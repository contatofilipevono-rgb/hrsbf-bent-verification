"""Energia Walsh conjunta por autocorrelação nos mesmos parâmetros afins."""
from collections import Counter
from ctypes import c_int
from functools import reduce
from math import gcd
from operator import xor
from pathlib import Path
import json

import numpy as np
from z3_fallback import P, Solver, api, assertion, ctx_delete, c_uint

HERE = Path(__file__).resolve().parent
pb_eq = api("mk_pbeq", P, P, c_uint, P, P, c_int)

def positions(word):
    while word:
        low = word & -word
        yield low.bit_length() - 1
        word ^= low

def add(vectors, mask):
    return reduce(xor, (vectors[i] for i in positions(mask)), 0)

def signed_value(row, lift):
    return sum(c * (1 - 2 * ((m & lift).bit_count() & 1)) for m,c in row.items())

def orbit(t):
    return {(t << k | t >> (8 - k)) & 255 for k in range(8)}

REPS = [t for t in range(1, 256) if t == min(orbit(t))]
UNITS = [1 << i for i in range(8)]

def functions(tables, polar):
    z_tables = [add(column[:48], polar) for column in zip(*tables, strict=True)]
    affines = [column[48:] for column in zip(*tables, strict=True)]
    assert z_tables[0] == 0 and all(v == 0 for v in affines[0])
    signs = []
    for t in REPS:
        row = Counter()
        for z, table in enumerate(z_tables):
            phase = (table ^ (table >> t)) & 1
            if any((((table >> u) ^ (table >> (u ^ t))) & 1) != phase for u in UNITS):
                continue
            mask = sum(((g ^ (g >> t)) & 1) << j for j, g in enumerate(affines[z]))
            row[mask] += 1 - 2 * phase
        signs.append((t, {m: c for m, c in row.items() if c}))
    return z_tables, affines, signs

def independent_fwht(z_tables, affines, lift, signs):
    a = np.array([[1 - 2 * ((v >> u) & 1) for u in range(256)]
                  for v in (g ^ add(vec, lift) for g,vec in zip(z_tables,affines,strict=True))])
    def transform(x):
        for i in range(8):
            h = 1 << i
            q = x.reshape(-1, 2*h)
            left = q[:, :h].copy()
            right = q[:, h:].copy()
            q[:, :h] = left + right
            q[:, h:] = left - right
        return x
    energy = np.sum(transform(a)**2,axis=0)
    correlation = transform(energy.copy())
    assert all(correlation[t] == 65536 * signed_value(row, lift)
               for t,row in signs)
    assert len(REPS) == 35
    for t in REPS:
        assert all(energy[w] == energy[t] for w in orbit(t))
    return int(np.count_nonzero(energy != 65536)), int(energy[0])

def reduce_form(mask, basis):
    phase = 0
    for p in sorted(basis, reverse=True):
        if mask >> p & 1:
            row, value = basis[p]
            mask ^= row
            phase ^= value
    return mask, phase

def restrict(row, basis):
    new = Counter()
    for mask, weight in row.items():
        form, phase = reduce_form(mask, basis)
        new[form] += weight * (1 - 2 * phase)
    return {m:c for m,c in new.items() if c}

def precheck(signs):
    basis = {}
    while True:
        before = len(basis)
        reduced = []
        for t, original in signs:
            row = restrict(original, basis)
            if not row:
                continue
            divisor = gcd(*row.values())
            row = {m: c // divisor for m,c in row.items()}
            total = sum(row.values())
            if total % 2:
                return basis, [], ('paridade', hex(t), dict(row))
            target = total // 2
            variables = {m:w for m,w in row.items() if m}
            if not (sum(min(0,v) for v in variables.values()) <= target <=
                    sum(max(0,v) for v in variables.values())):
                return basis, [], ('intervalo', hex(t), dict(row))
            mask = reduce(xor, (m for m,w in variables.items() if w % 2), 0)
            if not mask and target % 2:
                return basis, [], ('paridade', hex(t), dict(row))
            if mask:
                basis[mask.bit_length()-1] = mask, target % 2
            reduced.append((variables,target))
        if len(basis) == before:
            return basis, reduced, None

def exact_solution(signs, seconds, fiber_check=None):
    basis, reduced, failure = precheck(signs)
    if failure:
        return 'excluido_' + failure[0], len(basis), failure, None
    if fiber_check is not None and (z := fiber_check()) is not None:
        return 'excluido_energia_w0', len(basis), hex(z), None
    solver = Solver()
    n = max((mask.bit_length() for _,row in signs for mask in row), default=0)
    forms = {}
    try:
        def literal(mask):
            if mask in forms:
                return forms[mask]
            terms = [i+1 for i in positions(mask)]
            if len(terms) == 1:
                return terms[0]
            out = n + len(forms) + 1
            solver.add_xor_clause([out, *terms], False)
            forms[mask] = out
            return out
        for row, value in basis.values():
            solver.add_xor_clause([i+1 for i in positions(row)], bool(value))
        for coefficients, target in reduced:
            lits = []
            weights = []
            for mask, val in coefficients.items():
                v = literal(mask)
                lits.append(solver.ast(v if val > 0 else -v))
                weights.append(abs(val))
                if val < 0:
                    target -= val
            if not lits:
                assert target == 0
                continue
            assertion(solver.context,solver.s,pb_eq(solver.context,len(lits),
                      (P*len(lits))(*lits),(c_int*len(lits))(*weights),target))
        if not solver.values:
            return 'sat', len(basis), None, 0
        sat, model = solver.solve(seconds)
        if sat is not True:
            return 'excluido_sat' if sat is False else 'timeout', len(basis), None, None
        lift = sum(1 << i for i in range(min(n, len(model)-1)) if model[i+1])
        assert all(signed_value(row, lift) == 0 for _,row in signs)
        return 'sat', len(basis), None, lift
    finally:
        ctx_delete(solver.context)

def impossible_fiber(z_tables, affines):
    """Certifica E(0)>65536 se uma fibra não nula é sempre desbalanceada."""
    for z in (1, 0x11, 0x33, 0x55, 0x77, 0xff):
        table = z_tables[z]
        always_zero = True
        for r in range(1,256):
            phase = (table ^ (table >> r)) & 1
            if any((((table >> u) ^ (table >> (u ^ r))) & 1) != phase for u in UNITS):
                continue
            if phase or any((g ^ (g >> r)) & 1 for g in affines[z]):
                always_zero = False
                break
        if always_zero:
            return z
    return None

def main():
    data = json.loads((HERE/'entrada.json').read_text())
    tables = [list(map(lambda v:int(v,16),row)) for row in data['tabelas']]
    # O emparelhamento antipodal invertível fornece controle positivo de grau dois.
    matching = [sum((((((z << 4) | (z >> 4)) & 255) & u).bit_count() & 1) << u
                    for u in range(256)) for z in range(256)]
    zt, at, signs = functions([[0]*256 for _ in range(48)] + [matching], 0)
    assert independent_fwht(zt,at,0,signs) == (256, 16777216)
    assert independent_fwht(zt,at,1,signs) == (0, 65536)
    assert exact_solution(signs, 1)[-1] == 1
    stats = {}
    for label in ('pfaffianos_peso3','controles_seis_e_residuos'):
        count = Counter()
        details = []
        for index,item in enumerate(data[label]):
            v = int(item,16)
            polar = v & ((1<<48)-1)
            zt, at, signs = functions(tables,polar)
            if label == 'controles_seis_e_residuos':
                lift = v >> 48
                assert all((zt[z] ^ add(at[z], lift)).bit_count() == 128
                           for z in (1, 0x11, 0x33, 0x55, 0x77, 0xff))
                sign_rows = dict(signs)
                assert signed_value(sign_rows[0x55], lift) % 4 == 0
                assert signed_value(sign_rows[0xff], lift) % 8 == 0
            if index < 4:
                independent_fwht(zt,at,v>>48,signs)
            status, rank, failure, model = exact_solution(
                signs, 0.05, lambda: impossible_fiber(zt, at))
            if model is not None:
                assert independent_fwht(zt, at, model, signs) == (0, 65536)
            count[status] += 1
            initial_odd = [hex(t) for t,row in signs if sum(row.values()) % 2]
            details.append(dict(polar=hex(polar),status=status,posto_afim=rank,
                                direcoes_com_paridade_impar=initial_odd,
                                falha=failure,levantamento=None if model is None else hex(model)))
        stats[label] = dict(contagens=count, detalhes=details)
        print(label,count,flush=True)
    (HERE/'resultado_certificado.json').write_text(json.dumps(stats,indent=2)+'\n')

if __name__ == '__main__':
    main()

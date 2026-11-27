"""Confere cada sobrevivente com um levantamento comum para os cortes."""
from collections import Counter
from itertools import combinations
import json
from pathlib import Path
import sys

here = Path(__file__).resolve().parent
sys.path.insert(0,str(here.parent/'h16-energia-conjunta'))
from conferir import (add, positions, functions, exact_solution, impossible_fiber,
                      independent_fwht, orbit, UNITS, signed_value)

ZS = (1,17,51,85,119,255)
T = (0x55,0xff)
MODS = (4,8)
PAIRS = list(combinations(range(8),2))
DATA = here.parent/'h16-energia-conjunta'/'entrada.json'
if (here/'entrada.json').is_file():
    DATA = here/'entrada.json'

def matrix_from_truth(d):
    c = d&1
    return sum((c ^ ((d>>a ^ d>>b ^ d>>(a|b))&1))<<k
               for k,(a,b) in enumerate(combinations(UNITS,2)))

def radical(m):
    rows = [0]*8
    for k in positions(m):
        i,j = PAIRS[k]
        rows[i] |= 1<<j
        rows[j] |= 1<<i
    piv = [0]*8
    for row in rows:
        while row:
            k = row.bit_length()-1
            if not piv[k]:
                piv[k] = row
                break
            row ^= piv[k]
    assert piv.count(0) >= 2
    if piv.count(0) != 2:
        return ()
    rad = []
    for k,row in enumerate(piv):
        if not row:
            w = 1<<k
            for i,r in enumerate(piv):
                w ^= ((w&r).bit_count()&1)<<i
            rad.append(w)
    return tuple(rad)

def verify_pfaffians(zt):
    values = []
    for z,table in enumerate(zt):
        r = radical(matrix_from_truth(table))
        value = 0
        if r:
            a,b = r
            assert z in (a,b,a^b)
            for k,(i,j) in enumerate(PAIRS):
                value |= (((a>>i)&(b>>j)&1) ^ ((a>>j)&(b>>i)&1))<<k
        values.append(value)
    for u in UNITS:
        for z in range(256):
            if z&u:
                values[z] ^= values[z^u]
    return all(not v for z,v in enumerate(values) if z.bit_count()>4)

def joint_quotient(tables):
    piv = {}
    values = []
    for j,row in enumerate(tables[48:]):
        value = sum(row[z]<<(256*i) for i,z in enumerate(ZS))
        while value:
            k = value.bit_length()-1
            if k not in piv:
                piv[k] = value
                values.append(tuple(row[z] for z in ZS)+(1<<j,))
                break
            value ^= piv[k]
    assert len(values) == 13
    domain = [(0,)*7]
    for row in values:
        domain += [tuple(a^b for a,b in zip(r,row,strict=True)) for r in domain]
    assert len(set(domain)) == 8192
    return domain

def ac_flags(z, base):
    directions = []
    for t, modulo in zip(T,MODS,strict=True):
        active = []
        for j in range(len(orbit(z))):
            k = (8-j)%8
            v = ((t<<k)|(t>>(8-k)))&255
            p = (base^(base>>v))&1
            if all((((base>>u)^(base>>(u^v))^p)&1)==0 for u in UNITS):
                active.append(v)
        directions.append((modulo, active))
    return directions

def local_score(table, flags):
    return tuple(sum(1-2*((table^(table>>v))&1) for v in active)%mod
                 for mod,active in flags)

def scan_short(zt, domain):
    caches = [{} for _ in ZS]
    cases = [ac_flags(z,zt[z]) for z in ZS]
    first_six = None
    first_signed = None
    order=(0,5,2,3,1,4)
    for values in domain:
        for j in order:
            z = ZS[j]
            d = zt[z]^values[j]
            if d.bit_count()!=128:
                break
        else:
            if first_six is None:
                first_six=values[-1]
            scores = []
            for j,z in enumerate(ZS):
                d=zt[z]^values[j]
                cache=caches[j]
                if d not in cache:
                    cache[d] = local_score(d,cases[j])
                scores.append(cache[d])
            if all((1+sum(v[i] for v in scores))%mod==0 for i,mod in enumerate(MODS)):
                first_signed=values[-1]
                break
    return first_six,first_signed

def main():
    data = json.loads(DATA.read_text())
    tables = [[int(v,16) for v in row] for row in data['tabelas']]
    domain=joint_quotient(tables)
    counts=Counter()
    results=[]
    first = {}
    source=Path(sys.argv[1]) if len(sys.argv)>1 else here/'sobreviventes9.txt'
    for line in source.read_text().splitlines():
        polar=int(line,16)
        zt,af,signs=functions(tables,polar)
        assert verify_pfaffians(zt)
        six,signed=scan_short(zt,domain)
        for lift in [v for v in (six,signed) if v is not None]:
            assert all((zt[z]^add(af[z],lift)).bit_count()==128 for z in ZS)
        counts['pf_e_seis_projecoes']+=1
        counts['pf_e_seis_conjuntos']+=six is not None
        counts['pf_e_seis_e_residuos_conjuntos']+=signed is not None
        if signed is None:
            continue
        sign_rows=dict(signs)
        assert all(signed_value(sign_rows[t],signed)%mod==0 for t,mod in zip(T,MODS,strict=True))
        status,rank,failure,model=exact_solution(signs,0.5,lambda:impossible_fiber(zt,af))
        odd=[hex(t) for t,row in signs if sum(row.values())%2]
        counts[status]+=1
        counts['paridade_inicial_ok']+=not odd
        if model is not None:
            assert independent_fwht(zt,af,model,signs)==(0,65536)
        out=dict(polar=hex(polar),peso=polar.bit_count(),levantamento_curto=hex(signed),
                 posto_afim=rank,falha=failure,status=status,paridades_impares=odd,
                 modelo=None if model is None else hex(model))
        results.append(out)
        if status not in first:
            print(out,flush=True)
            first[status] = out
            independent_fwht(zt,af,signed,signs)
    (here/'levantamentos.json').write_text(json.dumps(dict(contagens=counts,casos=results),indent=2)+'\n')
    print(counts,flush=True)

if __name__=='__main__':main()

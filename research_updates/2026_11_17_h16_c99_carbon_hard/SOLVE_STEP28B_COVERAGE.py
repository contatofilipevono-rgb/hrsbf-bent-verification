import json
import random
from fractions import Fraction
from itertools import product
from pathlib import Path

import SOLVE_STEP27B_GROEBNER_F4_PROBE as step

def audit(cell, polynomials, w_idx, r_idx):
    rows = []
    rhs = 1 << len(r_idx)
    for poly in polynomials:
        terms = []
        for monomial in poly:
            w = 0
            r = rhs
            mask = monomial
            while mask:
                bit = mask & -mask
                var = bit.bit_length() - 1
                mask ^= bit
                if var in w_idx:
                    w |= 1 << w_idx[var]
                else:
                    assert var in r_idx and r == rhs, (var, monomial)
                    r = 1 << r_idx[var]
            terms.append((w, r))
        rows.append(terms)
    Path(f"step28_{cell}_eta0_linear_r.json").write_text(
        json.dumps({"nW": len(w_idx), "nR": len(r_idx), "rows": rows}),
        encoding="utf-8",
    )
    n_w = len(w_idx)
    rng = random.Random(191127)

    def row_values(w):
        result = []
        for row in rows:
            value = 0
            for monomial, r in row:
                if w & monomial == monomial:
                    value ^= r
            result.append(value)
        return result

    def witness(values, order):
        pivots = {}
        for i in order:
            v, proof = values[i], 1 << i
            while v & (rhs - 1):
                bit = (v & -v).bit_length() - 1
                if bit not in pivots:
                    pivots[bit] = (v, proof)
                    break
                old, old_proof = pivots[bit]
                v, proof = v ^ old, proof ^ old_proof
            else:
                if v == rhs:
                    return proof
        return 0

    def gate(proof):
        polynomials = [set() for _ in range(len(r_idx) + 1)]
        for i, row in enumerate(rows):
            if proof >> i & 1:
                for w, r in row:
                    polynomials[r.bit_length() - 1].symmetric_difference_update((w,))
        return polynomials

    def affine_bound(polynomials):
        polys = [p.copy() for p in polynomials]
        polys[-1].symmetric_difference_update((0,))
        mons = sorted(set().union(*polys), key=lambda m: (m.bit_count(), m))
        ind = {m: j for j, m in enumerate(mons)}
        pivots = {}
        for p in polys:
            value = sum(1 << ind[m] for m in p)
            while value:
                j = value.bit_length() - 1
                if j not in pivots:
                    pivots[j] = value
                    break
                value ^= pivots[j]
        assert all(mons[j] != 0 for j in pivots)
        return len(pivots), sum(mons[j].bit_count() == 1 for j in pivots)

    points = [0] + [rng.getrandbits(n_w) for _ in range(10)]
    selection = list(range(len(rows)))
    gates = {}
    for x in points:
        selection.sort()
        values = row_values(x)
        local = []
        for j in range(24):
            if j:
                rng.shuffle(selection)
            proof = witness(values, selection)
            if proof == 0:
                print("CONSISTENT_FIBER", x, flush=True)
                return
            polys = gate(proof)
            k_all, k_lin = affine_bound(polys)
            local.append((k_lin, k_all, proof.bit_count(), proof))
        k_lin, k_all, support, proof = min(local)
        gates[proof] = k_lin
        print(f"w={x:012x} support={support} constraints={k_all} affine_rank={k_lin}", flush=True)
    upper_bound = sum((Fraction(1, 1 << v) for v in gates.values()), Fraction())
    print(f"gates={len(gates)} rigorous_union_upper={upper_bound}", flush=True)
    print(f"nW={n_w} nR={len(r_idx)} nrows={len(rows)}", flush=True)
    Path(f"step28_{cell}_eta0_witnesses.json").write_text(
        json.dumps({"witnesses": [[hex(v), rank] for v, rank in gates.items()],
                    "union_upper_bound": str(upper_bound)}),
        encoding="utf-8",
    )
    if upper_bound < 1:
        print("UNCOVERED: affine-rank union bound below one", flush=True)
        return

    def multiply(a, b):
        # A degree bound alone does not limit transient ANF memory.
        if len(a) * len(b) > 1_000_000:
            raise OverflowError
        out = set()
        for x, y in product(a, b):
            out.symmetric_difference_update((x | y,))
        return out

    residual = {0}
    try:
        for proof in gates:
            *coefficients, constant = gate(proof)
            indicator = constant.copy()
            for coefficient in sorted(coefficients, key=len):
                indicator = multiply(indicator, coefficient ^ {0})
            residual = multiply(residual, indicator ^ {0})
    except OverflowError:
        print("INCONCLUSIVE: ANF product cap reached", flush=True)
        return
    if not residual:
        print("UNSAT: witness indicators cover the entire eta=0 cube", flush=True)
        return
    w = min(residual, key=lambda m: (m.bit_count(), m))
    assert sum(w & m == m for m in residual) % 2 == 1
    print(f"UNCOVERED: exact residual has {len(residual)} terms; w={w:012x}", flush=True)



if __name__ == "__main__":
    step.main(probe=audit)

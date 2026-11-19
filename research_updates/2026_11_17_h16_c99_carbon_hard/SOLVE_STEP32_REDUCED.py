"""Extract and test the exact reduced linear-in-R_free system after tail substitution."""

import json
import random
import time
from pathlib import Path

import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as step
from SOLVE_STEP28B_COVERAGE import audit


def multiply(left, right):
    result = set()
    for u in left:
        for v in right:
            result.symmetric_difference_update((u | v,))
    return result


def evaluate(poly, point):
    return sum((point & term) == term for term in poly) & 1


def reduce_tails(quads, w_mask, t_mask):
    basis = {}
    for quad in quads:
        support = set(quad)
        mask = 0
        for m in support:
            if m & t_mask:
                assert m == (m & t_mask) and m.bit_count() == 1
                mask ^= m
            else:
                assert not m & ~w_mask and m.bit_count() <= 2
        while mask:
            lead = mask & -mask
            if lead not in basis:
                basis[lead] = (mask, support)
                break
            prior_mask, prior_support = basis[lead]
            mask ^= prior_mask
            support ^= prior_support
        else:
            assert not support, "a tail row produced a separate pure-W constraint"
    assert sum(basis) == t_mask
    expressions = {}
    for bit, (mask, poly) in sorted(basis.items(), reverse=True):
        rest = set(m for m in poly if not m & t_mask)
        for other_bit, expression in expressions.items():
            if mask & other_bit:
                rest ^= expression
        expressions[bit] = rest
    return expressions


def substitute(poly, tails):
    result = set()
    for m in poly:
        terms = {m & ~sum(tails)}
        for bit, expr in tails.items():
            if m & bit:
                terms = multiply(terms, expr)
        result ^= terms
    return result


def constant_combination(polynomials, target={0}):
    vectors = {}
    for i, p in enumerate(polynomials):
        value = p.copy()
        combo = 1 << i
        while value:
            lead = max(value)
            if lead not in vectors:
                vectors[lead] = (value, combo)
                break
            v, c = vectors[lead]
            value ^= v
            combo ^= c
    value = target.copy()
    combo = 0
    while value:
        lead = max(value)
        if lead not in vectors:
            return 0
        v, c = vectors[lead]
        value ^= v
        combo ^= c
    return combo


def pivot_units(polynomials, r_mask, seconds=60):
    """Gauss elimination with unit pivots, using squarefree polynomial row operations."""
    rows = []
    for poly in polynomials:
        items = {}
        for monomial in poly:
            column = monomial & r_mask
            items.setdefault(column, set()).add(monomial ^ column)
        rows.append(items)
    active = list(range(len(rows)))
    pivot_trace = []
    deadline = time.monotonic() + seconds
    pair_budget = 6_000_000
    while time.monotonic() < deadline:
        columns = sorted({c for j in active for c in rows[j] if c})
        pure = [j for j in active if all(c == 0 for c in rows[j])]
        contradiction = constant_combination([rows[j].get(0, set()) for j in pure])
        if contradiction:
            witnesses = [j for i, j in enumerate(pure) if contradiction >> i & 1]
            return "UNSAT", pivot_trace, witnesses, len(pure)

        units = [(sum(map(len, rows[j].values())), c, j)
                 for j in active for c in columns if rows[j].get(c) == {0}]
        combo_rows = []
        if units:
            _, col, pivot = min(units)
        else:
            for col in columns:
                combo = constant_combination([rows[j].get(col, set()) for j in active])
                if combo:
                    combo_rows = [j for i, j in enumerate(active) if combo >> i & 1]
                    break
            if not combo_rows:
                return "NO_UNIT", pivot_trace, [], len(pure)
            pivot = combo_rows[0]
            merged = {}
            for j in combo_rows:
                for c, poly in rows[j].items():
                    merged[c] = merged.get(c, set()) ^ poly
            rows[pivot] = {c: p for c, p in merged.items() if p}
        pivot_row = rows[pivot]
        assert pivot_row[col] == {0}
        pivot_trace.append({"pivot": pivot, "column": col, "combine": combo_rows})
        active.remove(pivot)
        for j in active:
            multiplier = rows[j].pop(col, None)
            if multiplier is None:
                continue
            for c, p in pivot_row.items():
                if c == col:
                    continue
                pair_budget -= len(p) * len(multiplier)
                if pair_budget < 0:
                    return "PAIR_BUDGET", pivot_trace, [], len(pure)
                value = rows[j].get(c, set()) ^ multiply(p, multiplier)
                if value:
                    rows[j][c] = value
                else:
                    rows[j].pop(c, None)
    return "TIME_BUDGET", pivot_trace, [], 0


def analyze(cell, quads, before, w_idx, t_idx, r_idx):
    w_mask = sum(1 << i for i in w_idx)
    t_mask = sum(1 << i for i in t_idx)
    r_mask = sum(1 << i for i in r_idx)
    tails = reduce_tails(quads, w_mask, t_mask)
    after = [substitute(p, tails) for p in before]
    assert all(not m & ~(w_mask | r_mask) and (m & r_mask).bit_count() <= 1
               for row in after for m in row)
    rng = random.Random(3256)
    for _ in range(20):
        point = sum(rng.getrandbits(1) << i for i in list(w_idx) + list(r_idx))
        lifted = point | sum(evaluate(q, point) * bit for bit, q in tails.items())
        assert all(not evaluate(q, lifted) for q in quads)
        assert all(evaluate(x, lifted) == evaluate(y, point) for x, y in zip(before, after))
    sizes = (len(after), len(w_idx), len(t_idx), len(r_idx))
    degree_m = max(((m & w_mask).bit_count() for row in after for m in row if m & r_mask), default=0)
    degree_c = max((m.bit_count() for row in after for m in row if not m & r_mask), default=0)
    print(f"STEP32_BLOCK rows,W,T,R={sizes} deg_M={degree_m} deg_c={degree_c}", flush=True)
    status, trace, witnesses, pure = pivot_units(after, r_mask)
    print(f"STEP32_UNIT result={status} pivots={len(trace)} pure_W={pure}", flush=True)
    Path(f"step32_{cell}_unit.json").write_text(
        json.dumps({"dimensions": sizes, "degree_matrix": degree_m, "degree_rhs": degree_c,
                    "status": status, "trace": trace, "witness_rows": witnesses,
                    "w_idx": w_idx, "r_idx": r_idx, "rows": [sorted(p) for p in after]}),
        encoding="utf-8",
    )
    if status != "UNSAT":
        audit(cell, after, w_idx, r_idx)


if __name__ == "__main__":
    step.main(probe=analyze)

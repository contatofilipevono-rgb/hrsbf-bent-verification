"""Exact controls for ASTRA_AUDITORIA_A_MAIS_POSTO8_07NOV.md.

This does not enumerate the alleged 101 exceptional pencils.
"""
from itertools import combinations
from pathlib import Path
import json
import random
import time


def rank(vs):
    piv = {}
    for v in vs:
        while v:
            k = v.bit_length() - 1
            if k in piv:
                v ^= piv[k]
            else:
                piv[k] = v
                break
    return len(piv)


def nullspace(rows, n):
    rows = [v for v in rows if v]
    pivots = []
    r = 0
    for col in range(n):
        j = next((j for j in range(r, len(rows)) if rows[j] >> col & 1), None)
        if j is None:
            continue
        rows[r], rows[j] = rows[j], rows[r]
        for j in range(len(rows)):
            if j != r and rows[j] >> col & 1:
                rows[j] ^= rows[r]
        pivots.append(col)
        r += 1
    out = []
    for col in range(n):
        if col not in pivots:
            v = 1 << col
            for j, p in enumerate(pivots):
                if rows[j] >> col & 1:
                    v |= 1 << p
            out.append(v)
    return out


def pairing(rows, u, v):
    row = 0
    while u:
        bit = u & -u
        row ^= rows[bit.bit_length() - 1]
        u ^= bit
    return (row & v).bit_count() & 1


def restrict(rows, basis):
    return [sum(pairing(rows, u, v) << j for j, v in enumerate(basis)) for u in basis]


def lift(v, basis):
    out = 0
    for i, w in enumerate(basis):
        if v >> i & 1:
            out ^= w
    return out


def common_isotropic(A, B):
    n = len(A)
    if not n:
        return []
    v = nullspace(A, n)[0] if n & 1 else 1
    equations = [sum(pairing(F, v, 1 << j) << j for j in range(n)) for F in (A, B)]
    W = nullspace(equations, n)
    basis = [v]
    for w in W:
        if rank(basis + [w]) > len(basis):
            basis.append(w)
    complement = basis[1:]
    sub = common_isotropic(restrict(A, complement), restrict(B, complement))
    result = [v] + [lift(w, complement) for w in sub]
    assert len(result) >= (n + 1) // 2
    return result


def form(edges, n):
    rows = [0] * n
    for edge in edges:
        i, j = [i for i in range(n) if edge >> i & 1]
        rows[i] ^= 1 << j
        rows[j] ^= 1 << i
    return rows


def wedge(A, B):
    out = set()
    for a in A:
        for b in B:
            if a & b:
                continue
            m = a | b
            if m in out:
                out.remove(m)
            else:
                out.add(m)
    return out


def wedge_rank(images):
    ix = {m: i for i, m in enumerate(sorted(set().union(*images)))}
    return rank([sum(1 << ix[m] for m in im) for im in images])


def check_pair(A, B):
    n = len(A)
    U = common_isotropic(A, B)
    assert rank(U) == len(U)
    assert all(pairing(F, x, y) == 0 for F in (A, B) for x in U for y in U)
    H = U[:]
    extra = next((1 << i for i in range(n) if rank(H + [1 << i]) > len(H)), None)
    if extra is not None:
        H.append(extra)
    ar, br = restrict(A, H), restrict(B, H)
    for ids in combinations(range(len(H)), 4):
        val = 0
        for pair in combinations(ids, 2):
            other = [i for i in ids if i not in pair]
            val ^= (ar[pair[0]] >> pair[1] & 1) & (br[other[0]] >> other[1] & 1)
        assert not val
    assert n - len(H) <= max(0, n // 2 - 1)
    return H


def main():
    start = time.time()
    n = 4
    edges = [sum(1 << i for i in c) for c in combinations(range(n), 2)]
    forms = [form([e for i, e in enumerate(edges) if bits >> i & 1], n) for bits in range(1 << len(edges))]
    for A in forms:
        for B in forms:
            check_pair(A, B)
    rng = random.Random(20261107)
    for n in range(1, 21):
        edges = [sum(1 << i for i in c) for c in combinations(range(n), 2)]
        for _ in range(50):
            A = form([e for e in edges if rng.getrandbits(1)], n)
            B = form([e for e in edges if rng.getrandbits(1)], n)
            check_pair(A, B)
    gamma = {a | b | c for a, b, c in combinations([3 << (2 * i) for i in range(4)], 3)}
    gamma_results = []
    for n in range(8, 17):
        edges = [sum(1 << i for i in c) for c in combinations(range(n), 2)]
        r = wedge_rank([wedge(gamma, {e}) for e in edges])
        assert len(edges) - r == 27
        gamma_results.append(dict(n=n, domain=len(edges), rank=r, kernel=27))
    n = 12
    edges = [3 << (2 * i) for i in range(6)]
    A, B = set(edges[:4]), set(edges[2:])
    T = wedge(A, B)
    mons = [sum(1 << i for i in c) for c in combinations(range(n), 3)]
    ker = len(mons) - wedge_rank([wedge(T, {m}) for m in mons])
    span = wedge_rank([wedge(F, {1 << i}) for F in (A, B) for i in range(n)])
    assert [rank(form(F, n)) for F in (A, B, A ^ B)] == [8, 8, 8]
    assert ker == span == 24
    report = dict(
        scope="Constructive common-isotropic lemma, gamma3 kernel, one twelve-dimensional obstruction. No 101-class coverage.",
        all_pairs_dimension4=4096,
        seeded_pairs_dimensions1_to20=1000,
        gamma3_rank8=gamma_results,
        three_rank4_blocks=dict(n=12, ranks=[8, 8, 8], kernel=ker, span=span, K=True,
                               A_masks=sorted(A), B_masks=sorted(B),
                               minimum_cubic_flat_codimension=4,
                               codimension_claim="Proved in accompanying note; not a subspace enumeration."),
        seconds=time.time() - start,
    )
    path = Path(__file__).with_suffix('.json')
    path.write_text(json.dumps(report, indent=2), encoding='utf-8')
    print(json.dumps(report, indent=2))


if __name__ == '__main__':
    main()

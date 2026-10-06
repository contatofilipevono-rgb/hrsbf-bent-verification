"""Exact CPU verifier for the 7-dimensional same-parity quotient subspace in n=32.

This checker combines two exact necessary conditions for bentness over the full
affine family eta(c)=h:

(1) Antidiagonal fiber z=J=0xffff.
    If B_J=0, rotation invariance forces q_J(u)=f(u,u+J) to be constant,
    hence not balanced. The checker also confirms directly from the 155
    original orbit coordinates that all 16 radical functionals L_J(e_i)
    vanish modulo eta(c)=h.

(2) Diagonal autocorrelation.
    For fixed h and nonzero r,
        AC_f((r,r)) / 2^16 = sum_{z in rad(B_r)} (-1)^L_z(r).
    After imposing eta(c)=h, each L_z(r) is affine linear in the 120 free
    lift coordinates. If all nonconstant residual characters cancel and a
    nonzero constant remains, AC is nonzero for every lift in that family.

The seven eta coordinates are the cubic C_16 orbit classes whose
representatives have all indices of the same parity. There are 128 quotient
values in this subspace. The union of the two conditions below excludes all
128 exactly.

Everything is rebuilt from the 155 original cubic C_32 orbit coordinates.
Python >=3.10, standard library only; no GPU.
"""
from itertools import combinations
from functools import lru_cache
from pathlib import Path
from collections import Counter
import json, time

BASE = Path(__file__).resolve().parent
R_CANDIDATES = (0x0303, 0x0F0F, 0x3333)
PARITY_ETA_INDICES = (13, 15, 17, 19, 21, 30, 32)
J = 0xFFFF
EXPECTED_ANTIDIAGONAL_ONLY = {
    0x0, 0x2A8000, 0x1000A2000, 0x10020A000
}

def check(ok, msg):
    if not ok:
        raise RuntimeError(msg)

def cyclic_orbits(n):
    groups = {}
    for mon in combinations(range(n), 3):
        rep = min(tuple(sorted((v+k) % n for v in mon)) for k in range(n))
        groups.setdefault(rep, []).append(mon)
    return [tuple(groups[rep]) for rep in sorted(groups)]

def rank(rows):
    piv = {}
    for row in rows:
        while row:
            p = row.bit_length() - 1
            if p in piv:
                row ^= piv[p]
            else:
                piv[p] = row
                break
    return len(piv)

def kernel_basis(rows, n=16):
    rows = list(rows)
    pivots = []
    r = 0
    for col in range(n):
        pivot = next((j for j in range(r, n) if (rows[j] >> col) & 1), None)
        if pivot is None:
            continue
        rows[r], rows[pivot] = rows[pivot], rows[r]
        for j in range(n):
            if j != r and ((rows[j] >> col) & 1):
                rows[j] ^= rows[r]
        pivots.append(col)
        r += 1
    pset = set(pivots)
    out = []
    for free in range(n):
        if free in pset:
            continue
        v = 1 << free
        for j, col in enumerate(pivots):
            if (rows[j] >> free) & 1:
                v |= 1 << col
        out.append(v)
    return out

def span(basis):
    ans = [0]
    for b in basis:
        ans += [x ^ b for x in ans]
    return ans

def lift(u, z):
    return u | ((u ^ z) << 16)

def main():
    started = time.perf_counter()

    orbs16 = cyclic_orbits(16)
    orbs32 = cyclic_orbits(32)
    check(len(orbs16) == 35 and len(orbs32) == 155, "Wrong cubic orbit counts")
    check(all(len(o) == 16 for o in orbs16), "Short cubic orbit in n=16")
    check(all(len(o) == 32 for o in orbs32), "Short cubic orbit in n=32")

    lookup16 = {mon:j for j,o in enumerate(orbs16) for mon in o}
    tri32 = {}
    hrows = [0] * 35
    for j, orb in enumerate(orbs32):
        for mon in orb:
            tri32[sum(1 << x for x in mon)] = 1 << j
        reduced = tuple(sorted({x % 16 for x in orb[0]}))
        if len(reduced) == 3:
            hrows[lookup16[reduced]] |= 1 << j

    check(rank(hrows) == 35, "eta projection is not surjective")
    check(all(x.bit_count() == 4 for x in hrows),
          "Each eta coordinate must contain exactly four original lifts")

    @lru_cache(None)
    def value_row(x):
        active = [i for i in range(32) if (x >> i) & 1]
        ans = 0
        for a,b,c in combinations(active, 3):
            ans ^= tri32[(1 << a) | (1 << b) | (1 << c)]
        return ans

    def L_direct(r, z):
        return value_row(lift(r,z)) ^ value_row(lift(0,z))

    def L_polynomial(r):
        c0 = L_direct(r, 0)
        lin = [L_direct(r, 1 << i) ^ c0 for i in range(16)]
        quad = {}
        for i,j in combinations(range(16), 2):
            q = L_direct(r, (1 << i) | (1 << j)) ^ c0 ^ lin[i] ^ lin[j]
            if q:
                quad[(i,j)] = q
        return c0, lin, quad

    def L_eval(poly, z):
        c0, lin, quad = poly
        ans = c0
        idx = [i for i in range(16) if (z >> i) & 1]
        for i in idx:
            ans ^= lin[i]
        for i,j in combinations(idx, 2):
            ans ^= quad.get((i,j), 0)
        return ans

    Lpolys = {r:L_polynomial(r) for r in R_CANDIDATES}

    controls = (0, 1, 3, 0x1234, J)
    for r in R_CANDIDATES:
        for z in controls:
            check(L_eval(Lpolys[r], z) == L_direct(r, z),
                  "Quadratic L_z(r) reconstruction mismatch")

    def polar_matrices(h):
        mats = [[0] * 16 for _ in range(16)]
        for j, orb in enumerate(orbs16):
            if not ((h >> j) & 1):
                continue
            for a,b,c in orb:
                for z,i,k in ((a,b,c),(b,a,c),(c,a,b)):
                    mats[z][i] ^= 1 << k
                    mats[z][k] ^= 1 << i
        return mats

    def polar(mats, z):
        rows = [0] * 16
        for k in range(16):
            if (z >> k) & 1:
                for i in range(16):
                    rows[i] ^= mats[k][i]
        return rows

    def eta_pivots(h):
        piv = {}
        for j, row0 in enumerate(hrows):
            row = row0
            rhs = (h >> j) & 1
            for p in sorted(piv, reverse=True):
                if (row >> p) & 1:
                    rr, bb = piv[p]
                    row ^= rr
                    rhs ^= bb
            check(row != 0, "eta equations lost rank")
            piv[row.bit_length()-1] = (row, rhs)
        check(len(piv) == 35, "eta rank is not 35")
        return piv

    def reduce_eta(piv, row):
        const = 0
        for p in sorted(piv, reverse=True):
            if (row >> p) & 1:
                rr, b = piv[p]
                row ^= rr
                const ^= b
        return row, const

    def constant_autocorrelation_witness(h, r, poly):
        mats = polar_matrices(h)
        R = kernel_basis(polar(mats, r), 16)
        zs = span(R)
        piv = eta_pivots(h)
        signed = {}
        for z in zs:
            residual, const = reduce_eta(piv, L_eval(poly, z))
            signed[residual] = signed.get(residual, 0) + (-1 if const else 1)
        signed = {a:v for a,v in signed.items() if v}
        if set(signed) == {0} and signed[0] != 0:
            return {
                "r": hex(r),
                "radical_dimension": len(R),
                "normalized_autocorrelation": signed[0],
                "autocorrelation": signed[0] * (1 << 16),
            }
        return None

    hs = []
    for mask in range(1 << len(PARITY_ETA_INDICES)):
        h = 0
        for k,j in enumerate(PARITY_ETA_INDICES):
            if (mask >> k) & 1:
                h |= 1 << j
        hs.append(h)
    check(len(set(hs)) == 128, "Parity quotient subspace is not 7-dimensional")

    antidiagonal = set()
    diagonal = {}
    for h in hs:
        mats = polar_matrices(h)
        if not any(polar(mats, J)):
            piv = eta_pivots(h)
            # Direct original-ANF audit: q_J is affine when B_J=0, and all
            # its linear derivatives vanish throughout the eta-fiber.
            for i in range(16):
                residual, const = reduce_eta(piv, L_direct(1 << i, J))
                check(residual == 0 and const == 0,
                      "Antidiagonal affine fiber is not constant")
            antidiagonal.add(h)

        if h != 0:
            for r in R_CANDIDATES:
                found = constant_autocorrelation_witness(h, r, Lpolys[r])
                if found:
                    diagonal[h] = found
                    break

    A, D = antidiagonal, set(diagonal)
    union = A | D
    antidiagonal_only = A - D
    diagonal_only = D - A
    overlap = A & D

    check(len(A) == 32, f"Expected 32 antidiagonal quotient values, got {len(A)}")
    check(len(D) == 124, f"Expected 124 diagonal-autocorrelation exclusions, got {len(D)}")
    check(len(overlap) == 28, f"Expected overlap 28, got {len(overlap)}")
    check(len(diagonal_only) == 96, f"Expected 96 diagonal-only exclusions, got {len(diagonal_only)}")
    check(antidiagonal_only == EXPECTED_ANTIDIAGONAL_ONLY,
          "Unexpected antidiagonal-only quotient values")
    check(len(union) == 128 and set(hs) == union,
          "The combined certificate does not cover the full 7-dimensional subspace")

    type_counts = Counter(
        (w["r"], w["radical_dimension"], w["normalized_autocorrelation"])
        for w in diagonal.values()
    )

    report = {
        "status": "verified",
        "eta_subspace_dimension": 7,
        "eta_subspace_size": 128,
        "antidiagonal_zero_polar_quotients": len(A),
        "diagonal_autocorrelation_quotients": len(D),
        "overlap": len(overlap),
        "antidiagonal_only": len(antidiagonal_only),
        "diagonal_only": len(diagonal_only),
        "combined_excluded": len(union),
        "unresolved": 0,
        "antidiagonal_only_eta_hex": [hex(h) for h in sorted(antidiagonal_only)],
        "formerly_unresolved_now_antidiagonal": [
            "0x2a8000", "0x1000a2000", "0x10020a000"
        ],
        "family_dimension_per_quotient": 120,
        "directions_tested": [hex(r) for r in R_CANDIDATES],
        "witness_type_counts": {
            f"r={r},d={d},A/2^16={a}": n
            for (r,d,a),n in sorted(type_counts.items())
        },
        "identity": "AC_f((r,r)) = 2^16 * sum_{z in rad(B_r)} (-1)^{L_z(r)}",
        "antidiagonal_condition": "B_J=0 implies q_J is affine; rotation invariance forces it constant. Direct ANF reduction verifies all 16 linear derivatives vanish on every such eta-fiber.",
        "scope": "Closes all 128 quotient values in the 7-dimensional same-parity eta subspace. This still does not classify all 2^35 eta values and does not solve general n=32.",
        "seconds": round(time.perf_counter() - started, 3),
    }

    out = BASE / "resultado_subespaco_eta_paridade.json"
    out.write_text(json.dumps(report, indent=2), encoding="utf-8")
    print(json.dumps(report, indent=2))

if __name__ == "__main__":
    main()

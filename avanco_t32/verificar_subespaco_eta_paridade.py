"""Exact CPU verifier for the 7-dimensional same-parity quotient subspace in n=32.

The quotient eta(c) has 35 coordinates. We restrict eta to the seven cubic
rotation-symmetric orbit coordinates whose representatives in 16 variables
have all indices of the same parity. For each quotient h in this 7-dimensional
subspace, except h=0 handled by the antidiagonal zero-polar obstruction, we
test three diagonal autocorrelation directions r.

For fixed h and r:
    AC_f((r,r)) / 2^16 = sum_{z in rad(B_r)} (-1)^L_z(r),
where L_z(r)=f_c(r,r+z)+f_c(0,z).

Under eta(c)=h, each L_z(r) is an affine linear form in the 120 free lift
coordinates. Grouping equal residual linear forms gives a signed character
distribution. If every nonzero residual character cancels and only the
constant coefficient remains nonzero, the autocorrelation is the same
nonzero integer for every one of the 2^120 lifts. That excludes the entire
affine family from bentness.

Everything is recomputed from the 155 original cubic C_32 orbit coordinates.
Python >= 3.10, standard library only; no GPU.
"""
from itertools import combinations
from functools import lru_cache
from pathlib import Path
from collections import Counter
import json, time

BASE = Path(__file__).resolve().parent
R_CANDIDATES = (0x0303, 0x0F0F, 0x3333)
PARITY_ETA_INDICES = (13, 15, 17, 19, 21, 30, 32)
EXPECTED_UNRESOLVED = {0x2A8000, 0x1000A2000, 0x10020A000}

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

    # L_z(r) is quadratic in z. Reconstruct it from 137 exact evaluations
    # so all subsequent 2^d radical evaluations are cheap.
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

    # Independent positive controls for the quadratic reconstruction.
    controls = (0, 1, 3, 0x1234, 0xFFFF)
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

    # Canonical elimination of the 35 quotient equations eta(c)=h.
    # The residual row is a linear form on the 120-dimensional kernel.
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

    witnesses = {}
    unresolved = []
    for h in hs:
        if h == 0:
            continue
        found = None
        for r in R_CANDIDATES:
            found = constant_autocorrelation_witness(h, r, Lpolys[r])
            if found:
                break
        if found:
            witnesses[h] = found
        else:
            unresolved.append(h)

    check(len(witnesses) == 124, f"Expected 124 diagonal exclusions, got {len(witnesses)}")
    check(set(unresolved) == EXPECTED_UNRESOLVED,
          "Unexpected unresolved quotient masks in parity subspace")

    type_counts = Counter(
        (w["r"], w["radical_dimension"], w["normalized_autocorrelation"])
        for w in witnesses.values()
    )

    report = {
        "status": "verified",
        "eta_subspace_dimension": 7,
        "eta_subspace_size": 128,
        "zero_quotient_excluded_by_antidiagonal_obstruction": 1,
        "nonzero_quotients_excluded_by_constant_diagonal_autocorrelation": 124,
        "total_excluded_in_subspace": 125,
        "unresolved_in_subspace": len(unresolved),
        "unresolved_eta_hex": [hex(h) for h in unresolved],
        "unresolved_7bit_masks": [
            bin(sum(((h >> j) & 1) << k for k,j in enumerate(PARITY_ETA_INDICES)))
            for h in unresolved
        ],
        "family_dimension_per_quotient": 120,
        "directions_tested": [hex(r) for r in R_CANDIDATES],
        "witness_type_counts": {
            f"r={r},d={d},A/2^16={a}": n
            for (r,d,a),n in sorted(type_counts.items())
        },
        "identity": "AC_f((r,r)) = 2^16 * sum_{z in rad(B_r)} (-1)^{L_z(r)}",
        "certificate_condition": "After imposing eta(c)=h, all nonconstant residual characters in the radical sum cancel exactly and the remaining constant coefficient is nonzero.",
        "scope": "125/128 quotient values in the 7-dimensional same-parity eta subspace only. The three listed quotient values remain unresolved here. This does not solve all 2^35 quotient parameters or general n=32.",
        "seconds": round(time.perf_counter() - started, 3),
    }

    out = BASE / "resultado_subespaco_eta_paridade.json"
    out.write_text(json.dumps(report, indent=2), encoding="utf-8")
    print(json.dumps(report, indent=2))

if __name__ == "__main__":
    main()

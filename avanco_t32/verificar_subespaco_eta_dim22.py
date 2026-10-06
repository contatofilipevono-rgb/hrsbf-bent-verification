"""Exact CPU verifier for an explicit 22-dimensional eta subspace in n=32.

We consider cubic homogeneous rotation-symmetric Boolean functions in 32
variables, with 155 original cubic orbit coefficients c. The quotient
eta(c) in F_2^35 controls all quadratic polar parts of the fibers
q_z(u)=f_c(u,u+z); ker(eta) has dimension 120.

This verifier checks an explicit coordinate subspace H <= F_2^35 of
dimension 22 (4,194,304 quotient values). For every h in H it proves
non-bentness of every one of the 2^120 lifts eta(c)=h by the union of:

  (A) antidiagonal obstruction at J=0xffff:
      B_J=0, which forces the affine fiber q_J to be constant by rotation
      invariance and hence not balanced;

  (B) a constant nonzero diagonal-autocorrelation witness in one of seven
      directions r:
        AC_f((r,r)) / 2^16
          = sum_{z in rad(B_r)} (-1)^L_z(r),
      L_z(r)=f_c(r,r+z)+f_c(0,z).

For a fixed h and r, every L_z(r) is reduced modulo eta(c)=h into an affine
linear form on the 120 free lift coordinates. Equal residual characters are
grouped exactly. If all nonconstant characters cancel and a nonzero constant
coefficient remains, AC_f((r,r)) is nonzero for every lift in that affine
family, excluding bentness.

The seven autocorrelation directions are:
  0x0101, 0x0505, 0x0303, 0x0f0f, 0x3333, 0x1111, 0x5555.

All algebra is exact over F_2 / integers, Python >=3.10 standard library only.
No GPU is required.
"""
from itertools import combinations
from collections import Counter
from pathlib import Path
import json, time

BASE = Path(__file__).resolve().parent

ETA_BASIS_INDICES = (
    13, 15, 17, 19, 21, 30, 32,
    1, 2, 5, 22, 33, 20, 11, 31, 8, 14, 27,
    0, 3, 4, 6,
)
EXPECTED_REPRESENTATIVES = (
    (0,2,4), (0,2,6), (0,2,8), (0,2,10), (0,2,12), (0,4,8), (0,4,10),
    (0,1,3), (0,1,4), (0,1,7), (0,2,13), (0,4,11), (0,2,11),
    (0,1,13), (0,4,9), (0,1,10), (0,2,5), (0,3,10),
    (0,1,2), (0,1,5), (0,1,6), (0,1,8),
)
J = 0xFFFF
R_DIRECTIONS = (0x0101, 0x0505, 0x0303, 0x0F0F, 0x3333, 0x1111, 0x5555)

EXPECTED_COUNTS = {
    "antidiagonal": 65536,
    "0x101": 1884208,
    "0x505": 1017336,
    "0x303": 585388,
    "0xf0f": 297134,
    "0x3333": 290956,
    "0x1111": 37082,
    "0x5555": 16664,
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

def gf2_rank(vectors):
    pivots = {}
    for v in vectors:
        while v:
            p = v.bit_length() - 1
            if p in pivots:
                v ^= pivots[p]
            else:
                pivots[p] = v
                break
    return len(pivots)

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
    out = [0]
    for b in basis:
        out += [x ^ b for x in out]
    return out

def pack_rows(rows):
    ans = 0
    for i, row in enumerate(rows):
        ans |= row << (16*i)
    return ans

def unpack_rows(packed):
    return [(packed >> (16*i)) & 0xFFFF for i in range(16)]

def main():
    started = time.perf_counter()

    orbs16 = cyclic_orbits(16)
    orbs32 = cyclic_orbits(32)
    check(len(orbs16) == 35, "Expected 35 cubic C16 orbits")
    check(len(orbs32) == 155, "Expected 155 cubic C32 orbits")
    check(all(len(o) == 16 for o in orbs16), "Unexpected short cubic C16 orbit")
    check(all(len(o) == 32 for o in orbs32), "Unexpected short cubic C32 orbit")

    reps = tuple(orbs16[j][0] for j in ETA_BASIS_INDICES)
    check(reps == EXPECTED_REPRESENTATIVES, "Eta-basis orbit ordering mismatch")
    check(len(set(ETA_BASIS_INDICES)) == 22, "Eta basis is not coordinate-independent")

    # eta rows: each cubic C16 quotient coordinate is the parity of four
    # original C32 lifts. The remaining 15 original coordinates are antipodal.
    lookup16 = {mon:j for j,o in enumerate(orbs16) for mon in o}
    hrows = [0] * 35
    for j, orb in enumerate(orbs32):
        reduced = tuple(sorted({x % 16 for x in orb[0]}))
        if len(reduced) == 3:
            hrows[lookup16[reduced]] |= 1 << j
    check(all(row.bit_count() == 4 for row in hrows),
          "Each eta coordinate must contain exactly four lifts")
    check(gf2_rank(hrows) == 35, "eta projection must have rank 35")

    # Choose one pivot original coefficient in each disjoint eta group.
    # Any original linear form row(c) is reduced uniquely to
    # residual(free_120) + <quotient_mask, eta(c)>.
    pivot_bits = []
    free_mask = (1 << 155) - 1
    for row in hrows:
        p = (row & -row).bit_length() - 1
        pivot_bits.append(p)
        free_mask &= ~(1 << p)
    check(free_mask.bit_count() == 120, "Expected 120 free lift coordinates")

    def reduce_eta_symbolic(row):
        quotient_mask = 0
        for j, p in enumerate(pivot_bits):
            if (row >> p) & 1:
                row ^= hrows[j]
                quotient_mask ^= 1 << j
        check((row & ~free_mask) == 0, "Eta reduction left a pivot variable")
        return row, quotient_mask

    # Polar tensors of the 35 cubic C16 orbit coordinates.
    polar_basis = []
    for orb in orbs16:
        mats = [[0] * 16 for _ in range(16)]
        for a,b,c in orb:
            for z,i,k in ((a,b,c),(b,a,c),(c,a,b)):
                mats[z][i] ^= 1 << k
                mats[z][k] ^= 1 << i
        polar_basis.append(mats)

    def polar_rows_for_eta_coordinate(j, r):
        rows = [0] * 16
        mats = polar_basis[j]
        for k in range(16):
            if (r >> k) & 1:
                for i in range(16):
                    rows[i] ^= mats[k][i]
        return rows

    # Original C32 monomial patterns, used to reconstruct L_z(r) directly
    # from the 155 original orbit coordinates, without importing a search file.
    orb_patterns = []
    for orb in orbs32:
        pats = []
        for mon in orb:
            lower = tuple(i for i in mon if i < 16)
            upper = tuple(i-16 for i in mon if i >= 16)
            pats.append((lower, upper))
        orb_patterns.append(pats)

    def L_polynomial(r):
        # Vector-valued quadratic polynomial in z; each coefficient is a
        # 155-bit linear form in the original orbit coefficients c.
        coeff = {}
        for j, pats in enumerate(orb_patterns):
            orbit_bit = 1 << j
            for lower, upper in pats:
                # f(r,r+z) contribution.
                if all((r >> i) & 1 for i in lower):
                    terms = {0}
                    for i in upper:
                        nxt = set()
                        for tm in terms:
                            ztm = tm | (1 << i)
                            if ztm in nxt: nxt.remove(ztm)
                            else: nxt.add(ztm)
                            if (r >> i) & 1:
                                if tm in nxt: nxt.remove(tm)
                                else: nxt.add(tm)
                        terms = nxt
                    for tm in terms:
                        coeff[tm] = coeff.get(tm, 0) ^ orbit_bit
                # f(0,z) contribution.
                if not lower:
                    tm = 0
                    for i in upper:
                        tm |= 1 << i
                    coeff[tm] = coeff.get(tm, 0) ^ orbit_bit

        coeff = {tm:row for tm,row in coeff.items() if row}
        check(all(tm.bit_count() <= 2 for tm in coeff),
              "L_z(r) unexpectedly has degree > 2 in z")
        c0 = coeff.get(0, 0)
        lin = tuple(coeff.get(1 << i, 0) for i in range(16))
        quad = {
            (i,j): coeff[(1 << i) | (1 << j)]
            for i,j in combinations(range(16), 2)
            if ((1 << i) | (1 << j)) in coeff
        }
        return c0, lin, quad

    def precompute_L_symbolic(r):
        c0, lin, quad = L_polynomial(r)
        raw = [0] * 65536
        sym = [None] * 65536
        raw[0] = c0
        sym[0] = reduce_eta_symbolic(c0)
        for z in range(1, 65536):
            bit = z & -z
            i = bit.bit_length() - 1
            prev = z ^ bit
            val = raw[prev] ^ lin[i]
            p = prev
            while p:
                b = p & -p
                j = b.bit_length() - 1
                p ^= b
                key = (j,i) if j < i else (i,j)
                val ^= quad.get(key, 0)
            raw[z] = val
            sym[z] = reduce_eta_symbolic(val)
        return sym

    Lsym = {r: precompute_L_symbolic(r) for r in R_DIRECTIONS}

    # Packed contraction matrices for Gray-code updates over the 22-dimensional
    # quotient subspace. One basis toggle updates every matrix by one XOR.
    all_dirs = (J,) + R_DIRECTIONS
    packed_contrib = {r:{} for r in all_dirs}
    for r in all_dirs:
        for j in ETA_BASIS_INDICES:
            packed_contrib[r][j] = pack_rows(polar_rows_for_eta_coordinate(j, r))

    from functools import lru_cache

    @lru_cache(maxsize=60000)
    def radical_basis_cached(r, packed_B):
        return tuple(kernel_basis(unpack_rows(packed_B), 16))

    def constant_nonzero_autocorrelation(h, r, packed_B):
        # Cache only a radical basis, not the whole span, to keep memory bounded.
        zs = span(radical_basis_cached(r, packed_B))
        signed = {}
        for z in zs:
            residual, quotient_mask = Lsym[r][z]
            const = (quotient_mask & h).bit_count() & 1
            signed[residual] = signed.get(residual, 0) + (-1 if const else 1)

        nonzero = [(row, value) for row, value in signed.items() if value]
        return len(nonzero) == 1 and nonzero[0][0] == 0 and nonzero[0][1] != 0

    counts = Counter()
    h = 0
    previous_gray = 0
    packed_B = {r:0 for r in all_dirs}
    checked = 0

    for k in range(1 << 22):
        # Bound cache memory on long CPU runs without changing any arithmetic.
        if k and k % 100000 == 0:
            radical_basis_cached.cache_clear()
        gray = k ^ (k >> 1)
        if k:
            toggled = (gray ^ previous_gray).bit_length() - 1
            eta_index = ETA_BASIS_INDICES[toggled]
            h ^= 1 << eta_index
            for r in all_dirs:
                packed_B[r] ^= packed_contrib[r][eta_index]
        previous_gray = gray

        if packed_B[J] == 0:
            counts["antidiagonal"] += 1
            checked += 1
            continue

        found = False
        for r in R_DIRECTIONS:
            if constant_nonzero_autocorrelation(h, r, packed_B[r]):
                counts[hex(r)] += 1
                found = True
                break
        check(found, f"No obstruction found for eta={hex(h)}")
        checked += 1

    check(checked == 1 << 22, "Incomplete quotient enumeration")
    check(dict(counts) == EXPECTED_COUNTS, f"Witness count regression: {dict(counts)}")
    check(sum(counts.values()) == 1 << 22, "Coverage is not complete")

    result = {
        "status": "verified",
        "eta_subspace_dimension": 22,
        "eta_subspace_size": 1 << 22,
        "eta_basis_indices": list(ETA_BASIS_INDICES),
        "eta_basis_representatives": [list(x) for x in EXPECTED_REPRESENTATIVES],
        "kernel_eta_dimension": 120,
        "preimage_dimension_in_F2_155": 142,
        "excluded_original_coefficient_vectors": str(1 << 142),
        "excluded_nonzero_homogeneous_cubic_functions": str((1 << 142) - 1),
        "directions": [hex(r) for r in R_DIRECTIONS],
        "first_witness_counts": dict(counts),
        "unresolved_quotients_in_subspace": 0,
        "identity": "AC_f((r,r)) = 2^16 * sum_{z in rad(B_r)} (-1)^{L_z(r)}",
        "scope": "Complete exclusion of this explicit 22-dimensional eta subspace only. No claim that it is maximal; the full eta space has dimension 35 and general n=32 remains open.",
        "seconds": round(time.perf_counter() - started, 3),
    }

    out = BASE / "resultado_subespaco_eta_dim22.json"
    out.write_text(json.dumps(result, indent=2), encoding="utf-8")
    print(json.dumps(result, indent=2))

if __name__ == "__main__":
    main()

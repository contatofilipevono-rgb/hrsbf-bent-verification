"""Exact CPU verifier for the 24 sparse quotient classes left open by the
rank-14 fiber search in n=32.

For each fixed quotient h=eta(c), a nonzero diagonal direction (r,r) is given.
The diagonal autocorrelation identity is

    AC_f((r,r)) = 2^16 * sum_{z in rad(B_r)} (-1)^L_z(r),

where B_r=T_h(r,.,.) and L_z(r)=f_c(r,r+z)+f_c(0,z).
The verifier proves that every L_z(r) is already determined by eta(c)=h
(no dependence on the 120 free lift coordinates), and that the resulting
weight is not half of |rad(B_r)|. Hence AC is nonzero for every c in that
affine family, so no member can be bent.

Python >=3.10, standard library only. No GPU and no search engine required.
"""
from itertools import combinations
from functools import lru_cache
from pathlib import Path
import json, time

BASE = Path(__file__).resolve().parent

WITNESSES = {
    0x2000:       (0x3333, 4,   6),
    0x8000:       (0x0F0F, 4,   6),
    0x20000:      (0x3333, 8, 120),
    0x80000:      (0x3333, 8, 120),
    0x200000:     (0x0F0F, 4,   6),
    0x100000000:  (0x3333, 4,   6),
    0xA000:       (0x0F0F, 8, 120),
    0x22000:      (0x0303, 4,   6),
    0x82000:      (0x0303, 4,   6),
    0x202000:     (0x0F0F, 8, 120),
    0x40002000:   (0x0303, 4,   6),
    0x28000:      (0x0303, 4,   6),
    0x88000:      (0x0303, 4,   6),
    0x40008000:   (0x0303, 4,   6),
    0x100008000:  (0x0F0F, 8, 120),
    0x220000:     (0x0303, 4,   6),
    0x40020000:   (0x0F0F, 8, 120),
    0x100020000:  (0x0303, 4,   6),
    0x280000:     (0x0303, 4,   6),
    0x40080000:   (0x0F0F, 8, 120),
    0x100080000:  (0x0303, 4,   6),
    0x40200000:   (0x0303, 4,   6),
    0x100200000:  (0x0F0F, 8, 120),
    0x140000000:  (0x0303, 4,   6),
}

EXPECTED_REMAINING = {
    0x2000,0x8000,0x20000,0x80000,0x200000,0x100000000,
    0xA000,0x22000,0x82000,0x202000,0x40002000,0x28000,
    0x88000,0x40008000,0x100008000,0x220000,0x40020000,
    0x100020000,0x280000,0x40080000,0x100080000,0x40200000,
    0x100200000,0x140000000,
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
            p = row.bit_length()-1
            if p in piv:
                row ^= piv[p]
            else:
                piv[p] = row
                break
    return len(piv)

def add_equation(piv, row, rhs):
    for p in sorted(piv, reverse=True):
        if row >> p & 1:
            r, b = piv[p]
            row ^= r
            rhs ^= b
    if not row:
        return rhs == 0
    p = row.bit_length()-1
    piv[p] = (row, rhs)
    return True

def reduce_form(piv, row):
    const = 0
    for p in sorted(piv, reverse=True):
        if row >> p & 1:
            r, b = piv[p]
            row ^= r
            const ^= b
    return row, const

def kernel_basis(rows, n=16):
    rows = list(rows)
    pivots = []
    r = 0
    for col in range(n):
        pivot = next((j for j in range(r, n) if rows[j] >> col & 1), None)
        if pivot is None:
            continue
        rows[r], rows[pivot] = rows[pivot], rows[r]
        for j in range(n):
            if j != r and (rows[j] >> col & 1):
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
            if rows[j] >> free & 1:
                v |= 1 << col
        out.append(v)
    return out

def span(basis):
    ans = [0]
    for b in basis:
        ans += [x ^ b for x in ans]
    return ans

def polar_matrices(h, orbs16):
    mats = [[0]*16 for _ in range(16)]
    for j, orb in enumerate(orbs16):
        if not (h >> j) & 1:
            continue
        for a,b,c in orb:
            for z,i,k in ((a,b,c),(b,a,c),(c,a,b)):
                mats[z][i] ^= 1 << k
                mats[z][k] ^= 1 << i
    return mats

def polar(mats, z):
    rows = [0]*16
    for k in range(16):
        if z >> k & 1:
            for i in range(16):
                rows[i] ^= mats[k][i]
    return rows

def lift(u, z):
    return u | ((u ^ z) << 16)

def main():
    started = time.perf_counter()
    check(set(WITNESSES) == EXPECTED_REMAINING, 'Witness set is not the exact previous remainder')

    orbs16 = cyclic_orbits(16)
    orbs32 = cyclic_orbits(32)
    check(len(orbs16) == 35 and len(orbs32) == 155, 'Wrong cubic orbit counts')
    check(all(len(o) == 16 for o in orbs16), 'Short cubic orbit in n=16')
    check(all(len(o) == 32 for o in orbs32), 'Short cubic orbit in n=32')

    lookup16 = {mon:j for j,o in enumerate(orbs16) for mon in o}
    hrows = [0]*35
    tri32 = {}
    for j,o in enumerate(orbs32):
        for mon in o:
            tri32[sum(1 << x for x in mon)] = 1 << j
        reduced = tuple(sorted({x % 16 for x in o[0]}))
        if len(reduced) == 3:
            hrows[lookup16[reduced]] |= 1 << j
    check(all(x.bit_count() == 4 for x in hrows), 'Each eta coordinate must have four lifts')
    check(rank(hrows) == 35, 'eta projection is not surjective')

    @lru_cache(None)
    def values(x):
        active = [i for i in range(32) if x >> i & 1]
        ans = 0
        for a,b,c in combinations(active, 3):
            ans ^= tri32[(1 << a) | (1 << b) | (1 << c)]
        return ans

    details = []
    for h in sorted(WITNESSES):
        r, expected_dim, expected_ones = WITNESSES[h]
        check(r != 0, 'Autocorrelation direction must be nonzero')

        eta_system = {}
        for j,row in enumerate(hrows):
            check(add_equation(eta_system, row, (h >> j) & 1), 'Inconsistent eta equations')
        check(len(eta_system) == 35, 'eta system lost rank')

        mats = polar_matrices(h, orbs16)
        B = polar(mats, r)
        radical_basis = kernel_basis(B, 16)
        d = len(radical_basis)
        check(d == expected_dim, f'Wrong radical dimension for h={hex(h)}')
        check(all((row & r).bit_count() % 2 == 0 for row in B), 'r is not in rad(B_r)')

        zs = span(radical_basis)
        check(len(zs) == 1 << d, 'Radical span size mismatch')
        bits = []
        for z in zs:
            row = values(lift(r,z)) ^ values(lift(0,z))
            remainder, fixed_value = reduce_form(eta_system, row)
            check(remainder == 0, f'L_z(r) still depends on free lift coordinates for h={hex(h)}')
            bits.append(fixed_value)
        check(bits[0] == 0, 'L_0(r) must vanish')

        ones = sum(bits)
        target = 1 << (d-1)
        ac = (1 << 16) * ((1 << d) - 2*ones)
        check(ones == expected_ones, f'Unexpected fixed derivative weight for h={hex(h)}')
        check(ones != target and ac != 0, f'Witness does not obstruct bentness for h={hex(h)}')
        details.append({
            'h': hex(h), 'r': hex(r), 'radical_dimension': d,
            'radical_size': 1 << d, 'ones_in_L_vector': ones,
            'required_for_bent': target, 'autocorrelation': ac,
            'free_lift_dependence_rank': 0,
        })

    counts = {}
    for item in details:
        key = f"d{item['radical_dimension']}_w{item['ones_in_L_vector']}"
        counts[key] = counts.get(key, 0) + 1

    result = {
        'status': 'verified',
        'newly_excluded_previous_remainder': len(details),
        'previously_verified_excluded': 607,
        'sparse_quotient_classes_weight_le_2': 631,
        'combined_excluded': 607 + len(details),
        'family_dimension_per_quotient': 120,
        'witness_types': counts,
        'identity': 'AC_f((r,r)) = 2^16 * sum_{z in rad(B_r)} (-1)^{L_z(r)}',
        'criterion': 'Bentness requires zero autocorrelation in every nonzero direction, hence exactly half of the L_z(r) values on rad(B_r) must equal 1.',
        'details': details,
        'seconds': round(time.perf_counter()-started, 3),
        'scope': 'Closes exactly the 631 quotient parameters eta of Hamming weight <=2. This is not a complete classification of all 2^35 quotient parameters and does not solve general n=32.',
    }
    out = BASE / 'resultado_derivadas_diagonais_24.json'
    out.write_text(json.dumps(result, indent=2), encoding='utf-8')
    print(json.dumps({k:v for k,v in result.items() if k != 'details'}, indent=2))

if __name__ == '__main__':
    main()

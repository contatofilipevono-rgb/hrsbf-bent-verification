#!/usr/bin/env python3
"""Exact rank spectrum of quintic RS fiber maps at n=16.

For every nonzero z in F_2^8, this script constructs the linear map
    c in F_2^273 -> (u -> f_c(u,u+z)) in F_2^256,
where f_c ranges over homogeneous degree-5 rotation-symmetric Boolean
functions in 16 variables.

The calculation is exact and uses only Python's standard library.
It measures information carried by each fiber; it does NOT prove
nonexistence of quintic bent functions.
"""
import collections
import itertools
import json
import sys
from pathlib import Path

N = 16
H = 8

def toggle(s, x):
    if x in s:
        s.remove(x)
    else:
        s.add(x)

def cyclic_orbits(n=N, degree=5):
    unseen = set(itertools.combinations(range(n), degree))
    out = []
    while unseen:
        rep = min(unseen)
        orbit = {
            tuple(sorted((i + shift) % n for i in rep))
            for shift in range(n)
        }
        unseen.difference_update(orbit)
        out.append((rep, sorted(orbit)))
    return out

MONOMIAL_TRUTH = []
for mask in range(1 << H):
    bits = 0
    for u in range(1 << H):
        if (u & mask) == mask:
            bits |= 1 << u
    MONOMIAL_TRUTH.append(bits)

def fiber_profile(orbit, z):
    anf = set()
    for support in orbit:
        terms = {0}
        for v in support:
            if v < H:
                factors = (1 << v,)
            else:
                j = v - H
                factors = (1 << j, 0) if ((z >> j) & 1) else (1 << j,)
            nxt = set()
            for a in terms:
                for b in factors:
                    toggle(nxt, a | b)
            terms = nxt
        for m in terms:
            toggle(anf, m)
    truth = 0
    for m in anf:
        truth ^= MONOMIAL_TRUTH[m]
    return truth

def gf2_basis(vectors):
    pivots = {}
    for v in vectors:
        x = v
        while x:
            p = x.bit_length() - 1
            if p in pivots:
                x ^= pivots[p]
            else:
                pivots[p] = x
                break
    return list(pivots.values())

def gf2_rank(vectors):
    return len(gf2_basis(vectors))

def rotation(z, s):
    s %= H
    if not s:
        return z
    return ((z << s) | (z >> (H - s))) & ((1 << H) - 1)

def canonical_rotation(z):
    return min(rotation(z, s) for s in range(H))

def period(z):
    for p in range(1, H + 1):
        if rotation(z, p) == z:
            return p
    raise AssertionError

def weight_histogram_of_code(basis):
    # Gray-code enumeration: one generator changes at every step.
    r = len(basis)
    value = 0
    previous_gray = 0
    hist = collections.Counter({0: 1})
    for k in range(1, 1 << r):
        gray = k ^ (k >> 1)
        changed = gray ^ previous_gray
        j = (changed & -changed).bit_length() - 1
        value ^= basis[j]
        hist[value.bit_count()] += 1
        previous_gray = gray
    return hist

def joint_rank(profiles, zs, orbit_count):
    vectors = []
    for i in range(orbit_count):
        combined = 0
        shift = 0
        for z in zs:
            combined |= profiles[z][i] << shift
            shift += 1 << H
        vectors.append(combined)
    return gf2_rank(vectors)

def main(output):
    orbits = cyclic_orbits()
    assert len(orbits) == 273

    profiles = {}
    ranks = {}
    for z in range(1, 1 << H):
        vectors = [fiber_profile(orbit, z) for _, orbit in orbits]
        profiles[z] = vectors
        ranks[z] = gf2_rank(vectors)

    histogram = collections.Counter(ranks.values())

    classes = collections.defaultdict(list)
    for z in range(1, 1 << H):
        classes[canonical_rotation(z)].append(z)

    class_rows = []
    for rep, members in sorted(classes.items()):
        member_ranks = {ranks[z] for z in members}
        assert len(member_ranks) == 1
        class_rows.append({
            "representative": hex(rep),
            "orbit_size": len(members),
            "weight": rep.bit_count(),
            "period": period(rep),
            "rank": next(iter(member_ranks)),
        })

    exact_balance = {}
    for z in (0xFF, 0x55):
        basis = gf2_basis(profiles[z])
        hist = weight_histogram_of_code(basis)
        exact_balance[hex(z)] = {
            "rank": len(basis),
            "image_profiles": 1 << len(basis),
            "balanced_profiles": hist[1 << (H - 1)],
            "weight_histogram": {str(k): v for k, v in sorted(hist.items())},
        }

    # Deterministic greedy set maximizing joint rank at each step.
    selected = []
    remaining = list(range(1, 1 << H))
    history = []
    while len(selected) < 16:
        best_rank = -1
        best_z = None
        for z in remaining:
            r = joint_rank(profiles, selected + [z], len(orbits))
            if r > best_rank:
                best_rank, best_z = r, z
        selected.append(best_z)
        remaining.remove(best_z)
        history.append(best_rank)
        if best_rank == len(orbits):
            break

    result = {
        "date_utc": "2026-10-06",
        "n": N,
        "degree": 5,
        "coefficient_dimension": len(orbits),
        "fiber_variable_dimension": H,
        "nonzero_fibers": (1 << H) - 1,
        "rank_histogram": {str(k): v for k, v in sorted(histogram.items())},
        "rotation_class_count": len(class_rows),
        "rotation_classes": class_rows,
        "exact_low_rank_balance_profiles": exact_balance,
        "greedy_injective_fiber_set": {
            "z_hex": [hex(z) for z in selected],
            "rank_history": history,
            "final_joint_rank": history[-1],
            "injective_on_273_coefficients": history[-1] == len(orbits),
        },
        "interpretation": (
            "Exact linear-map ranks only. Rank and injectivity do not imply "
            "bentness or nonexistence."
        ),
    }

    # Cross-check against independently obtained invariants.
    assert ranks[0xFF] == 12
    assert exact_balance["0xff"]["balanced_profiles"] == 1670
    assert ranks[0x55] == 20
    assert exact_balance["0x55"]["balanced_profiles"] == 288195
    assert history[-1] == 273

    output.write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps({
        "status": "PASS",
        "rank_histogram": result["rank_histogram"],
        "greedy_injective_fiber_set": result["greedy_injective_fiber_set"],
        "complementary_rank": ranks[0xFF],
    }, indent=2))

if __name__ == "__main__":
    if not __debug__:
        raise RuntimeError("Run without python -O; assertions are audit checks.")
    if len(sys.argv) != 2:
        raise SystemExit("usage: python3 fiber_rank_spectrum_d5.py OUTPUT.json")
    main(Path(sys.argv[1]))

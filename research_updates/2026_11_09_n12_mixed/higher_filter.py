"""Linear lower-degree filters for n=12, and complete antipodal-sum families."""

import argparse
import json
import random
from collections import Counter
from itertools import combinations
from pathlib import Path
from time import perf_counter

N = 12
SIZE = 1 << N
FULL = SIZE - 1


def subsets(mask):
    s = mask
    while True:
        yield s
        if not s:
            return
        s = (s - 1) & mask


def shift(v, k, n=N):
    return ((v << k) | (v >> (n - k))) & ((1 << n) - 1)


def orbits(n, d=None):
    masks = (range(1 << n) if d is None else
             (sum(1 << i for i in p) for p in combinations(range(n), d)))
    unvisited = set(masks)
    while unvisited:
        m = min(unvisited)
        orb = {shift(m, k, n) for k in range(n)}
        yield m, orb
        unvisited -= orb


def pack(function):
    return int.from_bytes(bytes(
        sum(int(function(i + j)) << j for j in range(8))
        for i in range(0, SIZE, 8)), "little")


def evaluate_orbit(orb, on_pair_sums=False):
    def value(x):
        if on_pair_sums:
            x = (x & 63) ^ (x >> 6)
        return sum((x & m) == m for m in orb) % 2
    return pack(value)


def xor_terms(tables, c):
    table = 0
    while c:
        bit = c & -c
        table ^= tables[bit.bit_length() - 1]
        c ^= bit
    return table


def flats():
    keys = set()
    for _, supports in orbits(N, 8):
        for support in supports:
            for fixed in subsets(FULL ^ support):
                key = min((shift(support, k), shift(fixed, k)) for k in range(N))
                keys.add(key)
    coordinate = [sum(1 << (fixed | x) for x in subsets(support))
                  for support, fixed in sorted(keys)]
    rng = random.Random(1208)
    extra = []
    for _ in range(384):
        span = {0}
        while len(span) < 256:
            v = rng.randrange(SIZE)
            if v not in span:
                span |= {x ^ v for x in span}
        a = rng.randrange(SIZE)
        extra.append(sum(1 << (a ^ x) for x in span))
    assert all(s.bit_count() == 256 for s in coordinate + extra)
    return coordinate, extra


def solve(rows, width):
    pivots = {}
    for mask, rhs in rows:
        while mask:
            j = mask.bit_length() - 1
            if j not in pivots:
                pivots[j] = (mask, rhs)
                break
            other, b = pivots[j]
            mask ^= other
            rhs ^= b
        else:
            if rhs:
                return None, [], len(pivots)
    root = 0
    for j, (mask, rhs) in sorted(pivots.items()):
        if (root & mask).bit_count() % 2 != rhs:
            root |= 1 << j
    basis = []
    for i in range(width):
        if i in pivots:
            continue
        v = 1 << i
        for j, (mask, _) in sorted(pivots.items()):
            if (v & mask).bit_count() % 2:
                v |= 1 << j
        basis.append(v)
    return root, basis, len(pivots)


def linear_system(high, low, affine_flats):
    for flat in affine_flats:
        h = high & flat
        count = h.bit_count()
        assert count % 2 == 0
        coeffs = sum(((h & table).bit_count() % 2) << i for i, table in enumerate(low))
        yield coeffs, (count // 2) % 2


def projection(table):
    return sum(((table >> (273 * x)) & 1) << x for x in range(16))


def allowed_period4(table):
    return all(sum(1 - 2 * (((table >> x) ^ (u & x).bit_count()) & 1)
                   for x in range(16)) % 3 for u in range(16))


def period4_charts(high, low, root, basis):
    tables = [xor_terms(low, v) for v in basis]
    image = {0: 0}
    kernel = []
    for i, t in enumerate(tables):
        key = projection(t)
        if key in image:
            kernel.append(basis[i] ^ image[key])
        else:
            image.update({k ^ key: v ^ basis[i] for k, v in list(image.items())})
    p = projection(high ^ xor_terms(low, root))
    roots = [root ^ value for key, value in image.items() if allowed_period4(p ^ key)]
    return roots, kernel


def frequencies():
    reps = [m for m, _ in orbits(N)]
    order = list(dict.fromkeys([0, FULL, 1, 3, 5, 7, 15, 9] + reps))
    return [pack(lambda x: (u & x).bit_count() % 2) for u in order]


def direct_walsh(table):
    w = [1 - 2 * ((table >> x) & 1) for x in range(SIZE)]
    h = 1
    while h < SIZE:
        for i in range(0, SIZE, 2 * h):
            for j in range(i, i + h):
                a, b = w[j], w[j + h]
                w[j], w[j + h] = a + b, a - b
        h *= 2
    return all(v in (-64, 64) for v in w)


def complete(high, low, roots, kernel, masks):
    changes = [xor_terms(low, v) for v in kernel]
    results = []
    for c in roots:
        t = high ^ xor_terms(low, c)
        for j in range(1 << len(kernel)):
            if j:
                bit = (j & -j).bit_length() - 1
                t ^= changes[bit]
                c ^= kernel[bit]
            if all((t ^ chi).bit_count() in (2016, 2080) for chi in masks):
                results.append(c)
    assert len(results) == len(set(results))
    for c in results[::max(1, len(results) // 32)]:
        assert direct_walsh(high ^ xor_terms(low, c))
    return results


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--sample", type=int, default=0)
    p.add_argument("--chart", type=int)
    p.add_argument("--first", type=int, default=0)
    p.add_argument("--last", type=int, default=32)
    p.add_argument("--complete", action="store_true")
    p.add_argument("--output", type=Path, required=True)
    a = p.parse_args()
    t0 = perf_counter()
    coordinate, extra = flats()
    print("Affine 8-flats:", len(coordinate), "coordinate +", len(extra), "additional", flush=True)
    low = [evaluate_orbit(o) for d in (2, 3) for _, o in orbits(N, d)]
    anti = [evaluate_orbit(o, on_pair_sums=True) for d in (4, 5, 6) for _, o in orbits(6, d)]
    assert len(low) == 25 and len(anti) == 5
    masks = frequencies() if a.complete else None
    reports = []
    a.output.mkdir(parents=True, exist_ok=True)
    for chart in ([a.chart] if a.chart is not None else range(a.first, a.last)):
        high = xor_terms(anti, chart)
        roots_data = [solve(linear_system(high, low, selected), 25)
                      for selected in (coordinate, coordinate + extra)]
        root, basis, rank = roots_data[1]
        assert root is not None  # q + h(z) is a positive control for each top.
        q = 1 << 5
        assert all((row & q).bit_count() % 2 == rhs
                   for row, rhs in linear_system(high, low, coordinate + extra))
        assert direct_walsh(high ^ xor_terms(low, q))
        roots, kernel = period4_charts(high, low, root, basis)
        report = {"chart": chart,
                  "degree": 6 if chart & 16 else 5 if chart & 8 else 4 if chart else 0,
                  "rank_coordinate": roots_data[0][2], "rank_all": rank,
                  "trials": len(roots) << len(kernel)}
        if a.complete:
            bent = complete(high, low, roots, kernel, masks)
            report["normalized_bent"] = len(bent)
            (a.output / f"chart-{chart:02d}-bent.txt").write_text(
                "".join(f"{m}\n" for m in sorted(bent)))
            assert q in bent
        reports.append(report)
        print(report, flush=True)
    sample = {}
    if a.sample:
        high_terms = [evaluate_orbit(o) for d in (4, 5, 6) for _, o in orbits(N, d)]
        assert len(high_terms) == 43 + 66 + 80
        rng = random.Random(120506)
        for d, width in ((5, 109), (6, 189)):
            by_rank = Counter()
            survivors = 0
            survivors_all = 0
            for _ in range(a.sample):
                c = rng.getrandbits(width - 1) | (1 << (width - 1))
                high = xor_terms(high_terms, c)
                root, _, rank = solve(linear_system(high, low, coordinate), 25)
                by_rank[rank] += 1
                if root is None:
                    continue
                survivors += 1
                root, _, _ = solve(linear_system(high, low, coordinate + extra), 25)
                survivors_all += root is not None
            sample[d] = {"tested": a.sample, "survived_coordinate": survivors,
                         "survived_all": survivors_all,
                         "rank_at_termination_histogram": dict(sorted(by_rank.items()))}
        print("Sample", sample, flush=True)
    report = {"coordinate_flats": len(coordinate), "extra_flats": len(extra),
              "family": reports, "sample": sample, "seconds": perf_counter() - t0}
    (a.output / "report.json").write_text(json.dumps(report, indent=2) + "\n")


if __name__ == "__main__":
    main()

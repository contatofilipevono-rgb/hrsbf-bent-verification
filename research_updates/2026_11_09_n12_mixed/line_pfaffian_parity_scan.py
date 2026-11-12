"""Measure radical parity after the phase-free Pfaffian conditions."""
import argparse
import json
from collections import Counter
from itertools import combinations
from pathlib import Path

import numpy as np

from count_near_antipodal import all_points, image_and_kernel
from higher_filter import xor_terms
from line_column_collision import radical_bases
from line_radical_parity import PAIRS, Z_MASK, polar_basis
from line_zero_column import odd_radical_support
from lower_dim_model import anf


def top_coordinates(polar):
    monomials = [anf((polar >> (64*i)) & Z_MASK, 6) for i in range(15)]
    return sum(((polynomial >> ((1 << a) | (1 << b))) & 1) << (15*i+j)
               for i, polynomial in enumerate(monomials) for j, (a, b) in enumerate(PAIRS))


def pairings():
    pair_index = {pair: i for i, pair in enumerate(PAIRS)}
    return [
        [(pair_index[a, b], pair_index[c, d]), (pair_index[a, c], pair_index[b, d]),
         (pair_index[a, d], pair_index[b, c])]
        for a, b, c, d in combinations(range(6), 4)
    ]


def pfaffian_tops(image, shard, shard_bits):
    d = len(image) - shard_bits
    base = xor_terms([top for top, _ in image], shard << d)
    top = np.empty((1 << d, 15, 15), dtype=np.uint8)
    top[0] = np.array([(base >> i) & 1 for i in range(225)], dtype=np.uint8).reshape(15, 15)
    for i, (vector, _) in enumerate(image[:d]):
        direction = np.array([(vector >> j) & 1 for j in range(225)], dtype=np.uint8).reshape(15, 15)
        top[1 << i:2 << i] = top[:1 << i] ^ direction
    ids = np.arange(1 << d, dtype=np.int64) | (shard << d)
    groups = pairings()
    for w_pairs in groups:
        keep = np.ones(len(ids), dtype=bool)
        for z_pairs in groups:
            coefficients = np.zeros(len(ids), dtype=np.uint8)
            for i, j in w_pairs:
                for a, b in z_pairs:
                    coefficients ^= (top[:, i, a] & top[:, j, b]) ^ (top[:, i, b] & top[:, j, a])
            keep &= coefficients == 0
        ids, top = ids[keep], top[keep]
    return ids.tolist()


def polar_value(polar, u, v):
    forms = [((polar >> (64*i)) & Z_MASK) for i in range(15)]
    value = 0
    for entry, (a, b) in zip(forms, PAIRS):
        if ((u >> a & 1) & (v >> b & 1)) ^ ((u >> b & 1) & (v >> a & 1)):
            value ^= entry
    return value


def orbit_form(step):
    pairs = {tuple(sorted((i, (i+step) % 6))) for i in range(6)}
    return sum((sum((z >> i & 1) & (z >> j & 1) for i, j in pairs) & 1) << z
               for z in range(64))


def scan(shard, shard_bits):
    basis = polar_basis()
    image, kernel = image_and_kernel([top_coordinates(p) for p in basis])
    assert len(image) == 21 and len(kernel) == 4
    tops = pfaffian_tops(image, shard, shard_bits)
    lifts = [xor_terms(basis, word) for _, word in image]
    low = all_points([xor_terms(basis, word) for word in kernel])
    e1 = sum((z.bit_count() & 1) << z for z in range(64))
    p1, p2, p3 = [orbit_form(i) for i in (1, 2, 3)]
    labels_a = {p: i for i, p in enumerate(all_points([e1, p1, p2]))}
    labels_b = {p: i for i, p in enumerate(all_points([p1, e1 ^ p2, Z_MASK ^ e1 ^ p3]))}
    counts = Counter()
    for code in tops:
        top = xor_terms(lifts, code)
        for bottom in low:
            polar = top ^ bottom
            a = labels_a[polar_value(polar, 27, 54)]
            b = labels_b[polar_value(polar, 21, 42)]
            if not a or not b or not radical_bases(polar)[0]:
                continue
            counts[a, b, odd_radical_support(polar) is None] += 1
    return {
        "shard": shard, "top_count": len(tops),
        "counts": [[a, b, even, count] for (a, b, even), count in sorted(counts.items())],
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--shard", type=int, required=True)
    parser.add_argument("--shard-bits", type=int, default=4)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    assert 0 <= args.shard < (1 << args.shard_bits)
    report = scan(args.shard, args.shard_bits)
    args.output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(report)


if __name__ == "__main__":
    main()

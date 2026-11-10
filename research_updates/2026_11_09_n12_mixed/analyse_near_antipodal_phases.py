"""Analyse the phase equations on the near-antipodal plane partitions."""
import argparse
import json
import struct
from collections import Counter
from itertools import combinations
from pathlib import Path

from count_near_antipodal import rotation_orbits
from higher_filter import shift, solve


def label_action():
    rotated = [shift((1 << i) | 32, 1, 6) & 31 for i in range(5)]
    transpose = [sum(((label & v).bit_count() & 1) << i for i, v in enumerate(rotated))
                 for label in range(32)]
    return [transpose.index(label) for label in range(32)]


def base_action(x):
    return shift(x & 63, 1, 6) | (((x >> 6) ^ (x >> 5 & 1)) << 6)


def phase_rows(mapping, phase, kernel):
    fibres = [0] * 32
    for x, label in enumerate(mapping):
        fibres[label] |= 1 << x
    assert all(f.bit_count() == 4 for f in fibres)
    return [(sum(((f & h).bit_count() & 1) << j for j, h in enumerate(kernel)),
             1 ^ ((f & phase).bit_count() & 1)) for f in fibres]


def certify(rows, width):
    # Enumerate dependencies on the eight label orbits. This finds the
    # smallest inconsistent sums, including one-equation obstructions.
    row_codes = [a | (b << width) for a, b in rows]
    pivots = {}
    for a, _ in rows:
        while a and (key := a.bit_length()) in pivots:
            a ^= pivots[key]
        if a:
            pivots[a.bit_length()] = a
    for size in range(1, len(rows) + 1):
        masks = []
        for group in combinations(range(len(rows)), size):
            out = 0
            for i in group:
                out ^= row_codes[i]
            if out == 1 << width:
                masks.append(sum(1 << i for i in group))
        if masks:
            return len(pivots), tuple(masks)
    return len(pivots), ()


def ambient_generators():
    def mul(a, b):
        out = 0
        for i in range(12):
            if b >> i & 1:
                out ^= shift(a, i)
        return out

    # X^12 - 1 has only the irreducible factors X+1 and X^2+X+1.
    def is_unit(a):
        parity_classes = {sum(a >> i & 1 for i in range(j, 12, 3)) & 1
                          for j in range(3)}
        return (a.bit_count() & 1) and len(parity_classes) == 2

    units = [a for a in range(1, 4096) if is_unit(a)]
    assert len(units) == 1536
    span = {1}
    generators = []
    for g in units:
        if g in span:
            continue
        generators.append(g)
        coset = {mul(a, g) for a in span}
        while coset != span:
            old = coset - span
            if not old:
                break
            span |= old
            coset = {mul(a, g) for a in coset}
    assert span == set(units)
    return [(str(g), lambda x, g=g: mul(x, g)) for g in generators] + [
        ("reflection", lambda x: sum(((x >> i) & 1) << ((-i) % 12) for i in range(12))),
        ("translation", lambda x: x ^ 4095),
    ]


def map_actions():
    def quotient(original):
        a, w = original & 63, original >> 6
        return (a ^ w) | ((w.bit_count() & 1) << 6)

    for name, transform in ambient_generators():
        moved_base = []
        for x in range(128):
            w = (x >> 6) << 5
            moved_base.append(quotient(transform(((x & 63) ^ w) | (w << 6))))
        moved_u = []
        for i in range(5):
            w = (1 << i) | 32
            original = transform(w | (w << 6)) ^ transform(0)
            assert quotient(original) == 0
            moved_u.append((original >> 6) & 31)
        moved_labels = bytes(sum(((b & v).bit_count() & 1) << i for i, v in enumerate(moved_u))
                             for b in range(32))
        yield name, moved_base, moved_labels


def classify_orbits(phase_stats):
    unseen = set(phase_stats)
    actions = list(map_actions())
    hist = Counter()
    while unseen:
        start = min(unseen)
        orbit = {start}
        pending = [start]
        while pending:
            p = pending.pop()
            for _, base, labels in actions:
                moved = bytes(labels[p[x]] for x in base)
                if moved not in orbit:
                    assert moved in unseen
                    assert phase_stats[moved] == phase_stats[start]
                    orbit.add(moved)
                    pending.append(moved)
        unseen.difference_update(orbit)
        hist[phase_stats[start], len(orbit)] += 1
    return [
        {"rank": rank, "consistent": consistent, "size": size, "orbits": count}
        for ((rank, consistent), size), count in sorted(hist.items())
    ]


def analyse(branches_path, maps_path):
    with branches_path.open("rb") as source:
        _, width = struct.unpack("<II", source.read(8))
        kernel = [int.from_bytes(source.read(16), "little") for _ in range(width)]
    action = label_action()
    orbits = list(rotation_orbits(action))
    labels = [o[0] for o in orbits]
    histogram = Counter()
    certificates = Counter()
    phase_stats = {}
    rank_rows = Counter()
    phase_patterns = Counter()
    rhs_patterns = Counter()
    q_patterns = set()
    with maps_path.open("rb") as data:
        while block := data.read(144):
            assert len(block) == 144
            mapping = block[:128]
            phase = int.from_bytes(block[128:], "little")
            q_patterns.add(tuple(a ^ b for a, b in zip(mapping[:64], mapping[64:])))
            assert mapping not in phase_stats
            assert all(mapping[base_action(x)] == action[mapping[x]] for x in range(128))
            rows = phase_rows(mapping, phase, kernel)
            assert all(rows[b] == rows[o[0]] for o in orbits for b in o)
            reduced = [rows[b] for b in labels]
            rank, obstructions = certify(reduced, width)
            ok = not obstructions
            root, free, _ = solve(rows, width)
            assert (root is not None) == ok
            assert not ok or len(free) == width - rank
            phase_stats[mapping] = rank, ok
            histogram[rank, ok] += 1
            rank_rows[tuple(a != 0 for a, _ in reduced), rank, ok] += 1
            certificates.update(obstructions)
            phase_patterns[(tuple(a for a, _ in reduced), rank, ok)] += 1
            pair, zero_pair = ((1, 11), (3, 5)) if rows[1][0] else ((3, 5), (1, 11))
            a, b = pair
            c, d = zero_pair
            assert rows[a][0] == rows[b][0] and rows[a][0]
            assert rows[0][0] == rows[9][0] and rows[0][0] not in (0, rows[a][0])
            assert all(not rows[x][0] for x in (7, 21, c, d))
            assert rows[0][1] == rows[9][1] and not rows[7][1] and not rows[21][1]
            bits = (rows[a][1] ^ rows[b][1], rows[c][1], rows[d][1])
            assert ok == (not any(bits))
            rhs_patterns[pair, bits] += 1
    assert len(q_patterns) == 1
    q = q_patterns.pop()
    return {
        "label_representatives": labels,
        "q_nonzero_fibres": {b: [z for z, a in enumerate(q) if a == b]
                             for b in sorted(set(q) - {0})},
        "maps": len(phase_stats),
        "systems": [{"rank": r, "consistent": ok, "maps": n}
                    for (r, ok), n in sorted(histogram.items())],
        "row_patterns": [
            {"nonzero_labels": [b for b, yes in zip(labels, pattern) if yes],
             "rank": rank, "consistent": ok, "maps": n}
            for (pattern, rank, ok), n in sorted(rank_rows.items())
        ],
        "coefficient_patterns": [
            {"rows": rows, "rank": rank, "consistent": ok, "maps": n}
            for (rows, rank, ok), n in sorted(phase_patterns.items())
        ],
        "minimal_inconsistency_certificates": [
            {"labels": [b for i, b in enumerate(labels) if mask >> i & 1], "maps": n}
            for mask, n in sorted(certificates.items())
        ],
        "rhs_patterns": [
            {"injective_labels": pair, "remaining_rhs_bits": bits, "maps": n}
            for (pair, bits), n in sorted(rhs_patterns.items())
        ],
        "coordinate_orbits": classify_orbits(phase_stats),
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("branches", type=Path)
    parser.add_argument("maps", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    result = analyse(args.branches, args.maps)
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({k: v for k, v in result.items() if k != "coefficient_patterns"}, indent=2))


if __name__ == "__main__":
    main()

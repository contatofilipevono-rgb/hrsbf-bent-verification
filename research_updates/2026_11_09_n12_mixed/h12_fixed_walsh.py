"""Verify four fixed Walsh frequencies on the existing H12 candidate pool."""
import argparse
import json
from collections import Counter
from pathlib import Path

import numpy as np

from higher_filter import evaluate_orbit, projection
from higher_project import TOP


def lookup_blocks(columns):
    out = []
    for i in range(0, len(columns), 8):
        row = [0]
        for c in columns[i:i + 8]:
            row += [x ^ c for x in row]
        out.append(row)
    return out


def evaluate(blocks, code):
    result = 0
    for row in blocks:
        result ^= row[code & 255]
        code >>= 8
    return result


def truth_mask_for_frequency(frequency):
    return sum(((x & frequency).bit_count() & 1) << x for x in range(4096))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("shards", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    basis = [evaluate_orbit(o) for _, o in TOP]
    projected = lookup_blocks([projection(t) for t in basis])
    complete = lookup_blocks(basis)
    # Keys are the period-four truth tables from the three branches of H12.
    branch = {0x6CA0: 2, 0x7EE8: 3, 0x8000: 8}
    freqs = (0, 9, 1, 5)
    masks = [truth_mask_for_frequency(u) for u in freqs]
    counts = {i: [0] * (1 + len(freqs)) for i in branch.values()}
    w0 = {i: Counter() for i in counts}
    w9_after_w0 = {i: Counter() for i in counts}
    files = sorted(args.shards.glob("n12-top-*/tops.npy"))
    assert len(files) == 16
    for path in files:
        for packed in np.load(path, mmap_mode="r"):
            code = int(packed)
            i = branch.get(evaluate(projected, code))
            if i is None:
                continue
            counts[i][0] += 1
            truth = evaluate(complete, code)
            for stage, freq_signs in enumerate(masks, 1):
                w = 4096 - 2 * (truth ^ freq_signs).bit_count()
                if stage == 2:
                    w9_after_w0[i][w] += 1
                if abs(w) != 64:
                    break
                if stage == 1:
                    w0[i][w] += 1
                counts[i][stage] += 1
    assert counts == {2: [46912, 1980, 0, 0, 0], 3: [46400, 492, 0, 0, 0],
                      8: [70976, 836, 228, 4, 0]}
    report = {
        "frequencies": freqs,
        "period_four_codes": {str(i): f"{t:#06x}" for t, i in branch.items()},
        "counts_including_initial": counts,
        "surviving_walsh_at_zero": {i: dict(sorted(v.items())) for i, v in w0.items()},
        "walsh_at_nine_after_zero": {i: dict(sorted(v.items())) for i, v in w9_after_w0.items()},
    }
    args.output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(counts)


if __name__ == "__main__":
    main()

"""Compile the phase-free radical parity conditions in polar coordinates."""
import argparse
import json
from collections import Counter
from itertools import combinations
from pathlib import Path

from count_near_antipodal import image_and_kernel
from higher_filter import shift, xor_terms
from line_zero_column import odd_radical_support
from lower_dim_model import active_indices, anf, rotation_truth
from lower_dim_v3_symbolic import product


PAIRS = tuple(combinations(range(6), 2))
Z_MASK = (1 << 64) - 1


def polar_table(truth):
    entries = []
    for i, j in PAIRS:
        a, b = 1 << (6+i), 1 << (6+j)
        entries.append((truth ^ (truth >> a) ^ (truth >> b) ^ (truth >> (a | b))) & Z_MASK)
    return sum(value << (64*k) for k, value in enumerate(entries))


def polar_basis():
    coordinates = [(z ^ w) | (w << 6) for w in range(64) for z in range(64)]
    truth = [sum(((table >> x) & 1) << i for i, x in enumerate(coordinates))
             for table in rotation_truth()]
    forbidden = sum(1 << i for i in range(4096) if (i >> 6).bit_count() >= 3)
    _, kernel = image_and_kernel([anf(table, 12) & forbidden for table in truth])
    image, _ = image_and_kernel([polar_table(xor_terms(truth, c)) for c in kernel])
    assert len(kernel) == 68 and len(image) == 25
    return sorted((v for v, _ in image), reverse=True)


def coordinates_in_basis(polar, basis):
    word = 0
    for i, vector in enumerate(basis):
        if polar >> (vector.bit_length()-1) & 1:
            polar ^= vector
            word |= 1 << i
    assert not polar
    return word


def parity_polynomial(polars, v):
    result = set()
    for z in range(64):
        rows = [0] * 6
        for k, (i, j) in enumerate(PAIRS):
            column = sum(((p >> (64*k+z)) & 1) << n for n, p in enumerate(polars))
            if v >> j & 1:
                rows[i] ^= column
            if v >> i & 1:
                rows[j] ^= column
        image, _ = image_and_kernel(sorted(set(rows), key=int.bit_count))
        assert len(image) <= 4
        indicator = {0}
        for row, _ in image:
            indicator = product(indicator, {0} | {1 << i for i in active_indices(row)})
        result ^= indicator
    return result


def compile_and_check(reference):
    polars = polar_basis()
    directions = [v for v in range(1, 64) if v == min(shift(v, k, 6) for k in range(6))]
    equations = {v: parity_polynomial(polars, v) for v in directions}
    degrees = {v: max((m.bit_count() for m in p), default=None) for v, p in equations.items()}
    assert len(equations) == 13 and {v: d for v, d in degrees.items() if d != 4} == {
        9: 2, 27: None, 63: 2,
    }
    cross = Counter()
    for line in reference.read_text().splitlines():
        if not line.strip():
            continue
        polar = int(line.split()[0], 16)
        code = coordinates_in_basis(polar, polars)
        odd = any(sum(code & m == m for m in polynomial) & 1
                  for polynomial in equations.values())
        assert odd == (odd_radical_support(polar) is not None)
        cross["L5+L3=1" in line, odd] += 1
    assert cross == {(True, True): 106, (True, False): 92, (False, True): 10, (False, False): 4}
    return {
        "polar_basis": [f"{p:0240x}" for p in polars],
        "degrees": degrees,
        "parity_polynomials": {v: sorted(p) for v, p in equations.items()},
        "crosscheck": {"L3_compatible": 198, "L3_compatible_excluded_by_parity": 106},
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--reference", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    report = compile_and_check(args.reference)
    args.output.write_text(json.dumps(report, separators=(",", ":")) + "\n", encoding="utf-8")
    print({key: report[key] for key in ("degrees", "crosscheck")})


if __name__ == "__main__":
    main()

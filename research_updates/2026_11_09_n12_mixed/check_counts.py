"""Cross-check Argon's phase counts with bit-parallel integer moment evaluation."""
import json
import argparse
from collections import Counter
from functools import lru_cache
from pathlib import Path

from higher_filter import xor_terms
from line_phase_algebra import locate
from lower_dim_v2_residual_certificates import run_initial_quadratic_elimination
from lower_dim_v3_symbolic import read_tasks


@lru_cache(maxsize=None)
def variables(dimension):
    full = (1 << (1 << dimension)) - 1
    return full, [full ^ (full // ((1 << (1 << i)) + 1)) for i in range(dimension)]


def exact_count(root, phases, moments):
    full, coordinates = variables(len(phases))
    accepted = full
    for subset, mask, residue in moments:
        positions = subset
        histogram = Counter()
        while positions:
            bit = positions & -positions
            positions ^= bit
            affine = sum(bool(phase & bit) << i for i, phase in enumerate(phases))
            histogram[affine, bool(root & bit)] += 1
        width = mask.bit_length()
        weight = [0] * width
        for (affine, const), multiplicity in histogram.items():
            values = full if const else 0
            while affine:
                bit = affine & -affine
                affine ^= bit
                values ^= coordinates[bit.bit_length() - 1]
            for i in range(width):
                if multiplicity >> i & 1:
                    carry = values
                    for j in range(i, width):
                        previous = weight[j]
                        weight[j] ^= carry
                        carry &= previous
                        if not carry:
                            break
        for i, values in enumerate(weight):
            accepted &= values if residue >> i & 1 else ~values
        if not accepted:
            break
    return accepted.bit_count()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--artifacts", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, required=True)
    args = parser.parse_args()
    manifest = json.loads(args.manifest.read_text(encoding="utf-8"))
    tasks = {task[0]: task for task in read_tasks(args.artifacts / "tasks_reconstructed.bin")}
    result = {}
    for cert in manifest["residual_task_certificates"]:
        if cert["status"] != "positive":
            continue
        code = cert["map_code"]
        _, multiplier, _, root, signature, directions, moments = tasks[code]
        root, _, directions = run_initial_quadratic_elimination(root, signature, directions, moments)
        phases = [phase for phase, _ in directions]
        image = cert["polar_image_echelon"]
        kernel = [xor_terms(phases, word) for word in cert["polar_kernel_basis"]]
        total = 0
        for coset in cert["cosets"]:
            if coset["status"] == "empty":
                continue
            representative = coset["representative_mask"]
            assert locate(image, xor_terms([s >> 64 for _, s in directions], representative)) == representative
            phase = root ^ xor_terms(phases, representative)
            free = kernel
            for step in coset["reduction_rounds"]:
                phase ^= xor_terms(free, step["shift_mask"])
                free = [xor_terms(free, word) for word in step["free_basis"]]
            count = exact_count(phase, free, moments)
            assert count == coset["quotient_count"], (code, representative, count)
            total += count
        assert total == cert["quotient_count"]
        result[code] = total << multiplier
        print(code, total, result[code], flush=True)
    print(result, flush=True)


if __name__ == "__main__":
    main()

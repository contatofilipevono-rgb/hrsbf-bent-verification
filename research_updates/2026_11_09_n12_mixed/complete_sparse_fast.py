"""Split a hard sparse chart, then stream its exact affine tasks to C++."""
import argparse
import json
import subprocess
from pathlib import Path
from time import perf_counter

import numpy as np

from higher_complete import evaluate, make_tables
from higher_filter import (allowed_period4, evaluate_orbit, projection, solve, xor_terms)
from higher_project import LOW, TOP, UPPER, eliminate_lower, union_system
from sparse_projection import reduce_iteratively


def projected_kernel(low, basis):
    image = {0: 0}
    kernel = []
    for m in basis:
        v = projection(xor_terms(low, m))
        if v in image:
            kernel.append(m ^ image[v])
        else:
            image.update({x ^ v: c ^ m for x, c in list(image.items())})
    return image, kernel


def main():
    p = argparse.ArgumentParser()
    p.add_argument("index", type=int)
    p.add_argument("shard", type=int)
    p.add_argument("shard_bits", type=int)
    p.add_argument("executable", type=Path)
    p.add_argument("output", type=Path)
    a = p.parse_args()
    assert 0 <= a.shard < 1 << a.shard_bits
    started = perf_counter()
    low = [evaluate_orbit(o) for _, o in LOW]
    upper = [evaluate_orbit(o) for _, o in TOP]
    high = evaluate_orbit(UPPER[a.index][1])
    hp = projection(high)
    lp = [projection(v) for v in low]
    up = [projection(v) for v in upper]
    pivots, residual = eliminate_lower(union_system(1 << a.index))
    root, basis, reduced, stages, contradiction = reduce_iteratively(residual)
    assert contradiction is None
    width = len(basis) - a.shard_bits
    nw = min(20, width)
    fixed = a.shard << width
    q0, left, right, mixed, a_lut, b_lut = make_tables(
        reduced, fixed, [1 << i for i in range(width)], nw)
    low_rows = [(m, 0) for m, _ in pivots.values()]
    _, lb, rank = solve(low_rows, 25)
    assert rank == len(pivots)
    image, kernel = projected_kernel(low, lb)
    by_pivot = sorted(pivots.items())
    allowed = {g for g in range(65536) if allowed_period4(g)}
    a.output.mkdir(parents=True, exist_ok=True)
    quartic_survivors = 0
    tasks = 0
    with subprocess.Popen([str(a.executable.resolve()), str(a.output)],
                          stdin=subprocess.PIPE, text=True) as worker:
        worker.stdin.write(" ".join(map(str, [a.index, len(kernel), *kernel])) + "\n")
        for step in range(len(left)):
            if step:
                bit = (step & -step).bit_length() - 1
                np.bitwise_xor(right, mixed[bit], out=right)
            gray = step ^ (step >> 1)
            hits = np.flatnonzero(right == (left[gray] ^ np.uint64(q0)))
            for value in b_lut[hits] ^ a_lut[gray] ^ np.uint64(fixed):
                top = root ^ xor_terms(basis, int(value))
                quartic_survivors += 1
                low_root = 0
                for j, (m, eq) in by_pivot:
                    bit = (low_root & m).bit_count() % 2 ^ evaluate(eq, top)
                    low_root |= bit << j
                f = hp ^ xor_terms(up, top) ^ xor_terms(lp, low_root)
                for key, delta in image.items():
                    if f ^ key in allowed:
                        worker.stdin.write(f"{top} {low_root ^ delta}\n")
                        tasks += 1
        worker.stdin.close()
        assert worker.wait() == 0
    c_tasks, lower_trials, bent = map(int, (a.output / "totals.tsv").read_text().split())
    assert c_tasks == tasks and lower_trials == tasks << len(kernel)
    report = {"index": a.index, "shard": a.shard, "shard_bits": a.shard_bits,
              "linear_stages": stages, "quartic_trials": 1 << width,
              "quartic_filter_survivors": quartic_survivors, "lower_trials": lower_trials,
              "normalized_bent": bent, "seconds": round(perf_counter() - started, 3)}
    (a.output / "report.json").write_text(json.dumps(report, indent=2) + "\n")
    print(report, flush=True)


if __name__ == "__main__":
    main()

"""Enumerate all completions with exactly one degree-five/six orbit above degree four."""

import argparse
import json
from pathlib import Path
from time import perf_counter

import numpy as np

from higher_complete import evaluate, make_tables
from higher_filter import (direct_walsh, evaluate_orbit, frequencies, period4_charts,
                           solve, xor_terms)
from higher_project import LOW, TOP, UPPER, eliminate_lower, union_system
from sparse_projection import reduce_iteratively


def exhaust(index, output, top_tables, low_tables, spectrum_tests):
    start = perf_counter()
    higher_rep, higher_orbit = UPPER[index]
    high = evaluate_orbit(higher_orbit)
    low_pivots, residual = eliminate_lower(union_system(1 << index))
    root, quartic_basis, reduced, stages, contradiction = reduce_iteratively(residual)
    report = {"index": index, "higher_orbit_representative": higher_rep,
              "degree": higher_rep.bit_count(), "linear_stages": stages,
              "lower_rank": len(low_pivots), "quartic_trials": 0,
              "quartic_filter_survivors": 0, "lower_trials": 0,
              "normalized_bent": 0, "contradiction": contradiction is not None}
    if contradiction is not None:
        report["certificate_of_final_contradiction"] = contradiction
        report["seconds"] = round(perf_counter() - start, 3)
        return report

    width = len(quartic_basis)
    nw = min(20, width)
    q0, left, right, mixed, a_lut, b_lut = make_tables(
        reduced, 0, [1 << i for i in range(width)], nw)
    report["quartic_trials"] = 1 << width
    for step in range(len(left)):
        if step:
            bit = (step & -step).bit_length() - 1
            np.bitwise_xor(right, mixed[bit], out=right)
        gray = step ^ (step >> 1)
        hits = np.flatnonzero(right == (left[gray] ^ np.uint64(q0)))
        for value in b_lut[hits] ^ a_lut[gray]:
            top = root ^ xor_terms(quartic_basis, int(value))
            report["quartic_filter_survivors"] += 1
            lower_root, lower_basis, _ = solve(
                [(mask, evaluate(p, top)) for mask, p in low_pivots.values()], 25)
            assert lower_root is not None
            base = high ^ xor_terms(top_tables, top)
            roots, kernel = period4_charts(base, low_tables, lower_root, lower_basis)
            changes = [xor_terms(low_tables, v) for v in kernel]
            report["lower_trials"] += len(roots) << len(kernel)
            for c in roots:
                table = base ^ xor_terms(low_tables, c)
                for k in range(1 << len(kernel)):
                    if k:
                        b = (k & -k).bit_length() - 1
                        table ^= changes[b]
                        c ^= kernel[b]
                    if table.bit_count() not in (2016, 2080):
                        continue
                    for chi in spectrum_tests[1:]:
                        if (table ^ chi).bit_count() not in (2016, 2080):
                            break
                    else:
                        assert direct_walsh(table)
                        output.write(f"{index}\t{top}\t{c}\n")
                        report["normalized_bent"] += 1
    report["seconds"] = round(perf_counter() - start, 3)
    return report


def main():
    p = argparse.ArgumentParser()
    p.add_argument("shard", type=int)
    p.add_argument("shards", type=int)
    p.add_argument("output", type=Path)
    p.add_argument("--index", type=int)
    a = p.parse_args()
    assert 0 <= a.shard < a.shards
    top_tables = [evaluate_orbit(o) for _, o in TOP]
    low_tables = [evaluate_orbit(o) for _, o in LOW]
    spectrum = frequencies()
    a.output.mkdir(parents=True, exist_ok=True)
    reports = []
    indices = range(a.shard, len(UPPER), a.shards) if a.index is None else [a.index]
    with (a.output / "bent.tsv").open("w") as output:
        for index in indices:
            result = exhaust(index, output, top_tables, low_tables, spectrum)
            reports.append(result)
            output.flush()
            (a.output / "reports.json").write_text(json.dumps(reports, indent=2) + "\n")
            print({k: v for k, v in result.items()
                   if k != "certificate_of_final_contradiction"}, flush=True)


if __name__ == "__main__":
    main()

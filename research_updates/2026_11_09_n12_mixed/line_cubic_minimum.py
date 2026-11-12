"""Find an exact minimum number of mod-8 rows given the mod-4 equations."""
import argparse
import json
from collections import Counter
from functools import lru_cache
from pathlib import Path

from line_cubic_ablation import residual_systems
from lower_dim_model import active_indices


def truth_tables(dimension, polynomials):
    full = (1 << (1 << dimension)) - 1
    coordinates = [full ^ (full // ((1 << (1 << i)) + 1)) for i in range(dimension)]
    monomials = {0: full}
    for polynomial in polynomials:
        table = 0
        for monomial in polynomial:
            if monomial not in monomials:
                mask = full
                for i in active_indices(monomial):
                    mask &= coordinates[i]
                monomials[monomial] = mask
            table ^= monomials[monomial]
        yield table


def minimum_cover(dimension, quadratics, cubics):
    tables = iter(truth_tables(dimension, quadratics + cubics))
    remaining = (1 << (1 << dimension)) - 1
    for _ in quadratics:
        remaining &= ~next(tables)
    by_table = {}
    for index, table in enumerate(tables):
        if table & remaining:
            by_table.setdefault(table & remaining, index)
    ordered = sorted(by_table, key=lambda table: -table.bit_count())
    maximal = []
    for table in ordered:
        if all(table & ~previous for previous in maximal):
            maximal.append(table)
    rows = [tuple(table for table in maximal if table >> index & 1)
            for index in active_indices(remaining)]
    point_options = dict(zip(active_indices(remaining), rows))
    assert rows and all(rows)

    @lru_cache(maxsize=None)
    def solve(uncovered):
        if not uncovered:
            return ()
        options = min((point_options[i] for i in active_indices(uncovered)), key=len)
        return min(((by_table[table],) + solve(uncovered & ~table) for table in options),
                   key=lambda selection: (len(selection), selection))

    optimum = solve(remaining)
    return sorted(optimum), remaining.bit_count(), solve.cache_info().currsize


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--tasks", type=Path, required=True)
    parser.add_argument("--reference", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    reference = json.loads(args.reference.read_text())
    records = []
    for code, polar, dimension, quadratics, tagged in residual_systems(args.tasks, reference, 0, 1):
        cubics = list(tagged)
        optimum, phase_count, states = minimum_cover(dimension, quadratics, cubics)
        records.append({
            "map_code": code, "polar": f"{polar:0240x}", "dimension_mod4": dimension,
            "quadratic_solutions": phase_count, "minimum": len(optimum), "cover_states": states,
            "core": [{"moments": sorted(tagged[cubics[i]]), "polynomial": sorted(cubics[i])}
                     for i in optimum],
        })
    assert len(records) == 55
    summary = {
        "minimum_core_sizes": dict(sorted(Counter(r["minimum"] for r in records).items())),
        "largest_cover_search": max(r["cover_states"] for r in records),
        "details": records,
    }
    args.output.write_text(json.dumps(summary, indent=2) + "\n", encoding="utf-8")
    print({k: v for k, v in summary.items() if k != "details"})


if __name__ == "__main__":
    main()

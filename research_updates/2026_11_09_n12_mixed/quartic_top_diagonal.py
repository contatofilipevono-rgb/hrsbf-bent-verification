"""Check whether the leading quartic part decides the antipodal condition."""
import argparse
import csv
import json
from collections import Counter
from pathlib import Path

from higher_filter import evaluate_orbit, xor_terms
from higher_project import TOP
from mobius_rule import integer_anf
from quartic_m_catalog import kernel_basis


def obstruction_columns():
    coordinates = [(z ^ w) | (w << 6) for w in range(64) for z in range(64)]
    positions = [m for m in range(4096) if m.bit_count() == 4 and (m >> 6).bit_count() >= 2]
    columns = []
    for _, orbit in TOP:
        f = evaluate_orbit(orbit)
        transformed = sum(((f >> x) & 1) << i for i, x in enumerate(coordinates))
        coefficients = integer_anf(transformed)
        columns.append(sum((coefficients[m] & 1) << i for i, m in enumerate(positions)))
    return columns


def main():
    p = argparse.ArgumentParser()
    p.add_argument('catalog_index', type=Path)
    p.add_argument('m_subspace_report', type=Path)
    p.add_argument('output', type=Path)
    a = p.parse_args()
    columns = obstruction_columns()
    off_diagonal = {r['top'] for r in json.loads(a.m_subspace_report.read_text())['records']}
    counts = Counter()
    for row in csv.DictReader(a.catalog_index.open(newline=''), delimiter='\t'):
        top, completions, orbit_size = [int(row[k]) for k in ('top', 'count', 'orbit_size')]
        if top == 0 or completions == 0:
            continue
        off = bool(xor_terms(columns, top))
        assert off == (top in off_diagonal)
        label = 'outside_diagonal' if off else 'inside_diagonal'
        counts[f'{label}_top_representatives'] += 1
        counts[f'{label}_functions'] += 4 * completions * orbit_size
    result = {'linear_obstruction_rank': len(TOP) - len(kernel_basis(columns)), **counts}
    a.output.write_text(json.dumps(result, indent=2) + '\n')
    print(result)


if __name__ == '__main__':
    main()

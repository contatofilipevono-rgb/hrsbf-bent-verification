"""Recover every high-part orbit of an outside-diagonal quintic with quartic dual."""
import argparse
import json
from collections import Counter
from itertools import batched
from pathlib import Path

import numpy as np

from dual_catalog import dual_anf
from higher_filter import SIZE, evaluate_orbit, xor_terms
from higher_project import LOW, TOP, UPPER
from m_subspaces import find_m_subspace
from quartic_m_catalog import leading_kernels, rotate_kernels
from three_quintic_plan import generator_group


def raw_counts(source):
    tcols = [evaluate_orbit(o) for _, o in TOP]
    lcols = [evaluate_orbit(o) for _, o in LOW]
    quintic = [s for s, _ in UPPER[:66]]
    sextic = [s for s, _ in UPPER[66:]]
    counts = Counter()
    with source.open() as stream:
        for batch in batched(stream, 256):
            data = [tuple(map(int, s.split())) for s in batch]
            packed = b''.join((xor_terms(tcols, top) ^ xor_terms(lcols, low))
                              .to_bytes(SIZE // 8, 'little') for top, low, _ in data)
            dual = dual_anf(np.frombuffer(packed, dtype=np.uint64).reshape(len(batch), -1))
            assert not np.any(dual[:, sextic])
            codes = np.packbits(dual[:, quintic], axis=1, bitorder='little')
            for code, (_, _, size) in zip(codes, data, strict=True):
                mask = int.from_bytes(code.tobytes(), 'little')
                if mask:
                    counts[mask] += size
    return counts


def classify(counts):
    group = generator_group(66)
    records = []
    remaining = set(counts)
    while remaining:
        seed = min(remaining)
        orbit = {xor_terms(columns, seed) for columns in group}
        seen = remaining & orbit
        remaining -= seen
        weight = sum(counts[v] for v in seen)
        assert weight % len(orbit) == 0
        representative = min(orbit, key=lambda v: (v.bit_count(), v))
        basis, _ = find_m_subspace(rotate_kernels(leading_kernels(representative, UPPER[:66])))
        records.append({'mask': representative, 'min_quintic_orbits': representative.bit_count(),
                        'orbit_size': len(orbit), 'normalized_quartic_duals': weight // len(orbit),
                        'observed_high_masks': len(seen),
                        'leading_part_rules_out_m_subspace': basis is None})
    return sorted(records, key=lambda r: (r['min_quintic_orbits'], r['mask']))


def main():
    p = argparse.ArgumentParser()
    p.add_argument('outside_quartic_catalog', type=Path)
    p.add_argument('output', type=Path)
    a = p.parse_args()
    counts = raw_counts(a.outside_quartic_catalog)
    result = classify(counts)
    assert 4 * sum(r['orbit_size'] * r['normalized_quartic_duals'] for r in result) == 19034112
    distribution = Counter(r['min_quintic_orbits'] for r in result)
    a.output.write_text(json.dumps({'classes': result, 'sparsity_distribution': distribution}, indent=2) + '\n')
    print('Positive high orbits', len(result), 'distribution', dict(distribution))


if __name__ == '__main__':
    main()

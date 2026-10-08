#!/usr/bin/env python3
"""Independent direct-ANF checks and exhaustive small-dimensional controls."""
import argparse
import itertools
import json
from pathlib import Path

import numpy as np
from pesquisa_fibras_loop import Evaluator, make_tables


def fwht(table):
    spectrum = 1 - 2 * np.asarray(table, dtype=np.int32)
    step = 1
    while step < len(spectrum):
        for start in range(0, len(spectrum), 2 * step):
            left = spectrum[start:start+step].copy()
            right = spectrum[start+step:start+2*step].copy()
            spectrum[start:start+step] = left + right
            spectrum[start+step:start+2*step] = left - right
        step *= 2
    return spectrum


def directly_evaluate(coefficients, orbits, x):
    value = 0
    for coefficient, (_, orbit) in zip(coefficients, orbits):
        if coefficient:
            for support in orbit:
                value ^= int(all(x >> i & 1 for i in support))
    return value


def small_controls(backend):
    records = []
    for degree in (3, 5):
        n = 8
        orbits, basis, indices = make_tables(n, degree)
        coefficients = np.asarray([[c >> i & 1 for i in range(len(orbits))]
                                   for c in range(1, 1 << len(orbits))], dtype=np.uint8)
        engine = Evaluator(basis, indices, backend)
        weights, derivatives = engine.evaluate(coefficients)
        bent_count = semibent_count = 0
        for row, coeff in enumerate(coefficients):
            table = np.asarray([directly_evaluate(coeff, orbits, x) for x in range(256)], dtype=np.uint8)
            if not np.array_equal(weights[row], table[indices].sum(axis=1)):
                raise RuntimeError('Exhaustive direct-ANF fiber comparison failed')
            if derivatives[row] != np.bitwise_xor(table, table[::-1]).sum():
                raise RuntimeError('Exhaustive direct-ANF derivative comparison failed')
            spectrum = fwht(table)
            bent_count += bool(np.all(np.abs(spectrum) == 16))
            semibent_count += set(map(abs, spectrum.tolist())) == {0, 32}
        if bent_count or semibent_count:
            raise RuntimeError('Small control counts disagreed with recorded results')
        records.append({'n': n, 'degree': degree, 'nonzero_functions': len(coefficients),
                        'bent': bent_count, 'semibent_0_32': semibent_count,
                        'actual_backend': engine.backend, 'status': 'PASS'})
    # Positive bent control: q(x)=sum x_i*x_{i+4}. This tests the Walsh routine.
    positive = [sum(((x >> i) & 1) * ((x >> (i+4)) & 1) for i in range(4)) % 2
                for x in range(256)]
    if not np.all(np.abs(fwht(positive)) == 16):
        raise RuntimeError('Positive bent control failed')
    return {'status': 'PASS', 'controls': records, 'quadratic_bent_positive_control': 'PASS'}


def verify_round(folder, round_number):
    folder = Path(folder)
    summary = json.loads((folder / 'summary.json').read_text())
    config = summary['config']
    n, degree = config['n'], config['degree']
    orbits, basis, indices = make_tables(n, degree)
    data = np.load(folder / f'round_{round_number:04d}.npz')
    coefficients, weights = data['coefficients'], data['weights']
    failures = weights[:, 1:] != (1 << (n//2-1))
    closest = int(np.argmin(failures.sum(axis=1)))
    bad = np.flatnonzero(failures[closest])
    if not len(bad):
        return {'status': 'NEEDS_FULL_SPECTRAL_CHECK', 'row': closest}
    z = int(bad[0] + 1)
    # Independent monomial evaluator reconstructs the entire witness fiber.
    weight = sum(directly_evaluate(coefficients[closest], orbits, int(x)) for x in indices[z])
    if weight != int(weights[closest, z]) or weight == (1 << (n//2-1)):
        raise RuntimeError('Direct ANF witness verification failed')
    return {'status': 'PASS', 'row': closest, 'z': z, 'direct_anf_weight': weight,
            'balanced_weight_required': 1 << (n//2-1)}


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--backend', choices=('cpu', 'cuda', 'auto'), default='cpu')
    parser.add_argument('--folder')
    parser.add_argument('--round', type=int, default=1)
    parser.add_argument('--output', default='verificacao_loop.json')
    args = parser.parse_args()
    result = small_controls(args.backend)
    if args.folder:
        result['round_witness'] = verify_round(args.folder, args.round)
    Path(args.output).write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result, indent=2))

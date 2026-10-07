#!/usr/bin/env python3
"""Finite exact controls for v2 deductions; not a replacement for proofs."""
import hashlib
import itertools
import json
from pathlib import Path
import numpy as np


def orbit(mask, n):
    return sorted({((mask << k) | (mask >> (n-k))) & ((1 << n)-1) for k in range(n)})


def generators(n, degree):
    seen = set()
    for indices in itertools.combinations(range(n), degree):
        mask = sum(1 << i for i in indices)
        if mask not in seen:
            terms = orbit(mask, n)
            seen.update(terms)
            yield terms


def evaluate(terms, inputs):
    value = np.zeros(inputs.shape, dtype=np.int64)
    for term in terms:
        value ^= ((inputs & term) == term).astype(np.int64)
    return value


def walsh(values):
    out = 1 - 2*values.copy()
    h = 1
    while h < len(out):
        blocks = out.reshape(-1, 2*h)
        left, right = blocks[:, :h].copy(), blocks[:, h:].copy()
        blocks[:, :h], blocks[:, h:] = left+right, left-right
        h *= 2
    return out


def run():
    diagonal = []
    for n in range(2, 17, 2):
        m = n//2
        u = np.arange(1 << m, dtype=np.int64)
        inputs = u | (u << m)
        parity = np.array([int(i).bit_count() % 2 for i in u])
        checked = 0
        for degree in range(1, 4):
            for terms in generators(n, degree):
                antipodal = degree == 2 and ((1 | (1 << m)) in terms)
                expected = parity if antipodal else np.zeros(len(u), dtype=np.int64)
                assert np.array_equal(evaluate(terms, inputs), expected)
                checked += 1
        diagonal.append({'n':n, 'orbit_generators_checked':checked,
                         'diagonal_points_per_generator':len(u)})
    construction = []
    for n,t in [(10,2),(12,4),(18,6)]:
        m,r = n//2,n//t
        assert r % 2 == 1
        inputs = np.arange(1 << n, dtype=np.int64)
        paired = (inputs ^ (inputs >> m)) & ((1 << m)-1)
        p_terms = [((1 << i) | (1 << (i+m))) for i in range(m)]
        for degree in [4,5]:
            terms = orbit((1 << degree)-1, m)
            values = evaluate(p_terms,inputs) ^ evaluate(terms,paired)
            spec = walsh(values)
            assert set(np.abs(spec)) == {1 << m}
            y = np.arange(1 << t, dtype=np.int64)
            repeated = sum(y << (k*t) for k in range(r))
            restriction = values[repeated]
            v = (y ^ (y >> (t//2))) & ((1 << (t//2))-1)
            repeated_v = sum(v << (k*(t//2)) for k in range(r))
            predicted = evaluate([((1 << i)|(1 << (i+t//2))) for i in range(t//2)], y) ^ evaluate(terms,repeated_v)
            assert np.array_equal(restriction,predicted)
            assert set(np.abs(walsh(restriction))) == {1 << (t//2)}
            construction.append({'n':n,'t':t,'odd_repetitions':r,
                                 'gamma_degree':degree,'full_bent':True,
                                 'restriction_bent':True,'formula_matches':True})
    return {'status':'PASS','diagonal_basis_checks':diagonal,
            'tang_first_family_controls':construction,
            'scope':'Finite controls only. Diagonal formula checked on every degree<=3 orbit generator for even n<=16. Pair-sum restriction checked on six degree4/5 constructions. No general quartic transfer claimed.',
            'source_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}


if __name__ == '__main__':
    report=run()
    target=Path(__file__).with_name('literature_controls_2026-10-07.json')
    target.write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps(report,indent=2))

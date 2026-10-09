"""Count literal cubic classes covered by Meng--Chen--Fu, Theorems 11--13.
Does not check affine equivalents or claim global novelty.
Requires Python 3.10+, standard library only.
"""
from itertools import combinations
from pathlib import Path
import json

def count(n):
    orbits = {frozenset(tuple(sorted((i+k) % n for i in support))
                        for k in range(n))
              for support in combinations(range(n), 3)}
    within = 0
    for orbit in orbits:
        a, b, c = min(orbit)
        if max(b-a, c-b, n+a-c) <= n//2:
            within += 1
    q = len(orbits)
    if not (0 < within < q and q > 1):
        raise RuntimeError('Union formula requires both types of orbit.')
    covered = (2**within - 1) + (q-within) + 1
    return {'n': n, 'cubic_orbits': q,
            'orbits_with_max_circular_gap_at_most_half': within,
            'nonzero_cubic_RS_functions': 2**q-1,
            'direct_union_Theorems_11_12_13': covered,
            'outside_direct_union': 2**q-1-covered}

if __name__ == '__main__':
    results = {'scope': 'Literal original-coordinate criteria only; no affine-equivalence or novelty test.',
               'records': [count(16), count(32)]}
    if [(x['cubic_orbits'], x['orbits_with_max_circular_gap_at_most_half'])
        for x in results['records']] != [(35,14),(155,50)]:
        raise RuntimeError('Unexpected orbit counts.')
    output = json.dumps(results, indent=2) + '\n'
    Path(__file__).with_suffix('.json').write_text(output)
    print(output, end='')

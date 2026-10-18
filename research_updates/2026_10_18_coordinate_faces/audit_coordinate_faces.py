"""Exact H(12,4) coverage by the seven-coordinate zero-subspace criterion.

Counts coefficient vectors, including zero. No Lean claim is made.
"""
from pathlib import Path
from functools import lru_cache
from itertools import combinations
from collections import Counter
import hashlib
import json
import time
import argparse

def maximal(masks):
    result = []
    for mask in sorted(set(masks), key=int.bit_count, reverse=True):
        if not any(mask & prior == mask for prior in result):
            result.append(mask)
    return tuple(sorted(result))

@lru_cache(None)
def count_union(families):
    if not families:
        return 0
    if len(families) == 1:
        return 1 << families[0].bit_count()
    universe = 0
    for mask in families:
        universe |= mask
    candidates = [1 << i for i in range(universe.bit_length()) if universe >> i & 1]
    bit = min(candidates, key=lambda b: abs(2*sum(bool(m & b) for m in families)-len(families)))
    zeros = maximal(m & ~bit for m in families)
    ones = maximal(m & ~bit for m in families if m & bit)
    return count_union(zeros) + count_union(ones)

start = time.monotonic()
seen, orbits = set(), []
for monomial in combinations(range(12), 4):
    if monomial in seen:
        continue
    orbit = sorted({tuple(sorted((i+s)%12 for i in monomial)) for s in range(12)})
    seen.update(orbit)
    orbits.append(orbit)
assert len(orbits) == 43 and len(seen) == 495
records = []
for face in combinations(range(12), 7):
    subset = set(face)
    allowed = sum(1 << i for i, orbit in enumerate(orbits) if not any(set(m) <= subset for m in orbit))
    records.append({'coordinates': face, 'allowed_orbit_mask': allowed, 'dimension': allowed.bit_count()})
families = maximal(r['allowed_orbit_mask'] for r in records)
total = count_union(families)
states = count_union.cache_info().currsize

# Independent inclusion-exclusion, merging identical intersections.
terms = {}
for mask in families:
    delta = {mask: 1}
    for intersection, coefficient in list(terms.items()):
        key = intersection & mask
        delta[key] = delta.get(key, 0)-coefficient
    for intersection, coefficient in delta.items():
        terms[intersection] = terms.get(intersection, 0)+coefficient
        if terms[intersection] == 0:
            del terms[intersection]
    assert len(terms) < 200000, 'Avoid excessive local memory use'
independent_total = sum(coefficient*(1 << intersection.bit_count()) for intersection, coefficient in terms.items())
assert total == independent_total

# Exhaustive projected 12-coefficient control for both membership and counting.
projection = (1 << 12)-1
projected = maximal(m & projection for m in families)
direct = sum(any(c & m == c for m in projected) for c in range(1 << 12))
assert direct == count_union(projected)

sun_mask = sum(1 << i for i, orbit in enumerate(orbits) if all(sum(j % 2 for j in monomial) == 2 for monomial in orbit))
assert sun_mask.bit_count() == 20
assert any(sun_mask & m == sun_mask for m in families)

report = {
    'status': 'PASS_TWO_EXACT_COUNTS_AND_PROJECTED_EXHAUSTIVE_CONTROL',
    'scope': 'Seven-coordinate zero-subspace obstruction only; does not establish global nonexistence or novelty.',
    'n': 12, 'degree': 4, 'orbit_representatives': [o[0] for o in orbits],
    'orbit_lengths': dict(Counter(map(len, orbits))),
    'faces_tested': len(records), 'distinct_maximal_coefficient_spaces': len(families),
    'dimensions': dict(sorted(Counter(m.bit_count() for m in families).items())),
    'coefficient_vectors_excluded_including_zero': total,
    'total_coefficient_vectors': 1 << 43,
    'coefficient_vectors_not_decided_by_this_criterion': (1 << 43)-total,
    'fraction_excluded': total/(1 << 43),
    'shannon_states': states, 'inclusion_exclusion_terms': len(terms),
    'sun_theorem4_item1': {'dimension': 20, 'count_including_zero': 1 << 20, 'contained_in_union': True, 'allowed_orbit_mask': sun_mask},
    'zero_subspace_dimension': 7, 'nonlinearity_upper_bound': 1984, 'bent_nonlinearity': 2016,
    'faces': records, 'maximal_masks': families, 'seconds': time.monotonic()-start,
    'script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
}
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--out', type=Path, default=Path(__file__).resolve().parent/'outputs/literature_review')
out = parser.parse_args().out
out.mkdir(parents=True, exist_ok=True)
(out/'COORDINATE_FACE_COVERAGE.json').write_text(json.dumps(report, indent=2), encoding='utf-8')
print(json.dumps({k:v for k,v in report.items() if k not in ['faces','maximal_masks','orbit_representatives']}))

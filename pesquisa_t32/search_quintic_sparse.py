#!/usr/bin/env python3
"""Exhaustive sparse-support fiber exclusions in n=16 (not a global proof)."""
import argparse
from collections import Counter
import hashlib
import itertools
import json
import math
from pathlib import Path
import time

import compressed_quintic_constraints as compressed
import audit_quintic_candidate_constraints as full


def search(max_terms):
    if not 0 <= max_terms <= 3:
        raise ValueError('this bounded experiment supports max_terms from 0 through 3')
    started = time.monotonic()
    orbits, reps, periods, basis = compressed.build_basis()
    # Every class is checked; order only affects early rejection speed.
    order = [reps.index(z) for z in [1, 17, 255]]
    order += [i for i in range(len(reps)) if i not in order]
    columns = [[row[j] for row in basis] for j in order]
    witnesses = {}
    counts = []
    survivors = []
    for size in range(max_terms+1):
        rejected = Counter()
        tested = 0
        size_survivors = 0
        for support in itertools.combinations(range(len(basis)), size):
            tested += 1
            for j, column in zip(order, columns):
                value = 0
                for i in support:
                    value ^= column[i]
                weight = value.bit_count()
                if weight != 128:
                    rejected[hex(reps[j])] += 1
                    witnesses.setdefault((size, reps[j]), (support, weight))
                    break
            else:
                size_survivors += 1
                survivors.append(hex(sum(1 << i for i in support)))
        assert tested == math.comb(273, size)
        assert sum(rejected.values())+size_survivors == tested
        counts.append({'active_orbits':size, 'tested':tested,
                       'rejected_by_first_unbalanced_fiber':dict(rejected),
                       'fiber_survivors':size_survivors})
        print(json.dumps(counts[-1]), flush=True)

    # Independent full-table validation of a witness for every populated
    # rejection bucket. It checks the exact fiber weight, not a second filter.
    tables = full.orbit_truth_tables(full.cyclic_orbits())
    basis_checks = 0
    for i, truth in enumerate(tables):
        raw = truth.to_bytes(full.SIZE//8, "little")
        for j, z in enumerate(reps):
            exact = sum(((raw[(u | ((u ^ z) << 8)) >> 3] >> ((u | ((u ^ z) << 8)) & 7)) & 1) << u for u in range(256))
            assert exact == basis[i][j], (i, z)
            basis_checks += 1
    checked = []
    for (size, z), (support, expected) in witnesses.items():
        truth = 0
        for i in support:
            truth ^= tables[i]
        raw = truth.to_bytes(full.SIZE//8, 'little')
        obtained = full.fiber_weight(raw, z)
        assert obtained == expected and obtained != 128
        checked.append({'active_orbits':size, 'support':support,
                        'fiber':hex(z), 'weight':obtained})

    root = Path(__file__).resolve().parent
    return {'status':'COMPLETE', 'n':16, 'homogeneous_degree':5,
            'zero_function_included':True, 'basis_orbits':273,
            'max_active_orbits':max_terms, 'expected':sum(math.comb(273,i) for i in range(max_terms+1)),
            'tested':sum(r['tested'] for r in counts),
            'fiber_representatives_in_test_order':[hex(reps[j]) for j in order],
            'counts':counts, 'fiber_survivor_masks':survivors,
            'independent_witness_checks':checked,
            'independent_basis_fiber_bitstrings_checked':basis_checks,
            'elapsed_seconds':time.monotonic()-started,
            'source_sha256':{name:hashlib.sha256((root/name).read_bytes()).hexdigest()
               for name in ['search_quintic_sparse.py','compressed_quintic_constraints.py',
                            'audit_quintic_candidate_constraints.py']},
            'scope':'Exhaustive only over supports with at most max_active_orbits distinct cyclic quintic monomial orbits. A fiber survivor is not certified bent. No global degree-5 theorem.'}


if __name__ == '__main__':
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--max-terms',type=int,default=3)
    ap.add_argument('--output',default='quintic_sparse_support_result.json')
    args = ap.parse_args()
    report = search(args.max_terms)
    Path(args.output).write_text(json.dumps(report,indent=2)+'\n')

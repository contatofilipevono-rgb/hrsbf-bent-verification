#!/usr/bin/env python3
"""Deterministic differential validation; not a global nonexistence search."""
import hashlib
import json
import random
from pathlib import Path
import compressed_quintic_constraints as compressed
import audit_quintic_candidate_constraints as full


def main():
    rng = random.Random(20261007)
    maximum = (1 << 273)-1
    masks = [0, 1, 1 << 272, maximum, 0x602809]
    masks += [rng.getrandbits(273) for _ in range(27)]
    orbits = full.cyclic_orbits()
    tables = full.orbit_truth_tables(orbits)
    corbits, reps, periods, basis = compressed.build_basis()
    assert [r for r, _ in orbits] == [r for r, _ in corbits]
    assert sum(periods) == 255
    invalid_rejected = 0
    for invalid in [-1, 1 << 273]:
        for auditor in [compressed.audit, full.audit]:
            try:
                auditor(invalid)
            except ValueError:
                invalid_rejected += 1
            else:
                raise AssertionError('invalid mask accepted')
    records = []
    for mask in masks:
        c = compressed.audit(mask)
        truth = 0
        for i, table in enumerate(tables):
            if (mask >> i) & 1:
                truth ^= table
        raw = truth.to_bytes(full.SIZE//8, 'little')
        weights = {z: full.fiber_weight(raw, z) for z in range(256)}
        assert weights[0] == 0
        assert truth.bit_count() == c['total_weight'] == sum(weights.values())
        for z in range(1, 256):
            representative = compressed.canonical_rotation(z)
            assert weights[z] == c['fiber_class_weights'][hex(representative)]
        assert sum(weights[z] != 128 for z in range(1,256)) == c['bad_nonzero_fibers']
        for direction in reps:
            exact = full.derivative_weight(raw, direction | (direction << 8))
            assert exact == c['diagonal_derivative_class_weights'][hex(direction)]
        records.append({'mask':hex(mask), 'total_weight':truth.bit_count(),
                        'bad_nonzero_fibers':c['bad_nonzero_fibers'], 'status':'PASS'})
    root = Path(__file__).resolve().parent
    report = {'status':'PASS', 'seed':20261007, 'candidate_count':len(masks),
              'all_255_nonzero_fibers_per_candidate':True,
              'all_35_diagonal_derivative_classes_per_candidate':True,
              'invalid_masks_rejected':invalid_rejected,
              'source_sha256':{name:hashlib.sha256((root/name).read_bytes()).hexdigest()
                  for name in ['compressed_quintic_constraints.py',
                               'audit_quintic_candidate_constraints.py',
                               'validate_quintic_batch.py']},
              'records':records,
              'scope':'Implementation differential validation of 32 fixed candidates, not exhaustive over 2^273 functions and not a nonexistence proof.'}
    (root/'quintic_batch_validation_2026-10-07.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps({k:v for k,v in report.items() if k not in ['records','source_sha256']},indent=2))


if __name__ == '__main__':
    main()

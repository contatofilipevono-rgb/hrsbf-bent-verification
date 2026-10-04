#!/usr/bin/env python3
"""Differential checks of fiber substitution, radicals and certificate rows.

The direct ANF truth-table oracle does not use symbolic substitution or Gray sums.
The original seven-fiber checker separately validates the fixed-family projection.
"""
import hashlib
import json
import random
import time
from pathlib import Path
from verificar_fibras_exato import (require, orbit, orbit_representatives, evaluate,
    lift, parse_candidate, fiber_polynomial, polar_rows, radical_basis, sign_sum,
    inspect_fiber)

def main():
    start = time.perf_counter()
    rng = random.Random(20261004)
    reps = orbit_representatives()
    require(len(reps) == 155, 'Wrong cubic orbit count.')
    polys = [orbit(s) for s in reps]
    require(sum(map(len, polys)) == 4960, 'Not all cubic monomials represented.')
    differential = 0
    polar_checks = 0
    for case in range(12):
        selected = rng.sample(reps, case*2)
        poly, _ = parse_candidate({'n': 32, 'coordinate_base': 0,
                                  'sanf': [list(s) for s in selected]})
        require(not fiber_polynomial(poly, 0), 'Nonzero diagonal.')
        for _ in range(8):
            z = rng.randrange(1, 65536)
            q = fiber_polynomial(poly, z)
            entry = inspect_fiber(poly, z)
            rows = polar_rows(q)
            for _ in range(24):
                u = rng.randrange(65536)
                require(evaluate(q, u) == evaluate(poly, lift(u,z)), 'Substitution mismatch.')
                differential += 1
                v = rng.randrange(65536)
                direct = (evaluate(poly, lift(u^v,z)) ^ evaluate(poly,lift(u,z))
                          ^ evaluate(poly,lift(v,z)) ^ evaluate(poly,lift(0,z)))
                matrix = sum((rows[i] & v).bit_count() for i in range(16) if u >> i & 1) & 1
                require(direct == matrix, 'Polar mismatch.')
                polar_checks += 1
            if case in (0, 1, 11):
                require(abs(sign_sum(q)) == entry['absolute_sign_sum'], 'Radical criterion mismatch.')
    # Exhaustive direct 32-variable ANF evaluation on one complete coset.
    z = 2261
    poly = polys[0]
    q = fiber_polynomial(poly, z)
    direct_sum = 0
    for u in range(65536):
        value = evaluate(poly, lift(u,z))
        require(value == evaluate(q,u), 'Full-coset substitution mismatch.')
        direct_sum += 1-2*value
    require(direct_sum == sign_sum(q), 'Signed Gray sum differs from direct ANF oracle.')
    # Explicit degenerate, constant and full-rank quadratic sum controls.
    controls = []
    for q, expected in [(frozenset(),65536), (frozenset({0}),-65536),
                        (frozenset({1}),0), (frozenset({3}),32768),
                        (frozenset((1<<(2*i)) | (1<<(2*i+1)) for i in range(8)),256)]:
        actual = sign_sum(q)
        require(actual == expected, 'Quadratic sum control failed.')
        controls.append(actual)
    # Recompute all seven certificate rows from original orbit substitutions.
    certificate_path = Path(__file__).with_name('certificado_7_fibras.json')
    cert = json.loads(certificate_path.read_bytes())
    require(cert['h'] == '0x1' and cert['equation_count'] == 7, 'Unexpected certificate.')
    xor_rows = 0
    xor_rhs = 0
    ranks = []
    for eq in cert['equations']:
        require(eq['kind'] == 'fiber' and eq['rhs'] == 1, 'Unsupported certificate equation.')
        z, r = eq['z'], eq['r']
        row = 0
        for j, poly in enumerate(polys):
            q = fiber_polynomial(poly,z)
            if evaluate(q,r) ^ evaluate(q,0):
                row |= 1 << j
        require(row == int(eq['row'],16), 'Certificate row differs from substituted ANFs.')
        q = fiber_polynomial(polys[0],z)
        B = polar_rows(q)
        rank, _ = radical_basis(B)
        require(rank == 14 and r not in (0,z), 'Rank-14 radical premise failed.')
        require(all((line & r).bit_count() % 2 == 0 for line in B), 'Incorrect certificate radical.')
        require(all((line & z).bit_count() % 2 == 0 for line in B), 'Incorrect half-turn radical.')
        ranks.append(rank)
        xor_rows ^= row
        xor_rhs ^= eq['rhs']
    require(xor_rows == 0 and xor_rhs == 1, 'Certificate does not form XOR contradiction.')
    # Reject ambiguous or nonhomogeneous input instead of silently changing it.
    rejected_inputs = 0
    for invalid in [[ [0,1,2],[1,2,3] ], [[0,0,1]], [[0,1]], [[0,1,32]]]:
        try:
            parse_candidate({'n':32,'coordinate_base':0,'sanf':invalid})
        except ValueError:
            rejected_inputs += 1
        else:
            raise RuntimeError('Invalid SANF accepted.')
    result = {'status':'passed', 'differential_ANF_points':differential,
              'differential_polar_pairs':polar_checks, 'full_coset_points':65536,
              'direct_coset_sign_sum':direct_sum, 'quadratic_sum_controls':controls,
              'original_orbits':155,'reconstructed_certificate_rows':7,
              'certificate_sha256':hashlib.sha256(certificate_path.read_bytes()).hexdigest(),
              'certificate_representative_ranks':ranks, 'XOR_rows':xor_rows,'XOR_rhs':xor_rhs,
              'invalid_inputs_rejected':rejected_inputs,
              'scope':'Differential implementation checks and seven row reconstruction; use verificar_7_fibras.py for the full fixed-H family proof.',
              'seconds':round(time.perf_counter()-start,3)}
    Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2))

if __name__ == '__main__':
    main()

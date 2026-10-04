#!/usr/bin/env python3
"""Exact necessary bentness tests for homogeneous cubic RS functions on 32 bits.

Python 3.10+, standard library only. Coordinates in SANF input are zero-based.
Passing fibers is not a bentness certificate, even if all cosets are checked.
"""
import argparse
import hashlib
import json
from itertools import combinations
from pathlib import Path

N = 16

def require(ok, message):
    if not ok:
        raise ValueError(message)

def orbit(triple, dimension=32):
    return frozenset(sum(1 << ((i+k) % dimension) for i in triple)
                     for k in range(dimension))

def canonical(triple, dimension=32):
    return min(tuple(sorted((i+k) % dimension for i in triple))
               for k in range(dimension))

def orbit_representatives(dimension=32):
    return sorted({canonical(s, dimension) for s in combinations(range(dimension), 3)})

def parse_candidate(data):
    require(isinstance(data, dict) and data.get('n') == 32, 'Expected n=32.')
    require(data.get('coordinate_base') == 0, 'Specify coordinate_base=0.')
    supports = data.get('sanf')
    require(isinstance(supports, list), 'sanf must be a list of cubic supports.')
    representatives = []
    for support in supports:
        require(isinstance(support, list) and len(support) == 3,
                'Each support must have exactly three coordinates.')
        require(all(type(i) is int and 0 <= i < 32 for i in support),
                'Coordinates must be integers in 0..31.')
        require(len(set(support)) == 3, 'Repeated coordinates are not cubic.')
        representatives.append(canonical(support))
    require(len(set(representatives)) == len(representatives),
            'Duplicate orbit representatives; provide each orbit once.')
    poly = set()
    for support in representatives:
        poly.update(orbit(support))
    return frozenset(poly), sorted(representatives)

def evaluate(poly, x):
    return sum((x & mask) == mask for mask in poly) & 1

def lift(u, z):
    return u | ((u ^ z) << N)

def fiber_polynomial(poly, z):
    """Substitute x=(u,u+z) in ANF; expand over F2 with u_i^2=u_i."""
    require(type(z) is int and 0 <= z < (1 << N), 'z must be a 16-bit integer.')
    result = set()
    for mask in poly:
        terms = {0}
        while mask:
            bit = mask & -mask
            index = bit.bit_length()-1
            mask ^= bit
            variable = 1 << (index % N)
            factor = (variable, 0) if index >= N and z & variable else (variable,)
            next_terms = set()
            for a in terms:
                for b in factor:
                    term = a | b
                    if term in next_terms:
                        next_terms.remove(term)
                    else:
                        next_terms.add(term)
            terms = next_terms
        result.symmetric_difference_update(terms)
    require(all(mask.bit_count() <= 2 for mask in result),
            'Fiber is not quadratic; the homogeneous RS premise failed.')
    return frozenset(result)

def polar_rows(q):
    rows = [0]*N
    for mask in q:
        if mask.bit_count() == 2:
            low = mask & -mask
            high = mask ^ low
            rows[low.bit_length()-1] |= high
            rows[high.bit_length()-1] |= low
    return rows

def radical_basis(rows):
    matrix = list(rows)
    pivots = []
    rank = 0
    for column in range(N):
        found = next((i for i in range(rank, N) if matrix[i] >> column & 1), None)
        if found is None:
            continue
        matrix[rank], matrix[found] = matrix[found], matrix[rank]
        for i in range(N):
            if i != rank and matrix[i] >> column & 1:
                matrix[i] ^= matrix[rank]
        pivots.append(column)
        rank += 1
    basis = []
    for free in sorted(set(range(N))-set(pivots)):
        vector = 1 << free
        for i, column in enumerate(pivots):
            if matrix[i] >> free & 1:
                vector |= 1 << column
        basis.append(vector)
    return rank, basis

def sign_sum(q, rows=None):
    """Exact sum over all 65,536 points, using Gray updates of quadratic q."""
    rows = polar_rows(q) if rows is None else rows
    linear = sum(mask for mask in q if mask.bit_count() == 1)
    x = 0
    value = int(0 in q)
    total = 1-2*value
    for step in range(1, 1 << N):
        bit = step & -step
        index = bit.bit_length()-1
        value ^= int(bool(linear & bit)) ^ ((rows[index] & x).bit_count() & 1)
        x ^= bit
        total += 1-2*value
    return total

def inspect_fiber(poly, z, enumerate_sum=False):
    q = fiber_polynomial(poly, z)
    rows = polar_rows(q)
    rank, basis = radical_basis(rows)
    require(rank % 2 == 0, 'Alternating polar must have even rank.')
    require(all(all((row & r).bit_count() % 2 == 0 for row in rows) for r in basis),
            'Incorrect reconstructed radical.')
    q0 = int(0 in q)
    values = [evaluate(q, r) ^ q0 for r in basis]
    balanced = any(values)
    require(evaluate(q, z) == q0, 'Half-turn constraint q(u+z)=q(u) failed.')
    require(all((row & z).bit_count() % 2 == 0 for row in rows),
            'Half-turn direction is not in the polar radical.')
    magnitude = 0 if balanced else 1 << (N-rank//2)
    result = {'z': z, 'polar_rank': rank, 'radical_dimension': N-rank,
              'radical_basis': basis, 'radical_linear_values': values,
              'balanced': balanced, 'absolute_sign_sum': magnitude,
              'quadratic_terms': sorted(q)}
    if enumerate_sum:
        total = sign_sum(q, rows)
        require(abs(total) == magnitude, 'Radical criterion disagrees with truth table.')
        result['sign_sum'] = total
    return result

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('candidate', type=Path, help='JSON with n=32, coordinate_base=0, sanf.')
    parser.add_argument('--z', action='append', type=lambda s: int(s, 0),
                        help='Nonzero fiber direction; repeat as needed. Default: 16 basis directions.')
    parser.add_argument('--all', action='store_true', help='Check all 65,535 nonzero fibers; stop on failure.')
    parser.add_argument('--enumerate-sum', action='store_true', help='Also enumerate each quadratic truth table.')
    parser.add_argument('--output', required=True, type=Path, help='Write the exact JSON report here.')
    args = parser.parse_args()
    require(not (args.all and args.z), '--all and --z are mutually exclusive.')
    raw = args.candidate.read_bytes()
    poly, sanf = parse_candidate(json.loads(raw))
    require(not fiber_polynomial(poly, 0), 'The candidate does not vanish on the diagonal.')
    directions = range(1, 1 << N) if args.all else (args.z or [1 << i for i in range(N)])
    require(args.all or all(0 < z < (1 << N) for z in directions), 'Directions must be in 1..65535.')
    results = []
    for z in directions:
        entry = inspect_fiber(poly, z, args.enumerate_sum)
        results.append(entry)
        if not entry['balanced']:
            break
    rejected = any(not r['balanced'] for r in results)
    report = {'candidate_sha256': hashlib.sha256(raw).hexdigest(), 'sanf': sanf,
              'selected_orbits': len(sanf), 'ANF_monomials': len(poly),
              'status': 'proved_non_bent_by_fiber' if rejected else 'necessary_fiber_conditions_passed',
              'all_nonzero_fibers_checked': args.all and len(results) == (1 << N)-1,
              'bentness_certified': False,
              'scope': 'An unbalanced nonzero coset excludes bentness. Passing these conditions is not sufficient to prove bentness.',
              'fibers': results}
    args.output.write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps({k: v for k, v in report.items() if k != 'fibers'}, indent=2))

if __name__ == '__main__':
    main()

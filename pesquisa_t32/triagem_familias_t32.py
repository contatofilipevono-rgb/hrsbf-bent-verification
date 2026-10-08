"""Rank-14 fiber contradictions for fixed 35-bit polar parameters in n=32.

Passing this screening does not certify bentness. Certificates exclude whole
120-dimensional coefficient families, not only a chosen representative.
Run from pesquisa_t32/ in the repository; Python 3.10+, standard library.
"""
import argparse
from itertools import combinations
import json
from pathlib import Path
import random
import sys
import time

ROOT = Path(__file__).resolve().parent.parent
if not (ROOT/'avanco_t32').is_dir():
    ROOT = Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'avanco_t32'))
from verificar_fibras_exato import (orbit_representatives, orbit, fiber_polynomial,
                                  polar_rows, radical_basis, require)

def model():
    reps32 = orbit_representatives(32)
    reps16 = orbit_representatives(16)
    lookup = {s:i for i,rep in enumerate(reps16)
              for s in (tuple(sorted((v+k)%16 for v in rep)) for k in range(16))}
    hrows = [0]*35
    assignment = []
    for j,rep in enumerate(reps32):
        reduced = tuple(sorted({v%16 for v in rep}))
        if len(reduced) == 3:
            target = lookup[reduced]
            hrows[target] |= 1<<j
            assignment.append(target)
        else:
            require(len(reduced) == 2,'Unexpected reduced degree.')
            assignment.append(None)
    require(len(reps32) == 155 and len(reps16) == 35,'Orbit counts failed.')
    require(all(r.bit_count() == 4 for r in hrows),'Expected four lifts per parameter.')
    require(sum(a is None for a in assignment) == 15,'Expected fifteen zero-polar orbits.')
    return reps32, reps16, hrows, assignment

def coefficient_forms(reps32,z,hrows):
    forms = {}
    for j,rep in enumerate(reps32):
        for term in fiber_polynomial(orbit(rep),z):
            forms[term] = forms.get(term,0) ^ (1<<j)
    # Every polar coefficient must depend only on the fixed H projection.
    for term,row in forms.items():
        if term.bit_count() != 2:
            continue
        reconstructed = 0
        for group in hrows:
            overlap = row & group
            require(overlap in (0,group),'Polar depends on free lift coefficients.')
            reconstructed |= overlap
        require(reconstructed == row,'Antipodal coefficient changes the polar.')
    return forms

def representative(h,hrows):
    return sum(group & -group for i,group in enumerate(hrows) if h>>i&1)

def family_fiber(h,hrows,forms):
    coefficients = representative(h,hrows)
    q = frozenset(term for term,row in forms.items() if (row & coefficients).bit_count()&1)
    B = polar_rows(q)
    rank,basis = radical_basis(B)
    return B,rank,basis

def linear_row(forms,r):
    row = 0
    for term,coefficients in forms.items():
        if term and (term & r) == term:
            row ^= coefficients
    return row

def solve_family(h,hrows,forms_by_z):
    pivots = {}
    equations = []
    rank14 = 0
    def add(row,rhs,description):
        index = len(equations)
        equations.append((row,rhs,description))
        origin = 1<<index
        while row:
            pivot = row.bit_length()-1
            if pivot not in pivots:
                pivots[pivot] = (row,rhs,origin)
                return None
            old,old_rhs,old_origin = pivots[pivot]
            row ^= old
            rhs ^= old_rhs
            origin ^= old_origin
        if rhs:
            selected = [eq for i,eq in enumerate(equations) if origin>>i&1]
            check_row = 0
            check_rhs = 0
            for a,b,_ in selected:
                check_row ^= a
                check_rhs ^= b
            require(check_row == 0 and check_rhs == 1,'Invalid reconstructed contradiction.')
            return [description for _,_,description in selected]
        return None
    for i,row in enumerate(hrows):
        require(add(row,(h>>i)&1,{'kind':'h','index':i}) is None,'H projection inconsistent.')
    for z,forms in forms_by_z.items():
        B,rank,basis = family_fiber(h,hrows,forms)
        require(all((row & z).bit_count()%2 == 0 for row in B),'Missing half-turn radical.')
        if rank != 14:
            continue
        rank14 += 1
        r = next(vector for vector in basis if vector != z)
        require(r not in (0,z),'Dependent radical directions.')
        certificate = add(linear_row(forms,r),1,{'kind':'fiber','z':z,'r':r})
        if certificate is not None:
            return {'h':hex(h),'status':'excluded_fixed_H_family',
                    'family_dimension':120,'rank14_fibers_processed':rank14,
                    'certificate':certificate}
    return {'h':hex(h),'status':'unresolved_by_sampled_rank14_conditions',
            'family_dimension':120,'rank14_fibers_processed':rank14}

def check_certificate(record,hrows,forms_by_z):
    h = int(record['h'],16)
    require(0 <= h < (1<<35),'Parameter exceeds 35 bits.')
    total_row = 0
    total_rhs = 0
    for eq in record['certificate']:
        if eq['kind'] == 'h':
            i = eq['index']
            require(type(i) is int and 0 <= i < 35,'Invalid parameter equation index.')
            row,rhs = hrows[i],(h>>i)&1
        else:
            require(eq['kind'] == 'fiber','Unknown equation kind.')
            z,r = eq['z'],eq['r']
            require(type(r) is int and 0 < r < 65536,'Invalid radical vector range.')
            forms = forms_by_z[z]
            B,rank,basis = family_fiber(h,hrows,forms)
            require(rank == 14 and r not in (0,z),'Certificate rank premise failed.')
            require(all((line & r).bit_count()%2 == 0 for line in B),'Incorrect radical vector.')
            # q(r)+q(0) is the required nonzero normalized evaluation.
            row,rhs = linear_row(forms,r),1
            # The other radical direction is identically zero for all coefficients.
            require(linear_row(forms,z) == 0,'Half-turn linear condition failed.')
        total_row ^= row
        total_rhs ^= rhs
    require(total_row == 0 and total_rhs == 1,'Certificate XOR does not give 0=1.')

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--limit',type=int,default=128)
    parser.add_argument('--output',type=Path,required=True)
    parser.add_argument('--check-only',type=Path,help='Reconstruct and check a saved batch.')
    args = parser.parse_args()
    start = time.perf_counter()
    reps32,reps16,hrows,_ = model()
    if args.check_only:
        report = json.loads(args.check_only.read_text())
        directions = report['directions']
        require(all(type(z) is int and 0 < z < 65536 for z in directions),'Invalid fiber directions.')
        parameters = [int(r['h'],16) for r in report['families']]
        require(len(parameters) == len(set(parameters)),'Duplicate tested parameter.')
        require(parameters[0] == 1 and all(0 < h < (1<<35) and h.bit_count() == 3
                for h in parameters[1:]),'Unexpected family list.')
        require(len(parameters)-1 == report['weight3_tested'],'Incorrect coverage count.')
    else:
        require(0 <= args.limit <= 6545,'Limit must be in 0..6545.')
        seed = random.Random(20261005)
        directions = {1<<i for i in range(16)}
        cert = json.loads((ROOT/'avanco_t32/certificado_7_fibras.json').read_text())
        directions.update(eq['z'] for eq in cert['equations'] if eq['kind'] == 'fiber')
        while len(directions) < 119:
            directions.add(seed.randrange(1,65536))
        directions = sorted(directions)
    forms_by_z = {z:coefficient_forms(reps32,z,hrows) for z in directions}
    if args.check_only:
        verified = 0
        for record in report['families']:
            if record['status'] == 'excluded_fixed_H_family':
                check_certificate(record,hrows,forms_by_z)
                verified += 1
        output = {'status':'certificates_verified','verified_families':verified,
                  'all_n32_cubics_excluded':False,'seconds':round(time.perf_counter()-start,3)}
    else:
        parameters = [1] + [sum(1<<i for i in indices)
                            for indices in list(combinations(range(35),3))[:args.limit]]
        records = []
        for h in parameters:
            record = solve_family(h,hrows,forms_by_z)
            if record['status'] == 'excluded_fixed_H_family':
                check_certificate(record,hrows,forms_by_z)
            records.append(record)
        require(records[0]['status'] == 'excluded_fixed_H_family','Known h=1 control failed.')
        excluded = sum(r['status'] == 'excluded_fixed_H_family' for r in records[1:])
        output = {'status':'screening_completed','seed':20261005,'directions':directions,
                  'parameter_order':'canonical cubic orbit representatives in 16 variables; lexicographic triples of indices',
                  'parameter_representatives_16':reps16,
                  'weight3_total_parameters':6545,'weight3_tested':args.limit,
                  'weight3_excluded':excluded,'weight3_unresolved':args.limit-excluded,
                  'known_h1_control':'excluded','all_n32_cubics_excluded':False,
                  'scope':'Each exclusion covers its 120-dimensional fixed-H family. Unresolved means only that these sampled rank-14 equations did not contradict; no bentness or novelty claim.',
                  'families':records,'seconds':round(time.perf_counter()-start,3)}
    args.output.write_text(json.dumps(output,indent=2)+'\n')
    print(json.dumps({k:v for k,v in output.items()
                      if k not in ('families','directions','parameter_representatives_16')},indent=2))

if __name__ == '__main__':
    main()

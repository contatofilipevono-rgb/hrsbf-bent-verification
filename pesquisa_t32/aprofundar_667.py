"""Extend fiber directions and test higher-dimensional radical obstructions.

Necessary conditions only. No SAT verdict or bentness certification is emitted.
"""
import argparse
import hashlib
import json
from pathlib import Path
import random
import time
from triagem_familias_t32 import (model, coefficient_forms, family_fiber,
                                 linear_row, solve_family, check_certificate)
from verificar_fibras_exato import require

class LinearSystem:
    def __init__(self):
        self.pivots = {}
        self.equations = []

    def reduce(self,row,rhs):
        while row:
            pivot = row.bit_length()-1
            if pivot not in self.pivots:
                break
            old,old_rhs = self.pivots[pivot]
            row ^= old
            rhs ^= old_rhs
        return row,rhs

    def add(self,row,rhs,description):
        self.equations.append(description)
        row,rhs = self.reduce(row,rhs)
        require(row or not rhs,'Unexpected inconsistent base equations.')
        if row:
            self.pivots[row.bit_length()-1] = row,rhs

    def implies_zero(self,row):
        # Missing high pivots can still leave lower pivots; eliminate all.
        rhs = 0
        for pivot in sorted(self.pivots,reverse=True):
            if row>>pivot&1:
                old,old_rhs = self.pivots[pivot]
                row ^= old
                rhs ^= old_rhs
        return row == 0 and rhs == 0

def lower_rank_test(h,hrows,forms_by_z):
    system = LinearSystem()
    for i,row in enumerate(hrows):
        system.add(row,(h>>i)&1,{'kind':'h','index':i})
    lower = []
    for z,forms in forms_by_z.items():
        B,rank,basis = family_fiber(h,hrows,forms)
        require(all((row&z).bit_count()%2 == 0 for row in B),'Missing half-turn radical.')
        require(linear_row(forms,z) == 0,'Nonzero half-turn evaluation.')
        if rank == 14:
            r = next(v for v in basis if v != z)
            system.add(linear_row(forms,r),1,{'kind':'fiber','z':z,'r':r})
        else:
            require(rank < 14 and rank%2 == 0,'Invalid polar rank.')
            lower.append((z,rank,basis))
    for z,rank,basis in lower:
        forms = forms_by_z[z]
        if all(system.implies_zero(linear_row(forms,r)) for r in basis):
            return {'h':hex(h),'status':'excluded_by_forced_zero_radical',
                    'family_dimension':120,'polar_rank':rank,'z':z,
                    'base_equations':system.equations,
                    'reason':'All normalized evaluations on a radical basis are forced to zero.'}
    return {'h':hex(h),'status':'unresolved_by_linear_and_forced_radical_conditions',
            'family_dimension':120,'linear_rank':len(system.pivots),
            'remaining_linear_dimension':155-len(system.pivots),
            'lower_rank_fibers_tested':len(lower),
            'polar_rank_counts':{str(k):sum(rank==k for _,rank,_ in lower)
                                 for k in sorted({rank for _,rank,_ in lower})}}

def verify_lower(record,hrows,forms_by_z):
    h = int(record['h'],16)
    require(0 <= h < 1<<35,'Invalid parameter.')
    system = LinearSystem()
    for eq in record['base_equations']:
        if eq['kind'] == 'h':
            i = eq['index']
            require(type(i) is int and 0 <= i < 35,'Invalid H index.')
            system.add(hrows[i],(h>>i)&1,eq)
        else:
            require(eq['kind'] == 'fiber','Unknown equation.')
            z,r = eq['z'],eq['r']
            require(type(r) is int and 0 < r < 65536,'Invalid radical direction.')
            B,rank,_ = family_fiber(h,hrows,forms_by_z[z])
            require(rank == 14 and r not in (0,z),'Invalid rank-14 premise.')
            require(all((line&r).bit_count()%2 == 0 for line in B),'Not in radical.')
            require(linear_row(forms_by_z[z],z) == 0,'Half-turn evaluation failed.')
            system.add(linear_row(forms_by_z[z],r),1,eq)
    z = record['z']
    _,rank,basis = family_fiber(h,hrows,forms_by_z[z])
    require(rank == record['polar_rank'] and rank < 14,'Wrong lower-rank premise.')
    require(all(system.implies_zero(linear_row(forms_by_z[z],r)) for r in basis),
            'Radical evaluations are not all forced to zero.')

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source',type=Path,required=True,help='Original complete weight-three batch JSON.')
    parser.add_argument('--directions',type=int,default=512)
    parser.add_argument('--output',type=Path,required=True)
    parser.add_argument('--check-only',type=Path)
    parser.add_argument('--remaining-from',type=Path,help='Continue only unresolved parameters of this previous stage.')
    parser.add_argument('--orbit-directions',action='store_true',help='Use all 4,115 nonzero rotation-orbit representatives.')
    args = parser.parse_args()
    start = time.perf_counter()
    raw = args.source.read_bytes()
    source = json.loads(raw)
    targets = [int(r['h'],16) for r in source['families']
               if r['status'] == 'unresolved_by_sampled_rank14_conditions']
    require(len(targets) == 667 and len(set(targets)) == 667,'Expected the original 667 targets.')
    require(all(h.bit_count() == 3 and h < 1<<35 for h in targets),'Invalid target parameter.')
    parent_sha = None
    if args.remaining_from:
        parent_raw = args.remaining_from.read_bytes()
        parent = json.loads(parent_raw)
        require(parent['source_sha256'] == hashlib.sha256(raw).hexdigest(),'Parent has another source.')
        retained = [int(r['h'],16) for r in parent['families']
                    if r['status'] == 'unresolved_by_linear_and_forced_radical_conditions']
        require(len(retained) == len(set(retained)) and all(h in targets for h in retained),'Invalid parent targets.')
        targets = retained
        parent_sha = hashlib.sha256(parent_raw).hexdigest()
    reps32,_,hrows,_ = model()
    if args.check_only:
        report = json.loads(args.check_only.read_text())
        require(report['source_sha256'] == hashlib.sha256(raw).hexdigest(),'Wrong source batch.')
        require(report.get('parent_sha256') == parent_sha,'Wrong parent batch.')
        directions = report['directions']
    else:
        require(119 <= args.directions <= 65535,'Direction count must be in 119..65535.')
        directions = set(source['directions'])
        if args.orbit_directions:
            seen = {0}
            representatives = []
            for z in range(1,65536):
                if z in seen:
                    continue
                orbit_values = []
                value = z
                for _ in range(16):
                    orbit_values.append(value)
                    value = ((value<<1)&65535)|(value>>15)
                seen.update(orbit_values)
                representatives.append(min(orbit_values))
            require(len(representatives) == 4115 and len(seen) == 65536,'Incomplete direction orbits.')
            directions = set(representatives)
        else:
            rng = random.Random(20261006)
            while len(directions) < args.directions:
                directions.add(rng.randrange(1,65536))
        directions = sorted(directions)
    require(all(type(z) is int and 0 < z < 65536 for z in directions),'Invalid fiber direction.')
    if args.check_only:
        needed = set()
        for record in report['families']:
            if record['status'] == 'excluded_fixed_H_family':
                needed.update(eq['z'] for eq in record['certificate'] if eq['kind'] == 'fiber')
            elif record['status'] == 'excluded_by_forced_zero_radical':
                needed.add(record['z'])
                needed.update(eq['z'] for eq in record['base_equations'] if eq['kind'] == 'fiber')
        require(needed.issubset(set(directions)),'Certificate uses an unlisted direction.')
        forms = {z:coefficient_forms(reps32,z,hrows) for z in sorted(needed)}
    else:
        forms = {z:coefficient_forms(reps32,z,hrows) for z in directions}
    if args.check_only:
        require([int(r['h'],16) for r in report['families']] == targets,'Target coverage differs.')
        verified = 0
        for record in report['families']:
            if record['status'] == 'excluded_fixed_H_family':
                check_certificate(record,hrows,forms)
                verified += 1
            elif record['status'] == 'excluded_by_forced_zero_radical':
                verify_lower(record,hrows,forms)
                verified += 1
            else:
                require(record['status'] == 'unresolved_by_linear_and_forced_radical_conditions','Unknown status.')
        result = {'status':'certificates_reconstructed','verified_families':verified,
                  'target_families':len(targets),'all_n32_cubics_excluded':False,
                  'seconds':round(time.perf_counter()-start,3)}
    else:
        records = []
        for index,h in enumerate(targets):
            record = solve_family(h,hrows,forms)
            if record['status'] == 'excluded_fixed_H_family':
                check_certificate(record,hrows,forms)
            else:
                record = lower_rank_test(h,hrows,forms)
                if record['status'] == 'excluded_by_forced_zero_radical':
                    verify_lower(record,hrows,forms)
            records.append(record)
            if (index+1)%100 == 0:
                print('Processed',index+1,'of',len(targets),flush=True)
        linear = sum(r['status'] == 'excluded_fixed_H_family' for r in records)
        lower = sum(r['status'] == 'excluded_by_forced_zero_radical' for r in records)
        result = {'status':'screening_completed','source_sha256':hashlib.sha256(raw).hexdigest(),
                  'parent_sha256':parent_sha,
                  'seed':20261006,'directions':directions,'target_families':len(targets),
                  'complete_direction_orbits':args.orbit_directions,
                  'excluded_by_rank14':linear,'excluded_by_lower_rank':lower,
                  'unresolved':len(targets)-linear-lower,'all_n32_cubics_excluded':False,
                  'scope':'Higher-dimensional radicals use all normalized basis evaluations. Only forced-zero radicals are excluded here; disjunctions not decided by linear implication remain unresolved.',
                  'families':records,'seconds':round(time.perf_counter()-start,3)}
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k not in ('families','directions')},indent=2))

if __name__ == '__main__':
    main()

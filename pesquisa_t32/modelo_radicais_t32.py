"""Faithful fixed-H CNF for necessary balance of every nonzero fiber orbit.

CNF satisfiability is not bentness. No UNSAT claim is made without a checked proof.
"""
import argparse
import hashlib
from itertools import product
import json
from pathlib import Path
import random
from triagem_familias_t32 import model, coefficient_forms, family_fiber, linear_row
from verificar_fibras_exato import require

def directions():
    seen = {0}
    reps = []
    for z in range(1,65536):
        if z in seen:
            continue
        values = []
        value = z
        for _ in range(16):
            values.append(value)
            value = ((value<<1)&65535)|(value>>15)
        seen.update(values)
        reps.append(min(values))
    require(len(reps) == 4115 and len(seen) == 65536,'Incomplete direction orbit coverage.')
    return sorted(reps)

def free_coordinates(h,hrows):
    pivots = {row.bit_length()-1:i for i,row in enumerate(hrows)}
    free = [j for j in range(155) if j not in pivots]
    lookup = {j:i for i,j in enumerate(free)}
    require(len(free) == 120,'Wrong free dimension.')
    def reduce_row(row):
        constant = 0
        for pivot,i in pivots.items():
            if row>>pivot&1:
                row ^= hrows[i]
                constant ^= (h>>i)&1
        reduced = sum(1<<lookup[j] for j in free if row>>j&1)
        require(all(not(row>>p&1) for p in pivots),'Pivot was not eliminated.')
        return reduced,constant
    def lift(free_value):
        value = sum(1<<j for i,j in enumerate(free) if free_value>>i&1)
        for pivot,i in pivots.items():
            bit = ((hrows[i]&value).bit_count()&1)^((h>>i)&1)
            if bit:
                value |= 1<<pivot
        return value
    return free,reduce_row,lift

class CNF:
    def __init__(self,n):
        self.variables = n
        self.clauses = []
        self.parities = {}
        self.gates = []
        self.requested_parities = set()
    def parity(self,mask):
        require(mask != 0,'Constant parity must be handled explicitly.')
        if mask in self.parities:
            return self.parities[mask]
        low = (mask & -mask).bit_length()-1
        high = mask.bit_length()-1
        if low == high:
            value = low+1
        else:
            block = 1 << ((low^high).bit_length()-1)
            boundary = (high//block)*block
            left = mask & ((1<<boundary)-1)
            right = mask ^ left
            require(left and right,'Invalid parity split.')
            a,b = self.parity(left),self.parity(right)
            self.variables += 1
            value = self.variables
            self.clauses.extend([[a,b,-value],[a,-b,value],
                                 [-a,b,value],[-a,-b,-value]])
            self.gates.append((a,b,value))
        self.parities[mask] = value
        return value
    def balance(self,affine_values):
        if any(mask == 0 and constant == 1 for mask,constant in affine_values):
            return
        clause = set()
        for mask,constant in affine_values:
            if mask:
                self.requested_parities.add(mask)
                variable = self.parity(mask)
                clause.add(-variable if constant else variable)
        if any(-literal in clause for literal in clause):
            return
        self.clauses.append(sorted(clause,key=lambda x:(abs(x),x)))
    def evaluate(self,free_value):
        assignment = {i+1:bool(free_value>>i&1) for i in range(120)}
        for a,b,out in self.gates:
            assignment[out] = assignment[a]^assignment[b]
        return all(any(assignment[abs(lit)] == (lit>0) for lit in clause)
                   for clause in self.clauses)

def controls():
    # Exhaustive three-bit comparison of XOR/OR semantics and gate definitions.
    checked = 0
    for values in [[(1,0),(3,1),(6,0)],[(0,0)],[(0,1)],[(7,0),(7,1)],[(3,1)]]:
        formula = CNF(120)
        formula.balance(values)
        for x in range(8):
            expected = any(((mask&x).bit_count()&1)^constant for mask,constant in values)
            require(formula.evaluate(x) == expected,'CNF disagrees with affine disjunction.')
            checked += 1
    for a,b,out in product(range(2),repeat=3):
        clauses=[[1,2,-3],[1,-2,3],[-1,2,3],[-1,-2,-3]]
        assignment={1:bool(a),2:bool(b),3:bool(out)}
        actual=all(any(assignment[abs(l)] == (l>0) for l in cl) for cl in clauses)
        require(actual == (out == (a^b)),'XOR gate is incorrect.')
        checked += 1
    return checked

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--h',type=lambda x:int(x,0),required=True)
    parser.add_argument('--output-prefix',type=Path,required=True)
    parser.add_argument('--reencode',type=Path,help='Reuse previously generated normalized fiber data.')
    args=parser.parse_args()
    h=args.h
    require(0 <= h < (1<<35),'h must fit in 35 bits.')
    checked=controls()
    reps32,_,hrows,_=model()
    free,reduce_row,lift=free_coordinates(h,hrows)
    formula=CNF(120)
    normalized=[]
    ranks={}
    rng=random.Random(20261007)
    # Differential check: free-parameter substitution versus original 155-bit rows.
    for _ in range(100):
        row=rng.getrandbits(155);x=rng.getrandbits(120)
        reduced,constant=reduce_row(row)
        require(((row&lift(x)).bit_count()&1) == (((reduced&x).bit_count()&1)^constant),
                'Free-coordinate substitution failed.')
    cached_sha = None
    if args.reencode:
        raw=args.reencode.read_bytes()
        cached=json.loads(raw)
        require(int(cached['h'],16) == h and cached['free_original_orbit_indices'] == free,'Wrong cached family.')
        normalized=cached['fibers']
        require([f['z'] for f in normalized] == directions(),'Cached directions are incomplete.')
        for fiber in normalized:
            values=[(int(mask,16),constant) for mask,constant in fiber['affine_values']]
            require(all(0 <= mask < (1<<120) and constant in (0,1) for mask,constant in values),'Invalid affine values.')
            formula.balance(values)
            key=str(fiber['rank']);ranks[key]=ranks.get(key,0)+1
        cached_sha=hashlib.sha256(raw).hexdigest()
    else:
        for z in directions():
            forms=coefficient_forms(reps32,z,hrows)
            B,rank,basis=family_fiber(h,hrows,forms)
            require(all((row&z).bit_count()%2 == 0 for row in B),'Half-turn is not radical.')
            require(linear_row(forms,z) == 0,'Half-turn evaluation is not zero.')
            values=[reduce_row(linear_row(forms,r)) for r in basis]
            formula.balance(values)
            normalized.append({'z':z,'rank':rank,'radical_basis':basis,
                               'affine_values':[[hex(mask),constant] for mask,constant in values]})
            ranks[str(rank)]=ranks.get(str(rank),0)+1
    # Compare the whole CNF against all of its original affine disjunctions.
    for _ in range(8):
        x=rng.getrandbits(120)
        expected=all(any(((int(mask,16)&x).bit_count()&1)^constant
                         for mask,constant in fiber['affine_values']) for fiber in normalized)
        require(formula.evaluate(x) == expected,'Full CNF semantics mismatch.')
    cnf_path=args.output_prefix.with_suffix('.cnf')
    with cnf_path.open('w') as f:
        f.write('c Necessary fiber balance for fixed H='+hex(h)+'; not a bentness equivalence.\n')
        f.write('p cnf '+str(formula.variables)+' '+str(len(formula.clauses))+'\n')
        for clause in formula.clauses:
            f.write(' '.join(map(str,clause))+' 0\n')
    metadata={'h':hex(h),'family_dimension':120,'free_original_orbit_indices':free,
              'fiber_orbits':4115,'polar_rank_counts':ranks,'variables':formula.variables,
              'clauses':len(formula.clauses),'distinct_parity_forms':len(formula.requested_parities),
              'cached_parity_expressions':len(formula.parities),
              'reencoded_source_sha256':cached_sha,
              'toy_assignments_checked':checked,'free_coordinate_checks':100,
              'full_formula_assignments_checked':8,
              'cnf_sha256':hashlib.sha256(cnf_path.read_bytes()).hexdigest(),
              'solver_status':'not_run','bentness_certified':False,
              'scope':'UNSAT would exclude this fixed-H family only after model and proof verification. SAT would only mean necessary fiber conditions are consistent.',
              'fibers':normalized}
    args.output_prefix.with_suffix('.json').write_text(json.dumps(metadata,indent=2)+'\n')
    print(json.dumps({k:v for k,v in metadata.items() if k not in ('fibers','free_original_orbit_indices')},indent=2))

if __name__=='__main__':
    main()

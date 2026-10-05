"""Exact affine-unit elimination for necessary fiber-balance disjunctions."""
import argparse
from collections import Counter
import hashlib
import itertools
import json
from pathlib import Path
import random

def require(ok, text):
    if not ok: raise ValueError(text)

def reduce_form(mask, constant, basis):
    for p in sorted(basis, reverse=True):
        if mask >> p & 1:
            row, rhs = basis[p]; mask ^= row; constant ^= rhs
    return mask, constant

def normalize(values):
    values = set(values)
    if (0, 1) in values: return None
    values.discard((0, 0))
    if any((m, 1-c) in values for m,c in values): return None
    return tuple(sorted(values))

def simplify(original, n):
    basis = {}; derivations = []
    while True:
        added = False
        for index, values in enumerate(original):
            clause = normalize(reduce_form(m,c,basis) for m,c in values)
            if clause == (): return basis, derivations, [()], index
            if clause is not None and len(clause) == 1:
                mask, constant = clause[0]
                p = mask.bit_length()-1
                require(p not in basis, 'Uneliminated pivot.')
                basis[p] = (mask, constant^1)
                derivations.append({'fiber_index':index,'row':hex(mask),'rhs':constant^1})
                added = True
        if not added: break
    clauses = set()
    for values in original:
        clause = normalize(reduce_form(m,c,basis) for m,c in values)
        if clause is not None: clauses.add(clause)
    return basis, derivations, sorted(clauses), None

def replay(original, derivations):
    """Check each recorded equation is a forced unit under prior equations."""
    basis = {}
    for step in derivations:
        values = original[step['fiber_index']]
        clause = normalize(reduce_form(m,c,basis) for m,c in values)
        require(clause is not None and len(clause)==1, 'Unjustified unit equation.')
        row, constant = clause[0]
        require((row,constant^1)==(int(step['row'],16),step['rhs']), 'Bad elimination trace.')
        basis[row.bit_length()-1] = row, constant^1
    return basis

def coordinates(basis, n):
    free = [i for i in range(n) if i not in basis]
    def substitute(mask, constant):
        mask, constant = reduce_form(mask,constant,basis)
        return sum(((mask>>j)&1)<<i for i,j in enumerate(free)),constant
    expressions = [substitute(1<<i,0) for i in range(n)]
    def lift(value):
        return sum((((mask&value).bit_count()&1)^c)<<i for i,(mask,c) in enumerate(expressions))
    return free, substitute, lift, expressions

class Encoder:
    def __init__(self,n): self.variables=n; self.clauses=[]; self.cache={}
    def parity(self,mask):
        if mask in self.cache: return self.cache[mask]
        require(mask>0,'Constant gate.')
        low=(mask&-mask).bit_length()-1; high=mask.bit_length()-1
        if low==high: out=low+1
        else:
            block=1<<((low^high).bit_length()-1); boundary=(high//block)*block
            left=mask&((1<<boundary)-1); right=mask^left
            a,b=self.parity(left),self.parity(right)
            self.variables+=1; out=self.variables
            self.clauses.extend([[a,b,-out],[a,-b,out],[-a,b,out],[-a,-b,-out]])
        self.cache[mask]=out
        return out
    def balance(self,values):
        clause=normalize(values)
        if clause is None:return
        self.clauses.append([(-1 if c else 1)*self.parity(m) for m,c in clause])

def read_cnf(path,n,clauses):
    header=None; actual=[]
    for line in path.read_text().splitlines():
        if not line.strip() or line.startswith('c'):continue
        if line.startswith('p'):
            require(header is None,'Repeated header.');header=line.split();continue
        row=list(map(int,line.split()))
        require(row and row[-1]==0 and 0 not in row[:-1],'Malformed clause.')
        require(all(abs(v)<=n for v in row[:-1]),'Invalid variable.')
        actual.append(row[:-1])
    require(header==['p','cnf',str(n),str(len(clauses))] and actual==clauses,'Serialized CNF differs.')

def controls():
    rng=random.Random(20261005)
    cases=[[( (1,0),),((1,1),)],[( (1,0),(2,0)),((1,1),),((2,0),)]]
    for _ in range(80):
        cases.append([tuple((rng.randrange(64),rng.randrange(2)) for _ in range(rng.randrange(1,5))) for _ in range(12)])
    for original in cases:
        basis,trace,clauses,contradiction=simplify(original,6)
        require(replay(original,trace)==basis,'Trace mismatch.')
        free,sub,lift,_=coordinates(basis,6)
        expected={x for x in range(64) if all(any(((m&x).bit_count()&1)^c for m,c in row) for row in original)}
        actual=set()
        if contradiction is None:
            for y in range(1<<len(free)):
                if all(any(((sub(m,c)[0]&y).bit_count()&1)^sub(m,c)[1] for m,c in row) for row in clauses):actual.add(lift(y))
        require(actual==expected,'Exhaustive reduction control failed.')
    return len(cases)*64

def run(metadata,prefix):
    info=json.loads(metadata.read_text()); n=info['family_dimension']
    original=[[(int(m,16),c) for m,c in f['affine_values']] for f in info['fibers']]
    require(all(0<=m<(1<<n) and c in (0,1) for row in original for m,c in row),'Invalid input.')
    checked=controls();basis,trace,clauses,contradiction=simplify(original,n)
    require(replay(original,trace)==basis,'Elimination trace failed.')
    if contradiction is not None:
        require(normalize(reduce_form(m,c,basis) for m,c in original[contradiction])==(),'Unjustified contradiction.')
    free,sub,lift,expressions=coordinates(basis,n)
    reduced=[tuple(sub(m,c) for m,c in row) for row in clauses]
    encoder=Encoder(len(free))
    for row in reduced:encoder.balance(row)
    rng=random.Random(20261005)
    for _ in range(128):
        y=rng.getrandbits(len(free));x=lift(y)
        require(all(((row&x).bit_count()&1)==rhs for row,rhs in basis.values()),'Bad lift.')
        require(all(any(((m&x).bit_count()&1)^c for m,c in row) for row in original)==all(any(((m&y).bit_count()&1)^c for m,c in row) for row in reduced),'Reduced semantics mismatch.')
    cnf=prefix.with_suffix('.cnf')
    with cnf.open('w') as stream:
        stream.write('c Exact reduction of necessary fiber conditions; SAT is not bentness.\n')
        stream.write(f'p cnf {encoder.variables} {len(encoder.clauses)}\n')
        for row in encoder.clauses:stream.write(' '.join(map(str,row))+' 0\n')
    read_cnf(cnf,encoder.variables,encoder.clauses)
    report={'h':info['h'],'input_sha256':hashlib.sha256(metadata.read_bytes()).hexdigest(),
            'input_dimension':n,'linear_rank':len(basis),'remaining_dimension':len(free),
            'unit_derivations':trace,'contradictory_fiber_index':contradiction,
            'lift_expressions':[[hex(m),c] for m,c in expressions],
            'reduced_disjunctions':[[[hex(m),c] for m,c in row] for row in reduced],
            'variables':encoder.variables,'clauses':len(encoder.clauses),
            'cnf_sha256':hashlib.sha256(cnf.read_bytes()).hexdigest(),
            'exhaustive_control_assignments':checked,'lift_checks':128,'bentness_certified':False}
    prefix.with_suffix('.json').write_text(json.dumps(report,indent=2)+'\n')
    return report

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--metadata',type=Path,required=True);p.add_argument('--prefix',type=Path,required=True);a=p.parse_args()
    result=run(a.metadata,a.prefix)
    print(json.dumps({k:result[k] for k in ['h','linear_rank','remaining_dimension','variables','clauses']}))

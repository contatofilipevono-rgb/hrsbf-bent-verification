"""Exact existential CNF for balance of selected quadratic derivatives.

For q=D_a f let R=ker(B_q). Balance is equivalent to existence of r in R
with q(r)+q(0)=1. All arithmetic is over F_2. A selected subset of directions
gives necessary conditions only; SAT is never a bentness certificate.
"""
import argparse
import hashlib
import itertools
import json
from pathlib import Path


class Circuit:
    def __init__(self, variables=0, clauses=None):
        self.variables = variables
        self.clauses = [] if clauses is None else list(clauses)
        self.gates = []
        self.cache = {}

    def new(self):
        self.variables += 1
        return self.variables

    def force(self, value, target):
        if type(value) is bool:
            if value != target:
                self.clauses.append([])
        else:
            self.clauses.append([value if target else -value])

    def xor(self, values):
        constant = False
        pending = set()
        for v in values:
            if type(v) is bool:
                constant ^= v
            else:
                if v < 0:
                    constant ^= True
                    v = -v
                if v in pending:
                    pending.remove(v)
                else:
                    pending.add(v)
        ordered = sorted(pending)
        if not ordered:
            return constant
        result = ordered[0]
        for b in ordered[1:]:
            key = ('xor', min(result, b), max(result, b))
            if key not in self.cache:
                out = self.new()
                self.clauses.extend([[result,b,-out], [result,-b,out],
                                     [-result,b,out], [-result,-b,-out]])
                self.gates.append(('xor', result, b, out))
                self.cache[key] = out
            result = self.cache[key]
        return -result if constant else result

    def conjunction(self, values):
        pending = set()
        for v in values:
            if type(v) is bool:
                if not v:
                    return False
            else:
                if -v in pending:
                    return False
                pending.add(v)
        ordered = sorted(pending)
        if not ordered:
            return True
        result = ordered[0]
        for b in ordered[1:]:
            key = ('and', min(result,b), max(result,b))
            if key not in self.cache:
                out = self.new()
                self.clauses.extend([[-out,result], [-out,b], [out,-result,-b]])
                self.gates.append(('and',result,b,out))
                self.cache[key] = out
            result = self.cache[key]
        return result

    def affine(self, row):
        mask, constant = row
        return self.xor([bool(constant)] + [i+1 for i in range(mask.bit_length()) if mask>>i&1])

    def extend(self, assignment):
        assignment = dict(assignment)
        def value(v):
            return v if type(v) is bool else assignment[abs(v)] ^ (v<0)
        for kind,a,b,out in self.gates:
            assignment[out] = value(a)^value(b) if kind=='xor' else value(a)&value(b)
        return assignment


def derivative_forms(polynomial, direction):
    """Expand D_a f symbolically; polynomial maps monomial masks to coefficient rows."""
    result = {}
    for term, row in polynomial.items():
        if term.bit_count()>3:
            raise ValueError('Degree greater than three.')
        movable = term & direction
        removed = movable
        while removed:
            reduced = term ^ removed
            previous = result.get(reduced,(0,0))
            new = previous[0]^row[0], previous[1]^row[1]
            if new == (0,0):
                result.pop(reduced,None)
            else:
                result[reduced] = new
            removed = (removed-1)&movable
    return result


def add_balance(circuit, n, polynomial, direction):
    if not 0 < direction < 1<<n:
        raise ValueError('Direction must be nonzero and fit the dimension.')
    q = derivative_forms(polynomial, direction)
    r = [circuit.new() for _ in range(n)]
    coefficients = {term:circuit.affine(row) for term,row in q.items() if term}
    polar = [[] for _ in range(n)]
    values = []
    for term, coefficient in coefficients.items():
        indices = [i for i in range(n) if term>>i&1]
        if len(indices)>2:
            raise ValueError('Derivative is not quadratic.')
        values.append(circuit.conjunction([coefficient]+[r[i] for i in indices]))
        if len(indices)==2:
            i,j = indices
            polar[i].append(circuit.conjunction([coefficient,r[j]]))
            polar[j].append(circuit.conjunction([coefficient,r[i]]))
    for row in polar:
        circuit.force(circuit.xor(row),False)
    circuit.force(circuit.xor(values),True)
    return r


def default_directions(n=32):
    # Rotation represents all weight-one directions and all weight-two distances.
    return [1]+[1|(1<<d) for d in range(1,n//2+1)]+[
        1|(1<<a)|(1<<b) for a,b in [(1,2),(1,3),(1,4),(2,4),(3,6),(4,8)]]


def fixed_family(h):
    # Independent orbit/projection definitions, matched against production ordering.
    from audit_independent_cnf import REPS32, HROWS
    from modelo_radicais_t32 import free_coordinates
    from triagem_familias_t32 import model
    reps,_,rows,_ = model()
    if reps != [s for s,_ in REPS32] or rows != HROWS:
        raise ValueError('Independent generator ordering differs.')
    free, substitute, lift = free_coordinates(h, HROWS)
    polynomial = {term:substitute(1<<j) for j,(_,orb) in enumerate(REPS32) for term in orb}
    return polynomial, free, lift


def read_dimacs(path):
    variables = None
    expected = None
    clauses = []
    pending = []
    for line in path.read_text().splitlines():
        if not line.strip() or line.lstrip().startswith('c'):
            continue
        if line.startswith('p '):
            _,kind,v,c = line.split()
            if variables is not None or kind != 'cnf':
                raise ValueError('Invalid DIMACS header.')
            variables,expected = int(v),int(c)
            continue
        for literal in map(int,line.split()):
            if literal:
                pending.append(literal)
            else:
                clauses.append(pending)
                pending = []
    if variables is None or pending or len(clauses)!=expected:
        raise ValueError('Truncated DIMACS.')
    if any(abs(v)>variables for row in clauses for v in row):
        raise ValueError('Out-of-range DIMACS literal.')
    return variables, clauses


def generate(h, prefix, selected=None, source=None, metadata=None):
    if not 0<=h<1<<35:
        raise ValueError('H must fit 35 bits.')
    polynomial,free,_ = fixed_family(h)
    selected = default_directions() if selected is None else sorted(set(selected))
    if not selected:
        raise ValueError('Select at least one direction.')
    source_hash = None
    if source is not None:
        if metadata is None:
            raise ValueError('Original fiber metadata required to validate coefficient coordinates.')
        info = json.loads(metadata.read_text())
        source_hash = hashlib.sha256(source.read_bytes()).hexdigest()
        if int(info['h'],16)!=h or info['free_original_orbit_indices']!=free or info['cnf_sha256']!=source_hash:
            raise ValueError('Original fiber family/coordinate/hash mismatch.')
        variables,clauses = read_dimacs(source)
        if variables<120:
            raise ValueError('Expected unreduced original fiber CNF, with 120 leading parameters.')
    else:
        variables,clauses = 120,[]
    circuit = Circuit(variables,clauses)
    witnesses = {}
    for a in selected:
        witnesses[hex(a)] = add_balance(circuit,32,polynomial,a)
    prefix.parent.mkdir(parents=True,exist_ok=True)
    path = prefix.with_suffix('.cnf')
    with path.open('w') as f:
        f.write('c Selected derivative balance; SAT does not certify bentness.\n')
        f.write(f'p cnf {circuit.variables} {len(circuit.clauses)}\n')
        for row in circuit.clauses:
            f.write(' '.join(map(str,row))+' 0\n')
    v,rows = read_dimacs(path)
    if v!=circuit.variables or rows!=circuit.clauses:
        raise ValueError('Serialization mismatch.')
    report = {'h':hex(h),'scope':'Necessary balance of selected derivatives only; optionally conjoined with original fiber CNF.',
              'variables':v,'clauses':len(rows),'directions':[hex(a) for a in selected],
              'witness_variables':witnesses,'free_original_orbit_indices':free,
              'source_cnf_sha256':source_hash,'cnf_sha256':hashlib.sha256(path.read_bytes()).hexdigest(),
              'bentness_certified':False,'solver_status':'NOT_RUN'}
    prefix.with_suffix('.json').write_text(json.dumps(report,indent=2)+'\n')
    return report


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--h',type=lambda s:int(s,0),required=True)
    p.add_argument('--output-prefix',type=Path,required=True)
    p.add_argument('--directions',type=lambda s:[int(a,0) for a in s.split(',')])
    p.add_argument('--base-cnf',type=Path)
    p.add_argument('--base-metadata',type=Path)
    a=p.parse_args()
    print(json.dumps(generate(a.h,a.output_prefix,a.directions,a.base_cnf,a.base_metadata),indent=2))

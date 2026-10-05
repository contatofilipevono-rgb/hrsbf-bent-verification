"""Exact quotient by the common kernel of every affine fiber constraint.

The 120 original parameters x are replaced by y_i=<b_i,x>, where the b_i
form a basis of the row span of all remaining constraints. The map onto y
is surjective. SAT on this quotient still means necessary conditions only.
"""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import random


def need(ok,message):
    if not ok: raise ValueError(message)


def canonical(values):
    """OR of affine forms is unchanged by invertible row operations."""
    basis={}
    for mask,constant in values:
        v=(mask<<1)|constant
        while v:
            p=v.bit_length()-1
            if p in basis: v^=basis[p]
            else:
                basis[p]=v
                break
    if 0 in basis: return None  # span contains constant 1: tautology
    for p in sorted(basis):
        for j in basis:
            if j>p and basis[j]>>p&1: basis[j]^=basis[p]
    return tuple((v>>1,v&1) for _,v in sorted(basis.items()))


def independent_rank(rows):
    # Separate implementation: eliminate on the least significant bit.
    basis={}
    for v in rows:
        while v:
            low=v&-v
            if low in basis: v^=basis[low]
            else:
                basis[low]=v
                break
    return len(basis)


def verify_clause(original,reduced):
    rows=[(m<<1)|c for m,c in original]
    rank=independent_rank(rows)
    if reduced is None:
        need(independent_rank(rows+[1])==rank,'Unjustified tautology')
    else:
        other=[(m<<1)|c for m,c in reduced]
        need(independent_rank(other)==rank==independent_rank(rows+other),'Affine row spans differ')


def build(original,n):
    canonical_clauses=set()
    tautologies=0
    for clause in original:
        need(all(0<=m<1<<n and c in (0,1) for m,c in clause),'Invalid affine form')
        reduced=canonical(clause)
        verify_clause(clause,reduced)
        if reduced is None: tautologies+=1
        else: canonical_clauses.add(reduced)
    basis={}
    for m in sorted({m for clause in canonical_clauses for m,c in clause},key=lambda m:(m.bit_count(),m)):
        v=m
        while v:
            p=v.bit_length()-1
            if p in basis: v^=basis[p][0]
            else:
                basis[p]=(v,len(basis))
                break
    def reduce_mask(mask):
        coordinate=0
        while mask:
            p=mask.bit_length()-1
            need(p in basis,'Form outside quotient row span')
            row,index=basis[p]
            mask^=row
            coordinate^=1<<index
        return coordinate
    rows=[0]*len(basis)
    for row,index in basis.values(): rows[index]=row
    clauses=sorted(tuple((reduce_mask(m),c) for m,c in clause) for clause in canonical_clauses)
    for before,after in zip(sorted(canonical_clauses),[tuple((reduce_mask(m),c) for m,c in cl) for cl in sorted(canonical_clauses)]):
        for (m,c),(q,d) in zip(before,after):
            reconstructed=0
            for i,row in enumerate(rows):
                if q>>i&1: reconstructed^=row
            need(reconstructed==m and c==d,'Coefficient map failed replay')
    need(independent_rank(rows)==len(rows),'Quotient map is not surjective')
    return {'original_dimension':n,'dimension':len(rows),'basis_rows':rows,
            'clauses':clauses,'tautologies_removed':tautologies,
            'duplicate_clauses_removed':len(original)-tautologies-len(clauses)}


def project(model,x):
    return sum(((row&x).bit_count()&1)<<i for i,row in enumerate(model['basis_rows']))


def lift(model,y):
    need(0<=y<1<<model['dimension'],'Invalid quotient value')
    x=0
    for p,row,i in sorted((row.bit_length()-1,row,i) for i,row in enumerate(model['basis_rows'])):
        if ((y>>i)&1)^((row&x).bit_count()&1): x|=1<<p
    need(project(model,x)==y,'Quotient lift failed')
    return x


def satisfies(clauses,x):
    return all(any(((mask&x).bit_count()&1)^constant for mask,constant in clause) for clause in clauses)


def controls():
    rng=random.Random(20261005)
    cases=[[[ (1,0),(2,0),(3,1)]], [[(1,0)],[(1,1)]], [[]], [[(0,1)]], []]
    cases += [[[(rng.randrange(64),rng.randrange(2)) for _ in range(rng.randrange(5))]
               for _ in range(rng.randrange(1,15))] for _ in range(80)]
    assignments=0
    for original in cases:
        model=build(original,6)
        for x in range(64):
            need(satisfies(original,x)==satisfies(model['clauses'],project(model,x)),'Pointwise quotient mismatch')
            assignments+=1
        for y in range(1<<model['dimension']):
            x=lift(model,y)
            need(satisfies(model['clauses'],y)==satisfies(original,x),'Lift changed satisfiability')
    return {'exhaustive_pointwise_checks':assignments,'cases':len(cases),'status':'PASS'}


def audit_xcnf(path,model):
    """Parse serialized XORs independently and recover the affine clauses."""
    equations={}
    raw=[]
    header=None
    for line in path.read_text().splitlines():
        if not line.strip() or line.startswith('c'): continue
        if line.startswith('p '):
            need(header is None,'Duplicate header')
            fields=line.split();need(fields[:2]==['p','cnf'],'Bad header')
            header=tuple(map(int,fields[2:]));continue
        xor=line.startswith('x')
        tokens=list(map(int,(line[1:] if xor else line).split()))
        need(tokens and tokens[-1]==0 and 0 not in tokens[:-1],'Malformed clause')
        if xor:
            mask=0;rhs=1
            for v in tokens[:-1]:
                mask^=1<<(abs(v)-1)
                rhs^=int(v<0)
            auxiliary=mask>>model['dimension']
            need(auxiliary and auxiliary.bit_count()==1,'XOR does not define one auxiliary')
            index=model['dimension']+auxiliary.bit_length()
            need(index not in equations,'Duplicate auxiliary definition')
            equations[index]=(mask&((1<<model['dimension'])-1),rhs)
        else: raw.append(tokens[:-1])
    need(header is not None,'Missing header')
    need(header==(model['dimension']+len(equations),len(equations)+len(raw)),'Header mismatch')
    recovered=[]
    for row in raw:
        values=[]
        for v in row:
            need(abs(v) in equations,'Undefined affine literal')
            m,c=equations[abs(v)];values.append((m,c^int(v<0)))
        recovered.append(canonical(values))
    need(sorted(recovered)==sorted(canonical(c) for c in model['clauses']),'Serialized XOR formula differs from the quotient')
    return {'xor_equations_checked':len(equations),'affine_clauses_checked':len(raw),'status':'PASS'}


def export(metadata,prefix):
    info=json.loads(metadata.read_text())
    original=[[(int(m,16),c) for m,c in f['affine_values']] for f in info['fibers']]
    model=build(original,info['family_dimension'])
    rng=random.Random(20261005)
    for _ in range(128):
        x=rng.getrandbits(model['original_dimension'])
        need(satisfies(original,x)==satisfies(model['clauses'],project(model,x)),'Full model differential failure')
        lift(model,rng.getrandbits(model['dimension']))
    # Portable CNF and native-XOR versions encode the same affine disjunctions.
    from derivative_balance_cnf import read_dimacs
    from reduce_fiber_cnf import Encoder
    circuit=Encoder(model['dimension'])
    for clause in model['clauses']:
        literals=[(-1 if c else 1)*circuit.parity(m) for m,c in clause]
        circuit.clauses.append(literals)
    prefix.parent.mkdir(parents=True,exist_ok=True)
    cnf=prefix.with_suffix('.cnf')
    with cnf.open('w') as f:
        f.write(f'p cnf {circuit.variables} {len(circuit.clauses)}\n')
        for row in circuit.clauses: f.write(' '.join(map(str,row))+' 0\n')
    v,clauses=read_dimacs(cnf)
    need(v==circuit.variables and clauses==circuit.clauses,'CNF serialization differs')
    forms=sorted({m for cl in model['clauses'] for m,c in cl})
    ids={m:model['dimension']+j+1 for j,m in enumerate(forms)}
    xcnf=prefix.with_suffix('.xcnf')
    with xcnf.open('w') as f:
        f.write('c XOR lines have parity 1; negated output enforces XOR(inputs,output)=0.\n')
        f.write(f'p cnf {model["dimension"]+len(forms)} {len(forms)+len(model["clauses"])}\n')
        for m,v in ids.items():
            inputs=[i+1 for i in range(model['dimension']) if m>>i&1]
            f.write('x'+' '.join(map(str,inputs+[-v]))+' 0\n')
        for clause in model['clauses']:
            f.write(' '.join(str(-ids[m] if c else ids[m]) for m,c in clause)+' 0\n')
    serialization_audit=audit_xcnf(xcnf,model)
    report={k:v for k,v in model.items() if k not in ('clauses','basis_rows')}
    report.update(h=info['h'],basis_rows=[hex(v) for v in model['basis_rows']],
                  clauses=[[[hex(m),c] for m,c in row] for row in model['clauses']],
                  clause_dimensions=dict(Counter(map(len,model['clauses']))),
                  cnf_variables=circuit.variables,cnf_clauses=len(circuit.clauses),
                  cnf_sha256=hashlib.sha256(cnf.read_bytes()).hexdigest(),
                  xcnf_sha256=hashlib.sha256(xcnf.read_bytes()).hexdigest(),
                  source_metadata_sha256=hashlib.sha256(metadata.read_bytes()).hexdigest(),
                  scope='Equivalent to supplied fiber constraints, which are necessary only.',
                  bentness_certified=False,controls=controls(),serialization_audit=serialization_audit)
    prefix.with_suffix('.json').write_text(json.dumps(report,indent=2)+'\n')
    return report


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('metadata',type=Path);p.add_argument('prefix',type=Path)
    a=p.parse_args();r=export(a.metadata,a.prefix)
    print(json.dumps({k:v for k,v in r.items() if k not in ('clauses','basis_rows')},indent=2))

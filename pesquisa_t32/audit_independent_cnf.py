"""Independent ANF/linear-algebra/CNF audit; no production-module imports.

Python 3.10+, standard library. DRAT verification is a separate operation.
"""
import argparse
from collections import Counter
from functools import lru_cache
from itertools import combinations
import hashlib
import json
from pathlib import Path
import time

def need(ok, message):
    if not ok:
        raise ValueError(message)

def rot(x,n):
    return ((x<<1)&((1<<n)-1))|(x>>(n-1))

def necklaces_of_weight(n,weight):
    unseen={sum(1<<i for i in s) for s in combinations(range(n),weight)}
    out=[]
    while unseen:
        x=next(iter(unseen)); orbit=set(); y=x
        while y not in orbit:
            orbit.add(y); y=rot(y,n)
        unseen.difference_update(orbit)
        supports=[tuple(i for i in range(n) if m>>i&1) for m in orbit]
        out.append((min(supports),tuple(sorted(orbit))))
    return sorted(out)

REPS32=necklaces_of_weight(32,3)
REPS16=necklaces_of_weight(16,3)
need(len(REPS32)==155 and len(REPS16)==35,'Wrong cubic orbit counts.')
INDEX16={mask:i for i,(_,orb) in enumerate(REPS16) for mask in orb}
GROUPS=[[] for _ in range(35)]; TARGETS=[]; TENSORS=[]
for j,(support,orb) in enumerate(REPS32):
    reduced=sum(1<<i for i in set(v%16 for v in support))
    target=INDEX16.get(reduced)
    TARGETS.append(target)
    if target is not None: GROUPS[target].append(j)
    tensor=[[0]*16 for _ in range(16)]
    for mask in orb:
        half=((mask&65535)<<16)|(mask>>16)
        if mask>half: continue
        indices=[i%16 for i in range(32) if mask>>i&1]
        if len(set(indices))<3: continue
        a,b,c=indices
        for x,y,z in [(a,b,c),(a,c,b),(b,c,a)]:
            tensor[z][x]^=1<<y; tensor[z][y]^=1<<x
    TENSORS.append(tuple(tuple(row) for row in tensor))
need(all(len(g)==4 for g in GROUPS),'Wrong lift multiplicities.')
need(sum(t is None for t in TARGETS)==15,'Wrong zero-polar count.')
need(all(TENSORS[j]==TENSORS[g[0]] for g in GROUPS for j in g),'Polar differs between lifts.')
need(all(not any(any(row) for row in TENSORS[j]) for j,t in enumerate(TARGETS) if t is None),'Antipodal orbit changes polar.')
HROWS=[sum(1<<j for j in g) for g in GROUPS]

@lru_cache(maxsize=150000)
def evaluate_generators(x):
    value=0
    for j,(_,orb) in enumerate(REPS32):
        parity=0
        for mask in orb: parity^=((mask&x)==mask)
        if parity: value|=1<<j
    return value

def evaluation_row(z,r):
    return evaluate_generators(r|((r^z)<<16)) ^ evaluate_generators(z<<16)

def echelon(rows):
    pivots={}
    for original in rows:
        row=original
        while row:
            p=row.bit_length()-1
            if p in pivots: row^=pivots[p]
            else:
                pivots[p]=row; break
    return pivots

@lru_cache(maxsize=100000)
def polar(h,z):
    B=[0]*16
    for i,g in enumerate(GROUPS):
        if not h>>i&1: continue
        tensor=TENSORS[g[0]]
        for k in range(16):
            if z>>k&1:
                for row in range(16): B[row]^=tensor[k][row]
    pivots=echelon(B)
    need(len(pivots)%2==0,'Odd alternating rank.')
    need(all((row&z).bit_count()%2==0 for row in B),'Half-turn outside radical.')
    return tuple(B),len(pivots)

def equation(h,item):
    if item['kind']=='h':
        i=item['index']; need(0<=i<35,'Bad H index.')
        return HROWS[i],(h>>i)&1
    need(item['kind']=='fiber','Unknown certificate equation.')
    z,r=item['z'],item['r']
    need(0<z<65536 and 0<r<65536 and r!=z,'Bad rank-14 direction.')
    B,rank=polar(h,z)
    need(rank==14 and all((row&r).bit_count()%2==0 for row in B),'Invalid rank-14 premise.')
    need(evaluation_row(z,z)==0,'Half-turn evaluation nonzero for some generator.')
    return evaluation_row(z,r),1

def audit_certificates(paths):
    totals={}
    for path in paths:
        report=json.loads(path.read_text()); verified=0; seen=set()
        for record in report['families']:
            h=int(record['h'],16); need(h.bit_count() in (1,3) and h not in seen,'Bad or duplicate parameter.');seen.add(h)
            if record['status']=='excluded_fixed_H_family':
                row=rhs=0
                for item in record['certificate']:
                    a,b=equation(h,item); row^=a; rhs^=b
                need(row==0 and rhs==1,'Certificate does not give 0=1.')
                verified+=1
            elif record['status']=='excluded_by_forced_zero_radical':
                z=record['z']; B,rank=polar(h,z)
                need(rank==record['polar_rank']==0,'This audit expects the nineteen rank-zero obstructions.')
                augmented=[]
                for item in record['base_equations']:
                    a,b=equation(h,item); augmented.append(a|(b<<155))
                # Use coefficient pivots, retaining the right-hand side separately.
                pivots={}
                for aug in augmented:
                    a=aug&((1<<155)-1); b=aug>>155
                    while a:
                        p=a.bit_length()-1
                        if p in pivots:
                            old,c=pivots[p];a^=old;b^=c
                        else:
                            pivots[p]=(a,b);break
                    need(a or not b,'Inconsistent base system.')
                for i in range(16):
                    a=evaluation_row(z,1<<i); b=0
                    for p in sorted(pivots,reverse=True):
                        if a>>p&1:
                            old,c=pivots[p];a^=old;b^=c
                    need(a==0 and b==0,'Radical evaluation not forced to zero.')
                verified+=1
        statuses={r['status'] for r in report['families']}
        need(statuses<= {'excluded_fixed_H_family','excluded_by_forced_zero_radical','unresolved_by_sampled_rank14_conditions','unresolved_by_linear_and_forced_radical_conditions'},'Unknown status.')
        if 'weight3_total_parameters' in report:
            expected_h={sum(1<<i for i in s) for s in combinations(range(35),3)}
            need({h for h in seen if h.bit_count()==3}==expected_h,'Incomplete weight-three coverage.')
            need(report['parameter_representatives_16']==[list(rep) for rep,_ in REPS16],'Parameter indexing differs.')
        totals[path.name]={'families':len(seen),'certificates_verified':verified,'weight3_certificates_verified':verified-int(any(int(r['h'],16).bit_count()==1 and r['status']=='excluded_fixed_H_family' for r in report['families'])),'sha256':hashlib.sha256(path.read_bytes()).hexdigest()}
        print('Independent certificates:',path.name,verified,flush=True)
    return totals

def orbit_directions():
    unseen=set(range(1,65536));reps=[]
    while unseen:
        z=min(unseen); vals=set();v=z
        while v not in vals: vals.add(v);v=rot(v,16)
        unseen.difference_update(vals);reps.append(min(vals))
    return sorted(reps)

def audit_model(metadata,cnf):
    info=json.loads(metadata.read_text());h=int(info['h'],16)
    need(h.bit_count()==3,'Scope is weight three.')
    pivots={g[-1]:i for i,g in enumerate(GROUPS)}
    free=[j for j in range(155) if j not in pivots]
    need(free==info['free_original_orbit_indices'] and len(free)==120,'Free coordinates mismatch.')
    expected=Counter();fibers=info['fibers']
    need([f['z'] for f in fibers]==orbit_directions(),'Missing or reordered direction orbits.')
    for count,fiber in enumerate(fibers,1):
        z=fiber['z']; B,rank=polar(h,z);basis=fiber['radical_basis']
        need(rank==fiber['rank'],'Polar rank mismatch.')
        need(len(basis)==16-rank and len(echelon(basis))==16-rank,'Incomplete radical basis.')
        need(all(0<r<65536 and all((row&r).bit_count()%2==0 for row in B) for r in basis),'Wrong radical vector.')
        values=[]
        for r in basis:
            raw=evaluation_row(z,r)
            constant=sum(((raw>>p)&1)*((h>>i)&1) for p,i in pivots.items())%2
            reduced=0
            for k,j in enumerate(free):
                bit=(raw>>j)&1; target=TARGETS[j]
                if target is not None: bit^=(raw>>GROUPS[target][-1])&1
                reduced|=bit<<k
            values.append((reduced,constant))
        need(values==[(int(mask,16),c) for mask,c in fiber['affine_values']],'Affine evaluation differs from direct original ANF.')
        if (0,1) not in values:
            clause=set((m,c) for m,c in values if m)
            if not any((m,1-c) in clause for m,c in clause):expected[tuple(sorted(clause))]+=1
        if count%512==0: print('Independent direct-ANF fibers:',count,flush=True)
    symbols={i:1<<(i-1) for i in range(1,121)};maxvar=120;clauses=0;gates=0;balance=0
    with cnf.open() as stream:
        header=None
        def next_clause():
            nonlocal header
            for line in stream:
                if not line.strip() or line.startswith('c'):continue
                if line.startswith('p'):
                    need(header is None,'Repeated header.'); fields=line.split();need(fields[:2]==['p','cnf'],'Bad DIMACS header.');header=tuple(map(int,fields[2:]));continue
                fields=list(map(int,line.split()));need(fields and fields[-1]==0 and 0 not in fields[:-1],'Bad clause terminator.');return fields[:-1]
            return None
        while True:
            clause=next_clause()
            if clause is None:break
            clauses+=1
            if len(clause)==3 and clause[0]>0 and clause[1]>0 and clause[2]==-(maxvar+1):
                a,b,out=clause[0],clause[1],-clause[2]
                need(a in symbols and b in symbols,'Non-topological XOR.')
                need([next_clause(),next_clause(),next_clause()]==[[a,-b,out],[-a,b,out],[-a,-b,-out]],'Bad four-clause XOR equivalence.')
                symbols[out]=symbols[a]^symbols[b];need(symbols[out]!=0,'Unexpected constant gate.');maxvar=out;clauses+=3;gates+=1
            else:
                need(all(abs(lit) in symbols for lit in clause),'Unknown variable.')
                semantic=tuple(sorted(set((symbols[abs(lit)],int(lit<0)) for lit in clause)))
                need(expected[semantic]>0,'CNF contains an unsupported balance clause.');expected[semantic]-=1;balance+=1
    missing={str(k):v for k,v in expected.items() if v}
    need(not missing,'Missing necessary fiber constraints: '+str({'clauses':clauses,'balance':balance,'missing':list(missing.items())[:5],'missing_total':sum(missing.values())}))
    need(header==(maxvar,clauses)==(info['variables'],info['clauses']),'DIMACS counts differ.')
    digest=hashlib.sha256(cnf.read_bytes()).hexdigest();need(digest==info['cnf_sha256'],'CNF hash differs.')
    return {'h':hex(h),'fiber_orbits_verified':len(fibers),'direct_anf_basis_evaluations_verified':sum(len(f['radical_basis']) for f in fibers),'xor_gates_verified':gates,'balance_clauses_verified':balance,'cnf_sha256':digest,'proof_checked_by_this_script':False}

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--certificate-report',action='append',type=Path,default=[])
    parser.add_argument('--metadata',type=Path);parser.add_argument('--cnf',type=Path)
    parser.add_argument('--output',type=Path,required=True);args=parser.parse_args()
    start=time.perf_counter();result={'status':'PASS','imports_production_modules':False,'cubic_orbits_32':155,'cubic_orbits_16':35,'four_lift_groups':35,'zero_polar_orbits':15,'free_dimension':120}
    result['certificates']=audit_certificates(args.certificate_report)
    if args.metadata:
        need(args.cnf is not None,'Supply CNF.');result['model']=audit_model(args.metadata,args.cnf)
    result['seconds']=round(time.perf_counter()-start,3)
    args.output.write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,indent=2))

if __name__=='__main__': main()

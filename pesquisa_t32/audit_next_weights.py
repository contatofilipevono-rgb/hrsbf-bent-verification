"""Independent direct-ANF audit for research_next_weights.py certificates."""
import argparse
import base64
import gzip
import hashlib
import itertools
import json
from pathlib import Path
from audit_independent_cnf import REPS16, REPS32, equation, evaluate_generators, polar as fiber_polar, evaluation_row
from audit_all_ones_obstruction import orbits, polar, rank_radical

def global_rows():
    allones=(1<<32)-1;rows={}
    for j in range(1,32):
        value=0
        for a,b,c in itertools.product((0,1),repeat=3):
            x=(allones if a else 0)^(1 if b else 0)^((1<<j) if c else 0)
            value^=evaluate_generators(x)
        rows[j]=value
    linear=evaluate_generators(allones^1)^evaluate_generators(1)^evaluate_generators(allones)^evaluate_generators(0)
    assert evaluate_generators(allones)^evaluate_generators(0)==0
    assert linear==(1<<155)-1
    return rows,linear

def load_report(path):
    raw=path.read_bytes()
    if path.name.endswith('.gz.b64'):raw=gzip.decompress(base64.b64decode(raw,validate=True))
    return json.loads(raw),raw

def audit(path):
    data,raw=load_report(path);rows,lin=global_rows()
    o16=orbits(16,3);o32=orbits(32,3)
    assert [s for s,_ in o16]==[s for s,_ in REPS16]
    assert [s for s,_ in o32]==[s for s,_ in REPS32]
    b16=[polar(16,o) for _,o in o16]
    idx={s:i for i,(_,o) in enumerate(o16) for s in o}
    for k,(s,o) in enumerate(o32):
        full=polar(32,o)
        assert all((full[0]>>j&1)==(rows[j]>>k&1) for j in range(1,32))
        target=idx.get(tuple(sorted({i%16 for i in s})))
        assert [((full[i]^full[i+16])>>16)&65535 for i in range(16)]==([0]*16 if target is None else b16[target])
    seen={};totals={w:0 for w in data['weights']}
    for rec in data['families']:
        h=int(rec['h'],16);assert 0<=h<(1<<35) and h not in seen
        w=str(h.bit_count());assert w in totals;seen[h]=rec['status']
        if rec['status']=='excluded':
            total=rhs=0;equations=[]
            for eq in rec['certificate']:
                if eq['kind']=='all_ones_polar':a,b=rows[eq['column']],0
                elif eq['kind']=='all_ones_linear':a,b=lin,1
                else:a,b=equation(h,eq)
                total^=a;rhs^=b
                equations.append((a,b))
            if 'forced_zero_radical' not in rec:
                assert total==0 and rhs==1,(hex(h),'invalid contradiction')
            else:
                z=rec['forced_zero_radical']['z'];B,rk=fiber_polar(h,z)
                rank,basis=rank_radical(B)
                assert rank==rk==rec['forced_zero_radical']['rank'] and rank<14
                piv={}
                for a,b in equations:
                    while a:
                        p=a.bit_length()-1
                        if p not in piv:piv[p]=(a,b);break
                        aa,bb=piv[p];a^=aa;b^=bb
                    assert a or b==0
                for r in basis:
                    a=evaluation_row(z,r);b=0
                    for p in sorted(piv,reverse=True):
                        if a>>p&1:
                            aa,bb=piv[p];a^=aa;b^=bb
                    assert a==0 and b==0,(hex(h),'radical value not forced zero')
            totals[w]+=1
        else:assert rec['status']=='unresolved'
    results={}
    for ws,counts in data['weights'].items():
        w=int(ws);passing=set();total=0
        for inds in itertools.combinations(range(35),w):
            total+=1;v=0
            for i in inds:v^=b16[i][0]
            if v==0:passing.add(sum(1<<i for i in inds))
        recorded={h for h in seen if h.bit_count()==w}
        assert recorded==passing
        assert counts=={'total':total,'excluded_by_cross_polar':total-len(passing),'fiber_cases_tested':len(passing),'additional_certificates':totals[ws],'unresolved':len(passing)-totals[ws]}
        results[ws]=counts
    return {'status':'PASS','source_sha256':hashlib.sha256(raw).hexdigest(),'weights':results,'all_n32_cubics_excluded':False,'scope':'Only the reported H weights; unresolved does not imply bentness.'}

if __name__=='__main__':
    if not __debug__:raise RuntimeError('Run without -O.')
    p=argparse.ArgumentParser();p.add_argument('input');p.add_argument('output');args=p.parse_args()
    result=audit(Path(args.input));Path(args.output).write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,indent=2))

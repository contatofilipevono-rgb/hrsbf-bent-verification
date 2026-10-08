"""Bounded exact-certificate screening of fixed-H families of other weights.

Uses the new all-ones derivative equations plus rank-14 fiber obstructions.
Unknown never means bent. Independent audit is provided separately.
"""
import argparse
import itertools
import json
from pathlib import Path
import time
from audit_all_ones_obstruction import orbits, polar, rank_radical
from triagem_familias_t32 import model, coefficient_forms, linear_row, family_fiber

def global_equations():
    oo=orbits(32,3);bs=[polar(32,o) for _,o in oo]
    out=[]
    for j in range(1,32):
        row=sum(1<<k for k,b in enumerate(bs) if b[0]>>j&1)
        out.append((row,0,{'kind':'all_ones_polar','column':j}))
    # Once its polar vanishes, the invariant derivative must be a nonzero
    # affine function. Homogeneity and orbit lengths make its constant zero.
    row=sum(1<<k for k,(_,o) in enumerate(oo)
            if sum(0 not in support for support in o)%2)
    assert row==(1<<155)-1
    out.append((row,1,{'kind':'all_ones_linear'}))
    return out

def solve(h,hrows,forms,globals):
    piv={};equations=[];count=0
    def add(row,rhs,desc):
        k=len(equations);equations.append(desc);origin=1<<k
        while row:
            p=row.bit_length()-1
            if p not in piv:
                piv[p]=(row,rhs,origin);return None
            a,b,c=piv[p];row^=a;rhs^=b;origin^=c
        if rhs:return [d for i,d in enumerate(equations) if origin>>i&1]
        return None
    initial=[(r,(h>>i)&1,{'kind':'h','index':i}) for i,r in enumerate(hrows)]+globals
    for row,rhs,desc in initial:
        cert=add(row,rhs,desc)
        if cert is not None:return {'h':hex(h),'status':'excluded','certificate':cert,'rank14_fibers':count}
    for z,f in forms.items():
        B,rank,basis=family_fiber(h,hrows,f)
        if rank!=14:continue
        count+=1;r=next(v for v in basis if v!=z)
        assert linear_row(f,z)==0
        cert=add(linear_row(f,r),1,{'kind':'fiber','z':z,'r':r})
        if cert is not None:return {'h':hex(h),'status':'excluded','certificate':cert,'rank14_fibers':count}
    return {'h':hex(h),'status':'unresolved','rank14_fibers':count}

def lower_rank(h,hrows,forms,globals):
    piv={};descs=[];lower=[]
    def add(row,rhs,desc):
        origin=1<<len(descs);descs.append(desc)
        while row:
            p=row.bit_length()-1
            if p not in piv:piv[p]=(row,rhs,origin);return
            a,b,c=piv[p];row^=a;rhs^=b;origin^=c
        assert rhs==0,'Use the contradiction solver first.'
    for i,row in enumerate(hrows):add(row,h>>i&1,{'kind':'h','index':i})
    for row,rhs,desc in globals:add(row,rhs,desc)
    for z,f in forms.items():
        B,rank,basis=family_fiber(h,hrows,f)
        if rank==14:
            r=next(v for v in basis if v!=z)
            add(linear_row(f,r),1,{'kind':'fiber','z':z,'r':r})
        else:lower.append((z,rank,basis))
    for z,rank,basis in lower:
        origins=0;valid=True
        for r in basis:
            row=linear_row(forms[z],r);rhs=0;origin=0
            for p in sorted(piv,reverse=True):
                if row>>p&1:
                    a,b,c=piv[p];row^=a;rhs^=b;origin^=c
            if row or rhs:valid=False;break
            origins|=origin
        if valid:
            return {'h':hex(h),'status':'excluded','forced_zero_radical':{'z':z,'rank':rank},
                    'certificate':[d for i,d in enumerate(descs) if origins>>i&1]}
    return {'h':hex(h),'status':'unresolved','lower_rank_fibers_tested':len(lower),
            'linear_dimension':155-len(piv)}

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--weights',nargs='+',type=int,default=[4,5]);p.add_argument('--directions',required=True);p.add_argument('--output',required=True);args=p.parse_args()
    t=time.monotonic();reps32,reps16,hrows,_=model();globals=global_equations()
    b16=[polar(16,o) for _,o in orbits(16,3)]
    zs=json.loads(Path(args.directions).read_text())['directions']
    forms={z:coefficient_forms(reps32,z,hrows) for z in zs}
    print('Prepared',len(forms),'fiber directions',flush=True)
    report={'scope':'Named weights of H, not all cubic HRSBF n32','directions':zs,'weights':{},'families':[]}
    for w in args.weights:
        assert 0<=w<=35
        total=0;filtered=0;tested=0;excluded=0
        for inds in itertools.combinations(range(35),w):
            total+=1;h=sum(1<<i for i in inds);rows=[0]*16
            for i in inds:rows=[x^y for x,y in zip(rows,b16[i])]
            if any(rows):filtered+=1;continue
            rec=solve(h,hrows,forms,globals);report['families'].append(rec);tested+=1;excluded+=rec['status']=='excluded'
            if tested%100==0:print('Weight',w,'tested',tested,'certified contradictions',excluded,flush=True)
        report['weights'][str(w)]={'total':total,'excluded_by_cross_polar':filtered,'fiber_cases_tested':tested,'additional_certificates':excluded,'unresolved':tested-excluded}
        report['elapsed_seconds']=time.monotonic()-t
        Path(args.output).write_text(json.dumps(report,indent=2)+'\n')
        print('Weight completed',w,report['weights'][str(w)],flush=True)

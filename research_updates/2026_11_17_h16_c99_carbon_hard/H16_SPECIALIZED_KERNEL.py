"""Specialize Greedy-Untouched flags with exact quadratic coefficients and strip common kernels."""
import itertools
import json
import random
import re
import shutil
import subprocess
import tempfile
import time
from collections import defaultdict
from pathlib import Path
import numpy as np


def mul(a,b):
    return (a @ b) & 1


def poly_product(left,right):
    out=set()
    for a,b in itertools.product(left,right):
        term=a|b
        if term in out:
            out.remove(term)
        else:
            out.add(term)
    return out


def transform(poly, forms, cache):
    out=set()
    for mask in poly:
        if mask not in cache:
            result={0}
            m=mask
            while m:
                bit=m & -m
                m^=bit
                result=poly_product(result,forms[bit.bit_length()-1])
            cache[mask]=result
        out^=cache[mask]
    return out


def rank(matrix,rref):
    return len(rref(matrix)[1])


def contract(coeff, left, right):
    return {p:mul(mul(left,m),right) for p,m in coeff.items()}


def diagnostic(coeff,rref):
    a=coeff[0]
    matrices=[m for p,m in coeff.items() if p and m.any()]
    if matrices:
        img=rank(np.concatenate(matrices, axis=1),rref)
        row=rank(np.concatenate(matrices, axis=0),rref)
    else:
        img=row=0
    return {"shape":list(a.shape),"constant_rows":a.shape[0]-img,
            "common_kernel":a.shape[1]-row,"quadratic_terms":sum(p.bit_count()==2 and m.any().item() for p,m in coeff.items())}


def strip(coeff,rref,null):
    m,n=coeff[0].shape
    left=np.eye(m,dtype=np.uint8)
    steps=[]
    while True:
        A=coeff[0]
        size=A.shape[1]
        variables=[x for k,x in coeff.items() if k and x.any()]
        stack=np.concatenate(variables,axis=0) if variables else np.zeros((0,size),dtype=np.uint8)
        K=null(stack)
        if not len(K):
            break
        C=mul(A,K.T)
        P=null(C.T)
        piv=set(rref(K)[1])
        complement=np.eye(size,dtype=np.uint8)[:,[j for j in range(size) if j not in piv]]
        assert not mul(P,C).any()
        assert len(P)+rank(C,rref)==len(A)
        steps.append({"kernel":len(K),"pivots":rank(C,rref),"gauge":len(K)-rank(C,rref),
                      "remaining":[len(P),complement.shape[1]]})
        coeff=contract(coeff,P,complement)
        left=mul(P,left)
    return coeff,left,steps


def specialize(coeff, base, directions):
    n=coeff[0].shape
    forms=[]
    for j,bit in enumerate(base):
        labels={1<<i for i,row in enumerate(directions) if row[j]}
        if bit: labels.add(0)
        forms.append(labels)
    out={0:np.zeros(n,dtype=np.uint8)}
    cache={0:{0}}
    for p,M in coeff.items():
        for term in transform([p],forms,cache):
            out.setdefault(term,np.zeros(n,dtype=np.uint8))
            out[term]^=M
    return out,forms


def verify_specialization(source, dest, base, directions):
    rng=random.Random(4300)
    for _ in range(8):
        t=np.array([rng.getrandbits(1) for _ in directions],dtype=np.uint8)
        mask=sum(int(v)<<i for i,v in enumerate(t))
        w=base ^ mul(t,directions)
        wm=sum(int(b)<<j for j,b in enumerate(w))
        rows=[]
        for coeff,point in ((source,wm),(dest,mask)):
            out=np.zeros_like(coeff[0])
            for p,M in coeff.items():
                if point&p==p: out^=M
            rows.append(out)
        assert np.array_equal(*rows)


def singular(coeff,left,rhs,tail,forms,seconds):
    exe=shutil.which("Singular")
    if not exe:
        return {"result":"NO_SOLVER"}
    source=[]
    for row in left:
        acc=set()
        for k,b in enumerate(row):
            if b: acc^=rhs[k]
        source.append(acc)
    cache={0:{0}}
    polys=[transform(p,forms,cache) for p in source]
    polys.extend(transform(p,forms,cache) for p in tail)
    shift=max((x.bit_length() for f in forms if f is not None for x in f),default=0)
    for p,A in coeff.items():
        for i,row in enumerate(A):
            for j,b in enumerate(row):
                if b: polys[i].symmetric_difference_update({p | (1<<(shift+j))})
    count=shift+coeff[0].shape[1]
    names=[f"x{j}" for j in range(count)]
    def print_poly(poly):
        return "+".join("*".join(names[i] for i in range(count) if m>>i&1) or "1"
                        for m in sorted(poly))
    equations=[print_poly(p) for p in polys if p]
    equations.extend(f"{x}^2+{x}" for x in names)
    script=f"ring R=2,({','.join(names)}),dp;\nideal I={','.join(equations)};\nideal G=slimgb(I);\nprint(\"H16_HAS_ONE\");\nprint(G[1]==1);\nquit;\n"
    started=time.monotonic()
    with tempfile.TemporaryDirectory() as d:
        path=Path(d)/"run.sing"
        path.write_text(script)
        try:
            result=subprocess.run([exe,"-q",str(path)],capture_output=True,text=True,timeout=seconds)
        except subprocess.TimeoutExpired:
            return {"result":"TIMEOUT","seconds":round(time.monotonic()-started,2),
                    "equations":len(equations),"variables":count}
    match=re.search(r"H16_HAS_ONE\s+([01])",result.stdout)
    return {"result":("UNSAT" if match[1]=="1" else "NO_UNIT") if match else "SOLVER_ERROR",
            "seconds":round(time.monotonic()-started,2),"equations":len(equations),"variables":count,
            "error":"" if match else (result.stderr+result.stdout)[-500:]}


def run_probe(cell, flag, best, old_projector, original, source_rows, quads, w_idx, t_idx, rf_idx, rref, null):
    n=len(w_idx)
    variable_mask=sum(1<<j for j in w_idx.keys()|t_idx.keys()|rf_idx.keys())
    coefficients={0:np.zeros_like(original)}
    rhs=[]
    for i,row in enumerate(source_rows):
        const=set()
        for m in row:
            assert not m & ~variable_mask
            rr=[r for r in rf_idx if m>>r&1]
            if not rr:
                const.add(m)
            else:
                (r,)=rr
                support=m^(1<<r)
                w=sum(1<<j for p,j in w_idx.items() if support>>p&1)
                assert support.bit_count()==w.bit_count()<=2
                coefficients.setdefault(w,np.zeros_like(original))[i,rf_idx[r]]^=1
        rhs.append(const)
    assert np.array_equal(coefficients[0],original)
    core,P,global_steps=strip(coefficients,rref,null)
    # Restrict the first greedy direction flag and use representative affine offsets.
    rng=random.Random(414142)
    dims=(24,26,28,30) if cell=="B0_11" else (18,20,22,24)
    result={"global":global_steps,"dimensions":[]}
    u=mul(best[2],old_projector)
    row={m:mul(u,A)[None,:] for m,A in coefficients.items()}
    # Translation radical of the exact coefficient row at arbitrary offsets.
    polar=np.zeros((n,original.shape[1],n),dtype=np.uint8)
    for term,A in row.items():
        if term.bit_count()==2:
            a=(term&-term).bit_length()-1
            b=term.bit_length()-1
            polar[a,:,b]^=A[0]
            polar[b,:,a]^=A[0]
    radical=null(polar.reshape(-1,n))
    at_origin=specialize(row,np.zeros(n,dtype=np.uint8),radical)[0]
    assert not any(term.bit_count()>1 and mat.any() for term,mat in at_origin.items())
    difference=np.array([at_origin.get(1<<i,np.zeros_like(row[0]))[0]
                         for i in range(len(radical))],dtype=np.uint8)
    codim=rank(difference,rref) if len(radical) else 0
    print("STEP43_ROW",json.dumps({"cell":cell,"affine_annihilator":best[0],
             "exact_translation_dim":len(radical)-codim,
             "exact_dependence_dim":n-len(radical)+codim}),flush=True)
    print("STEP43_GLOBAL",json.dumps({"cell":cell,"source":diagnostic(coefficients,rref),
             "core":diagnostic(core,rref),"elimination":global_steps}),flush=True)
    for d in dims:
        if len(flag)<d: continue
        basis=np.array([[(p>>j)&1 for j in range(n)] for p in flag[:d]],dtype=np.uint8)
        F=null(basis)
        R,piv=rref(F)
        cases=[]
        for trial in range(4):
            bits=rng.getrandbits(len(F))
            base=np.zeros(n,dtype=np.uint8)
            # RREF changes row equations; solve F a = assigned via its pivot-column square system.
            A=F[:,piv]
            ext=np.concatenate((A,np.array([[(bits>>i)&1] for i in range(len(F))],dtype=np.uint8)),axis=1)
            rr,pv=rref(ext)
            assert list(pv)==list(range(len(F)))
            base[piv]=rr[:,-1]
            assert np.array_equal(mul(F,base),ext[:,-1])
            spec,forms=specialize(core,base,basis)
            verify_specialization(core,spec,base,basis)
            small,L,steps=strip(spec,rref,null)
            cases.append({"bits":bits,"before":diagnostic(spec,rref),"after":diagnostic(small,rref),
                          "elimination":steps})
            if trial==0 and d in ((26,28,30) if cell=="B0_11" else (20,22,24)):
                substitution=[None]*(1+max(w_idx.keys()|t_idx.keys()))
                for p,j in w_idx.items(): substitution[p]=forms[j]
                for p,j in t_idx.items(): substitution[p]={1<<(d+j)}
                before=singular(spec,P,rhs,quads,substitution,20)
                after=singular(small,mul(L,P),rhs,quads,substitution,25)
                # A verified contradiction is a certificate for this affine fiber only.
                cases[-1]["singular"]={"baseline":before,"stripped":after}
            print("STEP43_FIBER",json.dumps({"cell":cell,"free":d,"fixed":n-d,"trial":trial,**cases[-1]}),flush=True)
        result["dimensions"].append({"free":d,"cases":cases})
    Path(f"step43_{cell}.json").write_text(json.dumps(result))

#!/usr/bin/env python3
"""Exact scan of the 7-dimensional diagonal kernel for quintic HRSBFs, n=16.

Given any 273-bit coefficient mask f for homogeneous degree-5 rotation-symmetric
Boolean functions in 16 variables, enumerate its entire coset
    f + { h(u+v) : h in H_{8,5}^{RS} }
without evaluating the 128 lifts one by one.

For x=(u,u+z), a direction (a,b) becomes (p,q)=(a,a+b). Adding
k(u,v)=h(u+v) changes each derivative fiber by the constant D_q h(z).
Bucketing the 256 fiber deviations by the 7-bit derivative pattern and taking
a length-128 Walsh transform gives the centered derivative weight of all 128
lifts simultaneously. One representative of each of the 4,115 cyclic
nonzero-direction classes is checked.
"""
import argparse,itertools,json
from pathlib import Path
N=16; H=8; HALF=128

def toggle(s,x):
    if x in s:s.remove(x)
    else:s.add(x)
def cyclic_orbits(n,d):
    unseen=set(itertools.combinations(range(n),d));out=[]
    while unseen:
        rep=min(unseen); orb={tuple(sorted((i+s)%n for i in rep)) for s in range(n)}
        unseen-=orb;out.append((rep,sorted(orb)))
    return out
def rotate(x,s,b):
    s%=b
    return x if not s else ((x<<s)|(x>>(b-s)))&((1<<b)-1)
def canonical(x,b): return min(rotate(x,s,b) for s in range(b))
def period(x,b):
    return next(p for p in range(1,b+1) if rotate(x,p,b)==x)
MON=[]
for m in range(256):
    t=0
    for u in range(256):
        if (u&m)==m:t|=1<<u
    MON.append(t)
def fiber_profile(orb,z):
    anf=set()
    for sup in orb:
        terms={0}
        for v in sup:
            factors=(1<<v,) if v<H else ((1<<(v-H),0) if (z>>(v-H))&1 else (1<<(v-H),))
            nxt=set()
            for a in terms:
                for b in factors: toggle(nxt,a|b)
            terms=nxt
        for m in terms:toggle(anf,m)
    t=0
    for m in anf:t^=MON[m]
    return t
def build_basis(orbs):
    reps=sorted({canonical(z,H) for z in range(1,256)})
    return reps,[[fiber_profile(o,z) for z in reps] for _,o in orbs]
def rep_profiles(mask,basis):
    out=[0]*35
    while mask:
        low=mask&-mask;i=low.bit_length()-1
        for j,v in enumerate(basis[i]):out[j]^=v
        mask^=low
    return out
def reconstruct(reps,profiles):
    fibers=[None]*256;fibers[0]=0
    for rep,t in zip(reps,profiles):
        for s in range(8):
            zt=None;tt=0
            for u in range(256):
                x=u|((u^rep)<<8);xr=rotate(x,s,16);ut=xr&255
                z=(xr&255)^((xr>>8)&255)
                if zt is None:zt=z
                elif zt!=z:raise AssertionError
                if (t>>u)&1:tt|=1<<ut
            if fibers[zt] is not None and fibers[zt]!=tt:raise AssertionError
            fibers[zt]=tt
    assert all(v is not None for v in fibers);return fibers
PERM=[[[sum((((byte>>(bit^lo))&1)<<bit) for bit in range(8)) for byte in range(256)]][0] for lo in range(8)]
def translate(t,d):
    raw=t.to_bytes(32,"little");hi=d>>3;lo=d&7
    return int.from_bytes(bytes(PERM[lo][raw[i^hi]] for i in range(32)),"little")
def eval_orbit(o,x):
    v=0
    for sup in o:v^=int(all((x>>i)&1 for i in sup))
    return v
def fwht(a):
    a=list(a);s=1
    while s<len(a):
        for i in range(0,len(a),2*s):
            for j in range(i,i+s):
                x,y=a[j],a[j+s];a[j]=x+y;a[j+s]=x-y
        s*=2
    return a
def rank(vs):
    p={}
    for v in vs:
        while v:
            k=v.bit_length()-1
            if k in p:v^=p[k]
            else:p[k]=v;break
    return len(p)
def scan(mask):
    o16=cyclic_orbits(16,5);o8=cyclic_orbits(8,5)
    assert len(o16)==273 and len(o8)==7
    reps,basis=build_basis(o16);fibers=reconstruct(reps,rep_profiles(mask,basis))
    ht=[[eval_orbit(o,z) for z in range(256)] for _,o in o8]
    patterns=[[sum((ht[j][z]^ht[j][z^q])<<j for j in range(7)) for z in range(256)] for q in range(256)]
    for q in range(1,256):
        vec=[]
        for j in range(7):
            t=0
            for z in range(256):
                if ht[j][z]^ht[j][z^q]:t|=1<<z
            vec.append(t)
        assert rank(vec)==7
    trans=[[translate(fibers[z],p) for z in range(256)] for p in range(256)]
    dirs=sorted({canonical(d,16) for d in range(1,65536)});assert len(dirs)==4115
    allowed_rows=[];counts=[0]*128;energy=[0]*128
    for d in dirs:
        a=d&255;b=d>>8;p=a;q=a^b;bucket=[0]*128
        for z in range(256):
            bucket[patterns[q][z]]+=(fibers[z]^trans[z^q][p]).bit_count()-HALF
        vals=fwht(bucket);allowed=0;mult=period(d,16)
        for i,c in enumerate(vals):
            energy[i]+=mult*4*c*c
            if c==0:allowed|=1<<i;counts[i]+=1
        allowed_rows.append((d,allowed))
    survivors=(1<<128)-1
    for _,a in allowed_rows:survivors&=a
    cert=[];remaining=(1<<128)-1
    if not survivors:
        unused=list(allowed_rows)
        while remaining:
            k,nxt=min(enumerate(unused),key=lambda x:(remaining&x[1][1]).bit_count())
            d,a=unused.pop(k);new=remaining&a
            cert.append({"direction":hex(d),"before":remaining.bit_count(),"after":new.bit_count(),"allowed":hex(a)})
            remaining=new
    best=sorted(range(128),key=lambda i:(energy[i],-counts[i],i))[:10]
    return {"n":16,"degree":5,"base_coefficient_mask":hex(mask),"coset_size":128,
      "all_nonzero_q_kernel_derivative_rank":7,"surviving_lift_indices":[i for i in range(128) if (survivors>>i)&1],
      "bent_lift_exists":bool(survivors),"greedy_no_lift_certificate":cert,
      "best_lifts":[{"lift_index":i,"balanced_derivative_classes":counts[i],"autocorrelation_energy":energy[i]} for i in best],
      "interpretation":"Exact closure of the 7-bit diagonal-kernel coset; no universal nonexistence claim."}
if __name__=="__main__":
    if not __debug__:raise RuntimeError("Run without python -O")
    ap=argparse.ArgumentParser();ap.add_argument("--mask",required=True);ap.add_argument("--output",default="exact_kernel_lift_scan_d5.json");a=ap.parse_args()
    r=scan(int(a.mask,0));Path(a.output).write_text(json.dumps(r,indent=2)+"\n");print(json.dumps(r,indent=2))

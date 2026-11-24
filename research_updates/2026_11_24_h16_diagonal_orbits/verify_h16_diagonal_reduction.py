"""Self-contained exact closure of 32 raw H16 fibres using diagonal-dual parity."""
from time import perf_counter
"""Exact low Walsh bits for H16 fibres and H18 rotation orbits."""
from itertools import combinations
from collections import defaultdict
import numpy as np

def rotation(mask, shift, n=16):
    return ((mask << shift) | (mask >> (n-shift))) & ((1 << n)-1)
def pack(arr):
    return int.from_bytes(np.packbits(arr, bitorder='little').tobytes(), 'little')
def rank(vectors):
    pivots = {}
    for v in vectors:
        while v:
            p = v.bit_length()-1
            if p not in pivots:
                pivots[p] = v
                break
            v ^= pivots[p]
    return len(pivots)
def xor_selected(values, select):
    result = 0
    while select:
        bit = select & -select
        result ^= values[bit.bit_length()-1]
        select ^= bit
    return result

x = np.arange(1 << 16, dtype=np.uint32)
orb, seen = [], set()
for comb in combinations(range(16),4):
    v = sum(1 << u for u in comb)
    if v in seen:
        continue
    orbit = {rotation(v,j) for j in range(16)}
    seen.update(orbit)
    val = 0
    for w in orbit:
        val ^= pack((x & w) == w)
    orb.append(val)
assert len(orb)==116
def compressed(values,mask):
    sub=np.flatnonzero(np.unpackbits(np.frombuffer(mask.to_bytes(8192,'little'),dtype=np.uint8),bitorder='little'))
    return [pack(np.unpackbits(np.frombuffer(v.to_bytes(8192,'little'),dtype=np.uint8),bitorder='little')[sub]) for v in values]
# Reconstruct the quartic orbit masks and the layer of bidegree (3,1)
# in f(u,u+z). Keeping Boolean idempotence here is essential.
supports=[]
used=set()
for I in combinations(range(16),4):
    v=sum(1<<i for i in I)
    if v not in used:
        o={rotation(v,i) for i in range(16)}
        supports.append(o)
        used.update(o)
assert len(supports)==len(orb)==116
layers=defaultdict(int)
for index,O in enumerate(supports):
    for mon in O:
        prod=[(0,0)]
        for j in range(16):
            if mon>>j&1:
                k=j%8
                new_prod=[(u|(1<<k),z) for u,z in prod]
                if j>=8:
                    new_prod.extend((u,z|(1<<k)) for u,z in prod)
                prod=new_prod
        for u,z in prod:
            if u.bit_count()==3 and z.bit_count()==1:
                layers[(u,z)]^=1<<index

L_indices=[0,4,8,14,18,22,42,46,52,56,71,81,85,94,98,106]
free=[i for i in range(116) if i not in (0,57,99,113,115)]
cb=[(1<<j)|int(j in L_indices) for j in free]
forms=[m for _,m in sorted(layers.items()) if m]
def physical_fiber(c99,value):
    origin=(c99<<99)|c99|(1<<57)|(1<<113)
    H=[sum(((v&m).bit_count()%2)<<i for i,v in enumerate(cb)) for m in forms]
    b=[(m&value).bit_count()%2 ^ (m&origin).bit_count()%2 for m in forms]
    piv={}
    for v,s in zip(H,b):
        while v:
            k=v.bit_length()-1
            if k not in piv:
                piv[k]=(v,s)
                break
            u,t=piv[k]
            v^=u
            s^=t
        if not v and s:
            return None
    def lift(w, affine):
        for p in sorted(piv):
            a,s=piv[p]
            w ^= (((a&w).bit_count()&1)^(s if affine else 0))<<p
        return w
    o=origin ^ xor_selected(cb,lift(0,True))
    ds=[xor_selected(cb,lift(1<<j,False)) for j in range(len(cb)) if j not in piv]
    assert all((m&(o^value)).bit_count()%2==0 and all((m&v).bit_count()%2==0 for v in ds) for m in forms)
    assert rank(ds)==len(ds)
    return o,ds

def layer_value(coef):
    return sum(((f&coef).bit_count()&1)<<j for j,f in enumerate(forms))
lmask=[]
images=[]
for c in cb:
    v=layer_value(c)
    if rank(images+[v])>len(images):
        lmask.append(c)
        images.append(v)
assert len(lmask)==7
assert lmask == [0x2,0x4,0x8,0x1000,0x2000,0x4001,0x1000000]
print('layer coordinate basis:',*[hex(t) for t in lmask],flush=True)


def bits(v):
    while v:
        low=v&-v
        yield low.bit_length()-1
        v^=low

def diagonal_rows(word):
    # Reindex x=(u,u+z), with u in low bits and z indexing rows.
    truth=np.unpackbits(np.frombuffer(word.to_bytes(8192,"little"),dtype=np.uint8),bitorder="little")
    buf=np.packbits(truth[diag_index],axis=1,bitorder="little")
    return tuple(int.from_bytes(row.tobytes(),"little") for row in buf)

u=np.arange(256,dtype=np.uint32)
diag_index=u[None,:]|((u[:,None]^u[None,:])<<8)
up_masks=[sum(1<<i for i in range(256) if i>>j&1) for j in range(8)]
high_mask=sum(1<<i for i in range(256) if i.bit_count()>=3)

def low_walsh_bit(rows, other=None):
    if other is None:
        return sum(((v.bit_count()>>2)&1)<<i for i,v in enumerate(rows))
    return sum((((v^w).bit_count()>>2)&1)<<i for i,(v,w) in enumerate(zip(rows,other)))

def high_anf(truth):
    for j,mask in enumerate(up_masks):
        truth ^= (truth<<(1<<j))&mask
    return truth&high_mask

def reduce(v,piv):
    while v and v.bit_length()-1 in piv:
        v^=piv[v.bit_length()-1]
    return v


from collections import Counter
from math import comb

def subset_index(n,d):
    arr=[sum(1<<i for i in I) for I in combinations(range(n),d)]
    return arr,{m:i for i,m in enumerate(arr)}

def orbit8(v):
    return sorted({rotation(v,i,8) for i in range(8)})

reps=sorted({min(orbit8(v)) for v in range(256)})
orbit_pts=[orbit8(v) for v in reps]
matrix=np.array([[sum(1-2*((v&z).bit_count()&1) for v in O)
                 for O in orbit_pts] for z in reps],dtype=np.int16)

def span(vs):
    s=[0]
    for v in vs:s += [x^v for x in s]
    assert len(s)==len(set(s))
    return s

def pivots(vs):
    p={}
    for v in vs:
        t=reduce(v,p)
        if t:p[t.bit_length()-1]=t
    return p

def normal(v,p):
    for j in sorted(p,reverse=True):
        if v>>j&1:v^=p[j]
    return v

def fold_even(v):
    return sum(((v>>i)&1)<<(2*i) for i in range(8))

def N(v):
    return v^rotation(v,1,8)

T=[1]
for i in range(1,8):T.append(N(T[-1]))
assert rank(T)==8

def invariant_spaces():
    for i in range(9):
        j=8-i
        for b in range(1<<j):
            v=xor_selected(T,b)
            basis=[]
            for k in range(j):
                basis.append(fold_even(T[i+k])|(fold_even(v)<<1))
                v=N(v)
            for k in range(i):basis.append(fold_even(T[j+k])<<1)
            assert len(basis)==rank(basis)==8
            yield basis

def all_constraints():
    lhs={}
    num_spaces=0;num_cosets=0
    disagreements=[]
    dword=np.array([v*257 for v in range(256)],dtype=np.uint32)
    f0=[diagonal_rows(xor_selected(orb,(1<<113)|(1<<57)|(b<<99)|b))[0] for b in (0,1)]
    for E in invariant_spaces():
        num_spaces+=1
        pe=pivots(E)
        assert all(reduce(rotation(t,2,16),pe)==0 for t in E)
        pts=span(E)
        assert len(pts)==256
        diag_perp=np.ones(256,dtype=bool)
        for t in E:diag_perp &= np.bitwise_count(dword&t)%2==0
        U=pack(diag_perp)
        assert U.bit_count()>=16
        assert sum((v&255)==v>>8 for v in pts)>=16
        qbasis=[1<<i for i in range(16) if i not in pe]
        for a in span(qbasis):
            if normal(rotation(a,2,16)^a,pe):continue
            cos=[a^v for v in pts]
            D=sum(1<<(v&255) for v in cos if (v&255)==v>>8)
            assert D.bit_count()==0 or D.bit_count()>=16
            ch=(a&255)^(a>>8)
            mask=sum(((v&ch).bit_count()&1)<<v for v in range(256))
            # The signs outside D8 occur in R^2-orbits of size 8; their
            # aggregate contributes (256-|D|) or (256-|U|) modulo 16.
            rhs=tuple((U.bit_count()-2*((f^mask)&U).bit_count())%16 for f in f0)
            num_cosets+=1
            if D in lhs and lhs[D]!=rhs:
                disagreements.append((D,lhs[D],rhs))
            lhs[D]=rhs
    assert num_spaces==511
    print('spaces',num_spaces,'invariant cosets',num_cosets,'distinct diagonal subsets',len(lhs),
          'disagreements',len(disagreements),flush=True)
    return lhs,disagreements

def truth_image(zz,dr):
    piv={}
    for d in dr:
        t=reduce(sum(d[z]<<(256*i) for i,z in enumerate(zz)),piv)
        if t:piv[t.bit_length()-1]=t
    n=len(piv)
    width=4*len(zz)
    arr=np.zeros((1<<n,width),dtype=np.uint64)
    for i,b in enumerate(piv.values()):
        kb=np.frombuffer(b.to_bytes(8*width,'little'),dtype=np.uint64)
        t=1<<i
        arr[t:2*t]=arr[:t]^kb
    return piv,arr

def compact_key(v, n):
    return sum(int((x+256)//16)<<(6*i) for i,x in enumerate(v))

def actual_profiles_all_layers():
    indices=(0xff,0x55,0x11,0x33,0x77,1)
    plans=[(0,1),(0,2),(0,3),(0,4),(5,)]
    mat=[]
    origin,ds=physical_fiber(0,(1<<113)|(1<<57))
    dr=[diagonal_rows(xor_selected(orb,d)) for d in ds]
    bases={}
    for side in (0,1):
        for eta in range(128):
            c=(1<<113)|(1<<57)|(side<<99)|side
            c^=xor_selected(lmask,eta)
            bases[side,eta]=diagonal_rows(xor_selected(orb,c))
    tables={}
    start=perf_counter()
    for pattern in plans:
        zz=[indices[j] for j in pattern]
        piv,arr=truth_image(zz,dr)
        memo={}
        for key,rows in bases.items():
            word=sum(rows[z]<<(256*i) for i,z in enumerate(zz))
            for p in sorted(piv,reverse=True):
                if word>>p&1:word^=piv[p]
            if word not in memo:
                b=np.frombuffer(word.to_bytes(arr.shape[1]*8,'little'),dtype=np.uint64)
                w=np.bitwise_count(arr^b).reshape(-1,len(zz),4).sum(axis=2).astype(np.int16)
                spec=256-2*w
                assert not np.any(spec%16)
                codes=np.sum((((spec+256)//16).astype(np.int64))<<(6*np.arange(len(zz))),axis=1)
                memo[word]=set(np.unique(codes).tolist())
            tables[key,pattern]=memo[word]
        print('short table',pattern,'dimension',len(piv),'classes',len(memo),'seconds',round(perf_counter()-start,2),flush=True)
    return indices,plans,tables,bases,dr

def code_columns(rows,select):
    return np.sum(((rows[:,select]//16+16).astype(np.int64))<<(6*np.arange(len(select))),axis=1)

def enumerate_duals():
    G=[]
    for v in reps:
        if v.bit_count()>3:continue
        w=0
        for t in orbit8(v):w^=sum(1<<i for i in range(256) if i&t==t)
        G.append(w)
    assert len(G)==rank(G)==13
    data=[[],[]]
    w=0
    hist=[Counter(),Counter()]
    for i in range(1<<13):
        if i:w^=G[(i&-i).bit_length()-1]
        wt=w.bit_count()
        if wt not in (64,160):continue
        s=int(wt==160)
        hist[s]['weight']+=1
        v=np.array([(w>>t)&1 for t in reps],dtype=np.int16)
        z=256*(np.array(reps)==0)-2*(matrix@v)
        if np.any(z%16):continue
        hist[s]['div16']+=1
        data[s].append(z)
    print('degree3 exact candidate counts',hist,flush=True)
    return [np.array(a,dtype=np.int16).reshape(-1,36) for a in data]

def verify():
    # All affine sectors are established using the full 111 coefficient directions.
    for side in (0,1):
        anchor=(1<<113)|(1<<57)|(side<<99)|side
        g0=diagonal_rows(xor_selected(orb,anchor))[0]
        assert g0.bit_count()==(64 if side==0 else 160)
        assert all(diagonal_rows(xor_selected(orb,d))[0]==0 for d in cb)
        # Independent verification of degree <=2 on the fixed diagonal.
        anf=np.unpackbits(np.frombuffer(g0.to_bytes(32,"little"),dtype=np.uint8),bitorder="little")
        for j in range(8):
            b=anf.reshape(-1,2,1<<j)
            b[:,1,:]^=b[:,0,:]
        assert all(not anf[v] for v in range(256) if v.bit_count()>2)
    data=enumerate_duals()
    assert [len(r) for r in data]==[24,446]
    C,bad=all_constraints()
    assert not bad and len(C)==92
    for side,rows in enumerate(data):
        signs=(rows.astype(np.int32)@matrix.astype(np.int32).T)//256
        assert np.all(np.isin(signs,(-1,1)))
        mask=np.ones(len(rows),dtype=bool)
        for D,rhs in C.items():
            w=np.array([sum((D>>v)&1 for v in O) for O in orbit_pts],dtype=np.int32)
            mask&=(signs@w)%16==rhs[side]
        data[side]=rows[mask]
    assert [len(r) for r in data]==[16,110]
    zlist,patterns,tables,bases,dr=actual_profiles_all_layers()
    K_IDX=[1,3,9,11,13,15,21,24,28,32,34,38,45,47,53,55,67,69,70,72,74,76,78,80,86,89,91,93,97,103,107,109]
    km=sum(1<<j for j in K_IDX)
    assert rank([sum(((v&m).bit_count()%2)<<i for i,v in enumerate(cb)) for m in forms]
                +[sum(((v&km).bit_count()%2)<<i for i,v in enumerate(cb))])==7
    for side,arr in enumerate(data):
        result=[]
        for eta in range(128):
            mask=np.ones(len(arr),dtype=bool)
            for pat in patterns:
                Z=[reps.index(zlist[i]) for i in pat]
                mask&=np.isin(code_columns(arr,Z),list(tables[(side,eta),pat]))
            a=((1<<113)|(1<<57)|(side<<99)|side)^xor_selected(lmask,eta)
            rad=[]
            for z in reps:
                sym=0
                for (u,j),v in layers.items():
                    if z&j and (v&a).bit_count()&1:sym^=1<<u
                if not sym:rad.append(reps.index(z))
            mask&=np.all(np.isin(arr[:,rad],[0,32,-32,64,-64,128,-128,256,-256]),axis=1)
            result.append(int(mask.sum()))
        closed=[i for i,v in enumerate(result) if not v]
        print("side",side,"closed",closed,"histogram",sorted(Counter(result).items()),flush=True)
        if side==0:
            assert closed==[0,7,10,17,20,25,28,30,32,39,42,49,52,57,60,62,65,68,73,75,76,82,85,95,97,100,105,107,108,114,117,127]
            assert all((xor_selected(lmask,e)&km).bit_count()%2==0 for e in closed)
        else:
            assert not closed
    print("PASS: 32 complete raw B0_11 fibres are impossible.",flush=True)

if __name__=="__main__":
    verify()

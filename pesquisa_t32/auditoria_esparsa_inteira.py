"""Exact CPU audit for all one/two-orbit homogeneous RS functions at n=16.
Independent orbit enumeration and integer XOR/popcount; no CUDA or float GEMM.
"""
import itertools, json, hashlib, time
from pathlib import Path
import numpy as np

def check(degree):
    started=time.monotonic()
    n=16
    groups={}
    for support in itertools.combinations(range(n),degree):
        rotations={tuple(sorted((i+s)%n for i in support)) for s in range(n)}
        rep=min(rotations)
        if rep not in groups: groups[rep]=sorted(rotations)
    reps=sorted(groups)
    x=np.arange(65536,dtype=np.uint32)
    u=np.arange(256,dtype=np.uint32)
    ix=[u | ((u ^ z)<<8) for z in range(1,256)]
    tables=[]; fibers=[]
    for rep in reps:
        table=np.zeros(65536,dtype=np.uint8)
        for monomial in groups[rep]:
            mask=sum(1<<i for i in monomial)
            table ^= (x & mask)==mask
        if np.any(table[u | (u<<8)]):raise RuntimeError('Diagonal control failed')
        tables.append(int.from_bytes(np.packbits(table,bitorder='little').tobytes(),'little'))
        fibers.append([int.from_bytes(np.packbits(table[v],bitorder='little').tobytes(),'little') for v in ix])
    tested=0; weight_excluded=0; fiber_excluded=0; survivors=[]; digest=hashlib.sha256()
    for support in itertools.chain(((i,) for i in range(len(reps))),itertools.combinations(range(len(reps)),2)):
        i=support[0]; j=support[-1]
        table=tables[i] if len(support)==1 else tables[i]^tables[j]
        weight=table.bit_count(); tested+=1
        if weight not in (32640,32896):
            weight_excluded+=1
            witness=('W0',weight)
        else:
            witness=None
            for z in range(255):
                bits=fibers[i][z] if len(support)==1 else fibers[i][z]^fibers[j][z]
                w=bits.bit_count()
                if w!=128:
                    fiber_excluded+=1;witness=(z+1,w);break
            if witness is None:survivors.append(support)
        digest.update((str(support)+':'+str(witness)+'\n').encode())
    expected=len(reps)*(len(reps)+1)//2
    if tested!=expected:raise RuntimeError('Incomplete enumeration')
    return dict(n=n,degree=degree,orbits=len(reps),tested=tested,expected=expected,
        weight_exclusions=weight_excluded,fiber_exclusions=fiber_excluded,
        surviving_supports=survivors,witness_digest=digest.hexdigest(),
        elapsed_seconds=round(time.monotonic()-started,3),
        method='independent orbit generation, exact integer XOR and bit_count; no GPU/floating products')

if __name__=='__main__':
    results=[check(5),check(7)]
    out=Path(__file__).with_name('auditoria_esparsa_inteira.json')
    out.write_text(json.dumps({'results':results,'scope':'Only supports of size 1 or 2; not a universal result.'},indent=2)+'\n')
    print(out.read_text())

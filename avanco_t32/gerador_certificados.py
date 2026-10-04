from pathlib import Path
import sys,itertools,random,json,time
sys.path.insert(0,str(Path(__file__).resolve().parent))
import verificador_integrado as v
from functools import lru_cache

orbs32=v.orbit_basis(32,3);orbs16=v.orbit_basis(16,3)
tri16={mon:j for j,o in enumerate(orbs16) for mon in o}
tri32={sum(1<<x for x in mon):1<<j for j,o in enumerate(orbs32) for mon in o}
hrows=[0]*35
for j,o in enumerate(orbs32):
    mon=tuple(sorted({x%16 for x in o[0]}))
    if len(mon)==3:hrows[tri16[mon]] |= 1<<j
v.require(all(x.bit_count()==4 for x in hrows),'Each quotient generator needs four lifts')

@lru_cache(100000)
def evaluation(x):
    bits=[1<<i for i in range(32) if x>>i&1]
    ans=0
    for a,b,c in itertools.combinations(bits,3):ans^=tri32[a|b|c]
    return ans

def polar_matrices(h):
    Bs=[[0]*16 for _ in range(16)]
    for j,o in enumerate(orbs16):
        if not h>>j&1:continue
        for a,b,c in o:
            for z,i,k in [(a,b,c),(b,a,c),(c,a,b)]:
                Bs[z][i]^=1<<k;Bs[z][k]^=1<<i
    return Bs

def polar(Bs,z):
    rows=[0]*16
    for i in range(16):
        if z>>i&1:
            for j in range(16):rows[j]^=Bs[i][j]
    return rows

def reps():
    return [z for z in range(1,65536) if z==min(((z<<i)|(z>>(16-i)))&65535 for i in range(16))]

def certify(h,zs,limit=10000):
    Bs=polar_matrices(h)
    if not any(polar(Bs,65535)):
        return {'h':hex(h),'type':'constant_ones_fiber'}
    pivots={};equations=[]
    def insert(a,b,label):
        equations.append({'row':hex(a),'rhs':b,**label})
        cert=1<<(len(equations)-1)
        while a:
            p=a.bit_length()-1
            if p not in pivots:pivots[p]=(a,b,cert);return None
            aa,bb,cc=pivots[p];a^=aa;b^=bb;cert^=cc
        return cert if b else None
    for j,row in enumerate(hrows):insert(row,(h>>j)&1,{'kind':'h','index':j})
    tested=0
    for z in zs[:limit]:
        B=polar(Bs,z)
        kernel=v.kernel_basis(B,16)
        if len(kernel)!=2:continue
        tested+=1
        r=next(k for k in kernel if k not in (0,z))
        row=evaluation(r|((r^z)<<16))^evaluation(z<<16)
        cert=insert(row,1,{'kind':'fiber','z':z,'r':r})
        if cert is not None:
            used=[e for i,e in enumerate(equations) if cert>>i&1]
            return {'h':hex(h),'type':'linear_contradiction','rank14_fibers_processed':tested,
                    'equations':used,'equation_count':len(used),'all_family_free_bits':120}
    return {'h':hex(h),'type':'not_excluded','rank14_fibers_processed':tested,'linear_rank':len(pivots)}

if __name__=='__main__':
    start=time.perf_counter()
    zs=reps();rng=random.Random(32026);rng.shuffle(zs)
    hs=[1<<i for i in range(35)] + [rng.getrandbits(35) for _ in range(10)]
    out=[]
    for h in hs:
        r=certify(h,zs);out.append(r)
        print(json.dumps({k:v for k,v in r.items() if k!='equations'}),flush=True)
    Path(__file__).with_suffix('.json').write_text(json.dumps({'seconds':time.perf_counter()-start,'representatives':len(zs),'results':out},indent=2),encoding='utf-8')

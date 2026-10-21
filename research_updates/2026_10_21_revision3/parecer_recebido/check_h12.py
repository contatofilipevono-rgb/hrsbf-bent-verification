import random
N=12
def rot(m,k=1): return ((m<<k)|(m>>(N-k)))&0xFFF
def orbit(m):
    s={m}; x=rot(m)
    while x!=m: s.add(x); x=rot(x)
    return s
def mask(S): return sum(1<<i for i in S)
reps=[(0,1,2,3),(0,1,2,4),(0,1,2,5),(0,1,2,6),(0,1,2,7),(0,4,5,6),(0,3,4,5),(0,2,3,4),(0,1,3,4),(0,1,3,5),(0,1,3,6),(0,1,3,7),(0,4,5,7),(0,3,4,6),(0,2,3,5),(0,1,4,5),(0,1,4,6),(0,1,4,7),(0,1,4,8),(0,3,4,7),(0,2,3,6),(0,1,5,6),(0,1,5,7),(0,1,5,8),(0,3,4,8),(0,2,3,7),(0,1,6,7),(0,2,6,7),(0,3,6,7),(0,4,6,7),(0,2,5,6),(0,3,5,6),(0,2,4,5),(0,2,4,6),(0,2,4,7),(0,2,4,8),(0,3,5,7),(0,2,5,7),(0,2,5,8),(0,3,5,8),(0,2,6,8),(0,3,6,8),(0,3,6,9)]
orbs=[orbit(mask(r)) for r in reps]
allm=set().union(*orbs)
print("A: n orbits",len(orbs),"sizes ok",sorted(len(o) for o in orbs)==sorted([12]*40+[6]*2+[3]),"disjoint",sum(len(o) for o in orbs)==len(allm)==495)
sizes=[len(o) for o in orbs]
# truth tables p_j(x)
pop=lambda x:bin(x).count("1")
P=[[sum(1 for m in o if (x&m)==m)&1 for x in range(4096)] for o in orbs]
masks8=[255,383,639,509,447,703,765,831,1013,507,479,735,893,863,1375,763,927,1003,1005,503,495,751,957,879,1391,891,943,1455,1403,759,975,983,987,989,887,1399,955,951,1463,1467,1495,1499,1755]
o8=[frozenset(orbit(m)) for m in masks8]
print("B: 8-masks popcount8",all(pop(m)==8 for m in masks8),"distinct orbits",len(set(o8)),"cover 495",len(set().union(*o8))==495)
# Q_j as dict monomial->coef (monomials frozenset of vars), via (3.2)
def subspace_points(m):
    pts=[];s=m
    while True:
        pts.append(s)
        if s==0:break
        s=(s-1)&m
    return pts
def Q(m):
    pts=subspace_points(m)
    v=[frozenset(x for x in pts if P[i][x]) for i in range(43)]
    q={}
    for i in range(43):
        if (len(v[i])//2)&1: q[frozenset([i])]=1
        for j in range(i+1,43):
            if ((len(v[i])&1)*(len(v[j])&1)+len(v[i]&v[j]))&1: q[frozenset([i,j])]=1
    return q,v
Qs=[];Vs=[]
for m in masks8:
    q,v=Q(m);Qs.append(q);Vs.append(v)
# test (3.2) against direct weight bit1
random.seed(1);ok=True
for t in range(30):
    c=[random.getrandbits(1) for _ in range(43)]
    j=random.randrange(43)
    wt=sum((sum(c[i]&P[i][x] for i in range(43))&1) for x in subspace_points(masks8[j]))
    val=0
    for mon in Qs[j]:
        val^=all(c[i] for i in mon)
    if val!=((wt>>1)&1): ok=False
print("C: (3.2) matches bit1 of restricted weight:",ok)
# Boolean ring poly ops: poly = set of frozenset monomials (xor)
def padd(a,b): return a^b
def pmul(a,b):
    r=set()
    for x in a:
        for y in b:
            r^={x|y}
    return r
Qp=[set(q.keys()) for q in Qs]
def lin(idx): return {frozenset([i]) for i in idx}
one={frozenset()}
def T(pairs):
    r=set()
    for j,v in pairs:
        r^=pmul(Qp[j],one if v==-1 else {frozenset([v])})
    return r
T1=[(1,7),(3,1),(5,32),(8,9),(10,5),(12,13),(13,30),(15,20),(17,16),(19,3),(21,29),(24,36),(26,27),(28,34),(31,22),(33,11),(34,24),(36,18),(38,41),(40,-1),(40,40),(41,38)]
T2=[(42,-1)]
T3=[(30,-1),(30,26),(30,40),(30,42),(40,-1),(40,26),(40,40),(40,42),(42,0),(42,1),(42,2),(42,6),(42,7),(42,9),(42,12),(42,15),(42,18),(42,23),(42,24),(42,25),(42,32),(42,34),(42,36),(42,37)]
R1=lin([1,7,9,18,24,32,34,36]);R2=lin([26,40,42]);R3=lin([0,1,2,6,7,9,12,15,18,23,24,25,32,34,36,37])
print("D: sizes",len(T1),len(T2),len(T3),"R1",T(T1)==R1,"R2",T(T2)==R2,"R3",T(T3)==R3)
# (3.8)
q30=Qp[30]
L=lin([0,2,6,12,15,23,25,37])
print("E: Q30 = L+c26+c40+c26c42:",q30==(L^lin([26,40])^{frozenset([26,42])}), "L=R1+R3",L==(R1^R3))
rhs=q30^R1^R3^pmul(one^{frozenset([42])},R2)
print("   (3.8):",rhs=={frozenset([40,42])})
# periodic restriction
def rest(y): return y|(y<<4)|(y<<8)
alpha=[15,18,19,23,24];J=[1,2,3,5,6,7,8,9,11,12,13,16,17,20,21,22,25,27,28,29,30,32,34,36,38,39,41]
def g_basis(i): return [P[i][rest(y)] for y in range(16)]
A=[ (bin(y)[2:].zfill(4)[::-1].count("1")) for y in range(16)]
def bit(y,k):return (y>>k)&1
Aa=[(bit(y,0)&bit(y,1))^(bit(y,1)&bit(y,2))^(bit(y,2)&bit(y,3))^(bit(y,3)&bit(y,0)) for y in range(16)]
Bb=[(bit(y,0)&bit(y,2))^(bit(y,1)&bit(y,3)) for y in range(16)]
Cc=[(bit(y,0)&bit(y,1)&bit(y,2))^(bit(y,0)&bit(y,1)&bit(y,3))^(bit(y,0)&bit(y,2)&bit(y,3))^(bit(y,1)&bit(y,2)&bit(y,3)) for y in range(16)]
Dd=[bit(y,0)&bit(y,1)&bit(y,2)&bit(y,3) for y in range(16)]
good=True
for i in range(43):
    t=g_basis(i)
    a=1 if i in alpha else 0;b=1 if i==40 else 0;c=1 if i in J else 0;d=1 if i==42 else 0
    exp=[(a&Aa[y])^(b&Bb[y])^(c&Cc[y])^(d&Dd[y]) for y in range(16)]
    if exp!=t: good=False;print("  mismatch orbit",i)
print("F: (3.4)-(3.5) coefficients correct:",good)
# 16 codes
res=[]
for code in range(16):
    a,b,c,d=code&1,(code>>1)&1,(code>>2)&1,(code>>3)&1
    g=[(a&Aa[y])^(b&Bb[y])^(c&Cc[y])^(d&Dd[y]) for y in range(16)]
    ok=all(sum(1-2*(g[y]^g[y^u]) for y in range(16))%3==0 for u in range(1,16))
    tt=sum(g[y]<<y for y in range(16))
    if ok: res.append((code,hex(tt)))
print("G: codes passing mod-3 test:",res)
# parametrization
free=list(range(24))+[25]+list(range(27,36))+[38,39]
print("H: |I|",len(free),"determined",sorted(set(range(43))-set(free)))
# sanity: Lemma 3.1 direct on a known bent? use n=12 PKP-free check: verify Walsh/AC on random f
f=[random.getrandbits(1) for _ in range(4096)]
def wsum(f):
    # fast WHT
    a=[1-2*v for v in f];h=1
    while h<4096:
        for i in range(0,4096,2*h):
            for j in range(i,i+h):
                x,y=a[j],a[j+h];a[j],a[j+h]=x+y,x-y
        h*=2
    return a
W=wsum(f)
Wsq=[w*w for w in W]
# C(u)=2^-12 sum_a W^2 (-1)^{a.u}  -> WHT of Wsq/4096
C=wsum.__call__  # placeholder
def wht(a):
    a=a[:];h=1
    while h<4096:
        for i in range(0,4096,2*h):
            for j in range(i,i+h):
                x,y=a[j],a[j+h];a[j],a[j+h]=x+y,x-y
        h*=2
    return a
Cu=[v//4096 for v in wht(Wsq)]
direct=[sum(1-2*(f[x]^f[x^u]) for x in range(4096)) for u in (1,77,4095)]
print("I: Lemma 2.2 formula matches",[Cu[u] for u in (1,77,4095)]==direct)

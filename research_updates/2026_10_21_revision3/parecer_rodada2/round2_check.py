"""Independent round-2 checks of H12 article data (reads only the article and one Lean file)."""
import re, sys, itertools, random
from pathlib import Path

art = Path(sys.argv[1]).read_text(encoding='utf-8')
lean = Path(sys.argv[2]).read_text(encoding='utf-8')
N = 12
out = []
def ok(label, cond):
    out.append(f"{'PASS' if cond else 'FAIL'}  {label}")

# ---------- Appendix A ----------
rows = re.findall(r'^\|\s*(\d+)\s*\|\s*\$\\\{([\d,]+)\\\}\$\s*\|\s*(\d+)\s*\|', art, re.M)
reps = [(int(i), [int(t) for t in s.split(',')], int(sz)) for i, s, sz in rows]
ok('Appendix A has 43 rows indexed 0..42', [r[0] for r in reps] == list(range(43)))
def mask(S): return sum(1 << i for i in S)
def rot(m, r): return ((m << r) | (m >> (N - r))) & 0xFFF
orbits = []
for _, S, sz in reps:
    o = sorted({rot(mask(S), r) for r in range(N)})
    orbits.append(o)
    if len(o) != sz: ok(f'orbit size {S}', False)
allsup = [m for o in orbits for m in o]
ok('orbits disjoint and cover 495 supports', len(allsup) == 495 == len(set(allsup)) and all(bin(m).count('1') == 4 for m in allsup))

lean_orbits = eval(re.search(r'def quarticOrbits : List \(List Nat\) := (\[\[.*?\]\])\ndef', lean, re.S).group(1))
ok('Lean quarticOrbits == Appendix A orbits (index by index, as sets)', [sorted(o) for o in lean_orbits] == orbits)
ok('Lean orbit lists have no duplicates', all(len(o) == len(set(o)) for o in lean_orbits))

# burnside count for n=16
from math import comb
ok('Burnside: 43 orbits at n=12', (comb(12,4)+comb(6,2)+2*comb(3,1))//12 == 43)
ok('Burnside: 116 orbits at n=16', (comb(16,4)+comb(8,2)+2*comb(4,1))//16 == 116)

# ---------- basis truth vectors ----------
X = range(1 << N)
def pval(j, x): return sum(((x & s) == s) for s in orbits[j]) & 1
P = [[pval(j, x) for x in X] for j in range(43)]
def f_of(c): return [sum(c[j] & P[j][x] for j in range(43)) & 1 for x in X]

# ---------- filters ----------
masks_txt = re.search(r'\\begin\{gathered\}\s*255(.*?)\\end\{gathered\}', art, re.S).group(0)
fmasks = [int(t) for t in re.findall(r'\d+', masks_txt.replace('\\begin{gathered}', '').replace('\\end{gathered}', ''))]
ok('43 filter masks, popcount 8', len(fmasks) == 43 and all(bin(m).count('1') == 8 for m in fmasks))
comp_orbit = {}
for m in fmasks:
    comp = 0xFFF ^ m
    k = next(j for j, o in enumerate(orbits) if comp in o)
    comp_orbit.setdefault(k, []).append(m)
ok('filter masks hit 43 distinct 8-set orbits', len(comp_orbit) == 43)

def subspace(m):
    bits = [i for i in range(N) if m >> i & 1]
    res = []
    for t in range(256):
        x = 0
        for k, b in enumerate(bits):
            if t >> k & 1: x |= 1 << b
        res.append(x)
    return res

# Q as dict: frozenset of vars -> 1 (linear: {i}, quadratic {i,j})
def filterQ(m):
    V = subspace(m)
    vs = [[P[j][x] for x in V] for j in range(43)]
    w = [sum(v) for v in vs]
    Q = set()
    for i in range(43):
        if (w[i] // 2) % 2: Q ^= {frozenset([i])}
    for i in range(43):
        for j in range(i+1, 43):
            inter = sum(a & b for a, b in zip(vs[i], vs[j]))
            if ((w[i] % 2) * (w[j] % 2) + inter) % 2: Q ^= {frozenset([i, j])}
    return Q, w, vs
Qs = []; Ws = []
for m in fmasks:
    Q, w, vs = filterQ(m); Qs.append(Q); Ws.append(w)
ok('parity of every basis restriction is even (A9 tautology)', all(x % 2 == 0 for w in Ws for x in w))

# (3.2) vs actual second bit on random c
def evalpoly(Q, c): return sum(all(c[i] for i in mon) for mon in Q) & 1
random.seed(7)
good = True
for _ in range(25):
    c = [random.randint(0, 1) for _ in range(43)]
    f = f_of(c)
    for m, Q in zip(fmasks, Qs):
        wt = sum(f[x] for x in subspace(m))
        if (wt // 2) % 2 != evalpoly(Q, c) or wt % 2: good = False
ok('(3.2) equals second weight bit; parity always 0 (25 random c x 43 filters)', good)

# ---------- Appendix B identities ----------
def mul_var(Q, v):
    if v == -1: return set(Q)
    R = set()
    for mon in Q: R ^= {frozenset(mon | {v})}
    return R
def parse_pairs(label):
    seg = art.split(f'For ${label}$, the pairs in $T_')[1].split('\\end{gathered}')[0]
    return [(int(a), int(b)) for a, b in re.findall(r'\((\d+),(-?\d+)\)', seg)]
R = {
 'R_1': [1,7,9,18,24,32,34,36],
 'R_2': [26,40,42],
 'R_3': [0,1,2,6,7,9,12,15,18,23,24,25,32,34,36,37],
}
for lab, lin in R.items():
    pairs = parse_pairs(lab)
    acc = set()
    for j, v in pairs: acc ^= mul_var(Qs[j], v)
    ok(f'{lab}: {len(pairs)} products reproduce (3.3)', acc == {frozenset([i]) for i in lin})
ok('Q30 has mask 975 = 0x3cf', fmasks[30] == 975 == 0x3cf)
L = {frozenset([i]) for i in [0,2,6,12,15,23,25,37]}
ok('Q30 = L + c26 + c40 + c26c42', Qs[30] == L ^ {frozenset([26]), frozenset([40]), frozenset([26,42])})
ok('L = R1 + R3', L == {frozenset([i]) for i in R['R_1']} ^ {frozenset([i]) for i in R['R_3']})
# (3.8) brute check on the 5 relevant vars + L treated symbolically via exhaustive on involved vars
inv = sorted({0,1,2,6,7,9,12,15,18,23,24,25,32,34,36,37,26,40,42})
good = True
for bits in itertools.product([0,1], repeat=len(inv)):
    c = [0]*43
    for i, b in zip(inv, bits): c[i] = b
    r1 = sum(c[i] for i in R['R_1']) & 1; r2 = sum(c[i] for i in R['R_2']) & 1; r3 = sum(c[i] for i in R['R_3']) & 1
    if (c[40] & c[42]) != (evalpoly(Qs[30], c) ^ r1 ^ r3 ^ ((1 ^ c[42]) & r2)): good = False; break
ok('(3.8) identity holds on all 2^19 assignments of involved vars', good)

# Q42 example
ok('Q42 mask 1755 = {0,1,3,4,6,7,9,10}', fmasks[42] == 1755 and [i for i in range(12) if 1755 >> i & 1] == [0,1,3,4,6,7,9,10])
w = Ws[42]; V = subspace(1755); vs = [[P[j][x] for x in V] for j in range(43)]
ok('Q42: w26=w40=w42=30, others = 0 mod 4', w[26] == w[40] == w[42] == 30 and all(w[i] % 4 == 0 for i in range(43) if i not in (26,40,42)))
ok('Q42: all pairwise intersections even', all(sum(a & b for a, b in zip(vs[i], vs[j])) % 2 == 0 for i in range(43) for j in range(i+1, 43)))
ok('Q42 == R2 as polynomial', Qs[42] == {frozenset([26]), frozenset([40]), frozenset([42])})

# ---------- (3.4)-(3.5) ----------
def r(y): return y | (y << 4) | (y << 8)
A = lambda y: [(y>>0&1)&(y>>1&1) ^ (y>>1&1)&(y>>2&1) ^ (y>>2&1)&(y>>3&1) ^ (y>>3&1)&(y>>0&1)][0]
B = lambda y: (y&1)&(y>>2&1) ^ (y>>1&1)&(y>>3&1)
def E3(y):
    b=[y>>k&1 for k in range(4)]; return (b[0]&b[1]&b[2])^(b[0]&b[1]&b[3])^(b[0]&b[2]&b[3])^(b[1]&b[2]&b[3])
D = lambda y: int(y == 15)
tt = lambda g: sum(g(y) << y for y in range(16))
cols = {tt(A):'A', tt(B):'B', tt(E3):'E3', tt(D):'D', 0:'0'}
Jtxt = re.search(r'J=\\\{([\d,]+)\\\}', art).group(1)
J = [int(t) for t in Jtxt.split(',')]
alpha = [15,18,19,23,24]
expect = {j:'0' for j in range(43)}
for j in alpha: expect[j] = 'A'
for j in J: expect[j] = 'E3'
expect[40] = 'B'; expect[42] = 'D'
got = {j: cols.get(sum(P[j][r(y)] << y for y in range(16)), '?') for j in range(43)}
ok('(3.4)-(3.5): restriction of each p_j to period-4 inputs', got == expect)
ok('truth tables A=0x1248 B=0x6ca0 E3=0x6880 D=0x8000', (tt(A),tt(B),tt(E3),tt(D)) == (0x1248,0x6ca0,0x6880,0x8000))

# ---------- Lemma 3.3 table ----------
tab = re.findall(r'^\|\s*(\d+)\s*\|\s*\$\((\d),(\d),(\d),(\d)\)\$\s*\|\s*`(0x[0-9a-f]+)`\s*\|\s*([^|]+)\|\s*([^|]+)\|\s*([^|]+)\|', art, re.M)
ok('periodic table has 16 rows', len(tab) == 16)
surv = []
tabok = True
for code, a, b, g, d, ttxt, wit, cg, res in tab:
    code=int(code); a,b,g,d = map(int,(a,b,g,d))
    if code != a + 2*b + 4*g + 8*d: tabok = False
    G = lambda y: (a&A(y)) ^ (b&B(y)) ^ (g&E3(y)) ^ (d&D(y))
    if tt(G) != int(ttxt,16): tabok = False; out.append(f'   truth table mismatch code {code}')
    C = {u: sum((-1)**(G(y)^G(y^u)) for y in range(16)) for u in range(1,16)}
    passes = all(v % 3 == 0 for v in C.values())
    if passes: surv.append(code)
    wit = wit.strip()
    if wit != '---':
        u = int(wit); cgv = int(cg.strip().replace('−','-')); rv = int(res.strip())
        if C[u] != cgv or cgv % 3 != rv or rv == 0: tabok = False; out.append(f'   witness mismatch code {code}: C={C[u]} table={cgv}')
    elif not passes: tabok = False
ok('Lemma 3.3 table: codes, truth tables, witnesses, residues', tabok)
ok('survivors are exactly codes 2,3,8,15', surv == [2,3,8,15])
# (3.7) on actual f: C_f(r(u)) == C_g(u) mod 3 for random c
good = True
for _ in range(5):
    c = [random.randint(0,1) for _ in range(43)]
    f = f_of(c)
    g = [f[r(y)] for y in range(16)]
    for u in range(1,16):
        Cf = sum((-1)**(f[x]^f[x ^ r(u)]) for x in X)
        Cg = sum((-1)**(g[y]^g[y^u]) for y in range(16))
        if (Cf - Cg) % 3: good = False
ok('(3.7) C_f(r(u)) = C_g(u) mod 3 (5 random c, all u)', good)

# ---------- parametrization ----------
I = list(range(24)) + [25,27,28,29,30,31,32,33,34,35,38,39]
ok('|I| = 36, complement = {24,26,36,37,40,41,42}', len(I) == 36 and sorted(set(range(43)) - set(I)) == [24,26,36,37,40,41,42])
good = True
for (a,b,g,d) in [(0,1,0,0),(1,1,0,0),(0,0,0,1)]:
    for _ in range(200):
        c = [0]*43
        for i in I: c[i] = random.randint(0,1)
        c[24] = a ^ c[15] ^ c[18] ^ c[19] ^ c[23]
        c[40] = b; c[42] = d; c[26] = b ^ d
        c[36] = (c[1]+c[7]+c[9]+c[18]+c[24]+c[32]+c[34]) & 1
        c[37] = (c[0]+c[1]+c[2]+c[6]+c[7]+c[9]+c[12]+c[15]+c[18]+c[23]+c[24]+c[25]+c[32]+c[34]+c[36]) & 1
        c[41] = (g + sum(c[j] for j in J if j != 41)) & 1
        vals = (sum(c[j] for j in alpha)&1, c[40], sum(c[j] for j in J)&1, c[42])
        rs = [sum(c[i] for i in R[k]) & 1 for k in R]
        if vals != (a,b,g,d) or any(rs): good = False
ok('(3.9) parametrization satisfies tuple + R1=R2=R3=0 (600 samples)', good)

# ---------- certificate table arithmetic ----------
ok('C.2 node sums: elim+split+contra+term = nodes; leaves = splits+1',
   all(e+s+co+t == n and co+t == s+1 for n,e,s,co,t in [(142802,116087,13357,11018,2340),(142930,116215,13357,11038,2320),(64343,50116,7113,5121,1993)]))
ok('sum of Lean terminal assignments = 164288 (= Python checker count)', 46912+46400+70976 == 164288)

# ---------- antipodal quadratic bent; abstract word count ----------
def wht(f):
    a = [1-2*v for v in f]; h = 1
    while h < len(a):
        for i in range(0, len(a), 2*h):
            for j in range(i, i+h):
                x, y = a[j], a[j+h]; a[j], a[j+h] = x+y, x-y
        h *= 2
    return a
anti = [sum((x>>i&1)&(x>>(i+6)&1) for i in range(6)) & 1 for x in X]
ok('antipodal quadratic sum x_i x_{i+6} is bent', all(abs(v) == 64 for v in wht(anti)))
nonbent = all(any(abs(v) != 64 for v in wht(f_of([random.randint(0,1) for _ in range(43)]))) for _ in range(30))
ok('sanity: 30 random quartic c are non-bent', nonbent)
abstract = art.split('## Abstract')[1].split('**Keywords')[0]
out.append(f'INFO  abstract words = {len(abstract.split())}')
print('\n'.join(out))

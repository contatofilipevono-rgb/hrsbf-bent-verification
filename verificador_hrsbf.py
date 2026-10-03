#!/usr/bin/env python3
"""
Verificador Computacional: Nao-Existencia de HRSBF Cubicas (n != 0 mod 32).
Executa as checagens finitas da reducao, Teorema de Ward (136.697 condicoes) e buscas exaustivas.
Requer: Python >= 3.10, NumPy.
Uso:  python3 verificador_hrsbf.py          (padrao, ~30-40s)
      python3 verificador_hrsbf.py --slow   (inclui busca cubica exaustiva em n=14)
"""
import itertools, math, random, sys, time, collections
from pathlib import Path
_local_pkgs = Path(__file__).resolve().parent / "site-packages"
if _local_pkgs.is_dir() and str(_local_pkgs) not in sys.path:
    sys.path.insert(0, str(_local_pkgs))
import numpy as np

# ---------------------------------------------------------------- utilidades
def orbits(n, deg):
    """Orbitas de monomios de grau 'deg' sob rotacao em Z_n (cada orbita = lista de tuplas)."""
    seen, out = set(), []
    for mon in itertools.combinations(range(n), deg):
        if mon in seen: continue
        o = {tuple(sorted((i + s) % n for i in mon)) for s in range(n)}
        seen |= o; out.append(sorted(o))
    return out

def truth(orb, n):
    x = np.arange(1 << n, dtype=np.uint32); v = np.zeros(1 << n, dtype=np.uint8)
    for mon in orb:
        m = sum(1 << i for i in mon); v ^= ((x & m) == m).astype(np.uint8)
    return v

def to_int(v):  return int.from_bytes(np.packbits(v, bitorder='little').tobytes(), 'little')

def fwht(a):
    a = a.astype(np.int64).copy(); h = 1
    while h < len(a):
        a = a.reshape(-1, 2, h); a = np.stack([a[:, 0] + a[:, 1], a[:, 0] - a[:, 1]], 1).reshape(-1); h *= 2
    return a

def is_bent(v, n): return bool(np.all(np.abs(fwht(1 - 2 * v.astype(np.int64))) == (1 << (n // 2))))

def banner(s): print("\n" + "=" * 72 + "\n" + s + "\n" + "=" * 72)

# ------------------------------------------- [1] forca bruta (cubica / quartica)
def brute(n, deg):
    orbs = orbits(n, deg); k = len(orbs)
    tts = [truth(o, n) for o in orbs]; ints = [to_int(x) for x in tts]
    N = 1 << n; target = {N // 2 - (1 << (n // 2 - 1)), N // 2 + (1 << (n // 2 - 1))}
    cur = cand = bent = 0
    for g in range(1, 1 << k):                       # codigo de Gray
        cur ^= ints[(g & -g).bit_length() - 1]
        if cur.bit_count() in target:                # peso compativel com bent -> confirma por FWHT
            cand += 1; gray = g ^ (g >> 1); v = np.zeros(N, dtype=np.uint8)
            for i in range(k):
                if (gray >> i) & 1: v ^= tts[i]
            bent += is_bent(v, n)
    return k, cand, bent

def part1(slow):
    banner("[1] Forca bruta sobre TODAS as homogeneas RS (FWHT confirma cada candidata)")
    jobs = [(n, 3) for n in (4, 6, 8, 10, 12)] + [(8, 4), (10, 4)] + ([(14, 3)] if slow else [])
    for n, d in jobs:
        t0 = time.time(); k, cand, bent = brute(n, d)
        print(f"  grau {d}, n={n:2d}: {k:2d} orbitas, 2^{k} funcoes, peso compativel: {cand:6d}, BENT: {bent}  ({time.time()-t0:.0f}s)")
        assert bent == 0

# ---------------------------------------------- [2] enumeracao das geradoras t=16
def part2():
    banner("[2] Geradoras em t=16: 35 cubicas (composicoes ciclicas) + 7 quadraticas (+ L)")
    t = 16
    comps = sorted({min(g[i:] + g[:i] for i in range(3)) for g in itertools.product(range(1, t), repeat=3) if sum(g) == t})
    assert len(comps) == 35 == len(orbits(t, 3)) == 105 // 3
    print("  composicoes ciclicas (g1,g2,g3), soma 16 -> monomio {0, g1, g1+g2}:")
    print("  " + " ".join(f"({a},{b},{c})" for a, b, c in comps))
    quad = [o for o in orbits(t, 2) if len(o) == t]; assert len(quad) == 7
    print("  pesos das quadraticas d=1..7:", [int(truth(o, t).sum()) for o in quad])
    assert int(truth(quad[3], t).sum()) == 2**15 - 2**11 == 30720      # erro A da revisao
    return orbits(t, 3), quad

# -------------------------------------------- [3] restricao ao subespaco periodico
def fold_anf(mon, n, t):
    par = collections.defaultdict(int); seen = set()
    for s in range(n):
        key = tuple(sorted((i + s) % n for i in mon))
        if key in seen: continue
        seen.add(key); par[frozenset(i % t for i in key)] ^= 1
    return {m for m, p in par.items() if p}

def part3():
    banner("[3] Restricao de orbitas cubicas de n=t*m (m impar) a x_{i+t}=x_i")
    print("  Verifica: restricao e RS; quais tipos aparecem; q_{t/2} NUNCA aparece (paridade).")
    for t in (2, 4, 8, 16):
        for m in (1, 3, 5, 7):
            n = t * m; types = collections.Counter(); seen = set()
            for mon in itertools.combinations(range(n), 3):
                if mon in seen: continue
                seen |= {tuple(sorted((i + s) % n for i in mon)) for s in range(n)}
                S = fold_anf(mon, n, t)
                while S:
                    a = next(iter(S)); orb = {frozenset((i + s) % t for i in a) for s in range(t)}
                    assert orb <= S, "restricao nao e RS!"
                    S -= orb; k = len(a)
                    if k == 2:
                        x, y = sorted(a); assert 2 * min((y - x) % t, (x - y) % t) != t, "q_{t/2} apareceu!"
                    types[{3: "cubica", 2: "quad", 1: "L"}[k]] += 1
            print(f"  t={t:2d} m={m} (n={n:3d}): {dict(types)}")
    print("  => L (forma linear de 1s) aparece para m>=3: o espaco a tratar e span(42 geradoras + L).")

# ------------------------------------------------------------ [4] Ward em t=16
def part4(cub, quad):
    banner("[4] Teorema de Ward em t=16 (42 geradoras e 42+L)")
    t = 16; N = 1 << t; xs = np.arange(N, dtype=np.uint32)
    rots = np.stack([((xs << s) | (xs >> (t - s))) & (N - 1) for s in range(t)])
    full = rots[8] != xs; reps = np.unique(rots.min(0)[full])
    print(f"  pontos de orbita completa: {full.sum()}  (= 16 x {len(reps)} representantes); fixos por shift 8: {(~full).sum()}")
    tabs = [truth(o, t) for o in cub + quad]
    L = truth([(i,) for i in range(t)], t); tabs_L = tabs + [L]
    for tb in tabs_L: assert tb[~full].sum() == 0, "geradora nao se anula nos pontos (u,u)"
    def ward(tbs):
        b = [to_int(tb[reps]) for tb in tbs]; k = len(b); f = [0] * 4
        for i in range(k): f[0] += b[i].bit_count() % 16 != 0
        for i, j in itertools.combinations(range(k), 2): f[1] += (b[i] & b[j]).bit_count() % 8 != 0
        for i, j, l in itertools.combinations(range(k), 3): f[2] += (b[i] & b[j] & b[l]).bit_count() % 4 != 0
        for i, j in itertools.combinations(range(k), 2):
            bij = b[i] & b[j]
            for l in range(j + 1, k):
                bijl = bij & b[l]
                for p in range(l + 1, k): f[3] += (bijl & b[p]).bit_count() % 2 != 0
        return f, [math.comb(k, r) for r in (1, 2, 3, 4)]
    for name, tbs in (("42 geradoras", tabs), ("42 + L (43)", tabs_L)):
        f, cnt = ward(tbs)
        print(f"  {name}: falhas ordens 1..4 = {f}; subconjuntos auditados = {sum(cnt)} ({'+'.join(map(str, cnt))})")
        assert f == [0, 0, 0, 0]
    # conferencia direta, independente de Ward: combinacoes aleatorias no espaco completo de 65536 pontos
    ints = [to_int(tb) for tb in tabs_L]; random.seed(1); bad = 0
    for _ in range(5000):
        c = 0
        for i in range(43):
            if random.random() < 0.5: c ^= ints[i]
        w = c.bit_count(); W0 = N - 2 * w
        bad += (w % 256 != 0) or (W0 % 512 != 0) or abs(W0) == 256
    print(f"  amostra direta de 5000 combinacoes: wt = 0 (mod 256) e W(0) = 0 (mod 512) -> violacoes: {bad}")
    assert bad == 0
    print("  => para toda h no span: |W_h(0)| = 256 e impossivel (W_h(0) e multiplo de 512).")

# ------------------------------------------------------ [5] t = 2, 4, 8 (completo)
def part5():
    banner("[5] t = 2, 4, 8: span completo (cubicas + quadraticas d<t/2 + L), W_h(0) vs 2^(t/2)")
    for t in (2, 4, 8):
        gens = [o for o in orbits(t, 3)] + [o for o in orbits(t, 2) if len(o) == t] + [[(i,) for i in range(t)]]
        tbs = [truth(o, t) for o in gens]; vals = set()
        for c in range(1 << len(tbs)):
            v = np.zeros(1 << t, dtype=np.uint8)
            for i in range(len(tbs)):
                if (c >> i) & 1: v ^= tbs[i]
            vals.add((1 << t) - 2 * int(v.sum()))
        ok = (1 << (t // 2)) not in vals and -(1 << (t // 2)) not in vals
        print(f"  t={t}: {len(tbs)} geradoras, 2^{len(tbs)} funcoes, W(0) in {sorted(vals)[:6]}{'...' if len(vals)>6 else ''}; "
              f"+-{1 << (t//2)} ausente: {ok}")
        assert ok

if __name__ == "__main__":
    part1("--slow" in sys.argv)
    cub, quad = part2(); part3(); part4(cub, quad); part5()
    banner("TUDO VERIFICADO.\n(O programa verifica as etapas finitas. Os lemas analiticos mostram que uma suposta\nf bent induziria uma g bent no espaco reduzido (g = f|_U); os testes de divisibilidade\ne as buscas exaustivas excluem essa possibilidade.)")

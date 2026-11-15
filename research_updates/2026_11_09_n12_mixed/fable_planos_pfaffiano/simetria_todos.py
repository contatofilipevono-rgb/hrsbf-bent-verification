"""Orbits of the 18,816 polars under the circulant units + multipliers (generators fixed by seed).
Usage: python simetria_todos.py edges <polars file> --shard i/n --out edges.json
       python simetria_todos.py orbits <polars file> <edges files...>"""
import os, sys, json, random, glob
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from simetria_circulante import circ_matrix, mult_matrix, rank2, apply_map, image_polar

if sys.argv[1] == "edges":
    from bitj import load_model
    from poisson3_lista import todos_subespacos3
    from cert_arvore import polar_data
    model = load_model(); Vs = todos_subespacos3()
    polars = open(sys.argv[2]).read().split()
    si, sm = map(int, sys.argv[sys.argv.index("--shard") + 1].split("/"))
    out = sys.argv[sys.argv.index("--out") + 1]
    rng = random.Random(3)
    units = [c for c in range(1, 4096) if rank2(circ_matrix(c)) == 12]
    gens = {"m5": mult_matrix(5), "m7": mult_matrix(7)}
    for c in rng.sample(units, 10):
        gens["c%x" % c] = circ_matrix(c)
    ymaps = {g: apply_map(M) for g, M in gens.items()}
    rng2 = random.Random(si)
    res = {}; bad = 0
    for k, hx in enumerate(polars):
        if k % sm != si:
            continue
        # a function with this polar (no (L5)/(L3) needed): the polar's base combination G0, plus a random phase
        from base12 import pack
        Bb, Gb, Gk, piv = model
        val = int(hx, 16)
        Bm = np.array([[(val >> (64 * a + z)) & 1 for z in range(64)] for a in range(15)], dtype=np.uint8)
        r = pack(Bm); comb = 0
        while r:
            c = r.bit_length() - 1; r ^= piv[c][0]; comb ^= piv[c][1]
        sel = [j for j in range(len(Bb)) if comb >> j & 1]
        T0 = np.bitwise_xor.reduce(Gb[sel], axis=0) if sel else np.zeros((64, 64), np.uint8)
        G1 = T0.copy()
        for j in range(Gk.shape[0]):
            if rng2.random() < 0.5:
                G1 ^= Gk[j]
        d = {}
        for g, ym in ymaps.items():
            a, b = image_polar(T0, ym), image_polar(G1, ym)
            if a != b:
                bad += 1
            d[g] = a
        res[hx] = d
    json.dump({"edges": res, "function_dependent": bad}, open(out, "w"))
    print("shard", si, "polars", len(res), "function-dependent images", bad)
else:
    polars = open(sys.argv[2]).read().split()
    S = set(polars)
    adj = {h: set() for h in polars}
    outside = 0; bad = 0
    for f in sys.argv[3:]:
        D = json.load(open(f)); bad += D["function_dependent"]
        for h, d in D["edges"].items():
            for g, im in d.items():
                if im in S:
                    adj[h].add(im); adj[im].add(h)
                else:
                    outside += 1
    seen = set(); comps = []
    for h in polars:
        if h in seen: continue
        st = [h]; comp = set()
        while st:
            x = st.pop()
            if x in comp: continue
            comp.add(x); st += list(adj[x] - comp)
        seen |= comp; comps.append(sorted(comp))
    from collections import Counter
    print("images outside the 18,816:", outside, "| function-dependent images:", bad)
    print("orbits:", len(comps), "| size distribution:", sorted(Counter(len(c) for c in comps).items()))
    json.dump(comps, open("orbitas_18816.json", "w"))

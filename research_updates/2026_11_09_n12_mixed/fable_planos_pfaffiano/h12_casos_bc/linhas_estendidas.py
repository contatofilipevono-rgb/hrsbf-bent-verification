"""Extended row test: rows Z' = {0, e_i, 63} + orbits of 21, 9, 27 (and optionally 7, 11, 13).
The phase enters these rows through a space of small rank; for each polar we try every phase class
(cosets of the kernel of phase -> (lambda, h) on Z') and ask whether some class keeps
sum_{z in Z'} r_b(z)^2 <= 4096 for every column b.  Applied to the (Pf4) polars of cases B, C split by (alpha,beta)."""
import sys, os, json, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bc_comum import *
from oito_parametros_lib import params

here = os.path.dirname(os.path.abspath(__file__))
homog = json.load(open(os.path.join(here, "homog1176.json")))
paridade = np.load(os.path.join(here, "paridade_tab.npy"))
tab8 = json.load(open(os.path.join(here, "oito_tabela.json")))

# phase basis (as t masks) and its (lambda,h) on all rows
piv = {}
for r in EQ:
    while r:
        c = r.bit_length() - 1
        if c in piv: r ^= piv[c]
        else: piv[c] = r; break
pr = {}
for c in sorted(piv):
    r = piv[c]
    for h in sorted(pr, reverse=True):
        if r >> h & 1: r ^= pr[h]
    for k in list(pr):
        if pr[k] >> c & 1: pr[k] ^= r
    pr[c] = r
freec = [c for c in range(43) if c not in pr]
phase = []
for c in freec:
    v = 1 << c
    for h, r in pr.items():
        if r >> c & 1: v |= 1 << h
    phase.append(v)
PH = [ftab_zw([v >> j & 1 for j in range(43)]) for v in phase]   # 20 tables F[z,w] (pure phase: h(z)+lambda(z).w)


def rotm(d):
    return ((d << 1) | (d >> 5)) & 63


def orbit(z):
    o = [z]; x = z
    for _ in range(5):
        x = rotm(x)
        if x not in o: o.append(x)
    return o


SETS = {
    "8": [0, 63] + [1 << i for i in range(6)],
}
SETS["8+21"] = SETS["8"] + orbit(21)
SETS["8+21+9"] = SETS["8+21"] + orbit(9)
SETS["8+21+9+27"] = SETS["8+21+9"] + orbit(27)
SETS["+7,11,13"] = SETS["8+21+9+27"] + orbit(7) + orbit(11) + orbit(13)


def classes(rows):
    """basis of phase vectors acting nontrivially on 'rows' (mod those acting trivially)."""
    vecs = []
    for F in PH:
        v = 0
        for k, z in enumerate(rows):
            v |= int(sum(int(F[z, w]) << w for w in range(64))) << (64 * k)
        vecs.append(v)
    # pick a maximal independent subset
    p = {}; chosen = []
    for i, v in enumerate(vecs):
        x = v
        while x:
            c = x.bit_length() - 1
            if c in p: x ^= p[c]
            else: p[c] = x; chosen.append(i); break
    return chosen


CL = {name: classes(rows) for name, rows in SETS.items()}
for name in SETS:
    print("row set", name, "|rows|", len(SETS[name]), "phase rank", len(CL[name]))

CASE = {(0, 0, 0): "A", (1, 1, 0): "B", (1, 0, 1): "C"}
results = collections.defaultdict(collections.Counter)
survivors = collections.defaultdict(list)
done = 0
for c in homog:
    k = params(c)
    case = CASE[k[:3]]
    if case == "A" or k[3] != k[4]:
        continue
    done += 1
    if done % 50 == 0:
        print("...", done, flush=True)
    code = sum(int(c[i]) << i for i in range(21))
    ev = not paridade[:, code].any()
    ok8 = tab8["".join(map(str, k))][0]
    t = t_from_coords(c)
    F0 = ftab_zw(t)
    key = (case, k[3:5])
    results[key]["pf4"] += 1
    flags = {}
    prev = True
    for name, rows in SETS.items():
        chosen = CL[name]
        if not prev:
            flags[name] = False
            continue
        if name == "+7,11,13" and not (ev and ok8):
            flags[name] = False
            continue
        ok_any = False
        for bits_ in range(1 << len(chosen)):
            F = F0.copy()
            for q, i in enumerate(chosen):
                if bits_ >> q & 1:
                    F ^= PH[i]
            R = spectrum_rows(F[rows])
            if (R ** 2).sum(axis=0).max() <= 4096:
                ok_any = True; break
        flags[name] = ok_any
        prev = ok_any
        results[key]["pass " + name] += ok_any
        results[key]["pass " + name + " & par"] += ok_any and ev
    if flags["+7,11,13"] and ev:
        survivors[key].append(c)
for key in sorted(results):
    print(key, dict(results[key]))
json.dump({"%s%d%d" % (k[0], *k[1]): v for k, v in survivors.items()}, open(os.path.join(here, "linhas_estendidas_sobrev.json"), "w"))

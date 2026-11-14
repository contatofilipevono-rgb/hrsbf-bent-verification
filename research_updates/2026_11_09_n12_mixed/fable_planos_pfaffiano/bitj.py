"""Next bit of the Poisson count on 4-flats (n = 12, degree 4, f quadratic in w).

For V a 4-dimensional subspace of W = F2^6 (given by its 2-dimensional annihilator V^perp), a coset
w0 + V and a character omega, put K_z = sum_{s in V} (-1)^{f(z, w0+s) + omega.s}.  Since f is quadratic
in w, K_z is in {0, +-4, +-8, +-16}.  Poisson in V^perp: sum_{nu in V^perp} (+-) W_f(alpha, omega+nu)
= 4 * sum_z (-1)^{alpha.z} K_z, and the left side is a sum of four values +-64, hence a multiple of
128.  So kappa_z = K_z / 4 satisfies sum_z (-1)^{alpha.z} kappa_z = 0 (mod 8) for all alpha, i.e.
   sum_{z containing I} kappa_z = 0 (mod 2^{3-|I|})  for |I| <= 3.
|I| <= 2 mod 2 is (Pf4).  The new condition used here is |I| <= 1 mod 4: with (Pf4) the sum is even,
and the bit  b(V, w0, omega, I) = (sum_{z >= I} kappa_z mod 4) / 2  must vanish.

Fixing the polar B, the unknowns are the 43 coordinates u of the part of f affine in w; b is a
polynomial in u of degree <= 2 (linear in the phase alpha, quadratic in lambda: the Arf invariant and
the radical condition).  The script
  (1) solves (L5) + (L3) (linear) as in poisson3_lista.py;
  (2) interpolates all b's exactly on the points of weight <= 2 of the solution space and checks the
      degree on random points;
  (3) linearises: if the constant 1 is in the span of the polynomials, the polar has no bent function;
      otherwise extracts the linear consequences, restricts and repeats.
Usage:
  python bitj.py controle <witnesses.json>
  python bitj.py polares <L3_212_resultado.txt> --shard i/m --out res.json
"""
import os, sys, json, time, pickle, argparse, itertools
import numpy as np

here = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, here)
Zs = np.arange(64)
par6 = np.array([bin(i).count("1") & 1 for i in range(64)], dtype=np.int64)
H64 = (1 - 2 * par6[(Zs[:, None] & Zs[None, :])]).astype(np.int64)          # Walsh matrix
IMASK = np.array([np.ones(64, np.int64)] + [((Zs >> i) & 1) for i in range(6)], dtype=np.int64)   # 7 x 64


def annihilators():
    out = set()
    for p in range(1, 64):
        for q in range(p + 1, 64):
            out.add(tuple(sorted({0, p, q, p ^ q})))
    return sorted(out)


ANN = annihilators()
assert len(ANN) == 651
Pm = np.array(ANN, dtype=np.int64)                                            # 651 x 4 (V^perp)
OM = []; W0 = []
for P in ANN:
    p, q = P[1], P[2]
    reps = {}
    for w in range(64):
        key = 0                                                               # omega mod V^perp
        cos = frozenset(w ^ x for x in P)
        reps.setdefault(cos, min(cos))
    om = sorted(set(reps.values())); assert len(om) == 16
    OM.append(om)
    w0 = {}
    for w in range(64):
        w0.setdefault((par6[w & p], par6[w & q]), w)
    W0.append([w0[k] for k in sorted(w0)])
OM = np.array(OM, dtype=np.int64)                                             # 651 x 16
W0 = np.array(W0, dtype=np.int64)                                             # 651 x 4
U = OM[:, :, None] ^ Pm[:, None, :]                                           # 651 x 16 x 4  (omega + p)
SG = 1 - 2 * par6[U[:, :, None, :] & W0[:, None, :, None]]                    # 651 x 16 x 4w0 x 4p


def bits(G):
    """G[z, w] in {0,1}.  Returns (bits, odd) arrays of shape 7 x 651 x 16 x 4 (I, V, omega, w0)."""
    S = 1 - 2 * G.astype(np.int64)
    Sh = S @ H64                                                              # 64 x 64: hat S[z, u]
    T = Sh[:, U]                                                              # 64 x 651 x 16 x 4p
    K = np.einsum("zvop,vowp->zvow", T, SG)                                   # 64 x 651 x 16 x 4w0 (= 4K)
    assert (K % 16 == 0).all()
    kap = K // 16                                                             # K_z / 4
    M = np.tensordot(IMASK, kap, axes=(1, 0)) % 4                             # 7 x 651 x 16 x 4
    return (M >> 1) & 1, M & 1


FAMS = ("F4", "F6")          # degree-2 families used in the linearisation
MOM2 = np.array([np.ones(64, np.int64)] + [((Zs >> i) & 1) for i in range(6)] +
                [((Zs >> i) & (Zs >> j) & 1) for i, j in itertools.combinations(range(6), 2)], dtype=np.int64)  # 22 x 64
HYP = list(range(1, 64))                                                      # V^perp = {0, p}
OM5 = []; W05 = []
for p in HYP:
    reps = sorted({min(w, w ^ p) for w in range(64)}); OM5.append(reps)
    W05.append([0, next(w for w in range(64) if par6[w & p])])
OM5 = np.array(OM5, dtype=np.int64); W05 = np.array(W05, dtype=np.int64)    # 63 x 32, 63 x 2
U5 = OM5[:, :, None] ^ np.array(HYP, dtype=np.int64)[:, None, None] * np.array([0, 1])[None, None, :]
SG5 = 1 - 2 * par6[U5[:, :, None, :] & W05[:, None, :, None]]                # 63 x 32 x 2w0 x 2p


def families(G):
    """All the new bits (must vanish for bent f), by family:
       F4 : 4-flats, |I| <= 1, bit of value 2 of sum kappa, kappa = K/4
       F4z: 4-flats, I = {}, bit of value 4 of sum kappa
       F5 : hyperplanes, |I| <= 1, bit of value 2 of sum kappa, kappa = K/8 (next bit of L5)
       F6 : V = W, |I| = 2, bit of value 2 of sum kappa, kappa = K/8 (Walsh in z is +-64)."""
    S = 1 - 2 * G.astype(np.int64)
    Sh = S @ H64
    # 4-flats
    K = np.einsum("zvop,vowp->zvow", Sh[:, U], SG) // 16                      # K/4
    M4 = np.tensordot(IMASK, K, axes=(1, 0))
    f4 = ((M4 % 4) >> 1) & 1
    f4z = ((M4[0] % 8) >> 2) & 1
    # hyperplanes
    K5 = np.einsum("zvop,vowp->zvow", Sh[:, U5], SG5) // 2                     # sum over 2 terms /2 = K
    assert (K5 % 8 == 0).all()
    K5 = K5 // 8
    M5 = np.tensordot(IMASK, K5, axes=(1, 0))
    f5 = ((M5 % 4) >> 1) & 1
    # whole W
    assert (Sh % 8 == 0).all()
    K6 = Sh // 8                                                              # z x omega
    M6 = MOM2[7:] @ K6                                                        # 15 x 64
    f6 = ((M6 % 4) >> 1) & 1
    return {"F4": f4.reshape(-1), "F4z": f4z.reshape(-1), "F5": f5.reshape(-1), "F6": f6.reshape(-1)}


def controle(path):
    from base12 import X
    from poisson5 import tabela
    W = json.load(open(path))
    for w in W:
        t = np.zeros(4096, dtype=np.uint8)
        for m in w["anf_supports"]:
            t ^= ((X & m) == m).astype(np.uint8)
        b, o = bits(tabela(t))
        assert not o.any() and not b.any(), (w["map_orbit"], int(b.sum()), int(o.sum()))
        fam = families(tabela(t))
        for k, v in fam.items():
            assert not v.any(), (w["map_orbit"], k, int(v.sum()))
    print("ok: all bit families vanish on the", len(W), "bent witnesses")


def degree_probe(G0, Gk, part, ker, rng, ntest=6):
    """For each family: does exact degree-2 interpolation predict random points?  (and degree 3?)"""
    m = len(ker)
    def pt(sub):
        u = part
        for i in sub:
            u ^= ker[i]
        return u
    res = {}
    vals = {}
    for k in range(4):
        for S in itertools.combinations(range(m), k):
            vals[S] = families(table_at(G0, Gk, pt(S)))
    names = list(vals[()].keys())
    def predict(sel, name, deg):
        acc = np.zeros_like(vals[()][name])
        for k in range(deg + 1):
            for T in itertools.combinations(sel, k):
                c = np.zeros_like(acc)
                for r in range(len(T) + 1):
                    for Q in itertools.combinations(T, r):
                        c ^= vals[Q][name]
                acc ^= c
        return acc
    tests = [sorted(int(i) for i in rng.choice(m, size=int(rng.integers(4, m)), replace=False)) for _ in range(ntest)]
    for name in names:
        res[name] = {}
        for deg in (2, 3):
            ok = True
            for sel in tests:
                act = families(table_at(G0, Gk, pt(tuple(sel))))[name]
                if not (predict(sel, name, deg) == act).all():
                    ok = False; break
            res[name][deg] = ok
    return res


def load_model():
    from base12 import elim_comb, pack
    from poisson5 import tabela
    D = pickle.load(open(os.path.join(here, "base12.pkl"), "rb"))
    base, Bs = D["base"], D["B"]
    ind, ker = elim_comb([pack(B) for B in Bs])
    fb = [base[i.bit_length() - 1] for i in ind]; Bb = [Bs[i.bit_length() - 1] for i in ind]
    Hk = [np.bitwise_xor.reduce([base[j] for j in range(len(base)) if k >> j & 1], axis=0) for k in ker]
    Gk = np.array([tabela(h) for h in Hk]); Gb = np.array([tabela(f) for f in fb])
    piv = {}
    for i, B in enumerate(Bb):
        r = pack(B); comb = 1 << i
        while r:
            c = r.bit_length() - 1
            if c in piv:
                r ^= piv[c][0]; comb ^= piv[c][1]
            else:
                piv[c] = (r, comb); break
    return Bb, Gb, Gk, piv


def solve_affine(rows, n):
    """rows: (mask over n unknowns, rhs). Returns (particular, kernel basis) or None."""
    piv = {}
    for r, b in rows:
        x = (r << 1) | b
        while x > 1 and (x.bit_length() - 1) in piv:
            x ^= piv[x.bit_length() - 1]
        if x == 1:
            return None
        if x > 1:
            piv[x.bit_length() - 1] = x
    for p in sorted(piv):
        for q in piv:
            if q != p and piv[q] >> p & 1:
                piv[q] ^= piv[p]
    pivs = {p - 1 for p in piv}
    part = sum(1 << (p - 1) for p, x in piv.items() if x & 1)
    ker = []
    for f in range(n):
        if f not in pivs:
            v = 1 << f
            for p, x in piv.items():
                if x >> (f + 1) & 1:
                    v |= 1 << (p - 1)
            ker.append(v)
    return part, ker


def table_at(G0, Gk, u):
    G = G0.copy()
    for k in range(Gk.shape[0]):
        if u >> k & 1:
            G ^= Gk[k]
    return G


def analyse(G0, Gk, part, ker, rng, max_rounds=6):
    """Interpolate the bit polynomials on part + span(ker); linearise; iterate."""
    history = []
    for rnd in range(max_rounds):
        m = len(ker)
        mons = [()] + [(i,) for i in range(m)] + list(itertools.combinations(range(m), 2))
        pts = {}
        def pt(sub):
            u = part
            for i in sub:
                u ^= ker[i]
            return u
        vals = {}
        def cond(u):
            fam = families(table_at(G0, Gk, u))
            return np.concatenate([fam[k] for k in FAMS]).astype(np.uint8)
        for mono in mons:
            vals[mono] = cond(pt(mono))
        coef = {(): vals[()]}
        for i in range(m):
            coef[(i,)] = vals[(i,)] ^ vals[()]
        for i, j in itertools.combinations(range(m), 2):
            coef[(i, j)] = vals[(i, j)] ^ vals[(i,)] ^ vals[(j,)] ^ vals[()]
        # degree check on random points
        for _ in range(6):
            sel = [i for i in range(m) if rng.random() < 0.5]
            pred = coef[()].copy()
            for i in sel:
                pred ^= coef[(i,)]
            for i, j in itertools.combinations(sel, 2):
                pred ^= coef[(i, j)]
            act = cond(pt(tuple(sel)))
            assert (pred == act).all(), "degree > 2"
        # rows: one per condition, bits over monomials ordered: quadratic (high) > linear > constant (bit 0)
        order = [()] + [(i,) for i in range(m)] + list(itertools.combinations(range(m), 2))
        Cm = np.stack([coef[mo] for mo in order], axis=1)                     # conds x monomials
        Cm = np.unique(Cm, axis=0)
        # bit k of each row int = coefficient of order[k]: constant = bit 0, linear 1..m, quadratic above
        packed = np.packbits(Cm, axis=1, bitorder="little")
        remap = [v for v in (int.from_bytes(r.tobytes(), "little") for r in packed) if v]
        piv = {}; incons = False; lin = []
        for x in remap:
            while x and (x.bit_length() - 1) in piv:
                x ^= piv[x.bit_length() - 1]
            if x == 1:
                incons = True; break
            if x:
                piv[x.bit_length() - 1] = x
        info = {"round": rnd, "dim": m, "distinct_conditions": len(remap), "rank": len(piv)}
        if incons:
            info["result"] = "inconsistent (1 in the span)"
            history.append(info)
            return "dead", history
        # linear consequences: pivots whose leading monomial has degree <= 1
        for p, x in piv.items():
            if p <= m:                       # order index <= m -> constant or linear
                lin.append(x)
        # full reduction of linear rows among themselves happens in solve_affine
        lrows = []
        for x in lin:
            mask = 0
            for i in range(m):
                if x >> (1 + i) & 1:
                    mask |= 1 << i
            lrows.append((mask, x & 1))
        info["linear_consequences"] = len(lrows)
        history.append(info)
        if not lrows:
            info["result"] = "alive (no new linear consequence)"
            analyse.final = (part, ker, list(piv.values()), order)
            return "alive", history
        sol = solve_affine(lrows, m)
        if sol is None:
            info["result"] = "inconsistent linear part"
            return "dead", history
        p2, k2 = sol
        newpart = part
        for i in range(m):
            if p2 >> i & 1:
                newpart ^= ker[i]
        newker = []
        for kv in k2:
            v = 0
            for i in range(m):
                if kv >> i & 1:
                    v ^= ker[i]
            newker.append(v)
        part, ker = newpart, newker
    return "alive", history


def is_bent_batch(Gs):
    """Gs: array N x 64 x 64 of 0/1 (f(z, w)); bent iff all Walsh values have absolute value 64.
    (z, w) -> (a, b) is a linear bijection, so the Walsh spectrum magnitudes agree.)"""
    S = (1 - 2 * Gs.astype(np.int64))
    W = np.einsum("az,nzw,wb->nab", H64, S, H64)
    return (np.abs(W) == 64).all(axis=(1, 2))


def exclude(G0, Gk, part, ker, polys, order, slice_bits=24):
    """Enumerate the common zeros of the quadratic polynomials on part + span(ker) (bit-sliced),
    then test bentness directly on the survivors.  Returns (survivors, bent)."""
    m = len(ker)
    fix = max(0, m - slice_bits); n = m - fix
    W = 1 << n; FULL = (1 << W) - 1
    var = [FULL ^ (FULL // ((1 << (1 << i)) + 1)) for i in range(n)]
    surv = 0; bent = 0
    for sl in range(1 << fix):
        # fixed variables n..m-1 take the bits of sl
        def val(i):
            if i < n:
                return var[i]
            return FULL if (sl >> (i - n)) & 1 else 0
        alive = FULL
        for p in polys:
            acc = 0
            for k in range(p.bit_length()):
                if p >> k & 1:
                    mo = order[k]
                    if len(mo) == 0:
                        acc ^= FULL
                    elif len(mo) == 1:
                        acc ^= val(mo[0])
                    else:
                        acc ^= val(mo[0]) & val(mo[1])
            alive &= FULL ^ acc
            if not alive:
                break
        cnt = alive.bit_count(); surv += cnt
        if not cnt:
            continue
        idx = []
        a = alive
        while a:
            low = a & -a; idx.append(low.bit_length() - 1); a ^= low
        # build tables in batches
        base_u = part
        for i in range(n, m):
            if (sl >> (i - n)) & 1:
                base_u ^= ker[i]
        Gbase = table_at(G0, Gk, base_u)
        # precompute direction tables in the original 43 coordinates
        Kt = [table_at(np.zeros_like(G0), Gk, ker[i]) for i in range(n)]
        for start in range(0, len(idx), 4096):
            chunk = idx[start:start + 4096]
            Gs = np.empty((len(chunk), 64, 64), np.uint8)
            for t, j in enumerate(chunk):
                G = Gbase.copy()
                for i in range(n):
                    if j >> i & 1:
                        G ^= Kt[i]
                Gs[t] = G
            bent += int(is_bent_batch(Gs).sum())
    return surv, bent


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("mode"); ap.add_argument("path")
    ap.add_argument("--shard", default="0/1"); ap.add_argument("--out", default="bitj.json")
    ap.add_argument("--limit", type=int, default=0)
    a = ap.parse_args()
    if a.mode == "controle":
        controle(a.path); return
    from base12 import pack, forma
    from testemunhas12 import BA, BB, coords
    from poisson5 import Bv_table, equacoes
    from poisson3 import eq3
    from poisson3_lista import todos_subespacos3
    si, sm = map(int, a.shard.split("/"))
    Bb, Gb, Gk, piv = load_model()
    Vs = todos_subespacos3()
    lines = [l.split() for l in open(a.path) if "L5+L3=1" in l]
    rng = np.random.default_rng(1)
    out = []
    for n, parts in enumerate(lines):
        if n % sm != si:
            continue
        if a.limit and len(out) >= a.limit:
            break
        t0 = time.time()
        hx = parts[0]; val = int(hx, 16)
        B = np.array([[(val >> (64 * k + z)) & 1 for z in range(64)] for k in range(15)], dtype=np.uint8)
        r = pack(B); comb = 0
        while r:
            c = r.bit_length() - 1
            r ^= piv[c][0]; comb ^= piv[c][1]
        sel = [j for j in range(len(Bb)) if comb >> j & 1]
        G0 = np.bitwise_xor.reduce(Gb[sel], axis=0) if sel else np.zeros((64, 64), np.uint8)
        Bv = Bv_table(B)
        rows = equacoes(Bv, G0, Gk) + eq3(Bv, G0, Gk, Vs)
        sol = solve_affine(rows, Gk.shape[0])
        a_ = "".join(map(str, coords(forma(B, 27, 54), BA))); b_ = "".join(map(str, coords(forma(B, 21, 42), BB)))
        rec = {"polar": hx, "a": a_, "b": b_}
        if a.mode == "grau" and sol is not None:
            part, ker = sol
            sub = [ker[i] for i in rng.choice(len(ker), size=10, replace=False)]
            print(n, a_, b_, "degree probe (10 directions):", degree_probe(G0, Gk, part, sub, rng), flush=True)
            continue
        if sol is None:
            rec.update(status="dead by L5+L3")
        else:
            part, ker = sol
            rec["dim_after_L5_L3"] = len(ker)
            status, hist = analyse(G0, Gk, part, ker, rng)
            rec.update(status=status, history=hist)
            if status == "alive" and a.mode == "exclui":
                p2, k2, polys, order = analyse.final
                t1 = time.time()
                s_, b_ = exclude(G0, Gk, p2, k2, polys, order)
                rec.update(final_dim=len(k2), poisson_survivors=s_, bent_found=b_,
                           exclusion_seconds=round(time.time() - t1, 1),
                           status="dead by Poisson bits + direct Walsh" if b_ == 0 else "BENT FOUND")
        rec["seconds"] = round(time.time() - t0, 1)
        out.append(rec)
        print(n, a_, b_, rec["status"], rec.get("dim_after_L5_L3"), rec["seconds"], flush=True)
        json.dump(out, open(a.out, "w"), indent=1)


if __name__ == "__main__":
    main()

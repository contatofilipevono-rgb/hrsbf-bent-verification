# Levantamento linear da conta de Poisson em hiperplanos V = eta^perp de W (dimensao 5).
# Para f bent quadratica em w, w0 em W, e K_z = soma de (-1)^{f(z, w0+s)} em s em V:
#   K_z = 0, +-8 se B_z|_V tem posto 4 (ativo sse D_r f(z, w0) = 0, r = radical de B_z|_V), e K_z = 0 mod 16 caso contrario;
#   a transformada de K em z esta em 64 Z;  logo  sum_{z contem I} K_z / 8  e par para |I| <= 2, isto e
#   (L5)   sum_{z contem I, posto(B_z|_V) = 4} (1 + D_{r_z} f(z, w0)) = 0  (mod 2),   |I| <= 2.
# Fixada a polar B, (L5) e um sistema LINEAR na parte de f afim em w (lambda), com 63 x 2 x 22 equacoes.
# Uso: python poisson5.py controle <witnesses.json>   |   python poisson5.py polares
import os, sys, pickle, json, itertools
from collections import Counter
import numpy as np
from base12 import mobius, elim_comb, pack, PAIRS, forma, polar, ZW, X
from testemunhas12 import BA, BB, coords

here = os.path.dirname(os.path.abspath(__file__))
par6 = np.array([bin(i).count("1") & 1 for i in range(64)])
Zs = np.arange(64)
MONO = [0] + [1 << i for i in range(6)] + [(1 << i) | (1 << j) for i, j in itertools.combinations(range(6), 2)]
MI = np.array([(Zs & m) == m for m in MONO], dtype=np.int64)            # 22 x 64


def tabela(t):                       # t em x = (a,b) -> G[z, w]
    return t[ZW].reshape(64, 64).T.copy()


def Bv_table(B):
    """Bv[z, v] = B_z v (mascara de 6 bits)."""
    rows = np.zeros((64, 6), np.int64)
    for k, (i, j) in enumerate(PAIRS):
        rows[:, i] |= B[k].astype(np.int64) << j
        rows[:, j] |= B[k].astype(np.int64) << i
    out = np.zeros((64, 64), np.int64)
    for i in range(6):
        out |= par6[rows[:, i][:, None] & Zs[None, :]].astype(np.int64) << i
    return out


def radicais(Bv, eta):
    """para cada z: (mascara posto 4, r_z) no hiperplano V = eta^perp."""
    V = Zs[par6[Zs & eta] == 0]
    img = Bv[:, V]                                           # 64 x 32
    rad = (img == 0) | (img == eta)                          # v no radical da restricao
    cnt = rad.sum(axis=1)
    m4 = cnt == 2
    r = np.where(m4, V[np.argmax(rad[:, 1:], axis=1) + 1], 0)
    return m4, r


def equacoes(Bv, G0, Gk):
    """linhas (coeficientes em k, lado direito) de (L5) para todas as escolhas de eta, w0, I."""
    rows = []
    for eta in range(1, 64):
        m4, r = radicais(Bv, eta)
        if not m4.any(): continue
        w1 = next(w for w in range(64) if par6[w & eta])
        for w0 in (0, w1):
            d0 = (G0[Zs, w0 ^ r] ^ G0[Zs, w0]).astype(np.int64)
            dk = (Gk[:, Zs, w0 ^ r] ^ Gk[:, Zs, w0]).astype(np.int64)       # K x 64
            Mm = MI * m4.astype(np.int64)                                     # 22 x 64
            rhs = (Mm @ (1 ^ d0)) & 1
            co = (Mm @ dk.T) & 1                                              # 22 x K
            for i in range(len(MONO)):
                rows.append((sum(1 << int(k) for k in np.flatnonzero(co[i])), int(rhs[i])))
    return rows


def viavel(rows):
    piv = {}
    for r, b in rows:
        while r:
            c = r.bit_length() - 1
            if c in piv: r ^= piv[c][0]; b ^= piv[c][1]
            else: piv[c] = (r, b); break
        else:
            if b: return False, len(piv)
    return True, len(piv)


if __name__ == "__main__":
    D = pickle.load(open(os.path.join(here, "base12.pkl"), "rb"))
    base, Bs = D["base"], D["B"]
    ind, ker = elim_comb([pack(B) for B in Bs])
    fb = [base[i.bit_length() - 1] for i in ind]; Bb = [Bs[i.bit_length() - 1] for i in ind]
    Hk = [np.bitwise_xor.reduce([base[j] for j in range(len(base)) if k >> j & 1], axis=0) for k in ker]
    Gk = np.array([tabela(h) for h in Hk])
    Gb = np.array([tabela(f) for f in fb])
    print("polar: dim", len(fb), "| nucleo (f afim em w):", len(Hk), flush=True)
    if sys.argv[1] == "controle":
        W = json.load(open(sys.argv[2]))
        zero = np.zeros((0, 64, 64), np.uint8)
        for w in W:
            t = np.zeros(4096, dtype=np.uint8)
            for m in w["anf_supports"]: t ^= ((X & m) == m).astype(np.uint8)
            B = polar(t)[0]
            rows = equacoes(Bv_table(B), tabela(t), zero)
            assert all(b == 0 for _, b in rows), w["map_orbit"]
        print("ok: (L5) vale nas", len(W), "testemunhas bent, sem incognitas")
    else:
        ZP = [(1 << i) | (1 << j) for i, j in PAIRS]
        pidx = {p: k for k, p in enumerate(PAIRS)}
        quads = list(itertools.combinations(range(6), 4))
        tops = np.array([[mobius(B[k], 6)[ZP] for k in range(15)] for B in Bb], dtype=np.uint8)
        ti, tk = elim_comb([pack(t) for t in tops])
        d = len(ti); N = 1 << d
        T = np.array([tops[i.bit_length() - 1] for i in ti])
        allT = np.zeros((N, 15, 15), np.uint8)
        for i in range(d): allT[1 << i:2 << i] = allT[:1 << i] ^ T[i]
        ok = np.ones(N, bool)
        def sp(S):
            a, b, c, e = S
            return [((a, b), (c, e)), ((a, c), (b, e)), ((a, e), (b, c))]
        for S in quads:
            acc = np.zeros((N, 15), np.uint8)
            for P, Pc in sp(S):
                q, r = allT[:, pidx[P]], allT[:, pidx[Pc]]
                for s, Sz in enumerate(quads):
                    for A, Ac in sp(Sz):
                        acc[:, s] ^= (q[:, pidx[A]] & r[:, pidx[Ac]]) ^ (q[:, pidx[Ac]] & r[:, pidx[A]])
            ok &= ~acc.any(axis=1)
        del allT
        topi = [i.bit_length() - 1 for i in ti]
        lows = [[j for j in range(len(Bb)) if k >> j & 1] for k in tk]
        tab = Counter(); vivos = []
        feitos = 0
        for code in np.flatnonzero(ok):
            sel0 = [topi[i] for i in range(d) if code >> i & 1]
            for low in range(1 << len(lows)):
                sel = set(sel0)
                for i in range(len(lows)):
                    if low >> i & 1: sel ^= set(lows[i])
                sel = sorted(sel)
                B = np.bitwise_xor.reduce([Bb[j] for j in sel], axis=0) if sel else np.zeros((15, 64), np.uint8)
                a = coords(forma(B, 27, 54), BA); b = coords(forma(B, 21, 42), BB)
                if not (any(a) and any(b)): continue
                G0 = np.bitwise_xor.reduce(Gb[sel], axis=0)
                v, posto = viavel(equacoes(Bv_table(B), G0, Gk))
                tab[(a, b, v)] += 1
                if v: vivos.append((int(code), low))
                feitos += 1
                if feitos % 500 == 0: print(feitos, sum(1 for x in tab if x[2]), flush=True)
        print("(a, b) -> polares com (L5) viavel / total")
        pares = sorted({(a, b) for a, b, v in tab})
        for a, b in pares:
            print("  a =", a, "b =", b, "|", tab.get((a, b, True), 0), "/", tab.get((a, b, True), 0) + tab.get((a, b, False), 0))
        print("polares vivas:", len(vivos), "de", feitos)
        pickle.dump(vivos, open(os.path.join(here, "vivos_L5.pkl"), "wb"))

# Sistema completo (L3) + (L5) numa lista de polares dada em hexadecimal (formato do repositorio:
# 15 blocos de 64 bits, bloco k = valores em z de B_ij para o k-esimo par i<j).
# Uso: python poisson3_lista.py <lista.txt> <saida.txt>
import os, sys, pickle, itertools
from collections import Counter
import numpy as np
from base12 import elim_comb, pack, PAIRS, forma
from testemunhas12 import BA, BB, coords
from poisson5 import tabela, Bv_table, equacoes, viavel
from poisson3 import eq3

here = os.path.dirname(os.path.abspath(__file__))


def todos_subespacos3():
    out = set()
    for v1 in range(1, 64):
        for v2 in range(v1 + 1, 64):
            for v3 in range(v2 + 1, 64):
                if v3 == v1 ^ v2: continue
                span = {0}
                for v in (v1, v2, v3): span |= {s ^ v for s in span}
                out.add(tuple(sorted(span)))
    return [list(s) for s in sorted(out)]


if __name__ == "__main__":
    D = pickle.load(open(os.path.join(here, "base12.pkl"), "rb"))
    base, Bs = D["base"], D["B"]
    ind, ker = elim_comb([pack(B) for B in Bs])
    fb = [base[i.bit_length() - 1] for i in ind]; Bb = [Bs[i.bit_length() - 1] for i in ind]
    Hk = [np.bitwise_xor.reduce([base[j] for j in range(len(base)) if k >> j & 1], axis=0) for k in ker]
    Gk = np.array([tabela(h) for h in Hk]); Gb = np.array([tabela(f) for f in fb])
    # decomposicao de uma polar na base Bb
    piv = {}
    for i, B in enumerate(Bb):
        r = pack(B); comb = 1 << i
        while r:
            c = r.bit_length() - 1
            if c in piv: r ^= piv[c][0]; comb ^= piv[c][1]
            else: piv[c] = (r, comb); break
    Vs = todos_subespacos3()
    assert len(Vs) == 1395
    linhas = [l.strip() for l in open(sys.argv[1]) if l.strip()]
    tab = Counter()
    with open(sys.argv[2], "w") as out:
        for n, hx in enumerate(linhas):
            val = int(hx, 16)
            B = np.array([[(val >> (64 * k + z)) & 1 for z in range(64)] for k in range(15)], dtype=np.uint8)
            r = pack(B); comb = 0
            while r:
                c = r.bit_length() - 1
                assert c in piv, "polar fora do espaco do modelo"
                r ^= piv[c][0]; comb ^= piv[c][1]
            sel = [j for j in range(len(Bb)) if comb >> j & 1]
            a = coords(forma(B, 27, 54), BA); b = coords(forma(B, 21, 42), BB)
            G0 = np.bitwise_xor.reduce(Gb[sel], axis=0); Bv = Bv_table(B)
            r5 = equacoes(Bv, G0, Gk)
            v5, _ = viavel(r5)
            v3, posto = viavel(r5 + eq3(Bv, G0, Gk, Vs))
            tab[(a, b, v3)] += 1
            out.write("%s a=%s b=%s L5=%d L5+L3=%d posto=%d\n" % (hx, "".join(map(str, a)), "".join(map(str, b)), v5, v3, posto))
            out.flush()
            print(n, a, b, v5, v3, flush=True)
    print("(a, b, passa em L5 + L3 completo) -> contagem")
    for k, v in sorted(tab.items()): print(" ", k, v)

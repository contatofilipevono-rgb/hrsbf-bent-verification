# Acao das unidades circulantes de F_2[X]/(X^6 + 1) (e da reflexao) nas classes (a, b):
#   beta -> beta o M,  M circulante invertivel em z.  As mudancas x -> Mx em 12 coordenadas preservam
#   rotacao, grau, bentness e os planos V_a, V_b, e induzem em z um circulante 6 x 6.
# Conta as orbitas dos 49 pares com a != 0 e b != 0.
import numpy as np
from testemunhas12 import BA, BB, coords, Z

def mul(u, z):                     # produto em F_2[X]/(X^6+1), u e z como mascaras
    out = 0
    for i in range(6):
        if u >> i & 1: out ^= ((z << i) | (z >> (6 - i))) & 63
    return out

unid = [u for u in range(64) if len({mul(u, z) for z in range(64)}) == 64]
refl = np.array([sum(((z >> i) & 1) << ((-i) % 6) for i in range(6)) for z in range(64)])
perms = [np.array([mul(u, z) for z in range(64)]) for u in unid] + [refl]
print("unidades circulantes:", len(unid))


def vec(c, basis):
    w = np.zeros(64, int)
    for t in range(3):
        if c[t]: w ^= basis[t]
    return w


classes = [(a, b) for a in range(1, 8) for b in range(1, 8)]
tup = lambda c: tuple((c >> t) & 1 for t in range(3))
seen = {}; orbs = []
for a, b in classes:
    if (a, b) in seen: continue
    orb = set(); pend = [(a, b)]
    while pend:
        x = pend.pop()
        if x in orb: continue
        orb.add(x)
        va, vb = vec(tup(x[0]), BA), vec(tup(x[1]), BB)
        for p in perms:
            ca, cb = coords(va[p], BA), coords(vb[p], BB)
            assert ca is not None and cb is not None           # os dois espacos sao invariantes
            y = (sum(ca[t] << t for t in range(3)), sum(cb[t] << t for t in range(3)))
            if y not in orb: pend.append(y)
    for x in orb: seen[x] = len(orbs)
    orbs.append(sorted(orb))
print("orbitas dos 49 pares (a != 0, b != 0):", len(orbs))
for o in orbs: print("  tamanho", len(o), "| representante a =", tup(o[0][0]), "b =", tup(o[0][1]))
# orbitas de a e de b separadamente
for nome, basis in (("a", BA), ("b", BB)):
    s = {}; lst = []
    for c in range(1, 8):
        if c in s: continue
        orb = set(); pend = [c]
        while pend:
            x = pend.pop()
            if x in orb: continue
            orb.add(x)
            for p in perms:
                cc = coords(vec(tup(x), basis)[p], basis)
                y = sum(cc[t] << t for t in range(3))
                if y not in orb: pend.append(y)
        for x in orb: s[x] = 1
        lst.append([tup(x) for x in sorted(orb)])
    print("orbitas de", nome, ":", lst)

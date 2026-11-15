"""Which action of the rotation fixes the homogeneous tops?  Test T(z)(w,w') -> T(Mz z)(Mw w, Mw w') for
Mw, Mz in {I, R, R^-1} (over F2), on the 21 basis tops, and on the full polar B(z) of the functions."""
import os, sys, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from base12 import orbitas, mobius, ZW, wtw, polar, pack, elim_comb, X
from pf4_estrutura import top_of

PAIRS = list(itertools.combinations(range(6), 2))
R = np.zeros((6, 6), dtype=np.int64)
for i in range(6):
    R[(i + 1) % 6, i] = 1
Rinv = R.T.copy()
I = np.eye(6, dtype=np.int64)
MATS = {"I": I, "R": R, "Rinv": Rinv}


def apply_vec(M, z):
    v = np.array([z >> i & 1 for i in range(6)])
    w = (M @ v) % 2
    return int(sum(int(b) << i for i, b in enumerate(w)))


ORB = [o for o in orbitas() if o[0] == 4]
TT = []
for o in ORB:
    t = np.zeros(4096, dtype=np.uint8)
    for m in o[2]:
        t ^= ((X & m) == m).astype(np.uint8)
    TT.append(t)
AN = [mobius(t[ZW].copy(), 12) for t in TT]
ind, ker = elim_comb([pack(a[wtw >= 3]) for a in AN])
HV = [np.bitwise_xor.reduce([TT[i] for i in range(len(TT)) if k >> i & 1], axis=0) for k in ker]
Bs = [polar(t)[0] for t in HV]


def alt(B, z):
    M = np.zeros((6, 6), dtype=np.int64)
    for k, (i, j) in enumerate(PAIRS):
        if B[k][z]:
            M[i, j] = M[j, i] = 1
    return M


for nw, Mw in MATS.items():
    for nz, Mz in MATS.items():
        ok = True
        for B in Bs:
            for z in range(64):
                lhs = alt(B, apply_vec(Mz, z))
                rhs = (Mw.T @ alt(B, z) @ Mw) % 2           # B(Mz z)(u, v) =? B(z)(Mw u, Mw v)
                if not (Mw.T @ lhs @ Mw % 2 == alt(B, z)).all() and not (lhs == rhs).all():
                    ok = False; break
            if not ok:
                break
        # cleaner: test B(Mz z) == Mw^{-T} B(z) Mw^{-1}  <=>  Mw^T B(Mz z) Mw == B(z)
        ok2 = all(((Mw.T @ alt(B, apply_vec(Mz, z)) @ Mw) % 2 == alt(B, z)).all() for B in Bs for z in range(64))
        print("w-action %-4s z-action %-4s : B(Mz z) = Mw^-T B(z) Mw^-1 for all polars: %s" % (nw, nz, ok2))

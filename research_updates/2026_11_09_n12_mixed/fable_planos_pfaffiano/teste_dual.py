"""Extra symmetries of the bent polars: duality and translation by the all-ones vector.

For each bent polar (certificate in certificados_bent71.json.gz; the zero polar is skipped), a few bent functions
are taken from the first 'allbent' leaves of the certificate.  For each bent f:
  dual:  f~(u) = (1 - W_f(u)/64)/2 ; checked: RS, degree, quadratic in w (model), and the polar of f~;
  shift: f(x + 1...1) ; polar.
Output: per polar, the image polars (prefixes) under duality and shift, and the dual degree.
Usage: python teste_dual.py <bent certs .json.gz> [--shard i/n] [--out file.json]"""
import os, sys, json, gzip
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import verifica_arvore3 as V3
from base12 import mobius

XS = np.arange(4096)
Z = np.arange(64)[:, None]; Wd = np.arange(64)[None, :]
XOF = ((Z ^ Wd) | (Wd << 6))
PAIRS6 = [(i, j) for i in range(6) for j in range(i + 1, 6)]
rot12 = lambda x: ((x << 1) | (x >> 11)) & 4095
ROT = np.array([rot12(x) for x in range(4096)])
POP = np.array([bin(x).count("1") for x in range(4096)])


class Stop(Exception):
    pass


class FirstLeaves(V3.Checker):
    def __init__(self, P, want):
        super().__init__(P); self.pts = []; self.want = want

    def node(self, n, x0, B, stats):
        if n.get("leaf") == "allbent":
            for a in n["actions"]:
                if "compute" in a:
                    self.events[a["id"]] = (x0.copy(), B.copy())
                else:
                    polys = [self.get(u, x0, B) for u in a["restrict"]]
                    one, aff = V3.span_info([p for p in polys if p is not None], B.shape[0])
                    x0, B = V3.restrict(x0, B, aff)
            self.pts.append(x0.copy())
            if B.shape[0]:
                self.pts.append((x0 + B[0]) % 2)
            if len(self.pts) >= self.want:
                raise Stop
            return True
        if n.get("leaf") in ("const", "lin"):
            return True                                   # dead leaves: nothing to collect (already verified)
        return super().node(n, x0, B, stats)


def polar_hex_of_table(G):
    v = 0
    for kk, (i, j) in enumerate(PAIRS6):
        ei, ej = 1 << i, 1 << j
        col = G[:, ei ^ ej] ^ G[:, ei] ^ G[:, ej] ^ G[:, 0]
        for z in np.nonzero(col)[0]:
            v |= 1 << (64 * kk + int(z))
    return format(v, "x")


def to_x(G):
    t = np.zeros(4096, dtype=np.uint8); t[XOF.reshape(-1)] = G.reshape(-1); return t


def to_zw(t):
    return t[XOF]


def walsh(t):
    a = (1 - 2 * t.astype(np.int64)).copy()
    h = 1
    while h < 4096:
        a = a.reshape(-1, 2, h); x = a[:, 0, :].copy(); y = a[:, 1, :].copy()
        a[:, 0, :] = x + y; a[:, 1, :] = x - y; a = a.reshape(-1); h *= 2
    return a


def degree(t):
    an = mobius(t.astype(np.uint8).copy(), 12)
    nz = np.nonzero(an)[0]
    return int(POP[nz].max()) if len(nz) else -1


def quadratic_in_w(G):
    # degree in w <= 2: third derivatives in w vanish
    for i in range(6):
        for j in range(i + 1, 6):
            for k in range(j + 1, 6):
                s = np.zeros(64, dtype=np.uint8)
                for m in range(8):
                    d = (1 << i if m & 1 else 0) | (1 << j if m & 2 else 0) | (1 << k if m & 4 else 0)
                    s ^= G[:, d]
                if s.any():
                    return False
    return True


if __name__ == "__main__":
    from bitj import load_model
    from poisson3_lista import todos_subespacos3
    from cert_arvore import polar_data
    from verifica_arvore import Polar
    model = load_model(); Vs = todos_subespacos3()
    recs = json.load(gzip.open(sys.argv[1], "rt"))
    bent_full = {r["polar"] for r in recs} | {"0"}
    si, sm = map(int, (sys.argv[sys.argv.index("--shard") + 1] if "--shard" in sys.argv else "0/1").split("/"))
    out_path = sys.argv[sys.argv.index("--out") + 1] if "--out" in sys.argv else None
    res = []
    for k, r in enumerate(sorted(recs, key=lambda r: r["polar"])):
        if k % sm != si:
            continue
        T0, K = polar_data(r["polar"], model, Vs)
        P = Polar(T0, K)
        C = FirstLeaves(P, 4)
        try:
            C.node(r["cert"], np.zeros(P.m, np.int64), np.eye(P.m, dtype=np.int64), {})
        except Stop:
            pass
        rec = {"polar": r["polar"][:12], "dual": [], "shift": []}
        for pt in C.pts:
            G = T0.copy()
            for j in range(P.m):
                if pt[j]:
                    G ^= K[j]
            t = to_x(G)
            W = walsh(t)
            assert (np.abs(W) == 64).all(), "sample point is not bent"
            td = ((1 - W // 64) // 2).astype(np.uint8)
            rs = bool((td[ROT] == td).all())
            deg = degree(td)
            Gd = to_zw(td)
            qw = quadratic_in_w(Gd)
            ph = polar_hex_of_table(Gd) if qw else None
            rec["dual"].append({"rs": rs, "degree": deg, "quadratic_in_w": qw,
                                "polar": ph[:12] if ph else None, "in_bent_list": (ph in bent_full) if ph else None})
            ts = t[XS ^ 4095]
            ps = polar_hex_of_table(to_zw(ts))
            rec["shift"].append({"polar": ps[:12], "same": ps == r["polar"], "in_bent_list": ps in bent_full})
        res.append(rec)
        print(json.dumps(rec), flush=True)
        if out_path:
            json.dump(res, open(out_path, "w"))

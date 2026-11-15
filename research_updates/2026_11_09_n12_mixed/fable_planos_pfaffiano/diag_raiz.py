"""Root diagnostics for one polar: how far the S and F families get before branching."""
import os, sys, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from bitj import load_model
from poisson3_lista import todos_subespacos3
from cert_colunas import pairs_of
from cert_arvore import polar_data, restrict_affine
from cert_arvore2 import Prover, reduce_track

k = int(sys.argv[2])
hx = open(sys.argv[1]).read().split()[k]
model = load_model(); Vs = todos_subespacos3()
T0, K = polar_data(hx, model, Vs)
by_d = {}
for z, d, form, g in pairs_of(T0, K):
    if d:
        by_d.setdefault(d, []).append((form, g))
pr = Prover(T0, K, by_d)
p, Q = 0, [1 << i for i in range(len(K))]
for rnd in range(8):
    t = time.time()
    items = pr.polys(p, Q, True)
    st, res = reduce_track(items)
    degs = {}
    for ref, P in items:
        dg = max((bin(J).count("1") for J in P), default=0)
        degs[(ref[0], dg)] = degs.get((ref[0], dg), 0) + 1
    print(hx[:12], "round", rnd, "dim", len(Q), "polys", len(items), "by (family, degree)", sorted(degs.items()),
          "status", st, "affine consequences", (len(res) if st == "ok" else "-"), round(time.time() - t), "s", flush=True)
    if st == "one":
        print("  closes at root"); break
    new = restrict_affine(p, Q, [(m, r) for _, m, r in res]) if res else None
    if not new or len(new[1]) == len(Q):
        break
    p, Q = new

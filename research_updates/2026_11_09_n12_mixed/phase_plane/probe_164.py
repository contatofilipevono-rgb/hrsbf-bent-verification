"""Class 164, cells with certificate M(0, z0 s1) + bit2(|P_0|): structure of P_0."""
import sys, json
from pathlib import Path
from collections import Counter
sys.path.insert(0, str(Path(__file__).parent))
import plane_cert as PC
import short_certs as SC
M = PC.Model(sys.argv[1]); K = int(sys.argv[2]) if len(sys.argv) > 2 else 164
def mapping_of(c):
    m = 0
    for i in range(33):
        if c >> i & 1:
            m ^= M.basis[i]
    return m
cert = {r["cell_index"]: r for r in json.loads(Path(f"short-certificates/short-{K}.json").read_text())}
def dd(z): return (z & 7) ^ (z >> 3)
for idx, (code, rker, info) in enumerate(SC.cells_of(M, K)):
    r = cert[idx]
    if r["kind"] != "moments+size":
        continue
    lab = M.labels(mapping_of(code))
    D1 = [lab[z + 64] ^ lab[z] for z in range(64)]; D2 = [lab[z + 128] ^ lab[z] for z in range(64)]
    print("cell", idx, "dim", len(rker), "cert", r["certificate"])
    print("  (D1,D2) types:", Counter((D1[z], D2[z]) for z in range(64)))
    # cell directions: which z do they move, and how (label deltas)?
    for v in rker:
        dl = [a ^ b for a, b in zip(M.labels(mapping_of(code ^ v))[:64], lab[:64])]
        print("   dir moves", sum(1 for x in dl if x), "points; deltas", dict(Counter(x for x in dl if x)))
    # decomposition at the base point and statistics over the cell
    stat = Counter()
    for kk in range(1 << len(rker)):
        cc = code
        for i, v in enumerate(rker):
            if kk >> i & 1:
                cc ^= v
        L = M.labels(mapping_of(cc))
        P0 = [x for x in range(256) if L[x] == 0]
        cz = Counter(x & 63 for x in P0)
        mom = sum((x & 1) & (x >> 6 & 1) for x in P0) & 1
        stat[(len(P0) % 8, mom, tuple(sorted(Counter(cz.values()).items())))] += 1
    print("  (|P0| mod 8, moment z0 s1, multiplicities of z in P0):", dict(stat))
    break

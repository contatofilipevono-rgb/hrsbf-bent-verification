"""Class 164: rows of the (D1,D2) types, swap pairing of the multiplicity-2 points of P_0."""
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
def dd(z): return (z & 7) ^ (z >> 3)
def sw(z): return (z >> 3) | ((z & 7) << 3)
cert = {r["cell_index"]: r for r in json.loads(Path(f"short-certificates/short-{K}.json").read_text())}
for idx, (code, rker, info) in enumerate(SC.cells_of(M, K)):
    if cert[idx]["kind"] != "moments+size":
        continue
    lab = M.labels(mapping_of(code))
    D1 = [lab[z + 64] ^ lab[z] for z in range(64)]; D2 = [lab[z + 128] ^ lab[z] for z in range(64)]
    rows = {d: Counter((D1[z], D2[z]) for z in range(64) if dd(z) == d) for d in range(8)}
    print("cell", idx, "types per row:", rows)
    stat = Counter()
    for kk in range(1 << len(rker)):
        cc = code
        for i, v in enumerate(rker):
            if kk >> i & 1:
                cc ^= v
        L = M.labels(mapping_of(cc))
        P0 = [x for x in range(256) if L[x] == 0]
        cz = Counter(x & 63 for x in P0)
        T2 = sorted(z for z, c in cz.items() if c == 2)
        T4 = sorted(z for z, c in cz.items() if c == 4)
        closed = all(sw(z) in T2 for z in T2)
        stat[(len(T2), closed, tuple(sorted(Counter(dd(z) for z in T2).items())), tuple(dd(z) for z in T4),
              tuple(T4))] += 1
    for k_, v in sorted(stat.items()): print("  (k, swap-closed, rows of T2, row of T4, T4):", k_, v)

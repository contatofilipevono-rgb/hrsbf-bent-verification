"""Case B, (alpha,beta)=(0,0) and (1,1): row-e0 keys (x1,x2,y1,y2,w1,w2) of the (Pf4) polars, with Y = a+d+h+m,
and which keys pass the 8-row test; also case C (1,1)."""
import sys, os, json, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bc_comum import NAMES
from oito_parametros_lib import params

here = os.path.dirname(os.path.abspath(__file__))
homog = json.load(open(os.path.join(here, "homog1176.json")))
tab8 = json.load(open(os.path.join(here, "oito_tabela.json")))
par = np.load(os.path.join(here, "paridade_tab.npy"))
N = {s: i for i, s in enumerate(NAMES)}
for case, u in (("B", (1, 1, 0)), ("C", (1, 0, 1))):
    for ab in ((0, 0), (1, 1)):
        cnt = collections.Counter()
        for c in homog:
            k = params(c)
            if k[:3] != u or k[3:5] != ab:
                continue
            Y = (int(c[N["a"]]) + int(c[N["d"]]) + int(c[N["h"]]) + int(c[N["m"]])) & 1
            code = sum(int(c[i]) << i for i in range(21))
            ev = not par[:, code].any()
            cnt[(k[5:], Y, tab8["".join(map(str, k))][0], ev)] += 1
        print("case", case, "ab", ab)
        for key in sorted(cnt):
            print("   key", "".join(map(str, key[0])), "Y=%d pass8=%d even=%d" % key[1:], "count", cnt[key])
    # all keys passing 8 rows for this case and ab
    for ab in ((0, 0), (1, 1)):
        ok = ["".join(map(str, k[5:])) for k in [tuple(map(int, s)) for s in tab8] if k[:3] == u and k[3:5] == ab and tab8["".join(map(str, k))][0]]
        print("case", case, ab, "keys passing 8 rows:", len(ok), sorted(ok))

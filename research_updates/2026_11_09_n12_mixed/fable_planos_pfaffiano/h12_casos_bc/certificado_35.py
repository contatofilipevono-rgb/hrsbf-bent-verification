"""Front 4: one verification line for each of the 35 polars that pass Fable's levels 8 and 9.
 - 8 rows: a column b with sum_{z in {0, e_i, 63}} r_b(z)^2 > 4096 (rows listed with |r|);
 - parity: a direction d with N_d = #{z : B_z d = 0} odd;
 - otherwise: report (dies by the mod-4 / residue levels of S_d in the repo).
Usage: python -I certificado_35.py FABLE_DIR REPO_DIR"""
import sys, os, json, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from bc_comum import *

FAB, REPO = sys.argv[1], sys.argv[2]
here = os.path.dirname(os.path.abspath(__file__))
lv9 = collections.OrderedDict()
for line in open(os.path.join(FAB, "sobreviventes_nivel9.txt")):
    if line.startswith("#") or not line.strip():
        continue
    p = line.split()
    lv9.setdefault((p[0], p[3]), 0)
    lv9[(p[0], p[3])] += 1
det = {d[0]: d for d in json.load(open(os.path.join(REPO, "mede_homogeneo.json")))["detail"]}
out = []
for (case, code), nf in lv9.items():
    t = t_from_coords(code)
    B = polar_of(t)
    R = spectrum_rows(ftab_zw(t))
    s = (R[ROWS8] ** 2).sum(axis=0)
    if s.max() > 4096:
        b = int(s.argmax())
        rows = ["z=%d:|%d|" % (z, abs(int(R[z, b]))) for z in ROWS8 if R[z, b] != 0]
        line = "8 linhas: coluna b=%s, soma %d > 4096 (%s)" % (format(b, "06b")[::-1], int(s[b]), ", ".join(rows))
    else:
        ok, Nd = even_ok(B)
        if not ok:
            d = next(d for d in range(1, 64) if Nd[d] % 2)
            line = "paridade: d=%s, N_d=%d impar" % (format(d, "06b")[::-1], int(Nd[d]))
        else:
            hx = format(hexint(B), "x")[:12]
            line = "niveis de S_d: %s (mede_homogeneo.json, prefixo %s)" % (det.get(hx, ["?", "?"])[1], hx)
    out.append((case, code, nf, line))
    print(case, code, "funcoes=%d" % nf, "|", line)
with open(os.path.join(here, "certificado_35.tsv"), "w", encoding="utf-8") as fo:
    fo.write("# caso\tpolar\tfuncoes_nivel9\tverificacao\n")
    for r in out:
        fo.write("%s\t%s\t%d\t%s\n" % r)

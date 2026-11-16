"""For each level-8 polar of Fable (cases A, B, C): which repo filter kills it, and the 98 / 35 intersections.
Usage: python -I mapa_filtros.py FABLE_DIR REPO_DIR"""
import sys, os, json, random, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from bc_comum import *

FAB, REPO = sys.argv[1], sys.argv[2]

# sanity: polar depends only on the 21 coordinates (random model t)
random.seed(1)
for _ in range(30):
    t = [random.getrandbits(1) for _ in range(43)]
    t[37] = sum(t[j] for j in L456 if j != 37) & 1
    t[36] = sum(t[j] for j in L464 if j != 36) & 1
    t2 = t_from_coords(coords_of_t(t))
    assert hexint(polar_of(t)) == hexint(polar_of(t2))
print("polar depends only on the 21 coordinates: ok")

listed = {int(h, 16) for h in open(os.path.join(REPO, "polares_18816.txt")).read().split()}
killed8 = {int(h, 16) for h in json.load(open(os.path.join(REPO, "homog_linhas_fixas.json")))["killed"]}
resto3 = {int(h, 16) for h in json.load(open(os.path.join(REPO, "homog_resto.json")))}

# basis of homogeneous polars in the 21 coordinates
basis = []
for k in range(21):
    code = "".join("1" if i == k else "0" for i in range(21))
    basis.append(hexint(polar_of(t_from_coords(code))))
piv = {}
for k, v in enumerate(basis):
    comb = 1 << k
    while v:
        c = v.bit_length() - 1
        if c in piv:
            v ^= piv[c][0]; comb ^= piv[c][1]
        else:
            piv[c] = (v, comb); break
    else:
        raise SystemExit("basis dependent")


def coords_of_polar(P):
    comb = 0
    while P:
        c = P.bit_length() - 1
        if c not in piv:
            return None
        P ^= piv[c][0]; comb ^= piv[c][1]
    return "".join(str(comb >> k & 1) for k in range(21))


homog = {}
for P in listed:
    c = coords_of_polar(P)
    if c is not None:
        homog[c] = P
print("homogeneous polars among the 18816:", len(homog))
json.dump(sorted(homog), open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "homog1176.json"), "w"))


def status(code):
    t = t_from_coords(code)
    B = polar_of(t)
    P = hexint(B)
    F = ftab_zw(t)
    ok8, m8 = pass8(F)
    ev, N = even_ok(B)
    inl = P in listed
    k8 = P in killed8
    assert (not ok8) == k8 or not inl, (code, ok8, k8)
    if not inl:
        first = "nao-Pf4"
    elif not ok8:
        first = "8linhas"
    elif not ev:
        first = "paridade"
    elif P in resto3:
        first = "mod4/residuo"
    else:
        first = "L5L3"
    return dict(pf4=inl, pass8=ok8, max8=m8, even=ev, first=first,
                rank0=None)


# the 98
surv98 = []
for c, P in homog.items():
    s = status(c)
    if s["pass8"] and s["even"]:
        surv98.append(c)
print("98 check:", len(surv98), " pass8 among Pf4:", sum(1 for c in homog if status(c)["pass8"]))

lv8 = collections.defaultdict(dict)
for line in open(os.path.join(FAB, "polares_nivel8.txt")):
    if line.startswith("#") or not line.strip():
        continue
    case, code, fib = line.split()
    lv8[case][code] = int(fib)
lv9 = collections.defaultdict(set)
for line in open(os.path.join(FAB, "sobreviventes_nivel9.txt")):
    if line.startswith("#") or not line.strip():
        continue
    parts = line.split()
    lv9[parts[0]].add(parts[3])

out = {}
for case in "ABC":
    cnt = collections.Counter(); rows = []
    for code, fib in sorted(lv8[case].items()):
        s = status(code)
        cnt[s["first"]] += 1
        rows.append(dict(code=code, fibra=fib, nivel9=code in lv9[case], in98=code in surv98, **s))
    out[case] = rows
    print("case", case, "level-8 polars", len(rows), dict(cnt))
    print("   in the 98:", sum(r["in98"] for r in rows),
          " pass level 9:", sum(r["nivel9"] for r in rows),
          " level9 & in98:", sum(r["nivel9"] and r["in98"] for r in rows))
    c9 = collections.Counter(r["first"] for r in rows if r["nivel9"])
    print("   first repo filter among level-9 survivors:", dict(c9))
# the 98 by case
cases98 = collections.Counter()
for c in surv98:
    u30, u40, u42 = int(c[0]), int(c[1]), int(c[2])
    k = {(0, 0, 0): "A", (1, 1, 0): "B", (1, 0, 1): "C"}.get((u30, u40, u42), "outro")
    inl8 = c in lv8.get(k, {})
    cases98[(k, inl8)] += 1
print("the 98 by (case, is level-8 polar):", dict(cases98))
json.dump(dict(surv98=surv98, casos=out), open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "mapa_filtros.json"), "w"), indent=0)

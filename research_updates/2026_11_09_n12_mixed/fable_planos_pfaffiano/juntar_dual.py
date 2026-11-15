"""Combine Gamma-orbits (estr_out/simetria.json) with duality and shift edges (dual-*.json): components vs families."""
import sys, json, glob, collections
S = json.load(open("estr_out/simetria.json")); R = json.load(open("estr_out/resumo_estrutura.json"))["results"]
D = []
for f in sys.argv[1:]:
    D += json.load(open(f))
info = {r["polar"]: r for r in R}
key = lambda p: (info[p]["count"], info[p]["dim_U"], info[p].get("hull_dim"), info[p].get("stab_dim"), info[p].get("cosets")) if p in info else ("zero",)
adj = collections.defaultdict(set)
for orb in S["orbits"]:
    ps = [h[:12] for h in orb]
    for a in ps:
        for b in ps:
            adj[a].add(b)
dual_deg = collections.Counter(); dual_out = 0; shift_moves = 0; dual_same = 0
for r in D:
    for d in r["dual"]:
        dual_deg[(d["degree"], d["quadratic_in_w"], d["rs"])] += 1
        if d["polar"] and d["in_bent_list"]:
            adj[r["polar"]].add(d["polar"]); adj[d["polar"]].add(r["polar"])
            dual_same += d["polar"] == r["polar"]
        else:
            dual_out += 1
    for s in r["shift"]:
        if not s["same"]:
            shift_moves += 1
            adj[r["polar"]].add(s["polar"]); adj[s["polar"]].add(r["polar"])
print("dual (degree, quadratic in w, RS):", dict(dual_deg), "| duals outside the model/list:", dual_out,
      "| self-dual polar:", dual_same)
print("shift by 1...1 changing the polar:", shift_moves)
nodes = set(adj) | set(info)
seen = set(); comps = []
for v in sorted(nodes):
    if v in seen: continue
    st = [v]; c = set()
    while st:
        x = st.pop()
        if x in c: continue
        c.add(x); st += list(adj[x] - c)
    seen |= c; comps.append(c)
print("components with Gamma + duality + shift:", len(comps))
fam = collections.Counter(key(p) for p in info)
comp_of_fam = collections.Counter()
mixed = 0
for c in comps:
    ks = {key(p) for p in c}
    if len(ks) > 1: mixed += 1
    for k in ks: comp_of_fam[k] += 1
print("components mixing different families:", mixed)
for k, v in sorted(fam.items(), key=lambda kv: str(kv[0])):
    print("  family", k, "polars", v, "-> components", comp_of_fam[k])

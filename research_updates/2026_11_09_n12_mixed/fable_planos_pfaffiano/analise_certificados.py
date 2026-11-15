"""Pattern analysis over all certificates (dead trees, bent trees, Pf4 enumeration).

Reports:
 1. which constraints the certificates use (families S / W / F, directions, flats), and how often;
 2. greedy cover: a small set of constraint 'types' that already closes every dead polar;
 3. root closures: which single constraints kill a polar at the root;
 4. bent trees: dimensions of the 'allbent' leaves, count = odd * 2^k decomposition;
 5. 'lin' identities: the shapes (multiset of families) of the combinations that give 1;
 6. Pf4 solution set: 711 pass leaves, their dimensions, and the free low part.
Usage: python analise_certificados.py <dead certs .json.gz> <bent certs .json> <pf4 cert .json> [--out file.json]"""
import sys, json, gzip, collections, math


def walk(node, fn, depth=0):
    fn(node, depth)
    for k in node.get("kids", []):
        walk(k, fn, depth + 1)


def refs_of_node(node):
    out = []
    for a in node.get("actions", []):
        if "restrict" in a:
            out += [u[1] for u in a["restrict"]]
    for st in node.get("steps", []):
        out += st
    out += [u[1] if isinstance(u, list) and len(u) == 2 and isinstance(u[1], list) else u for u in node.get("use", [])]
    out += node.get("refs", [])
    return out


def fam(ref):
    return ref[0] if isinstance(ref, list) and ref and isinstance(ref[0], str) else "?"


def shape(ref):
    """Structural type of a constraint, invariant-ish: family + coarse parameters."""
    f = fam(ref)
    if f == "S":
        return ("S", bin(ref[1]).count("1"))                        # weight of the direction d
    if f == "W":
        return ("W", bin(ref[1]).count("1"), bin(ref[2]).count("1"))  # weights of u and b
    if f == "F":
        _, p, q, om, w0, I = ref
        return ("F", "I=" + ("{}" if I < 0 else "{i}"), bin(om).count("1"))
    return (f,)


def main():
    dead = json.load(gzip.open(sys.argv[1]))
    bent = json.load(open(sys.argv[2]))
    pf4 = json.load(open(sys.argv[3]))
    rep = {}

    # 1. constraint usage in the dead certificates
    use_fam = collections.Counter(); use_shape = collections.Counter(); per_polar_shapes = {}
    use_S_dir = collections.Counter()
    for r in dead:
        shapes = set()
        def f(node, depth):
            for ref in refs_of_node(node):
                use_fam[fam(ref)] += 1; use_shape[shape(ref)] += 1; shapes.add(shape(ref))
                if fam(ref) == "S":
                    use_S_dir[ref[1]] += 1
        walk(r["cert"], f)
        per_polar_shapes[r["polar"]] = shapes
    rep["usage_by_family"] = dict(use_fam)
    rep["top_shapes"] = [(list(map(str, k)), v) for k, v in use_shape.most_common(15)]
    rep["S_directions_most_used"] = use_S_dir.most_common(10)

    # 2. greedy cover by shapes (a polar is 'covered' by a shape set if its certificate uses only those shapes)
    remaining = set(per_polar_shapes)
    chosen = []
    allowed = set()
    while remaining:
        best = None
        for s in use_shape:
            if s in allowed:
                continue
            gain = sum(1 for h in remaining if per_polar_shapes[h] <= allowed | {s})
            if best is None or gain > best[1]:
                best = (s, gain)
        if best is None or best[1] == 0:
            # add the shape that appears in most remaining polars
            cnt = collections.Counter(s for h in remaining for s in per_polar_shapes[h] - allowed)
            s = cnt.most_common(1)[0][0]; allowed.add(s); chosen.append((list(map(str, s)), 0)); continue
        allowed.add(best[0]); chosen.append((list(map(str, best[0])), best[1]))
        remaining = {h for h in remaining if not per_polar_shapes[h] <= allowed}
    rep["greedy_shape_cover"] = chosen

    # 3. root closures
    root = collections.Counter()
    for r in dead:
        c = r["cert"]
        if "kids" not in c:
            root[(c.get("leaf"), tuple(sorted(set(fam(x) for x in refs_of_node(c)))))] += 1
    rep["root_closures"] = [(list(map(str, k)), v) for k, v in root.most_common()]

    # 4. bent trees: allbent leaf dims
    bent_info = []
    for r in bent:
        dims = collections.Counter()
        def g(node, depth):
            if node.get("leaf") == "allbent":
                dims[node["dim"]] += 1
        walk(r["cert"], g)
        cnt = sum(v << d for d, v in dims.items())
        k = (cnt & -cnt).bit_length() - 1 if cnt else 0
        bent_info.append({"polar": r["polar"][:12], "count": cnt, "odd": cnt >> k if cnt else 0, "two_power": k,
                          "allbent_dims": dict(sorted(dims.items())), "nodes": r.get("nodes")})
    rep["bent"] = sorted(bent_info, key=lambda x: x["count"])
    rep["bent_count_forms"] = collections.Counter("%d*2^%d" % (b["odd"], b["two_power"]) for b in bent_info).most_common()

    # 5. lin identities: family multisets
    lin_shapes = collections.Counter(); lin_sizes = collections.Counter()
    for r in dead:
        def h(node, depth):
            if node.get("leaf") in ("lin", "affine"):
                refs = refs_of_node({"use": node.get("use", []), "refs": node.get("refs", [])})
                lin_sizes[len(refs)] += 1
                lin_shapes[tuple(sorted(collections.Counter(fam(x) for x in refs).items()))] += 1
        walk(r["cert"], h)
    rep["lin_leaf_sizes"] = sorted(lin_sizes.items())[:20]
    rep["lin_leaf_family_mix"] = [(str(k), v) for k, v in lin_shapes.most_common(10)]

    # 6. Pf4 enumeration
    dims = collections.Counter()
    def p(node, depth):
        if node.get("leaf") == "pass":
            dims[node["dim"]] += 1
    walk(pf4["tree"], p)
    rep["pf4_pass_leaf_dims"] = dict(sorted(dims.items()))
    rep["pf4_solutions"] = pf4.get("solutions")

    out = sys.argv[sys.argv.index("--out") + 1] if "--out" in sys.argv else None
    txt = json.dumps(rep, indent=1, default=str)
    print(txt[:6000])
    if out:
        open(out, "w").write(txt)


if __name__ == "__main__":
    main()

"""Merge the subtrees of a split run of cert_arvore3.py (CERT_SPLIT_DEPTH, CERT_SPLIT=i/n) into one certificate.
Usage: python merge_split.py <out.json> <worker files...>"""
import sys, json


def collect(node, acc):
    if "split" in node and node.get("leaf") != "skip":
        acc[node["split"]] = node
    for k in node.get("kids", []):
        collect(k, acc)
    return acc


def fill(node, parts, missing):
    for i, k in enumerate(node.get("kids", [])):
        if k.get("leaf") == "skip":
            if k["split"] in parts:
                node["kids"][i] = parts[k["split"]]
            else:
                missing.append(k["split"])
        else:
            fill(k, parts, missing)


def leaves(n, acc):
    if "kids" in n:
        for k in n["kids"]:
            leaves(k, acc)
    else:
        acc[n["leaf"]] = acc.get(n["leaf"], 0) + 1
    return acc


def size(n):
    return 1 + sum(size(k) for k in n.get("kids", []))


by_polar = {}
for f in sys.argv[2:]:
    for r in json.load(open(f)):
        by_polar.setdefault(r["polar"], []).append(r)
out = []
for hx, recs in by_polar.items():
    if any(r.get("cert") is None for r in recs):
        print(hx[:12], "a worker has no tree (budget?)"); continue
    parts = {}
    for r in recs:
        collect(r["cert"], parts)
    root = recs[0]["cert"]
    if root.get("leaf") == "skip":
        root = parts.get(root["split"], root)
    missing = []
    fill(root, parts, missing)
    lv = leaves(root, {})
    status = "certified" if not missing and "point-open" not in lv and "skip" not in lv else "open"
    out.append({"polar": hx, "dim_U": recs[0]["dim_U"], "format": "arvore3", "status": status,
                "nodes": size(root), "leaves": lv, "cert": root, "workers": len(recs)})
    print(hx[:12], status, "workers", len(recs), "nodes", size(root), lv, "missing", len(missing))
json.dump(out, open(sys.argv[1], "w"))

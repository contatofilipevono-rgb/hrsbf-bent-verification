"""Short certificates for the residual rho-cells of x24 = 1 (cells that no single support
equation excludes).  For each such cell, find the smallest XOR combination of valid support
equations that equals 1 on every point of the cell.

Valid support equations (each vanishes on every admissible map):
  M(t, m) = sum_{x in P_t} m(x) mod 2, m in {x_i, x_i x_j}  (orthogonality to RM(2,8)),
  M(t, 1) = |P_t| mod 2,
  B(t, j) = bit j of |P_t| xor bit j of 16, j = 1..4          (fibre size, non-polynomial).
Search: weight 1, 2, 3, 4 exactly (hashing of truth tables over the cell), first with moments only,
then allowing size bits; otherwise a linear solution.  Usage:
  python -I short_certs.py REPO --classes 164 --out short-164.json [--shard i/m]
"""
import sys, json, time, argparse
from collections import Counter
from itertools import combinations
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
import plane_cert as PC

MASK = (1 << 256) - 1


def dd(z): return (z & 7) ^ (z >> 3)


def cells_of(M, k):
    """Yield (cell_base_code, cell_directions, info) for the rho-cells of x24 = 1 that pass the
    rho-only filters (same construction as cells_x24.py)."""
    base, dirs = PC.space_for(M, k, "H4")
    lin = [(d >> 24) & 1 for d in dirs]; p = lin.index(1)
    b1 = base if (base >> 24) & 1 else base ^ dirs[p]
    d1 = [d ^ dirs[p] if lin[i] else d for i, d in enumerate(dirs) if i != p]
    def mapping_of(code):
        m = 0
        for i in range(33):
            if code >> i & 1:
                m ^= M.basis[i]
        return m
    lab_b = M.labels(mapping_of(b1))
    D1 = [lab_b[z + 64] ^ lab_b[z] for z in range(64)]
    D2 = [lab_b[z + 128] ^ lab_b[z] for z in range(64)]
    Sp = {}
    for v in D1 + D2:
        while v and (v.bit_length() - 1) in Sp:
            v ^= Sp[v.bit_length() - 1]
        if v:
            Sp[v.bit_length() - 1] = v
    S_size = 1 << len(Sp)
    def proj(t):
        for pv in sorted(Sp, reverse=True):
            if t >> pv & 1:
                t ^= Sp[pv]
        return t
    def rho_word(code):
        lab = M.labels(mapping_of(code))
        return sum(proj(lab[z]) << (4 * z) for z in range(64))
    r0 = rho_word(b1)
    piv = {}; rch = []; rker = []
    for d in d1:
        x = rho_word(b1 ^ d) ^ r0; v = d
        while x and (x.bit_length() - 1) in piv:
            px, pv = piv[x.bit_length() - 1]; x ^= px; v ^= pv
        if x:
            piv[x.bit_length() - 1] = (x, v); rch.append((x, v))
        else:
            rker.append(v)
    pair_case = set(D1 + D2) <= {0, 15} and S_size == 2
    if pair_case:
        A = {dd(z) for z in range(64) if D1[z]}; B = {dd(z) for z in range(64) if D2[z]}
        Mset = A | B
    reps = sorted({proj(t) for t in range(16)})
    for sel in range(1 << len(rch)):
        r = r0; code = b1
        for i, (x, v) in enumerate(rch):
            if sel >> i & 1:
                r ^= x; code ^= v
        rho = [(r >> (4 * z)) & 15 for z in range(64)]
        Z = [[z for z in range(64) if rho[z] == t] for t in reps]
        if any(len(s) != 4 * S_size for s in Z):
            continue
        ok = True
        for s in (Z if pair_case else []):
            for SS in (A, B):
                q = [z for z in s if dd(z) in SS]; acc = 0
                for z in q:
                    acc ^= z
                if len(q) % 2 or acc:
                    ok = False
            if sum(dd(z) in Mset for z in s) % 2:
                ok = False
        if ok:
            yield code, rker, {"rho_sel": sel, "S_size": S_size}


def truth_tables(M, code, rker):
    """Truth tables (ints over the 2^len(rker) cell points) of all valid support equations."""
    def mapping_of(c):
        m = 0
        for i in range(33):
            if c >> i & 1:
                m ^= M.basis[i]
        return m
    n = len(rker)
    m0 = mapping_of(code); dm = [mapping_of(v) for v in rker]
    xs = [sum(1 << x for x in range(256) if x >> i & 1) for i in range(8)]
    mons = [("1", MASK)] + [(f"x{i}", xs[i]) for i in range(8)] + \
           [(f"x{i}x{j}", xs[i] & xs[j]) for i, j in combinations(range(8), 2)]
    names = [("M", t, nm) for t in range(16) for nm, _ in mons] + \
            [("B", t, j) for t in range(16) for j in range(1, 5)]
    tables = [0] * len(names)
    mp = m0
    for kk in range(1 << n):
        if kk:
            i = (kk & -kk).bit_length() - 1
            mp ^= dm[i]
        g = kk ^ (kk >> 1)            # Gray code: point index
        c = [(mp >> (256 * i)) & MASK for i in range(4)]
        nc = [MASK ^ w for w in c]
        e = 0
        for t in range(16):
            f = MASK
            for i in range(4):
                f &= c[i] if t >> i & 1 else nc[i]
            for _, m in mons:
                if (f & m).bit_count() & 1:
                    tables[e] |= 1 << g
                e += 1
        sizes_start = 16 * len(mons)
        for t in range(16):
            f = MASK
            for i in range(4):
                f &= c[i] if t >> i & 1 else nc[i]
            w = f.bit_count()
            for j in range(1, 5):
                if ((w >> j) ^ (16 >> j)) & 1:
                    tables[sizes_start + 4 * t + (j - 1)] |= 1 << g
    return names, tables


def shortest(names, tables, full, allowed, maxw=4):
    idx = [i for i in range(len(names)) if allowed(names[i]) and tables[i]]
    cols = {}
    for i in idx:
        cols.setdefault(tables[i], i)
    # weight 1
    if full in cols:
        return [cols[full]]
    # weight 2
    for i in idx:
        j = cols.get(full ^ tables[i])
        if j is not None and j != i:
            return [i, j]
    if maxw < 3:
        return None
    # weight 3 and 4: pair table
    pairs = {}
    for a, b in combinations(idx, 2):
        pairs.setdefault(tables[a] ^ tables[b], (a, b))
    for i in idx:
        pr = pairs.get(full ^ tables[i])
        if pr and i not in pr:
            return [i, *pr]
    if maxw < 4:
        return None
    for key, (a, b) in pairs.items():
        pr = pairs.get(full ^ key)
        if pr and not set(pr) & {a, b}:
            return [a, b, *pr]
    return None


def linear_solution(names, tables, full, allowed):
    """Any combination equal to 1 everywhere (Gaussian elimination over points)."""
    idx = [i for i in range(len(names)) if allowed(names[i]) and tables[i]]
    piv = {}
    for i in idx:
        x = tables[i]; comb = 1 << i
        while x and (x.bit_length() - 1) in piv:
            px, pc = piv[x.bit_length() - 1]; x ^= px; comb ^= pc
        if x:
            piv[x.bit_length() - 1] = (x, comb)
    x = full; comb = 0
    while x and (x.bit_length() - 1) in piv:
        px, pc = piv[x.bit_length() - 1]; x ^= px; comb ^= pc
    if x:
        return None
    return [i for i in range(len(names)) if comb >> i & 1]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("repo"); ap.add_argument("--classes", required=True)
    ap.add_argument("--shard", default="0/1"); ap.add_argument("--out", required=True)
    a = ap.parse_args()
    si, sm = map(int, a.shard.split("/"))
    M = PC.Model(a.repo)
    out = []
    for k in [int(x) for x in a.classes.split(",")]:
        t0 = time.time(); stat = Counter(); idx = -1
        for code, rker, info in cells_of(M, k):
            idx += 1
            if idx % sm != si:
                continue
            names, tables = truth_tables(M, code, rker)
            full = (1 << (1 << len(rker))) - 1
            res = {"class": k, "cell_index": idx, "cell_base_code": code, "cell_dim": len(rker), **info}
            moments_only = lambda nm: nm[0] == "M"
            cert = shortest(names, tables, full, moments_only)
            kind = "moments"
            if cert is None:
                cert = shortest(names, tables, full, lambda nm: True)
                kind = "moments+size"
            if cert is None:
                cert = linear_solution(names, tables, full, moments_only); kind = "moments, linear"
            if cert is None:
                cert = linear_solution(names, tables, full, lambda nm: True); kind = "moments+size, linear"
            if cert is None:
                kind = "none"
            res["kind"] = kind
            res["certificate"] = [list(map(str, names[i])) for i in cert] if cert else None
            if cert:
                acc = 0
                for i in cert:
                    acc ^= tables[i]
                assert acc == full
            stat[(kind, len(cert) if cert else 0)] += 1
            out.append(res)
        print(k, dict(stat), round(time.time() - t0, 1), "s", flush=True)
    Path(a.out).write_text(json.dumps(out, indent=1))


if __name__ == "__main__":
    main()

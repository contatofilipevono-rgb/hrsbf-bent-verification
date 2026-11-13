"""Bit-sliced exhaustive check of the phase plane on an affine space of maps (from the model).

For every assignment of the n free parameters (one bit per assignment), compute
  adm  = all 16 fibres have 16 points and are orthogonal to RM(2,8)
  viol = some phase column (48 moments) is outside the plane L
and report |adm|, |adm & viol| and a decodable witness code if a violation exists.
Optional slicing: fix the top `fix` parameters to the value `slice`.
"""
import sys, json, argparse, hashlib
from itertools import combinations
from pathlib import Path

L1, L2 = 0x084006C00810, 0x106002400C20
MASK = (1 << 256) - 1
USE_SIZE = True


def annihilator_L():
    # basis of y in F2^48 with y.L1 = y.L2 = 0
    out = []
    piv = {}
    for v in (L1, L2):
        while v and (v.bit_length() - 1) in piv:
            v ^= piv[v.bit_length() - 1]
        piv[v.bit_length() - 1] = v
    for p in sorted(piv):
        for q in piv:
            if q != p and piv[q] >> p & 1:
                piv[q] ^= piv[p]
    free = [i for i in range(48) if i not in piv]
    for f in free:
        y = 1 << f
        for p, v in piv.items():
            if v >> f & 1:
                y |= 1 << p
        out.append(y)
    assert len(out) == 46
    return out


def run(repo, kappa, base, dirs, fix=0, slc=0):
    sys.path.insert(0, str(Path(repo).resolve()))
    from dim4_support_decode import decode
    model, basis, labels = decode(1)
    phases = model.phases
    def mapping_of(code):
        m = 0
        for i in range(33):
            if code >> i & 1:
                m ^= basis[i]
        return m
    n_all = len(dirs)
    # fix the top `fix` free parameters
    for j in range(fix):
        if slc >> j & 1:
            base ^= dirs[n_all - 1 - j]
    dirs = dirs[:n_all - fix]
    n = len(dirs)
    W = 1 << n
    FULL = (1 << W) - 1
    var = [FULL ^ (FULL // ((1 << (1 << i)) + 1)) for i in range(n)]
    m0 = mapping_of(base); dm = [mapping_of(d) for d in dirs]
    # truth table of pi_k(x) for each point x and coordinate k
    def coord(x, k):
        bit = 256 * k + x
        t = FULL if m0 >> bit & 1 else 0
        for i in range(n):
            if dm[i] >> bit & 1:
                t ^= var[i]
        return t
    C = [[coord(x, k) for k in range(4)] for x in range(256)]
    xs = [sum(1 << x for x in range(256) if x >> i & 1) for i in range(8)]
    rm2 = xs + [xs[i] & xs[j] for i, j in combinations(range(8), 2)]
    s1, s2 = xs[6], xs[7]
    ann = annihilator_L()
    adm = FULL
    entries = [[0] * 48 for _ in phases]
    for t in range(16):
        ind = []
        for x in range(256):
            v = FULL
            for k in range(4):
                v &= C[x][k] if t >> k & 1 else FULL ^ C[x][k]
            ind.append(v)
        # fibre size == 16 (bit-sliced counter)
        cnt = [0] * 9
        for v in ind:
            carry = v
            for k in range(9):
                nxt = cnt[k] & carry
                cnt[k] ^= carry
                carry = nxt
                if not carry:
                    break
        if USE_SIZE:
            for k in range(9):
                adm &= cnt[k] if k == 4 else FULL ^ cnt[k]
        else:
            adm &= FULL ^ cnt[0]          # only |P_t| even (degree-0 orthogonality)
        # orthogonality to RM(2,8) monomials of degree 1, 2 (degree 0 is the size parity)
        for m in rm2:
            p = 0
            mm = m
            while mm:
                x = (mm & -mm).bit_length() - 1; mm &= mm - 1
                p ^= ind[x]
            adm &= FULL ^ p
        # phase entries
        for a, ph in enumerate(phases):
            for i, sub in enumerate((MASK, s1, s2)):
                p = 0
                mm = ph & sub
                while mm:
                    x = (mm & -mm).bit_length() - 1; mm &= mm - 1
                    p ^= ind[x]
                entries[a][3 * t + i] = p
    viol = 0
    for a in range(len(phases)):
        for y in ann:
            p = 0
            yy = y
            while yy:
                e = (yy & -yy).bit_length() - 1; yy &= yy - 1
                p ^= entries[a][e]
            viol |= p
    bad = adm & viol
    witness = None
    if bad:
        j = (bad & -bad).bit_length() - 1
        code = base
        for i in range(n):
            if j >> i & 1:
                code ^= dirs[i]
        witness = code
    admc = adm.bit_count()
    digest = hashlib.sha256(adm.to_bytes((W + 7) // 8, "little")).hexdigest()[:16]
    return {"class": kappa, "slice": slc, "fix": fix, "dim": n, "assignments": W,
            "admissible": admc, "violations": bad.bit_count(), "witness": witness,
            "adm_digest": digest}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("repo"); ap.add_argument("spaces", help="json from plane_cert (H4 spaces)")
    ap.add_argument("--classes", required=True); ap.add_argument("--fix", type=int, default=0)
    ap.add_argument("--slices", default="all"); ap.add_argument("--out", required=True)
    ap.add_argument("--no-size", action="store_true", help="drop |P_t| = 16 (keep only orthogonality)")
    a = ap.parse_args()
    global USE_SIZE
    USE_SIZE = not a.no_size
    S = json.loads(Path(a.spaces).read_text())
    res = []
    ks = sorted(map(int, S)) if a.classes == "nonempty" else [int(x) for x in a.classes.split(",")]
    for k in ks:
        sp = S[str(k)]["H4"]
        if sp.get("empty"):
            continue
        sl = range(1 << a.fix) if a.slices == "all" else [int(x) for x in a.slices.split(",")]
        for s in sl:
            r = run(a.repo, k, sp["base"], sp["dirs"], a.fix, s)
            print(json.dumps(r), flush=True)
            res.append(r)
    Path(a.out).write_text(json.dumps(res, indent=1))


if __name__ == "__main__":
    main()

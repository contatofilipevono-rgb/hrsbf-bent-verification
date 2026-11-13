"""Residue structure per class: columns mod L as polynomials on the H4 space.
Group the ANF by residue vector: residue = sum_k r_k(c) * w_k with w_k in F2^48/L (per phase)."""
import sys, json
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from plane_cert import Model, anf_of
M = Model(sys.argv[1]); S = json.loads(Path(sys.argv[2]).read_text())
def mapping_of(code):
    m = 0
    for i in range(33):
        if code >> i & 1:
            m ^= M.basis[i]
    return m
out = {}
for k in sorted(map(int, S)):
    sp = S[str(k)]["H4"]
    if sp.get("empty"):
        continue
    base, dirs = sp["base"], sp["dirs"]; n = len(dirs)
    def colfun(mp):
        v = 0
        for a, c in enumerate(M.columns_mod_L(mp)):
            v |= c << (48 * a)
        return v
    anf = anf_of(colfun, n, 4, mapping_of(base), [mapping_of(d) for d in dirs])
    # residue vectors spanned by ANF coefficient vectors
    vecs = set(anf.values())
    piv = {}
    for v in vecs:
        x = v
        while x and (x.bit_length() - 1) in piv:
            x ^= piv[x.bit_length() - 1]
        if x:
            piv[x.bit_length() - 1] = x
    degs = sorted({bin(m).count("1") for m in anf})
    phases = sorted({a for v in vecs for a in range(19) if (v >> (48 * a)) & ((1 << 48) - 1)})
    # express each coefficient in the basis -> polynomial per basis vector
    basis = list(piv.values())
    polys = [[] for _ in basis]
    for mono, v in anf.items():
        x = v; comb = 0
        for p in sorted(piv, reverse=True):
            if x >> p & 1:
                x ^= piv[p]; comb |= 1 << basis.index(piv[p])
        assert x == 0
        for i in range(len(basis)):
            if comb >> i & 1:
                polys[i].append(mono)
    out[k] = {"dim": n, "rank_of_residue_space": len(basis), "monomial_degrees": degs,
              "phases": phases,
              "residue_polynomials": [{"vector_per_phase": {a: hex((b >> (48 * a)) & ((1 << 48) - 1))
                                                             for a in range(19) if (b >> (48 * a)) & ((1 << 48) - 1)},
                                       "monomials": sorted(ps)} for b, ps in zip(basis, polys)]}
    print(k, "dim", n, "residue rank", len(basis), "degrees", degs, "phases", phases,
          "terms per polynomial", [len(p) for p in polys], flush=True)
Path(sys.argv[3]).write_text(json.dumps(out, indent=1))

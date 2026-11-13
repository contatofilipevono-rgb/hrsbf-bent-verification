"""Small verifier for the common V1 phase plane L = <0x084006c00810, 0x106002400c20>
(n = 12, degree 4, block V1 = <7,14,28,56>), without the support catalog.

For each of the 256 polar classes (code >> 25):
  1. Build the affine space A_k of map codes allowed by the support hypotheses
     (H-orth: every product of label coordinates is orthogonal to RM(2,8);
      H-bal : balance of the labels through character sums; only their affine consequences).
     Empty space => the class has no admissible map.
  2. Degree-4 identity (exact interpolation on points of weight <= 4): on A_k, every phase column
     reduced mod L equals r_k(c) * w with a single affine form r_k and a fixed vector w.
     r_k identically 0 => the class is closed by identity.
  3. Otherwise, bit-sliced exhaustive check on A_k: every map with 16 fibres of 16 points
     orthogonal to RM(2,8) satisfies r_k = 0 (equivalently, its columns lie in L).
     Relaxation control: dropping |P_t| = 16 produces maps with r_k = 1; one is kept as a witness.
Writes certificate.json.  Usage:
  python -I verify_plane.py REPO_DIR [--classes all|i,j,..] [--out certificate.json]
"""
import sys, json, time, argparse
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
import plane_cert as PC
import enum_slice as ES


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("repo"); ap.add_argument("--classes", default="all")
    ap.add_argument("--out", default="certificate.json")
    a = ap.parse_args()
    M = PC.Model(a.repo)
    def mapping_of(code):
        m = 0
        for i in range(33):
            if code >> i & 1:
                m ^= M.basis[i]
        return m
    ks = range(256) if a.classes == "all" else [int(x) for x in a.classes.split(",")]
    cert = {"plane": ["0x084006c00810", "0x106002400c20"], "classes": {}}
    W_common = None
    for k in ks:
        t0 = time.time()
        sp = PC.space_for(M, k, "H4")
        if sp is None:
            cert["classes"][k] = {"status": "empty"}
            continue
        base, dirs = sp; n = len(dirs)
        def colfun(mp):
            v = 0
            for i, c in enumerate(M.columns_mod_L(mp)):
                v |= c << (48 * i)
            return v
        anf = PC.anf_of(colfun, n, 4, mapping_of(base), [mapping_of(d) for d in dirs])
        vecs = set(anf.values())
        assert len(vecs) <= 1, (k, "residue space of rank > 1")
        assert all(bin(m).count("1") <= 1 for m in anf), (k, "residue not affine")
        entry = {"dim": n, "base": base, "dirs": dirs}
        if not anf:
            entry["status"] = "identity"
            ES.USE_SIZE = True
            res = ES.run(a.repo, k, base, dirs)          # coverage control only
            assert res["violations"] == 0
            entry["admissible"] = res["admissible"]
        else:
            w = vecs.pop()
            if W_common is None:
                W_common = w
            assert w == W_common, (k, "residue vector differs between classes")
            # r_k as affine form in the H4 coordinates, then as a mask on the 25 low code bits
            const = 1 if 0 in anf else 0
            lin = sum(m for m in anf if m)
            # solve mu . dirs_i = lin_i, mu . base(low) = const ^ 0  -> mu over 25 bits, rhs const'
            eqs = [(sum((dirs[i] >> j & 1) << j for j in range(25)), lin >> i & 1) for i in range(n)]
            sol = PC.lin_solve(eqs, 25)
            mu = sol[0]
            c0 = const ^ (bin(mu & base).count("1") & 1)
            entry.update(status="enumerated", r_mask=hex(mu), r_const=c0,
                         r_terms_in_H4_coordinates=[m.bit_length() - 1 for m in anf if m] + (["1"] if const else []))
            ES.USE_SIZE = True
            res = ES.run(a.repo, k, base, dirs)
            assert res["violations"] == 0, (k, res)
            ES.USE_SIZE = False
            rel = ES.run(a.repo, k, base, dirs)
            ES.USE_SIZE = True
            entry.update(admissible=res["admissible"],
                         relaxed_no_size={"maps": rel["admissible"], "violations": rel["violations"],
                                          "witness_code": rel["witness"]})
            if rel["witness"] is not None:
                # the witness satisfies all orthogonality moments but not |P_t| = 16
                lab = M.labels(mapping_of(rel["witness"]))
                sizes = [lab.count(t) for t in range(16)]
                assert any(s != 16 for s in sizes)
                assert bin(mu & rel["witness"]).count("1") & 1 ^ c0 == 1, "witness must have r = 1"
                entry["relaxed_no_size"]["witness_fibre_sizes"] = sizes
        entry["seconds"] = round(time.time() - t0, 1)
        cert["classes"][k] = entry
        print(k, entry["status"], entry.get("dim"), entry.get("admissible"),
              entry.get("relaxed_no_size", {}).get("violations"), entry["seconds"], flush=True)
    if W_common is not None:
        cert["residue_vector_per_phase"] = {i: hex((W_common >> (48 * i)) & ((1 << 48) - 1))
                                            for i in range(19) if (W_common >> (48 * i)) & ((1 << 48) - 1)}
    st = {}
    for e in cert["classes"].values():
        st[e["status"]] = st.get(e["status"], 0) + 1
    cert["summary"] = {"status_counts": st,
                       "total_admissible": sum(e.get("admissible", 0) for e in cert["classes"].values())}
    Path(a.out).write_text(json.dumps(cert, indent=1))
    print(json.dumps(cert["summary"]))


if __name__ == "__main__":
    main()

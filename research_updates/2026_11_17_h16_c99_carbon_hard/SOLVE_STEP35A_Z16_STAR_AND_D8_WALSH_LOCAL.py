#!/usr/bin/env python3
r"""
SOLVE_STEP35A_Z16_STAR_AND_D8_WALSH_LOCAL.py

FAST LOCAL PURE-MATH PROBE (runs in ~5s on Windows Python + numpy, zero gcc needed!):
  PART 1: EXACT ACTION OF Z_16^* = {1, 3, 5, 7, 9, 11, 13, 15} ON THE 116 ORBITS OF H(16, 4)
    - Verifies which multipliers k preserve c_115, c_99, c_57, c_113 (i.e. each cell B0_00, B0_11, B1_11!).
    - Computes the exact Z_16^*-orbits on the 64 eta-states of B0_00 (how many distinct open orbits remain?!).
    - Computes the exact Z_16^* Loewy/fixed-subspace dimensions on the 111-var space.
  PART 2: EXACT C_8-DUAL WALSH SPECTRUM OBSTRUCTION ON B0_11 (wt=64) AND B1_11 (wt=160)
    - By Poisson summation on D_8:
        S_{D_8}(z) = sum_{u in D_8} (-1)^{f(u, u^z)} = W_g(z),
      where g = f_tilde|_{D_8^perp} : F_2^8 -> F_2 is C_8-symmetric with EXACT weight:
        wt(g) = 0 (B0_00), 64 (B0_11), 160 (B1_11)!
    - Uses exact DP over the 36 C_8-orbits of F_2^8 to compute ALL achievable triples
      (wt(g), W_g(0xFF), W_g(0x55)) for C_8-symmetric g!
    - Evaluates ALL 512 states of (z=0xFF, z=0x55) in B0_11 & B1_11 (and ALL 8 states of z=0xFF)
      to see how many states are FORBIDDEN by the exact C_8-dual Walsh theorem!
"""

import sys
import time
from pathlib import Path
import numpy as np

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_B09_DUAL_S_ELIM as b09
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16


def perm_monomial(m, k):
    """Apply x_i -> x_{k*i mod 16} to a 16-bit monomial mask m."""
    out = 0
    for i in range(16):
        if (m >> i) & 1:
            out |= (1 << ((k * i) & 15))
    return out


def compute_c8_dual_walsh_dp():
    """Exact DP over the 36 C_8-orbits of F_2^8 computing all achievable (wt(g), W_g(0xFF), W_g(0x55))."""
    seen = set()
    c8_orbs = []
    for b in range(256):
        if b in seen: continue
        orb = []
        cur = b
        while cur not in seen:
            seen.add(cur); orb.append(cur)
            cur = ((cur << 1) | (cur >> 7)) & 0xFF
        c8_orbs.append(orb)
    assert len(c8_orbs) == 36

    # For each orbit, if g=0 on orbit: wt_add=0, wff_add = sum (-1)^{wt(b)}, w55_add = sum (-1)^{<0x55,b>}
    # If g=1 on orbit: wt_add=len(orb), wff_add = -sum, w55_add = -sum
    # Note: W_g(z) = sum_b (-1)^{g(b) + <z,b>}
    states = {(0, 0, 0)}
    for orb in c8_orbs:
        sz = len(orb)
        s_ff = sum(-1 if (b.bit_count() & 1) else 1 for b in orb)
        s_55 = sum(-1 if ((b & 0x55).bit_count() & 1) else 1 for b in orb)
        nxt = set()
        for wt, wff, w55 in states:
            nxt.add((wt, wff + s_ff, w55 + s_55))
            nxt.add((wt + sz, wff - s_ff, w55 - s_55))
        states = nxt
    by_wt = {}
    for wt, wff, w55 in states:
        by_wt.setdefault(wt, set()).add((wff, w55))
    return c8_orbs, by_wt


def main():
    t0 = time.perf_counter()
    orbits = diag_v2.build_orbits_116()
    orb_of_mon = {}
    for j, orb in enumerate(orbits):
        for m in orb: orb_of_mon[m] = j

    print("==================== PART 1: EXACT Z_16^* ACTION ON 116 ORBITS ====================")
    perms = {}
    for k in [1, 3, 5, 7, 9, 11, 13, 15]:
        p = [orb_of_mon[perm_monomial(orbits[j][0], k)] for j in range(116)]
        assert len(set(p)) == 116
        perms[k] = p
        fixed_special = {idx: p[idx] for idx in [0, 57, 99, 113, 115]}
        preserves_all = all(p[idx] == idx for idx in [0, 57, 99, 113, 115])
        n_fix = sum(1 for j in range(116) if p[j] == j)
        print(f"  k={k:2d}: fixed_orbits={n_fix:3d}/116 | special_map={fixed_special} | preserves_cells={preserves_all}")

    # Orbit sizes of the 116 orbits under Z_16^*
    seen_o = set()
    sz_hist = {}
    for j in range(116):
        if j in seen_o: continue
        o_set = {perms[k][j] for k in perms}
        seen_o |= o_set
        sz_hist[len(o_set)] = sz_hist.get(len(o_set), 0) + 1
    print(f"  116-orbit decomposition under Z_16^*: {dict(sorted(sz_hist.items()))} (total Z_16^*-orbits = {sum(sz_hist.values())})")

    # Check action on L1 (the 6 eta-coordinates!)
    layer_vecs = s16.build_orb_degu_degz_vecs(orbits)
    # Build B0_00 pure 111 basis to inspect L1 action
    _, _, cb0 = b09.build_pure_111_basis(0, 0, 0)
    # L1 forms live on the 116-orbit space; see how Z_16^* acts on the 6 L1 orbit-vectors!
    l1_rows = layer_vecs["L1"][1]
    print(f"  L1 has {len(l1_rows)} raw vectors (dim = {layer_vecs['L1'][0]})")

    print("\n==================== PART 2: EXACT C_8-DUAL WALSH SPECTRUM DP ====================")
    _, by_wt = compute_c8_dual_walsh_dp()
    for target_wt, cname in [(64, "B0_11"), (160, "B1_11"), (0, "B0_00")]:
        pairs = by_wt[target_wt]
        wff_vals = sorted({p[0] for p in pairs})
        w55_vals = sorted({p[1] for p in pairs})
        print(f"  [{cname} wt(g)={target_wt:3d}] achievable (W_g(0xFF), W_g(0x55)) pairs = {len(pairs)}")
        print(f"    W_g(0xFF) values ({len(wff_vals)}): {wff_vals[:15]} ... {wff_vals[-5:]}")
        print(f"    W_g(0xFF) mod 8 = {sorted({v % 8 for v in wff_vals})}, mod 16 = {sorted({v % 16 for v in wff_vals})}")
        print(f"    W_g(0x55) mod 8 = {sorted({v % 8 for v in w55_vals})}, mod 16 = {sorted({v % 16 for v in w55_vals})}")

    # Now compute ACTUAL S_{D_8}(0xFF) and S_{D_8}(0x55) on B0_11 and B1_11!
    X = np.arange(65536, dtype=np.uint16)
    orb_tt_np = np.zeros((116, 65536), dtype=np.uint8)
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for m in orb: acc ^= ((X & m) == m).astype(np.uint8)
        orb_tt_np[j] = acc

    pts_00 = np.array([u | (u << 8) for u in range(256)], dtype=np.uint16)
    pts_ff = np.array([u | ((u ^ 0xFF) << 8) for u in range(256)], dtype=np.uint16)
    pts_55 = np.array([u | ((u ^ 0x55) << 8) for u in range(256)], dtype=np.uint16)

    for cname, (c99, c57, c113), target_wt in [("B0_11", (0, 1, 1), 64), ("B1_11", (1, 1, 1), 160)]:
        free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
        orig_tt = np.zeros(65536, dtype=np.uint8)
        for o in range(116):
            if (origin111 >> o) & 1: orig_tt ^= orb_tt_np[o]
        wt_d8 = int(orig_tt[pts_00].sum())
        b_tt = np.zeros((111, 65536), dtype=np.uint8)
        for i in range(111):
            acc = np.zeros(65536, dtype=np.uint8)
            for o in range(116):
                if (cb111[i] >> o) & 1: acc ^= orb_tt_np[o]
            b_tt[i] = acc
        # Check D_8 invariance: b_tt[:, pts_00] should be ALL ZERO!
        d8_var_cnt = int(np.any(b_tt[:, pts_00], axis=1).sum())
        # Get independent linear forms on pts_ff and pts_55
        def get_basis_tts(pts):
            raw = [sum((1 << int(i)) for i in np.flatnonzero(b_tt[:, pts[k]])) for k in range(256) if np.any(b_tt[:, pts[k]])]
            piv = {}
            for m in raw:
                v = m
                while v:
                    b = v.bit_length() - 1
                    if b in piv: v ^= piv[b]
                    else: piv[b] = v; break
            # Strict RREF
            for b in sorted(piv.keys()):
                for hb in list(piv.keys()):
                    if hb > b and ((piv[hb] >> b) & 1): piv[hb] ^= piv[b]
            pvs = sorted(piv.keys())
            tts = [b_tt[p, pts].copy() for p in pvs]
            return pvs, tts

        p_ff, tts_ff = get_basis_tts(pts_ff)
        p_55, tts_55 = get_basis_tts(pts_55)
        # Joint basis for pts_ff U pts_55
        raw_both = ([sum((1 << int(i)) for i in np.flatnonzero(b_tt[:, pts_ff[k]])) for k in range(256) if np.any(b_tt[:, pts_ff[k]])] +
                    [sum((1 << int(i)) for i in np.flatnonzero(b_tt[:, pts_55[k]])) for k in range(256) if np.any(b_tt[:, pts_55[k]])])
        piv_b = {}
        for m in raw_both:
            v = m
            while v:
                b = v.bit_length() - 1
                if b in piv_b: v ^= piv_b[b]
                else: piv_b[b] = v; break
        for b in sorted(piv_b.keys()):
            for hb in list(piv_b.keys()):
                if hb > b and ((piv_b[hb] >> b) & 1): piv_b[hb] ^= piv_b[b]
        p_both = sorted(piv_b.keys())
        nb = len(p_both)

        valid_pairs = by_wt[target_wt]
        valid_ff = {p[0] for p in valid_pairs}
        valid_55 = {p[1] for p in valid_pairs}

        # Evaluate all 2^nb joint states!
        s_ff_hist, s_55_hist = {}, {}
        n_ok_ff, n_ok_55, n_ok_both = 0, 0, 0
        for st in range(1 << nb):
            tff = orig_tt[pts_ff].copy()
            t55 = orig_tt[pts_55].copy()
            for j, p in enumerate(p_both):
                if (st >> j) & 1:
                    tff ^= b_tt[p, pts_ff]
                    t55 ^= b_tt[p, pts_55]
            sff = 256 - 2 * int(tff.sum())
            s55 = 256 - 2 * int(t55.sum())
            s_ff_hist[sff] = s_ff_hist.get(sff, 0) + 1
            s_55_hist[s55] = s_55_hist.get(s55, 0) + 1
            if sff in valid_ff: n_ok_ff += 1
            if s55 in valid_55: n_ok_55 += 1
            if (sff, s55) in valid_pairs: n_ok_both += 1

        print(f"\n  [{cname}] wt(f|_D8)={wt_d8} (d8_var_cnt={d8_var_cnt}), dim_FF={len(p_ff)}, dim_55={len(p_55)}, dim_joint={nb} (2^{nb}={1<<nb} states):")
        print(f"    S_D8(0xFF) hist: {dict(sorted(s_ff_hist.items()))}")
        print(f"    S_D8(0x55) hist: {dict(sorted(s_55_hist.items()))}")
        print(f"    SURVIVING C_8-DUAL WALSH FILTER: ok_FF={n_ok_ff}/{1<<nb}, ok_55={n_ok_55}/{1<<nb}, *** ok_JOINT={n_ok_both}/{1<<nb} ***")

    print(f"\nDONE ({time.perf_counter()-t0:.2f}s)")


if __name__ == "__main__":
    main()

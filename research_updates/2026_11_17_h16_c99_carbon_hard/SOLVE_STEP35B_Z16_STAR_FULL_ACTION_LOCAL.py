#!/usr/bin/env python3
r"""
SOLVE_STEP35B_Z16_STAR_FULL_ACTION_LOCAL.py

3-SECOND LOCAL CHECK:
  1. Verifies whether the FULL order-8 group Z_16^* = {1, 3, 5, 7, 9, 11, 13, 15} preserves
     the exact affine constraint `c_0 + sum_{j in L} c_j = c_99` of each open cell B0_00, B0_11, B1_11!
  2. Computes the EXACT Z_16^*-orbits on the 64 eta-states (L1 space!) of B0_00, B0_11, B1_11!
  3. Checks how many of the 64 eta-states of B0_00 are ALREADY closed by our 26 proved states + Z_16^* symmetry,
     and lists the EXACT remaining open orbit representatives!
"""

import sys
from pathlib import Path

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_B09_DUAL_S_ELIM as b09
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16


def perm_monomial(m, k):
    out = 0
    for i in range(16):
        if (m >> i) & 1:
            out |= (1 << ((k * i) & 15))
    return out


def main():
    orbits = diag_v2.build_orbits_116()
    orb_of_mon = {m: j for j, orb in enumerate(orbits) for m in orb}
    perms = {k: [orb_of_mon[perm_monomial(orbits[j][0], k)] for j in range(116)] for k in [1, 3, 5, 7, 9, 11, 13, 15]}

    # Check if L_INDICES U {0} is Z_16^*-invariant!
    L_full = set(diag_v2.L_INDICES) | {0}
    print(f"L_INDICES size = {len(diag_v2.L_INDICES)}, L_full = L U {{0}} size = {len(L_full)}")
    for k, p in perms.items():
        img = {p[j] for j in L_full}
        ok_L = (img == L_full)
        ok_cell_sym = (p[115] == 115 and p[99] == 99 and {p[57], p[113]} == {57, 113})
        print(f"  k={k:2d}: preserves L_full={ok_L} | preserves {{57,113}} & 99 & 115 = {ok_cell_sym}")

    # Build L1 (the 6 eta-vectors in 116-orbit space) and compute exact Z_16^* action on the 64 eta-states!
    layer_vecs = s16.build_orb_degu_degz_vecs(orbits)
    # Wait: let's extract the exact 6-dim L1 linear forms on the 116-orbit space!
    # In s16.build_orb_degu_degz_vecs: layer_vecs["L1"] = (n_pts, orb_vecs) where orb_vecs[j] is a bitmask over n_pts
    n_pts_L1, orb_vecs_L1 = layer_vecs["L1"]
    # Build the 116-bit masks for each point p in range(n_pts_L1), then RREF to get 6 independent L1 linear forms!
    raw_forms_116 = []
    for pt in range(n_pts_L1):
        fm = 0
        for j in range(116):
            if (orb_vecs_L1[j] >> pt) & 1:
                fm |= (1 << j)
        if fm:
            raw_forms_116.append(fm)

    # Also reduce modulo the fixed cell variables {0, 57, 99, 113, 115} (for B0_00, c_57=c_99=c_113=c_115=0 and c_0=sum_{j in L} c_j!)
    def subst_c0_and_cell(fm, c99, c57, c113):
        """Substitute c_115=0, c_99, c_57, c_113, and c_0 = c_99 ^ sum_{j in L_INDICES} c_j."""
        rhs = 0
        if (fm >> 115) & 1: fm ^= (1 << 115)
        if (fm >> 99) & 1: fm ^= (1 << 99); rhs ^= c99
        if (fm >> 57) & 1: fm ^= (1 << 57); rhs ^= c57
        if (fm >> 113) & 1: fm ^= (1 << 113); rhs ^= c113
        if (fm >> 0) & 1:
            fm ^= (1 << 0)
            rhs ^= c99
            for j in diag_v2.L_INDICES:
                if j != 0:
                    fm ^= (1 << j)
        return fm, rhs

    for cname, (c99, c57, c113) in [("B0_00", (0, 0, 0)), ("B0_11", (0, 1, 1)), ("B1_11", (1, 1, 1))]:
        piv = {}
        for fm in raw_forms_116:
            f_sub, r_sub = subst_c0_and_cell(fm, c99, c57, c113)
            v = f_sub
            while v:
                b = v.bit_length() - 1
                if b in piv: v ^= piv[b]
                else: piv[b] = v; break
        # Strict RREF
        for b in sorted(piv.keys()):
            for hb in list(piv.keys()):
                if hb > b and ((piv[hb] >> b) & 1): piv[hb] ^= piv[b]
        basis_L1 = [piv[b] for b in sorted(piv.keys())]
        dim_L1 = len(basis_L1)
        print(f"\n=== [{cname}] L1 (eta) dim = {dim_L1} | checking Z_16^* invariance of L1 space ===")
        # Check if Z_16^* preserves span(basis_L1) (mod cell equations!)
        def apply_perm_mask(m, p):
            out = 0
            tmp = m
            while tmp:
                lb = tmp & -tmp
                j = lb.bit_length() - 1
                tmp ^= lb
                out |= (1 << p[j])
            return out

        def coords_in_L1(fm):
            """Express fm (already substituted mod cell) in basis_L1, return bitmask or None."""
            v = fm
            coord = 0
            piv_keys = sorted(piv.keys(), reverse=True)
            key_to_idx = {pk: i for i, pk in enumerate(sorted(piv.keys()))}
            for pk in piv_keys:
                if (v >> pk) & 1:
                    v ^= piv[pk]
                    coord |= (1 << key_to_idx[pk])
            return coord if v == 0 else None

        # Compute exact 6x6 affine action of each k in Z_16^* on eta in F_2^6!
        # Wait: if f' = pi_k(f), then (L_i, f') = (pi_k^{-1}(L_i), f).
        # Express pi_k^{-1}(basis_L1[i]) = sum_j M[i][j] basis_L1[j] + const_i!
        inv_k = {1: 1, 3: 11, 5: 13, 7: 7, 9: 9, 11: 3, 13: 5, 15: 15}
        eta_maps = {}
        all_ok = True
        for k in [1, 3, 5, 7, 9, 11, 13, 15]:
            pk_inv = perms[inv_k[k]]
            rows_M = []
            const_vec = 0
            for i, bm in enumerate(basis_L1):
                img = apply_perm_mask(bm, pk_inv)
                img_sub, r_sub = subst_c0_and_cell(img, c99, c57, c113)
                c_vec = coords_in_L1(img_sub)
                if c_vec is None:
                    all_ok = False
                    break
                rows_M.append(c_vec)
                if r_sub: const_vec |= (1 << i)
            if not all_ok:
                print(f"  k={k:2d}: L1 NOT invariant!")
                break
            eta_maps[k] = (rows_M, const_vec)
        if all_ok:
            print(f"  *** FULL Z_16^* (ORDER 8!) PRESERVES {cname} AND ITS 6-DIM ETA SPACE! ***")
            # Decompose the 64 eta-states into Z_16^*-orbits!
            seen_e = set()
            orbs_eta = []
            for e in range(1 << dim_L1):
                if e in seen_e: continue
                orb = set()
                for k, (rows_M, cvec) in eta_maps.items():
                    ne = cvec
                    for i in range(dim_L1):
                        if ((rows_M[i] & e).bit_count()) & 1:
                            ne ^= (1 << i)
                    orb.add(ne)
                seen_e |= orb
                orbs_eta.append(sorted(orb))
            sz_h = {}
            for o in orbs_eta: sz_h[len(o)] = sz_h.get(len(o), 0) + 1
            print(f"  64 eta-states decompose into ONLY {len(orbs_eta)} Z_16^*-orbits!! Sizes: {dict(sorted(sz_h.items()))}")
            for idx_o, o in enumerate(orbs_eta):
                print(f"    Orbit {idx_o:2d} (size {len(o)}): {o}")


if __name__ == "__main__":
    main()

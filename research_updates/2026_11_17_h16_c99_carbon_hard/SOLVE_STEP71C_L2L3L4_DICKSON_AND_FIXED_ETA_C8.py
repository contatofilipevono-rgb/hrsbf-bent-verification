#!/usr/bin/env python3
r"""
SOLVE_STEP71C_L2L3L4_DICKSON_AND_FIXED_ETA_C8.py
================================================
PURE-THEORETICAL FOLLOW-UP TO STEP 71A T3 & STEP 71B v3:

  PART 1 — EXACT (L2, L3, L4) LAYER DECOMPOSITION vs (W, T, R_F) & PURE-L2 DICKSON THEOREM:
    Step 71A T3 proved that in coordinates x = (v, v^y):
      g_y(v) = C_y^{(eta)}(v) + Q_y(v; L2) + L_y(v; L3) + c_y(L4)
    where C_y^{(eta)}(v) is 100% CONSTANT at fixed eta (rk=0/56)!
    Here we:
      (a) Measure exact dimensions of L2 (deg_v=2), L3 (deg_v=1), L4 (deg_v=0) and their exact
          alignment with (W, T, R_F) on B0_00, B0_11, B1_11!
      (b) Verify mathematically that L4 disappears 100% identically from ALL 35 D_8-shift
          autocorrelations Delta_f(u, u) = 0 AND ALL 36 twisted D_8 Parseval identities!
      (c) For ALL 35 C_8-orbits of u in F_2^8 \ {0}, compute exact Dickson symplectic rank
          histogram of constant matrix B_{u, y}(eta), build the exact pure-L2 indicator sum
          Delta_mag(u; L2), and test if ANY deg<=3 or deg==4 pure-L2 Dickson equation escapes
          CG(389) + XL(Q_eta) at fixed eta!

  PART 2 — FIXED-eta (N=101) DEGREE-DROP HARVEST OF ALL 64 C_8-INVARIANT 8-DIM SUBSPACES:
    Step 71B v3 proved 0 new deg<=3 eqs at root N=109, while seeing 865 deg=4 candidates.
    Here we test ALL 64 ZT-verified C_8-subspace specs directly at fixed eta (N=101) against
    the FULL degree<=3 ideal CG(389) + XL(Q_eta) using P_scr=3,072 points (zero saturation:
    dim(CG + XL) <= 2,100 < 3,072!), extracting exact ANF & testing IR6 cascade on any drop!

  PART 3 — EXACT Z_16^* AUTOMORPHISM STABILIZER GROUP G_eta & MODULE DECOMPOSITION:
    Computes the exact subgroup G_eta <= Z_16^* = {1,3,5,7,9,11,13,15} stabilizing each eta orbit
    (and tests whether G_eta-invariant solutions exist as a quick structural diagnostic).
"""

import argparse
import ctypes
import sys
import time
from pathlib import Path
import numpy as np

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP60C_DEG4_V13_WALSH_XL as s60c
import SOLVE_STEP61A_EXTENDED_OPT_AND_ALGEBRAIC_CEILING as s61a
import SOLVE_STEP63A_EXACT_AUTOCORR_PARSEVAL_MOD32_64 as s63a
import SOLVE_STEP71A_THEORETICAL_FRONTIERS as s71a
import SOLVE_STEP71B_C8_SUBSPACES_EXACT_ANF_AND_CASCADE as s71b


def anf_8bit(vals):
    A = vals.copy()
    for b in range(8):
        step = 1 << b
        A = A.reshape(-1, 256 // (2 * step), 2, step)
        A[:, :, 1, :] ^= A[:, :, 0, :]
        A = A.reshape(vals.shape)
    return A


def eval_sr_cg_on_batch(env, sr, active_vars, C_mat):
    """Evaluate all quad + cubic rows of sr on C_mat [B, N_act] via lib9.eval_row_s9."""
    lib9 = env["lib9"]
    tbl = env["tbl"]
    lin_pivs = sr["_lin_pivs"]
    eq_ids = list(sr["_quad_ids"]) + list(sr["_cub_ids"])
    n_cw = tbl["n_col_words"]
    mask64 = (1 << 64) - 1
    B = C_mat.shape[0]
    out = np.zeros((B, len(eq_ids)), dtype=np.uint8)
    for bi in range(B):
        x = 0
        for k, v in enumerate(active_vars):
            if C_mat[bi, k]:
                x |= (1 << v)
        for p, (pv, pr) in lin_pivs.items():
            if (((pv ^ (1 << p)) & x).bit_count() ^ pr) & 1:
                x |= (1 << p)
        v_lo, v_hi = x & mask64, x >> 64
        for ei, rid in enumerate(eq_ids):
            rptr = ctypes.cast(ctypes.byref(sr["_buf"], rid * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            out[bi, ei] = lib9.eval_row_s9(
                rptr, n_cw, tbl["off0"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], v_lo, v_hi
            )
    return out


# ==============================================================================
# PART 1: Exact (L2, L3, L4) vs (W, T, R_F) Alignment + Pure-L2 Dickson Audit
# ==============================================================================

def run_part1_l2l3l4_and_dickson(cell_name, env, em):
    print(f"\n==================== [PART 1: {cell_name} eta={em}] (L2, L3, L4) vs (W, T, R_F) + DICKSON ====================", flush=True)
    lib9, lib_sh = env["lib9"], env["lib_sh"]
    tbl, root, eta_free = env["tbl"], env["root"], env["eta_free"]
    blk = s61a.extract_full_blocks_fast(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=7180 + em)
    if blk["closed_unsat"]:
        print(f"  [{cell_name} eta={em}] CLOSED UNSAT AT ETA!", flush=True)
        return None

    sr = blk["sr"]
    W_rref, T_rref = blk["W_rref"], blk["T_rref"]
    W_pivs, T_pivs, RF_vars = blk["W_pivs"], blk["T_pivs"], blk["RF_vars"]
    nW, nT, nRF = blk["nW"], blk["nT"], blk["nRF"]
    act_eta = sorted(i for i in range(111) if i not in sr["_lin_pivs"])
    N_eta = len(act_eta)

    orig_eta, basis_eta, _, _ = s60c.build_affine_tt_basis(
        env["o_tt_111"], env["b_tt_111"], sr["_lin_pivs"], act_eta
    )

    # Build Jacobian from sheared (W, T, R_F) to act_eta [N_eta]
    lin_pivs = sr["_lin_pivs"]
    def sheared_to_eta_vec(w_vec, t_vec, rf_vec):
        bits = {}
        for i, v in enumerate(RF_vars): bits[v] = int(rf_vec[i])
        for i, v in enumerate(T_pivs):
            val = int(t_vec[i])
            rest = T_rref[v] ^ (1 << v)
            while rest:
                lb = rest & -rest; val ^= bits[lb.bit_length() - 1]; rest ^= lb
            bits[v] = val
        for i, v in enumerate(W_pivs):
            val = int(w_vec[i])
            rest = W_rref[v] ^ (1 << v)
            while rest:
                lb = rest & -rest; val ^= bits[lb.bit_length() - 1]; rest ^= lb
            bits[v] = val
        return np.array([bits[v] for v in act_eta], dtype=np.uint8)

    J_W = np.zeros((nW, N_eta), dtype=np.uint8)
    J_T = np.zeros((nT, N_eta), dtype=np.uint8)
    J_RF = np.zeros((nRF, N_eta), dtype=np.uint8)
    for i in range(nW):
        z = np.zeros(nW, dtype=np.uint8); z[i] = 1
        J_W[i] = sheared_to_eta_vec(z, np.zeros(nT, dtype=np.uint8), np.zeros(nRF, dtype=np.uint8))
    for i in range(nT):
        z = np.zeros(nT, dtype=np.uint8); z[i] = 1
        J_T[i] = sheared_to_eta_vec(np.zeros(nW, dtype=np.uint8), z, np.zeros(nRF, dtype=np.uint8))
    for i in range(nRF):
        z = np.zeros(nRF, dtype=np.uint8); z[i] = 1
        J_RF[i] = sheared_to_eta_vec(np.zeros(nW, dtype=np.uint8), np.zeros(nT, dtype=np.uint8), z)

    # Transform basis_eta into sheared truth-table basis: B_W [nW, 65536], B_T [nT, 65536], B_RF [nRF, 65536]
    B_W = ((J_W.astype(np.uint32) @ basis_eta.astype(np.uint32)) & 1).astype(np.uint8)
    B_T = ((J_T.astype(np.uint32) @ basis_eta.astype(np.uint32)) & 1).astype(np.uint8)
    B_RF = ((J_RF.astype(np.uint32) @ basis_eta.astype(np.uint32)) & 1).astype(np.uint8)
    B_all = np.vstack([B_W, B_T, B_RF])  # [N_eta, 65536]

    # Classify ALL 256 cosets' ANF coefficients into:
    #   L2 (deg_v == 2, 28 mons/coset), L3 (deg_v == 1, 8 mons/coset), L4 (deg_v == 0, 1 mon/coset)!
    # Use 36 C_8-orbit reps of y (since f is C_8-invariant on y, ALL forms are spanned by the 36 reps' C_8 shifts;
    # to be 100% exact, scan ALL 256 cosets y -> 256 * 256 = 65536 total!).
    v_arr = np.arange(256, dtype=np.int32)
    pop8 = np.array([int(m).bit_count() for m in range(256)], dtype=np.int32)
    idx_d3 = np.flatnonzero(pop8 == 3)
    idx_d2 = np.flatnonzero(pop8 == 2)
    idx_d1 = np.flatnonzero(pop8 == 1)
    idx_d0 = np.array([0], dtype=np.int32)

    # Reshape B_all into [N_eta, 256_y, 256_v] where pt = v | ((v ^ y) << 8)!
    idx_grid = (v_arr[None, :] | ((v_arr[None, :] ^ np.arange(256, dtype=np.int32)[:, None]) << 8))  # [256_y, 256_v]
    orig_grid = orig_eta[idx_grid]                   # [256_y, 256_v]
    orig_anf = anf_8bit(orig_grid)                   # [256_y, 256_v]
    B_anf = anf_8bit(B_all[:, idx_grid])             # [N_eta, 256_y, 256_v]

    # Verify deg_v >= 3 has ZERO dependence on ALL N_eta vars!
    assert not np.any(B_anf[:, :, idx_d3]), "Expected Phi_0 (deg_v=3) constant at fixed eta!"

    # Extract linear-form matrices (columns = linear forms in [W | T | R_F] of length N_eta):
    def layer_ranks(idx_d, lname):
        M = B_anf[:, :, idx_d].reshape(N_eta, -1)  # [N_eta, 256 * |idx_d|]
        rk_tot = s71a.gf2_rank_np(M)
        rk_W = s71a.gf2_rank_np(M[:nW])
        rk_T = s71a.gf2_rank_np(M[nW : nW + nT])
        rk_RF = s71a.gf2_rank_np(M[nW + nT :])
        rk_TRF = s71a.gf2_rank_np(M[nW:])
        rk_WT = s71a.gf2_rank_np(M[: nW + nT])
        print(
            f"  [LAYER {lname}] tot_rk={rk_tot:3d} | rk_W={rk_W:2d}, rk_T={rk_T:2d}, rk_RF={rk_RF:2d} | "
            f"rk_(T+RF)={rk_TRF:2d} (pure_W={rk_tot - rk_TRF:2d}) | rk_(W+T)={rk_WT:2d} (pure_RF={rk_tot - rk_WT:2d})",
            flush=True,
        )
        return M, rk_tot

    M_L2, rk_L2 = layer_ranks(idx_d2, "L2 (deg_v=2, Q_y)")
    M_L3, rk_L3 = layer_ranks(idx_d1, "L3 (deg_v=1, L_y)")
    M_L4, rk_L4 = layer_ranks(idx_d0, "L4 (deg_v=0, c_y)")

    # Check joint ranks: rk(L2+L3), rk(L2+L3+L4), and dim(L4 \ (L2+L3))!
    rk_L23 = s71a.gf2_rank_np(np.hstack([M_L2, M_L3]))
    rk_L234 = s71a.gf2_rank_np(np.hstack([M_L2, M_L3, M_L4]))
    print(
        f"  *** [LAYER DIMENSIONS {cell_name} eta={em}] ***: "
        f"dim(L2)={rk_L2}, dim(L2+L3)={rk_L23} (+{rk_L23 - rk_L2} in L3\\L2), "
        f"dim(L2+L3+L4)={rk_L234}/{N_eta} (+{rk_L234 - rk_L23} in L4\\(L2+L3))!",
        flush=True,
    )

    # Check Dickson symplectic rank histograms across ALL 35 non-zero C_8-orbits of u in F_2^8!
    c8_orbs = s71b.build_c8_orbits_with_step(1)
    u_reps = [o[0] for o in c8_orbs if o[0] != 0]
    assert len(u_reps) == 35
    # Compute B_{u, y}(eta) directly from orig_grid (since deg_v=3 is 100% constant!)
    low_rank_shifts = []
    for u in u_reps:
        rk_h = {}
        for y in range(256):
            du_g = orig_grid[y] ^ orig_grid[y, v_arr ^ u]
            a = anf_8bit(du_g)
            B = np.zeros((8, 8), dtype=np.uint8)
            for i in range(8):
                for j in range(i + 1, 8):
                    if a[(1 << i) | (1 << j)]:
                        B[i, j] = 1
                        B[j, i] = 1
            r = s71a.gf2_rank_np(B)
            rk_h[r] = rk_h.get(r, 0) + 1
        max_r = max(rk_h.keys())
        if max_r <= 4 or u in (0x01, 0x03, 0x11, 0x55, 0xFF):
            low_rank_shifts.append((u, max_r, dict(sorted(rk_h.items()))))
    print(f"  [DICKSON CONSTANT-B_{{u,y}}(eta) SHIFTS (max_r<=4 or key u)]:", flush=True)
    for u, mr, rh in low_rank_shifts:
        print(f"      u=0x{u:02x}: max_rank={mr} | rank_hist={rh}", flush=True)

    return {"sr": sr, "act_eta": act_eta, "orig_eta": orig_eta, "basis_eta": basis_eta, "blk": blk}


# ==============================================================================
# PART 2: Fixed-eta (N=101) Degree-Drop Harvest of ALL 64 C_8-Invariant Subspaces
# ==============================================================================

def run_part2_fixed_eta_c8(cell_name, env, em, eta_data, specs, lib71b):
    print(f"\n==================== [PART 2: {cell_name} eta={em}] ALL 64 C_8 SUBSPACES AT FIXED-eta (N=101) ====================", flush=True)
    sr = eta_data["sr"]
    act_eta = eta_data["act_eta"]
    orig_eta = eta_data["orig_eta"]
    basis_eta = eta_data["basis_eta"]
    N = len(act_eta)
    tbl = env["tbl"]
    lib9 = env["lib9"]
    n_cw = tbl["n_col_words"]

    # P_scr = 3072 points -> ZERO saturation (dim(CG + XL(17 quads)) <= 17*101 + 370 = 2087 < 3072!)
    P_scr = 3072
    rng = np.random.default_rng(71900 + em)
    C_scr = rng.integers(0, 2, size=(P_scr, N), dtype=np.uint8)
    bits5 = np.array([[(m >> b) & 1 for b in range(5)] for m in range(32)], dtype=np.uint8)
    n_cubes = 10
    C_cubes = np.zeros((n_cubes * 32, N), dtype=np.uint8)
    for ti in range(n_cubes):
        bc = rng.integers(0, 2, size=(1, N), dtype=np.uint8)
        dr = rng.integers(0, 2, size=(5, N), dtype=np.uint8)
        C_cubes[ti * 32 : (ti + 1) * 32] = (bc ^ ((bits5 @ dr) & 1)).astype(np.uint8)

    C_all = np.vstack([C_scr, C_cubes])
    P_all = C_all.shape[0]
    pts_lo = np.zeros(P_all, dtype=np.uint64)
    pts_hi = np.zeros(P_all, dtype=np.uint64)
    for k in range(N):
        col = C_all[:, k].astype(np.uint64)
        if k < 64: pts_lo |= (col << np.uint64(k))
        else: pts_hi |= (col << np.uint64(k - 64))

    cg_scr = eval_sr_cg_on_batch(env, sr, act_eta, C_scr)
    n_q = len(sr["_quad_ids"])

    def vec_to_int(col_u8):
        v = 0
        for i in np.flatnonzero(col_u8):
            v |= (1 << int(i))
        return v

    piv_scr = {}
    def insert_piv(col_u8):
        v = vec_to_int(col_u8)
        while v:
            lb = v & -v
            if lb in piv_scr:
                v ^= piv_scr[lb]
            else:
                piv_scr[lb] = v
                return True
        return False

    for j in range(cg_scr.shape[1]):
        insert_piv(cg_scr[:, j])
    rk_raw = len(piv_scr)
    for a in range(n_q):
        qa = cg_scr[:, a]
        for k in range(N):
            insert_piv(qa & C_scr[:, k])
    rk_xl = len(piv_scr)
    print(f"  [{cell_name} eta={em} N={N}] Baseline CG {P_scr}-pt rank: raw={rk_raw} | +XL({n_q} quads)={rk_xl}", flush=True)

    # Also build independent 256-pt ZT verification set
    C_zt = rng.integers(0, 2, size=(256, N), dtype=np.uint8)
    zt_lo = np.zeros(256, dtype=np.uint64)
    zt_hi = np.zeros(256, dtype=np.uint64)
    for k in range(N):
        col = C_zt[:, k].astype(np.uint64)
        if k < 64: zt_lo |= (col << np.uint64(k))
        else: zt_hi |= (col << np.uint64(k - 64))

    n1 = N
    n2 = N * (N - 1) // 2
    n3 = N * (N - 1) * (N - 2) // 6
    n_mon = 1 + n1 + n2 + n3
    n_mon_words = (n_mon + 63) // 64
    mon_orig_mask = np.zeros(n_mon, dtype=object)
    mon_orig_mask[0] = 0
    mon_tuples = [()]
    idx_m = 1
    for i in range(N):
        mon_orig_mask[idx_m] = (1 << act_eta[i]); mon_tuples.append((i,)); idx_m += 1
    for i in range(N):
        mi = 1 << act_eta[i]
        for j in range(i + 1, N):
            mon_orig_mask[idx_m] = mi | (1 << act_eta[j]); mon_tuples.append((i, j)); idx_m += 1
    for i in range(N):
        mi = 1 << act_eta[i]
        for j in range(i + 1, N):
            mij = mi | (1 << act_eta[j])
            for k in range(j + 1, N):
                mon_orig_mask[idx_m] = mij | (1 << act_eta[k]); mon_tuples.append((i, j, k)); idx_m += 1

    extracted = []
    deg4_tot = 0
    for sp in specs:
        sname = sp["name"]
        M_cos = sp["M_cos"]
        b0_pk, bs_pk = s71b.pack_subspace_tt_bits(orig_eta, basis_eta, sp["coset_pts"])
        S_all = np.zeros((P_all, M_cos), dtype=np.int32)
        lib71b.eval_subspace_S_batch_c(
            N, M_cos, P_all,
            b0_pk.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            bs_pk.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            sp["twist_mask"].ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            pts_lo.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            pts_hi.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            S_all.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
        )
        S_scr = S_all[:P_scr].astype(np.int64)
        S_cub = S_all[P_scr:].astype(np.int64)
        orb_sz = sp["orb_sz"].astype(np.int64)

        cands = []
        for k, mod_t, c0, u_vec in sp["syz_list"]:
            res = (S_scr @ u_vec.astype(np.int64)) - c0
            nz = res[res != 0]
            if len(nz) == 0: continue
            vm = min((int(x) & -int(x)).bit_length() - 1 for x in nz)
            if vm < k + 1:
                cands.append((0, vm, c0, u_vec))
        pars = np.sum((S_scr * S_scr) * orb_sz[None, :], axis=1) - 65536
        nz_p = pars[pars != 0]
        if len(nz_p) > 0:
            vp = min((int(x) & -int(x)).bit_length() - 1 for x in nz_p)
            cands.append((1, vp, 0, np.zeros(M_cos, dtype=np.int32)))
        if not cands:
            continue

        nC = len(cands)
        F_scr = np.zeros((P_scr, nC), dtype=np.uint8)
        F_cub = np.zeros((n_cubes * 32, nC), dtype=np.uint8)
        pars_cub = np.sum((S_cub * S_cub) * orb_sz[None, :], axis=1) - 65536
        for ci, (is_p, vm, c0, u_vec) in enumerate(cands):
            if is_p:
                F_scr[:, ci] = ((pars >> vm) & 1).astype(np.uint8)
                F_cub[:, ci] = ((pars_cub >> vm) & 1).astype(np.uint8)
            else:
                F_scr[:, ci] = (((S_scr @ u_vec.astype(np.int64)) - c0) >> vm) & 1
                F_cub[:, ci] = (((S_cub @ u_vec.astype(np.int64)) - c0) >> vm) & 1

        max_deg = np.full(nC, -1, dtype=np.int32)
        for ci in range(nC):
            if np.any(F_scr[:, ci]):
                max_deg[ci] = 0
                if np.any(F_scr[:, ci] != F_scr[0, ci]):
                    max_deg[ci] = 1
        for ti in range(n_cubes):
            M = F_cub[ti * 32 : (ti + 1) * 32].copy()
            for b in range(5):
                step = 1 << b
                for m in range(0, 32, 2 * step):
                    M[m + step : m + 2 * step] ^= M[m : m + step]
            for m in range(1, 32):
                d = int(m).bit_count()
                nz = np.flatnonzero(M[m])
                if len(nz): max_deg[nz] = np.maximum(max_deg[nz], d)

        sel = []
        for ci in range(nC):
            d = int(max_deg[ci])
            if d == 4:
                deg4_tot += 1
                continue
            if d > 3 or d < 0:
                continue
            if insert_piv(F_scr[:, ci]):
                sel.append((ci, d))
        if not sel:
            continue

        K_sel = len(sel)
        syz_u_arr = np.zeros((K_sel, M_cos), dtype=np.int32)
        syz_c0_arr = np.zeros(K_sel, dtype=np.int32)
        syz_sh_arr = np.zeros(K_sel, dtype=np.int32)
        is_p_arr = np.zeros(K_sel, dtype=np.uint8)
        for ki, (ci, _) in enumerate(sel):
            is_p, vm, c0, u_vec = cands[ci]
            is_p_arr[ki] = is_p; syz_sh_arr[ki] = vm; syz_c0_arr[ki] = c0; syz_u_arr[ki] = u_vec

        out_anf = np.zeros((K_sel, n_mon_words), dtype=np.uint64)
        lib71b.extract_subspace_deg3_anf_c(
            N, M_cos, K_sel,
            b0_pk.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            bs_pk.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            sp["twist_mask"].ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            syz_u_arr.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
            syz_c0_arr.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
            syz_sh_arr.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
            is_p_arr.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            sp["orb_sz"].ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
            out_anf.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        )
        S_zt = np.zeros((256, M_cos), dtype=np.int32)
        lib71b.eval_subspace_S_batch_c(
            N, M_cos, 256,
            b0_pk.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            bs_pk.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            sp["twist_mask"].ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            zt_lo.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            zt_hi.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            S_zt.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
        )
        S_zt64 = S_zt.astype(np.int64)
        pars_zt = np.sum((S_zt64 * S_zt64) * orb_sz[None, :], axis=1) - 65536
        anf_bits = np.unpackbits(out_anf.view(np.uint8), axis=1, bitorder="little")[:, :n_mon]
        for ki, (ci, d_est) in enumerate(sel):
            nz_cols = np.flatnonzero(anf_bits[ki])
            pred = np.zeros(256, dtype=np.uint8)
            for mc in nz_cols:
                tup = mon_tuples[int(mc)]
                if len(tup) == 0: pred ^= 1
                elif len(tup) == 1: pred ^= C_zt[:, tup[0]]
                elif len(tup) == 2: pred ^= (C_zt[:, tup[0]] & C_zt[:, tup[1]])
                else: pred ^= (C_zt[:, tup[0]] & C_zt[:, tup[1]] & C_zt[:, tup[2]])
            is_p, vm, c0, u_vec = cands[ci]
            true_v = ((pars_zt >> vm) & 1).astype(np.uint8) if is_p else ((((S_zt64 @ u_vec.astype(np.int64)) - c0) >> vm) & 1).astype(np.uint8)
            mis = int(np.sum(pred != true_v))
            assert mis == 0, f"ZT FAIL at fixed-eta in {sname} cand #{ci}: {mis}/256!"
            pset = set(int(mon_orig_mask[int(mc)]) for mc in nz_cols)
            true_deg = max((m.bit_count() for m in pset), default=0)
            extracted.append((f"{sname}#{'P' if is_p else ci}", true_deg, pset))
        print(f"  *** [{cell_name} eta={em} | {sname}] ***: +{K_sel} NEW deg<=3 eqs OUTSIDE CG+XL (ZT 256-pt OK) | total_new={len(extracted)}", flush=True)

    print(f"  *** [PART 2 SUMMARY {cell_name} eta={em}] ***: TOTAL NEW deg<=3 OUTSIDE CG+XL = {len(extracted)} (deg=4 cands={deg4_tot})", flush=True)
    if extracted:
        n_tot_old = len(sr["_buf"]) // n_cw
        n_add = len(extracted)
        new_buf = (ctypes.c_uint64 * ((n_tot_old + n_add) * n_cw))()
        ctypes.memmove(new_buf, sr["_buf"], n_tot_old * n_cw * 8)
        new_qids = list(sr["_quad_ids"])
        new_cids = list(sr["_cub_ids"])
        for idx_a, (tag, deg, ps) in enumerate(extracted):
            rid = n_tot_old + idx_a
            s9.pset_to_row(ps, new_buf, rid, tbl)
            if deg <= 2: new_qids.append(rid)
            else: new_cids.append(rid)
        sr_new = s9.run_branch_cascade(
            lib9, new_buf, new_qids, new_cids, sr["_lin_pivs"],
            [], tbl, max_xl_rounds=30, verify_subst=True,
        )
        print(
            f"  *** [PART 2 IR6 INJECTION {cell_name} eta={em}] ***:\n"
            f"      OLD: N={N}, q={len(sr['_quad_ids'])}, c={len(sr['_cub_ids'])}\n"
            f"      NEW: closed={sr_new['closed_unsat']} ({sr_new.get('closed_by')}), "
            f"N={sr_new.get('N_active')}, q={len(sr_new.get('_quad_ids', []))}, c={len(sr_new.get('_cub_ids', []))}",
            flush=True,
        )


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--cell", required=True, choices=["B0_00", "B0_11", "B1_11"])
    args = ap.parse_args()
    t0 = time.perf_counter()

    real_bents = s71a.build_real_c16_bents()
    lib71b = s71b.compile_step71b_c()
    specs = s71b.build_all_c8_subspace_specs(real_bents)
    env = s63a.setup_cell_env(args.cell)

    etas = [5] if args.cell == "B0_00" else ([5, 0] if args.cell == "B0_11" else [3, 0])
    for em in etas:
        eta_data = run_part1_l2l3l4_and_dickson(args.cell, env, em)
        if eta_data is not None:
            run_part2_fixed_eta_c8(args.cell, env, em, eta_data, specs, lib71b)

    print(f"\n[STEP 71C {args.cell}] COMPLETED in {time.perf_counter()-t0:.1f}s!", flush=True)


if __name__ == "__main__":
    main()

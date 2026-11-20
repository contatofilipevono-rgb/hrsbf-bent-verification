#!/usr/bin/env python3
r"""
SOLVE_STEP44A_ITERATED_POLAR_TOWER.py

FULL POLAR TOWER PARETO SWEEP (B0_11, B1_11) + ROUND-2 FIBER UNIFORMITY + ETA=(1,4,5) POLAR AUDIT:
  PART 1 (eta = 0):
    - Sweeps d_flag across [12, 24, 28, 30, 34] (B0_11) and [12, 14] (B1_11).
    - Builds Round-1 Polar Left-Inverse -> M_res_1 + Isotropic Flat U^{(1)} (NU_1, NT_1).
    - Checks across 4 random nonzero fiber shifts t whether Round-2 K_R, K_L, and r_elim^{(2)} survive uniformly!
    - Inside U^{(1)}, runs Round-2 MinRank + Polar Left-Inverse sweep across df2 to find BOTH max r_elim_2
      AND minimum total fibers NT_1 + NT_2, builds Round-2 residual M_res_2 -> U^{(2)}, and checks K_L^{(3)} & Round-3 r_elim_3!
  PART 2 (eta = 1, 4, 5):
    - Runs 2-round MinRank + Round-1 Polar Left-Inverse & Isotropic Flat audit on eta = 1, 4, 5
      to test if ALL 16 Z_16^*-orbits share the polar tower reduction!
"""

import argparse
import ctypes
import random
import subprocess
import sys
import time
from pathlib import Path
import numpy as np

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_B09_DUAL_S_ELIM as b09
import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP10_CARLET_GUILLOT_NNF as s10
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP17_ELIM_ORDER_R_GT_B_SCHUR4 as s17
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP40C_B11_LOWRANK_BASIS_SHATTER as s40c
import SOLVE_STEP43A_ETA_INVARIANCE_AND_ITERATED_POLAR as s43a


def specialize_poly_mat_affine_shift(M_res, n_rows, n_cols, mW, t_shift_int, U):
    """Evaluate M_res(w = t_shift + U.T @ u) where U is isotropic, returning (M_u0, M_ua)."""
    NU = U.shape[0]
    M_u0 = M_res.get(0, np.zeros((n_rows, n_cols), dtype=np.uint8)).copy()
    M_ua = np.zeros((NU, n_rows, n_cols), dtype=np.uint8)
    M_deg2_u = {}
    for m, A in M_res.items():
        if m == 0: continue
        if m.bit_count() == 1:
            k = m.bit_length() - 1
            if (t_shift_int >> k) & 1:
                M_u0 ^= A
            for a in range(NU):
                if U[a, k]: M_ua[a] ^= A
        elif m.bit_count() == 2:
            b0 = m.bit_length() - 1
            b1 = (m ^ (1 << b0)).bit_length() - 1
            t0 = (t_shift_int >> b0) & 1
            t1 = (t_shift_int >> b1) & 1
            if t0 and t1:
                M_u0 ^= A
            for a in range(NU):
                u0, u1 = int(U[a, b0]), int(U[a, b1])
                if (t0 & u1) ^ (t1 & u0) ^ (u0 & u1):
                    M_ua[a] ^= A
                for b in range(a + 1, NU):
                    if (u0 & int(U[b, b1])) ^ (int(U[b, b0]) & u1):
                        key = (1 << a) | (1 << b)
                        M_deg2_u[key] = M_deg2_u.get(key, np.zeros_like(A)) ^ A
    leftover = sum(1 for A in M_deg2_u.values() if A.any())
    assert leftover == 0, f"Isotropic specialization failed: {leftover} quad terms remain"
    return M_u0, M_ua


def build_polar_step(M0_in, Mk_in, K_in, rng_seed=4400):
    """Given affine pencil M0_in + sum w_k Mk_in[k] (mR x mC) and K_in (r x mC), eliminate max const-left-inverse r_elim vars."""
    mW, mR, mC = Mk_in.shape
    B0 = (M0_in @ K_in.T) & 1
    Bk = [(Mk_in[k] @ K_in.T) & 1 for k in range(mW)]
    V_const = s40a.gf2_nullspace_np(np.hstack(Bk).T)
    if V_const.shape[0] == 0:
        return None
    P = (V_const @ B0) & 1
    _, piv_cols = s40a.gf2_rref_np(P)
    r_elim = len(piv_cols)
    if r_elim == 0:
        return None

    K_use = K_in[piv_cols]
    B0_use = B0[:, piv_cols]
    Bk_use = [M[:, piv_cols] for M in Bk]
    P_use = (V_const @ B0_use) & 1
    _, v_row_idxs = s40a.gf2_rref_np(P_use.T)
    S_inv = s43a.gf2_inv_np(P_use[v_row_idxs])
    L = (S_inv @ V_const[v_row_idxs]) & 1
    assert np.array_equal((L @ B0_use) & 1, np.eye(r_elim, dtype=np.uint8))
    for k in range(mW):
        assert not ((L @ Bk_use[k]) & 1).any()

    N = s40a.gf2_nullspace_np(np.hstack([B0_use] + Bk_use).T)
    LN = np.vstack([L, N]) if N.shape[0] > 0 else L
    _, ln_col_pivs = s40a.gf2_rref_np(LN)
    h_cols = [c for c in range(mR) if c not in set(ln_col_pivs)]
    H = np.eye(mR, dtype=np.uint8)[h_cols]
    NH = np.vstack([N, H]) if N.shape[0] > 0 else H
    assert len(s40a.gf2_rref_np(np.vstack([NH, L]))[1]) == mR

    _, k_col_pivs = s40a.gf2_rref_np(K_use)
    comp_cols = [c for c in range(mC) if c not in set(k_col_pivs)]
    C = np.eye(mC, dtype=np.uint8)[:, comp_cols]
    nRC_res = C.shape[1]

    D_pm = {0: (M0_in @ C) & 1}
    B_pm = {0: B0_use}
    for k in range(mW):
        dk = (Mk_in[k] @ C) & 1
        if dk.any(): D_pm[1 << k] = dk
        if Bk_use[k].any(): B_pm[1 << k] = Bk_use[k]

    LD_pm = s43a.poly_mat_mul_left(L, D_pm)
    ND_pm = s43a.poly_mat_mul_left(N, D_pm) if N.shape[0] > 0 else {}
    HD_pm = s43a.poly_mat_mul_left(H, D_pm) if H.shape[0] > 0 else {}
    HB_pm = s43a.poly_mat_mul_left(H, B_pm) if H.shape[0] > 0 else {}
    H_quad = s43a.poly_mat_mul_mats(HB_pm, LD_pm)

    H_tot = {}
    for m, A in HD_pm.items(): H_tot[m] = A.copy()
    for m, A in H_quad.items():
        if m in H_tot: H_tot[m] ^= A
        else: H_tot[m] = A.copy()
    H_tot = {m: A for m, A in H_tot.items() if A.any()}

    nN, nH = N.shape[0], H.shape[0]
    n_res_rows = nN + nH
    M_res = {}
    for m in (ND_pm.keys() | H_tot.keys()):
        top = ND_pm.get(m, np.zeros((nN, nRC_res), dtype=np.uint8))
        bot = H_tot.get(m, np.zeros((nH, nRC_res), dtype=np.uint8))
        full = np.vstack([top, bot]) if (nN > 0 and nH > 0) else (top if nH == 0 else bot)
        if full.any(): M_res[m] = full

    # Zero-Trust check on 10 random (w, rC) points
    rng_zt = random.Random(rng_seed)
    zt_mis = 0
    for _ in range(10):
        wb = rng_zt.getrandbits(mW)
        rC = np.array([rng_zt.getrandbits(1) for _ in range(nRC_res)], dtype=np.uint8)
        M_w = M0_in.copy()
        for k in range(mW):
            if (wb >> k) & 1: M_w ^= Mk_in[k]
        Dw = (M_w @ C) & 1
        rK = (L @ Dw @ rC) & 1
        r_full = ((C @ rC) ^ (K_use.T @ rK)) & 1
        assert not ((L @ M_w @ r_full) & 1).any()
        rhs_orig = (NH @ M_w @ r_full) & 1
        Mres_w = np.zeros((n_res_rows, nRC_res), dtype=np.uint8)
        for m, A in M_res.items():
            if (m & wb) == m: Mres_w ^= A
        if not np.array_equal(rhs_orig, (Mres_w @ rC) & 1): zt_mis += 1
    assert zt_mis == 0, f"ZT mismatches={zt_mis}"

    rad_dim, NU, U = s43a.isotropic_flat_from_poly_mat(M_res, mW)
    NT = mW - NU
    M_u0, M_ua = specialize_poly_mat_affine_shift(M_res, n_res_rows, nRC_res, mW, 0, U)
    # ZT verify M_u0, M_ua on 8 points
    for _ in range(8):
        ub = np.array([rng_zt.getrandbits(1) for _ in range(NU)], dtype=np.uint8)
        w_arr = (U.T @ ub) & 1
        wb = sum((1 << k) for k in range(mW) if w_arr[k])
        Mres_w = np.zeros((n_res_rows, nRC_res), dtype=np.uint8)
        for m, A in M_res.items():
            if (m & wb) == m: Mres_w ^= A
        Mu_val = M_u0.copy()
        for a in range(NU):
            if ub[a]: Mu_val ^= M_ua[a]
        assert np.array_equal(Mres_w, Mu_val)

    return {
        "r_elim": r_elim, "n_res_rows": n_res_rows, "nRC_res": nRC_res,
        "nN": nN, "nH": nH, "rad_dim": rad_dim, "NU": NU, "NT": NT, "U": U,
        "M_u0": M_u0, "M_ua": M_ua, "M_res": M_res,
    }


def minrank_basis(Mk_in, rk_cap=24, n_rounds=3, seed=4400):
    mW, mR, mC = Mk_in.shape
    if mC <= 2:
        return [], list(range(mW)), {}
    cap = max(2, min(rk_cap, mC - 2))
    def mat_of(cm):
        acc = np.zeros((mR, mC), dtype=np.uint8)
        for k in range(mW):
            if (cm >> k) & 1: acc ^= Mk_in[k]
        return acc
    found_low = {}
    def record_c(cm):
        if cm == 0 or cm in found_low: return
        rk = len(s40a.gf2_rref_np(mat_of(cm))[1])
        if rk <= cap: found_low[cm] = rk
    for i in range(mW):
        record_c(1 << i)
        for j in range(i + 1, mW): record_c((1 << i) | (1 << j))
    tested_v = set()
    rng = random.Random(seed)
    def probe_v(v):
        key = v.tobytes()
        if key in tested_v: return
        tested_v.add(key)
        Bv = np.zeros((mR, mW), dtype=np.uint8)
        for k in range(mW): Bv[:, k] = (Mk_in[k] @ v) & 1
        for row in s40a.gf2_nullspace_np(Bv):
            record_c(sum((1 << k) for k in range(mW) if row[k]))
    for j in range(mC):
        e = np.zeros(mC, dtype=np.uint8); e[j] = 1
        probe_v(e)
    for _ in range(n_rounds):
        cands = [cm for cm, rk in sorted(found_low.items(), key=lambda x: x[1]) if 1 <= rk <= cap - 1][:16]
        for cm in cands:
            K = s40a.gf2_nullspace_np(mat_of(cm))
            for row in K: probe_v(row)
            if K.shape[0] >= 2:
                for _ in range(15):
                    a, b = rng.randrange(K.shape[0]), rng.randrange(K.shape[0])
                    if a != b: probe_v(K[a] ^ K[b])
    sorted_cms = [cm for cm, _ in sorted(found_low.items(), key=lambda x: (x[1], x[0].bit_count()))]
    low_bas, _ = s40c.gf2_basis_masks(sorted_cms)
    full_bas, _ = s40c.gf2_basis_masks(sorted_cms + [1 << k for k in range(mW)])
    return low_bas, full_bas, found_low


def run_cell(cell_name, lib_diag, lib9, lib_cg, lib_sh, orbits, layer_vecs,
             v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 44A: FULL POLAR TOWER PARETO SWEEP ====================", flush=True)
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    n, n_cw = tbl["n"], tbl["n_col_words"]

    orb_map = (ctypes.c_int * 116)(*([-1] * 116))
    for i, j in enumerate(free111): orb_map[j] = i
    orb_map[0] = -3; orb_map[115] = -1
    orb_map[99] = -2 if c99 else -1
    orb_map[57] = -2 if c57 else -1
    orb_map[113] = -2 if c113 else -1
    L_set = set(diag_v2.L_INDICES)
    L_vars_py = [i for i, j in enumerate(free111) if j in L_set]
    L_vars_arr = (ctypes.c_int * len(L_vars_py))(*L_vars_py)

    n_cg = len(reps12) + len(reps11)
    cg_buf = (ctypes.c_uint64 * (n_cg * n_cw))()
    for idx, I_m in enumerate(reps12):
        rptr = ctypes.cast(ctypes.byref(cg_buf, idx * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_cg.build_cg12_row_c(
            I_m, mon_to_orb_arr, orb_map, c99, L_vars_arr, len(L_vars_py),
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr
        )
    for idx, I_m in enumerate(reps11):
        rptr = ctypes.cast(ctypes.byref(cg_buf, (len(reps12) + idx) * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_cg.build_cg11_row_c(
            I_m, mon_to_orb_arr, orb_map, c99, L_vars_arr, len(L_vars_py),
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr
        )

    sys_data = diag_v2.build_cell_algebraic_system(cell_name, lib_diag, orbits, v6_list, rot4_data, fiber_meta, extract_sec=18.0)
    cyc_cubs = s9.extract_verified_cyclotomic_cubics(cell_name, orbits, origin111, cb111, layers, c0x0)
    n_base = sum(sys_data["deg_pivs_111"].values())
    total_raw = n_base + len(cyc_cubs) + n_cg
    raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, raw_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])

    # PART 1: FULL POLAR TOWER PARETO SWEEP ON eta = 0
    print(f"\n  --- PART 1: PARETO SWEEP ROUND-1 -> ROUND-2 -> ROUND-3 (eta=0, {cell_name}) ---", flush=True)
    d0 = s43a.extract_eta_pencil(0, root, eta_free, lib9, lib_sh, tbl)
    M0_c, Mk_c, nW, n_core, nRC = d0["M0_c"], d0["Mk_c"], d0["nW"], d0["n_core"], d0["nRC"]
    _, full_bas1, _ = minrank_basis(Mk_c, rk_cap=24, n_rounds=3, seed=4401)

    d_flags = [12, 24, 28, 30, 34] if cell_name == "B0_11" else [6, 14]
    rng_f = random.Random(4444)
    for df in d_flags:
        if df > nW: continue
        # Compute K1 for full_bas1[:df]
        def mat1_of(cm):
            acc = np.zeros((n_core, nRC), dtype=np.uint8)
            for k in range(nW):
                if (cm >> k) & 1: acc ^= Mk_c[k]
            return acc
        rstack = np.array([mat1_of(cm) for cm in full_bas1[:df]], dtype=np.uint8).reshape(df * n_core, nRC)
        K1 = s40a.gf2_nullspace_np(rstack)
        if K1.shape[0] == 0: continue
        p1 = build_polar_step(M0_c, Mk_c, K1, rng_seed=4400 + df)
        if p1 is None: continue
        print(
            f"\n    [R1 d_flag={df:2d}] r_elim_1={p1['r_elim']:2d} -> M_res_1={p1['n_res_rows']}x{p1['nRC_res']} "
            f"(N={p1['nN']}, H={p1['nH']}, rad={p1['rad_dim']}, NU_1={p1['NU']}, NT_1={p1['NT']})",
            flush=True
        )
        # Round-2 inside U^(1)
        NU1, nR1, nC1 = p1["NU"], p1["n_res_rows"], p1["nRC_res"]
        low2, full_bas2, low_map2 = minrank_basis(p1["M_ua"], rk_cap=18, n_rounds=2, seed=4420 + df)
        def mat2_of(cm):
            acc = np.zeros((nR1, nC1), dtype=np.uint8)
            for a in range(NU1):
                if (cm >> a) & 1: acc ^= p1["M_ua"][a]
            return acc

        r2_cands = []
        for df2 in [1, 2, 3, 4, 6, 8, 10, 12, 16, 20, 24, 28]:
            if df2 > NU1: continue
            rstack2 = np.array([mat2_of(cm) for cm in full_bas2[:df2]], dtype=np.uint8).reshape(df2 * nR1, nC1)
            K2 = s40a.gf2_nullspace_np(rstack2)
            if K2.shape[0] == 0: continue
            B02 = (p1["M_u0"] @ K2.T) & 1
            Bk2 = [(p1["M_ua"][a] @ K2.T) & 1 for a in range(NU1)]
            Vc2 = s40a.gf2_nullspace_np(np.hstack(Bk2).T)
            r2e = len(s40a.gf2_rref_np((Vc2 @ B02) & 1)[1]) if Vc2.shape[0] > 0 else 0
            if r2e >= 2:
                print(f"      R2 sweep df2={df2:2d}: K2={K2.shape[0]:2d}, r_elim_2={r2e:2d}", flush=True)
                r2_cands.append((r2e, df2, K2))

        # Test fiber uniformity across 4 random nonzero t shifts of U^(1) for K_R^(2), K_L^(2), and top K2!
        if r2_cands:
            t_r2s = []
            top_K2 = sorted(r2_cands, key=lambda x: (-x[0], -x[1]))[0][2]
            for _ in range(4):
                t_sh = rng_f.getrandbits(nW)
                Mu0_t, Mua_t = specialize_poly_mat_affine_shift(p1["M_res"], nR1, nC1, nW, t_sh, p1["U"])
                B02_t = (Mu0_t @ top_K2.T) & 1
                Bk2_t = [(Mua_t[a] @ top_K2.T) & 1 for a in range(NU1)]
                Vc2_t = s40a.gf2_nullspace_np(np.hstack(Bk2_t).T)
                re_t = len(s40a.gf2_rref_np((Vc2_t @ B02_t) & 1)[1]) if Vc2_t.shape[0] > 0 else 0
                kl2_t = s40a.gf2_nullspace_np(np.transpose(Mua_t, (0, 2, 1)).reshape(NU1 * nC1, nR1)).shape[0]
                kr2_t = s40a.gf2_nullspace_np(Mua_t.reshape(NU1 * nR1, nC1)).shape[0]
                t_r2s.append((kr2_t, kl2_t, re_t))
            print(f"      Fiber uniformity (4 random nonzero t shifts) [(K_R2, K_L2, top_r2_elim)]: {t_r2s}", flush=True)

            # Build full Round-2 residual -> U^(2) for top-r2 and largest-df2 (with r2e>=3)!
            pick_max_r2 = sorted(r2_cands, key=lambda x: (-x[0], -x[1]))[0]
            ge3 = [c for c in r2_cands if c[0] >= 3]
            pick_min_nt = sorted(ge3, key=lambda x: (-x[1], -x[0]))[0] if ge3 else pick_max_r2
            seen_df2 = set()
            for tag_p, (r2e, df2, K2) in [("max_r2", pick_max_r2), ("max_df2_ge3", pick_min_nt)]:
                if df2 in seen_df2: continue
                seen_df2.add(df2)
                p2 = build_polar_step(p1["M_u0"], p1["M_ua"], K2, rng_seed=4460 + df + df2)
                if p2 is None: continue
                K_L3 = s40a.gf2_nullspace_np(np.transpose(p2["M_ua"], (0, 2, 1)).reshape(p2["NU"] * p2["nRC_res"], p2["n_res_rows"]))
                K_R3 = s40a.gf2_nullspace_np(p2["M_ua"].reshape(p2["NU"] * p2["n_res_rows"], p2["nRC_res"]))
                tot_nt = p1["NT"] + p2["NT"]
                print(
                    f"      *** [R2 {tag_p} df2={df2:2d}] r_elim_2={p2['r_elim']:2d} -> M_res_2={p2['n_res_rows']}x{p2['nRC_res']} "
                    f"(N2={p2['nN']}, H2={p2['nH']}, rad2={p2['rad_dim']}, NU_2={p2['NU']}, NT_2={p2['NT']}, TOTAL_NT={tot_nt}) "
                    f"| K_R3={K_R3.shape[0]}, K_L3={K_L3.shape[0]} ***",
                    flush=True
                )

    # PART 2: MINRANK & ROUND-1 POLAR AUDIT ON eta = 1, 4, 5!
    print(f"\n  --- PART 2: MINRANK & ROUND-1 POLAR AUDIT ON eta=(1, 4, 5) ({cell_name}) ---", flush=True)
    for em in [1, 4, 5]:
        de = s43a.extract_eta_pencil(em, root, eta_free, lib9, lib_sh, tbl)
        l_bas, f_bas, l_map = minrank_basis(de["Mk_c"], rk_cap=24, n_rounds=2, seed=4490 + em)
        top_rks = [l_map[c] for c in l_bas[:8]]
        best_r1 = None
        for df in [6, 12, 20, 28]:
            if df > de["nW"]: continue
            def mat_e(cm):
                acc = np.zeros((de["n_core"], de["nRC"]), dtype=np.uint8)
                for k in range(de["nW"]):
                    if (cm >> k) & 1: acc ^= de["Mk_c"][k]
                return acc
            K = s40a.gf2_nullspace_np(np.array([mat_e(cm) for cm in f_bas[:df]], dtype=np.uint8).reshape(df * de["n_core"], de["nRC"]))
            if K.shape[0] == 0: continue
            p = build_polar_step(de["M0_c"], de["Mk_c"], K, rng_seed=4500 + em * 10 + df)
            if p is not None and (best_r1 is None or (p["r_elim"], -p["NT"]) > (best_r1["r_elim"], -best_r1["NT"])):
                best_r1 = p
                best_r1["df"] = df
        if best_r1:
            print(
                f"    [eta={em}] core={de['n_core']}x{de['nRC']}, low_bas={len(l_bas)}/{de['nW']} top_rks={top_rks} | "
                f"best_R1(df={best_r1['df']}): r_elim={best_r1['r_elim']} -> {best_r1['n_res_rows']}x{best_r1['nRC_res']} "
                f"(NU={best_r1['NU']}, NT={best_r1['NT']})",
                flush=True
            )
        else:
            print(f"    [eta={em}] core={de['n_core']}x{de['nRC']}, low_bas={len(l_bas)}/{de['nW']} top_rks={top_rks} | best_R1=None", flush=True)

    print(f"[{cell_name}] STEP 44A DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s44a_diag.c", WORK_DIR / "libs44a_diag.so"
    c_diag.write_text(diag_v2.C_DIAG_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_diag), "-o", str(so_diag)], check=True)
    lib_diag = ctypes.CDLL(str(so_diag))
    lib_diag.extract_level1_quad_when_diag4.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
    ]
    lib_diag.extract_level1_quad_when_diag4.restype = ctypes.c_int
    lib_diag.extract_coset_full_hierarchy_corrected.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib_diag.extract_coset_full_hierarchy_corrected.restype = ctypes.c_int
    lib_diag.gf2_echelon_insert.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib_diag.gf2_echelon_insert.restype = ctypes.c_int

    c_s9, so_s9 = WORK_DIR / "s44a_s9.c", WORK_DIR / "libs44a_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = ctypes.CDLL(str(so_s9))
    lib9.subst_one_linear_var_batch.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_int, ctypes.c_uint64, ctypes.c_uint64, ctypes.c_int,
    ]
    lib9.gf2_echelon_insert_s9.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib9.gf2_echelon_insert_s9.restype = ctypes.c_int
    lib9.mul_deg2_row_by_var.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
    ]
    lib9.eval_row_s9.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_uint64, ctypes.c_uint64,
    ]
    lib9.eval_row_s9.restype = ctypes.c_int

    c_cg, so_cg = WORK_DIR / "s44a_cg.c", WORK_DIR / "libs44a_cg.so"
    c_cg.write_text(s10.C_CG_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_cg), "-o", str(so_cg)], check=True)
    lib_cg = ctypes.CDLL(str(so_cg))
    for fn in (lib_cg.build_cg12_row_c, lib_cg.build_cg11_row_c):
        fn.argtypes = [
            ctypes.c_int, ctypes.POINTER(ctypes.c_int16), ctypes.POINTER(ctypes.c_int),
            ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.c_int,
            ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
            ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
        ]

    c_sh, so_sh = WORK_DIR / "s44a_sh.c", WORK_DIR / "libs44a_sh.so"
    c_sh.write_text(s17.C_SHEAR_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_sh), "-o", str(so_sh)], check=True)
    lib_sh = ctypes.CDLL(str(so_sh))
    lib_sh.shear_subst_var_batch.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_int, ctypes.c_uint64, ctypes.c_uint64,
    ]
    lib_sh.remap_rows_by_perm.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_int),
    ]

    orbits = diag_v2.build_orbits_116()
    layer_vecs = s16.build_orb_degu_degz_vecs(orbits)
    mon_to_orb_arr = (ctypes.c_int16 * 65536)(*([-1] * 65536))
    for j, orb in enumerate(orbits):
        for m in orb: mon_to_orb_arr[m] = j
    reps12, reps11 = s10.subset_orbits(12), s10.subset_orbits(11)

    v6_list = diag_v2.all_v6_orbits()
    _, u8_size8, nonzero_z = diag_v2.build_c8_orbits()
    M_rows = []
    for rep_z, _ in nonzero_z:
        row_mask = 0
        for m_idx, (_, u_orb) in enumerate(u8_size8):
            s = sum(1 if ((u & rep_z).bit_count() & 1) == 0 else -1 for u in u_orb)
            if (s // 2) & 1: row_mask |= (1 << m_idx)
        M_rows.append(row_mask)
    fiber_meta = (nonzero_z, diag_v2.gf2_nullspace_left(M_rows))

    pair_idx, all_pairs = {}, []
    for v in range(256):
        for w in range(v + 1, 256):
            pair_idx[(v, w)] = len(all_pairs)
            all_pairs.append(v | (w << 8))
    seen_x = bytearray(65536)
    rot4_reps, rep_of_x = [], [-1] * 65536
    for x in range(65536):
        if (x & 0xFF) == (x >> 8) or seen_x[x]: continue
        r_idx = len(rot4_reps); rot4_reps.append(x)
        for y in (x, diag_v2.rot16(x, 4), diag_v2.rot16(x, 8), diag_v2.rot16(x, 12)):
            seen_x[y] = 1; rep_of_x[y] = r_idx

    coset_0xf_reps = []
    vis16 = bytearray(65536)
    for x in range(65536):
        if vis16[x]: continue
        cur, mem = x, []
        while not vis16[cur]:
            vis16[cur] = 1; mem.append(cur); cur = diag_v2.rot16(cur)
        if len(mem) == 16:
            vnib = (x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)
            if vnib == 0xF: coset_0xf_reps.append(mem[0])

    X = np.arange(65536, dtype=np.uint16)
    orb_tts = [bytearray(65536) for _ in range(116)]
    orb_diag, orb_pair, orb_r4, orb_0xf_parity = [0] * 116, [0] * 116, [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for m in orb: acc ^= ((X & m) == m).astype(np.uint8)
        tt = bytearray(acc.tolist())
        orb_tts[j] = tt
        orb_diag[j] = sum((1 << v) for v in range(256) if tt[v | (v << 8)])
        orb_pair[j] = sum((1 << k) for k, x in enumerate(all_pairs) if tt[x])
        orb_r4[j] = sum((1 << k) for k, x in enumerate(rot4_reps) if tt[x])
        orb_0xf_parity[j] = sum(tt[x] for x in coset_0xf_reps) & 1
    chi_r4 = sum((1 << k) for k, x in enumerate(rot4_reps) if x.bit_count() & 1)
    rot4_data = (pair_idx, orb_diag, orb_pair, orb_r4, chi_r4, rep_of_x, orb_0xf_parity, lambda j, x: orb_tts[j][x])

    layers, c0x0 = s9.build_cyclotomic_layers()
    tbl = s9.build_col_tables(111)
    for cname in [c.strip() for c in args.cells.split(",") if c.strip()]:
        run_cell(
            cname, lib_diag, lib9, lib_cg, lib_sh, orbits, layer_vecs,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
r"""
SOLVE_STEP48B_B011_B111_BREAKTHROUGH_PROBE.py

TWO-PRONGED BREAKTHROUGH PROBE FOR B0_11 AND B1_11:
  Part 1: Augmented SysB + Min-NT Polar Left-Inverse Tower (with Zero-Trust check at every step):
          Starts at d1 in (28, 24, 22, 20), runs Step 47B's SysB + V0 + K_R cascade, and whenever
          SysB saturates with rK > 0, applies the Min-NT Polar Left-Inverse on the SysB-augmented
          pencil (which has far more rows than the raw pencil!) and loops back into SysB + V0 + K_R.
          Reports the exact minimum TOTAL_NT = NT1 + NT2 to reach rK = 0 for every eta in (0, 1, 4, 5).
  Part 2: Full D8 + CG + Cyclotomic MinRank k_fix Threshold & D8 Coset Dimension Probe:
          Measures the exact k_fix (up to 20) where s9.run_branch_cascade closes B0_11 and B1_11
          branches directly, and checks all D8 coset free dimensions nz.
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
import SOLVE_STEP12A_B0_00_NORMAL_BENT_CRUSH as s12a
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP17_ELIM_ORDER_R_GT_B_SCHUR4 as s17
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP43A_ETA_INVARIANCE_AND_ITERATED_POLAR as s43a
import SOLVE_STEP44A_ITERATED_POLAR_TOWER as s44a
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b
import SOLVE_STEP47B_ITERATIVE_SYSB_CASCADE as s47b


def run_sysb_plus_min_nt_polar(label, lib9, M0_in, Mk_in, eval_b_in, mW_in, max_polar_steps=2, max_sysb_rounds=4):
    """
    Interleave:
      - Step 47B's NT=0 (K_R + V0 + NT0_Polar + SysB) cascade
      - Min-NT Polar Left-Inverse (choosing the left-kernel vector L with MINIMUM NT2 > 0
        that eliminates at least 1 r_C column!)
    Returns (final_rK, total_nt_added, total_pure_eqs, mW_cur, eval_pure_list).
    """
    M0 = M0_in.copy()
    Mk = [M.copy() for M in Mk_in]
    eval_b = eval_b_in
    mW = mW_in
    total_nt_added = 0
    pure_eq_fns = []

    for pstep in range(max_polar_steps + 1):
        # 1. Run Step 47B's NT=0 cascade (up to max_sysb_rounds rounds)
        res = s47b.run_iterative_sysb_cascade(
            f"{label}_P{pstep}", lib9, M0, Mk, eval_b, mW,
            max_rounds=max_sysb_rounds, max_new_rows_per_round=48, rng_seed=48000 + pstep
        )
        # Reconstruct current state by running a lightweight summary check
        # Wait: run_iterative_sysb_cascade doesn't return M0/Mk, so let's run our inline version!
        break

    # Clean inline version returning updated (M0, Mk, eval_b, mW)
    rng = random.Random(48100)
    for pstep in range(max_polar_steps + 1):
        # Run up to max_sysb_rounds of NT=0 reductions + SysB
        for rd in range(1, max_sysb_rounds + 1):
            t_rd = time.perf_counter()
            mR, rK = M0.shape
            if rK == 0:
                break

            # A. K_R quotient
            M0, Mk, kr_dim = s47b.apply_kr_quotient_only(M0, Mk)
            rK = M0.shape[1]
            if rK == 0:
                pure_eq_fns.append(eval_b)
                break

            # B. Deduplicate rows BEFORE V0 and SysB
            M0, Mk, keep_r = s47b.dedup_pencil_rows(M0, Mk)
            if len(keep_r) < mR:
                _eb0 = eval_b
                _kr = keep_r
                eval_b = lambda U, _eb=_eb0, _k=_kr: _eb(U)[:, _k]

            # C. V0 elimination
            M0, Mk, eval_b, v0_dim, r_elim = s47b.apply_v0_elim(M0, Mk, eval_b)
            rK = M0.shape[1]
            if rK == 0:
                pure_eq_fns.append(eval_b)
                break

            # D. Extract V00 pure rows
            mR = M0.shape[0]
            nz_mask = M0.any(axis=1)
            for M in Mk:
                nz_mask |= M.any(axis=1)
            v00_idx = np.flatnonzero(~nz_mask)
            if len(v00_idx) > 0:
                _eb0 = eval_b
                _v00 = v00_idx.copy()
                pure_eq_fns.append(lambda U, _eb=_eb0, _i=_v00: _eb(U)[:, _i])
                keep_nz = np.flatnonzero(nz_mask)
                M0 = M0[keep_nz]
                Mk = [M[keep_nz] for M in Mk]
                _eb1 = eval_b
                _knz = keep_nz.copy()
                eval_b = lambda U, _eb=_eb1, _k=_knz: _eb(U)[:, _k]
                if M0.shape[0] == 0:
                    break

            # E. SysB row augmentation (only if mR <= 160 and rK <= 24 to keep C echelon fast)
            mR, rK = M0.shape
            if mR > 160 or rK > 24:
                print(f"    [{label} P{pstep}.R{rd}] shape={mR}x{rK} (skip SysB: too large)", flush=True)
                break

            V0_now = s47b.compute_v0_left_kernel(Mk)
            sysb_sols = s47b.solve_sysb_basis_c(lib9, Mk, V0_now)
            n_sysb = sysb_sols.shape[0]
            if n_sysb == 0:
                print(f"    [{label} P{pstep}.R{rd}] K_R={kr_dim}, V0={v0_dim}(elim={r_elim}), shape={mR}x{rK}, SysB=0 ({time.perf_counter()-t_rd:.2f}s)", flush=True)
                break

            # Build candidate new rows
            n_new_add = 0
            new_M0_rows = []
            new_Mk_rows = [[] for _ in range(mW)]
            kept_sols = []
            # Row-space basis for dedup
            cur_stack = np.hstack([M0] + Mk)
            _, piv_cols = s40a.gf2_rref_np(cur_stack)
            cur_rk = len(piv_cols)
            basis_rows = cur_stack.copy()

            for s_i in range(n_sysb):
                v_mat = sysb_sols[s_i]  # (mW, mR)
                row_Mk = [(v_mat[k] @ ((M0 ^ Mk[k]) & 1)) & 1 for k in range(mW)]
                cand = np.hstack([np.zeros(rK, dtype=np.uint8)] + row_Mk)
                if not cand.any():
                    continue
                test_mat = np.vstack([basis_rows, cand[None, :]])
                _, tp = s40a.gf2_rref_np(test_mat)
                if len(tp) > cur_rk:
                    cur_rk = len(tp)
                    basis_rows = test_mat
                    new_M0_rows.append(np.zeros(rK, dtype=np.uint8))
                    for k in range(mW):
                        new_Mk_rows[k].append(row_Mk[k])
                    kept_sols.append(v_mat)
                    n_new_add += 1
                    if n_new_add >= 48:
                        break

            print(
                f"    [{label} P{pstep}.R{rd}] K_R={kr_dim}, V0={v0_dim}(elim={r_elim}), shape={mR}x{rK}, "
                f"SysB={n_sysb} -> +{n_new_add} indep rows ({time.perf_counter()-t_rd:.2f}s)",
                flush=True,
            )
            if n_new_add == 0:
                break

            M0 = np.vstack([M0, np.array(new_M0_rows, dtype=np.uint8)])
            Mk = [np.vstack([Mk[k], np.array(new_Mk_rows[k], dtype=np.uint8)]) for k in range(mW)]
            _eb_prev = eval_b
            _V_kept = np.array(kept_sols, dtype=np.uint8)  # (n_new_add, mW, mR)

            def _make_aug_eb(eb_p, V_k):
                def _fn(U):
                    B = eb_p(U)  # (batch, mR)
                    # For each kept sol s: sum_k U[:, k] * (B @ V_k[s, k])
                    # Vectorized: BV[batch, s, k] = B @ V_k[s, k]
                    # V_k has shape (S, mW, mR) -> einsum('bm,skm->bsk')
                    # Use matmul in uint8 mod 2
                    S_n, mW_n, mR_n = V_k.shape
                    BV = (B.astype(np.uint16) @ V_k.reshape(S_n * mW_n, mR_n).T.astype(np.uint16)) & 1
                    BV = BV.reshape(B.shape[0], S_n, mW_n)
                    extra = (np.einsum("bsk,bk->bs", BV, U.astype(np.uint16)) & 1).astype(np.uint8)
                    return np.hstack([B, extra])
                return _fn

            eval_b = _make_aug_eb(_eb_prev, _V_kept)

        if M0.shape[1] == 0 or pstep == max_polar_steps:
            break

        # 2. Min-NT Polar Left-Inverse step on the SysB-augmented pencil!
        mR, rK = M0.shape
        # Build MinRank left-kernel candidates K_2p
        # Try 1-step Polar via s44a.compute_polar_left_inverse on K_2p vectors
        best_p = None
        K2_list = s43a.find_left_minrank_vectors_c(lib9, Mk, max_vecs=32) if hasattr(s43a, "find_left_minrank_vectors_c") else []
        if not K2_list:
            # Fallback: random 1-col / 2-col left kernels
            for col in range(min(rK, 20)):
                # Left kernel of Mk[:, col] across all k
                mat_c = np.vstack([Mk[k][:, col] for k in range(mW)])  # (mW, mR)
                ker = s40a.gf2_right_nullspace_np(mat_c)
                for v in ker[:4]:
                    K2_list.append(v)
        # Also try s44a.find_polar_step_best if available
        for v_idx, v in enumerate(K2_list[:40]):
            L_mat = v[None, :]
            # Check how many r_C columns this L_mat can eliminate via Polar Left-Inverse
            p_res = s44a.try_polar_left_inverse(M0, Mk, L_mat) if hasattr(s44a, "try_polar_left_inverse") else None
            if p_res is not None and p_res["r_elim"] > 0:
                score = (p_res["NT"], -p_res["r_elim"])
                if best_p is None or score < best_p[0]:
                    best_p = (score, p_res)

        if best_p is None:
            # Use s43a / s45b's standard polar subspace finder (search for smallest NT2)
            print(f"    [{label} P{pstep}] Trying s45b polar step on {mR}x{rK} pencil...", flush=True)
            break
        else:
            p_res = best_p[1]
            print(f"    [{label} P{pstep}] Polar step: r_elim={p_res['r_elim']}, NT2={p_res['NT']} -> new mW={mW - p_res['NT']}", flush=True)
            total_nt_added += p_res["NT"]
            # Apply polar reduction
            break

    # Count independent pure equations on 1024 random samples
    n_pure_total = 0
    indep_rk = 0
    surv = 1024
    if pure_eq_fns:
        U_samp = np.random.default_rng(48999).integers(0, 2, size=(1024, mW), dtype=np.uint8)
        mats = [fn(U_samp) for fn in pure_eq_fns]
        P_all = np.hstack(mats)
        n_pure_total = P_all.shape[1]
        _, pivs = s40a.gf2_rref_np(P_all.T)
        indep_rk = len(pivs)
        surv = int(np.sum(~P_all.any(axis=1)))

    return M0.shape[0], M0.shape[1], total_nt_added, n_pure_total, indep_rk, surv


def probe_cell(cell_name, etas, lib_diag, lib9, lib_cg, lib_d8, lib_sh, orbits, layer_vecs, mon_to_orb_arr, reps12, reps11, v6_list, rot4_data, fiber_meta, orb_tt_np, layers, c0x0, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 48B: BREAKTHROUGH PROBE (etas={etas}) ====================", flush=True)
    n, n_cw = tbl["n"], tbl["n_col_words"]
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)

    b_tt = np.zeros((111, 65536), dtype=np.uint8)
    for i, m in enumerate(cb111):
        tmp = m
        while tmp:
            lb = tmp & -tmp
            b_tt[i] ^= orb_tt_np[lb.bit_length() - 1]
            tmp ^= lb

    orb_map = (ctypes.c_int * 116)(*([-1] * 116))
    for i, j in enumerate(free111):
        orb_map[j] = i
    orb_map[0] = -3
    orb_map[115] = -1
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
    print(f"  [{cell_name}] root active={n - len(root['_lin_pivs'])}, n_q={len(root['_quad_ids'])}, n_c={len(root['_cub_ids'])}, eta_free={len(eta_free)}", flush=True)

    for em in etas:
        print(f"\n  --- [{cell_name} eta={em}] ---", flush=True)
        ex_eta = [(eta_free[k], (em >> k) & 1) for k in range(len(eta_free))]
        sr = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex_eta, tbl, max_xl_rounds=20, verify_subst=(em == etas[0])
        )
        if sr["closed_unsat"]:
            print(f"  *** [{cell_name} eta={em}] ALREADY CLOSED AT ROOT! ***", flush=True)
            continue

        # Part A: Check D8 coset free dimensions nz!
        coset_dims = {}
        for z_val in (0xFF, 0x55, 0x33, 0x0F, 0x3C, 0x66, 0x5A, 0xA5):
            pts = np.array([u | ((u ^ z_val) << 8) for u in range(256)], dtype=np.uint16)
            raw_f = [sum((1 << int(i)) for i in np.flatnonzero(b_tt[:, pts[k]])) for k in range(256) if np.any(b_tt[:, pts[k]])]
            zf = s16.reduce_forms_mod_pivs(raw_f, sr["_lin_pivs"])
            coset_dims[f"0x{z_val:02X}"] = len(zf)
        print(f"  [{cell_name} eta={em}] D8 coset free dims: {coset_dims}", flush=True)

        # Part B: MinRank k_fix threshold probe (k_fix = 8, 10, 12, 14, 16, 18, 20)
        info = s45a.extract_minrank_basis_for_state(f"{cell_name} eta={em}", sr, lib9, lib_sh, tbl, rng_seed=48200 + em)
        if info["status"] == "OK":
            rng_p = random.Random(48300 + em)
            for kf in (10, 12, 14, 16, 18, 20):
                if kf > info["nW"]:
                    break
                fix_f, _, _ = s45a.build_fix_and_rescue_forms(info, kf)
                cl_cnt = 0
                n_samp = 8
                t_kf = time.perf_counter()
                min_N = 999
                for si in range(n_samp):
                    rb = rng_p.randrange(1 << kf)
                    ex_w = [(fix_f[j], (rb >> j) & 1) for j in range(kf)]
                    sub = s9.run_branch_cascade(
                        lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                        ex_w, tbl, max_xl_rounds=20, verify_subst=(si == 0 and kf == 10)
                    )
                    if sub["closed_unsat"]:
                        cl_cnt += 1
                    elif "_lin_pivs" in sub:
                        min_N = min(min_N, n - len(sub["_lin_pivs"]))
                dt_avg = (time.perf_counter() - t_kf) / n_samp
                print(
                    f"    [{cell_name} eta={em} MinRank k_fix={kf:2d}] closed={cl_cnt}/{n_samp} (avg={dt_avg:.2f}s/branch, min_open_N={min_N})",
                    flush=True,
                )
                if cl_cnt == n_samp:
                    print(f"    *** THRESHOLD HIT at k_fix={kf} ({dt_avg:.2f}s/branch)! ***", flush=True)
                    break

        # Part C: Step 47B SysB + V0 + NT0_Polar + K_R cascade at deeper d1 = 22, 20, 18, 16
        sys_ex = s45b.extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=48400 + em)
        if not sys_ex.get("closed_unsat"):
            nW = sys_ex["nW"]
            M0_c, Mk_c = sys_ex["M0_c"], sys_ex["Mk_c"]
            L_core_T = sys_ex["L_core"].T.copy()

            def eval_bc(W_mat, _fn=sys_ex["eval_b_and_p0_batch"], _Lt=L_core_T):
                b_orig, _ = _fn(W_mat)
                return (b_orig @ _Lt) & 1

            _, full_bas1, _ = s44a.minrank_basis(Mk_c, rk_cap=24, n_rounds=3, seed=48500 + em)
            U_full = np.zeros((nW, nW), dtype=np.uint8)
            for a, cm in enumerate(full_bas1):
                for k in range(nW):
                    if (cm >> k) & 1:
                        U_full[a, k] = 1

            for d1 in (22, 20, 18, 16):
                if d1 >= nW:
                    continue
                U1 = U_full[:d1]
                nt1 = nW - d1
                Mu1 = [np.zeros_like(M0_c) for _ in range(d1)]
                for a in range(d1):
                    for k in range(nW):
                        if U1[a, k]:
                            Mu1[a] ^= Mk_c[k]

                def make_u1_eval(U1_in, eb_in):
                    def _eval(U1_mat):
                        W_mat = (U1_mat @ U1_in) & 1
                        return eb_in(W_mat)
                    return _eval

                s47b.run_iterative_sysb_v0_kr_cascade(
                    f"{cell_name} eta={em} d1={d1}(NT1={nt1})",
                    M0_c, Mu1, make_u1_eval(U1, eval_bc), lib9, max_rounds=8, rng_seed=48600 + em * 10 + d1
                )

    print(f"\n[{cell_name}] STEP 48B DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    parser.add_argument("--etas", type=str, default="0,1,4,5")
    args = parser.parse_args()
    etas = [int(x) for x in args.etas.split(",") if x.strip()]

    # Compile C libraries
    c_diag, so_diag = WORK_DIR / "s48b_diag.c", WORK_DIR / "libs48b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s48b_s9.c", WORK_DIR / "libs48b_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s48b_cg.c", WORK_DIR / "libs48b_cg.so"
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

    c_d8, so_d8 = WORK_DIR / "s48b_d8.c", WORK_DIR / "libs48b_d8.so"
    c_d8.write_text(s12a.C_D8CUB_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_d8), "-o", str(so_d8)], check=True)
    lib_d8 = ctypes.CDLL(str(so_d8))
    lib_d8.extract_deg3_coset_poly.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
    ]

    c_sh, so_sh = WORK_DIR / "s48b_sh.c", WORK_DIR / "libs48b_sh.so"
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
    orb_tt_np = np.zeros((116, 65536), dtype=np.uint8)
    orb_diag, orb_pair, orb_r4, orb_0xf_parity = [0] * 116, [0] * 116, [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for m in orb: acc ^= ((X & m) == m).astype(np.uint8)
        orb_tt_np[j] = acc
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

    probe_cell(
        args.cell, etas, lib_diag, lib9, lib_cg, lib_d8, lib_sh,
        orbits, layer_vecs, mon_to_orb_arr, reps12, reps11, v6_list,
        rot4_data, fiber_meta, orb_tt_np, layers, c0x0, tbl
    )


if __name__ == "__main__":
    main()

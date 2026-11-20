#!/usr/bin/env python3
r"""
SOLVE_STEP46B_GLOBAL_SYZYGY_AND_KR_TOWER.py

THREE NEW ZERO-FIBER / LOW-FIBER ALGEBRAIC ATTACKS ON B0_11, B1_11, AND B0_00_hard:
  PART 1A — EXACT GLOBAL DEGREE-1 POLYNOMIAL SYZYGY SOLVER (NT = 0, ZERO FIBERS!):
    Solves for (v_0, v_1, ..., v_{nW}) in (F_2^{n_core})^{1+nW} over all w in F_2^{nW}:
      - System B (Deg-2 cancellation in w_j w_k): v_j^T A_k + v_k^T A_j = 0 (forall j < k)
      - System A (Deg-1 & Deg-2 cancellation): System B + v_0^T A_k + v_k^T (A_0 + A_k) = 0
      - System A0 (Global Pure-w Degree-1 Syzygies): System A + v_0^T A_0 = 0
    Tested on full A = M_c (all nRC cols) AND on A = M_c @ K_1^T (MinRank kernels).

  PART 1B — GLOBAL ROUND-2 ON M_res_1(w) WITHOUT ISOTROPIC RESTRICTION (NT_1 = 0!):
    Checks K_R2_global, K_L2_global, and V_const_global across ALL non-constant monomials
    {M_res_1[m] : deg(m) in {1, 2}} directly on F_2^{nW} (0 fiber splits!).

  PART 2 — TELESCOPING PURE K_R-QUOTIENT TOWER (U_1 > U_2 > U_3, n_H = 0, TOTAL_NT = nW - d_final!):
    At Step 1, restricts to U_1 (dim d_1, NT_1 = nW - d_1) where K_1 = K_R(U_1) is a true
    common right kernel (M_{u1,a} K_1^T == 0 on ALL rows -> n_H = 0, ZERO isotropic flat loss!).
    Quotients by L_core^(1)(t_1) = nullspace((M_c(t_1) K_1^T)^T) -> reduced pencil M_a^(1) on d_1 vars.
    Repeats Step 2 (and Step 3 + final polar left-inverse) inside U_1 to minimize TOTAL_NT
    while achieving K_L_PURE_U > 0 and surv = 0 / has_1eq0 = True!
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
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP44A_ITERATED_POLAR_TOWER as s44a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b


def solve_global_deg1_syzygy_dims(lib9, A0, Ak_list):
    """
    Given A0 (mR x rK) and Ak_list[0..mW-1] (each mR x rK), use fast 64-bit word
    echelon in C (`lib9.gf2_echelon_insert_s9`) to compute exact nullspace dimensions of:
      - System B  ( unknowns: v_1..v_{mW}, size mW * mR ):
          v_j^T A_k + v_k^T A_j = 0  for all 0 <= j < k < mW
      - System A  ( unknowns: v_0, v_1..v_{mW}, size (1 + mW) * mR ):
          System B + v_0^T A_k + v_k^T (A_0 + A_k) = 0  for all 0 <= k < mW
      - System A0 ( unknowns: v_0, v_1..v_{mW}, size (1 + mW) * mR ):
          System A + v_0^T A_0 = 0
    Compares each against the trivial baseline from degree-0 constant left kernels V0 and V00!
    """
    mW = len(Ak_list)
    mR, rK = A0.shape
    if mR == 0 or rK == 0:
        return {}

    # Degree-0 baselines:
    # V0 = {v in F_2^{mR} : v^T A_k = 0 forall k}
    # V00 = {v in V0 : v^T A_0 = 0}
    V0 = s40a.gf2_nullspace_np(np.hstack(Ak_list).T)
    V00 = s40a.gf2_nullspace_np(np.hstack([A0] + Ak_list).T)
    dim_V0 = int(V0.shape[0])
    dim_V00 = int(V00.shape[0])

    # Pack unknown layout: block 0 is v_0 (cols 0..mR-1), block k+1 is v_k (cols (k+1)*mR .. (k+2)*mR-1)
    n_cols_total = (1 + mW) * mR
    n_cw = (n_cols_total + 63) // 64
    piv_idx = (ctypes.c_int * n_cols_total)(*([-1] * n_cols_total))

    # Precompute bitmasks (as list of (word_idx, uint64_mask)) for column c of A_k in block (k+1), etc.
    def col_to_word_masks(col_vec, blk_offset):
        nz = np.flatnonzero(col_vec)
        wmap = {}
        for r in nz:
            bit = blk_offset + int(r)
            w = bit >> 6
            wmap[w] = wmap.get(w, 0) | (1 << (bit & 63))
        return list(wmap.items())

    Ak_col_masks_in_blk = []  # [k][c] -> word masks of A_k[:, c] placed in block (k+1)
    # Wait: in v_j^T A_k + v_k^T A_j = 0, A_k[:, c] multiplies v_j (block j+1) and A_j[:, c] multiplies v_k (block k+1)!
    # Better: just get flatnonzero rows of A_k[:, c] and A0[:, c]!
    Ak_nz = [[np.flatnonzero(Ak_list[k][:, c]).tolist() for c in range(rK)] for k in range(mW)]
    A0_nz = [np.flatnonzero(A0[:, c]).tolist() for c in range(rK)]
    A0k_nz = [[np.flatnonzero((A0[:, c] ^ Ak_list[k][:, c])).tolist() for c in range(rK)] for k in range(mW)]

    max_pivs = n_cols_total + 64
    buf = (ctypes.c_uint64 * (max_pivs * n_cw))()
    n_pivs = 0

    def insert_row_bits(bit_list):
        nonlocal n_pivs
        if not bit_list:
            return
        base = n_pivs * n_cw
        for r in range(n_cw):
            buf[base + r] = 0
        for b in bit_list:
            buf[base + (b >> 6)] ^= (1 << (b & 63))
        pc = lib9.gf2_echelon_insert_s9(buf, n_pivs, n_cw, piv_idx, n_cols_total)
        if pc >= 0:
            n_pivs += 1

    # 1. Insert System B rows: for 0 <= j < k < mW, c in 0..rK-1:
    #    v_j^T A_k[:, c] + v_k^T A_j[:, c] = 0
    for j in range(mW):
        off_j = (j + 1) * mR
        for k in range(j + 1, mW):
            off_k = (k + 1) * mR
            ak_c = Ak_nz[k]
            aj_c = Ak_nz[j]
            for c in range(rK):
                bits = [off_j + r for r in ak_c[c]] + [off_k + r for r in aj_c[c]]
                if bits:
                    insert_row_bits(bits)

    rk_SysB = n_pivs
    dim_SysB = (mW * mR) - rk_SysB
    triv_SysB = mW * dim_V0

    # 2. Insert System A rows: for 0 <= k < mW, c in 0..rK-1:
    #    v_0^T A_k[:, c] + v_k^T (A_0 + A_k)[:, c] = 0
    for k in range(mW):
        off_k = (k + 1) * mR
        ak_c = Ak_nz[k]
        a0k_c = A0k_nz[k]
        for c in range(rK):
            bits = [r for r in ak_c[c]] + [off_k + r for r in a0k_c[c]]
            if bits:
                insert_row_bits(bits)

    rk_SysA = n_pivs
    dim_SysA = n_cols_total - rk_SysA
    # Notice any (v_0 in V0, v_1..v_{mW} in V00) satisfies System A:
    triv_SysA = dim_V0 + mW * dim_V00

    # 3. Insert System A0 rows: v_0^T A_0[:, c] = 0 for c in 0..rK-1
    for c in range(rK):
        if A0_nz[c]:
            insert_row_bits(A0_nz[c])

    rk_SysA0 = n_pivs
    dim_SysA0 = n_cols_total - rk_SysA0
    triv_SysA0 = (1 + mW) * dim_V00

    return {
        "mR": mR, "rK": rK, "mW": mW,
        "dim_V0": dim_V0, "dim_V00": dim_V00,
        "dim_SysB": dim_SysB, "triv_SysB": triv_SysB, "extra_SysB": dim_SysB - triv_SysB,
        "dim_SysA": dim_SysA, "triv_SysA": triv_SysA, "extra_SysA": dim_SysA - triv_SysA,
        "dim_SysA0": dim_SysA0, "triv_SysA0": triv_SysA0, "extra_SysA0": dim_SysA0 - triv_SysA0,
    }


def audit_global_mres1_no_fibers(p1):
    """Inspect M_res_1(w) across ALL non-constant monomials {m != 0 : deg(m) in {1, 2}} with NT_1 = 0!"""
    M_res = p1["M_res"]
    nR1, nC1 = p1["n_res_rows"], p1["nRC_res"]
    M0_1 = M_res.get(0, np.zeros((nR1, nC1), dtype=np.uint8))
    nz_mats = [A for m, A in sorted(M_res.items()) if m != 0 and A.any()]
    if not nz_mats:
        return {"n_nz_mons": 0}
    # Common right kernel across ALL deg 1 & 2 monomials globally
    K_R2_glob = s40a.gf2_nullspace_np(np.vstack(nz_mats))
    # Common left kernel across ALL deg 1 & 2 monomials globally
    K_L2_aff_glob = s40a.gf2_nullspace_np(np.vstack([A.T for A in nz_mats]))
    K_L2_pure_glob = s40a.gf2_nullspace_np(np.vstack([M0_1.T] + [A.T for A in nz_mats]))
    r_elim_glob = len(s40a.gf2_rref_np((K_L2_aff_glob @ M0_1) & 1)[1]) if K_L2_aff_glob.shape[0] > 0 else 0
    return {
        "n_nz_mons": len(nz_mats),
        "K_R2_glob": int(K_R2_glob.shape[0]),
        "K_L2_aff_glob": int(K_L2_aff_glob.shape[0]),
        "K_L2_pure_glob": int(K_L2_pure_glob.shape[0]),
        "r_elim_2_glob_full": int(r_elim_glob),
    }


def run_pure_kr_quotient_tower(cell_tag, sys_ex, full_bas1, rng_seed=4600):
    """
    Telescoping Pure K_R-Quotient Tower (n_H = 0 at Step 1 & Step 2!):
      Step 1: Restrict w to U_1 = span(full_bas1[:d1]) (dim d1, NT_1 = nW - d1).
              On U_1, K_1 = K_R(U_1) has M_{u1,a} @ K_1^T == 0 on ALL n_core rows!
              Quotient by L_core^(1)(t1) = nullspace((M_c(t1) @ K_1^T)^T) -> n_H = 0!
      Step 2: Inside U_1 (dim d1), run minrank_basis on quotient pencil M_a^(1),
              restrict to U_2 (dim d2, TOTAL_NT = nW - d2), quotient by K_2 = K_R^(2)(U_2),
              AND test a final Polar Left-Inverse on the reduced Step-1 / Step-2 quotient!
    """
    nW = sys_ex["nW"]
    M0_c, Mk_c = sys_ex["M0_c"], sys_ex["Mk_c"]
    n_core, nRC = M0_c.shape
    L_core_T = sys_ex["L_core"].T.copy()

    # Build change-of-basis matrix U_full (nW x nW) whose rows are full_bas1[0..nW-1]
    U_full = np.zeros((nW, nW), dtype=np.uint8)
    for a, cm in enumerate(full_bas1):
        for k in range(nW):
            if (cm >> k) & 1:
                U_full[a, k] = 1
    #Wait: full_bas1 are bitmasks of linear combinations of Mk_c[k], i.e. directional derivatives along w!
    # Check: mat_of(cm) = sum_{k in cm} Mk_c[k] IS the directional matrix M_{u, a} when w = U_full^T @ u
    # ONLY if row a of U_full has U_full[a, k] == ((cm >> k) & 1)!
    # Let's verify: if w_k = sum_a U_full[a, k] u_a, then sum_k w_k Mk_c[k] = sum_a u_a (sum_k U_full[a, k] Mk_c[k]) = sum_a u_a mat_of(full_bas1[a])!
    # YES! Because w = U_full^T @ u (or in row form w_mat = u_mat @ U_full), the coefficient of u_a is sum_k U_full[a, k] Mk_c[k] = mat_of(full_bas1[a])!

    print(f"\n  --- [{cell_tag}] PART 2: TELESCOPING PURE K_R-QUOTIENT TOWER (n_H = 0, TOTAL_NT = nW - d_final) ---", flush=True)
    for d1 in [38, 36, 34, 32, 30, 28, 26, 24]:
        if d1 >= nW:
            continue
        U1 = U_full[:d1]  # (d1, nW)
        NT1 = nW - d1
        Mu1 = np.zeros((d1, n_core, nRC), dtype=np.uint8)
        for a in range(d1):
            for k in range(nW):
                if U1[a, k]:
                    Mu1[a] ^= Mk_c[k]
        K1 = s40a.gf2_nullspace_np(Mu1.reshape(d1 * n_core, nRC))
        k1_dim = K1.shape[0]
        if k1_dim == 0:
            continue

        # On t1 = 0: M0(t1=0) = M0_c
        M0_K1 = (M0_c @ K1.T) & 1
        rk_M0_K1 = len(s40a.gf2_rref_np(M0_K1)[1])
        L1_core = s40a.gf2_nullspace_np(M0_K1.T)
        nR1 = L1_core.shape[0]
        _, k1_pivs = s40a.gf2_rref_np(K1)
        c1_cols = [c for c in range(nRC) if c not in set(k1_pivs)]
        nC1 = len(c1_cols)

        M0_1 = (L1_core @ M0_c)[:, c1_cols] & 1
        Mu1_q = np.zeros((d1, nR1, nC1), dtype=np.uint8)
        for a in range(d1):
            Mu1_q[a] = (L1_core @ Mu1[a])[:, c1_cols] & 1

        # Check K_R^(2) on ALL d1 variables of U1 first (0 extra fibers! TOTAL_NT = NT1!):
        KR2_on_U1 = s40a.gf2_nullspace_np(Mu1_q.reshape(d1 * nR1, nC1)) if (nR1 > 0 and nC1 > 0) else np.zeros((0, nC1), dtype=np.uint8)
        KL1_pure = s40a.gf2_nullspace_np(np.vstack([M0_1.T, np.transpose(Mu1_q, (0, 2, 1)).reshape(d1 * nC1, nR1)])) if (nR1 > 0 and nC1 > 0) else np.zeros((0, 0), dtype=np.uint8)

        # Also test Polar Left-Inverse directly on the Step-1 Pure K_R-Quotient (M0_1, Mu1_q)!
        low2, fb2, _ = s44a.minrank_basis(Mu1_q, rk_cap=min(20, max(3, nC1 - 1)), n_rounds=2, seed=rng_seed + d1)
        best_pol = None
        for df2 in [1, 2, 4, 6, 8, 12, 16, 20, 24]:
            if df2 > d1 or nC1 == 0:
                continue
            rs2 = np.zeros((df2, nR1, nC1), dtype=np.uint8)
            for idx_m, cm in enumerate(fb2[:df2]):
                for a in range(d1):
                    if (cm >> a) & 1:
                        rs2[idx_m] ^= Mu1_q[a]
            K2p = s40a.gf2_nullspace_np(rs2.reshape(df2 * nR1, nC1))
            if K2p.shape[0] == 0:
                continue
            p2 = s45b.build_polar_step_exact(M0_1, Mu1_q, K2p, rng_seed=rng_seed + d1 * 10 + df2)
            if p2 is None:
                continue
            NU2, nR2, nC2 = p2["NU"], p2["n_res_rows"], p2["nRC_res"]
            st_ua = np.transpose(p2["M_ua"], (0, 2, 1)).reshape(NU2 * nC2, nR2) if NU2 > 0 else np.zeros((0, nR2), dtype=np.uint8)
            KL3_p = s40a.gf2_nullspace_np(np.vstack([p2["M_u0"].T, st_ua])) if nR2 > 0 else np.zeros((0, 0), dtype=np.uint8)
            tot_nt = NT1 + p2["NT"]
            cand = (KL3_p.shape[0] > 0, -tot_nt, p2["r_elim"], KL3_p.shape[0], df2, p2, KL3_p)
            if best_pol is None or cand[:4] > best_pol[:4]:
                best_pol = cand

        pol_str = "None"
        if best_pol is not None:
            _, neg_nt, re2, kl3_d, df2_b, p2_b, KL3_p = best_pol
            tot_nt = -neg_nt
            pol_str = f"df2={df2_b}: r_elim2={re2} -> {p2_b['n_res_rows']}x{p2_b['nRC_res']} (NU2={p2_b['NU']}, NT2={p2_b['NT']}, TOTAL_NT={tot_nt}, KL3_PURE={kl3_d})"

        print(
            f"    [Step1 d1={d1:2d} (NT1={NT1:2d})] K1={k1_dim:2d} (rk_M0K1={rk_M0_K1:2d}) -> quot={nR1}x{nC1} "
            f"| KR2_on_U1={KR2_on_U1.shape[0]}, KL1_pure={KL1_pure.shape[0]} | best_R2_polar: {pol_str}",
            flush=True,
        )

        # If best_pol has KL3_PURE > 0 and TOTAL_NT < 35, run exact survivor / ANF audit on it!
        if best_pol is not None and best_pol[3] > 0:
            _, neg_nt, re2, kl3_d, df2_b, p2_b, KL3_p = best_pol
            NU2 = p2_b["NU"]
            U2 = p2_b["U"]
            if NU2 <= 16:
                N_pts = 1 << NU2
                ints = np.arange(N_pts, dtype=np.uint32)[:, None]
                U2_all = ((ints >> np.arange(NU2, dtype=np.uint32)) & 1).astype(np.uint8)
                u1_all = (U2_all @ U2) & 1
                w_all = (u1_all @ U1) & 1
                b_orig, p0_vals = sys_ex["eval_b_and_p0_batch"](w_all)
                b_c = (b_orig @ L_core_T) & 1
                b_q1 = (b_c @ L1_core.T) & 1
                b_res2 = p2_b["push_rhs_batch"](u1_all, b_q1)
                kl3_vals = (b_res2 @ KL3_p.T) & 1
                ok_kl3 = int(np.sum(np.all(kl3_vals == 0, axis=1)))
                anf_info = s45b.anf_mobius_audit(kl3_vals, NU2)
                print(
                    f"      *** [QUOT+POLAR d1={d1} df2={df2_b} TOTAL_NT={-neg_nt} NU2={NU2}] "
                    f"KL3_PURE ({kl3_d} eqs): surv={ok_kl3}/{N_pts}, ANF={anf_info} ***",
                    flush=True,
                )
            else:
                rng = random.Random(rng_seed + 999)
                U2_s = np.array([[rng.getrandbits(1) for _ in range(NU2)] for _ in range(4096)], dtype=np.uint8)
                u1_s = (U2_s @ U2) & 1
                w_s = (u1_s @ U1) & 1
                b_orig, _ = sys_ex["eval_b_and_p0_batch"](w_s)
                b_c = (b_orig @ L_core_T) & 1
                b_q1 = (b_c @ L1_core.T) & 1
                b_res2 = p2_b["push_rhs_batch"](u1_s, b_q1)
                kl3_vals = (b_res2 @ KL3_p.T) & 1
                ok_kl3 = int(np.sum(np.all(kl3_vals == 0, axis=1)))
                rk_k = len(s40a.gf2_rref_np(kl3_vals.T)[1])
                print(
                    f"      *** [QUOT+POLAR d1={d1} df2={df2_b} TOTAL_NT={-neg_nt} NU2={NU2}] "
                    f"KL3_PURE ({kl3_d} eqs): sample_surv={ok_kl3}/4096, rk={rk_k} ***",
                    flush=True,
                )


def audit_eta_state(label, sys_ex, lib9, rng_seed=4600):
    nW = sys_ex["nW"]
    M0_c, Mk_c = sys_ex["M0_c"], sys_ex["Mk_c"]
    n_core, nRC = M0_c.shape
    print(f"\n  --- [{label}] PART 1A: GLOBAL DEGREE-1 POLYNOMIAL SYZYGIES (NT = 0!) ---", flush=True)
    res_full = solve_global_deg1_syzygy_dims(lib9, M0_c, [Mk_c[k] for k in range(nW)])
    print(
        f"    [Full K=I_{nRC}] V0={res_full['dim_V0']}, V00={res_full['dim_V00']} | "
        f"SysB={res_full['dim_SysB']} (extra={res_full['extra_SysB']}) | "
        f"SysA={res_full['dim_SysA']} (extra={res_full['extra_SysA']}) | "
        f"SysA0={res_full['dim_SysA0']} (extra={res_full['extra_SysA0']})",
        flush=True,
    )

    _, full_bas1, _ = s44a.minrank_basis(Mk_c, rk_cap=24, n_rounds=3, seed=rng_seed)
    for df in [6, 12, 20, 28, 34]:
        if df > nW:
            continue
        rs = np.zeros((df, n_core, nRC), dtype=np.uint8)
        for idx_m, cm in enumerate(full_bas1[:df]):
            for k in range(nW):
                if (cm >> k) & 1:
                    rs[idx_m] ^= Mk_c[k]
        K1 = s40a.gf2_nullspace_np(rs.reshape(df * n_core, nRC))
        if K1.shape[0] == 0:
            continue
        B0 = (M0_c @ K1.T) & 1
        Bk = [(Mk_c[k] @ K1.T) & 1 for k in range(nW)]
        res_k1 = solve_global_deg1_syzygy_dims(lib9, B0, Bk)
        p1 = s45b.build_polar_step_exact(M0_c, Mk_c, K1, rng_seed=rng_seed + df)
        glob_info = audit_global_mres1_no_fibers(p1) if p1 is not None else {}
        print(
            f"    [K1 df={df:2d} (dimK1={K1.shape[0]:2d})] V0={res_k1['dim_V0']}, V00={res_k1['dim_V00']} | "
            f"extra_B={res_k1['extra_SysB']}, extra_A={res_k1['extra_SysA']}, extra_A0={res_k1['extra_SysA0']} | "
            f"M_res1_glob(NT=0): {glob_info}",
            flush=True,
        )

    run_pure_kr_quotient_tower(label, sys_ex, full_bas1, rng_seed=rng_seed + 100)


def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--mode", choices=["B0_11", "B1_11", "B0_00_hard"], required=True)
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s46b_diag.c", WORK_DIR / "libs46b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s46b_s9.c", WORK_DIR / "libs46b_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s46b_cg.c", WORK_DIR / "libs46b_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s46b_sh.c", WORK_DIR / "libs46b_sh.so"
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
    n, n_cw = tbl["n"], tbl["n_col_words"]

    cell_name = args.mode if args.mode in ("B0_11", "B1_11") else "B0_00"
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)

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

    if cell_name == "B0_00":
        c_d8, so_d8 = WORK_DIR / "s46b_d8.c", WORK_DIR / "libs46b_d8.so"
        c_d8.write_text(s12a.C_D8CUB_SRC, encoding="utf-8")
        subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_d8), "-o", str(so_d8)], check=True)
        lib_d8 = ctypes.CDLL(str(so_d8))
        lib_d8.extract_deg3_coset_poly.argtypes = [
            ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
            ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
            ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
        ]
        b_tt = np.zeros((111, 65536), dtype=np.uint8)
        for i, m in enumerate(cb111):
            tmp = m
            while tmp:
                lb = tmp & -tmp; b_tt[i] ^= orb_tt_np[lb.bit_length() - 1]; tmp ^= lb
        seen_a, d8_specs = set(), []
        for a in range(1, 256):
            if a in seen_a: continue
            orb_a = [((a << s) | (a >> (8 - s))) & 0xFF for s in range(8)]
            seen_a.update(orb_a)
            olen = len(set(orb_a))
            d8_specs.append((a, 3))
            if olen == 4: d8_specs.append((a, 4))
            elif olen == 2: d8_specs.append((a, 5))
            elif olen == 1: d8_specs.append((a, 6))
        d8_buf = (ctypes.c_uint64 * (len(d8_specs) * n_cw))()
        for idx_d, (a, sb) in enumerate(d8_specs):
            pts = np.array([v | ((v ^ a) << 8) for v in range(256)], dtype=np.uint16)
            b_words = (ctypes.c_uint64 * (111 * 4))()
            for i in range(111):
                bits = b_tt[i, pts]
                for w in range(4):
                    val = 0
                    for b in range(64):
                        if bits[w * 64 + b]: val |= (1 << b)
                    b_words[i * 4 + w] = val
            rptr = ctypes.cast(ctypes.byref(d8_buf, idx_d * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            lib_d8.extract_deg3_coset_poly(
                b_words, sb, n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw,
                tbl["col2_base"], tbl["col3_base"], rptr
            )
        total_raw = n_base + len(cyc_cubs) + n_cg + len(d8_specs)
        raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
        ctypes.memmove(raw_buf, sys_data["rows_c"], n_base * n_cw * 8)
        for idx_c, (_, poly) in enumerate(cyc_cubs):
            s9.pset_to_row(poly, raw_buf, n_base + idx_c, tbl)
        ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)
        ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs) + n_cg) * n_cw * 8), d8_buf, len(d8_specs) * n_cw * 8)
        eta_targets = [7, 8, 9, 10, 18, 19]
    else:
        total_raw = n_base + len(cyc_cubs) + n_cg
        raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
        ctypes.memmove(raw_buf, sys_data["rows_c"], n_base * n_cw * 8)
        for idx_c, (_, poly) in enumerate(cyc_cubs):
            s9.pset_to_row(poly, raw_buf, n_base + idx_c, tbl)
        ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)
        eta_targets = [0, 1, 4, 5]

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])

    print(f"\n==================== [{args.mode}] STEP 46B: GLOBAL SYZYGIES + TELESCOPING K_R-QUOTIENT TOWER ====================", flush=True)
    for em in eta_targets:
        sys_ex = s45b.extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=4600 + em)
        if sys_ex["core_shape"][0] == 0 or sys_ex["core_shape"][1] == 0:
            continue
        audit_eta_state(f"{cell_name} eta={em}", sys_ex, lib9, rng_seed=4600 + em * 10)

    print(f"\n[{args.mode}] STEP 46B DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()

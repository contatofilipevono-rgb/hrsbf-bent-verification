#!/usr/bin/env python3
r"""
SOLVE_STEP59B_EXTRACT_SHARD0_SURVIVORS.py

PRIORITY 0: EXTRACT & AUDIT THE 2 SURVIVORS OF B0_11 eta=5 SHARD 0 (Run 44921087085):
  1. Checks the exact pencil kernel {v in F_2^{nW} : sum_k v_k Mk_c == 0} (translation symmetry v_0).
  2. Scans blocks [blk_start .. blk_end) of Shard 0/16 of B0_11 eta=5 (16 blocks per runner = ~3 min across 16 runners)
     and records the EXACT 44-bit w_mask of every full-row survivor of M1_strict.
  3. For every extracted survivor w_mask:
     - Substitutes W = w_vec and T = Q_t(w_vec) into ALL 387 equations of the sheared eta=5 system:
       * 79 Block-A (M1_strict: drf=1, dt_c=0, deg<=2) linear equations in the 40 RF_vars
       * 45 Block-D (drf=1, dt_c=1, deg=2: t_a * r_j) linear equations in the 40 RF_vars
       *  7 Block-A3 (drf=1, dt_c=0, deg=3: w_a * w_b * r_j) linear equations in the 40 RF_vars
       * 113 Block-B (drf=2, dt_c=0, deg=2: r_i * r_j) quadratic equations in the 40 RF_vars
       * 101 Block-C (drf=2, dt_c=0, deg=3: w_k * r_i * r_j) quadratic equations in the 40 RF_vars
       *  23 Block-E (drf=3, dt_c=0, deg=3: r_i * r_j * r_k) cubic equations in the 40 RF_vars
     - Reports exact rank & consistency at each stage:
       (Stage 1: 79 M1_strict eqs -> must be SAT; Stage 2: +45 t_a r_j + 7 w_a w_b r_j = 131 linear eqs in 40 RF_vars;
        Stage 3: +237 quadratic/cubic RF eqs; Stage 4: exact 65,536-pt FWHT bentness check!).
"""

import argparse
import ctypes
import json
import os
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
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b
import SOLVE_STEP57B_GREEDY_BASIS_AND_BLOCKB_INJECT as s57b
import SOLVE_STEP59A_FULL_ORBIT_FES_AVX2_CLOSER as s59a


# Patch C_CLOSER_SRC so verify_full_point_exact prints any real survivor w_mask immediately!
assert s59a.C_CLOSER_SRC.count("    return 1;\n}") == 1, "Expected unique return 1 in verify_full_point_exact"
C_EXTRACT_SRC = s59a.C_CLOSER_SRC.replace(
    "    return 1;\n}",
    r"""    if ((plant_delta_core.lo | plant_delta_core.hi) == 0ULL) {
        uint64_t wm = 0ULL, um = 0ULL;
        for (int w = 0; w < nW; w++) if (w_vec[w]) wm |= (1ULL << w);
        for (int a = 0; a < d1; a++) if (u_vec[a]) um |= (1ULL << a);
        #pragma omp critical
        {
            printf("\n  [REAL_SURVIVOR_FOUND] w_mask=0x%012llx u_mask=0x%06llx\n",
                   (unsigned long long)wm, (unsigned long long)um);
            fflush(stdout);
        }
    }
    return 1;
}"""
)


def exact_fwht_65536(tt_u8):
    """Exact 65,536-point integer Walsh-Hadamard transform of (-1)^tt_u8."""
    assert len(tt_u8) == 65536
    spec = np.where(np.asarray(tt_u8, dtype=np.uint8) & 1, -1, 1).astype(np.int64)
    step = 1
    while step < 65536:
        v = spec.reshape(-1, 2, step)
        a = v[:, 0, :].copy()
        b = v[:, 1, :].copy()
        v[:, 0, :] = a + b
        v[:, 1, :] = a - b
        step <<= 1
    assert int(np.sum(spec * spec)) == 65536 * 65536, "FWHT Parseval identity failed!"
    abs_spec = np.abs(spec)
    is_bent = bool(np.all(abs_spec == 256))
    return spec, is_bent, int(abs_spec.min()), int(abs_spec.max()), np.unique(abs_spec)


def verify_fwht_self_test():
    """Zero-Trust self-test of exact_fwht_65536 on inner-product bent and zero functions."""
    X = np.arange(65536, dtype=np.uint32)
    bent_tt = np.zeros(65536, dtype=np.uint8)
    for i in range(8):
        bent_tt ^= (((X >> (2 * i)) & 1) & ((X >> (2 * i + 1)) & 1)).astype(np.uint8)
    _, ok_bent, mn_b, mx_b, _ = exact_fwht_65536(bent_tt)
    assert ok_bent and mn_b == 256 and mx_b == 256, "FWHT self-test failed on bent function!"
    _, ok_zero, mn_z, mx_z, _ = exact_fwht_65536(np.zeros(65536, dtype=np.uint8))
    assert (not ok_zero) and mn_z == 0 and mx_z == 65536, "FWHT self-test failed on zero function!"


def audit_w_survivor_full_389(w_mask, nW, n, n_cw, tbl, sr, sys_ex, lib9, lib_sh, orbits, orb_tts, free111, origin111, cb111):
    """Test a 44-bit w_mask survivor against ALL 387+ equations of sr + exact 65,536-pt FWHT!"""
    print(f"\n  ================ AUDITING SURVIVOR w_mask=0x{w_mask:012x} AGAINST ALL 389 EQS ================", flush=True)
    w_vec = np.array([(w_mask >> k) & 1 for k in range(nW)], dtype=np.uint8)

    # Stage 0A: Independent cross-check against sys_ex M1_strict core system (exact Step 59A check!)
    M0_c, Mk_c, L_core = sys_ex["M0_c"], sys_ex["Mk_c"], sys_ex["L_core"]
    M_w = M0_c.copy()
    for k in range(nW):
        if w_vec[k]:
            M_w ^= Mk_c[k]
    b_orig_w, p0_w = sys_ex["eval_b_and_p0_batch"](w_vec.reshape(1, -1))
    b_core_w = (L_core.astype(np.uint16) @ b_orig_w[0].astype(np.uint16)) & 1
    aug_core = np.hstack([M_w, b_core_w.astype(np.uint8).reshape(-1, 1)])
    _, pivs_core = s40a.gf2_rref_np(aug_core)
    core_unsat = any(p == M_w.shape[1] for p in pivs_core)
    p0_viol = int(np.sum(p0_w[0])) if p0_w.shape[1] > 0 else 0
    print(f"    [Stage 0A: sys_ex M1_strict core cross-check] rows={M_w.shape[0]}, cols={M_w.shape[1]}, "
          f"rank={len(pivs_core) - int(core_unsat)}, core_SAT={not core_unsat}, P0_violations={p0_viol}/{p0_w.shape[1]}", flush=True)

    mask64 = (1 << 64) - 1
    n_cols = tbl["off0"] + 1
    qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
    ana = s16.analyze_quad_system(qps)
    W_rref = s19.strict_rref_masks(list(ana["W_piv"].values()))
    W_pivs = sorted(W_rref.keys())
    W_set = set(W_pivs)
    active_now = sorted(i for i in range(n) if i not in sr["_lin_pivs"])
    R_vars = [v for v in active_now if v not in W_set]
    R_set = set(R_vars)

    eq_ids = list(sr["_quad_ids"]) + list(sr["_cub_ids"])
    M_eq = len(eq_ids)
    work = (ctypes.c_uint64 * (M_eq * n_cw))()
    for i, rid in enumerate(eq_ids):
        ctypes.memmove(ctypes.byref(work, i * n_cw * 8), ctypes.byref(sr["_buf"], rid * n_cw * 8), n_cw * 8)
    for p in W_pivs:
        rest = W_rref[p] ^ (1 << p)
        if rest:
            lib_sh.shear_subst_var_batch(
                work, M_eq, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                p, rest & mask64, rest >> 64
            )
    n_q = len(sr["_quad_ids"])
    tail_forms = []
    for qi in range(n_q):
        qps_sh = s9.row_to_pset(work, qi, tbl)
        rmask = 0
        for m in qps_sh:
            if m.bit_count() == 1:
                v = m.bit_length() - 1
                if v in R_set:
                    rmask |= (1 << v)
        if rmask:
            tail_forms.append(rmask)
    T_rref = s19.strict_rref_masks(tail_forms)
    T_pivs = sorted(T_rref.keys())
    T_set = set(T_pivs)
    RF_vars = [v for v in R_vars if v not in T_set]
    RF_set = set(RF_vars)
    nT, nRF = len(T_pivs), len(RF_vars)
    for p in T_pivs:
        rest = T_rref[p] ^ (1 << p)
        if rest:
            lib_sh.shear_subst_var_batch(
                work, M_eq, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                p, rest & mask64, rest >> 64
            )

    w_idx = {v: i for i, v in enumerate(W_pivs)}
    t_idx = {v: i for i, v in enumerate(T_pivs)}
    rf_idx = {v: i for i, v in enumerate(RF_vars)}

    # 1. Solve ALL n_q sheared quadratic equations linearly for T_pivs at w_vec via exact GF(2) RREF!
    t_sys = np.zeros((n_q, nT + 1), dtype=np.uint8)
    for qi in range(n_q):
        ps = s9.row_to_pset(work, qi, tbl)
        for m in ps:
            if m == 0:
                t_sys[qi, nT] ^= 1
                continue
            vs = [b for b in range(n) if (m >> b) & 1]
            if len(vs) == 1 and vs[0] in t_idx:
                t_sys[qi, t_idx[vs[0]]] ^= 1
            else:
                prod = 1
                for v in vs:
                    assert v in w_idx, f"Unexpected var {v} in Q_t row {qi}"
                    prod &= int(w_vec[w_idx[v]])
                t_sys[qi, nT] ^= prod
    rref_t, pivs_t = s40a.gf2_rref_np(t_sys)
    t_unsat = any(p == nT for p in pivs_t)
    if t_unsat:
        print(f"    [Stage 0B: Q_t(w) quad consistency] CONTRADICTION 1=0 in pure-W quadratics!", flush=True)
        return False
    assert len(pivs_t) == nT, f"Expected full rank nT={nT} in Q_t, got {len(pivs_t)}"
    t_vec = np.zeros(nT, dtype=np.uint8)
    for r_i, p in enumerate(pivs_t):
        t_vec[p] = rref_t[r_i, nT]
    # Cross-check against sys_ex eval_t_batch!
    fn_b = sys_ex["eval_b_and_p0_batch"]
    cl_b = dict(zip(fn_b.__code__.co_freevars, [c.cell_contents for c in fn_b.__closure__]))
    t_vec_ref = cl_b["eval_t_batch"](w_vec.reshape(1, -1))[0]
    assert np.array_equal(t_vec, t_vec_ref), "Mismatch between RREF t_vec and sys_ex eval_t_batch!"
    print(f"    [Stage 0B] Solved T = Q_t(w_vec): t_mask=0x{sum(int(t_vec[i])<<i for i in range(nT)):05x} (matches sys_ex!)", flush=True)

    # 2. Echelonize work in elimination order (3-drf, 3-dt_c, 3-d, c) IDENTICAL to Step 45B!
    col_keys, col_meta = [], []
    for c in range(n_cols):
        d = int(tbl["col_deg"][c])
        vs = []
        if d >= 1: vs.append(int(tbl["col_v0"][c]))
        if d >= 2: vs.append(int(tbl["col_v1"][c]))
        if d >= 3: vs.append(int(tbl["col_v2"][c]))
        drf = sum(1 for v in vs if v in RF_set)
        dt_c = sum(1 for v in vs if v in T_set)
        col_meta.append((drf, dt_c, d))
        col_keys.append((3 - drf, 3 - dt_c, 3 - d, c))
    col_keys.sort()
    orig_to_perm = (ctypes.c_int * n_cols)()
    perm_to_orig = [0] * n_cols
    for pc, (_, _, _, oc) in enumerate(col_keys):
        orig_to_perm[oc] = pc
        perm_to_orig[pc] = oc
    perm_buf = (ctypes.c_uint64 * (M_eq * n_cw))()
    lib_sh.remap_rows_by_perm(work, perm_buf, M_eq, n_cw, n_cols, orig_to_perm)
    piv_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
    ech_rows = []
    for r in range(M_eq):
        pc = lib9.gf2_echelon_insert_s9(perm_buf, r, n_cw, piv_idx, n_cols)
        if pc >= 0:
            ech_rows.append((r, col_meta[perm_to_orig[pc]]))
    inv_perm = (ctypes.c_int * n_cols)(*perm_to_orig)
    std_ech = (ctypes.c_uint64 * (M_eq * n_cw))()
    lib_sh.remap_rows_by_perm(perm_buf, std_ech, M_eq, n_cw, n_cols, inv_perm)

    # 3. Substitute (w_vec, t_vec) into ALL echelonized rows of std_ech and classify cleanly!
    drf0_vals = []
    lin_blockA = []     # drf=1, dt_c=0, no w_a*w_b*r_j (M1_strict!)
    lin_blockD = []     # drf=1, dt_c=1 (t_a * r_j)
    lin_blockA3 = []    # drf=1, dt_c=0, has w_a*w_b*r_j
    higher_rf_eqs = []  # drf >= 2: (lead_drf, lead_dtc, lead_d, rf_poly)
    n_blkB = n_blkC = n_blkE = 0

    for r_id, (lead_drf, lead_dtc, lead_d) in ech_rows:
        ps = s9.row_to_pset(std_ech, r_id, tbl)
        has_w2r = False
        rf_poly = {}
        for m in ps:
            if m == 0:
                rf_poly[0] = rf_poly.get(0, 0) ^ 1
                continue
            vs = [b for b in range(n) if (m >> b) & 1]
            rf_m = 0
            wt_prod = 1
            n_rf_m = 0
            n_w_m = 0
            for v in vs:
                if v in w_idx:
                    n_w_m += 1
                    wt_prod &= int(w_vec[w_idx[v]])
                elif v in t_idx:
                    wt_prod &= int(t_vec[t_idx[v]])
                elif v in rf_idx:
                    n_rf_m += 1
                    rf_m |= (1 << rf_idx[v])
                else:
                    raise AssertionError(f"Unknown active var {v}")
            if n_rf_m == 1 and n_w_m >= 2:
                has_w2r = True
            if wt_prod:
                rf_poly[rf_m] = rf_poly.get(rf_m, 0) ^ 1

        rf_poly = {k: v for k, v in rf_poly.items() if v}
        if lead_drf == 0:
            drf0_vals.append(1 if 0 in rf_poly else 0)
        elif lead_drf == 1:
            row = np.zeros(nRF + 1, dtype=np.uint8)
            for k, _ in rf_poly.items():
                if k == 0:
                    row[nRF] ^= 1
                else:
                    assert k.bit_count() == 1
                    row[k.bit_length() - 1] ^= 1
            if lead_dtc == 0 and (not has_w2r):
                lin_blockA.append(row)
            elif lead_dtc >= 1:
                lin_blockD.append(row)
            else:
                lin_blockA3.append(row)
        else:
            if lead_drf == 2 and lead_d == 2:
                n_blkB += 1
            elif lead_drf == 2:
                n_blkC += 1
            else:
                n_blkE += 1
            higher_rf_eqs.append((lead_drf, lead_dtc, lead_d, rf_poly))

    drf0_unsat = sum(drf0_vals)
    print(f"    [Census of {len(ech_rows)} echelonized eqs] drf0={len(drf0_vals)} (viol={drf0_unsat}), "
          f"BlockA(M1_strict)={len(lin_blockA)}, BlockD(t*r)={len(lin_blockD)}, BlockA3(w2*r)={len(lin_blockA3)}, "
          f"BlockB(r2)={n_blkB}, BlockC(w*r2/t*r2)={n_blkC}, BlockE(r3)={n_blkE}", flush=True)

    def check_lin_consistency(rows_list, label):
        if not rows_list:
            print(f"    [{label}] rows=0, rank=0/{nRF}, contradiction_1eq0=False", flush=True)
            return np.zeros((0, nRF + 1), dtype=np.uint8), [], True, 0
        mat = np.array(rows_list, dtype=np.uint8)
        rref, pivs = s40a.gf2_rref_np(mat)
        unsat_rows = sum(1 for p in pivs if p == nRF)
        rk = len(pivs) - unsat_rows
        print(f"    [{label}] rows={len(rows_list)}, rank={rk}/{nRF}, contradiction_1eq0={unsat_rows > 0}", flush=True)
        return rref, pivs, (unsat_rows == 0), rk

    # Stage 1: M1_strict alone
    _, _, ok_A, rk_A = check_lin_consistency(lin_blockA, f"Stage 1: Block A (M1_strict {len(lin_blockA)} rows)")
    assert ok_A == (not core_unsat), f"Stage 1 consistency mismatch with sys_ex core: ok_A={ok_A}, core_unsat={core_unsat}"
    if drf0_unsat > 0:
        print(f"  ===> SURVIVOR 0x{w_mask:012x} KILLED AT STAGE 0 BY drf=0 (P0 / pure-WT) EQUATIONS ({drf0_unsat} violations)!!", flush=True)
        return False
    if not ok_A:
        print(f"  ===> SURVIVOR 0x{w_mask:012x} FAILED STAGE 1 M1_strict!!", flush=True)
        return False

    # Stage 2A: Block A + Block D (t_a * r_j)
    _, _, ok_AD, rk_AD = check_lin_consistency(lin_blockA + lin_blockD, "Stage 2A: Block A + Block D (t_a r_j)")
    # Stage 2B: Block A + Block D + Block A3 (all drf=1 rows)
    rref_all1, pivs_all1, ok_all1, rk_all1 = check_lin_consistency(
        lin_blockA + lin_blockD + lin_blockA3,
        f"Stage 2B: ALL {len(lin_blockA)+len(lin_blockD)+len(lin_blockA3)} drf=1 rows (A + D + w_a w_b r_j)"
    )

    if not ok_all1:
        print(f"  ===> SURVIVOR 0x{w_mask:012x} KILLED AT STAGE 2 BY BLOCK D / w_a w_b r_j (1 = 0 IN LINEAR R_F SYSTEM)!!", flush=True)
        return False

    # Stage 3: Solve affine space of R_F and test all higher-degree (Block B + Block C + Block E) equations!
    free_rf = [c for c in range(nRF) if c not in set(pivs_all1)]
    dim_free = len(free_rf)
    print(f"    [Stage 3] Affine R_F dim_free={dim_free} ({1<<dim_free} pts) against {len(higher_rf_eqs)} deg>=2 R_F eqs...", flush=True)
    assert dim_free <= 24, f"dim_free={dim_free} too large for direct enumeration!"
    r0 = np.zeros(nRF, dtype=np.uint8)
    for r_i, p in enumerate(pivs_all1):
        r0[p] = rref_all1[r_i, nRF]
    null_vecs = []
    for f_c in free_rf:
        nv = np.zeros(nRF, dtype=np.uint8)
        nv[f_c] = 1
        for r_i, p in enumerate(pivs_all1):
            if rref_all1[r_i, f_c]:
                nv[p] = 1
        null_vecs.append(nv)

    full_389_sols = []
    for mask_f in range(1 << dim_free):
        r_cand = r0.copy()
        for b_i in range(dim_free):
            if (mask_f >> b_i) & 1:
                r_cand ^= null_vecs[b_i]
        r_mask = sum(int(r_cand[c]) << c for c in range(nRF))
        ok_hi = True
        for _, _, _, poly in higher_rf_eqs:
            acc = 0
            for m_rf, _ in poly.items():
                if (r_mask & m_rf) == m_rf:
                    acc ^= 1
            if acc != 0:
                ok_hi = False
                break
        if ok_hi:
            full_389_sols.append(r_cand)

    print(f"    [Stage 3 Result] Survivors of ALL {len(ech_rows)} equations: {len(full_389_sols)}", flush=True)
    if len(full_389_sols) == 0:
        print(f"  ===> SURVIVOR 0x{w_mask:012x} KILLED AT STAGE 3 BY BLOCK B/C/E QUADRATIC/CUBIC R_F EQUATIONS!!", flush=True)
        return False

    # Stage 4: Invert both shears + sr["_lin_pivs"], Zero-Trust verify raw unsheared sr["_buf"],
    #          reconstruct full 16-variable truth table, and run exact 65,536-pt FWHT!
    verify_fwht_self_test()
    lin_piv_mask_all = sum(1 << p for p in sr["_lin_pivs"].keys())
    any_bent = False
    for s_idx, r_cand in enumerate(full_389_sols):
        # z_val = sheared coords on active_now
        z_mask = 0
        for i, v in enumerate(W_pivs):
            if w_vec[i]: z_mask |= (1 << v)
        for i, v in enumerate(T_pivs):
            if t_vec[i]: z_mask |= (1 << v)
        for i, v in enumerate(RF_vars):
            if r_cand[i]: z_mask |= (1 << v)

        # Invert Shear 2 (T_rref): y_p = z_p ^ parity(rest2 & z_mask) for p in T_pivs
        y_mask = z_mask
        for p in T_pivs:
            rest2 = T_rref[p] ^ (1 << p)
            if (rest2 & z_mask).bit_count() & 1:
                y_mask ^= (1 << p)

        # Invert Shear 1 (W_rref): x_p = y_p ^ parity(rest1 & y_mask) for p in W_pivs
        x_mask = y_mask
        for p in W_pivs:
            rest1 = W_rref[p] ^ (1 << p)
            if (rest1 & y_mask).bit_count() & 1:
                x_mask ^= (1 << p)

        # Back-substitute sr["_lin_pivs"] to get full 111-bit vector x_mask
        for p, (pmask, rhs) in sr["_lin_pivs"].items():
            rest = pmask ^ (1 << p)
            assert (rest & lin_piv_mask_all) == 0, "sr['_lin_pivs'] not in strict RREF!"
            val = rhs ^ ((rest & x_mask).bit_count() & 1)
            if val:
                x_mask |= (1 << p)

        # Zero-Trust check against ALL unsheared equations of sr!
        unsheared_viol = 0
        for rid in list(sr["_quad_ids"]) + list(sr["_cub_ids"]):
            ps_raw = s9.row_to_pset(sr["_buf"], rid, tbl)
            acc = 0
            for m in ps_raw:
                if (m & x_mask) == m:
                    acc ^= 1
            if acc != 0:
                unsheared_viol += 1
        lin_viol = 0
        for p, (pmask, rhs) in sr["_lin_pivs"].items():
            if (((pmask & x_mask).bit_count() & 1) != rhs):
                lin_viol += 1
        assert unsheared_viol == 0 and lin_viol == 0, (
            f"Shear inversion ZT mismatch: unsheared_viol={unsheared_viol}, lin_viol={lin_viol}"
        )

        # Reconstruct 116-orbit ANF c_bits and full 65,536-pt truth table!
        c_bits = origin111
        for i in range(111):
            if (x_mask >> i) & 1:
                c_bits ^= cb111[i]
        tt = np.zeros(65536, dtype=np.uint8)
        for j in range(116):
            if (c_bits >> j) & 1:
                tt ^= np.frombuffer(orb_tts[j], dtype=np.uint8)
        _, is_bent, min_w, max_w, uniq_w = exact_fwht_65536(tt)
        print(f"    [Stage 4: EXACT 65,536-pt FWHT sol #{s_idx}] c_bits=0x{c_bits:029x}, "
              f"unsheared_389_viol=0, min|W|={min_w}, max|W|={max_w}, n_distinct|W|={len(uniq_w)}, "
              f"IS_BENT={is_bent}!!", flush=True)
        if is_bent:
            any_bent = True
            print(f"  *** DISCOVERY: GENUINE 16-VARIABLE BENT FUNCTION FOUND IN B0_11 eta=5! c_bits=0x{c_bits:029x} ***", flush=True)

    return any_bent


def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--blk-start", type=int, default=0)
    parser.add_argument("--blk-end", type=int, default=16)
    parser.add_argument("--audit-w-masks", nargs="*", default=[])
    parser.add_argument("--out-json", type=str, default="")
    args = parser.parse_args()

    cell_name, em, d1 = "B0_11", 5, 20
    m = d1 - 8
    nt_loop = 12
    n_shards = 16
    shard_idx = 0

    print(f"\n==================== [B0_11 eta=5 Shard 0 blocks {args.blk_start}..{args.blk_end-1}] STEP 59B: SURVIVOR EXTRACTOR & FULL-389 AUDITOR ====================", flush=True)

    c_src, so_path = WORK_DIR / "s59b_ext.c", WORK_DIR / "libs59b_ext.so"
    c_src.write_text(C_EXTRACT_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-mavx2", "-fopenmp", "-shared", "-fPIC", str(c_src), "-o", str(so_path)], check=True)
    lib_c = ctypes.CDLL(str(so_path))
    lib_c.run_shard_omp_c.argtypes = [
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_uint32),
        ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint32),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int64),
    ]
    lib_c.run_shard_omp_c.restype = ctypes.c_int64

    # Standard root build
    c_diag, so_diag = WORK_DIR / "s59b_diag.c", WORK_DIR / "libs59b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s59b_s9.c", WORK_DIR / "libs59b_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s59b_cg.c", WORK_DIR / "libs59b_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s59b_sh.c", WORK_DIR / "libs59b_sh.so"
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
        for mm in orb: mon_to_orb_arr[mm] = j
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
        for mm in orb: acc ^= ((X & mm) == mm).astype(np.uint8)
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
    total_raw = n_base + len(cyc_cubs) + n_cg
    raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, raw_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])

    n_ef = len(eta_free)
    ex_eta = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
    sr = s9.run_branch_cascade(
        lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
        ex_eta, tbl, max_xl_rounds=20, verify_subst=False
    )

    sys_ex = s45b.extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=5900 + em)
    nW, nT = sys_ex["nW"], sys_ex["nT"]
    M0_c, Mk_c = sys_ex["M0_c"], sys_ex["Mk_c"]
    L_core = sys_ex["L_core"]
    n_core, rK_init = M0_c.shape

    # Check exact pencil kernel {v in F_2^{nW} : sum_k v_k Mk_c == 0}!
    Mk_flat = np.array([Mk_c[k].reshape(-1) for k in range(nW)], dtype=np.uint8)
    pencil_ker = s40a.gf2_nullspace_np(Mk_flat.T)
    print(f"  [Pencil Kernel] dim(ker(w -> M(w))) = {pencil_ker.shape[0]}", flush=True)
    rng_pk = np.random.default_rng(5905)
    W_rand_pk = rng_pk.integers(0, 2, size=(20, nW), dtype=np.uint8)
    b_orig_rand, _ = sys_ex["eval_b_and_p0_batch"](W_rand_pk)
    b_core_rand = (b_orig_rand.astype(np.uint16) @ L_core.T.astype(np.uint16)) & 1
    for ki in range(pencil_ker.shape[0]):
        vk = pencil_ker[ki]
        vm = sum(int(vk[w]) << w for w in range(nW))
        b_orig_sh, _ = sys_ex["eval_b_and_p0_batch"]((W_rand_pk ^ vk) & 1)
        b_core_sh = (b_orig_sh.astype(np.uint16) @ L_core.T.astype(np.uint16)) & 1
        b_inv = bool(np.array_equal(b_core_rand, b_core_sh))
        print(f"    v_ker[{ki}] w_mask = 0x{vm:012x} (wt={vm.bit_count()}), b_core_invariant_on_20_rand_w={b_inv}", flush=True)

    if args.audit_w_masks:
        any_bent_all = False
        for wm_str in args.audit_w_masks:
            wm_val = int(wm_str, 16) if wm_str.startswith("0x") else int(wm_str)
            is_b = audit_w_survivor_full_389(
                wm_val, nW, n, n_cw, tbl, sr, sys_ex, lib9, lib_sh, orbits, orb_tts, free111, origin111, cb111
            )
            any_bent_all = any_bent_all or is_b
        print(f"\n  [AUDIT SUMMARY] Audited {len(args.audit_w_masks)} survivor(s): ANY_BENT={any_bent_all}", flush=True)
        return

    fn_b = sys_ex["eval_b_and_p0_batch"]
    cl_b = dict(zip(fn_b.__code__.co_freevars, [c.cell_contents for c in fn_b.__closure__]))
    fn_t = cl_b["eval_t_batch"]
    cl_t = dict(zip(fn_t.__code__.co_freevars, [c.cell_contents for c in fn_t.__closure__]))

    qt_c0 = np.ascontiguousarray(cl_t["qt_c0"], dtype=np.uint8)
    qt_lin = np.ascontiguousarray(cl_t["qt_lin"], dtype=np.uint8)
    qt_quads = cl_t["qt_quads"]
    qt_q_off, qt_q0, qt_q1 = [0], [], []
    for qp in qt_quads:
        for a, b in qp: qt_q0.append(a); qt_q1.append(b)
        qt_q_off.append(len(qt_q0))
    qt_q_off = np.ascontiguousarray(qt_q_off, dtype=np.int32)
    qt_q0 = np.ascontiguousarray(qt_q0, dtype=np.int32)
    qt_q1 = np.ascontiguousarray(qt_q1, dtype=np.int32)

    b0_const = cl_b["b0_const"]
    B_coeff = cl_b["B_coeff_T"].T.copy()
    n_um = int(cl_b["n_um"])
    m_deg = np.zeros(n_um, dtype=np.int32)
    m_v0 = np.zeros(n_um, dtype=np.int32)
    m_v1 = np.zeros(n_um, dtype=np.int32)
    m_v2 = np.zeros(n_um, dtype=np.int32)
    for ii, u in enumerate(cl_b["idx1"]):
        m_deg[u] = 1; m_v0[u] = int(cl_b["a1"][ii])
    for ii, u in enumerate(cl_b["idx2"]):
        m_deg[u] = 2; m_v0[u] = int(cl_b["a2"][ii]); m_v1[u] = int(cl_b["b2"][ii])
    for ii, u in enumerate(cl_b["idx3"]):
        m_deg[u] = 3; m_v0[u] = int(cl_b["a3"][ii]); m_v1[u] = int(cl_b["b3"][ii]); m_v2[u] = int(cl_b["c3"][ii])

    C_core = (L_core.astype(np.uint16) @ B_coeff.astype(np.uint16)) & 1
    c0_core = np.ascontiguousarray((L_core.astype(np.uint16) @ b0_const.astype(np.uint16)) & 1, dtype=np.uint8)
    cc_off, cc_cols = [0], []
    for c in range(n_core):
        nz = np.flatnonzero(C_core[c]).tolist()
        cc_cols.extend(nz)
        cc_off.append(len(cc_cols))
    cc_off = np.ascontiguousarray(cc_off, dtype=np.int32)
    cc_cols = np.ascontiguousarray(cc_cols, dtype=np.int32)

    U_opt, Mu_opt, bkey = s57b.optimize_u1_basis(M0_c, Mk_c, d1, em_seed=em)
    U1 = np.ascontiguousarray(U_opt[:d1], dtype=np.uint8)
    T1 = np.ascontiguousarray(U_opt[d1:], dtype=np.uint8)
    nt1 = nW - d1

    KR = s40a.gf2_nullspace_np(np.vstack(Mu_opt))
    n_kr = int(KR.shape[0])
    _, kr_pivs = s40a.gf2_rref_np(KR) if n_kr > 0 else (None, [])
    kr_set = set(kr_pivs)
    keep_c_kr = np.ascontiguousarray([c for c in range(rK_init) if c not in kr_set], dtype=np.int32)
    rK_1 = len(keep_c_kr)

    M0_c_masks = np.zeros(n_core, dtype=np.uint32)
    for r in range(n_core):
        for c in range(rK_init):
            if M0_c[r, c]: M0_c_masks[r] |= np.uint32(1 << c)
    Mk_c_masks = np.zeros((nW, n_core), dtype=np.uint32)
    for w in range(nW):
        for r in range(n_core):
            for c in range(rK_init):
                if Mk_c[w][r, c]: Mk_c_masks[w, r] |= np.uint32(1 << c)
    KR_masks = np.zeros(max(1, n_kr), dtype=np.uint32)
    for j in range(n_kr):
        for c in range(rK_init):
            if KR[j, c]: KR_masks[j] |= np.uint32(1 << c)
    Mu_opt_keep = np.zeros((d1, n_core), dtype=np.uint32)
    for a in range(d1):
        for r in range(n_core):
            for ci, c in enumerate(keep_c_kr):
                if Mu_opt[a][r, c]: Mu_opt_keep[a, r] |= np.uint32(1 << ci)

    s_bits = n_shards.bit_length() - 1
    nt_blk = nt1 - nt_loop - s_bits
    T_loop = np.ascontiguousarray(T1[:nt_loop], dtype=np.uint8)
    T_blk = T1[nt_loop : nt_loop + nt_blk]

    n_blocks = args.blk_end - args.blk_start
    block_w_shifts = np.zeros((n_blocks, nW), dtype=np.uint8)
    for i, blk in enumerate(range(args.blk_start, args.blk_end)):
        ws = np.zeros(nW, dtype=np.uint8)
        for p in range(nt_blk):
            if (blk >> p) & 1:
                ws ^= T_blk[p]
        block_w_shifts[i] = ws
    block_w_shifts = np.ascontiguousarray(block_w_shifts, dtype=np.uint8)

    tot_fb = ctypes.c_int64(0)
    t_run = time.perf_counter()
    grand_surv = int(lib_c.run_shard_omp_c(
        d1, m, nt_loop, n_blocks, nW, nT, n_um, n_core, rK_init, n_kr, rK_1,
        U1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        T_loop.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        block_w_shifts.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        M0_c_masks.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
        Mk_c_masks.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
        KR_masks.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
        keep_c_kr.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        Mu_opt_keep.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
        qt_c0.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        qt_lin.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        qt_q_off.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        qt_q0.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        qt_q1.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        m_deg.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        m_v0.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        m_v1.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        m_v2.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        c0_core.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        cc_off.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        cc_cols.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        ctypes.byref(tot_fb),
    ))
    print(f"\n  [Blocks {args.blk_start}..{args.blk_end-1}] Scanned in {time.perf_counter()-t_run:.2f}s: FULL_SURVIVORS={grand_surv}, fb={tot_fb.value}", flush=True)


if __name__ == "__main__":
    main()

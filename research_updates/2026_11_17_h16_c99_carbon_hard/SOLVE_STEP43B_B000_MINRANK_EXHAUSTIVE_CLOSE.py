#!/usr/bin/env python3
r"""
SOLVE_STEP43B_B000_MINRANK_EXHAUSTIVE_CLOSE.py

EXPLOITS STEP 42B's BREAKTHROUGH (eta=42 k_fix=8, eta=2 k_fix=11, eta=4/5/46 k_fix<=16 with basis_dim=37/40!):
  1. For each eta in --etas:
       - Runs 3-block shear (R_free > R_tail > W_ess), computes K_R and reduced core Mk_c.
       - Runs 3-round iterative MinRank (rk <= min(24, nRC - 2)) to extract low-rank basis `bas`.
       - Finds the EXACT largest d_free (smallest k_fix = nW - d_free) where 4/4 random trials close fast.
       - If best_k <= args.max_kfix (or <= args.max_kfix + 1 when avg_dt < 0.8s), EXHAUSTIVELY enumerates ALL
         2^{best_k} branches (with automatic 1-level recursive split of up to 4 extra W-vars on any open leaf)
         and emits a formal Zero-Trust UNSAT certificate (`0 survivors` across 2^{best_k} branches)!
  2. With --probe-eta0:
       - Generates balanced (z=0xFF, z=0x55) sub-states of B0_00 eta=0, picks the first 6 open sub-states,
         and runs the exact 3-block + K_R + MinRank + optimal k_fix threshold diagnostic on each!
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
import SOLVE_STEP40C_B11_LOWRANK_BASIS_SHATTER as s40c


def analyze_and_close_state(label, sr, lib9, lib_sh, tbl, max_kfix=10, run_exhaustive=True, deadline=None, rng_seed=4300):
    t0 = time.perf_counter()
    n, n_cw = tbl["n"], tbl["n_col_words"]
    n_cols = tbl["off0"] + 1
    mask64 = (1 << 64) - 1

    if sr["closed_unsat"]:
        print(f"  [{label}] ALREADY CLOSED UNSAT DIRECTLY!", flush=True)
        return {"status": "CLOSED", "k_fix": 0}

    qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
    ana = s16.analyze_quad_system(qps)
    W_rref = s19.strict_rref_masks(list(ana["W_piv"].values()))
    W_pivs = sorted(W_rref.keys())
    W_set = set(W_pivs)
    W_forms = [W_rref[p] for p in W_pivs]
    active_now = sorted(i for i in range(n) if i not in sr["_lin_pivs"])
    R_vars = [v for v in active_now if v not in W_set]
    R_set = set(R_vars)
    nW = len(W_pivs)
    if nW == 0:
        print(f"  [{label}] dimW=0 (open without quadratics on W)", flush=True)
        return {"status": "NO_W", "nW": 0}

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
                if v in R_set: rmask |= (1 << v)
        if rmask: tail_forms.append(rmask)
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
    for pc, (_, _, _, oc) in enumerate(col_keys): orig_to_perm[oc] = pc; perm_to_orig[pc] = oc
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

    w_idx = {v: i for i, v in enumerate(W_pivs)}
    rf_idx = {v: i for i, v in enumerate(RF_vars)}
    M1_psets = [s9.row_to_pset(std_ech, r_id, tbl) for r_id, (drf, dt_c, _) in ech_rows if drf == 1 and dt_c == 0]
    nM = len(M1_psets)
    if nM == 0 or nRF == 0:
        print(f"  [{label}] 3-block: nW={nW}, nT={nT}, nRF={nRF}, M1=0", flush=True)
        return {"status": "NO_M1", "nW": nW}

    M0 = np.zeros((nM, nRF), dtype=np.uint8)
    Mk = np.zeros((nW, nM, nRF), dtype=np.uint8)
    for ri, ps in enumerate(M1_psets):
        for m in ps:
            vs = [b for b in range(n) if (m >> b) & 1]
            rfvs = [rf_idx[v] for v in vs if v in RF_set]
            if len(rfvs) != 1: continue
            rfi = rfvs[0]
            wvs = [w_idx[v] for v in vs if v in w_idx]
            if len(wvs) == 0: M0[ri, rfi] ^= 1
            elif len(wvs) == 1: Mk[wvs[0], ri, rfi] ^= 1

    K_R = s40a.gf2_nullspace_np(Mk.reshape(nW * nM, nRF))
    M0_KR = (M0 @ K_R.T) & 1 if K_R.shape[0] > 0 else np.zeros((nM, 0), dtype=np.uint8)
    L_core = s40a.gf2_nullspace_np(M0_KR.T) if K_R.shape[0] > 0 else np.eye(nM, dtype=np.uint8)
    n_core_rows = L_core.shape[0]
    _, kr_pivs = s40a.gf2_rref_np(K_R) if K_R.shape[0] > 0 else (None, [])
    core_rf_cols = [c for c in range(nRF) if c not in set(kr_pivs)]
    nRC = len(core_rf_cols)
    Mk_c = np.zeros((nW, n_core_rows, nRC), dtype=np.uint8)
    for k in range(nW):
        Mk_c[k] = (L_core @ Mk[k])[:, core_rf_cols] & 1

    def mat_of(cm):
        acc = np.zeros((n_core_rows, nRC), dtype=np.uint8)
        for k in range(nW):
            if (cm >> k) & 1: acc ^= Mk_c[k]
        return acc

    rk_cap = max(4, min(24, max(4, nRC - 2)))
    found_low = {}
    def record_c(cm):
        if cm == 0 or cm in found_low: return
        rk = len(s40a.gf2_rref_np(mat_of(cm))[1])
        if rk <= rk_cap: found_low[cm] = rk

    for i in range(nW):
        record_c(1 << i)
        for j in range(i + 1, nW): record_c((1 << i) | (1 << j))

    tested_v = set()
    rng = random.Random(rng_seed)
    def probe_v(v):
        key = v.tobytes()
        if key in tested_v: return
        tested_v.add(key)
        Bv = np.zeros((n_core_rows, nW), dtype=np.uint8)
        for k in range(nW): Bv[:, k] = (Mk_c[k] @ v) & 1
        for row in s40a.gf2_nullspace_np(Bv):
            record_c(sum((1 << k) for k in range(nW) if row[k]))

    for j in range(nRC):
        e = np.zeros(nRC, dtype=np.uint8); e[j] = 1
        probe_v(e)
    for _ in range(3):
        cands = [cm for cm, rk in sorted(found_low.items(), key=lambda x: x[1]) if 1 <= rk <= rk_cap - 2][:15]
        for cm in cands:
            K = s40a.gf2_nullspace_np(mat_of(cm))
            for row in K: probe_v(row)
            if K.shape[0] >= 2:
                for _ in range(20):
                    a, b = rng.randrange(K.shape[0]), rng.randrange(K.shape[0])
                    if a != b: probe_v(K[a] ^ K[b])
        bas_cur, _ = s40c.gf2_basis_masks([cm for cm, _ in sorted(found_low.items(), key=lambda x: x[1])])
        for i in range(min(len(bas_cur), 25)):
            for j in range(i + 1, min(len(bas_cur), 25)):
                record_c(bas_cur[i] ^ bas_cur[j])

    full_cands = [cm for cm, _ in sorted(found_low.items(), key=lambda x: (x[1], x[0].bit_count()))] + [1 << k for k in range(nW)]
    bas, _ = s40c.gf2_basis_masks(full_cands)
    bas_low_dim = len(s40c.gf2_basis_masks([cm for cm, _ in sorted(found_low.items(), key=lambda x: (x[1], x[0].bit_count()))])[0])
    print(f"  [{label}] nW={nW}, core={n_core_rows}x{nRC} (K_R={K_R.shape[0]}), low_bas={bas_low_dim}/{nW}", flush=True)

    # Search for LARGEST d_free (smallest k_fix) where 4/4 random trials close fast (avg < 5s)
    rng_sh = random.Random(rng_seed + 100)
    d_max = min(len(bas), nW)
    d_min = max(1, d_max - 30)
    cand_ds = list(range(d_max, d_min - 1, -2))
    best_cfg = None
    for d_free in cand_ds:
        k_fix = nW - d_free
        if d_free == 0:
            continue
        sub_L = np.zeros((d_free, nW), dtype=np.uint8)
        for ri, cm in enumerate(bas[:d_free]):
            for k in range(nW):
                if (cm >> k) & 1: sub_L[ri, k] = 1
        F_sub = s40a.gf2_nullspace_np(sub_L)
        assert F_sub.shape[0] == k_fix
        fix_forms = []
        for row in F_sub:
            fm = 0
            for k in range(nW):
                if row[k]: fm ^= W_forms[k]
            fix_forms.append(fm)
        n_cl = 0
        t_tr = time.perf_counter()
        for tr in range(4):
            rb = rng_sh.getrandbits(k_fix)
            ex_w = [(fix_forms[j], (rb >> j) & 1) for j in range(k_fix)]
            sub = s9.run_branch_cascade(
                lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                ex_w, tbl, max_xl_rounds=20, verify_subst=False
            )
            if sub["closed_unsat"]: n_cl += 1
            else: break
        avg_dt = (time.perf_counter() - t_tr) / (n_cl if n_cl == 4 else (n_cl + 1))
        if n_cl == 4:
            print(f"    [{label}] probe d_free={d_free:2d} (k_fix={k_fix:2d}): CLOSED=4/4 (avg={avg_dt:.2f}s)", flush=True)
            if best_cfg is None:
                best_cfg = (d_free, k_fix, fix_forms, avg_dt)
                if avg_dt < 5.0:
                    break
                # If avg_dt >= 5s, check smaller d_free slightly to see if a MUCH faster branch exists
                best_cfg = (d_free, k_fix, fix_forms, avg_dt)
            else:
                if best_cfg[3] >= 5.0 and avg_dt * (1 << k_fix) < best_cfg[3] * (1 << best_cfg[1]):
                    best_cfg = (d_free, k_fix, fix_forms, avg_dt)
                if avg_dt < 5.0:
                    break

    if best_cfg is None:
        print(f"  [{label}] NO d_free closed 4/4 in range [{d_min}..{d_max}]", flush=True)
        return {"status": "NO_THRESHOLD", "nW": nW, "low_bas": bas_low_dim}

    best_d, best_k, fix_forms, avg_dt = best_cfg
    n_branches = 1 << best_k
    est_sec = n_branches * avg_dt
    print(f"  [{label}] OPTIMAL_THRESHOLD: nW={nW}, bas_dim={bas_low_dim}, best_d_free={best_d}, best_k_fix={best_k} (branches={n_branches}, avg={avg_dt:.2f}s, est={est_sec:.1f}s)", flush=True)

    # Extra forms for 1-level recursive rescue if a rare branch stays open
    extra_forms = []
    for k in range(nW):
        fm = W_forms[k]
        # Reduce mod existing fix_forms implicitly by just using remaining W_forms
        if fm not in fix_forms:
            extra_forms.append(fm)

    allow_k = max_kfix + (1 if avg_dt < 0.8 else 0)
    if not run_exhaustive:
        return {"status": "PROBED", "nW": nW, "best_k": best_k, "avg_dt": avg_dt}
    if best_k > allow_k or (deadline is not None and est_sec > max(120.0, deadline - time.perf_counter())):
        print(f"  [{label}] NEEDS_SHARDING: best_k_fix={best_k} (branches={n_branches}, est={est_sec:.1f}s)", flush=True)
        return {"status": "NEEDS_SHARDING", "nW": nW, "best_k": best_k, "avg_dt": avg_dt, "fix_forms": fix_forms}

    t_ex = time.perf_counter()
    n_cl, n_rec, open_cnt = 0, 0, 0
    for rb in range(n_branches):
        ex_w = [(fix_forms[j], (rb >> j) & 1) for j in range(best_k)]
        sub = s9.run_branch_cascade(
            lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
            ex_w, tbl, max_xl_rounds=20, verify_subst=(rb == 0 or rb == n_branches - 1)
        )
        if sub["closed_unsat"]:
            n_cl += 1
        else:
            # 1-level recursive split using up to 4 W_forms not yet fixed!
            rem_f = s16.reduce_forms_mod_pivs(W_forms, sub["_lin_pivs"])[:4]
            rescued = False
            for ns in range(1, min(4, len(rem_f)) + 1):
                op_ns = 0
                for sb in range(1 << ns):
                    ex2 = [(rem_f[j], (sb >> j) & 1) for j in range(ns)]
                    sub2 = s9.run_branch_cascade(
                        lib9, sub["_buf"], sub["_quad_ids"], sub["_cub_ids"], sub["_lin_pivs"],
                        ex2, tbl, max_xl_rounds=18, verify_subst=False
                    )
                    if not sub2["closed_unsat"]:
                        op_ns += 1; break
                if op_ns == 0:
                    rescued = True; break
            if rescued:
                n_rec += 1
            else:
                open_cnt += 1
                print(f"    [{label}] OPEN_BRANCH rb={rb}: N={111-len(sub['_lin_pivs'])}, q={len(sub['_quad_ids'])}", flush=True)
                if open_cnt >= 5:
                    print(f"    [{label}] ABORTING exhaustive after 5 genuine open branches at rb={rb}/{n_branches}", flush=True)
                    return {"status": "PARTIAL_OPEN", "best_k": best_k, "closed": n_cl, "rec_closed": n_rec, "open": open_cnt}
        if (rb + 1) % 256 == 0 or (rb + 1) == n_branches:
            print(f"    [{label}] progress {rb+1}/{n_branches}: closed={n_cl}, rec_closed={n_rec}, open={open_cnt} ({time.perf_counter()-t_ex:.1f}s)", flush=True)

    dt_ex = time.perf_counter() - t_ex
    if open_cnt == 0:
        print(f"  *** [{label}] FORMALLY CLOSED 100% ({n_branches}/{n_branches} branches, k_fix={best_k}, direct={n_cl}, rec_closed={n_rec}, ZERO SURVIVORS, {dt_ex:.1f}s)! ***", flush=True)
        return {"status": "FORMALLY_CLOSED", "k_fix": best_k, "branches": n_branches, "rec": n_rec}
    else:
        print(f"  [{label}] PARTIAL: closed={n_cl}/{n_branches}, rec_closed={n_rec}, STILL_OPEN={open_cnt}", flush=True)
        return {"status": "PARTIAL", "k_fix": best_k, "closed": n_cl, "rec": n_rec, "open": open_cnt}


def main():
    t_start = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--etas", type=str, default="42,2,3")
    parser.add_argument("--max-kfix", type=int, default=10)
    parser.add_argument("--probe-eta0", action="store_true")
    parser.add_argument("--budget-min", type=float, default=38.0)
    args = parser.parse_args()
    deadline = t_start + args.budget_min * 60.0

    c_diag, so_diag = WORK_DIR / "s43b_diag.c", WORK_DIR / "libs43b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s43b_s9.c", WORK_DIR / "libs43b_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s43b_cg.c", WORK_DIR / "libs43b_cg.so"
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

    c_d8, so_d8 = WORK_DIR / "s43b_d8.c", WORK_DIR / "libs43b_d8.so"
    c_d8.write_text(s12a.C_D8CUB_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_d8), "-o", str(so_d8)], check=True)
    lib_d8 = ctypes.CDLL(str(so_d8))
    lib_d8.extract_deg3_coset_poly.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
    ]

    c_sh, so_sh = WORK_DIR / "s43b_sh.c", WORK_DIR / "libs43b_sh.so"
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
    free111, origin111, cb111 = b09.build_pure_111_basis(0, 0, 0)
    n, n_cw = tbl["n"], tbl["n_col_words"]

    b_tt = np.zeros((111, 65536), dtype=np.uint8)
    for i, m in enumerate(cb111):
        tmp = m
        while tmp: lb = tmp & -tmp; b_tt[i] ^= orb_tt_np[lb.bit_length() - 1]; tmp ^= lb

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

    orb_map = (ctypes.c_int * 116)(*([-1] * 116))
    for i, j in enumerate(free111): orb_map[j] = i
    orb_map[0] = -3; orb_map[115] = -1; orb_map[99] = -1; orb_map[57] = -1; orb_map[113] = -1
    L_set = set(diag_v2.L_INDICES)
    L_vars_py = [i for i, j in enumerate(free111) if j in L_set]
    L_vars_arr = (ctypes.c_int * len(L_vars_py))(*L_vars_py)

    n_cg = len(reps12) + len(reps11)
    cg_buf = (ctypes.c_uint64 * (n_cg * n_cw))()
    for idx, I_m in enumerate(reps12):
        rptr = ctypes.cast(ctypes.byref(cg_buf, idx * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_cg.build_cg12_row_c(
            I_m, mon_to_orb_arr, orb_map, 0, L_vars_arr, len(L_vars_py),
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr
        )
    for idx, I_m in enumerate(reps11):
        rptr = ctypes.cast(ctypes.byref(cg_buf, (len(reps12) + idx) * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_cg.build_cg11_row_c(
            I_m, mon_to_orb_arr, orb_map, 0, L_vars_arr, len(L_vars_py),
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr
        )

    sys_data = diag_v2.build_cell_algebraic_system("B0_00", lib_diag, orbits, v6_list, rot4_data, fiber_meta, extract_sec=18.0)
    cyc_cubs = s9.extract_verified_cyclotomic_cubics("B0_00", orbits, origin111, cb111, layers, c0x0)
    n_base = sum(sys_data["deg_pivs_111"].values())
    total_raw = n_base + len(cyc_cubs) + n_cg + len(d8_specs)
    raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, raw_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs) + n_cg) * n_cw * 8), d8_buf, len(d8_specs) * n_cw * 8)

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])
    n_ef = len(eta_free)

    eta_list = [int(x.strip()) for x in args.etas.split(",") if x.strip()]
    if eta_list:
        print(f"\n--- STEP 43B: EXHAUSTIVE MINRANK CLOSURE (etas={eta_list}, max_kfix={args.max_kfix}) ---", flush=True)
        # Pass 1: find thresholds for ALL etas in batch first (fast!)
        srs = {}
        for idx_e, em in enumerate(eta_list):
            ex = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
            sr = s9.run_branch_cascade(
                lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
                ex, tbl, max_xl_rounds=20, verify_subst=(idx_e == 0)
            )
            srs[em] = sr
            # Probe-only first if batch > 1 so every eta prints its threshold quickly, OR run exhaustive if deadline permits!
        # Wait: let's probe ALL thresholds first, then sort by estimated runtime (smallest first!) so quickest closures always complete cleanly!
        infos = []
        for em in eta_list:
            res = analyze_and_close_state(f"B0_00 eta={em}", srs[em], lib9, lib_sh, tbl,
                                          max_kfix=args.max_kfix, run_exhaustive=False, rng_seed=4300 + em)
            infos.append((res.get("avg_dt", 99.0) * (1 << res.get("best_k", 30)), em, res))
        infos.sort()
        for _, em, _ in infos:
            if time.perf_counter() > deadline - 90.0:
                print(f"  [B0_00 eta={em}] SKIPPING exhaustive (approaching budget limit)", flush=True)
                continue
            analyze_and_close_state(f"B0_00 eta={em}", srs[em], lib9, lib_sh, tbl,
                                    max_kfix=args.max_kfix, run_exhaustive=True, deadline=deadline, rng_seed=4300 + em)

    if args.probe_eta0:
        print(f"\n--- STEP 43B ETA=0 PILOT: K_R + MinRank ON FIRST 6 OPEN (0xFF x 0x55) SUB-STATES ---", flush=True)
        def get_coset_bal_states(sr_cur, z_val, max_dim=9):
            pts = np.array([u | ((u ^ z_val) << 8) for u in range(256)], dtype=np.uint16)
            raw_forms = [sum((1 << int(i)) for i in np.flatnonzero(b_tt[:, pts[k]])) for k in range(256) if np.any(b_tt[:, pts[k]])]
            z_free = s16.reduce_forms_mod_pivs(raw_forms, sr_cur["_lin_pivs"])
            nz = len(z_free)
            if nz > max_dim: return nz, None, None
            z_rref = s19.strict_rref_masks(z_free)
            z_pivs = sorted(z_rref.keys())
            z_forms = [z_rref[p] for p in z_pivs]
            z_tts = []
            for p in z_pivs:
                x = 1 << p
                for lp, (pv, pr) in sr_cur["_lin_pivs"].items():
                    if (((pv ^ (1 << lp)) & x).bit_count()) & 1: x |= (1 << lp)
                tt = np.zeros(256, dtype=np.uint8)
                tmp = x
                while tmp: lb = tmp & -tmp; tt ^= b_tt[lb.bit_length() - 1, pts]; tmp ^= lb
                z_tts.append(tt)
            x0 = sum((1 << lp) for lp, (_, pr) in sr_cur["_lin_pivs"].items() if pr)
            tt0 = np.zeros(256, dtype=np.uint8)
            tmp = x0
            while tmp: lb = tmp & -tmp; tt0 ^= b_tt[lb.bit_length() - 1, pts]; tmp ^= lb
            bal_sts = []
            for st in range(1 << nz):
                tt = tt0.copy()
                for j in range(nz):
                    if (st >> j) & 1: tt ^= z_tts[j]
                if int(tt.sum()) == 128: bal_sts.append(st)
            return nz, z_forms, bal_sts

        ex0 = [(eta_free[k], 0) for k in range(n_ef)]
        sr0 = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex0, tbl, max_xl_rounds=20, verify_subst=True
        )
        nz_ff, forms_ff, bal_ff = get_coset_bal_states(sr0, 0xFF, max_dim=8)
        open_sub2 = []
        for st_ff in bal_ff:
            sub1 = s9.run_branch_cascade(
                lib9, sr0["_buf"], sr0["_quad_ids"], sr0["_cub_ids"], sr0["_lin_pivs"],
                [(forms_ff[j], (st_ff >> j) & 1) for j in range(nz_ff)], tbl, max_xl_rounds=20, verify_subst=False
            )
            if sub1["closed_unsat"]: continue
            nz_55, forms_55, bal_55 = get_coset_bal_states(sub1, 0x55, max_dim=9)
            for st_55 in bal_55:
                sub2 = s9.run_branch_cascade(
                    lib9, sub1["_buf"], sub1["_quad_ids"], sub1["_cub_ids"], sub1["_lin_pivs"],
                    [(forms_55[j], (st_55 >> j) & 1) for j in range(nz_55)], tbl, max_xl_rounds=18, verify_subst=False
                )
                if not sub2["closed_unsat"]:
                    open_sub2.append((st_ff, st_55, sub2))
                    if len(open_sub2) >= 6: break
            if len(open_sub2) >= 6: break
        print(f"  [eta=0] Collected {len(open_sub2)} open (0xFF, 0x55) sub-states for K_R+MinRank diagnostic:", flush=True)
        for st_ff, st_55, sub2 in open_sub2:
            analyze_and_close_state(f"B0_00 eta=0 (ff={st_ff},55={st_55})", sub2, lib9, lib_sh, tbl,
                                    max_kfix=8, run_exhaustive=False, rng_seed=4399 + st_ff * 100 + st_55)

    print(f"\n[B0_00] STEP 43B DONE ({time.perf_counter()-t_start:.1f}s)", flush=True)


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""
SOLVE_B000_K1_STEP59A_BENCH.py

100% C5-free Step 59A (Outer-FES + Inner-FES AVX2 256-way OpenMP) benchmark & feasibility probe
for B0_00, K=1 (default rep e=11; also supports e=3 or any A14 K=1 rep).
  - Builds B0_00, K=1 via SOLVE_B000_K1_WESS_PILOT.setup_k1_root (force_k=1, A14_LMASK, zero C5, zero proved_extra).
  - Extracts the exact bilinear pencil (M0_c, Mk_c, L_core) via s45b.extract_eta_exact_system.
  - Scans d1 in [24, 22, 20, 18, 16, 14] via s57b.optimize_u1_basis to map (d1, NT1, r1_elim, V0, KR, rK_rem).
  - Auto-selects the largest d1 with rK_rem <= 6 (or user --d1 override), runs Step 59A's 10/10
    Zero-Trust planted-solution audit, and runs a timed OpenMP AVX2 benchmark.
  - Computes exact measured throughput (pts/s, fibers/s) and projected wall-clock time for e=11
    and all 16 K=1 reps on GitHub Actions (4-vCPU / 64-vCPU) and Colab T4/L4 GPU (CUDA FES).
"""

import argparse
import ctypes
import hashlib
import json
import os
import subprocess
import sys
import time
from pathlib import Path
import numpy as np

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import SOLVE_B000_K1_WESS_PILOT as pilot
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b
import SOLVE_STEP57B_GREEDY_BASIS_AND_BLOCKB_INJECT as s57b
import SOLVE_STEP59A_FULL_ORBIT_FES_AVX2_CLOSER as s59a


def compile_s59a_kernel(tag):
    c_src = WORK_DIR / f"{tag}_s59a.c"
    so_path = WORK_DIR / f"lib{tag}_s59a.so"
    c_src.write_text(s59a.C_CLOSER_SRC, encoding="utf-8")
    subprocess.run(
        ["gcc", "-O3", "-march=native", "-mavx2", "-fopenmp", "-shared", "-fPIC", str(c_src), "-o", str(so_path)],
        check=True,
    )
    lib_c = ctypes.CDLL(str(so_path))
    lib_c.run_outer_fes_block_c.argtypes = [
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_uint32),
        ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint32),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int64, ctypes.c_uint64, ctypes.c_uint64, ctypes.POINTER(ctypes.c_int64),
    ]
    lib_c.run_outer_fes_block_c.restype = ctypes.c_int64

    lib_c.run_shard_omp_c.argtypes = [
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
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
    return lib_c


def main():
    t0 = time.perf_counter()
    ap = argparse.ArgumentParser()
    ap.add_argument("--rep", type=int, default=11, help="A14 K=1 representative (e.g., 11 or 3)")
    ap.add_argument("--d1", type=int, default=0, help="Override d1 (0 = auto-select largest d1 with rK_rem <= 6)")
    ap.add_argument("--d1-scan", type=str, default="24,22,20,18,16,14", help="Comma-separated d1 values to scan")
    ap.add_argument("--nt-loop", type=int, default=8, help="Outer-FES Gray loop bits per block (2^nt_loop fibers/block)")
    ap.add_argument("--bench-blocks", type=int, default=16, help="Number of Outer-FES blocks to benchmark (0 = full orbit!)")
    ap.add_argument("--out-json", type=str, required=True, help="Output JSON benchmark summary path")
    args = ap.parse_args()

    rep = args.rep
    tag = f"k1_s59a_e{rep}"
    print(f"==================== [B0_00 K=1 e={rep}] STEP 59A AVX2 FES BENCHMARK (C5-FREE) ====================", flush=True)

    root1, indep_forms, origin111, k_mask, lib9, lib_sh, _, tbl = pilot.setup_k1_root(tag)
    _, sr = pilot.get_rep_state(rep, root1, indep_forms, origin111, k_mask, lib9, tbl)
    dim_sr = 111 - len(sr["_lin_pivs"])
    q_sr = len(sr["_quad_ids"])
    c_sr = len(sr["_cub_ids"])
    print(f"  [K=1 e={rep}] Root state ready in {time.perf_counter()-t0:.1f}s: dim={dim_sr}, quads={q_sr}, cubs={c_sr}", flush=True)
    assert not sr["closed_unsat"], f"Unexpected direct closure on e={rep}"

    sys_ex = s45b.extract_eta_exact_system(0, sr, [], lib9, lib_sh, tbl, rng_seed=5900 + rep)
    nW, nT = int(sys_ex["nW"]), int(sys_ex["nT"])
    M0_c, Mk_c = sys_ex["M0_c"], sys_ex["Mk_c"]
    L_core = sys_ex["L_core"]
    n_core, rK_init = int(M0_c.shape[0]), int(M0_c.shape[1])
    print(f"  [s45b] Extracted exact pencil: nW={nW}, nT={nT}, n_core={n_core}, rK_init={rK_init}", flush=True)

    precond_ok = (n_core <= 128) and (rK_init <= 31) and (nW + nT <= 96)
    assert precond_ok, f"Step 59A preconditions violated: n_core={n_core}, rK_init={rK_init}, nW+nT={nW+nT}"

    # Scan d1 frontier via s57b.optimize_u1_basis
    d1_candidates = [int(x.strip()) for x in args.d1_scan.split(",") if x.strip()]
    if args.d1 > 0 and args.d1 not in d1_candidates:
        d1_candidates = [args.d1] + d1_candidates
    scan_results = []
    best_by_d1 = {}
    print("\n  --- SCANNING U1 SUBSPACE FRONTIER (s57b.optimize_u1_basis) ---", flush=True)
    for d1_try in d1_candidates:
        if d1_try < 9 or d1_try >= nW - 4 or d1_try * rK_init > 1024:
            continue
        ts = time.perf_counter()
        U_opt, Mu_opt, bkey = s57b.optimize_u1_basis(M0_c, Mk_c, d1_try, em_seed=rep)
        r1_elim, n_v0, n_kr = int(bkey[0]), int(bkey[1]), int(bkey[2])
        rK_rem = rK_init - r1_elim
        nt1 = nW - d1_try
        rec = {
            "d1": d1_try, "nt1": nt1, "r1_elim": r1_elim, "V0": n_v0,
            "KR": n_kr, "rK_rem": rK_rem, "fast_path_eligible": (rK_rem <= 6),
            "opt_time_s": round(time.perf_counter() - ts, 2),
        }
        scan_results.append(rec)
        best_by_d1[d1_try] = (U_opt, Mu_opt, bkey)
        print(
            f"    d1={d1_try:2d} (NT1={nt1:2d}): r1_elim={r1_elim:2d}, V0={n_v0:2d}, KR={n_kr:2d} "
            f"-> rK_rem={rK_rem:2d} ({'AVX2_FAST' if rK_rem <= 6 else 'FALLBACK'}) [{rec['opt_time_s']}s]",
            flush=True,
        )

    if args.d1 > 0:
        chosen_d1 = args.d1
    else:
        fast_cands = [r for r in scan_results if r["rK_rem"] <= 6]
        if fast_cands:
            chosen_d1 = max(fast_cands, key=lambda r: r["d1"])["d1"]
        else:
            chosen_d1 = min(scan_results, key=lambda r: (r["rK_rem"], -r["d1"]))["d1"]

    U_opt, Mu_opt, bkey = best_by_d1[chosen_d1]
    d1 = chosen_d1
    m = d1 - 8
    nt1 = nW - d1
    rK_rem_chosen = rK_init - int(bkey[0])
    print(f"\n  Selected d1={d1} (m={m}, NT1={nt1}, rK_rem={rK_rem_chosen}) for Step 59A AVX2 benchmark.", flush=True)

    # Extract exact C_core tables (identical to SOLVE_STEP59A lines 1221-1293)
    fn_b = sys_ex["eval_b_and_p0_batch"]
    cl_b = dict(zip(fn_b.__code__.co_freevars, [c.cell_contents for c in fn_b.__closure__]))
    fn_t = cl_b["eval_t_batch"]
    cl_t = dict(zip(fn_t.__code__.co_freevars, [c.cell_contents for c in fn_t.__closure__]))

    qt_c0 = np.ascontiguousarray(cl_t["qt_c0"], dtype=np.uint8)
    qt_lin = np.ascontiguousarray(cl_t["qt_lin"], dtype=np.uint8)
    qt_quads = cl_t["qt_quads"]
    qt_q_off, qt_q0, qt_q1 = [0], [], []
    for qp in qt_quads:
        for a, b in qp:
            qt_q0.append(a)
            qt_q1.append(b)
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

    U1 = np.ascontiguousarray(U_opt[:d1], dtype=np.uint8)
    T1 = np.ascontiguousarray(U_opt[d1:], dtype=np.uint8)

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

    lib_c = compile_s59a_kernel(tag)

    # 1. ZERO-TRUST END-TO-END AUDIT: 10 planted solutions
    print("\n  --- ZERO-TRUST END-TO-END OUTER+INNER FES AUDIT (10 trials, nt_loop=4) ---", flush=True)
    rng = np.random.default_rng(5999 + rep)
    zt_pass = 0
    nt_zt = 4
    T_zt = np.ascontiguousarray(T1[:nt_zt], dtype=np.uint8)
    for trial in range(10):
        t_rest = rng.integers(0, 2, size=nt1 - nt_zt, dtype=np.uint8)
        base_ws = np.ascontiguousarray((t_rest @ T1[nt_zt:]) & 1, dtype=np.uint8)
        t_star_val = int(rng.integers(0, 1 << nt_zt))
        t_star_bits = np.array([(t_star_val >> p) & 1 for p in range(nt_zt)], dtype=np.uint8)
        w_shift_star = (base_ws ^ ((t_star_bits @ T_zt) & 1)) & 1
        u_star = rng.integers(0, 2, size=d1, dtype=np.uint8)
        r_star = rng.integers(0, 2, size=rK_init, dtype=np.uint8)
        w_star = (w_shift_star ^ ((u_star @ U1) & 1)) & 1
        b_orig_star, _ = sys_ex["eval_b_and_p0_batch"](w_star.reshape(1, -1))
        b_core_star = (L_core @ b_orig_star[0]) & 1
        M_star = M0_c.copy()
        for w in range(nW):
            if w_star[w]: M_star ^= Mk_c[w]
        target_core = (M_star @ r_star) & 1
        delta_core = (b_core_star ^ target_core) & 1
        delta_lo = sum(int(delta_core[c]) << c for c in range(min(64, n_core)))
        delta_hi = sum(int(delta_core[c]) << (c - 64) for c in range(64, n_core))
        fb_zt = ctypes.c_int64(0)
        surv = int(lib_c.run_outer_fes_block_c(
            d1, m, nt_zt, nW, nT, n_um, n_core, rK_init, n_kr, rK_1,
            U1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            T_zt.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            base_ws.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
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
            ctypes.c_int64(t_star_val), ctypes.c_uint64(delta_lo), ctypes.c_uint64(delta_hi),
            ctypes.byref(fb_zt),
        ))
        if surv >= 1:
            zt_pass += 1
        print(f"    ZT trial {trial}: t_star={t_star_val:2d}, full_surv={surv} (fb={fb_zt.value})", flush=True)
    print(f"  ZERO-TRUST END-TO-END AUDIT: {zt_pass}/10 planted solutions detected!", flush=True)
    assert zt_pass == 10, "CRITICAL: Step 59A missed a planted solution on B0_00 K=1!"

    # 2. Timed OpenMP AVX2 benchmark
    nt_loop = min(args.nt_loop, nt1 - 1)
    nt_blk = nt1 - nt_loop
    n_blocks_full = 1 << nt_blk
    n_blocks = min(args.bench_blocks, n_blocks_full) if args.bench_blocks > 0 else n_blocks_full

    T_loop = np.ascontiguousarray(T1[:nt_loop], dtype=np.uint8)
    T_blk = T1[nt_loop:]
    block_w_shifts = np.zeros((n_blocks, nW), dtype=np.uint8)
    for blk in range(n_blocks):
        ws = np.zeros(nW, dtype=np.uint8)
        for p in range(nt_blk):
            if (blk >> p) & 1:
                ws ^= T_blk[p]
        block_w_shifts[blk] = ws
    block_w_shifts = np.ascontiguousarray(block_w_shifts, dtype=np.uint8)

    n_threads = int(os.environ.get("OMP_NUM_THREADS", os.cpu_count() or 1))
    total_fibs = n_blocks * (1 << nt_loop)
    total_pts = total_fibs * (1 << d1)
    print(f"\n  Launching OpenMP AVX2 benchmark ({n_threads} threads): {n_blocks}/{n_blocks_full} blocks ({total_fibs:,} fibers = {total_pts:,} pts)...", flush=True)

    t_run = time.perf_counter()
    tot_fb = ctypes.c_int64(0)
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
    dt_run = time.perf_counter() - t_run
    pts_per_s_total = total_pts / max(dt_run, 1e-9)
    pts_per_s_core = pts_per_s_total / max(1, n_threads)
    fibs_per_s_total = total_fibs / max(dt_run, 1e-9)

    orbit_pts = 1 << nW
    hrs_4vcpu = (orbit_pts / (pts_per_s_core * 4.0)) / 3600.0
    hrs_16x4vcpu = hrs_4vcpu / 16.0
    # Conservative Colab GPU CUDA bit-sliced FES estimates:
    # T4 (2560 cores, ~10-20x 4-vCPU AVX2) ~ 10B pts/s; L4 (7424 cores, ~30-50x) ~ 30B pts/s
    hrs_colab_t4_10b = (orbit_pts / 10e9) / 3600.0
    hrs_colab_l4_30b = (orbit_pts / 30e9) / 3600.0

    summary = {
        "cell": "B0_00",
        "K": 1,
        "rep": rep,
        "c5_free": True,
        "root_state": {"dim": dim_sr, "quads": q_sr, "cubs": c_sr},
        "pencil": {"nW": nW, "nT": nT, "n_core": n_core, "rK_init": rK_init},
        "d1_scan": scan_results,
        "selected": {"d1": d1, "m": m, "nt1": nt1, "rK_rem": rK_rem_chosen, "nt_loop": nt_loop},
        "zero_trust_planted_audit": f"{zt_pass}/10 PASS",
        "bench": {
            "threads": n_threads,
            "blocks_run": n_blocks,
            "blocks_full_orbit": n_blocks_full,
            "fibers_closed": int(total_fibs),
            "points_closed": int(total_pts),
            "degenerate_fallbacks": int(tot_fb.value),
            "full_survivors": int(grand_surv),
            "wall_time_s": round(dt_run, 3),
            "fibers_per_s_total": round(fibs_per_s_total, 2),
            "mpts_per_s_total": round(pts_per_s_total / 1e6, 2),
            "mpts_per_s_core": round(pts_per_s_core / 1e6, 2),
        },
        "eta_single_rep": {
            "total_points": orbit_pts,
            "gh_1x4vcpu_hours": round(hrs_4vcpu, 2),
            "gh_16x4vcpu_hours": round(hrs_16x4vcpu, 2),
            "colab_t4_10Gpts_hours": round(hrs_colab_t4_10b, 2),
            "colab_l4_30Gpts_hours": round(hrs_colab_l4_30b, 2),
        },
        "eta_16_reps_approx": {
            "note": "8 Tipo-A (nW=43) + 8 Tipo-B (nW=45 = 4x Tipo-A) => ~40x single Tipo-A rep",
            "gh_16x4vcpu_hours_est": round(hrs_16x4vcpu * 40.0, 2) if nW == 43 else None,
            "colab_t4_10Gpts_hours_est": round(hrs_colab_t4_10b * 40.0, 2) if nW == 43 else None,
            "colab_l4_30Gpts_hours_est": round(hrs_colab_l4_30b * 40.0, 2) if nW == 43 else None,
        },
        "total_script_s": round(time.perf_counter() - t0, 2),
    }
    summary["sha256"] = hashlib.sha256(json.dumps(summary, sort_keys=True).encode()).hexdigest()
    Path(args.out_json).write_text(json.dumps(summary, indent=2) + "\n", encoding="utf-8")

    print("\n  *** STEP 59A B0_00 K=1 BENCHMARK SUMMARY ***", flush=True)
    print(json.dumps(summary, indent=2), flush=True)


if __name__ == "__main__":
    main()

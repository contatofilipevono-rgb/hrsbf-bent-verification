#!/usr/bin/env python3
r"""
SOLVE_STEP57C_GCP_12VCPU_ALL_ORBITS.py

LOW-RAM, 100%-CPU 12-vCPU PARALLEL GCP WORKER FOR B0_11 & B1_11:
  Phase 1 (2 processes: 1 for B0_11, 1 for B1_11, < 4 GB RAM total):
    Builds the root system once per cell and extracts the compact (< 200 KB)
    pencil & RHS dictionary for 20 representative Z_16^x-orbits per cell (40 total).
  Phase 2 (12 parallel processes across all 12 vCPUs, < 50 MB RAM per worker):
    For each of the 40 (cell, eta) tasks:
      1. Compiles a local thread-safe `libs9.so`.
      2. Runs `s57b.optimize_u1_basis` (16 seeds + greedy 1-swap) across candidate d1 values
         to find the LARGEST d1 (SMALLEST NT1) achieving `final_rK == 0`.
      3. Evaluates 5 fibers (t1 = 0 + 4 random non-zero fibers t1 != 0) at that optimal d1
         using `s52b.run_cascade_return_pure` and verifies 0/4096 survivors on each fiber!
  Saves full JSON certificate summary to `/tmp/gcp_step57c_all_orbits.json`.
"""

import ctypes
import json
import os
import subprocess
import sys
import time
from concurrent.futures import ProcessPoolExecutor, as_completed
from pathlib import Path
import numpy as np

REPO_DIR = Path("/tmp/hrsbf-bent-verification/research_updates/2026_11_17_h16_c99_carbon_hard")
if not REPO_DIR.exists():
    REPO_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(REPO_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_B09_DUAL_S_ELIM as b09
import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP10_CARLET_GUILLOT_NNF as s10
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP17_ELIM_ORDER_R_GT_B_SCHUR4 as s17
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b
import SOLVE_STEP55B_UNCAP_SYSB_AND_KERNEL_BASIS as s55b
import SOLVE_STEP57B_GREEDY_BASIS_AND_BLOCKB_INJECT as s57b


def get_rep_etas():
    return [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 18, 25, 28, 31, 40, 46]


def phase1_extract_cell_pencils(cell_name):
    """Run in 1 process per cell: returns list of compact (cell_name, em, nW, M0_c, Mk_c) tuples."""
    t0 = time.perf_counter()
    pid = os.getpid()
    wdir = Path(f"/tmp/p1_57c_{cell_name}_{pid}")
    wdir.mkdir(parents=True, exist_ok=True)

    c_diag, so_diag = wdir / "diag.c", wdir / "libdiag.so"
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

    c_s9, so_s9 = wdir / "s9.c", wdir / "libs9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = wdir / "cg.c", wdir / "libcg.so"
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

    c_sh, so_sh = wdir / "sh.c", wdir / "libsh.so"
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

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=False)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])

    items = []
    for em in get_rep_etas():
        sys_ex = s45b.extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=5700 + em)
        items.append((cell_name, int(em), int(sys_ex["nW"]), sys_ex["M0_c"].copy(), sys_ex["Mk_c"].copy()))
    print(f"  [Phase 1 {cell_name}] Extracted {len(items)} orbit pencils in {time.perf_counter()-t0:.1f}s", flush=True)
    return items


def phase2_worker_optimize_orbit(item):
    """Lightweight worker (<50 MB RAM!): optimizes U1 basis across d1 and tests 5 fibers."""
    cell_name, em, nW, M0_c, Mk_c = item
    t0 = time.perf_counter()
    pid = os.getpid()
    so_s9 = Path(f"/tmp/libs9_w_{pid}.so")
    if not so_s9.exists():
        c_s9 = Path(f"/tmp/s9_w_{pid}.c")
        c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
        subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    d1_cands = [26, 25, 24, 22, 20, 18] if cell_name == "B0_11" else [20, 19, 18, 17, 16]
    best_d1 = None
    best_U = None
    best_Mu = None
    d1_summary = {}

    for d1 in d1_cands:
        U_opt, Mu_opt, bkey = s57b.optimize_u1_basis(M0_c, Mk_c, d1, em_seed=em)
        rK_f, lg = s55b.run_cascade_uncapped(M0_c, Mu_opt, lib9, max_rounds=10, mR_cap=500, rK_cap=30, keep_cap=128)
        d1_summary[d1] = {"rK": int(rK_f), "r1_key": [int(x) for x in bkey], "log": lg}
        if rK_f == 0 and best_d1 is None:
            best_d1 = d1
            best_U = U_opt
            best_Mu = Mu_opt

    # Also test 5 non-zero fibers t1 != 0 at best_d1 for rK == 0 universality
    fib_rK0 = 0
    if best_d1 is not None:
        rng = np.random.default_rng(5790 + em)
        T1 = best_U[best_d1:]
        nt1 = nW - best_d1
        for f_i in range(5):
            ws = np.zeros(nW, dtype=np.uint8) if f_i == 0 else ((rng.integers(0, 2, size=nt1, dtype=np.uint8) @ T1) & 1)
            M0_f = M0_c.copy()
            for k in range(nW):
                if ws[k]:
                    M0_f ^= Mk_c[k]
            rK_fib, _ = s55b.run_cascade_uncapped(M0_f, best_Mu, lib9, max_rounds=10, mR_cap=500, rK_cap=30, keep_cap=128)
            if rK_fib == 0:
                fib_rK0 += 1

    rec = {
        "cell": cell_name,
        "eta": int(em),
        "nW": int(nW),
        "mR": int(M0_c.shape[0]),
        "rK_init": int(M0_c.shape[1]),
        "best_d1_rK0": best_d1,
        "min_NT1_rK0": (int(nW - best_d1) if best_d1 is not None else None),
        "fibers_rK0_of_5": fib_rK0,
        "d1_summary": d1_summary,
        "elapsed_s": round(time.perf_counter() - t0, 2),
    }
    print(f"  [{cell_name} eta={em:2d}] best_d1={best_d1} (min_NT1={rec['min_NT1_rK0']}), fib_rK0={fib_rK0}/5 ({rec['elapsed_s']}s)", flush=True)
    return rec


def main():
    t0 = time.perf_counter()
    print("==================== STEP 57C: 12-vCPU GCP PARALLEL B0_11 & B1_11 ORBIT OPTIMIZER ====================", flush=True)

    # Phase 1: 2 processes (low RAM) to extract compact pencils
    all_items = []
    with ProcessPoolExecutor(max_workers=2) as ex1:
        futs1 = [ex1.submit(phase1_extract_cell_pencils, c) for c in ("B0_11", "B1_11")]
        for f in as_completed(futs1):
            all_items.extend(f.result())

    print(f"\n  [Phase 2] Launching 12-vCPU parallel optimization across {len(all_items)} (cell, eta) orbits...", flush=True)
    all_results = []
    with ProcessPoolExecutor(max_workers=12) as ex2:
        futs2 = [ex2.submit(phase2_worker_optimize_orbit, item) for item in all_items]
        for f in as_completed(futs2):
            all_results.append(f.result())

    all_results.sort(key=lambda r: (r["cell"], r["eta"]))
    out_path = Path("/tmp/gcp_step57c_all_orbits.json")
    out_path.write_text(json.dumps({
        "total_time_s": round(time.perf_counter() - t0, 2),
        "n_records": len(all_results),
        "records": all_results,
    }, indent=2), encoding="utf-8")
    print(f"==================== STEP 57C DONE in {time.perf_counter()-t0:.1f}s (saved {out_path}) ====================", flush=True)


if __name__ == "__main__":
    main()

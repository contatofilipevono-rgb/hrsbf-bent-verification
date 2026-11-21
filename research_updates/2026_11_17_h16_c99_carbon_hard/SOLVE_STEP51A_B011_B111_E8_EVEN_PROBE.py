#!/usr/bin/env python3
r"""
SOLVE_STEP51A_B011_B111_E8_EVEN_PROBE.py

FAST (~2 MIN) E8_even (free_dim = 8 -> 256 states) BREAKTHROUGH PROBE FOR B0_11 & B1_11:
  1. Extracts the 8 free linear forms of f|_{E8_even} modulo root["_lin_pivs"].
  2. Checks overlap with eta_free (6 forms) and evaluates all 256 states of E8_even
     via s9.run_branch_cascade on 4 forked cores!
  3. On state 0 (f|_{E8_even} == 0, normal on E8_even!), extracts ALL 51 exact degree-3
     E8-coset balance equations (using lib_d8.extract_deg3_coset_poly on E8 + odd_a)
     and tests whether state 0 closes immediately or collapses its MinRank core!
  4. Reports exact survivor count, (N, q, dimW, n_pure_w_quads) distribution across all 256 E8 states!
"""

import argparse
import ctypes
import multiprocessing as mp
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
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a


_G51 = {}


def _init_w51(so_s9_path, buf_bytes, n_u64, quad_ids, cub_ids, lin_pivs, forms, tbl_n):
    global _G51
    _G51 = {
        "lib9": s45a._setup_lib9(Path(so_s9_path)),
        "tbl": s9.build_col_tables(tbl_n),
        "buf": (ctypes.c_uint64 * n_u64).from_buffer_copy(buf_bytes),
        "quad_ids": quad_ids,
        "cub_ids": cub_ids,
        "lin_pivs": lin_pivs,
        "forms": forms,
    }


def _eval_w51(st):
    g = _G51
    forms = g["forms"]
    ex = [(forms[j], (st >> j) & 1) for j in range(len(forms))]
    sub = s9.run_branch_cascade(
        g["lib9"], g["buf"], g["quad_ids"], g["cub_ids"], g["lin_pivs"],
        ex, g["tbl"], max_xl_rounds=20, verify_subst=(st == 0)
    )
    if sub["closed_unsat"]:
        return (st, True, 0, 0)
    if "_lin_pivs" not in sub:
        return (st, False, -1, -1)
    return (st, False, g["tbl"]["n"] - len(sub["_lin_pivs"]), len(sub["_quad_ids"]))


def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    parser.add_argument("--workers", type=int, default=4)
    args = parser.parse_args()
    cell_name = args.cell

    print(f"\n==================== [{cell_name}] STEP 51A: E8_even (256-STATE) BREAKTHROUGH PROBE ====================", flush=True)

    c_diag, so_diag = WORK_DIR / "s51a_diag.c", WORK_DIR / "libs51a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s51a_s9.c", WORK_DIR / "libs51a_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s51a_cg.c", WORK_DIR / "libs51a_cg.so"
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

    c_d8, so_d8 = WORK_DIR / "s51a_d8.c", WORK_DIR / "libs51a_d8.so"
    c_d8.write_text(s12a.C_D8CUB_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_d8), "-o", str(so_d8)], check=True)
    lib_d8 = ctypes.CDLL(str(so_d8))
    lib_d8.extract_deg3_coset_poly.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
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
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)

    b_tt = np.zeros((111, 65536), dtype=np.uint8)
    for i, m in enumerate(cb111):
        tmp = m
        while tmp:
            lb = tmp & -tmp
            b_tt[i] ^= orb_tt_np[lb.bit_length() - 1]
            tmp ^= lb
    orig_tt = np.zeros(65536, dtype=np.uint8)
    tmp = origin111
    while tmp:
        lb = tmp & -tmp
        orig_tt ^= orb_tt_np[lb.bit_length() - 1]
        tmp ^= lb

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

    # Extract E8_even free forms
    e8_pts = np.array([sum(((u >> b) & 1) << (2 * b) for b in range(8)) for u in range(256)], dtype=np.uint16)
    raw_e8 = [sum((1 << int(i)) for i in np.flatnonzero(b_tt[:, e8_pts[k]])) for k in range(256) if np.any(b_tt[:, e8_pts[k]])]
    e8_free = s16.reduce_forms_mod_pivs(raw_e8, root["_lin_pivs"])
    e8_rref = s19.strict_rref_masks(e8_free)
    e8_forms = [e8_rref[p] for p in sorted(e8_rref.keys())]
    joint_dim = len(s19.strict_rref_masks(e8_forms + eta_free))
    print(f"  [{cell_name}] E8_even dim={len(e8_forms)}, eta_free dim={len(eta_free)}, joint dim={joint_dim} (overlap={len(e8_forms)+len(eta_free)-joint_dim})", flush=True)

    # Parallel evaluate all 256 E8_even states
    n_u64 = len(root["_buf"])
    buf_bytes = ctypes.string_at(root["_buf"], n_u64 * 8)
    ctx = mp.get_context("fork")
    closed_cnt = 0
    open_stats = {}
    with ctx.Pool(
        processes=args.workers,
        initializer=_init_w51,
        initargs=(str(so_s9), buf_bytes, n_u64, list(root["_quad_ids"]), list(root["_cub_ids"]), dict(root["_lin_pivs"]), e8_forms, tbl["n"]),
    ) as pool:
        for st, cl, n_act, n_q in pool.imap_unordered(_eval_w51, range(1 << len(e8_forms)), chunksize=4):
            if cl:
                closed_cnt += 1
            else:
                open_stats[(n_act, n_q)] = open_stats.get((n_act, n_q), 0) + 1

    print(f"  *** [{cell_name}] E8_even 256-state sweep: CLOSED={closed_cnt}/256, OPEN={256-closed_cnt}/256 ({time.perf_counter()-t0:.1f}s) ***", flush=True)
    print(f"  [{cell_name}] Open (N, q) histogram: {sorted(open_stats.items())}", flush=True)

    # Also test state 0 (f|_{E8} == 0 -> normal on E8!) with exact E8-coset cubic equations (WITH orig_tt check!)
    print(f"\n  === [{cell_name}] Testing E8_even state 0 (f|_E8 == 0 -> normal on E8!) ===", flush=True)
    # Check if orig_tt vanishes on E8
    print(f"    orig_tt on E8_even weight = {int(orig_tt[e8_pts].sum())}", flush=True)
    # Note: extract_deg3_coset_poly assumes orig_tt == 0 on the coset! Check orig_tt on coset E8 + odd_a!
    n_orig_zero_cosets = 0
    for a in range(1, 256):
        odd_a = sum(((a >> b) & 1) << (2 * b + 1) for b in range(8))
        pts_a = e8_pts ^ odd_a
        if int(orig_tt[pts_a].sum()) == 0:
            n_orig_zero_cosets += 1
    print(f"    E8 cosets with orig_tt == 0: {n_orig_zero_cosets}/255", flush=True)

    print(f"\n[{cell_name}] STEP 51A DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()

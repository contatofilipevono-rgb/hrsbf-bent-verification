#!/usr/bin/env python3
r"""
SOLVE_STEP34A_B11_COSET_AND_C16_SPLIT.py

TESTS C_16-INVARIANT COSET SPLITTING (z = 0xFF, z = 0x55, z = 0x33, z = 0x0F)
ON B1_11 AND B0_11 (eta = 0)!
  - In B0_00, simply branching on the 3 C_16-invariant linear forms of z = 0xFF
    (2^3 = 8 branches, WITHOUT even using balancedness!) CLOSED eta=62, 63, 22, 43 directly to 1 = 0!
  - Here we test whether the exact same C_16-invariant coset linear forms (z = 0xFF, 0x55, 0x33, 0x0F)
    exist in B1_11 and B0_11, how they intersect W_ess vs R_free, and whether branching on them
    triggers a cascade collapse or dimW drop in B1_11 / B0_11!
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
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19


def gf2_rank(masks):
    p = {}
    for m in masks:
        v = m
        while v:
            b = v.bit_length() - 1
            if b in p: v ^= p[b]
            else: p[b] = v; break
    return len(p)


def run_cell(cell_name, lib_diag, lib9, lib_cg, orbits, layer_vecs, orb_tt_np,
             v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 34A: C_16-INVARIANT COSET SPLIT PROBE ====================", flush=True)
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

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=15, verify_subst=False)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])
    ex0 = [(eta_free[k], 0) for k in range(len(eta_free))]
    sr = s9.run_branch_cascade(
        lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
        ex0, tbl, max_xl_rounds=20, verify_subst=True
    )
    qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
    ana = s16.analyze_quad_system(qps)
    W_forms = list(ana["W_piv"].values())
    print(f"  [{cell_name} eta=0] Baseline: N_act={111-len(sr['_lin_pivs'])}, q={len(qps)}, dimW={len(W_forms)}", flush=True)

    # Build basis truth tables b_tt[111, 65536]
    b_tt = np.zeros((111, 65536), dtype=np.uint8)
    for i in range(111):
        m = cb111[i]
        acc = np.zeros(65536, dtype=np.uint8)
        for o in range(116):
            if (m >> o) & 1: acc ^= orb_tt_np[o]
        b_tt[i] = acc

    # Inspect C_16 / C_8 / C_4 invariant D_8-cosets: z = 0xFF, 0x55, 0x33, 0x0F, 0x11, 0x77
    for z_name, z_val in [("0xFF", 0xFF), ("0x55", 0x55), ("0x33", 0x33), ("0x0F", 0x0F), ("0x11", 0x11), ("0x77", 0x77)]:
        pts = np.array([u | ((u ^ z_val) << 8) for u in range(256)], dtype=np.uint16)
        raw_forms = [sum((1 << int(i)) for i in np.flatnonzero(b_tt[:, pts[k]])) for k in range(256) if np.any(b_tt[:, pts[k]])]
        z_free = s16.reduce_forms_mod_pivs(raw_forms, sr["_lin_pivs"])
        nz = len(z_free)
        # Compute intersection with W_ess!
        r_w = gf2_rank(W_forms)
        r_zw = gf2_rank(W_forms + z_free)
        in_w = nz - (r_zw - r_w)
        print(f"  [{cell_name}] coset z={z_name}: free_forms={nz:2d} | inside_W_ess={in_w:2d}, outside_W_ess={r_zw - r_w:2d}", flush=True)

        # Branch on z=0xFF (exhaustive if <= 6, else 32 random states) and check cascade collapse!
        if z_name in ("0xFF", "0x55") and nz > 0:
            z_rref = s19.strict_rref_masks(z_free)
            z_pivs = sorted(z_rref.keys())
            z_forms = [z_rref[p] for p in z_pivs]
            n_test = (1 << nz) if nz <= 5 else 32
            rng = random.Random(3434)
            states = list(range(1 << nz)) if nz <= 5 else [rng.getrandbits(nz) for _ in range(n_test)]
            n_cl, min_N, max_q, min_dw = 0, 999, 0, 999
            for idx_s, st in enumerate(states):
                ex_z = [(z_forms[j], (st >> j) & 1) for j in range(nz)]
                sub = s9.run_branch_cascade(
                    lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                    ex_z, tbl, max_xl_rounds=15, verify_subst=(idx_s == 0)
                )
                if sub["closed_unsat"]:
                    n_cl += 1
                else:
                    na = 111 - len(sub["_lin_pivs"])
                    nq = len(sub["_quad_ids"])
                    nqps = [s9.row_to_pset(sub["_buf"], qr, tbl) for qr in sub["_quad_ids"]]
                    ndw = s16.analyze_quad_system(nqps)["dim_W_ess"] if nqps else 0
                    min_N = min(min_N, na); max_q = max(max_q, nq); min_dw = min(min_dw, ndw)
            print(
                f"    -> branch on z={z_name} ({n_test} states): CLOSED={n_cl}/{n_test} | "
                f"min_N={min_N}, max_q={max_q}, min_dimW={min_dw}",
                flush=True,
            )

    # Also test joint z=0xFF + z=0x55 (32 random states) to see if combining both triggers a cascade!
    pts_ff = np.array([u | ((u ^ 0xFF) << 8) for u in range(256)], dtype=np.uint16)
    pts_55 = np.array([u | ((u ^ 0x55) << 8) for u in range(256)], dtype=np.uint16)
    rf_both = ([sum((1 << int(i)) for i in np.flatnonzero(b_tt[:, pts_ff[k]])) for k in range(256) if np.any(b_tt[:, pts_ff[k]])] +
               [sum((1 << int(i)) for i in np.flatnonzero(b_tt[:, pts_55[k]])) for k in range(256) if np.any(b_tt[:, pts_55[k]])])
    zb = s16.reduce_forms_mod_pivs(rf_both, sr["_lin_pivs"])
    zb_rref = s19.strict_rref_masks(zb)
    zb_pivs = sorted(zb_rref.keys())
    zb_forms = [zb_rref[p] for p in zb_pivs]
    nzb = len(zb_forms)
    rng = random.Random(3455)
    n_cl, min_N, max_q, min_dw = 0, 999, 0, 999
    for idx_s in range(32):
        st = rng.getrandbits(nzb)
        ex_z = [(zb_forms[j], (st >> j) & 1) for j in range(nzb)]
        sub = s9.run_branch_cascade(
            lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
            ex_z, tbl, max_xl_rounds=15, verify_subst=(idx_s == 0)
        )
        if sub["closed_unsat"]: n_cl += 1
        else:
            na = 111 - len(sub["_lin_pivs"])
            nq = len(sub["_quad_ids"])
            nqps = [s9.row_to_pset(sub["_buf"], qr, tbl) for qr in sub["_quad_ids"]]
            ndw = s16.analyze_quad_system(nqps)["dim_W_ess"] if nqps else 0
            min_N = min(min_N, na); max_q = max(max_q, nq); min_dw = min(min_dw, ndw)
    print(
        f"  [{cell_name}] joint z=0xFF+0x55 (free={nzb}, 32 rand states): CLOSED={n_cl}/32 | "
        f"min_N={min_N}, max_q={max_q}, min_dimW={min_dw}",
        flush=True,
    )
    print(f"[{cell_name}] STEP 34A DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B1_11,B0_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s34a_diag.c", WORK_DIR / "libs34a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s34a_s9.c", WORK_DIR / "libs34a_s9.so"
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
    lib9.mul_deg2_row_by_var.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
    ]
    lib9.gf2_echelon_insert_s9.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib9.gf2_echelon_insert_s9.restype = ctypes.c_int
    lib9.eval_row_s9.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_uint64, ctypes.c_uint64,
    ]
    lib9.eval_row_s9.restype = ctypes.c_int

    c_cg, so_cg = WORK_DIR / "s34a_cg.c", WORK_DIR / "libs34a_cg.so"
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

    for cell in [c.strip() for c in args.cells.split(",") if c.strip()]:
        run_cell(
            cell, lib_diag, lib9, lib_cg, orbits, layer_vecs, orb_tt_np,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()

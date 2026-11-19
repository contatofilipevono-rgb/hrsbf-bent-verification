#!/usr/bin/env python3
r"""
SOLVE_STEP14_ETA128_SPLIT_ON_CG389.py

Tests splitting each open cell (B0_00, B0_11, B1_11) across ALL 2^7 = 128 values of the
7-dimensional diagonal-autocorrelation quotient eta(c) (the degree-3-in-u part of f(u, u+z)
governing EVERY bilinear form B_{r,z} in A_f((r,r)) = 0!), ON TOP OF:
  - the full root system (4..6 quads + 388..389 Carlet-Guillot cubics), AND
  - the surviving linearized branch (N=104..106)!

Measures for every cell:
  1. How many of the 128 eta classes are ALREADY closed algebraically (1=0) by root + CG(389)?
  2. How many surviving eta classes drop NEW linear pivots or NEW quadratics?
  3. On any surviving eta class that drops new quadratics, runs recursive symplectic splitting!
"""

import argparse
import ctypes
import json
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


def build_orb_eta(orbits):
    tri_idx, cnt_t = {}, 0
    for a in range(8):
        for b in range(a + 1, 8):
            for c in range(b + 1, 8):
                for d in range(8):
                    if d not in (a, b, c):
                        tri_idx[(a, b, c, d)] = cnt_t
                        cnt_t += 1
    orb_eta = [0] * 116
    for j, orb in enumerate(orbits):
        vec = 0
        for m in orb:
            bits = [b for b in range(16) if (m >> b) & 1]
            mods = [b & 7 for b in bits]
            if len(set(mods)) != 4:
                continue
            mod_set = set(mods)
            for b in bits:
                if b >= 8:
                    d = b - 8
                    tri = tuple(sorted(mod_set - {d}))
                    vec ^= (1 << tri_idx[(tri[0], tri[1], tri[2], d)])
        orb_eta[j] = vec
    return orb_eta


def run_step14_cell(cell_name, lib_diag, lib9, lib_cg, orbits, orb_eta,
                    v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 14: ALL 128 ETA(c) CLASSES ON ROOT + CG(389) ====================", flush=True)
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    n, n_cw = tbl["n"], tbl["n_col_words"]

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

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=5, verify_subst=False)

    # Extract the 7 linear forms of eta(c) in 111-var space
    basis_eta = []
    for cm in cb111:
        v = 0
        while cm:
            lb = cm & -cm; v ^= orb_eta[lb.bit_length() - 1]; cm ^= lb
        basis_eta.append(v)

    # Find 7 independent coordinate rows of eta
    piv = {}
    eta_forms_111 = []
    for bit in range(280):
        fm = sum((1 << i) for i in range(111) if (basis_eta[i] >> bit) & 1)
        if fm == 0:
            continue
        rem = fm
        while rem:
            b = rem.bit_length() - 1
            if b in piv: rem ^= piv[b]
            else:
                piv[b] = rem
                eta_forms_111.append(fm)
                break
    assert len(eta_forms_111) == 7, f"Expected 7 eta forms, got {len(eta_forms_111)}"

    # Reduce eta_forms_111 modulo root linear pivots!
    root_eta_free = []
    rp = {}
    for fm in eta_forms_111:
        m = fm
        for p, (pv, pr) in root["_lin_pivs"].items():
            if (m >> p) & 1: m ^= pv
        rem = m
        while rem:
            b = rem.bit_length() - 1
            if b in rp: rem ^= rp[b]
            else:
                rp[b] = rem
                root_eta_free.append(m)
                break
    print(f"[{cell_name}] Root N={root['N_active']}, quads={root['n_quad_surviving']}, cubics={root['n_genuine_cubics']}; "
          f"eta_free_at_root={len(root_eta_free)}/7 ({1<<len(root_eta_free)} states)!", flush=True)

    # Test ALL 2^{len(root_eta_free)} states of eta AT ROOT (with root quads + 388 CG cubics)!
    tot_root = 1 << len(root_eta_free)
    r_closed = 0
    r_q_hist = {}
    r_l_hist = {}
    r_max_q = 0
    r_max_l = 0
    for em in range(tot_root):
        ex = [(root_eta_free[k], (em >> k) & 1) for k in range(len(root_eta_free))]
        sr = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex, tbl, max_xl_rounds=5, verify_subst=False
        )
        if sr["closed_unsat"]:
            r_closed += 1
        else:
            q = sr["n_quad_surviving"]
            l = sr["total_lin_dropped"]
            r_q_hist[q] = r_q_hist.get(q, 0) + 1
            r_l_hist[l] = r_l_hist.get(l, 0) + 1
            r_max_q = max(r_max_q, q)
            r_max_l = max(r_max_l, l)

    print(f"[{cell_name}] ROOT x {tot_root} ETA STATES: closed={r_closed}/{tot_root}, "
          f"q_hist={r_q_hist}, lin_drop_hist={r_l_hist} (max_q={r_max_q}, max_l={r_max_l})", flush=True)

    # Also test ALL eta states INSIDE the first surviving linearized branch (0 quads)!
    root_quad_psets = [s9.row_to_pset(root["_buf"], qr, tbl) for qr in root["_quad_ids"]]
    forms = s9.find_minimal_linearizers(root_quad_psets, n)["linearizer_forms_111"]
    k_lin = len(forms)
    target_br, target_bm = None, None
    for bm in range(1 << k_lin):
        bres = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            [(forms[i], (bm >> i) & 1) for i in range(k_lin)], tbl, max_xl_rounds=5, verify_subst=False
        )
        if not bres["closed_unsat"]:
            target_br, target_bm = bres, bm
            break

    br_eta_free = []
    bp = {}
    for fm in eta_forms_111:
        m = fm
        for p, (pv, pr) in target_br["_lin_pivs"].items():
            if (m >> p) & 1: m ^= pv
        rem = m
        while rem:
            b = rem.bit_length() - 1
            if b in bp: rem ^= bp[b]
            else:
                bp[b] = rem
                br_eta_free.append(m)
                break
    tot_br = 1 << len(br_eta_free)
    b_closed, b_q_hist, b_l_hist = 0, {}, {}
    for em in range(tot_br):
        ex = [(br_eta_free[k], (em >> k) & 1) for k in range(len(br_eta_free))]
        sr = s9.run_branch_cascade(
            lib9, target_br["_buf"], target_br["_quad_ids"], target_br["_cub_ids"], target_br["_lin_pivs"],
            ex, tbl, max_xl_rounds=5, verify_subst=False
        )
        if sr["closed_unsat"]:
            b_closed += 1
        else:
            q = sr["n_quad_surviving"]; l = sr["total_lin_dropped"]
            b_q_hist[q] = b_q_hist.get(q, 0) + 1
            b_l_hist[l] = b_l_hist.get(l, 0) + 1

    print(f"[{cell_name}] BRANCH {target_bm:0{k_lin}b} x {tot_br} ETA STATES: closed={b_closed}/{tot_br}, "
          f"q_hist={b_q_hist}, lin_drop_hist={b_l_hist}", flush=True)

    summary = {
        "cell": cell_name,
        "root_eta": {"free": len(root_eta_free), "total": tot_root, "closed": r_closed, "q_hist": r_q_hist, "l_hist": r_l_hist},
        "branch_eta": {"branch": target_bm, "free": len(br_eta_free), "total": tot_br, "closed": b_closed, "q_hist": b_q_hist, "l_hist": b_l_hist},
        "elapsed_sec": round(time.perf_counter() - t0, 2),
    }
    print(f"[{cell_name}] STEP 14 SUMMARY: {json.dumps(summary)}", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s14_diag.c", WORK_DIR / "libs14_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s14_s9.c", WORK_DIR / "libs14_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s14_cg.c", WORK_DIR / "libs14_cg.so"
    c_cg.write_text(s10.C_CG_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_cg), "-o", str(so_cg)], check=True)
    lib_cg = ctypes.CDLL(str(so_cg))
    for fn in (lib_cg.build_cg12_row_c, lib_cg.build_cg11_row_c):
        fn.argtypes = [
            ctypes.c_int, ctypes.POINTER(ctypes.c_int16),
            ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.c_int,
            ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
            ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
            ctypes.POINTER(ctypes.c_uint64),
        ]

    orbits = diag_v2.build_orbits_116()
    orb_eta = build_orb_eta(orbits)
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
        run_step14_cell(
            cname, lib_diag, lib9, lib_cg, orbits, orb_eta,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
r"""
SOLVE_STEP50A_B011_B111_COSET_PARSEVAL_AND_CASCADE.py

POISSON-SUMMATION / PARSEVAL D8-COSET SPECTRUM + CASCADE PROBE FOR B0_11 AND B1_11:
  For any bent function f on F_2^16, on the self-dual 8-dim subspace D_8 = {(u, u)}:
      S(a) = sum_{u in F_2^8} (-1)^{f(u, u ^ a)} = W_h(a),
  where W_f(v, v) = 256 * (-1)^{h(v)} is the restriction of the dual bent function to D_8.
  Therefore:
    1. S(0) is FIXED by (c57=1, c113=1) on B0_11 and B1_11!
    2. Parseval: sum_{a in F_2^8} S(a)^2 = 65536.
       Since S(a) is C_8-invariant: S(0)^2 + S(0xFF)^2 + 2*S(0x55)^2 + 4*S(0x33)^2 + ... = 65536.
    3. Moreover, h(v) is C_8-rotation-symmetric, so W_h(0xFF) = sum_v (-1)^{h(v) ^ popcount(v)}
       and W_h(0x55) satisfy exact C_8-orbit parity/mod constraints!
  This script computes:
    - Exact S(0) for B0_11 and B1_11 (including affine origin111!)
    - Exact S(0xFF) spectrum across all 2^3 = 8 states of 0xFF (and which close directly under s9 cascade!)
    - Exact S(0x55) spectrum across all 2^7 = 128 states of 0x55 (and which survive Parseval + s9 cascade!)
    - Exact quadratic & MinRank core shape after fixing (0xFF, 0x55) on B0_11 and B1_11 (eta = 0, 1, 4, 5)!
"""

import argparse
import ctypes
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
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a


def get_coset_spectrum(sr_cur, z_val, b_tt, orig_tt, max_dim=10):
    """Exact affine evaluation of f(u, u^z_val) = orig_tt + sum x_i b_tt[i] over all 2^nz free states."""
    pts = np.array([u | ((u ^ z_val) << 8) for u in range(256)], dtype=np.uint16)
    raw_forms = [
        sum((1 << int(i)) for i in np.flatnonzero(b_tt[:, pts[k]]))
        for k in range(256)
        if np.any(b_tt[:, pts[k]])
    ]
    z_free = s16.reduce_forms_mod_pivs(raw_forms, sr_cur["_lin_pivs"])
    nz = len(z_free)
    if nz > max_dim:
        return nz, None, None
    z_rref = s19.strict_rref_masks(z_free)
    z_pivs = sorted(z_rref.keys())
    z_forms = [z_rref[p] for p in z_pivs]
    z_tts = []
    for p in z_pivs:
        x = 1 << p
        for lp, (pv, _) in sr_cur["_lin_pivs"].items():
            if (((pv ^ (1 << lp)) & x).bit_count()) & 1:
                x |= (1 << lp)
        tt = np.zeros(256, dtype=np.uint8)
        tmp = x
        while tmp:
            lb = tmp & -tmp
            tt ^= b_tt[lb.bit_length() - 1, pts]
            tmp ^= lb
        z_tts.append(tt)
    x0 = sum((1 << lp) for lp, (_, pr) in sr_cur["_lin_pivs"].items() if pr)
    tt0 = orig_tt[pts].copy()
    tmp = x0
    while tmp:
        lb = tmp & -tmp
        tt0 ^= b_tt[lb.bit_length() - 1, pts]
        tmp ^= lb
    spec = []
    for st in range(1 << nz):
        tt = tt0.copy()
        for j in range(nz):
            if (st >> j) & 1:
                tt ^= z_tts[j]
        wt = int(tt.sum())
        S_val = 256 - 2 * wt
        spec.append((st, wt, S_val))
    return nz, z_forms, spec


def run_probe(cell_name, etas):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 50A: D8-COSET PARSEVAL + CASCADE PROBE ====================", flush=True)

    c_diag, so_diag = WORK_DIR / "s50a_diag.c", WORK_DIR / "libs50a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s50a_s9.c", WORK_DIR / "libs50a_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s50a_cg.c", WORK_DIR / "libs50a_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s50a_sh.c", WORK_DIR / "libs50a_sh.so"
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

    # Check S(0) on D_8!
    nz0, _, spec0 = get_coset_spectrum(root, 0x00, b_tt, orig_tt, max_dim=4)
    print(f"  [{cell_name}] Diagonal z=0x00: nz={nz0}, spec={spec0}", flush=True)
    S0 = spec0[0][2] if spec0 else None
    rem_parseval = 65536 - (S0 * S0 if S0 is not None else 0)
    print(f"  [{cell_name}] S(0)={S0}, remaining Parseval budget sum_{{a!=0}} S(a)^2 = {rem_parseval}", flush=True)

    for em in etas:
        ex_eta = [(eta_free[k], (em >> k) & 1) for k in range(len(eta_free))]
        sr = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex_eta, tbl, max_xl_rounds=20, verify_subst=(em == etas[0])
        )
        if sr["closed_unsat"]:
            print(f"  [{cell_name} eta={em}] CLOSED AT ROOT!", flush=True)
            continue

        nz_ff, forms_ff, spec_ff = get_coset_spectrum(sr, 0xFF, b_tt, orig_tt, max_dim=8)
        print(f"\n  === [{cell_name} eta={em}] 0xFF (nz={nz_ff}) ===", flush=True)
        for st_ff, wt_ff, s_ff in spec_ff:
            pars_ok = (s_ff * s_ff <= rem_parseval)
            sub1 = s9.run_branch_cascade(
                lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                [(forms_ff[j], (st_ff >> j) & 1) for j in range(nz_ff)], tbl, max_xl_rounds=20, verify_subst=False
            )
            if sub1["closed_unsat"]:
                print(f"    ff={st_ff}: wt={wt_ff}, S={s_ff} (pars_ok={pars_ok}) -> CLOSED DIRECT!", flush=True)
            else:
                n_act1 = n - len(sub1["_lin_pivs"])
                n_q1 = len(sub1["_quad_ids"])
                nz_55, forms_55, spec_55 = get_coset_spectrum(sub1, 0x55, b_tt, orig_tt, max_dim=10)
                rem_after_ff = rem_parseval - s_ff * s_ff
                pars_55 = [x for x in spec_55 if 2 * x[2] * x[2] <= rem_after_ff] if spec_55 else []
                s55_vals = sorted({x[2] for x in spec_55}) if spec_55 else []
                print(
                    f"    ff={st_ff}: wt={wt_ff}, S={s_ff} (pars_ok={pars_ok}) -> OPEN(N={n_act1}, q={n_q1}) | "
                    f"0x55 nz={nz_55}, pars_surv={len(pars_55)}/{len(spec_55) if spec_55 else '?'}, S_55_vals={s55_vals[:12]}",
                    flush=True,
                )
                # Test cascade on first 8 Parseval-valid 0x55 states of ff=0!
                if st_ff == 0 and forms_55 is not None:
                    cl55 = 0
                    minN2 = 999
                    maxQ2 = 0
                    for st55, wt55, s55 in pars_55[:16]:
                        sub2 = s9.run_branch_cascade(
                            lib9, sub1["_buf"], sub1["_quad_ids"], sub1["_cub_ids"], sub1["_lin_pivs"],
                            [(forms_55[j], (st55 >> j) & 1) for j in range(nz_55)], tbl, max_xl_rounds=20, verify_subst=False
                        )
                        if sub2["closed_unsat"]:
                            cl55 += 1
                        elif "_lin_pivs" in sub2:
                            minN2 = min(minN2, n - len(sub2["_lin_pivs"]))
                            maxQ2 = max(maxQ2, len(sub2["_quad_ids"]))
                        del sub2
                    print(f"      -> [0x55 sample 16]: closed={cl55}/16, min_N2={minN2}, max_q2={maxQ2}", flush=True)
            del sub1

    print(f"\n[{cell_name}] STEP 50A DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    parser.add_argument("--etas", type=str, default="0,1,4,5")
    args = parser.parse_args()
    run_probe(args.cell, [int(x) for x in args.etas.split(",") if x.strip()])


if __name__ == "__main__":
    main()

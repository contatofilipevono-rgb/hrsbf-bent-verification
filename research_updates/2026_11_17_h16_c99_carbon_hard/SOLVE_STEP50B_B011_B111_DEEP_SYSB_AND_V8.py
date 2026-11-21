#!/usr/bin/env python3
r"""
SOLVE_STEP50B_B011_B111_DEEP_SYSB_AND_V8.py

FAST (~3 MIN) DUAL PROBE FOR B0_11 AND B1_11:
  1. Scans C_8-invariant 8-dimensional linear subspaces V_8 of F_2^16 (E_8, O_8,
     {(u, rot8^k(u))} for k=0..7, etc.) to check if f|_{V_8} is fixed or low-dim
     (which would unlock brand-new D8-style cubic equations for B0_11 / B1_11!).
  2. Runs Step 47B's Zero-Trust verified Iterative SysB + V0 + NT0_Polar + K_R
     cascade at d1 = 22, 20, 18, 16 on eta = 0, 1, 4, 5 to find the exact minimum
     NT1 = nW - d1 where rK -> 0 (100% elimination of all r_C variables!) on every
     orbit of B0_11 and B1_11.
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
import SOLVE_STEP44A_ITERATED_POLAR_TOWER as s44a
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b
import SOLVE_STEP47B_ITERATIVE_SYSB_CASCADE as s47b


def rot8(u, k):
    k &= 7
    return ((u << k) | (u >> (8 - k))) & 0xFF


def check_v8_subspaces(cell_name, root, b_tt, orig_tt):
    """Check free dimension and weight of f|_{V_8} on canonical C_8-invariant 8-dim subspaces."""
    print(f"\n  === [{cell_name}] 1. C8-INVARIANT 8-DIM SUBSPACE SCAN ===", flush=True)
    subspaces = {}
    # E_8: even bit positions 0,2,4,6,8,10,12,14
    e8_pts = []
    for u in range(256):
        x = 0
        for b in range(8):
            if (u >> b) & 1:
                x |= (1 << (2 * b))
        e8_pts.append(x)
    subspaces["E8_even"] = np.array(e8_pts, dtype=np.uint16)
    subspaces["O8_odd"] = np.array([x << 1 for x in e8_pts], dtype=np.uint16)
    # Anti-diagonal / twisted diagonals {(u, rot8(u, k))} for k=0..7
    for k in range(8):
        subspaces[f"D8_rot{k}"] = np.array([u | (rot8(u, k) << 8) for u in range(256)], dtype=np.uint16)
    # Low-half / High-half {(u, 0)} and {(0, u)}
    subspaces["Low8"] = np.array(list(range(256)), dtype=np.uint16)
    subspaces["High8"] = np.array([u << 8 for u in range(256)], dtype=np.uint16)
    # 4-bit block periodic {(q, q, q, q) + ...}: x_i = x_{i+4} (dim 4) -> skip; instead x_i ^ x_{i+4} = x_{i+8} ^ x_{i+12} (dim 12)
    # Check {(u, u ^ rot8(u, 4))}? Wait: u ^ rot8(u, 4) has rank 4, not 8, still {(u, u^rot8(u,4))} is 8-dim!
    for k in (1, 2, 3, 4):
        subspaces[f"D8_xor_rot{k}"] = np.array([u | ((u ^ rot8(u, k)) << 8) for u in range(256)], dtype=np.uint16)

    for name, pts in subspaces.items():
        raw_f = [
            sum((1 << int(i)) for i in np.flatnonzero(b_tt[:, pts[m]]))
            for m in range(256)
            if np.any(b_tt[:, pts[m]])
        ]
        zf = s16.reduce_forms_mod_pivs(raw_f, root["_lin_pivs"])
        wt0 = int(orig_tt[pts].sum())
        # Check if V8 is self-dual (x . y == 0 for all x, y in V8)
        # Basis of V8: pts[1], pts[2], pts[4], ..., pts[128]
        bas = [int(pts[1 << b]) for b in range(8)]
        is_sd = all(((bas[i] & bas[j]).bit_count() & 1) == 0 for i in range(8) for j in range(8))
        print(f"    {name:14s}: free_dim={len(zf):2d}, orig_wt={wt0:3d}, self_dual={is_sd}", flush=True)


def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    parser.add_argument("--etas", type=str, default="0,1,4,5")
    args = parser.parse_args()
    cell_name = args.cell
    etas = [int(x) for x in args.etas.split(",") if x.strip()]

    print(f"\n==================== [{cell_name}] STEP 50B: V8 SUBSPACES + DEEP d1 SYSB CASCADE ====================", flush=True)

    c_diag, so_diag = WORK_DIR / "s50b_diag.c", WORK_DIR / "libs50b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s50b_s9.c", WORK_DIR / "libs50b_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s50b_cg.c", WORK_DIR / "libs50b_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s50b_sh.c", WORK_DIR / "libs50b_sh.so"
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

    # 1. Scan all C8-invariant 8-dim subspaces
    check_v8_subspaces(cell_name, root, b_tt, orig_tt)

    # 2. Deep d1 = 22, 20, 18, 16 SysB + V0 + NT0_Polar + K_R cascade on etas
    print(f"\n  === [{cell_name}] 2. DEEP d1=(22, 20, 18, 16) ITERATIVE SYSB CASCADE ===", flush=True)
    for em in etas:
        sys_ex = s45b.extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=5000 + em)
        if sys_ex.get("closed_unsat"):
            print(f"    [{cell_name} eta={em}] CLOSED AT ROOT!", flush=True)
            continue
        nW = sys_ex["nW"]
        M0_c, Mk_c = sys_ex["M0_c"], sys_ex["Mk_c"]
        L_core_T = sys_ex["L_core"].T.copy()

        def eval_bc(W_mat, _fn=sys_ex["eval_b_and_p0_batch"], _Lt=L_core_T):
            b_orig, _ = _fn(W_mat)
            return (b_orig @ _Lt) & 1

        _, full_bas1, _ = s44a.minrank_basis(Mk_c, rk_cap=24, n_rounds=3, seed=5010 + em)
        U_full = np.zeros((nW, nW), dtype=np.uint8)
        for a, cm in enumerate(full_bas1):
            for k in range(nW):
                if (cm >> k) & 1:
                    U_full[a, k] = 1

        for d1 in (22, 20, 18, 16):
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
                M0_c, Mu1, make_u1_eval(U1, eval_bc), lib9, max_rounds=8, rng_seed=5020 + em * 10 + d1
            )

    print(f"\n[{cell_name}] STEP 50B DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()

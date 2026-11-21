#!/usr/bin/env python3
r"""
SOLVE_STEP57A_M1EXT_AND_DRF2_COLLAPSE.py

EXPLOITING THE TWO HUGE BLOCKS DISCOVERED IN STEP 56B CENSUS:
  1. BLOCK A: `(drf=1, dt_c=1, deg=2)` (45..53 equations of form sum B_{a,j} t_a r_j + ...)
     and `(drf=1, dt_c=0, deg=3)` (0..7 equations of form sum C_{k,l,j} w_k w_l r_j + ...).
     - Inspects whether `(drf=1, dt_c=1, deg=2)` rows contain ANY `w_k w_l r_j` terms!
     - Computes the exact alternating bilinear forms B^{(0)}..B^{(16)} of the 17 quadratics
       t_a = Q_a(W), their individual ranks, common kernel, and finds a maximal subspace
       U_iso subset F_2^{nW} on which ALL (or most) Q_a(W) become AFFINE-LINEAR (deg <= 1)!
     - On any subspace U_1 where Q_a(W) is affine-linear, substituting t_a = Q_a(u_1) turns
       ALL `(drf=1, dt_c=1, deg=2)` rows into STRICTLY BILINEAR rows (deg_{u_1} <= 1 in M(u_1)),
       boosting mR from 71..97 up to 124..146 rows!
     - Runs uncapped SysB + V0 + KR on the boosted 124..146-row pencil!

  2. BLOCK B: `(drf=2, dt_c=0, deg=2)` (113 equations on B0_11, 145 equations on B1_11!).
     - Every row in this block has CONSTANT-COEFFICIENT quadratic R_F part:
         sum_{0 <= i < j < 29} A^{(m)}_{ij} r_i r_j + (drf <= 1 terms) == 0 !
     - Whenever V_0 (in Round 1 or later rounds) eliminates `e` variables of R_F via
         r_{piv} = C @ r_{keep} ^ d(u_1)
       (where C = E_mat @ M0[:, keep] is a CONSTANT matrix, independent of u_1!),
       substituting r_{piv} into sum A^{(m)}_{ij} r_i r_j yields a reduced CONSTANT matrix
       \tilde{A} of shape (113..145, C(rK, 2)) on the remaining rK variables r_{keep}!
     - Every vector in left_nullspace(\tilde{A}) CANCELS all r_{keep,a} r_{keep,b} terms and
       produces a brand-new LINEAR-IN-r_{keep} (drf == 1) equation!
     - Measures how many new drf==1 equations drop from left_nullspace(\tilde{A}) across
       d1 = 18..36!
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
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP44A_ITERATED_POLAR_TOWER as s44a
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b
import SOLVE_STEP55B_UNCAP_SYSB_AND_KERNEL_BASIS as s55b


def find_max_isotropic_subspace(B_list, nW, Mk_c=None):
    """
    Given a list of alternating nW x nW binary matrices B_list (with B[i,i]=0, B[i,j]=B[j,i]),
    find a basis U_iso (d_iso x nW) of a maximal common isotropic subspace:
      U_iso @ B @ U_iso.T == 0 for all B in B_list,
    and complete it to a full nW x nW basis U_full = [U_iso; T_comp].
    If Mk_c is provided, orders candidate vectors by their minrank score in Mk_c!
    """
    # Start with candidate pool = all nW unit vectors + low-rank vectors from minrank_basis if available
    if Mk_c is not None:
        _, full_bas1, _ = s44a.minrank_basis(Mk_c, rk_cap=24, n_rounds=3, seed=5701)
        U_cand = np.zeros((nW, nW), dtype=np.uint8)
        for a, cm in enumerate(full_bas1):
            for k in range(nW):
                if (cm >> k) & 1:
                    U_cand[a, k] = 1
    else:
        U_cand = np.eye(nW, dtype=np.uint8)

    # Greedy exact subspace intersection:
    # Maintain current allowed subspace V_allow (initially F_2^{nW}, basis = U_cand)
    # and chosen isotropic basis vectors iso_vecs.
    iso_vecs = []
    # Constraint matrix C_constraints (m_c x nW): any next vector w must satisfy C_constraints @ w == 0
    # AND must be linearly independent of iso_vecs.
    C_constraints = np.zeros((0, nW), dtype=np.uint8)

    while True:
        # Nullspace of C_constraints is the space V_allow of vectors orthogonal to all iso_vecs under all B in B_list
        if C_constraints.shape[0] == 0:
            V_allow = U_cand.copy()
        else:
            V_allow = s40a.gf2_nullspace_np(C_constraints)
        if V_allow.shape[0] <= len(iso_vecs):
            break
        # Pick a vector in V_allow not in span(iso_vecs)
        if not iso_vecs:
            v_next = V_allow[0]
        else:
            iso_mat = np.array(iso_vecs, dtype=np.uint8)
            _, piv0 = s40a.gf2_rref_np(iso_mat)
            rk0 = len(piv0)
            v_next = None
            # Prefer vectors in V_allow that impose the FEWEST new constraints [B @ v for B in B_list]!
            best_score = 10**9
            for row in V_allow:
                _, piv1 = s40a.gf2_rref_np(np.vstack([iso_mat, row[None, :]]))
                if len(piv1) > rk0:
                    # Count rank of new constraints added by row
                    new_c = np.array([(B @ row) & 1 for B in B_list], dtype=np.uint8)
                    comb_c = np.vstack([C_constraints, new_c]) if C_constraints.shape[0] else new_c
                    _, pc = s40a.gf2_rref_np(comb_c)
                    if len(pc) < best_score:
                        best_score = len(pc)
                        v_next = row
            if v_next is None:
                break
        iso_vecs.append(v_next)
        new_c = np.array([(B @ v_next) & 1 for B in B_list], dtype=np.uint8)
        C_constraints = np.vstack([C_constraints, new_c]) if C_constraints.shape[0] else new_c
        # Keep C_constraints in RREF to stay compact
        R_c, piv_c = s40a.gf2_rref_np(C_constraints)
        C_constraints = R_c[:len(piv_c)]

    U_iso = np.array(iso_vecs, dtype=np.uint8)
    # Verify isotropy
    for B in B_list:
        assert not np.any((U_iso @ B @ U_iso.T) & 1), "Isotropy check failed!"
    return U_iso


def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    args = parser.parse_args()
    cell_name = args.cell

    print(f"\n==================== [{cell_name}] STEP 57A: M1_EXT ISOTROPIC BOOST & DRF=2 QUADRATIC COLLAPSE ====================", flush=True)

    c_diag, so_diag = WORK_DIR / "s57a_diag.c", WORK_DIR / "libs57a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s57a_s9.c", WORK_DIR / "libs57a_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s57a_cg.c", WORK_DIR / "libs57a_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s57a_sh.c", WORK_DIR / "libs57a_sh.so"
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
    n_cols = tbl["off0"] + 1
    mask64 = (1 << 64) - 1
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

    etas = [5, 0] if cell_name == "B0_11" else [0, 1]

    for em in etas:
        n_ef = len(eta_free)
        ex_eta = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
        sr = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex_eta, tbl, max_xl_rounds=20, verify_subst=False
        )
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
        nW, nT, nRF = len(W_pivs), len(T_pivs), len(RF_vars)
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

        # Extract Q_t[0..nT-1] and their alternating nW x nW matrices B_qt[0..nT-1]
        T_mask_all = sum(1 << v for v in T_pivs)
        q_sheared_psets = [s9.row_to_pset(work, qi, tbl) for qi in range(n_q)]
        t_piv_map = {}
        for ps in q_sheared_psets:
            tv, ws = 0, set()
            for m in ps:
                if m & T_mask_all:
                    tv |= (1 << t_idx[m.bit_length() - 1])
                else:
                    wm = 0
                    tmp = m
                    while tmp:
                        lb = tmp & -tmp
                        wm |= (1 << w_idx[lb.bit_length() - 1])
                        tmp ^= lb
                    ws ^= {wm}
            for p_ti, (ptv, pws) in t_piv_map.items():
                if (tv >> p_ti) & 1:
                    tv ^= ptv; ws ^= pws
            if tv == 0:
                continue
            b = (tv & -tv).bit_length() - 1
            for ob in list(t_piv_map.keys()):
                otv, ows = t_piv_map[ob]
                if (otv >> b) & 1:
                    t_piv_map[ob] = (otv ^ tv, ows ^ ws)
            t_piv_map[b] = (tv, ws)

        Q_t = [sorted(t_piv_map[ti][1]) for ti in range(nT)]
        B_qt = [np.zeros((nW, nW), dtype=np.uint8) for _ in range(nT)]
        qt_c0 = np.zeros(nT, dtype=np.uint8)
        qt_lin = np.zeros((nT, nW), dtype=np.uint8)
        for ti, mlist in enumerate(Q_t):
            for wm in mlist:
                if wm == 0:
                    qt_c0[ti] ^= 1
                elif wm.bit_count() == 1:
                    qt_lin[ti, wm.bit_length() - 1] ^= 1
                elif wm.bit_count() == 2:
                    a = (wm & -wm).bit_length() - 1
                    b = (wm ^ (1 << a)).bit_length() - 1
                    B_qt[ti][a, b] = 1
                    B_qt[ti][b, a] = 1

        # Echelonize work in elimination order
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

        # Separate blocks from std_ech
        rows_drf1_dt0 = []
        rows_drf1_dt1 = []
        rows_drf2_deg2 = []
        for r_id, (drf, dt_c, lead_d) in ech_rows:
            ps = s9.row_to_pset(std_ech, r_id, tbl)
            if drf == 1 and dt_c == 0:
                rows_drf1_dt0.append(ps)
            elif drf == 1 and dt_c == 1:
                rows_drf1_dt1.append(ps)
            elif drf == 2 and dt_c == 0 and lead_d == 2:
                rows_drf2_deg2.append(ps)

        # Check how many rows in rows_drf1_dt1 have w_a*w_b*r_j terms!
        dt1_no_w2r = []
        dt1_with_w2r = []
        for ps in rows_drf1_dt1:
            has_w2r = False
            for m in ps:
                vs = [b for b in range(n) if (m >> b) & 1]
                rfvs = [v for v in vs if v in RF_set]
                if len(rfvs) == 1 and len([v for v in vs if v in W_set]) >= 2:
                    has_w2r = True
                    break
            if has_w2r:
                dt1_with_w2r.append(ps)
            else:
                dt1_no_w2r.append(ps)

        print(f"\n  === [{cell_name} eta={em}] PART 1: BLOCK A (drf=1, dt_c=1) & ISOTROPIC Q_t AUDIT ===", flush=True)
        print(f"    drf=1, dt_c=0 total={len(rows_drf1_dt0)} | drf=1, dt_c=1 total={len(rows_drf1_dt1)} (no_w2r={len(dt1_no_w2r)}, with_w2r={len(dt1_with_w2r)})", flush=True)

        # Ranks and common kernel of B_qt[0..nT-1]
        qt_rks = [s55b.gf2_rank_np(B) for B in B_qt]
        comm_ker_qt = s40a.gf2_nullspace_np(np.vstack(B_qt))
        print(f"    17 Q_t alternating matrix ranks: {qt_rks}, common_kernel_dim={comm_ker_qt.shape[0]}", flush=True)

        sys_ex = s45b.extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=5700 + em)
        M0_c, Mk_c = sys_ex["M0_c"], sys_ex["Mk_c"]
        U_iso = find_max_isotropic_subspace(B_qt, nW, Mk_c=Mk_c)
        d_iso = U_iso.shape[0]
        print(f"    Maximal common isotropic subspace for ALL 17 Q_t: dim(U_iso) = {d_iso} (NT_iso = {nW - d_iso})", flush=True)

        # On U_iso, EVERY t_a = Q_a(u_1 U_iso) is STRICTLY AFFINE-LINEAR in u_1:
        #   t_a(u_1) = qt_c0[a] ^ sum_b (qt_lin[a] @ U_iso[b]) u_{1,b} !
        # That means ALL `dt1_no_w2r` rows (45..49 rows!) become STRICTLY BILINEAR in (u_1, R_F) on U_iso!
        # Let's build the combined (M1_strict + dt1_no_w2r) pencil on U_iso and test uncapped cascade!
        M1_strict_psets = [
            ps for ps in rows_drf1_dt0
            if not any(
                len([v for v in [b for b in range(n) if (m >> b) & 1] if v in RF_set]) == 1
                and len([v for v in [b for b in range(n) if (m >> b) & 1] if v in W_set]) >= 2
                for m in ps
            )
        ]
        comb_psets = M1_strict_psets + dt1_no_w2r
        n_comb = len(comb_psets)
        M0_ext = np.zeros((n_comb, nRF), dtype=np.uint8)
        Mw_ext = np.zeros((nW, n_comb, nRF), dtype=np.uint8)
        Mt_ext = np.zeros((nT, n_comb, nRF), dtype=np.uint8)
        for ri, ps in enumerate(comb_psets):
            for m in ps:
                vs = [b for b in range(n) if (m >> b) & 1]
                rfvs = [rf_idx[v] for v in vs if v in RF_set]
                if len(rfvs) == 1:
                    rfi = rfvs[0]
                    wvs = [w_idx[v] for v in vs if v in w_idx]
                    tvs = [t_idx[v] for v in vs if v in t_idx]
                    if len(wvs) == 0 and len(tvs) == 0:
                        M0_ext[ri, rfi] ^= 1
                    elif len(wvs) == 1 and len(tvs) == 0:
                        Mw_ext[wvs[0], ri, rfi] ^= 1
                    elif len(wvs) == 0 and len(tvs) == 1:
                        Mt_ext[tvs[0], ri, rfi] ^= 1
                    else:
                        raise AssertionError(f"Unexpected wvs={wvs}, tvs={tvs}")

        # Substitute t_a = qt_c0[a] ^ sum_k qt_lin[a, k] w_k (valid on U_iso where Q_a_quad == 0!)
        M0_iso = M0_ext.copy()
        for a in range(nT):
            if qt_c0[a]:
                M0_iso ^= Mt_ext[a]
        Mw_iso = Mw_ext.copy()
        for k in range(nW):
            for a in range(nT):
                if qt_lin[a, k]:
                    Mw_iso[k] ^= Mt_ext[a]

        Mu_iso = [np.zeros_like(M0_iso) for _ in range(d_iso)]
        for b in range(d_iso):
            for k in range(nW):
                if U_iso[b, k]:
                    Mu_iso[b] ^= Mw_iso[k]

        rK_iso, lg_iso = s55b.run_cascade_uncapped(M0_iso, Mu_iso, lib9, max_rounds=10, mR_cap=500, rK_cap=30, keep_cap=128)
        print(f"    [Boosted {n_comb}-row pencil on U_iso (d1={d_iso}, NT1={nW-d_iso})]: final_rK={rK_iso} | {' ; '.join(lg_iso)}", flush=True)

        # Also test sub-slices of U_iso (e.g. top d1 of minrank_basis restricted to U_iso)
        _, iso_bas, _ = s44a.minrank_basis(Mu_iso, rk_cap=24, n_rounds=3, seed=5720 + em)
        U_iso_ord = np.zeros((d_iso, d_iso), dtype=np.uint8)
        for a, cm in enumerate(iso_bas):
            for b in range(d_iso):
                if (cm >> b) & 1:
                    U_iso_ord[a, b] = 1
        for d_sub in [16, 18, 20, 22, 24]:
            if d_sub > d_iso:
                continue
            Mu_sub = [np.zeros_like(M0_iso) for _ in range(d_sub)]
            for a in range(d_sub):
                for b in range(d_iso):
                    if U_iso_ord[a, b]:
                        Mu_sub[a] ^= Mu_iso[b]
            rK_s, lg_s = s55b.run_cascade_uncapped(M0_iso, Mu_sub, lib9, max_rounds=10, mR_cap=500, rK_cap=30, keep_cap=128)
            print(f"      U_iso sub d1={d_sub:2d}(NT1={nW-d_sub:2d}): final_rK={rK_s:2d} | {' ; '.join(lg_s)}", flush=True)

        # PART 2: BLOCK B (drf=2, dt_c=0, deg=2) CONSTANT-COEFFICIENT R_F QUADRATIC COLLAPSE
        print(f"\n  === [{cell_name} eta={em}] PART 2: BLOCK B ({len(rows_drf2_deg2)} CONSTANT R_F-QUADRATIC EQS) ===", flush=True)
        # Extract the (n_drf2, C(nRF, 2)) constant binary matrix A_rf2
        pair_rf_map = {}
        rf_pairs = []
        for i in range(nRF):
            for j in range(i + 1, nRF):
                pair_rf_map[(i, j)] = len(rf_pairs)
                rf_pairs.append((i, j))
        n_rf_pairs = len(rf_pairs)
        A_rf2 = np.zeros((len(rows_drf2_deg2), n_rf_pairs), dtype=np.uint8)
        for ri, ps in enumerate(rows_drf2_deg2):
            for m in ps:
                vs = [b for b in range(n) if (m >> b) & 1]
                rfvs = sorted(rf_idx[v] for v in vs if v in RF_set)
                if len(rfvs) == 2:
                    assert len(vs) == 2, f"Expected pure deg-2 r_i*r_j, got vs={vs}"
                    A_rf2[ri, pair_rf_map[(rfvs[0], rfvs[1])]] ^= 1
                else:
                    assert len(rfvs) <= 1, f"Unexpected rfvs={rfvs}"

        rk_A2 = s55b.gf2_rank_np(A_rf2)
        print(f"    A_rf2 shape={A_rf2.shape}, rank={rk_A2}, initial left_kernel={A_rf2.shape[0] - rk_A2}", flush=True)

        # Now check: when we eliminate `e` variables of R_F (so rK = 29 - e remain via r_elim = C @ r_keep),
        # what is the rank and left_kernel dimension of the substituted quadratic matrix \tilde{A}_rf2
        # on the C(rK, 2) pairs of r_keep?!
        # Test along the actual V_0 + KR eliminations from minrank_basis of Mk_c at d1 = 18..32!
        _, full_bas1, _ = s44a.minrank_basis(Mk_c, rk_cap=24, n_rounds=3, seed=5730 + em)
        U_full = np.zeros((nW, nW), dtype=np.uint8)
        for a, cm in enumerate(full_bas1):
            for k in range(nW):
                if (cm >> k) & 1:
                    U_full[a, k] = 1

        # Recall: in extract_eta_exact_system, nRF=29 (K_R at root has dim 0 on B0_11/B1_11, so nRC == nRF == 29)
        for d1 in [18, 20, 22, 24, 26, 28, 30, 32]:
            U1 = U_full[:d1]
            Mu1 = [np.zeros_like(M0_c) for _ in range(d1)]
            for a in range(d1):
                for k in range(nW):
                    if U1[a, k]:
                        Mu1[a] ^= Mk_c[k]
            # Round-1 V_0 ONLY (strictly constant substitution r_piv = C @ r_keep + d(u1)!)
            V0 = s40a.gf2_nullspace_np(np.hstack(Mu1).T)
            V0_M0 = (V0 @ M0_c) & 1
            R_v0, piv_v0 = s40a.gf2_rref_np(V0_M0)
            e_v0 = len(piv_v0)
            rK_rem = nRF - e_v0
            # Express ALL nRF variables in terms of the rK_rem keep variables:
            # r_all = G @ r_keep (+ d(u1)), where G has shape (nRF, rK_rem):
            piv_set = set(piv_v0)
            keep_c = [c for c in range(nRF) if c not in piv_set]
            G = np.zeros((nRF, rK_rem), dtype=np.uint8)
            for idx_k, c in enumerate(keep_c):
                G[c, idx_k] = 1
            for idx_p, p in enumerate(piv_v0):
                G[p, :] = R_v0[idx_p, keep_c]

            # Substitute r_i = sum_a G[i,a] r_keep[a] into r_i * r_j (modulo linear terms in r_keep):
            # Coeff of r_keep[a] * r_keep[b] (a < b) in r_i * r_j is (G[i,a]&G[j,b]) ^ (G[i,b]&G[j,a])!
            n_rem_pairs = rK_rem * (rK_rem - 1) // 2
            P_trans = np.zeros((n_rf_pairs, n_rem_pairs), dtype=np.uint8)
            col_ab = 0
            for a in range(rK_rem):
                Ga = G[:, a]
                for b in range(a + 1, rK_rem):
                    Gb = G[:, b]
                    # For all pairs (i, j):
                    for idx_ij, (i, j) in enumerate(rf_pairs):
                        P_trans[idx_ij, col_ab] = (Ga[i] & Gb[j]) ^ (Ga[j] & Gb[i])
                    col_ab += 1
            A_tilde = (A_rf2.astype(np.uint16) @ P_trans.astype(np.uint16)) & 1
            rk_t = s55b.gf2_rank_np(A_tilde) if n_rem_pairs > 0 else 0
            new_lin_rf = A_rf2.shape[0] - rk_t
            print(
                f"    d1={d1:2d}(NT1={nW-d1:2d}): V0_elim={e_v0:2d} -> rK_rem={rK_rem:2d}, "
                f"C(rK_rem,2)={n_rem_pairs:3d}, rk(A_tilde)={rk_t:3d} => NEW_DRF1_EQS = {new_lin_rf:3d}!",
                flush=True,
            )

    print(f"\n[{cell_name}] STEP 57A DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()

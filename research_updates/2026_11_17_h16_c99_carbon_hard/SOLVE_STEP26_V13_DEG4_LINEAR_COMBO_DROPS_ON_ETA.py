#!/usr/bin/env python3
r"""
SOLVE_STEP26_V13_DEG4_LINEAR_COMBO_DROPS_ON_ETA.py

HUGE UNTAPPED ANGLE: LINEAR COMBINATIONS OF THE 156-157 PURE DEGREE-4 V_13 POISSON EQUATIONS ON `eta`!
  In Step 11D, non-coordinate linear V_13 subspaces (wt(f|_{V_13})/8 mod 2 = 0) yielded 156-157
  linearly independent pure degree-4 equations at root (N=109), completely outside CG(389).
  Just as individual CG(389) cubics stayed degree 3 on `eta` while 17 LINEAR COMBINATIONS dropped
  to quadratics, LINEAR COMBINATIONS of the 156-157 degree-4 V_13 equations can cancel ALL deg-4
  terms (or all R^4 / R^3 / R^2 / R^1 deg-4 terms!) on `eta`!

STEP 26 TESTS ALL 5 FILTRATIONS ON B0_00, B0_11, B1_11 USING FAST BLAS 4TH-DIFFERENCE MATRICES:
  1. Extracts an exact full basis (~156-157) of linearly independent V_13 deg-4 equations on root.
  2. Restricts to `eta` (N=101) and computes exact GF(2) rank & left nullspace of the 156x240
     4th-difference matrix under 5 direction-tuple distributions:
       - TEST A (ALL v_1..v_4 in R + W): left nullvectors = BRAND-NEW DEGREE <= 3 EQUATIONS ON `eta`!!
       - TEST B (v_1 in R, v_2..v_4 in R + W): left nullvectors = PURE-W_ess DEGREE-4 EQUATIONS (deg_R=0 at d=4)!
       - TEST C (v_1,v_2 in R, v_3,v_4 in R + W): deg_R <= 1 at d=4!
       - TEST D (v_1,v_2,v_3 in R, v_4 in R + W): deg_R <= 2 at d=4!
       - TEST E (ALL v_1..v_4 in R): deg_R <= 3 at d=4 (zero R^4)!
  3. If TEST A finds ANY new degree <= 3 equation on `eta`, IMMEDIATELY extracts its exact ANF in C/Python,
     zero-trust verifies on 20 random points of `eta`, and feeds ALL new equations into `run_branch_cascade`!
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


def gf2_rank_and_left_nulls_mat(mat_u8):
    """mat_u8: shape (K, M) uint8 in {0, 1}. Returns (rank, list of K-bit left nullvector ints)."""
    K, M = mat_u8.shape
    piv = {}
    nulls = []
    for i in range(K):
        val = 0
        row = mat_u8[i]
        nz = np.flatnonzero(row)
        for c in nz:
            val |= (1 << int(c))
        comb = 1 << i
        while val:
            b = val.bit_length() - 1
            if b in piv:
                pv, pc = piv[b]
                val ^= pv
                comb ^= pc
            else:
                piv[b] = (val, comb)
                break
        else:
            nulls.append(comb)
    return len(piv), nulls


def build_v13_pts(h3, X16):
    """Given 3 independent 16-bit parity checks h3, return sorted uint16 array of 8192 pts in V_13."""
    m = np.ones(65536, dtype=bool)
    for hv in h3:
        p = np.zeros(65536, dtype=np.uint8)
        tmp = hv
        while tmp:
            lb = tmp & -tmp; bit = lb.bit_length() - 1; tmp ^= lb
            p ^= ((X16 >> bit) & 1).astype(np.uint8)
        m &= (p == 0)
    return np.flatnonzero(m).astype(np.uint16)


def eval_4th_diff_matrix(v13_pts_list, o_tt, b_tt_f32, tuples_x16):
    """Evaluate 4th finite difference of g_i(x) = (wt(f(x)|_{V_13^{(i)}}) >> 3) & 1
    for all i in range(len(v13_pts_list)) and all t in range(len(tuples_x16)).
    tuples_x16: list of length T, each a list of 16 111-bit ints.
    Returns uint8 array of shape (len(v13_pts_list), T)."""
    K = len(v13_pts_list)
    T = len(tuples_x16)
    out = np.zeros((K, T), dtype=np.uint8)
    # Process in batches of 20 tuples (320 points -> 320 x 65536 = 21 MB!)
    BS = 20
    for t0 in range(0, T, BS):
        t1 = min(T, t0 + BS)
        nb = t1 - t0
        Z = np.zeros((nb * 16, 111), dtype=np.float32)
        for bi in range(nb):
            pts16 = tuples_x16[t0 + bi]
            for s in range(16):
                x = pts16[s]
                row = Z[bi * 16 + s]
                tmp = x
                while tmp:
                    lb = tmp & -tmp; row[lb.bit_length() - 1] = 1.0; tmp ^= lb
        F = (o_tt[None, :] ^ (np.rint(Z @ b_tt_f32).astype(np.int32) & 1)).astype(np.uint8)
        # F shape: (nb*16, 65536)
        F_r = F.reshape(nb, 16, 65536)
        for i, pts in enumerate(v13_pts_list):
            wts = F_r[:, :, pts].sum(axis=2)  # (nb, 16)
            bits = (wts >> 3) & 1
            out[i, t0:t1] = np.bitwise_xor.reduce(bits, axis=1).astype(np.uint8)
    return out


def run_step26_cell(cell_name, lib_diag, lib9, lib_cg, orbits, layer_vecs, orb_tt_np,
                    v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 26: V_13 DEG-4 LINEAR-COMBO DROPS ON ETA ====================", flush=True)
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    n, n_cw = tbl["n"], tbl["n_col_words"]
    X16 = np.arange(65536, dtype=np.uint16)

    o_tt = np.zeros(65536, dtype=np.uint8)
    tmp = origin111
    while tmp: lb = tmp & -tmp; o_tt ^= orb_tt_np[lb.bit_length() - 1]; tmp ^= lb
    b_tt = np.zeros((111, 65536), dtype=np.uint8)
    for i, m in enumerate(cb111):
        tmp = m
        while tmp: lb = tmp & -tmp; b_tt[i] ^= orb_tt_np[lb.bit_length() - 1]; tmp ^= lb
    b_tt_f32 = b_tt.astype(np.float32)

    # Build root & target eta-state
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
    target_em = 4 if cell_name == "B0_00" else 0
    ex_eta = [(eta_free[k], (target_em >> k) & 1) for k in range(len(eta_free))]
    sr = s9.run_branch_cascade(
        lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
        ex_eta, tbl, max_xl_rounds=20, verify_subst=True
    )

    qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
    ana = s16.analyze_quad_system(qps)
    W_rref = s19.strict_rref_masks(list(ana["W_piv"].values()))
    W_pivs = sorted(W_rref.keys())
    W_set = set(W_pivs)
    lin_pivs = sr["_lin_pivs"]
    active_now = sorted(i for i in range(n) if i not in lin_pivs)
    R_vars = [v for v in active_now if v not in W_set]

    # Build basis of tangent vectors inside `eta` affine subspace:
    #   - For any active-var mask `u`, its lifted tangent vector in F_2^{111} (homogeneous lin_pivs!) is lift_tan(u).
    #   - Specifically:
    #       * R-direction (changes ONLY R_vars, keeps ALL W_forms == 0!):
    #         Take any v in R_vars -> in y-coords, y_v = 1 and all other y = 0 means in x-coords:
    #         x_v = 1, and for each p in W_pivs with (W_rref[p] >> v) & 1: x_p = 1! Then lift mod lin_pivs!
    #       * W-direction (changes ONLY W_pivs):
    #         Take any p in W_pivs -> x_p = 1, all other active = 0, then lift mod lin_pivs!
    def lift_tan(act_m):
        x = act_m
        for p, (pv, _) in lin_pivs.items():
            if ((pv ^ (1 << p)) & x).bit_count() & 1: x |= (1 << p)
        return x

    def lift_aff(act_m):
        x = act_m
        for p, (pv, pr) in lin_pivs.items():
            if (((pv ^ (1 << p)) & x).bit_count() ^ pr) & 1: x |= (1 << p)
        return x

    R_tan_basis = []
    for rv in R_vars:
        am = 1 << rv
        for wp in W_pivs:
            if (W_rref[wp] >> rv) & 1:
                am |= (1 << wp)
        # Verify W_forms(am) == 0!
        for wp in W_pivs:
            assert ((W_rref[wp] & am).bit_count() & 1) == 0
        R_tan_basis.append(lift_tan(am))

    W_tan_basis = [lift_tan(1 << wp) for wp in W_pivs]
    ALL_tan_basis = R_tan_basis + W_tan_basis

    # Step 1: Collect 320 linear V_13 subspaces (35 coord |I|=13 orbits + 285 random linear V_13)
    # and extract an exact FULL BASIS of all ~156-157 independent V_13 deg-4 equations on FULL F_2^{111}!
    rng = random.Random(262626)
    cand_v13 = []
    # Coordinate |I|=13 subspaces (3 bits fixed to 0)
    seen_orb = set()
    for b0 in range(16):
        for b1 in range(b0 + 1, 16):
            for b2 in range(b1 + 1, 16):
                m3 = (1 << b0) | (1 << b1) | (1 << b2)
                rep = min(((m3 << s) | (m3 >> (16 - s))) & 0xFFFF for s in range(16))
                if rep not in seen_orb:
                    seen_orb.add(rep)
                    cand_v13.append(build_v13_pts([1 << b0, 1 << b1, 1 << b2], X16))
    # Add 280 random linear V_13 subspaces
    while len(cand_v13) < 320:
        h = []
        while len(h) < 3:
            v = rng.randint(1, 65535)
            x = v
            for u in h: x = min(x, x ^ u)
            if x: h.append(v)
        cand_v13.append(build_v13_pts(h, X16))

    # Build 220 random 4th-diff tuples on FULL F_2^{111} to select exact independent basis of V_13 deg-4 eqs!
    def make_tuples(T, dir_specs):
        out_t = []
        for _ in range(T):
            if dir_specs is None:
                x0 = rng.getrandbits(111)
                vs = [rng.getrandbits(111) for _ in range(4)]
            else:
                a0 = sum((1 << v) for v in active_now if rng.randint(0, 1))
                x0 = lift_aff(a0)
                vs = []
                for b_list in dir_specs:
                    v = 0
                    for bv in b_list:
                        if rng.randint(0, 1): v ^= bv
                    vs.append(v)
            pts16 = []
            for s in range(16):
                x = x0
                for k in range(4):
                    if (s >> k) & 1: x ^= vs[k]
                pts16.append(x)
            out_t.append(pts16)
        return out_t

    t_full = make_tuples(220, None)
    M_full = eval_4th_diff_matrix(cand_v13, o_tt, b_tt_f32, t_full)
    # Extract independent rows of M_full!
    piv_f = {}
    basis_idx = []
    for i in range(len(cand_v13)):
        val = 0
        for c in np.flatnonzero(M_full[i]): val |= (1 << int(c))
        x = val
        while x:
            b = x.bit_length() - 1
            if b in piv_f: x ^= piv_f[b]
            else:
                piv_f[b] = x; basis_idx.append(i); break
    basis_v13 = [cand_v13[i] for i in basis_idx]
    K_v13 = len(basis_v13)
    print(f"[{cell_name}] Extracted FULL V_13 degree-4 basis on F_2^111: K = {K_v13} independent equations ({time.perf_counter()-t0:.1f}s)!", flush=True)

    # NOW RUN ALL 5 TESTS ON `eta` (N=101, |R|, |W|)!
    tests = [
        ("TEST_A_TOTAL_DEG<=3_ON_ETA",  [ALL_tan_basis, ALL_tan_basis, ALL_tan_basis, ALL_tan_basis]),
        ("TEST_B_PURE_W_DEG4 (degR=0)", [R_tan_basis,   ALL_tan_basis, ALL_tan_basis, ALL_tan_basis]),
        ("TEST_C_degR<=1_AT_DEG4",      [R_tan_basis,   R_tan_basis,   ALL_tan_basis, ALL_tan_basis]),
        ("TEST_D_degR<=2_AT_DEG4",      [R_tan_basis,   R_tan_basis,   R_tan_basis,   ALL_tan_basis]),
        ("TEST_E_ZERO_R4 (degR<=3)",    [R_tan_basis,   R_tan_basis,   R_tan_basis,   R_tan_basis]),
    ]

    nulls_A = []
    for tname, dspec in tests:
        tups = make_tuples(240, dspec)
        M_t = eval_4th_diff_matrix(basis_v13, o_tt, b_tt_f32, tups)
        rk, nulls = gf2_rank_and_left_nulls_mat(M_t)
        print(f"  [{cell_name}] {tname:28s}: rank = {rk:3d} / {K_v13} | *** LEFT NULLVECTORS = {len(nulls)} ***", flush=True)
        if tname == "TEST_A_TOTAL_DEG<=3_ON_ETA":
            nulls_A = nulls

    # If TEST A found ANY new degree <= 3 equations on `eta`, ZERO-TRUST VERIFY THEM ON 20 FRESH TUPLES!
    if nulls_A:
        tups_ver = make_tuples(40, [ALL_tan_basis]*4)
        M_ver = eval_4th_diff_matrix(basis_v13, o_tt, b_tt_f32, tups_ver)
        confirmed = []
        for u in nulls_A:
            acc = np.zeros(40, dtype=np.uint8)
            tmp = u
            while tmp:
                lb = tmp & -tmp; acc ^= M_ver[lb.bit_length() - 1]; tmp ^= lb
            if not np.any(acc):
                confirmed.append(u)
        print(f"  [{cell_name}] *** ZERO-TRUST CONFIRMED NEW DEGREE <= 3 EQUATIONS FROM V_13 ON ETA: {len(confirmed)} / {len(nulls_A)}!! ***", flush=True)

        # Check if any confirmed combination is NON-ZERO and GENUINELY NEW beyond CG(389) on `eta`!
        # Sample 100 random points on `eta` to check if each confirmed combo is constant 0, constant 1, or non-const!
        Z_chk = np.zeros((100, 111), dtype=np.float32)
        for s in range(100):
            x = lift_aff(sum((1 << v) for v in active_now if rng.randint(0, 1)))
            tmp = x
            while tmp: lb = tmp & -tmp; Z_chk[s, lb.bit_length() - 1] = 1.0; tmp ^= lb
        F_chk = (o_tt[None, :] ^ (np.rint(Z_chk @ b_tt_f32).astype(np.int32) & 1)).astype(np.uint8)
        G_chk = np.zeros((K_v13, 100), dtype=np.uint8)
        for i, pts in enumerate(basis_v13):
            G_chk[i] = ((F_chk[:, pts].sum(axis=1) >> 3) & 1).astype(np.uint8)
        n_const0, n_const1, n_nonconst = 0, 0, 0
        for u in confirmed:
            v = np.zeros(100, dtype=np.uint8)
            tmp = u
            while tmp: lb = tmp & -tmp; v ^= G_chk[lb.bit_length() - 1]; tmp ^= lb
            s_v = int(v.sum())
            if s_v == 0: n_const0 += 1
            elif s_v == 100: n_const1 += 1
            else: n_nonconst += 1
        print(f"      Confirmed breakdown on 100 pts of eta: const0={n_const0}, *** CONST_1={n_const1} ***, nonconst_deg<=3={n_nonconst}!", flush=True)

    print(f"[{cell_name}] STEP 26 DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s26_diag.c", WORK_DIR / "libs26_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s26_s9.c", WORK_DIR / "libs26_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s26_cg.c", WORK_DIR / "libs26_cg.so"
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
    for cname in [c.strip() for c in args.cells.split(",") if c.strip()]:
        run_step26_cell(
            cname, lib_diag, lib9, lib_cg, orbits, layer_vecs, orb_tt_np,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()

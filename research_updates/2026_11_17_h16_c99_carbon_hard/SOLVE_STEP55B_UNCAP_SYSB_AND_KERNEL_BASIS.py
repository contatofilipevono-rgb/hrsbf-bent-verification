#!/usr/bin/env python3
r"""
SOLVE_STEP55B_UNCAP_SYSB_AND_KERNEL_BASIS.py

TWO CRITICAL TESTS TO COLLAPSE NT1 ON B0_11 & B1_11:
  1. UNCAP SysB (remove artificial rK<=24 and mR<=260 caps from Step 52B/53B!):
     Measure exact SysB solution count and final rK across d1 = 18..44 (NT1 = 0..26).
  2. KERNEL-SEEDED OPTIMAL SUBSPACE U_1 SEARCH:
     Instead of generic minrank_basis, explicitly search for:
       - Right-kernel seeds v in F_2^{rK} minimizing rank([M_1 v, ..., M_{nW} v]) -> huge dim(ker) with v in K_R!
       - Left-kernel seeds u in F_2^{mR} minimizing rank([u^T M_1; ..., u^T M_{nW}]) -> huge dim(ker) with u in V_0!
     Test whether a kernel-seeded U_1 achieves rK = 0 at MUCH LARGER d1 (SMALLER NT1 <= 14)!
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
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP44A_ITERATED_POLAR_TOWER as s44a
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b
import SOLVE_STEP47B_ITERATIVE_SYSB_CASCADE as s47b


def run_cascade_uncapped(M0_init, Mk_init, lib9, max_rounds=10, mR_cap=500, rK_cap=30, keep_cap=128):
    """Fast matrix-only cascade (no eval_b overhead) to find exact final rK and SysB counts."""
    M0 = M0_init.copy()
    Mk = [M.copy() for M in Mk_init]
    mW = len(Mk)
    log = []

    for rd in range(1, max_rounds + 1):
        mR, rK = M0.shape
        if rK == 0:
            return 0, log

        # 1. K_R quotient
        KR = s40a.gf2_nullspace_np(np.vstack(Mk))
        if KR.shape[0] > 0:
            M0_KR = (M0 @ KR.T) & 1
            L_kr = s40a.gf2_nullspace_np(M0_KR.T)
            _, kr_pivs = s40a.gf2_rref_np(KR)
            kr_set = set(kr_pivs)
            keep_c = [c for c in range(rK) if c not in kr_set]
            M0 = (L_kr @ M0[:, keep_c]) & 1
            Mk = [(L_kr @ M[:, keep_c]) & 1 for M in Mk]
            log.append(f"r{rd}:KR={KR.shape[0]}->({M0.shape[0]}x{M0.shape[1]})")
            if M0.shape[1] == 0:
                return 0, log

        # 2. Deduplicate rows
        cur_stack = np.hstack([M0] + Mk)
        _, keep_r = s40a.gf2_rref_np(cur_stack.T)
        if len(keep_r) < M0.shape[0]:
            M0 = M0[keep_r]
            Mk = [M[keep_r] for M in Mk]

        # 3. V_0 elimination
        V0 = s40a.gf2_nullspace_np(np.hstack(Mk).T)
        if V0.shape[0] > 0:
            V0_M0 = (V0 @ M0) & 1
            _, piv_c_v0 = s40a.gf2_rref_np(V0_M0)
            r_elim = len(piv_c_v0)
            if r_elim > 0:
                rK_cur = M0.shape[1]
                aug = np.hstack([V0_M0, V0])
                aug_r, _ = s40a.gf2_rref_np(aug)
                E_mat = aug_r[:r_elim, rK_cur:]
                piv_set = set(piv_c_v0)
                keep_c = [c for c in range(rK_cur) if c not in piv_set]
                C_m0 = M0[:, piv_c_v0]
                EM0_keep = (E_mat @ M0[:, keep_c]) & 1
                M0 = (M0[:, keep_c] ^ ((C_m0 @ EM0_keep) & 1)) & 1
                Mk = [(Mk[k][:, keep_c] ^ ((Mk[k][:, piv_c_v0] @ EM0_keep) & 1)) & 1 for k in range(mW)]
                log.append(f"r{rd}:V0={V0.shape[0]},e={r_elim}->({M0.shape[0]}x{M0.shape[1]})")
                if M0.shape[1] == 0:
                    return 0, log

        # 4. SysB augmentation (uncapped!)
        mR, rK = M0.shape
        if mR > mR_cap or rK > rK_cap:
            log.append(f"r{rd}:CAP({mR}x{rK})")
            break
        V0_now = s40a.gf2_nullspace_np(np.hstack(Mk).T)
        sysb_sols = s47b.solve_sysb_basis_c(lib9, Mk, V0_now)
        if sysb_sols.shape[0] == 0:
            log.append(f"r{rd}:sysb=0({mR}x{rK})")
            break
        cur_stack = np.hstack([M0] + Mk)
        _, cur_pivs = s40a.gf2_rref_np(cur_stack)
        cur_rk = len(cur_pivs)
        basis_rows = cur_stack.copy()
        new_M0, new_Mk = [], [[] for _ in range(mW)]
        kept = 0
        for s_i in range(sysb_sols.shape[0]):
            v_mat = sysb_sols[s_i]
            row_Mk = [(v_mat[k] @ ((M0 ^ Mk[k]) & 1)) & 1 for k in range(mW)]
            cand = np.hstack([np.zeros(rK, dtype=np.uint8)] + row_Mk)
            if not cand.any():
                continue
            test_mat = np.vstack([basis_rows, cand[None, :]])
            _, tp = s40a.gf2_rref_np(test_mat)
            if len(tp) > cur_rk:
                cur_rk = len(tp)
                basis_rows = test_mat
                new_M0.append(np.zeros(rK, dtype=np.uint8))
                for k in range(mW):
                    new_Mk[k].append(row_Mk[k])
                kept += 1
                if kept >= keep_cap:
                    break
        if kept == 0:
            log.append(f"r{rd}:sysb={sysb_sols.shape[0]},kept=0")
            break
        M0 = np.vstack([M0, np.array(new_M0, dtype=np.uint8)])
        Mk = [np.vstack([Mk[k], np.array(new_Mk[k], dtype=np.uint8)]) for k in range(mW)]
        log.append(f"r{rd}:SysB({sysb_sols.shape[0]}/+{kept})->({M0.shape[0]}x{M0.shape[1]})")

    return M0.shape[1], log


def gf2_rank_np(A):
    _, pivs = s40a.gf2_rref_np(A)
    return len(pivs)


def find_kernel_seeds(Mk_c, n_trials=400, seed=5555):
    """
    Search for:
      1) Right vectors v in F_2^{rK} with low rank of T(v) = [M_0 v, ..., M_{nW-1} v] (mR x nW)
         -> nullspace(T(v)) is a subspace of W of dim = nW - rk where v in K_R!
      2) Left vectors u in F_2^{mR} with low rank of S(u) = [u^T M_0; ...; u^T M_{nW-1}] (nW x rK)
         -> nullspace(S(u)^T) is a subspace of W of dim = nW - rk where u in V_0!
    Uses both basis vectors, right/left nullspaces of individual Mk_c[k], and random low-weight combos.
    """
    nW = len(Mk_c)
    mR, rK = Mk_c[0].shape
    M_tensor = np.stack(Mk_c, axis=0)  # (nW, mR, rK)

    # Candidate v vectors: unit vectors + right nullspace vectors of each Mk_c[k]
    cand_v = []
    for c in range(rK):
        v = np.zeros(rK, dtype=np.uint8); v[c] = 1
        cand_v.append(v)
    for k in range(nW):
        ns = s40a.gf2_nullspace_np(Mk_c[k])
        for row in ns:
            cand_v.append(row)
    rng = np.random.default_rng(seed)
    for _ in range(n_trials):
        # Random sparse combo of 2 or 3 unit vectors
        v = np.zeros(rK, dtype=np.uint8)
        idx = rng.choice(rK, size=int(rng.choice([2, 3])), replace=False)
        v[idx] = 1
        cand_v.append(v)

    best_v = []
    seen_v = set()
    for v in cand_v:
        vb = v.tobytes()
        if vb in seen_v:
            continue
        seen_v.add(vb)
        # T(v): (mR, nW)
        Tv = np.einsum("wmr,r->mw", M_tensor, v) & 1
        rk = gf2_rank_np(Tv)
        ker_dim = nW - rk
        if ker_dim > 0:
            best_v.append((ker_dim, v, Tv))
    best_v.sort(key=lambda x: -x[0])

    # Candidate u vectors: unit vectors + left nullspace vectors of each Mk_c[k]
    cand_u = []
    for r in range(mR):
        u = np.zeros(mR, dtype=np.uint8); u[r] = 1
        cand_u.append(u)
    for k in range(nW):
        ns = s40a.gf2_nullspace_np(Mk_c[k].T)
        for row in ns[:4]:
            cand_u.append(row)
    best_u = []
    seen_u = set()
    for u in cand_u:
        ub = u.tobytes()
        if ub in seen_u:
            continue
        seen_u.add(ub)
        # S(u): (rK, nW)
        Su = np.einsum("wmr,m->rw", M_tensor, u) & 1
        rk = gf2_rank_np(Su)
        ker_dim = nW - rk
        if ker_dim > 0:
            best_u.append((ker_dim, u, Su))
    best_u.sort(key=lambda x: -x[0])
    return best_v[:10], best_u[:10]


def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    args = parser.parse_args()
    cell_name = args.cell

    print(f"\n==================== [{cell_name}] STEP 55B: UNCAPPED SysB + KERNEL-SEEDED U1 SEARCH ====================", flush=True)

    c_diag, so_diag = WORK_DIR / "s55b_diag.c", WORK_DIR / "libs55b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s55b_s9.c", WORK_DIR / "libs55b_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s55b_cg.c", WORK_DIR / "libs55b_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s55b_sh.c", WORK_DIR / "libs55b_sh.so"
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

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])

    etas = [5, 0] if cell_name == "B0_11" else [0, 1]
    for em in etas:
        sys_ex = s45b.extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=5500 + em)
        nW = sys_ex["nW"]
        M0_c, Mk_c = sys_ex["M0_c"], sys_ex["Mk_c"]
        print(f"\n  === [{cell_name} eta={em}] Pencil: nW={nW}, mR={M0_c.shape[0]}, rK={M0_c.shape[1]} ===", flush=True)

        # PART 1: Uncapped SysB on minrank_basis across d1 = 20..nW
        _, full_bas1, _ = s44a.minrank_basis(Mk_c, rk_cap=24, n_rounds=3, seed=5520 + em)
        U_full = np.zeros((nW, nW), dtype=np.uint8)
        for a, cm in enumerate(full_bas1):
            for k in range(nW):
                if (cm >> k) & 1:
                    U_full[a, k] = 1

        print("  --- PART 1: UNCAPPED SysB (mR_cap=500, rK_cap=30) ---", flush=True)
        d1_tests = [20, 22, 24, 26, 28, 30, 32, 36, nW] if cell_name == "B0_11" else [16, 18, 20, 22, 24, 28, nW]
        for d1 in d1_tests:
            U1 = U_full[:d1]
            Mu1 = [np.zeros_like(M0_c) for _ in range(d1)]
            for a in range(d1):
                for k in range(nW):
                    if U1[a, k]:
                        Mu1[a] ^= Mk_c[k]
            t_d = time.perf_counter()
            rK_f, lg = run_cascade_uncapped(M0_c, Mu1, lib9, max_rounds=10, mR_cap=500, rK_cap=30, keep_cap=128)
            print(f"    d1={d1:2d}(NT1={nW-d1:2d}): final_rK={rK_f:2d} ({time.perf_counter()-t_d:4.1f}s) | {' ; '.join(lg)}", flush=True)

        # PART 2: Kernel-seeded subspace search
        print("  --- PART 2: KERNEL-SEEDED U1 SEARCH ---", flush=True)
        best_v, best_u = find_kernel_seeds(Mk_c, n_trials=400, seed=5555 + em)
        print(f"    Top right-kernel seeds (dim ker T(v)): {[x[0] for x in best_v[:8]]}", flush=True)
        print(f"    Top left-kernel  seeds (dim ker S(u)): {[x[0] for x in best_u[:8]]}", flush=True)

        # Test top left-kernel and right-kernel subspaces directly with uncapped cascade!
        for tag, seeds in [("RightKer_v", best_v[:4]), ("LeftKer_u", best_u[:4])]:
            for idx_s, (kdim, vec, mat) in enumerate(seeds):
                if kdim < 18:
                    continue
                U_ker = s40a.gf2_nullspace_np(mat)  # (kdim, nW)
                d1_k = U_ker.shape[0]
                Mu_k = [np.zeros_like(M0_c) for _ in range(d1_k)]
                for a in range(d1_k):
                    for k in range(nW):
                        if U_ker[a, k]:
                            Mu_k[a] ^= Mk_c[k]
                t_d = time.perf_counter()
                rK_k, lg_k = run_cascade_uncapped(M0_c, Mu_k, lib9, max_rounds=10, mR_cap=500, rK_cap=30, keep_cap=128)
                print(f"    [{tag} #{idx_s}] d1={d1_k:2d}(NT1={nW-d1_k:2d}): final_rK={rK_k:2d} ({time.perf_counter()-t_d:4.1f}s) | {' ; '.join(lg_k)}", flush=True)

        # Also test intersection of top 2 left-kernel seeds if they exist
        if len(best_u) >= 2:
            M_int = np.vstack([best_u[0][2], best_u[1][2]])
            U_int = s40a.gf2_nullspace_np(M_int)
            d1_i = U_int.shape[0]
            if d1_i >= 16:
                Mu_i = [np.zeros_like(M0_c) for _ in range(d1_i)]
                for a in range(d1_i):
                    for k in range(nW):
                        if U_int[a, k]:
                            Mu_i[a] ^= Mk_c[k]
                t_d = time.perf_counter()
                rK_i, lg_i = run_cascade_uncapped(M0_c, Mu_i, lib9, max_rounds=10, mR_cap=500, rK_cap=30, keep_cap=128)
                print(f"    [LeftKer_u0^u1] d1={d1_i:2d}(NT1={nW-d1_i:2d}): final_rK={rK_i:2d} ({time.perf_counter()-t_d:4.1f}s) | {' ; '.join(lg_i)}", flush=True)

    print(f"\n[{cell_name}] STEP 55B DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()

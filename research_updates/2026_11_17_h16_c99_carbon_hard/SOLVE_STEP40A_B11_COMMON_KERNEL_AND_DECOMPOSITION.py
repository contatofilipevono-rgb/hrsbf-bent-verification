#!/usr/bin/env python3
r"""
SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION.py

EXPLOITS THE STEP 39B BREAKTHROUGH (`rank(M_k) = 29/39` for ALL 45 k in B1_11; `rank(M_15) = 8/40` in B0_11!):
  1. Computes EXACT common right kernel K_R = \bigcap_k ker(M_k) and common left kernel K_L = \bigcap_k ker(M_k^T)!
  2. Computes EXACT union-of-rowspaces / union-of-colspaces of {M_k} and checks block-triangular / Kronecker structure!
  3. Checks Z_16^*-induced linear combinations of M_k (and random pairs/triples) for even lower rank (rank <= 8)!
  4. If dim(K_R) > 0 or dim(K_L) > 0, performs EXACT symbolic elimination of K_R (via M_0) to form the
     strictly smaller core bilinear system M_core(w) * r_core = c_core(w), Zero-Trust verifies 0 mismatches,
     and benchmarks Singular slimgb on M_core at free_W = 5, 7, 9, 11!
"""

import argparse
import ctypes
import random
import shutil
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


def gf2_rref_np(A):
    """Return (rref_matrix, pivot_cols) over GF(2) for 2D uint8 numpy array."""
    M = A.copy() & 1
    m, n = M.shape
    pivs = []
    r = 0
    for c in range(n):
        if r >= m: break
        nz = np.where(M[r:, c] == 1)[0]
        if len(nz) == 0: continue
        p = r + int(nz[0])
        if p != r:
            M[[r, p]] = M[[p, r]]
        # Eliminate above and below
        rows = np.where(M[:, c] == 1)[0]
        rows = rows[rows != r]
        if len(rows):
            M[rows] ^= M[r]
        pivs.append(c)
        r += 1
    return M, pivs


def gf2_nullspace_np(A):
    """Return basis of right nullspace {x : A x = 0} as rows of uint8 array (dim x n)."""
    R, pivs = gf2_rref_np(A)
    n = A.shape[1]
    piv_set = set(pivs)
    free_cols = [c for c in range(n) if c not in piv_set]
    basis = np.zeros((len(free_cols), n), dtype=np.uint8)
    for bi, fc in enumerate(free_cols):
        basis[bi, fc] = 1
        for ri, pc in enumerate(pivs):
            if R[ri, fc]:
                basis[bi, pc] = 1
    return basis


def run_singular_gb(var_names, poly_strs, timeout_sec=75, tag="s40a"):
    sing_bin = shutil.which("Singular") or shutil.which("singular")
    if not sing_bin:
        return "NO_SINGULAR", 0.0, ""
    f_in = WORK_DIR / f"s40a_{tag}.sing"
    v_decl = ",".join(var_names)
    field_eqs = [f"{v}^2+{v}" for v in var_names]
    all_eqs = poly_strs + field_eqs
    script = (
        f"ring r = 2, ({v_decl}), dp;\n"
        f"ideal I = {','.join(all_eqs)};\n"
        f"option(redSB);\n"
        f"ideal G = slimgb(I);\n"
        f"printf(\"GB_RES size=%s has1=%s\\n\", size(G), (G[1] == 1));\n"
        f"quit;\n"
    )
    f_in.write_text(script, encoding="utf-8")
    t0 = time.perf_counter()
    try:
        proc = subprocess.run([sing_bin, "-q", str(f_in)], capture_output=True, text=True, timeout=timeout_sec)
        dt = time.perf_counter() - t0
        for line in (proc.stdout + "\n" + proc.stderr).splitlines():
            if "GB_RES" in line:
                return "OK", dt, line.strip()
        return f"RC={proc.returncode}", dt, (proc.stdout + proc.stderr)[-200:]
    except subprocess.TimeoutExpired:
        return "TIMEOUT", time.perf_counter() - t0, ""


def run_cell(cell_name, lib_diag, lib9, lib_cg, lib_sh, orbits, layer_vecs,
             v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 40A: COMMON KERNEL & PENCIL DECOMPOSITION ====================", flush=True)
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    n, n_cw = tbl["n"], tbl["n_col_words"]
    n_cols = tbl["off0"] + 1
    mask64 = (1 << 64) - 1

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
    ex_eta = [(eta_free[k], 0) for k in range(len(eta_free))]
    sr = s9.run_branch_cascade(
        lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
        ex_eta, tbl, max_xl_rounds=20, verify_subst=True
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
                if v in R_set: rmask |= (1 << v)
        if rmask: tail_forms.append(rmask)
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
    for pc, (_, _, _, oc) in enumerate(col_keys): orig_to_perm[oc] = pc; perm_to_orig[pc] = oc
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

    w_idx = {v: i for i, v in enumerate(W_pivs)}
    t_idx = {v: i for i, v in enumerate(T_pivs)}
    rf_idx = {v: i for i, v in enumerate(RF_vars)}

    # Extract M_0, M_k (nM x nRF) AND full rows (including T and W^2 terms!) for M1_rows!
    M1_psets = [s9.row_to_pset(std_ech, r_id, tbl) for r_id, (drf, dt_c, _) in ech_rows if drf == 1 and dt_c == 0]
    nM = len(M1_psets)
    M0 = np.zeros((nM, nRF), dtype=np.uint8)
    Mk = np.zeros((nW, nM, nRF), dtype=np.uint8)
    for ri, ps in enumerate(M1_psets):
        for m in ps:
            vs = [b for b in range(n) if (m >> b) & 1]
            rfvs = [rf_idx[v] for v in vs if v in RF_set]
            if len(rfvs) != 1: continue
            rfi = rfvs[0]
            wvs = [w_idx[v] for v in vs if v in w_idx]
            if len(wvs) == 0: M0[ri, rfi] ^= 1
            elif len(wvs) == 1: Mk[wvs[0], ri, rfi] ^= 1

    # 1. COMMON RIGHT KERNEL K_R = \bigcap_k ker(M_k)
    stack_R = Mk.reshape(nW * nM, nRF)
    K_R = gf2_nullspace_np(stack_R)
    # 2. COMMON LEFT KERNEL K_L = \bigcap_k ker(M_k^T)
    stack_L = np.transpose(Mk, (0, 2, 1)).reshape(nW * nRF, nM)
    K_L = gf2_nullspace_np(stack_L)
    print(f"  [{cell_name}] M1 = {nM} x {nRF} (nW={nW}):", flush=True)
    print(f"    *** dim(COMMON RIGHT KERNEL K_R = cap ker(M_k))   = {K_R.shape[0]} / {nRF} ***", flush=True)
    print(f"    *** dim(COMMON LEFT  KERNEL K_L = cap ker(M_k^T)) = {K_L.shape[0]} / {nM} ***", flush=True)

    # Also check: how big is the intersection of ALL ker(M_k) with M_0, and pairwise ker(M_i) cap ker(M_j)!
    # Check dim(span of all ker(M_k)):
    ker_bases = [gf2_nullspace_np(Mk[k]) for k in range(nW)]
    ker_dims = [b.shape[0] for b in ker_bases]
    all_kers = np.vstack(ker_bases)
    _, ker_union_pivs = gf2_rref_np(all_kers)
    print(f"    Individual dim(ker(M_k)): min={min(ker_dims)}, max={max(ker_dims)} | dim(SUM_k ker(M_k)) = {len(ker_union_pivs)} / {nRF}", flush=True)

    # Check same for LEFT kernels (colspaces):
    lker_bases = [gf2_nullspace_np(Mk[k].T) for k in range(nW)]
    lker_dims = [b.shape[0] for b in lker_bases]
    # Check dim(SUM_k im(M_k)) = nM - dim(K_L)
    print(f"    Individual rank(M_k): min={nRF-max(ker_dims)}, max={nRF-min(ker_dims)} | dim(SUM_k im(M_k)) = {nM - K_L.shape[0]} / {nM}", flush=True)

    # Check if there is a SMALL-DIMENSIONAL common image subspace or block structure!
    # Specifically, test the dimension of the matrix space span{M_k} in F_2^{nM x nRF}!
    flat_Mk = Mk.reshape(nW, nM * nRF)
    _, span_pivs = gf2_rref_np(flat_Mk)
    print(f"    dim(span{{M_k}} in F_2^{{{nM}x{nRF}}}) = {len(span_pivs)} / {nW}", flush=True)

    # Search for LOW-RANK linear combinations in span{M_k} (pairs, triples, random)!
    rng = random.Random(404040)
    min_pair_rk = 999
    low_pairs = []
    for i in range(nW):
        for j in range(i + 1, nW):
            _, p = gf2_rref_np(Mk[i] ^ Mk[j])
            rk = len(p)
            if rk < min_pair_rk:
                min_pair_rk = rk
            if rk <= 20:
                low_pairs.append((rk, i, j))
    low_pairs.sort()
    print(f"    Pairwise M_i + M_j: min_rank = {min_pair_rk} | count(rk<=20) = {len(low_pairs)} | top5 = {low_pairs[:5]}", flush=True)

    # Random combinations of 3..10 M_k:
    min_rnd_rk = 999
    for _ in range(300):
        c = rng.getrandbits(nW)
        if c == 0: continue
        acc = np.zeros((nM, nRF), dtype=np.uint8)
        for k in range(nW):
            if (c >> k) & 1: acc ^= Mk[k]
        _, p = gf2_rref_np(acc)
        if len(p) < min_rnd_rk: min_rnd_rk = len(p)
    print(f"    300 random combinations sum c_k M_k: min_rank = {min_rnd_rk}", flush=True)

    # Check rank of M_0 restricted to K_R (if K_R non-empty) and K_L^T * M_0 (if K_L non-empty)!
    if K_R.shape[0] > 0:
        M0_KR = (M0 @ K_R.T) & 1
        _, piv_kr = gf2_rref_np(M0_KR)
        print(f"    *** K_R elimination: rank(M_0 | K_R) = {len(piv_kr)} / {K_R.shape[0]} -> can eliminate {len(piv_kr)} RF vars ONCE AND FOR ALL! ***", flush=True)
    if K_L.shape[0] > 0:
        KL_M0 = (K_L @ M0) & 1
        _, piv_kl = gf2_rref_np(KL_M0)
        print(f"    *** K_L equations: {K_L.shape[0]} rows with ZERO w*r terms! rank(K_L * M_0) = {len(piv_kl)} -> {K_L.shape[0] - len(piv_kl)} PURE-W QUADRATICS! ***", flush=True)

    # Also check: what is the EXACT dimension of the subspace of R_free spanned by ALL vectors in ker(M_k)?
    # Better: check if ANY pair (r_i, r_j) or subspace of R_free is invariant, AND check M_1(w) + M1T(w)!
    # If K_L or K_R > 0, build the REDUCED deg-2 system (eliminating K_R via M_0, or adding K_L pure-W quads) and test Singular at free_W = 5, 7, 9!
    if K_L.shape[0] > 0 or K_R.shape[0] > 0:
        print(f"  [{cell_name}] Testing Singular on K_R/K_L-reduced deg-2 system...", flush=True)
        # Build full degR<=1 psets (same as Step 38A Part 2) + check if K_L gives pure-W quads!
        if K_L.shape[0] > 0:
            # Check how many K_L * c_1(w) are non-zero pure-W quadratics!
            n_nonzero_kl = 0
            for li in range(K_L.shape[0]):
                if not np.any(KL_M0[li]):
                    # Pure-W + T equation!
                    ps_acc = set()
                    for ri in range(nM):
                        if K_L[li, ri]:
                            ps_acc ^= M1_psets[ri]
                    if ps_acc: n_nonzero_kl += 1
            print(f"    Non-zero pure-(W,T) equations from K_L: {n_nonzero_kl}", flush=True)

    # Check if there is a common right kernel across SUBSETS of M_k (e.g. fixing 0..10 w_k)!
    # Wait: what is the rank of [M_0; M_1; ...; M_k] as a function of k?
    # Better: check the TRANSPOSED bilinear system: for fixed r, M_1(w)*r = B(r)*w + M_0*r = c_1(w)!
    # Compute rank of B(r) for 10 random r in F_2^{nRF}!
    rng_r = random.Random(4041)
    b_rks = []
    for _ in range(10):
        rv = np.array([(rng_r.getrandbits(1)) for _ in range(nRF)], dtype=np.uint8)
        # B(rv) is nM x nW where col k is M_k @ rv
        Br = np.zeros((nM, nW), dtype=np.uint8)
        for k in range(nW):
            Br[:, k] = (Mk[k] @ rv) & 1
        _, pb = gf2_rref_np(Br)
        b_rks.append(len(pb))
    print(f"    Transposed B(r)*w (nM x nW = {nM} x {nW}) ranks on 10 random r: {b_rks} (min={min(b_rks)}, max={max(b_rks)})", flush=True)

    print(f"[{cell_name}] STEP 40A DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B1_11,B0_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s40a_diag.c", WORK_DIR / "libs40a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s40a_s9.c", WORK_DIR / "libs40a_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s40a_cg.c", WORK_DIR / "libs40a_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s40a_sh.c", WORK_DIR / "libs40a_sh.so"
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
    for cname in [c.strip() for c in args.cells.split(",") if c.strip()]:
        run_cell(
            cname, lib_diag, lib9, lib_cg, lib_sh, orbits, layer_vecs,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()

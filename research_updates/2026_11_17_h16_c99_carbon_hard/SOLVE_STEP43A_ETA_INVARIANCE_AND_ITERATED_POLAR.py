#!/usr/bin/env python3
r"""
SOLVE_STEP43A_ETA_INVARIANCE_AND_ITERATED_POLAR.py

TWO DECISIVE STRUCTURAL AUDITS ON BOTH B0_11 AND B1_11:
  PART 1: EXACT eta-DEPENDENCE AUDIT ACROSS 4 DISTINCT Z_16^* ORBITS (eta = 0, 1, 4, 5):
    - Tests whether W_pivs, W_rref, T_pivs, RF_vars, K_R, and the bilinear pencil Mk
      are invariant (or how they vary) across the 16 Z_16^*-orbits of eta!
  PART 2: SELF-CONTAINED POLAR LEFT-INVERSE + ISOTROPIC FLAT + ROUND-2 MINRANK INSIDE U:
    - Searches over low-rank flag dimensions d_flag for common right kernel K with a CONSTANT
      left inverse L (L @ B0 = I_r, L @ Bk = 0 for all k).
    - Builds exact global residual M_res(w) (affine N-rows + quadratic H-rows), Zero-Trust verifies
      0 mismatches against [N; H] @ M_core(w) @ [r_C; r_K].
    - Finds quadratic polar radical + isotropic flat U (dim NU, fibers = 2^{nW - NU}).
    - Runs ROUND-2 K_R, ROUND-2 MinRank, AND checks if a SECOND polar left-inverse exists inside U!
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
import SOLVE_STEP17_ELIM_ORDER_R_GT_B_SCHUR4 as s17
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP40C_B11_LOWRANK_BASIS_SHATTER as s40c


def gf2_inv_np(S):
    r = S.shape[0]
    aug = np.hstack([S.copy() & 1, np.eye(r, dtype=np.uint8)])
    for col in range(r):
        nz = np.where(aug[col:, col] == 1)[0]
        assert len(nz) > 0, f"Singular {r}x{r} GF(2) matrix at col {col}"
        p = col + int(nz[0])
        if p != col:
            aug[[col, p]] = aug[[p, col]]
        rows = np.where(aug[:, col] == 1)[0]
        rows = rows[rows != col]
        if len(rows):
            aug[rows] ^= aug[col]
    return aug[:, r:] & 1


def extract_eta_pencil(em, root, eta_free, lib9, lib_sh, tbl):
    n, n_cw = tbl["n"], tbl["n_col_words"]
    n_cols = tbl["off0"] + 1
    mask64 = (1 << 64) - 1
    n_ef = len(eta_free)
    ex_eta = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
    sr = s9.run_branch_cascade(
        lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
        ex_eta, tbl, max_xl_rounds=20, verify_subst=(em == 0)
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
    rf_idx = {v: i for i, v in enumerate(RF_vars)}
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

    K_R = s40a.gf2_nullspace_np(Mk.reshape(nW * nM, nRF))
    M0_KR = (M0 @ K_R.T) & 1
    L_core = s40a.gf2_nullspace_np(M0_KR.T)
    n_core = L_core.shape[0]
    _, kr_pivs = s40a.gf2_rref_np(K_R)
    core_rf_cols = [c for c in range(nRF) if c not in set(kr_pivs)]
    nRC = len(core_rf_cols)
    M0_c = (L_core @ M0)[:, core_rf_cols] & 1
    Mk_c = np.zeros((nW, n_core, nRC), dtype=np.uint8)
    for k in range(nW):
        Mk_c[k] = (L_core @ Mk[k])[:, core_rf_cols] & 1

    return {
        "W_pivs": W_pivs, "W_rref": W_rref, "T_pivs": T_pivs, "RF_vars": RF_vars,
        "M0": M0, "Mk": Mk, "K_R": K_R, "M0_c": M0_c, "Mk_c": Mk_c,
        "nW": nW, "nT": nT, "nRF": nRF, "nM": nM, "n_core": n_core, "nRC": nRC,
    }


def poly_mat_mul_left(A_left, pm):
    """Multiply constant binary matrix A_left on the left of polynomial matrix pm={mask: mat}."""
    out = {}
    for m, B in pm.items():
        C = (A_left @ B) & 1
        if C.any():
            out[m] = C
    return out


def poly_mat_mul_mats(P1, P2):
    """Multiply two polynomial matrices over GF(2)[w]: sum_{m1, m2} (P1[m1] @ P2[m2]) * w^{m1|m2}."""
    out = {}
    for m1, A1 in P1.items():
        if not A1.any(): continue
        for m2, A2 in P2.items():
            if not A2.any(): continue
            C = (A1 @ A2) & 1
            if not C.any(): continue
            m = m1 | m2
            if m in out:
                out[m] ^= C
            else:
                out[m] = C
    return {m: C for m, C in out.items() if C.any()}


def isotropic_flat_from_poly_mat(pm_quad, nW):
    """Find quadratic polar radical + isotropic flat U (mirrored from Step 55)."""
    deg2 = [(m, A) for m, A in pm_quad.items() if m.bit_count() == 2 and A.any()]
    if not deg2:
        return 0, nW, np.eye(nW, dtype=np.uint8)
    r_sz = deg2[0][1].shape[0]
    c_sz = deg2[0][1].shape[1]
    rc_sz = r_sz * c_sz
    polar = np.zeros((nW, rc_sz, nW), dtype=np.uint8)
    for m, A in deg2:
        bits = [k for k in range(nW) if (m >> k) & 1]
        i, j = bits[0], bits[1]
        flat = A.ravel()
        polar[i, :, j] = flat
        polar[j, :, i] = flat
    radical = s40a.gf2_nullspace_np(polar.reshape(nW * rc_sz, nW))
    rad_dim = radical.shape[0]
    _, pivs = s40a.gf2_rref_np(radical)
    piv_set = set(pivs)
    J = np.eye(nW, dtype=np.uint8)[[j for j in range(nW) if j not in piv_set]]
    q = J.shape[0]
    if q == 0:
        return rad_dim, nW, radical
    t1 = np.tensordot(J, polar, axes=(1, 0)) & 1
    polar_q = (np.tensordot(t1, J, axes=(2, 1))) & 1  # shape (q, rc_sz, q)

    # Greedy isotropic extension on polar_q!
    candidates = np.eye(q, dtype=np.uint8)
    flat_vecs = []
    while candidates.shape[0] > 0:
        # Pick row p of candidates maximizing remaining nullspace of pairing(p, candidates^T)
        best = None
        for idx in range(candidates.shape[0]):
            v = candidates[idx]
            # Compute pairing matrix: (rc_sz, q) = sum_{a: v[a]==1} polar_q[a]
            p_mat = (np.tensordot(v, polar_q, axes=(0, 0))) & 1  # (rc_sz, q)
            eqs = (p_mat @ candidates.T) & 1  # (rc_sz, n_cand)
            ns = s40a.gf2_nullspace_np(eqs)  # rows in F_2^{n_cand}
            new_cands = (ns @ candidates) & 1
            # Remove directions linearly dependent on flat_vecs + [v]
            # Wait: just record (new_cands.shape[0], -idx, v, new_cands)
            # Check v itself is isotropic wrt p_mat (since diag=0 in GF(2) symmetric form, v @ p_mat @ v == 0 automatically!)
            cand_score = (new_cands.shape[0], -idx)
            if best is None or cand_score > best[0]:
                best = (cand_score, v, new_cands)
        _, v_pick, new_cands = best
        flat_vecs.append(v_pick)
        # Filter new_cands to quotient mod span(flat_vecs)!
        fv_arr = np.array(flat_vecs, dtype=np.uint8)
        _, fpivs = s40a.gf2_rref_np(fv_arr)
        rem = []
        piv_dict = {}
        # Build RREF basis of flat_vecs as int bitmasks over q
        for row in fv_arr:
            m = sum((1 << c) for c in range(q) if row[c])
            while m:
                b = m.bit_length() - 1
                if b in piv_dict: m ^= piv_dict[b]
                else: piv_dict[b] = m; break
        kept = []
        for row in new_cands:
            m = sum((1 << c) for c in range(q) if row[c])
            cur = m
            while cur:
                b = cur.bit_length() - 1
                if b in piv_dict: cur ^= piv_dict[b]
                else:
                    piv_dict[b] = cur
                    kept.append(row)
                    break
        candidates = np.array(kept, dtype=np.uint8) if kept else np.zeros((0, q), dtype=np.uint8)

    flat_arr = np.array(flat_vecs, dtype=np.uint8)
    lifted = (flat_arr @ J) & 1
    U = np.vstack([radical, lifted]) if rad_dim > 0 else lifted
    return rad_dim, U.shape[0], U


def run_cell(cell_name, lib_diag, lib9, lib_cg, lib_sh, orbits, layer_vecs,
             v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 43A: ETA-INVARIANCE + ITERATED POLAR ====================", flush=True)
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

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])

    # ---------------- PART 1: EXACT ETA-DEPENDENCE AUDIT (eta = 0, 1, 4, 5) ----------------
    print(f"\n  --- PART 1: ETA-DEPENDENCE AUDIT ACROSS 4 ORBITS eta=(0, 1, 4, 5) ({cell_name}) ---", flush=True)
    etad = {}
    for em in [0, 1, 4, 5]:
        etad[em] = extract_eta_pencil(em, root, eta_free, lib9, lib_sh, tbl)
    d0 = etad[0]
    for em in [0, 1, 4, 5]:
        de = etad[em]
        same_w = (de["W_pivs"] == d0["W_pivs"]) and (de["W_rref"] == d0["W_rref"])
        same_rf = (de["RF_vars"] == d0["RF_vars"])
        same_t = (de["T_pivs"] == d0["T_pivs"])
        same_kr = np.array_equal(s40a.gf2_rref_np(de["K_R"])[0], s40a.gf2_rref_np(d0["K_R"])[0])
        rks_c = [len(s40a.gf2_rref_np(de["Mk_c"][k])[1]) for k in range(de["nW"])]
        m0_diff = not np.array_equal(de["M0"], d0["M0"]) if de["M0"].shape == d0["M0"].shape else True
        # Check if Mk rowspaces match eta=0! Flatten along columns of M1 -> shape (nM, nW * nRF)
        mk_same_span = False
        if same_w and same_rf and de["Mk"].shape == d0["Mk"].shape:
            f0 = np.transpose(d0["Mk"], (1, 0, 2)).reshape(d0["nM"], d0["nW"] * d0["nRF"])
            fe = np.transpose(de["Mk"], (1, 0, 2)).reshape(de["nM"], de["nW"] * de["nRF"])
            _, p0 = s40a.gf2_rref_np(f0)
            _, pu = s40a.gf2_rref_np(np.vstack([f0, fe]))
            mk_same_span = (len(p0) == len(pu))
            exact_mk = np.array_equal(de["Mk"], d0["Mk"])
        else:
            exact_mk = False
        print(
            f"    [eta={em}] shape={de['nM']}x{de['nRF']} -> core={de['n_core']}x{de['nRC']} | "
            f"same_W={same_w}, same_T={same_t}, same_RF={same_rf}, same_KR={same_kr} | "
            f"exact_Mk={exact_mk}, same_Mk_rowspan={mk_same_span}, M0_diff={m0_diff} | rk(Mk_c)=[{min(rks_c)}..{max(rks_c)}]",
            flush=True
        )

    # ---------------- PART 2: SELF-CONTAINED POLAR LEFT-INVERSE + ISOTROPIC FLAT + ROUND-2 MINRANK ----------------
    print(f"\n  --- PART 2: POLAR LEFT-INVERSE + ISOTROPIC FLAT + ROUND-2 MINRANK ({cell_name}) ---", flush=True)
    M0_c, Mk_c = d0["M0_c"], d0["Mk_c"]
    nW, n_core, nRC = d0["nW"], d0["n_core"], d0["nRC"]

    def mat_of(cm):
        acc = np.zeros((n_core, nRC), dtype=np.uint8)
        for k in range(nW):
            if (cm >> k) & 1: acc ^= Mk_c[k]
        return acc

    found_low = {}
    def record_c(cm):
        if cm == 0 or cm in found_low: return
        rk = len(s40a.gf2_rref_np(mat_of(cm))[1])
        if rk <= 24: found_low[cm] = rk

    for i in range(nW):
        record_c(1 << i)
        for j in range(i + 1, nW): record_c((1 << i) | (1 << j))
    tested_v = set()
    rng = random.Random(4343)
    def probe_v(v):
        key = v.tobytes()
        if key in tested_v: return
        tested_v.add(key)
        Bv = np.zeros((n_core, nW), dtype=np.uint8)
        for k in range(nW): Bv[:, k] = (Mk_c[k] @ v) & 1
        for row in s40a.gf2_nullspace_np(Bv):
            record_c(sum((1 << k) for k in range(nW) if row[k]))
    for j in range(nRC):
        e = np.zeros(nRC, dtype=np.uint8); e[j] = 1
        probe_v(e)
    for _ in range(3):
        cands = [cm for cm, rk in sorted(found_low.items(), key=lambda x: x[1]) if 1 <= rk <= 22][:16]
        for cm in cands:
            K = s40a.gf2_nullspace_np(mat_of(cm))
            for row in K: probe_v(row)
    full_basis, _ = s40c.gf2_basis_masks(
        [cm for cm, _ in sorted(found_low.items(), key=lambda x: (x[1], x[0].bit_count()))] + [1 << k for k in range(nW)]
    )

    best_polar = None
    for d_flag in [2, 3, 4, 6, 8, 10, 12, 14, 16, 20, 24, 28, 30, 32, 34, 36]:
        if d_flag > nW: continue
        row_stack = np.array([mat_of(cm) for cm in full_basis[:d_flag]], dtype=np.uint8).reshape(d_flag * n_core, nRC)
        K = s40a.gf2_nullspace_np(row_stack)
        r = K.shape[0]
        if r == 0: continue
        B0 = (M0_c @ K.T) & 1
        Bk = [(Mk_c[k] @ K.T) & 1 for k in range(nW)]
        V_const = s40a.gf2_nullspace_np(np.hstack(Bk).T)
        if V_const.shape[0] == 0:
            r_elim = 0
            piv_cols = []
        else:
            P = (V_const @ B0) & 1
            _, piv_cols = s40a.gf2_rref_np(P)
            r_elim = len(piv_cols)
        print(f"    d_flag={d_flag:2d}: r=dim(K)={r:2d}, dim(V_const)={V_const.shape[0]:2d}, r_elim={r_elim:2d}", flush=True)
        if r_elim >= 2:
            cand = (r_elim, d_flag, K, piv_cols, V_const)
            if best_polar is None or (cand[0], cand[1]) > (best_polar[0], best_polar[1]):
                best_polar = cand

    if best_polar is not None:
        r_elim, d_flag, K, piv_cols, V_const = best_polar
        K_use = K[piv_cols]  # r_elim x nRC
        B0_use = (M0_c @ K_use.T) & 1
        Bk_use = [(Mk_c[k] @ K_use.T) & 1 for k in range(nW)]
        P_use = (V_const @ B0_use) & 1  # m_v x r_elim, rank r_elim
        _, v_row_idxs = s40a.gf2_rref_np(P_use.T)
        S_inv = gf2_inv_np(P_use[v_row_idxs])
        L = (S_inv @ V_const[v_row_idxs]) & 1  # r_elim x n_core
        assert np.array_equal((L @ B0_use) & 1, np.eye(r_elim, dtype=np.uint8))
        for k in range(nW):
            assert not ((L @ Bk_use[k]) & 1).any()

        # Construct N (left nullspace of [B0_use, Bk_use...]) and H (row complement of [N; L])
        N = s40a.gf2_nullspace_np(np.hstack([B0_use] + Bk_use).T)
        LN = np.vstack([L, N]) if N.shape[0] > 0 else L
        _, ln_col_pivs = s40a.gf2_rref_np(LN)
        h_cols = [c for c in range(n_core) if c not in set(ln_col_pivs)]
        H = np.eye(n_core, dtype=np.uint8)[h_cols]
        NH = np.vstack([N, H]) if N.shape[0] > 0 else H
        assert len(s40a.gf2_rref_np(np.vstack([NH, L]))[1]) == n_core

        # Column complement C (nRC x nRC_res)
        _, k_col_pivs = s40a.gf2_rref_np(K_use)
        comp_cols = [c for c in range(nRC) if c not in set(k_col_pivs)]
        C = np.eye(nRC, dtype=np.uint8)[comp_cols]
        nRC_res = C.shape[1]

        # Build polynomial matrices D(w) = M_core(w) @ C, B(w) = M_core(w) @ K_use.T
        D_pm = {0: (M0_c @ C) & 1}
        B_pm = {0: B0_use}
        for k in range(nW):
            dk = (Mk_c[k] @ C) & 1
            if dk.any(): D_pm[1 << k] = dk
            if Bk_use[k].any(): B_pm[1 << k] = Bk_use[k]

        LD_pm = poly_mat_mul_left(L, D_pm)
        ND_pm = poly_mat_mul_left(N, D_pm) if N.shape[0] > 0 else {}
        HD_pm = poly_mat_mul_left(H, D_pm) if H.shape[0] > 0 else {}
        HB_pm = poly_mat_mul_left(H, B_pm) if H.shape[0] > 0 else {}
        H_quad = poly_mat_mul_mats(HB_pm, LD_pm)

        # Combine HD_pm and H_quad
        H_tot = {}
        for m, A in HD_pm.items(): H_tot[m] = A.copy()
        for m, A in H_quad.items():
            if m in H_tot: H_tot[m] ^= A
            else: H_tot[m] = A.copy()
        H_tot = {m: A for m, A in H_tot.items() if A.any()}

        # Build full residual matrix M_res(w) = vstack(N-rows, H-rows) of shape (n_core - r_elim, nRC_res)
        nN = N.shape[0]
        nH = H.shape[0]
        n_res_rows = nN + nH
        assert n_res_rows == n_core - r_elim
        M_res = {}
        for m in (ND_pm.keys() | H_tot.keys()):
            top = ND_pm.get(m, np.zeros((nN, nRC_res), dtype=np.uint8))
            bot = H_tot.get(m, np.zeros((nH, nRC_res), dtype=np.uint8))
            full = np.vstack([top, bot]) if (nN > 0 and nH > 0) else (top if nH == 0 else bot)
            if full.any():
                M_res[m] = full

        # ZERO-TRUST CHECK on 10 random (w, r_C) points!
        rng_zt = random.Random(434300)
        zt_mis = 0
        for _ in range(10):
            wb = rng_zt.getrandbits(nW)
            rC = np.array([rng_zt.getrandbits(1) for _ in range(nRC_res)], dtype=np.uint8)
            M_w = M0_c.copy()
            for k in range(nW):
                if (wb >> k) & 1: M_w ^= Mk_c[k]
            Dw = (M_w @ C) & 1
            rK = (L @ Dw @ rC) & 1
            r_full = ((C @ rC) ^ (K_use.T @ rK)) & 1
            lhs_check = (L @ M_w @ r_full) & 1
            assert not lhs_check.any(), "L @ M(w) @ r != 0!"
            rhs_orig = (NH @ M_w @ r_full) & 1
            # Evaluate M_res(wb) @ rC
            Mres_w = np.zeros((n_res_rows, nRC_res), dtype=np.uint8)
            for m, A in M_res.items():
                if (m & wb) == m: Mres_w ^= A
            rhs_res = (Mres_w @ rC) & 1
            if not np.array_equal(rhs_orig, rhs_res):
                zt_mis += 1
        max_deg = max((m.bit_count() for m in M_res.keys()), default=0)
        n_quad_m = sum(1 for m in M_res.keys() if m.bit_count() == 2)
        print(
            f"  *** [{cell_name}] POLAR RESIDUAL BUILT: d_flag={d_flag}, r_elim={r_elim} -> M_res={n_res_rows}x{nRC_res} "
            f"(N_affine={nN}, H_quad={nH}, max_deg={max_deg}, deg2_monomials={n_quad_m}) | ZT mismatches={zt_mis} ***",
            flush=True
        )
        assert zt_mis == 0

        # Find quadratic polar radical & isotropic flat U!
        rad_dim, NU, U = isotropic_flat_from_poly_mat(M_res, nW)
        NT = nW - NU
        print(f"  *** [{cell_name}] ISOTROPIC FLAT U: radical_dim={rad_dim}, NU={NU}/{nW}, NT={NT} (fibers=2^{NT}) ***", flush=True)

        # Restrict M_res(w) to flat w = U.T @ u (t=0 fiber) and Zero-Trust verify linearity + 10 random u points!
        M_u0 = M_res.get(0, np.zeros((n_res_rows, nRC_res), dtype=np.uint8)).copy()
        M_ua = np.zeros((NU, n_res_rows, nRC_res), dtype=np.uint8)
        M_deg2_u = {}
        for m, A in M_res.items():
            if m == 0: continue
            if m.bit_count() == 1:
                k = m.bit_length() - 1
                for a in range(NU):
                    if U[a, k]: M_ua[a] ^= A
            elif m.bit_count() == 2:
                b0 = m.bit_length() - 1
                b1 = (m ^ (1 << b0)).bit_length() - 1
                for a in range(NU):
                    if U[a, b1] and U[a, b0]: M_ua[a] ^= A
                    for b in range(a + 1, NU):
                        if (U[a, b0] & U[b, b1]) ^ (U[b, b0] & U[a, b1]):
                            key = (1 << a) | (1 << b)
                            M_deg2_u[key] = (M_deg2_u.get(key, np.zeros_like(A)) ^ A)
        leftover_q = sum(1 for A in M_deg2_u.values() if A.any())
        assert leftover_q == 0, f"Isotropic flat failed: {leftover_q} quadratic terms remain!"
        # ZT verify linear specialization on U
        for _ in range(10):
            ub = np.array([rng_zt.getrandbits(1) for _ in range(NU)], dtype=np.uint8)
            w_arr = (U.T @ ub) & 1
            wb = sum((1 << k) for k in range(nW) if w_arr[k])
            Mres_w = np.zeros((n_res_rows, nRC_res), dtype=np.uint8)
            for m, A in M_res.items():
                if (m & wb) == m: Mres_w ^= A
            Mu_val = M_u0.copy()
            for a in range(NU):
                if ub[a]: Mu_val ^= M_ua[a]
            assert np.array_equal(Mres_w, Mu_val), "U-specialization mismatch!"

        # ROUND-2 K_R, MinRank, AND 2nd POLAR LEFT-INVERSE INSIDE U!
        K_R2 = s40a.gf2_nullspace_np(M_ua.reshape(NU * n_res_rows, nRC_res))
        K_L2 = s40a.gf2_nullspace_np(np.transpose(M_ua, (0, 2, 1)).reshape(NU * nRC_res, n_res_rows))
        rks_u = [len(s40a.gf2_rref_np(M_ua[a])[1]) for a in range(NU)]

        def mat2_of(cm):
            acc = np.zeros((n_res_rows, nRC_res), dtype=np.uint8)
            for a in range(NU):
                if (cm >> a) & 1: acc ^= M_ua[a]
            return acc
        low2 = {}
        rk2_cap = max(4, min(18, nRC_res - 2))
        for i in range(NU):
            rk = len(s40a.gf2_rref_np(M_ua[i])[1])
            if rk <= rk2_cap: low2[1 << i] = rk
            for j in range(i + 1, NU):
                rk2 = len(s40a.gf2_rref_np(M_ua[i] ^ M_ua[j])[1])
                if rk2 <= rk2_cap: low2[(1 << i) | (1 << j)] = rk2
        for c in range(nRC_res):
            e = np.zeros(nRC_res, dtype=np.uint8); e[c] = 1
            Bv = np.zeros((n_res_rows, NU), dtype=np.uint8)
            for a in range(NU): Bv[:, a] = (M_ua[a] @ e) & 1
            for row in s40a.gf2_nullspace_np(Bv):
                cm = sum((1 << a) for a in range(NU) if row[a])
                if cm and cm not in low2:
                    rk = len(s40a.gf2_rref_np(mat2_of(cm))[1])
                    if rk <= rk2_cap: low2[cm] = rk
        bas2, _ = s40c.gf2_basis_masks([cm for cm, _ in sorted(low2.items(), key=lambda x: (x[1], x[0].bit_count()))])
        full_bas2, _ = s40c.gf2_basis_masks(bas2 + [1 << a for a in range(NU)])

        best_r2_elim = 0
        for df2 in [2, 4, 6, 8, 12, 16, 20, 24]:
            if df2 > NU: continue
            rstack = np.array([mat2_of(cm) for cm in full_bas2[:df2]], dtype=np.uint8).reshape(df2 * n_res_rows, nRC_res)
            K2 = s40a.gf2_nullspace_np(rstack)
            if K2.shape[0] == 0: continue
            B02 = (M_u0 @ K2.T) & 1
            Bk2 = [(M_ua[a] @ K2.T) & 1 for a in range(NU)]
            Vc2 = s40a.gf2_nullspace_np(np.hstack(Bk2).T)
            r2_e = len(s40a.gf2_rref_np((Vc2 @ B02) & 1)[1]) if Vc2.shape[0] > 0 else 0
            if r2_e > best_r2_elim: best_r2_elim = r2_e

        print(
            f"  *** [{cell_name}] ROUND-2 INSIDE U ({n_res_rows}x{nRC_res}, NU={NU}): K_R^(2)={K_R2.shape[0]}, "
            f"K_L^(2)={K_L2.shape[0]}, rk(M_ua)=[{min(rks_u)}..{max(rks_u)}], low_bas2(rk<={rk2_cap})={len(bas2)}/{NU} "
            f"top_rks={[low2[c] for c in bas2[:10]]} | 2nd_POLAR_r_elim={best_r2_elim} ***",
            flush=True
        )

    print(f"[{cell_name}] STEP 43A DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s43a_diag.c", WORK_DIR / "libs43a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s43a_s9.c", WORK_DIR / "libs43a_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s43a_cg.c", WORK_DIR / "libs43a_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s43a_sh.c", WORK_DIR / "libs43a_sh.so"
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

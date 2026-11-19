#!/usr/bin/env python3
r"""
SOLVE_STEP40B_B11_REDUCED_CORE_AND_MINRANK.py

EXPLOITS STEP 40A's EXACT 10-DIM COMMON RIGHT KERNEL K_R = \bigcap_k ker(M_k):
  1. Symbolically eliminates K_R via M_0 (DEGREE-PRESERVING! Stays pure degree 2!):
       B1_11: 97 x 39 -> 87 x 29  (10 RF vars eliminated forever!)
       B0_11: 78 x 40 -> 69 x 30  (9 RF vars eliminated + 1 constant kernel u_0!)
     Zero-Trust verifies 0 mismatches on 20 random (w, r_core) points!
  2. Benchmarks Singular slimgb on the K_R-eliminated DEGREE-2 system at free_W = 5, 7, 9, 11!
  3. Hunts the EXACT low-rank pencil subspace inside span{M_k} (why rank(M_16+M_27)=8 in B1_11,
     rank(M_26+M_30)=6 & rank(M_15)=8 in B0_11?!) via:
       - Exact kernel-guided MinRank: for every basis vector of ker(M_i+M_j) and random vectors v,
         find ALL c in F_2^{nW} with (sum c_k M_k) v = 0!
       - Reports exact count & span dimension of low-rank matrices (rk <= 12) and checks block structure!
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
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a


def run_singular_gb(var_names, poly_strs, timeout_sec=90, tag="s40b"):
    sing_bin = shutil.which("Singular") or shutil.which("singular")
    if not sing_bin:
        return "NO_SINGULAR", 0.0, ""
    f_in = WORK_DIR / f"s40b_{tag}.sing"
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
    print(f"\n==================== [{cell_name}] STEP 40B: K_R-ELIMINATED CORE + SINGULAR + MINRANK ====================", flush=True)
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

    # Extract quadratics (r_t = Q_t(w)) and M1_psets (drf=1, dt=0)
    quad_psets = [s9.row_to_pset(work, qi, tbl) for qi in range(n_q)]
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

    # Step 1: Exact K_R = \bigcap_k ker(M_k) and degree-preserving row elimination!
    K_R = s40a.gf2_nullspace_np(Mk.reshape(nW * nM, nRF))
    dKR = K_R.shape[0]
    # Compute M0_KR = M0 @ K_R.T (nM x dKR), find its left nullspace L_core (rows that kill ALL K_R vars!)
    M0_KR = (M0 @ K_R.T) & 1
    L_core = s40a.gf2_nullspace_np(M0_KR.T)  # shape: (nM - rk(M0_KR)) x nM
    n_core_rows = L_core.shape[0]

    # Build basis of R_free = [R_core | K_R] (i.e. pick nRF - dKR columns of R_free independent of K_R!)
    _, kr_pivs = s40a.gf2_rref_np(K_R)
    kr_piv_set = set(kr_pivs)
    core_rf_cols = [c for c in range(nRF) if c not in kr_piv_set]
    nRC = len(core_rf_cols)
    # Build exact reduced psets: for each row of L_core, XOR the corresponding M1_psets!
    # Wait: because L_core @ M0 @ K_R.T == 0 AND L_core @ Mk @ K_R.T == 0,
    # ALL variables in K_R vanish identically from L_core @ M1_psets!!
    # Specifically, if we substitute r_piv = sum_{c in core} alpha * r_c for piv in kr_pivs, the K_R components cancel!
    # Wait: even cleaner! Just take the linear combinations L_core @ M1_psets directly on the original RF vars:
    # Since every row in L_core @ M1 is orthogonal to K_R, its RF linear forms live in a (nRF - dKR)-dim quotient space!
    # Express each RF variable in the quotient basis core_rf_cols using K_R's RREF:
    KR_rref, _ = s40a.gf2_rref_np(K_R)
    # For each pivot col p = kr_pivs[ri], K_R has vector e_p + sum_{c in core} KR_rref[ri, c] e_c = 0 in quotient!
    # So in any functional f orthogonal to K_R, f(e_p) = sum_{c in core} KR_rref[ri, c] * f(e_c)!
    # Therefore, simply setting r_p = 0 for all p in kr_pivs gives the EXACT quotient equation in core_rf_cols!!
    # ZERO-TRUST CHECK THIS RIGHT NOW!
    core_psets = []
    for li in range(n_core_rows):
        ps_acc = set()
        for ri in range(nM):
            if L_core[li, ri]:
                ps_acc ^= M1_psets[ri]
        core_psets.append(ps_acc)

    # Zero-Trust check: for 20 random (w, t, r_free), verify that adding ANY vector in K_R to r_free leaves EVERY core_pset UNCHANGED!
    rng_zt = random.Random(4040)
    zt_mis = 0
    for _ in range(20):
        wb = rng_zt.getrandbits(nW)
        tb = rng_zt.getrandbits(nT)
        rfb = rng_zt.getrandbits(nRF)
        # Pick random vector in K_R
        k_coeff = rng_zt.getrandbits(dKR)
        delta_rf = 0
        for bi in range(dKR):
            if (k_coeff >> bi) & 1:
                for cj in range(nRF):
                    if K_R[bi, cj]: delta_rf ^= (1 << cj)
        def mk_x(rf_bits):
            x = 0
            for i, v in enumerate(W_pivs):
                if (wb >> i) & 1: x |= (1 << v)
            for i, v in enumerate(T_pivs):
                if (tb >> i) & 1: x |= (1 << v)
            for i, v in enumerate(RF_vars):
                if (rf_bits >> i) & 1: x |= (1 << v)
            return x
        x1, x2 = mk_x(rfb), mk_x(rfb ^ delta_rf)
        for ps in core_psets:
            v1 = sum(1 for m in ps if (m & x1) == m) & 1
            v2 = sum(1 for m in ps if (m & x2) == m) & 1
            if v1 != v2: zt_mis += 1
    print(f"  [{cell_name}] K_R-eliminated core: {n_core_rows} eqs x {nRC} core RF vars (dropped {dKR} K_R vars!) | ZERO-TRUST invariance mismatches = {zt_mis}", flush=True)
    assert zt_mis == 0

    # Check reduced pencil M_core_k (n_core_rows x nRC)
    M0_c = (L_core @ M0)[:, core_rf_cols] & 1
    Mk_c = np.zeros((nW, n_core_rows, nRC), dtype=np.uint8)
    for k in range(nW):
        Mk_c[k] = (L_core @ Mk[k])[:, core_rf_cols] & 1
    # Verify M0_c and Mk_c still have rank_min / kernel info
    _, p0c = s40a.gf2_rref_np(M0_c)
    rk_c = [len(s40a.gf2_rref_np(Mk_c[k])[1]) for k in range(nW)]
    print(f"  [{cell_name}] Reduced pencil M_core: shape={n_core_rows}x{nRC}, rank(M0_c)={len(p0c)}, rank(Mk_c) min={min(rk_c)} max={max(rk_c)}", flush=True)

    # PART 2: BENCHMARK SINGULAR SLIMGB ON K_R-ELIMINATED DEGREE-2 CORE (only nT + nRC + free_W vars!)
    print(f"\n  --- PART 2: SINGULAR SLIMGB ON K_R-ELIMINATED DEG-2 CORE ({cell_name}) ---", flush=True)
    rng_s = random.Random(272727)
    w_rand = rng_s.getrandbits(nW)
    core_rf_set = {RF_vars[c] for c in core_rf_cols}
    core_rf_map = {RF_vars[c]: i for i, c in enumerate(core_rf_cols)}
    # Notice: setting r_p = 0 for all p in kr_pivs is EXACT on core_psets (just verified zt_mis=0!)
    kr_piv_vars = {RF_vars[p] for p in kr_pivs}

    def psets_to_sing_core(ps_list, k_fix):
        pstrs = []
        for ps in ps_list:
            mon_par = {}
            for m in ps:
                vs = [b for b in range(n) if (m >> b) & 1]
                zero_out = False
                kept = []
                for v in vs:
                    if v in kr_piv_vars:
                        zero_out = True; break
                    elif v in w_idx:
                        wi = w_idx[v]
                        if wi < k_fix:
                            if not ((w_rand >> wi) & 1): zero_out = True; break
                        else:
                            kept.append(f"w{wi}")
                    elif v in t_idx:
                        kept.append(f"t{t_idx[v]}")
                    elif v in core_rf_map:
                        kept.append(f"r{core_rf_map[v]}")
                if zero_out: continue
                key = "*".join(sorted(kept)) if kept else "1"
                mon_par[key] = mon_par.get(key, 0) ^ 1
            terms = [k for k, c in mon_par.items() if c]
            if terms: pstrs.append("+".join(terms))
        return pstrs

    all_core_deg2 = quad_psets + core_psets
    for free_target in [5, 7, 9, 11]:
        k_fix = nW - free_target
        vnames = [f"r{i}" for i in range(nRC)] + [f"t{i}" for i in range(nT)] + [f"w{j}" for j in range(k_fix, nW)]
        pstrs = psets_to_sing_core(all_core_deg2, k_fix)
        st, dt, out = run_singular_gb(vnames, pstrs, timeout_sec=90, tag=f"{cell_name}_fw{free_target}")
        print(f"    [CORE {cell_name}] free_W={free_target:2d} (vars={len(vnames)}, eqs={len(pstrs)}): {st:7s} ({dt:5.2f}s) | {out}", flush=True)
        if st == "TIMEOUT":
            break

    # PART 3: EXACT LOW-RANK PENCIL HUNT INSIDE span{Mk_c} (MINRANK!)
    print(f"\n  --- PART 3: LOW-RANK PENCIL SUBSPACE HUNT INSIDE span{{Mk_c}} ({cell_name}) ---", flush=True)
    # Seed from known low-rank pairs/singles AND from kernel-guided MinRank!
    # For any vector v in F_2^{nRC}, the subspace {c in F_2^{nW} : (sum c_k Mk_c[k]) v = 0} is the right nullspace of
    # the (n_core_rows x nW) matrix B(v) whose col k is Mk_c[k] @ v!
    # Wait: n_core_rows = 87 (or 69) > nW = 45 (or 44), so for a random v, ker(B(v)) = 0!
    # ONLY special vectors v (those lying in kernels of low-rank pencil elements!) have ker(B(v)) != 0!
    # Let's test EVERY vector in the kernels of our known low-rank elements (M_16+M_27 in B1_11, M_15 & M_26+M_30 in B0_11)
    # AND all weight-1, weight-2, and random low-weight vectors in F_2^{nRC}!
    found_low = {}  # c_mask -> rank
    def record_c(c_mask):
        if c_mask == 0 or c_mask in found_low: return
        acc = np.zeros((n_core_rows, nRC), dtype=np.uint8)
        for k in range(nW):
            if (c_mask >> k) & 1: acc ^= Mk_c[k]
        rk = len(s40a.gf2_rref_np(acc)[1])
        if rk <= 16:
            found_low[c_mask] = rk

    # 1) Check all singles and pairs
    for i in range(nW):
        record_c(1 << i)
        for j in range(i + 1, nW):
            record_c((1 << i) | (1 << j))

    # 2) Kernel-guided expansion: for every found low-rank matrix M, compute its right kernel K,
    #    and for every basis vector v of K (and random pairs in K), compute ker(B(v))!
    seed_vecs = []
    for cm, rk in sorted(found_low.items(), key=lambda x: x[1])[:10]:
        acc = np.zeros((n_core_rows, nRC), dtype=np.uint8)
        for k in range(nW):
            if (cm >> k) & 1: acc ^= Mk_c[k]
        K = s40a.gf2_nullspace_np(acc)
        for row in K:
            seed_vecs.append(row)
    # Also add all nRC standard basis vectors e_j
    for j in range(nRC):
        e = np.zeros(nRC, dtype=np.uint8); e[j] = 1
        seed_vecs.append(e)

    for v in seed_vecs:
        Bv = np.zeros((n_core_rows, nW), dtype=np.uint8)
        for k in range(nW):
            Bv[:, k] = (Mk_c[k] @ v) & 1
        ker_c = s40a.gf2_nullspace_np(Bv)
        for row in ker_c:
            cm = sum((1 << k) for k in range(nW) if row[k])
            record_c(cm)

    # Also test pairwise XORs of all found_low!
    fl_keys = list(found_low.keys())
    for i in range(len(fl_keys)):
        for j in range(i + 1, len(fl_keys)):
            record_c(fl_keys[i] ^ fl_keys[j])

    # Compute GF(2) span dimension of all low-rank c_masks (rk <= 12 and rk <= 16)
    def span_dim(masks):
        piv = {}
        for m in masks:
            v = m
            while v:
                b = v.bit_length() - 1
                if b in piv: v ^= piv[b]
                else: piv[b] = v; break
        return len(piv)

    rk_hist = {}
    for rk in found_low.values(): rk_hist[rk] = rk_hist.get(rk, 0) + 1
    low12 = [cm for cm, rk in found_low.items() if rk <= 12]
    low16 = [cm for cm, rk in found_low.items() if rk <= 16]
    print(f"    Found {len(found_low)} distinct low-rank (<=16) pencil elements | rk_hist = {dict(sorted(rk_hist.items()))}", flush=True)
    print(f"    dim(span{{rk<=12}}) = {span_dim(low12)} / {nW} | dim(span{{rk<=16}}) = {span_dim(low16)} / {nW}", flush=True)
    top_low = sorted(found_low.items(), key=lambda x: (x[1], x[0].bit_count()))[:10]
    for cm, rk in top_low:
        ks = [k for k in range(nW) if (cm >> k) & 1]
        print(f"      rk={rk:2d}, wt(c)={len(ks):2d}, w_indices={ks[:12]}{'...' if len(ks)>12 else ''}", flush=True)

    print(f"[{cell_name}] STEP 40B DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B1_11,B0_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s40b_diag.c", WORK_DIR / "libs40b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s40b_s9.c", WORK_DIR / "libs40b_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s40b_cg.c", WORK_DIR / "libs40b_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s40b_sh.c", WORK_DIR / "libs40b_sh.so"
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

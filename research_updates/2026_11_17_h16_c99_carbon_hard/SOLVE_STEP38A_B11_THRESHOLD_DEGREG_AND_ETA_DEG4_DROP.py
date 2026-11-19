#!/usr/bin/env python3
r"""
SOLVE_STEP27B_GROEBNER_F4_PROBE.py

TESTS INDUSTRIAL SPARSE F4 / GROEBNER BASIS SOLVERS (`msolve` / `Singular` over F_2[x]/(x^2+x)) ON:
  1. B0_00: Exact Groebner basis of the pure-W quadratic systems of `eta=62` (46 quads / 38 vars)
     and `eta=42` (28 quads / 30 vars) — reveals exact dimension, linear factors, & Hilbert function!
  2. B0_11 & B1_11 (eta=0): Sparse F4 / slimgb on the exact `A(w)*r = b(w)` subsystem (95/114 eqs)
     calibrated at k_fix = 35, 30, 25, 20, 0 fixed W-variables!
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
import SOLVE_STEP12A_B0_00_NORMAL_BENT_CRUSH as s12a
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP17_ELIM_ORDER_R_GT_B_SCHUR4 as s17
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19
import SOLVE_STEP22A_B000_ENUM_CLOSE_ETA62_63_42_AND_ETA0 as s22a
import SOLVE_STEP36_C8_ORBIT_WALSH_KERNEL_LOCAL as s36


def run_singular_gb(var_names, poly_strs, timeout_sec=90, tag="gb", block_split=None, prot=False):
    """Run Singular `slimgb` over GF(2) with field equations x_i^2 + x_i = 0."""
    sing_bin = shutil.which("Singular") or shutil.which("singular")
    if not sing_bin:
        return "NO_SINGULAR", 0.0, ""
    f_in = WORK_DIR / f"s38a_{tag}.sing"
    v_decl = ",".join(var_names)
    field_eqs = [f"{v}^2+{v}" for v in var_names]
    all_eqs = poly_strs + field_eqs
    if block_split is not None and 0 < block_split < len(var_names):
        ord_str = f"(dp({block_split}), dp({len(var_names) - block_split}))"
    else:
        ord_str = "dp"
    prot_line = "option(prot);\n" if prot else ""
    script = (
        f"ring r = 2, ({v_decl}), {ord_str};\n"
        f"ideal I = {','.join(all_eqs)};\n"
        f"option(redSB);\n"
        f"{prot_line}"
        f"ideal G = slimgb(I);\n"
        f"int sz = size(G);\n"
        f"int has1 = (G[1] == 1);\n"
        f"printf(\"\\nGB_RES size=%s has1=%s\\n\", sz, has1);\n"
        f"quit;\n"
    )
    f_in.write_text(script, encoding="utf-8")
    t0 = time.perf_counter()
    try:
        proc = subprocess.run([sing_bin, "-q", str(f_in)], capture_output=True, text=True, timeout=timeout_sec)
        dt = time.perf_counter() - t0
        out = (proc.stdout + "\n" + proc.stderr).strip()
        gb_line = ""
        prot_degs = []
        for line in out.splitlines():
            if "GB_RES" in line:
                gb_line = line.strip()
            elif prot and line.strip().startswith("[") or ("(" in line and ")" in line and ("." in line or "-" in line or "s" in line)):
                prot_degs.append(line.strip())
        if gb_line:
            p_tail = " | prot=" + " ".join(prot_degs)[:120] if prot else ""
            return "OK", dt, gb_line + p_tail
        return f"RC={proc.returncode}", dt, out[-300:]
    except subprocess.TimeoutExpired:
        return "TIMEOUT", time.perf_counter() - t0, ""


def mul_w_polys(p1, p2):
    """Multiply two GF(2) polynomials in W (represented as sets of int bitmasks)."""
    res = set()
    for a in p1:
        for b in p2:
            m = a | b
            if m in res: res.remove(m)
            else: res.add(m)
    return res


def xor_w_polys(p1, p2):
    return p1 ^ p2


def eval_w_poly(p, w_bits):
    v = 0
    for m in p:
        if (m & w_bits) == m:
            v ^= 1
    return v


def find_tight_mus(rows_A, rhs_b, n_cols, rng, n_trials=60):
    """Find a tight minimal inconsistent subset (MUS) of A*r = b over GF(2) via randomized row perms."""
    m = len(rows_A)
    best_mask = None
    best_wt = m + 1
    idxs = list(range(m))
    for _ in range(n_trials):
        rng.shuffle(idxs)
        piv = {}  # col -> (row_vec, rhs_bit, comb_mask)
        for ri in idxs:
            v = rows_A[ri]
            b = rhs_b[ri]
            cm = 1 << ri
            while v:
                c = v.bit_length() - 1
                if c in piv:
                    pv, pb, pcm = piv[c]
                    v ^= pv; b ^= pb; cm ^= pcm
                else:
                    piv[c] = (v, b, cm)
                    break
            else:
                if b == 1:
                    wt = cm.bit_count()
                    if wt < best_wt:
                        best_wt = wt
                        best_mask = cm
                    break
    return best_mask, best_wt


def linear_sys_to_singular_strs(eq_list, w_rand, k_fix, nW, nRF):
    """Convert list of (coeff_polys_per_rf_dict, rhs_poly) to Singular strings with w[0..k_fix-1] fixed."""
    pstrs = []
    for coeff_dict, rhs_p in eq_list:
        mon_par = {}
        def add_w_poly(wp, prefix_str):
            for wm in wp:
                zero_out = False
                kept = [prefix_str] if prefix_str else []
                tmp = wm
                while tmp:
                    lb = tmp & -tmp
                    wi = lb.bit_length() - 1
                    tmp ^= lb
                    if wi < k_fix:
                        if not ((w_rand >> wi) & 1):
                            zero_out = True; break
                    else:
                        kept.append(f"w{wi}")
                if zero_out: continue
                key = "*".join(sorted(kept)) if kept else "1"
                mon_par[key] = mon_par.get(key, 0) ^ 1
        for rfi, wp in coeff_dict.items():
            add_w_poly(wp, f"r{rfi}")
        add_w_poly(rhs_p, "")
        terms = [k for k, c in mon_par.items() if c]
        if terms:
            pstrs.append("+".join(terms))
    return pstrs


def run_msolve_gb(var_names, poly_strs, timeout_sec=90, tag="ms"):
    """Run msolve (-g 1 for GB over GF(2)) if installed."""
    ms_bin = shutil.which("msolve")
    if not ms_bin:
        return "NO_MSOLVE", 0.0, ""
    f_in = WORK_DIR / f"s27b_{tag}.ms"
    f_out = WORK_DIR / f"s27b_{tag}.ms.out"
    field_eqs = [f"{v}^2+{v}" for v in var_names]
    content = ",".join(var_names) + "\n2\n" + ",\n".join(poly_strs + field_eqs) + "\n"
    f_in.write_text(content, encoding="utf-8")
    t0 = time.perf_counter()
    try:
        proc = subprocess.run([ms_bin, "-t", "4", "-g", "1", "-f", str(f_in), "-o", str(f_out)],
                              capture_output=True, text=True, timeout=timeout_sec)
        dt = time.perf_counter() - t0
        if proc.returncode == 0 and f_out.exists():
            txt = f_out.read_text(encoding="utf-8")[:200].replace("\n", " ")
            return "OK", dt, f"len={f_out.stat().st_size} head={txt}"
        return f"RC={proc.returncode}", dt, (proc.stderr or proc.stdout)[-200:]
    except subprocess.TimeoutExpired:
        return "TIMEOUT", time.perf_counter() - t0, ""


def run_step27b_cell(cell_name, lib_diag, lib9, lib_cg, lib_sh, lib_d8, orbits, layer_vecs, orb_tt_np,
                     v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 27B: GROEBNER / F4 PROBE (Singular & msolve) ====================", flush=True)
    print(f"  Available binaries: Singular={shutil.which('Singular')}, msolve={shutil.which('msolve')}", flush=True)
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

    d8_buf, n_d8 = None, 0
    if cell_name == "B0_00":
        b_tt = np.zeros((111, 65536), dtype=np.uint8)
        for i, m in enumerate(cb111):
            tmp = m
            while tmp: lb = tmp & -tmp; b_tt[i] ^= orb_tt_np[lb.bit_length() - 1]; tmp ^= lb
        seen_a, d8_specs = set(), []
        for a in range(1, 256):
            if a in seen_a: continue
            orb_a = [((a << s) | (a >> (8 - s))) & 0xFF for s in range(8)]
            seen_a.update(orb_a)
            olen = len(set(orb_a))
            d8_specs.append((a, 3))
            if olen == 4: d8_specs.append((a, 4))
            elif olen == 2: d8_specs.append((a, 5))
            elif olen == 1: d8_specs.append((a, 6))
        n_d8 = len(d8_specs)
        d8_buf = (ctypes.c_uint64 * (n_d8 * n_cw))()
        for idx_d, (a, sb) in enumerate(d8_specs):
            pts = np.array([v | ((v ^ a) << 8) for v in range(256)], dtype=np.uint16)
            b_words = (ctypes.c_uint64 * (111 * 4))()
            for i in range(111):
                bits = b_tt[i, pts]
                for w in range(4):
                    val = 0
                    for b in range(64):
                        if bits[w * 64 + b]: val |= (1 << b)
                    b_words[i * 4 + w] = val
            rptr = ctypes.cast(ctypes.byref(d8_buf, idx_d * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            lib_d8.extract_deg3_coset_poly(
                b_words, sb, n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw,
                tbl["col2_base"], tbl["col3_base"], rptr
            )

    sys_data = diag_v2.build_cell_algebraic_system(cell_name, lib_diag, orbits, v6_list, rot4_data, fiber_meta, extract_sec=18.0)
    cyc_cubs = s9.extract_verified_cyclotomic_cubics(cell_name, orbits, origin111, cb111, layers, c0x0)
    n_base = sum(sys_data["deg_pivs_111"].values())
    total_raw = n_base + len(cyc_cubs) + n_cg + n_d8
    raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, raw_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)
    if n_d8:
        ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs) + n_cg) * n_cw * 8), d8_buf, n_d8 * n_cw * 8)

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])
    n_ef = len(eta_free)

    if cell_name == "B0_00":
        # Test exact Groebner basis of pure-W quadratic systems of eta=42 (28/30), eta=43 (21/29), eta=62 (46/38)!
        for em in [42, 43, 62]:
            ex = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
            sr = s9.run_branch_cascade(
                lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
                ex, tbl, max_xl_rounds=20, verify_subst=False
            )
            qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
            ana = s16.analyze_quad_system(qps)
            W_rref = s19.strict_rref_masks(list(ana["W_piv"].values()))
            W_pivs, pure_y = s22a.extract_pure_w_quads(lib_sh, sr, W_rref, tbl)
            nW = len(W_pivs)
            vnames = [f"w{i}" for i in range(nW)]
            pstrs = []
            for qm in pure_y:
                terms = []
                for m in qm:
                    if m == 0: terms.append("1")
                    else:
                        vs = [f"w{b}" for b in range(nW) if (m >> b) & 1]
                        terms.append("*".join(vs))
                pstrs.append("+".join(terms))
            st_s, dt_s, out_s = run_singular_gb(vnames, pstrs, timeout_sec=120, tag=f"b000_eta{em}")
            print(f"  [B0_00 eta={em}] Singular slimgb (nW={nW}, pure_q={len(pure_y)}): {st_s} ({dt_s:.2f}s) | {out_s}", flush=True)
            st_m, dt_m, out_m = run_msolve_gb(vnames, pstrs, timeout_sec=120, tag=f"b000_eta{em}")
            if st_m != "NO_MSOLVE":
                print(f"  [B0_00 eta={em}] msolve F4 (nW={nW}, pure_q={len(pure_y)}): {st_m} ({dt_m:.2f}s) | {out_m}", flush=True)
    else:
        # B0_11 / B1_11: 3-block shear R_free > R_tail(17) > W_ess, substitute r_t = Q_t(w),
        # run MUS anatomy on M_1 and M_full, and benchmark REDUCED Singular slimgb (dp & block elim)!
        ex_eta = [(eta_free[k], 0) for k in range(n_ef)]
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

        # Extract linear R-masks of the 17 quadratics to form strict RREF R_tail
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

        # Echelonize under elimination order (deg_RF, deg_T, total_deg)
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

        # Step A: Exact 17x17 Gauss-Jordan on the n_q quadratics in work[0..n_q-1] to get ALL 17 r_t = Q_t(w)!
        q_rows = []
        for qi in range(n_q):
            ps = s9.row_to_pset(work, qi, tbl)
            tmask = 0
            w_poly = set()
            for m in ps:
                vs = [b for b in range(n) if (m >> b) & 1]
                rfvs = [v for v in vs if v in RF_set]
                tvs = [t_idx[v] for v in vs if v in T_set]
                wvs = [w_idx[v] for v in vs if v in w_idx]
                assert len(rfvs) == 0, f"Unexpected RF var in quadratic {qi}"
                if len(tvs) == 1 and len(wvs) == 0:
                    tmask ^= (1 << tvs[0])
                elif len(tvs) == 0:
                    wm = 0
                    for wi in wvs: wm |= (1 << wi)
                    w_poly ^= {wm}
                else:
                    raise AssertionError(f"Unexpected T*W term in quadratic {qi}: tvs={tvs}, wvs={wvs}")
            q_rows.append([tmask, w_poly])
        # Full Gauss-Jordan elimination on q_rows (17x17)
        Q_subs = {}
        for ti in range(nT):
            piv_i = None
            for i in range(ti, len(q_rows)):
                if (q_rows[i][0] >> ti) & 1:
                    piv_i = i; break
            assert piv_i is not None, f"T_piv {ti} missing from quadratics!"
            q_rows[ti], q_rows[piv_i] = q_rows[piv_i], q_rows[ti]
            for j in range(len(q_rows)):
                if j != ti and ((q_rows[j][0] >> ti) & 1):
                    q_rows[j][0] ^= q_rows[ti][0]
                    q_rows[j][1] ^= q_rows[ti][1]
        for ti in range(nT):
            assert q_rows[ti][0] == (1 << ti), f"Row {ti} not unit vector: {bin(q_rows[ti][0])}"
            Q_subs[ti] = q_rows[ti][1]

        # Step B: Classify ech_rows by leading column (drf, dt_c):
        #   M1:  leading (drf=1, dt_c=0) -> linear in r_free, affine coeff in w (after r_t=Q_t(w) in tail)
        #   M1T: leading (drf=1, dt_c=1) -> linear in r_free, quadratic coeff in w (after r_t=Q_t(w))
        M1_raw, M1T_raw = [], []
        for r_id, (drf, dt_c, d_lead) in ech_rows:
            if drf == 1 and dt_c == 0:
                M1_raw.append(s9.row_to_pset(std_ech, r_id, tbl))
            elif drf == 1 and dt_c == 1:
                M1T_raw.append(s9.row_to_pset(std_ech, r_id, tbl))

        print(f"  [{cell_name}] 3-block shear: nW={nW}, nT={nT} (Q_subs={len(Q_subs)}), nRF={nRF} | M1={len(M1_raw)}, M1T={len(M1T_raw)}", flush=True)
        assert len(Q_subs) == nT

        # Pre-parse M1_raw and M1T_raw into fast tuples: list of (rf_id_or_-1, t_mask, w_mask)
        def parse_lin_rf_raw(ps):
            terms = []
            for m in ps:
                vs = [b for b in range(n) if (m >> b) & 1]
                rfvs = [rf_idx[v] for v in vs if v in RF_set]
                tvs = [t_idx[v] for v in vs if v in T_set]
                wvs = [w_idx[v] for v in vs if v in w_idx]
                assert len(rfvs) <= 1, f"Unexpected RF^2 term in drf<=1 row!"
                tm = 0
                for ti in tvs: tm |= (1 << ti)
                wm = 0
                for wi in wvs: wm |= (1 << wi)
                terms.append((rfvs[0] if rfvs else -1, tm, wm))
            return terms

        M1_parsed = [parse_lin_rf_raw(ps) for ps in M1_raw]
        M1T_parsed = [parse_lin_rf_raw(ps) for ps in M1T_raw]
        M_full_parsed = M1_parsed + M1T_parsed

        # Fast evaluation of M(w)*r_free = c(w) at fixed wb (evaluating t_bits = Q_t(wb) in microseconds!)
        def eval_sys_at_w(parsed_sys, wb):
            t_bits = 0
            for ti in range(nT):
                if eval_w_poly(Q_subs[ti], wb):
                    t_bits |= (1 << ti)
            rows_A, rhs_b = [], []
            for terms in parsed_sys:
                rv = 0
                rb = 0
                for rfi, tm, wm in terms:
                    if ((tm & t_bits) == tm) and ((wm & wb) == wm):
                        if rfi >= 0: rv ^= (1 << rfi)
                        else: rb ^= 1
                rows_A.append(rv)
                rhs_b.append(rb)
            return rows_A, rhs_b, t_bits

        # ZERO-TRUST CHECK: verify eval_sys_at_w matches original sheared polynomials on 20 random (w, r_free) points!
        rng_zt = random.Random(282828)
        zt_mis = 0
        for _ in range(20):
            wb = rng_zt.getrandbits(nW)
            rfb = rng_zt.getrandbits(nRF)
            rows_A, rhs_b, t_bits = eval_sys_at_w(M_full_parsed, wb)
            x_full = 0
            for i, v in enumerate(W_pivs):
                if (wb >> i) & 1: x_full |= (1 << v)
            for i, v in enumerate(RF_vars):
                if (rfb >> i) & 1: x_full |= (1 << v)
            for ti, v in enumerate(T_pivs):
                if (t_bits >> ti) & 1: x_full |= (1 << v)
            for ps, rv, rb in zip(M1_raw + M1T_raw, rows_A, rhs_b):
                v_orig = 0
                for m in ps:
                    if (m & x_full) == m: v_orig ^= 1
                v_sub = (((rv & rfb).bit_count()) & 1) ^ rb
                if v_orig != v_sub: zt_mis += 1
        print(f"  [{cell_name}] ZERO-TRUST r_t=Q_t(w) substitution check (20 pts x {len(M_full_parsed)} eqs): mismatches = {zt_mis}", flush=True)
        assert zt_mis == 0

        # PART 1: EXACT k_* CLOSURE THRESHOLD ON W_ess (RREF vs REVERSE vs HIGH-DEGREE ORDER)
        print(f"\n  --- PART 1: EXACT k_* CLOSURE THRESHOLD ON W_ess ({cell_name}, nW={nW}) ---", flush=True)
        W_forms = [W_rref[p] for p in W_pivs]
        # Score each W-var by how many M1_raw bilinear terms r_free * w_i it appears in!
        w_freq = [0] * nW
        for terms in M1_parsed:
            for rfi, tm, wm in terms:
                if rfi >= 0:
                    tmp = wm
                    while tmp:
                        lb = tmp & -tmp
                        w_freq[lb.bit_length() - 1] += 1
                        tmp ^= lb
        order_rref = list(range(nW))
        order_freq = sorted(range(nW), key=lambda i: -w_freq[i])
        print(f"    W_ess M1-bilinear freq range: min={min(w_freq)}, max={max(w_freq)}, top5={[(i, w_freq[i]) for i in order_freq[:5]]}", flush=True)

        rng_k = random.Random(383838)
        for ord_name, ord_idx in [("RREF_prefix", order_rref), ("HIGH_FREQ", order_freq)]:
            print(f"    [Order: {ord_name}]", flush=True)
            for k_fix in [42, 40, 38, 36, 34, 32, 30, 28, 25, 20]:
                if k_fix > nW: continue
                n_cl = 0
                min_N, max_q = 999, 0
                for tr in range(8):
                    wb = rng_k.getrandbits(nW)
                    ex_w = [(W_forms[ord_idx[j]], (wb >> j) & 1) for j in range(k_fix)]
                    sub = s9.run_branch_cascade(
                        lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                        ex_w, tbl, max_xl_rounds=15, verify_subst=(tr == 0 and k_fix == 40)
                    )
                    if sub["closed_unsat"]: n_cl += 1
                    else:
                        min_N = min(min_N, 111 - len(sub["_lin_pivs"]))
                        max_q = max(max_q, len(sub["_quad_ids"]))
                print(f"      k_fix={k_fix:2d} (free_W={nW-k_fix:2d}): CLOSED={n_cl}/8 | open_min_N={min_N}, open_max_q={max_q}", flush=True)
                if n_cl == 0 and k_fix <= 30:
                    break

        # PART 2: SINGULAR SLIMGB DEGREE OF REGULARITY — REAL B1_11/B0_11 vs MATCHED RANDOM BILINEAR SYSTEM!
        print(f"\n  --- PART 2: SINGULAR DEGREE-OF-REGULARITY — REAL vs RANDOM ({cell_name}) ---", flush=True)
        degR_le1_psets = []
        for r_id, (drf, dt_c, d_lead) in ech_rows:
            ps = s9.row_to_pset(std_ech, r_id, tbl)
            max_r = max((sum(1 for b in range(n) if ((m >> b) & 1) and (b in R_set)) for m in ps), default=0)
            if max_r <= 1:
                degR_le1_psets.append(ps)
        r_all_idx = {v: i for i, v in enumerate(R_vars)}
        nR_all = len(R_vars)
        rng_s = random.Random(272727)
        w_rand = rng_s.getrandbits(nW)

        def psets_to_singular(ps_list, k_fix):
            pstrs = []
            for ps in ps_list:
                mon_par = {}
                for m in ps:
                    vs = [b for b in range(n) if (m >> b) & 1]
                    zero_out = False
                    kept = []
                    for v in vs:
                        if v in w_idx:
                            wi = w_idx[v]
                            if wi < k_fix:
                                if not ((w_rand >> wi) & 1): zero_out = True; break
                            else:
                                kept.append(f"w{wi}")
                        elif v in r_all_idx:
                            kept.append(f"r{r_all_idx[v]}")
                    if zero_out: continue
                    key = "*".join(sorted(kept)) if kept else "1"
                    mon_par[key] = mon_par.get(key, 0) ^ 1
                terms = [k for k, c in mon_par.items() if c]
                if terms: pstrs.append("+".join(terms))
            return pstrs

        def make_random_matched_bilinear(n_r, n_fw, n_q_sub, n_m1, seed=9999):
            """Generate random bilinear system with EXACT same shape: n_q_sub quads r_t = Q_t(w) + n_m1 affine M1(w)*r = c(w)."""
            rg = random.Random(seed)
            pstrs = []
            # n_q_sub random quadratics r_t + Q_t(w_free)
            for t in range(n_q_sub):
                terms = [f"r{t}"]
                for a in range(n_fw):
                    if rg.getrandbits(1): terms.append(f"w{a}")
                    for b in range(a + 1, n_fw):
                        if rg.getrandbits(1): terms.append(f"w{a}*w{b}")
                if rg.getrandbits(1): terms.append("1")
                pstrs.append("+".join(terms))
            # n_m1 random affine-in-w, linear-in-r + quadratic-in-w RHS
            for _ in range(n_m1):
                terms = []
                for ri in range(n_r):
                    if rg.getrandbits(1): terms.append(f"r{ri}")
                    for a in range(n_fw):
                        if rg.getrandbits(1): terms.append(f"r{ri}*w{a}")
                for a in range(n_fw):
                    if rg.getrandbits(1): terms.append(f"w{a}")
                    for b in range(a + 1, n_fw):
                        if rg.getrandbits(1): terms.append(f"w{a}*w{b}")
                if rg.getrandbits(1): terms.append("1")
                if terms: pstrs.append("+".join(terms))
            return pstrs

        for free_target in [3, 5, 7]:
            k_fix = nW - free_target
            free_w = list(range(k_fix, nW))
            vnames_real = [f"r{i}" for i in range(nR_all)] + [f"w{j}" for j in free_w]
            pstrs_real = psets_to_singular(degR_le1_psets, k_fix)
            st_r, dt_r, out_r = run_singular_gb(vnames_real, pstrs_real, timeout_sec=75, tag=f"real_{cell_name}_fw{free_target}", prot=True)
            print(f"    [REAL   {cell_name}] free_W={free_target} (eqs={len(pstrs_real)}): {st_r:7s} ({dt_r:5.2f}s) | {out_r}", flush=True)

            vnames_rnd = [f"r{i}" for i in range(nR_all)] + [f"w{j}" for j in range(free_target)]
            pstrs_rnd = make_random_matched_bilinear(nR_all, free_target, nT, len(M1_raw), seed=3800 + free_target)
            st_x, dt_x, out_x = run_singular_gb(vnames_rnd, pstrs_rnd, timeout_sec=75, tag=f"rand_{cell_name}_fw{free_target}", prot=True)
            print(f"    [RANDOM {cell_name}] free_W={free_target} (eqs={len(pstrs_rnd)}): {st_x:7s} ({dt_x:5.2f}s) | {out_x}", flush=True)

        # PART 3: DO ANY DEGREE-4 C_8-ORBIT DUAL-WALSH CONGRUENCES DROP TO DEGREE <= 3 ON eta = 0 (N = 101)?!
        print(f"\n  --- PART 3: DEGREE-4 C_8-WALSH CONGRUENCES DEGREE-DROP TEST ON eta = 0 ({cell_name}) ---", flush=True)
        seen_c8 = set()
        c8_orbs = []
        for b in range(256):
            if b in seen_c8: continue
            orb, cur = [], b
            while cur not in seen_c8:
                seen_c8.add(cur); orb.append(cur)
                cur = ((cur << 1) | (cur >> 7)) & 0xFF
            c8_orbs.append(orb)
        z_reps = [o[0] for o in c8_orbs]
        A_c8 = np.array([[sum(-1 if ((b & z).bit_count() & 1) else 1 for b in orb) for orb in c8_orbs] for z in z_reps], dtype=np.int64)
        orb_b0_par = np.array([sum(b & 1 for b in o) & 1 for o in c8_orbs], dtype=np.int64)
        pts_all = [np.array([u | ((u ^ z) << 8) for u in range(256)], dtype=np.uint16) for z in z_reps]

        # Build origin & basis truth tables for eta=0 affine subspace!
        orig_tt = np.zeros(65536, dtype=np.uint8)
        for o in range(116):
            if (origin111 >> o) & 1: orig_tt ^= orb_tt_np[o]
        b_tt = np.zeros((111, 65536), dtype=np.uint8)
        for i in range(111):
            acc = np.zeros(65536, dtype=np.uint8)
            for o in range(116):
                if (cb111[i] >> o) & 1: acc ^= orb_tt_np[o]
            b_tt[i] = acc
        lp_eta = sr["_lin_pivs"]
        act_eta = [i for i in range(111) if i not in lp_eta]

        def rand_eta_pt(rg):
            x = 0
            for av in act_eta:
                if rg.getrandbits(1): x |= (1 << av)
            for lp, (pm, pr) in lp_eta.items():
                if (pr ^ (((pm ^ (1 << lp)) & x).bit_count() & 1)): x |= (1 << lp)
            return x

        def rand_eta_dir(rg):
            x = 0
            for av in act_eta:
                if rg.getrandbits(1): x |= (1 << av)
            for lp, (pm, _) in lp_eta.items():
                if (((pm ^ (1 << lp)) & x).bit_count() & 1): x |= (1 << lp)
            return x

        def eval_S_eta(x_list):
            S_mat = np.zeros((len(x_list), 36), dtype=np.int64)
            for r, x in enumerate(x_list):
                tt = orig_tt.copy()
                tmp = x
                while tmp:
                    lb = tmp & -tmp; tt ^= b_tt[lb.bit_length() - 1]; tmp ^= lb
                for zi in range(36):
                    S_mat[r, zi] = 256 - 2 * int(tt[pts_all[zi]].sum())
            return S_mat

        rng_d4 = random.Random(380038)
        xs_rand = [rand_eta_pt(rng_d4) for _ in range(30)]
        xs_fd3 = []
        for _ in range(8):
            base = rand_eta_pt(rng_d4)
            dirs = [rand_eta_dir(rng_d4) for _ in range(4)]  # 4-diff tests deg <= 3!
            for mask in range(16):
                pt = base
                for b in range(4):
                    if (mask >> b) & 1: pt ^= dirs[b]
                xs_fd3.append(pt)
        S_r_eta = eval_S_eta(xs_rand)
        S_fd3_eta = eval_S_eta(xs_fd3)

        for MOD in (32, 64, 128):
            shift = MOD.bit_length() - 1
            A_ext = np.vstack([A_c8, (MOD // 2) * orb_b0_par])
            ker = s36.mod_rref_kernel(A_ext, MOD)
            vs = [k[:36] % MOD for k in ker if np.any(k[:36] % MOD != 0)]
            n_nonconst, n_deg_le3 = 0, 0
            for v in vs:
                vals = (S_r_eta @ v) % (2 * MOD)
                uniq = sorted(set(int(u) for u in vals))
                if len(uniq) <= 1: continue
                n_nonconst += 1
                if len(uniq) == 2 and ((uniq[1] - uniq[0]) % (2 * MOD) == MOD):
                    fvals = ((S_fd3_eta @ v) >> shift) & 1
                    ok = True
                    for t in range(8):
                        if int(fvals[t * 16:(t + 1) * 16].sum()) & 1:
                            ok = False; break
                    if ok: n_deg_le3 += 1
            print(f"    [eta=0 MOD={MOD:3d}] non-constant={n_nonconst:2d}, deg<=3 on eta=0 = {n_deg_le3:2d}", flush=True)

    print(f"[{cell_name}] STEP 38A DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s27b_diag.c", WORK_DIR / "libs27b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s27b_s9.c", WORK_DIR / "libs27b_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s27b_cg.c", WORK_DIR / "libs27b_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s27b_sh.c", WORK_DIR / "libs27b_sh.so"
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

    c_d8, so_d8 = WORK_DIR / "s27b_d8.c", WORK_DIR / "libs27b_d8.so"
    c_d8.write_text(s12a.C_D8CUB_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_d8), "-o", str(so_d8)], check=True)
    lib_d8 = ctypes.CDLL(str(so_d8))
    lib_d8.extract_deg3_coset_poly.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
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
        run_step27b_cell(
            cname, lib_diag, lib9, lib_cg, lib_sh, lib_d8, orbits, layer_vecs, orb_tt_np,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()

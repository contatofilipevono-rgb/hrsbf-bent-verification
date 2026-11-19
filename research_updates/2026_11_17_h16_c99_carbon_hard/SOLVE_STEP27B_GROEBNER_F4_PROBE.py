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


def run_singular_gb(var_names, poly_strs, timeout_sec=90, tag="gb"):
    """Run Singular `slimgb` over GF(2) with field equations x_i^2 + x_i = 0."""
    sing_bin = shutil.which("Singular") or shutil.which("singular")
    if not sing_bin:
        return "NO_SINGULAR", 0.0, ""
    f_in = WORK_DIR / f"s27b_{tag}.sing"
    v_decl = ",".join(var_names)
    field_eqs = [f"{v}^2+{v}" for v in var_names]
    all_eqs = poly_strs + field_eqs
    script = (
        f"ring r = 2, ({v_decl}), dp;\n"
        f"ideal I = {','.join(all_eqs)};\n"
        f"option(redSB);\n"
        f"ideal G = slimgb(I);\n"
        f"int sz = size(G);\n"
        f"int has1 = (G[1] == 1);\n"
        f"int n_d1 = 0; int n_d2 = 0; int n_d3 = 0;\n"
        f"for (int i = 1; i <= sz; i = i + 1) {{\n"
        f"  int d = deg(G[i]);\n"
        f"  if (d == 1) {{ n_d1 = n_d1 + 1; }}\n"
        f"  if (d == 2) {{ n_d2 = n_d2 + 1; }}\n"
        f"  if (d == 3) {{ n_d3 = n_d3 + 1; }}\n"
        f"}}\n"
        f"printf(\"GB_RES size=%s has1=%s d1=%s d2=%s d3=%s\", sz, has1, n_d1, n_d2, n_d3);\n"
        f"quit;\n"
    )
    f_in.write_text(script, encoding="utf-8")
    t0 = time.perf_counter()
    try:
        proc = subprocess.run([sing_bin, "-q", str(f_in)], capture_output=True, text=True, timeout=timeout_sec)
        dt = time.perf_counter() - t0
        out = (proc.stdout + "\n" + proc.stderr).strip()
        for line in out.splitlines():
            if "GB_RES" in line:
                return "OK", dt, line.strip()
        return f"RC={proc.returncode}", dt, out[-300:]
    except subprocess.TimeoutExpired:
        return "TIMEOUT", time.perf_counter() - t0, ""


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
                     v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl, probe=None):
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
        # B0_11 / B1_11: Extract exact A(w)*r = b(w) subsystem in (R_all, W_ess) and calibrate Singular & msolve!
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
        nW, nR = len(W_pivs), len(R_vars)

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

        col_keys, col_meta = [], []
        for c in range(n_cols):
            d = int(tbl["col_deg"][c])
            vs = []
            if d >= 1: vs.append(int(tbl["col_v0"][c]))
            if d >= 2: vs.append(int(tbl["col_v1"][c]))
            if d >= 3: vs.append(int(tbl["col_v2"][c]))
            dr = sum(1 for v in vs if v in R_set)
            col_meta.append(dr)
            col_keys.append((3 - dr, 3 - d, c))
        col_keys.sort()
        orig_to_perm = (ctypes.c_int * n_cols)()
        perm_to_orig = [0] * n_cols
        for pc, (_, _, oc) in enumerate(col_keys): orig_to_perm[oc] = pc; perm_to_orig[pc] = oc
        perm_buf = (ctypes.c_uint64 * (M_eq * n_cw))()
        lib_sh.remap_rows_by_perm(work, perm_buf, M_eq, n_cw, n_cols, orig_to_perm)
        piv_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
        ech_linR = []
        for r in range(M_eq):
            pc = lib9.gf2_echelon_insert_s9(perm_buf, r, n_cw, piv_idx, n_cols)
            if pc >= 0 and col_meta[perm_to_orig[pc]] <= 1:
                ech_linR.append(r)
        inv_perm = (ctypes.c_int * n_cols)(*perm_to_orig)
        std_ech = (ctypes.c_uint64 * (M_eq * n_cw))()
        lib_sh.remap_rows_by_perm(perm_buf, std_ech, M_eq, n_cw, n_cols, inv_perm)

        w_idx = {v: i for i, v in enumerate(W_pivs)}
        r_idx = {v: i for i, v in enumerate(R_vars)}
        linR_psets = [s9.row_to_pset(std_ech, r_id, tbl) for r_id in ech_linR]
        print(f"  [{cell_name}] Extracted {len(linR_psets)} exact deg_R<=1 polynomials (nW={nW}, nR={nR})", flush=True)

        if probe is not None:
            probe(cell_name, linR_psets, w_idx, r_idx)
            return

        rng = random.Random(272727)
        w_rand = rng.getrandbits(nW)
        for k_fix in [42, 40, 38, 35, 30, 0]:
            if k_fix > nW: continue
            free_w = list(range(k_fix, nW))
            vnames = [f"r{i}" for i in range(nR)] + [f"w{j}" for j in free_w]
            pstrs = []
            for ps in linR_psets:
                mon_par = {}
                for m in ps:
                    vs = [b for b in range(n) if (m >> b) & 1]
                    zero_out = False
                    kept = []
                    for v in vs:
                        if v in w_idx:
                            wi = w_idx[v]
                            if wi < k_fix:
                                if not ((w_rand >> wi) & 1):
                                    zero_out = True; break
                            else:
                                kept.append(f"w{wi}")
                        elif v in r_idx:
                            kept.append(f"r{r_idx[v]}")
                    if zero_out: continue
                    key = "*".join(sorted(kept)) if kept else "1"
                    mon_par[key] = mon_par.get(key, 0) ^ 1
                terms = [k for k, c in mon_par.items() if c]
                if terms: pstrs.append("+".join(terms))
            st_s, dt_s, out_s = run_singular_gb(vnames, pstrs, timeout_sec=90, tag=f"{cell_name}_k{k_fix}")
            print(f"  [{cell_name}] Singular slimgb k_fix={k_fix:2d} (free_W={nW-k_fix:2d}, eqs={len(pstrs)}): {st_s} ({dt_s:.2f}s) | {out_s}", flush=True)
            st_m, dt_m, out_m = run_msolve_gb(vnames, pstrs, timeout_sec=90, tag=f"{cell_name}_k{k_fix}")
            if st_m != "NO_MSOLVE":
                print(f"  [{cell_name}] msolve F4       k_fix={k_fix:2d} (free_W={nW-k_fix:2d}): {st_m} ({dt_m:.2f}s) | {out_m}", flush=True)
            if st_s == "TIMEOUT" and st_m in ("TIMEOUT", "NO_MSOLVE") and k_fix > 0:
                break

    print(f"[{cell_name}] STEP 27B DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main(probe=None):
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
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl, probe=probe
        )


if __name__ == "__main__":
    main()

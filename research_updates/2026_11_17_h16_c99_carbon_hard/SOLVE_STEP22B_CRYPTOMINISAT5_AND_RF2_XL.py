#!/usr/bin/env python3
r"""
SOLVE_STEP22B_CRYPTOMINISAT5_AND_RF2_XL.py

TESTS TWO BRAND-NEW WEAPONS ON B0_11 & B1_11 (eta = 0):
  PART 1 (R_free-ONLY XL ON THE 145/113 `RF=2_W=0` EQUATIONS):
    Multiplies ALL `RF=2, T=0, W=0` equations (145 in B1_11, 113 in B0_11) by ALL R_free vars
    (39/40 vars -> ~5,655 rows vs only C(39,3)=9,139 RF=3 cols!) + base RF=3 rows, checking for
    ANY RF=3 syzygy!
  PART 2 (CRYPTOMINISAT 5 NATIVE GF(2) GAUSSIAN ELIMINATION ON A(w)*r = b(w)!!):
    Encodes the exact `deg_R <= 1` system A(w)*r = b(w) (113 eqs in B1_11, 95 in B0_11) using
    CryptoMiniSat 5's NATIVE arbitrary-length XOR clauses (`add_xor_clause`) + Tseitin AND gates!
    Calibrates exact solve time & conflict counts at k = 40, 35, 30, 25, 20, 15, 0 fixed W-vars!
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
import SOLVE_STEP21A_TRUE_3BLOCK_AND_W_XL_SYZYGY as s21a


def build_cms_aw_system(linR_polys, nW, nR):
    """Build CNF clauses + native XOR clauses for A(w)*r = b(w) in 1-based var numbering:
      1..nW         = w_0..w_{nW-1}
      nW+1..nW+nR   = r_0..r_{nR-1}
      > nW+nR       = Tseitin product variables (pairs & triples)
    Returns (n_vars, cnf_clauses, xor_clauses)."""
    next_var = nW + nR + 1
    pair_v = {}   # (u, v) with u < v -> var_id
    triple_v = {} # (a, b, c) with a < b < c -> var_id
    cnf = []
    xors = []

    def get_pair(u, v):
        nonlocal next_var
        if u > v: u, v = v, u
        key = (u, v)
        if key not in pair_v:
            pv = next_var; next_var += 1
            pair_v[key] = pv
            cnf.append([-pv, u])
            cnf.append([-pv, v])
            cnf.append([pv, -u, -v])
        return pair_v[key]

    def get_triple(a, b, c):
        nonlocal next_var
        a, b, c = sorted((a, b, c))
        key = (a, b, c)
        if key not in triple_v:
            pab = get_pair(a, b)
            tv = next_var; next_var += 1
            triple_v[key] = tv
            cnf.append([-tv, pab])
            cnf.append([-tv, c])
            cnf.append([tv, -pab, -c])
        return triple_v[key]

    for by_r in linR_polys:
        rhs = False
        lits = []
        for rm, wms in by_r.items():
            if rm == 0:
                for wm in wms:
                    d = wm.bit_count()
                    if d == 0:
                        rhs = not rhs
                    elif d == 1:
                        lits.append(wm.bit_length())
                    elif d == 2:
                        b0 = (wm & -wm).bit_length() - 1
                        b1 = (wm ^ (1 << b0)).bit_length() - 1
                        lits.append(get_pair(b0 + 1, b1 + 1))
                    elif d == 3:
                        vs = [b + 1 for b in range(nW) if (wm >> b) & 1]
                        lits.append(get_triple(vs[0], vs[1], vs[2]))
            else:
                rv = nW + rm.bit_length()
                for wm in wms:
                    d = wm.bit_count()
                    if d == 0:
                        lits.append(rv)
                    elif d == 1:
                        wv = wm.bit_length()
                        lits.append(get_pair(wv, rv))
                    elif d == 2:
                        b0 = (wm & -wm).bit_length() - 1
                        b1 = (wm ^ (1 << b0)).bit_length() - 1
                        lits.append(get_triple(b0 + 1, b1 + 1, rv))
        # Deduplicate lits mod 2 just in case!
        parity = {}
        for l in lits: parity[l] = parity.get(l, 0) ^ 1
        clean_lits = [l for l, c in parity.items() if c]
        xors.append((clean_lits, rhs))
    return next_var - 1, cnf, xors


def run_step22b_cell(cell_name, lib_diag, lib9, lib_cg, lib_sh, lib_wxl, orbits, layer_vecs,
                     v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 22B: RF=2 XL + CRYPTOMINISAT5 ON A(w)*r = b(w) ====================", flush=True)
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

    # 2-block R_all > W_ess echelonization
    col_keys, col_meta = [], []
    for c in range(n_cols):
        d = int(tbl["col_deg"][c])
        vs = []
        if d >= 1: vs.append(int(tbl["col_v0"][c]))
        if d >= 2: vs.append(int(tbl["col_v1"][c]))
        if d >= 3: vs.append(int(tbl["col_v2"][c]))
        dr = sum(1 for v in vs if v in R_set)
        dw = sum(1 for v in vs if v in W_set)
        col_meta.append((dr, dw, d))
        col_keys.append((3 - dr, 3 - d, c))
    col_keys.sort()
    orig_to_perm = (ctypes.c_int * n_cols)()
    perm_to_orig = [0] * n_cols
    for pc, (_, _, oc) in enumerate(col_keys):
        orig_to_perm[oc] = pc; perm_to_orig[pc] = oc
    perm_buf = (ctypes.c_uint64 * (M_eq * n_cw))()
    lib_sh.remap_rows_by_perm(work, perm_buf, M_eq, n_cw, n_cols, orig_to_perm)
    piv_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
    ech_meta = []
    for r in range(M_eq):
        pc = lib9.gf2_echelon_insert_s9(perm_buf, r, n_cw, piv_idx, n_cols)
        if pc < 0: continue
        oc = perm_to_orig[pc]
        ech_meta.append((r, col_meta[oc][0], col_meta[oc][1], col_meta[oc][2]))
    inv_perm = (ctypes.c_int * n_cols)(*perm_to_orig)
    std_ech = (ctypes.c_uint64 * (M_eq * n_cw))()
    lib_sh.remap_rows_by_perm(perm_buf, std_ech, M_eq, n_cw, n_cols, inv_perm)

    w_idx = {v: i for i, v in enumerate(W_pivs)}
    r_idx = {v: i for i, v in enumerate(R_vars)}

    # --------------------------------------------------------------------------
    # PART 1: R-ONLY XL ON THE `degR=2, degW=0` BLOCK (+ `degR=3` BASE ROWS)!
    # --------------------------------------------------------------------------
    # Extract pure R^2 part of degR=2_degW=0 rows AND pure R^3 part of degR=3 rows!
    r2_base, r3_base = [], []
    linR_polys = []
    for r_id, dr, dw, td in ech_meta:
        ps = s9.row_to_pset(std_ech, r_id, tbl)
        if dr <= 1:
            by_r = {}
            for m in ps:
                rm, wm = 0, 0
                tmp = m
                while tmp:
                    lb = tmp & -tmp; v = lb.bit_length() - 1; tmp ^= lb
                    if v in r_idx: rm |= (1 << r_idx[v])
                    elif v in w_idx: wm |= (1 << w_idx[v])
                by_r.setdefault(rm, []).append(wm)
            linR_polys.append(by_r)
        elif dr == 2 and dw == 0:
            pairs = []
            for m in ps:
                if m.bit_count() == 2:
                    b0 = (m & -m).bit_length() - 1
                    b1 = (m ^ (1 << b0)).bit_length() - 1
                    if b0 in r_idx and b1 in r_idx:
                        i0, i1 = r_idx[b0], r_idx[b1]
                        pairs.append((i0, i1) if i0 < i1 else (i1, i0))
            r2_base.append(pairs)
        elif dr == 3 and dw == 0:
            trips = []
            for m in ps:
                if m.bit_count() == 3:
                    vs = sorted(r_idx[b] for b in range(n) if (m >> b) & 1 and b in r_idx)
                    if len(vs) == 3: trips.append(tuple(vs))
            r3_base.append(trips)

    # Index all C(nR, 3) triples!
    t2c = {}
    c_t = 0
    for i in range(nR):
        for j in range(i + 1, nR):
            for k in range(j + 1, nR):
                t2c[(i, j, k)] = c_t; c_t += 1
    n_tw = (c_t + 63) >> 6
    n_rxl_rows = len(r3_base) + len(r2_base) * nR
    rxl_buf = (ctypes.c_uint64 * (n_rxl_rows * n_tw))()
    piv_rxl = (ctypes.c_int * c_t)(*([-1] * c_t))
    rc, n_indep_r, n_syz_r = 0, 0, 0
    for trips in r3_base:
        off = rc * n_tw
        for t in trips:
            col = t2c[t]; rxl_buf[off + (col >> 6)] ^= (1 << (col & 63))
        if lib_wxl.gf2_insert_dense(rxl_buf, rc, n_tw, piv_rxl, c_t) >= 0: n_indep_r += 1
        else: n_syz_r += 1
        rc += 1
    for ri_m in range(nR):
        for pairs in r2_base:
            off = rc * n_tw
            for i0, i1 in pairs:
                if ri_m == i0 or ri_m == i1: continue
                t = tuple(sorted((i0, i1, ri_m)))
                col = t2c[t]; rxl_buf[off + (col >> 6)] ^= (1 << (col & 63))
            if lib_wxl.gf2_insert_dense(rxl_buf, rc, n_tw, piv_rxl, c_t) >= 0: n_indep_r += 1
            else: n_syz_r += 1
            rc += 1
    print(f"[{cell_name}] PART 1 R-ONLY XL on degR=2_W=0 ({len(r2_base)} x {nR} + {len(r3_base)} = {n_rxl_rows} rows vs {c_t} R^3 cols): "
          f"rank={n_indep_r}/{n_rxl_rows}, *** R^3-CANCELLING SYZYGIES = {n_syz_r} ***", flush=True)

    # --------------------------------------------------------------------------
    # PART 2: CRYPTOMINISAT 5 NATIVE GF(2) GAUSSIAN ELIMINATION ON A(w)*r = b(w)!!
    # --------------------------------------------------------------------------
    # Filter to degA <= 1 rows (in B1_11 that's ALL 113 rows; in B0_11 88 rows, or use ALL 95 rows!)
    nv_cms, cnf_cms, xor_cms = build_cms_aw_system(linR_polys, nW, nR)
    print(f"[{cell_name}] PART 2 CryptoMiniSat5 A(w)*r = b(w): {len(linR_polys)} native XORs, {len(cnf_cms)} Tseitin clauses, {nv_cms} vars (nW={nW}, nR={nR})", flush=True)

    rng = random.Random(22222)
    w_rand = rng.getrandbits(nW)
    cnf_path = WORK_DIR / f"s22b_{cell_name}.cnf"
    for k_fix in [44, 40, 35, 30, 25, 20, 15, 0]:
        if k_fix > nW: continue
        t_s = time.perf_counter()
        n_cl = len(cnf_cms) + len(xor_cms) + k_fix
        lines = [f"p cnf {nv_cms} {n_cl}\n"]
        for cl in cnf_cms:
            lines.append(" ".join(map(str, cl)) + " 0\n")
        for xlits, xrhs in xor_cms:
            if not xlits:
                if xrhs: lines.append("0\n")
                continue
            # DIMACS XOR: `x a b c 0` means a ^ b ^ c == 1 (True).
            # If xrhs is False (== 0), negate the first literal!
            if not xrhs:
                lines.append("x " + str(-xlits[0]) + (" " + " ".join(map(str, xlits[1:])) if len(xlits) > 1 else "") + " 0\n")
            else:
                lines.append("x " + " ".join(map(str, xlits)) + " 0\n")
        for i in range(k_fix):
            lines.append((f"{i+1} 0\n") if ((w_rand >> i) & 1) else (f"-{i+1} 0\n"))
        cnf_path.write_text("".join(lines), encoding="utf-8")

        max_t = 90 if k_fix <= 25 else 45
        proc = subprocess.run(
            ["cryptominisat5", "--verb=0", "--threads=4", f"--maxtime={max_t}", str(cnf_path)],
            capture_output=True, text=True
        )
        dt = time.perf_counter() - t_s
        rc_cms = proc.returncode
        status = "SAT" if rc_cms == 10 else ("UNSAT" if rc_cms == 20 else f"TIMEOUT({rc_cms})")
        print(f"  [{cell_name}] CMS5 k_fix={k_fix:2d} (free_W={nW-k_fix:2d}): {status:12s} in {dt:6.2f}s", flush=True)
        if rc_cms == 10:
            vals = {}
            for line in proc.stdout.splitlines():
                if line.startswith("v "):
                    for tok in line.split()[1:]:
                        iv = int(tok)
                        if iv != 0: vals[abs(iv)] = (iv > 0)
            wv = sum((1 << i) for i in range(nW) if vals.get(i + 1, False))
            rv = sum((1 << i) for i in range(nR) if vals.get(nW + i + 1, False))
            # Zero-trust verify against linR_polys!
            viol = 0
            for by_r in linR_polys:
                acc = 0
                for rm, wms in by_r.items():
                    if rm == 0 or ((rv & rm) == rm):
                        for wm in wms:
                            if (wv & wm) == wm: acc ^= 1
                if acc: viol += 1
            print(f"      *** FOUND A(w)*r=b(w) SOLUTION!! w=0x{wv:x}, r=0x{rv:x} (ZT viol={viol}/{len(linR_polys)}) ***", flush=True)
            assert viol == 0, "CMS5 SAT model failed zero-trust check!"
        if rc_cms not in (10, 20) and k_fix > 20:
            break

    print(f"[{cell_name}] STEP 22B DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s22b_diag.c", WORK_DIR / "libs22b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s22b_s9.c", WORK_DIR / "libs22b_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s22b_cg.c", WORK_DIR / "libs22b_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s22b_sh.c", WORK_DIR / "libs22b_sh.so"
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

    c_wxl, so_wxl = WORK_DIR / "s22b_wxl.c", WORK_DIR / "libs22b_wxl.so"
    c_wxl.write_text(s21a.C_WXL_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_wxl), "-o", str(so_wxl)], check=True)
    lib_wxl = ctypes.CDLL(str(so_wxl))
    lib_wxl.gf2_insert_dense.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib_wxl.gf2_insert_dense.restype = ctypes.c_int

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
        run_step22b_cell(
            cname, lib_diag, lib9, lib_cg, lib_sh, lib_wxl, orbits, layer_vecs,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
r"""
SOLVE_STEP41A_MAX_UNTOUCHED_FLAG_AND_SINGULAR.py

FOLLOW-UP TO STEP 40D's MASSIVE BREAKTHROUGH:
  - B0_11: FREE L_24 (k_fix=20!) CLOSED 4/4 (262,144x speedup over k_fix=38!)
  - B1_11: FREE L_18 (k_fix=27!) CLOSED 4/4 (2,048x speedup over k_fix=38!)

THREE UPGRADES TO PUSH k_fix EVEN LOWER (AIMING FOR k_fix <= 14..16!):
  1. GREEDY MAX-UNTOUCHED-ROWS FLAG: Instead of sorting by individual rank alone, greedily pick the next
     direction c from found_low (rk <= 26) that minimizes newly touched rows (maximizes untouched_rows!).
  2. EXACT LINEAR-ALGEBRA SUBSPACE SEARCH: For every row u_i of L_core (and low-rank left-kernel vectors),
     compute dim({c : u^T M_c == 0}) to see if there exist HIGHER-dimensional subspaces L_d leaving >= 6 rows untouched!
  3. SINGULAR SLIMGB ON L-ORDERED CORE: Tests whether Singular slimgb closes FREE L_26 / L_28 (k_fix=18, 16!)
     in B0_11 and FREE L_20 / L_22 (k_fix=25, 23!) in B1_11 where degree-3 XL stopped!
"""

import argparse
import ctypes
import random
import subprocess
import sys
from pathlib import Path
import numpy as np
from H16_SPECIALIZED_KERNEL import singular
import json
import os
from H16_POLAR_FLAGS import add, encode, null, radical_flag, rref, unpack
from H16_SPECIALIZED_KERNEL import mul, rank, specialize, transform

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



def tail_substitution(quadratics, w_idx, t_idx):
    rows = {}
    for poly in quadratics:
        lhs = 0
        rhs = set()
        for monomial in poly:
            if monomial.bit_count() == 1 and monomial.bit_length()-1 in t_idx:
                lhs ^= 1 << t_idx[monomial.bit_length()-1]
            else:
                mask = sum(1 << j for v, j in w_idx.items() if monomial >> v & 1)
                assert mask.bit_count() == monomial.bit_count()
                rhs.add(mask)
        while lhs:
            pivot = lhs.bit_length()-1
            if pivot not in rows:
                rows[pivot] = (lhs, rhs)
                break
            previous_lhs, previous_rhs = rows[pivot]
            lhs ^= previous_lhs
            rhs ^= previous_rhs
    assert len(rows) == len(t_idx)
    solved = []
    for pivot in range(len(t_idx)):
        lhs, rhs = rows[pivot]
        for j in range(pivot):
            if lhs >> j & 1:
                rhs = rhs ^ solved[j]
        solved.append(rhs)
    return solved


def evaluate(coeff, point):
    out = np.zeros_like(coeff[0])
    for mask, matrix in coeff.items():
        if point & mask == mask:
            out ^= matrix
    return out


def extend_rows(basis, full, width):
    pivots = {}
    for row in encode(basis):
        assert add(pivots, row)
    extra = [row for row in encode(full) if add(pivots, row)]
    return unpack(extra, width)


def split_probe(coeff, S, rhs, pure, fixed_bits, trial):
    m, n = coeff[0].shape
    origin, _ = specialize(coeff, np.zeros(S.shape[1], dtype=np.uint8), S)
    K = null(np.concatenate([A for p, A in origin.items() if p], axis=0))
    assert len(K) == 5
    blocks = {p: mul(A, K.T) for p, A in coeff.items()}
    U = np.concatenate(list(blocks.values()), axis=1)
    N = null(U.T)
    assert N.shape == (50, 69)
    C = np.eye(n, dtype=np.uint8)[:, [j for j in range(n) if j not in rref(K)[1]]]
    assert rank(np.concatenate((C, K.T), axis=1), rref) == n
    F = null(S)
    augmented = np.concatenate((F, np.array([[(fixed_bits >> j) & 1]
                               for j in range(len(F))], dtype=np.uint8)), axis=1)
    reduced, pivots = rref(augmented)
    assert len(pivots) == len(F) and all(p < S.shape[1] for p in pivots)
    offset = np.zeros(S.shape[1], dtype=np.uint8)
    offset[pivots] = reduced[:len(F), -1]
    assert np.array_equal(mul(F, offset), augmented[:, -1])
    spec, forms = specialize(coeff, offset, S)
    block = mul(spec[0], K.T)
    assert rank(block, rref) == 5
    assert all(not mul(A, K.T).any() for p, A in spec.items() if p)
    full = null(block.T)
    assert full.shape == (64, 69)
    extra = extend_rows(N, full, m)
    assert extra.shape == (14, 69)
    split = np.concatenate((N, extra))
    assert rank(split, rref) == 64 and not mul(split, block).any()

    projected = {p: mul(mul(split, A), C) for p, A in spec.items()}
    masks = [int(x) for x in encode(S)]
    a = encode([offset])[0]
    rng = random.Random(50000 + len(S) + trial)
    counts = {26: 0, 32: 0, 50: 0, 64: 0}
    affine_ranks = {}
    for _ in range(128):
        t = rng.getrandbits(len(S))
        w = a
        for j, row in enumerate(masks):
            if t >> j & 1:
                w ^= row
        b = np.array([sum(w & p == p for p in row) % 2 for row in rhs], dtype=np.uint8)
        A = evaluate(projected, t)
        assert np.array_equal(mul(mul(split, evaluate(coeff, w)), C), A)
        ab = np.column_stack((A, mul(split, b)))
        ranks = [rank(A[:k], rref) for k in counts]
        for (k, r) in zip(counts, ranks):
            counts[k] += rank(ab[:k], rref) > r
        affine_ranks[ranks[2]] = affine_ranks.get(ranks[2], 0) + 1
    result = {"free": len(S), "fixed": len(F), "trial": trial,
              "bits": fixed_bits, "rejected_of_128": counts, "fixed_rank": affine_ranks}
    print("STEP50_FILTER", json.dumps(result), flush=True)
    for rows in (50, 64):
        small = {p: A[:rows] for p, A in projected.items()}
        result["singular"] = singular(small, split[:rows], rhs, pure, forms, 30)
        result["rows"] = rows
        print("STEP50_SOLVER", json.dumps(result), flush=True)



def run_cell(cell_name, lib_diag, lib9, lib_cg, lib_sh, orbits, layer_vecs,
             v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    print(f"\n==================== [{cell_name}] STEP 50: FIXED AND FIBER-DEPENDENT QUOTIENTS ====================", flush=True)
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
    W_forms = [W_rref[p] for p in W_pivs]
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

    data=json.loads(Path("pencil/step41_B0_11.json").read_text())
    assert cell_name=="B0_11"
    assert data["w_vars"]==list(w_idx)
    assert data["r_vars"]==list(rf_idx)
    P=unpack(data["projector"],len(M1_psets))
    R=unpack(data["complement"],len(rf_idx)).T
    coeff={0:M0}
    for k,M in enumerate(Mk): coeff[1<<k]=M
    for row,poly in enumerate(M1_psets):
        for m in poly:
            rr=[v for v in rf_idx if m>>v&1]
            if not rr: continue
            mask=sum(1<<j for v,j in w_idx.items() if m>>v&1)
            assert len(rr)==1 and mask.bit_count()+1==m.bit_count()
            if mask.bit_count()==2:
                coeff.setdefault(mask,np.zeros_like(M0))[row,rf_idx[rr[0]]]^=1

    d=int(os.environ["H16_FREE_DIM"])
    case=int(os.environ["H16_CASE"])
    _,expected,S=next(item for item in radical_flag(data) if item[0]==d)
    actual={m:mul(mul(P,A),R) for m,A in coeff.items()}
    assert all(np.array_equal(expected.get(m,np.zeros_like(expected[0])),
                              actual.get(m,np.zeros_like(expected[0])))
               for m in expected.keys() | actual.keys())
    seed = random.Random(48000 + d)
    bits = [seed.getrandbits(S.shape[1]-d) for _ in range(4)][case]
    t_idx = {v: j for j, v in enumerate(T_pivs)}
    quadratics = [s9.row_to_pset(work, j, tbl) for j in range(n_q)]
    tails = tail_substitution(quadratics, w_idx, t_idx)
    rhs_forms = [None] * n
    for v, j in w_idx.items():
        rhs_forms[v] = {1 << j}
    for v, j in t_idx.items():
        rhs_forms[v] = tails[j]
    cache = {0: {0}}
    rhs = [transform([m for m in poly if not any(m >> v & 1 for v in rf_idx)],
                     rhs_forms, cache) for poly in M1_psets]
    pure = [transform(poly, rhs_forms, cache) for poly in quadratics]
    pure = [poly for poly in pure if poly]
    # Push the RHS through the same archived row projector used for M.
    core_rhs = [set() for _ in P]
    for out_row, comb in zip(core_rhs, P):
        for chosen, poly in zip(comb, rhs):
            if chosen:
                out_row ^= poly
    split_probe(expected, S, core_rhs, pure, bits, case)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s41a_diag.c", WORK_DIR / "libs41a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s41a_s9.c", WORK_DIR / "libs41a_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s41a_cg.c", WORK_DIR / "libs41a_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s41a_sh.c", WORK_DIR / "libs41a_sh.so"
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

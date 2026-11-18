#!/usr/bin/env python3
r"""
SOLVE_STEP10_CARLET_GUILLOT_NNF.py

Literature-Driven Attack (Carlet & Guillot 1999/2001 Numerical Normal Form Theorem):
For any bent function f on F_2^16 of degree 4:
  2^{|I|-8} | lambda_I(f)  for all 9 <= |I| <= 15.
Specifically:
  - |I| = 12 (116 C_16-orbits): 16 | lambda_I => mod 8 gives 116 exact pure degree-3 equations
    sum_{I = S1 u S2 u S3} a_{S1} a_{S2} a_{S3} == 0 (mod 2).
  - |I| = 11 (273 C_16-orbits):  8 | lambda_I => mod 8 gives 273 exact pure degree-3 equations
    sum_{S1 u S2 u S3 = I} a_{S1} a_{S2} a_{S3} == 0 (mod 2).
Together these 389 NON-SYMMETRIC coordinate subspace equations break past the ~95-cubic ceiling
of rho^8-invariant (V6 x V6) subspaces!

We build all 389 Carlet-Guillot cubics in C (< 0.2s), zero-trust verify both |I|=12 and |I|=11
directly against lambda_I(f) on random 111-var points, merge them with Step 9's pure-111 system
(V6xV6 + rot^4 + Q4 + C_0xf + C5 + fibers + cyclotomic L_d mod 8), and run:
  1. Exact Root GF(2) echelon + XL cascade (check if 389 CG cubics ALREADY drop new quads/linears/1=0!),
  2. Exact 8-branch symplectic linearizer cascade + recursive sub-splitting!
"""

import argparse
import ctypes
import json
import random
import subprocess
import sys
import time
from itertools import combinations
from pathlib import Path

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_B09_DUAL_S_ELIM as b09
import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9

C_CG_SRC = r"""
#include <stddef.h>
#include <stdint.h>
#include <string.h>

static inline void toggle_bit(uint64_t *row, int col) {
    row[col >> 6] ^= (1ULL << (col & 63));
}

static inline int col_of_2(int a, int b, int off2, const int *col2_base) {
    if (a > b) { int t = a; a = b; b = t; }
    return off2 + col2_base[a] + (b - a - 1);
}

static inline int col_of_3(int a, int b, int c, int n, const int *col3_base) {
    int t;
    if (a > b) { t = a; a = b; b = t; }
    if (b > c) { t = b; b = c; c = t; }
    if (a > b) { t = a; a = b; b = t; }
    return col3_base[a * n + b] + (c - b - 1);
}

// Toggle monomial given 0..3 variable indices in 0..110 (may have duplicates -> deduplicate!)
static inline void toggle_vars_set(
    uint64_t *row, const int *vs, int nv,
    int n, int off2, int off1, int off0,
    const int *col2_base, const int *col3_base
) {
    int u[3], nu = 0;
    for (int i = 0; i < nv; i++) {
        int x = vs[i];
        int dup = 0;
        for (int j = 0; j < nu; j++) if (u[j] == x) { dup = 1; break; }
        if (!dup) u[nu++] = x;
    }
    if (nu == 0) toggle_bit(row, off0);
    else if (nu == 1) toggle_bit(row, off1 + u[0]);
    else if (nu == 2) toggle_bit(row, col_of_2(u[0], u[1], off2, col2_base));
    else toggle_bit(row, col_of_3(u[0], u[1], u[2], n, col3_base));
}

// Add triple of orbit indices (j1, j2, j3) in 0..115 into a 111-var row:
// orb_map[j]:
//   >= 0 : free111 var index in 0..110
//   -1   : fixed 0
//   -2   : fixed 1
//   -3   : orbit 0 (c_0 = c99 ^ XOR_{t=0..nL-1} z_{L_vars[t]})
static inline void add_orb_triple(
    uint64_t *row, int j1, int j2, int j3,
    const int *orb_map, int c99, const int *L_vars, int nL,
    int n, int off2, int off1, int off0,
    const int *col2_base, const int *col3_base
) {
    int js[3] = {j1, j2, j3};
    int vs[3], nv = 0;
    int has_c0 = 0;
    for (int i = 0; i < 3; i++) {
        int m = orb_map[js[i]];
        if (m == -1) return; // multiplied by 0
        else if (m == -2) continue; // multiplied by 1
        else if (m == -3) has_c0 = 1; // c_0^2 = c_0
        else {
            int dup = 0;
            for (int k = 0; k < nv; k++) if (vs[k] == m) { dup = 1; break; }
            if (!dup) vs[nv++] = m;
        }
    }
    if (!has_c0) {
        toggle_vars_set(row, vs, nv, n, off2, off1, off0, col2_base, col3_base);
    } else {
        if (c99) {
            toggle_vars_set(row, vs, nv, n, off2, off1, off0, col2_base, col3_base);
        }
        int vs2[3];
        for (int i = 0; i < nv; i++) vs2[i] = vs[i];
        for (int t = 0; t < nL; t++) {
            vs2[nv] = L_vars[t];
            toggle_vars_set(row, vs2, nv + 1, n, off2, off1, off0, col2_base, col3_base);
        }
    }
}

void build_cg12_row_c(
    int I_mask,
    const int16_t *mon_to_orb,
    const int *orb_map, int c99, const int *L_vars, int nL,
    int n, int off2, int off1, int off0, int n_col_words,
    const int *col2_base, const int *col3_base,
    uint64_t *out_row
) {
    memset(out_row, 0, (size_t)n_col_words * sizeof(uint64_t));
    int bits[12], nb = 0;
    for (int b = 0; b < 16; b++) if ((I_mask >> b) & 1) bits[nb++] = b;
    int b0 = bits[0];
    // Choose 3 from bits[1..11] for S1
    for (int i1 = 1; i1 < 12; i1++) {
        for (int i2 = i1 + 1; i2 < 12; i2++) {
            for (int i3 = i2 + 1; i3 < 12; i3++) {
                int s1 = (1 << b0) | (1 << bits[i1]) | (1 << bits[i2]) | (1 << bits[i3]);
                int j1 = mon_to_orb[s1];
                int rem[8], nr = 0;
                for (int r = 1; r < 12; r++) {
                    if (r != i1 && r != i2 && r != i3) rem[nr++] = bits[r];
                }
                int r0 = rem[0];
                for (int k1 = 1; k1 < 8; k1++) {
                    for (int k2 = k1 + 1; k2 < 8; k2++) {
                        for (int k3 = k2 + 1; k3 < 8; k3++) {
                            int s2 = (1 << r0) | (1 << rem[k1]) | (1 << rem[k2]) | (1 << rem[k3]);
                            int s3 = I_mask ^ s1 ^ s2;
                            add_orb_triple(
                                out_row, j1, mon_to_orb[s2], mon_to_orb[s3],
                                orb_map, c99, L_vars, nL,
                                n, off2, off1, off0, col2_base, col3_base
                            );
                        }
                    }
                }
            }
        }
    }
}

void build_cg11_row_c(
    int I_mask,
    const int16_t *mon_to_orb,
    const int *orb_map, int c99, const int *L_vars, int nL,
    int n, int off2, int off1, int off0, int n_col_words,
    const int *col2_base, const int *col3_base,
    uint64_t *out_row
) {
    memset(out_row, 0, (size_t)n_col_words * sizeof(uint64_t));
    int bits[11], nb = 0;
    for (int b = 0; b < 16; b++) if ((I_mask >> b) & 1) bits[nb++] = b;
    for (int di = 0; di < 11; di++) {
        int d = bits[di];
        int bit_d = 1 << d;
        int rem10[10], n10 = 0;
        for (int r = 0; r < 11; r++) if (r != di) rem10[n10++] = bits[r];
        for (int a = 0; a < 10; a++) {
            for (int b = a + 1; b < 10; b++) {
                for (int c = b + 1; c < 10; c++) {
                    for (int e = c + 1; e < 10; e++) {
                        int s3 = (1 << rem10[a]) | (1 << rem10[b]) | (1 << rem10[c]) | (1 << rem10[e]);
                        int j3 = mon_to_orb[s3];
                        int rem6[6], n6 = 0;
                        for (int r = 0; r < 10; r++) {
                            if (r != a && r != b && r != c && r != e) rem6[n6++] = rem10[r];
                        }
                        int b_r0 = 1 << rem6[0];
                        for (int u = 1; u < 6; u++) {
                            for (int v = u + 1; v < 6; v++) {
                                int s1 = bit_d | b_r0 | (1 << rem6[u]) | (1 << rem6[v]);
                                int s2 = (I_mask ^ s3 ^ s1) | bit_d;
                                add_orb_triple(
                                    out_row, mon_to_orb[s1], mon_to_orb[s2], j3,
                                    orb_map, c99, L_vars, nL,
                                    n, off2, off1, off0, col2_base, col3_base
                                );
                            }
                        }
                    }
                }
            }
        }
    }
}
"""


def subset_orbits(k):
    seen, reps = set(), []
    for comb in combinations(range(16), k):
        m = sum(1 << b for b in comb)
        if m in seen:
            continue
        reps.append(m)
        cur = m
        for _ in range(16):
            seen.add(cur)
            cur = b09.rot16(cur)
    return reps


def zero_trust_verify_cg_row(row_ptr, I_mask, c99, c57, c113, orbits, lib9, tbl):
    """Verify a 111-var CG row directly against lambda_I(f)/4 mod 2 on 10 random x111."""
    _, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    pts = [0]
    for b in range(16):
        if (I_mask >> b) & 1:
            pts += [x | (1 << b) for x in pts]
    orb_tt = [0] * 116
    for j, orb in enumerate(orbits):
        w = 0
        for idx, x in enumerate(pts):
            if sum((x & m) == m for m in orb) & 1:
                w |= (1 << idx)
        orb_tt[j] = w
    sign_even = sum((1 << idx) for idx, x in enumerate(pts) if (x.bit_count() & 1) == 0)
    O_tt = 0
    for j in range(116):
        if (origin111 >> j) & 1:
            O_tt ^= orb_tt[j]
    cb_tt = []
    for cdir in cb111:
        w = 0
        for j in range(116):
            if (cdir >> j) & 1:
                w ^= orb_tt[j]
        cb_tt.append(w)

    rng = random.Random(20261001 + I_mask)
    mask64 = (1 << 64) - 1
    for _ in range(10):
        x = rng.getrandbits(111)
        tt = O_tt
        m = x
        while m:
            lb = m & -m
            tt ^= cb_tt[lb.bit_length() - 1]
            m ^= lb
        lam = (tt & sign_even).bit_count() - (tt & (~sign_even)).bit_count()
        assert lam % 4 == 0, f"lam={lam} not div by 4!"
        actual = (lam // 4) & 1
        pe = lib9.eval_row_s9(
            row_ptr, tbl["n_col_words"], tbl["off0"],
            tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
            x & mask64, x >> 64
        )
        assert pe == actual, f"CG zero-trust MISMATCH at I={hex(I_mask)}: actual={actual}, poly={pe}"


def run_step10_cell(cell_name, lib_diag, lib9, lib_cg, orbits, v6_list, rot4_data,
                    fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 10: CARLET-GUILLOT NNF (389 CUBICS) + 8-BRANCH ====================", flush=True)
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    n = tbl["n"]
    n_cw = tbl["n_col_words"]

    # Build orb_map and L_vars for C CG generator
    orb_map = (ctypes.c_int * 116)(*([-1] * 116))
    for i, j in enumerate(free111):
        orb_map[j] = i
    orb_map[0] = -3
    orb_map[115] = -1
    orb_map[99] = -2 if c99 else -1
    orb_map[57] = -2 if c57 else -1
    orb_map[113] = -2 if c113 else -1

    L_set = set(diag_v2.L_INDICES)
    L_vars_py = [i for i, j in enumerate(free111) if j in L_set]
    L_vars_arr = (ctypes.c_int * len(L_vars_py))(*L_vars_py)

    # 1. Build ALL 116 CG(|I|=12) + 273 CG(|I|=11) = 389 Carlet-Guillot cubics in C!
    t_cg = time.perf_counter()
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
    print(f"[{cell_name}] Built all {n_cg} Carlet-Guillot NNF cubics (116x12 + 273x11) in {time.perf_counter()-t_cg:.3f}s", flush=True)

    # Zero-trust verify 2 reps of |I|=12 and 2 reps of |I|=11!
    for check_idx, I_m in [(0, reps12[0]), (50, reps12[50]), (len(reps12), reps11[0]), (len(reps12) + 100, reps11[100])]:
        rptr = ctypes.cast(ctypes.byref(cg_buf, check_idx * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        zero_trust_verify_cg_row(rptr, I_m, c99, c57, c113, orbits, lib9, tbl)
    print(f"[{cell_name}] Zero-trust audit PASSED on 4 Carlet-Guillot NNF rows (40 random points, 0 mismatches)!", flush=True)

    # First test CG(389) ALONE (purely on 111 vars) to see its standalone rank & drops!
    cg_alone = s9.run_branch_cascade(lib9, cg_buf, [], list(range(n_cg)), {}, [], tbl, max_xl_rounds=4, verify_subst=False)
    print(f"[{cell_name}] CG(389) ALONE: closed={cg_alone['closed_unsat']}, "
          f"N_active={cg_alone.get('N_active')}, lin_dropped={cg_alone.get('total_lin_dropped')}, "
          f"quads={cg_alone.get('n_quad_surviving')}, cubics={cg_alone.get('n_genuine_cubics')}", flush=True)
    if cg_alone["closed_unsat"]:
        return {"cell": cell_name, "closed_unsat": True, "closed_by": "CG_389_ALONE", "cg_alone": cg_alone, "total_sec": round(time.perf_counter() - t0, 3)}

    # 2. Extract base pure-111 system via DIAGNOSE_V2_STRUCTURE + cyclotomic cubics
    sys_data = diag_v2.build_cell_algebraic_system(
        cell_name, lib_diag, orbits, v6_list, rot4_data, fiber_meta, extract_sec=20.0
    )
    if sys_data["has_one"]:
        return {"cell": cell_name, "closed_unsat": True, "closed_by": "stage1_base"}

    cyc_cubs = s9.extract_verified_cyclotomic_cubics(cell_name, orbits, origin111, cb111, layers, c0x0)
    n_base_pivs = sum(sys_data["deg_pivs_111"].values())
    total_raw = n_base_pivs + len(cyc_cubs) + n_cg
    raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base_pivs * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, raw_buf, n_base_pivs + idx_c, tbl)
    dst_cg = ctypes.cast(ctypes.byref(raw_buf, (n_base_pivs + len(cyc_cubs)) * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
    ctypes.memmove(dst_cg, cg_buf, n_cg * n_cw * 8)

    # 3. Full Root Cascade (Base + Cyclotomic + ALL 389 Carlet-Guillot NNF cubics!)
    t_root = time.perf_counter()
    root = s9.run_branch_cascade(
        lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=6, verify_subst=True
    )
    if root["closed_unsat"]:
        print(f"[{cell_name}] >>> CLOSED AT ROOT BY CARLET-GUILLOT 389 + BASE! ({root['closed_by']}) <<<", flush=True)
        return {"cell": cell_name, "closed_unsat": True, "closed_by": f"root_{root['closed_by']}",
                "root": root, "total_sec": round(time.perf_counter() - t0, 3)}

    print(f"[{cell_name}] Root MERGED ({time.perf_counter()-t_root:.2f}s): "
          f"N_active={root['N_active']}, genuine_quads={root['n_quad_surviving']}, "
          f"genuine_cubics={root['n_genuine_cubics']}, lin_dropped={root['total_lin_dropped']}, "
          f"rounds={root['rounds']}", flush=True)

    # 4. Symplectic Linearizer Branching on surviving root quadratics!
    root_quad_psets = [s9.row_to_pset(root["_buf"], qr, tbl) for qr in root["_quad_ids"]]
    lin_info = s9.find_minimal_linearizers(root_quad_psets, n)
    forms = lin_info["linearizer_forms_111"]
    k_lin = len(forms)
    print(f"[{cell_name}] Symplectic linearizers: dim_W_ess={lin_info['dim_W_ess']}, k={k_lin} -> {1<<k_lin} branches", flush=True)

    branches_summary = []
    closed_count = 0
    if k_lin <= 5:
        for bmask in range(1 << k_lin):
            tb = time.perf_counter()
            extra_eqs = [(forms[i], (bmask >> i) & 1) for i in range(k_lin)]
            bres = s9.run_branch_cascade(
                lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
                extra_eqs, tbl, max_xl_rounds=6, verify_subst=(bmask == 0)
            )
            b_sec = round(time.perf_counter() - tb, 3)
            if bres["closed_unsat"]:
                closed_count += 1
                bd = {"branch": bmask, "closed_unsat": True, "closed_by": bres["closed_by"], "rounds": bres["rounds"], "sec": b_sec}
            else:
                nq_symp = None
                sub_closed_str = None
                if bres["n_quad_surviving"] > 0:
                    bq = [s9.row_to_pset(bres["_buf"], qr, tbl) for qr in bres["_quad_ids"]]
                    nqi = s9.find_minimal_linearizers(bq, n)
                    nq_symp = {"dim_W_ess_new": nqi["dim_W_ess"], "k_lin_new": nqi["k_linearizers"]}
                    if 1 <= nqi["k_linearizers"] <= 4:
                        sc = 0
                        sf = nqi["linearizer_forms_111"]
                        for sm in range(1 << len(sf)):
                            sres = s9.run_branch_cascade(
                                lib9, bres["_buf"], bres["_quad_ids"], bres["_cub_ids"], bres["_lin_pivs"],
                                [(sf[i], (sm >> i) & 1) for i in range(len(sf))], tbl, max_xl_rounds=5, verify_subst=False
                            )
                            if sres["closed_unsat"]:
                                sc += 1
                        sub_closed_str = f"{sc}/{1 << len(sf)}"
                        if sc == (1 << len(sf)):
                            closed_count += 1
                bd = {
                    "branch": bmask,
                    "closed_unsat": (sub_closed_str is not None and sub_closed_str.split("/")[0] == sub_closed_str.split("/")[1]),
                    "N_active": bres["N_active"],
                    "new_quads": bres["n_quad_surviving"],
                    "genuine_cubics": bres["n_genuine_cubics"],
                    "lin_dropped": bres["total_lin_dropped"],
                    "new_q_symp": nq_symp,
                    "sub_split_closed": sub_closed_str,
                    "sec": b_sec,
                }
            branches_summary.append(bd)
            print(f"[{cell_name} | br {bmask:0{k_lin}b}] closed={bd['closed_unsat']}, "
                  f"N={bd.get('N_active')}, quads={bd.get('new_quads')}, cubs={bd.get('genuine_cubics')}, "
                  f"sub={bd.get('sub_split_closed')}, sec={b_sec}", flush=True)

    return {
        "cell": cell_name,
        "closed_unsat": (k_lin <= 5 and closed_count == (1 << k_lin)),
        "branches_closed": f"{closed_count}/{1 << k_lin}" if k_lin <= 5 else "skipped_k_gt_5",
        "cg_alone": {k: v for k, v in cg_alone.items() if not k.startswith("_")},
        "root_N_active": root["N_active"],
        "root_genuine_quads": root["n_quad_surviving"],
        "root_genuine_cubics": root["n_genuine_cubics"],
        "root_lin_dropped": root["total_lin_dropped"],
        "symplectic_linearizers": {"dim_W_ess": lin_info["dim_W_ess"], "k": k_lin},
        "branches": branches_summary,
        "total_sec": round(time.perf_counter() - t0, 3),
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    args = parser.parse_args()
    t_all = time.perf_counter()

    # Compile 3 C libraries
    c_diag, so_diag = WORK_DIR / "step10_diag.c", WORK_DIR / "libstep10_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "step10_s9.c", WORK_DIR / "libstep10_s9.so"
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

    c_cg, so_cg = WORK_DIR / "step10_cg.c", WORK_DIR / "libstep10_cg.so"
    c_cg.write_text(C_CG_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_cg), "-o", str(so_cg)], check=True)
    lib_cg = ctypes.CDLL(str(so_cg))
    for fn in (lib_cg.build_cg12_row_c, lib_cg.build_cg11_row_c):
        fn.argtypes = [
            ctypes.c_int, ctypes.POINTER(ctypes.c_int16),
            ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.c_int,
            ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
            ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
            ctypes.POINTER(ctypes.c_uint64),
        ]

    # Shared precomputations
    orbits = diag_v2.build_orbits_116()
    mon_to_orb_arr = (ctypes.c_int16 * 65536)(*([-1] * 65536))
    for j, orb in enumerate(orbits):
        for m in orb:
            mon_to_orb_arr[m] = j
    reps12 = subset_orbits(12)
    reps11 = subset_orbits(11)

    v6_list = diag_v2.all_v6_orbits()
    _, u8_size8, nonzero_z = diag_v2.build_c8_orbits()
    M_rows = []
    for rep_z, _ in nonzero_z:
        row_mask = 0
        for m_idx, (_, u_orb) in enumerate(u8_size8):
            s = sum(1 if ((u & rep_z).bit_count() & 1) == 0 else -1 for u in u_orb)
            if (s // 2) & 1:
                row_mask |= (1 << m_idx)
        M_rows.append(row_mask)
    null_z_vecs = diag_v2.gf2_nullspace_left(M_rows)
    fiber_meta = (nonzero_z, null_z_vecs)

    pair_idx, all_pairs = {}, []
    for v in range(256):
        for w in range(v + 1, 256):
            pair_idx[(v, w)] = len(all_pairs)
            all_pairs.append(v | (w << 8))
    seen_x = bytearray(65536)
    rot4_reps, rep_of_x = [], [-1] * 65536
    for x in range(65536):
        if (x & 0xFF) == (x >> 8) or seen_x[x]:
            continue
        r_idx = len(rot4_reps)
        rot4_reps.append(x)
        for y in (x, diag_v2.rot16(x, 4), diag_v2.rot16(x, 8), diag_v2.rot16(x, 12)):
            seen_x[y] = 1
            rep_of_x[y] = r_idx

    coset_0xf_reps = []
    vis16 = bytearray(65536)
    for x in range(65536):
        if vis16[x]:
            continue
        cur, mem = x, []
        while not vis16[cur]:
            vis16[cur] = 1
            mem.append(cur)
            cur = diag_v2.rot16(cur)
        if len(mem) == 16:
            vnib = (x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)
            if vnib == 0xF:
                coset_0xf_reps.append(mem[0])

    orb_tts = [bytearray(65536) for _ in range(116)]
    orb_diag, orb_pair, orb_r4, orb_0xf_parity = [0] * 116, [0] * 116, [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        tt = orb_tts[j]
        for x in range(65536):
            if sum((x & m) == m for m in orb) & 1:
                tt[x] = 1
        orb_diag[j] = sum((1 << v) for v in range(256) if tt[v | (v << 8)])
        orb_pair[j] = sum((1 << k) for k, x in enumerate(all_pairs) if tt[x])
        orb_r4[j] = sum((1 << k) for k, x in enumerate(rot4_reps) if tt[x])
        orb_0xf_parity[j] = sum(tt[x] for x in coset_0xf_reps) & 1
    chi_r4 = sum((1 << k) for k, x in enumerate(rot4_reps) if x.bit_count() & 1)

    def eval_orb_at_x(j, x):
        return orb_tts[j][x]

    rot4_data = (pair_idx, orb_diag, orb_pair, orb_r4, chi_r4, rep_of_x, orb_0xf_parity, eval_orb_at_x)
    layers, c0x0 = s9.build_cyclotomic_layers()
    tbl = s9.build_col_tables(111)

    report = {"cells": {}}
    for cname in [c.strip() for c in args.cells.split(",") if c.strip()]:
        report["cells"][cname] = run_step10_cell(
            cname, lib_diag, lib9, lib_cg, orbits, v6_list, rot4_data,
            fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )
    report["total_sec"] = round(time.perf_counter() - t_all, 3)
    print("\n=== STEP 10 FINAL SUMMARY ===", flush=True)
    print(json.dumps(report, indent=2), flush=True)


if __name__ == "__main__":
    main()

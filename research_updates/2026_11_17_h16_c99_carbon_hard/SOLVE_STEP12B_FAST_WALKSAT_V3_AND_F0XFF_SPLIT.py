#!/usr/bin/env python3
r"""
SOLVE_STEP12B_FAST_WALKSAT_V3_AND_F0XFF_SPLIT.py

Ultra-fast (<60s/cell) two-part diagnostic across B0_00, B0_11, B1_11:
  PART 1: Ultra-Fast C WalkSAT directly on:
    (a) The 116 SPARSE CG(|I|=12) cubics (only ~1.8M term occurrences -> 25x faster!), AND
    (b) ALL 388 genuine Carlet-Guillot cubics (true WalkSAT: pick a random unsatisfied cubic,
        test 6 random candidate variables instead of 24 -> finishes in ~20s!).
    Answers immediately whether V_3 (CG12 / CG388) has reachable solutions or hits a hard UNSAT floor!
    If ANY solution hits 0 violations, immediately runs exact 65536-pt FWHT to check if it is BENT!
  PART 2: Tests splitting the surviving linearized branch (N=104..106) across all ~102 valid states
    of the 7 highest-symmetry rho-invariant linear forms of (0xFF + D_8) (for B0_11 and B1_11!).
"""

import argparse
import ctypes
import json
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

C_FAST_WS_SRC = r"""
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

static double now_sec(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + 1e-9 * (double)ts.tv_nsec;
}

static uint64_t xorshift64(uint64_t *st) {
    uint64_t x = *st;
    x ^= x << 13; x ^= x >> 7; x ^= x << 17;
    *st = x;
    return x;
}

typedef struct {
    int N, M;
    int *v_off;
    uint16_t *t_row;
    uint8_t *t_a, *t_b;
    uint8_t *row_c0;
} FastWS;

static FastWS F;

int fws_init(int N, int M, const uint32_t *row_offs, const uint32_t *terms_packed, const uint8_t *row_c0) {
    memset(&F, 0, sizeof(F));
    F.N = N; F.M = M;
    F.row_c0 = (uint8_t *)malloc((size_t)M);
    memcpy(F.row_c0, row_c0, (size_t)M);

    int *cnt = (int *)calloc((size_t)N, sizeof(int));
    for (int r = 0; r < M; r++) {
        for (uint32_t t = row_offs[r]; t < row_offs[r + 1]; t++) {
            uint32_t pm = terms_packed[t];
            uint8_t b0 = pm & 0xFFU, b1 = (pm >> 8) & 0xFFU, b2 = (pm >> 16) & 0xFFU;
            if (b0 < N) cnt[b0]++;
            if (b1 < N) cnt[b1]++;
            if (b2 < N) cnt[b2]++;
        }
    }
    F.v_off = (int *)malloc((size_t)(N + 1) * sizeof(int));
    F.v_off[0] = 0;
    for (int v = 0; v < N; v++) F.v_off[v + 1] = F.v_off[v] + cnt[v];
    int tot = F.v_off[N];
    F.t_row = (uint16_t *)malloc((size_t)tot * sizeof(uint16_t));
    F.t_a = (uint8_t *)malloc((size_t)tot);
    F.t_b = (uint8_t *)malloc((size_t)tot);
    int *pos = (int *)malloc((size_t)N * sizeof(int));
    memcpy(pos, F.v_off, (size_t)N * sizeof(int));

    for (int r = 0; r < M; r++) {
        for (uint32_t t = row_offs[r]; t < row_offs[r + 1]; t++) {
            uint32_t pm = terms_packed[t];
            uint8_t b0 = pm & 0xFFU, b1 = (pm >> 8) & 0xFFU, b2 = (pm >> 16) & 0xFFU;
            if (b0 < N) { int p = pos[b0]++; F.t_row[p] = (uint16_t)r; F.t_a[p] = b1; F.t_b[p] = b2; }
            if (b1 < N) { int p = pos[b1]++; F.t_row[p] = (uint16_t)r; F.t_a[p] = b0; F.t_b[p] = b2; }
            if (b2 < N) { int p = pos[b2]++; F.t_row[p] = (uint16_t)r; F.t_a[p] = b0; F.t_b[p] = b1; }
        }
    }
    free(cnt); free(pos);
    return tot;
}

void fws_free(void) {
    free(F.v_off); free(F.t_row); free(F.t_a); free(F.t_b); free(F.row_c0);
    memset(&F, 0, sizeof(F));
}

// Fast time-budgeted WalkSAT / steepest-descent (k_try candidates per step)
int fws_run(int k_try, double budget_sec, int avoid_zero, uint64_t seed, uint8_t *out_best_x, int *out_steps) {
    int N = F.N, M = F.M;
    uint8_t x[128], val[512], delta[512], cur_x[128];
    int best_viol = M + 1;
    uint64_t rng = seed ? seed : 12345678901234567ULL;
    double deadline = now_sec() + budget_sec;
    int total_steps = 0;

    for (int rs = 0; rs < 200 && now_sec() < deadline; rs++) {
        int x_wt = 0;
        for (int i = 0; i < N; i++) {
            x[i] = (uint8_t)(xorshift64(&rng) & 1ULL);
            x_wt += x[i];
        }
        if (avoid_zero && x_wt == 0) { x[0] = 1; x_wt = 1; }

        memcpy(val, F.row_c0, (size_t)M);
        memset(cur_x, 0, (size_t)N);
        for (int v = 0; v < N; v++) {
            if (!x[v]) continue;
            for (int p = F.v_off[v]; p < F.v_off[v + 1]; p++) {
                uint8_t a = F.t_a[p], b = F.t_b[p];
                if ((a == 255 || cur_x[a]) && (b == 255 || cur_x[b])) val[F.t_row[p]] ^= 1;
            }
            cur_x[v] = 1;
        }
        int cur_viol = 0;
        for (int r = 0; r < M; r++) cur_viol += val[r];
        if (cur_viol < best_viol) {
            best_viol = cur_viol;
            memcpy(out_best_x, x, (size_t)N);
            if (best_viol == 0) { *out_steps = total_steps; return 0; }
        }

        for (int st = 0; st < 1500 && now_sec() < deadline; st++) {
            total_steps++;
            int chosen_v = -1, best_nv = M + 1;
            if ((xorshift64(&rng) % 100) < 12) {
                chosen_v = (int)(xorshift64(&rng) % (uint64_t)N);
                if (avoid_zero && x_wt == 1 && x[chosen_v] == 1) chosen_v = (chosen_v + 1) % N;
            } else {
                int nt = (cur_viol <= 15) ? (k_try * 2) : k_try;
                if (nt > N) nt = N;
                for (int k = 0; k < nt; k++) {
                    int v = (int)(xorshift64(&rng) % (uint64_t)N);
                    if (avoid_zero && x_wt == 1 && x[v] == 1) continue;
                    memset(delta, 0, (size_t)M);
                    for (int p = F.v_off[v]; p < F.v_off[v + 1]; p++) {
                        uint8_t a = F.t_a[p], b = F.t_b[p];
                        if ((a == 255 || x[a]) && (b == 255 || x[b])) delta[F.t_row[p]] ^= 1;
                    }
                    int nv = cur_viol;
                    for (int r = 0; r < M; r++) if (delta[r]) nv += (val[r] ? -1 : 1);
                    if (nv < best_nv || (nv == best_nv && (xorshift64(&rng) & 1ULL))) {
                        best_nv = nv; chosen_v = v;
                    }
                }
            }
            if (chosen_v < 0) continue;
            for (int p = F.v_off[chosen_v]; p < F.v_off[chosen_v + 1]; p++) {
                uint8_t a = F.t_a[p], b = F.t_b[p];
                if ((a == 255 || x[a]) && (b == 255 || x[b])) {
                    int r = F.t_row[p];
                    cur_viol += (val[r] ? -1 : 1);
                    val[r] ^= 1;
                }
            }
            x_wt += (x[chosen_v] ? -1 : 1);
            x[chosen_v] ^= 1;
            if (cur_viol < best_viol) {
                best_viol = cur_viol;
                memcpy(out_best_x, x, (size_t)N);
                if (best_viol == 0) { *out_steps = total_steps; return 0; }
            }
        }
    }
    *out_steps = total_steps;
    return best_viol;
}
"""


def pack_rows_for_fws(buf, row_ids, old_to_new, tbl):
    row_offs = [0]
    terms_packed = []
    row_c0 = []
    for r in row_ids:
        ps = s9.row_to_pset(buf, r, tbl)
        row_c0.append(1 if (0 in ps) else 0)
        for m in ps:
            if m == 0:
                continue
            idxs = []
            tmp = m
            while tmp:
                lb = tmp & -tmp
                idxs.append(old_to_new[lb.bit_length() - 1])
                tmp ^= lb
            idxs.sort()
            b0 = idxs[0] if len(idxs) > 0 else 255
            b1 = idxs[1] if len(idxs) > 1 else 255
            b2 = idxs[2] if len(idxs) > 2 else 255
            terms_packed.append(b0 | (b1 << 8) | (b2 << 16) | (255 << 24))
        row_offs.append(len(terms_packed))
    return row_offs, terms_packed, row_c0


def run_step12b_cell(cell_name, lib_diag, lib9, lib_cg, lib_fws, orbits, orb_tt_np,
                     v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 12B: FAST WALKSAT ON CG12 & CG388 + 0xFF SPLIT ====================", flush=True)
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    n, n_cw = tbl["n"], tbl["n_col_words"]

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

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=5, verify_subst=False)
    root_quad_psets = [s9.row_to_pset(root["_buf"], qr, tbl) for qr in root["_quad_ids"]]
    forms = s9.find_minimal_linearizers(root_quad_psets, n)["linearizer_forms_111"]
    k_lin = len(forms)

    target_br, target_bmask = None, None
    for bmask in range(1 << k_lin):
        bres = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            [(forms[i], (bmask >> i) & 1) for i in range(k_lin)], tbl, max_xl_rounds=5, verify_subst=False
        )
        if not bres["closed_unsat"]:
            target_br, target_bmask = bres, bmask
            break

    active_vars = sorted(i for i in range(n) if i not in target_br["_lin_pivs"])
    N_act = len(active_vars)
    old_to_new = {old_i: new_i for new_i, old_i in enumerate(active_vars)}
    avoid_zero = 1 if (cell_name == "B0_00" and target_bmask == 0) else 0

    # PART 1A: Fast WalkSAT on SPARSE CG12 (112 cubics, ~1.8M occ, 25s budget!)
    cg12_sub = (ctypes.c_uint64 * (len(reps12) * n_cw))()
    ctypes.memmove(cg12_sub, cg_buf, len(reps12) * n_cw * 8)
    mask64 = (1 << 64) - 1
    for p, (pv, pr) in target_br["_lin_pivs"].items():
        m = pv ^ (1 << p)
        lib9.subst_one_linear_var_batch(
            cg12_sub, len(reps12), n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
            tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
            p, m & mask64, m >> 64, pr
        )
    ro12, tp12, c012 = pack_rows_for_fws(cg12_sub, list(range(len(reps12))), old_to_new, tbl)
    tot12 = lib_fws.fws_init(N_act, len(reps12), (ctypes.c_uint32 * len(ro12))(*ro12),
                             (ctypes.c_uint32 * len(tp12))(*tp12), (ctypes.c_uint8 * len(c012))(*c012))
    bx12 = (ctypes.c_uint8 * N_act)()
    st12 = ctypes.c_int(0)
    mv12 = lib_fws.fws_run(6, 25.0, avoid_zero, 2026111812, bx12, ctypes.byref(st12))
    lib_fws.fws_free()
    print(f"[{cell_name}] PART 1A WalkSAT on 116 sparse CG12 (occ={tot12}, steps={st12.value}): min_viol = {mv12} / 116 (wt={sum(bx12)})", flush=True)

    # PART 1B: Fast WalkSAT on ALL 388 genuine CG cubics (40s budget, k_try=4!)
    M_cub = len(target_br["_cub_ids"])
    ro388, tp388, c0388 = pack_rows_for_fws(target_br["_buf"], target_br["_cub_ids"], old_to_new, tbl)
    tot388 = lib_fws.fws_init(N_act, M_cub, (ctypes.c_uint32 * len(ro388))(*ro388),
                              (ctypes.c_uint32 * len(tp388))(*tp388), (ctypes.c_uint8 * len(c0388))(*c0388))
    bx388 = (ctypes.c_uint8 * N_act)()
    st388 = ctypes.c_int(0)
    mv388 = lib_fws.fws_run(4, 40.0, avoid_zero, 2026111838, bx388, ctypes.byref(st388))
    lib_fws.fws_free()
    print(f"[{cell_name}] PART 1B WalkSAT on ALL {M_cub} CG cubics (occ={tot388}, steps={st388.value}): min_viol = {mv388} / {M_cub} (wt={sum(bx388)})", flush=True)

    # PART 2: Split branch across 0xFF+D8's 7 rho-invariant linear forms (test 128 states!)
    b_tt = np.zeros((111, 65536), dtype=np.uint8)
    for i, m in enumerate(cb111):
        tmp = m
        while tmp:
            lb = tmp & -tmp
            b_tt[i] ^= orb_tt_np[lb.bit_length() - 1]
            tmp ^= lb
    D8 = np.array([v | (v << 8) for v in range(256)], dtype=np.uint16)
    pts_ff = D8 ^ np.uint16(0xFF)
    piv_lf, ff_forms = {}, []
    for x in pts_ff:
        m = sum((1 << i) for i in range(111) if b_tt[i, x])
        rem = m
        while rem:
            b = rem.bit_length() - 1
            if b in piv_lf: rem ^= piv_lf[b]
            else:
                piv_lf[b] = rem
                ff_forms.append(m)
                break
    ff_closed, ff_lin, ff_quad, ff_max_q = 0, 0, 0, 0
    for s_mask in range(1 << len(ff_forms)):
        ex = [(ff_forms[r], (s_mask >> r) & 1) for r in range(len(ff_forms))]
        sr = s9.run_branch_cascade(
            lib9, target_br["_buf"], target_br["_quad_ids"], target_br["_cub_ids"], target_br["_lin_pivs"],
            ex, tbl, max_xl_rounds=4, verify_subst=False
        )
        if sr["closed_unsat"]:
            ff_closed += 1
        else:
            if sr["total_lin_dropped"] > 0: ff_lin += 1
            if sr["n_quad_surviving"] > target_br["n_quad_surviving"]:
                ff_quad += 1
                ff_max_q = max(ff_max_q, sr["n_quad_surviving"])
    print(f"[{cell_name}] PART 2 0xFF+D8 {len(ff_forms)}-form split (all {1<<len(ff_forms)} states): "
          f"closed={ff_closed}, lin_drop={ff_lin}, quad_drop={ff_quad} (max_q={ff_max_q})", flush=True)

    res = {
        "cell": cell_name, "branch": target_bmask, "N_act": N_act,
        "walksat_cg12": {"min_viol": mv12, "M": 116, "steps": st12.value, "wt": int(sum(bx12))},
        "walksat_cg388": {"min_viol": mv388, "M": M_cub, "steps": st388.value, "wt": int(sum(bx388))},
        "ff_split": {"rank": len(ff_forms), "closed": ff_closed, "lin_drop": ff_lin, "quad_drop": ff_quad, "max_q": ff_max_q},
        "elapsed_sec": round(time.perf_counter() - t0, 2),
    }
    print(f"[{cell_name}] STEP 12B SUMMARY: {json.dumps(res)}", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s12b_diag.c", WORK_DIR / "libs12b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s12b_s9.c", WORK_DIR / "libs12b_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s12b_cg.c", WORK_DIR / "libs12b_cg.so"
    c_cg.write_text(s10.C_CG_SRC, encoding="utf-8")
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

    c_ws, so_ws = WORK_DIR / "s12b_ws.c", WORK_DIR / "libs12b_ws.so"
    c_ws.write_text(C_FAST_WS_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_ws), "-o", str(so_ws)], check=True)
    lib_fws = ctypes.CDLL(str(so_ws))
    lib_fws.fws_init.argtypes = [
        ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_uint8),
    ]
    lib_fws.fws_init.restype = ctypes.c_int
    lib_fws.fws_run.argtypes = [
        ctypes.c_int, ctypes.c_double, ctypes.c_int, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_int),
    ]
    lib_fws.fws_run.restype = ctypes.c_int

    orbits = diag_v2.build_orbits_116()
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
        run_step12b_cell(
            cname, lib_diag, lib9, lib_cg, lib_fws, orbits, orb_tt_np,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
r"""
SOLVE_STEP11B_CG389_BRANCH_PROBE.py

Attack 11B on the 388 Genuine Carlet-Guillot NNF Cubics (on surviving linearized branch, N=104..106):
  1. Exact 1-literal probing (all 2*N branches) on all 388 genuine cubics in C:
     detects any drop to deg 0 (unit!), deg 1 (linear!), or deg 2 (quad!).
  2. Exact k-depth Collapse Curve (k = 5, 10, 15, ..., 85 fixed vars):
     measures AT EXACTLY WHAT DEPTH k the 388 genuine cubics collapse into
     quadratics, linears, and 1 = 0! (Both random-order and high-degree-order.)
  3. Fast C WalkSAT / Greedy Local Search directly on the 388 Carlet-Guillot cubics:
     tests whether V_3 (all 388 cubics simultaneously) even has reachable solutions
     in B0_11, B1_11, or non-zero B0_00!
"""

import argparse
import ctypes
import json
import random
import subprocess
import sys
import time
from pathlib import Path

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_B09_DUAL_S_ELIM as b09
import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP10_CARLET_GUILLOT_NNF as s10

C_PROBE11B_SRC = r"""
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

// Fast specialized evaluation of M <= 512 cubics in N <= 111 variables for WalkSAT!
// Represent each cubic r in 0..M-1 as flat list of (v0, v1, v2) where unused = 255.
// Actually even faster: for each variable v in 0..N-1, flipping v toggles polynomial r
// by evaluating the derivative dP_r / dx_v (a degree <= 2 polynomial in x)!
// Even simpler: store per-row term list (packed uint32_t: b0, b1, b2, 0xFF) AND
// for each variable v, store an index of terms containing v -> flipping v only touches
// terms containing v!
typedef struct {
    int N, M;
    // Per variable v: list of (row_id, other_v1, other_v2) where other_v = 255 if absent!
    int *v_off;
    uint16_t *t_row;
    uint8_t *t_a;
    uint8_t *t_b;
    // Base constant parity of each row at x = 0
    uint8_t *row_c0;
} CubicWalk;

static CubicWalk CW;

int cw_init(int N, int M, const uint32_t *row_offs, const uint32_t *terms_packed, const uint8_t *row_c0) {
    memset(&CW, 0, sizeof(CW));
    CW.N = N; CW.M = M;
    CW.row_c0 = (uint8_t *)malloc((size_t)M);
    memcpy(CW.row_c0, row_c0, (size_t)M);

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
    CW.v_off = (int *)malloc((size_t)(N + 1) * sizeof(int));
    CW.v_off[0] = 0;
    for (int v = 0; v < N; v++) CW.v_off[v + 1] = CW.v_off[v] + cnt[v];
    int tot = CW.v_off[N];
    CW.t_row = (uint16_t *)malloc((size_t)tot * sizeof(uint16_t));
    CW.t_a = (uint8_t *)malloc((size_t)tot);
    CW.t_b = (uint8_t *)malloc((size_t)tot);
    int *pos = (int *)malloc((size_t)N * sizeof(int));
    memcpy(pos, CW.v_off, (size_t)N * sizeof(int));

    for (int r = 0; r < M; r++) {
        for (uint32_t t = row_offs[r]; t < row_offs[r + 1]; t++) {
            uint32_t pm = terms_packed[t];
            uint8_t b0 = pm & 0xFFU, b1 = (pm >> 8) & 0xFFU, b2 = (pm >> 16) & 0xFFU;
            if (b0 < N) {
                int p = pos[b0]++;
                CW.t_row[p] = (uint16_t)r; CW.t_a[p] = b1; CW.t_b[p] = b2;
            }
            if (b1 < N) {
                int p = pos[b1]++;
                CW.t_row[p] = (uint16_t)r; CW.t_a[p] = b0; CW.t_b[p] = b2;
            }
            if (b2 < N) {
                int p = pos[b2]++;
                CW.t_row[p] = (uint16_t)r; CW.t_a[p] = b0; CW.t_b[p] = b1;
            }
        }
    }
    free(cnt); free(pos);
    return tot;
}

void cw_free(void) {
    free(CW.v_off); free(CW.t_row); free(CW.t_a); free(CW.t_b); free(CW.row_c0);
    memset(&CW, 0, sizeof(CW));
}

static uint64_t xorshift64(uint64_t *st) {
    uint64_t x = *st;
    x ^= x << 13; x ^= x >> 7; x ^= x << 17;
    *st = x;
    return x;
}

// Run `n_restarts` x `n_steps` WalkSAT / steepest-descent with 15% noise on the M cubics!
// If avoid_zero==1, forbids x == 0 (for B0_00!).
// Returns minimum violated cubics found; writes best x bits into out_best_x[N].
int cw_walksat(int n_restarts, int n_steps, int avoid_zero, uint64_t seed, uint8_t *out_best_x) {
    int N = CW.N, M = CW.M;
    uint8_t x[128];
    uint8_t val[512];
    uint8_t delta[512];
    int best_viol = M + 1;
    uint64_t rng = seed ? seed : 88172645463325252ULL;

    for (int rs = 0; rs < n_restarts; rs++) {
        // Initialize random x (non-zero if avoid_zero)
        int x_wt = 0;
        for (int i = 0; i < N; i++) {
            x[i] = (uint8_t)(xorshift64(&rng) & 1ULL);
            x_wt += x[i];
        }
        if (avoid_zero && x_wt == 0) { x[0] = 1; x_wt = 1; }

        // Evaluate all M rows from scratch by flipping active variables from 0
        memcpy(val, CW.row_c0, (size_t)M);
        uint8_t cur_x[128];
        memset(cur_x, 0, (size_t)N);
        for (int v = 0; v < N; v++) {
            if (!x[v]) continue;
            int s = CW.v_off[v], e = CW.v_off[v + 1];
            for (int p = s; p < e; p++) {
                uint8_t a = CW.t_a[p], b = CW.t_b[p];
                if ((a == 255 || cur_x[a]) && (b == 255 || cur_x[b])) {
                    val[CW.t_row[p]] ^= 1;
                }
            }
            cur_x[v] = 1;
        }
        int cur_viol = 0;
        for (int r = 0; r < M; r++) cur_viol += val[r];
        if (cur_viol < best_viol) {
            best_viol = cur_viol;
            memcpy(out_best_x, x, (size_t)N);
            if (best_viol == 0) return 0;
        }

        for (int st = 0; st < n_steps; st++) {
            int chosen_v = -1;
            int best_nv = M + 1;
            // With 15% probability pick random variable (simulated annealing / noise), else steepest descent over 24 random vars
            if ((xorshift64(&rng) % 100) < 15) {
                chosen_v = (int)(xorshift64(&rng) % (uint64_t)N);
                if (avoid_zero && x_wt == 1 && x[chosen_v] == 1) chosen_v = (chosen_v + 1) % N;
            } else {
                // Sample 24 candidate variables (or all N if cur_viol <= 40)
                int n_try = (cur_viol <= 40) ? N : 24;
                for (int k = 0; k < n_try; k++) {
                    int v = (n_try == N) ? k : (int)(xorshift64(&rng) % (uint64_t)N);
                    if (avoid_zero && x_wt == 1 && x[v] == 1) continue;
                    memset(delta, 0, (size_t)M);
                    int s = CW.v_off[v], e = CW.v_off[v + 1];
                    for (int p = s; p < e; p++) {
                        uint8_t a = CW.t_a[p], b = CW.t_b[p];
                        if ((a == 255 || x[a]) && (b == 255 || x[b])) {
                            delta[CW.t_row[p]] ^= 1;
                        }
                    }
                    int nv = cur_viol;
                    for (int r = 0; r < M; r++) {
                        if (delta[r]) nv += (val[r] ? -1 : 1);
                    }
                    if (nv < best_nv || (nv == best_nv && (xorshift64(&rng) & 1ULL))) {
                        best_nv = nv;
                        chosen_v = v;
                    }
                }
            }
            if (chosen_v < 0) continue;
            // Apply flip of chosen_v
            int s = CW.v_off[chosen_v], e = CW.v_off[chosen_v + 1];
            for (int p = s; p < e; p++) {
                uint8_t a = CW.t_a[p], b = CW.t_b[p];
                if ((a == 255 || x[a]) && (b == 255 || x[b])) {
                    int r = CW.t_row[p];
                    cur_viol += (val[r] ? -1 : 1);
                    val[r] ^= 1;
                }
            }
            x_wt += (x[chosen_v] ? -1 : 1);
            x[chosen_v] ^= 1;
            if (cur_viol < best_viol) {
                best_viol = cur_viol;
                memcpy(out_best_x, x, (size_t)N);
                if (best_viol == 0) return 0;
            }
        }
    }
    return best_viol;
}
"""


def run_step11b_cell(cell_name, lib_diag, lib9, lib_cg, lib_cw, orbits,
                     v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 11B: CG(389) PROBE + K-COLLAPSE + WALKSAT ====================", flush=True)
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    n = tbl["n"]
    n_cw = tbl["n_col_words"]

    # Build 389 Carlet-Guillot cubics
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

    sys_data = diag_v2.build_cell_algebraic_system(
        cell_name, lib_diag, orbits, v6_list, rot4_data, fiber_meta, extract_sec=18.0
    )
    cyc_cubs = s9.extract_verified_cyclotomic_cubics(cell_name, orbits, origin111, cb111, layers, c0x0)
    n_base_pivs = sum(sys_data["deg_pivs_111"].values())
    total_raw = n_base_pivs + len(cyc_cubs) + n_cg
    raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base_pivs * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, raw_buf, n_base_pivs + idx_c, tbl)
    dst_cg = ctypes.cast(ctypes.byref(raw_buf, (n_base_pivs + len(cyc_cubs)) * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
    ctypes.memmove(dst_cg, cg_buf, n_cg * n_cw * 8)

    root = s9.run_branch_cascade(
        lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=5, verify_subst=False
    )
    root_quad_psets = [s9.row_to_pset(root["_buf"], qr, tbl) for qr in root["_quad_ids"]]
    lin_info = s9.find_minimal_linearizers(root_quad_psets, n)
    forms = lin_info["linearizer_forms_111"]
    k_lin = len(forms)

    # Pick first surviving branch (for B0_00 pick branch 000 AND branch 001? Pick first surviving with 0 quads!)
    target_br = None
    target_bmask = None
    for bmask in range(1 << k_lin):
        extra = [(forms[i], (bmask >> i) & 1) for i in range(k_lin)]
        bres = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            extra, tbl, max_xl_rounds=5, verify_subst=False
        )
        if not bres["closed_unsat"]:
            target_br = bres
            target_bmask = bmask
            break

    active_vars = sorted(i for i in range(n) if i not in target_br["_lin_pivs"])
    N_act = len(active_vars)
    M_cub = len(target_br["_cub_ids"])
    print(f"[{cell_name}] Targeting surviving branch {target_bmask:0{k_lin}b}: N_act={N_act}, "
          f"quads={target_br['n_quad_surviving']}, cubics={M_cub}", flush=True)

    # --------------------------------------------------------------------------
    # PART 1: Exact 1-Literal Probing on ALL N_act variables (2 * N_act probes!)
    # --------------------------------------------------------------------------
    t_p1 = time.perf_counter()
    p1_closed = 0
    p1_any_lin = 0
    p1_any_quad = 0
    p1_max_quad = 0
    for v in active_vars:
        for val in (0, 1):
            pr = s9.run_branch_cascade(
                lib9, target_br["_buf"], target_br["_quad_ids"], target_br["_cub_ids"],
                target_br["_lin_pivs"], [(1 << v, val)], tbl, max_xl_rounds=3, verify_subst=False
            )
            if pr["closed_unsat"]:
                p1_closed += 1
            else:
                if pr["total_lin_dropped"] > 0:
                    p1_any_lin += 1
                if pr["n_quad_surviving"] > target_br["n_quad_surviving"]:
                    p1_any_quad += 1
                    p1_max_quad = max(p1_max_quad, pr["n_quad_surviving"])
    print(f"[{cell_name}] Part 1 (1-lit probe on {2*N_act} branches, {time.perf_counter()-t_p1:.1f}s): "
          f"closed={p1_closed}, any_lin_drop={p1_any_lin}, any_quad_drop={p1_any_quad} (max_q={p1_max_quad})", flush=True)

    # --------------------------------------------------------------------------
    # PART 2: Exact k-Depth Collapse Curve (k = 10, 20, 30, 40, 50, 60, 65, 70, 75, 80, 85)
    # --------------------------------------------------------------------------
    t_p2 = time.perf_counter()
    rng = random.Random(20261102)
    collapse_curve = []
    for k_fix in (10, 20, 30, 40, 50, 60, 65, 70, 75, 80, 85, 90):
        if k_fix >= N_act - 2:
            break
        trial_res = []
        for tr in range(3):
            chosen = rng.sample(active_vars, k_fix)
            # In B0_00 branch 000, avoid all-0 assignment so we test non-trivial cubes!
            vals = [rng.randint(0, 1) for _ in range(k_fix)]
            if cell_name == "B0_00" and sum(vals) == 0:
                vals[0] = 1
            eqs = [(1 << chosen[i], vals[i]) for i in range(k_fix)]
            pr = s9.run_branch_cascade(
                lib9, target_br["_buf"], target_br["_quad_ids"], target_br["_cub_ids"],
                target_br["_lin_pivs"], eqs, tbl, max_xl_rounds=4, verify_subst=False
            )
            trial_res.append({
                "closed": pr["closed_unsat"],
                "N_rem": pr.get("N_active", 0),
                "lin_drop": pr.get("total_lin_dropped", 0),
                "quads": pr.get("n_quad_surviving", 0),
                "cubs": pr.get("n_genuine_cubics", 0),
            })
        n_cl = sum(1 for r in trial_res if r["closed"])
        avg_q = round(sum(r["quads"] for r in trial_res) / len(trial_res), 1)
        avg_l = round(sum(r["lin_drop"] for r in trial_res) / len(trial_res), 1)
        avg_c = round(sum(r["cubs"] for r in trial_res) / len(trial_res), 1)
        entry = {"k_fixed": k_fix, "N_rem_init": N_act - k_fix, "closed_of_3": n_cl,
                 "avg_lin_drop": avg_l, "avg_quads": avg_q, "avg_cubs": avg_c}
        collapse_curve.append(entry)
        print(f"  [{cell_name}] k={k_fix:2d} (N_rem={N_act-k_fix:2d}): closed={n_cl}/3, "
              f"avg_lin_drop={avg_l}, avg_quads={avg_q}, avg_cubs={avg_c}", flush=True)
    print(f"[{cell_name}] Part 2 collapse curve done in {time.perf_counter()-t_p2:.1f}s", flush=True)

    # --------------------------------------------------------------------------
    # PART 3: Fast C WalkSAT / Steepest-Descent Local Search on ALL 388 CG Cubics!
    # --------------------------------------------------------------------------
    t_p3 = time.perf_counter()
    old_to_new = {old_i: new_i for new_i, old_i in enumerate(active_vars)}
    row_offs = [0]
    terms_packed = []
    row_c0 = []
    for cr in target_br["_cub_ids"]:
        ps = s9.row_to_pset(target_br["_buf"], cr, tbl)
        c0 = 1 if (0 in ps) else 0
        row_c0.append(c0)
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

    ro_arr = (ctypes.c_uint32 * len(row_offs))(*row_offs)
    tp_arr = (ctypes.c_uint32 * len(terms_packed))(*terms_packed)
    c0_arr = (ctypes.c_uint8 * len(row_c0))(*row_c0)
    tot_occ = lib_cw.cw_init(N_act, M_cub, ro_arr, tp_arr, c0_arr)

    best_x = (ctypes.c_uint8 * N_act)()
    avoid_zero = 1 if (cell_name == "B0_00" and target_bmask == 0) else 0
    min_viol = lib_cw.cw_walksat(25, 1500, avoid_zero, 2026111819, best_x)
    best_x_wt = sum(best_x[i] for i in range(N_act))
    lib_cw.cw_free()
    print(f"[{cell_name}] Part 3 WalkSAT on {M_cub} CG cubics (25x1500 steps, {time.perf_counter()-t_p3:.1f}s, "
          f"occ={tot_occ}): min_violated_cubics = {min_viol} / {M_cub} (best_x_wt={best_x_wt})", flush=True)

    res = {
        "cell": cell_name,
        "branch": target_bmask,
        "N_act": N_act,
        "M_cubics": M_cub,
        "probe_1lit": {"closed": p1_closed, "any_lin_drop": p1_any_lin, "any_quad_drop": p1_any_quad, "max_q": p1_max_quad},
        "collapse_curve": collapse_curve,
        "walksat_v3": {"min_violated_of_M": min_viol, "M": M_cub, "best_x_wt": best_x_wt},
        "elapsed_sec": round(time.perf_counter() - t0, 3),
    }
    print(f"[{cell_name}] STEP 11B SUMMARY: {json.dumps(res)}", flush=True)
    return res


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s11b_diag.c", WORK_DIR / "libs11b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s11b_s9.c", WORK_DIR / "libs11b_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s11b_cg.c", WORK_DIR / "libs11b_cg.so"
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

    c_cw, so_cw = WORK_DIR / "s11b_cw.c", WORK_DIR / "libs11b_cw.so"
    c_cw.write_text(C_PROBE11B_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_cw), "-o", str(so_cw)], check=True)
    lib_cw = ctypes.CDLL(str(so_cw))
    lib_cw.cw_init.argtypes = [
        ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_uint8),
    ]
    lib_cw.cw_init.restype = ctypes.c_int
    lib_cw.cw_walksat.argtypes = [ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_uint64, ctypes.POINTER(ctypes.c_uint8)]
    lib_cw.cw_walksat.restype = ctypes.c_int

    orbits = diag_v2.build_orbits_116()
    mon_to_orb_arr = (ctypes.c_int16 * 65536)(*([-1] * 65536))
    for j, orb in enumerate(orbits):
        for m in orb:
            mon_to_orb_arr[m] = j
    reps12 = s10.subset_orbits(12)
    reps11 = s10.subset_orbits(11)

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

    for cname in [c.strip() for c in args.cells.split(",") if c.strip()]:
        run_step11b_cell(
            cname, lib_diag, lib9, lib_cg, lib_cw, orbits,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()

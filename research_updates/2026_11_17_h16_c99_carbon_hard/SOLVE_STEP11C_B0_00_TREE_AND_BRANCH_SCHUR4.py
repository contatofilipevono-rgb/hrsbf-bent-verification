#!/usr/bin/env python3
r"""
SOLVE_STEP11C_B0_00_TREE_AND_BRANCH_SCHUR4.py

Two high-leverage attacks executed in parallel with 11A/11B/11D:
  PART A (for B0_00): Complete Recursive Symplectic DFS on all 5 non-zero branches
    (001, 010, 011, 101, 110) with ALL 389 Carlet-Guillot cubics!
    Tests whether recursive symplectic splitting algebraically closes ALL 5 non-zero
    branches of B0_00, isolating B0_00 down to the single normal-bent branch 000!
  PART B (for ALL 3 cells):
    1. Builds exact pure Degree-4 Carlet-Guillot equations CG(|I|=16) (1 eq),
       CG(|I|=15) (1 eq), AND ALL 8 CG(|I|=14) equations in C, with ZERO-TRUST
       verification against direct integer lambda_I(f)/8 mod 2 on 8 random points!
    2. Runs Schur-Complement Degree-4 Mutant-XL INSIDE the first surviving linearized
       branch (N=104..106, where all root quadratics are ALREADY eliminated!),
       injecting CG16 + CG15 + 8xCG14 + multiplying all 116 sparse CG12 cubics
       by all N_branch variables!
"""

import argparse
import ctypes
import itertools
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
import SOLVE_STEP11_CG_SCHUR_DEG4 as s11

C_CG14_EXTRA_SRC = s11.C_SCHUR11_SRC + r"""

// Build CG(|I|=14) for an arbitrary 14-element subset I_mask (14 bits set) directly into G.tmp_bits!
// Four exact disjoint topologies of unordered 4-covers {S1,S2,S3,S4} of size-14 set I:
//   T1: one element t covered 3 times: S1={t}uA, S2={t}uB, S3={t}uC (|A|=|B|=|C|=3), S4 disjoint 4-set
//   T2: two elements {d1,d2} covered twice in SAME pair: S1={d1,d2}uA, S2={d1,d2}uB (|A|=|B|=2), S3,S4 disjoint 4-sets
//   T3a: two disjoint overlap pairs: S1={d1}uA, S2={d1}uB (7 els), S3={d2}uC, S4={d2}uD (7 els)
//   T3b: chain of 3 + isolated 4-set: S2={d1,d2}uM (|M|=2), S1={d1}uA (|A|=3), S3={d2}uB (|B|=3), S4 disjoint 4-set
int s11_build_cg14(
    int I_mask,
    const int16_t *mon_to_orb,
    const int *orb_n, const int *orb_vars, const int *orb_c,
    int reduce_now, uint32_t *out_gcols, int max_out
) {
    int el[14], ne = 0;
    for (int b = 0; b < 16; b++) if ((I_mask >> b) & 1) el[ne++] = b;
    if (ne != 14) return -2;

    uint32_t min_w = UINT32_MAX, max_w = 0;

    // --- T1: choose isolated 4-set S4 (C(14,4)=1001), choose t in remaining 10, split 9 into (3,3,3) (280) ---
    for (int a0 = 0; a0 < 14; a0++)
    for (int a1 = a0 + 1; a1 < 14; a1++)
    for (int a2 = a1 + 1; a2 < 14; a2++)
    for (int a3 = a2 + 1; a3 < 14; a3++) {
        int s4 = (1<<el[a0])|(1<<el[a1])|(1<<el[a2])|(1<<el[a3]);
        int j4 = mon_to_orb[s4];
        int r10[10], n10 = 0;
        for (int x = 0; x < 14; x++) if (x!=a0 && x!=a1 && x!=a2 && x!=a3) r10[n10++] = el[x];
        int rem10_mask = I_mask ^ s4;
        for (int ti = 0; ti < 10; ti++) {
            int bt = 1 << r10[ti];
            int r9[9], n9 = 0;
            for (int x = 0; x < 10; x++) if (x != ti) r9[n9++] = r10[x];
            int r9_mask = rem10_mask ^ bt;
            // Fix r9[0] in A (choose 2 from 1..8 -> 28), then fix first remaining in B (choose 2 from 5 -> 10)
            for (int u1 = 1; u1 < 9; u1++)
            for (int u2 = u1 + 1; u2 < 9; u2++) {
                int am = (1<<r9[0])|(1<<r9[u1])|(1<<r9[u2]);
                int j1 = mon_to_orb[bt | am];
                int r6[6], n6 = 0;
                for (int x = 1; x < 9; x++) if (x != u1 && x != u2) r6[n6++] = r9[x];
                int r6_mask = r9_mask ^ am;
                for (int v1 = 1; v1 < 6; v1++)
                for (int v2 = v1 + 1; v2 < 6; v2++) {
                    int bm = (1<<r6[0])|(1<<r6[v1])|(1<<r6[v2]);
                    int cm = r6_mask ^ bm;
                    toggle_orb4_into_tmp(j1, mon_to_orb[bt | bm], mon_to_orb[bt | cm], j4,
                                         orb_n, orb_vars, orb_c, &min_w, &max_w);
                }
            }
        }
    }

    // --- T2: choose {d1, d2} (91), choose 4 of 12 for A u B (495), split 4 into (2,2) (3), split 8 into (4,4) (35) ---
    for (int d1 = 0; d1 < 14; d1++)
    for (int d2 = d1 + 1; d2 < 14; d2++) {
        int bd12 = (1 << el[d1]) | (1 << el[d2]);
        int r12[12], n12 = 0;
        for (int x = 0; x < 14; x++) if (x != d1 && x != d2) r12[n12++] = el[x];
        int rem12_mask = I_mask ^ bd12;
        for (int i0 = 0; i0 < 12; i0++)
        for (int i1 = i0 + 1; i1 < 12; i1++)
        for (int i2 = i1 + 1; i2 < 12; i2++)
        for (int i3 = i2 + 1; i3 < 12; i3++) {
            int q[4] = {r12[i0], r12[i1], r12[i2], r12[i3]};
            int qm = (1<<q[0])|(1<<q[1])|(1<<q[2])|(1<<q[3]);
            int pj1[3], pj2[3];
            for (int p = 1; p < 4; p++) {
                int am = (1<<q[0])|(1<<q[p]);
                pj1[p-1] = mon_to_orb[bd12 | am];
                pj2[p-1] = mon_to_orb[bd12 | (qm ^ am)];
            }
            int r8[8], n8 = 0;
            for (int x = 0; x < 12; x++) if (x!=i0 && x!=i1 && x!=i2 && x!=i3) r8[n8++] = r12[x];
            int r8m = rem12_mask ^ qm;
            for (int c1 = 1; c1 < 8; c1++)
            for (int c2 = c1 + 1; c2 < 8; c2++)
            for (int c3 = c2 + 1; c3 < 8; c3++) {
                int s3 = (1<<r8[0])|(1<<r8[c1])|(1<<r8[c2])|(1<<r8[c3]);
                int s4 = r8m ^ s3;
                int j3 = mon_to_orb[s3], j4 = mon_to_orb[s4];
                for (int p = 0; p < 3; p++) {
                    toggle_orb4_into_tmp(pj1[p], pj2[p], j3, j4,
                                         orb_n, orb_vars, orb_c, &min_w, &max_w);
                }
            }
        }
    }

    // --- T3a: split 14 into two 7-sets (fix el[0] in P: C(13,6)=1716); each 7-set split into d + (3,3) (70 each) ---
    for (int i1 = 1; i1 < 14; i1++)
    for (int i2 = i1 + 1; i2 < 14; i2++)
    for (int i3 = i2 + 1; i3 < 14; i3++)
    for (int i4 = i3 + 1; i4 < 14; i4++)
    for (int i5 = i4 + 1; i5 < 14; i5++)
    for (int i6 = i5 + 1; i6 < 14; i6++) {
        int P[7] = {el[0], el[i1], el[i2], el[i3], el[i4], el[i5], el[i6]};
        int Pm = (1<<P[0])|(1<<P[1])|(1<<P[2])|(1<<P[3])|(1<<P[4])|(1<<P[5])|(1<<P[6]);
        int Q[7], nq = 0;
        for (int x = 1; x < 14; x++) {
            if (x!=i1 && x!=i2 && x!=i3 && x!=i4 && x!=i5 && x!=i6) Q[nq++] = el[x];
        }
        int Qm = I_mask ^ Pm;
        int p1[70], p2[70], np = 0;
        for (int d = 0; d < 7; d++) {
            int bd = 1 << P[d];
            int r6[6], n6 = 0;
            for (int x = 0; x < 7; x++) if (x != d) r6[n6++] = P[x];
            int r6m = Pm ^ bd;
            for (int u = 1; u < 6; u++)
            for (int v = u + 1; v < 6; v++) {
                int am = (1<<r6[0])|(1<<r6[u])|(1<<r6[v]);
                p1[np] = mon_to_orb[bd | am];
                p2[np] = mon_to_orb[bd | (r6m ^ am)];
                np++;
            }
        }
        int q1[70], q2[70], nqq = 0;
        for (int d = 0; d < 7; d++) {
            int bd = 1 << Q[d];
            int r6[6], n6 = 0;
            for (int x = 0; x < 7; x++) if (x != d) r6[n6++] = Q[x];
            int r6m = Qm ^ bd;
            for (int u = 1; u < 6; u++)
            for (int v = u + 1; v < 6; v++) {
                int am = (1<<r6[0])|(1<<r6[u])|(1<<r6[v]);
                q1[nqq] = mon_to_orb[bd | am];
                q2[nqq] = mon_to_orb[bd | (r6m ^ am)];
                nqq++;
            }
        }
        for (int a = 0; a < 70; a++)
        for (int b = 0; b < 70; b++) {
            toggle_orb4_into_tmp(p1[a], p2[a], q1[b], q2[b],
                                 orb_n, orb_vars, orb_c, &min_w, &max_w);
        }
    }

    // --- T3b: chain S1-S2-S3 + isolated S4 ---
    // Choose unordered {d1, d2} (91); choose S4 from remaining 12 (495);
    // from remaining 8 choose M (size 2, C(8,2)=28) -> S2 = {d1,d2}uM;
    // from remaining 6 choose A (size 3, C(6,3)=20) -> S1 = {d1}uA, S3 = {d2}u(rem3)!
    // Notice: since d1 < d2 are ordered by index, choosing A of size 3 (all 20 subsets, NOT 10!)
    // uniquely pairs A with d1 and B=rem\A with d2 — EVERY unordered chain {S1,S2,S3,S4} counted ONCE!
    for (int d1 = 0; d1 < 14; d1++)
    for (int d2 = d1 + 1; d2 < 14; d2++) {
        int b1 = 1 << el[d1], b2 = 1 << el[d2];
        int bd12 = b1 | b2;
        int r12[12], n12 = 0;
        for (int x = 0; x < 14; x++) if (x != d1 && x != d2) r12[n12++] = el[x];
        int rem12_mask = I_mask ^ bd12;
        for (int i0 = 0; i0 < 12; i0++)
        for (int i1 = i0 + 1; i1 < 12; i1++)
        for (int i2 = i1 + 1; i2 < 12; i2++)
        for (int i3 = i2 + 1; i3 < 12; i3++) {
            int s4 = (1<<r12[i0])|(1<<r12[i1])|(1<<r12[i2])|(1<<r12[i3]);
            int j4 = mon_to_orb[s4];
            int r8[8], n8 = 0;
            for (int x = 0; x < 12; x++) if (x!=i0 && x!=i1 && x!=i2 && x!=i3) r8[n8++] = r12[x];
            int r8m = rem12_mask ^ s4;
            for (int m0 = 0; m0 < 8; m0++)
            for (int m1 = m0 + 1; m1 < 8; m1++) {
                int mm = (1<<r8[m0])|(1<<r8[m1]);
                int j2 = mon_to_orb[bd12 | mm];
                int r6[6], n6 = 0;
                for (int x = 0; x < 8; x++) if (x != m0 && x != m1) r6[n6++] = r8[x];
                int r6m = r8m ^ mm;
                for (int a0 = 0; a0 < 6; a0++)
                for (int a1 = a0 + 1; a1 < 6; a1++)
                for (int a2 = a1 + 1; a2 < 6; a2++) {
                    int am = (1<<r6[a0])|(1<<r6[a1])|(1<<r6[a2]);
                    int bm = r6m ^ am;
                    toggle_orb4_into_tmp(mon_to_orb[b1 | am], j2, mon_to_orb[b2 | bm], j4,
                                         orb_n, orb_vars, orb_c, &min_w, &max_w);
                }
            }
        }
    }

    if (reduce_now) {
        if (min_w <= max_w) return reduce_tmp_deg4(min_w, max_w);
        return -1;
    }
    int cnt = 0;
    for (uint32_t w = min_w; w <= max_w; w++) {
        uint64_t v = G.tmp_bits[w];
        G.tmp_bits[w] = 0ULL;
        while (v) {
            int b = __builtin_ctzll(v);
            uint32_t gc = (w << 6) + b;
            if (cnt < max_out && out_gcols) out_gcols[cnt] = gc;
            cnt++;
            v &= v - 1;
        }
    }
    return cnt;
}

// Fast exact evaluation of a list of global column indices (deg<=4) at a binary vector x[N]!
int s11_eval_gcols_at_x(const uint32_t *gcols, int cnt, const uint8_t *x) {
    int acc = 0;
    for (int i = 0; i < cnt; i++) {
        uint32_t gc = gcols[i];
        if (gc == G.off0) {
            acc ^= 1;
        } else if (gc >= G.off1) {
            acc ^= x[gc - G.off1];
        } else if (gc >= G.off2) {
            uint32_t r = gc - G.off2;
            int b1 = 1;
            while (b1 + 1 < G.N && C_tab[b1 + 1][2] <= r) b1++;
            int b0 = (int)(r - C_tab[b1][2]);
            acc ^= (x[b0] & x[b1]);
        } else if (gc >= G.off3) {
            uint32_t r = gc - G.off3;
            int b2 = 2;
            while (b2 + 1 < G.N && C_tab[b2 + 1][3] <= r) b2++;
            r -= C_tab[b2][3];
            int b1 = 1;
            while (b1 + 1 < b2 && C_tab[b1 + 1][2] <= r) b1++;
            int b0 = (int)(r - C_tab[b1][2]);
            acc ^= (x[b0] & x[b1] & x[b2]);
        } else {
            uint32_t r = gc;
            int b3 = 3;
            while (b3 + 1 < G.N && C_tab[b3 + 1][4] <= r) b3++;
            r -= C_tab[b3][4];
            int b2 = 2;
            while (b2 + 1 < b3 && C_tab[b2 + 1][3] <= r) b2++;
            r -= C_tab[b2][3];
            int b1 = 1;
            while (b1 + 1 < b2 && C_tab[b1 + 1][2] <= r) b1++;
            int b0 = (int)(r - C_tab[b1][2]);
            acc ^= (x[b0] & x[b1] & x[b2] & x[b3]);
        }
    }
    return acc;
}
"""


def direct_lambda_I_div8_mod2(I_mask, c116_mask, orbits):
    """Zero-trust exact integer NNF coefficient lambda_I(f) / 8 mod 2 via Mobius sum on E_I."""
    bits = [b for b in range(16) if (I_mask >> b) & 1]
    d = len(bits)
    # Build active monomials of f that are subsets of I_mask
    active_mons = []
    for j in range(116):
        if (c116_mask >> j) & 1:
            for m in orbits[j]:
                if (m & I_mask) == m:
                    active_mons.append(m)
    # Sum (-1)^{d - wt(x)} f(x) over all 2^d points x <= I_mask
    total = 0
    # Fast evaluation via subset masks
    pts = [0]
    for b in bits:
        pts += [p | (1 << b) for p in pts]
    for x in pts:
        fx = 0
        for m in active_mons:
            if (x & m) == m:
                fx ^= 1
        if fx:
            total += 1 if ((d - x.bit_count()) & 1) == 0 else -1
    assert (total % 8) == 0, f"lambda_I={total} not divisible by 8!"
    return (total // 8) & 1


def run_b0_00_recursive_symplectic_tree(lib9, root, tbl, max_nodes=400, max_depth=5):
    """Exact recursive symplectic DFS on B0_00's 5 non-zero branches with ALL 389 CG cubics."""
    n = tbl["n"]
    root_quad_psets = [s9.row_to_pset(root["_buf"], qr, tbl) for qr in root["_quad_ids"]]
    lin_info = s9.find_minimal_linearizers(root_quad_psets, n)
    forms = lin_info["linearizer_forms_111"]
    k_lin = len(forms)

    branch_reports = {}
    for bmask in range(1 << k_lin):
        bname = f"{bmask:0{k_lin}b}"
        extra = [(forms[i], (bmask >> i) & 1) for i in range(k_lin)]
        bres = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            extra, tbl, max_xl_rounds=5, verify_subst=False
        )
        if bres["closed_unsat"]:
            branch_reports[bname] = {"status": "CLOSED_DEPTH1", "nodes": 1, "open_leaves": 0}
            print(f"  [B0_00 tree] branch {bname}: CLOSED at depth 1!", flush=True)
            continue
        if bmask == 0:
            branch_reports[bname] = {
                "status": "ZERO_BRANCH_SKIPPED",
                "N_act": bres["N_active"],
                "quads": bres["n_quad_surviving"],
                "cubs": bres["n_genuine_cubics"],
            }
            print(f"  [B0_00 tree] branch 000: N={bres['N_active']}, q={bres['n_quad_surviving']}, c={bres['n_genuine_cubics']} (zero-branch)", flush=True)
            continue

        # Recursive DFS on non-zero branch!
        nodes_visited = 0
        closed_leaves = 0
        open_leaves = []

        def dfs(node, depth):
            nonlocal nodes_visited, closed_leaves
            nodes_visited += 1
            if node["n_quad_surviving"] == 0 or depth >= max_depth or nodes_visited >= max_nodes:
                open_leaves.append({
                    "depth": depth, "N": node["N_active"],
                    "q": node["n_quad_surviving"], "c": node["n_genuine_cubics"]
                })
                return
            qps = [s9.row_to_pset(node["_buf"], qr, tbl) for qr in node["_quad_ids"]]
            li = s9.find_minimal_linearizers(qps, n)
            sub_forms = li["linearizer_forms_111"]
            # Cap branching factor per step to 2^3 = 8 so DFS stays crisp
            use_forms = sub_forms[:3]
            if not use_forms:
                open_leaves.append({
                    "depth": depth, "N": node["N_active"],
                    "q": node["n_quad_surviving"], "c": node["n_genuine_cubics"]
                })
                return
            for sm in range(1 << len(use_forms)):
                if nodes_visited >= max_nodes:
                    open_leaves.append({"depth": depth + 1, "truncated": True})
                    return
                ex = [(use_forms[i], (sm >> i) & 1) for i in range(len(use_forms))]
                sub = s9.run_branch_cascade(
                    lib9, node["_buf"], node["_quad_ids"], node["_cub_ids"], node["_lin_pivs"],
                    ex, tbl, max_xl_rounds=5, verify_subst=False
                )
                if sub["closed_unsat"]:
                    closed_leaves += 1
                else:
                    dfs(sub, depth + 1)

        dfs(bres, 1)
        status = "CLOSED_100%_UNSAT" if len(open_leaves) == 0 else f"OPEN({len(open_leaves)}_leaves)"
        branch_reports[bname] = {
            "status": status,
            "depth1_quads": bres["n_quad_surviving"],
            "nodes": nodes_visited,
            "closed_leaves": closed_leaves,
            "open_leaves_count": len(open_leaves),
            "sample_open_leaves": open_leaves[:5],
        }
        print(f"  [B0_00 tree] branch {bname} (d1_q={bres['n_quad_surviving']}): {status}, "
              f"nodes={nodes_visited}, closed_leaves={closed_leaves}, sample_open={open_leaves[:3]}", flush=True)
    return branch_reports


def run_step11c_cell(cell_name, budget_sec, lib_diag, lib9, lib_cg, lib11c, orbits,
                     v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps14, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 11C: B0_00 TREE + BRANCH SCHUR-DEG4 (CG16+CG15+8xCG14) ====================", flush=True)
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    n = tbl["n"]
    n_cw = tbl["n_col_words"]

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

    tree_report = None
    if cell_name == "B0_00":
        print(f"[{cell_name}] PART A: Running recursive symplectic DFS on 5 non-zero branches...", flush=True)
        tree_report = run_b0_00_recursive_symplectic_tree(lib9, root, tbl, max_nodes=400, max_depth=5)

    # PART B: Pick first surviving linearized branch (for B0_00 pick branch 001 if open else 000!)
    root_quad_psets = [s9.row_to_pset(root["_buf"], qr, tbl) for qr in root["_quad_ids"]]
    lin_info = s9.find_minimal_linearizers(root_quad_psets, n)
    forms = lin_info["linearizer_forms_111"]
    k_lin = len(forms)

    target_br = None
    target_bmask = None
    order = ([1, 2, 3, 5, 6, 0] if cell_name == "B0_00" else list(range(1 << k_lin)))
    for bmask in order:
        if bmask >= (1 << k_lin):
            continue
        extra = [(forms[i], (bmask >> i) & 1) for i in range(k_lin)]
        bres = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            extra, tbl, max_xl_rounds=5, verify_subst=False
        )
        if not bres["closed_unsat"]:
            target_br = bres
            target_bmask = bmask
            break

    lin_pivs = target_br["_lin_pivs"]
    active_vars = sorted(i for i in range(n) if i not in lin_pivs)
    N = len(active_vars)
    old_to_new = {old_i: new_i for new_i, old_i in enumerate(active_vars)}
    print(f"[{cell_name}] PART B: Branch {target_bmask:0{k_lin}b} (N={N}, q={target_br['n_quad_surviving']}, "
          f"c={target_br['n_genuine_cubics']}) -> Schur-D4 with CG16 + CG15 + 8xCG14!", flush=True)

    # Build affine map of each of the 116 orbits in the N branch vars
    old_subst_N = []
    for old_i in range(n):
        if old_i in old_to_new:
            old_subst_N.append((1 << old_to_new[old_i], 0))
        else:
            pv, pr = lin_pivs[old_i]
            rem = pv ^ (1 << old_i)
            mn = 0
            while rem:
                lb = rem & -rem
                mn |= (1 << old_to_new[lb.bit_length() - 1])
                rem ^= lb
            old_subst_N.append((mn, pr))

    orb_n = (ctypes.c_int * 116)()
    orb_vars = (ctypes.c_int * (116 * 112))()
    orb_c = (ctypes.c_int * 116)()
    orb_mask_N_py = []
    orb_c_py = []
    for j in range(116):
        mn = 0
        mc = (origin111 >> j) & 1
        for old_i in range(n):
            if (cb111[old_i] >> j) & 1:
                sm, sc = old_subst_N[old_i]
                mn ^= sm
                mc ^= sc
        orb_mask_N_py.append(mn)
        orb_c_py.append(mc)
        orb_c[j] = mc
        cnt = 0
        for ni in range(N):
            if (mn >> ni) & 1:
                orb_vars[j * 112 + cnt] = ni
                cnt += 1
        orb_n[j] = cnt

    # Initialize C Schur-D4 engine (arena = 1.5B u32 = 6.0 GB)
    rc = lib11c.s11_init(N, 24000, ctypes.c_size_t(1_500_000_000))
    assert rc == 0, "s11_init failed!"

    # ZERO-TRUST VERIFY CG16, CG15, and CG14[0] on 6 random points x in F_2^N!
    rng = random.Random(20261118)
    test_xs = [[rng.randint(0, 1) for _ in range(N)] for _ in range(6)]
    test_c116 = []
    for xv in test_xs:
        xmask = sum((1 << i) for i, b in enumerate(xv) if b)
        c116 = 0
        for j in range(116):
            val = orb_c_py[j] ^ ((orb_mask_N_py[j] & xmask).bit_count() & 1)
            if val:
                c116 |= (1 << j)
        test_c116.append(c116)

    max_out = 5_000_000
    gbuf = (ctypes.c_uint32 * max_out)()
    zt_mismatches = {}
    for label, fn_call, I_m in [
        ("CG16", lambda: lib11c.s11_build_cg16(mon_to_orb_arr, orb_n, orb_vars, orb_c, 0, gbuf, max_out), 0xFFFF),
        ("CG15", lambda: lib11c.s11_build_cg15(mon_to_orb_arr, orb_n, orb_vars, orb_c, 0, gbuf, max_out), 0x7FFF),
        ("CG14_0", lambda: lib11c.s11_build_cg14(reps14[0], mon_to_orb_arr, orb_n, orb_vars, orb_c, 0, gbuf, max_out), reps14[0]),
    ]:
        cnt = fn_call()
        assert cnt <= max_out, f"{label} cnt={cnt} > max_out"
        mm = 0
        for idx_p, xv in enumerate(test_xs):
            xarr = (ctypes.c_uint8 * N)(*xv)
            got = lib11c.s11_eval_gcols_at_x(gbuf, cnt, xarr)
            exp = direct_lambda_I_div8_mod2(I_m, test_c116[idx_p], orbits)
            if got != exp:
                mm += 1
        zt_mismatches[label] = {"terms": cnt, "mismatches_of_6": mm}
        print(f"  [{cell_name}] Zero-trust {label}: terms={cnt}, mismatches={mm}/6", flush=True)
        assert mm == 0, f"ZERO-TRUST FAILED ON {label}!"
    del gbuf

    # Load branch quads + cubics into C_low
    quad_packed_list = []
    for qr in target_br["_quad_ids"]:
        ps = s9.row_to_pset(target_br["_buf"], qr, tbl)
        pms = s11.pset_to_packed_reindexed(ps, old_to_new)
        quad_packed_list.append(pms)
        arr = (ctypes.c_uint32 * len(pms))(*pms)
        lib11c.s11_insert_le3_packed(arr, len(pms), 0)
        for v in range(N):
            ps_v = set()
            for m in ps:
                nm = m | (1 << active_vars[v])
                if nm in ps_v: ps_v.remove(nm)
                else: ps_v.add(nm)
            pms_v = s11.pset_to_packed_reindexed(ps_v, old_to_new)
            arr_v = (ctypes.c_uint32 * len(pms_v))(*pms_v)
            lib11c.s11_insert_le3_packed(arr_v, len(pms_v), 0)

    for cr in target_br["_cub_ids"]:
        ps = s9.row_to_pset(target_br["_buf"], cr, tbl)
        pms = s11.pset_to_packed_reindexed(ps, old_to_new)
        arr = (ctypes.c_uint32 * len(pms))(*pms)
        lib11c.s11_insert_le3_packed(arr, len(pms), 0)

    # Inject CG16, CG15, and ALL 8 CG14 into A_44!
    t_cg = time.perf_counter()
    r16 = lib11c.s11_build_cg16(mon_to_orb_arr, orb_n, orb_vars, orb_c, 1, None, 0)
    r15 = lib11c.s11_build_cg15(mon_to_orb_arr, orb_n, orb_vars, orb_c, 1, None, 0)
    r14s = [lib11c.s11_build_cg14(im, mon_to_orb_arr, orb_n, orb_vars, orb_c, 1, None, 0) for im in reps14]
    print(f"[{cell_name}] Injected CG16({r16}), CG15({r15}), 8xCG14({r14s}) in {time.perf_counter()-t_cg:.2f}s", flush=True)

    # Multiply branch quads (if any, e.g. B0_00 branch 001!) by all pairs z_a * z_b
    deadline = time.monotonic() + max(15.0, budget_sec - (time.perf_counter() - t0))
    for pms in quad_packed_list:
        arr = (ctypes.c_uint32 * len(pms))(*pms)
        if lib11c.s11_mul_quad_by_all_pairs(arr, len(pms), ctypes.c_double(deadline)):
            break

    # Substitute branch linear pivots into sparse CG12 rows and multiply by all N vars!
    cg12_sub = (ctypes.c_uint64 * (len(reps12) * n_cw))()
    ctypes.memmove(cg12_sub, cg_buf, len(reps12) * n_cw * 8)
    mask64 = (1 << 64) - 1
    for p, (pv, pr) in lin_pivs.items():
        m = pv ^ (1 << p)
        lib9.subst_one_linear_var_batch(
            cg12_sub, len(reps12), n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
            tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
            p, m & mask64, m >> 64, pr
        )

    cg12_packed = []
    for idx in range(len(reps12)):
        ps = s9.row_to_pset(cg12_sub, idx, tbl)
        if ps:
            cg12_packed.append(s11.pset_to_packed_reindexed(ps, old_to_new))
    cg12_packed.sort(key=len)

    st = (ctypes.c_uint32 * 14)()
    lib11c.s11_get_stats(st)
    cg12_done = 0
    if not st[0]:
        for idx, pms in enumerate(cg12_packed):
            if time.monotonic() >= deadline:
                break
            arr = (ctypes.c_uint32 * len(pms))(*pms)
            has1 = lib11c.s11_mul_cubic_by_all_vars(arr, len(pms), ctypes.c_double(deadline))
            cg12_done += 1
            if has1:
                break
            if (idx + 1) % 20 == 0:
                lib11c.s11_get_stats(st)
                print(f"  [{cell_name}] Branch CG12 {idx+1}/{len(cg12_packed)} ({time.perf_counter()-t0:.1f}s): "
                      f"piv4={st[1]}, mutants={list(st[6:10])}, arena_mb={st[10]}, ovf={st[13]}", flush=True)
                if st[13] > 500:
                    break

    lib11c.s11_get_stats(st)
    res = {
        "cell": cell_name,
        "b0_00_tree": tree_report,
        "branch": target_bmask,
        "N_branch": N,
        "zero_trust_deg4": zt_mismatches,
        "has_one": bool(st[0]),
        "cg12_done": cg12_done,
        "deg4_rows_processed": int(st[12]),
        "piv4_stored": int(st[1]),
        "mutants_found": {"deg0": int(st[6]), "deg1": int(st[7]), "deg2": int(st[8]), "deg3": int(st[9])},
        "arena_mb": int(st[10]),
        "arena_overflows": int(st[13]),
        "elapsed_sec": round(time.perf_counter() - t0, 3),
    }
    lib11c.s11_free()
    print(f"[{cell_name}] STEP 11C RESULT: {json.dumps(res)}", flush=True)
    return res


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    parser.add_argument("--budget", type=float, default=360.0)
    args = parser.parse_args()

    # Compile C libraries
    c_diag, so_diag = WORK_DIR / "s11c_diag.c", WORK_DIR / "libs11c_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s11c_s9.c", WORK_DIR / "libs11c_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s11c_cg.c", WORK_DIR / "libs11c_cg.so"
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

    c_11c, so_11c = WORK_DIR / "s11c_schur.c", WORK_DIR / "libs11c_schur.so"
    c_11c.write_text(C_CG14_EXTRA_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_11c), "-o", str(so_11c)], check=True)
    lib11c = ctypes.CDLL(str(so_11c))
    lib11c.s11_init.argtypes = [ctypes.c_int, ctypes.c_uint32, ctypes.c_size_t]
    lib11c.s11_init.restype = ctypes.c_int
    lib11c.s11_insert_le3_packed.argtypes = [ctypes.POINTER(ctypes.c_uint32), ctypes.c_int, ctypes.c_int]
    lib11c.s11_insert_le3_packed.restype = ctypes.c_int
    lib11c.s11_mul_cubic_by_all_vars.argtypes = [ctypes.POINTER(ctypes.c_uint32), ctypes.c_int, ctypes.c_double]
    lib11c.s11_mul_cubic_by_all_vars.restype = ctypes.c_int
    lib11c.s11_mul_quad_by_all_pairs.argtypes = [ctypes.POINTER(ctypes.c_uint32), ctypes.c_int, ctypes.c_double]
    lib11c.s11_mul_quad_by_all_pairs.restype = ctypes.c_int
    for fn in (lib11c.s11_build_cg16, lib11c.s11_build_cg15):
        fn.argtypes = [
            ctypes.POINTER(ctypes.c_int16), ctypes.POINTER(ctypes.c_int),
            ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
            ctypes.c_int, ctypes.POINTER(ctypes.c_uint32), ctypes.c_int,
        ]
        fn.restype = ctypes.c_int
    lib11c.s11_build_cg14.argtypes = [
        ctypes.c_int, ctypes.POINTER(ctypes.c_int16), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.POINTER(ctypes.c_uint32), ctypes.c_int,
    ]
    lib11c.s11_build_cg14.restype = ctypes.c_int
    lib11c.s11_eval_gcols_at_x.argtypes = [ctypes.POINTER(ctypes.c_uint32), ctypes.c_int, ctypes.POINTER(ctypes.c_uint8)]
    lib11c.s11_eval_gcols_at_x.restype = ctypes.c_int
    lib11c.s11_get_stats.argtypes = [ctypes.POINTER(ctypes.c_uint32)]

    orbits = diag_v2.build_orbits_116()
    mon_to_orb_arr = (ctypes.c_int16 * 65536)(*([-1] * 65536))
    for j, orb in enumerate(orbits):
        for m in orb:
            mon_to_orb_arr[m] = j
    reps14 = s10.subset_orbits(14)
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
        run_step11c_cell(
            cname, args.budget, lib_diag, lib9, lib_cg, lib11c, orbits,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps14, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()

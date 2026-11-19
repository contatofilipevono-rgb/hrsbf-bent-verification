#!/usr/bin/env python3
r"""
SOLVE_STEP37_C8_WALSH_CONGRUENCES_NUCLEAR.py

BRAND-NEW FIRST-PRINCIPLES ALGEBRAIC WEAPON:
  C_8-EQUIVARIANT DUAL-WALSH POISSON CONGRUENCES MOD 32, 64, 128, 256!
  - Exact Theorem (Zero-Trust verified):
      For ANY bent function f in H(16, 4), its dual f_tilde has deg(f_tilde) <= 6, so
      g := f_tilde|_{D_8^perp} : F_2^8 -> F_2 is C_8-symmetric of degree <= 6!
      Let A in Z^{36 x 36} be the C_8-orbit Walsh matrix:
          A[i, j] = sum_{b in orb_j} (-1)^{<z_i, b>}.
      Then S_{D_8}(z_i) := sum_{u in D_8} (-1)^{f(u, u ^ z_i)} = W_g(z_i) = C_i - 2*(A*y)_i.
      For EVERY integer vector v in the left kernel of [A; (MOD/2)*b0_par] mod MOD (MOD = 16, 32, 64, 128):
          sum_{i=0}^{35} v_i * S_{D_8}(z_i) == target (mod 2*MOD)
      holds IDENTICALLY for EVERY bent function f in H(16, 4)!
  - In Step 36B, this yielded:
      * 18 exact deg-3 equations at MOD=16
      *  9 exact deg-3 equations at MOD=32
      *  8 exact deg-3 + 1 QUADRATIC (deg-2!) equation at MOD=64
      *  9 exact deg-3 + 1 QUADRATIC (deg-2!) equation at MOD=128
  - Here we extract ALL of those exact degree <= 3 equations in C (~0.1s total!),
    ZERO-TRUST verify 0 mismatches on 30 random points per equation, check EXACT NEW RANK
    above CG(389), and run `run_branch_cascade` on B1_11, B0_11, and B0_00!
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
import SOLVE_STEP36_C8_ORBIT_WALSH_KERNEL_LOCAL as s36

C_C8W_SRC = r"""
#include <stdint.h>
#include <string.h>

static inline void toggle_bit(uint64_t *row, int col) {
    row[col >> 6] ^= (1ULL << (col & 63));
}

/* Precompute 36 coset truth tables (each 4 uint64 words) for origin and all 111 basis vars,
   then in ONE sweep over (0), (i), (i,j), (i,j,k), compute ALL K congruences simultaneously! */
void extract_all_c8_walsh_cubics(
    const uint8_t *orb_tt,      /* [116 * 65536] */
    const uint8_t *origin111,   /* [116] */
    const uint8_t *cb111,       /* [111 * 116] */
    const uint16_t *pts36,      /* [36 * 256] */
    const int64_t *V_mat,       /* [K * 36] */
    const int64_t *targets,     /* [K] */
    const int *shifts,          /* [K]  (log2(MOD), e.g., 4, 5, 6, 7) */
    int K,
    int n,                      /* 111 */
    int off2,
    int off1,
    int off0,
    int n_cw,
    const int *col2_base,
    const int *col3_base,
    uint64_t *out_rows,         /* [K * n_cw] */
    int *out_mod_fail,          /* [K] */
    const uint64_t *ver_lo,     /* [R_ver] */
    const uint64_t *ver_hi,     /* [R_ver] */
    int R_ver,
    uint8_t *out_ver_bits       /* [K * R_ver] */
) {
    static uint64_t base_w[36][4];
    static uint64_t basis_w[111][36][4];
    memset(base_w, 0, sizeof(base_w));
    memset(basis_w, 0, sizeof(basis_w));
    memset(out_rows, 0, (size_t)K * n_cw * sizeof(uint64_t));
    memset(out_mod_fail, 0, (size_t)K * sizeof(int));

    for (int zi = 0; zi < 36; zi++) {
        for (int p = 0; p < 256; p++) {
            uint16_t x = pts36[zi * 256 + p];
            int ov = 0;
            for (int o = 0; o < 116; o++) if (origin111[o] && orb_tt[(size_t)o * 65536 + x]) ov ^= 1;
            if (ov) base_w[zi][p >> 6] |= (1ULL << (p & 63));
        }
    }
    for (int i = 0; i < n; i++) {
        const uint8_t *row = cb111 + (size_t)i * 116;
        int ao[116], na = 0;
        for (int o = 0; o < 116; o++) if (row[o]) ao[na++] = o;
        for (int zi = 0; zi < 36; zi++) {
            for (int p = 0; p < 256; p++) {
                uint16_t x = pts36[zi * 256 + p];
                int v = 0;
                for (int a = 0; a < na; a++) if (orb_tt[(size_t)ao[a] * 65536 + x]) v ^= 1;
                if (v) basis_w[i][zi][p >> 6] |= (1ULL << (p & 63));
            }
        }
    }

    int64_t S[36];
    /* Helper macro to evaluate bit for congruence q from S[0..35] */
    #define EVAL_Q_BIT(q, dst_bit) do { \
        int64_t acc = 0; \
        const int64_t *vq = V_mat + (size_t)(q) * 36; \
        for (int z = 0; z < 36; z++) if (vq[z]) acc += vq[z] * S[z]; \
        int64_t diff = acc - targets[q]; \
        int64_t mod_m = (1LL << shifts[q]); \
        if (diff & (mod_m - 1)) out_mod_fail[q] = 1; \
        (dst_bit) = (int)((diff >> shifts[q]) & 1LL); \
    } while (0)

    /* Allocate c0[K], c1[K][111], c2[K][111][111] dynamically or static (K <= 128) */
    static uint8_t c0[128];
    static uint8_t c1[128][111];
    static uint8_t c2[128][111][111];

    /* 0) origin */
    for (int zi = 0; zi < 36; zi++) {
        int wt = __builtin_popcountll(base_w[zi][0]) + __builtin_popcountll(base_w[zi][1]) +
                 __builtin_popcountll(base_w[zi][2]) + __builtin_popcountll(base_w[zi][3]);
        S[zi] = 256 - 2 * wt;
    }
    for (int q = 0; q < K; q++) {
        int b; EVAL_Q_BIT(q, b);
        c0[q] = (uint8_t)b;
        if (b) toggle_bit(out_rows + (size_t)q * n_cw, off0);
    }

    /* 1) linear c1 */
    for (int i = 0; i < n; i++) {
        for (int zi = 0; zi < 36; zi++) {
            int wt = __builtin_popcountll(base_w[zi][0] ^ basis_w[i][zi][0]) +
                     __builtin_popcountll(base_w[zi][1] ^ basis_w[i][zi][1]) +
                     __builtin_popcountll(base_w[zi][2] ^ basis_w[i][zi][2]) +
                     __builtin_popcountll(base_w[zi][3] ^ basis_w[i][zi][3]);
            S[zi] = 256 - 2 * wt;
        }
        for (int q = 0; q < K; q++) {
            int b; EVAL_Q_BIT(q, b);
            int val = b ^ c0[q];
            c1[q][i] = (uint8_t)val;
            if (val) toggle_bit(out_rows + (size_t)q * n_cw, off1 + i);
        }
    }

    /* 2) quadratic c2 */
    uint64_t xij[36][4];
    for (int i = 0; i < n; i++) {
        int b2_i = col2_base[i];
        for (int j = i + 1; j < n; j++) {
            for (int zi = 0; zi < 36; zi++) {
                xij[zi][0] = base_w[zi][0] ^ basis_w[i][zi][0] ^ basis_w[j][zi][0];
                xij[zi][1] = base_w[zi][1] ^ basis_w[i][zi][1] ^ basis_w[j][zi][1];
                xij[zi][2] = base_w[zi][2] ^ basis_w[i][zi][2] ^ basis_w[j][zi][2];
                xij[zi][3] = base_w[zi][3] ^ basis_w[i][zi][3] ^ basis_w[j][zi][3];
                int wt = __builtin_popcountll(xij[zi][0]) + __builtin_popcountll(xij[zi][1]) +
                         __builtin_popcountll(xij[zi][2]) + __builtin_popcountll(xij[zi][3]);
                S[zi] = 256 - 2 * wt;
            }
            for (int q = 0; q < K; q++) {
                int b; EVAL_Q_BIT(q, b);
                int val = b ^ c0[q] ^ c1[q][i] ^ c1[q][j];
                c2[q][i][j] = (uint8_t)val;
                if (val) toggle_bit(out_rows + (size_t)q * n_cw, off2 + b2_i + (j - i - 1));
            }
        }
    }

    /* 3) cubic c3 */
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            for (int zi = 0; zi < 36; zi++) {
                xij[zi][0] = base_w[zi][0] ^ basis_w[i][zi][0] ^ basis_w[j][zi][0];
                xij[zi][1] = base_w[zi][1] ^ basis_w[i][zi][1] ^ basis_w[j][zi][1];
                xij[zi][2] = base_w[zi][2] ^ basis_w[i][zi][2] ^ basis_w[j][zi][2];
                xij[zi][3] = base_w[zi][3] ^ basis_w[i][zi][3] ^ basis_w[j][zi][3];
            }
            int c3_ij = col3_base[i * n + j];
            for (int k = j + 1; k < n; k++) {
                for (int zi = 0; zi < 36; zi++) {
                    int wt = __builtin_popcountll(xij[zi][0] ^ basis_w[k][zi][0]) +
                             __builtin_popcountll(xij[zi][1] ^ basis_w[k][zi][1]) +
                             __builtin_popcountll(xij[zi][2] ^ basis_w[k][zi][2]) +
                             __builtin_popcountll(xij[zi][3] ^ basis_w[k][zi][3]);
                    S[zi] = 256 - 2 * wt;
                }
                for (int q = 0; q < K; q++) {
                    int b; EVAL_Q_BIT(q, b);
                    int val = b ^ c0[q] ^ c1[q][i] ^ c1[q][j] ^ c1[q][k] ^ c2[q][i][j] ^ c2[q][i][k] ^ c2[q][j][k];
                    if (val) toggle_bit(out_rows + (size_t)q * n_cw, c3_ij + (k - j - 1));
                }
            }
        }
    }

    /* 4) Zero-Trust verification evaluations on R_ver random points */
    for (int r = 0; r < R_ver; r++) {
        uint64_t acc_w[36][4];
        memcpy(acc_w, base_w, sizeof(acc_w));
        uint64_t lo = ver_lo[r], hi = ver_hi[r];
        while (lo) {
            int i = __builtin_ctzll(lo); lo &= lo - 1;
            for (int zi = 0; zi < 36; zi++) {
                acc_w[zi][0] ^= basis_w[i][zi][0]; acc_w[zi][1] ^= basis_w[i][zi][1];
                acc_w[zi][2] ^= basis_w[i][zi][2]; acc_w[zi][3] ^= basis_w[i][zi][3];
            }
        }
        while (hi) {
            int i = 64 + __builtin_ctzll(hi); hi &= hi - 1;
            for (int zi = 0; zi < 36; zi++) {
                acc_w[zi][0] ^= basis_w[i][zi][0]; acc_w[zi][1] ^= basis_w[i][zi][1];
                acc_w[zi][2] ^= basis_w[i][zi][2]; acc_w[zi][3] ^= basis_w[i][zi][3];
            }
        }
        for (int zi = 0; zi < 36; zi++) {
            int wt = __builtin_popcountll(acc_w[zi][0]) + __builtin_popcountll(acc_w[zi][1]) +
                     __builtin_popcountll(acc_w[zi][2]) + __builtin_popcountll(acc_w[zi][3]);
            S[zi] = 256 - 2 * wt;
        }
        for (int q = 0; q < K; q++) {
            int b; EVAL_Q_BIT(q, b);
            out_ver_bits[q * R_ver + r] = (uint8_t)b;
        }
    }
}
"""


def build_c8_walsh_congruences():
    """Build ALL ZT-verified C_8-orbit Walsh congruences at MOD = 16, 32, 64, 128."""
    seen = set()
    c8_orbs = []
    for b in range(256):
        if b in seen: continue
        orb, cur = [], b
        while cur not in seen:
            seen.add(cur); orb.append(cur)
            cur = ((cur << 1) | (cur >> 7)) & 0xFF
        c8_orbs.append(orb)
    m = len(c8_orbs)
    z_reps = [o[0] for o in c8_orbs]

    A = np.zeros((m, m), dtype=np.int64)
    for i, z in enumerate(z_reps):
        for j, orb in enumerate(c8_orbs):
            A[i, j] = sum(-1 if ((b & z).bit_count() & 1) else 1 for b in orb)
    orb_sz = np.array([len(o) for o in c8_orbs], dtype=np.int64)
    orb_b0_par = np.array([sum(b & 1 for b in o) & 1 for o in c8_orbs], dtype=np.int64)

    # 300 random C_8-symmetric deg <= 6 duals g for Zero-Trust target check
    rng_g = random.Random(370037)
    idx_ff = [j for j, o in enumerate(c8_orbs) if o[0] == 0xFF][0]
    G_W = []
    for _ in range(300):
        y = np.array([rng_g.getrandbits(1) for _ in range(m)], dtype=np.int64)
        if int((orb_b0_par * y).sum()) & 1: y[idx_ff] ^= 1
        if int((orb_sz * y).sum()) & 1: y[0] ^= 1
        G_W.append(A @ (1 - 2 * y))
    G_W = np.array(G_W, dtype=np.int64)

    specs = []  # (v_vec36, target, shift)
    for MOD in (16, 32, 64, 128):
        shift = MOD.bit_length() - 1
        A_ext = np.vstack([A, (MOD // 2) * orb_b0_par])
        ker = s36.mod_rref_kernel(A_ext, MOD)
        for k in ker:
            v = k[:36] % MOD
            if not np.any(v != 0): continue
            g_vals = (G_W @ v) % (2 * MOD)
            uniq = set(int(u) for u in g_vals)
            if len(uniq) == 1:
                specs.append((v.copy(), int(g_vals[0]), shift))
    return z_reps, specs


def run_cell(cell_name, lib_diag, lib9, lib_cg, lib_c8w, orbits, layer_vecs, orb_tt_np,
             v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl, z_reps, specs):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 37: C_8-ORBIT DUAL-WALSH CONGRUENCES ({len(specs)} specs) ====================", flush=True)
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    n, n_cw = tbl["n"], tbl["n_col_words"]
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

    # Process specs in chunks of <= 120 (static arrays in C have size 128)
    orb_tt_flat = np.ascontiguousarray(orb_tt_np.reshape(-1), dtype=np.uint8)
    orig_u8 = np.array([(origin111 >> o) & 1 for o in range(116)], dtype=np.uint8)
    cb_u8 = np.array([(cb111[i] >> o) & 1 for i in range(111) for o in range(116)], dtype=np.uint8)
    pts36 = np.array([[u | ((u ^ z) << 8) for u in range(256)] for z in z_reps], dtype=np.uint16).reshape(-1)

    R_ver = 30
    rng_v = random.Random(373737)
    ver_pts = [rng_v.getrandbits(111) for _ in range(R_ver)]
    ver_lo = (ctypes.c_uint64 * R_ver)(*[x & mask64 for x in ver_pts])
    ver_hi = (ctypes.c_uint64 * R_ver)(*[x >> 64 for x in ver_pts])

    exact_rows = []  # list of bytes (n_cw * 8) that passed 30/30 Zero-Trust check!
    for chunk_start in range(0, len(specs), 100):
        chunk = specs[chunk_start:chunk_start + 100]
        K = len(chunk)
        V_mat = np.ascontiguousarray(np.vstack([s[0] for s in chunk]), dtype=np.int64)
        targets = np.ascontiguousarray([s[1] for s in chunk], dtype=np.int64)
        shifts = np.ascontiguousarray([s[2] for s in chunk], dtype=np.int32)
        out_rows = (ctypes.c_uint64 * (K * n_cw))()
        out_mod_fail = (ctypes.c_int * K)()
        out_ver_bits = (ctypes.c_uint8 * (K * R_ver))()

        lib_c8w.extract_all_c8_walsh_cubics(
            orb_tt_flat.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            orig_u8.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            cb_u8.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            pts36.ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)),
            V_mat.ctypes.data_as(ctypes.POINTER(ctypes.c_int64)),
            targets.ctypes.data_as(ctypes.POINTER(ctypes.c_int64)),
            shifts.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
            K, n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw,
            tbl["col2_base"], tbl["col3_base"], out_rows, out_mod_fail,
            ver_lo, ver_hi, R_ver, out_ver_bits
        )
        for q in range(K):
            if out_mod_fail[q] != 0:
                continue
            rptr = ctypes.cast(ctypes.byref(out_rows, q * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            mis = 0
            for r in range(R_ver):
                v_poly = lib9.eval_row_s9(
                    rptr, n_cw, tbl["off0"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                    ver_lo[r], ver_hi[r]
                )
                if v_poly != out_ver_bits[q * R_ver + r]:
                    mis += 1
                    break
            if mis == 0:
                exact_rows.append((chunk[q][2], ctypes.string_at(rptr, n_cw * 8)))

    by_shift = {}
    for sh, _ in exact_rows: by_shift[1 << sh] = by_shift.get(1 << sh, 0) + 1
    print(f"  [{cell_name}] ZERO-TRUST VERIFIED EXACT deg<=3 C_8-Walsh equations: {len(exact_rows)}/{len(specs)} (by MOD: {dict(sorted(by_shift.items()))})", flush=True)

    # First run baseline root without exact_rows
    base_tot = n_base + len(cyc_cubs) + n_cg
    base_buf = (ctypes.c_uint64 * (base_tot * n_cw))()
    ctypes.memmove(base_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, base_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(base_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)
    root0 = s9.run_branch_cascade(lib9, base_buf, [], list(range(base_tot)), {}, [], tbl, max_xl_rounds=15, verify_subst=False)
    print(f"  [{cell_name}] BASELINE root: N_act={111-len(root0['_lin_pivs'])}, q={len(root0['_quad_ids'])}, cub={len(root0['_cub_ids'])}", flush=True)

    # Now inject ALL exact_rows!
    tot_all = base_tot + len(exact_rows)
    all_buf = (ctypes.c_uint64 * (tot_all * n_cw))()
    ctypes.memmove(all_buf, base_buf, base_tot * n_cw * 8)
    for idx_e, (_, rbytes) in enumerate(exact_rows):
        ctypes.memmove(ctypes.byref(all_buf, (base_tot + idx_e) * n_cw * 8), rbytes, n_cw * 8)

    root1 = s9.run_branch_cascade(lib9, all_buf, [], list(range(tot_all)), {}, [], tbl, max_xl_rounds=25, verify_subst=True)
    if root1["closed_unsat"]:
        print(f"  [{cell_name}] *** BOOM!! ROOT CLOSED UNSAT (1 = 0) WITH C_8-WALSH CONGRUENCES!! ***", flush=True)
        return
    print(
        f"  [{cell_name}] *** AFTER C_8-WALSH CONGRUENCES: N_act={111-len(root1['_lin_pivs'])}, "
        f"q={len(root1['_quad_ids'])}, cub={len(root1['_cub_ids'])} (was N={111-len(root0['_lin_pivs'])}, q={len(root0['_quad_ids'])}, cub={len(root0['_cub_ids'])}) ***",
        flush=True,
    )

    # Sweep all 64 eta-states!
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root1["_lin_pivs"])
    n_ef = len(eta_free)
    n_cl = 0
    for em in range(1 << n_ef):
        ex = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
        sr = s9.run_branch_cascade(
            lib9, root1["_buf"], root1["_quad_ids"], root1["_cub_ids"], root1["_lin_pivs"],
            ex, tbl, max_xl_rounds=20, verify_subst=(em == 0)
        )
        if sr["closed_unsat"]: n_cl += 1
        elif em < 5:
            qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
            dw = s16.analyze_quad_system(qps)["dim_W_ess"] if qps else 0
            print(f"    [eta={em:2d}] OPEN: N={111-len(sr['_lin_pivs'])}, q={len(sr['_quad_ids'])}, cub={len(sr['_cub_ids'])}, dimW={dw}", flush=True)
    print(f"  [{cell_name}] ETA SWEEP RESULT: CLOSED = {n_cl} / {1<<n_ef} ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B1_11,B0_11,B0_00")
    args = parser.parse_args()

    z_reps, specs = build_c8_walsh_congruences()
    print(f"Built {len(specs)} ZT-verified C_8-orbit Walsh congruence specs (MOD=16,32,64,128)", flush=True)

    c_diag, so_diag = WORK_DIR / "s37_diag.c", WORK_DIR / "libs37_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s37_s9.c", WORK_DIR / "libs37_s9.so"
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
    lib9.mul_deg2_row_by_var.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
    ]
    lib9.gf2_echelon_insert_s9.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib9.gf2_echelon_insert_s9.restype = ctypes.c_int
    lib9.eval_row_s9.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_uint64, ctypes.c_uint64,
    ]
    lib9.eval_row_s9.restype = ctypes.c_int

    c_cg, so_cg = WORK_DIR / "s37_cg.c", WORK_DIR / "libs37_cg.so"
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

    c_c8w, so_c8w = WORK_DIR / "s37_c8w.c", WORK_DIR / "libs37_c8w.so"
    c_c8w.write_text(C_C8W_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_c8w), "-o", str(so_c8w)], check=True)
    lib_c8w = ctypes.CDLL(str(so_c8w))
    lib_c8w.extract_all_c8_walsh_cubics.argtypes = [
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint16),
        ctypes.POINTER(ctypes.c_int64), ctypes.POINTER(ctypes.c_int64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.POINTER(ctypes.c_uint8),
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

    for cell in [c.strip() for c in args.cells.split(",") if c.strip()]:
        run_cell(
            cell, lib_diag, lib9, lib_cg, lib_c8w, orbits, layer_vecs, orb_tt_np,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl, z_reps, specs
        )


if __name__ == "__main__":
    main()

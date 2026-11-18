#!/usr/bin/env python3
"""
Task b06_simultaneous_linearization:
Exact Simultaneous Symplectic Core & GL(N, F_2) Linearization of the Quadratic System
for B1_00, B1_11 (223 quads in 109 vars), B0_11 and B0_00 (113 quads in 108 vars).

What this script proves & computes:
  1. Pure 111-variable extraction (c115=0, L=c99; ZERO external assumptions) with
     corrected diag_div8_parity, Level-1 diag4 quadratics, Dual Fiber equations,
     rot^4 dim-11/12 mod-16/32 equations, and full Macaulay XL closure.
     -> Closes B1_00 immediately via pure algebraic 1=0 (C_0xf parity vs K=c57=0).
  2. Eliminates all discovered linear pivots to obtain the exact N-variable system
     q_1(x), ..., q_m(x) and their N x N alternating matrices B_1, ..., B_m over F_2.
  3. Runs the exact C11/OpenMP engine `libb06_gl.so` to find G = A^{-1} in GL(N, F_2):
     - Stage A: Global Simultaneous Symplectic Radical R_0 = cap_r ker(B_r).
     - Stage B: Maximum Common Totally Isotropic Subspace W_iso in GL(N, F_2)
                (giving Simultaneous GL-Vertex-Cover of size s_vc = N - dim(W_iso)
                where ALL m quadratics become 100% LINEAR simultaneously!).
     - Stage C: Bit-sliced GL(N, F_2) transvection optimizer minimizing joint edge
                support |cup_r supp(G^T B_r G)| and sum_r |supp(G^T B_r G)|.
     - Stage D: Exact backward subspace ordering minimizing p_T(s) = rank([B_1^TT .. B_m^TT])
                for EVERY branching size s = 0 .. N, side-by-side against coordinate
                permutations S_N!
  4. Fast OpenMP C Linearized-Cube Solver for overdetermined cells (especially B1_11!)
     + lightweight SAT/FWHT closer (ZERO slow CNF CardEnc counters!).

Usage:
  python3 SOLVE_B06_GL_SIMULTANEOUS_LIN.py [ALL | B1_00 | B1_11 | B0_11 | B0_00] [cube_s]
"""
import ctypes
import json
import os
import random
import subprocess
import sys
import time
from pathlib import Path

from AUDIT_ALL_CELLS_111 import (
    C_SRC as C_SRC_AUDIT,
    I1, I2, I3, I4, J1, J2, J3, J4,
    K_INDICES, L_INDICES, R_INDICES,
    all_v6_orbits, build_orbits_116, build_pure_111_basis,
    decode_row_to_pset, interleave16, rot8, rot16,
)

C_SRC_B06_GL = r"""
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#ifdef _OPENMP
#include <omp.h>
#endif

#define MAXN 112
#define MAXW 4   // Up to 256 quadratic equations bit-sliced! (223 in B1_11 fits in 4 uint64_t!)

typedef struct {
    uint64_t w[MAXW];
} sig256_t;

static inline int sig_nonzero(const sig256_t *s) {
    return (s->w[0] | s->w[1] | s->w[2] | s->w[3]) != 0ULL;
}

static inline int sig_pop(const sig256_t *s) {
    return __builtin_popcountll(s->w[0]) + __builtin_popcountll(s->w[1]) +
           __builtin_popcountll(s->w[2]) + __builtin_popcountll(s->w[3]);
}

static inline void sig_xor(sig256_t *dst, const sig256_t *a, const sig256_t *b) {
    dst->w[0] = a->w[0] ^ b->w[0];
    dst->w[1] = a->w[1] ^ b->w[1];
    dst->w[2] = a->w[2] ^ b->w[2];
    dst->w[3] = a->w[3] ^ b->w[3];
}

// Compute union-edge count and total-monomial count across all m matrices for current W[N][N]
static void eval_support_metrics(
    const sig256_t W[MAXN][MAXN],
    int N,
    int *out_union_edges,
    int *out_total_monoms
) {
    int u_cnt = 0, t_cnt = 0;
    for (int i = 0; i < N; i++) {
        for (int j = i + 1; j < N; j++) {
            if (sig_nonzero(&W[i][j])) {
                u_cnt++;
                t_cnt += sig_pop(&W[i][j]);
            }
        }
    }
    *out_union_edges = u_cnt;
    *out_total_monoms = t_cnt;
}

// Apply elementary column operation on G: col_b ^= col_a (i.e. g_b <- g_b ^ g_a).
// Simultaneously updates A = G^{-1} via row_a ^= row_b, and W[N][N] in O(N) bit-sliced ops!
static inline void apply_col_xor(
    sig256_t W[MAXN][MAXN],
    uint64_t G_cols[MAXN][2],   // column b of G as 128-bit mask
    uint64_t A_rows[MAXN][2],   // row a of A = G^{-1} as 128-bit mask
    int N,
    int a,
    int b
) {
    G_cols[b][0] ^= G_cols[a][0];
    G_cols[b][1] ^= G_cols[a][1];
    A_rows[a][0] ^= A_rows[b][0];
    A_rows[a][1] ^= A_rows[b][1];

    for (int k = 0; k < N; k++) {
        if (k == a || k == b) continue;
        sig_xor(&W[k][b], &W[k][b], &W[k][a]);
        W[b][k] = W[k][b];
    }
}

// Swap columns a and b of G (and rows a and b of A, and rows/cols a,b of W)
static inline void apply_col_swap(
    sig256_t W[MAXN][MAXN],
    uint64_t G_cols[MAXN][2],
    uint64_t A_rows[MAXN][2],
    int N,
    int a,
    int b
) {
    if (a == b) return;
    for (int w = 0; w < 2; w++) {
        uint64_t tg = G_cols[a][w]; G_cols[a][w] = G_cols[b][w]; G_cols[b][w] = tg;
        uint64_t ta = A_rows[a][w]; A_rows[a][w] = A_rows[b][w]; A_rows[b][w] = ta;
    }
    for (int k = 0; k < N; k++) {
        sig256_t tmp = W[a][k]; W[a][k] = W[b][k]; W[b][k] = tmp;
    }
    for (int k = 0; k < N; k++) {
        sig256_t tmp = W[k][a]; W[k][a] = W[k][b]; W[k][b] = tmp;
    }
}

// Compute exact GF(2) rank of the m quadratic forms restricted to T = {s, s+1, ..., N-1}.
// Notice: W[i][j] (for s <= i < j < N) is ALREADY a column of M_2^{(T)} of height m (<= 256 bits)!
// By row-rank == column-rank, rank(M_2^{(T)}) equals the GF(2) rank of the vectors
// { W[i][j] in F_2^m : s <= i < j < N }!
// THAT TAKES O(|T|^2 * 4) OPERATIONS (microseconds!) instead of m * C(|T|,2)/64!
int exact_restricted_quad_rank(
    const sig256_t W[MAXN][MAXN],
    int s,
    int N
) {
    sig256_t basis[256];
    int has_piv[256];
    memset(has_piv, 0, sizeof(has_piv));
    int rk = 0;

    for (int i = s; i < N; i++) {
        for (int j = i + 1; j < N; j++) {
            sig256_t v = W[i][j];
            if (!sig_nonzero(&v)) continue;
            for (int w = 0; w < MAXW; w++) {
                while (v.w[w] != 0ULL) {
                    int bit = __builtin_ctzll(v.w[w]);
                    int col = (w << 6) + bit;
                    if (has_piv[col]) {
                        v.w[0] ^= basis[col].w[0];
                        v.w[1] ^= basis[col].w[1];
                        v.w[2] ^= basis[col].w[2];
                        v.w[3] ^= basis[col].w[3];
                    } else {
                        basis[col] = v;
                        has_piv[col] = 1;
                        rk++;
                        goto next_pair;
                    }
                }
            }
            next_pair:;
        }
    }
    return rk;
}

// Compute rank of concatenated [B_1^{(TT)} | ... | B_m^{(TT)}] of size |T| x (m*|T|),
// which equals |T| - dim(Simultaneous Symplectic Radical of W_T).
int exact_concatenated_rank(
    const sig256_t W[MAXN][MAXN],
    int m,
    int s,
    int N
) {
    int t = N - s;
    if (t <= 0) return 0;
    // Find dim of radical { u in F_2^t : sum_{i=0}^{t-1} u_i * W[s+i][s+j] == 0 for all j=0..t-1 }
    // Each pair (j, r) gives one t-bit equation on u!
    uint64_t piv[MAXN][2];
    int has_p[MAXN];
    memset(has_p, 0, sizeof(has_p));
    int rk = 0;

    for (int j = s; j < N && rk < t; j++) {
        for (int r = 0; r < m && rk < t; r++) {
            uint64_t row[2] = {0ULL, 0ULL};
            int rw = r >> 6, rb = r & 63;
            for (int i = s; i < N; i++) {
                if ((W[i][j].w[rw] >> rb) & 1ULL) {
                    int idx = i - s;
                    row[idx >> 6] |= 1ULL << (idx & 63);
                }
            }
            for (int w = 0; w < 2; w++) {
                while (row[w] != 0ULL) {
                    int bit = __builtin_ctzll(row[w]);
                    int c = (w << 6) + bit;
                    if (has_p[c]) {
                        row[0] ^= piv[c][0];
                        row[1] ^= piv[c][1];
                    } else {
                        piv[c][0] = row[0];
                        piv[c][1] = row[1];
                        has_p[c] = 1;
                        rk++;
                        goto next_eq;
                    }
                }
            }
            next_eq:;
        }
    }
    return rk;
}

// Coordinate-permutation baseline (S_N only): greedy backward Independent-Set / min-rank ordering!
void compute_permutation_baseline_curve(
    const sig256_t W_orig[MAXN][MAXN],
    int N,
    int m,
    int *out_perm_pT,        // length N+1: p_T(s) for s = 0..N
    int *out_perm_edgesT,    // length N+1
    int *out_perm_order      // length N
) {
    sig256_t W[MAXN][MAXN];
    memcpy(W, W_orig, sizeof(W));
    int perm[MAXN];
    for (int i = 0; i < N; i++) perm[i] = i;

    // Build T from right to left: pos = N-1 down to 0!
    // At step `pos`, choose v in 0..pos that minimizes exact_restricted_quad_rank on {pos..N-1}
    // (tie-breaker: fewest new edges with {pos+1..N-1}, then lowest total degree in 0..pos).
    for (int pos = N - 1; pos >= 0; pos--) {
        int best_v = pos;
        int best_rk = 1000000, best_new_e = 1000000, best_tot_m = 1000000;

        // Current basis of span{ W[i][j] : pos+1 <= i < j < N }
        sig256_t base_b[256];
        int base_hp[256];
        memset(base_hp, 0, sizeof(base_hp));
        int base_rk = 0;
        for (int i = pos + 1; i < N; i++) {
            for (int j = i + 1; j < N; j++) {
                sig256_t v = W[i][j];
                if (!sig_nonzero(&v)) continue;
                for (int w = 0; w < MAXW; w++) {
                    while (v.w[w]) {
                        int c = (w << 6) + __builtin_ctzll(v.w[w]);
                        if (base_hp[c]) {
                            for (int q = 0; q < MAXW; q++) v.w[q] ^= base_b[c].w[q];
                        } else {
                            base_b[c] = v; base_hp[c] = 1; base_rk++; break;
                        }
                    }
                    if (v.w[w]) break;
                }
            }
        }

        for (int cand = 0; cand <= pos; cand++) {
            sig256_t tb[256];
            int thp[256];
            memcpy(tb, base_b, sizeof(tb));
            memcpy(thp, base_hp, sizeof(thp));
            int rk = base_rk, new_e = 0, tot_m = 0;

            for (int j = pos + 1; j < N; j++) {
                sig256_t v = W[cand][j];
                if (!sig_nonzero(&v)) continue;
                new_e++;
                for (int w = 0; w < MAXW; w++) {
                    while (v.w[w]) {
                        int c = (w << 6) + __builtin_ctzll(v.w[w]);
                        if (thp[c]) {
                            for (int q = 0; q < MAXW; q++) v.w[q] ^= tb[c].w[q];
                        } else {
                            tb[c] = v; thp[c] = 1; rk++; break;
                        }
                    }
                    if (v.w[w]) break;
                }
            }
            for (int k = 0; k <= pos; k++) {
                if (k != cand) tot_m += sig_pop(&W[cand][k]);
            }
            if (rk < best_rk || (rk == best_rk && (new_e < best_new_e || (new_e == best_new_e && tot_m < best_tot_m)))) {
                best_rk = rk;
                best_new_e = new_e;
                best_tot_m = tot_m;
                best_v = cand;
            }
        }
        if (best_v != pos) {
            int tp = perm[pos]; perm[pos] = perm[best_v]; perm[best_v] = tp;
            for (int k = 0; k < N; k++) { sig256_t t = W[pos][k]; W[pos][k] = W[best_v][k]; W[best_v][k] = t; }
            for (int k = 0; k < N; k++) { sig256_t t = W[k][pos]; W[k][pos] = W[k][best_v]; W[k][best_v] = t; }
        }
    }

    for (int i = 0; i < N; i++) out_perm_order[i] = perm[i];
    for (int s = 0; s <= N; s++) {
        out_perm_pT[s] = exact_restricted_quad_rank(W, s, N);
        int ue = 0;
        for (int i = s; i < N; i++)
            for (int j = i + 1; j < N; j++)
                if (sig_nonzero(&W[i][j])) ue++;
        out_perm_edgesT[s] = ue;
    }
}

// =========================================================================================
// CORE GL(N, F_2) OPTIMIZER:
//   Phase 1: Exact Simultaneous Isotropic Subspace Construction in GL(N, F_2)
//            (finds vectors w in F_2^N orthogonal to current T under ALL m forms B_r,
//            choosing at each step the vector w minimizing dim(span_r {B_r w})!).
//   Phase 2: Bit-sliced GL(N, F_2) Support & Restricted-Rank Compression Sweeps
//            (elementary transvections g_b ^= g_a across all pairs (a, b)).
//   Phase 3: Backward Optimal Subspace Ordering for p_T(s) across all s = 0..N,
//            allowing LINEAR COMBINATIONS inside the remaining prefix span(g_0..g_pos)!
// =========================================================================================
void find_optimal_gl_basis(
    const uint64_t *B_bits_in, // m * N * N bits packed as m * N * 2 uint64_t words: B_r row i in [r*N*2 + i*2 .. +1]
    int N,
    int m,
    int n_sweeps,
    uint64_t *out_G_cols,      // N * 2 uint64_t
    uint64_t *out_A_rows,      // N * 2 uint64_t
    int *out_gl_pT,            // N + 1
    int *out_gl_rhoT,          // N + 1
    int *out_gl_edgesT,        // N + 1
    int *out_metrics           // [orig_u, orig_tot, gl_u, gl_tot, global_rad_dim, max_iso_dim]
) {
    sig256_t W[MAXN][MAXN];
    memset(W, 0, sizeof(W));
    for (int r = 0; r < m; r++) {
        int rw = r >> 6, rb = r & 63;
        for (int i = 0; i < N; i++) {
            const uint64_t *brow = B_bits_in + (size_t)(r * N + i) * 2;
            for (int j = 0; j < N; j++) {
                if ((brow[j >> 6] >> (j & 63)) & 1ULL) {
                    W[i][j].w[rw] |= 1ULL << rb;
                }
            }
        }
    }

    uint64_t G_cols[MAXN][2], A_rows[MAXN][2];
    memset(G_cols, 0, sizeof(G_cols));
    memset(A_rows, 0, sizeof(A_rows));
    for (int i = 0; i < N; i++) {
        G_cols[i][i >> 6] = 1ULL << (i & 63);
        A_rows[i][i >> 6] = 1ULL << (i & 63);
    }

    int orig_u = 0, orig_tot = 0;
    eval_support_metrics(W, N, &orig_u, &orig_tot);
    int global_rad_dim = N - exact_concatenated_rank(W, m, 0, N);

    // --- STAGE 1: Exact Simultaneous Totally Isotropic Subspace in GL(N, F_2)! ---
    // Place basis vectors of W_iso at the END of G (positions N-1, N-2, ..., N - iso_dim)!
    // At step pos = N-1 down to 0: find all vectors u in F_2^{pos+1} (combinations of g_0..g_pos)
    // such that for ALL j in {pos+1 .. N-1} and ALL r in {0 .. m-1}:
    //    (sum_{i=0}^{pos} u_i * W[i][j]) == 0!
    // Notice this is an EXACT homogeneous linear system on u in F_2^{pos+1}!
    int iso_dim = 0;
    for (int pos = N - 1; pos >= 0; pos--) {
        int dim_rem = pos + 1;
        uint64_t eq_piv[MAXN][2];
        int has_ep[MAXN];
        memset(has_ep, 0, sizeof(has_ep));
        int eq_rk = 0;

        for (int j = pos + 1; j < N && eq_rk < dim_rem; j++) {
            for (int r = 0; r < m && eq_rk < dim_rem; r++) {
                int rw = r >> 6, rb = r & 63;
                uint64_t row[2] = {0ULL, 0ULL};
                for (int i = 0; i <= pos; i++) {
                    if ((W[i][j].w[rw] >> rb) & 1ULL) {
                        row[i >> 6] |= 1ULL << (i & 63);
                    }
                }
                for (int w = 0; w < 2; w++) {
                    while (row[w]) {
                        int c = (w << 6) + __builtin_ctzll(row[w]);
                        if (has_ep[c]) {
                            row[0] ^= eq_piv[c][0];
                            row[1] ^= eq_piv[c][1];
                        } else {
                            eq_piv[c][0] = row[0];
                            eq_piv[c][1] = row[1];
                            has_ep[c] = 1;
                            eq_rk++;
                            break;
                        }
                    }
                    if (row[w]) break;
                }
            }
        }

        if (eq_rk == dim_rem) {
            // Nullspace is {0}: NO nonzero vector in span(g_0..g_pos) is orthogonal to ALL of W_iso!
            break;
        }

        // Put eq_piv in full RREF to extract nullspace basis vectors!
        for (int c = dim_rem - 1; c >= 0; c--) {
            if (!has_ep[c]) continue;
            for (int c2 = 0; c2 < c; c2++) {
                if (has_ep[c2] && ((eq_piv[c2][c >> 6] >> (c & 63)) & 1ULL)) {
                    eq_piv[c2][0] ^= eq_piv[c][0];
                    eq_piv[c2][1] ^= eq_piv[c][1];
                }
            }
        }

        uint64_t null_basis[MAXN][2];
        int n_null = 0;
        for (int f = 0; f < dim_rem; f++) {
            if (has_ep[f]) continue;
            uint64_t v[2] = {0ULL, 0ULL};
            v[f >> 6] |= 1ULL << (f & 63);
            for (int p = 0; p < dim_rem; p++) {
                if (has_ep[p] && ((eq_piv[p][f >> 6] >> (f & 63)) & 1ULL)) {
                    v[p >> 6] |= 1ULL << (p & 63);
                }
            }
            null_basis[n_null][0] = v[0];
            null_basis[n_null][1] = v[1];
            n_null++;
        }

        // Among null_basis vectors (and pairwise XORs of up to 32 candidates), pick u != 0
        // that MINIMIZES the number of new constraints it imposes on 0..pos (i.e. rank of r -> sum_i u_i W[i][k])!
        uint64_t best_u[2] = {null_basis[0][0], null_basis[0][1]};
        int best_cost = 100000000;
        int total_cands = n_null + ((n_null > 1) ? ((n_null < 24 ? n_null * (n_null - 1) / 2 : 120)) : 0);
        int c_idx = 0;
        for (int a_i = 0; a_i < n_null; a_i++) {
            for (int b_i = a_i; b_i < n_null && c_idx < total_cands; b_i++, c_idx++) {
                uint64_t u[2];
                if (a_i == b_i) {
                    u[0] = null_basis[a_i][0]; u[1] = null_basis[a_i][1];
                } else {
                    u[0] = null_basis[a_i][0] ^ null_basis[b_i][0];
                    u[1] = null_basis[a_i][1] ^ null_basis[b_i][1];
                }
                // Cost = total popcount of (sum_{i=0}^{pos} u_i W[i][k]) across k = 0..pos
                int cost = 0;
                for (int k = 0; k <= pos; k++) {
                    sig256_t acc = {{0, 0, 0, 0}};
                    for (int w = 0; w < 2; w++) {
                        uint64_t msk = u[w];
                        while (msk) {
                            int bit = __builtin_ctzll(msk);
                            int i = (w << 6) + bit;
                            sig_xor(&acc, &acc, &W[i][k]);
                            msk &= msk - 1;
                        }
                    }
                    if (sig_nonzero(&acc)) cost += 1000 + sig_pop(&acc);
                }
                if (cost < best_cost) {
                    best_cost = cost;
                    best_u[0] = u[0];
                    best_u[1] = u[1];
                }
            }
        }

        // Realize best_u at column `pos` via elementary GL operations inside 0..pos!
        int piv_i = (best_u[0] != 0ULL) ? __builtin_ctzll(best_u[0]) : (64 + __builtin_ctzll(best_u[1]));
        if (piv_i != pos) {
            apply_col_swap(W, G_cols, A_rows, N, piv_i, pos);
            // Update bit positions piv_i <-> pos in best_u!
            int b_piv = (best_u[piv_i >> 6] >> (piv_i & 63)) & 1ULL;
            int b_pos = (best_u[pos >> 6] >> (pos & 63)) & 1ULL;
            if (b_piv != b_pos) {
                best_u[piv_i >> 6] ^= 1ULL << (piv_i & 63);
                best_u[pos >> 6] ^= 1ULL << (pos & 63);
            }
        }
        for (int i = 0; i < pos; i++) {
            if ((best_u[i >> 6] >> (i & 63)) & 1ULL) {
                apply_col_xor(W, G_cols, A_rows, N, i, pos);
            }
        }
        iso_dim++;
    }

    int s_vc = N - iso_dim; // Columns {s_vc .. N-1} now have W[i][j] == 0 IDENTICALLY!

    // --- STAGE 2: Bit-Sliced GL(N, F_2) Support Compression Sweeps! ---
    // Note: To preserve W_iso = span(g_{s_vc} .. g_{N-1}), we NEVER add a non-isotropic column
    // `a < s_vc` into an isotropic column `b >= s_vc`!
    // Allowed moves that STRICTLY PRESERVE W_iso:
    //   1) Any (a, b) with 0 <= a, b < s_vc (arbitrary GL(s_vc, F_2) on the core!).
    //   2) Any a >= s_vc into b < s_vc (g_b ^= g_a: cleans cross-edges between S and W_iso!).
    //   3) Any a >= s_vc into b >= s_vc (GL(iso_dim, F_2) inside W_iso: cleans cross-edges W[S][T]!).
    for (int sw = 0; sw < n_sweeps; sw++) {
        int improved = 0;
        for (int a = 0; a < N; a++) {
            for (int b = 0; b < N; b++) {
                if (a == b) continue;
                if (a < s_vc && b >= s_vc) continue; // Protect W_iso!

                // Compute exact delta in (union_edges, total_monoms) for g_b ^= g_a in O(N)!
                int delta_u = 0, delta_tot = 0;
                for (int k = 0; k < N; k++) {
                    if (k == a || k == b) continue;
                    int old_nz = sig_nonzero(&W[k][b]);
                    int old_pop = old_nz ? sig_pop(&W[k][b]) : 0;
                    sig256_t nw;
                    sig_xor(&nw, &W[k][b], &W[k][a]);
                    int new_nz = sig_nonzero(&nw);
                    int new_pop = new_nz ? sig_pop(&nw) : 0;
                    delta_u += (new_nz - old_nz);
                    delta_tot += (new_pop - old_pop);
                }
                if (delta_u < 0 || (delta_u == 0 && delta_tot < 0)) {
                    apply_col_xor(W, G_cols, A_rows, N, a, b);
                    improved = 1;
                }
            }
        }
        if (!improved) break;
    }

    // --- STAGE 3: Backward Subspace Ordering + Pairwise GL-Reduction on 0 .. s_vc-1 ---
    // Order columns pos = s_vc - 1 down to 0 so that for every intermediate s,
    // p_T(s) = rank(M_2^{(T)}) is MINIMIZED (maximizing L_drop(s) = m - p_T(s)!)
    for (int pos = s_vc - 1; pos >= 0; pos--) {
        // Also test single elementary combinations g_cand ^ g_other (0 <= cand <= pos) to drop rank!
        sig256_t base_b[256];
        int base_hp[256];
        memset(base_hp, 0, sizeof(base_hp));
        int base_rk = 0;
        for (int i = pos + 1; i < N; i++) {
            for (int j = i + 1; j < N; j++) {
                sig256_t v = W[i][j];
                if (!sig_nonzero(&v)) continue;
                for (int w = 0; w < MAXW; w++) {
                    while (v.w[w]) {
                        int c = (w << 6) + __builtin_ctzll(v.w[w]);
                        if (base_hp[c]) {
                            for (int q = 0; q < MAXW; q++) v.w[q] ^= base_b[c].w[q];
                        } else {
                            base_b[c] = v; base_hp[c] = 1; base_rk++; break;
                        }
                    }
                    if (v.w[w]) break;
                }
            }
        }

        int best_cand = pos, best_partner = -1;
        int best_rk = 1000000, best_new_e = 1000000, best_tot_m = 1000000;

        for (int cand = 0; cand <= pos; cand++) {
            // Test pure column `cand` (partner = -1) AND 1-step GL combination `g_cand ^ g_part`!
            for (int part = -1; part <= pos; part++) {
                if (part == cand) continue;
                if (part >= 0 && cand > part) continue; // avoid duplicate unordered pairs

                sig256_t tb[256];
                int thp[256];
                memcpy(tb, base_b, sizeof(tb));
                memcpy(thp, base_hp, sizeof(thp));
                int rk = base_rk, new_e = 0, tot_m = 0;

                for (int j = pos + 1; j < N; j++) {
                    sig256_t v = W[cand][j];
                    if (part >= 0) sig_xor(&v, &v, &W[part][j]);
                    if (!sig_nonzero(&v)) continue;
                    new_e++;
                    for (int w = 0; w < MAXW; w++) {
                        while (v.w[w]) {
                            int c = (w << 6) + __builtin_ctzll(v.w[w]);
                            if (thp[c]) {
                                for (int q = 0; q < MAXW; q++) v.w[q] ^= tb[c].w[q];
                            } else {
                                tb[c] = v; thp[c] = 1; rk++; break;
                            }
                        }
                        if (v.w[w]) break;
                    }
                }
                for (int k = 0; k <= pos; k++) {
                    if (k == cand || k == part) continue;
                    sig256_t vk = W[cand][k];
                    if (part >= 0) sig_xor(&vk, &vk, &W[part][k]);
                    tot_m += sig_pop(&vk);
                }
                if (rk < best_rk || (rk == best_rk && (new_e < best_new_e || (new_e == best_new_e && tot_m < best_tot_m)))) {
                    best_rk = rk;
                    best_new_e = new_e;
                    best_tot_m = tot_m;
                    best_cand = cand;
                    best_partner = part;
                }
            }
        }

        if (best_partner >= 0) {
            apply_col_xor(W, G_cols, A_rows, N, best_partner, best_cand);
        }
        if (best_cand != pos) {
            apply_col_swap(W, G_cols, A_rows, N, best_cand, pos);
        }
    }

    int gl_u = 0, gl_tot = 0;
    eval_support_metrics(W, N, &gl_u, &gl_tot);

    for (int s = 0; s <= N; s++) {
        out_gl_pT[s] = exact_restricted_quad_rank(W, s, N);
        out_gl_rhoT[s] = exact_concatenated_rank(W, m, s, N);
        int ue = 0;
        for (int i = s; i < N; i++)
            for (int j = i + 1; j < N; j++)
                if (sig_nonzero(&W[i][j])) ue++;
        out_gl_edgesT[s] = ue;
    }

    memcpy(out_G_cols, G_cols, sizeof(G_cols));
    memcpy(out_A_rows, A_rows, sizeof(A_rows));
    out_metrics[0] = orig_u;
    out_metrics[1] = orig_tot;
    out_metrics[2] = gl_u;
    out_metrics[3] = gl_tot;
    out_metrics[4] = global_rad_dim;
    out_metrics[5] = iso_dim;
}

// =========================================================================================
// FAST OPENMP C LINEARIZED-CUBE SOLVER OVER TRANSFORMED SYSTEM y = A x:
// Given s branched variables y_0 .. y_{s-1}:
//   - L_drop = m - p_T equations have ZERO quadratic terms in y_T = (y_s .. y_{N-1})!
//     For each cube alpha in [cube_start, cube_end):
//       1) Evaluate the L_drop induced linear equations M_lin(alpha) * y_T = d_lin(alpha) in O(L_drop)!
//       2) Echelonize M_lin(alpha) over F_2 in 2 uint64_t words:
//          - If 1 = 0 appears -> CUBE REFUTED IN < 1 MICROSECOND!
//       3) Substitute the r_lin linear pivots into the remaining p_T quadratic equations!
//          If free_dim = (N - s) - r_lin <= 22: exhaustively check all 2^{free_dim} points in C!
//          Otherwise export surviving cube to lightweight SAT/XL!
// =========================================================================================
int sweep_linearized_cubes_omp(
    int N,
    int s,
    int n_lin_eqs,                  // L_drop = m - p_T
    const uint64_t *lin_B_ST_T,     // n_lin_eqs * s * 2 uint64_t: effect of alpha_b on row k's y_T mask
    const uint64_t *lin_base_T,     // n_lin_eqs * 2 uint64_t: l_k^{(T)} mask on y_T (bits 0..t-1)
    const uint64_t *lin_quad_S,     // n_lin_eqs * s uint64_t: upper triangular U_S[k][a] (a < b < s)
    const uint64_t *lin_l_S,        // n_lin_eqs uint64_t: linear mask on y_S (s <= 64)
    const uint8_t  *lin_const,      // n_lin_eqs
    int n_rem_quads,                // p_T remaining quadratics
    const uint64_t *rem_U_TT,       // n_rem_quads * t * 2 uint64_t (upper triangular on y_T)
    const uint64_t *rem_B_ST_T,     // n_rem_quads * s * 2 uint64_t
    const uint64_t *rem_base_T,     // n_rem_quads * 2 uint64_t
    const uint64_t *rem_quad_S,     // n_rem_quads * s uint64_t
    const uint64_t *rem_l_S,        // n_rem_quads uint64_t
    const uint8_t  *rem_const,      // n_rem_quads
    uint64_t cube_start,
    uint64_t cube_end,
    int max_bruteforce_free,        // e.g. 20
    uint64_t *out_unsat_by_lin,
    uint64_t *out_unsat_by_bf,
    uint64_t *out_hard_cubes,
    uint64_t *out_solutions_found,
    uint64_t *out_hard_cube_list,   // up to 4096 hard cube indices for fallback SAT
    int max_hard_list
) {
    const int t = N - s;
    uint64_t cnt_lin = 0, cnt_bf = 0, cnt_hard = 0, cnt_sol = 0;

    #pragma omp parallel for schedule(dynamic, 256) reduction(+:cnt_lin,cnt_bf,cnt_hard,cnt_sol)
    for (uint64_t alpha = cube_start; alpha < cube_end; alpha++) {
        uint64_t piv[MAXN][2];
        uint8_t piv_rhs[MAXN];
        int has_p[MAXN];
        memset(has_p, 0, sizeof(has_p));
        int rk = 0, contradiction = 0;

        for (int k = 0; k < n_lin_eqs; k++) {
            uint64_t row[2] = {lin_base_T[2 * k], lin_base_T[2 * k + 1]};
            int rhs = lin_const[k] ^ (__builtin_popcountll(lin_l_S[k] & alpha) & 1);
            const uint64_t *qs = lin_quad_S + (size_t)k * s;
            const uint64_t *bst = lin_B_ST_T + (size_t)(k * s) * 2;

            uint64_t a_tmp = alpha;
            while (a_tmp) {
                int a = __builtin_ctzll(a_tmp);
                row[0] ^= bst[2 * a];
                row[1] ^= bst[2 * a + 1];
                rhs ^= (__builtin_popcountll(qs[a] & alpha) & 1);
                a_tmp &= a_tmp - 1;
            }

            // Gauss insert into piv[0..t-1]
            for (int w = 0; w < 2; w++) {
                while (row[w]) {
                    int bit = __builtin_ctzll(row[w]);
                    int c = (w << 6) + bit;
                    if (has_p[c]) {
                        row[0] ^= piv[c][0];
                        row[1] ^= piv[c][1];
                        rhs ^= piv_rhs[c];
                    } else {
                        piv[c][0] = row[0];
                        piv[c][1] = row[1];
                        piv_rhs[c] = (uint8_t)rhs;
                        has_p[c] = 1;
                        rk++;
                        goto inserted_ok;
                    }
                }
            }
            if (rhs) {
                contradiction = 1;
                break;
            }
            inserted_ok:;
        }

        if (contradiction) {
            cnt_lin++;
            continue;
        }

        int free_dim = t - rk;
        if (free_dim > max_bruteforce_free) {
            cnt_hard++;
            #pragma omp critical
            {
                if ((int)(*out_hard_cubes) < max_hard_list) {
                    out_hard_cube_list[(*out_hard_cubes)++] = alpha;
                }
            }
            continue;
        }

        // Back-substitute RREF on piv[0..t-1] to parameterize y_T(z) = y0_T ^ sum_{f=0}^{free_dim-1} z_f * basis_T[f]!
        for (int c = t - 1; c >= 0; c--) {
            if (!has_p[c]) continue;
            for (int c2 = 0; c2 < c; c2++) {
                if (has_p[c2] && ((piv[c2][c >> 6] >> (c & 63)) & 1ULL)) {
                    piv[c2][0] ^= piv[c][0];
                    piv[c2][1] ^= piv[c][1];
                    piv_rhs[c2] ^= piv_rhs[c];
                }
            }
        }

        int free_cols[MAXN];
        int nf = 0;
        for (int c = 0; c < t; c++) {
            if (!has_p[c]) free_cols[nf++] = c;
        }

        uint64_t y0_T[2] = {0ULL, 0ULL};
        for (int c = 0; c < t; c++) {
            if (has_p[c] && piv_rhs[c]) y0_T[c >> 6] |= 1ULL << (c & 63);
        }

        uint64_t dir_T[32][2];
        for (int f = 0; f < nf; f++) {
            int fc = free_cols[f];
            dir_T[f][0] = 0ULL; dir_T[f][1] = 0ULL;
            dir_T[f][fc >> 6] |= 1ULL << (fc & 63);
            for (int p = 0; p < t; p++) {
                if (has_p[p] && ((piv[p][fc >> 6] >> (fc & 63)) & 1ULL)) {
                    dir_T[f][p >> 6] |= 1ULL << (p & 63);
                }
            }
        }

        // Pre-evaluate alpha part of first 64 remaining quadratics for fast bit-parallel filter!
        int q_chk = (n_rem_quads < 64) ? n_rem_quads : 64;
        uint64_t q_lin_T[64][2];
        uint8_t q_c0[64];
        for (int q = 0; q < q_chk; q++) {
            q_lin_T[q][0] = rem_base_T[2 * q];
            q_lin_T[q][1] = rem_base_T[2 * q + 1];
            int rhs = rem_const[q] ^ (__builtin_popcountll(rem_l_S[q] & alpha) & 1);
            const uint64_t *qs = rem_quad_S + (size_t)q * s;
            const uint64_t *bst = rem_B_ST_T + (size_t)(q * s) * 2;
            uint64_t a_tmp = alpha;
            while (a_tmp) {
                int a = __builtin_ctzll(a_tmp);
                q_lin_T[q][0] ^= bst[2 * a];
                q_lin_T[q][1] ^= bst[2 * a + 1];
                rhs ^= (__builtin_popcountll(qs[a] & alpha) & 1);
                a_tmp &= a_tmp - 1;
            }
            q_c0[q] = (uint8_t)rhs;
        }

        // Gray-code / direct enumeration over 2^{nf} states (nf <= 20)
        uint64_t total_z = 1ULL << nf;
        int cube_sat = 0;
        for (uint64_t z = 0; z < total_z; z++) {
            uint64_t yT[2] = {y0_T[0], y0_T[1]};
            uint64_t zt = z;
            while (zt) {
                int f = __builtin_ctzll(zt);
                yT[0] ^= dir_T[f][0];
                yT[1] ^= dir_T[f][1];
                zt &= zt - 1;
            }
            int ok = 1;
            for (int q = 0; q < q_chk; q++) {
                int val = q_c0[q] ^
                          ((__builtin_popcountll(q_lin_T[q][0] & yT[0]) +
                            __builtin_popcountll(q_lin_T[q][1] & yT[1])) & 1);
                const uint64_t *utt = rem_U_TT + (size_t)(q * t) * 2;
                for (int w = 0; w < 2; w++) {
                    uint64_t ym = yT[w];
                    while (ym) {
                        int a = (w << 6) + __builtin_ctzll(ym);
                        val ^= (__builtin_popcountll(utt[2 * a] & yT[0]) +
                                __builtin_popcountll(utt[2 * a + 1] & yT[1])) & 1;
                        ym &= ym - 1;
                    }
                }
                if (val & 1) { ok = 0; break; }
            }
            if (!ok) continue;

            // Check remaining quadratics q_chk .. n_rem_quads-1 if any!
            for (int q = q_chk; q < n_rem_quads; q++) {
                uint64_t lt0 = rem_base_T[2 * q], lt1 = rem_base_T[2 * q + 1];
                int val = rem_const[q] ^ (__builtin_popcountll(rem_l_S[q] & alpha) & 1);
                const uint64_t *qs = rem_quad_S + (size_t)q * s;
                const uint64_t *bst = rem_B_ST_T + (size_t)(q * s) * 2;
                uint64_t a_tmp = alpha;
                while (a_tmp) {
                    int a = __builtin_ctzll(a_tmp);
                    lt0 ^= bst[2 * a]; lt1 ^= bst[2 * a + 1];
                    val ^= (__builtin_popcountll(qs[a] & alpha) & 1);
                    a_tmp &= a_tmp - 1;
                }
                val ^= (__builtin_popcountll(lt0 & yT[0]) + __builtin_popcountll(lt1 & yT[1])) & 1;
                const uint64_t *utt = rem_U_TT + (size_t)(q * t) * 2;
                for (int w = 0; w < 2; w++) {
                    uint64_t ym = yT[w];
                    while (ym) {
                        int a = (w << 6) + __builtin_ctzll(ym);
                        val ^= (__builtin_popcountll(utt[2 * a] & yT[0]) +
                                __builtin_popcountll(utt[2 * a + 1] & yT[1])) & 1;
                        ym &= ym - 1;
                    }
                }
                if (val & 1) { ok = 0; break; }
            }
            if (ok) {
                cube_sat = 1;
                cnt_sol++;
            }
        }
        if (!cube_sat) cnt_bf++;
    }

    *out_unsat_by_lin = cnt_lin;
    *out_unsat_by_bf = cnt_bf;
    *out_solutions_found = cnt_sol;
    return 0;
}
"""


U4_LIST = [u * 0x1111 for u in range(16)]


def rref_gf2(vecs):
    pivs = {}
    for v in vecs:
        x = v
        while x:
            b = x.bit_length() - 1
            if b in pivs:
                x ^= pivs[b]
            else:
                pivs[b] = x
                break
    for b in sorted(pivs.keys(), reverse=True):
        for b2 in list(pivs.keys()):
            if b2 != b and ((pivs[b2] >> b) & 1):
                pivs[b2] ^= pivs[b]
    return [pivs[b] for b in sorted(pivs.keys(), reverse=True)]


def span_set(basis):
    pts = [0]
    for b in basis:
        pts += [p ^ b for p in pts]
    return pts


def nullspace_basis_16(hs):
    rows = rref_gf2(hs)
    piv_map = {r.bit_length() - 1: r for r in rows}
    out = []
    for f in range(16):
        if f in piv_map:
            continue
        v = 1 << f
        for pb, r in piv_map.items():
            if (r >> f) & 1:
                v |= 1 << pb
        out.append(v)
    return out


def sample_rot4_wperp(rng, target_codim):
    for _ in range(200):
        gens = []
        while len(rref_gf2(gens)) < target_codim:
            choice = rng.random()
            if choice < 0.35:
                cand = gens + [rng.choice(U4_LIST)]
            elif choice < 0.70:
                v = rng.randint(1, 255)
                d = v | (v << 8)
                cand = gens + [d, rot16(d, 4)]
            else:
                if rng.random() < 0.75:
                    v = rng.randint(0, 255)
                    u4b = rng.choice([u & 0xFF for u in U4_LIST if u])
                    h = v | ((v ^ u4b) << 8)
                else:
                    h = rng.randint(1, 65535)
                cand = gens + [h, rot16(h, 4), rot16(h, 8), rot16(h, 12)]
            if len(rref_gf2(cand)) <= target_codim:
                gens = rref_gf2(cand)
            elif len(rref_gf2(gens)) == target_codim - 1:
                for u in rng.sample(U4_LIST, len(U4_LIST)):
                    if len(rref_gf2(gens + [u])) == target_codim:
                        gens = rref_gf2(gens + [u])
                        break
                break
        if len(gens) == target_codim:
            sp = set(span_set(gens))
            if all(rot16(w, 4) in sp for w in sp):
                return gens
    return None


def extract_mod8_from_orbits4(basis_words, O_word, d0_div4, n):
    o_pop = O_word.bit_count()
    g0 = o_pop + d0_div4
    if g0 & 1:
        return None, None
    S1 = []
    for i in range(n):
        wi = basis_words[i].bit_count()
        wo = (basis_words[i] & O_word).bit_count()
        si = wi - 2 * wo
        if si & 1:
            return None, None
        S1.append(si)

    def toggle(pset, m):
        if m in pset:
            pset.remove(m)
        else:
            pset.add(m)

    P2, Q_raw = set(), set()
    v0 = g0 >> 1
    if v0 & 1:
        toggle(P2, 0)
    if (v0 >> 1) & 1:
        toggle(Q_raw, 0)
    for i in range(n):
        vi = S1[i] >> 1
        if vi & 1:
            toggle(P2, 1 << i)
        if (vi >> 1) & 1:
            toggle(Q_raw, 1 << i)
    for i in range(n):
        bi = basis_words[i]
        for j in range(i + 1, n):
            inter = bi & basis_words[j]
            if not inter:
                continue
            vij = 2 * (inter & O_word).bit_count() - inter.bit_count()
            m_ij = (1 << i) | (1 << j)
            if vij & 1:
                toggle(P2, m_ij)
            if (vij >> 1) & 1:
                toggle(Q_raw, m_ij)
            for k in range(j + 1, n):
                if (inter & basis_words[k]).bit_count() & 1:
                    toggle(Q_raw, m_ij | (1 << k))
    p2_list = sorted(P2)
    Q4 = set(Q_raw)
    for idx_a in range(len(p2_list)):
        ma = p2_list[idx_a]
        for idx_b in range(idx_a + 1, len(p2_list)):
            toggle(Q4, ma | p2_list[idx_b])
    return P2, Q4


def build_c8_orbits():
    seen = set()
    u8_size8, nonzero_z = [], []
    for a in range(256):
        if a in seen:
            continue
        orb, cur = [], a
        while cur not in orb:
            orb.append(cur)
            cur = rot8(cur)
        seen.update(orb)
        rep = min(orb)
        if a != 0:
            nonzero_z.append((rep, orb))
        if len(orb) == 8:
            u8_size8.append((rep, orb))
    return u8_size8, nonzero_z


def fiber_orbit_reps(z, group_step):
    pts = [v | ((v ^ z) << 8) for v in range(256)]
    seen = set()
    reps = []
    for x in pts:
        if x in seen:
            continue
        cur, orb = x, []
        while cur not in orb:
            orb.append(cur)
            for _ in range(group_step):
                cur = rot16(cur)
        seen.update(orb)
        reps.append(min(orb))
    return reps


def gf2_nullspace_left(mat_rows):
    piv = {}
    null_vecs = []
    for i, r in enumerate(mat_rows):
        v = r
        comb = 1 << i
        while v:
            b = v.bit_length() - 1
            if b in piv:
                pv, pcomb = piv[b]
                v ^= pv
                comb ^= pcomb
            else:
                piv[b] = (v, comb)
                break
        if v == 0:
            null_vecs.append(comb)
    return null_vecs


def extract_sym2_poly(lin_masks, origin_bits, n):
    M = len(lin_masks)
    o_wt = sum(origin_bits)
    pset = set()

    def toggle(m):
        if m in pset:
            pset.remove(m)
        else:
            pset.add(m)

    if ((o_wt * (o_wt - 1)) // 2) & 1:
        toggle(0)
    col_masks = [0] * n
    for r, wm in enumerate(lin_masks):
        for i in range(n):
            if (wm >> i) & 1:
                col_masks[i] |= 1 << r
    for i in range(n):
        c_wt = col_masks[i].bit_count()
        lin_coeff = 0
        for r in range(M):
            if ((col_masks[i] >> r) & 1) and ((o_wt - origin_bits[r]) & 1):
                lin_coeff ^= 1
        if ((c_wt * (c_wt - 1)) // 2) & 1:
            lin_coeff ^= 1
        if lin_coeff:
            toggle(1 << i)
    for i in range(n):
        ci = col_masks[i]
        ci_wt = ci.bit_count()
        for j in range(i + 1, n):
            cj = col_masks[j]
            if (ci_wt * cj.bit_count() - (ci & cj).bit_count()) & 1:
                toggle((1 << i) | (1 << j))
    return pset


def eliminate_linear_pivots_and_reduce_quads(deg12_psets, n_orig):
    """
    Given all degree <= 2 psets on n_orig = 111 variables:
      1) Extract and RREF all linear equations (deg <= 1).
      2) Express pivot variables x_{piv} = const ^ sum_{f in free} alpha_f x_f.
      3) Substitute into all quadratic equations and RREF over the N_free variables!
    Returns (free_vars, subst_map, reduced_quads_N, has_contradiction).
    """
    lin_rows = []
    quad_raw = []
    for p in deg12_psets:
        if not p:
            continue
        md = max(m.bit_count() for m in p)
        if md == 0:
            return [], {}, [], True
        elif md == 1:
            lin_rows.append(set(p))
        elif md == 2:
            quad_raw.append(set(p))

    # Iteratively reduce quadratics modulo linear equations (in case substitution drops a quad to linear!)
    while True:
        piv_lin = {}
        for lp in lin_rows:
            cur = set(lp)
            while cur:
                mx = max(cur)
                if mx == 0:
                    return [], {}, [], True
                b = mx.bit_length() - 1
                if b in piv_lin:
                    cur ^= piv_lin[b]
                else:
                    piv_lin[b] = cur
                    break

        for b in sorted(piv_lin.keys()):
            for b2 in list(piv_lin.keys()):
                if b2 != b and ((1 << b) in piv_lin[b2]):
                    piv_lin[b2] ^= piv_lin[b]

        # Substitute x_b -> (piv_lin[b] ^ {1<<b}) in all quad_raw
        new_lin_found = False
        next_quads = []
        for qp in quad_raw:
            out_q = set()
            for m in qp:
                if m == 0:
                    out_q ^= {0}
                elif m.bit_count() == 1:
                    b = m.bit_length() - 1
                    rep = (piv_lin[b] ^ {1 << b}) if b in piv_lin else {1 << b}
                    out_q ^= rep
                else:
                    b0 = (m & -m).bit_length() - 1
                    b1 = (m ^ (1 << b0)).bit_length() - 1
                    r0 = (piv_lin[b0] ^ {1 << b0}) if b0 in piv_lin else {1 << b0}
                    r1 = (piv_lin[b1] ^ {1 << b1}) if b1 in piv_lin else {1 << b1}
                    for a in r0:
                        for c in r1:
                            out_q ^= {a | c}
            if not out_q:
                continue
            md = max(m.bit_count() for m in out_q)
            if md == 0:
                return [], {}, [], True
            elif md == 1:
                lin_rows.append(out_q)
                new_lin_found = True
            else:
                next_quads.append(out_q)
        quad_raw = next_quads
        if not new_lin_found:
            break

    free_vars = [v for v in range(n_orig) if v not in piv_lin]
    orig_to_free = {v: idx for idx, v in enumerate(free_vars)}
    N = len(free_vars)

    # Remap quad_raw to [0 .. N-1] and put in exact RREF!
    remapped_quads = []
    for qp in quad_raw:
        rq = set()
        for m in qp:
            if m == 0:
                rq.add(0)
            elif m.bit_count() == 1:
                rq.add(1 << orig_to_free[m.bit_length() - 1])
            else:
                b0 = (m & -m).bit_length() - 1
                b1 = (m ^ (1 << b0)).bit_length() - 1
                rq.add((1 << orig_to_free[b0]) | (1 << orig_to_free[b1]))
        remapped_quads.append(rq)

    q_pivs = {}
    for rq in remapped_quads:
        cur = set(rq)
        while cur:
            lead = max(cur, key=lambda m: (m.bit_count(), m))
            if lead.bit_count() <= 1:
                if lead == 0:
                    return [], {}, [], True
                # Linear mutant emerged from quadratic RREF! Re-run outer elimination!
                orig_lin = set()
                for m in cur:
                    if m == 0:
                        orig_lin.add(0)
                    else:
                        orig_lin.add(1 << free_vars[m.bit_length() - 1])
                return eliminate_linear_pivots_and_reduce_quads(deg12_psets + [orig_lin], n_orig)
            if lead in q_pivs:
                cur ^= q_pivs[lead]
            else:
                q_pivs[lead] = cur
                break

    # Full RREF on q_pivs so tails are maximally clean
    sorted_leads = sorted(q_pivs.keys(), key=lambda m: (m.bit_count(), m))
    for ld in sorted_leads:
        for ld2 in sorted_leads:
            if ld2 != ld and (ld in q_pivs[ld2]):
                q_pivs[ld2] ^= q_pivs[ld]

    subst_map = {}
    for b, p in piv_lin.items():
        rem = p ^ {1 << b}
        c_bit = 1 if (0 in rem) else 0
        f_mask = 0
        for m in rem:
            if m != 0:
                f_mask |= 1 << orig_to_free[m.bit_length() - 1]
        subst_map[b] = (f_mask, c_bit)

    return free_vars, subst_map, [q_pivs[ld] for ld in reversed(sorted_leads)], False


def transform_quads_by_G(quads_N, G_cols_int, N):
    """
    Compute tilde{q}_r(y) = q_r(G y) over F_2[y_0..y_{N-1}]/(y_a^2 + y_a) using Lemma 1.1:
      - tilde{B}_r = G^T B_r G  (off-diagonal a < b)
      - tilde{l}_r[a] = q_r^{hom_deg2}(g_a) ^ <l_r, g_a>
      - tilde{c}_r = c_r
    """
    out_quads = []
    for qp in quads_N:
        c_r = 1 if (0 in qp) else 0
        l_mask = 0
        u_pairs = []
        B_rows = [0] * N
        for m in qp:
            bc = m.bit_count()
            if bc == 1:
                l_mask |= m
            elif bc == 2:
                i = (m & -m).bit_length() - 1
                j = (m ^ (1 << i)).bit_length() - 1
                u_pairs.append((i, j))
                B_rows[i] |= 1 << j
                B_rows[j] |= 1 << i

        tq = set()
        if c_r:
            tq.add(0)

        # Precompute B_r * g_b for b = 0..N-1
        Bg = [0] * N
        for b in range(N):
            gb = G_cols_int[b]
            v = 0
            for i in range(N):
                if (B_rows[i] & gb).bit_count() & 1:
                    v |= 1 << i
            Bg[b] = v

        for a in range(N):
            ga = G_cols_int[a]
            lin_a = (l_mask & ga).bit_count() & 1
            for i, j in u_pairs:
                if ((ga >> i) & 1) and ((ga >> j) & 1):
                    lin_a ^= 1
            if lin_a:
                tq.add(1 << a)
            for b in range(a + 1, N):
                if (ga & Bg[b]).bit_count() & 1:
                    tq.add((1 << a) | (1 << b))
        out_quads.append(tq)
    return out_quads


def eval_pset_int(pset, vec_int):
    ans = 0
    for m in pset:
        if (vec_int & m) == m:
            ans ^= 1
    return ans


def matvec_f2_rows(rows_int, x_int, N):
    out = 0
    for r in range(N):
        if (rows_int[r] & x_int).bit_count() & 1:
            out |= 1 << r
    return out


def matvec_f2_cols(cols_int, y_int, N):
    out = 0
    tmp = y_int
    while tmp:
        b = tmp & -tmp
        a = b.bit_length() - 1
        out ^= cols_int[a]
        tmp ^= b
    return out


def split_transformed_quads_for_s(t_quads, N, s):
    """
    Given transformed quadratics tilde{q}_1 .. tilde{q}_m in y = (y_S, y_T), S={0..s-1}, T={s..N-1}:
    Put the T-quadratic parts M_2^{(T)} in left-to-right echelon form so that:
      - `rem_quads` (length p_T) have linearly independent T-quadratic parts;
      - `lin_dropped` (length m - p_T) have ZERO quadratic terms in y_T (PURELY LINEAR in y_T
        for EVERY fixed alpha in F_2^s!!).
    """
    piv_T = {}  # lead_T_pair_mask -> full pset
    lin_dropped = []
    for tq in t_quads:
        cur = set(tq)
        while True:
            t_quad_terms = [
                m for m in cur
                if m.bit_count() == 2 and ((m & -m).bit_length() - 1) >= s
            ]
            if not t_quad_terms:
                lin_dropped.append(cur)
                break
            lead = max(t_quad_terms)
            if lead in piv_T:
                cur ^= piv_T[lead]
            else:
                piv_T[lead] = cur
                break
    rem_quads = [piv_T[k] for k in sorted(piv_T.keys(), reverse=True)]
    return lin_dropped, rem_quads


def compile_libs(work_dir: Path):
    c1_path = work_dir / "b06_audit_extract.c"
    so1_path = work_dir / "libb06_audit_extract.so"
    c1_path.write_text(C_SRC_AUDIT, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c1_path), "-o", str(so1_path)], check=True)

    c2_path = work_dir / "b06_gl_core.c"
    so2_path = work_dir / "libb06_gl_core.so"
    c2_path.write_text(C_SRC_B06_GL, encoding="utf-8")
    subprocess.run(
        ["gcc", "-O3", "-march=native", "-fopenmp", "-shared", "-fPIC", str(c2_path), "-o", str(so2_path)],
        check=True,
    )

    lib_ext = ctypes.CDLL(str(so1_path))
    lib_ext.extract_level1_quad_when_diag4.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64),
    ]
    lib_ext.extract_level1_quad_when_diag4.restype = ctypes.c_int
    lib_ext.extract_coset_full_hierarchy_corrected.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib_ext.extract_coset_full_hierarchy_corrected.restype = ctypes.c_int
    lib_ext.gf2_echelon_insert.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib_ext.gf2_echelon_insert.restype = ctypes.c_int

    lib_gl = ctypes.CDLL(str(so2_path))
    lib_gl.compute_permutation_baseline_curve.argtypes = [
        ctypes.c_void_p, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
    ]
    lib_gl.find_optimal_gl_basis.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
    ]
    lib_gl.sweep_linearized_cubes_omp.argtypes = [
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_uint64, ctypes.c_uint64, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
    ]
    lib_gl.sweep_linearized_cubes_omp.restype = ctypes.c_int
    return lib_ext, lib_gl


def analyze_and_solve_cell(
    c99_val: int,
    c57_val: int,
    c113_val: int,
    precomp: dict,
    lib_ext,
    lib_gl,
    cube_s_override: int = 0,
):
    tc = time.perf_counter()
    cell_name = f"B{c99_val}_{c57_val}{c113_val}"
    orbits = precomp["orbits"]
    v6_list = precomp["v6_list"]
    pair_idx = precomp["pair_idx"]
    orb_diag = precomp["orb_diag"]
    orb_pair = precomp["orb_pair"]
    orb_r4 = precomp["orb_r4"]
    chi_r4 = precomp["chi_r4"]
    rep_of_x = precomp["rep_of_x"]
    orb_0xf_parity = precomp["orb_0xf_parity"]
    orb_tts_point = precomp["orb_tts_point"]
    u8_size8 = precomp["u8_size8"]
    nonzero_z = precomp["nonzero_z"]
    null_z_vecs = precomp["null_z_vecs"]

    _, origin, cb = build_pure_111_basis(c99_val, c57_val, c113_val)
    n = 111
    n3 = n * (n - 1) * (n - 2) // 6
    n2 = n * (n - 1) // 2
    off2, off1, off0 = n3, n3 + n2, n3 + n2 + n
    n_cols = off0 + 1
    n_col_words = (n_cols + 63) // 64
    col3_base = precomp["col3_base"]
    col3_list = precomp["col3_list"]
    pair2_col = precomp["pair2_col"]
    pair2_list = precomp["pair2_list"]

    O_diag, O_pair, O_r4 = 0, 0, 0
    for j in range(116):
        if (origin >> j) & 1:
            O_diag ^= orb_diag[j]
            O_pair ^= orb_pair[j]
            O_r4 ^= orb_r4[j]
    cb_pair, cb_r4 = [], []
    for cdir in cb:
        vp, vr = 0, 0
        for j in range(116):
            if (cdir >> j) & 1:
                vp ^= orb_pair[j]
                vr ^= orb_r4[j]
        cb_pair.append(vp)
        cb_r4.append(vr)

    mask64 = (1 << 64) - 1
    all_pair_bits = (ctypes.c_uint64 * ((n + 1) * 510))()
    for i in range(n):
        for w in range(510):
            all_pair_bits[i * 510 + w] = (cb_pair[i] >> (64 * w)) & mask64
    for w in range(510):
        all_pair_bits[n * 510 + w] = (O_pair >> (64 * w)) & mask64

    max_rows = 16500
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    piv_row_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
    cur_row = 0
    deg_pivs = {0: 0, 1: 0, 2: 0, 3: 0}
    xl_queue = []
    deg12_rows = []

    def record_piv(pc):
        nonlocal cur_row
        if pc < 0:
            return
        d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
        deg_pivs[d] += 1
        if d in (1, 2):
            xl_queue.append(cur_row)
            deg12_rows.append(cur_row)
        cur_row += 1

    def mul_p(p1, p2):
        out = set()
        for a in p1:
            for b in p2:
                m = a | b
                if m in out:
                    out.remove(m)
                else:
                    out.add(m)
        return out

    def insert_pset(pset):
        if not pset or cur_row >= max_rows - 2 or piv_row_idx[off0] >= 0:
            return -1
        base = cur_row * n_col_words
        row_ptr = ctypes.cast(ctypes.byref(rows, base * 8), ctypes.POINTER(ctypes.c_uint64))
        ctypes.memset(row_ptr, 0, n_col_words * 8)
        for m in pset:
            d = m.bit_count()
            if d == 0:
                c = off0
            elif d == 1:
                c = off1 + (m.bit_length() - 1)
            elif d == 2:
                c = pair2_col[m]
            else:
                b0 = (m & -m).bit_length() - 1
                m1 = m ^ (1 << b0)
                b1 = (m1 & -m1).bit_length() - 1
                b2 = (m1 ^ (1 << b1)).bit_length() - 1
                c = col3_base[b0 * n + b1] + (b2 - b1 - 1)
            rows[base + (c >> 6)] ^= 1 << (c & 63)
        pc = lib_ext.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
        record_piv(pc)
        return pc

    def drain_xl():
        while xl_queue and piv_row_idx[off0] < 0 and cur_row < max_rows - n - 20:
            r_idx = xl_queue.pop(0)
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
            for i in range(n):
                if cur_row >= max_rows - 5 or piv_row_idx[off0] >= 0:
                    break
                insert_pset(mul_p({1 << i}, pset))

    # 1. Exact parity of C_{0xf} (Theorem 1: wt_orb16(C_{0xf}) == 128 => even!)
    c0xf_mask = sum(1 << j for j in range(116) if orb_0xf_parity[j])
    p_0xf = {1 << i for i, cdir in enumerate(cb) if (cdir & c0xf_mask).bit_count() & 1}
    if (origin & c0xf_mask).bit_count() & 1:
        p_0xf.add(0)
    insert_pset(p_0xf)
    drain_xl()

    # 2. Seed Q4 (note: in pure 111 vars without assuming K=c57, include I1*J1 when c99=0;
    #    when c99=1, L=1 makes I1^J1=1 so I1*J1 = I1 ^ I1^2 = 0 on boolean ring? Wait: u1 ^ v1 = L = 1
    #    => u1 * v1 = u1 * (u1 ^ 1) = u1 ^ u1 = 0 IDENTICALLY! Verified!)
    def lin_expr(indices):
        mask = sum(1 << j for j in indices)
        idxs = [i for i, c in enumerate(cb) if (c & mask).bit_count() & 1]
        return idxs, (origin & mask).bit_count() & 1

    def poly_from_lin(idxs, const):
        p = {1 << i for i in idxs}
        if const:
            p.add(0)
        return p

    slin_i, slin_c = lin_expr([23, 31, 39, 112])
    # Wait: in C4 (T20), the constant term on (c99, c57) is c57 when K=c57; to be 100% assumption-free
    # on pure 111 variables, let V6xV6 (which includes 0x3f3f, 0x55ff, 0x7777!) extract C5, C7, and Q4 directly,
    # AND also check C_{0x0}\D_8 mod 4!
    p_idxs_arr = (ctypes.c_int * 2048)()
    MAX_CHARS = 9
    MAX_C_PAIRS = MAX_CHARS * (MAX_CHARS - 1) // 2
    char_words32 = (ctypes.c_uint64 * (MAX_CHARS * 32))()
    quad_buf = (ctypes.c_uint64 * (MAX_CHARS * n_col_words))()
    quad_valid = (ctypes.c_int * MAX_CHARS)()
    lin_buf = (ctypes.c_uint64 * (MAX_C_PAIRS * n_col_words))()
    lin_valid = (ctypes.c_int * MAX_C_PAIRS)()

    def process_coset(pts_16):
        if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 100:
            return
        diag_pts = [x & 0xFF for x in pts_16 if (x & 0xFF) == (x >> 8)]
        pair_reps = [x for x in pts_16 if (x & 0xFF) < (x >> 8)]
        n_pairs = len(pair_reps)
        dmask = sum(1 << v for v in diag_pts)
        wt_diag = (O_diag & dmask).bit_count()

        for k, x in enumerate(pair_reps):
            p_idxs_arr[k] = pair_idx[(x & 0xFF, x >> 8)]

        u_vecs = [(1 << r) | (1 << (r + 8)) for r in range(8)] + [0xFFFF]
        ctypes.memset(char_words32, 0, ctypes.sizeof(char_words32))
        for m_i, u16 in enumerate(u_vecs):
            base_m = m_i * 32
            for k, x in enumerate(pair_reps):
                if (x & u16).bit_count() & 1:
                    char_words32[base_m + (k >> 6)] |= 1 << (k & 63)

        if wt_diag % 8 == 4:
            base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            if lib_ext.extract_level1_quad_when_diag4(
                all_pair_bits, p_idxs_arr, n_pairs, n, None, off2, off1, off0, n_col_words, base_ptr
            ) == 0:
                pc = lib_ext.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                record_piv(pc)
            for m_i in range(MAX_CHARS):
                if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 20:
                    break
                um_ptr = ctypes.cast(ctypes.byref(char_words32, m_i * 32 * 8), ctypes.POINTER(ctypes.c_uint64))
                base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                if lib_ext.extract_level1_quad_when_diag4(
                    all_pair_bits, p_idxs_arr, n_pairs, n, um_ptr, off2, off1, off0, n_col_words, base_ptr
                ) == 0:
                    pc = lib_ext.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                    record_piv(pc)
            drain_xl()
            return

        if wt_diag % 8 != 0:
            return
        diag_div8_parity = (wt_diag // 8) & 1
        ctypes.memset(quad_buf, 0, ctypes.sizeof(quad_buf))
        base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
        rc = lib_ext.extract_coset_full_hierarchy_corrected(
            all_pair_bits, p_idxs_arr, n_pairs, n, diag_div8_parity,
            char_words32, MAX_CHARS, col3_base, off2, off1, off0, n_col_words,
            base_ptr, quad_buf, quad_valid, lin_buf, lin_valid,
        )
        if rc != 0:
            return
        pc = lib_ext.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
        record_piv(pc)

        for pm in range(MAX_C_PAIRS):
            if not lin_valid[pm] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                continue
            dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(lin_buf, pm * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_col_words * 8)
            pc = lib_ext.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            record_piv(pc)

        for m_i in range(MAX_CHARS):
            if not quad_valid[m_i] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                continue
            dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(quad_buf, m_i * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_col_words * 8)
            pc = lib_ext.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            record_piv(pc)

        drain_xl()

    # 3. Linear V6 x V6 + Interleaved + Affine Shifts (budgeted)
    for pts8 in v6_list:
        if piv_row_idx[off0] >= 0:
            break
        w_pts = [v | (w << 8) for v in pts8 for w in pts8]
        process_coset(w_pts)

    # Insert Q4 (valid once C5 K=c57 is established; note in B1_00, C_0xf + V6 already gives 1=0!)
    if piv_row_idx[off0] < 0:
        q4 = poly_from_lin(slin_i, slin_c ^ c57_val)
        pairs_ij = [(I2, J2), (I3, J3), (I4, J4)] if c99_val == 1 else [(I1, J1), (I2, J2), (I3, J3), (I4, J4)]
        for Ir, Jr in pairs_ij:
            ui, uc = lin_expr(Ir)
            vi, vc = lin_expr(Jr)
            q4 ^= mul_p(poly_from_lin(ui, uc), poly_from_lin(vi, vc))
        insert_pset(q4)
        drain_xl()

    # 4. Dual Fiber Equations (exact & proven: B0_00 has wt(F_z)==128; others satisfy Krawtchouk mod-2 syzygies)
    def eval_x_form_111(x_pt):
        orb_vec = orb_tts_point[x_pt]
        o_bit = (origin & orb_vec).bit_count() & 1
        w_mask = 0
        for i, cdir in enumerate(cb):
            if (cdir & orb_vec).bit_count() & 1:
                w_mask |= 1 << i
        return w_mask, o_bit

    if piv_row_idx[off0] < 0:
        if c99_val == 0 and c57_val == 0 and c113_val == 0:
            for z_rep, _ in nonzero_z:
                gstep = 1 if z_rep == 0xFF else (2 if z_rep in (0x55, 0xAA) else (4 if z_rep in (0x11, 0x33, 0x77) else 8))
                reps = fiber_orbit_reps(z_rep, gstep)
                forms = [eval_x_form_111(x) for x in reps]
                w_xor, o_xor = 0, 0
                for wm, ob in forms:
                    w_xor ^= wm
                    o_xor ^= ob
                lin_p = {1 << i for i in range(n) if (w_xor >> i) & 1}
                if o_xor:
                    lin_p.add(0)
                insert_pset(lin_p)
                if not lin_p:
                    target_e2 = ((len(forms) // 2) // 2) & 1
                    q_fib = extract_sym2_poly([wm for wm, _ in forms], [ob for _, ob in forms], n)
                    if target_e2:
                        q_fib ^= {0}
                    insert_pset(q_fib)
                drain_xl()
        else:
            pair_forms_35 = [
                [eval_x_form_111(x) for x in fiber_orbit_reps(z_rep, 8)]
                for z_rep, _ in nonzero_z
            ]
            for u_vec in null_z_vecs:
                w_xor, o_xor = 0, 0
                for z_i in range(len(nonzero_z)):
                    if (u_vec >> z_i) & 1:
                        for wm, ob in pair_forms_35[z_i]:
                            w_xor ^= wm
                            o_xor ^= ob
                lin_p = {1 << i for i in range(n) if (w_xor >> i) & 1}
                if o_xor:
                    lin_p.add(0)
                insert_pset(lin_p)
            drain_xl()

    # 5. rot^4-invariant dim 12 (mod 32) and dim 11 (mod 16)
    if piv_row_idx[off0] < 0:
        rng = random.Random(20260707 + 10 * c99_val + c57_val)
        seen_w = set()
        for trial in range(900):
            if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 150 or (time.perf_counter() - tc) > 25.0:
                break
            codim = 4 if (trial % 3 != 2) else 5
            wp_basis = sample_rot4_wperp(rng, codim)
            if wp_basis is None:
                continue
            key = tuple(wp_basis)
            if key in seen_w:
                continue
            seen_w.add(key)
            W_pts = span_set(nullspace_basis_16(wp_basis))
            diag_mask = 0
            r4_indices, picked_r4 = [], set()
            for x in W_pts:
                if (x & 0xFF) == (x >> 8):
                    diag_mask |= 1 << (x & 0xFF)
                else:
                    ri = rep_of_x[x]
                    if ri not in picked_r4:
                        picked_r4.add(ri)
                        r4_indices.append(ri)
            d0 = (O_diag & diag_mask).bit_count()
            if d0 % 4 != 0:
                continue
            sub_cb = []
            for vr in cb_r4:
                w = 0
                for idx, ri in enumerate(r4_indices):
                    if (vr >> ri) & 1:
                        w |= 1 << idx
                sub_cb.append(w)
            for use_chi in (0, 1):
                src_O = O_r4 ^ (chi_r4 if use_chi else 0)
                sub_O = 0
                for idx, ri in enumerate(r4_indices):
                    if (src_O >> ri) & 1:
                        sub_O |= 1 << idx
                P2, Q4_r = extract_mod8_from_orbits4(sub_cb, sub_O, d0 // 4, n)
                if P2 is not None:
                    insert_pset(P2)
                if codim == 4 and Q4_r is not None and max((m.bit_count() for m in Q4_r), default=0) <= 3:
                    insert_pset(Q4_r)
                drain_xl()

    if piv_row_idx[off0] >= 0:
        return {
            "cell": cell_name,
            "algebraic_has_one": True,
            "closed_unsat": True,
            "deg_pivs_111": deg_pivs,
            "sec": round(time.perf_counter() - tc, 3),
        }

    # Decode all degree <= 2 rows and eliminate linear variables cleanly!
    deg12_psets = []
    for r_idx in deg12_rows:
        row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
        deg12_psets.append(decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list))

    free_vars, subst_map, quads_N, lin_contra = eliminate_linear_pivots_and_reduce_quads(deg12_psets, n)
    if lin_contra:
        return {
            "cell": cell_name,
            "algebraic_has_one": True,
            "closed_unsat": True,
            "deg_pivs_111": deg_pivs,
            "sec": round(time.perf_counter() - tc, 3),
        }

    N = len(free_vars)
    m = len(quads_N)
    assert m <= 256, f"Increase MAXW in C for m={m}"

    # Pack B_1 .. B_m for C GL(N, F_2) Core Optimizer!
    B_bits_in = (ctypes.c_uint64 * (m * N * 2))()
    sig_init = (((ctypes.c_uint64 * 4) * 112) * 112)()
    for r_i, qp in enumerate(quads_N):
        rw, rb = r_i >> 6, r_i & 63
        for term in qp:
            if term.bit_count() == 2:
                i = (term & -term).bit_length() - 1
                j = (term ^ (1 << i)).bit_length() - 1
                B_bits_in[(r_i * N + i) * 2 + (j >> 6)] |= 1 << (j & 63)
                B_bits_in[(r_i * N + j) * 2 + (i >> 6)] |= 1 << (i & 63)
                sig_init[i][j][rw] |= 1 << rb
                sig_init[j][i][rw] |= 1 << rb

    # 1) Permutation baseline S_N
    perm_pT = (ctypes.c_int * (N + 1))()
    perm_edgesT = (ctypes.c_int * (N + 1))()
    perm_order = (ctypes.c_int * N)()
    lib_gl.compute_permutation_baseline_curve(sig_init, N, m, perm_pT, perm_edgesT, perm_order)

    # 2) Full GL(N, F_2) Simultaneous Linearization!
    t_gl = time.perf_counter()
    G_cols_c = (ctypes.c_uint64 * (N * 2))()
    A_rows_c = (ctypes.c_uint64 * (N * 2))()
    gl_pT = (ctypes.c_int * (N + 1))()
    gl_rhoT = (ctypes.c_int * (N + 1))()
    gl_edgesT = (ctypes.c_int * (N + 1))()
    metrics_c = (ctypes.c_int * 6)()

    lib_gl.find_optimal_gl_basis(
        B_bits_in, N, m, 80, G_cols_c, A_rows_c, gl_pT, gl_rhoT, gl_edgesT, metrics_c
    )
    gl_sec = round(time.perf_counter() - t_gl, 3)

    G_cols_int = [int(G_cols_c[2 * a]) | (int(G_cols_c[2 * a + 1]) << 64) for a in range(N)]
    A_rows_int = [int(A_rows_c[2 * r]) | (int(A_rows_c[2 * r + 1]) << 64) for r in range(N)]

    # STRICT AUDIT 1: Verify A * G == I_N over GF(2)!
    for r in range(N):
        for c in range(N):
            dot = (A_rows_int[r] & G_cols_int[c]).bit_count() & 1
            assert dot == (1 if r == c else 0), f"A*G != I at ({r},{c})!"

    # STRICT AUDIT 2: Transform all m quadratics tilde{q}_r(y) = q_r(G y) and verify on 64 random x in F_2^N!
    t_quads = transform_quads_by_G(quads_N, G_cols_int, N)
    rng_chk = random.Random(998877 + c99_val * 10 + c57_val)
    for _ in range(64):
        x_int = rng_chk.getrandbits(N)
        y_int = matvec_f2_rows(A_rows_int, x_int, N)
        assert matvec_f2_cols(G_cols_int, y_int, N) == x_int
        for r_i in range(min(m, 40)):
            assert eval_pset_int(quads_N[r_i], x_int) == eval_pset_int(t_quads[r_i], y_int), \
                f"Transformed quadratic mismatch at r={r_i}!"

    # Build comparison table s -> (L_drop_GL vs L_drop_Perm)
    perm_iso_dim = sum(1 for s in range(N) if perm_pT[s] == 0)
    gl_iso_dim = metrics_c[5]
    gl_vc_size = N - gl_iso_dim
    perm_vc_size = N - perm_iso_dim

    checkpoints = sorted(set([0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 48, 56, 64, gl_vc_size, perm_vc_size]))
    checkpoints = [s for s in checkpoints if 0 <= s <= N]
    curve_table = []
    for s in checkpoints:
        curve_table.append({
            "s_branched": s,
            "T_rem_vars": N - s,
            "GL_pT_rank": int(gl_pT[s]),
            "GL_linear_eqs_dropped": int(m - gl_pT[s]),
            "GL_concat_rank_rhoT": int(gl_rhoT[s]),
            "GL_edges_in_T": int(gl_edgesT[s]),
            "Perm_pT_rank": int(perm_pT[s]),
            "Perm_linear_eqs_dropped": int(m - perm_pT[s]),
            "Perm_edges_in_T": int(perm_edgesT[s]),
            "GL_gain_extra_linear_eqs": int((m - gl_pT[s]) - (m - perm_pT[s])),
        })

    # Choose optimal s for fast OpenMP linearized cube test (e.g. s=14 -> 16,384 cubes in <0.5s!)
    # Particularly decisive for B1_11 (m=223, N=109)!
    chosen_s = cube_s_override if cube_s_override > 0 else (14 if m > 180 else 12)
    chosen_s = min(chosen_s, gl_vc_size, 30)
    lin_dropped, rem_quads = split_transformed_quads_for_s(t_quads, N, chosen_s)
    assert len(lin_dropped) == m - int(gl_pT[chosen_s]), \
        f"Expected {m - gl_pT[chosen_s]} linear drops, got {len(lin_dropped)}!"

    # Pack arrays for sweep_linearized_cubes_omp (runs 2^{chosen_s} cubes in milliseconds!)
    n_lin = len(lin_dropped)
    n_rem = len(rem_quads)
    t_vars = N - chosen_s

    def pack_poly_list_S_T(plist, include_UTT=False):
        k_len = len(plist)
        B_ST_T = (ctypes.c_uint64 * (max(1, k_len * chosen_s * 2)))()
        base_T = (ctypes.c_uint64 * (max(1, k_len * 2)))()
        quad_S = (ctypes.c_uint64 * (max(1, k_len * chosen_s)))()
        l_S = (ctypes.c_uint64 * max(1, k_len))()
        c_arr = (ctypes.c_uint8 * max(1, k_len))()
        U_TT = (ctypes.c_uint64 * (max(1, k_len * t_vars * 2)))() if include_UTT else None

        for k, qp in enumerate(plist):
            for term in qp:
                bc = term.bit_count()
                if bc == 0:
                    c_arr[k] ^= 1
                elif bc == 1:
                    v = term.bit_length() - 1
                    if v < chosen_s:
                        l_S[k] |= 1 << v
                    else:
                        tv = v - chosen_s
                        base_T[2 * k + (tv >> 6)] |= 1 << (tv & 63)
                elif bc == 2:
                    a = (term & -term).bit_length() - 1
                    b = (term ^ (1 << a)).bit_length() - 1
                    if b < chosen_s:
                        quad_S[k * chosen_s + a] |= 1 << b
                    elif a < chosen_s and b >= chosen_s:
                        tv = b - chosen_s
                        B_ST_T[(k * chosen_s + a) * 2 + (tv >> 6)] |= 1 << (tv & 63)
                    else:
                        assert include_UTT, "Unexpected T-quadratic term in lin_dropped!"
                        ta, tb = a - chosen_s, b - chosen_s
                        U_TT[(k * t_vars + ta) * 2 + (tb >> 6)] |= 1 << (tb & 63)
        return B_ST_T, base_T, quad_S, l_S, c_arr, U_TT

    l_bst, l_bt, l_qs, l_ls, l_c, _ = pack_poly_list_S_T(lin_dropped, include_UTT=False)
    r_bst, r_bt, r_qs, r_ls, r_c, r_utt = pack_poly_list_S_T(rem_quads, include_UTT=True)

    u_lin = ctypes.c_uint64(0)
    u_bf = ctypes.c_uint64(0)
    u_hard = ctypes.c_uint64(0)
    u_sol = ctypes.c_uint64(0)
    hard_list = (ctypes.c_uint64 * 4096)()

    t_sw = time.perf_counter()
    total_cubes = 1 << chosen_s
    lib_gl.sweep_linearized_cubes_omp(
        N, chosen_s, n_lin, l_bst, l_bt, l_qs, l_ls, l_c,
        n_rem, r_utt, r_bst, r_bt, r_qs, r_ls, r_c,
        0, total_cubes, 18,
        ctypes.byref(u_lin), ctypes.byref(u_bf), ctypes.byref(u_hard), ctypes.byref(u_sol),
        hard_list, 4096,
    )
    sw_sec = round(time.perf_counter() - t_sw, 4)

    closed_by_sweep = (u_hard.value == 0 and u_sol.value == 0)

    return {
        "cell": cell_name,
        "algebraic_has_one": False,
        "closed_unsat": bool(closed_by_sweep),
        "N_free_vars": N,
        "m_quad_eqs": m,
        "deg_pivs_111": deg_pivs,
        "gl_support_metrics": {
            "orig_union_edges": int(metrics_c[0]),
            "GL_union_edges": int(metrics_c[2]),
            "orig_total_quad_monomials": int(metrics_c[1]),
            "GL_total_quad_monomials": int(metrics_c[3]),
            "global_symplectic_radical_dim": int(metrics_c[4]),
            "GL_max_common_isotropic_dim": int(gl_iso_dim),
            "Perm_max_common_isotropic_dim": int(perm_iso_dim),
            "GL_simultaneous_vertex_cover_size": int(gl_vc_size),
            "Perm_simultaneous_vertex_cover_size": int(perm_vc_size),
            "GL_opt_sec": gl_sec,
        },
        "linearization_curve": curve_table,
        "omp_cube_sweep_benchmark": {
            "branched_s": chosen_s,
            "total_cubes": total_cubes,
            "induced_linear_eqs_per_cube": n_lin,
            "remaining_quad_eqs_per_cube": n_rem,
            "cubes_refuted_pure_linear_gauss": int(u_lin.value),
            "cubes_refuted_residual_bruteforce": int(u_bf.value),
            "hard_cubes_remaining": int(u_hard.value),
            "quad_variety_solutions_in_swept_cubes": int(u_sol.value),
            "sweep_sec": sw_sec,
        },
        "total_sec": round(time.perf_counter() - tc, 3),
    }


def main():
    t0 = time.perf_counter()
    target_arg = sys.argv[1].upper() if len(sys.argv) > 1 else "ALL"
    cube_s_arg = int(sys.argv[2]) if len(sys.argv) > 2 else 0

    work_dir = Path(__file__).resolve().parent
    lib_ext, lib_gl = compile_libs(work_dir)

    orbits = build_orbits_116()
    v6_list = all_v6_orbits()

    pair_idx, all_pairs = {}, []
    for v in range(256):
        for w in range(v + 1, 256):
            pair_idx[(v, w)] = len(all_pairs)
            all_pairs.append(v | (w << 8))

    seen_x = bytearray(65536)
    rot4_reps = []
    rep_of_x = [-1] * 65536
    for x in range(65536):
        if (x & 0xFF) == (x >> 8) or seen_x[x]:
            continue
        o4 = [x, rot16(x, 4), rot16(x, 8), rot16(x, 12)]
        r_idx = len(rot4_reps)
        rot4_reps.append(x)
        for y in o4:
            seen_x[y] = 1
            rep_of_x[y] = r_idx

    orb_diag, orb_pair, orb_r4 = [0] * 116, [0] * 116, [0] * 116
    orb_tts_point = [0] * 65536
    for j, orb in enumerate(orbits):
        for m in orb:
            sub_comp = 0xFFFF ^ m
            s = sub_comp
            while True:
                orb_tts_point[m | s] ^= 1 << j
                if s == 0:
                    break
                s = (s - 1) & sub_comp
        vd, vp, vr = 0, 0, 0
        for v in range(256):
            if (orb_tts_point[v | (v << 8)] >> j) & 1:
                vd |= 1 << v
        for k, x in enumerate(all_pairs):
            if (orb_tts_point[x] >> j) & 1:
                vp |= 1 << k
        for k, x in enumerate(rot4_reps):
            if (orb_tts_point[x] >> j) & 1:
                vr |= 1 << k
        orb_diag[j], orb_pair[j], orb_r4[j] = vd, vp, vr

    chi_r4 = sum((1 << k) for k, x in enumerate(rot4_reps) if x.bit_count() & 1)

    coset_0xf_reps = []
    vis16 = bytearray(65536)
    for x in range(65536):
        if vis16[x]:
            continue
        cur, mem = x, []
        while not vis16[cur]:
            vis16[cur] = 1
            mem.append(cur)
            cur = rot16(cur)
        if len(mem) == 16:
            vnib = (x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)
            if vnib == 0xF:
                coset_0xf_reps.append(mem[0])
    orb_0xf_parity = [
        sum(((orb_tts_point[x] >> j) & 1) for x in coset_0xf_reps) & 1
        for j in range(116)
    ]

    u8_size8, nonzero_z = build_c8_orbits()
    M_mod2_rows = []
    for z_rep, _ in nonzero_z:
        m_bits = 0
        for m_i, (_, a_orb) in enumerate(u8_size8):
            s_val = sum(-1 if ((a & z_rep).bit_count() & 1) else 1 for a in a_orb)
            if (s_val // 2) & 1:
                m_bits |= 1 << m_i
        M_mod2_rows.append(m_bits)
    null_z_vecs = gf2_nullspace_left(M_mod2_rows)

    n = 111
    col3_base = (ctypes.c_int * (n * n))()
    col3_list = []
    cur3 = 0
    for i in range(n):
        for j in range(i + 1, n):
            col3_base[i * n + j] = cur3
            for k in range(j + 1, n):
                col3_list.append((1 << i) | (1 << j) | (1 << k))
            cur3 += (n - 1 - j)
    n3 = len(col3_list)
    n2 = n * (n - 1) // 2
    off2 = n3
    pair2_col, pair2_list = {}, []
    for i in range(n):
        for j in range(i + 1, n):
            m_ij = (1 << i) | (1 << j)
            pair2_col[m_ij] = off2 + len(pair2_list)
            pair2_list.append(m_ij)

    precomp = {
        "orbits": orbits,
        "v6_list": v6_list,
        "pair_idx": pair_idx,
        "orb_diag": orb_diag,
        "orb_pair": orb_pair,
        "orb_r4": orb_r4,
        "chi_r4": chi_r4,
        "rep_of_x": rep_of_x,
        "orb_0xf_parity": orb_0xf_parity,
        "orb_tts_point": orb_tts_point,
        "u8_size8": u8_size8,
        "nonzero_z": nonzero_z,
        "null_z_vecs": null_z_vecs,
        "col3_base": col3_base,
        "col3_list": col3_list,
        "pair2_col": pair2_col,
        "pair2_list": pair2_list,
    }

    cell_map = {
        "B1_00": (1, 0, 0),
        "B1_11": (1, 1, 1),
        "B0_11": (0, 1, 1),
        "B0_00": (0, 0, 0),
    }
    targets = list(cell_map.values()) if target_arg == "ALL" else [cell_map[target_arg]]

    report = {"cells": {}}
    for c99_v, c57_v, c113_v in targets:
        res = analyze_and_solve_cell(c99_v, c57_v, c113_v, precomp, lib_ext, lib_gl, cube_s_arg)
        report["cells"][res["cell"]] = res
        print(f"=== {res['cell']} ===", flush=True)
        print(json.dumps(res, indent=2), flush=True)

    report["total_wall_sec"] = round(time.perf_counter() - t0, 3)
    out_file = work_dir / "b06_simultaneous_linearization_report.json"
    out_file.write_text(json.dumps(report, indent=2), encoding="utf-8")
    print(f"Saved full report to {out_file}", flush=True)


if __name__ == "__main__":
    main()

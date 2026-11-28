#!/usr/bin/env python3
"""
SOLVE_B111_S11_DEEP_AND_B011_IB8.py

Three-Job Pure-Algebraic Deepening & 8-Coset Tipo-Gamma Generator Extraction Engine:
  1. B111_S11_DEEP  : B1_11 (c99=1, force_k=1) e=1, Signature S11_E0_0 (-64, 64, -64, -64, 64; e0=0):
                      - Reconstructs the post-AC180 S11_E0_0 state (dim=100, quads=28, cubs=671, k_fix=22).
                      - Saturated Parseval Theorem: The 6 short cosets {0, 0xff, 0x55, 0x33, 0x11, 0x77}
                        all have |W_h(z)| = 64, accounting for 16 * 4096 = 65536 = 256^2 (100% of Parseval energy!),
                        which forces W_h(z) = 0 (wt(g_z) = 128, 100% balanced) on ALL 30 size-8 cosets!
                      - Stage A (Long-Coset Balanced Vanishing Ideals):
                        Uses embedded gf2id.c + WHT Proj(sr, z) on all unexplored size-8 cosets with projection rank
                        k <= 26 (starting with z=0x15 at k<=24 and the 7 rank-25 cosets 0x07,0x0b,0x0d,0x13,0x19,0x25,0x7f),
                        extracting exact deg<=2 (and deg<=3 minimal cubics when k<=22) vanishing ideals of {W_z = 0},
                        plus fibred pair ideals (0x55, 0x15) and (0x01, 0x15), Zero-Trust verified on random points!
                      - Stage B (Degree-3 Syzygy / Cubic Cancellation & Bilinear Pencil Reduction):
                        Extracts the exact (W, T, R_F) sheared system (s45b / s47b / s60b) on the 671+ cubics,
                        computes K_R quotient, V_00 pure-W equations, V_0 constant-coefficient Polar Left-Inverse,
                        NT2=0 zero-split Polar Left-Inverse, SysB degree-1 bilinear row augmentation, and Block-B
                        quadratic r_i*r_j feedback, lifts any pure-(W,T) degree-<=3 equations back to 111-var s9 rows
                        (Zero-Trust verified against planted/random solutions!), and re-runs s9 XL + AC180 + W_ess!
  2. B011_IB_E3_GP  : B0_11 (c99=0, force_k=-1 C5-free) Class I-B rep e=3 x Tipo gamma+ (h=2):
                      - Exact 8-coset generator extraction via embedded gf2id.c + paircoord + jointset + C/OpenMP
                        factored cubic expander:
                        * 2-coset (0xff, 0x55) = (0, 64) ideal (d=3)
                        * 4-coset fibred join Q = (0x55, 0x33, 0x11, 0x77) = (64, 0, +32, -32) (d=2, 3 + minimal cubics)
                        * Size-8 cosets z = 0x01 (d=2, 3 + minimal), z = 0x15 (d=2, 3 if k<=24), z in (0x0f, 0x2d) (d=2)
                      - Zero-Trust verifies all generators on fiber points matching the coset targets, expands cubics
                        directly into s9 uint64_t rows via C/OpenMP (0 pivot leaks, 64-pt ZT check), runs s9 + AC180 +
                        sheared pencil/Block-B audit + W_ess MinRank measurement!
  3. B011_IB_E3_GM  : Same 8-coset pipeline on B0_11 Class I-B rep e=3 x Tipo gamma- (h=6: W_11=-32, W_77=+32).
"""

import argparse
import ctypes
import json
import os
import random
import struct
import subprocess
import sys
import tempfile
import time
from pathlib import Path
import numpy as np

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP43A_ETA_INVARIANCE_AND_ITERATED_POLAR as s43a
import SOLVE_STEP44A_ITERATED_POLAR_TOWER as s44a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b
import SOLVE_STEP47B_ITERATIVE_SYSB_CASCADE as s47b
import SOLVE_STEP60B_BLOCKB_BLOCKD_ALGEBRAIC_FEEDBACK as s60b
import SOLVE_STEP60C_DEG4_V13_WALSH_XL as s60c
import SOLVE_STEP63A_EXACT_AUTOCORR_PARSEVAL_MOD32_64 as s63a
import SOLVE_STEP64A_AC180_MAC3_FUSION as s64a
import SOLVE_B111_B011_POISSON_ALGEBRA as spois
import SOLVE_B111_SIG_INJECT as ssig


# =============================================================================
# 1. EMBEDDED gf2id.c (EXACT DEGREE <= d VANISHING IDEAL EXTRACTOR, MODES 0 & 1)
# =============================================================================

GF2ID_C_SRC = r"""
/* gf2id: exact degree <= d vanishing ideal of a finite point set in F_2^k (k <= 64).
   mode 0: explicit list of points (all verified);
   mode 1: fibred product U_y A_y x B_y (pairs of coset projections sharing common y). */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

typedef uint64_t u64;
static int K, D, COLS, WD;
static long long BIN[65][6];
static int OFF[6];

static inline long long C(int n, int r) { return (r < 0 || n < r) ? 0 : BIN[n][r]; }

static void init_idx(int k, int d) {
    for (int n = 0; n <= 64; n++) {
        BIN[n][0] = 1;
        for (int r = 1; r < 6; r++) BIN[n][r] = n ? BIN[n - 1][r - 1] + BIN[n - 1][r] : 0;
    }
    OFF[0] = 0;
    for (int r = 1; r <= d + 1; r++) OFF[r] = OFF[r - 1] + (int)C(k, r - 1);
    COLS = OFF[d + 1];
}

static int SUB[250000];
static int subsets(u64 x, int d) {
    int s[64], w = 0;
    while (x) { s[w++] = __builtin_ctzll(x); x &= x - 1; }
    int n = 0;
    SUB[n++] = 0;
    if (d >= 1) for (int i = 0; i < w; i++) {
        SUB[n++] = OFF[1] + s[i];
        if (d >= 2) for (int j = i + 1; j < w; j++) {
            int b2 = OFF[2] + s[i] + (int)C(s[j], 2);
            SUB[n++] = b2;
            if (d >= 3) for (int l = j + 1; l < w; l++) {
                int b3 = OFF[3] + s[i] + (int)C(s[j], 2) + (int)C(s[l], 3);
                SUB[n++] = b3;
                if (d >= 4) for (int m = l + 1; m < w; m++) {
                    SUB[n++] = OFF[4] + s[i] + (int)C(s[j], 2) + (int)C(s[l], 3) + (int)C(s[m], 4);
                }
            }
        }
    }
    return n;
}

static u64 mono_mask(int idx) {
    int r = 0;
    while (r < D && idx >= OFF[r + 1]) r++;
    long long t = idx - OFF[r];
    u64 m = 0;
    for (int j = r; j >= 1; j--) {
        int v = j - 1;
        while (C(v + 1, j) <= t) v++;
        m |= 1ULL << v;
        t -= C(v, j);
    }
    return m;
}

static u64 *B;
static int *PIV;
static int RANK;

static int insert_row(u64 *r) {
    for (int w = 0; w < WD; w++) {
        while (r[w]) {
            int p = w * 64 + __builtin_ctzll(r[w]);
            if (PIV[p] < 0) {
                memcpy(B + (size_t)RANK * WD, r, (size_t)WD * 8);
                PIV[p] = RANK++;
                return 1;
            }
            u64 *b = B + (size_t)PIV[p] * WD;
            for (int q = w; q < WD; q++) r[q] ^= b[q];
        }
    }
    return 0;
}

static void row_of(u64 x, u64 *r) {
    memset(r, 0, (size_t)WD * 8);
    int n = subsets(x, D);
    for (int i = 0; i < n; i++) r[SUB[i] >> 6] |= 1ULL << (SUB[i] & 63);
}

static u64 *T;
static int NN, NW;
static int *FREECOL;

static void build_null(void) {
    for (int p = 0; p < COLS; p++) if (PIV[p] >= 0) {
        u64 *rp = B + (size_t)PIV[p] * WD;
        for (int q = 0; q < p; q++) if (PIV[q] >= 0) {
            u64 *rq = B + (size_t)PIV[q] * WD;
            if ((rq[p >> 6] >> (p & 63)) & 1) {
                for (int w = 0; w < WD; w++) rq[w] ^= rp[w];
            }
        }
    }
    NN = 0;
    free(FREECOL);
    FREECOL = (int *)malloc(sizeof(int) * (size_t)COLS);
    int *fidx = (int *)malloc(sizeof(int) * (size_t)COLS);
    for (int c = 0; c < COLS; c++) {
        fidx[c] = -1;
        if (PIV[c] < 0) { fidx[c] = NN; FREECOL[NN++] = c; }
    }
    NW = (NN + 63) / 64;
    if (NW == 0) NW = 1;
    free(T);
    T = (u64 *)calloc((size_t)COLS * (size_t)NW, 8);
    for (int c = 0; c < COLS; c++) {
        if (PIV[c] < 0) {
            int f = fidx[c];
            T[(size_t)c * NW + (f >> 6)] |= 1ULL << (f & 63);
        } else {
            u64 *rp = B + (size_t)PIV[c] * WD;
            for (int f = 0; f < NN; f++) {
                int fc = FREECOL[f];
                if ((rp[fc >> 6] >> (fc & 63)) & 1) {
                    T[(size_t)c * NW + (f >> 6)] |= 1ULL << (f & 63);
                }
            }
        }
    }
    free(fidx);
}

static int check_point(u64 x) {
    if (NN == 0) return 0;
    u64 acc[4096];
    memset(acc, 0, (size_t)NW * 8);
    int n = subsets(x, D);
    for (int i = 0; i < n; i++) {
        u64 *t = T + (size_t)SUB[i] * NW;
        for (int w = 0; w < NW; w++) acc[w] ^= t[w];
    }
    for (int w = 0; w < NW; w++) if (acc[w]) return 1;
    return 0;
}

static u64 rng = 0x9E3779B97F4A7C15ULL;
static inline u64 rnd(void) { rng ^= rng << 13; rng ^= rng >> 7; rng ^= rng << 17; return rng; }

static void span_select(u64 *pts, long long n, char *sel) {
    u64 row[4096];
    for (int i = 0; i < COLS; i++) PIV[i] = -1;
    RANK = 0; NN = 0;
    if (n <= 2 * COLS) {
        for (long long i = 0; i < n; i++) { row_of(pts[i], row); sel[i] = (char)insert_row(row); }
        return;
    }
    int dep = 0;
    while (dep < 3000 && RANK < COLS) {
        long long i = (long long)(rnd() % (u64)n);
        row_of(pts[i], row);
        if (insert_row(row)) { sel[i] = 1; dep = 0; } else dep++;
    }
    if (RANK == COLS) return;
    build_null();
    int pend = 0;
    for (long long i = 0; i < n; i++) if (!sel[i] && check_point(pts[i])) {
        row_of(pts[i], row);
        if (insert_row(row)) {
            sel[i] = 1;
            if (++pend >= 256) { build_null(); pend = 0; }
        }
    }
}

typedef struct { uint32_t y, a; } rec;

static rec *reduce_groups(rec *R, long long n, int kv, int d, long long *nout) {
    int sK = K, sD = D, sC = COLS, sW = WD;
    init_idx(kv, d); K = kv; D = d; WD = (COLS + 63) / 64;
    u64 *sB = B; int *sP = PIV, sR = RANK; u64 *sT = T; int sNN = NN, sNW = NW; int *sF = FREECOL;
    T = NULL; FREECOL = NULL;
    B = (u64 *)malloc((size_t)COLS * (size_t)WD * 8);
    PIV = (int *)malloc(sizeof(int) * (size_t)COLS);
    rec *out = (rec *)malloc(sizeof(rec) * (size_t)(n + 1));
    long long m = 0;
    u64 *pts = (u64 *)malloc(8 * (size_t)(n + 1));
    char *sel = (char *)malloc((size_t)(n + 1));
    for (long long i = 0; i < n;) {
        long long j = i;
        while (j < n && R[j].y == R[i].y) j++;
        for (long long t = i; t < j; t++) { pts[t - i] = R[t].a; sel[t - i] = 0; }
        span_select(pts, j - i, sel);
        for (long long t = i; t < j; t++) if (sel[t - i]) out[m++] = R[t];
        i = j;
    }
    free(pts); free(sel); free(B); free(PIV); free(T); free(FREECOL);
    B = sB; PIV = sP; RANK = sR; T = sT; NN = sNN; NW = sNW; FREECOL = sF;
    K = sK; D = sD; init_idx(K, D); COLS = sC; WD = sW;
    *nout = m;
    return out;
}

int main(int argc, char **argv) {
    if (argc < 3) { fprintf(stderr, "usage: gf2id in out\n"); return 1; }
    FILE *f = fopen(argv[1], "rb");
    if (!f) return 1;
    int mode = 0, k = 0, d = 0;
    if (fread(&mode, 4, 1, f) != 1) return 1;
    if (fread(&k, 4, 1, f) != 1) return 1;
    if (fread(&d, 4, 1, f) != 1) return 1;
    u64 *P = NULL; long long np = 0;
    rec *A = NULL, *Bg = NULL; long long nA = 0, nB = 0;
    int c = 0, ka = 0, kb = 0;
    long long *ga = NULL, *gb = NULL; int ng = 0; uint32_t *gy = NULL;
    long long *gbstart = NULL, *gbend = NULL;
    if (mode == 0) {
        if (fread(&np, 8, 1, f) != 1) return 1;
        P = (u64 *)malloc(8 * (size_t)(np + 1));
        if (np > 0 && fread(P, 8, (size_t)np, f) != (size_t)np) return 1;
    } else {
        if (fread(&c, 4, 1, f) != 1) return 1;
        if (fread(&ka, 4, 1, f) != 1) return 1;
        if (fread(&kb, 4, 1, f) != 1) return 1;
        if (fread(&nA, 8, 1, f) != 1) return 1;
        A = (rec *)malloc(sizeof(rec) * (size_t)(nA + 1));
        if (nA > 0 && fread(A, sizeof(rec), (size_t)nA, f) != (size_t)nA) return 1;
        if (fread(&nB, 8, 1, f) != 1) return 1;
        Bg = (rec *)malloc(sizeof(rec) * (size_t)(nB + 1));
        if (nB > 0 && fread(Bg, sizeof(rec), (size_t)nB, f) != (size_t)nB) return 1;
    }
    fclose(f);
    if (mode == 0 && np == 0) {
        FILE *o = fopen(argv[2], "w"); fprintf(o, "VAZIO\n"); fclose(o); return 0;
    }
    K = k; D = d; init_idx(K, D);
    if (mode == 1) {
        long long mA = 0, mB = 0;
        rec *A2 = reduce_groups(A, nA, ka, d, &mA);
        rec *B2 = reduce_groups(Bg, nB, kb, d, &mB);
        free(A); free(Bg); A = A2; Bg = B2; nA = mA; nB = mB;
        ga = (long long *)malloc(sizeof(long long) * (size_t)(nA + 1));
        gy = (uint32_t *)malloc(4 * (size_t)(nA + 1));
        gbstart = (long long *)malloc(8 * (size_t)(nA + 1));
        gbend = (long long *)malloc(8 * (size_t)(nA + 1));
        long long *gaend = (long long *)malloc(8 * (size_t)(nA + 1));
        long long jb = 0;
        for (long long i = 0; i < nA;) {
            long long j = i;
            while (j < nA && A[j].y == A[i].y) j++;
            while (jb < nB && Bg[jb].y < A[i].y) jb++;
            long long kb2 = jb;
            while (kb2 < nB && Bg[kb2].y == A[i].y) kb2++;
            if (kb2 > jb) {
                ga[ng] = i; gaend[ng] = j; gy[ng] = A[i].y; gbstart[ng] = jb; gbend[ng] = kb2; ng++;
            }
            i = j;
        }
        gb = gaend;
        long long tot = 0;
        for (int g = 0; g < ng; g++) tot += (gb[g] - ga[g]) * (gbend[g] - gbstart[g]);
        fprintf(stderr, "mode1: c=%d ka=%d kb=%d ng=%d |A_red|=%lld |B_red|=%lld gen_pts=%lld\n", c, ka, kb, ng, nA, nB, tot);
        if (ng == 0) {
            FILE *o = fopen(argv[2], "w"); fprintf(o, "VAZIO\n"); fclose(o); return 0;
        }
    }
    WD = (COLS + 63) / 64;
    B = (u64 *)malloc((size_t)COLS * (size_t)WD * 8);
    PIV = (int *)malloc(sizeof(int) * (size_t)COLS);
    for (int i = 0; i < COLS; i++) PIV[i] = -1;
    RANK = 0;
    u64 row[4096];
    #define JOINT(g, ia, ib) ((u64)gy[g] | ((u64)A[ia].a << c) | ((u64)Bg[ib].a << (c + ka)))
    int dep = 0; long long used = 0;
    while (dep < 3000 && RANK < COLS) {
        u64 x;
        if (mode == 0) { if (used >= np) break; x = P[rnd() % (u64)np]; }
        else {
            int g = (int)(rnd() % (u64)ng);
            long long ia = ga[g] + (long long)(rnd() % (u64)(gb[g] - ga[g]));
            long long ib = gbstart[g] + (long long)(rnd() % (u64)(gbend[g] - gbstart[g]));
            x = JOINT(g, ia, ib);
        }
        used++; row_of(x, row);
        if (insert_row(row)) dep = 0; else dep++;
        if (mode == 0 && np <= 2 * COLS && used >= np) break;
    }
    if (mode == 0 && np <= 2 * COLS) {
        for (long long i = 0; i < np; i++) { row_of(P[i], row); insert_row(row); }
    }
    build_null(); int nn0 = NN;
    int noverify = (argc > 3 && strcmp(argv[3], "noverify") == 0);
    long long fails = 0, checked = 0; int pend = 0;
    #define CHECK(x) do { checked++; if (check_point(x)) { fails++; row_of(x, row); if (insert_row(row)) { pend++; if (pend >= 256) { build_null(); pend = 0; } } } } while (0)
    if (!noverify) {
        if (mode == 0) { for (long long i = 0; i < np; i++) CHECK(P[i]); }
        else {
            for (int g = 0; g < ng; g++)
                for (long long ia = ga[g]; ia < gb[g]; ia++)
                    for (long long ib = gbstart[g]; ib < gbend[g]; ib++)
                        CHECK(JOINT(g, ia, ib));
        }
    }
    if (pend) build_null();
    fprintf(stderr, "verify: pts=%lld fails=%lld rank=%d null=%d (init %d)\n", checked, fails, RANK, NN, nn0);
    FILE *o = fopen(argv[2], "w");
    fprintf(o, "%d %d %d\n", COLS, RANK, NN);
    for (int fi = 0; fi < NN; fi++) {
        int fc = FREECOL[fi];
        fprintf(o, "%llx", (unsigned long long)mono_mask(fc));
        for (int p = 0; p < COLS; p++) if (PIV[p] >= 0) {
            u64 *rp = B + (size_t)PIV[p] * WD;
            if ((rp[fc >> 6] >> (fc & 63)) & 1) fprintf(o, " %llx", (unsigned long long)mono_mask(p));
        }
        fprintf(o, "\n");
    }
    fclose(o);
    return 0;
}
"""


def compile_gf2id_exe():
    c_path = WORK_DIR / "gf2id_gen.c"
    exe_name = "gf2id_gen.exe" if os.name == "nt" else "gf2id_gen"
    exe_path = WORK_DIR / exe_name
    c_path.write_text(GF2ID_C_SRC, encoding="utf-8")
    subprocess.run(
        ["gcc", "-O3", "-march=native", str(c_path), "-o", str(exe_path)],
        check=True,
    )
    return str(exe_path)


def parse_gf2id_out(out_path):
    txt = Path(out_path).read_text(encoding="utf-8").strip().splitlines()
    if not txt or txt[0].startswith("VAZIO"):
        return {"empty": True, "cols": 0, "rank": 0, "null": 0, "polys": []}
    cols, rk, nn = map(int, txt[0].split())
    polys = [[int(t, 16) for t in line.split()] for line in txt[1:] if line.strip()]
    return {"empty": False, "cols": cols, "rank": rk, "null": nn, "polys": polys}


def ideal_points(exe_path, pts, k, d, tag="p"):
    pts_arr = np.asarray(pts, dtype=np.uint64)
    if len(pts_arr) == 0:
        return {"empty": True, "cols": 0, "rank": 0, "null": 0, "polys": []}, "EMPTY_PTS"
    with tempfile.TemporaryDirectory() as td:
        fn = os.path.join(td, f"gfi_{tag}.bin")
        out = fn + ".out"
        with open(fn, "wb") as f:
            f.write(struct.pack("iii", 0, int(k), int(d)))
            f.write(struct.pack("q", len(pts_arr)))
            f.write(pts_arr.tobytes())
        r = subprocess.run([exe_path, fn, out], capture_output=True, text=True, check=True)
        return parse_gf2id_out(out), r.stderr.strip()


def ideal_fibred(exe_path, Arecs, Brecs, c, ka, kb, d, tag="f", noverify=False):
    A = np.asarray(Arecs, dtype=np.uint32)
    B = np.asarray(Brecs, dtype=np.uint32)
    if len(A) == 0 or len(B) == 0:
        return {"empty": True, "cols": 0, "rank": 0, "null": 0, "polys": []}, "EMPTY_AB"
    A = A[np.lexsort((A[:, 1], A[:, 0]))]
    B = B[np.lexsort((B[:, 1], B[:, 0]))]
    with tempfile.TemporaryDirectory() as td:
        fn = os.path.join(td, f"gfi_{tag}.bin")
        out = fn + ".out"
        with open(fn, "wb") as f:
            f.write(struct.pack("iii", 1, int(c + ka + kb), int(d)))
            f.write(struct.pack("iii", int(c), int(ka), int(kb)))
            f.write(struct.pack("q", len(A)))
            f.write(A.tobytes())
            f.write(struct.pack("q", len(B)))
            f.write(B.tobytes())
        cmd = [exe_path, fn, out] + (["noverify"] if noverify else [])
        r = subprocess.run(cmd, capture_output=True, text=True, check=True)
        return parse_gf2id_out(out), r.stderr.strip()


# =============================================================================
# 2. WHT COSET PROJECTION (Proj), PAIRCOORDS, FIBRED JOIN & MINIMAL CUBIC FILTER
# =============================================================================

def wht_int32(a):
    a = a.copy()
    n = a.shape[0]
    h = 1
    while h < n:
        a = a.reshape(-1, 2, h)
        x = a[:, 0, :].copy()
        a[:, 0, :] += a[:, 1, :]
        a[:, 1, :] = x - a[:, 1, :]
        a = a.reshape(n)
        h *= 2
    return a


class CosetProj:
    """
    Exact WHT Coset Projection for a polar coset A_z = {(u, u+z) : u in F_2^8} on an s9 state:
      g_z(u) = base(u) ^ sum_{j=0}^{k-1} m_j D_j(u),
    where m_j = <rows[j], x_free> (rows[j] is a bitmask over positions 0..len(free)-1,
    and forms[j] is the list of 111-var indices in free).
    Computes W(m) = W_h(z)(m) for all 2^k states m in 0..2^k-1 via a single 2^k WHT!
    """
    def __init__(self, orig_f, basis_f, free_vars, z, max_wht_k=26):
        idx_z = np.array([u | ((u ^ z) << 8) for u in range(256)], dtype=np.int32)
        base = orig_f[idx_z].astype(np.uint8)
        dirs = basis_f[:, idx_z].astype(np.uint8)
        nf = len(free_vars)

        def row_to_int256(r_idx):
            v = 0
            row = dirs[r_idx]
            for b in range(256):
                if int(row[b]):
                    v |= 1 << b
            return v

        piv = {}
        rows_256 = []
        sel = []
        for i in range(nf):
            v = row_to_int256(i)
            w = v
            t = 1 << len(rows_256)
            indep = False
            while w:
                p = w.bit_length() - 1
                if p not in piv:
                    piv[p] = (w, t)
                    indep = True
                    break
                w2, t2 = piv[p]
                w ^= w2
                t ^= t2
            if indep:
                rows_256.append(v)
                sel.append(i)

        def coords(v):
            t = 0
            while v:
                p = v.bit_length() - 1
                w2, t2 = piv[p]
                v ^= w2
                t ^= t2
            return t

        A = [coords(row_to_int256(i)) for i in range(nf)]
        k = len(sel)
        self.z = z
        self.k = k
        self.nf = nf
        self.free = list(free_vars)
        # rows[j]: bitmask over 0..nf-1
        self.rows = [sum(1 << i for i in range(nf) if (A[i] >> j) & 1) for j in range(k)]
        # forms[j]: list of 111-var indices
        self.forms = [[self.free[i] for i in range(nf) if (A[i] >> j) & 1] for j in range(k)]
        self.base = base
        self.D = dirs[sel].astype(np.int64)
        self.W = None
        if k <= max_wht_k:
            col = (self.D * (1 << np.arange(k, dtype=np.int64))[:, None]).sum(0)
            F = np.zeros(1 << k, dtype=np.int32)
            np.add.at(F, col, 1 - 2 * base.astype(np.int32))
            self.W = wht_int32(F)


def _par_vec(m, mask):
    v = np.bitwise_and(m, int(mask)).astype(np.uint64)
    v ^= v >> 32
    v ^= v >> 16
    v ^= v >> 8
    v ^= v >> 4
    v ^= v >> 2
    v ^= v >> 1
    return (v & 1).astype(np.int64)


def pair_coords(P1, P2, free_vars):
    R1, R2 = P1.rows, P2.rows
    k1, k2 = len(R1), len(R2)
    vecs = [(r, 1 << j) for j, r in enumerate(R1)] + [(r, 1 << (k1 + j)) for j, r in enumerate(R2)]
    piv = {}
    ker = []
    for r, t in vecs:
        while r:
            p = r.bit_length() - 1
            if p not in piv:
                piv[p] = (r, t)
                break
            r2, t2 = piv[p]
            r ^= r2
            t ^= t2
        if r == 0:
            ker.append(t)
    b1 = [t & ((1 << k1) - 1) for t in ker]
    b2 = [t >> k1 for t in ker]
    c = len(ker)
    Cf = []
    for bb in b1:
        f = 0
        for j in range(k1):
            if (bb >> j) & 1:
                f ^= R1[j]
        Cf.append(f)

    def complete(R, base_rows):
        sp = list(base_rows)
        sel = []

        def indep(v, S):
            pv = {}
            for w in S + [v]:
                x = w
                while x:
                    p = x.bit_length() - 1
                    if p not in pv:
                        pv[p] = x
                        break
                    x ^= pv[p]
                if x == 0 and w is v:
                    return False
            return True

        for j, r in enumerate(R):
            if indep(r, sp):
                sp.append(r)
                sel.append(j)
        return sel

    s1 = complete(R1, Cf)
    s2 = complete(R2, Cf)
    assert len(s1) == k1 - c and len(s2) == k2 - c
    rows = Cf + [R1[j] for j in s1] + [R2[j] for j in s2]
    nf = len(free_vars)
    forms_111 = [[free_vars[i] for i in range(nf) if (r >> i) & 1] for r in rows]

    def tr(m, bb, sel):
        m = np.asarray(m, dtype=np.int64)
        y = np.zeros(len(m), dtype=np.int64)
        a = np.zeros(len(m), dtype=np.int64)
        for i, b in enumerate(bb):
            y |= _par_vec(m, b) << i
        for i, j in enumerate(sel):
            a |= ((m >> j) & 1) << i
        return y, a

    return {
        "c": c,
        "ka": k1 - c,
        "kb": k2 - c,
        "rows": rows,
        "forms_111": forms_111,
        "tr1": lambda m: tr(m, b1, s1),
        "tr2": lambda m: tr(m, b2, s2),
    }


class JointSet:
    def __init__(self, rows, pts, free_vars):
        self.rows = list(rows)
        self.k = len(rows)
        self.pts = np.asarray(pts, dtype=np.int64)
        nf = len(free_vars)
        self.forms = [[free_vars[i] for i in range(nf) if (r >> i) & 1] for r in self.rows]


def from_proj(P, target_w):
    pts = np.flatnonzero(P.W == target_w).astype(np.int64)
    return JointSet(P.rows, pts, P.free)


def combine_js(J1, J2, free_vars, limit=60_000_000):
    pc = pair_coords(J1, J2, free_vars)
    c, ka, kb = pc["c"], pc["ka"], pc["kb"]
    if len(J1.pts) == 0 or len(J2.pts) == 0:
        return JointSet(pc["rows"], np.zeros(0, dtype=np.int64), free_vars), pc, 0
    y1, a1 = pc["tr1"](J1.pts)
    y2, b2 = pc["tr2"](J2.pts)
    o1 = np.argsort(y1, kind="stable")
    o2 = np.argsort(y2, kind="stable")
    y1, a1 = y1[o1], a1[o1]
    y2, b2 = y2[o2], b2[o2]
    u1, s1, n1 = np.unique(y1, return_index=True, return_counts=True)
    u2, s2, n2 = np.unique(y2, return_index=True, return_counts=True)
    com, i1, i2 = np.intersect1d(u1, u2, return_indices=True)
    tot = int((n1[i1].astype(np.int64) * n2[i2]).sum())
    if tot > limit:
        return None, pc, tot
    out = np.empty(tot, dtype=np.int64)
    p = 0
    for y, j1, j2 in zip(com, i1, i2):
        A = a1[s1[j1]:s1[j1] + n1[j1]]
        B = b2[s2[j2]:s2[j2] + n2[j2]]
        blk = (y | (A[:, None] << c) | (B[None, :] << (c + ka))).ravel()
        out[p:p + len(blk)] = blk
        p += len(blk)
    return JointSet(pc["rows"], out, free_vars), pc, tot


def _mul_poly_mask(p, m):
    out = {}
    for t in p:
        u = t | m
        out[u] = out.get(u, 0) ^ 1
    return [u for u, v in out.items() if v]


def filter_minimal_cubics_masks(R2_polys, R3_polys, k):
    """
    Given R2_polys (deg <= 2 masks) and R3_polys (deg <= 3 masks) in k variables,
    returns (R2_polys, min_cubics_masks) where min_cubics_masks is a basis of
    I_3 / (I_<=2 + sum_{i=0}^{k-1} y_i I_<=2).
    """
    piv = {}
    idx = {}

    def vec(p):
        v = 0
        for m in p:
            v ^= 1 << idx.setdefault(m, len(idx))
        return v

    def add(v):
        while v:
            q = v.bit_length() - 1
            if q not in piv:
                piv[q] = v
                return True
            v ^= piv[q]
        return False

    for p in R2_polys:
        add(vec(p))
    for p in R2_polys:
        for i in range(k):
            add(vec(_mul_poly_mask(p, 1 << i)))
    mins = [p for p in R3_polys if add(vec(p))]
    return list(R2_polys), mins


def poly_masks_to_compact_cubics(poly_masks_list):
    """
    Convert a list of y-polynomials (each a list of int bitmasks over 0..K-1)
    into compact format [[j_1, ...], ...] expected by ssig.expand_compact_block_to_c_rows.
    """
    out = []
    for pm in poly_masks_list:
        poly = []
        for mm in pm:
            mono = [j for j in range(mm.bit_length()) if (mm >> j) & 1]
            poly.append(mono)
        if poly:
            out.append(poly)
    return out


def lift_le2_poly_masks_to_psets(poly_masks_list, forms_111):
    """
    Lift degree <= 2 polynomials in y-coordinates (bitmasks over 0..K-1) directly to 111-var s9 psets!
    Fast and exact because every monomial has degree <= 2 in y.
    """
    form_masks = []
    for f_vars in forms_111:
        fm = 0
        for v in f_vars:
            fm ^= 1 << int(v)
        form_masks.append(fm)

    # Precompute pairwise products F_{j1}(x) * F_{j2}(x) as 111-var psets
    K = len(forms_111)
    pair_psets = {}
    for j1 in range(K):
        vars1 = forms_111[j1]
        for j2 in range(j1 + 1, K):
            vars2 = forms_111[j2]
            ps = set()
            for u in vars1:
                mu = 1 << int(u)
                for v in vars2:
                    m = mu | (1 << int(v))
                    if m in ps:
                        ps.remove(m)
                    else:
                        ps.add(m)
            pair_psets[(j1, j2)] = ps

    psets_lin = []
    psets_quad = []
    for pm in poly_masks_list:
        c0 = 0
        l_mask = 0
        ps_q = set()
        for mm in pm:
            deg = mm.bit_count()
            if deg == 0:
                c0 ^= 1
            elif deg == 1:
                j = mm.bit_length() - 1
                l_mask ^= form_masks[j]
            elif deg == 2:
                j1 = (mm & -mm).bit_length() - 1
                j2 = (mm >> (j1 + 1)).bit_length() + j1
                ps_q ^= pair_psets[(j1, j2)]
            else:
                raise ValueError(f"Expected deg <= 2 in lift_le2_poly_masks_to_psets, got mask {hex(mm)}")
        # Combine c0 and l_mask into ps_q
        ps = set(ps_q)
        if c0:
            ps ^= {0}
        tmp = l_mask
        while tmp:
            lb = tmp & -tmp
            ps ^= {lb}
            tmp ^= lb
        if not ps:
            continue
        max_d = max((0 if m == 0 else m.bit_count()) for m in ps)
        if max_d <= 1:
            psets_lin.append(ps)
        else:
            psets_quad.append(ps)
    return psets_lin, psets_quad


# =============================================================================
# 3. DEGREE-3 SYZYGY / CUBIC CANCELLATION & BILINEAR PENCIL -> 111-VAR LIFTING
# =============================================================================

def eval_pset_111(pset, x111):
    res = 0
    for m in pset:
        if (x111 & m) == m:
            res ^= 1
    return res


def lift_sheared_wt_poly_to_111_pset(wt_monomials, c0_bit, W_pivs, T_pivs, W_rref, T_rref, lib_exp, lib9, tbl, lin_pivs):
    """
    Given a polynomial in sheared (W, T) coordinates:
      P(w, t) = c0_bit ^ sum_{tuple in wt_monomials} prod_{idx in tuple} Z_{idx},
    where Z_0..Z_{nW-1} = w_0..w_{nW-1} and Z_{nW}..Z_{nW+nT-1} = t_0..t_{nT-1},
    and each w_k = <W_rref[W_pivs[k]], x>, t_a = <T_rref[T_pivs[a]], x> is a homogeneous
    linear form in the active 111-bit variables x:
    Uses our C/OpenMP factored cubic expander to expand P(w, t) into exact 111-var s9 uint64_t rows!
    """
    nW = len(W_pivs)
    formas = []
    for p in W_pivs:
        m = W_rref[p]
        formas.append([b for b in range(111) if (m >> b) & 1])
    for q in T_pivs:
        m = T_rref[q]
        formas.append([b for b in range(111) if (m >> b) & 1])

    poly = [list(tup) for tup in wt_monomials]
    if c0_bit:
        poly.append([])
    if not poly:
        return None
    return formas, poly


def run_cubic_syzygy_and_pencil_reduction(tag, sr_in, env, libs, lib_exp, rng_seed=14100):
    """
    On an arbitrary s9 state `sr_in` (such as B1_11 e=1 S11_E0_0 with dim=100, quads=28, cubs=671,
    or B0_11 e=3 after 8-coset gamma injection):
      1. Extracts the exact sheared (W, T, R_F) decomposition (s60b.extract_full_blocks with eta_free=[]):
         - Shears all quads + cubics by W_rref and T_rref.
         - Solves t_a = Q_a(w) from the sheared quadratics and extracts any pure-W quadratics.
         - Echelonizes all sheared equations in (3 - drf, 3 - dt_c, 3 - d, c) order into:
             * P0_psets       (drf == 0: pure-(W, T) degree-<=3 syzygies from cubic cancellation!)
             * M1_strict_psets (drf == 1, deg_W <= 1, deg_T == 0: strictly bilinear pencil (M0 + sum w_k Mk) r_F = b(w,t))
             * Block_A3_psets (drf == 1, w_a w_b r_j)
             * Block_D2_psets (drf == 1, t_a r_j)
             * Block_D3_psets (drf == 1, w_a t_b r_j / t_a t_b r_j)
             * Block_B_psets  (drf == 2, constant r_i r_j quadratics + drf<=1 tail)
             * Other_psets    (drf >= 2 with W/T or drf == 3)
      2. Runs the exact global (NT = 0, full W-space) Bilinear Pencil Syzygy & Reduction Cascade:
         - K_R right-kernel quotient (L_core = left nullspace of M0 @ K_R^T),
         - V_00 = left nullspace of [M0 | M_1 | ... | M_{nW}] (exact pure-(W,T) degree-<=3 equations!),
         - V_0 constant-coefficient Polar Left-Inverse (eliminating r_elim = rank(V_0 M_0) R_F variables at NT=0!),
         - NT2=0 Zero-Split Polar Left-Inverse (s47b.try_zero_split_polar_step),
         - System B degree-1 bilinear row augmentation (v_j^T M_k + v_k^T M_j = 0 -> new degree-<=3 rows!),
         - Un-quotiented Block-B (r_i r_j) + Fiber-Linearized (A3 + D2) feedback (s60b.extract_fiber_linearized_drf1
           + s60b.run_blockb_feedback_cascade at full d1 = nW, U1 = I_{nW}, t1 = 0)!
      3. Any new pure-(W, T) degree-<=3 equations discovered from:
         - V_00 at root (v^T M1_strict == 0 in R_F, leaving v^T b_strict(w, t) == 0 of degree <= 3!),
         - V_0 Polar elimination followed by V_00 on rows where L @ b_strict(w, t) has degree <= 2,
         - Linearized (A3 + D2) left-kernel rows where t_a = Q_a(w) substitution keeps degree <= 3,
         are lifted back to 111-var s9 rows via C/OpenMP `expand_compact_block_to_c_rows` (Zero-Trust verified!)
         and injected into `sr_in`!
    """
    t0 = time.perf_counter()
    lib_diag, lib9, lib_cg, lib_sh, lib_ac, lib_d4, lib63 = libs
    tbl = env["tbl"]
    if sr_in["closed_unsat"]:
        return sr_in, {"closed_unsat": True}

    blk = s60b.extract_full_blocks(0, sr_in, [], lib9, lib_sh, tbl, rng_seed=rng_seed)
    if blk.get("closed_unsat"):
        return {"closed_unsat": True, "_lin_pivs": dict(sr_in["_lin_pivs"]), "_quad_ids": [], "_cub_ids": []}, {"closed_unsat": True}

    nW, nT, nRF = blk["nW"], blk["nT"], blk["nRF"]
    W_pivs, T_pivs, RF_vars = blk["W_pivs"], blk["T_pivs"], blk["RF_vars"]
    W_rref, T_rref = blk["W_rref"], blk["T_rref"]
    w_idx = {v: i for i, v in enumerate(W_pivs)}
    t_idx = {v: i for i, v in enumerate(T_pivs)}

    M0_s, Mw_s = blk["M1_strict_t"]["M0"], blk["M1_strict_t"]["Mw"]
    M0_c, Mk_c = blk["M0_c"], blk["Mk_c"]
    K_R = blk["K_R"]
    L_core = blk["L_core"]

    # Check totally-kernel isotropic R_F directions: ker(M0_s) \cap \bigcap ker(Mw_s[k])
    if M0_s.shape[0] > 0:
        K_iso = s40a.gf2_nullspace_np(np.vstack([M0_s] + [Mw_s[k] for k in range(nW)]))
    else:
        K_iso = np.eye(nRF, dtype=np.uint8)

    # Check root V_0 and V_00 on M1_strict and on (M0_c, Mk_c)
    if M0_s.shape[0] > 0:
        V0_strict = s40a.gf2_nullspace_np(np.hstack([Mw_s[k] for k in range(nW)]).T)
        V00_strict = s40a.gf2_nullspace_np(np.hstack([M0_s] + [Mw_s[k] for k in range(nW)]).T)
        r_elim_strict = s60b.gf2_rank((V0_strict @ M0_s) & 1) if V0_strict.shape[0] > 0 else 0
    else:
        V0_strict = np.zeros((0, 0), dtype=np.uint8)
        V00_strict = np.zeros((0, 0), dtype=np.uint8)
        r_elim_strict = 0

    if M0_c.shape[0] > 0 and M0_c.shape[1] > 0:
        V0_core = s40a.gf2_nullspace_np(np.hstack([Mk_c[k] for k in range(nW)]).T)
        V00_core = s40a.gf2_nullspace_np(np.hstack([M0_c] + [Mk_c[k] for k in range(nW)]).T)
        r_elim_core = s60b.gf2_rank((V0_core @ M0_c) & 1) if V0_core.shape[0] > 0 else 0
    else:
        V0_core = np.zeros((0, 0), dtype=np.uint8)
        V00_core = np.zeros((0, 0), dtype=np.uint8)
        r_elim_core = 0

    print(
        f"\n  [{tag} SHEARED BLOCK ANATOMY]: nW={nW}, nT={nT}, nRF={nRF}, n_q={blk['n_q']} (pure_w_quads={len(blk['pure_w_quads'])})\n"
        f"    P0(drf=0)={len(blk['P0_psets'])}, M1_strict={len(blk['M1_strict_psets'])}, A3(w2r)={len(blk['Block_A3_psets'])}, "
        f"D2(tr)={len(blk['Block_D2_psets'])}, D3(wtr/t2r)={len(blk['Block_D3_psets'])}, "
        f"BlockB(r2)={len(blk['Block_B_psets'])}, Other={len(blk['Other_psets'])}\n"
        f"    K_R={K_R.shape[0]}, K_iso={K_iso.shape[0]}, core_shape={M0_c.shape}, "
        f"V0_strict={V0_strict.shape[0]}(r_elim={r_elim_strict}), V00_strict={V00_strict.shape[0]}, "
        f"V0_core={V0_core.shape[0]}(r_elim={r_elim_core}), V00_core={V00_core.shape[0]}",
        flush=True,
    )

    # Run Step 47B Global NT=0 Iterative (K_R -> V_00 -> V_0 & NT0_Polar -> SysB) cascade on core pencil (M0_c, Mk_c)!
    L_core_T = L_core.T.copy()

    def eval_bc_global(W_mat):
        T_mat = blk["eval_t_batch"](W_mat)
        b_s = blk["M1_strict_b"](W_mat, T_mat)
        return (b_s @ L_core_T) & 1

    s47b_trace = []
    pure_w_evals_nt0 = []
    has_1eq0_nt0 = False
    if M0_c.shape[0] > 0 and M0_c.shape[1] > 0:
        M0_cur = M0_c.copy()
        Mk_cur = [Mk_c[k].copy() for k in range(nW)]
        cur_eb = eval_bc_global
        rng_zt = random.Random(rng_seed + 17)
        for rnd in range(1, 9):
            mR, rK = M0_cur.shape
            if mR == 0 or rK == 0:
                if mR > 0 and rK == 0:
                    pure_w_evals_nt0.append(cur_eb)
                break
            K_R_now = s40a.gf2_nullspace_np(np.vstack(Mk_cur))
            kr_dim = K_R_now.shape[0]
            if kr_dim > 0:
                M0_KR = (M0_cur @ K_R_now.T) & 1
                L_kr = s40a.gf2_nullspace_np(M0_KR.T)
                _, kr_pivs = s40a.gf2_rref_np(K_R_now)
                keep_cols = [c for c in range(rK) if c not in set(kr_pivs)]
                M0_cur = (L_kr @ M0_cur)[:, keep_cols] & 1
                Mk_cur = [(L_kr @ M)[:, keep_cols] & 1 for M in Mk_cur]
                L_kr_T = L_kr.T.copy()
                prev_eb = cur_eb
                cur_eb = (lambda eb, LT: lambda X: (eb(X) @ LT) & 1)(prev_eb, L_kr_T)
                mR, rK = M0_cur.shape
                if mR == 0 or rK == 0:
                    if mR > 0 and rK == 0:
                        pure_w_evals_nt0.append(cur_eb)
                    s47b_trace.append(f"r{rnd}:KR({kr_dim})->{mR}x{rK}")
                    break

            V0_now = s40a.gf2_nullspace_np(np.hstack(Mk_cur).T)
            V00_now = s40a.gf2_nullspace_np(np.hstack([M0_cur] + Mk_cur).T)
            v0_d, v00_d = V0_now.shape[0], V00_now.shape[0]
            if v00_d > 0:
                V00_T = V00_now.T.copy()
                prev_eb = cur_eb
                pure_w_evals_nt0.append((lambda eb, VT: lambda X: (eb(X) @ VT) & 1)(prev_eb, V00_T))

            r_el = 0
            if v0_d > 0 and rK > 0:
                P_mat = (V0_now @ M0_cur) & 1
                _, piv_cols = s40a.gf2_rref_np(P_mat)
                r_el = len(piv_cols)
                if r_el > 0:
                    K_use = np.eye(rK, dtype=np.uint8)[piv_cols]
                    comp_cols = [c for c in range(rK) if c not in set(piv_cols)]
                    C_mat = np.eye(rK, dtype=np.uint8)[:, comp_cols]
                    B0_use = M0_cur[:, piv_cols]
                    P_use = (V0_now @ B0_use) & 1
                    _, v_rows = s40a.gf2_rref_np(P_use.T)
                    S_inv = s43a.gf2_inv_np(P_use[v_rows])
                    L_op = (S_inv @ V0_now[v_rows]) & 1
                    _, l_col_pivs = s40a.gf2_rref_np(L_op)
                    h_cols = [c for c in range(mR) if c not in set(l_col_pivs)]
                    H_op = np.eye(mR, dtype=np.uint8)[h_cols]
                    LM0C = (L_op @ ((M0_cur @ C_mat) & 1)) & 1
                    C_eff = (C_mat ^ ((K_use.T @ LM0C) & 1)) & 1
                    M0_new = (H_op @ ((M0_cur @ C_eff) & 1)) & 1
                    Mk_new = [(H_op @ ((M @ C_eff) & 1)) & 1 for M in Mk_cur]
                    HB0_T = ((H_op @ B0_use) & 1).T.copy()
                    HBk_T = [((H_op @ M[:, piv_cols]) & 1).T.copy() for M in Mk_cur]
                    L_T = L_op.T.copy()
                    H_T = H_op.T.copy()
                    prev_eb = cur_eb

                    def _make_v0_eb(eb_in, LT_in, HT_in, HB0T_in, HBkT_in, mW_in):
                        def _ev(X_mat):
                            b_in = eb_in(X_mat)
                            Lb = (b_in @ LT_in) & 1
                            bH = ((b_in @ HT_in) & 1) ^ ((Lb @ HB0T_in) & 1)
                            for k_i in range(mW_in):
                                if HBkT_in[k_i].any():
                                    bH ^= X_mat[:, k_i:k_i + 1] & ((Lb @ HBkT_in[k_i]) & 1)
                            return bH
                        return _ev

                    cur_eb = _make_v0_eb(prev_eb, L_T, H_T, HB0_T, HBk_T, nW)
                    M0_cur, Mk_cur = M0_new, Mk_new
                    mR, rK = M0_cur.shape

            r_el_p2 = 0
            if mR > 0 and rK > 0:
                zp2 = s47b.try_zero_split_polar_step(M0_cur, Mk_cur, rng_seed=rng_seed + rnd * 100)
                if zp2 is not None:
                    r_el_p2, _, p2 = zp2
                    M0_cur = p2["M_u0"].copy()
                    Mk_cur = [p2["M_ua"][k].copy() for k in range(nW)]
                    prev_eb = cur_eb
                    p2_push = p2["push_rhs_batch"]
                    cur_eb = (lambda eb_in, push_fn: lambda X_mat: push_fn(X_mat, eb_in(X_mat)))(prev_eb, p2_push)
                    mR, rK = M0_cur.shape

            if mR == 0 or rK == 0:
                if mR > 0 and rK == 0:
                    pure_w_evals_nt0.append(cur_eb)
                s47b_trace.append(f"r{rnd}:KR={kr_dim},V0={v0_d}(-{r_el}),NT0P(-{r_el_p2})->{mR}x{rK}")
                break

            V00_post = s40a.gf2_nullspace_np(np.hstack([M0_cur] + Mk_cur).T)
            if V00_post.shape[0] > 0:
                V00_T = V00_post.T.copy()
                prev_eb = cur_eb
                pure_w_evals_nt0.append((lambda eb, VT: lambda X: (eb(X) @ VT) & 1)(prev_eb, V00_T))

            existing_concat = np.hstack([M0_cur] + Mk_cur)
            _, exist_pivs = s40a.gf2_rref_np(existing_concat.T)
            if len(exist_pivs) < mR:
                keep_r = sorted(exist_pivs)
                M0_cur = M0_cur[keep_r]
                Mk_cur = [M[keep_r] for M in Mk_cur]
                prev_eb = cur_eb
                cur_eb = (lambda eb, kr: lambda X: eb(X)[:, kr])(prev_eb, keep_r)
                mR = len(keep_r)
                existing_concat = np.hstack([M0_cur] + Mk_cur)

            V0_post = s40a.gf2_nullspace_np(np.hstack(Mk_cur).T)
            sysb_sols = s47b.solve_sysb_basis_c(lib9, Mk_cur, V0_post) if mR <= 350 else np.zeros((0, nW, mR), dtype=np.uint8)
            n_extra_b = sysb_sols.shape[0]
            M0_plus_Mk = [(M0_cur ^ Mk_cur[k]) for k in range(nW)]
            new_M0_rows = []
            new_Mk_rows = [[] for _ in range(nW)]
            accepted_v = []
            pure_sysb_v = []
            cur_span = existing_concat.copy()
            cur_rk = len(s40a.gf2_rref_np(cur_span)[1])
            for s_idx in range(n_extra_b):
                v_arr = sysb_sols[s_idx]
                mk_r = [((v_arr[k] @ M0_plus_Mk[k]) & 1) for k in range(nW)]
                row_concat = np.concatenate([np.zeros(rK, dtype=np.uint8)] + mk_r)
                if not row_concat.any():
                    pure_sysb_v.append(v_arr.copy())
                    continue
                test_span = np.vstack([cur_span, row_concat])
                new_rk = len(s40a.gf2_rref_np(test_span)[1])
                if new_rk > cur_rk:
                    cur_span = test_span
                    cur_rk = new_rk
                    new_M0_rows.append(np.zeros(rK, dtype=np.uint8))
                    for k in range(nW):
                        new_Mk_rows[k].append(mk_r[k])
                    accepted_v.append(v_arr.copy())
                    if len(accepted_v) >= 64:
                        break
            if pure_sysb_v:
                pv_arr = np.array(pure_sysb_v, dtype=np.uint8)
                prev_eb = cur_eb

                def _make_pure_sb(eb_in, pv_in, mW_in):
                    vk_T = [pv_in[:, k, :].T.copy() for k in range(mW_in)]
                    def _ev(X_mat):
                        b_in = eb_in(X_mat)
                        acc = np.zeros((X_mat.shape[0], pv_in.shape[0]), dtype=np.uint8)
                        for k_i in range(mW_in):
                            if vk_T[k_i].any():
                                acc ^= X_mat[:, k_i:k_i + 1] & ((b_in @ vk_T[k_i]) & 1)
                        return acc
                    return _ev

                pure_w_evals_nt0.append(_make_pure_sb(prev_eb, pv_arr, nW))

            n_added = len(accepted_v)
            s47b_trace.append(
                f"r{rnd}:KR={kr_dim},V0={v0_d}(-{r_el}),NT0P(-{r_el_p2}),V00={v00_d}+{V00_post.shape[0]},"
                f"SysB={n_extra_b}(+{n_added},pure={len(pure_sysb_v)})->{mR}x{rK}"
            )
            if n_added == 0 and r_el == 0 and r_el_p2 == 0 and kr_dim == 0:
                break
            if n_added > 0:
                acc_arr = np.array(accepted_v, dtype=np.uint8)
                M0_add = np.array(new_M0_rows, dtype=np.uint8)
                Mk_add = [np.array(new_Mk_rows[k], dtype=np.uint8) for k in range(nW)]
                M0_cur = np.vstack([M0_cur, M0_add])
                Mk_cur = [np.vstack([Mk_cur[k], Mk_add[k]]) for k in range(nW)]
                prev_eb = cur_eb

                def _make_aug_eb(eb_in, acc_in, mW_in):
                    vk_T = [acc_in[:, k, :].T.copy() for k in range(mW_in)]
                    def _ev(X_mat):
                        b_in = eb_in(X_mat)
                        b_add = np.zeros((X_mat.shape[0], acc_in.shape[0]), dtype=np.uint8)
                        for k_i in range(mW_in):
                            if vk_T[k_i].any():
                                b_add ^= X_mat[:, k_i:k_i + 1] & ((b_in @ vk_T[k_i]) & 1)
                        return np.hstack([b_in, b_add])
                    return _ev

                cur_eb = _make_aug_eb(prev_eb, acc_arr, nW)
        final_nt0_shape = M0_cur.shape
    else:
        final_nt0_shape = M0_c.shape

    pure_nt0_rk = 0
    pure_nt0_total = 0
    if pure_w_evals_nt0:
        rng_s = random.Random(rng_seed + 99)
        X_sample = np.array([[rng_s.getrandbits(1) for _ in range(nW)] for _ in range(2048)], dtype=np.uint8)
        all_p = np.hstack([fn(X_sample) for fn in pure_w_evals_nt0])
        pure_nt0_total = int(all_p.shape[1])
        pure_nt0_rk = len(s40a.gf2_rref_np(all_p.T)[1])
        ones_row = np.ones((1, 2048), dtype=np.uint8)
        rk_w1 = len(s40a.gf2_rref_np(np.vstack([all_p.T, ones_row]))[1])
        has_1eq0_nt0 = (rk_w1 == pure_nt0_rk)

    # Also run Step 60B Un-quotiented Block-B + Linearized (A3 + D2) at full W-space (U1 = I_{nW}, t1 = 0)!
    U_id = np.eye(nW, dtype=np.uint8)
    t1_zero = np.zeros(nW, dtype=np.uint8)
    M0_lin, Mu_lin, eval_b_lin, n_strict_in, n_extra_a3d2, Lam_a3d2 = s60b.extract_fiber_linearized_drf1(blk, U_id, t1_zero)
    bb_res = s60b.run_blockb_feedback_cascade(
        blk, U_id, t1_zero, M0_lin, Mu_lin, eval_b_lin, lib9,
        enable_blockb=True, enable_affine_y=False, max_outer_rounds=4, max_inner_rounds=4, seed=rng_seed + 200
    )
    print(
        f"  [{tag} NT=0 PENCIL & BLOCK-B CASCADE]: s47b_final={final_nt0_shape}, trace={s47b_trace} | "
        f"pure_nt0={pure_nt0_total}(rk={pure_nt0_rk}, 1eq0={has_1eq0_nt0}) | "
        f"A3+D2_global_lin=+{n_extra_a3d2}, BlockB_final_rK={bb_res['final_rK']}/{nRF}, bb_log={bb_res['log']}",
        flush=True,
    )

    # Check if V00_core or V00_strict or A3+D2 global left-nullspace yields new degree-<=3 pure-(W,T) polynomials!
    # Note: In M1_strict_psets + Block_A3_psets + Block_D2_psets, any left-nullspace vector v of the drf=1 coefficient
    # matrices [M0 | Mw | Mt | Mww] kills ALL r_F terms identically! Since M1_strict + A3 + D2 come from sheared
    # equations of degree <= 3, v^T (M1_strict + A3 + D2) is a pure-(W, T) polynomial of degree <= 3 in x!
    # Wait: because std_ech was ALREADY echelonized with drf=1 > drf=0, any row combination of drf=1 rows whose
    # drf=1 part vanishes in (W, T) is ALREADY in P0_psets!
    # What if t_a = Q_a(w) substitution causes a cancellation between t_a * r_j (in Block_D2) and w_p * w_q * r_j
    # (in Block_A3) or w_k * r_j (in M1_strict)?
    # Let's check! In `extract_fiber_linearized_drf1(blk, U_id, t1_zero)`, `Lam_a3d2` (specifically its last
    # `n_extra_a3d2` rows) are linear combinations of `Block_A3 + Block_D2` where the quadratic-in-w part of
    # `t_a(w) * r_j` and `w_p * w_q * r_j` CANCELLED EACH OTHER!
    # Even better: after that quadratic-in-w cancellation, we have `M0_lin` and `Mu_lin[0..nW-1]` (size `m_lin x nRF`),
    # where every row has `drf=1` coefficient strictly degree <= 1 in `w`!
    # Therefore, any vector `u` in `V00_lin = ker([M0_lin | Mu_lin[0] | ... | Mu_lin[nW-1]]^T)` annihilates
    # the remaining degree-<=1 `r_F` terms as well!
    # And what is the leftover `drf=0` part of such a combination `u @ Lam_a3d2`?
    # In the original sheared equations (in variables `w` and `t`), `u @ Lam_a3d2` is a linear combination of
    # `M1_strict + Block_A3 + Block_D2` rows whose `r_F` coefficient vanishes identically when `t = Q(w)`!
    # And its `drf=0` part is already degree <= 3 in `(w, t)` (i.e. degree <= 3 in the 111 variables `x`!)!
    V00_lin = s40a.gf2_nullspace_np(np.hstack([M0_lin] + Mu_lin).T) if M0_lin.shape[0] > 0 else np.zeros((0, 0), dtype=np.uint8)
    n_new_syz_rows = 0
    sr_out = sr_in
    if V00_lin.shape[0] > 0:
        # Map V00_lin back to combinations of DRF1_quad_psets via Lam_a3d2!
        Comb_drf1 = (V00_lin @ Lam_a3d2) & 1  # (n_v00, n_tot_drf1)
        drf1_psets = blk["DRF1_quad_psets"]
        # For each row of Comb_drf1, XOR the drf=0 monomials of the selected drf1_psets!
        # Wait: what about the drf=1 monomials? By construction of Lam_a3d2 and V00_lin, the drf=1 coefficient
        # vanishes on the variedad {t_a = Q_a(w)}! And in fact, its drf=0 part is a polynomial in (w, t) of deg <= 3
        # which MUST vanish on every solution (w, t = Q(w), r_F)!
        # Let's extract the exact (w, t) degree-<=3 polynomial (keeping ONLY drf=0 monomials) AND verify it on
        # 32 random solutions of t = Q(w)!
        RF_set = set(RF_vars)
        formas_wt = []
        for p in W_pivs:
            m = W_rref[p]
            formas_wt.append([b for b in range(111) if (m >> b) & 1])
        for q in T_pivs:
            m = T_rref[q]
            formas_wt.append([b for b in range(111) if (m >> b) & 1])

        syz_cubicas = []
        for vi in range(Comb_drf1.shape[0]):
            wt_mons = set()
            c0_b = 0
            for ri in np.flatnonzero(Comb_drf1[vi]):
                for m in drf1_psets[ri]:
                    if m == 0:
                        c0_b ^= 1
                        continue
                    vs = [b for b in range(111) if (m >> b) & 1]
                    if any(v in RF_set for v in vs):
                        continue
                    tup = tuple(sorted((w_idx[v] if v in w_idx else (nW + t_idx[v])) for v in vs))
                    if tup in wt_mons:
                        wt_mons.remove(tup)
                    else:
                        wt_mons.add(tup)
            poly = [list(tup) for tup in sorted(wt_mons)]
            if c0_b:
                poly.append([])
            if poly:
                syz_cubicas.append(poly)

        if syz_cubicas:
            rows_syz, n_syz, _ = ssig.expand_compact_block_to_c_rows(
                formas_wt, syz_cubicas, sr_out["_lin_pivs"], lib_exp, lib9, tbl, zt_seed=rng_seed + 333
            )
            sr_out = ssig.inject_raw_c_rows_into_s9(sr_out, rows_syz, n_syz, lib9, tbl)
            n_new_syz_rows = n_syz
            print(f"  [{tag} A3+D2 V00 SYZYGY INJECT]: injected {n_syz} pure-(W,T) deg<=3 rows -> {ssig.state_sig(sr_out)}", flush=True)

    summary = {
        "nW": nW,
        "nT": nT,
        "nRF": nRF,
        "n_q": blk["n_q"],
        "n_pure_w_quads": len(blk["pure_w_quads"]),
        "n_P0_drf0": len(blk["P0_psets"]),
        "n_M1_strict": len(blk["M1_strict_psets"]),
        "n_Block_A3_w2r": len(blk["Block_A3_psets"]),
        "n_Block_D2_tr": len(blk["Block_D2_psets"]),
        "n_Block_D3_wtr": len(blk["Block_D3_psets"]),
        "n_Block_B_r2": len(blk["Block_B_psets"]),
        "n_Other": len(blk["Other_psets"]),
        "K_R_dim": int(K_R.shape[0]),
        "K_iso_dim": int(K_iso.shape[0]),
        "core_shape": list(M0_c.shape),
        "V0_strict_dim": int(V0_strict.shape[0]),
        "V0_strict_r_elim": int(r_elim_strict),
        "V00_strict_dim": int(V00_strict.shape[0]),
        "V0_core_dim": int(V0_core.shape[0]),
        "V0_core_r_elim": int(r_elim_core),
        "V00_core_dim": int(V00_core.shape[0]),
        "s47b_nt0_final_shape": list(final_nt0_shape),
        "s47b_nt0_trace": s47b_trace,
        "s47b_pure_nt0_total": pure_nt0_total,
        "s47b_pure_nt0_rk": pure_nt0_rk,
        "s47b_has_1eq0_nt0": has_1eq0_nt0,
        "a3d2_global_extra_lin": int(n_extra_a3d2),
        "v00_a3d2_dim": int(V00_lin.shape[0]),
        "v00_a3d2_injected_rows": int(n_new_syz_rows),
        "blockb_global_final_rK": int(bb_res["final_rK"]),
        "blockb_global_log": bb_res["log"],
        "blockb_global_stats": bb_res["bb_stats"],
        "after_syzygy_state": ssig.state_sig(sr_out),
        "elapsed_s": round(time.perf_counter() - t0, 2),
    }
    return sr_out, summary


# =============================================================================
# 4. JOB 1: B111_S11_DEEP (LONG-COSET BALANCED IDEALS + CUBIC SYZYGY CASCADE)
# =============================================================================

# All 29 unexplored size-8 long cosets (after 0, 0xff, 0x55, 0x33, 0x11, 0x77, 0x01)
B111_LONG_COSETS_PRIORITY = [
    0x15,                                            # 104-dim rank 24 (lowest rank unexplored!)
    0x07, 0x0B, 0x0D, 0x13, 0x19, 0x25, 0x7F,        # 104-dim rank 25 (7 cosets)
    0x03, 0x05, 0x0F, 0x17, 0x1F, 0x23, 0x27, 0x2B,  # 104-dim rank 26..27
    0x2D, 0x2F, 0x35, 0x37, 0x3B, 0x3D, 0x3F, 0x45,
    0x47, 0x4B, 0x4F, 0x57, 0x5F,
]


def verify_psets_on_coset_target(psets_list, forms_111, cubicas_y, orig_f, basis_f, f_act, z_targets_dict, n_trials=4000, seed=14200):
    """
    Direct truth-table Zero-Trust check: sample random fiber points, and whenever W_h(z) == target
    for all z in z_targets_dict, assert that EVERY pset in psets_list and EVERY compact cubic in cubicas_y vanishes!
    """
    if not psets_list and not cubicas_y:
        return {"matches": 0, "violations": 0}
    zs = list(z_targets_dict.keys())
    idx_map = {z: np.array([u | ((u ^ z) << 8) for u in range(256)], dtype=np.int32) for z in zs}
    o_z = {z: orig_f[idx_map[z]] for z in zs}
    b_z = {z: basis_f[:, idx_map[z]] for z in zs}
    rng = random.Random(seed)
    N = len(f_act)
    matches = 0
    violations = 0
    for _ in range(n_trials):
        picks = [rng.getrandbits(1) for _ in range(N)]
        ok = True
        for z in zs:
            cz = o_z[z].copy()
            for i, bit in enumerate(picks):
                if bit:
                    cz ^= b_z[z][i]
            if 256 - 2 * int(cz.sum()) != z_targets_dict[z]:
                ok = False
                break
        if not ok:
            continue
        matches += 1
        x111 = 0
        for i, bit in enumerate(picks):
            if bit:
                x111 |= 1 << f_act[i]
        for ps in psets_list:
            if eval_pset_111(ps, x111):
                violations += 1
                break
        if violations == 0 and cubicas_y:
            y_vals = [sum((x111 >> int(v)) & 1 for v in f_vars) & 1 for f_vars in forms_111]
            for poly in cubicas_y:
                v_p = 0
                for mono in poly:
                    prod = 1
                    for j in mono:
                        if not y_vals[int(j)]:
                            prod = 0
                            break
                    v_p ^= prod
                if v_p:
                    violations += 1
                    break
    assert violations == 0, f"ZT FAIL on {z_targets_dict}: {violations}/{matches} violations!"
    return {"matches": matches, "violations": violations}


def run_b111_s11_deep(libs, lib_exp, exe_gf2id):
    t0 = time.perf_counter()
    lib_diag, lib9, lib_cg, lib_sh, lib_ac, lib_d4, lib63 = libs

    # Step 1: Reconstruct B1_11 e=1 S11_E0_0 post-signature + AC180 state (dim=100, q=28, c=671, k_fix=22)
    env = spois.build_cell_root_sound("B1_11", libs)
    tbl = env["tbl"]
    sr_base = spois.fix_a14_fiber(env, 1, lib9)
    spec = ssig.JOB_SPECS["S11_E0_0"]
    base_data = json.loads((ssig.SIG_INJ_DIR / spec["base_json"]).read_text(encoding="utf-8"))["1"]
    comp_data = json.loads((ssig.SIG_INJ_DIR / spec["comp_json"]).read_text(encoding="utf-8"))

    psets_lin = []
    for vars_, c in base_data.get("lin", []):
        ps = {1 << int(v) for v in vars_}
        if int(c) & 1:
            ps.add(0)
        if ps:
            psets_lin.append(ps)
    psets_deg2 = []
    for p in base_data.get("polys", []):
        ps = set()
        for mono in p:
            m_mask = 0
            for v in mono:
                m_mask |= 1 << int(v)
            ps ^= {m_mask}
        if ps:
            psets_deg2.append(ps)

    sr_p2, _ = s60c.inject_psets_into_s9(sr_base, psets_lin + psets_deg2, lib9, tbl)
    rows_q5, n_q5, _ = ssig.expand_compact_block_to_c_rows(
        comp_data["Q5"]["formas"], comp_data["Q5"]["cubicas"], sr_p2["_lin_pivs"], lib_exp, lib9, tbl, zt_seed=14001
    )
    sr_p3 = ssig.inject_raw_c_rows_into_s9(sr_p2, rows_q5, n_q5, lib9, tbl)

    f_act3 = sorted(i for i in range(111) if i not in sr_p3["_lin_pivs"])
    orig_f3, basis_f3, _, _ = s60c.build_affine_tt_basis(env["o_tt_111"], env["b_tt_111"], sr_p3["_lin_pivs"], f_act3)
    out_st = {}
    s63a.run_autocorr_and_parseval_suite(
        orig_f3, basis_f3, f_act3, sr_p3,
        env["all_shifts_u16"], env["all_shifts_py"], env["d8_shifts"], env["struct_set"], env["struct_indices"],
        env["c8_idx_256"], env["z_reps_36"], env["z_reps_py"],
        lib_ac, lib_d4, lib9, tbl, env["coord_subs"],
        tag="S11_E0_0_INIT", seed=14050,
        vq_ctx=None, do_deg4_compare=False, out_states=out_st,
    )
    sr_s11 = out_st.get("sub_ac", sr_p3)
    init_sig = ssig.state_sig(sr_s11)
    print(f"\n[B111_S11_DEEP INIT POST-AC180]: {init_sig}", flush=True)

    out = {
        "job": "B111_S11_DEEP",
        "cell": "B1_11",
        "rep": 1,
        "signature": "S11_E0_0",
        "parseval_theorem": "6 short cosets {0,ff,55,33,11,77} have |W|=64 -> energy 16*4096=65536=256^2 -> W_h(z)=0 on ALL 30 size-8 cosets!",
        "init_post_s11_ac180": init_sig,
        "long_coset_scan": [],
        "fibred_pair_scan": [],
    }

    if sr_s11["closed_unsat"]:
        out["verdict"] = "CLOSED_UNSAT_AT_INIT"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        return out

    # Step 2: Scan projection ranks k_z of all 29 unexplored long cosets on the 100-dim post-S11_E0_0 state,
    # and extract exact W_z = 0 vanishing ideals for all cosets with k_z <= 25 (d=2, plus d=3 if k_z <= 22)!
    f_act = sorted(i for i in range(111) if i not in sr_s11["_lin_pivs"])
    orig_f, basis_f, _, _ = s60c.build_affine_tt_basis(env["o_tt_111"], env["b_tt_111"], sr_s11["_lin_pivs"], f_act)

    projs = {}
    rank_table = []
    for z in B111_LONG_COSETS_PRIORITY:
        P_z = CosetProj(orig_f, basis_f, f_act, z, max_wht_k=25)
        projs[z] = P_z
        rank_table.append((P_z.k, z))
    rank_table.sort()
    print(
        f"  [B111_S11_DEEP 29 LONG-COSET RANKS ON 100-DIM S11]: "
        + ", ".join(f"{hex(z)}:k={k}" for k, z in rank_table),
        flush=True,
    )
    out["long_coset_ranks_100dim"] = [{"z": hex(z), "k": int(k)} for k, z in rank_table]

    new_psets_le2 = []
    new_compact_cubic_blocks = []

    # Extract ideals on the lowest-rank long cosets (up to 10 cosets with k <= 25)
    selected_long = [z for k, z in rank_table if k <= 25][:10]
    for z in selected_long:
        t_z = time.perf_counter()
        P_z = projs[z]
        pts = np.flatnonzero(P_z.W == 0).astype(np.uint64)
        n_pts = int(len(pts))
        if n_pts == 0:
            out["long_coset_scan"].append({"z": hex(z), "k": P_z.k, "n_pts_W0": 0, "empty_image": True})
            print(f"  *** [B111_S11_DEEP] EMPTY IMAGE W_{hex(z)} == 0! 0 points! ***", flush=True)
            out["verdict"] = f"CLOSED_UNSAT_EMPTY_COSET_{hex(z)}"
            out["elapsed_s"] = round(time.perf_counter() - t0, 2)
            return out

        R2, err2 = ideal_points(exe_gf2id, pts, P_z.k, 2, tag=f"s11_{hex(z)}_d2")
        p_lin, p_quad = lift_le2_poly_masks_to_psets(R2["polys"], P_z.forms)
        min_cubs_y = []
        r3_dim = 0
        if P_z.k <= 22:
            R3, _ = ideal_points(exe_gf2id, pts, P_z.k, 3, tag=f"s11_{hex(z)}_d3")
            r3_dim = len(R3["polys"])
            _, min_masks = filter_minimal_cubics_masks(R2["polys"], R3["polys"], P_z.k)
            min_cubs_y = poly_masks_to_compact_cubics(min_masks)

        zt_info = verify_psets_on_coset_target(
            p_lin + p_quad, P_z.forms, min_cubs_y, orig_f, basis_f, f_act, {z: 0}, n_trials=4000, seed=14200 + z
        )
        new_psets_le2.extend(p_lin + p_quad)
        if min_cubs_y:
            new_compact_cubic_blocks.append((f"coset_{hex(z)}", P_z.forms, min_cubs_y))

        entry = {
            "z": hex(z),
            "k": int(P_z.k),
            "n_pts_W0": n_pts,
            "dim_I_le2": len(R2["polys"]),
            "n_lin": len(p_lin),
            "n_quad": len(p_quad),
            "dim_I_le3": int(r3_dim),
            "n_min_cubs": len(min_cubs_y),
            "zt_matches": zt_info["matches"],
            "zt_violations": zt_info["violations"],
            "elapsed_s": round(time.perf_counter() - t_z, 2),
        }
        out["long_coset_scan"].append(entry)
        print(
            f"  [LONG COSET {hex(z)}] k={P_z.k}, |W=0|={n_pts}/{1<<P_z.k} -> "
            f"I_<=2={len(R2['polys'])} ({len(p_lin)}L+{len(p_quad)}Q), min_cubs={len(min_cubs_y)} "
            f"(ZT matches={zt_info['matches']}, viol=0, {entry['elapsed_s']}s)",
            flush=True,
        )

    # Also test fibred pairs (0x55, z_best) and (0x01, z_best) at d=2 (and d=3 if k_conj <= 26)
    P_55 = CosetProj(orig_f, basis_f, f_act, 0x55, max_wht_k=25)
    P_01 = CosetProj(orig_f, basis_f, f_act, 0x01, max_wht_k=25)
    z_best_list = [z for k, z in rank_table if k <= 25][:3]
    for (z1, t1_w, P1), z2 in [((0x55, 64, P_55), zb) for zb in z_best_list] + [((0x01, 0, P_01), zb) for zb in z_best_list[:2]]:
        t_fp = time.perf_counter()
        P2 = projs[z2]
        pc = pair_coords(P1, P2, f_act)
        c, ka, kb = pc["c"], pc["ka"], pc["kb"]
        k_conj = c + ka + kb
        S1_pts = np.flatnonzero(P1.W == t1_w)
        S2_pts = np.flatnonzero(P2.W == 0)
        y1, a1 = pc["tr1"](S1_pts)
        y2, b2 = pc["tr2"](S2_pts)
        R2_fp, err_fp2 = ideal_fibred(
            exe_gf2id,
            np.stack([y1, a1], axis=1),
            np.stack([y2, b2], axis=1),
            c, ka, kb, 2, tag=f"fp_{hex(z1)}_{hex(z2)}_d2",
        )
        if R2_fp["empty"]:
            out["fibred_pair_scan"].append({"pair": [hex(z1), hex(z2)], "k_conj": k_conj, "empty_fibred": True})
            print(f"  *** [B111_S11_DEEP] EMPTY FIBRED JOIN ({hex(z1)}, {hex(z2)})! ***", flush=True)
            out["verdict"] = f"CLOSED_UNSAT_EMPTY_FIBRED_{hex(z1)}_{hex(z2)}"
            out["elapsed_s"] = round(time.perf_counter() - t0, 2)
            return out
        p_lin, p_quad = lift_le2_poly_masks_to_psets(R2_fp["polys"], pc["forms_111"])
        min_cubs_y = []
        if c >= 3 and k_conj <= 27:
            R3_fp, _ = ideal_fibred(
                exe_gf2id,
                np.stack([y1, a1], axis=1),
                np.stack([y2, b2], axis=1),
                c, ka, kb, 3, tag=f"fp_{hex(z1)}_{hex(z2)}_d3",
            )
            _, min_masks = filter_minimal_cubics_masks(R2_fp["polys"], R3_fp["polys"], k_conj)
            min_cubs_y = poly_masks_to_compact_cubics(min_masks)

        zt_fp = verify_psets_on_coset_target(
            p_lin + p_quad, pc["forms_111"], min_cubs_y, orig_f, basis_f, f_act,
            {z1: t1_w, z2: 0}, n_trials=4000, seed=14300 + z1 + z2
        )
        new_psets_le2.extend(p_lin + p_quad)
        if min_cubs_y:
            new_compact_cubic_blocks.append((f"fibred_{hex(z1)}_{hex(z2)}", pc["forms_111"], min_cubs_y))
        fp_entry = {
            "pair": [hex(z1), hex(z2)],
            "c_shared": int(c),
            "ka": int(ka),
            "kb": int(kb),
            "k_conj": int(k_conj),
            "dim_I_le2": len(R2_fp["polys"]),
            "n_lin": len(p_lin),
            "n_quad": len(p_quad),
            "n_min_cubs": len(min_cubs_y),
            "zt_matches": zt_fp["matches"],
            "zt_violations": zt_fp["violations"],
            "elapsed_s": round(time.perf_counter() - t_fp, 2),
        }
        out["fibred_pair_scan"].append(fp_entry)
        print(
            f"  [FIBRED PAIR ({hex(z1)},{hex(z2)})] c={c}, ka={ka}, kb={kb}, k_conj={k_conj} -> "
            f"I_<=2={len(R2_fp['polys'])} ({len(p_lin)}L+{len(p_quad)}Q), min_cubs={len(min_cubs_y)} "
            f"({fp_entry['elapsed_s']}s)",
            flush=True,
        )

    # Inject any new deg<=2 and deg==3 equations from long cosets & fibred pairs
    sr_cur = sr_s11
    if new_psets_le2:
        sr_cur, _ = s60c.inject_psets_into_s9(sr_cur, new_psets_le2, lib9, tbl)
    for blk_tag, formas_blk, cubs_blk in new_compact_cubic_blocks:
        if sr_cur["closed_unsat"]:
            break
        rows_b, n_b, _ = ssig.expand_compact_block_to_c_rows(
            formas_blk, cubs_blk, sr_cur["_lin_pivs"], lib_exp, lib9, tbl, zt_seed=14401
        )
        sr_cur = ssig.inject_raw_c_rows_into_s9(sr_cur, rows_b, n_b, lib9, tbl)

    out["after_long_coset_inject"] = ssig.state_sig(sr_cur)
    print(f"  [B111_S11_DEEP AFTER LONG-COSET INJECT]: {out['after_long_coset_inject']}", flush=True)
    if sr_cur["closed_unsat"]:
        out["verdict"] = "CLOSED_UNSAT_AFTER_LONG_COSET_INJECT"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        return out

    # Step 3: Cubic Cancellation / Degree-3 Syzygy & Bilinear Pencil Reduction (s45b / s47b / s60b)
    sr_cur, syz_summary = run_cubic_syzygy_and_pencil_reduction("B111_S11_DEEP", sr_cur, env, libs, lib_exp, rng_seed=14500)
    out["cubic_syzygy_and_pencil"] = syz_summary
    if sr_cur["closed_unsat"]:
        out["verdict"] = "CLOSED_UNSAT_AFTER_CUBIC_SYZYGY"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        return out

    # If new equations were injected, re-run AC180
    if (
        out["after_long_coset_inject"] != init_sig
        or syz_summary.get("v00_a3d2_injected_rows", 0) > 0
    ):
        f_act_ac = sorted(i for i in range(111) if i not in sr_cur["_lin_pivs"])
        orig_ac, basis_ac, _, _ = s60c.build_affine_tt_basis(env["o_tt_111"], env["b_tt_111"], sr_cur["_lin_pivs"], f_act_ac)
        out_st2 = {}
        s63a.run_autocorr_and_parseval_suite(
            orig_ac, basis_ac, f_act_ac, sr_cur,
            env["all_shifts_u16"], env["all_shifts_py"], env["d8_shifts"], env["struct_set"], env["struct_indices"],
            env["c8_idx_256"], env["z_reps_36"], env["z_reps_py"],
            lib_ac, lib_d4, lib9, tbl, env["coord_subs"],
            tag="B111_S11_DEEP_AC2", seed=14600,
            vq_ctx=None, do_deg4_compare=False, out_states=out_st2,
        )
        sr_cur = out_st2.get("sub_ac", sr_cur)

    out["final_state"] = ssig.state_sig(sr_cur)
    out["final_wess"] = spois.measure_wess("B111_S11_DEEP_wess", sr_cur, lib9, lib_sh, tbl, rng_seed=14700)
    print(f"  [B111_S11_DEEP FINAL W_ess]: {out['final_wess']}", flush=True)
    out["verdict"] = "CLOSED_UNSAT" if sr_cur["closed_unsat"] else "OPEN"
    out["elapsed_s"] = round(time.perf_counter() - t0, 2)
    return out


# =============================================================================
# 5. JOBS 2 & 3: B011_IB_E3_GP & B011_IB_E3_GM (8-COSET GAMMA EXTRACTION ON e=3)
# =============================================================================

GAMMA_8COSET_TARGETS = {
    "gamma+": {0xFF: 0, 0x55: 64, 0x33: 0, 0x11: 32, 0x77: -32, 0x01: 0, 0x15: 0, 0x0F: 0, 0x2D: 0},
    "gamma-": {0xFF: 0, 0x55: 64, 0x33: 0, 0x11: -32, 0x77: 32, 0x01: 0, 0x15: 0, 0x0F: 0, 0x2D: 0},
}


def run_b011_ib_e3_gamma8(job_name, gname, libs, lib_exp, exe_gf2id):
    t0 = time.perf_counter()
    lib_diag, lib9, lib_cg, lib_sh, lib_ac, lib_d4, lib63 = libs
    rep_e = 3
    T = GAMMA_8COSET_TARGETS[gname]

    env = spois.build_cell_root_sound("B0_11", libs)
    tbl = env["tbl"]
    sr_base = spois.fix_a14_fiber(env, rep_e, lib9)
    base_wess = spois.measure_wess(f"B0_11_e{rep_e}_base", sr_base, lib9, lib_sh, tbl, rng_seed=15000 + rep_e)
    print(f"\n[{job_name} B0_11 e={rep_e} BASELINE W_ess]: {base_wess}", flush=True)

    f_act = sorted(i for i in range(111) if i not in sr_base["_lin_pivs"])
    orig_f, basis_f, _, _ = s60c.build_affine_tt_basis(env["o_tt_111"], env["b_tt_111"], sr_base["_lin_pivs"], f_act)

    # 1. Extract 2-coset (0xff, 0x55) = (0, 64) exact degree<=3 ideal
    pois_ff55 = spois.extract_poisson_joint_ideal(
        orig_f, basis_f, f_act, {(0, 64)}, max_deg=3, seed=15100 + (1 if gname == "gamma+" else 2)
    )

    # 2. Build WHT projections on sr_base for [0x55, 0x33, 0x11, 0x77, 0x01, 0x15, 0x0f, 0x2d]
    zs_extract = [0x55, 0x33, 0x11, 0x77, 0x01, 0x15, 0x0F, 0x2D]
    P = {z: CosetProj(orig_f, basis_f, f_act, z, max_wht_k=26) for z in zs_extract}
    print(
        f"  [{job_name} COSET RANKS ON e=3 (dim={len(f_act)})]: "
        + ", ".join(f"{hex(z)}:k={P[z].k}(|W={T[z]}|={int((P[z].W==T[z]).sum()) if P[z].W is not None else -1})" for z in zs_extract),
        flush=True,
    )

    # Check if any single coset has empty target set
    for z in zs_extract:
        if P[z].W is not None and int((P[z].W == T[z]).sum()) == 0:
            return {
                "job": job_name, "cell": "B0_11", "rep": rep_e, "profile": gname,
                "verdict": f"CLOSED_UNSAT_EMPTY_COSET_{hex(z)}",
                "elapsed_s": round(time.perf_counter() - t0, 2),
            }

    # 3. Extract Q = (0x55, 0x33, 0x11, 0x77) fibred join ideal (d=2 and d=3 + minimal cubics)
    t_q = time.perf_counter()
    J = from_proj(P[0x55], T[0x55])
    join_trace = [{"step": "0x55", "k": J.k, "n_pts": int(len(J.pts))}]
    for z in (0x33, 0x11):
        J, pc_step, tot_step = combine_js(J, from_proj(P[z], T[z]), f_act)
        join_trace.append({
            "step": f"+{hex(z)}",
            "c": int(pc_step["c"]), "ka": int(pc_step["ka"]), "kb": int(pc_step["kb"]),
            "k": int(pc_step["c"] + pc_step["ka"] + pc_step["kb"]),
            "n_pts": int(tot_step),
        })
        if tot_step == 0:
            return {
                "job": job_name, "cell": "B0_11", "rep": rep_e, "profile": gname,
                "join_trace": join_trace,
                "verdict": f"CLOSED_UNSAT_EMPTY_JOIN_AT_{hex(z)}",
                "elapsed_s": round(time.perf_counter() - t0, 2),
            }

    Pl = P[0x77]
    pc_q = pair_coords(J, Pl, f_act)
    c_q, ka_q, kb_q = pc_q["c"], pc_q["ka"], pc_q["kb"]
    k_q = c_q + ka_q + kb_q
    y1, a1 = pc_q["tr1"](J.pts)
    S2_77 = np.flatnonzero(Pl.W == T[0x77])
    y2, b2 = pc_q["tr2"](S2_77)
    Arecs = np.stack([y1, a1], axis=1)
    Brecs = np.stack([y2, b2], axis=1)

    R2_q, err_q2 = ideal_fibred(exe_gf2id, Arecs, Brecs, c_q, ka_q, kb_q, 2, tag=f"q_{job_name}_d2")
    if R2_q["empty"]:
        return {
            "job": job_name, "cell": "B0_11", "rep": rep_e, "profile": gname,
            "join_trace": join_trace,
            "verdict": "CLOSED_UNSAT_EMPTY_FIBRED_Q_55_33_11_77",
            "elapsed_s": round(time.perf_counter() - t0, 2),
        }
    R3_q, err_q3 = ideal_fibred(exe_gf2id, Arecs, Brecs, c_q, ka_q, kb_q, 3, tag=f"q_{job_name}_d3")
    _, q_min_masks = filter_minimal_cubics_masks(R2_q["polys"], R3_q["polys"], k_q)
    q_lin, q_quad = lift_le2_poly_masks_to_psets(R2_q["polys"], pc_q["forms_111"])
    q_min_cubs_y = poly_masks_to_compact_cubics(q_min_masks)

    zt_q = verify_psets_on_coset_target(
        q_lin + q_quad, pc_q["forms_111"], q_min_cubs_y, orig_f, basis_f, f_act,
        {0x55: T[0x55], 0x33: T[0x33], 0x11: T[0x11], 0x77: T[0x77]},
        n_trials=12000, seed=15200 + (1 if gname == "gamma+" else 2)
    )
    dt_q = round(time.perf_counter() - t_q, 2)
    print(
        f"  [{job_name} Q=(55,33,11,77) ({dt_q}s)] c={c_q}, ka={ka_q}, kb={kb_q}, k_q={k_q} -> "
        f"I_<=2={len(R2_q['polys'])} ({len(q_lin)}L+{len(q_quad)}Q), I_<=3={len(R3_q['polys'])}, "
        f"min_cubs={len(q_min_cubs_y)} | ZT matches={zt_q['matches']} (viol=0)",
        flush=True,
    )

    all_psets_le2 = list(pois_ff55["psets_le2"]) + q_lin + q_quad
    all_psets_deg3 = list(pois_ff55["psets_deg3"])
    compact_cubic_blocks = [("Q_55_33_11_77", pc_q["forms_111"], q_min_cubs_y)]

    # 4. Extract size-8 coset ideals for z in (0x01, 0x15, 0x0f, 0x2d)
    # Note: 0x01 has k~13 (run d=2,3); 0x15 has k~24 (run d=2, plus d=3 if k<=23); 0x0f, 0x2d have k~26 (run d=2 fast!)
    coset_ideal_logs = []
    for z in (0x01, 0x15, 0x0F, 0x2D):
        if P[z].W is None:
            continue
        tz = time.perf_counter()
        pts_z = np.flatnonzero(P[z].W == T[z]).astype(np.uint64)
        R2_z, _ = ideal_points(exe_gf2id, pts_z, P[z].k, 2, tag=f"{job_name}_{hex(z)}_d2")
        z_lin, z_quad = lift_le2_poly_masks_to_psets(R2_z["polys"], P[z].forms)
        z_min_cubs = []
        r3_z_dim = 0
        if P[z].k <= 23:
            R3_z, _ = ideal_points(exe_gf2id, pts_z, P[z].k, 3, tag=f"{job_name}_{hex(z)}_d3")
            r3_z_dim = len(R3_z["polys"])
            _, z_min_masks = filter_minimal_cubics_masks(R2_z["polys"], R3_z["polys"], P[z].k)
            z_min_cubs = poly_masks_to_compact_cubics(z_min_masks)

        zt_z = verify_psets_on_coset_target(
            z_lin + z_quad, P[z].forms, z_min_cubs, orig_f, basis_f, f_act,
            {z: T[z]}, n_trials=4000, seed=15300 + z
        )
        all_psets_le2.extend(z_lin + z_quad)
        if z_min_cubs:
            compact_cubic_blocks.append((f"coset_{hex(z)}", P[z].forms, z_min_cubs))
        dt_z = round(time.perf_counter() - tz, 2)
        c_entry = {
            "z": hex(z),
            "k": int(P[z].k),
            "target_W": int(T[z]),
            "n_pts": int(len(pts_z)),
            "dim_I_le2": len(R2_z["polys"]),
            "n_lin": len(z_lin),
            "n_quad": len(z_quad),
            "dim_I_le3": int(r3_z_dim),
            "n_min_cubs": len(z_min_cubs),
            "zt_matches": zt_z["matches"],
            "zt_violations": zt_z["violations"],
            "elapsed_s": dt_z,
        }
        coset_ideal_logs.append(c_entry)
        print(
            f"  [{job_name} COSET {hex(z)} ({dt_z}s)] k={P[z].k} -> "
            f"I_<=2={len(R2_z['polys'])} ({len(z_lin)}L+{len(z_quad)}Q), min_cubs={len(z_min_cubs)}",
            flush=True,
        )

    out = {
        "job": job_name,
        "cell": "B0_11",
        "rep": rep_e,
        "class": "I-B",
        "profile": gname,
        "baseline": ssig.state_sig(sr_base),
        "baseline_wess": base_wess,
        "poisson_ff55_zt": pois_ff55["zt_10k"],
        "Q_55_33_11_77": {
            "join_trace": join_trace,
            "c": int(c_q), "ka": int(ka_q), "kb": int(kb_q), "k_q": int(k_q),
            "dim_I_le2": len(R2_q["polys"]),
            "n_lin": len(q_lin),
            "n_quad": len(q_quad),
            "dim_I_le3": len(R3_q["polys"]),
            "n_min_cubs": len(q_min_cubs_y),
            "zt_matches": zt_q["matches"],
            "zt_violations": zt_q["violations"],
            "stderr_d2": err_q2,
            "stderr_d3": err_q3,
            "elapsed_s": dt_q,
        },
        "size8_cosets": coset_ideal_logs,
    }

    # 5. Stage 1: Inject all linear + quadratic generators into sr_base
    sr_p2, _ = s60c.inject_psets_into_s9(sr_base, all_psets_le2, lib9, tbl)
    out["after_gamma8_le2"] = ssig.state_sig(sr_p2)
    print(f"  [{job_name} AFTER 8-COSET lin+deg<=2]: {out['after_gamma8_le2']}", flush=True)
    if sr_p2["closed_unsat"]:
        out["verdict"] = "CLOSED_UNSAT_AT_GAMMA8_DEG2"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        return out

    # 6. Stage 2: Inject (0xff, 0x55) cubics + expand compact cubics from Q=(55,33,11,77) and size-8 cosets in C/OpenMP!
    sr_p3, _ = s60c.inject_psets_into_s9(sr_p2, all_psets_deg3, lib9, tbl) if all_psets_deg3 else (sr_p2, [])
    expand_logs = []
    for blk_tag, formas_blk, cubs_blk in compact_cubic_blocks:
        if sr_p3["closed_unsat"] or not cubs_blk:
            continue
        rows_b, n_b, zt_b = ssig.expand_compact_block_to_c_rows(
            formas_blk, cubs_blk, sr_p3["_lin_pivs"], lib_exp, lib9, tbl, zt_seed=15400 + rep_e
        )
        zt_b["block"] = blk_tag
        expand_logs.append(zt_b)
        sr_p3 = ssig.inject_raw_c_rows_into_s9(sr_p3, rows_b, n_b, lib9, tbl)
    out["compact_cubic_expansions"] = expand_logs
    out["after_gamma8_le3"] = ssig.state_sig(sr_p3)
    print(f"  [{job_name} AFTER 8-COSET CUBICS]: {out['after_gamma8_le3']}", flush=True)
    if sr_p3["closed_unsat"]:
        out["verdict"] = "CLOSED_UNSAT_AT_GAMMA8_DEG3"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        return out

    # 7. Stage 3: Step 63A (AC180 + AC4115 + D8-PQ72)
    f_act3 = sorted(i for i in range(111) if i not in sr_p3["_lin_pivs"])
    orig_f3, basis_f3, _, _ = s60c.build_affine_tt_basis(env["o_tt_111"], env["b_tt_111"], sr_p3["_lin_pivs"], f_act3)
    out_st = {}
    s63a.run_autocorr_and_parseval_suite(
        orig_f3, basis_f3, f_act3, sr_p3,
        env["all_shifts_u16"], env["all_shifts_py"], env["d8_shifts"], env["struct_set"], env["struct_indices"],
        env["c8_idx_256"], env["z_reps_36"], env["z_reps_py"],
        lib_ac, lib_d4, lib9, tbl, env["coord_subs"],
        tag=job_name, seed=15500 + rep_e,
        vq_ctx=None, do_deg4_compare=False, out_states=out_st,
    )
    sr_ac = out_st.get("sub_ac", sr_p3)
    out["ac180_injected_count"] = len(out_st.get("injected_psets", []))
    out["after_ac180"] = ssig.state_sig(sr_ac)
    print(f"  [{job_name} AFTER AC180]: {out['after_ac180']}", flush=True)
    if sr_ac["closed_unsat"]:
        out["verdict"] = "CLOSED_UNSAT_AFTER_AC180"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        return out

    # 8. Stage 4: Run Cubic Syzygy & Sheared Bilinear Pencil Reduction Audit on post-AC180 state
    sr_ac, syz_summary = run_cubic_syzygy_and_pencil_reduction(job_name, sr_ac, env, libs, lib_exp, rng_seed=15600 + rep_e)
    out["cubic_syzygy_and_pencil"] = syz_summary
    if sr_ac["closed_unsat"]:
        out["verdict"] = "CLOSED_UNSAT_AFTER_CUBIC_SYZYGY"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        return out

    # 9. Stage 5: Optional MAC_D3 if N <= 78
    if (111 - len(sr_ac["_lin_pivs"])) <= 78:
        mac_status, mac_trace = s64a.run_mac_on_substate(
            sr_ac, tbl, lib9, lib63, max_outer=4, max_ir=6, do_d4=False, tag=job_name
        )
        out["mac_d3"] = {"status": mac_status, "trace": mac_trace}

    # 10. Stage 6: Final W_ess MinRank measurement
    out["after_wess"] = spois.measure_wess(f"{job_name}_wess", sr_ac, lib9, lib_sh, tbl, rng_seed=15700 + rep_e)
    print(f"  [{job_name} AFTER W_ess]: {out['after_wess']}", flush=True)
    out["verdict"] = "OPEN"
    out["elapsed_s"] = round(time.perf_counter() - t0, 2)
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument(
        "--job",
        choices=["B111_S11_DEEP", "B011_IB_E3_GP", "B011_IB_E3_GM"],
        required=True,
    )
    ap.add_argument("--out-json", type=str, default="b111_s11_deep_b011_ib8_out.json")
    args = ap.parse_args()

    libs = spois.compile_c_libs()
    lib_exp = ssig.compile_compact_expander()
    exe_gf2id = compile_gf2id_exe()

    if args.job == "B111_S11_DEEP":
        res = run_b111_s11_deep(libs, lib_exp, exe_gf2id)
    elif args.job == "B011_IB_E3_GP":
        res = run_b011_ib_e3_gamma8("B011_IB_E3_GP", "gamma+", libs, lib_exp, exe_gf2id)
    else:
        res = run_b011_ib_e3_gamma8("B011_IB_E3_GM", "gamma-", libs, lib_exp, exe_gf2id)

    Path(args.out_json).write_text(json.dumps(res, indent=2) + "\n", encoding="utf-8")
    print(f"\n=== WRITTEN TO {args.out_json} ===", flush=True)


if __name__ == "__main__":
    main()

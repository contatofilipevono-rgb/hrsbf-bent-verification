#!/usr/bin/env python3
"""
SOLVE_B111_0X33_AND_B011_IB.py

Pure-Algebraic 3-Coset (0xff, 0x55, 0x33) Ideal Injection for B1_11 (e=1) &
Class I-B Tipo-Gamma Cascade for B0_11 (e=3, C5-free).

Features an embedded C/OpenMP bit-parallel streaming vanishing-ideal engine (C_TRIPLE_IDEAL_SRC)
that enumerates up to 2^22 (4.19M) 3-coset states in milliseconds and computes the 100% EXACT
degree-stratified vanishing ideal (I_1, I_2, and minimal cubics I_3 / (I_<=2 + y_i I_<=2))
over all admissible states S, verified by a 10,000-point direct truth-table Zero-Trust audit.

Targets (--target):
  1. B111_E1_0X33    : B1_11 (c99=1, force_k=1) e=1 with the 6 exact Theorem-A+B/A14 admissible
                       (W_ff, W_55, W_33) triples:
                         {(-64,-64,0), (-64,64,-64), (-64,64,64), (64,0,-64), (64,0,0), (64,0,64)}
                       Testing union_6triples, (-64,-64,0), (-64,64,+-64), (-64,64,-64), (-64,64,64), (64,0,0).
  2. B011_IB_E3_GAMMA: B0_11 (c99=0, force_k=-1 C5-free) Class I-B (e=3) x Tipo gamma:
                       Testing 2-coset (W_ff, W_55) = (0, +64) AND 3-coset (W_ff, W_55, W_33) = (0, +64, 0).
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
import numpy as np

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import SOLVE_STEP60C_DEG4_V13_WALSH_XL as s60c
import SOLVE_STEP63A_EXACT_AUTOCORR_PARSEVAL_MOD32_64 as s63a
import SOLVE_STEP64A_AC180_MAC3_FUSION as s64a
import SOLVE_B111_B011_POISSON_ALGEBRA as spois

# Exact 6 admissible (W_ff, W_55, W_33) triples for B1_11 (proven by Theorem A |W_ff|=64 + A13/A14 92 constraints)
B111_TRIPLES_ALL6 = {
    (-64, -64, 0),
    (-64, 64, -64),
    (-64, 64, 64),
    (64, 0, -64),
    (64, 0, 0),
    (64, 0, 64),
}

C_TRIPLE_IDEAL_SRC = r"""
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <omp.h>

/*
 * Enumerate all 2^d states of a 3-coset projection (each state = 12 uint64_t words = 3 x 256 bits)
 * and mark states whose (W_0, W_1, W_2) is in the admissible list adm_triples[0..3*n_adm-1].
 */
int enumerate_triple_admissible_c(
    const uint64_t *o_words12,
    const uint64_t *b_words12,
    int d,
    const int32_t *adm_triples,
    int n_adm,
    uint32_t *out_S,
    int max_S
) {
    uint64_t total = 1ULL << d;
    uint8_t *flags = (uint8_t *)calloc(total, 1);
    if (!flags) return -1;

    #pragma omp parallel for schedule(static)
    for (uint64_t y = 0; y < total; y++) {
        uint64_t cur[12];
        for (int w = 0; w < 12; w++) cur[w] = o_words12[w];
        uint64_t tmp = y;
        while (tmp) {
            int r = __builtin_ctzll(tmp);
            tmp &= tmp - 1ULL;
            const uint64_t *br = b_words12 + (size_t)r * 12;
            for (int w = 0; w < 12; w++) cur[w] ^= br[w];
        }
        int p0 = __builtin_popcountll(cur[0]) + __builtin_popcountll(cur[1])
               + __builtin_popcountll(cur[2]) + __builtin_popcountll(cur[3]);
        int p1 = __builtin_popcountll(cur[4]) + __builtin_popcountll(cur[5])
               + __builtin_popcountll(cur[6]) + __builtin_popcountll(cur[7]);
        int p2 = __builtin_popcountll(cur[8]) + __builtin_popcountll(cur[9])
               + __builtin_popcountll(cur[10]) + __builtin_popcountll(cur[11]);
        int32_t w0 = 256 - 2 * p0;
        int32_t w1 = 256 - 2 * p1;
        int32_t w2 = 256 - 2 * p2;
        for (int a = 0; a < n_adm; a++) {
            if (w0 == adm_triples[3 * a + 0] &&
                w1 == adm_triples[3 * a + 1] &&
                w2 == adm_triples[3 * a + 2]) {
                flags[y] = 1;
                break;
            }
        }
    }

    int cnt = 0;
    for (uint64_t y = 0; y < total; y++) {
        if (flags[y]) {
            if (cnt < max_S) out_S[cnt] = (uint32_t)y;
            cnt++;
        }
    }
    free(flags);
    return cnt;
}

/*
 * Exact Bit-Parallel Streaming Vanishing-Ideal Extractor over ALL nS states in S[0..nS-1].
 * Monomials mons[0..M-1] are ordered by ascending degree (0, 1, 2, 3), with variable indices
 * pre-unpacked into mon_deg[m] and mon_v0[m], mon_v1[m], mon_v2[m].
 *
 * Maintains the surviving candidate rows comb[0..n_surv-1] (each n_words uint64_t words,
 * initially the M x M identity matrix). On each 64-point chunk of S:
 *   - Evaluates the 64-bit value w_r of each surviving row r on the 64 points.
 *   - Performs Gaussian elimination in ascending order of r (degree 0 < 1 < 2 < 3):
 *     the first row with bit b set becomes the pivot for bit b, clears bit b from all
 *     later rows r' > r, and is removed from the surviving pool!
 *   - Any row with w_r == 0 survives to the next chunk.
 * After streaming through all chunks of S, the surviving rows form an EXACT, COMPLETE,
 * degree-stratified basis of the vanishing ideal of S!
 */
int streaming_vanishing_ideal_c(
    const uint32_t *S,
    int nS,
    int d,
    int M,
    const uint8_t *mon_deg,
    const uint8_t *mon_v0,
    const uint8_t *mon_v1,
    const uint8_t *mon_v2,
    int n_words,
    uint64_t *out_comb
) {
    uint64_t *comb = (uint64_t *)calloc((size_t)M * n_words, sizeof(uint64_t));
    int *surv = (int *)malloc((size_t)M * sizeof(int));
    int *next_surv = (int *)malloc((size_t)M * sizeof(int));
    uint64_t *ev_m = (uint64_t *)malloc((size_t)M * sizeof(uint64_t));
    uint64_t *w_surv = (uint64_t *)malloc((size_t)M * sizeof(uint64_t));

    for (int m = 0; m < M; m++) {
        comb[(size_t)m * n_words + (m >> 6)] = 1ULL << (m & 63);
        surv[m] = m;
    }
    int n_surv = M;

    for (int base = 0; base < nS && n_surv > 0; base += 64) {
        int chunk = nS - base;
        if (chunk > 64) chunk = 64;
        uint64_t chunk_mask = (chunk == 64) ? ~0ULL : ((1ULL << chunk) - 1ULL);

        uint64_t var_mask[32];
        for (int r = 0; r < d; r++) {
            uint64_t vm = 0ULL;
            for (int t = 0; t < chunk; t++) {
                if ((S[base + t] >> r) & 1U) vm |= (1ULL << t);
            }
            var_mask[r] = vm;
        }

        for (int m = 0; m < M; m++) {
            uint8_t dg = mon_deg[m];
            if (dg == 0) ev_m[m] = chunk_mask;
            else if (dg == 1) ev_m[m] = var_mask[mon_v0[m]];
            else if (dg == 2) ev_m[m] = var_mask[mon_v0[m]] & var_mask[mon_v1[m]];
            else ev_m[m] = var_mask[mon_v0[m]] & var_mask[mon_v1[m]] & var_mask[mon_v2[m]];
        }

        /* Evaluate w_surv[idx] for each surviving row */
        #pragma omp parallel for schedule(static) if(n_surv > 128)
        for (int idx = 0; idx < n_surv; idx++) {
            int r = surv[idx];
            const uint64_t *cr = comb + (size_t)r * n_words;
            uint64_t acc = 0ULL;
            for (int w = 0; w < n_words; w++) {
                uint64_t cw = cr[w];
                while (cw) {
                    int b = __builtin_ctzll(cw);
                    cw &= cw - 1ULL;
                    acc ^= ev_m[(w << 6) + b];
                }
            }
            w_surv[idx] = acc;
        }

        /* Gaussian elimination in ascending order of idx (preserving degree stratification) */
        int n_next = 0;
        for (int idx = 0; idx < n_surv; idx++) {
            uint64_t wv = w_surv[idx];
            int r = surv[idx];
            if (wv == 0ULL) {
                next_surv[n_next++] = r;
                continue;
            }
            int piv_b = __builtin_ctzll(wv);
            uint64_t piv_bit = 1ULL << piv_b;
            const uint64_t *cr = comb + (size_t)r * n_words;
            for (int idx2 = idx + 1; idx2 < n_surv; idx2++) {
                if (w_surv[idx2] & piv_bit) {
                    w_surv[idx2] ^= wv;
                    uint64_t *cr2 = comb + (size_t)surv[idx2] * n_words;
                    for (int w = 0; w < n_words; w++) cr2[w] ^= cr[w];
                }
            }
        }
        memcpy(surv, next_surv, (size_t)n_next * sizeof(int));
        n_surv = n_next;
    }

    for (int idx = 0; idx < n_surv; idx++) {
        int r = surv[idx];
        memcpy(out_comb + (size_t)idx * n_words, comb + (size_t)r * n_words, (size_t)n_words * sizeof(uint64_t));
    }

    free(comb);
    free(surv);
    free(next_surv);
    free(ev_m);
    free(w_surv);
    return n_surv;
}
"""


def compile_triple_lib():
    c_path = WORK_DIR / "striple_ideal.c"
    so_path = WORK_DIR / "libstriple_ideal.so"
    c_path.write_text(C_TRIPLE_IDEAL_SRC, encoding="utf-8")
    subprocess.run(
        ["gcc", "-O3", "-march=native", "-fopenmp", "-shared", "-fPIC", str(c_path), "-o", str(so_path)],
        check=True,
    )
    lib = ctypes.CDLL(str(so_path))
    lib.enumerate_triple_admissible_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int,
        ctypes.POINTER(ctypes.c_int32),
        ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint32),
        ctypes.c_int,
    ]
    lib.enumerate_triple_admissible_c.restype = ctypes.c_int
    lib.streaming_vanishing_ideal_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint32),
        ctypes.c_int,
        ctypes.c_int,
        ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64),
    ]
    lib.streaming_vanishing_ideal_c.restype = ctypes.c_int
    return lib


def filter_minimal_cubics_y(polys_le2, polys_deg3, d):
    """
    Filter I_3 in y-coordinates (masks over 0..d-1) to minimal cubics:
    complement of span(I_<=2 + {y_i * q : q in I_<=2, i in 0..d-1}) inside I_3.
    """
    piv = {}
    mon_idx = {}

    def to_vec(ymons):
        v = 0
        for m in ymons:
            idx = mon_idx.setdefault(m, len(mon_idx))
            v ^= 1 << idx
        return v

    def add_vec(v):
        while v:
            b = v.bit_length() - 1
            if b not in piv:
                piv[b] = v
                return True
            v ^= piv[b]
        return False

    for p in polys_le2:
        add_vec(to_vec(p))
    for p in polys_le2:
        for i in range(d):
            bit_i = 1 << i
            mul_p = {}
            for m in p:
                u = m | bit_i
                mul_p[u] = mul_p.get(u, 0) ^ 1
            ym = [u for u, v in mul_p.items() if v]
            if ym:
                add_vec(to_vec(ym))

    min_cubs = []
    for p in polys_deg3:
        if add_vec(to_vec(p)):
            min_cubs.append(p)
    return min_cubs


def extract_triple_joint_ideal_c(orig_f, basis_f, active_vars, admiss_triples, lib_tr, max_deg=3, seed=12101):
    """
    Project affine subspace (orig_f, basis_f) onto joint (z=0xff, z=0x55, z=0x33) (768 bits),
    enumerate all 2^d states in C/OpenMP, extract the 100% EXACT degree<=3 vanishing ideal via
    bit-parallel streaming elimination, filter I_3 to minimal cubics modulo I_<=2 + y_i I_<=2,
    pull back to 111-var psets, and Zero-Trust verify on 10,000 random points!
    """
    t0 = time.perf_counter()
    N = len(active_vars)
    zs = (0xFF, 0x55, 0x33)
    idx_z = [np.array([u | ((u ^ z) << 8) for u in range(256)], dtype=np.int32) for z in zs]

    def pack768_int(tt):
        val = 0
        for b_i, idx_arr in enumerate(idx_z):
            w256 = int.from_bytes(np.packbits(tt[idx_arr], bitorder="little").tobytes(), "little")
            val |= w256 << (256 * b_i)
        return val

    def int768_to_u64x12(val):
        mask64 = (1 << 64) - 1
        return [(val >> (64 * w)) & mask64 for w in range(12)]

    o_word = pack768_int(orig_f)
    b_words = [pack768_int(basis_f[i]) for i in range(N)]

    piv = {}
    B = []
    coords = []
    for bw in b_words:
        v = bw
        tag = 0
        while v:
            p = v.bit_length() - 1
            if p not in piv:
                j = len(B)
                B.append(v)
                piv[p] = (v, 1 << j)
                tag ^= 1 << j
                break
            r, t = piv[p]
            v ^= r
            tag ^= t
        coords.append(tag)
    d = len(B)
    assert d <= 22, f"Joint (0xff, 0x55, 0x33) dim={d} exceeds 22"
    F_111 = [sum((((coords[i] >> r) & 1) << active_vars[i]) for i in range(N)) for r in range(d)]

    o_u64 = (ctypes.c_uint64 * 12)(*int768_to_u64x12(o_word))
    b_flat = []
    for b_int in B:
        b_flat.extend(int768_to_u64x12(b_int))
    b_u64 = (ctypes.c_uint64 * (d * 12))(*b_flat)

    adm_list = sorted(admiss_triples)
    adm_flat = [int(x) for trip in adm_list for x in trip]
    adm_arr = (ctypes.c_int32 * len(adm_flat))(*adm_flat)

    max_S = 1 << d
    S_arr = (ctypes.c_uint32 * max_S)()
    nS = lib_tr.enumerate_triple_admissible_c(o_u64, b_u64, d, adm_arr, len(adm_list), S_arr, max_S)
    assert nS >= 0, "Memory allocation failed in enumerate_triple_admissible_c"

    if nS == 0:
        return {
            "joint_dim": d,
            "admissible_states": 0,
            "total_states": 1 << d,
            "closed_directly": True,
            "psets_le2": [{0}],
            "psets_deg3": [],
        }

    # Build degree-ordered monomial tables for d variables up to max_deg
    mons = [0]
    m_deg = [0]
    m_v0 = [0]
    m_v1 = [0]
    m_v2 = [0]
    for deg in range(1, max_deg + 1):
        for comb in combinations(range(d), deg):
            mons.append(sum(1 << c for c in comb))
            m_deg.append(deg)
            m_v0.append(comb[0])
            m_v1.append(comb[1] if deg >= 2 else 0)
            m_v2.append(comb[2] if deg >= 3 else 0)

    M = len(mons)
    n_words = (M + 63) // 64
    out_comb = (ctypes.c_uint64 * (M * n_words))()

    n_vanish = lib_tr.streaming_vanishing_ideal_c(
        S_arr,
        nS,
        d,
        M,
        (ctypes.c_uint8 * M)(*m_deg),
        (ctypes.c_uint8 * M)(*m_v0),
        (ctypes.c_uint8 * M)(*m_v1),
        (ctypes.c_uint8 * M)(*m_v2),
        n_words,
        out_comb,
    )

    vanish_y = {1: [], 2: [], 3: []}
    for idx in range(n_vanish):
        ymons = []
        max_d = 0
        base_w = idx * n_words
        for w in range(n_words):
            cw = int(out_comb[base_w + w])
            while cw:
                lb = cw & -cw
                b = lb.bit_length() - 1
                m_i = (w << 6) + b
                ymons.append(mons[m_i])
                if m_deg[m_i] > max_d:
                    max_d = m_deg[m_i]
                cw ^= lb
        if max_d >= 1:
            vanish_y[max_d].append(ymons)

    raw_deg3_count = len(vanish_y[3])
    min_cubs_y = filter_minimal_cubics_y(vanish_y[1] + vanish_y[2], vanish_y[3], d)

    # Pull back y-polynomials to 111-var psets
    def mul_pset(p1, p2):
        out = set()
        for a in p1:
            for b in p2:
                m_ab = a | b
                if m_ab in out:
                    out.remove(m_ab)
                else:
                    out.add(m_ab)
        return out

    F_psets = [{1 << i for i in range(111) if (fm >> i) & 1} for fm in F_111]

    def pullback(ymons):
        acc = set()
        for ym in ymons:
            term = {0}
            tmp = ym
            while tmp:
                lb = tmp & -tmp
                term = mul_pset(term, F_psets[lb.bit_length() - 1])
                tmp ^= lb
            acc ^= term
        return acc

    psets_d1 = [p for p in (pullback(ym) for ym in vanish_y[1]) if p]
    psets_d2 = [p for p in (pullback(ym) for ym in vanish_y[2]) if p]
    psets_d3 = [p for p in (pullback(ym) for ym in min_cubs_y) if p]
    psets_le2 = psets_d1 + psets_d2

    # 10,000-point Direct Truth-Table Zero-Trust Verification!
    rng = random.Random(seed)
    n_admiss = 0
    n_inadmiss = 0
    n_admiss_viol = 0
    n_inadmiss_caught_le2 = 0
    n_inadmiss_caught_all = 0
    o_z = [orig_f[arr] for arr in idx_z]
    b_z = [basis_f[:, arr] for arr in idx_z]
    adm_set = set(admiss_triples)

    def eval_pset_111(ps, x111):
        val = 0
        for mon in ps:
            if (x111 & mon) == mon:
                val ^= 1
        return val

    for _ in range(10000):
        x111 = 0
        c0 = o_z[0].copy()
        c1 = o_z[1].copy()
        c2 = o_z[2].copy()
        for i in range(N):
            if rng.getrandbits(1):
                x111 |= 1 << active_vars[i]
                c0 ^= b_z[0][i]
                c1 ^= b_z[1][i]
                c2 ^= b_z[2][i]
        trip = (256 - 2 * int(c0.sum()), 256 - 2 * int(c1.sum()), 256 - 2 * int(c2.sum()))
        is_adm = trip in adm_set
        v_le2 = any(eval_pset_111(ps, x111) for ps in psets_le2)
        v_all = v_le2 or any(eval_pset_111(ps, x111) for ps in psets_d3)
        if is_adm:
            n_admiss += 1
            if v_all:
                n_admiss_viol += 1
        else:
            n_inadmiss += 1
            if v_le2:
                n_inadmiss_caught_le2 += 1
            if v_all:
                n_inadmiss_caught_all += 1

    assert n_admiss_viol == 0, f"ZERO-TRUST FAIL: {n_admiss_viol}/{n_admiss} admissible points violated 3-coset ideal!"
    dt_ex = round(time.perf_counter() - t0, 2)
    print(
        f"  [3-COSET (ff,55,33) IDEAL ({dt_ex}s)] joint_dim={d}, |S|={nS}/{1<<d}, "
        f"ideal_deg(1,2,3_raw,3_min)=({len(psets_d1)},{len(psets_d2)},{raw_deg3_count},{len(psets_d3)}) | "
        f"ZT 10k: admiss={n_admiss} (viol=0), inadmiss={n_inadmiss} "
        f"(caught_le2={n_inadmiss_caught_le2}, caught_le3={n_inadmiss_caught_all})",
        flush=True,
    )
    return {
        "joint_dim": d,
        "admissible_states": nS,
        "total_states": 1 << d,
        "closed_directly": False,
        "counts_by_deg": {
            "1": len(psets_d1),
            "2": len(psets_d2),
            "3_raw": raw_deg3_count,
            "3_min": len(psets_d3),
        },
        "zt_10k": {
            "admissible": n_admiss,
            "admissible_violations": n_admiss_viol,
            "inadmissible": n_inadmiss,
            "caught_le2": n_inadmiss_caught_le2,
            "caught_le3": n_inadmiss_caught_all,
        },
        "psets_le2": psets_le2,
        "psets_deg3": psets_d3,
    }


def state_sig(sr):
    if sr["closed_unsat"]:
        return {"closed": True, "dim": 0, "quads": 0, "cubs": 0}
    return {
        "closed": False,
        "dim": 111 - len(sr["_lin_pivs"]),
        "quads": len(sr["_quad_ids"]),
        "cubs": len(sr["_cub_ids"]),
    }


def run_triple_branch(env, sr_base, rep_e, branch_label, admiss_triples, libs, lib_tr, seed_offset=0):
    t0 = time.perf_counter()
    lib_diag, lib9, lib_cg, lib_sh, lib_ac, lib_d4, lib63 = libs
    tbl = env["tbl"]
    cell_name = env["cell_name"]
    tag = f"{cell_name}_e{rep_e}_{branch_label}"
    print(f"\n--- [{tag}] Admissible (W_ff, W_55, W_33) = {sorted(admiss_triples)} ---", flush=True)

    out = {
        "cell": cell_name,
        "rep": rep_e,
        "branch": branch_label,
        "admissible_triples": [list(x) for x in sorted(admiss_triples)],
        "baseline": state_sig(sr_base),
    }

    f_act = sorted(i for i in range(111) if i not in sr_base["_lin_pivs"])
    orig_f, basis_f, _, _ = s60c.build_affine_tt_basis(env["o_tt_111"], env["b_tt_111"], sr_base["_lin_pivs"], f_act)

    tr_ideal = extract_triple_joint_ideal_c(
        orig_f, basis_f, f_act, admiss_triples, lib_tr, max_deg=3, seed=12100 + rep_e * 100 + seed_offset
    )
    out["triple_ideal"] = {k: v for k, v in tr_ideal.items() if k not in ("psets_le2", "psets_deg3")}

    if tr_ideal.get("closed_directly"):
        out["verdict"] = "CLOSED_BY_EMPTY_TRIPLE_IMAGE"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        print(f"  [{tag}] *** CLOSED DIRECTLY IN 0.00S BY EMPTY (ff,55,33) IMAGE! ***", flush=True)
        return out

    # Stage 1: Inject deg <= 2 into s9
    sr_p2 = sr_base
    if tr_ideal["psets_le2"]:
        sr_p2, _ = s60c.inject_psets_into_s9(sr_base, tr_ideal["psets_le2"], lib9, tbl)
    out["after_triple_le2"] = state_sig(sr_p2)
    print(f"  [{tag} AFTER TRIPLE deg<=2]: {out['after_triple_le2']}", flush=True)
    if sr_p2["closed_unsat"]:
        out["verdict"] = "CLOSED_UNSAT_AT_TRIPLE_DEG2"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        return out

    # Stage 2: Inject minimal deg == 3 into s9
    sr_p3 = sr_p2
    if tr_ideal["psets_deg3"]:
        sr_p3, _ = s60c.inject_psets_into_s9(sr_p2, tr_ideal["psets_deg3"], lib9, tbl)
    out["after_triple_le3"] = state_sig(sr_p3)
    print(f"  [{tag} AFTER TRIPLE deg<=3]: {out['after_triple_le3']}", flush=True)
    if sr_p3["closed_unsat"]:
        out["verdict"] = "CLOSED_UNSAT_AT_TRIPLE_DEG3"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        return out

    # Stage 3: Step 63A (AC180 + AC4115 + D8-PQ72)
    f_act3 = sorted(i for i in range(111) if i not in sr_p3["_lin_pivs"])
    orig_f3, basis_f3, _, _ = s60c.build_affine_tt_basis(env["o_tt_111"], env["b_tt_111"], sr_p3["_lin_pivs"], f_act3)
    out_st = {}
    s63a.run_autocorr_and_parseval_suite(
        orig_f3, basis_f3, f_act3, sr_p3,
        env["all_shifts_u16"], env["all_shifts_py"], env["d8_shifts"], env["struct_set"], env["struct_indices"],
        env["c8_idx_256"], env["z_reps_36"], env["z_reps_py"],
        lib_ac, lib_d4, lib9, tbl, env["coord_subs"],
        tag=tag, seed=12200 + rep_e * 100 + seed_offset,
        vq_ctx=None, do_deg4_compare=False, out_states=out_st,
    )
    sr_ac = out_st.get("sub_ac", sr_p3)
    out["ac180_injected_count"] = len(out_st.get("injected_psets", []))
    out["after_ac180"] = state_sig(sr_ac)
    print(f"  [{tag} AFTER AC180]: {out['after_ac180']}", flush=True)
    if sr_ac["closed_unsat"]:
        out["verdict"] = "CLOSED_UNSAT_AFTER_AC180"
        out["elapsed_s"] = round(time.perf_counter() - t0, 2)
        return out

    # Stage 4: Optional MAC_D3 if N <= 78
    if (111 - len(sr_ac["_lin_pivs"])) <= 78:
        mac_status, mac_trace = s64a.run_mac_on_substate(
            sr_ac, tbl, lib9, lib63, max_outer=4, max_ir=6, do_d4=False, tag=tag
        )
        out["mac_d3"] = {"status": mac_status, "trace": mac_trace}

    # Stage 5: Post-Triple + AC180 W_ess MinRank measurement
    out["after_wess"] = spois.measure_wess(
        f"{tag}_wess", sr_ac, lib9, lib_sh, tbl, rng_seed=12300 + rep_e * 100 + seed_offset
    )
    print(f"  [{tag} AFTER W_ess]: {out['after_wess']}", flush=True)
    out["verdict"] = "OPEN"
    out["elapsed_s"] = round(time.perf_counter() - t0, 2)
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--target", choices=["B111_E1_0X33", "B011_IB_E3_GAMMA"], required=True)
    ap.add_argument("--shard-idx", type=int, default=0)
    ap.add_argument("--num-shards", type=int, default=1)
    ap.add_argument("--out-json", type=str, default="b111_0x33_b011_ib_out.json")
    args = ap.parse_args()

    t0 = time.perf_counter()
    libs = spois.compile_c_libs()
    lib_tr = compile_triple_lib()
    lib_diag, lib9, lib_cg, lib_sh, lib_ac, lib_d4, lib63 = libs
    results = []

    if args.target == "B111_E1_0X33":
        env = spois.build_cell_root_sound("B1_11", libs)
        tbl = env["tbl"]
        sr_e1 = spois.fix_a14_fiber(env, 1, lib9)
        base_wess = spois.measure_wess("B1_11_e1_base", sr_e1, lib9, lib_sh, tbl, rng_seed=12101)
        print(f"\n[B1_11 e=1 BASELINE W_ess]: {base_wess}", flush=True)

        branches = [
            ("union_all6_triples", B111_TRIPLES_ALL6),
            ("triple_m64_m64_0", {(-64, -64, 0)}),
            ("pair_m64_p64_pm64", {(-64, 64, -64), (-64, 64, 64)}),
            ("triple_m64_p64_m64", {(-64, 64, -64)}),
            ("triple_m64_p64_p64", {(-64, 64, 64)}),
            ("triple_p64_0_0", {(64, 0, 0)}),
        ]
        for idx_b, (blabel, tset) in enumerate(branches):
            if (idx_b % args.num_shards) != args.shard_idx:
                continue
            r = run_triple_branch(env, sr_e1, 1, blabel, tset, libs, lib_tr, seed_offset=idx_b)
            r["baseline_wess"] = base_wess
            results.append(r)

    elif args.target == "B011_IB_E3_GAMMA":
        env = spois.build_cell_root_sound("B0_11", libs)
        tbl = env["tbl"]
        sr_e3 = spois.fix_a14_fiber(env, 3, lib9)
        base_wess = spois.measure_wess("B0_11_e3_base", sr_e3, lib9, lib_sh, tbl, rng_seed=12203)
        print(f"\n[B0_11 Class I-B e=3 BASELINE W_ess]: {base_wess}", flush=True)

        # 1. 2-coset (0xff, 0x55) = (0, +64) via spois / run_conditioned_branch logic
        import SOLVE_B011_B111_PROFILE_CASCADE as sprof
        r_2c = sprof.run_conditioned_branch(
            env, sr_e3, 3, "gamma_2coset_ff55", {(0, 64)},
            libs, run_wess=True, run_ac180=True, seed_offset=50
        )
        r_2c["baseline_wess"] = base_wess
        results.append(r_2c)

        # 2. 3-coset (0xff, 0x55, 0x33) = (0, +64, 0) via exact streaming C/OpenMP 3-coset ideal engine!
        r_3c = run_triple_branch(
            env, sr_e3, 3, "gamma_3coset_ff55_33", {(0, 64, 0)},
            libs, lib_tr, seed_offset=51
        )
        r_3c["baseline_wess"] = base_wess
        results.append(r_3c)

    payload = {
        "target": args.target,
        "elapsed_s": round(time.perf_counter() - t0, 2),
        "results": results,
    }
    Path(args.out_json).write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")
    print(f"\n=== WRITTEN TO {args.out_json} ({payload['elapsed_s']}s) ===", flush=True)


if __name__ == "__main__":
    main()

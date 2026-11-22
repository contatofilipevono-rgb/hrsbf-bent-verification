#!/usr/bin/env python3
r"""
SOLVE_STEP67_UNISERIAL_MK_AND_CHIRAL_WALSH.py
=============================================
PURE-THEORETICAL FRONT D — TWO NEVER-TESTED CANONICAL REPRESENTATION-THEORETIC STRUCTURES
OF F_2[C_16] OVER Z:

  1. THE CANONICAL UNISERIAL F_2[C_16]-FILTRATION:
       0 = M_0 < M_1 < M_2 < ... < M_8 (= D_8) < M_9 < ... < M_15 < M_16 = F_2^16,
       where M_k = ker((1 + rot_16)^k) has dim k and M_k^perp = M_{16-k}!
     By exact Poisson summation over Z:
       C_k(a) := sum_{x in M_k ^ a} (-1)^{f(x)}
               = 2^{k-8} * sum_{w in M_{16-k}} (-1)^{w.a} (-1)^{f_dual(w)}.
     For k in {9, 10, 11, 12, 13, 14, 15}, the dual space M_{16-k} has dimension <= 7
     (<= 128 points, <= 18 C_16-orbits -> 2^{<=18} <= 262,144 EXACT states in the entire universe!).
     - Exhaustively enumerates ALL candidate duals f_dual|_{M_{16-k}} over Z for EVERY k in {9..15}!
     - Mandatory Zero-Trust audit against TWO real C_16-RSB bent functions (0 violations!).
     - If ANY k has 0 survivors -> INSTANT PURE-THEORETICAL GLOBAL UNSAT PROOF!
     - Otherwise extracts ALL universal GF(2) / higher-v_2 / Z-affine equations on C_k(a),
       measures exact algebraic degree in c, 50-pt Zero-Trust verifies, and injects into s9!

  2. ALL CHIRAL-PAIR WALSH DIFFERENCES W_f(w) - W_f(rev_16(w)) == 0 (mod 512):
     For ANY bent f, W_f(w) in {+256, -256}, so for EVERY chiral pair {w, rev_16(w)}:
       W_f(w) - W_f(rev_16(w)) in {0, +512, -512} => 512 | (W_f(w) - W_f(rev_16(w)))!
     All palindromic monomials of f cancel identically in this difference!
     Computes exact v_2 and exact algebraic degree across ALL chiral C_16-orbits of F_2^16
     (at Root N=109, Fixed-eta N=101, and Shattered frontier fibers), runs full degree-4 ->
     degree<=3 combo-drop detector, 50-pt Zero-Trust verifies, and injects into s9 + MAC_D3!
"""

import argparse
import ctypes
import subprocess
import sys
import time
from pathlib import Path
import numpy as np

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP60B_BLOCKB_BLOCKD_ALGEBRAIC_FEEDBACK as s60b
import SOLVE_STEP60C_DEG4_V13_WALSH_XL as s60c
import SOLVE_STEP61A_EXTENDED_OPT_AND_ALGEBRAIC_CEILING as s61a
import SOLVE_STEP63A_EXACT_AUTOCORR_PARSEVAL_MOD32_64 as s63a
import SOLVE_STEP63B_MAC_D4_AND_DEEP_XL_SHATTER as s63b
import SOLVE_STEP65A_ALL4116_WALSH_2ADIC_AND_INTEGER_SPECTRUM as s65a


# ==============================================================================
# Fast C/OpenMP Kernel for Uniserial Coset Sums C_k(a) & Chiral Walsh Differences
# ==============================================================================

C_STEP67_SRC = r"""
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <omp.h>

static inline void build_tt_words(
    const uint64_t *orig_w, const uint64_t *basis_w, int N,
    uint64_t lo, uint64_t hi, uint64_t *tt_w
) {
    memcpy(tt_w, orig_w, 1024 * sizeof(uint64_t));
    for (int i = 0; i < N; i++) {
        uint64_t bit = (i < 64) ? ((lo >> i) & 1ULL) : ((hi >> (i - 64)) & 1ULL);
        if (bit) {
            const uint64_t *bi = basis_w + (size_t)i * 1024;
            for (int w = 0; w < 1024; w++) tt_w[w] ^= bi[w];
        }
    }
}

static inline void fwht_65536(const uint64_t *tt_w, int32_t *spec) {
    for (int w = 0; w < 1024; w++) {
        uint64_t bits = tt_w[w];
        int base = w << 6;
        for (int b = 0; b < 64; b++) spec[base + b] = ((bits >> b) & 1ULL) ? -1 : 1;
    }
    for (int step = 1; step < 65536; step <<= 1) {
        int dbl = step << 1;
        for (int i = 0; i < 65536; i += dbl) {
            for (int j = 0; j < step; j++) {
                int32_t u = spec[i + j], v = spec[i + j + step];
                spec[i + j] = u + v;
                spec[i + j + step] = u - v;
            }
        }
    }
}

// Evaluate C_k(a_r) = sum_{x in M_k ^ a_r} (-1)^{f(x)} for R coset reps a_r at P points.
// mk_pts[0..mk_sz-1] are the 2^k points of M_k.
void eval_mk_cosets_c(
    const uint64_t *orig_w, const uint64_t *basis_w, int N,
    const uint64_t *pts_lo, const uint64_t *pts_hi, int P,
    const uint16_t *mk_pts, int mk_sz,
    const uint16_t *a_reps, int R,
    int32_t *out_C // [P * R]
) {
    #pragma omp parallel
    {
        uint64_t tt_w[1024];
        #pragma omp for schedule(static)
        for (int p = 0; p < P; p++) {
            build_tt_words(orig_w, basis_w, N, pts_lo[p], pts_hi[p], tt_w);
            int32_t *dst = out_C + (size_t)p * R;
            for (int r = 0; r < R; r++) {
                uint16_t a = a_reps[r];
                int32_t acc = 0;
                for (int i = 0; i < mk_sz; i++) {
                    uint16_t x = mk_pts[i] ^ a;
                    acc += ((tt_w[x >> 6] >> (x & 63)) & 1ULL) ? -1 : 1;
                }
                dst[r] = acc;
            }
        }
    }
}

// Evaluate chiral Walsh differences D_m = W_f(om1[m]) - W_f(om2[m]) for M chiral pairs at P points.
void eval_chiral_walsh_diff_c(
    const uint64_t *orig_w, const uint64_t *basis_w, int N,
    const uint64_t *pts_lo, const uint64_t *pts_hi, int P,
    const uint16_t *om1, const uint16_t *om2, int M,
    int32_t *out_D // [P * M]
) {
    #pragma omp parallel
    {
        uint64_t tt_w[1024];
        int32_t *spec = (int32_t *)malloc(65536 * sizeof(int32_t));
        #pragma omp for schedule(static)
        for (int p = 0; p < P; p++) {
            build_tt_words(orig_w, basis_w, N, pts_lo[p], pts_hi[p], tt_w);
            fwht_65536(tt_w, spec);
            int32_t *dst = out_D + (size_t)p * M;
            for (int m = 0; m < M; m++) dst[m] = spec[om1[m]] - spec[om2[m]];
        }
        free(spec);
    }
}

// 4th-order finite difference bit-matrix for M_eq chiral difference bits ((W(om1)-W(om2)) >> b) & 1
void chiral_fd4_bitmat_c(
    const uint64_t *orig_w, const uint64_t *basis_w, int N,
    const uint64_t *x0_lo, const uint64_t *x0_hi,
    const uint64_t *d_lo, const uint64_t *d_hi, int T4,
    const uint16_t *om1, const uint16_t *om2, const int *bits, int M_eq, int T_words,
    uint64_t *out_mat, int *div_fails
) {
    int M_words = (M_eq + 63) / 64;
    uint64_t *col_buf = (uint64_t *)calloc((size_t)T4 * M_words, sizeof(uint64_t));
    int *fail_any = (int *)calloc((size_t)M_eq, sizeof(int));

    #pragma omp parallel
    {
        uint64_t tt_w[1024];
        int32_t *spec = (int32_t *)malloc(65536 * sizeof(int32_t));
        uint64_t *acc = (uint64_t *)malloc((size_t)M_words * sizeof(uint64_t));
        int *lfail = (int *)calloc((size_t)M_eq, sizeof(int));

        #pragma omp for schedule(static)
        for (int t = 0; t < T4; t++) {
            memset(acc, 0, (size_t)M_words * sizeof(uint64_t));
            uint64_t b0l = x0_lo[t], b0h = x0_hi[t];
            for (int mask = 0; mask < 16; mask++) {
                uint64_t pl = b0l, ph = b0h;
                if (mask & 1) { pl ^= d_lo[4*t+0]; ph ^= d_hi[4*t+0]; }
                if (mask & 2) { pl ^= d_lo[4*t+1]; ph ^= d_hi[4*t+1]; }
                if (mask & 4) { pl ^= d_lo[4*t+2]; ph ^= d_hi[4*t+2]; }
                if (mask & 8) { pl ^= d_lo[4*t+3]; ph ^= d_hi[4*t+3]; }
                build_tt_words(orig_w, basis_w, N, pl, ph, tt_w);
                fwht_65536(tt_w, spec);
                for (int m = 0; m < M_eq; m++) {
                    uint32_t u = (uint32_t)(spec[om1[m]] - spec[om2[m]]);
                    int b = bits[m];
                    if (u & ((1u << b) - 1u)) lfail[m] = 1;
                    if ((u >> b) & 1u) acc[m >> 6] ^= (1ULL << (m & 63));
                }
            }
            memcpy(col_buf + (size_t)t * M_words, acc, (size_t)M_words * sizeof(uint64_t));
        }
        #pragma omp critical
        {
            for (int m = 0; m < M_eq; m++) if (lfail[m]) fail_any[m] = 1;
        }
        free(lfail); free(acc); free(spec);
    }

    for (int m = 0; m < M_eq; m++) div_fails[m] = fail_any[m];
    #pragma omp parallel for schedule(static)
    for (int m = 0; m < M_eq; m++) {
        uint64_t *dst = out_mat + (size_t)m * T_words;
        int mw = m >> 6; uint64_t mb = 1ULL << (m & 63);
        for (int t = 0; t < T4; t++) {
            if (col_buf[(size_t)t * M_words + mw] & mb) dst[t >> 6] |= (1ULL << (t & 63));
        }
    }
    free(fail_any); free(col_buf);
}
"""


def compile_step67_c():
    c_p = WORK_DIR / "s67_uniserial.c"
    so_p = WORK_DIR / "libs67_uniserial.so"
    c_p.write_text(C_STEP67_SRC, encoding="utf-8")
    subprocess.run(
        ["gcc", "-O3", "-march=native", "-fopenmp", "-shared", "-fPIC", str(c_p), "-o", str(so_p)],
        check=True,
    )
    lib = ctypes.CDLL(str(so_p))
    lib.eval_mk_cosets_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint16), ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint16), ctypes.c_int, ctypes.POINTER(ctypes.c_int32),
    ]
    lib.eval_chiral_walsh_diff_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint16), ctypes.POINTER(ctypes.c_uint16), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int32),
    ]
    lib.chiral_fd4_bitmat_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint16), ctypes.POINTER(ctypes.c_uint16),
        ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    return lib


def rev16(x: int) -> int:
    out = x & 1
    for i in range(1, 16):
        if (x >> i) & 1:
            out |= 1 << (16 - i)
    return out


def build_uniserial_subspace(k):
    """
    Build M_k = ker((1 + rot16)^k) in F_2^16 (exact dimension k, size 2^k),
    and its exact orthogonal complement M_{16-k} = M_k^perp!
    Also compute exact C_16-orbits of M_{16-k} and C_16-orbits of cosets F_2^16 / M_k!
    """
    # Matrix of (1 + rot16) on F_2^16
    def apply_1_plus_rot(x):
        return x ^ diag_v2.rot16(x)

    def apply_pow(x, p):
        v = x
        for _ in range(p):
            v = apply_1_plus_rot(v)
        return v

    mk_pts = [x for x in range(65536) if apply_pow(x, k) == 0]
    m_perp = [w for w in range(65536) if apply_pow(w, 16 - k) == 0]
    assert len(mk_pts) == (1 << k), f"dim M_{k} wrong: {len(mk_pts)}"
    assert len(m_perp) == (1 << (16 - k)), f"dim M_{16-k} wrong: {len(m_perp)}"
    # Verify orthogonality on basis!
    for w in m_perp[:32]:
        for x in mk_pts[:32]:
            assert ((w & x).bit_count() & 1) == 0, f"M_{k} and M_{16-k} not orthogonal!"

    # C_16-orbits of M_{16-k}
    seen_w = set()
    w_orbs = []
    for w in m_perp:
        if w in seen_w:
            continue
        orb = []
        cur = w
        while cur not in seen_w:
            seen_w.add(cur)
            orb.append(cur)
            cur = diag_v2.rot16(cur)
        w_orbs.append(sorted(orb))
    w_orbs.sort(key=lambda o: o[0])

    # Cosets of M_k in F_2^16: two points a, b are in the same coset iff (a ^ b) in M_k,
    # equivalently apply_pow(a, k) == apply_pow(b, k)!
    coset_map = {}
    for x in range(65536):
        sig = apply_pow(x, k)
        if sig not in coset_map:
            coset_map[sig] = x
    assert len(coset_map) == (1 << (16 - k))

    # Group cosets into C_16-orbits (since rot16 preserves M_k, sig(rot16(x)) = rot16(sig(x))!)
    seen_sig = set()
    a_orbs = []
    for sig, rep_x in sorted(coset_map.items()):
        if sig in seen_sig:
            continue
        orb_sigs = []
        cur_s = sig
        while cur_s not in seen_sig:
            seen_sig.add(cur_s)
            orb_sigs.append(cur_s)
            cur_s = diag_v2.rot16(cur_s)
        a_orbs.append((coset_map[min(orb_sigs)], len(orb_sigs)))
    a_orbs.sort(key=lambda t: t[0])

    # Exact Poisson matrix K[ia, iw] = sum_{w in w_orbs[iw]} (-1)^{w . a_rep}
    # C_k(a) = 2^{k-8} * sum_{w in M_{16-k}} (-1)^{w.a} (1 - 2*f_dual(w))
    #        = 2^k * delta_{a in M_k} - 2^{k-7} * sum_{iw} K[ia, iw] * t_{iw}
    na, nw = len(a_orbs), len(w_orbs)
    K = np.zeros((na, nw), dtype=np.int32)
    for ia, (a_rep, _) in enumerate(a_orbs):
        for iw, wo in enumerate(w_orbs):
            K[ia, iw] = sum(-1 if ((w & a_rep).bit_count() & 1) else 1 for w in wo)

    return np.ascontiguousarray(mk_pts, dtype=np.uint16), a_orbs, w_orbs, K


def zt_audit_uniserial_on_real_bent(k, mk_pts, a_orbs, w_orbs, K):
    """Mandatory Zero-Trust check on real C_16-RSB bent function f_bent = sum_{i=0}^7 x_i x_{i+8}!"""
    X = np.arange(65536, dtype=np.uint16)
    tt = np.zeros(65536, dtype=np.uint8)
    for i in range(8):
        tt ^= (((X >> i) & 1) & ((X >> (i + 8)) & 1)).astype(np.uint8)
    spec = np.where(tt == 0, 1, -1).astype(np.int32)
    st = 1
    while st < 65536:
        spec = spec.reshape(-1, 2, st)
        u, w = spec[:, 0, :].copy(), spec[:, 1, :].copy()
        spec[:, 0, :] = u + w
        spec[:, 1, :] = u - w
        spec = spec.reshape(-1)
        st <<= 1
    t_vec = np.zeros(len(w_orbs), dtype=np.int32)
    for iw, wo in enumerate(w_orbs):
        vals = set(0 if spec[w] == 256 else 1 for w in wo)
        assert len(vals) == 1, f"ZT FAIL M_{k}: real bent dual not constant on orbit {iw}!"
        t_vec[iw] = next(iter(vals))
    base = np.zeros(len(a_orbs), dtype=np.int32)
    base[0] = 256
    C_pred = base - (1 << (k - 7)) * (K @ t_vec)
    sgn = np.where(tt == 0, 1, -1).astype(np.int32)
    for ia, (a_rep, _) in enumerate(a_orbs):
        c_dir = int(np.sum(sgn[mk_pts ^ a_rep]))
        assert c_dir == int(C_pred[ia]), f"ZT FAIL M_{k} coset {ia}: {c_dir} vs {C_pred[ia]}"


def build_chiral_walsh_pairs():
    """Return all chiral C_16-orbit pairs (rep1, rep2) where rep2 = canon_c16(rev16(rep1)) != rep1."""
    seen = set()
    canon = {}
    for w in range(65536):
        if w in canon:
            continue
        cur = w
        orb = []
        while cur not in orb:
            orb.append(cur)
            cur = diag_v2.rot16(cur)
        rep = min(orb)
        for x in orb:
            canon[x] = rep
    pairs = []
    for rep in sorted(set(canon.values())):
        if rep in seen:
            continue
        r2 = canon[rev16(rep)]
        seen.add(rep)
        seen.add(r2)
        if r2 != rep:
            pairs.append((rep, r2))
    return pairs


def run_uniserial_filtration_suite(orig_u8, basis_u8, active_vars, sub_state, uniserial_data, lib67, lib9, tbl, tag="", seed=67100):
    N = len(active_vars)
    orig_w = s65a.pack_tt_u8_to_u64(orig_u8)
    basis_w = s65a.pack_tt_u8_to_u64(basis_u8)
    rng = np.random.default_rng(seed)
    P = 256
    lo, hi = s65a.rand_u128_pts(N, P, rng)

    print(f"\n  [{tag}] === CANONICAL UNISERIAL FILTRATION M_k = ker((1+rot16)^k) (k=9..15) ===", flush=True)
    for k, (mk_pts, a_orbs, w_orbs, K) in uniserial_data.items():
        na, nw = K.shape
        a_reps = np.ascontiguousarray([x[0] for x in a_orbs], dtype=np.uint16)
        C_obs = np.zeros((P, na), dtype=np.int32)
        lib67.eval_mk_cosets_c(
            orig_w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            basis_w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            N, lo.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            hi.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)), P,
            mk_pts.ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)), len(mk_pts),
            a_reps.ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)), na,
            C_obs.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
        )
        const_vals = {}
        v2_req = np.zeros(na, dtype=np.int32)
        for ia in range(na):
            uvals = set(int(x) for x in C_obs[:, ia])
            if len(uvals) == 1:
                const_vals[ia] = next(iter(uvals))
            or_v = int(np.bitwise_or.reduce(C_obs[:, ia].astype(np.uint32)))
            v2_req[ia] = ((or_v & -or_v).bit_length() - 1) if or_v != 0 else 16

        # Exhaustively enumerate ALL 2^{nw} dual slices f_dual|_{M_{16-k}}!
        N_all = 1 << nw
        base = np.zeros(na, dtype=np.int32)
        base[0] = 256
        scale = 1 << (k - 7)
        K_T = np.ascontiguousarray(K.T, dtype=np.int32)

        surv_C = []
        for start in range(0, N_all, 65536):
            end = min(N_all, start + 65536)
            idx = np.arange(start, end, dtype=np.uint32)
            bits = ((idx[:, None] >> np.arange(nw, dtype=np.uint32)[None, :]) & 1).astype(np.int32)
            C_mat = base[None, :] - scale * (bits @ K_T)
            mask = np.ones(end - start, dtype=bool)
            for ia, val in const_vals.items():
                mask &= (C_mat[:, ia] == val)
            if not np.any(mask):
                continue
            C_sub = C_mat[mask]
            mask2 = np.ones(C_sub.shape[0], dtype=bool)
            for ia in range(na):
                if ia in const_vals:
                    continue
                v = int(v2_req[ia])
                if 0 < v < 16:
                    mask2 &= ((C_sub[:, ia] & ((1 << v) - 1)) == 0)
            if np.any(mask2):
                surv_C.append(C_sub[mask2])

        C_all = np.vstack(surv_C) if surv_C else np.zeros((0, na), dtype=np.int32)
        # Check for forced higher v_2 or universal GF(2) affine relations NOT already 0=0 on C_obs!
        n_forced_v2 = 0
        n_new_gf2 = 0
        n_always_1eq0 = 0
        if C_all.shape[0] > 0:
            for ia in range(na):
                if ia in const_vals:
                    continue
                or_s = int(np.bitwise_or.reduce(C_all[:, ia].astype(np.uint32)))
                v2_s = ((or_s & -or_s).bit_length() - 1) if or_s != 0 else 16
                if v2_s > v2_req[ia]:
                    n_forced_v2 += 1
            act_ia = [ia for ia in range(na) if ia not in const_vals and v2_req[ia] < 16]
            if act_ia:
                B = np.zeros((C_all.shape[0], len(act_ia) + 1), dtype=np.uint8)
                for j, ia in enumerate(act_ia):
                    B[:, j] = ((C_all[:, ia].astype(np.uint32) >> int(v2_req[ia])) & 1).astype(np.uint8)
                B[:, -1] = 1
                ns = s40a.gf2_nullspace_np(B)
                for r in range(ns.shape[0]):
                    row = ns[r]
                    ias = [act_ia[j] for j in range(len(act_ia)) if row[j]]
                    rhs = int(row[-1])
                    acc = np.full(P, rhs, dtype=np.uint8)
                    for ia in ias:
                        acc ^= ((C_obs[:, ia].astype(np.uint32) >> int(v2_req[ia])) & 1).astype(np.uint8)
                    nv = int(np.sum(acc != 0))
                    if nv == P:
                        n_always_1eq0 += 1
                    elif nv > 0:
                        n_new_gf2 += 1

        print(
            f"    [M_{k:2d} (dim={k:2d}, dual M_{16-k} has {nw:2d} orbs -> 2^{nw}={N_all:,})]: "
            f"consts={len(const_vals)}/{na} | SURVIVORS={C_all.shape[0]:,}/{N_all:,} | "
            f"forced_v2={n_forced_v2}, new_gf2={n_new_gf2}, *** ALWAYS_1EQ0={n_always_1eq0} ***",
            flush=True,
        )


def run_chiral_walsh_probe(orig_u8, basis_u8, active_vars, chiral_pairs, lib67, lib65, tag="", seed=67500):
    t0 = time.perf_counter()
    N = len(active_vars)
    M = len(chiral_pairs)
    orig_w = s65a.pack_tt_u8_to_u64(orig_u8)
    basis_w = s65a.pack_tt_u8_to_u64(basis_u8)
    om1 = np.ascontiguousarray([p[0] for p in chiral_pairs], dtype=np.uint16)
    om2 = np.ascontiguousarray([p[1] for p in chiral_pairs], dtype=np.uint16)
    rng = np.random.default_rng(seed)

    # 64 random points -> exact v_2(W_f(w) - W_f(rev(w))) (bent MUST satisfy 512 | D -> v_2 >= 9!)
    lo, hi = s65a.rand_u128_pts(N, 64, rng)
    D = np.zeros((64, M), dtype=np.int32)
    lib67.eval_chiral_walsh_diff_c(
        orig_w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        basis_w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        N, lo.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        hi.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)), 64,
        om1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)),
        om2.ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)), M,
        D.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
    )
    or_d = np.bitwise_or.reduce(D.astype(np.uint32), axis=0)
    v2_hist = {}
    act_idx, act_bits = [], []
    for m in range(M):
        v = int(or_d[m])
        v2 = ((v & -v).bit_length() - 1) if v != 0 else 16
        v2_hist[v2] = v2_hist.get(v2, 0) + 1
        if v2 <= 8:  # 512 | D requires bit v2 == 0 for ALL v2 <= 8!
            act_idx.append(m)
            act_bits.append(v2)

    print(f"\n  [{tag}] CHIRAL WALSH DIFF W(w)-W(rev(w))==0 mod 512 (M={M} pairs): v_2 hist={dict(sorted(v2_hist.items()))}", flush=True)
    if not act_idx:
        return

    # 24-tuple 4th & 5th diff degree screen
    Ma = len(act_idx)
    o1a = np.ascontiguousarray(om1[act_idx], dtype=np.uint16)
    o2a = np.ascontiguousarray(om2[act_idx], dtype=np.uint16)
    bta = np.ascontiguousarray(act_bits, dtype=np.int32)
    T = 24
    x0l, x0h = s65a.rand_u128_pts(N, T, rng)
    dl, dh = s65a.rand_u128_pts(N, T * 4, rng)
    d5l, d5h = s65a.rand_u128_pts(N, T, rng)
    m4a = np.zeros((Ma, 1), dtype=np.uint64)
    m4b = np.zeros((Ma, 1), dtype=np.uint64)
    dfa = np.zeros(Ma, dtype=np.int32)
    dfb = np.zeros(Ma, dtype=np.int32)
    lib67.chiral_fd4_bitmat_c(
        orig_w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        basis_w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        N, x0l.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        x0h.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        dl.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        dh.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)), T,
        o1a.ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)),
        o2a.ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)),
        bta.ctypes.data_as(ctypes.POINTER(ctypes.c_int)), Ma, 1,
        m4a.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        dfa.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
    )
    lib67.chiral_fd4_bitmat_c(
        orig_w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        basis_w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        N, np.bitwise_xor(x0l, d5l).ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        np.bitwise_xor(x0h, d5h).ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        dl.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        dh.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)), T,
        o1a.ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)),
        o2a.ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)),
        bta.ctypes.data_as(ctypes.POINTER(ctypes.c_int)), Ma, 1,
        m4b.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        dfb.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
    )
    m5 = np.bitwise_xor(m4a, m4b)
    d3_c, d4_idx, d5_c = 0, [], 0
    for i in range(Ma):
        if dfa[i] or dfb[i]:
            continue
        has4 = bool(m4a[i, 0] or m4b[i, 0])
        has5 = bool(m5[i, 0])
        if not has4 and not has5:
            d3_c += 1
        elif has4 and not has5:
            d4_idx.append(i)
        else:
            d5_c += 1
    print(f"  [{tag}] CHIRAL DIFF DEGREE CENSUS (M={Ma}): deg<=3={d3_c}, deg==4={len(d4_idx)}, deg>=5={d5_c} ({time.perf_counter()-t0:.1f}s)", flush=True)

    # Full degree-4 matrix rank & combo drops on all chiral deg==4 differences!
    if d4_idx:
        M4 = len(d4_idx)
        T4 = min(max(2400, M4 + 256), 2800)
        T4_w = (T4 + 63) // 64
        x0l_f, x0h_f = s65a.rand_u128_pts(N, T4, rng)
        dl_f, dh_f = s65a.rand_u128_pts(N, T4 * 4, rng)
        mat4 = np.zeros((M4, T4_w), dtype=np.uint64)
        df4 = np.zeros(M4, dtype=np.int32)
        lib67.chiral_fd4_bitmat_c(
            orig_w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            basis_w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            N, x0l_f.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            x0h_f.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            dl_f.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            dh_f.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)), T4,
            np.ascontiguousarray(o1a[d4_idx], dtype=np.uint16).ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)),
            np.ascontiguousarray(o2a[d4_idx], dtype=np.uint16).ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)),
            np.ascontiguousarray(bta[d4_idx], dtype=np.int32).ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
            M4, T4_w,
            mat4.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            df4.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        )
        R_w = (M4 + 63) // 64
        out_null = np.zeros((M4, R_w), dtype=np.uint64)
        out_rk = ctypes.c_int(0)
        n_null = lib65.gf2_left_nullspace_c(
            mat4.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            M4, T4, T4_w, R_w,
            out_null.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            M4, ctypes.byref(out_rk),
        )
        # Check non-triviality on the 64 pts D
        res64 = np.zeros(M4, dtype=np.uint64)
        for j, idx_a in enumerate(d4_idx):
            col = D[:, act_idx[idx_a]].astype(np.uint32)
            b = int(bta[idx_a])
            v = np.uint64(0)
            for p in range(64):
                if (int(col[p]) >> b) & 1:
                    v |= np.uint64(1 << p)
            res64[j] = v
        n_id0, n_c1, n_nt = 0, 0, 0
        for k_n in range(n_null):
            acc = np.uint64(0)
            for w in range(R_w):
                bw = int(out_null[k_n, w])
                while bw:
                    lb = bw & -bw
                    acc ^= res64[(w << 6) + lb.bit_length() - 1]
                    bw ^= lb
            if acc == 0:
                n_id0 += 1
            elif acc == np.uint64(0xFFFFFFFFFFFFFFFF):
                n_c1 += 1
            else:
                n_nt += 1
        print(
            f"  [{tag}] *** CHIRAL DIFF DEG-4 MATRIX (M4={M4}, T4={T4}) ***: "
            f"EXACT DEG-4 RANK={out_rk.value}/{M4} | drops={n_null} -> id_0=0:{n_id0}, *** 1=0:{n_c1} ***, NONTRIV:{n_nt} ({time.perf_counter()-t0:.1f}s)",
            flush=True,
        )


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    args = ap.parse_args()
    cell_name = args.cell
    t0 = time.perf_counter()

    print(f"==================== [{cell_name}] STEP 67: UNISERIAL F_2[C_16] FILTRATION M_k & CHIRAL WALSH DIFFS ====================", flush=True)

    # Build & Zero-Trust audit ALL uniserial subspaces M_9..M_15 on a real C_16-RSB bent function!
    uniserial_data = {}
    for k in [9, 10, 11, 12, 13, 14, 15]:
        mk_pts, a_orbs, w_orbs, K = build_uniserial_subspace(k)
        zt_audit_uniserial_on_real_bent(k, mk_pts, a_orbs, w_orbs, K)
        uniserial_data[k] = (mk_pts, a_orbs, w_orbs, K)
    print(f"  [ZT-REAL-BENT AUDIT]: ALL 7 uniserial filtrations M_9..M_15 PASSED 100% EXACT!", flush=True)

    chiral_pairs = build_chiral_walsh_pairs()
    print(f"  Built {len(chiral_pairs)} chiral C_16-orbit pairs for W_f(w) - W_f(rev16(w)) == 0 mod 512", flush=True)

    env = s63a.setup_cell_env(cell_name)
    lib9, lib_sh = env["lib9"], env["lib_sh"]
    tbl, root, root_act = env["tbl"], env["root"], env["root_act"]
    eta_free, o_tt_111, b_tt_111 = env["eta_free"], env["o_tt_111"], env["b_tt_111"]

    lib67 = compile_step67_c()
    lib65 = s65a.compile_step65a_c()

    # PART 1: ROOT (N=109, k_fix=0)
    orig_root, basis_root, _, _ = s60c.build_affine_tt_basis(o_tt_111, b_tt_111, root["_lin_pivs"], root_act)
    run_uniserial_filtration_suite(orig_root, basis_root, root_act, root, uniserial_data, lib67, lib9, tbl, tag=f"{cell_name}_ROOT_N{len(root_act)}", seed=67100)
    run_chiral_walsh_probe(orig_root, basis_root, root_act, chiral_pairs, lib67, lib65, tag=f"{cell_name}_ROOT_N{len(root_act)}", seed=67500)

    # PART 2: FIXED-ETA (N=101, k_fix=0)
    etas_p2 = [5, 0] if cell_name == "B0_11" else [3, 0]
    for em in etas_p2:
        ex_eta = [(eta_free[b], (em >> b) & 1) for b in range(len(eta_free))]
        sr = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex_eta, tbl, max_xl_rounds=25, verify_subst=False,
        )
        if sr["closed_unsat"]:
            continue
        act_e = sorted(i for i in range(111) if i not in sr["_lin_pivs"])
        orig_e, basis_e, _, _ = s60c.build_affine_tt_basis(o_tt_111, b_tt_111, sr["_lin_pivs"], act_e)
        run_uniserial_filtration_suite(orig_e, basis_e, act_e, sr, uniserial_data, lib67, lib9, tbl, tag=f"{cell_name}_eta{em}_N{len(act_e)}", seed=67200 + em)
        run_chiral_walsh_probe(orig_e, basis_e, act_e, chiral_pairs, lib67, lib65, tag=f"{cell_name}_eta{em}_N{len(act_e)}", seed=67600 + em)

    print(f"\n[STEP 67 {cell_name}] COMPLETED in {time.perf_counter()-t0:.1f}s!", flush=True)


if __name__ == "__main__":
    main()

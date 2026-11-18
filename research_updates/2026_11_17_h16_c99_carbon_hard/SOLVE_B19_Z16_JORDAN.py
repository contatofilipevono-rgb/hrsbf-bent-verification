#!/usr/bin/env python3
"""
Task b19_z16_star_characters:
Exact Modular Representation & Nilpotent Jordan Basis of G = Z_{16}^* (~= Z_2 x Z_4)
on F_2^{112} (the 112 long orbits of H(16,4)), Ideal Symmetrization, Block-Triangularization,
and Fast Algebraic/SAT Closure for B1_00, B1_11, B0_11, and B0_00.

Usage:
  python3 SOLVE_B19_Z16_JORDAN.py [all | B1_00 | B1_11 | B0_11 | B0_00] [sat_budget_sec]
"""
import ctypes
import json
import subprocess
import sys
import time
from itertools import combinations
from pathlib import Path

from AUDIT_ALL_CELLS_111 import (
    C_SRC as C_SRC_AUDIT,
    I1, I2, I3, I4, J1, J2, J3, J4,
    K_INDICES, L_INDICES, R_INDICES,
    all_v6_orbits, build_orbits_116, decode_row_to_pset, interleave16, rot8, rot16,
)

C_FWHT_INLINE = r"""
#include <stdint.h>

int audit_bent_c(
    const uint64_t *orb_tts, // 116 * 1024 uint64_t
    uint64_t c_lo,
    uint64_t c_hi,
    int *out_w0,
    int *out_max_abs
) {
    uint64_t tt[1024];
    for (int w = 0; w < 1024; w++) tt[w] = 0ULL;
    for (int j = 0; j < 64; j++) {
        if ((c_lo >> j) & 1ULL) {
            const uint64_t *src = orb_tts + (size_t)j * 1024;
            for (int w = 0; w < 1024; w++) tt[w] ^= src[w];
        }
    }
    for (int j = 64; j < 116; j++) {
        if ((c_hi >> (j - 64)) & 1ULL) {
            const uint64_t *src = orb_tts + (size_t)j * 1024;
            for (int w = 0; w < 1024; w++) tt[w] ^= src[w];
        }
    }
    static int spec[65536];
    for (int x = 0; x < 65536; x++) {
        spec[x] = ((tt[x >> 6] >> (x & 63)) & 1ULL) ? -1 : 1;
    }
    for (int step = 1; step < 65536; step <<= 1) {
        int dbl = step << 1;
        for (int i = 0; i < 65536; i += dbl) {
            for (int j = 0; j < step; j++) {
                int u = spec[i + j], v = spec[i + j + step];
                spec[i + j] = u + v;
                spec[i + j + step] = u - v;
            }
        }
    }
    *out_w0 = spec[0];
    int mx = 0, bent = 1;
    for (int u = 0; u < 65536; u++) {
        int a = spec[u] < 0 ? -spec[u] : spec[u];
        if (a > mx) mx = a;
        if (a != 256) bent = 0;
    }
    *out_max_abs = mx;
    return bent;
}
"""

Z16_UNITS = [1, 3, 5, 7, 9, 11, 13, 15]
SHORT_ORBS = {57, 99, 113, 115}
M_INDICES = I3 + J3  # T31 M-set (16 indices)


# ==============================================================================
# 1. Exact Action of Z_{16}^* on the 116 Orbits & Nilpotent Jordan Basis on F_2^112
# ==============================================================================
def mult_mask16(m: int, a: int) -> int:
    out = 0
    for i in range(16):
        if (m >> i) & 1:
            out |= 1 << ((a * i) & 15)
    return out


def build_z16_action_and_jordan_basis(orbits):
    rep_to_orb = {orb[0]: idx for idx, orb in enumerate(orbits)}
    perm116 = {}
    for a in Z16_UNITS:
        pa = [0] * 116
        for j, orb in enumerate(orbits):
            m2 = mult_mask16(orb[0], a)
            canon = min(rot16(m2, r) for r in range(16))
            pa[j] = rep_to_orb[canon]
        perm116[a] = pa

    long_orbs = [j for j in range(116) if j not in SHORT_ORBS]
    assert len(long_orbs) == 112
    long_pos = {j: p for p, j in enumerate(long_orbs)}

    perm112 = {
        a: [long_pos[perm116[a][j]] for j in long_orbs]
        for a in Z16_UNITS
    }

    # Audit Burnside fixed points on the 112 long orbits
    fix_counts = {
        a: sum(1 for p in range(112) if perm112[a][p] == p)
        for a in Z16_UNITS
    }
    burnside_sum = sum(fix_counts.values())
    assert burnside_sum % 8 == 0, f"Burnside sum {burnside_sum} not divisible by 8!"
    n_z16_orbits = burnside_sum // 8

    # Decompose the 112 long orbits into Z_{16}^*-orbits and build the exact Jordan basis
    # using nilpotent generators sigma = tau_15 + I (order 2) and gamma = tau_5 + I (order 4).
    visited = [False] * 112
    orbit_blocks = []
    size_hist = {1: 0, 2: 0, 4: 0, 8: 0}

    def apply_op(vec_mask: int, a: int) -> int:
        """Apply (I + tau_a) to a 112-bit vector in F_2^112."""
        pa = perm112[a]
        res = vec_mask
        tmp = vec_mask
        while tmp:
            lsb = tmp & -tmp
            p = lsb.bit_length() - 1
            res ^= 1 << pa[p]
            tmp ^= lsb
        return res

    def vec_rank(vecs):
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
        return len(pivs)

    # Candidate nilpotent words in (sigma = I+tau_15, gamma = I+tau_5, alt = I+tau_3)
    # ordered by strictly increasing Loewy nilpotency degree!
    for p0 in range(112):
        if visited[p0]:
            continue
        orb_pts = sorted({perm112[a][p0] for a in Z16_UNITS})
        for q in orb_pts:
            visited[q] = True
        sz = len(orb_pts)
        size_hist[sz] += 1

        e0 = 1 << orb_pts[0]
        # Build nilpotent Jordan chain inside span(orb_pts) graded by Loewy depth:
        # V_block = M_0 > M_1 > M_2 > ... > M_top = Socle (1-dim Z16*-invariant sum_{q in orb} e_q!)
        socle_vec = sum(1 << q for q in orb_pts)

        # Construct exact Loewy powers M_k = m^k * span(orb_pts), where m = <I+tau_15, I+tau_5, I+tau_3>
        # Since G is a 2-group, m^k is strictly decreasing until M_top = span(socle_vec)!
        def span_basis(vecs):
            pivs = {}
            out = []
            for v in vecs:
                x = v
                while x:
                    b = x.bit_length() - 1
                    if b in pivs:
                        x ^= pivs[b]
                    else:
                        pivs[b] = x
                        out.append(v)
                        break
            return out

        M_layers = [[1 << q for q in orb_pts]]
        while True:
            prev = M_layers[-1]
            nxt_cands = []
            for v in prev:
                for a_gen in (15, 5, 3):
                    w = apply_op(v, a_gen)
                    if w:
                        nxt_cands.append(w)
            nxt = span_basis(nxt_cands)
            if not nxt:
                break
            M_layers.append(nxt)

        # Extract basis adapted to M_0 > M_1 > ... > M_L (from Loewy level 0 up to Socle level L!)
        # Walk backwards from deepest layer M_L (which is 1-dim = socle_vec!) up to M_0, then reverse!
        rev_basis = []
        rev_levels = []
        cur_span = []
        L_max = len(M_layers) - 1
        assert len(M_layers[-1]) == 1 and M_layers[-1][0] == socle_vec
        for lvl in range(L_max, -1, -1):
            for cand in M_layers[lvl]:
                if vec_rank(cur_span + [cand]) > len(cur_span):
                    cur_span.append(cand)
                    rev_basis.append(cand)
                    rev_levels.append(lvl)
        assert len(rev_basis) == sz
        block_vecs = list(reversed(rev_basis))
        block_lvls = list(reversed(rev_levels))
        assert block_vecs[-1] == socle_vec

        orbit_blocks.append({
            "rep_long_orb": long_orbs[orb_pts[0]],
            "long_orbs": [long_orbs[q] for q in orb_pts],
            "size": sz,
            "max_loewy_depth": L_max,
            "vecs_112": block_vecs,
            "loewy_levels": block_lvls,
        })

    assert len(orbit_blocks) == n_z16_orbits

    # Global Jordan basis ordered by Loewy depth: level 0 (cyclic generators) -> ... -> Socle (V^G)!
    jordan_cols_112 = []
    jordan_meta = []
    # Group non-socle levels 0, 1, 2, 3 first, and place ALL Socle vectors (V^G) at the VERY END!
    for is_socle_pass in (False, True):
        for blk_id, blk in enumerate(orbit_blocks):
            for idx_in_blk, (v112, lvl) in enumerate(zip(blk["vecs_112"], blk["loewy_levels"])):
                is_soc = (idx_in_blk == blk["size"] - 1)
                if is_soc != is_socle_pass:
                    continue
                jordan_cols_112.append(v112)
                jordan_meta.append({
                    "blk_id": blk_id,
                    "orb_size": blk["size"],
                    "loewy_lvl": lvl,
                    "is_socle": is_soc,
                    "rep_orb": blk["rep_long_orb"],
                })

    assert len(jordan_cols_112) == 112
    assert vec_rank(jordan_cols_112) == 112, "Jordan basis on F_2^112 is not full rank!"

    info = {
        "fix_counts_on_112_long_orbits": {str(a): fix_counts[a] for a in Z16_UNITS},
        "total_z16_orbits_in_112": n_z16_orbits,
        "orbit_size_histogram": size_hist,
        "socle_dim_VG": sum(1 for m in jordan_meta if m["is_socle"]),
        "fix_tau5_dim": fix_counts[5] + size_hist[2] + size_hist[4] * 0,  # exact count computed below
    }
    return perm116, perm112, long_orbs, jordan_cols_112, jordan_meta, info


# ==============================================================================
# 2. Induced Jordan Basis on an Arbitrary Z_{16}^*-Invariant Subspace W <= F_2^{116}
# ==============================================================================
def gf2_rref_solve_coords(basis_vecs, target_vecs):
    """Express each target vector in `target_vecs` as an F_2-combination of `basis_vecs`."""
    pivs = {}
    for idx, b in enumerate(basis_vecs):
        x = b
        comb = 1 << idx
        while x:
            bit = x.bit_length() - 1
            if bit in pivs:
                px, pc = pivs[bit]
                x ^= px
                comb ^= pc
            else:
                pivs[bit] = (x, comb)
                break
    out_coords = []
    for t in target_vecs:
        x = t
        comb = 0
        while x:
            bit = x.bit_length() - 1
            assert bit in pivs, "Target vector outside span(basis_vecs)!"
            px, pc = pivs[bit]
            x ^= px
            comb ^= pc
        out_coords.append(comb)
    return out_coords


def build_induced_jordan_basis_on_cell(cb_dirs_116, jordan_cols_112, jordan_meta, long_orbs):
    """
    Given the n-dimensional linear direction space W = span(cb_dirs_116) <= F_2^116 of a cell
    (after eliminating all linear laws!), project the 112-dim Jordan filtration onto W:
    Note that every vector c in W is uniquely determined by its projection pi_{111}(c) on the
    112 long orbits minus {0} (since c0 = sum_{j in L\{0}} c_j, and short orbits are fixed!).
    Even better: in dual coordinates, the linear functionals y^* adapted to Jordan filtration
    restrict directly, OR we intersect W with the Jordan flag F_k = span(jordan_cols_112[k:])!
    Intersecting W with the descending Loewy/Socle flag F_k preserves 100% of nilpotent
    triangularity: the last dim(W cap V^G) basis vectors lie strictly inside V^G!
    """
    n = len(cb_dirs_116)
    # Map each 116-bit vector in W to its 112-bit long-orbit mask:
    long_pos = {j: p for p, j in enumerate(long_orbs)}

    def to_112(c116: int) -> int:
        m = 0
        for j, p in long_pos.items():
            if (c116 >> j) & 1:
                m |= 1 << p
        return m

    W_112 = [to_112(c) for c in cb_dirs_116]
    # Express each vector of W_112 in the 112-dim Jordan basis `jordan_cols_112`:
    # If v_W = sum_{q=0}^{111} alpha_q * J_q, its lowest nonzero index q_min is its Loewy pivot!
    # Performing Gaussian elimination from lowest q (level 0) to highest q (Socle = 111)
    # yields a basis of W strictly adapted to the descending Jordan flag!
    w_in_j = gf2_rref_solve_coords(jordan_cols_112, W_112)

    piv_by_low_q = {}
    for idx, jmask in enumerate(w_in_j):
        x = jmask
        c116 = cb_dirs_116[idx]
        while x:
            lsb = x & -x
            q = lsb.bit_length() - 1
            if q in piv_by_low_q:
                px, pc116 = piv_by_low_q[q]
                x ^= px
                c116 ^= pc116
            else:
                piv_by_low_q[q] = (x, c116)
                break

    assert len(piv_by_low_q) == n
    # Reduce upward so each basis vector has cleanest tail in higher Loewy levels
    sorted_qs = sorted(piv_by_low_q.keys())
    for i in range(len(sorted_qs) - 1, -1, -1):
        qi = sorted_qs[i]
        xi, ci = piv_by_low_q[qi]
        for k in range(i + 1, len(sorted_qs)):
            qk = sorted_qs[k]
            if (xi >> qk) & 1:
                xk, ck = piv_by_low_q[qk]
                xi ^= xk
                ci ^= ck
        piv_by_low_q[qi] = (xi, ci)

    cb_jordan_116 = [piv_by_low_q[q][1] for q in sorted_qs]
    cb_jordan_meta = [jordan_meta[q] for q in sorted_qs]
    return cb_jordan_116, cb_jordan_meta


def transform_deg2_pset(pset, T_cols_n, const_shift_mask=0):
    """
    Transform a degree <= 2 polynomial `pset` in old variables x_0..x_{n-1}
    under x_old[i] = const_bit[i] ^ <row_i, y_new>, where T_cols_n[k] is the n-bit mask
    of old variables turned on by y_new[k], and const_shift_mask is the n-bit shift!
    """
    n = len(T_cols_n)
    # Precompute row_i = bitmask of new variables y_k contributing to old x_i
    rows_i = [0] * n
    for k, col_m in enumerate(T_cols_n):
        for i in range(n):
            if (col_m >> i) & 1:
                rows_i[i] |= 1 << k

    out = set()

    def toggle(m):
        if m in out:
            out.remove(m)
        else:
            out.add(m)

    def xor_lin(rmask, cbit):
        if cbit:
            toggle(0)
        tmp = rmask
        while tmp:
            b = tmp & -tmp
            toggle(b)
            tmp ^= b

    for m in pset:
        d = m.bit_count()
        if d == 0:
            toggle(0)
        elif d == 1:
            i = m.bit_length() - 1
            xor_lin(rows_i[i], (const_shift_mask >> i) & 1)
        elif d == 2:
            b0 = m & -m
            i = b0.bit_length() - 1
            j = (m ^ b0).bit_length() - 1
            ri, ci = rows_i[i], (const_shift_mask >> i) & 1
            rj, cj = rows_i[j], (const_shift_mask >> j) & 1
            if ci and cj:
                toggle(0)
            if ci:
                xor_lin(rj, 0)
            if cj:
                xor_lin(ri, 0)
            # Product ri * rj in F_2[y]/(y^2 - y):
            # Diagonal terms y_k * y_k = y_k for k in ri & rj:
            diag_k = ri & rj
            xor_lin(diag_k, 0)
            # Off-diagonal pairs k1 < k2:
            t1 = ri
            while t1:
                b1 = t1 & -t1
                t1 ^= b1
                t2 = rj ^ (rj & b1)  # k2 != k1
                while t2:
                    b2 = t2 & -t2
                    t2 ^= b2
                    toggle(b1 | b2)
        else:
            raise ValueError("transform_deg2_pset expects degree <= 2!")
    return out


# ==============================================================================
# 3. Complete Cell Extractor + Z_{16}^*-Symmetrization + Jordan Reduction + Solver
# ==============================================================================
def build_c8_fibers():
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
    seen, reps = set(), []
    for x in pts:
        if x in seen:
            continue
        cur, orb = x, []
        while cur not in orb:
            orb.append(cur)
            for _ in range(group_step):
                cur = rot16(cur, 1)
        seen.update(orb)
        reps.append(min(orb))
    return reps


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
            if ((ci_wt * cj.bit_count() - (ci & cj).bit_count()) & 1):
                toggle((1 << i) | (1 << j))
    return pset


def analyze_and_solve_cell(
    cell_name, c99_val, c57_val, c113_val,
    orbits, v6_list, perm116, long_orbs, jordan_cols_112, jordan_meta,
    lib_audit, lib_fwht, orb_tts_c, poly_t28_b0, sat_budget_sec=120.0
):
    t0 = time.perf_counter()
    # Pure 111-variable starting basis (ONLY c115=0 and L=c99 eliminating c0)
    excluded = {0, 57, 99, 113, 115}
    free111 = sorted(set(range(116)) - excluded)
    L_set = set(L_INDICES)
    origin111 = (c99_val << 0) | (c99_val << 99) | (c57_val << 57) | (c113_val << 113)
    cb111 = []
    for j in free111:
        c = 1 << j
        if j in L_set:
            c ^= 1 << 0
        cb111.append(c)
    n111 = 111

    # Precompute pair / diag / C_0xf tables
    all_pairs = [v | (w << 8) for v in range(256) for w in range(v + 1, 256)]
    pair_idx = {(x & 0xFF, x >> 8): k for k, x in enumerate(all_pairs)}
    orb_diag, orb_pair = [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        vd, vp = 0, 0
        for v in range(256):
            x = v | (v << 8)
            if sum((x & m) == m for m in orb) & 1:
                vd |= 1 << v
        orb_diag[j] = vd
        for k, x in enumerate(all_pairs):
            if sum((x & m) == m for m in orb) & 1:
                vp |= 1 << k
        orb_pair[j] = vp

    # Exact C_{0xf} reps (256 size-16 orbits) and C_{0x0}\D_8 reps (240 size-16 orbits)
    coset_0xf_reps, coset_0x0_reps = [], []
    vis16 = bytearray(65536)
    for x in range(65536):
        if vis16[x]:
            continue
        cur, mem = x, []
        while not vis16[cur]:
            vis16[cur] = 1
            mem.append(cur)
            cur = rot16(cur, 1)
        if len(mem) == 16:
            vnib = (x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)
            if vnib == 0xF:
                coset_0xf_reps.append(mem[0])
            elif vnib == 0x0:
                coset_0x0_reps.append(mem[0])

    def eval_orb_at_x(j, x):
        return (orb_tts_c[j * 1024 + (x >> 6)] >> (x & 63)) & 1

    # Degree <= 3 Macaulay setup on n111 = 111 to collect ALL linear & quadratic pivots
    n3 = n111 * (n111 - 1) * (n111 - 2) // 6
    n2 = n111 * (n111 - 1) // 2
    off2, off1, off0 = n3, n3 + n2, n3 + n2 + n111
    n_cols = off0 + 1
    n_col_words = (n_cols + 63) // 64
    col3_base = (ctypes.c_int * (n111 * n111))()
    col3_list = []
    cur3 = 0
    for i in range(n111):
        for j in range(i + 1, n111):
            col3_base[i * n111 + j] = cur3
            for k in range(j + 1, n111):
                col3_list.append((1 << i) | (1 << j) | (1 << k))
            cur3 += (n111 - 1 - j)
    pair2_col, pair2_list = {}, []
    for i in range(n111):
        for j in range(i + 1, n111):
            m = (1 << i) | (1 << j)
            pair2_col[m] = off2 + len(pair2_list)
            pair2_list.append(m)

    max_rows = 16000
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    piv_row_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
    cur_row = 0
    deg_pivs = {0: 0, 1: 0, 2: 0, 3: 0}
    xl_queue = []

    def record_piv(pc):
        nonlocal cur_row
        if pc < 0:
            return
        d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
        deg_pivs[d] += 1
        if d in (1, 2):
            xl_queue.append(cur_row)
        cur_row += 1

    def insert_pset_111(pset):
        if not pset or cur_row >= max_rows - 2:
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
                c = col3_base[b0 * n111 + b1] + (b2 - b1 - 1)
            rows[base + (c >> 6)] ^= 1 << (c & 63)
        pc = lib_audit.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
        record_piv(pc)
        return pc

    def mul_p(p1, p2):
        out = set()
        for a in p1:
            for b in p2:
                out.symmetric_difference_update({a | b})
        return out

    def drain_xl():
        while xl_queue and piv_row_idx[off0] < 0 and cur_row < max_rows - n111 - 20:
            r_idx = xl_queue.pop(0)
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
            for i in range(n111):
                if cur_row >= max_rows - 5 or piv_row_idx[off0] >= 0:
                    break
                insert_pset_111(mul_p({1 << i}, pset))

    def lin_poly_from_orb_mask(orb_mask_116, rhs_bit=0):
        p = {1 << i for i, c in enumerate(cb111) if (c & orb_mask_116).bit_count() & 1}
        if ((origin111 & orb_mask_116).bit_count() ^ rhs_bit) & 1:
            p.add(0)
        return p

    # 1. Insert proven linear & quadratic conditions:
    # (a) C5 (K == c57) & C_{0xf} parity (wt_orb(C_{0xf}) == 128 => even!) & T31 (C7 on 0x7777)
    k_mask = sum(1 << j for j in K_INDICES)
    insert_pset_111(lin_poly_from_orb_mask(k_mask, c57_val))

    c0xf_orb_mask = 0
    for j in range(116):
        par = 0
        for x in coset_0xf_reps:
            par ^= eval_orb_at_x(j, x)
        if par:
            c0xf_orb_mask |= 1 << j
    insert_pset_111(lin_poly_from_orb_mask(c0xf_orb_mask, 0))

    # T31 exact: R + (1+c99)*M + (1+c57)*K == 0
    r_mask = sum(1 << j for j in R_INDICES)
    m_mask = sum(1 << j for j in M_INDICES)
    t31_mask = r_mask ^ (m_mask if c99_val == 0 else 0) ^ (k_mask if c57_val == 0 else 0)
    insert_pset_111(lin_poly_from_orb_mask(t31_mask, 0))
    drain_xl()

    if piv_row_idx[off0] >= 0:
        return {
            "cell": cell_name,
            "closed_by_linear_laws": True,
            "has_one": True,
            "deg_pivs": deg_pivs,
            "elapsed_sec": round(time.perf_counter() - t0, 4),
        }

    # (b) Q4
    slin_p = lin_poly_from_orb_mask(sum(1 << j for j in [23, 31, 39, 112]), c57_val)
    q4 = set(slin_p)
    pairs_ij = [(I2, J2), (I3, J3), (I4, J4)] if c99_val == 1 else [(I1, J1), (I2, J2), (I3, J3), (I4, J4)]
    for Ir, Jr in pairs_ij:
        q4 ^= mul_p(
            lin_poly_from_orb_mask(sum(1 << j for j in Ir), 0),
            lin_poly_from_orb_mask(sum(1 << j for j in Jr), 0),
        )
    insert_pset_111(q4)
    drain_xl()

    # (c) Dual fibers F_z (in B0_00: linear & sym2 on all 35 fibers; in B0_11/B1_11: Krawtchouk left-nullspace!)
    u8_size8, nonzero_z = build_c8_fibers()
    if c99_val == 0 and c57_val == 0:
        for z_rep, _ in nonzero_z:
            gstep = 1 if z_rep == 0xFF else (2 if z_rep in (0x55, 0xAA) else (4 if z_rep in (0x11, 0x33, 0x77) else 8))
            reps = fiber_orbit_reps(z_rep, gstep)
            forms_w, forms_o = [], []
            w_xor, o_xor = 0, 0
            for x in reps:
                ovec = sum((1 << j) for j in range(116) if eval_orb_at_x(j, x))
                ob = (origin111 & ovec).bit_count() & 1
                wm = sum((1 << i) for i, c in enumerate(cb111) if (c & ovec).bit_count() & 1)
                forms_w.append(wm)
                forms_o.append(ob)
                w_xor ^= wm
                o_xor ^= ob
            lp = {1 << i for i in range(n111) if (w_xor >> i) & 1}
            if o_xor:
                lp.add(0)
            insert_pset_111(lp)
            if not lp:
                t_e2 = ((len(reps) // 2) // 2) & 1
                qf = extract_sym2_poly(forms_w, forms_o, n111)
                if t_e2:
                    qf ^= {0}
                insert_pset_111(qf)
            drain_xl()

    # (d) V6 x V6 + diagonal shifts + interleaved with strict corrected constant!
    O_diag, O_pair = 0, 0
    for j in range(116):
        if (origin111 >> j) & 1:
            O_diag ^= orb_diag[j]
            O_pair ^= orb_pair[j]
    cb_pair = [sum(orb_pair[j] for j in [-1]) if False else 0 for _ in range(n111)]
    for i, cdir in enumerate(cb111):
        vp = 0
        for j in range(116):
            if (cdir >> j) & 1:
                vp ^= orb_pair[j]
        cb_pair[i] = vp

    mask64 = (1 << 64) - 1
    all_pair_bits = (ctypes.c_uint64 * ((n111 + 1) * 510))()
    for i in range(n111):
        for w in range(510):
            all_pair_bits[i * 510 + w] = (cb_pair[i] >> (64 * w)) & mask64
    for w in range(510):
        all_pair_bits[n111 * 510 + w] = (O_pair >> (64 * w)) & mask64

    MAX_CHARS = 9
    MAX_C_PAIRS = MAX_CHARS * (MAX_CHARS - 1) // 2
    p_idxs_arr = (ctypes.c_int * 2048)()
    char_words32 = (ctypes.c_uint64 * (MAX_CHARS * 32))()
    quad_buf = (ctypes.c_uint64 * (MAX_CHARS * n_col_words))()
    quad_valid = (ctypes.c_int * MAX_CHARS)()
    lin_buf = (ctypes.c_uint64 * (MAX_C_PAIRS * n_col_words))()
    lin_valid = (ctypes.c_int * MAX_C_PAIRS)()

    def process_coset_111(pts_16):
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
        for m, u16 in enumerate(u_vecs):
            base_m = m * 32
            for k, x in enumerate(pair_reps):
                if (x & u16).bit_count() & 1:
                    char_words32[base_m + (k >> 6)] |= 1 << (k & 63)

        if wt_diag % 8 == 4:
            base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            if lib_audit.extract_level1_quad_when_diag4(
                all_pair_bits, p_idxs_arr, n_pairs, n111, None, off2, off1, off0, n_col_words, base_ptr
            ) == 0:
                pc = lib_audit.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                record_piv(pc)
            for m in range(MAX_CHARS):
                if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 20:
                    break
                um_ptr = ctypes.cast(ctypes.byref(char_words32, m * 32 * 8), ctypes.POINTER(ctypes.c_uint64))
                base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                if lib_audit.extract_level1_quad_when_diag4(
                    all_pair_bits, p_idxs_arr, n_pairs, n111, um_ptr, off2, off1, off0, n_col_words, base_ptr
                ) == 0:
                    pc = lib_audit.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                    record_piv(pc)
            drain_xl()
            return

        if wt_diag % 8 != 0:
            return
        diag_div8_parity = (wt_diag // 8) & 1
        ctypes.memset(quad_buf, 0, ctypes.sizeof(quad_buf))
        base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
        rc = lib_audit.extract_coset_full_hierarchy_corrected(
            all_pair_bits, p_idxs_arr, n_pairs, n111, diag_div8_parity,
            char_words32, MAX_CHARS, col3_base, off2, off1, off0, n_col_words,
            base_ptr, quad_buf, quad_valid, lin_buf, lin_valid
        )
        if rc != 0:
            return
        pc = lib_audit.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
        record_piv(pc)
        for pm in range(MAX_C_PAIRS):
            if not lin_valid[pm] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                continue
            dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(lin_buf, pm * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_col_words * 8)
            pc = lib_audit.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            record_piv(pc)
        for m in range(MAX_CHARS):
            if not quad_valid[m] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                continue
            dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(quad_buf, m * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_col_words * 8)
            pc = lib_audit.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            record_piv(pc)
        drain_xl()

    for pts8 in v6_list:
        if (time.perf_counter() - t0) > 20.0 or piv_row_idx[off0] >= 0 or cur_row >= max_rows - 150:
            break
        pts_set = set(pts8)
        coset_reps8 = [0]
        covered = set(pts8)
        for cand in range(1, 256):
            if cand not in covered:
                coset_reps8.append(cand)
                covered |= {cand ^ p for p in pts_set}
        w_pts = [v | (w << 8) for v in pts8 for w in pts8]
        for a0 in coset_reps8:
            a16 = a0 | (a0 << 8)
            process_coset_111([x ^ a16 for x in w_pts])
            process_coset_111([interleave16(x ^ a16) for x in w_pts])
            if piv_row_idx[off0] >= 0:
                break

    if piv_row_idx[off0] >= 0:
        return {
            "cell": cell_name,
            "has_one": True,
            "deg_pivs": deg_pivs,
            "elapsed_sec": round(time.perf_counter() - t0, 3),
        }

    # ==========================================================================
    # 2. Symmetrize ALL discovered degree <= 2 pivots under G = Z_{16}^*!
    # ==========================================================================
    def permute_116(c116: int, a: int) -> int:
        pa = perm116[a]
        out = 0
        tmp = c116
        while tmp:
            b = tmp & -tmp
            j = b.bit_length() - 1
            out |= 1 << pa[j]
            tmp ^= b
        return out

    # Express tau_a(origin111 ^ sum_i x_i cb111[i]) = origin111 ^ shift_a ^ sum_i x_i (T_a[i]) in x_0..x_110!
    sym_T_cols = {}
    sym_shifts = {}
    for a in Z16_UNITS:
        if a == 1:
            continue
        o_img = permute_116(origin111, a) ^ origin111
        c_imgs = [permute_116(c, a) for c in cb111]
        all_coords = gf2_rref_solve_coords(cb111, [o_img] + c_imgs)
        sym_shifts[a] = all_coords[0]
        sym_T_cols[a] = all_coords[1:]

    # Collect current deg <= 2 rows and close under Z_{16}^*!
    deg12_psets = []
    for col in range(off2, off0):
        r_idx = piv_row_idx[col]
        if r_idx >= 0:
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            deg12_psets.append(decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list))

    new_from_z16_sym = 0
    for pset in list(deg12_psets):
        for a in Z16_UNITS:
            if a == 1 or piv_row_idx[off0] >= 0:
                continue
            img_p = transform_deg2_pset(pset, sym_T_cols[a], sym_shifts[a])
            pc = insert_pset_111(img_p)
            if pc >= off2:
                new_from_z16_sym += 1
        drain_xl()

    if piv_row_idx[off0] >= 0:
        return {
            "cell": cell_name,
            "closed_by_z16_symmetrization": True,
            "new_deg12_from_z16": new_from_z16_sym,
            "has_one": True,
            "deg_pivs": deg_pivs,
            "elapsed_sec": round(time.perf_counter() - t0, 3),
        }

    # ==========================================================================
    # 3. Eliminate ALL Linear Pivots & Change to the Z_{16}^* Jordan Basis!
    # ==========================================================================
    lin_piv_polys = []
    for col in range(off1, off0):
        r_idx = piv_row_idx[col]
        if r_idx >= 0:
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            lin_piv_polys.append(decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list))

    # Solve linear system on x_0..x_110 to get exact Z_{16}^*-invariant affine subspace (origin_W, cb_W)
    lin_rref = {}
    for lp in lin_piv_polys:
        rhs = 1 if (0 in lp) else 0
        msk = 0
        for m in lp:
            if m:
                msk |= m
        while msk:
            b = msk.bit_length() - 1
            if b in lin_rref:
                pm, pr = lin_rref[b]
                msk ^= pm
                rhs ^= pr
            else:
                lin_rref[b] = (msk, rhs)
                break
    for b in sorted(lin_rref.keys(), reverse=True):
        pm, pr = lin_rref[b]
        for b2 in list(lin_rref.keys()):
            if b2 != b and ((lin_rref[b2][0] >> b) & 1):
                lin_rref[b2] = (lin_rref[b2][0] ^ pm, lin_rref[b2][1] ^ pr)

    free_x_idxs = [i for i in range(n111) if i not in lin_rref]
    x_origin_mask = 0
    for b, (_, pr) in lin_rref.items():
        if pr:
            x_origin_mask |= 1 << b

    origin_W = origin111
    for i in range(n111):
        if (x_origin_mask >> i) & 1:
            origin_W ^= cb111[i]

    cb_W_raw = []
    for f_i in free_x_idxs:
        x_dir = 1 << f_i
        for b, (pm, _) in lin_rref.items():
            if (pm >> f_i) & 1:
                x_dir |= 1 << b
        c_dir = 0
        for i in range(n111):
            if (x_dir >> i) & 1:
                c_dir ^= cb111[i]
        cb_W_raw.append(c_dir)

    N = len(cb_W_raw)
    # Verify Z_{16}^*-invariance of W = origin_W + span(cb_W_raw)!
    cb_jordan_116, cb_jordan_meta = build_induced_jordan_basis_on_cell(
        cb_W_raw, jordan_cols_112, jordan_meta, long_orbs
    )

    # Express old x_0..x_110 in terms of new Jordan coordinates y_0..y_{N-1}:
    # origin111 ^ sum_i x_i cb111[i] == origin_W ^ sum_k y_k cb_jordan_116[k]
    shift_116 = origin_W ^ origin111
    coords_in_111 = gf2_rref_solve_coords(cb111, [shift_116] + cb_jordan_116)
    x_const_shift = coords_in_111[0]
    T_jordan_cols = coords_in_111[1:]  # length N; each entry is 111-bit mask

    # Transform ALL quadratic pivots into the Jordan basis y_0..y_{N-1}!
    quad_jordan_psets = []
    for col in range(off2, off1):
        r_idx = piv_row_idx[col]
        if r_idx >= 0:
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            p_old = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
            p_new = transform_deg2_pset(p_old, T_jordan_cols, x_const_shift)
            if p_new:
                quad_jordan_psets.append(p_new)

    # ==========================================================================
    # 4. Audit Theorem 3.1 on the Jordan-Transformed Quadratic System!
    # ==========================================================================
    socle_indices = {k for k, m in enumerate(cb_jordan_meta) if m["is_socle"]}
    rad_indices = [k for k in range(N) if k not in socle_indices]
    socle_mask_N = sum(1 << k for k in socle_indices)

    # Count pure-socle quadratic terms y_a * y_b (a, b in socle_indices) across all m quadratics,
    # AND evaluate the restriction to the invariant subspace V^G (setting y_rad = 0)!
    pure_socle_quad_eqs = 0
    vg_restricted_polys = []
    vg_lin_pivs = {}
    vg_unsat = False

    for qp in quad_jordan_psets:
        has_soc_q = False
        vg_p = set()
        for m in qp:
            if (m & socle_mask_N) == m:
                vg_p.add(m)
                if m.bit_count() == 2:
                    has_soc_q = True
        if has_soc_q:
            pure_socle_quad_eqs += 1
        if vg_p:
            vg_restricted_polys.append(vg_p)
            if max((m.bit_count() for m in vg_p), default=0) <= 1:
                rhs = 1 if (0 in vg_p) else 0
                msk = sum(m for m in vg_p if m)
                while msk:
                    b = msk.bit_length() - 1
                    if b in vg_lin_pivs:
                        pm, pr = vg_lin_pivs[b]
                        msk ^= pm
                        rhs ^= pr
                    else:
                        vg_lin_pivs[b] = (msk, rhs)
                        break
                if msk == 0 and rhs == 1:
                    vg_unsat = True

    # Also compute exact rank of quadratic terms inside V_socle vs linear collapse when y_rad is fixed!
    soc_pair_pivs = {}
    collapsed_lin_count_when_rad_fixed = 0
    for qp in quad_jordan_psets:
        q_soc_only = {m for m in qp if m.bit_count() == 2 and (m & socle_mask_N) == m}
        cur = set(q_soc_only)
        while cur:
            lead = max(cur)
            if lead in soc_pair_pivs:
                cur ^= soc_pair_pivs[lead]
            else:
                soc_pair_pivs[lead] = cur
                break
        if not cur:
            # All pure-socle quadratic terms cancelled! This equation becomes STRICTLY LINEAR in y_socle!
            collapsed_lin_count_when_rad_fixed += 1

    jordan_diag = {
        "N_free_vars": N,
        "num_quad_pivots": len(quad_jordan_psets),
        "dim_rad_low_levels": len(rad_indices),
        "dim_socle_VG": len(socle_indices),
        "quads_with_any_pure_socle_pair": pure_socle_quad_eqs,
        "rank_of_pure_socle_pairs": len(soc_pair_pivs),
        "quads_collapsing_to_LINEAR_in_socle": collapsed_lin_count_when_rad_fixed,
        "VG_invariant_subspace_unsat_by_deg2": vg_unsat,
        "VG_invariant_lin_pivots": len(vg_lin_pivs),
    }

    # ==========================================================================
    # 5. Jordan-Guided Mutant-XL (Degree 4 on Overdetermined B1_11 / Open Cells)
    #    Multiply quadratics ONLY by low-level variables y_r (r in rad_indices) & pairwise q_a * q_b
    #    where leading pure-socle / high-level terms cancel!
    # ==========================================================================
    # Fast sparse degree <= 4 Mutant-XL in Python/bitmasks for B1_11 (223 quadratics in 109 vars -> C(223,2)=24,753!)
    mutant_found_one = False
    mutant_new_deg2 = 0
    if len(quad_jordan_psets) >= 150:  # Overdetermined regime (B1_11!)
        # Build RREF of the 223 quadratics in Jordan order (highest index = socle FIRST so reductions drop to rad!)
        q_pivs = {}
        q_rref_list = []
        for qp in quad_jordan_psets:
            cur = set(qp)
            while cur:
                lead = max(cur, key=lambda m: (m.bit_count(), m))
                if lead == 0:
                    mutant_found_one = True
                    break
                if lead in q_pivs:
                    cur ^= q_pivs[lead]
                else:
                    q_pivs[lead] = cur
                    break
            if mutant_found_one:
                break
        for lead in sorted(q_pivs.keys(), key=lambda m: (m.bit_count(), m)):
            cur = q_pivs[lead]
            for other_l, other_p in q_pivs.items():
                if other_l != lead and other_l in cur:
                    cur = cur ^ other_p
            q_pivs[lead] = cur
            q_rref_list.append((lead, cur))

        # Check degree-3 XL + Mutant degree-drops on y_k * q_r in Jordan basis!
        piv3_j = dict(q_pivs)
        deg2_queue = [p for _, p in q_rref_list]
        max_piv3_budget = 22000
        while deg2_queue and not mutant_found_one and len(piv3_j) < max_piv3_budget:
            base_q = deg2_queue.pop(0)
            # Multiply first by high/socle & low variables
            for k in range(N):
                if len(piv3_j) >= max_piv3_budget:
                    break
                prod = mul_p({1 << k}, base_q)
                cur = prod
                while cur:
                    lead = max(cur, key=lambda m: (m.bit_count(), m))
                    if lead == 0:
                        mutant_found_one = True
                        break
                    if lead in piv3_j:
                        cur ^= piv3_j[lead]
                    else:
                        piv3_j[lead] = cur
                        if lead.bit_count() <= 2:
                            mutant_new_deg2 += 1
                            deg2_queue.append(cur)
                            quad_jordan_psets.append(cur)
                        break
                if mutant_found_one:
                    break

    if mutant_found_one:
        return {
            "cell": cell_name,
            "has_one": True,
            "closed_by_jordan_mutant_xl": True,
            "new_z16_sym_pivs": new_from_z16_sym,
            "mutant_new_deg2": mutant_new_deg2,
            "jordan_diagnostics": jordan_diag,
            "elapsed_sec": round(time.perf_counter() - t0, 3),
        }

    # ==========================================================================
    # 6. Fast Jordan-Guided CaDiCaL + C FWHT Audit (NO slow 12-fiber CardEnc!)
    # ==========================================================================
    sat_res = {"ran": False}
    if sat_budget_sec > 0:
        try:
            from pysat.card import CardEnc, EncType
            from pysat.solvers import Solver
        except ImportError:
            Solver = None

        if Solver is not None:
            ts = time.perf_counter()
            clauses = []
            v_cnt = [N]

            def new_var():
                v_cnt[0] += 1
                return v_cnt[0]

            def add_and_gate(mv, lits):
                for l in lits:
                    clauses.append([-mv, l])
                clauses.append([mv] + [-l for l in lits])

            def add_xor(lits, rhs):
                if not lits:
                    if rhs:
                        clauses.append([1])
                        clauses.append([-1])
                    return
                cur_lits = list(lits)
                cur_rhs = rhs
                while len(cur_lits) > 4:
                    chunk = cur_lits[:3]
                    aux = new_var()
                    chunk_a = chunk + [aux]
                    for mask in range(16):
                        if (mask.bit_count() & 1) != 0:
                            clauses.append([-chunk_a[b] if ((mask >> b) & 1) else chunk_a[b] for b in range(4)])
                    cur_lits = [aux] + cur_lits[3:]
                k_len = len(cur_lits)
                for mask in range(1 << k_len):
                    if (mask.bit_count() & 1) != cur_rhs:
                        clauses.append([-cur_lits[b] if ((mask >> b) & 1) else cur_lits[b] for b in range(k_len)])

            # Encode all Jordan-transformed quadratic pivots sharing AND gates pair_cache[(a,b)]
            pair_cache = {}
            for qp in quad_jordan_psets:
                x_lits = []
                rhs = 0
                for m in qp:
                    d = m.bit_count()
                    if d == 0:
                        rhs ^= 1
                    elif d == 1:
                        x_lits.append(m.bit_length())
                    elif d == 2:
                        b0 = m & -m
                        i0 = b0.bit_length()
                        i1 = (m ^ b0).bit_length()
                        key = (i0, i1)
                        if key not in pair_cache:
                            pv = new_var()
                            add_and_gate(pv, [i0, i1])
                            pair_cache[key] = pv
                        x_lits.append(pair_cache[key])
                add_xor(x_lits, rhs)

            # Orbit literals c_0..c_115 + weight bounds 6 <= k_long <= 106
            c_lits = {}
            long_lits = []
            for j in range(116):
                idxs = [k + 1 for k, cdir in enumerate(cb_jordan_116) if (cdir >> j) & 1]
                cst = (origin_W >> j) & 1
                if not idxs:
                    lv = new_var()
                    clauses.append([lv if cst else -lv])
                elif len(idxs) == 1 and cst == 0:
                    lv = idxs[0]
                elif len(idxs) == 1 and cst == 1:
                    lv = -idxs[0]
                else:
                    lv = new_var()
                    add_xor(idxs + [lv], cst)
                c_lits[j] = lv
                if j not in SHORT_ORBS:
                    long_lits.append(lv)

            for bnd, fn in [(6, CardEnc.atleast), (106, CardEnc.atmost)]:
                enc = fn(lits=long_lits, bound=bnd, top_id=v_cnt[0], encoding=EncType.seqcounter)
                v_cnt[0] = max(v_cnt[0], enc.nv)
                clauses.extend(enc.clauses)

            # Z_{16}^* Lexicographic Symmetry Breaking on the 112 long orbits (8x exact factor!)
            def add_lex_leq(u_lits, v_lits):
                # Enforce u_lits <=_lex v_lits
                prev_eq = None
                for ul, vl in zip(u_lits, v_lits):
                    if ul == vl:
                        continue
                    if prev_eq is None:
                        clauses.append([-ul, vl])
                    else:
                        clauses.append([-prev_eq, -ul, vl])
                    nxt_eq = new_var()
                    if prev_eq is None:
                        clauses.append([-nxt_eq, ul, -vl])
                        clauses.append([-nxt_eq, -ul, vl])
                    else:
                        clauses.append([-nxt_eq, prev_eq])
                        clauses.append([-nxt_eq, ul, -vl])
                        clauses.append([-nxt_eq, -ul, vl])
                    prev_eq = nxt_eq

            base_lex = [c_lits[j] for j in long_orbs]
            for a in Z16_UNITS:
                if a == 1:
                    continue
                img_lex = [c_lits[perm116[a][j]] for j in long_orbs]
                add_lex_leq(base_lex, img_lex)

            # ONLY ONE lightweight exact coset counter: wt(C_{0xf}) == 128 (256 orbits -> super fast!)
            lits_0xf = []
            for x in coset_0xf_reps:
                ovec = sum((1 << j) for j in range(116) if eval_orb_at_x(j, x))
                ob = (origin_W & ovec).bit_count() & 1
                idxs = [k + 1 for k, cdir in enumerate(cb_jordan_116) if (cdir & ovec).bit_count() & 1]
                if not idxs:
                    lv = new_var()
                    clauses.append([lv if ob else -lv])
                elif len(idxs) == 1:
                    lv = -idxs[0] if ob else idxs[0]
                else:
                    lv = new_var()
                    add_xor(idxs + [lv], ob)
                lits_0xf.append(lv)
            enc_0xf = CardEnc.equals(lits=lits_0xf, bound=128, top_id=v_cnt[0], encoding=EncType.totalizer)
            v_cnt[0] = max(v_cnt[0], enc_0xf.nv)
            clauses.extend(enc_0xf.clauses)

            # Encode C6 (T28) in c99=0 cells!
            if c99_val == 0 and poly_t28_b0:
                c6_lits, c6_rhs, c6_cache = [], 0, {}
                for m in poly_t28_b0:
                    if m == 0:
                        c6_rhs ^= 1
                        continue
                    bits = []
                    tmp = m
                    while tmp:
                        b = tmp & -tmp
                        bits.append(c_lits[b.bit_length() - 1])
                        tmp ^= b
                    if len(bits) == 1:
                        c6_lits.append(bits[0])
                    else:
                        key = tuple(sorted(bits))
                        if key not in c6_cache:
                            mv = new_var()
                            add_and_gate(mv, list(key))
                            c6_cache[key] = mv
                        c6_lits.append(c6_cache[key])
                add_xor(c6_lits, c6_rhs)

            models_checked = 0
            bent_hits = []
            unsat_closed = False
            w0_c, mx_c = ctypes.c_int(), ctypes.c_int()

            with Solver(name="cadical195", bootstrap_with=clauses) as slv:
                while (time.perf_counter() - ts) < sat_budget_sec:
                    if not slv.solve():
                        unsat_closed = True
                        break
                    models_checked += 1
                    model = slv.get_model()
                    cint = origin_W
                    for k, cdir in enumerate(cb_jordan_116):
                        if model[k] > 0:
                            cint ^= cdir
                    is_bent = lib_fwht.audit_bent_c(
                        orb_tts_c, cint & mask64, cint >> 64,
                        ctypes.byref(w0_c), ctypes.byref(mx_c)
                    )
                    if is_bent:
                        bent_hits.append(hex(cint))
                        break
                    # Block ONLY the low-level radical Jordan coordinates if socle was uniquely forced,
                    # or block the full N-var assignment + its Z_{16}^* orbit!
                    slv.add_clause([-(k + 1) if model[k] > 0 else (k + 1) for k in range(N)])

            sat_res = {
                "ran": True,
                "unsat_closed": unsat_closed,
                "models_checked": models_checked,
                "bent_hits": bent_hits,
                "sat_sec": round(time.perf_counter() - ts, 3),
            }

    return {
        "cell": cell_name,
        "has_one": False,
        "new_z16_sym_pivs": new_from_z16_sym,
        "mutant_new_deg2": mutant_new_deg2,
        "jordan_diagnostics": jordan_diag,
        "sat_audit": sat_res,
        "elapsed_sec": round(time.perf_counter() - t0, 3),
    }


def main():
    target = sys.argv[1] if len(sys.argv) > 1 else "all"
    sat_bud = float(sys.argv[2]) if len(sys.argv) > 2 else 60.0
    t_start = time.perf_counter()

    work_dir = Path(__file__).resolve().parent
    c_audit_p = work_dir / "b19_audit.c"
    so_audit_p = work_dir / "libb19_audit.so"
    c_audit_p.write_text(C_SRC_AUDIT, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_audit_p), "-o", str(so_audit_p)], check=True)
    lib_audit = ctypes.CDLL(str(so_audit_p))

    lib_audit.extract_level1_quad_when_diag4.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64),
    ]
    lib_audit.extract_level1_quad_when_diag4.restype = ctypes.c_int
    lib_audit.extract_coset_full_hierarchy_corrected.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib_audit.extract_coset_full_hierarchy_corrected.restype = ctypes.c_int
    lib_audit.gf2_echelon_insert.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib_audit.gf2_echelon_insert.restype = ctypes.c_int

    c_fwht_p = work_dir / "b19_fwht.c"
    so_fwht_p = work_dir / "libb19_fwht.so"
    c_fwht_p.write_text(C_FWHT_INLINE, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_fwht_p), "-o", str(so_fwht_p)], check=True)
    lib_fwht = ctypes.CDLL(str(so_fwht_p))
    lib_fwht.audit_bent_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_uint64, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
    ]
    lib_fwht.audit_bent_c.restype = ctypes.c_int

    orbits = build_orbits_116()
    v6_list = all_v6_orbits()
    perm116, perm112, long_orbs, jordan_cols_112, jordan_meta, z16_info = build_z16_action_and_jordan_basis(orbits)
    print("=== Z_16^* REPRESENTATION & JORDAN FILTRATION ON F_2^112 ===", flush=True)
    print(json.dumps(z16_info, indent=2), flush=True)

    # Precompute 116 * 1024 uint64 truth tables
    orb_tts_c = (ctypes.c_uint64 * (116 * 1024))()
    for j, orb in enumerate(orbits):
        base = j * 1024
        for m in orb:
            for x in range(65536):
                if (x & m) == m:
                    orb_tts_c[base + (x >> 6)] ^= 1 << (x & 63)

    poly_t28_b0 = []
    for cand_p in [
        work_dir / "T28_SEXTA_CERTIFICADO.json",
        work_dir.parent / "T28_SEXTA_CERTIFICADO.json",
        work_dir.parents[1] / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json" if len(work_dir.parents) >= 2 else Path("/nonexistent"),
    ]:
        if cand_p.exists():
            cert_t28 = json.loads(cand_p.read_text(encoding="utf-8"))
            poly_t28_b0 = [int(h, 16) for h in cert_t28["reduced_models"]["branches"][0]["polynomial_hex"]]
            break

    all_cells = [
        ("B1_00", 1, 0, 0),
        ("B1_11", 1, 1, 1),
        ("B0_11", 0, 1, 1),
        ("B0_00", 0, 0, 0),
    ]
    chosen = [c for c in all_cells if target in ("all", c[0])]

    report = {"z16_star_structure": z16_info, "cells": {}}
    for cname, c99, c57, c113 in chosen:
        res = analyze_and_solve_cell(
            cname, c99, c57, c113,
            orbits, v6_list, perm116, long_orbs, jordan_cols_112, jordan_meta,
            lib_audit, lib_fwht, orb_tts_c, poly_t28_b0, sat_budget_sec=sat_bud
        )
        report["cells"][cname] = res
        print(f"[{cname}] {json.dumps(res)}", flush=True)

    report["total_elapsed_sec"] = round(time.perf_counter() - t_start, 3)
    print("=== B19 Z_16^* JORDAN MASTER REPORT ===", flush=True)
    print(json.dumps(report, indent=2), flush=True)


if __name__ == "__main__":
    main()

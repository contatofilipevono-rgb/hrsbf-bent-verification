#!/usr/bin/env python3
r"""
Task b09_b0_11_dual_s_elimination (+ Fast Closure of B1_11, B1_00, B0_11):
Exact 2-adic Krawtchouk Elimination of Dual Variables (s_0, s_1..s_30) in B0_11.

What this script computes and proves algorithmically:
  1. Exact structure of the 35 x 30 integer matrix M_{z,m} = K_{z,m} / 2:
     - Verifies rank_{GF(2)}(M mod 2) == 1 (explaining why Run 44373529263 missed 29/30 dual vars!).
     - Decomposes the 30 orbits of (U_8 \ U_4)/C_8 under bit-reversal into:
         * 18 palindromic (self-reverse) orbits s_p
         * 6 chiral pairs {O_a, O_abar} with sigma_a = s_a ^ s_abar, pi_a = s_a * s_abar
       and verifies 4 | (M_{z,a} - M_{z,abar}) for ALL 35 fibers z!
  2. Solves explicitly for y = (s_0, s_1..s_18, sigma_1..sigma_6) in GF(2)[c]:
     - Block 1 (DEGREE <= 1 in c!): U_4 fibers {0x11, 0x33, 0x77}, parity laws, 0x5555 law
       -> identifies ALL dual combinations determined as PURE LINEAR FORMS L_k(c) = y_k in Z!
     - Block 2 (DEGREE <= 2 in c!): Mod-4 Master Equations on all 35 fibers + Mod-8 0x55/0xff law (Eq. 32a)
       -> extracts ALL pure quadratic syzygies in c (including the 6 chiral equations Q_{z_b} ^ Q_{zbar_b} = 0)
       and expresses remaining y_k = P_k(c) in GF(2)[c]_{<=2}!
  3. Substitutes y_k = L_k(c) / P_k(c) back into:
     - Mod-8 syzygies where Mod-4 canceled identically in GF(2)[c] (producing exact DEGREE <= 3 pure equations in c!),
     - U_4 higher 2-adic fiber equations (0xff, 0x55, 0x11, 0x33, 0x77) + C_{0x0}\D_8 (q_0 = 116 + 8*s_0),
     - Chiral difference equations (W_{z_b} - W_{zbar_b})/4 mod 2 == sum D_{b,a} sigma_a(c),
     - Boolean product elimination pi_a and pi_a * sigma_a = 0, and 2*s_0 + sum s_m = 8!
  4. Feeds all pure equations in c into the C Macaulay XL engine (pure 111-var basis, zero external assumptions!)
     and runs fast CardEnc-free SAT + algebraic dual-s & FWHT C audit on B1_11 (223 quads!) and B0_11.

Usage:
  python3 SOLVE_B09_DUAL_S_ELIM.py [sat_budget_sec_per_cell]
"""
import ctypes
import json
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

C_FWHT_CHECK_SRC = r"""
#include <stddef.h>
#include <stdint.h>

int is_bent_65536_c(const uint64_t *orb_tts, uint64_t clo, uint64_t chi) {
    uint64_t tt[1024] = {0};
    for (int j = 0; j < 64; j++) {
        if ((clo >> j) & 1ULL) {
            const uint64_t *src = orb_tts + (size_t)j * 1024;
            for (int w = 0; w < 1024; w++) tt[w] ^= src[w];
        }
    }
    for (int j = 64; j < 116; j++) {
        if ((chi >> (j - 64)) & 1ULL) {
            const uint64_t *src = orb_tts + (size_t)j * 1024;
            for (int w = 0; w < 1024; w++) tt[w] ^= src[w];
        }
    }
    int32_t spec[65536];
    for (int x = 0; x < 65536; x++) {
        spec[x] = ((tt[x >> 6] >> (x & 63)) & 1ULL) ? -1 : 1;
    }
    for (int step = 1; step < 65536; step <<= 1) {
        int dbl = step << 1;
        for (int i = 0; i < 65536; i += dbl) {
            for (int j = 0; j < step; j++) {
                int32_t u = spec[i + j];
                int32_t v = spec[i + j + step];
                spec[i + j] = u + v;
                spec[i + j + step] = u - v;
            }
        }
    }
    for (int u = 0; u < 65536; u++) {
        if (spec[u] != 256 && spec[u] != -256) return 0;
    }
    return 1;
}
"""


def rev8(a: int) -> int:
    """Involucao diedral tau_rev: (rev8(a))_i = a_{(-i) mod 8}."""
    out = a & 1
    for i in range(1, 8):
        if (a >> i) & 1:
            out |= 1 << (8 - i)
    return out


def build_c8_and_dihedral_structure():
    seen = set()
    u4_orbs = []
    u8_size8 = []
    nonzero_z = []
    rep_of_byte = {}
    for a in range(256):
        if a in seen:
            continue
        orb = []
        cur = a
        while cur not in orb:
            orb.append(cur)
            cur = rot8(cur)
        seen.update(orb)
        rep = min(orb)
        for x in orb:
            rep_of_byte[x] = rep
        if a != 0:
            nonzero_z.append((rep, orb))
        if len(orb) < 8:
            u4_orbs.append((rep, orb))
        else:
            u8_size8.append((rep, orb))

    assert len(u4_orbs) == 6 and len(u8_size8) == 30 and len(nonzero_z) == 35

    # Partition the 30 size-8 orbits into 18 palindromic and 6 chiral pairs
    m_rep_to_idx = {r: idx for idx, (r, _) in enumerate(u8_size8)}
    pal_m = []
    chiral_m_pairs = []
    visited_m = set()
    for m, (r, _) in enumerate(u8_size8):
        if m in visited_m:
            continue
        r_bar = rep_of_byte[rev8(r)]
        m_bar = m_rep_to_idx[r_bar]
        if m == m_bar:
            pal_m.append(m)
            visited_m.add(m)
        else:
            chiral_m_pairs.append((m, m_bar))
            visited_m.add(m)
            visited_m.add(m_bar)

    assert len(pal_m) == 18 and len(chiral_m_pairs) == 6

    z_rep_to_idx = {r: idx for idx, (r, _) in enumerate(nonzero_z)}
    chiral_z_pairs = []
    visited_z = set()
    for zi, (zr, _) in enumerate(nonzero_z):
        if zi in visited_z:
            continue
        zr_bar = rep_of_byte[rev8(zr)]
        zi_bar = z_rep_to_idx[zr_bar]
        visited_z.add(zi)
        visited_z.add(zi_bar)
        if zi != zi_bar:
            chiral_z_pairs.append((zi, zi_bar))
    assert len(chiral_z_pairs) == 6

    # Exact 35 x 30 integer matrix M_{z, m} = K_{z, m} // 2
    M_int = []
    for zr, _ in nonzero_z:
        row = []
        for _, a_orb in u8_size8:
            k_val = sum(-1 if ((a & zr).bit_count() & 1) else 1 for a in a_orb)
            assert k_val % 2 == 0
            row.append(k_val // 2)
        M_int.append(row)

    # Verify Theorem 1 (rank(M mod 2) == 1) and Theorem 2 (4 | (M_{z,a} - M_{z,abar}) in K, i.e., 2 | (M_{z,a} - M_{z,abar}))!
    # Wait: K_{z,a} - K_{z,abar} is divisible by 8, so M_{z,a} - M_{z,abar} = (K_{z,a}-K_{z,abar})/2 is divisible by 4!!
    mod2_distinct = {
        tuple(v & 1 for v in row) for row in M_int if any(v & 1 for v in row)
    }
    assert len(mod2_distinct) == 1, f"Expected rank 1 for M mod 2, got {len(mod2_distinct)}!"
    for zi in range(35):
        for ma, mabar in chiral_m_pairs:
            diff = M_int[zi][ma] - M_int[zi][mabar]
            assert diff % 4 == 0, f"Violation of 4 | (M[z,a] - M[z,abar]) at z={zi}: diff={diff}!"

    return {
        "u4_orbs": u4_orbs,
        "u8_size8": u8_size8,
        "nonzero_z": nonzero_z,
        "pal_m": pal_m,
        "chiral_m_pairs": chiral_m_pairs,
        "chiral_z_pairs": chiral_z_pairs,
        "m_rep_to_idx": m_rep_to_idx,
        "z_rep_to_idx": z_rep_to_idx,
        "M_int": M_int,
    }


def fiber_orbit_reps(z: int, group_step: int):
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


def mul_poly(p1: set, p2: set) -> set:
    out = set()
    for a in p1:
        for b in p2:
            m = a | b
            if m in out:
                out.remove(m)
            else:
                out.add(m)
    return out


def poly_deg(pset: set) -> int:
    return max((m.bit_count() for m in pset), default=-1)


def eval_pset(pset: set, x_mask: int) -> int:
    acc = 0
    for m in pset:
        if (x_mask & m) == m:
            acc ^= 1
    return acc


def extract_weight_div_2k_poly(basis_words, O_word, k_shift: int, n: int):
    """
    Given M boolean affine forms g_p(c) = O_p ^ sum_i c_i b_{i,p},
    extract the EXACT polynomial for (wt(g(c)) // 2^k_shift) mod 2
    for k_shift in {0, 1, 2}, verifying lower-bit preconditions identically!
      - k_shift == 0: wt(g(c)) mod 2 (deg <= 1)
      - k_shift == 1: (wt(g(c)) // 2) mod 2, assuming wt(g(c)) == 0 mod 2 identically (deg <= 2)
      - k_shift == 2: (wt(g(c)) // 4) mod 2, assuming wt(g(c)) == 0 mod 4 identically (deg <= 3)
    """
    o_pop = O_word.bit_count()
    pset = set()

    def toggle(m):
        if m in pset:
            pset.remove(m)
        else:
            pset.add(m)

    if k_shift == 0:
        if o_pop & 1:
            toggle(0)
        for i in range(n):
            if basis_words[i].bit_count() & 1:
                toggle(1 << i)
        return pset

    # Verify level 0 == 0 identically:
    if o_pop & 1:
        return None
    Ai = []
    for i in range(n):
        wp = basis_words[i].bit_count()
        if wp & 1:
            return None
        wop = (basis_words[i] & O_word).bit_count()
        Ai.append(wp - 2 * wop)

    if k_shift == 1:
        if (o_pop >> 1) & 1:
            toggle(0)
        for i in range(n):
            if (Ai[i] >> 1) & 1:
                toggle(1 << i)
        for i in range(n):
            bi = basis_words[i]
            for j in range(i + 1, n):
                if (bi & basis_words[j]).bit_count() & 1:
                    toggle((1 << i) | (1 << j))
        return pset

    if k_shift == 2:
        if (o_pop & 3) != 0:
            return None
        if any((a & 3) != 0 for a in Ai):
            return None
        if (o_pop >> 2) & 1:
            toggle(0)
        for i in range(n):
            if (Ai[i] >> 2) & 1:
                toggle(1 << i)
        for i in range(n):
            bi = basis_words[i]
            for j in range(i + 1, n):
                inter = bi & basis_words[j]
                ip = inter.bit_count()
                if ip & 1:
                    return None
                iop = (inter & O_word).bit_count()
                if ((ip >> 1) + iop) & 1:
                    toggle((1 << i) | (1 << j))
                for k in range(j + 1, n):
                    if (inter & basis_words[k]).bit_count() & 1:
                        toggle((1 << i) | (1 << j) | (1 << k))
        return pset

    return None


def derive_b09_pure_c_equations(orbits, origin, cb, dih):
    """
    Derives ALL pure linear, quadratic, and cubic equations in c (n = 111 pure vars!)
    for B0_11 by solving and eliminating (s_0, s_1..s_30) mod 2, mod 4, and mod 8!
    """
    n = len(cb)
    u8_size8 = dih["u8_size8"]
    nonzero_z = dih["nonzero_z"]
    pal_m = dih["pal_m"]
    chiral_m_pairs = dih["chiral_m_pairs"]
    chiral_z_pairs = dih["chiral_z_pairs"]
    m_rep_to_idx = dih["m_rep_to_idx"]
    z_rep_to_idx = dih["z_rep_to_idx"]
    M_int = dih["M_int"]

    # Helper to pack basis_words and O_word on any list of points X_pts in F_2^16
    def pack_on_points(x_pts):
        O_w = 0
        cb_w = [0] * n
        orb_masks = []
        for j, orb in enumerate(orbits):
            om = 0
            for idx, x in enumerate(x_pts):
                if sum((x & m) == m for m in orb) & 1:
                    om |= 1 << idx
            orb_masks.append(om)
            if (origin >> j) & 1:
                O_w ^= om
        for i, cdir in enumerate(cb):
            bw = 0
            for j in range(116):
                if (cdir >> j) & 1:
                    bw ^= orb_masks[j]
            cb_w[i] = bw
        return cb_w, O_w

    # 1. Pack all 35 fibers on their 128 <rot^8>-pairs (plus fine orbits on U_4!)
    pair_packs_35 = []
    Q2_fibers = []  # Q_z^(2)(c) = (W_z(c) // 2) mod 2 (deg <= 2, and deg <= 1 on U_4!)
    pure_lin_eqs = []
    pure_quad_eqs = []
    pure_cub_eqs = []

    for zi, (zr, _) in enumerate(nonzero_z):
        reps128 = fiber_orbit_reps(zr, 8)
        cb_w, O_w = pack_on_points(reps128)
        pair_packs_35.append((cb_w, O_w))

        # Check parity W_z(c) mod 2:
        p_mod2 = extract_weight_div_2k_poly(cb_w, O_w, 0, n)
        if p_mod2:
            # Theorem 1 + Eq. (14): if wt(zr) is even, W_z(c) == 0 mod 2!
            if (zr.bit_count() & 1) == 0:
                pure_lin_eqs.append(("fiber_even_mod2", hex(zr), p_mod2))
        q2 = extract_weight_div_2k_poly(cb_w, O_w, 1, n)
        assert q2 is not None, f"W_z(c) not identically even at z={hex(zr)}!"
        Q2_fibers.append(q2)

    # Fine packs for z = 0xff (16 C_16-orbits), z = 0x55 (32 <rot^2>-orbits),
    # z in {0x11, 0x33, 0x77} (64 <rot^4>-orbits), and C_{0x0}\D_8 (240 C_16-orbits)!
    cb_ff, O_ff = pack_on_points(fiber_orbit_reps(0xFF, 1))
    p1_ff = extract_weight_div_2k_poly(cb_ff, O_ff, 0, n)
    if p1_ff:
        pure_lin_eqs.append(("0xff_mod2", "0xff", p1_ff))
    e2_ff = extract_weight_div_2k_poly(cb_ff, O_ff, 1, n)
    assert e2_ff is not None

    cb_55, O_55 = pack_on_points(fiber_orbit_reps(0x55, 2))
    p1_55 = extract_weight_div_2k_poly(cb_55, O_55, 0, n)
    if p1_55:
        pure_lin_eqs.append(("0x55_mod2", "0x55", p1_55))
    e2_55 = extract_weight_div_2k_poly(cb_55, O_55, 1, n)
    assert e2_55 is not None

    u4_step4_packs = {}
    for zr in (0x11, 0x33, 0x77):
        cb_u, O_u = pack_on_points(fiber_orbit_reps(zr, 4))
        l_u = extract_weight_div_2k_poly(cb_u, O_u, 0, n)
        assert poly_deg(l_u) <= 1
        u4_step4_packs[zr] = (cb_u, O_u, l_u)
        # Verify consistency: l_u must equal Q2_fibers[z_rep_to_idx[zr]]!
        assert l_u == Q2_fibers[z_rep_to_idx[zr]]

    # 2. Map 30 variables s_m to the 25 dihedral linear variables:
    #    y_0 = s_0
    #    y_{1..18} = s_{pal_m[0..17]}
    #    y_{19..24} = sigma_a = s_{ma} ^ s_{mabar} for chiral_m_pairs[0..5]
    m_to_y_bit = {}
    for idx_p, m in enumerate(pal_m):
        m_to_y_bit[m] = 1 + idx_p
    for idx_c, (ma, mabar) in enumerate(chiral_m_pairs):
        m_to_y_bit[ma] = 19 + idx_c
        m_to_y_bit[mabar] = 19 + idx_c  # when coeff of ma and mabar mod 2 are equal, s_a ^ s_abar = sigma_a!

    def pack_s_mask_to_y25(s30_mask: int, include_s0: int = 0) -> int:
        ymask = 1 if include_s0 else 0
        for idx_p, m in enumerate(pal_m):
            if (s30_mask >> m) & 1:
                ymask |= 1 << (1 + idx_p)
        for idx_c, (ma, mabar) in enumerate(chiral_m_pairs):
            ba = (s30_mask >> ma) & 1
            bb = (s30_mask >> mabar) & 1
            assert ba == bb, f"Asymmetric mod-2 s mask on chiral pair {(ma, mabar)}!"
            if ba:
                ymask |= 1 << (19 + idx_c)
        return ymask

    # Build the linear system H_y * y == rhs_poly(c) over GF(2) (25 columns for y_0..y_24)!
    # CRITICAL ORDERING: Insert all rows with deg(rhs_poly) <= 1 FIRST, so Gaussian elimination
    # isolates the ENTIRE subspace of y that equals PURE LINEAR FORMS L(c) in Z!
    sys_rows = []  # (deg_priority, label, y25_mask, rhs_pset, int_meta)

    # (a) Exact degree-0 parity laws on s:
    odd_m_mask = sum(1 << m for m, (r, _) in enumerate(u8_size8) if r.bit_count() & 1)
    even_m_mask = ((1 << 30) - 1) ^ odd_m_mask
    sys_rows.append((0, "sum_odd_s_mod2", pack_s_mask_to_y25(odd_m_mask, 0), set(), None))
    sys_rows.append((0, "sum_even_s_mod2", pack_s_mask_to_y25(even_m_mask, 0), set(), None))

    # s_0 ^ s_{0x01} ^ s_{0x05} ^ s_{0x15} == 0 (Note: 0x5555 Poisson mod 16 requires K == c57 = 1!
    # Let's include K == 1 as an exact proven linear equation of C_{0xf} parity in B0_11!)
    m_015 = (1 << m_rep_to_idx[0x01]) | (1 << m_rep_to_idx[0x05]) | (1 << m_rep_to_idx[0x15])
    sys_rows.append((0, "s0_0x5555_law", pack_s_mask_to_y25(m_015, include_s0=1), set(), None))

    # (b) All 19 even-weight z fibers (Eq. 17a): sum ((M_{z,m}//2) & 1) s_m == Q2_fibers[zi]
    z01_idx = z_rep_to_idx[0x01]
    for zi, (zr, _) in enumerate(nonzero_z):
        if (zr.bit_count() & 1) == 0:
            smask = sum(1 << m for m in range(30) if (M_int[zi][m] // 2) & 1)
            rhs = set(Q2_fibers[zi])
            d_prio = 1 if poly_deg(rhs) <= 1 else 2
            # Store integer combination metadata {zi: +1} for exact mod-8 syzygy lifting!
            sys_rows.append((d_prio, f"mod4_even_{hex(zr)}", pack_s_mask_to_y25(smask, 0), rhs, {zi: 1}))
        elif zi != z01_idx:
            # (c) 15 odd-weight fiber differences z - 0x01 (Eq. 17b):
            smask = sum(1 << m for m in range(30) if ((M_int[zi][m] - M_int[z01_idx][m]) // 2) & 1)
            rhs = Q2_fibers[zi] ^ Q2_fibers[z01_idx]
            d_prio = 1 if poly_deg(rhs) <= 1 else 2
            sys_rows.append((d_prio, f"mod4_odd_diff_{hex(zr)}", pack_s_mask_to_y25(smask, 0), rhs, {zi: 1, z01_idx: -1}))

    # (d) The 35th equation z = 0x01 combined with 0xff (Eq. 17b):
    smask_01 = sum(
        1 << m for m, (r, _) in enumerate(u8_size8)
        if r.bit_count() in (2, 6, 1, 5)
    )
    rhs_01 = Q2_fibers[z01_idx] ^ e2_ff
    sys_rows.append((1 if poly_deg(rhs_01) <= 1 else 2, "mod4_0x01_with_0xff",
                     pack_s_mask_to_y25(smask_01, 0), rhs_01, None))

    # (e) Level mod-8 exact linear-in-s equation from z = 0x55 + 0xff + sum_s=8 (Eq. 32a)!
    even_minus_mask = sum(
        1 << m for m in range(30) if M_int[z_rep_to_idx[0x55]][m] == -4
    )
    rhs_32a = {0} ^ e2_ff ^ e2_55
    sys_rows.append((1 if poly_deg(rhs_32a) <= 1 else 2, "mod8_0x55_eq32a",
                     pack_s_mask_to_y25(even_minus_mask, 0), rhs_32a, None))

    # Sort so deg <= 1 rows come FIRST!
    sys_rows.sort(key=lambda item: item[0])

    # Gauss-Jordan elimination over GF(2) on the 25 y-columns, tracking integer fiber combinations!
    piv_y = {}  # bit_col -> [y_mask, rhs_pset, comb_list_of_row_indices]
    syzygies = []

    for r_idx, (d_prio, lbl, ymask, rhs, meta) in enumerate(sys_rows):
        cur_y = ymask
        cur_rhs = set(rhs)
        cur_comb = {r_idx}
        while cur_y:
            b = cur_y.bit_length() - 1
            if b in piv_y:
                py, prhs, pcomb = piv_y[b]
                cur_y ^= py
                cur_rhs ^= prhs
                cur_comb ^= pcomb
            else:
                piv_y[b] = [cur_y, cur_rhs, cur_comb]
                break
        if cur_y == 0:
            syzygies.append((lbl, cur_rhs, cur_comb))
            if cur_rhs:
                if poly_deg(cur_rhs) <= 1:
                    pure_lin_eqs.append((f"syz_{lbl}", lbl, cur_rhs))
                else:
                    pure_quad_eqs.append((f"syz_{lbl}", lbl, cur_rhs))

    # Back-substitution to full RREF on piv_y so each pivot y_b is clean!
    for b in sorted(piv_y.keys()):
        py, prhs, pcomb = piv_y[b]
        for b2 in list(piv_y.keys()):
            if b2 != b and ((piv_y[b2][0] >> b) & 1):
                piv_y[b2][0] ^= py
                piv_y[b2][1] ^= prhs
                piv_y[b2][2] ^= pcomb

    # Inspect which y_b (or combinations) are COMPLETELY DETERMINED (unique bit in py) and their degree in c!
    determined_y = {}  # b -> rhs_pset (when piv_y[b][0] == (1 << b)!)
    linear_in_c_y = {}
    for b, (py, prhs, _) in piv_y.items():
        if py == (1 << b):
            determined_y[b] = prhs
            if poly_deg(prhs) <= 1:
                linear_in_c_y[b] = prhs

    # 3. LEVEL MOD-8 LIFTING OF IDENTICAL MOD-4 SYZYGIES -> PURE CUBIC EQUATIONS IN c!
    # Whenever a syzygy combination of integer fiber rows {zi: coeff} has cur_rhs == empty set
    # (meaning sum coeff * W_z(c) == 0 mod 4 IDENTICALLY as a polynomial in c!),
    # we can divide sum coeff * W_z(c) by 4 mod 2 with ZERO degree-4 carry (exact degree <= 3 in c!!)!
    mod8_lifted_count = 0
    for lbl, cur_rhs, cur_comb in syzygies:
        if len(cur_rhs) != 0:
            continue  # Non-zero quadratic equation already added to pure_quad_eqs!
        # Check if all rows in cur_comb come from pure fiber rows (meta != None)
        if not all(sys_rows[idx][4] is not None for idx in cur_comb):
            continue
        z_weights = {}
        for idx in cur_comb:
            for zi, w in sys_rows[idx][4].items():
                z_weights[zi] = z_weights.get(zi, 0) + w
        z_weights = {zi: w for zi, w in z_weights.items() if w != 0}
        if not z_weights:
            continue

        # Compute exact LHS = (sum_zi z_weights[zi] * W_zi(c) - RHS_const_and_s) mod 8!
        # On the RHS of Master Eq (2): sum_zi w_zi * (64 + 8*[zi in U4]*s_0 + sum_m M[zi][m]*s_m) mod 8:
        #   64 == 0 mod 8, 8*s_0 == 0 mod 8!
        #   Only sum_m (sum_zi w_zi * M[zi][m] mod 8) * s_m remains!
        # Because this is a mod-4 syzygy, C_m := sum_zi w_zi * M[zi][m] is a MULTIPLE OF 4 for EVERY m = 0..29!!
        C_m = [sum(w * M_int[zi][m] for zi, w in z_weights.items()) for m in range(30)]
        if not all(c_val % 4 == 0 for c_val in C_m):
            continue  # (Could differ by sum_odd_s == 0 mod 2, skip if odd multiple of 2)

        # AMAZING FACT: Since 4 | C_m for all m, (C_m // 4) & 1 is LINEAR in s_m (and symmetric on chiral pairs
        # if chiral diff is 0 mod 8; wait: on chiral pairs 4 | (M[z,a]-M[z,abar]), so C_a // 4 and C_abar // 4
        # might differ mod 2 if chiral!). Let's check if (C_m // 4) & 1 is expressible via determined_y!
        s30_mod8_mask = sum(1 << m for m in range(30) if (C_m[m] // 4) & 1)
        can_express = True
        rhs_s_poly = set()
        # Check palindromic bits:
        for idx_p, m in enumerate(pal_m):
            if (s30_mod8_mask >> m) & 1:
                yb = 1 + idx_p
                if yb in determined_y:
                    rhs_s_poly ^= determined_y[yb]
                else:
                    can_express = False
                    break
        if can_express:
            for idx_c, (ma, mabar) in enumerate(chiral_m_pairs):
                ba = (s30_mod8_mask >> ma) & 1
                bb = (s30_mod8_mask >> mabar) & 1
                if ba != bb:
                    can_express = False
                    break
                if ba:
                    yb = 19 + idx_c
                    if yb in determined_y:
                        rhs_s_poly ^= determined_y[yb]
                    else:
                        can_express = False
                        break
        if not can_express:
            continue

        # Extract exact degree <= 3 polynomial of (sum_zi w_zi * W_zi(c)) // 4 mod 2!
        # By multinomial expansion (37):
        o_sum = sum(w * pair_packs_35[zi][1].bit_count() for zi, w in z_weights.items())
        assert o_sum % 4 == 0
        lhs_cub = set()

        def toggle_cub(m_bit):
            if m_bit in lhs_cub:
                lhs_cub.remove(m_bit)
            else:
                lhs_cub.add(m_bit)

        if (o_sum // 4) & 1:
            toggle_cub(0)
        for i in range(n):
            ai_sum = 0
            for zi, w in z_weights.items():
                cb_w, O_w = pair_packs_35[zi]
                ai_sum += w * (cb_w[i].bit_count() - 2 * (cb_w[i] & O_w).bit_count())
            assert ai_sum % 4 == 0
            if (ai_sum // 4) & 1:
                toggle_cub(1 << i)

        for i in range(n):
            for j in range(i + 1, n):
                aij_sum = 0
                for zi, w in z_weights.items():
                    cb_w, O_w = pair_packs_35[zi]
                    inter = cb_w[i] & cb_w[j]
                    if inter:
                        aij_sum += w * (inter.bit_count() - 2 * (inter & O_w).bit_count())
                # Term in sum w*W_z is -2 * aij_sum; since 4 | sum, 2 | aij_sum, divided by 4 is (-aij_sum // 2) & 1!
                assert aij_sum % 2 == 0
                if ((-aij_sum) // 2) & 1:
                    toggle_cub((1 << i) | (1 << j))
                for k in range(j + 1, n):
                    bijk = 0
                    for zi, w in z_weights.items():
                        if w & 1:
                            cb_w, _ = pair_packs_35[zi]
                            bijk ^= (cb_w[i] & cb_w[j] & cb_w[k]).bit_count() & 1
                    if bijk:
                        toggle_cub((1 << i) | (1 << j) | (1 << k))

        full_cub_eq = lhs_cub ^ rhs_s_poly
        if full_cub_eq:
            mod8_lifted_count += 1
            if poly_deg(full_cub_eq) <= 2:
                pure_quad_eqs.append((f"mod8_lift_{lbl}", lbl, full_cub_eq))
            else:
                pure_cub_eqs.append((f"mod8_lift_{lbl}", lbl, full_cub_eq))

    # 4. U_4 Step-4 Fibers {0x11, 0x33, 0x77} Level Mod-8 (Eq. 36 -> Exact Degree <= 2/3 in c!):
    for zr in (0x11, 0x33, 0x77):
        zi = z_rep_to_idx[zr]
        cb_u, O_u, l_u = u4_step4_packs[zr]
        # On 64 <rot^4>-orbits: sum_{r=1}^{64} l_r == L_u + 2 * e_2(l_1..l_64) (mod 4),
        # where e_2_shifted = ((wt(l(c)) - L_u(c)) // 2) mod 2!
        # Let's compute ((wt(l(c)) - L_u(c)) // 2) mod 2 directly by appending L_u(c) as a 65th bit!
        # Because wt(l_1..l_64, L_u) == wt(l_1..l_64) + L_u == 2 * ((wt + L_u)//2), and for bits in {0,1}:
        # (S - (S mod 2)) // 2 == (S + (S mod 2)) // 2 - (S mod 2)!
        l_u_word_cb = [1 if ((1 << i) in l_u) else 0 for i in range(n)]
        l_u_word_O = 1 if (0 in l_u) else 0
        cb_65 = [(cb_u[i] << 1) | l_u_word_cb[i] for i in range(n)]
        O_65 = (O_u << 1) | l_u_word_O
        e2_u = extract_weight_div_2k_poly(cb_65, O_65, 1, n)
        assert e2_u is not None
        lhs_div2_mod2 = e2_u ^ l_u  # Exact polynomial of ((sum_{r=1}^{64} l_r(c) - L_u(c)) // 2) mod 2!

        # RHS of Eq. (36): xor_{|M|=4} s_m ^ xor_{M=-2} s_m ^ e_2({s_m}_{|M|=2})
        # Check if every s_m (or chiral pair) in {|M|=2} and {|M|=4 or M=-2} is determined with small degree!
        lin_s_mask = sum(1 << m for m in range(30) if abs(M_int[zi][m]) == 4 or M_int[zi][m] == -2)
        quad_s_list = [m for m in range(30) if abs(M_int[zi][m]) == 2]
        # Group quad_s_list into palindromic + chiral pairs:
        # Note: for a chiral pair {a, abar} in quad_s_list, s_a + s_abar = sigma_a + 2*pi_a, so
        # pi_a = s_a * s_abar APPEARS if chiral pairs are in {|M|=2}!
        chiral_in_2 = [
            idx_c for idx_c, (ma, mabar) in enumerate(chiral_m_pairs)
            if abs(M_int[zi][ma]) == 2
        ]
        if not chiral_in_2:
            # Pure in y = (s_pal, sigma)!
            ok = True
            rhs_36 = set()
            ym_lin = pack_s_mask_to_y25(lin_s_mask, 0)
            for b in range(25):
                if (ym_lin >> b) & 1:
                    if b in determined_y:
                        rhs_36 ^= determined_y[b]
                    else:
                        ok = False
            pal_in_2 = [1 + idx_p for idx_p, m in enumerate(pal_m) if abs(M_int[zi][m]) == 2]
            if ok and all(b in determined_y for b in pal_in_2):
                for idx_a in range(len(pal_in_2)):
                    for idx_b in range(idx_a + 1, len(pal_in_2)):
                        prod = mul_poly(determined_y[pal_in_2[idx_a]], determined_y[pal_in_2[idx_b]])
                        rhs_36 ^= prod
                eq36 = lhs_div2_mod2 ^ rhs_36
                if eq36 and poly_deg(eq36) <= 3:
                    if poly_deg(eq36) <= 2:
                        pure_quad_eqs.append((f"u4_mod8_{hex(zr)}", hex(zr), eq36))
                    else:
                        pure_cub_eqs.append((f"u4_mod8_{hex(zr)}", hex(zr), eq36))

    # 5. Also add C_{0xf} parity (exact proven linear law K == c57) and C_{0x0}\D_8 mod 2, mod 4, mod 8!
    coset_0xf_reps, coset_0x0_reps = [], []
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
            elif vnib == 0x0:
                coset_0x0_reps.append(mem[0])

    cb_0xf, O_0xf = pack_on_points(coset_0xf_reps)
    p_0xf_lin = extract_weight_div_2k_poly(cb_0xf, O_0xf, 0, n)
    if p_0xf_lin:
        pure_lin_eqs.append(("C_0xf_mod2", "C_0xf", p_0xf_lin))
    else:
        p_0xf_quad = extract_weight_div_2k_poly(cb_0xf, O_0xf, 1, n)
        if p_0xf_quad:
            pure_quad_eqs.append(("C_0xf_mod4", "C_0xf", p_0xf_quad))

    # In B0_11, q_0(c) = 116 + 8*s_0 == 4 (mod 8)!
    cb_0x0, O_0x0 = pack_on_points(coset_0x0_reps)
    p_0x0_lin = extract_weight_div_2k_poly(cb_0x0, O_0x0, 0, n)
    if p_0x0_lin:
        pure_lin_eqs.append(("C_0x0_mod2", "C_0x0", p_0x0_lin))
    else:
        p_0x0_quad = extract_weight_div_2k_poly(cb_0x0, O_0x0, 1, n)
        if p_0x0_quad:
            pure_quad_eqs.append(("C_0x0_mod4", "C_0x0", p_0x0_quad))
        else:
            p_0x0_cub = extract_weight_div_2k_poly(cb_0x0, O_0x0, 2, n)
            if p_0x0_cub is not None:
                # 116 // 4 == 29 == 1 (mod 2)! So q_0 // 4 mod 2 == 1 <==> p_0x0_cub ^ {0} == 0!
                pure_cub_eqs.append(("C_0x0_mod8_eq4", "C_0x0", p_0x0_cub ^ {0}))

    summary = {
        "y25_rank_over_gf2": len(piv_y),
        "y25_uniquely_determined_count": len(determined_y),
        "y25_determined_as_LINEAR_L_c_count": len(linear_in_c_y),
        "y25_determined_bits_degrees": {str(b): poly_deg(p) for b, p in sorted(determined_y.items())},
        "pure_lin_extracted": len(pure_lin_eqs),
        "pure_quad_extracted": len(pure_quad_eqs),
        "pure_cub_extracted": len(pure_cub_eqs),
        "mod8_syzygy_lifts": mod8_lifted_count,
    }
    return summary, determined_y, pair_packs_35, pure_lin_eqs, pure_quad_eqs, pure_cub_eqs


def fast_sat_close_degree2(
    cell_name: str,
    n: int,
    origin: int,
    cb: list,
    deg12_psets: list,
    orbits: list,
    lib_fwht,
    orb_tts,
    poly_t28_branch,
    b09_dual_checker=None,
    budget_sec: float = 120.0,
):
    """
    Discovery #2 of Run 44373529263 applied:
    ZERO slow CardEnc counters in CNF! Encodes ONLY the independent degree <= 2 pivots
    (+ Z_16^* lex symmetry breaking + C6 if provided), solving at maximum CaDiCaL speed!
    In B1_11 (223 quadratics in 109 vars!), degree <= 2 alone is massively overdetermined!
    In B0_11, b09_dual_checker checks in 0.001ms whether the integer fiber weights W_z(c)
    admit s_0, s_1..s_30 in {0,1} with 2*s_0 + sum s_m == 8 before even calling FWHT!
    """
    from pysat.solvers import Solver

    t_start = time.perf_counter()
    clauses = []
    v_cnt = [n]

    def new_var():
        v_cnt[0] += 1
        return v_cnt[0]

    def add_and2(z, a, b):
        clauses.append([-z, a])
        clauses.append([-z, b])
        clauses.append([z, -a, -b])

    def add_xor(lits, rhs):
        if not lits:
            if rhs:
                clauses.append([1])
                clauses.append([-1])
            return
        cur = list(lits)
        cur_rhs = rhs & 1
        while len(cur) > 4:
            chunk, rest = cur[:3], cur[3:]
            aux = new_var()
            # chunk[0] ^ chunk[1] ^ chunk[2] ^ aux == 0
            w = chunk + [aux]
            for mask in range(16):
                if mask.bit_count() & 1:
                    clauses.append([-w[k] if ((mask >> k) & 1) else w[k] for k in range(4)])
            cur = [aux] + rest
        m_len = len(cur)
        for mask in range(1 << m_len):
            if (mask.bit_count() & 1) != cur_rhs:
                clauses.append([-cur[k] if ((mask >> k) & 1) else cur[k] for k in range(m_len)])

    pair_cache = {}
    for pset in deg12_psets:
        rhs = 1 if (0 in pset) else 0
        xor_lits = []
        for m in pset:
            if m == 0:
                continue
            bc = m.bit_count()
            if bc == 1:
                xor_lits.append(m.bit_length())
            elif bc == 2:
                i = (m & -m).bit_length()
                j = (m ^ (1 << (i - 1))).bit_length()
                key = (i, j)
                if key not in pair_cache:
                    pv = new_var()
                    add_and2(pv, i, j)
                    pair_cache[key] = pv
                xor_lits.append(pair_cache[key])
        add_xor(xor_lits, rhs)

    # Optional C6 (T28) encoding if available
    if poly_t28_branch:
        c_lits = {}
        for j in range(116):
            idxs = [i + 1 for i, cdir in enumerate(cb) if (cdir >> j) & 1]
            cst = (origin >> j) & 1
            if len(idxs) == 1 and cst == 0:
                c_lits[j] = idxs[0]
            elif len(idxs) == 1 and cst == 1:
                c_lits[j] = -idxs[0]
            elif len(idxs) == 0:
                lv = new_var()
                clauses.append([lv if cst else -lv])
                c_lits[j] = lv
            else:
                lv = new_var()
                add_xor(idxs + [lv], cst)
                c_lits[j] = lv

        c6_lits, c6_rhs, c6_cache = [], 0, {}
        for m in poly_t28_branch:
            if m == 0:
                c6_rhs ^= 1
                continue
            bits, tmp = [], m
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
                    for lit in key:
                        clauses.append([-mv, lit])
                    clauses.append([mv] + [-lit for lit in key])
                    c6_cache[key] = mv
                c6_lits.append(c6_cache[key])
        add_xor(c6_lits, c6_rhs)

    mask64 = (1 << 64) - 1
    models_checked = 0
    dual_s_rejects = 0
    fwht_calls = 0
    bent_hits = []
    unsat_closed = False

    with Solver(name="cadical195", bootstrap_with=clauses) as slv:
        while (time.perf_counter() - t_start) < budget_sec:
            if not slv.solve():
                unsat_closed = True
                break
            models_checked += 1
            model = slv.get_model()
            x_bits = 0
            cint = origin
            for i, cdir in enumerate(cb):
                if model[i] > 0:
                    x_bits |= 1 << i
                    cint ^= cdir

            if cint == 0:
                # Reject zero function f == 0 in B0_00
                slv.add_clause([-(i + 1) if model[i] > 0 else (i + 1) for i in range(n)])
                continue

            if b09_dual_checker is not None and not b09_dual_checker(x_bits):
                dual_s_rejects += 1
                slv.add_clause([-(i + 1) if model[i] > 0 else (i + 1) for i in range(n)])
                continue

            fwht_calls += 1
            if lib_fwht.is_bent_65536_c(orb_tts, cint & mask64, cint >> 64):
                bent_hits.append(hex(cint))
                break
            slv.add_clause([-(i + 1) if model[i] > 0 else (i + 1) for i in range(n)])

    return {
        "cell": cell_name,
        "unsat_closed": unsat_closed,
        "models_checked": models_checked,
        "dual_s_integer_rejects": dual_s_rejects,
        "fwht_calls": fwht_calls,
        "bent_hits": bent_hits,
        "cnf_vars": v_cnt[0],
        "cnf_clauses": len(clauses),
        "sat_sec": round(time.perf_counter() - t_start, 3),
    }


def main():
    t0 = time.perf_counter()
    sat_budget = float(sys.argv[1]) if len(sys.argv) > 1 else 90.0
    work_dir = Path(__file__).resolve().parent

    # Compile audit/XL and FWHT shared libraries
    c_xl = work_dir / "b09_xl.c"
    so_xl = work_dir / "libb09_xl.so"
    c_xl.write_text(C_SRC_AUDIT, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_xl), "-o", str(so_xl)], check=True)
    lib = ctypes.CDLL(str(so_xl))
    lib.extract_level1_quad_when_diag4.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64),
    ]
    lib.extract_level1_quad_when_diag4.restype = ctypes.c_int
    lib.extract_coset_full_hierarchy_corrected.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib.extract_coset_full_hierarchy_corrected.restype = ctypes.c_int
    lib.gf2_echelon_insert.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib.gf2_echelon_insert.restype = ctypes.c_int

    c_fw = work_dir / "b09_fwht.c"
    so_fw = work_dir / "libb09_fwht.so"
    c_fw.write_text(C_FWHT_CHECK_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_fw), "-o", str(so_fw)], check=True)
    lib_fwht = ctypes.CDLL(str(so_fw))
    lib_fwht.is_bent_65536_c.argtypes = [ctypes.POINTER(ctypes.c_uint64), ctypes.c_uint64, ctypes.c_uint64]
    lib_fwht.is_bent_65536_c.restype = ctypes.c_int

    orbits = build_orbits_116()
    v6_list = all_v6_orbits()
    dih = build_c8_and_dihedral_structure()
    print("[b09] Dihedral Krawtchouk 35x30 structure verified: "
          "rank_GF2(M mod 2)=1, 18 palindromic + 6 chiral pairs, 4 | (M[z,a]-M[z,abar])!", flush=True)

    orb_tts = (ctypes.c_uint64 * (116 * 1024))()
    for j, orb in enumerate(orbits):
        base = j * 1024
        for m in orb:
            for x in range(65536):
                if (x & m) == m:
                    orb_tts[base + (x >> 6)] ^= 1 << (x & 63)

    # Optional T28 certificate if present in repo
    t28_branches = {0: None, 1: None}
    for cand_p in [
        work_dir / "T28_SEXTA_CERTIFICADO.json",
        work_dir.parent / "archive/T28_SEXTA_CERTIFICADO.json",
        work_dir.parents[1] / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json",
    ]:
        if cand_p.exists():
            cert_t28 = json.loads(cand_p.read_text(encoding="utf-8"))
            t28_branches[0] = [int(h, 16) for h in cert_t28["reduced_models"]["branches"][0]["polynomial_hex"]]
            if len(cert_t28["reduced_models"]["branches"]) > 1:
                t28_branches[1] = [int(h, 16) for h in cert_t28["reduced_models"]["branches"][1]["polynomial_hex"]]
            break

    pair_idx = {}
    all_pairs = []
    for v in range(256):
        for w in range(v + 1, 256):
            pair_idx[(v, w)] = len(all_pairs)
            all_pairs.append(v | (w << 8))
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

    # Precompute C_{0xf} parity mask (proves K=1 in c99=1 -> closes B1_00 immediately!)
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
        if len(mem) == 16 and ((x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)) == 0xF:
            coset_0xf_reps.append(mem[0])
    c0xf_orb_mask = sum(
        1 << j for j, orb in enumerate(orbits)
        if sum(sum((x & m) == m for m in orb) & 1 for x in coset_0xf_reps) & 1
    )

    n = 111
    n3 = n * (n - 1) * (n - 2) // 6
    n2 = n * (n - 1) // 2
    off2, off1, off0 = n3, n3 + n2, n3 + n2 + n
    n_cols = off0 + 1
    n_col_words = (n_cols + 63) // 64
    col3_base = (ctypes.c_int * (n * n))()
    col3_list = []
    cur3 = 0
    for i in range(n):
        for j in range(i + 1, n):
            col3_base[i * n + j] = cur3
            for k in range(j + 1, n):
                col3_list.append((1 << i) | (1 << j) | (1 << k))
            cur3 += (n - 1 - j)
    pair2_col, pair2_list = {}, []
    for i in range(n):
        for j in range(i + 1, n):
            m = (1 << i) | (1 << j)
            pair2_col[m] = off2 + len(pair2_list)
            pair2_list.append(m)

    mask64 = (1 << 64) - 1
    MAX_CHARS = 9
    MAX_C_PAIRS = MAX_CHARS * (MAX_CHARS - 1) // 2
    p_idxs_arr = (ctypes.c_int * 2048)()
    char_words32 = (ctypes.c_uint64 * (MAX_CHARS * 32))()
    quad_buf = (ctypes.c_uint64 * (MAX_CHARS * n_col_words))()
    quad_valid = (ctypes.c_int * MAX_CHARS)()
    lin_buf = (ctypes.c_uint64 * (MAX_C_PAIRS * n_col_words))()
    lin_valid = (ctypes.c_int * MAX_C_PAIRS)()

    max_rows = 18000
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    piv_row_idx = (ctypes.c_int * n_cols)()

    report = {}
    # Run on B1_00, B1_11, and B0_11!
    for c99_val, c57_val, c113_val in [(1, 0, 0), (1, 1, 1), (0, 1, 1)]:
        tc = time.perf_counter()
        cell_name = f"B{c99_val}_{c57_val}{c113_val}"
        _, origin, cb = build_pure_111_basis(c99_val, c57_val, c113_val)

        O_diag, O_pair = 0, 0
        for j in range(116):
            if (origin >> j) & 1:
                O_diag ^= orb_diag[j]
                O_pair ^= orb_pair[j]
        cb_pair = []
        for cdir in cb:
            vp = 0
            for j in range(116):
                if (cdir >> j) & 1:
                    vp ^= orb_pair[j]
            cb_pair.append(vp)

        all_pair_bits = (ctypes.c_uint64 * ((n + 1) * 510))()
        for i in range(n):
            for w in range(510):
                all_pair_bits[i * 510 + w] = (cb_pair[i] >> (64 * w)) & mask64
        for w in range(510):
            all_pair_bits[n * 510 + w] = (O_pair >> (64 * w)) & mask64

        for idx in range(n_cols):
            piv_row_idx[idx] = -1
        cur_row = 0
        deg_pivs = {0: 0, 1: 0, 2: 0, 3: 0}
        xl_queue = []
        deg12_row_indices = []
        b09_new_pivs = {0: 0, 1: 0, 2: 0, 3: 0}

        def record_piv(pc, from_b09=False):
            nonlocal cur_row
            if pc < 0:
                return
            d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
            deg_pivs[d] += 1
            if from_b09:
                b09_new_pivs[d] += 1
            if d in (1, 2):
                xl_queue.append(cur_row)
                deg12_row_indices.append(cur_row)
            cur_row += 1

        def insert_pset(pset, from_b09=False):
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
                    c = col3_base[b0 * n + b1] + (b2 - b1 - 1)
                rows[base + (c >> 6)] ^= 1 << (c & 63)
            pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            record_piv(pc, from_b09=from_b09)
            return pc

        def drain_xl(from_b09=False):
            while xl_queue and piv_row_idx[off0] < 0 and cur_row < max_rows - n - 20:
                r_idx = xl_queue.pop(0)
                row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
                pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
                for i in range(n):
                    if cur_row >= max_rows - 5 or piv_row_idx[off0] >= 0:
                        break
                    insert_pset(mul_poly({1 << i}, pset), from_b09=from_b09)

        # 1. Exact C_{0xf} parity (wt(C_{0xf}) == 128 => even!) + Q4
        p_0xf = {1 << i for i, cdir in enumerate(cb) if (cdir & c0xf_orb_mask).bit_count() & 1}
        if (origin & c0xf_orb_mask).bit_count() & 1:
            p_0xf.add(0)
        insert_pset(p_0xf)

        def lin_expr(indices):
            msk = sum(1 << j for j in indices)
            return [i for i, c in enumerate(cb) if (c & msk).bit_count() & 1], (origin & msk).bit_count() & 1

        def poly_from_lin(idxs, cst):
            p = {1 << i for i in idxs}
            if cst:
                p.add(0)
            return p

        slin_i, slin_c = lin_expr([23, 31, 39, 112])
        q4 = poly_from_lin(slin_i, slin_c ^ c57_val)
        pairs_ij = [(I2, J2), (I3, J3), (I4, J4)] if c99_val == 1 else [(I1, J1), (I2, J2), (I3, J3), (I4, J4)]
        for Ir, Jr in pairs_ij:
            ui, uc = lin_expr(Ir)
            vi, vc = lin_expr(Jr)
            q4 ^= mul_poly(poly_from_lin(ui, uc), poly_from_lin(vi, vc))
        insert_pset(q4)
        drain_xl()

        # 2. Extract V6 x V6 (+ affine diagonal shifts in B0_11 / B1_11 up to 18s)
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
            for m, u16 in enumerate(u_vecs):
                base_m = m * 32
                for k, x in enumerate(pair_reps):
                    if (x & u16).bit_count() & 1:
                        char_words32[base_m + (k >> 6)] |= 1 << (k & 63)

            if wt_diag % 8 == 4:
                base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                if lib.extract_level1_quad_when_diag4(
                    all_pair_bits, p_idxs_arr, n_pairs, n, None, off2, off1, off0, n_col_words, base_ptr
                ) == 0:
                    record_piv(lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
                drain_xl()
                return
            if wt_diag % 8 != 0:
                return
            diag_div8_parity = (wt_diag // 8) & 1
            ctypes.memset(quad_buf, 0, ctypes.sizeof(quad_buf))
            base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            if lib.extract_coset_full_hierarchy_corrected(
                all_pair_bits, p_idxs_arr, n_pairs, n, diag_div8_parity,
                char_words32, MAX_CHARS, col3_base, off2, off1, off0, n_col_words,
                base_ptr, quad_buf, quad_valid, lin_buf, lin_valid
            ) != 0:
                return
            record_piv(lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
            for pm in range(MAX_C_PAIRS):
                if lin_valid[pm] and cur_row < max_rows - 10 and piv_row_idx[off0] < 0:
                    dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                    src = ctypes.cast(ctypes.byref(lin_buf, pm * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                    ctypes.memmove(dst, src, n_col_words * 8)
                    record_piv(lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
            for m in range(MAX_CHARS):
                if quad_valid[m] and cur_row < max_rows - 10 and piv_row_idx[off0] < 0:
                    dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                    src = ctypes.cast(ctypes.byref(quad_buf, m * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                    ctypes.memmove(dst, src, n_col_words * 8)
                    record_piv(lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
            drain_xl()

        for pts8 in v6_list:
            if piv_row_idx[off0] >= 0:
                break
            process_coset([v | (w << 8) for v in pts8 for w in pts8])

        if piv_row_idx[off0] < 0:
            for pts8 in v6_list:
                if (time.perf_counter() - tc) > 18.0 or piv_row_idx[off0] >= 0 or cur_row >= max_rows - 200:
                    break
                pts_set = set(pts8)
                coset_reps8, covered = [0], set(pts8)
                for cand in range(1, 256):
                    if cand not in covered:
                        coset_reps8.append(cand)
                        covered |= {cand ^ p for p in pts_set}
                w_pts = [v | (w << 8) for v in pts8 for w in pts8]
                for a0 in coset_reps8:
                    a16 = a0 | (a0 << 8)
                    if a0 != 0:
                        process_coset([x ^ a16 for x in w_pts])
                    process_coset([interleave16(x ^ a16) for x in w_pts])

        pivs_before_b09 = dict(deg_pivs)
        b09_summary = None
        b09_checker = None

        # 3. In B0_11: Run Task b09 Dual-s Elimination and inject ALL pure equations in c!
        if (c99_val, c57_val, c113_val) == (0, 1, 1) and piv_row_idx[off0] < 0:
            b09_summary, det_y, pair_packs_35, p_lin, p_quad, p_cub = derive_b09_pure_c_equations(
                orbits, origin, cb, dih
            )
            print(f"[B0_11 b09] Summary: {json.dumps(b09_summary, indent=2)}", flush=True)
            for _, _, eq in p_lin:
                insert_pset(eq, from_b09=True)
                drain_xl(from_b09=True)
            for _, _, eq in p_quad:
                insert_pset(eq, from_b09=True)
                drain_xl(from_b09=True)
            for _, _, eq in p_cub:
                insert_pset(eq, from_b09=True)
                drain_xl(from_b09=True)

            # Fast O(1) exact integer dual-s checker for candidate models in B0_11:
            pal_m = dih["pal_m"]
            chiral_m_pairs = dih["chiral_m_pairs"]

            def check_b09_integer_dual(x_bits: int) -> bool:
                s0_val = eval_pset(det_y[0], x_bits) if 0 in det_y else None
                pal_sum = 0
                for idx_p in range(18):
                    yb = 1 + idx_p
                    if yb in det_y:
                        pal_sum += eval_pset(det_y[yb], x_bits)
                sig_sum = 0
                zero_sigs = 0
                for idx_c in range(6):
                    yb = 19 + idx_c
                    if yb in det_y:
                        sv = eval_pset(det_y[yb], x_bits)
                        sig_sum += sv
                        if sv == 0:
                            zero_sigs += 1
                    else:
                        zero_sigs += 1
                # 2*s_0 + pal_sum + sig_sum + 2*sum(pi_a) == 8, with 0 <= sum(pi_a) <= zero_sigs!
                if s0_val is not None and len(det_y) == 25:
                    rem = 8 - (2 * s0_val + pal_sum + sig_sum)
                    if rem < 0 or (rem & 1) or (rem // 2) > zero_sigs:
                        return False
                return True

            b09_checker = check_b09_integer_dual

        cell_res = {
            "has_one_algebraic": (piv_row_idx[off0] >= 0),
            "pivs_before_b09": pivs_before_b09,
            "b09_new_pivs_contributed": b09_new_pivs if c99_val == 0 else None,
            "b09_dual_s_summary": b09_summary,
            "deg_pivs_final": dict(deg_pivs),
            "total_pivots": cur_row,
            "alg_sec": round(time.perf_counter() - tc, 3),
        }

        # 4. If not closed algebraically in deg <= 3, run ultra-fast CardEnc-free SAT on deg <= 2 pivots!
        if not cell_res["has_one_algebraic"] and sat_budget > 0:
            deg12_psets = []
            for r_idx in deg12_row_indices:
                row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
                pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
                if poly_deg(pset) <= 2:
                    deg12_psets.append(pset)
            sat_res = fast_sat_close_degree2(
                cell_name=cell_name,
                n=n,
                origin=origin,
                cb=cb,
                deg12_psets=deg12_psets,
                orbits=orbits,
                lib_fwht=lib_fwht,
                orb_tts=orb_tts,
                poly_t28_branch=t28_branches.get(c99_val),
                b09_dual_checker=b09_checker,
                budget_sec=sat_budget,
            )
            cell_res["sat_close"] = sat_res

        report[cell_name] = cell_res
        print(f"[{cell_name}] DONE: {json.dumps(cell_res, indent=2)}", flush=True)

    print("=== FINAL B09 DUAL-S ELIMINATION & FAST CLOSE REPORT ===", flush=True)
    print(json.dumps({"cells": report, "total_sec": round(time.perf_counter() - t0, 3)}, indent=2), flush=True)


if __name__ == "__main__":
    main()

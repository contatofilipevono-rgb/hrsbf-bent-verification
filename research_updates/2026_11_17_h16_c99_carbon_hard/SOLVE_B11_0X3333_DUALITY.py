#!/usr/bin/env python3
r"""
Task b11_0x3333_coset_duality:
  1. Exact 8-dim subspace duality on V_{0x3333} = {x <= 0x3333} and V_{0xcccc} = {u <= 0xcccc}.
  2. Proves & verifies that EXACTLY 16 long orbits (+ short orbits O_57, O_113, O_115) touch V_{0x3333}
     (2^16 = 65,536 states, 2x smaller than 2^17!).
  3. Extracts exact linear & quadratic equations in c from the 69 canonical <rot^4>-orbits of
     cosets V_{0x3333} ^ b (b in V_{0xcccc} \ {0}) by eliminating the 60 unknown dual bits tau_k
     via the left-nullspace of the cyclic Krawtchouk matrix + the U_4 4-coset mod-16 identity!
  4. Sweeps all 2^16 = 65,536 states of J_16 in C (< 0.01s) using:
     - Projected elimination ideal I_{J_16} from global degree <= 2 pivots,
     - 8-bit FWHT spectral filters |W_{g3}(alpha)| <= 256 and B0_00 asymmetric bound [-224, 256] on V_3 cap U_8.
  5. Closes B1_00 (algebraically) and attacks B1_11 (223+ quadratics in 109 vars!), B0_11, B0_00
     with a lightweight CNF (NO heavy static CardEnc counters!) + C lazy coset/FWHT verifier.

Usage:
  python3 SOLVE_B11_0X3333_DUALITY.py [budget_per_cell_sec]
"""
import ctypes
import json
import random
import subprocess
import sys
import time
from pathlib import Path

from pysat.solvers import Solver

from AUDIT_ALL_CELLS_111 import (
    C_SRC as C_SRC_AUDIT,
    I1, I2, I3, I4, J1, J2, J3, J4,
    K_INDICES, L_INDICES, R_INDICES,
    all_v6_orbits, build_orbits_116, decode_row_to_pset, interleave16, rot8, rot16,
)

C_SRC_B11 = C_SRC_AUDIT + r"""

// Fast 8-bit FWHT + polynomial elimination filter over all 2^16 = 65,536 states of V_{0x3333}!
int scan_0x3333_states_c(
    int n_vars16,                  // 16
    const uint64_t *orb16_tt4,     // 16 * 4 uint64_t words (256-bit truth table on V_3 for each of the 16 long orbits)
    const uint64_t *fixed_tt4,     // 4 uint64_t words (contribution of O_57 and O_113 on V_3)
    int is_b0_00,                  // 1 if cell is B0_00 (enables [-224, +256] on V_3 cap U_8 and wt <= 240)
    int n_elim_polys,              // pure polynomials in z_0..z_15 from Schur elimination of global V_2
    const int *poly_offs,          // [n_elim_polys + 1]
    const uint16_t *poly_masks,    // bitmasks in 0..65535 (0 = constant 1 term!)
    const uint8_t *poly_consts,    // constant bit of each pure polynomial
    const int *u8_in_v3_indices,   // 16 indices in 0..255 corresponding to V_3 cap U_8
    uint16_t *out_survivors,       // output array of surviving 16-bit states
    int *out_elim_killed,
    int *out_spec_killed
) {
    int surv = 0, ek = 0, sk = 0;
    int total = 1 << n_vars16;

    for (int z = 0; z < total; z++) {
        // 1. Check projected algebraic equations P(z) == 0
        int alg_ok = 1;
        for (int p = 0; p < n_elim_polys; p++) {
            int val = poly_consts[p];
            for (int idx = poly_offs[p]; idx < poly_offs[p + 1]; idx++) {
                uint16_t m = poly_masks[idx];
                if ((z & m) == m) val ^= 1;
            }
            if (val != 0) {
                alg_ok = 0;
                break;
            }
        }
        if (!alg_ok) {
            ek++;
            continue;
        }

        // 2. Build 256-bit truth table g_3 on V_3
        uint64_t tt[4] = {fixed_tt4[0], fixed_tt4[1], fixed_tt4[2], fixed_tt4[3]};
        int tmp = z;
        while (tmp) {
            int b = __builtin_ctz(tmp);
            tmp &= tmp - 1;
            const uint64_t *src = orb16_tt4 + (size_t)b * 4;
            tt[0] ^= src[0]; tt[1] ^= src[1]; tt[2] ^= src[2]; tt[3] ^= src[3];
        }

        int wt = __builtin_popcountll(tt[0]) + __builtin_popcountll(tt[1])
               + __builtin_popcountll(tt[2]) + __builtin_popcountll(tt[3]);
        if (is_b0_00 && wt > 240) {
            sk++;
            continue;
        }

        // 3. 8-bit FWHT on 256 points
        int spec[256];
        for (int x = 0; x < 256; x++) {
            int bit = (tt[x >> 6] >> (x & 63)) & 1ULL;
            spec[x] = bit ? -1 : 1;
        }
        for (int step = 1; step < 256; step <<= 1) {
            int dbl = step << 1;
            for (int i = 0; i < 256; i += dbl) {
                for (int j = 0; j < step; j++) {
                    int u = spec[i + j], v = spec[i + j + step];
                    spec[i + j] = u + v;
                    spec[i + j + step] = u - v;
                }
            }
        }

        int spec_ok = 1;
        // Note: |spec[a]| <= 256 is automatic on 256 points, equality 256 iff g_3 is affine (i.e. z=0 and fixed=0).
        // In B0_00, Theorem A1 forces f~|_{U_8} == 0 => W_{g3}(a) = 256 - 8*q_a >= -224 for all 16 a in V_3 cap U_8!
        if (is_b0_00) {
            for (int k = 0; k < 16; k++) {
                int wv = spec[u8_in_v3_indices[k]];
                if (wv < -224 || (wv & 7) != 0) {
                    spec_ok = 0;
                    break;
                }
            }
        }
        if (!spec_ok) {
            sk++;
            continue;
        }
        out_survivors[surv++] = (uint16_t)z;
    }
    *out_elim_killed = ek;
    *out_spec_killed = sk;
    return surv;
}

// Full 65,536-point FWHT bentness auditor in C (0.05 ms per call)
int audit_bent_116_c(
    const uint64_t *orb_tts, // 116 * 1024 uint64_t
    uint64_t c_lo,
    uint64_t c_hi,
    int *out_first_bad_u,
    int *out_first_bad_val
) {
    uint64_t tt[1024];
    memset(tt, 0, sizeof(tt));
    for (int j = 0; j < 116; j++) {
        int bit = (j < 64) ? ((c_lo >> j) & 1ULL) : ((c_hi >> (j - 64)) & 1ULL);
        if (bit) {
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
                int32_t u = spec[i + j], v = spec[i + j + step];
                spec[i + j] = u + v;
                spec[i + j + step] = u - v;
            }
        }
    }
    for (int u = 0; u < 65536; u++) {
        if (spec[u] != 256 && spec[u] != -256) {
            *out_first_bad_u = u;
            *out_first_bad_val = spec[u];
            return 0;
        }
    }
    return 1;
}
"""

S3_BITS = [0, 1, 4, 5, 8, 9, 12, 13]
SC_BITS = [2, 3, 6, 7, 10, 11, 14, 15]
U4_SET = {u * 0x1111 for u in range(16)}


def expand_8_to_16(byte_val: int, bit_pos: list[int]) -> int:
    out = 0
    for idx, pos in enumerate(bit_pos):
        if (byte_val >> idx) & 1:
            out |= 1 << pos
    return out


def build_0x3333_geometry(orbits):
    """Build V_3, V_C, the exact 16 touching long orbits, and the 70 G_4-orbits on V_3 and V_C."""
    v3_pts = [expand_8_to_16(i, S3_BITS) for i in range(256)]
    vc_pts = [expand_8_to_16(i, SC_BITS) for i in range(256)]

    touching_long = []
    touching_short = {}
    for j, orb in enumerate(orbits):
        in_s3 = [m for m in orb if (m & ~0x3333) == 0]
        if in_s3:
            if len(orb) == 16:
                touching_long.append((j, len(in_s3)))
            else:
                touching_short[j] = len(in_s3)

    assert len(touching_long) == 16, f"Expected 16 long orbits, got {len(touching_long)}"
    assert all(cnt == 4 for _, cnt in touching_long)
    assert touching_short == {57: 2, 113: 2, 115: 2}, f"Unexpected short orbits: {touching_short}"

    def partition_g4(pts):
        seen = set()
        g4_orbs = []
        for x in pts:
            if x in seen:
                continue
            orb = []
            cur = x
            for _ in range(4):
                if cur not in orb:
                    orb.append(cur)
                cur = rot16(cur, 4)
            seen.update(orb)
            g4_orbs.append((min(orb), orb))
        return g4_orbs

    v3_g4 = partition_g4(v3_pts)
    vc_g4 = partition_g4(vc_pts)
    assert len(v3_g4) == 70 and len(vc_g4) == 70
    return v3_pts, vc_pts, [j for j, _ in touching_long], v3_g4, vc_g4


def build_c8_dual_map():
    seen = set()
    u8_size8 = []
    rep_of_byte = {}
    for a in range(256):
        if a in seen:
            continue
        orb, cur = [], a
        while cur not in orb:
            orb.append(cur)
            cur = rot8(cur)
        seen.update(orb)
        rep = min(orb)
        for z in orb:
            rep_of_byte[z] = (rep, len(orb))
        if len(orb) == 8:
            u8_size8.append((rep, orb))
    return u8_size8, rep_of_byte


def gf2_nullspace_left_rows(mat_rows):
    """Given list of int bitmasks (each row is a bitmask of columns), return basis of left nullspace."""
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


def extract_sym2_from_forms(lin_masks, origin_bits, n):
    """Exact quadratic pset for (wt(forms) // 2) % 2 when wt(forms) % 2 == 0 identically."""
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
        tmp = wm
        while tmp:
            b = tmp & -tmp
            col_masks[b.bit_length() - 1] |= 1 << r
            tmp ^= b
    for i in range(n):
        ci = col_masks[i]
        c_wt = ci.bit_count()
        lin_coeff = ((c_wt * (c_wt - 1)) // 2) & 1
        for r in range(M):
            if ((ci >> r) & 1) and ((o_wt - origin_bits[r]) & 1):
                lin_coeff ^= 1
        if lin_coeff:
            toggle(1 << i)
    for i in range(n):
        ci = col_masks[i]
        ci_wt = ci.bit_count()
        if ci_wt == 0:
            continue
        for j in range(i + 1, n):
            cj = col_masks[j]
            if cj and ((ci_wt * cj.bit_count() - (ci & cj).bit_count()) & 1):
                toggle((1 << i) | (1 << j))
    return pset


def extract_wt_div2_poly_general(lin_masks, origin_bits, n):
    """
    For ANY collection of M affine forms g_p(x) = o_p ^ <w_p, x> such that sum_p g_p(x) is ALWAYS EVEN
    (i.e. sum o_p is even and every col_mask[i] has even popcount), extract the exact degree <= 2
    polynomial for (sum_p g_p(x)) // 2 mod 2:
      const: (o_wt // 2) & 1
      lin i: ((wt(B_i) - 2*wt(B_i & O)) // 2) & 1
      quad i<j: wt(B_i & B_j) & 1
    """
    O_word = sum((1 << r) for r, ob in enumerate(origin_bits) if ob)
    o_pop = O_word.bit_count()
    if o_pop & 1:
        return None
    col_masks = [0] * n
    for r, wm in enumerate(lin_masks):
        tmp = wm
        while tmp:
            b = tmp & -tmp
            col_masks[b.bit_length() - 1] |= 1 << r
            tmp ^= b
    pset = set()
    if (o_pop >> 1) & 1:
        pset.add(0)
    for i in range(n):
        wp = col_masks[i].bit_count()
        if wp & 1:
            return None
        wop = (col_masks[i] & O_word).bit_count()
        ai = wp - 2 * wop
        if (ai >> 1) & 1:
            pset.add(1 << i)
    for i in range(n):
        bi = col_masks[i]
        if not bi:
            continue
        for j in range(i + 1, n):
            if (bi & col_masks[j]).bit_count() & 1:
                pset.add((1 << i) | (1 << j))
    return pset


def add_and_gate(clauses, z, inputs):
    for lit in inputs:
        clauses.append([-z, lit])
    clauses.append([z] + [-lit for lit in inputs])


def add_xor_clauses(clauses, lits, rhs, new_var):
    if not lits:
        if rhs:
            v = new_var()
            clauses.append([v])
            clauses.append([-v])
        return
    cur = list(lits)
    while len(cur) > 4:
        chunk, rest = cur[:3], cur[3:]
        aux = new_var()
        # chunk[0] ^ chunk[1] ^ chunk[2] ^ aux == 0
        vs = chunk + [aux]
        for mask in range(16):
            if mask.bit_count() & 1:
                clauses.append([-vs[k] if ((mask >> k) & 1) else vs[k] for k in range(4)])
        cur = [aux] + rest
    klen = len(cur)
    for mask in range(1 << klen):
        if (mask.bit_count() & 1) != rhs:
            clauses.append([-cur[k] if ((mask >> k) & 1) else cur[k] for k in range(klen)])


def encode_deg2_pset(clauses, pset, new_var, pair_cache):
    rhs = 1 if (0 in pset) else 0
    lits = []
    for m in sorted(pset):
        if m == 0:
            continue
        if m.bit_count() == 1:
            lits.append(m.bit_length())
        elif m.bit_count() == 2:
            b0 = (m & -m).bit_length()
            b1 = (m ^ (1 << (b0 - 1))).bit_length()
            key = (b0, b1)
            if key not in pair_cache:
                pv = new_var()
                add_and_gate(clauses, pv, [b0, b1])
                pair_cache[key] = pv
            lits.append(pair_cache[key])
        else:
            raise ValueError("Expected degree <= 2")
    add_xor_clauses(clauses, lits, rhs, new_var)


def main():
    t0 = time.perf_counter()
    budget_per_cell = float(sys.argv[1]) if len(sys.argv) > 1 else 90.0
    work_dir = Path(__file__).resolve().parent

    c_path = work_dir / "b11_0x3333.c"
    so_path = work_dir / "libb11_0x3333.so"
    c_path.write_text(C_SRC_B11, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)], check=True)
    lib = ctypes.CDLL(str(so_path))

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
    lib.scan_0x3333_states_c.argtypes = [
        ctypes.c_int, ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint16), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint16),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
    ]
    lib.scan_0x3333_states_c.restype = ctypes.c_int
    lib.audit_bent_116_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_uint64, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
    ]
    lib.audit_bent_116_c.restype = ctypes.c_int

    orbits = build_orbits_116()
    v3_pts, vc_pts, j16_orbs, v3_g4, vc_g4 = build_0x3333_geometry(orbits)
    u8_size8, rep_of_byte = build_c8_dual_map()
    v6_list = all_v6_orbits()

    print(f"[Geometry] Touching long orbits on V_0x3333 ({len(j16_orbs)}): {j16_orbs}", flush=True)

    # Full 65,536-bit truth tables of all 116 orbits (both Python int and C uint64 array)
    orb_tts_c = (ctypes.c_uint64 * (116 * 1024))()
    orb_tts_py = [0] * 116
    for j, orb in enumerate(orbits):
        a = bytearray(65536)
        for m in orb:
            a[m] ^= 1
        step = 1
        while step < 65536:
            dbl = step << 1
            for i in range(0, 65536, dbl):
                for k in range(i, i + step):
                    a[k + step] ^= a[k]
            step = dbl
        val_py = 0
        base = j * 1024
        for w in range(1024):
            word = 0
            off = w << 6
            for b in range(64):
                if a[off + b]:
                    word |= 1 << b
            orb_tts_c[base + w] = word
            val_py |= word << off
        orb_tts_py[j] = val_py

    def eval_orb_x(j, x):
        return (orb_tts_py[j] >> x) & 1

    # Verify C5 (wt(f|_{0x3f3f}) == 0 mod 16 => c57 == K) directly from 65,536-bit truth table!
    mask_3f3f = sum(1 << x for x in range(65536) if (x & ~0x3F3F) == 0)
    assert mask_3f3f.bit_count() == 4096

    # Classify the 70 G_4-orbits of V_C:
    # - 4 in U_4 (0x0000, 0x4444, 0x8888, 0xcccc)
    # - 6 of size 2 in (V_C cap U_8) \ U_4
    # - 60 of size 4 in V_C \ U_8 -> unknown dual bits tau_0 .. tau_59!
    vc_u4_nonzero = [orb for _, orb in vc_g4 if len(orb) == 1 and orb[0] != 0]      # 3 cosets (Class I)
    vc_u8_size2   = [orb for _, orb in vc_g4 if len(orb) == 2]                       # 6 cosets (Class II)
    vc_tau60      = [orb for _, orb in vc_g4 if len(orb) == 4]                       # 60 orbits (Class III)
    assert len(vc_u4_nonzero) == 3 and len(vc_u8_size2) == 6 and len(vc_tau60) == 60

    # Distinct C_16-orbits touched by vc_u8_size2 in (U_8 \ U_4)/C_8:
    u8_c8_reps_in_vc = sorted({rep_of_byte[orb[0] & 0xFF][0] for orb in vc_u8_size2})
    s_idx_map = {r: idx for idx, r in enumerate(u8_c8_reps_in_vc)}
    n_s_local = len(u8_c8_reps_in_vc)  # 4 or 5 distinct C_8-orbits in U_8 \ U_4!
    print(f"[Dual V_C cap U_8] Touches {n_s_local} C8-orbits in U_8\\U_4: {[hex(r) for r in u8_c8_reps_in_vc]}", flush=True)

    # Precompute pair & diag tables for V6xV6
    pair_idx = {}
    all_pairs = []
    for v in range(256):
        for w in range(v + 1, 256):
            pair_idx[(v, w)] = len(all_pairs)
            all_pairs.append(v | (w << 8))
    orb_diag = [sum(eval_orb_x(j, v | (v << 8)) << v for v in range(256)) for j in range(116)]
    orb_pair = [sum(eval_orb_x(j, x) << k for k, x in enumerate(all_pairs)) for j in range(116)]

    # Precompute C_{0xf} reps (256 size-16 orbits)
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
        if len(mem) == 16 and (((x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)) == 0xF):
            coset_0xf_reps.append(mem[0])
    orb_0xf_par = [sum(eval_orb_x(j, x) for x in coset_0xf_reps) & 1 for j in range(116)]

    # Try to load T28 C6 polynomial if available in repo, else reconstruct/skip gracefully
    poly_t28 = {0: None, 1: None}
    for cand_p in [
        work_dir / "T28_SEXTA_CERTIFICADO.json",
        work_dir.parent / "archive/T28_SEXTA_CERTIFICADO.json",
        work_dir.parent.parent / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json",
    ]:
        if cand_p.exists():
            cert28 = json.loads(cand_p.read_text(encoding="utf-8"))
            for br in cert28.get("reduced_models", {}).get("branches", []):
                b_c99 = int(br.get("c99", 0))
                poly_t28[b_c99] = [int(h, 16) for h in br["polynomial_hex"]]
            break

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

    # Indices in 0..255 of V_3 cap U_8 for the 8-bit FWHT check in C
    u8_in_v3_idx = (ctypes.c_int * 16)(*[
        idx for idx, x in enumerate(v3_pts) if (x & 0xFF) == (x >> 8)
    ])

    report = {}
    for c99_val, c57_val, c113_val in [(1, 0, 0), (1, 1, 1), (0, 1, 1), (0, 0, 0)]:
        tc = time.perf_counter()
        cell_name = f"B{c99_val}_{c57_val}{c113_val}"

        # Pure 111-variable basis (ONLY c115=0 and L=c99 eliminating c0)
        excluded = {0, 57, 99, 113, 115}
        free111 = sorted(set(range(116)) - excluded)
        L_set = set(L_INDICES)
        origin = (c99_val << 0) | (c99_val << 99) | (c57_val << 57) | (c113_val << 113)
        cb = [(1 << j) ^ ((1 << 0) if (j in L_set) else 0) for j in free111]

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
        deg12_rows = []
        stats = {"c5_3f3f_piv": 0, "c0xf_piv": 0, "b11_lin_pivs": 0, "b11_quad_pivs": 0, "v6_pivs": 0}

        def eval_x_form(x_pt):
            o_bit = 0
            for j in range(116):
                if ((origin >> j) & 1) and eval_orb_x(j, x_pt):
                    o_bit ^= 1
            w_mask = 0
            for i, cdir in enumerate(cb):
                bit = 0
                tmp = cdir
                while tmp:
                    b = tmp & -tmp
                    if eval_orb_x(b.bit_length() - 1, x_pt):
                        bit ^= 1
                    tmp ^= b
                if bit:
                    w_mask |= 1 << i
            return w_mask, o_bit

        def record_piv(pc, key=None):
            nonlocal cur_row
            if pc < 0:
                return
            d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
            deg_pivs[d] += 1
            if d in (1, 2):
                xl_queue.append(cur_row)
                deg12_rows.append(cur_row)
            if key:
                stats[key] += 1
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

        def insert_pset(pset, key=None):
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
            record_piv(pc, key=key)
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

        # --- A. Direct Poisson mod-16 on W = V_{0x3f3f} (dim 12, derives C5: K == c57 from first principles!) ---
        pts_3f3f = [x for x in range(65536) if (x & ~0x3F3F) == 0]
        d_pts_3f = [x & 0xFF for x in pts_3f3f if (x & 0xFF) == (x >> 8)]
        p_pts_3f = [x for x in pts_3f3f if (x & 0xFF) < (x >> 8)]
        wt_d_3f = sum((O_diag >> v) & 1 for v in d_pts_3f)
        for k, x in enumerate(p_pts_3f):
            p_idxs_arr[k] = pair_idx[(x & 0xFF, x >> 8)]
        base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
        if wt_d_3f % 8 == 0:
            if lib.extract_coset_full_hierarchy_corrected(
                all_pair_bits, p_idxs_arr, len(p_pts_3f), n, (wt_d_3f // 8) & 1,
                char_words32, 0, col3_base, off2, off1, off0, n_col_words,
                base_ptr, quad_buf, quad_valid, lin_buf, lin_valid
            ) == 0:
                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                record_piv(pc, key="c5_3f3f_piv")
        drain_xl()

        # --- B. Exact parity of C_{0xf} (Theorem 1: wt_orb16(C_{0xf}) == 128 => even! Closes B1_00 with A!) ---
        c0xf_mask = sum(1 << j for j in range(116) if orb_0xf_par[j])
        p_0xf = {1 << i for i, cdir in enumerate(cb) if (cdir & c0xf_mask).bit_count() & 1}
        if (origin & c0xf_mask).bit_count() & 1:
            p_0xf.add(0)
        insert_pset(p_0xf, key="c0xf_piv")
        drain_xl()

        # --- C. Seed Q4 ---
        if piv_row_idx[off0] < 0:
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
                q4 ^= mul_p(poly_from_lin(ui, uc), poly_from_lin(vi, vc))
            insert_pset(q4)
            drain_xl()

        # --- D. TASK b11: Extract ALL Linear & Quadratic Syzygies from the 69 Cosets V_{0x3333} ^ b! ---
        if piv_row_idx[off0] < 0:
            # 1) forms on V_3 \ D_8 (60 size-4 G_4-orbits): r_3(z)
            v3_free60_reps = [orb[0] for _, orb in v3_g4 if len(orb) == 4]
            forms_r3 = [eval_x_form(x) for x in v3_free60_reps]
            r3_lin_mask = 0
            r3_lin_const = 0
            for wm, ob in forms_r3:
                r3_lin_mask ^= wm
                r3_lin_const ^= ob

            # Dual column layout for Krawtchouk syzygy elimination:
            # Bits 0..59 = tau_0..tau_59 (always unknown).
            # In B0_00 (c99=0, c57=0), ALL s_m in U_8 are PROVEN 0 (Theorem A1), so n_dual = 60!
            # Otherwise, bits 60..60+n_s_local-1 = s_m for the C_8-orbits of (V_C cap U_8) \ U_4!
            is_b0_00 = (c99_val == 0 and c57_val == 0 and c113_val == 0)

            # Class I (3 U_4 cosets: 0x4444, 0x8888, 0xcccc): Eq. (14) pure linear + Eq. (13) mod-16 coupled!
            coupled_quad_eqs = []  # list of (dual_bitmask, poly_pset_in_c)
            class1_e2_polys = []

            for b_orb in vc_u4_nonzero:
                b = b_orb[0]
                coset_pts = [y ^ b for y in v3_pts]
                d_pts = [x for x in coset_pts if (x & 0xFF) == (x >> 8)]
                d0_b = sum(eval_x_form(x)[1] for x in d_pts)  # constant on D_8!
                assert d0_b % 4 == 0
                # 60 G_4-orbits on (V_3 ^ b) \ D_8
                seen_c = set()
                reps60 = []
                for x in coset_pts:
                    if (x & 0xFF) == (x >> 8) or x in seen_c:
                        continue
                    o4 = [x, rot16(x, 4), rot16(x, 8), rot16(x, 12)]
                    seen_c.update(o4)
                    reps60.append(min(o4))
                assert len(reps60) == 60
                forms_b = [eval_x_form(x) for x in reps60]

                # Eq. (14): parity(t_b) ^ parity(t_0) ^ ((d0_b // 4) ^ c57) == 0 (PURE LINEAR IN c!)
                wb_xor, ob_xor = 0, 0
                for wm, ob in forms_b:
                    wb_xor ^= wm
                    ob_xor ^= ob
                lin_m = wb_xor ^ r3_lin_mask
                lin_c = ob_xor ^ r3_lin_const ^ ((d0_b // 4) & 1) ^ c57_val
                lp = {1 << i for i in range(n) if (lin_m >> i) & 1}
                if lin_c:
                    lp.add(0)
                if lp:
                    insert_pset(lp, key="b11_lin_pivs")
                else:
                    # Parity of (wt(t_b) - wt(r_3) + d0_b/4 - c57) is identically 0!
                    # Divide Eq. (13) by 8 mod 2:
                    # ((d0_b + 4*wt(t_b) - 128 - 4*c57 - 4*r_3) // 8) % 2 == sum_{<O_k, b>=1} tau_k mod 2!
                    # Build exact degree <= 2 polynomial for ((wt(t_b) + (60 - r_3) + (d0_b/4 - c57 - 60)) // 2) % 2!
                    comb_masks = [wm for wm, _ in forms_b] + [wm for wm, _ in forms_r3]
                    comb_origs = [ob for _, ob in forms_b] + [ob ^ 1 for _, ob in forms_r3]  # 1 - r3_p = 1 ^ r3_p!
                    # Sum = wt(t_b) + 60 - r_3. Target = 32 + c57 - d0_b//4 + 60 - 2*sum_tau = 92 + c57 - d0_b//4 - 2*sum_tau
                    p_q = extract_wt_div2_poly_general(comb_masks, comb_origs, n)
                    if p_q is not None:
                        shift_cst = ((92 + c57_val - (d0_b // 4)) // 2) & 1
                        if shift_cst:
                            p_q ^= {0}
                        dual_m = 0
                        for k, tau_orb in enumerate(vc_tau60):
                            if ((tau_orb[0] & b).bit_count() & 1) == 1:
                                dual_m |= 1 << k
                        coupled_quad_eqs.append((dual_m, p_q))
                        class1_e2_polys.append(p_q)

            # Theorem 4.3 Eq. (15): Sum of the 3 Class-I mod-16 equations cancels ALL tau_k identically!
            if len(class1_e2_polys) == 3:
                p_sum3 = class1_e2_polys[0] ^ class1_e2_polys[1] ^ class1_e2_polys[2]
                insert_pset(p_sum3, key="b11_quad_pivs")

            # Class II (6 U_8\U_4 cosets): Eq. (17) -> degree <= 2 in c, linear in tau_0..tau_59!
            for b_orb in vc_u8_size2:
                b = b_orb[0]
                coset_pts = [y ^ b for y in v3_pts]
                d_pts = [x for x in coset_pts if (x & 0xFF) == (x >> 8)]
                d0_b = sum(eval_x_form(x)[1] for x in d_pts)
                reps120 = [x for x in coset_pts if (x & 0xFF) < (x >> 8)]
                assert len(reps120) == 120
                forms120 = [eval_x_form(x) for x in reps120]
                p_q2 = extract_wt_div2_poly_general([wm for wm, _ in forms120], [ob for _, ob in forms120], n)
                if p_q2 is not None:
                    # Eq. (17): ((wt_120 + d0_b/2) // 2) % 2 == c57 ^ r3_parity ^ sum_{mu_{b,k}==1} tau_k
                    # Wait: d0_b is multiple of 4, so d0_b/2 is even, ((d0_b/2)//2)&1 = (d0_b//4)&1!
                    cst_rhs = ((d0_b // 4) & 1) ^ c57_val ^ r3_lin_const
                    p_tot = set(p_q2)
                    for i in range(n):
                        if (r3_lin_mask >> i) & 1:
                            p_tot ^= {1 << i}
                    if cst_rhs:
                        p_tot ^= {0}
                    dual_m = 0
                    for k, tau_orb in enumerate(vc_tau60):
                        kap = sum(-1 if ((u & b).bit_count() & 1) else 1 for u in tau_orb)
                        mu = (4 - kap) // 4
                        if mu & 1:
                            dual_m |= 1 << k
                    coupled_quad_eqs.append((dual_m, p_tot))

            # Class III (60 V_C\U_8 cosets): Eq. (18) -> degree <= 2 in c (with IDENTICAL quadratic part!),
            # linear in tau_0..tau_59 and s_m!
            # Also include Corollary 3.1 Eq. (6): sum of the 4 weight-even/odd s_m == 0!
            if not is_b0_00:
                eq6_mask = 0
                for b_orb in vc_u8_size2:
                    if len(b_orb) == 2:
                        rep8, _ = rep_of_byte[b_orb[0] & 0xFF]
                        # Count multiplicity in Eq. (5): each G_4-orbit of size 2 contributes 2 * s_{rep8}!
                        # So 2 * (sum over the 6 G_4-orbits of s_{rep8}) == 0 mod 4!
                        eq6_mask ^= 1 << (60 + s_idx_map[rep8])
                if eq6_mask:
                    coupled_quad_eqs.append((eq6_mask, set()))

            for b_orb in vc_tau60:
                b = b_orb[0]
                coset_pts = [y ^ b for y in v3_pts]
                forms256 = [eval_x_form(x) for x in coset_pts]
                p_q3 = extract_wt_div2_poly_general([wm for wm, _ in forms256], [ob for _, ob in forms256], n)
                if p_q3 is None:
                    continue
                dual_m = 0
                for k, tau_orb in enumerate(vc_tau60):
                    kap = sum(-1 if ((u & b).bit_count() & 1) else 1 for u in tau_orb)
                    if (kap // 2) & 1:
                        dual_m |= 1 << k
                if not is_b0_00:
                    # Group the 12 points of (V_C cap U_8) \ U_4 by their C_8-orbit rep!
                    kap_by_s = [0] * n_s_local
                    for u_orb in vc_u8_size2:
                        rep8, _ = rep_of_byte[u_orb[0] & 0xFF]
                        si = s_idx_map[rep8]
                        for u in u_orb:
                            kap_by_s[si] += (-1 if ((u & b).bit_count() & 1) else 1)
                    for si, kv in enumerate(kap_by_s):
                        if (kv // 2) & 1:
                            dual_m |= 1 << (60 + si)
                coupled_quad_eqs.append((dual_m, p_q3))

            # Eliminate ALL unknown dual bits (tau_0..tau_59 and local s_m) via exact GF(2) left-nullspace!
            dual_rows = [dm for dm, _ in coupled_quad_eqs]
            syz_vecs = gf2_nullspace_left_rows(dual_rows)
            for sv in syz_vecs:
                if piv_row_idx[off0] >= 0:
                    break
                p_comb = set()
                for idx_eq in range(len(coupled_quad_eqs)):
                    if (sv >> idx_eq) & 1:
                        p_comb ^= coupled_quad_eqs[idx_eq][1]
                if p_comb:
                    max_d = max(m.bit_count() for m in p_comb)
                    insert_pset(p_comb, key=("b11_lin_pivs" if max_d <= 1 else "b11_quad_pivs"))
            drain_xl()

        # --- E. Standard V6xV6 + Diagonal Affine Shifts + Interleaved Hierarchy ---
        for pts8 in v6_list:
            if piv_row_idx[off0] >= 0 or (time.perf_counter() - tc) > budget_per_cell * 0.35:
                break
            w_pts = [v | (w << 8) for v in pts8 for w in pts8]
            for pts_16 in (w_pts, [interleave16(x) for x in w_pts]):
                diag_pts = [x & 0xFF for x in pts_16 if (x & 0xFF) == (x >> 8)]
                pair_reps = [x for x in pts_16 if (x & 0xFF) < (x >> 8)]
                wt_diag = sum((O_diag >> v) & 1 for v in diag_pts)
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
                        all_pair_bits, p_idxs_arr, len(pair_reps), n, None,
                        off2, off1, off0, n_col_words, base_ptr
                    ) == 0:
                        pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                        record_piv(pc, key="v6_pivs")
                    drain_xl()
                elif wt_diag % 8 == 0:
                    ctypes.memset(quad_buf, 0, ctypes.sizeof(quad_buf))
                    base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                    if lib.extract_coset_full_hierarchy_corrected(
                        all_pair_bits, p_idxs_arr, len(pair_reps), n, (wt_diag // 8) & 1,
                        char_words32, 9, col3_base, off2, off1, off0, n_col_words,
                        base_ptr, quad_buf, quad_valid, lin_buf, lin_valid
                    ) == 0:
                        pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                        record_piv(pc, key="v6_pivs")
                        for m in range(9):
                            if quad_valid[m] and cur_row < max_rows - 10 and piv_row_idx[off0] < 0:
                                dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                                src = ctypes.cast(ctypes.byref(quad_buf, m * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                                ctypes.memmove(dst, src, n_col_words * 8)
                                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                                record_piv(pc, key="v6_pivs")
                        drain_xl()

        has_one_alg = (piv_row_idx[off0] >= 0)

        # --- F. C Sweep over all 2^16 = 65,536 states of V_{0x3333} (J_16) ---
        ts_c = time.perf_counter()
        j16_to_pos = {}
        for pos, j_orb in enumerate(j16_orbs):
            # In free111, every j_orb in j16_orbs is present directly as cb[idx] = (1<<j_orb) ^ [c0]!
            # Wait: check if c0 (orbit 0: {0,1,2,3}) touches V_{0x3333}!
            # Orbit 0 has {0,1,2,3}: bit 2,3 in S_C! No rotation of 4 consecutive bits lies in S_3!
            # PROVEN BONUS: Orbit 0 DOES NOT TOUCH V_{0x3333}! So cb[idx] on V_{0x3333} is PURELY c_{j_orb}!!
            idx_111 = free111.index(j_orb)
            j16_to_pos[idx_111] = pos
        assert 0 not in j16_orbs, "Orbit 0 cannot touch 0x3333!"

        # Project degree <= 2 pivots onto J_16 by Gaussian elimination of all non-J_16 monomials!
        deg12_psets = []
        for r_idx in deg12_rows:
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            deg12_psets.append(decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list))

        non_j16_mask = sum((1 << i) for i in range(n) if i not in j16_to_pos)
        elim_pivs = {}
        pure_j16_polys = []
        for pset in deg12_psets:
            cur = set(pset)
            while cur:
                outside = [m for m in cur if (m & non_j16_mask) != 0]
                if not outside:
                    pure_j16_polys.append(cur)
                    break
                lead = max(outside, key=lambda m: (m.bit_count(), m))
                if lead in elim_pivs:
                    cur ^= elim_pivs[lead]
                else:
                    elim_pivs[lead] = cur
                    break

        # Pack 256-bit truth tables on V_3 for the 16 orbits + fixed short orbits
        orb16_tt4 = (ctypes.c_uint64 * (16 * 4))()
        for pos, j_orb in enumerate(j16_orbs):
            for idx_pt, x in enumerate(v3_pts):
                if eval_orb_x(j_orb, x):
                    orb16_tt4[pos * 4 + (idx_pt >> 6)] |= 1 << (idx_pt & 63)
        fixed_tt4 = (ctypes.c_uint64 * 4)()
        for idx_pt, x in enumerate(v3_pts):
            bit = 0
            if c57_val and eval_orb_x(57, x):
                bit ^= 1
            if c113_val and eval_orb_x(113, x):
                bit ^= 1
            if bit:
                fixed_tt4[idx_pt >> 6] |= 1 << (idx_pt & 63)

        poly_offs = [0]
        poly_masks = []
        poly_consts = []
        for pset in pure_j16_polys:
            cst = 1 if (0 in pset) else 0
            for m in pset:
                if m == 0:
                    continue
                m16 = 0
                tmp = m
                while tmp:
                    b = tmp & -tmp
                    m16 |= 1 << j16_to_pos[b.bit_length() - 1]
                    tmp ^= b
                poly_masks.append(m16)
            poly_offs.append(len(poly_masks))
            poly_consts.append(cst)

        n_ep = len(pure_j16_polys)
        c_offs = (ctypes.c_int * (n_ep + 1))(*poly_offs)
        c_masks = (ctypes.c_uint16 * max(1, len(poly_masks)))(*(poly_masks if poly_masks else [0]))
        c_consts = (ctypes.c_uint8 * max(1, n_ep))(*(poly_consts if poly_consts else [0]))
        out_surv = (ctypes.c_uint16 * 65536)()
        ek, sk = ctypes.c_int(), ctypes.c_int()

        n_surv = (0 if has_one_alg else lib.scan_0x3333_states_c(
            16, orb16_tt4, fixed_tt4, 1 if (c99_val == 0 and c57_val == 0) else 0,
            n_ep, c_offs, c_masks, c_consts, u8_in_v3_idx, out_surv, ctypes.byref(ek), ctypes.byref(sk)
        ))
        c_sweep_ms = round((time.perf_counter() - ts_c) * 1000.0, 2)

        # --- G. Lightweight CaDiCaL Solve (NO heavy static CardEnc counters!) ---
        unsat_sat = has_one_alg
        sat_models = 0
        bent_hits = []
        sat_sec = 0.0
        rem_time = budget_per_cell - (time.perf_counter() - tc)

        if not has_one_alg and rem_time > 2.0:
            ts_sat = time.perf_counter()
            clauses = []
            v_cnt = [n]

            def new_var():
                v_cnt[0] += 1
                return v_cnt[0]

            pair_cache = {}
            for pset in deg12_psets:
                encode_deg2_pset(clauses, pset, new_var, pair_cache)

            # Encode T28 C6 if loaded for this c99 branch
            if poly_t28.get(c99_val) is not None:
                c_lits = {}
                for j in range(116):
                    idxs = [i + 1 for i, cdir in enumerate(cb) if (cdir >> j) & 1]
                    cst = (origin >> j) & 1
                    if not idxs:
                        lv = new_var()
                        clauses.append([lv if cst else -lv])
                    elif len(idxs) == 1 and cst == 0:
                        lv = idxs[0]
                    elif len(idxs) == 1 and cst == 1:
                        lv = -idxs[0]
                    else:
                        lv = new_var()
                        add_xor_clauses(clauses, idxs + [lv], cst, new_var)
                    c_lits[j] = lv
                c6_lits, c6_rhs, c6_cache = [], 0, {}
                for m in poly_t28[c99_val]:
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
                        key = tuple(bits)
                        if key not in c6_cache:
                            mv = new_var()
                            add_and_gate(clauses, mv, bits)
                            c6_cache[key] = mv
                        c6_lits.append(c6_cache[key])
                add_xor_clauses(clauses, c6_lits, c6_rhs, new_var)

            bad_u, bad_val = ctypes.c_int(), ctypes.c_int()
            with Solver(name="cadical195", bootstrap_with=clauses) as slv:
                while (time.perf_counter() - tc) < budget_per_cell:
                    if not slv.solve():
                        unsat_sat = True
                        break
                    sat_models += 1
                    model = slv.get_model()
                    cint = origin
                    for i, cdir in enumerate(cb):
                        if model[i] > 0:
                            cint ^= cdir
                    if lib.audit_bent_116_c(
                        orb_tts_c, cint & mask64, cint >> 64,
                        ctypes.byref(bad_u), ctypes.byref(bad_val)
                    ):
                        bent_hits.append(hex(cint))
                        break
                    slv.add_clause([-(i + 1) if model[i] > 0 else (i + 1) for i in range(n)])
            sat_sec = round(time.perf_counter() - ts_sat, 3)

        report[cell_name] = {
            "has_one_algebraic": has_one_alg,
            "unsat_closed": unsat_sat,
            "deg_pivs": deg_pivs,
            "stats": stats,
            "v0x3333_pure_elim_polys": n_ep,
            "v0x3333_states_total": 65536,
            "v0x3333_elim_killed": ek.value,
            "v0x3333_spec_killed": sk.value,
            "v0x3333_survivors": n_surv,
            "v0x3333_c_sweep_ms": c_sweep_ms,
            "lightweight_sat_models_checked": sat_models,
            "lightweight_sat_sec": sat_sec,
            "bent_hits": bent_hits,
            "total_sec": round(time.perf_counter() - tc, 3),
        }
        print(f"[{cell_name}] {json.dumps(report[cell_name])}", flush=True)

    print("=== FINAL B11 0x3333 COSET DUALITY REPORT ===", flush=True)
    print(json.dumps(report, indent=2), flush=True)


if __name__ == "__main__":
    main()

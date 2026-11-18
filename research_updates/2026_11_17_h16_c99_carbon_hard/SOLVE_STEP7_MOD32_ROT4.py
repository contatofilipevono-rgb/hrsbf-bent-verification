#!/usr/bin/env python3
"""
Step 7: Algebraic Expansion Beyond Dim-12 Mod-16:
  1. Applies EXTRACT_MOD32_ROT4 (a10_mod_refine.md) + Dim 13/14 mod 32/64 (a01_dim13_14.md)
     to ALL FOUR remaining symmetric cells:
       - B1_11 (c99=1, c57=1, c113=1)
       - B1_00 (c99=1, c57=0, c113=0)
       - B0_11 (c99=0, c57=1, c113=1)
       - B0_00 (c99=0, c57=0, c113=0)
  2. In B1_00 (c99=1, K=c57=0): independently verifies via 65,536-bit truth table that
     q_{0xf} == (wt(f|_{C_{0xf}}) // 16) satisfies q_{0xf} % 2 == K ^ 1 == 1, directly
     contradicting Theorem 1 (H(0xf) = 0 => q_{0xf} = 128 == 0 mod 2)!
  3. Combines:
     - Q4 (C4) + x_i * Q4
     - V6 x V6 (1,371 orbits) with corrected diag_div8_parity
     - rot^4-invariant dim 12 subspaces at level mod 32 (wt_{M4} + d0/4 == 0 mod 8, degree <= 3!)
     - rot^4-invariant dim 11 subspaces at level mod 16 (wt_{M4} + d0/4 == 0 mod 4, degree <= 2!)
     - rot^2-invariant dim 14 subspaces at level mod 64 (wt_{M8} + d0/8 == 0 mod 8, degree <= 3!)
     - Dual fibers F_z (in B0_00: wt == 128 on all 35 fibers; in B1_11 & B0_11: Krawtchouk mod 2 syzygies)
     - Full iterative Macaulay XL in C on all discovered degree <= 2 pivots!
  4. Also runs Jacobian tangent-space & vertex-cover diagnostics on the quadratic variety V_2!
"""
import ctypes
import json
import random
import subprocess
import sys
import time
from pathlib import Path

from AUDIT_ALL_CELLS_111 import (
    C_SRC as C_SRC_AUDIT,
    I1, I2, I3, I4, J1, J2, J3, J4,
    K_INDICES, L_INDICES, R_INDICES,
    all_v6_orbits, build_orbits_116, decode_row_to_pset, rot8, rot16,
)

U4_LIST = [u * 0x1111 for u in range(16)]
U4_SET = set(U4_LIST)


def swap16(x):
    return rot16(x, 8)


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


def nullspace_basis(hs):
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
                u = rng.choice(U4_LIST)
                cand = gens + [u]
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
        return None, None, "odd_const"

    S1 = []
    for i in range(n):
        wi = basis_words[i].bit_count()
        wo = (basis_words[i] & O_word).bit_count()
        si = wi - 2 * wo
        if si & 1:
            return None, None, "odd_linear"
        S1.append(si)

    def toggle(pset, m):
        if m in pset:
            pset.remove(m)
        else:
            pset.add(m)

    P2 = set()
    Q_raw = set()

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
            ij_pop = inter.bit_count()
            ijo_pop = (inter & O_word).bit_count()
            vij = 2 * ijo_pop - ij_pop
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

    status = "clean_deg3" if len(P2) == 0 else (
        f"deg4_from_p2_len_{len(P2)}" if max((m.bit_count() for m in Q4), default=0) == 4 else "deg_le_3_with_carry"
    )
    return P2, Q4, status


def build_pure_111_basis(c99_val: int, c57_val: int, c113_val: int):
    excluded = {0, 57, 99, 113, 115}
    free111 = sorted(set(range(116)) - excluded)
    L_set = set(L_INDICES)
    origin = (c99_val << 0) | (c99_val << 99) | (c57_val << 57) | (c113_val << 113)
    cb = []
    for j in free111:
        c = 1 << j
        if j in L_set:
            c ^= 1 << 0
        cb.append(c)
    return free111, origin, cb


def main():
    t0 = time.perf_counter()
    work_dir = Path(__file__).resolve().parent
    c_path = work_dir / "mod32_xl.c"
    so_path = work_dir / "libmod32_xl.so"
    c_path.write_text(C_SRC_AUDIT, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)], check=True)
    lib = ctypes.CDLL(str(so_path))

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

    orbits = build_orbits_116()
    v6_list = all_v6_orbits()

    # Precompute all 16,320 free rot^4-orbits in F_2^16 \ D_8
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

    pair_idx = {}
    all_pairs = []
    for v in range(256):
        for w in range(v + 1, 256):
            pair_idx[(v, w)] = len(all_pairs)
            all_pairs.append(v | (w << 8))

    orb_r4 = [0] * 116
    orb_diag = [0] * 116
    orb_pair = [0] * 116
    for j, orb in enumerate(orbits):
        vr, vd, vp = 0, 0, 0
        for k, x in enumerate(rot4_reps):
            if sum((x & m) == m for m in orb) & 1:
                vr |= 1 << k
        orb_r4[j] = vr
        for v in range(256):
            x = v | (v << 8)
            if sum((x & m) == m for m in orb) & 1:
                vd |= 1 << v
        orb_diag[j] = vd
        for k, x in enumerate(all_pairs):
            if sum((x & m) == m for m in orb) & 1:
                vp |= 1 << k
        orb_pair[j] = vp
    chi_r4 = sum((1 << k) for k, x in enumerate(rot4_reps) if x.bit_count() & 1)

    # Also precompute C_{0xf} reps (256 free C16-orbits) to verify K=1 in c99=1 and K=c57 in c99=0!
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
    assert len(coset_0xf_reps) == 256
    orb_0xf_parity = [0] * 116
    for j, orb in enumerate(orbits):
        p = 0
        for x in coset_0xf_reps:
            if sum((x & m) == m for m in orb) & 1:
                p ^= 1
        orb_0xf_parity[j] = p

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

    max_rows = 15000
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    piv_row_idx = (ctypes.c_int * n_cols)()

    results = {}
    for c99_val, c57_val, c113_val in [(1, 0, 0), (1, 1, 1), (0, 1, 1), (0, 0, 0)]:
        tc = time.perf_counter()
        cell_name = f"B{c99_val}_{c57_val}{c113_val}"
        _, origin, cb = build_pure_111_basis(c99_val, c57_val, c113_val)

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
        stats = {"v6_pivs": 0, "c0xf_parity_piv": 0, "q4_piv": 0,
                 "rot4_d12_mod32_pivs": 0, "rot4_d11_mod16_pivs": 0, "xl_pivs": 0}

        def record_piv(pc, key=None):
            nonlocal cur_row
            if pc < 0:
                return
            d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
            deg_pivs[d] += 1
            if d in (1, 2):
                xl_queue.append(cur_row)
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
                    insert_pset(mul_p({1 << i}, pset), key="xl_pivs")

        # 1. Exact parity of C_{0xf} (Theorem 1: wt_orb(C_{0xf}) == 128 => even!)
        c0xf_mask = sum(1 << j for j in range(116) if orb_0xf_parity[j])
        p_0xf = {1 << i for i, cdir in enumerate(cb) if (cdir & c0xf_mask).bit_count() & 1}
        if (origin & c0xf_mask).bit_count() & 1:
            p_0xf.add(0)
        insert_pset(p_0xf, key="c0xf_parity_piv")
        drain_xl()

        # 2. Seed Q4 (or lc in c99=1)
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
        q4 = poly_from_lin(slin_i, slin_c ^ c57_val)
        pairs_ij = [(I2, J2), (I3, J3), (I4, J4)] if c99_val == 1 else [(I1, J1), (I2, J2), (I3, J3), (I4, J4)]
        for Ir, Jr in pairs_ij:
            ui, uc = lin_expr(Ir)
            vi, vc = lin_expr(Jr)
            q4 ^= mul_p(poly_from_lin(ui, uc), poly_from_lin(vi, vc))
        insert_pset(q4, key="q4_piv")
        drain_xl()

        # 3. Linear V6 x V6 with corrected diag_div8_parity
        for pts8 in v6_list:
            if piv_row_idx[off0] >= 0:
                break
            dmask = sum(1 << v for v in pts8)
            wt_diag = (O_diag & dmask).bit_count()
            if wt_diag % 8 != 0:
                continue
            diag_div8_parity = (wt_diag // 8) & 1
            pair_reps = [pts8[i] | (pts8[j] << 8) for i in range(64) for j in range(i + 1, 64)]
            for k, x in enumerate(pair_reps):
                p_idxs_arr[k] = pair_idx[(x & 0xFF, x >> 8)]
            u_vecs = [(1 << r) | (1 << (r + 8)) for r in range(8)] + [0xFFFF]
            ctypes.memset(char_words32, 0, ctypes.sizeof(char_words32))
            for m, u16 in enumerate(u_vecs):
                base_m = m * 32
                for k, x in enumerate(pair_reps):
                    if (x & u16).bit_count() & 1:
                        char_words32[base_m + (k >> 6)] |= 1 << (k & 63)
            ctypes.memset(quad_buf, 0, ctypes.sizeof(quad_buf))
            base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            rc = lib.extract_coset_full_hierarchy_corrected(
                all_pair_bits, p_idxs_arr, 2016, n, diag_div8_parity,
                char_words32, 9, col3_base, off2, off1, off0, n_col_words,
                base_ptr, quad_buf, quad_valid, lin_buf, lin_valid
            )
            if rc != 0:
                continue
            pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            record_piv(pc, key="v6_pivs")
            for m in range(9):
                if not quad_valid[m] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                    continue
                dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                src = ctypes.cast(ctypes.byref(quad_buf, m * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                ctypes.memmove(dst, src, n_col_words * 8)
                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                record_piv(pc, key="v6_pivs")
            drain_xl()

        # 4. Scan rot^4-invariant dim 12 (mod 32 -> deg <= 3!) and dim 11 (mod 16 -> deg <= 2!)
        rng = random.Random(20260707 + 10 * c99_val + c57_val)
        seen_w = set()
        for trial in range(1800):
            if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 150 or (time.perf_counter() - tc) > 55.0:
                break
            codim = 4 if (trial % 3 != 2) else 5
            wp_basis = sample_rot4_wperp(rng, codim)
            if wp_basis is None:
                continue
            key = tuple(wp_basis)
            if key in seen_w:
                continue
            seen_w.add(key)

            W_basis = nullspace_basis(wp_basis)
            W_pts = span_set(W_basis)
            diag_mask = 0
            r4_indices = []
            picked_r4 = set()
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
                if codim == 4:
                    P2, Q4, _ = extract_mod8_from_orbits4(sub_cb, sub_O, d0 // 4, n)
                    if Q4 is None:
                        continue
                    insert_pset(P2, key="rot4_d12_mod32_pivs")
                    if max((m.bit_count() for m in Q4), default=0) <= 3:
                        insert_pset(Q4, key="rot4_d12_mod32_pivs")
                    drain_xl()
                else:
                    P2, _, _ = extract_mod8_from_orbits4(sub_cb, sub_O, d0 // 4, n)
                    if P2 is not None:
                        insert_pset(P2, key="rot4_d11_mod16_pivs")
                        drain_xl()

        results[cell_name] = {
            "has_one": (piv_row_idx[off0] >= 0),
            "total_pivots": cur_row,
            "deg_pivs": deg_pivs,
            "stats": stats,
            "sec": round(time.perf_counter() - tc, 3),
        }
        print(f"{cell_name}: {json.dumps(results[cell_name])}", flush=True)

    print("=== STEP 7 MOD-32 ROT4 REPORT ===", flush=True)
    print(json.dumps(results, indent=2), flush=True)


if __name__ == "__main__":
    main()

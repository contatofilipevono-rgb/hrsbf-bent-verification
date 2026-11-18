#!/usr/bin/env python3
"""
Step 3: Master Closer for B0_00 (c57=0) and B0_11 (c57=1) (and any other open cell)
combining ALL proven algebraic & primal-dual discoveries from the 12 Carbon analyses:
  1. Corrected Affine Cosets (a + W, u) hierarchy (a02_affine_cosets.md):
     - Strictly enforces (o_pop % 4 == 0) and diag_div8_parity = (wt_diag // 8) & 1.
     - Level-1 quadratic equation (wt_pairs // 2) % 2 == 1 whenever wt_diag % 8 == 4!
     - First differences Q^(r)_{a+W} = P_0 ^ P_{(e_r,e_r)} (degree <= 2)
     - Second differences L^(r,s)_{a+W} (degree <= 1)
     - Regime II diagonal-free cosets (a + W) cap D_8 == empty with asymmetric characters!
  2. Closed Primal-Dual (f, f~|_{U_8}) Fiber Equations on all 35 C_8-orbits F_z (a03_dual_bent.md):
     - B0_00: Theorem A1 proves f~|_{U_8} == 0 identically => wt(f|_{F_z}) == 128 on all 35 fibers!
       * F_{0xff}: 16 C_16-orbits -> exact weight 8 of 16 (e_1 = 0, e_2 = 0)!
       * F_{0x55}: 32 <rot^2>-orbits -> exact weight 16 of 32 (e_1 = 0, e_2 = 0)!
       * F_{0x11,0x33,0x77}: 64 <rot^4>-orbits -> exact weight 32 of 64 (e_1 = 0, e_2 = 0)!
       * 30 generic fibers: 128 <rot^8>-pairs -> exact weight 64 of 128 (e_1 = 0, e_2 = 0)!
     - B0_11: Theorem B couples the 35 fibers F_z to the 31 dual bits (s_0, s_1..s_30) via Krawtchouk matrix K_{z,m}:
       * Left-nullspace of (K_{z,m}/2 mod 2) yields pure linear equations in c!
       * Exact coupled SAT constraints: 2*s_0 + sum s_m == 8, s_{0x01}^s_{0x05}^s_{0x15}^s_0 == 0,
         F_{0xff} (16 + 15 bits == 12), C_{0x0}\D_8 (q_0 + 8*(1-s_0) == 124), and U_4 fiber PB equations!
  3. Lazy Cubic Pivot Injection + Exact Small Coset Counters (C_{0xf}=128, C_{0x0}, F_z) + C FWHT in CaDiCaL 1.9.5!
"""
import ctypes
import json
import random
import subprocess
import sys
import time
from pathlib import Path

from pysat.card import CardEnc, EncType
from pysat.pb import PBEnc, EncType as PBEncType
from pysat.solvers import Solver

from AUDIT_ALL_CELLS_111 import C_SRC as C_SRC_AUDIT, interleave16, rot8, rot16
from SOLVE_C99_0_CLOSE import C_FWHT_SRC
from SOLVE_C99_0_SAT_QUAD import add_and_gate, add_long_xor, encode_poly_zero_vars
from SOLVE_C99_0_STEP4B import I1, J1, build_basis_c99_0_k
from SOLVE_C99_0_STEP4C import decode_row_to_pset
from SOLVE_C99_0_STEP4D import gen_v4_list
from SOLVE_C99_1_POISSON_C import I2, I3, I4, J2, J3, J4, all_v6_orbits
from VERIFICAR_ALGEBRA_C99_1 import setup_orbits


def swap16(h):
    return ((h & 0xFF) << 8) | (h >> 8)


def rref_16(hs):
    rows = []
    for h in hs:
        x = h
        for r in rows:
            pb = r.bit_length() - 1
            if (x >> pb) & 1:
                x ^= r
        if x:
            rows.append(x)
            rows.sort(reverse=True)
    for i in range(len(rows)):
        pb = rows[i].bit_length() - 1
        for j in range(len(rows)):
            if i != j and ((rows[j] >> pb) & 1):
                rows[j] ^= rows[i]
    return tuple(rows)


def nullspace_16(rref_rows):
    pivs = {r.bit_length() - 1: r for r in rref_rows}
    basis = []
    for f in range(16):
        if f in pivs:
            continue
        v = 1 << f
        for pb, r in pivs.items():
            if (r >> f) & 1:
                v |= 1 << pb
        basis.append(v)
    pts = [0]
    for b in basis:
        pts += [p ^ b for p in pts]
    return pts


def build_c8_orbits():
    seen = set()
    u4_orbs, u8_size8, nonzero_z = [], [], []
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
        if len(orb) < 8:
            u4_orbs.append((rep, orb))
        else:
            u8_size8.append((rep, orb))
    return u4_orbs, u8_size8, nonzero_z


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
            val = (ci_wt * cj.bit_count() - (ci & cj).bit_count()) & 1
            if val:
                toggle((1 << i) | (1 << j))
    return pset


def solve_master_cell(c57_val: int, budget_sec: float = 360.0):
    t0 = time.perf_counter()
    work_dir = Path(__file__).resolve().parent
    repo = Path(__file__).resolve().parents[2]
    cert_t28 = json.loads((repo / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json").read_text(encoding="utf-8"))
    poly_t28_b0 = [int(h, 16) for h in cert_t28["reduced_models"]["branches"][0]["polynomial_hex"]]

    c_path = work_dir / f"master_xl_{c57_val}.c"
    so_path = work_dir / f"libmaster_xl_{c57_val}.so"
    c_path.write_text(C_SRC_AUDIT, encoding="utf-8")
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

    fwht_c = work_dir / f"master_fwht_{c57_val}.c"
    fwht_so = work_dir / f"libmaster_fwht_{c57_val}.so"
    fwht_c.write_text(C_FWHT_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(fwht_c), "-o", str(fwht_so)], check=True)
    lib_fwht = ctypes.CDLL(str(fwht_so))
    lib_fwht.audit_bent_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_uint64, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
    ]
    lib_fwht.audit_bent_c.restype = ctypes.c_int

    orbits = setup_orbits()
    orb_tts = (ctypes.c_uint64 * (116 * 1024))()
    for j, orb in enumerate(orbits):
        base = j * 1024
        for m in orb:
            for x in range(65536):
                if (x & m) == m:
                    orb_tts[base + (x >> 6)] ^= 1 << (x & 63)

    def eval_orb_at_x(j, x):
        return (orb_tts[j * 1024 + (x >> 6)] >> (x & 63)) & 1

    # NOTE on C7 in c99=0: Build pure 110-variable basis with ONLY c115=0, L=0, K=c57 (NO R=0 assumed!)
    # Let Poisson-Lucas & Dual Fibers discover ALL linear laws automatically!
    from VERIFICAR_ALGEBRA_C99_1 import K_INDICES, L_INDICES
    excluded = {0, 57, 99, 113, 115}
    free111 = sorted(set(range(116)) - excluded)
    L_set = set(L_INDICES)
    origin = (c57_val << 57) | (c57_val << 113)
    cb111 = []
    for j in free111:
        c = 1 << j
        if j in L_set:
            c ^= 1 << 0
        cb111.append(c)
    k_mask = sum(1 << j for j in K_INDICES)
    k_const = (origin & k_mask).bit_count() & 1
    piv_i = next(i for i, c in enumerate(cb111) if (c & k_mask).bit_count() & 1)
    c_piv = cb111[piv_i]
    origin_k = origin ^ (c_piv if (k_const ^ c57_val) else 0)
    cb_k = [c ^ (c_piv if ((c & k_mask).bit_count() & 1) else 0) for i, c in enumerate(cb111) if i != piv_i]
    n = len(cb_k)  # 110 free variables (zero assumption on R vs R^M!)
    assert n == 110

    u4_orbs, u8_size8, nonzero_z = build_c8_orbits()
    s_rep_to_idx = {r: idx for idx, (r, _) in enumerate(u8_size8)}

    K_mat, M_mod2_rows = [], []
    for z_rep, _ in nonzero_z:
        row_k = []
        m_bits = 0
        for m, (_, a_orb) in enumerate(u8_size8):
            s_val = sum(-1 if ((a & z_rep).bit_count() & 1) else 1 for a in a_orb)
            row_k.append(s_val)
            if (s_val // 2) & 1:
                m_bits |= 1 << m
        K_mat.append(row_k)
        M_mod2_rows.append(m_bits)

    null_z_vecs = gf2_nullspace_left(M_mod2_rows)

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

    max_rows = 16000
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    piv_row_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
    cur_row = 0
    deg_pivs = {0: 0, 1: 0, 2: 0, 3: 0}
    xl_queue = []
    deg12_rows = []
    cub_rows = []

    def record_piv(pc):
        nonlocal cur_row
        if pc < 0:
            return
        d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
        deg_pivs[d] += 1
        if d in (1, 2):
            xl_queue.append(cur_row)
            deg12_rows.append(cur_row)
        elif d == 3:
            cub_rows.append(cur_row)
        cur_row += 1

    def insert_pset(pset):
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
        record_piv(pc)
        return pc

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

    def drain_xl():
        while xl_queue and piv_row_idx[off0] < 0 and cur_row < max_rows - n - 20:
            r_idx = xl_queue.pop(0)
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
            for i in range(n):
                if cur_row >= max_rows - 5 or piv_row_idx[off0] >= 0:
                    break
                insert_pset(mul_p({1 << i}, pset))

    def eval_x_form(x_pt):
        orb_vec = 0
        for j in range(116):
            if eval_orb_at_x(j, x_pt):
                orb_vec |= 1 << j
        o_bit = (origin_k & orb_vec).bit_count() & 1
        w_mask = 0
        for i, cdir in enumerate(cb_k):
            if (cdir & orb_vec).bit_count() & 1:
                w_mask |= 1 << i
        return w_mask, o_bit

    # 1. Seed Q4 + XL
    def lin_expr(indices):
        mask = sum(1 << j for j in indices)
        idxs = [i for i, c in enumerate(cb_k) if (c & mask).bit_count() & 1]
        return idxs, (origin_k & mask).bit_count() & 1

    def poly_from_lin(idxs, const):
        p = {1 << i for i in idxs}
        if const:
            p.add(0)
        return p

    slin_i, slin_c = lin_expr([23, 31, 39, 112])
    q4 = poly_from_lin(slin_i, slin_c ^ c57_val)
    for Ir, Jr in [(I1, J1), (I2, J2), (I3, J3), (I4, J4)]:
        ui, uc = lin_expr(Ir)
        vi, vc = lin_expr(Jr)
        q4 ^= mul_p(poly_from_lin(ui, uc), poly_from_lin(vi, vc))
    insert_pset(q4)
    drain_xl()

    # 2. Extract Dual Fiber equations on all 35 fibers F_z!
    fiber_forms = {}
    for z_rep, _ in nonzero_z:
        if z_rep == 0xFF:
            gstep = 1
        elif z_rep in (0x55, 0xAA):
            gstep = 2
        elif z_rep in (0x11, 0x33, 0x77):
            gstep = 4
        else:
            gstep = 8
        reps = fiber_orbit_reps(z_rep, gstep)
        forms = [eval_x_form(x) for x in reps]
        fiber_forms[z_rep] = (gstep, forms)

        if c57_val == 0:
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

    if c57_val == 1:
        pair_forms_35 = []
        for z_rep, _ in nonzero_z:
            reps128 = fiber_orbit_reps(z_rep, 8)
            pair_forms_35.append([eval_x_form(x) for x in reps128])
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

    # 3. Extract Affine Cosets (a + W, u) hierarchy + V6 + V4 + Regime II diagonal-free cosets!
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

    O_diag, O_pair = 0, 0
    for j in range(116):
        if (origin_k >> j) & 1:
            O_diag ^= orb_diag[j]
            O_pair ^= orb_pair[j]
    cb_pair = []
    for cdir in cb_k:
        vp = 0
        for j in range(116):
            if (cdir >> j) & 1:
                vp ^= orb_pair[j]
        cb_pair.append(vp)

    mask64 = (1 << 64) - 1
    all_pair_bits = (ctypes.c_uint64 * ((n + 1) * 510))()
    for i in range(n):
        for w in range(510):
            all_pair_bits[i * 510 + w] = (cb_pair[i] >> (64 * w)) & mask64
    for w in range(510):
        all_pair_bits[n * 510 + w] = (O_pair >> (64 * w)) & mask64

    MAX_CHARS = 12
    MAX_C_PAIRS = MAX_CHARS * (MAX_CHARS - 1) // 2
    p_idxs_arr = (ctypes.c_int * 2048)()
    char_words32 = (ctypes.c_uint64 * (MAX_CHARS * 32))()
    quad_buf = (ctypes.c_uint64 * (MAX_CHARS * n_col_words))()
    quad_valid = (ctypes.c_int * MAX_CHARS)()
    lin_buf = (ctypes.c_uint64 * (MAX_C_PAIRS * n_col_words))()
    lin_valid = (ctypes.c_int * MAX_C_PAIRS)()

    def process_coset(pts_16, asym_u_list=()):
        if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 100:
            return
        diag_pts = [x & 0xFF for x in pts_16 if (x & 0xFF) == (x >> 8)]
        pair_reps = [x for x in pts_16 if (x & 0xFF) < (x >> 8)]
        n_pairs = len(pair_reps)

        dmask = 0
        for v in diag_pts:
            dmask |= 1 << v
        wt_diag = (O_diag & dmask).bit_count()

        for k, x in enumerate(pair_reps):
            p_idxs_arr[k] = pair_idx[(x & 0xFF, x >> 8)]

        u_vecs = [(1 << r) | (1 << (r + 8)) for r in range(8)] + [0xFFFF]
        if not diag_pts:
            for u_asym in asym_u_list[: (MAX_CHARS - 9)]:
                u_vecs.append(u_asym)
        n_chars = len(u_vecs)

        ctypes.memset(char_words32, 0, ctypes.sizeof(char_words32))
        for m, u16 in enumerate(u_vecs):
            base_m = m * 32
            for k, x in enumerate(pair_reps):
                if (x & u16).bit_count() & 1:
                    char_words32[base_m + (k >> 6)] |= 1 << (k & 63)

        if wt_diag % 8 == 4:
            base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            if lib.extract_level1_quad_when_diag4(
                all_pair_bits, p_idxs_arr, n_pairs, n, None,
                off2, off1, off0, n_col_words, base_ptr
            ) == 0:
                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                record_piv(pc)
            for m in range(n_chars):
                if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 20:
                    break
                um_ptr = ctypes.cast(ctypes.byref(char_words32, m * 32 * 8), ctypes.POINTER(ctypes.c_uint64))
                base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                if lib.extract_level1_quad_when_diag4(
                    all_pair_bits, p_idxs_arr, n_pairs, n, um_ptr,
                    off2, off1, off0, n_col_words, base_ptr
                ) == 0:
                    pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                    record_piv(pc)
            drain_xl()
            return

        if wt_diag % 8 != 0:
            return
        diag_div8_parity = (wt_diag // 8) & 1

        ctypes.memset(quad_buf, 0, ctypes.sizeof(quad_buf))
        base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
        rc = lib.extract_coset_full_hierarchy_corrected(
            all_pair_bits, p_idxs_arr, n_pairs, n, diag_div8_parity,
            char_words32, n_chars, col3_base, off2, off1, off0, n_col_words,
            base_ptr, quad_buf, quad_valid, lin_buf, lin_valid,
        )
        if rc != 0:
            return

        pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
        record_piv(pc)

        n_cp = n_chars * (n_chars - 1) // 2
        for pm in range(n_cp):
            if not lin_valid[pm] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                continue
            dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(lin_buf, pm * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_col_words * 8)
            pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            record_piv(pc)

        for m in range(n_chars):
            if not quad_valid[m] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                continue
            dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(quad_buf, m * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_col_words * 8)
            pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            record_piv(pc)

        drain_xl()

    v6_list = all_v6_orbits()
    for pts8 in v6_list:
        if time.perf_counter() - t0 > budget_sec * 0.25 or piv_row_idx[off0] >= 0:
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
            process_coset([x ^ a16 for x in w_pts])
            process_coset([interleave16(x ^ a16) for x in w_pts])

    # Regime II diagonal-free cosets + V4 cosets
    rng = random.Random(202611 + c57_val)
    seen_w = set()
    while time.perf_counter() - t0 < budget_sec * 0.40 and piv_row_idx[off0] < 0 and cur_row < max_rows - 150:
        mode = rng.choice(("free1sym2", "sym4"))
        if mode == "free1sym2":
            h1 = rng.randint(1, 65535)
            s1, s2 = rng.randint(1, 255), rng.randint(1, 255)
            hs = [h1, swap16(h1), s1 | (s1 << 8), s2 | (s2 << 8)]
            sym_hs = [s1, s2, s1 ^ s2]
            cond_vec = (h1 & 0xFF) ^ (h1 >> 8)
        else:
            s_list = [rng.randint(1, 255) for _ in range(4)]
            hs = [s | (s << 8) for s in s_list]
            sym_hs = s_list
            cond_vec = 0
        rref = rref_16(hs)
        if len(rref) != 4 or rref in seen_w:
            continue
        seen_w.add(rref)
        w_pts = nullspace_16(rref)
        process_coset(w_pts)
        valid_deltas = [
            da for da in range(1, 256)
            if ((da & cond_vec).bit_count() & 1) == 0 and ((da & sym_hs[0]).bit_count() & 1) == 1
        ]
        rng.shuffle(valid_deltas)
        for da in valid_deltas[:2]:
            asym_u = [du for du in sym_hs if du != 0 and ((du & da).bit_count() & 1) == 0]
            process_coset([x ^ da for x in w_pts], asym_u_list=asym_u)
            if piv_row_idx[off0] >= 0:
                break

    print(f"[B0_{c57_val}{c57_val}] Algebraic phase done in {time.perf_counter()-t0:.2f}s: "
          f"has_one={piv_row_idx[off0]>=0}, deg_pivs={deg_pivs}", flush=True)

    if piv_row_idx[off0] >= 0:
        return {
            "cell": f"B0_{c57_val}{c57_val}",
            "algebraic_unsat_has_one": True,
            "unsat_closed": True,
            "total_pivots": cur_row,
            "deg_pivs": deg_pivs,
            "elapsed_sec": round(time.perf_counter() - t0, 3),
        }

    # Decode cubic pivots for fast lazy CEGAR evaluation!
    cubic_psets = []
    for r_idx in cub_rows:
        row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
        pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
        if len(pset) <= 500:
            cubic_psets.append(pset)
    cubic_psets.sort(key=len)

    # 4. Build Closed Primal-Dual SAT Instance!
    clauses = []
    v_cnt = [n]

    def new_var():
        v_cnt[0] += 1
        return v_cnt[0]

    def make_lin_lit(wm, ob):
        idxs = [i + 1 for i in range(n) if (wm >> i) & 1]
        if not idxs:
            v = new_var()
            clauses.append([v if ob else -v])
            return v
        if len(idxs) == 1 and ob == 0:
            return idxs[0]
        if len(idxs) == 1 and ob == 1:
            return -idxs[0]
        lv = new_var()
        add_long_xor(clauses, idxs + [lv], ob, new_var)
        return lv

    pair_cache = {}
    for r_idx in deg12_rows:
        row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
        pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
        encode_poly_zero_vars(clauses, pset, new_var, pair_cache)

    c_lits = {}
    long_lits = []
    for j in range(116):
        idxs = [i + 1 for i, c in enumerate(cb_k) if (c >> j) & 1]
        const = (origin_k >> j) & 1
        if len(idxs) == 1 and const == 0:
            lv = idxs[0]
        elif len(idxs) == 0:
            lv = new_var()
            clauses.append([lv if const else -lv])
        else:
            lv = new_var()
            add_long_xor(clauses, idxs + [lv], const, new_var)
        c_lits[j] = lv
        if j not in (57, 99, 113, 115):
            long_lits.append(lv)

    for bound, fn in [(6, CardEnc.atleast), (106, CardEnc.atmost)]:
        enc = fn(lits=long_lits, bound=bound, top_id=v_cnt[0], encoding=EncType.seqcounter)
        v_cnt[0] = max(v_cnt[0], enc.nv)
        clauses.extend(enc.clauses)

    coset_0xf_reps, coset_0x0_reps = [], []
    visited = bytearray(65536)
    for x in range(65536):
        if visited[x]:
            continue
        cur, mem = x, []
        while not visited[cur]:
            visited[cur] = 1
            mem.append(cur)
            cur = rot16(cur)
        if len(mem) == 16:
            vnib = (x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)
            if vnib == 0xF:
                coset_0xf_reps.append(mem[0])
            elif vnib == 0x0:
                coset_0x0_reps.append(mem[0])

    lits_0xf = [make_lin_lit(*eval_x_form(x)) for x in coset_0xf_reps]
    enc_0xf = CardEnc.equals(lits=lits_0xf, bound=128, top_id=v_cnt[0], encoding=EncType.totalizer)
    v_cnt[0] = max(v_cnt[0], enc_0xf.nv)
    clauses.extend(enc_0xf.clauses)

    lits_0x0 = [make_lin_lit(*eval_x_form(x)) for x in coset_0x0_reps]

    if c57_val == 0:
        enc_0x0 = CardEnc.equals(lits=lits_0x0, bound=120, top_id=v_cnt[0], encoding=EncType.totalizer)
        v_cnt[0] = max(v_cnt[0], enc_0x0.nv)
        clauses.extend(enc_0x0.clauses)

        for z_rep in [0xFF, 0x55, 0x11, 0x33, 0x77, 0x01, 0x03, 0x05, 0x07, 0x09, 0x0F, 0x15]:
            _, forms = fiber_forms[z_rep]
            flits = [make_lin_lit(wm, ob) for wm, ob in forms]
            enc_f = CardEnc.equals(lits=flits, bound=len(flits) // 2, top_id=v_cnt[0], encoding=EncType.totalizer)
            v_cnt[0] = max(v_cnt[0], enc_f.nv)
            clauses.extend(enc_f.clauses)
    else:
        s0_var = new_var()
        s_vars = [new_var() for _ in range(30)]

        pb_s = PBEnc.equals(lits=[s0_var] + s_vars, weights=[2] + [1] * 30, bound=8,
                            top_id=v_cnt[0], encoding=PBEncType.bdd)
        v_cnt[0] = max(v_cnt[0], pb_s.nv)
        clauses.extend(pb_s.clauses)

        add_long_xor(clauses, [
            s_vars[s_rep_to_idx[0x01]],
            s_vars[s_rep_to_idx[0x05]],
            s_vars[s_rep_to_idx[0x15]],
            s0_var,
        ], 0, new_var)

        pb_q0 = PBEnc.equals(lits=lits_0x0 + [-s0_var], weights=[1] * 240 + [8], bound=124,
                             top_id=v_cnt[0], encoding=PBEncType.bdd)
        v_cnt[0] = max(v_cnt[0], pb_q0.nv)
        clauses.extend(pb_q0.clauses)

        _, forms_ff = fiber_forms[0xFF]
        flits_ff = [make_lin_lit(wm, ob) for wm, ob in forms_ff]
        odd_s = [s_vars[m] for m, (r, _) in enumerate(u8_size8) if r.bit_count() & 1]
        enc_ff = CardEnc.equals(lits=flits_ff + odd_s, bound=12, top_id=v_cnt[0], encoding=EncType.totalizer)
        v_cnt[0] = max(v_cnt[0], enc_ff.nv)
        clauses.extend(enc_ff.clauses)

        for z_idx, (z_rep, _) in enumerate(nonzero_z):
            reps128 = fiber_orbit_reps(z_rep, 8)
            w_xor, o_xor = 0, 0
            for x in reps128:
                wm, ob = eval_x_form(x)
                w_xor ^= wm
                o_xor ^= ob
            xor_lits = [i + 1 for i in range(n) if (w_xor >> i) & 1]
            for m in range(30):
                if (M_mod2_rows[z_idx] >> m) & 1:
                    xor_lits.append(s_vars[m])
            add_long_xor(clauses, xor_lits, o_xor, new_var)

            if z_rep in (0x55, 0x11, 0x33, 0x77):
                gstep, forms = fiber_forms[z_rep]
                div_f = 16 // gstep
                if all(K_mat[z_idx][m] % div_f == 0 for m in range(30)):
                    flits = [make_lin_lit(wm, ob) for wm, ob in forms]
                    pb_lits = list(flits) + [-s0_var]
                    pb_wts = [1] * len(flits) + [16 // div_f]
                    rhs = 128 // div_f + (16 // div_f)
                    for m in range(30):
                        kw = K_mat[z_idx][m] // div_f
                        if kw > 0:
                            pb_lits.append(-s_vars[m])
                            pb_wts.append(kw)
                            rhs += kw
                        elif kw < 0:
                            pb_lits.append(s_vars[m])
                            pb_wts.append(-kw)
                    pb_f = PBEnc.equals(lits=pb_lits, weights=pb_wts, bound=rhs,
                                        top_id=v_cnt[0], encoding=PBEncType.bdd)
                    v_cnt[0] = max(v_cnt[0], pb_f.nv)
                    clauses.extend(pb_f.clauses)

    # Encode C6 (T28 branch 0)
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
            key = tuple(bits)
            if key not in c6_cache:
                mv = new_var()
                add_and_gate(clauses, mv, bits)
                c6_cache[key] = mv
            c6_lits.append(c6_cache[key])
    add_long_xor(clauses, c6_lits, c6_rhs, new_var)

    # 5. Solve with CaDiCaL + Lazy Cubic Pivot Injection + FWHT Audit!
    ts = time.perf_counter()
    models_checked = 0
    cubic_cuts_added = 0
    fwht_calls = 0
    bent_hits = []
    unsat_closed = False
    injected_cubics = set()
    w0, we0, fb, fv = ctypes.c_int(), ctypes.c_int(), ctypes.c_int(), ctypes.c_int()

    with Solver(name="cadical195", bootstrap_with=clauses) as slv:
        while (time.perf_counter() - t0) < budget_sec:
            if not slv.solve():
                unsat_closed = True
                break
            models_checked += 1
            model = slv.get_model()
            x_bits = 0
            cint = origin_k
            for i, cdir in enumerate(cb_k):
                if model[i] > 0:
                    x_bits |= 1 << i
                    cint ^= cdir

            added_now = 0
            for c_idx, pset in enumerate(cubic_psets):
                if c_idx in injected_cubics:
                    continue
                val = 0
                for m in pset:
                    if (x_bits & m) == m:
                        val ^= 1
                if val == 1:
                    new_cls = []
                    encode_poly_zero_vars(new_cls, pset, new_var, pair_cache)
                    for cl in new_cls:
                        slv.add_clause(cl)
                    injected_cubics.add(c_idx)
                    cubic_cuts_added += 1
                    added_now += 1
                    if added_now >= 24:
                        break
            if added_now > 0:
                continue

            fwht_calls += 1
            is_bent = lib_fwht.audit_bent_c(
                orb_tts, cint & mask64, cint >> 64,
                ctypes.byref(w0), ctypes.byref(we0), ctypes.byref(fb), ctypes.byref(fv)
            )
            if is_bent:
                bent_hits.append({"coefficients_hex": hex(cint)})
                break
            slv.add_clause([-(i + 1) if model[i] > 0 else (i + 1) for i in range(n)])

    return {
        "cell": f"B0_{c57_val}{c57_val}",
        "algebraic_unsat_has_one": False,
        "unsat_closed": unsat_closed,
        "deg_pivs": deg_pivs,
        "deg12_pivots": len(deg12_rows),
        "cubic_pivots_pool": len(cubic_psets),
        "cubic_cuts_injected": cubic_cuts_added,
        "models_checked": models_checked,
        "fwht_calls": fwht_calls,
        "bent_hits": bent_hits,
        "sat_sec": round(time.perf_counter() - ts, 3),
        "total_sec": round(time.perf_counter() - t0, 3),
    }


if __name__ == "__main__":
    cell_arg = int(sys.argv[1]) if len(sys.argv) > 1 else 0
    bud = float(sys.argv[2]) if len(sys.argv) > 2 else 360.0
    res = solve_master_cell(cell_arg, budget_sec=bud)
    print("=== MASTER CLOSE REPORT ===", flush=True)
    print(json.dumps(res, indent=2), flush=True)

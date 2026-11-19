#!/usr/bin/env python3
r"""
SOLVE_STEP25_AUTOCORR_2ADIC_ON_ETA64_AND_V13_SYZYGY.py

EXPLOITS THE UNTAPPED 2-ADIC AUTOCORRELATION A_f((r, r)) = 0 THEOREM ACROSS ALL 64 ETA-STATES
AND ALL 35 C_8-ORBITS OF r in F_2^8 \ {0}, COMBINED WITH CG(389)!!

For ANY fixed eta-state (L1 = (deg_u=3, deg_z=1)) in B0_00, B0_11, or B1_11:
  - h_z(u) = f(u, u+z) has deg_u <= 3, with cubic part 100% FIXED by eta!
  - Therefore, for EVERY r != 0 and EVERY z in F_2^8, the directional derivative
      g_{r, z}(u) = D_r h_z(u) = h_z(u) + h_z(u + r)
    is QUADRATIC in u, with 8x8 alternating bilinear matrix B_{r, z} 100% FIXED by eta!
  - Its Walsh sum S_{r, z} = sum_{u in F_2^8} (-1)^{g_{r, z}(u)} satisfies:
      * S_{r, z} == 0   if  ell_{r, z}(c) is NOT orthogonal to ker(B_{r, z}),
      * S_{r, z} == +- 2^{8 - rank(B_{r, z})/2}   if  ell_{r, z}(c) perp ker(B_{r, z}).
  - Grouping z in F_2^8 into Stab_{C_8}(r)-orbits O (size |O| = 2^s):
      Each orbit O contributes either 0 or +- 2^{e(O)}, where e(O) = 8 - rank(B_{r,z})/2 + s!
  - For z = 0: h_0(u) = f|_{D_8}(u) is 100% FIXED, so S_{r, 0} is a KNOWN constant!
    Whenever S_{r, 0} != 0 (e_0 = v_2(S_{r, 0})):
      * If NO other orbit O has e(O) <= e_0  -->  IMMEDIATE CONTRADICTION (eta-state DEAD!!).
      * If EXACTLY ONE other orbit O* has e(O*) <= e_0 (and e(O*) == e_0) -->
        O* MUST have S_{r, z*} != 0, FORCING the linear equations:
            <ell_{r, z*}(c), k> == 0   for ALL k in ker(B_{r, z*})
        (which are BRAND-NEW LINEAR EQUATIONS ON W_ess OUTSIDE CG(389)!!).
  - Even stronger: we filter out any orbit O whose linear condition <ell_{r,z}(c), ker(B_{r,z})> == 0
    is ALREADY INCONSISTENT with sr["_lin_pivs"] (so that orbit is GUARANTEED to contribute 0!!),
    and iterate to fixpoint!
  - Then we feed ALL newly forced linear equations directly into `run_branch_cascade(CG(389))`
    with verify_subst=True!
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
import SOLVE_STEP12A_B0_00_NORMAL_BENT_CRUSH as s12a
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19


def rot8(z, s):
    return ((z << s) | (z >> (8 - s))) & 0xFF


def gf2_rank_and_kernel_8(mat8):
    """8x8 binary symmetric matrix given as list of 8 8-bit ints.
    Returns (rank, list of kernel basis 8-bit ints)."""
    piv = {}
    for row in mat8:
        x = row
        for p, pm in piv.items():
            if (x >> p) & 1: x ^= pm
        if x == 0: continue
        b = x.bit_length() - 1
        for ob in list(piv.keys()):
            if (piv[ob] >> b) & 1: piv[ob] ^= x
        piv[b] = x
    ker = []
    for c in range(8):
        if c in piv: continue
        v = 1 << c
        for p, pm in piv.items():
            if (pm >> c) & 1: v |= (1 << p)
        ker.append(v)
    return len(piv), ker


def build_uz_tables(orbits, origin111, cb111):
    """Precompute exact (deg_u=3, deg_u=2, deg_u=1) ANF coefficients of h_z(u) = f(u, u+z)
    for all z in 0..255!
    Returns:
      - d3_forms[(um3, z_bit)]: 112-bit linear form (bit 111 = const) for coeff of um3 * z_{z_bit}
        Wait: since du=3 ALWAYS has dz=1, coeff of um3 in h_z(u) is sum_{b: (z>>b)&1} d3_forms[(um3, b)]!
      - d2_by_z[z][i][j] (for 0<=i<j<8): 112-bit linear form for coeff of u_i u_j in h_z(u)
      - d1_by_z[z][i] (for 0<=i<8): 112-bit linear form for coeff of u_i in h_z(u)
    """
    orb_uz = [set() for _ in range(116)]
    for j, orb in enumerate(orbits):
        s = orb_uz[j]
        for m in orb:
            bits = [b for b in range(16) if (m >> b) & 1]
            terms = [(0, 0)]
            for b in bits:
                if b < 8:
                    ub = 1 << b
                    terms = [(um | ub, zm) for (um, zm) in terms]
                else:
                    k = b - 8
                    ub, zb = 1 << k, 1 << k
                    nt = []
                    for (um, zm) in terms:
                        nt.append((um | ub, zm))
                        nt.append((um, zm | zb))
                    terms = nt
            for t in terms:
                if t in s: s.remove(t)
                else: s.add(t)

    def mask_to_uz(cm):
        s = set()
        while cm:
            lb = cm & -cm; j = lb.bit_length() - 1; cm ^= lb
            s.symmetric_difference_update(orb_uz[j])
        return s

    # Map (um, zm) -> 112-bit mask of which basis vars (+ bit 111 for origin111) contain (um, zm)
    term_forms = {}
    for i, cm in enumerate(cb111):
        bit = 1 << i
        for t in mask_to_uz(cm):
            term_forms[t] = term_forms.get(t, 0) ^ bit
    for t in mask_to_uz(origin111):
        term_forms[t] = term_forms.get(t, 0) ^ (1 << 111)

    # Group terms by du in {1, 2, 3}
    d3_terms = [(um, zm, fm) for (um, zm), fm in term_forms.items() if um.bit_count() == 3]
    d2_terms = [(um, zm, fm) for (um, zm), fm in term_forms.items() if um.bit_count() == 2]
    d1_terms = [(um, zm, fm) for (um, zm), fm in term_forms.items() if um.bit_count() == 1]

    # Precompute for every z in 0..255:
    #   c3[z]: list of (um3, fm) for terms active at z
    #   c2[z]: 8x8 symmetric matrix of 112-bit forms
    #   c1[z]: len-8 list of 112-bit forms
    c3_by_z = [[] for _ in range(256)]
    c2_by_z = [[[0]*8 for _ in range(8)] for _ in range(256)]
    c1_by_z = [[0]*8 for _ in range(256)]

    for z in range(256):
        c3_map = {}
        for um, zm, fm in d3_terms:
            if (zm & z) == zm:
                c3_map[um] = c3_map.get(um, 0) ^ fm
        c3_by_z[z] = [(um, fm) for um, fm in c3_map.items() if fm]

        mat = c2_by_z[z]
        for um, zm, fm in d2_terms:
            if (zm & z) == zm:
                b0 = (um & -um).bit_length() - 1
                b1 = (um ^ (1 << b0)).bit_length() - 1
                mat[b0][b1] ^= fm
                mat[b1][b0] ^= fm

        vec = c1_by_z[z]
        for um, zm, fm in d1_terms:
            if (zm & z) == zm:
                vec[um.bit_length() - 1] ^= fm

    return c3_by_z, c2_by_z, c1_by_z


def reduce_112_mod_lin_pivs(fm112, lin_pivs):
    """Reduce a 112-bit linear form (bit 111 = const) modulo lin_pivs (dict p -> (pv, pr)).
    Returns (var_mask, rhs_const) representing <var_mask, x> ^ rhs_const."""
    vm = fm112 & ((1 << 111) - 1)
    rhs = (fm112 >> 111) & 1
    for p, (pv, pr) in lin_pivs.items():
        if (vm >> p) & 1:
            vm ^= pv
            rhs ^= pr
    return vm, rhs


def run_step25_cell(cell_name, lib_diag, lib9, lib_cg, lib_d8, orbits, layer_vecs, orb_tt_np,
                    v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 25: 2-ADIC AUTOCORRELATION A_f((r,r))=0 ON ALL 64 ETA-STATES ====================", flush=True)
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    n, n_cw = tbl["n"], tbl["n_col_words"]

    c3_by_z, c2_by_z, c1_by_z = build_uz_tables(orbits, origin111, cb111)
    print(f"[{cell_name}] Built exact (u, z) ANF tables ({time.perf_counter()-t0:.1f}s)", flush=True)

    # Build CG(389) (+40 D8 cubics for B0_00!)
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

    d8_buf, n_d8 = None, 0
    if cell_name == "B0_00":
        b_tt = np.zeros((111, 65536), dtype=np.uint8)
        for i, m in enumerate(cb111):
            tmp = m
            while tmp: lb = tmp & -tmp; b_tt[i] ^= orb_tt_np[lb.bit_length() - 1]; tmp ^= lb
        seen_a, d8_specs = set(), []
        for a in range(1, 256):
            if a in seen_a: continue
            orb_a = [rot8(a, s) for s in range(8)]
            seen_a.update(orb_a)
            olen = len(set(orb_a))
            d8_specs.append((a, 3))
            if olen == 4: d8_specs.append((a, 4))
            elif olen == 2: d8_specs.append((a, 5))
            elif olen == 1: d8_specs.append((a, 6))
        n_d8 = len(d8_specs)
        d8_buf = (ctypes.c_uint64 * (n_d8 * n_cw))()
        for idx_d, (a, sb) in enumerate(d8_specs):
            pts = np.array([v | ((v ^ a) << 8) for v in range(256)], dtype=np.uint16)
            b_words = (ctypes.c_uint64 * (111 * 4))()
            for i in range(111):
                bits = b_tt[i, pts]
                for w in range(4):
                    val = 0
                    for b in range(64):
                        if bits[w * 64 + b]: val |= (1 << b)
                    b_words[i * 4 + w] = val
            rptr = ctypes.cast(ctypes.byref(d8_buf, idx_d * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            lib_d8.extract_deg3_coset_poly(
                b_words, sb, n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw,
                tbl["col2_base"], tbl["col3_base"], rptr
            )

    sys_data = diag_v2.build_cell_algebraic_system(cell_name, lib_diag, orbits, v6_list, rot4_data, fiber_meta, extract_sec=18.0)
    cyc_cubs = s9.extract_verified_cyclotomic_cubics(cell_name, orbits, origin111, cb111, layers, c0x0)
    n_base = sum(sys_data["deg_pivs_111"].values())
    total_raw = n_base + len(cyc_cubs) + n_cg + n_d8
    raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, raw_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)
    if n_d8:
        ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs) + n_cg) * n_cw * 8), d8_buf, n_d8 * n_cw * 8)

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])
    n_ef = len(eta_free)

    # Precompute all 35 C_8-orbit reps of r in 1..255 and their Stab_{C_8}(r) orbits on z in 0..255!
    seen_r, r_reps = set(), []
    for r in range(1, 256):
        if r in seen_r: continue
        orb_r = [rot8(r, s) for s in range(8)]
        seen_r.update(orb_r)
        stab = [s for s in range(8) if rot8(r, s) == r]
        # Partition z in 0..255 into stab-orbits
        seen_z, z_orbs = set(), []
        for z in range(256):
            if z in seen_z: continue
            oz = sorted(set(rot8(z, s) for s in stab))
            seen_z.update(oz)
            z_orbs.append((oz[0], len(oz)))
        r_reps.append((r, z_orbs))

    # Precompute f|_{D_8}(u) truth table (256 bits) to get EXACT S_{r, 0} for every r!
    orig_d8 = np.zeros(256, dtype=np.uint8)
    U = np.arange(256, dtype=np.uint16)
    X_d8 = U | (U << 8)
    tmp = origin111
    while tmp:
        lb = tmp & -tmp; orig_d8 ^= orb_tt_np[lb.bit_length() - 1, X_d8]; tmp ^= lb
    S_r0 = {}
    for r, _ in r_reps:
        d_tt = orig_d8 ^ orig_d8[U ^ r]
        S_r0[r] = int(256 - 2 * int(d_tt.sum()))

    # Helper: for fixed lin_pivs (which fixes ALL of eta!), compute for a given (r, z):
    #   - Exact 8x8 alternating matrix B_{r, z} (constant ints!)
    #   - Exact linear part ell_{r, z} (8 x 112-bit masks) of D_r h_z(u)
    #     Wait: D_r h_z(u) = h_z(u) + h_z(u+r).
    #     For a cubic term u_a u_b u_c:
    #       (u_a+r_a)(u_b+r_b)(u_c+r_c) + u_a u_b u_c
    #         = r_a u_b u_c + r_b u_a u_c + r_c u_a u_b   (deg 2 -> B_{r,z}!)
    #         + r_a r_b u_c + r_a r_c u_b + r_b r_c u_a   (deg 1 -> const contribution to ell_{r,z}!)
    #         + r_a r_b r_c
    #     For a quadratic term u_a u_b (coeff C2[a][b]):
    #       (u_a+r_a)(u_b+r_b) + u_a u_b
    #         = r_a u_b + r_b u_a                         (deg 1 -> linear form in c!)
    #         + r_a r_b
    #     For a linear term u_a:
    #       (u_a+r_a) + u_a = r_a (const only, does NOT contribute to ell_{r,z}!)
    #     WAIT A SECOND! ZERO-TRUST CHECK:
    #     In GF(2), for a quadratic Boolean function q(u) = sum_{i<j} B_{ij} u_i u_j + sum_i L_i u_i + c0,
    #     q is UNBALANCED (S != 0) IFF for every k in ker(B):
    #       q(k) + c0 == 0 !!  (NOT just L . k == 0!! Because of u_i^2 = u_i, q(k) = sum_{i<j} B_{ij} k_i k_j + L . k!!)
    #     OH!! THANK GOODNESS WE CAUGHT THAT RIGHT HERE (JUST LIKE EARLIER IN B0_00)!!
    #     EXACT DICKSON CRITERION OVER F_2:
    #       S(q) != 0  <==>  for EVERY k in ker(B):  (sum_{i<j} B_{ij} k_i k_j) ^ (L . k) == 0 !!
    #     Since B_{r,z} is 100% CONSTANT (fixed by eta), `q_quad(k) = sum_{i<j} B_{ij} k_i k_j` is a KNOWN CONSTANT BIT,
    #     so `L . k == q_quad(k)` is STILL AN EXACT AFFINE LINEAR EQUATION ON c!!

    # Zero-trust verify our Dickson criterion on 20 random (r, z, x) triples BEFORE scanning!
    def compute_dr_hz_conds(r, z, lin_pivs):
        # 1. Constant cubic coefficients at z (must reduce to constant 0 or 1 mod lin_pivs!)
        B_mat = [0] * 8
        L_const = [0] * 8
        for um3, fm in c3_by_z[z]:
            vm, rhs = reduce_112_mod_lin_pivs(fm, lin_pivs)
            assert vm == 0, f"eta not fully fixed at z=0x{z:02x}!"
            if rhs == 0: continue
            # 3 bits of um3
            a = (um3 & -um3).bit_length() - 1
            t1 = um3 ^ (1 << a)
            b = (t1 & -t1).bit_length() - 1
            c = (t1 ^ (1 << b)).bit_length() - 1
            ra, rb, rc = (r >> a) & 1, (r >> b) & 1, (r >> c) & 1
            if ra:
                B_mat[b] ^= (1 << c); B_mat[c] ^= (1 << b)
            if rb:
                B_mat[a] ^= (1 << c); B_mat[c] ^= (1 << a)
            if rc:
                B_mat[a] ^= (1 << b); B_mat[b] ^= (1 << a)
            if ra and rb: L_const[c] ^= 1
            if ra and rc: L_const[b] ^= 1
            if rb and rc: L_const[a] ^= 1
        rk, ker = gf2_rank_and_kernel_8(B_mat)
        # 2. Linear terms L_i(c) = L_const[i] ^ sum_{j: (r>>j)&1} c2_by_z[z][i][j]
        L_forms = [0] * 8
        c2z = c2_by_z[z]
        for i in range(8):
            fm = (1 << 111) if L_const[i] else 0
            for j in range(8):
                if (r >> j) & 1:
                    fm ^= c2z[i][j]
            L_forms[i] = fm
        # 3. For each k in ker: equation is (L . k) == sum_{i<j} B_mat[i][j] k_i k_j
        eqs = []
        for k in ker:
            quad_k = 0
            for i in range(8):
                if not ((k >> i) & 1): continue
                for j in range(i + 1, 8):
                    if ((k >> j) & 1) and ((B_mat[i] >> j) & 1):
                        quad_k ^= 1
            fm_k = (1 << 111) if quad_k else 0
            for i in range(8):
                if (k >> i) & 1:
                    fm_k ^= L_forms[i]
            vm, rhs = reduce_112_mod_lin_pivs(fm_k, lin_pivs)
            # We need vm . x ^ rhs == 0  <=>  vm . x == rhs!
            eqs.append((vm, rhs))
        # Check consistency of eqs!
        tmp_lp = {}
        ok = True
        for vm, rhs in eqs:
            if not s9.add_linear_rref(tmp_lp, vm, rhs):
                ok = False; break
        return rk, ok, eqs

    # Quick Zero-Trust check of compute_dr_hz_conds on eta=0 (or eta=4 for B0_00)
    em_zt = 4 if cell_name == "B0_00" else 0
    sr_zt = s9.run_branch_cascade(
        lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
        [(eta_free[k], (em_zt >> k) & 1) for k in range(n_ef)], tbl, max_xl_rounds=20, verify_subst=False
    )
    if not sr_zt["closed_unsat"]:
        rng_zt = random.Random(2525)
        act_zt = [i for i in range(n) if i not in sr_zt["_lin_pivs"]]
        for _ in range(15):
            r_t = rng_zt.randint(1, 255)
            z_t = rng_zt.randint(1, 255)
            rk, ok, eqs = compute_dr_hz_conds(r_t, z_t, sr_zt["_lin_pivs"])
            # Sample a point x satisfying lin_pivs!
            x = sum((1 << v) for v in act_zt if rng_zt.randint(0, 1))
            for p, (pv, pr) in sr_zt["_lin_pivs"].items():
                if (((pv ^ (1 << p)) & x).bit_count() ^ pr) & 1: x |= (1 << p)
            # Compute actual S_{r_t, z_t}(x) from truth table!
            pts = U | ((U ^ z_t) << 8)
            pts_r = (U ^ r_t) | ((U ^ r_t ^ z_t) << 8)
            tt_f = np.zeros(65536, dtype=np.uint8)
            cm = origin111
            for i in range(111):
                if (x >> i) & 1: cm ^= cb111[i]
            while cm:
                lb = cm & -cm; tt_f ^= orb_tt_np[lb.bit_length() - 1]; cm ^= lb
            d_tt = tt_f[pts] ^ tt_f[pts_r]
            S_true = int(256 - 2 * int(d_tt.sum()))
            cond_sat = all((((vm & x).bit_count() & 1) == rhs) for vm, rhs in eqs)
            if cond_sat:
                assert abs(S_true) == (1 << (8 - rk // 2)), f"Dickson mismatch: S={S_true}, rk={rk}"
            else:
                assert S_true == 0, f"Dickson zero mismatch: S={S_true}"
        print(f"[{cell_name}] Zero-trust verified Dickson S_{{r,z}} criterion: 15/15 EXACT matches!", flush=True)

    # NOW SCAN ALL 64 ETA-STATES!
    n_base_closed = 0
    n_autocorr_killed = 0
    n_with_forced_lin = 0
    n_closed_after_forced = 0
    max_forced_rk = 0
    max_q_jump = 0

    for em in range(1 << n_ef):
        ex = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
        sr = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex, tbl, max_xl_rounds=20, verify_subst=False
        )
        if sr["closed_unsat"]:
            n_base_closed += 1
            continue

        cur_lp = dict(sr["_lin_pivs"])
        forced_new = []
        killed_by_2adic = False

        # Iterate 2-adic single-canceller propagation to fixpoint!
        for _pass in range(4):
            added_this_pass = False
            for r, z_orbs in r_reps:
                s0 = S_r0[r]
                if s0 == 0: continue
                e0 = (abs(s0) & -abs(s0)).bit_length() - 1  # v_2(S_{r, 0})
                cands = []
                for z_rep, olen in z_orbs:
                    if z_rep == 0: continue
                    s_orb = olen.bit_length() - 1
                    # Quick bound: min possible e(O) = 4 + s_orb (since rank <= 8 -> 8 - rk/2 >= 4)
                    if 4 + s_orb > e0: continue
                    rk, ok, eqs = compute_dr_hz_conds(r, z_rep, cur_lp)
                    if not ok: continue
                    e_orb = (8 - rk // 2) + s_orb
                    if e_orb <= e0:
                        cands.append((e_orb, z_rep, eqs))
                if len(cands) == 0:
                    killed_by_2adic = True
                    break
                if len(cands) == 1 and cands[0][0] == e0:
                    # UNIQUE CANCELLER!! All eqs in cands[0][2] are 100% FORCED!!
                    for vm, rhs in cands[0][2]:
                        before = len(cur_lp)
                        if not s9.add_linear_rref(cur_lp, vm, rhs):
                            killed_by_2adic = True; break
                        if len(cur_lp) > before:
                            forced_new.append((vm, rhs))
                            added_this_pass = True
                    if killed_by_2adic: break
            if killed_by_2adic or not added_this_pass:
                break

        if killed_by_2adic:
            n_autocorr_killed += 1
            print(f"  [{cell_name}] *** eta={em:2d} KILLED BY 2-ADIC AUTOCORRELATION!! ***", flush=True)
            continue

        if forced_new:
            n_with_forced_lin += 1
            max_forced_rk = max(max_forced_rk, len(forced_new))
            sub = s9.run_branch_cascade(
                lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                forced_new, tbl, max_xl_rounds=20, verify_subst=True
            )
            if sub["closed_unsat"]:
                n_closed_after_forced += 1
                print(f"  [{cell_name}] *** eta={em:2d}: +{len(forced_new)} 2-adic forced linears -> CLOSED 1=0 ({sub.get('closed_by')})!! ***", flush=True)
            else:
                q_old = sr.get("n_quad_surviving", 0)
                q_new = sub.get("n_quad_surviving", 0)
                max_q_jump = max(max_q_jump, q_new - q_old)
                if q_new > q_old or len(forced_new) >= 2:
                    print(f"  [{cell_name}] eta={em:2d}: +{len(forced_new)} 2-adic forced linears -> N={sub['N_active']} (was {sr['N_active']}), q={q_new} (was {q_old})", flush=True)

    print(f"[{cell_name}] STEP 25 SUMMARY: base_closed={n_base_closed}/64 | 2adic_killed={n_autocorr_killed}/64 | "
          f"states_with_forced_lin={n_with_forced_lin}/64 (max_forced={max_forced_rk}) | closed_after_forced={n_closed_after_forced}/64 | "
          f"max_q_jump=+{max_q_jump} ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s25_diag.c", WORK_DIR / "libs25_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s25_s9.c", WORK_DIR / "libs25_s9.so"
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
    lib9.gf2_echelon_insert_s9.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib9.gf2_echelon_insert_s9.restype = ctypes.c_int
    lib9.mul_deg2_row_by_var.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
    ]
    lib9.eval_row_s9.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_uint64, ctypes.c_uint64,
    ]
    lib9.eval_row_s9.restype = ctypes.c_int

    c_cg, so_cg = WORK_DIR / "s25_cg.c", WORK_DIR / "libs25_cg.so"
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

    c_d8, so_d8 = WORK_DIR / "s25_d8.c", WORK_DIR / "libs25_d8.so"
    c_d8.write_text(s12a.C_D8CUB_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_d8), "-o", str(so_d8)], check=True)
    lib_d8 = ctypes.CDLL(str(so_d8))
    lib_d8.extract_deg3_coset_poly.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
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
    for cname in [c.strip() for c in args.cells.split(",") if c.strip()]:
        run_step25_cell(
            cname, lib_diag, lib9, lib_cg, lib_d8, orbits, layer_vecs, orb_tt_np,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()

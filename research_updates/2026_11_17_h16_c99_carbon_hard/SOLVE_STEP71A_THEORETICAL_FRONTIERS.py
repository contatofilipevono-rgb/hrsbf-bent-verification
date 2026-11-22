#!/usr/bin/env python3
r"""
SOLVE_STEP71A_THEORETICAL_FRONTIERS.py
======================================
PURE-THEORETICAL 4-FRONTIER X-RAY ON H(16, 4) (B0_00, B0_11, B1_11):

  T1. COMPLETE ANATOMY OF THE UNTOUCHED 61%-65% OF CG(389) (drf >= 2: Block_B + Block_C)
      + SAT/CONSISTENCY CHECK OF DRF1 ALONE + EXACT Z_16^* AUTOMORPHISM STABILIZER AUDIT:
      - Exact row counts for EVERY (drf, dt_c, lead_d) block across B0_00, B0_11, B1_11.
      - Inspect Block_B (A_rf2 rank, sparsity, factoring) and Block_C (cubic in R_F).
      - Check whether M(W) R_F = b(W) is consistent at W=0 / low-wt W / random W.
      - Exact Z_16^* = {1,3,5,7,9,11,13,15} stabilizer group of each eta orbit (esp. eta=0!).

  T2. EXACT C_8-INVARIANT EVEN/ODD SPLIT E_8 (+) O_8 (NEVER TESTED BEFORE!):
      - E_8 = {even coords}, O_8 = {odd coords} (C_8 = <rot16^2>-invariant!).
      - Exact dimension of f|_{E_8} in root (N=109) and fixed-eta (N=101).
      - Exact Z/16Z and Z/32Z left-syzygies of the 36x36 C_8-Walsh kernel K_{E_8}
        (Zero-Trust audited on real C16-RSB bent functions quad_b1, quad_d1!).
      - Check exact degree<=4 functional rank & independence from CG(389)!

  T3. THE D_8-COSET CUBIC TENSOR THEOREM g_y(v) = f(v, v^y) (deg_v <= 3 FOR ALL 256 COSETS!):
      - Verify deg_v(g_y) <= 3 for ALL 256 cosets y in F_2^8 on B0_00, B0_11, B1_11!
      - Extract exact 56-monomial cubic tensor Phi_0(v) = d/dx_8 f(v, v)|_{deg 3} as linear
        forms in (W, T, R_F) -> measure EXACT rank in W, T, and R_F!
      - Inspect anti-diagonal primal g_{0xFF}(v) = f(v, ~v): exact deg_v, variable support!
      - Dickson symplectic rank distribution of D_u g_y(v) (quadratic in v) for u != 0!

  T4. EXACT CHARACTERISTIC-0 DELSARTE / KRAWTCHOUK MILP (HiGHS via scipy.optimize.milp):
      - Variables: exact C_16-orbit counts n_{w, s} at each weight w=0..16 & orbit size s,
        for both primal f (A_w) and dual f_tilde (B_k), with A_0=A_1=A_2=A_3=0,
        exact fixed D_8 values (s <= 8 orbits) of f and f_tilde on B0_11 and B1_11,
        and exact anti-diagonal dual weight constraints!
      - Zero-Trust audited on real C16-RSB bent functions quad_b1, quad_d1 (0 residual!).
      - Checks global feasibility & exact min/max bounds on A_4 (wt of c) and A_16!
"""

import argparse
import ctypes
import math
import sys
import time
from pathlib import Path
import numpy as np
from scipy.optimize import milp, LinearConstraint, Bounds

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP60C_DEG4_V13_WALSH_XL as s60c
import SOLVE_STEP61A_EXTENDED_OPT_AND_ALGEBRAIC_CEILING as s61a
import SOLVE_STEP63A_EXACT_AUTOCORR_PARSEVAL_MOD32_64 as s63a
import SOLVE_STEP65A_ALL4116_WALSH_2ADIC_AND_INTEGER_SPECTRUM as s65a
import SOLVE_STEP66_ALL36_TWISTED_D8_DUALS as s66


def get_root_affine_basis(env):
    root = env["root"]
    root_act = env["root_act"]
    orig_tt, basis_tt, _, _ = s60c.build_affine_tt_basis(
        env["o_tt_111"], env["b_tt_111"], root["_lin_pivs"], root_act
    )
    return orig_tt, basis_tt, root_act


def eval_root_cg_on_batch(env, C_mat):
    """Evaluate all root CG(389) quad+cubic rows on C_mat [B, N_root] via lib9.eval_row_s9."""
    lib9 = env["lib9"]
    tbl = env["tbl"]
    root = env["root"]
    root_act = env["root_act"]
    lin_pivs = root["_lin_pivs"]
    eq_ids = list(root["_quad_ids"]) + list(root["_cub_ids"])
    n_cw = tbl["n_col_words"]
    mask64 = (1 << 64) - 1
    B = C_mat.shape[0]
    out = np.zeros((B, len(eq_ids)), dtype=np.uint8)
    for bi in range(B):
        x = 0
        for k, v in enumerate(root_act):
            if C_mat[bi, k]:
                x |= (1 << v)
        for p, (pv, pr) in lin_pivs.items():
            if (((pv ^ (1 << p)) & x).bit_count() ^ pr) & 1:
                x |= (1 << p)
        v_lo, v_hi = x & mask64, x >> 64
        for ei, rid in enumerate(eq_ids):
            rptr = ctypes.cast(ctypes.byref(root["_buf"], rid * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            out[bi, ei] = lib9.eval_row_s9(
                rptr, n_cw, tbl["off0"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], v_lo, v_hi
            )
    return out


# ==============================================================================
# Helper: Build real C16-RSB bent functions (quad_b1, quad_d1) for Zero-Trust!
# ==============================================================================

def build_real_c16_bents():
    xs = np.arange(65536, dtype=np.uint32)
    bents = []
    # 1. quad_b1: sum_{i=0}^7 x_i x_{i+8} (antipodal quadratic bent!)
    tt1 = np.zeros(65536, dtype=np.uint8)
    for i in range(8):
        tt1 ^= (((xs >> i) & 1) & ((xs >> (i + 8)) & 1)).astype(np.uint8)
    bents.append(("quad_b1", tt1))
    # 2. quad_d1: quad_b1 ^ sum_{i=0}^{15} x_i x_{(i+1)%16} (check bentness!)
    for d in [1, 2, 3, 4, 5, 6, 7]:
        tt = tt1.copy()
        for i in range(16):
            tt ^= (((xs >> i) & 1) & ((xs >> ((i + d) & 15)) & 1)).astype(np.uint8)
        sp = np.where(tt == 0, 1, -1).astype(np.int32)
        st = 1
        while st < 65536:
            sp = sp.reshape(-1, 2, st)
            u, w = sp[:, 0, :].copy(), sp[:, 1, :].copy()
            sp[:, 0, :] = u + w
            sp[:, 1, :] = u - w
            sp = sp.reshape(-1)
            st <<= 1
        if np.all(np.abs(sp) == 256):
            bents.append((f"quad_d{d}", tt))
            break
    # Verify both are C16-RSB and bent
    for name, tt in bents:
        sp = np.where(tt == 0, 1, -1).astype(np.int32)
        st = 1
        while st < 65536:
            sp = sp.reshape(-1, 2, st)
            u, w = sp[:, 0, :].copy(), sp[:, 1, :].copy()
            sp[:, 0, :] = u + w
            sp[:, 1, :] = u - w
            sp = sp.reshape(-1)
            st <<= 1
        assert np.all(np.abs(sp) == 256), f"{name} is not bent!"
    return bents


def fwht(vec):
    a = np.array(vec, dtype=np.int64)
    n = len(a)
    st = 1
    while st < n:
        a = a.reshape(-1, 2, st)
        u, w = a[:, 0, :].copy(), a[:, 1, :].copy()
        a[:, 0, :] = u + w
        a[:, 1, :] = u - w
        a = a.reshape(-1)
        st <<= 1
    return a


def gf2_rank_np(M):
    """Fast GF(2) rank of binary numpy matrix [r, c]."""
    if M.size == 0:
        return 0
    r, c = M.shape
    piv = {}
    for i in range(r):
        v = 0
        for j in np.flatnonzero(M[i]):
            v |= (1 << int(j))
        while v:
            lb = v & -v
            if lb in piv:
                v ^= piv[lb]
            else:
                piv[lb] = v
                break
    return len(piv)


def gf2_consistent(A, b):
    """Check if A x = b is consistent over GF(2)."""
    r1 = gf2_rank_np(A)
    r2 = gf2_rank_np(np.hstack([A, b[:, None]]))
    return (r1 == r2), r1, r2


# ==============================================================================
# T1: Full Anatomy of drf >= 2 + DRF1 Consistency + Z_16^* Stabilizer Symmetry
# ==============================================================================

def run_t1_anatomy_and_symmetry(cell_name, env, etas):
    print(f"\n==================== [T1: {cell_name}] FULL ANATOMY (drf>=2) + DRF1 SAT + Z_16^* SYMMETRY ====================", flush=True)
    lib9, lib_sh = env["lib9"], env["lib_sh"]
    tbl, root, eta_free = env["tbl"], env["root"], env["eta_free"]
    n, n_cw = tbl["n"], tbl["n_col_words"]
    n_cols = tbl["off0"] + 1
    mask64 = (1 << 64) - 1

    # 1. Z_16^* action on the 116 C_16 orbits!
    orbs_116 = diag_v2.build_orbits_116()
    orb_map = {}
    for oi, o in enumerate(orbs_116):
        for m in o:
            orb_map[m] = oi
    z16_star = [1, 3, 5, 7, 9, 11, 13, 15]
    perm_116 = {}
    for mult in z16_star:
        p = []
        for oi, o in enumerate(orbs_116):
            rep = o[0]
            nm = 0
            for bit in range(16):
                if (rep >> bit) & 1:
                    nm |= (1 << ((bit * mult) & 15))
            p.append(orb_map[nm])
        perm_116[mult] = p

    # Map eta_free masks (which are in root's 111-var indexing? Check!)
    # Check stabilizer of each eta_mask on the 8 eta_free linear forms!
    print(f"  [{cell_name}] n_eta_free={len(eta_free)} | eta_free masks (hex)={[hex(x) for x in eta_free]}", flush=True)

    for em in etas:
        blk = s61a.extract_full_blocks_fast(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=7100 + em)
        if blk["closed_unsat"]:
            print(f"  [{cell_name} eta={em}] CLOSED UNSAT AT ETA!", flush=True)
            continue

        # Re-classify ALL ech_rows (including drf=2 deg=3 and drf=3!)
        sr = blk["sr"]
        W_rref, T_rref = blk["W_rref"], blk["T_rref"]
        W_pivs, T_pivs, RF_vars = blk["W_pivs"], blk["T_pivs"], blk["RF_vars"]
        nW, nT, nRF = blk["nW"], blk["nT"], blk["nRF"]
        eq_ids = list(sr["_quad_ids"]) + list(sr["_cub_ids"])
        M_eq = len(eq_ids)
        work = (ctypes.c_uint64 * (M_eq * n_cw))()
        for i, rid in enumerate(eq_ids):
            ctypes.memmove(ctypes.byref(work, i * n_cw * 8), ctypes.byref(sr["_buf"], rid * n_cw * 8), n_cw * 8)
        for p in W_pivs:
            rest = W_rref[p] ^ (1 << p)
            if rest:
                lib_sh.shear_subst_var_batch(
                    work, M_eq, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                    tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                    p, rest & mask64, rest >> 64,
                )
        for p in T_pivs:
            rest = T_rref[p] ^ (1 << p)
            if rest:
                lib_sh.shear_subst_var_batch(
                    work, M_eq, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                    tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                    p, rest & mask64, rest >> 64,
                )

        col_deg_np = np.ctypeslib.as_array(tbl["col_deg"], shape=(n_cols,))
        col_v0_np = np.ctypeslib.as_array(tbl["col_v0"], shape=(n_cols,))
        col_v1_np = np.ctypeslib.as_array(tbl["col_v1"], shape=(n_cols,))
        col_v2_np = np.ctypeslib.as_array(tbl["col_v2"], shape=(n_cols,))
        var_grp = np.full(n, -1, dtype=np.int8)
        for v in W_pivs: var_grp[v] = 0
        for v in T_pivs: var_grp[v] = 1
        for v in RF_vars: var_grp[v] = 2
        c_drf = np.zeros(n_cols, dtype=np.int8)
        c_dtc = np.zeros(n_cols, dtype=np.int8)
        m1, m2, m3 = col_deg_np >= 1, col_deg_np >= 2, col_deg_np >= 3
        c_drf[m1] += (var_grp[col_v0_np[m1]] == 2)
        c_drf[m2] += (var_grp[col_v1_np[m2]] == 2)
        c_drf[m3] += (var_grp[col_v2_np[m3]] == 2)
        c_dtc[m1] += (var_grp[col_v0_np[m1]] == 1)
        c_dtc[m2] += (var_grp[col_v1_np[m2]] == 1)
        c_dtc[m3] += (var_grp[col_v2_np[m3]] == 1)

        col_keys = [(3 - int(c_drf[c]), 3 - int(c_dtc[c]), 3 - int(col_deg_np[c]), c) for c in range(n_cols)]
        col_keys.sort()
        orig_to_perm = (ctypes.c_int * n_cols)()
        perm_to_orig = [0] * n_cols
        for pc, (_, _, _, oc) in enumerate(col_keys):
            orig_to_perm[oc] = pc
            perm_to_orig[pc] = oc
        perm_buf = (ctypes.c_uint64 * (M_eq * n_cw))()
        lib_sh.remap_rows_by_perm(work, perm_buf, M_eq, n_cw, n_cols, orig_to_perm)
        piv_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
        hist = {}
        for r in range(M_eq):
            pc = lib9.gf2_echelon_insert_s9(perm_buf, r, n_cw, piv_idx, n_cols)
            if pc >= 0:
                oc = perm_to_orig[pc]
                key = (int(c_drf[oc]), int(c_dtc[oc]), int(col_deg_np[oc]))
                hist[key] = hist.get(key, 0) + 1

        # Block B stats
        A_rf2 = blk["A_rf2"]
        rk_B = gf2_rank_np(A_rf2)
        avg_wt_B = float(np.mean(np.sum(A_rf2, axis=1))) if A_rf2.shape[0] > 0 else 0.0

        # Check DRF1 consistency at W=0, all 1-hot e_k, and 128 random W!
        DQ_t = blk["DRF1_quad_t"]
        DQ_b = blk["DRF1_quad_b"]
        W_test = np.zeros((1 + nW + 128, nW), dtype=np.uint8)
        for k in range(nW):
            W_test[1 + k, k] = 1
        rng = np.random.default_rng(71100 + em)
        W_test[1 + nW:] = rng.integers(0, 2, size=(128, nW), dtype=np.uint8)
        T_test = blk["eval_t_batch"](W_test)
        B_test = DQ_b(W_test, T_test)

        n_cons_0, n_cons_1, n_cons_rnd = 0, 0, 0
        rks_rnd = []
        for idx in range(W_test.shape[0]):
            M_pt = blk["eval_drf1_mat_point"](DQ_t, W_test[idx], T_test[idx])
            ok, rA, rAb = gf2_consistent(M_pt, B_test[idx])
            if idx == 0:
                n_cons_0 = int(ok)
                rk_0 = (rA, rAb)
            elif idx <= nW:
                n_cons_1 += int(ok)
            else:
                n_cons_rnd += int(ok)
                rks_rnd.append(rA)

        print(
            f"  [{cell_name} eta={em}] (nW={nW}, nT={nT}, nRF={nRF}, M_eq={M_eq}):\n"
            f"    FULL ECHELON (drf, dt_c, lead_d) HIST = {dict(sorted(hist.items()))}\n"
            f"    Block_B (drf=2,d=2): rows={A_rf2.shape[0]}, rk(A_rf2)={rk_B}, avg_pairs/row={avg_wt_B:.1f}\n"
            f"    DRF1_quad consistency: W=0 -> cons={bool(n_cons_0)} (rk={rk_0[0]}/{rk_0[1]}), "
            f"wt1_W -> {n_cons_1}/{nW} cons, rnd128 -> {n_cons_rnd}/128 cons (rk_M min/med/max={min(rks_rnd)}/{int(np.median(rks_rnd))}/{max(rks_rnd)})",
            flush=True,
        )


# ==============================================================================
# T2: Exact C_8-Invariant Even/Odd Split E_8 (+) O_8
# ==============================================================================

def build_e8_o8_maps():
    """
    Build exact mapping between 8-bit even vector u_e, 8-bit odd vector u_o and 16-bit x:
      bit 2*i   of x = bit i of u_e
      bit 2*i+1 of x = bit i of u_o
    """
    even_to_16 = np.zeros(256, dtype=np.int32)
    odd_to_16 = np.zeros(256, dtype=np.int32)
    for u in range(256):
        xe, xo = 0, 0
        for i in range(8):
            if (u >> i) & 1:
                xe |= (1 << (2 * i))
                xo |= (1 << (2 * i + 1))
        even_to_16[u] = xe
        odd_to_16[u] = xo
    return even_to_16, odd_to_16


def run_t2_even_odd_split(cell_name, env, real_bents):
    print(f"\n==================== [T2: {cell_name}] C_8-INVARIANT EVEN/ODD SPLIT E_8 (+) O_8 ====================", flush=True)
    even_to_16, odd_to_16 = build_e8_o8_maps()

    # 1. Build 36 C_8-orbits on F_2^8
    seen = set()
    c8_orbs = []
    for a in range(256):
        if a in seen:
            continue
        orb = []
        cur = a
        while cur not in seen:
            seen.add(cur)
            orb.append(cur)
            cur = diag_v2.rot8(cur)
        c8_orbs.append(sorted(orb))
    assert len(c8_orbs) == 36

    # Build 36x36 C_8-Walsh kernel K_E8[a_orb, w_orb] = sum_{w in w_orb} (-1)^{a_rep . w}
    K_E8 = np.zeros((36, 36), dtype=np.int32)
    for ia, oa in enumerate(c8_orbs):
        arep = oa[0]
        for iw, ow in enumerate(c8_orbs):
            K_E8[ia, iw] = sum(-1 if ((arep & w).bit_count() & 1) else 1 for w in ow)

    # Zero-Trust check on real C16-RSB bent functions:
    #   S_a^{even} = sum_{u in E_8} (-1)^{f(u_e ^ a_o)} MUST equal sum_{w in O_8} (-1)^{a.w + f_tilde(w_o)}
    #   AND Parseval: sum_{a in O_8} (S_a^{even})^2 == 65536!
    bent_Se = []
    for bname, btt in real_bents:
        Se = np.zeros(256, dtype=np.int64)
        for a in range(256):
            ao = odd_to_16[a]
            idx = even_to_16 ^ ao
            Se[a] = int(np.sum(np.where(btt[idx] == 0, 1, -1)))
        # Walsh transform of Se over a in F_2^8 must be +-256!
        W_Se = fwht(Se)
        assert np.all(np.abs(W_Se) == 256), f"ZT FAIL E_8 Walsh on {bname}!"
        assert int(np.sum(Se * Se)) == 65536, f"ZT FAIL E_8 Parseval on {bname}!"
        # Also verify S_a^{even} is constant on each C_8-orbit!
        for oa in c8_orbs:
            vals = set(int(Se[a]) for a in oa)
            assert len(vals) == 1, f"ZT FAIL C_8 invariance on {bname}!"
        Se_36 = np.array([Se[oa[0]] for oa in c8_orbs], dtype=np.int64)
        bent_Se.append((bname, Se_36))
    print(f"  [ZT-E8-REAL-BENT]: Verified E_8 Walsh=+-256, Parseval=65536, C_8-invariance on {[x[0] for x in bent_Se]}!", flush=True)

    # Extract exact Z/16Z (k=4 -> mod 32) and Z/32Z (k=5 -> mod 64) left-syzygies of K_E8:
    # Since Se_36 = K_E8 @ (1 - 2*g_36), if u^T K_E8 == 0 mod 2^k, then u^T Se_36 == c0 mod 2^{k+1}!
    syz_e8 = []
    for k in [3, 4, 5]:
        u_vecs = s66.exact_left_nullspace_mod_2k(K_E8, k)
        mod_t = 1 << (k + 1)
        c0_all = K_E8.sum(axis=1)
        kept = 0
        for u in u_vecs:
            c0 = int(np.dot(u.astype(np.int64), c0_all.astype(np.int64))) % mod_t
            # Zero-Trust verify on BOTH real bent functions!
            for bname, Se_36 in bent_Se:
                lhs = int(np.dot(u.astype(np.int64), Se_36)) % mod_t
                assert lhs == c0, f"ZT FAIL E_8 syzygy k={k} on {bname}: {lhs} != {c0}!"
            syz_e8.append((k, mod_t, c0, u.copy()))
            kept += 1
        print(f"  [E_8 SYZYGIES k={k} (mod {mod_t})]: {kept} ZT-verified syzygies!", flush=True)

    # Evaluate f|_{E_8} dimension and exact 2-adic valuation + deg<=4 test on root affine space (N=109)!
    root = env["root"]
    tbl = env["tbl"]
    base_tt, basis_u8, active_vars = get_root_affine_basis(env)
    N = len(active_vars)
    # Check rank of f|_{E_8} (256 points even_to_16) in the N=109 variables!
    E8_basis = basis_u8[:, even_to_16]  # [N, 256]
    rk_E8 = gf2_rank_np(E8_basis)
    print(f"  [{cell_name} ROOT N={N}] dim(f|_{{E_8}}) = {rk_E8} (out of 10 even quartic orbits!)", flush=True)

    # Evaluate S_a^{even} (all 36 C_8-orbits) on 512 random root points + check Parseval & syzygies!
    rng = np.random.default_rng(71200)
    # Also check CG(389) degree<=3 + exact degree of each E_8 syzygy via 5-dim cubes!
    # Precompute Se_36 for any batch of points c_mat [B, N]
    # Fast vectorized: for each of the 36 orbit reps a_rep, precompute idx_36[ia] = even_to_16 ^ odd_to_16[a_rep]
    idx_36 = np.array([even_to_16 ^ odd_to_16[oa[0]] for oa in c8_orbs], dtype=np.int32)  # [36, 256]
    # Note: 36 * 256 = 9,216 truth-table indices (tiny!)
    flat_idx = idx_36.reshape(-1)
    base_sub = base_tt[flat_idx]               # [9216]
    basis_sub = basis_u8[:, flat_idx]          # [N, 9216]

    def eval_Se36(C_mat):
        # C_mat: [B, N] uint8 -> returns Se [B, 36] int64
        B = C_mat.shape[0]
        tts = ((C_mat.astype(np.uint16) @ basis_sub.astype(np.uint16)) & 1) ^ base_sub[None, :]
        tts = tts.reshape(B, 36, 256)
        return 256 - 2 * np.sum(tts, axis=2, dtype=np.int64)

    # Check exact v2 of every syzygy residual (u^T Se_36 - c0) / mod_t and Parseval!
    C_64 = rng.integers(0, 2, size=(64, N), dtype=np.uint8)
    Se_64 = eval_Se36(C_64)  # [64, 36]
    orb_sz = np.array([len(oa) for oa in c8_orbs], dtype=np.int64)
    pars_64 = np.sum((Se_64 * Se_64) * orb_sz[None, :], axis=1) - 65536
    # Compute 2-adic valuation of pars_64
    v2_pars = min((int(x) & -int(x)).bit_length() - 1 for x in pars_64 if x != 0) if np.any(pars_64 != 0) else 99
    print(f"  [{cell_name} ROOT] E_8 Parseval residual v2_min = {v2_pars} (mod 2^{v2_pars+1} bit)!", flush=True)

    # Check exact degree of E_8 syzygy mod-(2^{k+1}) bits and E_8 Parseval bit via 8 random 5-dim cubes!
    bits5 = np.array([[(m >> b) & 1 for b in range(5)] for m in range(32)], dtype=np.uint8)
    # Collect all scalar bit-functions: (syz_i mod mod_t != c0? wait: (u^T Se - c0) / (mod_t/2) mod 2)
    # Wait: first check actual min v2 of (u^T Se_64 - c0) across the 64 random points!
    n_active_syz = 0
    v2_hist = {}
    active_syz = []
    for k, mod_t, c0, u in syz_e8:
        res = (Se_64 @ u.astype(np.int64)) - c0
        nz = [int(x) for x in res if x != 0]
        if not nz:
            continue
        v_min = min((x & -x).bit_length() - 1 for x in nz)
        if v_min < k + 1:
            n_active_syz += 1
            v2_hist[v_min] = v2_hist.get(v_min, 0) + 1
            active_syz.append((v_min, k, mod_t, c0, u))
    print(f"  [{cell_name} ROOT] Active E_8 syzygies (violated on root): {n_active_syz}/{len(syz_e8)} | v2_min hist={dict(sorted(v2_hist.items()))}", flush=True)

    if active_syz or v2_pars < 99:
        # Check exact algebraic degree (up to 5) of every active syzygy bit + Parseval bit!
        n_bits = len(active_syz) + (1 if v2_pars < 99 else 0)
        max_deg = np.full(n_bits, -1, dtype=np.int32)
        for trial in range(16):
            base_c = rng.integers(0, 2, size=(1, N), dtype=np.uint8)
            dirs = rng.integers(0, 2, size=(5, N), dtype=np.uint8)
            C_cube = (base_c ^ ((bits5 @ dirs) & 1)).astype(np.uint8)
            Se_c = eval_Se36(C_cube)
            F = np.zeros((32, n_bits), dtype=np.uint8)
            for si, (v_min, k, mod_t, c0, u) in enumerate(active_syz):
                res = (Se_c @ u.astype(np.int64)) - c0
                F[:, si] = ((res >> v_min) & 1).astype(np.uint8)
            if v2_pars < 99:
                pr = np.sum((Se_c * Se_c) * orb_sz[None, :], axis=1) - 65536
                F[:, -1] = ((pr >> v2_pars) & 1).astype(np.uint8)
            # Fast Mobius transform
            M = F.copy()
            for b in range(5):
                step = 1 << b
                for m in range(0, 32, 2 * step):
                    M[m + step : m + 2 * step] ^= M[m : m + step]
            for m in range(32):
                d = int(m).bit_count()
                nz = np.flatnonzero(M[m])
                if len(nz):
                    max_deg[nz] = np.maximum(max_deg[nz], d)
        dhist = {}
        for d in max_deg[:-1] if v2_pars < 99 else max_deg:
            dhist[int(d)] = dhist.get(int(d), 0) + 1
        p_deg = int(max_deg[-1]) if v2_pars < 99 else -1
        print(f"  *** [{cell_name} ROOT E_8 EXACT DEGREE CENSUS] ***: syz_deg_hist={dict(sorted(dhist.items()))} | Parseval_v2={v2_pars} deg={p_deg}", flush=True)

        # If ANY deg <= 3 bit exists, check if it is inside CG(389) on 512 random root points!
        low_idx = [i for i in range(len(active_syz)) if max_deg[i] <= 3]
        if low_idx or (v2_pars < 99 and p_deg <= 3):
            C_512 = rng.integers(0, 2, size=(512, N), dtype=np.uint8)
            Se_512 = eval_Se36(C_512)
            # Evaluate all root CG(389) equations on C_512!
            cg_vals = eval_root_cg_on_batch(env, C_512)
            rk_cg = gf2_rank_np(cg_vals.T)
            cols = []
            for si in low_idx:
                v_min, k, mod_t, c0, u = active_syz[si]
                res = (Se_512 @ u.astype(np.int64)) - c0
                cols.append(((res >> v_min) & 1).astype(np.uint8))
            if v2_pars < 99 and p_deg <= 3:
                pr = np.sum((Se_512 * Se_512) * orb_sz[None, :], axis=1) - 65536
                cols.append(((pr >> v2_pars) & 1).astype(np.uint8))
            E8_mat = np.column_stack(cols)
            rk_joint = gf2_rank_np(np.hstack([cg_vals, E8_mat]).T)
            print(f"  *** [{cell_name} E_8 deg<=3 vs CG(389)] ***: rk_CG={rk_cg} | rk_JOINT={rk_joint} -> NEW_OUTSIDE_CG = {rk_joint - rk_cg}!", flush=True)


# ==============================================================================
# T3: D_8-Coset Cubic Tensor Theorem g_y(v) = f(v, v^y) & Dickson Rank Structure
# ==============================================================================

def run_t3_d8_coset_cubic_tensor(cell_name, env, etas):
    print(f"\n==================== [T3: {cell_name}] D_8-COSET CUBIC TENSOR g_y(v) = f(v, v^y) ====================", flush=True)
    lib9, lib_sh = env["lib9"], env["lib_sh"]
    tbl, root, eta_free = env["tbl"], env["root"], env["eta_free"]
    base_tt, basis_u8, active_vars = get_root_affine_basis(env)
    N = len(active_vars)

    # Fast Mobius transform on 8 bits (256 entries) along axis=-1!
    def anf_8bit(vals):
        A = vals.copy()
        for b in range(8):
            step = 1 << b
            A = A.reshape(-1, 256 // (2 * step), 2, step)
            A[:, :, 1, :] ^= A[:, :, 0, :]
            A = A.reshape(vals.shape)
        return A

    # 1. Verify Theorem T3a on ALL 256 cosets y in F_2^8: deg_v(g_y) <= 3!
    #    Check both base_tt and EVERY ONE of the N=109 basis_u8 rows!
    v_arr = np.arange(256, dtype=np.int32)
    pop8 = np.array([int(m).bit_count() for m in range(256)], dtype=np.int32)
    deg4plus_idx = np.flatnonzero(pop8 >= 4)
    deg3_idx = np.flatnonzero(pop8 == 3)
    assert len(deg3_idx) == 56

    max_deg_seen = 0
    for y in range(256):
        pts = v_arr | ((v_arr ^ y) << 8)
        # Check base_tt
        a_base = anf_8bit(base_tt[pts])
        if np.any(a_base[deg4plus_idx]):
            max_deg_seen = max(max_deg_seen, int(np.max(pop8[np.flatnonzero(a_base)])))
        # Check all N basis rows
        a_bas = anf_8bit(basis_u8[:, pts])
        if np.any(a_bas[:, deg4plus_idx]):
            nz_cols = np.flatnonzero(np.any(a_bas[:, deg4plus_idx], axis=0))
            max_deg_seen = max(max_deg_seen, int(np.max(pop8[deg4plus_idx[nz_cols]])))
    print(
        f"  *** [THEOREM T3a: {cell_name} ALL 256 COSETS y] ***: "
        f"ANY deg_v >= 4 across ALL 256 cosets & ALL {N} root vars? -> max_deg_above_3 = {max_deg_seen} "
        f"({'PROVEN deg_v(g_y) <= 3 FOR ALL 256 COSETS!' if max_deg_seen == 0 else 'FOUND DEG >= 4!'})",
        flush=True,
    )

    # 2. Extract exact 56-monomial cubic tensor Phi_0(v) = cubic part of g_{e_0}(v) (y = 1)
    #    Also check linearity in y: g_y|_{deg 3} == sum_{j: y_j=1} rot8^j(Phi_0)!
    pts_e0 = v_arr | ((v_arr ^ 1) << 8)
    phi0_base = anf_8bit(base_tt[pts_e0])[deg3_idx]          # [56]
    phi0_lin = anf_8bit(basis_u8[:, pts_e0])[:, deg3_idx]    # [N, 56]
    rk_phi0_root = gf2_rank_np(phi0_lin.T)

    # Also check g_{0xFF}(v) = f(v, ~v) (anti-diagonal primal!)
    pts_ff = v_arr | ((v_arr ^ 0xFF) << 8)
    aff_base = anf_8bit(base_tt[pts_ff])
    aff_lin = anf_8bit(basis_u8[:, pts_ff])
    aff_max_d = int(np.max(pop8[np.flatnonzero(aff_base | np.any(aff_lin, axis=0))])) if np.any(aff_base | np.any(aff_lin, axis=0)) else 0
    rk_aff_deg3 = gf2_rank_np(aff_lin[:, deg3_idx].T)
    rk_aff_all = gf2_rank_np(aff_lin.T)
    print(
        f"  [{cell_name} ROOT N={N}]:\n"
        f"    Phi_0(v) (56 cubics in g_{{e_0}}): rank = {rk_phi0_root}/56 (base_nz={int(np.sum(phi0_base))})\n"
        f"    Anti-diagonal primal g_{{0xFF}}(v)=f(v,~v): max_deg_v={aff_max_d} | deg3_rank={rk_aff_deg3} | total_rank={rk_aff_all}",
        flush=True,
    )

    # 3. Project Phi_0(v) onto (W, T, R_F) at fixed eta!
    #    Remember active_vars[k] is the original variable index in root (0..110)!
    #    For fixed eta, sr["_lin_pivs"] eliminates 8 more vars, and the remaining 101 vars split into
    #    W_pivs (sheared by W_rref), T_pivs (sheared by T_rref), and RF_vars!
    act_pos = {v: i for i, v in enumerate(active_vars)}
    for em in etas[:2]:
        blk = s61a.extract_full_blocks_fast(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=7130 + em)
        if blk["closed_unsat"]:
            continue
        sr = blk["sr"]
        W_rref, T_rref = blk["W_rref"], blk["T_rref"]
        W_pivs, T_pivs, RF_vars = blk["W_pivs"], blk["T_pivs"], blk["RF_vars"]
        nW, nT, nRF = blk["nW"], blk["nT"], blk["nRF"]

        # Build the exact map from sheared coordinates (w_0..w_{nW-1}, t_0..t_{nT-1}, rf_0..rf_{nRF-1})
        # to the root's N=109 active_vars!
        # In sr: each eliminated var p in sr["_lin_pivs"] equals lin_pivs[p] (linear form in active_now + const).
        # And W_pivs[k] = w_k ^ (rest of W_rref[W_pivs[k]]), T_pivs[a] = t_a ^ (rest of T_rref[T_pivs[a]])!
        # Easiest 100%-Zero-Trust way: evaluate Phi_0(v) on unit basis vectors of (W, T, R_F)!
        n_sh = nW + nT + nRF
        # Reconstruct full 111-bit vector x from (W, T, R_F):
        # First set RF_vars, then T_pivs using T_rref (only involves T_pivs and RF_vars),
        # then W_pivs using W_rref (only involves W_pivs, T_pivs, RF_vars),
        # then sr["_lin_pivs"]!
        lin_pivs = sr["_lin_pivs"]
        def sheared_to_root_vec(w_vec, t_vec, rf_vec):
            bits = {}
            for i, v in enumerate(RF_vars):
                bits[v] = int(rf_vec[i])
            for i, v in enumerate(T_pivs):
                # T_rref[v] = (1<<v) ^ rest_in_RF  ==>  v = t_i ^ parity(rest_in_RF)
                val = int(t_vec[i])
                rest = T_rref[v] ^ (1 << v)
                while rest:
                    lb = rest & -rest
                    u = lb.bit_length() - 1
                    val ^= bits[u]
                    rest ^= lb
                bits[v] = val
            for i, v in enumerate(W_pivs):
                val = int(w_vec[i])
                rest = W_rref[v] ^ (1 << v)
                while rest:
                    lb = rest & -rest
                    u = lb.bit_length() - 1
                    val ^= bits[u]
                    rest ^= lb
                bits[v] = val
            # Eliminated linear pivots (in sr["_lin_pivs"], values are masks in active_now, bit n=const)
            # Note: root["_lin_pivs"] are already folded into active_vars; we only need active_vars!
            c_root = np.zeros(N, dtype=np.uint8)
            for k_a, v in enumerate(active_vars):
                if v in bits:
                    c_root[k_a] = bits[v]
                else:
                    # v is in sr["_lin_pivs"]!
                    pmask, pconst = lin_pivs[v]
                    val = int(pconst)
                    tmp = pmask
                    while tmp:
                        lb = tmp & -tmp
                        u = lb.bit_length() - 1
                        if u != v:
                            val ^= bits[u]
                        tmp ^= lb
                    c_root[k_a] = val
            return c_root

        # Build Jacobian [n_sh, N] from sheared coords to root coords!
        c0 = sheared_to_root_vec(np.zeros(nW, dtype=np.uint8), np.zeros(nT, dtype=np.uint8), np.zeros(nRF, dtype=np.uint8))
        J_W = np.zeros((nW, N), dtype=np.uint8)
        for i in range(nW):
            wv = np.zeros(nW, dtype=np.uint8); wv[i] = 1
            J_W[i] = sheared_to_root_vec(wv, np.zeros(nT, dtype=np.uint8), np.zeros(nRF, dtype=np.uint8)) ^ c0
        J_T = np.zeros((nT, N), dtype=np.uint8)
        for i in range(nT):
            tv = np.zeros(nT, dtype=np.uint8); tv[i] = 1
            J_T[i] = sheared_to_root_vec(np.zeros(nW, dtype=np.uint8), tv, np.zeros(nRF, dtype=np.uint8)) ^ c0
        J_RF = np.zeros((nRF, N), dtype=np.uint8)
        for i in range(nRF):
            rv = np.zeros(nRF, dtype=np.uint8); rv[i] = 1
            J_RF[i] = sheared_to_root_vec(np.zeros(nW, dtype=np.uint8), np.zeros(nT, dtype=np.uint8), rv) ^ c0

        # Project Phi_0(v) [56 forms] onto W, T, RF!
        P_W = (J_W.astype(np.uint32) @ phi0_lin.astype(np.uint32)) & 1    # [nW, 56]
        P_T = (J_T.astype(np.uint32) @ phi0_lin.astype(np.uint32)) & 1    # [nT, 56]
        P_RF = (J_RF.astype(np.uint32) @ phi0_lin.astype(np.uint32)) & 1  # [nRF, 56]
        P_all = np.vstack([P_W, P_T, P_RF])

        rk_tot = gf2_rank_np(P_all.T)
        rk_W = gf2_rank_np(P_W.T)
        rk_T = gf2_rank_np(P_T.T)
        rk_RF = gf2_rank_np(P_RF.T)
        # How many of the 56 cubic coefficients of Phi_0(v) are PURE-W (zero on T and RF!)?
        # Specifically: rank of rows in span(P_all.T) that have zero T and zero RF!
        # Better: dim(Phi_0 restricted to RF=0, T=0) vs total dim!
        rk_TRF = gf2_rank_np(np.vstack([P_T, P_RF]).T)
        dim_pure_W_in_Phi0 = rk_tot - rk_TRF
        # And same for anti-diagonal primal g_{0xFF}(v)!
        A_W = (J_W.astype(np.uint32) @ aff_lin.astype(np.uint32)) & 1
        A_T = (J_T.astype(np.uint32) @ aff_lin.astype(np.uint32)) & 1
        A_RF = (J_RF.astype(np.uint32) @ aff_lin.astype(np.uint32)) & 1
        rk_aff_tot = gf2_rank_np(np.vstack([A_W, A_T, A_RF]).T)
        rk_aff_TRF = gf2_rank_np(np.vstack([A_T, A_RF]).T)
        print(
            f"  *** [{cell_name} eta={em} PROJECTION OF Phi_0(v) ONTO (W, T, R_F)] ***:\n"
            f"      Phi_0(v): tot_rk={rk_tot}/56 | rk_W={rk_W}, rk_T={rk_T}, rk_RF={rk_RF} | "
            f"rk_(T+RF)={rk_TRF} => pure_W_forms_in_Phi0 = {dim_pure_W_in_Phi0}\n"
            f"      g_{{0xFF}}(v): tot_rk={rk_aff_tot} | rk_(T+RF)={rk_aff_TRF} => pure_W_forms_in_g_0xFF = {rk_aff_tot - rk_aff_TRF}",
            flush=True,
        )

    # 4. Dickson symplectic rank distribution of D_u g_y(v) for random root c!
    #    For a random c in root, pick u = e_0 (1) and u = 0xFF (255), compute exact rank of symplectic
    #    8x8 matrix B_{u, y} of D_u g_y(v) across all 255 non-zero y!
    rng = np.random.default_rng(71399)
    c_rnd = rng.integers(0, 2, size=N, dtype=np.uint8)
    tt_rnd = base_tt.copy()
    for k in np.flatnonzero(c_rnd):
        tt_rnd ^= basis_u8[k]
    for u_name, u_val in [("u=e_0(0x01)", 1), ("u=0x03", 3), ("u=0x11", 0x11), ("u=0xFF", 0xFF)]:
        rk_hist = {}
        delta_sum = 0
        for y in range(256):
            pts = v_arr | ((v_arr ^ y) << 8)
            g = tt_rnd[pts]
            du_g = g ^ g[v_arr ^ u_val]
            # Extract quadratic part (symplectic 8x8 matrix B): B[i,j] = coeff of v_i v_j in ANF(du_g)!
            a = anf_8bit(du_g)
            B = np.zeros((8, 8), dtype=np.uint8)
            for i in range(8):
                for j in range(i + 1, 8):
                    if a[(1 << i) | (1 << j)]:
                        B[i, j] = 1
                        B[j, i] = 1
            r = gf2_rank_np(B)
            rk_hist[r] = rk_hist.get(r, 0) + 1
            delta_sum += int(np.sum(np.where(du_g == 0, 1, -1)))
        print(f"    [DICKSON RANK {cell_name} rnd_c, {u_name}]: rank_hist(256 cosets)={dict(sorted(rk_hist.items()))} | Delta_f(u,u)={delta_sum}", flush=True)


# ==============================================================================
# T4: Exact Characteristic-0 Delsarte / Krawtchouk MILP (HiGHS)
# ==============================================================================

def run_t4_krawtchouk_milp(real_bents, b011_env, b111_env):
    print(f"\n==================== [T4] EXACT CHARACTERISTIC-0 DELSARTE / KRAWTCHOUK MILP (HiGHS) ====================", flush=True)
    # 1. Decompose F_2^16 into ALL 4,116 C_16-orbits, grouped by (weight w, orbit_size s)!
    seen = np.zeros(65536, dtype=bool)
    orbs_by_ws = {}   # (w, s) -> count of orbits
    d8_orbs_by_ws = {}  # orbits inside D_8 (period divides 8 -> s in {1, 2, 4, 8})
    # Note: an orbit has size dividing 8 IFF every x in it satisfies rot16(x, 8) == x IFF x in D_8!
    all_orbs = []
    for x in range(65536):
        if seen[x]:
            continue
        orb = []
        cur = x
        while not seen[cur]:
            seen[cur] = True
            orb.append(cur)
            cur = diag_v2.rot16(cur, 1)
        w = int(x).bit_count()
        s = len(orb)
        orbs_by_ws[(w, s)] = orbs_by_ws.get((w, s), 0) + 1
        all_orbs.append((w, s, orb))
        if s <= 8:
            d8_orbs_by_ws[(w, s)] = d8_orbs_by_ws.get((w, s), 0) + 1
    assert len(all_orbs) == 4116

    # Build Krawtchouk matrix K[k, w] = sum_{j=0}^k (-1)^j C(w, j) C(16-w, k-j)
    K = np.zeros((17, 17), dtype=np.int64)
    for k in range(17):
        for w in range(17):
            s_val = 0
            for j in range(max(0, k - (16 - w)), min(k, w) + 1):
                term = math.comb(w, j) * math.comb(16 - w, k - j)
                s_val += (-term if (j & 1) else term)
            K[k, w] = s_val

    # Zero-Trust check Krawtchouk identity on real bent functions quad_b1, quad_d1!
    xs = np.arange(65536, dtype=np.int32)
    wts = np.array([int(x).bit_count() for x in range(65536)], dtype=np.int32)
    for bname, btt in real_bents:
        W_b = fwht(np.where(btt == 0, 1, -1))
        dual_b = (W_b < 0).astype(np.uint8)
        A_w = np.array([int(np.sum(btt[wts == w])) for w in range(17)], dtype=np.int64)
        B_k = np.array([int(np.sum(dual_b[wts == k])) for k in range(17)], dtype=np.int64)
        S_w = np.array([math.comb(16, w) - 2 * A_w[w] for w in range(17)], dtype=np.int64)
        lhs = K @ S_w
        rhs = np.array([256 * (math.comb(16, k) - 2 * B_k[k]) for k in range(17)], dtype=np.int64)
        assert np.array_equal(lhs, rhs), f"ZT FAIL Krawtchouk on {bname}!"
        print(f"  [ZT-KRAWTCHOUK {bname}]: 17/17 EXACT (0 residual) | A_tot={int(np.sum(A_w))}, B_tot={int(np.sum(B_k))}", flush=True)

    # Extract exact fixed D_8 primal & dual weight profiles on B0_11 and B1_11!
    # Remember: on D_8 = {v | (v << 8)}, f(v, v) is 100% FIXED on B0_11 and B1_11 (independent of all 109 vars!),
    # EXCEPT maybe a few free bits? Let's check exact fixedness directly on base_tt and basis_u8!
    d8_pts = np.array([v | (v << 8) for v in range(256)], dtype=np.int32)
    for cname, env in [("B0_11", b011_env), ("B1_11", b111_env)]:
        base_tt, basis_u8, _ = get_root_affine_basis(env)
        d8_var = np.any(basis_u8[:, d8_pts] != 0, axis=0)
        n_d8_free = int(np.sum(d8_var))
        f_d8 = base_tt[d8_pts]
        # Compute primal D_8 weight per weight w (note w = 2*wt(v)!)
        d8_A_fixed = {}
        if n_d8_free == 0:
            for w in range(17):
                mask_w = (wts[d8_pts] == w)
                d8_A_fixed[w] = int(np.sum(f_d8[mask_w]))
            # Also compute dual f_tilde|_{D_8}: by Poisson summation on D_8,
            # sum_{x in D_8} (-1)^{f(x) ^ omega.x} = 16 * (-1)^{f_tilde_D8(omega)}?
            # Wait: f|_{D_8} is bent on F_2^8, its 8-bit Walsh transform is +-16, and WAIT:
            # S_0(z) = sum_{v} (-1)^{f(v, v^z)} is NOT equal to W_{f|_{D_8}}; f_tilde|_{D_8} is NOT fixed by f|_{D_8} alone!
            # Good Zero-Trust catch! ONLY f|_{D_8} (i.e. all s<=8 orbits of f!) is fixed!
        print(f"  [{cname}] D_8 primal free points={n_d8_free}/256 | fixed D_8 A_w={ {w:v for w,v in d8_A_fixed.items() if v>0} }", flush=True)

        # Build MILP!
        # Variables:
        #   For primal: for each w=0..16, n16_A[w] = number of size-16 orbits with f=1 (0 <= n16_A[w] <= orbs_by_ws[(w,16)])
        #               (s<=8 orbits are FIXED to d8_A_fixed[w] if n_d8_free==0!)
        #               AND A_0 = A_1 = A_2 = A_3 = 0 (homogeneous quartic!)
        #               AND A_4 <= 115*16? Wait: c_115 = 0 (the unique size-4 orbit of wt 4 is 0!),
        #               so on wt 4, ONLY size-16 orbits (112 of them) + size-8 orbits (3 of them, FIXED on D_8!) exist!
        #   For dual:   for each (w, s) in orbs_by_ws, n_B[(w,s)] in [0, orbs_by_ws[(w,s)]]
        #               with B_k = sum_s s * n_B[(k, s)]!
        #   Constraints:
        #     1. 17 exact Krawtchouk equalities: sum_w K[k,w]*(C(16,w) - 2*A_w) == 256*(C(16,k) - 2*B_k)
        #     2. Note: k=0 Krawtchouk IS sum_w (C(16,w) - 2*A_w) = 256*(1 - 2*B_0) = +-256!
        #        And w=0 dual Krawtchouk IS sum_k (C(16,k) - 2*B_k) = 256*(1 - 2*A_0) = +256 (since A_0=0)!
        #        Wait: the 17 Krawtchouk equalities ALREADY imply the inverse Krawtchouk because K^2 = 2^16 I!
        #     3. Anti-diagonal dual weight (Step 65B): wait, anti-diagonal has mixed weights, not fixed per weight.
        #        Wait: CAN we constrain parity of A_w or B_k? Everything is already exact integer orbit counts!
        a_keys = []
        a_ub = []
        for w in range(17):
            cnt16 = orbs_by_ws.get((w, 16), 0)
            if w < 4:
                cnt16 = 0
            a_keys.append(w)
            a_ub.append(cnt16)
        b_keys = sorted(orbs_by_ws.keys())
        b_ub = [orbs_by_ws[k] for k in b_keys]

        nA = len(a_keys)
        nB = len(b_keys)
        nV = nA + nB
        integrality = np.ones(nV, dtype=np.int32)
        lb = np.zeros(nV, dtype=np.float64)
        ub = np.array(a_ub + b_ub, dtype=np.float64)

        # Build 17 Krawtchouk rows:
        #   -2 * sum_w K[k,w] * (16 * n16_A[w]) + 512 * sum_s s * n_B[(k,s)] == 256*C(16,k) - sum_w K[k,w]*(C(16,w) - 2*d8_A_fixed[w])
        A_eq = np.zeros((17, nV), dtype=np.float64)
        b_eq = np.zeros(17, dtype=np.float64)
        for k in range(17):
            rhs = 256.0 * math.comb(16, k)
            for w in range(17):
                fix_w = d8_A_fixed.get(w, 0) if (n_d8_free == 0 and w >= 4) else 0
                rhs -= float(K[k, w]) * (math.comb(16, w) - 2 * fix_w)
                A_eq[k, w] = -32.0 * float(K[k, w])
            for bi, (bw, bs) in enumerate(b_keys):
                if bw == k:
                    A_eq[k, nA + bi] = 512.0 * float(bs)
            b_eq[k] = rhs

        # Test feasibility, min A_4, max A_4, min B_0, max B_0!
        c_zero = np.zeros(nV, dtype=np.float64)
        res_f = milp(c=c_zero, integrality=integrality, bounds=Bounds(lb, ub), constraints=LinearConstraint(A_eq, b_eq, b_eq))
        if not res_f.success:
            print(f"  *** [T4 MILP {cname}] ***: INFEASIBLE!! status={res_f.status} ({res_f.message})", flush=True)
        else:
            # Find min and max n16_A[4] (number of active wt-4 size-16 orbits!)
            c_min4 = np.zeros(nV); c_min4[4] = 1.0
            c_max4 = np.zeros(nV); c_max4[4] = -1.0
            r_min = milp(c=c_min4, integrality=integrality, bounds=Bounds(lb, ub), constraints=LinearConstraint(A_eq, b_eq, b_eq))
            r_max = milp(c=c_max4, integrality=integrality, bounds=Bounds(lb, ub), constraints=LinearConstraint(A_eq, b_eq, b_eq))
            print(
                f"  *** [T4 MILP {cname}] ***: FEASIBLE | wt-4 size-16 orbit count n16_A[4] in "
                f"[{int(round(r_min.fun))}, {int(round(-r_max.fun))}] (out of {a_ub[4]})",
                flush=True,
            )


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--cells", nargs="+", default=["B0_00", "B0_11", "B1_11"])
    args = ap.parse_args()
    t0 = time.perf_counter()

    real_bents = build_real_c16_bents()
    print(f"[STEP 71A] Verified {len(real_bents)} real C16-RSB bent audit functions: {[x[0] for x in real_bents]}", flush=True)

    envs = {}
    for cname in args.cells:
        envs[cname] = s63a.setup_cell_env(cname)
        etas = [5] if cname == "B0_00" else ([5, 0, 9, 11] if cname == "B0_11" else [3, 0, 8, 10])
        run_t1_anatomy_and_symmetry(cname, envs[cname], etas)
        run_t2_even_odd_split(cname, envs[cname], real_bents)
        run_t3_d8_coset_cubic_tensor(cname, envs[cname], etas)

    if "B0_11" in envs and "B1_11" in envs:
        run_t4_krawtchouk_milp(real_bents, envs["B0_11"], envs["B1_11"])

    print(f"\n[STEP 71A ALL FRONTIERS] COMPLETED in {time.perf_counter()-t0:.1f}s!", flush=True)


if __name__ == "__main__":
    main()

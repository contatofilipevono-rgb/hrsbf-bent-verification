#!/usr/bin/env python3
r"""
SOLVE_STEP38C_LOCAL_PUREMATH_PROBES.py

FAST LOCAL PURE-MATH PROBES (no gcc needed, pure Python/NumPy) on B0_11 and B1_11:
  PROBE 1: Exact 2-adic Parseval on D_8-cosets: P(f) = sum_{z != 0} sz(z) * S_{D_8}(z)^2 == 65536 - S(0)^2.
           Checks exact 2-adic valuation & algebraic degree of (P(f) - target) mod 2^k!
  PROBE 2: Transverse 8-dim subspace H_even = {x_1=x_3=...=x_15=0} (C_8-symmetric, H_even^perp = S(H_even)!).
           Checks deg(f|_{H_even}), S_{H_even}(z) valuations, and C_8-orbit Walsh congruences on H_even!
  PROBE 3: 2-adic Autocorrelation Delta_f(a) = sum_x (-1)^{f(x) + f(x+a)} == 0 for representative
           C_16-orbits of a != 0 (in U_1, U_2, U_4, D_8, H_even, weight 1,2,4,8)!
           Checks exact 2-adic valuation & algebraic degree of lowest non-constant bit of Delta_f(a)!
  PROBE 4: Exact Z_16^* = {1,3,5,7,9,11,13,15} action on B0_11 / B1_11 orbit space (fixed subspace dim,
           Loewy filtration dimensions under tau=pi_15, sigma=pi_9, rho=pi_3, full Z_16^*).
"""

import random
import sys
import time
from pathlib import Path
import numpy as np

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_B09_DUAL_S_ELIM as b09
import SOLVE_STEP36_C8_ORBIT_WALSH_KERNEL_LOCAL as s36


def fwht_inplace(a):
    """Fast Walsh-Hadamard Transform in-place on 1D int64 numpy array of length 2^n."""
    n = a.shape[0]
    h = 1
    while h < n:
        x = a.reshape(-1, 2 * h)
        u = x[:, :h].copy()
        v = x[:, h:]
        x[:, :h] = u + v
        x[:, h:] = u - v
        h *= 2
    return a


def test_deg_le(eval_fn, rand_pt, rand_dir, deg, n_trials=6, rng=None):
    """Test if Boolean function eval_fn(x) has algebraic degree <= deg via (deg+1)-th finite difference."""
    k = deg + 1
    for _ in range(n_trials):
        base = rand_pt(rng)
        dirs = [rand_dir(rng) for _ in range(k)]
        s = 0
        for mask in range(1 << k):
            pt = base
            for b in range(k):
                if (mask >> b) & 1:
                    pt ^= dirs[b]
            s ^= eval_fn(pt)
        if s != 0:
            return False
    return True


def main():
    t0 = time.perf_counter()
    orbits = diag_v2.build_orbits_116()
    X = np.arange(65536, dtype=np.uint16)
    orb_tt = np.zeros((116, 65536), dtype=np.uint8)
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for m in orb:
            acc ^= ((X & m) == m).astype(np.uint8)
        orb_tt[j] = acc

    # Precompute C_8 orbits on F_2^8
    seen_c8 = set()
    c8_orbs = []
    for b in range(256):
        if b in seen_c8: continue
        orb, cur = [], b
        while cur not in seen_c8:
            seen_c8.add(cur); orb.append(cur)
            cur = ((cur << 1) | (cur >> 7)) & 0xFF
        c8_orbs.append(orb)
    z_reps = [o[0] for o in c8_orbs]
    z_sz = np.array([len(o) for o in c8_orbs], dtype=np.int64)
    pts_d8 = [np.array([u | ((u ^ z) << 8) for u in range(256)], dtype=np.uint16) for z in z_reps]

    # Precompute H_even cosets: y in H_even = even bit positions 0,2,4,6,8,10,12,14; z in H_odd = odd positions 1,3,...,15
    def spread_bits(v):
        out = 0
        for b in range(8):
            if (v >> b) & 1:
                out |= (1 << (2 * b))
        return out
    even_pts = np.array([spread_bits(u) for u in range(256)], dtype=np.uint16)
    pts_heven = [even_pts ^ (spread_bits(z) << 1) for z in z_reps]

    # Precompute C_8 Walsh matrix A_c8
    A_c8 = np.array([[sum(-1 if ((b & z).bit_count() & 1) else 1 for b in orb) for orb in c8_orbs] for z in z_reps], dtype=np.int64)
    orb_b0_par = np.array([sum(b & 1 for b in o) & 1 for o in c8_orbs], dtype=np.int64)

    # Known quartic Maiorana-McFarland bent function for Zero-Trust check!
    # f_mm(u, v) = <u, pi(v)> + g(v), where pi is a deg-3 permutation on F_2^8 (e.g. v^3 in GF(2^8) is deg-2 -> f_mm is deg-3;
    # or v^7 in GF(2^8) which has gcd(7, 255)=1 -> permutation of deg 3! So <u, v^7> is quartic bent!)
    def gf256_mul(a, b):
        r = 0
        for _ in range(8):
            if b & 1: r ^= a
            hi = a & 0x80
            a = (a << 1) & 0xFF
            if hi: a ^= 0x1B
            b >>= 1
        return r
    mm_tt = np.zeros(65536, dtype=np.uint8)
    for v in range(256):
        v2 = gf256_mul(v, v)
        v3 = gf256_mul(v2, v)
        v4 = gf256_mul(v2, v2)
        v7 = gf256_mul(v4, v3)
        for u in range(256):
            mm_tt[u | (v << 8)] = (u & v7).bit_count() & 1
    # Verify mm_tt is genuinely bent (all |W| == 256)
    w_mm = 1 - 2 * mm_tt.astype(np.int64)
    fwht_inplace(w_mm)
    assert np.all(np.abs(w_mm) == 256), "MM function not bent!"
    # Verify autocorrelation of mm_tt is 0 for all a != 0
    ac_mm = fwht_inplace((w_mm * w_mm).copy()) // 65536
    assert ac_mm[0] == 65536 and np.all(ac_mm[1:] == 0)
    print("Zero-Trust check: quartic MM bent function verified (all |W|=256, all AC(a!=0)=0).", flush=True)

    for cell_name, (c99, c57, c113) in [("B0_11", (0, 1, 1)), ("B1_11", (1, 1, 1))]:
        print(f"\n==================== [{cell_name}] LOCAL PURE-MATH PROBES ====================", flush=True)
        free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
        orig_tt = np.zeros(65536, dtype=np.uint8)
        for o in range(116):
            if (origin111 >> o) & 1: orig_tt ^= orb_tt[o]
        b_tt = np.zeros((111, 65536), dtype=np.uint8)
        for i in range(111):
            acc = np.zeros(65536, dtype=np.uint8)
            for o in range(116):
                if (cb111[i] >> o) & 1: acc ^= orb_tt[o]
            b_tt[i] = acc

        def tt_of(x111):
            tt = orig_tt.copy()
            tmp = x111
            while tmp:
                lb = tmp & -tmp
                tt ^= b_tt[lb.bit_length() - 1]
                tmp ^= lb
            return tt

        rng = random.Random(3800 + c99)
        pts = [rng.getrandbits(111) for _ in range(40)]
        tts = [tt_of(x) for x in pts]

        # PROBE 1: PARSEVAL ON D_8 COSETS
        print("  --- PROBE 1: 2-ADIC PARSEVAL ON D_8 COSETS ---", flush=True)
        S0_target = 128 if cell_name == "B0_11" else -64
        P_target = 65536 - S0_target * S0_target
        P_vals = []
        S_all = np.zeros((len(tts), 36), dtype=np.int64)
        for i, tt in enumerate(tts):
            for zi in range(36):
                S_all[i, zi] = 256 - 2 * int(tt[pts_d8[zi]].sum())
            assert S_all[i, 0] == S0_target
            P_vals.append(int(np.sum(z_sz[1:] * (S_all[i, 1:] ** 2))))
        diffs = [p - P_target for p in P_vals]
        # Find minimum 2-adic valuation of diffs
        nz_diffs = [abs(d) for d in diffs if d != 0]
        min_v2 = min((d & -d).bit_length() - 1 for d in nz_diffs) if nz_diffs else 99
        print(f"    P_target = {P_target} | min v2(P(f) - P_target) = {min_v2} (2^{min_v2} = {1<<min_v2})", flush=True)
        for k in range(min_v2, min_v2 + 5):
            bits = [(d >> k) & 1 for d in diffs]
            print(f"      bit {k:2d} (mod {1<<(k+1):5d}): ones={sum(bits)}/{len(bits)}", flush=True)
        # Check exact algebraic degree of bit min_v2 and min_v2+1 of (P(f) - P_target)!
        def eval_parseval_bit(x111, bit_k):
            tt = tt_of(x111)
            p = 0
            for zi in range(1, 36):
                s = 256 - 2 * int(tt[pts_d8[zi]].sum())
                p += int(z_sz[zi]) * s * s
            return ((p - P_target) >> bit_k) & 1

        rand_pt = lambda rg: rg.getrandbits(111)
        for bk in [min_v2, min_v2 + 1]:
            found_d = ">4"
            for d in [1, 2, 3, 4]:
                if test_deg_le(lambda x, bk=bk: eval_parseval_bit(x, bk), rand_pt, rand_pt, d, n_trials=4, rng=random.Random(900 + bk * 10 + d)):
                    found_d = f"<= {d}"
                    break
            print(f"      Algebraic degree of Parseval bit {bk} ((P - {P_target}) >> {bk} & 1): {found_d}", flush=True)

        # PROBE 2: TRANSVERSE 8-DIM SUBSPACE H_even
        print("  --- PROBE 2: TRANSVERSE 8-DIM SUBSPACE H_even ---", flush=True)
        # Check ANF degree of f|_{H_even} on 5 random points
        def anf_deg8(vec256):
            a = vec256.copy()
            for b in range(8):
                step = 1 << b
                for i in range(0, 256, 2 * step):
                    a[i + step:i + 2 * step] ^= a[i:i + step]
            degs = [i.bit_count() for i in range(256) if a[i]]
            return max(degs) if degs else -1
        h_degs = [anf_deg8(tt[even_pts]) for tt in tts[:5]]
        S_he = np.zeros((len(tts), 36), dtype=np.int64)
        for i, tt in enumerate(tts):
            for zi in range(36):
                S_he[i, zi] = 256 - 2 * int(tt[pts_heven[zi]].sum())
        S_he0_vals = sorted(set(int(v) for v in S_he[:, 0]))
        v2_he = [min(((int(v) & -int(v)).bit_length() - 1) for v in S_he[:, zi] if v != 0) if np.any(S_he[:, zi] != 0) else 99 for zi in range(36)]
        print(f"    deg(f|_Heven) = {h_degs} | S_Heven(0) unique vals (40 pts) = {S_he0_vals[:12]} (n={len(S_he0_vals)})", flush=True)
        print(f"    min v2(S_Heven(z)) across 36 C_8 orbits: min={min(v2_he)}, max={max(v2_he)}, hist={dict(zip(*np.unique(v2_he, return_counts=True)))}", flush=True)
        # Check C_8-orbit Walsh kernel congruences on H_even!
        for MOD in (16, 32, 64):
            A_ext = np.vstack([A_c8, (MOD // 2) * orb_b0_par])
            ker = s36.mod_rref_kernel(A_ext, MOD)
            vs = [k[:36] % MOD for k in ker if np.any(k[:36] % MOD != 0)]
            n_nonconst, n_twoval = 0, 0
            for v in vs:
                vals = (S_he @ v) % (2 * MOD)
                uniq = sorted(set(int(u) for u in vals))
                if len(uniq) > 1:
                    n_nonconst += 1
                    if len(uniq) == 2 and ((uniq[1] - uniq[0]) % (2 * MOD) == MOD):
                        n_twoval += 1
            print(f"    [H_even MOD={MOD:2d}] ker={len(vs):2d}, nonconst={n_nonconst:2d}, exact-bit-congruences={n_twoval:2d}", flush=True)

        # PROBE 3: 2-ADIC AUTOCORRELATION Delta_f(a) == 0 FOR KEY C_16-ORBITS OF a != 0!
        print("  --- PROBE 3: 2-ADIC AUTOCORRELATION Delta_f(a) == 0 ---", flush=True)
        # Compute full autocorrelation spectrum for all 40 random points via FWHT!
        ac_mat = np.zeros((len(tts), 65536), dtype=np.int64)
        for i, tt in enumerate(tts):
            w = 1 - 2 * tt.astype(np.int64)
            fwht_inplace(w)
            ac = fwht_inplace(w * w) // 65536
            ac_mat[i] = ac
        test_as = [
            ("0xFFFF (U1, D8)", 0xFFFF),
            ("0x5555 (U2, D8)", 0x5555),
            ("0x1111 (U4, D8)", 0x1111),
            ("0x3333 (U4, D8)", 0x3333),
            ("0x0101 (wt2, D8)", 0x0101),
            ("0x0303 (wt4, D8)", 0x0303),
            ("0x00FF (wt8, non-D8)", 0x00FF),
            ("0x55AA (wt8, non-D8)", 0x55AA),
            ("0x0F0F (wt8, U4?)", 0x0F0F),
            ("0x0001 (wt1)", 0x0001),
            ("0x0003 (wt2 adj)", 0x0003),
            ("0x0005 (wt2 Heven)", 0x0005),
            ("0x0009 (wt2)", 0x0009),
            ("0x0011 (wt2)", 0x0011),
            ("0x5500 (Heven?)", 0x5500),
            ("0x0055 (wt4 Heven)", 0x0055),
        ]
        for lbl, a_val in test_as:
            col = ac_mat[:, a_val]
            nz = [abs(int(v)) for v in col if v != 0]
            if not nz:
                print(f"    a={lbl:22s}: IDENTICALLY ZERO on all 40 pts!", flush=True)
            else:
                mv2 = min((v & -v).bit_length() - 1 for v in nz)
                # Test algebraic degree of bit mv2 of Delta_f(a)!
                def eval_ac_bit(x111, av=a_val, bk=mv2):
                    tt = tt_of(x111)
                    d = tt ^ tt[X ^ av]
                    # Delta_f(a) = 65536 - 2 * wt(d)
                    val = 65536 - 2 * int(d.sum())
                    return (val >> bk) & 1
                deg_str = ">4"
                for dg in [1, 2, 3, 4]:
                    if test_deg_le(eval_ac_bit, rand_pt, rand_pt, dg, n_trials=4, rng=random.Random(7000 + a_val + dg)):
                        deg_str = f"<= {dg}"
                        break
                print(f"    a={lbl:22s}: min_v2={mv2:2d} (2^{mv2:2d}={1<<mv2:5d}) | deg(bit {mv2}) = {deg_str}", flush=True)

        # Check ALL 65535 nonzero a for ANY with deg <= 3 or unusually high min_v2?
        # Quick scan of min_v2 across all a != 0:
        nz_mask = (ac_mat[:, 1:] != 0)
        always_zero = int(np.sum(~np.any(nz_mask, axis=0)))
        # Compute min_v2 per a over the 40 pts
        abs_ac = np.abs(ac_mat[:, 1:])
        # Lowest bit via a & -a; replace 0 with 1<<20
        lowbit = np.where(abs_ac == 0, 1 << 20, abs_ac & (-abs_ac))
        min_lb = np.min(lowbit, axis=0)
        vals_lb, cnts_lb = np.unique(min_lb, return_counts=True)
        hist_str = ", ".join(f"2^{(int(v).bit_length()-1)}:{int(c)}" for v, c in zip(vals_lb, cnts_lb))
        print(f"    ALL 65535 a!=0 scan: always_zero={always_zero} | min_v2 hist = {{{hist_str}}}", flush=True)

    # PROBE 4: Z_16^* ACTION ON THE 111-VAR SPACE
    print("\n--- PROBE 4: Z_16^* FIXED SUBSPACE & LOEWY DIMENSIONS ON 111 VARS ---", flush=True)
    orb_of_mon = {m: j for j, orb in enumerate(orbits) for m in orb}
    def perm_mon(m, k):
        out = 0
        for i in range(16):
            if (m >> i) & 1: out |= (1 << ((k * i) & 15))
        return out
    for k in [3, 5, 7, 9, 11, 13, 15]:
        p = [orb_of_mon[perm_mon(orbits[j][0], k)] for j in range(116)]
        # Count cycles on the 111 free orbits (excluding 0, 57, 99, 113, 115)
        free_set = [j for j in range(116) if j not in (0, 57, 99, 113, 115)]
        vis = set()
        cycs = []
        for j in free_set:
            if j in vis: continue
            c, cur = [], j
            while cur not in vis:
                vis.add(cur); c.append(cur); cur = p[cur]
            cycs.append(len(c))
        print(f"    k={k:2d}: fixed_dim={len(cycs):3d} (cycle lens: {dict(zip(*np.unique(cycs, return_counts=True)))})", flush=True)
    # Full Z_16^* orbits on the 111 free orbits
    vis = set()
    full_orbs = []
    free_set = [j for j in range(116) if j not in (0, 57, 99, 113, 115)]
    perms = {k: [orb_of_mon[perm_mon(orbits[j][0], k)] for j in range(116)] for k in [1, 3, 5, 7, 9, 11, 13, 15]}
    for j in free_set:
        if j in vis: continue
        o = sorted({perms[k][j] for k in perms})
        vis |= set(o)
        full_orbs.append(len(o))
    print(f"    FULL Z_16^* (order 8): fixed_dim (orbits on 111 vars) = {len(full_orbs)} (sizes: {dict(zip(*np.unique(full_orbs, return_counts=True)))})", flush=True)
    print(f"\nALL LOCAL PROBES DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()

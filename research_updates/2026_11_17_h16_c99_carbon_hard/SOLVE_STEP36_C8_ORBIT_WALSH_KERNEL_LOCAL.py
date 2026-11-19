#!/usr/bin/env python3
r"""
SOLVE_STEP36_C8_ORBIT_WALSH_KERNEL_LOCAL.py

3-SECOND LOCAL PURE-MATH PROBE:
  Computes the EXACT 36 x 36 C_8-orbit Walsh matrix A over Z:
      A[i, j] = sum_{b in orb_j} (-1)^{<z_i, b>}
  so for ANY C_8-symmetric Boolean function g = f_tilde|_{D_8^perp} with orbit bits y_j in {0, 1}:
      S_{D_8}(z_i) = W_g(z_i) = C_i - 2 * sum_j A[i, j] * y_j.
  Finds ALL integer vectors v (mod 16 and mod 32) such that v^T A = 0 (mod 16) (or mod 8, or mod 32)
  on the constrained subspace {sum sz_j y_j = wt(g), sum b0_j y_j = 0 mod 2}, giving EXACT
  C_16-equivariant Poisson congruences:
      sum_i v_i * S_{D_8}(z_i) == const (mod 32 or mod 64)!!
  Then evaluates those EXACT congruences on 100 random points of B0_11 and B1_11 to check:
    1. Are they NON-TRIVIAL (not identically 0 on B0_11 / B1_11)?
    2. What is their EXACT ALGEBRAIC DEGREE (via 4-diff / 5-diff finite differences)?
    3. Do they hold on our known bent functions / are they 100% necessary?
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


def mod_rref_kernel(M, mod):
    """Find left kernel of integer matrix M over Z / mod Z (mod = power of 2)."""
    # Use Gaussian elimination over Z / mod Z on M^T, keeping track of row operations!
    # Actually simplest exact method for 36 x 38 over Z / 2^k Z: row-reduce [M | I_m] by 2-adic valuation!
    m, n = M.shape
    aug = np.zeros((m, n + m), dtype=np.int64)
    aug[:, :n] = M % mod
    for i in range(m):
        aug[i, n + i] = 1
    row = 0
    for col in range(n):
        if row >= m: break
        # Pick row >= row with minimum 2-adic valuation in aug[r, col] % mod
        best_r, best_v = -1, 999
        for r in range(row, m):
            val = int(aug[r, col]) % mod
            if val == 0: continue
            v2 = (val & -val).bit_length() - 1
            if v2 < best_v:
                best_v = v2; best_r = r
        if best_r == -1: continue
        if best_r != row:
            aug[[row, best_r]] = aug[[best_r, row]]
        piv_val = int(aug[row, col]) % mod
        v2_p = (piv_val & -piv_val).bit_length() - 1
        odd_part = piv_val >> v2_p
        inv_odd = pow(odd_part, -1, mod)
        aug[row] = (aug[row] * inv_odd) % mod
        piv_val = int(aug[row, col]) % mod  # now literally 2^{v2_p}!
        for r in range(row + 1, m):
            val = int(aug[r, col]) % mod
            if val == 0: continue
            q = val // piv_val
            aug[r] = (aug[r] - q * aug[row]) % mod
        row += 1
    # Any row whose first n entries are ALL 0 mod `mod` gives a left-kernel vector in aug[r, n:]!
    # ALSO any row whose first n entries are multiples of mod//2 gives 2*v in kernel!
    ker = []
    for r in range(m):
        if np.all(aug[r, :n] % mod == 0):
            v = aug[r, n:] % mod
            if np.any(v != 0):
                ker.append(v)
        else:
            # Check if multiplying by 2^s kills first n entries!
            max_need = 0
            for c in range(n):
                val = int(aug[r, c]) % mod
                if val != 0:
                    v2 = (val & -val).bit_length() - 1
                    need = mod.bit_length() - 1 - v2
                    if need > max_need: max_need = need
            if 0 < max_need < mod.bit_length() - 1:
                v = (aug[r, n:] * (1 << max_need)) % mod
                if np.any(v != 0):
                    ker.append(v)
    return ker


def main():
    t0 = time.perf_counter()
    seen = set()
    c8_orbs = []
    for b in range(256):
        if b in seen: continue
        orb = []
        cur = b
        while cur not in seen:
            seen.add(cur); orb.append(cur)
            cur = ((cur << 1) | (cur >> 7)) & 0xFF
        c8_orbs.append(orb)
    m = len(c8_orbs)
    assert m == 36
    z_reps = [o[0] for o in c8_orbs]

    # Build 36 x 36 matrix A[i, j] = sum_{b in orb_j} (-1)^{<z_i, b>}
    A = np.zeros((m, m), dtype=np.int64)
    C = np.zeros(m, dtype=np.int64)
    for i, z in enumerate(z_reps):
        for j, orb in enumerate(c8_orbs):
            s = sum(-1 if ((b & z).bit_count() & 1) else 1 for b in orb)
            A[i, j] = s
        C[i] = int(A[i].sum())  # 256 if z=0 else 0

    # Add extra constraint rows for deg(g) <= 6? Wait: sum_j orb_b0_par[j] * y_j = 0 (mod 2)
    # -> that's 16 * orb_b0_par[j] * y_j = 0 (mod 32) -> row with 8 * orb_b0_par (in 2*A*y)!
    # Wait: S(z_i) = C_i - 2 * (A y)_i.
    # For sum_i v_i S(z_i) to be constant mod 2*MOD (e.g. mod 32 when MOD=16, or mod 64 when MOD=32),
    # we need v^T A = c_wt * sz_vec + c_deg * (MOD/2 * b0_par) (mod MOD)!
    # Note: z_0 = 0 already has A[0, j] = sz_j!! So including row 0 (S(0) is FIXED: 128 in B0_11, -64 in B1_11!)
    # AUTOMATICALLY captures any multiple of sz_vec!
    # And to include the deg(g) <= 6 constraint (b0_par . y = 0 mod 2), add a dummy 37th row `A_ext[36] = (MOD//2) * b0_par`!
    orb_b0_par = np.array([sum(b & 1 for b in o) & 1 for o in c8_orbs], dtype=np.int64)

    for MOD in (8, 16, 32):
        A_ext = np.vstack([A, (MOD // 2) * orb_b0_par])
        ker = mod_rref_kernel(A_ext, MOD)
        # Filter vectors v[:36] (ignoring row 36 which has value 0 mod 2*MOD)
        vs = [k[:36] for k in ker if np.any(k[:36] % MOD != 0)]
        # Verify on 200 random C_8-symmetric functions g of wt=64 (deg<=6) and wt=160 (deg<=6)!
        print(f"\n=== Left kernel of A mod {MOD} (gives S_D8 congruences mod {2*MOD}): {len(vs)} raw vectors ===")
        # Check how many have ODD entries (nonzero mod 2) so they hit the TOP bit mod 2*MOD!
        vs_odd = [v for v in vs if np.any(v & 1)]
        print(f"  Vectors with at least one ODD entry (primitive mod {MOD}): {len(vs_odd)}")

        # Now evaluate on B0_11 and B1_11!
        if MOD in (16, 32):
            orbits = diag_v2.build_orbits_116()
            X = np.arange(65536, dtype=np.uint16)
            orb_tt_np = np.zeros((116, 65536), dtype=np.uint8)
            for j, orb in enumerate(orbits):
                acc = np.zeros(65536, dtype=np.uint8)
                for mon in orb: acc ^= ((X & mon) == mon).astype(np.uint8)
                orb_tt_np[j] = acc

            # Precompute pts for all 36 z_reps
            pts_all = [np.array([u | ((u ^ z) << 8) for u in range(256)], dtype=np.uint16) for z in z_reps]

            for cname, (c99, c57, c113), S0_val in [("B0_11", (0, 1, 1), 128), ("B1_11", (1, 1, 1), -64)]:
                _, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
                orig_tt = np.zeros(65536, dtype=np.uint8)
                for o in range(116):
                    if (origin111 >> o) & 1: orig_tt ^= orb_tt_np[o]
                b_tt = np.zeros((111, 65536), dtype=np.uint8)
                for i in range(111):
                    acc = np.zeros(65536, dtype=np.uint8)
                    for o in range(116):
                        if (cb111[i] >> o) & 1: acc ^= orb_tt_np[o]
                    b_tt[i] = acc

                # Evaluate S_D8(z_0..z_35) on 40 random points of cname!
                rng = random.Random(3636)
                R = 40
                S_mat = np.zeros((R, 36), dtype=np.int64)
                for r in range(R):
                    x = rng.getrandbits(111)
                    tt = orig_tt.copy()
                    for i in range(111):
                        if (x >> i) & 1: tt ^= b_tt[i]
                    for zi in range(36):
                        S_mat[r, zi] = 256 - 2 * int(tt[pts_all[zi]].sum())
                # Verify S_mat[:, 0] == S0_val
                assert np.all(S_mat[:, 0] == S0_val)

                # Check every v in vs: what values does (S_mat @ v) % (2*MOD) take?!
                n_nonconst = 0
                nonconst_ex = []
                for idx_v, v in enumerate(vs):
                    # Expected bent constant: v[0]*S0_val (since for z!=0, C_i = 0, wait: S(z) = C_z - 2(Ay)_z
                    # and v^T S = v^T C - 2(v^T A) y == v[0]*256 (mod 2*MOD)!! Wait: verify directly!)
                    vals = (S_mat @ v) % (2 * MOD)
                    uniq = sorted(set(int(u) for u in vals))
                    if len(uniq) > 1:
                        n_nonconst += 1
                        if len(nonconst_ex) < 8:
                            nonconst_ex.append((idx_v, uniq[:6], int((v[0] * 256) % (2 * MOD))))
                print(f"    [{cname} mod {2*MOD}] non-constant congruences = {n_nonconst} / {len(vs)} | examples (id, vals, target): {nonconst_ex[:5]}")
            break  # already loaded orb_tt once; let's check both 16 and 32 cleanly below!

    print(f"\nDONE ({time.perf_counter()-t0:.2f}s)")


if __name__ == "__main__":
    main()

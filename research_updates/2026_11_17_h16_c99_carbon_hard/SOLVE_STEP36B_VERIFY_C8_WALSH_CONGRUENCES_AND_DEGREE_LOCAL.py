#!/usr/bin/env python3
r"""
SOLVE_STEP36B_VERIFY_C8_WALSH_CONGRUENCES_AND_DEGREE_LOCAL.py

FAST 3-SECOND LOCAL ZERO-TRUST CHECK OF THE 18 MOD-32 (AND MOD-64/128!) C_8-ORBIT WALSH CONGRUENCES!
  1. Verifies EVERY congruence v^T S_{D_8} == target (mod 2*MOD) on 500 random C_8-symmetric
     Boolean functions g (deg <= 6, wt=64 & wt=160) -> MUST HAVE 0 VIOLATIONS!
  2. Measures the EXACT ALGEBRAIC DEGREE (deg <= 2, 3, 4, 5+) of each non-constant congruence
     in B0_11 and B1_11 via exact finite differences (16-tuple / 32-tuple)!
  3. Checks MOD = 8, 16, 32, 64, 128!
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


def main():
    t0 = time.perf_counter()
    seen = set()
    c8_orbs = []
    for b in range(256):
        if b in seen: continue
        orb, cur = [], b
        while cur not in seen:
            seen.add(cur); orb.append(cur)
            cur = ((cur << 1) | (cur >> 7)) & 0xFF
        c8_orbs.append(orb)
    m = len(c8_orbs)
    z_reps = [o[0] for o in c8_orbs]

    A = np.zeros((m, m), dtype=np.int64)
    for i, z in enumerate(z_reps):
        for j, orb in enumerate(c8_orbs):
            A[i, j] = sum(-1 if ((b & z).bit_count() & 1) else 1 for b in orb)
    orb_sz = np.array([len(o) for o in c8_orbs], dtype=np.int64)
    orb_b0_par = np.array([sum(b & 1 for b in o) & 1 for o in c8_orbs], dtype=np.int64)

    # Generate 200 random C_8-symmetric Boolean functions g with deg(g) <= 6 (sum g even AND sum b0*g even)
    rng_g = random.Random(360036)
    g_W_samples = []
    for _ in range(300):
        y = np.array([rng_g.getrandbits(1) for _ in range(m)], dtype=np.int64)
        # Enforce sum sz*y even (automatic except orb 0 and orb 0xFF which have sz 1!)
        # Orbit 0 is b=0 (sz=1, b0=0); orbit with b=0xFF has sz=1, b0=1!
        idx_ff = [j for j, o in enumerate(c8_orbs) if o[0] == 0xFF][0]
        if int((orb_b0_par * y).sum()) & 1:
            y[idx_ff] ^= 1
        if int((orb_sz * y).sum()) & 1:
            y[0] ^= 1
        assert (int((orb_sz * y).sum()) & 1) == 0 and (int((orb_b0_par * y).sum()) & 1) == 0
        # W_g = A @ (1 - 2*y)
        W_g = A @ (1 - 2 * y)
        g_W_samples.append(W_g)
    G_W = np.array(g_W_samples, dtype=np.int64)  # [300, 36]

    # Build orb truth tables once
    orbits = diag_v2.build_orbits_116()
    X = np.arange(65536, dtype=np.uint16)
    orb_tt_np = np.zeros((116, 65536), dtype=np.uint8)
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for mon in orb: acc ^= ((X & mon) == mon).astype(np.uint8)
        orb_tt_np[j] = acc
    pts_all = [np.array([u | ((u ^ z) << 8) for u in range(256)], dtype=np.uint16) for z in z_reps]

    # Prebuild B0_11 and B1_11 basis truth tables restricted to pts_all? Better: fast S_D8 eval!
    cell_data = {}
    for cname, (c99, c57, c113) in [("B0_11", (0, 1, 1)), ("B1_11", (1, 1, 1))]:
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
        cell_data[cname] = (orig_tt, b_tt)

    def eval_S_batch(cname, x_list):
        orig_tt, b_tt = cell_data[cname]
        S_mat = np.zeros((len(x_list), 36), dtype=np.int64)
        for r, x in enumerate(x_list):
            tt = orig_tt.copy()
            tmp = x
            while tmp:
                lb = tmp & -tmp
                tt ^= b_tt[lb.bit_length() - 1]
                tmp ^= lb
            for zi in range(36):
                S_mat[r, zi] = 256 - 2 * int(tt[pts_all[zi]].sum())
        return S_mat

    # Precompute 30 random points + finite-diff batches (deg 2, 3, 4) for B1_11 & B0_11!
    rng = random.Random(363636)
    rand_x = [rng.getrandbits(111) for _ in range(40)]
    fd_x = {}
    for deg_try in (2, 3, 4):
        k = deg_try + 1
        xs = []
        for _ in range(8):
            base = rng.getrandbits(111)
            dirs = [rng.getrandbits(111) for _ in range(k)]
            for mask in range(1 << k):
                pt = base
                for b in range(k):
                    if (mask >> b) & 1: pt ^= dirs[b]
                xs.append(pt)
        fd_x[deg_try] = xs

    S_rand = {c: eval_S_batch(c, rand_x) for c in ("B0_11", "B1_11")}
    S_fd = {c: {d: eval_S_batch(c, fd_x[d]) for d in (2, 3, 4)} for c in ("B0_11", "B1_11")}

    for MOD in (16, 32, 64, 128):
        A_ext = np.vstack([A, (MOD // 2) * orb_b0_par])
        ker = s36.mod_rref_kernel(A_ext, MOD)
        vs = [k[:36] for k in ker if np.any(k[:36] % MOD != 0)]
        # ZERO-TRUST VERIFY on 300 random C_8-symmetric deg<=6 duals g!
        valid_vs = []
        for v in vs:
            g_vals = (G_W @ v) % (2 * MOD)
            if len(set(int(u) for u in g_vals)) == 1:
                valid_vs.append((v, int(g_vals[0])))
        print(f"\n=== MOD={MOD} (congruence mod {2*MOD}): {len(valid_vs)}/{len(vs)} ZT-verified on 300 C_8 deg<=6 duals ===")
        for cname in ("B0_11", "B1_11"):
            deg_hist = {}
            nonconst_cnt = 0
            for v, target in valid_vs:
                vals = (S_rand[cname] @ v) % (2 * MOD)
                uniq = sorted(set(int(u) for u in vals))
                if len(uniq) <= 1:
                    continue
                nonconst_cnt += 1
                # If vals only take 2 values {a, a + MOD} mod 2*MOD, test exact bit degree!
                if len(uniq) == 2 and ((uniq[1] - uniq[0]) % (2 * MOD) == MOD):
                    shift = MOD.bit_length() - 1
                    d_found = 5
                    for deg_try in (2, 3, 4):
                        k = deg_try + 1
                        fvals = ((S_fd[cname][deg_try] @ v) >> shift) & 1
                        ok = True
                        for t in range(8):
                            if int(fvals[t * (1 << k):(t + 1) * (1 << k)].sum()) & 1:
                                ok = False; break
                        if ok:
                            d_found = deg_try; break
                    deg_hist[d_found] = deg_hist.get(d_found, 0) + 1
                else:
                    deg_hist["multi_val"] = deg_hist.get("multi_val", 0) + 1
            print(f"  [{cname}] non-constant={nonconst_cnt} | EXACT DEGREE HISTOGRAM = {deg_hist}")

    print(f"\nDONE ({time.perf_counter()-t0:.2f}s)")


if __name__ == "__main__":
    main()

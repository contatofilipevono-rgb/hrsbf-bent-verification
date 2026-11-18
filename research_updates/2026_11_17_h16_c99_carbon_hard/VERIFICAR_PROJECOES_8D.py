#!/usr/bin/env python3
"""
Step 2: Exact 8D subspace projection enumeration for 0x5555 (10 orbits) and
0x3333 (19 orbits) in branch c99=1, plus direct audit of 0xd7 and 0xf5 on
0x3333, 0x0f0f, and 0x00ff.
"""
import ctypes
import json
import subprocess
import time
from itertools import combinations
from pathlib import Path

from VERIFICAR_ALGEBRA_C99_1 import WITNESSES


def build_orbits():
    orbits, seen = [], set()
    for mon in combinations(range(16), 4):
        if mon in seen:
            continue
        orb = sorted({tuple(sorted((j + s) % 16 for j in mon)) for s in range(16)})
        seen.update(orb)
        orbits.append(orb)
    return orbits


def eval_orb_on_subspace(orb, pts):
    tt = [0, 0, 0, 0]
    for k, x in enumerate(pts):
        val = 0
        for a, b, c, d in orb:
            if ((x >> a) & (x >> b) & (x >> c) & (x >> d)) & 1:
                val ^= 1
        if val:
            tt[k >> 6] |= 1 << (k & 63)
    return tt


def main():
    t0 = time.perf_counter()
    base_dir = Path(__file__).resolve().parent
    so_path = base_dir / "libproj8d.so"
    subprocess.run(
        ["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(base_dir / "proj8d_core.c"), "-o", str(so_path)],
        check=True,
    )
    lib = ctypes.CDLL(str(so_path))
    lib.scan_subspace_8d.argtypes = [
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int,
        ctypes.POINTER(ctypes.c_int32),
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64),
    ]

    orbits = build_orbits()
    out = {"subspaces": {}, "witness_8d_checks": {}}

    for name, mask in [("0x5555", 0x5555), ("0x3333", 0x3333), ("0x0f0f", 0x0F0F), ("0x00ff", 0x00FF)]:
        pts = [x for x in range(65536) if (x & mask) == x]
        assert len(pts) == 256
        active_orbs = []
        tts = {}
        for j, orb in enumerate(orbits):
            tt = eval_orb_on_subspace(orb, pts)
            if any(tt):
                active_orbs.append(j)
                tts[j] = tt

        free_orbs = [j for j in active_orbs if j != 99]
        # Note: if 57 and 113 are both active, c57 == c113 merges them!
        if 57 in free_orbs and 113 in free_orbs:
            merged_57 = [tts[57][w] ^ tts[113][w] for w in range(4)]
            free_orbs = [j for j in free_orbs if j not in (57, 113)]
            if any(merged_57):
                free_orbs.append("57^113")
                tts["57^113"] = merged_57

        info = {
            "active_orbits_count": len(active_orbs),
            "active_orbit_ids": active_orbs,
            "effective_free_dim": len(free_orbs),
        }

        if len(free_orbs) <= 18:
            base_tt = (ctypes.c_uint64 * 4)(*(tts[99] if 99 in tts else [0, 0, 0, 0]))
            orb_arr = (ctypes.c_uint64 * (4 * len(free_orbs)))()
            for i, oid in enumerate(free_orbs):
                for w in range(4):
                    orb_arr[4 * i + w] = tts[oid][w]
            hist = (ctypes.c_int32 * 257)()
            p_bnd = ctypes.c_uint64()
            p_m4 = ctypes.c_uint64()
            p_m16 = ctypes.c_uint64()
            lib.scan_subspace_8d(
                orb_arr, base_tt, len(free_orbs), hist,
                ctypes.byref(p_bnd), ctypes.byref(p_m4), ctypes.byref(p_m16),
            )
            info["total_states"] = 1 << len(free_orbs)
            info["pass_bounds_le_256"] = int(p_bnd.value)
            info["pass_mod4"] = int(p_m4.value)
            info["pass_mod16"] = int(p_m16.value)
            info["max_walsh_nonzero_hist"] = {str(v): int(hist[v]) for v in range(257) if hist[v] > 0}

        out["subspaces"][name] = info

        # Audit 0xd7 and 0xf5 on this 8D subspace
        for wn in ("0xd7", "0xf5"):
            cint = WITNESSES[wn]
            tt = [0, 0, 0, 0]
            for j in active_orbs:
                if (cint >> j) & 1:
                    for w in range(4):
                        tt[w] ^= tts[j][w]
            a = [(-1 if ((tt[x >> 6] >> (x & 63)) & 1) else 1) for x in range(256)]
            step = 1
            while step < 256:
                for i in range(0, 256, step << 1):
                    for j in range(step):
                        u, v = a[i + j], a[i + j + step]
                        a[i + j], a[i + j + step] = u + v, u - v
                step <<= 1
            mx = max(abs(v) for v in a)
            out["witness_8d_checks"].setdefault(wn, {})[name] = {
                "W_g_0": a[0],
                "max_abs_W_g": mx,
                "all_even": all(v % 2 == 0 for v in a),
                "mod4_count": sum(1 for v in a if v % 4 == 0),
                "mod16_count": sum(1 for v in a if v % 16 == 0),
            }

    out["elapsed_sec"] = round(time.perf_counter() - t0, 4)
    out_path = base_dir / "proj8d_c99_1_report.json"
    out_path.write_text(json.dumps(out, indent=2), encoding="utf-8")
    print(json.dumps(out, indent=2))


if __name__ == "__main__":
    main()

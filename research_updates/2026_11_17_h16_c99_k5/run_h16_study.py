#!/usr/bin/env python3
"""
Exact exhaustive study of 16-variable quartic homogeneous rotation-symmetric
Boolean functions (HRSBF) in branch c_99 = 1 with exactly 5 active or 5 absent
long orbits, including k=0..4 control reproduction and independent DP counts.
"""
import argparse
import ctypes
import json
import math
import os
import resource
import subprocess
import sys
import time
from concurrent.futures import ProcessPoolExecutor, as_completed
from itertools import combinations
from pathlib import Path

L_INDICES = [0, 4, 8, 14, 18, 22, 42, 46, 52, 56, 71, 81, 85, 94, 98, 106]
K_INDICES = [
    1, 3, 9, 11, 13, 15, 21, 24, 28, 32, 34, 38, 45, 47, 53, 55,
    67, 69, 70, 72, 74, 76, 78, 80, 86, 89, 91, 93, 97, 103, 107, 109,
]
R_INDICES = [
    5, 6, 7, 16, 17, 19, 43, 44, 49, 50, 51, 58, 59, 62, 63, 66,
    82, 84, 87, 95, 100, 102, 105, 108,
]
FIRST_TESTS = [0, 1, 3, 5, 9, 17, 33, 65, 129, 257, 7, 15]

NUM_LONG = 112
NUM_ORBITS = 4116
WORDS_64 = 65
BYTES_8 = 515
MAX_TESTS = 32
MAX_SURVIVORS = 1024


class BatchResult(ctypes.Structure):
    _fields_ = [
        ("total_tuples", ctypes.c_uint64),
        ("admissible", ctypes.c_uint64),
        ("fail_counts", ctypes.c_uint64 * MAX_TESTS),
        ("fwht_checked", ctypes.c_uint64),
        ("fwht_fail", ctypes.c_uint64),
        ("bent_found", ctypes.c_uint64),
        ("first_fwht_fail_freq", ctypes.c_int32 * MAX_SURVIVORS),
        ("bent_candidates", (ctypes.c_int32 * 8) * MAX_SURVIVORS),
    ]


class H16Context(ctypes.Structure):
    _fields_ = [
        ("long_tables", (ctypes.c_uint64 * WORDS_64) * NUM_LONG),
        ("base_sparse_0", ctypes.c_uint64 * WORDS_64),
        ("base_sparse_1", ctypes.c_uint64 * WORDS_64),
        ("base_dense_0", ctypes.c_uint64 * WORDS_64),
        ("base_dense_1", ctypes.c_uint64 * WORDS_64),
        ("is_L", ctypes.c_uint8 * NUM_LONG),
        ("is_R", ctypes.c_uint8 * NUM_LONG),
        ("is_K", ctypes.c_uint8 * NUM_LONG),
        ("long_orbit_ids", ctypes.c_int32 * NUM_LONG),
        ("n16", ctypes.c_uint32),
        ("mask16_tail", ctypes.c_uint64),
        ("n_short", ctypes.c_uint32),
        ("short_idx", ctypes.c_uint16 * 128),
        ("short_size", ctypes.c_uint8 * 128),
        ("n_tests", ctypes.c_int32),
        ("test_freqs", ctypes.c_uint16 * MAX_TESTS),
        ("byte_luts", ((ctypes.c_int16 * 256) * BYTES_8) * MAX_TESTS),
        ("x_to_orbit", ctypes.c_uint16 * 65536),
    ]


def build_quartic_orbits():
    orbits = []
    seen = set()
    for mon in combinations(range(16), 4):
        if mon in seen:
            continue
        orb = sorted({tuple(sorted((j + s) % 16 for j in mon)) for s in range(16)})
        seen.update(orb)
        orbits.append(orb)
    assert len(orbits) == 116
    long_ids = [i for i, o in enumerate(orbits) if len(o) == 16]
    short_ids = [i for i, o in enumerate(orbits) if len(o) < 16]
    assert len(long_ids) == 112
    assert short_ids == [57, 99, 113, 115], f"Unexpected short orbits: {short_ids}"
    assert orbits[99][0] == (0, 2, 8, 10), f"Orbit 99 rep: {orbits[99][0]}"
    long_set = set(long_ids)
    assert set(L_INDICES).issubset(long_set)
    assert set(K_INDICES).issubset(long_set)
    assert set(R_INDICES).issubset(long_set)
    assert set(L_INDICES).isdisjoint(R_INDICES)
    return orbits, long_ids, short_ids


def dp_admissible_counts(long_ids):
    L_set, R_set = set(L_INDICES), set(R_INDICES)
    # dp[k][pL][pR]
    dp = [[[0, 0], [0, 0]] for _ in range(6)]
    dp[0][0][0] = 1
    for oid in long_ids:
        dl = 1 if oid in L_set else 0
        dr = 1 if oid in R_set else 0
        for k in range(5, 0, -1):
            for pl in (0, 1):
                for pr in (0, 1):
                    dp[k][pl][pr] += dp[k - 1][pl ^ dl][pr ^ dr]
    dp_k0_4 = sum(dp[k][1][0] for k in range(5))
    dp_k5 = dp[5][1][0]

    # Independent closed-form binomial check
    nL, nR = len(L_INDICES), len(R_INDICES)
    nO = len(long_ids) - nL - nR
    binom_k0_4 = 0
    binom_k5 = 0
    for k in range(6):
        s = 0
        for l in range(1, min(k, nL) + 1, 2):
            for r in range(0, min(k - l, nR) + 1, 2):
                o = k - l - r
                if 0 <= o <= nO:
                    s += math.comb(nL, l) * math.comb(nR, r) * math.comb(nO, o)
        if k <= 4:
            binom_k0_4 += s
        else:
            binom_k5 = s
    assert dp_k0_4 == binom_k0_4 == 1359552, (dp_k0_4, binom_k0_4)
    assert dp_k5 == binom_k5, (dp_k5, binom_k5)
    return {"k0_4": dp_k0_4, "k5": dp_k5}


def build_input_orbits():
    visited = bytearray(65536)
    orbs_16 = []
    orbs_short = []
    for x in range(65536):
        if visited[x]:
            continue
        cur = x
        members = []
        while not visited[cur]:
            visited[cur] = 1
            members.append(cur)
            cur = ((cur << 1) & 0xFFFF) | (cur >> 15)
        if len(members) == 16:
            orbs_16.append(members)
        else:
            orbs_short.append(members)
    orbs = orbs_16 + orbs_short
    assert len(orbs) == NUM_ORBITS
    assert sum(len(o) for o in orbs) == 65536
    x_to_orbit = [0] * 65536
    for oid, members in enumerate(orbs):
        for x in members:
            x_to_orbit[x] = oid
    return orbs, len(orbs_16), x_to_orbit


def eval_orbit_poly_on_x(orb_monomials, x):
    val = 0
    for a, b, c, d in orb_monomials:
        if ((x >> a) & (x >> b) & (x >> c) & (x >> d)) & 1:
            val ^= 1
    return val


def compile_library(base_dir: Path) -> Path:
    c_path = base_dir / "h16_walsh_core.c"
    so_path = base_dir / "libh16walsh.so"
    if not so_path.exists() or c_path.stat().st_mtime > so_path.stat().st_mtime:
        cmd = ["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)]
        subprocess.run(cmd, check=True)
    return so_path


def load_lib(so_path: Path):
    lib = ctypes.CDLL(str(so_path))
    lib.validate_candidate_wfb.argtypes = [
        ctypes.POINTER(H16Context),
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int,
        ctypes.POINTER(ctypes.c_int32),
    ]
    lib.validate_candidate_wfb.restype = ctypes.c_int32
    lib.run_k5_batch.argtypes = [
        ctypes.POINTER(H16Context),
        ctypes.c_int,
        ctypes.c_int,
        ctypes.POINTER(BatchResult),
    ]
    lib.run_k5_batch.restype = None
    lib.run_control_k0_4.argtypes = [
        ctypes.POINTER(H16Context),
        ctypes.c_int,
        ctypes.POINTER(BatchResult),
    ]
    lib.run_control_k0_4.restype = None
    return lib


def build_context():
    quartic_orbits, long_ids, _ = build_quartic_orbits()
    in_orbs, n16, x_to_orbit = build_input_orbits()

    # Build packed 65-word truth tables for all 116 quartic orbits
    tables = []
    for q_orb in quartic_orbits:
        words = [0] * WORDS_64
        for oid, members in enumerate(in_orbs):
            if eval_orbit_poly_on_x(q_orb, members[0]):
                words[oid >> 6] |= 1 << (oid & 63)
        tables.append(words)

    ctx = H16Context()
    ctypes.memset(ctypes.byref(ctx), 0, ctypes.sizeof(ctx))

    L_set, R_set, K_set = set(L_INDICES), set(R_INDICES), set(K_INDICES)
    dense_words = [0] * WORDS_64
    for idx, qid in enumerate(long_ids):
        ctx.long_orbit_ids[idx] = qid
        ctx.is_L[idx] = 1 if qid in L_set else 0
        ctx.is_R[idx] = 1 if qid in R_set else 0
        ctx.is_K[idx] = 1 if qid in K_set else 0
        for w in range(WORDS_64):
            ctx.long_tables[idx][w] = tables[qid][w]
            dense_words[w] ^= tables[qid][w]

    for w in range(WORDS_64):
        t99 = tables[99][w]
        t57_113 = tables[57][w] ^ tables[113][w]
        ctx.base_sparse_0[w] = t99
        ctx.base_sparse_1[w] = t99 ^ t57_113
        ctx.base_dense_0[w] = dense_words[w] ^ t99
        ctx.base_dense_1[w] = dense_words[w] ^ t99 ^ t57_113

    ctx.n16 = n16
    rem = n16 % 64
    ctx.mask16_tail = ((1 << rem) - 1) if rem else 0
    ctx.n_short = NUM_ORBITS - n16
    for s in range(ctx.n_short):
        oid = n16 + s
        ctx.short_idx[s] = oid
        ctx.short_size[s] = len(in_orbs[oid])

    for x in range(65536):
        ctx.x_to_orbit[x] = x_to_orbit[x]

    ctx.n_tests = len(FIRST_TESTS)
    for t_idx, freq in enumerate(FIRST_TESTS):
        ctx.test_freqs[t_idx] = freq
        if freq == 0:
            continue
        # Compute orbit weight w_b(O) = sum_{x in O} (-1)^(b . x)
        weights = [0] * (BYTES_8 * 8)
        for oid, members in enumerate(in_orbs):
            w = 0
            for x in members:
                w += -1 if ((freq & x).bit_count() & 1) else 1
            weights[oid] = w
        for b_idx in range(BYTES_8):
            base_oid = b_idx * 8
            for byte_val in range(256):
                s = 0
                for bit in range(8):
                    if (byte_val >> bit) & 1:
                        s += weights[base_oid + bit]
                ctx.byte_luts[t_idx][b_idx][byte_val] = s

    return ctx, quartic_orbits, long_ids


def validate_optimization(lib, ctx):
    import random
    rng = random.Random(20261117)
    L_set, R_set, K_set = set(L_INDICES), set(R_INDICES), set(K_INDICES)
    checks = 0
    for dense in (0, 1):
        tested = 0
        while tested < 10:
            sel = rng.sample(range(NUM_LONG), 5)
            pl = sum(ctx.is_L[i] for i in sel) % 2
            pr = sum(ctx.is_R[i] for i in sel) % 2
            if pl != 1 or pr != 0:
                continue
            c57 = sum(ctx.is_K[i] for i in sel) % 2
            f = (ctypes.c_uint64 * WORDS_64)()
            base = (ctx.base_dense_1 if c57 else ctx.base_dense_0) if dense else (ctx.base_sparse_1 if c57 else ctx.base_sparse_0)
            for w in range(WORDS_64):
                val = base[w]
                for i in sel:
                    val ^= ctx.long_tables[i][w]
                f[w] = val
            for t_idx in range(ctx.n_tests):
                direct = ctypes.c_int32()
                fast = lib.validate_candidate_wfb(ctypes.byref(ctx), f, t_idx, ctypes.byref(direct))
                assert fast == direct.value, f"Mismatch at dense={dense}, t={t_idx}: fast={fast} vs direct={direct.value}"
            tested += 1
            checks += ctx.n_tests
    return checks


# Worker globals for ProcessPoolExecutor
_G_LIB = None
_G_CTX = None
_G_OUT_DIR = None


def _init_worker(so_path_str, out_dir_str):
    global _G_LIB, _G_CTX, _G_OUT_DIR
    _G_LIB = load_lib(Path(so_path_str))
    _G_CTX, _, _ = build_context()
    _G_OUT_DIR = Path(out_dir_str)


def _run_one_batch(task):
    side, dense, i0 = task
    t0 = time.perf_counter()
    res = BatchResult()
    _G_LIB.run_k5_batch(ctypes.byref(_G_CTX), dense, i0, ctypes.byref(res))
    dt = time.perf_counter() - t0
    fail_hist = {
        str(FIRST_TESTS[i]): int(res.fail_counts[i])
        for i in range(len(FIRST_TESTS))
        if res.fail_counts[i] > 0
    }
    bent_list = []
    for b in range(min(int(res.bent_found), MAX_SURVIVORS)):
        row = [int(res.bent_candidates[b][j]) for j in range(8)]
        bent_list.append({
            "dense": bool(row[0]),
            "k": row[1],
            "selected_long_orbit_ids": row[2:7],
            "c57": row[7],
            "c99": 1,
            "c113": row[7],
            "c115": 0,
        })
    payload = {
        "side": side,
        "dense": bool(dense),
        "batch_i0": i0,
        "status": "ok",
        "total_tuples": int(res.total_tuples),
        "admissible": int(res.admissible),
        "fail_hist": fail_hist,
        "fwht_checked": int(res.fwht_checked),
        "fwht_fail": int(res.fwht_fail),
        "bent_found": int(res.bent_found),
        "bent_candidates": bent_list,
        "elapsed_sec": round(dt, 6),
    }
    batch_file = _G_OUT_DIR / f"{side}_batch_{i0:03d}.json"
    tmp_file = _G_OUT_DIR / f"{side}_batch_{i0:03d}.json.tmp"
    tmp_file.write_text(json.dumps(payload, indent=2), encoding="utf-8")
    os.replace(tmp_file, batch_file)
    rss_kb = resource.getrusage(resource.RUSAGE_SELF).ru_maxrss
    return payload, rss_kb


def independent_verify_bent(cand, quartic_orbits, long_ids):
    """Second completely independent pure-Python verification of any bent candidate."""
    sel_ids = set(cand["selected_long_orbit_ids"])
    active_ids = (set(long_ids) - sel_ids) if cand["dense"] else sel_ids
    active_ids |= {99}
    if cand["c57"]:
        active_ids |= {57, 113}
    tt = [0] * 65536
    for qid in active_ids:
        for a, b, c, d in quartic_orbits[qid]:
            for x in range(65536):
                if ((x >> a) & (x >> b) & (x >> c) & (x >> d)) & 1:
                    tt[x] ^= 1
    spec = [1 - 2 * v for v in tt]
    len_ = 1
    while len_ < 65536:
        step = len_ << 1
        for i in range(0, 65536, step):
            for j in range(len_):
                u = spec[i + j]
                v = spec[i + j + len_]
                spec[i + j] = u + v
                spec[i + j + len_] = u - v
        len_ = step
    is_bent = all(abs(v) == 256 for v in spec)
    return {"independent_bent_verified": is_bent, "active_orbit_ids": sorted(active_ids)}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--work-dir", default=".")
    parser.add_argument("--workers", type=int, default=os.cpu_count() or 4)
    parser.add_argument("--pilot", action="store_true", help="Run pilot batches and measure speed/RAM")
    parser.add_argument("--run-full", action="store_true", help="Run all 108 sparse + 108 dense batches")
    args = parser.parse_args()

    base_dir = Path(__file__).resolve().parent
    work_dir = Path(args.work_dir).resolve()
    batches_dir = work_dir / "batches"
    batches_dir.mkdir(parents=True, exist_ok=True)

    t_start = time.perf_counter()
    so_path = compile_library(base_dir)
    lib = load_lib(so_path)
    ctx, quartic_orbits, long_ids = build_context()
    dp_counts = dp_admissible_counts(long_ids)
    val_checks = validate_optimization(lib, ctx)

    # Control k=0..4
    ctrl = {}
    for side, dense in (("presentes", 0), ("ausentes", 1)):
        res = BatchResult()
        t0 = time.perf_counter()
        lib.run_control_k0_4(ctypes.byref(ctx), dense, ctypes.byref(res))
        dt = time.perf_counter() - t0
        hist = {
            str(FIRST_TESTS[i]): int(res.fail_counts[i])
            for i in range(len(FIRST_TESTS))
            if res.fail_counts[i] > 0
        }
        ctrl[side] = {
            "total_tuples": int(res.total_tuples),
            "admissible": int(res.admissible),
            "fail_hist": hist,
            "fwht_checked": int(res.fwht_checked),
            "bent_found": int(res.bent_found),
            "elapsed_sec": round(dt, 6),
        }
    assert ctrl["presentes"]["admissible"] == 1359552
    assert ctrl["presentes"]["fail_hist"] == {"0": 1359552}
    assert ctrl["ausentes"]["admissible"] == 1359552
    assert ctrl["ausentes"]["fail_hist"] == {"0": 1359480, "1": 72}

    report = {
        "dp_counts": dp_counts,
        "validation_checks": val_checks,
        "control_k0_4": ctrl,
        "workers": args.workers,
    }

    if args.pilot:
        pilot_tasks = [("presentes", 0, i0) for i0 in range(4)] + [("ausentes", 1, i0) for i0 in range(4)]
        t0 = time.perf_counter()
        max_rss_kb = 0
        total_adm = 0
        total_tup = 0
        with ProcessPoolExecutor(
            max_workers=min(args.workers, len(pilot_tasks)),
            initializer=_init_worker,
            initargs=(str(so_path), str(batches_dir)),
        ) as ex:
            for payload, rss_kb in ex.map(_run_one_batch, pilot_tasks):
                max_rss_kb = max(max_rss_kb, rss_kb)
                total_adm += payload["admissible"]
                total_tup += payload["total_tuples"]
        dt = time.perf_counter() - t0
        report["pilot"] = {
            "batches_run": len(pilot_tasks),
            "total_tuples": total_tup,
            "admissible": total_adm,
            "elapsed_sec": round(dt, 4),
            "admissible_per_sec": round(total_adm / dt, 1),
            "tuples_per_sec": round(total_tup / dt, 1),
            "max_rss_mb_per_process": round(max_rss_kb / 1024.0, 2),
        }
        print(json.dumps(report, indent=2))
        return

    if args.run_full:
        tasks = [("presentes", 0, i0) for i0 in range(NUM_LONG - 4)] + [
            ("ausentes", 1, i0) for i0 in range(NUM_LONG - 4)
        ]
        t0 = time.perf_counter()
        max_rss_kb = 0
        with ProcessPoolExecutor(
            max_workers=args.workers,
            initializer=_init_worker,
            initargs=(str(so_path), str(batches_dir)),
        ) as ex:
            futures = [ex.submit(_run_one_batch, t) for t in tasks]
            for fut in as_completed(futures):
                _, rss_kb = fut.result()
                max_rss_kb = max(max_rss_kb, rss_kb)
        dt = time.perf_counter() - t0

        # Aggregate & verify all 216 batches
        sides_summary = {}
        all_bent = []
        expected_tuples = math.comb(112, 5)
        for side in ("presentes", "ausentes"):
            tot_tup = 0
            tot_adm = 0
            fwht_checked = 0
            fwht_fail = 0
            bent_found = 0
            fail_hist = {}
            batches_ok = 0
            for i0 in range(NUM_LONG - 4):
                bf = batches_dir / f"{side}_batch_{i0:03d}.json"
                assert bf.exists(), f"Missing batch {bf}"
                data = json.loads(bf.read_text(encoding="utf-8"))
                assert data["status"] == "ok"
                batches_ok += 1
                tot_tup += data["total_tuples"]
                tot_adm += data["admissible"]
                fwht_checked += data["fwht_checked"]
                fwht_fail += data["fwht_fail"]
                bent_found += data["bent_found"]
                for k, v in data["fail_hist"].items():
                    fail_hist[k] = fail_hist.get(k, 0) + v
                all_bent.extend(data["bent_candidates"])
            assert batches_ok == 108
            assert tot_tup == expected_tuples, (side, tot_tup, expected_tuples)
            assert tot_adm == dp_counts["k5"], (side, tot_adm, dp_counts["k5"])
            sides_summary[side] = {
                "batches_ok": batches_ok,
                "total_tuples": tot_tup,
                "admissible": tot_adm,
                "fail_hist": fail_hist,
                "fwht_checked": fwht_checked,
                "fwht_fail": fwht_fail,
                "bent_found": bent_found,
            }

        verified_bent = []
        for cand in all_bent:
            ver = independent_verify_bent(cand, quartic_orbits, long_ids)
            verified_bent.append({**cand, **ver})

        report["k5_partition_rule"] = "Disjoint partition by smallest long-orbit position i0 in 0..107 (108 batches per side)"
        report["k5_execution"] = {
            "elapsed_sec": round(dt, 4),
            "max_rss_mb_per_process": round(max_rss_kb / 1024.0, 2),
            "sides": sides_summary,
            "bent_candidates_verified": verified_bent,
        }
        report["total_wall_sec"] = round(time.perf_counter() - t_start, 4)

        out_report = work_dir / "h16_c99_k5_report.json"
        out_report.write_text(json.dumps(report, indent=2), encoding="utf-8")
        print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()

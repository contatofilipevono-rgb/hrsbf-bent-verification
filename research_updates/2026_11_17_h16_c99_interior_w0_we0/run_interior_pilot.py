#!/usr/bin/env python3
"""
Pilot search in the interior (6 <= k <= 106) of the c99=1 branch of H16 (n=16, deg 4)
for witnesses satisfying |W_f(0)| = |W_f(e_0)| = 256, with full C1..C7 verification
and direct half-table (A, B) + full 65,536-entry FWHT audit.
"""
import argparse
import ctypes
import gzip
import json
import os
import subprocess
import sys
import time
from concurrent.futures import ProcessPoolExecutor
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

NUM_LONG = 112
NUM_ORBITS = 4116
WORDS_64 = 65
BYTES_8 = 515
MAX_HITS = 256


class InteriorCtx(ctypes.Structure):
    _fields_ = [
        ("long_tables", (ctypes.c_uint64 * WORDS_64) * NUM_LONG),
        ("base_0", ctypes.c_uint64 * WORDS_64),
        ("base_1", ctypes.c_uint64 * WORDS_64),
        ("long_orbit_ids", ctypes.c_int32 * NUM_LONG),
        ("orbit_to_long_pos", ctypes.c_int32 * 116),
        ("mask_L_lo", ctypes.c_uint64),
        ("mask_L_hi", ctypes.c_uint64),
        ("mask_R_lo", ctypes.c_uint64),
        ("mask_R_hi", ctypes.c_uint64),
        ("mask_K_lo", ctypes.c_uint64),
        ("mask_K_hi", ctypes.c_uint64),
        ("q4_lin_lo", ctypes.c_uint64),
        ("q4_lin_hi", ctypes.c_uint64),
        ("q4_I_lo", ctypes.c_uint64 * 4),
        ("q4_I_hi", ctypes.c_uint64 * 4),
        ("q4_J_lo", ctypes.c_uint64 * 4),
        ("q4_J_hi", ctypes.c_uint64 * 4),
        ("pos_0", ctypes.c_int32),
        ("pos_5", ctypes.c_int32),
        ("pos_23", ctypes.c_int32),
        ("c6_len", ctypes.c_int32),
        ("c6_lo", ctypes.POINTER(ctypes.c_uint64)),
        ("c6_hi", ctypes.POINTER(ctypes.c_uint64)),
        ("free_109_pos", ctypes.c_int32 * 109),
        ("n16", ctypes.c_uint32),
        ("mask16_tail", ctypes.c_uint64),
        ("n_short", ctypes.c_uint32),
        ("short_idx", ctypes.c_uint16 * 128),
        ("short_size", ctypes.c_uint8 * 128),
        ("e0_lut", (ctypes.c_int16 * 256) * BYTES_8),
    ]


class SearchStats(ctypes.Structure):
    _fields_ = [
        ("c157_tested", ctypes.c_uint64),
        ("c7_tested", ctypes.c_uint64),
        ("pass_w0", ctypes.c_uint64),
        ("pass_both", ctypes.c_uint64),
        ("pass_both_c7", ctypes.c_uint64),
        ("n_hits", ctypes.c_uint64),
        ("hit_c_lo", ctypes.c_uint64 * MAX_HITS),
        ("hit_c_hi", ctypes.c_uint64 * MAX_HITS),
        ("hit_c6_pass", ctypes.c_int32 * MAX_HITS),
        ("hit_A", ctypes.c_int32 * MAX_HITS),
        ("hit_B", ctypes.c_int32 * MAX_HITS),
        ("mod512_AB", (ctypes.c_uint64 * 8) * 8),
        ("mod256_A", ctypes.c_uint64 * 4),
        ("mod256_B", ctypes.c_uint64 * 4),
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
    assert len(long_ids) == 112 and short_ids == [57, 99, 113, 115]
    assert orbits[99][0] == (0, 2, 8, 10)
    return orbits, long_ids


def build_input_orbits():
    visited = bytearray(65536)
    orbs_16, orbs_short = [], []
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
    assert len(orbs) == NUM_ORBITS and sum(len(o) for o in orbs) == 65536
    return orbs, len(orbs_16)


def eval_orbit_poly_on_x(orb_monomials, x):
    val = 0
    for a, b, c, d in orb_monomials:
        if ((x >> a) & (x >> b) & (x >> c) & (x >> d)) & 1:
            val ^= 1
    return val


def load_t28_cert(cert_path: Path):
    if cert_path.suffix == ".gz":
        with gzip.open(cert_path, "rt", encoding="utf-8") as f:
            return json.load(f)
    return json.loads(cert_path.read_text(encoding="utf-8"))


def split_128(mask: int):
    return mask & 0xFFFFFFFFFFFFFFFF, (mask >> 64) & 0xFFFFFFFFFFFFFFFF


def compile_library(base_dir: Path) -> Path:
    c_path = base_dir / "interior_search_core.c"
    so_path = base_dir / "libinteriorsearch.so"
    if not so_path.exists() or c_path.stat().st_mtime > so_path.stat().st_mtime:
        subprocess.run(
            ["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)],
            check=True,
        )
    return so_path


def load_lib(so_path: Path):
    lib = ctypes.CDLL(str(so_path))
    lib.run_interior_search.argtypes = [
        ctypes.POINTER(InteriorCtx),
        ctypes.c_uint64,
        ctypes.c_int,
        ctypes.c_int,
        ctypes.c_uint64,
        ctypes.c_int,
        ctypes.POINTER(SearchStats),
    ]
    lib.run_interior_search.restype = None
    return lib


def build_ctx(cert_data):
    quartic_orbits, long_ids = build_quartic_orbits()
    in_orbs, n16 = build_input_orbits()

    tables = []
    for q_orb in quartic_orbits:
        words = [0] * WORDS_64
        for oid, members in enumerate(in_orbs):
            if eval_orbit_poly_on_x(q_orb, members[0]):
                words[oid >> 6] |= 1 << (oid & 63)
        tables.append(words)

    ctx = InteriorCtx()
    ctypes.memset(ctypes.byref(ctx), 0, ctypes.sizeof(ctx))

    orb_to_pos = [-1] * 116
    for pos, qid in enumerate(long_ids):
        ctx.long_orbit_ids[pos] = qid
        orb_to_pos[qid] = pos
        for w in range(WORDS_64):
            ctx.long_tables[pos][w] = tables[qid][w]
    for qid in range(116):
        ctx.orbit_to_long_pos[qid] = orb_to_pos[qid]

    for w in range(WORDS_64):
        ctx.base_0[w] = tables[99][w]
        ctx.base_1[w] = tables[99][w] ^ tables[57][w] ^ tables[113][w]

    ctx.pos_0 = orb_to_pos[0]
    ctx.pos_5 = orb_to_pos[5]
    ctx.pos_23 = orb_to_pos[23]
    free_109 = [p for p in range(NUM_LONG) if p not in (ctx.pos_0, ctx.pos_5, ctx.pos_23)]
    assert len(free_109) == 109
    for i, p in enumerate(free_109):
        ctx.free_109_pos[i] = p

    mL = sum(1 << orb_to_pos[j] for j in L_INDICES if j != 0)
    mR = sum(1 << orb_to_pos[j] for j in R_INDICES if j != 5)
    mK = sum(1 << orb_to_pos[j] for j in K_INDICES)
    ctx.mask_L_lo, ctx.mask_L_hi = split_128(mL)
    ctx.mask_R_lo, ctx.mask_R_hi = split_128(mR)
    ctx.mask_K_lo, ctx.mask_K_hi = split_128(mK)

    factor = cert_data["fourth_factorization"]
    ctx.q4_lin_lo, ctx.q4_lin_hi = split_128(sum(1 << j for j in factor["linear"]))
    for b, prod in enumerate(factor["products"]):
        ctx.q4_I_lo[b], ctx.q4_I_hi[b] = split_128(sum(1 << j for j in prod["I"]))
        ctx.q4_J_lo[b], ctx.q4_J_hi[b] = split_128(sum(1 << j for j in prod["J"]))

    poly_hex = cert_data["reduced_models"]["branches"][1]["polynomial_hex"]
    assert cert_data["reduced_models"]["branches"][1]["branch"] == 1
    c6_len = len(poly_hex)
    c6_lo_arr = (ctypes.c_uint64 * c6_len)()
    c6_hi_arr = (ctypes.c_uint64 * c6_len)()
    for i, h in enumerate(poly_hex):
        m = int(h, 16)
        c6_lo_arr[i], c6_hi_arr[i] = split_128(m)
    ctx.c6_len = c6_len
    ctx.c6_lo = c6_lo_arr
    ctx.c6_hi = c6_hi_arr

    ctx.n16 = n16
    rem = n16 % 64
    ctx.mask16_tail = ((1 << rem) - 1) if rem else 0
    ctx.n_short = NUM_ORBITS - n16
    for s in range(ctx.n_short):
        oid = n16 + s
        ctx.short_idx[s] = oid
        ctx.short_size[s] = len(in_orbs[oid])

    # e0 = 0x0001
    weights = [0] * (BYTES_8 * 8)
    for oid, members in enumerate(in_orbs):
        weights[oid] = sum(-1 if (x & 1) else 1 for x in members)
    for b_idx in range(BYTES_8):
        base_oid = b_idx * 8
        for byte_val in range(256):
            s = 0
            for bit in range(8):
                if (byte_val >> bit) & 1:
                    s += weights[base_oid + bit]
            ctx.e0_lut[b_idx][byte_val] = s

    # Keep references alive
    ctx._keepalive = (c6_lo_arr, c6_hi_arr)
    return ctx, quartic_orbits, long_ids


def independent_audit_witness(c_int: int, cert_data, quartic_orbits, long_ids):
    """Independent pure-Python full 65,536-entry verification + C1..C7 check."""
    active_ids = [j for j in range(116) if (c_int >> j) & 1]
    long_active = [j for j in active_ids if j in set(long_ids)]

    # Verify C1..C7 explicitly
    c1 = ((c_int >> 99) & 1) == 1 and ((c_int >> 115) & 1) == 0
    c2 = ((c_int >> 57) & 1) == ((c_int >> 113) & 1)
    c3 = (sum((c_int >> j) & 1 for j in L_INDICES) % 2) == 1
    factor = cert_data["fourth_factorization"]
    q4_val = (
        sum((c_int >> j) & 1 for j in factor["linear"])
        + sum(
            (sum((c_int >> j) & 1 for j in p["I"]) % 2) * (sum((c_int >> j) & 1 for j in p["J"]) % 2)
            for p in factor["products"]
        )
    ) % 2
    c4 = q4_val == 0
    c5 = ((c_int >> 57) & 1) == (sum((c_int >> j) & 1 for j in K_INDICES) % 2)
    poly_hex = cert_data["reduced_models"]["branches"][1]["polynomial_hex"]
    c6_val = sum(1 for h in poly_hex if (c_int & int(h, 16)) == int(h, 16)) % 2
    c6 = c6_val == 0
    c7 = (sum((c_int >> j) & 1 for j in R_INDICES) % 2) == 0

    # Reconstruct f(x) directly from original 4-variable monomials over all 65,536 inputs
    monomials = []
    for qid in active_ids:
        monomials.extend(quartic_orbits[qid])

    tt = [0] * 65536
    for a, b, c, d in monomials:
        for x in range(65536):
            if ((x >> a) & (x >> b) & (x >> c) & (x >> d)) & 1:
                tt[x] ^= 1

    # Direct half-table sums A (x0=0) and B (x0=1)
    A = sum(1 - 2 * tt[x] for x in range(0, 65536, 2))
    B = sum(1 - 2 * tt[x] for x in range(1, 65536, 2))
    wt0 = sum(tt[x] for x in range(0, 65536, 2))
    wt1 = sum(tt[x] for x in range(1, 65536, 2))
    wf0 = A + B
    wfe0 = A - B

    # Full FWHT
    spec = [1 - 2 * v for v in tt]
    step_len = 1
    while step_len < 65536:
        step = step_len << 1
        for i in range(0, 65536, step):
            for j in range(step_len):
                u = spec[i + j]
                v = spec[i + j + step_len]
                spec[i + j] = u + v
                spec[i + j + step_len] = u - v
        step_len = step

    assert spec[0] == wf0 and spec[1] == wfe0
    unit_vals = [spec[1 << i] for i in range(16)]
    assert len(set(unit_vals)) == 1, f"Symmetry broken: {unit_vals}"

    first_fail = None
    for b in range(65536):
        if abs(spec[b]) != 256:
            first_fail = {"mask_hex": hex(b), "mask_int": b, "walsh_value": spec[b]}
            break

    return {
        "coefficients_hex": hex(c_int),
        "active_orbit_ids": active_ids,
        "num_long_orbits": len(long_active),
        "conditions": {
            "C1_c99_1_c115_0": c1,
            "C2_c57_eq_c113": c2,
            "C3_parity_L_1": c3,
            "C4_Q4_0": c4,
            "C5_c57_eq_K": c5,
            "C6_T28_branch1_0": c6,
            "C7_parity_R_0": c7,
            "all_C1_to_C7": (c1 and c2 and c3 and c4 and c5 and c6 and c7),
        },
        "A_x0_0": A,
        "B_x0_1": B,
        "half_weight_x0_0": wt0,
        "half_weight_x0_1": wt1,
        "W_f_0": wf0,
        "W_f_e0": wfe0,
        "unit_freq_walsh_common": unit_vals[0],
        "is_bent": (first_fail is None),
        "first_failing_frequency": first_fail,
    }


_G_LIB = None
_G_CTX = None


def _init_worker(so_path_str, cert_path_str):
    global _G_LIB, _G_CTX
    _G_LIB = load_lib(Path(so_path_str))
    cert_data = load_t28_cert(Path(cert_path_str))
    _G_CTX, _, _ = build_ctx(cert_data)


def _run_worker(task):
    seed, k_min, k_max, n_samples, check_c6_first = task
    stats = SearchStats()
    t0 = time.perf_counter()
    _G_LIB.run_interior_search(
        ctypes.byref(_G_CTX), seed, k_min, k_max, n_samples, check_c6_first, ctypes.byref(stats)
    )
    dt = time.perf_counter() - t0
    hits = []
    for i in range(min(int(stats.n_hits), MAX_HITS)):
        c_int = int(stats.hit_c_lo[i]) | (int(stats.hit_c_hi[i]) << 64)
        hits.append({
            "c_int": c_int,
            "c6_pass": bool(stats.hit_c6_pass[i]),
            "A": int(stats.hit_A[i]),
            "B": int(stats.hit_B[i]),
        })
    mod512 = [[int(stats.mod512_AB[r][c]) for c in range(8)] for r in range(8)]
    mod256_A = [int(stats.mod256_A[i]) for i in range(4)]
    mod256_B = [int(stats.mod256_B[i]) for i in range(4)]
    return {
        "c157_tested": int(stats.c157_tested),
        "c7_tested": int(stats.c7_tested),
        "pass_w0": int(stats.pass_w0),
        "pass_both": int(stats.pass_both),
        "pass_both_c7": int(stats.pass_both_c7),
        "hits": hits,
        "mod512_AB": mod512,
        "mod256_A": mod256_A,
        "mod256_B": mod256_B,
        "elapsed_sec": dt,
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cert-path", required=True)
    parser.add_argument("--work-dir", default=".")
    parser.add_argument("--workers", type=int, default=os.cpu_count() or 8)
    parser.add_argument("--c7-samples-per-band", type=int, default=1600000)
    parser.add_argument("--fast-samples-per-band", type=int, default=40000000)
    args = parser.parse_args()

    t_start = time.perf_counter()
    base_dir = Path(__file__).resolve().parent
    work_dir = Path(args.work_dir).resolve()
    work_dir.mkdir(parents=True, exist_ok=True)

    so_path = compile_library(base_dir)
    cert_data = load_t28_cert(Path(args.cert_path))
    _, quartic_orbits, long_ids = build_ctx(cert_data)

    bands = [
        ("near_sparse", 6, 15),
        ("central", 50, 62),
        ("near_dense", 97, 106),
        ("full_interior", 6, 106),
    ]

    results = {"bands_c7_strict": {}, "bands_c157_fast": {}, "witnesses_audited": []}
    all_hits_seen = {}

    with ProcessPoolExecutor(
        max_workers=args.workers,
        initializer=_init_worker,
        initargs=(str(so_path), str(args.cert_path)),
    ) as ex:
        # Prong B: Strict C7-filtered search + (A, B) modular distribution
        for b_idx, (b_name, kmin, kmax) in enumerate(bands):
            per_w = args.c7_samples_per_band // args.workers
            tasks = [(20261117000 + b_idx * 100 + w, kmin, kmax, per_w, 1) for w in range(args.workers)]
            agg = {
                "k_range": [kmin, kmax],
                "c157_tested": 0,
                "c7_tested": 0,
                "pass_w0": 0,
                "pass_both": 0,
                "pass_both_c7": 0,
                "mod512_AB": [[0] * 8 for _ in range(8)],
                "mod256_A": [0] * 4,
                "mod256_B": [0] * 4,
            }
            t0 = time.perf_counter()
            for r in ex.map(_run_worker, tasks):
                agg["c157_tested"] += r["c157_tested"]
                agg["c7_tested"] += r["c7_tested"]
                agg["pass_w0"] += r["pass_w0"]
                agg["pass_both"] += r["pass_both"]
                agg["pass_both_c7"] += r["pass_both_c7"]
                for i in range(8):
                    for j in range(8):
                        agg["mod512_AB"][i][j] += r["mod512_AB"][i][j]
                for i in range(4):
                    agg["mod256_A"][i] += r["mod256_A"][i]
                    agg["mod256_B"][i] += r["mod256_B"][i]
                for h in r["hits"]:
                    all_hits_seen[h["c_int"]] = h
            agg["elapsed_sec"] = round(time.perf_counter() - t0, 4)
            results["bands_c7_strict"][b_name] = agg

        # Prong A: High-throughput C1..C5+C7 -> Walsh (0, e0) -> C6 filter
        for b_idx, (b_name, kmin, kmax) in enumerate(bands):
            per_w = args.fast_samples_per_band // args.workers
            tasks = [(20261118000 + b_idx * 100 + w, kmin, kmax, per_w, 0) for w in range(args.workers)]
            agg = {
                "k_range": [kmin, kmax],
                "c157_tested": 0,
                "pass_w0": 0,
                "pass_both": 0,
                "pass_both_c7": 0,
            }
            t0 = time.perf_counter()
            for r in ex.map(_run_worker, tasks):
                agg["c157_tested"] += r["c157_tested"]
                agg["pass_w0"] += r["pass_w0"]
                agg["pass_both"] += r["pass_both"]
                agg["pass_both_c7"] += r["pass_both_c7"]
                for h in r["hits"]:
                    all_hits_seen[h["c_int"]] = h
            agg["elapsed_sec"] = round(time.perf_counter() - t0, 4)
            results["bands_c157_fast"][b_name] = agg

    # Audit up to 16 witnesses (prioritizing C7-valid ones first!)
    sorted_hits = sorted(all_hits_seen.values(), key=lambda x: (not x["c6_pass"], x["c_int"]))
    for h in sorted_hits[:16]:
        audit = independent_audit_witness(h["c_int"], cert_data, quartic_orbits, long_ids)
        results["witnesses_audited"].append(audit)

    results["total_distinct_hits_captured"] = len(all_hits_seen)
    results["total_wall_sec"] = round(time.perf_counter() - t_start, 4)

    out_path = work_dir / "interior_w0_we0_report.json"
    out_path.write_text(json.dumps(results, indent=2), encoding="utf-8")
    print(json.dumps(results, indent=2))


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""
Cascade Walsh + periodic-frequency attack on the interior (6 <= k <= 106) of
H16 degree 4 (c99=1, C1..C7), testing u2=0x5555, u4=0x1111, u8=0x0101, and all 8
weight-2 orbits e0+e_d (d=1..8), plus full 65,536-entry FWHT on any survivor.
"""
import argparse
import ctypes
import gzip
import json
import os
import subprocess
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

EXTRA_FREQS = [
    ("u2_0x5555", 0x5555),
    ("u4_0x1111", 0x1111),
    ("u8_0x0101", 0x0101),
    ("w2_d1_0x0003", 0x0003),
    ("w2_d2_0x0005", 0x0005),
    ("w2_d3_0x0009", 0x0009),
    ("w2_d4_0x0011", 0x0011),
    ("w2_d5_0x0021", 0x0021),
    ("w2_d6_0x0041", 0x0041),
    ("w2_d7_0x0081", 0x0081),
    ("w2_d8_0x0101_dup", 0x0101),  # wait: u8 is 0x0101! Let's use 0x3333 (period 4 weight 8) for slot 10!
]
EXTRA_FREQS[10] = ("u4_w8_0x3333", 0x3333)

NUM_LONG = 112
NUM_ORBITS = 4116
WORDS_64 = 65
BYTES_8 = 515
N_EXTRA_FREQS = 11
MAX_SURVIVORS = 128


class CascadeCtx(ctypes.Structure):
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
        ("extra_luts", ((ctypes.c_int16 * 256) * BYTES_8) * N_EXTRA_FREQS),
        ("extra_freqs", ctypes.c_uint16 * N_EXTRA_FREQS),
        ("x_to_orbit", ctypes.c_uint16 * 65536),
    ]


class CascadeStats(ctypes.Structure):
    _fields_ = [
        ("c157_tested", ctypes.c_uint64),
        ("pass_w0", ctypes.c_uint64),
        ("pass_w0_we0", ctypes.c_uint64),
        ("pass_w0_we0_c7", ctypes.c_uint64),
        ("indiv_pass_c7", ctypes.c_uint64 * N_EXTRA_FREQS),
        ("cascade_pass_c7", ctypes.c_uint64 * N_EXTRA_FREQS),
        ("mod128_hist", (ctypes.c_uint64 * 3) * N_EXTRA_FREQS),
        ("fwht_checked", ctypes.c_uint64),
        ("bent_found", ctypes.c_uint64),
        ("n_survivors", ctypes.c_uint64),
        ("surv_c_lo", ctypes.c_uint64 * MAX_SURVIVORS),
        ("surv_c_hi", ctypes.c_uint64 * MAX_SURVIVORS),
        ("surv_fail_b", ctypes.c_int32 * MAX_SURVIVORS),
        ("surv_fail_val", ctypes.c_int32 * MAX_SURVIVORS),
    ]


def build_quartic_orbits():
    orbits, seen = [], set()
    for mon in combinations(range(16), 4):
        if mon in seen:
            continue
        orb = sorted({tuple(sorted((j + s) % 16 for j in mon)) for s in range(16)})
        seen.update(orb)
        orbits.append(orb)
    assert len(orbits) == 116
    long_ids = [i for i, o in enumerate(orbits) if len(o) == 16]
    assert len(long_ids) == 112
    return orbits, long_ids


def build_input_orbits():
    visited = bytearray(65536)
    orbs_16, orbs_short = [], []
    for x in range(65536):
        if visited[x]:
            continue
        cur, members = x, []
        while not visited[cur]:
            visited[cur] = 1
            members.append(cur)
            cur = ((cur << 1) & 0xFFFF) | (cur >> 15)
        (orbs_16 if len(members) == 16 else orbs_short).append(members)
    orbs = orbs_16 + orbs_short
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


def load_t28_cert(cert_path: Path):
    if cert_path.suffix == ".gz":
        with gzip.open(cert_path, "rt", encoding="utf-8") as f:
            return json.load(f)
    return json.loads(cert_path.read_text(encoding="utf-8"))


def split_128(mask: int):
    return mask & 0xFFFFFFFFFFFFFFFF, (mask >> 64) & 0xFFFFFFFFFFFFFFFF


def compile_library(base_dir: Path) -> Path:
    c_path = base_dir / "cascade_core.c"
    so_path = base_dir / "libcascade.so"
    if not so_path.exists() or c_path.stat().st_mtime > so_path.stat().st_mtime:
        subprocess.run(
            ["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)],
            check=True,
        )
    return so_path


def load_lib(so_path: Path):
    lib = ctypes.CDLL(str(so_path))
    lib.run_cascade_search.argtypes = [
        ctypes.POINTER(CascadeCtx),
        ctypes.c_uint64,
        ctypes.c_int,
        ctypes.c_int,
        ctypes.c_uint64,
        ctypes.POINTER(CascadeStats),
    ]
    lib.run_cascade_search.restype = None
    return lib


def fill_byte_lut(lut_ptr, in_orbs, freq: int):
    weights = [0] * (BYTES_8 * 8)
    for oid, members in enumerate(in_orbs):
        weights[oid] = sum(-1 if ((freq & x).bit_count() & 1) else 1 for x in members)
    for b_idx in range(BYTES_8):
        base_oid = b_idx * 8
        for byte_val in range(256):
            s = 0
            for bit in range(8):
                if (byte_val >> bit) & 1:
                    s += weights[base_oid + bit]
            lut_ptr[b_idx][byte_val] = s


def build_ctx(cert_data):
    quartic_orbits, long_ids = build_quartic_orbits()
    in_orbs, n16, x_to_orbit = build_input_orbits()

    tables = []
    for q_orb in quartic_orbits:
        words = [0] * WORDS_64
        for oid, members in enumerate(in_orbs):
            if eval_orbit_poly_on_x(q_orb, members[0]):
                words[oid >> 6] |= 1 << (oid & 63)
        tables.append(words)

    ctx = CascadeCtx()
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
    for i, p in enumerate(free_109):
        ctx.free_109_pos[i] = p

    ctx.mask_L_lo, ctx.mask_L_hi = split_128(sum(1 << orb_to_pos[j] for j in L_INDICES if j != 0))
    ctx.mask_R_lo, ctx.mask_R_hi = split_128(sum(1 << orb_to_pos[j] for j in R_INDICES if j != 5))
    ctx.mask_K_lo, ctx.mask_K_hi = split_128(sum(1 << orb_to_pos[j] for j in K_INDICES))

    factor = cert_data["fourth_factorization"]
    ctx.q4_lin_lo, ctx.q4_lin_hi = split_128(sum(1 << j for j in factor["linear"]))
    for b, prod in enumerate(factor["products"]):
        ctx.q4_I_lo[b], ctx.q4_I_hi[b] = split_128(sum(1 << j for j in prod["I"]))
        ctx.q4_J_lo[b], ctx.q4_J_hi[b] = split_128(sum(1 << j for j in prod["J"]))

    poly_hex = cert_data["reduced_models"]["branches"][1]["polynomial_hex"]
    c6_len = len(poly_hex)
    c6_lo_arr = (ctypes.c_uint64 * c6_len)()
    c6_hi_arr = (ctypes.c_uint64 * c6_len)()
    for i, h in enumerate(poly_hex):
        c6_lo_arr[i], c6_hi_arr[i] = split_128(int(h, 16))
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

    for x in range(65536):
        ctx.x_to_orbit[x] = x_to_orbit[x]

    fill_byte_lut(ctx.e0_lut, in_orbs, 1)
    for q, (_, freq) in enumerate(EXTRA_FREQS):
        ctx.extra_freqs[q] = freq
        fill_byte_lut(ctx.extra_luts[q], in_orbs, freq)

    ctx._keepalive = (c6_lo_arr, c6_hi_arr)
    return ctx, quartic_orbits, long_ids


_G_LIB = None
_G_CTX = None


def _init_worker(so_path_str, cert_path_str):
    global _G_LIB, _G_CTX
    _G_LIB = load_lib(Path(so_path_str))
    cert_data = load_t28_cert(Path(cert_path_str))
    _G_CTX, _, _ = build_ctx(cert_data)


def _run_worker(task):
    seed, k_min, k_max, n_samples = task
    stats = CascadeStats()
    _G_LIB.run_cascade_search(ctypes.byref(_G_CTX), seed, k_min, k_max, n_samples, ctypes.byref(stats))
    survivors = []
    for i in range(min(int(stats.n_survivors), MAX_SURVIVORS)):
        c_int = int(stats.surv_c_lo[i]) | (int(stats.surv_c_hi[i]) << 64)
        survivors.append({
            "coefficients_hex": hex(c_int),
            "fail_b_hex": hex(int(stats.surv_fail_b[i])) if stats.surv_fail_b[i] >= 0 else None,
            "fail_val": int(stats.surv_fail_val[i]),
        })
    return {
        "c157_tested": int(stats.c157_tested),
        "pass_w0": int(stats.pass_w0),
        "pass_w0_we0": int(stats.pass_w0_we0),
        "pass_w0_we0_c7": int(stats.pass_w0_we0_c7),
        "indiv_pass_c7": [int(stats.indiv_pass_c7[q]) for q in range(N_EXTRA_FREQS)],
        "cascade_pass_c7": [int(stats.cascade_pass_c7[q]) for q in range(N_EXTRA_FREQS)],
        "mod128_hist": [[int(stats.mod128_hist[q][r]) for r in range(3)] for q in range(N_EXTRA_FREQS)],
        "fwht_checked": int(stats.fwht_checked),
        "bent_found": int(stats.bent_found),
        "survivors": survivors,
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cert-path", required=True)
    parser.add_argument("--work-dir", default=".")
    parser.add_argument("--workers", type=int, default=os.cpu_count() or 8)
    parser.add_argument("--samples-per-band", type=int, default=80000000)
    args = parser.parse_args()

    t_start = time.perf_counter()
    base_dir = Path(__file__).resolve().parent
    work_dir = Path(args.work_dir).resolve()
    work_dir.mkdir(parents=True, exist_ok=True)
    so_path = compile_library(base_dir)

    bands = [
        ("central_50_62", 50, 62),
        ("full_interior_6_106", 6, 106),
        ("near_dense_97_106", 97, 106),
    ]

    report = {"extra_freqs": [{"name": n, "mask_hex": hex(f)} for n, f in EXTRA_FREQS], "bands": {}}
    with ProcessPoolExecutor(
        max_workers=args.workers,
        initializer=_init_worker,
        initargs=(str(so_path), str(args.cert_path)),
    ) as ex:
        for b_idx, (b_name, kmin, kmax) in enumerate(bands):
            per_w = args.samples_per_band // args.workers
            tasks = [(20261119000 + b_idx * 100 + w, kmin, kmax, per_w) for w in range(args.workers)]
            agg = {
                "k_range": [kmin, kmax],
                "c157_tested": 0,
                "pass_w0": 0,
                "pass_w0_we0": 0,
                "pass_w0_we0_c7": 0,
                "indiv_pass_c7": {n: 0 for n, _ in EXTRA_FREQS},
                "cascade_pass_c7": {n: 0 for n, _ in EXTRA_FREQS},
                "mod128_hist": {n: {"0_mod_128": 0, "64_mod_128": 0, "other": 0} for n, _ in EXTRA_FREQS},
                "fwht_checked": 0,
                "bent_found": 0,
                "survivors": [],
            }
            t0 = time.perf_counter()
            for r in ex.map(_run_worker, tasks):
                agg["c157_tested"] += r["c157_tested"]
                agg["pass_w0"] += r["pass_w0"]
                agg["pass_w0_we0"] += r["pass_w0_we0"]
                agg["pass_w0_we0_c7"] += r["pass_w0_we0_c7"]
                agg["fwht_checked"] += r["fwht_checked"]
                agg["bent_found"] += r["bent_found"]
                agg["survivors"].extend(r["survivors"])
                for q, (n, _) in enumerate(EXTRA_FREQS):
                    agg["indiv_pass_c7"][n] += r["indiv_pass_c7"][q]
                    agg["cascade_pass_c7"][n] += r["cascade_pass_c7"][q]
                    agg["mod128_hist"][n]["0_mod_128"] += r["mod128_hist"][q][0]
                    agg["mod128_hist"][n]["64_mod_128"] += r["mod128_hist"][q][1]
                    agg["mod128_hist"][n]["other"] += r["mod128_hist"][q][2]
            agg["elapsed_sec"] = round(time.perf_counter() - t0, 4)
            report["bands"][b_name] = agg

    report["total_wall_sec"] = round(time.perf_counter() - t_start, 4)
    out_path = work_dir / "cascade_periodic_report.json"
    out_path.write_text(json.dumps(report, indent=2), encoding="utf-8")
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()

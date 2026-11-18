#!/usr/bin/env python3
"""
Pilot search for even-distance pairs (2,4), (2,6), (4,6), (2,8), (6,8) alongside
odd distances (1,3,5,7) in H16 degree 4 (c99=1, C1..C7, 6 <= k <= 106).
Includes directed search from 0xdd & 0xbf, incremental walk sampling,
i -> 3i mod 16 symmetry check, and full independent 65,536-entry FWHT audit.
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

W2_FREQS = [0x0003, 0x0005, 0x0009, 0x0011, 0x0021, 0x0041, 0x0081, 0x0101]
ODD_FREQS = [0x0003, 0x0009, 0x0021, 0x0081]
EVEN_FREQS = [0x0005, 0x0011, 0x0041, 0x0101]

TARGETS = {
    "0x5f": 0x5F,  # 2 and 4
    "0x77": 0x77,  # 2 and 6
    "0x7d": 0x7D,  # 4 and 6
    "0xd7": 0xD7,  # 2 and 8
    "0xf5": 0xF5,  # 6 and 8
}

CTRL_0XDD = 0x7ADAEDFE672BB236DCD7C63CA08B4
REG_0XBF = 0x363FDFBFE7FBD7EDEE7DFFFFFFBFA

NUM_LONG = 112
NUM_ORBITS = 4116
WORDS_64 = 65
BYTES_8 = 515


class EvenPairsCtx(ctypes.Structure):
    _fields_ = [
        ("long_tables", (ctypes.c_uint64 * WORDS_64) * NUM_LONG),
        ("base_0", ctypes.c_uint64 * WORDS_64),
        ("base_1", ctypes.c_uint64 * WORDS_64),
        ("diff_57_113", ctypes.c_uint64 * WORDS_64),
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
        ("odd_luts", ((ctypes.c_int16 * 256) * BYTES_8) * 4),
        ("even_luts", ((ctypes.c_int16 * 256) * BYTES_8) * 4),
    ]


class EvenPairsStats(ctypes.Structure):
    _fields_ = [
        ("tested", ctypes.c_uint64),
        ("pass_w0", ctypes.c_uint64),
        ("pass_w0_we0", ctypes.c_uint64),
        ("pass_0x55_c157", ctypes.c_uint64),
        ("pass_0x55_c7", ctypes.c_uint64),
        ("even_hist_c7", ctypes.c_uint64 * 16),
        ("has_ex", ctypes.c_uint8 * 16),
        ("ex_c_lo", ctypes.c_uint64 * 16),
        ("ex_c_hi", ctypes.c_uint64 * 16),
        ("ex_odd_vals", (ctypes.c_int32 * 4) * 16),
        ("ex_even_vals", (ctypes.c_int32 * 4) * 16),
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
    orb_to_idx = {m: i for i, orb in enumerate(orbits) for m in orb}
    perm3 = [orb_to_idx[tuple(sorted((3 * j) % 16 for j in orb[0]))] for orb in orbits]
    return orbits, long_ids, perm3


def apply_perm3(c: int, perm3) -> int:
    out = 0
    for i in range(116):
        if (c >> i) & 1:
            out |= 1 << perm3[i]
    return out


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
    return orbs_16 + orbs_short, len(orbs_16)


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
    c_path = base_dir / "even_pairs_core.c"
    so_path = base_dir / "libevenpairs.so"
    if not so_path.exists() or c_path.stat().st_mtime > so_path.stat().st_mtime:
        subprocess.run(
            ["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)],
            check=True,
        )
    return so_path


def load_lib(so_path: Path):
    lib = ctypes.CDLL(str(so_path))
    lib.run_walk_search.argtypes = [
        ctypes.POINTER(EvenPairsCtx), ctypes.c_uint64, ctypes.c_int, ctypes.c_int,
        ctypes.c_uint64, ctypes.POINTER(EvenPairsStats),
    ]
    lib.run_directed_search.argtypes = [
        ctypes.POINTER(EvenPairsCtx), ctypes.c_uint64, ctypes.c_uint64,
        ctypes.c_uint64, ctypes.c_uint64, ctypes.POINTER(EvenPairsStats),
    ]
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
    quartic_orbits, long_ids, perm3 = build_quartic_orbits()
    in_orbs, n16 = build_input_orbits()

    tables = []
    for q_orb in quartic_orbits:
        words = [0] * WORDS_64
        for oid, members in enumerate(in_orbs):
            if eval_orbit_poly_on_x(q_orb, members[0]):
                words[oid >> 6] |= 1 << (oid & 63)
        tables.append(words)

    ctx = EvenPairsCtx()
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
        ctx.diff_57_113[w] = tables[57][w] ^ tables[113][w]
        ctx.base_1[w] = tables[99][w] ^ ctx.diff_57_113[w]

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

    fill_byte_lut(ctx.e0_lut, in_orbs, 1)
    for i, freq in enumerate(ODD_FREQS):
        fill_byte_lut(ctx.odd_luts[i], in_orbs, freq)
    for i, freq in enumerate(EVEN_FREQS):
        fill_byte_lut(ctx.even_luts[i], in_orbs, freq)

    ctx._keepalive = (c6_lo_arr, c6_hi_arr)
    return ctx, quartic_orbits, long_ids, perm3


def check_c7(c_int: int, cert_data) -> bool:
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
    c6 = (sum(1 for h in poly_hex if (c_int & int(h, 16)) == int(h, 16)) % 2) == 0
    c7 = (sum((c_int >> j) & 1 for j in R_INDICES) % 2) == 0
    return c1 and c2 and c3 and c4 and c5 and c6 and c7


def full_independent_audit(c_int: int, cert_data, quartic_orbits, long_ids):
    active_ids = [j for j in range(116) if (c_int >> j) & 1]
    long_active = [j for j in active_ids if j in set(long_ids)]
    assert check_c7(c_int, cert_data), "C1..C7 failed!"

    tt = [0] * 65536
    for qid in active_ids:
        for a, b, c, d in quartic_orbits[qid]:
            for x in range(65536):
                if ((x >> a) & (x >> b) & (x >> c) & (x >> d)) & 1:
                    tt[x] ^= 1

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

    unit_vals = [spec[1 << i] for i in range(16)]
    assert len(set(unit_vals)) == 1 and abs(unit_vals[0]) == 256
    assert abs(spec[0]) == 256

    w2_signed = {hex(f): spec[f] for f in W2_FREQS}
    mask = 0
    for d, f in enumerate(W2_FREQS):
        if abs(spec[f]) == 256:
            mask |= 1 << d

    w2_all_120 = [spec[b] for b in range(65536) if b.bit_count() == 2]
    assert len(w2_all_120) == 120
    w2_all_120_pass = sum(1 for v in w2_all_120 if abs(v) == 256)

    first_fail = next(({"mask_hex": hex(b), "walsh_value": spec[b]} for b in range(65536) if abs(spec[b]) != 256), None)
    covered = [tname for tname, tv in TARGETS.items() if (mask & tv) == tv]

    return {
        "coefficients_hex": hex(c_int),
        "active_orbit_ids": active_ids,
        "num_long_orbits": len(long_active),
        "C1_to_C7_verified": True,
        "W_f_0": spec[0],
        "W_f_e0": spec[1],
        "unit_16_common": unit_vals[0],
        "w2_120_pass_count": w2_all_120_pass,
        "mask_hex": hex(mask),
        "mask_popcount": mask.bit_count(),
        "w2_8_signed": w2_signed,
        "targets_covered": covered,
        "is_bent": (first_fail is None),
        "first_failing_frequency": first_fail,
    }


_G_LIB = None
_G_CTX = None


def _init_worker(so_path_str, cert_path_str):
    global _G_LIB, _G_CTX
    _G_LIB = load_lib(Path(so_path_str))
    cert_data = load_t28_cert(Path(cert_path_str))
    _G_CTX, _, _, _ = build_ctx(cert_data)


def _unpack_stats(stats: EvenPairsStats):
    exs = {}
    for em in range(16):
        if stats.has_ex[em]:
            c_int = int(stats.ex_c_lo[em]) | (int(stats.ex_c_hi[em]) << 64)
            exs[em] = c_int
    return {
        "tested": int(stats.tested),
        "pass_w0": int(stats.pass_w0),
        "pass_w0_we0": int(stats.pass_w0_we0),
        "pass_0x55_c157": int(stats.pass_0x55_c157),
        "pass_0x55_c7": int(stats.pass_0x55_c7),
        "even_hist_c7": [int(stats.even_hist_c7[em]) for em in range(16)],
        "examples": exs,
    }


def _run_walk_worker(task):
    seed, k_min, k_max, n_steps = task
    stats = EvenPairsStats()
    _G_LIB.run_walk_search(ctypes.byref(_G_CTX), seed, k_min, k_max, n_steps, ctypes.byref(stats))
    return _unpack_stats(stats)


def _run_directed_worker(task):
    c_int, rng_seed, n_random = task
    c_lo, c_hi = split_128(c_int)
    stats = EvenPairsStats()
    _G_LIB.run_directed_search(ctypes.byref(_G_CTX), c_lo, c_hi, rng_seed, n_random, ctypes.byref(stats))
    return _unpack_stats(stats)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cert-path", required=True)
    parser.add_argument("--work-dir", default=".")
    parser.add_argument("--workers", type=int, default=os.cpu_count() or 8)
    parser.add_argument("--max-rounds", type=int, default=6)
    parser.add_argument("--steps-per-worker-round", type=int, default=50000000)
    args = parser.parse_args()

    t_start = time.perf_counter()
    base_dir = Path(__file__).resolve().parent
    work_dir = Path(args.work_dir).resolve()
    work_dir.mkdir(parents=True, exist_ok=True)
    so_path = compile_library(base_dir)
    cert_data = load_t28_cert(Path(args.cert_path))
    _, quartic_orbits, long_ids, perm3 = build_ctx(cert_data)

    # 1. Regression check on 0xbf -> 0xef and control 0xdd
    bf_p = apply_perm3(REG_0XBF, perm3)
    assert check_c7(bf_p, cert_data)
    ctrl_dd = full_independent_audit(CTRL_0XDD, cert_data, quartic_orbits, long_ids)
    assert ctrl_dd["mask_hex"] == "0xdd"

    found_witnesses = {}  # target_name -> c_int

    def absorb_examples(exs):
        for em, c_int in exs.items():
            # full 8-bit mask = 0x55 | ((em & 1)<<1) | ((em & 2)<<2) | ((em & 4)<<3) | ((em & 8)<<4)
            m8 = 0x55
            if em & 1: m8 |= 0x02
            if em & 2: m8 |= 0x08
            if em & 4: m8 |= 0x20
            if em & 8: m8 |= 0x80
            for tname, tv in TARGETS.items():
                if (m8 & tv) == tv and tname not in found_witnesses:
                    found_witnesses[tname] = c_int
            # Also try perm3(c_int) if C7-valid!
            if m8 & 0xAA:
                cp = apply_perm3(c_int, perm3)
                if check_c7(cp, cert_data):
                    # perm3 swaps bit1 (d=2) <-> bit5 (d=6), keeps bit3 (d=4) and bit7 (d=8)
                    em_p = (em & 0xA) | ((em & 1) << 2) | ((em & 4) >> 2)
                    m8p = 0x55
                    if em_p & 1: m8p |= 0x02
                    if em_p & 2: m8p |= 0x08
                    if em_p & 4: m8p |= 0x20
                    if em_p & 8: m8p |= 0x80
                    for tname, tv in TARGETS.items():
                        if (m8p & tv) == tv and tname not in found_witnesses:
                            found_witnesses[tname] = cp

    with ProcessPoolExecutor(
        max_workers=args.workers,
        initializer=_init_worker,
        initargs=(str(so_path), str(args.cert_path)),
    ) as ex:
        # 2. Directed search from 0xdd and 0xbf
        t0 = time.perf_counter()
        dir_tasks = [
            (CTRL_0XDD, 2026112000 + w, 5000000) for w in range(args.workers // 2)
        ] + [
            (REG_0XBF, 2026112100 + w, 5000000) for w in range(args.workers - args.workers // 2)
        ]
        dir_agg = {"tested": 0, "pass_w0": 0, "pass_w0_we0": 0, "pass_0x55_c157": 0, "pass_0x55_c7": 0, "even_hist_c7": [0] * 16}
        for r in ex.map(_run_directed_worker, dir_tasks):
            for k in ("tested", "pass_w0", "pass_w0_we0", "pass_0x55_c157", "pass_0x55_c7"):
                dir_agg[k] += r[k]
            for i in range(16):
                dir_agg["even_hist_c7"][i] += r["even_hist_c7"][i]
            absorb_examples(r["examples"])
        dir_agg["elapsed_sec"] = round(time.perf_counter() - t0, 4)

        # 3. Incremental walk sampling in central (50..62) and full interior (6..106)
        walk_agg = {"rounds": 0, "tested": 0, "pass_w0": 0, "pass_w0_we0": 0, "pass_0x55_c157": 0, "pass_0x55_c7": 0, "even_hist_c7": [0] * 16}
        t1 = time.perf_counter()
        for rnd in range(args.max_rounds):
            if len(found_witnesses) == len(TARGETS):
                break
            walk_agg["rounds"] += 1
            tasks = []
            for w in range(args.workers):
                kmin, kmax = (50, 62) if (w % 4 != 3) else (6, 106)
                tasks.append((20261122000 + rnd * 100 + w, kmin, kmax, args.steps_per_worker_round))
            for r in ex.map(_run_walk_worker, tasks):
                for k in ("tested", "pass_w0", "pass_w0_we0", "pass_0x55_c157", "pass_0x55_c7"):
                    walk_agg[k] += r[k]
                for i in range(16):
                    walk_agg["even_hist_c7"][i] += r["even_hist_c7"][i]
                absorb_examples(r["examples"])
        walk_agg["elapsed_sec"] = round(time.perf_counter() - t1, 4)

    # 4. Full independent 65,536-entry audit of all decisive witnesses
    audited_witnesses = {}
    for tname, c_int in found_witnesses.items():
        audited_witnesses[tname] = full_independent_audit(c_int, cert_data, quartic_orbits, long_ids)

    report = {
        "control_0xdd": ctrl_dd,
        "regression_0xbf_perm3_hex": hex(bf_p),
        "directed_search": dir_agg,
        "walk_search": walk_agg,
        "targets_found_count": len(audited_witnesses),
        "decisive_witnesses": audited_witnesses,
        "total_wall_sec": round(time.perf_counter() - t_start, 4),
    }

    out_path = work_dir / "even_pairs_report.json"
    out_path.write_text(json.dumps(report, indent=2), encoding="utf-8")
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()

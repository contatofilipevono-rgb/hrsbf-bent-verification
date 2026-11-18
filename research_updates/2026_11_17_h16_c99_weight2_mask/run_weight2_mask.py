#!/usr/bin/env python3
"""
Joint 8-bit weight-2 Walsh mask investigation on the interior (6 <= k <= 106)
of H16 degree 4 (c99=1, C1..C7), reusing the exact generator, bands, and seeds
from commit 70564fa (run_cascade_attack.py) with regression checks and full
independent 65,536-entry verification.
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

# Fixed order d=1..8 -> bit d-1
W2_FREQS = [0x0003, 0x0005, 0x0009, 0x0011, 0x0021, 0x0041, 0x0081, 0x0101]

# Expected regression counts from commit 70564fa cascade_periodic_report.json
EXPECTED_C7_TOTALS = {
    "central_50_62": 255449,
    "full_interior_6_106": 179966,
    "near_dense_97_106": 11179,
}
EXPECTED_INDIV_FROM_70564FA = {
    "central_50_62": [28546, 27362, 28611, 24933, 28415, 27706, 28411, 23683],
    "full_interior_6_106": [21284, 20958, 21217, 20026, 21189, 20899, 21382, 18076],
    "near_dense_97_106": [1329, 1340, 1403, 1345, 1363, 1327, 1285, 1196],
}

NUM_LONG = 112
NUM_ORBITS = 4116
WORDS_64 = 65
BYTES_8 = 515
N_W2 = 8
HITS_CAP = 60000


class W2MaskCtx(ctypes.Structure):
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
        ("w2_luts", ((ctypes.c_int16 * 256) * BYTES_8) * N_W2),
    ]


class W2MaskStats(ctypes.Structure):
    _fields_ = [
        ("c157_tested", ctypes.c_uint64),
        ("pass_w0", ctypes.c_uint64),
        ("pass_w0_we0", ctypes.c_uint64),
        ("pass_w0_we0_c7", ctypes.c_uint64),
        ("mask_hist", ctypes.c_uint64 * 256),
        ("has_ex", ctypes.c_uint8 * 256),
        ("ex_c_lo", ctypes.c_uint64 * 256),
        ("ex_c_hi", ctypes.c_uint64 * 256),
        ("ex_vals", (ctypes.c_int32 * N_W2) * 256),
        ("n_hits", ctypes.c_uint64),
        ("hit_c_lo", ctypes.POINTER(ctypes.c_uint64)),
        ("hit_c_hi", ctypes.POINTER(ctypes.c_uint64)),
        ("hit_mask", ctypes.POINTER(ctypes.c_uint8)),
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
    c_path = base_dir / "weight2_mask_core.c"
    so_path = base_dir / "libw2mask.so"
    if not so_path.exists() or c_path.stat().st_mtime > so_path.stat().st_mtime:
        subprocess.run(
            ["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)],
            check=True,
        )
    return so_path


def load_lib(so_path: Path):
    lib = ctypes.CDLL(str(so_path))
    lib.run_w2_mask_search.argtypes = [
        ctypes.POINTER(W2MaskCtx),
        ctypes.c_uint64,
        ctypes.c_int,
        ctypes.c_int,
        ctypes.c_uint64,
        ctypes.POINTER(W2MaskStats),
        ctypes.c_uint64,
    ]
    lib.run_w2_mask_search.restype = None
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
    in_orbs, n16 = build_input_orbits()

    tables = []
    for q_orb in quartic_orbits:
        words = [0] * WORDS_64
        for oid, members in enumerate(in_orbs):
            if eval_orbit_poly_on_x(q_orb, members[0]):
                words[oid >> 6] |= 1 << (oid & 63)
        tables.append(words)

    ctx = W2MaskCtx()
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

    fill_byte_lut(ctx.e0_lut, in_orbs, 1)
    for d, freq in enumerate(W2_FREQS):
        fill_byte_lut(ctx.w2_luts[d], in_orbs, freq)

    ctx._keepalive = (c6_lo_arr, c6_hi_arr)
    return ctx, quartic_orbits, long_ids


def independent_verify_full(c_int: int, cert_data, quartic_orbits, long_ids, full_fwht=False):
    active_ids = [j for j in range(116) if (c_int >> j) & 1]
    long_active = [j for j in active_ids if j in set(long_ids)]

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
    assert c1 and c2 and c3 and c4 and c5 and c6 and c7

    tt = [0] * 65536
    for qid in active_ids:
        for a, b, c, d in quartic_orbits[qid]:
            for x in range(65536):
                if ((x >> a) & (x >> b) & (x >> c) & (x >> d)) & 1:
                    tt[x] ^= 1

    spec = [1 - 2 * v for v in tt]
    if full_fwht:
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
        w0, we0 = spec[0], spec[1]
        w2_vals = [spec[f] for f in W2_FREQS]
        w_5555 = spec[0x5555]
        all_120_w2_ok = all(abs(spec[b]) == 256 for b in range(65536) if b.bit_count() == 2)
        first_fail = next(({"mask_hex": hex(b), "walsh_value": spec[b]} for b in range(65536) if abs(spec[b]) != 256), None)
    else:
        w0 = sum(spec)
        we0 = sum(-v if (x & 1) else v for x, v in enumerate(spec))
        w2_vals = [sum(-v if ((x & f).bit_count() & 1) else v for x, v in enumerate(spec)) for f in W2_FREQS]
        w_5555 = sum(-v if ((x & 0x5555).bit_count() & 1) else v for x, v in enumerate(spec))
        all_120_w2_ok = None
        first_fail = None

    mask = 0
    for d, val in enumerate(w2_vals):
        if abs(val) == 256:
            mask |= 1 << d

    return {
        "coefficients_hex": hex(c_int),
        "active_orbit_ids": active_ids,
        "num_long_orbits": len(long_active),
        "C1_to_C7_verified": True,
        "W_f_0": w0,
        "W_f_e0": we0,
        "W_f_0x5555": w_5555,
        "w2_signed_values": {hex(f): v for f, v in zip(W2_FREQS, w2_vals)},
        "mask_hex": hex(mask),
        "mask_popcount": mask.bit_count(),
        "all_120_w2_ok": all_120_w2_ok,
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
    seed, k_min, k_max, n_samples = task
    stats = W2MaskStats()
    hl = (ctypes.c_uint64 * HITS_CAP)()
    hh = (ctypes.c_uint64 * HITS_CAP)()
    hm = (ctypes.c_uint8 * HITS_CAP)()
    stats.hit_c_lo = hl
    stats.hit_c_hi = hh
    stats.hit_mask = hm
    _G_LIB.run_w2_mask_search(ctypes.byref(_G_CTX), seed, k_min, k_max, n_samples, ctypes.byref(stats), HITS_CAP)
    assert int(stats.n_hits) <= HITS_CAP

    examples = {}
    for m in range(256):
        if stats.has_ex[m]:
            c_int = int(stats.ex_c_lo[m]) | (int(stats.ex_c_hi[m]) << 64)
            examples[m] = (c_int, [int(stats.ex_vals[m][d]) for d in range(N_W2)])

    hits = [
        (int(hl[i]) | (int(hh[i]) << 64), int(hm[i]))
        for i in range(int(stats.n_hits))
    ]
    return {
        "c157_tested": int(stats.c157_tested),
        "pass_w0": int(stats.pass_w0),
        "pass_w0_we0": int(stats.pass_w0_we0),
        "pass_w0_we0_c7": int(stats.pass_w0_we0_c7),
        "mask_hist": [int(stats.mask_hist[m]) for m in range(256)],
        "examples": examples,
        "hits": hits,
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
    cert_data = load_t28_cert(Path(args.cert_path))
    _, quartic_orbits, long_ids = build_ctx(cert_data)

    # 1. Control check on witness 0xdcc662e2c890c0324c1549b289
    ctrl = independent_verify_full(0xDCC662E2C890C0324C1549B289, cert_data, quartic_orbits, long_ids, full_fwht=True)
    assert ctrl["num_long_orbits"] == 41
    assert ctrl["W_f_0"] == 256 and ctrl["W_f_e0"] == 256
    assert ctrl["w2_signed_values"]["0x3"] == 640
    assert ctrl["W_f_0x5555"] == -256
    assert (int(ctrl["mask_hex"], 16) & 1) == 0

    bands = [
        ("central_50_62", 50, 62),
        ("full_interior_6_106", 6, 106),
        ("near_dense_97_106", 97, 106),
    ]

    report = {
        "control_witness": ctrl,
        "w2_frequencies_order": [{"bit": d, "distance": d + 1, "mask_hex": hex(f)} for d, f in enumerate(W2_FREQS)],
        "bands": {},
    }

    global_mask_hist = [0] * 256
    global_distinct = set()

    with ProcessPoolExecutor(
        max_workers=args.workers,
        initializer=_init_worker,
        initargs=(str(so_path), str(args.cert_path)),
    ) as ex:
        for b_idx, (b_name, kmin, kmax) in enumerate(bands):
            per_w = args.samples_per_band // args.workers
            tasks = [(20261119000 + b_idx * 100 + w, kmin, kmax, per_w) for w in range(args.workers)]
            hist = [0] * 256
            band_examples = {}
            band_distinct = {}
            c157 = pw0 = pboth = pc7 = 0
            t0 = time.perf_counter()
            for r in ex.map(_run_worker, tasks):
                c157 += r["c157_tested"]
                pw0 += r["pass_w0"]
                pboth += r["pass_w0_we0"]
                pc7 += r["pass_w0_we0_c7"]
                for m in range(256):
                    hist[m] += r["mask_hist"][m]
                    global_mask_hist[m] += r["mask_hist"][m]
                for m, ex_val in r["examples"].items():
                    if m not in band_examples:
                        band_examples[m] = ex_val
                for c_int, m in r["hits"]:
                    band_distinct[c_int] = m
                    global_distinct.add((c_int, m))

            # Regression check against commit 70564fa
            assert pc7 == EXPECTED_C7_TOTALS[b_name], (b_name, pc7, EXPECTED_C7_TOTALS[b_name])
            indiv = [sum(hist[m] for m in range(256) if (m >> d) & 1) for d in range(8)]
            assert indiv == EXPECTED_INDIV_FROM_70564FA[b_name], (b_name, indiv, EXPECTED_INDIV_FROM_70564FA[b_name])

            distinct_hist = [0] * 256
            for m in band_distinct.values():
                distinct_hist[m] += 1

            max_pop = max((m.bit_count() for m in range(256) if hist[m] > 0), default=0)
            max_pop_examples = []
            for m in sorted(m for m in range(256) if hist[m] > 0 and m.bit_count() == max_pop):
                c_int, vals = band_examples[m]
                audit = independent_verify_full(c_int, cert_data, quartic_orbits, long_ids, full_fwht=(m == 0xFF))
                max_pop_examples.append({"mask_hex": hex(m), "popcount": max_pop, "c_vals": vals, "audit": audit})

            report["bands"][b_name] = {
                "k_range": [kmin, kmax],
                "c157_tested": c157,
                "pass_w0": pw0,
                "pass_w0_we0": pboth,
                "pass_w0_we0_c7_occurrences": pc7,
                "distinct_c7_w0_we0": len(band_distinct),
                "regression_check_70564fa": "PASS",
                "indiv_pass_counts": indiv,
                "max_popcount_observed": max_pop,
                "mask_hist_256_occurrences": {hex(m): hist[m] for m in range(256) if hist[m] > 0},
                "mask_hist_256_distinct": {hex(m): distinct_hist[m] for m in range(256) if distinct_hist[m] > 0},
                "max_popcount_examples": max_pop_examples,
                "elapsed_sec": round(time.perf_counter() - t0, 4),
            }

    # Global minimal-cardinality zero subsets (across all 446,594 occurrences)
    global_distinct_hist = [0] * 256
    for _, m in global_distinct:
        global_distinct_hist[m] += 1

    zero_subsets_by_card = {}
    for sub in range(1, 256):
        cnt = sum(global_mask_hist[m] for m in range(256) if (m & sub) == sub)
        if cnt == 0:
            card = sub.bit_count()
            dists = [d + 1 for d in range(8) if (sub >> d) & 1]
            zero_subsets_by_card.setdefault(card, []).append({"subset_mask_hex": hex(sub), "distances": dists})

    min_card = min(zero_subsets_by_card.keys()) if zero_subsets_by_card else None
    report["global_summary"] = {
        "total_occurrences": sum(global_mask_hist),
        "total_distinct_vectors": len(global_distinct),
        "found_0xff": global_mask_hist[0xFF] > 0,
        "max_popcount_global": max((m.bit_count() for m in range(256) if global_mask_hist[m] > 0), default=0),
        "minimal_zero_subset_cardinality": min_card,
        "minimal_zero_subsets": zero_subsets_by_card.get(min_card, []),
        "total_wall_sec": round(time.perf_counter() - t_start, 4),
    }

    out_path = work_dir / "weight2_mask_report.json"
    out_path.write_text(json.dumps(report, indent=2), encoding="utf-8")
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()

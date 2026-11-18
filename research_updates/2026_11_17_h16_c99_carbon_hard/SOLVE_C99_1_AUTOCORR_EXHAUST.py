#!/usr/bin/env python3
"""
Step 3E:
1. Exact GF(2) rank + OpenMP Gray-code exhaustion of D_{0xffff} f (wt == 32768)
   and rank analysis of D_{0x5555} f in branch c99=1, K=1.
2. Iterative Macaulay degree-3 closure including P_tilde_{3f3f, 5f5f, 6f6f} (chi=0).
"""
import json
import subprocess
import time
from pathlib import Path

from VERIFICAR_ALGEBRA_C99_1 import (
    K_INDICES, R_INDICES, WITNESSES, build_basis_111, extract_poly_mod4, setup_orbits,
)
from VERIFICAR_ALGEBRA_C99_5_M3 import gf2_macaulay_reduce, substitute_linear_vars


def eliminate_linear_eq(origin, cb, indices, rhs):
    """Eliminate one linear equation sum_{j in indices} c_j == rhs from (origin, cb)."""
    mask = sum(1 << j for j in indices)
    const = (origin & mask).bit_count() & 1
    piv = None
    for i, c in enumerate(cb):
        if (c & mask).bit_count() & 1:
            piv = i
            break
    assert piv is not None
    c_piv = cb[piv]
    new_origin = origin ^ (c_piv if (const ^ rhs) else 0)
    new_cb = []
    for i, c in enumerate(cb):
        if i == piv:
            continue
        new_cb.append(c ^ (c_piv if ((c & mask).bit_count() & 1) else 0))
    return new_origin, new_cb


def build_group_orbits(a_mask, rot_step=1):
    """Build orbits under <rot^rot_step> x <^ a_mask>."""
    visited = bytearray(65536)
    orbs = []
    for x in range(65536):
        if visited[x]:
            continue
        queue = [x]
        visited[x] = 1
        members = []
        while queue:
            cur = queue.pop()
            members.append(cur)
            nxt1 = ((cur << rot_step) & 0xFFFF) | (cur >> (16 - rot_step))
            if not visited[nxt1]:
                visited[nxt1] = 1
                queue.append(nxt1)
            nxt2 = cur ^ a_mask
            if not visited[nxt2]:
                visited[nxt2] = 1
                queue.append(nxt2)
        orbs.append((members[0], len(members)))
    return orbs


def eval_deriv_matrix(a_mask, rot_step, orbits, origin, cb):
    """
    For D_a f(x) = f(x) ^ f(x ^ a_mask), compute:
    - g_orbs: [(rep, weight), ...]
    - o_vec: int bitmask over len(g_orbs) bits
    - cols: list of len(cb) int bitmasks over len(g_orbs) bits
    """
    g_orbs = build_group_orbits(a_mask, rot_step)
    reps = [r for r, _ in g_orbs]
    weights = [w for _, w in g_orbs]
    # For each of 116 quartic orbits, compute its D_a value on each rep
    orb_d = []
    for orb in orbits:
        vec = 0
        for k, x in enumerate(reps):
            xa = x ^ a_mask
            v = (sum((x & m) == m for m in orb) ^ sum((xa & m) == m for m in orb)) & 1
            if v:
                vec |= 1 << k
        orb_d.append(vec)

    o_vec = 0
    for j in range(116):
        if (origin >> j) & 1:
            o_vec ^= orb_d[j]
    cols = []
    for cdir in cb:
        v = 0
        for j in range(116):
            if (cdir >> j) & 1:
                v ^= orb_d[j]
        cols.append(v)
    return g_orbs, weights, o_vec, cols, orb_d


def gf2_image_basis(cols):
    """Return linearly independent basis vectors spanning the GF(2) column space."""
    pivots = {}
    basis = []
    for v in cols:
        x = v
        while x:
            b = x.bit_length() - 1
            if b in pivots:
                x ^= pivots[b]
            else:
                pivots[b] = x
                basis.append(v)
                break
    return basis


def run_gray_exhaust_c(n_orbs, weights, o_vec, basis, work_dir):
    r = len(basis)
    n_words = (n_orbs + 63) // 64
    c_code = f"""
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <omp.h>

#define N_ORBS {n_orbs}
#define N_WORDS {n_words}
#define R_DIM {r}

static const uint64_t O_VEC[N_WORDS] = {{
    {", ".join(f"0x{(o_vec >> (64*w)) & ((1<<64)-1):016x}ULL" for w in range(n_words))}
}};

static const uint64_t BASIS[R_DIM][N_WORDS] = {{
    {", ".join("{" + ", ".join(f"0x{(b >> (64*w)) & ((1<<64)-1):016x}ULL" for w in range(n_words)) + "}" for b in basis)}
}};

static const int WEIGHTS[N_ORBS] = {{
    {", ".join(map(str, weights))}
}};

// Precompute 8-bit popcount weight tables per byte!
static int BYTE_WT[N_WORDS * 8][256];

static void init_tables(void) {{
    for (int b = 0; b < N_WORDS * 8; b++) {{
        for (int val = 0; val < 256; val++) {{
            int s = 0;
            for (int bit = 0; bit < 8; bit++) {{
                int idx = b * 8 + bit;
                if (idx < N_ORBS && ((val >> bit) & 1)) s += WEIGHTS[idx];
            }}
            BYTE_WT[b][val] = s;
        }}
    }}
}}

static inline int eval_wt(const uint64_t *cur) {{
    int total = 0;
    const uint8_t *p = (const uint8_t *)cur;
    for (int b = 0; b < N_WORDS * 8; b++) {{
        total += BYTE_WT[b][p[b]];
    }}
    return total;
}}

int main(void) {{
    init_tables();
    int k_split = (R_DIM >= 6) ? 6 : 0;
    int r_sub = R_DIM - k_split;
    uint64_t n_chunks = 1ULL << k_split;
    uint64_t sub_lim = 1ULL << r_sub;

    uint64_t total_hits = 0;
    uint64_t *hits_buf = (uint64_t *)malloc(sizeof(uint64_t) * 100000);
    int buf_cap = 100000;
    int buf_len = 0;

    #pragma omp parallel for schedule(dynamic, 1) reduction(+:total_hits)
    for (uint64_t chunk = 0; chunk < n_chunks; chunk++) {{
        uint64_t cur[N_WORDS];
        for (int w = 0; w < N_WORDS; w++) cur[w] = O_VEC[w];
        for (int b = 0; b < k_split; b++) {{
            if ((chunk >> b) & 1) {{
                int idx = r_sub + b;
                for (int w = 0; w < N_WORDS; w++) cur[w] ^= BASIS[idx][w];
            }}
        }}
        uint64_t z = 0;
        if (eval_wt(cur) == 32768) {{
            total_hits++;
            #pragma omp critical
            if (buf_len < buf_cap) hits_buf[buf_len++] = (chunk << r_sub) | z;
        }}
        uint64_t prev_g = 0;
        for (uint64_t i = 1; i < sub_lim; i++) {{
            uint64_t g = i ^ (i >> 1);
            int bit = __builtin_ctzll(g ^ prev_g);
            prev_g = g;
            z ^= (1ULL << bit);
            for (int w = 0; w < N_WORDS; w++) cur[w] ^= BASIS[bit][w];
            if (eval_wt(cur) == 32768) {{
                total_hits++;
                #pragma omp critical
                if (buf_len < buf_cap) hits_buf[buf_len++] = (chunk << r_sub) | z;
            }}
        }}
    }}

    printf("HITS %llu\\n", (unsigned long long)total_hits);
    FILE *fp = fopen("hits_0xffff.txt", "w");
    for (int i = 0; i < buf_len; i++) fprintf(fp, "%llu\\n", (unsigned long long)hits_buf[i]);
    fclose(fp);
    free(hits_buf);
    return 0;
}}
"""
    c_path = work_dir / "autocorr_gray.c"
    bin_path = work_dir / "autocorr_gray"
    c_path.write_text(c_code, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-fopenmp", str(c_path), "-o", str(bin_path)], check=True)
    t1 = time.perf_counter()
    res = subprocess.run([str(bin_path)], cwd=str(work_dir), capture_output=True, text=True, check=True)
    dt = round(time.perf_counter() - t1, 4)
    hits_line = [ln for ln in res.stdout.splitlines() if ln.startswith("HITS ")][0]
    total_hits = int(hits_line.split()[1])
    hits_sample = [int(ln.strip()) for ln in (work_dir / "hits_0xffff.txt").read_text().splitlines() if ln.strip()]
    return total_hits, hits_sample, dt


def main():
    t0 = time.perf_counter()
    repo = Path(__file__).resolve().parents[2]
    work_dir = Path(__file__).resolve().parent
    orbits = setup_orbits()
    free, origin, cb = build_basis_111()
    origin_k1, cb_k1 = eliminate_linear_eq(origin, cb, K_INDICES, 1)

    # 1. Rank & Exhaustion of D_{0xffff} f
    g_orbs_f, wts_f, o_f, cols_f, orb_d_f = eval_deriv_matrix(0xFFFF, 1, orbits, origin_k1, cb_k1)
    # Sanity check against 0xd7 on 65536 points
    c_d7 = WITNESSES["0xd7"]
    d_vec = 0
    for j in range(116):
        if (c_d7 >> j) & 1:
            d_vec ^= orb_d_f[j]
    wt_orb = sum(wts_f[k] for k in range(len(g_orbs_f)) if (d_vec >> k) & 1)
    # Brute force check
    tt = [0] * 65536
    for j in range(116):
        if (c_d7 >> j) & 1:
            for m in orbits[j]:
                for x in range(65536):
                    if (x & m) == m:
                        tt[x] ^= 1
    wt_bf = sum(tt[x] ^ tt[x ^ 0xFFFF] for x in range(65536))
    assert wt_orb == wt_bf, f"Sanity mismatch: {wt_orb} != {wt_bf}"

    basis_f = gf2_image_basis(cols_f)
    r_f = len(basis_f)
    print(f"D_0xffff: n_orbs={len(g_orbs_f)}, dim_free={len(cb_k1)}, rank={r_f}, sanity_wt={wt_orb}", flush=True)

    # Also check rank of D_{0x5555} f
    g_orbs_5, wts_5, o_5, cols_5, _ = eval_deriv_matrix(0x5555, 2, orbits, origin_k1, cb_k1)
    basis_5 = gf2_image_basis(cols_5)
    r_5 = len(basis_5)
    print(f"D_0x5555: n_orbs={len(g_orbs_5)}, rank={r_5}", flush=True)

    exhaust_res = {"skipped": True, "reason": f"rank {r_f} > 29"}
    if r_f <= 29:
        total_hits, hits_sample, c_sec = run_gray_exhaust_c(len(g_orbs_f), wts_f, o_f, basis_f, work_dir)
        # Compute affine hull of hits_sample
        affine_eqs = 0
        if 0 < len(hits_sample):
            h0 = hits_sample[0]
            pivs = {}
            for h in hits_sample[1:]:
                x = h ^ h0
                while x:
                    b = x.bit_length() - 1
                    if b in pivs:
                        x ^= pivs[b]
                    else:
                        pivs[b] = x
                        break
            affine_eqs = r_f - len(pivs)
        exhaust_res = {
            "skipped": False,
            "total_hits": total_hits,
            "fraction": total_hits / (1 << r_f),
            "affine_dim_reduction": affine_eqs,
            "c_sec": c_sec,
        }
        print(f"Exhaust D_0xffff: {exhaust_res}", flush=True)

    # 2. Macaulay degree-3 closure with P_tilde_{3f3f, 5f5f, 6f6f}
    cert_t28 = json.loads((repo / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json").read_text(encoding="utf-8"))
    polys = {}
    for name, m8, shift in [
        ("0x3f3f", 0x3F, 1), ("0x5f5f", 0x5F, 1), ("0x6f6f", 0x6F, 1),
        ("tilde_3f3f", 0x3F, 0), ("tilde_5f5f", 0x5F, 0), ("tilde_6f6f", 0x6F, 0),
    ]:
        small = [v for v in range(256) if (v & m8) == v]
        pairs = [v | (w << 8) for v in small for w in small if v < w]
        words = [sum((sum((x & m) == m for m in orb) % 2) << k for k, x in enumerate(pairs)) for orb in orbits]
        O_w = 0
        for j in range(116):
            if (origin >> j) & 1:
                O_w ^= words[j]
        b_w = []
        for cdir in cb:
            w = 0
            for j in range(116):
                if (cdir >> j) & 1:
                    w ^= words[j]
            b_w.append(w)
        polys[name] = extract_poly_mod4(b_w, O_w, free, const_shift=shift)

    # Substitute K=1
    k_mask = sum(1 << j for j in K_INDICES)
    k_idxs = [i for i, c in enumerate(cb) if (c & k_mask).bit_count() % 2]
    k_const = (origin & k_mask).bit_count() % 2
    piv_bit = k_idxs[0]
    piv_expr = {1 << i for i in k_idxs[1:]}
    if k_const ^ 1:
        piv_expr.add(0)
    piv_map = {piv_bit: piv_expr}
    rem_vars = [i for i in range(110) if i != piv_bit]

    sys_polys = [substitute_linear_vars(p, piv_map) for p in polys.values()]
    pivs = gf2_macaulay_reduce(sys_polys)
    # Iterative XL on any degree <= 2 pivots
    deg2_done = set()
    for _ in range(3):
        new_gen = []
        for lead, pset in list(pivs.items()):
            if lead.bit_count() <= 2 and lead not in deg2_done:
                deg2_done.add(lead)
                for i in rem_vars:
                    prod = set()
                    bit_m = 1 << i
                    for m in pset:
                        nm = m | bit_m
                        if nm in prod: prod.remove(nm)
                        else: prod.add(nm)
                    new_gen.append(prod)
        if not new_gen:
            break
        pivs = gf2_macaulay_reduce(list(pivs.values()) + new_gen)

    deg_counts = {}
    for lead in pivs:
        d = lead.bit_count()
        deg_counts[d] = deg_counts.get(d, 0) + 1

    out = {
        "D_0xffff": {"n_orbs": len(g_orbs_f), "rank": r_f, "sanity_wt_0xd7": wt_orb, "exhaust": exhaust_res},
        "D_0x5555": {"n_orbs": len(g_orbs_5), "rank": r_5},
        "macaulay_tilde": {
            "poly_lens": {k: len(v) for k, v in polys.items()},
            "has_one": (0 in pivs),
            "deg_counts": deg_counts,
            "total_pivots": len(pivs),
        },
        "elapsed_sec": round(time.perf_counter() - t0, 4),
    }
    (work_dir / "autocorr_exhaust_report.json").write_text(json.dumps(out, indent=2), encoding="utf-8")
    print(json.dumps(out, indent=2), flush=True)


if __name__ == "__main__":
    main()

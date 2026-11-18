#!/usr/bin/env python3
"""
Step 3F: 8-slice parallel C/OpenMP Gray-code exhaustion of D_{0xffff} f (rank 32 -> 2^32)
using fast-path __builtin_popcountll for all weight==32 orbits.
Usage: python3 SOLVE_C99_1_DFFFF_MATRIX.py <slice_id 0..7>
"""
import json
import subprocess
import sys
import time
from pathlib import Path

from SOLVE_C99_1_AUTOCORR_EXHAUST import (
    eliminate_linear_eq, eval_deriv_matrix, gf2_image_basis,
)
from VERIFICAR_ALGEBRA_C99_1 import K_INDICES, build_basis_111, setup_orbits


def main():
    slice_id = int(sys.argv[1]) if len(sys.argv) > 1 else 0
    assert 0 <= slice_id < 8
    work_dir = Path(__file__).resolve().parent
    orbits = setup_orbits()
    free, origin, cb = build_basis_111()
    origin_k1, cb_k1 = eliminate_linear_eq(origin, cb, K_INDICES, 1)

    g_orbs, wts, o_vec, cols, _ = eval_deriv_matrix(0xFFFF, 1, orbits, origin_k1, cb_k1)
    basis = gf2_image_basis(cols)
    r = len(basis)
    assert r == 32, f"Expected rank 32, got {r}"

    # Reorder orbits: put all weight==32 orbits first so they sit in contiguous uint64_t words
    w32_idxs = [k for k, w in enumerate(wts) if w == 32]
    other_idxs = [k for k, w in enumerate(wts) if w != 32]
    # Pad w32_idxs to multiple of 64? No, just track exact n_w32 and put other_idxs starting at word_other
    n_w32 = len(w32_idxs)
    n_w32_full_words = n_w32 // 64
    perm = w32_idxs + other_idxs
    new_wts = [wts[k] for k in perm]

    def remap(v):
        out = 0
        for new_i, old_i in enumerate(perm):
            if (v >> old_i) & 1:
                out |= 1 << new_i
        return out

    o_vec_m = remap(o_vec)
    basis_m = [remap(b) for b in basis]
    n_orbs = len(perm)
    n_words = (n_orbs + 63) // 64

    c_code = f"""
#include <stdio.h>
#include <stdint.h>
#include <omp.h>

#define N_ORBS {n_orbs}
#define N_WORDS {n_words}
#define N_W32_FULL {n_w32_full_words}
#define R_DIM 32

static const uint64_t O_VEC[N_WORDS] = {{
    {", ".join(f"0x{(o_vec_m >> (64*w)) & ((1<<64)-1):016x}ULL" for w in range(n_words))}
}};

static const uint64_t BASIS[R_DIM][N_WORDS] = {{
    {", ".join("{" + ", ".join(f"0x{(b >> (64*w)) & ((1<<64)-1):016x}ULL" for w in range(n_words)) + "}" for b in basis_m)}
}};

static const int WEIGHTS[N_ORBS] = {{
    {", ".join(map(str, new_wts))}
}};

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
    for (int w = 0; w < N_W32_FULL; w++) {{
        total += 32 * __builtin_popcountll(cur[w]);
    }}
    const uint8_t *p = (const uint8_t *)(cur + N_W32_FULL);
    for (int b = N_W32_FULL * 8; b < N_WORDS * 8; b++) {{
        total += BYTE_WT[b][p[b - N_W32_FULL * 8]];
    }}
    return total;
}}

int main(void) {{
    init_tables();
    // Slice fixes top 3 bits (bits 29, 30, 31) = slice_id, then splits next 5 bits (24..28) into 32 OpenMP chunks
    int slice_id = {slice_id};
    uint64_t total_hits = 0;

    #pragma omp parallel for schedule(dynamic, 1) reduction(+:total_hits)
    for (int chunk = 0; chunk < 32; chunk++) {{
        uint64_t cur[N_WORDS];
        for (int w = 0; w < N_WORDS; w++) cur[w] = O_VEC[w];
        for (int b = 0; b < 3; b++) {{
            if ((slice_id >> b) & 1) {{
                for (int w = 0; w < N_WORDS; w++) cur[w] ^= BASIS[29 + b][w];
            }}
        }}
        for (int b = 0; b < 5; b++) {{
            if ((chunk >> b) & 1) {{
                for (int w = 0; w < N_WORDS; w++) cur[w] ^= BASIS[24 + b][w];
            }}
        }}
        if (eval_wt(cur) == 32768) total_hits++;
        uint64_t prev_g = 0;
        uint64_t sub_lim = 1ULL << 24;
        for (uint64_t i = 1; i < sub_lim; i++) {{
            uint64_t g = i ^ (i >> 1);
            int bit = __builtin_ctzll(g ^ prev_g);
            prev_g = g;
            for (int w = 0; w < N_WORDS; w++) cur[w] ^= BASIS[bit][w];
            if (eval_wt(cur) == 32768) total_hits++;
        }}
    }}
    printf("SLICE %d HITS %llu\\n", slice_id, (unsigned long long)total_hits);
    return 0;
}}
"""
    c_path = work_dir / f"dffff_slice_{slice_id}.c"
    bin_path = work_dir / f"dffff_slice_{slice_id}"
    c_path.write_text(c_code, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-fopenmp", str(c_path), "-o", str(bin_path)], check=True)
    t1 = time.perf_counter()
    res = subprocess.run([str(bin_path)], capture_output=True, text=True, check=True)
    dt = round(time.perf_counter() - t1, 3)
    hits = int(res.stdout.strip().split()[-1])
    out = {"slice_id": slice_id, "hits": hits, "sec": dt}
    (work_dir / f"dffff_slice_{slice_id}.json").write_text(json.dumps(out, indent=2), encoding="utf-8")
    print(json.dumps(out), flush=True)


if __name__ == "__main__":
    main()

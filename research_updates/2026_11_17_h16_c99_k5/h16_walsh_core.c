#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define NUM_LONG 112
#define NUM_ORBITS 4116
#define WORDS_64 65
#define BYTES_8 515
#define MAX_TESTS 32
#define MAX_SURVIVORS 1024

typedef struct {
    uint64_t total_tuples;
    uint64_t admissible;
    uint64_t fail_counts[MAX_TESTS];
    uint64_t fwht_checked;
    uint64_t fwht_fail;
    uint64_t bent_found;
    int32_t  first_fwht_fail_freq[MAX_SURVIVORS];
    int32_t  bent_candidates[MAX_SURVIVORS][8]; /* [dense, k, i0..i4, c57] */
} BatchResult;

typedef struct {
    uint64_t long_tables[NUM_LONG][WORDS_64];
    uint64_t base_sparse_0[WORDS_64]; /* c99=1, c57=c113=0 */
    uint64_t base_sparse_1[WORDS_64]; /* c99=1, c57=c113=1 */
    uint64_t base_dense_0[WORDS_64];  /* dense ^ c99=1, c57=c113=0 */
    uint64_t base_dense_1[WORDS_64];  /* dense ^ c99=1, c57=c113=1 */

    uint8_t is_L[NUM_LONG];
    uint8_t is_R[NUM_LONG];
    uint8_t is_K[NUM_LONG];
    int32_t long_orbit_ids[NUM_LONG];

    uint32_t n16; /* number of size-16 input orbits (stored first) */
    uint64_t mask16_tail; /* bitmask for word n16/64 */
    uint32_t n_short; /* 4116 - n16 */
    uint16_t short_idx[128];
    uint8_t  short_size[128];

    int32_t n_tests;
    uint16_t test_freqs[MAX_TESTS]; /* test_freqs[0] must be 0 */
    int16_t byte_luts[MAX_TESTS][BYTES_8][256]; /* for tests 1..n_tests-1 */

    uint16_t x_to_orbit[65536];
} H16Context;

static inline int32_t eval_wf0(const H16Context *ctx, const uint64_t *f) {
    uint32_t full_words = ctx->n16 / 64;
    uint32_t ones16 = 0;
    for (uint32_t w = 0; w < full_words; w++) {
        ones16 += (uint32_t)__builtin_popcountll(f[w]);
    }
    if (ctx->mask16_tail) {
        ones16 += (uint32_t)__builtin_popcountll(f[full_words] & ctx->mask16_tail);
    }
    int32_t sum_ones_w = (int32_t)ones16 * 16;
    for (uint32_t s = 0; s < ctx->n_short; s++) {
        uint16_t idx = ctx->short_idx[s];
        if ((f[idx >> 6] >> (idx & 63)) & 1ULL) {
            sum_ones_w += (int32_t)ctx->short_size[s];
        }
    }
    return 65536 - 2 * sum_ones_w;
}

static inline int32_t eval_wfb_nonzero(const H16Context *ctx, int t_idx, const uint64_t *f) {
    const uint8_t *fb = (const uint8_t *)f;
    const int16_t (*lut)[256] = ctx->byte_luts[t_idx];
    int32_t sum = 0;
    for (uint32_t i = 0; i < BYTES_8; i++) {
        sum += lut[i][fb[i]];
    }
    return -2 * sum;
}

static int run_full_fwht(const H16Context *ctx, const uint64_t *f, int32_t *first_fail_b) {
    int32_t *a = (int32_t *)malloc(65536 * sizeof(int32_t));
    if (!a) return -1;
    for (uint32_t x = 0; x < 65536; x++) {
        uint16_t o = ctx->x_to_orbit[x];
        uint64_t bit = (f[o >> 6] >> (o & 63)) & 1ULL;
        a[x] = bit ? -1 : 1;
    }
    for (uint32_t len = 1; len < 65536; len <<= 1) {
        for (uint32_t i = 0; i < 65536; i += (len << 1)) {
            for (uint32_t j = 0; j < len; j++) {
                int32_t u = a[i + j];
                int32_t v = a[i + j + len];
                a[i + j] = u + v;
                a[i + j + len] = u - v;
            }
        }
    }
    int fail = 0;
    *first_fail_b = -1;
    for (int32_t b = 0; b < 65536; b++) {
        int32_t val = a[b];
        if (val != 256 && val != -256) {
            fail = 1;
            *first_fail_b = b;
            break;
        }
    }
    free(a);
    return fail ? 0 : 1; /* 1 = BENT, 0 = not bent */
}

static void test_candidate(const H16Context *ctx, const uint64_t *f, int dense, int k,
                           const int *sel, int c57, BatchResult *res) {
    int32_t w0 = eval_wf0(ctx, f);
    if (w0 != 256 && w0 != -256) {
        res->fail_counts[0]++;
        return;
    }
    for (int t = 1; t < ctx->n_tests; t++) {
        int32_t wb = eval_wfb_nonzero(ctx, t, f);
        if (wb != 256 && wb != -256) {
            res->fail_counts[t]++;
            return;
        }
    }
    /* Passed all initial tests -> run full FWHT */
    int32_t fail_b = -1;
    int is_bent = run_full_fwht(ctx, f, &fail_b);
    uint64_t idx = res->fwht_checked++;
    if (is_bent == 1) {
        uint64_t bidx = res->bent_found++;
        if (bidx < MAX_SURVIVORS) {
            res->bent_candidates[bidx][0] = dense;
            res->bent_candidates[bidx][1] = k;
            for (int j = 0; j < 5; j++) {
                res->bent_candidates[bidx][2 + j] = (j < k) ? ctx->long_orbit_ids[sel[j]] : -1;
            }
            res->bent_candidates[bidx][7] = c57;
        }
    } else {
        res->fwht_fail++;
        if (idx < MAX_SURVIVORS) {
            res->first_fwht_fail_freq[idx] = fail_b;
        }
    }
}

/* Validate orbit-weighted W_f(b) against direct 65536-entry sum */
int32_t validate_candidate_wfb(const H16Context *ctx, const uint64_t *f, int t_idx, int32_t *out_direct) {
    int32_t fast_val = (t_idx == 0) ? eval_wf0(ctx, f) : eval_wfb_nonzero(ctx, t_idx, f);
    uint16_t b = ctx->test_freqs[t_idx];
    int32_t direct = 0;
    for (uint32_t x = 0; x < 65536; x++) {
        uint16_t o = ctx->x_to_orbit[x];
        uint64_t fbit = (f[o >> 6] >> (o & 63)) & 1ULL;
        uint32_t bx = (uint32_t)__builtin_popcount(b & x) & 1U;
        direct += (fbit ^ bx) ? -1 : 1;
    }
    *out_direct = direct;
    return fast_val;
}

void run_k5_batch(const H16Context *ctx, int dense, int i0, BatchResult *res) {
    memset(res, 0, sizeof(BatchResult));
    if (i0 < 0 || i0 > NUM_LONG - 5) return;

    const uint64_t *base0 = dense ? ctx->base_dense_0 : ctx->base_sparse_0;
    const uint64_t *base1 = dense ? ctx->base_dense_1 : ctx->base_sparse_1;

    uint8_t l0 = ctx->is_L[i0], r0 = ctx->is_R[i0], k0 = ctx->is_K[i0];
    uint64_t f1[WORDS_64], f2[WORDS_64], f3[WORDS_64], f4[WORDS_64], f5[WORDS_64];
    const uint64_t *t0 = ctx->long_tables[i0];

    for (int i1 = i0 + 1; i1 <= NUM_LONG - 4; i1++) {
        uint8_t l1 = l0 ^ ctx->is_L[i1];
        uint8_t r1 = r0 ^ ctx->is_R[i1];
        uint8_t k1 = k0 ^ ctx->is_K[i1];
        const uint64_t *t1 = ctx->long_tables[i1];
        for (int w = 0; w < WORDS_64; w++) f1[w] = t0[w] ^ t1[w];

        for (int i2 = i1 + 1; i2 <= NUM_LONG - 3; i2++) {
            uint8_t l2 = l1 ^ ctx->is_L[i2];
            uint8_t r2 = r1 ^ ctx->is_R[i2];
            uint8_t k2 = k1 ^ ctx->is_K[i2];
            const uint64_t *t2 = ctx->long_tables[i2];
            for (int w = 0; w < WORDS_64; w++) f2[w] = f1[w] ^ t2[w];

            for (int i3 = i2 + 1; i3 <= NUM_LONG - 2; i3++) {
                uint8_t l3 = l2 ^ ctx->is_L[i3];
                uint8_t r3 = r2 ^ ctx->is_R[i3];
                uint8_t k3 = k2 ^ ctx->is_K[i3];
                const uint64_t *t3 = ctx->long_tables[i3];
                for (int w = 0; w < WORDS_64; w++) f3[w] = f2[w] ^ t3[w];

                for (int i4 = i3 + 1; i4 <= NUM_LONG - 1; i4++) {
                    res->total_tuples++;
                    /* |L|=16 (even), |R|=24 (even), |K|=32 (even) -> parity of A equals parity of D */
                    if ((l3 ^ ctx->is_L[i4]) != 1) continue;
                    if ((r3 ^ ctx->is_R[i4]) != 0) continue;

                    res->admissible++;
                    uint8_t c57 = k3 ^ ctx->is_K[i4];
                    const uint64_t *base = c57 ? base1 : base0;
                    const uint64_t *t4 = ctx->long_tables[i4];
                    for (int w = 0; w < WORDS_64; w++) {
                        f4[w] = f3[w] ^ t4[w] ^ base[w];
                    }
                    int sel[5] = {i0, i1, i2, i3, i4};
                    test_candidate(ctx, f4, dense, 5, sel, c57, res);
                }
            }
        }
    }
}

void run_control_k0_4(const H16Context *ctx, int dense, BatchResult *res) {
    memset(res, 0, sizeof(BatchResult));
    const uint64_t *base0 = dense ? ctx->base_dense_0 : ctx->base_sparse_0;
    const uint64_t *base1 = dense ? ctx->base_dense_1 : ctx->base_sparse_1;
    uint64_t f[WORDS_64];
    int sel[5] = {-1, -1, -1, -1, -1};

    /* k = 0 */
    res->total_tuples++;

    /* k = 1 */
    for (int i0 = 0; i0 < NUM_LONG; i0++) {
        res->total_tuples++;
        if (ctx->is_L[i0] == 1 && ctx->is_R[i0] == 0) {
            res->admissible++;
            uint8_t c57 = ctx->is_K[i0];
            const uint64_t *base = c57 ? base1 : base0;
            for (int w = 0; w < WORDS_64; w++) f[w] = ctx->long_tables[i0][w] ^ base[w];
            sel[0] = i0;
            test_candidate(ctx, f, dense, 1, sel, c57, res);
        }
    }

    /* k = 2 */
    for (int i0 = 0; i0 < NUM_LONG - 1; i0++) {
        for (int i1 = i0 + 1; i1 < NUM_LONG; i1++) {
            res->total_tuples++;
            if ((ctx->is_L[i0] ^ ctx->is_L[i1]) == 1 && (ctx->is_R[i0] ^ ctx->is_R[i1]) == 0) {
                res->admissible++;
                uint8_t c57 = ctx->is_K[i0] ^ ctx->is_K[i1];
                const uint64_t *base = c57 ? base1 : base0;
                for (int w = 0; w < WORDS_64; w++) {
                    f[w] = ctx->long_tables[i0][w] ^ ctx->long_tables[i1][w] ^ base[w];
                }
                sel[0] = i0; sel[1] = i1;
                test_candidate(ctx, f, dense, 2, sel, c57, res);
            }
        }
    }

    /* k = 3 */
    for (int i0 = 0; i0 < NUM_LONG - 2; i0++) {
        for (int i1 = i0 + 1; i1 < NUM_LONG - 1; i1++) {
            uint8_t l1 = ctx->is_L[i0] ^ ctx->is_L[i1];
            uint8_t r1 = ctx->is_R[i0] ^ ctx->is_R[i1];
            uint8_t k1 = ctx->is_K[i0] ^ ctx->is_K[i1];
            for (int i2 = i1 + 1; i2 < NUM_LONG; i2++) {
                res->total_tuples++;
                if ((l1 ^ ctx->is_L[i2]) == 1 && (r1 ^ ctx->is_R[i2]) == 0) {
                    res->admissible++;
                    uint8_t c57 = k1 ^ ctx->is_K[i2];
                    const uint64_t *base = c57 ? base1 : base0;
                    for (int w = 0; w < WORDS_64; w++) {
                        f[w] = ctx->long_tables[i0][w] ^ ctx->long_tables[i1][w] ^ ctx->long_tables[i2][w] ^ base[w];
                    }
                    sel[0] = i0; sel[1] = i1; sel[2] = i2;
                    test_candidate(ctx, f, dense, 3, sel, c57, res);
                }
            }
        }
    }

    /* k = 4 */
    uint64_t f2[WORDS_64];
    for (int i0 = 0; i0 < NUM_LONG - 3; i0++) {
        for (int i1 = i0 + 1; i1 < NUM_LONG - 2; i1++) {
            uint8_t l1 = ctx->is_L[i0] ^ ctx->is_L[i1];
            uint8_t r1 = ctx->is_R[i0] ^ ctx->is_R[i1];
            uint8_t k1 = ctx->is_K[i0] ^ ctx->is_K[i1];
            for (int i2 = i1 + 1; i2 < NUM_LONG - 1; i2++) {
                uint8_t l2 = l1 ^ ctx->is_L[i2];
                uint8_t r2 = r1 ^ ctx->is_R[i2];
                uint8_t k2 = k1 ^ ctx->is_K[i2];
                for (int w = 0; w < WORDS_64; w++) {
                    f2[w] = ctx->long_tables[i0][w] ^ ctx->long_tables[i1][w] ^ ctx->long_tables[i2][w];
                }
                for (int i3 = i2 + 1; i3 < NUM_LONG; i3++) {
                    res->total_tuples++;
                    if ((l2 ^ ctx->is_L[i3]) == 1 && (r2 ^ ctx->is_R[i3]) == 0) {
                        res->admissible++;
                        uint8_t c57 = k2 ^ ctx->is_K[i3];
                        const uint64_t *base = c57 ? base1 : base0;
                        for (int w = 0; w < WORDS_64; w++) {
                            f[w] = f2[w] ^ ctx->long_tables[i3][w] ^ base[w];
                        }
                        sel[0] = i0; sel[1] = i1; sel[2] = i2; sel[3] = i3;
                        test_candidate(ctx, f, dense, 4, sel, c57, res);
                    }
                }
            }
        }
    }
}

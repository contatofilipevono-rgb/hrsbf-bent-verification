#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#define NUM_LONG 112
#define NUM_ORBITS 4116
#define WORDS_64 65
#define BYTES_8 515

typedef struct {
    uint64_t long_tables[NUM_LONG][WORDS_64];
    uint64_t base_0[WORDS_64];
    uint64_t base_1[WORDS_64];
    uint64_t diff_57_113[WORDS_64];

    int32_t long_orbit_ids[NUM_LONG];
    int32_t orbit_to_long_pos[116];

    uint64_t mask_L_lo, mask_L_hi;
    uint64_t mask_R_lo, mask_R_hi;
    uint64_t mask_K_lo, mask_K_hi;
    uint64_t q4_lin_lo, q4_lin_hi;
    uint64_t q4_I_lo[4], q4_I_hi[4];
    uint64_t q4_J_lo[4], q4_J_hi[4];
    int32_t pos_0, pos_5, pos_23;

    int32_t c6_len;
    uint64_t *c6_lo;
    uint64_t *c6_hi;

    int32_t free_109_pos[109];

    uint32_t n16;
    uint64_t mask16_tail;
    uint32_t n_short;
    uint16_t short_idx[128];
    uint8_t  short_size[128];

    int16_t e0_lut[BYTES_8][256];
    int16_t odd_luts[4][BYTES_8][256];  /* d = 1, 3, 5, 7: 0x0003, 0x0009, 0x0021, 0x0081 */
    int16_t even_luts[4][BYTES_8][256]; /* d = 2, 4, 6, 8: 0x0005, 0x0011, 0x0041, 0x0101 */
} EvenPairsCtx;

typedef struct {
    uint64_t tested;
    uint64_t pass_w0;
    uint64_t pass_w0_we0;
    uint64_t pass_0x55_c157;
    uint64_t pass_0x55_c7;
    uint64_t even_hist_c7[16]; /* 4-bit even mask (bit0=d2, bit1=d4, bit2=d6, bit3=d8) */
    uint8_t  has_ex[16];
    uint64_t ex_c_lo[16];
    uint64_t ex_c_hi[16];
    int32_t  ex_odd_vals[16][4];
    int32_t  ex_even_vals[16][4];
} EvenPairsStats;

static inline uint64_t splitmix64(uint64_t *x) {
    uint64_t z = (*x += 0x9e3779b97f4a7c15ULL);
    z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ULL;
    z = (z ^ (z >> 27)) * 0x94d049bb133111ebULL;
    return z ^ (z >> 31);
}

static inline int parity128(uint64_t a_lo, uint64_t a_hi, uint64_t b_lo, uint64_t b_hi) {
    return (__builtin_popcountll(a_lo & b_lo) + __builtin_popcountll(a_hi & b_hi)) & 1;
}

static inline void xor_table(uint64_t *dst, const uint64_t *src) {
    for (int w = 0; w < WORDS_64; w++) dst[w] ^= src[w];
}

static inline int32_t eval_wf0(const EvenPairsCtx *ctx, const uint64_t *f) {
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

static inline int32_t eval_lut(const int16_t lut[BYTES_8][256], const uint64_t *f) {
    const uint8_t *fb = (const uint8_t *)f;
    int32_t sum = 0;
    for (uint32_t i = 0; i < BYTES_8; i++) {
        sum += lut[i][fb[i]];
    }
    return -2 * sum;
}

static int eval_c6(const EvenPairsCtx *ctx, uint64_t c_lo, uint64_t c_hi) {
    int acc = 0;
    const uint64_t *mlo = ctx->c6_lo;
    const uint64_t *mhi = ctx->c6_hi;
    int32_t n = ctx->c6_len;
    for (int32_t i = 0; i < n; i++) {
        if (((c_lo & mlo[i]) == mlo[i]) && ((c_hi & mhi[i]) == mhi[i])) {
            acc ^= 1;
        }
    }
    return acc;
}

static inline void reconstruct_c(const EvenPairsCtx *ctx, uint64_t p_lo, uint64_t p_hi,
                                 uint64_t *out_p_lo, uint64_t *out_p_hi,
                                 uint64_t *out_c_lo, uint64_t *out_c_hi, int *out_c57) {
    if (parity128(p_lo, p_hi, ctx->mask_R_lo, ctx->mask_R_hi)) {
        if (ctx->pos_5 < 64) p_lo |= (1ULL << ctx->pos_5);
        else p_hi |= (1ULL << (ctx->pos_5 - 64));
    }
    if (parity128(p_lo, p_hi, ctx->mask_L_lo, ctx->mask_L_hi) == 0) {
        if (ctx->pos_0 < 64) p_lo |= (1ULL << ctx->pos_0);
        else p_hi |= (1ULL << (ctx->pos_0 - 64));
    }
    uint64_t c_lo = 0, c_hi = 0;
    uint64_t tmp = p_lo;
    while (tmp) {
        int pos = __builtin_ctzll(tmp);
        tmp &= tmp - 1;
        int oid = ctx->long_orbit_ids[pos];
        if (oid < 64) c_lo |= (1ULL << oid);
        else c_hi |= (1ULL << (oid - 64));
    }
    tmp = p_hi;
    while (tmp) {
        int pos = 64 + __builtin_ctzll(tmp);
        tmp &= tmp - 1;
        int oid = ctx->long_orbit_ids[pos];
        if (oid < 64) c_lo |= (1ULL << oid);
        else c_hi |= (1ULL << (oid - 64));
    }
    int c57 = parity128(p_lo, p_hi, ctx->mask_K_lo, ctx->mask_K_hi);
    c_hi |= (1ULL << (99 - 64));
    if (c57) {
        c_lo |= (1ULL << 57);
        c_hi |= (1ULL << (113 - 64));
    }
    int q4 = parity128(c_lo, c_hi, ctx->q4_lin_lo, ctx->q4_lin_hi);
    for (int b = 0; b < 4; b++) {
        q4 ^= (parity128(c_lo, c_hi, ctx->q4_I_lo[b], ctx->q4_I_hi[b]) &
               parity128(c_lo, c_hi, ctx->q4_J_lo[b], ctx->q4_J_hi[b]));
    }
    if (q4) {
        c_lo |= (1ULL << 23);
        if (ctx->pos_23 < 64) p_lo |= (1ULL << ctx->pos_23);
        else p_hi |= (1ULL << (ctx->pos_23 - 64));
    }
    *out_p_lo = p_lo;
    *out_p_hi = p_hi;
    *out_c_lo = c_lo;
    *out_c_hi = c_hi;
    *out_c57 = c57;
}

static void build_truth_table(const EvenPairsCtx *ctx, uint64_t p_lo, uint64_t p_hi, int c57, uint64_t *f) {
    const uint64_t *base = c57 ? ctx->base_1 : ctx->base_0;
    memcpy(f, base, WORDS_64 * sizeof(uint64_t));
    uint64_t tmp = p_lo;
    while (tmp) {
        int pos = __builtin_ctzll(tmp);
        tmp &= tmp - 1;
        xor_table(f, ctx->long_tables[pos]);
    }
    tmp = p_hi;
    while (tmp) {
        int pos = 64 + __builtin_ctzll(tmp);
        tmp &= tmp - 1;
        xor_table(f, ctx->long_tables[pos]);
    }
}

static inline void eval_and_record(const EvenPairsCtx *ctx, const uint64_t *f,
                                   uint64_t c_lo, uint64_t c_hi, EvenPairsStats *stats) {
    stats->tested++;
    int32_t w0 = eval_wf0(ctx, f);
    if (w0 != 256 && w0 != -256) return;
    stats->pass_w0++;

    int32_t we0 = eval_lut(ctx->e0_lut, f);
    if (we0 != 256 && we0 != -256) return;
    stats->pass_w0_we0++;

    int32_t odd_vals[4];
    for (int i = 0; i < 4; i++) {
        int32_t v = eval_lut(ctx->odd_luts[i], f);
        if (v != 256 && v != -256) return;
        odd_vals[i] = v;
    }
    stats->pass_0x55_c157++;

    if (eval_c6(ctx, c_lo, c_hi) != 0) return;
    stats->pass_0x55_c7++;

    uint8_t emask = 0;
    int32_t even_vals[4];
    for (int i = 0; i < 4; i++) {
        int32_t v = eval_lut(ctx->even_luts[i], f);
        even_vals[i] = v;
        if (v == 256 || v == -256) emask |= (uint8_t)(1U << i);
    }
    stats->even_hist_c7[emask]++;
    if (!stats->has_ex[emask]) {
        stats->has_ex[emask] = 1;
        stats->ex_c_lo[emask] = c_lo;
        stats->ex_c_hi[emask] = c_hi;
        for (int i = 0; i < 4; i++) {
            stats->ex_odd_vals[emask][i] = odd_vals[i];
            stats->ex_even_vals[emask][i] = even_vals[i];
        }
    }
}

/* Fast incremental random walk in C1..C5+C7 (only ~2-5 table XORs per step!) */
void run_walk_search(const EvenPairsCtx *ctx, uint64_t seed, int k_min, int k_max,
                     uint64_t n_steps, EvenPairsStats *stats) {
    memset(stats, 0, sizeof(EvenPairsStats));
    uint64_t rng = seed;

    /* Initialize random state with k_free near midpoint */
    int k_mid = (k_min + k_max) / 2;
    uint8_t pool[109];
    for (int i = 0; i < 109; i++) pool[i] = (uint8_t)i;
    for (int i = 0; i < k_mid; i++) {
        int j = i + (int)(splitmix64(&rng) % (uint64_t)(109 - i));
        uint8_t tmp = pool[i]; pool[i] = pool[j]; pool[j] = tmp;
    }
    uint64_t p_lo = 0, p_hi = 0;
    for (int i = 0; i < k_mid; i++) {
        int pos = ctx->free_109_pos[pool[i]];
        if (pos < 64) p_lo |= (1ULL << pos);
        else p_hi |= (1ULL << (pos - 64));
    }

    uint64_t cur_p_lo, cur_p_hi, cur_c_lo, cur_c_hi;
    int cur_c57;
    reconstruct_c(ctx, p_lo, p_hi, &cur_p_lo, &cur_p_hi, &cur_c_lo, &cur_c_hi, &cur_c57);
    uint64_t f[WORDS_64];
    build_truth_table(ctx, cur_p_lo, cur_p_hi, cur_c57, f);

    for (uint64_t s = 0; s < n_steps; s++) {
        /* Flip 1 free bit (or 2 if outside [k_min+2, k_max-2]) */
        int idx1 = (int)(splitmix64(&rng) % 109ULL);
        int pos1 = ctx->free_109_pos[idx1];
        if (pos1 < 64) p_lo ^= (1ULL << pos1);
        else p_hi ^= (1ULL << (pos1 - 64));

        int k_free = __builtin_popcountll(p_lo) + __builtin_popcountll(p_hi);
        if (k_free < k_min || k_free > k_max) {
            /* Revert and pick a swap */
            if (pos1 < 64) p_lo ^= (1ULL << pos1);
            else p_hi ^= (1ULL << (pos1 - 64));
            int idx2 = (int)(splitmix64(&rng) % 109ULL);
            int pos2 = ctx->free_109_pos[idx2];
            /* Toggle both if different */
            if (pos1 != pos2) {
                int b1 = (pos1 < 64) ? ((p_lo >> pos1) & 1) : ((p_hi >> (pos1 - 64)) & 1);
                int b2 = (pos2 < 64) ? ((p_lo >> pos2) & 1) : ((p_hi >> (pos2 - 64)) & 1);
                if (b1 != b2) {
                    if (pos1 < 64) p_lo ^= (1ULL << pos1); else p_hi ^= (1ULL << (pos1 - 64));
                    if (pos2 < 64) p_lo ^= (1ULL << pos2); else p_hi ^= (1ULL << (pos2 - 64));
                }
            }
        }

        uint64_t nxt_p_lo, nxt_p_hi, nxt_c_lo, nxt_c_hi;
        int nxt_c57;
        reconstruct_c(ctx, p_lo, p_hi, &nxt_p_lo, &nxt_p_hi, &nxt_c_lo, &nxt_c_hi, &nxt_c57);

        /* Incremental XOR update of f */
        uint64_t d_lo = cur_p_lo ^ nxt_p_lo;
        uint64_t d_hi = cur_p_hi ^ nxt_p_hi;
        while (d_lo) {
            int pos = __builtin_ctzll(d_lo);
            d_lo &= d_lo - 1;
            xor_table(f, ctx->long_tables[pos]);
        }
        while (d_hi) {
            int pos = 64 + __builtin_ctzll(d_hi);
            d_hi &= d_hi - 1;
            xor_table(f, ctx->long_tables[pos]);
        }
        if (cur_c57 != nxt_c57) {
            xor_table(f, ctx->diff_57_113);
        }
        cur_p_lo = nxt_p_lo; cur_p_hi = nxt_p_hi;
        cur_c_lo = nxt_c_lo; cur_c_hi = nxt_c_hi;
        cur_c57 = nxt_c57;

        int k_long = __builtin_popcountll(cur_p_lo) + __builtin_popcountll(cur_p_hi);
        if (k_long < 6 || k_long > 106) continue;

        eval_and_record(ctx, f, cur_c_lo, cur_c_hi, stats);
    }
}

/* Directed neighborhood search around a given 116-bit seed vector */
void run_directed_search(const EvenPairsCtx *ctx, uint64_t seed_c_lo, uint64_t seed_c_hi,
                         uint64_t rng_seed, uint64_t n_random, EvenPairsStats *stats) {
    memset(stats, 0, sizeof(EvenPairsStats));

    /* Extract the 109 free bits from seed_c */
    uint64_t base_p_lo = 0, base_p_hi = 0;
    for (int i = 0; i < 109; i++) {
        int pos = ctx->free_109_pos[i];
        int oid = ctx->long_orbit_ids[pos];
        int bit = (oid < 64) ? (int)((seed_c_lo >> oid) & 1ULL) : (int)((seed_c_hi >> (oid - 64)) & 1ULL);
        if (bit) {
            if (pos < 64) base_p_lo |= (1ULL << pos);
            else base_p_hi |= (1ULL << (pos - 64));
        }
    }

    uint64_t f[WORDS_64];
    /* 1. Exhaustive 1-bit and 2-bit flips in the 109 free coordinates (109 + 5886 = 5995) */
    for (int i = 0; i < 109; i++) {
        int pos1 = ctx->free_109_pos[i];
        uint64_t p_lo = base_p_lo, p_hi = base_p_hi;
        if (pos1 < 64) p_lo ^= (1ULL << pos1); else p_hi ^= (1ULL << (pos1 - 64));
        uint64_t fp_lo, fp_hi, c_lo, c_hi; int c57;
        reconstruct_c(ctx, p_lo, p_hi, &fp_lo, &fp_hi, &c_lo, &c_hi, &c57);
        int k_long = __builtin_popcountll(fp_lo) + __builtin_popcountll(fp_hi);
        if (k_long >= 6 && k_long <= 106) {
            build_truth_table(ctx, fp_lo, fp_hi, c57, f);
            eval_and_record(ctx, f, c_lo, c_hi, stats);
        }
        for (int j = i + 1; j < 109; j++) {
            int pos2 = ctx->free_109_pos[j];
            uint64_t p2_lo = p_lo, p2_hi = p_hi;
            if (pos2 < 64) p2_lo ^= (1ULL << pos2); else p2_hi ^= (1ULL << (pos2 - 64));
            reconstruct_c(ctx, p2_lo, p2_hi, &fp_lo, &fp_hi, &c_lo, &c_hi, &c57);
            k_long = __builtin_popcountll(fp_lo) + __builtin_popcountll(fp_hi);
            if (k_long >= 6 && k_long <= 106) {
                build_truth_table(ctx, fp_lo, fp_hi, c57, f);
                eval_and_record(ctx, f, c_lo, c_hi, stats);
            }
        }
    }

    /* 2. Random 3..8-bit perturbations around seed_c */
    uint64_t rng = rng_seed;
    for (uint64_t s = 0; s < n_random; s++) {
        int flips = 3 + (int)(splitmix64(&rng) % 6ULL);
        uint64_t p_lo = base_p_lo, p_hi = base_p_hi;
        for (int k = 0; k < flips; k++) {
            int pos = ctx->free_109_pos[splitmix64(&rng) % 109ULL];
            if (pos < 64) p_lo ^= (1ULL << pos); else p_hi ^= (1ULL << (pos - 64));
        }
        uint64_t fp_lo, fp_hi, c_lo, c_hi; int c57;
        reconstruct_c(ctx, p_lo, p_hi, &fp_lo, &fp_hi, &c_lo, &c_hi, &c57);
        int k_long = __builtin_popcountll(fp_lo) + __builtin_popcountll(fp_hi);
        if (k_long >= 6 && k_long <= 106) {
            build_truth_table(ctx, fp_lo, fp_hi, c57, f);
            eval_and_record(ctx, f, c_lo, c_hi, stats);
        }
    }
}

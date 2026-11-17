#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#define NUM_LONG 112
#define NUM_ORBITS 4116
#define WORDS_64 65
#define BYTES_8 515
#define MAX_HITS 256

typedef struct {
    uint64_t long_tables[NUM_LONG][WORDS_64]; /* indexed by orbit_id? No, 0..111 -> long_orbit_ids[i] */
    uint64_t base_0[WORDS_64]; /* c99=1, c57=c113=0 */
    uint64_t base_1[WORDS_64]; /* c99=1, c57=c113=1 */

    int32_t long_orbit_ids[NUM_LONG];
    int32_t orbit_to_long_pos[116]; /* -1 if short */

    /* Bitmasks over 0..111 (long_pos) for L\{0}, R\{5}, K, Q4 */
    uint64_t mask_L_lo, mask_L_hi;
    uint64_t mask_R_lo, mask_R_hi;
    uint64_t mask_K_lo, mask_K_hi;
    uint64_t q4_lin_lo, q4_lin_hi;
    uint64_t q4_I_lo[4], q4_I_hi[4];
    uint64_t q4_J_lo[4], q4_J_hi[4];
    int32_t pos_0, pos_5, pos_23;

    /* C6 polynomial in 116-bit orbit coordinates */
    int32_t c6_len;
    uint64_t *c6_lo;
    uint64_t *c6_hi;

    /* 109 free long positions (excluding pos_0, pos_5, pos_23) */
    int32_t free_109_pos[109];

    uint32_t n16;
    uint64_t mask16_tail;
    uint32_t n_short;
    uint16_t short_idx[128];
    uint8_t  short_size[128];

    int16_t e0_lut[BYTES_8][256];
} InteriorCtx;

typedef struct {
    uint64_t c157_tested;
    uint64_t c7_tested;
    uint64_t pass_w0;
    uint64_t pass_both;
    uint64_t pass_both_c7;
    uint64_t n_hits;
    uint64_t hit_c_lo[MAX_HITS];
    uint64_t hit_c_hi[MAX_HITS];
    int32_t  hit_c6_pass[MAX_HITS];
    int32_t  hit_A[MAX_HITS];
    int32_t  hit_B[MAX_HITS];
    /* Modular counts for C7-valid samples: A mod 512 (index 0..511 -> 8 buckets of 64) */
    uint64_t mod512_AB[8][8]; /* (A % 512)/64, (B % 512)/64 */
    uint64_t mod256_A[4];
    uint64_t mod256_B[4];
} SearchStats;

static inline uint64_t splitmix64(uint64_t *x) {
    uint64_t z = (*x += 0x9e3779b97f4a7c15ULL);
    z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ULL;
    z = (z ^ (z >> 27)) * 0x94d049bb133111ebULL;
    return z ^ (z >> 31);
}

static inline int parity128(uint64_t a_lo, uint64_t a_hi, uint64_t b_lo, uint64_t b_hi) {
    return (__builtin_popcountll(a_lo & b_lo) + __builtin_popcountll(a_hi & b_hi)) & 1;
}

static inline int32_t eval_wf0(const InteriorCtx *ctx, const uint64_t *f) {
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

static inline int32_t eval_wfe0(const InteriorCtx *ctx, const uint64_t *f) {
    const uint8_t *fb = (const uint8_t *)f;
    int32_t sum = 0;
    for (uint32_t i = 0; i < BYTES_8; i++) {
        sum += ctx->e0_lut[i][fb[i]];
    }
    return -2 * sum;
}

static int eval_c6(const InteriorCtx *ctx, uint64_t c_lo, uint64_t c_hi) {
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

/* Reconstruct full 116-bit vector c from 109-bit long-pos mask p_lo, p_hi */
static inline void reconstruct_c(const InteriorCtx *ctx, uint64_t p_lo, uint64_t p_hi,
                                 uint64_t *out_p_lo, uint64_t *out_p_hi,
                                 uint64_t *out_c_lo, uint64_t *out_c_hi, int *out_c57) {
    /* Set c_5 (pos_5) so parity(R) == 0 */
    if (parity128(p_lo, p_hi, ctx->mask_R_lo, ctx->mask_R_hi)) {
        if (ctx->pos_5 < 64) p_lo |= (1ULL << ctx->pos_5);
        else p_hi |= (1ULL << (ctx->pos_5 - 64));
    }
    /* Set c_0 (pos_0) so parity(L) == 1 */
    if (parity128(p_lo, p_hi, ctx->mask_L_lo, ctx->mask_L_hi) == 0) {
        if (ctx->pos_0 < 64) p_lo |= (1ULL << ctx->pos_0);
        else p_hi |= (1ULL << (ctx->pos_0 - 64));
    }
    /* Convert long_pos mask p -> 116-bit orbit_id mask c */
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
    /* Short orbits: c99=1, c57=c113=parity(K) */
    int c57 = parity128(p_lo, p_hi, ctx->mask_K_lo, ctx->mask_K_hi);
    c_hi |= (1ULL << (99 - 64));
    if (c57) {
        c_lo |= (1ULL << 57);
        c_hi |= (1ULL << (113 - 64));
    }
    /* Set c_23 so Q4 == 0 (note 23 is in q4_lin, not in products) */
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

static void build_truth_table(const InteriorCtx *ctx, uint64_t p_lo, uint64_t p_hi, int c57, uint64_t *f) {
    const uint64_t *base = c57 ? ctx->base_1 : ctx->base_0;
    memcpy(f, base, WORDS_64 * sizeof(uint64_t));
    uint64_t tmp = p_lo;
    while (tmp) {
        int pos = __builtin_ctzll(tmp);
        tmp &= tmp - 1;
        const uint64_t *t = ctx->long_tables[pos];
        for (int w = 0; w < WORDS_64; w++) f[w] ^= t[w];
    }
    tmp = p_hi;
    while (tmp) {
        int pos = 64 + __builtin_ctzll(tmp);
        tmp &= tmp - 1;
        const uint64_t *t = ctx->long_tables[pos];
        for (int w = 0; w < WORDS_64; w++) f[w] ^= t[w];
    }
}

void run_interior_search(const InteriorCtx *ctx, uint64_t seed, int k_min, int k_max,
                         uint64_t n_samples, int check_c6_first, SearchStats *stats) {
    memset(stats, 0, sizeof(SearchStats));
    uint64_t rng = seed;
    uint64_t f[WORDS_64];
    uint8_t pool[109];
    for (int i = 0; i < 109; i++) pool[i] = (uint8_t)i;

    for (uint64_t s = 0; s < n_samples; s++) {
        /* Choose target weight in [k_min, k_max] */
        int k_target = k_min + (int)(splitmix64(&rng) % (uint64_t)(k_max - k_min + 1));
        /* Adjust slightly for the 3 dependent bits (average ~1.5) */
        int k_free = k_target - 1;
        if (k_free < 3) k_free = 3;
        if (k_free > 106) k_free = 106;

        /* Partial Fisher-Yates for k_free distinct positions out of 109 */
        for (int i = 0; i < k_free; i++) {
            int j = i + (int)(splitmix64(&rng) % (uint64_t)(109 - i));
            uint8_t tmp = pool[i];
            pool[i] = pool[j];
            pool[j] = tmp;
        }
        uint64_t p_lo = 0, p_hi = 0;
        for (int i = 0; i < k_free; i++) {
            int pos = ctx->free_109_pos[pool[i]];
            if (pos < 64) p_lo |= (1ULL << pos);
            else p_hi |= (1ULL << (pos - 64));
        }

        uint64_t full_p_lo, full_p_hi, c_lo, c_hi;
        int c57;
        reconstruct_c(ctx, p_lo, p_hi, &full_p_lo, &full_p_hi, &c_lo, &c_hi, &c57);
        int k_long = __builtin_popcountll(full_p_lo) + __builtin_popcountll(full_p_hi);
        if (k_long < 6 || k_long > 106) continue;

        stats->c157_tested++;

        if (check_c6_first) {
            if (eval_c6(ctx, c_lo, c_hi) != 0) continue;
            stats->c7_tested++;
            build_truth_table(ctx, full_p_lo, full_p_hi, c57, f);
            int32_t w0 = eval_wf0(ctx, f);
            int32_t we0 = eval_wfe0(ctx, f);
            int32_t A = (w0 + we0) >> 1;
            int32_t B = (w0 - we0) >> 1;
            int ma512 = ((A % 512) + 512) % 512;
            int mb512 = ((B % 512) + 512) % 512;
            stats->mod512_AB[ma512 >> 6][mb512 >> 6]++;
            stats->mod256_A[(((A % 256) + 256) % 256) >> 6]++;
            stats->mod256_B[(((B % 256) + 256) % 256) >> 6]++;
            if (w0 == 256 || w0 == -256) {
                stats->pass_w0++;
                if (we0 == 256 || we0 == -256) {
                    stats->pass_both++;
                    stats->pass_both_c7++;
                    if (stats->n_hits < MAX_HITS) {
                        uint64_t h = stats->n_hits++;
                        stats->hit_c_lo[h] = c_lo;
                        stats->hit_c_hi[h] = c_hi;
                        stats->hit_c6_pass[h] = 1;
                        stats->hit_A[h] = A;
                        stats->hit_B[h] = B;
                    }
                }
            }
        } else {
            build_truth_table(ctx, full_p_lo, full_p_hi, c57, f);
            int32_t w0 = eval_wf0(ctx, f);
            if (w0 == 256 || w0 == -256) {
                stats->pass_w0++;
                int32_t we0 = eval_wfe0(ctx, f);
                if (we0 == 256 || we0 == -256) {
                    stats->pass_both++;
                    int c6_ok = (eval_c6(ctx, c_lo, c_hi) == 0) ? 1 : 0;
                    if (c6_ok) stats->pass_both_c7++;
                    if (stats->n_hits < MAX_HITS) {
                        uint64_t h = stats->n_hits++;
                        stats->hit_c_lo[h] = c_lo;
                        stats->hit_c_hi[h] = c_hi;
                        stats->hit_c6_pass[h] = c6_ok;
                        stats->hit_A[h] = (w0 + we0) >> 1;
                        stats->hit_B[h] = (w0 - we0) >> 1;
                    }
                }
            }
        }
    }
}

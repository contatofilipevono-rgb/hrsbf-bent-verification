#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#define NUM_LONG 112
#define NUM_ORBITS 4116
#define WORDS_64 65
#define BYTES_8 515
#define N_EXTRA_FREQS 11 /* u2=0x5555, u4=0x1111, u8=0x0101, e0+e1..e0+e8 */
#define MAX_SURVIVORS 128

typedef struct {
    uint64_t long_tables[NUM_LONG][WORDS_64];
    uint64_t base_0[WORDS_64];
    uint64_t base_1[WORDS_64];

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
    int16_t extra_luts[N_EXTRA_FREQS][BYTES_8][256];
    uint16_t extra_freqs[N_EXTRA_FREQS];
    uint16_t x_to_orbit[65536];
} CascadeCtx;

typedef struct {
    uint64_t c157_tested;
    uint64_t pass_w0;
    uint64_t pass_w0_we0;
    uint64_t pass_w0_we0_c7;
    /* Among pass_w0_we0_c7: how many pass each extra frequency individually, and how many survive cascade */
    uint64_t indiv_pass_c7[N_EXTRA_FREQS];
    uint64_t cascade_pass_c7[N_EXTRA_FREQS];
    /* Mod 128 histogram (0 = 0 mod 128, 1 = 64 mod 128, 2 = other) for each extra freq on C7 w0+we0 hits */
    uint64_t mod128_hist[N_EXTRA_FREQS][3];
    uint64_t fwht_checked;
    uint64_t bent_found;
    uint64_t n_survivors;
    uint64_t surv_c_lo[MAX_SURVIVORS];
    uint64_t surv_c_hi[MAX_SURVIVORS];
    int32_t  surv_fail_b[MAX_SURVIVORS];
    int32_t  surv_fail_val[MAX_SURVIVORS];
} CascadeStats;

static inline uint64_t splitmix64(uint64_t *x) {
    uint64_t z = (*x += 0x9e3779b97f4a7c15ULL);
    z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ULL;
    z = (z ^ (z >> 27)) * 0x94d049bb133111ebULL;
    return z ^ (z >> 31);
}

static inline int parity128(uint64_t a_lo, uint64_t a_hi, uint64_t b_lo, uint64_t b_hi) {
    return (__builtin_popcountll(a_lo & b_lo) + __builtin_popcountll(a_hi & b_hi)) & 1;
}

static inline int32_t eval_wf0(const CascadeCtx *ctx, const uint64_t *f) {
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

static int eval_c6(const CascadeCtx *ctx, uint64_t c_lo, uint64_t c_hi) {
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

static int run_full_fwht(const CascadeCtx *ctx, const uint64_t *f, int32_t *fail_b, int32_t *fail_val) {
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
    *fail_b = -1;
    *fail_val = 0;
    int bent = 1;
    for (int32_t b = 0; b < 65536; b++) {
        if (a[b] != 256 && a[b] != -256) {
            *fail_b = b;
            *fail_val = a[b];
            bent = 0;
            break;
        }
    }
    free(a);
    return bent;
}

static inline void reconstruct_c(const CascadeCtx *ctx, uint64_t p_lo, uint64_t p_hi,
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

static void build_truth_table(const CascadeCtx *ctx, uint64_t p_lo, uint64_t p_hi, int c57, uint64_t *f) {
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

void run_cascade_search(const CascadeCtx *ctx, uint64_t seed, int k_min, int k_max,
                        uint64_t n_samples, CascadeStats *stats) {
    memset(stats, 0, sizeof(CascadeStats));
    uint64_t rng = seed;
    uint64_t f[WORDS_64];
    uint8_t pool[109];
    for (int i = 0; i < 109; i++) pool[i] = (uint8_t)i;

    for (uint64_t s = 0; s < n_samples; s++) {
        int k_target = k_min + (int)(splitmix64(&rng) % (uint64_t)(k_max - k_min + 1));
        int k_free = k_target - 1;
        if (k_free < 3) k_free = 3;
        if (k_free > 106) k_free = 106;

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
        build_truth_table(ctx, full_p_lo, full_p_hi, c57, f);

        int32_t w0 = eval_wf0(ctx, f);
        if (w0 != 256 && w0 != -256) continue;
        stats->pass_w0++;

        int32_t we0 = eval_lut(ctx->e0_lut, f);
        if (we0 != 256 && we0 != -256) continue;
        stats->pass_w0_we0++;

        if (eval_c6(ctx, c_lo, c_hi) != 0) continue;
        stats->pass_w0_we0_c7++;

        int all_ok = 1;
        for (int q = 0; q < N_EXTRA_FREQS; q++) {
            int32_t wq = eval_lut(ctx->extra_luts[q], f);
            int32_t awq = wq < 0 ? -wq : wq;
            int r128 = awq & 127;
            if (r128 == 0) stats->mod128_hist[q][0]++;
            else if (r128 == 64) stats->mod128_hist[q][1]++;
            else stats->mod128_hist[q][2]++;

            int ok = (wq == 256 || wq == -256);
            if (ok) stats->indiv_pass_c7[q]++;
            else all_ok = 0;

            if (all_ok) stats->cascade_pass_c7[q]++;
        }

        if (all_ok) {
            stats->fwht_checked++;
            int32_t fb = -1, fv = 0;
            int bent = run_full_fwht(ctx, f, &fb, &fv);
            if (bent == 1) stats->bent_found++;
            if (stats->n_survivors < MAX_SURVIVORS) {
                uint64_t idx = stats->n_survivors++;
                stats->surv_c_lo[idx] = c_lo;
                stats->surv_c_hi[idx] = c_hi;
                stats->surv_fail_b[idx] = fb;
                stats->surv_fail_val[idx] = fv;
            }
        }
    }
}

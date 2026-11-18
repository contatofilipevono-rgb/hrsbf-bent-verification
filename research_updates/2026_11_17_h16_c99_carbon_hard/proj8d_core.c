#include <stdint.h>
#include <stdlib.h>

/* Evaluate all 2^n_free states of an 8D subspace (256 points) via FWHT */
void scan_subspace_8d(const uint64_t *orb_tt, const uint64_t *base_tt, int n_free,
                      int32_t *out_hist_max, uint64_t *out_pass_bounds,
                      uint64_t *out_pass_mod4, uint64_t *out_pass_mod16) {
    uint64_t n_states = 1ULL << n_free;
    int32_t a[256];
    *out_pass_bounds = 0;
    *out_pass_mod4 = 0;
    *out_pass_mod16 = 0;
    for (int i = 0; i <= 256; i++) out_hist_max[i] = 0;

    for (uint64_t s = 0; s < n_states; s++) {
        uint64_t tt[4] = {base_tt[0], base_tt[1], base_tt[2], base_tt[3]};
        uint64_t tmp = s;
        while (tmp) {
            int bit = __builtin_ctzll(tmp);
            tmp &= tmp - 1;
            const uint64_t *ot = orb_tt + 4 * bit;
            tt[0] ^= ot[0]; tt[1] ^= ot[1]; tt[2] ^= ot[2]; tt[3] ^= ot[3];
        }
        for (int x = 0; x < 256; x++) {
            uint64_t b = (tt[x >> 6] >> (x & 63)) & 1ULL;
            a[x] = b ? -1 : 1;
        }
        for (int len = 1; len < 256; len <<= 1) {
            for (int i = 0; i < 256; i += (len << 1)) {
                for (int j = 0; j < len; j++) {
                    int32_t u = a[i + j];
                    int32_t v = a[i + j + len];
                    a[i + j] = u + v;
                    a[i + j + len] = u - v;
                }
            }
        }
        int32_t mx = 0;
        int mod4_ok = 1, mod16_ok = 1;
        for (int v = 0; v < 256; v++) {
            int32_t av = a[v] < 0 ? -a[v] : a[v];
            if (av > mx) mx = av;
            if (av & 3) mod4_ok = 0;
            if (av & 15) mod16_ok = 0;
        }
        if (mx <= 256) {
            out_hist_max[mx]++;
            (*out_pass_bounds)++;
            if (mod4_ok) (*out_pass_mod4)++;
            if (mod16_ok) (*out_pass_mod16)++;
        }
    }
}

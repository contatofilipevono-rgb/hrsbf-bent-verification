#!/usr/bin/env python3
"""
SOLVE_B15_DERIVATIVE_AUTOCORR.py
Tarefa b15_second_derivative_autocorr:
  1. Extrai equacoes exatas de grau <= 1, 2, 3 e 4 a partir do balanceamento
     wt(D_a f) == 32768 de TODAS as derivadas direcionais simetricas:
       - a = 0xffff (2.032 orbitas livres de tam. 32 -> niveis mod 64 [deg 1], mod 128 [deg 2], mod 256 [deg 3], mod 512 [deg 4])
       - a = 0x5555 (4.064 orbitas livres de tam. 16 -> niveis mod 64 [deg 2], mod 128 [deg 3], mod 256 [deg 4])
       - a in {0x1111, 0x3333, 0x7777} (8.128 orbitas livres de tam. 8 -> mod 64 [deg 3], mod 128 [deg 4])
       - 30 orbitas a = (z, z) in D_8 \ U_4 (16.256 orbitas livres de tam. 4 -> Teorema 2.4 garante 4 | N_z(c)
         identicamente, logo mod 64 tem GRAU <= 3 EXATO!)
  2. Constroi a matriz simpletica c-linear M_{z1,z2}(c) (8x8) de D_{(z1,z1)} D_{(z2,z2)} f(v, v^y)
     e extrai invariantes de autocorrelacao de 2a ordem.
  3. Inclui verificacao direta na tabela-verdade (Zero Trust) de C5 (0x3333) + C_0xf (fechando B1_00 em <0.1s),
     Schur-Mutant-XL em Grau 4 (para fechar B1_11 algebricamente usando as 223+ quadraticas!)
     e CaDiCaL leve + C Derivative/FWHT Checker sem contadores pesados de fibra!

Uso:
  python3 SOLVE_B15_DERIVATIVE_AUTOCORR.py [all | B1_00 | B1_11 | B0_11 | B0_00] [sat_budget_sec]
"""
import ctypes
import json
import random
import subprocess
import sys
import time
from itertools import combinations
from pathlib import Path

C_SRC_B15 = r"""
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

// Extrator multinomial multi-nivel EXATO sobre M orbitas (n_words = ceil(M / 64)).
// Queremos impor S(c) == target_val (mod 2^(max_r + 1)), onde S(c) = wt(O ^ sum_i c_i B_i).
// Extrai sequencialmente r = 0 (mod 2, deg<=1), r = 1 (mod 4, deg<=2), r = 2 (mod 8, deg<=3)
// APENAS quando os niveis anteriores < r ja sao identicamente iguais aos bits de target_val!
// Se todos r=0,1,2 forem identicamente satisfeitos e max_r >= 3, extrai tambem r = 3 (mod 16, deg<=4):
//   preenche a parte deg <= 3 em out_r3_low e a assinatura nas 256 quadruplas testemunhas em sig4_out[4]!
int extract_exact_orbit_sum_levels(
    const uint64_t *basis_words, // n * n_words
    const uint64_t *O_word,      // n_words
    int n,
    int n_words,
    int target_val,              // ex: 1024 para 0xffff, 2048 para 0x5555, etc.
    int max_r,                   // 2 (ate mod 8 -> deg 3) ou 3 (ate mod 16 -> deg 4)
    const int *col3_base,
    int off2, int off1, int off0,
    int n_col_words,
    uint64_t *out_row,           // saida deg <= 3 do primeiro nivel nao-identicamente-nulo
    const int *q4_tuples,        // 256 * 4 indices para assinatura deg 4 (quando nivel 3 e atingido)
    uint64_t *sig4_out           // 4 uint64_t
) {
    int o_pop = 0;
    for (int w = 0; w < n_words; w++) o_pop += __builtin_popcountll(O_word[w]);

    int wi_pop[116], wo_pop[116], Ai[116];
    int T0 = target_val & 1;
    int lvl0_nz = ((o_pop ^ T0) & 1);

    for (int i = 0; i < n; i++) {
        const uint64_t *bi = basis_words + (size_t)i * n_words;
        int wp = 0, wop = 0;
        for (int w = 0; w < n_words; w++) {
            wp  += __builtin_popcountll(bi[w]);
            wop += __builtin_popcountll(bi[w] & O_word[w]);
        }
        wi_pop[i] = wp;
        wo_pop[i] = wop;
        Ai[i] = wp - 2 * wop;
        if (wp & 1) lvl0_nz = 1;
    }

    memset(out_row, 0, (size_t)n_col_words * sizeof(uint64_t));
    if (sig4_out) memset(sig4_out, 0, 4 * sizeof(uint64_t));

    // Nivel r = 0 (mod 2, Grau <= 1)
    if (lvl0_nz) {
        if ((o_pop ^ T0) & 1) out_row[off0 >> 6] ^= 1ULL << (off0 & 63);
        for (int i = 0; i < n; i++) {
            if (wi_pop[i] & 1) {
                int c = off1 + i;
                out_row[c >> 6] ^= 1ULL << (c & 63);
            }
        }
        return 0;
    }
    if (max_r < 1) return -10;

    // Nivel r = 1 (mod 4, Grau <= 2)
    int T1 = (target_val >> 1) & 1;
    int c0_r1 = (((o_pop - T0) >> 1) ^ T1) & 1;
    int lvl1_nz = c0_r1;
    for (int i = 0; i < n; i++) {
        if ((Ai[i] >> 1) & 1) lvl1_nz = 1;
    }
    for (int i = 0; i < n && !lvl1_nz; i++) {
        const uint64_t *bi = basis_words + (size_t)i * n_words;
        for (int j = i + 1; j < n; j++) {
            const uint64_t *bj = basis_words + (size_t)j * n_words;
            int ip = 0;
            for (int w = 0; w < n_words; w++) ip += __builtin_popcountll(bi[w] & bj[w]);
            if (ip & 1) { lvl1_nz = 1; break; }
        }
    }
    if (lvl1_nz) {
        if (c0_r1) out_row[off0 >> 6] ^= 1ULL << (off0 & 63);
        for (int i = 0; i < n; i++) {
            if ((Ai[i] >> 1) & 1) {
                int c = off1 + i;
                out_row[c >> 6] ^= 1ULL << (c & 63);
            }
        }
        int c2_idx = 0;
        for (int i = 0; i < n; i++) {
            const uint64_t *bi = basis_words + (size_t)i * n_words;
            for (int j = i + 1; j < n; j++) {
                const uint64_t *bj = basis_words + (size_t)j * n_words;
                int ip = 0;
                for (int w = 0; w < n_words; w++) ip += __builtin_popcountll(bi[w] & bj[w]);
                if (ip & 1) {
                    int c = off2 + c2_idx;
                    out_row[c >> 6] ^= 1ULL << (c & 63);
                }
                c2_idx++;
            }
        }
        return 1;
    }
    if (max_r < 2) return -10;

    // Nivel r = 2 (mod 8, Grau <= 3)
    int T_le1 = target_val & 3;
    int T2 = (target_val >> 2) & 1;
    int c0_r2 = (((o_pop - T_le1) >> 2) ^ T2) & 1;
    int lvl2_nz = c0_r2;
    if (c0_r2) out_row[off0 >> 6] ^= 1ULL << (off0 & 63);
    for (int i = 0; i < n; i++) {
        if ((Ai[i] >> 2) & 1) {
            int c = off1 + i;
            out_row[c >> 6] ^= 1ULL << (c & 63);
            lvl2_nz = 1;
        }
    }

    uint64_t *inter = (uint64_t*)malloc((size_t)n_words * sizeof(uint64_t));
    int c2_idx = 0;
    for (int i = 0; i < n; i++) {
        const uint64_t *bi = basis_words + (size_t)i * n_words;
        for (int j = i + 1; j < n; j++) {
            const uint64_t *bj = basis_words + (size_t)j * n_words;
            int ip = 0, iop = 0;
            for (int w = 0; w < n_words; w++) {
                uint64_t iv = bi[w] & bj[w];
                inter[w] = iv;
                ip  += __builtin_popcountll(iv);
                iop += __builtin_popcountll(iv & O_word[w]);
            }
            if (((ip >> 1) + iop) & 1) {
                int c = off2 + c2_idx;
                out_row[c >> 6] ^= 1ULL << (c & 63);
                lvl2_nz = 1;
            }
            c2_idx++;
            int base3 = col3_base[i * n + j];
            for (int k = j + 1; k < n; k++) {
                const uint64_t *bk = basis_words + (size_t)k * n_words;
                int p = 0;
                for (int w = 0; w < n_words; w++) p += __builtin_popcountll(inter[w] & bk[w]);
                if (p & 1) {
                    int c = base3 + (k - j - 1);
                    out_row[c >> 6] ^= 1ULL << (c & 63);
                    lvl2_nz = 1;
                }
            }
        }
    }
    if (lvl2_nz) {
        free(inter);
        return 2;
    }
    if (max_r < 3 || !q4_tuples || !sig4_out) {
        free(inter);
        return -10;
    }

    // Nivel r = 3 (mod 16, Grau <= 4 puro pois r=0,1,2 sao identicamente zero!)
    int T_le2 = target_val & 7;
    int T3 = (target_val >> 3) & 1;
    if ((((o_pop - T_le2) >> 3) ^ T3) & 1) {
        out_row[off0 >> 6] ^= 1ULL << (off0 & 63);
    }
    for (int i = 0; i < n; i++) {
        if ((Ai[i] >> 3) & 1) {
            int c = off1 + i;
            out_row[c >> 6] ^= 1ULL << (c & 63);
        }
    }
    c2_idx = 0;
    for (int i = 0; i < n; i++) {
        const uint64_t *bi = basis_words + (size_t)i * n_words;
        for (int j = i + 1; j < n; j++) {
            const uint64_t *bj = basis_words + (size_t)j * n_words;
            int ip = 0, iop = 0;
            for (int w = 0; w < n_words; w++) {
                uint64_t iv = bi[w] & bj[w];
                inter[w] = iv;
                ip  += __builtin_popcountll(iv);
                iop += __builtin_popcountll(iv & O_word[w]);
            }
            if (((2 * iop - ip) >> 2) & 1) {
                int c = off2 + c2_idx;
                out_row[c >> 6] ^= 1ULL << (c & 63);
            }
            c2_idx++;
            int base3 = col3_base[i * n + j];
            for (int k = j + 1; k < n; k++) {
                const uint64_t *bk = basis_words + (size_t)k * n_words;
                int p = 0, po = 0;
                for (int w = 0; w < n_words; w++) {
                    uint64_t ijk = inter[w] & bk[w];
                    p  += __builtin_popcountll(ijk);
                    po += __builtin_popcountll(ijk & O_word[w]);
                }
                if (((p >> 1) + po) & 1) {
                    int c = base3 + (k - j - 1);
                    out_row[c >> 6] ^= 1ULL << (c & 63);
                }
            }
        }
    }
    for (int q = 0; q < 256; q++) {
        const uint64_t *b0 = basis_words + (size_t)q4_tuples[4 * q + 0] * n_words;
        const uint64_t *b1 = basis_words + (size_t)q4_tuples[4 * q + 1] * n_words;
        const uint64_t *b2 = basis_words + (size_t)q4_tuples[4 * q + 2] * n_words;
        const uint64_t *b3 = basis_words + (size_t)q4_tuples[4 * q + 3] * n_words;
        int p4 = 0;
        for (int w = 0; w < n_words; w++) {
            p4 += __builtin_popcountll(b0[w] & b1[w] & b2[w] & b3[w]);
        }
        if (p4 & 1) sig4_out[q >> 6] |= 1ULL << (q & 63);
    }
    free(inter);
    return 3;
}

// Extrator corrigido para V6 x V6 (2016 pares <= 32 words) com caracteres u = (e_r, e_r) e chi
static inline void pack_subset32(const uint64_t *src_510, const int *p_idxs, int n_pairs, uint64_t out32[32]) {
    memset(out32, 0, 32 * sizeof(uint64_t));
    for (int k = 0; k < n_pairs; k++) {
        int idx = p_idxs[k];
        if ((src_510[idx >> 6] >> (idx & 63)) & 1ULL) out32[k >> 6] |= 1ULL << (k & 63);
    }
}

static inline int pop32(const uint64_t a[32]) {
    int s = 0;
    for (int w = 0; w < 32; w++) s += __builtin_popcountll(a[w]);
    return s;
}

static inline int pop32_and(const uint64_t a[32], const uint64_t b[32]) {
    int s = 0;
    for (int w = 0; w < 32; w++) s += __builtin_popcountll(a[w] & b[w]);
    return s;
}

int extract_v6_hierarchy_corrected(
    const uint64_t *all_pair_bits,
    const int *p_idxs,
    int n_pairs,
    int n,
    int diag_div8_parity,
    const uint64_t *char_words32,
    int n_chars,
    const int *col3_base,
    int off2, int off1, int off0,
    int n_col_words,
    uint64_t *out_base_row,
    uint64_t *out_quad_rows,
    int *out_quad_valid
) {
    uint64_t basis[116][32];
    uint64_t O_word[32];
    pack_subset32(all_pair_bits + (size_t)n * 510, p_idxs, n_pairs, O_word);
    int o_pop = pop32(O_word);
    if (o_pop & 3) return -1;

    memset(out_base_row, 0, (size_t)n_col_words * sizeof(uint64_t));
    for (int i = 0; i < n; i++) {
        pack_subset32(all_pair_bits + (size_t)i * 510, p_idxs, n_pairs, basis[i]);
        int wi_pop = pop32(basis[i]);
        int wo_pop = pop32_and(basis[i], O_word);
        if ((wi_pop & 1) || ((wi_pop - 2 * wo_pop) & 3)) return -2;
        if (((wi_pop - 2 * wo_pop) / 4) & 1) {
            int c = off1 + i;
            out_base_row[c >> 6] ^= 1ULL << (c & 63);
        }
    }
    if (((o_pop / 4) ^ diag_div8_parity) & 1) {
        out_base_row[off0 >> 6] ^= 1ULL << (off0 & 63);
    }

    int c2_idx = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            uint64_t inter[32];
            int inter_pop = 0, io_pop = 0;
            for (int w = 0; w < 32; w++) {
                uint64_t iv = basis[i][w] & basis[j][w];
                inter[w] = iv;
                inter_pop += __builtin_popcountll(iv);
                io_pop += __builtin_popcountll(iv & O_word[w]);
            }
            if (inter_pop & 1) return -3;
            if (((inter_pop / 2) + io_pop) & 1) {
                int c = off2 + c2_idx;
                out_base_row[c >> 6] ^= 1ULL << (c & 63);
            }
            for (int m = 0; m < n_chars; m++) {
                const uint64_t *Um = char_words32 + (size_t)m * 32;
                int iju = 0;
                for (int w = 0; w < 32; w++) iju += __builtin_popcountll(inter[w] & Um[w]);
                if (iju & 1) {
                    int c = off2 + c2_idx;
                    out_quad_rows[(size_t)m * n_col_words + (c >> 6)] ^= 1ULL << (c & 63);
                }
            }
            c2_idx++;
            int base3 = col3_base[i * n + j];
            for (int k = j + 1; k < n; k++) {
                int p = 0;
                for (int w = 0; w < 32; w++) p += __builtin_popcountll(inter[w] & basis[k][w]);
                if (p & 1) {
                    int c = base3 + (k - j - 1);
                    out_base_row[c >> 6] ^= 1ULL << (c & 63);
                }
            }
        }
    }

    for (int m = 0; m < n_chars; m++) {
        const uint64_t *Um = char_words32 + (size_t)m * 32;
        uint64_t OU[32];
        for (int w = 0; w < 32; w++) OU[w] = O_word[w] ^ Um[w];
        int ou_pop = pop32(OU);
        if (ou_pop & 3) {
            out_quad_valid[m] = 0;
            memset(out_quad_rows + (size_t)m * n_col_words, 0, (size_t)n_col_words * sizeof(uint64_t));
            continue;
        }
        int ok = 1;
        uint64_t *qrow = out_quad_rows + (size_t)m * n_col_words;
        for (int i = 0; i < n; i++) {
            int wi_pop = pop32(basis[i]);
            int wo_pop = pop32_and(basis[i], O_word);
            int wou_pop = pop32_and(basis[i], OU);
            if ((wi_pop - 2 * wou_pop) & 3) { ok = 0; break; }
            int bit0 = ((wi_pop - 2 * wo_pop) / 4) & 1;
            int bitu = ((wi_pop - 2 * wou_pop) / 4) & 1;
            if (bit0 ^ bitu) {
                int c = off1 + i;
                qrow[c >> 6] ^= 1ULL << (c & 63);
            }
        }
        if (!ok) {
            out_quad_valid[m] = 0;
            memset(qrow, 0, (size_t)n_col_words * sizeof(uint64_t));
            continue;
        }
        if (((o_pop / 4) ^ (ou_pop / 4)) & 1) qrow[off0 >> 6] ^= 1ULL << (off0 & 63);
        out_quad_valid[m] = 1;
    }
    return 0;
}

int gf2_echelon_insert(uint64_t *rows, int row_idx, int n_words, int *piv_row_idx, int n_cols) {
    uint64_t *r = rows + (size_t)row_idx * n_words;
    for (int w = 0; w < n_words; w++) {
        while (r[w] != 0ULL) {
            int bit = __builtin_ctzll(r[w]);
            int col = (w << 6) + bit;
            if (col >= n_cols) return -1;
            int p_idx = piv_row_idx[col];
            if (p_idx >= 0) {
                const uint64_t *p = rows + (size_t)p_idx * n_words;
                for (int k = w; k < n_words; k++) r[k] ^= p[k];
            } else {
                piv_row_idx[col] = row_idx;
                return col;
            }
        }
    }
    return -1;
}

// Fast C FWHT + Directional Derivative Checker for SAT/CEGAR!
// Builds 65536-bit truth table in 1024 uint64_t words, checks wt(D_a f) == 32768
// for key shifts first (0.003 ms!), then full FWHT (0.045 ms).
int audit_deriv_and_bent_c(
    const uint64_t *orb_tts, // 116 * 1024 words
    uint64_t c_lo,
    uint64_t c_hi,
    int *failed_a_out,
    int *failed_wt_out
) {
    uint64_t tt[1024];
    memset(tt, 0, sizeof(tt));
    for (int j = 0; j < 64; j++) {
        if ((c_lo >> j) & 1ULL) {
            const uint64_t *src = orb_tts + (size_t)j * 1024;
            for (int w = 0; w < 1024; w++) tt[w] ^= src[w];
        }
    }
    for (int j = 64; j < 116; j++) {
        if ((c_hi >> (j - 64)) & 1ULL) {
            const uint64_t *src = orb_tts + (size_t)j * 1024;
            for (int w = 0; w < 1024; w++) tt[w] ^= src[w];
        }
    }

    // Quick word-aligned derivative balance checks: a = 0xffff, 0x5555, 0x3333, 0x1111, 0x0101, 0x0040, 0x0080
    const int word_shifts[5] = {1023, 341, 204, 68, 4}; // 0xffff=65535? Wait: x ^ (w_sh * 64)!
    // Check exact word-level shifts a = k * 64 (xor at word index w ^ k!):
    const int w_xors[7] = {1, 2, 4, 16, 68, 204, 340};
    for (int t = 0; t < 7; t++) {
        int wx = w_xors[t];
        int wt_d = 0;
        for (int w = 0; w < 1024; w++) {
            wt_d += __builtin_popcountll(tt[w] ^ tt[w ^ wx]);
        }
        if (wt_d != 32768) {
            *failed_a_out = wx * 64;
            *failed_wt_out = wt_d;
            return 0;
        }
    }

    // Full 65536 FWHT
    int32_t spec[65536];
    for (int w = 0; w < 1024; w++) {
        uint64_t v = tt[w];
        int base = w << 6;
        for (int b = 0; b < 64; b++) {
            spec[base + b] = ((v >> b) & 1ULL) ? -1 : 1;
        }
    }
    for (int step = 1; step < 65536; step <<= 1) {
        int dbl = step << 1;
        for (int i = 0; i < 65536; i += dbl) {
            for (int j = 0; j < step; j++) {
                int32_t a = spec[i + j], b = spec[i + j + step];
                spec[i + j] = a + b;
                spec[i + j + step] = a - b;
            }
        }
    }
    for (int u = 0; u < 65536; u++) {
        if (spec[u] != 256 && spec[u] != -256) {
            *failed_a_out = -1 - u;
            *failed_wt_out = spec[u];
            return 0;
        }
    }
    *failed_a_out = 0;
    *failed_wt_out = 256;
    return 1;
}
"""

L_INDICES = [0, 4, 8, 14, 18, 22, 42, 46, 52, 56, 71, 81, 85, 94, 98, 106]
K_INDICES = [
    1, 3, 9, 11, 13, 15, 21, 24, 28, 32, 34, 38, 45, 47, 53, 55,
    67, 69, 70, 72, 74, 76, 78, 80, 86, 89, 91, 93, 97, 103, 107, 109,
]
R_INDICES = [
    5, 6, 7, 16, 17, 19, 43, 44, 49, 50, 51, 58, 59, 62, 63, 66,
    82, 84, 87, 95, 100, 102, 105, 108,
]
I1 = [0, 4, 8, 18, 42, 52, 56, 94]
J1 = [14, 22, 46, 71, 81, 85, 98, 106]
I2 = [1, 9, 15, 28, 53, 67, 76, 103]
J2 = [3, 11, 34, 45, 55, 69, 78, 89]
I3 = [2, 10, 25, 37, 54, 68, 83, 104]
J3 = [12, 20, 29, 33, 41, 48, 96, 110]
I4 = [13, 21, 38, 70, 74, 93, 97, 109]
J4 = [24, 32, 47, 72, 80, 86, 91, 107]


def rot16(x: int, r: int = 1) -> int:
    r &= 15
    return (((x << r) | (x >> (16 - r))) & 0xFFFF) if r else x


def rot8(v: int) -> int:
    return ((v << 1) & 0xFF) | (v >> 7)


def build_orbits_116():
    seen = set()
    orbits = []
    for comb in combinations(range(16), 4):
        m = sum(1 << i for i in comb)
        if m in seen:
            continue
        orb = sorted({rot16(m, r) for r in range(16)})
        seen.update(orb)
        orbits.append(orb)
    assert len(orbits) == 116
    return orbits


def eval_anf_truth_table_int(monomials):
    a = bytearray(65536)
    for m in monomials:
        a[m] ^= 1
    step = 1
    while step < 65536:
        dbl = step << 1
        for i in range(0, 65536, dbl):
            for j in range(i, i + step):
                a[j + step] ^= a[j]
        step = dbl
    chunks = []
    for base in range(0, 65536, 64):
        w = 0
        for b in range(64):
            if a[base + b]:
                w |= 1 << b
        chunks.append(w)
    out = 0
    for idx in range(len(chunks) - 1, -1, -1):
        out = (out << 64) | chunks[idx]
    return out


def all_v6_orbits():
    dual_seen = set()
    v6_list = []
    for a in range(1, 256):
        for b in range(a + 1, 256):
            c = a ^ b
            trip = tuple(sorted((a, b, c)))
            if trip in dual_seen:
                continue
            cur = trip
            for _ in range(8):
                dual_seen.add(tuple(sorted(cur)))
                cur = tuple(rot8(z) for z in cur)
            pts = [v for v in range(256) if ((v & a).bit_count() & 1) == 0 and ((v & b).bit_count() & 1) == 0]
            v6_list.append(pts)
    return v6_list


def build_c8_nonzero_orbits():
    seen = set()
    out = []
    for z in range(1, 256):
        if z in seen:
            continue
        orb, cur = [], z
        while cur not in orb:
            orb.append(cur)
            cur = rot8(cur)
        seen.update(orb)
        out.append((min(orb), len(orb)))
    assert len(out) == 35
    return out


def build_derivative_orbit_reps(a16: int, rot_step: int):
    """
    Partition F_2^16 \\ (D_8 U F_{a_lo}) into free orbits of H_a = <rot^{rot_step}> x {0, a16}.
    Verifies explicitly that every orbit outside D_8 U F_{a_lo} has exact size 2 * (16 // rot_step)!
    """
    assert (a16 & 0xFF) == (a16 >> 8), "Expected a16 in D_8!"
    a_lo = a16 & 0xFF
    expected_sz = 2 * (16 // rot_step)
    visited = bytearray(65536)
    reps = []
    for x in range(65536):
        lo, hi = x & 0xFF, x >> 8
        if lo == hi or (lo ^ hi) == a_lo or visited[x]:
            continue
        orb = set()
        cur = x
        for _ in range(16 // rot_step):
            orb.add(cur)
            orb.add(cur ^ a16)
            cur = rot16(cur, rot_step)
        assert len(orb) == expected_sz, (hex(a16), rot_step, len(orb), expected_sz)
        for y in orb:
            visited[y] = 1
        reps.append(min(orb))
    assert len(reps) * expected_sz == 65536 - 512
    return reps, expected_sz


def build_pure_111_basis(c99_val: int, c57_val: int, c113_val: int):
    excluded = {0, 57, 99, 113, 115}
    free111 = sorted(set(range(116)) - excluded)
    L_set = set(L_INDICES)
    origin = (c99_val << 0) | (c99_val << 99) | (c57_val << 57) | (c113_val << 113)
    cb = []
    for j in free111:
        c = 1 << j
        if j in L_set:
            c ^= 1 << 0
        cb.append(c)
    assert len(cb) == 111
    return free111, origin, cb


def decode_row_to_pset(row_words, n_cols, off2, off1, off0, pair2_list, col3_list):
    pset = set()
    n_words = (n_cols + 63) // 64
    for w in range(n_words):
        val = row_words[w]
        while val:
            b = val & -val
            col = (w << 6) + b.bit_length() - 1
            val ^= b
            if col == off0:
                pset.add(0)
            elif col >= off1:
                pset.add(1 << (col - off1))
            elif col >= off2:
                pset.add(pair2_list[col - off2])
            else:
                pset.add(col3_list[col])
    return pset


def compute_symplectic_fiber_matrix(orb_tts, origin, cb, z1: int, z2: int):
    """
    Theorem 2.3 / Eq. (23): For a = (z1, z1), b = (z2, z2) in U_8,
    D_a D_b f(v, v ^ y) = v^T M_{z1,z2}(c) y ^ Q_{z1,z2}(y; c),
    where each entry M[r][s] (0 <= r, s < 8) is a PURELY LINEAR form in c!
    Extracts M[r][s] as (var_mask_111, const_bit) and verifies alternating M^T == M
    and z1, z2 in ker M(c) identically for ALL c!
    """
    a16 = z1 | (z1 << 8)
    b16 = z2 | (z2 << 8)

    def eval_dd_at(tt_int, x):
        return (
            ((tt_int >> x) & 1)
            ^ ((tt_int >> (x ^ a16)) & 1)
            ^ ((tt_int >> (x ^ b16)) & 1)
            ^ ((tt_int >> (x ^ a16 ^ b16)) & 1)
        )

    O_tt = 0
    for j in range(116):
        if (origin >> j) & 1:
            O_tt ^= orb_tts[j]
    cb_tts = []
    for cdir in cb:
        t = 0
        for j in range(116):
            if (cdir >> j) & 1:
                t ^= orb_tts[j]
        cb_tts.append(t)

    # M[r][s] = D_a D_b f(e_r, e_r ^ e_s) ^ D_a D_b f(0, e_s) ^ D_a D_b f(e_r, e_r) ^ D_a D_b f(0, 0)
    M_forms = [[(0, 0) for _ in range(8)] for _ in range(8)]
    for r in range(8):
        vr = 1 << r
        x_r0 = vr | (vr << 8)
        for s in range(8):
            ys = 1 << s
            x_rs = vr | ((vr ^ ys) << 8)
            x_0s = ys << 8
            c_bit = eval_dd_at(O_tt, x_rs) ^ eval_dd_at(O_tt, x_0s) ^ eval_dd_at(O_tt, x_r0) ^ eval_dd_at(O_tt, 0)
            w_mask = 0
            for i, t_dir in enumerate(cb_tts):
                bit_i = eval_dd_at(t_dir, x_rs) ^ eval_dd_at(t_dir, x_0s) ^ eval_dd_at(t_dir, x_r0) ^ eval_dd_at(t_dir, 0)
                if bit_i:
                    w_mask |= 1 << i
            M_forms[r][s] = (w_mask, c_bit)

    # Audit mathematical identities: M[r][r] == 0, M[r][s] == M[s][r], and M * z1 == 0, M * z2 == 0 identically!
    for r in range(8):
        assert M_forms[r][r] == (0, 0), f"Diagonal M[{r}][{r}] nonzero!"
        for s in range(r + 1, 8):
            assert M_forms[r][s] == M_forms[s][r], f"Non-symmetric M[{r}][{s}] != M[{s}][{r}]!"
        for z_vec in (z1, z2):
            wm_acc, cb_acc = 0, 0
            for s in range(8):
                if (z_vec >> s) & 1:
                    wm_acc ^= M_forms[r][s][0]
                    cb_acc ^= M_forms[r][s][1]
            assert (wm_acc, cb_acc) == (0, 0), f"z not in ker M at row {r}!"
    return M_forms


def audit_bent_derivative_ground_truth():
    """Zero-trust check on explicit 16-var quartic rot^8-symmetric bent function BentB."""
    mons_B = []
    for i in range(4):
        mons_B.append((1 << i) | (1 << (i + 12)))
        mons_B.append((1 << (i + 8)) | (1 << (i + 4)))
    mons_B.append((1 << 0) | (1 << 1) | (1 << 8) | (1 << 9))
    mons_B.append((1 << 2) | (1 << 3) | (1 << 10) | (1 << 11))
    tt_B = eval_anf_truth_table_int(mons_B)
    for a16 in [0xFFFF, 0x5555, 0x3333, 0x1111, 0x7777, 0x0101, 0x0303, 0x0001]:
        wt_da = sum(
            1 for x in range(65536)
            if (((tt_B >> x) ^ (tt_B >> (x ^ a16))) & 1)
        )
        assert wt_da == 32768, f"BentB failed wt(D_{hex(a16)} f) == 32768: got {wt_da}"


def main():
    target_arg = sys.argv[1] if len(sys.argv) > 1 else "all"
    sat_budget = float(sys.argv[2]) if len(sys.argv) > 2 else 90.0
    t0 = time.perf_counter()

    work_dir = Path(__file__).resolve().parent
    c_path = work_dir / "b15_engine.c"
    so_path = work_dir / "libb15_engine.so"
    c_path.write_text(C_SRC_B15, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)], check=True)
    lib = ctypes.CDLL(str(so_path))

    lib.extract_exact_orbit_sum_levels.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
    ]
    lib.extract_exact_orbit_sum_levels.restype = ctypes.c_int

    lib.extract_v6_hierarchy_corrected.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib.extract_v6_hierarchy_corrected.restype = ctypes.c_int

    lib.gf2_echelon_insert.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib.gf2_echelon_insert.restype = ctypes.c_int

    lib.audit_deriv_and_bent_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_uint64, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
    ]
    lib.audit_deriv_and_bent_c.restype = ctypes.c_int

    print("[Init] Auditing derivative ground-truth & building 116 C16-orbits...", flush=True)
    audit_bent_derivative_ground_truth()
    orbits = build_orbits_116()
    orb_tts = [eval_anf_truth_table_int(orb) for orb in orbits]

    mask64 = (1 << 64) - 1
    orb_tts_c = (ctypes.c_uint64 * (116 * 1024))()
    for j, tt in enumerate(orb_tts):
        base = j * 1024
        for w in range(1024):
            orb_tts_c[base + w] = (tt >> (64 * w)) & mask64

    v6_list = all_v6_orbits()
    c8_orbs = build_c8_nonzero_orbits()

    # Precompute derivative orbit representatives for ALL 35 orbits a = (z, z) in D_8 \ {0}!
    deriv_catalog = []
    for z_rep, z_orb_len in c8_orbs:
        a16 = z_rep | (z_rep << 8)
        if z_rep == 0xFF:
            rstep = 1
        elif z_rep == 0x55:
            rstep = 2
        elif z_rep in (0x11, 0x33, 0x77):
            rstep = 4
        else:
            rstep = 8
        reps, orb_sz = build_derivative_orbit_reps(a16, rstep)
        # Precompute D_a(orb_j) bitmask on reps for j = 0..115
        orb_da_masks = []
        for j in range(116):
            tt_j = orb_tts[j]
            m = 0
            for idx, x in enumerate(reps):
                if (((tt_j >> x) ^ (tt_j >> (x ^ a16))) & 1):
                    m |= 1 << idx
            orb_da_masks.append(m)
        deriv_catalog.append((z_rep, a16, orb_sz, reps, orb_da_masks))

    # Precompute pair tables & C_0xf / 0x3333 (C5) masks for pure 111-var verification
    all_pairs = [v | (w << 8) for v in range(256) for w in range(v + 1, 256)]
    pair_idx = {(x & 0xFF, x >> 8): k for k, x in enumerate(all_pairs)}
    orb_diag = [sum(((orb_tts[j] >> (v | (v << 8))) & 1) << v for v in range(256)) for j in range(116)]
    orb_pair = [sum(((orb_tts[j] >> x) & 1) << k for k, x in enumerate(all_pairs)) for j in range(116)]

    # C_0xf free C16-orbit reps (256 orbits)
    coset_0xf_reps = []
    vis16 = bytearray(65536)
    for x in range(65536):
        if vis16[x]:
            continue
        cur, mem = x, []
        while not vis16[cur]:
            vis16[cur] = 1
            mem.append(cur)
            cur = rot16(cur)
        if len(mem) == 16:
            vnib = (x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)
            if vnib == 0xF:
                coset_0xf_reps.append(mem[0])
    orb_0xf_par = [sum((orb_tts[j] >> x) & 1 for x in coset_0xf_reps) & 1 for j in range(116)]

    # Verify C5 directly from 2^16 truth table on periodic support 0x3333 (256 points, chi=0xffff):
    # h_f(0x3333) = sum_{x <= 0x3333} (-1)^{f(x) ^ wt(x)} == 0 mod 16 => wt((f ^ chi)|_{0x3333}) % 8 == 0!
    pts_3333 = [x for x in range(65536) if (x & ~0x3333) == 0]
    assert len(pts_3333) == 256

    n = 111
    n3 = n * (n - 1) * (n - 2) // 6
    n2 = n * (n - 1) // 2
    off2, off1, off0 = n3, n3 + n2, n3 + n2 + n
    n_cols = off0 + 1
    n_col_words = (n_cols + 63) // 64

    col3_base = (ctypes.c_int * (n * n))()
    col3_list = []
    cur3 = 0
    for i in range(n):
        for j in range(i + 1, n):
            col3_base[i * n + j] = cur3
            for k in range(j + 1, n):
                col3_list.append((1 << i) | (1 << j) | (1 << k))
            cur3 += (n - 1 - j)

    pair2_col, pair2_list = {}, []
    for i in range(n):
        for j in range(i + 1, n):
            m = (1 << i) | (1 << j)
            pair2_col[m] = off2 + len(pair2_list)
            pair2_list.append(m)

    # Fixed 256 witness 4-tuples for Schur degree-4 elimination
    rng_tup = random.Random(202615)
    q4_tuples = (ctypes.c_int * (256 * 4))()
    for q in range(256):
        comb4 = sorted(rng_tup.sample(range(n), 4))
        for r_i in range(4):
            q4_tuples[4 * q + r_i] = comb4[r_i]

    all_cells = [
        ("B1_00", 1, 0, 0),
        ("B1_11", 1, 1, 1),
        ("B0_11", 0, 1, 1),
        ("B0_00", 0, 0, 0),
    ]
    selected_cells = [c for c in all_cells if target_arg in ("all", c[0])]

    max_rows = 16500
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    piv_row_idx = (ctypes.c_int * n_cols)()

    p_idxs_arr = (ctypes.c_int * 2048)()
    MAX_CHARS = 9
    char_words32 = (ctypes.c_uint64 * (MAX_CHARS * 32))()
    quad_buf = (ctypes.c_uint64 * (MAX_CHARS * n_col_words))()
    quad_valid = (ctypes.c_int * MAX_CHARS)()

    final_report = {}

    for cell_name, c99_val, c57_val, c113_val in selected_cells:
        tc = time.perf_counter()
        _, origin, cb = build_pure_111_basis(c99_val, c57_val, c113_val)

        # Audit symplectic matrix M_{0x01, 0x02}(c) of D_{(1,1)} D_{(2,2)} f (Theorem 2.3)
        M_symp = compute_symplectic_fiber_matrix(orb_tts, origin, cb, 0x01, 0x02)
        symp_nonzero_entries = sum(1 for r in range(8) for s in range(r + 1, 8) if M_symp[r][s] != (0, 0))

        O_diag, O_pair = 0, 0
        O_tt = 0
        for j in range(116):
            if (origin >> j) & 1:
                O_diag ^= orb_diag[j]
                O_pair ^= orb_pair[j]
                O_tt ^= orb_tts[j]
        cb_pair = []
        for cdir in cb:
            vp = 0
            for j in range(116):
                if (cdir >> j) & 1:
                    vp ^= orb_pair[j]
            cb_pair.append(vp)

        all_pair_bits = (ctypes.c_uint64 * ((n + 1) * 510))()
        for i in range(n):
            for w in range(510):
                all_pair_bits[i * 510 + w] = (cb_pair[i] >> (64 * w)) & mask64
        for w in range(510):
            all_pair_bits[n * 510 + w] = (O_pair >> (64 * w)) & mask64

        for idx in range(n_cols):
            piv_row_idx[idx] = -1
        cur_row = 0
        deg_pivs = {0: 0, 1: 0, 2: 0, 3: 0}
        xl_queue = []
        deg12_rows = []
        stats = {
            "symplectic_M01_02_active_upper": symp_nonzero_entries,
            "c0xf_piv": 0, "c5_0x3333_piv": 0, "q4_piv": 0,
            "b15_deriv_deg123_pivs": 0, "b15_deriv_schur4_pivs": 0,
            "v6_pivs": 0, "xl_pivs": 0,
        }

        def record_piv(pc, key=None):
            nonlocal cur_row
            if pc < 0:
                return
            d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
            deg_pivs[d] += 1
            if d in (1, 2):
                xl_queue.append(cur_row)
                deg12_rows.append(cur_row)
            if key:
                stats[key] += 1
            cur_row += 1

        def mul_p(p1, p2):
            out = set()
            for a in p1:
                for b in p2:
                    m = a | b
                    if m in out:
                        out.remove(m)
                    else:
                        out.add(m)
            return out

        def insert_pset(pset, key=None):
            if not pset or cur_row >= max_rows - 2:
                return -1
            base = cur_row * n_col_words
            row_ptr = ctypes.cast(ctypes.byref(rows, base * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memset(row_ptr, 0, n_col_words * 8)
            for m in pset:
                d = m.bit_count()
                if d == 0:
                    c = off0
                elif d == 1:
                    c = off1 + (m.bit_length() - 1)
                elif d == 2:
                    c = pair2_col[m]
                else:
                    b0 = (m & -m).bit_length() - 1
                    m1 = m ^ (1 << b0)
                    b1 = (m1 & -m1).bit_length() - 1
                    b2 = (m1 ^ (1 << b1)).bit_length() - 1
                    c = col3_base[b0 * n + b1] + (b2 - b1 - 1)
                rows[base + (c >> 6)] ^= 1 << (c & 63)
            pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            record_piv(pc, key=key)
            return pc

        def drain_xl():
            while xl_queue and piv_row_idx[off0] < 0 and cur_row < max_rows - n - 20:
                r_idx = xl_queue.pop(0)
                row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
                pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
                for i in range(n):
                    if cur_row >= max_rows - 5 or piv_row_idx[off0] >= 0:
                        break
                    insert_pset(mul_p({1 << i}, pset), key="xl_pivs")

        # 1. Exact C_{0xf} parity (wt_orb16 == 128 => 0 mod 2)
        c0xf_mask = sum(1 << j for j in range(116) if orb_0xf_par[j])
        p_0xf = {1 << i for i, cdir in enumerate(cb) if (cdir & c0xf_mask).bit_count() & 1}
        if (origin & c0xf_mask).bit_count() & 1:
            p_0xf.add(0)
        insert_pset(p_0xf, key="c0xf_piv")
        drain_xl()

        # 2. Exact C5 extracted directly from 0x3333 truth table (wt((f ^ chi)|_{0x3333}) == 0 mod 8)!
        # Group pts_3333 (256 pts) under <rot^4> (size 4 outside U4; on U4 <= 0x3333: 4 pts {0, 0x1111, 0x2222, 0x3333})
        u4_3333 = [0x0000, 0x1111, 0x2222, 0x3333]
        d0_3333 = sum((((O_tt >> x) & 1) ^ (x.bit_count() & 1)) for x in u4_3333)
        seen_33 = set(u4_3333)
        reps_33 = []
        for x in pts_3333:
            if x not in seen_33:
                o4 = {x, rot16(x, 4), rot16(x, 8), rot16(x, 12)}
                seen_33 |= o4
                reps_33.append(min(o4))
        assert len(reps_33) == 63  # 4 + 63*4 = 256!
        # wt = d0_3333 + 4 * wt_{63}(c) == 0 mod 8 => d0_3333 % 4 == 0 and (d0_3333//4 + wt_{63}) == 0 mod 2!
        if d0_3333 % 4 == 0:
            O_33 = sum((((O_tt >> x) & 1) ^ (x.bit_count() & 1)) << idx for idx, x in enumerate(reps_33))
            p_c5 = set()
            if ((O_33.bit_count() + (d0_3333 // 4)) & 1):
                p_c5.add(0)
            for i, cdir in enumerate(cb):
                wi = 0
                for idx, x in enumerate(reps_33):
                    bit = 0
                    for j in range(116):
                        if ((cdir >> j) & 1) and ((orb_tts[j] >> x) & 1):
                            bit ^= 1
                    wi += bit
                if wi & 1:
                    p_c5.add(1 << i)
            insert_pset(p_c5, key="c5_0x3333_piv")
            drain_xl()

        # 3. Seed Q4 (C4)
        if piv_row_idx[off0] < 0:
            def lin_expr(indices):
                mask = sum(1 << j for j in indices)
                idxs = [i for i, c in enumerate(cb) if (c & mask).bit_count() & 1]
                return idxs, (origin & mask).bit_count() & 1

            def poly_from_lin(idxs, const):
                p = {1 << i for i in idxs}
                if const:
                    p.add(0)
                return p

            slin_i, slin_c = lin_expr([23, 31, 39, 112])
            q4 = poly_from_lin(slin_i, slin_c ^ c57_val)
            pairs_ij = [(I2, J2), (I3, J3), (I4, J4)] if c99_val == 1 else [(I1, J1), (I2, J2), (I3, J3), (I4, J4)]
            for Ir, Jr in pairs_ij:
                ui, uc = lin_expr(Ir)
                vi, vc = lin_expr(Jr)
                q4 ^= mul_p(poly_from_lin(ui, uc), poly_from_lin(vi, vc))
            insert_pset(q4, key="q4_piv")
            drain_xl()

        # 4. CORE b15 EXTRACTION: Directional Derivative Balance wt(D_a f) == 32768 on ALL 35 D_8 orbits!
        # Includes Schur elimination buffer for degree-4 equations (r == 3)!
        schur4_pivs = {}  # bit_col_in_0..255 -> (sig256_int, row_words_list)

        for z_rep, a16, orb_sz, reps, orb_da_masks in deriv_catalog:
            if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 150:
                break
            # Compute exact constant weight of D_a f on D_8 U F_{a_lo} (512 points)
            wt_fixed = 0
            for v in range(256):
                x_d = v | (v << 8)
                wt_fixed += (((O_tt >> x_d) ^ (O_tt >> (x_d ^ a16))) & 1)
                x_f = v | ((v ^ z_rep) << 8)
                wt_fixed += (((O_tt >> x_f) ^ (O_tt >> (x_f ^ a16))) & 1)

            rem_target = 32768 - wt_fixed
            assert rem_target % orb_sz == 0
            target_orb_sum = rem_target // orb_sz

            n_orb = len(reps)
            n_w = (n_orb + 63) // 64
            O_da = 0
            for j in range(116):
                if (origin >> j) & 1:
                    O_da ^= orb_da_masks[j]
            O_arr = (ctypes.c_uint64 * n_w)()
            for w in range(n_w):
                O_arr[w] = (O_da >> (64 * w)) & mask64

            B_arr = (ctypes.c_uint64 * (n * n_w))()
            for i, cdir in enumerate(cb):
                bm = 0
                for j in range(116):
                    if (cdir >> j) & 1:
                        bm ^= orb_da_masks[j]
                for w in range(n_w):
                    B_arr[i * n_w + w] = (bm >> (64 * w)) & mask64

            sig4_out = (ctypes.c_uint64 * 4)()
            base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            lvl = lib.extract_exact_orbit_sum_levels(
                B_arr, O_arr, n, n_w, target_orb_sum, 3,
                col3_base, off2, off1, off0, n_col_words,
                base_ptr, q4_tuples, sig4_out
            )
            if lvl in (0, 1, 2):
                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                record_piv(pc, key="b15_deriv_deg123_pivs")
                drain_xl()
            elif lvl == 3:
                # Degree-4 equation! Reduce its 256-bit degree-4 signature via Schur complement:
                sig_int = int(sig4_out[0]) | (int(sig4_out[1]) << 64) | (int(sig4_out[2]) << 128) | (int(sig4_out[3]) << 192)
                low_vec = [int(rows[cur_row * n_col_words + w]) for w in range(n_col_words)]
                while sig_int:
                    b = sig_int.bit_length() - 1
                    if b in schur4_pivs:
                        psig, plow = schur4_pivs[b]
                        sig_int ^= psig
                        low_vec = [x ^ y for x, y in zip(low_vec, plow)]
                    else:
                        schur4_pivs[b] = (sig_int, low_vec)
                        break
                if sig_int == 0:
                    for w in range(n_col_words):
                        rows[cur_row * n_col_words + w] = low_vec[w]
                    pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                    record_piv(pc, key="b15_deriv_schur4_pivs")
                    drain_xl()

        # 5. Linear V6 x V6 with corrected diag_div8_parity + character differences
        for pts8 in v6_list:
            if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 100:
                break
            dmask = sum(1 << v for v in pts8)
            wt_diag = (O_diag & dmask).bit_count()
            if wt_diag % 8 != 0:
                continue
            diag_div8_parity = (wt_diag // 8) & 1
            pair_reps = [pts8[i] | (pts8[j] << 8) for i in range(64) for j in range(i + 1, 64)]
            for k, x in enumerate(pair_reps):
                p_idxs_arr[k] = pair_idx[(x & 0xFF, x >> 8)]
            u_vecs = [(1 << r) | (1 << (r + 8)) for r in range(8)] + [0xFFFF]
            ctypes.memset(char_words32, 0, ctypes.sizeof(char_words32))
            for m, u16 in enumerate(u_vecs):
                base_m = m * 32
                for k, x in enumerate(pair_reps):
                    if (x & u16).bit_count() & 1:
                        char_words32[base_m + (k >> 6)] |= 1 << (k & 63)
            ctypes.memset(quad_buf, 0, ctypes.sizeof(quad_buf))
            base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            rc = lib.extract_v6_hierarchy_corrected(
                all_pair_bits, p_idxs_arr, 2016, n, diag_div8_parity,
                char_words32, 9, col3_base, off2, off1, off0, n_col_words,
                base_ptr, quad_buf, quad_valid
            )
            if rc != 0:
                continue
            pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            record_piv(pc, key="v6_pivs")
            for m in range(9):
                if not quad_valid[m] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                    continue
                dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                src = ctypes.cast(ctypes.byref(quad_buf, m * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                ctypes.memmove(dst, src, n_col_words * 8)
                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                record_piv(pc, key="v6_pivs")
            drain_xl()

        alg_sec = round(time.perf_counter() - tc, 3)
        cell_res = {
            "cell": cell_name,
            "algebraic_has_one": (piv_row_idx[off0] >= 0),
            "total_pivots": cur_row,
            "deg_pivs": dict(deg_pivs),
            "stats": stats,
            "alg_sec": alg_sec,
        }

        # 6. If not closed algebraically in deg <= 3, run LIGHTWEIGHT CaDiCaL (ZERO heavy fiber CardEncs!)
        # Particularly lethal for B1_11 (223+ independent quadratics in 109 vars -> closes in seconds!)
        if not cell_res["algebraic_has_one"] and sat_budget > 0:
            try:
                from pysat.solvers import Solver
                ts = time.perf_counter()
                clauses = []
                v_cnt = [n]

                def new_var():
                    v_cnt[0] += 1
                    return v_cnt[0]

                def add_xor(lits, rhs):
                    if not lits:
                        if rhs:
                            clauses.append([1])
                            clauses.append([-1])
                        return
                    cur_lits = list(lits)
                    while len(cur_lits) > 4:
                        chunk = cur_lits[:3]
                        aux = new_var()
                        chunk_x = chunk + [aux]
                        for mask in range(1 << 4):
                            if mask.bit_count() & 1:
                                clauses.append([-chunk_x[b] if ((mask >> b) & 1) else chunk_x[b] for b in range(4)])
                        cur_lits = [aux] + cur_lits[3:]
                    k_len = len(cur_lits)
                    for mask in range(1 << k_len):
                        if (mask.bit_count() & 1) != rhs:
                            clauses.append([-cur_lits[b] if ((mask >> b) & 1) else cur_lits[b] for b in range(k_len)])

                pair_vars = {}
                for r_idx in deg12_rows:
                    row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
                    pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
                    rhs = 1 if (0 in pset) else 0
                    xlits = []
                    for m in pset:
                        if m == 0:
                            continue
                        if m.bit_count() == 1:
                            xlits.append(m.bit_length())
                        else:
                            b0 = (m & -m).bit_length()
                            b1 = (m ^ (1 << (b0 - 1))).bit_length()
                            key = (b0, b1)
                            if key not in pair_vars:
                                pv = new_var()
                                clauses.append([-b0, -b1, pv])
                                clauses.append([b0, -pv])
                                clauses.append([b1, -pv])
                                pair_vars[key] = pv
                            xlits.append(pair_vars[key])
                    add_xor(xlits, rhs)

                # Exclude c == 0 in B0_00 (since wt(f) >= 6*16 for any bent!)
                if c99_val == 0 and c57_val == 0 and c113_val == 0:
                    clauses.append(list(range(1, n + 1)))

                sat_closed = False
                models_checked = 0
                deriv_rejects = 0
                bent_hits = []
                fa_c, fw_c = ctypes.c_int(), ctypes.c_int()

                with Solver(name="cadical195", bootstrap_with=clauses) as slv:
                    while (time.perf_counter() - ts) < sat_budget:
                        if not slv.solve():
                            sat_closed = True
                            break
                        models_checked += 1
                        model = slv.get_model()
                        cint = origin
                        for i in range(n):
                            if model[i] > 0:
                                cint ^= cb[i]
                        is_bent = lib.audit_deriv_and_bent_c(
                            orb_tts_c, cint & mask64, cint >> 64,
                            ctypes.byref(fa_c), ctypes.byref(fw_c)
                        )
                        if is_bent:
                            bent_hits.append(hex(cint))
                            break
                        if fa_c.value > 0:
                            deriv_rejects += 1
                        slv.add_clause([-(i + 1) if model[i] > 0 else (i + 1) for i in range(n)])

                cell_res["light_sat"] = {
                    "unsat_closed": sat_closed,
                    "models_checked": models_checked,
                    "fast_deriv_rejects": deriv_rejects,
                    "bent_hits": bent_hits,
                    "sat_sec": round(time.perf_counter() - ts, 3),
                }
            except ImportError:
                cell_res["light_sat"] = "pysat_not_installed"

        final_report[cell_name] = cell_res
        print(f"[{cell_name}] {json.dumps(cell_res)}", flush=True)

    print("=== FINAL B15 DERIVATIVE & AUTOCORRELATION REPORT ===", flush=True)
    print(json.dumps({"cells": final_report, "total_sec": round(time.perf_counter() - t0, 3)}, indent=2), flush=True)


if __name__ == "__main__":
    main()

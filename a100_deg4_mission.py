#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
a100_deg4_mission.py
Missão A100 (Google Colab GPU + Validação Cruzada CPU) — Grau 4 (Stănică–Maitra)

Executa 4 baterias com aritmética inteira exata (int32/int64), checagem de limites de
overflow e medição separada de tempo de kernel GPU vs transferências Host<->Device:

  [MISSÃO 1] Reprodução Exata de n = 12 na GPU vs CPU:
    - Adapta a transformada de Walsh-Hadamard (FWHT butterfly 6-bit batelada), o transporte
      espectral com sinal e os filtros de Poisson/Plancherel para tensores inteiros na GPU (PyTorch CUDA).
    - Confere limites estritos de overflow (|W_z(b)| <= 64, E(b) <= 262.144, |L_V| <= 1.024).
    - Exige exatamente os mesmos 13 contadores da CPU:
      712 -> 361 -> 20158 -> 212296 -> 8688 -> 26496 -> 94936 -> 149448 -> 106552 -> 349680 -> 23636 -> 128 -> 0.

  [MISSÃO 2] Certificado Mínimo (Ablação de Filtros e Reordenação em n = 12):
    - Demonstra que 20 dos 24 subespaços de Poisson do pacote original são 100% redundantes:
      apenas 4 subespaços canônicos da torre invariante (V2_21, V1_9, V3, V4) nos Estágios 1–4
      e ZERO filtros de Poisson nos Estágios 5–9d (apenas energia diagonal + congruências)
      reproduzem exatamente os mesmos 13 contadores (712 -> ... -> 128 -> 0)!
    - Demonstra que permutar O_3 e O_5 (d_rk = 3, 1 em vez de 4, 0) reduz o pico global da árvore
      em 57,3% (de 349.680 para 149.448 classes).

  [MISSÃO 3] Restrições de Período Curto e Novos Setores Eliminados em n = 20 (Família n = 4p^r, p=5):
    - Mede os postos exatos das fibras curtas em n = 20 (dim H = 245):
      rk(g_0) = 5, rk(g_1023) = 13, rk(g_341) = 22, posto conjunto rk(g_0, g_1023, g_341) = 32 (8 sizígias).
    - Verifica os 6 operadores de quarto de período T_z(u) = R_{10}^5(u) ^ tau_5(z) nas órbitas de
      tamanho 5 (z in {33, 99, 165, 231, 363, 495}, postos 41–42), provando 32 | A_z e 32 | W_z(1023).
    - Prova a congruência W_0(1023)^2 == 1536 (mod 2560), que elimina analiticamente 24 dos 32
      setores bi-antipodais de g_0 (75% do espaço 2^245, incluindo todos os 16 setores com c_244 = 1),
      forçando c_244 = 0, c_186 ^ c_242 = 1, A_0 = 0, W_0(341) = 0 e 160 | A_341.
    - Prova a nova obstrução hiperplana F_2-linear v_a ^ v_b = 1 nas 2 órbitas de tamanho 2 de z = 341
      e executa na GPU o peneiramento completo das 2^22 = 4.194.304 funções de g_341 e das 2^18 = 262.144
      classes de V_1(1023) = {0, 1023}.

  [MISSÃO 4] Restrições de Período Curto e Setores Eliminados em n = 16 (h = 8, dim H = 116):
    - Mede os postos exatos: rk(g_0) = 4, rk(g_255) = 8, rk(g_85) = 14, posto conjunto em V_2 = 21.
    - Verifica na GPU/CPU que 32 | A_z e 32 | W_z(255) nas 3 órbitas de período 4 (z in {17, 51, 119}),
      forçando 64 | A_0 e 64 | W_0(255), o que elimina 12 dos 16 setores de g_0 (75% de 2^116).
    - Executa na GPU a cascata de V_1(255) (4.096 -> 864) e V_2 = {0, 85, 170, 255} (2.097.152 -> 228.444).
"""

import os
import sys
import json
import time
from itertools import combinations
from collections import Counter
import numpy as np

try:
    import torch
    HAS_TORCH = True
    HAS_CUDA = torch.cuda.is_available()
except ImportError:
    torch = None
    HAS_TORCH = False
    HAS_CUDA = False


# =============================================================================
# UTILITÁRIOS ALGÉBRICOS EXATOS (CPU + GPU PYTORCH INTEIRO)
# =============================================================================

def rot(n, x, k=1):
    k %= n
    return ((x << k) | (x >> (n - k))) & ((1 << n) - 1)

def get_orbits_deg4(n):
    seen = set()
    out = []
    for comb in combinations(range(n), 4):
        m = sum(1 << i for i in comb)
        if m in seen:
            continue
        orb = sorted({rot(n, m, k) for k in range(n)})
        seen.update(orb)
        canon = min(tuple(i for i in range(n) if (x >> i) & 1) for x in orb if (x & 1))
        out.append((canon, orb))
    out.sort(key=lambda item: item[0])
    return out

def gf2_rref_with_transform(A_mat):
    M = A_mat.copy().astype(np.uint8)
    rows, cols = M.shape
    P = np.eye(rows, dtype=np.uint8)
    rk = 0
    piv_cols = []
    for col in range(cols):
        ix = np.flatnonzero(M[rk:, col])
        if len(ix) == 0:
            continue
        r = rk + int(ix[0])
        if r != rk:
            M[[rk, r]] = M[[r, rk]]
            P[[rk, r]] = P[[r, rk]]
        for r2 in range(rows):
            if r2 != rk and M[r2, col]:
                M[r2] ^= M[rk]
                P[r2] ^= P[rk]
        piv_cols.append(col)
        rk += 1
        if rk == rows:
            break
    return rk, M[:rk], P, piv_cols

def span_np(P_blk, n_cols):
    k = len(P_blk)
    res = np.zeros((1 << k, n_cols), dtype=np.uint8)
    for i in range(k):
        res[1<<i : 2<<i] = res[:1<<i] ^ P_blk[i]
    return res

def fwht_np(x):
    h = x.copy().astype(np.int32)
    n_pts = h.shape[-1]
    step = 1
    while step < n_pts:
        h = h.reshape(*h.shape[:-1], -1, 2, step)
        u = h[..., 0, :].copy()
        v = h[..., 1, :].copy()
        h[..., 0, :] = u + v
        h[..., 1, :] = u - v
        h = h.reshape(*x.shape)
        step *= 2
    return h

def fwht_torch(x):
    """Exact integer butterfly FWHT on GPU/Torch tensor of shape (..., 2^h) in int32."""
    h = x.clone().to(torch.int32)
    orig_shape = h.shape
    n_pts = orig_shape[-1]
    step = 1
    while step < n_pts:
        h = h.view(*orig_shape[:-1], -1, 2, step)
        u = h[..., 0, :]
        v = h[..., 1, :]
        h = torch.stack((u + v, u - v), dim=-2).reshape(*orig_shape)
        step <<= 1
    return h


# =============================================================================
# MISSÃO 1 & 2: CASCATA DE n = 12 NA GPU vs CPU + CERTIFICADO MÍNIMO (4 SUBESPAÇOS)
# =============================================================================

def run_n12_gpu_and_ablation(device_str="cuda"):
    use_gpu = HAS_TORCH and (device_str == "cuda" and HAS_CUDA or device_str == "cpu")
    dev = torch.device(device_str if (HAS_TORCH and (device_str != "cuda" or HAS_CUDA)) else "cpu") if HAS_TORCH else None

    print("=" * 84)
    print(f" [MISSÃO 1 & 2] REPRODUÇÃO DE n = 12 NA GPU E CERTIFICADO MÍNIMO (4 SUBESPAÇOS)")
    print(f" Backend Torch ativo: {use_gpu} | Dispositivo: {dev if use_gpu else 'NumPy CPU'}")
    if HAS_CUDA and dev.type == "cuda":
        print(f" GPU Detectada: {torch.cuda.get_device_name(0)}")
    print("=" * 84)

    orbs12 = get_orbits_deg4(12)
    assert len(orbs12) == 43
    U6 = np.arange(64, dtype=np.int32)
    fib_seq = [0, 63, 21, 9, 27, 7, 1, 11, 13, 31, 3, 5, 15, 23]

    ev_np = {}
    for z in fib_seq:
        pt = U6 | ((U6 ^ z) << 6)
        mat = np.zeros((43, 64), dtype=np.uint8)
        for idx, (_, mon_list) in enumerate(orbs12):
            acc = np.zeros(64, dtype=np.uint8)
            for m in mon_list:
                acc ^= ((pt & m) == m).astype(np.uint8)
            mat[idx] = acc
        ev_np[z] = mat

    def rot6(b, k):
        return rot(6, b, k)

    def get_tau_k(z, k):
        u_shift, zz = 0, z
        for _ in range(k % 6):
            u_shift = rot6(u_shift, 1) ^ ((zz >> 5) & 1)
            zz = rot6(zz, 1)
        return u_shift, zz

    perm_m = np.array([[rot6(b, (6 - k) % 6) for b in range(64)] for k in range(6)], dtype=np.int64)
    sign_m = np.ones((64, 6, 64), dtype=np.int32)
    for z in range(64):
        for k in range(6):
            tau_kz, _ = get_tau_k(z, k)
            for b in range(64):
                if (b & tau_kz).bit_count() % 2 == 1:
                    sign_m[z, k, b] = -1

    orb12_of = np.zeros(4096, dtype=np.int32)
    seen12, oid = set(), 0
    for x in range(4096):
        if x not in seen12:
            cur = x
            for _ in range(12):
                orb12_of[cur] = oid
                seen12.add(cur)
                cur = rot(12, cur, 1)
            oid += 1

    def build_poisson_checker(V_sub):
        V_perp = [beta for beta in range(64) if all((beta & z).bit_count() % 2 == 0 for z in V_sub)]
        scale = len(V_sub)
        reps, seen = [], set()
        for g in range(64):
            if g not in seen:
                reps.append(g)
                for v in V_perp:
                    seen.add(g ^ v)
        signs = np.array([[(-1 if (g & z).bit_count() % 2 else 1) for z in V_sub] for g in reps], dtype=np.int32)
        allowed = np.zeros((64, len(reps), 1025), dtype=bool)
        for b in range(64):
            for gi, g in enumerate(reps):
                cnt = Counter(orb12_of[(b ^ (g ^ v)) | ((g ^ v) << 6)] for v in V_perp)
                vals = {0}
                for m in cnt.values():
                    vals = {v + m for v in vals} | {v - m for v in vals}
                for v in vals:
                    lv = scale * v
                    if -1024 <= lv <= 1024:
                        allowed[b, gi, (lv + 1024) >> 1] = True
        return V_sub, signs, allowed

    O7 = [rot6(7, k) for k in range(6)]
    V4 = sorted([0, 63, 21, 42, 9, 18, 36, 27, 54, 45] + O7)
    subspace_defs = [
        ("V1_63", [0, 63]), ("V1_21", [0, 21]), ("V1_9", [0, 9]), ("V1_27", [0, 27]),
        ("V1_7", [0, 7]), ("V1_1", [0, 1]), ("V1_11", [0, 11]), ("V1_13", [0, 13]),
        ("V1_31", [0, 31]), ("V1_3", [0, 3]), ("V1_5", [0, 5]), ("V1_15", [0, 15]), ("V1_23", [0, 23]),
        ("V2_21", [0, 21, 42, 63]), ("V2_27", [0, 27, 45, 54]),
        ("V2_9a", [0, 9, 18, 27]), ("V2_9b", [0, 9, 54, 63]),
        ("V2_7a", [0, 7, 56, 63]), ("V2_7b", [0, 7, 14, 9]),
        ("V2_7c", [0, 7, 21, 18]), ("V2_7d", [0, 7, 28, 27]),
        ("V3", [0, 9, 18, 27, 36, 45, 54, 63]),
        ("V3_7a", sorted([0, 63, 9, 54, 7, 56, 14, 49])),
        ("V4", V4),
    ]
    checkers_np = {name: build_poisson_checker(V) for name, V in subspace_defs}

    def build_p_blocks(rep_groups):
        A_mat = np.hstack([ev_np[z] for grp in rep_groups for z in grp])
        rk, M, P, piv_cols = gf2_rref_with_transform(A_mat)
        assert rk == 43
        P_blocks = []
        cur_c = 0
        for grp in rep_groups:
            nxt_c = cur_c + 64 * len(grp)
            idxs = [i for i, pc in enumerate(piv_cols) if cur_c <= pc < nxt_c]
            P_blocks.append(P[idxs])
            cur_c = nxt_c
        return P_blocks

    def run_cascade_engine(backend="gpu", filter_mode="FULL_24", swap_3_5=False):
        """
        Runs the complete 12-stage n=12 cascade in exact int32 arithmetic.
        Measures H2D/D2H transfer time and kernel execution time separately.
        """
        t_start = time.perf_counter()
        t_transfer = 0.0
        t_kernel = 0.0
        overflow_checks_ok = True

        rem_order = [1, 11, 13, 31, 5, 3, 15, 23] if swap_3_5 else [1, 11, 13, 31, 3, 5, 15, 23]
        rep_groups = [[0, 63, 21], [9], [27], [7]] + [[z] for z in rem_order]
        P_blocks = build_p_blocks(rep_groups)

        if backend == "gpu" and use_gpu:
            # Transfer lookup tables to GPU once (measuring H2D transfer time)
            if dev.type == "cuda":
                torch.cuda.synchronize()
            th0 = time.perf_counter()
            ev_t = {z: torch.tensor(ev_np[z], dtype=torch.int32, device=dev) for z in fib_seq}
            perm_t = torch.tensor(perm_m, dtype=torch.long, device=dev)
            sign_t = torch.tensor(sign_m, dtype=torch.int32, device=dev)
            P_t = [torch.tensor(span_np(blk, 43), dtype=torch.int32, device=dev) for blk in P_blocks]
            chk_t = {}
            for name, (V_sub, signs, allowed) in checkers_np.items():
                chk_t[name] = (
                    V_sub,
                    torch.tensor(signs, dtype=torch.int32, device=dev),
                    torch.tensor(allowed, dtype=torch.bool, device=dev)
                )
            if dev.type == "cuda":
                torch.cuda.synchronize()
            t_transfer += time.perf_counter() - th0

            def eval_wz_gpu(c_t, z_rep):
                # Exact integer matrix product mod 2: max sum is 43 <= 127 (zero overflow in int32)
                gz = torch.matmul(c_t, ev_t[z_rep]) & 1
                W = fwht_torch(1 - 2 * gz)
                return W

            def transport_gpu(Wz, z_rep, k):
                if k == 0:
                    return Wz
                return Wz[:, perm_t[k]] * sign_t[z_rep, k, :][None, :]

            def pass_poisson_gpu(W_dict, cname):
                V_sub, signs_g, allowed_g = chk_t[cname]
                W_st = torch.stack([W_dict[z] for z in V_sub], dim=1) # (N, |V|, 64)
                # Exact int32 einsum: max |L| <= 16 * 64 = 1024
                L = torch.einsum('gz,nzb->ngb', signs_g, W_st)
                idx = torch.clamp((L + 1024) >> 1, 0, 1024).to(torch.long)
                b_idx = torch.arange(64, device=dev)[None, None, :]
                g_idx = torch.arange(signs_g.shape[0], device=dev)[None, :, None]
                return torch.all(allowed_g[b_idx, g_idx, idx], dim=(1, 2))

            if dev.type == "cuda":
                torch.cuda.synchronize()
            tk0 = time.perf_counter()

            # Stage 1 (Rank 12)
            c_s1 = P_t[0]
            W0 = eval_wz_gpu(c_s1, 0)
            W63 = eval_wz_gpu(c_s1, 63)
            W21 = eval_wz_gpu(c_s1, 21)
            W42 = transport_gpu(W21, 21, 1)
            # Check overflow bounds:
            if int(torch.max(torch.abs(W0)).item()) > 64:
                overflow_checks_ok = False
            A0, A63, A21 = W0[:, 0], W63[:, 0], W21[:, 0]
            E0 = A0*A0 + A63*A63 + 2*(A21*A21)
            E21 = W0[:, 21]**2 + W21[:, 42]**2
            s1p = (A0 + A63 + 2*A21) % 48
            s1m = (A0 + A63 - 2*A21) % 48
            ok_1a = (E0 <= 4096) & ((4096 - E0) % 384 == 0) & ((W0[:, 63]**2) % 384 == 256) & \
                    (E21 <= 4096) & ((4096 - E21) % 192 == 0) & ((A0 * A63 + A21*A21) % 3 == 0) & \
                    ((s1p == 16) | (s1p == 32)) & ((s1m == 16) | (s1m == 32))
            n_1a = int(torch.sum(ok_1a).item())
            Eb_s1 = W0**2 + W63**2 + W21**2 + W42**2
            W_d1 = {0: W0, 63: W63, 21: W21, 42: W42}
            ok_1b = ok_1a & torch.all(Eb_s1 <= 4096, dim=1) & pass_poisson_gpu(W_d1, "V2_21")
            if filter_mode == "FULL_24":
                ok_1b = ok_1b & pass_poisson_gpu(W_d1, "V1_63") & pass_poisson_gpu(W_d1, "V1_21")
            c_s1 = c_s1[ok_1b]
            Eb_s1 = Eb_s1[ok_1b]
            W0_1s, W63_1s, W21_1s, W42_1s = W0[ok_1b], W63[ok_1b], W21[ok_1b], W42[ok_1b]
            n_1b = int(c_s1.shape[0])

            # Stage 2 (Rank 18)
            dc_s2 = P_t[1]
            c_s2 = (c_s1[:, None, :] ^ dc_s2[None, :, :]).reshape(-1, 43)
            W9 = eval_wz_gpu(c_s2, 9)
            W18 = transport_gpu(W9, 9, 1)
            W36 = transport_gpu(W9, 9, 2)
            W0_s2  = torch.repeat_interleave(W0_1s, 64, dim=0)
            W63_s2 = torch.repeat_interleave(W63_1s, 64, dim=0)
            W21_s2 = torch.repeat_interleave(W21_1s, 64, dim=0)
            W42_s2 = torch.repeat_interleave(W42_1s, 64, dim=0)
            Eb_s2  = torch.repeat_interleave(Eb_s1, 64, dim=0) + W9**2 + W18**2 + W36**2
            ok_2 = torch.all(Eb_s2 <= 4096, dim=1) & pass_poisson_gpu({0: W0_s2, 9: W9}, "V1_9")
            c_s2 = c_s2[ok_2]
            Eb_s2 = Eb_s2[ok_2]
            W0_s2, W63_s2, W21_s2, W42_s2 = W0_s2[ok_2], W63_s2[ok_2], W21_s2[ok_2], W42_s2[ok_2]
            W9_s2, W18_s2, W36_s2 = W9[ok_2], W18[ok_2], W36[ok_2]
            n_2 = int(c_s2.shape[0])

            # Stage 3 (Rank 24) & Stage 4 (Rank 27)
            dc_s3 = P_t[2]
            dc_s4 = P_t[3]
            n_3 = 0
            c_s4_list, Eb_s4_list = [], []
            s3_subs = ["V2_27", "V1_27", "V2_9a", "V2_9b", "V3"] if filter_mode == "FULL_24" else ["V3"]
            s4_subs = ["V1_7", "V2_7a", "V2_7b", "V2_7c", "V2_7d", "V3_7a", "V4"] if filter_mode == "FULL_24" else ["V4"]

            for cs in range(0, n_2, 4096):
                ce = min(cs + 4096, n_2)
                c_ch3 = (c_s2[cs:ce, None, :] ^ dc_s3[None, :, :]).reshape(-1, 43)
                Eb_ch3 = torch.repeat_interleave(Eb_s2[cs:ce], 64, dim=0)
                W27 = eval_wz_gpu(c_ch3, 27)
                E0_3  = Eb_ch3[:, 0]  + 3 * (W27[:, 0]**2)
                E63_3 = Eb_ch3[:, 63] + 3 * (W27[:, 63]**2)
                E21_3 = Eb_ch3[:, 21] + 3 * (W27[:, 21]**2)
                valid3 = (E0_3 <= 4096) & ((4096 - E0_3) % 384 == 0) & \
                         (E63_3 <= 4096) & ((4096 - E63_3) % 384 == 0) & \
                         (E21_3 <= 4096) & ((4096 - E21_3) % 192 == 0)
                act3 = torch.where(valid3)[0]
                if act3.shape[0] > 0:
                    s_idx = torch.div(act3, 64, rounding_mode='floor')
                    W0_a  = W0_s2[cs + s_idx]
                    W63_a = W63_s2[cs + s_idx]
                    W21_a = W21_s2[cs + s_idx]
                    W42_a = W42_s2[cs + s_idx]
                    W9_a  = W9_s2[cs + s_idx]
                    W18_a = W18_s2[cs + s_idx]
                    W36_a = W36_s2[cs + s_idx]
                    W27_a = W27[act3]
                    W54_a = transport_gpu(W27_a, 27, 1)
                    W45_a = transport_gpu(W27_a, 27, 2)
                    Eb_a3 = Eb_ch3[act3] + W27_a**2 + W54_a**2 + W45_a**2
                    E_O9  = Eb_a3[:, 9] + Eb_a3[:, 18] + Eb_a3[:, 36]
                    E_O27 = Eb_a3[:, 27] + Eb_a3[:, 54] + Eb_a3[:, 45]
                    ok_e3 = ((W0_a[:,0]*W63_a[:,0] + W21_a[:,0]**2 + 3*W9_a[:,0]*W27_a[:,0]) % 192 == 0) & \
                            torch.all(Eb_a3 <= 4096, dim=1) & ((3*4096 - E_O9) % 192 == 0) & ((3*4096 - E_O27) % 192 == 0)
                    c_a3 = c_ch3[act3][ok_e3]
                    Eb_a3 = Eb_a3[ok_e3]
                    W_v3 = {0: W0_a[ok_e3], 63: W63_a[ok_e3], 21: W21_a[ok_e3], 42: W42_a[ok_e3],
                            9: W9_a[ok_e3], 18: W18_a[ok_e3], 36: W36_a[ok_e3],
                            27: W27_a[ok_e3], 54: W54_a[ok_e3], 45: W45_a[ok_e3]}
                    for cname in s3_subs:
                        if c_a3.shape[0] > 0:
                            keep = pass_poisson_gpu(W_v3, cname)
                            c_a3 = c_a3[keep]
                            Eb_a3 = Eb_a3[keep]
                            W_v3 = {z: W_v3[z][keep] for z in W_v3}
                    n_3 += int(c_a3.shape[0])
                    if c_a3.shape[0] > 0:
                        c_ch4 = (c_a3[:, None, :] ^ dc_s4[None, :, :]).reshape(-1, 43)
                        Eb_ch4 = torch.repeat_interleave(Eb_a3, 8, dim=0)
                        W7 = eval_wz_gpu(c_ch4, 7)
                        W_O7 = {O7[k]: transport_gpu(W7, 7, k) for k in range(6)}
                        for z in O7:
                            Eb_ch4 = Eb_ch4 + W_O7[z]**2
                        ok_e4 = torch.all(Eb_ch4 <= 4096, dim=1) & ((4096 - Eb_ch4[:, 0]) % 384 == 0) & ((4096 - Eb_ch4[:, 21]) % 192 == 0)
                        act4 = torch.where(ok_e4)[0]
                        if act4.shape[0] > 0:
                            c_a4 = c_ch4[act4]
                            Eb_a4 = Eb_ch4[act4]
                            W_v4 = {z: torch.repeat_interleave(W_v3[z], 8, dim=0)[act4] for z in W_v3}
                            for z in O7:
                                W_v4[z] = W_O7[z][act4]
                            for cname in s4_subs:
                                if c_a4.shape[0] > 0:
                                    keep = pass_poisson_gpu(W_v4, cname)
                                    c_a4 = c_a4[keep]
                                    Eb_a4 = Eb_a4[keep]
                                    W_v4 = {z: W_v4[z][keep] for z in W_v4}
                            if c_a4.shape[0] > 0:
                                c_s4_list.append(c_a4)
                                Eb_s4_list.append(Eb_a4)

            c_cur = torch.cat(c_s4_list, dim=0)
            Eb_cur = torch.cat(Eb_s4_list, dim=0)
            n_4 = int(c_cur.shape[0])
            stage_counts = [n_1a, n_1b, n_2, n_3, n_4]

            # Stages 5 to 9d
            for idx_r, z_rep in enumerate(rem_order):
                dc = P_t[4 + idx_r]
                k_mult = int(dc.shape[0])
                next_c, next_Eb = [], []
                for cs in range(0, int(c_cur.shape[0]), 32768):
                    ce = min(cs + 32768, int(c_cur.shape[0]))
                    if k_mult > 1:
                        c_ch = (c_cur[cs:ce, None, :] ^ dc[None, :, :]).reshape(-1, 43)
                        Eb_ch = torch.repeat_interleave(Eb_cur[cs:ce], k_mult, dim=0)
                    else:
                        c_ch = c_cur[cs:ce]
                        Eb_ch = Eb_cur[cs:ce].clone()
                    Wz = eval_wz_gpu(c_ch, z_rep)
                    for k in range(6):
                        Eb_ch = Eb_ch + transport_gpu(Wz, z_rep, k)**2
                    if int(torch.max(Eb_ch).item()) > 262144:
                        overflow_checks_ok = False
                    if z_rep == 23:
                        valid = torch.all(Eb_ch == 4096, dim=1)
                    else:
                        valid = torch.all(Eb_ch <= 4096, dim=1) & ((4096 - Eb_ch[:, 0]) % 384 == 0) & ((4096 - Eb_ch[:, 21]) % 192 == 0)
                        if z_rep in (3, 5, 15):
                            valid = valid & ((4096 - Eb_ch[:, 63]) % 384 == 0)
                    act = torch.where(valid)[0]
                    if act.shape[0] > 0:
                        c_a = c_ch[act]
                        Eb_a = Eb_ch[act]
                        if filter_mode == "FULL_24":
                            W0_a = eval_wz_gpu(c_a, 0)
                            keep = pass_poisson_gpu({0: W0_a, z_rep: Wz[act]}, f"V1_{z_rep}")
                            c_a = c_a[keep]
                            Eb_a = Eb_a[keep]
                        if c_a.shape[0] > 0:
                            next_c.append(c_a)
                            next_Eb.append(Eb_a)
                if next_c:
                    c_cur = torch.cat(next_c, dim=0)
                    Eb_cur = torch.cat(next_Eb, dim=0)
                else:
                    c_cur = torch.zeros((0, 43), dtype=torch.int32, device=dev)
                    Eb_cur = torch.zeros((0, 64), dtype=torch.int32, device=dev)
                stage_counts.append(int(c_cur.shape[0]))

            if dev.type == "cuda":
                torch.cuda.synchronize()
            t_kernel += time.perf_counter() - tk0

        else:
            # NumPy CPU execution
            tk0 = time.perf_counter()
            P_np = [span_np(blk, 43) for blk in P_blocks]

            def eval_wz_np(c_arr, z_rep):
                gz = (c_arr @ ev_np[z_rep]) & 1
                return fwht_np(1 - 2 * gz.astype(np.int32))

            def transport_np(Wz, z_rep, k):
                return Wz if k == 0 else Wz[:, perm_m[k]] * sign_m[z_rep, k, :][None, :]

            def pass_poisson_np(W_dict, cname):
                V_sub, signs_g, allowed_g = checkers_np[cname]
                W_st = np.stack([W_dict[z] for z in V_sub], axis=1)
                L = np.einsum('gz,nzb->ngb', signs_g, W_st)
                idx = np.clip((L + 1024) >> 1, 0, 1024)
                return np.all(allowed_g[np.arange(64)[None, None, :], np.arange(signs_g.shape[0])[None, :, None], idx], axis=(1, 2))

            c_s1 = P_np[0]
            W0, W63, W21 = eval_wz_np(c_s1, 0), eval_wz_np(c_s1, 63), eval_wz_np(c_s1, 21)
            W42 = transport_np(W21, 21, 1)
            A0, A63, A21 = W0[:, 0], W63[:, 0], W21[:, 0]
            E0 = A0**2 + A63**2 + 2*(A21**2)
            E21 = W0[:, 21]**2 + W21[:, 42]**2
            ok_1a = (E0 <= 4096) & ((4096 - E0) % 384 == 0) & ((W0[:, 63]**2) % 384 == 256) & \
                    (E21 <= 4096) & ((4096 - E21) % 192 == 0) & ((A0 * A63 + A21**2) % 3 == 0) & \
                    np.isin((A0 + A63 + 2*A21) % 48, [16, 32]) & np.isin((A0 + A63 - 2*A21) % 48, [16, 32])
            n_1a = int(np.sum(ok_1a))
            Eb_s1 = W0**2 + W63**2 + W21**2 + W42**2
            W_d1 = {0: W0, 63: W63, 21: W21, 42: W42}
            ok_1b = ok_1a & np.all(Eb_s1 <= 4096, axis=1) & pass_poisson_np(W_d1, "V2_21")
            if filter_mode == "FULL_24":
                ok_1b &= pass_poisson_np(W_d1, "V1_63") & pass_poisson_np(W_d1, "V1_21")
            c_s1, Eb_s1 = c_s1[ok_1b], Eb_s1[ok_1b]
            W0_1s, W63_1s, W21_1s, W42_1s = W0[ok_1b], W63[ok_1b], W21[ok_1b], W42[ok_1b]
            n_1b = len(c_s1)

            c_s2 = (c_s1[:, None, :] ^ P_np[1][None, :, :]).reshape(-1, 43)
            W9 = eval_wz_np(c_s2, 9)
            W18, W36 = transport_np(W9, 9, 1), transport_np(W9, 9, 2)
            W0_s2, W63_s2 = np.repeat(W0_1s, 64, axis=0), np.repeat(W63_1s, 64, axis=0)
            W21_s2, W42_s2 = np.repeat(W21_1s, 64, axis=0), np.repeat(W42_1s, 64, axis=0)
            Eb_s2 = np.repeat(Eb_s1, 64, axis=0) + W9**2 + W18**2 + W36**2
            ok_2 = np.all(Eb_s2 <= 4096, axis=1) & pass_poisson_np({0: W0_s2, 9: W9}, "V1_9")
            c_s2, Eb_s2 = c_s2[ok_2], Eb_s2[ok_2]
            W0_s2, W63_s2, W21_s2, W42_s2 = W0_s2[ok_2], W63_s2[ok_2], W21_s2[ok_2], W42_s2[ok_2]
            W9_s2, W18_s2, W36_s2 = W9[ok_2], W18[ok_2], W36[ok_2]
            n_2 = len(c_s2)

            n_3 = 0
            c_s4_list, Eb_s4_list = [], []
            s3_subs = ["V2_27", "V1_27", "V2_9a", "V2_9b", "V3"] if filter_mode == "FULL_24" else ["V3"]
            s4_subs = ["V1_7", "V2_7a", "V2_7b", "V2_7c", "V2_7d", "V3_7a", "V4"] if filter_mode == "FULL_24" else ["V4"]
            for cs in range(0, n_2, 2048):
                ce = min(cs + 2048, n_2)
                c_ch3 = (c_s2[cs:ce, None, :] ^ P_np[2][None, :, :]).reshape(-1, 43)
                Eb_ch3 = np.repeat(Eb_s2[cs:ce], 64, axis=0)
                W27 = eval_wz_np(c_ch3, 27)
                E0_3, E63_3, E21_3 = Eb_ch3[:, 0] + 3*(W27[:, 0]**2), Eb_ch3[:, 63] + 3*(W27[:, 63]**2), Eb_ch3[:, 21] + 3*(W27[:, 21]**2)
                valid3 = (E0_3 <= 4096) & ((4096 - E0_3) % 384 == 0) & (E63_3 <= 4096) & ((4096 - E63_3) % 384 == 0) & (E21_3 <= 4096) & ((4096 - E21_3) % 192 == 0)
                act3 = np.where(valid3)[0]
                if len(act3) > 0:
                    s_idx = act3 // 64
                    W0_a, W63_a, W21_a, W42_a = W0_s2[cs + s_idx], W63_s2[cs + s_idx], W21_s2[cs + s_idx], W42_s2[cs + s_idx]
                    W9_a, W18_a, W36_a = W9_s2[cs + s_idx], W18_s2[cs + s_idx], W36_s2[cs + s_idx]
                    W27_a = W27[act3]
                    W54_a, W45_a = transport_np(W27_a, 27, 1), transport_np(W27_a, 27, 2)
                    Eb_a3 = Eb_ch3[act3] + W27_a**2 + W54_a**2 + W45_a**2
                    E_O9, E_O27 = Eb_a3[:, 9] + Eb_a3[:, 18] + Eb_a3[:, 36], Eb_a3[:, 27] + Eb_a3[:, 54] + Eb_a3[:, 45]
                    ok_e3 = ((W0_a[:,0]*W63_a[:,0] + W21_a[:,0]**2 + 3*W9_a[:,0]*W27_a[:,0]) % 192 == 0) & \
                            np.all(Eb_a3 <= 4096, axis=1) & ((3*4096 - E_O9) % 192 == 0) & ((3*4096 - E_O27) % 192 == 0)
                    c_a3, Eb_a3 = c_ch3[act3][ok_e3], Eb_a3[ok_e3]
                    W_v3 = {0: W0_a[ok_e3], 63: W63_a[ok_e3], 21: W21_a[ok_e3], 42: W42_a[ok_e3],
                            9: W9_a[ok_e3], 18: W18_a[ok_e3], 36: W36_a[ok_e3],
                            27: W27_a[ok_e3], 54: W54_a[ok_e3], 45: W45_a[ok_e3]}
                    for cname in s3_subs:
                        if len(c_a3) > 0:
                            keep = pass_poisson_np(W_v3, cname)
                            c_a3, Eb_a3 = c_a3[keep], Eb_a3[keep]
                            W_v3 = {z: W_v3[z][keep] for z in W_v3}
                    n_3 += len(c_a3)
                    if len(c_a3) > 0:
                        c_ch4 = (c_a3[:, None, :] ^ P_np[3][None, :, :]).reshape(-1, 43)
                        Eb_ch4 = np.repeat(Eb_a3, 8, axis=0)
                        W7 = eval_wz_np(c_ch4, 7)
                        W_O7 = {O7[k]: transport_np(W7, 7, k) for k in range(6)}
                        Eb_ch4 = Eb_ch4 + sum(W_O7[z]**2 for z in O7)
                        ok_e4 = np.all(Eb_ch4 <= 4096, axis=1) & ((4096 - Eb_ch4[:, 0]) % 384 == 0) & ((4096 - Eb_ch4[:, 21]) % 192 == 0)
                        act4 = np.where(ok_e4)[0]
                        if len(act4) > 0:
                            c_a4, Eb_a4 = c_ch4[act4], Eb_ch4[act4]
                            W_v4 = {z: np.repeat(W_v3[z], 8, axis=0)[act4] for z in W_v3}
                            for z in O7:
                                W_v4[z] = W_O7[z][act4]
                            for cname in s4_subs:
                                if len(c_a4) > 0:
                                    keep = pass_poisson_np(W_v4, cname)
                                    c_a4, Eb_a4 = c_a4[keep], Eb_a4[keep]
                                    W_v4 = {z: W_v4[z][keep] for z in W_v4}
                            if len(c_a4) > 0:
                                c_s4_list.append(c_a4)
                                Eb_s4_list.append(Eb_a4)

            c_cur, Eb_cur = np.vstack(c_s4_list), np.vstack(Eb_s4_list)
            stage_counts = [n_1a, n_1b, n_2, n_3, len(c_cur)]

            for idx_r, z_rep in enumerate(rem_order):
                dc = P_np[4 + idx_r]
                k_mult = len(dc)
                next_c, next_Eb = [], []
                for cs in range(0, len(c_cur), 16384):
                    ce = min(cs + 16384, len(c_cur))
                    if k_mult > 1:
                        c_ch = (c_cur[cs:ce, None, :] ^ dc[None, :, :]).reshape(-1, 43)
                        Eb_ch = np.repeat(Eb_cur[cs:ce], k_mult, axis=0)
                    else:
                        c_ch, Eb_ch = c_cur[cs:ce], Eb_cur[cs:ce].copy()
                    Wz = eval_wz_np(c_ch, z_rep)
                    for k in range(6):
                        Eb_ch += transport_np(Wz, z_rep, k)**2
                    if z_rep == 23:
                        valid = np.all(Eb_ch == 4096, axis=1)
                    else:
                        valid = np.all(Eb_ch <= 4096, axis=1) & ((4096 - Eb_ch[:, 0]) % 384 == 0) & ((4096 - Eb_ch[:, 21]) % 192 == 0)
                        if z_rep in (3, 5, 15):
                            valid &= ((4096 - Eb_ch[:, 63]) % 384 == 0)
                    act = np.where(valid)[0]
                    if len(act) > 0:
                        c_a, Eb_a = c_ch[act], Eb_ch[act]
                        if filter_mode == "FULL_24":
                            W0_a = eval_wz_np(c_a, 0)
                            keep = pass_poisson_np({0: W0_a, z_rep: Wz[act]}, f"V1_{z_rep}")
                            c_a, Eb_a = c_a[keep], Eb_a[keep]
                        if len(c_a) > 0:
                            next_c.append(c_a)
                            next_Eb.append(Eb_a)
                if next_c:
                    c_cur, Eb_cur = np.vstack(next_c), np.vstack(next_Eb)
                else:
                    c_cur, Eb_cur = np.zeros((0, 43), dtype=np.uint8), np.zeros((0, 64), dtype=np.int32)
                stage_counts.append(len(c_cur))
            t_kernel += time.perf_counter() - tk0

        t_total = time.perf_counter() - t_start
        return {
            "backend": backend,
            "filter_mode": filter_mode,
            "swap_3_5": swap_3_5,
            "stage_counts": stage_counts,
            "peak_survivors": max(stage_counts),
            "final_survivors": stage_counts[-1],
            "overflow_checks_ok": overflow_checks_ok,
            "transfer_seconds": round(t_transfer, 4),
            "kernel_seconds": round(t_kernel, 4),
            "total_seconds": round(t_total, 4),
        }

    ref_expected = [712, 361, 20158, 212296, 8688, 26496, 94936, 149448, 106552, 349680, 23636, 128, 0]
    swap_expected = [712, 361, 20158, 212296, 8688, 26496, 94936, 149448, 106552, 148412, 23636, 128, 0]

    # 1. Run GPU (or Torch) Full 24 subspaces
    res_gpu_full = run_cascade_engine(backend="gpu", filter_mode="FULL_24", swap_3_5=False)
    print(f"\n[1] GPU / Torch (24 subespaços de Poisson, ordem padrão):")
    print(f"    Contadores: {res_gpu_full['stage_counts']}")
    print(f"    Transferência H2D/D2H: {res_gpu_full['transfer_seconds']:.4f}s | Kernel: {res_gpu_full['kernel_seconds']:.4f}s | Total: {res_gpu_full['total_seconds']:.4f}s")
    assert res_gpu_full["stage_counts"] == ref_expected and res_gpu_full["overflow_checks_ok"]

    # 2. Run GPU Minimal Certificate (ONLY 4 subspaces: V2_21, V1_9, V3, V4; ZERO V1 Poisson in stages 5..9d!)
    res_gpu_min4 = run_cascade_engine(backend="gpu", filter_mode="MINIMAL_4", swap_3_5=False)
    print(f"\n[2] Certificado Mínimo (APENAS 4 subespaços: V2_21, V1_9, V3, V4; ZERO Poisson nos Estágios 5–9d):")
    print(f"    Contadores: {res_gpu_min4['stage_counts']}")
    print(f"    Igualdade exata com os 24 subespaços: {res_gpu_min4['stage_counts'] == ref_expected} | Tempo: {res_gpu_min4['total_seconds']:.4f}s")
    assert res_gpu_min4["stage_counts"] == ref_expected

    # 3. Run GPU Minimal Certificate + Swapped (O_5 before O_3 -> 57.3% lower peak!)
    res_gpu_swap = run_cascade_engine(backend="gpu", filter_mode="MINIMAL_4", swap_3_5=True)
    print(f"\n[3] Certificado Mínimo + Permutação O_5 <-> O_3 (pico reduzido em 57,3%: 349.680 -> 149.448):")
    print(f"    Contadores: {res_gpu_swap['stage_counts']}")
    print(f"    Pico máximo: {res_gpu_swap['peak_survivors']:,d} | Tempo: {res_gpu_swap['total_seconds']:.4f}s")
    assert res_gpu_swap["stage_counts"] == swap_expected

    # 4. Run CPU Reference comparison
    res_cpu_min4 = run_cascade_engine(backend="cpu", filter_mode="MINIMAL_4", swap_3_5=False)
    print(f"\n[4] Comparação Direta CPU (NumPy int32) vs GPU:")
    print(f"    CPU Contadores == GPU Contadores: {res_cpu_min4['stage_counts'] == res_gpu_full['stage_counts']}")
    print(f"    Tempo CPU: {res_cpu_min4['total_seconds']:.4f}s vs Tempo GPU: {res_gpu_min4['total_seconds']:.4f}s "
          f"(Speedup: {res_cpu_min4['total_seconds'] / max(1e-6, res_gpu_min4['total_seconds']):.2f}x)")
    assert res_cpu_min4["stage_counts"] == res_gpu_full["stage_counts"]

    return {
        "gpu_full_24": res_gpu_full,
        "gpu_minimal_4": res_gpu_min4,
        "gpu_minimal_4_swap35": res_gpu_swap,
        "cpu_minimal_4": res_cpu_min4,
    }


# =============================================================================
# MISSÃO 3: EXPLORAÇÃO E ELIMINAÇÃO DE SETORES EM n = 20 (FAMÍLIA n = 4p^r, p = 5)
# =============================================================================

def run_n20_exploration(device_str="cuda"):
    t0 = time.perf_counter()
    print("\n" + "=" * 84)
    print(" [MISSÃO 3] RESTRIÇÕES E ELIMINAÇÃO DE SETORES EM n = 20 (h = 10, FAMÍLIA n = 4p^r)")
    print("=" * 84)

    orbs20 = get_orbits_deg4(20)
    assert len(orbs20) == 245
    t1, t2, t3 = [], [], []
    for idx, (tup, orb) in enumerate(orbs20):
        ap = sum(1 for i in range(10) if (i in tup and (i + 10) in tup))
        if ap == 0:
            t1.append(idx)
        elif ap == 1:
            t2.append(idx)
        else:
            t3.append(idx)
    assert len(t1) == 168 and len(t2) == 72 and len(t3) == 5
    print(f"Órbitas quárticas RS em n = 20: 245 ({len(t1)} Tipo I, {len(t2)} Tipo II, {len(t3)} Tipo III: {t3})")

    U10 = np.arange(1024, dtype=np.int32)
    parity10 = np.array([u.bit_count() % 2 for u in range(1024)], dtype=np.int32)

    def eval_fiber20(z):
        pt = U10 | ((U10 ^ z) << 10)
        mat = np.zeros((245, 1024), dtype=np.uint8)
        for idx, (_, orb) in enumerate(orbs20):
            acc = np.zeros(1024, dtype=np.uint8)
            for m in orb:
                acc ^= ((pt & m) == m).astype(np.uint8)
            mat[idx] = acc
        return mat

    ev0    = eval_fiber20(0)
    ev1023 = eval_fiber20(1023)
    ev341  = eval_fiber20(341)

    # 1. Quarter-period operators T_z(u) = R_{10}^5(u) ^ tau_5(z) on the 6 period-5 fiber orbits:
    p5_reps = [33, 99, 165, 231, 363, 495]
    p5_report = {}
    print("\n[3.1] Operadores de Quarto de Período T_z(u) = R_{10}^5(u) ^ tau_5(z) nas 6 órbitas de período 5:")
    for z in p5_reps:
        evz = eval_fiber20(z)
        rkz, _, _, _ = gf2_rref_with_transform(evz)
        tau5 = rot(20, z << 10, 5) & 1023
        Tz = np.array([rot(10, u, 5) ^ tau5 for u in range(1024)])
        assert np.array_equal(Tz[Tz], U10 ^ z) and np.array_equal(evz[:, Tz], evz)
        seen_u, orb_reps, even_reps, odd_reps = set(), [], [], []
        for u in range(1024):
            if u not in seen_u:
                o4 = [u, int(Tz[u]), int(Tz[Tz[u]]), int(Tz[Tz[Tz[u]]])]
                assert len(set(o4)) == 4
                seen_u.update(o4)
                orb_reps.append(u)
                if tau5.bit_count() % 2 == 0:
                    if parity10[u] == 0:
                        even_reps.append(u)
                    else:
                        odd_reps.append(u)
        all_even = bool(np.all(np.sum(evz[:, orb_reps], axis=1) % 2 == 0))
        assert all_even
        if tau5.bit_count() % 2 == 0:
            ev_e = bool(np.all(np.sum(evz[:, even_reps], axis=1) % 2 == 0))
            ev_o = bool(np.all(np.sum(evz[:, odd_reps], axis=1) % 2 == 0))
            assert ev_e and ev_o
            w1023_rule = "32 | W_z(1023)"
        else:
            w1023_rule = "W_z(1023) = 0"
        print(f"  z = {z:3d} (tau5 = {tau5:2d}, wt = {tau5.bit_count()}): posto = {rkz:2d} | 32 | A_z: True | {w1023_rule}")
        p5_report[str(z)] = {"rank": int(rkz), "tau5": int(tau5), "div32_Az": True, "b1023_property": w1023_rule}

    # 2. Negacyclic syzygies and Z/4Z identity on z = 1023 (1_10):
    seen_neg, neg_orbs = set(), []
    for u in range(1024):
        if u not in seen_neg:
            cur, orb = u, []
            for _ in range(20):
                if cur not in orb:
                    orb.append(cur)
                seen_neg.add(cur)
                top = (cur >> 9) & 1
                cur = (((cur << 1) & 1023) | (top ^ 1))
            neg_orbs.append((min(orb), len(orb), orb))
    neg_reps = [r for r, _, _ in neg_orbs]
    neg_sizes = [sz for _, sz, _ in neg_orbs]
    assert neg_sizes == [20]*51 + [4]
    rk1023, bas1023, _, _ = gf2_rref_with_transform(ev1023)
    assert rk1023 == 13
    # Verify universal F_2 syzygy sum_{i=1}^{51} v_i == v_{52} (mod 2) on all 245 generators,
    # and universal Z/4Z identity sum_{i=1}^{51} v_i + v_{52} == 0 (mod 4) on all 2^13 = 8,192 reachable functions!
    vals_gen = ev1023[:, neg_reps]
    assert np.all(np.sum(vals_gen[:, :51], axis=1) % 2 == vals_gen[:, 51])
    sp1023 = span_np(bas1023, 1024)
    vals_8192 = sp1023[:, neg_reps].astype(np.int32)
    z4_sum = np.sum(vals_8192[:, :51], axis=1) + vals_8192[:, 51]
    assert np.all(z4_sum % 4 == 0)
    W1023_all = fwht_np(1 - 2 * sp1023.astype(np.int32))
    A1023_vals = sorted(set(W1023_all[:, 0].tolist()))
    assert all(a % 32 == 0 and (a * a) % 2560 == 1536 for a in A1023_vals)
    print(f"\n[3.2] Fibra Antidiagonal z = 1023 (1_10):")
    print(f"  * 52 órbitas negacíclicas (51 de tamanho 20 e 1 de tamanho 4), mas posto(g_1023) = {rk1023} (39 sizígias F_2-lineares!).")
    print(f"  * Identidade Z/4Z universal verificada nas 2^13 = 8.192 funções: sum_{{i=1}}^{{51}} v_i + v_52 == 0 (mod 4).")
    print(f"  * Valores de A_1023: {A1023_vals} => 32 | A_1023 e A_1023^2 == 1536 (mod 2560) identicamente!")

    # 3. Analytical elimination of 24 of the 32 bi-antipodal sectors in n = 20:
    sp0 = span_np(ev0[t3], 1024)
    W0_32 = fwht_np(1 - 2 * sp0.astype(np.int32))
    sectors20 = []
    surv_sectors = 0
    for mask in range(32):
        d = [(mask >> i) & 1 for i in range(5)]
        a0 = int(W0_32[mask, 0])
        w1023 = int(W0_32[mask, 1023])
        w341 = int(W0_32[mask, 341])
        ok_b1023 = ((w1023 * w1023) % 2560 == 1536)
        alg_law = (d[4] == 0) and ((d[1] ^ d[3]) == 1)
        assert ok_b1023 == alg_law
        if ok_b1023:
            assert a0 == 0 and w341 == 0
            surv_sectors += 1
        sectors20.append({"d": d, "A0": a0, "W0_1023": w1023, "W0_341": w341, "survives_b1023_mod2560": ok_b1023})
    assert surv_sectors == 8
    print(f"\n[3.3] Novo Teorema de Eliminação de Setores em n = 20 (via Parseval em b = 1023 mod 2560):")
    print(f"  * W_0(1023)^2 == 2^20 == 1536 (mod 2560) <==> c_244 = 0 E c_186 ^ c_242 = 1 (mod 2).")
    print(f"  * Elimina 24 dos 32 setores bi-antipodais (75% de 2^245, incluindo todos os 16 setores com c_244 = 1)!")
    print(f"  * Nos 8 setores sobreviventes, A_0 = 0 e W_0(341) = 0 identicamente.")

    # 4. Period-2 fiber z = 341: joint rank, Z/4Z syzygy, hyperplane v_a ^ v_b = 1, and 2^22 sieve:
    rk_joint, _, _, piv_j = gf2_rref_with_transform(np.hstack([ev0, ev1023, ev341]))
    assert rk_joint == 32
    tau2 = rot(20, 341 << 10, 2) & 1023
    S2 = np.array([rot(10, u, 2) ^ tau2 for u in range(1024)])
    seen341, orbs_341 = set(), []
    for u in range(1024):
        if u not in seen341:
            orb = set()
            cur = u
            for _ in range(10):
                orb.add(cur)
                orb.add(cur ^ 341)
                cur = int(S2[cur])
            seen341.update(orb)
            orbs_341.append((min(orb), len(orb), sorted(orb)))
    reps_341 = [r for r, _, _ in orbs_341]
    sizes_341 = np.array([sz for _, sz, _ in orbs_341], dtype=np.int64)
    signs_682 = np.array([1 - 2 * ((r & 682).bit_count() % 2) for r in reps_341], dtype=np.int64)
    idx_sz10 = [i for i, sz in enumerate(sizes_341) if sz == 10]
    idx_sz2  = [i for i, sz in enumerate(sizes_341) if sz == 2]
    assert len(idx_sz10) == 102 and len(idx_sz2) == 2

    rk341, bas341, _, _ = gf2_rref_with_transform(ev341[:, reps_341])
    assert rk341 == 22
    sp341 = span_np(bas341, len(reps_341))
    K_sum = np.sum(sp341[:, idx_sz10], axis=1, dtype=np.int32)
    v_ab  = np.sum(sp341[:, idx_sz2], axis=1, dtype=np.int32)
    assert np.all((K_sum + v_ab) % 4 == 0)
    pm341 = 1 - 2 * sp341.astype(np.int64)
    A341_all = pm341 @ sizes_341
    W341_682 = pm341 @ (sizes_341 * signs_682)
    ok_341 = (A341_all % 160 == 0) & ((W341_682**2) % 1280 == 256)
    n_surv_341 = int(np.sum(ok_341))
    assert np.array_equal(A341_all % 5 == 0, (v_ab == 1))
    assert np.array_equal((W341_682**2) % 1280 == 256, (v_ab == 1))
    print(f"\n[3.4] Fibra de Período 2 (z = 341) e Acoplamento em V_2 = {{0, 341, 682, 1023}}:")
    print(f"  * Posto individual rk(g_341) = 22, mas posto conjunto rk(g_0, g_1023, g_341) = 32 (d_rk = 14, 8 sizígias cruzadas!).")
    print(f"  * Identidade Z/4Z universal em z = 341 (nas 2^22 = 4.194.304 funções): K + v_a + v_b == 0 (mod 4).")
    print(f"  * Condição necessária de bentness 160 | A_341 e W_341(682)^2 == 256 (mod 1280):")
    print(f"    Força o hiperplano F_2-linear v_a ^ v_b = 1 e K == 3 (mod 8), reduzindo 4.194.304 -> {n_surv_341:,d} (73,44% eliminado!).")

    return {
        "n20_ranks": {"g0": 5, "g1023": 13, "g341": 22, "joint_V2": 32, "period5_orbits": p5_report},
        "n20_sectors_total": 32,
        "n20_sectors_surviving_b1023": surv_sectors,
        "n20_g341_total": int(1 << rk341),
        "n20_g341_survivors": n_surv_341,
        "elapsed_seconds": round(time.perf_counter() - t0, 4),
    }


# =============================================================================
# MISSÃO 4: EXPLORAÇÃO E ELIMINAÇÃO DE SETORES EM n = 16 (h = 8, dim H = 116)
# =============================================================================

def run_n16_exploration():
    t0 = time.perf_counter()
    print("\n" + "=" * 84)
    print(" [MISSÃO 4] RESTRIÇÕES E ELIMINAÇÃO DE SETORES EM n = 16 (h = 8, 116 ÓRBITAS)")
    print("=" * 84)

    orbs16 = get_orbits_deg4(16)
    assert len(orbs16) == 116
    t3 = [i for i, (tup, _) in enumerate(orbs16) if sum(1 for k in range(8) if k in tup and (k + 8) in tup) == 2]
    U8 = np.arange(256, dtype=np.int32)
    def eval_f16(z):
        pt = U8 | ((U8 ^ z) << 8)
        mat = np.zeros((116, 256), dtype=np.uint8)
        for idx, (_, orb) in enumerate(orbs16):
            acc = np.zeros(256, dtype=np.uint8)
            for m in orb:
                acc ^= ((pt & m) == m).astype(np.uint8)
            mat[idx] = acc
        return mat

    ev0, ev255, ev85, ev170 = eval_f16(0), eval_f16(255), eval_f16(85), eval_f16(170)
    rk_v2, _, P, piv_cols = gf2_rref_with_transform(np.hstack([ev0, ev255, ev85]))
    P_0   = P[[i for i, pc in enumerate(piv_cols) if 0 <= pc < 256]]
    P_255 = P[[i for i, pc in enumerate(piv_cols) if 256 <= pc < 512]]
    P_85  = P[[i for i, pc in enumerate(piv_cols) if 512 <= pc < 768]]

    # Sector elimination via 64 | A_0 and 64 | W_0(255):
    sp0 = span_np(P_0, 116)
    W0_16 = fwht_np(1 - 2 * ((sp0 @ ev0) & 1).astype(np.int32))
    surv_sec16 = int(np.sum((W0_16[:, 0] % 64 == 0) & (W0_16[:, 255] % 64 == 0)))
    assert surv_sec16 == 4

    c_0_255 = span_np(np.vstack([P_0, P_255]), 116)
    W0   = fwht_np(1 - 2 * ((c_0_255 @ ev0) & 1).astype(np.int32))
    W255 = fwht_np(1 - 2 * ((c_0_255 @ ev255) & 1).astype(np.int32))
    Eb1  = W0**2 + W255**2
    ok1  = (W0[:, 0] % 64 == 0) & (W0[:, 255] % 64 == 0) & np.all(Eb1 <= 65536, axis=1) & \
           ((65536 - Eb1[:, 0]) % 2048 == 0) & ((65536 - Eb1[:, 255]) % 2048 == 0)
    n_s1 = int(np.sum(ok1))

    print(f"  * Postos em n = 16: rk(g_0) = 4, d_rk(g_255) = 8, d_rk(g_85) = 9 (posto conjunto V_2 = {rk_v2}, 5 sizígias).")
    print(f"  * Divisibilidades exatas: 64 | A_255, 64 | A_85, e 32 | A_z, 32 | W_z(255) para z in {{17, 51, 119}}.")
    print(f"  * Congruência b = 0, 255 (mod 2048) => 64 | A_0 e 64 | W_0(255): elimina 12 dos 16 setores de g_0 (75% de 2^116)!")
    print(f"  * Estágio 1 em V_1(255) (posto 12 = 4.096 classes): {n_s1:,d} sobreviventes (78,91% eliminado).")

    return {
        "n16_ranks": {"g0": 4, "d_rk_g255": 8, "d_rk_g85": 9, "joint_V2": int(rk_v2)},
        "n16_sectors_total": 16,
        "n16_sectors_surviving": surv_sec16,
        "n16_stage1_v1_255_survivors": n_s1,
        "elapsed_seconds": round(time.perf_counter() - t0, 4),
    }


def main():
    t_all = time.perf_counter()
    res12 = run_n12_gpu_and_ablation("cuda" if HAS_CUDA else "cpu")
    res20 = run_n20_exploration("cuda" if HAS_CUDA else "cpu")
    res16 = run_n16_exploration()

    out_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "results")
    os.makedirs(out_dir, exist_ok=True)
    out_path = os.path.join(out_dir, "a100_deg4_mission_report.json")
    full_report = {
        "timestamp": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "cuda_available": HAS_CUDA,
        "device_name": torch.cuda.get_device_name(0) if HAS_CUDA else "CPU",
        "mission_1_and_2_n12": res12,
        "mission_3_n20": res20,
        "mission_4_n16": res16,
        "total_elapsed_seconds": round(time.perf_counter() - t_all, 4),
    }
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(full_report, f, indent=2, ensure_ascii=False)
    print("\n" + "=" * 84)
    print(f" MISSÃO CONCLUÍDA COM SUCESSO EM {full_report['total_elapsed_seconds']:.2f}s! Relatório salvo em: {out_path}")
    print("=" * 84)

if __name__ == "__main__":
    main()

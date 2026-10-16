"""
verify_independent_n12_reimpl.py
Segunda Implementação Independente da Cascata de n = 12 (Postos 12 -> 43)
Conjectura de Stănică–Maitra Homogênea de Grau d = 4

DIFERENÇAS ARQUITETURAIS EM RELAÇÃO AO SCRIPT PRINCIPAL:
1. ZERO USO DE FÓRMULAS DE TRANSPORTE DE WALSH ENTRE FIBRAS:
   Em vez de avaliar apenas os 14 representantes de fibras e transportar W_{g_z}(b) para
   sigma^k(z) via tau_k(z) e fatores de sinal (-1)^{<b, tau_k(z)>}, este verificador
   constrói diretamente a tabela de verdade de g_z(u) = f(u, u ^ z) em TODAS AS 64 FIBRAS
   z in {0..63} a partir da tabela de verdade de 4.096 pontos de f em F_2^{12}, e calcula
   W_{g_z}(b) diretamente por Transformada Rápida de Walsh-Hadamard (FWHT butterfly) em
   cada uma das 64 fibras individualmente.
2. PARAMETRIZAÇÃO DIRETA POR VARIÁVEIS DE ÓRBITA (COEFICIENTES c in F_2^{43}):
   Em vez de operar no espaço imagem abstrato de 896 colunas via RREF de linhas,
   identificamos para cada estágio um conjunto de variáveis pivô entre os 43 coeficientes
   reais c_0, ..., c_{42} in {0, 1} das órbitas quárticas RS (módulo o núcleo das fibras
   ainda não visitadas). No Estágio 9b (posto 41), obtemos explicitamente os 23.636 * 4 =
   94.544 vetores de coeficientes c in F_2^{43} e verificamos seus espectros completos.
"""
import time
from itertools import combinations
from collections import Counter
import numpy as np

def fwht64_batch(x):
    """6-bit Fast Walsh-Hadamard Transform via butterfly on last axis of shape (..., 64)."""
    h = x.copy()
    for step in (1, 2, 4, 8, 16, 32):
        h = h.reshape(*h.shape[:-1], -1, 2, step)
        u = h[..., 0, :].copy()
        v = h[..., 1, :].copy()
        h[..., 0, :] = u + v
        h[..., 1, :] = u - v
        h = h.reshape(*x.shape)
    return h

def main():
    t0 = time.time()
    print('================================================================================')
    print(' SEGUNDA IMPLEMENTAÇÃO INDEPENDENTE DA CASCATA DE n = 12 (SEM TRANSPORTE)')
    print(' Avaliação direta nas 64 fibras z in F_2^6 + Parametrização em F_2^{43}')
    print('================================================================================\n')
    seen_mon = set()
    orbits12 = []
    for comb in combinations(range(12), 4):
        mask = sum((1 << i for i in comb))
        if mask not in seen_mon:
            orb = set()
            cur = mask
            for _ in range(12):
                orb.add(cur)
                cur = cur << 1 & 4095 | cur >> 11
            seen_mon |= orb
            canon = min((tuple((i for i in range(12) if m >> i & 1)) for m in orb if m & 1))
            orbits12.append((canon, sorted(orb)))
    orbits12.sort(key=lambda item: item[0])
    assert len(orbits12) == 43
    X12 = np.arange(4096, dtype=np.int32)
    tt43 = np.zeros((43, 4096), dtype=np.uint8)
    for idx, (_, mon_list) in enumerate(orbits12):
        acc = np.zeros(4096, dtype=np.uint8)
        for m in mon_list:
            acc ^= (X12 & m == m).astype(np.uint8)
        tt43[idx] = acc
    U6 = np.arange(64, dtype=np.int32)
    fiber_tt43 = np.zeros((43, 64, 64), dtype=np.uint8)
    for z in range(64):
        pts = U6 | (U6 ^ z) << 6
        fiber_tt43[:, z, :] = tt43[:, pts]

    def orbit6_of(z):
        res = []
        cur = z
        for _ in range(6):
            if cur not in res:
                res.append(cur)
            cur = cur << 1 & 63 | cur >> 5
        return res
    stage_reps = [0, 63, 21, 9, 27, 7, 1, 11, 13, 31, 3, 5, 15, 23]
    stage_fiber_groups = [[0, 63, 21, 42], orbit6_of(9), orbit6_of(27), orbit6_of(7), orbit6_of(1), orbit6_of(11), orbit6_of(13), orbit6_of(31), orbit6_of(3), orbit6_of(5), orbit6_of(15), orbit6_of(23)]
    all_fibers_ordered = [z for grp in stage_fiber_groups for z in grp]
    assert len(all_fibers_ordered) == 64 and len(set(all_fibers_ordered)) == 64
    A_mat = np.hstack([fiber_tt43[:, z, :] for z in all_fibers_ordered])
    M = A_mat.copy()
    P = np.eye(43, dtype=np.uint8)
    rk = 0
    piv_cols = []
    for col in range(M.shape[1]):
        for r in range(rk, 43):
            if M[r, col]:
                if r != rk:
                    M[[rk, r]] = M[[r, rk]]
                    P[[rk, r]] = P[[r, rk]]
                for r2 in range(43):
                    if r2 != rk and M[r2, col]:
                        M[r2] ^= M[rk]
                        P[r2] ^= P[rk]
                piv_cols.append(col)
                rk += 1
                break
    assert rk == 43
    assert np.array_equal(P @ A_mat & 1, M)
    assert np.array_equal(M[:, piv_cols], np.eye(43, dtype=np.uint8))
    stage_col_ranges = []
    cur_c = 0
    for grp in stage_fiber_groups:
        nxt_c = cur_c + 64 * len(grp)
        stage_col_ranges.append((cur_c, nxt_c))
        cur_c = nxt_c
    P_blocks = []
    for lo, hi in stage_col_ranges:
        idxs = [i for i, pc in enumerate(piv_cols) if lo <= pc < hi]
        P_blocks.append(P[idxs])
    print('Incrementos de posto por estágio (parametrizados diretamente em F_2^{43}):', [len(b) for b in P_blocks])
    orb12_of = np.zeros(4096, dtype=np.int32)
    seen12 = set()
    oid = 0
    for x in range(4096):
        if x not in seen12:
            cur = x
            for _ in range(12):
                orb12_of[cur] = oid
                seen12.add(cur)
                cur = cur << 1 & 4095 | cur >> 11
            oid += 1

    def build_poisson_checker(V_sub):
        assert 0 in V_sub and len(set(V_sub)) == len(V_sub)
        assert all((x ^ y in V_sub for x in V_sub for y in V_sub))
        V_perp = [beta for beta in range(64) if all((bin(beta & z).count('1') % 2 == 0 for z in V_sub))]
        scale = len(V_sub)
        reps = []
        seen = set()
        for g in range(64):
            if g not in seen:
                reps.append(g)
                for v in V_perp:
                    seen.add(g ^ v)
        signs = np.array([[-1 if bin(g & z).count('1') % 2 else 1 for z in V_sub] for g in reps], dtype=np.int32)
        allowed = np.zeros((64, len(reps), 1025), dtype=bool)
        for b in range(64):
            for gi, g in enumerate(reps):
                cnt = Counter((orb12_of[b ^ (g ^ v) | (g ^ v) << 6] for v in V_perp))
                vals = {0}
                for m in cnt.values():
                    vals = {v + m for v in vals} | {v - m for v in vals}
                for v in vals:
                    lv = scale * v
                    if -1024 <= lv <= 1024:
                        allowed[b, gi, lv + 1024 >> 1] = True
        return (V_sub, signs, allowed)
    O7 = orbit6_of(7)
    V4 = sorted([0, 63, 21, 42, 9, 18, 36, 27, 54, 45] + O7)
    checkers = {name: build_poisson_checker(V) for name, V in [('V1_63', [0, 63]), ('V1_21', [0, 21]), ('V1_9', [0, 9]), ('V1_27', [0, 27]), ('V1_7', [0, 7]), ('V1_1', [0, 1]), ('V1_11', [0, 11]), ('V1_13', [0, 13]), ('V1_31', [0, 31]), ('V1_3', [0, 3]), ('V1_5', [0, 5]), ('V1_15', [0, 15]), ('V1_23', [0, 23]), ('V2_21', [0, 21, 42, 63]), ('V2_27', [0, 27, 45, 54]), ('V2_9a', [0, 9, 18, 27]), ('V2_9b', [0, 9, 54, 63]), ('V2_7a', [0, 7, 56, 63]), ('V2_7b', [0, 7, 14, 9]), ('V2_7c', [0, 7, 21, 18]), ('V2_7d', [0, 7, 28, 27]), ('V3', [0, 9, 18, 27, 36, 45, 54, 63]), ('V3_7a', sorted([0, 63, 9, 54, 7, 56, 14, 49])), ('V4', V4)]}

    def pass_poisson(W_dict, cname, b_arr=np.arange(64, dtype=np.int32)):
        V_sub, signs, allowed = checkers[cname]
        W_st = np.stack([W_dict[z][:, b_arr] for z in V_sub], axis=1)
        L = np.einsum('gz,nzb->ngb', signs, W_st)
        idx = np.clip(L + 1024 >> 1, 0, 1024)
        return np.all(allowed[b_arr[None, None, :], np.arange(signs.shape[0])[None, :, None], idx], axis=(1, 2))

    def span_c(P_blk):
        k = len(P_blk)
        res = np.zeros((1 << k, 43), dtype=np.uint8)
        for i in range(k):
            res[1 << i:2 << i] = res[:1 << i] ^ P_blk[i]
        return res

    def direct_fiber_walsh(c_vecs, z_list):
        """Given (N, 43) coefficient vectors in F_2^{43}, directly evaluate g_z(u) and FWHT for all z in z_list."""
        out = {}
        c_f32 = c_vecs.astype(np.uint8)
        for z in z_list:
            gz = c_f32 @ fiber_tt43[:, z, :] & 1
            out[z] = fwht64_batch(1 - 2 * gz.astype(np.int32))
        return out
    c_s1 = span_c(P_blocks[0])
    W_s1 = direct_fiber_walsh(c_s1, [0, 63, 21, 42])
    A0, A63, A21 = (W_s1[0][:, 0], W_s1[63][:, 0], W_s1[21][:, 0])
    E0 = A0 ** 2 + A63 ** 2 + W_s1[21][:, 0] ** 2 + W_s1[42][:, 0] ** 2
    E21 = W_s1[0][:, 21] ** 2 + W_s1[63][:, 21] ** 2 + W_s1[21][:, 21] ** 2 + W_s1[42][:, 21] ** 2
    ok_1a = (E0 <= 4096) & ((4096 - E0) % 384 == 0) & (W_s1[0][:, 63] ** 2 % 384 == 256) & (E21 <= 4096) & ((4096 - E21) % 192 == 0) & ((A0 * A63 + A21 ** 2) % 3 == 0) & np.isin((A0 + A63 + 2 * A21) % 48, [16, 32]) & np.isin((A0 + A63 - 2 * A21) % 48, [16, 32])
    n_1a = int(np.sum(ok_1a))
    Eb_s1 = sum((W_s1[z] ** 2 for z in [0, 63, 21, 42]))
    ok_1b = ok_1a & np.all(Eb_s1 <= 4096, axis=1) & pass_poisson(W_s1, 'V1_63') & pass_poisson(W_s1, 'V1_21') & pass_poisson(W_s1, 'V2_21')
    c_s1 = c_s1[ok_1b]
    Eb_s1 = Eb_s1[ok_1b]
    W_s1 = {z: W_s1[z][ok_1b] for z in [0, 63, 21, 42]}
    n_1b = len(c_s1)
    print(f'Estágio 1a (Posto 12, Plancherel): {n_1a:,d} | Estágio 1b (+ Poisson V_2): {n_1b:,d}')
    assert n_1a == 712 and n_1b == 361
    dc_s2 = span_c(P_blocks[1])
    c_s2 = (c_s1[:, None, :] ^ dc_s2[None, :, :]).reshape(-1, 43)
    W_O9 = direct_fiber_walsh(c_s2, [9, 18, 36])
    W0_s2 = np.repeat(W_s1[0], 64, axis=0)
    Eb_s2 = np.repeat(Eb_s1, 64, axis=0) + sum((W_O9[z] ** 2 for z in [9, 18, 36]))
    ok_2 = np.all(Eb_s2 <= 4096, axis=1) & pass_poisson({0: W0_s2, 9: W_O9[9]}, 'V1_9')
    idx_2 = np.where(ok_2)[0]
    c_s2 = c_s2[idx_2]
    Eb_s2 = Eb_s2[idx_2]
    n_2 = len(c_s2)
    print(f'Estágio 2  (Posto 18, +O_9):       {n_2:,d}')
    assert n_2 == 20158
    dc_s3 = span_c(P_blocks[2])
    dc_s4 = span_c(P_blocks[3])
    n_3 = 0
    c_s4_list, Eb_s4_list = ([], [])
    b_pre = np.array([0, 1, 7], dtype=np.int32)
    for cs in range(0, len(c_s2), 1024):
        ce = min(cs + 1024, len(c_s2))
        c_chunk3 = (c_s2[cs:ce, None, :] ^ dc_s3[None, :, :]).reshape(-1, 43)
        Eb_chunk3 = np.repeat(Eb_s2[cs:ce], 64, axis=0)
        W27_only = direct_fiber_walsh(c_chunk3, [27])[27]
        E0_3 = Eb_chunk3[:, 0] + 3 * W27_only[:, 0] ** 2
        E63_3 = Eb_chunk3[:, 63] + 3 * W27_only[:, 63] ** 2
        E21_3 = Eb_chunk3[:, 21] + 3 * W27_only[:, 21] ** 2
        valid3 = (E0_3 <= 4096) & ((4096 - E0_3) % 384 == 0) & (E63_3 <= 4096) & ((4096 - E63_3) % 384 == 0) & (E21_3 <= 4096) & ((4096 - E21_3) % 192 == 0)
        act3 = np.where(valid3)[0]
        if len(act3) > 0:
            c_act3 = c_chunk3[act3]
            Eb_act3 = Eb_chunk3[act3]
            W_v3 = direct_fiber_walsh(c_act3, [0, 63, 21, 42, 9, 18, 36, 27, 54, 45])
            A0_a, A63_a, A21_a, A9_a, A27_a = (W_v3[0][:, 0], W_v3[63][:, 0], W_v3[21][:, 0], W_v3[9][:, 0], W_v3[27][:, 0])
            Eb_act3 = Eb_act3 + W_v3[27] ** 2 + W_v3[54] ** 2 + W_v3[45] ** 2
            E_O9 = Eb_act3[:, 9] + Eb_act3[:, 18] + Eb_act3[:, 36]
            E_O27 = Eb_act3[:, 27] + Eb_act3[:, 54] + Eb_act3[:, 45]
            ok_e3 = ((A0_a * A63_a + A21_a ** 2 + 3 * A9_a * A27_a) % 192 == 0) & np.all(Eb_act3 <= 4096, axis=1) & ((3 * 4096 - E_O9) % 192 == 0) & ((3 * 4096 - E_O27) % 192 == 0)
            c_act3 = c_act3[ok_e3]
            Eb_act3 = Eb_act3[ok_e3]
            W_v3 = {z: W_v3[z][ok_e3] for z in W_v3}
            for cname, b_sub in [('V2_27', b_pre), ('V3', b_pre), ('V2_27', np.arange(64, dtype=np.int32)), ('V1_27', np.arange(64, dtype=np.int32)), ('V2_9a', np.arange(64, dtype=np.int32)), ('V2_9b', np.arange(64, dtype=np.int32)), ('V3', np.arange(64, dtype=np.int32))]:
                if len(c_act3) > 0:
                    keep = pass_poisson(W_v3, cname, b_sub)
                    c_act3 = c_act3[keep]
                    Eb_act3 = Eb_act3[keep]
                    W_v3 = {z: W_v3[z][keep] for z in W_v3}
            n_3 += len(c_act3)
            if len(c_act3) > 0:
                c_chunk4 = (c_act3[:, None, :] ^ dc_s4[None, :, :]).reshape(-1, 43)
                Eb_chunk4 = np.repeat(Eb_act3, 8, axis=0)
                W_o7 = direct_fiber_walsh(c_chunk4, O7)
                Eb_chunk4 = Eb_chunk4 + sum((W_o7[z] ** 2 for z in O7))
                ok_e4 = np.all(Eb_chunk4 <= 4096, axis=1) & ((4096 - Eb_chunk4[:, 0]) % 384 == 0) & ((4096 - Eb_chunk4[:, 21]) % 192 == 0)
                act4 = np.where(ok_e4)[0]
                if len(act4) > 0:
                    c_act4 = c_chunk4[act4]
                    Eb_act4 = Eb_chunk4[act4]
                    W_v4 = {z: np.repeat(W_v3[z], 8, axis=0)[act4] for z in W_v3}
                    for z in O7:
                        W_v4[z] = W_o7[z][act4]
                    for cname in ['V1_7', 'V2_7a', 'V2_7b', 'V2_7c', 'V2_7d', 'V3_7a', 'V4']:
                        if len(c_act4) > 0:
                            keep = pass_poisson(W_v4, cname)
                            c_act4 = c_act4[keep]
                            Eb_act4 = Eb_act4[keep]
                            W_v4 = {z: W_v4[z][keep] for z in W_v4}
                    if len(c_act4) > 0:
                        c_s4_list.append(c_act4)
                        Eb_s4_list.append(Eb_act4)
    c_cur = np.vstack(c_s4_list)
    Eb_cur = np.vstack(Eb_s4_list)
    n_4 = len(c_cur)
    print(f'Estágio 3  (Posto 24, +O_27):      {n_3:,d}')
    print(f'Estágio 4  (Posto 27, +O_7):       {n_4:,d}')
    assert n_3 == 212296 and n_4 == 8688
    rem_specs = [(4, 1, 'V1_1', 'Estágio 5  (Posto 31, +O_1) '), (5, 11, 'V1_11', 'Estágio 6  (Posto 34, +O_11)'), (6, 13, 'V1_13', 'Estágio 7  (Posto 36, +O_13)'), (7, 31, 'V1_31', 'Estágio 8  (Posto 37, +O_31)'), (8, 3, 'V1_3', 'Estágio 9a (Posto 41, +O_3) '), (9, 5, 'V1_5', 'Estágio 9b (Posto 41, +O_5) '), (10, 15, 'V1_15', 'Estágio 9c (Posto 42, +O_15)'), (11, 23, 'V1_23', 'Estágio 9d (Posto 43, +O_23)')]
    for blk_i, z_rep, cname, label in rem_specs:
        P_blk = P_blocks[blk_i]
        k_b = len(P_blk)
        dc = span_c(P_blk) if k_b > 0 else None
        orb_z = orbit6_of(z_rep)
        next_c, next_Eb = ([], [])
        for cs in range(0, len(c_cur), 8192):
            ce = min(cs + 8192, len(c_cur))
            if k_b > 0:
                c_ch = (c_cur[cs:ce, None, :] ^ dc[None, :, :]).reshape(-1, 43)
                Eb_ch = np.repeat(Eb_cur[cs:ce], 1 << k_b, axis=0)
            else:
                c_ch = c_cur[cs:ce]
                Eb_ch = Eb_cur[cs:ce].copy()
            W_orb = direct_fiber_walsh(c_ch, orb_z)
            for z in orb_z:
                Eb_ch += W_orb[z] ** 2
            if z_rep == 23:
                valid = np.all(Eb_ch == 4096, axis=1)
            else:
                valid = np.all(Eb_ch <= 4096, axis=1) & ((4096 - Eb_ch[:, 0]) % 384 == 0) & ((4096 - Eb_ch[:, 21]) % 192 == 0)
                if z_rep in (3, 5, 15):
                    valid &= (4096 - Eb_ch[:, 63]) % 384 == 0
            act = np.where(valid)[0]
            if len(act) > 0:
                c_a = c_ch[act]
                Eb_a = Eb_ch[act]
                W0_a = direct_fiber_walsh(c_a, [0])[0]
                keep = pass_poisson({0: W0_a, z_rep: W_orb[z_rep][act]}, cname)
                if np.any(keep):
                    next_c.append(c_a[keep])
                    next_Eb.append(Eb_a[keep])
        if next_c:
            c_cur = np.vstack(next_c)
            Eb_cur = np.vstack(next_Eb)
        else:
            c_cur = np.zeros((0, 43), dtype=np.uint8)
            Eb_cur = np.zeros((0, 64), dtype=np.int32)
        expected = {1: 26496, 11: 94936, 13: 149448, 31: 106552, 3: 349680, 5: 23636, 15: 128, 23: 0}
        assert len(c_cur) == expected[z_rep]
        print(f'{label}:      {len(c_cur):,d}')
        capture_stage(z_rep, c_cur)
    assert len(c_cur) == 0
    print(f'\nSegunda implementação independente concluída em {time.time() - t0:.2f}s: TODOS OS CONTADORES IDÊNTICOS (0 sobreviventes)!')
if __name__ == '__main__':
    main()

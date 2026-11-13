"""Entrada em A_2 por células de rho, com a etapa da fibra 5 incluída.

Uso: python -I verifica_entrada_A2_celulas.py REPO_DIR [--catalogo mapas_V1.txt]

Parte do envoltório de dimensão 19. O quociente rho tem imagem de
dimensão 14 e núcleo de dimensão 5. Entre as 518 células com as
condições preliminares de suporte, a fibra 5 é passiva em todas.
Seu momento elimina 344 células e força Lambda_7 = 0 nas outras 174.
Adaptado do verificador do Opus para incluir essa etapa.

Passos conferidos:
  1. Condições de suporte que só dependem de rho, consequências de (F1)-(F3):
       |Z_[t]| = 8;  a e_t e b e_t ortogonais a RM(1,6);  |Z_[t] ∩ M| par.
     Das 16.384 imagens, 518 passam. A fibra 5 deixa 174.
  2. Em cada célula aprovada, os momentos de [2] (somas de H01+Q11 e H10+Q11 em Z_[2]) são cegos às
     19 fases e constantes na célula (são afins no código e Z_[2] é fixo; confere-se ponto base e as
     5 direções).
  3. Células com os dois momentos nulos:
       a) 30 com Lambda_1 = Lambda_2 = Lambda_4 = 0: estão em A_2, por (D);
       b) 32 com Lambda_M != 0: nelas os pares pares [2],[4],[6] ficam inteiros em N, o swap fixa os
          rótulos em Z_[t] (chi = 0, constante na célula) e a paridade do número de órbitas do swap
          com rótulo t é constante 1 na célula. Logo |g_t| = 2·(número de órbitas) ≡ 2 mod 4 e
          |P_t| = 4|g_t| ∈ {8, 24}, contra |P_t| = 16. Nenhum código dessas células é admissível.
  Conclusão: admissível em T com os dois momentos de [2] nulos => código em A_2.
Com --catalogo: os admissíveis do catálogo em T caem só nas células aprovadas, e os de valor (0,0)
são os 480 residuais.
"""
import argparse, sys
from collections import Counter
from itertools import combinations
from pathlib import Path

M64 = (1 << 64) - 1
HULL = [(2, 1), (0x05504EC, 0), (0x0D50800, 0), (0x0379000, 0), (0x01C2000, 0), (0x1000000, 0)]
def par(x): return bin(x).count("1") & 1
def rep(t): return t ^ (15 if t & 8 else 0)
def dd(z): return (z & 7) ^ (z >> 3)
def sw(z): return (z >> 3) | ((z & 7) << 3)
def zof(y, d): return y | ((y ^ d) << 3)
def comp(f):
    f00, f10, f01, f11 = f & M64, (f >> 64) & M64, (f >> 128) & M64, (f >> 192) & M64
    return f00, f00 ^ f10, f00 ^ f01, f00 ^ f10 ^ f01 ^ f11


def affine_solve(rows, n):
    piv = {}
    for v, b in rows:
        x = (v << 1) | b
        while x > 1 and (x.bit_length() - 1) in piv:
            x ^= piv[x.bit_length() - 1]
        assert x != 1
        if x > 1:
            piv[x.bit_length() - 1] = x
    for p in sorted(piv):
        for q in piv:
            if q != p and piv[q] >> p & 1:
                piv[q] ^= piv[p]
    pivs = {p - 1 for p in piv}
    part = sum(1 << (p - 1) for p, x in piv.items() if x & 1)
    ker = []
    for f in range(n):
        if f not in pivs:
            v = 1 << f
            for p, x in piv.items():
                if x >> (f + 1) & 1:
                    v |= 1 << (p - 1)
            ker.append(v)
    return part, ker


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("repo", type=Path); ap.add_argument("--catalogo", type=Path)
    a = ap.parse_args()
    sys.path.insert(0, str(a.repo.resolve()))
    from count_near_antipodal import image_and_kernel
    from dim4_support_decode import decode
    from higher_filter import xor_terms
    from line_phase_algebra import locate
    from lower_dim_phase_prepare import fibre_masks
    model, basis, labels = decode(1)
    maps, lifts = map(list, zip(*model.maps)); image = sorted(image_and_kernel(maps)[0], reverse=True)
    LAB = [labels(basis[i])[:64] for i in range(33)]
    LIFT = [xor_terms(lifts, locate(image, basis[i])) for i in range(33)]
    tailL = [x ^ y for x, y in zip(LAB[25], LAB[32])]; tailH = LIFT[25] ^ LIFT[32]
    def gen(low):
        lab = list(tailL); h = tailH
        for i in range(25):
            if low >> i & 1:
                lab = [x ^ y for x, y in zip(lab, LAB[i])]; h ^= LIFT[i]
        return lab, h
    def lam(lab, d):
        b0 = rep(lab[zof(0, d)])
        return tuple(rep(lab[zof(1 << i, d)]) ^ b0 for i in range(3))
    root, free = affine_solve(HULL, 25)
    assert len(free) == 19
    lab0, h0 = gen(root)
    rv = lambda lab: sum(rep(lab[z]) << (3 * z) for z in range(64))
    r0 = rv(lab0)
    piv = {}; rchg = []; rker = []
    for v in free:
        lab, h = gen(root ^ v)
        x, vv = rv(lab) ^ r0, v
        while x and (x.bit_length() - 1) in piv:
            px, pv = piv[x.bit_length() - 1]; x ^= px; vv ^= pv
        if x:
            piv[x.bit_length() - 1] = (x, vv); rchg.append((x, vv))
        else:
            rker.append(vv)
    assert len(rchg) == 14 and len(rker) == 5
    def in_a2(lab):
        return all(rep(lab[z]) == rep(lab[z ^ u]) for z in range(64) for u in (27, 45))
    # efeito das 5 direções da célula sobre rótulos e levantamento (afim: diferença em relação a root)
    kdir = []
    for v in rker:
        lab, h = gen(root ^ v)
        kdir.append(([x ^ y for x, y in zip(lab, lab0)], comp(h ^ h0)))
    P01 = [comp(p)[2] for p in model.phases]; P10 = [comp(p)[1] for p in model.phases]
    q11 = sum(((z >> 2 ^ z >> 5) & 1 & (1 ^ (z ^ z >> 1 ^ z >> 3 ^ z >> 4) & 1)) << z for z in range(64))
    A = {2, 4}; B = {1, 4}; M = {1, 2, 4}
    stats = Counter(); good_cells = {}
    residual_profiles = Counter()
    active_images = Counter()
    coords = [sum(1 << x for x in range(256) if x >> i & 1) for i in (6, 7)]
    for sel in range(1 << len(rchg)):
        r = r0; vv = root
        for i, (x, v) in enumerate(rchg):
            if sel >> i & 1:
                r ^= x; vv ^= v
        rho = [(r >> (3 * z)) & 7 for z in range(64)]
        Z = [[z for z in range(64) if rho[z] == t] for t in range(8)]
        if any(len(s) != 8 for s in Z):
            continue
        ok = True
        for s in Z:
            for S in (A, B):
                pts = [z for z in s if dd(z) in S]; acc = 0
                for z in pts:
                    acc ^= z
                if len(pts) % 2 or acc:
                    ok = False
            if sum(dd(z) in M for z in s) % 2:
                ok = False
        if not ok:
            continue
        stats["suporte preliminar"] += 1
        assert all(dd(z) not in M for z in Z[5])
        # The swap exchanges 5 and 10 on their part of d=7. There is one
        # occurrence of 5 per swap orbit, and Q11 vanishes away from d=7
        # on this passive pair. Thus the count below is the first moment.
        lab, h = gen(vv)
        on7 = [z for z in Z[5] if dd(z) == 7]
        assert all((lab[z] ^ lab[sw(z)]) == 15 for z in on7)
        assert all((dl[z] ^ dl[sw(z)]) == 0 for dl, _ in kdir for z in on7)
        assert comp(h)[3] == q11
        assert all(dh[3] == 0 for _, dh in kdir)
        assert all(not comp(phase)[3] for phase in model.phases)
        if (len(on7) // 2) & 1:
            stats["momento de 5 = 1"] += 1
            continue
        assert lam(lab, 7) == (0, 0, 0)
        stats["aprovadas"] += 1
        H = comp(h)
        Z2 = sum(1 << z for z in Z[2])
        vals = []
        for idx, P in ((2, P01), (1, P10)):
            assert all(not par(Z2 & f) for f in P), "cegueira"
            assert all(not par(Z2 & dh[idx]) for _, dh in kdir), "constância na célula"
            vals.append(par(Z2 & (H[idx] ^ q11)))
        lm = tuple(lam(lab, d) for d in (1, 2, 4))
        images = [{rho[zof(y, d)] for y in range(8)} for d in (1, 2, 4)]
        sizes = [len(values) for values in images]
        assert sizes in ([1, 1, 1], [2, 2, 2])
        degree = Counter(label for values in images for label in values)
        if sizes[0] == 1:
            graph = "constant slices"
        elif sorted(degree.values()) == [2, 2, 2]:
            graph = "triangle"
        else:
            assert sorted(degree.values()) == [1] * 6
            graph = "disjoint edges"
        active_images[graph, tuple(vals)] += 1
        good_cells[vv] = (tuple(vals), lm)
        if vals != [0, 0]:
            stats["momento de [2] = 1"] += 1
            continue
        if lm == ((0, 0, 0),) * 3:
            assert in_a2(lab)
            stats["(0,0) em A_2"] += 1
            # A passive fibre invariant under the half-swap has size
            # divisible by eight. Odd orbit parity excludes size 16
            # simultaneously for all five selector directions.
            z2 = Z[2]
            if (all(dd(z) not in M and sw(z) != z and sw(z) in z2 for z in z2)
                    and all(lab[z] == lab[sw(z)] for z in z2)
                    and all(dl[z] == dl[sw(z)] for dl, _ in kdir for z in z2)):
                reps = [z for z in z2 if z < sw(z)]
                if (sum(lab[z] == 2 for z in reps) & 1
                        and not any(sum(dl[z] & 1 for z in reps) & 1 for dl, _ in kdir)):
                    residual_profiles["excluded by the size of fibre 2"] += 1
                    continue

            # For this passive complementary pair, swap exchanges the
            # labels. Each swap orbit contributes one point to Z_1,
            # regardless of which selector is chosen in the cell.
            z1 = Z[1]
            assert all(dd(z) in (3, 5, 6) and sw(z) in z1 for z in z1)
            assert all(lab[z] ^ lab[sw(z)] == 15 for z in z1)
            assert all(dl[z] == dl[sw(z)] for dl, _ in kdir for z in z1)
            profile = tuple(sorted(dd(z) for z in z1 if z < sw(z)))
            if len(set(profile)) == 1:
                assert profile[0] in (3, 5, 6)
                assert all(rep(lab[zof(y, d)]) == rep(lab[zof(0, d)])
                           for d in range(8) for y in range(8))
                residual_profiles["one slice in A_rho"] += 1
            else:
                assert profile == (3, 3, 5, 5)
                residual_profiles["two half-slices"] += 1

            # Verify the local phase obstruction independently at the
            # level of affine coefficients in this entire selector cell.
            coord = coords[0 if len(set(profile)) == 1 else 1]
            fibre = fibre_masks(xor_terms(basis, vv | (129 << 25)), 256, 4)[1]
            assert (fibre & coord).bit_count() == 8
            for delta in [0, *rker, *(u ^ v for u, v in combinations(rker, 2))]:
                code = (vv ^ delta) | (129 << 25)
                shifted_fibre = fibre_masks(xor_terms(basis, code), 256, 4)[1]
                _, lifted = gen(vv ^ delta)
                assert (shifted_fibre & coord).bit_count() == 8
                assert not any(par(shifted_fibre & coord & phase) for phase in model.phases)
                assert par(shifted_fibre & coord & lifted)
            continue
        # família b): certificado de tamanho por um par par inteiro em N
        found = False
        for t in (2, 4, 6):
            s = Z[t]
            if any(dd(z) in M for z in s):
                continue
            if any((lab[z] ^ lab[sw(z)]) for z in s) or any((dl[z] ^ dl[sw(z)]) for dl, _ in kdir for z in s):
                continue          # chi = 0 em Z_[t], constante na célula
            reps_ = [z for z in s if z <= sw(z)]
            assert all(sw(z) != z for z in s)
            base = sum(lab[z] == t for z in reps_) & 1
            const = all(not (sum(dl[z] & 1 for z in reps_) & 1) for dl, _ in kdir)
            if base == 1 and const:
                found = True; break
        assert found, "célula (0,0) fora de A_2 sem certificado de tamanho"
        stats["(0,0) fora de A_2, excluída por |P_t| = 8 ou 24"] += 1
    print(dict(stats))
    assert stats["suporte preliminar"] == 518 and stats["momento de 5 = 1"] == 344
    assert stats["aprovadas"] == 174 and stats["(0,0) em A_2"] == 30
    assert stats["(0,0) fora de A_2, excluída por |P_t| = 8 ou 24"] == 32
    assert residual_profiles == {"excluded by the size of fibre 2": 15,
                                 "one slice in A_rho": 9, "two half-slices": 6}
    print(dict(residual_profiles))
    print("Active images and paired moments:", dict(sorted(active_images.items())))
    if a.catalogo:
        cat = [int(l) for l in a.catalogo.read_text().split() if int(l) >> 25 == 129]
        hit = Counter()
        lam7 = lambda lab: lam(lab, 7)
        for code in cat:
            mp = xor_terms(basis, code); lab = labels(mp)[:64]
            if lam7(lab) != (0, 0, 0):
                continue
            low = code & ((1 << 25) - 1)
            # localizar a célula: rho determina a célula; procure pelo rho
            key = sum(rep(lab[z]) << (3 * z) for z in range(64))
            hit[key] += 1
        cells_by_rho = {}
        for vv, (vals, lm) in good_cells.items():
            cells_by_rho[rv(gen(vv)[0])] = (vals, lm)
        assert set(hit) <= set(cells_by_rho), "admissível fora das células aprovadas"
        n00 = sum(n for k, n in hit.items() if cells_by_rho[k][0] == (0, 0))
        print("catálogo em T:", sum(hit.values()), "; em células (0,0):", n00)
        assert sum(hit.values()) == 2784 and n00 == 480
    print("OK")


if __name__ == "__main__":
    main()

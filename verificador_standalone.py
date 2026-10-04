#!/usr/bin/env python3
"""
Verificador Standalone Endurecido - Conjectura de Stanica-Maitra para HRSBF Cubicas (n != 0 mod 32).
Implementacao 100% em Biblioteca Padrao de Python (ZERO dependencias externas).
Resistente a 'python -O' (utiliza excecoes explicitas em vez de asserts).

Conteudo Auditado:
  1. Teorema de Ward em t=16:
     - Prova Principal: 42 geradoras (35 cubicas + 7 quadraticas, 124.313 condicoes).
       Justificativa: Somar a forma linear L preserva bentness (W_{f + L}(u) = W_f(u + 1)).
     - Conferencia Suplementar: 43 geradoras (com L, 136.697 condicoes).
     - Hashes criptograficos SHA-256 independentes das tabelas de 42 e 43 geradoras.
  2. Matriz de Transferencia Exata: validacao n=3..10 e contraexemplo t=32 (resto 512 mod 2048, v_2(wt)=14).
  3. Bases Reduzidas t=2, 4, 8: ausencia exaustiva de valores bent.
  4. Cancelamento Antipodal Estendido (Lema 2.3): m=1,3,5,7,9,15 para t<=8 (q_{t/2} nunca aparece).
     Sanity check quadratico real via fold_anf (q_{t/2} sobrevive com coeficiente 1 mod 2).
  5. Controles Obrigatorios de Integridade:
     - Controle 1: Contraexemplo bent cubica NAO-HOMOGENEA em n=12 (demonstra que homogeneidade e essencial).
     - Controle 2: Fibra t=32 com termo linear (orbita (0,1,16) -> u_15, soma=0, certificando contra falso descarte).

Requisitos: Python >= 3.10 (usa int.bit_count).
Uso: python verificador_standalone.py
"""
import itertools, math, hashlib, time, collections

def banner(s):
    print("\n" + "=" * 78 + "\n" + s + "\n" + "=" * 78)

# ==============================================================================
# 1. TEOREMA DE WARD EM t=16: 42 GERADORAS (PRINCIPAL) E 43 (SUPLEMENTAR)
# ==============================================================================
def test_ward_t16():
    banner("[1] Teorema de Ward em t=16: 42 Geradoras (Principal) e 43 (Suplementar)")
    t0 = time.time()
    t = 16
    N = 1 << t

    # 1.1 Identificar os 4.080 representantes das orbitas completas de F_2^16 \ V_8
    reps = []
    seen = bytearray(N)
    for x in range(N):
        if seen[x]:
            continue
        cur = x
        orb = []
        for s in range(16):
            if not seen[cur]:
                seen[cur] = 1
                orb.append(cur)
            cur = ((cur >> 1) | ((cur & 1) << 15))
        shift8 = ((x >> 8) | ((x & 0xFF) << 8))
        if len(orb) == 16 and shift8 != x:
            reps.append(min(orb))
    reps.sort()

    if len(reps) != 4080:
        raise RuntimeError(f"ERRO: Esperado 4080 representantes, obtido {len(reps)}")

    reps_bytes = b"".join(r.to_bytes(2, "little") for r in reps)
    sha_reps = hashlib.sha256(reps_bytes).hexdigest()
    print(f"  Orbitas completas em F_2^16 \\ V_8: {len(reps)} representantes.")
    print(f"  SHA-256 (4.080 representantes binarios): {sha_reps}")

    # 1.2 Gerar as 35 orbitas cubicas canonicas via lacunas (g1, g2, g3)
    comps = sorted({min(g[i:] + g[:i] for i in range(3)) 
                    for g in itertools.product(range(1, t), repeat=3) if sum(g) == t})
    if len(comps) != 35:
        raise RuntimeError(f"ERRO: Esperado 35 composicoes ciclicas, obtido {len(comps)}")

    cub_monos = []
    for g1, g2, g3 in comps:
        m = (0, g1, g1 + g2)
        orb = {tuple(sorted((i + s) % t for i in m)) for s in range(t)}
        cub_monos.append(sorted(orb))

    # 1.3 Gerar as 7 orbitas quadraticas completas d=1..7
    quad_monos = []
    for d in range(1, 8):
        orb = {tuple(sorted((i, (i + d) % t))) for i in range(t)}
        if len(orb) != 16:
            raise RuntimeError(f"ERRO: Orbita quadratica d={d} nao tem comprimento 16")
        quad_monos.append(sorted(orb))

    # 1.4 Gerar a forma linear L
    L_monos = [[(i,) for i in range(t)]]

    # As 42 geradoras de grau >= 2 (35 cubicas + 7 quadraticas)
    gens_42 = cub_monos + quad_monos
    # As 43 geradoras com L
    all_gens_43 = gens_42 + L_monos

    # Converter geradoras em palavras binarias de 4.080 bits
    words_43 = []
    for gen in all_gens_43:
        word = 0
        for k, r in enumerate(reps):
            val = 0
            for mon in gen:
                mask = sum(1 << idx for idx in mon)
                if (r & mask) == mask:
                    val ^= 1
            if val:
                word |= (1 << k)
        words_43.append(word)

    words_42 = words_43[:42]

    sha_42 = hashlib.sha256(b"".join(w.to_bytes(510, "little") for w in words_42)).hexdigest()
    sha_43 = hashlib.sha256(b"".join(w.to_bytes(510, "little") for w in words_43)).hexdigest()
    print(f"  SHA-256 (42 geradoras grau >= 2): {sha_42}")
    print(f"  SHA-256 (43 geradoras com L):     {sha_43}")

    # 1.5 PROVA PRINCIPAL: 42 Geradoras (124.313 condicoes)
    # Lema de Invariancia por Translacao Linear: W_{f + L}(u) = W_f(u + 1) preserva
    # o modulo |W(u)|. Logo f + L e bent sse f e bent. Basta auditar as 42 geradoras!
    f1_42 = sum(w.bit_count() % 16 != 0 for w in words_42)
    f2_42 = sum((words_42[i] & words_42[j]).bit_count() % 8 != 0 
                for i in range(42) for j in range(i + 1, 42))
    f3_42 = 0
    f4_42 = 0
    for i in range(42):
        wi = words_42[i]
        for j in range(i + 1, 42):
            wij = wi & words_42[j]
            for l in range(j + 1, 42):
                wijl = wij & words_42[l]
                if wijl.bit_count() % 4 != 0:
                    f3_42 += 1
                for p in range(l + 1, 42):
                    if (wijl & words_42[p]).bit_count() % 2 != 0:
                        f4_42 += 1

    total_subsets_42 = 42 + 861 + 11480 + 111930
    if f1_42 != 0 or f2_42 != 0 or f3_42 != 0 or f4_42 != 0:
        raise RuntimeError("ERRO: Violacao detectada na Prova Principal (42 geradoras)!")

    print(f"\n  [PROVA PRINCIPAL] 42 Geradoras (35 cubicas + 7 quadraticas):")
    print(f"  - Subconjuntos auditados: {total_subsets_42} (42 + 861 + 11.480 + 111.930)")
    print(f"  - Falhas registradas: 0 falhas em todas as 4 ordens de polarizacao de Ward.")
    print(f"  => Conclusao Principal: wt(c) = 0 mod 16 para todas as 2^42 funcoes.")
    print(f"  => W_g(0) = 0 mod 512 != +-256 => ZERO FUNCOES BENT no espaco de 42 geradoras.")
    print(f"  => Por invariancia linear (W_{{f+L}}(u) = W_f(u+1)), ZERO FUNCOES BENT com L.")

    # 1.6 CONFERENCIA SUPLEMENTAR: 43 Geradoras (136.697 condicoes)
    # Audita os subconjuntos adicionais contendo L
    f1_43 = f1_42 + (words_43[42].bit_count() % 16 != 0)
    f2_43 = f2_42 + sum((words_43[i] & words_43[42]).bit_count() % 8 != 0 for i in range(42))
    f3_43 = f3_42
    f4_43 = f4_42
    w_L = words_43[42]
    for i in range(42):
        wi = words_43[i]
        for j in range(i + 1, 42):
            wij = wi & words_43[j]
            if (wij & w_L).bit_count() % 4 != 0:
                f3_43 += 1
            for l in range(j + 1, 42):
                wijl = wij & words_43[l]
                if (wijl & w_L).bit_count() % 2 != 0:
                    f4_43 += 1

    total_subsets_43 = 43 + 903 + 12341 + 123410
    if f1_43 != 0 or f2_43 != 0 or f3_43 != 0 or f4_43 != 0:
        raise RuntimeError("ERRO: Violacao detectada na Conferencia Suplementar (43 geradoras)!")

    print(f"\n  [CONFERENCIA SUPLEMENTAR] 43 Geradoras (incluindo L):")
    print(f"  - Subconjuntos auditados: {total_subsets_43} ({total_subsets_42} + 12.384 envolvendo L)")
    print(f"  - Falhas registradas: 0 falhas em todas as 136.697 condicoes.")
    print(f"  - Tempo total Ward: {time.time()-t0:.2f} s")

# ==============================================================================
# 2. MATRIZ DE TRANSFERENCIA EXATA E COLAPSO 2-ADICO EM t=32
# ==============================================================================
def test_transfer_matrix():
    banner("[2] Matriz de Transferencia Exata e Limite 2-Adico em t=32")
    states = list(itertools.product(range(2), repeat=2))
    matrix = [[0] * 4 for _ in states]
    for i, (a, b) in enumerate(states):
        for j, (b2, c) in enumerate(states):
            if b == b2:
                matrix[i][j] = (-1) ** (a * b * c)

    def multiply(a, b):
        return [[sum(a[i][k] * b[k][j] for k in range(4)) for j in range(4)] for i in range(4)]

    def power(m, p):
        res = [[int(i == j) for j in range(4)] for i in range(4)]
        base = [row[:] for row in m]
        while p > 0:
            if p & 1:
                res = multiply(res, base)
            base = multiply(base, base)
            p >>= 1
        return res

    for n in range(3, 11):
        tr = sum(power(matrix, n)[i][i] for i in range(4))
        direct = sum((-1) ** (sum(((x >> i) & 1) * ((x >> ((i + 1) % n)) & 1) * ((x >> ((i + 2) % n)) & 1) 
                                  for i in range(n)) % 2) for x in range(1 << n))
        if tr != direct:
            raise RuntimeError(f"ERRO: Inconsistencia em n={n}: tr={tr}, direct={direct}")

    print("  Conferencia exata: matriz de transferencia validada contra somas exaustivas em n=3..10.")

    t = 32
    M32 = power(matrix, t)
    W_H_0 = sum(M32[i][i] for i in range(4))
    wt_H = (1 << (t - 1)) - (W_H_0 >> 1)
    v2_wt = (wt_H & -wt_H).bit_length() - 1

    rem = (wt_H // 32) % 2048
    print(f"  Dimensao t=32: W_H(0) = {W_H_0}, wt(H) = {wt_H}")
    print(f"  Valoracao 2-adica v_2(wt(H)) = {v2_wt} (alvo bent exigiria >= 15)")
    print(f"  wt(H)/32 = {wt_H // 32} = {rem} (mod 2048) -> resto: {rem}")
    if rem == 0 or v2_wt >= 15:
        raise RuntimeError("ERRO: Condicao de falha de Ward em t=32 nao reproduzida!")
    print("  => Confirmado: A divisibilidade universal por 2048 falha em t=32 (resto 512 != 0).")

# ==============================================================================
# 3. ESPACOS REDUZIDOS t=2, 4, 8: AUSENCIA EXAUSTIVA DE VALORES BENT
# ==============================================================================
def test_small_bases():
    banner("[3] Espacos Reduzidos t=2, 4, 8: Ausencia de Bent")
    for t in (2, 4, 8):
        gens = []
        for mon in itertools.combinations(range(t), 3):
            orb = tuple(sorted({tuple(sorted((i + s) % t for i in mon)) for s in range(t)}))
            if orb not in gens:
                gens.append(orb)
        for d in range(1, t // 2):
            orb = tuple(sorted({tuple(sorted((i, (i + d) % t))) for i in range(t)}))
            if orb not in gens:
                gens.append(orb)
        L_orb = tuple(sorted([(i,) for i in range(t)]))
        gens.append(L_orb)

        k = len(gens)
        N = 1 << t
        tts = []
        for g in gens:
            val = 0
            for x in range(N):
                b = 0
                for mon in g:
                    mask = sum(1 << idx for idx in mon)
                    if (x & mask) == mask:
                        b ^= 1
                if b:
                    val |= (1 << x)
            tts.append(val)

        vals = set()
        for mask in range(1 << k):
            comb = 0
            for i in range(k):
                if (mask >> i) & 1:
                    comb ^= tts[i]
            w = comb.bit_count()
            W0 = N - 2 * w
            vals.add(W0)

        target = 1 << (t // 2)
        has_target = (target in vals) or (-target in vals)
        print(f"  t={t}: {k:2d} geradoras, 2^{k} funcoes, W(0) in {sorted(vals)[:5]}...; alvo bent +- {target} ausente: {not has_target}")
        if has_target:
            raise RuntimeError(f"ERRO: Funcao bent encontrada indevidamente em t={t}")
        if t == 8 and any(v % 32 != 0 for v in vals):
            raise RuntimeError("ERRO: Valores de W(0) em t=8 deveriam ser todos multiplos de 32")

# ==============================================================================
# 4. CANCELAMENTO DE PARIDADE ESTENDIDO (m=1..15) E SANITY CHECK QUADRATICO
# ==============================================================================
def test_parity_extended():
    banner("[4] Cancelamento Antipodal Estendido (m=1..15) e Sanity Check")
    def fold_anf(mon, n, t):
        par = collections.defaultdict(int); seen = set()
        for s in range(n):
            key = tuple(sorted((i + s) % n for i in mon))
            if key in seen: continue
            seen.add(key); par[frozenset(i % t for i in key)] ^= 1
        return {m for m, p in par.items() if p}

    for t in (2, 4, 8):
        for m in (1, 3, 5, 7, 9, 15):
            n = t * m; seen = set(); q_half_appeared = False
            for mon in itertools.combinations(range(n), 3):
                if mon in seen: continue
                seen |= {tuple(sorted((i + s) % n for i in mon)) for s in range(n)}
                S = fold_anf(mon, n, t)
                for a in S:
                    if len(a) == 2:
                        x, y = sorted(a)
                        if 2 * min((y - x) % t, (x - y) % t) == t:
                            q_half_appeared = True
            if q_half_appeared:
                raise RuntimeError(f"ERRO: q_{{t/2}} apareceu indevidamente para t={t}, m={m}")
    print("  Cubicas (m=1,3,5,7,9,15 para t<=8): q_{t/2} NUNCA aparece (multiplicidade par).")

    print("  Sanity check real em quadraticas via fold_anf: q_{t/2} sobrevive com coeficiente 1 (mod 2):")
    for t in (2, 4, 8, 16):
        for m in (1, 3, 5, 7, 9, 15):
            n = t * m
            S_quad = fold_anf((0, n // 2), n, t)
            antipodal_pairs = {frozenset({j, (j + t // 2) % t}) for j in range(t)}
            if not antipodal_pairs.issubset(S_quad):
                raise RuntimeError(f"ERRO: q_{{t/2}} nao sobreviveu para quadratica em t={t}, m={m}")
    print("  => Realizado via fold_anf: quadratica preserva q_{t/2} (coeficiente 1 mod 2); cubica cancela q_{t/2} identicamente (coeficiente 0 mod 2).")

# ==============================================================================
# 5. CONTROLES OBRIGATORIOS DE INTEGRIDADE E NAO-TAUTOLOGIA
# ==============================================================================
def test_mandatory_controls():
    banner("[5] Controles Obrigatorios de Integridade e Nao-Tautologia")
    
    # Controle 1: Contraexemplo Bent Cubica NAO-HOMOGENEA em n=12
    # f(x) = sum x_i*x_{i+2}*x_{i+6} + sum x_i*x_{i+1} + sum_{i<6} x_i*x_{i+6}
    n12 = 12
    N12 = 1 << n12
    c12 = {tuple(sorted((j + s) % n12 for j in (0, 2, 6))) for s in range(n12)}
    q12 = {tuple(sorted((j + s) % n12 for j in (0, 1))) for s in range(n12)}
    a12 = {(i, i + 6) for i in range(6)}
    all_m12 = c12 | q12 | a12
    masks12 = [sum(1 << j for j in m) for m in all_m12]
    truth12 = [sum((x & m) == m for m in masks12) % 2 for x in range(N12)]
    
    w12 = [1 - 2 * v for v in truth12]
    h = 1
    while h < N12:
        for start in range(0, N12, 2 * h):
            for j in range(start, start + h):
                x_val, y_val = w12[j], w12[j + h]
                w12[j], w12[j + h] = x_val + y_val, x_val - y_val
        h *= 2
        
    is_bent_12 = all(abs(v) == 64 for v in w12)
    if not is_bent_12:
        raise RuntimeError("CONTROLE 1 FALHOU: Contraexemplo n=12 deveria ser bent!")
    print(f"  Controle 1 [n=12 nao-homogeneo]: Bent confirmada em todas as 4.096 frequencias (|W|=64).")
    print(f"  => Certifica que o verificador detecta bent e que a HOMOGENEIDADE e indispensavel.")

    # Controle 2: Fibra de t=32 que perdeu termo linear (orbita (0, 1, 16))
    # Para x = (u, u ^ e_0), a orbita canonica (0, 1, 16) restringe-se a u_15 (termo linear puro)
    t32 = 32
    orb_16 = {tuple(sorted((i + s) % t32 for i in (0, 1, 16))) for s in range(t32)}
    anf_fiber = collections.defaultdict(int)
    for m in orb_16:
        factors = []
        for r in m:
            if r < 16:
                factors.append({frozenset([r]): 1})
            elif r == 16:
                factors.append({frozenset([0]): 1, frozenset(): 1})
            else:
                factors.append({frozenset([r - 16]): 1})
        prod = {frozenset(): 1}
        for f in factors:
            new_prod = collections.defaultdict(int)
            for k1, v1 in prod.items():
                for k2, v2 in f.items():
                    new_prod[k1 | k2] ^= (v1 & v2)
            prod = new_prod
        for k, v in prod.items():
            if v:
                anf_fiber[k] ^= 1

    active_fiber_terms = {k for k, v in anf_fiber.items() if v}
    if active_fiber_terms != {frozenset([15])}:
        raise RuntimeError(f"CONTROLE 2 FALHOU: Restricao deveria ser {{u_15}}, obtido {active_fiber_terms}")

    print(f"  Controle 2 [t=32 fibra afim]: Orbita (0, 1, 16) restringe-se exatamente a u_15 (termo linear).")
    print(f"  => Soma de caracteres e zero (balanceada), certificando contra falsos descartes no filtro de Poisson.")

# ==============================================================================
# EXECUCAO PRINCIPAL
# ==============================================================================
if __name__ == "__main__":
    t_start = time.time()
    banner("VERIFICADOR STANDALONE ENDURECIDO (PYTHON >= 3.10 BIBLIOTECA PADRAO)")
    test_ward_t16()
    test_transfer_matrix()
    test_small_bases()
    test_parity_extended()
    test_mandatory_controls()
    t_total = time.time() - t_start
    banner(f"TUDO VERIFICADO COM SUCESSO EM {t_total:.2f} SEGUNDOS.\n"
           "Zero falhas na Prova Principal (124.313 condicoes), na Conferencia (136.697 condicoes)\n"
           "e nos Controles Obrigatorios de Integridade.")

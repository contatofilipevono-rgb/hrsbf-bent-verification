#!/usr/bin/env python3
"""
Verificador Standalone Endurecido - Conjectura de Stanica-Maitra para HRSBF Cubicas (n != 0 mod 32).
Implementacao 100% em Biblioteca Padrao de Python (ZERO dependencias externas).
Resistente a 'python -O' (utiliza excecoes explicitas em vez de asserts).

Conteudo Auditado:
  1. Teorema de Ward em t=16: 43 geradoras (35 cubicas + 7 quadraticas + L).
     Audita 136.697 subconjuntos em inteiros de 4080 bits.
     Exibe hashes criptograficos SHA-256 dos representantes e das tabelas de verdade.
  2. Matriz de Transferencia Exata: validacao n=3..10 e contraexemplo t=32 (resto 512 mod 2048, v_2(wt)=14).
  3. Bases Reduzidas t=2, 4, 8 com Forma Linear L: ausencia exaustiva de valores bent.
  4. Cancelamento Antipodal Estendido (Lema 2.3): m=1,3,5,7,9,15 para t<=8 (q_{t/2} nunca aparece).
  5. Teste de Consistencia da Quadratica Bent: multiplicidade m (impar) preserva q_{t/2}.

Requisitos: Python >= 3.10 (usa int.bit_count).
Uso: python verificador_standalone.py
"""
import itertools, math, hashlib, time

def banner(s):
    print("\n" + "=" * 78 + "\n" + s + "\n" + "=" * 78)

# ==============================================================================
# 1. TEOREMA DE WARD EM t=16 COM HASHES CRIPTOGRAFICOS (ZERO DEPENDENCIAS)
# ==============================================================================
def test_ward_t16():
    banner("[1] Teorema de Ward em t=16: 43 geradoras (35 cubicas + 7 quadraticas + L)")
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

    all_gens = cub_monos + quad_monos + L_monos
    if len(all_gens) != 43:
        raise RuntimeError(f"ERRO: Esperado 43 geradoras, obtido {len(all_gens)}")

    # 1.5 Converter cada geradora em uma palavra-codigo binaria de 4.080 bits
    words = []
    for gen in all_gens:
        word = 0
        for k, r in enumerate(reps):
            val = 0
            for mon in gen:
                mask = sum(1 << idx for idx in mon)
                if (r & mask) == mask:
                    val ^= 1
            if val:
                word |= (1 << k)
        words.append(word)

    words_bytes = b"".join(w.to_bytes(510, "little") for w in words)
    sha_words = hashlib.sha256(words_bytes).hexdigest()
    print(f"  SHA-256 (Tabelas de avaliacao das 43 geradoras): {sha_words}")

    # 1.6 Auditar as congruencias de Ward de ordens 1 a 4
    # Ordem 1: 43 testes (wt mod 16 == 0)
    w_rem16 = [w.bit_count() % 16 for w in words]
    f1 = sum(r != 0 for r in w_rem16)

    # Ordem 2: 903 testes (wt mod 8 == 0)
    f2 = sum((words[i] & words[j]).bit_count() % 8 != 0 
             for i in range(43) for j in range(i + 1, 43))

    # Ordem 3: 12.341 testes (wt mod 4 == 0)
    # Ordem 4: 123.410 testes (wt mod 2 == 0)
    f3 = 0
    f4 = 0
    for i in range(43):
        wi = words[i]
        for j in range(i + 1, 43):
            wij = wi & words[j]
            for l in range(j + 1, 43):
                wijl = wij & words[l]
                if wijl.bit_count() % 4 != 0:
                    f3 += 1
                for p in range(l + 1, 43):
                    if (wijl & words[p]).bit_count() % 2 != 0:
                        f4 += 1

    total_subsets = 43 + 903 + 12341 + 123410
    print(f"  Subconjuntos auditados: {total_subsets} (43 + 903 + 12.341 + 123.410)")
    print(f"  Falhas registradas: Ordem 1={f1}, Ordem 2={f2}, Ordem 3={f3}, Ordem 4={f4}")
    if f1 != 0 or f2 != 0 or f3 != 0 or f4 != 0:
        raise RuntimeError("ERRO: Violacao detectada na congruencia de polarizacao de Ward!")

    print(f"  => Conclusao: wt(c) = 0 (mod 16) para todas as 2^43 funcoes. Tempo: {time.time()-t0:.2f}s")

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

    def trace_power(n):
        p = [[int(i == j) for j in range(4)] for i in range(4)]
        for _ in range(n):
            p = multiply(p, matrix)
        return sum(p[i][i] for i in range(4))

    # Validar contra soma direta para n=3..10
    for n in range(3, 11):
        direct = sum((-1) ** sum(x[i] * x[(i + 1) % n] * x[(i + 2) % n] for i in range(n)) 
                     for x in itertools.product(range(2), repeat=n))
        if direct != trace_power(n):
            raise RuntimeError(f"ERRO: Discrepancia na matriz de transferencia em n={n}")
    print("  Conferencia exata: matriz de transferencia validada contra somas exaustivas em n=3..10.")

    # Caso t=32: orbita elementar H(x) = sum x_i x_{i+1} x_{i+2}
    walsh32 = trace_power(32)
    weight32 = ((1 << 32) - walsh32) // 2
    orbit_weight = weight32 // 32
    rem2048 = orbit_weight % 2048

    # Calculo da valoracao 2-adica exata de wt(H)
    v2_wt = (weight32 & -weight32).bit_length() - 1

    print(f"  Dimensao t=32: W_H(0) = {walsh32}, wt(H) = {weight32}")
    print(f"  Valoracao 2-adica v_2(wt(H)) = {v2_wt} (alvo bent exigiria >= 15)")
    print(f"  wt(H)/32 = {orbit_weight} = 512 (mod 2048) -> resto: {rem2048}")
    if walsh32 != 85032960 or weight32 != 2104967168 or rem2048 != 512:
        raise RuntimeError("ERRO: Discrepancia no calculo da matriz de transferencia em t=32")
    if v2_wt >= 15:
        raise RuntimeError("ERRO: Valoracao 2-adica deveria ser estritamente menor que 15")
    print("  => Confirmado: A divisibilidade universal por 2048 falha em t=32 (resto 512 != 0).")

# ==============================================================================
# 3. BASES REDUZIDAS t=2, 4, 8 COM A FORMA LINEAR L
# ==============================================================================
def test_small_bases():
    banner("[3] Espacos Reduzidos t=2, 4, 8 com Forma Linear L: Ausencia de Bent")
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
        import collections
        par = collections.defaultdict(int); seen = set()
        for s in range(n):
            key = tuple(sorted((i + s) % n for i in mon))
            if key in seen: continue
            seen.add(key); par[frozenset(i % t for i in key)] ^= 1
        return {m for m, p in par.items() if p}

    # Testar para m impares estendidos (incluindo compostos 9 e 15) em t=2, 4, 8
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

    # Sanity check real via fold_anf: quadratica bent antipodal f = sum x_i x_{i+n/2}
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
# EXECUCAO PRINCIPAL
# ==============================================================================
if __name__ == "__main__":
    t_start = time.time()
    banner("VERIFICADOR STANDALONE ENDURECIDO (PYTHON >= 3.10 BIBLIOTECA PADRAO)")
    test_ward_t16()
    test_transfer_matrix()
    test_small_bases()
    test_parity_extended()
    banner(f"TUDO VERIFICADO COM SUCESSO EM {time.time()-t_start:.2f} SEGUNDOS.\n"
           "Zero falhas, zero violacoes em todas as 136.697 condicoes e testes estendidos.")

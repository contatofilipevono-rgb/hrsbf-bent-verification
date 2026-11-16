# H12, casos B e C: resposta à missão do Fable

Data: 15/11/2026. Resposta a `PROMPT_OPUS_H12_CASOS_BC.md`. Notação do prompt: f = Σ t_j O_j, modelo f = h(z) + λ(z)·w + Σ B_ij(z) w_i w_j, as 21 coordenadas da polar (u₃₀, u₄₀, u₄₂, a, …, B3), e

- α = p + A2 + B1 + B2 e β = r + A1 + A3 + B2 + B3 (Lema 3 do Fable);
- Y = a + d + h + m;
- chave da linha e₀: x₁ = a+d, x₂ = a+h, y₁ = b+e, y₂ = b+n, w₁ = c+g, w₂ = c+k.

Testes dos lemas novos: `python teste_lemas_bc.py` (precisa de numpy e de `bc_comum.py`). As contagens desta nota são reproduzidas pelos scripts listados no fim.

## Resumo
**Provado à mão (novo):**
- **Lema 5.** (Pf4) já contém o Lema 1. No caso B, (Pf4) dá Y = α + β.
- **Lema 6.** N₆₃ ≡ (u₃₀+u₄₀+u₄₂) + α + β + (1+u₄₂)·Y (mod 2), por pontos fixos da rotação.
- **Corolário.** Com a paridade e o nível 10 simétrico do Fable (Y = 0 em B), vale **α = β** nos casos B e C.
- **Lema 7.** O caso C com α = β = 0 é impossível pela coluna 0.
- **Lema 8.** O teste das 8 linhas é uma tabela de 256 entradas por caso: depende só de (α, β) e da chave da linha e₀.

**Conferido por computador, sem prova à mão ainda:**
- os conjuntos (Pf4) de cada subcaso;
- o que as 8 linhas e a paridade cortam deles;
- a morte dos sobreviventes por (L5)+(L3).

**Continua aberto à mão:**
- a classificação de (Pf4) dentro de cada subcaso (25 quádricas em ≤ 16 variáveis);
- os 94 polares de B com α = β = 1.

### Funil por subcaso
Polares homogêneos de (Pf4), separados pelo caso e por (α, β):

| Subcaso | (Pf4) | + 8 linhas | + 8 linhas + paridade | Quem fecha |
|---|---:|---:|---:|---|
| B, (α,β) = (0,1) ou (1,0) | 188 | 172 | 0 | Lema 6 + nível 10 (à mão) |
| C, (0,1) ou (1,0) | 112 | 88 | 0 | Lema 6 (à mão) |
| C, (0,0) | 40 | 0 | 0 | Lema 7 (à mão) |
| B, (0,0) | 164 | 2 | 0 | ver §4 |
| C, (1,1) | 40 | 32 | 4 | plano afim; ver §4 |
| B, (1,1) | 152 | 94 | 94 | (L5)+(L3), um polar de cada vez; ver §4 |

O caso A tem 480 polares em (Pf4), e as 8 linhas matam todos (é o Lema 4 do Fable).

## 1. Dados pedidos no prompt
**Filtros do repositório nos 432 polares do nível 8** (tabela completa: `polares_nivel8_filtros.tsv`):

| Caso | Polares | Morrem nas 8 linhas | Paridade | (L5)+(L3) | mod 4/resíduo | Estão entre os 98 |
|---|---:|---:|---:|---:|---:|---:|
| A | 196 | 196 | 0 | 0 | 0 | 0 |
| B | 100 | 43 | 48 | 6 | 3 | 9 |
| C | 136 | 64 | 68 | 4 | 0 | 4 |

- **Os 98** (8 linhas + paridade + (Pf4)): 94 são do caso B e 4 do caso C; nenhum é do caso A. Só 9 dos 94 de B são polares do nível 8. Os 4 de C são todos polares do nível 8.
- **Interseção dos 35 polares pós-nível 9 com os 98:** um único polar, caso B, `110111011110101010000`, com 12 funções. Ele morre nos níveis mod 4 de S_d.
  - Dos 6 polares de B pós-nível 9: 3 morrem nas 8 linhas, 2 na paridade e 1 é esse.
  - Dos 29 de C: 27 morrem nas 8 linhas e 2 na paridade.
- **Frente 4 (uma linha por polar):** `certificado_35.tsv` dá, para cada um dos 35 polares, a coluna b e a soma > 4.096 nas 8 linhas, ou a direção d com N_d ímpar. No caso C, quase sempre é a coluna 0: a linha 0 dá |32| e as linhas e_i têm posto ≤ 2 (|r| = 32 ou 64).
- **Relações lineares do nível 8 (frente 2):** todas as que o Fable listou são formas **só da polar**.
  - Em B: Y, e as duas outras valem a + h + A1 + A3 + B1 + B2 (uma delas a menos de L₄₅₆). Essa forma se anula em todo (Pf4) de B com α = β.
  - Em C: a envoltória afim de (Pf4) no caso C tem exatamente 5 relações, todas válidas nas soluções do nível 8. Como o Fable achou 5 relações (envoltória de dimensão 33 de 38), os dois espaços coincidem. A mais curta, b + g + A1 + A3, é a soma de duas delas.
  - Ou seja, saem de (Pf4) (e, em B, de α = β), não do nível 8 em si.
  - O span de grau 3 das 25 quádricas de (Pf4), em cada subcaso, só dá uma forma linear (`pf4_xl.py`), como o Fable achou para o nível 8. As outras pedem divisão em casos.
- **Relações do modelo L₄₅₆ e L₄₆₄:**
  - Elas são os coeficientes dos monômios quárticos em (z,w) com pelo menos três coordenadas w, e estão no span de {Q_S, t_j Q_S} (`verifica_relacoes_universais.py`).
  - Pelo Lema 1 do Fable, elas aparecem também nas Q_S dos 8-conjuntos invariantes por σ:
    - Q_{0123 6789} = L₄₅₆ + t₃₀ + t₄₀ + t₃₀t₄₂;
    - Q_{0124 6 7 8 10} = L₄₆₄ + t₄₀t₄₂.
  - O Lema 5 mostra que, dentro do modelo, o resto dessas Q_S é exatamente uma quádrica de (Pf4) com V = J.
- **Artigo antipodal (grau ≤ 3):**
  - Enunciado, tal como registrado nas notas (o .tex não está nesta máquina): toda RS bent de grau ≤ 3 em n = 2m variáveis tem uma órbita antipodal, isto é, não é constante na diagonal E.
  - Em grau 4 e n = 12, isso é exatamente o Lema 4 (caso A: t₃₀ = t₄₀ = t₄₂ = 0, f constante em U).
  - O que falha em B e C é que há órbita antipodal, e o argumento não diz mais nada. O que vem a mais é a linha 63 (Lema 3) e os lemas abaixo.

## 2. Lemas novos (à mão)
### Lema 5: (Pf4) contém o Lema 1
Pf4(V,J) é o coeficiente de z^J em Pf_V(T_z), com T a parte de grau 2 em z da polar. Nas 21 coordenadas, as 225 condições dão só **28 quádricas distintas** (`pf4_quadricas.py`). Entre elas:
- V = J ∈ {0134, 0235, 1245}: u₃₀ + u₄₀ + u₄₂;
- V = J ∈ {0123, 0125, 0145, 0345, 1234, 2345}: u₃₀ + u₄₀ + u₃₀u₄₂;
- V = J ∈ {0124, 0135, 0234, 0245, 1235, 1345}: u₄₀u₄₂;
- V ≠ J, ambos em {0134, 0235, 1245}: Y + α + β + u₄₂(p + r).

As três primeiras são as Q_S do Lema 1 dentro do modelo, de modo que (Pf4) sozinho já dá os casos A, B, C. A correspondência é S = J ∪ (J + 6): o 8-conjunto invariante por σ do Lema 1 é a "duplicação" do 4-conjunto V = J de (Pf4). A quarta, no caso B (u₄₂ = 0), dá **Y = α + β**.

*Prova:* Pf_V é a soma dos três emparelhamentos de V. Os T_{ij,K} são formas lineares em t, lidas na expansão de cada órbita em (z,w). *Teste:* Lema 5 de `teste_lemas_bc.py`.

### Lema 6: paridade em d = 63
Seja N₆₃ = #{z : B_z·𝟏 = 0}, isto é, o número de z em que o grafo B_z tem todos os graus pares. Então

  **N₆₃ ≡ (u₃₀+u₄₀+u₄₂) + α + β + (1+u₄₂)·Y (mod 2).**

*Prova.*
1. De B(Rz) = R^{−T} B(z) R^{−1} e R𝟏 = 𝟏 sai B_{Rz}𝟏 = R^{−T} B_z 𝟏. Logo o conjunto Z = {z : B_z𝟏 = 0} é união de órbitas de rotação.
2. As órbitas têm tamanho 1 ({0}, {63}), 2 ({21, 42}), 3 ({9,18,36} e {27,45,54}) ou 6. Logo |Z| ≡ [0∈Z] + [63∈Z] + [9∈Z] + [27∈Z] (mod 2).
3. Somas de linha (graus do grafo B_z):
   - B₀ = u₃₀C₁ + u₄₀C₂ + u₄₂C₃ (Lema 2). Os graus são 2u₃₀ + 2u₄₀ + u₄₂ ≡ u₄₂, logo [0∈Z] = 1 + u₄₂.
   - B₆₃ = αC₁ + βC₂, com graus pares, logo 63 ∈ Z.
   - B₉: graus (0, s, s, 0, s, s), com s = u₃₀+u₄₀+u₄₂+α+β. Logo [9∈Z] = 1 + s.
   - B₂₇: graus (Y, Y, u₄₂, Y, Y, u₄₂). Logo [27∈Z] = (1+Y)(1+u₄₂).
4. Somando: (1+u₄₂) + 1 + (1+s) + (1+Y)(1+u₄₂) ≡ s + (1+u₄₂)Y. ∎

As tabelas de B₉ e B₂₇ em coordenadas estão em `polares_simetricas.py`. Por exemplo, B₉ tem 01 = 04 = 13 = 34 = e, 02 = 05 = 23 = 35 = c, 03 = 0, 12 = 45 = u₃₀ + a + h + A1 + A2 + A3, 15 = 24 = u₄₀ + a + h + B1 + B3 e 14 = 25 = u₄₂ + p + r.

*Teste:* Lema 6 de `teste_lemas_bc.py`. O polinômio também foi conferido nos 2²¹ polares (`paridade_coords.py`: P(63) tem 18 monômios, grau 2).

**Corolário 6.1 (α = β).** Nos casos B e C, u₃₀ + u₄₀ + u₄₂ = 0, e a paridade exige N₆₃ par.
- Caso C (u₄₂ = 1): α = β.
- Caso B (u₄₂ = 0): α + β = Y. Com o nível 10 simétrico do Fable (Y = 0 em B), α = β.

O mesmo vale para d = 9: em B e C, N₉ ≡ N₆₃. Já d = 27 é sempre par.

### Lema 7: C com α = β = 0
r₀(0) = 32 (Lema 2: q₀ = (w₀+w₂+w₄)(w₁+w₃+w₅)) e |r₀(63)| = 64 (Lema 3). Logo a coluna 0 soma pelo menos 1.024 + 4.096 > 4.096. ∎

### Lema 8: o teste das 8 linhas tem 8 parâmetros
Os valores |r_b(z)| nas linhas z ∈ {0, e_i, 63} dependem só do caso, de (α, β) e da chave (x₁, x₂, y₁, y₂, w₁, w₂). Motivo:
- a linha 0 vem do Lema 2;
- a linha 63 vem do Lema 3;
- as linhas e_i são formas quadráticas puras. A polar da linha e₀ (item 7 do prompt) só envolve as somas d+h, e+n, g+k, a+h, c+g, b+n, b+e, c+k, a+d, que se escrevem nessas 6 chaves. A rotação leva a linha e₀ nas outras com |r| preservado (r_{Rb}(Rz) = ±r_b(z)).

Resultado (`oito_parametros.py`, tabela em `oito_tabela.json`):
- caso A: 0 de 256 chaves passam;
- caso B: 182 de 256 passam (20 de 64 com (α,β) = (0,0));
- caso C: 162 de 256 passam (nenhuma com (0,0)).

## 3. Estrutura de (Pf4) por subcaso (computador)
Envoltórias afins (`pf4_casos_hull.py`):
- **B(0,0):** 164 polares, dimensão 13. Relações: a+h+A1+A3+B1+B2 = 0, b+g+k+n = 0, d+m+A1+A3+B1+B2 = 0, e α = β = 0.
- **B(1,1):** 152 polares, dimensão 12. Os 94 que passam nas 8 linhas e na paridade ficam numa envoltória de dimensão 11 (acrescenta c+e+A1+A3+B2+B3 = 0).
- **C(1,1):** 40 polares, dimensão 8. Os 4 sobreviventes formam um **plano afim**, com A3 e B3 livres: a = h = p = r = A2 = 1, d = m = 0, b = g = A1 = A3, c = k = B2 = B3, e = n = B1 = B3 + 1.
- **Multiplicadores 5, 7, 11:** reduzem pouco. Os 94 de B(1,1) formam 62 órbitas; os 4 de C(1,1), 2 órbitas.

## 4. O que falta, subcaso por subcaso
- **B(0,0):**
  - Com α = β = 0, r₀(63) = ±64, então toda linha z ≠ 63 tem de ser balanceada na coluna 0.
  - Em (Pf4), y₂ = w₁ + w₂ (b+g+k+n = 0), e só 4 chaves das 20 da tabela sobrevivem: 000101, 000110, 001101, 001110.
  - Dentro de (Pf4) só aparece 000101 (2 polares), e a paridade os mata.
  - Falta à mão: tirar de (Pf4) a relação b+g+k+n = 0 e a exclusão das outras três chaves.
- **C(1,1):**
  - Os 4 polares do plano afim morrem no teste estendido: 34 linhas (as 8 fixas mais as órbitas de 21, 9, 27, 7, 11, 13), com 14 bits de fase (`linhas_estendidas.py`).
  - Também morrem por (L5)+(L3), mas só por combinação de linhas, sem linha isolada sem fase.
  - Falta à mão: a classificação de (Pf4) em C(1,1) (40 → 4) e um argumento curto para o plano.
- **B(1,1), o núcleo:** 94 polares passam em todos os testes só de polar.
  - O teste estendido, com 14 bits de fase, deixa 44.
  - Em (L5)+(L3), 88 morrem por uma única linha sem fase com constante 1. Doze linhas cobrem os 88; a melhor, (L3, I = {0}), cobre 40. Os outros 6 morrem por combinação.
  - Os conjuntos mortos por cada linha não são famílias afins, então não há um corte uniforme simples.
  - Os níveis 8 e 9 do Fable reduzem os 94 a 1, que morre por mod 4.

**Fase por linha** (`fase_por_linha.py`): o posto da fase homogênea vista por λ(z) é:

| Órbita de z | 0, e_i, 63 | 21 | 9, 27 | 7, 11, 13 | 3, 5, 31 | 15, 23 |
|---|---:|---:|---:|---:|---:|---:|
| Posto | 0 | 1 | 2 | 3 | 4 | 5 |

Isso explica por que o teste estendido é quase só de polar.

## 5. Conclusão honesta
- **Caso C, à mão:** α = β (Lema 6) e (0,0) é impossível (Lema 7). Resta C(1,1), que depende de (Pf4) (40 polares) e de um teste pequeno por polar.
- **Caso B, à mão:** α = β (Lema 6 + nível 10). B(0,0) depende de (Pf4) e da paridade. B(1,1) continua com 94 polares, mortos um a um por (L5)+(L3) (88 com uma linha só).
- A redução a ≤ 20 casos ainda não saiu. O gargalo é a classificação de (Pf4) por subcaso e o B(1,1).
- **Próximo passo sugerido:** atacar B(1,1) com as linhas simétricas 21/42 (1 bit de fase) e 9/27 (2 bits) junto com as colunas b ∈ {0, 27, 45, 54} (linha 63 ativa) e {9, 18, 36, 63} (linha 0 ativa).

## Arquivos (`h12_casos_bc/`)
- **Base e testes:** `bc_comum.py` (modelo, polar, espectro), `teste_lemas_bc.py` (Lemas 5–8).
- **Dados pedidos:**
  - `mapa_filtros.py` → `mapa_filtros.json`, `polares_nivel8_filtros.tsv`;
  - `certificado_35.py` → `certificado_35.tsv`;
  - `relacoes_fable_B.py`.
- **(Pf4):** `pf4_quadricas.py` (28 quádricas, `pf4_quadricas.json`), `pf4_quais_vj.py`, `pf4_casos_hull.py`, `pf4_xl.py`.
- **Paridade:** `paridade_coords.py` (P(d) nos 2²¹ polares, `paridade_anf.json`), `paridade_analise.py`, `polares_simetricas.py`.
- **8 linhas:** `oito_parametros.py`, `oito_tabela.json`, `funil_casos.py`, `b00_chaves.py`.
- **Fase e (L5)+(L3):** `fase_por_linha.py`, `linhas_estendidas.py`, `l5l3_sobreviventes.py`, `l3_uniforme.py`, `multiplicadores.py`.
- **Dados do Fable:** `dados_fable/polares_nivel8.txt` e `dados_fable/sobreviventes_nivel9.txt`.
- **Uso:** `python mapa_filtros.py <dados_fable> <pasta fable_planos_pfaffiano>`, e o mesmo padrão nos demais.

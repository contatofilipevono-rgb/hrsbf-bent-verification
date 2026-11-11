# Bloco de dimensão três, segunda rodada: coeficiente da fase na fibra fixa e estado da lacuna π|Φ = 0

11 de novembro de 2026. Continuação de NOTA_MEIA_VOLTA_DIM3.md. Sem auditoria externa.

**Resultado desta rodada.** A exclusão das formas A₁ e A₂ agora tem prova à mão, por uma identidade irmã da de Codex. As outras duas prioridades não fecharam: a lacuna π|Φ = 0 ficou mais estreita e melhor descrita, mas continua dependendo dos suportes; a dedução estrutural das nove formas não foi atacada.

| Prioridade | O que foi feito | Estatuto |
|---|---|---|
| 2. Identidade do coeficiente | identidade de Codex auditada em base independente; identidade para a₀+a₁+a₂ provada à mão | fechada |
| 1. As 14 classes e (G2) | 10 das 14 classes não têm nenhum suporte; restam 4 classes e a parte sem (G2) da classe complementar | aberta, lacuna refinada |
| 3. As nove formas de Q | nada novo | aberta |

**Atribuição.** De Codex: as nove formas de Q por eliminação dos 512 casos, a identidade a(H) = σg(7) + σg(21) + Q₁₁(7), a exclusão de A₁, A₂ pelo grau de H, a auditoria da Proposição 5 e de (G1), (G2), e a reconstrução das 4.194.304 funções. De Fable (esta nota e a anterior): o quarto de volta κ, o lema da fatia fixa, a Proposição 5, e o que segue.

Marcas: **[D]** à mão; **[L]** álgebra linear numa base; **[E]** enumeração dos suportes.

Notação da nota anterior: f = h(z,u) + π(z,u)·c, π = g(z) + Q(z)u, r(z) = u_z, x(z) = v_z, H(x,u) = h(9x,u), C a permutação cíclica de F₂³, σ a paridade. Q_{ik} é a linha i e a coluna k, com índices desde zero.

## 1. O coeficiente quártico da fase na fibra fixa

Seja a_i o coeficiente de x₀x₁x₂u_i em H.

**Lema A [D].** Para todo u* ∈ U: a_i = Σ_{z : r(z) = e_i} x(z)·π(z, u*).

*Prova.* a_i é a soma de h nos 16 pontos z ∈ V, u ∈ {0, e_i}. Tome d com r(d) = e_i. Os 32 pontos {z ∈ V, u ∈ {0, e_i}} ∪ {z ∈ d + V, u ∈ u* + {0, e_i}} formam um flat de dimensão 5, e h tem grau ≤ 4, logo a soma de h nele é zero. Na segunda metade, u_z = e_i, e a meia-volta dá h(z, u* + e_i) + h(z, u*) = π(z, u*)·x(z). ∎

**Lema B [D].** a₀ + a₁ + a₂ = Σ_{z : r(z) = 111} x(z)·g(z).

*Prova.* G(z) = x(z)·g(z) tem grau ≤ 4, porque g tem grau ≤ 3. O conjunto {z : σ(r(z)) = 1} é um hiperplano afim de F₂⁶, logo G soma zero nele. Ele é a união das quatro fatias r = e₀, e₁, e₂, 111, e o Lema A com u* = 0 dá as três primeiras. ∎

**Lema C [D].** Σ_{z : r(z) = 111} x(z)·g(z) = σg(7) + σg(21) + Q₁₂(7) + Q₀₁(7) + Q₀₀(21).

*Prova.* Da Proposição 1 com u = 0: g(Rz) = Cg(z) + z₅Q(Rz)e₀ e Q(Rz) = CQ(z)C⁻¹. A fatia r = 111 é a união das órbitas 7 → 14 → 28 → 56 → 49 → 35 e {21, 42}, com x = 0, 1, 3, 7, 6, 4 e x = 2, 5.

- Órbita de 7: g(14) = Cg₇, g(28) = C²g₇, g(56) = g₇, g(49) = Cg₇ + Q(49)e₀, g(35) = C²g₇ + CQ(49)e₀ + Q(35)e₀. Os termos em g₇ somam três vezes cada coordenada, isto é, σg(7). Os termos em Q somam Q₂₀(49) + Q₂₀(35) = Q₁₂(7) + Q₀₁(7).
- Órbita de 21: g(42) = Cg₂₁ e g₂₁ = C²g₂₁ + Q(21)e₀, cuja coordenada 0 diz g₂₁,₀ + g₂₁,₁ = Q₀₀(21). A soma x·g vale g₂₁,₂ = σg(21) + Q₀₀(21). ∎

**Teorema 6 [D].** Em todo o espaço RS afim em V,

a₀ + a₁ + a₂ = σg(7) + σg(21) + Q₁₂(7) + Q₀₁(7) + Q₀₀(21).

Conferido nas 60 funções da base por `identidade_soma.py`. Nenhuma hipótese sobre π|Φ é usada.

**Corolário 7 [D].** Se π|Φ = 0, a função H é bent em seis variáveis, tem grau ≤ 3, e portanto

σg(7) + σg(21) = Q₁₂(7) + Q₀₁(7) + Q₀₀(21).

- Formas A_j = Rʲ[σ(r)(I + r1ᵀ)]: em r = 111 a imagem é o plano par e o rótulo 0 não pode reaparecer, logo σg(7) = σg(21) = 1. O lado direito vale 0 em A₀ e 1 em A₁, A₂. **A₁ e A₂ estão excluídas à mão.**
- Formas C_j = 1(r × Rʲr)ᵀ: Q se anula em r = 111, e o corolário dá a condição nova σg(7) = σg(21).

**Relação com a identidade de Codex.** A dele isola a₀: a₀ = σg(7) + σg(21) + Q₁₁(7). Reproduzi-a nas 60 funções da minha base independente (`identidade_fase.py`), com as convenções da nota dele: z = 7 e z = 21 têm r = 111, com x = 0 e x = (0,1,0). O Lema A reduz a identidade dele a um enunciado só sobre o mapa, Σ_{r(z) = e₀} x·g = σg(7) + σg(21) + Q₁₁(7), que continua sendo [L]. Para a exclusão de A₁, A₂ basta o Teorema 6. Na base, a₂ = a₀ sempre e a₁ + a₀ toma os dois valores.

## 2. A lacuna π|Φ = 0

**Contagem por classe [E], `classes_suportes.py`.** Das 15 classes não nulas que passam no lema da fatia fixa, só cinco têm suportes:

| g em V (x = 0..7) | Q em V | Suportes | Candidatos (dos 976) |
|---|---|---:|---:|
| (0,6,5,3,3,5,6,0) | 0 | 53.244 | 0 |
| (0,6,5,0,3,0,0,0), classe complementar | 0 | 9.528 | 384 |
| (0,0,0,3,0,5,6,0) | 0 | 9.528 | 0 |
| (7,0,0,0,0,7,0,0) | J nos x pares | 2.376 | 0 |
| (7,6,5,0,3,7,0,0) | J nos x pares | 1.272 | 0 |
| zero | 0 | 21.582 | 592 |

As outras dez classes não têm nenhum suporte balanceado com indicadores de grau ≤ 5. Logo "as 14 classes" são, de fato, quatro classes com 66.420 suportes, mais os 9.144 suportes da classe complementar que não chegam aos 384.

**Onde caem [E], `onde_morre.py` (amostra de um em sete).** Em todas essas classes o sistema linear de fases é incompatível, salvo 32 suportes cujas fases estão todas nas classes maiores. A incompatibilidade:

- nunca aparece nas equações de ordem 0 (peso par em cada fibra);
- aparece nas de ordem ≤ 1 em parte dos casos, e nas de ordem 2 no resto;
- não se localiza numa fibra fixa: o conjunto de fibras que falham sozinhas varia de suporte para suporte, mesmo dentro de uma classe.

Não encontrei um argumento por classe. A Proposição 5 não se transporta diretamente, porque usa a posição da fibra 0 fora de V, que nessas classes varia.

**Lema da paridade cúbica [D].** Para toda fibra γ e todo β, a função τ(z) = T_γ(z, β)/2 mod 2 tem grau ≤ 3 em z. Fora de z = 0 ela só depende do suporte: vale [β·r + γ·x = 0]·|P_γ(z)|/2 para z ∉ V, e o número de pares {u, u+x} ⊂ P_γ(x) com γ·u = β·x para z = 9x.

*Prova.* T_γ(·, β) = W_G/8 para uma função booleana G de seis variáveis, com W_G = 16t. Para um monômio z_I, Σ_z W_G(z) z_I = 2^{6−|I|} Σ_{α ⊆ I} ±1, logo Σ_z t(z) z_I é par para |I| ≤ 2. Assim t mod 2 é ortogonal a RM(2,6). ∎

Teste [E], `paridade_cubica.py`: o lema elimina 6.144 suportes, todos com π|Φ ≠ 0, e nenhum dos 976. É quase todo consequência do grau ≤ 5. Não substitui as equações de fase com monômios em u.

**(G2).** Continua vindo dos dados: os 384 são os suportes da classe complementar que passam no sistema linear, e neles (G2) vale. Não há dedução.

## 3. Rechecagem 43025501337

A execução 43025501337 do GitHub Actions ("Verify the nine V3 matrix forms", commit 55e88f9, ramo codex/n12-mixed-quartic) terminou com sucesso: nove tarefas de construção e a agregação, 34 segundos, só avisos de versão do Node. Não abri os artefatos; o total de funções não foi relido por mim.

## 4. Lacuna exata ao encerrar

1. **π|Φ = 0.** Falta prova à mão de que caem: as quatro classes da tabela (66.420 suportes) e a parte da classe complementar sem (G2) (9.144 suportes). Hoje isso é o sistema linear de fases sobre os suportes enumerados, reproduzido de forma independente. Também é [E] a ausência de suportes nas outras dez classes.
2. **Nove formas de Q.** Continua sendo a eliminação certificada de Codex sobre 512 casos. Desta rodada só sai, à mão, que A₁ e A₂ caem dado o resto da lista, e a condição σg(7) = σg(21) para C₁, C₂.
3. **Identidade de a₀ sozinho.** A parte sobre o mapa continua [L]; não é necessária para a exclusão.
4. **Seleção de g e fases** em A₀, C₁, C₂: certificados computacionais de Codex, não revistos aqui.

## Arquivos novos

- `identidade_soma.py`: Teorema 6 e a equivariância usada no Lema C, nas 60 funções da base; valores nas formas A_j.
- `identidade_fase.py`: identidade de Codex e Lema A em base independente.
- `classes_suportes.py`, `onde_morre.py`: seção 2.
- `paridade_cubica.py`: lema da paridade cúbica nos 97.530 suportes.

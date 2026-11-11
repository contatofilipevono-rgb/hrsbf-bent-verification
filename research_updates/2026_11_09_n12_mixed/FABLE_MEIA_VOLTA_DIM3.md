# Bloco de dimensão três (n = 12, grau 4): redução pela meia-volta e pelo quarto de volta

11 de novembro de 2026. Sem auditoria externa.

**Resultado.** Toda função bent do bloco exclusivo de V = ⟨9, 18, 36⟩ tem π ≡ 0 na fatia fixa z ∈ V. A fibra do rótulo 0 é então exatamente o plano fixo V×U, e a fase restrita a ela é uma função RS bent de seis variáveis. As outras sete fibras são uniões de 16 órbitas livres de tamanho quatro.

A prova tem três partes, com estatutos diferentes:

| Passo | O que faz | Estatuto |
|---|---|---|
| Lema da fatia fixa | reduz as 64 restrições possíveis de π a z ∈ V para 16 | à mão |
| Exclusão de 14 das 15 classes não nulas | nenhum suporte delas tem fase linear viável fora das classes maiores | enumeração (97.530 suportes) |
| Exclusão da última classe (384 candidatos) | Parseval por fatia na fibra 0 | à mão, com duas hipóteses geométricas conferidas nos 384 |

**Lacuna exata.** O segundo passo não tem prova à mão. Depois dele sobram 592 candidatos com π = 0 na fatia fixa, dos quais 256 têm fase; a seleção desses 256 continua sendo um enunciado sobre fases (seção 7).

Marcas: **[D]** demonstrado à mão; **[L]** álgebra linear numa base, segundos; **[E]** depende da enumeração dos suportes.

## 1. Coordenadas

- x = (a, b), z = a + b, w = b. Escreva w = u + v com u ∈ ⟨1, 2, 4⟩ e v = 9c, c ∈ F₂³. Então u_j = w_j + w_{j+3} e c_j = w_{j+3}.
- Para z: r_j(z) = z_j + z_{j+3} e x(z) = (z₃, z₄, z₅). Assim u_z = r(z) e v_z = x(z); z ∈ V equivale a r(z) = 0.
- f = h(z, u) + π(z, u)·c. O ponto da base é y = (z, u) = (x, r, u), em Y = F₂⁹.
- C é a permutação cíclica de F₂³, (Ct)_j = t_{j−1}. R é a rotação de F₂⁶.
- P_γ = π⁻¹(γ) é a fibra do rótulo γ; P_γ(z) = {u : π(z, u) = γ}. Φ = V×U é o conjunto fixo da meia-volta.

## 2. A rotação na base e o quarto de volta

**Proposição 1 [D], conferida nas 60 funções da base por `verifica_kappa.py`.** A rotação ρ desce a Y como ρ_Y(z, u) = (Rz, Cu + z₅e₀), e

- π(ρ_Y y) = Cπ(y), h(ρ_Y y) = h(y) + u₂π₂(y).

O cubo κ = ρ_Y³ é

- **κ(x, r, u) = (x + r, r, u + x)**, com κ² = meia-volta;
- **π∘κ = π** e **h∘κ = h + π·u**.

*Prova.* ρ(z, w) = (Rz, Rw + z₅e₀). Nas coordenadas (u, c), R age por u ↦ Cu, c ↦ Cc + u₂e₀, e a translação z₅e₀ só altera u. Comparar os coeficientes de c em f∘ρ = f dá as duas relações. Iterando três vezes, ρ³(z, w) = (R³z, R³w + x̂), com x̂ o vetor de bits baixos x; R³ fixa u e leva c em c + u, e x̂ soma x a u. ∎

Consequências imediatas:

- Cada fibra é união de órbitas de κ. Há três tipos: 8 pontos fixos (z = 0); 28 pares {(x, u), (x, u + x)} em Φ, x ≠ 0; e quadras {(x,r,u), (x+r,r,u+x), (x,r,u+r), (x+r,r,u+x+r)} com r ≠ 0.
- Em Φ: π(x, u)·x = 0 (meia-volta) e π(x, u + x) = π(x, u) (κ).
- Os rótulos se permutam por C, com órbitas {0}, {7}, {1,2,4}, {3,5,6}. As fibras 0 e 7 são invariantes por ρ_Y.
- Numa quadra de rótulo γ, as fases são h₀, h₀ + γ·u, h₀ + γ·x, h₀ + γ·(x + u + r). Na fibra 0 a fase é constante em cada órbita de κ.

**Proposição 2 [L], `estrutura.py` e `forma_Q.py`.** No espaço de dimensão 34:

- π é afim em u: **π = g(z) + Q(z)u**, com Q(z)r(z) = 0. O espaço dos Q tem dimensão 14 e o dos mapas com Q = 0 tem dimensão 20.
- A meia-volta e o grau sozinhos deixam um único termo quadrático possível, μ·(u₀u₁r₂ + u₀u₂r₁ + u₁u₂r₀) [D]; ele não ocorre no espaço RS [L].
- O subespaço Q|_V = 0 tem dimensão 11 e é exatamente {Q(z)u = A(z)(u × r(z)), A afim}. O quociente Q|_V tem dimensão 3.
- A restrição de π a Φ percorre um espaço de dimensão 6 (64 classes), e Q|_V é determinado por g|_V.

Classes maiores, em termos de Q: f é afim em V₁ = V ⊕ ⟨u = 111⟩ se e só se Q(z)(111) ≡ 0; afim em U exige Q(z)u = 0 para u par; a classe antipodal exige Q = 0.

## 3. Lema da fatia fixa

**Teorema 3 [D].** Suponha que os indicadores das fibras têm grau ≤ 5. Então, para todo γ:

- (a) |P_γ(x)| ≡ 0 (mod 4) para todo x ∈ V∖{0};
- (b) |P_γ(0)| é par e a soma dos u ∈ P_γ(0) é zero.

Com π afim em u: **Q(x) tem posto ≤ 1 e Q(x)x = 0 para todo x ∈ V**, e Q(0) ∈ {0, J}, onde Ju = (u₀+u₁+u₂)·(1,1,1).

*Prova.* Grau ≤ 5 equivale a toda função m de grau ≤ 3 somar zero em cada fibra. Somo por órbitas de κ.

- m = u_i·z_j z_{j+3}. Numa quadra a soma é r_i[φ(z) + φ(R³z)] com φ = z_j z_{j+3}, que é invariante por R³; dá zero. Num par de Φ, φ = x_j e a soma é x_i x_j. Em z = 0, φ = 0. Logo, com a_γ(x) = |P_γ(x)|/2, vale Σ_x a_γ(x) x_i x_j = 0 para todos i, j (incluindo i = j).
- As seis funções x_i, x_i x_j são independentes em V∖{0}, e o vetor constante é ortogonal a todas. Logo a_γ tem paridade constante em V∖{0}.
- Se γ ≠ 0, existe x ≠ 0 com γ·x = 1, onde P_γ(x) é vazio; a paridade é par. Para γ = 0, Σ_γ a_γ(x) = 4 dá o mesmo. Isso é (a).
- m = 1: tudo fora de z = 0 vem em órbitas pares, logo |P_γ(0)| é par. m = u_i: quadras somam zero, pares somam x_i, e Σ a_γ(x)x_i = 0; sobra Σ_{P_γ(0)} u_i = 0. Isso é (b).
- Com π afim, P_γ(x) é vazio ou uma classe de ker Q(x). Posto 2 dá classes de 2 pontos, contra (a) e contra (b) (a soma seria o gerador do núcleo). Posto 3 dá tamanho 1. Q(0) comuta com C e tem posto ≤ 1. ∎

**Corolário [L], `fatia_fixa.py`.** Das 64 classes de π|_Φ, 48 violam o Teorema 3. Sobram 16:

- oito com Q|_V = 0 e g(0) = 0 (um espaço de dimensão 3 de funções g: V → F₂³ com g(x)·x = 0);
- oito com g(0) = 7 e Q(0) = J, em que Q(x) tem posto 1 nos x de peso par.

Conferência [E]: nos 97.530 suportes o posto de Q em V é sempre ≤ 1.

## 4. A fibra invariante quando π|_Φ = 0

**Proposição 4 [D].** Se π ≡ 0 em Φ, então P₀ = Φ, e a condição de Walsh da fibra 0 diz exatamente que H(x, u) = h(9x, u) é bent em F₂⁶. Além disso H(x, u + x) = H(x, u) e H(Cx, Cu + x₂e₀) = H(x, u). Estas são a meia-volta e a rotação de uma função RS de seis variáveis nas coordenadas (z′, w′) = (x, u). As outras fibras são uniões de 16 quadras.

*Prova.* |Φ| = 64 = |P₀|. As duas simetrias são as de κ e ρ_Y com π = 0. ∎

Conferido nas 12 testemunhas por `verifica_fibra0.py`.

## 5. Exclusão da classe complementar

Das 15 classes não nulas que passam no Teorema 3, só uma tem suportes com fase linear viável fora das classes maiores [E]: **g(e_i) = e_i + (1,1,1) nos x de peso 1 e g = 0 nos demais, com Q|_V = 0**. São 384 dos 976 candidatos. Neles valem [E, `verifica_384.py`]:

- (G1) P₀ contém {x}×U para x ∈ {0, 3, 5, 6, 7} e não encontra x = 1, 2, 4;
- (G2) fora de V, P₀ vive em seis valores de z, que formam uma órbita de R; em cada um, P₀(z) é uma classe do plano par K = {0, 3, 5, 6}, e r(z) tem peso 2.

**Proposição 5 [D].** Um mapa com (G1) e (G2) não admite fase bent.

*Prova.* Ponha T(z, β) = Σ_{u ∈ P₀(z)} (−1)^{h(z,u)+β·u}. Como S₀(α, β) = Σ_z (−1)^{α·z} T(z, β) = ±8 para todo α, Parseval dá, para cada β,

(P) Σ_z T(z, β)² = 64.

Na fibra 0 a fase é invariante por κ e por ρ_Y. Disso:

- para x ∈ V∖{0} em P₀: T(9x, β) = 0 se β·x = 1, e T(9x, β) ∈ {0, ±4, ±8};
- T(Rz, 0) = T(z, 0), e os quadrados |T(9x, β)|² só dependem da órbita de (x, β) por C;
- T(0, ·) é o espectro de uma função C-invariante de três variáveis, com valores pares.

Fora de V, P₀(z) = {u, u+r, u+k, u+k+r} com k ∈ K, e h(u + r) = h(u). Logo T(z, β) = (1 + (−1)^{β·r})[(−1)^{h(u)+β·u} + (−1)^{h(u+k)+β·(u+k)}].

*Passo 1.* Em β = 0, T vale um mesmo t ∈ {0, ±4} nos seis z. Se t ≠ 0, (P) daria ≥ 96. Logo t = 0, isto é, h(u + k) = h(u) + 1, e

T(z, β) = ±4 se β·r = 0 e β·k = 1; caso contrário 0.

*Passo 2.* Como K é o plano par, β·k = 1 para algum k exige β ∉ {0, 7}. Os r dos seis z são 3, 5, 6, cada um duas vezes. Cada β ∈ {1, …, 6} é ortogonal a exatamente um deles. Logo a parte fora de V contribui 32 em (P) para β ∈ {1, …, 6} e 0 para β ∈ {0, 7}.

*Passo 3.* Nomeie os quadrados: a₀, a₁, a₂, a₇ para x = 0 (β de peso 0, 1, 2, 3), em {0, 4, 16, 36, 64}; b₀, b₂ para x = 7 (β = 0, β de peso 2), e c₀, c₁, c₂, c₇ para x de peso 2 (β = 0, β = complemento de x, β = x, β = 7), todos em {0, 16, 64}. Então:

1. β = 0: a₀ + 3c₀ + b₀ = 64
2. β = 7: a₇ + 3c₇ = 64
3. β de peso 1: a₁ + c₁ = 32
4. β de peso 2: a₂ + c₂ + b₂ = 32
5. Parseval em x = 0: a₀ + 3a₁ + 3a₂ + a₇ = 64
6. Parseval em x de peso 2: c₀ + c₁ + c₂ + c₇ = 64
7. Parseval em x = 7: b₀ + 3b₂ = 64

- De (3): a₁ = c₁ = 16. De (5): a₀ + 3a₂ + a₇ = 16, logo a₂ ∈ {0, 4}.
- De (4): a₂ = 4 daria c₂ + b₂ = 28, impossível. Logo a₂ = 0, c₂ = b₂ = 16, e (7) dá b₀ = 16.
- De (2) com a₀ + a₇ = 16: a₇ = 16, c₇ = 16, a₀ = 0. De (1): c₀ = 16.

*Passo 4.* Então T(·, 0) vale ±4 em z ∈ {27, 45, 54, 63} e zero no resto. Seja G a função booleana com W_G = 8T(·, 0), isto é, (−1)^G = ½(±χ₂₇ ± χ₄₅ ± χ₅₄ ± χ₆₃). Uma soma de quatro sinais vale ±2 só se o produto deles é −1. Isso exigiria que χ_{27+45+54+63} = χ₆₃ fosse constante. Contradição. ∎

Controle [E] (`mata_384.py`): a varredura completa das fases do sistema linear dá zero fases válidas na fibra 0 já com β = 0, nos dois padrões dos 384. Num candidato de dimensão 18 (2¹⁸ fases) caem também as fibras 1, 2, 4; num de dimensão 21 (2²¹ fases) caem também as fibras 3, 5, 6.

## 6. Conferência independente da contagem

Reconstrução sem importar código do repositório (`base3.py`, `enum3.py`, `fase_linear.py`):

| Etapa | Nota do repositório | Aqui |
|---|---:|---:|
| Dimensões (π, fases) | 34, 26 | 34, 26 |
| Partes cúbicas que passam | 12.160 | 12.160 |
| Mapas testados | 49.807.360 | 49.807.360 |
| Balanceados | 883.994 | 883.994 |
| Indicadores de grau ≤ 5 | 97.530 | 97.530 |
| Candidatos após fase linear e exclusão de classes | 976 | 976 |

Composição dos 976 (`olha_candidatos.py`):

| π em Φ | Postos de Q(z) (0, 1, 2) | Candidatos | Destino |
|---|---|---:|---|
| classe complementar | 8, 24, 32 | 384 | excluídos pela Proposição 5 |
| zero | 16, 48, 0 | 384 | 112 mapas com fase (7 órbitas) |
| zero | 32, 0, 32 | 208 | 144 mapas com fase (5 órbitas) |

A atribuição dos 256 mapas com fase às duas últimas linhas vem das 12 testemunhas publicadas (uma por órbita, com os tamanhos de órbita da nota). Não recontei as fases quadráticas.

## 7. O que falta

1. **As 14 classes não nulas restantes.** Há suportes com π ≠ 0 em Φ (75.948 dos 97.530, contando a classe complementar) e, fora dessa classe, todos caem no sistema linear de fases ou só admitem fases nas classes maiores. Falta um argumento à mão. O sistema da Proposição 5 (Parseval por β nas fatias fixas, mais simetria C) é o candidato natural, mas depende de onde a fibra 0 vive fora de V.
2. **(G2) para a classe complementar.** A Proposição 5 usa a geometria dos 384 candidatos. Há 19.056 suportes com 40 pontos fixos na fibra 0; os que não satisfazem (G2) já caem antes, por enumeração.
3. **Seleção dentro de π|_Φ = 0.** Dos 592 candidatos, 336 não têm fase. Pela Proposição 4, a fibra 0 só impõe que h|_Φ seja RS bent de seis variáveis; a seleção vem das sete fibras de quadras. A decomposição do Walsh de uma fibra por tipo de quadra (γ·r = 1 contribui sempre ±2; γ·r = 0 contribui 0 ou ±4) está pronta para isso, mas não foi levada adiante.
4. **Limite do teste de perfil.** Exigir só que T(·, 0) seja 1/8 do espectro de uma das 80 funções RS de seis variáveis com Walsh divisível por 16 elimina 6.144 suportes e nenhum dos 976 (`rs6.py`, `perfil_fibra0.py`). A Proposição 5 precisa dos β ≠ 0.

## Arquivos

- `base3.py`: espaço RS afim em V, π e fases.
- `estrutura_util.py`, `estrutura.py`, `forma_Q.py`, `fatia_fixa.py`: Proposição 2 e o corolário do Teorema 3.
- `verifica_kappa.py`: Proposição 1.
- `enum3.py`: os 97.530 suportes (cerca de 8 minutos). `fase_linear.py`: os 976 (cerca de 12 minutos).
- `olha_candidatos.py`, `geometria_384.py`, `verifica_384.py`, `mata_384.py`: seção 5.
- `verifica_fibra0.py`: Proposição 4. `rs6.py`, `perfil_fibra0.py`: teste de perfil.
- Os arquivos `.pkl` e `.npz` são gerados por `base3.py`, `estrutura.py`, `enum3.py` e `fase_linear.py`; as testemunhas vêm de `lower-dim-family-witnesses.json` do repositório (commit 7e509e2).

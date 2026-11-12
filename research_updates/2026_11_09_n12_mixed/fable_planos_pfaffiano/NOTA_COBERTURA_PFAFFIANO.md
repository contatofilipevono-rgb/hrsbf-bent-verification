# Cobertura pelos planos ⟨27,54⟩ e ⟨21,42⟩: redução pelo grau dos Pfaffianos

11 de novembro de 2026. Sem auditoria externa.

**Resultado.** A cobertura não foi provada. Saiu uma redução demonstrada: uma condição necessária nova, sem fase, que vem só da bentness e do grau ≤ 2 em w, exclui **34 dos 49 pares** de classes em que as duas derivadas mistas são não nulas. Restam 15 pares (9 órbitas pelas simetrias), realizados por 6.976 formas polares. Um segundo teorema, linear na parte de f afim em w, reduz essas 6.976 a **3.984**, sem derrubar nenhum par inteiro (seção 3a).

**Atribuição.** A prova da hipótese de grau em w (seção 1a) é de Codex. Os Teoremas 2 e 5, a Proposição 3 e os verificadores desta pasta são de Fable. A cobertura computacional de referência é a de COBERTURA_PLANOS_N12.md.

| Passo | Estatuto |
|---|---|
| D₂₇D₅₄f e D₂₁D₄₂f só dependem de z e vivem em espaços de dimensão 3 | álgebra linear na base [L] |
| Teorema (Pf4): os Pfaffianos 4×4 da polar têm grau ≤ 3 em z | à mão [D] |
| Exclusão de 34 pares | (Pf4) mais enumeração de 2²¹ partes quadráticas [L] |
| Os 15 pares restantes | abertos; hoje só caem pela verificação de fases |

Marcas: **[D]** à mão; **[L]** álgebra finita numa base explícita, segundos a minutos.

## 1. Hipóteses e convenções

- x = (a, b), z = a + b, w = b. As direções antipodais são as translações de w.
- **(H0)** f tem grau ≤ 2 em w nas coordenadas (z, w). No espaço RS de grau ≤ 4 (dimensão 70) isso corta exatamente o modelo de dimensão 68 da nota de cobertura [L, `base12.py`]. A meia-volta sozinha já elimina os termos de grau 4 em w [D], mas deixa duas dimensões de termos cúbicos. A prova de (H0) para funções bent é de Codex e está na seção 1a; não a reconferi.
- Sob (H0): f = α(z) + λ(z)·w + q_z(w), com polar B_z. As entradas de B_z têm grau ≤ 2 em z, B_z z = 0 (meia-volta) e B_{Rz} = R B_z Rᵀ (rotação).
- β_a(z) = B_z(27, 54) = D₂₇D₅₄f e β_b(z) = B_z(21, 42) = D₂₁D₄₂f. O enunciado a provar é: f bent implica β_a ≡ 0 ou β_b ≡ 0.

### 1a. Prova de (H0), por Codex

Transcrita da mensagem de 11/11. As duas identidades finais foram conferidas por Codex por comparação explícita de monômios; nada desta subseção foi verificado por mim.

- Em (a, b) = (z + w, w), a meia-volta em z = 0 cancela os suportes trocados; os suportes fixos são uniões de pares antipodais e viram monômios de grau ≤ 2 em w. Restam a excluir os termos z_i w_j w_k w_l.
- Se i ∈ {j, k, l}, os suportes que contribuem têm um par antipodal e dois índices simples e se cancelam pela meia-volta.
- Se os quatro índices são distintos e formam S, o coeficiente é a soma sobre um representante de cada par de suportes trocados pela meia-volta, e não depende de qual índice de S fornece z_i.
- A rotação reduz S a três tipos, pela distância cíclica entre os dois índices ausentes. Na distância três, a rotação por três age sem pontos fixos nas classes de suportes módulo meia-volta (se fixasse uma classe, seu quadrado, que é a meia-volta, fixaria o suporte), e o coeficiente zera.
- Nas distâncias um e dois sobram, com t_j os coeficientes das órbitas quárticas indexadas desde zero pela menor máscara:
  A = t₀+t₄+t₇+t₉+t₂₂+t₂₇+t₂₉+t₃₇ e B = t₁+t₃+t₅+t₈+t₂₄+t₂₈+t₃₄+t₃₆.
- Para uma máscara s de quatro posições, P_s é a soma de t_[U]·t_[U′] sobre as partições não ordenadas do complemento de s em dois suportes quárticos. Bentness dá P_s = 0: o peso na fatia coordenada de dimensão oito é múltiplo de quatro, e módulo quatro só contribuem os pares de quárticos disjuntos.
- Identidades no anel booleano: P₅₈₅ = t₃₀+t₄₀+t₄₂; A + B = P₁₉₅ + P₃₂₅ + (1+t₄₂)P₅₈₅; B = P₃₂₅ + Σ_{(s,j) ∈ T} t_j P_s, com
  T = {(23,1), (29,3), (43,5), (53,8), (71,10), (77,12), (83,13), (89,15), (101,17), (113,19), (139,21), (149,24), (163,26), (169,28), (197,31), (209,33), (275,34), (281,36), (293,38), (325,40), (329,41)}.
- Logo A = B = 0 e o grau em w é ≤ 2.

Funções RS de z: e₁ = Σ z_i, p₁ = Σ z_i z_{i+1}, p₂ = Σ z_i z_{i+2}, p₃ = z₀z₃ + z₁z₄ + z₂z₅.

**Proposição 1 [L], `betas.py`.** O espaço das polares B tem dimensão 25, e

- β_a = a₀e₁ + a₁p₁ + a₂p₂,
- β_b = b₁p₁ + b₂(e₁ + p₂) + b₃(1 + e₁ + p₃),

com (a, b) percorrendo F₂³ × F₂³ sem relação linear. São 64 classes, 49 com a ≠ 0 e b ≠ 0.

Observações [D]:
- β_a e β_b são invariantes por R, porque R permuta as bases dos dois planos.
- β_a se anula em V_a∖{0} e β_b em V_b∖{0}, por B_z z = 0.
- β_b(z) = D₂₁π, onde π = D₆₃f é o mapa do modelo da reta 63. Logo b é decidido pelo mapa, e a é uma propriedade da fase.
- Nas 18 testemunhas publicadas [L, `testemunhas12.py`]: a ∈ {(1,1,1), (1,0,1)} quando β_a ≠ 0, e b = (1,1,0) quando β_b ≠ 0.

## 2. O teorema dos Pfaffianos

**Teorema 2 (Pf4) [D].** Seja f bent em F₂⁶ × F₂⁶ com grau ≤ 2 em w. Para todo subespaço V ⊂ W de dimensão 4, com base v₁, …, v₄, a função

Pf_V(z) = B_z(v₁,v₂)B_z(v₃,v₄) + B_z(v₁,v₃)B_z(v₂,v₄) + B_z(v₁,v₄)B_z(v₂,v₃)

tem grau ≤ 3 em z. Não se usa a rotação.

*Prova.* Fixe w₀ e ω, e ponha K_z = Σ_{s ∈ V} (−1)^{f(z, w₀+s) + ω·(w₀+s)}.

- Em s, a função é quadrática com polar B_z|_V. Sua soma vale ±4 se a forma é não degenerada, 0 ou ±8 se tem posto 2, e 0 ou ±16 se é nula. Logo K_z ≡ 4·Pf_V(z) (mod 8).
- Poisson: Σ_{ν ∈ V^⊥} (−1)^{ν·w₀} W(α, ω+ν) = 4·Σ_z (−1)^{α·z} K_z. O lado esquerdo é soma de quatro valores ±64, logo é múltiplo de 128. Assim K̂(α) = Σ_z (−1)^{α·z}K_z ∈ 32ℤ para todo α.
- Para um monômio z_I, Σ_z K_z z_I = 2^{−|I|} Σ_{J ⊆ I} (−1)^{|J|} K̂(e_J) ∈ 2^{5−|I|}ℤ. Com κ_z = K_z/4, a soma Σ_z κ_z z_I é par para |I| ≤ 2.
- Como κ_z ≡ Pf_V(z) (mod 2), Pf_V é ortogonal a RM(2,6), isto é, Pf_V ∈ RM(3,6). ∎

Pf_V é 4-linear e alternada em (v₁, …, v₄), então basta impor a condição nos 15 menores de coordenadas γ₂(B)_{ijkl} = B_ij B_kl + B_ik B_jl + B_il B_jk. O termo de grau 4 só depende das partes quadráticas das entradas de B.

**Proposição 3 [D].** Nas mesmas hipóteses, com a meia-volta: B₀ é singular. (Mesma conta com V = W: a soma da fatia vale ≡ 8·Pf(B_z) mod 16, o que dá grau ≤ 2 para z ↦ Pf(B_z); como B_z z = 0, essa função é Pf(B₀)·δ₀, de grau 6 se não for nula.)

Para um plano V a mesma conta dá só grau ≤ 4, que é automático.

Controles [L, `verifica_pf4.py`]: (Pf4) e a Proposição 3 valem nas 18 testemunhas bent; em 2.000 polares aleatórias do modelo, as 2.000 violam (Pf4).

## 3. O que (Pf4) exclui

**Corolário 4 [L], `pfaffiano.py` e `pfaffiano_ab.py`.** O espaço das partes quadráticas de B tem dimensão 21. Das 2²¹ partes, 1.176 satisfazem (Pf4); com as 4 direções sem parte quadrática, são 18.816 polares de 2²⁵. A Proposição 3 não exclui mais nada depois disso.

Pares (a, b) com a ≠ 0 e b ≠ 0 que sobrevivem, com a = (a₀, a₁, a₂) e b = (b₁, b₂, b₃):

| a | b | Polares |
|---|---|---:|
| (1,0,0), isto é, β_a = e₁ | os sete b ≠ 0 | 4.928 |
| (0,1,1), (1,1,1) | (0,1,0), (1,0,0) | 1.536 |
| (0,0,1), (0,1,0), (1,0,1), (1,1,0) | (1,0,1) | 512 |

Total: **15 pares, 6.976 polares.** Os outros 34 pares não têm nenhuma polar que satisfaça (Pf4), logo nenhuma função bent.

Simetrias [L, `orbitas_ab.py`]: as 24 unidades circulantes de F₂[X]/(X⁶+1) e a reflexão agem nas classes por β ↦ β∘M. Os 49 pares formam 29 órbitas; os 15 restantes formam 9.

Leitura em termos da verificação:
- **O que fica dispensado.** Toda fase cuja polar cai num dos 34 pares, e toda polar fora das 18.816, está excluída sem momentos nem enumeração de fases. Entre as polares com as duas derivadas não nulas, restam 6.976 de cerca de 25,7 milhões.
- **O que não fica.** Todos os sete b ≠ 0 continuam vivos com a = (1,0,0), então nenhum mapa do modelo da reta é dispensado só por esta condição. Não cruzei a redução com as 452 órbitas de mapas nem com as 49 tarefas de fase da execução de referência.

## 3a. Levantamento linear em hiperplanos

O bit seguinte da mesma conta só é linear em dimensão ímpar. Num 4-flat, S(z) ≡ 4P + 8J (mod 16) dá Σ_{z ⊇ I}(P + 2J) ≡ 0 (mod 4) para |I| ≤ 1, e J é quadrático na parte de f afim em w.

**Teorema 5 (L5) [D].** Nas hipóteses do Teorema 2, seja V ⊂ W um hiperplano e w₀ ∈ W. Para z com B_z|_V de posto 4, seja r_z o gerador do radical. Então, para todo I com |I| ≤ 2,

Σ_{z ⊇ I, posto(B_z|_V) = 4} (1 + D_{r_z} f(z, w₀)) ≡ 0 (mod 2).

*Prova.* A soma K_z de (−1)^f na classe w₀ + V vale 0 ou ±8 se o posto é 4, e é não nula exatamente quando f é constante na direção do radical, isto é, D_{r_z}f(z, w₀) = 0; nos outros postos K_z ≡ 0 (mod 16). Poisson: Σ_{ν ∈ V^⊥} (±)W(α, ω+ν) = 2·K̂(α), e o lado esquerdo é soma de dois valores ±64, logo K̂ ∈ 64ℤ. Então Σ_z K_z z_I ∈ 2^{6−|I|}ℤ e Σ_z (K_z/8) z_I é par para |I| ≤ 2. Com um caráter ω na soma aparece o termo ω·r_z, que soma zero por (Pf4); por isso basta ω = 0. ∎

Fixada a polar B, (L5) é um sistema linear nas 43 direções de f afins em w, com 63 × 2 × 22 equações. Controle: vale nas 18 testemunhas bent, sem incógnitas.

**Resultado [L], `poisson5.py` (cerca de 25 minutos).** Polares com (L5) compatível, entre as 6.976:

| a | b | Compatíveis | Total |
|---|---|---:|---:|
| (1,0,0) | (0,0,1) | 218 | 256 |
| (1,0,0) | (0,1,0) | 402 | 800 |
| (1,0,0) | (0,1,1) | 296 | 320 |
| (1,0,0) | (1,0,0) | 402 | 800 |
| (1,0,0) | (1,0,1) | 352 | 448 |
| (1,0,0) | (1,1,0) | 928 | 2.048 |
| (1,0,0) | (1,1,1) | 218 | 256 |
| (0,1,1) | (0,1,0) | 200 | 384 |
| (0,1,1) | (1,0,0) | 200 | 384 |
| (1,1,1) | (0,1,0) | 180 | 384 |
| (1,1,1) | (1,0,0) | 180 | 384 |
| (0,0,1) | (1,0,1) | 100 | 128 |
| (0,1,0) | (1,0,1) | 104 | 128 |
| (1,0,1) | (1,0,1) | 104 | 128 |
| (1,1,0) | (1,0,1) | 100 | 128 |
| **Total** | | **3.984** | 6.976 |

- (L5) elimina 2.992 polares e **nenhum par inteiro**. Em β_a = e₁ sobram 2.816 de 4.928.
- Como nenhuma classe cai por inteiro, não há combinação de equações por classe a extrair. A lista das polares compatíveis fica em `vivos_L5.pkl`, gerado por `poisson5.py`.

**Sonda em dimensão 3 [D para o enunciado, L para a contagem], `poisson3.py`.** Para V de dimensão 3 a mesma conta dá K̂ ∈ 16ℤ e, com r_z = b₂₃v₁ + b₁₃v₂ + b₁₂v₃ o radical de B_z|_V:

(L3) Σ_{z ⊇ I, posto(B_z|_V) = 2} (1 + D_{r_z} f(z, w₀)) ≡ 0 (mod 2), para |I| ≤ 1.

São 1.395 subespaços, 8 classes de w₀ e 7 escolhas de I. Numa amostra de 120 subespaços, somada a (L5), a classe a = (1,0,0), b = (0,0,1) passa de 218 para 170 polares compatíveis (de 256). (L3) acrescenta exclusões, mas a amostra não derruba a classe. O sistema completo (L3) não foi rodado: custa cerca de 20 segundos por polar nesta implementação.

## 4. O que não funcionou

- **Parseval por colunas** (Σ_{z : ω ∈ ℓ_z + Im B_z} 2^{−posto B_z} = 1) e suas somas sobre subespaços de ω: reduzem-se ao balanceamento das derivadas D_v f e dependem de λ; sem λ são triviais.
- **A mesma conta de Poisson num plano V_a**: dá κ_z ≡ 2β_a(z) (mod 4) e só condições automáticas.
- **Subespaços de dimensão 3**: a paridade obtida depende da fase.
- **Somas de h em classes de V_a** quando as fibras do mapa são invariantes por V_a: a soma numa classe é β_a(z), mas as equações de ordem baixa ficam triviais em paridade.

## 5. Lacuna exata

1. **Os 15 pares** continuam todos vivos, agora com 3.984 polares compatíveis com (L5). Em β_a = e₁ são 2.816 de 4.928.
2. **Próximos sistemas lineares.** (L3) completo sobre as 3.984 polares, junto com (L5). Depois disso, o que sobrar depende de condições quadráticas na parte afim em w (o bit J do 4-flat) ou das fases.
3. **Cruzamento com a execução de referência.** Não foi feito: os artefatos das 49 tarefas de fase e das 452 órbitas de mapas não estão acessíveis a esta sessão, que não executa o código do repositório. A tabela da seção 3a usa só a base independente.
4. **(H0)** tem agora a prova de Codex (seção 1a), não reconferida aqui.
5. A identidade pedida entre as duas derivadas e os momentos das fibras do mapa não foi encontrada; (Pf4) e (L5) ligam as derivadas pela polar e pela parte afim em w, sem passar pelos momentos das fibras.

## Arquivos

- `base12.py`: espaço RS, subespaço de grau ≤ 2 em w, polares (grava `base12.pkl`).
- `betas.py`: Proposição 1. `testemunhas12.py`: classes e postos nas testemunhas.
- `pfaffiano.py`, `pfaffiano_ab.py`: Corolário 4 (cerca de um minuto cada).
- `verifica_pf4.py`: controles. `orbitas_ab.py`: simetrias.
- `poisson5.py`: Teorema 5; `python poisson5.py controle <testemunhas.json>` e `python poisson5.py polares` (cerca de 25 minutos, grava `vivos_L5.pkl`).
- `poisson3.py`: sonda (L3) numa classe, depois de `poisson5.py polares`.
- As testemunhas são `lower-dim-family-witnesses.json` da pasta do repositório.

# Passos algébricos: o lema Γ e a redução de (Pf4) (n = 12, grau ≤ 4)

Data: 15/11/2026. Scripts: `lema_gamma.py`, `pf4_estrutura.py`, `pf4_assinaturas.py`, `pf4_produto.py`.

## 1. Lema Γ (provado)
Seja Γ o grupo gerado por:
- as matrizes circulantes invertíveis x ↦ c·x, as unidades de F₂[X]/(X¹² − 1), que são 1.536;
- as trocas i ↦ k·i, com k ∈ {5, 7, 11}.

**Enunciado.** Seja V o modelo (RS de grau ≤ 4, quadráticas em w; dim 68) e K ⊂ V o núcleo das funções afins em w (polar nula; dim 43). Então, para todo γ ∈ Γ:
- **(i)** f ∈ V ⇒ f∘γ ∈ V;
- **(ii)** f ∈ K ⇒ f∘γ ∈ K.

Logo Γ age linearmente no espaço dos polares V/K ≅ F₂²⁵.

**Corolário.** f ↦ f∘γ é uma bijeção entre as funções bent de polar P e as de polar γP. Portanto ter ou não bent, e a contagem de bent, são constantes nas órbitas.

**Prova.**
- Cada γ é linear e invertível, então preserva o grau e a bentness. Como γ normaliza a rotação, também preserva RS.
- (i) e (ii) são afirmações lineares, então basta conferi-las nas bases de V e de K e num conjunto gerador. O conjunto gerador tem as trocas i ↦ 5i e i ↦ 7i e 6 unidades: X, 1+X+X³, 1+X²+X³, 1+X+X⁴, 1+X³+X⁴ e 1+X+X²+X³+X⁴, que geram as 1.536.
- Nessa base, "f∘γ é RS e tem grau ≤ 2 em w" e "f∘γ é afim em w" foram conferidos em todos os 68 + 43 vetores.

**Consequências conferidas:**
- as matrizes 25 × 25 dos geradores permutam os 18.816 polares de (Pf4);
- os 18.816 se dividem em **3.344 órbitas**: 56 de tamanho 1, 308 de tamanho 2, 1.424 de tamanho 4 e 1.556 de tamanho 8;
- os 72 polares bent formam 25 órbitas.

Basta, portanto, um certificado por órbita.

## 2. Redução algébrica de (Pf4)
Seja T o **topo** de uma polar B: a parte de grau 2 em z de cada B_ij(z). Ele é um elemento de Λ²W ⊗ Λ²Z.

**(a) As partes baixas são livres (à mão).** Pf_V(B_z) é soma de produtos de duas entradas de grau ≤ 2 em z. Os coeficientes de grau 4 só dependem dos topos das entradas, e os de grau 5 e 6 são nulos. Conferido: 18.816 = **1.176 topos × 16** partes baixas.

**(b) Os 651 subespaços se reduzem a 15 (à mão).** Pf(T|_V) = ⟨γ₂(T), v₁∧v₂∧v₃∧v₄⟩, em que γ₂ é o quadrado dividido. Isso é linear no 4-vetor de V, e os 4-vetores decomponíveis geram Λ⁴W. Logo

  **(Pf4) ⟺ γ₂(T) = 0 em Λ⁴W ⊗ Λ⁴Z**,

que são 15 × 15 = 225 quádricas no topo. As 9.726 condições sobre os 651 subespaços são combinações dessas 225. Isso explica por que a enumeração antiga, que usava só as 15 quádruplas coordenadas, já dava exatamente o conjunto certo.

**(c) Estrutura das soluções (computada):**
- os topos RS formam um espaço de dimensão 21, e as soluções geram um subespaço de dimensão 20;
- as 1.176 soluções são uma união de subespaços lineares (98 maximais, de dimensões 3 a 8);
- o posto de T varia de 0 a 13 entre as soluções;
- há **346 órbitas de Γ** nos topos;
- a assinatura de planos (a,b) não é invariante do topo, porque as partes baixas a mudam.

**(d) Não há separação em produto.** A polarização de γ₂ é β(T,T′) = T∧T′ e é não degenerada no espaço dos topos: o radical é 0 e o grafo de cruzamentos é conexo. Logo 1.176 = 24·49 não vem de uma decomposição A ⊕ B com β(A,B) = 0.

## 3. Lema da paridade dos radicais (`paridade_radicais.py`, `lema_paridade.py`)
Seja N_d = #{z : d ∈ rad B_z} e P_B(d) = N_d mod 2, uma função booleana de d ∈ F₂⁶.

**(a) À mão.** 1_{rad B_z}(d) = Π_{i=0}^{5} (1 + (B_z d)_i) tem grau posto(B_z) ≤ 4, logo deg P_B ≤ 4. Uma função não nula que se anula fora de 0 tem grau 6. Portanto

  **N_d é par para todo d ≠ 0 ⟺ P_B ≡ 0.**

**(b) À mão.** Para B_z de posto 4, a parte de grau 4 de Π(1 + (B_z d)_i) é o 4-vetor da imagem de B_z, isto é, γ₂(B_z). Logo a parte de grau 4 de P_B é Σ_z γ₂(B_z), que é justamente a soma de Pfaffianos de (Pf4) com I = ∅. **(Pf4) e o nível de paridade são partes da mesma identidade polinomial.**

**(c) Conferido nos 18.816 polares:**
- a parte de grau 3 de P_B também se anula em todos. Falta a prova à mão; a candidata natural é a família (Pf4) com |I| = 1;
- logo, em todos os polares, **P_B é uma forma quadrática em d**, ℓ(d) + q(d), porque P_B(0) = 64 mod 2 = 0;
- nos 9.088 polares com algum N_d ímpar, P_B tem grau 1 (2.752 polares) ou 2 (6.336);
- **um polar morre por paridade se e só se a sua forma quadrática P_B é não nula.** São 21 coeficientes, cada um polinomial na polar.

### Tentativa de prova do grau 3 (`grau3_teste.py`, `grau3_identidade.py`, `grau3_identidade_z.py`, `grau3_linear.py`)
**Reformulação.** O coeficiente de grau 3 de P_B na direção E (dim 3) é a_E = Σ_z q_E(B_z), com q_E(B) = [rad B ∩ E = 0]. Para B de posto 4, Pf_V(B) = [rad B ∩ V = 0], e (Pf4) diz que deg_z Pf_V(B_z) ≤ 3.

**O que foi testado:**
- **Sem (Pf4), o grau 3 não some:** em 366 de 400 polares aleatórios do modelo há parte de grau 3. Então a anulação vem de (Pf4), e não só da estrutura do modelo.
- **Não há identidade pontual simples.** Procurei q_E = Σ λ·Pf_V + R com todo termo de grau ≤ 5 em z, o que bastaria para a soma sobre z se anular:
  - com λ e R só nas entradas de B (deg λ ≤ 1, deg R ≤ 2), nas 18.880 matrizes alternadas de posto ≤ 4: não existe;
  - com λ e R dependendo também de z, nos 83.392 pares (z,B) com Bz = 0 (1.983 funções candidatas): também não existe.
- **Caso linear:** para B(z) com entradas lineares e B(z)·z = 0, que satisfaz (Pf4) automaticamente, as partes de grau 3 e 4 se anulam sempre (300 de 300 amostras).

**Estado.** A anulação do grau 3 está conferida nos 18.816 polares, mas **não está provada à mão**. Ela não segue de uma identidade pontual com multiplicadores de grau baixo. Deve usar ou a equivariância RS de B(z), ou termos cúbicos cujo topo em z se reduz por γ₂(T) = 0. Fica como lema conferido.

## 3b. Caso homogêneo (H12): medição e mecanismo (`mede_homogeneo.py`, `homog_L5L3_motivo.py`; GitHub run 43756856424)
**Dimensões.** As quárticas RS homogêneas no modelo formam um espaço de dimensão 41. A polar delas é só o topo, e ocupa o espaço de topos inteiro (dim 21). A fase homogênea tem dimensão 20. Os 1.176 topos de γ₂(T) = 0 aparecem todos, em 545 órbitas de Γ.

**Como morrem os 1.176:**
- (L5)+(L3): 1.006 polares. Desses, 726 morrem por uma única equação sem fase (646 delas são de (L3) com |I| = 1), e 280 por combinações de 2 a 12 equações.
- Paridade: 74. Mod 4: 73. Resíduo mod 8, 16 ou 64: 17.
- Sobram 6: o polar nulo e mais 5.

**O polar nulo morre à mão.** A homogênea é f = λ(z)·w + h(z), com λ cúbica homogênea. Uma cúbica homogênea anula todo z de peso ≤ 2, então λ não é injetora e, por Maiorana–McFarland, f não é bent.

**Por que tantas equações perdem a fase.**
- Em (L3), o radical de B_z|_V é r_z = b₂₃v₁ + b₁₃v₂ + b₁₂v₃. Ele é linear em B, logo quadrático homogêneo em z.
- Com λ cúbica homogênea, λ(z)·r_z é homogêneo de grau 5.
- A soma num subcubo {z ⊇ {i}}, de dimensão 5, só lê o coeficiente de z_{[6]∖i} em λ·r_z.
- Quando esse coeficiente é nulo, a equação vira uma condição só da polar.
- Em (L5), as equações com w₀ = 0 e w₀ = w₁ ∉ V têm a mesma parte de fase. A soma das duas dá a condição só da polar Σ_{z⊇I, z∈Z_V} B_z(w₁, r_z) ≡ 0, que vale para qualquer bent.

**Os 5 polares especiais morrem pela família S** (`homog_especiais.py`, GitHub run 43759496977, `homog_especiais_out/`).

Cada certificado fica dentro da fase homogênea restante e foi conferido pelo verificador independente:

| Polar | dim da fase | Nós | Folhas |
|---|---:|---:|---|
| 124812481248 | 14 | 1 | 1 `const` (S_d constante igual a ±64) |
| d4e871b24d8e | 18 | 5 | 2 `const`, 1 `lin` |
| 142841824182 | 18 | 11 | 4 `const`, 2 `lin` |
| 124821844812 | 17 | 13 | 6 `const`, 1 `lin` |
| c0c030300c0c | 18 | 127 | 16 `const`, 48 `lin` |
| polar nulo (controle) | 20 | 403 | já morto à mão por Maiorana–McFarland |

Só a família S foi usada, isto é, Parseval nas 64 colunas, sem W nem F. Os quatro primeiros têm árvores de no máximo 13 nós, o que é conferível à mão. O de 127 nós ainda pede organização para caber à mão.

**O que isso NÃO resolve.** As condições só da polar ainda precisam ser avaliadas em cada um dos 1.176 topos, e a lista dos topos (as soluções de γ₂(T) = 0) continua computacional. Os 5 polares especiais também não foram tratados. **O H12 não está fechado à mão.** O que existe é uma redução estrutural mais uma tabela por órbita.

## 4. O que isso muda no mapa da prova
| Elo | Antes | Agora |
|---|---|---|
| Γ age nos polares, e morte e contagens são constantes nas órbitas | conferido por máquina | **lema provado**, com conferência linear finita em 8 geradores |
| (Pf4): de quantas condições se precisa | 9.726 quádricas, 25 variáveis | **225 quádricas γ₂(T) = 0 em 21 variáveis** (à mão) |
| partes baixas | enumeradas | **livres** (à mão) |
| as 1.176 soluções de γ₂(T) = 0 | árvore | árvore, ou 346 casos de órbita; **ainda não há prova à mão** |
| nível de paridade (N_d ímpar): 9.088 polares | um certificado por polar | **um critério:** P_B ≠ 0, com P_B quadrática em d. Graus 4 e 3 nulos: o grau 4 à mão, o grau 3 conferido |

O passo restante de (Pf4), contar as soluções de γ₂(T) = 0 no espaço RS de Λ²W ⊗ Λ²Z, exige uma teoria estrutural: por exemplo, decompor o espaço sob a rotação, via F₂[X]/(X⁶ − 1) ≅ F₂[u]/(u²) × F₄[v]/(v²). Não é um passo curto.

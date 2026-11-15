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

## 3. O que isso muda no mapa da prova
| Elo | Antes | Agora |
|---|---|---|
| Γ age nos polares, e morte e contagens são constantes nas órbitas | conferido por máquina | **lema provado**, com conferência linear finita em 8 geradores |
| (Pf4): de quantas condições se precisa | 9.726 quádricas, 25 variáveis | **225 quádricas γ₂(T) = 0 em 21 variáveis** (à mão) |
| partes baixas | enumeradas | **livres** (à mão) |
| as 1.176 soluções de γ₂(T) = 0 | árvore | árvore, ou 346 casos de órbita; **ainda não há prova à mão** |

O passo restante de (Pf4), contar as soluções de γ₂(T) = 0 no espaço RS de Λ²W ⊗ Λ²Z, exige uma teoria estrutural: por exemplo, decompor o espaço sob a rotação, via F₂[X]/(X⁶ − 1) ≅ F₂[u]/(u²) × F₄[v]/(v²). Não é um passo curto.

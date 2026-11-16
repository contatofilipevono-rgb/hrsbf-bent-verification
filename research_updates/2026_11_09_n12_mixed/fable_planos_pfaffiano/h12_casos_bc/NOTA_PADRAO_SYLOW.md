# Padrão geral: localização de Sylow

Data: 15/11/2026. Complemento de `NOTA_H12_CASOS_BC.md`. Testes: Lema 9 de `teste_lemas_bc.py`. Scripts: `pf4_estabilizador.py`, `sd_mod4_r3.py`, `sylow_localizacao.py`, `varredura_localizada.py`, `perfil_posto_bent.py`.

## Enunciado
Seja P um ℓ-subgrupo da rotação, e X um conjunto com sinal s invariantes por P. Então

  Σ_{x ∈ X} s(x) ≡ Σ_{x ∈ X, |P·x| < ℓ^k} s(x)·[peso da órbita] (mod ℓ^k).

As órbitas livres somam múltiplos de ℓ^k e somem. O argumento é clássico (contagem por órbitas).

**O que esta nota observa:** tudo o que foi provado à mão no projeto é uma instância disso, e as condições "simples" são exatamente as indexadas por objetos com estabilizador não trivial.

Em n = 12, a rotação age em x por Z₁₂ = Z₄ × Z₃ e nas linhas z por Z₆ = Z₂ × Z₃:
- **parte 2:** ⟨R³⟩, com σ = R⁶ dentro;
- **parte 3:** ⟨R⁴⟩ em x, ⟨R²⟩ em z.

## Evidência
**Resultados anteriores que são instâncias:**

| Resultado | Subgrupo | Pontos fixos usados |
|---|---|---|
| Artigo antipodal, Lema 2 do Fable, thm:apar | σ (ordem 2, em x) | diagonal U |
| Lema 1 do Fable (três Q_S) | σ | 8-conjuntos S = J ∪ (J+6) |
| Lema 3 do Fable (linha 63) | Z₆ inteiro | z = 63 |
| Técnica 2 e redução em grupos ímpares | parte ímpar | palavras periódicas |
| Técnica 39, g(0) + g(1) ≡ n/2 | Z_n inteiro | órbitas de tamanho ímpar |
| Lema 6 (N₆₃ por pontos fixos) | ⟨R³⟩ nas linhas | z ∈ {0, 9, 27, 63} |

**Previsões conferidas (simples ⇔ estabilizador não trivial):**

| Família | Índice com estabilizador | Índice livre |
|---|---|---|
| (Pf4) (V,J) | 9 pares fixos por R³ e 12 diagonais V = J (σ): fixado o caso (u₃₀, u₄₀, u₄₂), ficam constantes ou lineares | 216 pares: 14 a 30 monômios, quase todos quadráticos; continuam quadráticas em todo caso |
| Paridade P(d) | d ∈ Fix(R³) = {9, 27, 63}: grau 2 ou nulo | demais d: grau 4, de 1.800 a 3.600 monômios |
| Fase vista pela linha z | estabilizador não trivial: posto 0 a 2 (0, 63: 0; 21: 1; 9, 27: 2) | órbitas livres: posto 3 a 5 |

## Consequências novas (Lema 9, conferido em 200 funções aleatórias do modelo)
- **(2a)** Para d ∈ Fix(R³): S_d ≡ N_d − 2·#{z ∈ Fix(R³) : B_z d = 0, f(z,d) + f(z,0) = 1} (mod 4). Só as 8 linhas fixas por R³ entram, com 6 bits de fase.
  - *Prova:* z ↦ R³z preserva {z : B_z d = 0} e o sinal (porque R³d = d e D_d f(z,·) é constante nesse conjunto). As órbitas têm tamanho 1 ou 2, e cada par vale ±2 ≡ 2 (mod 4).
- **(3a)** Para d ∈ Fix(R²) = {21, 42, 63}: S_d ≡ soma só sobre z ∈ {0, 21, 42, 63} (mod 3). As órbitas fora dessas linhas têm tamanho 3.
- Como S_d = 0 (Parseval nas colunas), ambas viram condições com poucos bits de fase.

**Força, dentro de (Pf4):**
- (3a) mata **todo o caso A** (480 polares), o que é uma segunda prova do Lema 4.
- (2a) mata os 4 últimos de C(1,1), de modo que o caso C fecha com (Pf4) + 8 linhas + paridade + (2a).
- (2a) também mata 28 dos 94 de B(1,1), restando 66.

**Força sem (Pf4)** (varredura dos 2¹⁸ polares de cada caso, `varredura_localizada.py`):

| Subcaso | 8 linhas + paridade em d ∈ {9,27,63} + (2a) + (3a) | + paridade em todo d | + (Pf4) |
|---|---:|---:|---:|
| C(1,1) | 5.808 | 186 | 0 |
| B(1,1) | 4.976 | 334 | 66 |

## Leitura
- A localização explica por que certas condições saem à mão e prevê condições novas que funcionam.
- Mas a informação decisiva está nas **órbitas livres**: as 204 quádricas genéricas de (Pf4) e as linhas (L3) com índice livre. Sem elas sobram milhares de polares.
- Nas linhas a profundidade é só mod 4 (Z₂) e mod 3 (Z₃). Os 66 polares restantes de B(1,1) são invisíveis a toda condição localizada.
- Isso explica por que B(1,1) resiste a argumentos de simetria: uma prova à mão terá de usar um argumento que não venha de pontos fixos.

**Hipótese refutada no caminho:** "polar bent ⇒ todas as linhas com posto ≤ 2". É falsa: 36 dos 72 polares bent têm linhas de posto 4 (perfil típico 0:1, 2:7, 4:56).

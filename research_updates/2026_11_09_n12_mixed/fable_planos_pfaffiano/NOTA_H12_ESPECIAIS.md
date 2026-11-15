# H12: os polares especiais do caso homogêneo, em argumentos

Data: 15/11/2026. Dados: `homog_especiais_out/` (certificados verificados) e `explica_especiais.py` (leitura dos certificados).

## Ferramenta comum
Seja f uma RS bent homogênea quártica. Pelas relações universais, f é quadrática em w: f(z,w) = h(z) + λ(z)·w + q_z(w), onde q_z é a forma quadrática de polar B_z. Para d ≠ 0, seja Z_d = {z : B_z d = 0} e N_d = |Z_d|.

**Lema (Parseval nas 64 colunas, `NOTA_AUTOCORRELACAO.md`).** Se f é bent, então para todo d ≠ 0

  S_d := Σ_{z∈Z_d} (−1)^{D_d f(z,0)} = 0, com D_d f(z,0) = f(z,d) + f(z,0) = λ(z)·d + q_z(d).

**Consequência de paridade.** Como S_d = N_d − 2·#{z ∈ Z_d : D_d f(z,0) = 1}, a condição S_d = 0 dá

  Σ_{z∈Z_d} D_d f(z,0) ≡ N_d/2 (mod 2).

Isso é uma equação linear na fase (λ, h).

**Folha "constante".** Se, depois de impostas as equações de paridade, os termos de S_d que dependem da fase se cancelam aos pares, isto é, cada forma ℓ aparece tantas vezes com sinal + quanto com sinal −, então S_d é uma constante. Se essa constante é não nula, f não é bent.

## Polar 124812481248…: prova completa (certificado de 1 nó)
**Dados:**
- B_z tem posto 0 em 28 pontos z e posto 2 em 36.
- d = 63 = (1,1,1,1,1,1) satisfaz B_z·63 = 0 para todo z, logo N₆₃ = 64.
- A fase homogênea que sobra depois de (L5)+(L3) tem dimensão 14.

**Argumento:**
1. Impomos as equações de paridade de S_d = 0 para d ∈ {1, 5, 7, 9, 11, 13, 21}. A parte afim do seu span tem posto 3, e a fase cai de 14 para 11 dimensões.
2. Nesse subespaço, D₆₃f(z,0) = 0 para todos os 64 valores de z. Então S₆₃ = Σ_z (−1)⁰ = 64 ≠ 0, contra o Lema.
3. Logo nenhuma quártica homogênea com esta polar é bent. ∎

**Reformulação mais conceitual.** e(z) := D₆₃f(z,0) é uma função de grau ≤ 3 em z ∈ F₂⁶, e S₆₃ = 64 − 2·wt(e). A coluna exige que e seja balanceada. As 7 equações de paridade forçam e ≡ 0. Para virar uma prova sem nenhuma álgebra linear em coordenadas, falta escrever essas 7 equações como condições sobre e.

## Polares d4e871… (5 nós), 142841… (11 nós) e 124821… (12 nós)
Mesmo esquema: equações de paridade, alguns cortes por um funcional φ (casos φ = 0 e φ = 1) e folhas.

| Polar | Perfil de posto de B_z | Fase | Cortes | Folhas `const` | Folhas `lin` |
|---|---|---:|---:|---:|---:|
| d4e871… | 0:8, 2:56 | 18 | 2 | 2 | 1 |
| 142841… | 0:40, 2:24 | 18 | 5 | 4 | 2 |
| 124821… | 0:48, 2:16 | 17 | 6 | 6 | 1 |

**Exemplos de folhas `const`, todas com os termos de fase cancelados aos pares:**
- d4e871…, d = 1 (N = 16): formas 0 ×11, ℓ ×1, 1 ×3, 1+ℓ ×1, logo S₁ = 11 − 3 + 0 = **8**.
- 142841…, d = 21 (N = 40): 0 ×21, ℓ ×3, 1 ×13, 1+ℓ ×3, logo S₂₁ = 21 − 13 = **8**; no ramo simétrico, **−8**.
- 124821…, d = 9 (N = 48): 0 ×28, ℓ ×4, 1 ×12, 1+ℓ ×4, logo S₉ = 28 − 12 = **16**.
- 124821…, d = 1 (N = 48): 0 ×28, 1 ×12, e três formas com fase canceladas aos pares, logo S₁ = **16**.

**Folhas `lin`:** uma combinação dos bits de paridade de 2 a 5 direções (por exemplo {21, 63} ou {3, 5, 7, 9}) dá 0 = 1.

**Estado:**
- os certificados são pequenos e verificados;
- cada passo é uma conta finita que dá para fazer à mão;
- falta reescrever as restrições intermediárias, que hoje estão numa base arbitrária da fase homogênea, nos coeficientes de órbita t_j. Só então isso vira um texto legível sem computador.

## Polar c0c030… (127 nós)
Só a família S foi usada (16 folhas `const` e 48 `lin`). Precisa ser reorganizado, por exemplo com a simetria Γ ou escolhendo melhor os cortes, antes de caber à mão.

## Situação do H12 sem computador
- **Feito à mão:** a redução (relações universais, γ₂(T) = 0, homogeneidade ⇒ polar só de topo), o polar nulo (Maiorana–McFarland) e o polar 124812….
- **Conferível à mão, falta escrever:** 3 polares especiais (5, 11 e 12 nós).
- **Computacional:** a lista dos 1.176 topos, os níveis simples um topo de cada vez, e o polar c0c030… (127 nós).

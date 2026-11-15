# H12: os polares especiais do caso homogêneo, em argumentos

Data: 15/11/2026. Dados: `homog_especiais_out/` (certificados verificados) e `explica_especiais.py` (leitura dos certificados).

## Atualização (16/11): as linhas fixas resolvem todos os especiais
**Fato estrutural**, conferido nas 41 funções da base (`homog_baixo_peso.py`). Nas coordenadas (z,w), os monômios das quárticas homogêneas do modelo têm graus (z,w) ∈ {(0,2), (1,2), (2,1), (2,2), (3,1), (4,0)}. Logo, para z de peso ≤ 1, f(z,·) é uma forma quadrática pura em w, sem parte linear e sem constante.

Além disso, a fase homogênea é constante em w em exatamente 8 linhas: z = 0, z = e_i (i = 0, …, 5) e z = 63 (`homog_linhas_fixas.py`). Nessas linhas, |r_b(z)| = |Σ_w (−1)^{f(z,w) + b·w}| depende só da polar.

**Teste das 8 linhas (à mão, só da polar).** Parseval na coluna b exige Σ_z r_b(z)² = 4.096. Se, para algum b, as 8 linhas fixas somam mais que 4.096, o polar não tem bent homogênea. Cada linha contribui 2^{12 − posto B_z} nas colunas b em que está ativa, isto é:
- 4.096 se B_z tem posto 0;
- 1.024 se tem posto 2;
- 256 se tem posto 4.

**Resultado:**
- o teste mata **788 dos 1.176** polares candidatos: 648 já com as 7 linhas de peso ≤ 1, e mais 140 com z = 63;
- **os 6 polares especiais estão entre eles**, inclusive o polar nulo e o c0c030… de 127 nós. Nenhum deles precisa mais de árvore.

### O funil do H12 depois desta volta (`homog_resto.py`)
| Critério | Depende da fase? | Polares | Acumulado |
|---|---|---:|---:|
| 8 linhas fixas excedem 4.096 numa coluna | não | 788 | 788 |
| paridade: algum N_d ímpar, logo S_d ≠ 0 | não | 290 | 1.078 |
| sistema linear de (L5)+(L3) na fase homogênea | sim (linear) | 95 | 1.173 |
| níveis mod 4 ou resíduo | sim | 3 | 1.176 |

**92% dos candidatos (1.078) morrem por critérios que dependem só da polar e se conferem por conta curta.** O que ainda impede a prova à mão:
- a lista dos 1.176 candidatos, isto é, as soluções de γ₂(T) = 0 combinadas com a homogeneidade;
- a aplicação dos critérios polar a polar: são contas curtas, mas são 1.176 (ou as órbitas de Γ correspondentes);
- os 98 casos que precisam da fase.

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

**Argumento** (em coeficientes de órbita, f = Σ_j t_j O_j; texto completo em `texto_124812481248.md`):
1. A fase homogênea depois de (L5)+(L3) tem coeficientes livres t0, …, t11, t16, t33.
2. Para d ∈ {1, 5, 7, 9, 11, 13, 21}, S_d ≡ 0 (mod 4) vale sempre. A condição S_d = 0 exige também o bit seguinte, S_d ≡ 0 (mod 8), que é uma forma quadrática em t (nível k0 = 2). **Não são equações de paridade simples.** A parte afim do span dessas 7 quadráticas dá três equações lineares: t11 + t16 = 0, t2 + t4 + t6 + t33 = 0 e t1 + t2 + t3 + t4 + t5 + t6 + t7 = 0.
3. Com essas equações, D₆₃f(z,0) = Σ_j t_j·c_j(z,63) = 0 para os 64 valores de z, onde c_j(z,d) = O_j(x(z,d)) + O_j(x(z,0)). Então S₆₃ = 64 ≠ 0, contra o Lema. ∎

Para conferir à mão: avaliar as somas de órbita O_j em x(z,63) e x(z,0) para os 64 valores de z, e mostrar que a combinação das 7 quadráticas é afim, com os termos quadráticos cancelando.

**Reformulação mais conceitual.** e(z) := D₆₃f(z,0) é uma função de grau ≤ 3 em z ∈ F₂⁶, e S₆₃ = 64 − 2·wt(e). A coluna exige que e seja balanceada. As 7 condições mod 8 forçam e ≡ 0. Para virar uma prova sem nenhuma álgebra linear em coordenadas, falta escrever essas 7 equações como condições sobre e.

## Polares d4e871… (5 nós), 142841… (11 nós) e 124821… (13 nós)
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

### Os três polares reescritos em t
Os textos completos estão em `texto_d4e871b24d8e.md`, `texto_142841824182.md` e `texto_124821844812.md` (gerados por `explica_t.py` a partir dos certificados verificados). Para cada polar, eles dão:
- os coeficientes livres da fase homogênea;
- cada corte, como uma equação linear em t;
- cada restrição, como as equações lineares que ela produz, com o nível k0 das somas S_d usadas;
- cada folha, como a lista das formas D_d f(z,0), com a multiplicidade de cada uma.

**Como conferir:**
- **Folhas:** por contagem. Em 10 das 13 folhas `const`, os termos com fase cancelam aos pares e S_d é uma constante não nula: 8, −8, 16, 24 ou 64. Nas outras 3, S_d ≡ 2^{k0} (mod 2^{k0+1}) em todo ponto: S₉ ≡ 8 (mod 16) duas vezes e S₅ ≡ 4 (mod 8).
- **Restrições:** quase todas vêm de k0 = 2. Algumas vêm de k0 = 3, 4 ou 5, isto é, de bits de S_d acima da paridade, que são quadráticos ou de grau maior em t. Conferir uma restrição à mão exige refazer a combinação dessas formas em que os termos de grau ≥ 2 cancelam. É explícito e finito, mas trabalhoso. Esse é o ponto que ainda não está "elegante".

## Polar c0c030… (127 nós)
Só a família S foi usada (16 folhas `const` e 48 `lin`). Precisa ser reorganizado, por exemplo com a simetria Γ ou escolhendo melhor os cortes, antes de caber à mão.

## Situação do H12 sem computador
- **Feito à mão:** a redução (relações universais e (Pf4) ⇔ γ₂(T) = 0; a homogeneidade NÃO torna a polar só de topo, correção de 16/11), o polar nulo (Maiorana–McFarland, porque λ se anula em z de peso ≤ 1) e o polar 124812….
- **Conferível à mão, falta escrever:** 3 polares especiais (5, 11 e 13 nós).
- **Computacional:** a lista dos 1.176 topos, os níveis simples um topo de cada vez, e o polar c0c030… (127 nós).

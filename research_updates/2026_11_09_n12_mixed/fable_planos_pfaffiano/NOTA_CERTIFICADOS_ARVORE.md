# Certificados por árvore para os 140 polares mortos por busca (n = 12, grau ≤ 4)

Data: 15/11/2026. Ramo `claude/n12-parseval-certificados`.

## Ponto de partida
Em `NOTA_ESPACO_POLAR_INTEIRO.md`, 140 dos 212 polares abertos morreram só por execução de programas:
- 85 pelo funil (Poisson + sistema quadrático + Walsh);
- 48 pelo Parseval exato nas 64 colunas;
- 7 pela busca por padrões.

Esta nota troca essas buscas por **certificados verificáveis**: uma árvore de subespaços afins do espaço de fase U, em que cada folha morre por uma conta de álgebra linear sobre F₂.

## O lema do bit mais baixo
Seja C(y) uma soma de caracteres no subespaço y = p + span(Q), com dim Q = D, e escreva f_y = T + Σ tᵢKᵢ. Como (−1)^{Σ tᵢKᵢ} = Π(1 − 2tᵢKᵢ), vale a expansão exata em {0,1}^D:

  C(t) = Σ_J (−2)^{|J|} N_J t^J,  com N_J = Σ_x w_x (−1)^{T(x)} Π_{i∈J} Kᵢ(x).

Seja k₀ = min_J (|J| + v₂(N_J)). Então

  **C ≡ 2^{k₀}·P(t) (mod 2^{k₀+1})**, com P = Σ_{J : |J| + v₂N_J = k₀} t^J ∈ F₂[t].

Prova: os termos com |J| + v₂N_J > k₀ somem módulo 2^{k₀+1}; os outros valem 2^{k₀}·ímpar·t^J.

Consequência: se a bentness força C ≡ 0 mod 2^t e k₀ < t, então **P(y) = 0** em todo ponto bent. Calcular só os monômios com |J| ≤ c já dá o P exato quando k₀ ≤ c ou c ≥ D.

Não há hipótese de grau. Os termos cúbicos dos bits de Poisson nos 4-flats são calculados e conferidos: eles somem de fato. Isso confirma a afirmação "grau ≤ 2" de `bitj.py`, que antes só tinha sido testada em pontos aleatórios.

## As três famílias de somas
| Família | Soma C(y) | Condição forçada pela bentness | Custo |
|---|---|---|---|
| **S** | S_d = Σ_{z : d ∈ rad B_z} (−1)^{g + L_zd(y)} | S_d = 0, para d ≠ 0 (Parseval nas 64 colunas, `NOTA_AUTOCORRELACAO.md`) | desprezível |
| **W** | W_{f_y}(u,b) − 64 | ≡ 0 mod 128 (cada Walsh vale ±64) | 4.096 somas; 2 produtos 64×64 por monômio |
| **F** | Σ_{z ⊇ I, s ∈ V} (−1)^{f_y(z,w₀+s) + ω·s}, V de dimensão 4 | ≡ 0 mod 2^{5−|I|}, com \|I\| ≤ 1 (Poisson em V^⊥) | 291.648 somas |

## A árvore
Em cada nó (subespaço):
1. as restrições herdadas dos ancestrais são reaproveitadas por substituição (P = 0 continua valendo como função);
2. depois vêm S, W e F, nesta ordem e só se necessário.

A partir dos polinômios P:
- **folha `const`:** algum P ≡ 1;
- **folha `lin`:** 1 está no F₂-span dos P (linearização: cada monômio vira uma incógnita);
- **passo de restrição:** a parte afim do span corta o subespaço;
- **ramificação:** caso contrário, o nó se divide em φ·y = 0 e φ·y = 1.

A forma φ escolhida é a forma de ativação L_zd mais frequente nas quadráticas S. Há também uma variante "forte", que testa 8 candidatas olhando um passo à frente. Ramificar por forma em vez de coordenada reduziu um piloto de 2.049 para 145 nós.

Todas as checagens são invariantes por mudança afim de coordenadas. Por isso o certificado guarda só:
- as referências das somas (`["S", d]`, `["W", u, b]`, `["F", p, q, ω, w₀, I]`);
- as formas de ramificação;
- os tipos de folha.

## Verificadores independentes
`verifica_arvore.py` (formato sem herança) e `verifica_arvore3.py` (com herança) foram escritos de forma independente do provador:
- avaliam cada soma diretamente sobre os seus pontos, sem transformadas;
- fazem a eliminação gaussiana com numpy;
- transportam as restrições herdadas resolvendo x₀ = x₀ₑ + t₀Bₑ e B = MBₑ, e substituindo; se o subespaço atual não estiver contido no do evento, o certificado é recusado.

Testes:
- **negativos** (`teste_negativo_arvore.py`): os certificados adulterados são recusados;
- **família W** (`teste_famW.py`): C ≡ 2^{k₀}P mod 2^{k₀+1} em pontos aleatórios, com 0 falhas, e concordância com o verificador;
- **família F** (`teste_fam2.py`): reproduz os 326 polinômios distintos do funil antigo.

## Resultado
**Os 140 polares têm certificado**, e o conjunto coincide exatamente com os mortos de `veredito212.json`. Arquivo: `certificados_arvore_140.json.gz`, com 109 árvores no formato sem herança e 31 no formato com herança.

| Origem do veredito antigo | Polares | Fecham na raiz | Mediana de nós | Máximo de nós |
|---|---:|---:|---:|---:|
| funil (Poisson + Walsh) | 84 | 65 | 1 | 73.727 |
| Parseval exato nas 64 colunas | 48 | 24 | 15 | 58.495 |
| busca por padrões | 6 | 0 | 769 | 10.009 |
| padrões + sistema quadrático (polar 5, `55aa…`) | 1 | 0 | 6.787 | 6.787 |
| funil fatiado completo (`8142…`) | 1 | 0 | 379.097 | 379.097 |

- Ao todo são 780.432 nós e 390.286 folhas: 242.747 `const`, 113.571 `lin` e 33.968 `affine`.
- O polar 5 era o caso mais pesado da busca antiga: 268 milhões de sobreviventes testados por Walsh. Ele fecha com 6.787 nós.
- O último polar (`8142…`) foi dividido em 26 subárvores na profundidade 10 e depois juntado (`merge_split.py`).
- **Verificação independente:** os 140 certificados passaram, com 0 falhas (24 lotes em paralelo; registro em `verificacao_arvore_140.log`). O certificado de 379.097 nós também foi verificado à parte, inteiro, com 0 falhas.
- **Testes negativos:** 38 adulterações, em três baterias, e 37 recusadas:
  - formato sem herança: 10 de 10;
  - formato com herança: 7 de 7 nos pilotos S e 20 de 21 em 6 certificados com a família W.

  A aceita tirava de uma folha `lin` uma referência redundante, e o certificado continuava válido.

## (L5)+(L3) verificadas de forma independente (`verifica_L5L3.py`)
As duas famílias lineares são somas de Poisson, como a família F.
- **(L5):** hiperplanos V = η^⊥, com dim V^⊥ = 1 e |I| ≤ 2. A bentness dá C ≡ 0 mod 16. Como todo K_z ≡ 0 mod 8, a condição é que o bit 3 de C seja 0.
- **(L3):** os 1.395 subespaços de dimensão 3, com dim V^⊥ = 3 e |I| ≤ 1. A bentness dá C ≡ 0 mod 8. Como todo K_z ≡ 0 mod 4, a condição é que o bit 2 de C seja 0.

Com a polar fixa, esses bits são afins na fase. Pelas somas de Gauss, a magnitude de K_z só depende da polar, e K_z/8 (ou K_z/4) é ímpar exatamente quando z está ativo, que é uma condição afim.

O verificador:
- soma K_z diretamente sobre os pontos de V, sem usar `poisson5.py` nem `poisson3.py`;
- interpola cada bit a partir de θ = 0 e dos 43 vetores unitários;
- confere a afinidade em pontos aleatórios;
- para cada um dos **18.816** polares de (Pf4) × partes baixas, ou mostra que o sistema é inconsistente (o polar morre), ou confere que o seu espaço solução U_ind está contido no U usado pelos certificados.

**Resultado:** os 18.816 polares foram conferidos sem nenhuma divergência (`verificacao_L5L3_18816.json.gz`).
- 14.284 morrem porque o sistema independente é inconsistente.
- Nos 4.532 vivos, U_ind ⊆ U, e as dimensões coincidem.

A conta fecha com a tabela anterior: 10.156 viáveis em (L5) − 5.624 mortos por (L5)+(L3) = 4.532.

## Contagens certificadas: folhas "toda bent"
- **Nova folha `allbent`:** num subespaço, se para os 4.096 pares (u,b) o polinômio de W(u,b) − 64 tem todos os monômios com |J| + v₂N_J ≥ 7, então W ≡ 64 mod 128 em todo ponto. Por Parseval, isso força |W| = 64, ou seja, todos os pontos do subespaço são bent.
- **Grau calculado:** os monômios vão até o grau min(6, D). Acima disso, |J| ≥ 7 vale sozinho.
- **Verificação:** o verificador refaz a conta com uma transformada de Walsh inteira em borboleta, um algoritmo diferente do provador.
- **Contagem:** as folhas são disjuntas, então a contagem de bent de um polar é a soma de 2^dim sobre as folhas `allbent`.

**Resultado:** os 71 polares bent não nulos têm contagem certificada, e as 71 coincidem com o catálogo. Ao todo são **19.216.384**. O verificador independente conferiu as 71 árvores sem falha (`certificados_bent71.json.gz`, `verificacao_bent71.log`).
- O maior caso, o polar 142841…, tem 10.485.760 bent em 1.052 folhas `allbent`, com 49.501 nós (17 subárvores juntadas).
- Os polares 3c3c55… e 7dbe41… dão 786.432 cada.
- Os polares 281414… e 699600… dão 655.360 cada.

## O polar nulo: Maiorana–McFarland e um censo (`censo_polar_nulo.py`)
Com polar nulo, f(z,w) = λ(z)·w + h(z).
- **Fórmula:** W_f(u,b) = 64·Σ_{z : λ(z) = b} (−1)^{h(z) + u·z}.
- **Critério:** Parseval em u numa fibra λ⁻¹(b) dá Σ_u W(u,b)² = 2^{18}·|λ⁻¹(b)|. Logo |W| = 64 para todo (u,b) se e só se toda fibra tem um ponto, ou seja, se e só se λ é bijetora, seja qual for h.
- **Dimensões:** o espaço de fase do polar nulo tem dimensão 43, e (L5)+(L3) são vazias. A projeção θ ↦ λ é linear, com imagem Λ de dimensão 31 e núcleo de dimensão 12, só com termos em h.
- **Contagem:** o número de bent é #{λ ∈ Λ bijetoras}·2^{12}.
- **Censo:** a varredura dos 2^{31} elementos de Λ usa o critério de que λ é bijetora se e só se as 63 combinações não nulas das coordenadas de saída são balanceadas. Resultado: **70.816** bijeções, logo **290.062.336** bent, igual à família da diagonal do `README`.

## As duas relações universais (`verifica_relacoes_universais.py`)
O modelo `base12` supõe que f é quadrática em w. Isso vem de `EXTERIOR_QUARTICO_N12.md`.
- **Necessidade do filtro:** para f bent e |S| = 8, o coeficiente inteiro de x^S em (−1)^f vale, pela fórmula do dual, 4·Σ_{v⊇S} (±1), com 16 parcelas, logo é ≡ 0 mod 8. Pela expansão Π(1 − 2x^m), o mesmo coeficiente é ≡ 4·#{pares de quárticos disjuntos com união S} mod 8. Daí as quádricas Q_S = 0 nos coeficientes de órbita t_j.
- **Certificado:** L₄₅₆ e L₄₆₄ estão no F₂-span de {Q_S, t_j·Q_S}.
- **Troca de coordenadas:** na troca x ↦ (z,w), os 135 monômios quárticos com pelo menos três w têm coeficiente 0 (87 deles), L₄₅₆ (24) ou L₄₆₄ (24).
- **Meia-volta:** ela mata os cúbicos puros em w.

O verificador novo refaz tudo isso do zero e confere.

## A enumeração dos polares (`pf4_cert.py`, `verifica_pf4_arvore.py`)
- **Origem de (Pf4):** κ_z = K_z/4 é ímpar exatamente quando B_z|_V é não degenerada. Então a condição de Poisson nos 4-flats, módulo 2, é Σ_{z⊇I} Pf_V(B_z) = 0, para os 651 subespaços V de dimensão 4 e |I| ≤ 2.
- **O sistema:** são quádricas nas 25 coordenadas da polar, ao todo 9.726 condições e 1.420 polinômios distintos.
- **Resultado:** uma árvore de 3.575 nós (1.077 folhas `lin` e 711 folhas de soluções) mostra que **as soluções são exatamente os 18.816 polares** de `polares_18816.txt`.
- **Verificação independente:** cada condição é avaliada diretamente pelo Pfaffiano e interpolada como forma quadrática. Ela confirmou a árvore e a igualdade dos conjuntos.

## Reprodução num ambiente limpo
O workflow `n12_verifica_certificados.yml` ([run 43713458745](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/43713458745)) refez tudo a partir do repositório, com 8 runners: reconstruiu `base12.pkl`, verificou as relações universais e a enumeração (Pf4), (L5)+(L3) nos 18.816 polares e os 140 certificados de árvore. Os 8 lotes foram aprovados.

## Estado da classificação (n = 12, RS, grau ≤ 4)
| Elo | Como está fechado |
|---|---|
| Toda RS bent de grau ≤ 4 é quadrática em w (modelo `base12`, 68 dimensões) | prova à mão (quadrado dividido + meia-volta) + verificador independente |
| Os polares possíveis são exatamente 18.816 | árvore (Pf4) + verificador independente |
| (L5)+(L3) em cada polar | verificador independente, direto das somas de Poisson |
| 10.084 polares sem bent | 9.944 certificados elementares + 140 certificados em árvore, todos verificados |
| 71 polares bent não nulos: 19.216.384 bent | árvores com folhas `allbent`, verificadas |
| polar nulo: 290.062.336 bent | Maiorana–McFarland (à mão) + censo de 2^{31} mapas |
| **total: 309.278.720 = 64 + 57.280 + 309.221.376** | igual ao catálogo, que só entra na comparação final |

**O que continua computacional:** o censo das 2^{31} bijeções do polar nulo e a execução dos verificadores. Cada passo dos verificadores é elementar: polinômios sobre F₂, eliminação gaussiana e a transformada de Walsh das folhas `allbent`. Não há busca. Falta uma auditoria externa (Codex) desta nota.

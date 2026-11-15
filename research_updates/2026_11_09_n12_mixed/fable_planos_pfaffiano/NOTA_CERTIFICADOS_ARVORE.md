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

Resultado: RESULT_L5L3.

## Contagens certificadas: folhas "toda bent"
- **Nova folha `allbent`:** num subespaço, se para os 4.096 pares (u,b) o polinômio de W(u,b) − 64 tem todos os monômios com |J| + v₂N_J ≥ 7, então W ≡ 64 mod 128 em todo ponto. Por Parseval, isso força |W| = 64, ou seja, todos os pontos do subespaço são bent.
- **Grau calculado:** os monômios vão até o grau min(6, D). Acima disso, |J| ≥ 7 vale sozinho.
- **Verificação:** o verificador refaz a conta com uma transformada de Walsh inteira em borboleta, um algoritmo diferente do provador.
- **Contagem:** as folhas são disjuntas, então a contagem de bent de um polar é a soma de 2^dim sobre as folhas `allbent`.

Resultado: RESULT_CONTAGEM.

## Dependências e o que ainda é computacional
- O modelo `base12`, a enumeração (Pf4) × partes baixas e a verificação de (L5)+(L3) polar a polar (as mesmas dos 9.944 certificados elementares).
- O polar nulo vem do teorema da diagonal.
- As **contagens** dos 71 polares bent não nulos ainda são enumeração (`contagem72.json`).
- Os certificados por árvore são verificados por máquina, mas cada passo é elementar (polinômios sobre F₂ e eliminação). Não há busca nem teste de Walsh ponto a ponto.

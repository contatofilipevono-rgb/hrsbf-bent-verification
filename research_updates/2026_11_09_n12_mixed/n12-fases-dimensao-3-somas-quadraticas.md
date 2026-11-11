# As fases do bloco de dimensão três em \(n=12\)

No bloco exclusivo de dimensão três, as congruências de fase dos 976 mapas candidatos se reduzem a 43 sistemas, um por órbita. Em 31 aparece a contradição \(1=0\). Nos 12 restantes, a eliminação afim deixa de uma a três equações quadráticas. Suas somas de Gauss dão exatamente **4.194.304** funções RS bent de grau quatro, com a mesma multiplicidade em cada mapa da contagem anterior.

## Das fibras às equações

Seja \(S\subseteq\mathbb F_2^9\) uma fibra de 64 pontos e \(h\) sua fase. Para a bentness do bloco, a transformada da fibra assinada deve ter módulo 8. Basta exigir que todos os coeficientes sejam \(8\bmod 16\). Isso força módulo pelo menos 8 e Parseval fixa a média dos quadrados em \(|S|=64\).

Para \(I\subseteq\{1,\ldots,9\}\), ponha \(S_I=\{x\in S:x_i=1\ \forall i\in I\}\) e \(w_I=|\{x\in S_I:h(x)=1\}|\). Expandindo \((-1)^{a\cdot x}=\prod_i(1-2a_ix_i)\), o coeficiente de \(\prod_{i\in I}a_i\) é \((-2)^{|I|}(|S_I|-2w_I)\). A expansão é única sobre \(\mathbb Z/16\mathbb Z\), por inversão de Möbius no cubo. Para \(I=\varnothing\) a congruência pede \(w_\varnothing\equiv4\bmod8\). Para \(|I|=1,2\) ela pede \(|S_I|\) par e \(w_I\equiv |S_I|/2\bmod 2^{3-|I|}\). Para \(|I|=3\) resta a paridade de \(|S_I|\).

Depois das condições lineares e do quociente pelas translações de fase afins em cada fibra, cada valor \(h(x)\) é uma função afim dos parâmetros livres. Para traduzir uma contagem \(w_I\) módulo 8, calculamos seus três bits no anel booleano. O bit \(j\) é o coeficiente de \(u^{2^j}\) em \(\prod_{x\in S_I}(1+h(x)u)\), avaliado nos parâmetros. Seu grau é no máximo \(2^j\). Assim o sistema pode começar com quartas, embora as quartas desapareçam por eliminação e substituição nos 43 representantes.

## Contagem por posto e sinal

Para \(q_1=\dots=q_k=0\) em \(d\) parâmetros, o número de soluções é
\[
2^{-k}\sum_{\lambda\in\mathbb F_2^k}\ \sum_{x\in\mathbb F_2^d}(-1)^{\sum_i\lambda_i q_i(x)}.
\]
Cada soma interna é calculada sem percorrer \(x\). Ao escrever a quadrática como \(xy+xA+yB+C\), a soma dos dois parâmetros elimina o par e produz \(2(-1)^{C+AB}\). Após eliminar todos os pares, um termo linear no radical zera a soma. Se restar uma constante, ela fixa o sinal, e a magnitude é \(2^{d-r/2}\), onde \(r\) é o posto polar.

Por exemplo, o mapa 225448085 tem duas quadráticas em 12 parâmetros. As quatro somas são \(4096,-1024,0,0\). Portanto há 768 soluções no quociente e \(768\cdot32=24.576\) fases no mapa.

| Representante | Mapas na órbita | Quadráticas | Fases por mapa |
| ---: | ---: | ---: | ---: |
| 1583330 | 32 | 3 | 12.288 |
| 225448085 | 32 | 2 | 24.576 |
| 225448170 | 32 | 3 | 12.288 |
| 225448212 | 32 | 2 | 24.576 |
| 225448239 | 16 | 2 | 32.768 |
| 447615148 | 16 | 2 | 16.384 |
| 447615179 | 16 | 1 | 8.192 |
| 447615748 | 16 | 1 | 8.192 |
| 447616407 | 16 | 1 | 8.192 |
| 447616496 | 16 | 2 | 16.384 |
| 447616600 | 16 | 1 | 8.192 |
| 447616730 | 16 | 1 | 16.384 |

## Cobertura e reprodução

O verificador refaz a preparação de fases a partir dos 97.530 suportes da execução anterior. Confere que os 976 mapas restantes são fechados pelos sete geradores usados na ação sobre os mapas, reduz o sistema de cada representante e compara as multiplicidades, inclusive os zeros, mapa a mapa. O JSON registra as órbitas, as quadráticas reduzidas e o posto e a soma de cada combinação. Em verificações separadas, comparei 288 somas quadráticas com contagem direta e a tradução das congruências em 1.312 avaliações de 41 sistemas.

A etapa de fases agora tem um cálculo algébrico finito por órbita. A lista inicial de suportes continua vindo da enumeração. O próximo alvo teórico é deduzir da geometria das fibras quais mapas podem chegar a esses sistemas.

Da pasta deste trabalho no repositório, com os artefatos extraídos, execute:

~~~sh
gh run download 42948057001 -R contatofilipevono-rgb/hrsbf-bent-verification -p 'lower-dim-phase-1-*' -D phase-artifacts
python lower_dim_v3_symbolic.py --summary lower-dim-v3-summary.json --artifacts phase-artifacts --work symbolic-work --output lower-dim-v3-symbolic.json
~~~

[Execução de referência no GitHub Actions](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42948057001)

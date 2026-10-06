# Quarta rodada Sol — núcleo diagonal de dimensão 7

Data: 6 de outubro de 2026.

## Teorema estrutural

Considere o espaço (\mathcal H_{16,5}) das funções Booleanas homogêneas de grau 5 simétricas por rotação em 16 variáveis. Sua dimensão é 273.

Escreva

[
x=(u,v),\qquad u,v\in\mathbb F_2^8,
]

e seja

[
a=(e_0,e_0).
]

Então

[
\ker\bigl(f\mapsto D_af\bigr)
=
\{,f(u,v)=h(u+v): h\in\mathcal H_{8,5},},
]

onde (\mathcal H_{8,5}) é o espaço das quínticas homogêneas RS em 8 variáveis.

Esse espaço tem dimensão 7. Consequentemente,

[
\operatorname{rank}(f\mapsto D_{(e_0,e_0)}f)=273-7=266.
]

### Prova

Se (D_{(e_0,e_0)}f=0), então (f) é invariante pela translação ((e_0,e_0)). Como (f) é simétrica por rotação, a mesma igualdade vale para todas as rotações dessa direção:

[
D_{(e_i,e_i)}f=0,qquad i=0,ldots,7.
]

Essas oito direções geram o subespaço diagonal

[
A=\{(p,p):p\in\mathbb F_2^8\}.
]

Logo (f) é constante nos cosets de (A) e existe uma função (h) tal que

[
f(u,v)=h(u+v).
]

Tomando (u=0),

[
h(z)=f(0,z).
]

A homogeneidade de grau 5 de (f) implica que (h) é homogênea de grau 5. A rotação de 16 coordenadas envia (u+v) para a rotação cíclica correspondente em 8 coordenadas, portanto (h) é RS.

Reciprocamente, se (h) é homogênea quíntica RS em 8 variáveis, então (h(u+v)) é homogênea de grau 5: cada monômio de (h) é produto de cinco fatores distintos (u_i+v_i), e sua expansão só contém monômios de grau 5. A rotação de 16 coordenadas apenas gira o vetor (u+v), logo o lift é RS. Ele é evidentemente invariante por ((p,p)).

Há sete órbitas quínticas RS em oito variáveis, fechando a dimensão do núcleo.

## Consequência para as condições necessárias

Se (k(u,v)=h(u+v)) pertence a esse núcleo, então na fibra

[
F_z(u)=f(u,u+z)
]

temos

[
(F+k)_z(u)=F_z(u)+h(z).
]

Ou seja, (k) apenas complementa a fibra inteira quando (h(z)=1).

Portanto:

1. a propriedade “(F_z) é balanceada” é invariável sob adição de (k);
2. todas as derivadas diagonais (D_{(p,p)}f) são invariáveis sob adição de (k).

Assim, **todos os testes de balanceamento de fibras e todas as 35 classes de derivadas diagonais fatoram por um quociente de dimensão 266**.

Os sete graus de liberdade do núcleo só podem ser distinguidos por derivadas não diagonais.

## Gauge canônico

O auditor constrói sete máscaras explícitas no espaço dos 273 coeficientes e fornece sete posições-pivô que podem ser zeradas para escolher um representante canônico de cada coset.

Isso permite que uma busca futura trabalhe em 266 bits efetivos, sem repetir 128 variantes indistinguíveis para os testes de fibras/derivadas diagonais.

## Próximo passo

Para um representante do quociente, restam somente (2^7=128) lifts possíveis.

Para uma direção geral ((a,b)), escrevendo (q=a+b),

[
D_{(a,b)}k = h(z)+h(z+q)=D_qh(z).
]

Esse termo depende apenas de (z), não de (u). Portanto as 128 variantes podem ser avaliadas simultaneamente por uma transformada de Walsh de comprimento 128 aplicada às contribuições por fibra.

A próxima ferramenta deve escolher **exatamente** o melhor dos 128 lifts segundo a energia de autocorrelação completa, sem busca heurística nesses sete bits.

## Status

- caracterização do núcleo: **prova algébrica**;
- dimensão 7 e posto 266: **prova + auditoria exata**;
- máscaras explícitas do núcleo: **certificado computacional reproduzível**;
- redução da busca 273 -> 266 + 7: **exata**;
- inexistência quíntica geral: **ainda aberta**.

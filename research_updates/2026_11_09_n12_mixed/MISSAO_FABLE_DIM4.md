# Missão para o Fable 5.2 — classificar as quárticas exteriores restantes

## Objetivo e escopo

Restam 8.730.624 funções RS bent de grau exatamente quatro em 12 variáveis fora das famílias já descritas. Ataque a classificação estrutural e a contagem independente do próximo bloco, formado pelas 4.227.072 funções cujo maior subespaço antipodal invariante de afinidade tem dimensão quatro.

A prioridade é um teorema reutilizável sobre fibras de 16 pontos, seguido de uma aplicação à compatibilidade global. As contagens do catálogo servem como controles.

## Dados estabelecidos

Nas coordenadas z=a+b, w=b, toda função em questão é quadrática em w, por duas identidades do topo e a meia-volta. O subespaço antipodal de dimensão seis é a diagonal inteira.

Se V é um subespaço de dimensão quatro no espaço w e f é afim nas suas classes, escreva

$$
f(y,u)=u\cdot\pi(y)+H(y),\qquad
y\in\mathbb F_2^8,\quad u\in\mathbb F_2^4.
$$

Bentness equivale a cada fibra P de pi ter 16 pontos e à função sinalizada (-1)^H em P ter Walsh de amplitude quatro em todas as frequências de F2^8.

Há dois subespaços invariantes de dimensão quatro. As máscaras abaixo representam vetores de seis bits, e a rotação desloca os índices por +1.

| Subespaço | Base de máscaras | Espaço RS afim em V | Dimensão de pi | Dimensão do núcleo de H | Exterior exclusivo, segundo catálogo |
|---|---|---:|---:|---:|---:|
| V1 | 7,14,28,56 | 52 | 33 | 19 | 1.900.544 |
| V2 | 5,10,20,40 | 52 | 31 | 21 | 2.326.528 |

V2 está no hiperplano U de vetores w com soma zero. V1 contém vetores de peso ímpar. Os dois casos contêm também as 10.485.760 funções do bloco U já classificado. Na parte exterior, segundo o catálogo, a interseção dos dois casos é precisamente esse bloco. Portanto as contagens novas precisam separar essa interseção.

A escolha de complemento de V usada no piloto acrescenta, em ordem, os primeiros vetores coordenados independentes à base indicada. Ordene as duas coordenadas do complemento antes das quatro coordenadas de V.

## Primeira missão — auditar um lema proposto

Para uma fibra P de 16 pontos distintos, forme o código binário C de comprimento 16 gerado pela constante e pelas avaliações das coordenadas em P. Seja k=dim C=1+dim afim P.

Proponho o seguinte critério exato, ainda sem auditoria independente.

**Lema proposto.** Existe uma escolha de 16 sinais em P com Walsh de amplitude quatro se e somente se C é auto-ortogonal e k≤7. Se C é auto-ortogonal, o número de escolhas de sinais é

$$
2^{15-k}-128.
$$

Como P tem 16 pontos distintos, os casos possíveis são

| Dimensão afim de P | k | Escolhas de sinais |
|---:|---:|---:|
| 4 | 5 | 896 |
| 5 | 6 | 384 |
| 6 | 7 | 128 |
| 7 | 8 | 0 |

Em particular, a dimensão afim máxima seria seis.

### Derivação para você auditar

Escreva os sinais como (-1)^h, com h em F2^16. A congruência de Walsh a quatro módulo oito, seguida de Parseval, é equivalente a

$$
C\subseteq C^\perp,\qquad
h\cdot c=\operatorname{wt}(c)/2\pmod2\quad(c\in C),\qquad
\operatorname{wt}(h)\equiv2\pmod4.
$$

A primeira condição vem dos momentos de ordem dois. Na segunda, wt(c)/2 é linear em C porque C é auto-ortogonal. A constante pertence a C, logo todas as soluções h da segunda condição têm peso par. Essas soluções formam um trasladado h0+Cperp, com 2^(16-k) elementos.

A identidade de Fourier no cubo de 16 bits é

$$
\sum_h i^{\operatorname{wt}(h)}(-1)^{c\cdot h}
=(1+i)^{16-\operatorname{wt}(c)}(1-i)^{\operatorname{wt}(c)}
=256\,i^{-\operatorname{wt}(c)}.
$$

Por projeção sobre o trasladado,

$$
\sum_{h\in h_0+C^\perp}(-1)^{\operatorname{wt}(h)/2}
=2^{-k}256\sum_{c\in C}
(-1)^{h_0\cdot c}i^{-\operatorname{wt}(c)}
=256.
$$

Assim o número com wt(h)≡2 mod4 é
(2^(16-k)-256)/2 = 2^(15-k)-128. Confirme todas as equivalências, inclusive a suficiência da congruência e o caso auto-dual k=8.

Se o lema for conhecido, procure a fonte primária apropriada. O vínculo com sombras de códigos auto-duais pode ajudar. Identifique o que é aplicação de literatura e o que foi deduzido aqui.

## Segunda missão — usar o lema nas funções globais

1. Classifique os suportes de 16 pontos que podem aparecer nas fibras de pi para V1 e V2, usando rotação, grau e o lema. Explore os códigos auto-ortogonais de comprimento 16 e posto 5, 6 ou 7, sem presumir que toda fibra seja um flat.
2. Determine quais estruturas são compatíveis com as restrições de grau de pi e com a ação da rotação nas fibras.
3. Resolva a compatibilidade das fases dentro do núcleo global de H, de dimensão 19 ou 21. O número de sinais permitido em uma fibra não pode ser multiplicado independentemente entre fibras, pois H é um único polinômio de grau até quatro.
4. Procure uma parametrização por famílias e uma contagem que reproduza os blocos exclusivos 1.900.544 e 2.326.528. Comece por V2 se precisar escolher, pois seu espaço de mapas tem dimensão 31.
5. Extraia um lema geral que também possa servir aos blocos de dimensão três e dois.

## Controles e entregas

- Distinguir resultados demonstrados, identidades de álgebra linear certificadas e observações de amostras.
- Produzir prova escrita do lema das fibras e um verificador independente pequeno.
- Salvar as formas canônicas, os parâmetros das famílias, as condições de fase e as contagens.
- Se houver testemunhos, reconstruir a ANF e conferir RS, grau e todos os 4.096 coeficientes de Walsh.
- Explicar qualquer diferença de convenção de índices antes de comparar contagens.
- Registrar parciais que realmente reduzam o problema, mesmo se a classificação completa não fechar.
- Salvar em pasta própria de pesquisa no repositório. Não editar ESTADO.md nem resultados/.

Os 4.194.304 casos de dimensão máxima três e os 309.248 de dimensão dois completam as 8.730.624 funções restantes. A missão imediata é obter uma estrutura que avance primeiro nas 4.227.072 de dimensão quatro.

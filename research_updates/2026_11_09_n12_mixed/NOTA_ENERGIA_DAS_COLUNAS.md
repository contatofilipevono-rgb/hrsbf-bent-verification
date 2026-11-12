# Cobertura por dois planos via energia de colunas de Walsh

Seja \(f(z,w)\) uma função bent, com \(z,w\in\mathbb F_2^6\), quadrática em \(w\). Para cada \(z\), escreva \(B_z\) para a polar de \(f(z,\cdot)\) e \(R_z=\ker B_z\). Na coluna \(\beta\), a transformada parcial é \(A(z,\beta)=\sum_w(-1)^{f(z,w)+\beta\cdot w}\).

Ao expandir \(A^2\), agrupe os pares \(w,w+v\) por \(v\). A soma em \(w\) é nula se \(v\notin R_z\), pois a derivada tem parte linear \(B_z(v,w)\). Se \(v\in R_z\), ela é \(64(-1)^{D_v f(z,0)}\). Portanto

\[
E_\beta = \frac1{64}\sum_z A(z,\beta)^2
=\sum_z\sum_{v\in R_z}(-1)^{D_v f(z,0)+\beta\cdot v}.
\]

Parseval em \(z\) dá \(E_\beta=64\) para toda \(\beta\). Invertendo a transformada em \(\beta\), obtemos a condição equivalente

\[
\sum_{z:v\in R_z}(-1)^{D_v f(z,0)}=0\qquad(v\ne 0).
\]

Esta última condição é o balanceamento das derivadas nas direções contidas no bloco \(w\). Com o mapa e a polar fixos, cada bit \(D_v f(z,0)\) é afim nos parâmetros de fase. Basta agrupar as parcelas por seu caráter. Para testar se a soma pode valer zero ou 64, basta usar o dual do espaço gerado pelas frequências que restaram. A rotação permite escolher um representante por órbita de \(v\).

## Aplicação às 49 tarefas

O verificador `line_phase_algebra.py --column-energy` reconstrói os 2.096 pares mapa–polar a partir das tarefas, sem consultar a classificação anterior dos casos difíceis. Depois das 728 exclusões por assinaturas e das 925 colisões com linhas de posto zero, restam 443 pares:

| Condição que primeiro exclui o par | Pares |
| --- | ---: |
| Uma direção de derivada | 413 |
| Uma coluna entre 0, 63 e 21 | 5 |
| Redução módulo 4 | 7 |
| Coluna 0 após a redução módulo 4 | 18 |

O passo novo dispensa todos os momentos módulo 8. Entre os 55 pares que antes dependiam deles, 37 já caem pelo balanceamento de uma derivada. Nos 17 casos seguintes, a desigualdade triangular na soma de caracteres da coluna 0 dá um limite estritamente acima de 64. No mapa `2023`, resta a identidade abaixo.

## Mapa 2023

Depois da redução módulo 4, a energia na coluna zero é

\[
E_0=192-48a-8b-48c-24d-24e+24de,
\]

onde \(a,b,c,d,e\) são os caracteres associados às máscaras 532, 3584, 4177, 11307, 17492 da parametrização reduzida. A última frequência é o XOR das duas anteriores. Como \(-24d-24e+24de\ge -24\), a igualdade \(E_0=64\) força \(a=b=c=1\). Basta impor \(a=c=1\). A soma das equações quadráticas de índices 0, 5, 7 e 10 se restringe ao polinômio constante 1 no subespaço definido por essas duas relações lineares. A substituição formal verifica a identidade, sem avaliar fases.

## Exclusão sem os momentos módulo 4 e módulo 8

Em cada soma de caracteres, os padrões que atingem o valor prescrito vivem no dual do espaço das frequências. As equações do fecho afim desses padrões são condições lineares necessárias nos parâmetros de fase. Para transpor uma equação desse dual ao espaço de fases, some as frequências correspondentes à sua forma linear. Interseque as equações de todas as somas e repita após a substituição afim. Em 16 dos últimos 25 pares, as equações são incompatíveis já na primeira interseção.

Para os nove restantes, use também a autocorrelação da coluna. Se \(f\) é bent, então para cada \(\beta\) a transformada em \(z\) de \(A(z,\beta)\) tem módulo constante. Pelo teorema da autocorrelação,

\[
\sum_z A(z,\beta)A(z+a,\beta)=0\qquad(a\ne 0).
\]

Expanda \(A(z,\beta)\) como soma de caracteres nos parâmetros de fase. A autocorrelação é o produto de duas somas de caracteres, seguido da soma sobre os pares \(z,z+a\). Os pares contribuem duas vezes, e o programa usa uma vez cada par. O mesmo procedimento de fecho afim, aplicado às autocorrelações de colunas selecionadas, resolve os nove casos. No mapa 1505 basta a coluna 0, com deslocamento 9 depois da redução linear. Os outros oito usam somente colunas de rótulo até 16, além das colunas iniciais 21 e 63.

O comando `line_phase_algebra.py --column-autocorrelation` reproduz a cobertura completa. As 49 tarefas já incorporam os momentos lineares de paridade. O novo passo dispensa os momentos de ordem superior, usando apenas somas de caracteres e eliminação linear. O arquivo de saída registra as equações afins e suas fontes em cada redução. A construção das tarefas e o cálculo dos espaços de frequências ainda são verificações finitas.

## Paridade dos radicais

Um primeiro filtro dispensa a fase. Para todo \(v\ne 0\), o número de linhas \(z\) com \(B_zv=0\) tem de ser par. Isso exclui 1.196 dos 2.096 pares antes da construção das fases. Com a paridade aplicada primeiro, as demais exclusões ficam em 352 por assinatura, 429 por colisão, 89 por uma derivada, 5 pela energia de uma coluna, 16 por relações lineares conjuntas e 9 pela autocorrelação.

Para uma dimensão \(m\ge4\) e uma polar cíclica com \(B_zz=0\), a condição de paridade é um polinômio de grau no máximo \(m-2\) nas coordenadas do espaço linear das polares. De fato, a avaliação \(B_zv\) para \(z\notin\{0,v\}\) pertence a \(z^\perp\cap v^\perp\), pela simetria e pela alternância de \(B_z\). O indicador de sua anulação é um produto de no máximo \(m-2\) fatores afins. A avaliação em \(z=v\) é identicamente nula, e em \(z=0\) a matriz \(B_0\) é circulante e alternada, de modo que a dimensão de seus valores é limitada por \(\lfloor m/2\rfloor\).

Em dimensão seis, há 13 órbitas de direções não nulas. O verificador simbólico obteve dez equações de grau quatro e duas de grau dois, para \(v=9,63\). A equação de \(v=27\) é identicamente nula no modelo de dimensão 25. A contagem simbólica e o teste direto dos radicais coincidem nas 212 polares do cruzamento de Pfaffianos. Das 198 compatíveis com os testes lineares L3 e L5, 106 são excluídas pela paridade, deixando 92 nesse cruzamento.

Para uma soma \(F(t)=c_0+\sum_m c_m(-1)^{m\cdot t}\), seja \(g=\gcd_m c_m\) sobre as frequências não nulas. A diferença \(F(0)-F(t)\) é sempre múltipla de \(2g\). O quociente módulo 2 é o produto escalar com o XOR das frequências para as quais \(c_m/g\) é ímpar. Quando esse XOR é nulo, o módulo pode ser dobrado. Todas as exclusões por uma única derivada admitem desigualdade triangular ou uma dessas congruências.

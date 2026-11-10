# Bent com simetria de rotação em 12 variáveis

Nota de trabalho de 10 de novembro de 2026. Contagens de funções distintas com a rotação fixa nas doze coordenadas.

## Resultado exato até grau quatro

| Grau algébrico | Constante e termo linear removidos | Todas as funções |
| --- | ---: | ---: |
| 2 | 16 | 64 |
| 3 | 14.320 | 57.280 |
| 4 | 77.305.344 | 309.221.376 |

Cada forma normalizada dá quatro funções distintas ao adicionar $a_0+a_1\sum_i x_i$. A lista está comprimida usando órbitas dos **topos quárticos**. Isso distingue todas as funções, sem propor classes de equivalência afim estendida.

### Cobertura da enumeração

Escreva a forma normal algébrica como $T+C+Q$, com graus $4,3,2$. A parte $T$ tem 43 coeficientes de órbitas. Por ortogonalidade de Walsh, numa restrição afim a oito dimensões o peso de uma bent é divisível por quatro. A expansão inteira do XOR de monômios, reduzida módulo quatro, tem só os termos singulares e os pares de monômios. Em dimensão oito, os termos singulares têm peso múltiplo de quatro. Dos pares, só sobrevivem dois quárticos disjuntos cuja união seja o conjunto dos oito eixos livres. Portanto as 43 equações quadráticas do H12 dependem exclusivamente de $T$, inclusive na presença de $C$ e $Q$. [H12 e os filtros originais](https://doi.org/10.6084/m9.figshare.34737294.v2)

O programa `top_filters.py` deriva três equações lineares no espaço gerado pelos 43 filtros e seus produtos por uma variável, com certificados conferidos por identidades polinomiais. Os 16 blocos do Actions cobrem os $2^{40}$ vetores restantes. Passam 949.760, contando $T=0$. [Execução dos topos](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42744053190)

Uma transformação linear que normaliza a rotação preserva a simetria e a bentness. A parte de grau quatro transforma-se independentemente de $C+Q$. Usamos os circulantes invertíveis e as permutações de coordenadas dadas pela multiplicação dos índices por 5 e por 7 módulo 12. O anel dos circulantes é $\mathbb F_2[z]/((z+1)^4(z^2+z+1)^4)$ e tem $8\cdot192=1536$ unidades. O grupo dos multiplicadores tem ordem quatro e a rotação, de ordem 12, age trivialmente nas funções invariantes. As órbitas observadas têm tamanho que divide 512 e estão inteiramente no conjunto enumerado de topos. A partição produziu 17.283 representantes. Uma transformação que leva um topo a outro dá uma bijeção entre completamentos normalizados, porque a remoção dos termos afins com simetria de rotação comuta com a passagem ao quociente por esses termos.

Para cada representante, os 25 coeficientes de $C+Q$ projetam-se sobre um espaço de dimensão quatro ao restringir a função aos 16 pontos de período quatro. Somar as contribuições nas órbitas de tamanho três mostra que a transformada de Walsh restrita deve ser não nula módulo três em toda frequência. Para cada topo, quatro fibras são admissíveis e são visitados $4\cdot2^{21}$ completamentos. Todo sobrevivente das 352 frequências representativas passa pela transformada completa de 4.096 pontos. Entre os topos não nulos, 2.564 representantes admitem bent, totalizando 67.647 topos. A soma dos números de completamentos multiplicados pelos tamanhos das órbitas dá a tabela. [Execução dos completamentos](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42744599465)

### Usar o catálogo

`catalog/catalog-index.tsv` informa, para cada representante, o tamanho da órbita, a contagem de completamentos e a localização do bloco em `catalog/catalog.bin`. Cada bloco guarda as máscaras de 25 bits em inteiros little-endian de quatro bytes comprimidos com zlib. Os 43 bits do topo são ordenados pelas menores máscaras dos suportes nas órbitas cíclicas. Os 25 bits inferiores seguem a mesma ordem, primeiro os seis quadráticos e depois os dezenove cúbicos.

Com Python e NumPy, `python quartic_catalog.py query catalog 0x2028400291` lista os completamentos do topo de controle. O programa aceita um topo que não seja representante, localiza sua órbita e transporta os completamentos por uma mudança de coordenadas invertível. O topo zero recupera a lista completa de graus 2 e 3. A verificação local reconstruiu e conferiu por Walsh e Möbius 96 membros transportados para topos diferentes de seus representantes.

## Critério exato na ANF inteira

Escreva $f(x)=\sum_A c_A\prod_{i\in A}x_i$ como polinômio multilinear **sobre os inteiros**, com $f(x)$ em $\{0,1\}$. A condição de bentness equivale a
$$
c_A\equiv0\pmod{2^{|A|-6}}\quad(7\le|A|\le11),
\qquad c_{[12]}\equiv32\pmod{64}.
$$

Se $f$ é bent, para qualquer subespaço coordenado de dimensão $k$ entre 7 e 11 a soma de sinais vale $2^{k-6}$ vezes uma soma de um número par de sinais de Walsh. Seu peso é múltiplo de $2^{k-6}$. A fórmula do peso do subespaço $V_S$, $\sum_{A\subseteq S}2^{|S|-|A|}c_A$, dá as congruências por indução em $|S|$. Para $|S|=12$, o peso é $2048\pm32$ e fornece a última congruência.

Reciprocamente, essas congruências dão $\operatorname{wt}(f)\equiv32\pmod{64}$. Para $1\le|S|\le5$, o peso na fatia $x_S=1$ é múltiplo de $2^{6-|S|}$. Cada parcela que não é o termo cheio tem a divisibilidade pelo fator $2^{12-|S|-|A\setminus S|}$ e pela hipótese sobre $c_A$. O termo cheio é divisível por 32. No polinômio inteiro de Walsh, o coeficiente da frequência monomial $u_S$ é
$$
(-2)^{|S|}\left(2^{12-|S|}-2\sum_{x_S=1}f(x)\right).
$$
Todos os coeficientes não constantes são zero módulo 128. O constante é 64 módulo 128. Todo valor de Walsh, portanto, tem módulo pelo menos 64 e Parseval força que todos tenham módulo 64.

A condição de módulo quatro implica uma regra triangular. Para todo conjunto $S$ de tamanho pelo menos oito, o número de pares distintos de monômios da ANF booleana com união exatamente $S$ é par. Se a parte de graus 4 a 6 está fixada, essas equações são lineares nos 25 bits de graus 2 e 3, pois a união de dois suportes de grau no máximo três não chega a oito. Em qualquer fatia afim de dimensão oito, vale a formulação equivalente por peso
$$
\frac{\operatorname{wt}((H+L)|_F)}2
\equiv \frac{\operatorname{wt}(H|_F)}2
+\sum_{x\in F}H(x)L(x)\pmod2,
$$
com $H$ fixo e $L$ de grau até três. O peso de $L|_F$ é divisível por quatro. A versão com todas as fatias coordenadas de dimensão oito equivale às equações das uniões, tomando os coeficientes do polinômio nas quatro coordenadas fixadas.

A experiência com 666 fatias coordenadas, uma por órbita, rejeitou todas as 4.096 partes altas sorteadas de cada grau 5 e 6 com o último coeficiente do grau máximo fixado em 1. A busca exata também completou 24 partes altas de grau 5 ou 6 nas somas antipodais. Cada uma tem os mesmos 14.336 completamentos normalizados que o topo zero. Este é um recorte exaustivo de 24 partes altas. [Execução dos graus maiores](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42745251145)

## Bent afins nas classes laterais da diagonal antipodal

Use $x=(a,b)$ com blocos de seis, $z=a+b$ e $w=b$. A diagonal $E=\{(a,a)\}$ é o espaço das direções de $w$. Se $f$ é afim em cada classe lateral de $E$, então $f(z,w)=w\cdot\pi(z)+h(z)$. Somando a transformada em $w$, a bentness equivale a $\pi$ ser uma permutação.

Denote por $R$ a rotação de um bit nas seis coordenadas. A rotação de um bit nas doze coordenadas se escreve $(z,w)\mapsto (Rz,Rw+z_5 e_0)$. A simetria equivale a
$$
\pi(Rz)=R\pi(z),\qquad h(Rz)+h(z)=z_5\pi(z)_5.
$$
Assim, $\pi$ envia cada órbita a outra de mesmo comprimento com uma fase. A fase é elegível quando a soma da recorrência na órbita é zero. Para cada $\pi$ elegível, o número de $h$ é $2^{14}$, uma escolha em cada órbita. O permanente da matriz de fases elegíveis conta as permutações em cada comprimento. Para grau até cinco, é preciso $\deg\pi\le4$ e $\deg h\le5$. Basta anular os seis coeficientes de grau cinco da primeira coordenada de $\pi$, porque as demais são rotações e as coordenadas de uma permutação são balanceadas. O programa conta a síndrome XOR desses seis coeficientes por duas vias, uma programação dinâmica e permanentes assinados. Exatamente metade dos $h$ satisfaz $\deg h\le5$, porque a escolha inicial de $h$ na órbita de $z=0$ altera sua paridade.

| Grau exato | Bent afins nas classes laterais de $E$ |
| --- | ---: |
| 2 | 64 |
| 3 | 57.280 |
| 4 | 290.004.992 |
| 5 | 6.082.604.171.264 |
| 6 | 366.875.900.903.424 |
| Total | 372.958.795.137.024 |

Os graus até quatro são extraídos do catálogo testando a condição afim em cada classe lateral. O grupo usado no catálogo preserva $E$, pois normaliza a rotação e comuta com sua meia-volta. Assim o teste é constante em cada órbita do topo com os completamentos transportados.

### Unicidade entre subespaços invariantes pela rotação

Um subespaço invariante de dimensão seis é um ideal do anel cíclico, gerado por $(z+1)^a(z^2+z+1)^b$ com $(a,b)\in\{(4,1),(2,2),(0,3)\}$. Se uma bent RS é afim nas classes de um subespaço invariante $U$ de dimensão seis, a permutação da forma Maiorana–McFarland deve entrelaçar a rotação em $V/U$ com a ação dual em $U^*$. As duas ações precisam ter o mesmo número de pontos fixos. Para $(4,1)$ e $(0,3)$, exatamente um dos módulos contém o fator $z+1$, logo uma ação tem dois pontos fixos e a outra só um. Para $(2,2)$ obtemos o ideal de $z^6+1$, que é $E$. Portanto $E$ é o único subespaço **invariante pela rotação** de dimensão seis que pode satisfazer a condição. Isso permite distinguir o recorte acima de funções que usam subespaços sem essa invariância.

## Graus da dual

A dual é definida por $W_f(u)=64(-1)^{f^*(u)}$ e é uma involução no conjunto das bent. A rechecagem vetorizada dos 4.029.176 registros do catálogo obteve os seguintes números de funções distintas, incluindo os quatro termos afins de cada forma normalizada. [Execução da conferência de duais](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42745979247)

| Grau de $f$ | Grau de $f^*$ | Funções | Fora do recorte da diagonal |
| --- | ---: | ---: | ---: |
| 2 | 2 | 64 | 0 |
| 3 | 3 | 4.032 | 0 |
| 3 | 4 | 53.248 | 0 |
| 4 | 3 | 53.248 | 0 |
| 4 | 4 | 6.395.904 | 182.272 |
| 4 | 5 | 302.772.224 | 19.034.112 |

A propriedade de ser afim nas classes da diagonal é preservada pela dualidade. Para $f(z,w)=w\cdot\pi(z)+h(z)$, somar em $w$ mostra que a dual em frequências $(u,v)$ depende de $z=\pi^{-1}(u+v)$ e vale $h(z)+u\cdot z$. Fixado $u+v$, ela é afim nas direções da diagonal. A involução dá a recíproca. Assim a última linha também conta todas as quínticas de dual quártica, inclusive as 19.034.112 que ficam fora do recorte da diagonal.

Há uma separação teórica entre as séxticas e os graus menores. Para $S\ne\emptyset$, o coeficiente inteiro $c_S(W_f)$ é $(-2)^{|S|}$ vezes a soma dos sinais de $f$ na fatia $x_S=1$. Se $\deg f=d$, a expansão do sinal mostra que essa soma é divisível por $2^{\lceil(12-|S|)/d\rceil}$. Como $c_S(W_f)=-128c_S(f^*)$, temos $[f^*]_S=0$ quando $|S|+\lceil(12-|S|)/d\rceil\ge8$. Para $d\le5$, a dual tem grau no máximo cinco. Toda séxtica tem, portanto, dual séxtica. Para $|S|=6$, a mesma identidade dá
$$
[f^*]_S=\operatorname{wt}(f|_{x_S=1})\pmod2=[f]_{S^c}.
$$
Na última igualdade, só o monômio de suporte $S^c$ pode contribuir para a paridade do peso, pois $f$ tem grau no máximo seis. Essa relação é um caso das relações entre graus e coeficientes de uma bent e sua dual. [Carlet, *Boolean Functions for Cryptography and Coding Theory*](https://www.math.univ-paris13.fr/~carlet/book-fcts-Bool-vect-crypt-codes.pdf)

## Partes altas fixas fora da diagonal

Fixe $A$ nos graus cinco e seis. As 70 equações de pares de monômios com união de tamanho pelo menos oito se escrevem $B L+P(T)=0$, onde $L$ são os 25 bits inferiores, $T$ os 43 bits quárticos e $P$ tem grau no máximo dois. A matriz $B$ depende só de $A$, porque um quártico e um cúbico têm união de tamanho no máximo sete. Eliminar $L$ produz um sistema quadrático apenas em $T$. Uma vez fixado um $T$ que passa, as soluções de $L$ formam um espaço afim. A busca usa a condição de período quatro e Walsh completo.

Foram completadas exatamente duas partes altas fora do recorte da diagonal. A primeira é extraída da dual de uma quártica do catálogo. A segunda vem da construção de grau máximo de Su. [Execução das duas partes altas](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42746470605) · [Su (2019)](https://doi.org/10.3934/amc.2019017)

| Parte alta | Bits quárticos após relações lineares | Completamentos normalizados | Funções na órbita afim da parte alta |
| --- | ---: | ---: | ---: |
| Quíntica `0x40640b82416fcc8c` | 29 | 384 | 393.216 |
| Séxtica com parte quíntica `0x80000000000000001` | 33 | 5 | 20.480 |

A órbita da parte alta usa os normalizadores lineares e a translação pelo vetor de uns. Entre os 384 completamentos quínticos, 368 têm dual quíntica e 16 têm dual quártica. Na órbita completa, isso certifica 376.832 quínticas de dual quíntica fora da diagonal. Os cinco completamentos séxticos e seus transportados ficam fora da diagonal. Os arquivos `dual5-bent.tsv`, `su6-bent.tsv` e `fixed-high-orbits.json` permitem reconstruir os exemplos e as testemunhas por segunda derivada.

## Uma única órbita de grau cinco ou seis

Com exatamente uma órbita quíntica ativa, sem termos séxticos, há 131.072 bent. As únicas duas órbitas possíveis têm menores máscaras de suporte 587 e 589. Cada uma dá 16.384 completamentos normalizados. Com exatamente uma órbita séxtica ativa e sem termos quínticos, não há bent. Em ambos os casos foram admitidos todos os termos de graus dois a quatro. [Execução inicial](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42747005817) · [Execução complementar](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42786490392)

Dos 146 padrões, 136 terminaram na execução inicial. Para oito dos pendentes, `sparse-counts.json` registra um caminho de normalizadores até um padrão resolvido. Outro é excluído por uma identidade polinomial e o último foi completado em 16 blocos. Uma segunda implementação conferiu por Walsh os 16.384 completamentos do suporte 589. Todos têm dual de grau cinco e ficam fora da diagonal. A órbita afim dessa parte alta tem 64 membros e é disjunta da órbita quíntica da seção anterior, o que certifica outras 4.194.304 quínticas de dual quíntica fora da diagonal.

## Duas órbitas quínticas

Com exatamente duas órbitas quínticas ativas, sem termos séxticos e com termos livres de graus dois a quatro, há **1.024 bent**. Todas têm dual de grau cinco e estão fora da diagonal. Três das 601 classes de partes altas têm completamento.

| Índices das órbitas quínticas | Completamentos normalizados no representante | Partes altas com duas órbitas na classe | Funções no recorte |
| --- | ---: | ---: | ---: |
| 7 e 26 | 4 | 4 | 64 |
| 35 e 42 | 36 | 4 | 576 |
| 35 e 47 | 48 | 2 | 384 |

Os índices começam em zero e seguem a ordem das menores máscaras de suporte das 66 órbitas quínticas. Um teste de paridade nas uniões de tamanho dez excluiu 408 classes. A eliminação polinomial excluiu outras 14. Os 261 blocos das 179 classes restantes percorreram 2.766.805.504 pontos quárticos e 841.209.664 completamentos inferiores. `summarize_two.py` verifica a cobertura dos blocos, a unicidade dos 88 registros e o Walsh completo de cada registro. Os resultados estão em `two-quintic-counts.json` e `two-quintic-bent.tsv`. [Projeção](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42786973906) · [Enumeração](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42787349924)

As três órbitas afins completas dessas partes altas dão 131.072 funções. Elas são disjuntas das órbitas fora da diagonal contadas acima. Somando o recorte da diagonal, as 19.034.112 quínticas de dual quártica fora dele e as órbitas de dual quíntica contadas separadamente, o limite inferior para o grau cinco é 6.082.627.907.584. Para o grau seis, o recorte da diagonal e a órbita da parte alta de Su dão um limite inferior de 366.875.900.923.904. As contagens globais dos graus cinco e seis seguem abertas.

## Equações independentes dos graus dois a quatro

Numa quíntica, uma união de tamanho dez requer dois monômios quínticos disjuntos. Há seis equações de paridade, uma por órbita do par de posições omitidas. Entre os $2^{66}-1$ topos quínticos não nulos, 1.150.894.005.165.228.031 passam pelas seis equações. A contagem é feita por somas de caracteres de formas quadráticas. Para eliminar um par $x,y$ com termo $xy$, escrevemos $q=xy+xA+yB+C$ e usamos $\sum_{x,y}(-1)^q=2(-1)^{C+AB}$. `upper_union_counts.py` implementa essa eliminação e a confere por enumeração de tabelas pequenas.

Numa séxtica, uma união de tamanho doze exige dois monômios complementares de grau seis. Se uma órbita difere da complementar, a contribuição tem a paridade do seu comprimento, que é sempre par para suportes de peso seis. Se a órbita é sua própria complementar, a contribuição tem a paridade de metade do comprimento. Só contam as órbitas autocomplementares de comprimento dois ou seis. No comprimento dois, o padrão é alternado. No comprimento seis, o padrão no bloco de seis é $u\bar u$, com $u$ de três bits. Das oito escolhas, duas são alternadas e as outras seis formam uma única órbita. As menores máscaras dessas duas órbitas são 1.365 e 455. Portanto toda séxtica bent RS em 12 variáveis tem **coeficientes iguais nas órbitas 455 e 1.365**.

A união de tamanho onze também fornece uma equação só nos graus cinco e seis. Com as duas condições de tamanho onze e doze, sobram 22.300.745.198.530.623.141.535.644.485.672.066.667.773.952 partes altas com algum termo séxtico. No recorte com exatamente duas órbitas altas, pelo menos uma séxtica, esses testes excluem 3.122 dos 8.440 padrões. Os sobreviventes formam 1.529 classes, das quais 881 foram excluídas pelas consequências polinomiais da projeção. Restam 2.207 padrões em 648 classes para a busca pelos completamentos. [Projeção das partes séxticas](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42788369424)

## Exemplos fora da classe completa de Maiorana–McFarland

Uma bent em 12 variáveis pertence a $\mathcal M^\#$ se e somente se existe um subespaço $U$ de dimensão seis com $D_aD_b f=0$ para todos $a,b\in U$. Para cada $a\ne0$, seja $K_f(a)=\{b:D_aD_b f=0\}$. É o subespaço dos períodos de $D_a f$. Se $U$ existe, então $U\subseteq K_f(a)$ para cada $a\in U\setminus\{0\}$. [Critério de Dillon e resultados de Polujan, Kudin e Pašalić](https://doi.org/10.1109/TIT.2026.3685133)

Para a quártica com máscaras $(T,L)=(13896404,1065441)$, a maior dimensão de $K_f(a)$ é cinco. Para a quíntica com máscaras $(A,T,L)=(67108992,1658964672512,148226)$, todo $K_f(a)$ tem dimensão um. Outro exemplo, de máscaras $(4432406249472,137606725825,15055593)$, tem dimensão máxima cinco. As contagens foram obtidas pelo anulador do suporte de Walsh de cada $D_a f$ e conferidas por translações diretas de tabelas-verdade. `m-subspace-witnesses.tsv` dá as máscaras e `m-subspace-witnesses.json` inclui os histogramas completos, uma quadrática de controle e a séxtica de Su, cujo caso fora de $\mathcal M^\#$ é conhecido. [Construção de Su](https://doi.org/10.3934/amc.2019017)

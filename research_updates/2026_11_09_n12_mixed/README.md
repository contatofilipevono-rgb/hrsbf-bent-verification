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

As três órbitas afins completas dessas partes altas dão 131.072 funções. Elas são disjuntas das órbitas fora da diagonal contadas acima.

## Três órbitas quínticas

Com exatamente três órbitas quínticas ativas e termos inferiores livres, há **13.056 bent**. Todas têm dual de grau cinco e ficam fora de $\mathcal M^\#$. Entre 45.760 padrões, 6.272 passam pelo teste de uniões de tamanho dez e formam 1.633 classes. A projeção excluiu 89 classes e os 1.632 blocos da enumeração restante visitaram 4.999.543.360 pontos quárticos e 70.539.943.808 completamentos inferiores. [Projeção](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42790009613) · [Enumeração](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42790401968)

| Índices das órbitas quínticas | Completamentos no representante | Partes altas no recorte | Funções no recorte |
| --- | ---: | ---: | ---: |
| 11, 17 e 28 | 256 | 4 | 4.096 |
| 35, 42 e 47 | 608 | 3 | 7.296 |
| 7, 40 e 51 | 64 | 2 | 512 |
| 36, 41 e 54 | 40 | 4 | 640 |
| 30, 51 e 62 | 64 | 2 | 512 |

Os 1.032 completamentos normalizados das cinco classes foram conferidos por Walsh completo. A contração dupla da parte quíntica exclui $\mathcal M^\#$ para todos. Suas órbitas afins completas dão 557.056 quínticas adicionais, disjuntas das órbitas anteriores. Incluindo as quínticas de dual quártica, há pelo menos **24.293.376 quínticas fora de $\mathcal M^\#$**. Somando também a família da diagonal, o limite inferior para grau cinco é **6.082.628.464.640**.

## Equações independentes dos graus dois a quatro

Numa quíntica, uma união de tamanho dez requer dois monômios quínticos disjuntos. Há seis equações de paridade, uma por órbita do par de posições omitidas. Entre os $2^{66}-1$ topos quínticos não nulos, 1.150.894.005.165.228.031 passam pelas seis equações. A contagem é feita por somas de caracteres de formas quadráticas. Para eliminar um par $x,y$ com termo $xy$, escrevemos $q=xy+xA+yB+C$ e usamos $\sum_{x,y}(-1)^q=2(-1)^{C+AB}$. `upper_union_counts.py` implementa essa eliminação e a confere por enumeração de tabelas pequenas.

Numa séxtica, uma união de tamanho doze exige dois monômios complementares de grau seis. Se uma órbita difere da complementar, a contribuição tem a paridade do seu comprimento, que é sempre par para suportes de peso seis. Se a órbita é sua própria complementar, a contribuição tem a paridade de metade do comprimento. Só contam as órbitas autocomplementares de comprimento dois ou seis. No comprimento dois, o padrão é alternado. No comprimento seis, o padrão no bloco de seis é $u\bar u$, com $u$ de três bits. Das oito escolhas, duas são alternadas e as outras seis formam uma única órbita. As menores máscaras dessas duas órbitas são 1.365 e 455. Portanto toda séxtica bent RS em 12 variáveis tem **coeficientes iguais nas órbitas 455 e 1.365**.

A união de tamanho onze também fornece uma equação só nos graus cinco e seis. Com as duas condições de tamanho onze e doze, sobram 22.300.745.198.530.623.141.535.644.485.672.066.667.773.952 partes altas com algum termo séxtico. No recorte com exatamente duas órbitas altas, pelo menos uma séxtica, esses testes excluem 3.122 dos 8.440 padrões. Os sobreviventes formam 1.529 classes, das quais 881 foram excluídas pelas consequências polinomiais da projeção. Restam 2.207 padrões em 648 classes para a busca pelos completamentos. [Projeção das partes séxticas](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42788369424)

A regra dos pares complementares vale também em $n=2m$, $m\ge3$. O coeficiente inteiro cheio é $-W_f(\mathbf 1)/2$, divisível por quatro. Pelo limite de grau de bent, os únicos pares que o afetam módulo quatro são monômios complementares de grau $m$. Todo comprimento de órbita de suporte de peso $m$ é par, pois um bloco fundamental precisa conter metade de uns. Assim, a soma dos coeficientes das órbitas autocomplementares de comprimento $2\bmod4$ precisa ser zero. Em particular, quando $m$ é potência de dois, a órbita alternada de comprimento dois tem coeficiente zero.

### Equação módulo oito na união cheia

Escreva $q_s$ e $b_s$ para os coeficientes quárticos e séxticos, respectivamente, indexados pela menor máscara da órbita. Além de $b_{455}=b_{1365}$, vale
$$
q_{585}(1+q_{195}+q_{325}+b_{715}+b_{845})
=b_{63}+b_{189}+b_{315}+b_{441}+b_{693}+b_{819}+b_{715}b_{845}.
$$
As duas expressões são tomadas em $\mathbb F_2$. Logo a equação também vale para grau até cinco com todos os $b_s=0$.

Sejam $P$ e $J$ o número de pares e de trios de monômios ativos cuja união tem as doze posições. O coeficiente inteiro cheio é $-2P+4J$ módulo oito. O cálculo de $P$ módulo quatro agrupa pares complementares de acordo com suas órbitas. Os únicos trios que contam para $J$ módulo dois são fixos pela rotação de três posições, pois os demais têm órbitas de tamanho par. Nesses trios, ou os três suportes são individualmente fixos, ou um é fixo e os outros dois são trocados. Os suportes individualmente fixos são exatamente 585, 1170 e 2340. Enumerar essas possibilidades dá a identidade acima. `upper_mod8.py` refaz a enumeração e a compara com 256 transformadas inteiras de Möbius.

### O próximo bit é afim nos termos inferiores

Fixadas as partes de graus quatro a seis e satisfeita a congruência cheia módulo oito, a congruência cheia módulo dezesseis dá uma equação afim nos 25 coeficientes inferiores normalizados. Se $K$ é a contagem de quartetos que cobrem todas as posições, o coeficiente inteiro é $-2P+4J-8K$ módulo dezesseis. Decomponha $J\equiv J_o+2J_e\pmod4$, com $J_o$ contando os trios fixos pela rotação de três posições e $J_e$ contando um trio por órbita de comprimento dois dessa rotação. As órbitas de comprimento quatro desaparecem. A equação resultante é
$$
J_e+K\equiv (P-2J_o)/4\pmod2.
$$
O lado direito é inteiro pela congruência módulo oito e depende só dos graus quatro a seis. Os trios de $J_e$ são fixos pela meia-volta. Se há um par trocado, os seus suportes pertencem à mesma órbita cíclica e contribuem com um único coeficiente. Dois suportes quadráticos individualmente fixos pela meia-volta também pertencem à mesma órbita, a antipodal. Em $K$ só contribuem, módulo dois, os quartetos fixos pela rotação de três posições. Eles se dividem em um ciclo de quatro, dois pares trocados, ou um par trocado e dois suportes fixos. Em cada caso, o produto de coeficientes tem no máximo um coeficiente de grau dois ou três. `full_mod16.py` deriva o polinômio pela ação nas coleções de suportes e confere 768 transformadas inteiras, 448 delas admissíveis módulo oito. Uma auditoria independente por modelo refez as contagens pequenas de órbitas.

### Duas formas afins para a restrição de período quatro

Sejam $t_0,t_1,t_3,t_5,t_7,t_{15}$ os valores da restrição $f(y,y,y)$, um por órbita. O teste de Walsh não nulo módulo três equivale a
$$
t_0+t_1+t_7+t_{15}=1,\qquad b=a+c+ac,
$$
onde $a=t_3+t_0$, $b=t_5+t_0$ e $c=t_7+t_1$. Todas as operações são em $\mathbb F_2$. `period4_conditions.py` confere a equivalência nas 64 tabelas invariantes. Fixar $c=0$ ou $c=1$ converte a segunda equação, respectivamente, em $b=a$ ou $b=1$. Como os valores $t_i$ são lineares nos coeficientes SANF, cada caso fornece três linhas afins que podem entrar na eliminação antes de enumerar os termos quárticos.

## Exemplos fora da classe completa de Maiorana–McFarland

Uma bent em 12 variáveis pertence a $\mathcal M^\#$ se e somente se existe um subespaço $U$ de dimensão seis com $D_aD_b f=0$ para todos $a,b\in U$. Para cada $a\ne0$, seja $K_f(a)=\{b:D_aD_b f=0\}$. É o subespaço dos períodos de $D_a f$. Se $U$ existe, então $U\subseteq K_f(a)$ para cada $a\in U\setminus\{0\}$. [Critério de Dillon e resultados de Polujan, Kudin e Pašalić](https://doi.org/10.1109/TIT.2026.3685133)

Para a quártica com máscaras $(T,L)=(13896404,1065441)$, a maior dimensão de $K_f(a)$ é cinco. Para a quíntica com máscaras $(A,T,L)=(67108992,1658964672512,148226)$, todo $K_f(a)$ tem dimensão um. Outro exemplo, de máscaras $(4432406249472,137606725825,15055593)$, tem dimensão máxima cinco. As contagens foram obtidas pelo anulador do suporte de Walsh de cada $D_a f$ e conferidas por translações diretas de tabelas-verdade. `m-subspace-witnesses.tsv` dá as máscaras e `m-subspace-witnesses.json` inclui os histogramas completos, uma quadrática de controle e a séxtica de Su, cujo caso fora de $\mathcal M^\#$ é conhecido. [Construção de Su](https://doi.org/10.3934/amc.2019017)

### Classificação em relação a $\mathcal M^\#$ até grau quatro

Todas as 19.216.384 quárticas fora do recorte da diagonal estão fora de $\mathcal M^\#$. As 290.004.992 quárticas do recorte pertencem à classe, assim como todas as quadráticas e cúbicas RS bent em 12 variáveis. Portanto, neste catálogo, pertencer a $\mathcal M^\#$ equivale a ser afim em todas as classes laterais da diagonal antipodal. [Execução da classificação por subespaços](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42789440160)

Se $T$ é a parte de grau $d$, o termo de grau $d-2$ de $D_aD_b f$ é a contração dupla de $T$. Cada suporte $S$ de $T$ e cada par $i,j\in S$ contribuem com $(a_i b_j+a_j b_i)x_{S\setminus\{i,j\}}$. Fixado $a$, seus coeficientes fornecem um sistema linear em $b$, cujo núcleo contém $K_f(a)$. Basta calcular um núcleo por órbita de $a$ e transportar os restantes pela rotação.

A busca de um possível $U$ começa por $0$ e escolhe sucessivamente a menor direção em cada nova classe lateral do espaço parcial. Cada direção nova precisa pertencer a todos os núcleos dos vetores já escolhidos. Todos os vetores do espaço ampliado precisam ter núcleo de dimensão pelo menos seis. Esses testes são necessários e preservam o caminho que escolhe sempre o menor vetor ainda disponível em qualquer $U$ válido. No teste com $K_f$ exato, testar pares dos vetores da base é suficiente porque $D_{a+b}=D_a+D_b+D_aD_b$.

Nos 272 topos representativos fora do recorte da diagonal, o teste do termo de grau dois de $D_aD_b f$ já exclui 18.012.160 funções. Nos 15 topos restantes, o cálculo exato de $K_f(a)$ por translações da tabela elimina as outras 1.204.224. `quartic-m-counts.json` registra a cobertura e os totais.

A classe $\mathcal M^\#$ é fechada por dualidade. Na forma $f(u,v)=u\cdot\pi(v)+h(v)$, a dual usa a permutação inversa e troca os blocos. Uma equivalência afim estendida de $f$ induz uma equivalência afim estendida de $f^*$ por mudança de variáveis no somatório de Walsh. Assim, as **19.034.112 quínticas de dual quártica** fora da diagonal também estão fora de $\mathcal M^\#$. A contração dupla da parte de grau máximo ainda exclui de $\mathcal M^\#$ as três órbitas afins quínticas da seção de duas órbitas, as duas órbitas quínticas de dual quíntica já contadas fora da diagonal e a órbita séxtica de Su.

## Duas órbitas altas com pelo menos uma séxtica

A enumeração dos 9.017 blocos fechou todo o recorte de 8.440 padrões. Contando todas as adições afins, há **213.712 séxticas** no recorte. Seis classes têm completamentos e todos estão fora de $\mathcal M^\#$. Para cada um desses seis topos, a contração dupla da parte séxtica já exclui qualquer subespaço de dimensão seis. O teste vetorizado independente refez o Walsh e calculou a dual de cada um dos 26.681 completamentos normalizados dos seis representantes. [Enumeração séxtica](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42788649738)

| Índices das duas órbitas | Completamentos no representante | Funções no recorte |
| --- | ---: | ---: |
| 0 e 67 | 5 | 80 |
| 89 e 99 | 22 | 352 |
| 43 e 104 | 6 | 96 |
| 84 e 106 | 15.360 | 122.880 |
| 100 e 133 | 11.264 | 90.112 |
| 117 e 135 | 24 | 192 |

Os índices começam em zero e ordenam primeiro as 66 órbitas quínticas, depois as 80 séxticas. Os 3.117.699.211.330 pontos quárticos e 6.099.206.658 completamentos inferiores estão cobertos pelos relatórios dos blocos. `two-sextic-bent.tsv` guarda os completamentos e `two-sextic-counts.json` guarda as multiplicidades. O transporte dos cinco topos em órbitas disjuntas da de Su dá outras 27.426.816 séxticas fora de $\mathcal M^\#$.

### Extensão das duas famílias maiores por adições nas somas antipodais

Nas coordenadas $(z,w)$, seja $B_\beta(z)$ a transformada de Walsh de $f(z,w)$ em $w$, na frequência $\beta$. Adicionar $h(z)$ multiplica $B_\beta(z)$ por $(-1)^{h(z)}$. Quando $h$ é afim no suporte de $B_\beta$, o Walsh completo nessa frequência só sofre um sinal e uma translação na frequência de $z$. Se isso vale para todo $\beta$, a adição preserva a bentness.

Para cada completamento das duas classes maiores, 40 colunas têm suporte unitário e 24 têm suporte num plano afim, com valores absolutos 32. Para um plano, o produto dos quatro sinais deve ser $-1$ para que todas as transformadas tenham módulo 64. Logo é necessário e suficiente que a paridade de $h$ no plano seja zero. Nas 12 coordenadas SANF de graus dois a seis em $z$, os 24 planos de cada família impõem a mesma equação linear. Cada semente tem $2^{11}$ adições normalizadas possíveis, das quais $2^9$ preservam a parte alta. A busca encontra 30 classes laterais de adições inferiores para a primeira parte alta e 22 para a segunda. `spectral_switching.py` refaz o cálculo dos suportes, dos espaços e da união dos completamentos, com conferência de Walsh em cada parte alta por classe lateral.

As adições geram seis novas órbitas de partes altas, disjuntas das seis anteriores. Cada uma tem 256 partes altas. A contração dupla do topo séxtico exclui $\mathcal M^\#$ em todas. Contando essas adições e os normalizadores, obtemos mais **81.788.928 séxticas**. Ao todo, isso certifica pelo menos **109.236.224 séxticas fora de $\mathcal M^\#$** e pelo menos **366.876.010.139.648 séxticas** contando também a família da diagonal.

As equações nas funções $h$ das duas famílias, usando as menores máscaras das órbitas em seis variáveis, são respectivamente $h_3+h_7+h_{11}+h_{15}=0$ e $h_5+h_{13}+h_{21}+h_{23}=0$. A primeira já aparece no plano $\{3,19,35,51\}$ e a segunda no plano $\{3,11,35,43\}$, ambos na coluna de frequência 3 para os exemplos de máscaras $(A,T,L)=(81129657757419795529855800442880,28204737792,1278049)$ e $(10889035742737681431056216839313285971968,296757660338,1163873)$. Uma auditoria independente por modelo conferiu a condição em cada coluna e a contagem sem sobreposição.

Uma enumeração separada completou as seis novas partes altas em 99 blocos. Os 79.872 registros normalizados coincidem, registro por registro, com a construção por adições. Portanto **81.788.928** é a contagem exata nessas seis órbitas de partes altas. [Verificação exaustiva das seis partes](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42792897305)

### Família ampliada por sinais em blocos de Walsh

Para as 52 sementes, o suporte da matriz $B_\beta(z)$ é a união disjunta de 40 blocos $1\times1$ e seis blocos $4\times4$. Cada bloco maior tem um plano afim de índices $z$ e um plano afim de frequências $\beta$. Prescrevemos amplitude 64 nas entradas isoladas e 32 nas entradas dos blocos maiores. A inversão de Walsh em cada linha dá uma tabela booleana se e somente se o produto dos quatro sinais em cada linha do bloco maior é $-1$. A mesma condição nas colunas torna a transformada completa de módulo 64. Em cada plano, os quatro sinais com produto $-1$ correspondem a uma quadrática bent em duas variáveis.

Se $s(z,\beta)$ denota o bit do sinal, a rotação acrescenta a equação $s(Rz,R\beta)=s(z,\beta)+z_5\beta_5$. Isso vem da mudança $w\mapsto Rw+z_5e_0$ no Walsh parcial. Para cada suporte fixo, as paridades de linha e coluna e a rotação formam um sistema afim de posto 117 nas 136 entradas. São exatamente $2^{19}$ soluções, já contando constante e termo linear. Os 52 suportes pertencem a órbitas distintas de tamanho oito sob os normalizadores. Na transformação de coordenadas $(z,w)\mapsto(Pz,Qw+Lz)$, o suporte passa pelo transporte de $z$ por $P$ e de frequências por $Q^T$. O termo $Lz$ muda apenas os sinais. Portanto essas órbitas de suportes dão exatamente **218.103.808 bent RS**.

A parte quadrática em $w$ é determinada pelo suporte de cada linha, independentemente dos sinais. Se o plano de frequências tem direções $b_1,b_2$, a parte quadrática é a de $(b_1\cdot w)(b_2\cdot w)$. Nos 52 suportes, pelo menos um coeficiente dessa parte tem grau quatro em $z$, de modo que todas as funções têm grau seis.

O mesmo coeficiente quadrático permite excluir $\mathcal M^\#$ para toda a família. Denote por $r(z)$ a forma polar em $w$ de cada linha. Se existisse um subespaço $U$ de dimensão seis com segundas derivadas nulas, sua projeção $Z$ no bloco $z$ e sua interseção $K$ com o bloco $w$ teriam dimensões somando seis. Precisariam valer $D_aD_b r=0$ para $a,b\in Z$, $(D_a r)e=0$ para $a\in Z,e\in K$, e $r(z)(e,e')=0$ para $e,e'\in K$. São as partes de maior grau em $w$ das segundas derivadas correspondentes. `block_sign_catalog.py` enumera os subespaços dos dois blocos de seis e verifica que nenhum par $(Z,K)$ atende às condições em qualquer um dos 52 suportes. O programa também reconstrói uma segunda tabela por suporte, verifica o Walsh, o grau e a simetria, e confere os geradores do transporte por mudança direta de coordenadas.

A família de blocos contém as duas grandes órbitas de partes altas e suas seis extensões por adição. Os outros quatro casos séxticos da enumeração têm pelo menos uma coluna de suporte maior que quatro, inclusive após transporte. Eles contribuem com 184.320 funções disjuntas. Isso dá pelo menos **218.288.128 séxticas fora de $\mathcal M^\#$** e pelo menos **366.876.119.191.552 séxticas** incluindo o recorte da diagonal.

### Todos os emparelhamentos entre os blocos

Fixamos agora só a partição dos índices $z$ e a partição dos índices $\beta$, sem fixar o emparelhamento entre elas. Sob os normalizadores, os suportes acima dão 16 pares distintos de partições, oito de cada tipo. Em cada partição, os seis planos formam uma única órbita de comprimento seis. Seu emparelhamento equivariante tem seis fases possíveis. Em cada par de partições, exatamente uma fase passa pelas equações de sinais, com nove bits de sinais livres nos planos. A parte quadrática em $w$ permanece de grau quatro em $z$ e o teste de $(Z,K)$ exclui $\mathcal M^\#$.

As entradas isoladas formam dez órbitas. Em cada comprimento, contamos os emparelhamentos equivariantes pelo permanente da matriz de fases. Uma fase é admissível quando a soma de $z_5\beta_5$ ao longo da órbita é par. Cada órbita admissível deixa um sinal livre. Para comprimentos 1, 2, 3 e 6, os permanentes são $(1,1,3,45.472)$ para oito pares e $(1,1,3,35.832)$ para os outros oito. O total é
$$
8\cdot 3\cdot(45.472+35.832)\cdot2^{10+9}
=1.023.041.077.248.
$$
`partition_switching.py` confere os permanentes por enumeração direta das permutações, reconstrói uma tabela por par de partições e verifica a rotação e o Walsh completo. Uma auditoria independente por modelo conferiu o argumento de sinais e a exclusão de $\mathcal M^\#$. Os pares de partições são recuperáveis do suporte de Walsh, logo a soma não duplica funções. Essa família contém a de 218.103.808 funções. Somados os quatro casos disjuntos com coluna de suporte maior que quatro, temos pelo menos **1.023.041.261.568 séxticas fora de $\mathcal M^\#$** e **367.898.942.164.992 séxticas** incluindo o recorte da diagonal.

## Localização das quínticas de dual quártica

`dual_quintic_tops.py` extrai dos 118.520 registros representativos quárticos fora da diagonal todos os topos quínticos das duais. As 19.034.112 quínticas de dual quártica fora de $\mathcal M^\#$ ocupam exatamente 120 órbitas afins de partes altas. Em cada órbita, o número de completamentos com dual quártica é constante e pode ser recuperado pela multiplicidade ponderada do catálogo. `dual-quintic-top-orbits.json` guarda os representantes, seus tamanhos e o número de completamentos conhecidos por representante. O menor número de órbitas quínticas ativas dentro de cada classe varia de nove a 32. Assim, a enumeração de partes altas esparsas e a de duais quárticas cobrem conjuntos distintos de topos.

Em 112 das 120 classes, a própria parte quíntica exclui $\mathcal M^\#$. As outras oito requerem os termos inferiores no teste de derivadas, embora a exclusão das quínticas de dual quártica já siga da classificação de suas duais. A projeção das 119 classes além da parte alta já completada identificou 97 com no máximo 30 bits quárticos livres nos dois ramos de período quatro. Os quatro trabalhos da enumeração atingiram o limite de 90 minutos. Os artefatos preservaram 349 dos 774 blocos previstos, que esgotam uma das 97 partes altas. [Execução dos 97 representantes](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42794028770)

A parte alta recuperada tem máscara 165780191766564007 e órbita de tamanho 128. A rechecagem independente refez o Walsh dos 126.976 completamentos normalizados. São 256 de dual quártica e 126.720 de dual quíntica. O teste do topo exclui $\mathcal M^\#$ em toda a órbita. Com os termos afins, isso dá 131.072 quínticas de dual quártica já contadas no catálogo de duais e **64.880.640 quínticas adicionais de dual quíntica**. `dual-seeded-completed-chart.tsv.gz` contém os registros, `dual-seeded-completed-chart.json` tem a auditoria e `dual-seeded-checkpoint.json` distingue os blocos completos dos 425 pendentes.

A auditoria em fluxo dos 349 blocos completos registrou 15.051.712 completamentos normalizados, todos fora da diagonal. Conferiu 339 amostras pelo Walsh completo em uma segunda implementação. Para cada parte alta, subtraímos dos completamentos já vistos o número total de duais quárticas conhecido pelo catálogo, tomando zero quando a diferença é negativa. Isso é um limite inferior para as quínticas de dual quíntica, inclusive nas partes altas ainda incompletas. Após transportar pelos normalizadores e incluir os termos afins, obtemos **pelo menos 1.320.026.112 quínticas de dual quíntica fora de $\mathcal M^\#$**. A exclusão da classe vem do teste do topo nas partes altas que contribuem. A conta inclui as 64.880.640 já registradas para a parte alta completa. `dual-seeded-partial-audit.json` preserva as contagens por parte alta. [Retomada dos 425 blocos](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42852791194)

Os 16 trabalhos da retomada terminaram. A união das duas execuções cobre exatamente 774 blocos, incluindo todos os completamentos dos 97 topos escolhidos. A auditoria em fluxo conferiu a cobertura, os 20.407.752 registros normalizados, a exclusão da diagonal e 651 tabelas por uma segunda implementação de Walsh. O teste de derivadas da parte quíntica exclui $\mathcal M^\#$ em todos os 97 topos. Contando as partes altas transportadas e os termos afins, há **2.764.734.464 quínticas** nessas órbitas. Destas, 17.317.888 têm dual quártica, pelo catálogo completo do grau quatro, e **2.747.416.576** têm dual quíntica. A contagem de dual quíntica aumentou em 1.427.390.464 após os 349 blocos iniciais. `dual-seeded-resume-audit.json` preserva as contagens exatas por parte alta. [Execução concluída](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42852791194)

## Extensão espectral de quínticas

Aplicamos a condição de afinidade em cada suporte de $B_\beta$ aos 1.120 completamentos representativos fora da diagonal dos casos de duas e três órbitas. Para cada suporte, as relações afins entre seus pontos dão equações lineares nos coeficientes de $h(z)$. Restringimos $h$ a grau cinco e recalculamos o Walsh completo e o grau da dual para cada função em uma parte alta nova. `quintic-switching.py` certifica **294.912 quínticas adicionais** de dual quíntica fora de $\mathcal M^\#$, em seis órbitas de partes altas. As partes altas dessas órbitas exigem de 15 a 19 órbitas quínticas ativas mesmo após transporte. Elas também são disjuntas das 120 classes localizadas pelas duais quárticas. O limite inferior atual para o grau cinco, com a família da diagonal, é **6.082.628.759.552**.

## Quatro órbitas quínticas

Entre 720.720 padrões, 43.139 passam pelas condições de tamanho dez e formam 11.045 classes. A eliminação com o módulo oito exclui 648 classes. Nos 11 casos com pelo menos 29 bits quárticos livres, separamos os dois ramos de período quatro. Isso reduz a enumeração de 582.669.742.386 para 95.912.390.962 pontos quárticos. Por exemplo, o maior caso passa de 38 bits livres a dois ramos com 23 e 33 bits. A enumeração e a auditoria são organizadas por bloco. [Projeção](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42791593491) · [Enumeração](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/42792663998)

Os 16 trabalhos fecharam os 10.815 blocos e deram **1.738.920.000 quínticas com exatamente quatro órbitas ativas**, das quais **15.339.584** ficam fora da diagonal. O enumerador conferiu todos os positivos por Walsh completo. A auditoria em fluxo conferiu a cobertura, a classificação por afinidade na diagonal e 97 tabelas por uma segunda implementação de Walsh. A parte quíntica certifica que pelo menos 1.933.376 funções do recorte ficam fora de $\mathcal M^\#$. O transporte por órbitas completas de partes altas acrescenta 169.115.648 quínticas fora da diagonal aos limites inferiores anteriores. Destas, pelo menos 61.865.984 ficam fora de $\mathcal M^\#$. `four-quintic-counts.json` separa as contagens exatas dos limites inferiores.

As órbitas das quínticas adicionais de quatro órbitas e das partes altas localizadas pelas duais quárticas são disjuntas. Com a enumeração completa dos 97 topos, o limite inferior sobe a **6.085.545.291.776 quínticas** no total.

## Formulação SAT por valores da tabela-verdade

Para cada órbita de pontos, tome uma variável binária $t_O$ igual ao valor de $f$ nessa órbita. O coeficiente inteiro $c_S$ é uma combinação linear dos $t_O$ com coeficiente $\sum_{X\subseteq S,\,X\in O}(-1)^{|S|-|X|}$ para a órbita $O$. As congruências do critério inteiro podem, portanto, ser codificadas por somadores binários, sem fixar previamente os coeficientes de graus cinco e seis. Em `mobius_sat.py`, a fórmula básica tem 352 variáveis de tabela, 35.670 variáveis totais e 157.670 cláusulas. O programa pode impor uma parte alta específica e a existência de uma restrição não afim numa classe da diagonal.

Os controles de tabela-verdade passaram para a quadrática antipodal, a séxtica de Su e duas funções não bent. As portas de soma também foram comparadas com as congruências aritméticas em 768 atribuições pequenas. O ensaio livre com a parte alta de Su chegou ao limite de 2.500 conflitos, embora a testemunha de Su passe ao se fixar a tabela. Assim, a formulação é exata, e o ensaio ainda não mede a viabilidade de uma busca global.

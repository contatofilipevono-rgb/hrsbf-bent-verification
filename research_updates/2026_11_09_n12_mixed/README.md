# Bent com simetria de rotação em 12 variáveis

Nota de trabalho de 9 de novembro de 2026. Contagens de funções distintas com a rotação fixa nas doze coordenadas.

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

Para a rotação à esquerda de seis posições, denotada aqui por $R$, a rotação de **um bit** em doze posições se escreve $(z,w)\mapsto (Rz,Rw+z_5 e_0)$. A simetria equivale a
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

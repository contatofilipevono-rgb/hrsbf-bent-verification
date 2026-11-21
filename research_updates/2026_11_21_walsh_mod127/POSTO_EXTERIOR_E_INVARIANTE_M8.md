# Posto exterior de um símbolo com a obstrução módulo quatro

No caso global de Walsh em 32 variáveis e módulo 127, o [invariante das oito quárticas](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/a62baae440e10b095a20b33ea5013237a0d1283b/research_updates/2026_11_21_walsh_mod127/INVARIANTE_M8_WALSH_MOD127.md) impõe $\gamma_6(a)=0$ e $\Gamma_8(A)\equiv2\operatorname{vol}_{32}\pmod4$. Aqui $a$ é o símbolo quártico e $A$ um levantamento exterior integral orientado. A seguir provamos que essas condições exigem **pelo menos 12 parcelas decomponíveis**. A prova é algébrica.

## Enunciado geral

Sejam $d\ge4$ par, $m\ge3$ e $V$ de dimensão $dm$ sobre $\mathbb F_2$. Seja $a\in\Lambda^d V$ com

$$
\gamma_{m-2}(a)=0,\qquad
\Gamma_m(A)\equiv2\operatorname{vol}_{dm}\pmod4.
$$

Então $a$ exige ao menos $m+4$ parcelas decomponíveis. Uma parcela decomponível é o produto exterior de $d$ formas lineares.

As potências divididas inteiras são $\Gamma_j(A)=A^j/j!$, calculadas no exterior racional. O resultado é integral para $d$ par, pois cada parcela monomial tem quadrado nulo e parcelas de grau par comutam. Sua redução módulo dois é $\gamma_j(a)$. A contração satisfaz $\iota_v\Gamma_j(A)=(\iota_v A)\Gamma_{j-1}(A)$. Assim $\gamma_{m-2}(a)=0$ implica $\gamma_{m-1}(a)=0$, pois todas as contrações de $\gamma_{m-1}(a)$ se anulam. A expansão de $\Gamma_m(A+2H)$ mostra que seu resíduo módulo quatro independe do levantamento. O termo linear na diferença é $2H\Gamma_{m-1}(A)$ e os termos restantes são múltiplos de quatro. O mesmo vale sobre $\mathbb Z_{(2)}$, o anel dos racionais de denominador ímpar. Uma mudança de base multiplica o coeficiente de volume por uma unidade ímpar, preservando a classe $2\bmod4$.

## 1. Passar para o núcleo da matriz dos fatores

Suponha que $a$ seja uma soma de até $r=m+3$ parcelas decomponíveis. Complete com parcelas nulas até $r$. Considere $E=\mathbb F_2^{dr}$, dividido em $r$ blocos coordenados de tamanho $d$, e escreva $\omega_i$ para o volume exterior do bloco $i$. A aplicação $P:E\to V$ envia cada base de bloco aos $d$ fatores da parcela correspondente, logo envia $\omega=\sum_i\omega_i$ a $a$. Ela é sobrejetora. Caso contrário seria possível levantar $a$ num subespaço estritamente menor que $V$ e ter $\Gamma_m(A)=0$, contrariando a hipótese módulo quatro.

Seja $K=\ker P$ de dimensão $3d$. As $d$ coordenadas duais do bloco $i$ restringem-se a $K^*$ e geram um subespaço $L_i\subseteq K^*$ de dimensão no máximo $d$. Escreva $\beta_i$ para o produto exterior das $d$ restrições do bloco e $b=\sum_i\beta_i$. Os $L_i$ geram $K^*$.

Em $E^*$, seja $\lambda_j$ a soma dos produtos das formas de volume de $j$ blocos distintos. Se $\theta$ é o volume de $K$, as três anulações $\gamma_{m-j}(a)=0$ para $j=0,1,2$ implicam

$$
\iota_\theta\lambda_{3+j}=0\qquad (j=0,1,2).
$$

De fato, $\bigwedge P(\gamma_{m-j}(\omega))=0$ equivale a $\theta\wedge\gamma_{m-j}(\omega)=0$, por uma base adaptada ao núcleo. O emparelhamento de volume de $E$ identifica a última identidade com a contração indicada, porque o complemento de $m-j$ blocos tem $3+j$ blocos. Para $j=0$, a anulação original vem da paridade de $\Gamma_m(A)$.

Uma regra para avaliar estas três identidades é escolher $u_i>0$ vetores coordenados em cada bloco $i$ de um conjunto $J$, com $\sum_{i\in J}u_i=jd$. Seja $X$ a cunha das restrições a $K$ das coordenadas complementares dentro desses blocos. A avaliação dá

$$
X\wedge\gamma_{3+j-|J|}\left(\sum_{i\notin J}\beta_i\right)=0 .
$$

Só os termos contendo todos os blocos de $J$ sobrevivem à avaliação. As coordenadas ainda livres nos outros blocos entram por seus volumes completos. Por multilinearidade, os vetores escolhidos na cunha $X$ podem ser combinações das coordenadas restritas de cada bloco.

Para usar a informação módulo quatro, podemos levantar a matriz de coordenadas de uma base de $K$ de qualquer forma, contanto que ela se reduza à matriz binária. Um menor ímpar garante que seu espaço de colunas sobre $\mathbb Z_{(2)}$ seja um somando livre. O quociente por ele dá um levantamento de $P$ após escolher uma base do quociente. Cada maior menor do quociente é, até uma unidade ímpar comum e o sinal de permutação, o menor complementar da matriz de $K$. Isso segue cunhando os vetores do menor do quociente com a base levantada de $K$ e comparando coeficientes de volume. Para uniões de blocos inteiros de tamanho par, o sinal é constante. Conclui-se que

$$
\Gamma_m(A)\equiv2\operatorname{vol}_{dm}\pmod4
\quad\Longleftrightarrow\quad
\Gamma_3\left(\sum_i\widetilde\beta_i\right)\equiv2\operatorname{vol}_{3d}\pmod4 ,
$$

onde $\widetilde\beta_i$ são os volumes dos blocos na matriz dual levantada. A equivalência vale para todos esses levantamentos. Em particular, ao levantar as coordenadas de um bloco, podemos preservar seu posto binário exato, escolhendo uma base do bloco e levantando as demais coordenadas como combinações dessa base.

## 2. Três consequências no espaço dual

1. **Paridade por par de blocos.** Dado um par $p,q$, o número de terceiros blocos que, junto deles, geram $K^*$ é par. Defina $\delta_S=1$ se os três blocos de $S$ geram $K^*$ e zero caso contrário. Para todo conjunto $J$ de tamanho $0,1,2$, escolha todos os $d$ vetores coordenados de cada bloco de $J$ nas identidades anteriores. A regra de avaliação dá $\sum_{S\cap J=\varnothing}\delta_S=0$. Somar as quatro relações para $J=\varnothing,\{p\},\{q\},\{p,q\}$ isola $\sum_{S\supseteq\{p,q\}}\delta_S=0$.

2. **Menores com blocos incompletos.** Toda seleção de $3d$ vetores em até cinco blocos, cada um fornecendo no máximo $d-1$ vetores, é dependente. Complete o conjunto de blocos até cinco usando blocos adicionais com zero vetores. Escolha no bloco $i$ os $u_i=d-k_i$ vetores complementares ao número selecionado $k_i$. Assim $|J|=5$ e $\sum u_i=2d$. A regra com $j=2$ dá diretamente $X=0$.

3. **Um bloco completo e três incompletos.** Toda seleção de $3d$ vetores em quatro blocos distintos, nas quantidades $(d,d-1,d-1,2)$, é dependente. Tome $X$ como o produto dos vetores dos três blocos incompletos. Use primeiro a regra com os números complementares $(1,1,d-2)$ e $j=1$, obtendo $Xb=0$. Os volumes dos blocos de $X$ podem ser incluídos em $b$ pois seu produto com $X$ é zero. Inclua agora o bloco completo $p$ com $d$ vetores de avaliação e aplique a regra com $j=2$. Ela dá $X(b+\beta_p)=0$, logo $X\beta_p=0$.

## 3. Se três blocos formam uma base

Suponha que haja três blocos com espaços $A,B,C$ de dimensão $d$ e $K^*=A\oplus B\oplus C$. Chamemos externos os outros blocos. Pela paridade por par, há um bloco externo com projeção de posto $d$ em $A$, outro com projeção de posto $d$ em $B$ e outro com projeção de posto $d$ em $C$.

Para a soma $D$ de até dois blocos externos, é impossível encontrar três funcionais que dependam, respectivamente, das componentes $A,B,C$, e cujas restrições a $D$ sejam independentes. Se fosse possível, o núcleo comum desses três funcionais seria a soma de um hiperplano em cada um de $A,B,C$. Tome $d-1$ vetores de cada hiperplano e acrescente três vetores dos blocos externos que gerem o quociente. Isso viola a consequência 2.

Considere a soma dos dois blocos externos com projeções de posto $d$ em $A$ e $B$. Sua projeção em $C$ tem de ser zero. Se fosse não nula, escolha um funcional de $C$ com restrição não nula à soma. Depois escolha um funcional de $A$ cuja restrição não pertença à linha do primeiro, e um de $B$ cuja restrição esteja fora do plano dos dois primeiros. Os postos $d\ge4$ permitem ambas as escolhas. Isso é proibido. Aplicando o mesmo argumento às outras duas duplas, obtemos um bloco duplicado de cada um dos espaços $A,B,C$.

Agora, se um bloco externo $G$ tem projeções não nulas em duas componentes, some-o ao duplicado da terceira. Duas restrições independentes de funcionais das duas primeiras componentes poderiam ser estendidas por uma restrição da terceira, de posto $d$. Logo a projeção conjunta de $G$ nas duas primeiras componentes tem posto no máximo um. Se $G$ tem só duas projeções não nulas, isso dá $\dim G\le1$. Se tem três, aplique o argumento a cada par. A imagem de cada componente tem posto um e os três parâmetros binários coincidem, logo também $\dim G\le1$.

Portanto cada bloco de posto cheio é um dos espaços $A,B,C$. A paridade por par implica um número par de blocos de cada tipo. Escolha os levantamentos mantendo os três espaços coordenados e o posto de cada bloco. Então $\sum_i\widetilde\beta_i$ é soma dos três volumes com coeficientes pares, e sua terceira potência dividida é múltipla de oito. Isso contradiz o resíduo módulo quatro.

## 4. Se três blocos completos geram um hiperplano

Resta o caso sem três blocos que gerem $K^*$. Suponha que três blocos completos $A,B,C$ gerem um hiperplano $H$ de dimensão $3d-1$. A aplicação de soma $A\oplus B\oplus C\to H$ tem uma única relação binária não nula. Seu suporte usa dois ou três blocos.

Seja $D$ um bloco que cruza $H$, isto é, não está contido em $H$. Faça o quociente por $A$. As imagens $B',C'$ geram $H/A$ de dimensão $2d-1$. Considere qualquer espaço $S$ de dimensão $2d-2$ gerado por $d-1$ vetores de cada imagem. Pela consequência 3, a imagem de $D$ módulo o espaço gerado por $A$ e pelos vetores de $S$ tem dimensão no máximo um. Como $D$ tem um vetor fora de $H$, isso obriga a imagem de $D\cap H$ em $H/A$ a estar em $S$.

Quando $B',C'$ têm dimensão $d$ e interseção uma linha $T$, a interseção de todos esses $S$ é zero. Para cada funcional $\ell$ em $H/A$ não nulo em $T$, o hiperplano $\ker\ell$ é um desses $S$, pela soma de suas interseções com $B'$ e $C'$. Esses funcionais geram o dual de $H/A$. Quando as imagens têm dimensões $d-1,d$ e são disjuntas, a interseção dos $S$ é o espaço de dimensão $d-1$, pois se pode somá-lo a qualquer hiperplano do outro.

Se a relação usa todos os três blocos, cada escolha do bloco pelo qual se toma o quociente está no primeiro regime. Segue $D\cap H\subseteq A\cap B\cap C=0$. Se a relação usa apenas $A,B$, o quociente por $C$ dá $D\cap H\subseteq C$. Já o quociente por $A$ está no segundo regime e dá $D\cap H\subseteq A+B$. Como $C\cap(A+B)=0$, novamente $D\cap H=0$. Em ambos os casos, todo bloco que cruza $H$ tem posto um. Todos os blocos completos estão, portanto, em $H$. Levante-os num mesmo hiperplano integral e mantenha os demais blocos com posto menor que $d$. A terceira potência dividida resulta zero.

Se sequer houver três blocos completos gerando dimensão $3d-1$, levante cada bloco com seu posto exato. Os termos com bloco incompleto se anulam. Todos os outros determinantes de três blocos têm posto binário no máximo $3d-2$, portanto são divisíveis por quatro, por eliminação com pivôs ímpares. Em ambos os cenários há contradição.

Isso prova o limite $m+4$. Em $(d,m)=(4,8)$, elimina até 11 parcelas decomponíveis.

## 5. Família excluída com um número arbitrário de parcelas

Há uma exclusão complementar quando $V$ é soma de $d$ cópias de um mesmo espaço $U$ de dimensão $m$ e

$$
a=\sum_i v_i^{(1)}\wedge v_i^{(2)}\wedge\cdots\wedge v_i^{(d)},
$$

em que $v_i^{(k)}$ denota o mesmo vetor $v_i\in U$ na cópia de índice $k$. Seja $Q$ a matriz integral cujas colunas levantam os $v_i$. A potência dividida máxima do levantamento formado por essa soma tem coeficiente de volume $\pm\sum_{|S|=m}\det(Q_S)^d$. O sinal é comum, vindo da reordenação dos fatores por cópia. Como $d$ é par, cada $\det(Q_S)^d\equiv\det(Q_S)^2\bmod4$. Pela identidade de Cauchy–Binet, a soma reduz ao determinante de $QQ^{\mathsf T}$, a menos do sinal comum.

Para quaisquer conjuntos de coordenadas $I,J$ de tamanho $m-2$ em $U$, avalie $\gamma_{m-2}(a)$ nas coordenadas $I$ nas primeiras $d-1$ cópias e $J$ na última. O coeficiente é

$$
\sum_{|S|=m-2}\det(Q_{I,S})^{d-1}\det(Q_{J,S})
\equiv \det\bigl((QQ^{\mathsf T})_{I,J}\bigr)\pmod2,
$$

outra vez por Cauchy–Binet. Seu anulamento força posto binário de $QQ^{\mathsf T}$ no máximo $m-3$. O determinante integral é então divisível por oito, o que contradiz a congruência da potência dividida máxima. A conclusão vale para qualquer número de vetores $v_i$.

## Escopo

O Astra 6.2 e o Codex obtiveram os argumentos complementares da prova de posto, e o Astra identificou a exclusão via Cauchy–Binet. Em 32 variáveis, o novo limite de 12 trata parcelas que são produtos de quatro formas lineares. A cota anterior de oito continua aplicável a produtos de dois fatores exteriores arbitrários. O caso global módulo 127 segue aberto para símbolos gerais de posto exterior pelo menos 12.

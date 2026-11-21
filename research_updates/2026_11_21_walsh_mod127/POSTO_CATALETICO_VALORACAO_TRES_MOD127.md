# Posto da forma quártica no nível de valoração três

No [caso global módulo 127](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/0401146804e15448e519732727e00ef53be232da/research_updates/2026_11_21_walsh_mod127/SUPORTE_AFIM_VALORACAO_TRES_MOD127.md), escreva $a=[f]_4$ para a forma quártica em $V=\mathbb F_2^{32}$ e $T(b)=k(b)(k(b)-1)/2$. Supomos que a menor valoração de $T\ne0$ seja três. Sejam $P=\{b:\nu_2(T(b))=3\}$, $Q=\{b:T(b)\equiv16\bmod32\}$, $p=|P|$ e $q=|Q|$. Já se tem $128\le p\le290$, $q\le38$ e $s=\dim\operatorname{aff}(P)\ge20$. Provamos aqui que **$s\ge21$**, e que **$s=21$ exige $p=128$**.

## 1. Dados dos momentos

Para $s<32$, ponha $U=(\operatorname{dir}\operatorname{aff}(P))^\perp$, $R=(\operatorname{dir}\operatorname{aff}(Q))^\perp$, $u=\dim U=32-s$ e $r=\dim R$. O argumento dos momentos dá $Q\ne\varnothing$, $a(U,R,V,V)=0$ e

$$
q\ge65-s-r+\rho_U,\qquad
1\,813\,560\,p+7\,748\,016\,q\le528\,531\,328,
$$

onde $\rho_U$ é o posto de $B_a(x\wedge y,z\wedge t)=a(x,y,z,t)$ em $L=U\wedge V$. O posto é par. Vale $r\le s$, e $U\cap R$ tem dimensão no máximo um. Se $U\cap R\ne0$, então $r\le s-7$. A última cota vem da contração cúbica por um vetor da interseção, que precisa de oito formas lineares e se anula ao inserir um vetor de $U+R$.

Podemos tomar $R'\subseteq R$ disjunto de $U$, com $\dim R'\ge r-1$. Em qualquer base adaptada a $U\oplus R'$, a congruência $\Gamma_8(A)\equiv2\operatorname{vol}_{32}\pmod4$ garante uma cobertura das 32 coordenadas por oito monômios disjuntos de $a$. Um monômio que toca $R'$ não toca $U$. Assim pelo menos $\lceil\dim(R')/4\rceil$ dos oito monômios são indisponíveis para cobrir índices de $U$.

## 2. O caso de posto relativo no máximo oito

Suponha que $\rho_U\le8$ e que alguma avaliação não nula de $a$ use ao menos três vetores de $U$. Escolha um $4$-espaço $W$ em que $a$ seja uma forma de volume. Se $a|_U\ne0$, escolha $W\subseteq U$. Caso contrário, escolha $E=W\cap U$ de dimensão três. Em ambos os casos, escreva $E=W\cap U$ e tome o complemento

$$
X=\{x:a(w_1,w_2,w_3,x)=0\ \text{para todos }w_1,w_2,w_3\in W\}.
$$

Então $U=E\oplus Y$, onde $Y=U\cap X$. Quando $\dim E=3$, isso segue de $a|_U=0$. A componente de um vetor de $U$ em $W$, determinada pelo emparelhamento de volume com $\Lambda^3 W$, está em $E$.

A restrição de $B_a$ a $\Lambda^2W\subseteq L$ é não degenerada de posto seis. Depois de separar este subespaço e tomar o quociente pelo radical, sobra um espaço simplético $S$ de dimensão no máximo dois. Denote por $\phi$ a projeção de $L$ em $S$.

Usaremos o seguinte fato. Para uma aplicação bilinear $F:A_1\times A_2\to S$, suponha que os valores de $F$ com primeiro argumento repetido sejam mutuamente ortogonais, e que o mesmo valha com segundo argumento repetido. Então toda a imagem de $F$ está numa única reta isotrópica ou é nula. Para cada primeiro argumento $x$ com imagem não nula, a aplicação $F(x,-)$ tem posto um, pois sua imagem é isotrópica. Se duas imagens fossem retas distintas num plano simplético, haveria um segundo argumento em que ambas fossem não nulas. Duas formas lineares não nulas sobre $\mathbb F_2$ sempre admitem um argumento em que ambas valem um. Isso contradiz a ortogonalidade com segundo argumento repetido.

Os pares de $E\wedge X$ e de $W\wedge Y$ são ortogonais a $\Lambda^2W$ pela definição de $X$. O fato acima se aplica separadamente a $\phi$ em $E\times X$ e em $W\times Y$, pois o valor de $B_a$ é zero com argumentos repetidos. Portanto todos os coeficientes de tipo $2W+2X$ com pelo menos três índices de $U$ são zero. Se $E=W$, todos os coeficientes de tipo $2W+2X$ são zero.

Para $y\in Y$ e $x\in X$, a componente de $y\wedge x$ em $\Lambda^2 W$ é ortogonal a $\Lambda^2 E$, pelos coeficientes já anulados. Se $E=W$, a componente é zero. Se $\dim E=3$, o ortogonal de $\Lambda^2 E$ em $\Lambda^2 W$ é a própria $\Lambda^2 E$, isotrópica. Em ambos os casos, as componentes em $\Lambda^2 W$ de todos os pares de $Y\wedge X$ são mutuamente ortogonais. O fato sobre o plano simplético pode então ser aplicado a $(y,x)\mapsto\phi(y\wedge x)$, cuja imagem está numa reta isotrópica ou é nula. Isso anula todo coeficiente de $a$ com quatro índices em $X$ e pelo menos dois em $U$.

Se $E=W$, para $w\in W$ e $y\in Y$ fixos, o emparelhamento
$a(w,x,y,z)=B_a(w\wedge x,y\wedge z)$ em $(x,z)\in X\times X$ é de posto no máximo um, pois $\phi(w\wedge X)$ tem dimensão no máximo um. Como é alternado, zera. Assim o único monômio com pelo menos dois índices em $U$ é o volume de $W$.

Se $\dim E=3$, fixe $t\in W\setminus E$ a completar uma base de $W$. Os coeficientes $a(t,y_1,y_2,x)$ também são zero, para $y_1,y_2\in Y$ e $x\in X$. Se a imagem de $\phi(Y\wedge X)$ for nula, isso é imediato. Caso contrário, denote sua reta por $M$. Para cada $y$ com $\phi(y\wedge X)\ne0$, a identidade $a(t,y,y,x)=0$ força $\phi(t\wedge y)\in M$. Esses $y$ geram $Y$, pois são o complemento de um subespaço próprio. Logo $\phi(t\wedge Y)\subseteq M$ e o emparelhamento é zero. Consequentemente todo monômio com pelo menos dois índices em $U$ usa um índice de $E$. No máximo três desses monômios cabem numa cobertura disjunta, e cada um tem no máximo três índices em $U$.

**Conclusão.** Se $u\ge11$, $\dim R'\ge13$ e há uma cobertura disjunta pelos oito monômios, então $\rho_U\ge10$. De fato, no máximo quatro monômios da cobertura tocam $U$, então algum usa ao menos três índices de $U$. Sob $\rho_U\le8$, o caso $E=W$ cobriria no máximo $4+3$ índices de $U$. O caso $\dim E=3$ cobriria no máximo $3\cdot3+1=10$. Ambas as alternativas são impossíveis.

## 3. Duas cotas para o posto absoluto

Seja $c$ uma 4-forma num espaço $H$. Seu posto absoluto é o posto do emparelhamento $B_c$ em $\Lambda^2H$.

**Posto no máximo dez implica suporte em, no máximo, seis formas lineares.** Se $c\ne0$, separe $W$ de dimensão quatro e o complemento $X$ como acima, agora tomando $U=H$. O espaço simplético residual tem dimensão no máximo quatro. Para $w\in W$, a aplicação $\phi_w:x\mapsto\phi(w\wedge x)$ tem imagem isotrópica, de dimensão no máximo dois, porque $c(w,x,w,y)=0$. A contração $c(w,\cdot,\cdot,\cdot)|_X$ se anula na direção do núcleo de $\phi_w$ e é cúbica alternada, logo é nula.

Considere $\beta_{w,w'}(x,y)=\langle\phi_w(x),\phi_{w'}(y)\rangle$. É alternada em $x,y$ e tem posto no máximo dois. Se alguma $\beta_{w,w'}$ é não nula, ela tem posto dois e seu radical é o núcleo comum de $\phi_w$ e $\phi_{w'}$. As duas imagens são planos isotrópicos emparelhados de modo não degenerado, gerando todo o espaço residual. Para qualquer $v\in W$ com $\phi_v\ne0$, pelo menos um dos emparelhamentos com $\phi_w$ ou $\phi_{w'}$ é não nulo. Portanto todas as aplicações $\phi_v$ passam pelo mesmo quociente de $X$ de dimensão dois. Assim todos os coeficientes de tipo $2W+2X$ são dados por uma única 2-forma $\alpha$ em $X$, apoiada em duas formas lineares. Se todos os emparelhamentos forem nulos, tome $\alpha=0$.

A projeção de $\Lambda^2X$ em $\Lambda^2W$ tem posto no máximo um, porque seu emparelhamento com $\Lambda^2W$ só depende da avaliação de $\alpha$. Logo essa projeção é isotrópica, e o emparelhamento de $c|_X$ em $\Lambda^2X$ tem posto no máximo quatro. Qualquer 4-forma não nula produz um subemparelhamento de posto seis em um espaço de dimensão quatro em que ela vale um. Assim $c|_X=0$. Como os termos de tipo $3W+1X$ são nulos pela escolha de $X$, restam o volume de $W$ e termos de tipo $2W+2X$ com o mesmo fator $\alpha$. Isso prova a cota de seis.

**Se $H$ tem dimensão 12 e $\gamma_3(c)\ne0$, o posto é pelo menos 14.** A hipótese força que o radical de $c$ seja nulo, pois uma direção no radical deixaria a forma apoiada em 11 variáveis. Forme o quociente da álgebra exterior $\Lambda H$ pelo ideal aniquilador de $c$. Na ordem $d$, o ideal consiste nos elementos que emparelham a zero com todo elemento de ordem $4-d$ sob $c$, e contém todas as ordens acima de quatro. O emparelhamento no quociente é perfeito entre graus $d$ e $4-d$. Assim a função de Hilbert satisfaz $h_1=h_3=12$ e $h_2=\operatorname{rank}B_c$.

Usando uma ordem de monômios, os monômios quadrados livres que sobrevivem ao ideal inicial dão bases nos graus dois e três. Todo divisor de um monômio sobrevivente também sobrevive. Os monômios sobreviventes de grau dois são então as arestas de um grafo em que cada monômio sobrevivente de grau três determina um triângulo. Se $h_2\le12$, o teorema de Kruskal–Katona dá no máximo $\binom53+\binom22=11$ triângulos, pois $12=\binom52+\binom21$. Isso contradiz $h_3=12$. Como o posto é par, ele é pelo menos 14. [Forma de Kruskal–Katona para grafos](https://ocw.mit.edu/courses/18-225-graph-theory-and-additive-combinatorics-fall-2023/mit18_225_f23_lec17-18.pdf).

## 4. Dimensões 20 e 21

Em $s=20,21$, a [cota anterior](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/0401146804e15448e519732727e00ef53be232da/research_updates/2026_11_21_walsh_mod127/SUPORTE_AFIM_VALORACAO_TRES_MOD127.md) dá $\rho_U\ge8$, portanto $r\ge35-s$, já que $q\le38$. Temos $u\ge11$ e $\dim R'\ge r-1\ge13$. Pela seção 2, $\rho_U\ge10$, logo $r\ge37-s$. Como $37-s>s-7$, segue $U\cap R=0$. A cobertura dos índices de $U$ requer ao menos três parcelas, e portanto $r\le20$. Complete $U\oplus R$ por $Z$.

### Dimensão 20

Temos $u=12$ e $r\ge17$. Uma cobertura precisa de pelo menos cinco monômios que tocam $R$, e nenhum deles toca $U$. Restam exatamente três monômios, todos inteiramente em $U$, para cobrir seus 12 índices. Em levantamentos monomiais, com $H=R\oplus Z$, isso dá

$$
\Gamma_8(A)=\Gamma_3(A|_U)\wedge\Gamma_5(A|_H).
$$

O componente de $\gamma_6(a)$ com 4 índices em $U$ e 20 em $H$ é $a|_U\wedge\gamma_5(a|_H)$. De fato, há no mínimo cinco monômios tocando $R$, de modo que o monômio restante cobre os quatro índices em $U$. Como $\gamma_6(a)=0$ e $a|_U\ne0$, segue $\gamma_5(a|_H)=0$. A congruência $\Gamma_8(A)\equiv2\bmod4$ força então $\gamma_3(a|_U)\ne0$. Pela seção 3, $\rho_U\ge14$. Logo

$$
q\ge65-20-r+14\ge39,
$$

uma contradição.

### Dimensão 21

Temos $u=11$ e $16\le r\le20$. Se $r=16$, $\rho_U\ge10$ já dá $q\ge38$, o que força $p\le128$ por orçamento e paridade.

Se $17\le r\le20$, somente três monômios da cobertura podem tocar $U$. Para cobrir seus 11 índices, pelo menos dois desses monômios precisam estar inteiramente em $U$. Se $\rho_U\le10$, o posto absoluto de $a|_U$ é também no máximo dez. Pela seção 3, podemos escolher uma base de $U$ em que a restrição esteja apoiada em no máximo seis coordenadas. Nessa base, não há dois monômios disjuntos inteiramente em $U$, contradizendo a cobertura. Logo $\rho_U\ge12$. As cotas tornam-se $q\ge39,38,37,36$ para $r=17,18,19,20$, respectivamente. Isso exclui $r=17$, força $p\le128$ em $r=18$ e $p\le132$ em $r=19$.

Em $r=20$, $Z$ tem dimensão um. Os cinco monômios que cobrem $R$ são puros, e os três restantes cobrem $H=U\oplus Z$, de dimensão 12. Segue $\Gamma_8(A)=\Gamma_5(A|_R)\wedge\Gamma_3(A|_H)$. A componente de $\gamma_6(a)$ de bidegree $(20,4)$ em $R\oplus H$ é $\gamma_5(a|_R)\wedge a|_H=0$. O único monômio que toca $U$ precisa cobrir todos os quatro índices em $H$, pois as cinco parcelas que cobrem $R$ são puras. Logo $\Gamma_5(A|_R)$ é par e $\gamma_3(a|_H)\ne0$. Como $\Lambda^2H=U\wedge H$, a cota absoluta de 14 aplica-se a $\rho_U$. Assim $q\ge38$ e $p\le128$.

Por fim, a classificação de pesos de Kasami–Tokura–Azumi exclui 130 e 132 em $\mathrm{RM}(26,32)$. Na faixa estritamente entre 128 e 160, os pesos pertencem às famílias $128+2\cdot2^{6-\ell}$ com $2\le\ell\le4$, $160-2\cdot2^i$ com $0\le i\le3$, ou $160-6\cdot2^i$ com $0\le i\le2$. O primeiro peso permitido acima de 128 é 136. Concluímos que em $s=21$ **$p=128$**, com os seguintes pares restantes sob essas cotas. [Kasami–Tokura–Azumi](https://doi.org/10.1016/S0019-9958(76)90355-7) · [Formulação dos pesos no Lema 4 de Krotov](https://arxiv.org/pdf/1811.00015).

| $r$ | Valores restantes de $q$ |
|---:|---:|
| 16, 18, 20 | 38 |
| 19 | 37, 38 |

## 5. Orçamento residual quando $s=21$ e $q=38$

Depois dos custos mínimos em $P$ e $Q$, sobram no máximo $1\,971\,040$ unidades de custo. O menor custo positivo fora de $P\cup Q$ é $8128$, atingido em $k=-127,128$. Portanto há no máximo 242 outros pontos com $T>0$, e no máximo 408 pontos no suporte total de $T$.

Seja $e=\#\{b\in P:T(b)\equiv8\bmod32\}$. O custo mínimo nessa classe é $2\,063\,496$, superior ao mínimo em $P$ por $249\,936$. Em $Q$, o primeiro custo acima do mínimo é $8\,256\,016$, com acréscimo de $508\,000$. Esses valores seguem enumerando as classes $k\bmod8128$ e tomando os representantes mais próximos de $\{0,1\}$ de cada lado. Logo

$$
249\,936\,e+508\,000\cdot\#\{b\in Q:T(b)>7\,748\,016\}
\sum_{b\notin P\cup Q}T(b)\le1\,971\,040 .
$$

Como $\sum_bT(b)\equiv0\bmod32$, reduzir a soma em $P\cup Q$ dá $24p-16e+16q\equiv0\bmod32$. Com $p=128,q=38$, $e$ é par e $e\le6$.

O ramo de valoração três permanece aberto nas dimensões afins de 21 a 32. Esta nota exclui a dimensão 20 e restringe o caso de dimensão 21 ao dobro exato do peso mínimo.

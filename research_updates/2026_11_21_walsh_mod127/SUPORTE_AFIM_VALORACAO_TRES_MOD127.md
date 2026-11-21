# Dimensão afim do suporte de valoração três no caso global módulo 127

Seja $f:\mathbb F_2^{32}\to\mathbb F_2$ de grau no máximo quatro, com $W_f=-512+2^{17}k$ e $k\bmod127\in\{0,1\}$ em todas as frequências. Escreva $a=[f]_4$ para a forma alternada de ordem quatro no espaço físico $V$, e ponha $T(b)=k(b)(k(b)-1)/2$. Usamos a congruência dos momentos $\widehat T(v)\equiv128+256f(v)\bmod512$ e o orçamento $\sum_bT(b)\le528\,531\,328$. Também usamos $\gamma_6(a)=0$ e $\Gamma_8(A)\equiv2\operatorname{vol}_{32}\bmod4$ para qualquer levantamento exterior integral $A$ de $a$. Em particular, o radical de $a$ é nulo e, em qualquer base adaptada, há pelo menos uma seleção de oito monômios quárticos disjuntos que cobre as 32 coordenadas. [Obstrução por momentos](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/b3890a40dc9536fda11679e1fc5547b180e5f600/research_updates/2026_11_21_walsh_mod127/OBSTRUCAO_CODIGO_TRIORTOGONAL_MOD127.md) · [Invariante das oito quárticas](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/a62baae440e10b095a20b33ea5013237a0d1283b/research_updates/2026_11_21_walsh_mod127/INVARIANTE_M8_WALSH_MOD127.md).

## 1. Momentos em dois conjuntos disjuntos

Defina $P=\{b:16\nmid T(b)\}$ e $Q=\{b:T(b)\equiv16\bmod32\}$. Para um produto inteiro $M$ de $d\le4$ formas afins de frequência com valores em $\{0,1\}$, a comparação das diferenças de $\widehat T$ módulo 512 dá

$$
\sum_b T(b)M(b)\equiv
\begin{cases}
0 \pmod{32}, & d\le3,\\
16a(v_1,v_2,v_3,v_4)\pmod{32}, & d=4,
\end{cases}
$$

onde $v_i$ é a parte linear da forma afim na posição $i$. Para formas lineares, basta dividir a diferença de ordem $d$ por $(-2)^d$. Em ordens até três o lado direito após a divisão é múltiplo de 32. Em ordem quatro é múltiplo de 16 e sua paridade após dividir por 16 dá $a$. O caso constante usa $\widehat T(0)\equiv0\bmod32$. Formas afins seguem expandindo cada fator como $\ell_i$ ou $1-\ell_i$ e usando as ordens inferiores.

Se pelo menos um dos fatores se anula em $P$, o produto vale zero nesses pontos. Fora de $P$, o custo $T$ é divisível por 16. Portanto, após dividir por 16, as relações acima dão os mesmos momentos binários diretamente em $Q$:

$$
\sum_{b\in Q} M(b)=
\begin{cases}
0, & d\le3,\\
a(v_1,v_2,v_3,v_4), & d=4,
\end{cases}
\qquad\text{em }\mathbb F_2 .
$$

Ponhamos $s=\dim\operatorname{aff}(P)$, $U=(\operatorname{dir}\operatorname{aff}(P))^\perp$ e $u=32-s$. Assumimos nesta seção que $P$ é não vazio e $s<32$. As formas afins que se anulam em $P$ correspondem bijetivamente, pela parte linear, aos vetores de $U$. Sua avaliação em $Q$ é injetiva: uma forma que também se anule em $Q$ dá $a(v,\cdot,\cdot,\cdot)=0$ pelo momento de ordem quatro, logo $v=0$. Em particular $Q$ é não vazio.

Seja $C$ o espaço das avaliações de todas as formas afins em $Q$, e $D\subseteq C$ o subespaço das avaliações das formas que se anulam em $P$. Escreva $R=(\operatorname{dir}\operatorname{aff}(Q))^\perp$ e $r=\dim R$. Temos

$$
\dim C=33-r,\qquad \dim D=u,\qquad
D\subseteq C^\perp,\qquad a(U,R,V,V)=0 .
$$

A ortogonalidade usa o momento de ordem dois. Para a última identidade, escolha um fator afim com parte linear em $U$ e que se anule em $P$, e outro com parte linear em $R$ e que se anule em $Q$.

Em $U\cap R$, as avaliações que se anulam em $P$ são constantes em $Q$. Pela injetividade, a interseção tem dimensão no máximo um. Se ela contém $v\ne0$, a identidade $a(U,R,V,V)=0$ implica que a contração $\iota_v a$ se anula quando um de seus argumentos está em $U+R$. Assim essa contração é suportada em um quociente de dimensão $s-r+1$. Porém cada contração não nula precisa de pelo menos oito formas lineares para suportar seu símbolo. Nesse caso $r\le s-7$. Quando a interseção é nula, a soma direta dá $r\le s$. Em ambos os casos vale $r\le s$, e podemos escolher $R'\subseteq R$ disjunto de $U$, com $\dim R'\ge r-1$. [Cota para as contrações cúbicas, seção 10.6](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/a62baae440e10b095a20b33ea5013237a0d1283b/research_updates/2026_11_21_walsh_mod127/rigidez_walsh_32_127_ramo_F.md).

Seja $L=U\wedge V\subseteq\Lambda^2 V$ e seja $\rho_U$ o posto da forma bilinear em $L$ com valor $a(x,y,z,w)$ no par $(x\wedge y,z\wedge w)$. Para uma base física adaptada a $U$, represente cada par de base de $L$ pelo produto de suas avaliações em $Q$, escolhendo para um fator de $U$ a forma afim que se anula em $P$. Pelo momento de ordem três, todos esses produtos pertencem a $C^\perp$. Sua matriz de Gram é a forma bilinear de posto $\rho_U$, pelo momento de ordem quatro. Como o radical do produto escalar em $C^\perp$ contém $D$, obtemos

$$
|Q|\ge \dim C+\dim D+\rho_U=65-s-r+\rho_U .
$$

## 2. O momento de ordem quatro e as oito quárticas

Em uma base adaptada a $U$, se todo monômio de $a$ usasse no máximo dois índices de $U$, uma cobertura disjunta por oito quárticas consumiria pelo menos 16 índices complementares. Assim, para $s\le15$, há um valor não nulo de $a$ com pelo menos três argumentos de $U$. Os seis pares entre quatro argumentos independentes de uma avaliação assim pertencem a $L$ e têm matriz de Gram de posto seis. Portanto $\rho_U\ge6$. Do mesmo modo, para $s\le23$, a cobertura força um monômio com pelo menos dois índices de $U$. Os quatro pares cruzados entre dois argumentos em $U$ e os dois restantes têm matriz de Gram invertível de ordem quatro. Logo $\rho_U\ge4$.

Há um refinamento quando existe uma avaliação não nula com pelo menos três argumentos de $U$. Suponha que $\rho_U=6$. Escolha $W\subseteq V$ de dimensão quatro em que $a$ é uma forma de volume, com $W\subseteq U$ se $a|_U\ne0$, e com $\dim(W\cap U)=3$ caso contrário. O complemento

$$
X=\{x\in V:a(w_1,w_2,w_3,x)=0\text{ para todos }w_1,w_2,w_3\in W\}
$$

satisfaz $V=W\oplus X$ e $U=(W\cap U)\oplus(U\cap X)$. A primeira decomposição vem da identificação de $W$ com $\Lambda^3W^*$ pela forma de volume. Se $\dim(W\cap U)=3$, o componente de um vetor de $U$ em $W$ pertence a $W\cap U$, pois $a|_U=0$.

A forma bilinear é não degenerada em $\Lambda^2 W\subseteq L$. Como $\rho_U=6$, qualquer elemento de $L$ ortogonal a $\Lambda^2 W$ pertence ao radical da forma em $L$. Em particular, $w\wedge x$ pertence a esse radical sempre que $w\in W$, $x\in X$ e um deles está em $U$, pela definição de $X$.

Em uma base adaptada a essas decomposições, um coeficiente de $a$ com dois índices em $W$ e dois em $X$, dos quais pelo menos dois estão em $U$, zera ao emparelhar um índice de cada espaço em cada par. Cada par pode ser escolhido com um índice de $U$. Um coeficiente com um índice em $W$ e três em $X$, dos quais pelo menos dois estão em $U$, zera escolhendo o primeiro par com um índice de cada espaço e o segundo em $X$, também com um índice de $U$. Finalmente, todo par de índices de $X$ com pelo menos um em $U$ é ortogonal a $\Lambda^2W$ pelo caso de dois índices em cada espaço, logo está no radical. Isso anula os coeficientes com quatro índices em $X$ e pelo menos dois em $U$. Os coeficientes com três índices em $W$ e um em $X$ já são nulos.

Assim, o único monômio que pode ter dois ou mais índices de $U$ é o volume de $W$. Uma cobertura disjunta por oito monômios pode cobrir no máximo $4+7=11$ índices de $U$. Concluímos que, se $u\ge12$ e existe uma avaliação não nula com pelo menos três argumentos de $U$, então $\rho_U\ge8$. O posto é par porque a forma bilinear é alternada.

A contagem se fortalece quando usamos $R'$. Como $a(U,R',V,V)=0$, numa base adaptada à soma direta $U\oplus R'$ os monômios que contêm coordenadas de $R'$ usam pelo menos $\lceil\dim(R')/4\rceil$ das oito parcelas da cobertura e não cobrem nenhum índice de $U$. Se $\dim R'\ge9$, sobram no máximo cinco parcelas para $U$. Se $u\ge11$, uma parcela precisa usar pelo menos três índices de $U$, logo $\rho_U\ge6$. O caso $\rho_U=6$ já analisado permitiria cobrir no máximo $4+4=8$ índices de $U$. Assim, quando $\dim R'\ge9$ e $u\ge11$, vale $\rho_U\ge8$.

## 3. Exclusão de um par de dimensões

Suponha que $U$ e $R$ sejam disjuntos, com dimensões 13 e 16, respectivamente, e que $a(U,R,V,V)=0$. Complete-os por um subespaço $Z$ de dimensão três e escreva $B=U\oplus Z$. Ponha $a_R=a|_R$ e $a_B=a|_B$, vistas como formas nos respectivos espaços. Os monômios de $a$ podem tocar $U$ ou $R$, mas nunca ambos.

Na oitava potência dividida, cobrir os 13 índices de $U$ e os 16 de $R$ exige quatro parcelas para cada. As quatro parcelas que tocam $R$ precisam estar inteiramente em $R$. Portanto, com levantamentos monomiais,

$$
\Gamma_8(A)=\Gamma_4(A_R)\wedge\Gamma_4(A_B).
$$

O componente de bidegree $(16,8)$ em $R\oplus B$ de $\gamma_6(a)$ é $\gamma_4(a_R)\wedge\gamma_2(a_B)$. Para ver isso, entre os oito índices em $B$ há pelo menos cinco de $U$, logo pelo menos duas parcelas que tocam $U$. Sobram quatro para os 16 índices de $R$, necessariamente puras. O bidegree $(8,16)$ dá, da mesma maneira, $\gamma_2(a_R)\wedge\gamma_4(a_B)=0$, pois são necessários quatro monômios para os 13 índices de $U$. Se ambos os coeficientes de volume das quartas potências divididas forem pares, o produto é múltiplo de quatro. Se um deles for ímpar, uma das duas identidades força que a segunda potência dividida da outra forma seja par coeficiente a coeficiente. Nesse caso sua quarta potência dividida é múltipla de quatro por $\Gamma_2(\Gamma_2(A))=3\Gamma_4(A)$. Em todos os casos $\Gamma_8(A)\equiv0\bmod4$, uma contradição.

## 4. Aplicação à menor valoração três

Suponha que a menor valoração 2-ádica de $T(b)$ entre os valores não nulos seja três. Então $P=\{b:\nu_2(T(b))=3\}$. Pelo [argumento dos momentos](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/b3890a40dc9536fda11679e1fc5547b180e5f600/research_updates/2026_11_21_walsh_mod127/OBSTRUCAO_CODIGO_TRIORTOGONAL_MOD127.md), $P$ tem todos os momentos até ordem cinco nulos. Portanto sua função indicadora está em $\mathrm{RM}(26,32)$, por dualidade de Reed–Muller. Os custos mínimos em $P$ e $Q$ são, respectivamente, $1\,813\,560$ e $7\,748\,016$. Assim, com $p=|P|$ e $q=|Q|$,

$$
1\,813\,560\,p+7\,748\,016\,q\le528\,531\,328 .
$$

Se $p=64$, o suporte é um subespaço afim de dimensão seis. Se $64<p<128$, as formas de Kasami–Tokura mostram que $p\ge96$ e $s\le12$. Na forma do produto de 24 coordenadas com uma quadrática, o suporte fica em dimensão oito. Na forma do produto de $26-\ell$ coordenadas com a soma de dois produtos de $\ell$ fatores, fica em dimensão $6+\ell\le12$. O peso mínimo também segue dessas formas. [Kasami–Tokura, teorema de pesos abaixo de dois mínimos](https://doi.org/10.1109/TIT.1970.1054545) · [Formulação explícita das formas normais, Teorema 2](https://eprint.iacr.org/2018/1194.pdf).

Para $s\le15$, as duas primeiras seções dão $q\ge71-2s$. Se $p=64$ isso exige $q\ge59$, acima da cota orçamentária 53. Se $64<p<128$, exige $q\ge47$, acima da cota 45. Portanto $p\ge128$ e $q\le38$. Isso exclui também $s\le15$, quando $q\ge41$.

Considere agora $16\le s\le19$. Pela cota $\rho_U\ge4$, temos $r\ge31-s\ge12$. Assim $\dim R'\ge11$ e $u\ge13$, de modo que o refinamento da seção 2 dá $\rho_U\ge8$. Resulta $r\ge35-s$. A hipótese $U\cap R\ne0$ exigiria $r\le s-7$, o que é incompatível com $r\ge35-s$ nesse intervalo. Logo $U$ e $R$ são disjuntos. Pela cobertura de oito monômios, $\lceil u/4\rceil+\lceil r/4\rceil\le8$, de modo que $r\le16$ pois $u\ge13$. Para $s\le18$ isso contradiz $r\ge35-s$. Resta $s=19,r=16$, com $u=13$, que a seção 3 exclui.

Concluímos **$128\le p\le290$ e $s\ge20$**. A cota superior arredonda o limite orçamentário 291 para um inteiro par. Para $s=20,21$, a cota inicial $\rho_U\ge4$ ainda dá $r\ge31-s\ge10$ e $\dim R'\ge9$, enquanto $u\ge11$. Então $q\ge73-2s$ e o mesmo orçamento dá $p\le150$ para $s=20$, e $p\le158$ para $s=21$. Para $s=22,23$ as cotas são, respectivamente, $p\le184$ e $p\le192$, usando $q\ge69-2s$ e paridade.

## Consequência global e escopo

Qualquer candidato no caso global tem pelo menos **128 frequências com $16\nmid T(b)$**. Com valoração mínima zero, um ou dois, a cota anterior pelos momentos já dá, respectivamente, 512, 256 ou 128 frequências no primeiro nível não nulo. Com valoração mínima três, vale a nova cota acima. O caso global segue aberto. A valoração três ainda admite suportes de dimensão afim pelo menos 20 sujeitos às cotas dadas nesta nota.

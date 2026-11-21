# Obstrução por momentos binários no caso global módulo 127

Suponha que $f:\mathbb F_2^{32}\to\mathbb F_2$ tenha grau no máximo quatro e satisfaça

$$
W_f(b)=-512+2^{17}k(b),\qquad k(b)\bmod127\in\{0,1\}.
$$

Escreva $a_f=[f]_4$ para a forma alternada quártica, $s=(-1)^f$, $s_0=s(0)$ e $T(b)=k(b)(k(b)-1)/2$. As transformadas de Walsh são não normalizadas. Provamos que **$T$ não é divisível por 16 em todos os pontos**, sem hipótese de decomposição do símbolo ou de uma restrição física.

## 1. Congruência dos momentos espectrais

Por inversão de Walsh e Parseval,

$$
\sum_b T(b)=127^2\,2^{15}-127\cdot128\,s_0.
$$

Se $\Delta_f(a)=\sum_xs(x)s(x+a)$, a identidade de Wiener–Khinchin e a expansão do quadrado dão

$$
\widehat T(a)=\Delta_f(a)/8-16256s(a)-8355840\,\mathbf1_{\{a=0\}}.
$$

Para $a\ne0$, a derivada $f(x)+f(x+a)$ tem grau no máximo três e é constante nas órbitas de $\langle a\rangle$. Em coordenadas do quociente de dimensão 31, a expansão da soma de sinais por monômios dá divisibilidade por $2^{\lceil31/3\rceil}=2^{11}$. O fator dois do quociente dá $2^{12}\mid\Delta_f(a)$. A mesma divisibilidade é imediata em $a=0$. Logo

$$
\widehat T(a)\equiv128+256f(a)\pmod{512}.
$$

Suponha por contradição que $16\mid T(b)$ para todo $b$. Defina $P=\{b:T(b)/16\text{ é ímpar}\}$. Para direções físicas $v_1,\ldots,v_d$, a diferença iterada em zero de $\widehat T$ é

$$
(-2)^d\sum_b T(b)\prod_{i=1}^d(v_i\cdot b),
$$

onde cada $v_i\cdot b$ é avaliado como um inteiro em $\{0,1\}$. Comparar módulo 512 dá, em $\mathbb F_2$,

$$
\sum_{b\in P}\prod_{i=1}^d(v_i\cdot b)=
\begin{cases}
0 & 1\le d\le3,\\
a_f(v_1,v_2,v_3,v_4)& d=4.
\end{cases}
$$

De fato, para $d\le3$, o fator $2^d\cdot16$ deixa pelo menos um fator dois de $256$. Para $d=4$, o fator é exatamente 256 e a quarta diferença de $f$ módulo dois avalia sua forma de topo. O caso de direções repetidas é coberto pela mesma identidade. Também $|P|$ é par pela congruência de $\widehat T(0)$.

## 2. O momento quártico exige pelo menos 72 pontos

A forma alternada $a_f$ tem radical nulo pelo Teorema G1 da [revisão](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/a62baae440e10b095a20b33ea5013237a0d1283b/research_updates/2026_11_21_walsh_mod127/rigidez_walsh_32_127_ramo_F.md). Isso também decorre da congruência $\Gamma_8(A)\equiv2\bmod4$ do [invariante das oito quárticas](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/a62baae440e10b095a20b33ea5013237a0d1283b/research_updates/2026_11_21_walsh_mod127/INVARIANTE_M8_WALSH_MOD127.md). Uma direção no radical permitiria escolher um levantamento exterior de $a_f$ com apenas 31 coordenadas, cuja oitava potência dividida seria zero.

Para cada $v\in\mathbb F_2^{32}$, defina $c(v)=(v\cdot b)_{b\in P}\in\mathbb F_2^P$. Seja $C$ o espaço das avaliações afins, gerado pelos $c(v)$ e pela palavra constante $\mathbf1$. Se $c(v)$ for constante, o momento quártico $a_f(v,w,u,z)$ se reduz a zero ou ao momento cúbico, que também é zero. Pelo radical nulo, $v=0$. Como $a_f\ne0$, $P$ não é vazio. Logo $\dim C=33$.

Os momentos até ordem dois dão $C\subseteq C^\perp$ para o produto escalar usual de $\mathbb F_2^P$. Denote por $c(v)c(w)$ o produto coordenada a coordenada. Os momentos de ordens dois e três mostram que cada $c(v)c(w)$ está em $C^\perp$. O produto escalar de dois desses produtos é o momento de ordem quatro e pode ser calculado no quociente $C^\perp/C$, de dimensão $|P|-66$.

Como $a_f\ne0$, escolha $v_1,v_2,v_3,v_4$ com $a_f(v_1,v_2,v_3,v_4)=1$. As seis classes de $c(v_i)c(v_j)$, $i<j$, têm matriz de Gram igual à matriz que emparelha cada par $\{i,j\}$ ao seu complementar em $\{1,2,3,4\}$. De fato, o momento de ordem quatro vale um para índices distintos e zero se há repetição. Esta matriz é invertível, logo as seis classes são independentes. Concluímos que

$$
|P|-66\ge6,\qquad |P|\ge72.
$$

## 3. O orçamento permite no máximo 68 pontos

Para $b\in P$, $T(b)\equiv16\bmod32$, isto é, $k(b)(k(b)-1)\equiv32\bmod64$. Exatamente um dos dois fatores é par. Assim, $k(b)\equiv32$ ou $33\bmod64$. Com $k(b)\equiv0,1\bmod127$, o teorema chinês dos restos dá quatro classes módulo $8128$, representadas por

$$
3937,\quad4064,\quad4065,\quad4192.
$$

Os representantes adjacentes do lado negativo são $-4191,-4064,-4063,-3936$. Como $k(k-1)/2$ cresce ao afastar-se de $\{0,1\}$ em cada semirreta, seu menor valor nas quatro classes é $7\,748\,016$, atingido por $k=-3936,3937$. Portanto

$$
|P|\le
\left\lfloor\frac{127^2\,2^{15}+127\cdot128}{7\,748\,016}\right\rfloor=68,
$$

em contradição com a seção anterior. A aritmética usa valores inteiros.

## 4. Os quatro níveis de divisibilidade restantes

Como $\sum T>0$, seja $i$ a menor valoração 2-ádica entre os custos não nulos. Acabamos de provar $0\le i\le3$. Ponha $P_i=\{b:T(b)/2^i\text{ é ímpar}\}$. Os momentos binários de $P_i$ de ordem $d\le 8-i$ são nulos. Para $d=0$, use $\widehat T(0)\equiv128\bmod256$. Para $1\le d\le4$, divida a diferença iterada por $2^{d+i}$ e note $d+i\le7$. Para $5\le d\le8-i$, a diferença de ordem $d$ de $f$ é par porque o grau booleano é quatro, e o lado direito já é múltiplo de 512. Também são nulos os momentos dos monômios afins de grau até $8-i$, por expansão.

Um conjunto binário não vazio com todos os momentos de grau até $t$ nulos contém pelo menos $2^{t+1}$ pontos. Para $t=0$ sua cardinalidade é par. Para $t>0$, escolha um hiperplano que separe dois pontos. As duas fatias não vazias conservam os momentos nulos até $t-1$, pois multiplicar cada monômio pelo indicador afim da fatia eleva o grau em no máximo um. A indução dá a cota. Aplicando-a a $P_i$ e comparando com o menor custo em cada classe CRT, resulta

| $i$ | Menor custo em $P_i$ | Limite inferior para $|P_i|$ | Limite superior para $|P_i|$ |
|---:|---:|---:|---:|
| 0 | $8\,001$ | 512 | $66\,058$ |
| 1 | $72\,390$ | 256 | $7\,301$ |
| 2 | $394\,716$ | 128 | $1\,339$ |
| 3 | $1\,813\,560$ | 64 | 291 |

Em particular, qualquer candidato carrega pelo menos 64 exceções de valoração estritamente menor que quatro. O caso global permanece aberto nos níveis acima. A exclusão de $16\mid T$ é algébrica e não depende dos perfis em cinco ou seis controles.

## Princípio geral

Para um conjunto de pontos binários que realize uma 4-forma alternada pelos momentos de ordem quatro e tenha todos os momentos até ordem três nulos, o tamanho do conjunto é pelo menos $2r+\rho$. Aqui $r$ é a dimensão do espaço de avaliações afins e $\rho$ é o posto da forma bilinear em $\Lambda^2$ induzida pela 4-forma. Os produtos coordenada a coordenada das avaliações lineares pertencem a $C^\perp$. Escolher uma base física e enviar cada cunha de dois vetores de base ao produto das respectivas avaliações dá uma aplicação linear de $\Lambda^2$ em $C^\perp/C$. A forma bilinear é o recuo do produto escalar nesse quociente. Se a 4-forma tem radical nulo, $r$ é a dimensão ambiente mais um. A demonstração acima usa apenas $\rho\ge6$.

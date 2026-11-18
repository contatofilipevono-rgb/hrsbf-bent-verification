# Rigidez modular em módulo 17: exclusão do ramo ímpar $Q=1$

Seja $f:\mathbb F_2^{20}\to\mathbb F_2$ de grau no máximo quatro, $s=(-1)^f$ e $X=W_f/32$, com transformada de Walsh não normalizada. Suponha que $X(b)\equiv\pm2\pmod{17}$ para todo $b$ e que, na normalização ímpar, $X\equiv5+8D\pmod{16}$. Isso é o ramo $Q=1$: $X\equiv1\pmod 4$ e seu bit de peso quatro é sempre um. Este ramo é impossível.

## 1. Normalização até módulo 64

A divisibilidade de somas de sinais de grau quatro implica $X$ inteiro. Para o coeficiente inteiro de Möbius $c_S(X)$, se $|S|=j\ge 1$, temos

$$
c_S(X)=\frac{(-2)^j}{32}\sum_{x:x_i=1\ (i\in S)}s(x),\qquad
v_2(c_S(X))\ge\left\lceil 3j/4\right\rceil .
$$

Como $X\equiv5\pmod8$, o bit $D=(X-5)/8\bmod2$ tem grau no máximo quatro. Walsh inverso e Parseval dão $\mathbb E X=s(0)/32$ e $\mathbb E X^2=1024$.

Escreva $L=53-72D$, $Y=(-1)^D(X-L)$ e $e=(X-53)(X+19)=Y(Y+72)$. As duas congruências de $X$ implicam $Y\in\{0,64\}+272\mathbb Z$; logo $e\ge0$ e

$$
\mathbb E e=17-\frac{17}{16}s(0)\le\frac{289}{16}.
$$

O bit $(X-L)/16\bmod2$ tem grau no máximo oito. De fato, para grau $j>8$, $c_S(X)$ é zero módulo 32, e o levantamento inteiro de $72D$ módulo 32 usa produtos de no máximo dois monômios da ANF de $D$. Quando esse bit é um, $Y=64a+272k$ com $a\in\{0,1\}$ e $k$ ímpar, e o mínimo de $e$ é $28288$, em $Y=-208$. A distância mínima de Reed–Muller exclui suporte não vazio, pois $(289/16)/28288<2^{-8}$. Assim $32\mid X-L$.

O bit $(X-L)/32\bmod2$ tem grau no máximo doze pelo argumento análogo módulo 64 com até três monômios. Depois da exclusão do primeiro bit, quando esse segundo bit é um temos $k\equiv2\pmod4$. Seu menor custo é $195840$, em $Y=-480$. Como $(289/16)/195840<2^{-12}$, este bit também é zero. Logo $X\equiv L\pmod{64}$.

## 2. Uma função inteira de massa pequena

Temos $Y=64t$ com $t\equiv0,1\pmod{17}$. Defina

$$
H=\frac{e}{8704}=\frac{t(9+8t)}{17}\in\mathbb Z_{\ge0}.
$$

Se $N=2^{20}$, sua massa $T=\sum H$ é $2048-128s(0)$, portanto 1920 ou 2176. Para cada direção não nula $a$, a autocorrelação $A(a)=\sum_x s(x)s(x+a)$ é múltipla de $17$ pela identidade $\mathcal W(X^2)=(N/1024)A$ e por $X^2\equiv4\pmod{17}$. Também é múltipla de $256$: $D_a f$ tem grau no máximo três, é constante nas classes da direção $a$, e a soma de sinais no quociente de dimensão 19 é múltipla de $2^7$.

Em todas as frequências,

$$
W_H(a)=\frac{2}{17}A(a)-128s(a)-\frac{1007\cdot 2048}{17}\mathbf1_{a=0}.
$$

Em $a=0$ os primeiro e terceiro termos somam 2048. Em $a\ne0$ o primeiro termo é múltiplo de 512. Em particular $W_H\equiv-128s\pmod{512}$, portanto $W_H\equiv128\pmod{256}$.

## 3. A paridade de $H$ tem grau no máximo dez

Escreva $G=H\bmod2$. Para qualquer suporte $S$ de tamanho $j\le9$, basta que $c_S(W_H)$ seja múltiplo de $2^{j+1}$, pois

$$
c_S(W_H)=(-2)^j\sum_{x:x_i=1\ (i\in S)} H(x).
$$

Essas somas pares dão $G\perp \operatorname{RM}(9,20)$, ou $G\in\operatorname{RM}(10,20)$. Para $j\le6$, a divisibilidade segue do fator 128. Para $j=7,8$, a congruência módulo 512 e a expansão da ANF de $f$ dão $v_2(c_S(s))\ge\lceil j/4\rceil\ge2$.

Para $j=9$, a mesma expansão dá $v_2(c_S(s))\ge3$. Para a autocorrelação, decomponha $x$ em nove coordenadas de $S$ e onze auxiliares $y$. Somando sobre deslocamentos apoiados em $S$, depois substituindo o par deslocamento e entrada pelo par de entradas, obtemos

$$
c_S(A)=(-1)^9\sum_{y\in\mathbb F_2^{11}}\Phi(y)^2,
\qquad
\Phi(y)=\sum_{u\in\mathbb F_2^9}(-1)^{f(u,y)+\sum_i u_i}.
$$

O coeficiente inteiro de $\Phi$ em um monômio de tamanho $j'$ nas coordenadas $y$ tem valuação pelo menos $\lceil(9+j')/4\rceil$. Para a verificação, expanda o produto dos fatores $1-2m$ da função sinal. Um termo com $k$ monômios e união de $r$ coordenadas $u$ tem valuação pelo menos $k+9-r$. Como $r\le\min(9,4k-j')$, essa valuação é pelo menos $\max(k,9+j'-3k)\ge(9+j')/4$.

Ponha $V=\Phi/8$, $a=V\bmod2$ e $b$ seu bit de peso dois. A cota acima dá $\deg a\le3$, $\deg b\le7$, porque carregamentos do bit inferior usam pares de monômios de grau no máximo três. Como

$$
\sum_y V(y)^2 \equiv \operatorname{wt}(a)+4\operatorname{wt}((1+a)b)\pmod8,
$$

a soma é múltipla de oito. O primeiro peso é múltiplo de oito pela divisibilidade de pesos cúbicos em onze variáveis. O segundo peso é par pois o polinômio tem grau no máximo dez. Segue $512\mid c_S(A)$. O termo de origem na expressão de $W_H$ tem valuação 11, logo $1024\mid c_S(W_H)$, como necessário.

## 4. Exclusão de todos os perfis de massa

Escreva $H=G+P$, onde $P$ é não negativa, par, e só tem suporte nos pontos com $H>1$. Para tais pontos, enumerando $t\equiv0,1\bmod17$ e $H\le2176$, os possíveis valores de $H$ são

$$
112,127,145,162,495,526,562,595,1150,1197,1251,1300,2077,2140.
$$

Parseval e $|W_H|\ge128$ dão $\sum H^2\ge128^2$. Em particular existe ao menos um ponto com $H>1$. Para cada lista não ordenada de tais valores $h_i$, a massa da paridade é $w=T-\sum_i(h_i-(h_i\bmod2))$ e $\sum H^2=w+\sum_i(h_i^2-(h_i\bmod2))$. Kasami–Tokura limita $0<w<2048$ aos valores $2048-1024/2^j$, $0\le j\le9$. A enumeração finita em `verify_q1_arithmetic.py` usa somente essa restrição e as duas identidades de massa. Todos os pesos acima de 2048 ficam inicialmente permitidos. O resultado é:

| $T$ | Peso $w$ | Número de perfis preliminares |
| --- | ---: | ---: |
| 1920 | 0 | 80 |
| 1920 | 1024 | 1 |
| 2176 | 0 | 138 |
| 2176 | 1024 | 9 |
| 2176 | 1920 | 1 |
| 2176 | 2032 | 1 |
| 2176 | 2050 | 1 |

Usamos o seguinte fato elementar. Se $W_P\equiv128\bmod256$, a massa de $P$ em todo flat afim de codimensão $1\le c\le8$ é divisível por $2^{8-c}$, por média dos caracteres. Também, para isolar um ponto num conjunto finito, um corte por hiperplano passando pelo ponto consegue reter no máximo a metade dos demais, arredondada para baixo. Isso segue da média sobre todas as formas lineares e pode ser repetido sobre os sobreviventes.

- **$w=0$.** $H=P$ tem no máximo 19 pontos no suporte. Cada ponto pode ser isolado com até 5 hiperplanos, logo sua massa é múltipla de 8. O único valor possível da lista divisível por 8 é 112 e $T$ não é múltiplo de 112.
- **$w=1024$.** $G$ é o indicador de um flat de dimensão dez, de forma que $W_G\equiv0\bmod256$. Logo $W_P\equiv128\bmod256$. Há no máximo dez pontos com $P>0$, e isolamento por até quatro hiperplanos força $16\mid P(x)$. Os únicos valores possíveis são 112 e 144. Portanto $(P/16)\bmod2$ é o indicador do suporte de $P$. A congruência $W_{P/16}\equiv8\bmod16$ implica que seu peso é par em todo flat de codimensão até três, incluindo o espaço inteiro. Seu indicador é ortogonal a $\operatorname{RM}(3,20)$, daí tem grau no máximo 16 e precisa de pelo menos 16 pontos.
- **$w=1920$.** Pelo teorema de Kasami–Tokura, salvo transformação afim, $G$ é uma quadrática de posto oito num flat de dimensão 12, estendida por zero, ou a diferença simétrica de dois flats de dimensão dez com interseção de dimensão seis. Nos dois casos $128\mid W_G$: no primeiro isto vem do espectro quadrático de amplitude 256 para o sinal; no segundo, da identidade inteira dos indicadores, que subtrai duas vezes a interseção. O perfil único dá $P=112\delta_p+144\delta_q$ para $p\ne q$. Um caráter que separa os dois pontos faz $W_P$ igual a $32$ ou $-32$, contrariando $128\mid W_H$.
- **$w=2032$.** A forma de Kasami–Tokura é uma diferença simétrica de dois flats de dimensão dez que se intersectam em dimensão três. A forma quadrática exigiria posto 14 no flat de dimensão 12. O suporte de $W_G$ está contido na união dos aniquiladores das direções dos três flats, de tamanho no máximo $2\cdot2^{10}+2^{17}<2^{20}$. Num zero de $W_G$ temos $W_H=W_P=\pm144$, contrariando a divisibilidade por 128.
- **$w=2050$.** O perfil único dá $P=126\delta_p$, portanto $W_G\equiv2(-1)^{p\cdot a}\bmod256$. Translade $p$ para a origem, obtendo resíduo constante 2. Restrinja sucessivamente ao hiperplano ortogonal a uma frequência não nula com $W_G=2$. Depois de $k$ cortes, valem peso $2048/2^k+2$ e congruência $2\bmod(256/2^k)$, por média de duas frequências. Para $k=0,\ldots,4$, a frequência necessária sempre existe: se faltasse, todo coeficiente não trivial teria módulo pelo menos $256/2^k-2$, e o trivial também. Seu quadrado excede $2048/2^k+2$, contrariando Parseval. Ao fim, o peso seria 66 em $\operatorname{RM}(10,15)$. O espectro conhecido de $\operatorname{RM}(m-5,m)$ exclui 66, pelo Teorema 3 de Carlet.

Isto contradiz todos os perfis do ramo $Q=1$.

## Referências

- T. Kasami e N. Tokura. *On the weight structure of Reed-Muller codes*. [DOI](https://doi.org/10.1109/TIT.1970.1054545).
- C. Carlet. *The Weight Spectrum of the Reed-Muller Codes RM(m−5,m)*. IEEE Transactions on Information Theory 70(7), 4799–4807, Teorema 3. [DOI](https://doi.org/10.1109/TIT.2023.3343697) · [Versão aberta](https://doi.org/10.36227/techrxiv.23662062.v1).

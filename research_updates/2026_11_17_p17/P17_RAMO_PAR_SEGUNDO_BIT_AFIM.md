# Ramo par com segundo bit afim não constante

Este complemento trata a situação em que $X=W_f/32$ é par e o bit $(X/2)\bmod2$ é afim não constante. Como nas outras notas, $f$ tem grau no máximo quatro em 20 variáveis e $X\equiv\pm2\bmod17$.

Seja $F$ o hiperplano $X\equiv2\bmod4$. No outro hiperplano, $X$ é múltiplo de quatro e $|X|\ge32$ pela congruência módulo 17. Parseval dá $\mathbb E_F X^2\le1024$. Em $F$, defina $Q,D,Y,L$ como na nota do ramo par, com posto polar $2h$ para $Q$. A fórmula de coeficientes inteiros é válida após restrição afim, de modo que $\deg Q\le2$ e $\deg D\le4$ no domínio de 19 dimensões.

Para cada frequência do dual de $F$, o coeficiente normalizado de Fourier de $X|_F$ é a soma de dois coeficientes de Fourier de $X$ com sinal apropriado. Cada parcela tem módulo $1/32$, o que dá $\|\widehat{X|_F}\|_\infty\le1/16$. Segue $|\mathbb E_F Y|\le2^h/16$. Com $w=\mathbb E_F D$,

$$
w\le\min(5/24,\,(17+2^h/16)/144),\qquad
\mathbb E_F L\le1156-9792w+68\cdot 2^h/16.
$$

Quando $w\ge1/8$, o limite de peso exclui $h\le3$. Para $h=5,6,7$, os limites de peso e energia são os mesmos do ramo par global nos semipostos $6,7,8$, respectivamente. Os flats de Klein–Storme são tomados dentro de $F$, com codimensões relativas a $F$. A demonstração do custo de cada ponto ruim e os limites de densidade em blocos simpléticos independem da codimensão total: todo 6-flat está no espaço original de 20 coordenadas e Poisson ainda deixa uma soma em 14 coordenadas. Assim as cotas calculadas na nota par valem com médias em $F$.

Para $h=5$ ou $6$, o flat de codimensão relativa dois tem posto pelo menos seis, e o custo médio em $F$ é pelo menos 221, excedendo o orçamento máximo 204. Para $h=7$, nos três intervalos dos pesos separados por $5/32$ e $11/64$, os flats de codimensões relativas dois, três e quatro contêm blocos simpléticos de dimensão oito, oito e seis. Seus custos médios em $F$ são pelo menos $552{,}5,\ 276{,}25,\ 55{,}25$, contra os orçamentos máximos $476,\ 170,\ 17$.

Portanto, entre candidatos com $w\ge1/8$ neste hiperplano, ficam apenas os semipostos $h=4,8,9$. A região $w<1/8$ requer tratamento próprio. As cotas usam o Teorema 3 de [Klein–Storme](https://doi.org/10.3934/amc.2011.5.333) e os mesmos cálculos de pesos e momentos da nota principal do ramo par.

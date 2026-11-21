# Walsh módulo 127 após fixar cinco controles

Suponha que $f$ seja uma função booleana de grau no máximo quatro em 32 variáveis e que $W_f=-512+2^{17}k$ com $k\bmod127\in\{0,1\}$ em todas as frequências. Todos os espectros abaixo são não normalizados. Considere uma restrição linear de codimensão cinco que se decomponha em dois blocos físicos independentes.

## 1. De duas classes espectrais a sete resíduos

O [verificador de decomposições](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/a62baae440e10b095a20b33ea5013237a0d1283b/research_updates/2026_11_21_walsh_mod127/verifica_invariante_M8.py) deixa, a menos de permutação, apenas as dimensões $(4,23)$ e as valorações espectrais $(1,8)$. Escreva $A_1=W_{g_1}/2$ para o bloco pequeno e $A=W_g/256$ para o núcleo. A projeção de Walsh impõe $A_1A\equiv-1\pmod8$ sempre. Por Parseval e inversão, $\mathbb E A_1^2=4$ e $\mathbb E A_1=\pm1/2$. Os valores mais próximos de zero de cada sinal, $x$ e $-y$, satisfazem $x+y\equiv0\pmod8$ e $xy-|x-y|/2\le4$. Resulta $x+y\le8$, com $(x,y)=(1,7)$ ou $(7,1)$. Pode-se inverter ambos os sinais dos blocos e obter a primeira opção. A desigualdade pontual $(A_1-1)(A_1+7)\ge0$ então força $\mathbb E A_1=1/2$ e igualdade pontual. Assim $A_1$ assume exatamente os valores $1,-7$.

Seja $D=\{-1+8s:0\le s\le32\}\bmod127$. Por Poisson, para cada par de frequências do corte, $W_{g_1}W_g/512=-1+8\sum_{u\in\mathbb F_2^5}k(u,b)$, cuja redução pertence a $D$. Daí $A\equiv-1\pmod8$ e $A,-7A\bmod127\in D$. Escrevendo $A=8q-1$, a última condição equivale a $q\equiv s\bmod127$ com $s\in[0,32]$ e $1-7s\bmod127\in[0,32]$. Explicitamente,

$$
q\bmod127\in\{0,14,15,16,17,18,32\}.
$$

Por Parseval e inversão no núcleo, $\mathbb E A^2=128$ e $\mathbb E A=\pm1/256$. Para qualquer flat espectral $J$ de codimensão $c$ no núcleo, Poisson dá $|\mathbb E_J A|\le 2^c/256$. Isso usa que a média é $1/256$ vezes um coeficiente de Walsh de uma restrição física a $c$ variáveis.

## 2. Anular quatro bits do núcleo

Sempre que $A\equiv-1\pmod{2^j}$, defina $B_j=((A+1)/2^j)\bmod2$. O coeficiente multilinear inteiro de ordem $d>0$ de $W_g$ é, a menos de sinal, $2^d$ vezes uma soma de sinais de uma restrição afim de $g$ a $23-d$ variáveis. A expansão monomial dá valoração ao menos $d+\lceil(23-d)/4\rceil$. Logo $\deg B_j\le\lfloor(4(8+j)-23)/3\rfloor$. Para $j=3,4,5,6$ as cotas são $7,8,9,11$.

**Bit 3.** Onde $B_3=1$, $q$ é ímpar e os sete resíduos impõem $A\ge119$ ou $A\le-761$. Como $A$ é ímpar, a densidade de $B_3$ é no máximo $127/(119^2-1)$, inferior a $3/(2\cdot128)$. Se $B_3$ for não nulo, pelo peso mínimo e pelo segundo peso de Reed–Muller, ele é o indicador de um flat $J$ de codimensão sete. Ali $(A-119)(A+761)\ge0$, logo $\mathbb E_J A^2\ge119\cdot761-642/2$. Sua contribuição global, dividida por 128, excede 128. Portanto $B_3=0$.

**Bit 4.** Suponha $B_4\ne0$, com densidade $w$. Onde $B_4=1$, o módulo de $A$ é pelo menos $111$, então cada ponto paga ao menos $12320$ em $A^2-1$. Em um flat $J$ de zeros de $B_4$, $A\equiv-1\pmod{32}$. Os sete resíduos acima excluem todo $-1<A<127$ nessa classe. Logo $(A+1)(A-127)\ge0$ em $J$, e a contribuição de $J$ para $\mathbb E(A^2-1)$ é pelo menos

$$
126(2^{-c}-1/256),\qquad c=\operatorname{codim}J.
$$

Primeiro $w\le127/12320<(3-1/4)/256$. O [Teorema 3 de Klein–Storme](https://doi.org/10.3934/amc.2011.5.333), aplicado com $k=3$, dá um flat de zeros de codimensão no máximo três. Deduzir seu custo do orçamento $127$ dá $w<(5/2)/256$. O mesmo teorema com $k=2$ dá um flat de zeros de codimensão no máximo dois. Deduzir seu custo da mesma maneira dá $w<2/256$. As duas deduções são separadas, pois os flats podem se cruzar.

Nesse intervalo, [Kasami–Tokura](https://doi.org/10.1109/TIT.1970.1054545) dá duas formas afins possíveis. Na forma com seis fatores afins comuns e um quadrático, os dois primeiros fatores fornecem dois flats de zeros disjuntos, de codimensões um e dois. O custo deles, somado ao custo do suporte de densidade ao menos $1/256$, é pelo menos

$$
126(3/4-2/256)+12320/256>127.
$$

Na outra forma, há um produto de fatores comuns vezes a soma booleana de dois produtos independentes de $\mu\ge3$ fatores. O suporte tem densidade $(2-2^{1-\mu})/256\ge7/1024$. Se há fator comum, seu zero fornece um hiperplano de zeros. Se não há, escolha dois fatores de cada bloco e separe o primeiro zero entre os dois escolhidos em cada bloco. Isso dá quatro flats de zeros disjuntos, de codimensões $2,3,3,4$, com densidade conjunta $9/16$. Os custos inferiores são, respectivamente,

$$
126(1/2-1/256)+12320\cdot7/1024>127,\qquad
126(9/16-4/256)+12320\cdot7/1024>127 .
$$

Ambos os regimes são impossíveis. Assim $B_4=0$.

**Bits 5 e 6.** Já vale $A\equiv-1\pmod{32}$, então $E(A)=(A+1)(A-127)\ge0$ em todo o espectro, com

$$
\mathbb E E(A) = 1-126\mathbb E A\le1+126/256 .
$$

Se $|A|\le512$, os sete resíduos dão $q\in\{0,14,15,16,17,18,32\}$. Nenhum desses inteiros é $4\bmod 8$ ou $8\bmod16$. Assim $B_5=1$ ou, depois de anular $B_5$, $B_6=1$ exigiria $|A|\ge513$. Isso custa ao menos $(513+1)(513-127)$ em $E(A)$. Mesmo ponderado pela menor densidade relevante $2^{-11}$, o custo excede $1+126/256$. Conclui-se $A\equiv-1\pmod{128}$ em todas as frequências.

## 3. Forma residual do núcleo

Escreva $A=-1+128K$ e $\sigma=(-1)^{g(0)}$. As identidades de momentos e os resíduos dão

$$
\sum_b K=65536+256\sigma,\qquad
\sum_b K^2=66048+4\sigma,\qquad
\sum_b\frac{K(K-1)}2=256-126\sigma .
$$

O terceiro somatório é não negativo termo a termo e vale $130$ ou $382$. Logo $-27\le K\le28$. Com $K\equiv A+1\pmod{127}$, os únicos valores admissíveis são

$$
K\in\{-15,-7,0,1,2,9,17\}.
$$

O custo $K(K-1)/2$ de um valor fora de $\{0,1,2\}$ é pelo menos 28 e múltiplo de quatro. Por isso o número de ocorrências de $K=2$ é $2\bmod4$, e há no máximo quatro outras exceções quando $\sigma=1$ e no máximo treze quando $\sigma=-1$.

Em todo flat físico de dimensões 12, 16 e 20 dentro do núcleo, a congruência $W_g\equiv-256\pmod{32768}$ e Poisson dão valorações estritamente maiores que três, quatro e cinco, respectivamente. Nesses tamanhos a contribuição de valoração mínima é a paridade da cobertura por quárticas disjuntas. Portanto $\gamma_3([g]_4)=\gamma_4([g]_4)=\gamma_5([g]_4)=0$.

O caso global e a existência desse núcleo residual seguem em aberto. A lista de sete valores é uma condição necessária sob a hipótese de decomposição em dois blocos após fixar cinco controles.

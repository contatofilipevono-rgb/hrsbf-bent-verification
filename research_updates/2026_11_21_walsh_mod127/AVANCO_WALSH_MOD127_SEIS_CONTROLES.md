# Novas restrições para decomposições em dois blocos módulo 127

Suponha que $f:\mathbb F_2^{32}\to\mathbb F_2$ tenha grau no máximo quatro e $W_f=-512+2^{17}k$ com $k\bmod127\in\{0,1\}$ em todas as frequências. Consideramos uma restrição física linear de codimensão $r$ que seja uma soma de duas funções em blocos independentes de dimensões positivas. As transformadas de Walsh são não normalizadas.

## 1. O bit raro em cinco controles e a obstrução ao argumento de grau

A [enumeração das projeções CRT](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/a62baae440e10b095a20b33ea5013237a0d1283b/research_updates/2026_11_21_walsh_mod127/verifica_invariante_M8.py) exclui $r\le4$ e, para $r=5$, deixa apenas as dimensões $(4,23)$ e as valorações espectrais $(1,8)$, a menos de permutação. O [adendo de cinco controles](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/535f48678651cbd7936210b95668f027df3b261d/research_updates/2026_11_21_walsh_mod127/AVANCO_MOD127_CINCO_CONTROLES.md) força que o núcleo de 23 variáveis satisfaça $W_g=-256+32768K$, com

$$
K\in\{-15,-7,0,1,2,9,17\},
\qquad
\sum_b\binom{K(b)}2=256-126(-1)^{g(0)}\in\{130,382\}.
$$

Considere $B(b)=\binom{K(b)}2\bmod2$. A lista mostra que $B=\mathbf1_{\{K=2\}}$. O custo $\binom K2$ nos quatro valores excepcionais $-15,-7,9,17$ é, respectivamente, $120,28,36,136$. São todos múltiplos de quatro, enquanto $K=2$ paga um. Portanto

$$
0<\operatorname{wt}(B)=\#\{K=2\}\le382,\qquad
\operatorname{wt}(B)\equiv2\pmod4.
$$

Para uma função de grau no máximo quatro em $n$ variáveis, o coeficiente multilinear inteiro de ordem $d>0$ da função $b\mapsto W_g(b)$ é $(-2)^d$ vezes a soma de sinais num flat físico de dimensão $n-d$. A expansão por monômios dá divisibilidade por $2^{\lceil(n-d)/4\rceil}$ à soma de sinais. Com $n=23$ e $d\ge14$, o coeficiente é, portanto, múltiplo de $2^{17}$, pois $d+\lceil(23-d)/4\rceil\ge17$. Dividindo os coeficientes de $W_g+256$ por $2^{15}$, conclui-se que $K\bmod4$ tem uma representação multilinear inteira de grau no máximo 13.

Aqui é necessário controlar o transporte entre bits. Seja $P$ a redução módulo dois de $K$ em forma normal algébrica e use seu levantamento inteiro canônico $\widetilde P:\mathbb F_2^{23}\to\{0,1\}$. A cota de grau de $K\bmod4$, por si só, dá $\deg P\le13$, mas não dá a mesma cota para $\widetilde P\bmod4$. Assim o argumento por distância mínima para $B=(K-\widetilde P)/2\bmod2$ exige uma informação adicional sobre $P$.

As identidades $\sum K=65536+256\sigma$ e $\sum K^2=66048+4\sigma$, com $\sigma=(-1)^{g(0)}$, dão

$$
\left|\operatorname{wt}(P)-(65536+256\sigma)\right|
\le 2\sum_b\binom{K(b)}2\le764 .
$$

A desigualdade usa $|K-(K\bmod2)|\le K(K-1)$ para todo inteiro $K$. Há duas observações adicionais. Escreva $P=\bigoplus_\alpha m_\alpha$ em forma normal algébrica. Há um polinômio booleano $Q$ de grau no máximo 13 tal que

$$
B=Q+\sum_{\alpha<\beta}m_\alpha m_\beta .
$$

Com efeito, $K\bmod4$ tem a forma $\sum_\alpha m_\alpha+2Q$ e o levantamento booleano de $P$ é $\sum_\alpha m_\alpha-2\sum_{\alpha<\beta}m_\alpha m_\beta\bmod4$. Pela distância mínima de Reed–Muller e pela cota $382<2^{23-14}$, $B$ deve ter grau pelo menos 15. A soma dos produtos de monômios de $P$ tem, portanto, grau pelo menos 15. Isso explicita a condição que precisa ser controlada para fechar a prova por grau. Além disso, $\operatorname{wt}(P)\equiv4\pmod8$: os valores ímpares da lista são todos $1\bmod8$, e $\operatorname{wt}(P)\equiv\sum K-2\#\{K=2\}\equiv4\bmod8$.

## 2. Um dos três perfis de seis controles é impossível

A extensão da mesma enumeração para $r=6$ deixa os parâmetros $(d_1,d_2;v_1,v_2)=(3,23;1,8),(4,22;1,8),(8,18;2,7)$. Vamos excluir o último.

Escreva $A=W_{g_1}/4$ para o bloco de dimensão oito. A enumeração dá os valores mais próximos de zero de cada sinal nos dois blocos. A menos de inverter ambos os sinais constantes, eles são $(1,-19)$ no primeiro e $(15,-1)$ no segundo. Logo

$$
A\equiv1\pmod4,\quad |A|\le64,\quad
15A,-A\bmod127\in\{-1+4s:0\le s\le64\}.
$$

A interseção exata dá $A\in\{1,-19,-23,-27,-31,-51,-55,-59,-63\}$. Pela inversão e por Parseval, $\mathbb E A=\pm1/4$ e $\mathbb E A^2=16$.

Se $A\equiv1\pmod{2^j}$, a paridade de $(A-1)/2^j$ tem grau no máximo $\lfloor4j/3\rfloor$. De fato, o coeficiente de ordem $d$ de $W_{g_1}$ tem valoração pelo menos $d+\lceil(8-d)/4\rceil$, e $W_{g_1}=4A$. A classe de paridade extraída é a redução módulo dois de todo o quociente inteiro. Como os bits inferiores são constantes nesta etapa, não há transporte dependente da frequência.

Para $j=2$, um ponto onde o bit vale um tem $|A|\ge19$. Se o bit for não nulo, seu peso relativo é pelo menos $2^{-2}$ pela distância mínima de Reed–Muller. Isso exige pelo menos $(19^2-1)/4>15$ da energia $\mathbb E(A^2-1)=15$, logo o bit é nulo. Para $j=3$ o mesmo argumento usa $|A|\ge23$ e densidade $2^{-4}$ e dá $(23^2-1)/16>15$. Restam $A\in\{1,-31,-63\}$, que já satisfazem $A\equiv1\pmod{32}$.

O bit para $j=5$ é exatamente o indicador de $A=-31$, com grau no máximo seis. Se for não nulo, pelo menos quatro frequências têm $A=-31$. Cada uma consome $31^2-1=960$ de $\sum(A^2-1)=15\cdot256=3840$. Assim são exatamente quatro e os demais valores são um. Isso dá $\mathbb E A=1/2$, que é impossível. Se o bit for nulo, qualquer $A=-63$ custaria $3968>3840$. Restaria $A\equiv1$, também incompatível com Parseval.

Portanto o perfil $(8,18;2,7)$ em codimensão seis é impossível.

## 3. No perfil $(3,23)$, dois bits do núcleo se anulam

No perfil $(3,23;1,8)$, a enumeração dá os valores mais próximos de zero do bloco pequeno $W_{g_1}/2$ iguais a $1,-3$, após uma troca simultânea de sinais se necessário. Ponha $A=W_g/256$ no núcleo de 23 variáveis. Então $A\equiv-1\pmod4$, ambos $A,-3A$ reduzem módulo 127 a $D=\{-1+4s:0\le s\le64\}$, $\mathbb E A^2=128$ e $\mathbb E A=\pm1/256$. Em um flat espectral $J$ de codimensão $c$, Poisson dá $|\mathbb E_J A|\le2^c/256$.

Se $A\equiv-1\bmod2^j$, o bit $B_j=((A+1)/2^j)\bmod2$ tem grau no máximo $\lfloor(4(8+j)-23)/3\rfloor$. As restrições de resíduos podem ser verificadas em um período $\operatorname{lcm}(127,2^{j+1})$:

| Bit | Valores de $A$ onde vale um | Valores de $A$ onde vale zero |
|---|---|---|
| $B_2$ | $A\ge91$ ou $A\le-253$ | |
| $B_3$ após $B_2=0$ | $A\ge87$ ou $A\le-345$ | $A\le-1$ ou $A\ge95$ |

O grau de $B_2$ é no máximo cinco. Se não nulo, ele custa pelo menos $(91^2-1)/32>127$ da energia $\mathbb E(A^2-1)=127$, impossível.

O grau de $B_3$ é no máximo sete. Sua densidade $w$ é no máximo $127/(87^2-1)<(5/2)2^{-7}$. O [Teorema 3 de Klein–Storme](https://doi.org/10.3934/amc.2011.5.333) dá um flat de zeros $J$ de codimensão $c\le2$. Em $J$, $(A+1)(A-95)\ge0$, logo o custo global vindo de $J$ é pelo menos $94(2^{-c}-1/256)$. Como $J$ é disjunto do suporte, obtemos

$$
w\le\frac{127-94(1/4-1/256)}{87^2-1}<2\cdot2^{-7}.
$$

Suponha $B_3\ne0$. Na classe de peso inferior a dois pesos mínimos, [Kasami–Tokura](https://doi.org/10.1109/TIT.1970.1054545) dá duas formas afins. Escreva $\|\widehat{B_3}\|_1$ para a norma $\ell^1$ da transformada normalizada. Temos $|\mathbb E(AB_3)|\le \|\widehat{B_3}\|_1/256$, pois a transformada normalizada de $A$ tem módulo $1/256$ em todo ponto. No suporte de $B_3$, $(A-87)(A+345)\ge0$. Portanto

$$
\mathbb E(A^2-1)\ \ge\ 30014w-258\|\widehat{B_3}\|_1/256 .
$$

Na primeira forma, $B_3$ é produto do indicador de um flat de codimensão cinco com um quadrático de semiposto $h$ nas 18 variáveis livres. Temos $w=(2-2^{1-h})/128$ e $\|\widehat{B_3}\|_1\le(1+2^h)/2$, pois o sinal quadrático tem norma $\ell^1$ igual a $2^h$ e o indicador é metade da diferença entre um e o sinal. Para todo $1\le h\le9$ a cota acima excede 127. Na segunda forma, o suporte é a diferença simétrica de dois flats afins de codimensão sete, com interseção de densidade $2^{-7-\mu}$ e $\mu\ge3$. Daí $w\ge7/512$ e $\|\widehat{B_3}\|_1\le4$, ao escrever o indicador como soma dos dois indicadores menos duas vezes o da interseção. A cota também excede 127. Assim $B_3=0$ e $W_g\equiv-256\pmod{4096}$.

## Escopo

O caso global segue aberto. Em seis controles, restam os perfis $(3,23)$ e $(4,22)$, com a nova congruência no primeiro. Em cinco controles, a densidade do bit raro foi confirmada, mas o transporte binário impede usar apenas a cota de grau da representação inteira para excluí-lo.

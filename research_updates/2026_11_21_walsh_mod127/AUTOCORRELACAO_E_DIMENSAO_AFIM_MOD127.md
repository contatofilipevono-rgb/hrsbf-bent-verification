# Autocorrelação e dimensão afim no caso global módulo 127

Seja $f:\mathbb F_2^{32}\to\mathbb F_2$ uma candidata de grau quatro no ramo global, com $W_f=-512+2^{17}k$ e $k\bmod127\in\{0,1\}$. Ponha $T(b)=k(b)(k(b)-1)/2$ e $a=[f]_4$. Provamos uma cota de autocorrelação para todo o ramo global. Se a menor valoração 2-ádica de $T\ne0$ é três, a cota exclui as dimensões afins 21 a 25 de $P=\{\nu_2(T)=3\}$. [Cotas anteriores de suporte](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/0401146804e15448e519732727e00ef53be232da/research_updates/2026_11_21_walsh_mod127/SUPORTE_AFIM_VALORACAO_TRES_MOD127.md) · [Posto da forma quártica](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/acb47493135a655a2c41c4c4d815a3d62547d539/research_updates/2026_11_21_walsh_mod127/POSTO_CATALETICO_VALORACAO_TRES_MOD127.md).

## 1. A lacuna do viés cúbico

Escreva $S(x)=(-1)^{f(x)}$ e $\Delta(v)=\sum_x S(x)S(x+v)$. Para $v\ne0$, a derivada $g(x)=f(x)+f(x+v)$ é cúbica no quociente por $\langle v\rangle$, de dimensão 31. Seu símbolo cúbico, $\iota_v a$, não se anula em nenhum subespaço físico linear de codimensão até três. Assim nem $g$ nem $1+g$ tem um subespaço afim de zeros de codimensão até três. A existência desse subespaço anularia o símbolo cúbico em sua direção. [Prova da propriedade das contrações, seção 10.6](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/a62baae440e10b095a20b33ea5013237a0d1283b/research_updates/2026_11_21_walsh_mod127/rigidez_walsh_32_127_ramo_F.md).

A distância mínima e as formas normais de Kasami–Tokura dão os limites relativos $1/8$, $7/32$, $1/4$ para cúbicas sem um espaço de zeros de codimensão até $0,1,2$, respectivamente. Para o segundo e o terceiro limites, uma cúbica de peso positivo menor que $1/4$ tem um hiperplano de zeros, salvo a soma de dois produtos disjuntos de três formas independentes. Essa soma pesa $7/32$ e tem um zero afim de codimensão dois. [Formas normais de Kasami–Tokura](https://doi.org/10.1109/TIT.1970.1054545) · [Formulação explícita, Teorema 2](https://eprint.iacr.org/2018/1194.pdf).

Para uma cúbica sem zeros afins de codimensão até três, passe ao quociente pelo espaço de períodos, de dimensão $N\ge4$. Se o peso $w$ fosse menor que $37/128$, a média dos pesos das derivadas seria $2w(1-w)<2(37/128)(91/128)$. Se nenhuma derivada em direção não nula tivesse peso até $3/8$, a média seria pelo menos $(31/32)(7/16)$ para $N\ge5$, ou $(15/16)(1/2)$ para $N=4$. Ambas são maiores que $2(37/128)(91/128)$. A última cota usa que a derivada em quatro variáveis é quadrática e periódica em sua direção, de modo que depende de no máximo três variáveis. Existe, portanto, uma derivada quadrática de peso $1/4$ ou $3/8$. Escrevendo o quadrático como $x\cdot y$ em um ou dois pares e fixando $x$, seu conjunto de zeros se divide numa parte de codimensão um e outra de codimensão dois, ou numa parte de codimensão dois e três de codimensão três, respectivamente. No conjunto em que a derivada vale um, metade dos pontos são uns da cúbica, por emparelhamento via translação. Nas partes de zeros, as restrições da cúbica herdam a ausência de zeros afins nas codimensões restantes. Os limites locais então dão $w\ge1/8+(1/2)(1/4)+(1/4)(7/32)=39/128$ no primeiro caso e $w\ge3/16+(1/4)(7/32)+(3/8)(1/8)=37/128$ no segundo.

Assim $w=\min(\mathrm{wt}(g),\mathrm{wt}(1+g))$ em peso relativo é pelo menos $37/128$. Além disso, $127\mid\Delta(v)$. De fato, $W_f(b)\equiv-4+8k(b)\equiv\pm4\bmod127$, logo $W_f^2$ é constante módulo 127. Sua transformada inversa, que dá $\Delta(v)$, se anula módulo 127 fora da origem.

Se $37/128\le w<5/16$, a classificação de Kasami–Tokura–Azumi para $\mathrm{RM}(3,31)$, entre dois e dois e meio pesos mínimos, oferece três famílias. A primeira tem peso relativo $1/4+2^{-2-\ell}$, $\ell\ge2$, que alcança $5/16$ para $\ell=2$ e fica abaixo de $37/128$ para $\ell\ge3$. As outras duas dão, respectivamente, $|\Delta(v)|=3\cdot2^{29}+2^{i+3}$ ou $|\Delta(v)|=3\cdot2^{29}+3\cdot2^{i+3}$. A divisibilidade exigiria uma potência de dois congruente a $-3$ ou $-1$ módulo 127. Isso é impossível, pois as potências de dois módulo 127 são $1,2,4,8,16,32,64$. O extremo $w=5/16$ daria $|\Delta(v)|=3\cdot2^{29}$, também incompatível. Logo

$$
|\Delta(v)|<\tfrac38\,2^{32}\qquad(v\ne0).
$$

[Kasami–Tokura–Azumi](https://doi.org/10.1016/S0019-9958(76)90355-7) · [Famílias de pesos no Lema 4 de Krotov](https://arxiv.org/pdf/1811.00015).

## 2. Massa espectral num subespaço afim

A identidade $\widehat T(v)=\Delta(v)/8-16256S(v)-8355840\,\mathbf1_{\{v=0\}}$ usa a transformada não normalizada. Logo $|\widehat T(v)|\le F=3\cdot2^{26}+16256$ para $v\ne0$, e $\widehat T(0)\le B=528\,531\,328$. Para qualquer subespaço afim $J=b_0+R^\perp$ de codimensão $r=\dim R$, a média de Fourier dá

$$
\sum_{b\in J}T(b)
=2^{-r}\sum_{v\in R}(-1)^{b_0\cdot v}\widehat T(v)
\le F+2^{-r}(B-F).
$$

Defina $Q=\{b:T(b)\equiv16\bmod32\}$ e $q=|Q|$. Cada ponto em $Q$ custa ao menos $c_4=7\,748\,016$. Se $Q$ é não vazio, aplique a média ao seu fecho afim. Resulta

$$
q\le \left\lfloor\frac{F+2^{-r}(B-F)}{c_4}\right\rfloor,
\qquad r=32-\dim\operatorname{aff}(Q).
$$

Em particular $q\le25$ para $r\ge12$. A estimativa aplica-se a qualquer valoração mínima de $T$. [Identidade de Fourier e custo mínimo](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/b3890a40dc9536fda11679e1fc5547b180e5f600/research_updates/2026_11_21_walsh_mod127/OBSTRUCAO_CODIGO_TRIORTOGONAL_MOD127.md).

## 3. Aplicação à valoração três

Para $s=\dim\operatorname{aff}(P)<32$, ponha $U=(\operatorname{dir}\operatorname{aff}(P))^\perp$ e $u=32-s$. Os momentos dão $Q\ne\varnothing$ e $q\ge65-s-r+\rho_U$, onde $\rho_U$ é o posto do emparelhamento de $a$ em $U\wedge V$. Vale $a(U,R,V,V)=0$. Escrevendo $e=\dim(U\cap R)$, temos $e=0$ ou $1$, $r\le s$ e, se $e=1$, $r\le s-7$. Escolha em $R$ um complemento $R'$ à interseção com $U$. Numa base adaptada a $U\oplus R'$, a cobertura de oito monômios disjuntos tem ao menos $\lceil(r-e)/4\rceil$ monômios que tocam em $R'$ e evitam $U$. Sobram no máximo $m=8-\lceil(r-e)/4\rceil$ para os índices de $U$.

| Condição | Consequência |
|---|---|
| $u>4m$ | A cobertura é impossível |
| $u>m$ | $\rho_U\ge4$, pois algum monômio usa dois índices de $U$ |
| $u>2m$ | $\rho_U\ge6$, pois algum monômio usa três índices de $U$ |
| $u>2m$ e $u>m+3$ | $\rho_U\ge8$ |
| $u>2m$ e $u>\max(m+3,m+2\min(3,m))$ | $\rho_U\ge10$ |
| $u>3m+1$ | $\rho_U\ge12$ |

Para a quarta linha, se o posto fosse seis, numa base adaptada haveria no máximo um monômio com dois ou mais índices em $U$, permitindo cobrir até $4+(m-1)$. Para a quinta, sob posto no máximo oito, escolha $W$ como na prova anterior. Se $a|_U\ne0$, vale o mesmo limite. Se $a|_U=0$, todo monômio com pelo menos dois índices de $U$ usa um índice no espaço $W\cap U$ de dimensão três, e cada um cobre no máximo três índices de $U$. Para a última linha, se $\rho_U\le10$, o posto absoluto de $a|_U$ também é no máximo dez. Logo é possível escolher uma base de $U$ onde $a|_U$ esteja apoiada em no máximo seis índices. Assim no máximo um dos $m$ monômios seria inteiramente em $U$, permitindo cobrir até $3m+1$ índices. [Provas das formas de posto baixo](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/acb47493135a655a2c41c4c4d815a3d62547d539/research_updates/2026_11_21_walsh_mod127/POSTO_CATALETICO_VALORACAO_TRES_MOD127.md).

Há um acréscimo de um na cota inferior de $q$ quando $\rho_U=0$. Suponha $q=65-s-r$. Seja $C$ o espaço de avaliações afins em $Q$ e $D$ o subespaço de avaliações das formas afins que se anulam em $P$. Temos $D\subseteq C\cap C^\perp$ e $\dim D=u>0$. A igualdade na cota daria $C^\perp=D$. Pelos momentos até ordem três, o produto de uma palavra de $D$ com qualquer avaliação afim pertence a $C^\perp$. Portanto $D$ seria um ideal sob multiplicação pelas avaliações afins, que geram a álgebra de todas as funções em $Q$ por separarem os pontos. Como $D$ não é zero, conteria um indicador de um ponto, incompatível com sua auto-ortogonalidade.

O orçamento anterior dá $|P|\ge128$ e $q\le38$. O seguinte código confere as desigualdades inteiras.

~~~~python
B, F, c4 = 528_531_328, 3 * 2**26 + 16_256, 7_748_016
allowed = {}
for s in range(21, 27):
    u = 32 - s
    allowed[s] = set()
    for r in range(s + 1):
        upper = min(38, (F + (B - F) // (1 << r)) // c4)
        for e in (0, 1):
            if e and not 1 <= r <= s - 7:
                continue
            m = 8 - (r - e + 3) // 4
            if u > 4 * m:
                continue
            rank = 4 if u > m else 0
            if u > 2 * m:
                rank = max(rank, 6)
                if u > m + 3:
                    rank = max(rank, 8)
                if u > max(m + 3, m + 2 * min(3, m)):
                    rank = max(rank, 10)
            if u > 3 * m + 1:
                rank = max(rank, 12)
            if 65 - s - r + max(1, rank) <= upper:
                allowed[s].add(r)
assert all(not allowed[s] for s in range(21, 26))
assert allowed[26] == {18, 19, 20, 22, 23, 24}
~~~~

**Conclusão.** No ramo de valoração três, $P$ tem dimensão afim pelo menos 26. Se a dimensão for 26, então $r\in\{18,19,20,22,23,24\}$ e $q\le25$. Para dimensões afins 26 a 32 ainda há perfis a analisar.

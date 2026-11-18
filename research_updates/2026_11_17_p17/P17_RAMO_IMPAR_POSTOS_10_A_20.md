# Módulo 17 em 20 variáveis — exclusão dos postos polares 10 a 20 no ramo ímpar

**Resultado verificado em 17 de novembro de 2026.** Seja $f:\mathbb F_2^{20}\to\mathbb F_2$ de grau no máximo quatro e suponha $W_f(b)\equiv\pm1024\pmod {17}$ para todo $b$. Defina $X=W_f/32$. Se $X$ é ímpar, pode-se normalizar $X\equiv1\pmod4$ por uma translação de $f$ e uma constante. Na normalização $X\equiv1+4Q+8D\pmod {16}$, a quadrática $Q$ tem posto polar menor que dez.

A exclusão vale para quadráticas balanceadas e não balanceadas, sem exigir simetria de rotação ou homogeneidade. Em particular, elimina o peso $127/256$ (posto 14), escolhido como alvo no caderno. As exclusões anteriores de pesos de postos 10 e 12 servem de sobreposição. O caso ímpar $Q=1$ é tratado na nota separada do mesmo pacote. Este é um argumento matemático com conferência exata das constantes. A demonstração ainda aguarda revisão humana.

## 1. Normalização espectral

Ponha $V=\mathbb F_2^{20}$ e escreva $\mathbb E$ para a média uniforme em $V$. Para toda função booleana de grau no máximo quatro em $k$ variáveis, a soma de sinais é divisível por $2^{\lceil k/4\rceil}$. De fato, expanda $\prod_M(1-2M)$, com $M$ percorrendo os monômios. Um produto de $j$ monômios tem união de suportes de tamanho no máximo $4j$. Seu somatório, após incluir o fator $(-2)^j$, é divisível por $2^{j+\max(0,k-4j)}$, cujo expoente é pelo menos $\lceil k/4\rceil$. A constante global de $f$ só troca o sinal.

Logo $X$ é inteiro. No polinômio multilinear **inteiro** de $X(b)$, o coeficiente $c_S$ de suporte não vazio $S$, com $j=|S|$, satisfaz
$$
 c_S=\frac{(-2)^j}{32}\sum_{x_i=1\text{ para }i\in S}(-1)^{f(x)},
 \qquad 2^{\lceil3j/4\rceil}\mid c_S.
$$
A mesma conta vale em quaisquer coordenadas afins do espaço das frequências. Compor $X$ com uma transformação afim invertível corresponde a uma mudança linear inversa transposta e à adição de uma forma linear no domínio de $f$.

Assim, $X\bmod2$ é constante e, para $X$ ímpar, seu bit de ordem um é afim. Multiplicar pelo caráter correspondente torna $X\equiv1\pmod4$. Após a normalização, a filtração dos $c_S$ dá $\deg Q\le2$ ao extrair $X\equiv1+4Q\pmod8$. O levantamento inteiro de $Q$ tem coeficientes $c_j(Q)$ divisíveis por $2^{\lceil j/2\rceil-1}$, pela expansão inteira do XOR de seus monômios. Assim $4Q$ tem coeficientes em graus $j\ge5$ divisíveis por 16. A extração de $D=(X-1-4Q)/8\bmod2$ dá $\deg D\le4$.

Escreva $X=32\varepsilon+17r$, com $\varepsilon\in\{\pm1\}$ escolhido pelo resíduo. Temos $r\equiv1+4Q+8D\pmod {16}$. Pela inversão de Walsh e por Parseval,
$$
 \mu=\mathbb E X=\pm1/32,\qquad \mathbb E X^2=1024.
$$
Para uma função real $a$, use $\widehat a(v)=\mathbb E_b a(b)(-1)^{v\cdot b}$. Então $\widehat X(v)=(-1)^{f(v)}/32$, de modo que
$$
 |\mathbb E Xa|\le\tfrac1{32}\|\widehat a\|_1.
$$

## 2. Orçamento e fatoração

Defina $e=(X-17)^2-1024$, $w=\mathbb E Q$ e $B=\mathbb E(e-272Q)=289-34\mu-272w$. Em cada célula $(Q,D)$, o conjunto de valores possíveis de $X$ é $17(1+4Q+8D)+32\varepsilon+272\mathbb Z$.

| $(Q,D)$ | Mínimo de $e$ | Desigualdade adicional |
|---|---:|---|
| $(0,0)$ | 0 | $X\ge-15-e/272$ |
| $(0,1)$ | 9792 | |
| $(1,0)$ | 272 | $136\vert X-53\vert \le e-272$ |
| $(1,1)$ | 272 | $136\vert X+19\vert \le e-272$ |

Para a primeira desigualdade, $X<-15$ implica $y=-15-X\ge208$, e $e=y(y+64)\ge272y$. Para a terceira, escreva $X=53+\delta$. Se $\delta>0$, então $\delta\ge64$. Se $\delta<0$, então $|\delta|\ge208$. A igualdade $e-272=\delta(\delta+72)$ dá a cota. A última é a imagem pela reflexão $X\mapsto34-X$.

O polinômio $D(1+Q)$ tem grau no máximo seis e peso relativo no máximo $B/9792$. Se $2h$ é o posto polar de $Q$, $\lvert 1-2w\rvert\le2^{-h}$. Para $h\ge5$, $B/9792<3/128$. Pela classificação dos pesos de Reed–Muller de Kasami–Tokura, $D(1+Q)$ é zero ou indica um flat afim de dimensão 14. No segundo caso, chame-o de $S$ e fixe $s_0\in S$. O espaço $S-s_0$ é totalmente singular para $Q(s_0+\cdot)$ e projeta-se num isotrópico de dimensão no máximo $h$ no quociente pelo radical.

- Para $h\ge7$, o limite $20-h\le13$ para a dimensão isotrópica exclui $S$.
- Para $h=6$, uma $Q$ balanceada deixa no radical um núcleo de dimensão 7, de modo que a dimensão de $S$ é no máximo $7+6=13$. Para $Q$ não balanceada, $S-s_0$ contém todo o radical de dimensão 8 e projeta-se num lagrangiano singular de dimensão 6. A forma no quociente é então hiperbólica. Um lagrangiano singular oposto fornece um flat $T\subset\{Q=0\}$, de dimensão 14, que corta $S$ em dimensão 8. Em $T$, $D$ seria o indicador desse corte, de grau seis.
- Para $h=5$ e $w=33/64$, $B<9792/64$, abaixo do peso mínimo. Para $w=31/64$, a forma no quociente é hiperbólica e $S-s_0$ se projeta num singular de dimensão 4 ou 5. Estenda-o a um lagrangiano singular e escolha um singular oposto. Seu levantamento com todo o radical dá $T\subset\{Q=0\}$ de dimensão 15, cujo corte com $S$ tem dimensão 9 ou 10. Em $T$, o indicador desse corte tem grau seis ou cinco.
- Para $h=5$ e $w=1/2$, o núcleo da parte linear no radical tem dimensão 9 e $S$ projeta-se num lagrangiano de dimensão 5. Escolha um lagrangiano oposto para a polar. Ajuste seu levantamento pela direção radical em que $Q(s_0+\cdot)$ vale um. O ajuste é linear no lagrangiano, pois ali a polar é zero. Com o núcleo radical, isto dá $T\subset\{Q=0\}$ de dimensão 14 e um corte de dimensão 9. O indicador teria grau cinco.

Todas as contradições de grau usam apenas a hipótese $\deg D\le4$. Concluímos $D(1+Q)=0$. O Corolário 7.2 de Ding–Hodges–Kruglov dá $D=QR$ com $\deg R\le2$. Explicitamente, com $A_d$ o espaço das ANFs de grau no máximo $d$, vale
$$
 \dim\ker(1+Q:A_4\to A_6)=\dim A_4-\delta(20,4)=\delta(20,2)=\dim QA_2.
$$
A inclusão $QA_2\subseteq\ker(1+Q)$ é imediata. As hipóteses do corolário valem porque tanto $Q$ como $1+Q$ dependem de pelo menos $2h$ coordenadas, inclusive no caso balanceado.

## 3. Exclusão por correlação com quadráticas

Use $s=(-1)^R$, $b_P=\mathbb E(-1)^P$, $a=\mathbb E(Qs)=(b_R-b_{Q+R})/2$, e $\eta=B/136$. Na célula $Q=1$, as desigualdades da tabela dão $X=17+36s+\Delta$ com $\mathbb E(Q|\Delta|)\le\eta$. Em particular,
$$
 \mathbb E(XQ)\ge17w+36a-\eta,
 \qquad \mathbb E(XQs)\ge36w+17a-\eta.
$$

Seja $r$ o menor dos semipostos de $R,Q+R$, e $t$ o maior. Podemos trocar $R$ por $1+Q+R$, que coincide com $R$ em $Q=1$, e supor que o menor posto é de $R$. Pela subaditividade do posto polar, $t\ge\max(r,h-r)$.

**Semiposto menor $r\le9$, exceto $R=1$.** Em $R=0$, $X\ge53-(e-272)/136$ quando $Q=1$ e $X\ge-15-e/272$ quando $Q=0$. Portanto
$$
 \mathbb E(X1_{R=0})\ge \tfrac{19}{2}(1+b_R)-17(b_Q+b_{Q+R})-\eta.
$$
Por outro lado, $1_{R=0}=(1+(-1)^R)/2$. A norma $\ell^1$ do espectro normalizado de uma fase quadrática de posto $2r$ é $2^r$. Logo $\mathbb E(X1_{R=0})\le(1+2^r)/64$. Use $b_R\ge-2^{-r}$ para $r>0$ e $b_R\ge0$ para $r=0$, pois a constante um foi destacada. As duas desigualdades contradizem-se para todos os $h\ge6$ e $r\le9$. A margem mínima é $19/1024$, atingida em $h=6,r=9$ na estimativa conservadora.

Para $h=5$, $r\ge3$ já é incompatível com a primeira cota para $\mathbb E(XQ)$. Nesse caso $a\ge-1/8, w\ge31/64, \eta\le149/128$, o que dá $\mathbb E(XQ)\ge329/128$. Mas $Q=(1-(-1)^Q)/2$ dá $|\mathbb E(XQ)|\le33/64$. Restam $r\le2$, excluídos pela mesma cota com $1_{R=0}$, com margem mínima $249/128$.

**Ambos os postos são 20.** Este caso usa a ortogonalidade da transformada inteira uma segunda vez. As fases de $R$ e $Q+R$ têm espectros de amplitude constante $1/1024$ na normalização $\widehat a$. Ponha $u=1024\widehat{(-1)^R}$ e $v=1024\widehat{(-1)^{Q+R}}$, ambos tomando valores $\pm1$. Como $Qs=((-1)^R-(-1)^{Q+R})/2$, sua norma espectral $\ell^1$ é **exatamente** $1024\Pr(u\ne v)=1024w$. A última igualdade vem de Parseval cruzado, $\mathbb E(uv)=b_Q$. Concluímos $|\mathbb E(XQs)|\le32w$. Contudo $|a|\le1/1024$ e, por $h\ge6$, $4w-17/1024-\eta\ge823/1024>0$. A cota inferior para $\mathbb E(XQs)$ excede $32w$.

## 4. Exceção $R=1$

Nesse caso $D=Q$ e $X\equiv1-4Q\pmod {16}$. A função booleana
$$
 U=(X-17+4Q)/16\pmod2
$$
tem grau no máximo seis. Para $j\ge7$, a filtração da seção 1 dá $32\mid c_S(X)$ e também $32\mid c_S(4Q)$, justificando o grau após a divisão inteira.

Se $U=1$, a progressão admissível em cada célula mostra que $e-272Q\ge28288$. Em $Q=0$, a cota é $56576$. Em $Q=1$, ela é $28288$. Assim $\operatorname{wt}(U)\le B/28288<1/64$. A distância mínima de Reed–Muller força $U=0$, isto é, $X\equiv17-4Q\pmod {32}$.

Em coordenadas afins, restrinja a três pares hiperbólicos da forma polar de $Q$, eliminando as partes lineares nas seis coordenadas por translação. O coeficiente inteiro do monômio de grau seis de $Q$ nessa restrição é $\pm4$, obtido de três produtos disjuntos por inclusão-exclusão. O coeficiente correspondente de $17-4Q$ é $16\pmod{32}$, enquanto o de $X$ é $0\pmod{32}$ pela filtração. Isso encerra a prova.

## Reprodução e fontes

O verificador `verifica_p17_impar_postos_altos.py` checa as progressões e as margens com frações exatas. As reduções de grau e a cobertura por postos estão na demonstração. A prova usa ferramentas do caderno, especialmente a filtração espectral, distância e peso baixo de Reed–Muller e fatoração com controle de grau. A correlação exata quando os dois postos são plenos usa somente a ortogonalidade de Walsh.

- [Caderno de ferramentas, técnicas 4–6, 11, 20 e 21](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/b96f6ac1caa5f17aec8762aa40ae9139d5504ae2/research_updates/2026_11_07_ferramentas/CADERNO_TECNICAS_BENT.md)
- [Kasami e Tokura, *On the weight structure of Reed–Muller codes*](https://doi.org/10.1109/TIT.1970.1054545)
- [Ding, Hodges e Kruglov, *Growth of the Ideal Generated by a Quadratic Boolean Function*, Corolário 7.2](https://archive.ymsc.tsinghua.edu.cn/pacm_download/672/12626-dingjt-c33.pdf)

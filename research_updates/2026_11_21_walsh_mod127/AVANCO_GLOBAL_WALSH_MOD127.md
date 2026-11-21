# Caso global módulo 127 — peso de \(C_9\), autocorrelação nula e a próxima codimensão

Este adendo usa a [revisão 6462f42](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/tree/6462f420c650a14315b3dcea652b727f44fe32d3/research_updates/2026_11_21_walsh_mod127). Suponha que \(f:\mathbb F_2^{32}\to\mathbb F_2\) tenha grau no máximo quatro e satisfaça
\[
 W_f=-512+2^{17}k,\qquad k\bmod127\in\{0,1\}
\]
em todas as frequências. Todas as transformadas de Walsh são não normalizadas, exceto quando indicado. Escreva \(s_0=(-1)^{f(0)}\), \(C_9=k\bmod2\), \(T=k(k-1)/2\), \(S_{\mathrm{big}}=\{k\notin\{0,1\}\}\), e \(N_1=\#\{k=1\}\).

## 1. Novas cotas de peso e grau do primeiro bit

Por inversão e Parseval,
\[
 S_1=\sum k=2^{24}+2^{15}s_0,\quad
 S_2=\sum k^2=2^{30}+2^{16}+2^8s_0,\quad
 \sum T/127=127\cdot2^{15}-128s_0 .
\]
Como \(|k|\ge126\) em \(S_{\mathrm{big}}\),
\[
 S_1-\frac{S_2-N_1}{126}\le N_1\le S_1+\frac{S_2-N_1}{126}.
\]
Equivalentemente,
\[
 \left\lceil\frac{126S_1-S_2}{125}\right\rceil
 \le N_1\le
 \left\lfloor\frac{126S_1+S_2}{127}\right\rfloor .
\]

Para obter uma cota direta de \(C_9\), escreva \(\varepsilon(k)=k\bmod2\) como inteiro em \(\{0,1\}\). Ponto a ponto,
\[
 |\varepsilon(k)-k|\le \frac{k(k-1)}{127}.
\]
A desigualdade é igualdade em \(0,1,127,128,-126,-127\). Para \(k\ge128\), o lado direito é pelo menos \(k\). Para \(k=-a\) e \(a\ge127\), é pelo menos \(a+1\), suficiente. Os valores intermediários proibidos pelo CRT não entram. Somando,
\[
 S_1-2\sum T/127\le\mathrm{wt}(C_9)\le S_1+2\sum T/127 .
\]

| \(s_0\) | Intervalo de \(N_1\) | Intervalo de \(\mathrm{wt}(C_9)\) |
|---:|---:|---:|
| \(-1\) | \([8\,287\,947,\ 25\,067\,776]\) | \([8\,421\,120,\ 25\,067\,776]\) |
| \(+1\) | \([8\,354\,003,\ 25\,132\,800]\) | \([8\,487\,168,\ 25\,132\,800]\) |

**Consequência.** \(9\le\deg C_9\le12\). O limite superior vem da filtração original. Se o grau fosse no máximo oito, \(C_9\) pertenceria a \(\mathrm{RM}(8,32)\). Seu peso é positivo e estritamente inferior ao segundo peso \(3\cdot2^{23}=25\,165\,824\). Restaria apenas uma palavra de peso mínimo, indicadora de um flat de codimensão oito. Ela tem um hiperplano de zeros, em contradição com G2.

Caso o grau seja exatamente nove, o Teorema 3 de [Klein–Storme](https://biblio.ugent.be/publication/2140143) dá um flat afim de zeros de codimensão no máximo nove, pois \(25\,132\,800<(3-2^{-8})2^{23}=25\,133\,056\). Se \(s_0=-1\), a cota melhora para codimensão oito, pois \(25\,067\,776<(3-2^{-7})2^{23}=25\,100\,288\). O argumento não exclui esses casos de grau nove.

## 2. Estabilidade espectral na dimensão 15

Suponha que exista um subespaço físico \(L\) de dimensão 15 tal que \(\Delta_f(a)=0\) para todo \(0\ne a\in L\). A transformada normalizada de \(W_f^2/2^{32}\) é \(\Delta_f/2^{32}\). Logo a média de \(W_f^2/2^{32}\) em cada coset \(J\) de \(L^\perp\) é exatamente um. A expansão de \(W_f\) dá
\[
 \sum_{b\in J}\frac{128k(b)^2-k(b)}{127}=33024,\qquad
 W_{f|_L}(J)=\sum_{b\in J}k(b)-512 .
\]
A segunda identidade é Poisson. O custo \((128k^2-k)/127\) é zero em \(k=0\), um em \(k=1\), e pelo menos \(16002\) em uma exceção. As únicas exceções com custo até \(33024\) são \(-127,-126,127,128\), pelos dois resíduos módulo 127 e pela monotonicidade do custo nas duas caudas. O cálculo também vale para \(f(0)=1\).

Defina \(m_J=\#(J\cap S_{\mathrm{big}})\) e \(j_J=\#\{b\in J:k(b)\in\{-126,127\}\}\). Cada uma das \(m_J-j_J\) exceções do outro tipo tem custo menos \(k\) igual a \(16384\), e cada uma das \(j_J\) tem custo menos \(k\) igual a \(16128\). Assim
\[
 W_{f|_L}(J)=32512-16384m_J+256j_J .
\]

| Exceções na fibra \(m_J\) | Coeficientes possíveis |
|---:|---:|
| 0 | \(32512\) |
| 1 | \(16128,\ 16384\) |
| 2 | \(-256,\ 0,\ 256\) |

O primeiro perfil é impossível. Um coeficiente \(32512\) significaria distância \(128\) entre \(f|_L\) e uma função afim, abaixo da distância mínima não nula \(2^{15-4}=2048\). Há no máximo duas fibras de uma exceção. Se três frequências tivessem coeficientes pelo menos \(16128\), complete-as a um plano afim de frequências. O quarto coeficiente seria pelo menos \(-256\), de modo que a soma seria \(>32768\). Por Poisson, a soma dos quatro é \(4\) vezes uma soma de sinais em dimensão 13, com módulo no máximo \(32768\).

Logo
\[
 |S_{\mathrm{big}}|\in\{65534,65535,65536\}.
\]
Todas as exceções estão nos quatro valores da tabela. Parseval dá ainda o número de coeficientes pequenos não nulos.

| Fibras de uma exceção | Coeficientes grandes | Número de pequenos não nulos |
|---:|---:|---:|
| 0 | nenhum | \(16384\) |
| 1 | \(16128\) ou \(16384\) | \(12415\) ou \(12288\), respectivamente |
| 2 | \(16384,16384\) | \(8192\) |

Para a última linha, a soma do par grande dividida por dois é uma soma de sinais em um hiperplano físico de \(L\), contra uma fase afim. Se os coeficientes não forem ambos \(16384\), isso dá distância \(64\) ou \(128\) à fase nesse hiperplano, abaixo da distância mínima \(2^{14-4}=1024\). Portanto ambos são \(16384\) e há coincidência afim nesse hiperplano. Depois de retirar essa fase, a restrição à metade complementar tem grau no máximo três, por fatoração pelo indicador da metade, e seu espectro é balanceado com valores em \(\{-256,0,256\}\). Para verificar os valores, use a soma e a diferença dos coeficientes em cada par de frequências associado à normal do hiperplano. Fora do par grande, o coeficiente da metade afim é zero; no par grande, os dois coeficientes iguais tornam a outra metade balanceada.

Este resultado, obtido com análise independente do Astra, não presume que \(L\) exista. Ele também não elimina os três perfis restantes.

## 3. Condição exata para um zero físico em codimensão seis

A revisão anterior já exclui zeros de \(a_f=[f]_4\) em subespaço físico linear de codimensão até cinco. Considere a primeira dimensão seguinte. Se \(U\) é um subespaço linear de codimensão seis com \(a_f|_U=0\), então \(g=f|_U\) tem grau no máximo três em 26 variáveis. Seja \(c=[g]_3\). Em cada subespaço linear de dimensão 24 em \(U\), a soma de sinais é divisível por \(512\), por Poisson aplicado ao espectro global. Na valoração oito, a expansão conta a paridade das coberturas por oito cúbicas disjuntas. Logo \(\gamma_8(c)=0\).

Fixe uma base de \(U\). Na expansão da soma de sinais de \(g\) em 26 variáveis, um termo escolhido com \(r\) monômios e união de tamanho \(u\) tem valoração \(r+26-u\). Para valoração nove, é necessário \(r=9,u=26\). De fato, \(r\le8\) dá piso \(26-2r\ge10\), e \(r\ge10\) já paga dez. Se um monômio tem grau menor que três, a única possibilidade é um quadrático e oito cúbicas disjuntas. Sua contribuição total módulo \(1024\) é zero porque é a contração em volume do produto \([g]_2\,\gamma_8(c)\). Aqui \([g]_2\) designa a parte quadrática da ANF na base escolhida.

Restam nove monômios cúbicos que cobrem as 26 coordenadas, com uma coordenada repetida exatamente duas vezes. Para a coordenada repetida \(i\), escreva \(c=x_iq_i+b_i\), onde \(q_i\) é quadrática exterior e \(b_i\) não contém \(x_i\). A paridade desse grupo é
\[
 \operatorname{vol}_{25}\bigl(\gamma_2(q_i)\wedge\gamma_7(b_i)\bigr).
\]
Portanto todo zero quártico físico de codimensão seis teria de satisfazer
\[
 \gamma_8(c)=0,\qquad
 \sum_{i=1}^{26}\operatorname{vol}_{25}
 \bigl(\gamma_2(q_i)\wedge\gamma_7(b_i)\bigr)=1.
\]
A segunda igualdade usa \(W_g(0)\equiv-512\bmod2048\). Ela é independente da parte de grau até dois quando \(\gamma_8(c)=0\). Ainda falta decidir se uma cúbica com essas duas propriedades pode existir. Mesmo uma exclusão aqui não garantiria a existência original de um zero quártico de codimensão seis.

## Estado

O caso global \(D=h=0\) segue em aberto. As novas condições valem para todo candidato residual. O verificador adjunto reproduz as contas inteiras das Seções 1–3. Os passos geométricos e exteriores estão demonstrados no texto.

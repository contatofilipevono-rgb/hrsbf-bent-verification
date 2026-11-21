# Oito quárticas disjuntas no caso global módulo 127

Suponha que (f:\mathbb F_2^{32}\to\mathbb F_2) tenha grau no máximo quatro e, em todas as frequências,
\[
W_f(b)=-512+2^{17}k(b),\qquad k(b)\bmod127\in\{0,1\}.
\]
O símbolo quártico é (a=[f]_4). Este adendo obtém uma condição módulo quatro no símbolo, exclui todos os zeros físicos de codimensão até sete e eleva a oito a cota inferior para o número de produtos exteriores que o representam. A congruência módulo 127 também exclui uma decomposição em dois blocos independentes após fixar até quatro controles lineares.

## 1. Uma contagem inteira determinada módulo quatro

Em uma base física linear, escreva a ANF de (f) como soma booleana dos seus monômios (m\) com coeficiente um. Ponha (P_j=\sum_{|S|=j}\prod_{m\in S}m), calculado no anel booleano inteiro (\mathbb Z[x_i]/(x_i^2-x_i)), e (e_j=P_j\bmod2). O termo constante, quando presente na ANF, conta como um monômio. A expansão exata do sinal é
\[
(-1)^{f(x)}=\sum_{j\ge0}(-2)^jP_j(x).
\]
Escreva (M_j) para a potência dividida inteira de ordem (j) do levantamento 0–1 do símbolo (a) no anel **comutativo** (\mathbb Z[x_i]/(x_i^2)). Assim (M_j) conta seleções de (j) monômios quárticos disjuntos. Ele coincide com a parte de grau (4j) de (P_j) e reduz a (\gamma_j(a)) módulo dois. Em dimensão 32, também escrevemos (M_8) para seu coeficiente único.

Por Poisson, em todo subespaço físico linear de dimensão 24, a soma de sinais restrita é ( -512+2^9 R) com (R\) inteiro. Sua parte na valoração seis é a paridade da cobertura por seis quárticas disjuntas. A soma é divisível por (512), portanto (\gamma_6(a)=0). Logo (M_6) é par coeficiente a coeficiente, em qualquer base.

Para um monômio de grau (d\ge25), a inversão de Walsh dá para o coeficiente inteiro do sinal a congruência
\[
[x_I](-1)^f\equiv-512(-1)^d\pmod {2^{d-15}},\qquad d=|I|.
\]
De fato, a parcela constante do espectro é (-512\,\mathbf1_{\{x=0\}}) no espaço físico, e cada coeficiente de grau (d) vindo do outro termo é ((-2)^d2^{-15}\sum_{b\supseteq I}k(b)).

Para (d\ge29), a expansão do sinal módulo (512) só pode receber contribuição de (256P_8), pois (\deg P_j\le4j). Logo (\deg e_8\le28). Para (d=28), a mesma comparação dá
\[
[e_8]_{28}=M_7/2\bmod2=a\wedge(M_6/2\bmod2).
\]
A divisão por dois é válida, pois (7M_7=A M_6) no anel de quadrados nulos, onde (A) levanta (a). A última igualdade usa que sete é ímpar. Em característica dois, (e_1 e_8=e_9) na álgebra booleana. Em cada ponto, isso segue da identidade (P_1P_8=9P_9+8P_8), válida para o número de monômios ativos. Como (e_1=f), o coeficiente de grau 32 de (e_9) é
\[
a\wedge[e_8]_{28}=a\wedge a\wedge (M_6/2\bmod2)=0.
\]
A última igualdade usa o quadrado nulo de toda forma exterior homogênea de grau positivo em característica dois. No grau 32, a expansão inteira módulo (1024) fica portanto (256M_8\). A congruência pela inversão de Walsh exige (256M_8\equiv-512\pmod{1024}). Concluímos
\[
\boxed{M_8\equiv2\pmod4.}
\]
O argumento vale em toda base linear. Nenhum passo desta seção usa a condição módulo 127.

## 2. Três consequências algébricas

**Zeros físicos.** Se (a|_U=0) num subespaço linear de codimensão (c\le7), em uma base adaptada todo monômio quártico usa pelo menos uma das (c) coordenadas complementares. Oito monômios quárticos disjuntos não podem então existir. Isso força (M_8=0), em contradição com a Seção 1. Portanto (f) tem grau quatro em todo subespaço físico linear de dimensão pelo menos 25. A exclusão se estende a flats afins com a mesma direção, pois a translação preserva o símbolo quártico restrito.

**Produtos exteriores.** Suponha (a=\sum_{i=1}^r p_i\wedge q_i), em que (p_i,q_i) são formas homogêneas de graus positivos que somam quatro e (r\le7). No anel comutativo inteiro de quadrados nulos use o levantamento (H=\sum_i H_i), (H_i=P_i' Q_i') para levantamentos integrais dos dois fatores. Substituir (A) por (A+2B) preserva a oitava potência dividida módulo quatro. Na expansão pela soma, apenas o termo linear em (2B) pode importar módulo quatro, e ele contém (2B M_7(A)), divisível por quatro. Para cada componente, a identidade inteira é
\[
\gamma_j^{\mathbb Z}(H_i)=j!\,\gamma_j^{\mathbb Z}(P_i')\gamma_j^{\mathbb Z}(Q_i').
\]
Ela segue elevando (P_i' Q_i') à potência (j) no anel comutativo e dividindo por (j!), o que é legítimo pois o anel tem base monomial livre sobre (\mathbb Z).

Na expansão de \(\gamma_8^{\mathbb Z}(H)\) módulo quatro, termos com multiplicidade pelo menos quatro e termos com pelo menos duas multiplicidades de dois ou mais são nulos. Também não há oito componentes distintas. Para um índice (i) repetido, ponha (G_i=\gamma_2(p_i)\gamma_2(q_i)) e (h_i=p_iq_i\). A contribuição de sua multiplicidade dois, dividida por dois e reduzida módulo dois, é (G_i\gamma_6(a+h_i)\). A de sua multiplicidade três é (G_i h_i\gamma_5(a+h_i)\), pela relação (\gamma_3(p_i)=p_i\gamma_2(p_i)\) e análoga para (q_i). Como (\gamma_j(h_i)=0) para (j\ge2), a soma dessas contribuições é (G_i\gamma_6(a)=0\). Resulta (M_8\equiv0\pmod4), uma contradição. Todo candidato requer no mínimo oito produtos exteriores.

**Forma orientada e classe de pares.** O coeficiente de volume da oitava potência dividida de um levantamento no exterior inteiro coincide com (M_8\bmod4). Com os monômios orientados em ordem crescente, a paridade do sinal de uma cobertura é a soma das paridades de inversão entre pares de blocos. Para cada par de blocos prescrito, o número de completamentos por seis quárticas no complemento é par porque (\gamma_6(a)=0\). Portanto um número par de coberturas recebe sinal negativo. Em particular, suponha que, em alguma base, todo monômio quártico seja a união de dois dentre 16 pares fixos, mutuamente disjuntos. No espaço dos pares, (a) é representado por uma 2-forma (q) de ordem 16. A condição (\gamma_6(q)=0) equivale a posto polar no máximo dez, pela forma normal alternante sobre (\mathbb F_2). O Pfaffiano inteiro de ordem 16 é divisível por (2^3): em uma base integral levantada invertível módulo dois, a matriz tem seis linhas e colunas nulas módulo dois. Em cada termo do Pfaffiano que emparelha os 16 índices há pelo menos três pares que tocam esses seis índices, e cada um paga um fator dois. A mudança de base tem determinante ímpar e preserva essa divisibilidade. O número não orientado de emparelhamentos difere desse Pfaffiano por duas vezes o número dos de sinal negativo. Esse número é par, pois, para cada cruzamento de duas arestas, o complemento de 12 índices admite um número par de emparelhamentos pela condição (\gamma_6(q)=0). Portanto (M_8\equiv0\pmod4), contra a Seção 1.

## 3. A congruência módulo 127 exclui dois blocos com até quatro controles

Fixe (r\le4) coordenadas lineares físicas em zero. Suponha que a restrição, a menos de mudança linear nessas coordenadas livres, seja (g_1(x)+g_2(y)), com (d_1,d_2\ge1) e (d_1+d_2=32-r\). Termos afins são absorvidos nos dois blocos. Por Poisson, o produto de Walsh (W_{g_1}(b_1)W_{g_2}(b_2)) é (-512\bmod2^{17-r}) em todas as frequências. As valorações (v_i) de (W_{g_i}) são então constantes, positivas e somam nove. Escreva (A_i=W_{g_i}/2^{v_i}) e (L=2^{8-r}). Fixar uma frequência do outro bloco mostra que cada (A_i) está em uma única classe ímpar módulo (L), e as duas classes têm produto (-1\bmod L). A expansão do sinal dá (d_i\le4v_i). Parseval dá (Q_i=\mathbb E A_i^2=2^{d_i-2v_i}\ge1). Pela inversão, \(\mu_i=\mathbb E A_i=\pm 2^{-v_i}\).

Os valores de (A_i) incluem ambos os sinais, pois são ímpares e \(|\mu_i|\le1/2\). Se (x_i) e (-y_i) forem os valores mais próximos de zero de cada sinal, todos os valores satisfazem \((A_i-x_i)(A_i+y_i)\ge0\). Daí
\[
x_i y_i-|x_i-y_i|2^{-v_i}\le Q_i,\qquad x_i+y_i\equiv0\pmod L.
\]
Como (x_i y_i\ge\max(x_i,y_i)), temos (x_i+y_i\le2Q_i\), de modo que a enumeração desses inteiros é finita. Ademais (x_1x_2\equiv-1\pmod L\).

Pela fórmula de Poisson antes de reduzir módulo 127, (A_1A_2= -1+L\sum_{u\in\mathbb F_2^r}k(u,b_1,b_2)\). Logo os quatro produtos (x_1x_2,-x_1y_2,-y_1x_2,y_1y_2) devem reduzir, módulo 127, a elementos de (\{-1+Ls:0\le s\le2^r\}\). O arquivo `verifica_invariante_M8.py` enumera todos os parâmetros e as cotas com inteiros e não encontra nenhuma solução para (r=0,1,2,3,4). A rotina usa somente condições necessárias. Como controle de calibração, para (r=5) ela deixa um único perfil de dimensões e valorações, ( (d_1,d_2,v_1,v_2)=(4,23,1,8)\), a menos de permutação dos blocos. Esse perfil aritmético por si só não produz uma função.

## 4. Escopo

O Astra encontrou a congruência da Seção 1. Ela substitui a exclusão parcial da frente de codimensão seis por uma exclusão integral em codimensões seis e sete. A congruência, junto de \(\gamma_6(a)=0\), não foi demonstrada impossível para uma 4-forma arbitrária em dimensão 32. O caso global \(D=h=0\) permanece em aberto. Uma forma que cumpra as condições algébricas deste adendo, se encontrada, ainda teria de ser levantada a uma função com todas as congruências de Walsh para constituir um contraexemplo.

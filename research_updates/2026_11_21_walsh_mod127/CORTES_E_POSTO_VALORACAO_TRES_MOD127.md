# Valoração três módulo 127 — cortes de 32 pontos e posto do símbolo quártico

No ramo global \(W_f=-512+2^{17}k\), \(k\bmod127\in\{0,1\}\), suponha que a menor valoração dos valores não nulos de \(T=k(k-1)/2\) seja três. Ponha \(P=\{\nu_2(T)=3\}\), \(Q=\{T\equiv16\bmod32\}\), \(N=|P|\), \(q=|Q|\) e \(a=[f]_4\). A análise anterior exige \(\dim\operatorname{aff}P=32,\ 202\le N\le290,\ q\le20\). Mostramos duas novas restrições.

1. Todo hiperplano afim \(H\) tem \(|P\cap H|\ge48\). Assim, o código das avaliações afins em \(P\) tem distância mínima pelo menos 48.
2. A forma bilinear \(B_a(x\wedge y,z\wedge t)=a(x,y,z,t)\) em \(\Lambda^2\mathbb F_2^{32}\) tem posto no máximo 168. Sua restrição aos símbolos das quadráticas que zeram em \(P\) tem posto no máximo 14.

## 1. Momentos usados nas duas provas

Escreva \(L=T/8\), inteiro em toda frequência. Para um produto \(M\) de \(j\) formas afins binárias, avaliado em inteiros, temos
\[
\sum_b L(b)M(b)\equiv
\begin{cases}
0\pmod4 & 0\le j\le3,\\
2a(v_1,v_2,v_3,v_4)\pmod4 & j=4 ,
\end{cases}
\]
onde \(v_i\) são as partes lineares no espaço físico. Para os fatores lineares, a diferença iterada de \(\widehat T\) em zero é \((-2)^j\sum_b T(b)M(b)\). Use \(\widehat T(x)\equiv128+256f(x)\pmod{512}\) e divida por \(8(-2)^j\). Os fatores afins seguem por expansão, e \(j=0\) segue da congruência na origem. Temos \(L\) ímpar em \(P\), \(L\equiv2\bmod4\) em \(Q\) e \(L\equiv0\bmod4\) fora de \(P\cup Q\). Os momentos binários de \(P\) até ordem cinco são nulos. Usamos também
\[
\sum_b T(b)\le B=528\,531\,328,\qquad
c_3=1\,813\,560,\quad c_4=7\,748\,016,
\]
onde \(c_3,c_4\) são os custos mínimos de um ponto em \(P,Q\), respectivamente. [Momentos e custos](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/0401146804e15448e519732727e00ef53be232da/research_updates/2026_11_21_walsh_mod127/SUPORTE_AFIM_VALORACAO_TRES_MOD127.md) · [Dimensão plena e limites para \(N,q\)](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/475e902cdcb4e4cefbcdd240e5bc11b4323e5863/research_updates/2026_11_21_walsh_mod127/SUPORTE_AFIM_PLENO_MOD127.md).

## 2. O símbolo da derivada a partir das duas camadas de um corte

Seja \(H\) um hiperplano espectral afim de normal \(v\ne0\). Ponha \(S=P\cap H\), \(J=Q\cap H\) e \(j=|J|\). Como \(P\) tem fecho afim pleno, \(S\ne\varnothing\). O indicador de \(H\) é afim. Multiplicar \(M\) por esse indicador na identidade anterior dá, no próprio \(H\), momentos ponderados nulos módulo quatro para ordens até dois, e em ordem três dá \(2\beta\), onde \(\beta=\iota_v a\) é uma 3-forma no quociente físico por \(\langle v\rangle\). Escreva \(d_S=\dim\operatorname{aff}S\) e \(d(\beta)\) para o número mínimo de formas lineares necessárias para expressar \(\beta\). Vamos provar
\[
d(\beta)\le d_S+\max\!\left(0,\left\lfloor\frac{j-1}{2}\right\rfloor\right). \tag{1}
\]

Se \(j=0\), toda forma afim que zera em \(S\) anula \(\beta\) por contração, diretamente pelo momento de ordem três. Suponha \(j>0\). Seja \(C\) o espaço das avaliações de formas afins em \(J\), e \(D\subseteq C\) o espaço das avaliações das formas afins em \(H\) que zeram em \(S\). O momento de ordem dois em \(H\) dá \(D\subseteq C^\perp\). De fato, se um fator zera em \(S\), o momento depende apenas de \(J\) módulo quatro, onde o peso é dois. Ponha \(e=\dim D=\dim\operatorname{aff}(S\cup J)-d_S\). Se \(\boldsymbol1\notin D\), então \(\dim C\ge e+1\), logo \(j\ge2e+1\). Qualquer parte linear normal ao fecho afim de \(S\cup J\) admite um representante afim que zera simultaneamente em \(S\) e em \(J\), e portanto anula \(\beta\) por contração. Isso dá \(d(\beta)\le d_S+e\).

Se \(\boldsymbol1\in D\), então \(j\) é par, pois \(\boldsymbol1\in C^\perp\) e \(\boldsymbol1\in C\). Para \(j\) par temos sempre \(d(\beta)\le d_S+e\le d_S+j/2\). Quando \(e=j/2\), segue \(D=C=C^\perp\), e os momentos de \(J\) até ordem dois são então nulos, pela auto-ortogonalidade de \(C\). Neste caso, use uma parte linear normal à soma das direções de \(\operatorname{aff}S\) e \(\operatorname{aff}J\), e escolha seu representante afim que zere em \(S\). Em \(J\) ele é constante. O momento de ordem três em \(H\) zera módulo quatro, pois a contribuição de \(J\) se reduz a um momento de ordem até dois. Assim a parte linear anula \(\beta\) por contração. Isso dá
\[
d(\beta)\le d_S+\dim\operatorname{aff}J=d_S+j/2-1.
\]
Se \(e<j/2\), o limite \(d(\beta)\le d_S+e\) já implica (1).

## 3. Autocorrelação com até 14 formas no símbolo cúbico

Seja \(g\) uma função de grau no máximo três em \(m\) variáveis, cujo símbolo cúbico se expresse em \(D\le14\) formas lineares. Suponha que \(\sum_x(-1)^{g(x)}\) seja divisível por 127. Separe as coordenadas \(y\) das \(D\) formas e some as demais em pares quadráticos de um modo que a parte em \(z\) seja \(\sum_{i=1}^t z_{2i-1}z_{2i}\), mais termos lineares em \(z\) com coeficientes afins em \(y\). Cada par soma a dois vezes um sinal de grau até dois em \(y\). Cada direção do radical do quadrático impõe uma equação afim em \(y\) e dá um fator dois. Se essas equações são consistentes e têm posto \(c\), resta uma cúbica \(g_0\) em \(d\le D\) variáveis, com soma de sinais \(Z_0\) divisível por 127. O viés original é \(2^{-(t+c)}Z_0/2^d\). Equações inconsistentes dão viés zero.

Para \(d\le11\), o argumento de divisibilidade e distância mínima já dá viés zero. Para \(12\le d\le14\), a divisibilidade por \(127\cdot2^{\lceil d/3\rceil}\) e o limite de \(3/4\) para o módulo do viés não constante dão as opções teóricas abaixo. A menor densidade entre \(g_0\) e \(1+g_0\) é \(w=(1-|Z_0|/2^d)/2\).

| \(d\) | \(|Z_0|/2^d>0\) | Menor densidade \(w\) | Consequência |
|---:|---:|---:|---|
| 12 ou 13 | \(127/256\) | \(129/512\) | excluída |
| 14 | \(381/512\) | \(131/1024\) | excluída |
| 14 | \(127/256\) | \(129/512\) | excluída |
| 14 | \(127/512\) | \(385/1024\) | admitida pelas cotas usadas |

O valor \(131/1024\) fica estritamente entre o peso mínimo relativo \(1/8\) e o segundo \(3/16\) de \(\mathrm{RM}(3,14)\). Para excluir \(129/512=1/4+1/512\), aplique Kasami–Tokura–Azumi ao intervalo \((1/4,5/16)\). A primeira família dá \(1/4+2^{-2-\ell}\) com \(\ell\le\lfloor(d-1)/2\rfloor\le6\). A segunda e a terceira têm pesos relativos pelo menos \(9/32\) e \(17/64\), respectivamente. Esses limites saem dos maiores \(i\) nas famílias \(5\cdot2^{d-4}-2\cdot2^i\) e \(5\cdot2^{d-4}-6\cdot2^i\), dividindo por \(2^d\). Funções constantes dão potências de dois, incompatíveis com 127. [Kasami–Tokura–Azumi](https://doi.org/10.1016/S0019-9958(76)90355-7) · [Fórmulas de pesos, Lemas 3 e 4 de Krotov](https://arxiv.org/pdf/1811.00015).

Concluímos que com \(D\le13\) o viés zera. Com \(D\le14\), seu módulo é zero ou é \((127/512)2^{-h}\) para algum inteiro \(h\ge0\).

## 4. Exclusão de todos os cortes de 32 pontos

O indicador de \(S=P\cap H\) tem momentos nulos até ordem quatro, pois basta multiplicar pelos indicadores afins de \(H\). Abaixo de 64 pontos, os pesos possíveis são \(32,48,56,60,62\). Pela classificação de Kasami–Tokura, no peso 32 temos \(d_S=5\).

A derivada \(g(x)=f(x)+f(x+v)\) tem símbolo \(\beta\) e soma \(\Delta_f(v)\) divisível por 127, pois \(W_f(b)^2\) é constante módulo 127. Se \(|S|=32\) e \(j\le18\), (1) dá \(D\le13\) e a seção 3 dá \(\Delta_f(v)=0\). Cada hiperplano de normal \(v\) tem massa de \(T\) no máximo \((B+E)/2\), com \(E=16\,256\), pois \(\widehat T(v)=\Delta_f(v)/8-E(-1)^{f(v)}\). Essa massa comporta no máximo 145 pontos de \(P\), logo no máximo 144 pela paridade de cada corte. O outro hiperplano tem pelo menos \(202-32=170\) pontos de \(P\), uma contradição.

Assim \(j\ge19\). Como \(q\le20\), (1) dá \(D\le14\). Ponha \(\lambda=|\Delta_f(v)|/2^{32}\). O hiperplano complementar tem massa pelo menos \(170c_3\). Isso força
\[
\lambda\,2^{29}\ \ge\ 2(170)c_3-B-E
=88\,062\,816\ >\ (127/1024)2^{29}.
\]
Logo a única opção da seção 3 é \(\lambda=127/512\). O hiperplano complementar tem massa superior à metade da massa total. Portanto \(H\) é o hiperplano de massa menor e sua massa é no máximo
\[
\frac{B-(127/512)2^{29}+E}{2}
=197\,689\,216 < 32c_3+19c_4=205\,246\,224.
\]
Isso contradiz o próprio custo dos pontos em \(H\). Nenhum hiperplano tem 32 pontos de \(P\), provando a distância mínima 48.

Uma consequência para os outros cortes pequenos é dada na tabela. Se \(N-w>144\), onde \(w=|S|\), então \(\Delta_f(v)\ne0\), logo (1) exige \(d_S+\lfloor(j-1)/2\rfloor\ge14\). Isso limita \(j\) por baixo e \(N\) por cima via orçamento. As cotas de \(d_S\) usam a diferença simétrica de dois 5-espaços afins ou a família quadrática apoiada em até sete coordenadas afins. [Formas normais de Kasami–Tokura](https://arxiv.org/pdf/1811.00015).

| \(w\) | \(d_S\) no máximo | \(j\) no mínimo se \(N-w>144\) | \(N\) no máximo se \(N-w>144\) |
|---:|---:|---:|---:|
| 48 | 7 | 15 | 226 |
| 56 | 8 | 13 | 234 |
| 60 | 9 | 11 | 244 |
| 62 | 10 | 9 | 252 |

## 5. Quadráticas que zeram em \(P\) restringem \(B_a\)

Para uma quadrática booleana \(G\), chame \(\widetilde G\) a soma inteira dos monômios de sua forma normal algébrica, incluindo termos de grau inferior. Denote por \(\mathcal I_2(P)\) o espaço das quadráticas booleanas que zeram em \(P\), e por \(K\subseteq\Lambda^2\mathbb F_2^{32}\) o espaço dos seus símbolos quadráticos. A passagem ao símbolo é injetiva em \(\mathcal I_2(P)\), pois \(P\) tem fecho afim pleno.

Se \(G\in\mathcal I_2(P)\), então em \(P\) temos \(\widetilde G\equiv2E_2(G)\bmod4\), onde \(E_2(G)\) é a soma binária dos produtos de pares de monômios de \(G\). A identidade vem da expansão do XOR módulo quatro. Como \(\deg E_2(G)\le4\), para toda forma afim \(\ell\) a soma binária de \(E_2(G)\ell\) em \(P\) é zero. O momento ponderado de \(\widetilde G\ell\) é zero módulo quatro por ordem até três. Sua contribuição de \(P\) é zero, pois \(L\) é ímpar em \(P\). Assim a imagem \(E_Q=\operatorname{ev}_Q\mathcal I_2(P)\) está contida em \(C(Q)^\perp\), onde \(C(Q)\) é o código das avaliações afins em \(Q\).

Para \(G,H\in\mathcal I_2(P)\), a contribuição de \(P\) para o momento de \(\widetilde G\widetilde H\) zera módulo quatro, pois cada levantamento é par em \(P\). A contribuição de \(Q\) dá
\[
B_a([G]_2,[H]_2)=\sum_{b\in Q}G(b)H(b)\qquad\text{em }\mathbb F_2.
\]
Logo o posto de \(B_a|_K\) é no máximo \(q-\dim C(Q)\). Se \(q>0\), \(\dim C(Q)\ge1+\lceil\log_2 q\rceil\) porque os \(q\) pontos são distintos. Para \(q\le20\), isso dá \(\operatorname{rank}(B_a|_K)\le14\), incluindo \(q=0\). Se \(Q\) é afimmente independente, \(E_Q=0\) e toda quadrática que zera em \(P\) também zera em \(Q\).

## 6. Cota de posto absoluto via o espaço de avaliações em \(P\)

Seja \(h_i\) a dimensão do código das avaliações de polinômios de grau até \(i\) em \(P\). Os momentos até ordem cinco dão \(h_2+h_3\le N\), pois os códigos de graus dois e três são ortogonais entre si. Logo \(b=h_3-h_2\le N-2h_2\).

Escolha uma ordem monomial compatível com grau no ideal polinomial de \(P\) sobre \(\mathbb F_2\). Os monômios padrão são quadrados livres, pois \(x_i^2-x_i\) pertence ao ideal. São fechados por divisores, e os de grau até \(i\) contam \(h_i\), pela compatibilidade da ordem com grau. Um monômio padrão de grau \(d\ge3\) precisa ter todos os seus divisores de grau três entre os \(b\) monômios padrão de grau três. Kruskal–Katona limita o número de tais cliques em um hipergrafo de \(b\) triplas pelo segmento inicial de colex de \(b\) triplas. [Versão para cliques de hipergrafos, Teorema 10](https://par.nsf.gov/servlets/purl/10583440).

Se \(b=\sum_{i=1}^3\binom{a_i}{i}\) é a representação binomial usual, omitindo seus termos nulos, o número de cliques de tamanhos \(d\ge3\) nesse segmento é
\[
F(b)=\sum_{i=1}^3\sum_{r=i}^{a_i}\binom{a_i}{r}.
\]
De fato, para cada \(d\), o número é \(\sum_i\binom{a_i}{i+d-3}\), obtido decompondo o segmento em blocos de colex com \(3-i\) vértices fixados. Como há \(N-h_2\) monômios padrão de graus pelo menos três,
\[
N-h_2\le F(N-2h_2).
\]
Além disso, \(\operatorname{codim}K=h_2-33\) em \(\Lambda^2\mathbb F_2^{32}\): o domínio das quadráticas tem dimensão \(33+\binom{32}{2}\), sua imagem nas avaliações tem dimensão \(h_2\), e a passagem daquelas que zeram ao símbolo é injetiva. Ao estender a matriz de \(B_a|_K\), cada nova coordenada pode acrescentar no máximo dois ao posto. Logo
\[
\operatorname{rank}B_a
\le 2(h_2-33)+q-\dim C(Q)
\le168,
\]
usando o orçamento \(q\le\lfloor(B-c_3 N)/c_4\rfloor\), a paridade de \(N\) e a desigualdade de colex acima.

## 7. Verificação inteira das cotas

~~~~python
from math import comb

B, E = 528_531_328, 16_256
c3, c4 = 1_813_560, 7_748_016

def cap_p(q):
    return 2 * ((B - c4 * q) // (2 * c3))

assert (B + E) // (2 * c3) == 145
assert 2 * 170 * c3 - B - E == 88_062_816 > 127 * 2**19
assert (B - 127 * 2**20 + E) // 2 == 197_689_216
assert 32 * c3 + 19 * c4 == 205_246_224
assert [(2 * (14 - d) + 1, cap_p(2 * (14 - d) + 1))
        for d in (7, 8, 9, 10)] == [
            (15, 226), (13, 234), (11, 244), (9, 252)
        ]

def colex_tail(triples):
    total = 0
    ceiling = triples + 2
    for degree in (3, 2, 1):
        if not triples:
            break
        a = max(x for x in range(degree, ceiling + 1)
                if comb(x, degree) <= triples)
        total += sum(comb(a, r) for r in range(degree, a + 1))
        triples -= comb(a, degree)
        ceiling = a - 1
    return total

def cap_h2(n):
    return max(h for h in range(n // 2 + 1)
               if n - h <= colex_tail(n - 2*h))

def rank_cap_on_k(q):
    return q - 1 - (q - 1).bit_length() if q else 0

def rank_cap(n):
    q = (B - n * c3) // c4
    return 2 * (cap_h2(n) - 33) + rank_cap_on_k(q)

assert max(cap_h2(n) for n in range(202, 291, 2)) == 117
assert max(rank_cap(n) for n in range(202, 291, 2)) == 168
assert rank_cap(202) == 104
~~~~

A valoração mínima três permanece aberta com \(P\) de dimensão afim plena e distância mínima pelo menos 48 para suas avaliações afins. Os limites de posto impõem uma condição adicional ao símbolo \(a\) desse ramo. As valorações mínimas zero, um e dois também continuam abertas.

# Cortes espectrais excluem dimensões afins até 30 no ramo global módulo 127

Considere uma candidata \(f:\mathbb F_2^{32}\to\mathbb F_2\) de grau no máximo quatro com
\[
W_f(b)=-512+2^{17}k(b),\qquad k(b)\bmod127\in\{0,1\}.
\]
Escreva \(T(b)=k(b)(k(b)-1)/2\), \(a=[f]_4\), \(P=\{b:16\nmid T(b)\}\) e \(Q=\{b:T(b)\equiv16\bmod32\}\). Nesta nota, \(P\) é sempre o conjunto de **todas** as frequências com \(16\nmid T(b)\). Se a menor valoração 2-ádica de \(T\ne0\) for três, então \(P=\{b:\nu_2(T(b))=3\}\), e provamos
\[
\boxed{\dim\operatorname{aff}P\in\{31,32\}.}
\]
Para qualquer valoração mínima, se \(\dim\operatorname{aff}P\le30\), o fecho afim de \(Q\) tem codimensão no máximo um.

## 1. Dados de partida

Usamos a congruência \(\widehat T(v)\equiv128+256f(v)\pmod{512}\) e o fato de que, para cada \(v\ne0\), a 3-forma \(\iota_v a\) requer pelo menos oito formas lineares para expressar seu símbolo. Em termos intrínsecos, a dimensão do quociente pelo radical dessa 3-forma é pelo menos oito. Também usamos \(P\ne\varnothing\), \(\sum_b T(b)\le B=528\,531\,328\) e \(T(b)\ge c_4=7\,748\,016\) em \(Q\). [Congruência e custo mínimo](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/b3890a40dc9536fda11679e1fc5547b180e5f600/research_updates/2026_11_21_walsh_mod127/OBSTRUCAO_CODIGO_TRIORTOGONAL_MOD127.md) · [Cota de suporte da contração, §10.6](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/a62baae440e10b095a20b33ea5013237a0d1283b/research_updates/2026_11_21_walsh_mod127/rigidez_walsh_32_127_ramo_F.md).

Se um dos fatores de um produto de até quatro formas afins se anula em \(P\), a soma binária do produto em \(Q\) é zero em ordens até três, e é \(a(v_1,v_2,v_3,v_4)\) em ordem quatro. Aqui \(v_i\) são as partes lineares no espaço físico \(V=\mathbb F_2^{32}\). De fato, basta dividir a diferença de ordem \(j\) de \(\widehat T\) por \((-2)^j\) para fatores lineares, depois expandir os termos afins. Obtém-se, módulo 32, zero em ordens até três e \(16a(v_1,v_2,v_3,v_4)\) em ordem quatro para o momento ponderado por \(T\). O caso constante segue de \(\widehat T(0)\equiv0\bmod32\). O fator que se anula em \(P\) permite dividir por 16 na soma ponderada, e os pontos que sobrevivem módulo dois são os de \(Q\). [Identidade dos momentos afins](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/0401146804e15448e519732727e00ef53be232da/research_updates/2026_11_21_walsh_mod127/SUPORTE_AFIM_VALORACAO_TRES_MOD127.md).

## 2. Cada corte que evita \(P\) força 18 pontos de \(Q\)

Ponha \(s=\dim\operatorname{aff}P\), suponha \(s<32\) e tome \(U=(\operatorname{dir}\operatorname{aff}P)^\perp\), com \(u=32-s\). Para cada \(v\in U\setminus\{0\}\), existe uma única forma afim \(\ell_v\) de parte linear \(v\) que se anula em \(P\). Ponha
\[
Q_v=\{b\in Q:\ell_v(b)=1\}.
\]

Aplicando a relação dos momentos com \(\ell_v\) como primeiro fator, os momentos afins de \(Q_v\) de ordens zero, um e dois são todos nulos. O momento cúbico de \(Q_v\) é \(\iota_v a\). Em particular \(Q_v\) é não vazio, pois \(\iota_v a\ne0\). Segue também que \(Q\) é não vazio e que a avaliação das formas \(\ell_v\) em \(Q\) é injetiva.

Seja \(A_v\) o espaço das avaliações de formas afins em \(Q_v\) e \(d_v=\dim\operatorname{aff}Q_v\). Então \(\dim A_v=d_v+1\). A direção do fecho afim de \(Q_v\) tem ortogonal contido no radical de \(\iota_v a\). De fato, uma parte linear nesse ortogonal avalia como constante em \(Q_v\), e seu momento cúbico com outros dois fatores se reduz a zero ou a um momento quadrático, em ambos os casos nulo. Isso implica \(d_v\ge8\). Além disso, \(A_v\subseteq A_v^\perp\), pois o produto escalar de duas palavras de \(A_v\) é um momento de ordem dois. Logo
\[
|Q_v|\ge2(d_v+1)\ge18
\qquad(v\in U\setminus\{0\}).
\]

## 3. Duas cotas para \(q=|Q|\)

**Contagem de todos os cortes.** Escolha \(b_0\in P\). Como \(\ell_v(b)=v\cdot(b+b_0)\), para cada \(b\in Q\) há zero ou \(2^{u-1}\) vetores \(v\in U\) com \(\ell_v(b)=1\). Portanto
\[
18(2^u-1)\le\sum_{v\in U\setminus\{0\}}|Q_v|
\le2^{u-1}q .
\]
Em particular, \(q\ge27\) para \(u\ge2\).

**Dimensão dentro do dual.** Seja \(C\) o espaço de avaliações de todas as formas afins em \(Q\) e seja \(r=32-\dim\operatorname{aff}Q\), de modo que \(\dim C=33-r\). Para \(v\ne0\) em \(U\) e \(c\in C\), multiplique \(c\) coordenada a coordenada por \(\ell_v|_Q\). O resultado pertence a \(C^\perp\), pois o produto escalar com qualquer palavra de \(C\) é um momento de ordem dois em \(Q_v\). O espaço desses produtos é \(A_v\) estendido por zeros fora de \(Q_v\) e tem dimensão \(d_v+1\ge9\). Assim
\[
q\ge(33-r)+(d_v+1)\ge42-r .
\]
Se \(Q\) fica inteiramente num dos cortes \(\{\ell_v=1\}\), seus momentos de ordem até dois são nulos, de modo que \(C\subseteq C^\perp\) e \(q\ge2(33-r)\).

## 4. Exclusão de \(s\le30\) na valoração mínima três

A cota de massa de \(T\) no fecho afim de \(Q\), obtida pela média de Fourier a partir de \(|\widehat T(v)|\le F=3\cdot2^{26}+16\,256\) para \(v\ne0\), dá
\[
q\le\left\lfloor\frac{F+2^{-r}(B-F)}{c_4}\right\rfloor .
\]
A cota vale para todas as valorações mínimas. [Demonstração da cota de massa afim](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/dcb2f41901844379880f0efa2fb9aefc1fe50a6e/research_updates/2026_11_21_walsh_mod127/AUTOCORRELACAO_E_DIMENSAO_AFIM_MOD127.md).

Se \(s\le30\), então \(u\ge2\). Para \(r=2,3,4,5\) a cota superior de \(q\) é, respectivamente, \(36,31,28,27\), cada uma estritamente menor que \(42-r\). Para \(r\ge6\) a cota superior é no máximo 26, contra \(q\ge27\). Portanto \(r\le1\). Além disso, \(U\cap R=0\) para \(R=(\operatorname{dir}\operatorname{aff}Q)^\perp\). De fato, se \(0\ne v\in U\cap R\), então \(\ell_v\) avalia como constante não nula em \(Q\) e \(q\ge2(33-r)\). Para \(r=1\) isso exigiria \(q\ge64\), mas a cota de massa dá \(q\le47\).

Na valoração mínima três, o resultado anterior \(|P|\ge128\) e o custo mínimo \(c_3=1\,813\,560\) em \(P\) dão \(q\le38\), pois \(P\cap Q=\varnothing\) e \(c_3|P|+c_4q\le B\). Mas \(q\ge42-r\ge41\) quando \(r\le1\). Portanto \(s\le30\) é impossível. [Custo e cota \(|P|\ge128\)](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/0401146804e15448e519732727e00ef53be232da/research_updates/2026_11_21_walsh_mod127/SUPORTE_AFIM_VALORACAO_TRES_MOD127.md).

## 5. Perfis em dimensão 31

Se \(s=31\), escreva \(U=\langle v\rangle\), \(Q_1=Q_v\), \(Q_0=Q\setminus Q_1\), \(r=32-\dim\operatorname{aff}Q\) e \(d=\dim\operatorname{aff}Q_1\). As cotas \(q\ge42-r\) e \(q\le38\) excluem \(r=0,1\). Para \(2\le r\le16\), a massa afim dá \(q<42-r\), logo \(r\ge17\) e \(q\le25\). A auto-ortogonalidade em \(Q_1\) dá \(8\le d\le11\).

Se \(Q_0\ne\varnothing\), então \(d\le31-r\), pois \(Q_1\) fica num hiperplano de \(\operatorname{aff}Q\). Portanto \(r\le23\), \(q\ge19\), e \(q\ge34-r+d\) pelo argumento do dual. Se \(Q_0=\varnothing\), temos \(d=32-r\) e \(q\ge2(33-r)\). Nesse caso \(21\le r\le24\). Em resumo,

| Corte oposto a \(P\) | \(r\) possível | Cotas para \(q\) | Cota para \(|P|\) |
|---|---:|---|---:|
| \(Q_1\subsetneq Q\) | \(17\) a \(23\) | \(\max(19,42-r)\le q\le25\) | \(210\) |
| \(Q_1=Q\) | \(21\) a \(24\) | \(2(33-r)\le q\le25\) | \(214\) |

As cotas para \(|P|\) seguem de \(c_3|P|+c_4q\le B\) e da paridade de \(|P|\). A paridade segue de \(\sum_bT(b)\equiv0\bmod16\) e \(T\equiv8\bmod16\) em \(P\).

## 6. Verificação aritmética

O código confere as desigualdades inteiras das duas seções anteriores. A exclusão dimensional usa apenas os argumentos de momentos, dimensão e custo acima.

~~~~python
B = 528_531_328
F = 3 * 2**26 + 16_256
c3, c4 = 1_813_560, 7_748_016

def mass_cap(r):
    return (F + (B - F) // (1 << r)) // c4

def cap_val3(r):
    return min((B - 128 * c3) // c4, mass_cap(r))

def cap_p(q):
    return 2 * ((B - c4 * q) // (2 * c3))

assert [mass_cap(r) for r in range(1, 7)] == [47, 36, 31, 28, 27, 26]
assert all(mass_cap(r) < 42 - r for r in range(2, 6))
assert all(mass_cap(r) <= 26 for r in range(6, 33))
assert cap_val3(0) == cap_val3(1) == 38
assert all(cap_val3(r) < 42 - r for r in range(17))
assert all(cap_val3(r) == 25 for r in range(17, 33))

proper_cut = [r for r in range(33)
              if r <= 23 and max(19, 42 - r) <= cap_val3(r)]
full_cut = [r for r in range(33)
            if r <= 24 and 2 * (33 - r) <= cap_val3(r)]
assert proper_cut == list(range(17, 24))
assert full_cut == list(range(21, 25))
assert cap_p(19) == 210
assert cap_p(18) == 214
~~~~

O caso global \(D=0,h=0\) segue aberto. A valoração mínima três fica restrita a \(s=31,32\), com os perfis acima em \(s=31\). Nas valorações mínimas zero, um ou dois, as cotas dos cortes valem para \(P=\{16\nmid T\}\) e dão a restrição \(r\le1\) sempre que \(s\le30\).

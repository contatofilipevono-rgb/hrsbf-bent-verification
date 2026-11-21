# A valoração três exige suporte afim pleno no ramo global módulo 127

Considere \(f:\mathbb F_2^{32}\to\mathbb F_2\) de grau no máximo quatro com
\[
W_f(b)=-512+2^{17}k(b),\qquad k(b)\bmod127\in\{0,1\}.
\]
Ponha \(T=k(k-1)/2\). Se a menor valoração dos valores não nulos de \(T\) é três, defina \(P=\{\nu_2(T)=3\}\), \(Q=\{T\equiv16\bmod32\}\) e \(a=[f]_4\). Provamos que
\[
\boxed{\dim\operatorname{aff}P=32,\qquad 202\le |P|\le290,\qquad |Q|\le20.}
\]
A exclusão da dimensão 31 é algébrica. A cota inferior de 202 vem de uma recorrência finita de encurtamento de códigos, verificada por Python.

## 1. Símbolo cúbico pequeno força equilíbrio da derivada

**Lema.** Seja \(g:\mathbb F_2^N\to\mathbb F_2\) de grau no máximo três. Se o símbolo cúbico de \(g\) se expressa em no máximo 11 formas lineares e \(127\mid\sum_x(-1)^{g(x)}\), então \(\sum_x(-1)^{g(x)}=0\).

Escolha coordenadas \((y,z)\), com no máximo 11 coordenadas \(y\), nas quais a parte cúbica usa apenas \(y\). Escreva \(g=p(y)+q(z)+L_y(z)\), com \(p\) de grau até três, \(q\) quadrático e \(L_y\) linear em \(z\) com coeficientes afins em \(y\). Podemos escrever a parte quadrática em \(z\) como \(\sum_{i=1}^j z_{2i-1}z_{2i}\) por uma mudança linear nas coordenadas \(z\) e absorver os termos de grau inferior em \(L_y\) e \(p\).

Somar em cada par \(z_{2i-1},z_{2i}\) dá \(2(-1)^{\ell_{2i-1}(y)\ell_{2i}(y)}\), onde \(\ell_k(y)\) é o coeficiente linear de \(z_k\). Cada coordenada restante impõe \(\ell_k(y)=0\) e fornece um fator dois. Logo a soma inicial é zero ou é uma potência de dois vezes uma soma de sinais de grau até três em um subespaço afim de dimensão \(d\le11\). Escreva a soma remanescente como \(Z(h)\). A divisibilidade por 127 passa a \(Z(h)\).

Para \(d\le10\), \(Z(h)\) é divisível por \(2^{\lceil d/3\rceil}\). Essa divisibilidade segue expandindo o sinal pelos monômios e observando que um produto de \(j\) deles fixa no máximo \(3j\) coordenadas. O quociente tem módulo no máximo \(2^{d-\lceil d/3\rceil}\le64\), portanto zera. Para \(d=11\), uma função constante tem \(Z(h)=\pm2^{11}\), incompatível com a divisibilidade por 127. Para \(h\) não constante, tanto \(h\) como \(1+h\) têm peso pelo menos \(2^8\) pela distância mínima de Reed–Muller. Logo \(|Z(h)|\le1536\). O quociente por 16 é múltiplo de 127 e tem módulo no máximo 96, logo zera. Isso prova o lema.

## 2. Dimensão 31 limita \(|P|\) a 144

A análise de cortes espectrais já exclui dimensões afins de \(P\) até 30. Suponha \(\dim\operatorname{aff}P=31\), escreva \(\operatorname{aff}P=\{b:v\cdot b=\epsilon\}\) com \(v\ne0\) e tome \(Q_1=Q\cap\{b:v\cdot b=1+\epsilon\}\). O corte \(Q_1\) tem seus momentos binários de ordens até dois nulos, e seu momento cúbico é \(\iota_v a\). Também vale \(|Q|\le25\) nessa dimensão, pela cota de massa afim. A auto-ortogonalidade das avaliações afins em \(Q_1\) dá \(2(\dim\operatorname{aff}Q_1+1)\le |Q_1|\le25\). Toda normal ao fecho afim de \(Q_1\) avalia como constante e anula o momento cúbico por contração. Logo a 3-forma \(\iota_v a\), que é o símbolo de \(x\mapsto f(x)+f(x+v)\), se expressa em no máximo 11 formas lineares. [Resultados dos cortes espectrais](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/059b5c742ff2e67663a42d6b0cb6f22322cf81f5/research_updates/2026_11_21_walsh_mod127/CORTES_ESPECTRAIS_DIMENSAO_31_MOD127.md).

Como \(W_f^2\) é constante módulo 127, a transformada inversa dá \(127\mid\Delta_f(v)\) para \(v\ne0\), onde \(\Delta_f(v)=\sum_x(-1)^{f(x)+f(x+v)}\). O lema dá \(\Delta_f(v)=0\). Pela identidade \(\widehat T(v)=\Delta_f(v)/8-16256(-1)^{f(v)}\) fora da origem, a massa de \(T\) em \(\operatorname{aff}P\) é no máximo
\[
\frac{\widehat T(0)+|\widehat T(v)|}{2}
\le\frac{528\,531\,328+16\,256}{2}=264\,273\,792 .
\]
O custo mínimo de cada ponto de \(P\) é \(1\,813\,560\), de modo que \(|P|\le145\). Os momentos de \(P\) de ordens até cinco são nulos, inclusive a paridade. Portanto \(|P|\le144\). [Identidade de Fourier, custos CRT e momentos de \(P\)](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/0401146804e15448e519732727e00ef53be232da/research_updates/2026_11_21_walsh_mod127/SUPORTE_AFIM_VALORACAO_TRES_MOD127.md).

## 3. Prova algébrica de que 144 pontos não bastam

Para um conjunto binário \(S\), chame \(C(S)\) o código das avaliações afins, de dimensão \(\dim\operatorname{aff}S+1\). Se os momentos de \(S\) até ordem \(t\) são nulos, o suporte de uma palavra de \(C(S)\) tem momentos nulos até \(t-1\), pois seu indicador em \(S\) é uma avaliação afim.

Os suportes não vazios das palavras de \(C(P)\) têm momentos nulos até ordem quatro. No fecho afim de \(P\), o indicador de cada suporte pertence a \(\mathrm{RM}(s-5,s)\), com \(s=\dim\operatorname{aff}P\), pela dualidade de Reed–Muller. A distância mínima é 32. Abaixo de 64, Kasami–Tokura dá os pesos \(32,48,56,60,62\). O peso 32 tem suporte um subespaço afim de dimensão cinco. Nos pesos de 48 a 62, a dimensão afim é no máximo dez. Na família de dois produtos com fatores comuns ela é no máximo \(5+\mu\le10\), e na família quadrática é no máximo sete. [Kasami–Tokura, 1970](https://doi.org/10.1109/TIT.1970.1054545) · [Formas normais no Lema 5 de D. S. Krotov](https://arxiv.org/pdf/1811.00015).

Use a cota de Griesmer \(n\ge G(k,\delta)=\sum_{j=0}^{k-1}\lceil\delta/2^j\rceil\) para códigos binários de comprimento \(n\), dimensão \(k\) e distância mínima \(\delta\). Ela segue pela projeção para fora do suporte de uma palavra mínima \(w\). O núcleo é gerado por \(w\), e se \(z\) não está nesse núcleo, comparar os pesos de \(z\) e \(z+w\) mostra que o peso de \(z\) fora de \(w\) é pelo menos \(\lceil\delta/2\rceil\). Indução dá \(G\). [Cota de Griesmer](https://hyperelliptic.org/tanja/teaching/CCI11/CODING.pdf).

Vamos também usar **encurtamento** no suporte \(S\) de uma palavra. Primeiro, passe ao subcódigo de palavras que zeram em \(S\). Em seguida, apague as coordenadas de \(S\). O comprimento cai em \(|S|\), a distância mínima não cai e a dimensão cai no máximo \(\dim C(S)\). Essa última afirmação segue do posto da aplicação de restrição a \(S\). Cada palavra do código encurtado conserva seu suporte original em \(P\), pois foi escolhida para valer zero nas coordenadas apagadas. As mesmas restrições por pesos de Reed–Muller continuam válidas.

Suponha \(s\ge31\) e \(|P|\le144\). A dimensão de \(C(P)\) é pelo menos 32, e \(G(32,64)=152>144\), logo a distância mínima é menor que 64. Se ela for pelo menos 48, encurte no suporte de uma palavra mínima. A dimensão que resta é ao menos \(32-11=21\) e o comprimento é no máximo \(144-48=96\). Isso viola \(G(21,48)=110\). Portanto existe palavra de peso 32. Encurte em seu suporte, de dimensão afim cinco, restando comprimento até 112 e dimensão pelo menos 26. Como \(G(26,48)=115\), a distância mínima ainda é 32. Encurte mais uma vez. Restam comprimento até 80 e dimensão pelo menos 20. Como \(G(20,48)=109\), há novamente uma palavra de peso 32. Depois do terceiro encurtamento restam pelo menos 14 dimensões em comprimento até 48, com distância mínima pelo menos 32, contra \(G(14,32)=71\).

Portanto \(|P|\le144\) e \(s\ge31\) são incompatíveis. A seção 2 exclui \(s=31\), de modo que \(P\) tem fecho afim pleno.

## 4. Uma cota recursiva para \(|P|\) com fecho afim pleno

A mesma ideia fornece uma cota de 202 pontos para \(s=32\). Em cada estado \((t,n,k,\delta)\), procuramos um código possivelmente obtido por encurtamentos de um código de avaliações de um conjunto com momentos nulos até \(t\). O comprimento atual é \(n\), a dimensão é pelo menos \(k\) e a distância mínima é pelo menos \(\delta\). Enumeramos os pesos \(d\) possíveis da palavra mínima. Como o suporte dessa palavra tem momentos nulos até \(t-1\), \(d\) é par e \(G(k,d)\le n\).

Se \(U_{t-1}(d)\) é uma cota superior para a dimensão do código de avaliações de um conjunto de \(d\) pontos com momentos nulos até \(t-1\), encurtar no suporte da palavra mínima muda o estado para
\[
(t,n-d,k-U_{t-1}(d),d).
\]
Para calcular \(U_j(m)\), aplique o mesmo teste ao código de avaliações original de \(m\) pontos com momentos nulos até \(j\). Sua distância mínima é pelo menos \(2^j\), pois o suporte de uma palavra não nula tem momentos nulos até \(j-1\), logo contém pelo menos \(2^j\) pontos. Seu código de avaliações é auto-ortogonal para \(j\ge2\), logo tem dimensão no máximo \(m/2\). Para \(j=2\), usamos apenas essa última cota. A recursão estritamente diminui \(n\) a cada encurtamento ou \(j\) a cada consulta a um suporte. Quando um estado é rejeitado, nenhum código com essas propriedades pode realizá-lo. Um estado aceito satisfaz apenas as condições necessárias usadas no teste.

Para reforçar \(U_3\) e \(U_4\) nos pesos abaixo de duas vezes o mínimo, aplicamos Kasami–Tokura. O mínimo \(2^{j+1}\) é um subespaço afim de dimensão \(j+1\). Para peso \(w\) acima desse mínimo e abaixo do dobro, na família de dois subespaços de dimensão \(j+1\), sua interseção tem tamanho \((2^{j+2}-w)/2=2^i\). O fecho afim da união tem dimensão \(2(j+1)-i\), pois a interseção é não vazia. A outra família tem dimensão afim no máximo \(j+3\). As tabelas no código usam o maior dos dois limites, mais um para a dimensão das avaliações afins. Uma entrada zero indica que o peso é impossível.

~~~~python
from functools import cache

SMALL_AFFINE_RANK = {
    3: {16: 5, 24: 7, 28: 8, 30: 9},
    4: {32: 6, 48: 8, 56: 9, 60: 10, 62: 11},
}

@cache
def griesmer(dimension, distance):
    return sum((distance + (1 << j) - 1) >> j
               for j in range(dimension))

@cache
def affine_rank_cap(strength, size, use_small_weights):
    if size < 1 << (strength + 1):
        return 0
    if strength == 2:
        return size // 2
    if use_small_weights and strength in SMALL_AFFINE_RANK:
        if size < 1 << (strength + 2):
            return SMALL_AFFINE_RANK[strength].get(size, 0)
    for dimension in range(size // 2, 0, -1):
        if admissible(strength, size, dimension, 1 << strength,
                      use_small_weights):
            return dimension
    return 0

@cache
def admissible(strength, length, dimension, lower_distance,
               use_small_weights):
    if dimension <= 0:
        return True
    for distance in range(lower_distance, length + 1, 2):
        if griesmer(dimension, distance) > length:
            break
        rank_cap = affine_rank_cap(strength - 1, distance,
                                   use_small_weights)
        if rank_cap > 0 and admissible(
            strength, length - distance, dimension - rank_cap,
            distance, use_small_weights
        ):
            return True
    return False

def first_admissible_size(dimension, use_small_weights):
    return next(size for size in range(64, 292, 2)
                if admissible(5, size, dimension, 32, use_small_weights))

assert [griesmer(k, d) for k, d in
        [(32, 64), (21, 48), (26, 48), (20, 48), (14, 32)]] == [
            152, 110, 115, 109, 71
        ]
assert first_admissible_size(32, True) == 200
assert first_admissible_size(33, True) == 202
assert first_admissible_size(33, False) == 196
assert (528_531_328 + 16_256) // (2 * 1_813_560) == 145
assert (528_531_328 - 202 * 1_813_560) // 7_748_016 == 20
~~~~

O resultado para dimensão 33 de avaliações dá \(|P|\ge202\). Como \(P\cap Q=\varnothing\), o orçamento \(1\,813\,560|P|+7\,748\,016|Q|\le528\,531\,328\) dá \(|Q|\le20\). Também resulta \(|P|\le290\) pela paridade. Sem as formas de Kasami–Tokura, a mesma recursão dá \(|P|\ge196\).

Na valoração mínima três resta apenas \(P\) com dimensão afim 32. As valorações mínimas zero, um e dois também seguem abertas no caso global \(D=0,h=0\).

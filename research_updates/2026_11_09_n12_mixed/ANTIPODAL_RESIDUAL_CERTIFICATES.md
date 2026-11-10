# Sete certificados para os suportes restantes da forma alternada 9

O Fable obteve uma identidade para os três coeficientes nas máscaras 27, 45 e 54 e está estudando a classificação das funções \(\psi\) divididas. Esta nota trata da etapa seguinte. Os 20 suportes que sobrevivem às três máscaras formam sete órbitas de mudanças de coordenadas. Cada órbita tem um representante excluído pela soma de quatro ou cinco equações de sinais. A redução a esses representantes ainda usa a enumeração finita dos suportes.

## Uma fórmula direta para os coeficientes

Para \(z,w\in\mathbb F_2^6\), escreva a função como \(h(z)+\pi(z)\cdot w+q_z(w)\), onde \(q_z\) é quadrática pura e tem matriz polar \(B_z=\iota_z\tau\). Se \(s(z,\beta)\) é o bit de sinal do Walsh parcial na frequência \(\beta\), transladar \(w\) por \(e_0\) dá, para qualquer \(\beta\) no suporte da linha,

$$
\pi_0(z)=s(z,\beta)+s(z,\beta+B_ze_0)+\beta_0.
$$

Usamos a menor \(\beta\) da linha. A fórmula vale também em posto zero, quando os dois sinais se cancelam. O coeficiente \(c_m\) da ANF de \(\pi_0\) é a soma dessas expressões sobre as submáscaras de \(m\).

Em uma linha com quatro entradas, o XOR dos quatro sinais é 1. Com efeito, as entradas têm módulo 32 e sua soma é \(64(-1)^{f(z,0)}\). O mesmo vale para uma coluna com quatro entradas, cuja soma é o Walsh completo na frequência \((0,\beta)\). Para reduzir os índices à órbita de cada par usamos

$$
s(Rz,R\beta)=s(z,\beta)+z_5\beta_5.
$$

As identidades abaixo usam apenas essas equações e a fórmula de translação. A função \(h(z)\), denotada \(g_0\) na nota do Fable, fica livre.

## A parte da redução do Fable que conferimos

Escreva \(z=(a,a+v)\) e \(\pi=(p,p+\psi)\), com \(a,v\in\mathbb F_2^3\). Seja \(D\) o conjunto \(v=0\). As oito linhas em \(D\) têm posto zero. A rotação \(R^3\) fixa cada linha e, portanto, fixa sua frequência unitária. Essas frequências estão em \(D\) e são distintas, pois cada uma preenche a norma da coluna. Elas ocupam as oito frequências de \(D\). Qualquer outra linha com \(\psi=0\) tocaria uma dessas colunas. Assim \(\psi=0\) exatamente em \(D\).

A restrição \(p_D\) é uma permutação e comuta com a rotação de três posições. O ciclo de sinais nessa restrição exige \(a\cdot p_D(a)=0\). Portanto \(p_D(0)=111\) e \(p_D(111)=0\). Se os pesos 1 e 2 são trocados, o único mapa é o complemento. Se são preservados, o peso 1 admite os dois ciclos não triviais e o peso 2 só admite a identidade.

A terceira potência da rotação dá

$$
p(a+v,v)=p(a,v)+\psi(a,v)+v\times a.
$$

No subespaço \(V_2=\{z_2=z_5=0\}\), os pontos fora de \(D\) formam seis pares. A soma de \(v\times a\) sobre um representante de cada par é \(e_2\). Para cada \(v\ne0\) com \(v_2=0\), os dois pares contribuem juntos \(e_2\), e há três valores de \(v\). Somando a identidade de meia-volta e usando a rotação para identificar os outros dois coeficientes, obtemos

$$
(c_{27},c_{45},c_{54})
=\sum_{(a,a)\in V_2\cap D}p_D(a)+e_2
+\sum_{\{z,R^3z\}\subset V_2\setminus D}\psi(z).
$$

A soma de \(\psi\) é independente do representante porque \(\psi\) é constante no par. As correções de grau no máximo dois na rotação de \(\pi\) somam zero em \(V_2\). Conferimos essa identidade nos 288 suportes com sinais conjuntos.

## As simetrias

Um circulante invertível em seis coordenadas levanta para um circulante invertível em doze. A coprimalidade com \(X^6+1\) implica coprimalidade com \(X^{12}+1=(X^6+1)^2\). A reflexão dos índices em seis posições também levanta para doze. A ação de um levantamento nas coordenadas \((z,w)\) tem a forma \((Az,Aw+Lz)\), pois comuta com a meia-volta. A transformação \(A\) preserva \(D\) e, portanto, preserva a forma de volume \(\tau\) no quociente tridimensional. O suporte passa de \(S(z)\) a \(A^\top S(Az)\).

Usamos os 24 circulantes invertíveis e suas composições com a reflexão. A enumeração dos 288 suportes é fechada por essas 48 ações. A bentness, a simetria de rotação e o limite de grau quatro são preservados pelos levantamentos. Basta excluir um representante de cada órbita. Nos 20 suportes restantes, duas órbitas, com dois suportes cada, caem no grau quatro. As outras cinco órbitas, de tamanhos \(2,2,2,2,8\), caem com um coeficiente de grau cinco.

## Os certificados

Cada linha abaixo dá uma identidade \(c_i+c_j=1\) ou \(c_i+c_j+c_k=1\). Os números da coluna de sinais são máscaras de seis bits. Escrevemos \(C_b\) para a paridade da coluna \(b\) e \(L_z\) para a paridade da linha \(z\). Para verificar uma identidade, some as equações listadas e reduza os sinais pela recorrência de rotação. O resultado é a expressão dos coeficientes listados obtida pela fórmula de translação.

As tabelas de \(\psi\) estão em ordem \(v=1,\ldots,6\), com \(a=0,\ldots,7\) da esquerda para a direita. Em \(v=0\) ela vale zero e em \(v=7\) vale 7. A coluna \(p_D\) dá os valores em \(a=0,\ldots,7\). O suporte é unitário em \(D\), com frequência \((p_D(a),p_D(a))\). Fora de \(D\) ele é o conjunto das \(\beta\) com \(\beta_0+\beta_3,\beta_1+\beta_4,\beta_2+\beta_5\) iguais a \(\psi\) e com \(\beta\cdot z=0\).

| Tamanho da órbita | \(p_D\) | Tabelas de \(\psi\) | Máscaras dos coeficientes | Equações de sinais |
| ---: | --- | --- | --- | --- |
| 2 | 72431560 | 33333333 / 66666666 / 42242442 / 55555555 / 12212112 / 14414114 | 23, 30 | \(C_{11},C_{31},L_3,L_{15}\) |
| 2 | 74132560 | 33333333 / 66666666 / 41141441 / 55555555 / 42242442 / 12212112 | 23, 30 | \(C_{13},C_{31},L_3,L_{23}\) |
| 2 | 72431560 | 11111111 / 22222222 / 53353553 / 44444444 / 56656556 / 36636336 | 31, 30, 58 | \(C_1,C_3,C_{11},C_{23},L_5\) |
| 2 | 72431560 | 33333333 / 66666666 / 24424224 / 55555555 / 21121221 / 41141441 | 47, 29, 57 | \(C_3,C_5,C_{11},C_{31}\) |
| 2 | 74132560 | 11111111 / 22222222 / 36636336 / 44444444 / 35535335 / 65565665 | 47, 53, 60 | \(C_1,C_3,C_{13},C_{23},L_3\) |
| 2 | 74132560 | 33333333 / 66666666 / 14414114 / 55555555 / 24424224 / 21121221 | 47, 29, 57 | \(C_1,C_3,C_5,C_{11},L_5\) |
| 8 | 76543210 | 11551155 / 22223333 / 33332222 / 46464646 / 55115511 / 64646464 | 31, 23, 30 | \(C_1,C_3,C_5,C_{11}\) |

Por exemplo, na última linha, as colunas \(1,3,5,11\) contêm respectivamente as linhas \((8,30,44,58)\), \((3,24,47,52)\), \((5,26,40,55)\) e \((16,25,39,46)\). Reduzindo cada par \((z,\beta)\) ao menor de sua órbita, a soma das quatro paridades dá uma fase constante 1 mais os seguintes 16 sinais:

$$
\begin{gathered}
(1,8),(1,44),(3,3),(3,24),(5,5),(5,40),(11,16),(11,25),\\
(13,34),(13,48),(15,22),(15,32),(23,8),(23,37),(31,6),(31,20).
\end{gathered}
$$

A soma das quatro paridades deve ser zero. Já a expansão de \(c_{31}+c_{23}+c_{30}\) dá esses mesmos sinais com fase zero, logo é 1.

Reprodução no diretório do verificador original:

~~~text
python antipodal_residual_certificates.py audit-congruences.json
python antipodal_residual_certificates.py audit-walsh.json --direct
~~~

As duas execuções produzem o mesmo relatório de referência em antipodal-residual-certificates.json.

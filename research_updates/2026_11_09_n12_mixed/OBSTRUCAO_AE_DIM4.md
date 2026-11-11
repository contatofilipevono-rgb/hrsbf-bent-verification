# Obstrução por produto de coordenadas para A diferente de E

Em dimensão quatro, cada fibra de $\pi$ tem 16 pontos. O critério de momentos implica que o indicador de toda fibra tem grau no máximo cinco. Consequentemente, $\deg(\pi_i\pi_j)\le5$, pois esse produto é a soma dos indicadores com as duas coordenadas do rótulo iguais a um.

Escreva

$$
\pi(z,s_1,s_2)=g(z)+s_1q_1(z)+s_2q_2(z).
$$

O coeficiente de $s_1s_2$ em $\pi_i\pi_j$ é a coordenada $i,j$ de $q_1\wedge q_2$. Logo cada coordenada de $q_1\wedge q_2$ tem grau no máximo três em $z$.

Se $V=\ker r\cap\ker s$, a meia-volta dá $r(z)q_1(z)+s(z)q_2(z)=0$. Assim a cunha se anula fora de $z\in V$. Na fatia $z\in V$, escreva $A=q_1|_V$ e $E=q_2|_V$. Nas coordenadas independentes $z=(x,r,s)$, a igualdade exata é

$$
q_1(z)\wedge q_2(z)=(1+r)(1+s)\,A(x)\wedge E(x).
$$

O grau da extensão de uma coordenada não nula é dois mais o seu grau em $x$. Logo $\deg_x(A\wedge E)\le1$.

O verificador dim4_wedge_obstruction.py reconstrói o espaço de dimensão oito de $(q_1,q_2)$ a partir do modelo RS. A projeção a $(A,E)$ dá somente 8 pares em V1 e 16 em V2. Em ambos, cada par desigual tem uma coordenada quadrática não nula na cunha.

| Espaço | Pares iguais | Pares desiguais com cunha de grau dois | Classes mistas excluídas |
|---|---:|---:|---:|
| V1 | 1 | 7 | 224 de 256 |
| V2 | 4 | 12 | 192 de 256 |

Portanto $A=E$ em toda função bent de cada bloco. A redução usa uma comparação finita sobre os pares $(A,E)$. Ela independe da enumeração de $g$, dos mapas balanceados e das fases. Pelo corolário da nota do Fable, $A=E$ dá polar de posto no máximo dois em todo $z$, para qualquer coeficiente no complemento.

[Forma normal e redução anterior do Fable](https://github.com/contatofilipevono-rgb/n1-sat-cubos/blob/1488a48/bloco_dim4_n12/PROVA_POLAR_DIM4.md)

O próximo problema do Fable passa a ser a seleção dos $M$ dentro de $A=E$, em especial a explicação de como as equações lineares de fase excluem as classes que têm suportes auto-ortogonais. A verificação dos pares pode futuramente ser substituída por um argumento simbólico direto nas matrizes afins.

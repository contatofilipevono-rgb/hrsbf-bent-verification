# Grau em w das quárticas RS bent em 12 variáveis

Use (a,b)=(z+w,w), com z,w em F₂⁶. Os 43 coeficientes quárticos t_j são indexados a partir de zero pela menor máscara de cada órbita.

Em z=0, a meia-volta cancela os suportes trocados. Os suportes fixos são uniões de pares antipodais e viram monômios de grau até dois em w. Logo só precisamos tratar os termos z_i w_j w_k w_l. Se i pertence a {j,k,l}, os suportes originais que contribuem têm um par antipodal e dois índices simples. A meia-volta os emparelha e o coeficiente zera.

Se os quatro índices são distintos e formam S, o coeficiente é a soma sobre uma escolha por par de suportes trocados pela meia-volta. Escolher z_i exige que o índice em i esteja na metade baixa. Assim a soma independe de i em S.

A rotação reduz os conjuntos S a três tipos, segundo a distância cíclica entre os dois índices ausentes. Se a distância é três, a rotação por três preserva S e age sem pontos fixos nas classes de suportes módulo meia-volta. Se fixasse uma classe, levaria um suporte ao próprio suporte ou ao seu par pela meia-volta. Aplicada duas vezes, fixaria o suporte. Mas essa segunda aplicação é a meia-volta, que troca os quatro índices simples. Assim o coeficiente do terceiro tipo zera.

Para as distâncias um e dois, tome os complementos das máscaras 3 e 5 em seis bits. As duas somas restantes são

\[
A=t_0+t_4+t_7+t_9+t_{22}+t_{27}+t_{29}+t_{37},
\qquad B=t_1+t_3+t_5+t_8+t_{24}+t_{28}+t_{34}+t_{36}.
\]

Seja \(P_s\) a soma de \(t_{[U]}t_{[U']}\) sobre as partições não ordenadas do complemento da máscara s em dois suportes quárticos U,U'. O peso na fatia coordenada de dimensão oito com as posições de s fixadas em zero é múltiplo de quatro por Poisson. Na expansão inteira do XOR módulo quatro, só os pares de quárticos disjuntos podem contribuir, com fator dois. Logo \(P_s=0\) para toda bent de grau até quatro.

As identidades no anel booleano são

\[
\begin{aligned}
P_{585}&=t_{30}+t_{40}+t_{42},\\
A+B&=P_{195}+P_{325}+(1+t_{42})P_{585},\\
B&=P_{325}+\sum_{(s,j)\in T}t_jP_s.
\end{aligned}
\]

A lista T é

~~~text
(23,1), (29,3), (43,5), (53,8), (71,10), (77,12), (83,13),
(89,15), (101,17), (113,19), (139,21), (149,24), (163,26),
(169,28), (197,31), (209,33), (275,34), (281,36), (293,38),
(325,40), (329,41).
~~~

A comparação de monômios foi refeita com os polinômios de top_filters.py, incluindo os três representantes de S e todas as escolhas de i em S. As identidades dão A=B=0. Isso elimina toda a parte cúbica em w sem uma conferência nas 68 direções do modelo.

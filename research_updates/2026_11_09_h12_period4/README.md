# O caso de doze variáveis da conjectura para bent homogêneas com simetria de rotação

**Teorema.** Toda função booleana bent, homogênea e invariante pela rotação cíclica das doze coordenadas tem grau 2.

Usamos a transformada de Walsh não normalizada
$W_f(u)=\sum_x(-1)^{f(x)+u\cdot x}$. Escrevemos $\mathbf 0_s$ e $\mathbf 1_s$ para os vetores de zeros e de uns de comprimento $s$.

## Uma frequência resolve os graus ímpares

Seja $f$ invariante pela rotação cíclica e seja $g(y)=f(y,y,y)$, com $y\in\mathbb F_2^4$. Na soma de $W_f(u,u,u)$, a rotação de quatro posições conserva o somando. Suas órbitas têm comprimento 1 ou 3. Os pontos fixos são os vetores $(y,y,y)$, nos quais $(u,u,u)\cdot(y,y,y)=u\cdot y$ em $\mathbb F_2$. Logo, para todo $u$,
$$
W_f(u,u,u)\equiv W_g(u)\pmod 3.
$$
Se $f$ é bent, o lado esquerdo vale $\pm64$ e é sempre não nulo módulo 3.

Se $f$ é homogênea de grau ímpar, a meia-volta pareia todos os suportes dos monômios da ANF. Um suporte fixo pela meia-volta seria união de pares antipodais e teria cardinalidade par. Em cada ponto fixo pela meia-volta, os dois monômios de cada par têm o mesmo valor e se cancelam. Portanto $f=0$ nesses pontos. Em particular $g=0$ nos quatro pontos da diagonal $E=\{(a,b,a,b):a,b\in\mathbb F_2\}$.

Use máscaras binárias com o bit 0 na coordenada 0. As órbitas da rotação em quatro variáveis têm representantes $0,1,3,5,7,15$. Na frequência $u=3$, correspondente a $e_0+e_1$, as somas de $(-1)^{u\cdot y}$ nessas órbitas são, respectivamente,
$$
1,\quad 0,\quad 0,\quad -2,\quad 0,\quad 1 .
$$
As órbitas de representantes $0,5,15$ formam $E$. Como $g$ vale zero nas três e é constante em cada órbita, $W_g(3)=1-2+1=0$. Isso contradiz a congruência módulo 3 e exclui, em particular, os graus 3 e 5.

## Os graus pares

- Grau 4. O resultado H12 de Vono exclui funções homogêneas quárticas bent com simetria de rotação. A exclusão foi verificada pelo núcleo de Lean a partir dos certificados do H12. [Preprint H12, versão 2](https://doi.org/10.6084/m9.figshare.34737294.v2) · [Fontes formais preservadas](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/tree/9be0d98/research_updates/2026_10_20_final_integration) · [Verificação em GitHub Actions](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/39520500414)
- Grau 6. O teorema de Xia, Seberry, Pieprzyk e Charnes exclui qualquer bent homogênea de grau $r$ em $2r$ variáveis para $r>3$. [Artigo de Xia et al.](https://doi.org/10.1016/j.dam.2004.02.006)
- Graus maiores que 6 são excluídos pelo limite de grau de Rothaus. Funções afins têm espectro concentrado numa frequência, logo também ficam excluídas. [Artigo de Rothaus](https://doi.org/10.1016/0097-3165(76)90024-8)

O grau 2 é realizado pela quadrática antipodal $q(a,b)=\sum_{i=0}^5 a_i b_i$, onde $a,b$ são as duas metades de seis coordenadas. Ela é invariante por rotação e $W_q(v,w)=64(-1)^{v\cdot w}$.

## Relação de sinais observada nas amostras

Para qualquer bent com simetria de rotação em doze variáveis, inclusive não homogênea, vale
$$
\operatorname{sgn}\bigl(W_f(\mathbf 0_{12})W_f(\mathbf 1_{12})\bigr)
=(-1)^{f(\mathbf 0_{12})+f(\mathbf 1_{12})}.
$$
De fato, ponha $s_j=(-1)^{g(j)}$ para os seis representantes. As somas de Walsh em $0$ e $15$ são $U+V$ e $U-V$, onde $U=s_0+s_{15}+4s_3+2s_5$ e $V=4(s_1+s_7)$. Como ambas são não nulas em $\mathbb F_3$, exatamente um de $U,V$ é zero nesse corpo.

Se $s_0=s_{15}$, a condição $W_g(3)=s_0+s_{15}-2s_5\not\equiv0\pmod3$ força $s_5=-s_0$. Daí $U\equiv s_3\ne0$ e $V=0$ em $\mathbb F_3$. Se $s_0=-s_{15}$, a soma $W_g(5)=s_0+s_{15}-4s_3+2s_5$ é não nula módulo 3, logo $s_3=s_5$ e $U=0$ em $\mathbb F_3$. Os resíduos de $W_f(\mathbf 0_{12})$ e $W_f(\mathbf 1_{12})$ são, assim, iguais no primeiro caso e opostos no segundo. Como $64\equiv1\pmod3$ e $g$ tem os mesmos valores de $f$ nos extremos, segue a relação.

## Reprodução

Execute `python verifica_n12_periodo4.py` com Python 3.10 ou posterior. O verificador calcula as seis linhas de Walsh pelas órbitas, testa as 64 tabelas invariantes em quatro variáveis, confere as órbitas da rotação de quatro posições em doze variáveis e usa a quadrática antipodal como controle positivo. A prova dos graus ímpares acima é algébrica. O verificador cobre as identidades finitas e preserva separadamente as referências aos resultados dos graus pares.

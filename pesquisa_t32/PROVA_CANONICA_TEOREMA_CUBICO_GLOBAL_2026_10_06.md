# Prova canônica — inexistência global de HRSBF cúbicas bent

Data: 2026-10-06.

## Status

Esta é a versão canônica curta da prova candidata após as auditorias adversariais independentes. Ela foi escrita para isolar o argumento matemático essencial, sem depender de enumeração, GPU, SAT, certificados ou resultados computacionais em dimensões particulares.

Não se faz aqui alegação de prioridade bibliográfica. O resultado matemático demonstrado é exclusivamente para funções booleanas **homogêneas de grau 3**, rotation-symmetric e bent.

## Teorema principal

**Teorema.** Para todo inteiro par positivo (n), não existe função booleana
[
f:mathbb F_2^n	omathbb F_2
]
que seja simultaneamente

1. bent;
2. rotation-symmetric;
3. homogênea de grau (3).

A prova será obtida combinando três lemas.

---

## 1. Redução por automorfismo de ordem ímpar

### Lema 1

Seja (V) um espaço vetorial finito sobre (mathbb F_2), seja (Tin GL(V)) de ordem ímpar (m), e ponha
[
U=operatorname{Fix}(T).
]
Se (q:V	omathbb F_2) tem grau no máximo (2) e é (T)-invariante, então
[
q	ext{ é balanceada em }V
iff
q|_U	ext{ é balanceada em }U.
]

### Prova

Somar a constante (q(0)) não altera balanceamento, portanto suponha (q(0)=0). Seja
[
B(x,y)=q(x+y)+q(x)+q(y)
]
a polar alternada de (q).

Defina
[
P=I+T+cdots+T^{m-1}.
]
Como (m) é ímpar,
[
P^2=P,qquad operatorname{im}P=U,
]
e
[
V=Uoplus K,qquad K=ker P.
]

Para (uin U) e (kin K),
[
B(u,k)
=
sum_{j=0}^{m-1} B(u,T^jk)
=
B(u,Pk)
=
0.
]
Logo
[
q(u+k)=q(u)+q(k),
]
e a soma de caracteres fatora:
[
S_V(q)=S_U(q|_U),S_K(q|_K),
qquad
S_E(h)=sum_{xin E}(-1)^{h(x)}.
]

Resta mostrar
[
S_K(q|_K)
e0.
]

Seja
[
R=operatorname{rad}(B|_K).
]
O espaço (R) é (T)-invariante. Além disso, (q|_R) é linear, porque a polar se anula em (R).

Para (rin R), todos os vetores (T^jr) pertencem a (R), portanto as polarizações entre eles são zero. Assim
[
q(Pr)=sum_{j=0}^{m-1}q(T^jr).
]
Mas (rin K), logo (Pr=0); e (q) é (T)-invariante. Portanto
[
0=q(Pr)=m,q(r)=q(r),
]
pois (m) é ímpar. Logo (q) se anula em (R).

A identidade de caracteres quadráticos fornece
[
S_K(q|_K)^2
=
|K|sum_{rin R}(-1)^{q(r)}
=
|K|,|R|
>0.
]
Consequentemente (S_K(q|_K)
e0), e a fatoração mostra
[
S_V(q)=0iff S_U(q|_U)=0.
]
Isso prova o lema. (square)

### Corolário 1

Se (f:V	omathbb F_2) é bent, (T)-invariante, (deg fle3), e (dim U) é par, então
[
f|_U
]
é bent.

### Prova

Para todo (ain Usetminus{0}), a derivada
[
D_af(x)=f(x+a)+f(x)
]
tem grau no máximo (2), é balanceada porque (f) é bent, e é (T)-invariante porque (Ta=a).

Pelo Lema 1,
[
D_a(f|_U)=(D_af)|_U
]
é balanceada para todo (a
e0) em (U). Pela caracterização de bentness por derivadas, (f|_U) é bent. (square)

---

## 2. Folding de uma órbita cúbica

Escreva
[
n=tm,qquad t=2^s,quad sge1,quad m	ext{ ímpar},
]
e tome
[
T=sigma^t.
]
Então (T) tem ordem (m), e seu fixed space é
[
U={x:x_{i+t}=x_i},
]
identificado com (mathbb F_2^t) por
[
x_i=y_{imod t}.
]

Defina a órbita quadrática antipodal em (t) variáveis por
[
Q_A(y)=sum_{i=0}^{t/2-1} y_i y_{i+t/2}.
]

### Lema 2

A restrição a (U) de qualquer função cúbica homogênea rotation-symmetric em (n=tm) variáveis tem grau no máximo (3), é rotation-symmetric em (t) variáveis e **não contém (Q_A)**.

### Prova

Considere uma órbita de um monômio cúbico com suporte de três elementos. O estabilizador desse suporte sob a rotação cíclica tem ordem
[
hin{1,3},
]
pois ele age livremente sobre um conjunto de três elementos.

Como (hmid n=tm) e (gcd(h,t)=1), temos (hmid m). O comprimento da órbita é
[
rac nh=trac mh,
]
e (m/h) é ímpar.

Após a identificação (x_i=y_{imod t}), a órbita original restringe-se, módulo (2), à soma das (t) translações cíclicas do monômio reduzido em (mathbb F_2^t), pois o fator (m/h) é ímpar.

O monômio reduzido pode ter grau (1), (2) ou (3).

- Se tem grau (3), sua órbita em (t=2^s) variáveis tem comprimento (t), pois um estabilizador não trivial teria ordem (3), impossível em uma potência de dois.
- Se tem grau (1), obtém-se a forma linear total
  [
  L(y)=sum_i y_i.
  ]
- Se tem grau (2), obtém-se a soma cíclica completa
  [
  sum_{i=0}^{t-1} y_i y_{i+r}.
  ]
  Para (r
e t/2), esta é uma órbita quadrática de comprimento completo (t).

No caso antipodal (r=t/2),
[
sum_{i=0}^{t-1} y_i y_{i+t/2}
=
2sum_{i=0}^{t/2-1} y_i y_{i+t/2}
=
0
]
em (mathbb F_2).

Equivalentemente, para uma órbita cúbica full-length original, cada monômio antipodal reduzido aparece (2m) vezes antes da redução módulo (2), portanto cancela. Uma órbita cúbica curta, de estabilizador (3), só pode ocorrer quando (3mid m); então os três índices diferem por múltiplos de (t) e colapsam para um único índice, produzindo apenas a forma linear.

Assim nenhuma órbita cúbica homogênea pode produzir (Q_A) após a restrição. (square)

---

## 3. Regra Antipodal

### Lema 3 — Regra Antipodal

Se
[
N=2^k,qquad kge1,
]
e
[
g:mathbb F_2^N	omathbb F_2
]
é rotation-symmetric, bent e satisfaz (deg gle3), então a ANF de (g) contém a órbita quadrática antipodal
[
Q_A(x)=sum_{i=0}^{N/2-1}x_i x_{i+N/2}.
]

### Prova

Escreva
[
N=2h,
qquad
d(u)=(u,u),
qquad
e(z)=(0,z),
]
com (u,zinmathbb F_2^h). Seja (alphainmathbb F_2) o coeficiente de (Q_A) na ANF de (g).

#### Passo 1 — diagonal

Na diagonal (d(u)),

- a órbita linear cancela entre as duas metades;
- toda órbita cúbica cancela aos pares pela meia-rotação;
- toda órbita quadrática não antipodal cancela aos pares;
- a órbita antipodal satisfaz
  [
  Q_A(d(u))=sum_{i=0}^{h-1}u_i.
  ]

Logo
[
g(d(u))=c+alphasum_i u_i
]
para alguma constante (c).

Suponha, por contradição, que
[
alpha=0.
]
Somando a constante (c) a (g), o que preserva bentness e rotation symmetry, podemos supor
[
g(d(u))=0
]
para todo (u).

#### Passo 2 — as fibras não diagonais são balanceadas

Defina
[
F_z(u)=g(d(u)+e(z))=g(u,u+z)
]
e
[
A_z=sum_{uinmathbb F_2^h}(-1)^{F_z(u)}.
]

A transformação linear
[
(u,z)mapsto(u,u+z)
]
é invertível, portanto
[
G(u,z)=g(u,u+z)
]
é bent.

A transformada de Walsh de (A_z) na variável (z) é
[
widehat A(v)=W_G(0,v),
]
de modo que
[
|widehat A(v)|=2^h
]
para todo (v).

Por Parseval,
[
sum_z A_z^2=2^N.
]
Como
[
F_0(u)=g(d(u))=0,
qquad
A_0=2^h,
]
já temos
[
A_0^2=2^N.
]
Logo
[
A_z=0
]
para todo (z
e0).

Em particular,
[
F_{mathbf1}(u)=g(u,u+mathbf1)
]
é balanceada.

#### Passo 3 — lema quadrático RS

Seja (q) uma função rotation-symmetric, balanceada, de grau no máximo (2), em (N=2^k) variáveis. Então a polar de (q) é zero.

De fato, normalize
[
Q=q+q(0),
]
e seja
[
B(x,y)=Q(x+y)+Q(x)+Q(y),
qquad
R=operatorname{rad}(B).
]

Se (B
e0), então (R) é um subespaço próprio e invariante pela rotação (S).

Identifique (mathbb F_2^N) com
[
mathbb F_2[X]/((X+1)^N),
]
onde (S) é multiplicação por (X). Todo vetor de peso ímpar representa um polinômio (p) com
[
p(1)=1,
]
logo uma unidade do anel. Portanto um submódulo próprio não pode conter vetor de peso ímpar. Assim
[
Rsubseteqoperatorname{im}(S+I),
]
o hiperplano dos vetores de peso par.

Para (rin R), escreva
[
r=(S+I)y=Sy+y.
]
Pela invariância de (Q),
[
Q(r)
=
Q(Sy)+Q(y)+B(Sy,y)
=
B(Sy,y).
]
Como (Sy=r+y), (B) é alternada e (rin R),
[
B(Sy,y)=B(r+y,y)=0.
]
Portanto
[
Q(r)=0
]
para todo (rin R).

A identidade de caracteres quadráticos dá
[
left(sum_x(-1)^{q(x)}ight)^2
=
2^Nsum_{rin R}(-1)^{Q(r)}
=
2^N|R|
>0,
]
contradizendo o balanceamento de (q).

Logo necessariamente
[
B=0.
]

#### Passo 4 — derivada de todos-uns

Seja
[
J=mathbf1^N=d(mathbf1).
]
Como (g) é bent,
[
D_Jg
]
é balanceada. Como (deg gle3), essa derivada tem grau no máximo (2), e continua rotation-symmetric.

Pelo Passo 3,
[
B_{D_Jg}=0.
]

Defina a terceira diferença
[
T(p,q,r)=D_pD_qD_rg(0).
]
Para (deg gle3), (T) é trilinear, simétrica e independente do ponto base.

Como (gcirc d=0), temos
[
B_{F_{mathbf1}}(u,v)
=
T(d(u),d(v),e(mathbf1)).
]

Por outro lado,
[
B_{D_Jg}(d(u),e(v))
=
T(d(u),e(v),J).
]

Escrevendo
[
J=(mathbf1,0)+(0,mathbf1)
]
e usando a invariância de (T) pela meia-rotação que troca as duas metades,
[
egin{aligned}
T(d(u),e(v),J)
&=
T(d(u),e(v),(mathbf1,0))
+
T(d(u),e(v),(0,mathbf1))
\
&=
T(d(u),(v,0),(0,mathbf1))
+
T(d(u),(0,v),(0,mathbf1))
\
&=
T(d(u),d(v),e(mathbf1)).
end{aligned}
]

Portanto
[
B_{F_{mathbf1}}(u,v)
=
B_{D_Jg}(d(u),e(v))
=
0.
]

Como (F_{mathbf1}) tem grau no máximo (2), segue que
[
F_{mathbf1}
]
é afim.

Esta formulação evita qualquer necessidade de calcular separadamente a constante produzida por órbitas quadráticas na fibra. Se essa expansão for feita explicitamente, a constante de uma órbita de distância (r) é ((h+r)mod2), não simplesmente (hmod2); em qualquer caso sua polar é zero.

#### Passo 5 — rotação torcida

Escolha a convenção
[
(sigma x)_i=x_{i-1pmod N}
]
e seja (R) a rotação análoga em (h) coordenadas.

Na fibra complementar,
[
sigma(u,u+mathbf1)
=
(Ru+e_0,;Ru+e_0+mathbf1).
]
Como (g) é rotation-symmetric,
[
F_{mathbf1}(Ru+e_0)=F_{mathbf1}(u).
]

Escreva
[
F_{mathbf1}(u)=L(u)+c_0.
]
Comparando as partes lineares,
[
Lcirc R=L.
]
Logo (L) é uma forma linear rotation-symmetric em (h) variáveis e, portanto,
[
L(u)=gammasum_i u_i.
]

Comparando os termos constantes na invariância torcida,
[
L(e_0)=0.
]
Assim
[
gamma=0,
]
e (F_{mathbf1}) é constante.

Isso contradiz o Passo 2, que mostrou que (F_{mathbf1}) é balanceada.

Logo a hipótese (alpha=0) é impossível, e portanto
[
alpha=1.
]
A órbita antipodal é necessária. (square)

**Observação sobre (k=1).** A demonstração acima continua válida para (N=2). Equivalentemente, pode-se observar diretamente que uma função RS bent em duas variáveis deve ter o termo quadrático (x_0x_1).

---

## 4. Prova do teorema global

Seja (n) par e escreva
[
n=2^s m,
qquad
sge1,
qquad
m	ext{ ímpar}.
]
Ponha
[
t=2^s
]
e
[
T=sigma^t.
]

Suponha, por contradição, que exista uma função
[
f:mathbb F_2^n	omathbb F_2
]
bent, rotation-symmetric e homogênea de grau (3).

O fixed space
[
U=operatorname{Fix}(T)
]
tem dimensão
[
t=2^s,
]
portanto dimensão par.

Pelo Corolário 1,
[
g=f|_U
]
é bent. Pela própria construção do fixed space, (g) é rotation-symmetric em (t) variáveis e
[
deg gle3.
]

Pelo Lema 2, o folding da homogeneidade cúbica original implica
[
Q_A
otsubseteq g.
]

Mas (t=2^s) com (sge1). Pelo Lema 3, toda função rotation-symmetric bent de grau no máximo (3) em (t) variáveis satisfaz
[
Q_Asubseteq g.
]

Contradição.

Portanto não existe função booleana bent, homogênea de grau (3) e rotation-symmetric em nenhuma dimensão par. (square)

---

## 5. Alcance

O argumento resolve somente o caso homogêneo de grau (3).

Ele **não** implica inexistência de funções rotation-symmetric bent cúbicas não homogêneas; tais funções existem e são compatíveis com a Regra Antipodal porque contêm o termo quadrático necessário.

Também não resolve, por si só, os graus homogêneos (4,5,ldots).

Os cálculos e certificados em (n=16) e (n=32) permanecem úteis como controles independentes, mas não são necessários para a demonstração acima.

## 6. Pendência editorial

Antes de promover este resultado como novidade ou resolução inédita do caso cúbico na literatura, deve-se concluir uma revisão bibliográfica primária, em particular confrontando o enunciado com Meng–Chen–Fu, Zhang–Gao, Cusick–Sanger, Gao–Zhang–Liu–Carlet e Sun–Shi–Liu–Fu (2026).

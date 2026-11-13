# O ramo de duas meias-fatias da classe 129 em V1

Escreva (z=(y,y+d)), com (y,d\in\mathbb F_2^3), e
(\rho=\pi_0\bmod\langle1111\rangle). No espaço afim (A_2), o
mapa (\rho) é constante em cada plano
(C_{d,p}=\{(y,y+d):\operatorname{par}(y)=p\}).
Quando (\rho=1), o primeiro bit de (\pi_0) seleciona o rótulo
1. Denote esse bit por (b_0).

## Lema de seleção

Se (C) é um espaço afim binário e (b_0) um seletor, a soma de (h)
onde (b_0=c) é o coeficiente de grau máximo da ANF restrita de
((1+b_0+c)h). Em dimensão 2, se (b_0) é afim e seleciona dois
pontos, a soma para (h) afim é (D_v h), onde (v) é a direção
do núcleo da parte linear do seletor. Em dimensão 3, se (b_0) é
quadrático balanceado e sua polar tem posto 2, o momento de um
coeficiente afim (h) é a parte linear de (h) aplicada à direção
radical. De fato, o balanceamento exige que a derivada do seletor
nessa direção seja 1. A seleção escolhe um ponto por par radical,
e a extração do coeficiente cúbico em coordenadas adaptadas dá a
parte linear de (h) nessa direção. A mesma fórmula vale para
(b_0+h) porque a contribuição de (b_0) é (4c=0).

## Aplicação à fibra 1

Supomos (Z_1) com dois pontos em cada uma das fatias (d=3,5),
sem outros pontos. Nas duas fatias, (a=b=Q_{11}=0).
A fibra é (Z_1\times\mathbb F_2^2), e o momento em (s_2)
exige (\sum_{Z_1}H_{10}=0).

O seletor é afim em cada (C_{d,p}), como se verifica no ponto
base e nas 14 direções de (A_2). Portanto, os dois pontos de uma
fatia provêm de um único plano. Para cada escolha dos dois planos
e das duas partes lineares não nulas do seletor, as condições
(\rho=1) e as partes lineares prescritas são equações lineares
nos parâmetros do mapa.

Das 36 escolhas, quatro são consistentes e cada uma define um espaço
afim de dimensão 9. As paridades dos dois planos coincidem.
Em cada paridade (p=0,1), as direções dos pares selecionados em
coordenadas de (y) são ((5,3)) ou ((6,6)), na ordem (d=3,5).
Os números são máscaras binárias de três bits.

Em cada um dos quatro espaços, (H_{10}) é afim nos dois planos.
A soma

$$
 D_{(v_3,v_3)}H_{10}|_{C_{3,p}}+
 D_{(v_5,v_5)}H_{10}|_{C_{5,p}}
$$

vale 1 no levantamento de referência e 0 nas direções de fase.
Para o levantamento, basta verificar o valor em um ponto base
e o anulamento nas nove direções de cada espaço. Para as fases,
basta verificar as 19 direções do modelo. As derivadas não dependem
do ponto em que são calculadas dentro dos respectivos planos.
Isso contradiz o momento em (s_2).

A prova local usa apenas sistemas lineares e testes nas bases.
Ela se aplica a qualquer código de (A_2) com o perfil indicado,
inclusive sem as demais condições de suporte. A implicação das
condições globais de suporte e dos três primeiros momentos para
a entrada em (A_2) é uma questão separada.

## Reprodução

`audit_v1_class129_affine_branches.py` verifica os coeficientes antes
da checagem de catálogo. A checagem posterior reproduz os 192 casos
admissíveis com o perfil e serve de controle independente.

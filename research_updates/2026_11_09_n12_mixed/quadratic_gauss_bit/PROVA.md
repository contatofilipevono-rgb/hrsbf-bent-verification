# Segundo bit das somas de Gauss: grau dois nos parâmetros

Data: 14/11/2026. Derivação do Codex, ainda sem auditoria externa. A missão
enviada ao usuário para o Carbon solicita uma demonstração independente.

## Enunciado

Seja V de dimensão 2k, k >= 1, sobre F2. Fixe uma função quadrática q com
q(0)=0, polar B, e funções lambda(theta) em V* e h(theta) em F2, ambas afins
nos parâmetros theta. Ponha

    K(theta) = sum_{v in V} (-1)^{q(v)+lambda(theta)(v)+h(theta)},
    kappa(theta) = K(theta)/2^k.

Existe p em {0,1}, independente de theta, e uma função Q de grau <= 2 tal que

    kappa(theta) = p + 2 Q(theta) (mod 4).

Aqui p=1 se, e somente se, B é não degenerada. Em particular kappa é inteiro.
Para qualquer soma de tais kappa, com polares fixas, o segundo bit tem grau
<=2 nos parâmetros comuns. O primeiro bit é constante. O enunciado não exige
rotação, grau quatro em outras variáveis ou bentness.

## Prova por posto

Se r=rank(B), a soma é zero ou tem módulo 2^(2k-r/2). Isso segue somando
primeiro no radical R: o somatório se anula a menos que lambda|R=q|R; no caso
ativo resta uma soma quadrática não degenerada no quociente V/R.
Portanto K é divisível por 2^k.

Para conferir o módulo dessa soma sem enumeração, escolha uma base simplética
no quociente. A quadrática vira sum_j (x_j y_j+a_j x_j+b_j y_j). Cada par
contribui sum_{x,y} (-1)^{xy+a_j x+b_j y}=2(-1)^{a_j b_j}. Isso dá módulo
2^(r/2) no quociente e o fator adicional 2^(2k-r) do radical no caso ativo.

**Posto 2k.** Para cada lambda há um único t com B(t,v)=lambda(v) para todo v.
Pela translação v -> v+t,

    sum_v (-1)^{q(v)+lambda(v)} = (-1)^{q(t)} sum_v (-1)^{q(v)}.

Escreva sum_v (-1)^{q(v)} = (-1)^a 2^k, com a fixo. Então

    kappa = (-1)^{a+h+q(t)} = 1 + 2(a+h+q(t)) (mod 4).

O vetor t depende afimmente de theta, logo Q=a+h+q(t) tem grau <=2.

**Posto 2k-2.** O radical tem base r1,r2. A soma é ativa exatamente quando
lambda(rj)=q(rj) para j=1,2. Seu indicador é

    Q = (1+lambda(r1)+q(r1)) (1+lambda(r2)+q(r2)).

No caso ativo kappa vale +2 ou -2, que são iguais módulo quatro. Fora dele é
zero. Assim kappa=2Q (mod 4), e Q é produto de duas funções afins.

**Posto <=2k-4.** No caso ativo kappa é múltiplo de quatro; no caso inativo é
zero. Podemos tomar p=Q=0. Estes são todos os postos possíveis. Fim da prova.

## Soma e transporte binário

Para os índices z presentes no momento, sejam p_z e Q_z como acima e N=sum_z p_z
(uma contagem inteira fixa). Então

    M(theta) = N + 2 sum_z Q_z(theta) (mod 4).

O primeiro bit é N mod 2. O segundo bit, definido por floor((M mod 4)/2), é

    b(theta) = floor(N/2) mod 2 + sum_z Q_z(theta)  em F2.

Isso inclui somas negativas: a congruência determina o resíduo em {0,1,2,3}.
Se a condição de primeiro bit exige N par, a exigência M=0 (mod 4) equivale a
b=0. O transporte é a constante floor(N/2) mod 2; ele não é descartado.
Não é necessário supor N par para a conclusão de grau do segundo bit.

## Coeficientes sem interpolação

No posto pleno, escreva t=t0+sum_i theta_i Ti e h=h0+sum_i hi theta_i.
Usando B como polar de q, os coeficientes de Q são

    constante: a+h0+q(t0),
    theta_i:   hi+q(Ti)+B(t0,Ti),
    theta_i theta_j, i<j: B(Ti,Tj).

No posto 2k-2, escreva os dois fatores afins como a1+sum_i b1i theta_i e
a2+sum_i b2i theta_i. Os coeficientes de seu produto booleano são

    constante: a1 a2,
    theta_i:   a1 b2i+a2 b1i+b1i b2i,
    theta_i theta_j, i<j: b1i b2j+b1j b2i.

O termo b1i b2i é obrigatório, porque theta_i^2=theta_i. Some esses
coeficientes para todos os z e acrescente o transporte à constante.

## Aplicação exata ao teste de n=12

Fixe cada polar B_z e um 4-flat w0+V. A translação de q_z para V produz uma
quadrática fixa q em V; a constante e a parte linear absorvem q_z(w0),
B_z(w0,.) e o caráter omega. Elas continuam afins nos 43 parâmetros da parte
de f afim em w. Portanto a prova se aplica a cada kappa_z=K_z/4 e aos momentos
com |I|<=1 usados em bitj.py. Qualquer restrição afim dos parâmetros preserva
o grau <=2.

Uma função booleana de grau <=2 é determinada por seu valor em 0, nos ei e
nos ei+ej: o coeficiente linear é b(ei)+b(0), e o quadrático é
b(ei+ej)+b(ei)+b(ej)+b(0). Isso justifica a interpolação exata. Testes
aleatórios posteriores não substituem a prova de grau, que está acima.

Esta conclusão valida a construção das equações quadráticas necessárias.
Não prova que elas sejam suficientes para bentness, nem que a enumeração de
seus zeros seja algébrica. A execução ampla ainda contém testes de Walsh.

## Conferência independente

Execute `python verifica.py`. O programa constrói as previsões pelas fórmulas
de posto e radical e compara com somas inteiras diretas: todas as 64 polares
em dimensão quatro, suas 32 escolhas de parte afim, todos os 4.096 pares de
polares e 64 substituições afins em seis parâmetros. Também confere formas
canônicas em dimensões 2, 6 e 8, em todos os postos pares. Não importa código
do modelo de pesquisa. A saída fica em resultado.json.

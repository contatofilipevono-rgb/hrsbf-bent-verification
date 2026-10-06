# Regra antipodal para funções RS bent de grau <= 3

**Status:** prova algébrica candidata, auditada estruturalmente em 2026-10-06. Não fazer alegação de prioridade sem comparação bibliográfica final.

## Teorema

Se n=2^k com k>=2 e f:F_2^n->F_2 é rotation-symmetric, bent e deg(f)<=3, então a ANF de f contém a órbita quadrática antipodal
Q_A(x)=sum_{i=0}^{n/2-1} x_i x_{i+n/2}.
Em particular, nenhuma função homogênea cúbica RS em n=2^k variáveis é bent.

## Prova

Ponha n=2h e d(u)=(u,u), e(z)=(0,z), u,z in F_2^h. Seja alpha o coeficiente de Q_A.

### 1. Diagonal

Sob x=d(u), a órbita linear cancela. Toda órbita cúbica cancela ao emparelhar cada monômio com sua meia-rotação; um conjunto de 3 índices não pode ser fixado pela involução sem pontos fixos. Toda órbita quadrática não antipodal também cancela em pares. Já
Q_A(d(u))=sum_i u_i.
Logo f(d(u))=c+alpha sum_i u_i.

Suponha alpha=0. Somando a constante c a f, o que preserva bentness, podemos assumir F_0(u)=f(d(u))=0.

### 2. As outras fibras devem ser balanceadas

Defina F_z(u)=f(d(u)+e(z)). Para A_z=sum_u (-1)^{F_z(u)}, a transformada de Walsh na variável z e Parseval dão
sum_z A_z^2=2^n
quando f é bent. Como A_0=2^h e A_0^2=2^n, segue A_z=0 para todo z!=0. Em particular, F_1 é balanceada.

### 3. Lema quadrático RS em potência de dois

Se q é RS, deg(q)<=2, n=2^k, e q é balanceada, então a polar de q é zero.

De fato, após remover q(0), seja Q=q+q(0), B sua polar e R=rad(B). Se B!=0, R é subespaço próprio e invariante pela rotação S. Identificando F_2^n com F_2[X]/((X+1)^n), todo vetor de peso ímpar é uma unidade; portanto um submódulo próprio R não contém vetor de peso ímpar e R está contido em im(S+I). Para r=(S+I)y em R,
Q(r)=Q(Sy)+Q(y)+B(Sy,y)=B(Sy,y)=B(r+y,y)=0.
A identidade de caracteres quadráticos fornece
( sum_x (-1)^{q(x)} )^2 = 2^n sum_{r in R} (-1)^{Q(r)} = 2^n |R| >0,
contradizendo balanceamento. Logo B=0.

### 4. A derivada de todos-uns

Seja J=1^n=d(1^h). Como f é bent, D_J f é balanceada; como deg(f)<=3, D_J f tem grau <=2 e continua RS. Pelo lema,
B_{D_J f}=0.

A polar de D_J f depende somente da parte cúbica de f. Se T é a terceira diferença da parte cúbica, a mesma identidade de meia-rotação usada na prova homogênea dá
B_{F_1}^{(3)}(u,v)
=T(d(u),d(v),e(1))
=B_{D_J f}(d(u),e(v))=0.

### 5. Termos de grau <=2 na fibra complementar

A órbita linear RS é beta sum_i x_i; em x=(u,u+1), ela é a constante beta*h, portanto tem polar zero.

Para uma órbita quadrática não antipodal de distância r<h, emparelhe o termo de índice i com o de i+h. Como x_{j+h}=x_j+1 na fibra z=1,
x_i x_{i+r}+x_{i+h}x_{i+r+h}
=x_i x_{i+r}+(x_i+1)(x_{i+r}+1)
=x_i+x_{i+r}+1.
Somando i=0,...,h-1, as partes lineares aparecem duas vezes e cancelam; resta a constante h mod 2=0 porque k>=2 implica h par. A órbita antipodal foi excluída pela hipótese alpha=0. Logo a parte de grau <=2 de f também tem polar zero em F_1.

Assim B_{F_1}=0. Como deg(F_1)<=2, F_1 é afim.

### 6. Rotação torcida

A rotação de x=(u,u+1) induz u -> R_h u+e_0. Portanto F_1(R_hu+e_0)=F_1(u). Escreva F_1=L+c. A igualdade das partes lineares força L a ser uma forma linear RS em h variáveis, então L=gamma sum_i u_i. A igualdade dos termos constantes força L(e_0)=gamma=0. Logo F_1 é constante.

Isso contradiz o balanceamento de F_1 obtido no passo 2. Portanto alpha=1.

## Observações

1. A prova NÃO usa a falsa afirmação de que uma função bent não pode ser constante num flat de dimensão n/2.
2. A condição antipodal é necessária, não suficiente.
3. O corolário homogêneo cúbico segue imediatamente, pois uma função homogênea de grau 3 não contém Q_A.
4. A busca bibliográfica encontrou resultado relacionado de Cusick--Sanger para somas de short-cycle RS bent; a relação exata de prioridade/escopo deve ser explicitada antes de publicação externa.

# Redução ao período quatro em n=4p: demonstração e limites

Data: 16/10/2026. Adendo separado do preprint corrigido.
Status: demonstração matemática apresentada abaixo, acompanhada de verificações
finitas independentes. Não formalizada em Lean. Prioridade bibliográfica não
estabelecida. Este resultado não prova inexistência quártica em n=4p.

## 1. Lema de restrição, sem hipótese de grau

Se p>=5 é primo e f:F2^(4p)->F2 é bent e invariante pela rotação de uma
coordenada, então h(y)=f(y,y,...,y), com p cópias do bloco y de quatro bits,
é bent em quatro variáveis.

**Prova.** Seja T a rotação por quatro coordenadas. A ordem de T é p.
Seus pontos fixos são exatamente as repetições de blocos de quatro bits.
Para cada b em F2^4, tome a repetição a=(b,...,b) em F2^(4p).
O somando (-1)^(f(x)+<a,x>) é constante nas órbitas de T: f é invariante
e a é fixo por T. Cada órbita não fixa tem p elementos. Logo,

    W_f(a) = W_h(b) (mod p).

Nos pontos fixos x=(y,...,y), o produto escalar é
<a,x>=p<b,y>=<b,y> em F2, justificando o termo W_h(b).

Bentness e Fermat dão W_f(a)=±2^(2p)=±4 (mod p).
Cada W_h(b) é par. Nenhum dos inteiros 0,2,-2 é congruente a 4 ou -4
módulo um primo p>=5: isso exigiria que p dividisse 2,4 ou 6.
Portanto |W_h(b)|>=4 para os dezesseis vetores b. Parseval em quatro
variáveis fornece

    sum_b W_h(b)^2 = 16^2 = 256 = 16*4^2.

Todas as dezesseis desigualdades são igualdades. Assim |W_h(b)|=4
para todo b, que é a definição de bentness de h. Fim da prova.

Esta prova usa simultaneamente a congruência e Parseval. Não descarta
valores apenas porque parecem ter resíduos com sinais diferentes.
O caso p=3 não está coberto: ±2 e ±4 têm os mesmos resíduos módulo 3.

## 2. Classificação elementar da base em quatro variáveis

Uma função RS em quatro variáveis, com constante zero e grau <=4, tem ANF

    h = aL + bC + cP + dT + eM,

onde as operações são em F2 e

    L = y0+y1+y2+y3,
    C = y0*y1+y1*y2+y2*y3+y3*y0,
    P = y0*y2+y1*y3,
    T = y0*y1*y2+y0*y1*y3+y0*y2*y3+y1*y2*y3,
    M = y0*y1*y2*y3.

As bent em quatro variáveis têm grau no máximo dois. Alternativamente,
o arquivo folding_prime_certificate.py verifica diretamente as 32 tabelas
de verdade possíveis, com todos os dezesseis coeficientes de Walsh:

    h bent <=> c=1, d=0, e=0; a,b arbitrários.

Para a suficiência, a matriz polar de bC+P é não singular para b=0 e b=1;
adicionar aL não muda a bentness. A verificação das 32 tabelas também torna
esse passo independente de uma referência externa ao limite do grau.

## 3. Aplicação à base quártica homogênea RS em 4p variáveis

Seja O uma órbita de suportes quárticos distintos, e c_O seu coeficiente.
Seu tamanho é 4p, 2p ou p: o estabilizador divide o tamanho quatro do
suporte e a ordem 4p do grupo, logo tem tamanho 1,2 ou 4.

Há p órbitas bi-antipodais de tamanho 2p ou p, representadas por
(0,d,2p,2p+d), 1<=d<=p. Denote seus coeficientes por c_d.
Para d=p, o suporte é (0,p,2p,3p), e a órbita tem tamanho p.
Para d<p, o tamanho é 2p.

Defina a forma linear

    tau(f) = XOR c_O,

onde O percorre as órbitas de tamanho 4p cujos suportes ocupam exatamente
três classes de resíduos módulo quatro. Essa propriedade é constante na
órbita, pois a rotação apenas translada os resíduos.

A restrição ao período quatro tem coeficientes

    [M]h = c_p,
    [P]h = XOR_{d par, 1<=d<p} c_d,
    [T]h = tau(f).

Para verificar as fórmulas, reduza os índices dos monômios módulo quatro
e use y_i^2=y_i. Em uma órbita longa, cada padrão de rotação por quatro
aparece p vezes, portanto com multiplicidade ímpar. Suportes que ocupam
três resíduos contribuem T. Se ocupam quatro, suas 4p contribuições a M
cancelam. Se ocupam dois resíduos opostos, cada um dos dois monômios
quadráticos aparece 2p vezes e também cancela. Os demais casos longos
contribuem apenas L ou C.

Nas órbitas bi-antipodais com d<p, os resíduos são {0,2,d,d+2}, pois
2p=2 (mod 4). Se d é par, a restrição é P, pois cada um de seus dois
monômios ocorre p vezes. Se d é ímpar, a restrição é zero: M aparece 2p
vezes. Finalmente a órbita com d=p contribui M exatamente p vezes.

Pelo lema e pela classificação da base, toda f quártica homogênea RS bent
em n=4p, p primo >=5, satisfaz as três condições necessárias

    c_p = 0,
    XOR_{d par, 1<=d<p} c_d = 1,
    tau(f) = 0.

As três equações são independentes. Testemunhas para as três coordenadas
são, respectivamente, as órbitas representadas por (0,p,2p,3p),
(0,2,2p,2p+2) e (0,1,2,4). Portanto, exatamente 1/8 do espaço quártico
RS satisfaz simultaneamente essas condições. Os outros 7/8 são excluídos
para todo primo p>=5. Isso continua sendo apenas uma condição necessária.

## 4. Relação com a enumeração real em n=20

As duas primeiras condições já eliminavam 75%. A terceira explica a lei
afim identificada e verificada pela segunda enumeração de 2^30 estados.
Com as duas primeiras condições impostas, ela também equivale a

    f((1000)^5) XOR f((0111)^5) = 1,

com a ordem dos bits interpretada consistentemente. De fato, em h,
h(e0)+h(1+e0)=c+d; a base bent exige c=1,d=0.

A enumeração das quatro fibras de período dois aceita 536.864.768 estados
da imagem original de posto 32, isto é, 2^29-6.144. Todos estão no setor
das três equações. Além dessas equações, o filtro rejeita exatamente 6.144
estados dentro desse setor. Todos esses estados excepcionais foram
exportados em T12_affine_exceptions.npz. A fração sobrevivente no espaço
original é 262141/2097152; a exclusão total é 87,50014305114746%.

As exceções não são novas equações universais em p, e sua existência não
fecha n=20. Os sobreviventes também não foram declarados bent.

## 5. Auditoria e prioridade

O certificado T13 verifica a fórmula de restrição de CADA gerador para
p=5,7,11,13,17,19, além das 32 funções RS da base em quatro variáveis.
A demonstração acima, e não essa lista finita de primos, cobre todos os
primos p>=5. T11/T12 são computações reais em A100, com oráculo CPU direto.

O limite clássico do grau bent está apresentado no livro de Claude Carlet,
Boolean Functions for Cryptography and Coding Theory, disponível no site
do autor: https://www.math.univ-paris13.fr/~carlet/book-fcts-Bool-vect-crypt-codes.pdf
O trabalho de Cusick e Sanger (2017), arXiv:1708.09313, trata n=2p e deve
ser comparado com esse argumento. A busca inicial não estabelece prioridade
para o lema de restrição, suas consequências ou as três equações.
Na comparação direta com Sun, Shi, Liu e Fu, Designs, Codes and Cryptography
94:93 (2026), DOI 10.1007/s10623-026-01848-4, as páginas 5 e 10 dão condições
relacionadas. O Teorema 1 exige p1>2^(2^n0); para n=4p, isso significa p>16.
Nessa situação ele impõe igualdade dos valores em zero e um e desigualdade
nos padrões de peso um e três em período quatro. O Teorema 2 traduz essas
condições em paridades orbitais. No caso quártico 4p elas correspondem a
c_p=0 e tau+XOR_even(c_d)=1.

O argumento deste adendo mostra que a restrição COMPLETA de quatro variáveis
é bent e produz separadamente XOR_even(c_d)=1 e tau=0, valendo já para
p=5,7,11,13, além dos primos maiores. Essa é a diferença demonstrada em
relação a esses dois enunciados específicos. A fórmula do limiar foi
conferida na página renderizada, evitando confundir expoentes na extração.
Isso não demonstra originalidade em relação a toda a literatura nem afirma
que nenhum outro resultado do artigo ou de trabalhos anteriores implique
essas condições. A avaliação de prioridade segue pendente.

Não substituir o preprint por este adendo sem revisão independente.

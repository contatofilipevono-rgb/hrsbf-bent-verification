# V2: o limite de grau 3 da necessidade antipodal é exato

## Resultado e alcance

Há uma função rotation-symmetric bent de grau exatamente 4 em oito variáveis cujo coeficiente da órbita quadrática antipodal é zero. Por soma direta intercalada, há exemplos em toda dimensão n=8r, r≥1.

Isso encerra a possibilidade de simplesmente substituir `deg f <= 3` por `deg f <= 4` na conclusão antipodal da v1. Não contradiz a conjectura homogênea: o exemplo contém termos de graus 2 e 4. Não refuta a transferência de bentness a espaços fixos de ordem ímpar; a falha da conclusão antipodal já ocorre na dimensão potência de dois.

Esta nota documenta uma dedução e uma verificação nesta pesquisa. Não afirma que o exemplo ou a construção sejam inéditos. A classificação histórica de funções RS em oito variáveis deve ser consultada antes de qualquer alegação de prioridade. O valor imediato para a v2 é tornar explícita a limitação exata do teorema e orientar corretamente as extensões.

## Exemplo explícito

Todos os índices abaixo são tomados módulo 8, e as somas são em F_2. Defina

    f(x) = sum_{i=0}^7 [
        x_i x_{i+1}
        + x_i x_{i+1} x_{i+2} x_{i+3}
        + x_i x_{i+1} x_{i+2} x_{i+5}
        + x_i x_{i+1} x_{i+3} x_{i+5}
    ].

As quatro órbitas têm comprimento 8 e são distintas. A ANF contém oito monômios quadráticos adjacentes e 24 monômios quárticos, sem termos cúbicos. Nenhum dos quatro monômios x_i x_{i+4} ocorre. Logo o coeficiente de P_8 é zero e o grau é 4.

O certificado finito completo encontra

    W_f(a) = +16 em 136 frequências,
    W_f(a) = -16 em 120 frequências.

Todas as 256 frequências foram calculadas diretamente por

    W_f(a)=sum_{x=0}^{255} (-1)^{f(x)+paridade(a & x)}.

Portanto f é bent. O JSON fornece a tabela verdade em ordem crescente de x, todos os coeficientes de Walsh em ordem crescente de a, os suportes ANF e os hashes. A verificação não usa a regra antipodal nem filtros de derivadas. Uma FWHT inteira adicional confere o cálculo direto, e uma transformação de Möbius recupera a ANF a partir da tabela verdade. A invariância por rotação foi checada em todos os 256 pontos.

## Família infinita por soma direta intercalada

Para r≥1, tome n=8r e organize as variáveis nos blocos

    B_j = (x_j, x_{j+r}, ..., x_{j+7r}), 0<=j<r.

Defina F_r(x)=sum_{j=0}^{r-1} f(B_j).

1. **Bentness.** Os blocos são disjuntos. O espectro de Walsh da soma direta é o produto dos espectros de f nos blocos. Seu módulo é 16^r=2^(n/2).
2. **Simetria de rotação.** Um deslocamento de uma posição leva B_j a B_{j+1} para j<r-1. O último bloco é levado a uma rotação interna de B_0. Como f é RS, a soma é preservada.
3. **Grau.** Os blocos são disjuntos e contêm monômios de grau 4, que não cancelam entre blocos. Logo deg F_r=4.
4. **Ausência antipodal.** Os termos quadráticos de F_r ligam índices separados por r, enquanto pares antipodais são separados por 4r. Como ±r não equivale a 4r módulo 8r, o coeficiente antipodal é zero.

Equivalentemente, F_r possui as quatro órbitas com representantes

    (0,r), (0,r,2r,3r), (0,r,2r,5r), (0,r,3r,5r).

Como controle adicional, a fórmula orbital foi comparada à soma direta nos 65.536 pontos de n=16, e todo o espectro de Walsh teve módulo 256.

## Consequência para o programa de pesquisa

O resultado da v1 é máximo quanto ao limite uniforme de grau: a necessidade antipodal vale até grau 3 e falha já em grau 4. Como uma função bent em n variáveis tem grau no máximo n/2 (para n≥4), oito é também a menor dimensão possível para um contraexemplo de grau 4.

A v2 pode incorporar esta nota como seção de sharpness após revisão própria, mantendo a v1 congelada. O caminho para não existência homogênea em grau 4 precisa usar homogeneidade de modo essencial ou encontrar outro invariante. Um programa que procure provar necessidade antipodal para todas as funções RS de grau ≤4 tem agora um contraexemplo explícito como teste obrigatório.

## Reprodução e proveniência

    python pesquisa_v2_quartic/certify_quartic_boundary.py

O script usa apenas a biblioteca padrão de Python. Seu cálculo direto do caso n=8 é independente do programa NumPy que encontrou o exemplo. O teste n=16 é controle da implementação da família; a prova para todo r é a fatoração algébrica acima.

SHA da branch de pesquisa antes desta etapa: b66fc912b2ced5c4908f7fb0d65b628d2722274d.
V1 congelada: d70ebc8a5a6c8a4901263af24ff71cbdb2a12e93, branch preprint-v1-final-2026-10-06.

Referências para comparação de prioridade, não usadas como certificado do exemplo:

- Stănică–Maitra, Rotation symmetric Boolean functions—Count and cryptographic properties, Discrete Applied Mathematics 156 (2008), 1567–1580. https://doi.org/10.1016/j.dam.2007.04.029
- Carlet–Gao–Liu, A secondary construction and a transformation on rotation symmetric functions, and their action on bent and semi-bent functions, JCTA 127 (2014), 161–175. https://doi.org/10.1016/j.jcta.2014.05.008
- Tang–Qi–Zhou–Fan, Two infinite classes of rotation symmetric bent functions with simple representation. https://arxiv.org/abs/1508.05674

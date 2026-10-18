# Avaliação de Kholosha–Pal e das considerações do Gemini

Data: 18 de outubro de 2026.

## Veredito

O artigo é uma referência pertinente para contextualizar subespaços de meia dimensão, normalidade e dualidade. Não fornece a alegada prova de que o colapso do grau da restrição a V_m impede bentness. A resposta do Gemini mistura identidades corretas com uma conclusão não demonstrada. Não incorporar essa conclusão como teorema, nem como solução da Crítica 1.

Fonte conferida: Alexander Kholosha e Mohit Pal, *General constructions of normal bent partitions related to vectorial dual-bent functions*, arXiv:2610.03420v1, submetido em 2 de outubro de 2026. https://arxiv.org/abs/2610.03420

Foi lido o PDF local de 17 páginas fornecido pelo usuário; a identificação foi confirmada no arXiv. Os resultados e construções têm hipóteses específicas. Não se infere uma obstrução para todas as funções bent ou para todas as funções rotacionais a partir dessas construções.

## O que está correto

Para o produto escalar binário usual em F_2^(2m), o subespaço diagonal V_m={(z,z)} é totalmente isotrópico e V_m^perp=V_m. A inclusão segue de (z,z)·(w,w)=0; a igualdade segue da não degenerescência do produto escalar ambiente e das dimensões. O produto escalar binário usual no espaço ambiente não é uma forma alternante; por isso, preferir a expressão exata “subespaço totalmente isotrópico e autodual” a reivindicar uma nova estrutura simplética sem defini-la.

A identidade de Poisson também está correta:

    Σ_{x∈V_m} (-1)^f(x) = 2^(-m) Σ_{a∈V_m} W_f(a).

Se f é bent, definindo sua dual por W_f(a)=2^m(-1)^f*(a), isso fornece:

    Σ_{x∈V_m} (-1)^f(x) = Σ_{a∈V_m} (-1)^f*(a).

Para f rotacional, sua dual também é rotacional: a mudança de variável na soma de Walsh mostra W_f(Ra)=W_f(a). Portanto, os sinais no lado direito são constantes em órbitas de rotação. Nenhuma dessas etapas produz uma contradição por si.

## A lacuna lógica

Ter grau no máximo dois em um único subespaço de meia dimensão não impede uma função de ser bent. Restrições constantes ou afins são, inclusive, parte do contexto de normalidade discutido pelo artigo. Há uma diferença essencial entre ser afim em um subespaço e ser afim em todos os seus cosetos; a caracterização de Maiorana–McFarland mencionada na introdução se refere à segunda condição.

A passagem “o lado esquerdo fica rigidamente travado; o lado direito soma em blocos; logo há contradição” precisaria calcular conjuntos de valores incompatíveis e provar que são disjuntos. Isso não foi feito pelo Gemini. Para os tamanhos centrais de nosso projeto, a restrição baseada apenas nos comprimentos das órbitas não exclui sequer um valor par admissível da soma.

Verificação exata por programação dinâmica das somas Σ_O |O| ε_O, com ε_O∈{-1,+1} independente por órbita:

| m | Multiplicidades dos comprimentos | Somas possíveis |
|---|---|---|
| 6 | 1:2, 2:1, 3:2, 6:9 | todos os 65 inteiros pares de -64 a 64 |
| 8 | 1:2, 2:1, 4:3, 8:30 | todos os 257 inteiros pares de -256 a 256 |

Qualquer soma de 2^m sinais é par. Assim, nesses dois casos, “sinais constantes nas órbitas” junto à única identidade de Poisson exibida não impõe uma obstrução adicional ao valor dessa soma. As escolhas de sinais utilizadas nesse cálculo são uma relaxação; não se afirma que todas sejam duais bent. Justamente as condições adicionais de realizabilidade da dual teriam de fornecer o argumento ausente.

## Contraexemplo à implicação proposta

Considere, para qualquer m≥1,

    F(x,y)=Σ_{i=0}^{m-1} x_i y_i,  x,y∈F_2^m.

Na ordem de coordenadas (x_0,...,x_{m-1},y_0,...,y_{m-1}), a rotação cíclica de 2m posições permuta os pares antipodais, portanto F é rotacional. Sua transformada é:

    W_F(a,b) = Σ_y (-1)^(b·y) Σ_x (-1)^(x·(y+a))
               = 2^m (-1)^(a·b).

Logo F é bent e F*=F. No subespaço diagonal,

    F(z,z)=Σ_i z_i,

que é linear. Para m≥1 a soma restrita é zero; Poisson fornece 0=0. A autodualidade de V_m, a simetria cíclica e o baixo grau restrito coexistem sem contradição.

Este exemplo tem grau global dois: NÃO refuta a conjectura sobre funções homogêneas de grau quatro. Ele refuta a suficiência dos ingredientes usados na explicação do Gemini. A exclusão quártica precisa usar informação adicional da homogeneidade e dos coeficientes, de filtros necessários, de autocorrelações ou do espectro completo. Os testes anexos reavaliam o espectro inteiro em 4, 6, 8 e 12 variáveis.

## Correções na leitura do artigo

- Página 1, equação (1.1): a permutação é condição da construção de Maiorana–McFarland. Não é uma condição universal na forma alegada pelo Gemini para toda função bent.
- Página 2, Definição 1.2: a construção normal admite funções bent constantes no subespaço distinguido. Isso não apoia “restrição de baixo grau é letal”.
- Página 3: a primeira construção é apresentada inicialmente para p ímpar. A versão binária está na Observação 2.3, página 7. Não transportar expressões com divisão por dois diretamente para característica dois.
- Página 12, Observação 3.3: a segunda construção binária usa V=F_q dentro de F_(q²). Para o emparelhamento Tr_(2m)(ab), esse V também é totalmente isotrópico e autodual: Tr_(2m)(ab)=0 para a,b∈F_q, e a dimensão é m. Essa verificação é uma dedução nossa a partir da definição, não uma citação de um teorema nomeado pelos autores. Portanto, a autodualidade não é uma característica que necessariamente diferencia nosso subespaço de todos os subespaços do artigo.
- Página 13, Observação 4.2: os conjuntos da partição não precisam ser subespaços para permutações gerais. Não descrevê-los genericamente como cosetos de subespaços.
- Não há justificativa para a frase sugerida de que simetria rotacional impede “qualquer estrutura de partição bent normal”. A incompatibilidade com a família homogênea quártica teria de ser demonstrada separadamente.

## Como aproveitar no manuscrito

1. Citar a referência para contexto construtivo e para distinguir normalidade, comportamento em cosetos e restrição a um único subespaço.
2. Acrescentar a autodualidade do subespaço diagonal e a identidade de Poisson como lemas de compatibilidade, com uma declaração explícita de que não bastam para não existência.
3. Reformular a Crítica 1: o grau reduzido não é a contradição; é um mecanismo para obter condições necessárias explícitas. A exclusão depende das condições adicionais efetivamente demonstradas e do certificado.
4. Investigar restrições simultâneas em cosetos, autocorrelações e compatibilidade da dual. Só promover uma nova obstrução a teorema depois de provar a incompatibilidade.

Texto em inglês adequado para adaptação:

“Recent constructions of normal bent partitions highlight the role of subspaces of half the ambient dimension in the construction of bent functions (Kholosha and Pal, 2026). In our rotational setting, the diagonal fixed subspace is self-dual for the standard binary inner product. Poisson summation therefore relates the signed restriction sums of a bent function and its dual on that same subspace. This compatibility identity does not by itself rule out bentness, even when the restricted degree is at most two. The exclusion in the quartic family requires the additional necessary constraints and certificate verification established below.”

O valor da referência depende de sua relação matemática com o argumento. A data recente e a afiliação dos autores não substituem novidade ou prova.

## Evidência reproduzível

`AVALIACAO_KHOLOSHA_PAL_TESTES.json`: espectros dos contraexemplos e capacidades exatas das somas por órbitas em m=6,8. O script independente usa uma FWHT inteira e enumeração exata de órbitas; não usa aproximações ou amostragem nesses controles.

A prova Lean global de H(12,4) permanece em desenvolvimento. A avaliação deste artigo não altera o estatuto do resultado computacional já auditado.

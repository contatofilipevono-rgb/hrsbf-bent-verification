# Comparação integral com Meng–Chen–Fu (2010)

## Fonte e método

Qiang Meng, Lusheng Chen e Fang-Wei Fu, *On homogeneous rotation symmetric bent functions*, Discrete Applied Mathematics 158 (2010), 1111–1117. DOI: https://doi.org/10.1016/j.dam.2010.02.009.

O PDF integral foi fornecido pelo usuário em 4 de outubro de 2026. Foram lidas as sete páginas e conferidas visualmente as páginas 1114–1116, que contêm os Teoremas 11–13 e suas provas. Não redistribuímos o PDF da editora.

## Resultados e sobreposição

| Resultado | Hipóteses e conclusão | Relação com o manuscrito |
|---|---|---|
| Proposição 7, p. 1113 | O máximo absoluto de Walsh de uma restrição coordenada não excede o da função original. | Ferramenta de restrição; não afirma que uma restrição de bent seja bent ou balanceada. |
| Proposições 8–10, pp. 1113–1114 | Espectro de um monômio e fatoração para somas em variáveis disjuntas. | Ferramentas para as provas de não existência. |
| Teorema 11, pp. 1114–1115 | n≥4, grau homogêneo d>2, SANF com um único representante: a função não é bent, para qualquer suporte desse representante. | Todas as cúbicas de uma só órbita já são cobertas, inclusive H contígua em n=32. |
| Teorema 12, pp. 1115–1116 | A soma de todos os monômios de um grau d>2 não é bent. | Função elementar totalmente simétrica; resultado atribuído no próprio artigo a Savický (1994). Não é toda combinação de órbitas. |
| Teorema 13, p. 1116 | Grau homogêneo d≥3 e maior lacuna circular s_f≤n/2: não é bent. s_f inclui a lacuna que cruza a origem. | Exclui combinações em que cada suporte tem todas as lacunas no limite. Não fornece uma exclusão incondicional de todas as cúbicas em n=16 ou n=16m. |

A leitura das provas não revelou uma hipótese de dimensão adicional que transforme esses enunciados em nossa exclusão uniforme. No Teorema 11, a prova separa órbitas curtas e completas. No Teorema 13, fixar n/2−1 coordenadas a zero dá a obstrução de não linearidade exigida. Nenhum dos dois é um enunciado de transferência por todo fator ímpar.

## Comparação concreta dos critérios diretamente enunciados

Em n=16 há 35 órbitas cúbicas; 14 têm maior lacuna circular no máximo oito. Portanto o Teorema 13 cobre diretamente 2^14−1 combinações não nulas. O Teorema 11 acrescenta 21 órbitas isoladas fora desse grupo. O Teorema 12 acrescenta a soma de todas as 35 órbitas. A união dessas três classes tem **16.405 funções**, entre as **34.359.738.367** cúbicas homogêneas RS não nulas.

Essa contagem é somente a aplicação literal dos critérios em coordenadas originais. Não afirma que as demais funções eram desconhecidas em toda a literatura, que não podem ser excluídas por outros argumentos do artigo, ou que não são equivalentes a casos cobertos. Em particular, o exemplo de duas órbitas de SANF x1x2x3 + x1x2x4 fica fora dos três critérios literais de Meng, mas é tratado por Zhang–Gao; não deve ser usado como certificado de novidade global.

O script auditoria_2026_10_04/comparar_meng2010.py reproduz as contagens de órbitas e classes por enumeração de suportes. A saída comparar_meng2010.json registra também n=32: 155 órbitas, das quais 50 satisfazem o limite de lacunas.

## Impacto na contribuição e na submissão

O teorema central revisado exclui **todas** as cúbicas homogêneas RS em **toda dimensão positiva par não divisível por 32**, sem condições de SANF ou lacuna circular. Seu alcance não é igual aos Teoremas 11–13 de Meng–Chen–Fu. A contribuição proposta é a redução quadrática de ordem ímpar e a obstrução uniforme com certificado de divisibilidade; a mera não bentness de H em n=32 não é nova.

A pendência específica de obter e comparar Meng–Chen–Fu está encerrada. O exame dos trabalhos integrais consultados sustenta uma diferença de alcance, mas não é uma garantia de prioridade em toda a literatura nem substitui avaliação externa. Os dados de autoria, afiliações, declarações e a carta final ainda precisam ser completados antes de enviar. Não há alegação de resolução de n=32 nem da conjectura inteira.

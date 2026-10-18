# Incorporação da revisão externa

## Correção aceita: direção do arredondamento

O relatório externo identificou que o percentual T40 havia sido arredondado para cima, apesar de ser apresentado como limite inferior. O argumento racional permanecia correto. A apresentação foi corrigida para **pelo menos 99,94316569188364%**, com a fração exata como referência. A mesma correção foi aplicada aos decimais T39, T43 e T44 quando necessário.

Os verificadores relevantes passaram a emitir um decimal inferior garantido: comparam sua representação decimal à fração exata e, se necessário, recuam um valor representável. O procedimento complementar dá limites superiores. Foram conferidos 132 intervalos, incluindo os certificados reais e casos próximos das extremidades. Nenhum coeficiente, posto, matriz ou fração exata foi alterado.

## Situação das execuções

O relatório do Claude retratava verificadores ainda em execução em seu ambiente. Na máquina desta pesquisa, T40, T43 e T44 já terminaram com PASS, e os relatórios estão publicados. Depois, o usuário informou também a conclusão externa de T40 com PASS. A validação externa de T43/T44 não é presumida concluída por essa informação.

T47 também terminou localmente com PASS e atende ao critério sugerido: passagem abaixo de 3,5×10⁻⁴.

## Clareza e generalização

A fração `2097035386883/2^49` pertence ao conjunto histórico de **nove condições**: seis no núcleo e três bits adicionais. O manuscrito foi rotulado explicitamente para evitar confusão com os conjuntos posteriores.

A fragilidade entre os campos `average_absolute_slice_bias` e `selected_amplitude` está sendo removida por um certificado misto com um campo comum `amplitude_bound` e evidências específicas de cada método. Ele verifica somente as folhas escolhidas, sem depender dos nomes de etapas históricas.

O patamar `100·(1−3/16384)=99,981689453125%` é uma limitação exata da forma atual de estimativa por contribuições não negativas, e não uma hipótese de independência nem um teto para a exclusão real. Isso justifica priorizar novos bits invariantes ou informação sobre sinais, além de simplesmente aumentar k.

Os testes externos com funções bent e polinômios pequenos são evidência útil de consistência; não substituem a prova geral do critério de divisibilidade nem a verificação dos certificados concretos. Nenhum resultado aqui demonstra inexistência global ou resolve C16.

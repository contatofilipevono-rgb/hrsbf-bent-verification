# T41: um teste exato para novas condições

## Identidade compacta

Sob as três leis lineares T20, sejam a=c57 e b=c99. Há 4.080 órbitas completas de entradas, cada uma de tamanho 16. Se w conta aquelas nas quais f vale um, então

`W_f(0) = 65536 − 128a − 192b − 32w`.

A contribuição das 256 entradas de órbitas curtas é `256−128a−192b`. Assim, a condição necessária bent `W_f(0)=±256` equivale a

`w=2040−4a−6b+16σ`, com σ em {0,1}.

Ela elimina, por exemplo, a função zero, que passa nas condições homogêneas anteriores. Passar neste teste isolado também não certifica bentness.

## Verificação e busca

O verificador público reconstrói as 4.080 órbitas, confere a contribuição diagonal de todos os 116 geradores e testa cinco funções: duas com W(0)=±256, duas com valores incompatíveis e a função zero. Todas as identidades e tabelas dos somadores passaram.

A codificação de busca usa somadores binários e equações XOR; ela acrescenta 20.151 variáveis, 36.289 cláusulas e 12.092 equações XOR. Os dois ramos reforçados foram executados por 60 segundos cada. Ambos terminaram **sem conclusão**: não houve prova de impossibilidade nem candidato bent confirmado. Esses limites de tempo não excluem candidatos e não modificam a porcentagem global demonstrada.

Arquivos: `T41_WALSH_CERTIFICADO.json`, `VERIFICAR_IDENTIDADE_WALSH_T41.py`, `T41_IDENTIDADE_VERIFICACAO.json` e `T41_SAT_REFORCADO_RESULTADOS.json`.

O próximo uso possível é ampliar o tempo de busca ou acrescentar outras amplitudes Walsh, preservando a interpretação exata dos resultados. A identidade já oferece um teste simples e reproduzível em condições diferentes das obstruções modulares anteriores.

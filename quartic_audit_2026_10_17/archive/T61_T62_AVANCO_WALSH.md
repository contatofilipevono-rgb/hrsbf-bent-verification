# Condições periódicas de Walsh: implementação e piloto

Foram implementadas as 36 frequências periódicas com pesos orbitais inteiros corretos e uma codificação conjunta de W(0) e W(1^16). O experimento encontrou uma terceira frequência especialmente útil na amostra: 0x0101. Isso orienta a busca; não demonstra inexistência em H(16,4).

## Contadores compartilhados

Sob as três leis T20, escreva a=c57 e b=c99. Existem 2032 órbitas completas de entradas de peso par e 2048 de peso ímpar. Se e e o contam as órbitas de cada classe nas quais f vale 1, então

W(0) = 65536 - 128a - 192b - 32(e+o),

W(1^16) = -128a - 192b - 32(e-o).

Consequentemente, exigir W(0)=256(1-2s0) e W(1^16)=256(1-2s1) equivale a

e = 1016 - 4a - 6b + 8(s0+s1),

o = 1024 + 8(s0-s1),

com s0,s1 em {0,1}. A codificação usa dois somadores sobre os mesmos valores de f nas órbitas.

| Componente | Apenas W(0) | W(0) e W(1^16) |
|---|---:|---:|
| Variáveis auxiliares | 20151 | 20134 |
| Cláusulas CNF | 36289 | 36369 |
| Equações XOR | 12092 | 12083 |

Essas contagens são as do componente de Walsh, em ambos os ramos. Não são tempos de execução nem demonstram melhoria no tempo de solução. O componente conjunto passou em oito controles com funções fixadas, cobrindo os dois ramos e todas as quatro combinações de aprovação/rejeição das amplitudes.

## Outras frequências

Para qualquer frequência u e órbita de entradas O, foram calculados os pesos

C_O(u) = soma_{x em O} (-1)^(u·x),

W_f(u) = soma_O C_O(u)(1-2f(O)).

Essa forma evita supor que todas as frequências admitem o mesmo contador não ponderado. Foram avaliadas as 36 órbitas de frequências com período dividindo 8.

## Resultado do piloto

A amostra reutiliza 512 funções que passaram por nove condições necessárias anteriores. Ela não é uma amostra uniforme de H(16,4).

| Condições de amplitude acumuladas | Sobreviventes |
|---|---:|
| W(0) | 63/512 |
| W(0), W(1^16) | 29/512 |
| W(0), W(1^16), W(0x0101) | 0/512 |

Nas duas metades previamente existentes, os números foram respectivamente 28 → 14 → 0 e 35 → 15 → 0. Essas contagens são descritivas; não constituem um novo ensaio independente após a análise dos dados.

Das 26 funções da amostra que também passavam pelas treze condições, nenhuma passou simultaneamente pelas duas primeiras amplitudes.

Um verificador separado reconstruiu as 512 funções a partir dos seus coeficientes, executou 512 transformadas completas de Walsh e confirmou as 18432 amplitudes periódicas. Resultado PASS. Ele não revalida os rótulos herdados de aprovação nos filtros algébricos anteriores.

## Alcance

O ganho concreto é impor duas amplitudes com tamanho de codificação praticamente igual ao de uma e identificar uma terceira frequência útil para o próximo refinamento. O limite global certificado T47 permanece inalterado. Nenhuma taxa observada aqui foi promovida a limite global e nenhum resultado UNSAT é inferido da amostra.

Arquivos de evidência: T61_WALSH_PERIODICO_PILOTO.json, T61_WALSH_PERIODICO_VERIFICACAO.json, VERIFICAR_WALSH_PERIODICO_T61.py e T62_WALSH_PAR_CODIFICACAO_VERIFICACAO.json.

## Teste limitado do sistema algébrico com as duas amplitudes

O solver foi executado separadamente nos ramos b=0 e b=1, acrescentando a codificação conjunta ao sistema existente de 389 condições cúbicas e restrições auxiliares. Cada ramo atingiu o limite de aproximadamente 30 segundos sem decidir SAT ou UNSAT. Os resultados são inconclusivos, registrados em T62_SAT_Walsh_pair_branch0.json e T62_SAT_Walsh_pair_branch1.json. Não houve prova de inexistência.

## Atualização posterior: amostra nova T66

O zero observado nas três frequências não se manteve numa amostra nova: entre 4096 funções passando nove condições, 18 passaram pelas três amplitudes. Nenhuma dessas 18 passou pelas 36 amplitudes periódicas. Os dados e exemplos estão em T66_WALSH_NOVA_AMOSTRA_VERIFICACAO.json; a avaliação consolidada está em AVALIACAO_GEMINI_E_NOVOS_TESTES.md. Todos esses números são amostrais.

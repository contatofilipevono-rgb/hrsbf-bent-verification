# Auditoria dos certificados de fase no plano ⟨21,42⟩

Os certificados e seu construtor são contribuição do Gemini Argon. A auditoria do Codex refez a preparação com o código do ramo de pesquisa e os suportes da execução de referência. Os hashes de suportes, representantes, pesos de órbita, testemunhas nativas, tarefas reconstruídas e base de translações coincidiram byte a byte. Os arquivos JSON com tempos de execução diferiram em alguns hashes. O verificador no ramo fixa os hashes dos insumos binários e da base de translações e aceita tempos diferentes nos relatórios.

O verificador recompilou as 344 tarefas, repetiu as 307 exclusões quadráticas e conferiu as 31 identidades de contradição nas 37 restantes. Dos 31 certificados, 12 usam uma equação, 16 usam duas, um usa quatro e dois usam seis. Em 27 casos os multiplicadores são constantes. Em quatro casos há multiplicadores lineares.

Nos seis representantes positivos, o verificador prova as reduções e a impossibilidade de zerar qualquer assinatura de exclusividade. Depois conta as soluções dos sistemas quadráticos restantes por somas de Gauss. Um segundo programa confirma os 25 totais não nulos por avaliação direta dos resíduos dos momentos em paralelo por bits, nos espaços reduzidos certificados. Esse teste não usa a compilação dos bits módulo 8 e 16 nem a rotina de somas de Gauss. Foram verificadas também as testemunhas ANF e as translações publicadas de cada testemunha por Walsh completo, grau, simetria e exclusividade.

| Mapa | Fases no quociente | Fases por mapa | Tamanho da órbita |
| ---: | ---: | ---: | ---: |
| 1 | 8.960 | 71.680 | 1 |
| 19 | 96 | 3.072 | 64 |
| 822549 | 32 | 512 | 32 |
| 115044639 | 16 | 256 | 32 |
| 115044803 | 16 | 256 | 32 |
| 202149121 | 256 | 4.096 | 2 |

O total ponderado é 309.248 funções. O verificador principal dispensa a enumeração das fases. A conferência independente avalia atribuições apenas nos espaços reduzidos dos casos positivos. A construção e classificação dos suportes ainda são finitas.

O fluxo `n12_dim2_certificates.yml` reconstrói os suportes e as órbitas, verifica o manifesto e roda a segunda contagem. A opção `--build` do construtor requer as testemunhas binárias nativas da execução de referência. A opção `--verify` usa as testemunhas incorporadas ao manifesto e pode preparar as tarefas a partir dos representantes.

## Primeiro plano, ⟨27,54⟩

O mesmo método resolve as 98 tarefas do primeiro plano. Depois das 85 exclusões quadráticas, 13 ficam no manifesto `plane27-phase-certificates.json`. Dez já caem com momentos módulo 8 e assinaturas. A tarefa 1913345 cai por uma única equação módulo 16. As tarefas 1913347 e 42953732 exigem primeiro duas relações lineares, que reduzem o espaço de 19 a 17 parâmetros. No espaço reduzido, um momento dá a contradição constante. O verificador recompila cada equação usada e confere as identidades sem percorrer as fases. Assim, os dois planos de dimensão dois têm a etapa de fases certificada por álgebra.

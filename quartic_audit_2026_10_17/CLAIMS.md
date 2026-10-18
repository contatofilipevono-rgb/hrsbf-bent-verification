# Estado verificável das afirmações

| Afirmação | Estado | Evidência | Limite |
|---|---|---|---|
| Nenhuma bent em H(12,4) | Resultado computacional global auditado | Pacote original, fonte, log completo, T110/T111 | Sem segunda execução integral independente; não é ainda teorema Lean global |
| Os 43 filtros quadráticos são necessários | Demonstração por restrição de Walsh e carry; reconstrução independente | Relatório global e verificador do pacote | Não implica, sozinho, inexistência |
| Três relações lineares decorrem desses filtros | Identidades exatas com testemunhos | `linear_law_certificates.json`, `verify_linear_laws.py` | Não se supõem as cinco leis antigas |
| A imagem de período quatro tem dimensão quatro | Verificada por geradores e forma normal | `H12PeriodFour.lean`, verificador periódico | A restrição perde informação fora dos pontos fixos |
| Somente quatro tabelas passam nas autocorrelações módulo três | Prova finita no núcleo Lean | `four_case_classification` | É uma condição necessária |
| A soma sobre 4.096 entradas reduz à soma de 16 pontos fixos módulo três | Prova de partição e soma em Lean | `H12Descent.lean` | A aplicação à função exige a invariância correspondente |
| O peso em órbitas longas deve ser 165, 170, 172 ou 171 conforme o caso | Redução algébrica e verificação exata | `verify_periodic_reduction.py` | Não exclui todos os candidatos |
| H(16,4) não contém bent | **Não demonstrada nesta pesquisa** | Há somente cotas certificadas de exclusão | Não converter percentuais em inexistência |
| O sistema SAT experimental é UNSAT | **Não estabelecida** | Logs em `experiments/` | Interrupção/timeout não significa UNSAT |
| A inexistência quártica geral é uma conjectura nova deste projeto | **Falso como atribuição** | Contexto bibliográfico em `archive/CONJECTURA_QUARTICA_E_CONTEXTO.md` | É caso particular de conjectura anterior |

As antigas buscas condicionadas em 36 variáveis e suas contagens são preservadas para auditoria. Elas não substituem a busca global em 43 variáveis. Relatórios históricos que empreguem “provado”, “global” ou “certificado” devem ser lidos à luz desta tabela e das correções posteriores.

## O que significam os axiomas do Lean

Os lemas são acompanhados de `#print axioms`. As provas finais desta entrega devem depender apenas de axiomas lógicos usuais como `propext` e `Quot.sound`, sem `sorryAx`, avaliação nativa ou axiomas particulares do projeto. As primeiras tentativas locais que usavam `bv_decide` foram substituídas por identidades explícitas para retirar uma dependência de avaliação nativa. Os registros antigos de tentativas não devem ser confundidos com o registro final de compilação.

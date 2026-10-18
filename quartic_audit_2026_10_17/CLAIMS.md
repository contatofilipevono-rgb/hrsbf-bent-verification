# Estado verificável das afirmações

**H(12,4) está fechado computacionalmente:** nenhuma função bent no espaço definido pelos 43 geradores quárticos cíclicos. A busca global original é corroborada por duas execuções independentes em CPU nos espaços necessários e por um certificado simbólico completo. A formalização integral dessa conclusão em Lean permanece em desenvolvimento; essa etapa não reabre a busca computacional.

| Afirmação | Estado | Evidência | Limite |
|---|---|---|---|
| Nenhuma bent em H(12,4) | Resultado computacional global auditado e corroborado independentemente | Pacote original, T110/T111, duas execuções em CPU nos espaços necessários e certificado simbólico completo | A enumeração literal das 2^43 funções foi executada na GPU original; a verificação independente usa reduções necessárias. Não é ainda teorema Lean global |
| Nenhuma bent nos quatro espaços necessários, cobrindo qualquer possível bent de H(12,4) | Certificado finito completo e repetição independente em CPU | `cpu_replay/DECOMPOSITION.json`, 164.288 testemunhos, verificadores independentes | O verificador global está em Python, ainda não formalizado no Lean |
| Os 43 filtros quadráticos explícitos são necessários | **Provado também em Lean**, desde a definição por autocorrelação | `H12FilterLink.bent_passes`, Poisson, pesos, tabelas e 43 verificações numéricas | Não implica, sozinho, inexistência |
| Três relações lineares e c40*c42=0 decorrem de bentness | Identidades e necessidade dos filtros provadas em Lean | `H12Quadratic.lean`, `H12FilterLink.lean`, `H12Audit.necessary_chart_constraints` | Ainda falta aplicar a árvore de exclusão às cartas numéricas |
| A imagem de período quatro tem dimensão quatro | Verificada por geradores e forma normal | `H12PeriodFour.lean`, verificador periódico | A restrição perde informação fora dos pontos fixos |
| Somente quatro tabelas passam nas autocorrelações módulo três | Prova finita no núcleo Lean | `four_case_classification` | É uma condição necessária |
| A soma sobre 4.096 entradas reduz à soma de 16 pontos fixos módulo três | Prova de partição e soma em Lean | `H12Descent.lean` | A aplicação à função exige a invariância correspondente |
| A função quártica é invariante pela rotação usada na descida | Prova estrutural em Lean por permutação dos monômios | `H12Orbit.lean`, `quartic_rotational_four` | Vale para a base explícita do projeto |
| As regras algébricas do verificador de árvores são corretas | Teorema genérico em Lean | `H12Refutation.check_sound` | O teste terminal exige sua própria prova; a árvore global ainda não foi instanciada |
| Todo possível bent pertence a uma carta numérica e satisfaz seu sistema transformado | Provado em Lean, com construção explícita das coordenadas e 172 substituições exatas | `H12Affine.covers_bent_cpu`, `H12ChartFilters.bent_root` | Falta conferir a árvore e seus testes terminais no Lean |
| Autocorrelação bent implica W(a)=±64; um valor de Walsh fora desse módulo rejeita bentness | Provado em Lean | `H12Walsh.bent_walsh_values`, `walsh_witness_rejects` | Não confere automaticamente os testemunhos numéricos; a direção Walsh plano → autocorrelação também está provada em `H12Fourier.bent_iff_flat` |
| O peso em órbitas longas deve ser 165, 170, 172 ou 171 conforme o caso | Redução algébrica e verificação exata | `verify_periodic_reduction.py` | Não exclui todos os candidatos |
| H(16,4) não contém bent | **Não demonstrada nesta pesquisa** | Há somente cotas certificadas de exclusão | Não converter percentuais em inexistência |
| O sistema SAT experimental é UNSAT | **Não estabelecida** | Logs em `experiments/` | Interrupção/timeout não significa UNSAT |
| A inexistência quártica geral é uma conjectura nova deste projeto | **Falso como atribuição** | Contexto bibliográfico em `archive/CONJECTURA_QUARTICA_E_CONTEXTO.md` | É caso particular de conjectura anterior |

As antigas buscas condicionadas em 36 variáveis e suas contagens são preservadas para auditoria. Elas não substituem a busca global em 43 variáveis. Relatórios históricos que empreguem “provado”, “global” ou “certificado” devem ser lidos à luz desta tabela e das correções posteriores.

Os novos quatro espaços de dimensão 36 não são a antiga busca condicionada: derivam de quatro possibilidades da restrição periódica e de três relações lineares certificadas globalmente. Os três casos não vazios possuem 46.912, 46.400 e 70.976 zeros dos filtros, respectivamente; o quarto é incompatível com um filtro necessário. A cobertura desses espaços foi verificada simbolicamente, não apenas inferida da lista de candidatos.

## O que significam os axiomas do Lean

Os lemas são acompanhados de `#print axioms`. As provas finais desta entrega dependem apenas dos axiomas lógicos usuais `propext`, `Quot.sound` e, no módulo espectral, `Classical.choice`, sem `sorryAx`, avaliação nativa como axioma ou axiomas particulares do projeto. As primeiras tentativas locais que usavam `bv_decide` foram substituídas por identidades explícitas para retirar uma dependência de avaliação nativa. Os registros antigos de tentativas não devem ser confundidos com o registro final de compilação. A tabela completa das obrigações restantes está em `FORMALIZATION_STATUS.md`.

## Progresso do contador e dos testes terminais

O contador exato e o modular estão provados em `H12Popcount`; a ligação aos valores Walsh originais está provada em `H12WalshTable`, incluindo `rejectsMod_sound`. A execução concreta dos 164288 testes ainda não terminou neste checkpoint. Os fontes gerados de `H12WitnessCertificate` não são evidência de aprovação por si. A ponte da árvore usa hipóteses explícitas e ainda não fornece um teorema global incondicional.

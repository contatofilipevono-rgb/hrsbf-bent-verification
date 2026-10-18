# Estado da formalização de H(12,4)

O resultado computacional global é zero bent. O objetivo formal integral ainda não foi atingido. Esta tabela identifica as obrigações, sem substituir a prova global por uma coleção de lemas condicionais.

| Obrigação | Estado e evidência atual |
|---|---|
| Definir a base correta de H(12,4) | `H12.quarticOrbits`, no arquivo `H12PeriodFour.lean`, contém os 43 geradores explícitos; `H12Orbit.all_supports_partitioned` cobre os 495 suportes exatamente uma vez e `cyclic_orbits_exact` verifica cada órbita cíclica distinta. |
| Ligar a função original à restrição de período quatro | `H12.quartic_periodic`, `H12.restriction_normal_form`: provados. |
| Provar a invariância por rotação | `H12Orbit.quartic_rotational_four`: provado estruturalmente, sem tabela de 43 × 4096 avaliações. |
| Descer autocorrelações aos 16 pontos fixos | `H12Descent.bent_rotational_descent`: provado usando a partição exata em 16 pontos fixos e 1360 triplas. |
| Classificar os quatro casos periódicos | `H12.four_case_classification`, `H12Audit.quartic_bent_four_cases`: provados. |
| Autocorrelação bent implica Walsh de módulo 64 | `H12Walsh.bent_walsh_square`, `bent_walsh_values`: provados para a definição explícita de Walsh em 12 bits. |
| Um valor Walsh de quadrado diferente de 4096 rejeita bentness por autocorrelação | `H12Walsh.walsh_witness_rejects`: provado. Ainda não é a conferência dos 164288 valores concretos. |
| Walsh plano implica autocorrelação bent | Ainda não formalizado. Necessário para uma equivalência formal completa das duas definições e para exportar o resultado final na definição espectral usual. |
| Os 43 filtros quadráticos explícitos são necessários | **Provado:** `H12FilterLink.bent_passes`. `H12Restriction` prova Poisson/divisibilidade do peso; `H12Weight` prova a forma quadrática; `H12Truth` liga os bitsets aos geradores originais; `H12NumericFilters` confere as 43 identidades exatas no núcleo. |
| As três leis lineares decorrem de bentness | `H12Quadratic.necessary_r1/r2/r3` e `H12FilterLink.bent_passes`, reunidos em `H12Audit.necessary_chart_constraints`. Esse teorema recebe somente a hipótese de autocorrelação bent. |
| Eliminar o caso periódico 15 | Provado a partir de bentness pela identidade curta e pela necessidade dos filtros. `H12Audit.necessary_chart_constraints` conclui apenas os casos 2, 3 e 8. |
| Cobrir as soluções das condições lineares pelas cartas afins explícitas | Postos e bases verificados em `cpu_replay/verify_model.py`; a aplicação às bases numéricas ainda não foi formalizada em Lean. |
| Correção algébrica de normalização e substituição | `H12CertificateTheory.evaluate_normalize/evaluate_substitute/update_of_equation`: provados. |
| Correção genérica do verificador da árvore | `H12Refutation.check_sound`: provado, com hipótese explícita sobre o teste terminal. |
| Avaliação eficiente de pesos e tabelas dos geradores | `H12Bits.fastCarry_sound` e `foldParity_sound` provam os dois primeiros bits do peso por operações em blocos. `H12PlaneTables` e `H12Truth.basis_semantics` provam a semântica exata das tabelas; `H12TablePolynomial` liga o cálculo rápido aos polinômios de peso. Isso ainda não é um contador de peso inteiro para os testemunhos globais. |
| Instanciar a árvore numérica global no Lean | Pendente. A árvore completa foi conferida pelo verificador independente Python, não por `H12Refutation.check`. |
| Conferir os testemunhos Walsh numéricos no Lean | Pendente. Todos foram recalculados em Python. As tabelas dos geradores já têm prova semântica Lean; falta o cálculo formal dos pesos dos vetores com fase linear e a aplicação aos 164288 testemunhos. Uma auditoria exata mostra que bastam 4–10 bits de peso conforme o testemunho; veja `reports/WALSH_WITNESS_MODULI.json`. |
| Teorema Lean global de inexistência | **Ausente.** Não existe ainda uma declaração formal que conclua a inexistência em todo H(12,4). |

## Lógica e confiança

As provas são compiladas com Lean 4.35.0, sem Mathlib e sem `sorry` ou axiomas particulares do projeto. As declarações finais imprimem suas dependências e usam apenas `propext`, `Quot.sound` e, em alguns lemas, o axioma lógico padrão `Classical.choice`. Não se usa avaliação nativa como axioma para certificar os resultados finitos. As 43 identidades numéricas têm provas separadas no núcleo e uma prova conjunta por lista de verificações. `leanchecker` repete as declarações pelo mesmo núcleo Lean; não é um segundo núcleo independente.

Veja os registros atuais em `reports/` e os nomes exatos em `lean/*.lean`. Os arquivos históricos em `archive/` e as tentativas em `experiments/` têm escopos distintos.

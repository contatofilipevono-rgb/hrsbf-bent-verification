# Estado da formalização de H(12,4)

**Atualização de 21/10/2026: objetivo formal de H(12,4) atingido.** `H12Final.no_bent_quartic`, `no_flat_quartic` e `walsh_witness` foram aceitos pelo kernel e auditados após a integração das três raízes. Consulte [o relatório final](../research_updates/2026_10_20_final_integration/CONCLUSAO_FORMAL_H12.md). A tabela preserva a descrição das reduções e registra abaixo a conclusão global.

O checkpoint histórico de base cobria 218 módulos com reprodução pelo kernel; veja [ESTADO_KERNEL_218.md](ESTADO_KERNEL_162.md). As teorias de composição por linhas e os pilotos adicionais passaram. A instanciação das três cartas e a integração final foram concluídas no run 39520500414, tentativa 2.

| Obrigação | Estado e evidência atual |
|---|---|
| Definir a base correta de H(12,4) | `H12.quarticOrbits`, no arquivo `H12PeriodFour.lean`, contém os 43 geradores explícitos; `H12Orbit.all_supports_partitioned` cobre os 495 suportes exatamente uma vez e `cyclic_orbits_exact` verifica cada órbita cíclica distinta. |
| Ligar a função original à restrição de período quatro | `H12.quartic_periodic`, `H12.restriction_normal_form`: provados. |
| Provar a invariância por rotação | `H12Orbit.quartic_rotational_four`: provado estruturalmente, sem tabela de 43 × 4096 avaliações. |
| Descer autocorrelações aos 16 pontos fixos | `H12Descent.bent_rotational_descent`: provado usando a partição exata em 16 pontos fixos e 1360 triplas. |
| Classificar os quatro casos periódicos | `H12.four_case_classification`, `H12Audit.quartic_bent_four_cases`: provados. |
| Autocorrelação bent implica Walsh de módulo 64 | `H12Walsh.bent_walsh_square`, `bent_walsh_values`: provados para a definição explícita de Walsh em 12 bits. |
| Um valor Walsh de quadrado diferente de 4096 rejeita bentness por autocorrelação | `H12Walsh.walsh_witness_rejects`: provado. Ainda não é a conferência dos 164288 valores concretos. |
| Walsh plano implica autocorrelação bent | **Provado:** `H12Fourier.fourier_inversion`, `flat_implies_bent` e `bent_iff_flat` completam a equivalência, sem uma tabela de 4096 × 4096 valores. |
| Os 43 filtros quadráticos explícitos são necessários | **Provado:** `H12FilterLink.bent_passes`. `H12Restriction` prova Poisson/divisibilidade do peso; `H12Weight` prova a forma quadrática; `H12Truth` liga os bitsets aos geradores originais; `H12NumericFilters` confere as 43 identidades exatas no núcleo. |
| As três leis lineares decorrem de bentness | `H12Quadratic.necessary_r1/r2/r3` e `H12FilterLink.bent_passes`, reunidos em `H12Audit.necessary_chart_constraints`. Esse teorema recebe somente a hipótese de autocorrelação bent. |
| Eliminar o caso periódico 15 | Provado a partir de bentness pela identidade curta e pela necessidade dos filtros. `H12Audit.necessary_chart_constraints` conclui apenas os casos 2, 3 e 8. |
| Cobrir todos os possíveis bent pelas cartas afins explícitas | **Provado:** `H12Affine.covers_bent` constrói as 36 coordenadas livres e reconstrói o coeficiente original em uma das três cartas restantes. `embed_cpu_agree` e `covers_bent_cpu` ligam essa parametrização à soma XOR de offset e colunas usada pela CPU. Não se pressupõe o posto calculado externamente. |
| Ligar os filtros originais aos sistemas nas cartas | **Provado:** `H12Compose.affine_substitution` dá a semântica genérica de substituição; `H12ChartFilters.exact_substitution` confere as 172 identidades; `bent_root` coloca qualquer possível bent em uma raiz do certificado. Os dados formais são comparados com `model.json` por `tools/check_affine_data.py`. |
| Correção algébrica de normalização e substituição | `H12CertificateTheory.evaluate_normalize/evaluate_substitute/update_of_equation`: provados. |
| Correção genérica do verificador da árvore | `H12Refutation.check_sound`: provado, com hipótese explícita sobre o teste terminal. |
| Avaliação eficiente de pesos e tabelas dos geradores | `H12Bits.fastCarry_sound` e `foldParity_sound` provam os dois primeiros bits do peso por operações em blocos. `H12PlaneTables` e `H12Truth.basis_semantics` provam a semântica exata das tabelas; `H12TablePolynomial` liga o cálculo rápido aos polinômios de peso. `H12Popcount.fastWeight_sound` agora prova o peso inteiro, e `fastWeightMod_sound` prova todos os resíduos por potências de dois. `H12WalshTable.phaseWeight_sound` liga os cálculos à função e à fase originais; `rejectsMod_sound` prova a rejeição modular. |
| Instanciar a árvore numérica global no Lean | **Concluído por outra implementação formal:** as três raízes `H12CloudChart0/1/2.refutation` foram conferidas e integradas com `H12AffineFastState.no_bent_of_affine_state_refutations`. Não se afirma execução da árvore completa pelo antigo `H12Refutation.check`. |
| Conferir os testemunhos Walsh numéricos no Lean | **Concluído.** Os 164288 testes concretos nos 41 módulos de dados e no agregador passaram na compilação e na reprodução independente pelo kernel. Evidência: `reports/LEAN_WITNESS_KERNEL_AUDIT.json` e os registros completos em `reports/witness_kernel/`. Esses testes isolados não demonstram cobertura; a cobertura completa agora decorre das três raízes concretas e da integração final. |
| Teorema Lean global de inexistência | **Concluído e auditado:** `H12Final.no_bent_quartic` conclui ∀ c : BitVec 43, ¬ BentAC (quarticFunction c), sem filtros adicionais como premissas; `no_flat_quartic` e `walsh_witness` dão as consequências espectrais. |

## Lógica e confiança

As provas são compiladas com Lean 4.35.0, sem Mathlib e sem `sorry` ou axiomas particulares do projeto. As declarações finais imprimem suas dependências e usam apenas `propext`, `Quot.sound` e, em alguns lemas, o axioma lógico padrão `Classical.choice`. Não se usa avaliação nativa como axioma para certificar os resultados finitos. As 43 identidades numéricas têm provas separadas no núcleo e uma prova conjunta por lista de verificações. `leanchecker` repete as declarações pelo mesmo núcleo Lean; não é um segundo núcleo independente.

Veja os registros atuais em `reports/` e os nomes exatos em `lean/*.lean`. Os arquivos históricos em `archive/` e as tentativas em `experiments/` têm escopos distintos.

## Ponte final e conferência de folhas

`H12TerminalTheory.terminal_sound` prova a cobertura por coordenadas livres sob uma verificação explícita de suporte. `H12WitnessSearch.checked_good` prova a correção da busca de testemunhos. `H12CertificateBridge.terminalCheck_sound` liga os dois testes; `root_observation` liga a observação à parametrização original. `no_bent_of_three_refutations` é um teorema **condicional**: falta fornecer as três refutações concretas. Ele não é o teorema global concluído.

A biblioteca principal tem 28 módulos. A biblioteca opcional de testemunhos tem 42 módulos adicionais, cuja compilação e reprodução pelo kernel foram concluídas com sucesso.

A avaliação de Kholosha–Pal está em `KHOLOSHA_PAL_REVIEW.md`. Poisson no subespaço autodual é uma compatibilidade necessária; a alegação de que isso, junto ao grau restrito baixo, resolve a inexistência não foi demonstrada e não é usada como premissa.


## Ponte compacta e folha concreta

`H12PackedTerminal.terminalCheckFast_sound` e `H12WitnessIndex.build_good` passaram na compilação e na reprodução pelo kernel. A folha 12 da primeira carta foi instanciada: três parâmetros livres, oito candidatos, rejeição comprovada desde a observação afim até os testemunhos das funções originais. Evidência: `reports/LEAN_PACKED_TERMINAL_AUDIT.json`. A folha isolada não substitui a prova dos caminhos da árvore global.

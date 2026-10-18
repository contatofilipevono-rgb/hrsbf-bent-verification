# Checkpoint de 162 módulos

A auditoria de fontes e registros cobre 162 módulos Lean: os 147 do checkpoint anterior e 15 novos módulos de teoria e pilotos. Todos passaram na compilação e na reprodução independente pelo kernel. Os 164.288 testemunhos Walsh continuam integralmente conferidos. A prova global Lean de inexistência em H(12,4) permanece pendente.

`H12QuadraticCompose.composeRows_sound` prova a composição de um polinômio quadrático agrupado em 36 linhas. `canonicalFast_sound` prova uma alternativa de normalização. As duas variantes do estado afim têm provas genéricas de correção, incluindo a passagem das folhas para a função original. Os axiomas impressos são apenas os usuais do Lean; não há axiomas particulares, `sorry` ou avaliação nativa como axioma.

As instâncias novas são: seis módulos do ramo com normalização alternativa, três do ramo com normalização anterior e três da quarta carta completa. Ambos os ramos correspondem aos mesmos 3 nós, 31 transições e 16 candidatos. Eles também se sobrepõem a pilotos anteriores. Não se somam essas contagens. A quarta carta já estava excluída; sua nova refutação testa a ligação da variante às definições originais, sem resolver as três cartas necessárias restantes.

O teste local de 16 identidades registrou 16,229 s no método anterior, 9,997 s na composição por linhas com normalização anterior e 16,124 s com a normalização alternativa. Havia outras tarefas em execução: são medidas locais, sem controle de carga, não uma garantia de aceleração. A variante escolhida para a execução completa é `H12AffineRowScanState`.

Um experimento com 6.000 declarações por módulo atingiu aproximadamente 7.071 MB de memória privada em um computador de 8 GB e foi interrompido sem contar resultados como aprovados. A carta de índice 2 foi regenerada com 1.200 declarações de dados e 600 provas por módulo: 541 módulos, 14.227 nós, 64.342 transições e 70.976 candidatos terminais. Essa geração, e quaisquer módulos parciais aprovados, não estabelecem cobertura da carta. A conclusão exige o teorema final da raiz e, depois, as outras duas cartas.

Os fontes da execução completa em andamento são trabalho local e não integram este checkpoint verificado. Os nove módulos aprovados da primeira execução foram preservados; seu relatório registra explicitamente a interrupção e a ausência de cobertura da raiz.

Evidências principais: `LEAN_CHECKPOINT_COVERAGE.json`, `LEAN_ROW_THEORY_AUDIT.json`, `LEAN_ROW_SCAN_THEORY_AUDIT.json`, `LEAN_ROW_ROOT_PILOT_AUDIT.json`, `H12RowScanPilot_KERNEL_AUDIT.json` e `H12RowScanEmptyChart_KERNEL_AUDIT.json`, em `reports/`. Os registros completos acompanham os relatórios.

No checkout publicado, `python tools/audit_lean_checkpoint.py` confere os hashes e os registros dos 162 módulos. Essa auditoria não substitui repetir as provas com os verificadores Lean. Na árvore de desenvolvimento, bibliotecas completas ainda inacabadas devem ser excluídas explicitamente; o relatório da auditoria identifica essas exclusões. O pacote de 147 módulos continua disponível como snapshot anterior testado.

# N5 — reprodução integral do arquivo destinado ao depósito

Estado: NÃO EXECUTADA nesta rodada. A conclusão do parecer de que falta um rebuild limpo desta distribuição é mantida. O teste de representação, o confronto de hashes e a integração original certificada não são apresentados como substitutos desse teste.

Arquivo exato: H12_formal_sources.zip, SHA256 89aa7f8df2aaa20c9466955be9851f275ff20b2a1cb7aaf06c27cdea23caf6ac. Fontes matemáticas inalteradas; lakefile.toml é metadado da distribuição. O arquivo contém 2.093 fontes matemáticos, sem objetos compilados.

Procedimento recomendado em ambiente Linux isolado com Lean 4.35.0:

1. Conferir o SHA256 do ZIP e extrair em pasta vazia, sem restaurar objetos de execuções anteriores na primeira fatia.
2. Conferir todos os membros contra SOURCE_SHA256.json e preservar o hash do lakefile.toml e lean-toolchain.
3. Registrar versões Lean/Lake, sistema e horários. Executar `lake build H12Final` e depois `lake env leanchecker --verbose H12Final`.
4. Preservar os quatro relatórios de axiomas e conferir apenas propext, Classical.choice e Quot.sound, sem sorryAx/ofReduceBool.
5. Exportar logs, manifesto dos objetos e relatório de conclusão vinculados ao hash exato do ZIP.

Pode exigir horas; não foi iniciada carga Lean pesada na máquina do usuário nem serviço pago. Se a execução for dividida em fatias, a primeira deve começar limpa e cada continuação deve validar as fontes e o checkpoint exato. Isso é teste de reprodução da distribuição, não uma nova busca de candidatos. Não apagar registros da prova original nem declarar N5 encerrado antes do resultado real.

O diretório original de integração traz 20/10 no nome porque foi criado na preparação. A integração formal terminou em 21/10; esta explicação pertence aos registros de reprodução, não ao artigo.

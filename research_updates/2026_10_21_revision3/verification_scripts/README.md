# Scripts desta rodada

- audit_terminal_images.py compara as imagens terminais com os CSVs e avalia todos os43 quadráticos; pode ser executado na distribuição completa, desde que H12_formal_sources.zip esteja na pasta acima.
- audit_certificates_and_definitions.py verifica os fontes certificados, grafo e correspondência de órbitas; não recompila Lean.
- audit_article_transcription.py, na raiz, reconstitui os dados matemáticos a partir do artigo atual.
- render_article.py e qa_pdfs.py são registros do ambiente de preparação; dependem das ferramentas locais e não são o verificador de prova. Os geradores antigos ficaram no histórico e não devem substituir a versão atual.
- O script original round2_check.py fica em parecer_rodada2, junto do relatório recebido. Seu replay no artigo atual passou nas33 checagens.

Use Python sem -O. Não confundir estes testes com o rebuild integral ainda pendente em N5.

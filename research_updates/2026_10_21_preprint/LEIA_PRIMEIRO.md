# Pacote para análise adversarial — H(12,4)

Versão preparada em 21/10/2026. Comece pelo artigo PDF e pelo PEDIDO_ANALISE_ADVERSARIAL.md. A finalidade desta entrega é obter uma avaliação externa crítica da matemática, da novidade e da apresentação.

O pacote essencial inclui artigo, fontes de redação, suplemento independente e relatórios. O arquivo H12_formal_sources.zip, de cerca de 49 MB, é fornecido separadamente: contém 2.093 fontes matemáticas Lean com hashes conferidos contra os registros certificados. O novo empacotamento Lake não foi reconstruído integralmente nesta preparação; a integração formal original já foi concluída e auditada.

O suplemento independente passou em 138,631 segundos na máquina de preparação. Para reproduzir, extraia H12_independent_verification.zip e execute `python verify.py`, sem a opção -O. O resultado esperado é PASS_COMPLETE_SYMBOLIC_COVER_AND_WALSH_REJECTIONS. Isso não substitui a reconstrução da prova Lean.

Escopo: inexistência de funções bent homogêneas quárticas simétricas por rotação em doze variáveis, com todos os 43 coeficientes livres. Não é um resultado para dezesseis variáveis ou dimensões gerais.

Os pareceres incluídos são autocríticas simuladas, não avaliação independente. A comparação bibliográfica dirigida não estabelece prioridade absoluta. A declaração de IA foi mantida na redação aprovada pelo autor.

O Figshare tem um rascunho separado, item 34737294, ainda não publicado. Este pacote não é uma submissão à revista. As declarações de financiamento e conflitos ainda devem ser confirmadas antes da submissão.

## Conferências adicionais

MAPA_PARA_AVALIADOR.md relaciona as proposições às fontes conceituais. ARTICLE_TRANSCRIPTION_AUDIT.json registra a reconstrução das tabelas e identidades a partir do artigo. H12_final_kernel_records.zip inclui as duas fontes finais e os quatro logs com hashes iguais ao relatório original, além dos relatórios de escopo e auditoria. Nenhuma dessas verificações reiniciou o Lean.

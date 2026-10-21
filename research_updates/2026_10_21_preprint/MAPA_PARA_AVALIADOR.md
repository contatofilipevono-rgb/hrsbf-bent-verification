# Roteiro de conferência para o avaliador

O artigo é a exposição principal. Este mapa localiza os pontos em que uma eventual falha seria decisiva e permite chegar às fontes sem ler milhares de arquivos gerados em sequência.

| Questão | Artigo | Material a conferir |
|---|---|---|
| A família é exatamente H(12,4)? | Proposição 2.1 e Apêndice A | Cobertura dos 495 suportes; ARTICLE_TRANSCRIPTION_AUDIT.json; H12Final e definição concreta de quarticFunction |
| BentAC significa bent no sentido de Walsh? | Lema 2.2 e Seção 5.2 | H12Fourier.lean, bent_iff_flat; H12Final.no_flat_quartic |
| Os filtros são necessários, não uma premissa adicional? | Lema 3.1 e (3.2) | Reconstrução dos 43 filtros no script audit_article_transcription.py; H12NumericFilters.all_filters_exact |
| As três relações decorrem dos filtros? | Lema 3.2 e Apêndice B | Expansão de todos os 22/1/24 produtos, conferida pelo script de transcrição |
| A restrição periódica cobre as possibilidades? | Lemas 3.3–3.4 | H12Descent.bent_rotational_descent; tabela completa dos 16 códigos e identidade (3.8) |
| As famílias cobrem toda candidata bent? | (3.9), Proposição 3.5 | H12ChartFilters.bent_root; verificação simbólica das três parametrizações |
| A recursão preserva as soluções? | Seção 4 | H12AffineFastState.Refutes e refutes_sound |
| As folhas rejeitam todas as observações possíveis? | Rejeição terminal | H12AffineFastState.leaf_sound; H12CertificateBridge.terminalCheck_sound e condição de suporte |
| As três instâncias estão efetivamente demonstradas? | Proposição 5.1 | H12CloudChart0/1/2.refutation e H12Final.all_chart_refutations |
| O teorema final tem hipótese oculta? | Seção 5.2 | H12Final.no_bent_quartic e seus relatórios de axiomas, incluídos em H12_final_kernel_records.zip |

## Ordem sugerida

1. Ler o enunciado e as Seções 2–5, verificando as implicações necessárias e a contradição final.
2. Conferir os apêndices matemáticos. A auditoria de transcrição refaz esses dados partindo do próprio Markdown, sem importar resultados dos filtros certificados.
3. Extrair o suplemento independente e executar `python verify.py`, sem -O. O checker Python usa quatro raízes; a prova Lean usa três após a exclusão analítica da quarta. Não somar suas contagens.
4. Examinar as fontes conceituais acima, os relatórios de axiomas e a composição final. Só então decidir se é necessária uma reconstrução integral do Lean.

O tempo de 139 segundos pertence ao replay independente observado em uma máquina. Não é promessa sobre reconstrução Lean ou tempo de revisão humana. O pacote formal conserva fontes exatas; a configuração Lake mínima de distribuição não foi reconstruída integralmente nesta preparação.

As auditorias são produzidas nesta pesquisa e não constituem revisão humana independente. Os logs preservados facilitam a inspeção, mas uma avaliação adversarial deve confrontar definições, implicações e fontes.

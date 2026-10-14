# V1 — funções bent homogêneas simétricas por rotação

**Origem congelada:** [audit/v1-release-gates-2026-10-11](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/db3d5b9f385dc96adf7df3f0a0483d4c611d90e8/README.md) (`db3d5b9f385dc96adf7df3f0a0483d4c611d90e8`).

## Arquivos copiados

- [Manuscrito cúbico global](manuscritos/paper_cubic_global_submission.tex); [preprint](manuscritos/paper_arxiv_v1.tex); [manuscrito consolidado t=32](manuscritos/paper_hrsbf_consolidated.tex).
- [Certificado universal n=32](certificados/certificado_universal_n32.json), [verificador independente](certificados/audit_end_to_end_n32.py), [resultado](certificados/resultado_end_to_end_n32.json).
- [Estado de pesquisa](auditorias/RESEARCH_STATE_2026-10-06.md), [revisão de prioridade](auditorias/LITERATURE_PRIORITY_AUDIT_2026-10-06.md), [comparação Sun](auditorias/COMPARACAO_SUN_2026.md).
- [Nota de continuidade — fibras n=16, outubro de 2026](NOTA_ADENDO_FIBRAS_2026-10-14.md).
- [Parecer de originalidade — 14/10/2026](auditorias/PARECER_PRIORIDADE_PTBR_2026-10-14.md), importado integralmente do arquivo de conversa com atribuição, mas não submetido à arbitragem externa.

## Distinguir afirmação e evidência

O manuscrito reivindica não existência cúbica homogênea RS bent em toda dimensão par com a regra antipodal e redução de ordem ímpar; a reivindicação precisa de auditoria matemática e originalidade separadas. Os certificados `n=32` são computacionais. A nova linha de fibras de graus 5 e 7 está registrada como adendo recente, mas suas provas, critérios de cobertura e prioridade bibliográfica exigem revisão editorial antes de integrar o teorema principal.

**Nunca** substituir o lema de fibras com diagonal constante por "todas as fibras de toda função bent são balanceadas"; essa hipótese é indispensável. Não tratar o controle quadrático de Maiorana–McFarland como contraexemplo ao lema condicionado.

**Pendente:** localizar e reconstruir eventuais matrizes A, b e mapeamento dos 6 certificados de Farkas, se forem reivindicados; a inspeção deste acervo não encontrou o notebook `HRSBF_n32_30_familias.ipynb`.

# V2 — índice relaxado e quarticas vetoriais

**Origem do adendo mais recente no GitHub:** [audit/v2-ultra-rigidity-2026-10-13](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/16309c4e692cf37427c189baf8e9050b64e85052/V2_graphs/auditoria_2026_10_13/README.md), commit `16309c4e692cf37427c189baf8e9050b64e85052`.

## Arquivos

- [Rascunho do manuscrito](MANUSCRIPT_DRAFT.md) e [LaTeX](manuscript/main.tex).
- [Adendo de ultrarrigidez](auditoria_2026_10_13/ADENDO_ULTRARRIGIDEZ_CERTIFICADA.md), [contagem por Burnside](auditoria_2026_10_13/BURNSIDE_QUADRATIC_EA_CLASSES.md), [instruções e gates](auditoria_2026_10_13/README.md).
- [Certificador de grupo finito](auditoria_2026_10_13/certificar_ultrarrigidez_local.py) e [contador](auditoria_2026_10_13/contagem_ea_quadraticas.py).
- [Snapshot da formalização Lean 4](lean_snapshot_2026-10-08/) proveniente, **separadamente**, do commit V3-C `01ea4b263a3cbe338df264b9d057a4edb3a980c8` sob `pesquisa_v2_quartic/lean`.

## Atenção científica

O README da auditoria registra certificado finito para a simetria local, e NÃO uma prova integral em Lean desse adendo. A bicondicional irrestrita "EA-indecomponível sse digrafo conectado após Q arbitrário" foi identificada como falsa e **não pode voltar ao manuscrito**. Qualquer afirmação de novidade depende de revisão bibliográfica. Os 31 fontes Lean são um snapshot anterior/adjacente e **não** demonstram que a versão do adendo de 13/10 foi formalizada.

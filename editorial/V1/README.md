# V1: human-readable proof and evidence

Isolated editorial revision of the antipodal necessity / homogeneous cubic preprint. Nothing in this directory is a new quartic theorem. Historical manuscripts and proof sources remain unchanged.

## Read in this order

1. `ARTIGO_SIMPLIFICADO.pdf`: complete structural proof, in English.
2. `APENDICE_PROVAS.pdf`: expanded identities, boundaries and formal map, in English.
3. `CERTIFICACAO_E_REPRODUCAO.md`: fixed source, semantic correspondence and reproduction.

Complete compilable sources: `ARTIGO_SIMPLIFICADO.tex` and `APENDICE_PROVAS.tex`. The local LaTeX editor uses `main.tex`; the appendix has a separate wrapper in `appendix/`.

The Portuguese reports are `MAPA_LOGICO_DAS_PROVAS.md`, `COMPARATIVO_ORIGINAL_VS_SIMPLIFICADO.md`, `PARECER_DO_REVISOR_SIMULADO.md`, and `RELATORIO_DE_RIGOR.md`. The reviewer report is internal self-review, not external peer review.

The mathematical simplification uses averaging directly on the quadratic radical. Its proof is supplied, but its alternate derivation is not a new Lean script. The final theorem was already certified by a different derivation with the same hypotheses and conclusion. No coefficient-folding identity is newly claimed formalized.

`EDITORIAL_CHECKS.json` records the exact finite controls and document diagnostics. `SOURCE_AUDIT.txt`, `HISTORICAL_CI.json`, `VISUAL_REVIEW.json` and `SHA256SUMS.json` record additional evidence. Integrity hashes authenticate files, not mathematical truth.

The manifest hashes text with LF line endings, as stored by Git; PDFs are hashed byte for byte. `check_editorial.py` accepts Windows CRLF checkouts by normalizing text only before checking these hashes.

No journal submission, preprint upload, or merge to main is part of this revision. Branch: `editorial/v1-human-proof-2026-10-19`.

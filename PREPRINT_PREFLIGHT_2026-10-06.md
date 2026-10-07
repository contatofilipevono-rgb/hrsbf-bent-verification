# Preprint v1 preflight — 2026-10-06

Branch: `preprint-v1-final-2026-10-06`  
Preflight source HEAD before this note: `cc067493284db05a849376a0d1c1809c681d3955`

## Result

- `paper_arxiv_v1.tex` compiled successfully with `pdflatex/latexmk`.
- Final PDF length: 9 pages.
- No undefined citations after the second LaTeX pass.
- No undefined cross-references after the second LaTeX pass.
- PDF opens cleanly and is not encrypted or scan-only.
- All 9 rendered pages were visually inspected for clipping, overlap, broken glyphs, and malformed equations; no blocking layout defect was found.
- Two nonfatal underfull-box warnings remain in the first bibliography entry; they affect spacing only and do not block submission.
- A missing `remark` environment declaration was found during preflight and fixed by adding:
  ```tex
  \theoremstyle{remark}
  \newtheorem{remark}[theorem]{Remark}
  \theoremstyle{plain}
  ```
- DOI/title checks were refreshed for the recent Sun–Shi–Liu–Fu (2026), Polujan–Kudin–Pašalić (2026), Gao–Zhang–Liu–Carlet (2012), and Chirvasitu–Cusick (2024) references; the identifiers used in the manuscript match the indexed records reviewed.

## Editorial status

The source is compile-clean for preprint purposes. The remaining caveat is scientific rather than technical: the manuscript is a preprint and has not undergone peer review. Priority wording remains literature-qualified rather than absolute.

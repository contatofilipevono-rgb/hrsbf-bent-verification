# V1: journal-style revision

This directory preserves the received Markdown and a corrected journal-style version. It concerns the universal antipodal theorem through degree three, independently of the ongoing quartic H(12,4) computation.

- [Corrected English manuscript](ARTIGO_REVISADO_AUDITADO.md).
- [PDF, seven pages](paper/ARTIGO_REVISADO.pdf).
- [Complete amsart source](paper/ARTIGO_REVISADO.tex).
- [Review of the received revision](REVISAO_DA_REVISAO.md), in Portuguese.
- [Directed bibliography audit](AUDITORIA_BIBLIOGRAFICA.md), in Portuguese.
- [Exact correction log](ALTERACOES_EXATAS.json).
- [Document and finite checks](CHECKS_JOURNAL.json).
- [Unmodified received text](ORIGINAL_RECEBIDO.md).

The statement already has a historical Lean certificate. The radical-averaging derivation has not been separately formalized. No new global Lean build, merge to main, journal submission or external preprint publication occurred in this revision.

With Python and pypdf installed, run `python check_journal.py` from this directory. Rebuild the source with `python build_journal.py`; compile `paper/ARTIGO_REVISADO.tex` using Tectonic or an ordinary LaTeX distribution. The build script reproduces the received manuscript plus the exact documented corrections.

The author's original sources and earlier editorial PDFs are retained in their existing directories. This branch does not replace the public Figshare preprint.

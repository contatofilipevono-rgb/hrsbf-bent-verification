# HANDOFF TO NEW ASTRA — FINALIZE AND PUBLISH v1

Date: 2026-10-06 / 2026-10-07 UTC boundary

## Mission

Finish the submission workflow and publish preprint v1. Do **not** reopen the mathematics from scratch and do **not** delay v1 for additional computational experiments unless a genuine fatal issue is found.

The n=12 exhaustive A100 search is a **v2** validation task, not a prerequisite for v1.

## Repository and canonical source

Repository:
`https://github.com/contatofilipevono-rgb/hrsbf-bent-verification`

Canonical v1 branch:
`preprint-v1-final-2026-10-06`

Branch HEAD immediately before this handoff file:
`cd7bdff180cfe5f4cc78fa67b74955e6b1bd2a3e`

Canonical manuscript:
`paper_arxiv_v1.tex`

The last commit that changed the canonical manuscript itself:
`2a64e060d57d2079539e8c323393b9962620b88c`

Submission-track mirror:
`paper_cubic_global_submission.tex`
(last manuscript update in that file: `9fea8cd66dc4c5850236f34206810bc961f6d529`)

## Title and theorem

Title:
**Antipodal Necessity and the Cubic Case of the Homogeneous Rotation-Symmetric Bent Function Conjecture**

Main structural theorem:
for every positive even integer n,
[
f\text{ rotation-symmetric, bent, }\deg f\le3
\Longrightarrow [P_n]f=1,
]
where
[
P_n(x)=\sum_{i=0}^{n/2-1}x_i x_{i+n/2}.
]

Immediate consequence:
**no homogeneous rotation-symmetric cubic bent Boolean function exists in any positive even dimension.**

## Proof architecture already audited

1. Odd-order fixed-space reduction:
   write n=2^s m with m odd; bentness transfers to the fixed space of the order-m rotation because derivatives are quadratic.
2. Exact orbit folding:
   `Fold(O_A)=((mb/h) mod 2) O_B` for supports of size <=3.
3. Power-of-two quadratic rigidity:
   balanced RS quadratic in N=2^k has zero polar.
4. Complementary-fiber balance.
5. Local complementary-fiber rigidity using the symmetric trilinear third difference.
6. Antipodal Rule in power-of-two dimension.
7. Exact transport back to n and contradiction with cubic homogeneity.

Final hardening also added:
- self-contained radical-J proof of quadratic antipodal necessity;
- explicit three-family folding analysis;
- t=2 boundary;
- h=3 short cubic orbit treatment;
- Frobenius/local-ring explanation X^N+1=(X+1)^N;
- explicit trilinearity argument via affine second derivatives;
- full-length cubic-orbit cancellation explanation;
- n=2 boundary.

## Independent referee status

Google Gemini:
- FATAL ISSUE: NO
- MAJOR ISSUE: NO
- MAIN THEOREM: VALID
- ANTIPODAL RULE: VALID
- ARXIV READY: YES

Anthropic Claude:
- FATAL ISSUE: NO
- MAJOR ISSUE: NO
- MAIN THEOREM: VALID
- ANTIPODAL RULE: VALID
- ARXIV READY: YES after minor clarifications

Those minor clarifications have already been incorporated.

See:
- `FINAL_REFEREE_CONVERGENCE_2026-10-06.md`
- `END_TO_END_ADVERSARIAL_AUDIT_2026_10_06.md`

## Computational controls already completed

These are evidence only; the proof is algebraic.

Antipodal Rule:
- N=4: 8 bent functions, 0 violations.
- N=8: 256 bent functions, 0 violations.

Folding formula:
direct enumeration of all cyclic monomial orbits of degree <=3 for
(6,2), (10,2), (12,4), (18,2), (20,4), (24,8), (28,4), (40,8):
674 source orbits, 0 discrepancies.

## Literature positioning

Use conservative novelty language.

Safe claim:
“To the best of our knowledge, and within the literature reviewed through October 2026, no previous result excludes homogeneous cubic rotation-symmetric bent functions uniformly in every even dimension. Our stronger antipodal theorem extends the known quadratic antipodal necessity to arbitrary rotation-symmetric bent functions of algebraic degree at most three.”

Do not write “first proof ever.”

Verified positioning:
- Cusick–Sanger Section 2 treats quadratic antipodal necessity for n=2m (all even n), while later parts focus on n=2p.
- Meng–Chen–Fu should be described conservatively as giving partial results toward the conjecture unless quoting exact verified theorems.
- Sun–Shi–Liu–Fu (2026) gives conditional cubic nonexistence results, not a uniform all-even theorem.
- Known nonhomogeneous cubic RS bent constructions do not conflict with the theorem because they contain quadratic antipodal coupling.

## Author metadata

Author:
Filipe Martins Vono

Affiliation:
Centro Universitário de Belo Horizonte (UniBH), Belo Horizonte, Brazil

ORCID:
0009-0009-4994-8533

Corresponding email:
contatofilipevono@gmail.com

## AI disclosure already in manuscript

The manuscript transparently states:
- OpenAI ChatGPT: principal AI research assistant;
- Google Gemini: more limited auxiliary adversarial reviewer;
- Anthropic Claude: additional independent adversarial referee used to attempt falsification and locate gaps;
- author retains responsibility for all claims, validation, exposition, and submission.

Do not remove this disclosure unless the author explicitly requests it.

## arXiv metadata

Primary:
`cs.CR`

Cross-list:
`math.CO`

Title:
Antipodal Necessity and the Cubic Case of the Homogeneous Rotation-Symmetric Bent Function Conjecture

Comments:
`10 pages, no figures. Preprint version 1.0. Source and audit materials: https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/tree/preprint-v1-final-2026-10-06`

Recommended license:
**arXiv.org perpetual, non-exclusive license 1.0**

Leave blank for v1:
- report number
- journal reference
- DOI

Compiler:
PDFLaTeX

Top-level upload source:
`main.tex` in the generated source package.

See:
`ARXIV_SUBMISSION_METADATA_2026-10-06.md`

## Final preflight already passed

See:
`FINAL_HARDENED_PREFLIGHT_2026-10-06.md`

Status:
- PDFLaTeX/latexmk: PASS
- 10 pages
- no undefined citations/references observed
- PDF openable, text-based, unencrypted
- visual inspection passed

Recorded final package SHA-256:
`c1f8ed340bd36ede8f3618dd438789149fc8c966dbaa1790dc2b577ab8e45fd5`

Recorded final PDF SHA-256:
`567e8ec8369d09176fa3dd3a515b15aa51eb08ada688926373779ff2969e7443`

If you regenerate the package, hashes may change because of archive/PDF metadata; verify the generated content rather than requiring identical hashes unless reproducing the exact package.

## v2 / A100 work — DO NOT BLOCK v1

Separate branch:
`colab-a100-2026-10-06`

Current queued-work branch HEAD before handoff:
`33f886ccbdea93b81b420ce3ba60ae3b270b97a3`

Added:
`rs_bent_exhaustive.py`

Queued job:
`rs_bent_n12`

Target:
`python rs_bent_exhaustive.py 12 16`

The Colab worker had not produced a status file at the last check. The author decided explicitly to move this exhaustive n=12 experiment to **v2**.

Do not wait for it before publishing v1.

## What the new Astra should do now

1. Fetch the exact canonical branch `preprint-v1-final-2026-10-06` and record its current HEAD.
2. Read `paper_arxiv_v1.tex`, `FINAL_HARDENED_PREFLIGHT_2026-10-06.md`, `FINAL_REFEREE_CONVERGENCE_2026-10-06.md`, and `ARXIV_SUBMISSION_METADATA_2026-10-06.md`.
3. Do one final mechanical submission check only:
   - source compiles;
   - no missing files;
   - title/author/abstract/AI declaration correct;
   - bibliography resolves;
   - 10-page PDF looks sane.
4. Do not rewrite or expand the proof unless an actual error is discovered.
5. Prepare/upload the TeX source package to arXiv.
6. Preview arXiv-generated PDF.
7. If the preview matches and no submission-system error remains, proceed to the final submission step with the author’s explicit action/approval if required by the interface.
8. Record the arXiv identifier and submission timestamp back in the repository after successful submission.

## Stop conditions

Stop and report instead of silently changing mathematics if:
- canonical branch cannot be fetched;
- source fails to compile;
- arXiv changes equations/text unexpectedly;
- category/endorsement blocks submission;
- a new fatal mathematical issue is found.

Otherwise: finish and submit v1.
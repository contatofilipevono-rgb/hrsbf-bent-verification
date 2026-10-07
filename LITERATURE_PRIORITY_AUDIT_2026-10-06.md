# Literature priority audit — cubic HRSBF theorem

Date: 2026-10-06  
Branch audited: `colab-a100-2026-10-06`  
Baseline manuscript snapshot rechecked before the final preprint edits: `bb412393524fab26653a52f1e0eb92fe00c84325`

## Questions

This note records a focused novelty/priority audit for two statements proved in the current manuscript:

1. **Global cubic homogeneous nonexistence:** there is no homogeneous rotation-symmetric bent Boolean function of algebraic degree 3 in any positive even dimension.
2. **Universal antipodal necessity through degree 3:** if an RS Boolean function is bent and has algebraic degree at most 3 in positive even dimension (n), then its ANF contains
   [
   P_n=sum_{i=0}^{n/2-1}x_i x_{i+n/2}.
   ]

The audit is about prior literature, not proof correctness.

## Main antecedents located

### Stănică–Maitra and early work

The original computational/theoretical program formulated the conjecture that homogeneous RS bent functions of degree greater than two do not exist. Early results treated computational ranges and restricted structural cases, including single-cycle/MRS cases.

### Meng–Chen–Fu (2010)

Q. Meng, L. Chen, F.-W. Fu, *On homogeneous rotation symmetric bent functions*, Discrete Applied Mathematics 158 (2010), 1111–1117, DOI 10.1016/j.dam.2010.02.009.

The abstract explicitly describes the results as **partial results** toward the conjectured nonexistence in degree (>2). The located indexed material does not state a uniform cubic theorem for all even dimensions.

### Zhang–Gao (2013)

X. Zhang, G. Gao, *On the conjecture about the nonexistence of rotation symmetric bent functions*, arXiv:1303.2282.

The located abstract/material presents additional supporting restrictions, not a global degree-three solution.

### Cusick–Sanger (2017)

T. W. Cusick, E. M. Sanger, *Rotation Symmetric Bent Boolean Functions for n=2p*, arXiv:1708.09313.

This is the strongest direct antecedent for the antipodal phenomenon found in the audit. In particular:
- every quadratic RS bent function in even dimension must contain the antipodal quadratic orbit (P_n);
- analogous necessity is proved for sums of short-cycle MRS functions;
- most cases of the homogeneous conjecture are treated for (n=2p), (p>2) prime.

This does **not** state the current universal theorem for arbitrary RS bent functions of degree at most 3 in every even dimension.

### Gao–Zhang–Liu–Carlet (2012)

G. Gao, X. Zhang, W. Liu, C. Carlet, *Constructions of Quadratic and Cubic Rotation Symmetric Bent Functions*, IEEE Trans. Inf. Theory 58(7) (2012), 4908–4913.

Known nonhomogeneous cubic RS bent constructions contain an antipodal quadratic coupling. This is consistent with the current theorem, but is a construction result rather than a universal antipodal-necessity theorem.

### Sun–Shi–Liu–Fu (2026) — full-text audit completed

L. Sun, Z. Shi, J. Liu, F.-W. Fu, *On the conjecture about the nonexistence of homogeneous rotation symmetric bent functions*, Designs, Codes and Cryptography 94(4), article 93 (2026), DOI 10.1007/s10623-026-01848-4.

The complete 22-page paper was checked theorem by theorem, with special attention to Section 3.3, “Nonexistence results of cubic homogeneous rotation symmetric bent functions,” and Table 1.

The cubic results are conditional:

- **Theorem 5:** for a cubic homogeneous RSBF with an even number of SANF terms, nonexistence follows under the additional valuations (v_2(r_i),v_2(s_i)ge v_2(n)).
- **Theorem 6:** for any fixed finite set of cubic generator pairs (P), there exists (e_0) such that the corresponding family is non-bent whenever (nequiv0pmod{2^{e_0}}). This excludes a divisibility subfamily of dimensions, not all even dimensions.
- **Corollary 2:** excludes cubic homogeneous RS bent functions when (n=2p_1^{n_1}cdots p_t^{n_t}) and the odd primes satisfy the paper’s strong recursive size inequalities. Again this is an arithmetic subfamily, not every even (n).

Table 1 records these cubic results as rows 16 and 17 with their explicit extra conditions. The conclusion states that solving the conjecture remains “an extremely difficult problem” and proposes further work.

Accordingly, Sun–Shi–Liu–Fu (2026) **does not contain a uniform theorem excluding homogeneous cubic RS bent functions in every positive even dimension**.

A focused full-text search also found no antipodal-orbit theorem analogous to the current statement
[
	ext{RS bent}, deg fle3Longrightarrow [P_n]f=1.
]

This materially lowers the principal overlap risk identified in the first literature pass.

### Polujan–Kudin–Pašalić (2026)

A. Polujan, S. Kudin, E. Pašalić, *Rotation-Symmetric Bent Functions Outside the Completed Maiorana-McFarland Class*, IEEE Trans. Inf. Theory 72(6) (2026), 4341–4351, DOI 10.1109/TIT.2026.3685133.

They classify RS cubic bent functions in 10 variables and obtain 1572 functions in 8 EA-equivalence classes. The published representatives displayed in their table all contain the antipodal quadratic term (x_1x_6). This is a strong independent consistency check for the current antipodal theorem in dimension 10, but the paper does not state the all-even-dimensional degree-(le3) necessity theorem.

## Priority assessment

### A. Global homogeneous cubic nonexistence

**Assessment: apparently new in the literature reviewed, but not yet safe for an absolute priority claim.**

No located earlier source states a theorem excluding homogeneous cubic RS bent functions uniformly in every positive even dimension. Earlier work found in this audit is restricted by orbit structure, support conditions, arithmetic conditions, dimension families, or is explicitly described as partial.

The principal residual bibliographic risk is Sun–Shi–Liu–Fu (2026), because it is both recent and directly targeted at the same conjecture.

### B. Universal antipodal necessity for RS bent functions of degree at most 3

**Assessment: stronger novelty signal than the homogeneous corollary.**

The known quadratic necessity (P_nsubseteqmathrm{ANF}(f)) is an established antecedent and must be credited. The audit found no prior theorem extending that necessity simultaneously to:
- arbitrary RS bent functions (not just MRS/short-cycle sums),
- algebraic degree at most 3,
- every positive even dimension.

The manuscript should present this as an extension of the known quadratic/short-cycle antipodal phenomenon, not as the discovery of the antipodal phenomenon itself.

### C. Proof architecture

No located source uses the same complete chain
[
	ext{odd-order fixed-space transfer}
	o
	ext{power-of-two antipodal rule}
	o
	ext{exact folding coefficient transport}.
]
This mechanism appears distinct in the reviewed literature. No absolute novelty claim is made.

## Recommended submission wording

Safe wording:

> To the best of our knowledge, and within the literature reviewed through October 2026, no previous result excludes homogeneous cubic rotation-symmetric bent functions uniformly in every even dimension. Our stronger antipodal theorem extends the known quadratic antipodal necessity to arbitrary rotation-symmetric bent functions of algebraic degree at most three.

Avoid until the full 2026 overlap check is completed:

> “This is the first proof ever…”

or any equivalent absolute priority statement.

## Status

- Proof correctness: independently audited elsewhere in the repository.
- Literature search result: **no prior global cubic theorem or universal degree-(le3) antipodal theorem located**.
- Priority confidence: **high** after full-text theorem-by-theorem audit of Sun–Shi–Liu–Fu (2026).\n- Follow-up indexed search on 2026-10-06 checked current web/arXiv/Springer/IEEE records for the exact homogeneous-cubic and antipodal claims; no later global theorem was located. This remains a literature-qualified conclusion, not an absolute priority guarantee.
- Remaining bibliographic check before journal submission: citation chaining from Sun–Shi–Liu–Fu’s references and later papers citing it; avoid absolute “first ever” wording unless that broader check is also completed.

# Literature priority audit — cubic HRSBF theorem

Date: 2026-10-06  
Branch audited: `colab-a100-2026-10-06`  
Starting HEAD: `af510e59ef4ea3b9cde596227864d3f9cf7b454e`

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

### Sun–Shi–Liu–Fu (2026)

L. Sun, Z. Shi, J. Liu, F.-W. Fu, *On the conjecture about the nonexistence of homogeneous rotation symmetric bent functions*, Designs, Codes and Cryptography 94(4), article 93 (2026), DOI 10.1007/s10623-026-01848-4.

This is the highest-priority overlap risk. The published abstract says that the paper obtains new nonexistence results that solve the conjecture **partially**. Focused searches in the indexed text did not locate the strings “cubic” or “degree 3”, nor a theorem statement claiming uniform exclusion of homogeneous cubics in all even dimensions.

**Caution:** the accessible indexed material is not a theorem-by-theorem reading of the complete publisher PDF. Therefore this audit does not justify an absolute “first ever” priority claim. Before submission, the complete Sun–Shi–Liu–Fu paper should be checked line by line, especially every theorem/corollary concerning degree 3.

### Polujan–Kudin–Pašalić (2026)

A. Polujan, M. Kudin, E. Pašalić, *Rotation-Symmetric Bent Functions Outside the Completed Maiorana-McFarland Class*, IEEE Trans. Inf. Theory 72(6) (2026).

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
- Priority confidence: **high but not final**.
- Required final check before journal submission: full-text theorem-by-theorem audit of Sun–Shi–Liu–Fu (2026), plus citation chaining from its references and papers citing it.

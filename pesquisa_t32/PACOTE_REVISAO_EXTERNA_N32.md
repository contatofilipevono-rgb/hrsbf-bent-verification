# Independent referee brief: homogeneous cubic RS bent functions in 32 variables

The accompanying proof claims nonexistence for every homogeneous cubic rotation-symmetric Boolean function on F₂³², with no restriction on its 155 cubic coefficients. It does not claim the full Stănică–Maitra conjecture, include nonhomogeneous cubics, or establish bibliographic originality.

Please examine `PROVA_CUBICA_N32_REVISADA.md` without treating the author's computational checks as a substitute for mathematical justification. Attempt to refute the argument or construct a counterexample to an intermediate assertion. In particular:

1. Does a proper rotation-invariant radical in the cyclic F₂ module F₂[X]/((X+1)³²) necessarily lie in im(S+I)? Does this imply that every rotation-invariant quadratic with nonzero polar is unbalanced, including arbitrary affine terms?
2. Does half-turn invariance and cubic homogeneity imply that the diagonal restriction f(u,u) vanishes identically? Does F_z(u)=D_{e(z)}f(d(u)) then have degree at most two?
3. Is the Parseval normalization Σ_z A_z²=2³² correct under bentness? Does the zero diagonal fiber force all nonzero fibers to be balanced?
4. Verify directly, using the third polarization and half-turn invariance, that B_{F_1}(u,v)=B_{D_1f}(d(u),e(v)). Check constants, characteristic-two conventions and all linear terms.
5. Does rotation invariance of the complementary fiber impose F_1(R₁₆u+e₀)=F_1(u)? Must an affine function with this invariance be constant?
6. Is this theorem, or the same argument, already implied by a published result? Compare especially Chirvasitu–Cusick (2020, 2023) and Sun–Shi–Liu–Fu (2026). Identify a precise prior theorem if it subsumes the claim.

Return a verdict distinguishing mathematical validity, adequacy of exposition, computational reproducibility and bibliographic priority. If there is a gap, identify the exact implication that fails and provide a counterexample or a missing assumption. Do not infer publication acceptance from the scope of the result.

Reproduction uses Python's standard library:

```
python3 audit_universal_n32.py certificate.json
python3 verify_universal_n32.py certificate.json independent_audit.json
python3 adversarial_review_n32.py certificate.json adversarial_audit.json
```

These scripts require `audit_all_ones_obstruction.py` and `audit_independent_cnf.py` in the same directory. Run without `-O`. The universal certificate checks all 155 cubic generators and 136 linear identities; separate controls include genuinely bent cubics after removing either homogeneity or rotation symmetry. The computational evaluators were written within the same project, so they are not an external referee review.

# ASTRA 4 — GLOBAL LEAN 4 RESEARCH MISSION
## Full antipodal necessity theorem for homogeneous rotation-symmetric bent functions

**Author / provenance:** Scientific manuscript by Filipe Martins Vono. Preserve author attribution. This file is a research assignment, not a claim of proof.

**Repository:** https://github.com/contatofilipevono-rgb/hrsbf-bent-verification  
**Starting branch:** `formal/antipodal-global-completion-2026-10-14`  
**Last clean certified CI known when this mission was written:** https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/38671993921  
**Formalization status:** `formalization/GLOBAL_BRIDGE_STATUS.md`  
**Focused quadratic subtask:** `formalization/ASTRA_MISSION_LEMMA_5_1.md`  
**Elementary cyclic route:** `formalization/CYCLIC_NAKAYAMA_ROUTE.md`  
**Paper:** `publications/v1-audited-2026-10-14/paper/antipodal_necessity_v1_2.tex` on `audit/a100-results-2026-10-14`  
**Environment:** pinned Lean 4.15.0 and Mathlib `9837ca9d65d9de6fad1ef4381750ca688774e608`; read the actual checked-in `lean-toolchain` and `lake-manifest.json`.

> **IMPORTANT: This is the GLOBAL mission, not only Lemma 5.1. Continue until a kernel-checked theorem matching the manuscript's universal antipodal conclusion is obtained, or report the exact mathematical or implementation blocker. Do not stop merely because the quadratic rigidity lemma passes.**

### A. Exact universal mathematical target

For every even dimension `n = 2h >= 2`, every Boolean function `f : (Fin n → ZMod 2) → ZMod 2` which is rotation-symmetric, bent (its integer Walsh transform at all frequencies has absolute value `2^h`), and has algebraic degree at most three, prove that its *canonical ANF* contains the antipodal quadratic orbit with coefficient 1. In manuscript notation: `[P_n] f = 1`.

Consequent corollary: No **homogeneous cubic** rotation-symmetric Boolean function is bent in any even dimension.

Crucial qualifications:
- `[P_n]` must be defined from the unique ANF coefficient, accounting carefully for orbit length `h`; do not silently identify it with an arbitrary pair of variables or a sum that can cancel modulo two.
- Include affine, constant and lower-degree terms in the **necessary** statement; prove the homogeneous cubic conclusion as a genuine corollary.
- A statement about all `h ≥ 1` cannot be replaced with tests for fixed `n`, a few powers of two, a conditional theorem, or a theorem over merely `h+1` without relating parameters.
- Explicitly handle the small `n=2` boundary and short monomial orbits / exceptional periodic patterns.

### B. Required research workflow — four pillars + integration

**1. Finish unconditional quadratic rigidity (the Lema 5.1 currently assigned).**
- Under `N = 2^k`, a genuinely cyclic coordinate shift `S` on `V=F₂^N`, third difference zero and `Q ∘ S = Q`, prove:
  `balanced Q → ∀ a b, polar Q a b = 0`.
- Reuse **already kernel-checked** `QuadraticPolar.lean`, `QuadraticRadical.lean`, `QuadraticGauss.lean`, `QuadraticBalanceBridge.lean`, `RadicalInvariant.lean`, `PowerTwoNilpotence.lean`, `NilpotentNakayama.lean` and `NilpotentHyperplane.lean`. Do not re-prove these without a substantive reason.
- Most immediate concrete tasks: (a) `S^(2^k)=I` for the actual cyclic shift; (b) `im(S+I)=ker(parity)` via explicit cyclic prefix-sum recurrence including wraparound; (c) instantiate proper-radical and nilpotent-hyperplane results to eliminate the assumed `himage` from the **final quadratic theorem**.
- If the elementary proof fails, try the local algebra `F₂[X]/((X+1)^N)` independently, but verify the ideal/unit claims and the cyclic module isomorphism.

**2. Power-of-two antipodal implication.**
- Formalize the manuscript's full diagonal identity and derivative/balance argument from actual bentness, degree≤3, and RS symmetry.
- Derive, rather than postulate, hypotheses currently called `hd` and `hz` in `Antipodal/Main.lean` (or replace them with an equivalent proven route).
- Combine the unconditional Lema 5.1 with the existing complementary-fiber contradiction, obtaining antipodal necessity for `n=2^s` and showing why the `s=1` endpoint is valid.
- Test for misleading variance under adding affine terms; distinguish functions, homogeneous polynomials, and their unique ANFs.

**3. Odd-order fixed-space reduction.**
- Given `n = 2^s m` with `m` odd and `s≥1`, choose the correct odd-order rotation subgroup. Construct its fixed-point subspace and explicit `F₂`-linear identifications.
- Prove that the restriction of a rotation-invariant bent function of degree≤3 remains bent, using a fully explicit Walsh/character-sum decomposition and degree transport. Do **not** assume the conclusion from invariance alone: check all hypotheses of the general fixed-space lemma.
- Prove restriction preserves rotation symmetry with the expected smaller cycle and keeps algebraic degree≤3.

**4. Exact antipodal ANF coefficient transport.**
- Give a combinatorial proof, preferably in Lean, of the ANF monomial orbit/fiber counting under restriction to the odd-order fixed space.
- Treat degree drops under variable identifications, cubic repetitions in characteristic two (`x_i^2=x_i`), stabilizer lengths, short orbits, and possible duplicate cancellation.
- Prove the target smaller-dimensional antipodal coefficient equals the original `[P_n] f`, not merely that coefficients are related under additional assumptions.
- Connect with the existing proven parity lemmas in `OddMultiplicity.lean`.

**5. Assemble the universal theorem and homogeneous cubic corollary.**
- Create a canonical interface defining a dimension-uniform rotation operator, `IsRotationSymmetric`, `HasAlgebraicDegreeAtMostThree`, `IsBent`, `antipodalANFCoefficient`, and `IsHomogeneousCubic`. Prefer reusable definitions already in the repository and prove equivalences to manuscript conventions.
- State the exact universal theorem with **no extra structural assumptions** like constant diagonal, vanishing derivative polar, radical inclusion, a presumed coefficient value, or pre-assumed bentness of a restricted function. Its only non-arbitrary assumptions must be those in the paper.
- Prove the nonexistence of homogeneous cubic RS bent functions as a kernel theorem derived from the universal result. Verify equivalence of homogeneous degree 3 and absence of quadratic ANF coefficients.
- Ensure the proof does not become vacuous due to impossible or excessively restrictive side conditions.

### C. Independent adversarial verification (not optional)

Before or during proof construction:
- Inspect every mathematical lemma in the manuscript, not just code elaboration: find implicit assumptions, order-of-quantifier issues, circularity, coefficient sign and normalization errors, and small-dimensional exceptions.
- Attempt targeted brute-force counterexample searches in small dimensions and exact integer checks; report any genuine counterexample immediately with the full truth table/ANF and reproducible script. Computation is falsification/validation support, **never** a substitute for the general kernel theorem.
- Stress-test the odd-order bent-preserving restriction independently: if false as stated, characterize the missing hypotheses or revise the manuscript, instead of manufacturing Lean assumptions that hide the error.
- Check affine shifts, alternating polars, Walsh square normalization, short cubic orbits, and the distinction between zero-frequency balance and global bentness.
- Consult relevant prior work to distinguish original contribution from established lemmas. Use correctly attributed citations and never invent paper links or peer-review outcomes.

### D. GitHub preservation and parallel research

- Make a **NEW isolated branch**, e.g. `formal/astra-global-antipodal-2026-10-15`, starting from an explicitly recorded current SHA. Never force-push, rewrite past commits, or edit the historical manuscripts in place.
- Publish certified components incrementally with substantive descriptive commits and small reusable modules. All major discoveries need a real git SHA and permanent links.
- Document dependencies and provenance, theorem signatures, exact Lean/Mathlib environment, tested commit SHA, CI run URLs, and commands. Keep a visible `OPEN_GAPS.md` with accurate status.
- Prefer complementary work to duplicating existing successful certificates. If another worker updates the starting branch, avoid blind merges; compare SHA, changes, proof assumptions, and reproducibility.
- The repository is not itself journal/arXiv publication. Do not claim acceptance, priority or formal proof certification based solely on a PDF or screenshots.

### E. Non-negotiable Lean certification and release gates

For **every important theorem**, especially the global result:
1. Pin the exact toolchain and Mathlib, run `lake build`, then `lake env lean <path>.lean` on a clean checkout. Record command exit code.
2. Run `#print axioms <fully-qualified-global-theorem>` and `#print axioms` for intermediate bridge theorems; standard `propext`, `Classical.choice`, `Quot.sound` can be accepted when genuine. No `sorryAx`, `Lean.ofReduceBool` or additional unreviewed axioms.
3. Forbid `sorry`, `admit`, `axiom`, `unsafe` proof shortcuts, disguised axioms, tautological restatements, `native_decide` as proof of general claims, and `by decide` covering only finitely many cases while stated as universal.
4. Run one independent clean CI build on the new branch and check the resulting job logs for actual success. A successful `lake build` of modules not importing the new global file is **insufficient**; ensure the global theorem file is a built target.
5. Show the full Lean theorem statement and map each premise to the paper; explain exactly why no unresolved case survives.

If the theorem fails: **do not label the paper proven**. Preserve the last passing commit; publish adversarial findings and exact remaining type goals, mathematical hypotheses still unproved, and the smallest reproducible failing case. A progress claim must distinguish: manuscript-level reasoning, computation, Lean conditional lemmas, and Lean proof of the complete global statement.

### F. Mandatory final deliverables

A. `FINAL_STATUS_GLOBAL.md`: global result PROVED / NOT PROVED, evidence, limitations, detailed milestones.
B. `PROOF_DEPENDENCIES.md`: dependency DAG from manuscript hypotheses to the final statement.
C. `GAP_REGISTER.md`: every unproved assumption or failure, with severity and next step.
D. Lean source modules with no placeholders in purported proofs and an end-to-end `lake build` CI.
E. `KERNEL_CERTIFICATE.md`: exact theorem signature, git SHA, toolchain versions, `#print axioms` output and GitHub Actions run URL.
F. `COUNTEREXAMPLES.md`: adversarial searches/results, with exact scripts/certificates where available.
G. Manuscript correction proposal only when a mathematical discrepancy is actually found, with line-level rationale and no silent alteration of the public preprint.
H. Concise summary in **Portuguese** covering what is truly proved, what remains, how to reproduce, and the implications for an arXiv/journal submission.

**Priority rule:** Continue through (1)–(5) within your available compute/context budget. Do not stop after the first success. If budget runs out, commit all genuinely validated work and state precisely what is still missing. Never fabricate kernel output, commits, links, research novelty, or global certainty.

## One-line handoff

**Complete the entire universal antipodal theorem in Lean 4, not merely quadratic rigidity; audit and preserve each step, report any counterexample or blocker honestly, and publish reproducible kernel evidence in an isolated branch.**

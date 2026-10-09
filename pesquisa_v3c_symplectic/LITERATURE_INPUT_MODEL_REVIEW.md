# Input-model comparison and manuscript self-review

Date: 2026-10-09. Audited V3-C source: `cd29f92c06f5a02122649765acb3a926a86793c3`.
This is a further review by the continuing agent, not an independent referee
report. The review changes prose and citations; it introduces no new theorem.

## Kaleyski–Sunde: frozen implementation, unresolved full paper

The official ePrint 2026/940 abstract remains accessible. Another direct PDF
request returned HTTP 403, and the official version-history page also returned
403 through the retriever. The full text has not been read. No assertion is
made that a particular theorem is absent from it.

The authors' public implementation was cloned read-only and fixed at:

`c9cec6515b3297abf5c15fedd23e55b43f2ba888`.

| File inspected | Git blob SHA-1 | Role |
|---|---|---|
| `README.md` | `22cb54b9480da9be009f12218879e77625813660` | Documented table and polynomial inputs |
| `python/_ccz_inputs.py` | `127436dcddaafbfd54bb9949e5c63b945b74ccb3` | `_normalize_inputs` |
| `python/ccz.py` | `e3d9a9409527a2ab66f187988192954b30a33c91` | `ea_equivalence` calls normalization before either search dispatch |

The polynomial branch sets N to the field degree and the output dimension to
N, then materializes 2^N values using `for x in range(1 << n)`.
EA search dispatch follows normalization. Rectangular inputs use explicit
tables. This frozen wrapper expands polynomial inputs; it supplies no
compact-ANF-only path through that branch.

This is static inspection, not a benchmark or execution of EA search.
Other interfaces and theoretical algorithms remain unassessed. No lower
bound on the paper's algorithm or performance advantage of our Lean
classification proof is inferred.

Permanent links:

- https://github.com/zskiley/CCZ-EA-equivalence/blob/c9cec6515b3297abf5c15fedd23e55b43f2ba888/python/_ccz_inputs.py
- https://github.com/zskiley/CCZ-EA-equivalence/blob/c9cec6515b3297abf5c15fedd23e55b43f2ba888/python/ccz.py
- https://github.com/zskiley/CCZ-EA-equivalence/blob/c9cec6515b3297abf5c15fedd23e55b43f2ba888/README.md

Reproduce in a separate directory, without changing V3-C:

```sh
git clone https://github.com/zskiley/CCZ-EA-equivalence.git ks-review
git -C ks-review checkout --detach c9cec6515b3297abf5c15fedd23e55b43f2ba888
git -C ks-review hash-object README.md python/_ccz_inputs.py python/ccz.py
```

Read `_normalize_inputs` and `ea_equivalence`; no Sage installation or search
execution is required for this source inspection.

## Additional derivative-based prior methodology

Canteaut–Couvreur–Perrin, *Recovering or Testing Extended-Affine Equivalence*,
arXiv:2103.00078v3 (16 May 2022), was retrieved as a complete PDF; the review
inspected selected statements in Sections 3 and 4.1.2. Section 3
uses quadratic Jacobians. Section 4.1.2 defines the ortho-derivative for
quadratic APN maps, and Proposition 36 gives its EA transport. These provide
a concrete derivative-based comparison, distinct from our quartic
zero-pair contraction and directed mixed-third-difference detector. This
comparison supports precise positioning, not a novelty verdict.

Primary source: https://arxiv.org/pdf/2103.00078v3

Downloaded PDF SHA-256:
`58cdbd13d7c9e9766ae8b5ac8ede27496ba82787837dc88f9448ccff8375c057`.
The external PDF is not copied into the repository; retrieve the versioned
primary source to reproduce the comparison.

## Manuscript-to-Lean correspondence review

| Manuscript item | Source examined | Finding |
|---|---|---|
| Seed and polarization | `Polarization.lean`, `Contraction.lean` | The two-pair Pluecker argument covers m=2; no symplectic-stabilizer assumption is inserted. |
| Block recovery | `Blocks.lean` | Expanded the prose proof to explain whole-block membership, selection of a target block, and injectivity of the assignment. |
| Canonical classification | `GraphClassification.lean`, `GraphEATransport.lean`, `GraphEdgeRecovery.lean` | Common finite vertex type and looplessness are retained; ordinary EA translations and affine correction are included. |
| Output recovery | `GraphOutputRecovery.lean` | Input block i maps to π(i), while `(B y)i=y(π(i))`; the inverse orientation is respected. |
| Radical dimension | `KernelDimension.lean` | The quantified actual fourth derivative is matched; support counts nonzero blocks. |
| Exact relaxed index | `GraphRelaxedIndex.lean`, `GraphQuadratic.lean` | Upper bound uses projection ranks; lower witness uses local pair index 1, disjoint from coupling pair index 0. |
| Quadratic robustness | `GraphQuadratic.lean` | Explicit quadratic ANFs discharge the derivative condition; no separate degree-API bridge is claimed. |
| EA product obstruction | `GraphSplitting.lean`, `GraphIndecomposability.lean` | Both input factors are nontrivial; arbitrary linear output mixing is allowed. Cut convention and missing converse are retained. |

No contradiction between these statements and the draft was found in this
pass. This conclusion does not replace a human independent mathematical review.
The changed block proof follows the existing compiled argument; no proof
module was modified. Earlier publication-review notes remain a historical
record; the frozen input-path observation here advances their initially
README-only comparison.

## Remaining tasks

1. Full 2026/940 theorem-level comparison is still pending.
2. Novelty of this exact family, recovery theorem, and robust indecomposability
   is still open; screening selected neighbors is not an exhaustive search.
3. Authorship, independent review, journal formatting, and submission remain
   to be completed. Do not describe the Markdown manuscript as submitted.
4. No new Lean theorem is claimed by this documentation advance. The full
   build and all three audits exited 0. Logs are in
   `lean/logs/continuation/manuscript-review-*.log`. Audited declarations use
   only `propext`, `Classical.choice`, and `Quot.sound`. The old linter warnings
   remain; no proof or configuration was changed.

# Research update: coordinate-subspace coverage and literature audit

The seven-coordinate zero-subspace criterion excludes exactly 38,520,999 coefficient vectors, including zero, from H(12,4). Two exact counting methods agree. This is not a global nonexistence result or an additional Lean coverage claim.

Read [the progress record](EVOLUCOES_2026_10_18.md) for the proof of the criterion, the comparison with Sun–Shi–Liu–Fu (2026), and its limits. The [corrected literature review](ANALISE_E_TRECHOS_PARA_ARTIGO.md) contains proposed article paragraphs. The publisher PDF is not redistributed.

## Reproduce

Python 3.10 or newer, standard library only. From this directory:

```sh
python audit_coordinate_faces.py --out reports
python review_literature_checks.py --out reports
```

The reports include the hash of the script used. Elapsed time is machine-dependent. MANIFEST.json records hashes of this checkpoint's files before reproduction; regenerated reports may differ in timing.

The finite Ward check confirms the stated 136,697 conditions; it does not prove the odd-order reduction lemma. A separate FWHT checks the quadratic counterexample to the claim that a low-degree restriction alone excludes bentness.

This package is separate from the active Lean workflow, which continues checking a concrete chart. Do not add these counts to existing filter counts without resolving overlap.

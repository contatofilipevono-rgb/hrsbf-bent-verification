# Adversarial checks

No counterexample to the requested theorem was found in these checks. They are falsification support, never a universal proof.

`adversarial.py` exhausts all RS Boolean functions of degree≤3 for n=2,4,6,8, including affine and constant terms. `exhaustive_n10.json` records the separately executed exact n=10 family.

| n | Functions tested | Bent | Bent without antipodal coefficient |
|---|---:|---:|---:|
| 2 | 8 | 4 | 0 |
| 4 | 32 | 8 | 0 |
| 6 | 512 | 48 | 0 |
| 8 | 8192 | 256 | 0 |
| 10 | 524288 | 6336 | 0 |

Total: 533032 functions and 6652 bent functions. Walsh transforms use int64 and exact square equality. Truth tables are evaluated from squarefree ANFs. No floating-point decisions or probabilistic claims are used.

The script also exhausts all 65536 degree≤3 functions invariant under the order-3 rotation by two coordinates in n=6. This intentionally tests more than full RS symmetry. All 5120 bent functions restrict to bent functions on the two-dimensional fixed space.

Eight odd-folding parameter pairs `(n,t)=(6,2),(10,2),(12,4),(18,2),(20,4),(24,8),(30,2),(40,8)` were tested on every distinct monomial orbit of degree≤3. All 702 orbits satisfy the antipodal coefficient identity, with set-based degree reduction and duplicate cancellation. This is not a general proof.

## Reproduce

```sh
python research/astra-global-2026-10-15/adversarial.py
python -c "import runpy,json; a=runpy.run_path('research/astra-global-2026-10-15/adversarial.py'); print(json.dumps(a['exact_family'](10),indent=2))"
```

Dependency: NumPy; all operations relevant to certification are exact integer/Boolean operations. No genuine failing case was found, so no fabricated witness/truth table is provided.

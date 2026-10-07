# V2 quintic evaluator validation — 2026-10-07

Starting branch: sol-quintic-2026-10-06 at a7a292e4c092981eb8e9ec7f5580c36026209245.
Frozen v1 branch is untouched.

## Improvements
Both evaluators reject negative and out-of-basis coefficient masks. Previously a negative mask could make the compressed evaluator's bit loop fail to terminate, while the full evaluator silently interpreted out-of-range values differently.
The compressed basis is cached within one Python process, avoiding repeated construction for batch audits.

## Exact differential validation
Run: python pesquisa_t32/validate_quintic_batch.py

32 deterministic candidates (seed 20261007), including zero, extreme singleton supports, all orbits, the earlier witness, and 27 dense pseudorandom masks.
For each candidate, compared compressed output against independently built full truth tables:
- all 255 nonzero fiber weights;
- total Hamming weight and count of unbalanced fibers;
- all 35 rotation classes of diagonal derivative weights.
All comparisons passed. Four invalid-input checks passed.
Source hashes and explicit candidate masks are in quintic_batch_validation_2026-10-07.json.

This validates the implementation on these inputs. It does not enumerate 2^273 functions or prove nonexistence.
Next: construct a bounded candidate-search experiment using validated necessary conditions, and independently validate any surviving candidate with a full Walsh spectrum before calling it bent.

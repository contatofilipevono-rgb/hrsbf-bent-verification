# V2 development checkpoint — 2026-10-07

## Branch isolation
Development branch: `colab-a100-2026-10-06`.
Starting development HEAD: `ac2cfb427107c69d81a33801a7b32582e2d621f2`.
Frozen v1: `preprint-v1-final-2026-10-06` at `d70ebc8a5a6c8a4901263af24ff71cbdb2a12e93`.
No manuscript changes, no v1 commits, and no arXiv actions are part of these cycles.

## Cycle 1: reliable finite search
- Fixed the empty-survivor FWHT reshape failure, exercised by a one-candidate zero-function batch.
- Explicit CUDA selection now fails if CUDA is unavailable instead of silently running n=12 on CPU.
- Disabled TF32 for the float32 binary-generator matrix product; the n<=12 supported range has at most 25 generators, so integer sums are exactly representable.
- Added structured JSON evidence, explicit generator ordering, software/device metadata, source and identifier-file SHA-256.
- Counterexample candidates exit nonzero. Partial runs report incomplete, never consistent.

## Cycle 2: restart and worker integration
- Atomic checkpoint after first batch, every 64 batches, final batch, and controlled partial stop.
- Resume requires matching source SHA-256 and dimension; coverage counter must equal next candidate index.
- Resume tested against an uninterrupted complete n=8 run: identical IDs, no omissions or duplicates.
- Worker retries waiting_gpu jobs, avoids repeated waiting commits, accepts list/object queues, and handles missing nvidia-smi.
- Worker rejects operation outside the dedicated v2 branch.
- Worker persists declared result artifacts, including checkpoint and bent IDs; missing artifacts turn an otherwise successful job into failed.
- n=12 job revision 2 requires CUDA, uses chunk_log2=12 and saves all artifacts in results/rs_bent_n12/rev_2.
- A timeout retains the latest written checkpoint if the worker remains alive to push it. Runtime termination can lose unpushed local checkpoints. Automatic recovery of stale running/failed jobs is intentionally not enabled because concurrent workers must not duplicate work.

## Validation
Run `python -m unittest -v test_v2_controls.py`.
Six tests passed locally, including a direct integer Walsh-character oracle without the production derivative filter/FWHT.
Complete CPU results:
| n | Candidate affine representatives | Bent representatives | Including constant and RS linear |
|---|---:|---:|---:|
| 2 | 2 | 1 | 4 |
| 4 | 8 | 2 | 8 |
| 8 | 2048 | 64 | 256 |

All had zero antipodal violations and zero homogeneous cubic bent examples.
See V2_CPU_CONTROLS_2026-10-07.json for exact IDs and provenance.
No n=12 result is claimed. No CUDA execution was available in this local validation.

## Existing research outside v1
- `sol-quintic-2026-10-06`, inspected HEAD `a7a292e4c092981eb8e9ec7f5580c36026209245`: compressed quintic constraints and independent full-table auditor. Existing n=16 diagnostic used 4096 samples out of 2^273 functions; 69 survivors of two preliminary conditions were excluded by other fibers. This is sampling, not an exhaustive result.
- `quartic_falsification_strategy.md`: construction-driven search for a genuinely degree-4 RS bent function in n=10 or n=12 whose odd-order fixed-space restriction is not bent.
- `quartic_fixed_space_spectral_audit.md`: the degree-4 fixed-space transfer remains OPEN; second-derivative balance cannot be assumed.
- `RESEARCH_STATE_2026-10-06.md`: cubic proof is settled for v1; quartic research must retain separate evidence labels.

## Next autonomous cycles
1. Validate CUDA n=4/n=8 against the committed exact CPU IDs before interpreting n=12 output.
2. Run queued n=12 control (33,554,432 affine representatives), retain hashes and verify any claimed counterexample independently.
3. Extend compressed-quintic evaluator differential checks over a deterministic candidate set; do not promote samples to a global theorem.
4. Investigate structured quartic families with a nontrivial odd-order symmetry; retain the fixed-space transfer as OPEN unless proved or falsified.
5. Keep each improvement isolated and tested; never update the frozen v1 branch.

## Resuming a stopped run
Use the same source and the same output directory with `--resume`.
A failed/timed-out worker job needs an explicit queue revision/reset decision; revision changes normally select a new output directory, so preserve/copy the compatible checkpoint deliberately before restarting.

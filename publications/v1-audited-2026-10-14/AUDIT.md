# Maturity decision and independent reconstruction — 14 October 2026

## Decision

**Suitable for a public preprint with an ordinary algebraic proof and a clearly limited Lean supplement.** Not classified as a fully formalized global theorem or an accepted paper. Expert review remains the purpose of the preprint.

The conventional proof was reconstructed from the definitions. No fatal gap was found in the chain below. The author-requested condition for publication is met at the preprint level; it is not interpreted as permission to claim peer review or a journal acceptance.

## Proof dependencies checked

1. **Odd-order quadratic restriction.** P=sum(T^j) is a projection onto Fix(T). Its kernel is polar-orthogonal to the fixed space. On the radical in that kernel, invariance and oddness imply q(Pz)=q(z)=0. Therefore the kernel character-sum factor has positive square, and balance transfers in both directions.
2. **Restriction of bent functions through degree three.** Every nonzero fixed-space derivative is balanced, quadratic and invariant. Step 1 transfers this balance. Fourier inversion of autocorrelation yields bentness of the restriction. The identity automorphism and two-variable endpoint cause no exception.
3. **Quadratic rigidity in N=2^k.** The algebra F2[X]/(X^N-1)=F2[X]/((X+1)^N) is local. A proper cyclic invariant radical contains no unit, hence no odd vector; it lies in im(S+I). For r=Sy+y in that radical, Q(r)=B(r+y,y)=0. The quadratic character-sum identity then excludes balance when the polar is nonzero. Linear and constant terms were retained in this reasoning.
4. **Balance of complementary fibers.** After normalizing a constant diagonal to zero, its fiber sum already exhausts the Parseval square sum allowed by bentness. Every nonzero fiber must be balanced. The powers of two and linear coordinate substitution were checked explicitly.
5. **Rigidity of the complementary fiber.** Its cubic part vanishes with that of the diagonal. Third differences and half-rotation identify its polar with a contraction of the polar of D_Jg. When this is zero, the fiber is affine. The affine cyclic action u -> Ru+e0 forces its slope to be rotation invariant and its first coordinate to be zero; thus the entire slope is zero.
6. **Power-of-two antipodal rule.** Every cubic monomial orbit is full because its stabilizer divides both 3 and N. Half-rotation pairs the terms on the diagonal. Only the short quadratic antipodal orbit contributes parity. Without it, Steps 4 and 5 make the same complementary fiber both balanced and constant.
7. **Transport to general even n.** For a support A, its distinct orbit folds with multiplicity |O_A|/|O_B|=mb/h. Only the original antipodal quadratic orbit has odd multiplicity at the target antipodal pair. A short cubic orbit has stabilizer 3 and reduces to a singleton. For t=2, a missing antipodal term means an affine function, which cannot be bent.
8. **Homogeneous cubic corollary.** A homogeneous cubic has antipodal quadratic coefficient zero, contradicting the necessity theorem.

## Fresh finite controls

`checks/verify_structural.py` is independent of the received NumPy verifier and uses exact integer bit operations over F2, with runtime checks that remain active under Python optimization. It does not import the project validators.

- All RS quadratic components and both invariant linear components in n=4,8,16,32 pass the rigidity control. In n=32 there are 131,072 normalized candidates; no balanced candidate has nonzero polar.
- Complementary-fiber checks cover 7,35,155 cubic orbits in n=8,16,32. Their polar and nonconstant maps have identical row spaces (ranks 0,2,6, respectively).
- The n=32 trilinear control checks 155*16*16=39,680 basis contractions. By linearity these identities apply to every coefficient combination. They do not enumerate 2^155 functions or alone prove the global theorem.
- Folding controls pass for n=6,10,12,18,20,24,30,40,48,64,96.
- **Exhaustive n=12 control:** An exhaustive CUDA audit on an NVIDIA A100 GPU evaluated all $2^{25} = 33,554,432$ candidates of degree $\le 3$ in dimension 12. Exactly 14,336 affine representatives (57,344 bent functions including constant and linear terms) are bent. Exactly zero bent functions omit $P_{12}$ (`bent_without_Pn = 0`), and zero homogeneous cubics are bent (`homogeneous_cubic_bent = 0`). The full run completed with status `consistent` (SHA-256 of bent IDs: `dfc59083ce06bacae24822d167a03a47967638da1278324361980e7a0e806cd9`).
- **High-throughput n=14 control (500M functions):** A high-throughput CUDA execution on an NVIDIA A100-SXM4-40GB evaluated $500,006,912$ candidates of degree $\le 3$ in dimension 14 in $1627.36$s (~27.1 min). Out of $250,003,456$ functions surviving the Dickson–Jardine filter, exactly $25,176$ affine representatives ($100,704$ including affine terms) are bent. Exactly zero bent functions omit $P_{14}$ (`bent_without_Pn = 0`), and zero homogeneous cubics are bent (`homogeneous_cubic_bent = 0`), verifying the antipodal necessity theorem across half a billion candidates with zero violations (SHA-256 of bent IDs: `76c7d41e243b1c4c798009833220cae013de562d020e4a3df607e4103f29fd37`).
- The existing independent odd-order validator was rerun: all odd-order invertible maps and invariant normalized quadratics in dimensions 1,2,3 passed. The log is included; the script remains at the baseline repository root.

Pivot positions depend on the explicit ordering of orbit generators. The published control records its own lexicographic ordering; historical pivot lists are not treated as certificates for this run.

## Formal scope

The formal file is byte-identical to the repaired source compiled earlier in this session. Its published source SHA-256 is `ff6284e2756dfaac7f240c8d0d43bc765bfc9f308262e1aa8f8c66b6b66413cd`. All 543 axiom reports were checked. It certifies the n=12 positive control and several supporting results, **not the complete chain above**.

The universal Ward divisibility assertion and the bit-walk bridge remain formal tasks. They are no longer needed as premises of the conventional cubic nonexistence proof. Their remaining formal status must not be erased or reported as completed.

## Literature and priority

Current primary sources checked on 14 October 2026 include:

- Zhang–Gao, arXiv:1303.2282: https://arxiv.org/abs/1303.2282. Its statements concern homogeneous functions; the n=12 nonhomogeneous example does not refute those hypotheses.
- Chirvasitu–Cusick, *Quadratic rotation symmetric Boolean functions*, arXiv:2304.12734: https://arxiv.org/abs/2304.12734. It develops the earlier quadratic balancing theory; no separate novelty is claimed here for those phenomena.
- Sun–Shi–Liu–Fu, DCC 94, article 93 (2026): https://link.springer.com/article/10.1007/s10623-026-01848-4. The publisher identifies the results as partial. The existing detailed theorem comparison is retained at the repository root; this audit does not pretend that a paywalled full text was freshly retrieved.
- Wang–Liu–Zhao–Lin, ISIT 2015, 486–490: author institutional publication list https://people.ucas.edu.cn/~mcliu?language=en and DOI 10.1109/ISIT.2015.7282502.
- Polujan–Kudin–Pašalić, IEEE TIT 72(6), 4341–4351 (2026): publisher record https://ieeexplore.ieee.org/document/11483153/ and the authors' WCC 2024 presentation https://wcc2024.sites.dmi.unipg.it/SLIDES/Polujan.pdf. General cubic RS bent examples do not contradict homogeneous nonexistence.

No earlier all-even-dimensional cubic antipodal theorem was located in this targeted check. This is not an exhaustive priority guarantee. The published statement remains literature-qualified.

## Publication boundaries

This release is confined to V1/HRSBF. V2, V3-C, Foulkes–Howe and kernel-soundness research are separate. The branch is isolated from main and earlier release branches. No third-party copyrighted article PDFs, credentials, or private correspondence are included.

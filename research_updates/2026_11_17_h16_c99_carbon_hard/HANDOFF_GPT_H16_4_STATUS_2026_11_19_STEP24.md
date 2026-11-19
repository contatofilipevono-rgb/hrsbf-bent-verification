# $H(16, 4)$ Bent Verification — Complete Technical Handoff Report (Through Step 24)

**Date**: 2026-11-19  
**Repository**: `contatofilipevono-rgb/hrsbf-bent-verification` (`main` branch)  
**Working Directory**: `research_updates/2026_11_17_h16_c99_carbon_hard/`  
**Goal**: Formally close (prove UNSAT or find a bent witness for) the **3 remaining open cells** (`B0_00`, `B0_11`, `B1_11`) of $H(16, 4)$ (16-variable quartic homogeneous rotation-symmetric Boolean functions, 116 $C_{16}$-orbits, $c_{115} = 0, L = c_{99}$).

---

## 1. Executive Status (5 of 8 Cells Formally Closed; 3 Open)

| Cell `(c99, c57, c113)` | Status | Root System (`N`, `q`, `c`) | After `eta` (`L1`, 6 bits = 64 states) | Key Breakthrough |
| :--- | :--- | :--- | :--- | :--- |
| `B0_01`, `B0_10`, `B1_01`, `B1_10` | **CLOSED (UNSAT)** | `1 = 0` in `0.05s–1.06s` | — | Pure 111-var algebraic closure |
| `B1_00` `(1,0,0)` | **CLOSED (UNSAT)** | Degree-1 proof | — | $U_4$-rigidity: $q_{\texttt{0xf}} = 128 \implies K = 1 \neq c_{57} = 0$ |
| **`B0_00` `(0,0,0)`** | **OPEN (CRUMBLING)** | `N=109, q=6, c=392` (+40 `D_8`-coset cubics) | **`17/64` CLOSED DIRECTLY**; `eta=1` closes `1032/1088` pts; `eta=62,63` drop `46` pure quads in `38` `W_ess` vars; `eta=42` drops `30` pure quads in `30` vars | **Closest to 100% closure** ($f|_{D_8} \equiv 0$, normal bent!) |
| **`B0_11` `(0,1,1)`** | **OPEN** | `N=109, q=4, c=388` | `0/64` closed; **64/64 drop `+2` linears & `q=17`** inside `W_ess` (`dim=44`) | `W_ess ⊂ L2b (45)`; fixing `W_ess (k=40..44)` closes `4/4` to `1=0` in Round 1 with `57` `R`-vars free |
| **`B1_11` `(1,1,1)`** | **OPEN** | `N=109, q=4, c=387` | `0/64` closed; **64/64 drop `+2` linears & `q=17`** inside `W_ess` (`dim=45`) | `W_ess == L2b (45)`; `113×56` linear-in-`R` block `A(w)*r = b(w)` + ONLY `7` `deg_R=3` cubics |

---

## 2. Critical Bugfix Applied & Verified (Step 19 — Commit `a8266d9`)

- **Bug found via Zero-Trust contradiction in Step 18**: `add_linear_rref()` in `SOLVE_STEP9_8BRANCH_CUBIC_DROP.py` (and `rref_B`/`rref_W` in Steps 17–18) stopped at the first unseen pivot bit without first reducing other existing pivots out of `cur_v`. When pivots were inserted out of order with `verify_subst=False`, dead pivot variables could be re-introduced.
- **Fix**: `SOLVE_STEP9_8BRANCH_CUBIC_DROP.py` (`add_linear_rref`) now strictly eliminates **all** existing pivots from `cur_v` first, then picks LSB and back-substitutes (validated on `200/200` random systems + strict RREF assertions).
- **Zero-Trust Re-Audit (Step 19, Run `44449513873`, `verify_subst=True` everywhere)**: Confirmed `0` mismatches across ALL 64 `eta`-states, `W_ess_PREFIX`, `L2b_FORWARD`, `L2b_REVERSE`, and the 3-block shear basis change (`0/300` mismatches).

---

## 3. Major Structural Discoveries (Steps 12–24, 100% Zero-Trust Verified)

### A. Exact `(deg_u, deg_z)` Filtration of $h_z(u) = f(u, u+z)$ on $D_8$
- In **ALL 3 open cells**, $f|_{D_8}$ is **100% FIXED** across all of $\mathbb{F}_2^{111}$:
  - `B0_00`: $f|_{D_8} \equiv 0$ (normal bent $\implies \operatorname{wt}(h_z) = 128$ for **every** $z \in \mathbb{F}_2^8 \setminus \{0\}$ by 2-line Poisson summation!).
  - `B0_11`: $f|_{D_8}(u) = (\texttt{0x55}\cdot u)(\texttt{0xAA}\cdot u)$ (`wt=64`, Walsh `[-128:1, 0:252, +128:3]`).
  - `B1_11`: $f|_{D_8}(u)$ is the symmetric rank-4 quadratic on the 4 nibble parities (`wt=160`, Walsh `[-64:6, 0:240, +64:10]`).
- Consequently, $\deg_u(h_z) \le 3$ in all 3 cells, with exact filtration ranks in $\mathbb{F}_2^{111}$:
  - **`L1 = (deg_u=3, deg_z=1)` ($\eta(c)$)**: rank `7` (`6` free bits at root = **`64` states**).
  - `L2a = (deg_u=2, deg_z=1)`: rank `14`.
  - **`L2b = (deg_u=2, deg_z=2)`**: rank `55` (`44..45` free bits after $\eta$).
  - `L0 = (deg_u=0, deg_z=4)`: rank `35`.

### B. `eta-64` Shatters the Cubic Wall & `W_ess == L2b`
- Fixing just the **6 free bits of $\eta(c)$**:
  - **`B0_00` (+40 verified `D_8`-coset cubics)**: **`17 / 64` CLOSE DIRECTLY to `1 = 0`** (`16` from `CG(389)` + `eta=20` closed in Round 3 by the `+40 D_8`-coset cubics!). Almost every surviving state drops `13..57` quadratics (`eta=62,63`: `q=57` with **`46` pure quadratics in `38` `W_ess` vars**; `eta=42`: `28+2=30` pure quads in `30` vars; `eta=1`: `13` pure quads in `12` vars where `1032/1088` valid points close!). Only `eta=0` has `q=0` because $f \equiv 0$ lives inside `eta=0`.
  - **`B0_11` & `B1_11`**: `64 / 64` states drop `+2` linear pivots (`N: 109 -> 101`) and jump from `4 -> 17` genuine quadratics whose bilinear essential subspace `W_ess` satisfies:
    - `B0_11`: `dim(W_ess) = 44`, `rank(L2b) = 45`, **overlap = `44/44` (`W_ess ⊂ L2b`)**.
    - `B1_11`: `dim(W_ess) = 45`, `rank(L2b) = 45`, **overlap = `45/45` (`W_ess == L2b`)**.

### C. Exact 3-Block Decomposition `R_free > R_tail > W_ess` & Round-1 `1 = 0` Proof Anatomy (Steps 19–21)
Using strict-RREF two-step shear change of basis (`0/300` ZT mismatches):
- **`B1_11 (eta=0)` (`|W|=45, |T|=17, |R_free|=39`)**:
  - `RF=0, T=1, W=0, d=1`: **`17`** — ALL 17 quadratics are **exact** $y_t = Q_t(w)$ (zero `R_free`!).
  - `RF=1, T=0, W=1, d=2`: **`97`** — linear-in-`R_free`, linear-in-`W` (`M(w) * r_free = c(w)`).
  - `RF=1, T=1, W=0, d=2`: `49`.
  - `RF=2, T=0, W=0, d=2`: `145` (in 2-block `R_all`: `197` rows; `6` of them have rank-2 factorized `R^2` part, rest rank `34..48`).
  - `RF=2, T=0, W=1, d=3`: `71`.
  - `RF=3, T=0, W=0, d=3`: **ONLY `7`** (constant across all 64 `eta`-states; `dr1` ranges `73..122`!).
- **`B0_11 (eta=0)` (`|W|=44, |T|=17, |R_free|=40`)**:
  - `RF=0, T=1`: `17`; `RF=1, T=0, W=1`: `71`; `RF=1, T=0, W=2`: `7`; `RF=1, T=1`: `53`; `RF=2, T=0`: `113`; `RF=2, T=0, W=1`: `101`; `RF=2, T=1`: `2`; `RF=3`: `23` (`dr3 = 25` constant across all 64 `eta`-states in 2-block).
  - Constant right kernel: `dim(ker A(w)) = 1`, `dim(ker [A_0; A_1]) = 3` at all tested `w`.
- **Why fixing `W_ess` closes `4/4` in Round 1 (`k=40..45`)**:
  - The `deg_R <= 1` subsystem $A(w) \cdot r = b(w)$ (`113 × 56` in `B1_11`, `95 × 57` in `B0_11`) is **alone inconsistent `11/11` times** (`rank = 56/56`, `20..34` left-nullspace violations in `B1_11`; Round-1 proof uses `19..32` pure `deg_R=1` rows!).
  - Fixing `k = 40` of `W_ess` leaves `m = 5` free `w`-vars ($\binom{5}{3} = 10$ cubic `w^3` monomials vs `97` `RF=1` rows $\implies$ `87+` quadratics drop in Round 1 and collapse to `1 = 0`!).

---

## 4. Complete Catalog of Eliminated / Exhausted Paths (DO NOT REPEAT)

1. **Non-coordinate / affine $V_{11}$ degree-3 congruences** (`+0` rank above `CG(389)`, `Rank = 385`).
2. **Dense Schur-D4 at `N = 104..109`** (`CG16 = 0` identically; `CG15/CG14 = 2.38M` terms; fills 6 GB arena vs `4.6M` cols with `0` deg $\le 2$ mutants).
3. **Pure `V_3` Cube-and-Conquer (random, hi-freq, lo-freq), 2-lit hub probing, WalkSAT on `V_3`** (`k_* = 85..90`; WalkSAT floor `34..37 / 116` on `CG12`).
4. **Uniserial chain $E_9 \dots E_{14}$ splitting** (`0/12` closed even at `E_14`, `N_rem = 26`).
5. **Linear span of the `156–157` pure degree-4 $V_{13}$ Poisson equations** (`CONSTANT_1_IN_SPAN = False`; `0` real drops to degree $\le 3$ on `eta`).
6. **All 65,536 Walsh frequencies `((wt(f + a·x)) >> s) & 1` (`s = 4..7`, 20 tuples, `<0.06` FP)**: only the 8 period-4 frequencies at `s=6` have $\deg \le 3$ (the exact 1 quadratic already in root).
7. **First derivatives `((wt(D_a f)) >> s) & 1` (`s = 4..14`, `a = 0xFFFF..0x0003`)**: `0` non-constant degree $\le 3$ equations.
8. **Other 8-dim subspaces of $\mathbb{F}_2^{16}$**: `D_8` is uniquely `eval_rank = 0` (next smallest: `Even bits = 8`, which closed `0/16` in Step 18; `Half = 10`; `Adjacent pairs = 18`).
9. **`W`-only degree-4 XL on $M(w) r_{\text{free}} = c(w)$ (Step 21A)**: full rank in all 3 cells (`4462/4462`, `3195/3195`, `2160/2160` $\implies$ `0` degree-4 pure-`W` syzygies).
10. **Low-rank bilinear matrices $B_k$ in $M(w)$ (Step 21C)**: near-full rank (`43..45` in `B1_11`, `39..44` in `B0_11`; pairwise sums min rank `41`/`32`).
11. **`R`-only XL `R^3`-cancelling syzygies on `degR=2, degW=0` (Step 22B/23)**: `50` syzygies in `B1_11` stay pure degree 4 (`deg4_rank = 50/50`, `0` deg $\le 3$ mutants).
12. **Fixing rank-2 `R^2` factor subspace `F_low` (`8..12` forms) or `R_rad = R \ W_ess_R` (`4..6` vars) (Step 24)**: `closed = 0/8`, `0/16`, `max_q = 17` (`+0` drops).
13. **Dense Tseitin triple CNF into CryptoMiniSat5 on $A(w) r = b(w)$ (Step 22B)**: `53k` clauses / `18k` vars timed out even at `k_fix = 44`.

---

## 5. Highest-Leverage Next Paths to Close the Remaining 3 Cells

### Priority 1 — Close `B0_00` First (Closest to 100% Formal Closure!)
- **`17 / 64` $\eta$-states ALREADY closed directly**; Steps 22A & 24 (`B0_00`) are running right now on `eta = 62, 63, 42, 43, 2, 3, 40, 41, 1, 0`.
- **Untapped `B0_00` Normal-Bent Weapon**: For EVERY surviving $\eta$-state of `B0_00`, $h_{\texttt{0x01}}(u_1, \dots, u_7)$ (on ONLY 7 vars!) is **100% determined by `eta (6 bits)` + `L2a (14 bits)`** and MUST be balanced ($\operatorname{wt} = 64$, eliminating ~80% of `L2a` states!). Furthermore, every $C_8$-orbit $z \in \{\texttt{0xFF}, \texttt{0x55}, \texttt{0x33}, \texttt{0x11}, \texttt{0x77}\}$ has $\operatorname{wt}(h_z) = 128$ EXACTLY.
- **Additional `B0_00` degree-3/4 equations**: Check normal-bent coset weights on **9-dim and 10-dim subspaces containing $D_8$** ($D_8 \subset V_9 \subset V_{10}$ -> on $V_9 = D_8 \cup (z + D_8)$, $\operatorname{wt} = 0 + 128 = 128$, which is already sum of cosets, **BUT** on $f + a \cdot x$ for $a \notin D_8^\perp$, check exact Poisson identities!).

### Priority 2 — Crack the `W_44` / `W_45` Wall in `B0_11` and `B1_11`
The core mathematical obstacle in `B0_11` and `B1_11` is now **completely crystallized**:
- Within `CG(389)` + `eta-64`, `B0_11` and `B1_11` sit at a **101-variable block-triangular system**: `17` quads $y_t = Q_t(w)$ + `97..122` bilinear-in-$(r', w)$ equations $M(w) r' = c(w)$ + `145` quad-in-$r'$ equations + `7..25` cubic-in-$r'$ equations.
- Remember how in **`B0_00`**, adding just **`+3` genuinely new cubics** (`389 -> 392` from `D_8`-cosets) caused a **phase-transition collapse** (`eta=20` closed directly; `eta=62,63` jumped from `q=17` to `q=57` with `46` pure-`W` quads!).
- Therefore, to break `B0_11` and `B1_11` without $2^{40}$ brute force, pursue **one of three concrete angles**:
  1. **Find `+1..+10` genuinely new degree-3/4 equations for `B0_11` & `B1_11` NOT in `CG(389)`**:
     - **2-adic / Dual-bent / Autocorrelation constraints on `eta`-states**: For fixed $\eta$, $D_{(r,r)} f(u, u+z)$ is **quadratic in $u$** whose bilinear form $B_{r,z}$ is **100% FIXED by $\eta$**! Its Walsh sum $S_{r,z}$ vanishes unless $\ell_{r,z}(w) \perp \ker(B_{r,z})$ (linear in `W_ess`!). Compute the exact 2-adic valuation table of $A_f((r,r)) = \sum_z S_{r,z} = 0$ across ALL 64 $\eta$-states and ALL $r \in \mathbb{F}_2^8 \setminus \{0\}$ (`35` orbits) to extract **forced linear/Boolean constraints on `W_ess`** (`single_canceller` or small-orbit parity constraints!) and feed them into `CG(389)`!
     - **Degree-4 `V_{13}` Poisson equations (`156–157` equations from Step 11D) restricted/combined with `17` quads + `eta`**: We know their linear span alone lacks `1`, and none drop individually to degree $\le 3$ on `eta`. **UNTESTED**: Do linear combinations of the `156` $V_{13}$ degree-4 equations with the **`deg = 4` multiples of the `17` quadratics (`17 × 101`?) or the `50` / `318` `R^3`-cancelling degree-4 syzygies** drop new degree $\le 3$ mutants?!
     - **Bent-function second-order / Sylvester / Parseval / $W_f(a)^2 = 2^{16}$ identities** modulo $2^k$ on subspaces of dimension `8, 9, 10` containing $K_6$ (in `B0_11`, $f|_{H_{\text{even}}} \equiv 0$ on a **7-dim subspace** $H_{\text{even}} \subset D_8$!).
  2. **Exploit `M(w) * r' = c(w)` directly via specialized algebra / F4 / MinRank / Macaulay**:
     - Use a genuine **sparse F4 / Groebner basis engine** (e.g., `MSolve` / `FGb` / `PolyBoRi` / `SageMath` in GitHub Actions `ubuntu-latest`!) on the **exact `113 × 56` `A(w)*r = b(w)` subsystem** (or full `387`-eq `eta=0` system with elimination order `R > W`!) — `MSolve` / `PolyBoRi` uses ZDDs / F4 sparse linear algebra at degree 4–5 that dense C bit-matrices cannot reach.
  3. **Distributed Cube-and-Conquer on `B0_00` (`47` surviving $\eta$-states)**:
     - With 20 free concurrent GitHub Actions runners (`80` vCPUs, 6h/job limit!), `B0_00`'s high-`pureW` $\eta$-states can be partitioned and closed systematically once we see which states close via Steps 22A & 24.

---

## 6. Key Files & Infrastructure
- **Core algebraic engine (FIXED strict RREF)**: `SOLVE_STEP9_8BRANCH_CUBIC_DROP.py`
- **Carlet–Guillot NNF builder**: `SOLVE_STEP10_CARLET_GUILLOT_NNF.py`
- **`B0_00` +40 `D_8`-coset cubics**: `SOLVE_STEP12A_B0_00_NORMAL_BENT_CRUSH.py`
- **`(deg_u, deg_z)` filtration & `analyze_quad_system`**: `SOLVE_STEP16_LAYER2A_AND_W44_CRUSH.py`
- **Shear change of basis in C**: `SOLVE_STEP17_ELIM_ORDER_R_GT_B_SCHUR4.py`
- **Zero-Trust strict-RREF audit & 3-block**: `SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH.py`
- **Round-1 proof anatomy & `A(w)*r = b(w)`**: `SOLVE_STEP20_ANATOMY_OF_ROUND1_PROOF_AND_AW_SYZYGY.py`
- **True 3-block + `W`-XL + `B0_00` pure-W + `A(w)` anatomy**: `SOLVE_STEP21A/B/C_*.py`
- **`B0_00` formal closure & `R`-XL syzygies & Rank-2 factors**: `SOLVE_STEP22A/B_*.py`, `SOLVE_STEP23_*.py`, `SOLVE_STEP24_*.py`
- **Constraints**: Carbon (`gemini-4-carbon`) and Google Cloud credits are EXHAUSTED. GitHub Actions (`ubuntu-latest`, up to 20 concurrent 4-vCPU / 16 GB RAM runners) is 100% FREE. Always maintain Zero-Trust verification (`verify_subst=True` and random-point checks on every new equation or basis change).

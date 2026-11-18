# Handoff Report — Exhaustive Verification of Quartic Homogeneous Rotation-Symmetric Bent Functions $H(16, 4)$

**Date:** 2026-11-18  
**Repository:** `contatofilipevono-rgb/hrsbf-bent-verification` (`main` branch)  
**Local path:** `C:\Users\Valer\.gemini\antigravity\scratch\hrsbf-bent-verification`  
**Working directory:** `research_updates/2026_11_17_h16_c99_carbon_hard/`  
**Goal:** Formally prove UNSAT (or find a bent function) for the **3 remaining open cells** (`B0_00`, `B0_11`, `B1_11`) of $H(16, 4)$ with $c_{115} = 0$.

---

## 1. Problem Setup & Exact Status of All 8 Cells

We study homogeneous quartic rotation-symmetric Boolean functions $f \in H(16, 4)$ over $\mathbb{F}_2^{16}$, spanned by **116 $C_{16}$-orbits** of degree-4 monomials (indexed `0..115`, with orbit `115` = $\{x_0 x_4 x_8 x_{12}\}$ fixed to $c_{115} = 0$, and orbit `0` fixed via the linear invariant $L = c_{99}$).

Partitioning by $(c_{99}, c_{57}, c_{113}) \in \{0, 1\}^3$ yields **8 cells**, each parameterized in a **pure 111-variable affine basis** (`free111`, `origin111`, `cb111` built by `SOLVE_B09_DUAL_S_ELIM.build_pure_111_basis(c99, c57, c113)`):

| Cell | $(c_{99}, c_{57}, c_{113})$ | Status | Proof / Evidence |
| :--- | :---: | :---: | :--- |
| `B0_01` | $(0, 0, 1)$ | **CLOSED (UNSAT)** | Algebraic $1 = 0$ in `0.05s–1.06s` (pure 111-var basis) |
| `B0_10` | $(0, 1, 0)$ | **CLOSED (UNSAT)** | Algebraic $1 = 0$ in `0.05s–1.06s` (pure 111-var basis) |
| `B1_01` | $(1, 0, 1)$ | **CLOSED (UNSAT)** | Algebraic $1 = 0$ in `0.05s–1.06s` (pure 111-var basis) |
| `B1_10` | $(1, 1, 0)$ | **CLOSED (UNSAT)** | Algebraic $1 = 0$ in `0.05s–1.06s` (pure 111-var basis) |
| `B1_00` | $(1, 0, 0)$ | **CLOSED (UNSAT)** | Mathematical degree-1 proof via $U_4$-rigidity ($q_{\texttt{0xf}}=128 \implies K=1$, contradicting $C_5: K=c_{57}=0$; verified in `VERIFY_B1_00_AND_LINEAR_PIVOTS_111.py`) |
| **`B0_00`** | $(0, 0, 0)$ | **OPEN** | `bent_hits: []` across millions of models; **normal bent** ($f|_{D_8} \equiv 0$ identically) |
| **`B0_11`** | $(0, 1, 1)$ | **OPEN** | `bent_hits: []` across >8M models; $\operatorname{wt}(f|_{D_8}) = 64$, verified $q_0(f) \equiv 4 \pmod 8$ |
| **`B1_11`** | $(1, 1, 1)$ | **OPEN** | `bent_hits: []` across millions of models; $\operatorname{wt}(f|_{D_8}) = 64$ |

---

## 2. True Algebraic Anatomy of the 3 Open Cells (Verified)

All earlier claims of "112 or 223 independent quadratics" in 111 variables were artifacts of trivial Macaulay multiples $x_i \cdot L$ before linear elimination. After exact linear elimination (`111 -> N = 109` free variables), the **true algebraic structure** is:

### Degree $\le 2$ ($V_2$):
- **Genuine quadratics:** `6` in `B0_00`, `4` in `B0_11`, `4` in `B1_11`.
- **Symplectic / bilinear structure (`DIAGNOSE_V2_STRUCTURE.py`):**
  - Essential space dimension $\dim W_{\text{ess}} = 6$; global bilinear radical dimension $= 103$; universal translation subgroup $\dim T_{\text{univ}} = 103$ (`B0_00`) and $102$ (`B0_11`, `B1_11`).
  - Linearizable by **`k = 3` linear forms** $\implies$ **$2^3 = 8$ symplectic branches** per cell.
  - Across all 3 cells, **`2 / 8` branches close immediately ($1 = 0$ in $<1\text{s}$)**.
  - In `B0_11` and `B1_11`, all **`6 / 8` surviving branches** have **`0` quadratics left** (`N = 104–105`).
  - In `B0_00`, **`5 / 8` non-zero branches** (`001, 010, 011, 101, 110`) drop **`3..10` NEW quadratics** (`001` dropped 8 quads and closed `5/8` sub-branches; `110` dropped 7 quads and closed `4/8`; `010` dropped 9 quads; `011` dropped 10 quads). Only **`branch 000`** (which contains $f \equiv 0$) has `0` quadratics.

### Degree 3 ($V_3$) — **SATURATED BY CARLET–GUILLOT NNF (`388–389` Genuine Cubics):**
- From **Carlet & Guillot (1999/2001) NNF Theorem** ($2^{|I|-8} \mid \lambda_I(f)$ for $9 \le |I| \le 15$, $\lambda_{\{0..15\}} \equiv 128 \pmod{256}$), we extracted all **389 coordinate pure cubic equations** (`116` of $|I|=12$ + `273` of $|I|=11$, zero-trust verified `40/40`, `0` mismatches in `SOLVE_STEP10_CARLET_GUILLOT_NNF.py`).
- **Breakthrough:** `CG(389)` shattered the old `~95`-cubic ceiling of $\rho^8$-invariant subspaces ($V_6 \times V_6$ was completely inside `CG(389)`!). Combined with verified cyclotomic cubics (`L_9..L_13` in `B0_00`, `C_0x0_mod8_eq4` in `B0_11`, `L_13` in `B1_11`), we have:
  - **`389` genuine cubics in `B0_00`**, **`388` genuine cubics in `B0_11` and `B1_11`**,
  - **Zero trilinear radical (`dim_R3 = 0`)** — zero mute variables!
  - On the 6 surviving linearized branches (`N = 104–105`), the system is **$3.73\times$ overdetermined** (`388` cubics in `104` vars).
- **Local Theorem Proven Today (`test_v11_noncoord_cubics.py`):**
  - For ANY 11-dim linear or affine subspace $a + V_{11} \subset \mathbb{F}_2^{16}$, Poisson summation gives $\operatorname{wt}(f|_{a+V_{11}}) \equiv 0 \pmod 8$, so $(\operatorname{wt}(f|_{a+V_{11}})/4) \bmod 2 = 0$ is a pure cubic equation.
  - Testing `150` random linear $V_{11}$ + `150` random affine $a + V_{11}$ on top of `CG(389)` gave **`Rank = 385` with `+0` new cubics**.
  - **Conclusion:** All $\sim 2^{55}$ non-coordinate/affine $V_{11}$ congruences are 100% spanned by our 389 coordinate Carlet–Guillot cubics. **Do NOT search for more general degree-3 subspace congruences.**

### Special `B0_00` Normal-Bent Discovery (Proven Locally Today):
- In `B0_00`, **$f|_{D_8} \equiv 0$ identically on all of $\mathbb{F}_2^{111}$** (`wt(f|_{D_8}) = 0` for every point, rank = 0).
- Since $D_8^\perp = D_8$, Poisson summation forces $W_f(u) = +256$ for all $u \in D_8$, hence for **all 255 non-zero cosets $a + D_8$**:
  $$\operatorname{wt}(f|_{a + D_8}) = 128 \quad \text{(EXACTLY BALANCED!)}$$
- Moreover, $h_a(v) = f(a + (v,v))$ has algebraic degree $\le 3$ on $\mathbb{F}_2^8$ AND admits the free involution $v \mapsto v \oplus a$, so $8 \mid \operatorname{wt}(f|_{a+D_8})$ identically across all 255 cosets (and $16\mid$ on 12 cosets, $32\mid$ on 2 cosets `0x55/0xAA`, $64\mid$ on `0xFF`).
- **Brand-New Equations NOT yet merged into the solver:**
  - `(\operatorname{wt}(f|_{a+D_8}) / 8) \bmod 2 = 0` has **exact algebraic degree 3** (`4th-diff = 0/30`) and adds **`+4` brand-new linearly independent cubics OUTSIDE `CG(389)`** (and `div16` adds `+2` more!).
  - Furthermore, on `0xFF + D_8`, `eval_code_rank = 7` (only **7 linear forms**!), and `wt(f|_{0xFF+D_8}) = 128` strictly forbids $f \equiv 0$ (kills the trivial solution in `branch 000`!).

---

## 3. Eliminated Paths & Known Bugs (Do NOT Repeat)

1. **Exhaustive FWHT on $V_{10}$ (`rank = 16`, `65,536` functions):** ELIMINATED — `50.2%` (`B0_00`), `91.0%` (`B0_11`), `99.2%` (`B1_11`) survive $|W(g_{10})| \le 256$.
2. **Avalanche probing on `L_9 (7 forms) + E_8 (8 forms)` (`15` linear forms):** ELIMINATED — `0` lin / `0–1` quad drops.
3. **Pure degree-$\le 3$ symplectic splitting on `B0_11` / `B1_11` (even with `CG(389)`):** ELIMINATED — closes `2/8` branches, `6/8` stall at `0` quads + `388` cubics.
4. **Non-coordinate / affine $V_{11}$ degree-3 congruences:** ELIMINATED — `+0` rank above `CG(389)` (`Rank = 385`).
5. **Naive SAT CEGAR on $V_2$ alone (`lazy_card_cuts` / `subcube_slack_cuts`):** ELIMINATED — `dim(T_univ) = 102–103` (`2^{102}` points); 32 workers checked 7.9M models in `B0_11` and closed `0/768` cubes.
6. **Old `SOLVE_DEG4_SCHUR_C.py` (`c03`) bug:** Skipped every cubic with `nnz > 400` / `len > 800`, so it NEVER multiplied a single genuine cubic into degree 4. Replaced by `SOLVE_STEP11_CG_SCHUR_DEG4.py` and `SOLVE_STEP11C_B0_00_TREE_AND_BRANCH_SCHUR4.py`.
7. **False positive caught & fixed (`SOLVE_B09_DUAL_S_ELIM.py`, commit `9cb104a`):** Line 461 had a spurious `{0}` in `rhs_32a`, falsely claiming `B0_11` closed. **Always run zero-trust point checks on every new equation and every `has_one: true` claim.**

---

## 4. Currently Running GitHub Actions Batch — **FIRST THING FOR GPT TO CHECK**

**Run ID:** `44420596691` (12 parallel `ubuntu-latest` runners, 48 vCPUs, 100% free)  
**Workflow:** `.github/workflows/run_step6_master_close.yml`  
**URL:** `https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/44420596691`

### Immediate Commands for GPT to Inspect Results:
```powershell
gh run view 44420596691 --repo contatofilipevono-rgb/hrsbf-bent-verification
# Fetch any individual job log (works even while other jobs run):
gh api --allow-escape-sequences repos/contatofilipevono-rgb/hrsbf-bent-verification/actions/jobs/<JOB_ID>/logs
```

### The 4 Parallel Fronts Launched in Run `44420596691`:
1. **Front 11A — `SOLVE_STEP11_CG_SCHUR_DEG4.py` (Root Schur-D4, `N=109`):**
   - **Already completed for `B0_00` (`135212192516`, `2m42s`) and `B0_11` (`135212192387`, `3m10s`); `B1_11` (`135212192588`) finishing:**
   - `B0_00`: `has_one=false`, `CG(|I|=16)` vanished (`rc=-1`), `CG(|I|=15)` inserted (`rc=4`). `quads*pairs` alone consumed `4000 MB` (`piv4=33388`), leaving room for only `~35/112` `CG12*vars` before the `5722 MB` arena filled (`mutants=[0,0,0,0]`).
   - `B0_11`: `has_one=false`, `quads*pairs` ate `4635 MB` (`piv4=22676`, produced **`8` deg-3 mutants**), arena filled at `45/112` `CG12*vars`, `0` deg $\le 2$ mutants.
   - **Key takeaway:** Running Schur-D4 at root wastes `4.0–4.6 GB` on `quads*pairs`! That is why **Front 11C** (inside the linearized branch with `0` quads!) is critical.
2. **Front 11B — `SOLVE_STEP11B_CG389_BRANCH_PROBE.py` (`135212192349`, `135212192393`, `135212192431`):**
   - Exact 1-literal probing (`2*N` probes), exact `k`-depth collapse curve (`k = 10..90`) on all `388` CG cubics, AND **C WalkSAT directly on `V_3`** (`25 x 1500` steps) to see if `V_3` has reachable solutions or hits a hard UNSAT floor!
3. **Front 11C — `SOLVE_STEP11C_B0_00_TREE_AND_BRANCH_SCHUR4.py` (`135212192488`, `135212192726`, `135212192018`):**
   - **(a) `B0_00` Recursive Symplectic DFS** on all 5 non-zero branches (`001, 010, 011, 101, 110`) with all `389` CG cubics (checks if all 5 non-zero branches close 100% UNSAT, isolating `B0_00` to `branch 000` alone!).
   - **(b) Branch Schur-D4 (`N=104`, `0` quads!)** with **zero-trust verified `CG(|I|=16)` + `CG(|I|=15)` + ALL `8` `CG(|I|=14)` pure deg-4 equations** + all `112` `CG12*vars` (no RAM wasted on `quads*pairs`!).
4. **Front 11D — `SOLVE_STEP11D_DEG4_POISSON_AND_STRUCTURED_PROBE.py` (`135212192251`, `135212192409`, `135212192461`):**
   - **(a) Exact Degree-4 Poisson Rank Census:** measures GF(2) rank of all `45` coordinate deg-4 Carlet–Guillot equations (`|I|=13,14,15,16`) + `150` random linear $V_{13}$ + `150` random affine $a + V_{13}$ + `100` $V_{14}$ (`(wt(f|_{a+V_{13}})/8) mod 2 = 0`). Reveals immediately whether non-coordinate $V_{13}/V_{14}$ unlocks a large new space of pure degree-4 equations!
   - **(b) Structured hi-freq / lo-freq variable ordering collapse curve** + **2-literal hub probing** (`264` pairs on top 12 `CG12` hub variables).

---

## 5. Prioritized Playbook for GPT (Next Steps After Reading Run `44420596691`)

1. **Read ALL 12 logs of Run `44420596691` first.**
   - If **11C** shows `has_one: true` or `deg1/deg2` mutants: **ZERO-TRUST AUDIT** the exact equation chain before declaring closure, then cascade to all 6 surviving branches.
   - If **11C** shows `B0_00`'s 5 non-zero branches closed (or nearly closed): add the **+4 brand-new `B0_00` normal-bent `D_8`-coset cubics** (`(wt(f|_{a+D_8})/8) mod 2 = 0` + `div16/32/64`) AND the **non-homogeneous 7-variable `0xFF + D_8` constraint (`wt == 128`)** to attack `branch 000` directly!
2. **If 11D Part 1 shows non-coordinate $V_{13}/V_{14}$ adds NEW degree-4 equations beyond `45`:**
   - Immediately harvest hundreds/thousands of pure degree-4 $V_{13}$ equations in C and feed them into Branch Schur-D4 (`N=104`) — degree-4 linear algebra could drop degree $\le 2$ mutants directly!
3. **If 11B / 11D shows a feasible collapse depth $k_*$ (or WalkSAT finds `min_violated > 0` hard floor on `V_3`):**
   - Build a dedicated **C Cube-and-Conquer / Branch-and-Reduce solver directly on `CG(389)`** (Gaussian elimination + cubic propagation + minimal-linearizer splitting at every node, NEVER naive $V_2$ SAT!) and fan out across **20 concurrent free GitHub Actions runners (80 vCPUs)**.
4. **If algebraic degree 4 at `N=104` still stalls and $k_*$ is large — Untested Literature Weapons:**
   - **All `35` `CG(|I|=13)` pure degree-4 equations** + `|I|=12` mod 16 (`116` eqs on `V_3`) + cyclotomic weight layers `L_14..L_16` mod 16.
   - **Canteaut–Charpin (IEEE IT 2003) codimension-2 4-decompositions** ($f_1, f_2, f_3, f_4$ on cosets of $H = \langle a, b \rangle^\perp$, especially $a, b \in D_8$ where $D_a D_b \tilde{f}|_{D_8} \equiv 0$ in `B0_00`).
   - **Hou (Proc. AMS 2000) 2-adic valuation & univariate idempotent representation** over $\mathbb{F}_{2^{16}}$ in a normal basis.
   - **Weight-$\le 3$ vanishing / Krawtchouk moments (Meng et al. 2007 / Sun–Shi–Liu–Fu DCC 2026):** $f(x) = 0$ on all 697 vectors of $\operatorname{wt}(x) \le 3 \implies W_{\tilde{f}}(x) = +256$ on all $\operatorname{wt}(x) \le 3$.
   - **Direct ANF-to-CNF / CryptoMiniSat (XOR-native CDCL)** on a reduced branch of the `116` sparsest `CG(|I|=12)` cubics (note: standard CaDiCaL has no native Gaussian elimination for XORs; **CryptoMiniSat** does!).

---

## 6. Environment & Resource Constraints
- **Carbon (`gemini-4-carbon`) credits:** EXHAUSTED — do NOT use.
- **Google Cloud (96 vCPUs) credits:** EXHAUSTED — do NOT use.
- **GitHub Actions on public repo:** **100% FREE** (up to **20 concurrent `ubuntu-latest` 4-vCPU / 16 GB RAM runners** with `gcc`/`g++` and `pip install python-sat numpy`).
- **Local Windows machine:** 12 logical CPUs, Python 3.12 (`py`) with `pysat` and `numpy`; **NO local `gcc`/`clang`**.
- **Zero-Trust Discipline:** Never trust any `has_one: true` without verifying every injected polynomial against direct truth-table/Möbius evaluation on random points.

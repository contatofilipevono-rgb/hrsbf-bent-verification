import Mathlib.Data.ZMod.Basic
import Mathlib.LinearAlgebra.Pi
import Mathlib.Algebra.CharP.Two
import Mathlib.Tactic.Ring

/-!
Local complementary-fiber rigidity over F₂.
The polynomial hypothesis below is a concrete finite sum of products of three
 affine linear forms; constants and polynomials of smaller degree are included.
No spectral or global nonexistence theorem is asserted in this module.
-/
set_option maxHeartbeats 4000000
set_option linter.unusedSectionVars false

namespace HRSBF.Antipodal

abbrev F₂ := ZMod 2
@[simp] lemma f2_num_2 : (2 : F₂) = 0 := by decide
@[simp] lemma f2_num_3 : (3 : F₂) = 1 := by decide
@[simp] lemma f2_num_4 : (4 : F₂) = 0 := by decide
@[simp] lemma f2_num_5 : (5 : F₂) = 1 := by decide
@[simp] lemma f2_num_6 : (6 : F₂) = 0 := by decide
@[simp] lemma f2_num_7 : (7 : F₂) = 1 := by decide
@[simp] lemma f2_num_8 : (8 : F₂) = 0 := by decide
@[simp] lemma f2_num_9 : (9 : F₂) = 1 := by decide
@[simp] lemma f2_num_10 : (10 : F₂) = 0 := by decide
@[simp] lemma f2_num_11 : (11 : F₂) = 1 := by decide
@[simp] lemma f2_num_12 : (12 : F₂) = 0 := by decide
@[simp] lemma f2_num_13 : (13 : F₂) = 1 := by decide
@[simp] lemma f2_num_14 : (14 : F₂) = 0 := by decide
@[simp] lemma f2_num_15 : (15 : F₂) = 1 := by decide
@[simp] lemma f2_num_16 : (16 : F₂) = 0 := by decide

abbrev Vec (n : ℕ) := Fin n → F₂

section Differences
variable {V : Type*} [AddCommGroup V] [Module F₂ V]

def polar (f : V → F₂) (a b : V) : F₂ :=
  f (a + b) + f a + f b + f 0

def derivative (f : V → F₂) (a x : V) : F₂ := f (x + a) + f x

def third (f : V → F₂) (a b c : V) : F₂ :=
  f (a + b + c) + f (a + b) + f (a + c) + f (b + c) +
    f a + f b + f c + f 0

structure AffineExpr (V : Type*) [AddCommGroup V] [Module F₂ V] where
  linear : V →ₗ[F₂] F₂
  constant : F₂

def AffineExpr.eval (A : AffineExpr V) (x : V) : F₂ := A.linear x + A.constant

abbrev CubicTerm (V : Type*) [AddCommGroup V] [Module F₂ V] :=
  AffineExpr V × AffineExpr V × AffineExpr V

def termEval (t : CubicTerm V) (x : V) : F₂ :=
  t.1.eval x * t.2.1.eval x * t.2.2.eval x

def polynomialEval (p : List (CubicTerm V)) (x : V) : F₂ :=
  (p.map (fun t => termEval t x)).sum

def HasCubicRepresentation (f : V → F₂) : Prop :=
  ∃ p : List (CubicTerm V), f = polynomialEval p

lemma third_add_functions (f g : V → F₂) (a b c : V) :
    third (fun x => f x + g x) a b c = third f a b c + third g a b c := by
  unfold third
  ring

lemma third_term_formula (t : CubicTerm V) (a b c : V) :
    third (termEval t) a b c =
      t.1.linear a * t.2.1.linear b * t.2.2.linear c +
      t.1.linear a * t.2.1.linear c * t.2.2.linear b +
      t.1.linear b * t.2.1.linear a * t.2.2.linear c +
      t.1.linear b * t.2.1.linear c * t.2.2.linear a +
      t.1.linear c * t.2.1.linear a * t.2.2.linear b +
      t.1.linear c * t.2.1.linear b * t.2.2.linear a := by
  simp only [third, termEval, AffineExpr.eval, map_add, map_zero]
  ring_nf; simp

lemma third_term_add (t : CubicTerm V) (a b c d : V) :
    third (termEval t) a b (c + d) =
      third (termEval t) a b c + third (termEval t) a b d := by
  simp only [third_term_formula, map_add]
  ring

lemma third_polynomial_add (p : List (CubicTerm V)) (a b c d : V) :
    third (polynomialEval p) a b (c + d) =
      third (polynomialEval p) a b c + third (polynomialEval p) a b d := by
  induction p with
  | nil => simp [polynomialEval, third]
  | cons t p ih =>
    have hp : polynomialEval (t :: p) = fun x => termEval t x + polynomialEval p x := by
      funext x
      simp [polynomialEval]
    rw [hp, third_add_functions, third_add_functions, third_add_functions,
      third_term_add, ih]
    ring

lemma third_add_right {f : V → F₂} (hf : HasCubicRepresentation f) (a b c d : V) :
    third f a b (c + d) = third f a b c + third f a b d := by
  obtain ⟨p, rfl⟩ := hf
  exact third_polynomial_add p a b c d

lemma third_swap (f : V → F₂) (a b c : V) : third f a b c = third f a c b := by
  simp only [third, add_comm, add_left_comm, add_assoc]

lemma third_add_middle {f : V → F₂} (hf : HasCubicRepresentation f) (a b c d : V) :
    third f a (b + c) d = third f a b d + third f a c d := by
  rw [third_swap f a (b + c) d, third_add_right hf,
    third_swap f a d b, third_swap f a d c]

lemma polar_derivative (f : V → F₂) (a b c : V) :
    polar (derivative f c) a b = third f a b c := by
  simp only [polar, derivative, zero_add, third]
  ring

end Differences

section Fibers
variable {h : ℕ}
abbrev PairSpace (h : ℕ) := Vec h × Vec h

def diagonal (u : Vec h) : PairSpace h := (u, u)
def rightBlock (v : Vec h) : PairSpace h := (0, v)
def leftBlock (v : Vec h) : PairSpace h := (v, 0)
def swapBlocks (x : PairSpace h) : PairSpace h := (x.2, x.1)
def ones : Vec h := fun _ => 1

def complementaryFiber (g : PairSpace h → F₂) (u : Vec h) : F₂ :=
  g (u, u + ones)

lemma swapBlocks_add (x y : PairSpace h) :
    swapBlocks (x + y) = swapBlocks x + swapBlocks y := rfl

lemma third_swapBlocks (g : PairSpace h → F₂)
    (hs : ∀ x, g (swapBlocks x) = g x) (a b c : PairSpace h) :
    third g (swapBlocks a) (swapBlocks b) (swapBlocks c) = third g a b c := by
  simp only [third, ← swapBlocks_add]
  change g (swapBlocks (a + b + c)) + g (swapBlocks (a + b)) +
    g (swapBlocks (a + c)) + g (swapBlocks (b + c)) +
    g (swapBlocks a) + g (swapBlocks b) + g (swapBlocks c) +
    g (swapBlocks 0) = _
  simp only [hs]

lemma fiber_polar_eq_third (g : PairSpace h → F₂)
    (hd : ∀ u, g (diagonal u) = g 0) (u v : Vec h) :
    polar (complementaryFiber g) u v =
      third g (diagonal u) (diagonal v) (rightBlock ones) := by
  have hdiag : diagonal u + diagonal v = diagonal (u + v) := rfl
  unfold third
  rw [hdiag, hd (u + v), hd u, hd v]
  simp only [polar, complementaryFiber, diagonal, rightBlock,
    Prod.mk_add_mk, add_zero, zero_add]
  ring_nf; simp

/-- The trilinear comparison from the paper, with every summand expanded by Lean. -/
theorem fiber_polar_eq_derivative_polar (g : PairSpace h → F₂)
    (hc : HasCubicRepresentation g)
    (hd : ∀ u, g (diagonal u) = g 0)
    (hs : ∀ x, g (swapBlocks x) = g x) (u v : Vec h) :
    polar (complementaryFiber g) u v =
      polar (derivative g (ones, ones)) (diagonal u) (rightBlock v) := by
  rw [fiber_polar_eq_third g hd, polar_derivative]
  have hj : ((ones, ones) : PairSpace h) = leftBlock ones + rightBlock ones := by
    simp [leftBlock, rightBlock]
  have hv : diagonal v = leftBlock v + rightBlock v := by
    simp [diagonal, leftBlock, rightBlock]
  have hswap : third g (diagonal u) (rightBlock v) (leftBlock ones) =
      third g (diagonal u) (leftBlock v) (rightBlock ones) := by
    have ht := third_swapBlocks g hs (diagonal u) (leftBlock v) (rightBlock ones)
    simpa [swapBlocks, diagonal, rightBlock, leftBlock] using ht
  rw [hj, third_add_right hc, hswap, hv, third_add_middle hc]

/-- Zero polar of D_J g really implies zero polar of the complementary fiber. -/
theorem complementaryFiber_polar_zero (g : PairSpace h → F₂)
    (hc : HasCubicRepresentation g)
    (hd : ∀ u, g (diagonal u) = g 0)
    (hs : ∀ x, g (swapBlocks x) = g x)
    (hz : ∀ a b, polar (derivative g (ones, ones)) a b = 0) :
    ∀ u v, polar (complementaryFiber g) u v = 0 := by
  intro u v
  rw [fiber_polar_eq_derivative_polar g hc hd hs, hz]

end Fibers
end HRSBF.Antipodal

namespace HRSBF.Antipodal
section CyclicAffine

/-- Ordinary cyclic shift on the h coordinates. -/
def rotate {h : ℕ} (u : Vec h) : Vec h := fun i => u (finRotate h i)

/-- The seam flip induced on u by rotating (u,u+1). -/
def seam (n : ℕ) : Vec (n + 1) := Pi.single (Fin.last n) 1

def twistedRotate {n : ℕ} (u : Vec (n + 1)) : Vec (n + 1) := rotate u + seam n

lemma rotate_zero (h : ℕ) : rotate (0 : Vec h) = 0 := rfl

lemma rotate_single {h : ℕ} (i : Fin h) :
    rotate (Pi.single (finRotate h i) (1 : F₂)) = Pi.single i 1 := by
  funext j
  simp [rotate, Pi.single_apply, (finRotate h).injective.eq_iff]

/-- A Boolean function with zero normalized polar is affine, with its linear part explicit. -/
def linearPart {h : ℕ} (f : Vec h → F₂)
    (hz : ∀ u v, polar f u v = 0) : Vec h →ₗ[F₂] F₂ where
  toFun u := f u + f 0
  map_add' u v := by
    have hp := hz u v
    unfold polar at hp
    calc
      f (u + v) + f 0 = (f (u + v) + f u + f v + f 0) +
          (f u + f 0) + (f v + f 0) := by ring_nf; simp
      _ = (f u + f 0) + (f v + f 0) := by rw [hp]; ring
  map_smul' c u := by
    fin_cases c <;> simp [CharTwo.add_self_eq_zero]

/-- An affine function invariant under the cyclic shift with one seam flip is constant.
This is uniform in every positive dimension, not a finite exhaustive check. -/
theorem affine_twisted_invariant_constant {n : ℕ} (f : Vec (n + 1) → F₂)
    (hz : ∀ u v, polar f u v = 0)
    (ht : ∀ u, f (twistedRotate u) = f u) :
    ∀ u, f u = f 0 := by
  let L := linearPart f hz
  have hseam : L (seam n) = 0 := by
    have ht0 := ht 0
    have heq : twistedRotate (0 : Vec (n + 1)) = seam n := by
      simp [twistedRotate, rotate_zero]
    rw [heq] at ht0
    change f (seam n) + f 0 = 0
    rw [ht0]
    ring_nf; simp
  have hrot (u : Vec (n + 1)) : L (rotate u) = L u := by
    have htL : L (twistedRotate u) = L u := congrArg (fun z => z + f 0) (ht u)
    simpa [twistedRotate, map_add, hseam] using htL
  have hstep (i : Fin (n + 1)) :
      L (Pi.single (finRotate (n + 1) i) 1) = L (Pi.single i 1) := by
    rw [← hrot (Pi.single (finRotate (n + 1) i) 1), rotate_single]
  have hlast : L (Pi.single (Fin.last n) 1) = 0 := hseam
  have hzero : L (Pi.single (0 : Fin (n + 1)) 1) = 0 := by
    simpa [finRotate_last] using (hstep (Fin.last n)).trans hlast
  have hb : ∀ k (hk : k < n + 1), L (Pi.single (⟨k, hk⟩ : Fin (n + 1)) 1) = 0 := by
    intro k
    induction k with
    | zero => intro hk; exact hzero
    | succ k ih =>
      intro hk
      have hkn : k < n := by omega
      have hki : k < n + 1 := by omega
      have hs := hstep (⟨k, hki⟩ : Fin (n + 1))
      rw [finRotate_of_lt hkn] at hs
      exact hs.trans (ih hki)
  intro u
  have hu : u = ∑ i : Fin (n + 1), u i • (Pi.single i (1 : F₂) : Vec (n + 1)) := by
    ext j
    simp [Finset.sum_apply, Pi.single_apply, smul_eq_mul]
  have hLu : L u = 0 := by
    rw [hu, map_sum]
    apply Finset.sum_eq_zero
    intro i _
    rw [map_smul, hb i.val i.isLt, smul_zero]
  change f u + f 0 = 0 at hLu
  have heq := congrArg (fun z => z + f 0) hLu
  simpa only [add_assoc, CharTwo.add_self_eq_zero, add_zero, zero_add] using heq

end CyclicAffine
end HRSBF.Antipodal

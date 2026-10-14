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


namespace HRSBF.Antipodal

section PolynomialBridge
variable {V : Type*} [AddCommGroup V] [Module F₂ V]

/-- A monomial is a product of coordinate linear forms; the empty product is 1. -/
def monomialEval (m : List (V →ₗ[F₂] F₂)) (x : V) : F₂ :=
  (m.map (fun L => L x)).prod

def monomialSumEval (p : List (List (V →ₗ[F₂] F₂))) (x : V) : F₂ :=
  (p.map (fun m => monomialEval m x)).sum

private def affineOne : AffineExpr V := ⟨0, 1⟩
private def affineLinear (L : V →ₗ[F₂] F₂) : AffineExpr V := ⟨L, 0⟩

private def monomialTerm : List (V →ₗ[F₂] F₂) → CubicTerm V
  | [] => (affineOne, affineOne, affineOne)
  | [a] => (affineLinear a, affineOne, affineOne)
  | [a,b] => (affineLinear a, affineLinear b, affineOne)
  | a :: b :: c :: _ => (affineLinear a, affineLinear b, affineLinear c)

private lemma monomialTerm_correct (m : List (V →ₗ[F₂] F₂)) (hm : m.length ≤ 3) (x : V) :
    termEval (monomialTerm m) x = monomialEval m x := by
  cases m with
  | nil => simp [monomialTerm, monomialEval, termEval, affineOne, AffineExpr.eval]
  | cons a m =>
    cases m with
    | nil => simp [monomialTerm, monomialEval, termEval, affineOne, affineLinear, AffineExpr.eval]
    | cons b m =>
      cases m with
      | nil => simp [monomialTerm, monomialEval, termEval, affineOne, affineLinear, AffineExpr.eval]
      | cons c m =>
        have he : m = [] := by simpa using hm
        subst m
        simp [monomialTerm, monomialEval, termEval, affineLinear, AffineExpr.eval, mul_assoc]

/-- This supplies the degree hypothesis from an ordinary sum of monomials of length ≤ 3.
In particular, it applies to ANF written using coordinate projections.
-/
theorem hasCubicRepresentation_of_monomials (p : List (List (V →ₗ[F₂] F₂)))
    (hp : ∀ m ∈ p, m.length ≤ 3) : HasCubicRepresentation (monomialSumEval p) := by
  refine ⟨p.map monomialTerm, ?_⟩
  funext x
  unfold polynomialEval monomialSumEval
  rw [List.map_map]
  congr 1
  apply List.map_congr_left
  intro m hm
  exact (monomialTerm_correct m (hp m hm) x).symm

end PolynomialBridge
end HRSBF.Antipodal


namespace HRSBF.Antipodal

/-- Read a coordinate in the concatenation of two equally sized blocks. -/
def readPair {h : ℕ} (x : PairSpace h) (j : Fin (h + h)) : F₂ :=
  if hj : j.val < h then x.1 ⟨j.val, hj⟩
  else x.2 ⟨j.val - h, by omega⟩

/-- An actual cyclic shift of all 2h coordinates, expressed in block coordinates. -/
def blockShift {n : ℕ} (k : ℕ) (x : PairSpace (n + 1)) : PairSpace (n + 1) :=
  (fun i => readPair x ⟨(i.val + k) % ((n + 1) + (n + 1)), Nat.mod_lt _ (by omega)⟩,
   fun i => readPair x ⟨((n + 1) + i.val + k) % ((n + 1) + (n + 1)),
     Nat.mod_lt _ (by omega)⟩)

lemma readPair_left {h : ℕ} (x : PairSpace h) (i : Fin h) :
    readPair x ⟨i.val, by omega⟩ = x.1 i := by
  simp [readPair, i.isLt]

lemma readPair_right {h : ℕ} (x : PairSpace h) (i : Fin h) :
    readPair x ⟨h + i.val, by omega⟩ = x.2 i := by
  unfold readPair
  rw [dif_neg (by dsimp; omega)]
  apply congrArg x.2
  apply Fin.ext
  simp

lemma blockShift_half {n : ℕ} (x : PairSpace (n + 1)) :
    blockShift (n + 1) x = swapBlocks x := by
  apply Prod.ext
  · funext i
    change readPair x ⟨(i.val + (n + 1)) % ((n + 1) + (n + 1)), _⟩ = x.2 i
    have he : (⟨(i.val + (n + 1)) % ((n + 1) + (n + 1)), Nat.mod_lt _ (by omega)⟩ : Fin ((n+1)+(n+1))) =
        ⟨(n + 1) + i.val, by omega⟩ := by
      apply Fin.ext
      dsimp
      rw [Nat.mod_eq_of_lt (by omega)]
      omega
    rw [he, readPair_right]
  · funext i
    change readPair x ⟨((n + 1) + i.val + (n + 1)) % ((n + 1) + (n + 1)), _⟩ = x.1 i
    have he : (⟨((n + 1) + i.val + (n + 1)) % ((n + 1) + (n + 1)), Nat.mod_lt _ (by omega)⟩ : Fin ((n+1)+(n+1))) =
        ⟨i.val, by omega⟩ := by
      apply Fin.ext
      dsimp
      have hsum : n + 1 + i.val + (n + 1) = i.val + ((n+1)+(n+1)) := by omega
      rw [hsum, Nat.add_mod_right, Nat.mod_eq_of_lt (by omega)]
    rw [he, readPair_left]

lemma blockShift_one_fst {n : ℕ} (x : PairSpace (n+1)) (i : Fin (n+1)) :
    (blockShift 1 x).1 i =
      if i = Fin.last n then x.2 0 else x.1 (finRotate (n+1) i) := by
  change readPair x ⟨(i.val + 1) % ((n+1)+(n+1)), _⟩ = _
  by_cases hil : i = Fin.last n
  · subst i
    rw [if_pos rfl]
    have he : (⟨((Fin.last n).val + 1) % ((n+1)+(n+1)), Nat.mod_lt _ (by omega)⟩ : Fin ((n+1)+(n+1))) =
        ⟨(n+1)+(0 : Fin (n+1)).val, by omega⟩ := by
      apply Fin.ext
      dsimp
      rw [Nat.mod_eq_of_lt (by omega)]
    rw [he, readPair_right]
  · rw [if_neg hil]
    have hi : i.val < n := by
      have := i.isLt
      simp only [Fin.ext_iff, Fin.val_last] at hil
      omega
    have hr := finRotate_of_lt hi
    have he : (⟨(i.val+1) % ((n+1)+(n+1)), Nat.mod_lt _ (by omega)⟩ : Fin ((n+1)+(n+1))) =
        ⟨(finRotate (n+1) i).val, by omega⟩ := by
      apply Fin.ext
      dsimp
      rw [Nat.mod_eq_of_lt (by omega), show finRotate (n+1) i = ⟨i.val+1, by omega⟩ from hr]
    rw [he, readPair_left]

lemma blockShift_one_snd {n : ℕ} (x : PairSpace (n+1)) (i : Fin (n+1)) :
    (blockShift 1 x).2 i =
      if i = Fin.last n then x.1 0 else x.2 (finRotate (n+1) i) := by
  change readPair x ⟨((n+1)+i.val+1) % ((n+1)+(n+1)), _⟩ = _
  by_cases hil : i = Fin.last n
  · subst i
    rw [if_pos rfl]
    have he : (⟨((n+1)+(Fin.last n).val+1) % ((n+1)+(n+1)), Nat.mod_lt _ (by omega)⟩ : Fin ((n+1)+(n+1))) =
        ⟨(0 : Fin (n+1)).val, by omega⟩ := by
      apply Fin.ext
      dsimp
      have hs : n+1+n+1 = (n+1)+(n+1) := by omega
      rw [hs, Nat.mod_self]
    rw [he, readPair_left]
  · rw [if_neg hil]
    have hi : i.val < n := by
      have := i.isLt
      simp only [Fin.ext_iff, Fin.val_last] at hil
      omega
    have hr := finRotate_of_lt hi
    have he : (⟨((n+1)+i.val+1) % ((n+1)+(n+1)), Nat.mod_lt _ (by omega)⟩ : Fin ((n+1)+(n+1))) =
        ⟨(n+1)+(finRotate (n+1) i).val, by omega⟩ := by
      apply Fin.ext
      dsimp
      rw [Nat.mod_eq_of_lt (by omega), show finRotate (n+1) i = ⟨i.val+1, by omega⟩ from hr]
      rfl
    rw [he, readPair_right]

lemma blockShift_one_complementary {n : ℕ} (u : Vec (n + 1)) :
    blockShift 1 (u, u + ones) = (twistedRotate u, twistedRotate u + ones) := by
  apply Prod.ext
  · funext i
    rw [blockShift_one_fst]
    by_cases hil : i = Fin.last n
    · subst i
      simp [twistedRotate, rotate, seam, ones, finRotate_last]
    · simp [hil, twistedRotate, rotate, seam, ones, Pi.single_apply]
  · funext i
    rw [blockShift_one_snd]
    by_cases hil : i = Fin.last n
    · subst i
      simp [twistedRotate, rotate, seam, ones, finRotate_last, add_assoc, CharTwo.add_self_eq_zero]
    · simp [hil, twistedRotate, rotate, seam, ones, Pi.single_apply]

/-- The local rigidity lemma, for every positive half-dimension.
The degree hypothesis is an explicit list of cubic polynomial terms.
Rotation symmetry here means invariance under the actual coordinate shifts.
-/
theorem local_complementary_fiber_rigidity {n : ℕ}
    (g : PairSpace (n + 1) → F₂)
    (hc : HasCubicRepresentation g)
    (hrs : ∀ k x, g (blockShift k x) = g x)
    (hd : ∀ u, g (diagonal u) = g 0)
    (hz : ∀ a b, polar (derivative g (ones, ones)) a b = 0) :
    ∀ u, complementaryFiber g u = complementaryFiber g 0 := by
  have hs (x : PairSpace (n + 1)) : g (swapBlocks x) = g x := by
    simpa only [blockShift_half] using hrs (n + 1) x
  have hp := complementaryFiber_polar_zero g hc hd hs hz
  apply affine_twisted_invariant_constant (complementaryFiber g) hp
  intro u
  have ht := hrs 1 (u, u + ones)
  simpa only [blockShift_one_complementary, complementaryFiber] using ht

end HRSBF.Antipodal


namespace HRSBF.Antipodal
open Finset

def sign (b : F₂) : ℤ := if b = 0 then 1 else -1

lemma sign_add (a b : F₂) : sign (a + b) = sign a * sign b := by
  fin_cases a <;> fin_cases b <;> decide

lemma sign_sq (a : F₂) : sign a ^ 2 = 1 := by
  fin_cases a <;> decide

def dot {h : ℕ} (a x : Vec h) : F₂ := ∑ i, a i * x i

def character {h : ℕ} (a x : Vec h) : ℤ := sign (dot a x)

lemma dot_add {h : ℕ} (a x y : Vec h) : dot a (x + y) = dot a x + dot a y := by
  simp [dot, mul_add, sum_add_distrib]

lemma dot_comm {h : ℕ} (a x : Vec h) : dot a x = dot x a := by
  simp [dot, mul_comm]

lemma character_add {h : ℕ} (a x y : Vec h) :
    character a (x + y) = character a x * character a y := by
  simp only [character, dot_add, sign_add]

lemma character_sq {h : ℕ} (a x : Vec h) : character a x ^ 2 = 1 := sign_sq _

lemma sum_character {h : ℕ} (a : Vec h) :
    (∑ x : Vec h, character a x) = if a = 0 then (Fintype.card (Vec h) : ℤ) else 0 := by
  classical
  split_ifs with ha
  · subst a
    simp [character, dot, sign]
  · obtain ⟨i, hi⟩ : ∃ i, a i ≠ 0 := by
      by_contra hn
      apply ha
      ext i
      simpa using (not_exists.mp hn i)
    have hc : ∀ c : F₂, c = 0 ∨ c = 1 := by decide
    have hai : a i = 1 := (hc (a i)).resolve_left hi
    let e : Vec h := Pi.single i 1
    have he : character a e = -1 := by
      simp [character, dot, e, Pi.single_apply, hai, sign]
    have hs := Equiv.sum_comp (Equiv.addRight e) (character a)
    simp only [Equiv.coe_addRight, character_add, he, mul_neg_one] at hs
    rw [sum_neg_distrib] at hs
    omega

lemma character_orthogonality {h : ℕ} (x y : Vec h) :
    (∑ a : Vec h, character a x * character a y) =
      if x = y then (Fintype.card (Vec h) : ℤ) else 0 := by
  have he (a : Vec h) : character a x * character a y = character (x + y) a := by
    rw [← character_add]
    exact congrArg sign (dot_comm _ _)
  simp_rw [he]
  rw [sum_character]
  congr 1
  apply propext
  constructor
  · intro hz
    have hx := congrArg (fun z => z + y) hz
    have hyy : y + y = 0 := by ext i; exact CharTwo.add_self_eq_zero (y i)
    simpa only [add_assoc, hyy, add_zero, zero_add] using hx
  · intro hxy
    subst y
    ext i
    exact CharTwo.add_self_eq_zero (x i)

def transform {h : ℕ} (A : Vec h → ℤ) (a : Vec h) : ℤ :=
  ∑ x, A x * character a x

/-- Exact integer Parseval identity, proved by finite sums and orthogonality. -/
theorem parseval {h : ℕ} (A : Vec h → ℤ) :
    (∑ a, transform A a ^ 2) = (Fintype.card (Vec h) : ℤ) * ∑ x, A x ^ 2 := by
  classical
  have hex (a : Vec h) : transform A a ^ 2 =
      ∑ x, ∑ y, (A x * A y) * (character a x * character a y) := by
    rw [transform, pow_two, sum_mul_sum]
    apply sum_congr rfl
    intro x _
    apply sum_congr rfl
    intro y _
    ring
  simp_rw [hex]
  rw [sum_comm]
  calc
    (∑ x, ∑ a, ∑ y, (A x * A y) * (character a x * character a y)) =
        ∑ x, ∑ y, ∑ a, (A x * A y) * (character a x * character a y) := by
      apply sum_congr rfl
      intro x _
      rw [sum_comm]
    _ = ∑ x, ∑ y, (A x * A y) *
        (if x = y then (Fintype.card (Vec h) : ℤ) else 0) := by
      simp_rw [← mul_sum, character_orthogonality]
    _ = (Fintype.card (Vec h) : ℤ) * ∑ x, A x ^ 2 := by
      simp [mul_ite, sum_ite_irrel, pow_two, mul_comm, mul_left_comm, mul_assoc, mul_sum]

/-- Walsh transform in two blocks, using the actual additive characters. -/
def walshPair {h : ℕ} (g : PairSpace h → F₂) (a b : Vec h) : ℤ :=
  ∑ u, ∑ v, sign (g (u, v)) * character a u * character b v

def IsBentPair {h : ℕ} (g : PairSpace h → F₂) : Prop :=
  ∀ a b, walshPair g a b ^ 2 = (Fintype.card (Vec h) : ℤ) ^ 2

def fiberSum {h : ℕ} (g : PairSpace h → F₂) (z : Vec h) : ℤ :=
  ∑ u, sign (g (u, u + z))

lemma diagonal_walsh_eq_fiber_transform {h : ℕ} (g : PairSpace h → F₂) (b : Vec h) :
    walshPair g b b = transform (fiberSum g) b := by
  classical
  unfold walshPair transform fiberSum
  calc
    (∑ u, ∑ v, sign (g (u, v)) * character b u * character b v) =
        ∑ u, ∑ z, sign (g (u, u + z)) * character b u * character b (u + z) := by
      apply sum_congr rfl
      intro u _
      exact (Equiv.sum_comp (Equiv.addLeft u) (fun v => sign (g (u, v)) * character b u * character b v)).symm
    _ = ∑ u, ∑ z, sign (g (u, u + z)) * character b z := by
      apply sum_congr rfl
      intro u _
      apply sum_congr rfl
      intro z _
      rw [character_add]
      have hc := character_sq b u
      calc
        sign (g (u, u + z)) * character b u * (character b u * character b z) =
            sign (g (u, u + z)) * character b z * character b u ^ 2 := by ring
        _ = sign (g (u, u + z)) * character b z := by rw [hc, mul_one]
    _ = ∑ z, (∑ u, sign (g (u, u + z))) * character b z := by
      rw [sum_comm]
      simp_rw [sum_mul]

end HRSBF.Antipodal

namespace HRSBF.Antipodal
open Finset

/-- A constant diagonal of a bent function exhausts Parseval's energy.
Consequently every nonzero complementary fiber is balanced. -/
theorem complementary_fiber_balance {h : ℕ} (g : PairSpace h → F₂)
    (hb : IsBentPair g) (hd : ∀ u, g (diagonal u) = g 0) :
    ∀ z : Vec h, z ≠ 0 → fiberSum g z = 0 := by
  classical
  let C : ℤ := Fintype.card (Vec h)
  have hC : C ≠ 0 := by
    dsimp [C]
    exact_mod_cast (Fintype.card_ne_zero : Fintype.card (Vec h) ≠ 0)
  have he : (∑ z, fiberSum g z ^ 2) = C ^ 2 := by
    have hp := parseval (fiberSum g)
    have ht (b : Vec h) : transform (fiberSum g) b ^ 2 = C ^ 2 := by
      rw [← diagonal_walsh_eq_fiber_transform]
      exact hb b b
    simp_rw [ht] at hp
    have hp' : C * (∑ z, fiberSum g z ^ 2) = C * C ^ 2 := by
      simpa only [sum_const, card_univ, nsmul_eq_mul, C] using hp.symm
    exact mul_left_cancel₀ hC hp'
  have hzero : fiberSum g 0 ^ 2 = C ^ 2 := by
    have hz : fiberSum g 0 = C * sign (g 0) := by
      unfold fiberSum
      have heq (u : Vec h) : g (u, u + (0 : Vec h)) = g 0 := by
        simpa [diagonal] using hd u
      simp only [heq, sum_const, card_univ, nsmul_eq_mul, C]
    rw [hz, mul_pow, sign_sq, mul_one]
  have hrest : ∑ z ∈ (univ : Finset (Vec h)).erase 0, fiberSum g z ^ 2 = 0 := by
    have hs := sum_erase_add (univ : Finset (Vec h)) (fun z => fiberSum g z ^ 2) (mem_univ 0)
    dsimp only at hs
    rw [he, hzero] at hs
    omega
  have hall := (sum_eq_zero_iff_of_nonneg (fun z _ => sq_nonneg (fiberSum g z))).mp hrest
  intro z hz
  have hsq := hall z (mem_erase.mpr ⟨hz, mem_univ z⟩)
  exact (sq_eq_zero_iff).mp hsq

end HRSBF.Antipodal


namespace HRSBF.Antipodal

/-- The completed fiber contradiction, without a dimension-specific enumeration.
The remaining global work must derive the two structural hypotheses hd and hz.
-/
theorem not_bent_of_diagonal_and_derivative_polar_zero {n : ℕ}
    (g : PairSpace (n + 1) → F₂)
    (hc : HasCubicRepresentation g)
    (hrs : ∀ k x, g (blockShift k x) = g x)
    (hd : ∀ u, g (diagonal u) = g 0)
    (hz : ∀ a b, polar (derivative g (ones, ones)) a b = 0) :
    ¬ IsBentPair g := by
  intro hb
  have hr := local_complementary_fiber_rigidity g hc hrs hd hz
  have hones : (ones : Vec (n + 1)) ≠ 0 := by
    intro he
    have he0 := congrFun he (0 : Fin (n + 1))
    norm_num [ones] at he0
  have hbal := complementary_fiber_balance g hb hd ones hones
  have hsum : fiberSum g ones =
      (Fintype.card (Vec (n + 1)) : ℤ) * sign (complementaryFiber g 0) := by
    unfold fiberSum
    change (∑ u, sign (complementaryFiber g u)) = _
    simp_rw [hr]
    simp
  have hc0 : (Fintype.card (Vec (n + 1)) : ℤ) ≠ 0 := by
    exact_mod_cast (Fintype.card_ne_zero : Fintype.card (Vec (n + 1)) ≠ 0)
  have hs0 : sign (complementaryFiber g 0) ≠ 0 := by
    intro hs
    have hh := sign_sq (complementaryFiber g 0)
    rw [hs] at hh
    norm_num at hh
  exact (mul_ne_zero hc0 hs0) (hsum.symm.trans hbal)

/-- Same contradiction with the degree bound supplied by actual monomials. -/
theorem not_bent_of_monomials {n : ℕ}
    (p : List (List (PairSpace (n + 1) →ₗ[F₂] F₂)))
    (hp : ∀ m ∈ p, m.length ≤ 3)
    (hrs : ∀ k x, monomialSumEval p (blockShift k x) = monomialSumEval p x)
    (hd : ∀ u, monomialSumEval p (diagonal u) = monomialSumEval p 0)
    (hz : ∀ a b, polar (derivative (monomialSumEval p) (ones, ones)) a b = 0) :
    ¬ IsBentPair (monomialSumEval p) :=
  not_bent_of_diagonal_and_derivative_polar_zero _
    (hasCubicRepresentation_of_monomials p hp) hrs hd hz

end HRSBF.Antipodal


#print axioms HRSBF.Antipodal.readPair_left
#print axioms HRSBF.Antipodal.readPair_right
#print axioms HRSBF.Antipodal.blockShift_half
#print axioms HRSBF.Antipodal.blockShift_one_fst
#print axioms HRSBF.Antipodal.blockShift_one_snd
#print axioms HRSBF.Antipodal.blockShift_one_complementary
#print axioms HRSBF.Antipodal.local_complementary_fiber_rigidity
#print axioms HRSBF.Antipodal.sign_add
#print axioms HRSBF.Antipodal.sign_sq
#print axioms HRSBF.Antipodal.dot_add
#print axioms HRSBF.Antipodal.dot_comm
#print axioms HRSBF.Antipodal.character_add
#print axioms HRSBF.Antipodal.character_sq
#print axioms HRSBF.Antipodal.sum_character
#print axioms HRSBF.Antipodal.character_orthogonality
#print axioms HRSBF.Antipodal.parseval
#print axioms HRSBF.Antipodal.diagonal_walsh_eq_fiber_transform
#print axioms HRSBF.Antipodal.complementary_fiber_balance
#print axioms HRSBF.Antipodal.f2_num_2
#print axioms HRSBF.Antipodal.f2_num_3
#print axioms HRSBF.Antipodal.f2_num_4
#print axioms HRSBF.Antipodal.f2_num_5
#print axioms HRSBF.Antipodal.f2_num_6
#print axioms HRSBF.Antipodal.f2_num_7
#print axioms HRSBF.Antipodal.f2_num_8
#print axioms HRSBF.Antipodal.f2_num_9
#print axioms HRSBF.Antipodal.f2_num_10
#print axioms HRSBF.Antipodal.f2_num_11
#print axioms HRSBF.Antipodal.f2_num_12
#print axioms HRSBF.Antipodal.f2_num_13
#print axioms HRSBF.Antipodal.f2_num_14
#print axioms HRSBF.Antipodal.f2_num_15
#print axioms HRSBF.Antipodal.f2_num_16
#print axioms HRSBF.Antipodal.third_add_functions
#print axioms HRSBF.Antipodal.third_term_formula
#print axioms HRSBF.Antipodal.third_term_add
#print axioms HRSBF.Antipodal.third_polynomial_add
#print axioms HRSBF.Antipodal.third_add_right
#print axioms HRSBF.Antipodal.third_swap
#print axioms HRSBF.Antipodal.third_add_middle
#print axioms HRSBF.Antipodal.polar_derivative
#print axioms HRSBF.Antipodal.swapBlocks_add
#print axioms HRSBF.Antipodal.third_swapBlocks
#print axioms HRSBF.Antipodal.fiber_polar_eq_third
#print axioms HRSBF.Antipodal.fiber_polar_eq_derivative_polar
#print axioms HRSBF.Antipodal.complementaryFiber_polar_zero
#print axioms HRSBF.Antipodal.rotate_zero
#print axioms HRSBF.Antipodal.rotate_single
#print axioms HRSBF.Antipodal.affine_twisted_invariant_constant
#print axioms HRSBF.Antipodal.not_bent_of_diagonal_and_derivative_polar_zero
#print axioms HRSBF.Antipodal.not_bent_of_monomials
#print axioms HRSBF.Antipodal.hasCubicRepresentation_of_monomials

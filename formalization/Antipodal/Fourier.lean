import Antipodal.LocalRigidity

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

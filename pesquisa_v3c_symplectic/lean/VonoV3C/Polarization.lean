import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Abel

open scoped BigOperators

set_option maxHeartbeats 0
set_option maxRecDepth 10000

namespace VonoV3C

abbrev Scalar := ZMod 2
abbrev Vec (m : ℕ) := Fin m → (Scalar × Scalar)

def diff {V : Type*} [Add V] (a : V) (f : V → Scalar) (x : V) : Scalar :=
  f (x + a) + f x

def fourth {V : Type*} [Add V] (f : V → Scalar) (a b c d x : V) : Scalar :=
  diff a (diff b (diff c (diff d f))) x

def seed (m : ℕ) (x : Vec m) : Scalar :=
  ∑ i : Fin m, ∑ j : Fin m, if i < j then
    (x i).1 * (x i).2 * (x j).1 * (x j).2 else 0

def omega {m : ℕ} (a b : Vec m) : Scalar :=
  ∑ i : Fin m, ((a i).1 * (b i).2 + (a i).2 * (b i).1)

def pfaffian {m : ℕ} (a b c d : Vec m) : Scalar :=
  omega a b * omega c d + omega a c * omega b d + omega a d * omega b c

/-- The polarization of one monomial, with no restriction on ambient dimension. -/
def monomial {m : ℕ} (i j : Fin m) (x : Vec m) : Scalar :=
  (x i).1 * (x i).2 * (x j).1 * (x j).2

def localOmega {m : ℕ} (i : Fin m) (a b : Vec m) : Scalar :=
  (a i).1 * (b i).2 + (a i).2 * (b i).1

def crossTerm {m : ℕ} (i j : Fin m) (a b c d : Vec m) : Scalar :=
  localOmega i a b * localOmega j c d + localOmega i c d * localOmega j a b +
  localOmega i a c * localOmega j b d + localOmega i b d * localOmega j a c +
  localOmega i a d * localOmega j b c + localOmega i b c * localOmega j a d

@[simp] theorem scalar_add_self (z : Scalar) : z + z = 0 := by
  have h := ZMod.neg_eq_self_mod_two z
  calc
    z + z = -z + z := by rw [h]
    _ = 0 := neg_add_cancel z

private theorem monomial_first {m : ℕ} (i j : Fin m) (a : Vec m) :
    diff a (monomial i j) = fun x =>
    (x i).1 * (x i).2 * (x j).1 * (a j).2 +
    (x i).1 * (x i).2 * (a j).1 * (x j).2 +
    (x i).1 * (x i).2 * (a j).1 * (a j).2 +
    (x i).1 * (a i).2 * (x j).1 * (x j).2 +
    (x i).1 * (a i).2 * (x j).1 * (a j).2 +
    (x i).1 * (a i).2 * (a j).1 * (x j).2 +
    (x i).1 * (a i).2 * (a j).1 * (a j).2 +
    (a i).1 * (x i).2 * (x j).1 * (x j).2 +
    (a i).1 * (x i).2 * (x j).1 * (a j).2 +
    (a i).1 * (x i).2 * (a j).1 * (x j).2 +
    (a i).1 * (x i).2 * (a j).1 * (a j).2 +
    (a i).1 * (a i).2 * (x j).1 * (x j).2 +
    (a i).1 * (a i).2 * (x j).1 * (a j).2 +
    (a i).1 * (a i).2 * (a j).1 * (x j).2 +
    (a i).1 * (a i).2 * (a j).1 * (a j).2 := by
  funext x
  simp only [diff, monomial, Pi.add_apply, Prod.fst_add, Prod.snd_add]
  ring_nf (config := { recursive := false })
  simp only [show (2 : Scalar) = 0 from rfl,
    show (4 : Scalar) = 0 from rfl, show (8 : Scalar) = 0 from rfl,
    show (16 : Scalar) = 0 from rfl, mul_zero, zero_mul, add_zero, zero_add]


private theorem monomial_second {m : ℕ} (i j : Fin m) (a b : Vec m) :
    diff a (diff b (monomial i j)) = fun x =>
    (x i).1 * (x i).2 * (a j).1 * (b j).2 +
    (x i).1 * (x i).2 * (b j).1 * (a j).2 +
    (x i).1 * (a i).2 * (x j).1 * (b j).2 +
    (x i).1 * (a i).2 * (a j).1 * (b j).2 +
    (x i).1 * (a i).2 * (b j).1 * (x j).2 +
    (x i).1 * (a i).2 * (b j).1 * (a j).2 +
    (x i).1 * (a i).2 * (b j).1 * (b j).2 +
    (x i).1 * (b i).2 * (x j).1 * (a j).2 +
    (x i).1 * (b i).2 * (a j).1 * (x j).2 +
    (x i).1 * (b i).2 * (a j).1 * (a j).2 +
    (x i).1 * (b i).2 * (a j).1 * (b j).2 +
    (x i).1 * (b i).2 * (b j).1 * (a j).2 +
    (a i).1 * (x i).2 * (x j).1 * (b j).2 +
    (a i).1 * (x i).2 * (a j).1 * (b j).2 +
    (a i).1 * (x i).2 * (b j).1 * (x j).2 +
    (a i).1 * (x i).2 * (b j).1 * (a j).2 +
    (a i).1 * (x i).2 * (b j).1 * (b j).2 +
    (a i).1 * (a i).2 * (x j).1 * (b j).2 +
    (a i).1 * (a i).2 * (a j).1 * (b j).2 +
    (a i).1 * (a i).2 * (b j).1 * (x j).2 +
    (a i).1 * (a i).2 * (b j).1 * (a j).2 +
    (a i).1 * (a i).2 * (b j).1 * (b j).2 +
    (a i).1 * (b i).2 * (x j).1 * (x j).2 +
    (a i).1 * (b i).2 * (x j).1 * (a j).2 +
    (a i).1 * (b i).2 * (x j).1 * (b j).2 +
    (a i).1 * (b i).2 * (a j).1 * (x j).2 +
    (a i).1 * (b i).2 * (a j).1 * (a j).2 +
    (a i).1 * (b i).2 * (a j).1 * (b j).2 +
    (a i).1 * (b i).2 * (b j).1 * (x j).2 +
    (a i).1 * (b i).2 * (b j).1 * (a j).2 +
    (a i).1 * (b i).2 * (b j).1 * (b j).2 +
    (b i).1 * (x i).2 * (x j).1 * (a j).2 +
    (b i).1 * (x i).2 * (a j).1 * (x j).2 +
    (b i).1 * (x i).2 * (a j).1 * (a j).2 +
    (b i).1 * (x i).2 * (a j).1 * (b j).2 +
    (b i).1 * (x i).2 * (b j).1 * (a j).2 +
    (b i).1 * (a i).2 * (x j).1 * (x j).2 +
    (b i).1 * (a i).2 * (x j).1 * (a j).2 +
    (b i).1 * (a i).2 * (x j).1 * (b j).2 +
    (b i).1 * (a i).2 * (a j).1 * (x j).2 +
    (b i).1 * (a i).2 * (a j).1 * (a j).2 +
    (b i).1 * (a i).2 * (a j).1 * (b j).2 +
    (b i).1 * (a i).2 * (b j).1 * (x j).2 +
    (b i).1 * (a i).2 * (b j).1 * (a j).2 +
    (b i).1 * (a i).2 * (b j).1 * (b j).2 +
    (b i).1 * (b i).2 * (x j).1 * (a j).2 +
    (b i).1 * (b i).2 * (a j).1 * (x j).2 +
    (b i).1 * (b i).2 * (a j).1 * (a j).2 +
    (b i).1 * (b i).2 * (a j).1 * (b j).2 +
    (b i).1 * (b i).2 * (b j).1 * (a j).2 := by
  rw [monomial_first i j b]
  funext x
  simp only [diff, monomial, Pi.add_apply, Prod.fst_add, Prod.snd_add]
  ring_nf (config := { recursive := false })
  simp only [show (2 : Scalar) = 0 from rfl,
    show (4 : Scalar) = 0 from rfl, show (8 : Scalar) = 0 from rfl,
    show (16 : Scalar) = 0 from rfl, mul_zero, zero_mul, add_zero, zero_add]


private theorem monomial_third {m : ℕ} (i j : Fin m) (a b c : Vec m) :
    diff a (diff b (diff c (monomial i j))) = fun x =>
    (x i).1 * (a i).2 * (b j).1 * (c j).2 +
    (x i).1 * (a i).2 * (c j).1 * (b j).2 +
    (x i).1 * (b i).2 * (a j).1 * (c j).2 +
    (x i).1 * (b i).2 * (c j).1 * (a j).2 +
    (x i).1 * (c i).2 * (a j).1 * (b j).2 +
    (x i).1 * (c i).2 * (b j).1 * (a j).2 +
    (a i).1 * (x i).2 * (b j).1 * (c j).2 +
    (a i).1 * (x i).2 * (c j).1 * (b j).2 +
    (a i).1 * (a i).2 * (b j).1 * (c j).2 +
    (a i).1 * (a i).2 * (c j).1 * (b j).2 +
    (a i).1 * (b i).2 * (x j).1 * (c j).2 +
    (a i).1 * (b i).2 * (a j).1 * (c j).2 +
    (a i).1 * (b i).2 * (b j).1 * (c j).2 +
    (a i).1 * (b i).2 * (c j).1 * (x j).2 +
    (a i).1 * (b i).2 * (c j).1 * (a j).2 +
    (a i).1 * (b i).2 * (c j).1 * (b j).2 +
    (a i).1 * (b i).2 * (c j).1 * (c j).2 +
    (a i).1 * (c i).2 * (x j).1 * (b j).2 +
    (a i).1 * (c i).2 * (a j).1 * (b j).2 +
    (a i).1 * (c i).2 * (b j).1 * (x j).2 +
    (a i).1 * (c i).2 * (b j).1 * (a j).2 +
    (a i).1 * (c i).2 * (b j).1 * (b j).2 +
    (a i).1 * (c i).2 * (b j).1 * (c j).2 +
    (a i).1 * (c i).2 * (c j).1 * (b j).2 +
    (b i).1 * (x i).2 * (a j).1 * (c j).2 +
    (b i).1 * (x i).2 * (c j).1 * (a j).2 +
    (b i).1 * (a i).2 * (x j).1 * (c j).2 +
    (b i).1 * (a i).2 * (a j).1 * (c j).2 +
    (b i).1 * (a i).2 * (b j).1 * (c j).2 +
    (b i).1 * (a i).2 * (c j).1 * (x j).2 +
    (b i).1 * (a i).2 * (c j).1 * (a j).2 +
    (b i).1 * (a i).2 * (c j).1 * (b j).2 +
    (b i).1 * (a i).2 * (c j).1 * (c j).2 +
    (b i).1 * (b i).2 * (a j).1 * (c j).2 +
    (b i).1 * (b i).2 * (c j).1 * (a j).2 +
    (b i).1 * (c i).2 * (x j).1 * (a j).2 +
    (b i).1 * (c i).2 * (a j).1 * (x j).2 +
    (b i).1 * (c i).2 * (a j).1 * (a j).2 +
    (b i).1 * (c i).2 * (a j).1 * (b j).2 +
    (b i).1 * (c i).2 * (a j).1 * (c j).2 +
    (b i).1 * (c i).2 * (b j).1 * (a j).2 +
    (b i).1 * (c i).2 * (c j).1 * (a j).2 +
    (c i).1 * (x i).2 * (a j).1 * (b j).2 +
    (c i).1 * (x i).2 * (b j).1 * (a j).2 +
    (c i).1 * (a i).2 * (x j).1 * (b j).2 +
    (c i).1 * (a i).2 * (a j).1 * (b j).2 +
    (c i).1 * (a i).2 * (b j).1 * (x j).2 +
    (c i).1 * (a i).2 * (b j).1 * (a j).2 +
    (c i).1 * (a i).2 * (b j).1 * (b j).2 +
    (c i).1 * (a i).2 * (b j).1 * (c j).2 +
    (c i).1 * (a i).2 * (c j).1 * (b j).2 +
    (c i).1 * (b i).2 * (x j).1 * (a j).2 +
    (c i).1 * (b i).2 * (a j).1 * (x j).2 +
    (c i).1 * (b i).2 * (a j).1 * (a j).2 +
    (c i).1 * (b i).2 * (a j).1 * (b j).2 +
    (c i).1 * (b i).2 * (a j).1 * (c j).2 +
    (c i).1 * (b i).2 * (b j).1 * (a j).2 +
    (c i).1 * (b i).2 * (c j).1 * (a j).2 +
    (c i).1 * (c i).2 * (a j).1 * (b j).2 +
    (c i).1 * (c i).2 * (b j).1 * (a j).2 := by
  rw [monomial_second i j b c]
  funext x
  simp only [diff, monomial, Pi.add_apply, Prod.fst_add, Prod.snd_add]
  ring_nf (config := { recursive := false })
  simp only [show (2 : Scalar) = 0 from rfl,
    show (4 : Scalar) = 0 from rfl, show (8 : Scalar) = 0 from rfl,
    show (16 : Scalar) = 0 from rfl, mul_zero, zero_mul, add_zero, zero_add]


/-- Algebraic certificate: no truth-table enumeration. -/
theorem monomial_fourth {m : ℕ} (i j : Fin m) (a b c d x : Vec m) :
    fourth (monomial i j) a b c d x = crossTerm i j a b c d := by
  unfold fourth
  rw [monomial_third i j b c d]
  simp only [diff, crossTerm, localOmega, Pi.add_apply, Prod.fst_add, Prod.snd_add]
  ring_nf (config := { recursive := false })
  simp only [show (2 : Scalar) = 0 from rfl, mul_zero, zero_mul, add_zero, zero_add]

theorem diff_sum {V I : Type*} [Add V] (s : Finset I)
    (g : I → V → Scalar) (a x : V) :
    diff a (fun y => ∑ i ∈ s, g i y) x = ∑ i ∈ s, diff a (g i) x := by
  simp only [diff, Finset.sum_add_distrib]

theorem fourth_sum {V I : Type*} [Add V] (s : Finset I)
    (g : I → V → Scalar) (a b c d x : V) :
    fourth (fun y => ∑ i ∈ s, g i y) a b c d x =
      ∑ i ∈ s, fourth (g i) a b c d x := by
  simp only [fourth, diff, Finset.sum_add_distrib]

theorem seed_fourth_expansion {m : ℕ} (a b c d x : Vec m) :
    fourth (seed m) a b c d x =
      ∑ i : Fin m, ∑ j : Fin m, if i < j then crossTerm i j a b c d else 0 := by
  unfold seed
  rw [fourth_sum]
  apply Finset.sum_congr rfl
  intro i hi
  rw [fourth_sum]
  apply Finset.sum_congr rfl
  intro j hj
  by_cases hij : i < j
  · simp only [if_pos hij]
    exact monomial_fourth i j a b c d x
  · simp [fourth, diff, hij]

def orderedTerm {m : ℕ} (i j : Fin m) (a b c d : Vec m) : Scalar :=
  localOmega i a b * localOmega j c d +
  localOmega i a c * localOmega j b d +
  localOmega i a d * localOmega j b c

theorem orderedTerm_diagonal {m : ℕ} (i : Fin m) (a b c d : Vec m) :
    orderedTerm i i a b c d = 0 := by
  unfold orderedTerm localOmega
  ring_nf (config := { recursive := false })
  simp only [show (2 : Scalar) = 0 from rfl,
    show (4 : Scalar) = 0 from rfl, show (8 : Scalar) = 0 from rfl,
    show (16 : Scalar) = 0 from rfl, mul_zero, zero_mul, add_zero, zero_add]

theorem crossTerm_ordered {m : ℕ} (i j : Fin m) (a b c d : Vec m) :
    crossTerm i j a b c d = orderedTerm i j a b c d + orderedTerm j i a b c d := by
  unfold crossTerm orderedTerm
  ring

theorem triangular_sum {m : ℕ} (H : Fin m → Fin m → Scalar)
    (hdiag : ∀ i, H i i = 0) :
    (∑ i : Fin m, ∑ j : Fin m, if i < j then H i j + H j i else 0) =
      ∑ i : Fin m, ∑ j : Fin m, H i j := by
  have hsplit (i j : Fin m) :
      (if i < j then H i j + H j i else 0) =
      (if i < j then H i j else 0) + (if i < j then H j i else 0) := by
    split_ifs <;> simp
  simp_rw [hsplit, Finset.sum_add_distrib]
  rw [Finset.sum_comm (f := fun i j : Fin m => if i < j then H j i else 0)]
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i hi
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro j hj
  rcases lt_trichotomy i j with hij | hij | hij
  · simp [hij, not_lt_of_gt hij]
  · subst j; simp [hdiag]
  · simp [hij, not_lt_of_gt hij]

/-- Fourth polarization of the explicit quartic family in arbitrary dimension. -/
theorem seed_fourth {m : ℕ} (a b c d x : Vec m) :
    fourth (seed m) a b c d x = pfaffian a b c d := by
  rw [seed_fourth_expansion]
  simp_rw [crossTerm_ordered]
  rw [triangular_sum (fun i j => orderedTerm i j a b c d)
    (fun i => orderedTerm_diagonal i a b c d)]
  change (∑ i : Fin m, ∑ j : Fin m, orderedTerm i j a b c d) =
    (∑ i : Fin m, localOmega i a b) * (∑ i : Fin m, localOmega i c d) +
    (∑ i : Fin m, localOmega i a c) * (∑ i : Fin m, localOmega i b d) +
    (∑ i : Fin m, localOmega i a d) * (∑ i : Fin m, localOmega i b c)
  simp only [orderedTerm, Finset.sum_add_distrib]
  simp_rw [← Finset.mul_sum, ← Finset.sum_mul]

end VonoV3C

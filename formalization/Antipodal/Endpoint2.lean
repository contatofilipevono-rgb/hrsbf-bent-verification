import Antipodal.Fourier

/-!
A mathematical, non-reflective proof of the two-variable endpoint.
It uses the zero-frequency Walsh equation and an exact four-sign parity
identity, instead of kernel-reducing all function-space inhabitants.
-/

namespace HRSBF.Antipodal
open Finset

def leftUnit2 : PairSpace 1 := (fun _ => 1, fun _ => 0)
def rightUnit2 : PairSpace 1 := (fun _ => 0, fun _ => 1)

/-- Normalized polar coefficient of the unique mixed quadratic monomial. -/
def antipodalCoeff2 (f : PairSpace 1 → F₂) : F₂ :=
  polar f leftUnit2 rightUnit2

private lemma vec1_zero_or_one (u : Vec 1) : u = 0 ∨ u = ones := by
  have hc : ∀ a : F₂, a = 0 ∨ a = 1 := by decide
  have h : u (0 : Fin 1) = 0 ∨ u (0 : Fin 1) = 1 := hc _
  rcases h with hz | ho
  · left
    funext i
    have hi : i = (0 : Fin 1) := Subsingleton.elim _ _
    simpa [hi] using hz
  · right
    funext i
    have hi : i = (0 : Fin 1) := Subsingleton.elim _ _
    simpa [hi, ones] using ho

private lemma vec1_zero_ne_one : (0 : Vec 1) ≠ ones := by
  intro h
  have h0 := congrFun h (0 : Fin 1)
  norm_num [ones] at h0

private lemma sum_vec1 (f : Vec 1 → ℤ) :
    (∑ u : Vec 1, f u) = f 0 + f ones := by
  classical
  have heq : (Finset.univ : Finset (Vec 1)) = {0, ones} := by
    ext u
    simp only [mem_univ, mem_insert, mem_singleton, true_iff]
    exact vec1_zero_or_one u
  rw [heq]
  simp [vec1_zero_ne_one]

private lemma vec1_card : Fintype.card (Vec 1) = 2 := by
  classical
  have heq : (Finset.univ : Finset (Vec 1)) = {0, ones} := by
    ext u
    simp only [mem_univ, mem_insert, mem_singleton, true_iff]
    exact vec1_zero_or_one u
  rw [← Finset.card_univ, heq]
  simp [vec1_zero_ne_one]

private lemma character_zero_vec1 (u : Vec 1) :
    character (0 : Vec 1) u = 1 := by
  simp [character, dot, sign]

private lemma walsh_pair_zero_zero (g : PairSpace 1 → F₂) :
    walshPair g 0 0 =
      sign (g (0, 0)) + sign (g (0, ones)) +
      sign (g (ones, 0)) + sign (g (ones, ones)) := by
  unfold walshPair
  simp only [character_zero_vec1, mul_one]
  simp_rw [sum_vec1]
  ring

/-- Of four signs ±1, Walsh square 4 forces odd parity of negative signs. -/
private lemma four_sign_parity (a b c d : F₂)
    (h : (sign a + sign b + sign c + sign d) ^ 2 = 4) :
    a + b + c + d = 1 := by
  fin_cases a <;> fin_cases b <;> fin_cases c <;> fin_cases d <;>
    norm_num [sign] at * <;> decide

/-- A bent Boolean function on F₂² must have its mixed quadratic term.
No rotation assumption is necessary in dimension two. -/
theorem bent_implies_antipodal_in_two_variables
    (f : PairSpace 1 → F₂) (hb : IsBentPair f) :
    antipodalCoeff2 f = 1 := by
  have hs := hb (0 : Vec 1) (0 : Vec 1)
  rw [walsh_pair_zero_zero, vec1_card] at hs
  have hp := four_sign_parity
    (f (0, 0)) (f (0, ones)) (f (ones, 0)) (f (ones, ones)) hs
  have hsum : leftUnit2 + rightUnit2 = ((ones : Vec 1), ones) := by
    apply Prod.ext
    · funext i
      simp [leftUnit2, rightUnit2, ones]
    · funext i
      simp [leftUnit2, rightUnit2, ones]
  unfold antipodalCoeff2 polar
  rw [hsum]
  change f (ones, ones) + f (ones, 0) + f (0, ones) + f 0 = 1
  calc
    f (ones, ones) + f (ones, 0) + f (0, ones) + f 0 =
        f 0 + (f (ones, ones) + (f (ones, 0) + f (0, ones))) := by ring
    _ = 1 := hp

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.bent_implies_antipodal_in_two_variables

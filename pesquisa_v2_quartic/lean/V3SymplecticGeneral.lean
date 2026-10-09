import Mathlib

/-!
Dimension-parametric V3 definitions and the first symbolic lemma.
This module does not assert general property (A) or polarization yet.
The finite m=2 certified gate is in V3SeedFiniteChecks.lean.
-/

namespace VonoV3General

abbrev Bit := ZMod 2
abbrev Vec (m : ℕ) := Fin m → Bit × Bit

def q {m : ℕ} (x : Vec m) (i : Fin m) : Bit :=
  (x i).1 * (x i).2

def omega {m : ℕ} (a b : Vec m) : Bit :=
  ∑ i : Fin m, ((a i).1 * (b i).2 + (a i).2 * (b i).1)

def phi {m : ℕ} (a b c d : Vec m) : Bit :=
  omega a b * omega c d +
  omega a c * omega b d +
  omega a d * omega b c

theorem omega_symmetric {m : ℕ} (a b : Vec m) :
    omega a b = omega b a := by
  unfold omega
  apply Finset.sum_congr rfl
  intro i hi
  ring

/-- The zero direction annihilates the symplectic form. -/
theorem omega_zero_left {m : ℕ} (b : Vec m) :
    omega (0 : Vec m) b = 0 := by
  simp [omega]

/-- The zero direction annihilates the quartic polarization tensor. -/
theorem phi_zero_left {m : ℕ} (b c d : Vec m) :
    phi (0 : Vec m) b c d = 0 := by
  simp [phi, omega_zero_left]

/-- In characteristic two the symplectic form vanishes on the diagonal. -/
theorem omega_self {m : ℕ} (a : Vec m) :
    omega a a = 0 := by
  unfold omega
  apply Finset.sum_eq_zero
  intro i hi
  have h : (2 : Bit) = 0 := by decide
  calc
    (a i).1 * (a i).2 + (a i).2 * (a i).1
        = (2 : Bit) * ((a i).1 * (a i).2) := by ring
    _ = 0 := by rw [h]; ring

/-- Repeating the first two arguments annihilates the fourth-order tensor. -/
theorem phi_self_first {m : ℕ} (a c d : Vec m) :
    phi a a c d = 0 := by
  simp only [phi, omega_self]
  ring

end VonoV3General

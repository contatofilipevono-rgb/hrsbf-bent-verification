import Mathlib

/-! V3 experimental finite gate. This file is NOT the general m theorem.
    CI success, not this source text alone, is evidence of compilation. -/
namespace VonoV3Finite

abbrev Bit := ZMod 2
abbrev Vec := Fin 2 → Bit × Bit

def q (x : Vec) (i : Fin 2) : Bit := (x i).1 * (x i).2
def seed (x : Vec) : Bit := q x 0 * q x 1
def omega (a b : Vec) : Bit :=
  ∑ i : Fin 2, ((a i).1 * (b i).2 + (a i).2 * (b i).1)
def phi (a b c d : Vec) : Bit :=
  omega a b * omega c d + omega a c * omega b d + omega a d * omega b c
def diff (a : Vec) (f : Vec → Bit) (x : Vec) : Bit := f (x + a) - f x
def d4 (a b c d x : Vec) : Bit :=
  diff a (diff b (diff c (diff d seed))) x

theorem finite_polarization :
    ∀ a b c d x : Vec, d4 a b c d x = phi a b c d := by
  native_decide

theorem finite_property_A :
    ∀ a b : Vec, (∀ c d : Vec, phi a b c d = 0) →
      (a = 0 ∨ b = 0 ∨ a = b) := by
  native_decide

end VonoV3Finite

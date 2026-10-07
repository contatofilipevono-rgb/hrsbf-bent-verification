import Mathlib

namespace VonoExactIndex

variable {V : Type*} [AddCommGroup V] [Module (ZMod 2) V]

def diff (a : V) (f : V → ZMod 2) : V → ZMod 2 :=
  fun x => f (x + a) + f x

@[simp] theorem add_self_zmod2 (z : ZMod 2) : z + z = 0 := by
  change 2 * z = 0
  simp

@[simp] theorem diff_zero (f : V → ZMod 2) :
    diff (0 : V) f = (0 : V → ZMod 2) := by
  funext x
  simp [diff]

@[simp] theorem diff_self (a : V) (f : V → ZMod 2) :
    diff a (diff a f) = (0 : V → ZMod 2) := by
  funext x
  simp only [diff]
  have haa : a + a = 0 := by
    have h2 : (2 : ZMod 2) = 0 := by decide
    have := two_smul (ZMod 2) a
    simpa [h2] using this.symm
  rw [show x + a + a = x by abel]
  simp

theorem diff_add (a : V) (f g : V → ZMod 2) :
    diff a (fun x => f x + g x) = fun x => diff a f x + diff a g x := by
  funext x
  simp only [diff]
  abel

theorem diff_add_direction (a b : V) (f : V → ZMod 2) :
    diff (a + b) f =
      fun x => diff a f x + diff b f x + diff a (diff b f) x := by
  funext x
  simp only [diff]
  rw [show x + (a + b) = (x + b) + a by abel]
  abel

end VonoExactIndex

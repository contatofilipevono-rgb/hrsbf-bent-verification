import Mathlib

namespace VonoExactIndex

variable {V : Type*} [AddCommGroup V] [Module (ZMod 2) V]

def diff (a : V) (f : V → ZMod 2) : V → ZMod 2 :=
  fun x => f (x + a) + f x

@[simp] theorem diff_zero (f : V → ZMod 2) : diff (0 : V) f = (0 : V → ZMod 2) := by
  funext x
  simp [diff]

@[simp] theorem diff_self (a : V) (f : V → ZMod 2) :
    diff a (diff a f) = (0 : V → ZMod 2) := by
  funext x
  simp [diff, add_assoc, add_comm, add_left_comm]

theorem diff_add (a : V) (f g : V → ZMod 2) :
    diff a (fun x => f x + g x) = fun x => diff a f x + diff a g x := by
  funext x
  simp [diff, add_assoc, add_comm, add_left_comm]

theorem diff_add_direction (a b : V) (f : V → ZMod 2) :
    diff (a + b) f =
      fun x => diff a f x + diff b f x + diff a (diff b f) x := by
  funext x
  simp [diff, add_assoc, add_comm, add_left_comm]

end VonoExactIndex

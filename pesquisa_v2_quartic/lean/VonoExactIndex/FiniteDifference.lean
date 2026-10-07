import Mathlib

namespace VonoExactIndex

variable {V : Type*} [AddCommGroup V] [Module (ZMod 2) V]

/-- Boolean-valued finite difference in direction `a`. -/
def diff (a : V) (f : V → ZMod 2) : V → ZMod 2 :=
  fun x => f (x + a) + f x

notation "D[" a "]" f => diff a f

@[simp] theorem diff_zero (f : V → ZMod 2) : D[(0 : V)] f = 0 := by
  funext x
  simp [diff]

/-- Repeating a direction twice annihilates a Boolean finite difference. -/
@[simp] theorem diff_self (a : V) (f : V → ZMod 2) : D[a] (D[a] f) = 0 := by
  funext x
  simp [diff, add_assoc, add_comm, add_left_comm]

/-- Finite difference distributes over sums of Boolean functions. -/
theorem diff_add (a : V) (f g : V → ZMod 2) :
    D[a] (fun x => f x + g x) = fun x => D[a] f x + D[a] g x := by
  funext x
  simp [diff, add_assoc, add_comm, add_left_comm]

/--
The correction term that explains why finite differences are not simply
linear in their direction argument.
-/
theorem diff_add_direction (a b : V) (f : V → ZMod 2) :
    D[a + b] f = fun x => D[a] f x + D[b] f x + D[a] (D[b] f) x := by
  funext x
  simp [diff, add_assoc, add_comm, add_left_comm]

end VonoExactIndex

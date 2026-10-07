import Mathlib

namespace VonoExactIndex

variable {V : Type*} [AddCommGroup V] [Module (ZMod 2) V]

def diff (a : V) (f : V → ZMod 2) : V → ZMod 2 :=
  fun x => f (x + a) + f x

@[simp] theorem add_self_zmod2 (z : ZMod 2) : z + z = 0 := by
  exact ZMod.add_self z

@[simp] theorem diff_zero (f : V → ZMod 2) :
    diff (0 : V) f = (0 : V → ZMod 2) := by
  funext x
  simp [diff]

@[simp] theorem diff_self (a : V) (f : V → ZMod 2) :
    diff a (diff a f) = (0 : V → ZMod 2) := by
  funext x
  have haa : a + a = 0 := by
    have hchar : (1 : ZMod 2) + 1 = 0 := by
      exact ZMod.add_self 1
    calc
      a + a = (1 : ZMod 2) • a + (1 : ZMod 2) • a := by simp
      _ = ((1 : ZMod 2) + 1) • a := by rw [add_smul]
      _ = 0 := by rw [hchar, zero_smul]
  simp only [diff]
  have hxaa : x + a + a = x := by
    rw [add_assoc, haa, add_zero]
  rw [hxaa]
  calc
    f x + f (x + a) + (f (x + a) + f x)
        = (f x + f x) + (f (x + a) + f (x + a)) := by abel
    _ = 0 := by simp

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
  have hab : x + (a + b) = x + b + a := by abel
  have hba : x + b + a = x + a + b := by abel
  rw [hab]
  calc
    f (x + b + a) + f x
        = f (x + b + a) + f x
            + (f (x + a) + f (x + a))
            + (f (x + b) + f (x + b))
            + (f x + f x) := by simp
    _ = (f (x + a) + f x) + (f (x + b) + f x)
          + ((f (x + b + a) + f (x + b)) + (f (x + a) + f x)) := by abel
    _ = (f (x + a) + f x) + (f (x + b) + f x)
          + ((f (x + a + b) + f (x + b)) + (f (x + a) + f x)) := by rw [hba]
    _ = (f (x + a) + f x) + (f (x + b) + f x)
          + (f (x + a + b) + f (x + a) + (f (x + b) + f x)) := by abel

end VonoExactIndex

import H12Weight

namespace H12Bits
open H12Weight
universe u v

theorem parity_append (xs ys : List α) (f : α → Bool) :
    parity (xs ++ ys) f = (parity xs f ^^ parity ys f) := by
  induction xs with
  | nil => simp [parity]
  | cons a xs ih =>
    rw [List.cons_append, parity_cons, parity_cons, ih, Bool.xor_assoc]

theorem parity_map (xs : List α) (g : α → β) (f : β → Bool) :
    parity (xs.map g) f = parity xs (fun x => f (g x)) := by
  simp [parity, List.countP_map, Function.comp_def]

theorem parity_filter (xs : List α) (p f : α → Bool) :
    parity (xs.filter p) f = parity xs (fun x => p x && f x) := by
  simp [parity, List.countP_filter, Bool.and_comm]

def foldParity : Nat → Nat → Bool
  | 0, value => value.testBit 0
  | n+1, value => foldParity n (value ^^^ (value >>> (2^n)))

theorem foldParity_sound (depth value : Nat) :
    foldParity depth value = parity (List.range (2^depth)) (fun x => value.testBit x) := by
  induction depth generalizing value with
  | zero =>
    cases h : value.testBit 0 <;> simp [foldParity, parity, h]
  | succ n ih =>
    rw [foldParity, ih]
    have hp : 2^(n+1) = 2^n + 2^n := by simp [Nat.pow_succ, Nat.mul_two]
    rw [hp, List.range_add, parity_append, parity_map]
    simp only [Nat.testBit_xor, Nat.testBit_shiftRight, parity_xor]

#print axioms foldParity_sound

theorem count_carry_add (a b : Nat) :
    (a+b).testBit 1 = (a.testBit 1 ^^ b.testBit 1 ^^ (a.testBit 0 && b.testBit 0)) := by
  cases ha0 : a.testBit 0 <;> cases ha1 : a.testBit 1 <;>
    cases hb0 : b.testBit 0 <;> cases hb1 : b.testBit 1 <;> cases hc : (a+b).testBit 1 <;>
    simp_all only [Nat.testBit_eq_decide_div_mod_eq, Nat.pow_zero, Nat.div_one, Nat.pow_one,
      decide_eq_true_eq, decide_eq_false_iff_not, Bool.false_and, Bool.true_and,
      Bool.and_false, Bool.and_true, Bool.false_xor, Bool.true_xor, Bool.not_false, Bool.not_true] <;> omega

theorem carry_append (xs ys : List α) (f : α → Bool) :
    carry (xs ++ ys) f = (carry xs f ^^ carry ys f ^^ (parity xs f && parity ys f)) := by
  simp only [carry, parity, List.countP_append]
  exact count_carry_add ..

theorem carry_map (xs : List α) (g : α → β) (f : β → Bool) :
    carry (xs.map g) f = carry xs (fun x => f (g x)) := by
  simp [carry, List.countP_map, Function.comp_def]

def foldTwoBits : Nat → Nat → Nat → Bool × Bool
  | 0, lo, hi => (lo.testBit 0, hi.testBit 0)
  | n+1, lo, hi => foldTwoBits n (lo ^^^ (lo >>> (2^n)))
      (hi ^^^ (hi >>> (2^n)) ^^^ (lo &&& (lo >>> (2^n))))

theorem step_carry : ∀ a b c d p q r : Bool,
    ((a ^^ b ^^ (p && q) ^^ r) ^^ ((c ^^ d) ^^ r)) =
      ((a ^^ b ^^ (p && q)) ^^ (c ^^ d)) := by decide

theorem foldTwoBits_sound (depth lo hi : Nat) :
    foldTwoBits depth lo hi =
      (parity (List.range (2^depth)) (fun x => lo.testBit x),
       carry (List.range (2^depth)) (fun x => lo.testBit x) ^^
         parity (List.range (2^depth)) (fun x => hi.testBit x)) := by
  induction depth generalizing lo hi with
  | zero =>
    cases hl : lo.testBit 0 <;> cases hh : hi.testBit 0 <;>
      simp [foldTwoBits, carry, parity, hl, hh] <;> decide
  | succ n ih =>
    rw [foldTwoBits, ih]
    have hp : 2^(n+1) = 2^n + 2^n := by simp [Nat.pow_succ, Nat.mul_two]
    rw [hp, List.range_add, parity_append, carry_append, parity_append, parity_map, carry_map, parity_map]
    simp only [Nat.testBit_xor, Nat.testBit_and, Nat.testBit_shiftRight,
      parity_xor, carry_xor, polar]
    apply Prod.ext
    · rfl
    · dsimp only
      have hs := step_carry
      simp only [Bool.xor_assoc] at hs ⊢
      exact hs ..

def fastCarry (depth value : Nat) : Bool := (foldTwoBits depth value 0).2

theorem fastCarry_sound (depth value : Nat) :
    fastCarry depth value = carry (List.range (2^depth)) (fun x => value.testBit x) := by
  unfold fastCarry
  rw [foldTwoBits_sound]
  simp [parity_zero]

#print axioms fastCarry_sound
end H12Bits

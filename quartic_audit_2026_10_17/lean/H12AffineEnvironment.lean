import H12QuadraticCompose

namespace H12AffineEnvironment
open H12PackedPolynomial H12BooleanPolynomial H12CertificateTheory
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def sum : Nat → Nat → (Nat → Bool) → Nat → Bool
  | 0, _, _, _ => false
  | width+1, start, f, word =>
      (word.testBit 0 && f start) ^^ sum width (start+1) f (word >>> 1)

theorem sum_semantics (width start : Nat) (f : Nat → Bool) (word : Nat)
    (hw : start+width ≤ 36) :
    sum width start f word = evaluate 36 f (unpack (unitMasks width start) word) := by
  induction width generalizing start word with
  | zero => rfl
  | succ width ih =>
    have ht := ih (start+1) (word >>> 1) (by omega)
    have hs : start < 36 := by omega
    cases hb : word.testBit 0 <;>
      simp only [sum, hb, Bool.false_and, Bool.false_xor, Bool.true_and,
        ht, unitMasks, unpack, Bool.false_eq_true, ↓reduceIte, evaluate_cons,
        monomial_unit 36 f start hs]

theorem sum_below (width start : Nat) (f : Nat → Bool) (word i : Nat) (b : Bool)
    (hi : i < start) : sum width start (update f i b) word = sum width start f word := by
  induction width generalizing start word with
  | zero => rfl
  | succ width ih =>
    have hs : start ≠ i := by omega
    simp only [sum, update, hs, ↓reduceIte, ih (start+1) (word >>> 1) (by omega)]

theorem sum_update (width start j : Nat) (f : Nat → Bool) (word : Nat) (b : Bool) :
    sum width start (update f (start+j) b) word =
      (sum width start f word ^^
        (if j < width then word.testBit j && (f (start+j) ^^ b) else false)) := by
  induction width generalizing start j word with
  | zero => simp only [sum, Nat.not_lt_zero, ↓reduceIte, Bool.xor_false]
  | succ width ih =>
    cases j with
    | zero =>
      have ht := sum_below width (start+1) f (word >>> 1) start b (by omega)
      simp only [Nat.add_zero, sum, update, ↓reduceIte, ht,
        Nat.zero_lt_succ]
      cases word.testBit 0 <;> cases f start <;> cases b <;>
        cases sum width (start+1) f (word >>> 1) <;> decide
    | succ j =>
      have hs : start ≠ (start+1)+j := by omega
      have he : start+(j+1) = (start+1)+j := by omega
      have ht := ih (start+1) j (word >>> 1)
      rw [he]
      simp only [sum, update, hs, ↓reduceIte]
      rw [ht]
      have hb : (word >>> 1).testBit j = word.testBit (j+1) := by
        simp only [Nat.testBit_shiftRight, Nat.add_comm]
      rw [hb]
      by_cases hj : j < width
      · have hj' : j+1 < width+1 := by omega
        simp only [hj, hj', ↓reduceIte, Bool.xor_assoc]
      · have hj' : ¬j+1 < width+1 := by omega
        simp only [hj, hj', ↓reduceIte, Bool.xor_false]

theorem affineValue_update (f : Nat → Bool) (i word : Nat) (b : Bool) (hi : i < 36) :
    affineValue (update f i b) word = (affineValue f word ^^
      (word.testBit (i+1) && (f i ^^ b))) := by
  have hs := sum_update 36 0 i f (word >>> 1) b
  simp only [Nat.zero_add] at hs
  rw [sum_semantics 36 0 _ _ (by decide), sum_semantics 36 0 _ _ (by decide)] at hs
  change linearValue (update f i b) (word >>> 1) =
    (linearValue f (word >>> 1) ^^ _) at hs
  simp only [Nat.zero_add, hi, ↓reduceIte, Nat.testBit_shiftRight, Nat.add_comm] at hs
  simp only [affineValue, hs, Bool.xor_assoc]

def substitute (i a word : Nat) : Nat :=
  if word.testBit (i+1) then word ^^^ (2^(i+1) ^^^ a) else word

theorem substitute_sound (f : Nat → Bool) (i a word : Nat) (hi : i < 36) :
    affineValue f (substitute i a word) = affineValue (update f i (affineValue f a)) word := by
  rw [affineValue_update _ _ _ _ hi]
  cases hb : word.testBit (i+1) <;>
    simp only [substitute, hb, Bool.false_eq_true, ↓reduceIte, affineValue_xor,
      affineValue_unit f i hi, Bool.false_and, Bool.xor_false, Bool.true_and]

def transform (i a : Nat) (env : List Nat) : List Nat := env.map (substitute i a)

#print axioms substitute_sound
end H12AffineEnvironment

import H12PackedProductOptimization
import H12AffineState
namespace H12QuadraticCompose
open H12PackedPolynomial H12BooleanPolynomial
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

theorem unitMasks_length (width start : Nat) : (unitMasks width start).length = width := by
  induction width generalizing start with
  | zero => rfl
  | succ width ih => simp only [unitMasks, List.length_cons, ih]

theorem unpack_congr (book : List Nat) (a b : Nat)
    (he : ∀ i, i < book.length → a.testBit i = b.testBit i) : unpack book a = unpack book b := by
  induction book generalizing a b with
  | nil => rfl
  | cons m ms ih =>
    have h0 := he 0 (by simp)
    have ht := ih (a >>> 1) (b >>> 1) (by
      intro i hi
      simp only [Nat.testBit_shiftRight]
      exact he (1+i) (by simp only [List.length_cons]; omega))
    simp only [unpack, h0, ht]

theorem unpack_mod (book : List Nat) (word : Nat) :
    unpack book (word % 2^book.length) = unpack book word := by
  apply unpack_congr
  intro i hi
  simp only [Nat.testBit_mod_two_pow, hi, decide_true, Bool.true_and]

theorem linearValue_mod (f : Nat → Bool) (word : Nat) :
    linearValue f (word % 2^36) = linearValue f word := by
  have h := unpack_mod (unitMasks 36 0) word
  rw [unitMasks_length] at h
  exact congrArg (evaluate 36 f) h

def linearCompose : Nat → Nat → List Nat → Nat → Nat
  | 0, _, _, _ => 0
  | width+1, start, env, word =>
      if word = 0 then 0
      else (if word.testBit 0 then (env[start]?).getD 0 else 0) ^^^
        linearCompose width (start+1) env (word >>> 1)

theorem affineValue_zero (f : Nat → Bool) : affineValue f 0 = false := by
  simp only [affineValue, Nat.zero_testBit, Nat.zero_shiftRight, linearValue_zero, Bool.false_xor]

theorem linearCompose_sound (width start : Nat) (env : List Nat) (f : Nat → Bool) (word : Nat)
    (hw : start+width ≤ 36) :
    affineValue f (linearCompose width start env word) =
      evaluate 36 (H12AffineState.assignment env f) (unpack (unitMasks width start) word) := by
  induction width generalizing start word with
  | zero => exact affineValue_zero f
  | succ width ih =>
    by_cases hz : word = 0
    · subst word
      simp only [linearCompose, ↓reduceIte, affineValue_zero]
      exact (value_zero 36 _ (unitMasks (width+1) start)).symm
    · have hs : start < 36 := by omega
      have ht := ih (start+1) (word >>> 1) (by omega)
      simp only [linearCompose, hz, ↓reduceIte, affineValue_xor, ht]
      cases hb : word.testBit 0 with
      | false => simp only [hb, Bool.false_eq_true, ↓reduceIte, affineValue_zero,
          Bool.false_xor, unitMasks, unpack]
      | true => simp only [hb, ↓reduceIte, unitMasks, unpack, evaluate_cons,
          monomial_unit 36 (H12AffineState.assignment env f) start hs, H12AffineState.assignment]

def rowsBook : Nat → Nat → List Nat
  | 0, _ => []
  | width+1, start => rowMasks 36 0 start ++ rowsBook width (start+1)

def structuredBook : List Nat := [0] ++ unitMasks 36 0 ++ rowsBook 36 0

theorem structuredBook_eq : structuredBook = denseBook := by
  exact beq_iff_eq.mp (by decide +kernel : (structuredBook == denseBook) = true)

#print axioms structuredBook_eq

def quadraticValue (width start : Nat) (f : Nat → Bool) (word : Nat) : Bool :=
  match width with
  | 0 => false
  | width+1 => (f start && linearValue f word) ^^ quadraticValue width (start+1) f (word >>> 36)

theorem rowValue (f : Nat → Bool) (start word : Nat) (hs : start < 36) :
    value 36 f (rowMasks 36 0 start) word = (f start && linearValue f word) := by
  simp only [value, rowMasks, unpack_map, evaluate_union, monomial_unit 36 f start hs, linearValue]

theorem rowsValue (width start : Nat) (f : Nat → Bool) (word : Nat) (hw : start+width ≤ 36) :
    value 36 f (rowsBook width start) word = quadraticValue width start f word := by
  induction width generalizing start word with
  | zero => rfl
  | succ width ih =>
    have hs : start < 36 := by omega
    simp only [rowsBook, value_append, rowMasks, List.length_map, unitMasks_length,
      quadraticValue]
    rw [show value 36 f ((unitMasks 36 0).map (fun m => 2^start ||| m)) word =
      (f start && linearValue f word) from rowValue f start word hs, ih _ _ (by omega)]

theorem constantValue (f : Nat → Bool) (word : Nat) : value 36 f [0] word = word.testBit 0 := by
  cases hb : word.testBit 0 <;> simp only [value, unpack, hb, Bool.false_eq_true, ↓reduceIte,
    evaluate, List.foldr_cons, List.foldr_nil, monomial_zero, Bool.xor_false]

theorem denseValue (f : Nat → Bool) (word : Nat) :
    value 36 f denseBook word =
      ((word.testBit 0 ^^ linearValue f (word >>> 1)) ^^ quadraticValue 36 0 f (word >>> 37)) := by
  rw [← structuredBook_eq, structuredBook, value_append, value_append, constantValue]
  simp only [List.length_append, List.length_cons, List.length_nil, Nat.zero_add,
    unitMasks_length, Nat.shiftRight_add]
  rw [rowsValue 36 0 f _ (by decide)]
  rfl

#print axioms denseValue

theorem quadraticValue_zero (width start : Nat) (f : Nat → Bool) : quadraticValue width start f 0 = false := by
  induction width generalizing start with
  | zero => rfl
  | succ width ih => simp only [quadraticValue, linearValue_zero, Bool.and_false, Nat.zero_shiftRight, ih, Bool.false_xor]

def quadraticCompose : Nat → Nat → List Nat → Nat → Nat
  | 0, _, _, _ => 0
  | width+1, start, env, word =>
      if word = 0 then 0
      else (if word % 2^36 = 0 then 0
        else H12PackedProductOptimization.product ((env[start]?).getD 0) (linearCompose 36 0 env word)) ^^^
        quadraticCompose width (start+1) env (word >>> 36)

theorem quadraticCompose_sound (width start : Nat) (env : List Nat) (f : Nat → Bool) (word : Nat)
    (hw : start+width ≤ 36) :
    value 36 f denseBook (quadraticCompose width start env word) =
      quadraticValue width start (H12AffineState.assignment env f) word := by
  induction width generalizing start word with
  | zero => exact value_zero 36 f denseBook
  | succ width ih =>
    by_cases hz : word = 0
    · subst word
      simp only [quadraticCompose, ↓reduceIte, value_zero, quadraticValue_zero]
    · have ht := ih (start+1) (word >>> 36) (by omega)
      simp only [quadraticCompose, hz, ↓reduceIte, value_xor, ht, quadraticValue]
      by_cases hr : word % 2^36 = 0
      · have hl : linearValue (H12AffineState.assignment env f) word = false := by
          rw [← linearValue_mod, hr, linearValue_zero]
        simp only [hr, ↓reduceIte, value_zero, hl, Bool.and_false]
      · simp only [hr, ↓reduceIte, H12PackedProductOptimization.product_sound,
          linearCompose_sound 36 0 env f word (by decide), H12AffineState.assignment, linearValue]

def composeRows (env : List Nat) (word : Nat) : Nat :=
  ((if word.testBit 0 then 1 else 0) ^^^ affineNative (linearCompose 36 0 env (word >>> 1))) ^^^
    quadraticCompose 36 0 env (word >>> 37)

theorem composeRows_sound (env : List Nat) (f : Nat → Bool) (word : Nat) :
    value 36 f denseBook (composeRows env word) = value 36 (H12AffineState.assignment env f) denseBook word := by
  rw [composeRows, value_xor, value_xor, constantNative_sound, affineNative_sound,
    linearCompose_sound 36 0 env f (word >>> 1) (by decide), quadraticCompose_sound 36 0 env f _ (by decide), denseValue]
  rfl

def canonicalFast (word : Nat) : Nat :=
  H12PackedSparse.applyFast 1333 canonicalColumn (word % 2^1333)

theorem canonicalFast_sound (f : Nat → Bool) (word : Nat) :
    value 36 f denseBook (canonicalFast word) = value 36 f denseBook word := by
  have hm : word % 2^1333 < 2^1333 := Nat.mod_lt _ (Nat.two_pow_pos _)
  have hw : word % 2^1333 < 2^2048 :=
    Nat.lt_of_lt_of_le hm (Nat.pow_le_pow_right (by decide) (by decide))
  rw [canonicalFast, H12PackedSparse.applyFast_eq_sparse _ _ _ hw]
  have hc := canonicalize_sound f (word % 2^1333) hm
  change value 36 f denseBook (canonicalize (word % 2^1333)) = _
  rw [hc]
  have he := unpack_mod denseBook word
  rw [dense_length] at he
  exact congrArg (evaluate 36 f) he

#print axioms composeRows_sound
#print axioms canonicalFast_sound
end H12QuadraticCompose

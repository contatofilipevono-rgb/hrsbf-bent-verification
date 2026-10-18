import H12BooleanPolynomial

namespace H12CertificateTheory
open H12BooleanPolynomial

theorem xor_interleave : ∀ a x y : Bool, ((a ^^ x) ^^ (a ^^ y)) = (x ^^ y) := by decide

def mergeXor : Nat → List Nat → List Nat → List Nat
  | 0, xs, ys => xs ++ ys
  | _+1, [], ys => ys
  | _+1, xs, [] => xs
  | k+1, a::as, b::bs =>
    if a = b then mergeXor k as bs
    else if a < b then a :: mergeXor k as (b::bs)
    else b :: mergeXor k (a::as) bs

theorem evaluate_merge (n : Nat) (f : Nat → Bool) (fuel : Nat) (xs ys : List Nat) :
    evaluate n f (mergeXor fuel xs ys) = (evaluate n f xs ^^ evaluate n f ys) := by
  induction fuel generalizing xs ys with
  | zero => exact evaluate_append n f xs ys
  | succ k ih =>
    cases xs with
    | nil => simp [mergeXor, evaluate]
    | cons a as =>
      cases ys with
      | nil => simp [mergeXor, evaluate]
      | cons b bs =>
        simp only [mergeXor]
        split
        · rename_i h; subst b
          rw [ih, evaluate_cons, evaluate_cons, xor_interleave]
        · split
          · simp only [evaluate_cons, ih, Bool.xor_assoc]
          · simp only [evaluate_cons, ih]
            exact Bool.xor_left_comm _ _ _

def normalizeFuel : Nat → List Nat → List Nat
  | 0, xs => xs
  | k+1, xs => if xs.length ≤ 1 then xs else mergeXor xs.length
      (normalizeFuel k (xs.take (xs.length/2)))
      (normalizeFuel k (xs.drop (xs.length/2)))

theorem evaluate_normalize (n : Nat) (f : Nat → Bool) (fuel : Nat) (xs : List Nat) :
    evaluate n f (normalizeFuel fuel xs) = evaluate n f xs := by
  induction fuel generalizing xs with
  | zero => rfl
  | succ k ih =>
    rw [normalizeFuel]
    split
    · rfl
    · rw [evaluate_merge, ih, ih, ← evaluate_append, List.take_append_drop]

def update (f : Nat → Bool) (i : Nat) (value : Bool) : Nat → Bool :=
  fun j => if j = i then value else f j

theorem clear_bit (mask i : Nat) (h : mask.testBit i = true) :
    ((mask ^^^ 2^i) ||| 2^i) = mask ∧ (mask ^^^ 2^i).testBit i = false := by
  constructor
  · apply Nat.eq_of_testBit_eq
    intro j
    simp only [Nat.testBit_or, Nat.testBit_xor, Nat.testBit_two_pow]
    by_cases he : i = j
    · subst j; simp [h]
    · simp [he]
  · simp [Nat.testBit_xor, Nat.testBit_two_pow, h]

theorem monomial_update_irrelevant (n : Nat) (f : Nat → Bool) (i mask : Nat)
    (value : Bool) (h : mask.testBit i = false) :
    monomial n (update f i value) mask = monomial n f mask := by
  unfold monomial
  apply Bool.eq_iff_iff.mpr
  simp only [List.all_eq_true]
  constructor <;> intro ha j hj
  · have hm := List.mem_filter.mp hj
    have hne : j ≠ i := by
      intro he; subst j
      rw [h] at hm
      cases hm.2
    simpa [update, hne] using ha j hj
  · have hm := List.mem_filter.mp hj
    have hne : j ≠ i := by
      intro he; subst j
      rw [h] at hm
      cases hm.2
    simpa [update, hne] using ha j hj

theorem monomial_update (n : Nat) (f : Nat → Bool) (i : Nat) (hi : i < n)
    (value : Bool) (mask : Nat) :
    monomial n (update f i value) mask =
      if mask.testBit i then (monomial n f (mask ^^^ 2^i) && value)
      else monomial n f mask := by
  cases h : mask.testBit i
  · simp only [h, Bool.false_eq_true, ↓reduceIte]
    exact monomial_update_irrelevant n f i mask value h
  · simp only [h, ↓reduceIte]
    have hc := clear_bit mask i h
    calc
      monomial n (update f i value) mask =
          monomial n (update f i value) ((mask ^^^ 2^i) ||| 2^i) := by rw [hc.1]
      _ = (monomial n (update f i value) (mask ^^^ 2^i) &&
          monomial n (update f i value) (2^i)) := monomial_union _ _ _ _
      _ = (monomial n f (mask ^^^ 2^i) && value) := by
        rw [monomial_update_irrelevant n f i _ value hc.2, monomial_unit n _ i hi]
        simp [update]

def substituteMonomial (i : Nat) (form : List Nat) (mask : Nat) : List Nat :=
  if mask.testBit i then form.map (fun m => m ||| (mask ^^^ 2^i)) else [mask]
def substitute (i : Nat) (form polynomial : List Nat) : List Nat :=
  polynomial.flatMap (substituteMonomial i form)

theorem evaluate_substitute_monomial (n : Nat) (f : Nat → Bool) (i : Nat)
    (hi : i < n) (form : List Nat) (mask : Nat) :
    evaluate n f (substituteMonomial i form mask) =
      monomial n (update f i (evaluate n f form)) mask := by
  rw [monomial_update n f i hi]
  cases h : mask.testBit i <;> simp only [substituteMonomial, h, ↓reduceIte]
  · simp [evaluate]
  · rw [evaluate_map_union, Bool.and_comm]

theorem evaluate_substitute (n : Nat) (f : Nat → Bool) (i : Nat) (hi : i < n)
    (form polynomial : List Nat) :
    evaluate n f (substitute i form polynomial) =
      evaluate n (update f i (evaluate n f form)) polynomial := by
  induction polynomial with
  | nil => rfl
  | cons m ms ih =>
    change evaluate n f (substituteMonomial i form m ++ substitute i form ms) = _
    rw [evaluate_append, evaluate_substitute_monomial n f i hi, ih, evaluate_cons]

theorem xor_zero_iff : ∀ a b : Bool, (a ^^ b) = false ↔ a = b := by decide

theorem update_of_equation (n : Nat) (f : Nat → Bool) (i : Nat) (hi : i < n)
    (form : List Nat) (h : evaluate n f ((2^i) :: form) = false) :
    update f i (evaluate n f form) = f := by
  rw [evaluate_cons, monomial_unit n f i hi, xor_zero_iff] at h
  funext j
  by_cases he : j = i
  · subst j; simp [update, h]
  · simp [update, he]

#print axioms evaluate_normalize
#print axioms evaluate_substitute
#print axioms update_of_equation
end H12CertificateTheory

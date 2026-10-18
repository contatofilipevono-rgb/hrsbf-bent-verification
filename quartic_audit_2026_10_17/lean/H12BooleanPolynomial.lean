import H12Descent

/-! Elementary semantics for Boolean polynomials represented by lists of
monomial masks. Repeated monomials cancel, and multiplication uses mask union.
-/
namespace H12BooleanPolynomial

def monomial (n : Nat) (assignment : Nat → Bool) (mask : Nat) : Bool :=
  ((List.range n).filter (fun i => mask.testBit i)).all assignment

def evaluate (n : Nat) (assignment : Nat → Bool) (polynomial : List Nat) : Bool :=
  polynomial.foldr (fun mask value => monomial n assignment mask ^^ value) false

theorem all_filter_or (xs : List Nat) (p q f : Nat → Bool) :
    (xs.filter (fun i => p i || q i)).all f =
      ((xs.filter p).all f && (xs.filter q).all f) := by
  induction xs with
  | nil => simp
  | cons a xs ih =>
    cases hp : p a <;> cases hq : q a <;> cases hf : f a <;>
      simp [hp, hq, hf, ih]

theorem monomial_union (n : Nat) (f : Nat → Bool) (a b : Nat) :
    monomial n f (a ||| b) = (monomial n f a && monomial n f b) := by
  unfold monomial
  simp only [Nat.testBit_or]
  exact all_filter_or _ _ _ _

theorem monomial_zero (n : Nat) (f : Nat → Bool) : monomial n f 0 = true := by
  simp [monomial]

theorem monomial_unit (n : Nat) (f : Nat → Bool) (j : Nat) (hj : j < n) :
    monomial n f (2^j) = f j := by
  apply Bool.eq_iff_iff.mpr
  constructor
  · intro h
    apply List.all_eq_true.mp h j
    simp [List.mem_filter, List.mem_range, hj, Nat.testBit_two_pow]
  · intro h
    apply List.all_eq_true.mpr
    intro i hi
    have hh := List.mem_filter.mp hi
    have heq : j = i := by simpa only [Nat.testBit_two_pow, decide_eq_true_eq] using hh.2
    simpa [← heq] using h

theorem evaluate_nil (n : Nat) (f : Nat → Bool) : evaluate n f [] = false := rfl
theorem evaluate_cons (n : Nat) (f : Nat → Bool) (m : Nat) (ms : List Nat) :
    evaluate n f (m :: ms) = (monomial n f m ^^ evaluate n f ms) := rfl

theorem evaluate_append (n : Nat) (f : Nat → Bool) (xs ys : List Nat) :
    evaluate n f (xs ++ ys) = (evaluate n f xs ^^ evaluate n f ys) := by
  induction xs with
  | nil => simp [evaluate]
  | cons a xs ih => simp only [List.cons_append, evaluate_cons, ih, Bool.xor_assoc]

theorem evaluate_permutation (n : Nat) (f : Nat → Bool) {xs ys : List Nat}
    (h : xs.Perm ys) : evaluate n f xs = evaluate n f ys := by
  induction h with
  | nil => rfl
  | cons a _ ih => simp only [evaluate_cons, ih]
  | swap => simp only [evaluate_cons]; exact Bool.xor_left_comm _ _ _
  | trans _ _ ih₁ ih₂ => exact ih₁.trans ih₂

theorem evaluate_map_union (n : Nat) (f : Nat → Bool) (xs : List Nat) (m : Nat) :
    evaluate n f (xs.map (fun a => a ||| m)) =
      (evaluate n f xs && monomial n f m) := by
  induction xs with
  | nil => simp [evaluate]
  | cons a xs ih =>
    simp only [List.map_cons, evaluate_cons, monomial_union, ih, Bool.and_xor_distrib_right]

theorem evaluate_multiply_variable (n : Nat) (f : Nat → Bool) (xs : List Nat)
    (j : Nat) (hj : j < n) :
    evaluate n f (xs.map (fun a => a ||| 2^j)) = (evaluate n f xs && f j) := by
  rw [evaluate_map_union, monomial_unit n f j hj]

theorem evaluate_flatten (n : Nat) (f : Nat → Bool) (xs : List (List Nat)) :
    evaluate n f xs.flatten =
      xs.foldr (fun p v => evaluate n f p ^^ v) false := by
  induction xs with
  | nil => rfl
  | cons a xs ih => simp only [List.flatten_cons, evaluate_append, List.foldr_cons, ih]

def paired (xs : List Nat) : List Nat := xs.flatMap (fun m => [m,m])
theorem evaluate_paired (n : Nat) (f : Nat → Bool) (xs : List Nat) :
    evaluate n f (paired xs) = false := by
  induction xs with
  | nil => rfl
  | cons a xs ih =>
    simp only [paired, List.flatMap_cons, evaluate_append, evaluate_cons, evaluate_nil,
      Bool.xor_false, Bool.false_xor, Bool.xor_self] at ih ⊢
    exact ih

theorem permutation_of_sorted (xs ys : List Nat) (fuel : Nat)
    (h : H12Descent.sortFuel fuel xs = H12Descent.sortFuel fuel ys) : xs.Perm ys :=
  (H12Descent.sort_perm fuel xs).symm.trans
    ((List.Perm.of_eq h).trans (H12Descent.sort_perm fuel ys))

#print axioms evaluate_map_union
#print axioms evaluate_permutation
end H12BooleanPolynomial

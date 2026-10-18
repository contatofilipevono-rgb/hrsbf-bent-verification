import H12BooleanPolynomial

namespace H12Weight
universe u
variable {α : Type u}

def parity (xs : List α) (f : α → Bool) : Bool := (xs.countP f).testBit 0
def carry (xs : List α) (f : α → Bool) : Bool := (xs.countP f).testBit 1

theorem low_successor (n : Nat) : (n+1).testBit 0 = !(n.testBit 0) := by
  cases h0 : n.testBit 0 <;> cases hs : (n+1).testBit 0 <;>
    simp_all [Nat.testBit_eq_decide_div_mod_eq] <;> omega

theorem carry_successor (n : Nat) :
    (n+1).testBit 1 = (n.testBit 1 ^^ n.testBit 0) := by
  cases h0 : n.testBit 0 <;> cases h1 : n.testBit 1 <;> cases hs : (n+1).testBit 1 <;>
    simp_all only [Nat.testBit_eq_decide_div_mod_eq, Nat.pow_zero, Nat.div_one,
      Nat.pow_one, decide_eq_true_eq, decide_eq_false_iff_not,
      Bool.false_xor, Bool.true_xor, Bool.not_false, Bool.not_true] <;> omega

theorem parity_cons (a : α) (xs : List α) (f : α → Bool) :
    parity (a :: xs) f = (f a ^^ parity xs f) := by
  cases h : f a
  · simp [parity, h]
  · rw [Bool.true_xor]
    change ((a :: xs).countP f).testBit 0 = !(xs.countP f).testBit 0
    rw [List.countP_cons]
    simp only [h, ↓reduceIte]
    exact low_successor _

theorem carry_cons (a : α) (xs : List α) (f : α → Bool) :
    carry (a :: xs) f = (carry xs f ^^ (f a && parity xs f)) := by
  cases h : f a <;> simp [carry, parity, h, carry_successor]

theorem parity_zero (xs : List α) : parity xs (fun _ => false) = false := by simp [parity]
theorem carry_zero (xs : List α) : carry xs (fun _ => false) = false := by simp [carry]

theorem xor_four : ∀ a b c d : Bool, ((a ^^ b) ^^ (c ^^ d)) = ((a ^^ c) ^^ (b ^^ d)) := by decide

theorem parity_xor (xs : List α) (f g : α → Bool) :
    parity xs (fun x => f x ^^ g x) = (parity xs f ^^ parity xs g) := by
  induction xs with
  | nil => simp [parity]
  | cons a xs ih =>
    rw [parity_cons, parity_cons, parity_cons, ih]
    exact xor_four ..

theorem step_identity : ∀ a b p q c d t : Bool,
    ((c ^^ d ^^ (p && q) ^^ t) ^^ ((a ^^ b) && (p ^^ q))) =
      ((c ^^ (a && p)) ^^ (d ^^ (b && q)) ^^ ((a ^^ p) && (b ^^ q)) ^^ ((a && b) ^^ t)) := by decide

theorem carry_polar (xs : List α) (f g : α → Bool) :
    carry xs (fun x => f x ^^ g x) =
      (carry xs f ^^ carry xs g ^^ (parity xs f && parity xs g) ^^
        parity xs (fun x => f x && g x)) := by
  induction xs with
  | nil => simp [carry, parity]
  | cons a xs ih =>
    rw [carry_cons, ih, parity_xor, carry_cons, carry_cons,
      parity_cons, parity_cons, parity_cons]
    exact step_identity ..

def polar (xs : List α) (f g : α → Bool) : Bool :=
  (parity xs f && parity xs g) ^^ parity xs (fun x => f x && g x)

theorem carry_xor (xs : List α) (f g : α → Bool) :
    carry xs (fun x => f x ^^ g x) = (carry xs f ^^ carry xs g ^^ polar xs f g) := by
  rw [carry_polar]
  simp only [polar, Bool.xor_assoc]

theorem parity_scale (xs : List α) (c : Bool) (f : α → Bool) :
    parity xs (fun x => c && f x) = (c && parity xs f) := by
  cases c <;> simp [parity_zero]

theorem carry_scale (xs : List α) (c : Bool) (f : α → Bool) :
    carry xs (fun x => c && f x) = (c && carry xs f) := by
  cases c <;> simp [carry_zero]

theorem polar_xor_right (xs : List α) (f g h : α → Bool) :
    polar xs f (fun x => g x ^^ h x) = (polar xs f g ^^ polar xs f h) := by
  unfold polar
  rw [parity_xor, Bool.and_xor_distrib_left]
  have he : (fun x => f x && (g x ^^ h x)) = (fun x => (f x && g x) ^^ (f x && h x)) := by
    funext x; exact Bool.and_xor_distrib_left ..
  rw [he, parity_xor]
  exact xor_four ..

theorem polar_scale_left (xs : List α) (c : Bool) (f g : α → Bool) :
    polar xs (fun x => c && f x) g = (c && polar xs f g) := by
  cases c <;> simp [polar, parity_zero]

theorem polar_scale_right (xs : List α) (c : Bool) (f g : α → Bool) :
    polar xs f (fun x => c && g x) = (c && polar xs f g) := by
  cases c <;> simp [polar, parity_zero]

#print axioms carry_polar
#print axioms polar_xor_right

open H12BooleanPolynomial

def combine (coeff : Nat → Bool) : List (Nat × (α → Bool)) → α → Bool
  | [], _ => false
  | (i,v) :: rest, x => (coeff i && v x) ^^ combine coeff rest x

def pairTerms (xs : List α) (i : Nat) (v : α → Bool) : List (Nat × (α → Bool)) → List Nat
  | [] => []
  | (j,w) :: rest => (if polar xs v w then [(2^i) ||| (2^j)] else []) ++ pairTerms xs i v rest

def rowPolynomial (xs : List α) : List (Nat × (α → Bool)) → List Nat
  | [] => []
  | (i,v) :: rest =>
      (if carry xs v then [2^i] else []) ++ pairTerms xs i v rest ++ rowPolynomial xs rest

theorem evaluate_linear_term (n : Nat) (coeff : Nat → Bool) (i : Nat) (hi : i < n) (b : Bool) :
    evaluate n coeff (if b then [2^i] else []) = (coeff i && b) := by
  cases b <;> simp only [Bool.false_eq_true, ↓reduceIte, evaluate_nil, evaluate_cons, monomial_unit n coeff i hi,
    Bool.and_false, Bool.and_true, Bool.xor_false]

theorem evaluate_pair_term (n : Nat) (coeff : Nat → Bool) (i j : Nat)
    (hi : i < n) (hj : j < n) (b : Bool) :
    evaluate n coeff (if b then [(2^i) ||| (2^j)] else []) = (coeff i && coeff j && b) := by
  cases b <;> simp only [Bool.false_eq_true, ↓reduceIte, evaluate_nil, evaluate_cons,
    monomial_union, monomial_unit n coeff i hi, monomial_unit n coeff j hj,
    Bool.and_false, Bool.and_true, Bool.xor_false]

theorem pair_step : ∀ a b p q : Bool,
    ((a && b && p) ^^ (a && q)) = (a && ((b && p) ^^ q)) := by decide

theorem evaluate_pairTerms (n : Nat) (coeff : Nat → Bool) (xs : List α)
    (i : Nat) (hi : i < n) (v : α → Bool) (rows : List (Nat × (α → Bool)))
    (bounds : ∀ row ∈ rows, row.1 < n) :
    evaluate n coeff (pairTerms xs i v rows) = (coeff i && polar xs v (combine coeff rows)) := by
  induction rows with
  | nil => simp [pairTerms, combine, evaluate_nil, polar, parity_zero]
  | cons row rest ih =>
    rcases row with ⟨j,w⟩
    have hj := bounds (j,w) List.mem_cons_self
    have ht := ih (fun row h => bounds row (List.mem_cons_of_mem (j,w) h))
    rw [pairTerms, evaluate_append, evaluate_pair_term n coeff i j hi hj, ht]
    change _ = (coeff i && polar xs v (fun x => (coeff j && w x) ^^ combine coeff rest x))
    rw [polar_xor_right, polar_scale_right]
    exact pair_step ..

theorem xor_reorder : ∀ a b c : Bool, (a ^^ b ^^ c) = (a ^^ c ^^ b) := by decide

theorem carry_of_combination (n : Nat) (coeff : Nat → Bool) (xs : List α)
    (rows : List (Nat × (α → Bool))) (bounds : ∀ row ∈ rows, row.1 < n) :
    evaluate n coeff (rowPolynomial xs rows) = carry xs (combine coeff rows) := by
  induction rows with
  | nil => simp [rowPolynomial, combine, carry_zero, evaluate_nil]
  | cons row rest ih =>
    rcases row with ⟨i,v⟩
    have hi := bounds (i,v) List.mem_cons_self
    have ht := ih (fun row h => bounds row (List.mem_cons_of_mem (i,v) h))
    rw [rowPolynomial, evaluate_append, evaluate_append,
      evaluate_linear_term n coeff i hi, evaluate_pairTerms n coeff xs i hi v rest
        (fun row h => bounds row (List.mem_cons_of_mem (i,v) h)), ht]
    change _ = carry xs (fun x => (coeff i && v x) ^^ combine coeff rest x)
    rw [carry_xor, carry_scale, polar_scale_left]
    simp only [Bool.xor_assoc]
    exact congrArg (fun b => (coeff i && carry xs v) ^^ b) (Bool.xor_comm _ _)

#print axioms carry_of_combination
end H12Weight

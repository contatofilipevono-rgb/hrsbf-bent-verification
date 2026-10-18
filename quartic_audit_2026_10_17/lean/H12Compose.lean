import H12Affine

namespace H12Compose
open H12BooleanPolynomial

def multiply (p q : List Nat) : List Nat := p.flatMap (fun m => q.map (fun n => n ||| m))

theorem evaluate_multiply (n : Nat) (f : Nat → Bool) (p q : List Nat) :
    evaluate n f (multiply p q) = (evaluate n f p && evaluate n f q) := by
  induction p with
  | nil => simp [multiply, evaluate_nil]
  | cons m p ih =>
    simp only [multiply, List.flatMap_cons, evaluate_append] at *
    rw [evaluate_map_union, ih, Bool.and_comm (evaluate n f q)]
    rw [evaluate_cons, Bool.and_xor_distrib_right]

def product (env : Nat → List Nat) (indices : List Nat) : List Nat :=
  indices.foldr (fun i p => multiply (env i) p) [0]

theorem evaluate_product (n : Nat) (f : Nat → Bool) (env : Nat → List Nat) (indices : List Nat) :
    evaluate n f (product env indices) = indices.all (fun i => evaluate n f (env i)) := by
  induction indices with
  | nil => simp [product, evaluate_cons, evaluate_nil, monomial_zero]
  | cons i indices ih =>
    simp only [product, List.foldr_cons, List.all_cons] at *
    rw [evaluate_multiply, ih]

def imageMonomial (source : Nat) (env : Nat → List Nat) (mask : Nat) : List Nat :=
  product env ((List.range source).filter mask.testBit)

def compose (source : Nat) (env : Nat → List Nat) (p : List Nat) : List Nat :=
  p.flatMap (imageMonomial source env)

theorem evaluate_imageMonomial (source target : Nat) (f : Nat → Bool)
    (env : Nat → List Nat) (mask : Nat) :
    evaluate target f (imageMonomial source env mask) =
      monomial source (fun i => evaluate target f (env i)) mask := by
  exact evaluate_product target f env _

theorem evaluate_compose (source target : Nat) (f : Nat → Bool)
    (env : Nat → List Nat) (p : List Nat) :
    evaluate target f (compose source env p) =
      evaluate source (fun i => evaluate target f (env i)) p := by
  induction p with
  | nil => rfl
  | cons m p ih =>
    simp only [compose, List.flatMap_cons, evaluate_append] at *
    rw [evaluate_imageMonomial, ih, evaluate_cons]

theorem monomial_congr (n : Nat) (f g : Nat → Bool) (mask : Nat)
    (h : ∀ i, i < n → f i = g i) : monomial n f mask = monomial n g mask := by
  apply H12Truth.all_congr_on
  intro i hi
  exact h i (List.mem_range.mp (List.mem_filter.mp hi).1)

theorem evaluate_congr (n : Nat) (f g : Nat → Bool) (p : List Nat)
    (h : ∀ i, i < n → f i = g i) : evaluate n f p = evaluate n g p := by
  induction p with
  | nil => rfl
  | cons m p ih => rw [evaluate_cons, evaluate_cons, monomial_congr n f g m h, ih]

theorem affine_substitution (k : Nat) (u : BitVec 36) (p : List Nat) :
    evaluate 36 u.getLsbD (compose 43 (H12Affine.rowU k) p) =
      evaluate 43 (H12Affine.embed k u).getLsbD p := by
  rw [evaluate_compose]
  apply evaluate_congr
  intro i hi
  exact (H12Affine.get_fromFn (fun t : Fin 43 => evaluate 36 u.getLsbD (H12Affine.rowU k t.val)) i hi).symm

#print axioms affine_substitution
end H12Compose

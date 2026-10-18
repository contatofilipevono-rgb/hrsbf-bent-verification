import H12Bits

namespace H12TablePolynomial
open H12Bits H12Weight

def tableRows (rows : List (Nat × Nat)) : List (Nat × (Nat → Bool)) :=
  rows.map (fun row => (row.1, fun x => row.2.testBit x))

def fastPolar (depth a b : Nat) : Bool :=
  (foldParity depth a && foldParity depth b) ^^ foldParity depth (a &&& b)

theorem fastPolar_sound (depth a b : Nat) :
    fastPolar depth a b = polar (List.range (2^depth)) a.testBit b.testBit := by
  simp only [fastPolar, foldParity_sound, Nat.testBit_and, polar]

def fastPairTerms (depth i value : Nat) : List (Nat × Nat) → List Nat
  | [] => []
  | (j,w) :: rest =>
      (if fastPolar depth value w then [(2^i) ||| (2^j)] else []) ++ fastPairTerms depth i value rest

def fastPolynomial (depth : Nat) : List (Nat × Nat) → List Nat
  | [] => []
  | (i,value) :: rest =>
      (if fastCarry depth value then [2^i] else []) ++
        fastPairTerms depth i value rest ++ fastPolynomial depth rest

theorem fastPairTerms_sound (depth i value : Nat) (rows : List (Nat × Nat)) :
    fastPairTerms depth i value rows =
      pairTerms (List.range (2^depth)) i value.testBit (tableRows rows) := by
  induction rows with
  | nil => rfl
  | cons row rest ih =>
    rcases row with ⟨j,w⟩
    simp only [fastPairTerms, tableRows, List.map_cons, pairTerms, fastPolar_sound] at *
    rw [ih]

theorem fastPolynomial_sound (depth : Nat) (rows : List (Nat × Nat)) :
    fastPolynomial depth rows = rowPolynomial (List.range (2^depth)) (tableRows rows) := by
  induction rows with
  | nil => rfl
  | cons row rest ih =>
    rcases row with ⟨i,v⟩
    simp only [fastPolynomial, tableRows, List.map_cons, rowPolynomial,
      fastCarry_sound, fastPairTerms_sound] at *
    rw [ih]

#print axioms fastPolynomial_sound
end H12TablePolynomial

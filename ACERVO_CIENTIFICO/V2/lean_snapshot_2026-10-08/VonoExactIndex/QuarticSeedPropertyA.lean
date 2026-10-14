import Mathlib.Data.Finset.Card

/-!
# Quartic seed: contraction criterion directly from fourth differences

This module intentionally does NOT assume multilinearity of D4.
It checks the fourth derivative on all 28 basis pairs for each of the
65536 ordered pairs of directions, then uses the parity contraction
certificate. It is a finite bridge, not a general multilinearity proof.

WARNING: `native_decide` over this domain may be computationally expensive.
Compilation status is recorded in the accompanying real build log.
-/
namespace VonoExactIndex.QuarticSeedPropertyA

private def orbitSeeds : List (List Nat) :=
  [[0,1,2,3], [0,1,2,5], [0,1,3,5]]
private def rotateSet (k : Nat) (s : List Nat) : Finset Nat :=
  (s.map (fun i => (i+k)%8)).toFinset
private def coefficient (s : Finset Nat) : Bool := Id.run do
  let mut parity := false
  for seed in orbitSeeds do
    for k in [:8] do
      if rotateSet k seed == s then parity := !parity
  return parity
def seedFormula (x : Nat) : Bool := Id.run do
  let mut parity := false
  for t in orbitSeeds do
    for k in [:8] do
      if t.all (fun i => x.testBit ((i+k)%8)) then parity := !parity
  return parity
private def seedTable : Array Bool :=
  ((List.range 256).map seedFormula).toArray
/-- Tabulation of the explicit cyclic-orbit formula on the eight-bit domain. -/
def seed (x : Nat) : Bool := seedTable[x % 256]!
theorem seed_matches_formula : ∀ x : Fin 256, seed x.val = seedFormula x.val := by
  native_decide

def diff (a : Nat) (g : Nat → Bool) (x : Nat) : Bool :=
  g x != g (Nat.xor x a)
def fourth (a b c d : Nat) : Bool :=
  diff a (diff b (diff c (diff d seed))) 0
def pairs : Array (Nat × Nat) :=
  ((List.range 8).flatMap (fun i =>
    (List.range 8).filterMap (fun j =>
      if i < j then some (i,j) else none))).toArray
private def entryFormula (p q : Nat) : Bool :=
  let a := pairs[p]!
  let b := pairs[q]!
  let s := ([a.1,a.2,b.1,b.2] : List Nat).toFinset
  s.card == 4 && coefficient s
private def entryTable : Array (Array Bool) :=
  ((List.range 28).map (fun p =>
    ((List.range 28).map (entryFormula p)).toArray)).toArray
private def entry (p q : Nat) : Bool := entryTable[p]![q]!

private def wedge (a b p : Nat) : Bool :=
  let ij := pairs[p]!
  (a.testBit ij.1 && b.testBit ij.2) !=
  (a.testBit ij.2 && b.testBit ij.1)
private def parityContraction (a b p : Nat) : Bool :=
  (List.range 28).foldl
    (fun acc q => acc != (entry p q && wedge a b q)) false
def dependent (a b : Nat) : Bool :=
  a == 0 || b == 0 || a == b

/-- Every fourth derivative on a basis pair equals the contraction
    coefficient for arbitrary first two directions. -/
theorem fourth_pair_basis_matches_contraction :
    ∀ a b : Fin 256, ∀ p : Fin 28,
      let ij := pairs[p.val]!
      fourth a.val b.val (2 ^ ij.1) (2 ^ ij.2) =
        parityContraction a.val b.val p.val := by
  native_decide

/-- The verified contraction kernel contains no independent pair. -/
theorem contraction_zero_implies_dependent :
    ∀ a b : Fin 256,
      (∀ p : Fin 28, parityContraction a.val b.val p.val = false) →
      dependent a.val b.val = true := by
  native_decide

/-- Combined finite certificate for arbitrary a,b and basis c,d.
    A hypothesis over all c,d includes these basis pairs. -/
theorem fourth_basis_zero_implies_dependent :
    ∀ a b : Fin 256,
      (∀ p : Fin 28,
        let ij := pairs[p.val]!
        fourth a.val b.val (2 ^ ij.1) (2 ^ ij.2) = false) →
      dependent a.val b.val = true := by
  intro a b h
  apply contraction_zero_implies_dependent a b
  intro p
  have hbridge := fourth_pair_basis_matches_contraction a b p
  exact (hbridge ▸ h p)

/-- Property (A) for eight-bit vectors, represented by Fin 256.
Fourth differences are evaluated at zero; the hypothesis is over all directions.
-/
theorem seed_property_A (a b : Fin 256)
    (h : ∀ c d : Fin 256, fourth a.val b.val c.val d.val = false) :
    a = 0 ∨ b = 0 ∨ a = b := by
  have bounds : ∀ p : Fin 28,
      2 ^ (pairs[p.val]!).1 < 256 ∧ 2 ^ (pairs[p.val]!).2 < 256 := by
    native_decide
  have hd := fourth_basis_zero_implies_dependent a b (by
    intro p
    exact h ⟨2 ^ (pairs[p.val]!).1, (bounds p).1⟩
      ⟨2 ^ (pairs[p.val]!).2, (bounds p).2⟩)
  simpa [dependent, Bool.or_eq_true, Fin.ext_iff, or_assoc] using hd


end VonoExactIndex.QuarticSeedPropertyA

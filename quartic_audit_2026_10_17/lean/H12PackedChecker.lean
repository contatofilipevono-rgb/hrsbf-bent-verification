import H12PackedSparse
namespace H12PackedChecker
open H12PackedPolynomial H12PackedSparse

inductive Tree where
  | contradiction (indices : List Nat)
  | eliminate (i a : Nat) (indices : List Nat) (child : Tree)
  | split (i a : Nat) (zero one : Tree)
  | terminal (witness : Nat)

def boundedCheck (ps : List Nat) : Bool := ps.all (fun p => decide (p < 2^1333))

theorem boundedCheck_sound (ps : List Nat) (hc : boundedCheck ps = true) : packedBounded ps := by
  intro p hp
  exact of_decide_eq_true (List.all_eq_true.mp hc p hp)

def check (terminal : Nat → List Nat → Bool) : Tree → List Nat → List Nat → Bool
  | tree, ps, env => boundedCheck ps && boundedCheck env &&
      match tree with
      | .contradiction indices => decide (packedSelected indices ps < 2^1333) &&
          (scanCanonicalize (packedSelected indices ps) == 1)
      | .eliminate i a indices child => decide (i < 36) &&
          decide (packedSelected indices ps < 2^1333) &&
          (scanCanonicalize (packedSelected indices ps) == affineNative (2^(i+1) ^^^ a)) &&
          check terminal child (directTransform i a ps) (directTransform i a env)
      | .split i a zero one => decide (i < 36) &&
          check terminal zero (directTransform i a ps) (directTransform i a env) &&
          check terminal one (directTransform i (a ^^^ 1) ps) (directTransform i (a ^^^ 1) env)
      | .terminal w => terminal w env

theorem check_produces_refutation (target : List Bool → Prop)
    (terminal : Nat → List Nat → Bool)
    (terminal_sound : ∀ w env, terminal w env = true → ∀ f, ¬target (packedObservation f env))
    (tree : Tree) : ∀ ps env, check terminal tree ps env = true → PackedRefutes target ps env := by
  induction tree with
  | contradiction indices =>
    intro ps env hc
    simp only [check, Bool.and_eq_true, decide_eq_true_eq, beq_iff_eq] at hc
    exact .contradiction ps env indices hc.2.1 hc.2.2
  | eliminate i a indices child ih =>
    intro ps env hc
    simp only [check, Bool.and_eq_true, decide_eq_true_eq, beq_iff_eq] at hc
    have bp := boundedCheck_sound ps hc.1.1
    have be := boundedCheck_sound env hc.1.2
    have hr := ih _ _ hc.2.2
    rw [directTransform_eq i a ps bp, directTransform_eq i a env be] at hr
    exact .eliminate ps env i a hc.2.1.1.1 indices hc.2.1.1.2 hc.2.1.2 bp be hr
  | split i a zero one ih0 ih1 =>
    intro ps env hc
    simp only [check, Bool.and_eq_true, decide_eq_true_eq] at hc
    have bp := boundedCheck_sound ps hc.1.1
    have be := boundedCheck_sound env hc.1.2
    have hr0 := ih0 _ _ hc.2.1.2
    have hr1 := ih1 _ _ hc.2.2
    rw [directTransform_eq i a ps bp, directTransform_eq i a env be] at hr0
    rw [directTransform_eq i (a ^^^ 1) ps bp, directTransform_eq i (a ^^^ 1) env be] at hr1
    exact .split ps env i a hc.2.1.1 bp be hr0 hr1
  | terminal w =>
    intro ps env hc
    simp only [check, Bool.and_eq_true] at hc
    exact .terminal ps env (terminal_sound w env hc.2)

theorem check_sound (target : List Bool → Prop) (terminal : Nat → List Nat → Bool)
    (terminal_sound : ∀ w env, terminal w env = true → ∀ f, ¬target (packedObservation f env))
    (tree : Tree) (ps env : List Nat) (hc : check terminal tree ps env = true) :
    ∀ f, packedModels f ps → ¬target (packedObservation f env) :=
  packedRefutes_sound target ps env (check_produces_refutation target terminal terminal_sound tree ps env hc)

#print axioms check_sound
end H12PackedChecker

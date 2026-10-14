import VonoExactIndex.GraphClassification

namespace VonoExactIndex.GraphFamily
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem constant_second_vector (Q : Input ι → Output ι)
    (hQ : HasConstantSecondDifferences Q) (a b : Input ι) :
    ∃ k : Output ι, ∀ x, iterDiff [a,b] Q x = k := by
  classical
  choose k hk using fun i => hQ i a b
  refine ⟨k, ?_⟩
  intro x
  funext i
  exact congrFun (hk i) x

theorem quadratic_transform (Q : Input ι → Output ι)
    (hQ : HasConstantSecondDifferences Q)
    (A : Input ι ≃ₗ[ZMod 2] Input ι) (B : Output ι ≃ₗ[ZMod 2] Output ι) (t : Input ι) :
    HasConstantSecondDifferences (fun x => B (Q (A x + t))) := by
  intro i a b
  obtain ⟨k,hk⟩ := constant_second_vector Q hQ (A a) (A b)
  refine ⟨B k i, ?_⟩
  funext x
  have ht := congrFun (iterDiff_output [a,b] B (fun y => Q (A y + t))) x
  rw [iterDiff_input _ A t Q] at ht
  simp only [List.map_cons, List.map_nil, hk] at ht
  exact congrFun ht i

theorem quadratic_sum (Q R : Input ι → Output ι)
    (hQ : HasConstantSecondDifferences Q) (hR : HasConstantSecondDifferences R) :
    HasConstantSecondDifferences (fun x => Q x + R x) := by
  intro i a b
  exact second_constant_add _ _ a b (hQ i a b) (hR i a b)

/-- Perturbed representatives can only be EA-equivalent when their directed graphs are isomorphic. -/
theorem perturbed_EA_implies_graph_isomorphic (adjG adjH : ι → ι → Bool)
    (hG : Loopless adjG) (hH : Loopless adjH)
    (QG QH : Input ι → Output ι)
    (hQG : HasConstantSecondDifferences QG) (hQH : HasConstantSecondDifferences QH)
    (h : EAEquivalent (addVector (graphMap adjG) QG) (addVector (graphMap adjH) QH)) :
    GraphIsomorphic adjG adjH := by
  rcases h with ⟨A,B,t,L,k,he⟩
  apply quadraticEA_implies_graph_isomorphic adjG adjH hG hH
  let R : Input ι → Output ι := fun x => (B (QG (A x + t)) + (L x + k)) + QH x
  have hR : HasConstantSecondDifferences R := by
    apply quadratic_sum _ _ _ hQH
    apply quadratic_sum
    · exact quadratic_transform QG hQG A B t
    · intro i a b
      exact affine_second_constant ((LinearMap.proj i).comp L) (k i) a b
  refine ⟨A,B,t,R,hR,?_⟩
  intro x
  have hh := he x
  have hvec : addVector (graphMap adjG) QG (A x + t) =
      graphMap adjG (A x + t) + QG (A x + t) := rfl
  rw [hvec, B.map_add] at hh
  funext i
  have hs := congrFun hh i
  change graphMap adjH x i + QH x i =
    ((B (graphMap adjG (A x + t))) i + B (QG (A x + t)) i) + L x i + k i at hs
  change graphMap adjH x i = B (graphMap adjG (A x + t)) i +
    ((B (QG (A x + t)) i + (L x i + k i)) + QH x i)
  calc
    _ = (graphMap adjH x i + QH x i) + QH x i := by simp [add_assoc]
    _ = _ := by rw [hs]; abel

/-- Explicit quadratic ANF perturbations require no intrinsic-condition premise. -/
theorem ANF_perturbed_EA_implies_graph_isomorphic {κ : Type*} [Fintype κ]
    (adjG adjH : ι → ι → Bool) (hG : Loopless adjG) (hH : Loopless adjH)
    (cG cH : Output ι) (LG LH : Input ι →ₗ[ZMod 2] Output ι)
    (lG mG lH mH : κ → Input ι →ₗ[ZMod 2] ZMod 2) (wG wH : κ → Output ι)
    (h : EAEquivalent
      (addVector (graphMap adjG) (fun x i => cG i + LG x i + ∑ k, wG k i * (lG k x * mG k x)))
      (addVector (graphMap adjH) (fun x i => cH i + LH x i + ∑ k, wH k i * (lH k x * mH k x)))) :
    GraphIsomorphic adjG adjH :=
  perturbed_EA_implies_graph_isomorphic adjG adjH hG hH _ _
    (quadratic_ANF_second_constant cG LG lG mG wG)
    (quadratic_ANF_second_constant cH LH lH mH wH) h

#print axioms perturbed_EA_implies_graph_isomorphic
#print axioms ANF_perturbed_EA_implies_graph_isomorphic
end VonoExactIndex.GraphFamily

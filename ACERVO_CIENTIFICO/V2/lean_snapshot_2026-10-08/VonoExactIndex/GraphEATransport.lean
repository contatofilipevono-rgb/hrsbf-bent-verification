import VonoExactIndex.GraphStarFamily

namespace VonoExactIndex.GraphFamily
variable {ι : Type*} [Fintype ι] [DecidableEq ι]
abbrev Output (ι : Type*) := ι → ZMod 2

def vectorDiff (a : Input ι) (F : Input ι → Output ι) (x : Input ι) : Output ι :=
  F (x + a) + F x

def iterDiff : List (Input ι) → (Input ι → Output ι) → Input ι → Output ι
  | [], F => F
  | a :: as, F => vectorDiff a (iterDiff as F)

theorem iterDiff_add (as : List (Input ι)) (F G : Input ι → Output ι) :
    iterDiff as (fun x => F x + G x) = fun x => iterDiff as F x + iterDiff as G x := by
  induction as with
  | nil => rfl
  | cons a as ih =>
    funext x i
    simp only [iterDiff, vectorDiff, ih, Pi.add_apply]
    abel

theorem iterDiff_output (as : List (Input ι)) (B : Output ι ≃ₗ[ZMod 2] Output ι)
    (F : Input ι → Output ι) :
    iterDiff as (fun x => B (F x)) = fun x => B (iterDiff as F x) := by
  induction as with
  | nil => rfl
  | cons a as ih =>
    funext x
    simp only [iterDiff, vectorDiff, ih, map_add]

theorem iterDiff_input (as : List (Input ι)) (A : Input ι ≃ₗ[ZMod 2] Input ι)
    (t : Input ι) (F : Input ι → Output ι) :
    iterDiff as (fun x => F (A x + t)) = fun x => iterDiff (as.map A) F (A x + t) := by
  induction as with
  | nil => rfl
  | cons a as ih =>
    funext x
    simp only [iterDiff, vectorDiff, ih, List.map_cons, map_add]
    congr 1
    congr 1
    abel

theorem quadratic_third_zero (Q : Input ι → Output ι)
    (hQ : HasConstantSecondDifferences Q) (a b c x : Input ι) :
    iterDiff [a,b,c] Q x = 0 := by
  funext i
  rcases hQ i b c with ⟨k, hk⟩
  change diff a (diff b (diff c (fun y => Q y i))) x = 0
  rw [hk]
  simp [diff]

theorem quadratic_fourth_zero (Q : Input ι → Output ι)
    (hQ : HasConstantSecondDifferences Q) (a b c d x : Input ι) :
    iterDiff [a,b,c,d] Q x = 0 := by
  change iterDiff [b,c,d] Q (x + a) + iterDiff [b,c,d] Q x = 0
  rw [quadratic_third_zero Q hQ, quadratic_third_zero Q hQ, add_zero]

/-- Quadratic correction is permitted; ordinary affine EA correction is a special case. -/
def QuadraticEA (F G : Input ι → Output ι) : Prop :=
  ∃ (A : Input ι ≃ₗ[ZMod 2] Input ι) (B : Output ι ≃ₗ[ZMod 2] Output ι)
    (t : Input ι) (Q : Input ι → Output ι),
    HasConstantSecondDifferences Q ∧ ∀ x, G x = B (F (A x + t)) + Q x

def EAEquivalent (F G : Input ι → Output ι) : Prop :=
  ∃ (A : Input ι ≃ₗ[ZMod 2] Input ι) (B : Output ι ≃ₗ[ZMod 2] Output ι)
    (t : Input ι) (L : Input ι →ₗ[ZMod 2] Output ι) (k : Output ι),
    ∀ x, G x = B (F (A x + t)) + L x + k

theorem EAEquivalent.quadratic {F G : Input ι → Output ι} (h : EAEquivalent F G) :
    QuadraticEA F G := by
  rcases h with ⟨A,B,t,L,k,he⟩
  refine ⟨A,B,t,(fun x => L x + k),?_,?_⟩
  · intro i a b
    exact affine_second_constant ((LinearMap.proj i).comp L) (k i) a b
  · intro x
    simpa only [add_assoc] using he x

theorem representation_third (F G Q : Input ι → Output ι)
    (A : Input ι ≃ₗ[ZMod 2] Input ι) (B : Output ι ≃ₗ[ZMod 2] Output ι)
    (t : Input ι) (hQ : HasConstantSecondDifferences Q)
    (he : ∀ x, G x = B (F (A x + t)) + Q x) (a b c x : Input ι) :
    iterDiff [a,b,c] G x = B (iterDiff [A a,A b,A c] F (A x + t)) := by
  have hf : G = fun x => B (F (A x + t)) + Q x := funext he
  rw [hf, iterDiff_add, iterDiff_output _ B, iterDiff_input _ A]
  simp only [List.map_cons, List.map_nil, quadratic_third_zero Q hQ, add_zero]

theorem representation_fourth (F G Q : Input ι → Output ι)
    (A : Input ι ≃ₗ[ZMod 2] Input ι) (B : Output ι ≃ₗ[ZMod 2] Output ι)
    (t : Input ι) (hQ : HasConstantSecondDifferences Q)
    (he : ∀ x, G x = B (F (A x + t)) + Q x) (a b c d x : Input ι) :
    iterDiff [a,b,c,d] G x = B (iterDiff [A a,A b,A c,A d] F (A x + t)) := by
  have hf : G = fun x => B (F (A x + t)) + Q x := funext he
  rw [hf, iterDiff_add, iterDiff_output _ B, iterDiff_input _ A]
  simp only [List.map_cons, List.map_nil, quadratic_fourth_zero Q hQ, add_zero]

def PairDependent (a b : Input ι) : Prop := ∀ i, a i = 0 ∨ b i = 0 ∨ a i = b i

theorem fourth_pair_iff (adj : ι → ι → Bool) (a b : Input ι) :
    (∀ c d x, iterDiff [a,b,c,d] (graphMap adj) x = 0) ↔ PairDependent a b := by
  constructor
  · intro h i
    apply SeedPropertyABridge.seed_property_A
    intro c d
    have hh := congrFun (h (Pi.single i c) (Pi.single i d) 0) i
    change diff a (diff b (diff (Pi.single i c) (diff (Pi.single i d) (component adj i)))) 0 = 0 at hh
    rw [fourth_component] at hh
    simpa using hh
  · intro h c d x
    funext i
    change diff a (diff b (diff c (diff d (component adj i)))) x = 0
    rw [fourth_component]
    rcases h i with ha | hb | hab
    · rw [ha, diff_zero]; rfl
    · rw [hb, diff_zero]; simp [diff]
    · rw [hab, diff_self]; rfl

theorem representation_pair (adjG adjH : ι → ι → Bool)
    (A : Input ι ≃ₗ[ZMod 2] Input ι) (B : Output ι ≃ₗ[ZMod 2] Output ι)
    (t : Input ι) (Q : Input ι → Output ι) (hQ : HasConstantSecondDifferences Q)
    (he : ∀ x, graphMap adjH x = B (graphMap adjG (A x + t)) + Q x)
    (a b : Input ι) : PairDependent a b ↔ PairDependent (A a) (A b) := by
  rw [← fourth_pair_iff adjH, ← fourth_pair_iff adjG]
  constructor
  · intro h c d x
    have hh := representation_fourth _ _ _ A B t hQ he a b (A.symm c) (A.symm d)
      (A.symm (x - t))
    rw [h] at hh
    apply B.injective
    simpa using hh.symm
  · intro h c d x
    rw [representation_fourth _ _ _ A B t hQ he]
    rw [h]
    exact B.map_zero

end VonoExactIndex.GraphFamily

import VonoV3C.GraphMap

namespace VonoV3C.GraphFamily
variable {ι : Type*} [Fintype ι] [DecidableEq ι] {m : ℕ}

def vectorDiff (a : Input ι m) (F : Input ι m → Output ι)
    (x : Input ι m) : Output ι := F (x + a) + F x

def iterDiff : List (Input ι m) → (Input ι m → Output ι) → Input ι m → Output ι
  | [], F => F
  | a :: as, F => vectorDiff a (iterDiff as F)

theorem iterDiff_add (as : List (Input ι m)) (F G : Input ι m → Output ι) :
    iterDiff as (fun x => F x + G x) = fun x => iterDiff as F x + iterDiff as G x := by
  induction as with
  | nil => rfl
  | cons a as ih =>
    funext x i
    simp only [iterDiff, vectorDiff, ih, Pi.add_apply]
    abel

theorem iterDiff_output (as : List (Input ι m)) (B : Output ι ≃ₗ[Scalar] Output ι)
    (F : Input ι m → Output ι) :
    iterDiff as (fun x => B (F x)) = fun x => B (iterDiff as F x) := by
  induction as with
  | nil => rfl
  | cons a as ih =>
    funext x
    simp only [iterDiff, vectorDiff, ih, map_add]

theorem iterDiff_input (as : List (Input ι m)) (A : Input ι m ≃ₗ[Scalar] Input ι m)
    (t : Input ι m) (F : Input ι m → Output ι) :
    iterDiff as (fun x => F (A x + t)) = fun x => iterDiff (as.map A) F (A x + t) := by
  induction as with
  | nil => rfl
  | cons a as ih =>
    funext x
    simp only [iterDiff, vectorDiff, ih, List.map_cons, map_add]
    congr 1
    congr 1
    abel

/-- Ordinary EA: only an affine correction, encoded by its linear and constant parts. -/
def EAEquivalent (F G : Input ι m → Output ι) : Prop :=
  ∃ (A : Input ι m ≃ₗ[Scalar] Input ι m) (B : Output ι ≃ₗ[Scalar] Output ι)
    (t : Input ι m) (L : Input ι m →ₗ[Scalar] Output ι) (k : Output ι),
    ∀ x, G x = B (F (A x + t)) + (L x + k)

theorem affine_second_zero (L : Input ι m →ₗ[Scalar] Output ι)
    (k : Output ι) (a b x : Input ι m) :
    iterDiff [a,b] (fun y => L y + k) x = 0 := by
  funext i
  simp only [iterDiff, vectorDiff, map_add, Pi.add_apply, Pi.zero_apply, List.map_cons]
  ring_nf (config := { recursive := false })
  simp only [show (2 : Scalar) = 0 from rfl, show (4 : Scalar) = 0 from rfl,
    mul_zero, zero_mul, add_zero, zero_add]

theorem affine_third_zero (L : Input ι m →ₗ[Scalar] Output ι)
    (k : Output ι) (a b c x : Input ι m) :
    iterDiff [a,b,c] (fun y => L y + k) x = 0 := by
  change iterDiff [b,c] (fun y => L y + k) (x+a) +
    iterDiff [b,c] (fun y => L y + k) x = 0
  rw [affine_second_zero, affine_second_zero, add_zero]

theorem affine_fourth_zero (L : Input ι m →ₗ[Scalar] Output ι)
    (k : Output ι) (a b c d x : Input ι m) :
    iterDiff [a,b,c,d] (fun y => L y + k) x = 0 := by
  change iterDiff [b,c,d] (fun y => L y + k) (x+a) +
    iterDiff [b,c,d] (fun y => L y + k) x = 0
  rw [affine_third_zero, affine_third_zero, add_zero]

theorem representation_third (F G : Input ι m → Output ι)
    (A : Input ι m ≃ₗ[Scalar] Input ι m) (B : Output ι ≃ₗ[Scalar] Output ι)
    (t : Input ι m) (L : Input ι m →ₗ[Scalar] Output ι) (k : Output ι)
    (he : ∀ x, G x = B (F (A x+t)) + (L x+k)) (a b c x : Input ι m) :
    iterDiff [a,b,c] G x = B (iterDiff [A a,A b,A c] F (A x+t)) := by
  have hf : G = fun x => B (F (A x+t)) + (L x+k) := funext he
  rw [hf, iterDiff_add, iterDiff_output _ B, iterDiff_input _ A]
  simp only [List.map_cons, List.map_nil, affine_third_zero, add_zero]

theorem representation_fourth (F G : Input ι m → Output ι)
    (A : Input ι m ≃ₗ[Scalar] Input ι m) (B : Output ι ≃ₗ[Scalar] Output ι)
    (t : Input ι m) (L : Input ι m →ₗ[Scalar] Output ι) (k : Output ι)
    (he : ∀ x, G x = B (F (A x+t)) + (L x+k)) (a b c d x : Input ι m) :
    iterDiff [a,b,c,d] G x = B (iterDiff [A a,A b,A c,A d] F (A x+t)) := by
  have hf : G = fun x => B (F (A x+t)) + (L x+k) := funext he
  rw [hf, iterDiff_add, iterDiff_output _ B, iterDiff_input _ A]
  simp only [List.map_cons, List.map_nil, affine_fourth_zero, add_zero]

/-- Vector-valued fourth derivative, independent of graph and base point. -/
theorem graph_fourth (hm : 2 ≤ m) (adj : ι → ι → Bool)
    (a b c d x : Input ι m) : iterDiff [a,b,c,d] (graphMap hm adj) x =
    fun i => pfaffian (a i) (b i) (c i) (d i) := by
  funext i
  exact fourth_component hm adj i a b c d x

theorem fourth_pair_iff (hm : 2 ≤ m) (adj : ι → ι → Bool) (a b : Input ι m) :
    (∀ c d x, iterDiff [a,b,c,d] (graphMap hm adj) x = 0) ↔
      Blocks.QuarticPairZero a b := by
  simp only [graph_fourth, funext_iff, Pi.zero_apply]
  constructor
  · intro h c d i; exact h c d 0 i
  · intro h c d x i; exact h c d i

theorem representation_pair (hm : 2 ≤ m) (adjG adjH : ι → ι → Bool)
    (A : Input ι m ≃ₗ[Scalar] Input ι m) (B : Output ι ≃ₗ[Scalar] Output ι)
    (t : Input ι m) (L : Input ι m →ₗ[Scalar] Output ι) (k : Output ι)
    (he : ∀ x, graphMap hm adjH x = B (graphMap hm adjG (A x+t)) + (L x+k))
    (a b : Input ι m) :
    Blocks.QuarticPairZero a b ↔ Blocks.QuarticPairZero (A a) (A b) := by
  rw [← fourth_pair_iff hm adjH, ← fourth_pair_iff hm adjG]
  constructor
  · intro h c d x
    have hh := representation_fourth _ _ A B t L k he a b (A.symm c) (A.symm d)
      (A.symm (x-t))
    rw [h] at hh
    apply B.injective
    simpa using hh.symm
  · intro h c d x
    rw [representation_fourth _ _ A B t L k he, h]
    exact B.map_zero

/-- Block recovery now follows from actual graph EA data, without a tensor premise. -/
theorem EA_recovers_blocks (hm : 2 ≤ m) (adjG adjH : ι → ι → Bool)
    (A : Input ι m ≃ₗ[Scalar] Input ι m) (B : Output ι ≃ₗ[Scalar] Output ι)
    (t : Input ι m) (L : Input ι m →ₗ[Scalar] Output ι) (k : Output ι)
    (he : ∀ x, graphMap hm adjH x = B (graphMap hm adjG (A x+t)) + (L x+k)) :
    ∃ perm : ι ≃ ι, ∀ i, ∃ e : Vec m ≃ₗ[Scalar] Vec m,
      ∀ v, A (Pi.single i v) = Pi.single (perm i) (e v) := by
  exact Blocks.recover_blocks_from_quartic hm A (representation_pair hm adjG adjH A B t L k he)

end VonoV3C.GraphFamily

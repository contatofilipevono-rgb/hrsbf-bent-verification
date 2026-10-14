import VonoV3C.GraphRelaxedIndex
import VonoV3C.GraphEATransport

open scoped BigOperators
namespace VonoV3C.GraphFamily
variable {ι : Type*} [Fintype ι] [DecidableEq ι] {m : ℕ}

def IsScalarConstant (f : Input ι m → Scalar) : Prop :=
  ∃ z : Scalar, f = fun _ => z

/-- Intrinsic degree-at-most-two condition on every output coordinate. -/
def HasConstantSecondDifferences (Q : Input ι m → Output ι) : Prop :=
  ∀ i a b, IsScalarConstant (diff a (diff b (fun x => Q x i)))

def addVector (F Q : Input ι m → Output ι) : Input ι m → Output ι :=
  fun x => F x + Q x

theorem second_constant_add (f g : Input ι m → Scalar) (a b : Input ι m)
    (hf : IsScalarConstant (diff a (diff b f)))
    (hg : IsScalarConstant (diff a (diff b g))) :
    IsScalarConstant (diff a (diff b (fun x => f x + g x))) := by
  rcases hf with ⟨z, hz⟩
  rcases hg with ⟨w, hw⟩
  refine ⟨z + w, ?_⟩
  rw [diff_add, diff_add, hz, hw]

theorem quadratic_third_zero (Q : Input ι m → Output ι)
    (hQ : HasConstantSecondDifferences Q) (a b c x : Input ι m) :
    iterDiff [a,b,c] Q x = 0 := by
  funext i
  rcases hQ i b c with ⟨z, hz⟩
  change diff a (diff b (diff c (fun y => Q y i))) x = 0
  rw [hz]
  simp [diff]

theorem quadratic_fourth_zero (Q : Input ι m → Output ι)
    (hQ : HasConstantSecondDifferences Q) (a b c d x : Input ι m) :
    iterDiff [a,b,c,d] Q x = 0 := by
  change iterDiff [b,c,d] Q (x+a) + iterDiff [b,c,d] Q x = 0
  rw [quadratic_third_zero Q hQ, quadratic_third_zero Q hQ, add_zero]

theorem quadratic_add_third (F Q : Input ι m → Output ι)
    (hQ : HasConstantSecondDifferences Q) (a b c x : Input ι m) :
    iterDiff [a,b,c] (addVector F Q) x = iterDiff [a,b,c] F x := by
  change iterDiff [a,b,c] (fun y => F y + Q y) x = _
  rw [iterDiff_add]
  simp only [quadratic_third_zero Q hQ, add_zero]

theorem quadratic_add_fourth (F Q : Input ι m → Output ι)
    (hQ : HasConstantSecondDifferences Q) (a b c d x : Input ι m) :
    iterDiff [a,b,c,d] (addVector F Q) x = iterDiff [a,b,c,d] F x := by
  change iterDiff [a,b,c,d] (fun y => F y + Q y) x = _
  rw [iterDiff_add]
  simp only [quadratic_fourth_zero Q hQ, add_zero]

theorem vector_relaxed_add_iff (F Q : Input ι m → Output ι)
    (hQ : HasConstantSecondDifferences Q) (U : Submodule Scalar (Input ι m)) :
    IsVectorRelaxed (addVector F Q) U ↔ IsVectorRelaxed F U := by
  constructor
  · intro h i a ha b hb
    rcases h i a ha b hb with ⟨z, hz⟩
    have hs := second_constant_add (fun x => F x i + Q x i) (fun x => Q x i)
      a b ⟨z, funext hz⟩ (hQ i a b)
    have he : (fun x => (F x i + Q x i) + Q x i) = (fun x => F x i) := by
      funext x
      simp [add_assoc]
    rw [he] at hs
    rcases hs with ⟨w, hw⟩
    exact ⟨w, fun x => congrFun hw x⟩
  · intro h i a ha b hb
    rcases h i a ha b hb with ⟨z, hz⟩
    rcases second_constant_add (fun x => F x i) (fun x => Q x i)
      a b ⟨z, funext hz⟩ (hQ i a b) with ⟨w, hw⟩
    exact ⟨w, fun x => congrFun hw x⟩

theorem graph_quadratic_exact_index (hm : 2 ≤ m) (adj : ι → ι → Bool)
    (Q : Input ι m → Output ι) (hQ : HasConstantSecondDifferences Q) :
    HasVectorRelaxedIndex (addVector (graphMap hm adj) Q) (Fintype.card ι) := by
  rcases graph_has_exact_relaxed_index hm adj with ⟨hu, U, hU, hd⟩
  constructor
  · intro T hT
    exact hu T ((vector_relaxed_add_iff (graphMap hm adj) Q hQ T).mp hT)
  · exact ⟨U, (vector_relaxed_add_iff (graphMap hm adj) Q hQ U).mpr hU, hd⟩

theorem linear_second_zero_scalar (l : Input ι m →ₗ[Scalar] Scalar)
    (a b : Input ι m) : diff a (diff b l) = 0 := by
  funext x
  simp only [diff, map_add]
  calc
    _ = ((l x + l x) + (l x + l x)) + (l a + l a) + (l b + l b) := by abel
    _ = 0 := by simp

theorem affine_second_constant_scalar (l : Input ι m →ₗ[Scalar] Scalar)
    (k : Scalar) (a b : Input ι m) :
    IsScalarConstant (diff a (diff b (fun x => l x + k))) := by
  apply second_constant_add
  · exact ⟨0, linear_second_zero_scalar l a b⟩
  · refine ⟨0, ?_⟩
    funext x
    simp [diff]

theorem product_linear_second_constant (l n : Input ι m →ₗ[Scalar] Scalar)
    (a b : Input ι m) :
    IsScalarConstant (diff a (diff b (fun x => l x * n x))) := by
  refine ⟨l a * n b + l b * n a, ?_⟩
  funext x
  simp only [diff, map_add]
  ring_nf
  simp only [show (2 : Scalar) = 0 from rfl, show (4 : Scalar) = 0 from rfl,
    mul_zero, zero_mul, add_zero, zero_add]

/-- Explicit affine-plus-quadratic ANFs, with arbitrary coefficients and
products of arbitrary linear forms, satisfy the intrinsic condition. -/
theorem quadratic_ANF_second_constant {κ : Type*} [Fintype κ]
    (c : Output ι) (L : Input ι m →ₗ[Scalar] Output ι)
    (l n : κ → Input ι m →ₗ[Scalar] Scalar) (w : κ → Output ι) :
    HasConstantSecondDifferences
      (fun x i => c i + L x i + ∑ k, w k i * (l k x * n k x)) := by
  classical
  intro i a b
  have hterm (k : κ) : IsScalarConstant (diff a (diff b
      (fun x => w k i * (l k x * n k x)))) := by
    rcases product_linear_second_constant (l k) (n k) a b with ⟨z, hz⟩
    refine ⟨w k i * z, ?_⟩
    funext x
    have he : diff a (diff b (fun y => w k i * (l k y * n k y))) x =
        w k i * diff a (diff b (fun y => l k y * n k y)) x := by
      simp only [diff, mul_add]
    rw [he]
    exact congrArg (fun t => w k i * t) (congrFun hz x)
  choose z hz using hterm
  have hsum : IsScalarConstant
      (diff a (diff b (fun x => ∑ k, w k i * (l k x * n k x)))) := by
    refine ⟨∑ k, z k, ?_⟩
    funext x
    calc
      _ = ∑ k, diff a (diff b (fun y => w k i * (l k y * n k y))) x := by
        simp only [diff, Finset.sum_add_distrib]
      _ = ∑ k, z k := Finset.sum_congr rfl (fun k _ => congrFun (hz k) x)
  have haff := affine_second_constant_scalar ((LinearMap.proj i).comp L) (c i) a b
  have he : (fun x => c i + L x i) =
      (fun x => ((LinearMap.proj i).comp L) x + c i) := by
    funext x
    exact add_comm _ _
  rw [← he] at haff
  exact second_constant_add _ _ a b haff hsum

end VonoV3C.GraphFamily

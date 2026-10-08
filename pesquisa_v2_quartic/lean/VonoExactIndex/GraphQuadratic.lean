import VonoExactIndex.GraphConnected

namespace VonoExactIndex.GraphFamily
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- Intrinsic degree-at-most-two condition: every second difference is constant. -/
def HasConstantSecondDifferences (Q : Input ι → ι → ZMod 2) : Prop :=
  ∀ i a b, IsConstant (diff a (diff b (fun x => Q x i)))

def addVector (F Q : Input ι → ι → ZMod 2) : Input ι → ι → ZMod 2 :=
  fun x i => F x i + Q x i

theorem second_constant_add (f g : Input ι → ZMod 2) (a b : Input ι)
    (hf : IsConstant (diff a (diff b f))) (hg : IsConstant (diff a (diff b g))) :
    IsConstant (diff a (diff b (fun x => f x + g x))) := by
  rcases hf with ⟨c, hc⟩
  rcases hg with ⟨d, hd⟩
  refine ⟨c + d, ?_⟩
  rw [diff_add, diff_add, hc, hd]

theorem vector_relaxed_add_iff (F Q : Input ι → ι → ZMod 2)
    (hQ : HasConstantSecondDifferences Q) (U : Submodule (ZMod 2) (Input ι)) :
    IsVectorRelaxed (addVector F Q) U ↔ IsVectorRelaxed F U := by
  constructor
  · intro h i a ha b hb
    have hs := second_constant_add (fun x => F x i + Q x i) (fun x => Q x i)
      a b (h i a ha b hb) (hQ i a b)
    have he : (fun x => (F x i + Q x i) + Q x i) = (fun x => F x i) := by
      funext x
      simp [add_assoc]
    rwa [he] at hs
  · intro h i a ha b hb
    exact second_constant_add (fun x => F x i) (fun x => Q x i)
      a b (h i a ha b hb) (hQ i a b)

theorem cross_relaxed_add_iff (F Q : Input ι → ι → ZMod 2)
    (hQ : HasConstantSecondDifferences Q) (U T : Submodule (ZMod 2) (Input ι)) :
    CrossRelaxed (addVector F Q) U T ↔ CrossRelaxed F U T := by
  constructor
  · intro h i a ha b hb
    have hs := second_constant_add (fun x => F x i + Q x i) (fun x => Q x i)
      a b (h i a ha b hb) (hQ i a b)
    have he : (fun x => (F x i + Q x i) + Q x i) = (fun x => F x i) := by
      funext x
      simp [add_assoc]
    rwa [he] at hs
  · intro h i a ha b hb
    exact second_constant_add (fun x => F x i) (fun x => Q x i)
      a b (h i a ha b hb) (hQ i a b)

theorem graph_quadratic_exact_index (adj : ι → ι → Bool)
    (Q : Input ι → ι → ZMod 2) (hQ : HasConstantSecondDifferences Q) :
    HasVectorRelaxedIndex (addVector (graphMap adj) Q) (Fintype.card ι) := by
  rcases graph_has_exact_index adj with ⟨hu, U, hU, hd⟩
  constructor
  · intro T hT
    exact hu T ((vector_relaxed_add_iff (graphMap adj) Q hQ T).mp hT)
  · exact ⟨U, (vector_relaxed_add_iff (graphMap adj) Q hQ U).mpr hU, hd⟩

theorem graph_quadratic_no_relaxed_split (adj : ι → ι → Bool) (hconn : CutConnected adj)
    (Q : Input ι → ι → ZMod 2) (hQ : HasConstantSecondDifferences Q) :
    ¬ HasRelaxedSplit (addVector (graphMap adj) Q) := by
  rintro ⟨U, T, hU, hT, hs, hc⟩
  exact graph_no_relaxed_split adj hconn
    ⟨U, T, hU, hT, hs, (cross_relaxed_add_iff (graphMap adj) Q hQ U T).mp hc⟩

/-- Linear functions have zero second differences. -/
theorem linear_second_zero (l : Input ι →ₗ[ZMod 2] ZMod 2) (a b : Input ι) :
    diff a (diff b l) = 0 := by
  funext x
  simp only [diff, map_add]
  calc
    _ = ((l x + l x) + (l x + l x)) + (l a + l a) + (l b + l b) := by abel
    _ = 0 := by simp

theorem affine_second_constant (l : Input ι →ₗ[ZMod 2] ZMod 2) (k : ZMod 2)
    (a b : Input ι) : IsConstant (diff a (diff b (fun x => l x + k))) := by
  apply second_constant_add
  · exact ⟨0, linear_second_zero l a b⟩
  · refine ⟨0, ?_⟩
    funext x
    simp [diff]

/-- Standard quadratic ANF products are explicitly covered by the intrinsic condition. -/
theorem product_linear_second_constant
    (l m : Input ι →ₗ[ZMod 2] ZMod 2) (a b : Input ι) :
    IsConstant (diff a (diff b (fun x => l x * m x))) := by
  refine ⟨l a * m b + l b * m a, ?_⟩
  funext x
  simp only [diff, map_add]
  have h2 : (2 : ZMod 2) = 0 := by decide
  have h4 : (4 : ZMod 2) = 0 := by decide
  ring_nf
  simp [h2, h4]

/-- Every explicit affine-plus-quadratic ANF is certified without a degree assumption. -/
theorem quadratic_ANF_second_constant {κ : Type*} [Fintype κ]
    (c : ι → ZMod 2) (L : Input ι →ₗ[ZMod 2] (ι → ZMod 2))
    (l m : κ → Input ι →ₗ[ZMod 2] ZMod 2) (w : κ → ι → ZMod 2) :
    HasConstantSecondDifferences (fun x i => c i + L x i + ∑ k, w k i * (l k x * m k x)) := by
  classical
  intro i a b
  have hterm (k : κ) : IsConstant (diff a (diff b
      (fun x => w k i * (l k x * m k x)))) := by
    rcases product_linear_second_constant (l k) (m k) a b with ⟨z, hz⟩
    refine ⟨w k i * z, ?_⟩
    funext x
    have he : diff a (diff b (fun y => w k i * (l k y * m k y))) x =
        w k i * diff a (diff b (fun y => l k y * m k y)) x := by
      simp only [diff, mul_add]
    rw [he]
    exact congrArg (fun t => w k i * t) (congrFun hz x)
  choose z hz using hterm
  have hsum : IsConstant (diff a (diff b (fun x => ∑ k, w k i * (l k x * m k x)))) := by
    refine ⟨∑ k, z k, ?_⟩
    funext x
    calc
      _ = ∑ k, diff a (diff b (fun y => w k i * (l k y * m k y))) x := by
        simp only [diff, Finset.sum_add_distrib]
      _ = ∑ k, z k := Finset.sum_congr rfl (fun k _ => congrFun (hz k) x)
  have haff := affine_second_constant ((LinearMap.proj i).comp L) (c i) a b
  have he : (fun x => c i + L x i) =
      (fun x => ((LinearMap.proj i).comp L) x + c i) := by funext x; exact add_comm _ _
  rw [← he] at haff
  exact second_constant_add _ _ a b haff hsum

#print axioms graph_quadratic_exact_index
#print axioms graph_quadratic_no_relaxed_split
end VonoExactIndex.GraphFamily

import VonoV3C.GraphSplitting

namespace VonoV3C.GraphFamily
variable {ι : Type*} [Fintype ι] [DecidableEq ι] {m : ℕ}
variable {V₁ V₂ W₁ W₂ : Type*}
variable [AddCommGroup V₁] [Module Scalar V₁]
variable [AddCommGroup V₂] [Module Scalar V₂]
variable [AddCommGroup W₁] [Module Scalar W₁]
variable [AddCommGroup W₂] [Module Scalar W₂]

private theorem product_core_second_zero
    (A : Input ι m ≃ₗ[Scalar] V₁ × V₂) (t : V₁ × V₂)
    (B : (W₁ × W₂) →ₗ[Scalar] (Output ι))
    (g : V₁ → W₁) (h : V₂ → W₂) (i : ι) (a b : Input ι m)
    (ha : (A a).2 = 0) (hb : (A b).1 = 0) :
    diff a (diff b (fun x => (B (g (A x + t).1, h (A x + t).2)) i)) = 0 := by
  let f₁ : Input ι m → Scalar := fun x => (B (g (A x + t).1, 0)) i
  let f₂ : Input ι m → Scalar := fun x => (B (0, h (A x + t).2)) i
  have he : (fun x => (B (g (A x + t).1, h (A x + t).2)) i) =
      (fun x => f₁ x + f₂ x) := by
    funext x
    have hh := B.map_add (g (A x + t).1, 0) (0, h (A x + t).2)
    have hB : B (g (A x + t).1, h (A x + t).2) =
        B (g (A x + t).1, 0) + B (0, h (A x + t).2) := by simpa using hh
    exact congrFun hB i
  have h₁ : diff b f₁ = 0 := by
    funext x
    simp [diff, f₁, map_add, hb]
  have h₂ : diff a f₂ = 0 := by
    funext x
    simp [diff, f₂, map_add, ha]
  rw [he, diff_add, diff_add, h₁, diff_comm a b f₂, h₂]
  funext x
  simp [diff]

/-- Every nontrivial EA direct-product representation induces a forbidden input split.
Output B is allowed to be any linear map, so invertible EA output maps are included. -/
theorem EA_product_has_relaxed_split [Nontrivial V₁] [Nontrivial V₂]
    (F : Input ι m → Output ι)
    (A : Input ι m ≃ₗ[Scalar] V₁ × V₂) (t : V₁ × V₂)
    (B : (W₁ × W₂) →ₗ[Scalar] (Output ι))
    (g : V₁ → W₁) (h : V₂ → W₂)
    (L : Input ι m →ₗ[Scalar] (Output ι)) (k : Output ι)
    (hrepr : ∀ x, F x = B (g (A x + t).1, h (A x + t).2) + L x + k) :
    HasRelaxedSplit F := by
  let U := LinearMap.ker ((LinearMap.snd Scalar V₁ V₂).comp A.toLinearMap)
  let T := LinearMap.ker ((LinearMap.fst Scalar V₁ V₂).comp A.toLinearMap)
  have memU (x : Input ι m) : x ∈ U ↔ (A x).2 = 0 := Iff.rfl
  have memT (x : Input ι m) : x ∈ T ↔ (A x).1 = 0 := Iff.rfl
  have hU : U ≠ ⊥ := by
    obtain ⟨u, hu⟩ := exists_ne (0 : V₁)
    intro he
    have hm : A.symm (u, 0) ∈ U := (memU _).mpr (by simp)
    rw [he] at hm
    have hz := (Submodule.mem_bot _).mp hm
    have hh := congrArg (fun x => (A x).1) hz
    exact hu (by simpa using hh)
  have hT : T ≠ ⊥ := by
    obtain ⟨v, hv⟩ := exists_ne (0 : V₂)
    intro he
    have hm : A.symm (0, v) ∈ T := (memT _).mpr (by simp)
    rw [he] at hm
    have hz := (Submodule.mem_bot _).mp hm
    have hh := congrArg (fun x => (A x).2) hz
    exact hv (by simpa using hh)
  have hs : U ⊔ T = ⊤ := by
    apply top_unique
    intro x hx
    apply Submodule.mem_sup.mpr
    refine ⟨A.symm ((A x).1, 0), (memU _).mpr (by simp),
      A.symm (0, (A x).2), (memT _).mpr (by simp), ?_⟩
    calc
      _ = A.symm (((A x).1, 0) + (0, (A x).2)) := (A.symm.map_add _ _).symm
      _ = A.symm (A x) := by congr 1 <;> ext <;> simp
      _ = x := A.symm_apply_apply x
  refine ⟨U, T, hU, hT, hs, ?_⟩
  intro i a ha b hb
  have he : (fun x => F x i) =
      (fun x => (B (g (A x + t).1, h (A x + t).2)) i + (L x i + k i)) := by
    funext x
    have hh := congrFun (hrepr x) i
    simpa only [Pi.add_apply, add_assoc] using hh
  rw [he]
  apply second_constant_add
  · exact ⟨0, product_core_second_zero A t B g h i a b ((memU a).mp ha) ((memT b).mp hb)⟩
  · exact affine_second_constant_scalar ((LinearMap.proj i).comp L) (k i) a b

/-- Connected canonical graph functions are EA-indecomposable. -/
theorem graph_not_EA_product [Nontrivial V₁] [Nontrivial V₂]
    (hm : 2 ≤ m) (adj : ι → ι → Bool) (hconn : CutConnected adj)
    (A : Input ι m ≃ₗ[Scalar] V₁ × V₂) (t : V₁ × V₂)
    (B : (W₁ × W₂) →ₗ[Scalar] (Output ι))
    (g : V₁ → W₁) (h : V₂ → W₂)
    (L : Input ι m →ₗ[Scalar] (Output ι)) (k : Output ι) :
    ¬ (∀ x, graphMap hm adj x = B (g (A x + t).1, h (A x + t).2) + L x + k) := by
  intro hrepr
  exact graph_no_relaxed_split hm adj hconn
    (EA_product_has_relaxed_split (graphMap hm adj) A t B g h L k hrepr)

/-- EA indecomposability survives every perturbation with constant second differences. -/
theorem graph_quadratic_not_EA_product [Nontrivial V₁] [Nontrivial V₂]
    (hm : 2 ≤ m) (adj : ι → ι → Bool) (hconn : CutConnected adj)
    (Q : Input ι m → Output ι) (hQ : HasConstantSecondDifferences Q)
    (A : Input ι m ≃ₗ[Scalar] V₁ × V₂) (t : V₁ × V₂)
    (B : (W₁ × W₂) →ₗ[Scalar] (Output ι))
    (g : V₁ → W₁) (h : V₂ → W₂)
    (L : Input ι m →ₗ[Scalar] (Output ι)) (k : Output ι) :
    ¬ (∀ x, addVector (graphMap hm adj) Q x =
      B (g (A x + t).1, h (A x + t).2) + L x + k) := by
  intro hrepr
  exact graph_quadratic_no_relaxed_split hm adj hconn Q hQ
    (EA_product_has_relaxed_split (addVector (graphMap hm adj) Q) A t B g h L k hrepr)

/-- Unconditional version for every explicit quadratic ANF. The quadratic
derivative condition is discharged by the certified ANF theorem. -/
theorem graph_quadratic_ANF_not_EA_product [Nontrivial V₁] [Nontrivial V₂]
    {κ : Type*} [Fintype κ]
    (hm : 2 ≤ m) (adj : ι → ι → Bool) (hconn : CutConnected adj)
    (c : Output ι) (LQ : Input ι m →ₗ[Scalar] Output ι)
    (l n : κ → Input ι m →ₗ[Scalar] Scalar) (w : κ → Output ι)
    (A : Input ι m ≃ₗ[Scalar] V₁ × V₂) (t : V₁ × V₂)
    (B : (W₁ × W₂) →ₗ[Scalar] Output ι) (g : V₁ → W₁) (h : V₂ → W₂)
    (L : Input ι m →ₗ[Scalar] Output ι) (k : Output ι) :
    ¬ (∀ x, graphMap hm adj x +
      (fun i => c i + LQ x i + ∑ j, w j i * (l j x * n j x)) =
        B (g (A x + t).1, h (A x + t).2) + L x + k) := by
  exact graph_quadratic_not_EA_product hm adj hconn
    (fun x i => c i + LQ x i + ∑ j, w j i * (l j x * n j x))
    (quadratic_ANF_second_constant c LQ l n w) A t B g h L k

end VonoV3C.GraphFamily

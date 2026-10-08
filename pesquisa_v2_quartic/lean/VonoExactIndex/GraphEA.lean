import VonoExactIndex.GraphQuadratic

namespace VonoExactIndex.GraphFamily
variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {V₁ V₂ W₁ W₂ : Type*}
variable [AddCommGroup V₁] [Module (ZMod 2) V₁]
variable [AddCommGroup V₂] [Module (ZMod 2) V₂]
variable [AddCommGroup W₁] [Module (ZMod 2) W₁]
variable [AddCommGroup W₂] [Module (ZMod 2) W₂]

private theorem product_core_second_zero
    (A : Input ι ≃ₗ[ZMod 2] V₁ × V₂) (t : V₁ × V₂)
    (B : (W₁ × W₂) →ₗ[ZMod 2] (ι → ZMod 2))
    (g : V₁ → W₁) (h : V₂ → W₂) (i : ι) (a b : Input ι)
    (ha : (A a).2 = 0) (hb : (A b).1 = 0) :
    diff a (diff b (fun x => (B (g (A x + t).1, h (A x + t).2)) i)) = 0 := by
  let f₁ : Input ι → ZMod 2 := fun x => (B (g (A x + t).1, 0)) i
  let f₂ : Input ι → ZMod 2 := fun x => (B (0, h (A x + t).2)) i
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
  rw [he, diff_add, diff_add, h₁, diff_commute a b f₂, h₂]
  funext x
  simp [diff]

/-- Every nontrivial EA direct-product representation induces a forbidden input split.
Output B is allowed to be any linear map, so invertible EA output maps are included. -/
theorem EA_product_has_relaxed_split [Nontrivial V₁] [Nontrivial V₂]
    (F : Input ι → ι → ZMod 2)
    (A : Input ι ≃ₗ[ZMod 2] V₁ × V₂) (t : V₁ × V₂)
    (B : (W₁ × W₂) →ₗ[ZMod 2] (ι → ZMod 2))
    (g : V₁ → W₁) (h : V₂ → W₂)
    (L : Input ι →ₗ[ZMod 2] (ι → ZMod 2)) (k : ι → ZMod 2)
    (hrepr : ∀ x, F x = B (g (A x + t).1, h (A x + t).2) + L x + k) :
    HasRelaxedSplit F := by
  let U := LinearMap.ker ((LinearMap.snd (ZMod 2) V₁ V₂).comp A.toLinearMap)
  let T := LinearMap.ker ((LinearMap.fst (ZMod 2) V₁ V₂).comp A.toLinearMap)
  have memU (x : Input ι) : x ∈ U ↔ (A x).2 = 0 := Iff.rfl
  have memT (x : Input ι) : x ∈ T ↔ (A x).1 = 0 := Iff.rfl
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
  · exact affine_second_constant ((LinearMap.proj i).comp L) (k i) a b

/-- Connected canonical graph functions are EA-indecomposable. -/
theorem graph_not_EA_product [Nontrivial V₁] [Nontrivial V₂]
    (adj : ι → ι → Bool) (hconn : CutConnected adj)
    (A : Input ι ≃ₗ[ZMod 2] V₁ × V₂) (t : V₁ × V₂)
    (B : (W₁ × W₂) →ₗ[ZMod 2] (ι → ZMod 2))
    (g : V₁ → W₁) (h : V₂ → W₂)
    (L : Input ι →ₗ[ZMod 2] (ι → ZMod 2)) (k : ι → ZMod 2) :
    ¬ (∀ x, graphMap adj x = B (g (A x + t).1, h (A x + t).2) + L x + k) := by
  intro hrepr
  exact graph_no_relaxed_split adj hconn
    (EA_product_has_relaxed_split (graphMap adj) A t B g h L k hrepr)

/-- EA indecomposability survives every perturbation with constant second differences. -/
theorem graph_quadratic_not_EA_product [Nontrivial V₁] [Nontrivial V₂]
    (adj : ι → ι → Bool) (hconn : CutConnected adj)
    (Q : Input ι → ι → ZMod 2) (hQ : HasConstantSecondDifferences Q)
    (A : Input ι ≃ₗ[ZMod 2] V₁ × V₂) (t : V₁ × V₂)
    (B : (W₁ × W₂) →ₗ[ZMod 2] (ι → ZMod 2))
    (g : V₁ → W₁) (h : V₂ → W₂)
    (L : Input ι →ₗ[ZMod 2] (ι → ZMod 2)) (k : ι → ZMod 2) :
    ¬ (∀ x, addVector (graphMap adj) Q x =
      B (g (A x + t).1, h (A x + t).2) + L x + k) := by
  intro hrepr
  exact graph_quadratic_no_relaxed_split adj hconn Q hQ
    (EA_product_has_relaxed_split (addVector (graphMap adj) Q) A t B g h L k hrepr)

#print axioms graph_not_EA_product
#print axioms graph_quadratic_not_EA_product
end VonoExactIndex.GraphFamily

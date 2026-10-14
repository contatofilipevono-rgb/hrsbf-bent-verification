import VonoV3C.GraphEATransport

namespace VonoV3C.GraphFamily
variable {ι : Type*} [Fintype ι] [DecidableEq ι] {m : ℕ}

/-- The quartic polarization attains 1 in every permitted dimension. -/
theorem exists_pfaffian_one (hm : 2 ≤ m) :
    ∃ a b c d : Vec m, pfaffian a b c d = 1 := by
  classical
  by_contra hn
  have hz (a b c d : Vec m) : pfaffian a b c d = 0 := by
    rcases scalar_zero_or_one (pfaffian a b c d) with h | h
    · exact h
    · exact False.elim (hn ⟨a,b,c,d,h⟩)
  have h := pfaffian_property_A hm (Blocks.basisP hm) (Blocks.basisQ hm)
    (hz _ _)
  rcases h with h | h | h
  · have hh := congrArg (fun v : Vec m => (v (firstIndex hm)).1) h
    simpa [Blocks.basisP, firstIndex] using hh
  · have hh := congrArg (fun v : Vec m => (v (firstIndex hm)).2) h
    simpa [Blocks.basisQ, firstIndex] using hh
  · have hh := congrArg (fun v : Vec m => (v (firstIndex hm)).1) h
    simpa [Blocks.basisP, Blocks.basisQ, firstIndex] using hh

theorem fourth_single (hm : 2 ≤ m) (adj : ι → ι → Bool) (i : ι)
    (a b c d : Vec m) (x : Input ι m) :
    iterDiff [Pi.single i a, Pi.single i b, Pi.single i c, Pi.single i d]
      (graphMap hm adj) x = Pi.single i (pfaffian a b c d) := by
  rw [graph_fourth]
  funext j
  by_cases hj : j = i
  · subst j; simp
  · simp [Pi.single_apply, hj, pfaffian, omega]

/-- Orientation: M sends H-input block i to G-input block perm i;
therefore B sends G-output coordinate perm i to H-output coordinate i. -/
theorem representation_output_basis (hm : 2 ≤ m) (adjG adjH : ι → ι → Bool)
    (A : Input ι m ≃ₗ[Scalar] Input ι m) (B : Output ι ≃ₗ[Scalar] Output ι)
    (t : Input ι m) (L : Input ι m →ₗ[Scalar] Output ι) (k : Output ι)
    (he : ∀ x, graphMap hm adjH x = B (graphMap hm adjG (A x+t)) + (L x+k))
    (perm : ι ≃ ι) (e : ι → Vec m ≃ₗ[Scalar] Vec m)
    (hblock : ∀ i v, A (Pi.single i v) = Pi.single (perm i) (e i v))
    (i : ι) : B (Pi.single (perm i) 1) = Pi.single i 1 := by
  obtain ⟨a,b,c,d,habcd⟩ := exists_pfaffian_one hm
  have hh := representation_fourth _ _ A B t L k he
    (Pi.single i a) (Pi.single i b) (Pi.single i c) (Pi.single i d) 0
  rw [fourth_single, habcd, hblock, hblock, hblock, hblock, fourth_single] at hh
  have hn : pfaffian (e i a) (e i b) (e i c) (e i d) ≠ 0 := by
    intro hz
    rw [hz] at hh
    have hi := congrFun hh i
    simpa using hi
  have hone := (scalar_zero_or_one _).resolve_left hn
  rw [hone] at hh
  exact hh.symm

/-- Full output permutation, with no internal symplectic-preservation premise. -/
theorem representation_output (hm : 2 ≤ m) (adjG adjH : ι → ι → Bool)
    (A : Input ι m ≃ₗ[Scalar] Input ι m) (B : Output ι ≃ₗ[Scalar] Output ι)
    (t : Input ι m) (L : Input ι m →ₗ[Scalar] Output ι) (k : Output ι)
    (he : ∀ x, graphMap hm adjH x = B (graphMap hm adjG (A x+t)) + (L x+k))
    (perm : ι ≃ ι) (e : ι → Vec m ≃ₗ[Scalar] Vec m)
    (hblock : ∀ i v, A (Pi.single i v) = Pi.single (perm i) (e i v))
    (y : Output ι) (i : ι) : B y i = y (perm i) := by
  classical
  have hdecomp : y = ∑ j : ι, Pi.single j (y j) := by
    ext j
    simp
  have hBy : B y = ∑ j : ι, B (Pi.single j (y j)) := by
    conv_lhs => rw [hdecomp]
    rw [map_sum]
  rw [hBy]
  simp only [Finset.sum_apply]
  have hterm (j : ι) : B (Pi.single j (y j)) i =
      (Pi.single (perm.symm j) (y j) : Output ι) i := by
    rcases scalar_zero_or_one (y j) with hz | ho
    · simp [hz]
    · rw [ho]
      have hh := representation_output_basis hm adjG adjH A B t L k he perm e hblock
        (perm.symm j)
      simpa using congrFun hh i
  simp_rw [hterm]
  rw [Finset.sum_eq_single (perm i)]
  · simp [Pi.single_apply]
  · intro j hj hji
    have hne : i ≠ perm.symm j := by
      intro heq
      apply hji
      simpa using (congrArg perm heq).symm
    simp [Pi.single_apply, hne]
  · simp

end VonoV3C.GraphFamily

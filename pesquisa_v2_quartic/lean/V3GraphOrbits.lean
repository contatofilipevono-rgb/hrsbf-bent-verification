import V3OrbitBound

/-!
# V3: concrete relabelling orbits

We now define the actual permutation action on loopless directed graphs.
The orbit-size bound is not merely about an arbitrary map: it applies to
the vertex-relabelled graph family itself.
-/

namespace VonoExactIndex.V3Counting

/-- Relabel an ordered edge by a permutation of vertices. -/
def relabelEdge (r : ℕ) (p : Equiv.Perm (Fin r)) (e : EdgePosition r) :
    EdgePosition r :=
  ⟨(p e.1.1, p e.1.2), by
    intro h
    exact e.2 (p.injective h)⟩

/-- Relabel a loopless digraph, with inverse permutation acting on its edges. -/
def relabelGraph (r : ℕ) (p : Equiv.Perm (Fin r))
    (g : LabelledDigraph r) : LabelledDigraph r :=
  fun e => g (relabelEdge r p.symm e)

/-- A concrete graph orbit is a finite image of the permutation group. -/
def graphOrbit (r : ℕ) (g : LabelledDigraph r) : Finset (LabelledDigraph r) :=
  Finset.univ.image (fun p : Equiv.Perm (Fin r) => relabelGraph r p g)

/-- Every labelled graph has at most r! relabelled representatives. -/
theorem graphOrbit_card_le_factorial (r : ℕ) (g : LabelledDigraph r) :
    (graphOrbit r g).card ≤ Nat.factorial r := by
  classical
  exact relabellings_card_le_factorial r (fun p => relabelGraph r p g)

end VonoExactIndex.V3Counting

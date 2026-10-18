import H12WitnessTheory

namespace H12WitnessSearch
open H12WitnessTheory

inductive Tree where
  | empty
  | leaf (witness : Witness)
  | node (pivot : Nat) (left right : Tree)

def leaves : Tree → List Witness
  | .empty => []
  | .leaf w => [w]
  | .node _ left right => leaves left ++ leaves right

def lookup : Tree → Nat → Bool
  | .empty, _ => false
  | .leaf w, c => w.coefficient == c
  | .node p left right, c => if c < p then lookup left c else lookup right c

theorem lookup_member (tree : Tree) (c : Nat) (h : lookup tree c = true) :
    ∃ w ∈ leaves tree, w.coefficient = c := by
  induction tree with
  | empty => simp [lookup] at h
  | leaf w => exact ⟨w,List.mem_cons_self,beq_iff_eq.mp h⟩
  | node pivot left right ihl ihr =>
    simp only [lookup] at h
    split at h
    · obtain ⟨w,hw,hc⟩ := ihl h
      exact ⟨w,List.mem_append_left _ hw,hc⟩
    · obtain ⟨w,hw,hc⟩ := ihr h
      exact ⟨w,List.mem_append_right _ hw,hc⟩

def Good (tree : Tree) : Prop :=
  ∀ c, lookup tree c = true → ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 c))

theorem checked_good (tree : Tree) (h : (leaves tree).all check = true) : Good tree := by
  intro c hc
  obtain ⟨w,hw,hc'⟩ := lookup_member tree c hc
  rw [← hc']
  exact checked_list_sound _ h w hw

theorem node_good (pivot : Nat) (left right : Tree) (hl : Good left) (hr : Good right) :
    Good (.node pivot left right) := by
  intro c hc
  simp only [lookup] at hc
  split at hc
  · exact hl c hc
  · exact hr c hc

#print axioms checked_good
#print axioms node_good
end H12WitnessSearch

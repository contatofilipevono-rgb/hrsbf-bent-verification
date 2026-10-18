import H12WitnessSearch
namespace H12WitnessIndex
open H12WitnessTheory H12WitnessSearch

def build : Nat → List Witness → Tree
  | 0, _ => .empty
  | _+1, [] => .empty
  | _+1, [w] => .leaf w
  | depth+1, x::y::xs =>
      let ws := x::y::xs
      let middle := ws.length / 2
      .node ((ws[middle]?).getD x).coefficient
        (build depth (ws.take middle)) (build depth (ws.drop middle))

theorem build_good (depth : Nat) (ws : List Witness) (h : ws.all check = true) : Good (build depth ws) := by
  induction depth generalizing ws with
  | zero => intro c hc; cases hc
  | succ depth ih =>
    cases ws with
    | nil => intro c hc; cases hc
    | cons x xs =>
      cases xs with
      | nil =>
        intro c hc
        have he : x.coefficient = c := beq_iff_eq.mp hc
        rw [← he]
        exact check_sound x (List.all_eq_true.mp h x List.mem_cons_self)
      | cons y ys =>
        apply node_good
        · apply ih
          apply List.all_eq_true.mpr
          intro w hw
          exact List.all_eq_true.mp h w (List.mem_of_mem_take hw)
        · apply ih
          apply List.all_eq_true.mpr
          intro w hw
          exact List.all_eq_true.mp h w (List.mem_of_mem_drop hw)

#print axioms build_good
end H12WitnessIndex

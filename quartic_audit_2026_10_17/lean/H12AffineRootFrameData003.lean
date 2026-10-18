import H12AffineRootFrameData002

namespace H12AffineRootFrame

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem envTrans29_30 : H12PackedSparse.directTransform 10 3 env29 = env30 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 10 3 env29 == env30) = true)

theorem identity30 : scanCanonicalize (H12AffineState.compose env30 (packedSelected [1] rootPS)) = affineNative (2^(8+1) ^^^ 4) := by decide +kernel

theorem selectedBound30 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env31 : List Nat := [2,4,2,1,0,1,2,4,4,4,3,4096,2,4096,0,2,4097,3,4,0,4097,0,1,2,2,1,3,4097,4096,3,4,0,4,0,4096,4]

theorem envBound31 : H12AffineState.Bounded env31 := by
  intro p hp
  have h : env31.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans30_31 : H12PackedSparse.directTransform 8 4 env30 = env31 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 8 4 env30 == env31) = true)

def w8 : H12WitnessTheory.Witness := H12WitnessData002.batch14[49]'(by decide)

theorem w8_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w8.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData002.batch14 H12WitnessData002.batch14_checked _ (List.getElem_mem (by decide))

theorem w8_good : H12WitnessSearch.Good (.leaf w8) := by
  intro c hc
  have he : w8.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w8_reject

def w9 : H12WitnessTheory.Witness := H12WitnessData004.batch4[166]'(by decide)

theorem w9_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w9.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData004.batch4 H12WitnessData004.batch4_checked _ (List.getElem_mem (by decide))

theorem w9_good : H12WitnessSearch.Good (.leaf w9) := by
  intro c hc
  have he : w9.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w9_reject

def w10 : H12WitnessTheory.Witness := H12WitnessData009.batch8[53]'(by decide)

theorem w10_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w10.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData009.batch8 H12WitnessData009.batch8_checked _ (List.getElem_mem (by decide))

theorem w10_good : H12WitnessSearch.Good (.leaf w10) := by
  intro c hc
  have he : w10.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w10_reject

def w11 : H12WitnessTheory.Witness := H12WitnessData010.batch14[108]'(by decide)

theorem w11_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w11.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData010.batch14 H12WitnessData010.batch14_checked _ (List.getElem_mem (by decide))

theorem w11_good : H12WitnessSearch.Good (.leaf w11) := by
  intro c hc
  have he : w11.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w11_reject

def w12 : H12WitnessTheory.Witness := H12WitnessData011.batch6[171]'(by decide)

theorem w12_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w12.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData011.batch6 H12WitnessData011.batch6_checked _ (List.getElem_mem (by decide))

theorem w12_good : H12WitnessSearch.Good (.leaf w12) := by
  intro c hc
  have he : w12.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w12_reject

def w13 : H12WitnessTheory.Witness := H12WitnessData012.batch13[19]'(by decide)

theorem w13_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w13.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData012.batch13 H12WitnessData012.batch13_checked _ (List.getElem_mem (by decide))

theorem w13_good : H12WitnessSearch.Good (.leaf w13) := by
  intro c hc
  have he : w13.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w13_reject

def w14 : H12WitnessTheory.Witness := H12WitnessData018.batch0[149]'(by decide)

theorem w14_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w14.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData018.batch0 H12WitnessData018.batch0_checked _ (List.getElem_mem (by decide))

theorem w14_good : H12WitnessSearch.Good (.leaf w14) := by
  intro c hc
  have he : w14.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w14_reject

def w15 : H12WitnessTheory.Witness := H12WitnessData019.batch6[235]'(by decide)

theorem w15_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w15.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData019.batch6 H12WitnessData019.batch6_checked _ (List.getElem_mem (by decide))

theorem w15_good : H12WitnessSearch.Good (.leaf w15) := by
  intro c hc
  have he : w15.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w15_reject

def leafEnv31 : List Nat := [2,4,2,1,0,1,2,4,4,4,3,4096,2,4096,0,2,4097,3,4,0,4097,0,1,2,4,2,1,1,3,4097,4096,3,4,0,4,0,4,2,4096,4,1,4097,0]

def active31 : List Nat := [0,1,11]

def tree31 : H12WitnessSearch.Tree := (.node 3301694440488 (.node 2018052026282 (.node 1513149741165 (.leaf w8) (.leaf w9)) (.node 2153116908527 (.leaf w10) (.leaf w11))) (.node 3941661607850 (.node 3436759322733 (.leaf w12) (.leaf w13)) (.node 4076726490095 (.leaf w14) (.leaf w15))))

theorem treeGood31 : H12WitnessSearch.Good tree31 := (H12WitnessSearch.node_good 3301694440488 _ _ (H12WitnessSearch.node_good 2018052026282 _ _ (H12WitnessSearch.node_good 1513149741165 _ _ w8_good w9_good) (H12WitnessSearch.node_good 2153116908527 _ _ w10_good w11_good)) (H12WitnessSearch.node_good 3941661607850 _ _ (H12WitnessSearch.node_good 3436759322733 _ _ w12_good w13_good) (H12WitnessSearch.node_good 4076726490095 _ _ w14_good w15_good)))

theorem leafIdentity31 : H12AffineState.composeSystem env31 rootObs = leafEnv31 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineState.composeSystem env31 rootObs == leafEnv31) = true)

theorem terminalChecked31 : H12PackedTerminal.terminalCheckFast leafEnv31 active31 tree31 = true := by decide +kernel

end H12AffineRootFrame
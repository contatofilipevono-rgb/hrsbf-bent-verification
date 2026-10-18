import H12AffinePilotData000

namespace H12AffinePilot

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

def env12 : List Nat := [2,4,8,16,10,16,2,256,512,20,2048,4096,8,4112,0,8,4096,2058,524288,1048576,4112,4194304,16,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound12 : H12AffineState.Bounded env12 := by
  intro p hp
  have h : env12.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans11_12 : H12PackedSparse.directTransform 4 10 env11 = env12 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 4 10 env11 == env12) = true)

theorem identity12 : scanCanonicalize (H12AffineState.compose env12 (packedSelected [1,5] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound12 : packedSelected [1,5] rootPS < 2^1333 := by decide +kernel

def env13 : List Nat := [2,4,8,0,10,0,2,256,512,4,2048,4096,8,4096,0,8,4096,2058,524288,1048576,4096,4194304,0,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound13 : H12AffineState.Bounded env13 := by
  intro p hp
  have h : env13.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans12_13 : H12PackedSparse.directTransform 3 0 env12 = env13 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 3 0 env12 == env13) = true)

theorem identity13 : scanCanonicalize (H12AffineState.compose env13 (packedSelected [0,7] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound13 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env14 : List Nat := [2,4,2,0,0,0,2,256,512,4,2048,4096,2,4096,0,2,4096,2048,524288,1048576,4096,4194304,0,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound14 : H12AffineState.Bounded env14 := by
  intro p hp
  have h : env14.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans13_14 : H12PackedSparse.directTransform 2 2 env13 = env14 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 2 2 env13 == env14) = true)

theorem identity14 : scanCanonicalize (H12AffineState.compose env14 (packedSelected [0] rootPS)) = affineNative (2^(11+1) ^^^ 2050) := by decide +kernel

theorem selectedBound14 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env15 : List Nat := [2,4,2,0,0,0,2,256,512,4,2048,2050,2,2050,0,2,2050,2048,524288,1048576,2050,4194304,0,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound15 : H12AffineState.Bounded env15 := by
  intro p hp
  have h : env15.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans14_15 : H12PackedSparse.directTransform 11 2050 env14 = env15 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 11 2050 env14 == env15) = true)

theorem identity15 : scanCanonicalize (H12AffineState.compose env15 (packedSelected [1] rootPS)) = affineNative (2^(1+1) ^^^ 0) := by decide +kernel

theorem selectedBound15 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env16 : List Nat := [2,0,2,0,0,0,2,256,512,0,2048,2050,2,2050,0,2,2050,2048,524288,1048576,2050,4194304,0,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound16 : H12AffineState.Bounded env16 := by
  intro p hp
  have h : env16.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans15_16 : H12PackedSparse.directTransform 1 0 env15 = env16 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 1 0 env15 == env16) = true)

def w0 : H12WitnessTheory.Witness := H12WitnessData000.batch0[0]'(by decide)

theorem w0_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w0.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData000.batch0 H12WitnessData000.batch0_checked _ (List.getElem_mem (by decide))

theorem w0_good : H12WitnessSearch.Good (.leaf w0) := by
  intro c hc
  have he : w0.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w0_reject

def w1 : H12WitnessTheory.Witness := H12WitnessData001.batch7[19]'(by decide)

theorem w1_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w1.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData001.batch7 H12WitnessData001.batch7_checked _ (List.getElem_mem (by decide))

theorem w1_good : H12WitnessSearch.Good (.leaf w1) := by
  intro c hc
  have he : w1.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w1_reject

def w2 : H12WitnessTheory.Witness := H12WitnessData005.batch11[32]'(by decide)

theorem w2_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w2.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData005.batch11 H12WitnessData005.batch11_checked _ (List.getElem_mem (by decide))

theorem w2_good : H12WitnessSearch.Good (.leaf w2) := by
  intro c hc
  have he : w2.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w2_reject

def w3 : H12WitnessTheory.Witness := H12WitnessData007.batch2[57]'(by decide)

theorem w3_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w3.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData007.batch2 H12WitnessData007.batch2_checked _ (List.getElem_mem (by decide))

theorem w3_good : H12WitnessSearch.Good (.leaf w3) := by
  intro c hc
  have he : w3.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w3_reject

def w4 : H12WitnessTheory.Witness := H12WitnessData014.batch4[17]'(by decide)

theorem w4_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w4.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData014.batch4 H12WitnessData014.batch4_checked _ (List.getElem_mem (by decide))

theorem w4_good : H12WitnessSearch.Good (.leaf w4) := by
  intro c hc
  have he : w4.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w4_reject

def w5 : H12WitnessTheory.Witness := H12WitnessData015.batch10[187]'(by decide)

theorem w5_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w5.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData015.batch10 H12WitnessData015.batch10_checked _ (List.getElem_mem (by decide))

theorem w5_good : H12WitnessSearch.Good (.leaf w5) := by
  intro c hc
  have he : w5.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w5_reject

def w6 : H12WitnessTheory.Witness := H12WitnessData019.batch15[74]'(by decide)

theorem w6_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w6.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData019.batch15 H12WitnessData019.batch15_checked _ (List.getElem_mem (by decide))

theorem w6_good : H12WitnessSearch.Good (.leaf w6) := by
  intro c hc
  have he : w6.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w6_reject

def w7 : H12WitnessTheory.Witness := H12WitnessData021.batch5[227]'(by decide)

theorem w7_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w7.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData021.batch5 H12WitnessData021.batch5_checked _ (List.getElem_mem (by decide))

theorem w7_good : H12WitnessSearch.Good (.leaf w7) := by
  intro c hc
  have he : w7.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w7_reject

def leafEnv16 : List Nat := [2,0,2,0,0,0,2,0,512,0,2048,2050,2,2050,0,2,2050,2048,0,0,2050,0,0,2,0,2,1,0,2048,2050,2050,2048,0,0,0,0,0,2,2050,512,1,2050,0]

def active16 : List Nat := [0,8,10]

def tree16 : H12WitnessSearch.Tree := (.node 3577507687424 (.node 1649334550784 (.node 1239475721285 (.leaf w0) (.leaf w1)) (.node 1789231535429 (.leaf w2) (.leaf w3))) (.node 4127263501568 (.node 3712572569669 (.leaf w4) (.leaf w5)) (.node 4262328383813 (.leaf w6) (.leaf w7))))

theorem treeGood16 : H12WitnessSearch.Good tree16 := (H12WitnessSearch.node_good 3577507687424 _ _ (H12WitnessSearch.node_good 1649334550784 _ _ (H12WitnessSearch.node_good 1239475721285 _ _ w0_good w1_good) (H12WitnessSearch.node_good 1789231535429 _ _ w2_good w3_good)) (H12WitnessSearch.node_good 4127263501568 _ _ (H12WitnessSearch.node_good 3712572569669 _ _ w4_good w5_good) (H12WitnessSearch.node_good 4262328383813 _ _ w6_good w7_good)))

theorem leafIdentity16 : H12AffineState.composeSystem env16 rootObs = leafEnv16 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineState.composeSystem env16 rootObs == leafEnv16) = true)

theorem terminalChecked16 : H12PackedTerminal.terminalCheckFast leafEnv16 active16 tree16 = true := by decide +kernel

def env17 : List Nat := [2,4,8,16,32,64,128,256,512,237,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,16465,4194304,8388608,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound17 : H12AffineState.Bounded env17 := by
  intro p hp
  have h : env17.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1_17 : H12PackedSparse.directTransform 9 237 env1 = env17 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 9 237 env1 == env17) = true)

theorem identity17 : scanCanonicalize (H12AffineState.compose env17 (packedSelected [0,2,7,11,13,14,17,18,20] rootPS)) = affineNative (2^(22+1) ^^^ 213130) := by decide +kernel

theorem selectedBound17 : packedSelected [0,2,7,11,13,14,17,18,20] rootPS < 2^1333 := by decide +kernel

def env18 : List Nat := [2,4,8,16,32,64,128,256,512,237,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,16465,4194304,213130,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound18 : H12AffineState.Bounded env18 := by
  intro p hp
  have h : env18.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

end H12AffinePilot
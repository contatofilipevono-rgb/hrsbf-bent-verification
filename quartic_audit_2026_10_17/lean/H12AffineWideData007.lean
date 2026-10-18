import H12AffineWideData006

namespace H12AffineWide

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem w24_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w24.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData002.batch13 H12WitnessData002.batch13_checked _ (List.getElem_mem (by decide))

theorem w24_good : H12WitnessSearch.Good (.leaf w24) := by
  intro c hc
  have he : w24.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w24_reject

def w25 : H12WitnessTheory.Witness := H12WitnessData004.batch4[221]'(by decide)

theorem w25_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w25.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData004.batch4 H12WitnessData004.batch4_checked _ (List.getElem_mem (by decide))

theorem w25_good : H12WitnessSearch.Good (.leaf w25) := by
  intro c hc
  have he : w25.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w25_reject

def w26 : H12WitnessTheory.Witness := H12WitnessData009.batch7[200]'(by decide)

theorem w26_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w26.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData009.batch7 H12WitnessData009.batch7_checked _ (List.getElem_mem (by decide))

theorem w26_good : H12WitnessSearch.Good (.leaf w26) := by
  intro c hc
  have he : w26.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w26_reject

def w27 : H12WitnessTheory.Witness := H12WitnessData010.batch14[166]'(by decide)

theorem w27_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w27.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData010.batch14 H12WitnessData010.batch14_checked _ (List.getElem_mem (by decide))

theorem w27_good : H12WitnessSearch.Good (.leaf w27) := by
  intro c hc
  have he : w27.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w27_reject

def w28 : H12WitnessTheory.Witness := H12WitnessData011.batch6[107]'(by decide)

theorem w28_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w28.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData011.batch6 H12WitnessData011.batch6_checked _ (List.getElem_mem (by decide))

theorem w28_good : H12WitnessSearch.Good (.leaf w28) := by
  intro c hc
  have he : w28.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w28_reject

def w29 : H12WitnessTheory.Witness := H12WitnessData012.batch13[135]'(by decide)

theorem w29_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w29.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData012.batch13 H12WitnessData012.batch13_checked _ (List.getElem_mem (by decide))

theorem w29_good : H12WitnessSearch.Good (.leaf w29) := by
  intro c hc
  have he : w29.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w29_reject

def w30 : H12WitnessTheory.Witness := H12WitnessData018.batch0[91]'(by decide)

theorem w30_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w30.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData018.batch0 H12WitnessData018.batch0_checked _ (List.getElem_mem (by decide))

theorem w30_good : H12WitnessSearch.Good (.leaf w30) := by
  intro c hc
  have he : w30.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w30_reject

def w31 : H12WitnessTheory.Witness := H12WitnessData019.batch7[97]'(by decide)

theorem w31_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w31.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData019.batch7 H12WitnessData019.batch7_checked _ (List.getElem_mem (by decide))

theorem w31_good : H12WitnessSearch.Good (.leaf w31) := by
  intro c hc
  have he : w31.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w31_reject

def leafEnv68 : List Nat := [2,4,2,1,0,1,2,4,4,4,2,4096,2,4097,0,2,4097,2,4,0,4096,0,1,2,4,2,1,1,2,4097,4096,2,4,0,4,0,4,2,4097,4,1,4096,0]

def active68 : List Nat := [0,1,11]

def tree68 : H12WitnessSearch.Tree := (.node 3299815196712 (.node 2015099167658 (.node 1515028984941 (.leaf w24) (.leaf w25)) (.node 2154996152303 (.leaf w26) (.leaf w27))) (.node 3939782364074 (.node 3439712181357 (.leaf w28) (.leaf w29)) (.node 4079679348719 (.leaf w30) (.leaf w31))))

theorem treeGood68 : H12WitnessSearch.Good tree68 := (H12WitnessSearch.node_good 3299815196712 _ _ (H12WitnessSearch.node_good 2015099167658 _ _ (H12WitnessSearch.node_good 1515028984941 _ _ w24_good w25_good) (H12WitnessSearch.node_good 2154996152303 _ _ w26_good w27_good)) (H12WitnessSearch.node_good 3939782364074 _ _ (H12WitnessSearch.node_good 3439712181357 _ _ w28_good w29_good) (H12WitnessSearch.node_good 4079679348719 _ _ w30_good w31_good)))

theorem leafIdentity68 : H12AffineState.composeSystem env68 rootObs = leafEnv68 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineState.composeSystem env68 rootObs == leafEnv68) = true)

theorem terminalChecked68 : H12PackedTerminal.terminalCheckFast leafEnv68 active68 tree68 = true := by decide +kernel

def env69 : List Nat := [2,4,8,16,32,64,128,252,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304,8388608,16777216,33554432,566496,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,14815281,68719476736]

theorem envBound69 : H12AffineState.Bounded env69 := by
  intro p hp
  have h : env69.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2_69 : H12PackedSparse.directTransform 34 14815281 env2 = env69 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 34 14815281 env2 == env69) = true)

theorem identity69 : scanCanonicalize (H12AffineState.compose env69 (packedSelected [13,21] rootPS)) = affineNative (2^(21+1) ^^^ 73890) := by decide +kernel

theorem selectedBound69 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env70 : List Nat := [2,4,8,16,32,64,128,252,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,73890,8388608,16777216,33554432,566496,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,10694803,68719476736]

theorem envBound70 : H12AffineState.Bounded env70 := by
  intro p hp
  have h : env70.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans69_70 : H12PackedSparse.directTransform 21 73890 env69 = env70 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 21 73890 env69 == env70) = true)

theorem identity70 : scanCanonicalize (H12AffineState.compose env70 (packedSelected [0,4,7,14,18,22,23,35] rootPS)) = affineNative (2^(15+1) ^^^ 32802) := by decide +kernel

theorem selectedBound70 : packedSelected [0,4,7,14,18,22,23,35] rootPS < 2^1333 := by decide +kernel

def env71 : List Nat := [2,4,8,16,32,64,128,252,512,1024,2048,4096,8192,16384,32768,32802,131072,262144,524288,1048576,2097152,41088,8388608,16777216,33554432,566496,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,10662065,68719476736]

theorem envBound71 : H12AffineState.Bounded env71 := by
  intro p hp
  have h : env71.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans70_71 : H12PackedSparse.directTransform 15 32802 env70 = env71 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 15 32802 env70 == env71) = true)

theorem identity71 : scanCanonicalize (H12AffineState.compose env71 (packedSelected [3,5,10] rootPS)) = affineNative (2^(20+1) ^^^ 17596) := by decide +kernel

theorem selectedBound71 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env72 : List Nat := [2,4,8,16,32,64,128,252,512,1024,2048,4096,8192,16384,32768,32802,131072,262144,524288,1048576,17596,41088,8388608,16777216,33554432,566496,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,8582157,68719476736]

theorem envBound72 : H12AffineState.Bounded env72 := by
  intro p hp
  have h : env72.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans71_72 : H12PackedSparse.directTransform 20 17596 env71 = env72 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 20 17596 env71 == env72) = true)

def env73 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304,8388608,16777216,33554432,566496,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound73 : H12AffineState.Bounded env73 := by
  intro p hp
  have h : env73.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1_73 : H12PackedSparse.directTransform 7 253 env1 = env73 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 7 253 env1 == env73) = true)

theorem identity73 : scanCanonicalize (H12AffineState.compose env73 (packedSelected [0,3,7,9,10,13,14,20,21,22,24,26] rootPS)) = affineNative (2^(21+1) ^^^ 73891) := by decide +kernel

theorem selectedBound73 : packedSelected [0,3,7,9,10,13,14,20,21,22,24,26] rootPS < 2^1333 := by decide +kernel

def env74 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,73891,8388608,16777216,33554432,566496,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound74 : H12AffineState.Bounded env74 := by
  intro p hp
  have h : env74.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans73_74 : H12PackedSparse.directTransform 21 73891 env73 = env74 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 21 73891 env73 == env74) = true)

def env75 : List Nat := [2,4,8,16,32,64,128,253,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,570592,73891,8388608,16777216,33554432,566496,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,34359738368,68719476736]

theorem envBound75 : H12AffineState.Bounded env75 := by
  intro p hp
  have h : env75.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans74_75 : H12PackedSparse.directTransform 20 570592 env74 = env75 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 20 570592 env74 == env75) = true)

theorem identity75 : scanCanonicalize (H12AffineState.compose env75 (packedSelected [3,5,10] rootPS)) = affineNative (2^(16+1) ^^^ 5357) := by decide +kernel

theorem selectedBound75 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

end H12AffineWide
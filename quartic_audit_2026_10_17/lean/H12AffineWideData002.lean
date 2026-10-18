import H12AffineWideData001

namespace H12AffineWide

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

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

def leafEnv21 : List Nat := [2,0,2,0,0,0,2,0,512,0,2048,2050,2,2050,0,2,2050,2048,0,0,2050,0,0,2,0,2,1,0,2048,2050,2050,2048,0,0,0,0,0,2,2050,512,1,2050,0]

def active21 : List Nat := [0,8,10]

def tree21 : H12WitnessSearch.Tree := (.node 3577507687424 (.node 1649334550784 (.node 1239475721285 (.leaf w0) (.leaf w1)) (.node 1789231535429 (.leaf w2) (.leaf w3))) (.node 4127263501568 (.node 3712572569669 (.leaf w4) (.leaf w5)) (.node 4262328383813 (.leaf w6) (.leaf w7))))

theorem treeGood21 : H12WitnessSearch.Good tree21 := (H12WitnessSearch.node_good 3577507687424 _ _ (H12WitnessSearch.node_good 1649334550784 _ _ (H12WitnessSearch.node_good 1239475721285 _ _ w0_good w1_good) (H12WitnessSearch.node_good 1789231535429 _ _ w2_good w3_good)) (H12WitnessSearch.node_good 4127263501568 _ _ (H12WitnessSearch.node_good 3712572569669 _ _ w4_good w5_good) (H12WitnessSearch.node_good 4262328383813 _ _ w6_good w7_good)))

theorem leafIdentity21 : H12AffineState.composeSystem env21 rootObs = leafEnv21 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineState.composeSystem env21 rootObs == leafEnv21) = true)

theorem terminalChecked21 : H12PackedTerminal.terminalCheckFast leafEnv21 active21 tree21 = true := by decide +kernel

def env22 : List Nat := [2,4,8,16,32,64,128,252,512,237,2048,4096,8192,16384,32768,65536,131072,262144,188509,1048576,16465,41088,8388608,16777216,33554432,147536,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,8581345,68719476736]

theorem envBound22 : H12AffineState.Bounded env22 := by
  intro p hp
  have h : env22.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6_22 : H12PackedSparse.directTransform 9 237 env6 = env22 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 9 237 env6 == env22) = true)

theorem identity22 : scanCanonicalize (H12AffineState.compose env22 (packedSelected [0,2,7,11,13,14,17,18,20] rootPS)) = affineNative (2^(22+1) ^^^ 213130) := by decide +kernel

theorem selectedBound22 : packedSelected [0,2,7,11,13,14,17,18,20] rootPS < 2^1333 := by decide +kernel

def env23 : List Nat := [2,4,8,16,32,64,128,252,512,237,2048,4096,8192,16384,32768,65536,131072,262144,188509,1048576,16465,41088,213130,16777216,33554432,147536,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,110699,68719476736]

theorem envBound23 : H12AffineState.Bounded env23 := by
  intro p hp
  have h : env23.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans22_23 : H12PackedSparse.directTransform 22 213130 env22 = env23 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 22 213130 env22 == env23) = true)

theorem identity23 : scanCanonicalize (H12AffineState.compose env23 (packedSelected [0,2,6,9,11,13,17,18,22,27] rootPS)) = affineNative (2^(15+1) ^^^ 41002) := by decide +kernel

theorem selectedBound23 : packedSelected [0,2,6,9,11,13,17,18,22,27] rootPS < 2^1333 := by decide +kernel

def env24 : List Nat := [2,4,8,16,32,64,128,252,512,237,2048,4096,8192,16384,32768,41002,131072,262144,188509,1048576,16465,41088,188576,16777216,33554432,147536,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4161,68719476736]

theorem envBound24 : H12AffineState.Bounded env24 := by
  intro p hp
  have h : env24.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans23_24 : H12PackedSparse.directTransform 15 41002 env23 = env24 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 15 41002 env23 == env24) = true)

theorem identity24 : scanCanonicalize (H12AffineState.compose env24 (packedSelected [2,9,11,13,17,18,22] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound24 : packedSelected [2,9,11,13,17,18,22] rootPS < 2^1333 := by decide +kernel

def env25 : List Nat := [2,4,8,16,32,64,128,252,512,237,2048,4096,8,16384,32768,32802,131072,262144,180309,1048576,16465,32904,180392,16777216,33554432,147536,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4161,68719476736]

theorem envBound25 : H12AffineState.Bounded env25 := by
  intro p hp
  have h : env25.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans24_25 : H12PackedSparse.directTransform 12 8 env24 = env25 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 12 8 env24 == env25) = true)

theorem identity25 : scanCanonicalize (H12AffineState.compose env25 (packedSelected [2,13,14] rootPS)) = affineNative (2^(16+1) ^^^ 4265) := by decide +kernel

theorem selectedBound25 : packedSelected [2,13,14] rootPS < 2^1333 := by decide +kernel

def env26 : List Nat := [2,4,8,16,32,64,128,252,512,237,2048,4096,8,16384,32768,32802,4265,262144,53500,1048576,16465,32904,53249,16777216,33554432,20729,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4161,68719476736]

theorem envBound26 : H12AffineState.Bounded env26 := by
  intro p hp
  have h : env26.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans25_26 : H12PackedSparse.directTransform 16 4265 env25 = env26 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 16 4265 env25 == env26) = true)

theorem identity26 : scanCanonicalize (H12AffineState.compose env26 (packedSelected [13] rootPS)) = affineNative (2^(6+1) ^^^ 40) := by decide +kernel

theorem selectedBound26 : packedSelected [13] rootPS < 2^1333 := by decide +kernel

def env27 : List Nat := [2,4,8,16,32,64,40,84,512,69,2048,4096,8,16384,32768,32802,4097,262144,53332,1048576,16465,32800,53249,16777216,33554432,20561,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4161,68719476736]

theorem envBound27 : H12AffineState.Bounded env27 := by
  intro p hp
  have h : env27.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans26_27 : H12PackedSparse.directTransform 6 40 env26 = env27 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 6 40 env26 == env27) = true)

theorem identity27 : scanCanonicalize (H12AffineState.compose env27 (packedSelected [2,4,6,9,11] rootPS)) = affineNative (2^(17+1) ^^^ 34848) := by decide +kernel

theorem selectedBound27 : packedSelected [2,4,6,9,11] rootPS < 2^1333 := by decide +kernel

def env28 : List Nat := [2,4,8,16,32,64,40,84,512,69,2048,4096,8,16384,32768,32802,4097,34848,53332,1048576,16465,32800,53249,16777216,33554432,20561,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4161,68719476736]

theorem envBound28 : H12AffineState.Bounded env28 := by
  intro p hp
  have h : env28.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans27_28 : H12PackedSparse.directTransform 17 34848 env27 = env28 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 17 34848 env27 == env28) = true)

theorem identity28 : scanCanonicalize (H12AffineState.compose env28 (packedSelected [0,2,4,7,9] rootPS)) = affineNative (2^(14+1) ^^^ 0) := by decide +kernel

theorem selectedBound28 : packedSelected [0,2,4,7,9] rootPS < 2^1333 := by decide +kernel

def env29 : List Nat := [2,4,8,16,32,64,40,84,512,69,2048,4096,8,16384,0,34,4097,2080,20564,1048576,16465,32,20481,16777216,33554432,20561,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4161,68719476736]

theorem envBound29 : H12AffineState.Bounded env29 := by
  intro p hp
  have h : env29.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans28_29 : H12PackedSparse.directTransform 14 0 env28 = env29 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 14 0 env28 == env29) = true)

theorem identity29 : scanCanonicalize (H12AffineState.compose env29 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound29 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env30 : List Nat := [2,4,8,16,32,16,40,4,512,21,2048,4096,8,16384,0,34,4097,2080,20484,1048576,16385,32,20481,16777216,33554432,20481,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4113,68719476736]

theorem envBound30 : H12AffineState.Bounded env30 := by
  intro p hp
  have h : env30.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans29_30 : H12PackedSparse.directTransform 5 16 env29 = env30 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 5 16 env29 == env30) = true)

theorem identity30 : scanCanonicalize (H12AffineState.compose env30 (packedSelected [2] rootPS)) = affineNative (2^(13+1) ^^^ 4113) := by decide +kernel

theorem selectedBound30 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env31 : List Nat := [2,4,8,16,32,16,40,4,512,21,2048,4096,8,4113,0,34,4097,2080,21,1048576,4112,32,16,16777216,33554432,16,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4113,68719476736]

theorem envBound31 : H12AffineState.Bounded env31 := by
  intro p hp
  have h : env31.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans30_31 : H12PackedSparse.directTransform 13 4113 env30 = env31 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 13 4113 env30 == env31) = true)

end H12AffineWide
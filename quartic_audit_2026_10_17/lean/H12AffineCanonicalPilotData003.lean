import H12AffineCanonicalPilotData002

namespace H12AffineCanonicalPilot

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem selectedBound56 : packedSelected [2,9,11,13,17,18,22] rootPS < 2^1333 := by decide +kernel

def env57 : List Nat := [2,4,8,16,32,64,128,252,512,237,2048,4096,8,16384,32768,32802,131072,262144,180308,1048576,16465,32904,180393,16777216,33554432,147537,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4160,68719476736]

theorem envBound57 : H12AffineState.Bounded env57 := by
  intro p hp
  have h : env57.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans56_57 : H12PackedSparse.directTransform 12 8 env56 = env57 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 12 8 env56 == env57) = true)

theorem identity57 : scanCanonicalize (H12AffineState.compose env57 (packedSelected [2,13,14] rootPS)) = affineNative (2^(16+1) ^^^ 4265) := by decide +kernel

theorem selectedBound57 : packedSelected [2,13,14] rootPS < 2^1333 := by decide +kernel

def env58 : List Nat := [2,4,8,16,32,64,128,252,512,237,2048,4096,8,16384,32768,32802,4265,262144,53501,1048576,16465,32904,53248,16777216,33554432,20728,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4160,68719476736]

theorem envBound58 : H12AffineState.Bounded env58 := by
  intro p hp
  have h : env58.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans57_58 : H12PackedSparse.directTransform 16 4265 env57 = env58 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 16 4265 env57 == env58) = true)

theorem identity58 : scanCanonicalize (H12AffineState.compose env58 (packedSelected [13] rootPS)) = affineNative (2^(6+1) ^^^ 40) := by decide +kernel

theorem selectedBound58 : packedSelected [13] rootPS < 2^1333 := by decide +kernel

def env59 : List Nat := [2,4,8,16,32,64,40,84,512,69,2048,4096,8,16384,32768,32802,4097,262144,53333,1048576,16465,32800,53248,16777216,33554432,20560,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4160,68719476736]

theorem envBound59 : H12AffineState.Bounded env59 := by
  intro p hp
  have h : env59.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans58_59 : H12PackedSparse.directTransform 6 40 env58 = env59 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 6 40 env58 == env59) = true)

theorem identity59 : scanCanonicalize (H12AffineState.compose env59 (packedSelected [2,4,6,9,11] rootPS)) = affineNative (2^(17+1) ^^^ 34848) := by decide +kernel

theorem selectedBound59 : packedSelected [2,4,6,9,11] rootPS < 2^1333 := by decide +kernel

def env60 : List Nat := [2,4,8,16,32,64,40,84,512,69,2048,4096,8,16384,32768,32802,4097,34848,53333,1048576,16465,32800,53248,16777216,33554432,20560,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4160,68719476736]

theorem envBound60 : H12AffineState.Bounded env60 := by
  intro p hp
  have h : env60.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans59_60 : H12PackedSparse.directTransform 17 34848 env59 = env60 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 17 34848 env59 == env60) = true)

theorem identity60 : scanCanonicalize (H12AffineState.compose env60 (packedSelected [0,2,4,7,9] rootPS)) = affineNative (2^(14+1) ^^^ 0) := by decide +kernel

theorem selectedBound60 : packedSelected [0,2,4,7,9] rootPS < 2^1333 := by decide +kernel

def env61 : List Nat := [2,4,8,16,32,64,40,84,512,69,2048,4096,8,16384,0,34,4097,2080,20565,1048576,16465,32,20480,16777216,33554432,20560,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4160,68719476736]

theorem envBound61 : H12AffineState.Bounded env61 := by
  intro p hp
  have h : env61.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans60_61 : H12PackedSparse.directTransform 14 0 env60 = env61 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 14 0 env60 == env61) = true)

theorem identity61 : scanCanonicalize (H12AffineState.compose env61 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound61 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env62 : List Nat := [2,4,8,16,32,16,40,4,512,21,2048,4096,8,16384,0,34,4097,2080,20485,1048576,16385,32,20480,16777216,33554432,20480,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4112,68719476736]

theorem envBound62 : H12AffineState.Bounded env62 := by
  intro p hp
  have h : env62.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans61_62 : H12PackedSparse.directTransform 5 16 env61 = env62 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 5 16 env61 == env62) = true)

theorem identity62 : scanCanonicalize (H12AffineState.compose env62 (packedSelected [2] rootPS)) = affineNative (2^(13+1) ^^^ 4112) := by decide +kernel

theorem selectedBound62 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env63 : List Nat := [2,4,8,16,32,16,40,4,512,21,2048,4096,8,4112,0,34,4097,2080,21,1048576,4113,32,16,16777216,33554432,16,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4112,68719476736]

theorem envBound63 : H12AffineState.Bounded env63 := by
  intro p hp
  have h : env63.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans62_63 : H12PackedSparse.directTransform 13 4112 env62 = env63 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 13 4112 env62 == env63) = true)

theorem identity63 : scanCanonicalize (H12AffineState.compose env63 (packedSelected [0,4] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound63 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env64 : List Nat := [2,4,8,16,10,16,2,4,512,21,2048,4096,8,4112,0,8,4097,2058,21,1048576,4113,10,16,16777216,33554432,16,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4112,68719476736]

theorem envBound64 : H12AffineState.Bounded env64 := by
  intro p hp
  have h : env64.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans63_64 : H12PackedSparse.directTransform 4 10 env63 = env64 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 4 10 env63 == env64) = true)

theorem identity64 : scanCanonicalize (H12AffineState.compose env64 (packedSelected [1,5] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound64 : packedSelected [1,5] rootPS < 2^1333 := by decide +kernel

def env65 : List Nat := [2,4,8,1,10,1,2,4,512,4,2048,4096,8,4097,0,8,4097,2058,4,1048576,4096,10,1,16777216,33554432,1,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4097,68719476736]

theorem envBound65 : H12AffineState.Bounded env65 := by
  intro p hp
  have h : env65.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans64_65 : H12PackedSparse.directTransform 3 1 env64 = env65 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 3 1 env64 == env65) = true)

theorem identity65 : scanCanonicalize (H12AffineState.compose env65 (packedSelected [0,7] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound65 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env66 : List Nat := [2,4,2,1,0,1,2,4,512,4,2048,4096,2,4097,0,2,4097,2048,4,1048576,4096,0,1,16777216,33554432,1,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4097,68719476736]

theorem envBound66 : H12AffineState.Bounded env66 := by
  intro p hp
  have h : env66.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans65_66 : H12PackedSparse.directTransform 2 2 env65 = env66 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 2 2 env65 == env66) = true)

theorem identity66 : scanCanonicalize (H12AffineState.compose env66 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 2) := by decide +kernel

theorem selectedBound66 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env67 : List Nat := [2,4,2,1,0,1,2,4,512,4,2,4096,2,4097,0,2,4097,2,4,1048576,4096,0,1,16777216,33554432,1,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4097,68719476736]

theorem envBound67 : H12AffineState.Bounded env67 := by
  intro p hp
  have h : env67.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans66_67 : H12PackedSparse.directTransform 10 2 env66 = env67 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 10 2 env66 == env67) = true)

theorem identity67 : scanCanonicalize (H12AffineState.compose env67 (packedSelected [1] rootPS)) = affineNative (2^(8+1) ^^^ 4) := by decide +kernel

theorem selectedBound67 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env68 : List Nat := [2,4,2,1,0,1,2,4,4,4,2,4096,2,4097,0,2,4097,2,4,1048576,4096,0,1,16777216,33554432,1,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4097,68719476736]

theorem envBound68 : H12AffineState.Bounded env68 := by
  intro p hp
  have h : env68.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans67_68 : H12PackedSparse.directTransform 8 4 env67 = env68 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 8 4 env67 == env68) = true)

def w24 : H12WitnessTheory.Witness := H12WitnessData002.batch13[192]'(by decide)

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

end H12AffineCanonicalPilot
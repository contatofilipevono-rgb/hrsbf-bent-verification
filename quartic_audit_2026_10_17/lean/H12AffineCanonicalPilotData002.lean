import H12AffineCanonicalPilotData001

namespace H12AffineCanonicalPilot

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

def env38 : List Nat := [2,4,8,16,32,64,128,252,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,189617,1048576,115870,41088,8388608,16777216,33554432,147537,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,8614958,68719476736]

theorem envBound38 : H12AffineState.Bounded env38 := by
  intro p hp
  have h : env38.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans37_38 : H12PackedSparse.directTransform 20 115870 env37 = env38 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 20 115870 env37 == env38) = true)

def env39 : List Nat := [2,4,8,16,32,64,128,252,512,236,2048,4096,8192,16384,32768,65536,131072,262144,188509,1048576,114802,41088,8388608,16777216,33554432,147537,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,8614082,68719476736]

theorem envBound39 : H12AffineState.Bounded env39 := by
  intro p hp
  have h : env39.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans38_39 : H12PackedSparse.directTransform 9 236 env38 = env39 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 9 236 env38 == env39) = true)

theorem identity39 : scanCanonicalize (H12AffineState.compose env39 (packedSelected [0,2,7,11,13,14,17,18,20] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound39 : packedSelected [0,2,7,11,13,14,17,18,20] rootPS < 2^1333 := by decide +kernel

def env40 : List Nat := [2,4,8,16,32,64,128,252,512,236,2048,4096,8,16384,32768,65536,131072,262144,180309,1048576,114802,32904,8388608,16777216,33554432,147537,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,8605898,68719476736]

theorem envBound40 : H12AffineState.Bounded env40 := by
  intro p hp
  have h : env40.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans39_40 : H12PackedSparse.directTransform 12 8 env39 = env40 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 12 8 env39 == env40) = true)

theorem identity40 : scanCanonicalize (H12AffineState.compose env40 (packedSelected [0,2,6,9,11,13,17,18,22,27] rootPS)) = affineNative (2^(22+1) ^^^ 180393) := by decide +kernel

theorem selectedBound40 : packedSelected [0,2,6,9,11,13,17,18,22,27] rootPS < 2^1333 := by decide +kernel

def env41 : List Nat := [2,4,8,16,32,64,128,252,512,236,2048,4096,8,16384,32768,65536,131072,262144,180309,1048576,114802,32904,180393,16777216,33554432,147537,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,102499,68719476736]

theorem envBound41 : H12AffineState.Bounded env41 := by
  intro p hp
  have h : env41.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans40_41 : H12PackedSparse.directTransform 22 180393 env40 = env41 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 22 180393 env40 == env41) = true)

theorem identity41 : scanCanonicalize (H12AffineState.compose env41 (packedSelected [2,9,11,13,17,18,22] rootPS)) = affineNative (2^(15+1) ^^^ 32802) := by decide +kernel

theorem selectedBound41 : packedSelected [2,9,11,13,17,18,22] rootPS < 2^1333 := by decide +kernel

def env42 : List Nat := [2,4,8,16,32,64,128,252,512,236,2048,4096,8,16384,32768,32802,131072,262144,180309,1048576,16464,32904,180393,16777216,33554432,147537,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4161,68719476736]

theorem envBound42 : H12AffineState.Bounded env42 := by
  intro p hp
  have h : env42.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans41_42 : H12PackedSparse.directTransform 15 32802 env41 = env42 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 15 32802 env41 == env42) = true)

theorem identity42 : scanCanonicalize (H12AffineState.compose env42 (packedSelected [2,13,14] rootPS)) = affineNative (2^(16+1) ^^^ 4264) := by decide +kernel

theorem selectedBound42 : packedSelected [2,13,14] rootPS < 2^1333 := by decide +kernel

def env43 : List Nat := [2,4,8,16,32,64,128,252,512,236,2048,4096,8,16384,32768,32802,4264,262144,53501,1048576,16464,32904,53249,16777216,33554432,20729,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4161,68719476736]

theorem envBound43 : H12AffineState.Bounded env43 := by
  intro p hp
  have h : env43.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans42_43 : H12PackedSparse.directTransform 16 4264 env42 = env43 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 16 4264 env42 == env43) = true)

theorem identity43 : scanCanonicalize (H12AffineState.compose env43 (packedSelected [13] rootPS)) = affineNative (2^(6+1) ^^^ 40) := by decide +kernel

theorem selectedBound43 : packedSelected [13] rootPS < 2^1333 := by decide +kernel

def env44 : List Nat := [2,4,8,16,32,64,40,84,512,68,2048,4096,8,16384,32768,32802,4096,262144,53333,1048576,16464,32800,53249,16777216,33554432,20561,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4161,68719476736]

theorem envBound44 : H12AffineState.Bounded env44 := by
  intro p hp
  have h : env44.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans43_44 : H12PackedSparse.directTransform 6 40 env43 = env44 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 6 40 env43 == env44) = true)

theorem identity44 : scanCanonicalize (H12AffineState.compose env44 (packedSelected [2,4,6,9,11] rootPS)) = affineNative (2^(17+1) ^^^ 34848) := by decide +kernel

theorem selectedBound44 : packedSelected [2,4,6,9,11] rootPS < 2^1333 := by decide +kernel

def env45 : List Nat := [2,4,8,16,32,64,40,84,512,68,2048,4096,8,16384,32768,32802,4096,34848,53333,1048576,16464,32800,53249,16777216,33554432,20561,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4161,68719476736]

theorem envBound45 : H12AffineState.Bounded env45 := by
  intro p hp
  have h : env45.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans44_45 : H12PackedSparse.directTransform 17 34848 env44 = env45 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 17 34848 env44 == env45) = true)

theorem identity45 : scanCanonicalize (H12AffineState.compose env45 (packedSelected [0,2,4,7,9] rootPS)) = affineNative (2^(14+1) ^^^ 0) := by decide +kernel

theorem selectedBound45 : packedSelected [0,2,4,7,9] rootPS < 2^1333 := by decide +kernel

def env46 : List Nat := [2,4,8,16,32,64,40,84,512,68,2048,4096,8,16384,0,34,4096,2080,20565,1048576,16464,32,20481,16777216,33554432,20561,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4161,68719476736]

theorem envBound46 : H12AffineState.Bounded env46 := by
  intro p hp
  have h : env46.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans45_46 : H12PackedSparse.directTransform 14 0 env45 = env46 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 14 0 env45 == env46) = true)

theorem identity46 : scanCanonicalize (H12AffineState.compose env46 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound46 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env47 : List Nat := [2,4,8,16,32,16,40,4,512,20,2048,4096,8,16384,0,34,4096,2080,20485,1048576,16384,32,20481,16777216,33554432,20481,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4113,68719476736]

theorem envBound47 : H12AffineState.Bounded env47 := by
  intro p hp
  have h : env47.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans46_47 : H12PackedSparse.directTransform 5 16 env46 = env47 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 5 16 env46 == env47) = true)

theorem identity47 : scanCanonicalize (H12AffineState.compose env47 (packedSelected [6] rootPS)) = affineNative (2^(13+1) ^^^ 4113) := by decide +kernel

theorem selectedBound47 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env48 : List Nat := [2,4,8,16,32,16,40,4,512,20,2048,4096,8,4113,0,34,4096,2080,20,1048576,4113,32,16,16777216,33554432,16,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4113,68719476736]

theorem envBound48 : H12AffineState.Bounded env48 := by
  intro p hp
  have h : env48.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans47_48 : H12PackedSparse.directTransform 13 4113 env47 = env48 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 13 4113 env47 == env48) = true)

theorem identity48 : scanCanonicalize (H12AffineState.compose env48 (packedSelected [0,4] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound48 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env49 : List Nat := [2,4,8,16,10,16,2,4,512,20,2048,4096,8,4113,0,8,4096,2058,20,1048576,4113,10,16,16777216,33554432,16,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4113,68719476736]

theorem envBound49 : H12AffineState.Bounded env49 := by
  intro p hp
  have h : env49.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans48_49 : H12PackedSparse.directTransform 4 10 env48 = env49 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 4 10 env48 == env49) = true)

theorem identity49 : scanCanonicalize (H12AffineState.compose env49 (packedSelected [1,5] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound49 : packedSelected [1,5] rootPS < 2^1333 := by decide +kernel

def env50 : List Nat := [2,4,8,0,10,0,2,4,512,4,2048,4096,8,4097,0,8,4096,2058,4,1048576,4097,10,0,16777216,33554432,0,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4097,68719476736]

theorem envBound50 : H12AffineState.Bounded env50 := by
  intro p hp
  have h : env50.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans49_50 : H12PackedSparse.directTransform 3 0 env49 = env50 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 3 0 env49 == env50) = true)

theorem identity50 : scanCanonicalize (H12AffineState.compose env50 (packedSelected [0,7] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound50 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env51 : List Nat := [2,4,2,0,0,0,2,4,512,4,2048,4096,2,4097,0,2,4096,2048,4,1048576,4097,0,0,16777216,33554432,0,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4097,68719476736]

theorem envBound51 : H12AffineState.Bounded env51 := by
  intro p hp
  have h : env51.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans50_51 : H12PackedSparse.directTransform 2 2 env50 = env51 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 2 2 env50 == env51) = true)

theorem identity51 : scanCanonicalize (H12AffineState.compose env51 (packedSelected [0] rootPS)) = affineNative (2^(11+1) ^^^ 2051) := by decide +kernel

theorem selectedBound51 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env52 : List Nat := [2,4,2,0,0,0,2,4,512,4,2048,2051,2,2050,0,2,2051,2048,4,1048576,2050,0,0,16777216,33554432,0,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,2050,68719476736]

theorem envBound52 : H12AffineState.Bounded env52 := by
  intro p hp
  have h : env52.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans51_52 : H12PackedSparse.directTransform 11 2051 env51 = env52 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 11 2051 env51 == env52) = true)

theorem identity52 : scanCanonicalize (H12AffineState.compose env52 (packedSelected [1] rootPS)) = affineNative (2^(1+1) ^^^ 0) := by decide +kernel

theorem selectedBound52 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env53 : List Nat := [2,0,2,0,0,0,2,0,512,0,2048,2051,2,2050,0,2,2051,2048,0,1048576,2050,0,0,16777216,33554432,0,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,2050,68719476736]

theorem envBound53 : H12AffineState.Bounded env53 := by
  intro p hp
  have h : env53.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans52_53 : H12PackedSparse.directTransform 1 0 env52 = env53 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 1 0 env52 == env53) = true)

def w16 : H12WitnessTheory.Witness := H12WitnessData000.batch0[57]'(by decide)

theorem w16_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w16.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData000.batch0 H12WitnessData000.batch0_checked _ (List.getElem_mem (by decide))

theorem w16_good : H12WitnessSearch.Good (.leaf w16) := by
  intro c hc
  have he : w16.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w16_reject

def w17 : H12WitnessTheory.Witness := H12WitnessData001.batch7[65]'(by decide)

theorem w17_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w17.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData001.batch7 H12WitnessData001.batch7_checked _ (List.getElem_mem (by decide))

theorem w17_good : H12WitnessSearch.Good (.leaf w17) := by
  intro c hc
  have he : w17.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w17_reject

def w18 : H12WitnessTheory.Witness := H12WitnessData005.batch11[73]'(by decide)

theorem w18_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w18.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData005.batch11 H12WitnessData005.batch11_checked _ (List.getElem_mem (by decide))

theorem w18_good : H12WitnessSearch.Good (.leaf w18) := by
  intro c hc
  have he : w18.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w18_reject

def w19 : H12WitnessTheory.Witness := H12WitnessData007.batch2[102]'(by decide)

theorem w19_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w19.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData007.batch2 H12WitnessData007.batch2_checked _ (List.getElem_mem (by decide))

theorem w19_good : H12WitnessSearch.Good (.leaf w19) := by
  intro c hc
  have he : w19.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w19_reject

def w20 : H12WitnessTheory.Witness := H12WitnessData014.batch3[232]'(by decide)

theorem w20_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w20.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData014.batch3 H12WitnessData014.batch3_checked _ (List.getElem_mem (by decide))

theorem w20_good : H12WitnessSearch.Good (.leaf w20) := by
  intro c hc
  have he : w20.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w20_reject

def w21 : H12WitnessTheory.Witness := H12WitnessData015.batch10[138]'(by decide)

theorem w21_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w21.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData015.batch10 H12WitnessData015.batch10_checked _ (List.getElem_mem (by decide))

theorem w21_good : H12WitnessSearch.Good (.leaf w21) := by
  intro c hc
  have he : w21.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w21_reject

def w22 : H12WitnessTheory.Witness := H12WitnessData019.batch15[19]'(by decide)

theorem w22_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w22.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData019.batch15 H12WitnessData019.batch15_checked _ (List.getElem_mem (by decide))

theorem w22_good : H12WitnessSearch.Good (.leaf w22) := by
  intro c hc
  have he : w22.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w22_reject

def w23 : H12WitnessTheory.Witness := H12WitnessData021.batch5[186]'(by decide)

theorem w23_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w23.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData021.batch5 H12WitnessData021.batch5_checked _ (List.getElem_mem (by decide))

theorem w23_good : H12WitnessSearch.Good (.leaf w23) := by
  intro c hc
  have he : w23.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w23_reject

def leafEnv53 : List Nat := [2,0,2,0,0,0,2,0,512,0,2048,2051,2,2050,0,2,2051,2048,0,0,2050,0,0,2,0,2,1,0,2048,2051,2051,2048,0,0,0,0,0,2,2050,512,1,2050,0]

def active53 : List Nat := [0,8,10]

def tree53 : H12WitnessSearch.Tree := (.node 3575897007104 (.node 1650945231104 (.node 1241086401605 (.leaf w16) (.leaf w17)) (.node 1790842215749 (.leaf w18) (.leaf w19))) (.node 4125652821248 (.node 3710961889349 (.leaf w20) (.leaf w21)) (.node 4260717703493 (.leaf w22) (.leaf w23))))

theorem treeGood53 : H12WitnessSearch.Good tree53 := (H12WitnessSearch.node_good 3575897007104 _ _ (H12WitnessSearch.node_good 1650945231104 _ _ (H12WitnessSearch.node_good 1241086401605 _ _ w16_good w17_good) (H12WitnessSearch.node_good 1790842215749 _ _ w18_good w19_good)) (H12WitnessSearch.node_good 4125652821248 _ _ (H12WitnessSearch.node_good 3710961889349 _ _ w20_good w21_good) (H12WitnessSearch.node_good 4260717703493 _ _ w22_good w23_good)))

theorem leafIdentity53 : H12AffineState.composeSystem env53 rootObs = leafEnv53 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineState.composeSystem env53 rootObs == leafEnv53) = true)

theorem terminalChecked53 : H12PackedTerminal.terminalCheckFast leafEnv53 active53 tree53 = true := by decide +kernel

def env54 : List Nat := [2,4,8,16,32,64,128,252,512,237,2048,4096,8192,16384,32768,65536,131072,262144,188508,1048576,114803,41088,8388608,16777216,33554432,147537,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,8614083,68719476736]

theorem envBound54 : H12AffineState.Bounded env54 := by
  intro p hp
  have h : env54.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans38_54 : H12PackedSparse.directTransform 9 237 env38 = env54 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 9 237 env38 == env54) = true)

theorem identity54 : scanCanonicalize (H12AffineState.compose env54 (packedSelected [0,2,7,11,13,14,17,18,20] rootPS)) = affineNative (2^(15+1) ^^^ 41002) := by decide +kernel

theorem selectedBound54 : packedSelected [0,2,7,11,13,14,17,18,20] rootPS < 2^1333 := by decide +kernel

def env55 : List Nat := [2,4,8,16,32,64,128,252,512,237,2048,4096,8192,16384,32768,41002,131072,262144,188508,1048576,24665,41088,8388608,16777216,33554432,147537,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,8573161,68719476736]

theorem envBound55 : H12AffineState.Bounded env55 := by
  intro p hp
  have h : env55.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans54_55 : H12PackedSparse.directTransform 15 41002 env54 = env55 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 15 41002 env54 == env55) = true)

theorem identity55 : scanCanonicalize (H12AffineState.compose env55 (packedSelected [0,2,6,9,11,13,17,18,22,27] rootPS)) = affineNative (2^(22+1) ^^^ 188577) := by decide +kernel

theorem selectedBound55 : packedSelected [0,2,6,9,11,13,17,18,22,27] rootPS < 2^1333 := by decide +kernel

def env56 : List Nat := [2,4,8,16,32,64,128,252,512,237,2048,4096,8192,16384,32768,41002,131072,262144,188508,1048576,24665,41088,188577,16777216,33554432,147537,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,12360,68719476736]

theorem envBound56 : H12AffineState.Bounded env56 := by
  intro p hp
  have h : env56.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans55_56 : H12PackedSparse.directTransform 22 188577 env55 = env56 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 22 188577 env55 == env56) = true)

theorem identity56 : scanCanonicalize (H12AffineState.compose env56 (packedSelected [2,9,11,13,17,18,22] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

end H12AffineCanonicalPilot
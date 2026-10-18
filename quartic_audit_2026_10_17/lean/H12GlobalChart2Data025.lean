import H12GlobalChart2Data024

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem envBound6127 : H12AffineFastState.Bounded env6127 := by
  intro p hp
  have h : env6127.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6126_6127 : H12AffineEnvironment.transform 7 37 env6126 = env6127 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env6126 == env6127) = true)

theorem identity6127 : scanCanonicalize (H12AffineFastState.compose env6127 (packedSelected [0,2,4] rootPS)) = affineNative (2^(31+1) ^^^ 4322) := by decide +kernel

theorem selectedBound6127 : packedSelected [0,2,4] rootPS < 2^1333 := by decide +kernel

def env6128 : List Nat := [2,4,8,16,32,64,128,37,137,36,32,4096,8,64,33,138,4176,33,37,33,4097,33,64,138,4241,16,33,4176,17,4145,4116,4322,4148,243,4177,4248]

theorem envBound6128 : H12AffineFastState.Bounded env6128 := by
  intro p hp
  have h : env6128.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6127_6128 : H12AffineEnvironment.transform 31 4322 env6127 = env6128 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4322 env6127 == env6128) = true)

theorem identity6128 : scanCanonicalize (H12AffineFastState.compose env6128 (packedSelected [2,5] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound6128 : packedSelected [2,5] rootPS < 2^1333 := by decide +kernel

def env6129 : List Nat := [2,4,8,16,10,64,128,15,137,14,10,4096,8,64,11,138,4176,11,15,11,4097,11,64,138,4241,16,11,4176,17,4123,4116,4296,4126,217,4177,4248]

theorem envBound6129 : H12AffineFastState.Bounded env6129 := by
  intro p hp
  have h : env6129.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6128_6129 : H12AffineEnvironment.transform 4 10 env6128 = env6129 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env6128 == env6129) = true)

theorem identity6129 : scanCanonicalize (H12AffineFastState.compose env6129 (packedSelected [0,3,7] rootPS)) = affineNative (2^(5+1) ^^^ 27) := by decide +kernel

theorem selectedBound6129 : packedSelected [0,3,7] rootPS < 2^1333 := by decide +kernel

def env6130 : List Nat := [2,4,8,16,10,27,128,15,137,14,10,4096,8,27,11,138,4107,11,15,11,4097,11,27,138,4241,16,11,4107,17,4123,4116,4243,4126,130,4106,4248]

theorem envBound6130 : H12AffineFastState.Bounded env6130 := by
  intro p hp
  have h : env6130.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6129_6130 : H12AffineEnvironment.transform 5 27 env6129 = env6130 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 27 env6129 == env6130) = true)

theorem identity6130 : scanCanonicalize (H12AffineFastState.compose env6130 (packedSelected [1,2,3] rootPS)) = affineNative (2^(11+1) ^^^ 17) := by decide +kernel

theorem selectedBound6130 : packedSelected [1,2,3] rootPS < 2^1333 := by decide +kernel

def env6131 : List Nat := [2,4,8,16,10,27,128,15,137,14,10,17,8,27,11,138,26,11,15,11,16,11,27,138,128,16,11,26,17,10,5,130,15,130,27,137]

theorem envBound6131 : H12AffineFastState.Bounded env6131 := by
  intro p hp
  have h : env6131.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6130_6131 : H12AffineEnvironment.transform 11 17 env6130 = env6131 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 17 env6130 == env6131) = true)

theorem identity6131 : scanCanonicalize (H12AffineFastState.compose env6131 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 0) := by decide +kernel

theorem selectedBound6131 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6132 : List Nat := [2,4,8,16,10,27,0,15,9,14,10,17,8,27,11,10,26,11,15,11,16,11,27,10,0,16,11,26,17,10,5,2,15,2,27,9]

theorem envBound6132 : H12AffineFastState.Bounded env6132 := by
  intro p hp
  have h : env6132.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6131_6132 : H12AffineEnvironment.transform 6 0 env6131 = env6132 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 0 env6131 == env6132) = true)

theorem identity6132 : scanCanonicalize (H12AffineFastState.compose env6132 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 0) := by decide +kernel

theorem selectedBound6132 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6133 : List Nat := [2,4,0,16,2,19,0,7,1,6,2,17,0,19,3,2,18,3,7,3,16,3,19,2,0,16,3,18,17,2,5,2,7,2,19,1]

theorem envBound6133 : H12AffineFastState.Bounded env6133 := by
  intro p hp
  have h : env6133.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6132_6133 : H12AffineEnvironment.transform 2 0 env6132 = env6133 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env6132 == env6133) = true)

theorem identity6133 : scanCanonicalize (H12AffineFastState.compose env6133 (packedSelected [10] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound6133 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env6134 : List Nat := [0,4,0,16,0,17,0,5,1,4,0,17,0,17,1,0,16,1,5,1,16,1,17,0,0,16,1,16,17,0,5,0,5,0,17,1]

theorem envBound6134 : H12AffineFastState.Bounded env6134 := by
  intro p hp
  have h : env6134.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6133_6134 : H12AffineEnvironment.transform 0 0 env6133 = env6134 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env6133 == env6134) = true)

def leafEnv6134 : List Nat := [0,4,0,16,0,17,0,5,1,4,0,17,0,17,1,0,16,1,5,1,16,1,17,0,4,0,1,16,1,16,17,0,5,0,5,0,4,0,17,1,0,16,1]

def active6134 : List Nat := [1,3]

def tree6134 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6134 : H12WitnessSearch.Good tree6134 := H12GlobalWitnessIndex.good

theorem leafIdentity6134 : H12AffineFastState.composeSystem env6134 rootObs = leafEnv6134 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6134 rootObs == leafEnv6134) = true)

theorem terminalChecked6134 : H12PackedTerminal.terminalCheckFast leafEnv6134 active6134 tree6134 = true := by decide +kernel

def env6135 : List Nat := [2,4,8,16,32,64,128,256,512,257,2048,4096,8192,16384,10881,65536,20496,681,524288,10881,4097,4194304,16384,76677,89046,16464,4195245,4176,17,4289114,20564,4294967296,20817,4299706736,20497,96606]

theorem envBound6135 : H12AffineFastState.Bounded env6135 := by
  intro p hp
  have h : env6135.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6070_6135 : H12AffineEnvironment.transform 14 10881 env6070 = env6135 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 10881 env6070 == env6135) = true)

def env6136 : List Nat := [2,4,8,16,32,64,128,256,512,257,2048,4096,8192,16384,10881,65536,20496,681,524288,10881,4097,10248,16384,76677,89046,16464,11173,4176,17,88658,20564,4294967296,20817,4295522680,20497,96606]

theorem envBound6136 : H12AffineFastState.Bounded env6136 := by
  intro p hp
  have h : env6136.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6135_6136 : H12AffineEnvironment.transform 21 10248 env6135 = env6136 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10248 env6135 == env6136) = true)

theorem identity6136 : scanCanonicalize (H12AffineFastState.compose env6136 (packedSelected [11] rootPS)) = affineNative (2^(15+1) ^^^ 4251) := by decide +kernel

theorem selectedBound6136 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env6137 : List Nat := [2,4,8,16,32,64,128,256,512,257,2048,4096,8192,16384,10881,4251,20496,681,524288,10881,4097,10248,16384,15134,19277,16464,11173,4176,17,19145,20564,4294967296,20817,4295522680,20497,27077]

theorem envBound6137 : H12AffineFastState.Bounded env6137 := by
  intro p hp
  have h : env6137.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6136_6137 : H12AffineEnvironment.transform 15 4251 env6136 = env6137 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 4251 env6136 == env6137) = true)

def env6138 : List Nat := [2,4,8,16,32,64,128,256,512,257,680,4096,8192,16384,8233,4251,20496,681,524288,8233,4097,8864,16384,12726,16869,16464,8461,4176,17,16481,20564,4294967296,20817,4295521232,20497,25453]

theorem envBound6138 : H12AffineFastState.Bounded env6138 := by
  intro p hp
  have h : env6138.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6137_6138 : H12AffineEnvironment.transform 10 680 env6137 = env6138 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 680 env6137 == env6138) = true)

theorem identity6138 : scanCanonicalize (H12AffineFastState.compose env6138 (packedSelected [18] rootPS)) = affineNative (2^(13+1) ^^^ 13301) := by decide +kernel

theorem selectedBound6138 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env6139 : List Nat := [2,4,8,16,32,64,128,256,512,257,680,4096,8192,13301,8233,4251,9189,681,524288,8233,4097,8864,13301,12726,12816,13221,8461,4176,17,13204,9121,4294967296,8868,4295491621,9188,4248]

theorem envBound6139 : H12AffineFastState.Bounded env6139 := by
  intro p hp
  have h : env6139.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6138_6139 : H12AffineEnvironment.transform 13 13301 env6138 = env6139 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 13301 env6138 == env6139) = true)

theorem identity6139 : scanCanonicalize (H12AffineFastState.compose env6139 (packedSelected [3,8,10,12] rootPS)) = affineNative (2^(12+1) ^^^ 300) := by decide +kernel

theorem selectedBound6139 : packedSelected [3,8,10,12] rootPS < 2^1333 := by decide +kernel

def env6140 : List Nat := [2,4,8,16,32,64,128,256,512,257,680,4096,300,4825,261,4251,713,681,524288,261,4097,908,4825,4250,4924,4745,33,4176,17,4792,653,4294967296,904,4295491621,712,4248]

theorem envBound6140 : H12AffineFastState.Bounded env6140 := by
  intro p hp
  have h : env6140.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6139_6140 : H12AffineEnvironment.transform 12 300 env6139 = env6140 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 300 env6139 == env6140) = true)

theorem identity6140 : scanCanonicalize (H12AffineFastState.compose env6140 (packedSelected [0,3,4,7,8,9,10,15] rootPS)) = affineNative (2^(11+1) ^^^ 665) := by decide +kernel

theorem selectedBound6140 : packedSelected [0,3,4,7,8,9,10,15] rootPS < 2^1333 := by decide +kernel

def env6141 : List Nat := [2,4,8,16,32,64,128,256,512,257,680,665,300,64,261,514,713,681,524288,261,664,908,64,515,421,16,33,713,17,33,653,4294967296,904,4295491621,712,513]

theorem envBound6141 : H12AffineFastState.Bounded env6141 := by
  intro p hp
  have h : env6141.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6140_6141 : H12AffineEnvironment.transform 11 665 env6140 = env6141 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 665 env6140 == env6141) = true)

theorem identity6141 : scanCanonicalize (H12AffineFastState.compose env6141 (packedSelected [0,7] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound6141 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env6142 : List Nat := [2,4,8,16,32,64,128,256,137,257,33,16,300,64,261,139,64,32,524288,261,17,261,64,138,421,16,33,64,17,33,4,4294967296,257,4295491621,65,136]

theorem envBound6142 : H12AffineFastState.Bounded env6142 := by
  intro p hp
  have h : env6142.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6141_6142 : H12AffineEnvironment.transform 8 137 env6141 = env6142 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6141 == env6142) = true)

theorem identity6142 : scanCanonicalize (H12AffineFastState.compose env6142 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound6142 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env6143 : List Nat := [2,4,8,16,32,64,128,4,137,5,33,16,40,64,1,139,64,32,524288,1,17,1,64,138,161,16,33,64,17,33,4,4294967296,5,4295491621,65,136]

theorem envBound6143 : H12AffineFastState.Bounded env6143 := by
  intro p hp
  have h : env6143.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6142_6143 : H12AffineEnvironment.transform 7 4 env6142 = env6143 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env6142 == env6143) = true)

def env6144 : List Nat := [2,4,8,16,0,64,128,4,137,5,1,16,8,64,1,139,64,0,524288,1,17,1,64,138,129,16,1,64,17,1,4,4294967296,5,4295491589,65,136]

theorem envBound6144 : H12AffineFastState.Bounded env6144 := by
  intro p hp
  have h : env6144.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6143_6144 : H12AffineEnvironment.transform 4 0 env6143 = env6144 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env6143 == env6144) = true)

theorem identity6144 : scanCanonicalize (H12AffineFastState.compose env6144 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 91) := by decide +kernel

theorem selectedBound6144 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6145 : List Nat := [2,4,8,16,0,64,128,4,137,5,1,16,8,64,1,139,64,0,524288,1,17,1,64,138,129,16,1,64,17,1,4,91,5,524382,65,136]

theorem envBound6145 : H12AffineFastState.Bounded env6145 := by
  intro p hp
  have h : env6145.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6144_6145 : H12AffineEnvironment.transform 31 91 env6144 = env6145 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 91 env6144 == env6145) = true)

def env6146 : List Nat := [2,4,8,16,0,64,128,4,137,5,1,16,8,64,1,139,64,0,4,1,17,1,64,138,129,16,1,64,17,1,4,91,5,90,65,136]

theorem envBound6146 : H12AffineFastState.Bounded env6146 := by
  intro p hp
  have h : env6146.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6145_6146 : H12AffineEnvironment.transform 18 4 env6145 = env6146 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 4 env6145 == env6146) = true)

theorem identity6146 : scanCanonicalize (H12AffineFastState.compose env6146 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound6146 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6147 : List Nat := [2,4,8,16,0,64,9,4,0,5,1,16,8,64,1,2,64,0,4,1,17,1,64,3,8,16,1,64,17,1,4,91,5,90,65,1]

theorem envBound6147 : H12AffineFastState.Bounded env6147 := by
  intro p hp
  have h : env6147.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6146_6147 : H12AffineEnvironment.transform 6 9 env6146 = env6147 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env6146 == env6147) = true)

theorem identity6147 : scanCanonicalize (H12AffineFastState.compose env6147 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound6147 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6148 : List Nat := [2,4,2,16,0,64,3,4,0,5,1,16,2,64,1,2,64,0,4,1,17,1,64,3,2,16,1,64,17,1,4,81,5,80,65,1]

theorem envBound6148 : H12AffineFastState.Bounded env6148 := by
  intro p hp
  have h : env6148.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6147_6148 : H12AffineEnvironment.transform 2 2 env6147 = env6148 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env6147 == env6148) = true)

def leafEnv6148 : List Nat := [2,4,2,16,0,64,3,4,0,5,1,16,2,64,1,2,64,0,4,1,17,1,64,3,4,2,1,16,1,64,17,1,4,81,5,80,4,2,65,1,0,17,1]

def active6148 : List Nat := [0,1,3,5]

def tree6148 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6148 : H12WitnessSearch.Good tree6148 := H12GlobalWitnessIndex.good

theorem leafIdentity6148 : H12AffineFastState.composeSystem env6148 rootObs = leafEnv6148 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6148 rootObs == leafEnv6148) = true)

theorem terminalChecked6148 : H12PackedTerminal.terminalCheckFast leafEnv6148 active6148 tree6148 = true := by decide +kernel

def env6149 : List Nat := [2,4,8,16,0,64,128,4,137,5,1,16,8,64,1,139,64,0,5,1,17,1,64,138,129,16,1,64,17,1,4,91,5,91,65,136]

theorem envBound6149 : H12AffineFastState.Bounded env6149 := by
  intro p hp
  have h : env6149.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6145_6149 : H12AffineEnvironment.transform 18 5 env6145 = env6149 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 5 env6145 == env6149) = true)

theorem identity6149 : scanCanonicalize (H12AffineFastState.compose env6149 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound6149 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6150 : List Nat := [2,4,8,16,0,64,3,4,10,5,1,16,8,64,1,8,64,0,5,1,17,1,64,9,2,16,1,64,17,1,4,91,5,91,65,11]

theorem envBound6150 : H12AffineFastState.Bounded env6150 := by
  intro p hp
  have h : env6150.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6149_6150 : H12AffineEnvironment.transform 6 3 env6149 = env6150 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env6149 == env6150) = true)

def leafEnv6150 : List Nat := [2,4,8,16,0,64,3,4,10,5,1,16,8,64,1,8,64,0,5,1,17,1,64,9,5,2,1,16,1,64,17,1,4,91,5,91,4,2,65,11,0,17,1]

def active6150 : List Nat := [0,1,2,3,5]

def tree6150 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6150 : H12WitnessSearch.Good tree6150 := H12GlobalWitnessIndex.good

theorem leafIdentity6150 : H12AffineFastState.composeSystem env6150 rootObs = leafEnv6150 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6150 rootObs == leafEnv6150) = true)

theorem terminalChecked6150 : H12PackedTerminal.terminalCheckFast leafEnv6150 active6150 tree6150 = true := by decide +kernel

def env6151 : List Nat := [2,4,8,16,1,64,128,4,137,5,0,16,9,64,1,139,64,1,524288,1,17,1,64,138,128,16,0,64,17,0,4,4294967296,5,4295491588,65,136]

theorem envBound6151 : H12AffineFastState.Bounded env6151 := by
  intro p hp
  have h : env6151.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6143_6151 : H12AffineEnvironment.transform 4 1 env6143 = env6151 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env6143 == env6151) = true)

theorem identity6151 : scanCanonicalize (H12AffineFastState.compose env6151 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 210) := by decide +kernel

theorem selectedBound6151 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6152 : List Nat := [2,4,8,16,1,64,128,4,137,5,0,16,9,64,1,139,64,1,524288,1,17,1,64,138,128,16,0,64,17,0,4,210,5,524502,65,136]

theorem envBound6152 : H12AffineFastState.Bounded env6152 := by
  intro p hp
  have h : env6152.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6151_6152 : H12AffineEnvironment.transform 31 210 env6151 = env6152 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 210 env6151 == env6152) = true)

theorem identity6152 : scanCanonicalize (H12AffineFastState.compose env6152 (packedSelected [1,2,5] rootPS)) = affineNative (2^(18+1) ^^^ 5) := by decide +kernel

theorem selectedBound6152 : packedSelected [1,2,5] rootPS < 2^1333 := by decide +kernel

def env6153 : List Nat := [2,4,8,16,1,64,128,4,137,5,0,16,9,64,1,139,64,1,5,1,17,1,64,138,128,16,0,64,17,0,4,210,5,211,65,136]

theorem envBound6153 : H12AffineFastState.Bounded env6153 := by
  intro p hp
  have h : env6153.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6152_6153 : H12AffineEnvironment.transform 18 5 env6152 = env6153 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 5 env6152 == env6153) = true)

theorem identity6153 : scanCanonicalize (H12AffineFastState.compose env6153 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 83) := by decide +kernel

theorem selectedBound6153 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6154 : List Nat := [2,4,8,16,1,64,83,4,90,5,0,16,9,64,1,88,64,1,5,1,17,1,64,89,83,16,0,64,17,0,4,1,5,0,65,91]

theorem envBound6154 : H12AffineFastState.Bounded env6154 := by
  intro p hp
  have h : env6154.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6153_6154 : H12AffineEnvironment.transform 6 83 env6153 = env6154 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 83 env6153 == env6154) = true)

theorem identity6154 : scanCanonicalize (H12AffineFastState.compose env6154 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound6154 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6155 : List Nat := [2,4,3,16,1,64,83,4,81,5,0,16,2,64,1,83,64,1,5,1,17,1,64,82,83,16,0,64,17,0,4,1,5,0,65,80]

theorem envBound6155 : H12AffineFastState.Bounded env6155 := by
  intro p hp
  have h : env6155.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6154_6155 : H12AffineEnvironment.transform 2 3 env6154 = env6155 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env6154 == env6155) = true)

def leafEnv6155 : List Nat := [2,4,3,16,1,64,83,4,81,5,0,16,2,64,1,83,64,1,5,1,17,1,64,82,5,83,1,16,0,64,17,0,4,1,5,0,4,2,65,80,0,17,1]

def active6155 : List Nat := [0,1,3,5]

def tree6155 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6155 : H12WitnessSearch.Good tree6155 := H12GlobalWitnessIndex.good

theorem leafIdentity6155 : H12AffineFastState.composeSystem env6155 rootObs = leafEnv6155 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6155 rootObs == leafEnv6155) = true)

theorem terminalChecked6155 : H12PackedTerminal.terminalCheckFast leafEnv6155 active6155 tree6155 = true := by decide +kernel

def env6156 : List Nat := [2,4,8,16,32,64,128,256,512,257,681,4096,8192,16384,8232,4251,20496,681,524288,8232,4097,8865,16384,12727,16868,16464,8460,4176,17,16480,20564,4294967296,20817,4295521233,20497,25452]

theorem envBound6156 : H12AffineFastState.Bounded env6156 := by
  intro p hp
  have h : env6156.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6137_6156 : H12AffineEnvironment.transform 10 681 env6137 = env6156 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 681 env6137 == env6156) = true)

theorem identity6156 : scanCanonicalize (H12AffineFastState.compose env6156 (packedSelected [18] rootPS)) = affineNative (2^(13+1) ^^^ 4177) := by decide +kernel

theorem selectedBound6156 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env6157 : List Nat := [2,4,8,16,32,64,128,256,512,257,681,4096,8192,4177,8232,4251,65,681,524288,8232,4097,8865,4177,12727,4533,4097,8460,4176,17,4145,5,4294967296,256,4295500672,64,13117]

theorem envBound6157 : H12AffineFastState.Bounded env6157 := by
  intro p hp
  have h : env6157.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6156_6157 : H12AffineEnvironment.transform 13 4177 env6156 = env6157 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env6156 == env6157) = true)

theorem identity6157 : scanCanonicalize (H12AffineFastState.compose env6157 (packedSelected [3,8,10,12] rootPS)) = affineNative (2^(18+1) ^^^ 5017) := by decide +kernel

theorem selectedBound6157 : packedSelected [3,8,10,12] rootPS < 2^1333 := by decide +kernel

def env6158 : List Nat := [2,4,8,16,32,64,128,256,512,257,681,4096,8192,4177,8232,4251,65,681,5017,8232,4097,8865,4177,12727,4533,4097,8460,4176,17,4145,5,4294967296,256,4294979609,64,13117]

theorem envBound6158 : H12AffineFastState.Bounded env6158 := by
  intro p hp
  have h : env6158.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6157_6158 : H12AffineEnvironment.transform 18 5017 env6157 = env6158 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 5017 env6157 == env6158) = true)

theorem identity6158 : scanCanonicalize (H12AffineFastState.compose env6158 (packedSelected [0,4,5,7,8,9] rootPS)) = affineNative (2^(11+1) ^^^ 17) := by decide +kernel

theorem selectedBound6158 : packedSelected [0,4,5,7,8,9] rootPS < 2^1333 := by decide +kernel

def env6159 : List Nat := [2,4,8,16,32,64,128,256,512,257,681,17,8192,64,8232,138,65,681,904,8232,16,8865,64,8614,420,16,8460,65,17,32,5,4294967296,256,4294975496,64,9004]

theorem envBound6159 : H12AffineFastState.Bounded env6159 := by
  intro p hp
  have h : env6159.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6158_6159 : H12AffineEnvironment.transform 11 17 env6158 = env6159 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 17 env6158 == env6159) = true)

theorem identity6159 : scanCanonicalize (H12AffineFastState.compose env6159 (packedSelected [3,5,10,15] rootPS)) = affineNative (2^(12+1) ^^^ 933) := by decide +kernel

theorem selectedBound6159 : packedSelected [3,5,10,15] rootPS < 2^1333 := by decide +kernel

def env6160 : List Nat := [2,4,8,16,32,64,128,256,512,257,681,17,933,64,909,138,65,681,904,909,16,260,64,515,420,16,681,65,17,32,5,4294967296,256,4294968237,64,137]

theorem envBound6160 : H12AffineFastState.Bounded env6160 := by
  intro p hp
  have h : env6160.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6159_6160 : H12AffineEnvironment.transform 12 933 env6159 = env6160 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 933 env6159 == env6160) = true)

theorem identity6160 : scanCanonicalize (H12AffineFastState.compose env6160 (packedSelected [0,1,3,7] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound6160 : packedSelected [0,1,3,7] rootPS < 2^1333 := by decide +kernel

def env6161 : List Nat := [2,4,8,16,32,64,8,256,512,257,545,17,813,64,773,2,65,545,768,773,16,260,64,515,300,16,545,65,17,32,5,4294967296,256,4294968101,64,1]

theorem envBound6161 : H12AffineFastState.Bounded env6161 := by
  intro p hp
  have h : env6161.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6160_6161 : H12AffineEnvironment.transform 6 8 env6160 = env6161 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env6160 == env6161) = true)

theorem identity6161 : scanCanonicalize (H12AffineFastState.compose env6161 (packedSelected [1,3] rootPS)) = affineNative (2^(8+1) ^^^ 1) := by decide +kernel

theorem selectedBound6161 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env6162 : List Nat := [2,4,8,16,32,64,8,256,1,257,32,17,300,64,260,2,65,32,257,260,16,260,64,2,300,16,32,65,17,32,5,4294967296,256,4294967588,64,1]

theorem envBound6162 : H12AffineFastState.Bounded env6162 := by
  intro p hp
  have h : env6162.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6161_6162 : H12AffineEnvironment.transform 8 1 env6161 = env6162 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 1 env6161 == env6162) = true)

theorem identity6162 : scanCanonicalize (H12AffineFastState.compose env6162 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 115) := by decide +kernel

theorem selectedBound6162 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6163 : List Nat := [2,4,8,16,32,64,8,256,1,257,32,17,300,64,260,2,65,32,257,260,16,260,64,2,300,16,32,65,17,32,5,115,256,343,64,1]

theorem envBound6163 : H12AffineFastState.Bounded env6163 := by
  intro p hp
  have h : env6163.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6162_6163 : H12AffineEnvironment.transform 31 115 env6162 = env6163 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 115 env6162 == env6163) = true)

theorem identity6163 : scanCanonicalize (H12AffineFastState.compose env6163 (packedSelected [2,4] rootPS)) = affineNative (2^(2+1) ^^^ 0) := by decide +kernel

theorem selectedBound6163 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env6164 : List Nat := [2,4,0,16,32,64,0,256,1,257,32,17,292,64,260,2,65,32,257,260,16,260,64,2,292,16,32,65,17,32,5,115,256,343,64,1]

theorem envBound6164 : H12AffineFastState.Bounded env6164 := by
  intro p hp
  have h : env6164.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6163_6164 : H12AffineEnvironment.transform 2 0 env6163 = env6164 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env6163 == env6164) = true)

theorem identity6164 : scanCanonicalize (H12AffineFastState.compose env6164 (packedSelected [5] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound6164 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env6165 : List Nat := [2,4,0,16,32,16,0,256,1,257,32,17,292,16,260,2,17,32,257,260,16,260,16,2,292,16,32,17,17,32,5,35,256,263,16,1]

theorem envBound6165 : H12AffineFastState.Bounded env6165 := by
  intro p hp
  have h : env6165.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6164_6165 : H12AffineEnvironment.transform 5 16 env6164 = env6165 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env6164 == env6165) = true)

theorem identity6165 : scanCanonicalize (H12AffineFastState.compose env6165 (packedSelected [6] rootPS)) = affineNative (2^(7+1) ^^^ 7) := by decide +kernel

theorem selectedBound6165 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6166 : List Nat := [2,4,0,16,32,16,0,7,1,6,32,17,35,16,3,2,17,32,6,3,16,3,16,2,35,16,32,17,17,32,5,35,7,0,16,1]

theorem envBound6166 : H12AffineFastState.Bounded env6166 := by
  intro p hp
  have h : env6166.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6165_6166 : H12AffineEnvironment.transform 7 7 env6165 = env6166 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 7 env6165 == env6166) = true)

theorem identity6166 : scanCanonicalize (H12AffineFastState.compose env6166 (packedSelected [2,22] rootPS)) = affineNative (2^(4+1) ^^^ 3) := by decide +kernel

theorem selectedBound6166 : packedSelected [2,22] rootPS < 2^1333 := by decide +kernel

def env6167 : List Nat := [2,4,0,16,3,16,0,7,1,6,3,17,0,16,3,2,17,3,6,3,16,3,16,2,0,16,3,17,17,3,5,0,7,0,16,1]

theorem envBound6167 : H12AffineFastState.Bounded env6167 := by
  intro p hp
  have h : env6167.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6166_6167 : H12AffineEnvironment.transform 4 3 env6166 = env6167 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 3 env6166 == env6167) = true)

theorem identity6167 : scanCanonicalize (H12AffineFastState.compose env6167 (packedSelected [2] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound6167 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6168 : List Nat := [0,4,0,16,1,16,0,5,1,4,1,17,0,16,1,0,17,1,4,1,16,1,16,0,0,16,1,17,17,1,5,0,5,0,16,1]

theorem envBound6168 : H12AffineFastState.Bounded env6168 := by
  intro p hp
  have h : env6168.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6167_6168 : H12AffineEnvironment.transform 0 0 env6167 = env6168 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env6167 == env6168) = true)

def leafEnv6168 : List Nat := [0,4,0,16,1,16,0,5,1,4,1,17,0,16,1,0,17,1,4,1,16,1,16,0,5,0,1,16,1,17,17,1,5,0,5,0,4,0,16,1,0,16,1]

def active6168 : List Nat := [1,3]

def tree6168 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6168 : H12WitnessSearch.Good tree6168 := H12GlobalWitnessIndex.good

theorem leafIdentity6168 : H12AffineFastState.composeSystem env6168 rootObs = leafEnv6168 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6168 rootObs == leafEnv6168) = true)

theorem terminalChecked6168 : H12PackedTerminal.terminalCheckFast leafEnv6168 active6168 tree6168 = true := by decide +kernel

def env6169 : List Nat := [2,4,8,16,32,64,128,256,512,257,2048,4096,8192,16384,10881,65536,20496,681,524288,10881,4097,10249,16384,76677,89046,16464,11172,4176,17,88659,20564,4294967296,20817,4295522681,20497,96606]

theorem envBound6169 : H12AffineFastState.Bounded env6169 := by
  intro p hp
  have h : env6169.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6135_6169 : H12AffineEnvironment.transform 21 10249 env6135 = env6169 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10249 env6135 == env6169) = true)

theorem identity6169 : scanCanonicalize (H12AffineFastState.compose env6169 (packedSelected [11] rootPS)) = affineNative (2^(15+1) ^^^ 13118) := by decide +kernel

theorem selectedBound6169 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env6170 : List Nat := [2,4,8,16,32,64,128,256,512,257,2048,4096,8192,16384,10881,13118,20496,681,524288,10881,4097,10249,16384,6331,26856,16464,11172,4176,17,26989,20564,4294967296,20817,4295522681,20497,19040]

theorem envBound6170 : H12AffineFastState.Bounded env6170 := by
  intro p hp
  have h : env6170.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6169_6170 : H12AffineEnvironment.transform 15 13118 env6169 = env6170 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13118 env6169 == env6170) = true)

def env6171 : List Nat := [2,4,8,16,32,64,128,256,512,257,680,4096,8192,16384,8233,13118,20496,681,524288,8233,4097,8865,16384,4627,25152,16464,8460,4176,17,25541,20564,4294967296,20817,4295521233,20497,16584]

theorem envBound6171 : H12AffineFastState.Bounded env6171 := by
  intro p hp
  have h : env6171.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6170_6171 : H12AffineEnvironment.transform 10 680 env6170 = env6171 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 680 env6170 == env6171) = true)

theorem identity6171 : scanCanonicalize (H12AffineFastState.compose env6171 (packedSelected [18] rootPS)) = affineNative (2^(12+1) ^^^ 4412) := by decide +kernel

theorem selectedBound6171 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env6172 : List Nat := [2,4,8,16,32,64,128,256,512,257,680,4096,4412,16384,4373,514,20496,681,524288,4373,4097,5021,16384,4627,21372,16464,4144,4176,17,21241,20564,4294967296,20817,4295508717,20497,16584]

theorem envBound6172 : H12AffineFastState.Bounded env6172 := by
  intro p hp
  have h : env6172.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6171_6172 : H12AffineEnvironment.transform 12 4412 env6171 = env6172 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4412 env6171 == env6172) = true)

theorem identity6172 : scanCanonicalize (H12AffineFastState.compose env6172 (packedSelected [0,3,4,7,8,9,10,12] rootPS)) = affineNative (2^(18+1) ^^^ 16704) := by decide +kernel

theorem selectedBound6172 : packedSelected [0,3,4,7,8,9,10,12] rootPS < 2^1333 := by decide +kernel

def env6173 : List Nat := [2,4,8,16,32,64,128,256,512,257,680,4096,4412,16384,4373,514,20496,681,16704,4373,4097,5021,16384,4627,21372,16464,4144,4176,17,21241,20564,4294967296,20817,4294968237,20497,16584]

theorem envBound6173 : H12AffineFastState.Bounded env6173 := by
  intro p hp
  have h : env6173.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6172_6173 : H12AffineEnvironment.transform 18 16704 env6172 = env6173 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 16704 env6172 == env6173) = true)

theorem identity6173 : scanCanonicalize (H12AffineFastState.compose env6173 (packedSelected [3,5,10,15] rootPS)) = affineNative (2^(13+1) ^^^ 4825) := by decide +kernel

theorem selectedBound6173 : packedSelected [3,5,10,15] rootPS < 2^1333 := by decide +kernel

def env6174 : List Nat := [2,4,8,16,32,64,128,256,512,257,680,4096,4412,4825,4373,514,713,681,5017,4373,4097,5021,4825,4627,421,4745,4144,4176,17,32,653,4294967296,904,4294968237,712,4625]

theorem envBound6174 : H12AffineFastState.Bounded env6174 := by
  intro p hp
  have h : env6174.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6173_6174 : H12AffineEnvironment.transform 13 4825 env6173 = env6174 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4825 env6173 == env6174) = true)

theorem identity6174 : scanCanonicalize (H12AffineFastState.compose env6174 (packedSelected [0,4,5,7,8,9] rootPS)) = affineNative (2^(11+1) ^^^ 665) := by decide +kernel

theorem selectedBound6174 : packedSelected [0,4,5,7,8,9] rootPS < 2^1333 := by decide +kernel

def env6175 : List Nat := [2,4,8,16,32,64,128,256,512,257,680,665,933,64,908,514,713,681,256,908,664,260,64,138,421,16,681,713,17,32,653,4294967296,904,4294968237,712,136]

theorem envBound6175 : H12AffineFastState.Bounded env6175 := by
  intro p hp
  have h : env6175.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6174_6175 : H12AffineEnvironment.transform 11 665 env6174 = env6175 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 665 env6174 == env6175) = true)

theorem identity6175 : scanCanonicalize (H12AffineFastState.compose env6175 (packedSelected [10,13] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound6175 : packedSelected [10,13] rootPS < 2^1333 := by decide +kernel

def env6176 : List Nat := [2,4,8,16,32,64,128,37,512,36,680,665,640,64,681,514,713,681,37,681,664,33,64,138,128,16,681,713,17,32,653,4294967296,685,4294967944,712,136]

theorem envBound6176 : H12AffineFastState.Bounded env6176 := by
  intro p hp
  have h : env6176.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6175_6176 : H12AffineEnvironment.transform 7 37 env6175 = env6176 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env6175 == env6176) = true)

theorem identity6176 : scanCanonicalize (H12AffineFastState.compose env6176 (packedSelected [0,2,4] rootPS)) = affineNative (2^(31+1) ^^^ 634) := by decide +kernel

theorem selectedBound6176 : packedSelected [0,2,4] rootPS < 2^1333 := by decide +kernel

def env6177 : List Nat := [2,4,8,16,32,64,128,37,512,36,680,665,640,64,681,514,713,681,37,681,664,33,64,138,128,16,681,713,17,32,653,634,685,242,712,136]

theorem envBound6177 : H12AffineFastState.Bounded env6177 := by
  intro p hp
  have h : env6177.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6176_6177 : H12AffineEnvironment.transform 31 634 env6176 = env6177 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 634 env6176 == env6177) = true)

theorem identity6177 : scanCanonicalize (H12AffineFastState.compose env6177 (packedSelected [5,6] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound6177 : packedSelected [5,6] rootPS < 2^1333 := by decide +kernel

def env6178 : List Nat := [2,4,8,16,32,64,2,37,512,36,554,539,514,64,555,514,587,555,37,555,538,33,64,8,2,16,555,587,17,32,527,634,559,112,586,10]

theorem envBound6178 : H12AffineFastState.Bounded env6178 := by
  intro p hp
  have h : env6178.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6177_6178 : H12AffineEnvironment.transform 6 2 env6177 = env6178 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env6177 == env6178) = true)

theorem identity6178 : scanCanonicalize (H12AffineFastState.compose env6178 (packedSelected [1,2,5] rootPS)) = affineNative (2^(5+1) ^^^ 48) := by decide +kernel

theorem selectedBound6178 : packedSelected [1,2,5] rootPS < 2^1333 := by decide +kernel

def env6179 : List Nat := [2,4,8,16,32,48,2,37,512,36,554,539,514,48,555,514,571,555,37,555,538,33,48,8,2,16,555,571,17,32,527,522,559,0,570,10]

theorem envBound6179 : H12AffineFastState.Bounded env6179 := by
  intro p hp
  have h : env6179.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6178_6179 : H12AffineEnvironment.transform 5 48 env6178 = env6179 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 48 env6178 == env6179) = true)

theorem identity6179 : scanCanonicalize (H12AffineFastState.compose env6179 (packedSelected [1,2,3] rootPS)) = affineNative (2^(8+1) ^^^ 33) := by decide +kernel

theorem selectedBound6179 : packedSelected [1,2,3] rootPS < 2^1333 := by decide +kernel

def env6180 : List Nat := [2,4,8,16,32,48,2,37,33,36,11,58,35,48,10,35,26,10,37,10,59,33,48,8,2,16,10,26,17,32,46,43,14,0,27,10]

theorem envBound6180 : H12AffineFastState.Bounded env6180 := by
  intro p hp
  have h : env6180.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6179_6180 : H12AffineEnvironment.transform 8 33 env6179 = env6180 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 33 env6179 == env6180) = true)

theorem identity6180 : scanCanonicalize (H12AffineFastState.compose env6180 (packedSelected [0,1,7] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound6180 : packedSelected [0,1,7] rootPS < 2^1333 := by decide +kernel

def env6181 : List Nat := [2,4,8,16,11,27,2,14,10,15,11,17,8,27,10,8,26,10,14,10,16,10,27,8,2,16,10,26,17,11,5,0,14,0,27,10]

theorem envBound6181 : H12AffineFastState.Bounded env6181 := by
  intro p hp
  have h : env6181.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6180_6181 : H12AffineEnvironment.transform 4 11 env6180 = env6181 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env6180 == env6181) = true)

theorem identity6181 : scanCanonicalize (H12AffineFastState.compose env6181 (packedSelected [0] rootPS)) = affineNative (2^(2+1) ^^^ 1) := by decide +kernel

theorem selectedBound6181 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6182 : List Nat := [2,4,1,16,2,18,2,7,3,6,2,17,1,18,3,1,19,3,7,3,16,3,18,1,2,16,3,19,17,2,5,0,7,0,18,3]

theorem envBound6182 : H12AffineFastState.Bounded env6182 := by
  intro p hp
  have h : env6182.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6181_6182 : H12AffineEnvironment.transform 2 1 env6181 = env6182 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env6181 == env6182) = true)

theorem identity6182 : scanCanonicalize (H12AffineFastState.compose env6182 (packedSelected [1] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound6182 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6183 : List Nat := [1,4,1,16,1,17,1,4,0,5,1,17,1,17,0,1,16,0,4,0,16,0,17,1,1,16,0,16,17,1,5,0,4,0,17,0]

theorem envBound6183 : H12AffineFastState.Bounded env6183 := by
  intro p hp
  have h : env6183.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6182_6183 : H12AffineEnvironment.transform 0 1 env6182 = env6183 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env6182 == env6183) = true)

def env6184 : List Nat := [2,4,8,16,32,64,128,256,512,257,681,4096,8192,16384,8232,13118,20496,681,524288,8232,4097,8864,16384,4626,25153,16464,8461,4176,17,25540,20564,4294967296,20817,4295521232,20497,16585]

theorem envBound6184 : H12AffineFastState.Bounded env6184 := by
  intro p hp
  have h : env6184.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6170_6184 : H12AffineEnvironment.transform 10 681 env6170 = env6184 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 681 env6170 == env6184) = true)

theorem identity6184 : scanCanonicalize (H12AffineFastState.compose env6184 (packedSelected [18] rootPS)) = affineNative (2^(11+1) ^^^ 664) := by decide +kernel

theorem selectedBound6184 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env6185 : List Nat := [2,4,8,16,32,64,128,256,512,257,681,664,8192,16384,8232,8614,17032,681,524288,8232,665,8864,16384,138,25153,16464,8461,712,17,25540,17100,4294967296,17353,4295516488,17033,16585]

theorem envBound6185 : H12AffineFastState.Bounded env6185 := by
  intro p hp
  have h : env6185.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6184_6185 : H12AffineEnvironment.transform 11 664 env6184 = env6185 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 664 env6184 == env6185) = true)

theorem identity6185 : scanCanonicalize (H12AffineFastState.compose env6185 (packedSelected [0,3,4,5,7,9,10,12] rootPS)) = affineNative (2^(13+1) ^^^ 712) := by decide +kernel

theorem selectedBound6185 : packedSelected [0,3,4,5,7,9,10,12] rootPS < 2^1333 := by decide +kernel

def env6186 : List Nat := [2,4,8,16,32,64,128,256,512,257,681,664,8192,712,8232,8614,64,681,524288,8232,665,8864,712,138,8329,664,8461,712,17,8460,4,4294967296,257,4295500672,65,513]

theorem envBound6186 : H12AffineFastState.Bounded env6186 := by
  intro p hp
  have h : env6186.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6185_6186 : H12AffineEnvironment.transform 13 712 env6185 = env6186 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 712 env6185 == env6186) = true)

theorem identity6186 : scanCanonicalize (H12AffineFastState.compose env6186 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound6186 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env6187 : List Nat := [2,4,8,16,32,64,128,256,137,257,32,17,8192,65,8232,8614,64,32,524288,8232,16,8233,65,138,8329,17,8461,65,17,8460,4,4294967296,257,4295500041,65,136]

theorem envBound6187 : H12AffineFastState.Bounded env6187 := by
  intro p hp
  have h : env6187.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6186_6187 : H12AffineEnvironment.transform 8 137 env6186 = env6187 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6186 == env6187) = true)

theorem identity6187 : scanCanonicalize (H12AffineFastState.compose env6187 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound6187 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env6188 : List Nat := [2,4,8,16,32,64,128,4,137,5,32,17,8192,65,8232,8354,64,32,524288,8232,16,8233,65,138,8329,17,8201,65,17,8200,4,4294967296,5,4295499789,65,136]

theorem envBound6188 : H12AffineFastState.Bounded env6188 := by
  intro p hp
  have h : env6188.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6187_6188 : H12AffineEnvironment.transform 7 4 env6187 = env6188 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env6187 == env6188) = true)

theorem identity6188 : scanCanonicalize (H12AffineFastState.compose env6188 (packedSelected [1,3,5,10,13] rootPS)) = affineNative (2^(12+1) ^^^ 40) := by decide +kernel

theorem selectedBound6188 : packedSelected [1,3,5,10,13] rootPS < 2^1333 := by decide +kernel

def env6189 : List Nat := [2,4,8,16,32,64,128,4,137,5,32,17,40,65,0,138,64,32,524288,0,16,1,65,138,161,17,33,65,17,32,4,4294967296,5,4295491621,65,136]

theorem envBound6189 : H12AffineFastState.Bounded env6189 := by
  intro p hp
  have h : env6189.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6188_6189 : H12AffineEnvironment.transform 12 40 env6188 = env6189 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 40 env6188 == env6189) = true)

def env6190 : List Nat := [2,4,8,16,0,64,128,4,137,5,0,17,8,65,0,138,64,0,524288,0,16,1,65,138,129,17,1,65,17,0,4,4294967296,5,4295491589,65,136]

theorem envBound6190 : H12AffineFastState.Bounded env6190 := by
  intro p hp
  have h : env6190.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6189_6190 : H12AffineEnvironment.transform 4 0 env6189 = env6190 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env6189 == env6190) = true)

theorem identity6190 : scanCanonicalize (H12AffineFastState.compose env6190 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 211) := by decide +kernel

theorem selectedBound6190 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6191 : List Nat := [2,4,8,16,0,64,128,4,137,5,0,17,8,65,0,138,64,0,524288,0,16,1,65,138,129,17,1,65,17,0,4,211,5,524502,65,136]

theorem envBound6191 : H12AffineFastState.Bounded env6191 := by
  intro p hp
  have h : env6191.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6190_6191 : H12AffineEnvironment.transform 31 211 env6190 = env6191 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 211 env6190 == env6191) = true)

theorem identity6191 : scanCanonicalize (H12AffineFastState.compose env6191 (packedSelected [2,3] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound6191 : packedSelected [2,3] rootPS < 2^1333 := by decide +kernel

def env6192 : List Nat := [2,4,2,16,0,64,128,4,131,5,0,17,2,65,0,128,64,0,524288,0,16,1,65,128,129,17,1,65,17,0,4,211,5,524502,65,130]

theorem envBound6192 : H12AffineFastState.Bounded env6192 := by
  intro p hp
  have h : env6192.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6191_6192 : H12AffineEnvironment.transform 2 2 env6191 = env6192 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env6191 == env6192) = true)

theorem identity6192 : scanCanonicalize (H12AffineFastState.compose env6192 (packedSelected [1] rootPS)) = affineNative (2^(18+1) ^^^ 85) := by decide +kernel

theorem selectedBound6192 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6193 : List Nat := [2,4,2,16,0,64,128,4,131,5,0,17,2,65,0,128,64,0,85,0,16,1,65,128,129,17,1,65,17,0,4,211,5,131,65,130]

theorem envBound6193 : H12AffineFastState.Bounded env6193 := by
  intro p hp
  have h : env6193.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6192_6193 : H12AffineEnvironment.transform 18 85 env6192 = env6193 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 85 env6192 == env6193) = true)

theorem identity6193 : scanCanonicalize (H12AffineFastState.compose env6193 (packedSelected [2,5] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound6193 : packedSelected [2,5] rootPS < 2^1333 := by decide +kernel

def env6194 : List Nat := [2,4,2,16,0,16,128,4,131,5,0,17,2,17,0,128,16,0,5,0,16,1,17,128,129,17,1,17,17,0,4,131,5,131,17,130]

theorem envBound6194 : H12AffineFastState.Bounded env6194 := by
  intro p hp
  have h : env6194.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6193_6194 : H12AffineEnvironment.transform 5 16 env6193 = env6194 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env6193 == env6194) = true)

def leafEnv6194 : List Nat := [2,4,2,16,0,16,128,4,131,5,0,17,2,17,0,128,16,0,5,0,16,1,17,128,5,129,1,17,1,17,17,0,4,131,5,131,4,3,17,130,0,17,1]

def active6194 : List Nat := [0,1,3,6]

def tree6194 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6194 : H12WitnessSearch.Good tree6194 := H12GlobalWitnessIndex.good

theorem leafIdentity6194 : H12AffineFastState.composeSystem env6194 rootObs = leafEnv6194 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6194 rootObs == leafEnv6194) = true)

theorem terminalChecked6194 : H12PackedTerminal.terminalCheckFast leafEnv6194 active6194 tree6194 = true := by decide +kernel

def env6195 : List Nat := [2,4,8,16,1,64,128,4,137,5,1,17,9,65,0,138,64,1,524288,0,16,1,65,138,128,17,0,65,17,1,4,4294967296,5,4295491588,65,136]

theorem envBound6195 : H12AffineFastState.Bounded env6195 := by
  intro p hp
  have h : env6195.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6189_6195 : H12AffineEnvironment.transform 4 1 env6189 = env6195 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env6189 == env6195) = true)

theorem identity6195 : scanCanonicalize (H12AffineFastState.compose env6195 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 90) := by decide +kernel

theorem selectedBound6195 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6196 : List Nat := [2,4,8,16,1,64,128,4,137,5,1,17,9,65,0,138,64,1,524288,0,16,1,65,138,128,17,0,65,17,1,4,90,5,524382,65,136]

theorem envBound6196 : H12AffineFastState.Bounded env6196 := by
  intro p hp
  have h : env6196.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6195_6196 : H12AffineEnvironment.transform 31 90 env6195 = env6196 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 90 env6195 == env6196) = true)

theorem identity6196 : scanCanonicalize (H12AffineFastState.compose env6196 (packedSelected [1,2] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound6196 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env6197 : List Nat := [2,4,8,16,1,64,2,4,11,5,1,17,9,65,0,8,64,1,524288,0,16,1,65,8,2,17,0,65,17,1,4,90,5,524382,65,10]

theorem envBound6197 : H12AffineFastState.Bounded env6197 := by
  intro p hp
  have h : env6197.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6196_6197 : H12AffineEnvironment.transform 6 2 env6196 = env6197 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env6196 == env6197) = true)

theorem identity6197 : scanCanonicalize (H12AffineFastState.compose env6197 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound6197 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6198 : List Nat := [2,4,3,16,1,64,2,4,0,5,1,17,2,65,0,3,64,1,524288,0,16,1,65,3,2,17,0,65,17,1,4,81,5,524373,65,1]

theorem envBound6198 : H12AffineFastState.Bounded env6198 := by
  intro p hp
  have h : env6198.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6197_6198 : H12AffineEnvironment.transform 2 3 env6197 = env6198 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env6197 == env6198) = true)

def leafEnv6198 : List Nat := [2,4,3,16,1,64,2,4,0,5,1,17,2,65,0,3,64,1,524288,0,16,1,65,3,524288,2,1,17,0,65,17,1,4,81,5,524373,4,3,65,1,0,17,1]

def active6198 : List Nat := [0,1,3,5,18]

def tree6198 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6198 : H12WitnessSearch.Good tree6198 := H12GlobalWitnessIndex.good

theorem leafIdentity6198 : H12AffineFastState.composeSystem env6198 rootObs = leafEnv6198 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6198 rootObs == leafEnv6198) = true)

theorem terminalChecked6198 : H12PackedTerminal.terminalCheckFast leafEnv6198 active6198 tree6198 = true := by decide +kernel

def env6199 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,134217728,67130625,157794305,1073741824,140788817,4294967296,157663569,4417151347,131072,33563272]

theorem envBound6199 : H12AffineFastState.Bounded env6199 := by
  intro p hp
  have h : env6199.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5901_6199 : H12AffineEnvironment.transform 28 157794305 env5901 = env6199 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 28 157794305 env5901 == env6199) = true)

theorem identity6199 : scanCanonicalize (H12AffineFastState.compose env6199 (packedSelected [14] rootPS)) = affineNative (2^(26+1) ^^^ 73684052) := by decide +kernel

theorem selectedBound6199 : packedSelected [14] rootPS < 2^1333 := by decide +kernel

def env6200 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,73684052,67130625,84120661,1073741824,67112965,4294967296,83989765,4417151347,131072,33563272]

theorem envBound6200 : H12AffineFastState.Bounded env6200 := by
  intro p hp
  have h : env6200.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6199_6200 : H12AffineEnvironment.transform 26 73684052 env6199 = env6200 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 73684052 env6199 == env6200) = true)

def env6201 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,135232,6702100,148801,16876565,1073741824,131141,4294967296,17007941,4350177587,131072,33563272]

theorem envBound6201 : H12AffineFastState.Bounded env6201 := by
  intro p hp
  have h : env6201.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6200_6201 : H12AffineEnvironment.transform 25 135232 env6200 = env6201 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 135232 env6200 == env6201) = true)

theorem identity6201 : scanCanonicalize (H12AffineFastState.compose env6201 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 2109576) := by decide +kernel

theorem selectedBound6201 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env6202 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,2109576,135232,6702100,148801,16876565,1073741824,131141,4294967296,17007941,4318708155,131072,2101760]

theorem envBound6202 : H12AffineFastState.Bounded env6202 := by
  intro p hp
  have h : env6202.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6201_6202 : H12AffineEnvironment.transform 24 2109576 env6201 = env6202 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 2109576 env6201 == env6202) = true)

theorem identity6202 : scanCanonicalize (H12AffineFastState.compose env6202 (packedSelected [3,10,24,26,35] rootPS)) = affineNative (2^(23+1) ^^^ 2199813) := by decide +kernel

theorem selectedBound6202 : packedSelected [3,10,24,26,35] rootPS < 2^1333 := by decide +kernel

def env6203 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,2199813,2109576,135232,6702100,148801,2102544,1073741824,131141,4294967296,2233408,4299935934,131072,2101760]

theorem envBound6203 : H12AffineFastState.Bounded env6203 := by
  intro p hp
  have h : env6203.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6202_6203 : H12AffineEnvironment.transform 23 2199813 env6202 = env6203 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 2199813 env6202 == env6203) = true)

def env6204 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17665,98565,8328,135232,4609044,148801,1296,1073741824,131141,4294967296,132160,4299935934,131072,512]

theorem envBound6204 : H12AffineFastState.Bounded env6204 := by
  intro p hp
  have h : env6204.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6203_6204 : H12AffineEnvironment.transform 20 4096 env6203 = env6204 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env6203 == env6204) = true)

theorem identity6204 : scanCanonicalize (H12AffineFastState.compose env6204 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(29+1) ^^^ 4267215) := by decide +kernel

theorem selectedBound6204 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env6205 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17665,98565,8328,135232,4609044,148801,1296,4267215,131141,4294967296,132160,4299935934,131072,512]

theorem envBound6205 : H12AffineFastState.Bounded env6205 := by
  intro p hp
  have h : env6205.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6204_6205 : H12AffineEnvironment.transform 29 4267215 env6204 = env6205 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4267215 env6204 == env6205) = true)

theorem identity6205 : scanCanonicalize (H12AffineFastState.compose env6205 (packedSelected [4,16,22] rootPS)) = affineNative (2^(21+1) ^^^ 25748) := by decide +kernel

theorem selectedBound6205 : packedSelected [4,16,22] rootPS < 2^1333 := by decide +kernel

def env6206 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,25748,17665,98565,8328,135232,405632,148801,1296,96347,131141,4294967296,132160,4295734314,131072,512]

theorem envBound6206 : H12AffineFastState.Bounded env6206 := by
  intro p hp
  have h : env6206.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6205_6206 : H12AffineEnvironment.transform 21 25748 env6205 = env6206 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 25748 env6205 == env6206) = true)

theorem identity6206 : scanCanonicalize (H12AffineFastState.compose env6206 (packedSelected [5,15,17,24] rootPS)) = affineNative (2^(31+1) ^^^ 387511) := by decide +kernel

theorem selectedBound6206 : packedSelected [5,15,17,24] rootPS < 2^1333 := by decide +kernel

def env6207 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,25748,17665,98565,8328,135232,405632,148801,1296,96347,131141,387511,132160,941469,131072,512]

theorem envBound6207 : H12AffineFastState.Bounded env6207 := by
  intro p hp
  have h : env6207.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6206_6207 : H12AffineEnvironment.transform 31 387511 env6206 = env6207 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 387511 env6206 == env6207) = true)

theorem identity6207 : scanCanonicalize (H12AffineFastState.compose env6207 (packedSelected [4,6,9,16,25] rootPS)) = affineNative (2^(18+1) ^^^ 12616) := by decide +kernel

theorem selectedBound6207 : packedSelected [4,6,9,16,25] rootPS < 2^1333 := by decide +kernel

def env6208 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,12616,32768,4096,25748,17665,98565,8328,135232,405632,148801,1296,96347,131141,387511,132160,421077,131072,512]

theorem envBound6208 : H12AffineFastState.Bounded env6208 := by
  intro p hp
  have h : env6208.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6207_6208 : H12AffineEnvironment.transform 18 12616 env6207 = env6208 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 12616 env6207 == env6208) = true)

theorem identity6208 : scanCanonicalize (H12AffineFastState.compose env6208 (packedSelected [3,5,10,15,17,26] rootPS)) = affineNative (2^(16+1) ^^^ 1344) := by decide +kernel

theorem selectedBound6208 : packedSelected [3,5,10,15,17,26] rootPS < 2^1333 := by decide +kernel

def env6209 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,12616,32768,4096,25748,17665,98565,8328,5376,275904,16385,1296,96347,1285,387511,256,289173,1344,512]

theorem envBound6209 : H12AffineFastState.Bounded env6209 := by
  intro p hp
  have h : env6209.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6208_6209 : H12AffineEnvironment.transform 16 1344 env6208 = env6209 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env6208 == env6209) = true)

theorem identity6209 : scanCanonicalize (H12AffineFastState.compose env6209 (packedSelected [0,27] rootPS)) = affineNative (2^(14+1) ^^^ 17428) := by decide +kernel

theorem selectedBound6209 : packedSelected [0,27] rootPS < 2^1333 := by decide +kernel

def env6210 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,17428,65536,1344,262144,12616,17428,4096,25748,17665,83217,8328,5376,275904,16385,1296,96347,1285,339363,256,289173,1344,512]

theorem envBound6210 : H12AffineFastState.Bounded env6210 := by
  intro p hp
  have h : env6210.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6209_6210 : H12AffineEnvironment.transform 14 17428 env6209 = env6210 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 17428 env6209 == env6210) = true)

theorem identity6210 : scanCanonicalize (H12AffineFastState.compose env6210 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 28882) := by decide +kernel

theorem selectedBound6210 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env6211 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,17428,28882,1344,262144,12616,17428,4096,25748,17665,13763,8328,5376,275904,16385,1296,2185,1285,286065,256,289173,1344,512]

theorem envBound6211 : H12AffineFastState.Bounded env6211 := by
  intro p hp
  have h : env6211.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6210_6211 : H12AffineEnvironment.transform 15 28882 env6210 = env6211 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 28882 env6210 == env6211) = true)

theorem identity6211 : scanCanonicalize (H12AffineFastState.compose env6211 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(12+1) ^^^ 5449) := by decide +kernel

theorem selectedBound6211 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env6212 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,5449,16384,17428,17819,1344,262144,1025,17428,4096,20957,17665,138,5569,5376,262281,16385,1296,2185,1285,286065,256,285916,1344,512]

theorem envBound6212 : H12AffineFastState.Bounded env6212 := by
  intro p hp
  have h : env6212.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6211_6212 : H12AffineEnvironment.transform 12 5449 env6211 = env6212 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5449 env6211 == env6212) = true)

theorem identity6212 : scanCanonicalize (H12AffineFastState.compose env6212 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(17+1) ^^^ 2340) := by decide +kernel

theorem selectedBound6212 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env6213 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,5449,16384,17428,17819,1344,2340,1025,17428,4096,20957,17665,138,5569,5376,2477,16385,1296,2185,1285,21589,256,22008,1344,512]

theorem envBound6213 : H12AffineFastState.Bounded env6213 := by
  intro p hp
  have h : env6213.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6212_6213 : H12AffineEnvironment.transform 17 2340 env6212 = env6213 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2340 env6212 == env6213) = true)

theorem identity6213 : scanCanonicalize (H12AffineFastState.compose env6213 (packedSelected [3,5,10] rootPS)) = affineNative (2^(11+1) ^^^ 1993) := by decide +kernel

theorem selectedBound6213 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env6214 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1993,640,16384,17428,17819,1344,2340,1025,17428,1993,17940,17665,138,520,713,2477,16385,1296,2185,1285,17308,256,16945,1344,512]

theorem envBound6214 : H12AffineFastState.Bounded env6214 := by
  intro p hp
  have h : env6214.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6213_6214 : H12AffineEnvironment.transform 11 1993 env6213 = env6214 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1993 env6213 == env6214) = true)

theorem identity6214 : scanCanonicalize (H12AffineFastState.compose env6214 (packedSelected [5,6,8] rootPS)) = affineNative (2^(13+1) ^^^ 185) := by decide +kernel

theorem selectedBound6214 : packedSelected [5,6,8] rootPS < 2^1333 := by decide +kernel

def env6215 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1993,640,185,1197,1314,1344,2340,1025,1197,1993,1709,1464,138,520,713,2477,184,1296,2185,1285,805,256,648,1344,512]

theorem envBound6215 : H12AffineFastState.Bounded env6215 := by
  intro p hp
  have h : env6215.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6214_6215 : H12AffineEnvironment.transform 13 185 env6214 = env6215 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 185 env6214 == env6215) = true)

theorem identity6215 : scanCanonicalize (H12AffineFastState.compose env6215 (packedSelected [0,2,4,6,11] rootPS)) = affineNative (2^(10+1) ^^^ 1015) := by decide +kernel

theorem selectedBound6215 : packedSelected [0,2,4,6,11] rootPS < 2^1333 := by decide +kernel

def env6216 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1015,1993,640,185,1197,1314,1344,723,1025,1197,1993,1709,1464,138,520,713,602,184,1296,894,1285,805,256,648,1344,512]

theorem envBound6216 : H12AffineFastState.Bounded env6216 := by
  intro p hp
  have h : env6216.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6215_6216 : H12AffineEnvironment.transform 10 1015 env6215 = env6216 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1015 env6215 == env6216) = true)

theorem identity6216 : scanCanonicalize (H12AffineFastState.compose env6216 (packedSelected [3,5,12,13] rootPS)) = affineNative (2^(9+1) ^^^ 801) := by decide +kernel

theorem selectedBound6216 : packedSelected [3,5,12,13] rootPS < 2^1333 := by decide +kernel

def env6217 : List Nat := [2,4,8,16,32,64,128,256,512,801,1015,232,640,185,908,515,609,723,800,908,232,396,665,138,520,713,602,184,561,894,548,805,256,648,609,512]

theorem envBound6217 : H12AffineFastState.Bounded env6217 := by
  intro p hp
  have h : env6217.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6216_6217 : H12AffineEnvironment.transform 9 801 env6216 = env6217 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 801 env6216 == env6217) = true)

theorem identity6217 : scanCanonicalize (H12AffineFastState.compose env6217 (packedSelected [1,3,5] rootPS)) = affineNative (2^(8+1) ^^^ 261) := by decide +kernel

theorem selectedBound6217 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env6218 : List Nat := [2,4,8,16,32,64,128,256,261,36,242,232,389,185,137,262,356,470,37,137,232,396,412,138,269,460,351,184,308,123,289,32,256,397,356,261]

theorem envBound6218 : H12AffineFastState.Bounded env6218 := by
  intro p hp
  have h : env6218.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6217_6218 : H12AffineEnvironment.transform 8 261 env6217 = env6218 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 261 env6217 == env6218) = true)

def env6219 : List Nat := [2,4,8,16,32,64,8,256,261,36,122,96,269,49,1,262,356,350,37,1,96,260,276,2,269,324,351,48,308,123,289,32,256,261,356,261]

theorem envBound6219 : H12AffineFastState.Bounded env6219 := by
  intro p hp
  have h : env6219.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6218_6219 : H12AffineEnvironment.transform 6 8 env6218 = env6219 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env6218 == env6219) = true)

theorem identity6219 : scanCanonicalize (H12AffineFastState.compose env6219 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 18) := by decide +kernel

theorem selectedBound6219 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6220 : List Nat := [2,4,8,16,18,64,8,256,261,22,72,82,269,3,1,262,342,350,23,1,82,260,276,2,269,324,351,2,262,73,275,18,256,261,342,261]

theorem envBound6220 : H12AffineFastState.Bounded env6220 := by
  intro p hp
  have h : env6220.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6219_6220 : H12AffineEnvironment.transform 4 18 env6219 = env6220 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 18 env6219 == env6220) = true)

theorem identity6220 : scanCanonicalize (H12AffineFastState.compose env6220 (packedSelected [1,3] rootPS)) = affineNative (2^(7+1) ^^^ 84) := by decide +kernel

theorem selectedBound6220 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env6221 : List Nat := [2,4,8,16,18,64,8,84,81,22,72,82,89,3,1,82,2,10,23,1,82,80,64,2,89,16,11,2,82,73,71,18,84,81,2,81]

theorem envBound6221 : H12AffineFastState.Bounded env6221 := by
  intro p hp
  have h : env6221.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6220_6221 : H12AffineEnvironment.transform 7 84 env6220 = env6221 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 84 env6220 == env6221) = true)

theorem identity6221 : scanCanonicalize (H12AffineFastState.compose env6221 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 2) := by decide +kernel

theorem selectedBound6221 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6222 : List Nat := [2,4,8,16,18,2,8,22,19,22,10,16,27,3,1,16,2,10,23,1,16,18,2,2,27,16,11,2,16,11,5,18,22,19,2,19]

theorem envBound6222 : H12AffineFastState.Bounded env6222 := by
  intro p hp
  have h : env6222.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6221_6222 : H12AffineEnvironment.transform 5 2 env6221 = env6222 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 2 env6221 == env6222) = true)

def env6223 : List Nat := [2,4,8,16,32,64,9,256,261,36,123,97,268,48,0,262,356,351,37,0,97,261,277,3,269,325,351,49,308,123,289,32,256,260,356,261]

theorem envBound6223 : H12AffineFastState.Bounded env6223 := by
  intro p hp
  have h : env6223.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6218_6223 : H12AffineEnvironment.transform 6 9 env6218 = env6223 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env6218 == env6223) = true)

theorem identity6223 : scanCanonicalize (H12AffineFastState.compose env6223 (packedSelected [0] rootPS)) = affineNative (2^(5+1) ^^^ 8) := by decide +kernel

theorem selectedBound6223 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6224 : List Nat := [2,4,8,16,32,8,9,256,261,36,51,41,268,48,0,262,300,279,37,0,41,261,277,3,269,269,279,49,308,51,289,32,256,260,300,261]

theorem envBound6224 : H12AffineFastState.Bounded env6224 := by
  intro p hp
  have h : env6224.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6223_6224 : H12AffineEnvironment.transform 5 8 env6223 = env6224 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 8 env6223 == env6224) = true)

def env6225 : List Nat := [2,4,8,16,32,8,9,28,25,36,51,41,16,48,0,26,48,11,37,0,41,25,9,3,17,17,11,49,40,51,61,32,28,24,48,25]

theorem envBound6225 : H12AffineFastState.Bounded env6225 := by
  intro p hp
  have h : env6225.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6224_6225 : H12AffineEnvironment.transform 7 28 env6224 = env6225 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 28 env6224 == env6225) = true)

theorem identity6225 : scanCanonicalize (H12AffineFastState.compose env6225 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 19) := by decide +kernel

theorem selectedBound6225 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6226 : List Nat := [2,4,8,16,19,8,9,28,25,23,0,26,16,3,0,26,3,11,22,0,26,25,9,3,17,17,11,2,27,0,14,19,28,24,3,25]

theorem envBound6226 : H12AffineFastState.Bounded env6226 := by
  intro p hp
  have h : env6226.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6225_6226 : H12AffineEnvironment.transform 4 19 env6225 = env6226 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 19 env6225 == env6226) = true)

theorem identity6226 : scanCanonicalize (H12AffineFastState.compose env6226 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound6226 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6227 : List Nat := [2,4,8,3,0,8,9,15,10,4,0,9,3,3,0,9,3,11,5,0,9,10,9,3,2,2,11,2,8,0,14,0,15,11,3,10]

theorem envBound6227 : H12AffineFastState.Bounded env6227 := by
  intro p hp
  have h : env6227.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6226_6227 : H12AffineEnvironment.transform 3 3 env6226 = env6227 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env6226 == env6227) = true)

theorem identity6227 : scanCanonicalize (H12AffineFastState.compose env6227 (packedSelected [4] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound6227 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env6228 : List Nat := [2,4,2,3,0,2,3,5,0,4,0,3,3,3,0,3,3,1,5,0,3,0,3,3,2,2,1,2,2,0,4,0,5,1,3,0]

theorem envBound6228 : H12AffineFastState.Bounded env6228 := by
  intro p hp
  have h : env6228.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6227_6228 : H12AffineEnvironment.transform 2 2 env6227 = env6228 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env6227 == env6228) = true)

def leafEnv6228 : List Nat := [2,4,2,3,0,2,3,5,0,4,0,3,3,3,0,3,3,1,5,0,3,0,3,3,5,2,1,2,1,2,2,0,4,0,5,1,4,2,3,0,0,3,1]

def active6228 : List Nat := [0,1]

def tree6228 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6228 : H12WitnessSearch.Good tree6228 := H12GlobalWitnessIndex.good

theorem leafIdentity6228 : H12AffineFastState.composeSystem env6228 rootObs = leafEnv6228 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6228 rootObs == leafEnv6228) = true)

theorem terminalChecked6228 : H12PackedTerminal.terminalCheckFast leafEnv6228 active6228 tree6228 = true := by decide +kernel

def env6229 : List Nat := [2,4,8,16,32,8,9,29,24,36,51,41,17,48,0,27,49,10,37,0,41,24,8,3,16,16,10,49,41,51,60,32,29,25,49,24]

theorem envBound6229 : H12AffineFastState.Bounded env6229 := by
  intro p hp
  have h : env6229.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6224_6229 : H12AffineEnvironment.transform 7 29 env6224 = env6229 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 29 env6224 == env6229) = true)

theorem identity6229 : scanCanonicalize (H12AffineFastState.compose env6229 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 24) := by decide +kernel

theorem selectedBound6229 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6230 : List Nat := [2,4,8,16,24,8,9,29,24,28,11,17,17,8,0,27,9,10,29,0,17,24,8,3,16,16,10,9,17,11,4,24,29,25,9,24]

theorem envBound6230 : H12AffineFastState.Bounded env6230 := by
  intro p hp
  have h : env6230.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6229_6230 : H12AffineEnvironment.transform 4 24 env6229 = env6230 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 24 env6229 == env6230) = true)

def env6231 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,4194304,17665,98564,8329,135232,4609045,148801,1297,1073741824,131141,4294967296,132161,4299935934,131072,513]

theorem envBound6231 : H12AffineFastState.Bounded env6231 := by
  intro p hp
  have h : env6231.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6203_6231 : H12AffineEnvironment.transform 20 4097 env6203 = env6231 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env6203 == env6231) = true)

theorem identity6231 : scanCanonicalize (H12AffineFastState.compose env6231 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(16+1) ^^^ 22424) := by decide +kernel

theorem selectedBound6231 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env6232 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,22424,262144,524288,32768,4097,4194304,17665,98564,8329,18392,4457357,4825,1297,1073741824,22493,4294967296,21465,4299786022,22424,513]

theorem envBound6232 : H12AffineFastState.Bounded env6232 := by
  intro p hp
  have h : env6232.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6231_6232 : H12AffineEnvironment.transform 16 22424 env6231 = env6232 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 22424 env6231 == env6232) = true)

theorem identity6232 : scanCanonicalize (H12AffineFastState.compose env6232 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(29+1) ^^^ 4497709) := by decide +kernel

theorem selectedBound6232 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env6233 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,22424,262144,524288,32768,4097,4194304,17665,98564,8329,18392,4457357,4825,1297,4497709,22493,4294967296,21465,4299786022,22424,513]

theorem envBound6233 : H12AffineFastState.Bounded env6233 := by
  intro p hp
  have h : env6233.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6232_6233 : H12AffineEnvironment.transform 29 4497709 env6232 = env6233 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4497709 env6232 == env6233) = true)

theorem identity6233 : scanCanonicalize (H12AffineFastState.compose env6233 (packedSelected [1,3,5,12,13,24] rootPS)) = affineNative (2^(17+1) ^^^ 43681) := by decide +kernel

theorem selectedBound6233 : packedSelected [1,3,5,12,13,24] rootPS < 2^1333 := by decide +kernel

def env6234 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,22424,43681,524288,32768,4097,4194304,17665,98564,8329,18392,4237612,4825,1297,4197260,22493,4294967296,21465,4299786022,22424,513]

theorem envBound6234 : H12AffineFastState.Bounded env6234 := by
  intro p hp
  have h : env6234.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6233_6234 : H12AffineEnvironment.transform 17 43681 env6233 = env6234 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43681 env6233 == env6234) = true)

def env6235 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,22424,43681,524288,32768,4097,10248,17665,98564,8329,18392,33060,4825,1297,9092,22493,4294967296,21465,4295601966,22424,513]

theorem envBound6235 : H12AffineFastState.Bounded env6235 := by
  intro p hp
  have h : env6235.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6234_6235 : H12AffineEnvironment.transform 21 10248 env6234 = env6235 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10248 env6234 == env6235) = true)

theorem identity6235 : scanCanonicalize (H12AffineFastState.compose env6235 (packedSelected [2,6,7,9] rootPS)) = affineNative (2^(12+1) ^^^ 7196) := by decide +kernel

theorem selectedBound6235 : packedSelected [2,6,7,9] rootPS < 2^1333 := by decide +kernel

def env6236 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,7196,16384,32768,65536,22424,38589,524288,32768,4097,5140,17665,98564,7317,18392,33060,4825,1297,8088,22493,4294967296,21465,4295594802,22424,513]

theorem envBound6236 : H12AffineFastState.Bounded env6236 := by
  intro p hp
  have h : env6236.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6235_6236 : H12AffineEnvironment.transform 12 7196 env6235 = env6236 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 7196 env6235 == env6236) = true)

def env6237 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,2948,16384,32768,65536,16384,33061,524288,32768,1945,908,17665,98564,2829,18392,33060,1345,1297,2048,16453,4294967296,17473,4295591082,16384,513]

theorem envBound6237 : H12AffineFastState.Bounded env6237 := by
  intro p hp
  have h : env6237.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6236_6237 : H12AffineEnvironment.transform 11 1944 env6236 = env6237 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env6236 == env6237) = true)

theorem identity6237 : scanCanonicalize (H12AffineFastState.compose env6237 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(14+1) ^^^ 20205) := by decide +kernel

theorem selectedBound6237 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env6238 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,2948,16384,20205,65536,16384,20424,524288,20205,1945,908,17665,85993,2829,18392,20425,1345,1297,2048,16453,4294967296,17473,4295576135,16384,513]

theorem envBound6238 : H12AffineFastState.Bounded env6238 := by
  intro p hp
  have h : env6238.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6237_6238 : H12AffineEnvironment.transform 14 20205 env6237 = env6238 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 20205 env6237 == env6238) = true)

theorem identity6238 : scanCanonicalize (H12AffineFastState.compose env6238 (packedSelected [1,3,10,12,13] rootPS)) = affineNative (2^(18+1) ^^^ 1672) := by decide +kernel

theorem selectedBound6238 : packedSelected [1,3,10,12,13] rootPS < 2^1333 := by decide +kernel

def env6239 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,2948,16384,20205,65536,16384,20424,1672,20205,1945,908,17665,85993,2829,18392,20425,1345,1297,2048,16453,4294967296,17473,4295052495,16384,513]

theorem envBound6239 : H12AffineFastState.Bounded env6239 := by
  intro p hp
  have h : env6239.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6238_6239 : H12AffineEnvironment.transform 18 1672 env6238 = env6239 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1672 env6238 == env6239) = true)

theorem identity6239 : scanCanonicalize (H12AffineFastState.compose env6239 (packedSelected [0,1,2,4,5,6,10] rootPS)) = affineNative (2^(15+1) ^^^ 2447) := by decide +kernel

theorem selectedBound6239 : packedSelected [0,1,2,4,5,6,10] rootPS < 2^1333 := by decide +kernel

def env6240 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,2948,16384,20205,2447,16384,20424,1672,20205,1945,908,17665,18022,2829,18392,20425,1345,1297,2048,16453,4294967296,17473,4294985024,16384,513]

theorem envBound6240 : H12AffineFastState.Bounded env6240 := by
  intro p hp
  have h : env6240.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6239_6240 : H12AffineEnvironment.transform 15 2447 env6239 = env6240 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2447 env6239 == env6240) = true)

theorem identity6240 : scanCanonicalize (H12AffineFastState.compose env6240 (packedSelected [0,1,2,3,4,5,6,8,12] rootPS)) = affineNative (2^(13+1) ^^^ 1993) := by decide +kernel

theorem selectedBound6240 : packedSelected [0,1,2,3,4,5,6,8,12] rootPS < 2^1333 := by decide +kernel

def env6241 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,2948,1993,2340,2447,1993,2049,1672,2340,1945,908,712,431,2829,17,2048,1345,1297,2048,1932,4294967296,904,4294967945,1993,513]

theorem envBound6241 : H12AffineFastState.Bounded env6241 := by
  intro p hp
  have h : env6241.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6240_6241 : H12AffineEnvironment.transform 13 1993 env6240 = env6241 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1993 env6240 == env6241) = true)

theorem identity6241 : scanCanonicalize (H12AffineFastState.compose env6241 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound6241 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env6242 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,1725,2721,1772,2049,2218,1772,2049,1672,2049,1724,681,712,138,2600,17,2048,1124,1076,2048,1705,4294967296,685,4294967945,1772,513]

theorem envBound6242 : H12AffineFastState.Bounded env6242 := by
  intro p hp
  have h : env6242.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6241_6242 : H12AffineEnvironment.transform 7 37 env6241 = env6242 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env6241 == env6242) = true)

theorem identity6242 : scanCanonicalize (H12AffineFastState.compose env6242 (packedSelected [2,4] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound6242 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env6243 : List Nat := [2,4,8,16,1,64,128,4,512,1024,2048,1692,2688,1741,2049,2187,1741,2049,1672,2049,1693,648,712,138,2569,17,2048,1093,1045,2048,1672,4294967296,652,4294967945,1741,513]

theorem envBound6243 : H12AffineFastState.Bounded env6243 := by
  intro p hp
  have h : env6243.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6242_6243 : H12AffineEnvironment.transform 4 1 env6242 = env6243 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env6242 == env6243) = true)

def env6244 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,2949,16384,32768,65536,16385,33060,524288,32768,1944,909,17665,98564,2828,18392,33060,1344,1297,2049,16452,4294967296,17472,4295591083,16385,513]

theorem envBound6244 : H12AffineFastState.Bounded env6244 := by
  intro p hp
  have h : env6244.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6236_6244 : H12AffineEnvironment.transform 11 1945 env6236 = env6244 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1945 env6236 == env6244) = true)

theorem identity6244 : scanCanonicalize (H12AffineFastState.compose env6244 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(13+1) ^^^ 1992) := by decide +kernel

theorem selectedBound6244 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env6245 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,2949,1992,32768,65536,1993,33060,524288,32768,1944,909,713,98564,2828,16,33060,1344,1297,2049,1932,4294967296,904,4295591083,1993,513]

theorem envBound6245 : H12AffineFastState.Bounded env6245 := by
  intro p hp
  have h : env6245.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6244_6245 : H12AffineEnvironment.transform 13 1992 env6244 = env6245 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1992 env6244 == env6245) = true)

def env6246 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,2949,1992,32768,65536,1993,33060,1024,32768,1944,909,713,98564,2828,16,33060,1344,1297,2049,1932,4294967296,904,4295065771,1993,513]

theorem envBound6246 : H12AffineFastState.Bounded env6246 := by
  intro p hp
  have h : env6246.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6245_6246 : H12AffineEnvironment.transform 18 1024 env6245 = env6246 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env6245 == env6246) = true)

theorem identity6246 : scanCanonicalize (H12AffineFastState.compose env6246 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 33166) := by decide +kernel

theorem selectedBound6246 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env6247 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,2949,1992,32768,33166,1993,33060,1024,32768,1944,909,713,138,2828,16,33060,1344,1297,2049,1932,4294967296,904,4294967589,1993,513]

theorem envBound6247 : H12AffineFastState.Bounded env6247 := by
  intro p hp
  have h : env6247.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6246_6247 : H12AffineEnvironment.transform 15 33166 env6246 = env6247 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33166 env6246 == env6247) = true)

theorem identity6247 : scanCanonicalize (H12AffineFastState.compose env6247 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound6247 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env6248 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1693,2689,1740,32768,32906,1741,32800,1024,32768,1692,649,713,138,2568,16,32800,1092,1045,2049,1672,4294967296,652,4294967329,1741,513]

theorem envBound6248 : H12AffineFastState.Bounded env6248 := by
  intro p hp
  have h : env6248.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6247_6248 : H12AffineEnvironment.transform 7 4 env6247 = env6248 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env6247 == env6248) = true)

theorem identity6248 : scanCanonicalize (H12AffineFastState.compose env6248 (packedSelected [3,10] rootPS)) = affineNative (2^(14+1) ^^^ 2080) := by decide +kernel

theorem selectedBound6248 : packedSelected [3,10] rootPS < 2^1333 := by decide +kernel

def env6249 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1693,2689,1740,2080,2218,1741,2048,1024,2080,1692,649,713,138,2568,16,2048,1092,1045,2049,1672,4294967296,652,4294967329,1741,513]

theorem envBound6249 : H12AffineFastState.Bounded env6249 := by
  intro p hp
  have h : env6249.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6248_6249 : H12AffineEnvironment.transform 14 2080 env6248 = env6249 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2080 env6248 == env6249) = true)

def env6250 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1693,2689,1740,2080,2218,1741,2048,1024,2080,1692,649,713,138,2568,16,2048,1092,1045,2049,1672,32,652,1,1741,513]

theorem envBound6250 : H12AffineFastState.Bounded env6250 := by
  intro p hp
  have h : env6250.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6249_6250 : H12AffineEnvironment.transform 31 32 env6249 = env6250 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 32 env6249 == env6250) = true)

theorem identity6250 : scanCanonicalize (H12AffineFastState.compose env6250 (packedSelected [5] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound6250 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env6251 : List Nat := [2,4,8,16,32,64,88,4,512,1024,2048,1605,2649,1556,2080,2162,1557,2048,1024,2080,1604,593,529,82,2568,16,2048,1092,1045,2049,1616,32,596,1,1557,513]

theorem envBound6251 : H12AffineFastState.Bounded env6251 := by
  intro p hp
  have h : env6251.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6250_6251 : H12AffineEnvironment.transform 6 88 env6250 = env6251 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env6250 == env6251) = true)

def env6252 : List Nat := [2,4,8,16,32,64,88,4,96,1024,2048,1061,2105,1140,2080,2162,1141,2048,1024,2080,1060,49,113,82,2152,16,2048,1092,1045,2049,1072,32,52,1,1141,97]

theorem envBound6252 : H12AffineFastState.Bounded env6252 := by
  intro p hp
  have h : env6252.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6251_6252 : H12AffineEnvironment.transform 8 96 env6251 = env6252 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 96 env6251 == env6252) = true)

theorem identity6252 : scanCanonicalize (H12AffineFastState.compose env6252 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound6252 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6253 : List Nat := [2,4,8,0,32,64,72,4,96,1024,2048,1061,2089,1124,2080,2146,1125,2048,1024,2080,1060,33,97,66,2152,0,2048,1092,1029,2049,1056,32,36,1,1125,97]

theorem envBound6253 : H12AffineFastState.Bounded env6253 := by
  intro p hp
  have h : env6253.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6252_6253 : H12AffineEnvironment.transform 3 0 env6252 = env6253 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env6252 == env6253) = true)

theorem identity6253 : scanCanonicalize (H12AffineFastState.compose env6253 (packedSelected [1,3] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound6253 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env6254 : List Nat := [2,4,8,0,1,64,72,4,65,1024,2048,1028,2056,1093,2049,2115,1092,2048,1024,2049,1029,0,64,66,2121,0,2048,1092,1029,2049,1025,1,5,1,1092,64]

theorem envBound6254 : H12AffineFastState.Bounded env6254 := by
  intro p hp
  have h : env6254.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6253_6254 : H12AffineEnvironment.transform 4 1 env6253 = env6254 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env6253 == env6254) = true)

theorem identity6254 : scanCanonicalize (H12AffineFastState.compose env6254 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 1102) := by decide +kernel

theorem selectedBound6254 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6255 : List Nat := [2,4,8,0,1,64,72,4,65,1024,1102,1028,1094,1093,1103,1037,1092,1102,1024,1103,1029,0,64,66,1031,0,1102,1092,1029,1103,1025,1,5,1,1092,64]

theorem envBound6255 : H12AffineFastState.Bounded env6255 := by
  intro p hp
  have h : env6255.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6254_6255 : H12AffineEnvironment.transform 10 1102 env6254 = env6255 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1102 env6254 == env6255) = true)

def leafEnv6255 : List Nat := [2,4,8,0,1,64,72,4,65,1024,1102,1028,1094,1093,1103,1037,1092,1102,1024,1103,1029,0,64,66,1024,1031,1,0,1102,1092,1029,1103,1025,1,5,1,4,1100,1092,64,0,1029,1]

def active6255 : List Nat := [0,1,2,5,9]

def tree6255 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6255 : H12WitnessSearch.Good tree6255 := H12GlobalWitnessIndex.good

theorem leafIdentity6255 : H12AffineFastState.composeSystem env6255 rootObs = leafEnv6255 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6255 rootObs == leafEnv6255) = true)

theorem terminalChecked6255 : H12PackedTerminal.terminalCheckFast leafEnv6255 active6255 tree6255 = true := by decide +kernel

def env6256 : List Nat := [2,4,8,16,32,64,88,4,97,1024,2048,1060,2104,1141,2080,2162,1140,2048,1024,2080,1061,48,112,82,2153,16,2048,1092,1045,2049,1073,32,53,1,1140,96]

theorem envBound6256 : H12AffineFastState.Bounded env6256 := by
  intro p hp
  have h : env6256.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6251_6256 : H12AffineEnvironment.transform 8 97 env6251 = env6256 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 97 env6251 == env6256) = true)

theorem identity6256 : scanCanonicalize (H12AffineFastState.compose env6256 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound6256 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6257 : List Nat := [2,4,8,16,1,64,88,4,64,1024,2048,1029,2073,1108,2049,2131,1109,2048,1024,2049,1028,17,81,82,2120,16,2048,1092,1045,2049,1040,1,20,1,1109,65]

theorem envBound6257 : H12AffineFastState.Bounded env6257 := by
  intro p hp
  have h : env6257.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6256_6257 : H12AffineEnvironment.transform 4 1 env6256 = env6257 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env6256 == env6257) = true)

def env6258 : List Nat := [2,4,8,0,1,64,72,4,64,1024,2048,1029,2057,1092,2049,2115,1093,2048,1024,2049,1028,1,65,66,2120,0,2048,1092,1029,2049,1024,1,4,1,1093,65]

theorem envBound6258 : H12AffineFastState.Bounded env6258 := by
  intro p hp
  have h : env6258.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6257_6258 : H12AffineEnvironment.transform 3 0 env6257 = env6258 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env6257 == env6258) = true)

theorem identity6258 : scanCanonicalize (H12AffineFastState.compose env6258 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 74) := by decide +kernel

theorem selectedBound6258 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6259 : List Nat := [2,4,8,0,1,64,72,4,64,1024,74,1029,67,1092,75,9,1093,74,1024,75,1028,1,65,66,2,0,74,1092,1029,75,1024,1,4,1,1093,65]

theorem envBound6259 : H12AffineFastState.Bounded env6259 := by
  intro p hp
  have h : env6259.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6258_6259 : H12AffineEnvironment.transform 10 74 env6258 = env6259 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 74 env6258 == env6259) = true)

theorem identity6259 : scanCanonicalize (H12AffineFastState.compose env6259 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound6259 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6260 : List Nat := [2,4,8,0,1,11,3,4,11,1024,1,1029,8,1039,0,9,1038,1,1024,0,1028,1,10,9,2,0,1,1039,1029,0,1024,1,4,1,1038,10]

theorem envBound6260 : H12AffineFastState.Bounded env6260 := by
  intro p hp
  have h : env6260.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6259_6260 : H12AffineEnvironment.transform 5 11 env6259 = env6260 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env6259 == env6260) = true)

def leafEnv6260 : List Nat := [2,4,8,0,1,11,3,4,11,1024,1,1029,8,1039,0,9,1038,1,1024,0,1028,1,10,9,1024,2,1,0,1,1039,1029,0,1024,1,4,1,4,3,1038,10,0,1028,1]

def active6260 : List Nat := [0,1,2,9]

def tree6260 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6260 : H12WitnessSearch.Good tree6260 := H12GlobalWitnessIndex.good

theorem leafIdentity6260 : H12AffineFastState.composeSystem env6260 rootObs = leafEnv6260 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6260 rootObs == leafEnv6260) = true)

theorem terminalChecked6260 : H12PackedTerminal.terminalCheckFast leafEnv6260 active6260 tree6260 = true := by decide +kernel

def env6261 : List Nat := [2,4,8,1,1,64,73,4,64,1024,2048,1029,2056,1093,2049,2114,1092,2048,1024,2049,1028,0,64,67,2120,1,2048,1092,1028,2049,1025,1,5,1,1092,65]

theorem envBound6261 : H12AffineFastState.Bounded env6261 := by
  intro p hp
  have h : env6261.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6257_6261 : H12AffineEnvironment.transform 3 1 env6257 = env6261 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env6257 == env6261) = true)

theorem identity6261 : scanCanonicalize (H12AffineFastState.compose env6261 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 1103) := by decide +kernel

theorem selectedBound6261 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6262 : List Nat := [2,4,8,1,1,64,73,4,64,1024,1103,1029,1095,1093,1102,1037,1092,1103,1024,1102,1028,0,64,67,1031,1,1103,1092,1028,1102,1025,1,5,1,1092,65]

theorem envBound6262 : H12AffineFastState.Bounded env6262 := by
  intro p hp
  have h : env6262.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6261_6262 : H12AffineEnvironment.transform 10 1103 env6261 = env6262 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1103 env6261 == env6262) = true)

def leafEnv6262 : List Nat := [2,4,8,1,1,64,73,4,64,1024,1103,1029,1095,1093,1102,1037,1092,1103,1024,1102,1028,0,64,67,1024,1031,1,1,1103,1092,1028,1102,1025,1,5,1,4,1101,1092,65,0,1028,1]

def active6262 : List Nat := [0,1,2,5,9]

def tree6262 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6262 : H12WitnessSearch.Good tree6262 := H12GlobalWitnessIndex.good

theorem leafIdentity6262 : H12AffineFastState.composeSystem env6262 rootObs = leafEnv6262 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6262 rootObs == leafEnv6262) = true)

theorem terminalChecked6262 : H12PackedTerminal.terminalCheckFast leafEnv6262 active6262 tree6262 = true := by decide +kernel

def env6263 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1693,2689,1740,2080,2218,1741,2048,1024,2080,1692,649,713,138,2568,16,2048,1092,1045,2049,1672,33,652,0,1741,513]

theorem envBound6263 : H12AffineFastState.Bounded env6263 := by
  intro p hp
  have h : env6263.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6249_6263 : H12AffineEnvironment.transform 31 33 env6249 = env6263 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 33 env6249 == env6263) = true)

theorem identity6263 : scanCanonicalize (H12AffineFastState.compose env6263 (packedSelected [5] rootPS)) = affineNative (2^(8+1) ^^^ 80) := by decide +kernel

theorem selectedBound6263 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env6264 : List Nat := [2,4,8,16,32,64,128,4,80,1024,2048,1229,2257,1180,2080,2218,1181,2048,1024,2080,1228,217,153,138,2136,16,2048,1092,1045,2049,1240,33,220,0,1181,81]

theorem envBound6264 : H12AffineFastState.Bounded env6264 := by
  intro p hp
  have h : env6264.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6263_6264 : H12AffineEnvironment.transform 8 80 env6263 = env6264 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 80 env6263 == env6264) = true)

def env6265 : List Nat := [2,4,8,16,16,64,128,4,80,1024,2048,1229,2257,1180,2064,2202,1181,2048,1024,2064,1228,217,153,138,2136,16,2048,1092,1045,2049,1240,17,220,0,1181,81]

theorem envBound6265 : H12AffineFastState.Bounded env6265 := by
  intro p hp
  have h : env6265.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6264_6265 : H12AffineEnvironment.transform 4 16 env6264 = env6265 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env6264 == env6265) = true)

def env6266 : List Nat := [2,4,8,16,16,64,88,4,80,1024,2048,1045,2057,1092,2064,2114,1093,2048,1024,2064,1044,1,65,82,2136,16,2048,1092,1045,2049,1024,17,4,0,1093,81]

theorem envBound6266 : H12AffineFastState.Bounded env6266 := by
  intro p hp
  have h : env6266.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6265_6266 : H12AffineEnvironment.transform 6 88 env6265 = env6266 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env6265 == env6266) = true)

theorem identity6266 : scanCanonicalize (H12AffineFastState.compose env6266 (packedSelected [0,1] rootPS)) = affineNative (2^(5+1) ^^^ 26) := by decide +kernel

theorem selectedBound6266 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env6267 : List Nat := [2,4,8,16,16,26,2,4,10,1024,2048,1045,2057,1054,2064,2072,1055,2048,1024,2064,1044,1,27,8,2050,16,2048,1054,1045,2049,1024,17,4,0,1055,11]

theorem envBound6267 : H12AffineFastState.Bounded env6267 := by
  intro p hp
  have h : env6267.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6266_6267 : H12AffineEnvironment.transform 5 26 env6266 = env6267 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 26 env6266 == env6267) = true)

theorem identity6267 : scanCanonicalize (H12AffineFastState.compose env6267 (packedSelected [0,3] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound6267 : packedSelected [0,3] rootPS < 2^1333 := by decide +kernel

def env6268 : List Nat := [2,4,8,1,1,11,2,4,10,1024,2048,1028,2057,1039,2049,2057,1038,2048,1024,2049,1029,1,10,8,2050,1,2048,1039,1028,2049,1024,0,4,0,1038,11]

theorem envBound6268 : H12AffineFastState.Bounded env6268 := by
  intro p hp
  have h : env6268.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6267_6268 : H12AffineEnvironment.transform 3 1 env6267 = env6268 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env6267 == env6268) = true)

theorem identity6268 : scanCanonicalize (H12AffineFastState.compose env6268 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 1) := by decide +kernel

theorem selectedBound6268 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6269 : List Nat := [2,4,8,1,1,11,2,4,10,1024,1,1028,8,1039,0,8,1038,1,1024,0,1029,1,10,8,3,1,1,1039,1028,0,1024,0,4,0,1038,11]

theorem envBound6269 : H12AffineFastState.Bounded env6269 := by
  intro p hp
  have h : env6269.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6268_6269 : H12AffineEnvironment.transform 10 1 env6268 = env6269 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env6268 == env6269) = true)

def leafEnv6269 : List Nat := [2,4,8,1,1,11,2,4,10,1024,1,1028,8,1039,0,8,1038,1,1024,0,1029,1,10,8,1024,3,1,1,1,1039,1028,0,1024,0,4,0,4,3,1038,11,0,1029,1]

def active6269 : List Nat := [0,1,2,9]

def tree6269 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6269 : H12WitnessSearch.Good tree6269 := H12GlobalWitnessIndex.good

theorem leafIdentity6269 : H12AffineFastState.composeSystem env6269 rootObs = leafEnv6269 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6269 rootObs == leafEnv6269) = true)

theorem terminalChecked6269 : H12PackedTerminal.terminalCheckFast leafEnv6269 active6269 tree6269 = true := by decide +kernel

def env6270 : List Nat := [2,4,8,16,16,64,89,4,80,1024,2048,1044,2056,1093,2064,2115,1092,2048,1024,2064,1045,0,64,83,2136,16,2048,1092,1045,2049,1025,17,5,0,1092,81]

theorem envBound6270 : H12AffineFastState.Bounded env6270 := by
  intro p hp
  have h : env6270.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6265_6270 : H12AffineEnvironment.transform 6 89 env6265 = env6270 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env6265 == env6270) = true)

def env6271 : List Nat := [2,4,8,16,16,0,25,4,16,1024,2048,1044,2056,1029,2064,2051,1028,2048,1024,2064,1045,0,0,19,2072,16,2048,1028,1045,2049,1025,17,5,0,1028,17]

theorem envBound6271 : H12AffineFastState.Bounded env6271 := by
  intro p hp
  have h : env6271.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6270_6271 : H12AffineEnvironment.transform 5 0 env6270 = env6271 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env6270 == env6271) = true)

theorem identity6271 : scanCanonicalize (H12AffineFastState.compose env6271 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 1038) := by decide +kernel

theorem selectedBound6271 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6272 : List Nat := [2,4,8,16,16,0,25,4,16,1024,1038,1044,1030,1029,1054,1037,1028,1038,1024,1054,1045,0,0,19,1046,16,1038,1028,1045,1039,1025,17,5,0,1028,17]

theorem envBound6272 : H12AffineFastState.Bounded env6272 := by
  intro p hp
  have h : env6272.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6271_6272 : H12AffineEnvironment.transform 10 1038 env6271 = env6272 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1038 env6271 == env6272) = true)

def leafEnv6272 : List Nat := [2,4,8,16,16,0,25,4,16,1024,1038,1044,1030,1029,1054,1037,1028,1038,1024,1054,1045,0,0,19,1024,1046,1,16,1038,1028,1045,1039,1025,17,5,0,4,1053,1028,17,0,1045,1]

def active6272 : List Nat := [0,1,2,3,9]

def tree6272 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6272 : H12WitnessSearch.Good tree6272 := H12GlobalWitnessIndex.good

theorem leafIdentity6272 : H12AffineFastState.composeSystem env6272 rootObs = leafEnv6272 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6272 rootObs == leafEnv6272) = true)

theorem terminalChecked6272 : H12PackedTerminal.terminalCheckFast leafEnv6272 active6272 tree6272 = true := by decide +kernel

def env6273 : List Nat := [2,4,8,16,16,1,24,4,17,1024,2048,1044,2056,1028,2064,2050,1029,2048,1024,2064,1045,0,1,18,2073,16,2048,1029,1045,2049,1025,17,5,0,1029,16]

theorem envBound6273 : H12AffineFastState.Bounded env6273 := by
  intro p hp
  have h : env6273.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6270_6273 : H12AffineEnvironment.transform 5 1 env6270 = env6273 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 1 env6270 == env6273) = true)

theorem identity6273 : scanCanonicalize (H12AffineFastState.compose env6273 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 1054) := by decide +kernel

theorem selectedBound6273 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6274 : List Nat := [2,4,8,16,16,1,24,4,17,1024,1054,1044,1046,1028,1038,1052,1029,1054,1024,1038,1045,0,1,18,1031,16,1054,1029,1045,1055,1025,17,5,0,1029,16]

theorem envBound6274 : H12AffineFastState.Bounded env6274 := by
  intro p hp
  have h : env6274.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6273_6274 : H12AffineEnvironment.transform 10 1054 env6273 = env6274 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1054 env6273 == env6274) = true)

def leafEnv6274 : List Nat := [2,4,8,16,16,1,24,4,17,1024,1054,1044,1046,1028,1038,1052,1029,1054,1024,1038,1045,0,1,18,1024,1031,1,16,1054,1029,1045,1055,1025,17,5,0,4,1037,1029,16,0,1045,1]

def active6274 : List Nat := [0,1,2,3,9]

def tree6274 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6274 : H12WitnessSearch.Good tree6274 := H12GlobalWitnessIndex.good

theorem leafIdentity6274 : H12AffineFastState.composeSystem env6274 rootObs = leafEnv6274 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6274 rootObs == leafEnv6274) = true)

theorem terminalChecked6274 : H12PackedTerminal.terminalCheckFast leafEnv6274 active6274 tree6274 = true := by decide +kernel

def env6275 : List Nat := [2,4,8,16,17,64,128,4,80,1024,2048,1229,2257,1180,2065,2203,1181,2048,1024,2065,1228,217,153,138,2136,16,2048,1092,1045,2049,1240,16,220,0,1181,81]

theorem envBound6275 : H12AffineFastState.Bounded env6275 := by
  intro p hp
  have h : env6275.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6264_6275 : H12AffineEnvironment.transform 4 17 env6264 = env6275 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env6264 == env6275) = true)

theorem identity6275 : scanCanonicalize (H12AffineFastState.compose env6275 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 89) := by decide +kernel

theorem selectedBound6275 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6276 : List Nat := [2,4,8,16,17,64,89,4,80,1024,2048,1044,2056,1093,2065,2114,1092,2048,1024,2065,1045,0,64,83,2136,16,2048,1092,1045,2049,1025,16,5,0,1092,81]

theorem envBound6276 : H12AffineFastState.Bounded env6276 := by
  intro p hp
  have h : env6276.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6275_6276 : H12AffineEnvironment.transform 6 89 env6275 = env6276 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env6275 == env6276) = true)

def env6277 : List Nat := [2,4,8,16,17,0,25,4,16,1024,2048,1044,2056,1029,2065,2050,1028,2048,1024,2065,1045,0,0,19,2072,16,2048,1028,1045,2049,1025,16,5,0,1028,17]

theorem envBound6277 : H12AffineFastState.Bounded env6277 := by
  intro p hp
  have h : env6277.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6276_6277 : H12AffineEnvironment.transform 5 0 env6276 = env6277 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env6276 == env6277) = true)

theorem identity6277 : scanCanonicalize (H12AffineFastState.compose env6277 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 1055) := by decide +kernel

theorem selectedBound6277 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6278 : List Nat := [2,4,8,16,17,0,25,4,16,1024,1055,1044,1047,1029,1038,1053,1028,1055,1024,1038,1045,0,0,19,1031,16,1055,1028,1045,1054,1025,16,5,0,1028,17]

theorem envBound6278 : H12AffineFastState.Bounded env6278 := by
  intro p hp
  have h : env6278.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6277_6278 : H12AffineEnvironment.transform 10 1055 env6277 = env6278 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1055 env6277 == env6278) = true)

def leafEnv6278 : List Nat := [2,4,8,16,17,0,25,4,16,1024,1055,1044,1047,1029,1038,1053,1028,1055,1024,1038,1045,0,0,19,1024,1031,1,16,1055,1028,1045,1054,1025,16,5,0,4,1037,1028,17,0,1045,1]

def active6278 : List Nat := [0,1,2,3,9]

def tree6278 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6278 : H12WitnessSearch.Good tree6278 := H12GlobalWitnessIndex.good

theorem leafIdentity6278 : H12AffineFastState.composeSystem env6278 rootObs = leafEnv6278 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6278 rootObs == leafEnv6278) = true)

theorem terminalChecked6278 : H12PackedTerminal.terminalCheckFast leafEnv6278 active6278 tree6278 = true := by decide +kernel

def env6279 : List Nat := [2,4,8,16,17,1,24,4,17,1024,2048,1044,2056,1028,2065,2051,1029,2048,1024,2065,1045,0,1,18,2073,16,2048,1029,1045,2049,1025,16,5,0,1029,16]

theorem envBound6279 : H12AffineFastState.Bounded env6279 := by
  intro p hp
  have h : env6279.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6276_6279 : H12AffineEnvironment.transform 5 1 env6276 = env6279 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 1 env6276 == env6279) = true)

theorem identity6279 : scanCanonicalize (H12AffineFastState.compose env6279 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 1038) := by decide +kernel

theorem selectedBound6279 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6280 : List Nat := [2,4,8,16,17,1,24,4,17,1024,1038,1044,1030,1028,1055,1037,1029,1038,1024,1055,1045,0,1,18,1047,16,1038,1029,1045,1039,1025,16,5,0,1029,16]

theorem envBound6280 : H12AffineFastState.Bounded env6280 := by
  intro p hp
  have h : env6280.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6279_6280 : H12AffineEnvironment.transform 10 1038 env6279 = env6280 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1038 env6279 == env6280) = true)

def leafEnv6280 : List Nat := [2,4,8,16,17,1,24,4,17,1024,1038,1044,1030,1028,1055,1037,1029,1038,1024,1055,1045,0,1,18,1024,1047,1,16,1038,1029,1045,1039,1025,16,5,0,4,1052,1029,16,0,1045,1]

def active6280 : List Nat := [0,1,2,3,9]

def tree6280 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6280 : H12WitnessSearch.Good tree6280 := H12GlobalWitnessIndex.good

theorem leafIdentity6280 : H12AffineFastState.composeSystem env6280 rootObs = leafEnv6280 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6280 rootObs == leafEnv6280) = true)

theorem terminalChecked6280 : H12PackedTerminal.terminalCheckFast leafEnv6280 active6280 tree6280 = true := by decide +kernel

def env6281 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,2949,1992,32768,65536,1993,33060,1025,32768,1944,909,713,98564,2828,16,33060,1344,1297,2049,1932,4294967296,904,4295065770,1993,513]

theorem envBound6281 : H12AffineFastState.Bounded env6281 := by
  intro p hp
  have h : env6281.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6245_6281 : H12AffineEnvironment.transform 18 1025 env6245 = env6281 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env6245 == env6281) = true)

theorem identity6281 : scanCanonicalize (H12AffineFastState.compose env6281 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 33543) := by decide +kernel

theorem selectedBound6281 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env6282 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,2949,1992,32768,33543,1993,33060,1025,32768,1944,909,713,515,2828,16,33060,1344,1297,2049,1932,4294967296,904,4294968237,1993,513]

theorem envBound6282 : H12AffineFastState.Bounded env6282 := by
  intro p hp
  have h : env6282.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6281_6282 : H12AffineEnvironment.transform 15 33543 env6281 = env6282 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33543 env6281 == env6282) = true)

theorem identity6282 : scanCanonicalize (H12AffineFastState.compose env6282 (packedSelected [3,10] rootPS)) = affineNative (2^(14+1) ^^^ 2340) := by decide +kernel

theorem selectedBound6282 : packedSelected [3,10] rootPS < 2^1333 := by decide +kernel

def env6283 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,2949,1992,2340,2595,1993,2048,1025,2340,1944,909,713,515,2828,16,2048,1344,1297,2049,1932,4294967296,904,4294968237,1993,513]

theorem envBound6283 : H12AffineFastState.Bounded env6283 := by
  intro p hp
  have h : env6283.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6282_6283 : H12AffineEnvironment.transform 14 2340 env6282 = env6283 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2340 env6282 == env6283) = true)

def env6284 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,2949,1992,2340,2595,1993,2048,1025,2340,1944,909,713,515,2828,16,2048,1344,1297,2049,1932,112,904,989,1993,513]

theorem envBound6284 : H12AffineFastState.Bounded env6284 := by
  intro p hp
  have h : env6284.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6283_6284 : H12AffineEnvironment.transform 31 112 env6283 = env6284 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 112 env6283 == env6284) = true)

theorem identity6284 : scanCanonicalize (H12AffineFastState.compose env6284 (packedSelected [5] rootPS)) = affineNative (2^(8+1) ^^^ 429) := by decide +kernel

theorem selectedBound6284 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env6285 : List Nat := [2,4,8,16,32,64,128,256,429,1024,2048,1076,2088,1125,2340,2446,1124,2048,1025,2340,1077,32,356,430,2209,16,2048,1344,1297,2049,1057,112,37,112,1124,428]

theorem envBound6285 : H12AffineFastState.Bounded env6285 := by
  intro p hp
  have h : env6285.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6284_6285 : H12AffineEnvironment.transform 8 429 env6284 = env6285 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 429 env6284 == env6285) = true)

theorem identity6285 : scanCanonicalize (H12AffineFastState.compose env6285 (packedSelected [1,3] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound6285 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env6286 : List Nat := [2,4,8,16,32,64,128,37,136,1024,2048,1076,2088,1125,2049,2219,1124,2048,1025,2049,1077,32,65,139,2209,16,2048,1125,1076,2049,1057,112,37,112,1124,137]

theorem envBound6286 : H12AffineFastState.Bounded env6286 := by
  intro p hp
  have h : env6286.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6285_6286 : H12AffineEnvironment.transform 7 37 env6285 = env6286 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env6285 == env6286) = true)

theorem identity6286 : scanCanonicalize (H12AffineFastState.compose env6286 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 82) := by decide +kernel

theorem selectedBound6286 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6287 : List Nat := [2,4,8,16,32,64,82,37,90,1024,2048,1076,2088,1125,2049,2169,1124,2048,1025,2049,1077,32,65,89,2163,16,2048,1125,1076,2049,1057,112,37,112,1124,91]

theorem envBound6287 : H12AffineFastState.Bounded env6287 := by
  intro p hp
  have h : env6287.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6286_6287 : H12AffineEnvironment.transform 6 82 env6286 = env6287 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 82 env6286 == env6287) = true)

theorem identity6287 : scanCanonicalize (H12AffineFastState.compose env6287 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 0) := by decide +kernel

theorem selectedBound6287 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6288 : List Nat := [2,4,8,16,32,0,18,37,26,1024,2048,1076,2088,1061,2049,2105,1060,2048,1025,2049,1077,32,1,25,2099,16,2048,1061,1076,2049,1057,48,37,48,1060,27]

theorem envBound6288 : H12AffineFastState.Bounded env6288 := by
  intro p hp
  have h : env6288.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6287_6288 : H12AffineEnvironment.transform 5 0 env6287 = env6288 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env6287 == env6288) = true)

def leafEnv6288 : List Nat := [2,4,8,16,32,0,18,37,26,1024,2048,1076,2088,1061,2049,2105,1060,2048,1025,2049,1077,32,1,25,1056,2099,1,16,2048,1061,1076,2049,1057,48,37,48,4,2083,1060,27,0,1077,1]

def active6288 : List Nat := [0,1,2,3,4,9,10]

def tree6288 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6288 : H12WitnessSearch.Good tree6288 := H12GlobalWitnessIndex.good

theorem leafIdentity6288 : H12AffineFastState.composeSystem env6288 rootObs = leafEnv6288 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6288 rootObs == leafEnv6288) = true)

theorem terminalChecked6288 : H12PackedTerminal.terminalCheckFast leafEnv6288 active6288 tree6288 = true := by decide +kernel

def env6289 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,2949,1992,2340,2595,1993,2048,1025,2340,1944,909,713,515,2828,16,2048,1344,1297,2049,1932,113,904,988,1993,513]

theorem envBound6289 : H12AffineFastState.Bounded env6289 := by
  intro p hp
  have h : env6289.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6283_6289 : H12AffineEnvironment.transform 31 113 env6283 = env6289 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 113 env6283 == env6289) = true)

theorem identity6289 : scanCanonicalize (H12AffineFastState.compose env6289 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound6289 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env6290 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,1724,2720,1773,2049,2595,1772,2048,1025,2049,1725,680,713,515,2601,16,2048,1125,1076,2049,1705,113,685,761,1772,513]

theorem envBound6290 : H12AffineFastState.Bounded env6290 := by
  intro p hp
  have h : env6290.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6289_6290 : H12AffineEnvironment.transform 7 37 env6289 = env6290 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env6289 == env6290) = true)

def env6291 : List Nat := [2,4,8,16,32,64,128,37,136,1024,2048,1076,2088,1125,2049,2219,1124,2048,1025,2049,1077,32,65,139,2209,16,2048,1125,1076,2049,1057,113,37,113,1124,137]

theorem envBound6291 : H12AffineFastState.Bounded env6291 := by
  intro p hp
  have h : env6291.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6290_6291 : H12AffineEnvironment.transform 8 136 env6290 = env6291 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env6290 == env6291) = true)

theorem identity6291 : scanCanonicalize (H12AffineFastState.compose env6291 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 83) := by decide +kernel

theorem selectedBound6291 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6292 : List Nat := [2,4,8,16,32,64,83,37,91,1024,2048,1076,2088,1125,2049,2168,1124,2048,1025,2049,1077,32,65,88,2162,16,2048,1125,1076,2049,1057,113,37,113,1124,90]

theorem envBound6292 : H12AffineFastState.Bounded env6292 := by
  intro p hp
  have h : env6292.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6291_6292 : H12AffineEnvironment.transform 6 83 env6291 = env6292 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 83 env6291 == env6292) = true)

theorem identity6292 : scanCanonicalize (H12AffineFastState.compose env6292 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 1) := by decide +kernel

theorem selectedBound6292 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6293 : List Nat := [2,4,8,16,32,1,18,37,26,1024,2048,1076,2088,1060,2049,2105,1061,2048,1025,2049,1077,32,0,25,2099,16,2048,1060,1076,2049,1057,48,37,48,1061,27]

theorem envBound6293 : H12AffineFastState.Bounded env6293 := by
  intro p hp
  have h : env6293.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6292_6293 : H12AffineEnvironment.transform 5 1 env6292 = env6293 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 1 env6292 == env6293) = true)

def leafEnv6293 : List Nat := [2,4,8,16,32,1,18,37,26,1024,2048,1076,2088,1060,2049,2105,1061,2048,1025,2049,1077,32,0,25,1056,2099,1,16,2048,1060,1076,2049,1057,48,37,48,4,2083,1061,27,0,1077,1]

def active6293 : List Nat := [0,1,2,3,4,9,10]

def tree6293 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6293 : H12WitnessSearch.Good tree6293 := H12GlobalWitnessIndex.good

theorem leafIdentity6293 : H12AffineFastState.composeSystem env6293 rootObs = leafEnv6293 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6293 rootObs == leafEnv6293) = true)

theorem terminalChecked6293 : H12PackedTerminal.terminalCheckFast leafEnv6293 active6293 tree6293 = true := by decide +kernel

def env6294 : List Nat := [2,4,8,16,32,64,128,37,137,1024,2048,1077,2089,1124,2049,2218,1125,2048,1025,2049,1076,33,64,138,2208,16,2048,1125,1076,2049,1056,113,36,112,1125,136]

theorem envBound6294 : H12AffineFastState.Bounded env6294 := by
  intro p hp
  have h : env6294.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6290_6294 : H12AffineEnvironment.transform 8 137 env6290 = env6294 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6290 == env6294) = true)

theorem identity6294 : scanCanonicalize (H12AffineFastState.compose env6294 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 1070) := by decide +kernel

theorem selectedBound6294 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6295 : List Nat := [2,4,8,16,32,64,128,37,137,1024,1070,1077,1031,1124,1071,1156,1125,1070,1025,1071,1076,33,64,138,1166,16,1070,1125,1076,1071,1056,113,36,112,1125,136]

theorem envBound6295 : H12AffineFastState.Bounded env6295 := by
  intro p hp
  have h : env6295.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6294_6295 : H12AffineEnvironment.transform 10 1070 env6294 = env6295 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1070 env6294 == env6295) = true)

theorem identity6295 : scanCanonicalize (H12AffineFastState.compose env6295 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound6295 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6296 : List Nat := [2,4,8,16,32,64,9,37,0,1024,1070,1077,1031,1124,1071,1037,1125,1070,1025,1071,1076,33,64,3,1031,16,1070,1125,1076,1071,1056,113,36,112,1125,1]

theorem envBound6296 : H12AffineFastState.Bounded env6296 := by
  intro p hp
  have h : env6296.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6295_6296 : H12AffineEnvironment.transform 6 9 env6295 = env6296 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env6295 == env6296) = true)

theorem identity6296 : scanCanonicalize (H12AffineFastState.compose env6296 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound6296 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6297 : List Nat := [2,4,8,16,1,64,9,4,0,1024,1039,1044,1031,1093,1038,1037,1092,1039,1025,1038,1045,0,64,3,1031,16,1039,1092,1045,1038,1025,80,5,81,1092,1]

theorem envBound6297 : H12AffineFastState.Bounded env6297 := by
  intro p hp
  have h : env6297.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6296_6297 : H12AffineEnvironment.transform 4 1 env6296 = env6297 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env6296 == env6297) = true)

def leafEnv6297 : List Nat := [2,4,8,16,1,64,9,4,0,1024,1039,1044,1031,1093,1038,1037,1092,1039,1025,1038,1045,0,64,3,1025,1031,1,16,1039,1092,1045,1038,1025,80,5,81,4,1037,1092,1,0,1045,1]

def active6297 : List Nat := [0,1,2,3,5,9]

def tree6297 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6297 : H12WitnessSearch.Good tree6297 := H12GlobalWitnessIndex.good

theorem leafIdentity6297 : H12AffineFastState.composeSystem env6297 rootObs = leafEnv6297 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6297 rootObs == leafEnv6297) = true)

theorem terminalChecked6297 : H12PackedTerminal.terminalCheckFast leafEnv6297 active6297 tree6297 = true := by decide +kernel

def env6298 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,22424,43681,524288,32768,4097,10249,17665,98564,8329,18392,33061,4825,1297,9093,22493,4294967296,21465,4295601967,22424,513]

theorem envBound6298 : H12AffineFastState.Bounded env6298 := by
  intro p hp
  have h : env6298.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6234_6298 : H12AffineEnvironment.transform 21 10249 env6234 = env6298 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10249 env6234 == env6298) = true)

theorem identity6298 : scanCanonicalize (H12AffineFastState.compose env6298 (packedSelected [2,6,7,9] rootPS)) = affineNative (2^(14+1) ^^^ 13624) := by decide +kernel

theorem selectedBound6298 : packedSelected [2,6,7,9] rootPS < 2^1333 := by decide +kernel

def env6299 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,13624,65536,22424,8089,524288,13624,4097,10249,17665,78908,8329,18392,13341,4825,1297,9093,22493,4294967296,21465,4295563799,22424,513]

theorem envBound6299 : H12AffineFastState.Bounded env6299 := by
  intro p hp
  have h : env6299.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6298_6299 : H12AffineEnvironment.transform 14 13624 env6298 = env6299 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13624 env6298 == env6299) = true)

def env6300 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,8192,16384,8864,65536,16384,2049,524288,8864,1945,10249,17665,74660,8329,18392,9093,1345,1297,9093,16453,4294967296,17473,4295560591,16384,513]

theorem envBound6300 : H12AffineFastState.Bounded env6300 := by
  intro p hp
  have h : env6300.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6299_6300 : H12AffineEnvironment.transform 11 1944 env6299 = env6300 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env6299 == env6300) = true)

theorem identity6300 : scanCanonicalize (H12AffineFastState.compose env6300 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(13+1) ^^^ 11341) := by decide +kernel

theorem selectedBound6300 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env6301 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,8192,11341,8864,65536,11341,2049,524288,8864,1945,10249,10572,74660,8329,11157,9093,1345,1297,9093,11272,4294967296,10252,4295560591,11341,513]

theorem envBound6301 : H12AffineFastState.Bounded env6301 := by
  intro p hp
  have h : env6301.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6300_6301 : H12AffineEnvironment.transform 13 11341 env6300 = env6301 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 11341 env6300 == env6301) = true)

theorem identity6301 : scanCanonicalize (H12AffineFastState.compose env6301 (packedSelected [3,8,10,12] rootPS)) = affineNative (2^(12+1) ^^^ 2948) := by decide +kernel

theorem selectedBound6301 : packedSelected [3,8,10,12] rootPS < 2^1333 := by decide +kernel

def env6302 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,2948,1993,2340,65536,1993,2049,524288,2340,1945,909,712,67616,2829,17,2049,1345,1297,2049,1932,4294967296,904,4295560591,1993,513]

theorem envBound6302 : H12AffineFastState.Bounded env6302 := by
  intro p hp
  have h : env6302.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6301_6302 : H12AffineEnvironment.transform 12 2948 env6301 = env6302 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2948 env6301 == env6302) = true)

def env6303 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,2948,1993,2340,65536,1993,2049,1024,2340,1945,909,712,67616,2829,17,2049,1345,1297,2049,1932,4294967296,904,4295035279,1993,513]

theorem envBound6303 : H12AffineFastState.Bounded env6303 := by
  intro p hp
  have h : env6303.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6302_6303 : H12AffineEnvironment.transform 18 1024 env6302 = env6303 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env6302 == env6303) = true)

theorem identity6303 : scanCanonicalize (H12AffineFastState.compose env6303 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 2218) := by decide +kernel

theorem selectedBound6303 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env6304 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,2948,1993,2340,2218,1993,2049,1024,2340,1945,909,712,138,2829,17,2049,1345,1297,2049,1932,4294967296,904,4294967589,1993,513]

theorem envBound6304 : H12AffineFastState.Bounded env6304 := by
  intro p hp
  have h : env6304.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6303_6304 : H12AffineEnvironment.transform 15 2218 env6303 = env6304 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2218 env6303 == env6304) = true)

theorem identity6304 : scanCanonicalize (H12AffineFastState.compose env6304 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound6304 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env6305 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1692,2688,1741,2080,2218,1741,2049,1024,2080,1693,649,712,138,2569,17,2049,1093,1045,2049,1672,4294967296,652,4294967329,1741,513]

theorem envBound6305 : H12AffineFastState.Bounded env6305 := by
  intro p hp
  have h : env6305.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6304_6305 : H12AffineEnvironment.transform 7 4 env6304 = env6305 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env6304 == env6305) = true)

def env6306 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1692,2688,1741,2080,2218,1741,2049,1024,2080,1693,649,712,138,2569,17,2049,1093,1045,2049,1672,32,652,1,1741,513]

theorem envBound6306 : H12AffineFastState.Bounded env6306 := by
  intro p hp
  have h : env6306.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6305_6306 : H12AffineEnvironment.transform 31 32 env6305 = env6306 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 32 env6305 == env6306) = true)

theorem identity6306 : scanCanonicalize (H12AffineFastState.compose env6306 (packedSelected [5] rootPS)) = affineNative (2^(8+1) ^^^ 80) := by decide +kernel

theorem selectedBound6306 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env6307 : List Nat := [2,4,8,16,32,64,128,4,80,1024,2048,1228,2256,1181,2080,2218,1181,2049,1024,2080,1229,217,152,138,2137,17,2049,1093,1045,2049,1240,32,220,1,1181,81]

theorem envBound6307 : H12AffineFastState.Bounded env6307 := by
  intro p hp
  have h : env6307.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6306_6307 : H12AffineEnvironment.transform 8 80 env6306 = env6307 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 80 env6306 == env6307) = true)

def env6308 : List Nat := [2,4,8,16,16,64,128,4,80,1024,2048,1228,2256,1181,2064,2202,1181,2049,1024,2064,1229,217,152,138,2137,17,2049,1093,1045,2049,1240,16,220,1,1181,81]

theorem envBound6308 : H12AffineFastState.Bounded env6308 := by
  intro p hp
  have h : env6308.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6307_6308 : H12AffineEnvironment.transform 4 16 env6307 = env6308 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env6307 == env6308) = true)

theorem identity6308 : scanCanonicalize (H12AffineFastState.compose env6308 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 25) := by decide +kernel

theorem selectedBound6308 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6309 : List Nat := [2,4,8,16,16,64,25,4,80,1024,2048,1109,2121,1028,2064,2051,1028,2049,1024,2064,1108,64,1,19,2137,17,2049,1093,1045,2049,1089,16,69,1,1028,81]

theorem envBound6309 : H12AffineFastState.Bounded env6309 := by
  intro p hp
  have h : env6309.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6308_6309 : H12AffineEnvironment.transform 6 25 env6308 = env6309 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 25 env6308 == env6309) = true)

def env6310 : List Nat := [2,4,8,16,16,0,25,4,16,1024,2048,1045,2057,1028,2064,2051,1028,2049,1024,2064,1044,0,1,19,2073,17,2049,1029,1045,2049,1025,16,5,1,1028,17]

theorem envBound6310 : H12AffineFastState.Bounded env6310 := by
  intro p hp
  have h : env6310.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6309_6310 : H12AffineEnvironment.transform 5 0 env6309 = env6310 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env6309 == env6310) = true)

theorem identity6310 : scanCanonicalize (H12AffineFastState.compose env6310 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 1054) := by decide +kernel

theorem selectedBound6310 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6311 : List Nat := [2,4,8,16,16,0,25,4,16,1024,1054,1045,1047,1028,1038,1053,1028,1055,1024,1038,1044,0,1,19,1031,17,1055,1029,1045,1055,1025,16,5,1,1028,17]

theorem envBound6311 : H12AffineFastState.Bounded env6311 := by
  intro p hp
  have h : env6311.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6310_6311 : H12AffineEnvironment.transform 10 1054 env6310 = env6311 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1054 env6310 == env6311) = true)

def leafEnv6311 : List Nat := [2,4,8,16,16,0,25,4,16,1024,1054,1045,1047,1028,1038,1053,1028,1055,1024,1038,1044,0,1,19,1024,1031,1,17,1055,1029,1045,1055,1025,16,5,1,4,1037,1028,17,0,1045,1]

def active6311 : List Nat := [0,1,2,3,9]

def tree6311 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6311 : H12WitnessSearch.Good tree6311 := H12GlobalWitnessIndex.good

theorem leafIdentity6311 : H12AffineFastState.composeSystem env6311 rootObs = leafEnv6311 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6311 rootObs == leafEnv6311) = true)

theorem terminalChecked6311 : H12PackedTerminal.terminalCheckFast leafEnv6311 active6311 tree6311 = true := by decide +kernel

def env6312 : List Nat := [2,4,8,16,16,1,25,4,17,1024,2048,1044,2056,1028,2064,2051,1028,2049,1024,2064,1045,1,1,19,2072,17,2049,1028,1045,2049,1024,16,4,1,1028,16]

theorem envBound6312 : H12AffineFastState.Bounded env6312 := by
  intro p hp
  have h : env6312.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6309_6312 : H12AffineEnvironment.transform 5 1 env6309 = env6312 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 1 env6309 == env6312) = true)

theorem identity6312 : scanCanonicalize (H12AffineFastState.compose env6312 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 26) := by decide +kernel

theorem selectedBound6312 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6313 : List Nat := [2,4,8,16,16,1,25,4,17,1024,26,1044,18,1028,10,25,1028,27,1024,10,1045,1,1,19,2,17,27,1028,1045,27,1024,16,4,1,1028,16]

theorem envBound6313 : H12AffineFastState.Bounded env6313 := by
  intro p hp
  have h : env6313.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6312_6313 : H12AffineEnvironment.transform 10 26 env6312 = env6313 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 26 env6312 == env6313) = true)

theorem identity6313 : scanCanonicalize (H12AffineFastState.compose env6313 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound6313 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6314 : List Nat := [2,4,8,11,11,1,2,4,10,1024,1,1039,9,1028,10,2,1028,0,1024,10,1038,1,1,8,2,10,0,1028,1038,0,1024,11,4,1,1028,11]

theorem envBound6314 : H12AffineFastState.Bounded env6314 := by
  intro p hp
  have h : env6314.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6313_6314 : H12AffineEnvironment.transform 3 11 env6313 = env6314 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env6313 == env6314) = true)

theorem identity6314 : scanCanonicalize (H12AffineFastState.compose env6314 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound6314 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6315 : List Nat := [2,4,2,1,1,1,2,4,0,1024,1,1029,3,1028,0,2,1028,0,1024,0,1028,1,1,2,2,0,0,1028,1028,0,1024,1,4,1,1028,1]

theorem envBound6315 : H12AffineFastState.Bounded env6315 := by
  intro p hp
  have h : env6315.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6314_6315 : H12AffineEnvironment.transform 2 2 env6314 = env6315 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env6314 == env6315) = true)

def leafEnv6315 : List Nat := [2,4,2,1,1,1,2,4,0,1024,1,1029,3,1028,0,2,1028,0,1024,0,1028,1,1,2,1024,2,1,0,0,1028,1028,0,1024,1,4,1,4,3,1028,1,0,1029,1]

def active6315 : List Nat := [0,1,9]

def tree6315 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6315 : H12WitnessSearch.Good tree6315 := H12GlobalWitnessIndex.good

theorem leafIdentity6315 : H12AffineFastState.composeSystem env6315 rootObs = leafEnv6315 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6315 rootObs == leafEnv6315) = true)

theorem terminalChecked6315 : H12PackedTerminal.terminalCheckFast leafEnv6315 active6315 tree6315 = true := by decide +kernel

def env6316 : List Nat := [2,4,8,16,17,64,128,4,80,1024,2048,1228,2256,1181,2065,2203,1181,2049,1024,2065,1229,217,152,138,2137,17,2049,1093,1045,2049,1240,17,220,1,1181,81]

theorem envBound6316 : H12AffineFastState.Bounded env6316 := by
  intro p hp
  have h : env6316.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6307_6316 : H12AffineEnvironment.transform 4 17 env6307 = env6316 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env6307 == env6316) = true)

theorem identity6316 : scanCanonicalize (H12AffineFastState.compose env6316 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 1) := by decide +kernel

theorem selectedBound6316 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6317 : List Nat := [2,4,8,16,17,1,128,4,17,1024,2048,1165,2193,1181,2065,2203,1181,2049,1024,2065,1164,152,152,138,2072,17,2049,1028,1045,2049,1177,17,157,1,1181,16]

theorem envBound6317 : H12AffineFastState.Bounded env6317 := by
  intro p hp
  have h : env6317.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6316_6317 : H12AffineEnvironment.transform 5 1 env6316 = env6317 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 1 env6316 == env6317) = true)

def env6318 : List Nat := [2,4,8,16,17,1,24,4,17,1024,2048,1045,2057,1029,2065,2051,1029,2049,1024,2065,1044,0,0,18,2072,17,2049,1028,1045,2049,1025,17,5,1,1029,16]

theorem envBound6318 : H12AffineFastState.Bounded env6318 := by
  intro p hp
  have h : env6318.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6317_6318 : H12AffineEnvironment.transform 6 24 env6317 = env6318 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 24 env6317 == env6318) = true)

theorem identity6318 : scanCanonicalize (H12AffineFastState.compose env6318 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 1055) := by decide +kernel

theorem selectedBound6318 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6319 : List Nat := [2,4,8,16,17,1,24,4,17,1024,1055,1045,1046,1029,1038,1052,1029,1054,1024,1038,1044,0,0,18,1031,17,1054,1028,1045,1054,1025,17,5,1,1029,16]

theorem envBound6319 : H12AffineFastState.Bounded env6319 := by
  intro p hp
  have h : env6319.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6318_6319 : H12AffineEnvironment.transform 10 1055 env6318 = env6319 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1055 env6318 == env6319) = true)

def leafEnv6319 : List Nat := [2,4,8,16,17,1,24,4,17,1024,1055,1045,1046,1029,1038,1052,1029,1054,1024,1038,1044,0,0,18,1024,1031,1,17,1054,1028,1045,1054,1025,17,5,1,4,1037,1029,16,0,1045,1]

def active6319 : List Nat := [0,1,2,3,9]

def tree6319 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6319 : H12WitnessSearch.Good tree6319 := H12GlobalWitnessIndex.good

theorem leafIdentity6319 : H12AffineFastState.composeSystem env6319 rootObs = leafEnv6319 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6319 rootObs == leafEnv6319) = true)

theorem terminalChecked6319 : H12PackedTerminal.terminalCheckFast leafEnv6319 active6319 tree6319 = true := by decide +kernel

def env6320 : List Nat := [2,4,8,16,17,1,25,4,17,1024,2048,1044,2056,1028,2065,2050,1028,2049,1024,2065,1045,1,1,19,2072,17,2049,1028,1045,2049,1024,17,4,1,1028,16]

theorem envBound6320 : H12AffineFastState.Bounded env6320 := by
  intro p hp
  have h : env6320.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6317_6320 : H12AffineEnvironment.transform 6 25 env6317 = env6320 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 25 env6317 == env6320) = true)

theorem identity6320 : scanCanonicalize (H12AffineFastState.compose env6320 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 11) := by decide +kernel

theorem selectedBound6320 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6321 : List Nat := [2,4,8,16,17,1,25,4,17,1024,11,1044,3,1028,26,9,1028,10,1024,26,1045,1,1,19,19,17,10,1028,1045,10,1024,17,4,1,1028,16]

theorem envBound6321 : H12AffineFastState.Bounded env6321 := by
  intro p hp
  have h : env6321.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6320_6321 : H12AffineEnvironment.transform 10 11 env6320 = env6321 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 11 env6320 == env6321) = true)

theorem identity6321 : scanCanonicalize (H12AffineFastState.compose env6321 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound6321 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6322 : List Nat := [2,4,8,10,11,1,3,4,11,1024,11,1038,3,1028,0,9,1028,10,1024,0,1039,1,1,9,9,11,10,1028,1039,10,1024,11,4,1,1028,10]

theorem envBound6322 : H12AffineFastState.Bounded env6322 := by
  intro p hp
  have h : env6322.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6321_6322 : H12AffineEnvironment.transform 3 10 env6321 = env6322 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env6321 == env6322) = true)

theorem identity6322 : scanCanonicalize (H12AffineFastState.compose env6322 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound6322 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6323 : List Nat := [2,4,2,0,1,1,3,4,1,1024,1,1028,3,1028,0,3,1028,0,1024,0,1029,1,1,3,3,1,0,1028,1029,0,1024,1,4,1,1028,0]

theorem envBound6323 : H12AffineFastState.Bounded env6323 := by
  intro p hp
  have h : env6323.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6322_6323 : H12AffineEnvironment.transform 2 2 env6322 = env6323 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env6322 == env6323) = true)

def leafEnv6323 : List Nat := [2,4,2,0,1,1,3,4,1,1024,1,1028,3,1028,0,3,1028,0,1024,0,1029,1,1,3,1024,3,1,1,0,1028,1029,0,1024,1,4,1,4,3,1028,0,0,1028,1]

def active6323 : List Nat := [0,1,9]

def tree6323 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6323 : H12WitnessSearch.Good tree6323 := H12GlobalWitnessIndex.good

theorem leafIdentity6323 : H12AffineFastState.composeSystem env6323 rootObs = leafEnv6323 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6323 rootObs == leafEnv6323) = true)

theorem terminalChecked6323 : H12PackedTerminal.terminalCheckFast leafEnv6323 active6323 tree6323 = true := by decide +kernel

def env6324 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1692,2688,1741,2080,2218,1741,2049,1024,2080,1693,649,712,138,2569,17,2049,1093,1045,2049,1672,33,652,0,1741,513]

theorem envBound6324 : H12AffineFastState.Bounded env6324 := by
  intro p hp
  have h : env6324.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6305_6324 : H12AffineEnvironment.transform 31 33 env6305 = env6324 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 33 env6305 == env6324) = true)

theorem identity6324 : scanCanonicalize (H12AffineFastState.compose env6324 (packedSelected [5] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound6324 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env6325 : List Nat := [2,4,8,16,32,64,88,4,512,1024,2048,1604,2648,1557,2080,2162,1557,2049,1024,2080,1605,593,528,82,2569,17,2049,1093,1045,2049,1616,33,596,0,1557,513]

theorem envBound6325 : H12AffineFastState.Bounded env6325 := by
  intro p hp
  have h : env6325.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6324_6325 : H12AffineEnvironment.transform 6 88 env6324 = env6325 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env6324 == env6325) = true)

def env6326 : List Nat := [2,4,8,16,32,64,88,4,96,1024,2048,1060,2104,1141,2080,2162,1141,2049,1024,2080,1061,49,112,82,2153,17,2049,1093,1045,2049,1072,33,52,0,1141,97]

theorem envBound6326 : H12AffineFastState.Bounded env6326 := by
  intro p hp
  have h : env6326.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6325_6326 : H12AffineEnvironment.transform 8 96 env6325 = env6326 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 96 env6325 == env6326) = true)

theorem identity6326 : scanCanonicalize (H12AffineFastState.compose env6326 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound6326 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6327 : List Nat := [2,4,8,16,32,17,9,4,49,1024,2048,1060,2104,1060,2080,2083,1060,2049,1024,2080,1061,49,33,3,2104,17,2049,1044,1045,2049,1072,33,52,0,1060,48]

theorem envBound6327 : H12AffineFastState.Bounded env6327 := by
  intro p hp
  have h : env6327.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6326_6327 : H12AffineEnvironment.transform 5 17 env6326 = env6327 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env6326 == env6327) = true)

def env6328 : List Nat := [2,4,8,16,16,17,9,4,1,1024,2048,1044,2056,1044,2064,2067,1044,2049,1024,2064,1045,1,17,3,2056,17,2049,1044,1045,2049,1024,17,4,0,1044,0]

theorem envBound6328 : H12AffineFastState.Bounded env6328 := by
  intro p hp
  have h : env6328.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6327_6328 : H12AffineEnvironment.transform 4 16 env6327 = env6328 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env6327 == env6328) = true)

theorem identity6328 : scanCanonicalize (H12AffineFastState.compose env6328 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 27) := by decide +kernel

theorem selectedBound6328 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6329 : List Nat := [2,4,8,16,16,17,9,4,1,1024,27,1044,19,1044,11,8,1044,26,1024,11,1045,1,17,3,19,17,26,1044,1045,26,1024,17,4,0,1044,0]

theorem envBound6329 : H12AffineFastState.Bounded env6329 := by
  intro p hp
  have h : env6329.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6328_6329 : H12AffineEnvironment.transform 10 27 env6328 = env6329 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 27 env6328 == env6329) = true)

theorem identity6329 : scanCanonicalize (H12AffineFastState.compose env6329 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound6329 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6330 : List Nat := [2,4,8,10,10,11,9,4,1,1024,1,1038,9,1038,11,8,1038,0,1024,11,1039,1,11,3,9,11,0,1038,1039,0,1024,11,4,0,1038,0]

theorem envBound6330 : H12AffineFastState.Bounded env6330 := by
  intro p hp
  have h : env6330.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6329_6330 : H12AffineEnvironment.transform 3 10 env6329 = env6330 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env6329 == env6330) = true)

theorem identity6330 : scanCanonicalize (H12AffineFastState.compose env6330 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound6330 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6331 : List Nat := [2,4,3,1,1,0,2,4,1,1024,1,1029,2,1029,0,3,1029,0,1024,0,1028,1,0,3,2,0,0,1029,1028,0,1024,0,4,0,1029,0]

theorem envBound6331 : H12AffineFastState.Bounded env6331 := by
  intro p hp
  have h : env6331.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6330_6331 : H12AffineEnvironment.transform 2 3 env6330 = env6331 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env6330 == env6331) = true)

def leafEnv6331 : List Nat := [2,4,3,1,1,0,2,4,1,1024,1,1029,2,1029,0,3,1029,0,1024,0,1028,1,0,3,1024,2,1,0,0,1029,1028,0,1024,0,4,0,4,3,1029,0,0,1029,1]

def active6331 : List Nat := [0,1,9]

def tree6331 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6331 : H12WitnessSearch.Good tree6331 := H12GlobalWitnessIndex.good

theorem leafIdentity6331 : H12AffineFastState.composeSystem env6331 rootObs = leafEnv6331 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6331 rootObs == leafEnv6331) = true)

theorem terminalChecked6331 : H12PackedTerminal.terminalCheckFast leafEnv6331 active6331 tree6331 = true := by decide +kernel

def env6332 : List Nat := [2,4,8,16,17,17,9,4,0,1024,2048,1045,2057,1045,2065,2066,1045,2049,1024,2065,1044,0,16,3,2057,17,2049,1044,1045,2049,1025,16,5,0,1045,1]

theorem envBound6332 : H12AffineFastState.Bounded env6332 := by
  intro p hp
  have h : env6332.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6327_6332 : H12AffineEnvironment.transform 4 17 env6327 = env6332 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env6327 == env6332) = true)

theorem identity6332 : scanCanonicalize (H12AffineFastState.compose env6332 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 1055) := by decide +kernel

theorem selectedBound6332 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6333 : List Nat := [2,4,8,16,17,17,9,4,0,1024,1055,1045,1046,1045,1038,1037,1045,1054,1024,1038,1044,0,16,3,1046,17,1054,1044,1045,1054,1025,16,5,0,1045,1]

theorem envBound6333 : H12AffineFastState.Bounded env6333 := by
  intro p hp
  have h : env6333.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6332_6333 : H12AffineEnvironment.transform 10 1055 env6332 = env6333 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1055 env6332 == env6333) = true)

def leafEnv6333 : List Nat := [2,4,8,16,17,17,9,4,0,1024,1055,1045,1046,1045,1038,1037,1045,1054,1024,1038,1044,0,16,3,1024,1046,1,17,1054,1044,1045,1054,1025,16,5,0,4,1037,1045,1,0,1045,1]

def active6333 : List Nat := [0,1,2,3,9]

def tree6333 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6333 : H12WitnessSearch.Good tree6333 := H12GlobalWitnessIndex.good

theorem leafIdentity6333 : H12AffineFastState.composeSystem env6333 rootObs = leafEnv6333 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6333 rootObs == leafEnv6333) = true)

theorem terminalChecked6333 : H12PackedTerminal.terminalCheckFast leafEnv6333 active6333 tree6333 = true := by decide +kernel

def env6334 : List Nat := [2,4,8,16,32,64,88,4,97,1024,2048,1061,2105,1140,2080,2162,1140,2049,1024,2080,1060,48,113,82,2152,17,2049,1093,1045,2049,1073,33,53,0,1140,96]

theorem envBound6334 : H12AffineFastState.Bounded env6334 := by
  intro p hp
  have h : env6334.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6325_6334 : H12AffineEnvironment.transform 8 97 env6325 = env6334 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 97 env6325 == env6334) = true)

theorem identity6334 : scanCanonicalize (H12AffineFastState.compose env6334 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 33) := by decide +kernel

theorem selectedBound6334 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6335 : List Nat := [2,4,8,16,32,33,57,4,0,1024,2048,1061,2105,1045,2080,2067,1045,2049,1024,2080,1060,48,16,51,2057,17,2049,1060,1045,2049,1073,33,53,0,1045,1]

theorem envBound6335 : H12AffineFastState.Bounded env6335 := by
  intro p hp
  have h : env6335.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6334_6335 : H12AffineEnvironment.transform 5 33 env6334 = env6335 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 33 env6334 == env6335) = true)

def env6336 : List Nat := [2,4,8,16,16,17,9,4,0,1024,2048,1045,2057,1045,2064,2067,1045,2049,1024,2064,1044,0,16,3,2057,17,2049,1044,1045,2049,1025,17,5,0,1045,1]

theorem envBound6336 : H12AffineFastState.Bounded env6336 := by
  intro p hp
  have h : env6336.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6335_6336 : H12AffineEnvironment.transform 4 16 env6335 = env6336 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env6335 == env6336) = true)

theorem identity6336 : scanCanonicalize (H12AffineFastState.compose env6336 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 1054) := by decide +kernel

theorem selectedBound6336 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6337 : List Nat := [2,4,8,16,16,17,9,4,0,1024,1054,1045,1047,1045,1038,1037,1045,1055,1024,1038,1044,0,16,3,1047,17,1055,1044,1045,1055,1025,17,5,0,1045,1]

theorem envBound6337 : H12AffineFastState.Bounded env6337 := by
  intro p hp
  have h : env6337.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6336_6337 : H12AffineEnvironment.transform 10 1054 env6336 = env6337 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1054 env6336 == env6337) = true)

def leafEnv6337 : List Nat := [2,4,8,16,16,17,9,4,0,1024,1054,1045,1047,1045,1038,1037,1045,1055,1024,1038,1044,0,16,3,1024,1047,1,17,1055,1044,1045,1055,1025,17,5,0,4,1037,1045,1,0,1045,1]

def active6337 : List Nat := [0,1,2,3,9]

def tree6337 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6337 : H12WitnessSearch.Good tree6337 := H12GlobalWitnessIndex.good

theorem leafIdentity6337 : H12AffineFastState.composeSystem env6337 rootObs = leafEnv6337 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6337 rootObs == leafEnv6337) = true)

theorem terminalChecked6337 : H12PackedTerminal.terminalCheckFast leafEnv6337 active6337 tree6337 = true := by decide +kernel

def env6338 : List Nat := [2,4,8,16,17,16,8,4,0,1024,2048,1044,2056,1045,2065,2067,1045,2049,1024,2065,1045,1,16,2,2057,17,2049,1045,1045,2049,1024,16,4,0,1045,1]

theorem envBound6338 : H12AffineFastState.Bounded env6338 := by
  intro p hp
  have h : env6338.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6335_6338 : H12AffineEnvironment.transform 4 17 env6335 = env6338 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env6335 == env6338) = true)

theorem identity6338 : scanCanonicalize (H12AffineFastState.compose env6338 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 10) := by decide +kernel

theorem selectedBound6338 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6339 : List Nat := [2,4,8,16,17,16,8,4,0,1024,10,1044,2,1045,27,25,1045,11,1024,27,1045,1,16,2,3,17,11,1045,1045,11,1024,16,4,0,1045,1]

theorem envBound6339 : H12AffineFastState.Bounded env6339 := by
  intro p hp
  have h : env6339.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6338_6339 : H12AffineEnvironment.transform 10 10 env6338 = env6339 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 10 env6338 == env6339) = true)

theorem identity6339 : scanCanonicalize (H12AffineFastState.compose env6339 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound6339 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6340 : List Nat := [2,4,8,11,10,11,8,4,0,1024,10,1039,2,1038,0,2,1038,11,1024,0,1038,1,11,2,3,10,11,1038,1038,11,1024,11,4,0,1038,1]

theorem envBound6340 : H12AffineFastState.Bounded env6340 := by
  intro p hp
  have h : env6340.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6339_6340 : H12AffineEnvironment.transform 3 11 env6339 = env6340 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env6339 == env6340) = true)

theorem identity6340 : scanCanonicalize (H12AffineFastState.compose env6340 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound6340 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6341 : List Nat := [2,4,3,0,1,0,3,4,0,1024,1,1028,2,1029,0,2,1029,0,1024,0,1029,1,0,2,3,1,0,1029,1029,0,1024,0,4,0,1029,1]

theorem envBound6341 : H12AffineFastState.Bounded env6341 := by
  intro p hp
  have h : env6341.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6340_6341 : H12AffineEnvironment.transform 2 3 env6340 = env6341 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env6340 == env6341) = true)

def leafEnv6341 : List Nat := [2,4,3,0,1,0,3,4,0,1024,1,1028,2,1029,0,2,1029,0,1024,0,1029,1,0,2,1024,3,1,1,0,1029,1029,0,1024,0,4,0,4,3,1029,1,0,1028,1]

def active6341 : List Nat := [0,1,9]

def tree6341 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6341 : H12WitnessSearch.Good tree6341 := H12GlobalWitnessIndex.good

theorem leafIdentity6341 : H12AffineFastState.composeSystem env6341 rootObs = leafEnv6341 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6341 rootObs == leafEnv6341) = true)

theorem terminalChecked6341 : H12PackedTerminal.terminalCheckFast leafEnv6341 active6341 tree6341 = true := by decide +kernel

def env6342 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,2948,1993,2340,65536,1993,2049,1025,2340,1945,909,712,67616,2829,17,2049,1345,1297,2049,1932,4294967296,904,4295035278,1993,513]

theorem envBound6342 : H12AffineFastState.Bounded env6342 := by
  intro p hp
  have h : env6342.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6302_6342 : H12AffineEnvironment.transform 18 1025 env6302 = env6342 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env6302 == env6342) = true)

theorem identity6342 : scanCanonicalize (H12AffineFastState.compose env6342 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 2595) := by decide +kernel

theorem selectedBound6342 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env6343 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,2948,1993,2340,2595,1993,2049,1025,2340,1945,909,712,515,2829,17,2049,1345,1297,2049,1932,4294967296,904,4294968237,1993,513]

theorem envBound6343 : H12AffineFastState.Bounded env6343 := by
  intro p hp
  have h : env6343.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6342_6343 : H12AffineEnvironment.transform 15 2595 env6342 = env6343 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2595 env6342 == env6343) = true)

def env6344 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,2948,1993,2340,2595,1993,2049,1025,2340,1945,909,712,515,2829,17,2049,1345,1297,2049,1932,112,904,989,1993,513]

theorem envBound6344 : H12AffineFastState.Bounded env6344 := by
  intro p hp
  have h : env6344.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6343_6344 : H12AffineEnvironment.transform 31 112 env6343 = env6344 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 112 env6343 == env6344) = true)

theorem identity6344 : scanCanonicalize (H12AffineFastState.compose env6344 (packedSelected [5] rootPS)) = affineNative (2^(8+1) ^^^ 429) := by decide +kernel

theorem selectedBound6344 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env6345 : List Nat := [2,4,8,16,32,64,128,256,429,1024,2048,1077,2089,1124,2340,2446,1124,2049,1025,2340,1076,32,357,430,2208,17,2049,1345,1297,2049,1057,112,37,112,1124,428]

theorem envBound6345 : H12AffineFastState.Bounded env6345 := by
  intro p hp
  have h : env6345.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6344_6345 : H12AffineEnvironment.transform 8 429 env6344 = env6345 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 429 env6344 == env6345) = true)

def env6346 : List Nat := [2,4,8,16,32,64,128,256,429,1024,1360,1077,1401,1124,1140,1246,1124,1361,1025,1140,1076,32,357,430,1520,17,1361,1345,1297,1361,1057,112,37,112,1124,428]

theorem envBound6346 : H12AffineFastState.Bounded env6346 := by
  intro p hp
  have h : env6346.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6345_6346 : H12AffineEnvironment.transform 10 1360 env6345 = env6346 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1360 env6345 == env6346) = true)

theorem identity6346 : scanCanonicalize (H12AffineFastState.compose env6346 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 126) := by decide +kernel

theorem selectedBound6346 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6347 : List Nat := [2,4,8,16,32,64,128,126,211,1024,1070,1077,1031,1124,1140,1246,1124,1071,1025,1140,1076,32,27,208,1166,17,1071,1087,1135,1071,1057,112,37,112,1124,210]

theorem envBound6347 : H12AffineFastState.Bounded env6347 := by
  intro p hp
  have h : env6347.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6346_6347 : H12AffineEnvironment.transform 7 126 env6346 = env6347 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 126 env6346 == env6347) = true)

def env6348 : List Nat := [2,4,8,0,32,64,128,110,195,1024,1070,1061,1031,1124,1124,1230,1124,1071,1025,1124,1060,32,11,192,1166,1,1071,1071,1135,1071,1057,96,37,96,1124,194]

theorem envBound6348 : H12AffineFastState.Bounded env6348 := by
  intro p hp
  have h : env6348.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6347_6348 : H12AffineEnvironment.transform 3 0 env6347 = env6348 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env6347 == env6348) = true)

theorem identity6348 : scanCanonicalize (H12AffineFastState.compose env6348 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound6348 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6349 : List Nat := [2,4,8,0,32,10,128,36,137,1024,1070,1061,1031,1070,1070,1156,1070,1071,1025,1070,1060,32,11,138,1166,1,1071,1071,1061,1071,1057,42,37,42,1070,136]

theorem envBound6349 : H12AffineFastState.Bounded env6349 := by
  intro p hp
  have h : env6349.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6348_6349 : H12AffineEnvironment.transform 5 10 env6348 = env6349 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env6348 == env6349) = true)

theorem identity6349 : scanCanonicalize (H12AffineFastState.compose env6349 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 41) := by decide +kernel

theorem selectedBound6349 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6350 : List Nat := [2,4,8,0,32,10,41,36,32,1024,1070,1061,1031,1070,1070,1069,1070,1071,1025,1070,1060,32,11,35,1063,1,1071,1071,1061,1071,1057,42,37,42,1070,33]

theorem envBound6350 : H12AffineFastState.Bounded env6350 := by
  intro p hp
  have h : env6350.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6349_6350 : H12AffineEnvironment.transform 6 41 env6349 = env6350 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 41 env6349 == env6350) = true)

theorem identity6350 : scanCanonicalize (H12AffineFastState.compose env6350 (packedSelected [4] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound6350 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env6351 : List Nat := [2,4,8,0,0,10,9,4,0,1024,1038,1029,1031,1038,1038,1037,1038,1039,1025,1038,1028,0,11,3,1031,1,1039,1039,1029,1039,1025,10,5,10,1038,1]

theorem envBound6351 : H12AffineFastState.Bounded env6351 := by
  intro p hp
  have h : env6351.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6350_6351 : H12AffineEnvironment.transform 4 0 env6350 = env6351 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env6350 == env6351) = true)

def leafEnv6351 : List Nat := [2,4,8,0,0,10,9,4,0,1024,1038,1029,1031,1038,1038,1037,1038,1039,1025,1038,1028,0,11,3,1025,1031,1,1,1039,1039,1029,1039,1025,10,5,10,4,1037,1038,1,0,1029,1]

def active6351 : List Nat := [0,1,2,9]

def tree6351 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6351 : H12WitnessSearch.Good tree6351 := H12GlobalWitnessIndex.good

theorem leafIdentity6351 : H12AffineFastState.composeSystem env6351 rootObs = leafEnv6351 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6351 rootObs == leafEnv6351) = true)

theorem terminalChecked6351 : H12PackedTerminal.terminalCheckFast leafEnv6351 active6351 tree6351 = true := by decide +kernel

def env6352 : List Nat := [2,4,8,1,32,64,128,111,194,1024,1070,1060,1031,1124,1125,1231,1124,1071,1025,1125,1061,32,10,193,1166,0,1071,1070,1135,1071,1057,97,37,97,1124,195]

theorem envBound6352 : H12AffineFastState.Bounded env6352 := by
  intro p hp
  have h : env6352.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6347_6352 : H12AffineEnvironment.transform 3 1 env6347 = env6352 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env6347 == env6352) = true)

def env6353 : List Nat := [2,4,8,1,32,64,40,111,106,1024,1070,1060,1031,1124,1125,1127,1124,1071,1025,1125,1061,32,10,105,1062,0,1071,1070,1135,1071,1057,97,37,97,1124,107]

theorem envBound6353 : H12AffineFastState.Bounded env6353 := by
  intro p hp
  have h : env6353.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6352_6353 : H12AffineEnvironment.transform 6 40 env6352 = env6353 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 40 env6352 == env6353) = true)

theorem identity6353 : scanCanonicalize (H12AffineFastState.compose env6353 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound6353 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6354 : List Nat := [2,4,8,1,32,10,40,37,32,1024,1070,1060,1031,1070,1071,1069,1070,1071,1025,1071,1061,32,10,35,1062,0,1071,1070,1061,1071,1057,43,37,43,1070,33]

theorem envBound6354 : H12AffineFastState.Bounded env6354 := by
  intro p hp
  have h : env6354.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6353_6354 : H12AffineEnvironment.transform 5 10 env6353 = env6354 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env6353 == env6354) = true)

def leafEnv6354 : List Nat := [2,4,8,1,32,10,40,37,32,1024,1070,1060,1031,1070,1071,1069,1070,1071,1025,1071,1061,32,10,35,1056,1062,1,0,1071,1070,1061,1071,1057,43,37,43,4,1037,1070,33,0,1060,1]

def active6354 : List Nat := [0,1,2,4,9]

def tree6354 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6354 : H12WitnessSearch.Good tree6354 := H12GlobalWitnessIndex.good

theorem leafIdentity6354 : H12AffineFastState.composeSystem env6354 rootObs = leafEnv6354 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6354 rootObs == leafEnv6354) = true)

theorem terminalChecked6354 : H12PackedTerminal.terminalCheckFast leafEnv6354 active6354 tree6354 = true := by decide +kernel

def env6355 : List Nat := [2,4,8,1,32,64,41,111,107,1024,1070,1060,1031,1124,1125,1126,1124,1071,1025,1125,1061,32,10,104,1063,0,1071,1070,1135,1071,1057,97,37,97,1124,106]

theorem envBound6355 : H12AffineFastState.Bounded env6355 := by
  intro p hp
  have h : env6355.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6352_6355 : H12AffineEnvironment.transform 6 41 env6352 = env6355 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 41 env6352 == env6355) = true)

def env6356 : List Nat := [2,4,8,1,0,64,9,79,75,1024,1038,1028,1031,1092,1093,1094,1092,1039,1025,1093,1029,0,10,72,1031,0,1039,1038,1103,1039,1025,65,5,65,1092,74]

theorem envBound6356 : H12AffineFastState.Bounded env6356 := by
  intro p hp
  have h : env6356.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6355_6356 : H12AffineEnvironment.transform 4 0 env6355 = env6356 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env6355 == env6356) = true)

def leafEnv6356 : List Nat := [2,4,8,1,0,64,9,79,75,1024,1038,1028,1031,1092,1093,1094,1092,1039,1025,1093,1029,0,10,72,1098,1031,1,0,1039,1038,1103,1039,1025,65,5,65,4,1037,1092,74,0,1028,1]

def active6356 : List Nat := [0,1,2,5,9]

def tree6356 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6356 : H12WitnessSearch.Good tree6356 := H12GlobalWitnessIndex.good

theorem leafIdentity6356 : H12AffineFastState.composeSystem env6356 rootObs = leafEnv6356 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6356 rootObs == leafEnv6356) = true)

theorem terminalChecked6356 : H12PackedTerminal.terminalCheckFast leafEnv6356 active6356 tree6356 = true := by decide +kernel

def env6357 : List Nat := [2,4,8,1,1,64,8,78,74,1024,1039,1029,1031,1093,1092,1095,1093,1038,1025,1092,1028,1,10,73,1030,0,1038,1039,1102,1038,1024,64,4,64,1093,75]

theorem envBound6357 : H12AffineFastState.Bounded env6357 := by
  intro p hp
  have h : env6357.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6355_6357 : H12AffineEnvironment.transform 4 1 env6355 = env6357 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env6355 == env6357) = true)

theorem identity6357 : scanCanonicalize (H12AffineFastState.compose env6357 (packedSelected [4] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound6357 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env6358 : List Nat := [2,4,8,1,1,10,8,4,0,1024,1039,1029,1031,1039,1038,1037,1039,1038,1025,1038,1028,1,10,3,1030,0,1038,1039,1028,1038,1024,10,4,10,1039,1]

theorem envBound6358 : H12AffineFastState.Bounded env6358 := by
  intro p hp
  have h : env6358.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6357_6358 : H12AffineEnvironment.transform 5 10 env6357 = env6358 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env6357 == env6358) = true)

def leafEnv6358 : List Nat := [2,4,8,1,1,10,8,4,0,1024,1039,1029,1031,1039,1038,1037,1039,1038,1025,1038,1028,1,10,3,1025,1030,1,0,1038,1039,1028,1038,1024,10,4,10,4,1037,1039,1,0,1029,1]

def active6358 : List Nat := [0,1,2,9]

def tree6358 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

end H12GlobalChart2
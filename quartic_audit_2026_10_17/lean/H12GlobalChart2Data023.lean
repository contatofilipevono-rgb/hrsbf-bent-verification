import H12GlobalChart2Data022

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

def env5652 : List Nat := [2,4,8,16,32,64,89,256,80,1024,2048,4096,8192,4177,13341,13643,1345,7220,1025,13341,4096,4194304,5456,82,8272,5377,4201777,4177,1297,4196612,1284,4294967296,256,4299161632,1345,81]

theorem envBound5652 : H12AffineFastState.Bounded env5652 := by
  intro p hp
  have h : env5652.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5651_5652 : H12AffineEnvironment.transform 6 89 env5651 = env5652 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env5651 == env5652) = true)

theorem identity5652 : scanCanonicalize (H12AffineFastState.compose env5652 (packedSelected [1,12] rootPS)) = affineNative (2^(11+1) ^^^ 1370) := by decide +kernel

theorem selectedBound5652 : packedSelected [1,12] rootPS < 2^1333 := by decide +kernel

def env5653 : List Nat := [2,4,8,16,32,64,89,256,80,1024,2048,1370,8192,1291,8519,8209,1345,2414,1025,8519,1370,4194304,10,82,8272,91,4196459,1291,1297,4196612,1284,4294967296,256,4299161632,1345,81]

theorem envBound5653 : H12AffineFastState.Bounded env5653 := by
  intro p hp
  have h : env5653.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5652_5653 : H12AffineEnvironment.transform 11 1370 env5652 = env5653 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1370 env5652 == env5653) = true)

def env5654 : List Nat := [2,4,8,16,32,64,89,256,80,1024,2048,1370,8192,1291,8519,8209,1345,2414,1025,8519,1370,10540,10,82,8272,91,8519,1291,1297,8232,1284,4294967296,256,4294977804,1345,81]

theorem envBound5654 : H12AffineFastState.Bounded env5654 := by
  intro p hp
  have h : env5654.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5653_5654 : H12AffineEnvironment.transform 21 10540 env5653 = env5654 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10540 env5653 == env5654) = true)

theorem identity5654 : scanCanonicalize (H12AffineFastState.compose env5654 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound5654 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5655 : List Nat := [2,4,8,16,32,64,89,36,80,1024,2048,1150,8192,1071,8291,8209,1125,2122,1025,8291,1150,10248,10,82,8272,91,8291,1071,1077,8232,1056,4294967296,36,4294977576,1125,81]

theorem envBound5655 : H12AffineFastState.Bounded env5655 := by
  intro p hp
  have h : env5655.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5654_5655 : H12AffineEnvironment.transform 7 36 env5654 = env5655 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env5654 == env5655) = true)

theorem identity5655 : scanCanonicalize (H12AffineFastState.compose env5655 (packedSelected [2,4] rootPS)) = affineNative (2^(12+1) ^^^ 2147) := by decide +kernel

theorem selectedBound5655 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env5656 : List Nat := [2,4,8,16,32,64,89,36,80,1024,2048,1150,2147,1071,2048,2162,1125,2122,1025,2048,1150,107,10,82,2099,91,2048,1071,1077,2123,1056,4294967296,36,4294967371,1125,81]

theorem envBound5656 : H12AffineFastState.Bounded env5656 := by
  intro p hp
  have h : env5656.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5655_5656 : H12AffineEnvironment.transform 12 2147 env5655 = env5656 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2147 env5655 == env5656) = true)

theorem identity5656 : scanCanonicalize (H12AffineFastState.compose env5656 (packedSelected [0,7] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound5656 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env5657 : List Nat := [2,4,8,16,32,11,18,36,27,1024,2048,1077,2088,1071,2048,2105,1070,2049,1025,2048,1077,32,10,25,2099,16,2048,1071,1077,2048,1056,4294967296,36,4294967296,1070,26]

theorem envBound5657 : H12AffineFastState.Bounded env5657 := by
  intro p hp
  have h : env5657.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5656_5657 : H12AffineEnvironment.transform 5 11 env5656 = env5657 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env5656 == env5657) = true)

theorem identity5657 : scanCanonicalize (H12AffineFastState.compose env5657 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 48) := by decide +kernel

theorem selectedBound5657 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5658 : List Nat := [2,4,8,16,32,11,18,36,27,1024,2048,1077,2088,1071,2048,2105,1070,2049,1025,2048,1077,32,10,25,2099,16,2048,1071,1077,2048,1056,48,36,48,1070,26]

theorem envBound5658 : H12AffineFastState.Bounded env5658 := by
  intro p hp
  have h : env5658.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5657_5658 : H12AffineEnvironment.transform 31 48 env5657 = env5658 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 48 env5657 == env5658) = true)

def leafEnv5658 : List Nat := [2,4,8,16,32,11,18,36,27,1024,2048,1077,2088,1071,2048,2105,1070,2049,1025,2048,1077,32,10,25,1057,2099,1,16,2048,1071,1077,2048,1056,48,36,48,4,2083,1070,26,0,1077,1]

def active5658 : List Nat := [0,1,2,3,4,9,10]

def tree5658 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5658 : H12WitnessSearch.Good tree5658 := H12GlobalWitnessIndex.good

theorem leafIdentity5658 : H12AffineFastState.composeSystem env5658 rootObs = leafEnv5658 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5658 rootObs == leafEnv5658) = true)

theorem terminalChecked5658 : H12PackedTerminal.terminalCheckFast leafEnv5658 active5658 tree5658 = true := by decide +kernel

def env5659 : List Nat := [2,4,8,16,32,64,89,256,80,1024,2048,1370,8192,1291,8519,8209,1345,2414,1025,8519,1370,10541,10,82,8272,91,8518,1291,1297,8233,1284,4294967296,256,4294977805,1345,81]

theorem envBound5659 : H12AffineFastState.Bounded env5659 := by
  intro p hp
  have h : env5659.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5653_5659 : H12AffineEnvironment.transform 21 10541 env5653 = env5659 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10541 env5653 == env5659) = true)

theorem identity5659 : scanCanonicalize (H12AffineFastState.compose env5659 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 110) := by decide +kernel

theorem selectedBound5659 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5660 : List Nat := [2,4,8,16,32,64,89,110,80,1024,2048,1076,8192,1125,8233,8209,1071,2048,1025,8233,1076,10307,10,82,8272,91,8232,1125,1151,8233,1130,4294967296,110,4294977635,1071,81]

theorem envBound5660 : H12AffineFastState.Bounded env5660 := by
  intro p hp
  have h : env5660.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5659_5660 : H12AffineEnvironment.transform 7 110 env5659 = env5660 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 110 env5659 == env5660) = true)

theorem identity5660 : scanCanonicalize (H12AffineFastState.compose env5660 (packedSelected [2,4] rootPS)) = affineNative (2^(12+1) ^^^ 2089) := by decide +kernel

theorem selectedBound5660 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env5661 : List Nat := [2,4,8,16,32,64,89,110,80,1024,2048,1076,2089,1125,2048,2104,1071,2048,1025,2048,1076,106,10,82,2169,91,2049,1125,1151,2048,1130,4294967296,110,4294967370,1071,81]

theorem envBound5661 : H12AffineFastState.Bounded env5661 := by
  intro p hp
  have h : env5661.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5660_5661 : H12AffineEnvironment.transform 12 2089 env5660 = env5661 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2089 env5660 == env5661) = true)

theorem identity5661 : scanCanonicalize (H12AffineFastState.compose env5661 (packedSelected [3] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound5661 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env5662 : List Nat := [2,4,8,16,32,10,19,36,26,1024,2048,1076,2089,1071,2048,2104,1071,2048,1025,2048,1076,32,10,24,2099,17,2049,1071,1077,2048,1056,4294967296,36,4294967296,1071,27]

theorem envBound5662 : H12AffineFastState.Bounded env5662 := by
  intro p hp
  have h : env5662.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5661_5662 : H12AffineEnvironment.transform 5 10 env5661 = env5662 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env5661 == env5662) = true)

theorem identity5662 : scanCanonicalize (H12AffineFastState.compose env5662 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 42) := by decide +kernel

theorem selectedBound5662 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5663 : List Nat := [2,4,8,16,32,10,19,36,26,1024,2048,1076,2089,1071,2048,2104,1071,2048,1025,2048,1076,32,10,24,2099,17,2049,1071,1077,2048,1056,42,36,42,1071,27]

theorem envBound5663 : H12AffineFastState.Bounded env5663 := by
  intro p hp
  have h : env5663.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5662_5663 : H12AffineEnvironment.transform 31 42 env5662 = env5663 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 42 env5662 == env5663) = true)

def leafEnv5663 : List Nat := [2,4,8,16,32,10,19,36,26,1024,2048,1076,2089,1071,2048,2104,1071,2048,1025,2048,1076,32,10,24,1057,2099,1,17,2049,1071,1077,2048,1056,42,36,42,4,2083,1071,27,0,1077,1]

def active5663 : List Nat := [0,1,2,3,4,9,10]

def tree5663 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5663 : H12WitnessSearch.Good tree5663 := H12GlobalWitnessIndex.good

theorem leafIdentity5663 : H12AffineFastState.composeSystem env5663 rootObs = leafEnv5663 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5663 rootObs == leafEnv5663) = true)

theorem terminalChecked5663 : H12PackedTerminal.terminalCheckFast leafEnv5663 active5663 tree5663 = true := by decide +kernel

def env5664 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4097,4194304,17665,16777216,33554432,67108864,4477269,67130625,16876565,1073741824,1284,4294967296,16875524,4417151347,1345,33563272]

theorem envBound5664 : H12AffineFastState.Bounded env5664 := by
  intro p hp
  have h : env5664.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5268_5664 : H12AffineEnvironment.transform 20 4097 env5268 = env5664 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env5268 == env5664) = true)

theorem identity5664 : scanCanonicalize (H12AffineFastState.compose env5664 (packedSelected [35] rootPS)) = affineNative (2^(23+1) ^^^ 98564) := by decide +kernel

theorem selectedBound5664 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env5665 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4097,4194304,17665,98564,33554432,67108864,4477269,67130625,1297,1073741824,1284,4294967296,256,4400472183,1345,33563272]

theorem envBound5665 : H12AffineFastState.Bounded env5665 := by
  intro p hp
  have h : env5665.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5664_5665 : H12AffineEnvironment.transform 23 98564 env5664 = env5665 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98564 env5664 == env5665) = true)

def env5666 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4097,4194304,17665,98564,33554432,5376,4477269,16385,1297,1073741824,1284,4294967296,256,4333368695,1345,33563272]

theorem envBound5666 : H12AffineFastState.Bounded env5666 := by
  intro p hp
  have h : env5666.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5665_5666 : H12AffineEnvironment.transform 25 5376 env5665 = env5666 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env5665 == env5666) = true)

theorem identity5666 : scanCanonicalize (H12AffineFastState.compose env5666 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(24+1) ^^^ 554201) := by decide +kernel

theorem selectedBound5666 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env5667 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4097,4194304,17665,98564,554201,5376,4477269,16385,1297,1073741824,1284,4294967296,256,4299260334,1345,546385]

theorem envBound5667 : H12AffineFastState.Bounded env5667 := by
  intro p hp
  have h : env5667.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5666_5667 : H12AffineEnvironment.transform 24 554201 env5666 = env5667 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 554201 env5666 == env5667) = true)

theorem identity5667 : scanCanonicalize (H12AffineFastState.compose env5667 (packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS)) = affineNative (2^(29+1) ^^^ 4840667) := by decide +kernel

theorem selectedBound5667 : packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS < 2^1333 := by decide +kernel

def env5668 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4097,4194304,17665,98564,554201,5376,4477269,16385,1297,4840667,1284,4294967296,256,4299260334,1345,546385]

theorem envBound5668 : H12AffineFastState.Bounded env5668 := by
  intro p hp
  have h : env5668.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5667_5668 : H12AffineEnvironment.transform 29 4840667 env5667 = env5668 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4840667 env5667 == env5668) = true)

theorem identity5668 : scanCanonicalize (H12AffineFastState.compose env5668 (packedSelected [6,25] rootPS)) = affineNative (2^(18+1) ^^^ 21585) := by decide +kernel

theorem selectedBound5668 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env5669 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,21585,32768,4097,4194304,17665,98564,8328,5376,4477269,16385,1297,4294794,1284,4294967296,256,4299260334,1345,512]

theorem envBound5669 : H12AffineFastState.Bounded env5669 := by
  intro p hp
  have h : env5669.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5668_5669 : H12AffineEnvironment.transform 18 21585 env5668 = env5669 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 21585 env5668 == env5669) = true)

theorem identity5669 : scanCanonicalize (H12AffineFastState.compose env5669 (packedSelected [4,9,16] rootPS)) = affineNative (2^(21+1) ^^^ 396) := by decide +kernel

theorem selectedBound5669 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env5670 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,21585,32768,4097,396,17665,98564,8328,5376,282841,16385,1297,100614,1284,4294967296,256,4295065634,1345,512]

theorem envBound5670 : H12AffineFastState.Bounded env5670 := by
  intro p hp
  have h : env5670.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5669_5670 : H12AffineEnvironment.transform 21 396 env5669 = env5670 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 396 env5669 == env5670) = true)

theorem identity5670 : scanCanonicalize (H12AffineFastState.compose env5670 (packedSelected [0,7,20] rootPS)) = affineNative (2^(14+1) ^^^ 340) := by decide +kernel

theorem selectedBound5670 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env5671 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,340,65536,1345,262144,21585,340,4097,396,17665,65616,8328,5376,282841,16385,1297,67666,1284,4294967296,256,4295033206,1345,512]

theorem envBound5671 : H12AffineFastState.Bounded env5671 := by
  intro p hp
  have h : env5671.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5670_5671 : H12AffineEnvironment.transform 14 340 env5670 = env5671 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 340 env5670 == env5671) = true)

theorem identity5671 : scanCanonicalize (H12AffineFastState.compose env5671 (packedSelected [1,5,10,12,15,17,21] rootPS)) = affineNative (2^(31+1) ^^^ 77931) := by decide +kernel

theorem selectedBound5671 : packedSelected [1,5,10,12,15,17,21] rootPS < 2^1333 := by decide +kernel

def env5672 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,340,65536,1345,262144,21585,340,4097,396,17665,65616,8328,5376,282841,16385,1297,67666,1284,77931,256,12573,1345,512]

theorem envBound5672 : H12AffineFastState.Bounded env5672 := by
  intro p hp
  have h : env5672.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5671_5672 : H12AffineEnvironment.transform 31 77931 env5671 = env5672 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 77931 env5671 == env5672) = true)

theorem identity5672 : scanCanonicalize (H12AffineFastState.compose env5672 (packedSelected [9,22] rootPS)) = affineNative (2^(13+1) ^^^ 12297) := by decide +kernel

theorem selectedBound5672 : packedSelected [9,22] rootPS < 2^1333 := by decide +kernel

def env5673 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,12297,340,65536,1345,262144,9304,340,4097,396,13576,65616,8328,5376,270544,12296,1297,67666,1284,77931,256,12573,1345,512]

theorem envBound5673 : H12AffineFastState.Bounded env5673 := by
  intro p hp
  have h : env5673.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5672_5673 : H12AffineEnvironment.transform 13 12297 env5672 = env5673 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 12297 env5672 == env5673) = true)

theorem identity5673 : scanCanonicalize (H12AffineFastState.compose env5673 (packedSelected [3,6,8,10,13,17] rootPS)) = affineNative (2^(12+1) ^^^ 1116) := by decide +kernel

theorem selectedBound5673 : packedSelected [3,6,8,10,13,17] rootPS < 2^1333 := by decide +kernel

def env5674 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,1116,5205,340,65536,1345,262144,4,340,4097,396,4436,65616,1236,5376,263308,5204,1297,67666,1284,70711,256,5441,1345,512]

theorem envBound5674 : H12AffineFastState.Bounded env5674 := by
  intro p hp
  have h : env5674.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5673_5674 : H12AffineEnvironment.transform 12 1116 env5673 = env5674 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1116 env5673 == env5674) = true)

theorem identity5674 : scanCanonicalize (H12AffineFastState.compose env5674 (packedSelected [3,5,6,8,10,13,15,24] rootPS)) = affineNative (2^(11+1) ^^^ 1345) := by decide +kernel

theorem selectedBound5674 : packedSelected [3,5,6,8,10,13,15,24] rootPS < 2^1333 := by decide +kernel

def env5675 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1345,1116,276,340,65536,1345,262144,4,340,1344,396,1045,65616,1236,65,263308,277,1297,67666,1284,65910,256,0,1345,512]

theorem envBound5675 : H12AffineFastState.Bounded env5675 := by
  intro p hp
  have h : env5675.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5674_5675 : H12AffineEnvironment.transform 11 1345 env5674 = env5675 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1345 env5674 == env5675) = true)

theorem identity5675 : scanCanonicalize (H12AffineFastState.compose env5675 (packedSelected [1,3,5,10,12,13] rootPS)) = affineNative (2^(17+1) ^^^ 67164) := by decide +kernel

theorem selectedBound5675 : packedSelected [1,3,5,10,12,13] rootPS < 2^1333 := by decide +kernel

def env5676 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1345,1116,276,340,65536,1345,67164,4,340,1344,396,1045,65616,1236,65,66256,277,1297,67666,1284,65910,256,0,1345,512]

theorem envBound5676 : H12AffineFastState.Bounded env5676 := by
  intro p hp
  have h : env5676.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5675_5676 : H12AffineEnvironment.transform 17 67164 env5675 = env5676 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 67164 env5675 == env5676) = true)

theorem identity5676 : scanCanonicalize (H12AffineFastState.compose env5676 (packedSelected [0,27] rootPS)) = affineNative (2^(9+1) ^^^ 4) := by decide +kernel

theorem selectedBound5676 : packedSelected [0,27] rootPS < 2^1333 := by decide +kernel

def env5677 : List Nat := [2,4,8,16,32,64,128,256,512,4,2048,325,88,276,340,65536,325,66136,4,340,324,396,17,65616,208,65,66256,277,277,67666,256,65910,256,0,325,512]

theorem envBound5677 : H12AffineFastState.Bounded env5677 := by
  intro p hp
  have h : env5677.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5676_5677 : H12AffineEnvironment.transform 9 4 env5676 = env5677 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 4 env5676 == env5677) = true)

def env5678 : List Nat := [2,4,8,16,32,64,8,256,512,4,2048,325,88,276,340,65536,325,66136,4,340,324,260,17,65616,88,65,66136,277,277,67666,256,65910,256,0,325,512]

theorem envBound5678 : H12AffineFastState.Bounded env5678 := by
  intro p hp
  have h : env5678.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5677_5678 : H12AffineEnvironment.transform 6 8 env5677 = env5678 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env5677 == env5678) = true)

theorem identity5678 : scanCanonicalize (H12AffineFastState.compose env5678 (packedSelected [7] rootPS)) = affineNative (2^(8+1) ^^^ 268) := by decide +kernel

theorem selectedBound5678 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env5679 : List Nat := [2,4,8,16,32,64,8,256,268,4,2048,325,88,276,340,65536,325,65876,4,340,324,260,17,65616,88,65,65876,277,277,67666,256,65910,256,0,325,268]

theorem envBound5679 : H12AffineFastState.Bounded env5679 := by
  intro p hp
  have h : env5679.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5678_5679 : H12AffineEnvironment.transform 8 268 env5678 = env5679 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 268 env5678 == env5679) = true)

def env5680 : List Nat := [2,4,8,16,32,64,8,256,268,4,0,325,88,276,340,65536,325,65876,4,340,324,260,17,65616,88,65,65876,277,277,65618,256,65910,256,0,325,268]

theorem envBound5680 : H12AffineFastState.Bounded env5680 := by
  intro p hp
  have h : env5680.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5679_5680 : H12AffineEnvironment.transform 10 0 env5679 = env5680 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env5679 == env5680) = true)

theorem identity5680 : scanCanonicalize (H12AffineFastState.compose env5680 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 2) := by decide +kernel

theorem selectedBound5680 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5681 : List Nat := [2,4,8,16,2,64,8,256,268,4,0,325,88,276,340,65536,325,65876,4,340,324,260,17,65616,88,65,65876,277,277,65618,256,65876,256,0,325,268]

theorem envBound5681 : H12AffineFastState.Bounded env5681 := by
  intro p hp
  have h : env5681.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5680_5681 : H12AffineEnvironment.transform 4 2 env5680 = env5681 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 2 env5680 == env5681) = true)

theorem identity5681 : scanCanonicalize (H12AffineFastState.compose env5681 (packedSelected [18,23] rootPS)) = affineNative (2^(15+1) ^^^ 82) := by decide +kernel

theorem selectedBound5681 : packedSelected [18,23] rootPS < 2^1333 := by decide +kernel

def env5682 : List Nat := [2,4,8,16,2,64,8,256,268,4,0,325,88,276,340,82,325,262,4,340,324,260,17,2,88,65,262,277,277,0,256,262,256,0,325,268]

theorem envBound5682 : H12AffineFastState.Bounded env5682 := by
  intro p hp
  have h : env5682.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5681_5682 : H12AffineEnvironment.transform 15 82 env5681 = env5682 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 82 env5681 == env5682) = true)

def env5683 : List Nat := [2,4,8,16,2,16,8,256,268,4,0,277,8,276,260,2,277,262,4,260,276,260,17,2,8,17,262,277,277,0,256,262,256,0,277,268]

theorem envBound5683 : H12AffineFastState.Bounded env5683 := by
  intro p hp
  have h : env5683.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5682_5683 : H12AffineEnvironment.transform 5 16 env5682 = env5683 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env5682 == env5683) = true)

theorem identity5683 : scanCanonicalize (H12AffineFastState.compose env5683 (packedSelected [1] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5683 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5684 : List Nat := [0,4,8,16,0,16,8,256,268,4,0,277,8,276,260,0,277,260,4,260,276,260,17,0,8,17,260,277,277,0,256,260,256,0,277,268]

theorem envBound5684 : H12AffineFastState.Bounded env5684 := by
  intro p hp
  have h : env5684.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5683_5684 : H12AffineEnvironment.transform 0 0 env5683 = env5684 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5683 == env5684) = true)

theorem identity5684 : scanCanonicalize (H12AffineFastState.compose env5684 (packedSelected [2] rootPS)) = affineNative (2^(7+1) ^^^ 12) := by decide +kernel

theorem selectedBound5684 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5685 : List Nat := [0,4,8,16,0,16,8,12,0,4,0,25,8,24,8,0,25,8,4,8,24,8,17,0,8,17,8,25,25,0,12,8,12,0,25,0]

theorem envBound5685 : H12AffineFastState.Bounded env5685 := by
  intro p hp
  have h : env5685.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5684_5685 : H12AffineEnvironment.transform 7 12 env5684 = env5685 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 12 env5684 == env5685) = true)

def leafEnv5685 : List Nat := [0,4,8,16,0,16,8,12,0,4,0,25,8,24,8,0,25,8,4,8,24,8,17,0,12,8,1,17,8,25,25,0,12,8,12,0,4,0,25,0,0,25,1]

def active5685 : List Nat := [1,2,3]

def tree5685 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5685 : H12WitnessSearch.Good tree5685 := H12GlobalWitnessIndex.good

theorem leafIdentity5685 : H12AffineFastState.composeSystem env5685 rootObs = leafEnv5685 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5685 rootObs == leafEnv5685) = true)

theorem terminalChecked5685 : H12PackedTerminal.terminalCheckFast leafEnv5685 active5685 tree5685 = true := by decide +kernel

def env5686 : List Nat := [2,4,8,16,2,17,8,256,268,4,0,276,9,276,261,3,276,262,4,261,277,260,17,2,9,16,262,277,277,0,256,262,256,0,276,268]

theorem envBound5686 : H12AffineFastState.Bounded env5686 := by
  intro p hp
  have h : env5686.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5682_5686 : H12AffineEnvironment.transform 5 17 env5682 = env5686 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env5682 == env5686) = true)

theorem identity5686 : scanCanonicalize (H12AffineFastState.compose env5686 (packedSelected [4] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound5686 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env5687 : List Nat := [2,4,3,16,2,17,3,256,263,4,0,276,2,276,261,3,276,262,4,261,277,260,17,2,2,16,262,277,277,0,256,262,256,0,276,263]

theorem envBound5687 : H12AffineFastState.Bounded env5687 := by
  intro p hp
  have h : env5687.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5686_5687 : H12AffineEnvironment.transform 2 3 env5686 = env5687 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env5686 == env5687) = true)

def env5688 : List Nat := [2,4,3,16,2,17,3,4,3,4,0,16,2,16,1,3,16,2,4,1,17,0,17,2,2,16,2,17,17,0,4,2,4,0,16,3]

theorem envBound5688 : H12AffineFastState.Bounded env5688 := by
  intro p hp
  have h : env5688.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5687_5688 : H12AffineEnvironment.transform 7 4 env5687 = env5688 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env5687 == env5688) = true)

theorem identity5688 : scanCanonicalize (H12AffineFastState.compose env5688 (packedSelected [2] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound5688 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5689 : List Nat := [1,4,0,16,1,17,0,4,0,4,0,16,1,16,1,0,16,1,4,1,17,0,17,1,1,16,1,17,17,0,4,1,4,0,16,0]

theorem envBound5689 : H12AffineFastState.Bounded env5689 := by
  intro p hp
  have h : env5689.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5688_5689 : H12AffineEnvironment.transform 0 1 env5688 = env5689 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env5688 == env5689) = true)

def leafEnv5689 : List Nat := [1,4,0,16,1,17,0,4,0,4,0,16,1,16,1,0,16,1,4,1,17,0,17,1,4,1,1,16,1,17,17,0,4,1,4,0,4,0,16,0,0,17,1]

def active5689 : List Nat := [1,3]

def tree5689 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5689 : H12WitnessSearch.Good tree5689 := H12GlobalWitnessIndex.good

theorem leafIdentity5689 : H12AffineFastState.composeSystem env5689 rootObs = leafEnv5689 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5689 rootObs == leafEnv5689) = true)

theorem terminalChecked5689 : H12PackedTerminal.terminalCheckFast leafEnv5689 active5689 tree5689 = true := by decide +kernel

def env5690 : List Nat := [2,4,3,16,2,17,3,5,2,4,0,17,2,17,0,3,17,3,4,0,16,1,17,2,2,16,3,16,16,0,5,3,5,0,17,2]

theorem envBound5690 : H12AffineFastState.Bounded env5690 := by
  intro p hp
  have h : env5690.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5687_5690 : H12AffineEnvironment.transform 7 5 env5687 = env5690 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env5687 == env5690) = true)

def leafEnv5690 : List Nat := [2,4,3,16,2,17,3,5,2,4,0,17,2,17,0,3,17,3,4,0,16,1,17,2,5,2,1,16,3,16,16,0,5,3,5,0,4,3,17,2,0,16,1]

def active5690 : List Nat := [0,1,3]

def tree5690 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5690 : H12WitnessSearch.Good tree5690 := H12GlobalWitnessIndex.good

theorem leafIdentity5690 : H12AffineFastState.composeSystem env5690 rootObs = leafEnv5690 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5690 rootObs == leafEnv5690) = true)

theorem terminalChecked5690 : H12PackedTerminal.terminalCheckFast leafEnv5690 active5690 tree5690 = true := by decide +kernel

def env5691 : List Nat := [2,4,8,16,32,64,8,256,268,4,1,325,88,276,340,65536,325,65876,4,340,324,260,17,65616,88,65,65876,277,277,65619,256,65910,256,0,325,268]

theorem envBound5691 : H12AffineFastState.Bounded env5691 := by
  intro p hp
  have h : env5691.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5679_5691 : H12AffineEnvironment.transform 10 1 env5679 = env5691 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env5679 == env5691) = true)

theorem identity5691 : scanCanonicalize (H12AffineFastState.compose env5691 (packedSelected [0] rootPS)) = affineNative (2^(15+1) ^^^ 113) := by decide +kernel

theorem selectedBound5691 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5692 : List Nat := [2,4,8,16,32,64,8,256,268,4,1,325,88,276,340,113,325,293,4,340,324,260,17,33,88,65,293,277,277,34,256,263,256,0,325,268]

theorem envBound5692 : H12AffineFastState.Bounded env5692 := by
  intro p hp
  have h : env5692.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5691_5692 : H12AffineEnvironment.transform 15 113 env5691 = env5692 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 113 env5691 == env5692) = true)

theorem identity5692 : scanCanonicalize (H12AffineFastState.compose env5692 (packedSelected [11,32] rootPS)) = affineNative (2^(4+1) ^^^ 3) := by decide +kernel

theorem selectedBound5692 : packedSelected [11,32] rootPS < 2^1333 := by decide +kernel

def env5693 : List Nat := [2,4,8,16,3,64,8,256,268,4,1,325,88,276,340,82,325,262,4,340,324,260,17,2,88,65,262,277,277,1,256,263,256,0,325,268]

theorem envBound5693 : H12AffineFastState.Bounded env5693 := by
  intro p hp
  have h : env5693.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5692_5693 : H12AffineEnvironment.transform 4 3 env5692 = env5693 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 3 env5692 == env5693) = true)

def env5694 : List Nat := [2,4,8,16,3,16,8,256,268,4,1,277,8,276,260,2,277,262,4,260,276,260,17,2,8,17,262,277,277,1,256,263,256,0,277,268]

theorem envBound5694 : H12AffineFastState.Bounded env5694 := by
  intro p hp
  have h : env5694.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5693_5694 : H12AffineEnvironment.transform 5 16 env5693 = env5694 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env5693 == env5694) = true)

theorem identity5694 : scanCanonicalize (H12AffineFastState.compose env5694 (packedSelected [1] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5694 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5695 : List Nat := [0,4,8,16,1,16,8,256,268,4,1,277,8,276,260,0,277,260,4,260,276,260,17,0,8,17,260,277,277,1,256,261,256,0,277,268]

theorem envBound5695 : H12AffineFastState.Bounded env5695 := by
  intro p hp
  have h : env5695.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5694_5695 : H12AffineEnvironment.transform 0 0 env5694 = env5695 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5694 == env5695) = true)

theorem identity5695 : scanCanonicalize (H12AffineFastState.compose env5695 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 0) := by decide +kernel

theorem selectedBound5695 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5696 : List Nat := [0,4,0,16,1,16,0,256,260,4,1,277,0,276,260,0,277,260,4,260,276,260,17,0,0,17,260,277,277,1,256,261,256,0,277,260]

theorem envBound5696 : H12AffineFastState.Bounded env5696 := by
  intro p hp
  have h : env5696.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5695_5696 : H12AffineEnvironment.transform 2 0 env5695 = env5696 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env5695 == env5696) = true)

def leafEnv5696 : List Nat := [0,4,0,16,1,16,0,256,260,4,1,277,0,276,260,0,277,260,4,260,276,260,17,0,256,0,1,17,260,277,277,1,256,261,256,0,4,0,277,260,0,277,1]

def active5696 : List Nat := [1,3,7]

def tree5696 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5696 : H12WitnessSearch.Good tree5696 := H12GlobalWitnessIndex.good

theorem leafIdentity5696 : H12AffineFastState.composeSystem env5696 rootObs = leafEnv5696 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5696 rootObs == leafEnv5696) = true)

theorem terminalChecked5696 : H12PackedTerminal.terminalCheckFast leafEnv5696 active5696 tree5696 = true := by decide +kernel

def env5697 : List Nat := [2,4,8,16,3,17,8,256,268,4,1,276,9,276,261,3,276,262,4,261,277,260,17,2,9,16,262,277,277,1,256,263,256,0,276,268]

theorem envBound5697 : H12AffineFastState.Bounded env5697 := by
  intro p hp
  have h : env5697.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5693_5697 : H12AffineEnvironment.transform 5 17 env5693 = env5697 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env5693 == env5697) = true)

theorem identity5697 : scanCanonicalize (H12AffineFastState.compose env5697 (packedSelected [4] rootPS)) = affineNative (2^(7+1) ^^^ 12) := by decide +kernel

theorem selectedBound5697 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env5698 : List Nat := [2,4,8,16,3,17,8,12,0,4,1,24,9,24,9,3,24,10,4,9,25,8,17,2,9,16,10,25,25,1,12,11,12,0,24,0]

theorem envBound5698 : H12AffineFastState.Bounded env5698 := by
  intro p hp
  have h : env5698.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5697_5698 : H12AffineEnvironment.transform 7 12 env5697 = env5698 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 12 env5697 == env5698) = true)

def env5699 : List Nat := [2,4,0,16,3,17,0,4,0,4,1,16,1,16,1,3,16,2,4,1,17,0,17,2,1,16,2,17,17,1,4,3,4,0,16,0]

theorem envBound5699 : H12AffineFastState.Bounded env5699 := by
  intro p hp
  have h : env5699.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5698_5699 : H12AffineEnvironment.transform 2 0 env5698 = env5699 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env5698 == env5699) = true)

def leafEnv5699 : List Nat := [2,4,0,16,3,17,0,4,0,4,1,16,1,16,1,3,16,2,4,1,17,0,17,2,4,1,1,16,2,17,17,1,4,3,4,0,4,3,16,0,0,17,1]

def active5699 : List Nat := [0,1,3]

def tree5699 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5699 : H12WitnessSearch.Good tree5699 := H12GlobalWitnessIndex.good

theorem leafIdentity5699 : H12AffineFastState.composeSystem env5699 rootObs = leafEnv5699 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5699 rootObs == leafEnv5699) = true)

theorem terminalChecked5699 : H12PackedTerminal.terminalCheckFast leafEnv5699 active5699 tree5699 = true := by decide +kernel

def env5700 : List Nat := [2,4,1,16,3,17,1,5,0,4,1,17,0,17,0,3,17,3,4,0,16,1,17,2,0,16,3,16,16,1,5,2,5,0,17,0]

theorem envBound5700 : H12AffineFastState.Bounded env5700 := by
  intro p hp
  have h : env5700.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5698_5700 : H12AffineEnvironment.transform 2 1 env5698 = env5700 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env5698 == env5700) = true)

theorem identity5700 : scanCanonicalize (H12AffineFastState.compose env5700 (packedSelected [2] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound5700 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5701 : List Nat := [1,4,1,16,0,17,1,5,0,4,1,17,0,17,0,0,17,0,4,0,16,1,17,1,0,16,0,16,16,1,5,1,5,0,17,0]

theorem envBound5701 : H12AffineFastState.Bounded env5701 := by
  intro p hp
  have h : env5701.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5700_5701 : H12AffineEnvironment.transform 0 1 env5700 = env5701 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env5700 == env5701) = true)

def leafEnv5701 : List Nat := [1,4,1,16,0,17,1,5,0,4,1,17,0,17,0,0,17,0,4,0,16,1,17,1,5,0,1,16,0,16,16,1,5,1,5,0,4,0,17,0,0,16,1]

def active5701 : List Nat := [1,3]

def tree5701 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5701 : H12WitnessSearch.Good tree5701 := H12GlobalWitnessIndex.good

theorem leafIdentity5701 : H12AffineFastState.composeSystem env5701 rootObs = leafEnv5701 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5701 rootObs == leafEnv5701) = true)

theorem terminalChecked5701 : H12PackedTerminal.terminalCheckFast leafEnv5701 active5701 tree5701 = true := by decide +kernel

def env5702 : List Nat := [2,4,8,16,32,64,9,256,512,4,2048,325,88,276,340,65536,325,66136,4,340,324,261,17,65616,89,65,66137,277,277,67666,256,65910,256,0,325,512]

theorem envBound5702 : H12AffineFastState.Bounded env5702 := by
  intro p hp
  have h : env5702.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5677_5702 : H12AffineEnvironment.transform 6 9 env5677 = env5702 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env5677 == env5702) = true)

theorem identity5702 : scanCanonicalize (H12AffineFastState.compose env5702 (packedSelected [7] rootPS)) = affineNative (2^(15+1) ^^^ 1) := by decide +kernel

theorem selectedBound5702 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env5703 : List Nat := [2,4,8,16,32,64,9,256,512,4,2048,325,88,276,340,1,325,601,4,340,324,261,17,81,89,65,600,277,277,2131,256,375,256,0,325,512]

theorem envBound5703 : H12AffineFastState.Bounded env5703 := by
  intro p hp
  have h : env5703.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5702_5703 : H12AffineEnvironment.transform 15 1 env5702 = env5703 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 1 env5702 == env5703) = true)

def env5704 : List Nat := [2,4,8,16,32,64,9,256,512,4,0,325,88,276,340,1,325,601,4,340,324,261,17,81,89,65,600,277,277,83,256,375,256,0,325,512]

theorem envBound5704 : H12AffineFastState.Bounded env5704 := by
  intro p hp
  have h : env5704.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5703_5704 : H12AffineEnvironment.transform 10 0 env5703 = env5704 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env5703 == env5704) = true)

theorem identity5704 : scanCanonicalize (H12AffineFastState.compose env5704 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 118) := by decide +kernel

theorem selectedBound5704 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5705 : List Nat := [2,4,8,16,32,64,9,118,512,4,0,51,88,98,34,1,51,601,4,34,50,115,17,81,89,65,600,99,99,83,118,1,118,0,51,512]

theorem envBound5705 : H12AffineFastState.Bounded env5705 := by
  intro p hp
  have h : env5705.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5704_5705 : H12AffineEnvironment.transform 7 118 env5704 = env5705 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 118 env5704 == env5705) = true)

theorem identity5705 : scanCanonicalize (H12AffineFastState.compose env5705 (packedSelected [2,4] rootPS)) = affineNative (2^(8+1) ^^^ 11) := by decide +kernel

theorem selectedBound5705 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env5706 : List Nat := [2,4,8,16,32,64,9,118,11,4,0,51,88,98,34,1,51,82,4,34,50,115,17,81,89,65,83,99,99,83,118,1,118,0,51,11]

theorem envBound5706 : H12AffineFastState.Bounded env5706 := by
  intro p hp
  have h : env5706.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5705_5706 : H12AffineEnvironment.transform 8 11 env5705 = env5706 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 11 env5705 == env5706) = true)

theorem identity5706 : scanCanonicalize (H12AffineFastState.compose env5706 (packedSelected [2,9] rootPS)) = affineNative (2^(5+1) ^^^ 18) := by decide +kernel

theorem selectedBound5706 : packedSelected [2,9] rootPS < 2^1333 := by decide +kernel

def env5707 : List Nat := [2,4,8,16,32,18,9,36,11,4,0,51,10,48,34,1,51,0,4,34,50,33,17,3,11,19,1,49,49,1,36,1,36,0,51,11]

theorem envBound5707 : H12AffineFastState.Bounded env5707 := by
  intro p hp
  have h : env5707.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5706_5707 : H12AffineEnvironment.transform 5 18 env5706 = env5707 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 18 env5706 == env5707) = true)

theorem identity5707 : scanCanonicalize (H12AffineFastState.compose env5707 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound5707 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5708 : List Nat := [2,4,2,16,32,18,3,36,1,4,0,51,0,48,34,1,51,0,4,34,50,33,17,3,1,19,1,49,49,1,36,1,36,0,51,1]

theorem envBound5708 : H12AffineFastState.Bounded env5708 := by
  intro p hp
  have h : env5708.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5707_5708 : H12AffineEnvironment.transform 2 2 env5707 = env5708 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env5707 == env5708) = true)

theorem identity5708 : scanCanonicalize (H12AffineFastState.compose env5708 (packedSelected [1,3] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound5708 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5709 : List Nat := [1,4,1,16,32,17,0,36,1,4,0,48,0,48,33,1,48,0,4,33,49,33,17,0,1,16,1,49,49,1,36,1,36,0,48,1]

theorem envBound5709 : H12AffineFastState.Bounded env5709 := by
  intro p hp
  have h : env5709.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5708_5709 : H12AffineEnvironment.transform 0 1 env5708 = env5709 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env5708 == env5709) = true)

def leafEnv5709 : List Nat := [1,4,1,16,32,17,0,36,1,4,0,48,0,48,33,1,48,0,4,33,49,33,17,0,36,1,1,16,1,49,49,1,36,1,36,0,4,0,48,1,0,49,1]

def active5709 : List Nat := [1,3,4]

def tree5709 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5709 : H12WitnessSearch.Good tree5709 := H12GlobalWitnessIndex.good

theorem leafIdentity5709 : H12AffineFastState.composeSystem env5709 rootObs = leafEnv5709 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5709 rootObs == leafEnv5709) = true)

theorem terminalChecked5709 : H12PackedTerminal.terminalCheckFast leafEnv5709 active5709 tree5709 = true := by decide +kernel

def env5710 : List Nat := [2,4,8,16,32,64,9,256,512,4,1,325,88,276,340,1,325,601,4,340,324,261,17,81,89,65,600,277,277,82,256,375,256,0,325,512]

theorem envBound5710 : H12AffineFastState.Bounded env5710 := by
  intro p hp
  have h : env5710.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5703_5710 : H12AffineEnvironment.transform 10 1 env5703 = env5710 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env5703 == env5710) = true)

theorem identity5710 : scanCanonicalize (H12AffineFastState.compose env5710 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound5710 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5711 : List Nat := [2,4,8,16,32,64,9,36,512,4,1,97,88,48,112,1,97,601,4,112,96,33,17,81,89,65,600,49,49,82,36,83,36,0,97,512]

theorem envBound5711 : H12AffineFastState.Bounded env5711 := by
  intro p hp
  have h : env5711.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5710_5711 : H12AffineEnvironment.transform 7 36 env5710 = env5711 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env5710 == env5711) = true)

theorem identity5711 : scanCanonicalize (H12AffineFastState.compose env5711 (packedSelected [2,5,8] rootPS)) = affineNative (2^(8+1) ^^^ 1) := by decide +kernel

theorem selectedBound5711 : packedSelected [2,5,8] rootPS < 2^1333 := by decide +kernel

def env5712 : List Nat := [2,4,8,16,32,64,9,36,1,4,1,97,88,48,112,1,97,88,4,112,96,33,17,81,89,65,89,49,49,82,36,83,36,0,97,1]

theorem envBound5712 : H12AffineFastState.Bounded env5712 := by
  intro p hp
  have h : env5712.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5711_5712 : H12AffineEnvironment.transform 8 1 env5711 = env5712 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 1 env5711 == env5712) = true)

theorem identity5712 : scanCanonicalize (H12AffineFastState.compose env5712 (packedSelected [2,4,11,23] rootPS)) = affineNative (2^(5+1) ^^^ 25) := by decide +kernel

theorem selectedBound5712 : packedSelected [2,4,11,23] rootPS < 2^1333 := by decide +kernel

def env5713 : List Nat := [2,4,8,16,32,25,9,36,1,4,1,56,1,48,41,1,56,1,4,41,57,33,17,8,0,24,0,49,49,11,36,10,36,0,56,1]

theorem envBound5713 : H12AffineFastState.Bounded env5713 := by
  intro p hp
  have h : env5713.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5712_5713 : H12AffineEnvironment.transform 5 25 env5712 = env5713 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 25 env5712 == env5713) = true)

theorem identity5713 : scanCanonicalize (H12AffineFastState.compose env5713 (packedSelected [11] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound5713 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env5714 : List Nat := [2,4,3,16,32,18,2,36,1,4,1,51,1,48,34,1,51,1,4,34,50,33,17,3,0,19,0,49,49,0,36,1,36,0,51,1]

theorem envBound5714 : H12AffineFastState.Bounded env5714 := by
  intro p hp
  have h : env5714.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5713_5714 : H12AffineEnvironment.transform 2 3 env5713 = env5714 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env5713 == env5714) = true)

theorem identity5714 : scanCanonicalize (H12AffineFastState.compose env5714 (packedSelected [1,3] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound5714 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5715 : List Nat := [1,4,0,16,32,17,1,36,1,4,1,48,1,48,33,1,48,1,4,33,49,33,17,0,0,16,0,49,49,0,36,1,36,0,48,1]

theorem envBound5715 : H12AffineFastState.Bounded env5715 := by
  intro p hp
  have h : env5715.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5714_5715 : H12AffineEnvironment.transform 0 1 env5714 = env5715 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env5714 == env5715) = true)

def leafEnv5715 : List Nat := [1,4,0,16,32,17,1,36,1,4,1,48,1,48,33,1,48,1,4,33,49,33,17,0,36,0,1,16,0,49,49,0,36,1,36,0,4,0,48,1,0,49,1]

def active5715 : List Nat := [1,3,4]

def tree5715 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5715 : H12WitnessSearch.Good tree5715 := H12GlobalWitnessIndex.good

theorem leafIdentity5715 : H12AffineFastState.composeSystem env5715 rootObs = leafEnv5715 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5715 rootObs == leafEnv5715) = true)

theorem terminalChecked5715 : H12PackedTerminal.terminalCheckFast leafEnv5715 active5715 tree5715 = true := by decide +kernel

def env5716 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4097,4194304,17665,98564,33554432,5377,4477269,16384,1297,1073741824,1284,4294967296,256,4333368694,1345,33563272]

theorem envBound5716 : H12AffineFastState.Bounded env5716 := by
  intro p hp
  have h : env5716.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5665_5716 : H12AffineEnvironment.transform 25 5377 env5665 = env5716 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env5665 == env5716) = true)

theorem identity5716 : scanCanonicalize (H12AffineFastState.compose env5716 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(24+1) ^^^ 8328) := by decide +kernel

theorem selectedBound5716 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env5717 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4097,4194304,17665,98564,8328,5377,4477269,16384,1297,1073741824,1284,4294967296,256,4299806206,1345,512]

theorem envBound5717 : H12AffineFastState.Bounded env5717 := by
  intro p hp
  have h : env5717.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5716_5717 : H12AffineEnvironment.transform 24 8328 env5716 = env5717 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8328 env5716 == env5717) = true)

theorem identity5717 : scanCanonicalize (H12AffineFastState.compose env5717 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(29+1) ^^^ 4279454) := by decide +kernel

theorem selectedBound5717 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env5718 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4097,4194304,17665,98564,8328,5377,4477269,16384,1297,4279454,1284,4294967296,256,4299806206,1345,512]

theorem envBound5718 : H12AffineFastState.Bounded env5718 := by
  intro p hp
  have h : env5718.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5717_5718 : H12AffineEnvironment.transform 29 4279454 env5717 = env5718 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4279454 env5717 == env5718) = true)

theorem identity5718 : scanCanonicalize (H12AffineFastState.compose env5718 (packedSelected [4,16,22] rootPS)) = affineNative (2^(21+1) ^^^ 13508) := by decide +kernel

theorem selectedBound5718 : packedSelected [4,16,22] rootPS < 2^1333 := by decide +kernel

def env5719 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4097,13508,17665,98564,8328,5377,288145,16384,1297,96346,1284,4294967296,256,4295614778,1345,512]

theorem envBound5719 : H12AffineFastState.Bounded env5719 := by
  intro p hp
  have h : env5719.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5718_5719 : H12AffineEnvironment.transform 21 13508 env5718 = env5719 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 13508 env5718 == env5719) = true)

theorem identity5719 : scanCanonicalize (H12AffineFastState.compose env5719 (packedSelected [5,15,17,24] rootPS)) = affineNative (2^(31+1) ^^^ 859234) := by decide +kernel

theorem selectedBound5719 : packedSelected [5,15,17,24] rootPS < 2^1333 := by decide +kernel

def env5720 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4097,13508,17665,98564,8328,5377,288145,16384,1297,96346,1284,859234,256,327000,1345,512]

theorem envBound5720 : H12AffineFastState.Bounded env5720 := by
  intro p hp
  have h : env5720.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5719_5720 : H12AffineEnvironment.transform 31 859234 env5719 = env5720 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 859234 env5719 == env5720) = true)

theorem identity5720 : scanCanonicalize (H12AffineFastState.compose env5720 (packedSelected [4,6,9,16,25] rootPS)) = affineNative (2^(18+1) ^^^ 24857) := by decide +kernel

theorem selectedBound5720 : packedSelected [4,6,9,16,25] rootPS < 2^1333 := by decide +kernel

def env5721 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,24857,32768,4097,13508,17665,98564,8328,5377,288145,16384,1297,96346,1284,359803,256,327000,1345,512]

theorem envBound5721 : H12AffineFastState.Bounded env5721 := by
  intro p hp
  have h : env5721.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5720_5721 : H12AffineEnvironment.transform 18 24857 env5720 = env5721 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 24857 env5720 == env5721) = true)

theorem identity5721 : scanCanonicalize (H12AffineFastState.compose env5721 (packedSelected [0,27] rootPS)) = affineNative (2^(14+1) ^^^ 5189) := by decide +kernel

theorem selectedBound5721 : packedSelected [0,27] rootPS < 2^1333 := by decide +kernel

def env5722 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,5189,65536,1345,262144,24857,5189,4097,13508,17665,70977,8328,5377,288145,16384,1297,96346,1284,359803,256,289053,1345,512]

theorem envBound5722 : H12AffineFastState.Bounded env5722 := by
  intro p hp
  have h : env5722.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5721_5722 : H12AffineEnvironment.transform 14 5189 env5721 = env5722 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 5189 env5721 == env5722) = true)

theorem identity5722 : scanCanonicalize (H12AffineFastState.compose env5722 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(13+1) ^^^ 15453) := by decide +kernel

theorem selectedBound5722 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env5723 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,15453,5189,65536,1345,262144,7492,5189,4097,13508,14684,70977,8328,5377,268748,15453,1297,66567,1284,327974,256,267584,1345,512]

theorem envBound5723 : H12AffineFastState.Bounded env5723 := by
  intro p hp
  have h : env5723.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5722_5723 : H12AffineEnvironment.transform 13 15453 env5722 = env5723 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 15453 env5722 == env5723) = true)

theorem identity5723 : scanCanonicalize (H12AffineFastState.compose env5723 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(12+1) ^^^ 3084) := by decide +kernel

theorem selectedBound5723 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env5724 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,3084,4177,5189,65536,1345,262144,7492,5189,4097,6344,5456,70977,3204,5377,268748,4177,1297,66567,1284,327974,256,267584,1345,512]

theorem envBound5724 : H12AffineFastState.Bounded env5724 := by
  intro p hp
  have h : env5724.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5723_5724 : H12AffineEnvironment.transform 12 3084 env5723 = env5724 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 3084 env5723 == env5724) = true)

theorem identity5724 : scanCanonicalize (H12AffineFastState.compose env5724 (packedSelected [6] rootPS)) = affineNative (2^(17+1) ^^^ 1281) := by decide +kernel

theorem selectedBound5724 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env5725 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,3084,4177,5189,65536,1345,1281,7492,5189,4097,6344,5456,70977,3204,5377,7373,4177,1297,66567,1284,66599,256,4161,1345,512]

theorem envBound5725 : H12AffineFastState.Bounded env5725 := by
  intro p hp
  have h : env5725.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5724_5725 : H12AffineEnvironment.transform 17 1281 env5724 = env5725 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1281 env5724 == env5725) = true)

def env5726 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,134217728,67130625,157794305,1073741824,140788817,4294967296,157663569,4417151347,131073,33563272]

theorem envBound5726 : H12AffineFastState.Bounded env5726 := by
  intro p hp
  have h : env5726.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5261_5726 : H12AffineEnvironment.transform 28 157794305 env5261 = env5726 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 28 157794305 env5261 == env5726) = true)

theorem identity5726 : scanCanonicalize (H12AffineFastState.compose env5726 (packedSelected [14] rootPS)) = affineNative (2^(26+1) ^^^ 4477269) := by decide +kernel

theorem selectedBound5726 : packedSelected [14] rootPS < 2^1333 := by decide +kernel

def env5727 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,4477269,67130625,19108180,1073741824,2102532,4294967296,18976772,4417151347,131073,33563272]

theorem envBound5727 : H12AffineFastState.Bounded env5727 := by
  intro p hp
  have h : env5727.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5726_5727 : H12AffineEnvironment.transform 26 4477269 env5726 = env5727 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 4477269 env5726 == env5727) = true)

def env5728 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,136512,4194304,17665,16777216,33554432,67108864,4477269,67130625,16876564,1073741824,131140,4294967296,17007940,4417151347,131073,33563272]

theorem envBound5728 : H12AffineFastState.Bounded env5728 := by
  intro p hp
  have h : env5728.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5727_5728 : H12AffineEnvironment.transform 20 136512 env5727 = env5728 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 136512 env5727 == env5728) = true)

def env5729 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,136512,4194304,17665,16777216,33554432,5376,4477269,16385,16876564,1073741824,131140,4294967296,17007940,4350047347,131073,33563272]

theorem envBound5729 : H12AffineFastState.Bounded env5729 := by
  intro p hp
  have h : env5729.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5728_5729 : H12AffineEnvironment.transform 25 5376 env5728 = env5729 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env5728 == env5729) = true)

theorem identity5729 : scanCanonicalize (H12AffineFastState.compose env5729 (packedSelected [35] rootPS)) = affineNative (2^(23+1) ^^^ 230468) := by decide +kernel

theorem selectedBound5729 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env5730 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,136512,4194304,17665,230468,33554432,5376,4477269,16385,131152,1073741824,131140,4294967296,256,4333498423,131073,33563272]

theorem envBound5730 : H12AffineFastState.Bounded env5730 := by
  intro p hp
  have h : env5730.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5729_5730 : H12AffineEnvironment.transform 23 230468 env5729 = env5730 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230468 env5729 == env5730) = true)

def env5731 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,131392,32768,136512,4194304,17665,230468,33554432,5376,4477269,16385,131152,1073741824,131140,4294967296,256,4332843383,131073,33563272]

theorem envBound5731 : H12AffineFastState.Bounded env5731 := by
  intro p hp
  have h : env5731.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5730_5731 : H12AffineEnvironment.transform 18 131392 env5730 = env5731 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 131392 env5730 == env5731) = true)

theorem identity5731 : scanCanonicalize (H12AffineFastState.compose env5731 (packedSelected [3,4,6,7,9,10,16,20,24,25,26,27] rootPS)) = affineNative (2^(29+1) ^^^ 37857283) := by decide +kernel

theorem selectedBound5731 : packedSelected [3,4,6,7,9,10,16,20,24,25,26,27] rootPS < 2^1333 := by decide +kernel

def env5732 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,131392,32768,136512,4194304,17665,230468,33554432,5376,4477269,16385,131152,37857283,131140,4294967296,256,4332843383,131073,33563272]

theorem envBound5732 : H12AffineFastState.Bounded env5732 := by
  intro p hp
  have h : env5732.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5731_5732 : H12AffineEnvironment.transform 29 37857283 env5731 = env5732 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 37857283 env5731 == env5732) = true)

theorem identity5732 : scanCanonicalize (H12AffineFastState.compose env5732 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(16+1) ^^^ 1344) := by decide +kernel

theorem selectedBound5732 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env5733 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,1024,32768,4096,4194304,17665,98564,33554432,5376,4477269,16385,1296,37857283,1284,4294967296,256,4332843383,1345,33563272]

theorem envBound5733 : H12AffineFastState.Bounded env5733 := by
  intro p hp
  have h : env5733.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5732_5733 : H12AffineEnvironment.transform 16 1344 env5732 = env5733 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env5732 == env5733) = true)

theorem identity5733 : scanCanonicalize (H12AffineFastState.compose env5733 (packedSelected [1,3,5,6,8,10,19,25] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound5733 : packedSelected [1,3,5,6,8,10,19,25] rootPS < 2^1333 := by decide +kernel

def env5734 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,1024,32768,4096,4194304,17665,98564,8329,5376,4477269,16385,1296,4294794,1284,4294967296,256,4299280894,1345,513]

theorem envBound5734 : H12AffineFastState.Bounded env5734 := by
  intro p hp
  have h : env5734.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5733_5734 : H12AffineEnvironment.transform 24 8329 env5733 = env5734 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env5733 == env5734) = true)

theorem identity5734 : scanCanonicalize (H12AffineFastState.compose env5734 (packedSelected [0,7,20] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound5734 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env5735 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,16384,32768,65536,1344,262144,1024,32768,4096,4194304,17665,98564,8329,5376,4477269,16385,1296,4294794,1284,4294967296,256,4299280894,1345,136]

theorem envBound5735 : H12AffineFastState.Bounded env5735 := by
  intro p hp
  have h : env5735.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5734_5735 : H12AffineEnvironment.transform 8 137 env5734 = env5735 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env5734 == env5735) = true)

theorem identity5735 : scanCanonicalize (H12AffineFastState.compose env5735 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(17+1) ^^^ 96759) := by decide +kernel

theorem selectedBound5735 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env5736 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,16384,32768,65536,1344,96759,1024,32768,4096,4194304,17665,98564,8329,5376,4270242,16385,1296,4294794,1284,4294967296,256,4299280894,1345,136]

theorem envBound5736 : H12AffineFastState.Bounded env5736 := by
  intro p hp
  have h : env5736.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5735_5736 : H12AffineEnvironment.transform 17 96759 env5735 = env5736 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 96759 env5735 == env5736) = true)

theorem identity5736 : scanCanonicalize (H12AffineFastState.compose env5736 (packedSelected [3,5,10,13,21] rootPS)) = affineNative (2^(13+1) ^^^ 4176) := by decide +kernel

theorem selectedBound5736 : packedSelected [3,5,10,13,21] rootPS < 2^1333 := by decide +kernel

def env5737 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4176,32768,65536,1344,76199,1024,32768,4096,4194304,5457,98564,8329,5376,4270242,4177,1296,4294794,1284,4294967296,256,4299260334,1345,136]

theorem envBound5737 : H12AffineFastState.Bounded env5737 := by
  intro p hp
  have h : env5737.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5736_5737 : H12AffineEnvironment.transform 13 4176 env5736 = env5737 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env5736 == env5737) = true)

theorem identity5737 : scanCanonicalize (H12AffineFastState.compose env5737 (packedSelected [1,3,8] rootPS)) = affineNative (2^(14+1) ^^^ 2297) := by decide +kernel

theorem selectedBound5737 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env5738 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4176,2297,65536,1344,76199,1024,2297,4096,4194304,5457,68093,8329,5376,4270242,4177,1296,4259955,1284,4294967296,256,4299229527,1345,136]

theorem envBound5738 : H12AffineFastState.Bounded env5738 := by
  intro p hp
  have h : env5738.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5737_5738 : H12AffineEnvironment.transform 14 2297 env5737 = env5738 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2297 env5737 == env5738) = true)

theorem identity5738 : scanCanonicalize (H12AffineFastState.compose env5738 (packedSelected [3,5,10] rootPS)) = affineNative (2^(21+1) ^^^ 477) := by decide +kernel

theorem selectedBound5738 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env5739 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4176,2297,65536,1344,76199,1024,2297,4096,477,5457,68093,8329,5376,76159,4177,1296,65966,1284,4294967296,256,4295035018,1345,136]

theorem envBound5739 : H12AffineFastState.Bounded env5739 := by
  intro p hp
  have h : env5739.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5738_5739 : H12AffineEnvironment.transform 21 477 env5738 = env5739 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 477 env5738 == env5739) = true)

theorem identity5739 : scanCanonicalize (H12AffineFastState.compose env5739 (packedSelected [1,12,13] rootPS)) = affineNative (2^(12+1) ^^^ 7397) := by decide +kernel

theorem selectedBound5739 : packedSelected [1,12,13] rootPS < 2^1333 := by decide +kernel

def env5740 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,7397,4176,2297,65536,1344,70978,1024,2297,4096,477,5457,68093,7276,5376,71066,4177,1296,65966,1284,4294967296,256,4295035018,1345,136]

theorem envBound5740 : H12AffineFastState.Bounded env5740 := by
  intro p hp
  have h : env5740.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5739_5740 : H12AffineEnvironment.transform 12 7397 env5739 = env5740 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 7397 env5739 == env5740) = true)

theorem identity5740 : scanCanonicalize (H12AffineFastState.compose env5740 (packedSelected [3,12] rootPS)) = affineNative (2^(10+1) ^^^ 261) := by decide +kernel

theorem selectedBound5740 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env5741 : List Nat := [2,4,8,16,32,64,128,256,137,1024,261,4096,5600,4176,508,65536,1344,70978,1024,508,4096,477,5457,65784,5481,5376,71066,4177,1296,65966,1284,4294967296,256,4295033231,1345,136]

theorem envBound5741 : H12AffineFastState.Bounded env5741 := by
  intro p hp
  have h : env5741.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5740_5741 : H12AffineEnvironment.transform 10 261 env5740 = env5741 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 261 env5740 == env5741) = true)

theorem identity5741 : scanCanonicalize (H12AffineFastState.compose env5741 (packedSelected [3,5,24] rootPS)) = affineNative (2^(15+1) ^^^ 114) := by decide +kernel

theorem selectedBound5741 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env5742 : List Nat := [2,4,8,16,32,64,128,256,137,1024,261,4096,5600,4176,508,114,1344,5424,1024,508,4096,477,5457,138,5481,5376,5608,4177,1296,476,1284,4294967296,256,4294967805,1345,136]

theorem envBound5742 : H12AffineFastState.Bounded env5742 := by
  intro p hp
  have h : env5742.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5741_5742 : H12AffineEnvironment.transform 15 114 env5741 = env5742 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 114 env5741 == env5742) = true)

def env5743 : List Nat := [2,4,8,16,32,64,128,256,137,1024,261,1296,240,1344,508,114,1344,32,1024,508,1296,477,65,138,121,16,248,1345,1296,476,1284,4294967296,256,4294967805,1345,136]

theorem envBound5743 : H12AffineFastState.Bounded env5743 := by
  intro p hp
  have h : env5743.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5742_5743 : H12AffineEnvironment.transform 11 1296 env5742 = env5743 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env5742 == env5743) = true)

theorem identity5743 : scanCanonicalize (H12AffineFastState.compose env5743 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 120) := by decide +kernel

theorem selectedBound5743 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5744 : List Nat := [2,4,8,16,32,64,120,256,113,1024,261,1296,8,1344,260,114,1344,32,1024,260,1296,293,65,114,121,16,0,1345,1296,292,1284,4294967296,256,4294967557,1345,112]

theorem envBound5744 : H12AffineFastState.Bounded env5744 := by
  intro p hp
  have h : env5744.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5743_5744 : H12AffineEnvironment.transform 6 120 env5743 = env5744 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 120 env5743 == env5744) = true)

theorem identity5744 : scanCanonicalize (H12AffineFastState.compose env5744 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 90) := by decide +kernel

theorem selectedBound5744 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5745 : List Nat := [2,4,8,16,32,64,120,256,113,1024,261,1296,8,1344,260,114,1344,32,1024,260,1296,293,65,114,121,16,0,1345,1296,292,1284,90,256,351,1345,112]

theorem envBound5745 : H12AffineFastState.Bounded env5745 := by
  intro p hp
  have h : env5745.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5744_5745 : H12AffineEnvironment.transform 31 90 env5744 = env5745 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 90 env5744 == env5745) = true)

theorem identity5745 : scanCanonicalize (H12AffineFastState.compose env5745 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound5745 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env5746 : List Nat := [2,4,8,16,0,64,88,256,81,1024,261,1296,8,1344,260,82,1344,0,1024,260,1296,261,65,82,89,16,0,1345,1296,260,1284,90,256,351,1345,80]

theorem envBound5746 : H12AffineFastState.Bounded env5746 := by
  intro p hp
  have h : env5746.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5745_5746 : H12AffineEnvironment.transform 4 0 env5745 = env5746 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5745 == env5746) = true)

theorem identity5746 : scanCanonicalize (H12AffineFastState.compose env5746 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound5746 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env5747 : List Nat := [2,4,8,16,0,64,88,5,81,1024,0,1045,8,1093,1,82,1093,0,1024,1,1045,0,65,82,89,16,0,1092,1045,1,1025,90,5,90,1092,80]

theorem envBound5747 : H12AffineFastState.Bounded env5747 := by
  intro p hp
  have h : env5747.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5746_5747 : H12AffineEnvironment.transform 7 5 env5746 = env5747 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env5746 == env5747) = true)

theorem identity5747 : scanCanonicalize (H12AffineFastState.compose env5747 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound5747 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5748 : List Nat := [2,4,8,16,0,11,19,5,26,1024,0,1045,8,1038,1,25,1038,0,1024,1,1045,0,10,25,18,16,0,1039,1045,1,1025,17,5,17,1039,27]

theorem envBound5748 : H12AffineFastState.Bounded env5748 := by
  intro p hp
  have h : env5748.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5747_5748 : H12AffineEnvironment.transform 5 11 env5747 = env5748 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env5747 == env5748) = true)

def leafEnv5748 : List Nat := [2,4,8,16,0,11,19,5,26,1024,0,1045,8,1038,1,25,1038,0,1024,1,1045,0,10,25,1025,18,1,16,0,1039,1045,1,1025,17,5,17,4,3,1039,27,0,1045,1]

def active5748 : List Nat := [0,1,2,3,9]

def tree5748 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5748 : H12WitnessSearch.Good tree5748 := H12GlobalWitnessIndex.good

theorem leafIdentity5748 : H12AffineFastState.composeSystem env5748 rootObs = leafEnv5748 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5748 rootObs == leafEnv5748) = true)

theorem terminalChecked5748 : H12PackedTerminal.terminalCheckFast leafEnv5748 active5748 tree5748 = true := by decide +kernel

def env5749 : List Nat := [2,4,8,16,32,64,128,256,137,1024,261,1297,241,1345,508,114,1344,33,1024,508,1297,477,64,138,120,17,249,1344,1296,476,1284,4294967296,256,4294967805,1345,136]

theorem envBound5749 : H12AffineFastState.Bounded env5749 := by
  intro p hp
  have h : env5749.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5742_5749 : H12AffineEnvironment.transform 11 1297 env5742 = env5749 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env5742 == env5749) = true)

theorem identity5749 : scanCanonicalize (H12AffineFastState.compose env5749 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound5749 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5750 : List Nat := [2,4,8,16,32,64,128,37,137,1024,32,1076,241,1124,217,114,1125,33,1024,217,1076,248,64,138,120,17,249,1125,1077,249,1057,4294967296,37,4294967512,1124,136]

theorem envBound5750 : H12AffineFastState.Bounded env5750 := by
  intro p hp
  have h : env5750.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5749_5750 : H12AffineEnvironment.transform 7 37 env5749 = env5750 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env5749 == env5750) = true)

theorem identity5750 : scanCanonicalize (H12AffineFastState.compose env5750 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 120) := by decide +kernel

theorem selectedBound5750 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env5751 : List Nat := [2,4,8,16,32,64,120,37,113,1024,32,1076,9,1124,33,114,1125,33,1024,33,1076,0,64,114,120,17,1,1125,1077,1,1057,4294967296,37,4294967328,1124,112]

theorem envBound5751 : H12AffineFastState.Bounded env5751 := by
  intro p hp
  have h : env5751.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5750_5751 : H12AffineEnvironment.transform 6 120 env5750 = env5751 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 120 env5750 == env5751) = true)

theorem identity5751 : scanCanonicalize (H12AffineFastState.compose env5751 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 43) := by decide +kernel

theorem selectedBound5751 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5752 : List Nat := [2,4,8,16,32,64,120,37,113,1024,32,1076,9,1124,33,114,1125,33,1024,33,1076,0,64,114,120,17,1,1125,1077,1,1057,43,37,11,1124,112]

theorem envBound5752 : H12AffineFastState.Bounded env5752 := by
  intro p hp
  have h : env5752.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5751_5752 : H12AffineEnvironment.transform 31 43 env5751 = env5752 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 43 env5751 == env5752) = true)

theorem identity5752 : scanCanonicalize (H12AffineFastState.compose env5752 (packedSelected [2,4] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound5752 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env5753 : List Nat := [2,4,8,16,0,64,88,5,81,1024,0,1044,9,1092,1,82,1093,1,1024,1,1044,0,64,82,88,17,1,1093,1045,1,1025,11,5,11,1092,80]

theorem envBound5753 : H12AffineFastState.Bounded env5753 := by
  intro p hp
  have h : env5753.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5752_5753 : H12AffineEnvironment.transform 4 0 env5752 = env5753 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5752 == env5753) = true)

theorem identity5753 : scanCanonicalize (H12AffineFastState.compose env5753 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound5753 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5754 : List Nat := [2,4,8,16,0,11,19,5,26,1024,0,1044,9,1039,1,25,1038,1,1024,1,1044,0,11,25,19,17,1,1038,1045,1,1025,11,5,11,1039,27]

theorem envBound5754 : H12AffineFastState.Bounded env5754 := by
  intro p hp
  have h : env5754.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5753_5754 : H12AffineEnvironment.transform 5 11 env5753 = env5754 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env5753 == env5754) = true)

def leafEnv5754 : List Nat := [2,4,8,16,0,11,19,5,26,1024,0,1044,9,1039,1,25,1038,1,1024,1,1044,0,11,25,1025,19,1,17,1,1038,1045,1,1025,11,5,11,4,3,1039,27,0,1045,1]

def active5754 : List Nat := [0,1,2,3,9]

def tree5754 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5754 : H12WitnessSearch.Good tree5754 := H12GlobalWitnessIndex.good

theorem leafIdentity5754 : H12AffineFastState.composeSystem env5754 rootObs = leafEnv5754 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5754 rootObs == leafEnv5754) = true)

theorem terminalChecked5754 : H12PackedTerminal.terminalCheckFast leafEnv5754 active5754 tree5754 = true := by decide +kernel

def env5755 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,131393,32768,136512,4194304,17665,230468,33554432,5376,4477269,16385,131152,1073741824,131140,4294967296,256,4332843382,131073,33563272]

theorem envBound5755 : H12AffineFastState.Bounded env5755 := by
  intro p hp
  have h : env5755.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5730_5755 : H12AffineEnvironment.transform 18 131393 env5730 = env5755 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 131393 env5730 == env5755) = true)

theorem identity5755 : scanCanonicalize (H12AffineFastState.compose env5755 (packedSelected [3,4,6,7,9,10,16,20,24,25,26,27] rootPS)) = affineNative (2^(29+1) ^^^ 37877842) := by decide +kernel

theorem selectedBound5755 : packedSelected [3,4,6,7,9,10,16,20,24,25,26,27] rootPS < 2^1333 := by decide +kernel

def env5756 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,131393,32768,136512,4194304,17665,230468,33554432,5376,4477269,16385,131152,37877842,131140,4294967296,256,4332843382,131073,33563272]

theorem envBound5756 : H12AffineFastState.Bounded env5756 := by
  intro p hp
  have h : env5756.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5755_5756 : H12AffineEnvironment.transform 29 37877842 env5755 = env5756 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 37877842 env5755 == env5756) = true)

theorem identity5756 : scanCanonicalize (H12AffineFastState.compose env5756 (packedSelected [1,6,19,25,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound5756 : packedSelected [1,6,19,25,28,31] rootPS < 2^1333 := by decide +kernel

def env5757 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,131393,32768,136512,4194304,17665,230468,8329,5376,4477269,16385,131152,4315355,131140,4294967296,256,4299280895,131073,513]

theorem envBound5757 : H12AffineFastState.Bounded env5757 := by
  intro p hp
  have h : env5757.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5756_5757 : H12AffineEnvironment.transform 24 8329 env5756 = env5757 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env5756 == env5757) = true)

theorem identity5757 : scanCanonicalize (H12AffineFastState.compose env5757 (packedSelected [4,9,16] rootPS)) = affineNative (2^(16+1) ^^^ 1344) := by decide +kernel

theorem selectedBound5757 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env5758 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,1025,32768,4096,4194304,17665,98564,8329,5376,4477269,16385,1296,4315355,1284,4294967296,256,4299280895,1345,513]

theorem envBound5758 : H12AffineFastState.Bounded env5758 := by
  intro p hp
  have h : env5758.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5757_5758 : H12AffineEnvironment.transform 16 1344 env5757 = env5758 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env5757 == env5758) = true)

theorem identity5758 : scanCanonicalize (H12AffineFastState.compose env5758 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 4176) := by decide +kernel

theorem selectedBound5758 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env5759 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1344,262144,1025,32768,4096,4194304,5457,98564,8329,5376,4456709,4177,1296,4294795,1284,4294967296,256,4299260335,1345,513]

theorem envBound5759 : H12AffineFastState.Bounded env5759 := by
  intro p hp
  have h : env5759.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5758_5759 : H12AffineEnvironment.transform 13 4176 env5758 = env5759 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env5758 == env5759) = true)

theorem identity5759 : scanCanonicalize (H12AffineFastState.compose env5759 (packedSelected [3,5,10] rootPS)) = affineNative (2^(14+1) ^^^ 13973) := by decide +kernel

theorem selectedBound5759 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env5760 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,13973,65536,1344,262144,1025,13973,4096,4194304,5457,79761,8329,5376,4456709,4177,1296,4275742,1284,4294967296,256,4299241274,1345,513]

theorem envBound5760 : H12AffineFastState.Bounded env5760 := by
  intro p hp
  have h : env5760.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5759_5760 : H12AffineEnvironment.transform 14 13973 env5759 = env5760 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13973 env5759 == env5760) = true)

theorem identity5760 : scanCanonicalize (H12AffineFastState.compose env5760 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 76591) := by decide +kernel

theorem selectedBound5760 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env5761 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,13973,65536,1344,76591,1025,13973,4096,4194304,5457,79761,8329,5376,4270634,4177,1296,4275742,1284,4294967296,256,4299241274,1345,513]

theorem envBound5761 : H12AffineFastState.Bounded env5761 := by
  intro p hp
  have h : env5761.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5760_5761 : H12AffineEnvironment.transform 17 76591 env5760 = env5761 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 76591 env5760 == env5761) = true)

theorem identity5761 : scanCanonicalize (H12AffineFastState.compose env5761 (packedSelected [0,7,20] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound5761 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env5762 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4176,13340,65536,1344,76198,1025,13340,4096,4194304,5457,79128,8329,5376,4270243,4177,1296,4275351,1284,4294967296,256,4299240883,1345,136]

theorem envBound5762 : H12AffineFastState.Bounded env5762 := by
  intro p hp
  have h : env5762.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5761_5762 : H12AffineEnvironment.transform 8 137 env5761 = env5762 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env5761 == env5762) = true)

theorem identity5762 : scanCanonicalize (H12AffineFastState.compose env5762 (packedSelected [1,3,8] rootPS)) = affineNative (2^(12+1) ^^^ 7649) := by decide +kernel

theorem selectedBound5762 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env5763 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,7649,4176,2557,65536,1344,70727,1025,2557,4096,4194304,5457,67833,7528,5376,4265282,4177,1296,4260214,1284,4294967296,256,4299229266,1345,136]

theorem envBound5763 : H12AffineFastState.Bounded env5763 := by
  intro p hp
  have h : env5763.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5762_5763 : H12AffineEnvironment.transform 12 7649 env5762 = env5763 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 7649 env5762 == env5763) = true)

theorem identity5763 : scanCanonicalize (H12AffineFastState.compose env5763 (packedSelected [3,5,24] rootPS)) = affineNative (2^(15+1) ^^^ 2162) := by decide +kernel

theorem selectedBound5763 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env5764 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,7649,4176,2557,2162,1344,7221,1025,2557,4096,4194304,5457,139,7528,5376,4201776,4177,1296,4196612,1284,4294967296,256,4299161632,1345,136]

theorem envBound5764 : H12AffineFastState.Bounded env5764 := by
  intro p hp
  have h : env5764.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5763_5764 : H12AffineEnvironment.transform 15 2162 env5763 = env5764 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2162 env5763 == env5764) = true)

theorem identity5764 : scanCanonicalize (H12AffineFastState.compose env5764 (packedSelected [3] rootPS)) = affineNative (2^(11+1) ^^^ 1190) := by decide +kernel

theorem selectedBound5764 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env5765 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1190,2375,1270,2557,2162,1344,2195,1025,2557,1190,4194304,503,139,2510,422,4196758,1271,1296,4196612,1284,4294967296,256,4299161632,1345,136]

theorem envBound5765 : H12AffineFastState.Bounded env5765 := by
  intro p hp
  have h : env5765.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5764_5765 : H12AffineEnvironment.transform 11 1190 env5764 = env5765 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1190 env5764 == env5765) = true)

def env5766 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1190,2375,1270,2557,2162,1344,2195,1025,2557,1190,260,503,139,2510,422,2194,1271,1296,2048,1284,4294967296,256,4294967588,1345,136]

theorem envBound5766 : H12AffineFastState.Bounded env5766 := by
  intro p hp
  have h : env5766.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5765_5766 : H12AffineEnvironment.transform 21 260 env5765 = env5766 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 260 env5765 == env5766) = true)

theorem identity5766 : scanCanonicalize (H12AffineFastState.compose env5766 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound5766 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5767 : List Nat := [2,4,8,16,32,10,128,256,137,1024,2048,1190,2317,1212,2487,2104,1290,2195,1025,2487,1190,260,445,139,2436,422,2194,1213,1296,2048,1284,4294967296,256,4294967588,1291,136]

theorem envBound5767 : H12AffineFastState.Bounded env5767 := by
  intro p hp
  have h : env5767.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5766_5767 : H12AffineEnvironment.transform 5 10 env5766 = env5767 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env5766 == env5767) = true)

theorem identity5767 : scanCanonicalize (H12AffineFastState.compose env5767 (packedSelected [0,6] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound5767 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env5768 : List Nat := [2,4,8,16,32,10,128,37,137,1024,2048,1190,2088,1212,2194,2104,1071,2195,1025,2194,1190,33,152,139,2209,131,2194,1213,1077,2048,1057,4294967296,37,4294967297,1070,136]

theorem envBound5768 : H12AffineFastState.Bounded env5768 := by
  intro p hp
  have h : env5768.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5767_5768 : H12AffineEnvironment.transform 7 37 env5767 = env5768 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env5767 == env5768) = true)

theorem identity5768 : scanCanonicalize (H12AffineFastState.compose env5768 (packedSelected [0,2] rootPS)) = affineNative (2^(31+1) ^^^ 178) := by decide +kernel

theorem selectedBound5768 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env5769 : List Nat := [2,4,8,16,32,10,128,37,137,1024,2048,1190,2088,1212,2194,2104,1071,2195,1025,2194,1190,33,152,139,2209,131,2194,1213,1077,2048,1057,178,37,179,1070,136]

theorem envBound5769 : H12AffineFastState.Bounded env5769 := by
  intro p hp
  have h : env5769.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5768_5769 : H12AffineEnvironment.transform 31 178 env5768 = env5769 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 178 env5768 == env5769) = true)

def env5770 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1190,2375,1270,2557,2162,1344,2195,1025,2557,1190,261,503,139,2510,422,2195,1271,1296,2049,1284,4294967296,256,4294967589,1345,136]

theorem envBound5770 : H12AffineFastState.Bounded env5770 := by
  intro p hp
  have h : env5770.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5765_5770 : H12AffineEnvironment.transform 21 261 env5765 = env5770 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 261 env5765 == env5770) = true)

theorem identity5770 : scanCanonicalize (H12AffineFastState.compose env5770 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 252) := by decide +kernel

theorem selectedBound5770 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5771 : List Nat := [2,4,8,16,32,64,128,252,137,1024,2048,1190,2235,1270,2049,2162,1212,2195,1025,2049,1190,249,11,139,2098,90,2195,1271,1260,2049,1272,4294967296,252,4294967513,1213,136]

theorem envBound5771 : H12AffineFastState.Bounded env5771 := by
  intro p hp
  have h : env5771.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5770_5771 : H12AffineEnvironment.transform 7 252 env5770 = env5771 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 252 env5770 == env5771) = true)

theorem identity5771 : scanCanonicalize (H12AffineFastState.compose env5771 (packedSelected [0,6] rootPS)) = affineNative (2^(6+1) ^^^ 89) := by decide +kernel

theorem selectedBound5771 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env5772 : List Nat := [2,4,8,16,32,64,89,37,80,1024,2048,1151,2146,1071,2049,2162,1125,2122,1025,2049,1151,32,11,82,2098,90,2122,1070,1077,2049,1057,4294967296,37,4294967296,1124,81]

theorem envBound5772 : H12AffineFastState.Bounded env5772 := by
  intro p hp
  have h : env5772.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5771_5772 : H12AffineEnvironment.transform 6 89 env5771 = env5772 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env5771 == env5772) = true)

def env5773 : List Nat := [2,4,8,16,32,16,9,37,0,1024,2048,1071,2098,1071,2049,2082,1077,2074,1025,2049,1071,32,11,2,2098,10,2074,1070,1077,2049,1057,4294967296,37,4294967296,1076,1]

theorem envBound5773 : H12AffineFastState.Bounded env5773 := by
  intro p hp
  have h : env5773.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5772_5773 : H12AffineEnvironment.transform 5 16 env5772 = env5773 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env5772 == env5773) = true)

theorem identity5773 : scanCanonicalize (H12AffineFastState.compose env5773 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 42) := by decide +kernel

theorem selectedBound5773 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5774 : List Nat := [2,4,8,16,32,16,9,37,0,1024,2048,1071,2098,1071,2049,2082,1077,2074,1025,2049,1071,32,11,2,2098,10,2074,1070,1077,2049,1057,42,37,42,1076,1]

theorem envBound5774 : H12AffineFastState.Bounded env5774 := by
  intro p hp
  have h : env5774.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5773_5774 : H12AffineEnvironment.transform 31 42 env5773 = env5774 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 42 env5773 == env5774) = true)

def leafEnv5774 : List Nat := [2,4,8,16,32,16,9,37,0,1024,2048,1071,2098,1071,2049,2082,1077,2074,1025,2049,1071,32,11,2,1056,2098,1,10,2074,1070,1077,2049,1057,42,37,42,4,2083,1076,1,0,1077,1]

def active5774 : List Nat := [0,1,2,3,4,9,10]

def tree5774 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5774 : H12WitnessSearch.Good tree5774 := H12GlobalWitnessIndex.good

theorem leafIdentity5774 : H12AffineFastState.composeSystem env5774 rootObs = leafEnv5774 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5774 rootObs == leafEnv5774) = true)

theorem terminalChecked5774 : H12PackedTerminal.terminalCheckFast leafEnv5774 active5774 tree5774 = true := by decide +kernel

def env5775 : List Nat := [2,4,8,16,32,17,8,37,1,1024,2048,1070,2099,1071,2049,2083,1076,2075,1025,2049,1070,32,11,3,2098,11,2075,1070,1077,2049,1057,4294967296,37,4294967296,1077,0]

theorem envBound5775 : H12AffineFastState.Bounded env5775 := by
  intro p hp
  have h : env5775.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5772_5775 : H12AffineEnvironment.transform 5 17 env5772 = env5775 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env5772 == env5775) = true)

theorem identity5775 : scanCanonicalize (H12AffineFastState.compose env5775 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 48) := by decide +kernel

theorem selectedBound5775 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5776 : List Nat := [2,4,8,16,32,17,8,37,1,1024,2048,1070,2099,1071,2049,2083,1076,2075,1025,2049,1070,32,11,3,2098,11,2075,1070,1077,2049,1057,48,37,48,1077,0]

theorem envBound5776 : H12AffineFastState.Bounded env5776 := by
  intro p hp
  have h : env5776.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5775_5776 : H12AffineEnvironment.transform 31 48 env5775 = env5776 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 48 env5775 == env5776) = true)

def leafEnv5776 : List Nat := [2,4,8,16,32,17,8,37,1,1024,2048,1070,2099,1071,2049,2083,1076,2075,1025,2049,1070,32,11,3,1056,2098,1,11,2075,1070,1077,2049,1057,48,37,48,4,2083,1077,0,0,1077,1]

def active5776 : List Nat := [0,1,2,3,4,9,10]

def tree5776 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5776 : H12WitnessSearch.Good tree5776 := H12GlobalWitnessIndex.good

theorem leafIdentity5776 : H12AffineFastState.composeSystem env5776 rootObs = leafEnv5776 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5776 rootObs == leafEnv5776) = true)

theorem terminalChecked5776 : H12PackedTerminal.terminalCheckFast leafEnv5776 active5776 tree5776 = true := by decide +kernel

def env5777 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,136512,4194304,17665,16777216,33554432,5377,4477269,16384,16876564,1073741824,131140,4294967296,17007940,4350047346,131073,33563272]

theorem envBound5777 : H12AffineFastState.Bounded env5777 := by
  intro p hp
  have h : env5777.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5728_5777 : H12AffineEnvironment.transform 25 5377 env5728 = env5777 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env5728 == env5777) = true)

theorem identity5777 : scanCanonicalize (H12AffineFastState.compose env5777 (packedSelected [35] rootPS)) = affineNative (2^(23+1) ^^^ 98565) := by decide +kernel

theorem selectedBound5777 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env5778 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,136512,4194304,17665,98565,33554432,5377,4477269,16384,1297,1073741824,131140,4294967296,132161,4333368695,131073,33563272]

theorem envBound5778 : H12AffineFastState.Bounded env5778 := by
  intro p hp
  have h : env5778.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5777_5778 : H12AffineEnvironment.transform 23 98565 env5777 = env5778 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98565 env5777 == env5778) = true)

def env5779 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,131392,32768,136512,4194304,17665,98565,33554432,5377,4477269,16384,1297,1073741824,131140,4294967296,132161,4332975159,131073,33563272]

theorem envBound5779 : H12AffineFastState.Bounded env5779 := by
  intro p hp
  have h : env5779.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5778_5779 : H12AffineEnvironment.transform 18 131392 env5778 = env5779 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 131392 env5778 == env5779) = true)

theorem identity5779 : scanCanonicalize (H12AffineFastState.compose env5779 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 4447643) := by decide +kernel

theorem selectedBound5779 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env5780 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,131392,32768,136512,4194304,17665,98565,33554432,5377,4477269,16384,1297,4447643,131140,4294967296,132161,4332975159,131073,33563272]

theorem envBound5780 : H12AffineFastState.Bounded env5780 := by
  intro p hp
  have h : env5780.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5779_5780 : H12AffineEnvironment.transform 29 4447643 env5779 = env5780 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4447643 env5779 == env5780) = true)

theorem identity5780 : scanCanonicalize (H12AffineFastState.compose env5780 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(24+1) ^^^ 140745) := by decide +kernel

theorem selectedBound5780 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env5781 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,131392,32768,136512,4194304,17665,98565,140745,5377,4477269,16384,1297,4447643,131140,4294967296,132161,4299280894,131073,132929]

theorem envBound5781 : H12AffineFastState.Bounded env5781 := by
  intro p hp
  have h : env5781.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5780_5781 : H12AffineEnvironment.transform 24 140745 env5780 = env5781 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 140745 env5780 == env5781) = true)

theorem identity5781 : scanCanonicalize (H12AffineFastState.compose env5781 (packedSelected [1,3,5,8,10,15,17,21,26,38] rootPS)) = affineNative (2^(13+1) ^^^ 4176) := by decide +kernel

theorem selectedBound5781 : packedSelected [1,3,5,8,10,15,17,21,26,38] rootPS < 2^1333 := by decide +kernel

def env5782 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,131392,32768,136512,4194304,5457,98565,140745,5377,4456709,4176,1297,4427211,131140,4294967296,132161,4299260334,131073,132929]

theorem envBound5782 : H12AffineFastState.Bounded env5782 := by
  intro p hp
  have h : env5782.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5781_5782 : H12AffineEnvironment.transform 13 4176 env5781 = env5782 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env5781 == env5782) = true)

theorem identity5782 : scanCanonicalize (H12AffineFastState.compose env5782 (packedSelected [1,3,4,5,8,9,16,24,28] rootPS)) = affineNative (2^(16+1) ^^^ 42061) := by decide +kernel

theorem selectedBound5782 : packedSelected [1,3,4,5,8,9,16,24,28] rootPS < 2^1333 := by decide +kernel

def env5783 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,42061,262144,42253,32768,45325,4194304,5457,98565,33156,5377,4456709,4176,1297,4270470,41993,4294967296,40972,4299260334,42060,41740]

theorem envBound5783 : H12AffineFastState.Bounded env5783 := by
  intro p hp
  have h : env5783.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5782_5783 : H12AffineEnvironment.transform 16 42061 env5782 = env5783 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 42061 env5782 == env5783) = true)

def env5784 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,42061,262144,42253,32768,45325,370000,5457,98565,33156,5377,107605,4176,1297,298198,41993,4294967296,40972,4295238910,42060,41740]

theorem envBound5784 : H12AffineFastState.Bounded env5784 := by
  intro p hp
  have h : env5784.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5783_5784 : H12AffineEnvironment.transform 21 370000 env5783 = env5784 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 370000 env5783 == env5784) = true)

theorem identity5784 : scanCanonicalize (H12AffineFastState.compose env5784 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 263414) := by decide +kernel

theorem selectedBound5784 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env5785 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,42061,262144,42253,32768,45325,370000,5457,98565,33156,5377,107605,4176,1297,298198,41993,263414,40972,8200,42060,41740]

theorem envBound5785 : H12AffineFastState.Bounded env5785 := by
  intro p hp
  have h : env5785.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5784_5785 : H12AffineEnvironment.transform 31 263414 env5784 = env5785 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 263414 env5784 == env5785) = true)

def env5786 : List Nat := [2,4,8,16,32,64,128,256,32,1024,2048,4096,8192,4176,32768,65536,42061,262144,42253,32768,45325,370000,5457,98565,33156,5377,107605,4176,1297,298198,41993,263414,40972,8200,42060,41260]

theorem envBound5786 : H12AffineFastState.Bounded env5786 := by
  intro p hp
  have h : env5786.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5785_5786 : H12AffineEnvironment.transform 8 32 env5785 = env5786 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 32 env5785 == env5786) = true)

theorem identity5786 : scanCanonicalize (H12AffineFastState.compose env5786 (packedSelected [0,1,3,4,7,9,12,15,16,17,20,21] rootPS)) = affineNative (2^(15+1) ^^^ 46279) := by decide +kernel

theorem selectedBound5786 : packedSelected [0,1,3,4,7,9,12,15,16,17,20,21] rootPS < 2^1333 := by decide +kernel

def env5787 : List Nat := [2,4,8,16,32,64,128,256,32,1024,2048,4096,8192,4176,32768,46279,42061,262144,42253,32768,45325,266647,5457,13762,33156,5377,4242,4176,1297,298198,41993,263414,40972,8200,42060,41260]

theorem envBound5787 : H12AffineFastState.Bounded env5787 := by
  intro p hp
  have h : env5787.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5786_5787 : H12AffineEnvironment.transform 15 46279 env5786 = env5787 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 46279 env5786 == env5787) = true)

def env5788 : List Nat := [2,4,8,16,32,64,128,256,32,1024,2048,4096,8192,4176,8200,5327,1093,262144,1285,8200,4357,266647,5457,13762,8588,5377,4242,4176,1297,273630,1025,263414,4,8200,1092,292]

theorem envBound5788 : H12AffineFastState.Bounded env5788 := by
  intro p hp
  have h : env5788.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5787_5788 : H12AffineEnvironment.transform 14 8200 env5787 = env5788 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8200 env5787 == env5788) = true)

theorem identity5788 : scanCanonicalize (H12AffineFastState.compose env5788 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 9555) := by decide +kernel

theorem selectedBound5788 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env5789 : List Nat := [2,4,8,16,32,64,128,256,32,1024,2048,4096,8192,4176,8200,5327,1093,9555,1285,8200,4357,13508,5457,13762,8588,5377,4242,4176,1297,2445,1025,8613,4,8200,1092,292]

theorem envBound5789 : H12AffineFastState.Bounded env5789 := by
  intro p hp
  have h : env5789.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5788_5789 : H12AffineEnvironment.transform 17 9555 env5788 = env5789 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 9555 env5788 == env5789) = true)

theorem identity5789 : scanCanonicalize (H12AffineFastState.compose env5789 (packedSelected [5,8,13,17] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound5789 : packedSelected [5,8,13,17] rootPS < 2^1333 := by decide +kernel

def env5790 : List Nat := [2,4,8,16,32,64,128,4,32,1024,2048,4096,8192,4176,8200,5327,1093,9303,1025,8200,4097,13508,5205,13510,8328,5125,4242,4176,1045,2185,1025,8353,4,8200,1092,32]

theorem envBound5790 : H12AffineFastState.Bounded env5790 := by
  intro p hp
  have h : env5790.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5789_5790 : H12AffineEnvironment.transform 7 4 env5789 = env5790 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env5789 == env5790) = true)

theorem identity5790 : scanCanonicalize (H12AffineFastState.compose env5790 (packedSelected [3,5,10] rootPS)) = affineNative (2^(12+1) ^^^ 4168) := by decide +kernel

theorem selectedBound5790 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env5791 : List Nat := [2,4,8,16,32,64,128,4,32,1024,2048,4096,4168,4176,4160,5327,1093,5151,1025,4160,4097,1164,5205,1166,4288,5125,4242,4176,1045,2185,1025,4329,4,4160,1092,32]

theorem envBound5791 : H12AffineFastState.Bounded env5791 := by
  intro p hp
  have h : env5791.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5790_5791 : H12AffineEnvironment.transform 12 4168 env5790 = env5791 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4168 env5790 == env5791) = true)

theorem identity5791 : scanCanonicalize (H12AffineFastState.compose env5791 (packedSelected [1,5,12] rootPS)) = affineNative (2^(11+1) ^^^ 3134) := by decide +kernel

theorem selectedBound5791 : packedSelected [1,5,12] rootPS < 2^1333 := by decide +kernel

def env5792 : List Nat := [2,4,8,16,32,64,128,4,32,1024,2048,3134,3190,3182,3198,2289,1093,2081,1025,3198,3135,1164,2155,1166,3326,2107,3244,3182,1045,2185,1025,3287,4,3198,1092,32]

theorem envBound5792 : H12AffineFastState.Bounded env5792 := by
  intro p hp
  have h : env5792.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5791_5792 : H12AffineEnvironment.transform 11 3134 env5791 = env5792 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3134 env5791 == env5792) = true)

theorem identity5792 : scanCanonicalize (H12AffineFastState.compose env5792 (packedSelected [1,3,13] rootPS)) = affineNative (2^(6+1) ^^^ 121) := by decide +kernel

theorem selectedBound5792 : packedSelected [1,3,13] rootPS < 2^1333 := by decide +kernel

def env5793 : List Nat := [2,4,8,16,32,64,121,4,32,1024,2048,3134,3190,3182,3198,2056,1093,2081,1025,3198,3135,1141,2155,1143,3079,2107,3157,3182,1045,2160,1025,3118,4,3198,1092,32]

theorem envBound5793 : H12AffineFastState.Bounded env5793 := by
  intro p hp
  have h : env5793.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5792_5793 : H12AffineEnvironment.transform 6 121 env5792 = env5793 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 121 env5792 == env5793) = true)

theorem identity5793 : scanCanonicalize (H12AffineFastState.compose env5793 (packedSelected [4,9,16] rootPS)) = affineNative (2^(9+1) ^^^ 4) := by decide +kernel

theorem selectedBound5793 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env5794 : List Nat := [2,4,8,16,32,64,121,4,32,4,2048,2106,2162,2154,2170,2056,65,2081,5,2170,2107,113,2155,115,2051,2107,2129,2154,17,2160,5,2090,4,2170,64,32]

theorem envBound5794 : H12AffineFastState.Bounded env5794 := by
  intro p hp
  have h : env5794.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5793_5794 : H12AffineEnvironment.transform 9 4 env5793 = env5794 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 4 env5793 == env5794) = true)

theorem identity5794 : scanCanonicalize (H12AffineFastState.compose env5794 (packedSelected [0,2,7] rootPS)) = affineNative (2^(5+1) ^^^ 48) := by decide +kernel

theorem selectedBound5794 : packedSelected [0,2,7] rootPS < 2^1333 := by decide +kernel

def env5795 : List Nat := [2,4,8,16,32,48,9,4,32,4,2048,2106,2050,2074,2058,2056,49,2081,5,2058,2107,1,2075,3,2051,2107,2081,2074,17,2048,5,2090,4,2058,48,32]

theorem envBound5795 : H12AffineFastState.Bounded env5795 := by
  intro p hp
  have h : env5795.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5794_5795 : H12AffineEnvironment.transform 5 48 env5794 = env5795 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 48 env5794 == env5795) = true)

theorem identity5795 : scanCanonicalize (H12AffineFastState.compose env5795 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 50) := by decide +kernel

theorem selectedBound5795 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5796 : List Nat := [2,4,8,16,32,48,9,4,32,4,50,8,48,40,56,58,49,19,5,56,9,1,41,3,49,9,19,40,17,50,5,24,4,56,48,32]

theorem envBound5796 : H12AffineFastState.Bounded env5796 := by
  intro p hp
  have h : env5796.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5795_5796 : H12AffineEnvironment.transform 10 50 env5795 = env5796 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 50 env5795 == env5796) = true)

def env5797 : List Nat := [2,4,8,16,32,64,128,256,32,1024,2048,4096,8192,4176,8201,5326,1092,262144,1284,8201,4356,266647,5457,13762,8589,5377,4242,4176,1297,273631,1024,263414,5,8200,1093,293]

theorem envBound5797 : H12AffineFastState.Bounded env5797 := by
  intro p hp
  have h : env5797.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5787_5797 : H12AffineEnvironment.transform 14 8201 env5787 = env5797 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8201 env5787 == env5797) = true)

theorem identity5797 : scanCanonicalize (H12AffineFastState.compose env5797 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 9302) := by decide +kernel

theorem selectedBound5797 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env5798 : List Nat := [2,4,8,16,32,64,128,256,32,1024,2048,4096,8192,4176,8201,5326,1092,9302,1284,8201,4356,13761,5457,13762,8589,5377,4242,4176,1297,2185,1024,8352,5,8200,1093,293]

theorem envBound5798 : H12AffineFastState.Bounded env5798 := by
  intro p hp
  have h : env5798.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5797_5798 : H12AffineEnvironment.transform 17 9302 env5797 = env5798 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 9302 env5797 == env5798) = true)

theorem identity5798 : scanCanonicalize (H12AffineFastState.compose env5798 (packedSelected [5,8,13,17] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound5798 : packedSelected [5,8,13,17] rootPS < 2^1333 := by decide +kernel

def env5799 : List Nat := [2,4,8,16,32,64,128,5,32,1024,2048,4096,8192,4176,8201,5326,1092,9302,1025,8201,4097,13508,5204,13511,8328,5124,4242,4176,1044,2185,1024,8352,5,8200,1093,32]

theorem envBound5799 : H12AffineFastState.Bounded env5799 := by
  intro p hp
  have h : env5799.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5798_5799 : H12AffineEnvironment.transform 7 5 env5798 = env5799 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env5798 == env5799) = true)

theorem identity5799 : scanCanonicalize (H12AffineFastState.compose env5799 (packedSelected [3,5,10] rootPS)) = affineNative (2^(12+1) ^^^ 4168) := by decide +kernel

theorem selectedBound5799 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env5800 : List Nat := [2,4,8,16,32,64,128,5,32,1024,2048,4096,4168,4176,4161,5326,1092,5150,1025,4161,4097,1164,5204,1167,4288,5124,4242,4176,1044,2185,1024,4328,5,4160,1093,32]

theorem envBound5800 : H12AffineFastState.Bounded env5800 := by
  intro p hp
  have h : env5800.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5799_5800 : H12AffineEnvironment.transform 12 4168 env5799 = env5800 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4168 env5799 == env5800) = true)

theorem identity5800 : scanCanonicalize (H12AffineFastState.compose env5800 (packedSelected [1,5,12] rootPS)) = affineNative (2^(11+1) ^^^ 3134) := by decide +kernel

theorem selectedBound5800 : packedSelected [1,5,12] rootPS < 2^1333 := by decide +kernel

def env5801 : List Nat := [2,4,8,16,32,64,128,5,32,1024,2048,3134,3190,3182,3199,2288,1092,2080,1025,3199,3135,1164,2154,1167,3326,2106,3244,3182,1044,2185,1024,3286,5,3198,1093,32]

theorem envBound5801 : H12AffineFastState.Bounded env5801 := by
  intro p hp
  have h : env5801.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5800_5801 : H12AffineEnvironment.transform 11 3134 env5800 = env5801 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3134 env5800 == env5801) = true)

theorem identity5801 : scanCanonicalize (H12AffineFastState.compose env5801 (packedSelected [1,3,13] rootPS)) = affineNative (2^(6+1) ^^^ 121) := by decide +kernel

theorem selectedBound5801 : packedSelected [1,3,13] rootPS < 2^1333 := by decide +kernel

def env5802 : List Nat := [2,4,8,16,32,64,121,5,32,1024,2048,3134,3190,3182,3199,2057,1092,2080,1025,3199,3135,1141,2154,1142,3079,2106,3157,3182,1044,2160,1024,3119,5,3198,1093,32]

theorem envBound5802 : H12AffineFastState.Bounded env5802 := by
  intro p hp
  have h : env5802.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5801_5802 : H12AffineEnvironment.transform 6 121 env5801 = env5802 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 121 env5801 == env5802) = true)

theorem identity5802 : scanCanonicalize (H12AffineFastState.compose env5802 (packedSelected [4,9,16] rootPS)) = affineNative (2^(9+1) ^^^ 5) := by decide +kernel

theorem selectedBound5802 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env5803 : List Nat := [2,4,8,16,32,64,121,5,32,5,2048,2107,2163,2155,2170,2057,65,2080,4,2170,2106,112,2154,115,2050,2106,2128,2155,17,2160,5,2090,5,2171,64,32]

theorem envBound5803 : H12AffineFastState.Bounded env5803 := by
  intro p hp
  have h : env5803.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5802_5803 : H12AffineEnvironment.transform 9 5 env5802 = env5803 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 5 env5802 == env5803) = true)

theorem identity5803 : scanCanonicalize (H12AffineFastState.compose env5803 (packedSelected [0,2,7] rootPS)) = affineNative (2^(10+1) ^^^ 90) := by decide +kernel

theorem selectedBound5803 : packedSelected [0,2,7] rootPS < 2^1333 := by decide +kernel

def env5804 : List Nat := [2,4,8,16,32,64,121,5,32,5,90,97,41,49,32,83,65,122,4,32,96,112,48,115,88,96,10,49,17,42,5,112,5,33,64,32]

theorem envBound5804 : H12AffineFastState.Bounded env5804 := by
  intro p hp
  have h : env5804.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5803_5804 : H12AffineEnvironment.transform 10 90 env5803 = env5804 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 90 env5803 == env5804) = true)

theorem identity5804 : scanCanonicalize (H12AffineFastState.compose env5804 (packedSelected [0,1] rootPS)) = affineNative (2^(4+1) ^^^ 8) := by decide +kernel

theorem selectedBound5804 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env5805 : List Nat := [2,4,8,16,8,64,81,5,8,5,90,73,1,25,8,83,65,82,4,8,72,88,24,91,88,72,10,25,17,2,5,88,5,9,64,8]

theorem envBound5805 : H12AffineFastState.Bounded env5805 := by
  intro p hp
  have h : env5805.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5804_5805 : H12AffineEnvironment.transform 4 8 env5804 = env5805 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 8 env5804 == env5805) = true)

theorem identity5805 : scanCanonicalize (H12AffineFastState.compose env5805 (packedSelected [0,3] rootPS)) = affineNative (2^(2+1) ^^^ 1) := by decide +kernel

theorem selectedBound5805 : packedSelected [0,3] rootPS < 2^1333 := by decide +kernel

def env5806 : List Nat := [2,4,1,16,1,64,81,5,1,5,83,64,1,16,1,83,65,82,4,1,65,81,17,82,81,65,3,16,17,2,5,81,5,0,64,1]

theorem envBound5806 : H12AffineFastState.Bounded env5806 := by
  intro p hp
  have h : env5806.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5805_5806 : H12AffineEnvironment.transform 2 1 env5805 = env5806 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env5805 == env5806) = true)

theorem identity5806 : scanCanonicalize (H12AffineFastState.compose env5806 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound5806 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5807 : List Nat := [2,4,1,16,1,16,1,5,1,5,3,16,1,16,1,3,17,2,4,1,17,1,17,2,1,17,3,16,17,2,5,1,5,0,16,1]

theorem envBound5807 : H12AffineFastState.Bounded env5807 := by
  intro p hp
  have h : env5807.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5806_5807 : H12AffineEnvironment.transform 5 16 env5806 = env5807 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env5806 == env5807) = true)

theorem identity5807 : scanCanonicalize (H12AffineFastState.compose env5807 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound5807 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5808 : List Nat := [2,4,1,2,1,2,1,5,1,5,3,2,1,2,1,3,3,2,4,1,3,1,3,2,1,3,3,2,3,2,5,1,5,0,2,1]

theorem envBound5808 : H12AffineFastState.Bounded env5808 := by
  intro p hp
  have h : env5808.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5807_5808 : H12AffineEnvironment.transform 3 2 env5807 = env5808 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env5807 == env5808) = true)

theorem identity5808 : scanCanonicalize (H12AffineFastState.compose env5808 (packedSelected [4] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5808 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env5809 : List Nat := [0,4,1,0,1,0,1,5,1,5,1,0,1,0,1,1,1,0,4,1,1,1,1,0,1,1,1,0,1,0,5,1,5,0,0,1]

theorem envBound5809 : H12AffineFastState.Bounded env5809 := by
  intro p hp
  have h : env5809.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5808_5809 : H12AffineEnvironment.transform 0 0 env5808 = env5809 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5808 == env5809) = true)

def env5810 : List Nat := [2,4,8,16,32,64,128,256,33,1024,2048,4096,8192,4176,32768,65536,42061,262144,42253,32768,45325,370000,5457,98565,33156,5377,107605,4176,1297,298198,41993,263414,40972,8200,42060,41261]

theorem envBound5810 : H12AffineFastState.Bounded env5810 := by
  intro p hp
  have h : env5810.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5785_5810 : H12AffineEnvironment.transform 8 33 env5785 = env5810 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 33 env5785 == env5810) = true)

theorem identity5810 : scanCanonicalize (H12AffineFastState.compose env5810 (packedSelected [0,1,3,4,7,9,12,15,16,17,20,21] rootPS)) = affineNative (2^(15+1) ^^^ 5579) := by decide +kernel

theorem selectedBound5810 : packedSelected [0,1,3,4,7,9,12,15,16,17,20,21] rootPS < 2^1333 := by decide +kernel

def env5811 : List Nat := [2,4,8,16,32,64,128,256,33,1024,2048,4096,8192,4176,32768,5579,42061,262144,42253,32768,45325,307355,5457,38094,33156,5377,45470,4176,1297,298198,41993,263414,40972,8200,42060,41261]

theorem envBound5811 : H12AffineFastState.Bounded env5811 := by
  intro p hp
  have h : env5811.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5810_5811 : H12AffineEnvironment.transform 15 5579 env5810 = env5811 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5579 env5810 == env5811) = true)

def env5812 : List Nat := [2,4,8,16,32,64,128,256,33,1024,2048,4096,8192,4176,8200,5579,1093,262144,1285,8200,4357,266387,5457,13510,8588,5377,4502,4176,1297,273630,1025,263414,4,8200,1092,293]

theorem envBound5812 : H12AffineFastState.Bounded env5812 := by
  intro p hp
  have h : env5812.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5811_5812 : H12AffineEnvironment.transform 14 8200 env5811 = env5812 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8200 env5811 == env5812) = true)

theorem identity5812 : scanCanonicalize (H12AffineFastState.compose env5812 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 9303) := by decide +kernel

theorem selectedBound5812 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env5813 : List Nat := [2,4,8,16,32,64,128,256,33,1024,2048,4096,8192,4176,8200,5579,1093,9303,1285,8200,4357,13508,5457,13510,8588,5377,4502,4176,1297,2185,1025,8353,4,8200,1092,293]

theorem envBound5813 : H12AffineFastState.Bounded env5813 := by
  intro p hp
  have h : env5813.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5812_5813 : H12AffineEnvironment.transform 17 9303 env5812 = env5813 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 9303 env5812 == env5813) = true)

theorem identity5813 : scanCanonicalize (H12AffineFastState.compose env5813 (packedSelected [5,8,13,17] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound5813 : packedSelected [5,8,13,17] rootPS < 2^1333 := by decide +kernel

def env5814 : List Nat := [2,4,8,16,32,64,128,4,33,1024,2048,4096,8192,4176,8200,5327,1093,9303,1025,8200,4097,13508,5205,13510,8328,5125,4242,4176,1045,2185,1025,8353,4,8200,1092,33]

theorem envBound5814 : H12AffineFastState.Bounded env5814 := by
  intro p hp
  have h : env5814.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5813_5814 : H12AffineEnvironment.transform 7 4 env5813 = env5814 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env5813 == env5814) = true)

theorem identity5814 : scanCanonicalize (H12AffineFastState.compose env5814 (packedSelected [3,5,10] rootPS)) = affineNative (2^(12+1) ^^^ 4169) := by decide +kernel

theorem selectedBound5814 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env5815 : List Nat := [2,4,8,16,32,64,128,4,33,1024,2048,4096,4169,4176,4161,5327,1093,5150,1025,4161,4097,1165,5205,1167,4289,5125,4242,4176,1045,2185,1025,4328,4,4161,1092,33]

theorem envBound5815 : H12AffineFastState.Bounded env5815 := by
  intro p hp
  have h : env5815.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5814_5815 : H12AffineEnvironment.transform 12 4169 env5814 = env5815 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4169 env5814 == env5815) = true)

theorem identity5815 : scanCanonicalize (H12AffineFastState.compose env5815 (packedSelected [1,5,12] rootPS)) = affineNative (2^(11+1) ^^^ 3134) := by decide +kernel

theorem selectedBound5815 : packedSelected [1,5,12] rootPS < 2^1333 := by decide +kernel

def env5816 : List Nat := [2,4,8,16,32,64,128,4,33,1024,2048,3134,3191,3182,3199,2289,1093,2080,1025,3199,3135,1165,2155,1167,3327,2107,3244,3182,1045,2185,1025,3286,4,3199,1092,33]

theorem envBound5816 : H12AffineFastState.Bounded env5816 := by
  intro p hp
  have h : env5816.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5815_5816 : H12AffineEnvironment.transform 11 3134 env5815 = env5816 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3134 env5815 == env5816) = true)

theorem identity5816 : scanCanonicalize (H12AffineFastState.compose env5816 (packedSelected [1,3,13] rootPS)) = affineNative (2^(10+1) ^^^ 211) := by decide +kernel

theorem selectedBound5816 : packedSelected [1,3,13] rootPS < 2^1333 := by decide +kernel

def env5817 : List Nat := [2,4,8,16,32,64,128,4,33,1024,211,1261,1188,1213,1196,34,1093,243,1025,1196,1260,1165,184,1167,1068,232,1151,1213,1045,90,1025,1029,4,1196,1092,33]

theorem envBound5817 : H12AffineFastState.Bounded env5817 := by
  intro p hp
  have h : env5817.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5816_5817 : H12AffineEnvironment.transform 10 211 env5816 = env5817 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 211 env5816 == env5817) = true)

theorem identity5817 : scanCanonicalize (H12AffineFastState.compose env5817 (packedSelected [1,3,5] rootPS)) = affineNative (2^(9+1) ^^^ 37) := by decide +kernel

theorem selectedBound5817 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env5818 : List Nat := [2,4,8,16,32,64,128,4,33,37,211,200,129,152,137,34,96,243,36,137,201,168,184,170,9,232,90,152,48,90,36,32,4,137,97,33]

theorem envBound5818 : H12AffineFastState.Bounded env5818 := by
  intro p hp
  have h : env5818.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5817_5818 : H12AffineEnvironment.transform 9 37 env5817 = env5818 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 37 env5817 == env5818) = true)

theorem identity5818 : scanCanonicalize (H12AffineFastState.compose env5818 (packedSelected [2,9] rootPS)) = affineNative (2^(6+1) ^^^ 59) := by decide +kernel

theorem selectedBound5818 : packedSelected [2,9] rootPS < 2^1333 := by decide +kernel

def env5819 : List Nat := [2,4,8,16,32,64,59,4,33,37,104,115,58,35,50,34,96,72,36,50,114,19,3,17,9,83,90,35,48,90,36,32,4,50,97,33]

theorem envBound5819 : H12AffineFastState.Bounded env5819 := by
  intro p hp
  have h : env5819.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5818_5819 : H12AffineEnvironment.transform 6 59 env5818 = env5819 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 59 env5818 == env5819) = true)

theorem identity5819 : scanCanonicalize (H12AffineFastState.compose env5819 (packedSelected [2,4,7,11] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound5819 : packedSelected [2,4,7,11] rootPS < 2^1333 := by decide +kernel

def env5820 : List Nat := [2,4,8,16,0,64,27,4,1,5,72,83,26,3,18,2,64,72,4,18,82,19,3,17,9,83,90,3,16,90,4,0,4,18,65,1]

theorem envBound5820 : H12AffineFastState.Bounded env5820 := by
  intro p hp
  have h : env5820.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5819_5820 : H12AffineEnvironment.transform 4 0 env5819 = env5820 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5819 == env5820) = true)

theorem identity5820 : scanCanonicalize (H12AffineFastState.compose env5820 (packedSelected [1,2,3] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound5820 : packedSelected [1,2,3] rootPS < 2^1333 := by decide +kernel

def env5821 : List Nat := [2,4,8,2,0,64,9,4,1,5,72,65,8,3,0,2,64,72,4,0,64,1,3,3,9,65,72,3,2,72,4,0,4,0,65,1]

theorem envBound5821 : H12AffineFastState.Bounded env5821 := by
  intro p hp
  have h : env5821.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5820_5821 : H12AffineEnvironment.transform 3 2 env5820 = env5821 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env5820 == env5821) = true)

theorem identity5821 : scanCanonicalize (H12AffineFastState.compose env5821 (packedSelected [0] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound5821 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5822 : List Nat := [2,4,3,2,0,64,2,4,1,5,67,65,3,3,0,2,64,67,4,0,64,1,3,3,2,65,67,3,2,67,4,0,4,0,65,1]

theorem envBound5822 : H12AffineFastState.Bounded env5822 := by
  intro p hp
  have h : env5822.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5821_5822 : H12AffineEnvironment.transform 2 3 env5821 = env5822 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env5821 == env5822) = true)

def env5823 : List Nat := [2,4,8,16,32,64,128,256,33,1024,2048,4096,8192,4176,8201,5579,1092,262144,1284,8201,4356,266386,5457,13511,8589,5377,4503,4176,1297,273631,1024,263414,5,8200,1093,292]

theorem envBound5823 : H12AffineFastState.Bounded env5823 := by
  intro p hp
  have h : env5823.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5811_5823 : H12AffineEnvironment.transform 14 8201 env5811 = env5823 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8201 env5811 == env5823) = true)

theorem identity5823 : scanCanonicalize (H12AffineFastState.compose env5823 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 9555) := by decide +kernel

theorem selectedBound5823 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env5824 : List Nat := [2,4,8,16,32,64,128,256,33,1024,2048,4096,8192,4176,8201,5579,1092,9555,1284,8201,4356,13761,5457,13511,8589,5377,4503,4176,1297,2444,1024,8613,5,8200,1093,292]

theorem envBound5824 : H12AffineFastState.Bounded env5824 := by
  intro p hp
  have h : env5824.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5823_5824 : H12AffineEnvironment.transform 17 9555 env5823 = env5824 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 9555 env5823 == env5824) = true)

theorem identity5824 : scanCanonicalize (H12AffineFastState.compose env5824 (packedSelected [5,8,13,17] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound5824 : packedSelected [5,8,13,17] rootPS < 2^1333 := by decide +kernel

def env5825 : List Nat := [2,4,8,16,32,64,128,5,33,1024,2048,4096,8192,4176,8201,5326,1092,9302,1025,8201,4097,13508,5204,13511,8328,5124,4242,4176,1044,2185,1024,8352,5,8200,1093,33]

theorem envBound5825 : H12AffineFastState.Bounded env5825 := by
  intro p hp
  have h : env5825.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5824_5825 : H12AffineEnvironment.transform 7 5 env5824 = env5825 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env5824 == env5825) = true)

theorem identity5825 : scanCanonicalize (H12AffineFastState.compose env5825 (packedSelected [3,5,10] rootPS)) = affineNative (2^(12+1) ^^^ 4169) := by decide +kernel

theorem selectedBound5825 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env5826 : List Nat := [2,4,8,16,32,64,128,5,33,1024,2048,4096,4169,4176,4160,5326,1092,5151,1025,4160,4097,1165,5204,1166,4289,5124,4242,4176,1044,2185,1024,4329,5,4161,1093,33]

theorem envBound5826 : H12AffineFastState.Bounded env5826 := by
  intro p hp
  have h : env5826.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5825_5826 : H12AffineEnvironment.transform 12 4169 env5825 = env5826 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4169 env5825 == env5826) = true)

theorem identity5826 : scanCanonicalize (H12AffineFastState.compose env5826 (packedSelected [1,5,12] rootPS)) = affineNative (2^(11+1) ^^^ 3134) := by decide +kernel

theorem selectedBound5826 : packedSelected [1,5,12] rootPS < 2^1333 := by decide +kernel

def env5827 : List Nat := [2,4,8,16,32,64,128,5,33,1024,2048,3134,3191,3182,3198,2288,1092,2081,1025,3198,3135,1165,2154,1166,3327,2106,3244,3182,1044,2185,1024,3287,5,3199,1093,33]

theorem envBound5827 : H12AffineFastState.Bounded env5827 := by
  intro p hp
  have h : env5827.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5826_5827 : H12AffineEnvironment.transform 11 3134 env5826 = env5827 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3134 env5826 == env5827) = true)

theorem identity5827 : scanCanonicalize (H12AffineFastState.compose env5827 (packedSelected [1,3,13] rootPS)) = affineNative (2^(10+1) ^^^ 210) := by decide +kernel

theorem selectedBound5827 : packedSelected [1,3,13] rootPS < 2^1333 := by decide +kernel

def env5828 : List Nat := [2,4,8,16,32,64,128,5,33,1024,210,1260,1189,1212,1196,34,1092,243,1025,1196,1261,1165,184,1166,1069,232,1150,1212,1044,91,1024,1029,5,1197,1093,33]

theorem envBound5828 : H12AffineFastState.Bounded env5828 := by
  intro p hp
  have h : env5828.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5827_5828 : H12AffineEnvironment.transform 10 210 env5827 = env5828 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 210 env5827 == env5828) = true)

theorem identity5828 : scanCanonicalize (H12AffineFastState.compose env5828 (packedSelected [1,3,5] rootPS)) = affineNative (2^(9+1) ^^^ 37) := by decide +kernel

theorem selectedBound5828 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env5829 : List Nat := [2,4,8,16,32,64,128,5,33,37,210,201,128,153,137,34,97,243,36,137,200,168,184,171,8,232,91,153,49,91,37,32,5,136,96,33]

theorem envBound5829 : H12AffineFastState.Bounded env5829 := by
  intro p hp
  have h : env5829.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5828_5829 : H12AffineEnvironment.transform 9 37 env5828 = env5829 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 37 env5828 == env5829) = true)

theorem identity5829 : scanCanonicalize (H12AffineFastState.compose env5829 (packedSelected [2,9] rootPS)) = affineNative (2^(6+1) ^^^ 27) := by decide +kernel

theorem selectedBound5829 : packedSelected [2,9] rootPS < 2^1333 := by decide +kernel

def env5830 : List Nat := [2,4,8,16,32,64,27,5,33,37,73,82,27,2,18,34,97,104,36,18,83,51,35,48,8,115,91,2,49,91,37,32,5,19,96,33]

theorem envBound5830 : H12AffineFastState.Bounded env5830 := by
  intro p hp
  have h : env5830.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5829_5830 : H12AffineEnvironment.transform 6 27 env5829 = env5830 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 27 env5829 == env5830) = true)

theorem identity5830 : scanCanonicalize (H12AffineFastState.compose env5830 (packedSelected [2,4,7,11] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound5830 : packedSelected [2,4,7,11] rootPS < 2^1333 := by decide +kernel

def env5831 : List Nat := [2,4,8,16,1,64,27,5,0,4,73,82,27,2,18,3,64,73,5,18,83,18,2,17,8,82,91,2,16,91,4,1,5,19,65,0]

theorem envBound5831 : H12AffineFastState.Bounded env5831 := by
  intro p hp
  have h : env5831.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5830_5831 : H12AffineEnvironment.transform 4 1 env5830 = env5831 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env5830 == env5831) = true)

theorem identity5831 : scanCanonicalize (H12AffineFastState.compose env5831 (packedSelected [1,2,3] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound5831 : packedSelected [1,2,3] rootPS < 2^1333 := by decide +kernel

def env5832 : List Nat := [2,4,8,16,1,16,27,5,0,4,25,2,27,2,18,3,16,25,5,18,3,18,2,17,8,2,11,2,16,11,4,1,5,19,17,0]

theorem envBound5832 : H12AffineFastState.Bounded env5832 := by
  intro p hp
  have h : env5832.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5831_5832 : H12AffineEnvironment.transform 5 16 env5831 = env5832 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env5831 == env5832) = true)

theorem identity5832 : scanCanonicalize (H12AffineFastState.compose env5832 (packedSelected [0,1] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound5832 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env5833 : List Nat := [2,4,2,16,1,16,17,5,0,4,19,2,17,2,18,3,16,19,5,18,3,18,2,17,2,2,1,2,16,1,4,1,5,19,17,0]

theorem envBound5833 : H12AffineFastState.Bounded env5833 := by
  intro p hp
  have h : env5833.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5832_5833 : H12AffineEnvironment.transform 2 2 env5832 = env5833 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env5832 == env5833) = true)

theorem identity5833 : scanCanonicalize (H12AffineFastState.compose env5833 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound5833 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5834 : List Nat := [2,4,2,3,1,3,2,5,0,4,0,2,2,2,1,3,3,0,5,1,3,1,2,2,2,2,1,2,3,1,4,1,5,0,2,0]

theorem envBound5834 : H12AffineFastState.Bounded env5834 := by
  intro p hp
  have h : env5834.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5833_5834 : H12AffineEnvironment.transform 3 3 env5833 = env5834 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env5833 == env5834) = true)

def env5835 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,42061,262144,42253,32768,45325,370001,5457,98565,33156,5377,107604,4176,1297,298199,41993,4294967296,40972,4295238911,42060,41740]

theorem envBound5835 : H12AffineFastState.Bounded env5835 := by
  intro p hp
  have h : env5835.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5783_5835 : H12AffineEnvironment.transform 21 370001 env5783 = env5835 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 370001 env5783 == env5835) = true)

theorem identity5835 : scanCanonicalize (H12AffineFastState.compose env5835 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 304635) := by decide +kernel

theorem selectedBound5835 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env5836 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,42061,262144,42253,32768,45325,370001,5457,98565,33156,5377,107604,4176,1297,298199,41993,304635,40972,33028,42060,41740]

theorem envBound5836 : H12AffineFastState.Bounded env5836 := by
  intro p hp
  have h : env5836.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5835_5836 : H12AffineEnvironment.transform 31 304635 env5835 = env5836 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 304635 env5835 == env5836) = true)

def env5837 : List Nat := [2,4,8,16,32,64,128,256,32,1024,2048,4096,8192,4176,32768,65536,42061,262144,42253,32768,45325,370001,5457,98565,33156,5377,107604,4176,1297,298199,41993,304635,40972,33028,42060,41260]

theorem envBound5837 : H12AffineFastState.Bounded env5837 := by
  intro p hp
  have h : env5837.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5836_5837 : H12AffineEnvironment.transform 8 32 env5836 = env5837 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 32 env5836 == env5837) = true)

theorem identity5837 : scanCanonicalize (H12AffineFastState.compose env5837 (packedSelected [0,1,3,4,7,9,12,15,16,17,20,21] rootPS)) = affineNative (2^(15+1) ^^^ 5579) := by decide +kernel

theorem selectedBound5837 : packedSelected [0,1,3,4,7,9,12,15,16,17,20,21] rootPS < 2^1333 := by decide +kernel

def env5838 : List Nat := [2,4,8,16,32,64,128,256,32,1024,2048,4096,8192,4176,32768,5579,42061,262144,42253,32768,45325,307354,5457,38094,33156,5377,45471,4176,1297,298199,41993,304635,40972,33028,42060,41260]

theorem envBound5838 : H12AffineFastState.Bounded env5838 := by
  intro p hp
  have h : env5838.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5837_5838 : H12AffineEnvironment.transform 15 5579 env5837 = env5838 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5579 env5837 == env5838) = true)

def env5839 : List Nat := [2,4,8,16,32,64,128,256,32,1024,2048,4096,8192,4176,8200,5579,1093,262144,1285,8200,4357,266386,5457,13510,8588,5377,4503,4176,1297,273631,1025,263667,4,8460,1092,292]

theorem envBound5839 : H12AffineFastState.Bounded env5839 := by
  intro p hp
  have h : env5839.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5838_5839 : H12AffineEnvironment.transform 14 8200 env5838 = env5839 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8200 env5838 == env5839) = true)

theorem identity5839 : scanCanonicalize (H12AffineFastState.compose env5839 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 9554) := by decide +kernel

theorem selectedBound5839 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env5840 : List Nat := [2,4,8,16,32,64,128,256,32,1024,2048,4096,8192,4176,8200,5579,1093,9554,1285,8200,4357,13760,5457,13510,8588,5377,4503,4176,1297,2445,1025,8353,4,8460,1092,292]

theorem envBound5840 : H12AffineFastState.Bounded env5840 := by
  intro p hp
  have h : env5840.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5839_5840 : H12AffineEnvironment.transform 17 9554 env5839 = env5840 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 9554 env5839 == env5840) = true)

theorem identity5840 : scanCanonicalize (H12AffineFastState.compose env5840 (packedSelected [5,8,13,17] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound5840 : packedSelected [5,8,13,17] rootPS < 2^1333 := by decide +kernel

def env5841 : List Nat := [2,4,8,16,32,64,128,4,32,1024,2048,4096,8192,4176,8200,5327,1093,9302,1025,8200,4097,13508,5205,13510,8328,5125,4243,4176,1045,2185,1025,8353,4,8200,1092,32]

theorem envBound5841 : H12AffineFastState.Bounded env5841 := by
  intro p hp
  have h : env5841.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5840_5841 : H12AffineEnvironment.transform 7 4 env5840 = env5841 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env5840 == env5841) = true)

theorem identity5841 : scanCanonicalize (H12AffineFastState.compose env5841 (packedSelected [3,5,10] rootPS)) = affineNative (2^(12+1) ^^^ 4168) := by decide +kernel

theorem selectedBound5841 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env5842 : List Nat := [2,4,8,16,32,64,128,4,32,1024,2048,4096,4168,4176,4160,5327,1093,5150,1025,4160,4097,1164,5205,1166,4288,5125,4243,4176,1045,2185,1025,4329,4,4160,1092,32]

theorem envBound5842 : H12AffineFastState.Bounded env5842 := by
  intro p hp
  have h : env5842.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5841_5842 : H12AffineEnvironment.transform 12 4168 env5841 = env5842 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4168 env5841 == env5842) = true)

theorem identity5842 : scanCanonicalize (H12AffineFastState.compose env5842 (packedSelected [1,5,12] rootPS)) = affineNative (2^(11+1) ^^^ 3134) := by decide +kernel

theorem selectedBound5842 : packedSelected [1,5,12] rootPS < 2^1333 := by decide +kernel

def env5843 : List Nat := [2,4,8,16,32,64,128,4,32,1024,2048,3134,3190,3182,3198,2289,1093,2080,1025,3198,3135,1164,2155,1166,3326,2107,3245,3182,1045,2185,1025,3287,4,3198,1092,32]

theorem envBound5843 : H12AffineFastState.Bounded env5843 := by
  intro p hp
  have h : env5843.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5842_5843 : H12AffineEnvironment.transform 11 3134 env5842 = env5843 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3134 env5842 == env5843) = true)

theorem identity5843 : scanCanonicalize (H12AffineFastState.compose env5843 (packedSelected [1,3,13] rootPS)) = affineNative (2^(10+1) ^^^ 210) := by decide +kernel

theorem selectedBound5843 : packedSelected [1,3,13] rootPS < 2^1333 := by decide +kernel

def env5844 : List Nat := [2,4,8,16,32,64,128,4,32,1024,210,1260,1188,1212,1196,35,1093,242,1025,1196,1261,1164,185,1166,1068,233,1151,1212,1045,91,1025,1029,4,1196,1092,32]

theorem envBound5844 : H12AffineFastState.Bounded env5844 := by
  intro p hp
  have h : env5844.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5843_5844 : H12AffineEnvironment.transform 10 210 env5843 = env5844 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 210 env5843 == env5844) = true)

theorem identity5844 : scanCanonicalize (H12AffineFastState.compose env5844 (packedSelected [1,3,5] rootPS)) = affineNative (2^(9+1) ^^^ 37) := by decide +kernel

theorem selectedBound5844 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env5845 : List Nat := [2,4,8,16,32,64,128,4,32,37,210,201,129,153,137,35,96,242,36,137,200,169,185,171,9,233,90,153,48,91,36,32,4,137,97,32]

theorem envBound5845 : H12AffineFastState.Bounded env5845 := by
  intro p hp
  have h : env5845.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5844_5845 : H12AffineEnvironment.transform 9 37 env5844 = env5845 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 37 env5844 == env5845) = true)

theorem identity5845 : scanCanonicalize (H12AffineFastState.compose env5845 (packedSelected [2,9] rootPS)) = affineNative (2^(6+1) ^^^ 64) := by decide +kernel

theorem selectedBound5845 : packedSelected [2,9] rootPS < 2^1333 := by decide +kernel

def env5846 : List Nat := [2,4,8,16,32,64,64,4,32,37,18,9,65,89,73,35,96,50,36,73,8,105,121,107,9,41,90,89,48,91,36,32,4,73,97,32]

theorem envBound5846 : H12AffineFastState.Bounded env5846 := by
  intro p hp
  have h : env5846.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5845_5846 : H12AffineEnvironment.transform 6 64 env5845 = env5846 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 64 env5845 == env5846) = true)

theorem identity5846 : scanCanonicalize (H12AffineFastState.compose env5846 (packedSelected [2,4,7,11] rootPS)) = affineNative (2^(5+1) ^^^ 9) := by decide +kernel

theorem selectedBound5846 : packedSelected [2,4,7,11] rootPS < 2^1333 := by decide +kernel

def env5847 : List Nat := [2,4,8,16,32,9,9,4,32,37,18,9,8,16,0,35,41,50,36,0,8,32,48,34,9,41,19,16,48,18,36,32,4,0,40,32]

theorem envBound5847 : H12AffineFastState.Bounded env5847 := by
  intro p hp
  have h : env5847.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5846_5847 : H12AffineEnvironment.transform 5 9 env5846 = env5847 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 9 env5846 == env5847) = true)

theorem identity5847 : scanCanonicalize (H12AffineFastState.compose env5847 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 9) := by decide +kernel

theorem selectedBound5847 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5848 : List Nat := [2,4,8,9,32,9,9,4,32,37,11,9,8,9,0,35,41,43,36,0,8,32,41,34,9,41,10,9,41,11,36,32,4,0,40,32]

theorem envBound5848 : H12AffineFastState.Bounded env5848 := by
  intro p hp
  have h : env5848.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5847_5848 : H12AffineEnvironment.transform 3 9 env5847 = env5848 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 9 env5847 == env5848) = true)

theorem identity5848 : scanCanonicalize (H12AffineFastState.compose env5848 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound5848 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5849 : List Nat := [2,4,8,9,0,9,9,4,0,5,11,9,8,9,0,3,9,11,4,0,8,0,9,2,9,9,10,9,9,11,4,0,4,0,8,0]

theorem envBound5849 : H12AffineFastState.Bounded env5849 := by
  intro p hp
  have h : env5849.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5848_5849 : H12AffineEnvironment.transform 4 0 env5848 = env5849 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5848 == env5849) = true)

theorem identity5849 : scanCanonicalize (H12AffineFastState.compose env5849 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 1) := by decide +kernel

theorem selectedBound5849 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env5850 : List Nat := [2,4,1,0,0,0,0,4,0,5,2,0,1,0,0,3,0,2,4,0,1,0,0,2,0,0,3,0,0,2,4,0,4,0,1,0]

theorem envBound5850 : H12AffineFastState.Bounded env5850 := by
  intro p hp
  have h : env5850.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5849_5850 : H12AffineEnvironment.transform 2 1 env5849 = env5850 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env5849 == env5850) = true)

theorem identity5850 : scanCanonicalize (H12AffineFastState.compose env5850 (packedSelected [4] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5850 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env5851 : List Nat := [0,4,1,0,0,0,0,4,0,5,0,0,1,0,0,1,0,0,4,0,1,0,0,0,0,0,1,0,0,0,4,0,4,0,1,0]

theorem envBound5851 : H12AffineFastState.Bounded env5851 := by
  intro p hp
  have h : env5851.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5850_5851 : H12AffineEnvironment.transform 0 0 env5850 = env5851 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5850 == env5851) = true)

def env5852 : List Nat := [2,4,8,16,32,64,128,256,32,1024,2048,4096,8192,4176,8201,5579,1092,262144,1284,8201,4356,266387,5457,13511,8589,5377,4502,4176,1297,273630,1024,263666,5,8461,1093,293]

theorem envBound5852 : H12AffineFastState.Bounded env5852 := by
  intro p hp
  have h : env5852.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5838_5852 : H12AffineEnvironment.transform 14 8201 env5838 = env5852 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8201 env5838 == env5852) = true)

theorem identity5852 : scanCanonicalize (H12AffineFastState.compose env5852 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 9303) := by decide +kernel

theorem selectedBound5852 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env5853 : List Nat := [2,4,8,16,32,64,128,256,32,1024,2048,4096,8192,4176,8201,5579,1092,9303,1284,8201,4356,13508,5457,13511,8589,5377,4502,4176,1297,2185,1024,8613,5,8461,1093,293]

theorem envBound5853 : H12AffineFastState.Bounded env5853 := by
  intro p hp
  have h : env5853.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5852_5853 : H12AffineEnvironment.transform 17 9303 env5852 = env5853 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 9303 env5852 == env5853) = true)

theorem identity5853 : scanCanonicalize (H12AffineFastState.compose env5853 (packedSelected [5,8,13,17] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound5853 : packedSelected [5,8,13,17] rootPS < 2^1333 := by decide +kernel

def env5854 : List Nat := [2,4,8,16,32,64,128,5,32,1024,2048,4096,8192,4176,8201,5326,1092,9303,1025,8201,4097,13508,5204,13511,8328,5124,4243,4176,1044,2185,1024,8352,5,8200,1093,32]

theorem envBound5854 : H12AffineFastState.Bounded env5854 := by
  intro p hp
  have h : env5854.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5853_5854 : H12AffineEnvironment.transform 7 5 env5853 = env5854 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env5853 == env5854) = true)

theorem identity5854 : scanCanonicalize (H12AffineFastState.compose env5854 (packedSelected [3,5,10] rootPS)) = affineNative (2^(12+1) ^^^ 4168) := by decide +kernel

theorem selectedBound5854 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env5855 : List Nat := [2,4,8,16,32,64,128,5,32,1024,2048,4096,4168,4176,4161,5326,1092,5151,1025,4161,4097,1164,5204,1167,4288,5124,4243,4176,1044,2185,1024,4328,5,4160,1093,32]

theorem envBound5855 : H12AffineFastState.Bounded env5855 := by
  intro p hp
  have h : env5855.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5854_5855 : H12AffineEnvironment.transform 12 4168 env5854 = env5855 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4168 env5854 == env5855) = true)

theorem identity5855 : scanCanonicalize (H12AffineFastState.compose env5855 (packedSelected [1,5,12] rootPS)) = affineNative (2^(11+1) ^^^ 3134) := by decide +kernel

theorem selectedBound5855 : packedSelected [1,5,12] rootPS < 2^1333 := by decide +kernel

def env5856 : List Nat := [2,4,8,16,32,64,128,5,32,1024,2048,3134,3190,3182,3199,2288,1092,2081,1025,3199,3135,1164,2154,1167,3326,2106,3245,3182,1044,2185,1024,3286,5,3198,1093,32]

theorem envBound5856 : H12AffineFastState.Bounded env5856 := by
  intro p hp
  have h : env5856.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5855_5856 : H12AffineEnvironment.transform 11 3134 env5855 = env5856 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3134 env5855 == env5856) = true)

theorem identity5856 : scanCanonicalize (H12AffineFastState.compose env5856 (packedSelected [1,3,13] rootPS)) = affineNative (2^(10+1) ^^^ 211) := by decide +kernel

theorem selectedBound5856 : packedSelected [1,3,13] rootPS < 2^1333 := by decide +kernel

def env5857 : List Nat := [2,4,8,16,32,64,128,5,32,1024,211,1261,1189,1213,1196,35,1092,242,1025,1196,1260,1164,185,1167,1069,233,1150,1213,1044,90,1024,1029,5,1197,1093,32]

theorem envBound5857 : H12AffineFastState.Bounded env5857 := by
  intro p hp
  have h : env5857.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5856_5857 : H12AffineEnvironment.transform 10 211 env5856 = env5857 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 211 env5856 == env5857) = true)

theorem identity5857 : scanCanonicalize (H12AffineFastState.compose env5857 (packedSelected [1,3,5] rootPS)) = affineNative (2^(9+1) ^^^ 37) := by decide +kernel

theorem selectedBound5857 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env5858 : List Nat := [2,4,8,16,32,64,128,5,32,37,211,200,128,152,137,35,97,242,36,137,201,169,185,170,8,233,91,152,49,90,37,32,5,136,96,32]

theorem envBound5858 : H12AffineFastState.Bounded env5858 := by
  intro p hp
  have h : env5858.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5857_5858 : H12AffineEnvironment.transform 9 37 env5857 = env5858 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 37 env5857 == env5858) = true)

theorem identity5858 : scanCanonicalize (H12AffineFastState.compose env5858 (packedSelected [2,9] rootPS)) = affineNative (2^(6+1) ^^^ 97) := by decide +kernel

theorem selectedBound5858 : packedSelected [2,9] rootPS < 2^1333 := by decide +kernel

def env5859 : List Nat := [2,4,8,16,32,64,97,5,32,37,50,41,97,121,104,35,97,19,36,104,40,72,88,75,8,8,91,121,49,90,37,32,5,105,96,32]

theorem envBound5859 : H12AffineFastState.Bounded env5859 := by
  intro p hp
  have h : env5859.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5858_5859 : H12AffineEnvironment.transform 6 97 env5858 = env5859 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 97 env5858 == env5859) = true)

theorem identity5859 : scanCanonicalize (H12AffineFastState.compose env5859 (packedSelected [2,4,7,11] rootPS)) = affineNative (2^(5+1) ^^^ 40) := by decide +kernel

theorem selectedBound5859 : packedSelected [2,4,7,11] rootPS < 2^1333 := by decide +kernel

def env5860 : List Nat := [2,4,8,16,32,40,9,5,32,37,50,41,9,17,0,35,9,19,36,0,40,32,48,35,8,8,51,17,49,50,37,32,5,1,8,32]

theorem envBound5860 : H12AffineFastState.Bounded env5860 := by
  intro p hp
  have h : env5860.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5859_5860 : H12AffineEnvironment.transform 5 40 env5859 = env5860 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 40 env5859 == env5860) = true)

theorem identity5860 : scanCanonicalize (H12AffineFastState.compose env5860 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 25) := by decide +kernel

theorem selectedBound5860 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5861 : List Nat := [2,4,8,16,25,17,9,5,25,28,11,16,9,17,0,26,9,19,29,0,17,25,9,26,8,8,10,17,8,11,28,25,5,1,8,25]

theorem envBound5861 : H12AffineFastState.Bounded env5861 := by
  intro p hp
  have h : env5861.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5860_5861 : H12AffineEnvironment.transform 4 25 env5860 = env5861 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 25 env5860 == env5861) = true)

theorem identity5861 : scanCanonicalize (H12AffineFastState.compose env5861 (packedSelected [1,4] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound5861 : packedSelected [1,4] rootPS < 2^1333 := by decide +kernel

def env5862 : List Nat := [2,4,8,2,11,3,9,5,11,14,11,2,9,3,0,8,9,1,15,0,3,11,9,8,8,8,10,3,8,11,14,11,5,1,8,11]

theorem envBound5862 : H12AffineFastState.Bounded env5862 := by
  intro p hp
  have h : env5862.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5861_5862 : H12AffineEnvironment.transform 3 2 env5861 = env5862 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env5861 == env5862) = true)

theorem identity5862 : scanCanonicalize (H12AffineFastState.compose env5862 (packedSelected [1] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound5862 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5863 : List Nat := [2,4,3,2,0,3,2,5,0,5,0,2,2,3,0,3,2,1,4,0,3,0,2,3,3,3,1,3,3,0,5,0,5,1,3,0]

theorem envBound5863 : H12AffineFastState.Bounded env5863 := by
  intro p hp
  have h : env5863.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5862_5863 : H12AffineEnvironment.transform 2 3 env5862 = env5863 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env5862 == env5863) = true)

def leafEnv5863 : List Nat := [2,4,3,2,0,3,2,5,0,5,0,2,2,3,0,3,2,1,4,0,3,0,2,3,4,3,1,3,1,3,3,0,5,0,5,1,4,2,3,0,0,3,1]

def active5863 : List Nat := [0,1]

def tree5863 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5863 : H12WitnessSearch.Good tree5863 := H12GlobalWitnessIndex.good

theorem leafIdentity5863 : H12AffineFastState.composeSystem env5863 rootObs = leafEnv5863 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5863 rootObs == leafEnv5863) = true)

theorem terminalChecked5863 : H12PackedTerminal.terminalCheckFast leafEnv5863 active5863 tree5863 = true := by decide +kernel

def env5864 : List Nat := [2,4,8,16,32,64,128,256,33,1024,2048,4096,8192,4176,32768,65536,42061,262144,42253,32768,45325,370001,5457,98565,33156,5377,107604,4176,1297,298199,41993,304635,40972,33028,42060,41261]

theorem envBound5864 : H12AffineFastState.Bounded env5864 := by
  intro p hp
  have h : env5864.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5836_5864 : H12AffineEnvironment.transform 8 33 env5836 = env5864 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 33 env5836 == env5864) = true)

theorem identity5864 : scanCanonicalize (H12AffineFastState.compose env5864 (packedSelected [0,1,3,4,7,9,12,15,16,17,20,21] rootPS)) = affineNative (2^(15+1) ^^^ 46279) := by decide +kernel

theorem selectedBound5864 : packedSelected [0,1,3,4,7,9,12,15,16,17,20,21] rootPS < 2^1333 := by decide +kernel

def env5865 : List Nat := [2,4,8,16,32,64,128,256,33,1024,2048,4096,8192,4176,32768,46279,42061,262144,42253,32768,45325,266646,5457,13762,33156,5377,4243,4176,1297,298199,41993,304635,40972,33028,42060,41261]

theorem envBound5865 : H12AffineFastState.Bounded env5865 := by
  intro p hp
  have h : env5865.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5864_5865 : H12AffineEnvironment.transform 15 46279 env5864 = env5865 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 46279 env5864 == env5865) = true)

def env5866 : List Nat := [2,4,8,16,32,64,128,256,33,1024,2048,4096,8192,4176,8200,5327,1093,262144,1285,8200,4357,266646,5457,13762,8588,5377,4243,4176,1297,273631,1025,263667,4,8460,1092,293]

theorem envBound5866 : H12AffineFastState.Bounded env5866 := by
  intro p hp
  have h : env5866.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5865_5866 : H12AffineEnvironment.transform 14 8200 env5865 = env5866 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8200 env5865 == env5866) = true)

theorem identity5866 : scanCanonicalize (H12AffineFastState.compose env5866 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 9302) := by decide +kernel

theorem selectedBound5866 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env5867 : List Nat := [2,4,8,16,32,64,128,256,33,1024,2048,4096,8192,4176,8200,5327,1093,9302,1285,8200,4357,13760,5457,13762,8588,5377,4243,4176,1297,2185,1025,8613,4,8460,1092,293]

theorem envBound5867 : H12AffineFastState.Bounded env5867 := by
  intro p hp
  have h : env5867.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5866_5867 : H12AffineEnvironment.transform 17 9302 env5866 = env5867 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 9302 env5866 == env5867) = true)

theorem identity5867 : scanCanonicalize (H12AffineFastState.compose env5867 (packedSelected [5,8,13,17] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound5867 : packedSelected [5,8,13,17] rootPS < 2^1333 := by decide +kernel

def env5868 : List Nat := [2,4,8,16,32,64,128,4,33,1024,2048,4096,8192,4176,8200,5327,1093,9302,1025,8200,4097,13508,5205,13510,8328,5125,4243,4176,1045,2185,1025,8353,4,8200,1092,33]

theorem envBound5868 : H12AffineFastState.Bounded env5868 := by
  intro p hp
  have h : env5868.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5867_5868 : H12AffineEnvironment.transform 7 4 env5867 = env5868 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env5867 == env5868) = true)

theorem identity5868 : scanCanonicalize (H12AffineFastState.compose env5868 (packedSelected [3,5,10] rootPS)) = affineNative (2^(12+1) ^^^ 4169) := by decide +kernel

theorem selectedBound5868 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env5869 : List Nat := [2,4,8,16,32,64,128,4,33,1024,2048,4096,4169,4176,4161,5327,1093,5151,1025,4161,4097,1165,5205,1167,4289,5125,4243,4176,1045,2185,1025,4328,4,4161,1092,33]

theorem envBound5869 : H12AffineFastState.Bounded env5869 := by
  intro p hp
  have h : env5869.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5868_5869 : H12AffineEnvironment.transform 12 4169 env5868 = env5869 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4169 env5868 == env5869) = true)

theorem identity5869 : scanCanonicalize (H12AffineFastState.compose env5869 (packedSelected [1,5,12] rootPS)) = affineNative (2^(11+1) ^^^ 3134) := by decide +kernel

theorem selectedBound5869 : packedSelected [1,5,12] rootPS < 2^1333 := by decide +kernel

def env5870 : List Nat := [2,4,8,16,32,64,128,4,33,1024,2048,3134,3191,3182,3199,2289,1093,2081,1025,3199,3135,1165,2155,1167,3327,2107,3245,3182,1045,2185,1025,3286,4,3199,1092,33]

theorem envBound5870 : H12AffineFastState.Bounded env5870 := by
  intro p hp
  have h : env5870.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5869_5870 : H12AffineEnvironment.transform 11 3134 env5869 = env5870 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3134 env5869 == env5870) = true)

theorem identity5870 : scanCanonicalize (H12AffineFastState.compose env5870 (packedSelected [1,3,13] rootPS)) = affineNative (2^(6+1) ^^^ 120) := by decide +kernel

theorem selectedBound5870 : packedSelected [1,3,13] rootPS < 2^1333 := by decide +kernel

def env5871 : List Nat := [2,4,8,16,32,64,120,4,33,1024,2048,3134,3191,3182,3199,2057,1093,2081,1025,3199,3135,1141,2155,1143,3079,2107,3157,3182,1045,2161,1025,3118,4,3199,1092,33]

theorem envBound5871 : H12AffineFastState.Bounded env5871 := by
  intro p hp
  have h : env5871.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5870_5871 : H12AffineEnvironment.transform 6 120 env5870 = env5871 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 120 env5870 == env5871) = true)

theorem identity5871 : scanCanonicalize (H12AffineFastState.compose env5871 (packedSelected [4,9,16] rootPS)) = affineNative (2^(9+1) ^^^ 5) := by decide +kernel

theorem selectedBound5871 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env5872 : List Nat := [2,4,8,16,32,64,120,4,33,5,2048,2107,2162,2155,2170,2057,64,2081,4,2170,2106,112,2155,114,2050,2107,2128,2155,16,2161,4,2091,4,2170,65,33]

theorem envBound5872 : H12AffineFastState.Bounded env5872 := by
  intro p hp
  have h : env5872.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5871_5872 : H12AffineEnvironment.transform 9 5 env5871 = env5872 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 5 env5871 == env5872) = true)

theorem identity5872 : scanCanonicalize (H12AffineFastState.compose env5872 (packedSelected [0,2,7] rootPS)) = affineNative (2^(10+1) ^^^ 10) := by decide +kernel

theorem selectedBound5872 : packedSelected [0,2,7] rootPS < 2^1333 := by decide +kernel

def env5873 : List Nat := [2,4,8,16,32,64,120,4,33,5,10,49,120,97,112,3,64,43,4,112,48,112,97,114,8,49,90,97,16,123,4,33,4,112,65,33]

theorem envBound5873 : H12AffineFastState.Bounded env5873 := by
  intro p hp
  have h : env5873.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5872_5873 : H12AffineEnvironment.transform 10 10 env5872 = env5873 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 10 env5872 == env5873) = true)

theorem identity5873 : scanCanonicalize (H12AffineFastState.compose env5873 (packedSelected [1,2,3] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound5873 : packedSelected [1,2,3] rootPS < 2^1333 := by decide +kernel

def env5874 : List Nat := [2,4,8,16,32,16,40,4,33,5,10,49,40,49,32,3,16,43,4,32,48,32,49,34,8,49,10,49,16,43,4,33,4,32,17,33]

theorem envBound5874 : H12AffineFastState.Bounded env5874 := by
  intro p hp
  have h : env5874.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5873_5874 : H12AffineEnvironment.transform 5 16 env5873 = env5874 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env5873 == env5874) = true)

theorem identity5874 : scanCanonicalize (H12AffineFastState.compose env5874 (packedSelected [0,1] rootPS)) = affineNative (2^(4+1) ^^^ 9) := by decide +kernel

theorem selectedBound5874 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env5875 : List Nat := [2,4,8,16,9,16,1,4,8,5,10,24,1,24,9,3,16,2,4,9,25,9,24,11,8,24,10,24,16,2,4,8,4,9,17,8]

theorem envBound5875 : H12AffineFastState.Bounded env5875 := by
  intro p hp
  have h : env5875.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5874_5875 : H12AffineEnvironment.transform 4 9 env5874 = env5875 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 9 env5874 == env5875) = true)

theorem identity5875 : scanCanonicalize (H12AffineFastState.compose env5875 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 1) := by decide +kernel

theorem selectedBound5875 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5876 : List Nat := [2,4,1,16,0,16,1,4,1,5,3,17,1,17,0,3,16,2,4,0,16,0,17,2,1,17,3,17,16,2,4,1,4,0,17,1]

theorem envBound5876 : H12AffineFastState.Bounded env5876 := by
  intro p hp
  have h : env5876.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5875_5876 : H12AffineEnvironment.transform 2 1 env5875 = env5876 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env5875 == env5876) = true)

theorem identity5876 : scanCanonicalize (H12AffineFastState.compose env5876 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound5876 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5877 : List Nat := [2,4,1,3,0,3,1,4,1,5,3,2,1,2,0,3,3,2,4,0,3,0,2,2,1,2,3,2,3,2,4,1,4,0,2,1]

theorem envBound5877 : H12AffineFastState.Bounded env5877 := by
  intro p hp
  have h : env5877.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5876_5877 : H12AffineEnvironment.transform 3 3 env5876 = env5877 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env5876 == env5877) = true)

theorem identity5877 : scanCanonicalize (H12AffineFastState.compose env5877 (packedSelected [4] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5877 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env5878 : List Nat := [0,4,1,1,0,1,1,4,1,5,1,0,1,0,0,1,1,0,4,0,1,0,0,0,1,0,1,0,1,0,4,1,4,0,0,1]

theorem envBound5878 : H12AffineFastState.Bounded env5878 := by
  intro p hp
  have h : env5878.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5877_5878 : H12AffineEnvironment.transform 0 0 env5877 = env5878 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5877 == env5878) = true)

def env5879 : List Nat := [2,4,8,16,32,64,128,256,33,1024,2048,4096,8192,4176,8201,5326,1092,262144,1284,8201,4356,266646,5457,13762,8589,5377,4243,4176,1297,273630,1024,263666,5,8461,1093,292]

theorem envBound5879 : H12AffineFastState.Bounded env5879 := by
  intro p hp
  have h : env5879.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5865_5879 : H12AffineEnvironment.transform 14 8201 env5865 = env5879 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8201 env5865 == env5879) = true)

theorem identity5879 : scanCanonicalize (H12AffineFastState.compose env5879 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 9554) := by decide +kernel

theorem selectedBound5879 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env5880 : List Nat := [2,4,8,16,32,64,128,256,33,1024,2048,4096,8192,4176,8201,5326,1092,9554,1284,8201,4356,13508,5457,13762,8589,5377,4243,4176,1297,2444,1024,8352,5,8461,1093,292]

theorem envBound5880 : H12AffineFastState.Bounded env5880 := by
  intro p hp
  have h : env5880.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5879_5880 : H12AffineEnvironment.transform 17 9554 env5879 = env5880 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 9554 env5879 == env5880) = true)

theorem identity5880 : scanCanonicalize (H12AffineFastState.compose env5880 (packedSelected [5,8,13,17] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound5880 : packedSelected [5,8,13,17] rootPS < 2^1333 := by decide +kernel

def env5881 : List Nat := [2,4,8,16,32,64,128,5,33,1024,2048,4096,8192,4176,8201,5326,1092,9303,1025,8201,4097,13508,5204,13511,8328,5124,4243,4176,1044,2185,1024,8352,5,8200,1093,33]

theorem envBound5881 : H12AffineFastState.Bounded env5881 := by
  intro p hp
  have h : env5881.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5880_5881 : H12AffineEnvironment.transform 7 5 env5880 = env5881 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env5880 == env5881) = true)

theorem identity5881 : scanCanonicalize (H12AffineFastState.compose env5881 (packedSelected [3,5,10] rootPS)) = affineNative (2^(12+1) ^^^ 4169) := by decide +kernel

theorem selectedBound5881 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env5882 : List Nat := [2,4,8,16,32,64,128,5,33,1024,2048,4096,4169,4176,4160,5326,1092,5150,1025,4160,4097,1165,5204,1166,4289,5124,4243,4176,1044,2185,1024,4329,5,4161,1093,33]

theorem envBound5882 : H12AffineFastState.Bounded env5882 := by
  intro p hp
  have h : env5882.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5881_5882 : H12AffineEnvironment.transform 12 4169 env5881 = env5882 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4169 env5881 == env5882) = true)

theorem identity5882 : scanCanonicalize (H12AffineFastState.compose env5882 (packedSelected [1,5,12] rootPS)) = affineNative (2^(11+1) ^^^ 3134) := by decide +kernel

theorem selectedBound5882 : packedSelected [1,5,12] rootPS < 2^1333 := by decide +kernel

def env5883 : List Nat := [2,4,8,16,32,64,128,5,33,1024,2048,3134,3191,3182,3198,2288,1092,2080,1025,3198,3135,1165,2154,1166,3327,2106,3245,3182,1044,2185,1024,3287,5,3199,1093,33]

theorem envBound5883 : H12AffineFastState.Bounded env5883 := by
  intro p hp
  have h : env5883.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5882_5883 : H12AffineEnvironment.transform 11 3134 env5882 = env5883 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3134 env5882 == env5883) = true)

theorem identity5883 : scanCanonicalize (H12AffineFastState.compose env5883 (packedSelected [1,3,13] rootPS)) = affineNative (2^(6+1) ^^^ 120) := by decide +kernel

theorem selectedBound5883 : packedSelected [1,3,13] rootPS < 2^1333 := by decide +kernel

def env5884 : List Nat := [2,4,8,16,32,64,120,5,33,1024,2048,3134,3191,3182,3198,2056,1092,2080,1025,3198,3135,1141,2154,1142,3079,2106,3157,3182,1044,2161,1024,3119,5,3199,1093,33]

theorem envBound5884 : H12AffineFastState.Bounded env5884 := by
  intro p hp
  have h : env5884.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5883_5884 : H12AffineEnvironment.transform 6 120 env5883 = env5884 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 120 env5883 == env5884) = true)

theorem identity5884 : scanCanonicalize (H12AffineFastState.compose env5884 (packedSelected [4,9,16] rootPS)) = affineNative (2^(9+1) ^^^ 4) := by decide +kernel

theorem selectedBound5884 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env5885 : List Nat := [2,4,8,16,32,64,120,5,33,4,2048,2106,2163,2154,2170,2056,64,2080,5,2170,2107,113,2154,114,2051,2106,2129,2154,16,2161,4,2091,5,2171,65,33]

theorem envBound5885 : H12AffineFastState.Bounded env5885 := by
  intro p hp
  have h : env5885.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5884_5885 : H12AffineEnvironment.transform 9 4 env5884 = env5885 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 4 env5884 == env5885) = true)

theorem identity5885 : scanCanonicalize (H12AffineFastState.compose env5885 (packedSelected [0,2,7] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound5885 : packedSelected [0,2,7] rootPS < 2^1333 := by decide +kernel

def env5886 : List Nat := [2,4,8,16,0,64,88,5,1,4,2048,2074,2131,2122,2138,2056,64,2048,5,2138,2075,81,2122,82,2051,2074,2129,2122,16,2129,4,2059,5,2139,65,1]

theorem envBound5886 : H12AffineFastState.Bounded env5886 := by
  intro p hp
  have h : env5886.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5885_5886 : H12AffineEnvironment.transform 4 0 env5885 = env5886 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5885 == env5886) = true)

def env5887 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,131393,32768,136512,4194304,17665,98565,33554432,5377,4477269,16384,1297,1073741824,131140,4294967296,132161,4332975158,131073,33563272]

theorem envBound5887 : H12AffineFastState.Bounded env5887 := by
  intro p hp
  have h : env5887.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5778_5887 : H12AffineEnvironment.transform 18 131393 env5778 = env5887 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 131393 env5778 == env5887) = true)

theorem identity5887 : scanCanonicalize (H12AffineFastState.compose env5887 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 4427211) := by decide +kernel

theorem selectedBound5887 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env5888 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,131393,32768,136512,4194304,17665,98565,33554432,5377,4477269,16384,1297,4427211,131140,4294967296,132161,4332975158,131073,33563272]

theorem envBound5888 : H12AffineFastState.Bounded env5888 := by
  intro p hp
  have h : env5888.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5887_5888 : H12AffineEnvironment.transform 29 4427211 env5887 = env5888 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4427211 env5887 == env5888) = true)

theorem identity5888 : scanCanonicalize (H12AffineFastState.compose env5888 (packedSelected [1,5,8,19,24,26] rootPS)) = affineNative (2^(24+1) ^^^ 28889) := by decide +kernel

theorem selectedBound5888 : packedSelected [1,5,8,19,24,26] rootPS < 2^1333 := by decide +kernel

def env5889 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,131393,32768,136512,4194304,17665,98565,28889,5377,4477269,16384,1297,4427211,131140,4294967296,132161,4299392239,131073,21073]

theorem envBound5889 : H12AffineFastState.Bounded env5889 := by
  intro p hp
  have h : env5889.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5888_5889 : H12AffineEnvironment.transform 24 28889 env5888 = env5889 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 28889 env5888 == env5889) = true)

def env5890 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,136513,4194304,17665,16777216,33554432,67108864,4477269,67130625,16876565,1073741824,131141,4294967296,17007941,4417151347,131073,33563272]

theorem envBound5890 : H12AffineFastState.Bounded env5890 := by
  intro p hp
  have h : env5890.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5727_5890 : H12AffineEnvironment.transform 20 136513 env5727 = env5890 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 136513 env5727 == env5890) = true)

def env5891 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,136513,4194304,17665,16777216,33554432,5376,4477269,16385,16876565,1073741824,131141,4294967296,17007941,4350047347,131073,33563272]

theorem envBound5891 : H12AffineFastState.Bounded env5891 := by
  intro p hp
  have h : env5891.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5890_5891 : H12AffineEnvironment.transform 25 5376 env5890 = env5891 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env5890 == env5891) = true)

def env5892 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,136513,4194304,17665,16777216,33554432,5377,4477269,16384,16876565,1073741824,131141,4294967296,17007941,4350047346,131073,33563272]

theorem envBound5892 : H12AffineFastState.Bounded env5892 := by
  intro p hp
  have h : env5892.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5890_5892 : H12AffineEnvironment.transform 25 5377 env5890 = env5892 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env5890 == env5892) = true)

theorem identity5892 : scanCanonicalize (H12AffineFastState.compose env5892 (packedSelected [35] rootPS)) = affineNative (2^(16+1) ^^^ 1345) := by decide +kernel

theorem selectedBound5892 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env5893 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4096,4194304,17665,16777216,33554432,5377,4477269,16384,16876565,1073741824,1284,4294967296,16875524,4350047346,1344,33563272]

theorem envBound5893 : H12AffineFastState.Bounded env5893 := by
  intro p hp
  have h : env5893.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5892_5893 : H12AffineEnvironment.transform 16 1345 env5892 = env5893 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env5892 == env5893) = true)

theorem identity5893 : scanCanonicalize (H12AffineFastState.compose env5893 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(24+1) ^^^ 8328) := by decide +kernel

theorem selectedBound5893 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

end H12GlobalChart2
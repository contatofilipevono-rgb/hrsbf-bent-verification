import H12GlobalChart2Data018

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem envTrans4649_4650 : H12AffineEnvironment.transform 15 33167 env4649 = env4650 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33167 env4649 == env4650) = true)

theorem identity4650 : scanCanonicalize (H12AffineFastState.compose env4650 (packedSelected [1,3] rootPS)) = affineNative (2^(14+1) ^^^ 1344) := by decide +kernel

theorem selectedBound4650 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4651 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1296,268,1344,1344,1231,1344,1124,1025,1344,1297,260,65,138,389,16,1124,1344,1297,0,1285,4294967296,256,4294967589,1344,136]

theorem envBound4651 : H12AffineFastState.Bounded env4651 := by
  intro p hp
  have h : env4651.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4650_4651 : H12AffineEnvironment.transform 14 1344 env4650 = env4651 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 1344 env4650 == env4651) = true)

theorem identity4651 : scanCanonicalize (H12AffineFastState.compose env4651 (packedSelected [2,4] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound4651 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env4652 : List Nat := [2,4,8,16,32,64,9,256,0,1024,0,1296,268,1344,1344,1094,1344,1124,1025,1344,1297,260,65,3,268,16,1124,1344,1297,0,1285,4294967296,256,4294967589,1344,1]

theorem envBound4652 : H12AffineFastState.Bounded env4652 := by
  intro p hp
  have h : env4652.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4651_4652 : H12AffineEnvironment.transform 6 9 env4651 = env4652 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env4651 == env4652) = true)

theorem identity4652 : scanCanonicalize (H12AffineFastState.compose env4652 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 1102) := by decide +kernel

theorem selectedBound4652 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4653 : List Nat := [2,4,8,16,32,64,9,256,0,1024,0,1296,268,1344,1344,1094,1344,1124,1025,1344,1297,260,65,3,268,16,1124,1344,1297,0,1285,1102,256,1387,1344,1]

theorem envBound4653 : H12AffineFastState.Bounded env4653 := by
  intro p hp
  have h : env4653.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4652_4653 : H12AffineEnvironment.transform 31 1102 env4652 = env4653 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1102 env4652 == env4653) = true)

theorem identity4653 : scanCanonicalize (H12AffineFastState.compose env4653 (packedSelected [5] rootPS)) = affineNative (2^(9+1) ^^^ 53) := by decide +kernel

theorem selectedBound4653 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env4654 : List Nat := [2,4,8,16,32,64,9,256,0,53,0,293,268,373,373,115,373,81,52,373,292,260,65,3,268,16,81,373,292,0,304,123,256,350,373,1]

theorem envBound4654 : H12AffineFastState.Bounded env4654 := by
  intro p hp
  have h : env4654.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4653_4654 : H12AffineEnvironment.transform 9 53 env4653 = env4654 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 53 env4653 == env4654) = true)

def env4655 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,1344,262144,524288,32768,4097,8200,5457,16777216,8329,16880645,270604,16879957,16876564,17311110,1285,4294967296,16875525,4295599527,1344,513]

theorem envBound4655 : H12AffineFastState.Bounded env4655 := by
  intro p hp
  have h : env4655.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4619_4655 : H12AffineEnvironment.transform 10 1 env4619 = env4655 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env4619 == env4655) = true)

theorem identity4655 : scanCanonicalize (H12AffineFastState.compose env4655 (packedSelected [11] rootPS)) = affineNative (2^(23+1) ^^^ 791314) := by decide +kernel

theorem selectedBound4655 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env4656 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,1344,262144,524288,32768,4097,8200,5457,791314,8329,886551,270604,885319,890630,276116,1285,4294967296,889623,4295599527,1344,513]

theorem envBound4656 : H12AffineFastState.Bounded env4656 := by
  intro p hp
  have h : env4656.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4655_4656 : H12AffineEnvironment.transform 23 791314 env4655 = env4656 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 791314 env4655 == env4656) = true)

def env4657 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,1344,0,524288,32768,4097,8200,5457,529170,8329,624407,8460,623175,628486,13972,1285,4294967296,627479,4295599527,1344,513]

theorem envBound4657 : H12AffineFastState.Bounded env4657 := by
  intro p hp
  have h : env4657.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4656_4657 : H12AffineEnvironment.transform 17 0 env4656 = env4657 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env4656 == env4657) = true)

theorem identity4657 : scanCanonicalize (H12AffineFastState.compose env4657 (packedSelected [0,7] rootPS)) = affineNative (2^(14+1) ^^^ 5820) := by decide +kernel

theorem selectedBound4657 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4658 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,5820,65536,1344,0,524288,5820,4097,8200,5457,529170,8329,594347,8460,595195,590266,13972,1285,4294967296,591275,4295570203,1344,513]

theorem envBound4658 : H12AffineFastState.Bounded env4658 := by
  intro p hp
  have h : env4658.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4657_4658 : H12AffineEnvironment.transform 14 5820 env4657 = env4658 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 5820 env4657 == env4658) = true)

theorem identity4658 : scanCanonicalize (H12AffineFastState.compose env4658 (packedSelected [9,22,23] rootPS)) = affineNative (2^(12+1) ^^^ 5780) := by decide +kernel

theorem selectedBound4658 : packedSelected [9,22,23] rootPS < 2^1333 := by decide +kernel

def env4659 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,5780,4176,5820,65536,1344,0,524288,5820,4097,5788,5457,529170,5661,594347,6040,595195,590266,0,1285,4294967296,591275,4295558543,1344,513]

theorem envBound4659 : H12AffineFastState.Bounded env4659 := by
  intro p hp
  have h : env4659.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4658_4659 : H12AffineEnvironment.transform 12 5780 env4658 = env4659 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5780 env4658 == env4659) = true)

theorem identity4659 : scanCanonicalize (H12AffineFastState.compose env4659 (packedSelected [18,20] rootPS)) = affineNative (2^(18+1) ^^^ 70451) := by decide +kernel

theorem selectedBound4659 : packedSelected [18,20] rootPS < 2^1333 := by decide +kernel

def env4660 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,5780,4176,5820,65536,1344,0,70451,5820,4097,5788,5457,65569,5661,664,6040,1992,4745,0,1285,4294967296,5784,4294973116,1344,513]

theorem envBound4660 : H12AffineFastState.Bounded env4660 := by
  intro p hp
  have h : env4660.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4659_4660 : H12AffineEnvironment.transform 18 70451 env4659 = env4660 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 70451 env4659 == env4660) = true)

theorem identity4660 : scanCanonicalize (H12AffineFastState.compose env4660 (packedSelected [0,2,5,6,8,9,10,12,17] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound4660 : packedSelected [0,2,5,6,8,9,10,12,17] rootPS < 2^1333 := by decide +kernel

def env4661 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,4096,5148,4176,5172,65536,1344,0,70075,5172,4097,5140,5457,65569,5269,16,5392,1344,4097,0,1285,4294967296,5136,4294972468,1344,137]

theorem envBound4661 : H12AffineFastState.Bounded env4661 := by
  intro p hp
  have h : env4661.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4660_4661 : H12AffineEnvironment.transform 8 136 env4660 = env4661 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env4660 == env4661) = true)

theorem identity4661 : scanCanonicalize (H12AffineFastState.compose env4661 (packedSelected [5,12,13,28] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound4661 : packedSelected [5,12,13,28] rootPS < 2^1333 := by decide +kernel

def env4662 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,1296,268,1344,292,65536,1344,0,66731,292,1297,260,65,65569,389,16,0,1344,1297,0,1285,4294967296,256,4294967588,1344,137]

theorem envBound4662 : H12AffineFastState.Bounded env4662 := by
  intro p hp
  have h : env4662.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4661_4662 : H12AffineEnvironment.transform 11 1296 env4661 = env4662 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env4661 == env4662) = true)

def env4663 : List Nat := [2,4,8,16,32,64,128,36,136,1024,1,1076,40,1124,0,65536,1124,0,66731,0,1077,32,65,65569,161,16,0,1124,1077,0,1057,4294967296,36,4294967296,1124,137]

theorem envBound4663 : H12AffineFastState.Bounded env4663 := by
  intro p hp
  have h : env4663.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4662_4663 : H12AffineEnvironment.transform 7 36 env4662 = env4663 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env4662 == env4663) = true)

theorem identity4663 : scanCanonicalize (H12AffineFastState.compose env4663 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 65664) := by decide +kernel

theorem selectedBound4663 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4664 : List Nat := [2,4,8,16,32,64,128,36,136,1024,1,1076,40,1124,0,65536,1124,0,66731,0,1077,32,65,65569,161,16,0,1124,1077,0,1057,65664,36,65664,1124,137]

theorem envBound4664 : H12AffineFastState.Bounded env4664 := by
  intro p hp
  have h : env4664.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4663_4664 : H12AffineEnvironment.transform 31 65664 env4663 = env4664 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65664 env4663 == env4664) = true)

theorem identity4664 : scanCanonicalize (H12AffineFastState.compose env4664 (packedSelected [1,3,4] rootPS)) = affineNative (2^(15+1) ^^^ 176) := by decide +kernel

theorem selectedBound4664 : packedSelected [1,3,4] rootPS < 2^1333 := by decide +kernel

def env4665 : List Nat := [2,4,8,16,32,64,128,36,136,1024,1,1076,40,1124,0,176,1124,0,1051,0,1077,32,65,145,161,16,0,1124,1077,0,1057,48,36,48,1124,137]

theorem envBound4665 : H12AffineFastState.Bounded env4665 := by
  intro p hp
  have h : env4665.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4664_4665 : H12AffineEnvironment.transform 15 176 env4664 = env4665 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 176 env4664 == env4665) = true)

theorem identity4665 : scanCanonicalize (H12AffineFastState.compose env4665 (packedSelected [2,5] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound4665 : packedSelected [2,5] rootPS < 2^1333 := by decide +kernel

def env4666 : List Nat := [2,4,8,10,32,64,128,36,136,1024,1,1070,40,1124,0,170,1124,0,1025,0,1071,32,65,139,161,10,0,1124,1071,0,1057,42,36,42,1124,137]

theorem envBound4666 : H12AffineFastState.Bounded env4666 := by
  intro p hp
  have h : env4666.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4665_4666 : H12AffineEnvironment.transform 3 10 env4665 = env4666 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env4665 == env4666) = true)

theorem identity4666 : scanCanonicalize (H12AffineFastState.compose env4666 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 72) := by decide +kernel

theorem selectedBound4666 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4667 : List Nat := [2,4,8,10,32,64,72,36,64,1024,1,1070,40,1124,0,98,1124,0,1025,0,1071,32,65,67,105,10,0,1124,1071,0,1057,42,36,42,1124,65]

theorem envBound4667 : H12AffineFastState.Bounded env4667 := by
  intro p hp
  have h : env4667.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4666_4667 : H12AffineEnvironment.transform 6 72 env4666 = env4667 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 72 env4666 == env4667) = true)

def env4668 : List Nat := [2,4,8,16,32,64,128,37,136,1024,1,1077,41,1125,1,65536,1125,0,66731,1,1076,33,65,65569,160,16,0,1125,1076,0,1056,4294967296,37,4294967297,1125,137]

theorem envBound4668 : H12AffineFastState.Bounded env4668 := by
  intro p hp
  have h : env4668.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4662_4668 : H12AffineEnvironment.transform 7 37 env4662 = env4668 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env4662 == env4668) = true)

theorem identity4668 : scanCanonicalize (H12AffineFastState.compose env4668 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 163) := by decide +kernel

theorem selectedBound4668 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4669 : List Nat := [2,4,8,16,32,64,128,37,136,1024,1,1077,41,1125,1,65536,1125,0,66731,1,1076,33,65,65569,160,16,0,1125,1076,0,1056,163,37,162,1125,137]

theorem envBound4669 : H12AffineFastState.Bounded env4669 := by
  intro p hp
  have h : env4669.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4668_4669 : H12AffineEnvironment.transform 31 163 env4668 = env4669 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 163 env4668 == env4669) = true)

theorem identity4669 : scanCanonicalize (H12AffineFastState.compose env4669 (packedSelected [1,3,4] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound4669 : packedSelected [1,3,4] rootPS < 2^1333 := by decide +kernel

def env4670 : List Nat := [2,4,8,1,32,64,128,37,136,1024,1,1060,41,1125,1,65536,1125,0,66731,1,1061,33,65,65569,160,1,0,1125,1061,0,1056,163,37,162,1125,137]

theorem envBound4670 : H12AffineFastState.Bounded env4670 := by
  intro p hp
  have h : env4670.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4669_4670 : H12AffineEnvironment.transform 3 1 env4669 = env4670 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env4669 == env4670) = true)

def env4671 : List Nat := [2,4,8,1,32,64,128,37,136,1024,1,1060,41,1125,1,192,1125,0,1131,1,1061,33,65,225,160,1,0,1125,1061,0,1056,163,37,162,1125,137]

theorem envBound4671 : H12AffineFastState.Bounded env4671 := by
  intro p hp
  have h : env4671.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4670_4671 : H12AffineEnvironment.transform 15 192 env4670 = env4671 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 192 env4670 == env4671) = true)

def env4672 : List Nat := [2,4,8,1,32,64,104,37,96,1024,1,1060,41,1125,1,40,1125,0,1131,1,1061,33,65,9,72,1,0,1125,1061,0,1056,75,37,74,1125,97]

theorem envBound4672 : H12AffineFastState.Bounded env4672 := by
  intro p hp
  have h : env4672.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4671_4672 : H12AffineEnvironment.transform 6 104 env4671 = env4672 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 104 env4671 == env4672) = true)

theorem identity4672 : scanCanonicalize (H12AffineFastState.compose env4672 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 42) := by decide +kernel

theorem selectedBound4672 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4673 : List Nat := [2,4,8,1,32,42,2,37,10,1024,1,1060,41,1039,1,40,1039,0,1025,1,1061,33,43,9,34,1,0,1039,1061,0,1056,33,37,32,1039,11]

theorem envBound4673 : H12AffineFastState.Bounded env4673 := by
  intro p hp
  have h : env4673.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4672_4673 : H12AffineEnvironment.transform 5 42 env4672 = env4673 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 42 env4672 == env4673) = true)

def leafEnv4673 : List Nat := [2,4,8,1,32,42,2,37,10,1024,1,1060,41,1039,1,40,1039,0,1025,1,1061,33,43,9,1057,34,1,1,0,1039,1061,0,1056,33,37,32,4,34,1039,11,0,1060,1]

def active4673 : List Nat := [0,1,2,4,9]

def tree4673 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4673 : H12WitnessSearch.Good tree4673 := H12GlobalWitnessIndex.good

theorem leafIdentity4673 : H12AffineFastState.composeSystem env4673 rootObs = leafEnv4673 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4673 rootObs == leafEnv4673) = true)

theorem terminalChecked4673 : H12PackedTerminal.terminalCheckFast leafEnv4673 active4673 tree4673 = true := by decide +kernel

def env4674 : List Nat := [2,4,8,1,32,64,105,37,97,1024,1,1060,41,1125,1,41,1125,0,1131,1,1061,33,65,8,73,1,0,1125,1061,0,1056,74,37,75,1125,96]

theorem envBound4674 : H12AffineFastState.Bounded env4674 := by
  intro p hp
  have h : env4674.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4671_4674 : H12AffineEnvironment.transform 6 105 env4671 = env4674 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 105 env4671 == env4674) = true)

def env4675 : List Nat := [2,4,8,1,0,64,73,5,65,1024,1,1028,9,1093,1,9,1093,0,1099,1,1029,1,65,8,73,1,0,1093,1029,0,1024,74,5,75,1093,64]

theorem envBound4675 : H12AffineFastState.Bounded env4675 := by
  intro p hp
  have h : env4675.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4674_4675 : H12AffineEnvironment.transform 4 0 env4674 = env4675 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4674 == env4675) = true)

def leafEnv4675 : List Nat := [2,4,8,1,0,64,73,5,65,1024,1,1028,9,1093,1,9,1093,0,1099,1,1029,1,65,8,1099,73,1,1,0,1093,1029,0,1024,74,5,75,4,2,1093,64,0,1028,1]

def active4675 : List Nat := [0,1,2,5,9]

def tree4675 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4675 : H12WitnessSearch.Good tree4675 := H12GlobalWitnessIndex.good

theorem leafIdentity4675 : H12AffineFastState.composeSystem env4675 rootObs = leafEnv4675 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4675 rootObs == leafEnv4675) = true)

theorem terminalChecked4675 : H12PackedTerminal.terminalCheckFast leafEnv4675 active4675 tree4675 = true := by decide +kernel

def env4676 : List Nat := [2,4,8,1,1,64,72,4,64,1024,1,1029,8,1092,1,8,1092,0,1098,1,1028,0,65,8,73,1,0,1092,1028,0,1025,74,4,75,1092,65]

theorem envBound4676 : H12AffineFastState.Bounded env4676 := by
  intro p hp
  have h : env4676.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4674_4676 : H12AffineEnvironment.transform 4 1 env4674 = env4676 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4674 == env4676) = true)

theorem identity4676 : scanCanonicalize (H12AffineFastState.compose env4676 (packedSelected [3] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound4676 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4677 : List Nat := [2,4,8,1,1,11,3,4,11,1024,1,1029,8,1039,1,8,1039,0,1025,1,1028,0,10,8,2,1,0,1039,1028,0,1025,1,4,0,1039,10]

theorem envBound4677 : H12AffineFastState.Bounded env4677 := by
  intro p hp
  have h : env4677.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4676_4677 : H12AffineEnvironment.transform 5 11 env4676 = env4677 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env4676 == env4677) = true)

def leafEnv4677 : List Nat := [2,4,8,1,1,11,3,4,11,1024,1,1029,8,1039,1,8,1039,0,1025,1,1028,0,10,8,1024,2,1,1,0,1039,1028,0,1025,1,4,0,4,3,1039,10,0,1029,1]

def active4677 : List Nat := [0,1,2,9]

def tree4677 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4677 : H12WitnessSearch.Good tree4677 := H12GlobalWitnessIndex.good

theorem leafIdentity4677 : H12AffineFastState.composeSystem env4677 rootObs = leafEnv4677 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4677 rootObs == leafEnv4677) = true)

theorem terminalChecked4677 : H12PackedTerminal.terminalCheckFast leafEnv4677 active4677 tree4677 = true := by decide +kernel

def env4678 : List Nat := [2,4,8,1,32,64,128,37,136,1024,1,1060,41,1125,1,193,1125,0,1130,1,1061,33,65,224,160,1,0,1125,1061,0,1056,163,37,162,1125,137]

theorem envBound4678 : H12AffineFastState.Bounded env4678 := by
  intro p hp
  have h : env4678.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4670_4678 : H12AffineEnvironment.transform 15 193 env4670 = env4678 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 193 env4670 == env4678) = true)

theorem identity4678 : scanCanonicalize (H12AffineFastState.compose env4678 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 43) := by decide +kernel

theorem selectedBound4678 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4679 : List Nat := [2,4,8,1,32,43,128,37,136,1024,1,1060,41,1038,1,170,1038,0,1025,1,1061,33,42,139,160,1,0,1038,1061,0,1056,163,37,162,1038,137]

theorem envBound4679 : H12AffineFastState.Bounded env4679 := by
  intro p hp
  have h : env4679.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4678_4679 : H12AffineEnvironment.transform 5 43 env4678 = env4679 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 43 env4678 == env4679) = true)

def leafEnv4679 : List Nat := [2,4,8,1,32,43,128,37,136,1024,1,1060,41,1038,1,170,1038,0,1025,1,1061,33,42,139,1057,160,1,1,0,1038,1061,0,1056,163,37,162,4,34,1038,137,0,1060,1]

def active4679 : List Nat := [0,1,2,4,6,9]

def tree4679 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4679 : H12WitnessSearch.Good tree4679 := H12GlobalWitnessIndex.good

theorem leafIdentity4679 : H12AffineFastState.composeSystem env4679 rootObs = leafEnv4679 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4679 rootObs == leafEnv4679) = true)

theorem terminalChecked4679 : H12PackedTerminal.terminalCheckFast leafEnv4679 active4679 tree4679 = true := by decide +kernel

def env4680 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,1344,1,524288,32768,4097,8200,5457,529171,8329,624406,8461,623174,628487,13973,1285,4294967296,627478,4295599527,1344,513]

theorem envBound4680 : H12AffineFastState.Bounded env4680 := by
  intro p hp
  have h : env4680.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4656_4680 : H12AffineEnvironment.transform 17 1 env4656 = env4680 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env4656 == env4680) = true)

theorem identity4680 : scanCanonicalize (H12AffineFastState.compose env4680 (packedSelected [0,7] rootPS)) = affineNative (2^(14+1) ^^^ 14257) := by decide +kernel

theorem selectedBound4680 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4681 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,14257,65536,1344,1,524288,14257,4097,8200,5457,529171,8329,602279,8461,603639,598198,13973,1285,4294967296,599207,4295561750,1344,513]

theorem envBound4681 : H12AffineFastState.Bounded env4681 := by
  intro p hp
  have h : env4681.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4680_4681 : H12AffineEnvironment.transform 14 14257 env4680 = env4681 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 14257 env4680 == env4681) = true)

theorem identity4681 : scanCanonicalize (H12AffineFastState.compose env4681 (packedSelected [0,2,3,5,6,9,10,13,18,20,21] rootPS)) = affineNative (2^(18+1) ^^^ 70451) := by decide +kernel

theorem selectedBound4681 : packedSelected [0,2,3,5,6,9,10,13,18,20,21] rootPS < 2^1333 := by decide +kernel

def env4682 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,14257,65536,1344,1,70451,14257,4097,8200,5457,65568,8329,9108,8461,9924,13189,13973,1285,4294967296,14228,4294967589,1344,513]

theorem envBound4682 : H12AffineFastState.Bounded env4682 := by
  intro p hp
  have h : env4682.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4681_4682 : H12AffineEnvironment.transform 18 70451 env4681 = env4682 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 70451 env4681 == env4682) = true)

theorem identity4682 : scanCanonicalize (H12AffineFastState.compose env4682 (packedSelected [0,1,2,3,4,6,10,13,15,18] rootPS)) = affineNative (2^(11+1) ^^^ 1944) := by decide +kernel

theorem selectedBound4682 : packedSelected [0,1,2,3,4,6,10,13,15,18] rootPS < 2^1333 := by decide +kernel

def env4683 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1944,8192,1992,8233,65536,1344,1,66731,8233,1945,8200,713,65568,8329,9108,8461,9924,9245,8461,1285,4294967296,8204,4294967589,1344,513]

theorem envBound4683 : H12AffineFastState.Bounded env4683 := by
  intro p hp
  have h : env4683.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4682_4683 : H12AffineEnvironment.transform 11 1944 env4682 = env4683 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env4682 == env4683) = true)

theorem identity4683 : scanCanonicalize (H12AffineFastState.compose env4683 (packedSelected [0,2,5,6,8,9,10,12,17] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound4683 : packedSelected [0,2,5,6,8,9,10,12,17] rootPS < 2^1333 := by decide +kernel

def env4684 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1297,8192,1345,8233,65536,1344,1,66731,8233,1296,8200,64,65568,8329,8477,8461,9293,9245,8461,1285,4294967296,8204,4294967589,1344,136]

theorem envBound4684 : H12AffineFastState.Bounded env4684 := by
  intro p hp
  have h : env4684.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4683_4684 : H12AffineEnvironment.transform 8 137 env4683 = env4684 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env4683 == env4684) = true)

theorem identity4684 : scanCanonicalize (H12AffineFastState.compose env4684 (packedSelected [0,2,6,9] rootPS)) = affineNative (2^(15+1) ^^^ 170) := by decide +kernel

theorem selectedBound4684 : packedSelected [0,2,6,9] rootPS < 2^1333 := by decide +kernel

def env4685 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1297,8192,1345,8233,170,1344,1,1025,8233,1296,8200,64,138,8329,8477,8461,9293,9245,8461,1285,4294967296,8204,4294967589,1344,136]

theorem envBound4685 : H12AffineFastState.Bounded env4685 := by
  intro p hp
  have h : env4685.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4684_4685 : H12AffineEnvironment.transform 15 170 env4684 = env4685 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 170 env4684 == env4685) = true)

def env4686 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1345,262144,524288,32768,4097,8201,5457,16777216,8329,16880644,270604,16879956,16876564,1073741824,1284,4294967296,16875524,4295599527,1345,513]

theorem envBound4686 : H12AffineFastState.Bounded env4686 := by
  intro p hp
  have h : env4686.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4617_4686 : H12AffineEnvironment.transform 16 1345 env4617 = env4686 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env4617 == env4686) = true)

theorem identity4686 : scanCanonicalize (H12AffineFastState.compose env4686 (packedSelected [4,9,16] rootPS)) = affineNative (2^(29+1) ^^^ 108674) := by decide +kernel

theorem selectedBound4686 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env4687 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1345,262144,524288,32768,4097,8201,5457,16777216,8329,16880644,270604,16879956,16876564,108674,1284,4294967296,16875524,4295599527,1345,513]

theorem envBound4687 : H12AffineFastState.Bounded env4687 := by
  intro p hp
  have h : env4687.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4686_4687 : H12AffineEnvironment.transform 29 108674 env4686 = env4687 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 108674 env4686 == env4687) = true)

def env4688 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,1345,262144,524288,32768,4097,8201,5457,16777216,8329,16880644,270604,16879956,16876564,106626,1284,4294967296,16875524,4295599527,1345,513]

theorem envBound4688 : H12AffineFastState.Bounded env4688 := by
  intro p hp
  have h : env4688.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4687_4688 : H12AffineEnvironment.transform 10 0 env4687 = env4688 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env4687 == env4688) = true)

theorem identity4688 : scanCanonicalize (H12AffineFastState.compose env4688 (packedSelected [11] rootPS)) = affineNative (2^(15+1) ^^^ 13886) := by decide +kernel

theorem selectedBound4688 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env4689 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,13886,1345,262144,524288,32768,4097,8201,5457,16777216,8329,16818746,270604,16820074,16822826,38588,1284,4294967296,16823866,4295529369,1345,513]

theorem envBound4689 : H12AffineFastState.Bounded env4689 := by
  intro p hp
  have h : env4689.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4688_4689 : H12AffineEnvironment.transform 15 13886 env4688 = env4689 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13886 env4688 == env4689) = true)

def env4690 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,13886,1345,0,524288,32768,4097,8201,5457,16777216,8329,16818746,8460,16820074,16822826,38588,1284,4294967296,16823866,4295529369,1345,513]

theorem envBound4690 : H12AffineFastState.Bounded env4690 := by
  intro p hp
  have h : env4690.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4689_4690 : H12AffineEnvironment.transform 17 0 env4689 = env4690 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env4689 == env4690) = true)

theorem identity4690 : scanCanonicalize (H12AffineFastState.compose env4690 (packedSelected [0,7] rootPS)) = affineNative (2^(23+1) ^^^ 46906) := by decide +kernel

theorem selectedBound4690 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4691 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,13886,1345,0,524288,32768,4097,8201,5457,46906,8329,5376,8460,4176,1296,38588,1284,4294967296,256,4295529369,1345,513]

theorem envBound4691 : H12AffineFastState.Bounded env4691 := by
  intro p hp
  have h : env4691.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4690_4691 : H12AffineEnvironment.transform 23 46906 env4690 = env4691 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 46906 env4690 == env4691) = true)

theorem identity4691 : scanCanonicalize (H12AffineFastState.compose env4691 (packedSelected [0,2,6,9] rootPS)) = affineNative (2^(18+1) ^^^ 1024) := by decide +kernel

theorem selectedBound4691 : packedSelected [0,2,6,9] rootPS < 2^1333 := by decide +kernel

def env4692 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,13886,1345,0,1024,32768,4097,8201,5457,46906,8329,5376,8460,4176,1296,38588,1284,4294967296,256,4295006105,1345,513]

theorem envBound4692 : H12AffineFastState.Bounded env4692 := by
  intro p hp
  have h : env4692.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4691_4692 : H12AffineEnvironment.transform 18 1024 env4691 = env4692 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env4691 == env4692) = true)

theorem identity4692 : scanCanonicalize (H12AffineFastState.compose env4692 (packedSelected [3,5,10] rootPS)) = affineNative (2^(8+1) ^^^ 0) := by decide +kernel

theorem selectedBound4692 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env4693 : List Nat := [2,4,8,16,32,64,128,256,0,1024,0,4096,8192,4176,32768,13374,1345,0,1024,32768,4097,8201,5457,46394,8329,5376,8460,4176,1296,38076,1284,4294967296,256,4295005593,1345,1]

theorem envBound4693 : H12AffineFastState.Bounded env4693 := by
  intro p hp
  have h : env4693.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4692_4693 : H12AffineEnvironment.transform 8 0 env4692 = env4693 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 0 env4692 == env4693) = true)

theorem identity4693 : scanCanonicalize (H12AffineFastState.compose env4693 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(14+1) ^^^ 5529) := by decide +kernel

theorem selectedBound4693 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env4694 : List Nat := [2,4,8,16,32,64,128,256,0,1024,0,4096,8192,4176,5529,13374,1345,0,1024,5529,4097,8201,5457,8355,8329,5376,8460,4176,1296,293,1284,4294967296,256,4294967296,1345,1]

theorem envBound4694 : H12AffineFastState.Bounded env4694 := by
  intro p hp
  have h : env4694.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4693_4694 : H12AffineEnvironment.transform 14 5529 env4693 = env4694 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 5529 env4693 == env4694) = true)

theorem identity4694 : scanCanonicalize (H12AffineFastState.compose env4694 (packedSelected [5,8,13,17] rootPS)) = affineNative (2^(12+1) ^^^ 5149) := by decide +kernel

theorem selectedBound4694 : packedSelected [5,8,13,17] rootPS < 2^1333 := by decide +kernel

def env4695 : List Nat := [2,4,8,16,32,64,128,256,0,1024,0,4096,5149,4176,5529,35,1345,0,1024,5529,4097,5140,5457,5310,5268,5376,5393,4176,1296,293,1284,4294967296,256,4294967296,1345,1]

theorem envBound4695 : H12AffineFastState.Bounded env4695 := by
  intro p hp
  have h : env4695.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4694_4695 : H12AffineEnvironment.transform 12 5149 env4694 = env4695 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5149 env4694 == env4695) = true)

theorem identity4695 : scanCanonicalize (H12AffineFastState.compose env4695 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 5367) := by decide +kernel

theorem selectedBound4695 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4696 : List Nat := [2,4,8,16,32,64,128,256,0,1024,0,4096,5149,4176,5529,35,1345,0,1024,5529,4097,5140,5457,5310,5268,5376,5393,4176,1296,293,1284,5367,256,5367,1345,1]

theorem envBound4696 : H12AffineFastState.Bounded env4696 := by
  intro p hp
  have h : env4696.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4695_4696 : H12AffineEnvironment.transform 31 5367 env4695 = env4696 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 5367 env4695 == env4696) = true)

theorem identity4696 : scanCanonicalize (H12AffineFastState.compose env4696 (packedSelected [3,12] rootPS)) = affineNative (2^(11+1) ^^^ 131) := by decide +kernel

theorem selectedBound4696 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env4697 : List Nat := [2,4,8,16,32,64,128,256,0,1024,0,131,1182,211,1306,35,1345,0,1024,1306,130,1175,1490,1085,1047,1411,1426,211,1296,293,1284,1140,256,1140,1345,1]

theorem envBound4697 : H12AffineFastState.Bounded env4697 := by
  intro p hp
  have h : env4697.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4696_4697 : H12AffineEnvironment.transform 11 131 env4696 = env4697 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 131 env4696 == env4697) = true)

theorem identity4697 : scanCanonicalize (H12AffineFastState.compose env4697 (packedSelected [2,4,5,13] rootPS)) = affineNative (2^(9+1) ^^^ 498) := by decide +kernel

theorem selectedBound4697 : packedSelected [2,4,5,13] rootPS < 2^1333 := by decide +kernel

def env4698 : List Nat := [2,4,8,16,32,64,128,256,0,498,0,131,364,211,232,35,179,0,498,232,130,357,32,463,485,113,96,211,226,293,246,390,256,390,179,1]

theorem envBound4698 : H12AffineFastState.Bounded env4698 := by
  intro p hp
  have h : env4698.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4697_4698 : H12AffineEnvironment.transform 9 498 env4697 = env4698 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 498 env4697 == env4698) = true)

theorem identity4698 : scanCanonicalize (H12AffineFastState.compose env4698 (packedSelected [20] rootPS)) = affineNative (2^(6+1) ^^^ 104) := by decide +kernel

theorem selectedBound4698 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env4699 : List Nat := [2,4,8,16,32,64,104,256,0,282,0,107,364,59,0,35,91,0,282,0,106,357,32,295,269,113,96,59,10,293,30,366,256,366,91,1]

theorem envBound4699 : H12AffineFastState.Bounded env4699 := by
  intro p hp
  have h : env4699.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4698_4699 : H12AffineEnvironment.transform 6 104 env4698 = env4699 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 104 env4698 == env4699) = true)

theorem identity4699 : scanCanonicalize (H12AffineFastState.compose env4699 (packedSelected [1,2,3,5] rootPS)) = affineNative (2^(7+1) ^^^ 85) := by decide +kernel

theorem selectedBound4699 : packedSelected [1,2,3,5] rootPS < 2^1333 := by decide +kernel

def env4700 : List Nat := [2,4,8,16,32,64,104,85,0,79,0,107,57,59,0,35,91,0,79,0,106,48,32,114,88,113,96,59,10,112,30,59,85,59,91,1]

theorem envBound4700 : H12AffineFastState.Bounded env4700 := by
  intro p hp
  have h : env4700.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4699_4700 : H12AffineEnvironment.transform 7 85 env4699 = env4700 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 85 env4699 == env4700) = true)

theorem identity4700 : scanCanonicalize (H12AffineFastState.compose env4700 (packedSelected [6] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound4700 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env4701 : List Nat := [2,4,8,0,32,64,104,69,0,79,0,107,41,43,0,35,75,0,79,0,106,32,32,98,72,97,96,43,10,96,14,43,69,43,75,1]

theorem envBound4701 : H12AffineFastState.Bounded env4701 := by
  intro p hp
  have h : env4701.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4700_4701 : H12AffineEnvironment.transform 3 0 env4700 = env4701 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env4700 == env4701) = true)

theorem identity4701 : scanCanonicalize (H12AffineFastState.compose env4701 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 0) := by decide +kernel

theorem selectedBound4701 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4702 : List Nat := [2,4,8,0,32,0,40,5,0,15,0,43,41,43,0,35,11,0,15,0,42,32,32,34,8,33,32,43,10,32,14,43,5,43,11,1]

theorem envBound4702 : H12AffineFastState.Bounded env4702 := by
  intro p hp
  have h : env4702.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4701_4702 : H12AffineEnvironment.transform 5 0 env4701 = env4702 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env4701 == env4702) = true)

theorem identity4702 : scanCanonicalize (H12AffineFastState.compose env4702 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound4702 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4703 : List Nat := [2,4,8,0,10,0,2,5,0,15,0,1,3,1,0,9,11,0,15,0,0,10,10,8,8,11,10,1,10,10,14,1,5,1,11,1]

theorem envBound4703 : H12AffineFastState.Bounded env4703 := by
  intro p hp
  have h : env4703.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4702_4703 : H12AffineEnvironment.transform 4 10 env4702 = env4703 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env4702 == env4703) = true)

theorem identity4703 : scanCanonicalize (H12AffineFastState.compose env4703 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound4703 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4704 : List Nat := [2,4,2,0,0,0,2,5,0,5,0,1,3,1,0,3,1,0,5,0,0,0,0,2,2,1,0,1,0,0,4,1,5,1,1,1]

theorem envBound4704 : H12AffineFastState.Bounded env4704 := by
  intro p hp
  have h : env4704.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4703_4704 : H12AffineEnvironment.transform 2 2 env4703 = env4704 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env4703 == env4704) = true)

def env4705 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,13886,1345,1,524288,32768,4097,8201,5457,16777216,8329,16818746,8461,16820074,16822826,38588,1284,4294967296,16823866,4295529369,1345,513]

theorem envBound4705 : H12AffineFastState.Bounded env4705 := by
  intro p hp
  have h : env4705.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4689_4705 : H12AffineEnvironment.transform 17 1 env4689 = env4705 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env4689 == env4705) = true)

theorem identity4705 : scanCanonicalize (H12AffineFastState.compose env4705 (packedSelected [0,7] rootPS)) = affineNative (2^(23+1) ^^^ 38455) := by decide +kernel

theorem selectedBound4705 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4706 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,13886,1345,1,524288,32768,4097,8201,5457,38455,8329,13325,8461,12637,9245,38588,1284,4294967296,8205,4295529369,1345,513]

theorem envBound4706 : H12AffineFastState.Bounded env4706 := by
  intro p hp
  have h : env4706.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4705_4706 : H12AffineEnvironment.transform 23 38455 env4705 = env4706 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 38455 env4705 == env4706) = true)

theorem identity4706 : scanCanonicalize (H12AffineFastState.compose env4706 (packedSelected [9,22,23] rootPS)) = affineNative (2^(14+1) ^^^ 293) := by decide +kernel

theorem selectedBound4706 : packedSelected [9,22,23] rootPS < 2^1333 := by decide +kernel

def env4707 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,293,13886,1345,1,524288,293,4097,8201,5457,5906,8329,13325,8461,12637,9245,6041,1284,4294967296,8205,4295496380,1345,513]

theorem envBound4707 : H12AffineFastState.Bounded env4707 := by
  intro p hp
  have h : env4707.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4706_4707 : H12AffineEnvironment.transform 14 293 env4706 = env4707 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 293 env4706 == env4707) = true)

theorem identity4707 : scanCanonicalize (H12AffineFastState.compose env4707 (packedSelected [0,2,4,6,20] rootPS)) = affineNative (2^(12+1) ^^^ 5780) := by decide +kernel

theorem selectedBound4707 : packedSelected [0,2,4,6,20] rootPS < 2^1333 := by decide +kernel

def env4708 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,5780,4176,293,170,1345,1,524288,293,4097,5789,5457,5906,5661,665,6041,1993,4745,6041,1284,4294967296,5785,4295496380,1345,513]

theorem envBound4708 : H12AffineFastState.Bounded env4708 := by
  intro p hp
  have h : env4708.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4707_4708 : H12AffineEnvironment.transform 12 5780 env4707 = env4708 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5780 env4707 == env4708) = true)

theorem identity4708 : scanCanonicalize (H12AffineFastState.compose env4708 (packedSelected [0,1,2,3,6,9,10,21] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound4708 : packedSelected [0,1,2,3,6,9,10,21] rootPS < 2^1333 := by decide +kernel

def env4709 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,5149,4176,293,170,1345,1,524288,293,4097,5140,5457,5531,5268,16,5392,1344,4096,5392,1284,4294967296,5136,4295495733,1345,136]

theorem envBound4709 : H12AffineFastState.Bounded env4709 := by
  intro p hp
  have h : env4709.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4708_4709 : H12AffineEnvironment.transform 8 137 env4708 = env4709 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env4708 == env4709) = true)

def env4710 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,5149,4176,293,170,1345,1,1024,293,4097,5140,5457,5531,5268,16,5392,1344,4096,5392,1284,4294967296,5136,4294972469,1345,136]

theorem envBound4710 : H12AffineFastState.Bounded env4710 := by
  intro p hp
  have h : env4710.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4709_4710 : H12AffineEnvironment.transform 18 1024 env4709 = env4710 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env4709 == env4710) = true)

theorem identity4710 : scanCanonicalize (H12AffineFastState.compose env4710 (packedSelected [4,9] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound4710 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env4711 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1297,268,1345,293,170,1345,1,1024,293,1296,261,64,138,389,16,1,1344,1297,1,1284,4294967296,257,4294967588,1345,136]

theorem envBound4711 : H12AffineFastState.Bounded env4711 := by
  intro p hp
  have h : env4711.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4710_4711 : H12AffineEnvironment.transform 11 1297 env4710 = env4711 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env4710 == env4711) = true)

theorem identity4711 : scanCanonicalize (H12AffineFastState.compose env4711 (packedSelected [1,3] rootPS)) = affineNative (2^(31+1) ^^^ 249) := by decide +kernel

theorem selectedBound4711 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4712 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1297,268,1345,293,170,1345,1,1024,293,1296,261,64,138,389,16,1,1344,1297,1,1284,249,257,477,1345,136]

theorem envBound4712 : H12AffineFastState.Bounded env4712 := by
  intro p hp
  have h : env4712.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4711_4712 : H12AffineEnvironment.transform 31 249 env4711 = env4712 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 249 env4711 == env4712) = true)

theorem identity4712 : scanCanonicalize (H12AffineFastState.compose env4712 (packedSelected [0,1,4] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound4712 : packedSelected [0,1,4] rootPS < 2^1333 := by decide +kernel

def env4713 : List Nat := [2,4,8,16,32,64,128,5,137,1024,0,1044,9,1092,32,170,1092,1,1024,32,1045,0,64,138,128,16,1,1093,1044,1,1025,249,4,216,1092,136]

theorem envBound4713 : H12AffineFastState.Bounded env4713 := by
  intro p hp
  have h : env4713.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4712_4713 : H12AffineEnvironment.transform 7 5 env4712 = env4713 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env4712 == env4713) = true)

def env4714 : List Nat := [2,4,8,16,0,64,128,5,137,1024,0,1044,9,1092,0,138,1092,1,1024,0,1045,0,64,138,128,16,1,1093,1044,1,1025,217,4,216,1092,136]

theorem envBound4714 : H12AffineFastState.Bounded env4714 := by
  intro p hp
  have h : env4714.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4713_4714 : H12AffineEnvironment.transform 4 0 env4713 = env4714 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4713 == env4714) = true)

theorem identity4714 : scanCanonicalize (H12AffineFastState.compose env4714 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 135) := by decide +kernel

theorem selectedBound4714 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4715 : List Nat := [2,4,8,16,0,64,128,5,137,135,0,147,9,195,0,138,195,1,135,0,146,0,64,138,128,16,1,194,147,1,134,217,4,216,195,136]

theorem envBound4715 : H12AffineFastState.Bounded env4715 := by
  intro p hp
  have h : env4715.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4714_4715 : H12AffineEnvironment.transform 9 135 env4714 = env4715 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 135 env4714 == env4715) = true)

theorem identity4715 : scanCanonicalize (H12AffineFastState.compose env4715 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound4715 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4716 : List Nat := [2,4,8,16,0,64,88,5,81,95,0,75,9,27,0,82,27,1,95,0,74,0,64,82,88,16,1,26,75,1,94,1,4,0,27,80]

theorem envBound4716 : H12AffineFastState.Bounded env4716 := by
  intro p hp
  have h : env4716.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4715_4716 : H12AffineEnvironment.transform 6 88 env4715 = env4716 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env4715 == env4716) = true)

def leafEnv4716 : List Nat := [2,4,8,16,0,64,88,5,81,95,0,75,9,27,0,82,27,1,95,0,74,0,64,82,95,88,1,16,1,26,75,1,94,1,4,0,4,3,27,80,0,75,1]

def active4716 : List Nat := [0,1,2,3,5]

def tree4716 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4716 : H12WitnessSearch.Good tree4716 := H12GlobalWitnessIndex.good

theorem leafIdentity4716 : H12AffineFastState.composeSystem env4716 rootObs = leafEnv4716 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4716 rootObs == leafEnv4716) = true)

theorem terminalChecked4716 : H12PackedTerminal.terminalCheckFast leafEnv4716 active4716 tree4716 = true := by decide +kernel

def env4717 : List Nat := [2,4,8,16,1,64,128,5,137,1024,0,1044,9,1092,1,139,1092,1,1024,1,1045,0,64,138,128,16,1,1093,1044,1,1025,216,4,216,1092,136]

theorem envBound4717 : H12AffineFastState.Bounded env4717 := by
  intro p hp
  have h : env4717.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4713_4717 : H12AffineEnvironment.transform 4 1 env4713 = env4717 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4713 == env4717) = true)

theorem identity4717 : scanCanonicalize (H12AffineFastState.compose env4717 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 15) := by decide +kernel

theorem selectedBound4717 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4718 : List Nat := [2,4,8,16,1,64,128,5,137,15,0,27,9,75,1,139,75,1,15,1,26,0,64,138,128,16,1,74,27,1,14,216,4,216,75,136]

theorem envBound4718 : H12AffineFastState.Bounded env4718 := by
  intro p hp
  have h : env4718.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4717_4718 : H12AffineEnvironment.transform 9 15 env4717 = env4718 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 15 env4717 == env4718) = true)

def leafEnv4718 : List Nat := [2,4,8,16,1,64,128,5,137,15,0,27,9,75,1,139,75,1,15,1,26,0,64,138,15,128,1,16,1,74,27,1,14,216,4,216,4,2,75,136,0,27,1]

def active4718 : List Nat := [0,1,2,3,5,6]

def tree4718 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4718 : H12WitnessSearch.Good tree4718 := H12GlobalWitnessIndex.good

theorem leafIdentity4718 : H12AffineFastState.composeSystem env4718 rootObs = leafEnv4718 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4718 rootObs == leafEnv4718) = true)

theorem terminalChecked4718 : H12PackedTerminal.terminalCheckFast leafEnv4718 active4718 tree4718 = true := by decide +kernel

def env4719 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,5149,4176,293,170,1345,1,1025,293,4097,5140,5457,5531,5268,16,5392,1344,4096,5392,1284,4294967296,5136,4294972468,1345,136]

theorem envBound4719 : H12AffineFastState.Bounded env4719 := by
  intro p hp
  have h : env4719.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4709_4719 : H12AffineEnvironment.transform 18 1025 env4709 = env4719 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env4709 == env4719) = true)

theorem identity4719 : scanCanonicalize (H12AffineFastState.compose env4719 (packedSelected [1,5,10] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound4719 : packedSelected [1,5,10] rootPS < 2^1333 := by decide +kernel

def env4720 : List Nat := [2,4,8,16,32,64,128,36,137,1024,0,4096,5149,4176,1,170,1125,1,1025,1,4097,5140,5237,5311,5268,16,5172,1124,4096,5172,1056,4294967296,5136,4294972468,1125,136]

theorem envBound4720 : H12AffineFastState.Bounded env4720 := by
  intro p hp
  have h : env4720.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4719_4720 : H12AffineEnvironment.transform 7 36 env4719 = env4720 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env4719 == env4720) = true)

def env4721 : List Nat := [2,4,8,16,32,64,128,36,137,1024,0,168,1205,248,1,170,1125,1,1025,1,169,1212,1245,1047,1084,16,1180,1124,168,1180,1056,4294967296,1208,4294968476,1125,136]

theorem envBound4721 : H12AffineFastState.Bounded env4721 := by
  intro p hp
  have h : env4721.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4720_4721 : H12AffineEnvironment.transform 11 168 env4720 = env4721 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 168 env4720 == env4721) = true)

theorem identity4721 : scanCanonicalize (H12AffineFastState.compose env4721 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 1239) := by decide +kernel

theorem selectedBound4721 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4722 : List Nat := [2,4,8,16,32,64,128,36,137,1024,0,168,1205,248,1,170,1125,1,1025,1,169,1212,1245,1047,1084,16,1180,1124,168,1180,1056,1239,1208,75,1125,136]

theorem envBound4722 : H12AffineFastState.Bounded env4722 := by
  intro p hp
  have h : env4722.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4721_4722 : H12AffineEnvironment.transform 31 1239 env4721 = env4722 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1239 env4721 == env4722) = true)

theorem identity4722 : scanCanonicalize (H12AffineFastState.compose env4722 (packedSelected [1,4,5] rootPS)) = affineNative (2^(9+1) ^^^ 157) := by decide +kernel

theorem selectedBound4722 : packedSelected [1,4,5] rootPS < 2^1333 := by decide +kernel

def env4723 : List Nat := [2,4,8,16,32,64,128,36,137,157,0,168,40,248,1,170,248,1,156,1,169,33,64,138,161,16,1,249,168,1,189,74,37,75,248,136]

theorem envBound4723 : H12AffineFastState.Bounded env4723 := by
  intro p hp
  have h : env4723.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4722_4723 : H12AffineEnvironment.transform 9 157 env4722 = env4723 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 157 env4722 == env4723) = true)

theorem identity4723 : scanCanonicalize (H12AffineFastState.compose env4723 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 51) := by decide +kernel

theorem selectedBound4723 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4724 : List Nat := [2,4,8,16,32,64,51,36,58,46,0,27,40,75,1,25,75,1,47,1,26,33,64,57,18,16,1,74,27,1,14,74,37,75,75,59]

theorem envBound4724 : H12AffineFastState.Bounded env4724 := by
  intro p hp
  have h : env4724.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4723_4724 : H12AffineEnvironment.transform 6 51 env4723 = env4724 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 51 env4723 == env4724) = true)

theorem identity4724 : scanCanonicalize (H12AffineFastState.compose env4724 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound4724 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4725 : List Nat := [2,4,8,10,32,64,41,36,32,46,0,1,40,75,1,3,75,1,47,1,0,33,64,35,8,10,1,74,1,1,14,74,37,75,75,33]

theorem envBound4725 : H12AffineFastState.Bounded env4725 := by
  intro p hp
  have h : env4725.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4724_4725 : H12AffineEnvironment.transform 3 10 env4724 = env4725 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env4724 == env4725) = true)

theorem identity4725 : scanCanonicalize (H12AffineFastState.compose env4725 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound4725 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4726 : List Nat := [2,4,8,10,1,64,8,5,1,15,0,1,9,75,1,3,75,1,14,1,0,0,64,2,8,10,1,74,1,1,14,74,4,75,75,0]

theorem envBound4726 : H12AffineFastState.Bounded env4726 := by
  intro p hp
  have h : env4726.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4725_4726 : H12AffineEnvironment.transform 4 1 env4725 = env4726 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4725 == env4726) = true)

def leafEnv4726 : List Nat := [2,4,8,10,1,64,8,5,1,15,0,1,9,75,1,3,75,1,14,1,0,0,64,2,14,8,1,10,1,74,1,1,14,74,4,75,4,2,75,0,0,1,1]

def active4726 : List Nat := [0,1,2,5]

def tree4726 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4726 : H12WitnessSearch.Good tree4726 := H12GlobalWitnessIndex.good

theorem leafIdentity4726 : H12AffineFastState.composeSystem env4726 rootObs = leafEnv4726 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4726 rootObs == leafEnv4726) = true)

theorem terminalChecked4726 : H12PackedTerminal.terminalCheckFast leafEnv4726 active4726 tree4726 = true := by decide +kernel

def env4727 : List Nat := [2,4,8,16,32,64,128,36,137,1024,0,169,1204,249,1,170,1125,1,1025,1,168,1213,1244,1046,1085,16,1181,1124,169,1181,1056,4294967296,1209,4294968477,1125,136]

theorem envBound4727 : H12AffineFastState.Bounded env4727 := by
  intro p hp
  have h : env4727.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4720_4727 : H12AffineEnvironment.transform 11 169 env4720 = env4727 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 169 env4720 == env4727) = true)

theorem identity4727 : scanCanonicalize (H12AffineFastState.compose env4727 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 75) := by decide +kernel

theorem selectedBound4727 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4728 : List Nat := [2,4,8,16,32,64,128,36,137,1024,0,169,1204,249,1,170,1125,1,1025,1,168,1213,1244,1046,1085,16,1181,1124,169,1181,1056,75,1209,1238,1125,136]

theorem envBound4728 : H12AffineFastState.Bounded env4728 := by
  intro p hp
  have h : env4728.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4727_4728 : H12AffineEnvironment.transform 31 75 env4727 = env4728 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 75 env4727 == env4728) = true)

theorem identity4728 : scanCanonicalize (H12AffineFastState.compose env4728 (packedSelected [1,4,5] rootPS)) = affineNative (2^(9+1) ^^^ 156) := by decide +kernel

theorem selectedBound4728 : packedSelected [1,4,5] rootPS < 2^1333 := by decide +kernel

def env4729 : List Nat := [2,4,8,16,32,64,128,36,137,156,0,169,40,249,1,170,249,1,157,1,168,33,64,138,161,16,1,248,169,1,188,75,37,74,249,136]

theorem envBound4729 : H12AffineFastState.Bounded env4729 := by
  intro p hp
  have h : env4729.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4728_4729 : H12AffineEnvironment.transform 9 156 env4728 = env4729 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 156 env4728 == env4729) = true)

theorem identity4729 : scanCanonicalize (H12AffineFastState.compose env4729 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 50) := by decide +kernel

theorem selectedBound4729 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4730 : List Nat := [2,4,8,16,32,64,50,36,59,46,0,27,40,75,1,24,75,1,47,1,26,33,64,56,19,16,1,74,27,1,14,75,37,74,75,58]

theorem envBound4730 : H12AffineFastState.Bounded env4730 := by
  intro p hp
  have h : env4730.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4729_4730 : H12AffineEnvironment.transform 6 50 env4729 = env4730 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 50 env4729 == env4730) = true)

theorem identity4730 : scanCanonicalize (H12AffineFastState.compose env4730 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound4730 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4731 : List Nat := [2,4,8,11,32,64,41,36,32,46,0,0,40,75,1,3,75,1,47,1,1,33,64,35,8,11,1,74,0,1,14,75,37,74,75,33]

theorem envBound4731 : H12AffineFastState.Bounded env4731 := by
  intro p hp
  have h : env4731.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4730_4731 : H12AffineEnvironment.transform 3 11 env4730 = env4731 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env4730 == env4731) = true)

theorem identity4731 : scanCanonicalize (H12AffineFastState.compose env4731 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound4731 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4732 : List Nat := [2,4,8,11,1,64,8,5,1,15,0,0,9,75,1,3,75,1,14,1,1,0,64,2,8,11,1,74,0,1,14,75,4,74,75,0]

theorem envBound4732 : H12AffineFastState.Bounded env4732 := by
  intro p hp
  have h : env4732.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4731_4732 : H12AffineEnvironment.transform 4 1 env4731 = env4732 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4731 == env4732) = true)

def leafEnv4732 : List Nat := [2,4,8,11,1,64,8,5,1,15,0,0,9,75,1,3,75,1,14,1,1,0,64,2,14,8,1,11,1,74,0,1,14,75,4,74,4,2,75,0,0,0,1]

def active4732 : List Nat := [0,1,2,5]

def tree4732 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4732 : H12WitnessSearch.Good tree4732 := H12GlobalWitnessIndex.good

theorem leafIdentity4732 : H12AffineFastState.composeSystem env4732 rootObs = leafEnv4732 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4732 rootObs == leafEnv4732) = true)

theorem terminalChecked4732 : H12PackedTerminal.terminalCheckFast leafEnv4732 active4732 tree4732 = true := by decide +kernel

def env4733 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,1345,262144,524288,32768,4097,8201,5457,16777216,8329,16880644,270604,16879956,16876564,106627,1284,4294967296,16875524,4295599527,1345,513]

theorem envBound4733 : H12AffineFastState.Bounded env4733 := by
  intro p hp
  have h : env4733.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4687_4733 : H12AffineEnvironment.transform 10 1 env4687 = env4733 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env4687 == env4733) = true)

theorem identity4733 : scanCanonicalize (H12AffineFastState.compose env4733 (packedSelected [11] rootPS)) = affineNative (2^(23+1) ^^^ 13855) := by decide +kernel

theorem selectedBound4733 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env4734 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,1345,262144,524288,32768,4097,8201,5457,13855,8329,107035,270604,108363,111115,106627,1284,4294967296,112155,4295599527,1345,513]

theorem envBound4734 : H12AffineFastState.Bounded env4734 := by
  intro p hp
  have h : env4734.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4733_4734 : H12AffineEnvironment.transform 23 13855 env4733 = env4734 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 13855 env4733 == env4734) = true)

def env4735 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,1345,0,524288,32768,4097,8201,5457,13855,8329,107035,8460,108363,111115,106627,1284,4294967296,112155,4295599527,1345,513]

theorem envBound4735 : H12AffineFastState.Bounded env4735 := by
  intro p hp
  have h : env4735.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4734_4735 : H12AffineEnvironment.transform 17 0 env4734 = env4735 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env4734 == env4735) = true)

theorem identity4735 : scanCanonicalize (H12AffineFastState.compose env4735 (packedSelected [0,7] rootPS)) = affineNative (2^(15+1) ^^^ 8614) := by decide +kernel

theorem selectedBound4735 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4736 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,8614,1345,0,524288,32768,4097,8201,5457,13855,8329,33725,8460,34541,37805,33061,1284,4294967296,38845,4295525377,1345,513]

theorem envBound4736 : H12AffineFastState.Bounded env4736 := by
  intro p hp
  have h : env4736.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4735_4736 : H12AffineEnvironment.transform 15 8614 env4735 = env4736 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8614 env4735 == env4736) = true)

theorem identity4736 : scanCanonicalize (H12AffineFastState.compose env4736 (packedSelected [0,1,2,5,6,9,15,18,20,21] rootPS)) = affineNative (2^(14+1) ^^^ 8233) := by decide +kernel

theorem selectedBound4736 : packedSelected [0,1,2,5,6,9,15,18,20,21] rootPS < 2^1333 := by decide +kernel

def env4737 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,8233,8614,1345,0,524288,8233,4097,8201,5457,13855,8329,9108,8460,9924,13188,8460,1284,4294967296,14228,4295500840,1345,513]

theorem envBound4737 : H12AffineFastState.Bounded env4737 := by
  intro p hp
  have h : env4737.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4736_4737 : H12AffineEnvironment.transform 14 8233 env4736 = env4737 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8233 env4736 == env4737) = true)

theorem identity4737 : scanCanonicalize (H12AffineFastState.compose env4737 (packedSelected [1,3,5,8,12,13,15,17] rootPS)) = affineNative (2^(12+1) ^^^ 5781) := by decide +kernel

theorem selectedBound4737 : packedSelected [1,3,5,8,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env4738 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,5781,4176,5820,5939,1345,0,524288,5820,4097,5788,5457,138,5660,5377,6041,4177,1297,6041,1284,4294967296,257,4295496381,1345,513]

theorem envBound4738 : H12AffineFastState.Bounded env4738 := by
  intro p hp
  have h : env4738.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4737_4738 : H12AffineEnvironment.transform 12 5781 env4737 = env4738 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5781 env4737 == env4738) = true)

theorem identity4738 : scanCanonicalize (H12AffineFastState.compose env4738 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound4738 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env4739 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,4096,5148,4176,5173,5562,1345,0,524288,5173,4097,5141,5457,138,5269,5377,5392,4177,1297,5392,1284,4294967296,257,4295495732,1345,136]

theorem envBound4739 : H12AffineFastState.Bounded env4739 := by
  intro p hp
  have h : env4739.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4738_4739 : H12AffineEnvironment.transform 8 137 env4738 = env4739 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env4738 == env4739) = true)

theorem identity4739 : scanCanonicalize (H12AffineFastState.compose env4739 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound4739 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env4740 : List Nat := [2,4,8,16,32,64,128,5,137,1024,1,4096,5148,4176,5173,5311,1092,0,524288,5173,4097,5141,5204,138,5269,5124,5141,4177,1044,5141,1025,4294967296,4,4295495732,1092,136]

theorem envBound4740 : H12AffineFastState.Bounded env4740 := by
  intro p hp
  have h : env4740.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4739_4740 : H12AffineEnvironment.transform 7 5 env4739 = env4740 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env4739 == env4740) = true)

theorem identity4740 : scanCanonicalize (H12AffineFastState.compose env4740 (packedSelected [3,5,10,12] rootPS)) = affineNative (2^(18+1) ^^^ 1025) := by decide +kernel

theorem selectedBound4740 : packedSelected [3,5,10,12] rootPS < 2^1333 := by decide +kernel

def env4741 : List Nat := [2,4,8,16,32,64,128,5,137,1024,1,4096,5148,4176,5173,5311,1092,0,1025,5173,4097,5141,5204,138,5269,5124,5141,4177,1044,5141,1025,4294967296,4,4294972469,1092,136]

theorem envBound4741 : H12AffineFastState.Bounded env4741 := by
  intro p hp
  have h : env4741.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4740_4741 : H12AffineEnvironment.transform 18 1025 env4740 = env4741 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env4740 == env4741) = true)

theorem identity4741 : scanCanonicalize (H12AffineFastState.compose env4741 (packedSelected [1,3] rootPS)) = affineNative (2^(31+1) ^^^ 112) := by decide +kernel

theorem selectedBound4741 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4742 : List Nat := [2,4,8,16,32,64,128,5,137,1024,1,4096,5148,4176,5173,5311,1092,0,1025,5173,4097,5141,5204,138,5269,5124,5141,4177,1044,5141,1025,112,4,5189,1092,136]

theorem envBound4742 : H12AffineFastState.Bounded env4742 := by
  intro p hp
  have h : env4742.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4741_4742 : H12AffineEnvironment.transform 31 112 env4741 = env4742 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 112 env4741 == env4742) = true)

theorem identity4742 : scanCanonicalize (H12AffineFastState.compose env4742 (packedSelected [5] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound4742 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env4743 : List Nat := [2,4,8,16,1,64,128,5,137,1024,1,4096,5148,4176,5140,5278,1092,0,1025,5140,4097,5141,5204,138,5269,5124,5141,4177,1044,5141,1025,81,4,5189,1092,136]

theorem envBound4743 : H12AffineFastState.Bounded env4743 := by
  intro p hp
  have h : env4743.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4742_4743 : H12AffineEnvironment.transform 4 1 env4742 = env4743 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4742 == env4743) = true)

theorem identity4743 : scanCanonicalize (H12AffineFastState.compose env4743 (packedSelected [0] rootPS)) = affineNative (2^(11+1) ^^^ 147) := by decide +kernel

theorem selectedBound4743 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4744 : List Nat := [2,4,8,16,1,64,128,5,137,1024,1,147,1167,195,1159,1037,1092,0,1025,1159,146,1158,1223,138,1030,1175,1158,194,1044,1158,1025,81,4,1238,1092,136]

theorem envBound4744 : H12AffineFastState.Bounded env4744 := by
  intro p hp
  have h : env4744.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4743_4744 : H12AffineEnvironment.transform 11 147 env4743 = env4744 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 147 env4743 == env4744) = true)

theorem identity4744 : scanCanonicalize (H12AffineFastState.compose env4744 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound4744 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4745 : List Nat := [2,4,8,16,1,64,88,5,81,1024,1,75,1111,27,1119,1037,1092,0,1025,1119,74,1118,1055,82,1030,1103,1118,26,1044,1118,1025,81,4,1038,1092,80]

theorem envBound4745 : H12AffineFastState.Bounded env4745 := by
  intro p hp
  have h : env4745.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4744_4745 : H12AffineEnvironment.transform 6 88 env4744 = env4745 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env4744 == env4745) = true)

def env4746 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,1345,1,524288,32768,4097,8201,5457,13855,8329,107035,8461,108363,111115,106627,1284,4294967296,112155,4295599527,1345,513]

theorem envBound4746 : H12AffineFastState.Bounded env4746 := by
  intro p hp
  have h : env4746.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4734_4746 : H12AffineEnvironment.transform 17 1 env4734 = env4746 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env4734 == env4746) = true)

theorem identity4746 : scanCanonicalize (H12AffineFastState.compose env4746 (packedSelected [0,7] rootPS)) = affineNative (2^(15+1) ^^^ 171) := by decide +kernel

theorem selectedBound4746 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4747 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,171,1345,1,524288,32768,4097,8201,5457,13855,8329,41648,8461,42976,45728,41000,1284,4294967296,46768,4295533836,1345,513]

theorem envBound4747 : H12AffineFastState.Bounded env4747 := by
  intro p hp
  have h : env4747.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4746_4747 : H12AffineEnvironment.transform 15 171 env4746 = env4747 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 171 env4746 == env4747) = true)

theorem identity4747 : scanCanonicalize (H12AffineFastState.compose env4747 (packedSelected [0,2,4,6,18] rootPS)) = affineNative (2^(11+1) ^^^ 1945) := by decide +kernel

theorem selectedBound4747 : packedSelected [0,2,4,6,18] rootPS < 2^1333 := by decide +kernel

def env4748 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1945,8192,1993,32768,171,1345,1,524288,32768,1944,8201,712,8582,8329,41648,8461,42976,42297,41000,1284,4294967296,41257,4295533836,1345,513]

theorem envBound4748 : H12AffineFastState.Bounded env4748 := by
  intro p hp
  have h : env4748.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4747_4748 : H12AffineEnvironment.transform 11 1945 env4747 = env4748 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1945 env4747 == env4748) = true)

theorem identity4748 : scanCanonicalize (H12AffineFastState.compose env4748 (packedSelected [3,4,8,9,12,13,17,21] rootPS)) = affineNative (2^(12+1) ^^^ 901) := by decide +kernel

theorem selectedBound4748 : packedSelected [3,4,8,9,12,13,17,21] rootPS < 2^1333 := by decide +kernel

def env4749 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1945,901,1993,32768,171,1345,1,524288,32768,1944,908,712,515,780,33077,648,33893,34492,33709,1284,4294967296,33452,4295526025,1345,513]

theorem envBound4749 : H12AffineFastState.Bounded env4749 := by
  intro p hp
  have h : env4749.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4748_4749 : H12AffineEnvironment.transform 12 901 env4748 = env4749 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 901 env4748 == env4749) = true)

theorem identity4749 : scanCanonicalize (H12AffineFastState.compose env4749 (packedSelected [4,9,20,23] rootPS)) = affineNative (2^(14+1) ^^^ 292) := by decide +kernel

theorem selectedBound4749 : packedSelected [4,9,20,23] rootPS < 2^1333 := by decide +kernel

def env4750 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1945,901,1993,292,171,1345,1,524288,292,1944,908,712,515,780,17,648,1345,1944,649,1284,4294967296,904,4295493549,1345,513]

theorem envBound4750 : H12AffineFastState.Bounded env4750 := by
  intro p hp
  have h : env4750.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4749_4750 : H12AffineEnvironment.transform 14 292 env4749 = env4750 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 292 env4749 == env4750) = true)

def env4751 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1945,901,1993,292,171,1345,1,1024,292,1944,908,712,515,780,17,648,1345,1944,649,1284,4294967296,904,4294968237,1345,513]

theorem envBound4751 : H12AffineFastState.Bounded env4751 := by
  intro p hp
  have h : env4751.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4750_4751 : H12AffineEnvironment.transform 18 1024 env4750 = env4751 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env4750 == env4751) = true)

theorem identity4751 : scanCanonicalize (H12AffineFastState.compose env4751 (packedSelected [4,9] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound4751 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env4752 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1296,268,1344,292,171,1345,1,1024,292,1297,261,65,138,389,17,1,1345,1297,0,1284,4294967296,257,4294967588,1345,136]

theorem envBound4752 : H12AffineFastState.Bounded env4752 := by
  intro p hp
  have h : env4752.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4751_4752 : H12AffineEnvironment.transform 8 137 env4751 = env4752 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env4751 == env4752) = true)

theorem identity4752 : scanCanonicalize (H12AffineFastState.compose env4752 (packedSelected [1,3] rootPS)) = affineNative (2^(31+1) ^^^ 248) := by decide +kernel

theorem selectedBound4752 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4753 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1296,268,1344,292,171,1345,1,1024,292,1297,261,65,138,389,17,1,1345,1297,0,1284,248,257,476,1345,136]

theorem envBound4753 : H12AffineFastState.Bounded env4753 := by
  intro p hp
  have h : env4753.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4752_4753 : H12AffineEnvironment.transform 31 248 env4752 = env4753 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 248 env4752 == env4753) = true)

theorem identity4753 : scanCanonicalize (H12AffineFastState.compose env4753 (packedSelected [0,1,4] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound4753 : packedSelected [0,1,4] rootPS < 2^1333 := by decide +kernel

def env4754 : List Nat := [2,4,8,16,32,64,128,5,137,1024,1,1045,9,1093,33,171,1092,1,1024,33,1044,0,65,138,128,17,1,1092,1044,0,1025,248,4,217,1092,136]

theorem envBound4754 : H12AffineFastState.Bounded env4754 := by
  intro p hp
  have h : env4754.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4753_4754 : H12AffineEnvironment.transform 7 5 env4753 = env4754 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env4753 == env4754) = true)

def env4755 : List Nat := [2,4,8,16,0,64,128,5,137,1024,1,1045,9,1093,1,139,1092,1,1024,1,1044,0,65,138,128,17,1,1092,1044,0,1025,216,4,217,1092,136]

theorem envBound4755 : H12AffineFastState.Bounded env4755 := by
  intro p hp
  have h : env4755.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4754_4755 : H12AffineEnvironment.transform 4 0 env4754 = env4755 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4754 == env4755) = true)

theorem identity4755 : scanCanonicalize (H12AffineFastState.compose env4755 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 15) := by decide +kernel

theorem selectedBound4755 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4756 : List Nat := [2,4,8,16,0,64,128,5,137,15,1,26,9,74,1,139,75,1,15,1,27,0,65,138,128,17,1,75,27,0,14,216,4,217,75,136]

theorem envBound4756 : H12AffineFastState.Bounded env4756 := by
  intro p hp
  have h : env4756.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4755_4756 : H12AffineEnvironment.transform 9 15 env4755 = env4756 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 15 env4755 == env4756) = true)

theorem identity4756 : scanCanonicalize (H12AffineFastState.compose env4756 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound4756 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4757 : List Nat := [2,4,8,16,0,64,8,5,1,15,1,26,9,74,1,3,75,1,15,1,27,0,65,2,8,17,1,75,27,0,14,80,4,81,75,0]

theorem envBound4757 : H12AffineFastState.Bounded env4757 := by
  intro p hp
  have h : env4757.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4756_4757 : H12AffineEnvironment.transform 6 8 env4756 = env4757 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env4756 == env4757) = true)

def leafEnv4757 : List Nat := [2,4,8,16,0,64,8,5,1,15,1,26,9,74,1,3,75,1,15,1,27,0,65,2,15,8,1,17,1,75,27,0,14,80,4,81,4,2,75,0,0,27,1]

def active4757 : List Nat := [0,1,2,3,5]

def tree4757 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4757 : H12WitnessSearch.Good tree4757 := H12GlobalWitnessIndex.good

theorem leafIdentity4757 : H12AffineFastState.composeSystem env4757 rootObs = leafEnv4757 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4757 rootObs == leafEnv4757) = true)

theorem terminalChecked4757 : H12PackedTerminal.terminalCheckFast leafEnv4757 active4757 tree4757 = true := by decide +kernel

def env4758 : List Nat := [2,4,8,16,1,64,128,5,137,1024,1,1045,9,1093,0,138,1092,1,1024,0,1044,0,65,138,128,17,1,1092,1044,0,1025,217,4,217,1092,136]

theorem envBound4758 : H12AffineFastState.Bounded env4758 := by
  intro p hp
  have h : env4758.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4754_4758 : H12AffineEnvironment.transform 4 1 env4754 = env4758 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4754 == env4758) = true)

theorem identity4758 : scanCanonicalize (H12AffineFastState.compose env4758 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 135) := by decide +kernel

theorem selectedBound4758 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4759 : List Nat := [2,4,8,16,1,64,128,5,137,135,1,146,9,194,0,138,195,1,135,0,147,0,65,138,128,17,1,195,147,0,134,217,4,217,195,136]

theorem envBound4759 : H12AffineFastState.Bounded env4759 := by
  intro p hp
  have h : env4759.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4758_4759 : H12AffineEnvironment.transform 9 135 env4758 = env4759 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 135 env4758 == env4759) = true)

theorem identity4759 : scanCanonicalize (H12AffineFastState.compose env4759 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound4759 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4760 : List Nat := [2,4,8,16,1,17,128,5,137,135,1,146,9,147,0,138,146,1,135,0,147,0,16,138,128,17,1,146,147,0,134,136,4,136,146,136]

theorem envBound4760 : H12AffineFastState.Bounded env4760 := by
  intro p hp
  have h : env4760.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4759_4760 : H12AffineEnvironment.transform 5 17 env4759 = env4760 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env4759 == env4760) = true)

def leafEnv4760 : List Nat := [2,4,8,16,1,17,128,5,137,135,1,146,9,147,0,138,146,1,135,0,147,0,16,138,135,128,1,17,1,146,147,0,134,136,4,136,4,3,146,136,0,147,1]

def active4760 : List Nat := [0,1,2,3,6]

def tree4760 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4760 : H12WitnessSearch.Good tree4760 := H12GlobalWitnessIndex.good

theorem leafIdentity4760 : H12AffineFastState.composeSystem env4760 rootObs = leafEnv4760 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4760 rootObs == leafEnv4760) = true)

theorem terminalChecked4760 : H12PackedTerminal.terminalCheckFast leafEnv4760 active4760 tree4760 = true := by decide +kernel

def env4761 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1945,901,1993,292,171,1345,1,1025,292,1944,908,712,515,780,17,648,1345,1944,649,1284,4294967296,904,4294968236,1345,513]

theorem envBound4761 : H12AffineFastState.Bounded env4761 := by
  intro p hp
  have h : env4761.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4750_4761 : H12AffineEnvironment.transform 18 1025 env4750 = env4761 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env4750 == env4761) = true)

theorem identity4761 : scanCanonicalize (H12AffineFastState.compose env4761 (packedSelected [1,5,10] rootPS)) = affineNative (2^(8+1) ^^^ 428) := by decide +kernel

theorem selectedBound4761 : packedSelected [1,5,10] rootPS < 2^1333 := by decide +kernel

def env4762 : List Nat := [2,4,8,16,32,64,128,256,428,1024,1,1077,41,1125,292,171,1345,1,1025,292,1076,32,356,431,160,17,292,1345,1076,293,1284,4294967296,36,4294967296,1345,429]

theorem envBound4762 : H12AffineFastState.Bounded env4762 := by
  intro p hp
  have h : env4762.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4761_4762 : H12AffineEnvironment.transform 8 428 env4761 = env4762 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 428 env4761 == env4762) = true)

def env4763 : List Nat := [2,4,8,16,32,64,128,256,428,440,1,397,41,477,292,171,249,1,441,292,396,32,356,431,160,17,292,249,396,293,188,4294967296,36,4294967296,249,429]

theorem envBound4763 : H12AffineFastState.Bounded env4763 := by
  intro p hp
  have h : env4763.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4762_4763 : H12AffineEnvironment.transform 9 440 env4762 = env4763 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 440 env4762 == env4763) = true)

theorem identity4763 : scanCanonicalize (H12AffineFastState.compose env4763 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 367) := by decide +kernel

theorem selectedBound4763 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4764 : List Nat := [2,4,8,16,32,64,128,256,428,440,1,397,41,477,292,171,249,1,441,292,396,32,356,431,160,17,292,249,396,293,188,367,36,367,249,429]

theorem envBound4764 : H12AffineFastState.Bounded env4764 := by
  intro p hp
  have h : env4764.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4763_4764 : H12AffineEnvironment.transform 31 367 env4763 = env4764 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 367 env4763 == env4764) = true)

def env4765 : List Nat := [2,4,8,16,32,64,128,36,136,156,1,169,41,249,0,171,249,1,157,0,168,32,64,139,160,17,0,249,168,1,188,75,36,75,249,137]

theorem envBound4765 : H12AffineFastState.Bounded env4765 := by
  intro p hp
  have h : env4765.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4764_4765 : H12AffineEnvironment.transform 7 36 env4764 = env4765 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env4764 == env4765) = true)

theorem identity4765 : scanCanonicalize (H12AffineFastState.compose env4765 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 33) := by decide +kernel

theorem selectedBound4765 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4766 : List Nat := [2,4,8,16,32,33,128,36,136,156,1,169,41,152,0,171,152,1,157,0,168,32,33,139,160,17,0,152,168,1,188,42,36,42,152,137]

theorem envBound4766 : H12AffineFastState.Bounded env4766 := by
  intro p hp
  have h : env4766.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4765_4766 : H12AffineEnvironment.transform 5 33 env4765 = env4766 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 33 env4765 == env4766) = true)

theorem identity4766 : scanCanonicalize (H12AffineFastState.compose env4766 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound4766 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4767 : List Nat := [2,4,8,16,11,10,128,15,136,156,1,130,2,152,0,128,152,1,157,0,131,11,10,139,139,17,0,152,131,1,151,1,15,1,152,137]

theorem envBound4767 : H12AffineFastState.Bounded env4767 := by
  intro p hp
  have h : env4767.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4766_4767 : H12AffineEnvironment.transform 4 11 env4766 = env4767 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env4766 == env4767) = true)

def env4768 : List Nat := [2,4,8,16,32,64,128,37,137,157,1,168,41,248,1,171,249,1,156,1,169,32,65,138,160,17,1,249,169,0,188,74,36,74,249,136]

theorem envBound4768 : H12AffineFastState.Bounded env4768 := by
  intro p hp
  have h : env4768.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4764_4768 : H12AffineEnvironment.transform 7 37 env4764 = env4768 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env4764 == env4768) = true)

theorem identity4768 : scanCanonicalize (H12AffineFastState.compose env4768 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 26) := by decide +kernel

theorem selectedBound4768 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4769 : List Nat := [2,4,8,16,26,64,128,31,137,157,1,146,19,194,1,145,195,1,156,1,147,26,65,138,154,17,1,195,147,0,134,74,30,74,195,136]

theorem envBound4769 : H12AffineFastState.Bounded env4769 := by
  intro p hp
  have h : env4769.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4768_4769 : H12AffineEnvironment.transform 4 26 env4768 = env4769 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 26 env4768 == env4769) = true)

theorem identity4769 : scanCanonicalize (H12AffineFastState.compose env4769 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 18) := by decide +kernel

theorem selectedBound4769 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4770 : List Nat := [2,4,8,16,26,64,18,31,27,15,1,0,19,80,1,3,81,1,14,1,1,26,65,24,8,17,1,81,1,0,20,74,30,74,81,26]

theorem envBound4770 : H12AffineFastState.Bounded env4770 := by
  intro p hp
  have h : env4770.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4769_4770 : H12AffineEnvironment.transform 6 18 env4769 = env4770 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 18 env4769 == env4770) = true)

theorem identity4770 : scanCanonicalize (H12AffineFastState.compose env4770 (packedSelected [4] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound4770 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env4771 : List Nat := [2,4,8,10,0,64,8,5,1,15,1,0,9,74,1,3,75,1,14,1,1,0,65,2,8,11,1,75,1,0,14,74,4,74,75,0]

theorem envBound4771 : H12AffineFastState.Bounded env4771 := by
  intro p hp
  have h : env4771.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4770_4771 : H12AffineEnvironment.transform 3 10 env4770 = env4771 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env4770 == env4771) = true)

def leafEnv4771 : List Nat := [2,4,8,10,0,64,8,5,1,15,1,0,9,74,1,3,75,1,14,1,1,0,65,2,14,8,1,11,1,75,1,0,14,74,4,74,4,2,75,0,0,1,1]

def active4771 : List Nat := [0,1,2,5]

def tree4771 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4771 : H12WitnessSearch.Good tree4771 := H12GlobalWitnessIndex.good

theorem leafIdentity4771 : H12AffineFastState.composeSystem env4771 rootObs = leafEnv4771 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4771 rootObs == leafEnv4771) = true)

theorem terminalChecked4771 : H12PackedTerminal.terminalCheckFast leafEnv4771 active4771 tree4771 = true := by decide +kernel

def env4772 : List Nat := [2,4,8,16,32,64,128,256,428,441,1,396,41,476,292,171,248,1,440,292,397,32,356,431,160,17,292,248,397,293,189,4294967296,36,4294967296,248,429]

theorem envBound4772 : H12AffineFastState.Bounded env4772 := by
  intro p hp
  have h : env4772.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4762_4772 : H12AffineEnvironment.transform 9 441 env4762 = env4772 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 441 env4762 == env4772) = true)

theorem identity4772 : scanCanonicalize (H12AffineFastState.compose env4772 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 75) := by decide +kernel

theorem selectedBound4772 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4773 : List Nat := [2,4,8,16,32,64,128,256,428,441,1,396,41,476,292,171,248,1,440,292,397,32,356,431,160,17,292,248,397,293,189,75,36,75,248,429]

theorem envBound4773 : H12AffineFastState.Bounded env4773 := by
  intro p hp
  have h : env4773.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4772_4773 : H12AffineEnvironment.transform 31 75 env4772 = env4773 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 75 env4772 == env4773) = true)

def env4774 : List Nat := [2,4,8,16,32,64,128,36,136,157,1,168,41,248,0,171,248,1,156,0,169,32,64,139,160,17,0,248,169,1,189,75,36,75,248,137]

theorem envBound4774 : H12AffineFastState.Bounded env4774 := by
  intro p hp
  have h : env4774.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4773_4774 : H12AffineEnvironment.transform 7 36 env4773 = env4774 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env4773 == env4774) = true)

theorem identity4774 : scanCanonicalize (H12AffineFastState.compose env4774 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 33) := by decide +kernel

theorem selectedBound4774 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4775 : List Nat := [2,4,8,16,32,33,128,36,136,157,1,168,41,153,0,171,153,1,156,0,169,32,33,139,160,17,0,153,169,1,189,42,36,42,153,137]

theorem envBound4775 : H12AffineFastState.Bounded env4775 := by
  intro p hp
  have h : env4775.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4774_4775 : H12AffineEnvironment.transform 5 33 env4774 = env4775 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 33 env4774 == env4775) = true)

theorem identity4775 : scanCanonicalize (H12AffineFastState.compose env4775 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound4775 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4776 : List Nat := [2,4,8,16,11,10,128,15,136,157,1,131,2,153,0,128,153,1,156,0,130,11,10,139,139,17,0,153,130,1,150,1,15,1,153,137]

theorem envBound4776 : H12AffineFastState.Bounded env4776 := by
  intro p hp
  have h : env4776.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4775_4776 : H12AffineEnvironment.transform 4 11 env4775 = env4776 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env4775 == env4776) = true)

def env4777 : List Nat := [2,4,8,16,32,64,128,37,137,156,1,169,41,249,1,171,248,1,157,1,168,32,65,138,160,17,1,248,168,0,189,75,36,75,248,136]

theorem envBound4777 : H12AffineFastState.Bounded env4777 := by
  intro p hp
  have h : env4777.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4773_4777 : H12AffineEnvironment.transform 7 37 env4773 = env4777 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env4773 == env4777) = true)

theorem identity4777 : scanCanonicalize (H12AffineFastState.compose env4777 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 27) := by decide +kernel

theorem selectedBound4777 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4778 : List Nat := [2,4,8,16,27,64,128,30,137,156,1,146,18,194,1,144,195,1,157,1,147,27,65,138,155,17,1,195,147,0,134,75,31,75,195,136]

theorem envBound4778 : H12AffineFastState.Bounded env4778 := by
  intro p hp
  have h : env4778.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4777_4778 : H12AffineEnvironment.transform 4 27 env4777 = env4778 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 27 env4777 == env4778) = true)

theorem identity4778 : scanCanonicalize (H12AffineFastState.compose env4778 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 19) := by decide +kernel

theorem selectedBound4778 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4779 : List Nat := [2,4,8,16,27,64,19,30,26,15,1,1,18,81,1,3,80,1,14,1,0,27,65,25,8,17,1,80,0,0,21,75,31,75,80,27]

theorem envBound4779 : H12AffineFastState.Bounded env4779 := by
  intro p hp
  have h : env4779.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4778_4779 : H12AffineEnvironment.transform 6 19 env4778 = env4779 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 19 env4778 == env4779) = true)

theorem identity4779 : scanCanonicalize (H12AffineFastState.compose env4779 (packedSelected [4] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound4779 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env4780 : List Nat := [2,4,8,11,0,64,8,5,1,15,1,1,9,74,1,3,75,1,14,1,0,0,65,2,8,10,1,75,0,0,14,75,4,75,75,0]

theorem envBound4780 : H12AffineFastState.Bounded env4780 := by
  intro p hp
  have h : env4780.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4779_4780 : H12AffineEnvironment.transform 3 11 env4779 = env4780 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env4779 == env4780) = true)

def leafEnv4780 : List Nat := [2,4,8,11,0,64,8,5,1,15,1,1,9,74,1,3,75,1,14,1,0,0,65,2,14,8,1,10,1,75,0,0,14,75,4,75,4,2,75,0,0,0,1]

def active4780 : List Nat := [0,1,2,5]

def tree4780 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4780 : H12WitnessSearch.Good tree4780 := H12GlobalWitnessIndex.good

theorem leafIdentity4780 : H12AffineFastState.composeSystem env4780 rootObs = leafEnv4780 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4780 rootObs == leafEnv4780) = true)

theorem terminalChecked4780 : H12PackedTerminal.terminalCheckFast leafEnv4780 active4780 tree4780 = true := by decide +kernel

def env4781 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,140617,5457,16777216,8329,17011013,270605,17011733,16876564,1073741824,131141,4294967296,17007941,4295599526,131072,513]

theorem envBound4781 : H12AffineFastState.Bounded env4781 := by
  intro p hp
  have h : env4781.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4616_4781 : H12AffineEnvironment.transform 21 140617 env4616 = env4781 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 140617 env4616 == env4781) = true)

def env4782 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1344,262144,524288,32768,4097,8201,5457,16777216,8329,16880645,270605,16879957,16876564,1073741824,1285,4294967296,16875525,4295599526,1344,513]

theorem envBound4782 : H12AffineFastState.Bounded env4782 := by
  intro p hp
  have h : env4782.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4781_4782 : H12AffineEnvironment.transform 16 1344 env4781 = env4782 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env4781 == env4782) = true)

theorem identity4782 : scanCanonicalize (H12AffineFastState.compose env4782 (packedSelected [4,9,16] rootPS)) = affineNative (2^(29+1) ^^^ 17313158) := by decide +kernel

theorem selectedBound4782 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env4783 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1344,262144,524288,32768,4097,8201,5457,16777216,8329,16880645,270605,16879957,16876564,17313158,1285,4294967296,16875525,4295599526,1344,513]

theorem envBound4783 : H12AffineFastState.Bounded env4783 := by
  intro p hp
  have h : env4783.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4782_4783 : H12AffineEnvironment.transform 29 17313158 env4782 = env4783 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 17313158 env4782 == env4783) = true)

def env4784 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,1344,262144,524288,32768,4097,8201,5457,16777216,8329,16880645,270605,16879957,16876564,17311110,1285,4294967296,16875525,4295599526,1344,513]

theorem envBound4784 : H12AffineFastState.Bounded env4784 := by
  intro p hp
  have h : env4784.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4783_4784 : H12AffineEnvironment.transform 10 0 env4783 = env4784 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env4783 == env4784) = true)

theorem identity4784 : scanCanonicalize (H12AffineFastState.compose env4784 (packedSelected [11] rootPS)) = affineNative (2^(18+1) ^^^ 78399) := by decide +kernel

theorem selectedBound4784 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env4785 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,1344,262144,78399,32768,4097,8201,5457,16777216,8329,16880645,270605,16879957,16876564,16848825,1285,4294967296,16875525,4295006105,1344,513]

theorem envBound4785 : H12AffineFastState.Bounded env4785 := by
  intro p hp
  have h : env4785.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4784_4785 : H12AffineEnvironment.transform 18 78399 env4784 = env4785 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 78399 env4784 == env4785) = true)

def env4786 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,1344,0,78399,32768,4097,8201,5457,16777216,8329,16880645,8461,16879957,16876564,16848825,1285,4294967296,16875525,4295006105,1344,513]

theorem envBound4786 : H12AffineFastState.Bounded env4786 := by
  intro p hp
  have h : env4786.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4785_4786 : H12AffineEnvironment.transform 17 0 env4785 = env4786 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env4785 == env4786) = true)

theorem identity4786 : scanCanonicalize (H12AffineFastState.compose env4786 (packedSelected [0,7] rootPS)) = affineNative (2^(23+1) ^^^ 98564) := by decide +kernel

theorem selectedBound4786 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4787 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,1344,0,78399,32768,4097,8201,5457,98564,8329,5377,8461,4177,1296,38589,1285,4294967296,257,4295006105,1344,513]

theorem envBound4787 : H12AffineFastState.Bounded env4787 := by
  intro p hp
  have h : env4787.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4786_4787 : H12AffineEnvironment.transform 23 98564 env4786 = env4787 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98564 env4786 == env4787) = true)

theorem identity4787 : scanCanonicalize (H12AffineFastState.compose env4787 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(14+1) ^^^ 8460) := by decide +kernel

theorem selectedBound4787 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env4788 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,8460,65536,1344,0,78399,8460,4097,8201,5457,73736,8329,5377,8461,4177,1296,14257,1285,4294967296,257,4294981269,1344,513]

theorem envBound4788 : H12AffineFastState.Bounded env4788 := by
  intro p hp
  have h : env4788.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4787_4788 : H12AffineEnvironment.transform 14 8460 env4787 = env4788 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8460 env4787 == env4788) = true)

theorem identity4788 : scanCanonicalize (H12AffineFastState.compose env4788 (packedSelected [20] rootPS)) = affineNative (2^(11+1) ^^^ 1945) := by decide +kernel

theorem selectedBound4788 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env4789 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1945,8192,1993,8460,65536,1344,0,75174,8460,1944,8201,712,73736,8329,664,8461,1992,1296,8232,1285,4294967296,257,4294975756,1344,513]

theorem envBound4789 : H12AffineFastState.Bounded env4789 := by
  intro p hp
  have h : env4789.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4788_4789 : H12AffineEnvironment.transform 11 1945 env4788 = env4789 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1945 env4788 == env4789) = true)

theorem identity4789 : scanCanonicalize (H12AffineFastState.compose env4789 (packedSelected [0,2,3,6,8,9,12,13] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound4789 : packedSelected [0,2,3,6,8,9,12,13] rootPS < 2^1333 := by decide +kernel

def env4790 : List Nat := [2,4,8,16,32,64,128,37,512,1024,0,1724,8192,1772,8233,65536,1125,0,74883,8233,1725,8201,712,73736,8329,664,8232,1773,1077,8232,1056,4294967296,36,4294975529,1125,513]

theorem envBound4790 : H12AffineFastState.Bounded env4790 := by
  intro p hp
  have h : env4790.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4789_4790 : H12AffineEnvironment.transform 7 37 env4789 = env4790 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env4789 == env4790) = true)

theorem identity4790 : scanCanonicalize (H12AffineFastState.compose env4790 (packedSelected [5,8] rootPS)) = affineNative (2^(15+1) ^^^ 8715) := by decide +kernel

theorem selectedBound4790 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env4791 : List Nat := [2,4,8,16,32,64,128,37,512,1024,0,1724,8192,1772,8233,8715,1125,0,1672,8233,1725,8201,712,515,8329,664,8232,1773,1077,8232,1056,4294967296,36,4294975529,1125,513]

theorem envBound4791 : H12AffineFastState.Bounded env4791 := by
  intro p hp
  have h : env4791.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4790_4791 : H12AffineEnvironment.transform 15 8715 env4790 = env4791 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8715 env4790 == env4791) = true)

theorem identity4791 : scanCanonicalize (H12AffineFastState.compose env4791 (packedSelected [2,4,5] rootPS)) = affineNative (2^(31+1) ^^^ 1671) := by decide +kernel

theorem selectedBound4791 : packedSelected [2,4,5] rootPS < 2^1333 := by decide +kernel

def env4792 : List Nat := [2,4,8,16,32,64,128,37,512,1024,0,1724,8192,1772,8233,8715,1125,0,1672,8233,1725,8201,712,515,8329,664,8232,1773,1077,8232,1056,1671,36,9902,1125,513]

theorem envBound4792 : H12AffineFastState.Bounded env4792 := by
  intro p hp
  have h : env4792.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4791_4792 : H12AffineEnvironment.transform 31 1671 env4791 = env4792 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1671 env4791 == env4792) = true)

theorem identity4792 : scanCanonicalize (H12AffineFastState.compose env4792 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(12+1) ^^^ 673) := by decide +kernel

theorem selectedBound4792 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env4793 : List Nat := [2,4,8,16,32,64,128,37,512,1024,0,1724,673,1772,648,170,1125,0,1672,648,1725,680,712,515,552,664,649,1773,1077,649,1056,1671,36,1039,1125,513]

theorem envBound4793 : H12AffineFastState.Bounded env4793 := by
  intro p hp
  have h : env4793.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4792_4793 : H12AffineEnvironment.transform 12 673 env4792 = env4793 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 673 env4792 == env4793) = true)

def env4794 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,1344,1,78399,32768,4097,8201,5457,16777216,8329,16880645,8460,16879957,16876564,16848825,1285,4294967296,16875525,4295006105,1344,513]

theorem envBound4794 : H12AffineFastState.Bounded env4794 := by
  intro p hp
  have h : env4794.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4785_4794 : H12AffineEnvironment.transform 17 1 env4785 = env4794 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env4785 == env4794) = true)

theorem identity4794 : scanCanonicalize (H12AffineFastState.compose env4794 (packedSelected [0,7] rootPS)) = affineNative (2^(23+1) ^^^ 106504) := by decide +kernel

theorem selectedBound4794 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4795 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,1344,1,78399,32768,4097,8201,5457,106504,8329,13325,8460,12637,9244,47025,1285,4294967296,8205,4295006105,1344,513]

theorem envBound4795 : H12AffineFastState.Bounded env4795 := by
  intro p hp
  have h : env4795.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4794_4795 : H12AffineEnvironment.transform 23 106504 env4794 = env4795 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 106504 env4794 == env4795) = true)

theorem identity4795 : scanCanonicalize (H12AffineFastState.compose env4795 (packedSelected [0,2,3,5,6,9,10,13,21] rootPS)) = affineNative (2^(14+1) ^^^ 293) := by decide +kernel

theorem selectedBound4795 : packedSelected [0,2,3,5,6,9,10,13,21] rootPS < 2^1333 := by decide +kernel

def env4796 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,293,65536,1344,1,78399,293,4097,8201,5457,74029,8329,13325,8460,12637,9244,13972,1285,4294967296,8205,4294973116,1344,513]

theorem envBound4796 : H12AffineFastState.Bounded env4796 := by
  intro p hp
  have h : env4796.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4795_4796 : H12AffineEnvironment.transform 14 293 env4795 = env4796 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 293 env4795 == env4796) = true)

theorem identity4796 : scanCanonicalize (H12AffineFastState.compose env4796 (packedSelected [0,2,4,5,6,8,9,10,12,17,20,22] rootPS)) = affineNative (2^(12+1) ^^^ 5781) := by decide +kernel

theorem selectedBound4796 : packedSelected [0,2,4,5,6,8,9,10,12,17,20,22] rootPS < 2^1333 := by decide +kernel

def env4797 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,5781,4176,293,65536,1344,1,66730,293,4097,5788,5457,71608,5660,664,6041,1992,4745,1,1285,4294967296,5784,4294973116,1344,513]

theorem envBound4797 : H12AffineFastState.Bounded env4797 := by
  intro p hp
  have h : env4797.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4796_4797 : H12AffineEnvironment.transform 12 5781 env4796 = env4797 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5781 env4796 == env4797) = true)

theorem identity4797 : scanCanonicalize (H12AffineFastState.compose env4797 (packedSelected [1,3,4,5,8,9,12,13,15,17] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound4797 : packedSelected [1,3,4,5,8,9,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env4798 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,901,1344,293,65536,1344,1,66730,293,1297,908,65,66216,780,664,649,1992,1945,1,1285,4294967296,904,4294968236,1344,513]

theorem envBound4798 : H12AffineFastState.Bounded env4798 := by
  intro p hp
  have h : env4798.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4797_4798 : H12AffineEnvironment.transform 11 1296 env4797 = env4798 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env4797 == env4798) = true)

theorem identity4798 : scanCanonicalize (H12AffineFastState.compose env4798 (packedSelected [4,9,23] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound4798 : packedSelected [4,9,23] rootPS < 2^1333 := by decide +kernel

def env4799 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,1296,269,1344,293,65536,1344,1,66730,293,1297,260,65,65568,388,16,1,1344,1297,1,1285,4294967296,256,4294967588,1344,137]

theorem envBound4799 : H12AffineFastState.Bounded env4799 := by
  intro p hp
  have h : env4799.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4798_4799 : H12AffineEnvironment.transform 8 136 env4798 = env4799 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env4798 == env4799) = true)

def env4800 : List Nat := [2,4,8,16,32,64,128,36,136,1024,0,1076,41,1124,1,65536,1124,1,66730,1,1077,32,65,65568,160,16,1,1124,1077,1,1057,4294967296,36,4294967296,1124,137]

theorem envBound4800 : H12AffineFastState.Bounded env4800 := by
  intro p hp
  have h : env4800.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4799_4800 : H12AffineEnvironment.transform 7 36 env4799 = env4800 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env4799 == env4800) = true)

theorem identity4800 : scanCanonicalize (H12AffineFastState.compose env4800 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 42) := by decide +kernel

theorem selectedBound4800 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4801 : List Nat := [2,4,8,16,32,64,128,36,136,1024,0,1076,41,1124,1,65536,1124,1,66730,1,1077,32,65,65568,160,16,1,1124,1077,1,1057,42,36,42,1124,137]

theorem envBound4801 : H12AffineFastState.Bounded env4801 := by
  intro p hp
  have h : env4801.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4800_4801 : H12AffineEnvironment.transform 31 42 env4800 = env4801 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 42 env4800 == env4801) = true)

theorem identity4801 : scanCanonicalize (H12AffineFastState.compose env4801 (packedSelected [1,3,4] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound4801 : packedSelected [1,3,4] rootPS < 2^1333 := by decide +kernel

def env4802 : List Nat := [2,4,8,10,32,64,128,36,136,1024,0,1070,41,1124,1,65536,1124,1,66730,1,1071,32,65,65568,160,10,1,1124,1071,1,1057,42,36,42,1124,137]

theorem envBound4802 : H12AffineFastState.Bounded env4802 := by
  intro p hp
  have h : env4802.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4801_4802 : H12AffineEnvironment.transform 3 10 env4801 = env4802 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env4801 == env4802) = true)

theorem identity4802 : scanCanonicalize (H12AffineFastState.compose env4802 (packedSelected [2,5] rootPS)) = affineNative (2^(15+1) ^^^ 171) := by decide +kernel

theorem selectedBound4802 : packedSelected [2,5] rootPS < 2^1333 := by decide +kernel

def env4803 : List Nat := [2,4,8,10,32,64,128,36,136,1024,0,1070,41,1124,1,171,1124,1,1025,1,1071,32,65,139,160,10,1,1124,1071,1,1057,42,36,42,1124,137]

theorem envBound4803 : H12AffineFastState.Bounded env4803 := by
  intro p hp
  have h : env4803.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4802_4803 : H12AffineEnvironment.transform 15 171 env4802 = env4803 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 171 env4802 == env4803) = true)

theorem identity4803 : scanCanonicalize (H12AffineFastState.compose env4803 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 72) := by decide +kernel

theorem selectedBound4803 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4804 : List Nat := [2,4,8,10,32,64,72,36,64,1024,0,1070,41,1124,1,99,1124,1,1025,1,1071,32,65,67,104,10,1,1124,1071,1,1057,42,36,42,1124,65]

theorem envBound4804 : H12AffineFastState.Bounded env4804 := by
  intro p hp
  have h : env4804.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4803_4804 : H12AffineEnvironment.transform 6 72 env4803 = env4804 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 72 env4803 == env4804) = true)

def env4805 : List Nat := [2,4,8,16,32,64,128,37,136,1024,0,1077,40,1125,0,65536,1125,1,66730,0,1076,33,65,65568,161,16,1,1125,1076,1,1056,4294967296,37,4294967297,1125,137]

theorem envBound4805 : H12AffineFastState.Bounded env4805 := by
  intro p hp
  have h : env4805.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4799_4805 : H12AffineEnvironment.transform 7 37 env4799 = env4805 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env4799 == env4805) = true)

theorem identity4805 : scanCanonicalize (H12AffineFastState.compose env4805 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 65544) := by decide +kernel

theorem selectedBound4805 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4806 : List Nat := [2,4,8,16,32,64,128,37,136,1024,0,1077,40,1125,0,65536,1125,1,66730,0,1076,33,65,65568,161,16,1,1125,1076,1,1056,65544,37,65545,1125,137]

theorem envBound4806 : H12AffineFastState.Bounded env4806 := by
  intro p hp
  have h : env4806.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4805_4806 : H12AffineEnvironment.transform 31 65544 env4805 = env4806 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65544 env4805 == env4806) = true)

theorem identity4806 : scanCanonicalize (H12AffineFastState.compose env4806 (packedSelected [1,3,4] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound4806 : packedSelected [1,3,4] rootPS < 2^1333 := by decide +kernel

def env4807 : List Nat := [2,4,8,1,32,64,128,37,136,1024,0,1060,40,1125,0,65536,1125,1,66730,0,1061,33,65,65568,161,1,1,1125,1061,1,1056,65544,37,65545,1125,137]

theorem envBound4807 : H12AffineFastState.Bounded env4807 := by
  intro p hp
  have h : env4807.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4806_4807 : H12AffineEnvironment.transform 3 1 env4806 = env4807 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env4806 == env4807) = true)

def env4808 : List Nat := [2,4,8,1,32,64,128,37,136,1024,0,1060,40,1125,0,192,1125,1,1130,0,1061,33,65,224,161,1,1,1125,1061,1,1056,200,37,201,1125,137]

theorem envBound4808 : H12AffineFastState.Bounded env4808 := by
  intro p hp
  have h : env4808.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4807_4808 : H12AffineEnvironment.transform 15 192 env4807 = env4808 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 192 env4807 == env4808) = true)

theorem identity4808 : scanCanonicalize (H12AffineFastState.compose env4808 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 43) := by decide +kernel

theorem selectedBound4808 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4809 : List Nat := [2,4,8,1,32,43,128,37,136,1024,0,1060,40,1038,0,171,1038,1,1025,0,1061,33,42,139,161,1,1,1038,1061,1,1056,163,37,162,1038,137]

theorem envBound4809 : H12AffineFastState.Bounded env4809 := by
  intro p hp
  have h : env4809.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4808_4809 : H12AffineEnvironment.transform 5 43 env4808 = env4809 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 43 env4808 == env4809) = true)

def leafEnv4809 : List Nat := [2,4,8,1,32,43,128,37,136,1024,0,1060,40,1038,0,171,1038,1,1025,0,1061,33,42,139,1057,161,1,1,1,1038,1061,1,1056,163,37,162,4,35,1038,137,0,1060,1]

def active4809 : List Nat := [0,1,2,4,6,9]

def tree4809 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4809 : H12WitnessSearch.Good tree4809 := H12GlobalWitnessIndex.good

theorem leafIdentity4809 : H12AffineFastState.composeSystem env4809 rootObs = leafEnv4809 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4809 rootObs == leafEnv4809) = true)

theorem terminalChecked4809 : H12PackedTerminal.terminalCheckFast leafEnv4809 active4809 tree4809 = true := by decide +kernel

def env4810 : List Nat := [2,4,8,1,32,64,128,37,136,1024,0,1060,40,1125,0,193,1125,1,1131,0,1061,33,65,225,161,1,1,1125,1061,1,1056,201,37,200,1125,137]

theorem envBound4810 : H12AffineFastState.Bounded env4810 := by
  intro p hp
  have h : env4810.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4807_4810 : H12AffineEnvironment.transform 15 193 env4807 = env4810 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 193 env4807 == env4810) = true)

def env4811 : List Nat := [2,4,8,1,32,64,104,37,96,1024,0,1060,40,1125,0,41,1125,1,1131,0,1061,33,65,9,73,1,1,1125,1061,1,1056,33,37,32,1125,97]

theorem envBound4811 : H12AffineFastState.Bounded env4811 := by
  intro p hp
  have h : env4811.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4810_4811 : H12AffineEnvironment.transform 6 104 env4810 = env4811 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 104 env4810 == env4811) = true)

theorem identity4811 : scanCanonicalize (H12AffineFastState.compose env4811 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 42) := by decide +kernel

theorem selectedBound4811 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4812 : List Nat := [2,4,8,1,32,42,2,37,10,1024,0,1060,40,1039,0,41,1039,1,1025,0,1061,33,43,9,35,1,1,1039,1061,1,1056,33,37,32,1039,11]

theorem envBound4812 : H12AffineFastState.Bounded env4812 := by
  intro p hp
  have h : env4812.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4811_4812 : H12AffineEnvironment.transform 5 42 env4811 = env4812 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 42 env4811 == env4812) = true)

def leafEnv4812 : List Nat := [2,4,8,1,32,42,2,37,10,1024,0,1060,40,1039,0,41,1039,1,1025,0,1061,33,43,9,1057,35,1,1,1,1039,1061,1,1056,33,37,32,4,35,1039,11,0,1060,1]

def active4812 : List Nat := [0,1,2,4,9]

def tree4812 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4812 : H12WitnessSearch.Good tree4812 := H12GlobalWitnessIndex.good

theorem leafIdentity4812 : H12AffineFastState.composeSystem env4812 rootObs = leafEnv4812 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4812 rootObs == leafEnv4812) = true)

theorem terminalChecked4812 : H12PackedTerminal.terminalCheckFast leafEnv4812 active4812 tree4812 = true := by decide +kernel

def env4813 : List Nat := [2,4,8,1,32,64,105,37,97,1024,0,1060,40,1125,0,40,1125,1,1131,0,1061,33,65,8,72,1,1,1125,1061,1,1056,32,37,33,1125,96]

theorem envBound4813 : H12AffineFastState.Bounded env4813 := by
  intro p hp
  have h : env4813.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4810_4813 : H12AffineEnvironment.transform 6 105 env4810 = env4813 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 105 env4810 == env4813) = true)

def env4814 : List Nat := [2,4,8,1,0,64,73,5,65,1024,0,1028,8,1093,0,8,1093,1,1099,0,1029,1,65,8,72,1,1,1093,1029,1,1024,0,5,1,1093,64]

theorem envBound4814 : H12AffineFastState.Bounded env4814 := by
  intro p hp
  have h : env4814.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4813_4814 : H12AffineEnvironment.transform 4 0 env4813 = env4814 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4813 == env4814) = true)

def leafEnv4814 : List Nat := [2,4,8,1,0,64,73,5,65,1024,0,1028,8,1093,0,8,1093,1,1099,0,1029,1,65,8,1099,72,1,1,1,1093,1029,1,1024,0,5,1,4,3,1093,64,0,1028,1]

def active4814 : List Nat := [0,1,2,5,9]

def tree4814 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4814 : H12WitnessSearch.Good tree4814 := H12GlobalWitnessIndex.good

theorem leafIdentity4814 : H12AffineFastState.composeSystem env4814 rootObs = leafEnv4814 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4814 rootObs == leafEnv4814) = true)

theorem terminalChecked4814 : H12PackedTerminal.terminalCheckFast leafEnv4814 active4814 tree4814 = true := by decide +kernel

def env4815 : List Nat := [2,4,8,1,1,64,72,4,64,1024,0,1029,9,1092,0,9,1092,1,1098,0,1028,0,65,8,72,1,1,1092,1028,1,1025,1,4,0,1092,65]

theorem envBound4815 : H12AffineFastState.Bounded env4815 := by
  intro p hp
  have h : env4815.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4813_4815 : H12AffineEnvironment.transform 4 1 env4813 = env4815 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4813 == env4815) = true)

theorem identity4815 : scanCanonicalize (H12AffineFastState.compose env4815 (packedSelected [3] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound4815 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4816 : List Nat := [2,4,8,1,1,11,3,4,11,1024,0,1029,9,1039,0,9,1039,1,1025,0,1028,0,10,8,3,1,1,1039,1028,1,1025,1,4,0,1039,10]

theorem envBound4816 : H12AffineFastState.Bounded env4816 := by
  intro p hp
  have h : env4816.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4815_4816 : H12AffineEnvironment.transform 5 11 env4815 = env4816 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env4815 == env4816) = true)

def leafEnv4816 : List Nat := [2,4,8,1,1,11,3,4,11,1024,0,1029,9,1039,0,9,1039,1,1025,0,1028,0,10,8,1024,3,1,1,1,1039,1028,1,1025,1,4,0,4,2,1039,10,0,1029,1]

def active4816 : List Nat := [0,1,2,9]

def tree4816 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4816 : H12WitnessSearch.Good tree4816 := H12GlobalWitnessIndex.good

theorem leafIdentity4816 : H12AffineFastState.composeSystem env4816 rootObs = leafEnv4816 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4816 rootObs == leafEnv4816) = true)

theorem terminalChecked4816 : H12PackedTerminal.terminalCheckFast leafEnv4816 active4816 tree4816 = true := by decide +kernel

def env4817 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,1344,262144,524288,32768,4097,8201,5457,16777216,8329,16880645,270605,16879957,16876564,17311111,1285,4294967296,16875525,4295599526,1344,513]

theorem envBound4817 : H12AffineFastState.Bounded env4817 := by
  intro p hp
  have h : env4817.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4783_4817 : H12AffineEnvironment.transform 10 1 env4783 = env4817 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env4783 == env4817) = true)

theorem identity4817 : scanCanonicalize (H12AffineFastState.compose env4817 (packedSelected [11] rootPS)) = affineNative (2^(23+1) ^^^ 537118) := by decide +kernel

theorem selectedBound4817 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env4818 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,1344,262144,524288,32768,4097,8201,5457,537118,8329,632347,270605,631627,636426,6041,1285,4294967296,635419,4295599526,1344,513]

theorem envBound4818 : H12AffineFastState.Bounded env4818 := by
  intro p hp
  have h : env4818.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4817_4818 : H12AffineEnvironment.transform 23 537118 env4817 = env4818 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 537118 env4817 == env4818) = true)

def env4819 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,1344,0,524288,32768,4097,8201,5457,537118,8329,632347,8461,631627,636426,6041,1285,4294967296,635419,4295599526,1344,513]

theorem envBound4819 : H12AffineFastState.Bounded env4819 := by
  intro p hp
  have h : env4819.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4818_4819 : H12AffineEnvironment.transform 17 0 env4818 = env4819 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env4818 == env4819) = true)

theorem identity4819 : scanCanonicalize (H12AffineFastState.compose env4819 (packedSelected [0,7] rootPS)) = affineNative (2^(14+1) ^^^ 5820) := by decide +kernel

theorem selectedBound4819 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4820 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,5820,65536,1344,0,524288,5820,4097,8201,5457,537118,8329,602279,8461,603639,598198,6041,1285,4294967296,599207,4295570202,1344,513]

theorem envBound4820 : H12AffineFastState.Bounded env4820 := by
  intro p hp
  have h : env4820.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4819_4820 : H12AffineEnvironment.transform 14 5820 env4819 = env4820 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 5820 env4819 == env4820) = true)

theorem identity4820 : scanCanonicalize (H12AffineFastState.compose env4820 (packedSelected [1,5,9,15,20,21,22] rootPS)) = affineNative (2^(18+1) ^^^ 75567) := by decide +kernel

theorem selectedBound4820 : packedSelected [1,5,9,15,20,21,22] rootPS < 2^1333 := by decide +kernel

def env4821 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,5820,65536,1344,0,75567,5820,4097,8201,5457,70961,8329,6024,8461,4824,1945,6041,1285,4294967296,904,4294972469,1344,513]

theorem envBound4821 : H12AffineFastState.Bounded env4821 := by
  intro p hp
  have h : env4821.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4820_4821 : H12AffineEnvironment.transform 18 75567 env4820 = env4821 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 75567 env4820 == env4821) = true)

theorem identity4821 : scanCanonicalize (H12AffineFastState.compose env4821 (packedSelected [4,5,8,9,10,12,17] rootPS)) = affineNative (2^(12+1) ^^^ 5148) := by decide +kernel

theorem selectedBound4821 : packedSelected [4,5,8,9,10,12,17] rootPS < 2^1333 := by decide +kernel

def env4822 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,5148,4176,5820,65536,1344,0,70451,5820,4097,5141,5457,70961,5269,6024,5393,4824,1945,6041,1285,4294967296,904,4294972469,1344,513]

theorem envBound4822 : H12AffineFastState.Bounded env4822 := by
  intro p hp
  have h : env4822.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4821_4822 : H12AffineEnvironment.transform 12 5148 env4821 = env4822 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5148 env4821 == env4822) = true)

theorem identity4822 : scanCanonicalize (H12AffineFastState.compose env4822 (packedSelected [0,1,2,3,4,6,10,13,15] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound4822 : packedSelected [0,1,2,3,4,6,10,13,15] rootPS < 2^1333 := by decide +kernel

def env4823 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,4096,5148,4176,5172,65536,1344,0,70075,5172,4097,5141,5457,70961,5269,5376,5393,4176,1297,5393,1285,4294967296,256,4294972469,1344,137]

theorem envBound4823 : H12AffineFastState.Bounded env4823 := by
  intro p hp
  have h : env4823.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4822_4823 : H12AffineEnvironment.transform 8 136 env4822 = env4823 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env4822 == env4823) = true)

theorem identity4823 : scanCanonicalize (H12AffineFastState.compose env4823 (packedSelected [3,5,10,12] rootPS)) = affineNative (2^(15+1) ^^^ 5563) := by decide +kernel

theorem selectedBound4823 : packedSelected [3,5,10,12] rootPS < 2^1333 := by decide +kernel

def env4824 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,4096,5148,4176,5172,5563,1344,0,1024,5172,4097,5141,5457,138,5269,5376,5393,4176,1297,5393,1285,4294967296,256,4294972469,1344,137]

theorem envBound4824 : H12AffineFastState.Bounded env4824 := by
  intro p hp
  have h : env4824.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4823_4824 : H12AffineEnvironment.transform 15 5563 env4823 = env4824 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5563 env4823 == env4824) = true)

theorem identity4824 : scanCanonicalize (H12AffineFastState.compose env4824 (packedSelected [1,3] rootPS)) = affineNative (2^(7+1) ^^^ 252) := by decide +kernel

theorem selectedBound4824 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4825 : List Nat := [2,4,8,16,32,64,128,252,136,1024,1,4096,5148,4176,5172,5191,1212,0,1024,5172,4097,5141,5293,138,5269,5372,5357,4176,1261,5357,1273,4294967296,252,4294972469,1212,137]

theorem envBound4825 : H12AffineFastState.Bounded env4825 := by
  intro p hp
  have h : env4825.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4824_4825 : H12AffineEnvironment.transform 7 252 env4824 = env4825 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 252 env4824 == env4825) = true)

theorem identity4825 : scanCanonicalize (H12AffineFastState.compose env4825 (packedSelected [2,4] rootPS)) = affineNative (2^(6+1) ^^^ 121) := by decide +kernel

theorem selectedBound4825 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env4826 : List Nat := [2,4,8,16,32,64,121,5,113,1024,1,4096,5148,4176,5172,5191,1093,0,1024,5172,4097,5141,5204,115,5228,5125,5140,4176,1044,5140,1024,4294967296,5,4294972469,1093,112]

theorem envBound4826 : H12AffineFastState.Bounded env4826 := by
  intro p hp
  have h : env4826.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4825_4826 : H12AffineEnvironment.transform 6 121 env4825 = env4826 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 121 env4825 == env4826) = true)

theorem identity4826 : scanCanonicalize (H12AffineFastState.compose env4826 (packedSelected [5] rootPS)) = affineNative (2^(11+1) ^^^ 1076) := by decide +kernel

theorem selectedBound4826 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env4827 : List Nat := [2,4,8,16,32,64,121,5,113,1024,1,1076,40,1124,0,115,1093,0,1024,0,1077,33,96,115,88,49,32,1124,1044,32,1024,4294967296,5,4294967297,1093,112]

theorem envBound4827 : H12AffineFastState.Bounded env4827 := by
  intro p hp
  have h : env4827.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4826_4827 : H12AffineEnvironment.transform 11 1076 env4826 = env4827 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1076 env4826 == env4827) = true)

theorem identity4827 : scanCanonicalize (H12AffineFastState.compose env4827 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 80) := by decide +kernel

theorem selectedBound4827 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4828 : List Nat := [2,4,8,16,32,64,121,5,113,1024,1,1076,40,1124,0,115,1093,0,1024,0,1077,33,96,115,88,49,32,1124,1044,32,1024,80,5,81,1093,112]

theorem envBound4828 : H12AffineFastState.Bounded env4828 := by
  intro p hp
  have h : env4828.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4827_4828 : H12AffineEnvironment.transform 31 80 env4827 = env4828 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 80 env4827 == env4828) = true)

theorem identity4828 : scanCanonicalize (H12AffineFastState.compose env4828 (packedSelected [0,2] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound4828 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env4829 : List Nat := [2,4,8,16,32,11,50,5,58,1024,1,1076,40,1071,0,56,1038,0,1024,0,1077,33,43,56,19,49,32,1071,1044,32,1024,27,5,26,1038,59]

theorem envBound4829 : H12AffineFastState.Bounded env4829 := by
  intro p hp
  have h : env4829.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4828_4829 : H12AffineEnvironment.transform 5 11 env4828 = env4829 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env4828 == env4829) = true)

def env4830 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,1344,1,524288,32768,4097,8201,5457,537118,8329,632347,8460,631627,636426,6041,1285,4294967296,635419,4295599526,1344,513]

theorem envBound4830 : H12AffineFastState.Bounded env4830 := by
  intro p hp
  have h : env4830.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4818_4830 : H12AffineEnvironment.transform 17 1 env4818 = env4830 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env4818 == env4830) = true)

theorem identity4830 : scanCanonicalize (H12AffineFastState.compose env4830 (packedSelected [0,7] rootPS)) = affineNative (2^(14+1) ^^^ 14256) := by decide +kernel

theorem selectedBound4830 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4831 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,14256,65536,1344,1,524288,14256,4097,8201,5457,537118,8329,594347,8460,595195,590266,6041,1285,4294967296,591275,4295561750,1344,513]

theorem envBound4831 : H12AffineFastState.Bounded env4831 := by
  intro p hp
  have h : env4831.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4830_4831 : H12AffineEnvironment.transform 14 14256 env4830 = env4831 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 14256 env4830 == env4831) = true)

theorem identity4831 : scanCanonicalize (H12AffineFastState.compose env4831 (packedSelected [0,2,3,4,5,6,9,10,13,18,20,21,22] rootPS)) = affineNative (2^(18+1) ^^^ 70450) := by decide +kernel

theorem selectedBound4831 : packedSelected [0,2,3,4,5,6,9,10,13,18,20,21,22] rootPS < 2^1333 := by decide +kernel

def env4832 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,14256,65536,1344,1,70450,14256,4097,8201,5457,74028,8329,665,8460,1993,4744,6041,1285,4294967296,5785,4294967588,1344,513]

theorem envBound4832 : H12AffineFastState.Bounded env4832 := by
  intro p hp
  have h : env4832.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4831_4832 : H12AffineEnvironment.transform 18 70450 env4831 = env4832 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 70450 env4831 == env4832) = true)

theorem identity4832 : scanCanonicalize (H12AffineFastState.compose env4832 (packedSelected [0,2,5,6,8,9,10,12,17,18] rootPS)) = affineNative (2^(12+1) ^^^ 5780) := by decide +kernel

theorem selectedBound4832 : packedSelected [0,2,5,6,8,9,10,12,17,18] rootPS < 2^1333 := by decide +kernel

def env4833 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,5780,4176,292,65536,1344,1,70450,292,4097,5789,5457,71608,5661,665,6040,1993,4744,6041,1285,4294967296,5785,4294967588,1344,513]

theorem envBound4833 : H12AffineFastState.Bounded env4833 := by
  intro p hp
  have h : env4833.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4832_4833 : H12AffineEnvironment.transform 12 5780 env4832 = env4833 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5780 env4832 == env4833) = true)

theorem identity4833 : scanCanonicalize (H12AffineFastState.compose env4833 (packedSelected [3,4,5,9,10,12,20] rootPS)) = affineNative (2^(11+1) ^^^ 1945) := by decide +kernel

theorem selectedBound4833 : packedSelected [3,4,5,9,10,12,20] rootPS < 2^1333 := by decide +kernel

def env4834 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1945,269,1993,292,65536,1344,1,66731,292,1944,260,712,65569,388,665,1,1993,1297,0,1285,4294967296,256,4294967588,1344,513]

theorem envBound4834 : H12AffineFastState.Bounded env4834 := by
  intro p hp
  have h : env4834.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4833_4834 : H12AffineEnvironment.transform 11 1945 env4833 = env4834 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1945 env4833 == env4834) = true)

theorem identity4834 : scanCanonicalize (H12AffineFastState.compose env4834 (packedSelected [5,8] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound4834 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env4835 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,1297,269,1345,292,65536,1344,1,66731,292,1296,260,64,65569,388,17,1,1345,1297,0,1285,4294967296,256,4294967588,1344,137]

theorem envBound4835 : H12AffineFastState.Bounded env4835 := by
  intro p hp
  have h : env4835.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4834_4835 : H12AffineEnvironment.transform 8 136 env4834 = env4835 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env4834 == env4835) = true)

def env4836 : List Nat := [2,4,8,16,32,64,128,36,136,1024,1,1077,41,1125,0,65536,1124,1,66731,0,1076,32,64,65569,160,17,1,1125,1077,0,1057,4294967296,36,4294967296,1124,137]

theorem envBound4836 : H12AffineFastState.Bounded env4836 := by
  intro p hp
  have h : env4836.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4835_4836 : H12AffineEnvironment.transform 7 36 env4835 = env4836 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env4835 == env4836) = true)

theorem identity4836 : scanCanonicalize (H12AffineFastState.compose env4836 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 65545) := by decide +kernel

theorem selectedBound4836 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4837 : List Nat := [2,4,8,16,32,64,128,36,136,1024,1,1077,41,1125,0,65536,1124,1,66731,0,1076,32,64,65569,160,17,1,1125,1077,0,1057,65545,36,65545,1124,137]

theorem envBound4837 : H12AffineFastState.Bounded env4837 := by
  intro p hp
  have h : env4837.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4836_4837 : H12AffineEnvironment.transform 31 65545 env4836 = env4837 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65545 env4836 == env4837) = true)

theorem identity4837 : scanCanonicalize (H12AffineFastState.compose env4837 (packedSelected [1,3,4] rootPS)) = affineNative (2^(15+1) ^^^ 104) := by decide +kernel

theorem selectedBound4837 : packedSelected [1,3,4] rootPS < 2^1333 := by decide +kernel

def env4838 : List Nat := [2,4,8,16,32,64,128,36,136,1024,1,1077,41,1125,0,104,1124,1,1219,0,1076,32,64,73,160,17,1,1125,1077,0,1057,97,36,97,1124,137]

theorem envBound4838 : H12AffineFastState.Bounded env4838 := by
  intro p hp
  have h : env4838.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4837_4838 : H12AffineEnvironment.transform 15 104 env4837 = env4838 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 104 env4837 == env4838) = true)

theorem identity4838 : scanCanonicalize (H12AffineFastState.compose env4838 (packedSelected [2,5] rootPS)) = affineNative (2^(6+1) ^^^ 66) := by decide +kernel

theorem selectedBound4838 : packedSelected [2,5] rootPS < 2^1333 := by decide +kernel

def env4839 : List Nat := [2,4,8,16,32,64,66,36,74,1024,1,1077,41,1125,0,104,1124,1,1025,0,1076,32,64,73,98,17,1,1125,1077,0,1057,97,36,97,1124,75]

theorem envBound4839 : H12AffineFastState.Bounded env4839 := by
  intro p hp
  have h : env4839.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4838_4839 : H12AffineEnvironment.transform 6 66 env4838 = env4839 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 66 env4838 == env4839) = true)

theorem identity4839 : scanCanonicalize (H12AffineFastState.compose env4839 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 26) := by decide +kernel

theorem selectedBound4839 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4840 : List Nat := [2,4,8,16,32,26,24,36,16,1024,1,1077,41,1087,0,50,1086,1,1025,0,1076,32,26,19,56,17,1,1087,1077,0,1057,59,36,59,1086,17]

theorem envBound4840 : H12AffineFastState.Bounded env4840 := by
  intro p hp
  have h : env4840.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4839_4840 : H12AffineEnvironment.transform 5 26 env4839 = env4840 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 26 env4839 == env4840) = true)

def env4841 : List Nat := [2,4,8,16,32,64,128,37,136,1024,1,1076,40,1124,1,65536,1125,1,66731,1,1077,33,64,65569,161,17,1,1124,1076,0,1056,4294967296,37,4294967297,1125,137]

theorem envBound4841 : H12AffineFastState.Bounded env4841 := by
  intro p hp
  have h : env4841.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4835_4841 : H12AffineEnvironment.transform 7 37 env4835 = env4841 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env4835 == env4841) = true)

theorem identity4841 : scanCanonicalize (H12AffineFastState.compose env4841 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 42) := by decide +kernel

theorem selectedBound4841 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4842 : List Nat := [2,4,8,16,32,64,128,37,136,1024,1,1076,40,1124,1,65536,1125,1,66731,1,1077,33,64,65569,161,17,1,1124,1076,0,1056,42,37,43,1125,137]

theorem envBound4842 : H12AffineFastState.Bounded env4842 := by
  intro p hp
  have h : env4842.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4841_4842 : H12AffineEnvironment.transform 31 42 env4841 = env4842 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 42 env4841 == env4842) = true)

theorem identity4842 : scanCanonicalize (H12AffineFastState.compose env4842 (packedSelected [1,3,4] rootPS)) = affineNative (2^(5+1) ^^^ 0) := by decide +kernel

theorem selectedBound4842 : packedSelected [1,3,4] rootPS < 2^1333 := by decide +kernel

def env4843 : List Nat := [2,4,8,16,32,0,128,37,136,1024,1,1076,40,1060,1,65536,1061,1,66731,1,1077,33,0,65569,161,17,1,1060,1076,0,1056,42,37,43,1061,137]

theorem envBound4843 : H12AffineFastState.Bounded env4843 := by
  intro p hp
  have h : env4843.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4842_4843 : H12AffineEnvironment.transform 5 0 env4842 = env4843 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env4842 == env4843) = true)

def env4844 : List Nat := [2,4,8,16,32,0,128,37,136,1024,1,1076,40,1060,1,128,1061,1,1067,1,1077,33,0,161,161,17,1,1060,1076,0,1056,42,37,43,1061,137]

theorem envBound4844 : H12AffineFastState.Bounded env4844 := by
  intro p hp
  have h : env4844.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4843_4844 : H12AffineEnvironment.transform 15 128 env4843 = env4844 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 128 env4843 == env4844) = true)

def env4845 : List Nat := [2,4,8,16,32,0,56,37,48,1024,1,1076,40,1060,1,56,1061,1,1067,1,1077,33,0,25,25,17,1,1060,1076,0,1056,42,37,43,1061,49]

theorem envBound4845 : H12AffineFastState.Bounded env4845 := by
  intro p hp
  have h : env4845.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4844_4845 : H12AffineEnvironment.transform 6 56 env4844 = env4845 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 56 env4844 == env4845) = true)

def env4846 : List Nat := [2,4,8,16,0,0,24,5,16,1024,1,1044,8,1028,1,24,1029,1,1035,1,1045,1,0,25,25,17,1,1028,1044,0,1024,10,5,11,1029,17]

theorem envBound4846 : H12AffineFastState.Bounded env4846 := by
  intro p hp
  have h : env4846.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4845_4846 : H12AffineEnvironment.transform 4 0 env4845 = env4846 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4845 == env4846) = true)

def leafEnv4846 : List Nat := [2,4,8,16,0,0,24,5,16,1024,1,1044,8,1028,1,24,1029,1,1035,1,1045,1,0,25,1035,25,1,17,1,1028,1044,0,1024,10,5,11,4,2,1029,17,0,1045,1]

def active4846 : List Nat := [0,1,2,3,9]

def tree4846 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4846 : H12WitnessSearch.Good tree4846 := H12GlobalWitnessIndex.good

theorem leafIdentity4846 : H12AffineFastState.composeSystem env4846 rootObs = leafEnv4846 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4846 rootObs == leafEnv4846) = true)

theorem terminalChecked4846 : H12PackedTerminal.terminalCheckFast leafEnv4846 active4846 tree4846 = true := by decide +kernel

def env4847 : List Nat := [2,4,8,16,1,0,25,4,17,1024,1,1045,9,1029,1,25,1028,1,1034,1,1044,0,0,25,25,17,1,1029,1045,0,1025,11,4,10,1028,16]

theorem envBound4847 : H12AffineFastState.Bounded env4847 := by
  intro p hp
  have h : env4847.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4845_4847 : H12AffineEnvironment.transform 4 1 env4845 = env4847 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4845 == env4847) = true)

theorem identity4847 : scanCanonicalize (H12AffineFastState.compose env4847 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound4847 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4848 : List Nat := [2,4,3,16,1,0,18,4,17,1024,1,1045,2,1029,1,18,1028,1,1025,1,1044,0,0,18,18,17,1,1029,1045,0,1025,0,4,1,1028,16]

theorem envBound4848 : H12AffineFastState.Bounded env4848 := by
  intro p hp
  have h : env4848.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4847_4848 : H12AffineEnvironment.transform 2 3 env4847 = env4848 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env4847 == env4848) = true)

def leafEnv4848 : List Nat := [2,4,3,16,1,0,18,4,17,1024,1,1045,2,1029,1,18,1028,1,1025,1,1044,0,0,18,1024,18,1,17,1,1029,1045,0,1025,0,4,1,4,3,1028,16,0,1044,1]

def active4848 : List Nat := [0,1,3,9]

def tree4848 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4848 : H12WitnessSearch.Good tree4848 := H12GlobalWitnessIndex.good

theorem leafIdentity4848 : H12AffineFastState.composeSystem env4848 rootObs = leafEnv4848 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4848 rootObs == leafEnv4848) = true)

theorem terminalChecked4848 : H12PackedTerminal.terminalCheckFast leafEnv4848 active4848 tree4848 = true := by decide +kernel

def env4849 : List Nat := [2,4,8,16,32,0,57,37,49,1024,1,1076,40,1060,1,57,1061,1,1067,1,1077,33,0,24,24,17,1,1060,1076,0,1056,42,37,43,1061,48]

theorem envBound4849 : H12AffineFastState.Bounded env4849 := by
  intro p hp
  have h : env4849.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4844_4849 : H12AffineEnvironment.transform 6 57 env4844 = env4849 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 57 env4844 == env4849) = true)

theorem identity4849 : scanCanonicalize (H12AffineFastState.compose env4849 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound4849 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4850 : List Nat := [2,4,8,16,10,0,19,15,27,1024,1,1054,2,1038,1,19,1039,1,1025,1,1055,11,0,24,24,17,1,1038,1054,0,1034,0,15,1,1039,26]

theorem envBound4850 : H12AffineFastState.Bounded env4850 := by
  intro p hp
  have h : env4850.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4849_4850 : H12AffineEnvironment.transform 4 10 env4849 = env4850 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env4849 == env4850) = true)

def leafEnv4850 : List Nat := [2,4,8,16,10,0,19,15,27,1024,1,1054,2,1038,1,19,1039,1,1025,1,1055,11,0,24,1035,24,1,17,1,1038,1054,0,1034,0,15,1,4,8,1039,26,0,1055,1]

def active4850 : List Nat := [0,1,2,3,9]

def tree4850 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4850 : H12WitnessSearch.Good tree4850 := H12GlobalWitnessIndex.good

theorem leafIdentity4850 : H12AffineFastState.composeSystem env4850 rootObs = leafEnv4850 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4850 rootObs == leafEnv4850) = true)

theorem terminalChecked4850 : H12PackedTerminal.terminalCheckFast leafEnv4850 active4850 tree4850 = true := by decide +kernel

def env4851 : List Nat := [2,4,8,16,32,0,128,37,136,1024,1,1076,40,1060,1,129,1061,1,1066,1,1077,33,0,160,161,17,1,1060,1076,0,1056,42,37,43,1061,137]

theorem envBound4851 : H12AffineFastState.Bounded env4851 := by
  intro p hp
  have h : env4851.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4843_4851 : H12AffineEnvironment.transform 15 129 env4843 = env4851 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 129 env4843 == env4851) = true)

theorem identity4851 : scanCanonicalize (H12AffineFastState.compose env4851 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound4851 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4852 : List Nat := [2,4,8,16,11,0,128,14,136,1024,1,1055,3,1039,1,129,1038,1,1025,1,1054,10,0,139,138,17,1,1039,1055,0,1035,1,14,0,1038,137]

theorem envBound4852 : H12AffineFastState.Bounded env4852 := by
  intro p hp
  have h : env4852.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4851_4852 : H12AffineEnvironment.transform 4 11 env4851 = env4852 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env4851 == env4852) = true)

def leafEnv4852 : List Nat := [2,4,8,16,11,0,128,14,136,1024,1,1055,3,1039,1,129,1038,1,1025,1,1054,10,0,139,1034,138,1,17,1,1039,1055,0,1035,1,14,0,4,9,1038,137,0,1054,1]

def active4852 : List Nat := [0,1,2,3,6,9]

def tree4852 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4852 : H12WitnessSearch.Good tree4852 := H12GlobalWitnessIndex.good

theorem leafIdentity4852 : H12AffineFastState.composeSystem env4852 rootObs = leafEnv4852 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4852 rootObs == leafEnv4852) = true)

theorem terminalChecked4852 : H12PackedTerminal.terminalCheckFast leafEnv4852 active4852 tree4852 = true := by decide +kernel

def env4853 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1345,262144,524288,32768,4097,8200,5457,16777216,8329,16880644,270605,16879956,16876564,1073741824,1284,4294967296,16875524,4295599526,1345,513]

theorem envBound4853 : H12AffineFastState.Bounded env4853 := by
  intro p hp
  have h : env4853.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4781_4853 : H12AffineEnvironment.transform 16 1345 env4781 = env4853 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env4781 == env4853) = true)

theorem identity4853 : scanCanonicalize (H12AffineFastState.compose env4853 (packedSelected [4,9,16] rootPS)) = affineNative (2^(29+1) ^^^ 108675) := by decide +kernel

theorem selectedBound4853 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env4854 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1345,262144,524288,32768,4097,8200,5457,16777216,8329,16880644,270605,16879956,16876564,108675,1284,4294967296,16875524,4295599526,1345,513]

theorem envBound4854 : H12AffineFastState.Bounded env4854 := by
  intro p hp
  have h : env4854.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4853_4854 : H12AffineEnvironment.transform 29 108675 env4853 = env4854 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 108675 env4853 == env4854) = true)

def env4855 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,1345,262144,524288,32768,4097,8200,5457,16777216,8329,16880644,270605,16879956,16876564,106627,1284,4294967296,16875524,4295599526,1345,513]

theorem envBound4855 : H12AffineFastState.Bounded env4855 := by
  intro p hp
  have h : env4855.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4854_4855 : H12AffineEnvironment.transform 10 0 env4854 = env4855 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env4854 == env4855) = true)

theorem identity4855 : scanCanonicalize (H12AffineFastState.compose env4855 (packedSelected [11] rootPS)) = affineNative (2^(17+1) ^^^ 71475) := by decide +kernel

theorem selectedBound4855 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env4856 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,1345,71475,524288,32768,4097,8200,5457,16777216,8329,16880644,79422,16879956,16876564,106627,1284,4294967296,16875524,4295599526,1345,513]

theorem envBound4856 : H12AffineFastState.Bounded env4856 := by
  intro p hp
  have h : env4856.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4855_4856 : H12AffineEnvironment.transform 17 71475 env4855 = env4856 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 71475 env4855 == env4856) = true)

def env4857 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,1344,32768,65536,1345,66083,524288,32768,1297,8200,65,16777216,8329,16875796,74542,16876612,16876564,106627,1284,4294967296,16875524,4295599526,1345,513]

theorem envBound4857 : H12AffineFastState.Bounded env4857 := by
  intro p hp
  have h : env4857.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4856_4857 : H12AffineEnvironment.transform 11 1296 env4856 = env4857 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env4856 == env4857) = true)

theorem identity4857 : scanCanonicalize (H12AffineFastState.compose env4857 (packedSelected [0,7,20] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound4857 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env4858 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1296,8192,1344,32768,65536,1345,65706,524288,32768,1297,8200,65,16777216,8329,16875796,74151,16876612,16876564,106627,1284,4294967296,16875524,4295599526,1345,136]

theorem envBound4858 : H12AffineFastState.Bounded env4858 := by
  intro p hp
  have h : env4858.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4857_4858 : H12AffineEnvironment.transform 8 137 env4857 = env4858 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env4857 == env4858) = true)

theorem identity4858 : scanCanonicalize (H12AffineFastState.compose env4858 (packedSelected [1,3,4,9,10,13,15,18] rootPS)) = affineNative (2^(15+1) ^^^ 33167) := by decide +kernel

theorem selectedBound4858 : packedSelected [1,3,4,9,10,13,15,18] rootPS < 2^1333 := by decide +kernel

def env4859 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1296,8192,1344,32768,33167,1345,33061,524288,32768,1297,8200,65,16777216,8329,16777371,41000,16778699,16778651,8460,1284,4294967296,16777611,4295500841,1345,136]

theorem envBound4859 : H12AffineFastState.Bounded env4859 := by
  intro p hp
  have h : env4859.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4858_4859 : H12AffineEnvironment.transform 15 33167 env4858 = env4859 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33167 env4858 == env4859) = true)

theorem identity4859 : scanCanonicalize (H12AffineFastState.compose env4859 (packedSelected [0,4,5,7,8,9,10,12,17] rootPS)) = affineNative (2^(23+1) ^^^ 8583) := by decide +kernel

theorem selectedBound4859 : packedSelected [0,4,5,7,8,9,10,12,17] rootPS < 2^1333 := by decide +kernel

def env4860 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1296,8192,1344,32768,33167,1345,33061,524288,32768,1297,8200,65,8583,8329,8476,41000,9292,9244,8460,1284,4294967296,8204,4295500841,1345,136]

theorem envBound4860 : H12AffineFastState.Bounded env4860 := by
  intro p hp
  have h : env4860.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4859_4860 : H12AffineEnvironment.transform 23 8583 env4859 = env4860 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 8583 env4859 == env4860) = true)

theorem identity4860 : scanCanonicalize (H12AffineFastState.compose env4860 (packedSelected [0,1,4,5,7,9,12,21] rootPS)) = affineNative (2^(12+1) ^^^ 269) := by decide +kernel

theorem selectedBound4860 : packedSelected [0,1,4,5,7,9,12,21] rootPS < 2^1333 := by decide +kernel

def env4861 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1296,269,1344,32768,33167,1345,33061,524288,32768,1297,261,65,138,388,17,33061,1345,1297,1,1284,4294967296,257,4295492900,1345,136]

theorem envBound4861 : H12AffineFastState.Bounded env4861 := by
  intro p hp
  have h : env4861.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4860_4861 : H12AffineEnvironment.transform 12 269 env4860 = env4861 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 269 env4860 == env4861) = true)

theorem identity4861 : scanCanonicalize (H12AffineFastState.compose env4861 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound4861 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env4862 : List Nat := [2,4,8,16,32,64,128,5,137,1024,0,1045,8,1093,32768,32906,1092,32800,524288,32768,1044,0,65,138,129,17,32800,1092,1044,1,1025,4294967296,4,4295492641,1092,136]

theorem envBound4862 : H12AffineFastState.Bounded env4862 := by
  intro p hp
  have h : env4862.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4861_4862 : H12AffineEnvironment.transform 7 5 env4861 = env4862 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env4861 == env4862) = true)

theorem identity4862 : scanCanonicalize (H12AffineFastState.compose env4862 (packedSelected [3,10] rootPS)) = affineNative (2^(14+1) ^^^ 32) := by decide +kernel

theorem selectedBound4862 : packedSelected [3,10] rootPS < 2^1333 := by decide +kernel

def env4863 : List Nat := [2,4,8,16,32,64,128,5,137,1024,0,1045,8,1093,32,170,1092,0,524288,32,1044,0,65,138,129,17,0,1092,1044,1,1025,4294967296,4,4295492641,1092,136]

theorem envBound4863 : H12AffineFastState.Bounded env4863 := by
  intro p hp
  have h : env4863.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4862_4863 : H12AffineEnvironment.transform 14 32 env4862 = env4863 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 32 env4862 == env4863) = true)

def env4864 : List Nat := [2,4,8,16,0,64,128,5,137,1024,0,1045,8,1093,0,138,1092,0,524288,0,1044,0,65,138,129,17,0,1092,1044,1,1025,4294967296,4,4295492609,1092,136]

theorem envBound4864 : H12AffineFastState.Bounded env4864 := by
  intro p hp
  have h : env4864.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4863_4864 : H12AffineEnvironment.transform 4 0 env4863 = env4864 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4863 == env4864) = true)

theorem identity4864 : scanCanonicalize (H12AffineFastState.compose env4864 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 1238) := by decide +kernel

theorem selectedBound4864 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4865 : List Nat := [2,4,8,16,0,64,128,5,137,1024,0,1045,8,1093,0,138,1092,0,524288,0,1044,0,65,138,129,17,0,1092,1044,1,1025,1238,4,524503,1092,136]

theorem envBound4865 : H12AffineFastState.Bounded env4865 := by
  intro p hp
  have h : env4865.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4864_4865 : H12AffineEnvironment.transform 31 1238 env4864 = env4865 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1238 env4864 == env4865) = true)

theorem identity4865 : scanCanonicalize (H12AffineFastState.compose env4865 (packedSelected [2,3] rootPS)) = affineNative (2^(9+1) ^^^ 14) := by decide +kernel

theorem selectedBound4865 : packedSelected [2,3] rootPS < 2^1333 := by decide +kernel

def env4866 : List Nat := [2,4,8,16,0,64,128,5,137,14,0,27,8,75,0,138,74,0,524288,0,26,0,65,138,129,17,0,74,26,1,15,216,4,524503,74,136]

theorem envBound4866 : H12AffineFastState.Bounded env4866 := by
  intro p hp
  have h : env4866.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4865_4866 : H12AffineEnvironment.transform 9 14 env4865 = env4866 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 14 env4865 == env4866) = true)

theorem identity4866 : scanCanonicalize (H12AffineFastState.compose env4866 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound4866 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4867 : List Nat := [2,4,8,16,0,64,8,5,1,14,0,27,8,75,0,2,74,0,524288,0,26,0,65,2,9,17,0,74,26,1,15,80,4,524383,74,0]

theorem envBound4867 : H12AffineFastState.Bounded env4867 := by
  intro p hp
  have h : env4867.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4866_4867 : H12AffineEnvironment.transform 6 8 env4866 = env4867 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env4866 == env4867) = true)

def leafEnv4867 : List Nat := [2,4,8,16,0,64,8,5,1,14,0,27,8,75,0,2,74,0,524288,0,26,0,65,2,524288,9,1,17,0,74,26,1,15,80,4,524383,4,3,74,0,0,26,1]

def active4867 : List Nat := [0,1,2,3,5,18]

def tree4867 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4867 : H12WitnessSearch.Good tree4867 := H12GlobalWitnessIndex.good

theorem leafIdentity4867 : H12AffineFastState.composeSystem env4867 rootObs = leafEnv4867 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4867 rootObs == leafEnv4867) = true)

theorem terminalChecked4867 : H12PackedTerminal.terminalCheckFast leafEnv4867 active4867 tree4867 = true := by decide +kernel

def env4868 : List Nat := [2,4,8,16,1,64,128,5,137,1024,0,1045,8,1093,1,139,1092,0,524288,1,1044,0,65,138,129,17,0,1092,1044,1,1025,4294967296,4,4295492608,1092,136]

theorem envBound4868 : H12AffineFastState.Bounded env4868 := by
  intro p hp
  have h : env4868.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4863_4868 : H12AffineEnvironment.transform 4 1 env4863 = env4868 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4863 == env4868) = true)

theorem identity4868 : scanCanonicalize (H12AffineFastState.compose env4868 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 1119) := by decide +kernel

theorem selectedBound4868 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4869 : List Nat := [2,4,8,16,1,64,128,5,137,1024,0,1045,8,1093,1,139,1092,0,524288,1,1044,0,65,138,129,17,0,1092,1044,1,1025,1119,4,524383,1092,136]

theorem envBound4869 : H12AffineFastState.Bounded env4869 := by
  intro p hp
  have h : env4869.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4868_4869 : H12AffineEnvironment.transform 31 1119 env4868 = env4869 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1119 env4868 == env4869) = true)

theorem identity4869 : scanCanonicalize (H12AffineFastState.compose env4869 (packedSelected [1,2] rootPS)) = affineNative (2^(9+1) ^^^ 134) := by decide +kernel

theorem selectedBound4869 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env4870 : List Nat := [2,4,8,16,1,64,128,5,137,134,0,147,8,195,1,139,194,0,524288,1,146,0,65,138,129,17,0,194,146,1,135,217,4,524383,194,136]

theorem envBound4870 : H12AffineFastState.Bounded env4870 := by
  intro p hp
  have h : env4870.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4869_4870 : H12AffineEnvironment.transform 9 134 env4869 = env4870 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 134 env4869 == env4870) = true)

theorem identity4870 : scanCanonicalize (H12AffineFastState.compose env4870 (packedSelected [3] rootPS)) = affineNative (2^(18+1) ^^^ 215) := by decide +kernel

theorem selectedBound4870 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4871 : List Nat := [2,4,8,16,1,64,128,5,137,134,0,147,8,195,1,139,194,0,215,1,146,0,65,138,129,17,0,194,146,1,135,217,4,136,194,136]

theorem envBound4871 : H12AffineFastState.Bounded env4871 := by
  intro p hp
  have h : env4871.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4870_4871 : H12AffineEnvironment.transform 18 215 env4870 = env4871 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 215 env4870 == env4871) = true)

theorem identity4871 : scanCanonicalize (H12AffineFastState.compose env4871 (packedSelected [1,5] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound4871 : packedSelected [1,5] rootPS < 2^1333 := by decide +kernel

def env4872 : List Nat := [2,4,8,16,1,17,128,5,137,134,0,147,8,146,1,139,147,0,134,1,146,0,16,138,129,17,0,147,146,1,135,136,4,136,147,136]

theorem envBound4872 : H12AffineFastState.Bounded env4872 := by
  intro p hp
  have h : env4872.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4871_4872 : H12AffineEnvironment.transform 5 17 env4871 = env4872 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env4871 == env4872) = true)

def leafEnv4872 : List Nat := [2,4,8,16,1,17,128,5,137,134,0,147,8,146,1,139,147,0,134,1,146,0,16,138,134,129,1,17,0,147,146,1,135,136,4,136,4,2,147,136,0,146,1]

def active4872 : List Nat := [0,1,2,3,6]

def tree4872 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4872 : H12WitnessSearch.Good tree4872 := H12GlobalWitnessIndex.good

theorem leafIdentity4872 : H12AffineFastState.composeSystem env4872 rootObs = leafEnv4872 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4872 rootObs == leafEnv4872) = true)

theorem terminalChecked4872 : H12PackedTerminal.terminalCheckFast leafEnv4872 active4872 tree4872 = true := by decide +kernel

def env4873 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,1345,32768,65536,1345,66082,524288,32768,1296,8200,64,16777216,8329,16875797,74543,16876613,16876564,106627,1284,4294967296,16875524,4295599526,1345,513]

theorem envBound4873 : H12AffineFastState.Bounded env4873 := by
  intro p hp
  have h : env4873.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4856_4873 : H12AffineEnvironment.transform 11 1297 env4856 = env4873 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env4856 == env4873) = true)

theorem identity4873 : scanCanonicalize (H12AffineFastState.compose env4873 (packedSelected [0,7,20] rootPS)) = affineNative (2^(23+1) ^^^ 99212) := by decide +kernel

theorem selectedBound4873 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env4874 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,1345,32768,65536,1345,66082,524288,32768,1296,8200,64,99212,8329,665,74543,1993,1944,106627,1284,4294967296,904,4295599526,1345,513]

theorem envBound4874 : H12AffineFastState.Bounded env4874 := by
  intro p hp
  have h : env4874.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4873_4874 : H12AffineEnvironment.transform 23 99212 env4873 = env4874 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 99212 env4873 == env4874) = true)

theorem identity4874 : scanCanonicalize (H12AffineFastState.compose env4874 (packedSelected [2,6,7,9,23] rootPS)) = affineNative (2^(14+1) ^^^ 8233) := by decide +kernel

theorem selectedBound4874 : packedSelected [2,6,7,9,23] rootPS < 2^1333 := by decide +kernel

def env4875 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,1345,8233,65536,1345,66082,524288,8233,1296,8200,64,74661,8329,665,74543,1993,1944,65706,1284,4294967296,904,4295558543,1345,513]

theorem envBound4875 : H12AffineFastState.Bounded env4875 := by
  intro p hp
  have h : env4875.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4874_4875 : H12AffineEnvironment.transform 14 8233 env4874 = env4875 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8233 env4874 == env4875) = true)

theorem identity4875 : scanCanonicalize (H12AffineFastState.compose env4875 (packedSelected [0,1,2,3,4,6,10,13,15,18] rootPS)) = affineNative (2^(15+1) ^^^ 8614) := by decide +kernel

theorem selectedBound4875 : packedSelected [0,1,2,3,4,6,10,13,15,18] rootPS < 2^1333 := by decide +kernel

def env4876 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,1345,8233,8614,1345,9092,524288,8233,1296,8200,64,515,8329,665,649,1993,1944,8460,1284,4294967296,904,4295500841,1345,513]

theorem envBound4876 : H12AffineFastState.Bounded env4876 := by
  intro p hp
  have h : env4876.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4875_4876 : H12AffineEnvironment.transform 15 8614 env4875 = env4876 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8614 env4875 == env4876) = true)

theorem identity4876 : scanCanonicalize (H12AffineFastState.compose env4876 (packedSelected [4,5,9,12,13,28] rootPS)) = affineNative (2^(12+1) ^^^ 268) := by decide +kernel

theorem selectedBound4876 : packedSelected [4,5,9,12,13,28] rootPS < 2^1333 := by decide +kernel

def env4877 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,268,1345,293,170,1345,648,524288,293,1296,260,64,515,389,665,649,1993,1944,0,1284,4294967296,904,4295492901,1345,513]

theorem envBound4877 : H12AffineFastState.Bounded env4877 := by
  intro p hp
  have h : env4877.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4876_4877 : H12AffineEnvironment.transform 12 268 env4876 = env4877 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 268 env4876 == env4877) = true)

theorem identity4877 : scanCanonicalize (H12AffineFastState.compose env4877 (packedSelected [3,4,5,9,10,12] rootPS)) = affineNative (2^(18+1) ^^^ 1025) := by decide +kernel

theorem selectedBound4877 : packedSelected [3,4,5,9,10,12] rootPS < 2^1333 := by decide +kernel

def env4878 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,268,1345,293,170,1345,648,1025,293,1296,260,64,515,389,665,649,1993,1944,0,1284,4294967296,904,4294967588,1345,513]

theorem envBound4878 : H12AffineFastState.Bounded env4878 := by
  intro p hp
  have h : env4878.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4877_4878 : H12AffineEnvironment.transform 18 1025 env4877 = env4878 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env4877 == env4878) = true)

theorem identity4878 : scanCanonicalize (H12AffineFastState.compose env4878 (packedSelected [1,5,10] rootPS)) = affineNative (2^(8+1) ^^^ 428) := by decide +kernel

theorem selectedBound4878 : packedSelected [1,5,10] rootPS < 2^1333 := by decide +kernel

def env4879 : List Nat := [2,4,8,16,32,64,128,256,428,1024,0,1297,268,1345,293,170,1345,292,1025,293,1296,260,64,431,389,309,293,1125,1076,0,1284,4294967296,36,4294967588,1345,429]

theorem envBound4879 : H12AffineFastState.Bounded env4879 := by
  intro p hp
  have h : env4879.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4878_4879 : H12AffineEnvironment.transform 8 428 env4878 = env4879 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 428 env4878 == env4879) = true)

theorem identity4879 : scanCanonicalize (H12AffineFastState.compose env4879 (packedSelected [1,2] rootPS)) = affineNative (2^(31+1) ^^^ 293) := by decide +kernel

theorem selectedBound4879 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env4880 : List Nat := [2,4,8,16,32,64,128,256,428,1024,0,1297,268,1345,293,170,1345,292,1025,293,1296,260,64,431,389,309,293,1125,1076,0,1284,293,36,1,1345,429]

theorem envBound4880 : H12AffineFastState.Bounded env4880 := by
  intro p hp
  have h : env4880.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4879_4880 : H12AffineEnvironment.transform 31 293 env4879 = env4880 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 293 env4879 == env4880) = true)

def env4881 : List Nat := [2,4,8,16,32,64,128,256,428,304,0,33,268,113,293,170,113,292,305,293,32,260,64,431,389,309,293,341,260,0,52,293,36,1,113,429]

theorem envBound4881 : H12AffineFastState.Bounded env4881 := by
  intro p hp
  have h : env4881.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4880_4881 : H12AffineEnvironment.transform 9 304 env4880 = env4881 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 304 env4880 == env4881) = true)

theorem identity4881 : scanCanonicalize (H12AffineFastState.compose env4881 (packedSelected [0] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound4881 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4882 : List Nat := [2,4,8,16,32,10,128,256,428,304,0,33,268,59,293,170,59,292,305,293,32,260,10,431,389,309,293,287,260,0,52,293,36,1,59,429]

theorem envBound4882 : H12AffineFastState.Bounded env4882 := by
  intro p hp
  have h : env4882.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4881_4882 : H12AffineEnvironment.transform 5 10 env4881 = env4882 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env4881 == env4882) = true)

def env4883 : List Nat := [2,4,8,16,32,10,128,36,136,20,0,33,40,59,1,170,59,0,21,1,32,32,10,139,161,17,1,59,32,0,52,1,36,1,59,137]

theorem envBound4883 : H12AffineFastState.Bounded env4883 := by
  intro p hp
  have h : env4883.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4882_4883 : H12AffineEnvironment.transform 7 36 env4882 = env4883 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env4882 == env4883) = true)

theorem identity4883 : scanCanonicalize (H12AffineFastState.compose env4883 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound4883 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4884 : List Nat := [2,4,8,16,11,10,128,15,136,20,0,10,3,16,1,129,16,0,21,1,11,11,10,139,138,17,1,16,11,0,31,1,15,1,16,137]

theorem envBound4884 : H12AffineFastState.Bounded env4884 := by
  intro p hp
  have h : env4884.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4883_4884 : H12AffineEnvironment.transform 4 11 env4883 = env4884 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env4883 == env4884) = true)

def env4885 : List Nat := [2,4,8,16,32,10,128,37,137,21,0,33,41,59,0,170,59,1,20,0,32,33,10,138,160,16,0,58,33,0,52,0,36,1,59,136]

theorem envBound4885 : H12AffineFastState.Bounded env4885 := by
  intro p hp
  have h : env4885.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4882_4885 : H12AffineEnvironment.transform 7 37 env4882 = env4885 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env4882 == env4885) = true)

theorem identity4885 : scanCanonicalize (H12AffineFastState.compose env4885 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 41) := by decide +kernel

theorem selectedBound4885 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4886 : List Nat := [2,4,8,16,32,10,41,37,32,21,0,33,41,59,0,3,59,1,20,0,32,33,10,35,9,16,0,58,33,0,52,0,36,1,59,33]

theorem envBound4886 : H12AffineFastState.Bounded env4886 := by
  intro p hp
  have h : env4886.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4885_4886 : H12AffineEnvironment.transform 6 41 env4885 = env4886 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 41 env4885 == env4886) = true)

theorem identity4886 : scanCanonicalize (H12AffineFastState.compose env4886 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 26) := by decide +kernel

theorem selectedBound4886 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4887 : List Nat := [2,4,8,16,26,10,19,31,26,21,0,27,19,1,0,3,1,1,20,0,26,27,10,25,9,16,0,0,27,0,14,0,30,1,1,27]

theorem envBound4887 : H12AffineFastState.Bounded env4887 := by
  intro p hp
  have h : env4887.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4886_4887 : H12AffineEnvironment.transform 4 26 env4886 = env4887 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 26 env4886 == env4887) = true)

theorem identity4887 : scanCanonicalize (H12AffineFastState.compose env4887 (packedSelected [4] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound4887 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env4888 : List Nat := [2,4,8,10,0,10,9,5,0,15,0,1,9,1,0,3,1,1,14,0,0,1,10,3,9,10,0,0,1,0,14,0,4,1,1,1]

theorem envBound4888 : H12AffineFastState.Bounded env4888 := by
  intro p hp
  have h : env4888.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4887_4888 : H12AffineEnvironment.transform 3 10 env4887 = env4888 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env4887 == env4888) = true)

def env4889 : List Nat := [2,4,8,16,32,64,128,256,428,305,0,32,268,112,293,170,112,292,304,293,33,260,64,431,389,309,293,340,261,0,53,293,36,1,112,429]

theorem envBound4889 : H12AffineFastState.Bounded env4889 := by
  intro p hp
  have h : env4889.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4880_4889 : H12AffineEnvironment.transform 9 305 env4880 = env4889 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 305 env4880 == env4889) = true)

theorem identity4889 : scanCanonicalize (H12AffineFastState.compose env4889 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 110) := by decide +kernel

theorem selectedBound4889 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4890 : List Nat := [2,4,8,16,32,64,128,110,194,95,0,32,98,112,75,170,112,74,94,75,33,106,64,193,235,91,75,58,107,0,53,75,36,1,112,195]

theorem envBound4890 : H12AffineFastState.Bounded env4890 := by
  intro p hp
  have h : env4890.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4889_4890 : H12AffineEnvironment.transform 7 110 env4889 = env4890 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 110 env4889 == env4890) = true)

def env4891 : List Nat := [2,4,8,16,32,64,72,110,10,95,0,32,98,112,75,98,112,74,94,75,33,106,64,9,35,91,75,58,107,0,53,75,36,1,112,11]

theorem envBound4891 : H12AffineFastState.Bounded env4891 := by
  intro p hp
  have h : env4891.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4890_4891 : H12AffineEnvironment.transform 6 72 env4890 = env4891 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 72 env4890 == env4891) = true)

end H12GlobalChart2
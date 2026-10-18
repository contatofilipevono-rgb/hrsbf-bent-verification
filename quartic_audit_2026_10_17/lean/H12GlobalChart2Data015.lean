import H12GlobalChart2Data014

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem envTrans3645_3646 : H12AffineEnvironment.transform 8 81 env3645 = env3646 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 81 env3645 == env3646) = true)

theorem identity3646 : scanCanonicalize (H12AffineFastState.compose env3646 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 65544) := by decide +kernel

theorem selectedBound3646 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3647 : List Nat := [2,4,8,16,32,64,88,37,81,1024,0,1076,40,1125,0,65536,1124,1,66674,0,1076,33,65,65568,121,16,1,1124,1077,1,1056,65544,37,65545,1125,80]

theorem envBound3647 : H12AffineFastState.Bounded env3647 := by
  intro p hp
  have h : env3647.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3646_3647 : H12AffineEnvironment.transform 31 65544 env3646 = env3647 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65544 env3646 == env3647) = true)

theorem identity3647 : scanCanonicalize (H12AffineFastState.compose env3647 (packedSelected [4] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound3647 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env3648 : List Nat := [2,4,8,0,32,64,72,37,65,1024,0,1060,40,1125,0,65536,1124,1,66658,0,1060,33,65,65568,105,0,1,1124,1061,1,1056,65544,37,65545,1125,64]

theorem envBound3648 : H12AffineFastState.Bounded env3648 := by
  intro p hp
  have h : env3648.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3647_3648 : H12AffineEnvironment.transform 3 0 env3647 = env3648 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env3647 == env3648) = true)

def env3649 : List Nat := [2,4,8,0,32,64,72,37,65,1024,0,1060,40,1125,0,8,1124,1,1130,0,1060,33,65,40,105,0,1,1124,1061,1,1056,0,37,1,1125,64]

theorem envBound3649 : H12AffineFastState.Bounded env3649 := by
  intro p hp
  have h : env3649.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3648_3649 : H12AffineEnvironment.transform 15 8 env3648 = env3649 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8 env3648 == env3649) = true)

theorem identity3649 : scanCanonicalize (H12AffineFastState.compose env3649 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 42) := by decide +kernel

theorem selectedBound3649 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3650 : List Nat := [2,4,8,0,32,42,34,37,43,1024,0,1060,40,1039,0,8,1038,1,1024,0,1060,33,43,40,3,0,1,1038,1061,1,1056,0,37,1,1039,42]

theorem envBound3650 : H12AffineFastState.Bounded env3650 := by
  intro p hp
  have h : env3650.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3649_3650 : H12AffineEnvironment.transform 5 42 env3649 = env3650 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 42 env3649 == env3650) = true)

theorem identity3650 : scanCanonicalize (H12AffineFastState.compose env3650 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound3650 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3651 : List Nat := [2,4,8,0,1,11,3,4,10,1024,0,1029,9,1039,0,8,1038,1,1024,0,1029,0,10,9,3,0,1,1038,1028,1,1025,0,4,1,1039,11]

theorem envBound3651 : H12AffineFastState.Bounded env3651 := by
  intro p hp
  have h : env3651.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3650_3651 : H12AffineEnvironment.transform 4 1 env3650 = env3651 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env3650 == env3651) = true)

def leafEnv3651 : List Nat := [2,4,8,0,1,11,3,4,10,1024,0,1029,9,1039,0,8,1038,1,1024,0,1029,0,10,9,1025,3,1,0,1,1038,1028,1,1025,0,4,1,4,2,1039,11,0,1028,1]

def active3651 : List Nat := [0,1,2,9]

def tree3651 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3651 : H12WitnessSearch.Good tree3651 := H12GlobalWitnessIndex.good

theorem leafIdentity3651 : H12AffineFastState.composeSystem env3651 rootObs = leafEnv3651 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3651 rootObs == leafEnv3651) = true)

theorem terminalChecked3651 : H12PackedTerminal.terminalCheckFast leafEnv3651 active3651 tree3651 = true := by decide +kernel

def env3652 : List Nat := [2,4,8,0,32,64,72,37,65,1024,0,1060,40,1125,0,9,1124,1,1131,0,1060,33,65,41,105,0,1,1124,1061,1,1056,1,37,0,1125,64]

theorem envBound3652 : H12AffineFastState.Bounded env3652 := by
  intro p hp
  have h : env3652.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3648_3652 : H12AffineEnvironment.transform 15 9 env3648 = env3652 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 9 env3648 == env3652) = true)

def env3653 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,17033,262144,524288,32768,4096,8201,17665,116429,8329,5377,276116,16385,17112,50925,17101,4294967296,256,4295602751,17032,513]

theorem envBound3653 : H12AffineFastState.Bounded env3653 := by
  intro p hp
  have h : env3653.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3610_3653 : H12AffineEnvironment.transform 16 17033 env3610 = env3653 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 17033 env3610 == env3653) = true)

theorem identity3653 : scanCanonicalize (H12AffineFastState.compose env3653 (packedSelected [16,18,32] rootPS)) = affineNative (2^(14+1) ^^^ 28792) := by decide +kernel

theorem selectedBound3653 : packedSelected [16,18,32] rootPS < 2^1333 := by decide +kernel

def env3654 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,28792,65536,17033,262144,524288,28792,4096,8201,17665,79541,8329,5377,276116,16385,17112,13973,17101,4294967296,256,4295574087,17032,513]

theorem envBound3654 : H12AffineFastState.Bounded env3654 := by
  intro p hp
  have h : env3654.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3653_3654 : H12AffineEnvironment.transform 14 28792 env3653 = env3654 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 28792 env3653 == env3654) = true)

theorem identity3654 : scanCanonicalize (H12AffineFastState.compose env3654 (packedSelected [16,23] rootPS)) = affineNative (2^(17+1) ^^^ 0) := by decide +kernel

theorem selectedBound3654 : packedSelected [16,23] rootPS < 2^1333 := by decide +kernel

def env3655 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,28792,65536,17033,0,524288,28792,4096,8201,17665,79541,8329,5377,13972,16385,17112,13973,17101,4294967296,256,4295574087,17032,513]

theorem envBound3655 : H12AffineFastState.Bounded env3655 := by
  intro p hp
  have h : env3655.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3654_3655 : H12AffineEnvironment.transform 17 0 env3654 = env3655 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env3654 == env3655) = true)

def env3656 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,16384,25960,65536,17033,0,524288,25960,1296,8201,17665,74661,8329,17,9092,16385,17112,9093,17101,4294967296,256,4295574087,17032,513]

theorem envBound3656 : H12AffineFastState.Bounded env3656 := by
  intro p hp
  have h : env3656.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3655_3656 : H12AffineEnvironment.transform 11 1296 env3655 = env3656 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env3655 == env3656) = true)

def env3657 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,16384,25961,65536,17033,0,524288,25961,1297,8201,17665,74660,8329,16,9093,16385,17112,9092,17101,4294967296,256,4295574087,17032,513]

theorem envBound3657 : H12AffineFastState.Bounded env3657 := by
  intro p hp
  have h : env3657.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3655_3657 : H12AffineEnvironment.transform 11 1297 env3655 = env3657 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env3655 == env3657) = true)

theorem identity3657 : scanCanonicalize (H12AffineFastState.compose env3657 (packedSelected [0,2,4,5,6,8,10,12,16,17] rootPS)) = affineNative (2^(18+1) ^^^ 75174) := by decide +kernel

theorem selectedBound3657 : packedSelected [0,2,4,5,6,8,10,12,16,17] rootPS < 2^1333 := by decide +kernel

def env3658 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,16384,25961,65536,17033,0,75174,25961,1297,8201,17665,74660,8329,16,9093,16385,17112,9092,17101,4294967296,256,4294993889,17032,513]

theorem envBound3658 : H12AffineFastState.Bounded env3658 := by
  intro p hp
  have h : env3658.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3657_3658 : H12AffineEnvironment.transform 18 75174 env3657 = env3658 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 75174 env3657 == env3658) = true)

theorem identity3658 : scanCanonicalize (H12AffineFastState.compose env3658 (packedSelected [0,1,3,4,7,9,10,13,15] rootPS)) = affineNative (2^(15+1) ^^^ 26222) := by decide +kernel

theorem selectedBound3658 : packedSelected [0,1,3,4,7,9,10,13,15] rootPS < 2^1333 := by decide +kernel

def env3659 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,16384,25961,26222,17033,0,17352,25961,1297,8201,17665,17866,8329,16,9093,16385,17112,9092,17101,4294967296,256,4294993889,17032,513]

theorem envBound3659 : H12AffineFastState.Bounded env3659 := by
  intro p hp
  have h : env3659.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3658_3659 : H12AffineEnvironment.transform 15 26222 env3658 = env3659 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 26222 env3658 == env3659) = true)

theorem identity3659 : scanCanonicalize (H12AffineFastState.compose env3659 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(13+1) ^^^ 1992) := by decide +kernel

theorem selectedBound3659 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env3660 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,1992,8865,8614,1345,0,1024,8865,1297,8201,713,514,8329,16,9093,1993,1296,9092,1285,4294967296,256,4294975529,1344,513]

theorem envBound3660 : H12AffineFastState.Bounded env3660 := by
  intro p hp
  have h : env3660.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3659_3660 : H12AffineEnvironment.transform 13 1992 env3659 = env3660 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1992 env3659 == env3660) = true)

theorem identity3660 : scanCanonicalize (H12AffineFastState.compose env3660 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound3660 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env3661 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1297,8192,1345,8232,8614,1345,0,1024,8232,1297,8201,64,139,8329,16,8460,1344,1296,8461,1285,4294967296,256,4294975529,1344,136]

theorem envBound3661 : H12AffineFastState.Bounded env3661 := by
  intro p hp
  have h : env3661.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3660_3661 : H12AffineEnvironment.transform 8 137 env3660 = env3661 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env3660 == env3661) = true)

theorem identity3661 : scanCanonicalize (H12AffineFastState.compose env3661 (packedSelected [2,4] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound3661 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env3662 : List Nat := [2,4,8,16,32,17,128,256,137,1024,0,1297,8192,1296,8232,8614,1296,0,1024,8232,1297,8201,17,139,8329,16,8460,1297,1296,8461,1285,4294967296,256,4294975529,1297,136]

theorem envBound3662 : H12AffineFastState.Bounded env3662 := by
  intro p hp
  have h : env3662.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3661_3662 : H12AffineEnvironment.transform 5 17 env3661 = env3662 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env3661 == env3662) = true)

theorem identity3662 : scanCanonicalize (H12AffineFastState.compose env3662 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 152) := by decide +kernel

theorem selectedBound3662 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3663 : List Nat := [2,4,8,16,32,17,128,256,137,1024,0,1297,8192,1296,8232,8614,1296,0,1024,8232,1297,8201,17,139,8329,16,8460,1297,1296,8461,1285,152,256,8369,1297,136]

theorem envBound3663 : H12AffineFastState.Bounded env3663 := by
  intro p hp
  have h : env3663.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3662_3663 : H12AffineEnvironment.transform 31 152 env3662 = env3663 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 152 env3662 == env3663) = true)

theorem identity3663 : scanCanonicalize (H12AffineFastState.compose env3663 (packedSelected [5] rootPS)) = affineNative (2^(12+1) ^^^ 161) := by decide +kernel

theorem selectedBound3663 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env3664 : List Nat := [2,4,8,16,32,17,128,256,137,1024,0,1297,161,1296,137,263,1296,0,1024,137,1297,168,17,139,40,16,429,1297,1296,428,1285,152,256,16,1297,136]

theorem envBound3664 : H12AffineFastState.Bounded env3664 := by
  intro p hp
  have h : env3664.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3663_3664 : H12AffineEnvironment.transform 12 161 env3663 = env3664 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 161 env3663 == env3664) = true)

theorem identity3664 : scanCanonicalize (H12AffineFastState.compose env3664 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 150) := by decide +kernel

theorem selectedBound3664 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3665 : List Nat := [2,4,8,16,32,17,128,150,137,1024,0,1159,161,1158,137,145,1158,0,1024,137,1159,168,17,139,40,16,59,1159,1158,58,1171,152,150,16,1159,136]

theorem envBound3665 : H12AffineFastState.Bounded env3665 := by
  intro p hp
  have h : env3665.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3664_3665 : H12AffineEnvironment.transform 7 150 env3664 = env3665 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 150 env3664 == env3665) = true)

def env3666 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,8201,17665,230468,8329,5376,422940,16384,131153,1073741824,131140,4294967296,256,4295749815,131073,513]

theorem envBound3666 : H12AffineFastState.Bounded env3666 := by
  intro p hp
  have h : env3666.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3608_3666 : H12AffineEnvironment.transform 20 4097 env3608 = env3666 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env3608 == env3666) = true)

theorem identity3666 : scanCanonicalize (H12AffineFastState.compose env3666 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 54189) := by decide +kernel

theorem selectedBound3666 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3667 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,8201,17665,230468,8329,5376,422940,16384,131153,54189,131140,4294967296,256,4295749815,131073,513]

theorem envBound3667 : H12AffineFastState.Bounded env3667 := by
  intro p hp
  have h : env3667.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3666_3667 : H12AffineEnvironment.transform 29 54189 env3666 = env3667 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 54189 env3666 == env3667) = true)

theorem identity3667 : scanCanonicalize (H12AffineFastState.compose env3667 (packedSelected [0,4,6,7,16,20,22,25] rootPS)) = affineNative (2^(18+1) ^^^ 21585) := by decide +kernel

theorem selectedBound3667 : packedSelected [0,4,6,7,16,20,22,25] rootPS < 2^1333 := by decide +kernel

def env3668 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,21585,32768,4097,8201,17665,230468,8329,5376,422940,16384,131153,54189,131140,4294967296,256,4295206118,131073,513]

theorem envBound3668 : H12AffineFastState.Bounded env3668 := by
  intro p hp
  have h : env3668.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3667_3668 : H12AffineEnvironment.transform 18 21585 env3667 = env3668 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 21585 env3667 == env3668) = true)

theorem identity3668 : scanCanonicalize (H12AffineFastState.compose env3668 (packedSelected [4,9,16] rootPS)) = affineNative (2^(15+1) ^^^ 29486) := by decide +kernel

theorem selectedBound3668 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env3669 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,29486,131072,262144,21585,32768,4097,8201,17665,194410,8329,5376,422940,16384,131153,54189,131140,4294967296,256,4295153608,131073,513]

theorem envBound3669 : H12AffineFastState.Bounded env3669 := by
  intro p hp
  have h : env3669.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3668_3669 : H12AffineEnvironment.transform 15 29486 env3668 = env3669 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 29486 env3668 == env3669) = true)

theorem identity3669 : scanCanonicalize (H12AffineFastState.compose env3669 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 4176) := by decide +kernel

theorem selectedBound3669 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env3670 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,9086,131072,262144,1025,32768,4097,8201,5457,173882,8329,5376,402508,4176,131153,33789,131140,4294967296,256,4295133080,131073,513]

theorem envBound3670 : H12AffineFastState.Bounded env3670 := by
  intro p hp
  have h : env3670.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3669_3670 : H12AffineEnvironment.transform 13 4176 env3669 = env3670 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env3669 == env3670) = true)

theorem identity3670 : scanCanonicalize (H12AffineFastState.compose env3670 (packedSelected [13,21] rootPS)) = affineNative (2^(14+1) ^^^ 8540) := by decide +kernel

theorem selectedBound3670 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env3671 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,8540,9086,131072,262144,1025,8540,4097,8201,5457,132710,8329,5376,402508,4176,131153,8865,131140,4294967296,256,4295108292,131073,513]

theorem envBound3671 : H12AffineFastState.Bounded env3671 := by
  intro p hp
  have h : env3671.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3670_3671 : H12AffineEnvironment.transform 14 8540 env3670 = env3671 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8540 env3670 == env3671) = true)

def env3672 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,8200,17665,230468,8329,2098433,2515996,2117633,131153,1073741824,131140,4294967296,256,4297842871,131073,513]

theorem envBound3672 : H12AffineFastState.Bounded env3672 := by
  intro p hp
  have h : env3672.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3607_3672 : H12AffineEnvironment.transform 10 1 env3607 = env3672 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env3607 == env3672) = true)

def env3673 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,8200,17665,230468,8329,5377,422940,16385,131153,1073741824,131140,4294967296,256,4295749815,131073,513]

theorem envBound3673 : H12AffineFastState.Bounded env3673 := by
  intro p hp
  have h : env3673.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3672_3673 : H12AffineEnvironment.transform 20 4096 env3672 = env3673 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3672 == env3673) = true)

theorem identity3673 : scanCanonicalize (H12AffineFastState.compose env3673 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 276116) := by decide +kernel

theorem selectedBound3673 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3674 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,8200,17665,230468,8329,5377,422940,16385,131153,276116,131140,4294967296,256,4295749815,131073,513]

theorem envBound3674 : H12AffineFastState.Bounded env3674 := by
  intro p hp
  have h : env3674.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3673_3674 : H12AffineEnvironment.transform 29 276116 env3673 = env3674 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 276116 env3673 == env3674) = true)

def env3675 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,176880,524288,32768,4096,8200,17665,230468,8329,5377,50924,16385,131153,164964,131140,4294967296,256,4295749815,131073,513]

theorem envBound3675 : H12AffineFastState.Bounded env3675 := by
  intro p hp
  have h : env3675.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3674_3675 : H12AffineEnvironment.transform 17 176880 env3674 = env3675 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 176880 env3674 == env3675) = true)

theorem identity3675 : scanCanonicalize (H12AffineFastState.compose env3675 (packedSelected [16,18,32] rootPS)) = affineNative (2^(14+1) ^^^ 28792) := by decide +kernel

theorem selectedBound3675 : packedSelected [16,18,32] rootPS < 2^1333 := by decide +kernel

def env3676 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,28792,65536,131072,148104,524288,28792,4096,8200,17665,226364,8329,5377,13972,16385,131153,160796,131140,4294967296,256,4295688399,131073,513]

theorem envBound3676 : H12AffineFastState.Bounded env3676 := by
  intro p hp
  have h : env3676.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3675_3676 : H12AffineEnvironment.transform 14 28792 env3675 = env3676 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 28792 env3675 == env3676) = true)

theorem identity3676 : scanCanonicalize (H12AffineFastState.compose env3676 (packedSelected [16,23] rootPS)) = affineNative (2^(16+1) ^^^ 17033) := by decide +kernel

theorem selectedBound3676 : packedSelected [16,23] rootPS < 2^1333 := by decide +kernel

def env3677 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,28792,65536,17033,1,524288,28792,4096,8200,17665,79541,8329,5377,13972,16385,17112,13973,17101,4294967296,256,4295574086,17032,513]

theorem envBound3677 : H12AffineFastState.Bounded env3677 := by
  intro p hp
  have h : env3677.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3676_3677 : H12AffineEnvironment.transform 16 17033 env3676 = env3677 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 17033 env3676 == env3677) = true)

def env3678 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,25960,65536,17033,1,524288,25960,1296,8200,17665,74661,8329,17,9092,16385,17112,9093,17101,4294967296,256,4295574086,17032,513]

theorem envBound3678 : H12AffineFastState.Bounded env3678 := by
  intro p hp
  have h : env3678.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3677_3678 : H12AffineEnvironment.transform 11 1296 env3677 = env3678 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env3677 == env3678) = true)

def env3679 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,25961,65536,17033,1,524288,25961,1297,8200,17665,74660,8329,16,9093,16385,17112,9092,17101,4294967296,256,4295574086,17032,513]

theorem envBound3679 : H12AffineFastState.Bounded env3679 := by
  intro p hp
  have h : env3679.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3677_3679 : H12AffineEnvironment.transform 11 1297 env3677 = env3679 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env3677 == env3679) = true)

theorem identity3679 : scanCanonicalize (H12AffineFastState.compose env3679 (packedSelected [0,2,4,5,6,8,10,12,16,17] rootPS)) = affineNative (2^(18+1) ^^^ 75174) := by decide +kernel

theorem selectedBound3679 : packedSelected [0,2,4,5,6,8,10,12,16,17] rootPS < 2^1333 := by decide +kernel

def env3680 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,25961,65536,17033,1,75174,25961,1297,8200,17665,74660,8329,16,9093,16385,17112,9092,17101,4294967296,256,4294993888,17032,513]

theorem envBound3680 : H12AffineFastState.Bounded env3680 := by
  intro p hp
  have h : env3680.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3679_3680 : H12AffineEnvironment.transform 18 75174 env3679 = env3680 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 75174 env3679 == env3680) = true)

theorem identity3680 : scanCanonicalize (H12AffineFastState.compose env3680 (packedSelected [0,1,3,4,7,9,10,13,15] rootPS)) = affineNative (2^(15+1) ^^^ 26222) := by decide +kernel

theorem selectedBound3680 : packedSelected [0,1,3,4,7,9,10,13,15] rootPS < 2^1333 := by decide +kernel

def env3681 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,25961,26222,17033,1,17352,25961,1297,8200,17665,17866,8329,16,9093,16385,17112,9092,17101,4294967296,256,4294993888,17032,513]

theorem envBound3681 : H12AffineFastState.Bounded env3681 := by
  intro p hp
  have h : env3681.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3680_3681 : H12AffineEnvironment.transform 15 26222 env3680 = env3681 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 26222 env3680 == env3681) = true)

theorem identity3681 : scanCanonicalize (H12AffineFastState.compose env3681 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(13+1) ^^^ 1992) := by decide +kernel

theorem selectedBound3681 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env3682 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,1992,8865,8614,1345,1,1024,8865,1297,8200,713,514,8329,16,9093,1993,1296,9092,1285,4294967296,256,4294975528,1344,513]

theorem envBound3682 : H12AffineFastState.Bounded env3682 := by
  intro p hp
  have h : env3682.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3681_3682 : H12AffineEnvironment.transform 13 1992 env3681 = env3682 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1992 env3681 == env3682) = true)

theorem identity3682 : scanCanonicalize (H12AffineFastState.compose env3682 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound3682 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env3683 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1297,8192,1345,8232,8614,1345,1,1024,8232,1297,8200,64,139,8329,16,8460,1344,1296,8461,1285,4294967296,256,4294975528,1344,136]

theorem envBound3683 : H12AffineFastState.Bounded env3683 := by
  intro p hp
  have h : env3683.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3682_3683 : H12AffineEnvironment.transform 8 137 env3682 = env3683 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env3682 == env3683) = true)

theorem identity3683 : scanCanonicalize (H12AffineFastState.compose env3683 (packedSelected [2,4] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound3683 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env3684 : List Nat := [2,4,8,16,32,17,128,256,137,1024,1,1297,8192,1296,8232,8614,1296,1,1024,8232,1297,8200,17,139,8329,16,8460,1297,1296,8461,1285,4294967296,256,4294975528,1297,136]

theorem envBound3684 : H12AffineFastState.Bounded env3684 := by
  intro p hp
  have h : env3684.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3683_3684 : H12AffineEnvironment.transform 5 17 env3683 = env3684 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env3683 == env3684) = true)

theorem identity3684 : scanCanonicalize (H12AffineFastState.compose env3684 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 152) := by decide +kernel

theorem selectedBound3684 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3685 : List Nat := [2,4,8,16,32,17,128,256,137,1024,1,1297,8192,1296,8232,8614,1296,1,1024,8232,1297,8200,17,139,8329,16,8460,1297,1296,8461,1285,152,256,8368,1297,136]

theorem envBound3685 : H12AffineFastState.Bounded env3685 := by
  intro p hp
  have h : env3685.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3684_3685 : H12AffineEnvironment.transform 31 152 env3684 = env3685 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 152 env3684 == env3685) = true)

theorem identity3685 : scanCanonicalize (H12AffineFastState.compose env3685 (packedSelected [5] rootPS)) = affineNative (2^(12+1) ^^^ 160) := by decide +kernel

theorem selectedBound3685 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env3686 : List Nat := [2,4,8,16,32,17,128,256,137,1024,1,1297,160,1296,136,262,1296,1,1024,136,1297,168,17,139,41,16,428,1297,1296,429,1285,152,256,16,1297,136]

theorem envBound3686 : H12AffineFastState.Bounded env3686 := by
  intro p hp
  have h : env3686.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3685_3686 : H12AffineEnvironment.transform 12 160 env3685 = env3686 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 160 env3685 == env3686) = true)

theorem identity3686 : scanCanonicalize (H12AffineFastState.compose env3686 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 150) := by decide +kernel

theorem selectedBound3686 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3687 : List Nat := [2,4,8,16,32,17,128,150,137,1024,1,1159,160,1158,136,144,1158,1,1024,136,1159,168,17,139,41,16,58,1159,1158,59,1171,152,150,16,1159,136]

theorem envBound3687 : H12AffineFastState.Bounded env3687 := by
  intro p hp
  have h : env3687.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3686_3687 : H12AffineEnvironment.transform 7 150 env3686 = env3687 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 150 env3686 == env3687) = true)

def env3688 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,176881,524288,32768,4096,8200,17665,230468,8329,5377,50925,16385,131153,164965,131140,4294967296,256,4295749815,131073,513]

theorem envBound3688 : H12AffineFastState.Bounded env3688 := by
  intro p hp
  have h : env3688.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3674_3688 : H12AffineEnvironment.transform 17 176881 env3674 = env3688 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 176881 env3674 == env3688) = true)

theorem identity3688 : scanCanonicalize (H12AffineFastState.compose env3688 (packedSelected [16,18,32] rootPS)) = affineNative (2^(16+1) ^^^ 45809) := by decide +kernel

theorem selectedBound3688 : packedSelected [16,18,32] rootPS < 2^1333 := by decide +kernel

def env3689 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,45809,0,524288,32768,4096,8200,17665,79541,8329,5377,50925,16385,45728,13972,45749,4294967296,256,4295574086,45808,513]

theorem envBound3689 : H12AffineFastState.Bounded env3689 := by
  intro p hp
  have h : env3689.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3688_3689 : H12AffineEnvironment.transform 16 45809 env3688 = env3689 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 45809 env3688 == env3689) = true)

theorem identity3689 : scanCanonicalize (H12AffineFastState.compose env3689 (packedSelected [18,20] rootPS)) = affineNative (2^(14+1) ^^^ 28793) := by decide +kernel

theorem selectedBound3689 : packedSelected [18,20] rootPS < 2^1333 := by decide +kernel

def env3690 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,28793,65536,17032,0,524288,28793,4096,8200,17665,79541,8329,5377,13972,16385,17113,13972,17100,4294967296,256,4295574086,17033,513]

theorem envBound3690 : H12AffineFastState.Bounded env3690 := by
  intro p hp
  have h : env3690.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3689_3690 : H12AffineEnvironment.transform 14 28793 env3689 = env3690 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 28793 env3689 == env3690) = true)

def env3691 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,25961,65536,17032,0,524288,25961,1296,8200,17665,74661,8329,17,9092,16385,17113,9092,17100,4294967296,256,4295574086,17033,513]

theorem envBound3691 : H12AffineFastState.Bounded env3691 := by
  intro p hp
  have h : env3691.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3690_3691 : H12AffineEnvironment.transform 11 1296 env3690 = env3691 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env3690 == env3691) = true)

theorem identity3691 : scanCanonicalize (H12AffineFastState.compose env3691 (packedSelected [0,2,4,5,6,8,10,12,16,17] rootPS)) = affineNative (2^(18+1) ^^^ 82411) := by decide +kernel

theorem selectedBound3691 : packedSelected [0,2,4,5,6,8,10,12,16,17] rootPS < 2^1333 := by decide +kernel

def env3692 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,25961,65536,17032,0,82411,25961,1296,8200,17665,74661,8329,17,9092,16385,17113,9092,17100,4294967296,256,4294968237,17033,513]

theorem envBound3692 : H12AffineFastState.Bounded env3692 := by
  intro p hp
  have h : env3692.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3691_3692 : H12AffineEnvironment.transform 18 82411 env3691 = env3692 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 82411 env3691 == env3692) = true)

theorem identity3692 : scanCanonicalize (H12AffineFastState.compose env3692 (packedSelected [0,2,3,4,5,6,10,12] rootPS)) = affineNative (2^(15+1) ^^^ 25830) := by decide +kernel

theorem selectedBound3692 : packedSelected [0,2,3,4,5,6,10,12] rootPS < 2^1333 := by decide +kernel

def env3693 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,16384,25961,25830,17032,0,9485,25961,1296,8200,17665,18243,8329,17,9092,16385,17113,9092,17100,4294967296,256,4294968237,17033,513]

theorem envBound3693 : H12AffineFastState.Bounded env3693 := by
  intro p hp
  have h : env3693.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3692_3693 : H12AffineEnvironment.transform 15 25830 env3692 = env3693 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 25830 env3692 == env3693) = true)

theorem identity3693 : scanCanonicalize (H12AffineFastState.compose env3693 (packedSelected [0,1,2,5,6,9,13] rootPS)) = affineNative (2^(12+1) ^^^ 901) := by decide +kernel

theorem selectedBound3693 : packedSelected [0,1,2,5,6,9,13] rootPS < 2^1333 := by decide +kernel

def env3694 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,901,16384,18156,18275,17032,0,1672,18156,1296,909,17665,18243,780,17,1,16385,17113,1,17100,4294967296,256,4294968237,17033,513]

theorem envBound3694 : H12AffineFastState.Bounded env3694 := by
  intro p hp
  have h : env3694.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3693_3694 : H12AffineEnvironment.transform 12 901 env3693 = env3694 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 901 env3693 == env3694) = true)

theorem identity3694 : scanCanonicalize (H12AffineFastState.compose env3694 (packedSelected [0,7] rootPS)) = affineNative (2^(13+1) ^^^ 1992) := by decide +kernel

theorem selectedBound3694 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env3695 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,901,1992,292,171,1344,0,1672,292,1296,909,713,139,780,17,1,1993,1297,1,1284,4294967296,256,4294968237,1345,513]

theorem envBound3695 : H12AffineFastState.Bounded env3695 := by
  intro p hp
  have h : env3695.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3694_3695 : H12AffineEnvironment.transform 13 1992 env3694 = env3695 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1992 env3694 == env3695) = true)

theorem identity3695 : scanCanonicalize (H12AffineFastState.compose env3695 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 157) := by decide +kernel

theorem selectedBound3695 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env3696 : List Nat := [2,4,8,16,32,64,128,157,512,1024,1,1165,536,1621,185,171,1245,0,1672,185,1165,528,713,139,657,17,1,1620,1164,1,1177,4294967296,157,4294967856,1244,513]

theorem envBound3696 : H12AffineFastState.Bounded env3696 := by
  intro p hp
  have h : env3696.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3695_3696 : H12AffineEnvironment.transform 7 157 env3695 = env3696 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 157 env3695 == env3696) = true)

theorem identity3696 : scanCanonicalize (H12AffineFastState.compose env3696 (packedSelected [1,3,5] rootPS)) = affineNative (2^(8+1) ^^^ 122) := by decide +kernel

theorem selectedBound3696 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env3697 : List Nat := [2,4,8,16,32,64,128,157,122,1024,1,1165,98,1071,185,171,1245,0,1266,185,1165,106,179,139,235,17,1,1070,1164,1,1177,4294967296,157,4294967370,1244,123]

theorem envBound3697 : H12AffineFastState.Bounded env3697 := by
  intro p hp
  have h : env3697.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3696_3697 : H12AffineEnvironment.transform 8 122 env3696 = env3697 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 122 env3696 == env3697) = true)

theorem identity3697 : scanCanonicalize (H12AffineFastState.compose env3697 (packedSelected [1,3,8] rootPS)) = affineNative (2^(6+1) ^^^ 56) := by decide +kernel

theorem selectedBound3697 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env3698 : List Nat := [2,4,8,16,32,64,56,37,122,1024,1,1077,98,1071,1,19,1125,0,1098,1,1077,106,11,51,83,17,1,1070,1076,1,1057,4294967296,37,4294967370,1124,123]

theorem envBound3698 : H12AffineFastState.Bounded env3698 := by
  intro p hp
  have h : env3698.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3697_3698 : H12AffineEnvironment.transform 6 56 env3697 = env3698 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 56 env3697 == env3698) = true)

theorem identity3698 : scanCanonicalize (H12AffineFastState.compose env3698 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound3698 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3699 : List Nat := [2,4,8,16,32,11,56,37,49,1024,1,1077,41,1071,1,19,1070,0,1025,1,1077,33,11,51,24,17,1,1070,1076,1,1057,4294967296,37,4294967297,1071,48]

theorem envBound3699 : H12AffineFastState.Bounded env3699 := by
  intro p hp
  have h : env3699.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3698_3699 : H12AffineEnvironment.transform 5 11 env3698 = env3699 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env3698 == env3699) = true)

theorem identity3699 : scanCanonicalize (H12AffineFastState.compose env3699 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 42) := by decide +kernel

theorem selectedBound3699 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3700 : List Nat := [2,4,8,16,32,11,56,37,49,1024,1,1077,41,1071,1,19,1070,0,1025,1,1077,33,11,51,24,17,1,1070,1076,1,1057,42,37,43,1071,48]

theorem envBound3700 : H12AffineFastState.Bounded env3700 := by
  intro p hp
  have h : env3700.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3699_3700 : H12AffineEnvironment.transform 31 42 env3699 = env3700 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 42 env3699 == env3700) = true)

theorem identity3700 : scanCanonicalize (H12AffineFastState.compose env3700 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound3700 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3701 : List Nat := [2,4,2,16,32,1,50,37,49,1024,1,1077,35,1061,1,19,1060,0,1025,1,1077,33,1,51,18,17,1,1060,1076,1,1057,32,37,33,1061,48]

theorem envBound3701 : H12AffineFastState.Bounded env3701 := by
  intro p hp
  have h : env3701.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3700_3701 : H12AffineEnvironment.transform 2 2 env3700 = env3701 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env3700 == env3701) = true)

def env3702 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,16384,25960,65536,17032,0,524288,25960,1297,8200,17665,74660,8329,16,9093,16385,17113,9093,17100,4294967296,256,4295574086,17033,513]

theorem envBound3702 : H12AffineFastState.Bounded env3702 := by
  intro p hp
  have h : env3702.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3690_3702 : H12AffineEnvironment.transform 11 1297 env3690 = env3702 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env3690 == env3702) = true)

theorem identity3702 : scanCanonicalize (H12AffineFastState.compose env3702 (packedSelected [0,2,4,5,6,8,10,12,16,17] rootPS)) = affineNative (2^(13+1) ^^^ 9292) := by decide +kernel

theorem selectedBound3702 : packedSelected [0,2,4,5,6,8,10,12,16,17] rootPS < 2^1333 := by decide +kernel

def env3703 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,9292,292,65536,9924,0,524288,292,1297,8200,8525,74660,8329,16,9093,9293,9877,9093,9856,4294967296,256,4295566858,9925,513]

theorem envBound3703 : H12AffineFastState.Bounded env3703 := by
  intro p hp
  have h : env3703.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3702_3703 : H12AffineEnvironment.transform 13 9292 env3702 = env3703 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 9292 env3702 == env3703) = true)

theorem identity3703 : scanCanonicalize (H12AffineFastState.compose env3703 (packedSelected [1,3,4,9,10,12,13] rootPS)) = affineNative (2^(18+1) ^^^ 67106) := by decide +kernel

theorem selectedBound3703 : packedSelected [1,3,4,9,10,12,13] rootPS < 2^1333 := by decide +kernel

def env3704 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,9292,292,65536,9924,0,67106,292,1297,8200,8525,74660,8329,16,9093,9293,9877,9093,9856,4294967296,256,4294975528,9925,513]

theorem envBound3704 : H12AffineFastState.Bounded env3704 := by
  intro p hp
  have h : env3704.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3703_3704 : H12AffineEnvironment.transform 18 67106 env3703 = env3704 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 67106 env3703 == env3704) = true)

def env3705 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,268,1344,292,65536,1992,0,67106,292,1297,260,65,66216,389,16,649,1345,1945,649,1932,4294967296,256,4294967588,1993,513]

theorem envBound3705 : H12AffineFastState.Bounded env3705 := by
  intro p hp
  have h : env3705.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3704_3705 : H12AffineEnvironment.transform 12 268 env3704 = env3705 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 268 env3704 == env3705) = true)

def env3706 : List Nat := [2,4,8,16,32,64,128,252,512,1024,1,1261,240,1212,216,65536,1588,0,67106,216,1261,248,65,66216,121,16,649,1213,1637,649,1648,4294967296,252,4294967512,1589,513]

theorem envBound3706 : H12AffineFastState.Bounded env3706 := by
  intro p hp
  have h : env3706.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3705_3706 : H12AffineEnvironment.transform 7 252 env3705 = env3706 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 252 env3705 == env3706) = true)

theorem identity3706 : scanCanonicalize (H12AffineFastState.compose env3706 (packedSelected [3,5,10] rootPS)) = affineNative (2^(15+1) ^^^ 762) := by decide +kernel

theorem selectedBound3706 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env3707 : List Nat := [2,4,8,16,32,64,128,252,512,1024,1,1261,240,1212,216,762,1588,0,1240,216,1261,248,65,82,121,16,649,1213,1637,649,1648,4294967296,252,4294967512,1589,513]

theorem envBound3707 : H12AffineFastState.Bounded env3707 := by
  intro p hp
  have h : env3707.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3706_3707 : H12AffineEnvironment.transform 15 762 env3706 = env3707 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 762 env3706 == env3707) = true)

theorem identity3707 : scanCanonicalize (H12AffineFastState.compose env3707 (packedSelected [1,3] rootPS)) = affineNative (2^(8+1) ^^^ 80) := by decide +kernel

theorem selectedBound3707 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env3708 : List Nat := [2,4,8,16,32,64,128,252,80,1024,1,1261,240,1212,216,170,1124,0,1240,216,1261,248,65,82,121,16,217,1213,1077,217,1056,4294967296,252,4294967512,1125,81]

theorem envBound3708 : H12AffineFastState.Bounded env3708 := by
  intro p hp
  have h : env3708.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3707_3708 : H12AffineEnvironment.transform 8 80 env3707 = env3708 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 80 env3707 == env3708) = true)

theorem identity3708 : scanCanonicalize (H12AffineFastState.compose env3708 (packedSelected [0,1,2] rootPS)) = affineNative (2^(6+1) ^^^ 89) := by decide +kernel

theorem selectedBound3708 : packedSelected [0,1,2] rootPS < 2^1333 := by decide +kernel

def env3709 : List Nat := [2,4,8,16,32,64,89,37,80,1024,1,1076,41,1125,1,115,1124,0,1025,1,1076,33,65,82,121,16,0,1124,1077,0,1056,4294967296,37,4294967297,1125,81]

theorem envBound3709 : H12AffineFastState.Bounded env3709 := by
  intro p hp
  have h : env3709.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3708_3709 : H12AffineEnvironment.transform 6 89 env3708 = env3709 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env3708 == env3709) = true)

theorem identity3709 : scanCanonicalize (H12AffineFastState.compose env3709 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 123) := by decide +kernel

theorem selectedBound3709 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3710 : List Nat := [2,4,8,16,32,64,89,37,80,1024,1,1076,41,1125,1,115,1124,0,1025,1,1076,33,65,82,121,16,0,1124,1077,0,1056,123,37,122,1125,81]

theorem envBound3710 : H12AffineFastState.Bounded env3710 := by
  intro p hp
  have h : env3710.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3709_3710 : H12AffineEnvironment.transform 31 123 env3709 = env3710 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 123 env3709 == env3710) = true)

theorem identity3710 : scanCanonicalize (H12AffineFastState.compose env3710 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound3710 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3711 : List Nat := [2,4,8,1,32,64,72,37,65,1024,1,1061,41,1125,1,98,1124,0,1025,1,1061,33,65,67,104,1,0,1124,1060,0,1056,106,37,107,1125,64]

theorem envBound3711 : H12AffineFastState.Bounded env3711 := by
  intro p hp
  have h : env3711.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3710_3711 : H12AffineEnvironment.transform 3 1 env3710 = env3711 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env3710 == env3711) = true)

def leafEnv3711 : List Nat := [2,4,8,1,32,64,72,37,65,1024,1,1061,41,1125,1,98,1124,0,1025,1,1061,33,65,67,1057,104,1,1,0,1124,1060,0,1056,106,37,107,4,34,1125,64,0,1060,1]

def active3711 : List Nat := [0,1,2,4,5,9]

def tree3711 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3711 : H12WitnessSearch.Good tree3711 := H12GlobalWitnessIndex.good

theorem leafIdentity3711 : H12AffineFastState.composeSystem env3711 rootObs = leafEnv3711 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3711 rootObs == leafEnv3711) = true)

theorem terminalChecked3711 : H12PackedTerminal.terminalCheckFast leafEnv3711 active3711 tree3711 = true := by decide +kernel

def env3712 : List Nat := [2,4,8,16,32,64,128,253,512,1024,1,1260,241,1213,217,65536,1589,0,67106,217,1260,249,65,66216,120,16,649,1212,1636,649,1649,4294967296,253,4294967513,1588,513]

theorem envBound3712 : H12AffineFastState.Bounded env3712 := by
  intro p hp
  have h : env3712.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3705_3712 : H12AffineEnvironment.transform 7 253 env3705 = env3712 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 253 env3705 == env3712) = true)

theorem identity3712 : scanCanonicalize (H12AffineFastState.compose env3712 (packedSelected [3,5,10] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound3712 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env3713 : List Nat := [2,4,8,16,32,64,88,37,512,1024,1,1076,41,1125,1,65536,1589,0,67106,1,1076,33,65,66160,120,16,593,1124,1636,593,1649,4294967296,37,4294967297,1588,513]

theorem envBound3713 : H12AffineFastState.Bounded env3713 := by
  intro p hp
  have h : env3713.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3712_3713 : H12AffineEnvironment.transform 6 88 env3712 = env3713 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env3712 == env3713) = true)

theorem identity3713 : scanCanonicalize (H12AffineFastState.compose env3713 (packedSelected [0,1,3,7] rootPS)) = affineNative (2^(8+1) ^^^ 81) := by decide +kernel

theorem selectedBound3713 : packedSelected [0,1,3,7] rootPS < 2^1333 := by decide +kernel

def env3714 : List Nat := [2,4,8,16,32,64,88,37,81,1024,1,1076,41,1125,1,65536,1124,0,66675,1,1076,33,65,65569,120,16,0,1124,1077,0,1056,4294967296,37,4294967297,1125,80]

theorem envBound3714 : H12AffineFastState.Bounded env3714 := by
  intro p hp
  have h : env3714.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3713_3714 : H12AffineEnvironment.transform 8 81 env3713 = env3714 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 81 env3713 == env3714) = true)

theorem identity3714 : scanCanonicalize (H12AffineFastState.compose env3714 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 123) := by decide +kernel

theorem selectedBound3714 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3715 : List Nat := [2,4,8,16,32,64,88,37,81,1024,1,1076,41,1125,1,65536,1124,0,66675,1,1076,33,65,65569,120,16,0,1124,1077,0,1056,123,37,122,1125,80]

theorem envBound3715 : H12AffineFastState.Bounded env3715 := by
  intro p hp
  have h : env3715.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3714_3715 : H12AffineEnvironment.transform 31 123 env3714 = env3715 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 123 env3714 == env3715) = true)

theorem identity3715 : scanCanonicalize (H12AffineFastState.compose env3715 (packedSelected [4] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound3715 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env3716 : List Nat := [2,4,8,0,32,64,72,37,65,1024,1,1060,41,1125,1,65536,1124,0,66659,1,1060,33,65,65569,104,0,0,1124,1061,0,1056,107,37,106,1125,64]

theorem envBound3716 : H12AffineFastState.Bounded env3716 := by
  intro p hp
  have h : env3716.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3715_3716 : H12AffineEnvironment.transform 3 0 env3715 = env3716 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env3715 == env3716) = true)

def env3717 : List Nat := [2,4,8,0,32,64,72,37,65,1024,1,1060,41,1125,1,8,1124,0,1131,1,1060,33,65,41,104,0,0,1124,1061,0,1056,107,37,106,1125,64]

theorem envBound3717 : H12AffineFastState.Bounded env3717 := by
  intro p hp
  have h : env3717.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3716_3717 : H12AffineEnvironment.transform 15 8 env3716 = env3717 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8 env3716 == env3717) = true)

def env3718 : List Nat := [2,4,8,0,32,64,72,37,65,1024,1,1060,41,1125,1,9,1124,0,1130,1,1060,33,65,40,104,0,0,1124,1061,0,1056,107,37,106,1125,64]

theorem envBound3718 : H12AffineFastState.Bounded env3718 := by
  intro p hp
  have h : env3718.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3716_3718 : H12AffineEnvironment.transform 15 9 env3716 = env3718 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 9 env3716 == env3718) = true)

theorem identity3718 : scanCanonicalize (H12AffineFastState.compose env3718 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 42) := by decide +kernel

theorem selectedBound3718 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3719 : List Nat := [2,4,8,0,32,42,34,37,43,1024,1,1060,41,1039,1,9,1038,0,1024,1,1060,33,43,40,2,0,0,1038,1061,0,1056,1,37,0,1039,42]

theorem envBound3719 : H12AffineFastState.Bounded env3719 := by
  intro p hp
  have h : env3719.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3718_3719 : H12AffineEnvironment.transform 5 42 env3718 = env3719 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 42 env3718 == env3719) = true)

theorem identity3719 : scanCanonicalize (H12AffineFastState.compose env3719 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound3719 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3720 : List Nat := [2,4,8,0,1,11,3,4,10,1024,1,1029,8,1039,1,9,1038,0,1024,1,1029,0,10,9,2,0,0,1038,1028,0,1025,1,4,0,1039,11]

theorem envBound3720 : H12AffineFastState.Bounded env3720 := by
  intro p hp
  have h : env3720.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3719_3720 : H12AffineEnvironment.transform 4 1 env3719 = env3720 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env3719 == env3720) = true)

def leafEnv3720 : List Nat := [2,4,8,0,1,11,3,4,10,1024,1,1029,8,1039,1,9,1038,0,1024,1,1029,0,10,9,1025,2,1,0,0,1038,1028,0,1025,1,4,0,4,3,1039,11,0,1028,1]

def active3720 : List Nat := [0,1,2,9]

def tree3720 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3720 : H12WitnessSearch.Good tree3720 := H12GlobalWitnessIndex.good

theorem leafIdentity3720 : H12AffineFastState.composeSystem env3720 rootObs = leafEnv3720 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3720 rootObs == leafEnv3720) = true)

theorem terminalChecked3720 : H12PackedTerminal.terminalCheckFast leafEnv3720 active3720 tree3720 = true := by decide +kernel

def env3721 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,269,1345,292,65536,1993,0,67106,292,1297,261,64,66217,388,16,648,1344,1944,648,1933,4294967296,256,4294967589,1992,513]

theorem envBound3721 : H12AffineFastState.Bounded env3721 := by
  intro p hp
  have h : env3721.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3704_3721 : H12AffineEnvironment.transform 12 269 env3704 = env3721 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 269 env3704 == env3721) = true)

theorem identity3721 : scanCanonicalize (H12AffineFastState.compose env3721 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 546) := by decide +kernel

theorem selectedBound3721 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env3722 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,269,1345,292,546,1993,0,1024,292,1297,261,64,139,388,16,648,1344,1944,648,1933,4294967296,256,4294967589,1992,513]

theorem envBound3722 : H12AffineFastState.Bounded env3722 := by
  intro p hp
  have h : env3722.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3721_3722 : H12AffineEnvironment.transform 15 546 env3721 = env3722 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 546 env3721 == env3722) = true)

theorem identity3722 : scanCanonicalize (H12AffineFastState.compose env3722 (packedSelected [0,7] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound3722 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env3723 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1297,269,1345,292,171,1344,0,1024,292,1297,261,64,139,388,16,1,1344,1297,1,1284,4294967296,256,4294967589,1345,136]

theorem envBound3723 : H12AffineFastState.Bounded env3723 := by
  intro p hp
  have h : env3723.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3722_3723 : H12AffineEnvironment.transform 8 137 env3722 = env3723 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env3722 == env3723) = true)

theorem identity3723 : scanCanonicalize (H12AffineFastState.compose env3723 (packedSelected [1,3] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound3723 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env3724 : List Nat := [2,4,8,16,32,64,128,36,137,1024,1,1077,41,1125,0,171,1124,0,1024,0,1077,33,64,139,160,16,1,1124,1077,1,1056,4294967296,36,4294967297,1125,136]

theorem envBound3724 : H12AffineFastState.Bounded env3724 := by
  intro p hp
  have h : env3724.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3723_3724 : H12AffineEnvironment.transform 7 36 env3723 = env3724 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env3723 == env3724) = true)

theorem identity3724 : scanCanonicalize (H12AffineFastState.compose env3724 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 75) := by decide +kernel

theorem selectedBound3724 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3725 : List Nat := [2,4,8,16,32,64,128,36,137,1024,1,1077,41,1125,0,171,1124,0,1024,0,1077,33,64,139,160,16,1,1124,1077,1,1056,75,36,74,1125,136]

theorem envBound3725 : H12AffineFastState.Bounded env3725 := by
  intro p hp
  have h : env3725.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3724_3725 : H12AffineEnvironment.transform 31 75 env3724 = env3725 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 75 env3724 == env3725) = true)

theorem identity3725 : scanCanonicalize (H12AffineFastState.compose env3725 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 66) := by decide +kernel

theorem selectedBound3725 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3726 : List Nat := [2,4,8,16,32,64,66,36,75,1024,1,1077,41,1125,0,105,1124,0,1024,0,1077,33,64,73,98,16,1,1124,1077,1,1056,75,36,74,1125,74]

theorem envBound3726 : H12AffineFastState.Bounded env3726 := by
  intro p hp
  have h : env3726.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3725_3726 : H12AffineEnvironment.transform 6 66 env3725 = env3726 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 66 env3725 == env3726) = true)

theorem identity3726 : scanCanonicalize (H12AffineFastState.compose env3726 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 49) := by decide +kernel

theorem selectedBound3726 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3727 : List Nat := [2,4,8,16,32,49,51,36,58,1024,1,1077,41,1044,0,24,1045,0,1024,0,1077,33,49,56,19,16,1,1045,1077,1,1056,58,36,59,1044,59]

theorem envBound3727 : H12AffineFastState.Bounded env3727 := by
  intro p hp
  have h : env3727.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3726_3727 : H12AffineEnvironment.transform 5 49 env3726 = env3727 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 49 env3726 == env3727) = true)

theorem identity3727 : scanCanonicalize (H12AffineFastState.compose env3727 (packedSelected [4] rootPS)) = affineNative (2^(4+1) ^^^ 16) := by decide +kernel

theorem selectedBound3727 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env3728 : List Nat := [2,4,8,16,16,1,3,20,10,1024,1,1029,25,1044,0,24,1045,0,1024,0,1029,17,1,8,19,16,1,1045,1029,1,1040,10,20,11,1044,11]

theorem envBound3728 : H12AffineFastState.Bounded env3728 := by
  intro p hp
  have h : env3728.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3727_3728 : H12AffineEnvironment.transform 4 16 env3727 = env3728 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env3727 == env3728) = true)

theorem identity3728 : scanCanonicalize (H12AffineFastState.compose env3728 (packedSelected [5] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound3728 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env3729 : List Nat := [2,4,8,0,0,1,3,4,10,1024,1,1029,9,1028,0,8,1029,0,1024,0,1029,1,1,8,3,0,1,1029,1029,1,1024,10,4,11,1028,11]

theorem envBound3729 : H12AffineFastState.Bounded env3729 := by
  intro p hp
  have h : env3729.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3728_3729 : H12AffineEnvironment.transform 3 0 env3728 = env3729 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env3728 == env3729) = true)

def env3730 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,8200,17665,230468,8329,5376,422941,16384,131153,1073741824,131140,4294967296,256,4295749814,131073,513]

theorem envBound3730 : H12AffineFastState.Bounded env3730 := by
  intro p hp
  have h : env3730.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3672_3730 : H12AffineEnvironment.transform 20 4097 env3672 = env3730 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env3672 == env3730) = true)

theorem identity3730 : scanCanonicalize (H12AffineFastState.compose env3730 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 271317) := by decide +kernel

theorem selectedBound3730 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3731 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,8200,17665,230468,8329,5376,422941,16384,131153,271317,131140,4294967296,256,4295749814,131073,513]

theorem envBound3731 : H12AffineFastState.Bounded env3731 := by
  intro p hp
  have h : env3731.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3730_3731 : H12AffineEnvironment.transform 29 271317 env3730 = env3731 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 271317 env3730 == env3731) = true)

theorem identity3731 : scanCanonicalize (H12AffineFastState.compose env3731 (packedSelected [0,4,6,7,16,20,22,25] rootPS)) = affineNative (2^(18+1) ^^^ 21585) := by decide +kernel

theorem selectedBound3731 : packedSelected [0,4,6,7,16,20,22,25] rootPS < 2^1333 := by decide +kernel

def env3732 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,21585,32768,4097,8200,17665,230468,8329,5376,422941,16384,131153,271317,131140,4294967296,256,4295206119,131073,513]

theorem envBound3732 : H12AffineFastState.Bounded env3732 := by
  intro p hp
  have h : env3732.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3731_3732 : H12AffineEnvironment.transform 18 21585 env3731 = env3732 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 21585 env3731 == env3732) = true)

theorem identity3732 : scanCanonicalize (H12AffineFastState.compose env3732 (packedSelected [4,9,16] rootPS)) = affineNative (2^(17+1) ^^^ 99158) := by decide +kernel

theorem selectedBound3732 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env3733 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,99158,21585,32768,4097,8200,17665,230468,8329,5376,259915,16384,131153,106627,131140,4294967296,256,4295206119,131073,513]

theorem envBound3733 : H12AffineFastState.Bounded env3733 := by
  intro p hp
  have h : env3733.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3732_3733 : H12AffineEnvironment.transform 17 99158 env3732 = env3733 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 99158 env3732 == env3733) = true)

theorem identity3733 : scanCanonicalize (H12AffineFastState.compose env3733 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 4176) := by decide +kernel

theorem selectedBound3733 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env3734 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,131072,99158,1025,32768,4097,8200,5457,230468,8329,5376,239387,4176,131153,106627,131140,4294967296,256,4295206119,131073,513]

theorem envBound3734 : H12AffineFastState.Bounded env3734 := by
  intro p hp
  have h : env3734.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3733_3734 : H12AffineEnvironment.transform 13 4176 env3733 = env3734 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env3733 == env3734) = true)

theorem identity3734 : scanCanonicalize (H12AffineFastState.compose env3734 (packedSelected [13,21] rootPS)) = affineNative (2^(14+1) ^^^ 8540) := by decide +kernel

theorem selectedBound3734 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env3735 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,8540,65536,131072,74250,1025,8540,4097,8200,5457,206104,8329,5376,198215,4176,131153,66015,131140,4294967296,256,4295165371,131073,513]

theorem envBound3735 : H12AffineFastState.Bounded env3735 := by
  intro p hp
  have h : env3735.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3734_3735 : H12AffineEnvironment.transform 14 8540 env3734 = env3735 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8540 env3734 == env3735) = true)

def env3736 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,134217728,67130624,536870912,1073741824,553878609,4294967296,537002321,4417151347,694534145,33563272]

theorem envBound3736 : H12AffineFastState.Bounded env3736 := by
  intro p hp
  have h : env3736.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2855_3736 : H12AffineEnvironment.transform 34 694534145 env2855 = env3736 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 34 694534145 env2855 == env3736) = true)

def env3737 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,134217728,67130624,157794304,1073741824,140788817,4294967296,157663569,4417151347,131073,33563272]

theorem envBound3737 : H12AffineFastState.Bounded env3737 := by
  intro p hp
  have h : env3737.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3736_3737 : H12AffineEnvironment.transform 28 157794304 env3736 = env3737 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 28 157794304 env3736 == env3737) = true)

theorem identity3737 : scanCanonicalize (H12AffineFastState.compose env3737 (packedSelected [14] rootPS)) = affineNative (2^(26+1) ^^^ 4609044) := by decide +kernel

theorem selectedBound3737 : packedSelected [14] rootPS < 2^1333 := by decide +kernel

def env3738 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,4609044,67130624,18977812,1073741824,2232389,4294967296,19109189,4417151347,131073,33563272]

theorem envBound3738 : H12AffineFastState.Bounded env3738 := by
  intro p hp
  have h : env3738.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3737_3738 : H12AffineEnvironment.transform 26 4609044 env3737 = env3738 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 4609044 env3737 == env3738) = true)

def env3739 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17665,16777216,33554432,67108864,4609044,67130624,16876564,1073741824,131141,4294967296,17007941,4417151347,131073,33563272]

theorem envBound3739 : H12AffineFastState.Bounded env3739 := by
  intro p hp
  have h : env3739.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3738_3739 : H12AffineEnvironment.transform 20 4096 env3738 = env3739 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3738 == env3739) = true)

def env3740 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,4194304,17665,16777216,33554432,67108864,4609044,67130624,16876565,1073741824,131140,4294967296,17007940,4417151347,131073,33563272]

theorem envBound3740 : H12AffineFastState.Bounded env3740 := by
  intro p hp
  have h : env3740.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3738_3740 : H12AffineEnvironment.transform 20 4097 env3738 = env3740 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env3738 == env3740) = true)

theorem identity3740 : scanCanonicalize (H12AffineFastState.compose env3740 (packedSelected [35] rootPS)) = affineNative (2^(25+1) ^^^ 17011013) := by decide +kernel

theorem selectedBound3740 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env3741 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,4194304,17665,16777216,33554432,17011013,4609044,17024069,16876565,1073741824,131140,4294967296,17007940,4333498422,131073,33563272]

theorem envBound3741 : H12AffineFastState.Bounded env3741 := by
  intro p hp
  have h : env3741.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3740_3741 : H12AffineEnvironment.transform 25 17011013 env3740 = env3741 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 17011013 env3740 == env3741) = true)

def env3742 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,4194304,5457,16777216,33554432,17011013,4588612,17011733,16876565,1073741824,131140,4294967296,17007940,4333477990,131073,33563272]

theorem envBound3742 : H12AffineFastState.Bounded env3742 := by
  intro p hp
  have h : env3742.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3741_3742 : H12AffineEnvironment.transform 13 4176 env3741 = env3742 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env3741 == env3742) = true)

def env3743 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,4194304,5457,16777216,4395008,17011013,4588612,17011733,16876565,1073741824,131140,4294967296,17007940,4295536742,131073,4403848]

theorem envBound3743 : H12AffineFastState.Bounded env3743 := by
  intro p hp
  have h : env3743.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3742_3743 : H12AffineEnvironment.transform 24 4395008 env3742 = env3743 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 4395008 env3742 == env3743) = true)

def env3744 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,524288,32768,4097,4194304,5457,16777216,4259840,16875845,4461636,16876565,16876565,1073741824,4164,4294967296,16880964,4295536742,4097,4268680]

theorem envBound3744 : H12AffineFastState.Bounded env3744 := by
  intro p hp
  have h : env3744.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3743_3744 : H12AffineEnvironment.transform 16 4096 env3743 = env3744 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env3743 == env3744) = true)

def env3745 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,524288,32768,4097,4194304,5457,98304,4259840,325,4461636,1045,1045,1073741824,4164,4294967296,5444,4295536742,4097,4268680]

theorem envBound3745 : H12AffineFastState.Bounded env3745 := by
  intro p hp
  have h : env3745.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3744_3745 : H12AffineEnvironment.transform 23 98304 env3744 = env3745 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98304 env3744 == env3745) = true)

theorem identity3745 : scanCanonicalize (H12AffineFastState.compose env3745 (packedSelected [3,5,24] rootPS)) = affineNative (2^(15+1) ^^^ 13516) := by decide +kernel

theorem selectedBound3745 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env3746 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,13516,4096,262144,524288,32768,4097,4194304,5457,46284,4207820,325,4461636,1045,1045,1073741824,4164,4294967296,5444,4295536742,4097,4200004]

theorem envBound3746 : H12AffineFastState.Bounded env3746 := by
  intro p hp
  have h : env3746.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3745_3746 : H12AffineEnvironment.transform 15 13516 env3745 = env3746 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13516 env3745 == env3746) = true)

def env3747 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,13468,4096,262144,524288,32768,4097,4194304,5377,46236,4207772,277,4461588,1045,1045,1073741824,4116,4294967296,5396,4295536694,4097,4199956]

theorem envBound3747 : H12AffineFastState.Bounded env3747 := by
  intro p hp
  have h : env3747.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3746_3747 : H12AffineEnvironment.transform 5 16 env3746 = env3747 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env3746 == env3747) = true)

theorem identity3747 : scanCanonicalize (H12AffineFastState.compose env3747 (packedSelected [3,5,8,17,21,28] rootPS)) = affineNative (2^(29+1) ^^^ 308284) := by decide +kernel

theorem selectedBound3747 : packedSelected [3,5,8,17,21,28] rootPS < 2^1333 := by decide +kernel

def env3748 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,13468,4096,262144,524288,32768,4097,4194304,5377,46236,4207772,277,4461588,1045,1045,308284,4116,4294967296,5396,4295536694,4097,4199956]

theorem envBound3748 : H12AffineFastState.Bounded env3748 := by
  intro p hp
  have h : env3748.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3747_3748 : H12AffineEnvironment.transform 29 308284 env3747 = env3748 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 308284 env3747 == env3748) = true)

theorem identity3748 : scanCanonicalize (H12AffineFastState.compose env3748 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(17+1) ^^^ 48188) := by decide +kernel

theorem selectedBound3748 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env3749 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,13468,4096,48188,524288,32768,4097,4194304,5377,46236,4207772,277,4237352,1045,1045,2048,4116,4294967296,5396,4295536694,4097,4199956]

theorem envBound3749 : H12AffineFastState.Bounded env3749 := by
  intro p hp
  have h : env3749.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3748_3749 : H12AffineEnvironment.transform 17 48188 env3748 = env3749 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 48188 env3748 == env3749) = true)

def env3750 : List Nat := [2,4,8,16,32,16,128,4,512,1024,2048,4096,8192,4096,32768,13468,4096,48188,524288,32768,4097,4194304,5125,46236,4207772,17,4237352,1045,1045,2048,4116,4294967296,5136,4295536694,4097,4199956]

theorem envBound3750 : H12AffineFastState.Bounded env3750 := by
  intro p hp
  have h : env3750.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3749_3750 : H12AffineEnvironment.transform 7 4 env3749 = env3750 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env3749 == env3750) = true)

theorem identity3750 : scanCanonicalize (H12AffineFastState.compose env3750 (packedSelected [1,3,5,8,13,17] rootPS)) = affineNative (2^(21+1) ^^^ 525354) := by decide +kernel

theorem selectedBound3750 : packedSelected [1,3,5,8,13,17] rootPS < 2^1333 := by decide +kernel

def env3751 : List Nat := [2,4,8,16,32,16,128,4,512,1024,2048,4096,8192,4096,32768,13468,4096,48188,524288,32768,4097,525354,5125,46236,536758,17,568322,1045,1045,2048,4116,4294967296,5136,4295536694,4097,528958]

theorem envBound3751 : H12AffineFastState.Bounded env3751 := by
  intro p hp
  have h : env3751.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3750_3751 : H12AffineEnvironment.transform 21 525354 env3750 = env3751 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 525354 env3750 == env3751) = true)

theorem identity3751 : scanCanonicalize (H12AffineFastState.compose env3751 (packedSelected [1,3,5,8,10,12,15,19] rootPS)) = affineNative (2^(18+1) ^^^ 42024) := by decide +kernel

theorem selectedBound3751 : packedSelected [1,3,5,8,10,12,15,19] rootPS < 2^1333 := by decide +kernel

def env3752 : List Nat := [2,4,8,16,32,16,128,4,512,1024,2048,4096,8192,4096,32768,13468,4096,48188,42024,32768,4097,40962,5125,46236,38046,17,2090,1045,1045,2048,4116,4294967296,5136,4294972446,4097,46614]

theorem envBound3752 : H12AffineFastState.Bounded env3752 := by
  intro p hp
  have h : env3752.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3751_3752 : H12AffineEnvironment.transform 18 42024 env3751 = env3752 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 42024 env3751 == env3752) = true)

theorem identity3752 : scanCanonicalize (H12AffineFastState.compose env3752 (packedSelected [0,3,4,5,7,9,10,15,16,18] rootPS)) = affineNative (2^(14+1) ^^^ 13334) := by decide +kernel

theorem selectedBound3752 : packedSelected [0,3,4,5,7,9,10,15,16,18] rootPS < 2^1333 := by decide +kernel

def env3753 : List Nat := [2,4,8,16,32,16,128,4,512,1024,2048,4096,8192,4096,13334,13468,4096,2090,4158,13334,4097,5140,5125,138,8328,17,2090,1045,1045,2048,4116,4294967296,5136,4294972446,4097,512]

theorem envBound3753 : H12AffineFastState.Bounded env3753 := by
  intro p hp
  have h : env3753.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3752_3753 : H12AffineEnvironment.transform 14 13334 env3752 = env3753 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13334 env3752 == env3753) = true)

theorem identity3753 : scanCanonicalize (H12AffineFastState.compose env3753 (packedSelected [4,9] rootPS)) = affineNative (2^(11+1) ^^^ 1207) := by decide +kernel

theorem selectedBound3753 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env3754 : List Nat := [2,4,8,16,32,16,128,4,512,1024,2048,1207,8192,1207,8353,8235,1207,2090,1161,8353,1206,163,178,138,8328,17,2090,1045,1045,2048,1187,4294967296,167,4294967465,1206,512]

theorem envBound3754 : H12AffineFastState.Bounded env3754 := by
  intro p hp
  have h : env3754.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3753_3754 : H12AffineEnvironment.transform 11 1207 env3753 = env3754 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1207 env3753 == env3754) = true)

theorem identity3754 : scanCanonicalize (H12AffineFastState.compose env3754 (packedSelected [3,5,6,7,8,10] rootPS)) = affineNative (2^(12+1) ^^^ 3740) := by decide +kernel

theorem selectedBound3754 : packedSelected [3,5,6,7,8,10] rootPS < 2^1333 := by decide +kernel

def env3755 : List Nat := [2,4,8,16,32,16,128,4,512,1024,2048,1207,3740,1207,3645,3767,1207,2090,1161,3645,1206,163,178,138,3604,17,2090,1045,1045,2048,1187,4294967296,167,4294967465,1206,512]

theorem envBound3755 : H12AffineFastState.Bounded env3755 := by
  intro p hp
  have h : env3755.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3754_3755 : H12AffineEnvironment.transform 12 3740 env3754 = env3755 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 3740 env3754 == env3755) = true)

theorem identity3755 : scanCanonicalize (H12AffineFastState.compose env3755 (packedSelected [2,4,6,7,11] rootPS)) = affineNative (2^(10+1) ^^^ 649) := by decide +kernel

theorem selectedBound3755 : packedSelected [2,4,6,7,11] rootPS < 2^1333 := by decide +kernel

def env3756 : List Nat := [2,4,8,16,32,16,128,4,512,1024,649,1207,1045,1207,1204,1086,1207,675,1161,1204,1206,163,178,138,1181,17,675,1045,1045,649,1187,4294967296,167,4294967465,1206,512]

theorem envBound3756 : H12AffineFastState.Bounded env3756 := by
  intro p hp
  have h : env3756.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3755_3756 : H12AffineEnvironment.transform 10 649 env3755 = env3756 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 649 env3755 == env3756) = true)

theorem identity3756 : scanCanonicalize (H12AffineFastState.compose env3756 (packedSelected [0,2,4,7,8,12] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound3756 : packedSelected [0,2,4,7,8,12] rootPS < 2^1333 := by decide +kernel

def env3757 : List Nat := [2,4,8,16,32,16,8,4,512,1024,513,1087,1045,1087,1084,1086,1087,555,1025,1084,1086,43,58,2,1045,17,555,1045,1045,513,1067,4294967296,47,4294967329,1086,512]

theorem envBound3757 : H12AffineFastState.Bounded env3757 := by
  intro p hp
  have h : env3757.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3756_3757 : H12AffineEnvironment.transform 6 8 env3756 = env3757 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env3756 == env3757) = true)

theorem identity3757 : scanCanonicalize (H12AffineFastState.compose env3757 (packedSelected [0,1] rootPS)) = affineNative (2^(31+1) ^^^ 545) := by decide +kernel

theorem selectedBound3757 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env3758 : List Nat := [2,4,8,16,32,16,8,4,512,1024,513,1087,1045,1087,1084,1086,1087,555,1025,1084,1086,43,58,2,1045,17,555,1045,1045,513,1067,545,47,512,1086,512]

theorem envBound3758 : H12AffineFastState.Bounded env3758 := by
  intro p hp
  have h : env3758.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3757_3758 : H12AffineEnvironment.transform 31 545 env3757 = env3758 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 545 env3757 == env3758) = true)

theorem identity3758 : scanCanonicalize (H12AffineFastState.compose env3758 (packedSelected [0,6] rootPS)) = affineNative (2^(8+1) ^^^ 50) := by decide +kernel

theorem selectedBound3758 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env3759 : List Nat := [2,4,8,16,32,16,8,4,50,1024,51,1087,1045,1087,1084,1086,1087,25,1025,1084,1086,43,58,2,1045,17,25,1045,1045,51,1067,19,47,50,1086,50]

theorem envBound3759 : H12AffineFastState.Bounded env3759 := by
  intro p hp
  have h : env3759.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3758_3759 : H12AffineEnvironment.transform 8 50 env3758 = env3759 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 50 env3758 == env3759) = true)

theorem identity3759 : scanCanonicalize (H12AffineFastState.compose env3759 (packedSelected [0,2,4] rootPS)) = affineNative (2^(9+1) ^^^ 15) := by decide +kernel

theorem selectedBound3759 : packedSelected [0,2,4] rootPS < 2^1333 := by decide +kernel

def env3760 : List Nat := [2,4,8,16,32,16,8,4,50,15,51,48,26,48,51,49,48,25,14,51,49,43,58,2,26,17,25,26,26,51,36,19,47,50,49,50]

theorem envBound3760 : H12AffineFastState.Bounded env3760 := by
  intro p hp
  have h : env3760.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3759_3760 : H12AffineEnvironment.transform 9 15 env3759 = env3760 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 15 env3759 == env3760) = true)

theorem identity3760 : scanCanonicalize (H12AffineFastState.compose env3760 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound3760 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env3761 : List Nat := [2,4,3,16,32,16,3,4,50,4,51,48,17,48,51,49,48,18,5,51,49,32,49,2,17,17,18,17,17,51,36,19,36,50,49,50]

theorem envBound3761 : H12AffineFastState.Bounded env3761 := by
  intro p hp
  have h : env3761.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3760_3761 : H12AffineEnvironment.transform 2 3 env3760 = env3761 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env3760 == env3761) = true)

theorem identity3761 : scanCanonicalize (H12AffineFastState.compose env3761 (packedSelected [7] rootPS)) = affineNative (2^(4+1) ^^^ 18) := by decide +kernel

theorem selectedBound3761 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env3762 : List Nat := [2,4,3,16,18,16,3,4,0,4,1,2,17,2,1,3,2,18,5,1,3,18,3,2,17,17,18,17,17,1,22,19,22,0,3,0]

theorem envBound3762 : H12AffineFastState.Bounded env3762 := by
  intro p hp
  have h : env3762.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3761_3762 : H12AffineEnvironment.transform 4 18 env3761 = env3762 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 18 env3761 == env3762) = true)

theorem identity3762 : scanCanonicalize (H12AffineFastState.compose env3762 (packedSelected [5] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound3762 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env3763 : List Nat := [2,4,3,2,0,2,3,4,0,4,1,2,3,2,1,3,2,0,5,1,3,0,3,2,3,3,0,3,3,1,4,1,4,0,3,0]

theorem envBound3763 : H12AffineFastState.Bounded env3763 := by
  intro p hp
  have h : env3763.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3762_3763 : H12AffineEnvironment.transform 3 2 env3762 = env3763 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env3762 == env3763) = true)

def env3764 : List Nat := [2,4,8,16,32,16,128,5,512,1024,2048,4096,8192,4096,32768,13468,4096,48188,524288,32768,4097,4194304,5124,46236,4207772,16,4237352,1045,1045,2048,4116,4294967296,5137,4295536694,4097,4199956]

theorem envBound3764 : H12AffineFastState.Bounded env3764 := by
  intro p hp
  have h : env3764.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3749_3764 : H12AffineEnvironment.transform 7 5 env3749 = env3764 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env3749 == env3764) = true)

theorem identity3764 : scanCanonicalize (H12AffineFastState.compose env3764 (packedSelected [1,3,5,8,13,17] rootPS)) = affineNative (2^(21+1) ^^^ 5140) := by decide +kernel

theorem selectedBound3764 : packedSelected [1,3,5,8,13,17] rootPS < 2^1333 := by decide +kernel

def env3765 : List Nat := [2,4,8,16,32,16,128,5,512,1024,2048,4096,8192,4096,32768,13468,4096,48188,524288,32768,4097,5140,5124,46236,8328,16,48188,1045,1045,2048,4116,4294967296,5137,4295536694,4097,512]

theorem envBound3765 : H12AffineFastState.Bounded env3765 := by
  intro p hp
  have h : env3765.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3764_3765 : H12AffineEnvironment.transform 21 5140 env3764 = env3765 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5140 env3764 == env3765) = true)

theorem identity3765 : scanCanonicalize (H12AffineFastState.compose env3765 (packedSelected [4,9] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound3765 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env3766 : List Nat := [2,4,8,16,32,16,8,5,512,1024,2048,4096,8192,4096,32768,13332,4096,48188,524288,32768,4097,5140,5124,46100,8192,16,48188,1045,1045,2048,4116,4294967296,5137,4295536694,4097,512]

theorem envBound3766 : H12AffineFastState.Bounded env3766 := by
  intro p hp
  have h : env3766.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3765_3766 : H12AffineEnvironment.transform 6 8 env3765 = env3766 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env3765 == env3766) = true)

theorem identity3766 : scanCanonicalize (H12AffineFastState.compose env3766 (packedSelected [0,6] rootPS)) = affineNative (2^(10+1) ^^^ 35) := by decide +kernel

theorem selectedBound3766 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env3767 : List Nat := [2,4,8,16,32,16,8,5,512,1024,35,4096,8192,4096,32768,13332,4096,46111,524288,32768,4097,5140,5124,46100,8192,16,46111,1045,1045,35,4116,4294967296,5137,4295536694,4097,512]

theorem envBound3767 : H12AffineFastState.Bounded env3767 := by
  intro p hp
  have h : env3767.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3766_3767 : H12AffineEnvironment.transform 10 35 env3766 = env3767 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 35 env3766 == env3767) = true)

theorem identity3767 : scanCanonicalize (H12AffineFastState.compose env3767 (packedSelected [0,1,5,7,8,12,13] rootPS)) = affineNative (2^(12+1) ^^^ 1031) := by decide +kernel

theorem selectedBound3767 : packedSelected [0,1,5,7,8,12,13] rootPS < 2^1333 := by decide +kernel

def env3768 : List Nat := [2,4,8,16,32,16,8,5,512,1024,35,4096,1031,4096,32768,4115,4096,36888,524288,32768,4097,5140,5124,36883,1031,16,36888,1045,1045,35,4116,4294967296,5137,4295529521,4097,512]

theorem envBound3768 : H12AffineFastState.Bounded env3768 := by
  intro p hp
  have h : env3768.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3767_3768 : H12AffineEnvironment.transform 12 1031 env3767 = env3768 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1031 env3767 == env3768) = true)

theorem identity3768 : scanCanonicalize (H12AffineFastState.compose env3768 (packedSelected [0,7,12,15] rootPS)) = affineNative (2^(11+1) ^^^ 16) := by decide +kernel

theorem selectedBound3768 : packedSelected [0,7,12,15] rootPS < 2^1333 := by decide +kernel

def env3769 : List Nat := [2,4,8,16,32,16,8,5,512,1024,35,16,1031,16,32768,3,16,32776,524288,32768,17,1028,1044,32771,1031,16,32776,1045,1045,35,4,4294967296,1025,4295525409,17,512]

theorem envBound3769 : H12AffineFastState.Bounded env3769 := by
  intro p hp
  have h : env3769.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3768_3769 : H12AffineEnvironment.transform 11 16 env3768 = env3769 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 16 env3768 == env3769) = true)

theorem identity3769 : scanCanonicalize (H12AffineFastState.compose env3769 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 1061) := by decide +kernel

theorem selectedBound3769 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3770 : List Nat := [2,4,8,16,32,16,8,5,512,1024,35,16,1031,16,32768,3,16,32776,524288,32768,17,1028,1044,32771,1031,16,32776,1045,1045,35,4,1061,1025,557060,17,512]

theorem envBound3770 : H12AffineFastState.Bounded env3770 := by
  intro p hp
  have h : env3770.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3769_3770 : H12AffineEnvironment.transform 31 1061 env3769 = env3770 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1061 env3769 == env3770) = true)

def env3771 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,13469,4096,262144,524288,32768,4097,4194304,5376,46237,4207773,276,4461589,1045,1045,1073741824,4117,4294967296,5397,4295536695,4097,4199957]

theorem envBound3771 : H12AffineFastState.Bounded env3771 := by
  intro p hp
  have h : env3771.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3746_3771 : H12AffineEnvironment.transform 5 17 env3746 = env3771 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env3746 == env3771) = true)

def env3772 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,4096,8192,4097,32768,13469,4096,262144,524288,32768,4097,4194304,5124,46237,4207773,16,4461589,1045,1045,1073741824,4117,4294967296,5137,4295536695,4097,4199957]

theorem envBound3772 : H12AffineFastState.Bounded env3772 := by
  intro p hp
  have h : env3772.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3771_3772 : H12AffineEnvironment.transform 7 4 env3771 = env3772 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env3771 == env3772) = true)

theorem identity3772 : scanCanonicalize (H12AffineFastState.compose env3772 (packedSelected [10,12,13,15,17,19] rootPS)) = affineNative (2^(29+1) ^^^ 4461631) := by decide +kernel

theorem selectedBound3772 : packedSelected [10,12,13,15,17,19] rootPS < 2^1333 := by decide +kernel

def env3773 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,4096,8192,4097,32768,13469,4096,262144,524288,32768,4097,4194304,5124,46237,4207773,16,4461589,1045,1045,4461631,4117,4294967296,5137,4295536695,4097,4199957]

theorem envBound3773 : H12AffineFastState.Bounded env3773 := by
  intro p hp
  have h : env3773.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3772_3773 : H12AffineEnvironment.transform 29 4461631 env3772 = env3773 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4461631 env3772 == env3773) = true)

theorem identity3773 : scanCanonicalize (H12AffineFastState.compose env3773 (packedSelected [5,12,13,15,21] rootPS)) = affineNative (2^(21+1) ^^^ 525313) := by decide +kernel

theorem selectedBound3773 : packedSelected [5,12,13,15,21] rootPS < 2^1333 := by decide +kernel

def env3774 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,4096,8192,4097,32768,13469,4096,262144,524288,32768,4097,525313,5124,46237,536732,16,790548,1045,1045,790590,4117,4294967296,5137,4295536695,4097,528916]

theorem envBound3774 : H12AffineFastState.Bounded env3774 := by
  intro p hp
  have h : env3774.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3773_3774 : H12AffineEnvironment.transform 21 525313 env3773 = env3774 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 525313 env3773 == env3774) = true)

theorem identity3774 : scanCanonicalize (H12AffineFastState.compose env3774 (packedSelected [1,3,5,8,12,13,15,17] rootPS)) = affineNative (2^(11+1) ^^^ 1045) := by decide +kernel

theorem selectedBound3774 : packedSelected [1,3,5,8,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env3775 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,1045,8192,1044,32768,8328,1045,262144,524288,32768,1044,525313,17,41096,533641,16,787457,1045,1045,787499,1024,4294967296,4,4295533602,1044,525825]

theorem envBound3775 : H12AffineFastState.Bounded env3775 := by
  intro p hp
  have h : env3775.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3774_3775 : H12AffineEnvironment.transform 11 1045 env3774 = env3775 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1045 env3774 == env3775) = true)

theorem identity3775 : scanCanonicalize (H12AffineFastState.compose env3775 (packedSelected [5,8] rootPS)) = affineNative (2^(18+1) ^^^ 41993) := by decide +kernel

theorem selectedBound3775 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env3776 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,1045,8192,1044,32768,8328,1045,262144,41993,32768,1044,40968,17,41096,32896,16,303112,1045,1045,303138,1024,4294967296,4,4294967339,1044,41480]

theorem envBound3776 : H12AffineFastState.Bounded env3776 := by
  intro p hp
  have h : env3776.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3775_3776 : H12AffineEnvironment.transform 18 41993 env3775 = env3776 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 41993 env3775 == env3776) = true)

theorem identity3776 : scanCanonicalize (H12AffineFastState.compose env3776 (packedSelected [0,4,7,16,20,22] rootPS)) = affineNative (2^(17+1) ^^^ 43048) := by decide +kernel

theorem selectedBound3776 : packedSelected [0,4,7,16,20,22] rootPS < 2^1333 := by decide +kernel

def env3777 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,1045,8192,1044,32768,8328,1045,43048,41993,32768,1044,40968,17,41096,32896,16,2080,1045,1045,2058,1024,4294967296,4,4294967339,1044,41480]

theorem envBound3777 : H12AffineFastState.Bounded env3777 := by
  intro p hp
  have h : env3777.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3776_3777 : H12AffineEnvironment.transform 17 43048 env3776 = env3777 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43048 env3776 == env3777) = true)

theorem identity3777 : scanCanonicalize (H12AffineFastState.compose env3777 (packedSelected [1,3,4,9,12,15,16] rootPS)) = affineNative (2^(14+1) ^^^ 8200) := by decide +kernel

theorem selectedBound3777 : packedSelected [1,3,4,9,12,15,16] rootPS < 2^1333 := by decide +kernel

def env3778 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,1045,8192,1044,8200,8328,1045,2080,1025,8200,1044,0,17,128,8328,16,2080,1045,1045,2058,1024,4294967296,4,4294967339,1044,512]

theorem envBound3778 : H12AffineFastState.Bounded env3778 := by
  intro p hp
  have h : env3778.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3777_3778 : H12AffineEnvironment.transform 14 8200 env3777 = env3778 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8200 env3777 == env3778) = true)

theorem identity3778 : scanCanonicalize (H12AffineFastState.compose env3778 (packedSelected [1] rootPS)) = affineNative (2^(12+1) ^^^ 1710) := by decide +kernel

theorem selectedBound3778 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3779 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,1045,1710,1044,1702,1574,1045,2080,1025,1702,1044,0,17,128,1574,16,2080,1045,1045,2058,1024,4294967296,4,4294967339,1044,512]

theorem envBound3779 : H12AffineFastState.Bounded env3779 := by
  intro p hp
  have h : env3779.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3778_3779 : H12AffineEnvironment.transform 12 1710 env3778 = env3779 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1710 env3778 == env3779) = true)

theorem identity3779 : scanCanonicalize (H12AffineFastState.compose env3779 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 1541) := by decide +kernel

theorem selectedBound3779 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env3780 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,1045,1710,1044,1702,1574,1045,2080,1025,1702,1044,0,17,128,1574,16,2080,1045,1045,2058,1024,1541,4,1582,1044,512]

theorem envBound3780 : H12AffineFastState.Bounded env3780 := by
  intro p hp
  have h : env3780.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3779_3780 : H12AffineEnvironment.transform 31 1541 env3779 = env3780 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1541 env3779 == env3780) = true)

theorem identity3780 : scanCanonicalize (H12AffineFastState.compose env3780 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 559) := by decide +kernel

theorem selectedBound3780 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env3781 : List Nat := [2,4,8,16,32,17,128,4,512,559,2048,570,129,571,137,9,570,2080,558,137,571,0,17,128,9,16,2080,570,570,2058,559,42,4,1,571,512]

theorem envBound3781 : H12AffineFastState.Bounded env3781 := by
  intro p hp
  have h : env3781.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3780_3781 : H12AffineEnvironment.transform 9 559 env3780 = env3781 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 559 env3780 == env3781) = true)

theorem identity3781 : scanCanonicalize (H12AffineFastState.compose env3781 (packedSelected [4,7,11] rootPS)) = affineNative (2^(10+1) ^^^ 137) := by decide +kernel

theorem selectedBound3781 : packedSelected [4,7,11] rootPS < 2^1333 := by decide +kernel

def env3782 : List Nat := [2,4,8,16,32,17,128,4,512,559,137,570,129,571,137,9,570,169,558,137,571,0,17,128,9,16,169,570,570,131,559,42,4,1,571,512]

theorem envBound3782 : H12AffineFastState.Bounded env3782 := by
  intro p hp
  have h : env3782.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3781_3782 : H12AffineEnvironment.transform 10 137 env3781 = env3782 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 137 env3781 == env3782) = true)

theorem identity3782 : scanCanonicalize (H12AffineFastState.compose env3782 (packedSelected [0,2,4] rootPS)) = affineNative (2^(8+1) ^^^ 42) := by decide +kernel

theorem selectedBound3782 : packedSelected [0,2,4] rootPS < 2^1333 := by decide +kernel

def env3783 : List Nat := [2,4,8,16,32,17,128,4,42,5,137,16,129,17,137,9,16,169,4,137,17,0,17,128,9,16,169,16,16,131,5,42,4,1,17,42]

theorem envBound3783 : H12AffineFastState.Bounded env3783 := by
  intro p hp
  have h : env3783.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3782_3783 : H12AffineEnvironment.transform 8 42 env3782 = env3783 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 42 env3782 == env3783) = true)

theorem identity3783 : scanCanonicalize (H12AffineFastState.compose env3783 (packedSelected [0,2,7] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound3783 : packedSelected [0,2,7] rootPS < 2^1333 := by decide +kernel

def env3784 : List Nat := [2,4,8,16,32,17,3,4,42,5,10,16,2,17,10,9,16,42,4,10,17,0,17,3,9,16,42,16,16,0,5,42,4,1,17,42]

theorem envBound3784 : H12AffineFastState.Bounded env3784 := by
  intro p hp
  have h : env3784.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3783_3784 : H12AffineEnvironment.transform 6 3 env3783 = env3784 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env3783 == env3784) = true)

theorem identity3784 : scanCanonicalize (H12AffineFastState.compose env3784 (packedSelected [9] rootPS)) = affineNative (2^(3+1) ^^^ 8) := by decide +kernel

theorem selectedBound3784 : packedSelected [9] rootPS < 2^1333 := by decide +kernel

def env3785 : List Nat := [2,4,8,8,32,9,3,4,42,5,10,8,2,9,10,9,8,42,4,10,9,0,9,3,9,8,42,8,8,0,5,42,4,1,9,42]

theorem envBound3785 : H12AffineFastState.Bounded env3785 := by
  intro p hp
  have h : env3785.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3784_3785 : H12AffineEnvironment.transform 3 8 env3784 = env3785 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 8 env3784 == env3785) = true)

theorem identity3785 : scanCanonicalize (H12AffineFastState.compose env3785 (packedSelected [3,12] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound3785 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env3786 : List Nat := [2,4,8,8,0,9,3,4,10,5,10,8,2,9,10,9,8,10,4,10,9,0,9,3,9,8,10,8,8,0,5,10,4,1,9,10]

theorem envBound3786 : H12AffineFastState.Bounded env3786 := by
  intro p hp
  have h : env3786.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3785_3786 : H12AffineEnvironment.transform 4 0 env3785 = env3786 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env3785 == env3786) = true)

theorem identity3786 : scanCanonicalize (H12AffineFastState.compose env3786 (packedSelected [15] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound3786 : packedSelected [15] rootPS < 2^1333 := by decide +kernel

def env3787 : List Nat := [2,4,2,2,0,3,3,4,0,5,0,2,2,3,0,3,2,0,4,0,3,0,3,3,3,2,0,2,2,0,5,0,4,1,3,0]

theorem envBound3787 : H12AffineFastState.Bounded env3787 := by
  intro p hp
  have h : env3787.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3786_3787 : H12AffineEnvironment.transform 2 2 env3786 = env3787 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env3786 == env3787) = true)

def env3788 : List Nat := [2,4,8,16,32,17,128,5,512,1024,2048,4096,8192,4097,32768,13469,4096,262144,524288,32768,4097,4194304,5125,46237,4207773,17,4461589,1045,1045,1073741824,4117,4294967296,5136,4295536695,4097,4199957]

theorem envBound3788 : H12AffineFastState.Bounded env3788 := by
  intro p hp
  have h : env3788.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3771_3788 : H12AffineEnvironment.transform 7 5 env3771 = env3788 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env3771 == env3788) = true)

theorem identity3788 : scanCanonicalize (H12AffineFastState.compose env3788 (packedSelected [10,12,13,15,17,19] rootPS)) = affineNative (2^(29+1) ^^^ 2048) := by decide +kernel

theorem selectedBound3788 : packedSelected [10,12,13,15,17,19] rootPS < 2^1333 := by decide +kernel

def env3789 : List Nat := [2,4,8,16,32,17,128,5,512,1024,2048,4096,8192,4097,32768,13469,4096,262144,524288,32768,4097,4194304,5125,46237,4207773,17,4461589,1045,1045,2048,4117,4294967296,5136,4295536695,4097,4199957]

theorem envBound3789 : H12AffineFastState.Bounded env3789 := by
  intro p hp
  have h : env3789.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3788_3789 : H12AffineEnvironment.transform 29 2048 env3788 = env3789 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 2048 env3788 == env3789) = true)

theorem identity3789 : scanCanonicalize (H12AffineFastState.compose env3789 (packedSelected [1,3,5,8,13,17] rootPS)) = affineNative (2^(21+1) ^^^ 5141) := by decide +kernel

theorem selectedBound3789 : packedSelected [1,3,5,8,13,17] rootPS < 2^1333 := by decide +kernel

def env3790 : List Nat := [2,4,8,16,32,17,128,5,512,1024,2048,4096,8192,4097,32768,13469,4096,262144,524288,32768,4097,5141,5125,46237,8328,17,262144,1045,1045,2048,4117,4294967296,5136,4295536695,4097,512]

theorem envBound3790 : H12AffineFastState.Bounded env3790 := by
  intro p hp
  have h : env3790.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3789_3790 : H12AffineEnvironment.transform 21 5141 env3789 = env3790 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5141 env3789 == env3790) = true)

theorem identity3790 : scanCanonicalize (H12AffineFastState.compose env3790 (packedSelected [4,9] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound3790 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env3791 : List Nat := [2,4,8,16,32,17,8,5,512,1024,2048,4096,8192,4097,32768,13333,4096,262144,524288,32768,4097,5141,5125,46101,8192,17,262144,1045,1045,2048,4117,4294967296,5136,4295536695,4097,512]

theorem envBound3791 : H12AffineFastState.Bounded env3791 := by
  intro p hp
  have h : env3791.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3790_3791 : H12AffineEnvironment.transform 6 8 env3790 = env3791 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env3790 == env3791) = true)

theorem identity3791 : scanCanonicalize (H12AffineFastState.compose env3791 (packedSelected [0,6] rootPS)) = affineNative (2^(10+1) ^^^ 35) := by decide +kernel

theorem selectedBound3791 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env3792 : List Nat := [2,4,8,16,32,17,8,5,512,1024,35,4096,8192,4097,32768,13333,4096,262144,524288,32768,4097,5141,5125,46101,8192,17,262144,1045,1045,35,4117,4294967296,5136,4295536695,4097,512]

theorem envBound3792 : H12AffineFastState.Bounded env3792 := by
  intro p hp
  have h : env3792.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3791_3792 : H12AffineEnvironment.transform 10 35 env3791 = env3792 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 35 env3791 == env3792) = true)

theorem identity3792 : scanCanonicalize (H12AffineFastState.compose env3792 (packedSelected [0,1,5,7,8,12,13] rootPS)) = affineNative (2^(12+1) ^^^ 1031) := by decide +kernel

theorem selectedBound3792 : packedSelected [0,1,5,7,8,12,13] rootPS < 2^1333 := by decide +kernel

def env3793 : List Nat := [2,4,8,16,32,17,8,5,512,1024,35,4096,1031,4097,32768,4114,4096,262144,524288,32768,4097,5141,5125,36882,1031,17,262144,1045,1045,35,4117,4294967296,5136,4295529520,4097,512]

theorem envBound3793 : H12AffineFastState.Bounded env3793 := by
  intro p hp
  have h : env3793.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3792_3793 : H12AffineEnvironment.transform 12 1031 env3792 = env3793 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1031 env3792 == env3793) = true)

theorem identity3793 : scanCanonicalize (H12AffineFastState.compose env3793 (packedSelected [0,7,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 32776) := by decide +kernel

theorem selectedBound3793 : packedSelected [0,7,12,15] rootPS < 2^1333 := by decide +kernel

def env3794 : List Nat := [2,4,8,16,32,17,8,5,512,1024,35,4096,1031,4097,32768,4114,4096,32776,524288,32768,4097,5141,5125,36882,1031,17,32776,1045,1045,35,4117,4294967296,5136,4295529520,4097,512]

theorem envBound3794 : H12AffineFastState.Bounded env3794 := by
  intro p hp
  have h : env3794.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3793_3794 : H12AffineEnvironment.transform 17 32776 env3793 = env3794 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 32776 env3793 == env3794) = true)

def env3795 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,524288,32768,4097,4194304,5457,98305,4259840,324,4461636,1044,1044,1073741824,4164,4294967296,5445,4295536742,4097,4268680]

theorem envBound3795 : H12AffineFastState.Bounded env3795 := by
  intro p hp
  have h : env3795.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3744_3795 : H12AffineEnvironment.transform 23 98305 env3744 = env3795 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98305 env3744 == env3795) = true)

theorem identity3795 : scanCanonicalize (H12AffineFastState.compose env3795 (packedSelected [3,5,24] rootPS)) = affineNative (2^(18+1) ^^^ 78028) := by decide +kernel

theorem selectedBound3795 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env3796 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,78028,32768,4097,4194304,5457,98305,4259840,324,4461636,1044,1044,1073741824,4164,4294967296,5445,4295065770,4097,4268680]

theorem envBound3796 : H12AffineFastState.Bounded env3796 := by
  intro p hp
  have h : env3796.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3795_3796 : H12AffineEnvironment.transform 18 78028 env3795 = env3796 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 78028 env3795 == env3796) = true)

def env3797 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,78028,32768,4097,73728,5457,98305,8192,324,341060,1044,1044,1073741824,4164,4294967296,5445,4295065770,4097,648]

theorem envBound3797 : H12AffineFastState.Bounded env3797 := by
  intro p hp
  have h : env3797.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3796_3797 : H12AffineEnvironment.transform 21 73728 env3796 = env3797 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 73728 env3796 == env3797) = true)

theorem identity3797 : scanCanonicalize (H12AffineFastState.compose env3797 (packedSelected [1,3,5,7,8,10,19,20,27] rootPS)) = affineNative (2^(29+1) ^^^ 100490) := by decide +kernel

theorem selectedBound3797 : packedSelected [1,3,5,7,8,10,19,20,27] rootPS < 2^1333 := by decide +kernel

def env3798 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,78028,32768,4097,73728,5457,98305,8192,324,341060,1044,1044,100490,4164,4294967296,5445,4295065770,4097,648]

theorem envBound3798 : H12AffineFastState.Bounded env3798 := by
  intro p hp
  have h : env3798.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3797_3798 : H12AffineEnvironment.transform 29 100490 env3797 = env3798 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 100490 env3797 == env3798) = true)

def env3799 : List Nat := [2,4,8,16,32,64,8,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,77892,32768,4097,73728,5457,98305,8192,324,341060,1044,1044,100354,4164,4294967296,5445,4295065634,4097,512]

theorem envBound3799 : H12AffineFastState.Bounded env3799 := by
  intro p hp
  have h : env3799.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3798_3799 : H12AffineEnvironment.transform 6 8 env3798 = env3799 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env3798 == env3799) = true)

theorem identity3799 : scanCanonicalize (H12AffineFastState.compose env3799 (packedSelected [1,3,4,5,8,9,10,16,19] rootPS)) = affineNative (2^(15+1) ^^^ 13381) := by decide +kernel

theorem selectedBound3799 : packedSelected [1,3,4,5,8,9,10,16,19] rootPS < 2^1333 := by decide +kernel

def env3800 : List Nat := [2,4,8,16,32,64,8,256,512,1024,2048,4096,8192,4176,32768,13381,4096,262144,1025,32768,4097,5189,5457,46148,8192,324,262145,1044,1044,48199,4164,4294967296,5445,4295013479,4097,512]

theorem envBound3800 : H12AffineFastState.Bounded env3800 := by
  intro p hp
  have h : env3800.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3799_3800 : H12AffineEnvironment.transform 15 13381 env3799 = env3800 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13381 env3799 == env3800) = true)

theorem identity3800 : scanCanonicalize (H12AffineFastState.compose env3800 (packedSelected [0,4,7,16,20,22] rootPS)) = affineNative (2^(14+1) ^^^ 8201) := by decide +kernel

theorem selectedBound3800 : packedSelected [0,4,7,16,20,22] rootPS < 2^1333 := by decide +kernel

def env3801 : List Nat := [2,4,8,16,32,64,8,256,512,1024,2048,4096,8192,4176,8201,13381,4096,262144,1025,8201,4097,5189,5457,5197,8192,324,262145,1044,1044,7246,4164,4294967296,5445,4294972526,4097,512]

theorem envBound3801 : H12AffineFastState.Bounded env3801 := by
  intro p hp
  have h : env3801.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3800_3801 : H12AffineEnvironment.transform 14 8201 env3800 = env3801 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8201 env3800 == env3801) = true)

theorem identity3801 : scanCanonicalize (H12AffineFastState.compose env3801 (packedSelected [4,5,9,10,16,26] rootPS)) = affineNative (2^(11+1) ^^^ 1344) := by decide +kernel

theorem selectedBound3801 : packedSelected [4,5,9,10,16,26] rootPS < 2^1333 := by decide +kernel

def env3802 : List Nat := [2,4,8,16,32,64,8,256,512,1024,2048,1344,8192,1296,8201,8453,1344,262144,1025,8201,1345,261,17,269,8192,324,262145,1044,1044,2318,1284,4294967296,5,4294967598,1345,512]

theorem envBound3802 : H12AffineFastState.Bounded env3802 := by
  intro p hp
  have h : env3802.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3801_3802 : H12AffineEnvironment.transform 11 1344 env3801 = env3802 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1344 env3801 == env3802) = true)

theorem identity3802 : scanCanonicalize (H12AffineFastState.compose env3802 (packedSelected [4,9,16] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound3802 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env3803 : List Nat := [2,4,8,16,32,64,8,5,512,1024,2048,1093,8192,1045,8201,8192,1093,262144,1025,8201,1092,0,17,8,8192,65,262145,1044,1044,2059,1025,4294967296,5,4294967339,1092,512]

theorem envBound3803 : H12AffineFastState.Bounded env3803 := by
  intro p hp
  have h : env3803.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3802_3803 : H12AffineEnvironment.transform 7 5 env3802 = env3803 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env3802 == env3803) = true)

theorem identity3803 : scanCanonicalize (H12AffineFastState.compose env3803 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 8307) := by decide +kernel

theorem selectedBound3803 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env3804 : List Nat := [2,4,8,16,32,64,8,5,512,1024,2048,1093,8192,1045,8201,8192,1093,262144,1025,8201,1092,0,17,8,8192,65,262145,1044,1044,2059,1025,8307,5,8280,1092,512]

theorem envBound3804 : H12AffineFastState.Bounded env3804 := by
  intro p hp
  have h : env3804.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3803_3804 : H12AffineEnvironment.transform 31 8307 env3803 = env3804 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 8307 env3803 == env3804) = true)

theorem identity3804 : scanCanonicalize (H12AffineFastState.compose env3804 (packedSelected [7] rootPS)) = affineNative (2^(8+1) ^^^ 25) := by decide +kernel

theorem selectedBound3804 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env3805 : List Nat := [2,4,8,16,32,64,8,5,25,1024,2048,1093,8192,1045,8201,8192,1093,262144,1025,8201,1092,0,17,8,8192,65,262145,1044,1044,2059,1025,8307,5,8280,1092,25]

theorem envBound3805 : H12AffineFastState.Bounded env3805 := by
  intro p hp
  have h : env3805.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3804_3805 : H12AffineEnvironment.transform 8 25 env3804 = env3805 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 25 env3804 == env3805) = true)

theorem identity3805 : scanCanonicalize (H12AffineFastState.compose env3805 (packedSelected [3,5,10] rootPS)) = affineNative (2^(9+1) ^^^ 54) := by decide +kernel

theorem selectedBound3805 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env3806 : List Nat := [2,4,8,16,32,64,8,5,25,54,2048,115,8192,35,8201,8192,115,262144,55,8201,114,0,17,8,8192,65,262145,34,34,2059,55,8307,5,8280,114,25]

theorem envBound3806 : H12AffineFastState.Bounded env3806 := by
  intro p hp
  have h : env3806.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3805_3806 : H12AffineEnvironment.transform 9 54 env3805 = env3806 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 54 env3805 == env3806) = true)

theorem identity3806 : scanCanonicalize (H12AffineFastState.compose env3806 (packedSelected [1,8,12] rootPS)) = affineNative (2^(17+1) ^^^ 91) := by decide +kernel

theorem selectedBound3806 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env3807 : List Nat := [2,4,8,16,32,64,8,5,25,54,2048,115,8192,35,8201,8192,115,91,55,8201,114,0,17,8,8192,65,90,34,34,2059,55,8307,5,8280,114,25]

theorem envBound3807 : H12AffineFastState.Bounded env3807 := by
  intro p hp
  have h : env3807.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3806_3807 : H12AffineEnvironment.transform 17 91 env3806 = env3807 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 91 env3806 == env3807) = true)

theorem identity3807 : scanCanonicalize (H12AffineFastState.compose env3807 (packedSelected [4,5,8,9] rootPS)) = affineNative (2^(10+1) ^^^ 10) := by decide +kernel

theorem selectedBound3807 : packedSelected [4,5,8,9] rootPS < 2^1333 := by decide +kernel

def env3808 : List Nat := [2,4,8,16,32,64,8,5,25,54,10,115,8192,35,8201,8192,115,91,55,8201,114,0,17,8,8192,65,90,34,34,1,55,8307,5,8280,114,25]

theorem envBound3808 : H12AffineFastState.Bounded env3808 := by
  intro p hp
  have h : env3808.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3807_3808 : H12AffineEnvironment.transform 10 10 env3807 = env3808 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 10 env3807 == env3808) = true)

theorem identity3808 : scanCanonicalize (H12AffineFastState.compose env3808 (packedSelected [0] rootPS)) = affineNative (2^(12+1) ^^^ 41) := by decide +kernel

theorem selectedBound3808 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3809 : List Nat := [2,4,8,16,32,64,8,5,25,54,10,115,41,35,32,41,115,91,55,32,114,0,17,8,41,65,90,34,34,1,55,90,5,113,114,25]

theorem envBound3809 : H12AffineFastState.Bounded env3809 := by
  intro p hp
  have h : env3809.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3808_3809 : H12AffineEnvironment.transform 12 41 env3808 = env3809 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 41 env3808 == env3809) = true)

theorem identity3809 : scanCanonicalize (H12AffineFastState.compose env3809 (packedSelected [1,2,3,8] rootPS)) = affineNative (2^(5+1) ^^^ 40) := by decide +kernel

theorem selectedBound3809 : packedSelected [1,2,3,8] rootPS < 2^1333 := by decide +kernel

def env3810 : List Nat := [2,4,8,16,32,40,8,5,25,54,10,27,41,35,32,41,27,51,55,32,26,0,17,8,41,41,50,34,34,1,55,50,5,25,26,25]

theorem envBound3810 : H12AffineFastState.Bounded env3810 := by
  intro p hp
  have h : env3810.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3809_3810 : H12AffineEnvironment.transform 5 40 env3809 = env3810 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 40 env3809 == env3810) = true)

theorem identity3810 : scanCanonicalize (H12AffineFastState.compose env3810 (packedSelected [4,11] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound3810 : packedSelected [4,11] rootPS < 2^1333 := by decide +kernel

def env3811 : List Nat := [2,4,8,2,32,40,8,5,11,36,10,9,41,35,32,41,9,33,37,32,8,0,3,8,41,41,32,34,34,1,37,32,5,11,8,11]

theorem envBound3811 : H12AffineFastState.Bounded env3811 := by
  intro p hp
  have h : env3811.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3810_3811 : H12AffineEnvironment.transform 3 2 env3810 = env3811 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env3810 == env3811) = true)

theorem identity3811 : scanCanonicalize (H12AffineFastState.compose env3811 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound3811 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env3812 : List Nat := [2,4,8,2,11,3,8,5,11,15,10,9,2,8,11,2,9,10,14,11,8,0,3,8,2,2,11,9,9,1,14,11,5,11,8,11]

theorem envBound3812 : H12AffineFastState.Bounded env3812 := by
  intro p hp
  have h : env3812.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3811_3812 : H12AffineEnvironment.transform 4 11 env3811 = env3812 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env3811 == env3812) = true)

theorem identity3812 : scanCanonicalize (H12AffineFastState.compose env3812 (packedSelected [1,13] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound3812 : packedSelected [1,13] rootPS < 2^1333 := by decide +kernel

def env3813 : List Nat := [2,4,2,2,1,3,2,5,1,5,0,3,2,2,1,2,3,0,4,1,2,0,3,2,2,2,1,3,3,1,4,1,5,1,2,1]

theorem envBound3813 : H12AffineFastState.Bounded env3813 := by
  intro p hp
  have h : env3813.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3812_3813 : H12AffineEnvironment.transform 2 2 env3812 = env3813 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env3812 == env3813) = true)

def env3814 : List Nat := [2,4,8,16,32,64,9,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,77893,32768,4097,73728,5457,98305,8192,324,341060,1044,1044,100355,4164,4294967296,5445,4295065635,4097,513]

theorem envBound3814 : H12AffineFastState.Bounded env3814 := by
  intro p hp
  have h : env3814.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3798_3814 : H12AffineEnvironment.transform 6 9 env3798 = env3814 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env3798 == env3814) = true)

def env3815 : List Nat := [2,4,8,16,32,64,9,4,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,77893,32768,4097,73728,5205,98305,8192,64,341060,1044,1044,100355,4164,4294967296,5185,4295065635,4097,513]

theorem envBound3815 : H12AffineFastState.Bounded env3815 := by
  intro p hp
  have h : env3815.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3814_3815 : H12AffineEnvironment.transform 7 4 env3814 = env3815 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env3814 == env3815) = true)

theorem identity3815 : scanCanonicalize (H12AffineFastState.compose env3815 (packedSelected [3,15,17] rootPS)) = affineNative (2^(17+1) ^^^ 2091) := by decide +kernel

theorem selectedBound3815 : packedSelected [3,15,17] rootPS < 2^1333 := by decide +kernel

def env3816 : List Nat := [2,4,8,16,32,64,9,4,512,1024,2048,4096,8192,4176,32768,65536,4096,2091,77893,32768,4097,73728,5205,98305,8192,64,81007,1044,1044,100355,4164,4294967296,5185,4295065635,4097,513]

theorem envBound3816 : H12AffineFastState.Bounded env3816 := by
  intro p hp
  have h : env3816.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3815_3816 : H12AffineEnvironment.transform 17 2091 env3815 = env3816 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2091 env3815 == env3816) = true)

theorem identity3816 : scanCanonicalize (H12AffineFastState.compose env3816 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(11+1) ^^^ 1605) := by decide +kernel

theorem selectedBound3816 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env3817 : List Nat := [2,4,8,16,32,64,9,4,512,1024,2048,1605,8192,1557,32768,65536,1605,2091,75264,32768,1604,73728,528,98305,8192,64,76330,1044,1044,100355,1537,4294967296,516,4295065635,1604,513]

theorem envBound3817 : H12AffineFastState.Bounded env3817 := by
  intro p hp
  have h : env3817.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3816_3817 : H12AffineEnvironment.transform 11 1605 env3816 = env3817 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1605 env3816 == env3817) = true)

theorem identity3817 : scanCanonicalize (H12AffineFastState.compose env3817 (packedSelected [1,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 8707) := by decide +kernel

theorem selectedBound3817 : packedSelected [1,12,13] rootPS < 2^1333 := by decide +kernel

def env3818 : List Nat := [2,4,8,16,32,64,9,4,512,1024,2048,1605,8192,1557,8707,65536,1605,2091,75264,8707,1604,73728,528,74242,8192,64,76330,1044,1044,76288,1537,4294967296,516,4295041568,1604,513]

theorem envBound3818 : H12AffineFastState.Bounded env3818 := by
  intro p hp
  have h : env3818.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3817_3818 : H12AffineEnvironment.transform 14 8707 env3817 = env3818 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8707 env3817 == env3818) = true)

def env3819 : List Nat := [2,4,8,16,32,64,9,4,512,1024,2048,1605,8192,1557,8707,2056,1605,2091,11784,8707,1604,10248,528,10762,8192,64,8738,1044,1044,8712,1537,4294967296,516,4294978088,1604,513]

theorem envBound3819 : H12AffineFastState.Bounded env3819 := by
  intro p hp
  have h : env3819.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3818_3819 : H12AffineEnvironment.transform 15 2056 env3818 = env3819 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2056 env3818 == env3819) = true)

def env3820 : List Nat := [2,4,8,16,32,64,9,4,512,1024,2048,1605,8192,1557,8707,2057,1605,2091,11785,8707,1604,10249,528,10763,8192,64,8739,1044,1044,8713,1537,4294967296,516,4294978089,1604,513]

theorem envBound3820 : H12AffineFastState.Bounded env3820 := by
  intro p hp
  have h : env3820.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3818_3820 : H12AffineEnvironment.transform 15 2057 env3818 = env3820 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2057 env3818 == env3820) = true)

theorem identity3820 : scanCanonicalize (H12AffineFastState.compose env3820 (packedSelected [0,6] rootPS)) = affineNative (2^(12+1) ^^^ 2568) := by decide +kernel

theorem selectedBound3820 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env3821 : List Nat := [2,4,8,16,32,64,9,4,512,1024,2048,1605,2568,1557,2059,2057,1605,2091,1025,2059,1604,513,528,3,2568,64,2091,1044,1044,2049,1537,4294967296,516,4294967329,1604,513]

theorem envBound3821 : H12AffineFastState.Bounded env3821 := by
  intro p hp
  have h : env3821.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3820_3821 : H12AffineEnvironment.transform 12 2568 env3820 = env3821 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2568 env3820 == env3821) = true)

theorem identity3821 : scanCanonicalize (H12AffineFastState.compose env3821 (packedSelected [2,4] rootPS)) = affineNative (2^(5+1) ^^^ 58) := by decide +kernel

theorem selectedBound3821 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env3822 : List Nat := [2,4,8,16,32,58,9,4,512,1024,2048,1599,2568,1557,2059,2057,1599,2091,1025,2059,1598,513,528,3,2568,58,2091,1044,1044,2049,1537,4294967296,516,4294967329,1598,513]

theorem envBound3822 : H12AffineFastState.Bounded env3822 := by
  intro p hp
  have h : env3822.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3821_3822 : H12AffineEnvironment.transform 5 58 env3821 = env3822 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 58 env3821 == env3822) = true)

theorem identity3822 : scanCanonicalize (H12AffineFastState.compose env3822 (packedSelected [0,1] rootPS)) = affineNative (2^(8+1) ^^^ 33) := by decide +kernel

theorem selectedBound3822 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env3823 : List Nat := [2,4,8,16,32,58,9,4,33,1024,2048,1054,2089,1076,2059,2057,1054,2091,1025,2059,1055,32,49,3,2089,58,2091,1044,1044,2049,1056,4294967296,37,4294967329,1055,32]

theorem envBound3823 : H12AffineFastState.Bounded env3823 := by
  intro p hp
  have h : env3823.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3822_3823 : H12AffineEnvironment.transform 8 33 env3822 = env3823 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 33 env3822 == env3823) = true)

theorem identity3823 : scanCanonicalize (H12AffineFastState.compose env3823 (packedSelected [0,3,5] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound3823 : packedSelected [0,3,5] rootPS < 2^1333 := by decide +kernel

def env3824 : List Nat := [2,4,8,16,1,27,9,4,0,1024,2048,1054,2056,1045,2059,2057,1054,2058,1025,2059,1055,1,16,3,2056,27,2058,1044,1044,2049,1025,4294967296,4,4294967296,1055,1]

theorem envBound3824 : H12AffineFastState.Bounded env3824 := by
  intro p hp
  have h : env3824.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3823_3824 : H12AffineEnvironment.transform 4 1 env3823 = env3824 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env3823 == env3824) = true)

theorem identity3824 : scanCanonicalize (H12AffineFastState.compose env3824 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 2058) := by decide +kernel

theorem selectedBound3824 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3825 : List Nat := [2,4,8,16,1,27,9,4,0,1024,2048,1054,2056,1045,2059,2057,1054,2058,1025,2059,1055,1,16,3,2056,27,2058,1044,1044,2049,1025,2058,4,2058,1055,1]

theorem envBound3825 : H12AffineFastState.Bounded env3825 := by
  intro p hp
  have h : env3825.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3824_3825 : H12AffineEnvironment.transform 31 2058 env3824 = env3825 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 2058 env3824 == env3825) = true)

theorem identity3825 : scanCanonicalize (H12AffineFastState.compose env3825 (packedSelected [2] rootPS)) = affineNative (2^(10+1) ^^^ 0) := by decide +kernel

theorem selectedBound3825 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3826 : List Nat := [2,4,8,16,1,27,9,4,0,1024,0,1054,8,1045,11,9,1054,10,1025,11,1055,1,16,3,8,27,10,1044,1044,1,1025,10,4,10,1055,1]

theorem envBound3826 : H12AffineFastState.Bounded env3826 := by
  intro p hp
  have h : env3826.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3825_3826 : H12AffineEnvironment.transform 10 0 env3825 = env3826 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env3825 == env3826) = true)

theorem identity3826 : scanCanonicalize (H12AffineFastState.compose env3826 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound3826 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env3827 : List Nat := [2,4,2,16,1,17,3,4,0,1024,0,1044,2,1045,1,3,1044,0,1025,1,1045,1,16,3,2,17,0,1044,1044,1,1025,0,4,0,1045,1]

theorem envBound3827 : H12AffineFastState.Bounded env3827 := by
  intro p hp
  have h : env3827.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3826_3827 : H12AffineEnvironment.transform 2 2 env3826 = env3827 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env3826 == env3827) = true)

def env3828 : List Nat := [2,4,8,16,32,64,9,5,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,77893,32768,4097,73728,5204,98305,8192,65,341060,1044,1044,100355,4164,4294967296,5184,4295065635,4097,513]

theorem envBound3828 : H12AffineFastState.Bounded env3828 := by
  intro p hp
  have h : env3828.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3814_3828 : H12AffineEnvironment.transform 7 5 env3814 = env3828 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env3814 == env3828) = true)

theorem identity3828 : scanCanonicalize (H12AffineFastState.compose env3828 (packedSelected [3,15,17] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound3828 : packedSelected [3,15,17] rootPS < 2^1333 := by decide +kernel

def env3829 : List Nat := [2,4,8,16,0,64,9,5,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,77893,32768,4097,73728,5204,98305,8192,65,341060,1044,1044,100355,4164,4294967296,5184,4295065603,4097,513]

theorem envBound3829 : H12AffineFastState.Bounded env3829 := by
  intro p hp
  have h : env3829.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3828_3829 : H12AffineEnvironment.transform 4 0 env3828 = env3829 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env3828 == env3829) = true)

theorem identity3829 : scanCanonicalize (H12AffineFastState.compose env3829 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(11+1) ^^^ 1556) := by decide +kernel

theorem selectedBound3829 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env3830 : List Nat := [2,4,8,16,0,64,9,5,512,1024,2048,1556,8192,1604,32768,65536,1556,262144,75345,32768,1557,73728,576,98305,8192,65,336464,1044,1044,100355,1616,4294967296,596,4295065603,1557,513]

theorem envBound3830 : H12AffineFastState.Bounded env3830 := by
  intro p hp
  have h : env3830.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3829_3830 : H12AffineEnvironment.transform 11 1556 env3829 = env3830 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1556 env3829 == env3830) = true)

theorem identity3830 : scanCanonicalize (H12AffineFastState.compose env3830 (packedSelected [4,16,22] rootPS)) = affineNative (2^(15+1) ^^^ 8192) := by decide +kernel

theorem selectedBound3830 : packedSelected [4,16,22] rootPS < 2^1333 := by decide +kernel

def env3831 : List Nat := [2,4,8,16,0,64,9,5,512,1024,2048,1556,8192,1604,32768,8192,1556,262144,1617,32768,1557,0,576,40961,8192,65,262736,1044,1044,43011,1616,4294967296,596,4295008259,1557,513]

theorem envBound3831 : H12AffineFastState.Bounded env3831 := by
  intro p hp
  have h : env3831.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3830_3831 : H12AffineEnvironment.transform 15 8192 env3830 = env3831 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8192 env3830 == env3831) = true)

theorem identity3831 : scanCanonicalize (H12AffineFastState.compose env3831 (packedSelected [4,9,16] rootPS)) = affineNative (2^(8+1) ^^^ 81) := by decide +kernel

theorem selectedBound3831 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env3832 : List Nat := [2,4,8,16,0,64,9,5,81,1024,2048,1093,8192,1045,32768,8192,1093,262144,1024,32768,1092,0,17,40961,8192,65,262145,1044,1044,43011,1025,4294967296,5,4295008259,1092,80]

theorem envBound3832 : H12AffineFastState.Bounded env3832 := by
  intro p hp
  have h : env3832.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3831_3832 : H12AffineEnvironment.transform 8 81 env3831 = env3832 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 81 env3831 == env3832) = true)

theorem identity3832 : scanCanonicalize (H12AffineFastState.compose env3832 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 295003) := by decide +kernel

theorem selectedBound3832 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env3833 : List Nat := [2,4,8,16,0,64,9,5,81,1024,2048,1093,8192,1045,32768,8192,1093,262144,1024,32768,1092,0,17,40961,8192,65,262145,1044,1044,43011,1025,295003,5,270424,1092,80]

theorem envBound3833 : H12AffineFastState.Bounded env3833 := by
  intro p hp
  have h : env3833.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3832_3833 : H12AffineEnvironment.transform 31 295003 env3832 = env3833 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 295003 env3832 == env3833) = true)

theorem identity3833 : scanCanonicalize (H12AffineFastState.compose env3833 (packedSelected [7] rootPS)) = affineNative (2^(17+1) ^^^ 8265) := by decide +kernel

theorem selectedBound3833 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env3834 : List Nat := [2,4,8,16,0,64,9,5,81,1024,2048,1093,8192,1045,32768,8192,1093,8265,1024,32768,1092,0,17,40961,8192,65,8264,1044,1044,43011,1025,40978,5,17,1092,80]

theorem envBound3834 : H12AffineFastState.Bounded env3834 := by
  intro p hp
  have h : env3834.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3833_3834 : H12AffineEnvironment.transform 17 8265 env3833 = env3834 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 8265 env3833 == env3834) = true)

theorem identity3834 : scanCanonicalize (H12AffineFastState.compose env3834 (packedSelected [2,4,5,8,9] rootPS)) = affineNative (2^(14+1) ^^^ 8217) := by decide +kernel

theorem selectedBound3834 : packedSelected [2,4,5,8,9] rootPS < 2^1333 := by decide +kernel

def env3835 : List Nat := [2,4,8,16,0,64,9,5,81,1024,2048,1093,8192,1045,8217,8192,1093,8265,1024,8217,1092,0,17,24,8192,65,8264,1044,1044,2074,1025,11,5,17,1092,80]

theorem envBound3835 : H12AffineFastState.Bounded env3835 := by
  intro p hp
  have h : env3835.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3834_3835 : H12AffineEnvironment.transform 14 8217 env3834 = env3835 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8217 env3834 == env3835) = true)

theorem identity3835 : scanCanonicalize (H12AffineFastState.compose env3835 (packedSelected [3,5,10] rootPS)) = affineNative (2^(5+1) ^^^ 27) := by decide +kernel

theorem selectedBound3835 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env3836 : List Nat := [2,4,8,16,0,27,9,5,10,1024,2048,1054,8192,1045,8217,8192,1054,8210,1024,8217,1055,0,17,24,8192,26,8211,1044,1044,2074,1025,11,5,17,1055,11]

theorem envBound3836 : H12AffineFastState.Bounded env3836 := by
  intro p hp
  have h : env3836.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3835_3836 : H12AffineEnvironment.transform 5 27 env3835 = env3836 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 27 env3835 == env3836) = true)

theorem identity3836 : scanCanonicalize (H12AffineFastState.compose env3836 (packedSelected [1,3,4,8,11] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound3836 : packedSelected [1,3,4,8,11] rootPS < 2^1333 := by decide +kernel

def env3837 : List Nat := [2,4,3,16,0,16,2,5,1,1024,2048,1045,8192,1045,8210,8192,1045,8210,1024,8210,1044,0,17,19,8192,17,8211,1044,1044,2065,1025,0,5,17,1044,0]

theorem envBound3837 : H12AffineFastState.Bounded env3837 := by
  intro p hp
  have h : env3837.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3836_3837 : H12AffineEnvironment.transform 2 3 env3836 = env3837 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env3836 == env3837) = true)

theorem identity3837 : scanCanonicalize (H12AffineFastState.compose env3837 (packedSelected [1,3,5] rootPS)) = affineNative (2^(12+1) ^^^ 2066) := by decide +kernel

theorem selectedBound3837 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env3838 : List Nat := [2,4,3,16,0,16,2,5,1,1024,2048,1045,2066,1045,2048,2066,1045,2048,1024,2048,1044,0,17,19,2066,17,2049,1044,1044,2065,1025,0,5,17,1044,0]

theorem envBound3838 : H12AffineFastState.Bounded env3838 := by
  intro p hp
  have h : env3838.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3837_3838 : H12AffineEnvironment.transform 12 2066 env3837 = env3838 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2066 env3837 == env3838) = true)

theorem identity3838 : scanCanonicalize (H12AffineFastState.compose env3838 (packedSelected [0,2] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound3838 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env3839 : List Nat := [2,4,3,1,0,1,2,5,1,1024,2048,1028,2051,1028,2048,2051,1028,2048,1024,2048,1029,0,0,2,2051,0,2049,1029,1029,2048,1025,0,5,0,1029,0]

theorem envBound3839 : H12AffineFastState.Bounded env3839 := by
  intro p hp
  have h : env3839.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3838_3839 : H12AffineEnvironment.transform 3 1 env3838 = env3839 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env3838 == env3839) = true)

def env3840 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,78028,32768,4097,73729,5457,98305,8193,324,341061,1044,1044,1073741824,4164,4294967296,5445,4295065770,4097,649]

theorem envBound3840 : H12AffineFastState.Bounded env3840 := by
  intro p hp
  have h : env3840.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3796_3840 : H12AffineEnvironment.transform 21 73729 env3796 = env3840 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 73729 env3796 == env3840) = true)

theorem identity3840 : scanCanonicalize (H12AffineFastState.compose env3840 (packedSelected [1,3,5,7,8,10,19,20,27] rootPS)) = affineNative (2^(29+1) ^^^ 100354) := by decide +kernel

theorem selectedBound3840 : packedSelected [1,3,5,7,8,10,19,20,27] rootPS < 2^1333 := by decide +kernel

def env3841 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,78028,32768,4097,73729,5457,98305,8193,324,341061,1044,1044,100354,4164,4294967296,5445,4295065770,4097,649]

theorem envBound3841 : H12AffineFastState.Bounded env3841 := by
  intro p hp
  have h : env3841.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3840_3841 : H12AffineEnvironment.transform 29 100354 env3840 = env3841 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 100354 env3840 == env3841) = true)

def env3842 : List Nat := [2,4,8,16,32,64,8,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,77892,32768,4097,73729,5457,98305,8193,324,341061,1044,1044,100354,4164,4294967296,5445,4295065634,4097,513]

theorem envBound3842 : H12AffineFastState.Bounded env3842 := by
  intro p hp
  have h : env3842.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3841_3842 : H12AffineEnvironment.transform 6 8 env3841 = env3842 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env3841 == env3842) = true)

def env3843 : List Nat := [2,4,8,16,32,64,8,4,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,77892,32768,4097,73729,5205,98305,8193,64,341061,1044,1044,100354,4164,4294967296,5185,4295065634,4097,513]

theorem envBound3843 : H12AffineFastState.Bounded env3843 := by
  intro p hp
  have h : env3843.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3842_3843 : H12AffineEnvironment.transform 7 4 env3842 = env3843 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env3842 == env3843) = true)

theorem identity3843 : scanCanonicalize (H12AffineFastState.compose env3843 (packedSelected [3,15,17] rootPS)) = affineNative (2^(17+1) ^^^ 2091) := by decide +kernel

theorem selectedBound3843 : packedSelected [3,15,17] rootPS < 2^1333 := by decide +kernel

def env3844 : List Nat := [2,4,8,16,32,64,8,4,512,1024,2048,4096,8192,4176,32768,65536,4096,2091,77892,32768,4097,73729,5205,98305,8193,64,81006,1044,1044,100354,4164,4294967296,5185,4295065634,4097,513]

theorem envBound3844 : H12AffineFastState.Bounded env3844 := by
  intro p hp
  have h : env3844.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3843_3844 : H12AffineEnvironment.transform 17 2091 env3843 = env3844 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2091 env3843 == env3844) = true)

theorem identity3844 : scanCanonicalize (H12AffineFastState.compose env3844 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(11+1) ^^^ 1604) := by decide +kernel

theorem selectedBound3844 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env3845 : List Nat := [2,4,8,16,32,64,8,4,512,1024,2048,1604,8192,1556,32768,65536,1604,2091,75264,32768,1605,73729,529,98305,8193,64,76330,1044,1044,100354,1536,4294967296,517,4295065634,1605,513]

theorem envBound3845 : H12AffineFastState.Bounded env3845 := by
  intro p hp
  have h : env3845.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3844_3845 : H12AffineEnvironment.transform 11 1604 env3844 = env3845 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1604 env3844 == env3845) = true)

theorem identity3845 : scanCanonicalize (H12AffineFastState.compose env3845 (packedSelected [1,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 8706) := by decide +kernel

theorem selectedBound3845 : packedSelected [1,12,13] rootPS < 2^1333 := by decide +kernel

def env3846 : List Nat := [2,4,8,16,32,64,8,4,512,1024,2048,1604,8192,1556,8706,65536,1604,2091,75264,8706,1605,73729,529,74243,8193,64,76330,1044,1044,76288,1536,4294967296,517,4295041568,1605,513]

theorem envBound3846 : H12AffineFastState.Bounded env3846 := by
  intro p hp
  have h : env3846.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3845_3846 : H12AffineEnvironment.transform 14 8706 env3845 = env3846 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8706 env3845 == env3846) = true)

def env3847 : List Nat := [2,4,8,16,32,64,8,4,512,1024,2048,1604,8192,1556,8706,2056,1604,2091,11784,8706,1605,10249,529,10763,8193,64,8738,1044,1044,8712,1536,4294967296,517,4294978088,1605,513]

theorem envBound3847 : H12AffineFastState.Bounded env3847 := by
  intro p hp
  have h : env3847.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3846_3847 : H12AffineEnvironment.transform 15 2056 env3846 = env3847 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2056 env3846 == env3847) = true)

theorem identity3847 : scanCanonicalize (H12AffineFastState.compose env3847 (packedSelected [0,6] rootPS)) = affineNative (2^(12+1) ^^^ 2569) := by decide +kernel

theorem selectedBound3847 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env3848 : List Nat := [2,4,8,16,32,64,8,4,512,1024,2048,1604,2569,1556,2059,2056,1604,2091,1025,2059,1605,512,529,2,2568,64,2091,1044,1044,2049,1536,4294967296,517,4294967329,1605,513]

theorem envBound3848 : H12AffineFastState.Bounded env3848 := by
  intro p hp
  have h : env3848.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3847_3848 : H12AffineEnvironment.transform 12 2569 env3847 = env3848 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2569 env3847 == env3848) = true)

theorem identity3848 : scanCanonicalize (H12AffineFastState.compose env3848 (packedSelected [2,4] rootPS)) = affineNative (2^(5+1) ^^^ 58) := by decide +kernel

theorem selectedBound3848 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env3849 : List Nat := [2,4,8,16,32,58,8,4,512,1024,2048,1598,2569,1556,2059,2056,1598,2091,1025,2059,1599,512,529,2,2568,58,2091,1044,1044,2049,1536,4294967296,517,4294967329,1599,513]

theorem envBound3849 : H12AffineFastState.Bounded env3849 := by
  intro p hp
  have h : env3849.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3848_3849 : H12AffineEnvironment.transform 5 58 env3848 = env3849 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 58 env3848 == env3849) = true)

def env3850 : List Nat := [2,4,8,16,32,64,8,4,512,1024,2048,1604,8192,1556,8706,2057,1604,2091,11785,8706,1605,10248,529,10762,8193,64,8739,1044,1044,8713,1536,4294967296,517,4294978089,1605,513]

theorem envBound3850 : H12AffineFastState.Bounded env3850 := by
  intro p hp
  have h : env3850.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3846_3850 : H12AffineEnvironment.transform 15 2057 env3846 = env3850 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2057 env3846 == env3850) = true)

def env3851 : List Nat := [2,4,8,16,32,64,8,5,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,77892,32768,4097,73729,5204,98305,8193,65,341061,1044,1044,100354,4164,4294967296,5184,4295065634,4097,513]

theorem envBound3851 : H12AffineFastState.Bounded env3851 := by
  intro p hp
  have h : env3851.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3842_3851 : H12AffineEnvironment.transform 7 5 env3842 = env3851 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env3842 == env3851) = true)

theorem identity3851 : scanCanonicalize (H12AffineFastState.compose env3851 (packedSelected [3,15,17] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound3851 : packedSelected [3,15,17] rootPS < 2^1333 := by decide +kernel

def env3852 : List Nat := [2,4,8,16,0,64,8,5,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,77892,32768,4097,73729,5204,98305,8193,65,341061,1044,1044,100354,4164,4294967296,5184,4295065602,4097,513]

theorem envBound3852 : H12AffineFastState.Bounded env3852 := by
  intro p hp
  have h : env3852.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3851_3852 : H12AffineEnvironment.transform 4 0 env3851 = env3852 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env3851 == env3852) = true)

theorem identity3852 : scanCanonicalize (H12AffineFastState.compose env3852 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(11+1) ^^^ 1557) := by decide +kernel

theorem selectedBound3852 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env3853 : List Nat := [2,4,8,16,0,64,8,5,512,1024,2048,1557,8192,1605,32768,65536,1557,262144,75345,32768,1556,73729,577,98305,8193,65,336464,1044,1044,100354,1617,4294967296,597,4295065602,1556,513]

theorem envBound3853 : H12AffineFastState.Bounded env3853 := by
  intro p hp
  have h : env3853.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3852_3853 : H12AffineEnvironment.transform 11 1557 env3852 = env3853 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1557 env3852 == env3853) = true)

theorem identity3853 : scanCanonicalize (H12AffineFastState.compose env3853 (packedSelected [4,16,22] rootPS)) = affineNative (2^(15+1) ^^^ 8193) := by decide +kernel

theorem selectedBound3853 : packedSelected [4,16,22] rootPS < 2^1333 := by decide +kernel

def env3854 : List Nat := [2,4,8,16,0,64,8,5,512,1024,2048,1557,8192,1605,32768,8193,1557,262144,1616,32768,1556,0,577,40960,8193,65,262737,1044,1044,43011,1617,4294967296,597,4295008259,1556,513]

theorem envBound3854 : H12AffineFastState.Bounded env3854 := by
  intro p hp
  have h : env3854.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3853_3854 : H12AffineEnvironment.transform 15 8193 env3853 = env3854 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8193 env3853 == env3854) = true)

theorem identity3854 : scanCanonicalize (H12AffineFastState.compose env3854 (packedSelected [4,9,16] rootPS)) = affineNative (2^(8+1) ^^^ 80) := by decide +kernel

theorem selectedBound3854 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env3855 : List Nat := [2,4,8,16,0,64,8,5,80,1024,2048,1093,8192,1045,32768,8193,1093,262144,1024,32768,1092,0,17,40960,8193,65,262145,1044,1044,43011,1025,4294967296,5,4295008259,1092,81]

theorem envBound3855 : H12AffineFastState.Bounded env3855 := by
  intro p hp
  have h : env3855.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3854_3855 : H12AffineEnvironment.transform 8 80 env3854 = env3855 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 80 env3854 == env3855) = true)

theorem identity3855 : scanCanonicalize (H12AffineFastState.compose env3855 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 270419) := by decide +kernel

theorem selectedBound3855 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env3856 : List Nat := [2,4,8,16,0,64,8,5,80,1024,2048,1093,8192,1045,32768,8193,1093,262144,1024,32768,1092,0,17,40960,8193,65,262145,1044,1044,43011,1025,270419,5,294992,1092,81]

theorem envBound3856 : H12AffineFastState.Bounded env3856 := by
  intro p hp
  have h : env3856.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3855_3856 : H12AffineEnvironment.transform 31 270419 env3855 = env3856 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 270419 env3855 == env3856) = true)

theorem identity3856 : scanCanonicalize (H12AffineFastState.compose env3856 (packedSelected [7] rootPS)) = affineNative (2^(17+1) ^^^ 8216) := by decide +kernel

theorem selectedBound3856 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env3857 : List Nat := [2,4,8,16,0,64,8,5,80,1024,2048,1093,8192,1045,32768,8193,1093,8216,1024,32768,1092,0,17,40960,8193,65,8217,1044,1044,43011,1025,75,5,41032,1092,81]

theorem envBound3857 : H12AffineFastState.Bounded env3857 := by
  intro p hp
  have h : env3857.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3856_3857 : H12AffineEnvironment.transform 17 8216 env3856 = env3857 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 8216 env3856 == env3857) = true)

theorem identity3857 : scanCanonicalize (H12AffineFastState.compose env3857 (packedSelected [3,5,10] rootPS)) = affineNative (2^(5+1) ^^^ 27) := by decide +kernel

theorem selectedBound3857 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env3858 : List Nat := [2,4,8,16,0,27,8,5,11,1024,2048,1054,8192,1045,32768,8193,1054,8216,1024,32768,1055,0,17,40960,8193,26,8217,1044,1044,43011,1025,16,5,40979,1055,10]

theorem envBound3858 : H12AffineFastState.Bounded env3858 := by
  intro p hp
  have h : env3858.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3857_3858 : H12AffineEnvironment.transform 5 27 env3857 = env3858 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 27 env3857 == env3858) = true)

theorem identity3858 : scanCanonicalize (H12AffineFastState.compose env3858 (packedSelected [2,4,9] rootPS)) = affineNative (2^(14+1) ^^^ 8211) := by decide +kernel

theorem selectedBound3858 : packedSelected [2,4,9] rootPS < 2^1333 := by decide +kernel

def env3859 : List Nat := [2,4,8,16,0,27,8,5,11,1024,2048,1054,8192,1045,8211,8193,1054,8216,1024,8211,1055,0,17,19,8193,26,8217,1044,1044,2064,1025,16,5,0,1055,10]

theorem envBound3859 : H12AffineFastState.Bounded env3859 := by
  intro p hp
  have h : env3859.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3858_3859 : H12AffineEnvironment.transform 14 8211 env3858 = env3859 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8211 env3858 == env3859) = true)

theorem identity3859 : scanCanonicalize (H12AffineFastState.compose env3859 (packedSelected [1,3,4,5,11] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound3859 : packedSelected [1,3,4,5,11] rootPS < 2^1333 := by decide +kernel

def env3860 : List Nat := [2,4,3,16,0,16,3,5,0,1024,2048,1045,8192,1045,8211,8193,1045,8211,1024,8211,1044,0,17,19,8193,17,8210,1044,1044,2064,1025,16,5,0,1044,1]

theorem envBound3860 : H12AffineFastState.Bounded env3860 := by
  intro p hp
  have h : env3860.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3859_3860 : H12AffineEnvironment.transform 2 3 env3859 = env3860 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env3859 == env3860) = true)

theorem identity3860 : scanCanonicalize (H12AffineFastState.compose env3860 (packedSelected [1,3,5] rootPS)) = affineNative (2^(12+1) ^^^ 2067) := by decide +kernel

theorem selectedBound3860 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env3861 : List Nat := [2,4,3,16,0,16,3,5,0,1024,2048,1045,2067,1045,2048,2066,1045,2048,1024,2048,1044,0,17,19,2066,17,2049,1044,1044,2064,1025,16,5,0,1044,1]

theorem envBound3861 : H12AffineFastState.Bounded env3861 := by
  intro p hp
  have h : env3861.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3860_3861 : H12AffineEnvironment.transform 12 2067 env3860 = env3861 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2067 env3860 == env3861) = true)

theorem identity3861 : scanCanonicalize (H12AffineFastState.compose env3861 (packedSelected [0,2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound3861 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env3862 : List Nat := [2,4,3,0,0,0,3,5,0,1024,2048,1029,2051,1029,2048,2050,1029,2048,1024,2048,1028,0,1,3,2050,1,2049,1028,1028,2048,1025,0,5,0,1028,1]

theorem envBound3862 : H12AffineFastState.Bounded env3862 := by
  intro p hp
  have h : env3862.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3861_3862 : H12AffineEnvironment.transform 3 0 env3861 = env3862 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env3861 == env3862) = true)

def env3863 : List Nat := [2,4,8,16,32,64,9,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,77893,32768,4097,73729,5457,98305,8193,324,341061,1044,1044,100354,4164,4294967296,5445,4295065635,4097,512]

theorem envBound3863 : H12AffineFastState.Bounded env3863 := by
  intro p hp
  have h : env3863.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3841_3863 : H12AffineEnvironment.transform 6 9 env3841 = env3863 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env3841 == env3863) = true)

theorem identity3863 : scanCanonicalize (H12AffineFastState.compose env3863 (packedSelected [1,3,4,5,8,9,10,16,19] rootPS)) = affineNative (2^(15+1) ^^^ 13381) := by decide +kernel

theorem selectedBound3863 : packedSelected [1,3,4,5,8,9,10,16,19] rootPS < 2^1333 := by decide +kernel

def env3864 : List Nat := [2,4,8,16,32,64,9,256,512,1024,2048,4096,8192,4176,32768,13381,4096,262144,1024,32768,4097,5188,5457,46148,8193,324,262144,1044,1044,48199,4164,4294967296,5445,4295013478,4097,512]

theorem envBound3864 : H12AffineFastState.Bounded env3864 := by
  intro p hp
  have h : env3864.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3863_3864 : H12AffineEnvironment.transform 15 13381 env3863 = env3864 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13381 env3863 == env3864) = true)

theorem identity3864 : scanCanonicalize (H12AffineFastState.compose env3864 (packedSelected [0,4,7,16,20,22] rootPS)) = affineNative (2^(14+1) ^^^ 13388) := by decide +kernel

theorem selectedBound3864 : packedSelected [0,4,7,16,20,22] rootPS < 2^1333 := by decide +kernel

def env3865 : List Nat := [2,4,8,16,32,64,9,256,512,1024,2048,4096,8192,4176,13388,13381,4096,262144,1024,13388,4097,5188,5457,8,8193,324,262144,1044,1044,2059,4164,4294967296,5445,4294967338,4097,512]

theorem envBound3865 : H12AffineFastState.Bounded env3865 := by
  intro p hp
  have h : env3865.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3864_3865 : H12AffineEnvironment.transform 14 13388 env3864 = env3865 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13388 env3864 == env3865) = true)

theorem identity3865 : scanCanonicalize (H12AffineFastState.compose env3865 (packedSelected [6,25] rootPS)) = affineNative (2^(11+1) ^^^ 1093) := by decide +kernel

theorem selectedBound3865 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env3866 : List Nat := [2,4,8,16,32,64,9,256,512,1024,2048,1093,8192,1045,8201,8192,1093,262144,1024,8201,1092,1,276,8,8193,324,262144,1044,1044,2059,1025,4294967296,256,4294967338,1092,512]

theorem envBound3866 : H12AffineFastState.Bounded env3866 := by
  intro p hp
  have h : env3866.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3865_3866 : H12AffineEnvironment.transform 11 1093 env3865 = env3866 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1093 env3865 == env3866) = true)

def env3867 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,524288,32768,4097,4194304,5457,16777216,4259841,16875844,4461637,16876564,16876565,1073741824,4165,4294967296,16880965,4295536742,4096,4268681]

theorem envBound3867 : H12AffineFastState.Bounded env3867 := by
  intro p hp
  have h : env3867.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3743_3867 : H12AffineEnvironment.transform 16 4097 env3743 = env3867 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env3743 == env3867) = true)

def env3868 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,524288,32768,4097,4194304,5457,98304,4259841,324,4461637,1044,1045,1073741824,4165,4294967296,5445,4295536742,4096,4268681]

theorem envBound3868 : H12AffineFastState.Bounded env3868 := by
  intro p hp
  have h : env3868.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3867_3868 : H12AffineEnvironment.transform 23 98304 env3867 = env3868 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98304 env3867 == env3868) = true)

theorem identity3868 : scanCanonicalize (H12AffineFastState.compose env3868 (packedSelected [3,5,24] rootPS)) = affineNative (2^(21+1) ^^^ 909) := by decide +kernel

theorem selectedBound3868 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env3869 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,524288,32768,4097,909,5457,98304,66444,324,268232,1044,1045,1073741824,4165,4294967296,5445,4295536742,4096,73988]

theorem envBound3869 : H12AffineFastState.Bounded env3869 := by
  intro p hp
  have h : env3869.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3868_3869 : H12AffineEnvironment.transform 21 909 env3868 = env3869 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 909 env3868 == env3869) = true)

def env3870 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,524288,32768,4097,909,5457,98304,66444,324,268232,1044,1045,360608,4165,4294967296,5445,4295536742,4096,73988]

theorem envBound3870 : H12AffineFastState.Bounded env3870 := by
  intro p hp
  have h : env3870.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3869_3870 : H12AffineEnvironment.transform 29 360608 env3869 = env3870 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360608 env3869 == env3870) = true)

theorem identity3870 : scanCanonicalize (H12AffineFastState.compose env3870 (packedSelected [3,5,8,17,21,28] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound3870 : packedSelected [3,5,8,17,21,28] rootPS < 2^1333 := by decide +kernel

def env3871 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,4097,262144,524288,32768,4097,909,5377,98304,66444,276,268184,1044,1045,360608,4117,4294967296,5397,4295536694,4096,73988]

theorem envBound3871 : H12AffineFastState.Bounded env3871 := by
  intro p hp
  have h : env3871.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3870_3871 : H12AffineEnvironment.transform 5 16 env3870 = env3871 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env3870 == env3871) = true)

def env3872 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,524288,32768,4097,909,5457,98304,66444,324,268232,1044,1045,360609,4165,4294967296,5445,4295536742,4096,73988]

theorem envBound3872 : H12AffineFastState.Bounded env3872 := by
  intro p hp
  have h : env3872.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3869_3872 : H12AffineEnvironment.transform 29 360609 env3869 = env3872 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360609 env3869 == env3872) = true)

theorem identity3872 : scanCanonicalize (H12AffineFastState.compose env3872 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(17+1) ^^^ 48237) := by decide +kernel

theorem selectedBound3872 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env3873 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,48237,524288,32768,4097,909,5457,98304,66444,324,43941,1044,1045,81100,4165,4294967296,5445,4295536742,4096,73988]

theorem envBound3873 : H12AffineFastState.Bounded env3873 := by
  intro p hp
  have h : env3873.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3872_3873 : H12AffineEnvironment.transform 17 48237 env3872 = env3873 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 48237 env3872 == env3873) = true)

def env3874 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4176,32768,65536,4097,48237,524288,32768,4097,649,5205,98304,66184,64,43681,1044,1045,81100,4165,4294967296,5185,4295536742,4096,73728]

theorem envBound3874 : H12AffineFastState.Bounded env3874 := by
  intro p hp
  have h : env3874.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3873_3874 : H12AffineEnvironment.transform 7 4 env3873 = env3874 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env3873 == env3874) = true)

theorem identity3874 : scanCanonicalize (H12AffineFastState.compose env3874 (packedSelected [10,12,13,15,17,19] rootPS)) = affineNative (2^(14+1) ^^^ 8842) := by decide +kernel

theorem selectedBound3874 : packedSelected [10,12,13,15,17,19] rootPS < 2^1333 := by decide +kernel

def env3875 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4176,8842,65536,4097,7911,524288,8842,4097,649,5205,74378,66184,64,2091,1044,1045,81100,4165,4294967296,5185,4295496428,4096,73728]

theorem envBound3875 : H12AffineFastState.Bounded env3875 := by
  intro p hp
  have h : env3875.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3874_3875 : H12AffineEnvironment.transform 14 8842 env3874 = env3875 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8842 env3874 == env3875) = true)

theorem identity3875 : scanCanonicalize (H12AffineFastState.compose env3875 (packedSelected [11,18,20] rootPS)) = affineNative (2^(11+1) ^^^ 1093) := by decide +kernel

theorem selectedBound3875 : packedSelected [11,18,20] rootPS < 2^1333 := by decide +kernel

def env3876 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1093,8192,1045,8842,65536,1092,2722,524288,8842,1092,649,16,74378,66184,64,2091,1044,1045,75913,1024,4294967296,4,4295493289,1093,73728]

theorem envBound3876 : H12AffineFastState.Bounded env3876 := by
  intro p hp
  have h : env3876.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3875_3876 : H12AffineEnvironment.transform 11 1093 env3875 = env3876 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1093 env3875 == env3876) = true)

theorem identity3876 : scanCanonicalize (H12AffineFastState.compose env3876 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(18+1) ^^^ 1667) := by decide +kernel

theorem selectedBound3876 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env3877 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1093,8192,1045,8842,65536,1092,2722,1667,8842,1092,649,16,74378,66184,64,2091,1044,1045,75913,1024,4294967296,4,4294967338,1093,73728]

theorem envBound3877 : H12AffineFastState.Bounded env3877 := by
  intro p hp
  have h : env3877.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3876_3877 : H12AffineEnvironment.transform 18 1667 env3876 = env3877 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1667 env3876 == env3877) = true)

theorem identity3877 : scanCanonicalize (H12AffineFastState.compose env3877 (packedSelected [5,12,13,15,21] rootPS)) = affineNative (2^(15+1) ^^^ 8322) := by decide +kernel

theorem selectedBound3877 : packedSelected [5,12,13,15,21] rootPS < 2^1333 := by decide +kernel

def env3878 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1093,8192,1045,8842,8322,1092,2722,1667,8842,1092,649,16,520,8714,64,2091,1044,1045,2059,1024,4294967296,4,4294967338,1093,130]

theorem envBound3878 : H12AffineFastState.Bounded env3878 := by
  intro p hp
  have h : env3878.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3877_3878 : H12AffineEnvironment.transform 15 8322 env3877 = env3878 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8322 env3877 == env3878) = true)

theorem identity3878 : scanCanonicalize (H12AffineFastState.compose env3878 (packedSelected [2,4,7,11,16] rootPS)) = affineNative (2^(31+1) ^^^ 10881) := by decide +kernel

theorem selectedBound3878 : packedSelected [2,4,7,11,16] rootPS < 2^1333 := by decide +kernel

def env3879 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1093,8192,1045,8842,8322,1092,2722,1667,8842,1092,649,16,520,8714,64,2091,1044,1045,2059,1024,10881,4,10923,1093,130]

theorem envBound3879 : H12AffineFastState.Bounded env3879 := by
  intro p hp
  have h : env3879.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3878_3879 : H12AffineEnvironment.transform 31 10881 env3878 = env3879 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 10881 env3878 == env3879) = true)

def env3880 : List Nat := [2,4,8,16,32,64,128,4,512,1024,168,1093,8192,1045,8842,8322,1092,522,1667,8842,1092,649,16,520,8714,64,131,1044,1045,163,1024,8745,4,8707,1093,130]

theorem envBound3880 : H12AffineFastState.Bounded env3880 := by
  intro p hp
  have h : env3880.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3879_3880 : H12AffineEnvironment.transform 10 168 env3879 = env3880 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 168 env3879 == env3880) = true)

theorem identity3880 : scanCanonicalize (H12AffineFastState.compose env3880 (packedSelected [6] rootPS)) = affineNative (2^(8+1) ^^^ 217) := by decide +kernel

theorem selectedBound3880 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env3881 : List Nat := [2,4,8,16,32,64,128,4,217,1024,168,1093,8192,1045,8275,8322,1092,211,1114,8275,1092,80,16,209,8403,64,131,1044,1045,163,1024,8432,4,8410,1093,130]

theorem envBound3881 : H12AffineFastState.Bounded env3881 := by
  intro p hp
  have h : env3881.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3880_3881 : H12AffineEnvironment.transform 8 217 env3880 = env3881 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 217 env3880 == env3881) = true)

theorem identity3881 : scanCanonicalize (H12AffineFastState.compose env3881 (packedSelected [2,7,9,10,11,12,13] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound3881 : packedSelected [2,7,9,10,11,12,13] rootPS < 2^1333 := by decide +kernel

def env3882 : List Nat := [2,4,8,16,32,17,128,4,136,1024,168,1044,8192,1045,8194,8322,1045,130,1035,8194,1045,1,16,128,8322,17,131,1044,1045,163,1024,8353,4,8331,1044,130]

theorem envBound3882 : H12AffineFastState.Bounded env3882 := by
  intro p hp
  have h : env3882.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3881_3882 : H12AffineEnvironment.transform 5 17 env3881 = env3882 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env3881 == env3882) = true)

theorem identity3882 : scanCanonicalize (H12AffineFastState.compose env3882 (packedSelected [0,1,3,4] rootPS)) = affineNative (2^(12+1) ^^^ 160) := by decide +kernel

theorem selectedBound3882 : packedSelected [0,1,3,4] rootPS < 2^1333 := by decide +kernel

def env3883 : List Nat := [2,4,8,16,32,17,128,4,136,1024,168,1044,160,1045,162,34,1045,130,1035,162,1045,1,16,128,34,17,131,1044,1045,163,1024,1,4,43,1044,130]

theorem envBound3883 : H12AffineFastState.Bounded env3883 := by
  intro p hp
  have h : env3883.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3882_3883 : H12AffineEnvironment.transform 12 160 env3882 = env3883 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 160 env3882 == env3883) = true)

theorem identity3883 : scanCanonicalize (H12AffineFastState.compose env3883 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound3883 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3884 : List Nat := [2,4,2,16,32,17,128,4,130,1024,162,1044,160,1045,162,34,1045,130,1025,162,1045,1,16,128,34,17,131,1044,1045,163,1024,1,4,33,1044,130]

theorem envBound3884 : H12AffineFastState.Bounded env3884 := by
  intro p hp
  have h : env3884.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3883_3884 : H12AffineEnvironment.transform 2 2 env3883 = env3884 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env3883 == env3884) = true)

theorem identity3884 : scanCanonicalize (H12AffineFastState.compose env3884 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 16) := by decide +kernel

theorem selectedBound3884 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3885 : List Nat := [2,4,2,16,32,17,16,4,18,1024,50,1044,48,1045,50,34,1045,18,1025,50,1045,1,16,16,34,17,19,1044,1045,51,1024,1,4,33,1044,18]

theorem envBound3885 : H12AffineFastState.Bounded env3885 := by
  intro p hp
  have h : env3885.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3884_3885 : H12AffineEnvironment.transform 6 16 env3884 = env3885 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 16 env3884 == env3885) = true)

theorem identity3885 : scanCanonicalize (H12AffineFastState.compose env3885 (packedSelected [1] rootPS)) = affineNative (2^(9+1) ^^^ 36) := by decide +kernel

theorem selectedBound3885 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3886 : List Nat := [2,4,2,16,32,17,16,4,18,36,50,48,48,49,50,34,49,18,37,50,49,1,16,16,34,17,19,48,49,51,36,1,4,33,48,18]

theorem envBound3886 : H12AffineFastState.Bounded env3886 := by
  intro p hp
  have h : env3886.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3885_3886 : H12AffineEnvironment.transform 9 36 env3885 = env3886 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 36 env3885 == env3886) = true)

theorem identity3886 : scanCanonicalize (H12AffineFastState.compose env3886 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 18) := by decide +kernel

theorem selectedBound3886 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env3887 : List Nat := [2,4,2,16,18,17,16,4,18,22,0,2,2,3,0,16,3,18,23,0,3,1,16,16,16,17,19,2,3,1,22,1,4,19,2,18]

theorem envBound3887 : H12AffineFastState.Bounded env3887 := by
  intro p hp
  have h : env3887.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3886_3887 : H12AffineEnvironment.transform 4 18 env3886 = env3887 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 18 env3886 == env3887) = true)

def env3888 : List Nat := [2,4,8,16,32,64,128,4,512,1024,169,1093,8192,1045,8842,8322,1092,523,1667,8842,1092,649,16,520,8714,64,130,1044,1045,162,1024,8744,4,8706,1093,130]

theorem envBound3888 : H12AffineFastState.Bounded env3888 := by
  intro p hp
  have h : env3888.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3879_3888 : H12AffineEnvironment.transform 10 169 env3879 = env3888 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 169 env3879 == env3888) = true)

theorem identity3888 : scanCanonicalize (H12AffineFastState.compose env3888 (packedSelected [6] rootPS)) = affineNative (2^(5+1) ^^^ 26) := by decide +kernel

theorem selectedBound3888 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env3889 : List Nat := [2,4,8,16,32,26,128,4,512,1024,169,1055,8192,1045,8842,8322,1054,523,1667,8842,1054,649,16,520,8714,26,130,1044,1045,162,1024,8744,4,8706,1055,130]

theorem envBound3889 : H12AffineFastState.Bounded env3889 := by
  intro p hp
  have h : env3889.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3888_3889 : H12AffineEnvironment.transform 5 26 env3888 = env3889 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 26 env3888 == env3889) = true)

theorem identity3889 : scanCanonicalize (H12AffineFastState.compose env3889 (packedSelected [1,2,3,7,9,11] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound3889 : packedSelected [1,2,3,7,9,11] rootPS < 2^1333 := by decide +kernel

def env3890 : List Nat := [2,4,8,16,1,26,128,4,512,1024,136,1055,8192,1045,8842,8322,1054,523,1667,8842,1054,649,16,520,8714,26,130,1044,1045,131,1024,8713,4,8706,1055,130]

theorem envBound3890 : H12AffineFastState.Bounded env3890 := by
  intro p hp
  have h : env3890.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3889_3890 : H12AffineEnvironment.transform 4 1 env3889 = env3890 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env3889 == env3890) = true)

theorem identity3890 : scanCanonicalize (H12AffineFastState.compose env3890 (packedSelected [0,7] rootPS)) = affineNative (2^(12+1) ^^^ 515) := by decide +kernel

theorem selectedBound3890 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env3891 : List Nat := [2,4,8,16,1,26,128,4,512,1024,136,1055,515,1045,137,641,1054,523,1667,137,1054,649,16,520,9,26,130,1044,1045,131,1024,10,4,1,1055,130]

theorem envBound3891 : H12AffineFastState.Bounded env3891 := by
  intro p hp
  have h : env3891.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3890_3891 : H12AffineEnvironment.transform 12 515 env3890 = env3891 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 515 env3890 == env3891) = true)

theorem identity3891 : scanCanonicalize (H12AffineFastState.compose env3891 (packedSelected [0,1,2,3,4] rootPS)) = affineNative (2^(8+1) ^^^ 130) := by decide +kernel

theorem selectedBound3891 : packedSelected [0,1,2,3,4] rootPS < 2^1333 := by decide +kernel

def env3892 : List Nat := [2,4,8,16,1,26,128,4,130,1024,136,1055,129,1045,137,3,1054,137,1025,137,1054,11,16,138,9,26,130,1044,1045,131,1024,10,4,1,1055,130]

theorem envBound3892 : H12AffineFastState.Bounded env3892 := by
  intro p hp
  have h : env3892.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3891_3892 : H12AffineEnvironment.transform 8 130 env3891 = env3892 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 130 env3891 == env3892) = true)

theorem identity3892 : scanCanonicalize (H12AffineFastState.compose env3892 (packedSelected [0,1] rootPS)) = affineNative (2^(9+1) ^^^ 23) := by decide +kernel

theorem selectedBound3892 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env3893 : List Nat := [2,4,8,16,1,26,128,4,130,23,136,8,129,2,137,3,9,137,22,137,9,11,16,138,9,26,130,3,2,131,23,10,4,1,8,130]

theorem envBound3893 : H12AffineFastState.Bounded env3893 := by
  intro p hp
  have h : env3893.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3892_3893 : H12AffineEnvironment.transform 9 23 env3892 = env3893 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 23 env3892 == env3893) = true)

theorem identity3893 : scanCanonicalize (H12AffineFastState.compose env3893 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound3893 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3894 : List Nat := [2,4,2,16,1,16,128,4,130,23,130,2,129,2,131,3,3,131,22,131,3,1,16,128,3,16,130,3,2,131,23,0,4,1,2,130]

theorem envBound3894 : H12AffineFastState.Bounded env3894 := by
  intro p hp
  have h : env3894.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3893_3894 : H12AffineEnvironment.transform 2 2 env3893 = env3894 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env3893 == env3894) = true)

theorem identity3894 : scanCanonicalize (H12AffineFastState.compose env3894 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 16) := by decide +kernel

theorem selectedBound3894 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3895 : List Nat := [2,4,2,16,1,16,16,4,18,23,18,2,17,2,19,3,3,19,22,19,3,1,16,16,3,16,18,3,2,19,23,0,4,1,2,18]

theorem envBound3895 : H12AffineFastState.Bounded env3895 := by
  intro p hp
  have h : env3895.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3894_3895 : H12AffineEnvironment.transform 6 16 env3894 = env3895 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 16 env3894 == env3895) = true)

theorem identity3895 : scanCanonicalize (H12AffineFastState.compose env3895 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound3895 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env3896 : List Nat := [2,4,2,2,1,2,2,4,0,5,0,2,3,2,1,3,3,1,4,1,3,1,2,2,3,2,0,3,2,1,5,0,4,1,2,0]

theorem envBound3896 : H12AffineFastState.Bounded env3896 := by
  intro p hp
  have h : env3896.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3895_3896 : H12AffineEnvironment.transform 3 2 env3895 = env3896 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env3895 == env3896) = true)

def env3897 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,4096,8192,4176,32768,65536,4097,48237,524288,32768,4097,648,5204,98304,66185,65,43680,1044,1045,81100,4165,4294967296,5184,4295536742,4096,73729]

theorem envBound3897 : H12AffineFastState.Bounded env3897 := by
  intro p hp
  have h : env3897.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3873_3897 : H12AffineEnvironment.transform 7 5 env3873 = env3897 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env3873 == env3897) = true)

theorem identity3897 : scanCanonicalize (H12AffineFastState.compose env3897 (packedSelected [5,12,13,15,21] rootPS)) = affineNative (2^(15+1) ^^^ 8704) := by decide +kernel

theorem selectedBound3897 : packedSelected [5,12,13,15,21] rootPS < 2^1333 := by decide +kernel

def env3898 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,4096,8192,4176,32768,8704,4097,48237,524288,32768,4097,648,5204,41472,8329,65,43680,1044,1045,7884,4165,4294967296,5184,4295536742,4096,513]

theorem envBound3898 : H12AffineFastState.Bounded env3898 := by
  intro p hp
  have h : env3898.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3897_3898 : H12AffineEnvironment.transform 15 8704 env3897 = env3898 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8704 env3897 == env3898) = true)

theorem identity3898 : scanCanonicalize (H12AffineFastState.compose env3898 (packedSelected [0,1,4,5,7,8,9,12,13] rootPS)) = affineNative (2^(18+1) ^^^ 45127) := by decide +kernel

theorem selectedBound3898 : packedSelected [0,1,4,5,7,8,9,12,13] rootPS < 2^1333 := by decide +kernel

def env3899 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,4096,8192,4176,32768,8704,4097,48237,45127,32768,4097,648,5204,41472,8329,65,43680,1044,1045,7884,4165,4294967296,5184,4294967329,4096,513]

theorem envBound3899 : H12AffineFastState.Bounded env3899 := by
  intro p hp
  have h : env3899.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3898_3899 : H12AffineEnvironment.transform 18 45127 env3898 = env3899 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 45127 env3898 == env3899) = true)

theorem identity3899 : scanCanonicalize (H12AffineFastState.compose env3899 (packedSelected [0,7,16] rootPS)) = affineNative (2^(11+1) ^^^ 1740) := by decide +kernel

theorem selectedBound3899 : packedSelected [0,7,16] rootPS < 2^1333 := by decide +kernel

def env3900 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1740,8192,1692,32768,8704,1741,43681,42635,32768,1741,648,664,41472,8329,65,43680,1044,1045,2048,1673,4294967296,652,4294967329,1740,513]

theorem envBound3900 : H12AffineFastState.Bounded env3900 := by
  intro p hp
  have h : env3900.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3899_3900 : H12AffineEnvironment.transform 11 1740 env3899 = env3900 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1740 env3899 == env3900) = true)

def env3901 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,524288,32768,4097,4194304,5457,98305,4259841,325,4461637,1045,1044,1073741824,4165,4294967296,5444,4295536742,4096,4268681]

theorem envBound3901 : H12AffineFastState.Bounded env3901 := by
  intro p hp
  have h : env3901.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3867_3901 : H12AffineEnvironment.transform 23 98305 env3867 = env3901 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98305 env3867 == env3901) = true)

theorem identity3901 : scanCanonicalize (H12AffineFastState.compose env3901 (packedSelected [3,5,24] rootPS)) = affineNative (2^(21+1) ^^^ 526221) := by decide +kernel

theorem selectedBound3901 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env3902 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,524288,32768,4097,526221,5457,98305,591756,325,791496,1045,1044,1073741824,4165,4294967296,5444,4295536742,4096,599300]

theorem envBound3902 : H12AffineFastState.Bounded env3902 := by
  intro p hp
  have h : env3902.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3901_3902 : H12AffineEnvironment.transform 21 526221 env3901 = env3902 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 526221 env3901 == env3902) = true)

def env3903 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,524288,32768,4097,526221,5457,98305,591756,325,791496,1045,1044,360608,4165,4294967296,5444,4295536742,4096,599300]

theorem envBound3903 : H12AffineFastState.Bounded env3903 := by
  intro p hp
  have h : env3903.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3902_3903 : H12AffineEnvironment.transform 29 360608 env3902 = env3903 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360608 env3902 == env3903) = true)

theorem identity3903 : scanCanonicalize (H12AffineFastState.compose env3903 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(17+1) ^^^ 48236) := by decide +kernel

theorem selectedBound3903 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env3904 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,48236,524288,32768,4097,526221,5457,98305,591756,325,569252,1045,1044,81100,4165,4294967296,5444,4295536742,4096,599300]

theorem envBound3904 : H12AffineFastState.Bounded env3904 := by
  intro p hp
  have h : env3904.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3903_3904 : H12AffineEnvironment.transform 17 48236 env3903 = env3904 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 48236 env3903 == env3904) = true)

def env3905 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4176,32768,65536,4097,48236,524288,32768,4097,525961,5205,98305,591496,65,568992,1045,1044,81100,4165,4294967296,5184,4295536742,4096,599040]

theorem envBound3905 : H12AffineFastState.Bounded env3905 := by
  intro p hp
  have h : env3905.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3904_3905 : H12AffineEnvironment.transform 7 4 env3904 = env3905 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env3904 == env3905) = true)

theorem identity3905 : scanCanonicalize (H12AffineFastState.compose env3905 (packedSelected [5,12,13,15,21] rootPS)) = affineNative (2^(18+1) ^^^ 75265) := by decide +kernel

theorem selectedBound3905 : packedSelected [5,12,13,15,21] rootPS < 2^1333 := by decide +kernel

def env3906 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4176,32768,65536,4097,48236,75265,32768,4097,73864,5205,98305,8329,65,100513,1045,1044,81100,4165,4294967296,5184,4295071335,4096,513]

theorem envBound3906 : H12AffineFastState.Bounded env3906 := by
  intro p hp
  have h : env3906.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3905_3906 : H12AffineEnvironment.transform 18 75265 env3905 = env3906 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 75265 env3905 == env3906) = true)

theorem identity3906 : scanCanonicalize (H12AffineFastState.compose env3906 (packedSelected [0,1,4,5,7,8,9,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 13382) := by decide +kernel

theorem selectedBound3906 : packedSelected [0,1,4,5,7,8,9,12,13] rootPS < 2^1333 := by decide +kernel

def env3907 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4176,13382,65536,4097,2090,75265,13382,4097,73864,5205,78919,8329,65,81127,1045,1044,81100,4165,4294967296,5184,4295041569,4096,513]

end H12GlobalChart2
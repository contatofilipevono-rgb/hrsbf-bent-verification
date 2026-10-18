import H12GlobalChart2Data026

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem selectedBound6602 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env6603 : List Nat := [2,4,8,16,32,17,128,140,137,1024,163,1180,9,1180,131,8,1180,137,1025,131,1180,1,16,3,128,16,1,1180,1181,163,1160,163,141,11,1180,136]

theorem envBound6603 : H12AffineFastState.Bounded env6603 := by
  intro p hp
  have h : env6603.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6602_6603 : H12AffineEnvironment.transform 7 140 env6602 = env6603 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 140 env6602 == env6603) = true)

theorem identity6603 : scanCanonicalize (H12AffineFastState.compose env6603 (packedSelected [1,13] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound6603 : packedSelected [1,13] rootPS < 2^1333 := by decide +kernel

def env6604 : List Nat := [2,4,8,16,32,17,3,15,10,1024,32,1055,9,1055,0,8,1055,10,1025,0,1055,1,16,3,3,16,1,1055,1054,32,1035,32,14,11,1055,11]

theorem envBound6604 : H12AffineFastState.Bounded env6604 := by
  intro p hp
  have h : env6604.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6603_6604 : H12AffineEnvironment.transform 6 3 env6603 = env6604 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env6603 == env6604) = true)

theorem identity6604 : scanCanonicalize (H12AffineFastState.compose env6604 (packedSelected [4] rootPS)) = affineNative (2^(4+1) ^^^ 26) := by decide +kernel

theorem selectedBound6604 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env6605 : List Nat := [2,4,8,16,26,17,3,15,10,1024,26,1055,9,1055,0,8,1055,10,1025,0,1055,1,16,3,3,16,1,1055,1054,26,1035,26,14,11,1055,11]

theorem envBound6605 : H12AffineFastState.Bounded env6605 := by
  intro p hp
  have h : env6605.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6604_6605 : H12AffineEnvironment.transform 4 26 env6604 = env6605 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 26 env6604 == env6605) = true)

theorem identity6605 : scanCanonicalize (H12AffineFastState.compose env6605 (packedSelected [1,15] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound6605 : packedSelected [1,15] rootPS < 2^1333 := by decide +kernel

def env6606 : List Nat := [2,4,2,16,16,17,3,5,0,1024,16,1045,3,1045,0,2,1045,0,1025,0,1045,1,16,3,3,16,1,1045,1044,16,1025,16,4,1,1045,1]

theorem envBound6606 : H12AffineFastState.Bounded env6606 := by
  intro p hp
  have h : env6606.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6605_6606 : H12AffineEnvironment.transform 2 2 env6605 = env6606 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env6605 == env6606) = true)

def leafEnv6606 : List Nat := [2,4,2,16,16,17,3,5,0,1024,16,1045,3,1045,0,2,1045,0,1025,0,1045,1,16,3,1024,3,1,16,1,1045,1044,16,1025,16,4,1,5,2,1045,1,0,1044,1]

def active6606 : List Nat := [0,1,3,9]

def tree6606 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6606 : H12WitnessSearch.Good tree6606 := H12GlobalWitnessIndex.good

theorem leafIdentity6606 : H12AffineFastState.composeSystem env6606 rootObs = leafEnv6606 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6606 rootObs == leafEnv6606) = true)

theorem terminalChecked6606 : H12PackedTerminal.terminalCheckFast leafEnv6606 active6606 tree6606 = true := by decide +kernel

def env6607 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,640,16384,32768,65536,1297,262144,1025,32768,1297,4194304,17664,16777216,129,16875796,21349648,16892165,1296,20973967,16876544,4294967296,257,4299277878,1297,137]

theorem envBound6607 : H12AffineFastState.Bounded env6607 := by
  intro p hp
  have h : env6607.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6592_6607 : H12AffineEnvironment.transform 11 1297 env6592 = env6607 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env6592 == env6607) = true)

theorem identity6607 : scanCanonicalize (H12AffineFastState.compose env6607 (packedSelected [1,5,8,19,24,26] rootPS)) = affineNative (2^(23+1) ^^^ 98565) := by decide +kernel

theorem selectedBound6607 : packedSelected [1,5,8,19,24,26] rootPS < 2^1333 := by decide +kernel

def env6608 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,640,16384,32768,65536,1297,262144,1025,32768,1297,4194304,17664,98565,129,17,4473877,16384,1296,4294794,1285,4294967296,257,4299277878,1297,137]

theorem envBound6608 : H12AffineFastState.Bounded env6608 := by
  intro p hp
  have h : env6608.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6607_6608 : H12AffineEnvironment.transform 23 98565 env6607 = env6608 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98565 env6607 == env6608) = true)

theorem identity6608 : scanCanonicalize (H12AffineFastState.compose env6608 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(17+1) ^^^ 100899) := by decide +kernel

theorem selectedBound6608 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env6609 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,640,16384,32768,65536,1297,100899,1025,32768,1297,4194304,17664,98565,129,17,4312630,16384,1296,4294794,1285,4294967296,257,4299277878,1297,137]

theorem envBound6609 : H12AffineFastState.Bounded env6609 := by
  intro p hp
  have h : env6609.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6608_6609 : H12AffineEnvironment.transform 17 100899 env6608 = env6609 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 100899 env6608 == env6609) = true)

theorem identity6609 : scanCanonicalize (H12AffineFastState.compose env6609 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 1296) := by decide +kernel

theorem selectedBound6609 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env6610 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,640,1296,32768,65536,1297,100899,1025,32768,1297,4194304,16,98565,129,17,4295462,1296,1296,4294794,1285,4294967296,257,4299260710,1297,137]

theorem envBound6610 : H12AffineFastState.Bounded env6610 := by
  intro p hp
  have h : env6610.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6609_6610 : H12AffineEnvironment.transform 13 1296 env6609 = env6610 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1296 env6609 == env6610) = true)

theorem identity6610 : scanCanonicalize (H12AffineFastState.compose env6610 (packedSelected [1,3,5] rootPS)) = affineNative (2^(7+1) ^^^ 134) := by decide +kernel

theorem selectedBound6610 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env6611 : List Nat := [2,4,8,16,32,17,128,134,512,1024,2048,1175,640,1174,32768,65536,1175,100899,1025,32768,1175,4194304,16,98435,129,17,4295328,1174,1174,4294794,1155,4294967296,135,4299260576,1175,137]

theorem envBound6611 : H12AffineFastState.Bounded env6611 := by
  intro p hp
  have h : env6611.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6610_6611 : H12AffineEnvironment.transform 7 134 env6610 = env6611 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 134 env6610 == env6611) = true)

theorem identity6611 : scanCanonicalize (H12AffineFastState.compose env6611 (packedSelected [1,3,8] rootPS)) = affineNative (2^(15+1) ^^^ 139) := by decide +kernel

theorem selectedBound6611 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env6612 : List Nat := [2,4,8,16,32,17,128,134,512,1024,2048,1175,640,1174,32768,139,1175,35496,1025,32768,1175,4194304,16,32776,129,17,4229675,1174,1174,4229121,1155,4294967296,135,4299194923,1175,137]

theorem envBound6612 : H12AffineFastState.Bounded env6612 := by
  intro p hp
  have h : env6612.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6611_6612 : H12AffineEnvironment.transform 15 139 env6611 = env6612 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 139 env6611 == env6612) = true)

theorem identity6612 : scanCanonicalize (H12AffineFastState.compose env6612 (packedSelected [3,10,12] rootPS)) = affineNative (2^(21+1) ^^^ 2696) := by decide +kernel

theorem selectedBound6612 : packedSelected [3,10,12] rootPS < 2^1333 := by decide +kernel

def env6613 : List Nat := [2,4,8,16,32,17,128,134,512,1024,2048,1175,640,1174,32768,139,1175,35496,1025,32768,1175,2696,16,32776,129,17,32931,1174,1174,33417,1155,4294967296,135,4295002275,1175,137]

theorem envBound6613 : H12AffineFastState.Bounded env6613 := by
  intro p hp
  have h : env6613.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6612_6613 : H12AffineEnvironment.transform 21 2696 env6612 = env6613 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 2696 env6612 == env6613) = true)

theorem identity6613 : scanCanonicalize (H12AffineFastState.compose env6613 (packedSelected [1,10,15] rootPS)) = affineNative (2^(14+1) ^^^ 523) := by decide +kernel

theorem selectedBound6613 : packedSelected [1,10,15] rootPS < 2^1333 := by decide +kernel

def env6614 : List Nat := [2,4,8,16,32,17,128,134,512,1024,2048,1175,640,1174,523,139,1175,2211,1025,523,1175,2696,16,515,129,17,680,1174,1174,130,1155,4294967296,135,4294970024,1175,137]

theorem envBound6614 : H12AffineFastState.Bounded env6614 := by
  intro p hp
  have h : env6614.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6613_6614 : H12AffineEnvironment.transform 14 523 env6613 = env6614 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 523 env6613 == env6614) = true)

theorem identity6614 : scanCanonicalize (H12AffineFastState.compose env6614 (packedSelected [1,3] rootPS)) = affineNative (2^(8+1) ^^^ 42) := by decide +kernel

theorem selectedBound6614 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env6615 : List Nat := [2,4,8,16,32,17,128,134,42,1024,2048,1175,170,1174,33,139,1175,2211,1025,33,1175,2210,16,41,129,17,130,1174,1174,130,1155,4294967296,135,4294969474,1175,137]

theorem envBound6615 : H12AffineFastState.Bounded env6615 := by
  intro p hp
  have h : env6615.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6614_6615 : H12AffineEnvironment.transform 8 42 env6614 = env6615 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 42 env6614 == env6615) = true)

theorem identity6615 : scanCanonicalize (H12AffineFastState.compose env6615 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(6+1) ^^^ 35) := by decide +kernel

theorem selectedBound6615 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env6616 : List Nat := [2,4,8,16,32,17,35,37,42,1024,2048,1076,9,1077,33,40,1076,2048,1025,33,1076,2049,16,41,34,17,33,1077,1077,33,1056,4294967296,36,4294969377,1076,42]

theorem envBound6616 : H12AffineFastState.Bounded env6616 := by
  intro p hp
  have h : env6616.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6615_6616 : H12AffineEnvironment.transform 6 35 env6615 = env6616 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 35 env6615 == env6616) = true)

theorem identity6616 : scanCanonicalize (H12AffineFastState.compose env6616 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 2099) := by decide +kernel

theorem selectedBound6616 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6617 : List Nat := [2,4,8,16,32,17,35,37,42,1024,2048,1076,9,1077,33,40,1076,2048,1025,33,1076,2049,16,41,34,17,33,1077,1077,33,1056,2099,36,18,1076,42]

theorem envBound6617 : H12AffineFastState.Bounded env6617 := by
  intro p hp
  have h : env6617.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6616_6617 : H12AffineEnvironment.transform 31 2099 env6616 = env6617 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 2099 env6616 == env6617) = true)

theorem identity6617 : scanCanonicalize (H12AffineFastState.compose env6617 (packedSelected [1] rootPS)) = affineNative (2^(10+1) ^^^ 10) := by decide +kernel

theorem selectedBound6617 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6618 : List Nat := [2,4,8,16,32,17,35,37,42,1024,10,1076,9,1077,33,40,1076,10,1025,33,1076,11,16,41,34,17,33,1077,1077,33,1056,57,36,18,1076,42]

theorem envBound6618 : H12AffineFastState.Bounded env6618 := by
  intro p hp
  have h : env6618.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6617_6618 : H12AffineEnvironment.transform 10 10 env6617 = env6618 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 10 env6617 == env6618) = true)

theorem identity6618 : scanCanonicalize (H12AffineFastState.compose env6618 (packedSelected [2,4] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound6618 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env6619 : List Nat := [2,4,8,2,32,3,35,37,42,1024,10,1062,9,1063,33,40,1062,10,1025,33,1062,11,2,41,34,3,33,1063,1063,33,1056,43,36,0,1062,42]

theorem envBound6619 : H12AffineFastState.Bounded env6619 := by
  intro p hp
  have h : env6619.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6618_6619 : H12AffineEnvironment.transform 3 2 env6618 = env6619 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env6618 == env6619) = true)

def env6620 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,16777216,33554432,16875797,21352449,16897045,4096,20978847,16876544,4294967296,257,4332832438,4097,33554440]

theorem envBound6620 : H12AffineFastState.Bounded env6620 := by
  intro p hp
  have h : env6620.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6590_6620 : H12AffineEnvironment.transform 16 4097 env6590 = env6620 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env6590 == env6620) = true)

theorem identity6620 : scanCanonicalize (H12AffineFastState.compose env6620 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(24+1) ^^^ 128) := by decide +kernel

theorem selectedBound6620 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env6621 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,16777216,128,16875797,21352449,16897045,4096,20978847,16876544,4294967296,257,4299277878,4097,136]

theorem envBound6621 : H12AffineFastState.Bounded env6621 := by
  intro p hp
  have h : env6621.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6620_6621 : H12AffineEnvironment.transform 24 128 env6620 = env6621 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 128 env6620 == env6621) = true)

def env6622 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,4293120,128,4195093,283137,4216341,4096,106143,4195840,4294967296,257,4299277878,4097,136]

theorem envBound6622 : H12AffineFastState.Bounded env6622 := by
  intro p hp
  have h : env6622.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6621_6622 : H12AffineEnvironment.transform 23 4293120 env6621 = env6622 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 4293120 env6621 == env6622) = true)

def env6623 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,4292744,128,4194717,282761,4215965,4096,105495,4195464,4294967296,257,4299277502,4097,136]

theorem envBound6623 : H12AffineFastState.Bounded env6623 := by
  intro p hp
  have h : env6623.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6622_6623 : H12AffineEnvironment.transform 8 136 env6622 = env6623 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env6622 == env6623) = true)

theorem identity6623 : scanCanonicalize (H12AffineFastState.compose env6623 (packedSelected [6,25] rootPS)) = affineNative (2^(21+1) ^^^ 17564) := by decide +kernel

theorem selectedBound6623 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env6624 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,16384,32768,65536,4097,262144,1025,32768,4096,17564,17664,115732,128,17665,282761,4097,4096,105495,16404,4294967296,257,4295065634,4097,136]

theorem envBound6624 : H12AffineFastState.Bounded env6624 := by
  intro p hp
  have h : env6624.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6623_6624 : H12AffineEnvironment.transform 21 17564 env6623 = env6624 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 17564 env6623 == env6624) = true)

theorem identity6624 : scanCanonicalize (H12AffineFastState.compose env6624 (packedSelected [4,9,16] rootPS)) = affineNative (2^(13+1) ^^^ 4097) := by decide +kernel

theorem selectedBound6624 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env6625 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,4097,32768,65536,4097,262144,1025,32768,4096,5277,5377,103445,128,5376,262280,4097,4096,105495,4117,4294967296,257,4295065634,4097,136]

theorem envBound6625 : H12AffineFastState.Bounded env6625 := by
  intro p hp
  have h : env6625.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6624_6625 : H12AffineEnvironment.transform 13 4097 env6624 = env6625 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4097 env6624 == env6625) = true)

theorem identity6625 : scanCanonicalize (H12AffineFastState.compose env6625 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 70711) := by decide +kernel

theorem selectedBound6625 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6626 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,4097,32768,65536,4097,262144,1025,32768,4096,5277,5377,103445,128,5376,262280,4097,4096,105495,4117,70711,257,37909,4097,136]

theorem envBound6626 : H12AffineFastState.Bounded env6626 := by
  intro p hp
  have h : env6626.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6625_6626 : H12AffineEnvironment.transform 31 70711 env6625 = env6626 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 70711 env6625 == env6626) = true)

theorem identity6626 : scanCanonicalize (H12AffineFastState.compose env6626 (packedSelected [0,7,20] rootPS)) = affineNative (2^(14+1) ^^^ 5141) := by decide +kernel

theorem selectedBound6626 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env6627 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,4097,5141,65536,4097,262144,1025,5141,4096,5277,5377,65536,128,5376,262280,4097,4096,67586,4117,70711,257,0,4097,136]

theorem envBound6627 : H12AffineFastState.Bounded env6627 := by
  intro p hp
  have h : env6627.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6626_6627 : H12AffineEnvironment.transform 14 5141 env6626 = env6627 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 5141 env6626 == env6627) = true)

theorem identity6627 : scanCanonicalize (H12AffineFastState.compose env6627 (packedSelected [1,3,10,26] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound6627 : packedSelected [1,3,10,26] rootPS < 2^1333 := by decide +kernel

def env6628 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1296,8,1297,261,65536,1297,262144,1025,261,1296,397,17,65536,128,16,262280,1297,1296,67586,1285,65831,257,0,1297,136]

theorem envBound6628 : H12AffineFastState.Bounded env6628 := by
  intro p hp
  have h : env6628.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6627_6628 : H12AffineEnvironment.transform 11 1296 env6627 = env6628 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env6627 == env6628) = true)

theorem identity6628 : scanCanonicalize (H12AffineFastState.compose env6628 (packedSelected [1,3,5] rootPS)) = affineNative (2^(15+1) ^^^ 269) := by decide +kernel

theorem selectedBound6628 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env6629 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1296,8,1297,261,269,1297,262144,1025,261,1296,397,17,269,128,16,262280,1297,1296,2319,1285,42,257,0,1297,136]

theorem envBound6629 : H12AffineFastState.Bounded env6629 := by
  intro p hp
  have h : env6629.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6628_6629 : H12AffineEnvironment.transform 15 269 env6628 = env6629 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 269 env6628 == env6629) = true)

theorem identity6629 : scanCanonicalize (H12AffineFastState.compose env6629 (packedSelected [1,10] rootPS)) = affineNative (2^(9+1) ^^^ 299) := by decide +kernel

theorem selectedBound6629 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env6630 : List Nat := [2,4,8,16,32,17,128,256,136,299,2048,59,8,58,261,269,58,262144,298,261,59,397,17,269,128,16,262280,58,59,2319,46,42,257,0,58,136]

theorem envBound6630 : H12AffineFastState.Bounded env6630 := by
  intro p hp
  have h : env6630.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6629_6630 : H12AffineEnvironment.transform 9 299 env6629 = env6630 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 299 env6629 == env6630) = true)

theorem identity6630 : scanCanonicalize (H12AffineFastState.compose env6630 (packedSelected [3,12] rootPS)) = affineNative (2^(17+1) ^^^ 2341) := by decide +kernel

theorem selectedBound6630 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env6631 : List Nat := [2,4,8,16,32,17,128,256,136,299,2048,59,8,58,261,269,58,2341,298,261,59,397,17,269,128,16,2477,58,59,2319,46,42,257,0,58,136]

theorem envBound6631 : H12AffineFastState.Bounded env6631 := by
  intro p hp
  have h : env6631.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6630_6631 : H12AffineEnvironment.transform 17 2341 env6630 = env6631 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2341 env6630 == env6631) = true)

theorem identity6631 : scanCanonicalize (H12AffineFastState.compose env6631 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound6631 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6632 : List Nat := [2,4,8,16,10,17,128,256,136,257,2048,17,8,16,261,269,16,2319,256,261,17,397,17,269,128,16,2439,16,17,2319,4,0,257,0,16,136]

theorem envBound6632 : H12AffineFastState.Bounded env6632 := by
  intro p hp
  have h : env6632.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6631_6632 : H12AffineEnvironment.transform 4 10 env6631 = env6632 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env6631 == env6632) = true)

theorem identity6632 : scanCanonicalize (H12AffineFastState.compose env6632 (packedSelected [0,2,7,11] rootPS)) = affineNative (2^(10+1) ^^^ 136) := by decide +kernel

theorem selectedBound6632 : packedSelected [0,2,7,11] rootPS < 2^1333 := by decide +kernel

def env6633 : List Nat := [2,4,8,16,10,17,128,256,136,257,136,17,8,16,261,269,16,391,256,261,17,397,17,269,128,16,271,16,17,391,4,0,257,0,16,136]

theorem envBound6633 : H12AffineFastState.Bounded env6633 := by
  intro p hp
  have h : env6633.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6632_6633 : H12AffineEnvironment.transform 10 136 env6632 = env6633 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 136 env6632 == env6633) = true)

theorem identity6633 : scanCanonicalize (H12AffineFastState.compose env6633 (packedSelected [0,7] rootPS)) = affineNative (2^(7+1) ^^^ 15) := by decide +kernel

theorem selectedBound6633 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env6634 : List Nat := [2,4,8,16,10,17,128,15,136,14,136,17,8,16,10,2,16,136,15,10,17,130,17,2,128,16,0,16,17,136,4,0,14,0,16,136]

theorem envBound6634 : H12AffineFastState.Bounded env6634 := by
  intro p hp
  have h : env6634.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6633_6634 : H12AffineEnvironment.transform 7 15 env6633 = env6634 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 15 env6633 == env6634) = true)

theorem identity6634 : scanCanonicalize (H12AffineFastState.compose env6634 (packedSelected [0,2] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound6634 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env6635 : List Nat := [2,4,8,3,10,2,128,15,136,14,136,2,8,3,10,2,3,136,15,10,2,130,2,2,128,3,0,3,2,136,4,0,14,0,3,136]

theorem envBound6635 : H12AffineFastState.Bounded env6635 := by
  intro p hp
  have h : env6635.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6634_6635 : H12AffineEnvironment.transform 3 3 env6634 = env6635 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env6634 == env6635) = true)

theorem identity6635 : scanCanonicalize (H12AffineFastState.compose env6635 (packedSelected [3,13] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound6635 : packedSelected [3,13] rootPS < 2^1333 := by decide +kernel

def env6636 : List Nat := [2,4,8,3,10,2,9,15,1,14,1,2,8,3,10,2,3,1,15,10,2,11,2,2,9,3,0,3,2,1,4,0,14,0,3,1]

theorem envBound6636 : H12AffineFastState.Bounded env6636 := by
  intro p hp
  have h : env6636.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6635_6636 : H12AffineEnvironment.transform 6 9 env6635 = env6636 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env6635 == env6636) = true)

def env6637 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,4292745,128,4194716,282760,4215964,4096,105494,4195465,4294967296,257,4299277503,4097,136]

theorem envBound6637 : H12AffineFastState.Bounded env6637 := by
  intro p hp
  have h : env6637.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6622_6637 : H12AffineEnvironment.transform 8 137 env6622 = env6637 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6622 == env6637) = true)

theorem identity6637 : scanCanonicalize (H12AffineFastState.compose env6637 (packedSelected [3,4,9,10,16,24,26] rootPS)) = affineNative (2^(21+1) ^^^ 5276) := by decide +kernel

theorem selectedBound6637 : packedSelected [3,4,9,10,16,24,26] rootPS < 2^1333 := by decide +kernel

def env6638 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,16384,32768,65536,4097,262144,1025,32768,4096,5276,17664,103445,128,5376,282760,16384,4096,105494,4117,4294967296,257,4295086115,4097,136]

theorem envBound6638 : H12AffineFastState.Bounded env6638 := by
  intro p hp
  have h : env6638.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6637_6638 : H12AffineEnvironment.transform 21 5276 env6637 = env6638 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5276 env6637 == env6638) = true)

theorem identity6638 : scanCanonicalize (H12AffineFastState.compose env6638 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 279735) := by decide +kernel

theorem selectedBound6638 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6639 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,16384,32768,65536,4097,262144,1025,32768,4096,5276,17664,103445,128,5376,282760,16384,4096,105494,4117,279735,257,365716,4097,136]

theorem envBound6639 : H12AffineFastState.Bounded env6639 := by
  intro p hp
  have h : env6639.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6638_6639 : H12AffineEnvironment.transform 31 279735 env6638 = env6639 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 279735 env6638 == env6639) = true)

theorem identity6639 : scanCanonicalize (H12AffineFastState.compose env6639 (packedSelected [13,21] rootPS)) = affineNative (2^(13+1) ^^^ 4096) := by decide +kernel

theorem selectedBound6639 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env6640 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,4096,32768,65536,4097,262144,1025,32768,4096,5276,5376,103445,128,5376,262280,4096,4096,105494,4117,267447,257,365716,4097,136]

theorem envBound6640 : H12AffineFastState.Bounded env6640 := by
  intro p hp
  have h : env6640.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6639_6640 : H12AffineEnvironment.transform 13 4096 env6639 = env6640 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4096 env6639 == env6640) = true)

theorem identity6640 : scanCanonicalize (H12AffineFastState.compose env6640 (packedSelected [4,9,16] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound6640 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env6641 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,1297,32768,65536,1296,262144,1025,32768,1297,397,17,98564,128,17,262280,1297,1297,100615,1284,262566,257,360837,1296,136]

theorem envBound6641 : H12AffineFastState.Bounded env6641 := by
  intro p hp
  have h : env6641.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6640_6641 : H12AffineEnvironment.transform 11 1297 env6640 = env6641 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env6640 == env6641) = true)

theorem identity6641 : scanCanonicalize (H12AffineFastState.compose env6641 (packedSelected [1,3,5] rootPS)) = affineNative (2^(17+1) ^^^ 67755) := by decide +kernel

theorem selectedBound6641 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env6642 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,1297,32768,65536,1296,67755,1025,32768,1297,397,17,98564,128,17,67619,1297,1297,100615,1284,67853,257,35118,1296,136]

theorem envBound6642 : H12AffineFastState.Bounded env6642 := by
  intro p hp
  have h : env6642.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6641_6642 : H12AffineEnvironment.transform 17 67755 env6641 = env6642 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 67755 env6641 == env6642) = true)

theorem identity6642 : scanCanonicalize (H12AffineFastState.compose env6642 (packedSelected [1,3,8] rootPS)) = affineNative (2^(15+1) ^^^ 32907) := by decide +kernel

theorem selectedBound6642 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env6643 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,1297,32768,32907,1296,34848,1025,32768,1297,397,17,399,128,17,34984,1297,1297,2444,1284,35206,257,35118,1296,136]

theorem envBound6643 : H12AffineFastState.Bounded env6643 := by
  intro p hp
  have h : env6643.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6642_6643 : H12AffineEnvironment.transform 15 32907 env6642 = env6643 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 32907 env6642 == env6643) = true)

theorem identity6643 : scanCanonicalize (H12AffineFastState.compose env6643 (packedSelected [1] rootPS)) = affineNative (2^(14+1) ^^^ 390) := by decide +kernel

theorem selectedBound6643 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6644 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,1297,390,269,1296,2470,1025,390,1297,397,17,399,128,17,2350,1297,1297,2444,1284,2048,257,2216,1296,136]

theorem envBound6644 : H12AffineFastState.Bounded env6644 := by
  intro p hp
  have h : env6644.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6643_6644 : H12AffineEnvironment.transform 14 390 env6643 = env6644 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 390 env6643 == env6644) = true)

theorem identity6644 : scanCanonicalize (H12AffineFastState.compose env6644 (packedSelected [3,12] rootPS)) = affineNative (2^(10+1) ^^^ 168) := by decide +kernel

theorem selectedBound6644 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env6645 : List Nat := [2,4,8,16,32,17,128,256,137,1024,168,1297,9,1297,390,269,1296,270,1025,390,1297,397,17,399,128,17,390,1297,1297,292,1284,168,257,0,1296,136]

theorem envBound6645 : H12AffineFastState.Bounded env6645 := by
  intro p hp
  have h : env6645.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6644_6645 : H12AffineEnvironment.transform 10 168 env6644 = env6645 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 168 env6644 == env6645) = true)

theorem identity6645 : scanCanonicalize (H12AffineFastState.compose env6645 (packedSelected [3,13] rootPS)) = affineNative (2^(7+1) ^^^ 135) := by decide +kernel

theorem selectedBound6645 : packedSelected [3,13] rootPS < 2^1333 := by decide +kernel

def env6646 : List Nat := [2,4,8,16,32,17,128,135,137,1024,168,1174,9,1174,1,138,1175,137,1025,1,1174,10,17,8,128,17,1,1174,1174,163,1155,168,134,0,1175,136]

theorem envBound6646 : H12AffineFastState.Bounded env6646 := by
  intro p hp
  have h : env6646.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6645_6646 : H12AffineEnvironment.transform 7 135 env6645 = env6646 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 135 env6645 == env6646) = true)

theorem identity6646 : scanCanonicalize (H12AffineFastState.compose env6646 (packedSelected [0,2] rootPS)) = affineNative (2^(6+1) ^^^ 24) := by decide +kernel

theorem selectedBound6646 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env6647 : List Nat := [2,4,8,16,32,17,24,31,17,1024,48,1038,9,1038,1,18,1039,17,1025,1,1038,10,17,8,24,17,1,1038,1038,59,1051,48,30,0,1039,16]

theorem envBound6647 : H12AffineFastState.Bounded env6647 := by
  intro p hp
  have h : env6647.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6646_6647 : H12AffineEnvironment.transform 6 24 env6646 = env6647 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 24 env6646 == env6647) = true)

theorem identity6647 : scanCanonicalize (H12AffineFastState.compose env6647 (packedSelected [9] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound6647 : packedSelected [9] rootPS < 2^1333 := by decide +kernel

def env6648 : List Nat := [2,4,3,16,32,17,19,20,17,1024,48,1029,2,1029,1,18,1028,17,1025,1,1029,1,17,3,19,17,1,1029,1029,48,1040,48,21,0,1028,16]

theorem envBound6648 : H12AffineFastState.Bounded env6648 := by
  intro p hp
  have h : env6648.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6647_6648 : H12AffineEnvironment.transform 2 3 env6647 = env6648 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env6647 == env6648) = true)

theorem identity6648 : scanCanonicalize (H12AffineFastState.compose env6648 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound6648 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6649 : List Nat := [2,4,3,1,32,0,2,5,0,1024,33,1029,2,1029,1,3,1028,0,1025,1,1029,1,0,3,2,0,1,1029,1029,33,1025,33,4,0,1028,1]

theorem envBound6649 : H12AffineFastState.Bounded env6649 := by
  intro p hp
  have h : env6649.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6648_6649 : H12AffineEnvironment.transform 3 1 env6648 = env6649 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env6648 == env6649) = true)

def leafEnv6649 : List Nat := [2,4,3,1,32,0,2,5,0,1024,33,1029,2,1029,1,3,1028,0,1025,1,1029,1,0,3,1024,2,1,0,1,1029,1029,33,1025,33,4,0,5,3,1028,1,0,1029,1]

def active6649 : List Nat := [0,1,4,9]

def tree6649 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6649 : H12WitnessSearch.Good tree6649 := H12GlobalWitnessIndex.good

theorem leafIdentity6649 : H12AffineFastState.composeSystem env6649 rootObs = leafEnv6649 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6649 rootObs == leafEnv6649) = true)

theorem terminalChecked6649 : H12PackedTerminal.terminalCheckFast leafEnv6649 active6649 tree6649 = true := by decide +kernel

def env6650 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,4293121,128,4195092,283136,4216340,4096,106142,4195841,4294967296,257,4299277878,4097,136]

theorem envBound6650 : H12AffineFastState.Bounded env6650 := by
  intro p hp
  have h : env6650.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6621_6650 : H12AffineEnvironment.transform 23 4293121 env6621 = env6650 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 4293121 env6621 == env6650) = true)

theorem identity6650 : scanCanonicalize (H12AffineFastState.compose env6650 (packedSelected [1,3,4,5,8,9,10,16,19] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound6650 : packedSelected [1,3,4,5,8,9,10,16,19] rootPS < 2^1333 := by decide +kernel

def env6651 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,4292744,128,4194717,282761,4215965,4096,105495,4195464,4294967296,257,4299277503,4097,136]

theorem envBound6651 : H12AffineFastState.Bounded env6651 := by
  intro p hp
  have h : env6651.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6650_6651 : H12AffineEnvironment.transform 8 137 env6650 = env6651 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6650 == env6651) = true)

theorem identity6651 : scanCanonicalize (H12AffineFastState.compose env6651 (packedSelected [3,4,9,10,16,24,26] rootPS)) = affineNative (2^(21+1) ^^^ 5277) := by decide +kernel

theorem selectedBound6651 : packedSelected [3,4,9,10,16,24,26] rootPS < 2^1333 := by decide +kernel

def env6652 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,16384,32768,65536,4097,262144,1025,32768,4096,5277,17664,103445,128,5376,282761,16384,4096,105495,4117,4294967296,257,4295086114,4097,136]

theorem envBound6652 : H12AffineFastState.Bounded env6652 := by
  intro p hp
  have h : env6652.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6651_6652 : H12AffineEnvironment.transform 21 5277 env6651 = env6652 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5277 env6651 == env6652) = true)

theorem identity6652 : scanCanonicalize (H12AffineFastState.compose env6652 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 315555) := by decide +kernel

theorem selectedBound6652 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6653 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,16384,32768,65536,4097,262144,1025,32768,4096,5277,17664,103445,128,5376,282761,16384,4096,105495,4117,315555,257,327809,4097,136]

theorem envBound6653 : H12AffineFastState.Bounded env6653 := by
  intro p hp
  have h : env6653.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6652_6653 : H12AffineEnvironment.transform 31 315555 env6652 = env6653 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 315555 env6652 == env6653) = true)

def env6654 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,16777216,33554432,17010964,21352449,17024020,131073,21105822,16876544,4294967296,257,4332967606,131072,33554441]

theorem envBound6654 : H12AffineFastState.Bounded env6654 := by
  intro p hp
  have h : env6654.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6589_6654 : H12AffineEnvironment.transform 12 641 env6589 = env6654 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 641 env6589 == env6654) = true)

def env6655 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,16777216,33554432,16875796,21352449,16897044,4097,20978846,16876544,4294967296,257,4332832438,4096,33554441]

theorem envBound6655 : H12AffineFastState.Bounded env6655 := by
  intro p hp
  have h : env6655.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6654_6655 : H12AffineEnvironment.transform 16 4096 env6654 = env6655 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env6654 == env6655) = true)

theorem identity6655 : scanCanonicalize (H12AffineFastState.compose env6655 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(11+1) ^^^ 1945) := by decide +kernel

theorem selectedBound6655 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env6656 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,641,16384,32768,65536,1945,262144,1025,32768,1945,4194304,17664,16777216,33554432,16875796,21350296,16892813,1944,20974343,16876544,4294967296,257,4332832438,1945,33554441]

theorem envBound6656 : H12AffineFastState.Bounded env6656 := by
  intro p hp
  have h : env6656.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6655_6656 : H12AffineEnvironment.transform 11 1945 env6655 = env6656 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1945 env6655 == env6656) = true)

def env6657 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,641,16384,32768,65536,1945,262144,1025,32768,1945,4194304,17664,16777216,128,16875796,21350296,16892813,1944,20974343,16876544,4294967296,257,4299277878,1945,137]

theorem envBound6657 : H12AffineFastState.Bounded env6657 := by
  intro p hp
  have h : env6657.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6656_6657 : H12AffineEnvironment.transform 24 128 env6656 = env6657 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 128 env6656 == env6657) = true)

theorem identity6657 : scanCanonicalize (H12AffineFastState.compose env6657 (packedSelected [1,5,8,19,24,26] rootPS)) = affineNative (2^(23+1) ^^^ 98565) := by decide +kernel

theorem selectedBound6657 : packedSelected [1,5,8,19,24,26] rootPS < 2^1333 := by decide +kernel

def env6658 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,641,16384,32768,65536,1945,262144,1025,32768,1945,4194304,17664,98565,128,17,4474525,17032,1944,4295170,1285,4294967296,257,4299277878,1945,137]

theorem envBound6658 : H12AffineFastState.Bounded env6658 := by
  intro p hp
  have h : env6658.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6657_6658 : H12AffineEnvironment.transform 23 98565 env6657 = env6658 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98565 env6657 == env6658) = true)

theorem identity6658 : scanCanonicalize (H12AffineFastState.compose env6658 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 1944) := by decide +kernel

theorem selectedBound6658 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env6659 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,641,1944,32768,65536,1945,262144,1025,32768,1945,4194304,664,98565,128,17,4456709,1296,1944,4295170,1285,4294967296,257,4299260334,1945,137]

theorem envBound6659 : H12AffineFastState.Bounded env6659 := by
  intro p hp
  have h : env6659.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6658_6659 : H12AffineEnvironment.transform 13 1944 env6658 = env6659 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1944 env6658 == env6659) = true)

theorem identity6659 : scanCanonicalize (H12AffineFastState.compose env6659 (packedSelected [8,10,12] rootPS)) = affineNative (2^(21+1) ^^^ 66333) := by decide +kernel

theorem selectedBound6659 : packedSelected [8,10,12] rootPS < 2^1333 := by decide +kernel

def env6660 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,641,1944,32768,65536,1945,262144,1025,32768,1945,66333,664,98565,128,17,328216,1296,1944,35103,1285,4294967296,257,4295000755,1945,137]

theorem envBound6660 : H12AffineFastState.Bounded env6660 := by
  intro p hp
  have h : env6660.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6659_6660 : H12AffineEnvironment.transform 21 66333 env6659 = env6660 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 66333 env6659 == env6660) = true)

theorem identity6660 : scanCanonicalize (H12AffineFastState.compose env6660 (packedSelected [1,3,4,8,9,10,13,15,16,21] rootPS)) = affineNative (2^(17+1) ^^^ 2989) := by decide +kernel

theorem selectedBound6660 : packedSelected [1,3,4,8,9,10,13,15,16,21] rootPS < 2^1333 := by decide +kernel

def env6661 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,641,1944,32768,65536,1945,2989,1025,32768,1945,66333,664,98565,128,17,68021,1296,1944,35103,1285,4294967296,257,4295000755,1945,137]

theorem envBound6661 : H12AffineFastState.Bounded env6661 := by
  intro p hp
  have h : env6661.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6660_6661 : H12AffineEnvironment.transform 17 2989 env6660 = env6661 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2989 env6660 == env6661) = true)

theorem identity6661 : scanCanonicalize (H12AffineFastState.compose env6661 (packedSelected [0,3,4,5,7,8,9,16,17,20,24] rootPS)) = affineNative (2^(15+1) ^^^ 32776) := by decide +kernel

theorem selectedBound6661 : packedSelected [0,3,4,5,7,8,9,16,17,20,24] rootPS < 2^1333 := by decide +kernel

def env6662 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,641,1944,32768,32776,1945,2989,1025,32768,1945,33557,664,269,128,17,35261,1296,1944,35103,1285,4294967296,257,4295000755,1945,137]

theorem envBound6662 : H12AffineFastState.Bounded env6662 := by
  intro p hp
  have h : env6662.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6661_6662 : H12AffineEnvironment.transform 15 32776 env6661 = env6662 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 32776 env6661 == env6662) = true)

theorem identity6662 : scanCanonicalize (H12AffineFastState.compose env6662 (packedSelected [6,25] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound6662 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env6663 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,9,1296,32768,32776,1297,2341,1025,32768,1297,33181,16,269,128,17,35261,1296,1296,35103,1285,4294967296,257,4295000123,1297,137]

theorem envBound6663 : H12AffineFastState.Bounded env6663 := by
  intro p hp
  have h : env6663.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6662_6663 : H12AffineEnvironment.transform 8 136 env6662 = env6663 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env6662 == env6663) = true)

theorem identity6663 : scanCanonicalize (H12AffineFastState.compose env6663 (packedSelected [1,3,8] rootPS)) = affineNative (2^(14+1) ^^^ 130) := by decide +kernel

theorem selectedBound6663 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env6664 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,9,1296,130,138,1297,2341,1025,130,1297,287,16,269,128,17,2367,1296,1296,2461,1285,4294967296,257,4294967481,1297,137]

theorem envBound6664 : H12AffineFastState.Bounded env6664 := by
  intro p hp
  have h : env6664.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6663_6664 : H12AffineEnvironment.transform 14 130 env6663 = env6664 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 130 env6663 == env6664) = true)

theorem identity6664 : scanCanonicalize (H12AffineFastState.compose env6664 (packedSelected [3] rootPS)) = affineNative (2^(10+1) ^^^ 444) := by decide +kernel

theorem selectedBound6664 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6665 : List Nat := [2,4,8,16,32,17,128,256,136,1024,444,1297,9,1296,130,138,1297,153,1025,130,1297,287,16,269,128,17,131,1296,1296,33,1285,4294967296,257,4294967481,1297,137]

theorem envBound6665 : H12AffineFastState.Bounded env6665 := by
  intro p hp
  have h : env6665.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6664_6665 : H12AffineEnvironment.transform 10 444 env6664 = env6665 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 444 env6664 == env6665) = true)

theorem identity6665 : scanCanonicalize (H12AffineFastState.compose env6665 (packedSelected [0,2,7,9] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound6665 : packedSelected [0,2,7,9] rootPS < 2^1333 := by decide +kernel

def env6666 : List Nat := [2,4,8,16,32,17,128,36,136,1024,152,1077,9,1076,130,138,1077,153,1025,130,1077,59,16,41,128,17,131,1076,1076,33,1057,4294967296,37,4294967481,1077,137]

theorem envBound6666 : H12AffineFastState.Bounded env6666 := by
  intro p hp
  have h : env6666.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6665_6666 : H12AffineEnvironment.transform 7 36 env6665 = env6666 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env6665 == env6666) = true)

def env6667 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,641,16384,32768,65536,1945,262144,1025,32768,1945,4194304,17664,16777216,129,16875796,21350296,16892813,1944,20974343,16876544,4294967296,257,4299277879,1945,136]

theorem envBound6667 : H12AffineFastState.Bounded env6667 := by
  intro p hp
  have h : env6667.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6656_6667 : H12AffineEnvironment.transform 24 129 env6656 = env6667 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 129 env6656 == env6667) = true)

theorem identity6667 : scanCanonicalize (H12AffineFastState.compose env6667 (packedSelected [1,5,8,19,24,26] rootPS)) = affineNative (2^(23+1) ^^^ 99213) := by decide +kernel

theorem selectedBound6667 : packedSelected [1,5,8,19,24,26] rootPS < 2^1333 := by decide +kernel

def env6668 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,641,16384,32768,65536,1945,262144,1025,32768,1945,4194304,17664,99213,129,665,4473877,16384,1944,4294794,1933,4294967296,257,4299277879,1945,136]

theorem envBound6668 : H12AffineFastState.Bounded env6668 := by
  intro p hp
  have h : env6668.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6667_6668 : H12AffineEnvironment.transform 23 99213 env6667 = env6668 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 99213 env6667 == env6668) = true)

theorem identity6668 : scanCanonicalize (H12AffineFastState.compose env6668 (packedSelected [0,4,7,9,10,16,19,20,24,28] rootPS)) = affineNative (2^(13+1) ^^^ 1296) := by decide +kernel

theorem selectedBound6668 : packedSelected [0,4,7,9,10,16,19,20,24,28] rootPS < 2^1333 := by decide +kernel

def env6669 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,641,1296,32768,65536,1945,262144,1025,32768,1945,4194304,16,99213,129,665,4456709,1296,1944,4294794,1933,4294967296,257,4299260711,1945,136]

theorem envBound6669 : H12AffineFastState.Bounded env6669 := by
  intro p hp
  have h : env6669.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6668_6669 : H12AffineEnvironment.transform 13 1296 env6668 = env6669 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1296 env6668 == env6669) = true)

theorem identity6669 : scanCanonicalize (H12AffineFastState.compose env6669 (packedSelected [4,5,8,9,13,16,17] rootPS)) = affineNative (2^(21+1) ^^^ 32905) := by decide +kernel

theorem selectedBound6669 : packedSelected [4,5,8,9,13,16,17] rootPS < 2^1333 := by decide +kernel

def env6670 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,641,1296,32768,65536,1945,262144,1025,32768,1945,32905,16,99213,129,665,295308,1296,1944,67587,1933,4294967296,257,4295033774,1945,136]

theorem envBound6670 : H12AffineFastState.Bounded env6670 := by
  intro p hp
  have h : env6670.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6669_6670 : H12AffineEnvironment.transform 21 32905 env6669 = env6670 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 32905 env6669 == env6670) = true)

theorem identity6670 : scanCanonicalize (H12AffineFastState.compose env6670 (packedSelected [5,8,10,12,13] rootPS)) = affineNative (2^(17+1) ^^^ 34849) := by decide +kernel

theorem selectedBound6670 : packedSelected [5,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env6671 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,641,1296,32768,65536,1945,34849,1025,32768,1945,32905,16,99213,129,665,2477,1296,1944,67587,1933,4294967296,257,4295033774,1945,136]

theorem envBound6671 : H12AffineFastState.Bounded env6671 := by
  intro p hp
  have h : env6671.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6670_6671 : H12AffineEnvironment.transform 17 34849 env6670 = env6671 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 34849 env6670 == env6671) = true)

theorem identity6671 : scanCanonicalize (H12AffineFastState.compose env6671 (packedSelected [4,5,8,9,16] rootPS)) = affineNative (2^(15+1) ^^^ 33543) := by decide +kernel

theorem selectedBound6671 : packedSelected [4,5,8,9,16] rootPS < 2^1333 := by decide +kernel

def env6672 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,641,1296,32768,33543,1945,34849,1025,32768,1945,32905,16,138,129,665,2477,1296,1944,35588,1933,4294967296,257,4295000233,1945,136]

theorem envBound6672 : H12AffineFastState.Bounded env6672 := by
  intro p hp
  have h : env6672.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6671_6672 : H12AffineEnvironment.transform 15 33543 env6671 = env6672 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33543 env6671 == env6672) = true)

theorem identity6672 : scanCanonicalize (H12AffineFastState.compose env6672 (packedSelected [0,2,4,5,8,11] rootPS)) = affineNative (2^(31+1) ^^^ 2570) := by decide +kernel

theorem selectedBound6672 : packedSelected [0,2,4,5,8,11] rootPS < 2^1333 := by decide +kernel

def env6673 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1945,641,1296,32768,33543,1945,34849,1025,32768,1945,32905,16,138,129,665,2477,1296,1944,35588,1933,2570,257,35491,1945,136]

theorem envBound6673 : H12AffineFastState.Bounded env6673 := by
  intro p hp
  have h : env6673.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6672_6673 : H12AffineEnvironment.transform 31 2570 env6672 = env6673 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 2570 env6672 == env6673) = true)

theorem identity6673 : scanCanonicalize (H12AffineFastState.compose env6673 (packedSelected [1,3,6,10,12] rootPS)) = affineNative (2^(10+1) ^^^ 302) := by decide +kernel

theorem selectedBound6673 : packedSelected [1,3,6,10,12] rootPS < 2^1333 := by decide +kernel

def env6674 : List Nat := [2,4,8,16,32,17,128,256,512,1024,302,1945,641,1296,32768,33543,1945,33039,1025,32768,1945,32905,16,138,129,665,131,1296,1944,33322,1933,804,257,33677,1945,136]

theorem envBound6674 : H12AffineFastState.Bounded env6674 := by
  intro p hp
  have h : env6674.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6673_6674 : H12AffineEnvironment.transform 10 302 env6673 = env6674 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 302 env6673 == env6674) = true)

theorem identity6674 : scanCanonicalize (H12AffineFastState.compose env6674 (packedSelected [1,3,21] rootPS)) = affineNative (2^(14+1) ^^^ 260) := by decide +kernel

theorem selectedBound6674 : packedSelected [1,3,21] rootPS < 2^1333 := by decide +kernel

def env6675 : List Nat := [2,4,8,16,32,17,128,256,512,1024,302,1945,641,1296,260,515,1945,11,1025,260,1945,397,16,138,129,665,131,1296,1944,814,1933,804,257,649,1945,136]

theorem envBound6675 : H12AffineFastState.Bounded env6675 := by
  intro p hp
  have h : env6675.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6674_6675 : H12AffineEnvironment.transform 14 260 env6674 = env6675 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 260 env6674 == env6675) = true)

def env6676 : List Nat := [2,4,8,16,32,17,128,256,32,1024,302,1465,161,1296,260,35,1465,11,1025,260,1465,397,16,138,129,185,131,1296,1464,270,1453,260,257,169,1465,136]

theorem envBound6676 : H12AffineFastState.Bounded env6676 := by
  intro p hp
  have h : env6676.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6675_6676 : H12AffineEnvironment.transform 8 32 env6675 = env6676 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 32 env6675 == env6676) = true)

theorem identity6676 : scanCanonicalize (H12AffineFastState.compose env6676 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound6676 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6677 : List Nat := [2,4,8,16,32,17,128,37,32,1024,11,1180,161,1077,33,35,1180,11,1025,33,1180,168,16,138,129,185,131,1077,1181,43,1160,33,36,169,1180,136]

theorem envBound6677 : H12AffineFastState.Bounded env6677 := by
  intro p hp
  have h : env6677.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6676_6677 : H12AffineEnvironment.transform 7 37 env6676 = env6677 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env6676 == env6677) = true)

theorem identity6677 : scanCanonicalize (H12AffineFastState.compose env6677 (packedSelected [0,3,7] rootPS)) = affineNative (2^(6+1) ^^^ 41) := by decide +kernel

theorem selectedBound6677 : packedSelected [0,3,7] rootPS < 2^1333 := by decide +kernel

def env6678 : List Nat := [2,4,8,16,32,17,41,37,32,1024,11,1077,8,1077,33,35,1077,11,1025,33,1077,1,16,35,40,16,42,1077,1076,43,1057,33,36,0,1077,33]

theorem envBound6678 : H12AffineFastState.Bounded env6678 := by
  intro p hp
  have h : env6678.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6677_6678 : H12AffineEnvironment.transform 6 41 env6677 = env6678 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 41 env6677 == env6678) = true)

theorem identity6678 : scanCanonicalize (H12AffineFastState.compose env6678 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound6678 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6679 : List Nat := [2,4,8,10,32,11,41,37,32,1024,11,1071,8,1071,33,35,1071,11,1025,33,1071,1,10,35,40,10,42,1071,1070,43,1057,33,36,0,1071,33]

theorem envBound6679 : H12AffineFastState.Bounded env6679 := by
  intro p hp
  have h : env6679.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6678_6679 : H12AffineEnvironment.transform 3 10 env6678 = env6679 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env6678 == env6679) = true)

theorem identity6679 : scanCanonicalize (H12AffineFastState.compose env6679 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound6679 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6680 : List Nat := [2,4,2,0,32,1,35,37,32,1024,1,1061,2,1061,33,35,1061,1,1025,33,1061,1,0,35,34,0,32,1061,1060,33,1057,33,36,0,1061,33]

theorem envBound6680 : H12AffineFastState.Bounded env6680 := by
  intro p hp
  have h : env6680.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6679_6680 : H12AffineEnvironment.transform 2 2 env6679 = env6680 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env6679 == env6680) = true)

theorem identity6680 : scanCanonicalize (H12AffineFastState.compose env6680 (packedSelected [4] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound6680 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env6681 : List Nat := [2,4,2,0,0,1,3,5,0,1024,1,1029,2,1029,1,3,1029,1,1025,1,1029,1,0,3,2,0,0,1029,1028,1,1025,1,4,0,1029,1]

theorem envBound6681 : H12AffineFastState.Bounded env6681 := by
  intro p hp
  have h : env6681.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6680_6681 : H12AffineEnvironment.transform 4 0 env6680 = env6681 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env6680 == env6681) = true)

def leafEnv6681 : List Nat := [2,4,2,0,0,1,3,5,0,1024,1,1029,2,1029,1,3,1029,1,1025,1,1029,1,0,3,1024,2,1,0,0,1029,1028,1,1025,1,4,0,5,3,1029,1,0,1028,1]

def active6681 : List Nat := [0,1,9]

def tree6681 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6681 : H12WitnessSearch.Good tree6681 := H12GlobalWitnessIndex.good

theorem leafIdentity6681 : H12AffineFastState.composeSystem env6681 rootObs = leafEnv6681 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6681 rootObs == leafEnv6681) = true)

theorem terminalChecked6681 : H12PackedTerminal.terminalCheckFast leafEnv6681 active6681 tree6681 = true := by decide +kernel

def env6682 : List Nat := [2,4,8,16,32,17,128,256,33,1024,302,1464,160,1296,260,34,1464,11,1025,260,1464,397,16,138,129,184,131,1296,1465,271,1452,261,257,168,1464,136]

theorem envBound6682 : H12AffineFastState.Bounded env6682 := by
  intro p hp
  have h : env6682.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6675_6682 : H12AffineEnvironment.transform 8 33 env6675 = env6682 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 33 env6675 == env6682) = true)

theorem identity6682 : scanCanonicalize (H12AffineFastState.compose env6682 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 140) := by decide +kernel

theorem selectedBound6682 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6683 : List Nat := [2,4,8,16,32,17,128,140,33,1024,162,1076,160,1180,136,34,1076,11,1025,136,1076,1,16,138,129,184,131,1180,1077,131,1056,137,141,168,1076,136]

theorem envBound6683 : H12AffineFastState.Bounded env6683 := by
  intro p hp
  have h : env6683.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6682_6683 : H12AffineEnvironment.transform 7 140 env6682 = env6683 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 140 env6682 == env6683) = true)

theorem identity6683 : scanCanonicalize (H12AffineFastState.compose env6683 (packedSelected [0,3,5,7] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound6683 : packedSelected [0,3,5,7] rootPS < 2^1333 := by decide +kernel

def env6684 : List Nat := [2,4,2,16,32,17,128,134,33,1024,162,1076,160,1174,130,34,1076,1,1025,130,1076,1,16,128,129,178,131,1174,1077,131,1056,131,135,162,1076,130]

theorem envBound6684 : H12AffineFastState.Bounded env6684 := by
  intro p hp
  have h : env6684.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6683_6684 : H12AffineEnvironment.transform 2 2 env6683 = env6684 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env6683 == env6684) = true)

theorem identity6684 : scanCanonicalize (H12AffineFastState.compose env6684 (packedSelected [0,2,4,5] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound6684 : packedSelected [0,2,4,5] rootPS < 2^1333 := by decide +kernel

def env6685 : List Nat := [2,4,2,16,32,17,3,5,33,1024,33,1076,35,1045,1,34,1076,1,1025,1,1076,1,16,3,2,49,0,1045,1077,0,1056,0,4,33,1076,1]

theorem envBound6685 : H12AffineFastState.Bounded env6685 := by
  intro p hp
  have h : env6685.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6684_6685 : H12AffineEnvironment.transform 6 3 env6684 = env6685 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env6684 == env6685) = true)

theorem identity6685 : scanCanonicalize (H12AffineFastState.compose env6685 (packedSelected [0,2,4] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound6685 : packedSelected [0,2,4] rootPS < 2^1333 := by decide +kernel

def env6686 : List Nat := [2,4,2,16,1,17,3,5,0,1024,0,1045,2,1045,1,3,1045,1,1025,1,1045,1,16,3,2,16,0,1045,1044,0,1025,0,4,0,1045,1]

theorem envBound6686 : H12AffineFastState.Bounded env6686 := by
  intro p hp
  have h : env6686.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6685_6686 : H12AffineEnvironment.transform 4 1 env6685 = env6686 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env6685 == env6686) = true)

theorem identity6686 : scanCanonicalize (H12AffineFastState.compose env6686 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound6686 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6687 : List Nat := [2,4,2,0,1,1,3,5,0,1024,0,1029,2,1029,1,3,1029,1,1025,1,1029,1,0,3,2,0,0,1029,1028,0,1025,0,4,0,1029,1]

theorem envBound6687 : H12AffineFastState.Bounded env6687 := by
  intro p hp
  have h : env6687.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6686_6687 : H12AffineEnvironment.transform 3 0 env6686 = env6687 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env6686 == env6687) = true)

def leafEnv6687 : List Nat := [2,4,2,0,1,1,3,5,0,1024,0,1029,2,1029,1,3,1029,1,1025,1,1029,1,0,3,1024,2,1,0,0,1029,1028,0,1025,0,4,0,5,3,1029,1,0,1028,1]

def active6687 : List Nat := [0,1,9]

def tree6687 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6687 : H12WitnessSearch.Good tree6687 := H12GlobalWitnessIndex.good

theorem leafIdentity6687 : H12AffineFastState.composeSystem env6687 rootObs = leafEnv6687 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6687 rootObs == leafEnv6687) = true)

theorem terminalChecked6687 : H12PackedTerminal.terminalCheckFast leafEnv6687 active6687 tree6687 = true := by decide +kernel

def env6688 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,16777216,33554432,16875797,21352449,16897045,4096,20978847,16876544,4294967296,257,4332832439,4097,33554441]

theorem envBound6688 : H12AffineFastState.Bounded env6688 := by
  intro p hp
  have h : env6688.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6654_6688 : H12AffineEnvironment.transform 16 4097 env6654 = env6688 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env6654 == env6688) = true)

theorem identity6688 : scanCanonicalize (H12AffineFastState.compose env6688 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound6688 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env6689 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,16777216,33554432,16875797,21352449,16897045,4096,20978847,16876544,4294967296,257,4332831806,4097,33554441]

theorem envBound6689 : H12AffineFastState.Bounded env6689 := by
  intro p hp
  have h : env6689.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6688_6689 : H12AffineEnvironment.transform 8 137 env6688 = env6689 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6688 == env6689) = true)

def env6690 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,16777216,16859280,16875797,21352449,16897045,4096,20978847,16876544,4294967296,257,4315972782,4097,16859289]

theorem envBound6690 : H12AffineFastState.Bounded env6690 := by
  intro p hp
  have h : env6690.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6689_6690 : H12AffineEnvironment.transform 24 16859280 env6689 = env6690 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 16859280 env6689 == env6690) = true)

def env6691 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,8,16384,32768,65536,4097,262144,257,32768,4096,4194304,16384,16777216,16859280,16875797,21352449,16896277,4096,20978079,16875776,4294967296,257,4315972014,4097,16859289]

theorem envBound6691 : H12AffineFastState.Bounded env6691 := by
  intro p hp
  have h : env6691.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6690_6691 : H12AffineEnvironment.transform 9 256 env6690 = env6691 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 256 env6690 == env6691) = true)

theorem identity6691 : scanCanonicalize (H12AffineFastState.compose env6691 (packedSelected [0,3,4,7,9,10,13,16,17,20,21,24,26,33] rootPS)) = affineNative (2^(23+1) ^^^ 81937) := by decide +kernel

theorem selectedBound6691 : packedSelected [0,3,4,7,9,10,13,16,17,20,21,24,26,33] rootPS < 2^1333 := by decide +kernel

def env6692 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,8,16384,32768,65536,4097,262144,257,32768,4096,4194304,16384,81937,129,49412,4493328,37124,4096,4282766,49425,4294967296,257,4299276735,4097,136]

theorem envBound6692 : H12AffineFastState.Bounded env6692 := by
  intro p hp
  have h : env6692.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6691_6692 : H12AffineEnvironment.transform 23 81937 env6691 = env6692 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 81937 env6691 == env6692) = true)

theorem identity6692 : scanCanonicalize (H12AffineFastState.compose env6692 (packedSelected [3,4,9,10,16,24,26] rootPS)) = affineNative (2^(14+1) ^^^ 20740) := by decide +kernel

theorem selectedBound6692 : packedSelected [3,4,9,10,16,24,26] rootPS < 2^1333 := by decide +kernel

def env6693 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,8,16384,20740,65536,4097,262144,257,20740,4096,4194304,16384,81937,129,4096,4473108,16384,4096,4282766,4117,4294967296,257,4299231419,4097,136]

theorem envBound6693 : H12AffineFastState.Bounded env6693 := by
  intro p hp
  have h : env6693.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6692_6693 : H12AffineEnvironment.transform 14 20740 env6692 = env6693 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 20740 env6692 == env6693) = true)

theorem identity6693 : scanCanonicalize (H12AffineFastState.compose env6693 (packedSelected [4,5,8,9,16,17,21] rootPS)) = affineNative (2^(11+1) ^^^ 16) := by decide +kernel

theorem selectedBound6693 : packedSelected [4,5,8,9,16,17,21] rootPS < 2^1333 := by decide +kernel

def env6694 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,16,8,16384,16660,65536,17,262144,257,16660,16,4194304,16384,81937,129,16,4473108,16384,16,4278686,5,4294967296,257,4299227307,17,136]

theorem envBound6694 : H12AffineFastState.Bounded env6694 := by
  intro p hp
  have h : env6694.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6693_6694 : H12AffineEnvironment.transform 11 16 env6693 = env6694 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 16 env6693 == env6694) = true)

theorem identity6694 : scanCanonicalize (H12AffineFastState.compose env6694 (packedSelected [3,5,6,10] rootPS)) = affineNative (2^(31+1) ^^^ 4538652) := by decide +kernel

theorem selectedBound6694 : packedSelected [3,5,6,10] rootPS < 2^1333 := by decide +kernel

def env6695 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,16,8,16384,16660,65536,17,262144,257,16660,16,4194304,16384,81937,129,16,4473108,16384,16,4278686,5,4538652,257,278967,17,136]

theorem envBound6695 : H12AffineFastState.Bounded env6695 := by
  intro p hp
  have h : env6695.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6694_6695 : H12AffineEnvironment.transform 31 4538652 env6694 = env6695 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4538652 env6694 == env6695) = true)

theorem identity6695 : scanCanonicalize (H12AffineFastState.compose env6695 (packedSelected [1,3,5,6,8,12,15] rootPS)) = affineNative (2^(21+1) ^^^ 280852) := by decide +kernel

theorem selectedBound6695 : packedSelected [1,3,5,6,8,12,15] rootPS < 2^1333 := by decide +kernel

def env6696 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,16,8,16384,16660,65536,17,262144,257,16660,16,280852,16384,81937,129,16,2048,16384,16,327818,5,67592,257,278967,17,136]

theorem envBound6696 : H12AffineFastState.Bounded env6696 := by
  intro p hp
  have h : env6696.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6695_6696 : H12AffineEnvironment.transform 21 280852 env6695 = env6696 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 280852 env6695 == env6696) = true)

theorem identity6696 : scanCanonicalize (H12AffineFastState.compose env6696 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(13+1) ^^^ 17) := by decide +kernel

theorem selectedBound6696 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env6697 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,16,8,17,261,65536,17,262144,257,261,16,264453,17,65536,129,16,2048,17,16,327818,5,67592,257,262566,17,136]

theorem envBound6697 : H12AffineFastState.Bounded env6697 := by
  intro p hp
  have h : env6697.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6696_6697 : H12AffineEnvironment.transform 13 17 env6696 = env6697 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 17 env6696 == env6697) = true)

theorem identity6697 : scanCanonicalize (H12AffineFastState.compose env6697 (packedSelected [1,3,5] rootPS)) = affineNative (2^(15+1) ^^^ 268) := by decide +kernel

theorem selectedBound6697 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env6698 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,16,8,17,261,268,17,262144,257,261,16,264453,17,268,129,16,2048,17,16,262534,5,2308,257,262566,17,136]

theorem envBound6698 : H12AffineFastState.Bounded env6698 := by
  intro p hp
  have h : env6698.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6697_6698 : H12AffineEnvironment.transform 15 268 env6697 = env6698 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 268 env6697 == env6698) = true)

theorem identity6698 : scanCanonicalize (H12AffineFastState.compose env6698 (packedSelected [6] rootPS)) = affineNative (2^(17+1) ^^^ 2211) := by decide +kernel

theorem selectedBound6698 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6699 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,16,8,17,261,268,17,2211,257,261,16,422,17,268,129,16,2048,17,16,2341,5,2308,257,2309,17,136]

theorem envBound6699 : H12AffineFastState.Bounded env6699 := by
  intro p hp
  have h : env6699.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6698_6699 : H12AffineEnvironment.transform 17 2211 env6698 = env6699 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2211 env6698 == env6699) = true)

theorem identity6699 : scanCanonicalize (H12AffineFastState.compose env6699 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound6699 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6700 : List Nat := [2,4,8,16,32,17,2,256,11,256,2048,16,8,17,261,268,17,2081,257,261,16,292,17,268,3,16,2048,17,16,2341,5,2308,257,2309,17,10]

theorem envBound6700 : H12AffineFastState.Bounded env6700 := by
  intro p hp
  have h : env6700.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6699_6700 : H12AffineEnvironment.transform 6 2 env6699 = env6700 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env6699 == env6700) = true)

theorem identity6700 : scanCanonicalize (H12AffineFastState.compose env6700 (packedSelected [2] rootPS)) = affineNative (2^(10+1) ^^^ 293) := by decide +kernel

theorem selectedBound6700 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6701 : List Nat := [2,4,8,16,32,17,2,256,11,256,293,16,8,17,261,268,17,260,257,261,16,292,17,268,3,16,293,17,16,0,5,33,257,32,17,10]

theorem envBound6701 : H12AffineFastState.Bounded env6701 := by
  intro p hp
  have h : env6701.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6700_6701 : H12AffineEnvironment.transform 10 293 env6700 = env6701 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 293 env6700 == env6701) = true)

theorem identity6701 : scanCanonicalize (H12AffineFastState.compose env6701 (packedSelected [0,4] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound6701 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env6702 : List Nat := [2,4,8,16,32,17,2,5,11,5,32,16,8,17,0,9,17,1,4,0,16,33,17,9,3,16,32,17,16,0,5,33,4,32,17,10]

theorem envBound6702 : H12AffineFastState.Bounded env6702 := by
  intro p hp
  have h : env6702.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6701_6702 : H12AffineEnvironment.transform 7 5 env6701 = env6702 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env6701 == env6702) = true)

theorem identity6702 : scanCanonicalize (H12AffineFastState.compose env6702 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound6702 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6703 : List Nat := [2,4,8,0,32,1,2,5,11,5,32,0,8,1,0,9,1,1,4,0,0,33,1,9,3,0,32,1,0,0,5,33,4,32,1,10]

theorem envBound6703 : H12AffineFastState.Bounded env6703 := by
  intro p hp
  have h : env6703.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6702_6703 : H12AffineEnvironment.transform 3 0 env6702 = env6703 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env6702 == env6703) = true)

def env6704 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,8,16384,32768,65536,4097,262144,256,32768,4096,4194304,16385,16777216,16859280,16875797,21352449,16896276,4096,20978078,16875777,4294967296,257,4315972015,4097,16859289]

theorem envBound6704 : H12AffineFastState.Bounded env6704 := by
  intro p hp
  have h : env6704.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6690_6704 : H12AffineEnvironment.transform 9 257 env6690 = env6704 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 257 env6690 == env6704) = true)

def env6705 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,8,16384,32768,65536,4097,262144,256,32768,4096,4194304,16385,65536,16528,33045,4509697,53524,4096,4266398,33025,4294967296,257,4299260335,4097,16537]

theorem envBound6705 : H12AffineFastState.Bounded env6705 := by
  intro p hp
  have h : env6705.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6704_6705 : H12AffineEnvironment.transform 23 65536 env6704 = env6705 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 65536 env6704 == env6705) = true)

theorem identity6705 : scanCanonicalize (H12AffineFastState.compose env6705 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(13+1) ^^^ 4097) := by decide +kernel

theorem selectedBound6705 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env6706 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,8,4097,32768,65536,4097,262144,256,32768,4096,4194304,4096,65536,4241,33045,4489216,33045,4096,4266398,33025,4294967296,257,4299260335,4097,4248]

theorem envBound6706 : H12AffineFastState.Bounded env6706 := by
  intro p hp
  have h : env6706.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6705_6706 : H12AffineEnvironment.transform 13 4097 env6705 = env6706 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4097 env6705 == env6706) = true)

theorem identity6706 : scanCanonicalize (H12AffineFastState.compose env6706 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(14+1) ^^^ 4372) := by decide +kernel

theorem selectedBound6706 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env6707 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,8,4097,4372,65536,4097,262144,256,4372,4096,4194304,4096,65536,4241,4097,4460820,4097,4096,4266398,4117,4294967296,257,4299231419,4097,4248]

theorem envBound6707 : H12AffineFastState.Bounded env6707 := by
  intro p hp
  have h : env6707.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6706_6707 : H12AffineEnvironment.transform 14 4372 env6706 = env6707 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 4372 env6706 == env6707) = true)

theorem identity6707 : scanCanonicalize (H12AffineFastState.compose env6707 (packedSelected [5,8] rootPS)) = affineNative (2^(11+1) ^^^ 17) := by decide +kernel

theorem selectedBound6707 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env6708 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,17,8,16,261,65536,16,262144,256,261,17,4194304,17,65536,128,16,4456709,16,17,4262287,4,4294967296,257,4299227306,16,137]

theorem envBound6708 : H12AffineFastState.Bounded env6708 := by
  intro p hp
  have h : env6708.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6707_6708 : H12AffineEnvironment.transform 11 17 env6707 = env6708 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 17 env6707 == env6708) = true)

theorem identity6708 : scanCanonicalize (H12AffineFastState.compose env6708 (packedSelected [1,3,5] rootPS)) = affineNative (2^(15+1) ^^^ 269) := by decide +kernel

theorem selectedBound6708 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env6709 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,17,8,16,261,269,16,262144,256,261,17,4194304,17,269,128,16,4456709,16,17,4196482,4,4294967296,257,4299162023,16,137]

theorem envBound6709 : H12AffineFastState.Bounded env6709 := by
  intro p hp
  have h : env6709.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6708_6709 : H12AffineEnvironment.transform 15 269 env6708 = env6709 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 269 env6708 == env6709) = true)

theorem identity6709 : scanCanonicalize (H12AffineFastState.compose env6709 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 42) := by decide +kernel

theorem selectedBound6709 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6710 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,17,8,16,261,269,16,262144,256,261,17,4194304,17,269,128,16,4456709,16,17,4196482,4,42,257,4194701,16,137]

theorem envBound6710 : H12AffineFastState.Bounded env6710 := by
  intro p hp
  have h : env6710.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6709_6710 : H12AffineEnvironment.transform 31 42 env6709 = env6710 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 42 env6709 == env6710) = true)

theorem identity6710 : scanCanonicalize (H12AffineFastState.compose env6710 (packedSelected [1,10] rootPS)) = affineNative (2^(21+1) ^^^ 423) := by decide +kernel

theorem selectedBound6710 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env6711 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,17,8,16,261,269,16,262144,256,261,17,423,17,269,128,16,262306,16,17,2341,4,42,257,42,16,137]

theorem envBound6711 : H12AffineFastState.Bounded env6711 := by
  intro p hp
  have h : env6711.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6710_6711 : H12AffineEnvironment.transform 21 423 env6710 = env6711 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 423 env6710 == env6711) = true)

theorem identity6711 : scanCanonicalize (H12AffineFastState.compose env6711 (packedSelected [3,12] rootPS)) = affineNative (2^(17+1) ^^^ 2341) := by decide +kernel

theorem selectedBound6711 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env6712 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,17,8,16,261,269,16,2341,256,261,17,423,17,269,128,16,2439,16,17,2341,4,42,257,42,16,137]

theorem envBound6712 : H12AffineFastState.Bounded env6712 := by
  intro p hp
  have h : env6712.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6711_6712 : H12AffineEnvironment.transform 17 2341 env6711 = env6712 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2341 env6711 == env6712) = true)

theorem identity6712 : scanCanonicalize (H12AffineFastState.compose env6712 (packedSelected [0,2,7,11] rootPS)) = affineNative (2^(10+1) ^^^ 163) := by decide +kernel

theorem selectedBound6712 : packedSelected [0,2,7,11] rootPS < 2^1333 := by decide +kernel

def env6713 : List Nat := [2,4,8,16,32,17,128,256,137,257,163,17,8,16,261,269,16,390,256,261,17,423,17,269,128,16,292,16,17,390,4,42,257,42,16,137]

theorem envBound6713 : H12AffineFastState.Bounded env6713 := by
  intro p hp
  have h : env6713.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6712_6713 : H12AffineEnvironment.transform 10 163 env6712 = env6713 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 163 env6712 == env6713) = true)

theorem identity6713 : scanCanonicalize (H12AffineFastState.compose env6713 (packedSelected [0,7] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound6713 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env6714 : List Nat := [2,4,8,16,32,17,8,256,1,257,43,17,8,16,261,269,16,270,256,261,17,303,17,269,8,16,292,16,17,270,4,42,257,42,16,1]

theorem envBound6714 : H12AffineFastState.Bounded env6714 := by
  intro p hp
  have h : env6714.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6713_6714 : H12AffineEnvironment.transform 6 8 env6713 = env6714 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env6713 == env6714) = true)

theorem identity6714 : scanCanonicalize (H12AffineFastState.compose env6714 (packedSelected [3,13] rootPS)) = affineNative (2^(7+1) ^^^ 14) := by decide +kernel

theorem selectedBound6714 : packedSelected [3,13] rootPS < 2^1333 := by decide +kernel

def env6715 : List Nat := [2,4,8,16,32,17,8,14,1,15,43,17,8,16,11,3,16,0,14,11,17,33,17,3,8,16,42,16,17,0,4,42,15,42,16,1]

theorem envBound6715 : H12AffineFastState.Bounded env6715 := by
  intro p hp
  have h : env6715.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6714_6715 : H12AffineEnvironment.transform 7 14 env6714 = env6715 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 14 env6714 == env6715) = true)

def env6716 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,8,16384,32768,65536,4097,262144,256,32768,4096,4194304,16385,65537,16529,33044,4509696,53525,4096,4266399,33024,4294967296,257,4299260334,4097,16536]

theorem envBound6716 : H12AffineFastState.Bounded env6716 := by
  intro p hp
  have h : env6716.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6704_6716 : H12AffineEnvironment.transform 23 65537 env6704 = env6716 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 65537 env6704 == env6716) = true)

theorem identity6716 : scanCanonicalize (H12AffineFastState.compose env6716 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(14+1) ^^^ 20741) := by decide +kernel

theorem selectedBound6716 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env6717 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,8,16384,20741,65536,4097,262144,256,20741,4096,4194304,16385,65537,16529,20497,4456709,16,4096,4266399,20485,4294967296,257,4299247787,4097,16536]

theorem envBound6717 : H12AffineFastState.Bounded env6717 := by
  intro p hp
  have h : env6717.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6716_6717 : H12AffineEnvironment.transform 14 20741 env6716 = env6717 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 20741 env6716 == env6717) = true)

theorem identity6717 : scanCanonicalize (H12AffineFastState.compose env6717 (packedSelected [1,3,5,6,8,10,19,25] rootPS)) = affineNative (2^(13+1) ^^^ 16) := by decide +kernel

theorem selectedBound6717 : packedSelected [1,3,5,6,8,10,19,25] rootPS < 2^1333 := by decide +kernel

def env6718 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,8,16,4373,65536,4097,262144,256,4373,4096,4194304,17,65537,129,4097,4456709,16,4096,4266399,4117,4294967296,257,4299231419,4097,136]

theorem envBound6718 : H12AffineFastState.Bounded env6718 := by
  intro p hp
  have h : env6718.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6717_6718 : H12AffineEnvironment.transform 13 16 env6717 = env6718 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 16 env6717 == env6718) = true)

theorem identity6718 : scanCanonicalize (H12AffineFastState.compose env6718 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 4456491) := by decide +kernel

theorem selectedBound6718 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6719 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,8,16,4373,65536,4097,262144,256,4373,4096,4194304,17,65537,129,4097,4456709,16,4096,4266399,4117,4456491,257,331920,4097,136]

theorem envBound6719 : H12AffineFastState.Bounded env6719 := by
  intro p hp
  have h : env6719.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6718_6719 : H12AffineEnvironment.transform 31 4456491 env6718 = env6719 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4456491 env6718 == env6719) = true)

theorem identity6719 : scanCanonicalize (H12AffineFastState.compose env6719 (packedSelected [10,12,17] rootPS)) = affineNative (2^(15+1) ^^^ 139) := by decide +kernel

theorem selectedBound6719 : packedSelected [10,12,17] rootPS < 2^1333 := by decide +kernel

def env6720 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,8,16,4373,139,4097,262144,256,4373,4096,4194304,17,138,129,4097,4456709,16,4096,4200724,4117,4456491,257,266267,4097,136]

theorem envBound6720 : H12AffineFastState.Bounded env6720 := by
  intro p hp
  have h : env6720.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6719_6720 : H12AffineEnvironment.transform 15 139 env6719 = env6720 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 139 env6719 == env6720) = true)

theorem identity6720 : scanCanonicalize (H12AffineFastState.compose env6720 (packedSelected [0,3,4,5,7,9,12,13] rootPS)) = affineNative (2^(17+1) ^^^ 6452) := by decide +kernel

theorem selectedBound6720 : packedSelected [0,3,4,5,7,9,12,13] rootPS < 2^1333 := by decide +kernel

def env6721 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,8,16,4373,139,4097,6452,256,4373,4096,4194304,17,138,129,4097,4200497,16,4096,4200724,4117,4200735,257,2351,4097,136]

theorem envBound6721 : H12AffineFastState.Bounded env6721 := by
  intro p hp
  have h : env6721.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6720_6721 : H12AffineEnvironment.transform 17 6452 env6720 = env6721 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 6452 env6720 == env6721) = true)

theorem identity6721 : scanCanonicalize (H12AffineFastState.compose env6721 (packedSelected [5,8] rootPS)) = affineNative (2^(11+1) ^^^ 16) := by decide +kernel

theorem selectedBound6721 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env6722 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,16,8,16,261,139,17,2340,256,261,16,4194304,17,138,129,17,4196385,16,16,4196612,5,4196623,257,2351,17,136]

theorem envBound6722 : H12AffineFastState.Bounded env6722 := by
  intro p hp
  have h : env6722.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6721_6722 : H12AffineEnvironment.transform 11 16 env6721 = env6722 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 16 env6721 == env6722) = true)

theorem identity6722 : scanCanonicalize (H12AffineFastState.compose env6722 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound6722 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6723 : List Nat := [2,4,8,16,32,17,2,256,11,257,2048,16,8,16,261,9,17,2340,256,261,16,4194304,17,8,3,17,4196385,16,16,4196612,5,4196623,257,2351,17,10]

theorem envBound6723 : H12AffineFastState.Bounded env6723 := by
  intro p hp
  have h : env6723.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6722_6723 : H12AffineEnvironment.transform 6 2 env6722 = env6723 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env6722 == env6723) = true)

theorem identity6723 : scanCanonicalize (H12AffineFastState.compose env6723 (packedSelected [3] rootPS)) = affineNative (2^(21+1) ^^^ 2351) := by decide +kernel

theorem selectedBound6723 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6724 : List Nat := [2,4,8,16,32,17,2,256,11,257,2048,16,8,16,261,9,17,2340,256,261,16,2351,17,8,3,17,270,16,16,43,5,32,257,2351,17,10]

theorem envBound6724 : H12AffineFastState.Bounded env6724 := by
  intro p hp
  have h : env6724.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6723_6724 : H12AffineEnvironment.transform 21 2351 env6723 = env6724 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 2351 env6723 == env6724) = true)

theorem identity6724 : scanCanonicalize (H12AffineFastState.compose env6724 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 17) := by decide +kernel

theorem selectedBound6724 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6725 : List Nat := [2,4,8,16,17,17,2,256,11,257,2048,16,8,16,261,9,17,2325,256,261,16,2334,17,8,3,17,270,16,16,26,5,17,257,2334,17,10]

theorem envBound6725 : H12AffineFastState.Bounded env6725 := by
  intro p hp
  have h : env6725.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6724_6725 : H12AffineEnvironment.transform 4 17 env6724 = env6725 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env6724 == env6725) = true)

theorem identity6725 : scanCanonicalize (H12AffineFastState.compose env6725 (packedSelected [5] rootPS)) = affineNative (2^(10+1) ^^^ 276) := by decide +kernel

theorem selectedBound6725 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env6726 : List Nat := [2,4,8,16,17,17,2,256,11,257,276,16,8,16,261,9,17,1,256,261,16,10,17,8,3,17,270,16,16,26,5,17,257,10,17,10]

theorem envBound6726 : H12AffineFastState.Bounded env6726 := by
  intro p hp
  have h : env6726.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6725_6726 : H12AffineEnvironment.transform 10 276 env6725 = env6726 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 276 env6725 == env6726) = true)

theorem identity6726 : scanCanonicalize (H12AffineFastState.compose env6726 (packedSelected [10] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound6726 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env6727 : List Nat := [2,4,8,16,17,17,2,5,11,4,17,16,8,16,0,9,17,1,5,0,16,10,17,8,3,17,11,16,16,26,5,17,4,10,17,10]

theorem envBound6727 : H12AffineFastState.Bounded env6727 := by
  intro p hp
  have h : env6727.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6726_6727 : H12AffineEnvironment.transform 7 5 env6726 = env6727 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env6726 == env6727) = true)

theorem identity6727 : scanCanonicalize (H12AffineFastState.compose env6727 (packedSelected [0,4] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound6727 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env6728 : List Nat := [2,4,3,16,17,17,2,5,0,4,17,16,3,16,0,2,17,1,5,0,16,1,17,3,3,17,0,16,16,17,5,17,4,1,17,1]

theorem envBound6728 : H12AffineFastState.Bounded env6728 := by
  intro p hp
  have h : env6728.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6727_6728 : H12AffineEnvironment.transform 2 3 env6727 = env6728 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env6727 == env6728) = true)

def leafEnv6728 : List Nat := [2,4,3,16,17,17,2,5,0,4,17,16,3,16,0,2,17,1,5,0,16,1,17,3,4,3,1,17,0,16,16,17,5,17,4,1,5,2,17,1,0,16,1]

def active6728 : List Nat := [0,1,3]

def tree6728 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6728 : H12WitnessSearch.Good tree6728 := H12GlobalWitnessIndex.good

theorem leafIdentity6728 : H12AffineFastState.composeSystem env6728 rootObs = leafEnv6728 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6728 rootObs == leafEnv6728) = true)

theorem terminalChecked6728 : H12PackedTerminal.terminalCheckFast leafEnv6728 active6728 tree6728 = true := by decide +kernel

def env6729 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,16777216,16859281,16875797,21352449,16897045,4096,20978847,16876544,4294967296,257,4315972783,4097,16859288]

theorem envBound6729 : H12AffineFastState.Bounded env6729 := by
  intro p hp
  have h : env6729.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6689_6729 : H12AffineEnvironment.transform 24 16859281 env6689 = env6729 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 16859281 env6689 == env6729) = true)

def env6730 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,8,16384,32768,65536,4097,262144,257,32768,4096,4194304,16384,16777216,16859281,16875797,21352449,16896277,4096,20978079,16875776,4294967296,257,4315972015,4097,16859288]

theorem envBound6730 : H12AffineFastState.Bounded env6730 := by
  intro p hp
  have h : env6730.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6729_6730 : H12AffineEnvironment.transform 9 256 env6729 = env6730 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 256 env6729 == env6730) = true)

def env6731 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,8,16384,32768,65536,4097,262144,257,32768,4096,4194304,16384,65536,16529,33045,4509697,53525,4096,4266399,33024,4294967296,257,4299260335,4097,16536]

theorem envBound6731 : H12AffineFastState.Bounded env6731 := by
  intro p hp
  have h : env6731.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6730_6731 : H12AffineEnvironment.transform 23 65536 env6730 = env6731 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 65536 env6730 == env6731) = true)

theorem identity6731 : scanCanonicalize (H12AffineFastState.compose env6731 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(13+1) ^^^ 4097) := by decide +kernel

theorem selectedBound6731 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env6732 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,8,4097,32768,65536,4097,262144,257,32768,4096,4194304,4097,65536,4240,33045,4489216,33044,4096,4266399,33024,4294967296,257,4299260335,4097,4249]

theorem envBound6732 : H12AffineFastState.Bounded env6732 := by
  intro p hp
  have h : env6732.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6731_6732 : H12AffineEnvironment.transform 13 4097 env6731 = env6732 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4097 env6731 == env6732) = true)

theorem identity6732 : scanCanonicalize (H12AffineFastState.compose env6732 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(14+1) ^^^ 4373) := by decide +kernel

theorem selectedBound6732 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env6733 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,8,4097,4373,65536,4097,262144,257,4373,4096,4194304,4097,65536,4240,4096,4460821,4097,4096,4266399,4117,4294967296,257,4299231418,4097,4249]

theorem envBound6733 : H12AffineFastState.Bounded env6733 := by
  intro p hp
  have h : env6733.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6732_6733 : H12AffineEnvironment.transform 14 4373 env6732 = env6733 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 4373 env6732 == env6733) = true)

theorem identity6733 : scanCanonicalize (H12AffineFastState.compose env6733 (packedSelected [5,8] rootPS)) = affineNative (2^(11+1) ^^^ 16) := by decide +kernel

theorem selectedBound6733 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env6734 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,16,8,17,261,65536,17,262144,257,261,16,4194304,17,65536,128,16,4456709,17,16,4262287,5,4294967296,257,4299227306,17,137]

theorem envBound6734 : H12AffineFastState.Bounded env6734 := by
  intro p hp
  have h : env6734.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6733_6734 : H12AffineEnvironment.transform 11 16 env6733 = env6734 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 16 env6733 == env6734) = true)

theorem identity6734 : scanCanonicalize (H12AffineFastState.compose env6734 (packedSelected [1,3,5] rootPS)) = affineNative (2^(15+1) ^^^ 269) := by decide +kernel

theorem selectedBound6734 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env6735 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,16,8,17,261,269,17,262144,257,261,16,4194304,17,269,128,16,4456709,17,16,4196482,5,4294967296,257,4299162023,17,137]

theorem envBound6735 : H12AffineFastState.Bounded env6735 := by
  intro p hp
  have h : env6735.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6734_6735 : H12AffineEnvironment.transform 15 269 env6734 = env6735 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 269 env6734 == env6735) = true)

theorem identity6735 : scanCanonicalize (H12AffineFastState.compose env6735 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 42) := by decide +kernel

theorem selectedBound6735 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6736 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,16,8,17,261,269,17,262144,257,261,16,4194304,17,269,128,16,4456709,17,16,4196482,5,42,257,4194701,17,137]

theorem envBound6736 : H12AffineFastState.Bounded env6736 := by
  intro p hp
  have h : env6736.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6735_6736 : H12AffineEnvironment.transform 31 42 env6735 = env6736 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 42 env6735 == env6736) = true)

theorem identity6736 : scanCanonicalize (H12AffineFastState.compose env6736 (packedSelected [1,10] rootPS)) = affineNative (2^(21+1) ^^^ 422) := by decide +kernel

theorem selectedBound6736 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env6737 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,16,8,17,261,269,17,262144,257,261,16,422,17,269,128,16,262307,17,16,2340,5,42,257,43,17,137]

theorem envBound6737 : H12AffineFastState.Bounded env6737 := by
  intro p hp
  have h : env6737.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6736_6737 : H12AffineEnvironment.transform 21 422 env6736 = env6737 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 422 env6736 == env6737) = true)

theorem identity6737 : scanCanonicalize (H12AffineFastState.compose env6737 (packedSelected [3,12] rootPS)) = affineNative (2^(17+1) ^^^ 2341) := by decide +kernel

theorem selectedBound6737 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env6738 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,16,8,17,261,269,17,2341,257,261,16,422,17,269,128,16,2438,17,16,2340,5,42,257,43,17,137]

theorem envBound6738 : H12AffineFastState.Bounded env6738 := by
  intro p hp
  have h : env6738.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6737_6738 : H12AffineEnvironment.transform 17 2341 env6737 = env6738 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2341 env6737 == env6738) = true)

def env6739 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,8,16384,32768,65536,4097,262144,257,32768,4096,4194304,16384,65537,16528,33044,4509696,53524,4096,4266398,33025,4294967296,257,4299260334,4097,16537]

theorem envBound6739 : H12AffineFastState.Bounded env6739 := by
  intro p hp
  have h : env6739.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6730_6739 : H12AffineEnvironment.transform 23 65537 env6730 = env6739 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 65537 env6730 == env6739) = true)

theorem identity6739 : scanCanonicalize (H12AffineFastState.compose env6739 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(14+1) ^^^ 20741) := by decide +kernel

theorem selectedBound6739 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env6740 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,8,16384,20741,65536,4097,262144,257,20741,4096,4194304,16384,65537,16528,20497,4456709,17,4096,4266398,20484,4294967296,257,4299247787,4097,16537]

theorem envBound6740 : H12AffineFastState.Bounded env6740 := by
  intro p hp
  have h : env6740.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6739_6740 : H12AffineEnvironment.transform 14 20741 env6739 = env6740 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 20741 env6739 == env6740) = true)

theorem identity6740 : scanCanonicalize (H12AffineFastState.compose env6740 (packedSelected [1,3,5,6,8,10,19,25] rootPS)) = affineNative (2^(13+1) ^^^ 17) := by decide +kernel

theorem selectedBound6740 : packedSelected [1,3,5,6,8,10,19,25] rootPS < 2^1333 := by decide +kernel

def env6741 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,8,17,4372,65536,4097,262144,257,4372,4096,4194304,17,65537,129,4096,4456709,17,4096,4266398,4117,4294967296,257,4299231418,4097,136]

theorem envBound6741 : H12AffineFastState.Bounded env6741 := by
  intro p hp
  have h : env6741.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6740_6741 : H12AffineEnvironment.transform 13 17 env6740 = env6741 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 17 env6740 == env6741) = true)

theorem identity6741 : scanCanonicalize (H12AffineFastState.compose env6741 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 4456491) := by decide +kernel

theorem selectedBound6741 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6742 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,8,17,4372,65536,4097,262144,257,4372,4096,4194304,17,65537,129,4096,4456709,17,4096,4266398,4117,4456491,257,331921,4097,136]

theorem envBound6742 : H12AffineFastState.Bounded env6742 := by
  intro p hp
  have h : env6742.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6741_6742 : H12AffineEnvironment.transform 31 4456491 env6741 = env6742 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4456491 env6741 == env6742) = true)

theorem identity6742 : scanCanonicalize (H12AffineFastState.compose env6742 (packedSelected [10,12,17] rootPS)) = affineNative (2^(15+1) ^^^ 139) := by decide +kernel

theorem selectedBound6742 : packedSelected [10,12,17] rootPS < 2^1333 := by decide +kernel

def env6743 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,8,17,4372,139,4097,262144,257,4372,4096,4194304,17,138,129,4096,4456709,17,4096,4200725,4117,4456491,257,266266,4097,136]

theorem envBound6743 : H12AffineFastState.Bounded env6743 := by
  intro p hp
  have h : env6743.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6742_6743 : H12AffineEnvironment.transform 15 139 env6742 = env6743 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 139 env6742 == env6743) = true)

theorem identity6743 : scanCanonicalize (H12AffineFastState.compose env6743 (packedSelected [0,3,4,5,7,9,12,13] rootPS)) = affineNative (2^(17+1) ^^^ 6453) := by decide +kernel

theorem selectedBound6743 : packedSelected [0,3,4,5,7,9,12,13] rootPS < 2^1333 := by decide +kernel

def env6744 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,8,17,4372,139,4097,6453,257,4372,4096,4194304,17,138,129,4096,4200496,17,4096,4200725,4117,4200734,257,2351,4097,136]

theorem envBound6744 : H12AffineFastState.Bounded env6744 := by
  intro p hp
  have h : env6744.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6743_6744 : H12AffineEnvironment.transform 17 6453 env6743 = env6744 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 6453 env6743 == env6744) = true)

theorem identity6744 : scanCanonicalize (H12AffineFastState.compose env6744 (packedSelected [5,8] rootPS)) = affineNative (2^(11+1) ^^^ 17) := by decide +kernel

theorem selectedBound6744 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env6745 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,17,8,17,261,139,16,2340,257,261,17,4194304,17,138,129,17,4196385,17,17,4196612,4,4196623,257,2351,16,136]

theorem envBound6745 : H12AffineFastState.Bounded env6745 := by
  intro p hp
  have h : env6745.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6744_6745 : H12AffineEnvironment.transform 11 17 env6744 = env6745 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 17 env6744 == env6745) = true)

theorem identity6745 : scanCanonicalize (H12AffineFastState.compose env6745 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound6745 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6746 : List Nat := [2,4,8,16,32,17,2,256,11,256,2048,17,8,17,261,9,16,2340,257,261,17,4194304,17,8,3,17,4196385,17,17,4196612,4,4196623,257,2351,16,10]

theorem envBound6746 : H12AffineFastState.Bounded env6746 := by
  intro p hp
  have h : env6746.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6745_6746 : H12AffineEnvironment.transform 6 2 env6745 = env6746 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env6745 == env6746) = true)

theorem identity6746 : scanCanonicalize (H12AffineFastState.compose env6746 (packedSelected [3] rootPS)) = affineNative (2^(21+1) ^^^ 2351) := by decide +kernel

theorem selectedBound6746 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6747 : List Nat := [2,4,8,16,32,17,2,256,11,256,2048,17,8,17,261,9,16,2340,257,261,17,2351,17,8,3,17,270,17,17,43,4,32,257,2351,16,10]

theorem envBound6747 : H12AffineFastState.Bounded env6747 := by
  intro p hp
  have h : env6747.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6746_6747 : H12AffineEnvironment.transform 21 2351 env6746 = env6747 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 2351 env6746 == env6747) = true)

theorem identity6747 : scanCanonicalize (H12AffineFastState.compose env6747 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 17) := by decide +kernel

theorem selectedBound6747 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6748 : List Nat := [2,4,8,16,17,17,2,256,11,256,2048,17,8,17,261,9,16,2325,257,261,17,2334,17,8,3,17,270,17,17,26,4,17,257,2334,16,10]

theorem envBound6748 : H12AffineFastState.Bounded env6748 := by
  intro p hp
  have h : env6748.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6747_6748 : H12AffineEnvironment.transform 4 17 env6747 = env6748 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env6747 == env6748) = true)

theorem identity6748 : scanCanonicalize (H12AffineFastState.compose env6748 (packedSelected [5] rootPS)) = affineNative (2^(10+1) ^^^ 276) := by decide +kernel

theorem selectedBound6748 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env6749 : List Nat := [2,4,8,16,17,17,2,256,11,256,276,17,8,17,261,9,16,1,257,261,17,10,17,8,3,17,270,17,17,26,4,17,257,10,16,10]

theorem envBound6749 : H12AffineFastState.Bounded env6749 := by
  intro p hp
  have h : env6749.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6748_6749 : H12AffineEnvironment.transform 10 276 env6748 = env6749 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 276 env6748 == env6749) = true)

theorem identity6749 : scanCanonicalize (H12AffineFastState.compose env6749 (packedSelected [10] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound6749 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env6750 : List Nat := [2,4,8,16,17,17,2,5,11,5,17,17,8,17,0,9,16,1,4,0,17,10,17,8,3,17,11,17,17,26,4,17,4,10,16,10]

theorem envBound6750 : H12AffineFastState.Bounded env6750 := by
  intro p hp
  have h : env6750.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6749_6750 : H12AffineEnvironment.transform 7 5 env6749 = env6750 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env6749 == env6750) = true)

theorem identity6750 : scanCanonicalize (H12AffineFastState.compose env6750 (packedSelected [0,4] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound6750 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env6751 : List Nat := [2,4,3,16,17,17,2,5,0,5,17,17,3,17,0,2,16,1,4,0,17,1,17,3,3,17,0,17,17,17,4,17,4,1,16,1]

theorem envBound6751 : H12AffineFastState.Bounded env6751 := by
  intro p hp
  have h : env6751.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6750_6751 : H12AffineEnvironment.transform 2 3 env6750 = env6751 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env6750 == env6751) = true)

def leafEnv6751 : List Nat := [2,4,3,16,17,17,2,5,0,5,17,17,3,17,0,2,16,1,4,0,17,1,17,3,5,3,1,17,0,17,17,17,4,17,4,1,5,2,16,1,0,17,1]

def active6751 : List Nat := [0,1,3]

def tree6751 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6751 : H12WitnessSearch.Good tree6751 := H12GlobalWitnessIndex.good

theorem leafIdentity6751 : H12AffineFastState.composeSystem env6751 rootObs = leafEnv6751 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6751 rootObs == leafEnv6751) = true)

theorem terminalChecked6751 : H12PackedTerminal.terminalCheckFast leafEnv6751 active6751 tree6751 = true := by decide +kernel

def env6752 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,8,16384,32768,65536,4097,262144,256,32768,4096,4194304,16385,16777216,16859281,16875797,21352449,16896276,4096,20978078,16875777,4294967296,257,4315972014,4097,16859288]

theorem envBound6752 : H12AffineFastState.Bounded env6752 := by
  intro p hp
  have h : env6752.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6729_6752 : H12AffineEnvironment.transform 9 257 env6729 = env6752 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 257 env6729 == env6752) = true)

theorem identity6752 : scanCanonicalize (H12AffineFastState.compose env6752 (packedSelected [0,3,4,7,9,10,13,16,17,20,21,24,26,33] rootPS)) = affineNative (2^(23+1) ^^^ 81936) := by decide +kernel

theorem selectedBound6752 : packedSelected [0,3,4,7,9,10,13,16,17,20,21,24,26,33] rootPS < 2^1333 := by decide +kernel

def env6753 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,8,16384,32768,65536,4097,262144,256,32768,4096,4194304,16385,81936,129,49413,4493329,37124,4096,4282766,49425,4294967296,257,4299276734,4097,136]

theorem envBound6753 : H12AffineFastState.Bounded env6753 := by
  intro p hp
  have h : env6753.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6752_6753 : H12AffineEnvironment.transform 23 81936 env6752 = env6753 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 81936 env6752 == env6753) = true)

theorem identity6753 : scanCanonicalize (H12AffineFastState.compose env6753 (packedSelected [3,4,9,10,16,24,26] rootPS)) = affineNative (2^(14+1) ^^^ 20740) := by decide +kernel

theorem selectedBound6753 : packedSelected [3,4,9,10,16,24,26] rootPS < 2^1333 := by decide +kernel

def env6754 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,8,16384,20740,65536,4097,262144,256,20740,4096,4194304,16385,81936,129,4097,4473109,16384,4096,4282766,4117,4294967296,257,4299231418,4097,136]

theorem envBound6754 : H12AffineFastState.Bounded env6754 := by
  intro p hp
  have h : env6754.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6753_6754 : H12AffineEnvironment.transform 14 20740 env6753 = env6754 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 20740 env6753 == env6754) = true)

theorem identity6754 : scanCanonicalize (H12AffineFastState.compose env6754 (packedSelected [4,5,8,9,16,17,21] rootPS)) = affineNative (2^(11+1) ^^^ 17) := by decide +kernel

theorem selectedBound6754 : packedSelected [4,5,8,9,16,17,21] rootPS < 2^1333 := by decide +kernel

def env6755 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,17,8,16384,16661,65536,16,262144,256,16661,17,4194304,16385,81936,129,16,4473109,16384,17,4278687,4,4294967296,257,4299227307,16,136]

theorem envBound6755 : H12AffineFastState.Bounded env6755 := by
  intro p hp
  have h : env6755.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6754_6755 : H12AffineEnvironment.transform 11 17 env6754 = env6755 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 17 env6754 == env6755) = true)

theorem identity6755 : scanCanonicalize (H12AffineFastState.compose env6755 (packedSelected [3,5,6,10] rootPS)) = affineNative (2^(31+1) ^^^ 4538653) := by decide +kernel

theorem selectedBound6755 : packedSelected [3,5,6,10] rootPS < 2^1333 := by decide +kernel

def env6756 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,17,8,16384,16661,65536,16,262144,256,16661,17,4194304,16385,81936,129,16,4473109,16384,17,4278687,4,4538653,257,278966,16,136]

theorem envBound6756 : H12AffineFastState.Bounded env6756 := by
  intro p hp
  have h : env6756.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6755_6756 : H12AffineEnvironment.transform 31 4538653 env6755 = env6756 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4538653 env6755 == env6756) = true)

theorem identity6756 : scanCanonicalize (H12AffineFastState.compose env6756 (packedSelected [1,3,5,6,8,12,15] rootPS)) = affineNative (2^(21+1) ^^^ 280853) := by decide +kernel

theorem selectedBound6756 : packedSelected [1,3,5,6,8,12,15] rootPS < 2^1333 := by decide +kernel

def env6757 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,17,8,16384,16661,65536,16,262144,256,16661,17,280853,16385,81936,129,16,2048,16384,17,327818,4,67592,257,278966,16,136]

theorem envBound6757 : H12AffineFastState.Bounded env6757 := by
  intro p hp
  have h : env6757.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6756_6757 : H12AffineEnvironment.transform 21 280853 env6756 = env6757 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 280853 env6756 == env6757) = true)

theorem identity6757 : scanCanonicalize (H12AffineFastState.compose env6757 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(13+1) ^^^ 16) := by decide +kernel

theorem selectedBound6757 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env6758 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,17,8,16,261,65536,16,262144,256,261,17,264453,17,65536,129,16,2048,16,17,327818,4,67592,257,262566,16,136]

theorem envBound6758 : H12AffineFastState.Bounded env6758 := by
  intro p hp
  have h : env6758.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6757_6758 : H12AffineEnvironment.transform 13 16 env6757 = env6758 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 16 env6757 == env6758) = true)

theorem identity6758 : scanCanonicalize (H12AffineFastState.compose env6758 (packedSelected [1,3,5] rootPS)) = affineNative (2^(15+1) ^^^ 268) := by decide +kernel

theorem selectedBound6758 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env6759 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,17,8,16,261,268,16,262144,256,261,17,264453,17,268,129,16,2048,16,17,262534,4,2308,257,262566,16,136]

theorem envBound6759 : H12AffineFastState.Bounded env6759 := by
  intro p hp
  have h : env6759.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6758_6759 : H12AffineEnvironment.transform 15 268 env6758 = env6759 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 268 env6758 == env6759) = true)

theorem identity6759 : scanCanonicalize (H12AffineFastState.compose env6759 (packedSelected [6] rootPS)) = affineNative (2^(17+1) ^^^ 2211) := by decide +kernel

theorem selectedBound6759 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6760 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,17,8,16,261,268,16,2211,256,261,17,422,17,268,129,16,2048,16,17,2341,4,2308,257,2309,16,136]

theorem envBound6760 : H12AffineFastState.Bounded env6760 := by
  intro p hp
  have h : env6760.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6759_6760 : H12AffineEnvironment.transform 17 2211 env6759 = env6760 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2211 env6759 == env6760) = true)

theorem identity6760 : scanCanonicalize (H12AffineFastState.compose env6760 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound6760 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6761 : List Nat := [2,4,8,16,32,17,3,256,10,257,2048,17,8,16,261,268,16,2080,256,261,17,293,17,268,2,16,2048,16,17,2341,4,2308,257,2309,16,11]

theorem envBound6761 : H12AffineFastState.Bounded env6761 := by
  intro p hp
  have h : env6761.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6760_6761 : H12AffineEnvironment.transform 6 3 env6760 = env6761 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env6760 == env6761) = true)

theorem identity6761 : scanCanonicalize (H12AffineFastState.compose env6761 (packedSelected [2] rootPS)) = affineNative (2^(10+1) ^^^ 33) := by decide +kernel

theorem selectedBound6761 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6762 : List Nat := [2,4,8,16,32,17,3,256,10,257,33,17,8,16,261,268,16,1,256,261,17,293,17,268,2,16,33,16,17,260,4,293,257,292,16,11]

theorem envBound6762 : H12AffineFastState.Bounded env6762 := by
  intro p hp
  have h : env6762.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6761_6762 : H12AffineEnvironment.transform 10 33 env6761 = env6762 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 33 env6761 == env6762) = true)

theorem identity6762 : scanCanonicalize (H12AffineFastState.compose env6762 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 52) := by decide +kernel

theorem selectedBound6762 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6763 : List Nat := [2,4,8,16,32,17,3,52,10,53,33,17,8,16,49,56,16,1,52,49,17,17,17,56,2,16,33,16,17,48,4,17,53,16,16,11]

theorem envBound6763 : H12AffineFastState.Bounded env6763 := by
  intro p hp
  have h : env6763.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6762_6763 : H12AffineEnvironment.transform 7 52 env6762 = env6763 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 52 env6762 == env6763) = true)

def env6764 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,4194304,17664,16777216,33554432,67108864,21352529,67130624,131152,1073741824,16876544,4294967296,257,4417151347,131072,33563272]

theorem envBound6764 : H12AffineFastState.Bounded env6764 := by
  intro p hp
  have h : env6764.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6398_6764 : H12AffineEnvironment.transform 20 4097 env6398 = env6764 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env6398 == env6764) = true)

theorem identity6764 : scanCanonicalize (H12AffineFastState.compose env6764 (packedSelected [35] rootPS)) = affineNative (2^(23+1) ^^^ 230469) := by decide +kernel

theorem selectedBound6764 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env6765 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,4194304,17664,230469,33554432,67108864,4609044,67130624,131152,1073741824,131141,4294967296,257,4400604470,131072,33563272]

theorem envBound6765 : H12AffineFastState.Bounded env6765 := by
  intro p hp
  have h : env6765.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6764_6765 : H12AffineEnvironment.transform 23 230469 env6764 = env6765 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230469 env6764 == env6765) = true)

def env6766 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1024,32768,4097,4194304,17664,230469,33554432,67108864,4609044,67130624,131152,1073741824,131141,4294967296,257,4400079158,131072,33563272]

theorem envBound6766 : H12AffineFastState.Bounded env6766 := by
  intro p hp
  have h : env6766.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6765_6766 : H12AffineEnvironment.transform 18 1024 env6765 = env6766 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env6765 == env6766) = true)

theorem identity6766 : scanCanonicalize (H12AffineFastState.compose env6766 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 71421402) := by decide +kernel

theorem selectedBound6766 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env6767 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1024,32768,4097,4194304,17664,230469,33554432,67108864,4609044,67130624,131152,71421402,131141,4294967296,257,4400079158,131072,33563272]

theorem envBound6767 : H12AffineFastState.Bounded env6767 := by
  intro p hp
  have h : env6767.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6766_6767 : H12AffineEnvironment.transform 29 71421402 env6766 = env6767 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 71421402 env6766 == env6767) = true)

def env6768 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1024,32768,4097,4194304,5456,230469,33554432,67108864,4588612,67110224,131152,71409034,131141,4294967296,257,4400066918,131072,33563272]

theorem envBound6768 : H12AffineFastState.Bounded env6768 := by
  intro p hp
  have h : env6768.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6767_6768 : H12AffineEnvironment.transform 13 4176 env6767 = env6768 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env6767 == env6768) = true)

theorem identity6768 : scanCanonicalize (H12AffineFastState.compose env6768 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(25+1) ^^^ 5377) := by decide +kernel

theorem selectedBound6768 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env6769 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1024,32768,4097,4194304,5456,230469,33554432,5377,4588612,4177,131152,4294795,131141,4294967296,257,4332954727,131072,33563272]

theorem envBound6769 : H12AffineFastState.Bounded env6769 := by
  intro p hp
  have h : env6769.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6768_6769 : H12AffineEnvironment.transform 25 5377 env6768 = env6769 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env6768 == env6769) = true)

def env6770 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1024,32768,4097,4194304,5457,230469,33554432,67108864,4588613,67110225,131152,71409035,131141,4294967296,257,4400066919,131072,33563272]

theorem envBound6770 : H12AffineFastState.Bounded env6770 := by
  intro p hp
  have h : env6770.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6767_6770 : H12AffineEnvironment.transform 13 4177 env6767 = env6770 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env6767 == env6770) = true)

theorem identity6770 : scanCanonicalize (H12AffineFastState.compose env6770 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(25+1) ^^^ 33568137) := by decide +kernel

theorem selectedBound6770 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env6771 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1024,32768,4097,4194304,5457,230469,33554432,33568137,4588613,33566936,131152,37857282,131141,4294967296,257,4299392238,131072,33563272]

theorem envBound6771 : H12AffineFastState.Bounded env6771 := by
  intro p hp
  have h : env6771.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6770_6771 : H12AffineEnvironment.transform 25 33568137 env6770 = env6771 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 33568137 env6770 == env6771) = true)

theorem identity6771 : scanCanonicalize (H12AffineFastState.compose env6771 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(24+1) ^^^ 8328) := by decide +kernel

theorem selectedBound6771 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env6772 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1024,32768,4097,4194304,5457,230469,8328,5377,4588613,4176,131152,4294794,131141,4294967296,257,4299392238,131072,512]

theorem envBound6772 : H12AffineFastState.Bounded env6772 := by
  intro p hp
  have h : env6772.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6771_6772 : H12AffineEnvironment.transform 24 8328 env6771 = env6772 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8328 env6771 == env6772) = true)

theorem identity6772 : scanCanonicalize (H12AffineFastState.compose env6772 (packedSelected [4,9,16] rootPS)) = affineNative (2^(21+1) ^^^ 396) := by decide +kernel

theorem selectedBound6772 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env6773 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1024,32768,4097,396,5457,230469,8328,5377,394697,4176,131152,100614,131141,4294967296,257,4295198050,131072,512]

theorem envBound6773 : H12AffineFastState.Bounded env6773 := by
  intro p hp
  have h : env6773.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6772_6773 : H12AffineEnvironment.transform 21 396 env6772 = env6773 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 396 env6772 == env6773) = true)

theorem identity6773 : scanCanonicalize (H12AffineFastState.compose env6773 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(16+1) ^^^ 1345) := by decide +kernel

theorem selectedBound6773 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env6774 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,1345,262144,1024,32768,4097,396,5457,98564,8328,5377,262280,4176,1297,100614,1284,4294967296,257,4295065635,1345,512]

theorem envBound6774 : H12AffineFastState.Bounded env6774 := by
  intro p hp
  have h : env6774.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6773_6774 : H12AffineEnvironment.transform 16 1345 env6773 = env6774 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env6773 == env6774) = true)

theorem identity6774 : scanCanonicalize (H12AffineFastState.compose env6774 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 70710) := by decide +kernel

theorem selectedBound6774 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6775 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,1345,262144,1024,32768,4097,396,5457,98564,8328,5377,262280,4176,1297,100614,1284,70710,257,37909,1345,512]

theorem envBound6775 : H12AffineFastState.Bounded env6775 := by
  intro p hp
  have h : env6775.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6774_6775 : H12AffineEnvironment.transform 31 70710 env6774 = env6775 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 70710 env6774 == env6775) = true)

theorem identity6775 : scanCanonicalize (H12AffineFastState.compose env6775 (packedSelected [3,5,10] rootPS)) = affineNative (2^(14+1) ^^^ 2009) := by decide +kernel

theorem selectedBound6775 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env6776 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,2009,65536,1345,262144,1024,2009,4097,396,5457,67293,8328,5377,262280,4176,1297,69343,1284,70710,257,5068,1345,512]

theorem envBound6776 : H12AffineFastState.Bounded env6776 := by
  intro p hp
  have h : env6776.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6775_6776 : H12AffineEnvironment.transform 14 2009 env6775 = env6776 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2009 env6775 == env6776) = true)

theorem identity6776 : scanCanonicalize (H12AffineFastState.compose env6776 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 1623) := by decide +kernel

theorem selectedBound6776 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env6777 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,2009,1623,1345,262144,1024,2009,4097,396,5457,138,8328,5377,262280,4176,1297,2184,1284,4705,257,5068,1345,512]

theorem envBound6777 : H12AffineFastState.Bounded env6777 := by
  intro p hp
  have h : env6777.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6776_6777 : H12AffineEnvironment.transform 15 1623 env6776 = env6777 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 1623 env6776 == env6777) = true)

theorem identity6777 : scanCanonicalize (H12AffineFastState.compose env6777 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(17+1) ^^^ 10620) := by decide +kernel

theorem selectedBound6777 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env6778 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,2009,1623,1345,10620,1024,2009,4097,396,5457,138,8328,5377,10740,4176,1297,2184,1284,4705,257,5068,1345,512]

theorem envBound6778 : H12AffineFastState.Bounded env6778 := by
  intro p hp
  have h : env6778.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6777_6778 : H12AffineEnvironment.transform 17 10620 env6777 = env6778 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 10620 env6777 == env6778) = true)

theorem identity6778 : scanCanonicalize (H12AffineFastState.compose env6778 (packedSelected [0,7,20] rootPS)) = affineNative (2^(9+1) ^^^ 653) := by decide +kernel

theorem selectedBound6778 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env6779 : List Nat := [2,4,8,16,32,64,128,256,512,653,2048,4096,8192,4177,340,218,972,10620,653,340,4097,396,5084,138,8328,5004,10740,4176,924,2184,905,4705,257,5068,972,512]

theorem envBound6779 : H12AffineFastState.Bounded env6779 := by
  intro p hp
  have h : env6779.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6778_6779 : H12AffineEnvironment.transform 9 653 env6778 = env6779 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 653 env6778 == env6779) = true)

theorem identity6779 : scanCanonicalize (H12AffineFastState.compose env6779 (packedSelected [0,2,4,11] rootPS)) = affineNative (2^(11+1) ^^^ 2154) := by decide +kernel

theorem selectedBound6779 : packedSelected [0,2,4,11] rootPS < 2^1333 := by decide +kernel

def env6780 : List Nat := [2,4,8,16,32,64,128,256,512,653,2048,2154,8192,2107,340,218,972,10620,653,340,2155,396,2998,138,8328,3046,10740,2106,924,2184,905,2571,257,2982,972,512]

theorem envBound6780 : H12AffineFastState.Bounded env6780 := by
  intro p hp
  have h : env6780.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6779_6780 : H12AffineEnvironment.transform 11 2154 env6779 = env6780 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 2154 env6779 == env6780) = true)

theorem identity6780 : scanCanonicalize (H12AffineFastState.compose env6780 (packedSelected [3,5,12,13] rootPS)) = affineNative (2^(12+1) ^^^ 2423) := by decide +kernel

theorem selectedBound6780 : packedSelected [3,5,12,13] rootPS < 2^1333 := by decide +kernel

def env6781 : List Nat := [2,4,8,16,32,64,128,256,512,653,2048,2154,2423,2107,340,218,972,11,653,340,2155,396,2998,138,2559,3046,131,2106,924,2184,905,2571,257,2982,972,512]

theorem envBound6781 : H12AffineFastState.Bounded env6781 := by
  intro p hp
  have h : env6781.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6780_6781 : H12AffineEnvironment.transform 12 2423 env6780 = env6781 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2423 env6780 == env6781) = true)

theorem identity6781 : scanCanonicalize (H12AffineFastState.compose env6781 (packedSelected [3,12] rootPS)) = affineNative (2^(10+1) ^^^ 555) := by decide +kernel

theorem selectedBound6781 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env6782 : List Nat := [2,4,8,16,32,64,128,256,512,653,555,577,860,528,340,218,972,11,653,340,576,396,413,138,980,461,131,529,924,675,905,32,257,397,972,512]

theorem envBound6782 : H12AffineFastState.Bounded env6782 := by
  intro p hp
  have h : env6782.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6781_6782 : H12AffineEnvironment.transform 10 555 env6781 = env6782 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 555 env6781 == env6782) = true)

theorem identity6782 : scanCanonicalize (H12AffineFastState.compose env6782 (packedSelected [5,21] rootPS)) = affineNative (2^(8+1) ^^^ 261) := by decide +kernel

theorem selectedBound6782 : packedSelected [5,21] rootPS < 2^1333 := by decide +kernel

def env6783 : List Nat := [2,4,8,16,32,64,128,256,261,392,302,324,89,277,340,218,201,11,392,340,325,396,413,138,209,461,131,276,153,422,140,32,257,397,201,261]

theorem envBound6783 : H12AffineFastState.Bounded env6783 := by
  intro p hp
  have h : env6783.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6782_6783 : H12AffineEnvironment.transform 8 261 env6782 = env6783 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 261 env6782 == env6783) = true)

def env6784 : List Nat := [2,4,8,16,32,64,8,256,261,256,302,324,89,277,340,82,65,11,256,340,325,260,277,2,89,325,11,276,17,302,4,32,257,261,65,261]

theorem envBound6784 : H12AffineFastState.Bounded env6784 := by
  intro p hp
  have h : env6784.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6783_6784 : H12AffineEnvironment.transform 6 8 env6783 = env6784 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env6783 == env6784) = true)

theorem identity6784 : scanCanonicalize (H12AffineFastState.compose env6784 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 13) := by decide +kernel

theorem selectedBound6784 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6785 : List Nat := [2,4,8,16,32,64,8,13,8,13,35,73,89,24,89,82,65,11,13,89,72,9,24,2,89,72,11,25,17,35,4,32,12,8,65,8]

theorem envBound6785 : H12AffineFastState.Bounded env6785 := by
  intro p hp
  have h : env6785.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6784_6785 : H12AffineEnvironment.transform 7 13 env6784 = env6785 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 13 env6784 == env6785) = true)

def env6786 : List Nat := [2,4,8,16,32,24,8,13,8,13,35,17,1,24,1,10,25,11,13,1,16,9,24,2,1,16,11,25,17,35,4,32,12,8,25,8]

theorem envBound6786 : H12AffineFastState.Bounded env6786 := by
  intro p hp
  have h : env6786.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6785_6786 : H12AffineEnvironment.transform 5 24 env6785 = env6786 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 24 env6785 == env6786) = true)

theorem identity6786 : scanCanonicalize (H12AffineFastState.compose env6786 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 9) := by decide +kernel

theorem selectedBound6786 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6787 : List Nat := [2,4,8,16,9,24,8,13,8,13,10,17,1,24,1,10,25,11,13,1,16,9,24,2,1,16,11,25,17,10,4,9,12,8,25,8]

theorem envBound6787 : H12AffineFastState.Bounded env6787 := by
  intro p hp
  have h : env6787.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6786_6787 : H12AffineEnvironment.transform 4 9 env6786 = env6787 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 9 env6786 == env6787) = true)

def env6788 : List Nat := [2,4,8,16,32,25,8,13,8,13,35,16,0,24,0,11,24,11,13,0,17,9,24,2,0,17,11,25,17,35,4,32,12,8,24,8]

theorem envBound6788 : H12AffineFastState.Bounded env6788 := by
  intro p hp
  have h : env6788.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6785_6788 : H12AffineEnvironment.transform 5 25 env6785 = env6788 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 25 env6785 == env6788) = true)

theorem identity6788 : scanCanonicalize (H12AffineFastState.compose env6788 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 3) := by decide +kernel

theorem selectedBound6788 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6789 : List Nat := [2,4,8,16,3,25,8,13,8,13,0,16,0,24,0,11,24,11,13,0,17,9,24,2,0,17,11,25,17,0,4,3,12,8,24,8]

theorem envBound6789 : H12AffineFastState.Bounded env6789 := by
  intro p hp
  have h : env6789.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6788_6789 : H12AffineEnvironment.transform 4 3 env6788 = env6789 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 3 env6788 == env6789) = true)

theorem identity6789 : scanCanonicalize (H12AffineFastState.compose env6789 (packedSelected [2] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound6789 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6790 : List Nat := [0,4,8,16,1,25,8,13,8,13,0,16,0,24,0,9,24,9,13,0,17,9,24,0,0,17,9,25,17,0,4,1,12,8,24,8]

theorem envBound6790 : H12AffineFastState.Bounded env6790 := by
  intro p hp
  have h : env6790.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6789_6790 : H12AffineEnvironment.transform 0 0 env6789 = env6790 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env6789 == env6790) = true)

theorem identity6790 : scanCanonicalize (H12AffineFastState.compose env6790 (packedSelected [4] rootPS)) = affineNative (2^(2+1) ^^^ 0) := by decide +kernel

theorem selectedBound6790 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env6791 : List Nat := [0,4,0,16,1,17,0,5,0,5,0,16,0,16,0,1,16,1,5,0,17,1,16,0,0,17,1,17,17,0,4,1,4,0,16,0]

theorem envBound6791 : H12AffineFastState.Bounded env6791 := by
  intro p hp
  have h : env6791.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6790_6791 : H12AffineEnvironment.transform 2 0 env6790 = env6791 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env6790 == env6791) = true)

def leafEnv6791 : List Nat := [0,4,0,16,1,17,0,5,0,5,0,16,0,16,0,1,16,1,5,0,17,1,16,0,4,0,1,17,1,17,17,0,4,1,4,0,5,1,16,0,0,17,1]

def active6791 : List Nat := [1,3]

def tree6791 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6791 : H12WitnessSearch.Good tree6791 := H12GlobalWitnessIndex.good

theorem leafIdentity6791 : H12AffineFastState.composeSystem env6791 rootObs = leafEnv6791 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6791 rootObs == leafEnv6791) = true)

theorem terminalChecked6791 : H12PackedTerminal.terminalCheckFast leafEnv6791 active6791 tree6791 = true := by decide +kernel

def env6792 : List Nat := [2,4,8,16,32,64,9,256,261,257,302,324,89,277,340,83,64,11,257,340,325,261,276,3,88,324,10,276,16,303,5,32,257,260,64,261]

theorem envBound6792 : H12AffineFastState.Bounded env6792 := by
  intro p hp
  have h : env6792.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6783_6792 : H12AffineEnvironment.transform 6 9 env6783 = env6792 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env6783 == env6792) = true)

theorem identity6792 : scanCanonicalize (H12AffineFastState.compose env6792 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 118) := by decide +kernel

theorem selectedBound6792 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6793 : List Nat := [2,4,8,16,32,64,9,118,115,119,88,50,89,99,34,83,64,11,119,34,51,115,98,3,88,50,10,98,16,89,5,32,119,114,64,115]

theorem envBound6793 : H12AffineFastState.Bounded env6793 := by
  intro p hp
  have h : env6793.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6792_6793 : H12AffineEnvironment.transform 7 118 env6792 = env6793 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 118 env6792 == env6793) = true)

theorem identity6793 : scanCanonicalize (H12AffineFastState.compose env6793 (packedSelected [1,3] rootPS)) = affineNative (2^(4+1) ^^^ 2) := by decide +kernel

theorem selectedBound6793 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env6794 : List Nat := [2,4,8,16,2,64,9,84,81,85,88,16,89,65,0,83,64,11,85,0,17,81,64,3,88,16,10,64,16,89,5,2,85,80,64,81]

theorem envBound6794 : H12AffineFastState.Bounded env6794 := by
  intro p hp
  have h : env6794.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6793_6794 : H12AffineEnvironment.transform 4 2 env6793 = env6794 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 2 env6793 == env6794) = true)

theorem identity6794 : scanCanonicalize (H12AffineFastState.compose env6794 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 19) := by decide +kernel

theorem selectedBound6794 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6795 : List Nat := [2,4,8,16,2,19,9,7,2,6,11,16,10,18,0,0,19,11,6,0,17,2,19,3,11,16,10,19,16,10,5,2,6,3,19,2]

theorem envBound6795 : H12AffineFastState.Bounded env6795 := by
  intro p hp
  have h : env6795.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6794_6795 : H12AffineEnvironment.transform 5 19 env6794 = env6795 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 19 env6794 == env6795) = true)

def env6796 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1025,32768,4097,4194304,17664,230469,33554432,67108864,4609044,67130624,131152,1073741824,131141,4294967296,257,4400079159,131072,33563272]

theorem envBound6796 : H12AffineFastState.Bounded env6796 := by
  intro p hp
  have h : env6796.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6765_6796 : H12AffineEnvironment.transform 18 1025 env6765 = env6796 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env6765 == env6796) = true)

theorem identity6796 : scanCanonicalize (H12AffineFastState.compose env6796 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 71409035) := by decide +kernel

theorem selectedBound6796 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env6797 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1025,32768,4097,4194304,17664,230469,33554432,67108864,4609044,67130624,131152,71409035,131141,4294967296,257,4400079159,131072,33563272]

theorem envBound6797 : H12AffineFastState.Bounded env6797 := by
  intro p hp
  have h : env6797.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6796_6797 : H12AffineEnvironment.transform 29 71409035 env6796 = env6797 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 71409035 env6796 == env6797) = true)

def env6798 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1025,32768,4097,4194304,5456,230469,33554432,67108864,4588612,67110224,131152,71409035,131141,4294967296,257,4400066919,131072,33563272]

theorem envBound6798 : H12AffineFastState.Bounded env6798 := by
  intro p hp
  have h : env6798.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6797_6798 : H12AffineEnvironment.transform 13 4176 env6797 = env6798 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env6797 == env6798) = true)

theorem identity6798 : scanCanonicalize (H12AffineFastState.compose env6798 (packedSelected [1,3,6,10,19,24,25,26,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound6798 : packedSelected [1,3,6,10,19,24,25,26,28,31] rootPS < 2^1333 := by decide +kernel

def env6799 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1025,32768,4097,4194304,5456,230469,8329,67108864,4588612,67110224,131152,71409035,131141,4294967296,257,4366504430,131072,513]

theorem envBound6799 : H12AffineFastState.Bounded env6799 := by
  intro p hp
  have h : env6799.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6798_6799 : H12AffineEnvironment.transform 24 8329 env6798 = env6799 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env6798 == env6799) = true)

theorem identity6799 : scanCanonicalize (H12AffineFastState.compose env6799 (packedSelected [0,4,7,16,20,22] rootPS)) = affineNative (2^(25+1) ^^^ 5376) := by decide +kernel

theorem selectedBound6799 : packedSelected [0,4,7,16,20,22] rootPS < 2^1333 := by decide +kernel

def env6800 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1025,32768,4097,4194304,5456,230469,8329,5376,4588612,4176,131152,4294795,131141,4294967296,257,4299392238,131072,513]

theorem envBound6800 : H12AffineFastState.Bounded env6800 := by
  intro p hp
  have h : env6800.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6799_6800 : H12AffineEnvironment.transform 25 5376 env6799 = env6800 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env6799 == env6800) = true)

theorem identity6800 : scanCanonicalize (H12AffineFastState.compose env6800 (packedSelected [13,21] rootPS)) = affineNative (2^(31+1) ^^^ 4329688) := by decide +kernel

theorem selectedBound6800 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env6801 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1025,32768,4097,4194304,5456,230469,8329,5376,4588612,4176,131152,4294795,131141,4329688,257,103478,131072,513]

theorem envBound6801 : H12AffineFastState.Bounded env6801 := by
  intro p hp
  have h : env6801.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6800_6801 : H12AffineEnvironment.transform 31 4329688 env6800 = env6801 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4329688 env6800 == env6801) = true)

def env6802 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1025,32768,4097,4194304,5457,230469,33554432,67108864,4588613,67110225,131152,71409035,131141,4294967296,257,4400066918,131072,33563272]

theorem envBound6802 : H12AffineFastState.Bounded env6802 := by
  intro p hp
  have h : env6802.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6797_6802 : H12AffineEnvironment.transform 13 4177 env6797 = env6802 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env6797 == env6802) = true)

def env6803 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1025,32768,4097,4194304,5457,230469,4259840,67108864,4588613,67110225,131152,71409035,131141,4294967296,257,4362252646,131072,4268680]

theorem envBound6803 : H12AffineFastState.Bounded env6803 := by
  intro p hp
  have h : env6803.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6802_6803 : H12AffineEnvironment.transform 24 4259840 env6802 = env6803 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 4259840 env6802 == env6803) = true)

def env6804 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4096,262144,1025,32768,4097,4194304,5457,103493,4259840,67108864,4461637,67110225,4176,71409035,4165,4294967296,257,4362117478,4096,4268680]

theorem envBound6804 : H12AffineFastState.Bounded env6804 := by
  intro p hp
  have h : env6804.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6803_6804 : H12AffineEnvironment.transform 16 4096 env6803 = env6804 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env6803 == env6804) = true)

theorem identity6804 : scanCanonicalize (H12AffineFastState.compose env6804 (packedSelected [3,5,24] rootPS)) = affineNative (2^(21+1) ^^^ 360576) := by decide +kernel

theorem selectedBound6804 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env6805 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4096,262144,1025,32768,4097,360576,5457,103493,295040,67108864,103621,67110225,4176,67378443,4165,4294967296,257,4362117478,4096,303624]

theorem envBound6805 : H12AffineFastState.Bounded env6805 := by
  intro p hp
  have h : env6805.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6804_6805 : H12AffineEnvironment.transform 21 360576 env6804 = env6805 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 360576 env6804 == env6805) = true)

def env6806 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4096,262144,1025,32768,4097,360576,5377,103445,295040,67108864,103573,67110145,4096,67378443,4117,4294967296,257,4362117430,4096,303624]

theorem envBound6806 : H12AffineFastState.Bounded env6806 := by
  intro p hp
  have h : env6806.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6805_6806 : H12AffineEnvironment.transform 5 16 env6805 = env6806 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env6805 == env6806) = true)

theorem identity6806 : scanCanonicalize (H12AffineFastState.compose env6806 (packedSelected [1,3,8,17,21] rootPS)) = affineNative (2^(17+1) ^^^ 43048) := by decide +kernel

theorem selectedBound6806 : packedSelected [1,3,8,17,21] rootPS < 2^1333 := by decide +kernel

def env6807 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4096,43048,1025,32768,4097,75944,5377,103445,10408,67108864,103573,67110145,4096,67155235,4117,4294967296,257,4362117430,4096,2592]

theorem envBound6807 : H12AffineFastState.Bounded env6807 := by
  intro p hp
  have h : env6807.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6806_6807 : H12AffineEnvironment.transform 17 43048 env6806 = env6807 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43048 env6806 == env6807) = true)

theorem identity6807 : scanCanonicalize (H12AffineFastState.compose env6807 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(15+1) ^^^ 40127) := by decide +kernel

theorem selectedBound6807 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env6808 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,40127,4096,43048,1025,32768,4097,46103,5377,2218,10408,67108864,2090,67110145,4096,67155235,4117,4294967296,257,4362117430,4096,2592]

theorem envBound6808 : H12AffineFastState.Bounded env6808 := by
  intro p hp
  have h : env6808.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6807_6808 : H12AffineEnvironment.transform 15 40127 env6807 = env6808 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 40127 env6807 == env6808) = true)

theorem identity6808 : scanCanonicalize (H12AffineFastState.compose env6808 (packedSelected [0,4,7,10,11,12,13,15,16,17,19,22,23] rootPS)) = affineNative (2^(25+1) ^^^ 7457) := by decide +kernel

theorem selectedBound6808 : packedSelected [0,4,7,10,11,12,13,15,16,17,19,22,23] rootPS < 2^1333 := by decide +kernel

def env6809 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,40127,4096,43048,1025,32768,4097,46103,5377,2218,10408,7457,2090,6176,4096,43010,4117,4294967296,257,4295015447,4096,2592]

theorem envBound6809 : H12AffineFastState.Bounded env6809 := by
  intro p hp
  have h : env6809.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6808_6809 : H12AffineEnvironment.transform 25 7457 env6808 = env6809 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 7457 env6808 == env6809) = true)

theorem identity6809 : scanCanonicalize (H12AffineFastState.compose env6809 (packedSelected [0,1,2,3,4,6,8,11,16,20] rootPS)) = affineNative (2^(14+1) ^^^ 6034) := by decide +kernel

theorem selectedBound6809 : packedSelected [0,1,2,3,4,6,8,11,16,20] rootPS < 2^1333 := by decide +kernel

def env6810 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,6034,2861,4096,16314,1025,6034,4097,9093,5377,2218,10408,7457,2090,6176,4096,16272,4117,4294967296,257,4294978437,4096,2592]

theorem envBound6810 : H12AffineFastState.Bounded env6810 := by
  intro p hp
  have h : env6810.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6809_6810 : H12AffineEnvironment.transform 14 6034 env6809 = env6810 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 6034 env6809 == env6810) = true)

theorem identity6810 : scanCanonicalize (H12AffineFastState.compose env6810 (packedSelected [1,2,3,6,7,9,10,13,15,16,18] rootPS)) = affineNative (2^(12+1) ^^^ 2088) := by decide +kernel

theorem selectedBound6810 : packedSelected [1,2,3,6,7,9,10,13,15,16,18] rootPS < 2^1333 := by decide +kernel

def env6811 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,2088,4097,6034,2861,4096,6034,1025,6034,4097,2989,5377,2218,128,7457,2090,6176,4096,6072,4117,4294967296,257,4294968237,4096,2592]

theorem envBound6811 : H12AffineFastState.Bounded env6811 := by
  intro p hp
  have h : env6811.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6810_6811 : H12AffineEnvironment.transform 12 2088 env6810 = env6811 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2088 env6810 == env6811) = true)

theorem identity6811 : scanCanonicalize (H12AffineFastState.compose env6811 (packedSelected [0,1,2,3,4,6,9,10,11,13,15,22] rootPS)) = affineNative (2^(8+1) ^^^ 391) := by decide +kernel

theorem selectedBound6811 : packedSelected [0,1,2,3,4,6,9,10,11,13,15,22] rootPS < 2^1333 := by decide +kernel

def env6812 : List Nat := [2,4,8,16,32,16,128,256,391,1024,2048,4096,2088,4097,5141,2218,4096,5141,1025,5141,4097,2090,5377,2218,128,7457,2090,6176,4096,5183,4117,4294967296,257,4294967338,4096,2471]

theorem envBound6812 : H12AffineFastState.Bounded env6812 := by
  intro p hp
  have h : env6812.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6811_6812 : H12AffineEnvironment.transform 8 391 env6811 = env6812 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 391 env6811 == env6812) = true)

theorem identity6812 : scanCanonicalize (H12AffineFastState.compose env6812 (packedSelected [0,1,2,3,4,5,6] rootPS)) = affineNative (2^(7+1) ^^^ 135) := by decide +kernel

theorem selectedBound6812 : packedSelected [0,1,2,3,4,5,6] rootPS < 2^1333 := by decide +kernel

def env6813 : List Nat := [2,4,8,16,32,16,128,135,0,1024,2048,4096,2088,4097,5141,2218,4096,5141,1025,5141,4097,2090,5254,2218,128,7334,2090,6176,4096,5183,4117,4294967296,134,4294967338,4096,2080]

theorem envBound6813 : H12AffineFastState.Bounded env6813 := by
  intro p hp
  have h : env6813.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6812_6813 : H12AffineEnvironment.transform 7 135 env6812 = env6813 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 135 env6812 == env6813) = true)

theorem identity6813 : scanCanonicalize (H12AffineFastState.compose env6813 (packedSelected [11] rootPS)) = affineNative (2^(11+1) ^^^ 3255) := by decide +kernel

theorem selectedBound6813 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env6814 : List Nat := [2,4,8,16,32,16,128,135,0,1024,2048,3255,2088,3254,2210,2218,3255,2210,1025,2210,3254,2090,2097,2218,128,17,2090,1175,3255,2184,3234,4294967296,134,4294967338,3255,2080]

theorem envBound6814 : H12AffineFastState.Bounded env6814 := by
  intro p hp
  have h : env6814.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6813_6814 : H12AffineEnvironment.transform 11 3255 env6813 = env6814 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3255 env6813 == env6814) = true)

theorem identity6814 : scanCanonicalize (H12AffineFastState.compose env6814 (packedSelected [1,3,8] rootPS)) = affineNative (2^(10+1) ^^^ 32) := by decide +kernel

theorem selectedBound6814 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env6815 : List Nat := [2,4,8,16,32,16,128,135,0,1024,32,1175,8,1174,130,138,1175,130,1025,130,1174,10,17,138,128,17,10,1175,1175,168,1154,4294967296,134,4294967338,1175,0]

theorem envBound6815 : H12AffineFastState.Bounded env6815 := by
  intro p hp
  have h : env6815.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6814_6815 : H12AffineEnvironment.transform 10 32 env6814 = env6815 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 32 env6814 == env6815) = true)

theorem identity6815 : scanCanonicalize (H12AffineFastState.compose env6815 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 34) := by decide +kernel

theorem selectedBound6815 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6816 : List Nat := [2,4,8,16,32,16,34,37,0,1024,32,1077,8,1076,32,40,1077,32,1025,32,1076,10,17,40,34,17,10,1077,1077,10,1056,4294967296,36,4294967338,1077,0]

theorem envBound6816 : H12AffineFastState.Bounded env6816 := by
  intro p hp
  have h : env6816.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6815_6816 : H12AffineEnvironment.transform 6 34 env6815 = env6816 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 34 env6815 == env6816) = true)

theorem identity6816 : scanCanonicalize (H12AffineFastState.compose env6816 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 24) := by decide +kernel

theorem selectedBound6816 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6817 : List Nat := [2,4,8,16,32,16,34,37,0,1024,32,1077,8,1076,32,40,1077,32,1025,32,1076,10,17,40,34,17,10,1077,1077,10,1056,24,36,50,1077,0]

theorem envBound6817 : H12AffineFastState.Bounded env6817 := by
  intro p hp
  have h : env6817.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6816_6817 : H12AffineEnvironment.transform 31 24 env6816 = env6817 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 24 env6816 == env6817) = true)

theorem identity6817 : scanCanonicalize (H12AffineFastState.compose env6817 (packedSelected [2,4] rootPS)) = affineNative (2^(4+1) ^^^ 18) := by decide +kernel

theorem selectedBound6817 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env6818 : List Nat := [2,4,8,16,18,16,16,23,0,1024,18,1031,8,1030,18,26,1031,18,1025,18,1030,10,17,26,16,17,10,1031,1031,10,1042,24,22,0,1031,0]

theorem envBound6818 : H12AffineFastState.Bounded env6818 := by
  intro p hp
  have h : env6818.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6817_6818 : H12AffineEnvironment.transform 4 18 env6817 = env6818 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 18 env6817 == env6818) = true)

def env6819 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,262144,1025,32768,4097,360576,5376,103444,295040,67108864,103572,67110144,4097,67378443,4116,4294967296,257,4362117431,4096,303624]

theorem envBound6819 : H12AffineFastState.Bounded env6819 := by
  intro p hp
  have h : env6819.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6805_6819 : H12AffineEnvironment.transform 5 17 env6805 = env6819 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env6805 == env6819) = true)

def env6820 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,262144,1025,32768,4097,360576,5376,103444,295040,5376,103572,4096,4097,264203,4116,4294967296,257,4295013431,4096,303624]

theorem envBound6820 : H12AffineFastState.Bounded env6820 := by
  intro p hp
  have h : env6820.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6819_6820 : H12AffineEnvironment.transform 25 5376 env6819 = env6820 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env6819 == env6820) = true)

theorem identity6820 : scanCanonicalize (H12AffineFastState.compose env6820 (packedSelected [1,3,8] rootPS)) = affineNative (2^(17+1) ^^^ 2340) := by decide +kernel

theorem selectedBound6820 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env6821 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,2340,1025,32768,4097,100772,5376,103444,35236,5376,103572,4096,4097,303,4116,4294967296,257,4295013431,4096,43820]

theorem envBound6821 : H12AffineFastState.Bounded env6821 := by
  intro p hp
  have h : env6821.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6820_6821 : H12AffineEnvironment.transform 17 2340 env6820 = env6821 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2340 env6820 == env6821) = true)

theorem identity6821 : scanCanonicalize (H12AffineFastState.compose env6821 (packedSelected [13,17] rootPS)) = affineNative (2^(31+1) ^^^ 5140) := by decide +kernel

theorem selectedBound6821 : packedSelected [13,17] rootPS < 2^1333 := by decide +kernel

def env6822 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,2340,1025,32768,4097,100772,5376,103444,35236,5376,103572,4096,4097,303,4116,5140,257,40995,4096,43820]

theorem envBound6822 : H12AffineFastState.Bounded env6822 := by
  intro p hp
  have h : env6822.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6821_6822 : H12AffineEnvironment.transform 31 5140 env6821 = env6822 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 5140 env6821 == env6822) = true)

theorem identity6822 : scanCanonicalize (H12AffineFastState.compose env6822 (packedSelected [5,10,19] rootPS)) = affineNative (2^(14+1) ^^^ 15421) := by decide +kernel

theorem selectedBound6822 : packedSelected [5,10,19] rootPS < 2^1333 := by decide +kernel

def env6823 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,15421,65536,4096,2340,1025,15421,4097,79257,5376,75817,13721,5376,75945,4096,4097,303,4116,5140,257,7198,4096,5905]

theorem envBound6823 : H12AffineFastState.Bounded env6823 := by
  intro p hp
  have h : env6823.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6822_6823 : H12AffineEnvironment.transform 14 15421 env6822 = env6823 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 15421 env6822 == env6823) = true)

theorem identity6823 : scanCanonicalize (H12AffineFastState.compose env6823 (packedSelected [5,10,13,15] rootPS)) = affineNative (2^(11+1) ^^^ 1433) := by decide +kernel

theorem selectedBound6823 : packedSelected [5,10,13,15] rootPS < 2^1333 := by decide +kernel

def env6824 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1433,8192,1433,10660,65536,1433,2340,1025,10660,1432,73728,153,75817,8192,153,75945,1433,1432,303,1421,397,257,2439,1433,648]

theorem envBound6824 : H12AffineFastState.Bounded env6824 := by
  intro p hp
  have h : env6824.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6823_6824 : H12AffineEnvironment.transform 11 1433 env6823 = env6824 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1433 env6823 == env6824) = true)

theorem identity6824 : scanCanonicalize (H12AffineFastState.compose env6824 (packedSelected [0,1,3,4,5,7,16,20,22] rootPS)) = affineNative (2^(15+1) ^^^ 430) := by decide +kernel

theorem selectedBound6824 : packedSelected [0,1,3,4,5,7,16,20,22] rootPS < 2^1333 := by decide +kernel

def env6825 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1433,8192,1433,10660,430,1433,2340,1025,10660,1432,8622,153,10631,8192,153,10503,1433,1432,303,1421,397,257,2439,1433,648]

theorem envBound6825 : H12AffineFastState.Bounded env6825 := by
  intro p hp
  have h : env6825.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6824_6825 : H12AffineEnvironment.transform 15 430 env6824 = env6825 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 430 env6824 == env6825) = true)

theorem identity6825 : scanCanonicalize (H12AffineFastState.compose env6825 (packedSelected [6,25] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound6825 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env6826 : List Nat := [2,4,8,16,32,17,9,256,512,1024,2048,1296,8192,1296,10541,295,1296,2340,1025,10541,1297,8487,16,10510,8192,16,10503,1296,1297,303,1284,260,257,2318,1296,513]

theorem envBound6826 : H12AffineFastState.Bounded env6826 := by
  intro p hp
  have h : env6826.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6825_6826 : H12AffineEnvironment.transform 6 9 env6825 = env6826 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env6825 == env6826) = true)

def env6827 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,262144,1025,32768,4097,360576,5376,103444,295040,5377,103572,4097,4097,264202,4116,4294967296,257,4295013430,4096,303624]

theorem envBound6827 : H12AffineFastState.Bounded env6827 := by
  intro p hp
  have h : env6827.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6819_6827 : H12AffineEnvironment.transform 25 5377 env6819 = env6827 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env6819 == env6827) = true)

theorem identity6827 : scanCanonicalize (H12AffineFastState.compose env6827 (packedSelected [1,3,8] rootPS)) = affineNative (2^(17+1) ^^^ 40968) := by decide +kernel

theorem selectedBound6827 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env6828 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,40968,1025,32768,4097,73864,5376,103444,8328,5377,103572,4097,4097,43010,4116,4294967296,257,4295013430,4096,512]

theorem envBound6828 : H12AffineFastState.Bounded env6828 := by
  intro p hp
  have h : env6828.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6827_6828 : H12AffineEnvironment.transform 17 40968 env6827 = env6828 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 40968 env6827 == env6828) = true)

theorem identity6828 : scanCanonicalize (H12AffineFastState.compose env6828 (packedSelected [4,9,16] rootPS)) = affineNative (2^(15+1) ^^^ 13332) := by decide +kernel

theorem selectedBound6828 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env6829 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,13332,4096,40968,1025,32768,4097,5276,5376,40960,8328,5377,41088,4097,4097,43010,4116,4294967296,257,4295013430,4096,512]

theorem envBound6829 : H12AffineFastState.Bounded env6829 := by
  intro p hp
  have h : env6829.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6828_6829 : H12AffineEnvironment.transform 15 13332 env6828 = env6829 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13332 env6828 == env6829) = true)

theorem identity6829 : scanCanonicalize (H12AffineFastState.compose env6829 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 8226) := by decide +kernel

theorem selectedBound6829 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6830 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,13332,4096,40968,1025,32768,4097,5276,5376,40960,8328,5377,41088,4097,4097,43010,4116,8226,257,37908,4096,512]

theorem envBound6830 : H12AffineFastState.Bounded env6830 := by
  intro p hp
  have h : env6830.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6829_6830 : H12AffineEnvironment.transform 31 8226 env6829 = env6830 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 8226 env6829 == env6830) = true)

theorem identity6830 : scanCanonicalize (H12AffineFastState.compose env6830 (packedSelected [0,7,20] rootPS)) = affineNative (2^(14+1) ^^^ 261) := by decide +kernel

theorem selectedBound6830 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env6831 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,261,13332,4096,8461,1025,261,4097,5276,5376,8453,8328,5377,8581,4097,4097,10503,4116,8226,257,5393,4096,512]

theorem envBound6831 : H12AffineFastState.Bounded env6831 := by
  intro p hp
  have h : env6831.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6830_6831 : H12AffineEnvironment.transform 14 261 env6830 = env6831 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 261 env6830 == env6831) = true)

theorem identity6831 : scanCanonicalize (H12AffineFastState.compose env6831 (packedSelected [9,22] rootPS)) = affineNative (2^(12+1) ^^^ 5401) := by decide +kernel

theorem selectedBound6831 : packedSelected [9,22] rootPS < 2^1333 := by decide +kernel

def env6832 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,5401,4096,261,269,4096,5140,1025,261,4097,5276,5376,5148,5521,5377,5276,4097,4097,7198,4116,5435,257,5393,4096,512]

theorem envBound6832 : H12AffineFastState.Bounded env6832 := by
  intro p hp
  have h : env6832.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6831_6832 : H12AffineEnvironment.transform 12 5401 env6831 = env6832 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5401 env6831 == env6832) = true)

theorem identity6832 : scanCanonicalize (H12AffineFastState.compose env6832 (packedSelected [1,3,10,26] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound6832 : packedSelected [1,3,10,26] rootPS < 2^1333 := by decide +kernel

def env6833 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,8,1297,261,269,1297,261,1025,261,1296,397,17,269,128,16,397,1296,1296,2319,1285,42,257,0,1297,512]

theorem envBound6833 : H12AffineFastState.Bounded env6833 := by
  intro p hp
  have h : env6833.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6832_6833 : H12AffineEnvironment.transform 11 1297 env6832 = env6833 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env6832 == env6833) = true)

theorem identity6833 : scanCanonicalize (H12AffineFastState.compose env6833 (packedSelected [7] rootPS)) = affineNative (2^(6+1) ^^^ 16) := by decide +kernel

theorem selectedBound6833 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env6834 : List Nat := [2,4,8,16,32,17,16,256,512,1024,2048,1297,8,1297,261,269,1297,261,1025,261,1296,285,17,269,16,16,285,1296,1296,2319,1285,42,257,0,1297,512]

theorem envBound6834 : H12AffineFastState.Bounded env6834 := by
  intro p hp
  have h : env6834.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6833_6834 : H12AffineEnvironment.transform 6 16 env6833 = env6834 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 16 env6833 == env6834) = true)

theorem identity6834 : scanCanonicalize (H12AffineFastState.compose env6834 (packedSelected [1,10] rootPS)) = affineNative (2^(9+1) ^^^ 46) := by decide +kernel

theorem selectedBound6834 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env6835 : List Nat := [2,4,8,16,32,17,16,256,512,46,2048,319,8,319,261,269,319,261,47,261,318,285,17,269,16,16,285,318,318,2319,299,42,257,0,319,512]

theorem envBound6835 : H12AffineFastState.Bounded env6835 := by
  intro p hp
  have h : env6835.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6834_6835 : H12AffineEnvironment.transform 9 46 env6834 = env6835 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 46 env6834 == env6835) = true)

theorem identity6835 : scanCanonicalize (H12AffineFastState.compose env6835 (packedSelected [3,12] rootPS)) = affineNative (2^(7+1) ^^^ 23) := by decide +kernel

theorem selectedBound6835 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env6836 : List Nat := [2,4,8,16,32,17,16,23,512,46,2048,40,8,40,18,26,40,18,47,18,41,10,17,26,16,16,10,41,41,2072,60,42,22,0,40,512]

theorem envBound6836 : H12AffineFastState.Bounded env6836 := by
  intro p hp
  have h : env6836.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6835_6836 : H12AffineEnvironment.transform 7 23 env6835 = env6836 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 23 env6835 == env6836) = true)

theorem identity6836 : scanCanonicalize (H12AffineFastState.compose env6836 (packedSelected [1,3] rootPS)) = affineNative (2^(10+1) ^^^ 10) := by decide +kernel

theorem selectedBound6836 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env6837 : List Nat := [2,4,8,16,32,17,16,23,512,46,10,40,8,40,18,26,40,18,47,18,41,10,17,26,16,16,10,41,41,18,60,42,22,0,40,512]

theorem envBound6837 : H12AffineFastState.Bounded env6837 := by
  intro p hp
  have h : env6837.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6836_6837 : H12AffineEnvironment.transform 10 10 env6836 = env6837 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 10 env6836 == env6837) = true)

theorem identity6837 : scanCanonicalize (H12AffineFastState.compose env6837 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 18) := by decide +kernel

theorem selectedBound6837 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6838 : List Nat := [2,4,8,16,18,17,16,23,512,28,10,26,8,26,18,26,26,18,29,18,27,10,17,26,16,16,10,27,27,18,14,24,22,0,26,512]

theorem envBound6838 : H12AffineFastState.Bounded env6838 := by
  intro p hp
  have h : env6838.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6837_6838 : H12AffineEnvironment.transform 4 18 env6837 = env6838 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 18 env6837 == env6838) = true)

theorem identity6838 : scanCanonicalize (H12AffineFastState.compose env6838 (packedSelected [4] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound6838 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env6839 : List Nat := [2,4,2,16,18,17,16,23,512,22,0,16,2,16,18,16,16,18,23,18,17,0,17,16,16,16,0,17,17,18,4,18,22,0,16,512]

theorem envBound6839 : H12AffineFastState.Bounded env6839 := by
  intro p hp
  have h : env6839.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6838_6839 : H12AffineEnvironment.transform 2 2 env6838 = env6839 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env6838 == env6839) = true)

theorem identity6839 : scanCanonicalize (H12AffineFastState.compose env6839 (packedSelected [2] rootPS)) = affineNative (2^(8+1) ^^^ 19) := by decide +kernel

theorem selectedBound6839 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6840 : List Nat := [2,4,2,16,18,17,16,23,19,22,0,16,2,16,18,16,16,18,23,18,17,0,17,16,16,16,0,17,17,18,4,18,22,0,16,19]

theorem envBound6840 : H12AffineFastState.Bounded env6840 := by
  intro p hp
  have h : env6840.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6839_6840 : H12AffineEnvironment.transform 8 19 env6839 = env6840 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 19 env6839 == env6840) = true)

theorem identity6840 : scanCanonicalize (H12AffineFastState.compose env6840 (packedSelected [9] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound6840 : packedSelected [9] rootPS < 2^1333 := by decide +kernel

def env6841 : List Nat := [2,4,2,2,0,3,2,5,1,4,0,2,2,2,0,2,2,0,5,0,3,0,3,2,2,2,0,3,3,0,4,0,4,0,2,1]

theorem envBound6841 : H12AffineFastState.Bounded env6841 := by
  intro p hp
  have h : env6841.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6840_6841 : H12AffineEnvironment.transform 3 2 env6840 = env6841 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env6840 == env6841) = true)

def leafEnv6841 : List Nat := [2,4,2,2,0,3,2,5,1,4,0,2,2,2,0,2,2,0,5,0,3,0,3,2,5,2,1,2,0,3,3,0,4,0,4,0,5,2,2,1,0,3,1]

def active6841 : List Nat := [0,1]

def tree6841 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6841 : H12WitnessSearch.Good tree6841 := H12GlobalWitnessIndex.good

theorem leafIdentity6841 : H12AffineFastState.composeSystem env6841 rootObs = leafEnv6841 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6841 rootObs == leafEnv6841) = true)

theorem terminalChecked6841 : H12PackedTerminal.terminalCheckFast leafEnv6841 active6841 tree6841 = true := by decide +kernel

def env6842 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,1025,32768,4097,4194304,5457,103492,4259840,67108864,4461636,67110225,4177,71409035,4164,4294967296,257,4362117479,4097,4268680]

theorem envBound6842 : H12AffineFastState.Bounded env6842 := by
  intro p hp
  have h : env6842.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6803_6842 : H12AffineEnvironment.transform 16 4097 env6803 = env6842 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env6803 == env6842) = true)

theorem identity6842 : scanCanonicalize (H12AffineFastState.compose env6842 (packedSelected [3,5,24] rootPS)) = affineNative (2^(17+1) ^^^ 41600) := by decide +kernel

theorem selectedBound6842 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env6843 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,41600,1025,32768,4097,4194304,5457,103492,4259840,67108864,4241092,67110225,4177,71409035,4164,4294967296,257,4362117479,4097,4268680]

theorem envBound6843 : H12AffineFastState.Bounded env6843 := by
  intro p hp
  have h : env6843.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6842_6843 : H12AffineEnvironment.transform 17 41600 env6842 = env6843 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41600 env6842 == env6843) = true)

def env6844 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4097,41600,1025,32768,4097,4194304,5377,103444,4259840,67108864,4241044,67110145,4097,71409035,4116,4294967296,257,4362117431,4097,4268680]

theorem envBound6844 : H12AffineFastState.Bounded env6844 := by
  intro p hp
  have h : env6844.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6843_6844 : H12AffineEnvironment.transform 5 16 env6843 = env6844 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env6843 == env6844) = true)

def env6845 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4097,41600,1025,32768,4097,4194304,5377,103444,4259840,5376,4241044,4097,4097,4294795,4116,4294967296,257,4295013431,4097,4268680]

theorem envBound6845 : H12AffineFastState.Bounded env6845 := by
  intro p hp
  have h : env6845.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6844_6845 : H12AffineEnvironment.transform 25 5376 env6844 = env6845 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env6844 == env6845) = true)

theorem identity6845 : scanCanonicalize (H12AffineFastState.compose env6845 (packedSelected [1,3,8] rootPS)) = affineNative (2^(14+1) ^^^ 11172) := by decide +kernel

theorem selectedBound6845 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env6846 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,11172,65536,4097,2340,1025,11172,4097,4194304,5377,81840,4259840,5376,4201776,4097,4097,4268847,4116,4294967296,257,4294975379,4097,4268680]

theorem envBound6846 : H12AffineFastState.Bounded env6846 := by
  intro p hp
  have h : env6846.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6845_6846 : H12AffineEnvironment.transform 14 11172 env6845 = env6846 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 11172 env6845 == env6846) = true)

theorem identity6846 : scanCanonicalize (H12AffineFastState.compose env6846 (packedSelected [13,17] rootPS)) = affineNative (2^(31+1) ^^^ 5141) := by decide +kernel

theorem selectedBound6846 : packedSelected [13,17] rootPS < 2^1333 := by decide +kernel

def env6847 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,11172,65536,4097,2340,1025,11172,4097,4194304,5377,81840,4259840,5376,4201776,4097,4097,4268847,4116,5141,257,2950,4097,4268680]

theorem envBound6847 : H12AffineFastState.Bounded env6847 := by
  intro p hp
  have h : env6847.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6846_6847 : H12AffineEnvironment.transform 31 5141 env6846 = env6847 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 5141 env6846 == env6847) = true)

theorem identity6847 : scanCanonicalize (H12AffineFastState.compose env6847 (packedSelected [5,10,19] rootPS)) = affineNative (2^(21+1) ^^^ 79257) := by decide +kernel

theorem selectedBound6847 : packedSelected [5,10,19] rootPS < 2^1333 := by decide +kernel

def env6848 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,11172,65536,4097,2340,1025,11172,4097,79257,5377,81840,13721,5376,75945,4097,4097,5814,4116,5141,257,2950,4097,5905]

theorem envBound6848 : H12AffineFastState.Bounded env6848 := by
  intro p hp
  have h : env6848.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6847_6848 : H12AffineEnvironment.transform 21 79257 env6847 = env6848 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 79257 env6847 == env6848) = true)

theorem identity6848 : scanCanonicalize (H12AffineFastState.compose env6848 (packedSelected [5,10,13,15] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound6848 : packedSelected [5,10,13,15] rootPS < 2^1333 := by decide +kernel

def env6849 : List Nat := [2,4,8,16,32,16,9,256,512,1024,2048,4096,8192,4097,11053,65536,4097,2340,1025,11053,4097,79120,5377,81721,13584,5376,75808,4097,4097,5695,4116,5141,257,2831,4097,5905]

theorem envBound6849 : H12AffineFastState.Bounded env6849 := by
  intro p hp
  have h : env6849.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6848_6849 : H12AffineEnvironment.transform 6 9 env6848 = env6849 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env6848 == env6849) = true)

theorem identity6849 : scanCanonicalize (H12AffineFastState.compose env6849 (packedSelected [0,1,3,4,5,7,16,20,22] rootPS)) = affineNative (2^(15+1) ^^^ 807) := by decide +kernel

theorem selectedBound6849 : packedSelected [0,1,3,4,5,7,16,20,22] rootPS < 2^1333 := by decide +kernel

def env6850 : List Nat := [2,4,8,16,32,16,9,256,512,1024,2048,4096,8192,4097,11053,807,4097,2340,1025,11053,4097,13879,5377,15390,13584,5376,11015,4097,4097,5695,4116,5141,257,2831,4097,5905]

theorem envBound6850 : H12AffineFastState.Bounded env6850 := by
  intro p hp
  have h : env6850.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

end H12GlobalChart2
import H12GlobalChart2Data006

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem envBound1683 : H12AffineFastState.Bounded env1683 := by
  intro p hp
  have h : env1683.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1682_1683 : H12AffineEnvironment.transform 15 38046 env1682 = env1683 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 38046 env1682 == env1683) = true)

theorem identity1683 : scanCanonicalize (H12AffineFastState.compose env1683 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound1683 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env1684 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,9,1297,32768,33167,1297,262144,1024,32768,1297,4194304,17,138,128,17,4456708,1296,1297,4196613,1285,4294967296,256,4299161632,1296,137]

theorem envBound1684 : H12AffineFastState.Bounded env1684 := by
  intro p hp
  have h : env1684.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1683_1684 : H12AffineEnvironment.transform 11 1297 env1683 = env1684 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env1683 == env1684) = true)

theorem identity1684 : scanCanonicalize (H12AffineFastState.compose env1684 (packedSelected [1,3] rootPS)) = affineNative (2^(14+1) ^^^ 2184) := by decide +kernel

theorem selectedBound1684 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env1685 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,9,1297,2184,2311,1297,262144,1024,2184,1297,4194304,17,138,128,17,4456708,1296,1297,4196613,1285,4294967296,256,4299161632,1296,137]

theorem envBound1685 : H12AffineFastState.Bounded env1685 := by
  intro p hp
  have h : env1685.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1684_1685 : H12AffineEnvironment.transform 14 2184 env1684 = env1685 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2184 env1684 == env1685) = true)

theorem identity1685 : scanCanonicalize (H12AffineFastState.compose env1685 (packedSelected [5] rootPS)) = affineNative (2^(10+1) ^^^ 292) := by decide +kernel

theorem selectedBound1685 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1686 : List Nat := [2,4,8,16,32,17,128,256,136,1024,292,1297,9,1297,428,35,1297,262144,1024,428,1297,4194304,17,138,128,17,4456708,1296,1297,4194337,1285,4294967296,256,4299161632,1296,137]

theorem envBound1686 : H12AffineFastState.Bounded env1686 := by
  intro p hp
  have h : env1686.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1685_1686 : H12AffineEnvironment.transform 10 292 env1685 = env1686 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 292 env1685 == env1686) = true)

theorem identity1686 : scanCanonicalize (H12AffineFastState.compose env1686 (packedSelected [8] rootPS)) = affineNative (2^(17+1) ^^^ 168) := by decide +kernel

theorem selectedBound1686 : packedSelected [8] rootPS < 2^1333 := by decide +kernel

def env1687 : List Nat := [2,4,8,16,32,17,128,256,136,1024,292,1297,9,1297,428,35,1297,168,1024,428,1297,4194304,17,138,128,17,4194732,1296,1297,4194337,1285,4294967296,256,4299161632,1296,137]

theorem envBound1687 : H12AffineFastState.Bounded env1687 := by
  intro p hp
  have h : env1687.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1686_1687 : H12AffineEnvironment.transform 17 168 env1686 = env1687 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 168 env1686 == env1687) = true)

theorem identity1687 : scanCanonicalize (H12AffineFastState.compose env1687 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 137) := by decide +kernel

theorem selectedBound1687 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1688 : List Nat := [2,4,8,16,32,17,128,256,136,1024,292,1297,9,1297,428,35,1297,168,1024,428,1297,4194304,17,138,128,17,4194732,1296,1297,4194337,1285,137,256,4194473,1296,137]

theorem envBound1688 : H12AffineFastState.Bounded env1688 := by
  intro p hp
  have h : env1688.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1687_1688 : H12AffineEnvironment.transform 31 137 env1687 = env1688 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 137 env1687 == env1688) = true)

theorem identity1688 : scanCanonicalize (H12AffineFastState.compose env1688 (packedSelected [10] rootPS)) = affineNative (2^(21+1) ^^^ 397) := by decide +kernel

theorem selectedBound1688 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env1689 : List Nat := [2,4,8,16,32,17,128,256,136,1024,292,1297,9,1297,428,35,1297,168,1024,428,1297,397,17,138,128,17,33,1296,1297,428,1285,137,256,292,1296,137]

theorem envBound1689 : H12AffineFastState.Bounded env1689 := by
  intro p hp
  have h : env1689.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1688_1689 : H12AffineEnvironment.transform 21 397 env1688 = env1689 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 397 env1688 == env1689) = true)

theorem identity1689 : scanCanonicalize (H12AffineFastState.compose env1689 (packedSelected [4] rootPS)) = affineNative (2^(7+1) ^^^ 188) := by decide +kernel

theorem selectedBound1689 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env1690 : List Nat := [2,4,8,16,32,17,128,188,136,1024,152,1197,9,1197,16,35,1197,168,1024,16,1197,49,17,138,128,17,33,1196,1197,16,1209,137,188,152,1196,137]

theorem envBound1690 : H12AffineFastState.Bounded env1690 := by
  intro p hp
  have h : env1690.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1689_1690 : H12AffineEnvironment.transform 7 188 env1689 = env1690 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 188 env1689 == env1690) = true)

theorem identity1690 : scanCanonicalize (H12AffineFastState.compose env1690 (packedSelected [6] rootPS)) = affineNative (2^(6+1) ^^^ 19) := by decide +kernel

theorem selectedBound1690 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1691 : List Nat := [2,4,8,16,32,17,19,47,27,1024,11,1086,9,1086,16,35,1086,59,1024,16,1086,49,17,25,19,17,33,1087,1086,16,1066,26,47,11,1087,26]

theorem envBound1691 : H12AffineFastState.Bounded env1691 := by
  intro p hp
  have h : env1691.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1690_1691 : H12AffineEnvironment.transform 6 19 env1690 = env1691 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 19 env1690 == env1691) = true)

theorem identity1691 : scanCanonicalize (H12AffineFastState.compose env1691 (packedSelected [12] rootPS)) = affineNative (2^(4+1) ^^^ 16) := by decide +kernel

theorem selectedBound1691 : packedSelected [12] rootPS < 2^1333 := by decide +kernel

def env1692 : List Nat := [2,4,8,16,16,17,19,31,27,1024,11,1038,9,1038,16,19,1038,11,1024,16,1038,1,17,25,19,17,17,1039,1038,16,1050,26,31,11,1039,26]

theorem envBound1692 : H12AffineFastState.Bounded env1692 := by
  intro p hp
  have h : env1692.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1691_1692 : H12AffineEnvironment.transform 4 16 env1691 = env1692 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env1691 == env1692) = true)

theorem identity1692 : scanCanonicalize (H12AffineFastState.compose env1692 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1692 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1693 : List Nat := [2,4,8,0,0,1,3,15,11,1024,11,1038,9,1038,0,3,1038,11,1024,0,1038,1,1,9,3,1,1,1039,1038,0,1034,10,15,11,1039,10]

theorem envBound1693 : H12AffineFastState.Bounded env1693 := by
  intro p hp
  have h : env1693.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1692_1693 : H12AffineEnvironment.transform 3 0 env1692 = env1693 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1692 == env1693) = true)

theorem identity1693 : scanCanonicalize (H12AffineFastState.compose env1693 (packedSelected [0] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1693 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1694 : List Nat := [2,4,2,0,0,1,3,5,1,1024,1,1028,3,1028,0,3,1028,1,1024,0,1028,1,1,3,3,1,1,1029,1028,0,1024,0,5,1,1029,0]

theorem envBound1694 : H12AffineFastState.Bounded env1694 := by
  intro p hp
  have h : env1694.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1693_1694 : H12AffineEnvironment.transform 2 2 env1693 = env1694 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1693 == env1694) = true)

def leafEnv1694 : List Nat := [2,4,2,0,0,1,3,5,1,1024,1,1028,3,1028,0,3,1028,1,1024,0,1028,1,1,3,1024,3,1,1,1,1029,1028,0,1024,0,5,1,4,3,1029,0,0,1028,1]

def active1694 : List Nat := [0,1,9]

def tree1694 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1694 : H12WitnessSearch.Good tree1694 := H12GlobalWitnessIndex.good

theorem leafIdentity1694 : H12AffineFastState.composeSystem env1694 rootObs = leafEnv1694 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1694 rootObs == leafEnv1694) = true)

theorem terminalChecked1694 : H12PackedTerminal.terminalCheckFast leafEnv1694 active1694 tree1694 = true := by decide +kernel

def env1695 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8,4097,32768,65536,4096,262144,1024,32768,4096,4194304,5377,16777216,33554432,16875796,21331968,16876564,4096,20978846,16876544,4294967296,256,4332819518,4097,33554441]

theorem envBound1695 : H12AffineFastState.Bounded env1695 := by
  intro p hp
  have h : env1695.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1679_1695 : H12AffineEnvironment.transform 8 137 env1679 = env1695 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1679 == env1695) = true)

def env1696 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8,4097,32768,65536,4096,262144,1024,32768,4096,65544,5377,16777216,33554432,16875796,17072136,16876564,4096,16850070,16876544,4294967296,256,4328559670,4097,33554441]

theorem envBound1696 : H12AffineFastState.Bounded env1696 := by
  intro p hp
  have h : env1696.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1695_1696 : H12AffineEnvironment.transform 21 65544 env1695 = env1696 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 65544 env1695 == env1696) = true)

def env1697 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,32768,65536,1296,262144,1024,32768,1296,65544,17,16777216,33554432,16875796,17072136,16876564,1296,16845190,16876544,4294967296,256,4328554790,1297,33554441]

theorem envBound1697 : H12AffineFastState.Bounded env1697 := by
  intro p hp
  have h : env1697.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1696_1697 : H12AffineEnvironment.transform 11 1296 env1696 = env1697 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env1696 == env1697) = true)

theorem identity1697 : scanCanonicalize (H12AffineFastState.compose env1697 (packedSelected [3,5,24] rootPS)) = affineNative (2^(24+1) ^^^ 17137673) := by decide +kernel

theorem selectedBound1697 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env1698 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,32768,65536,1296,262144,1024,32768,1296,65544,17,16777216,17137673,16875796,17072136,16876564,1296,16845190,16876544,4294967296,256,4312072495,1297,17137664]

theorem envBound1698 : H12AffineFastState.Bounded env1698 := by
  intro p hp
  have h : env1698.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1697_1698 : H12AffineEnvironment.transform 24 17137673 env1697 = env1698 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 17137673 env1697 == env1698) = true)

theorem identity1698 : scanCanonicalize (H12AffineFastState.compose env1698 (packedSelected [1,3,5,17,21] rootPS)) = affineNative (2^(23+1) ^^^ 328077) := by decide +kernel

theorem selectedBound1698 : packedSelected [1,3,5,17,21] rootPS < 2^1333 := by decide +kernel

def env1699 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,32768,65536,1296,262144,1024,32768,1296,65544,17,328077,33156,295065,98693,296345,1296,264203,296333,4294967296,256,4294967458,1297,33165]

theorem envBound1699 : H12AffineFastState.Bounded env1699 := by
  intro p hp
  have h : env1699.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1698_1699 : H12AffineEnvironment.transform 23 328077 env1698 = env1699 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 328077 env1698 == env1699) = true)

theorem identity1699 : scanCanonicalize (H12AffineFastState.compose env1699 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(17+1) ^^^ 32905) := by decide +kernel

theorem selectedBound1699 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env1700 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,32768,65536,1296,32905,1024,32768,1296,65544,17,98564,33156,16,98693,1296,1296,34946,1284,4294967296,256,4294967458,1297,33165]

theorem envBound1700 : H12AffineFastState.Bounded env1700 := by
  intro p hp
  have h : env1700.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1699_1700 : H12AffineEnvironment.transform 17 32905 env1699 = env1700 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 32905 env1699 == env1700) = true)

theorem identity1700 : scanCanonicalize (H12AffineFastState.compose env1700 (packedSelected [10,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 2477) := by decide +kernel

theorem selectedBound1700 : packedSelected [10,12,13] rootPS < 2^1333 := by decide +kernel

def env1701 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,2477,65536,1296,2340,1024,2477,1296,65544,17,67753,2089,16,67624,1296,1296,303,1284,4294967296,256,4294967458,1297,2080]

theorem envBound1701 : H12AffineFastState.Bounded env1701 := by
  intro p hp
  have h : env1701.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1700_1701 : H12AffineEnvironment.transform 14 2477 env1700 = env1701 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2477 env1700 == env1701) = true)

theorem identity1701 : scanCanonicalize (H12AffineFastState.compose env1701 (packedSelected [1,3,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 2083) := by decide +kernel

theorem selectedBound1701 : packedSelected [1,3,12,15] rootPS < 2^1333 := by decide +kernel

def env1702 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,2477,2083,1296,2340,1024,2477,1296,2091,17,138,2089,16,11,1296,1296,303,1284,4294967296,256,4294967458,1297,2080]

theorem envBound1702 : H12AffineFastState.Bounded env1702 := by
  intro p hp
  have h : env1702.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1701_1702 : H12AffineEnvironment.transform 15 2083 env1701 = env1702 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2083 env1701 == env1702) = true)

theorem identity1702 : scanCanonicalize (H12AffineFastState.compose env1702 (packedSelected [0,2,4,6,11] rootPS)) = affineNative (2^(10+1) ^^^ 303) := by decide +kernel

theorem selectedBound1702 : packedSelected [0,2,4,6,11] rootPS < 2^1333 := by decide +kernel

def env1703 : List Nat := [2,4,8,16,32,17,128,256,137,1024,303,1296,8,1297,130,268,1296,11,1024,130,1296,260,17,138,262,16,11,1296,1296,303,1284,4294967296,256,4294967458,1297,271]

theorem envBound1703 : H12AffineFastState.Bounded env1703 := by
  intro p hp
  have h : env1703.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1702_1703 : H12AffineEnvironment.transform 10 303 env1702 = env1703 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 303 env1702 == env1703) = true)

theorem identity1703 : scanCanonicalize (H12AffineFastState.compose env1703 (packedSelected [0,6,7,10] rootPS)) = affineNative (2^(31+1) ^^^ 1060) := by decide +kernel

theorem selectedBound1703 : packedSelected [0,6,7,10] rootPS < 2^1333 := by decide +kernel

def env1704 : List Nat := [2,4,8,16,32,17,128,256,137,1024,303,1296,8,1297,130,268,1296,11,1024,130,1296,260,17,138,262,16,11,1296,1296,303,1284,1060,256,1158,1297,271]

theorem envBound1704 : H12AffineFastState.Bounded env1704 := by
  intro p hp
  have h : env1704.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1703_1704 : H12AffineEnvironment.transform 31 1060 env1703 = env1704 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1060 env1703 == env1704) = true)

theorem identity1704 : scanCanonicalize (H12AffineFastState.compose env1704 (packedSelected [0,1,6,7,12] rootPS)) = affineNative (2^(6+1) ^^^ 34) := by decide +kernel

theorem selectedBound1704 : packedSelected [0,1,6,7,12] rootPS < 2^1333 := by decide +kernel

def env1705 : List Nat := [2,4,8,16,32,17,34,256,43,1024,303,1296,8,1297,32,268,1296,11,1024,32,1296,260,17,40,262,16,11,1296,1296,303,1284,1060,256,1060,1297,271]

theorem envBound1705 : H12AffineFastState.Bounded env1705 := by
  intro p hp
  have h : env1705.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1704_1705 : H12AffineEnvironment.transform 6 34 env1704 = env1705 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 34 env1704 == env1705) = true)

theorem identity1705 : scanCanonicalize (H12AffineFastState.compose env1705 (packedSelected [2,6] rootPS)) = affineNative (2^(7+1) ^^^ 47) := by decide +kernel

theorem selectedBound1705 : packedSelected [2,6] rootPS < 2^1333 := by decide +kernel

def env1706 : List Nat := [2,4,8,16,32,17,34,47,43,1024,0,1087,8,1086,32,35,1087,11,1024,32,1087,43,17,40,41,16,11,1087,1087,0,1067,1060,47,1060,1086,32]

theorem envBound1706 : H12AffineFastState.Bounded env1706 := by
  intro p hp
  have h : env1706.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1705_1706 : H12AffineEnvironment.transform 7 47 env1705 = env1706 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 47 env1705 == env1706) = true)

theorem identity1706 : scanCanonicalize (H12AffineFastState.compose env1706 (packedSelected [0,4] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound1706 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env1707 : List Nat := [2,4,8,16,0,17,2,15,11,1024,0,1055,8,1054,0,3,1055,11,1024,0,1055,11,17,8,9,16,11,1055,1055,0,1035,1028,15,1028,1054,0]

theorem envBound1707 : H12AffineFastState.Bounded env1707 := by
  intro p hp
  have h : env1707.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1706_1707 : H12AffineEnvironment.transform 4 0 env1706 = env1707 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1706 == env1707) = true)

theorem identity1707 : scanCanonicalize (H12AffineFastState.compose env1707 (packedSelected [2] rootPS)) = affineNative (2^(9+1) ^^^ 4) := by decide +kernel

theorem selectedBound1707 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1708 : List Nat := [2,4,8,16,0,17,2,15,11,4,0,27,8,26,0,3,27,11,4,0,27,11,17,8,9,16,11,27,27,0,15,0,15,0,26,0]

theorem envBound1708 : H12AffineFastState.Bounded env1708 := by
  intro p hp
  have h : env1708.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1707_1708 : H12AffineEnvironment.transform 9 4 env1707 = env1708 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 4 env1707 == env1708) = true)

def env1709 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,1296,32768,65536,1297,262144,1024,32768,1297,65544,16,16777216,33554432,16875796,17072136,16876564,1297,16845191,16876544,4294967296,256,4328554791,1296,33554441]

theorem envBound1709 : H12AffineFastState.Bounded env1709 := by
  intro p hp
  have h : env1709.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1696_1709 : H12AffineEnvironment.transform 11 1297 env1696 = env1709 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env1696 == env1709) = true)

theorem identity1709 : scanCanonicalize (H12AffineFastState.compose env1709 (packedSelected [3,5,24] rootPS)) = affineNative (2^(23+1) ^^^ 360449) := by decide +kernel

theorem selectedBound1709 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env1710 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,1296,32768,65536,1297,262144,1024,32768,1297,65544,16,360449,33554432,262421,65545,263189,1297,297350,263169,4294967296,256,4328554791,1296,33554441]

theorem envBound1710 : H12AffineFastState.Bounded env1710 := by
  intro p hp
  have h : env1710.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1709_1710 : H12AffineEnvironment.transform 23 360449 env1709 = env1710 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 360449 env1709 == env1710) = true)

theorem identity1710 : scanCanonicalize (H12AffineFastState.compose env1710 (packedSelected [1,3,5,10,12,17] rootPS)) = affineNative (2^(24+1) ^^^ 67627) := by decide +kernel

theorem selectedBound1710 : packedSelected [1,3,5,10,12,17] rootPS < 2^1333 := by decide +kernel

def env1711 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,1296,32768,65536,1297,262144,1024,32768,1297,65544,16,360449,67627,262421,65545,263189,1297,297350,263169,4294967296,256,4295067916,1296,67618]

theorem envBound1711 : H12AffineFastState.Bounded env1711 := by
  intro p hp
  have h : env1711.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1710_1711 : H12AffineEnvironment.transform 24 67627 env1710 = env1711 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 67627 env1710 == env1711) = true)

theorem identity1711 : scanCanonicalize (H12AffineFastState.compose env1711 (packedSelected [1,3,5,6,8,10,19,25] rootPS)) = affineNative (2^(17+1) ^^^ 260) := by decide +kernel

theorem selectedBound1711 : packedSelected [1,3,5,6,8,10,19,25] rootPS < 2^1333 := by decide +kernel

def env1712 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,1296,32768,65536,1297,260,1024,32768,1297,65544,16,98565,67627,17,65545,1297,1297,34946,1285,4294967296,256,4295067916,1296,67618]

theorem envBound1712 : H12AffineFastState.Bounded env1712 := by
  intro p hp
  have h : env1712.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1711_1712 : H12AffineEnvironment.transform 17 260 env1711 = env1712 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 260 env1711 == env1712) = true)

theorem identity1712 : scanCanonicalize (H12AffineFastState.compose env1712 (packedSelected [1,10,12] rootPS)) = affineNative (2^(15+1) ^^^ 33069) := by decide +kernel

theorem selectedBound1712 : packedSelected [1,10,12] rootPS < 2^1333 := by decide +kernel

def env1713 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,1296,32768,33069,1297,260,1024,32768,1297,33061,16,40,35078,17,33060,1297,1297,34946,1285,4294967296,256,4294969377,1296,35087]

theorem envBound1713 : H12AffineFastState.Bounded env1713 := by
  intro p hp
  have h : env1713.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1712_1713 : H12AffineEnvironment.transform 15 33069 env1712 = env1713 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33069 env1712 == env1713) = true)

theorem identity1713 : scanCanonicalize (H12AffineFastState.compose env1713 (packedSelected [1,13] rootPS)) = affineNative (2^(14+1) ^^^ 2438) := by decide +kernel

theorem selectedBound1713 : packedSelected [1,13] rootPS < 2^1333 := by decide +kernel

def env1714 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,1296,2438,2219,1297,260,1024,2438,1297,2211,16,40,128,17,2210,1297,1297,260,1285,4294967296,256,4294969377,1296,137]

theorem envBound1714 : H12AffineFastState.Bounded env1714 := by
  intro p hp
  have h : env1714.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1713_1714 : H12AffineEnvironment.transform 14 2438 env1713 = env1714 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2438 env1713 == env1714) = true)

theorem identity1714 : scanCanonicalize (H12AffineFastState.compose env1714 (packedSelected [3] rootPS)) = affineNative (2^(31+1) ^^^ 2091) := by decide +kernel

theorem selectedBound1714 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1715 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,1296,2438,2219,1297,260,1024,2438,1297,2211,16,40,128,17,2210,1297,1297,260,1285,2091,256,10,1296,137]

theorem envBound1715 : H12AffineFastState.Bounded env1715 := by
  intro p hp
  have h : env1715.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1714_1715 : H12AffineEnvironment.transform 31 2091 env1714 = env1715 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 2091 env1714 == env1715) = true)

theorem identity1715 : scanCanonicalize (H12AffineFastState.compose env1715 (packedSelected [2,4] rootPS)) = affineNative (2^(10+1) ^^^ 389) := by decide +kernel

theorem selectedBound1715 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env1716 : List Nat := [2,4,8,16,32,17,128,256,137,1024,389,1297,8,1296,3,302,1297,260,1024,3,1297,294,16,40,128,17,295,1297,1297,260,1285,430,256,10,1296,137]

theorem envBound1716 : H12AffineFastState.Bounded env1716 := by
  intro p hp
  have h : env1716.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1715_1716 : H12AffineEnvironment.transform 10 389 env1715 = env1716 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 389 env1715 == env1716) = true)

theorem identity1716 : scanCanonicalize (H12AffineFastState.compose env1716 (packedSelected [6,7] rootPS)) = affineNative (2^(7+1) ^^^ 134) := by decide +kernel

theorem selectedBound1716 : packedSelected [6,7] rootPS < 2^1333 := by decide +kernel

def env1717 : List Nat := [2,4,8,16,32,17,128,134,137,1024,3,1175,8,1174,3,168,1175,130,1024,3,1175,160,16,40,128,17,161,1175,1175,130,1155,40,134,10,1174,137]

theorem envBound1717 : H12AffineFastState.Bounded env1717 := by
  intro p hp
  have h : env1717.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1716_1717 : H12AffineEnvironment.transform 7 134 env1716 = env1717 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 134 env1716 == env1717) = true)

theorem identity1717 : scanCanonicalize (H12AffineFastState.compose env1717 (packedSelected [0,2,6,9] rootPS)) = affineNative (2^(4+1) ^^^ 2) := by decide +kernel

theorem selectedBound1717 : packedSelected [0,2,6,9] rootPS < 2^1333 := by decide +kernel

def env1718 : List Nat := [2,4,8,16,2,17,128,134,137,1024,3,1175,8,1174,3,138,1175,130,1024,3,1175,130,16,10,128,17,131,1175,1175,130,1155,10,134,10,1174,137]

theorem envBound1718 : H12AffineFastState.Bounded env1718 := by
  intro p hp
  have h : env1718.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1717_1718 : H12AffineEnvironment.transform 4 2 env1717 = env1718 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 2 env1717 == env1718) = true)

def env1719 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8,4097,32768,65536,4096,262144,1024,32768,4096,65545,5377,16777216,33554432,16875796,17072137,16876564,4096,16850071,16876544,4294967296,256,4328559671,4097,33554441]

theorem envBound1719 : H12AffineFastState.Bounded env1719 := by
  intro p hp
  have h : env1719.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1695_1719 : H12AffineEnvironment.transform 21 65545 env1695 = env1719 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 65545 env1695 == env1719) = true)

def env1720 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,32768,65536,1296,262144,1024,32768,1296,65545,17,16777216,33554432,16875796,17072137,16876564,1296,16845191,16876544,4294967296,256,4328554791,1297,33554441]

theorem envBound1720 : H12AffineFastState.Bounded env1720 := by
  intro p hp
  have h : env1720.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1719_1720 : H12AffineEnvironment.transform 11 1296 env1719 = env1720 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env1719 == env1720) = true)

theorem identity1720 : scanCanonicalize (H12AffineFastState.compose env1720 (packedSelected [3,5,24] rootPS)) = affineNative (2^(24+1) ^^^ 262412) := by decide +kernel

theorem selectedBound1720 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env1721 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,32768,65536,1296,262144,1024,32768,1296,65545,17,16777216,262412,16875796,17072137,16876564,1296,16845191,16876544,4294967296,256,4295262251,1297,262405]

theorem envBound1721 : H12AffineFastState.Bounded env1721 := by
  intro p hp
  have h : env1721.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1720_1721 : H12AffineEnvironment.transform 24 262412 env1720 = env1721 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 262412 env1720 == env1721) = true)

theorem identity1721 : scanCanonicalize (H12AffineFastState.compose env1721 (packedSelected [1,3,5,17,21] rootPS)) = affineNative (2^(17+1) ^^^ 32904) := by decide +kernel

theorem selectedBound1721 : packedSelected [1,3,5,17,21] rootPS < 2^1333 := by decide +kernel

def env1722 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,32768,65536,1296,32904,1024,32768,1296,65545,17,16777216,33156,16875796,16777345,16876564,1296,16845191,16876544,4294967296,256,4294967459,1297,33165]

theorem envBound1722 : H12AffineFastState.Bounded env1722 := by
  intro p hp
  have h : env1722.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1721_1722 : H12AffineEnvironment.transform 17 32904 env1721 = env1722 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 32904 env1721 == env1722) = true)

theorem identity1722 : scanCanonicalize (H12AffineFastState.compose env1722 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(23+1) ^^^ 98564) := by decide +kernel

theorem selectedBound1722 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env1723 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,32768,65536,1296,32904,1024,32768,1296,65545,17,98564,33156,16,98693,1296,1296,34947,1284,4294967296,256,4294967459,1297,33165]

theorem envBound1723 : H12AffineFastState.Bounded env1723 := by
  intro p hp
  have h : env1723.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1722_1723 : H12AffineEnvironment.transform 23 98564 env1722 = env1723 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98564 env1722 == env1723) = true)

theorem identity1723 : scanCanonicalize (H12AffineFastState.compose env1723 (packedSelected [10,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 2476) := by decide +kernel

theorem selectedBound1723 : packedSelected [10,12,13] rootPS < 2^1333 := by decide +kernel

def env1724 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,2476,65536,1296,2340,1024,2476,1296,65545,17,67752,2088,16,67625,1296,1296,303,1284,4294967296,256,4294967459,1297,2081]

theorem envBound1724 : H12AffineFastState.Bounded env1724 := by
  intro p hp
  have h : env1724.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1723_1724 : H12AffineEnvironment.transform 14 2476 env1723 = env1724 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2476 env1723 == env1724) = true)

theorem identity1724 : scanCanonicalize (H12AffineFastState.compose env1724 (packedSelected [1,3,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 2082) := by decide +kernel

theorem selectedBound1724 : packedSelected [1,3,12,15] rootPS < 2^1333 := by decide +kernel

def env1725 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,2476,2082,1296,2340,1024,2476,1296,2091,17,138,2088,16,11,1296,1296,303,1284,4294967296,256,4294967459,1297,2081]

theorem envBound1725 : H12AffineFastState.Bounded env1725 := by
  intro p hp
  have h : env1725.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1724_1725 : H12AffineEnvironment.transform 15 2082 env1724 = env1725 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2082 env1724 == env1725) = true)

theorem identity1725 : scanCanonicalize (H12AffineFastState.compose env1725 (packedSelected [0,2,4,6,11] rootPS)) = affineNative (2^(10+1) ^^^ 303) := by decide +kernel

theorem selectedBound1725 : packedSelected [0,2,4,6,11] rootPS < 2^1333 := by decide +kernel

def env1726 : List Nat := [2,4,8,16,32,17,128,256,137,1024,303,1296,8,1297,131,269,1296,11,1024,131,1296,260,17,138,263,16,11,1296,1296,303,1284,4294967296,256,4294967459,1297,270]

theorem envBound1726 : H12AffineFastState.Bounded env1726 := by
  intro p hp
  have h : env1726.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1725_1726 : H12AffineEnvironment.transform 10 303 env1725 = env1726 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 303 env1725 == env1726) = true)

theorem identity1726 : scanCanonicalize (H12AffineFastState.compose env1726 (packedSelected [0,6,7,10] rootPS)) = affineNative (2^(31+1) ^^^ 1060) := by decide +kernel

theorem selectedBound1726 : packedSelected [0,6,7,10] rootPS < 2^1333 := by decide +kernel

def env1727 : List Nat := [2,4,8,16,32,17,128,256,137,1024,303,1296,8,1297,131,269,1296,11,1024,131,1296,260,17,138,263,16,11,1296,1296,303,1284,1060,256,1159,1297,270]

theorem envBound1727 : H12AffineFastState.Bounded env1727 := by
  intro p hp
  have h : env1727.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1726_1727 : H12AffineEnvironment.transform 31 1060 env1726 = env1727 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1060 env1726 == env1727) = true)

theorem identity1727 : scanCanonicalize (H12AffineFastState.compose env1727 (packedSelected [0,1,6,7,12] rootPS)) = affineNative (2^(6+1) ^^^ 35) := by decide +kernel

theorem selectedBound1727 : packedSelected [0,1,6,7,12] rootPS < 2^1333 := by decide +kernel

def env1728 : List Nat := [2,4,8,16,32,17,35,256,42,1024,303,1296,8,1297,32,269,1296,11,1024,32,1296,260,17,41,263,16,11,1296,1296,303,1284,1060,256,1060,1297,270]

theorem envBound1728 : H12AffineFastState.Bounded env1728 := by
  intro p hp
  have h : env1728.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1727_1728 : H12AffineEnvironment.transform 6 35 env1727 = env1728 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 35 env1727 == env1728) = true)

theorem identity1728 : scanCanonicalize (H12AffineFastState.compose env1728 (packedSelected [2,6] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1728 : packedSelected [2,6] rootPS < 2^1333 := by decide +kernel

def env1729 : List Nat := [2,4,2,16,32,17,35,256,32,1024,293,1296,2,1297,32,263,1296,1,1024,32,1296,260,17,35,263,16,1,1296,1296,293,1284,1060,256,1060,1297,260]

theorem envBound1729 : H12AffineFastState.Bounded env1729 := by
  intro p hp
  have h : env1729.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1728_1729 : H12AffineEnvironment.transform 2 2 env1728 = env1729 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1728 == env1729) = true)

theorem identity1729 : scanCanonicalize (H12AffineFastState.compose env1729 (packedSelected [0,4] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1729 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env1730 : List Nat := [2,4,2,16,32,17,35,5,32,1024,32,1045,2,1044,32,2,1045,1,1024,32,1045,1,17,35,2,16,1,1045,1045,32,1025,1060,5,1060,1044,1]

theorem envBound1730 : H12AffineFastState.Bounded env1730 := by
  intro p hp
  have h : env1730.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1729_1730 : H12AffineEnvironment.transform 7 5 env1729 = env1730 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1729 == env1730) = true)

theorem identity1730 : scanCanonicalize (H12AffineFastState.compose env1730 (packedSelected [2] rootPS)) = affineNative (2^(9+1) ^^^ 4) := by decide +kernel

theorem selectedBound1730 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1731 : List Nat := [2,4,2,16,32,17,35,5,32,4,32,17,2,16,32,2,17,1,4,32,17,1,17,35,2,16,1,17,17,32,5,32,5,32,16,1]

theorem envBound1731 : H12AffineFastState.Bounded env1731 := by
  intro p hp
  have h : env1731.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1730_1731 : H12AffineEnvironment.transform 9 4 env1730 = env1731 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 4 env1730 == env1731) = true)

theorem identity1731 : scanCanonicalize (H12AffineFastState.compose env1731 (packedSelected [0,7] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound1731 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env1732 : List Nat := [2,4,2,16,1,17,2,5,1,4,1,17,2,16,1,2,17,1,4,1,17,1,17,2,2,16,1,17,17,1,5,1,5,1,16,1]

theorem envBound1732 : H12AffineFastState.Bounded env1732 := by
  intro p hp
  have h : env1732.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1731_1732 : H12AffineEnvironment.transform 4 1 env1731 = env1732 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env1731 == env1732) = true)

theorem identity1732 : scanCanonicalize (H12AffineFastState.compose env1732 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound1732 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1733 : List Nat := [2,4,2,3,1,2,2,5,1,4,1,2,2,3,1,2,2,1,4,1,2,1,2,2,2,3,1,2,2,1,5,1,5,1,3,1]

theorem envBound1733 : H12AffineFastState.Bounded env1733 := by
  intro p hp
  have h : env1733.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1732_1733 : H12AffineEnvironment.transform 3 3 env1732 = env1733 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env1732 == env1733) = true)

def leafEnv1733 : List Nat := [2,4,2,3,1,2,2,5,1,4,1,2,2,3,1,2,2,1,4,1,2,1,2,2,5,2,1,3,1,2,2,1,5,1,5,1,4,2,3,1,0,2,1]

def active1733 : List Nat := [0,1]

def tree1733 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1733 : H12WitnessSearch.Good tree1733 := H12GlobalWitnessIndex.good

theorem leafIdentity1733 : H12AffineFastState.composeSystem env1733 rootObs = leafEnv1733 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1733 rootObs == leafEnv1733) = true)

theorem terminalChecked1733 : H12PackedTerminal.terminalCheckFast leafEnv1733 active1733 tree1733 = true := by decide +kernel

def env1734 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,1296,32768,65536,1297,262144,1024,32768,1297,65545,16,16777216,33554432,16875796,17072137,16876564,1297,16845190,16876544,4294967296,256,4328554790,1296,33554441]

theorem envBound1734 : H12AffineFastState.Bounded env1734 := by
  intro p hp
  have h : env1734.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1719_1734 : H12AffineEnvironment.transform 11 1297 env1719 = env1734 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env1719 == env1734) = true)

theorem identity1734 : scanCanonicalize (H12AffineFastState.compose env1734 (packedSelected [3,5,24] rootPS)) = affineNative (2^(17+1) ^^^ 260) := by decide +kernel

theorem selectedBound1734 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env1735 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,1296,32768,65536,1297,260,1024,32768,1297,65545,16,16777216,33554432,16875796,16810253,16876564,1297,16845190,16876544,4294967296,256,4328554790,1296,33554441]

theorem envBound1735 : H12AffineFastState.Bounded env1735 := by
  intro p hp
  have h : env1735.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1734_1735 : H12AffineEnvironment.transform 17 260 env1734 = env1735 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 260 env1734 == env1735) = true)

theorem identity1735 : scanCanonicalize (H12AffineFastState.compose env1735 (packedSelected [1,3,5,10,12,17] rootPS)) = affineNative (2^(24+1) ^^^ 67627) := by decide +kernel

theorem selectedBound1735 : packedSelected [1,3,5,10,12,17] rootPS < 2^1333 := by decide +kernel

def env1736 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,1296,32768,65536,1297,260,1024,32768,1297,65545,16,16777216,67627,16875796,16810253,16876564,1297,16845190,16876544,4294967296,256,4295067917,1296,67618]

theorem envBound1736 : H12AffineFastState.Bounded env1736 := by
  intro p hp
  have h : env1736.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1735_1736 : H12AffineEnvironment.transform 24 67627 env1735 = env1736 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 67627 env1735 == env1736) = true)

theorem identity1736 : scanCanonicalize (H12AffineFastState.compose env1736 (packedSelected [1,10,12,13,15,19] rootPS)) = affineNative (2^(15+1) ^^^ 2056) := by decide +kernel

theorem selectedBound1736 : packedSelected [1,10,12,13,15,19] rootPS < 2^1333 := by decide +kernel

def env1737 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,1296,32768,2056,1297,260,1024,32768,1297,2049,16,16777216,35,16812316,16810253,16813084,1297,16777614,16813064,4294967296,256,4295000325,1296,42]

theorem envBound1737 : H12AffineFastState.Bounded env1737 := by
  intro p hp
  have h : env1737.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1736_1737 : H12AffineEnvironment.transform 15 2056 env1736 = env1737 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2056 env1736 == env1737) = true)

theorem identity1737 : scanCanonicalize (H12AffineFastState.compose env1737 (packedSelected [2,3,4,5,6,7,8,12,13,15,16,18,20] rootPS)) = affineNative (2^(23+1) ^^^ 35247) := by decide +kernel

theorem selectedBound1737 : packedSelected [2,3,4,5,6,7,8,12,13,15,16,18,20] rootPS < 2^1333 := by decide +kernel

def env1738 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,1296,32768,2056,1297,260,1024,32768,1297,2049,16,35247,35,179,2210,1459,1297,34849,1447,4294967296,256,4295000325,1296,42]

theorem envBound1738 : H12AffineFastState.Bounded env1738 := by
  intro p hp
  have h : env1738.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1737_1738 : H12AffineEnvironment.transform 23 35247 env1737 = env1738 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 35247 env1737 == env1738) = true)

theorem identity1738 : scanCanonicalize (H12AffineFastState.compose env1738 (packedSelected [0,3,7,8,10,11,12] rootPS)) = affineNative (2^(14+1) ^^^ 2438) := by decide +kernel

theorem selectedBound1738 : packedSelected [0,3,7,8,10,11,12] rootPS < 2^1333 := by decide +kernel

def env1739 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,1296,2438,2056,1297,260,1024,2438,1297,2049,16,41,35,179,2210,1459,1297,423,1447,4294967296,256,4294969475,1296,42]

theorem envBound1739 : H12AffineFastState.Bounded env1739 := by
  intro p hp
  have h : env1739.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1738_1739 : H12AffineEnvironment.transform 14 2438 env1738 = env1739 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2438 env1738 == env1739) = true)

theorem identity1739 : scanCanonicalize (H12AffineFastState.compose env1739 (packedSelected [0,1,3,5,7,8] rootPS)) = affineNative (2^(10+1) ^^^ 423) := by decide +kernel

theorem selectedBound1739 : packedSelected [0,1,3,5,7,8] rootPS < 2^1333 := by decide +kernel

def env1740 : List Nat := [2,4,8,16,32,17,128,256,137,1024,423,1297,8,1296,33,431,1297,260,1024,33,1297,422,16,41,35,179,261,1459,1297,423,1447,4294967296,256,4294967588,1296,42]

theorem envBound1740 : H12AffineFastState.Bounded env1740 := by
  intro p hp
  have h : env1740.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1739_1740 : H12AffineEnvironment.transform 10 423 env1739 = env1740 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 423 env1739 == env1740) = true)

theorem identity1740 : scanCanonicalize (H12AffineFastState.compose env1740 (packedSelected [0,2,4,5,6] rootPS)) = affineNative (2^(6+1) ^^^ 34) := by decide +kernel

theorem selectedBound1740 : packedSelected [0,2,4,5,6] rootPS < 2^1333 := by decide +kernel

def env1741 : List Nat := [2,4,8,16,32,17,34,256,43,1024,261,1297,8,1296,33,269,1297,260,1024,33,1297,260,16,41,35,17,261,1297,1297,261,1285,4294967296,256,4294967588,1296,42]

theorem envBound1741 : H12AffineFastState.Bounded env1741 := by
  intro p hp
  have h : env1741.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1740_1741 : H12AffineEnvironment.transform 6 34 env1740 = env1741 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 34 env1740 == env1741) = true)

theorem identity1741 : scanCanonicalize (H12AffineFastState.compose env1741 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 59) := by decide +kernel

theorem selectedBound1741 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1742 : List Nat := [2,4,8,16,32,17,34,256,43,1024,261,1297,8,1296,33,269,1297,260,1024,33,1297,260,16,41,35,17,261,1297,1297,261,1285,59,256,287,1296,42]

theorem envBound1742 : H12AffineFastState.Bounded env1742 := by
  intro p hp
  have h : env1742.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1741_1742 : H12AffineEnvironment.transform 31 59 env1741 = env1742 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 59 env1741 == env1742) = true)

def env1743 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,16777216,33554432,16875797,21352449,16897044,4097,20978847,16876544,4294967296,256,4332832439,4096,33554441]

theorem envBound1743 : H12AffineFastState.Bounded env1743 := by
  intro p hp
  have h : env1743.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1677_1743 : H12AffineEnvironment.transform 16 4097 env1677 = env1743 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env1677 == env1743) = true)

theorem identity1743 : scanCanonicalize (H12AffineFastState.compose env1743 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(13+1) ^^^ 1944) := by decide +kernel

theorem selectedBound1743 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env1744 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,1944,32768,65536,4097,262144,1024,32768,4096,4194304,664,16777216,33554432,16875797,21338009,16880524,4097,20978847,16876544,4294967296,256,4332814639,4096,33554441]

theorem envBound1744 : H12AffineFastState.Bounded env1744 := by
  intro p hp
  have h : env1744.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1743_1744 : H12AffineEnvironment.transform 13 1944 env1743 = env1744 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1944 env1743 == env1744) = true)

def env1745 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,1296,32768,65536,4097,262144,1024,32768,4096,4194304,16,16777216,33554432,16875797,21337361,16879876,4097,20978847,16876544,4294967296,256,4332814639,4096,33554441]

theorem envBound1745 : H12AffineFastState.Bounded env1745 := by
  intro p hp
  have h : env1745.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1744_1745 : H12AffineEnvironment.transform 8 136 env1744 = env1745 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1744 == env1745) = true)

theorem identity1745 : scanCanonicalize (H12AffineFastState.compose env1745 (packedSelected [3,6,10,24,25,26] rootPS)) = affineNative (2^(23+1) ^^^ 103445) := by decide +kernel

theorem selectedBound1745 : packedSelected [3,6,10,24,25,26] rootPS < 2^1333 := by decide +kernel

def env1746 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,1296,32768,65536,4097,262144,1024,32768,4096,4194304,16,103445,33554432,5376,4456708,1297,4097,4294794,4117,4294967296,256,4332814639,4096,33554441]

theorem envBound1746 : H12AffineFastState.Bounded env1746 := by
  intro p hp
  have h : env1746.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1745_1746 : H12AffineEnvironment.transform 23 103445 env1745 = env1746 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 103445 env1745 == env1746) = true)

theorem identity1746 : scanCanonicalize (H12AffineFastState.compose env1746 (packedSelected [3,5,8,10,13,15,17,21,24] rootPS)) = affineNative (2^(24+1) ^^^ 302512) := by decide +kernel

theorem selectedBound1746 : packedSelected [3,5,8,10,13,15,17,21,24] rootPS < 2^1333 := by decide +kernel

def env1747 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,1296,32768,65536,4097,262144,1024,32768,4096,4194304,16,103445,302512,5376,4456708,1297,4097,4294794,4117,4294967296,256,4299496607,4096,302521]

theorem envBound1747 : H12AffineFastState.Bounded env1747 := by
  intro p hp
  have h : env1747.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1746_1747 : H12AffineEnvironment.transform 24 302512 env1746 = env1747 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 302512 env1746 == env1747) = true)

theorem identity1747 : scanCanonicalize (H12AffineFastState.compose env1747 (packedSelected [5,8,10,12,17] rootPS)) = affineNative (2^(17+1) ^^^ 40240) := by decide +kernel

theorem selectedBound1747 : packedSelected [5,8,10,12,17] rootPS < 2^1333 := by decide +kernel

def env1748 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,1296,32768,65536,4097,40240,1024,32768,4096,4194304,16,103445,128,5376,4234292,1297,4097,4294794,4117,4294967296,256,4299260335,4096,137]

theorem envBound1748 : H12AffineFastState.Bounded env1748 := by
  intro p hp
  have h : env1748.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1747_1748 : H12AffineEnvironment.transform 17 40240 env1747 = env1748 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 40240 env1747 == env1748) = true)

theorem identity1748 : scanCanonicalize (H12AffineFastState.compose env1748 (packedSelected [10,12,21] rootPS)) = affineNative (2^(14+1) ^^^ 260) := by decide +kernel

theorem selectedBound1748 : packedSelected [10,12,21] rootPS < 2^1333 := by decide +kernel

def env1749 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,1296,260,65536,4097,7220,1024,260,4096,4194304,16,70929,128,5376,4201776,1297,4097,4262286,4117,4294967296,256,4299227307,4096,137]

theorem envBound1749 : H12AffineFastState.Bounded env1749 := by
  intro p hp
  have h : env1749.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1748_1749 : H12AffineEnvironment.transform 14 260 env1748 = env1749 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 260 env1748 == env1749) = true)

theorem identity1749 : scanCanonicalize (H12AffineFastState.compose env1749 (packedSelected [5,8] rootPS)) = affineNative (2^(15+1) ^^^ 139) := by decide +kernel

theorem selectedBound1749 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env1750 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,1296,260,139,4097,7220,1024,260,4096,4194304,16,5530,128,5376,4201776,1297,4097,4196613,4117,4294967296,256,4299161632,4096,137]

theorem envBound1750 : H12AffineFastState.Bounded env1750 := by
  intro p hp
  have h : env1750.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1749_1750 : H12AffineEnvironment.transform 15 139 env1749 = env1750 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 139 env1749 == env1750) = true)

theorem identity1750 : scanCanonicalize (H12AffineFastState.compose env1750 (packedSelected [6,10,12,13] rootPS)) = affineNative (2^(31+1) ^^^ 4201503) := by decide +kernel

theorem selectedBound1750 : packedSelected [6,10,12,13] rootPS < 2^1333 := by decide +kernel

def env1751 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,1296,260,139,4097,7220,1024,260,4096,4194304,16,5530,128,5376,4201776,1297,4097,4196613,4117,4201503,256,7231,4096,137]

theorem envBound1751 : H12AffineFastState.Bounded env1751 := by
  intro p hp
  have h : env1751.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1750_1751 : H12AffineEnvironment.transform 31 4201503 env1750 = env1751 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4201503 env1750 == env1751) = true)

def env1752 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,1296,260,139,4097,7220,1024,260,4096,5408,16,5530,128,5376,2064,1297,4097,7205,4117,2367,256,7231,4096,137]

theorem envBound1752 : H12AffineFastState.Bounded env1752 := by
  intro p hp
  have h : env1752.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1751_1752 : H12AffineEnvironment.transform 21 5408 env1751 = env1752 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5408 env1751 == env1752) = true)

theorem identity1752 : scanCanonicalize (H12AffineFastState.compose env1752 (packedSelected [1] rootPS)) = affineNative (2^(11+1) ^^^ 1427) := by decide +kernel

theorem selectedBound1752 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1753 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1427,9,1296,260,139,1426,2471,1024,260,1427,179,16,9,128,147,2064,1297,1426,2486,1414,2367,256,2476,1427,137]

theorem envBound1753 : H12AffineFastState.Bounded env1753 := by
  intro p hp
  have h : env1753.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1752_1753 : H12AffineEnvironment.transform 11 1427 env1752 = env1753 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1427 env1752 == env1753) = true)

theorem identity1753 : scanCanonicalize (H12AffineFastState.compose env1753 (packedSelected [3,5,6] rootPS)) = affineNative (2^(10+1) ^^^ 27) := by decide +kernel

theorem selectedBound1753 : packedSelected [3,5,6] rootPS < 2^1333 := by decide +kernel

def env1754 : List Nat := [2,4,8,16,32,17,128,256,136,1024,27,1427,9,1296,260,139,1426,444,1024,260,1427,179,16,9,128,147,11,1297,1426,429,1414,292,256,439,1427,137]

theorem envBound1754 : H12AffineFastState.Bounded env1754 := by
  intro p hp
  have h : env1754.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1753_1754 : H12AffineEnvironment.transform 10 27 env1753 = env1754 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 27 env1753 == env1754) = true)

def env1755 : List Nat := [2,4,8,16,32,17,128,20,136,1024,27,1159,9,1028,16,139,1158,168,1024,16,1159,179,16,9,128,147,11,1029,1158,185,1170,48,20,163,1159,137]

theorem envBound1755 : H12AffineFastState.Bounded env1755 := by
  intro p hp
  have h : env1755.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1754_1755 : H12AffineEnvironment.transform 7 20 env1754 = env1755 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 20 env1754 == env1755) = true)

theorem identity1755 : scanCanonicalize (H12AffineFastState.compose env1755 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 35) := by decide +kernel

theorem selectedBound1755 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1756 : List Nat := [2,4,8,16,32,17,35,20,43,1024,27,1060,9,1028,16,40,1061,11,1024,16,1060,16,16,9,35,48,11,1029,1061,26,1073,48,20,0,1060,42]

theorem envBound1756 : H12AffineFastState.Bounded env1756 := by
  intro p hp
  have h : env1756.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1755_1756 : H12AffineEnvironment.transform 6 35 env1755 = env1756 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 35 env1755 == env1756) = true)

theorem identity1756 : scanCanonicalize (H12AffineFastState.compose env1756 (packedSelected [2,5] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound1756 : packedSelected [2,5] rootPS < 2^1333 := by decide +kernel

def env1757 : List Nat := [2,4,3,16,32,17,35,20,32,1024,16,1060,2,1028,16,35,1061,0,1024,16,1060,16,16,2,35,48,0,1029,1061,17,1073,48,20,0,1060,33]

theorem envBound1757 : H12AffineFastState.Bounded env1757 := by
  intro p hp
  have h : env1757.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1756_1757 : H12AffineEnvironment.transform 2 3 env1756 = env1757 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env1756 == env1757) = true)

theorem identity1757 : scanCanonicalize (H12AffineFastState.compose env1757 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound1757 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1758 : List Nat := [2,4,3,16,1,17,2,20,1,1024,16,1029,2,1028,16,2,1028,0,1024,16,1029,16,16,2,2,17,0,1029,1028,17,1040,17,20,0,1029,0]

theorem envBound1758 : H12AffineFastState.Bounded env1758 := by
  intro p hp
  have h : env1758.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1757_1758 : H12AffineEnvironment.transform 4 1 env1757 = env1758 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env1757 == env1758) = true)

theorem identity1758 : scanCanonicalize (H12AffineFastState.compose env1758 (packedSelected [4] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1758 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env1759 : List Nat := [2,4,3,0,1,1,2,4,1,1024,0,1029,2,1028,0,2,1028,0,1024,0,1029,0,0,2,2,1,0,1029,1028,1,1024,1,4,0,1029,0]

theorem envBound1759 : H12AffineFastState.Bounded env1759 := by
  intro p hp
  have h : env1759.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1758_1759 : H12AffineEnvironment.transform 3 0 env1758 = env1759 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1758 == env1759) = true)

def env1760 : List Nat := [2,4,8,16,32,17,128,21,136,1024,27,1158,9,1029,17,139,1159,169,1024,17,1158,179,16,9,128,147,11,1028,1159,184,1171,49,21,162,1158,137]

theorem envBound1760 : H12AffineFastState.Bounded env1760 := by
  intro p hp
  have h : env1760.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1754_1760 : H12AffineEnvironment.transform 7 21 env1754 = env1760 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 21 env1754 == env1760) = true)

theorem identity1760 : scanCanonicalize (H12AffineFastState.compose env1760 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound1760 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1761 : List Nat := [2,4,8,16,0,17,128,21,136,1024,27,1158,9,1029,17,139,1159,137,1024,17,1158,147,16,9,128,147,11,1028,1159,152,1171,17,21,130,1158,137]

theorem envBound1761 : H12AffineFastState.Bounded env1761 := by
  intro p hp
  have h : env1761.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1760_1761 : H12AffineEnvironment.transform 4 0 env1760 = env1761 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1760 == env1761) = true)

theorem identity1761 : scanCanonicalize (H12AffineFastState.compose env1761 (packedSelected [2,5] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound1761 : packedSelected [2,5] rootPS < 2^1333 := by decide +kernel

def env1762 : List Nat := [2,4,8,11,0,10,128,14,136,1024,0,1158,9,1029,10,139,1159,137,1024,10,1158,136,11,9,128,136,11,1028,1159,131,1160,10,14,130,1158,137]

theorem envBound1762 : H12AffineFastState.Bounded env1762 := by
  intro p hp
  have h : env1762.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1761_1762 : H12AffineEnvironment.transform 3 11 env1761 = env1762 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env1761 == env1762) = true)

theorem identity1762 : scanCanonicalize (H12AffineFastState.compose env1762 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound1762 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1763 : List Nat := [2,4,8,11,0,10,2,14,10,1024,0,1028,9,1029,10,9,1029,11,1024,10,1028,10,11,9,2,10,11,1028,1029,1,1034,10,14,0,1028,11]

theorem envBound1763 : H12AffineFastState.Bounded env1763 := by
  intro p hp
  have h : env1763.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1762_1763 : H12AffineEnvironment.transform 6 2 env1762 = env1763 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env1762 == env1763) = true)

theorem identity1763 : scanCanonicalize (H12AffineFastState.compose env1763 (packedSelected [4] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound1763 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env1764 : List Nat := [2,4,3,0,0,1,2,5,1,1024,0,1028,2,1029,1,2,1029,0,1024,1,1028,1,0,2,2,1,0,1028,1029,1,1025,1,5,0,1028,0]

theorem envBound1764 : H12AffineFastState.Bounded env1764 := by
  intro p hp
  have h : env1764.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1763_1764 : H12AffineEnvironment.transform 2 3 env1763 = env1764 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env1763 == env1764) = true)

def env1765 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,1296,260,139,4097,7220,1024,260,4096,5409,16,5530,128,5376,2065,1297,4097,7204,4117,2366,256,7231,4096,137]

theorem envBound1765 : H12AffineFastState.Bounded env1765 := by
  intro p hp
  have h : env1765.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1751_1765 : H12AffineEnvironment.transform 21 5409 env1751 = env1765 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5409 env1751 == env1765) = true)

theorem identity1765 : scanCanonicalize (H12AffineFastState.compose env1765 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound1765 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1766 : List Nat := [2,4,8,16,32,17,3,256,11,1024,2048,4096,9,1296,260,8,4097,7220,1024,260,4096,5409,16,5401,3,5376,2065,1297,4097,7204,4117,2366,256,7231,4096,10]

theorem envBound1766 : H12AffineFastState.Bounded env1766 := by
  intro p hp
  have h : env1766.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1765_1766 : H12AffineEnvironment.transform 6 3 env1765 = env1766 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env1765 == env1766) = true)

theorem identity1766 : scanCanonicalize (H12AffineFastState.compose env1766 (packedSelected [3,5,6] rootPS)) = affineNative (2^(10+1) ^^^ 26) := by decide +kernel

theorem selectedBound1766 : packedSelected [3,5,6] rootPS < 2^1333 := by decide +kernel

def env1767 : List Nat := [2,4,8,16,32,17,3,256,11,1024,26,4096,9,1296,260,8,4097,5166,1024,260,4096,5409,16,5401,3,5376,11,1297,4097,5182,4117,292,256,5157,4096,10]

theorem envBound1767 : H12AffineFastState.Bounded env1767 := by
  intro p hp
  have h : env1767.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1766_1767 : H12AffineEnvironment.transform 10 26 env1766 = env1767 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 26 env1766 == env1767) = true)

def env1768 : List Nat := [2,4,8,16,32,17,3,256,11,1024,26,1296,9,1296,260,8,1297,318,1024,260,1296,49,16,9,3,16,11,1297,1297,302,1285,292,256,309,1296,10]

theorem envBound1768 : H12AffineFastState.Bounded env1768 := by
  intro p hp
  have h : env1768.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1767_1768 : H12AffineEnvironment.transform 11 1296 env1767 = env1768 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env1767 == env1768) = true)

theorem identity1768 : scanCanonicalize (H12AffineFastState.compose env1768 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound1768 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1769 : List Nat := [2,4,8,16,0,17,3,256,11,1024,26,1296,9,1296,260,8,1297,286,1024,260,1296,17,16,9,3,16,11,1297,1297,270,1285,260,256,277,1296,10]

theorem envBound1769 : H12AffineFastState.Bounded env1769 := by
  intro p hp
  have h : env1769.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1768_1769 : H12AffineEnvironment.transform 4 0 env1768 = env1769 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1768 == env1769) = true)

theorem identity1769 : scanCanonicalize (H12AffineFastState.compose env1769 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 31) := by decide +kernel

theorem selectedBound1769 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1770 : List Nat := [2,4,8,16,0,17,3,31,11,1024,26,1039,9,1039,27,8,1038,1,1024,27,1039,17,16,9,3,16,11,1038,1038,17,1050,27,31,10,1039,10]

theorem envBound1770 : H12AffineFastState.Bounded env1770 := by
  intro p hp
  have h : env1770.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1769_1770 : H12AffineEnvironment.transform 7 31 env1769 = env1770 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 31 env1769 == env1770) = true)

theorem identity1770 : scanCanonicalize (H12AffineFastState.compose env1770 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1770 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1771 : List Nat := [2,4,8,0,0,1,3,15,11,1024,10,1039,9,1039,11,8,1038,1,1024,11,1039,1,0,9,3,0,11,1038,1038,1,1034,11,15,10,1039,10]

theorem envBound1771 : H12AffineFastState.Bounded env1771 := by
  intro p hp
  have h : env1771.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1770_1771 : H12AffineEnvironment.transform 3 0 env1770 = env1771 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1770 == env1771) = true)

theorem identity1771 : scanCanonicalize (H12AffineFastState.compose env1771 (packedSelected [7] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1771 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1772 : List Nat := [2,4,2,0,0,1,3,5,1,1024,0,1029,3,1029,1,2,1028,1,1024,1,1029,1,0,3,3,0,1,1028,1028,1,1024,1,5,0,1029,0]

theorem envBound1772 : H12AffineFastState.Bounded env1772 := by
  intro p hp
  have h : env1772.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1771_1772 : H12AffineEnvironment.transform 2 2 env1771 = env1772 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1771 == env1772) = true)

def leafEnv1772 : List Nat := [2,4,2,0,0,1,3,5,1,1024,0,1029,3,1029,1,2,1028,1,1024,1,1029,1,0,3,1024,3,1,0,1,1028,1028,1,1024,1,5,0,4,2,1029,0,0,1028,1]

def active1772 : List Nat := [0,1,9]

def tree1772 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1772 : H12WitnessSearch.Good tree1772 := H12GlobalWitnessIndex.good

theorem leafIdentity1772 : H12AffineFastState.composeSystem env1772 rootObs = leafEnv1772 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1772 rootObs == leafEnv1772) = true)

theorem terminalChecked1772 : H12PackedTerminal.terminalCheckFast leafEnv1772 active1772 tree1772 = true := by decide +kernel

def env1773 : List Nat := [2,4,8,16,32,17,3,256,11,1024,26,1297,9,1296,260,8,1296,319,1024,260,1297,48,16,8,3,17,11,1297,1296,303,1284,292,256,308,1297,10]

theorem envBound1773 : H12AffineFastState.Bounded env1773 := by
  intro p hp
  have h : env1773.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1767_1773 : H12AffineEnvironment.transform 11 1297 env1767 = env1773 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env1767 == env1773) = true)

theorem identity1773 : scanCanonicalize (H12AffineFastState.compose env1773 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 52) := by decide +kernel

theorem selectedBound1773 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1774 : List Nat := [2,4,8,16,32,17,3,52,11,1024,26,1061,9,1060,48,8,1060,11,1024,48,1061,48,16,8,3,17,11,1061,1060,27,1072,16,52,0,1061,10]

theorem envBound1774 : H12AffineFastState.Bounded env1774 := by
  intro p hp
  have h : env1774.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1773_1774 : H12AffineEnvironment.transform 7 52 env1773 = env1774 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 52 env1773 == env1774) = true)

theorem identity1774 : scanCanonicalize (H12AffineFastState.compose env1774 (packedSelected [7] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound1774 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1775 : List Nat := [2,4,8,16,11,17,3,31,11,1024,26,1038,9,1039,27,8,1039,11,1024,27,1038,27,16,8,3,17,11,1038,1039,27,1051,16,31,0,1038,10]

theorem envBound1775 : H12AffineFastState.Bounded env1775 := by
  intro p hp
  have h : env1775.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1774_1775 : H12AffineEnvironment.transform 4 11 env1774 = env1775 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env1774 == env1775) = true)

theorem identity1775 : scanCanonicalize (H12AffineFastState.compose env1775 (packedSelected [10] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1775 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env1776 : List Nat := [2,4,8,0,11,1,3,15,11,1024,10,1038,9,1039,11,8,1039,11,1024,11,1038,11,0,8,3,1,11,1038,1039,11,1035,0,15,0,1038,10]

theorem envBound1776 : H12AffineFastState.Bounded env1776 := by
  intro p hp
  have h : env1776.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1775_1776 : H12AffineEnvironment.transform 3 0 env1775 = env1776 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1775 == env1776) = true)

def env1777 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8,1297,32768,65536,4097,262144,1024,32768,4096,4194304,17,16777216,33554432,16875797,21337360,16879877,4097,20978847,16876544,4294967296,256,4332814639,4096,33554441]

theorem envBound1777 : H12AffineFastState.Bounded env1777 := by
  intro p hp
  have h : env1777.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1744_1777 : H12AffineEnvironment.transform 8 137 env1744 = env1777 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1744 == env1777) = true)

theorem identity1777 : scanCanonicalize (H12AffineFastState.compose env1777 (packedSelected [3,6,10,24,25,26] rootPS)) = affineNative (2^(24+1) ^^^ 5521) := by decide +kernel

theorem selectedBound1777 : packedSelected [3,6,10,24,25,26] rootPS < 2^1333 := by decide +kernel

def env1778 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8,1297,32768,65536,4097,262144,1024,32768,4096,4194304,17,16777216,5521,16875797,21337360,16879877,4097,20978847,16876544,4294967296,256,4299265214,4096,5528]

theorem envBound1778 : H12AffineFastState.Bounded env1778 := by
  intro p hp
  have h : env1778.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1777_1778 : H12AffineEnvironment.transform 24 5521 env1777 = env1778 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 5521 env1777 == env1778) = true)

theorem identity1778 : scanCanonicalize (H12AffineFastState.compose env1778 (packedSelected [1,3,5,6,8,10,19,25] rootPS)) = affineNative (2^(23+1) ^^^ 103445) := by decide +kernel

theorem selectedBound1778 : packedSelected [1,3,5,6,8,10,19,25] rootPS < 2^1333 := by decide +kernel

def env1779 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8,1297,32768,65536,4097,262144,1024,32768,4096,4194304,17,103445,5521,5376,4456709,1296,4097,4294794,4117,4294967296,256,4299265214,4096,5528]

theorem envBound1779 : H12AffineFastState.Bounded env1779 := by
  intro p hp
  have h : env1779.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1778_1779 : H12AffineEnvironment.transform 23 103445 env1778 = env1779 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 103445 env1778 == env1779) = true)

theorem identity1779 : scanCanonicalize (H12AffineFastState.compose env1779 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound1779 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env1780 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,32768,65536,1297,262144,1024,32768,1296,4194304,17,98565,129,16,4456709,1296,1297,4294794,1285,4294967296,256,4299260334,1296,136]

theorem envBound1780 : H12AffineFastState.Bounded env1780 := by
  intro p hp
  have h : env1780.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1779_1780 : H12AffineEnvironment.transform 11 1296 env1779 = env1780 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env1779 == env1780) = true)

theorem identity1780 : scanCanonicalize (H12AffineFastState.compose env1780 (packedSelected [1,3,5] rootPS)) = affineNative (2^(14+1) ^^^ 2340) := by decide +kernel

theorem selectedBound1780 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1781 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,2340,65536,1297,262144,1024,2340,1296,4194304,17,67617,129,16,4456709,1296,1297,4260270,1285,4294967296,256,4299229322,1296,136]

theorem envBound1781 : H12AffineFastState.Bounded env1781 := by
  intro p hp
  have h : env1781.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1780_1781 : H12AffineEnvironment.transform 14 2340 env1780 = env1781 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2340 env1780 == env1781) = true)

theorem identity1781 : scanCanonicalize (H12AffineFastState.compose env1781 (packedSelected [1,3,8] rootPS)) = affineNative (2^(15+1) ^^^ 2218) := by decide +kernel

theorem selectedBound1781 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env1782 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,2340,2218,1297,262144,1024,2340,1296,4194304,17,139,129,16,4456709,1296,1297,4196612,1285,4294967296,256,4299161632,1296,136]

theorem envBound1782 : H12AffineFastState.Bounded env1782 := by
  intro p hp
  have h : env1782.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1781_1782 : H12AffineEnvironment.transform 15 2218 env1781 = env1782 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2218 env1781 == env1782) = true)

theorem identity1782 : scanCanonicalize (H12AffineFastState.compose env1782 (packedSelected [1,3] rootPS)) = affineNative (2^(17+1) ^^^ 2048) := by decide +kernel

theorem selectedBound1782 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env1783 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,2340,2218,1297,2048,1024,2340,1296,4194304,17,139,129,16,4196613,1296,1297,4196612,1285,4294967296,256,4299161632,1296,136]

theorem envBound1783 : H12AffineFastState.Bounded env1783 := by
  intro p hp
  have h : env1783.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1782_1783 : H12AffineEnvironment.transform 17 2048 env1782 = env1783 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2048 env1782 == env1783) = true)

theorem identity1783 : scanCanonicalize (H12AffineFastState.compose env1783 (packedSelected [0,7] rootPS)) = affineNative (2^(21+1) ^^^ 261) := by decide +kernel

theorem selectedBound1783 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env1784 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,2340,2218,1297,2048,1024,2340,1296,261,17,139,129,16,2048,1296,1297,2049,1285,4294967296,256,4294967589,1296,136]

theorem envBound1784 : H12AffineFastState.Bounded env1784 := by
  intro p hp
  have h : env1784.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1783_1784 : H12AffineEnvironment.transform 21 261 env1783 = env1784 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 261 env1783 == env1784) = true)

theorem identity1784 : scanCanonicalize (H12AffineFastState.compose env1784 (packedSelected [1,12] rootPS)) = affineNative (2^(31+1) ^^^ 309) := by decide +kernel

theorem selectedBound1784 : packedSelected [1,12] rootPS < 2^1333 := by decide +kernel

def env1785 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,2340,2218,1297,2048,1024,2340,1296,261,17,139,129,16,2048,1296,1297,2049,1285,309,256,16,1296,136]

theorem envBound1785 : H12AffineFastState.Bounded env1785 := by
  intro p hp
  have h : env1785.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1784_1785 : H12AffineEnvironment.transform 31 309 env1784 = env1785 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 309 env1784 == env1785) = true)

theorem identity1785 : scanCanonicalize (H12AffineFastState.compose env1785 (packedSelected [1,15] rootPS)) = affineNative (2^(10+1) ^^^ 260) := by decide +kernel

theorem selectedBound1785 : packedSelected [1,15] rootPS < 2^1333 := by decide +kernel

def env1786 : List Nat := [2,4,8,16,32,17,128,256,137,1024,260,1296,8,1297,32,430,1297,260,1024,32,1296,261,17,139,129,16,260,1296,1297,261,1285,309,256,16,1296,136]

theorem envBound1786 : H12AffineFastState.Bounded env1786 := by
  intro p hp
  have h : env1786.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1785_1786 : H12AffineEnvironment.transform 10 260 env1785 = env1786 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 260 env1785 == env1786) = true)

def env1787 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,16777216,33554432,17011013,21352528,17024068,131153,1073741824,16876544,4294967296,256,4332975158,131073,33563272]

theorem envBound1787 : H12AffineFastState.Bounded env1787 := by
  intro p hp
  have h : env1787.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1442_1787 : H12AffineEnvironment.transform 18 1025 env1442 = env1787 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env1442 == env1787) = true)

theorem identity1787 : scanCanonicalize (H12AffineFastState.compose env1787 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 21126303) := by decide +kernel

theorem selectedBound1787 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env1788 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,16777216,33554432,17011013,21352528,17024068,131153,21126303,16876544,4294967296,256,4332975158,131073,33563272]

theorem envBound1788 : H12AffineFastState.Bounded env1788 := by
  intro p hp
  have h : env1788.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1787_1788 : H12AffineEnvironment.transform 29 21126303 env1787 = env1788 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 21126303 env1787 == env1788) = true)

def env1789 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1025,32768,4096,4194304,5376,16777216,33554432,17011013,21332048,17011780,131153,21105823,16876544,4294967296,256,4332954678,131073,33563272]

theorem envBound1789 : H12AffineFastState.Bounded env1789 := by
  intro p hp
  have h : env1789.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1788_1789 : H12AffineEnvironment.transform 13 4096 env1788 = env1789 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4096 env1788 == env1789) = true)

def env1790 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1025,32768,4096,4194304,5376,16777216,33554432,17010965,21331968,17011732,131073,21105823,16876544,4294967296,256,4332954678,131073,33563272]

theorem envBound1790 : H12AffineFastState.Bounded env1790 := by
  intro p hp
  have h : env1790.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1789_1790 : H12AffineEnvironment.transform 5 16 env1789 = env1790 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env1789 == env1790) = true)

theorem identity1790 : scanCanonicalize (H12AffineFastState.compose env1790 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(24+1) ^^^ 17015965) := by decide +kernel

theorem selectedBound1790 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env1791 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1025,32768,4096,4194304,5376,16777216,17015965,17010965,21331968,17011732,131073,21105823,16876544,4294967296,256,4315938987,131073,17008149]

theorem envBound1791 : H12AffineFastState.Bounded env1791 := by
  intro p hp
  have h : env1791.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1790_1791 : H12AffineEnvironment.transform 24 17015965 env1790 = env1791 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 17015965 env1790 == env1791) = true)

def env1792 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1025,32768,4096,4194304,5376,16777216,33554432,17010964,21331969,17011733,131072,21105823,16876544,4294967296,256,4332954678,131073,33563272]

theorem envBound1792 : H12AffineFastState.Bounded env1792 := by
  intro p hp
  have h : env1792.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1789_1792 : H12AffineEnvironment.transform 5 17 env1789 = env1792 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env1789 == env1792) = true)

theorem identity1792 : scanCanonicalize (H12AffineFastState.compose env1792 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(23+1) ^^^ 230420) := by decide +kernel

theorem selectedBound1792 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env1793 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1025,32768,4096,4194304,5376,230420,33554432,5376,4588565,4097,131072,4294795,131092,4294967296,256,4332954678,131073,33563272]

theorem envBound1793 : H12AffineFastState.Bounded env1793 := by
  intro p hp
  have h : env1793.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1792_1793 : H12AffineEnvironment.transform 23 230420 env1792 = env1793 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230420 env1792 == env1793) = true)

theorem identity1793 : scanCanonicalize (H12AffineFastState.compose env1793 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound1793 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env1794 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1025,32768,4096,4194304,5376,230420,8329,5376,4588565,4097,131072,4294795,131092,4294967296,256,4299392191,131073,513]

theorem envBound1794 : H12AffineFastState.Bounded env1794 := by
  intro p hp
  have h : env1794.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1793_1794 : H12AffineEnvironment.transform 24 8329 env1793 = env1794 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env1793 == env1794) = true)

theorem identity1794 : scanCanonicalize (H12AffineFastState.compose env1794 (packedSelected [13,21] rootPS)) = affineNative (2^(14+1) ^^^ 13341) := by decide +kernel

theorem selectedBound1794 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env1795 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,13341,65536,131072,262144,1025,13341,4096,4194304,5376,208905,8329,5376,4588565,4097,131072,4275350,131092,4294967296,256,4299370658,131073,513]

theorem envBound1795 : H12AffineFastState.Bounded env1795 := by
  intro p hp
  have h : env1795.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1794_1795 : H12AffineEnvironment.transform 14 13341 env1794 = env1795 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13341 env1794 == env1795) = true)

theorem identity1795 : scanCanonicalize (H12AffineFastState.compose env1795 (packedSelected [0,5,7,8,13,17,20] rootPS)) = affineNative (2^(16+1) ^^^ 1297) := by decide +kernel

theorem selectedBound1795 : packedSelected [0,5,7,8,13,17,20] rootPS < 2^1333 := by decide +kernel

def env1796 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,13341,65536,1297,262144,1025,13341,4096,4194304,5376,79128,8329,5376,4456708,4097,1297,4275350,1285,4294967296,256,4299240883,1296,513]

theorem envBound1796 : H12AffineFastState.Bounded env1796 := by
  intro p hp
  have h : env1796.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1795_1796 : H12AffineEnvironment.transform 16 1297 env1795 = env1796 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1297 env1795 == env1796) = true)

theorem identity1796 : scanCanonicalize (H12AffineFastState.compose env1796 (packedSelected [3,5,10] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound1796 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env1797 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8192,4096,13341,65536,1297,262144,1025,13341,4096,4194304,5376,79128,8329,5376,4456708,4097,1297,4275350,1285,4294967296,256,4299240883,1296,137]

theorem envBound1797 : H12AffineFastState.Bounded env1797 := by
  intro p hp
  have h : env1797.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1796_1797 : H12AffineEnvironment.transform 8 136 env1796 = env1797 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1796 == env1797) = true)

theorem identity1797 : scanCanonicalize (H12AffineFastState.compose env1797 (packedSelected [1,6,8,12] rootPS)) = affineNative (2^(15+1) ^^^ 13699) := by decide +kernel

theorem selectedBound1797 : packedSelected [1,6,8,12] rootPS < 2^1333 := by decide +kernel

def env1798 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8192,4096,13341,13699,1297,262144,1025,13341,4096,4194304,5376,155,8329,5376,4456708,4097,1297,4196629,1285,4294967296,256,4299161648,1296,137]

theorem envBound1798 : H12AffineFastState.Bounded env1798 := by
  intro p hp
  have h : env1798.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1797_1798 : H12AffineEnvironment.transform 15 13699 env1797 = env1798 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13699 env1797 == env1798) = true)

theorem identity1798 : scanCanonicalize (H12AffineFastState.compose env1798 (packedSelected [6,8,13] rootPS)) = affineNative (2^(12+1) ^^^ 7465) := by decide +kernel

theorem selectedBound1798 : packedSelected [6,8,13] rootPS < 2^1333 := by decide +kernel

def env1799 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,7465,4096,2356,2218,1297,262144,1025,2356,4096,4194304,5376,155,7584,5376,4456708,4097,1297,4196629,1285,4294967296,256,4299161648,1296,137]

theorem envBound1799 : H12AffineFastState.Bounded env1799 := by
  intro p hp
  have h : env1799.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1798_1799 : H12AffineEnvironment.transform 12 7465 env1798 = env1799 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 7465 env1798 == env1799) = true)

theorem identity1799 : scanCanonicalize (H12AffineFastState.compose env1799 (packedSelected [3,5,6,15] rootPS)) = affineNative (2^(17+1) ^^^ 7220) := by decide +kernel

theorem selectedBound1799 : packedSelected [3,5,6,15] rootPS < 2^1333 := by decide +kernel

def env1800 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,7465,4096,2356,2218,1297,7220,1025,2356,4096,4194304,5376,155,7584,5376,4201776,4097,1297,4196629,1285,4294967296,256,4299161648,1296,137]

theorem envBound1800 : H12AffineFastState.Bounded env1800 := by
  intro p hp
  have h : env1800.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1799_1800 : H12AffineEnvironment.transform 17 7220 env1799 = env1800 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 7220 env1799 == env1800) = true)

theorem identity1800 : scanCanonicalize (H12AffineFastState.compose env1800 (packedSelected [1,6] rootPS)) = affineNative (2^(21+1) ^^^ 276) := by decide +kernel

theorem selectedBound1800 : packedSelected [1,6] rootPS < 2^1333 := by decide +kernel

def env1801 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,7465,4096,2356,2218,1297,7220,1025,2356,4096,276,5376,155,7584,5376,7204,4097,1297,2049,1285,4294967296,256,4294967588,1296,137]

theorem envBound1801 : H12AffineFastState.Bounded env1801 := by
  intro p hp
  have h : env1801.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1800_1801 : H12AffineEnvironment.transform 21 276 env1800 = env1801 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 276 env1800 == env1801) = true)

theorem identity1801 : scanCanonicalize (H12AffineFastState.compose env1801 (packedSelected [0,1,2,4] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1801 : packedSelected [0,1,2,4] rootPS < 2^1333 := by decide +kernel

def env1802 : List Nat := [2,4,8,0,32,1,128,256,136,1024,2048,4096,7465,4096,2340,2218,1281,7204,1025,2340,4096,260,5376,139,7584,5376,7204,4097,1281,2049,1285,4294967296,256,4294967588,1280,137]

theorem envBound1802 : H12AffineFastState.Bounded env1802 := by
  intro p hp
  have h : env1802.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1801_1802 : H12AffineEnvironment.transform 3 0 env1801 = env1802 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1801 == env1802) = true)

theorem identity1802 : scanCanonicalize (H12AffineFastState.compose env1802 (packedSelected [0,1] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound1802 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env1803 : List Nat := [2,4,8,0,32,1,128,37,136,1024,2048,4096,7180,4096,2049,2218,1060,7204,1025,2049,4096,33,5157,139,7301,5157,7204,4097,1060,2049,1056,4294967296,37,4294967297,1061,137]

theorem envBound1803 : H12AffineFastState.Bounded env1803 := by
  intro p hp
  have h : env1803.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1802_1803 : H12AffineEnvironment.transform 7 37 env1802 = env1803 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env1802 == env1803) = true)

def env1804 : List Nat := [2,4,8,0,32,1,8,37,0,1024,2048,4096,7180,4096,2049,2082,1060,7204,1025,2049,4096,33,5157,3,7181,5157,7204,4097,1060,2049,1056,4294967296,37,4294967297,1061,1]

theorem envBound1804 : H12AffineFastState.Bounded env1804 := by
  intro p hp
  have h : env1804.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1803_1804 : H12AffineEnvironment.transform 6 8 env1803 = env1804 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env1803 == env1804) = true)

theorem identity1804 : scanCanonicalize (H12AffineFastState.compose env1804 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 5135) := by decide +kernel

theorem selectedBound1804 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1805 : List Nat := [2,4,8,0,32,1,8,37,0,1024,2048,4096,7180,4096,2049,2082,1060,7204,1025,2049,4096,33,5157,3,7181,5157,7204,4097,1060,2049,1056,5135,37,5134,1061,1]

theorem envBound1805 : H12AffineFastState.Bounded env1805 := by
  intro p hp
  have h : env1805.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1804_1805 : H12AffineEnvironment.transform 31 5135 env1804 = env1805 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 5135 env1804 == env1805) = true)

def leafEnv1805 : List Nat := [2,4,8,0,32,1,8,37,0,1024,2048,4096,7180,4096,2049,2082,1060,7204,1025,2049,4096,33,5157,3,1057,7181,1,5157,7204,4097,1060,2049,1056,5135,37,5134,4,2082,1061,1,0,1060,1]

def active1805 : List Nat := [0,1,2,4,9,10,11]

def tree1805 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1805 : H12WitnessSearch.Good tree1805 := H12GlobalWitnessIndex.good

theorem leafIdentity1805 : H12AffineFastState.composeSystem env1805 rootObs = leafEnv1805 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1805 rootObs == leafEnv1805) = true)

theorem terminalChecked1805 : H12PackedTerminal.terminalCheckFast leafEnv1805 active1805 tree1805 = true := by decide +kernel

def env1806 : List Nat := [2,4,8,0,32,1,9,37,1,1024,2048,4096,7180,4096,2049,2083,1060,7204,1025,2049,4096,33,5157,2,7180,5157,7204,4097,1060,2049,1056,4294967296,37,4294967297,1061,0]

theorem envBound1806 : H12AffineFastState.Bounded env1806 := by
  intro p hp
  have h : env1806.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1803_1806 : H12AffineEnvironment.transform 6 9 env1803 = env1806 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env1803 == env1806) = true)

theorem identity1806 : scanCanonicalize (H12AffineFastState.compose env1806 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 43) := by decide +kernel

theorem selectedBound1806 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1807 : List Nat := [2,4,8,0,32,1,9,37,1,1024,2048,4096,7180,4096,2049,2083,1060,7204,1025,2049,4096,33,5157,2,7180,5157,7204,4097,1060,2049,1056,43,37,42,1061,0]

theorem envBound1807 : H12AffineFastState.Bounded env1807 := by
  intro p hp
  have h : env1807.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1806_1807 : H12AffineEnvironment.transform 31 43 env1806 = env1807 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 43 env1806 == env1807) = true)

def leafEnv1807 : List Nat := [2,4,8,0,32,1,9,37,1,1024,2048,4096,7180,4096,2049,2083,1060,7204,1025,2049,4096,33,5157,2,1057,7180,1,5157,7204,4097,1060,2049,1056,43,37,42,4,2082,1061,0,0,1060,1]

def active1807 : List Nat := [0,1,2,4,9,10,11]

def tree1807 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1807 : H12WitnessSearch.Good tree1807 := H12GlobalWitnessIndex.good

theorem leafIdentity1807 : H12AffineFastState.composeSystem env1807 rootObs = leafEnv1807 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1807 rootObs == leafEnv1807) = true)

theorem terminalChecked1807 : H12PackedTerminal.terminalCheckFast leafEnv1807 active1807 tree1807 = true := by decide +kernel

def env1808 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1025,32768,4096,4194304,5377,16777216,33554432,17011013,21332049,17011781,131153,21105822,16876544,4294967296,256,4332954679,131073,33563272]

theorem envBound1808 : H12AffineFastState.Bounded env1808 := by
  intro p hp
  have h : env1808.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1788_1808 : H12AffineEnvironment.transform 13 4097 env1788 = env1808 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4097 env1788 == env1808) = true)

def env1809 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1025,32768,4096,4194304,5377,16777216,33554432,17010965,21331969,17011733,131073,21105822,16876544,4294967296,256,4332954679,131073,33563272]

theorem envBound1809 : H12AffineFastState.Bounded env1809 := by
  intro p hp
  have h : env1809.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1808_1809 : H12AffineEnvironment.transform 5 16 env1808 = env1809 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env1808 == env1809) = true)

theorem identity1809 : scanCanonicalize (H12AffineFastState.compose env1809 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(23+1) ^^^ 230421) := by decide +kernel

theorem selectedBound1809 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env1810 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1025,32768,4096,4194304,5377,230421,33554432,5376,4588564,4096,131073,4294795,131093,4294967296,256,4332954679,131073,33563272]

theorem envBound1810 : H12AffineFastState.Bounded env1810 := by
  intro p hp
  have h : env1810.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1809_1810 : H12AffineEnvironment.transform 23 230421 env1809 = env1810 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230421 env1809 == env1810) = true)

theorem identity1810 : scanCanonicalize (H12AffineFastState.compose env1810 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound1810 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env1811 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1025,32768,4096,4194304,5377,230421,8329,5376,4588564,4096,131073,4294795,131093,4294967296,256,4299392190,131073,513]

theorem envBound1811 : H12AffineFastState.Bounded env1811 := by
  intro p hp
  have h : env1811.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1810_1811 : H12AffineEnvironment.transform 24 8329 env1810 = env1811 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env1810 == env1811) = true)

theorem identity1811 : scanCanonicalize (H12AffineFastState.compose env1811 (packedSelected [13,21] rootPS)) = affineNative (2^(14+1) ^^^ 13341) := by decide +kernel

theorem selectedBound1811 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env1812 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,13341,65536,131072,262144,1025,13341,4096,4194304,5377,208904,8329,5376,4588564,4096,131073,4275350,131093,4294967296,256,4299370659,131073,513]

theorem envBound1812 : H12AffineFastState.Bounded env1812 := by
  intro p hp
  have h : env1812.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1811_1812 : H12AffineEnvironment.transform 14 13341 env1811 = env1812 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13341 env1811 == env1812) = true)

theorem identity1812 : scanCanonicalize (H12AffineFastState.compose env1812 (packedSelected [0,5,7,8,13,17,20] rootPS)) = affineNative (2^(16+1) ^^^ 1296) := by decide +kernel

theorem selectedBound1812 : packedSelected [0,5,7,8,13,17,20] rootPS < 2^1333 := by decide +kernel

def env1813 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,13341,65536,1296,262144,1025,13341,4096,4194304,5377,79128,8329,5376,4456708,4096,1297,4275350,1285,4294967296,256,4299240883,1297,513]

theorem envBound1813 : H12AffineFastState.Bounded env1813 := by
  intro p hp
  have h : env1813.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1812_1813 : H12AffineEnvironment.transform 16 1296 env1812 = env1813 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1296 env1812 == env1813) = true)

theorem identity1813 : scanCanonicalize (H12AffineFastState.compose env1813 (packedSelected [3,5,10] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound1813 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env1814 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8192,4097,13341,65536,1296,262144,1025,13341,4096,4194304,5377,79128,8329,5376,4456708,4096,1297,4275350,1285,4294967296,256,4299240883,1297,137]

theorem envBound1814 : H12AffineFastState.Bounded env1814 := by
  intro p hp
  have h : env1814.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1813_1814 : H12AffineEnvironment.transform 8 136 env1813 = env1814 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1813 == env1814) = true)

theorem identity1814 : scanCanonicalize (H12AffineFastState.compose env1814 (packedSelected [1,6,8,12] rootPS)) = affineNative (2^(15+1) ^^^ 8339) := by decide +kernel

theorem selectedBound1814 : packedSelected [1,6,8,12] rootPS < 2^1333 := by decide +kernel

def env1815 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8192,4097,13341,8339,1296,262144,1025,13341,4096,4194304,5377,5515,8329,5376,4456708,4096,1297,4201477,1285,4294967296,256,4299167008,1297,137]

theorem envBound1815 : H12AffineFastState.Bounded env1815 := by
  intro p hp
  have h : env1815.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1814_1815 : H12AffineEnvironment.transform 15 8339 env1814 = env1815 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8339 env1814 == env1815) = true)

theorem identity1815 : scanCanonicalize (H12AffineFastState.compose env1815 (packedSelected [6,8,13] rootPS)) = affineNative (2^(12+1) ^^^ 2105) := by decide +kernel

theorem selectedBound1815 : packedSelected [6,8,13] rootPS < 2^1333 := by decide +kernel

def env1816 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,2105,4097,7204,2218,1296,262144,1025,7204,4096,4194304,5377,5515,2224,5376,4456708,4096,1297,4201477,1285,4294967296,256,4299167008,1297,137]

theorem envBound1816 : H12AffineFastState.Bounded env1816 := by
  intro p hp
  have h : env1816.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1815_1816 : H12AffineEnvironment.transform 12 2105 env1815 = env1816 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2105 env1815 == env1816) = true)

theorem identity1816 : scanCanonicalize (H12AffineFastState.compose env1816 (packedSelected [3,5,6,15] rootPS)) = affineNative (2^(17+1) ^^^ 7220) := by decide +kernel

theorem selectedBound1816 : packedSelected [3,5,6,15] rootPS < 2^1333 := by decide +kernel

def env1817 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,2105,4097,7204,2218,1296,7220,1025,7204,4096,4194304,5377,5515,2224,5376,4201776,4096,1297,4201477,1285,4294967296,256,4299167008,1297,137]

theorem envBound1817 : H12AffineFastState.Bounded env1817 := by
  intro p hp
  have h : env1817.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1816_1817 : H12AffineEnvironment.transform 17 7220 env1816 = env1817 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 7220 env1816 == env1817) = true)

theorem identity1817 : scanCanonicalize (H12AffineFastState.compose env1817 (packedSelected [1,6] rootPS)) = affineNative (2^(21+1) ^^^ 260) := by decide +kernel

theorem selectedBound1817 : packedSelected [1,6] rootPS < 2^1333 := by decide +kernel

def env1818 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,2105,4097,7204,2218,1296,7220,1025,7204,4096,260,5377,5515,2224,5376,7220,4096,1297,7425,1285,4294967296,256,4294972452,1297,137]

theorem envBound1818 : H12AffineFastState.Bounded env1818 := by
  intro p hp
  have h : env1818.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1817_1818 : H12AffineEnvironment.transform 21 260 env1817 = env1818 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 260 env1817 == env1818) = true)

theorem identity1818 : scanCanonicalize (H12AffineFastState.compose env1818 (packedSelected [0,1,2,4] rootPS)) = affineNative (2^(11+1) ^^^ 1280) := by decide +kernel

theorem selectedBound1818 : packedSelected [0,1,2,4] rootPS < 2^1333 := by decide +kernel

def env1819 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1280,2105,1281,2340,2218,1296,2356,1025,2340,1280,260,1,139,2224,0,2356,1280,1297,2049,1285,4294967296,256,4294967588,1297,137]

theorem envBound1819 : H12AffineFastState.Bounded env1819 := by
  intro p hp
  have h : env1819.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1818_1819 : H12AffineEnvironment.transform 11 1280 env1818 = env1819 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1280 env1818 == env1819) = true)

theorem identity1819 : scanCanonicalize (H12AffineFastState.compose env1819 (packedSelected [0,1] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound1819 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env1820 : List Nat := [2,4,8,16,32,16,128,37,136,1024,2048,1061,2105,1060,2049,2218,1077,2065,1025,2049,1061,33,1,139,2224,0,2065,1061,1076,2049,1056,4294967296,37,4294967297,1076,137]

theorem envBound1820 : H12AffineFastState.Bounded env1820 := by
  intro p hp
  have h : env1820.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1819_1820 : H12AffineEnvironment.transform 7 37 env1819 = env1820 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env1819 == env1820) = true)

def env1821 : List Nat := [2,4,8,0,32,0,128,37,136,1024,2048,1061,2089,1060,2049,2218,1061,2049,1025,2049,1061,33,1,139,2208,0,2049,1061,1060,2049,1056,4294967296,37,4294967297,1060,137]

theorem envBound1821 : H12AffineFastState.Bounded env1821 := by
  intro p hp
  have h : env1821.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1820_1821 : H12AffineEnvironment.transform 3 0 env1820 = env1821 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1820 == env1821) = true)

theorem identity1821 : scanCanonicalize (H12AffineFastState.compose env1821 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 162) := by decide +kernel

theorem selectedBound1821 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1822 : List Nat := [2,4,8,0,32,0,128,37,136,1024,2048,1061,2089,1060,2049,2218,1061,2049,1025,2049,1061,33,1,139,2208,0,2049,1061,1060,2049,1056,162,37,163,1060,137]

theorem envBound1822 : H12AffineFastState.Bounded env1822 := by
  intro p hp
  have h : env1822.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1821_1822 : H12AffineEnvironment.transform 31 162 env1821 = env1822 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 162 env1821 == env1822) = true)

def leafEnv1822 : List Nat := [2,4,8,0,32,0,128,37,136,1024,2048,1061,2089,1060,2049,2218,1061,2049,1025,2049,1061,33,1,139,1057,2208,1,0,2049,1061,1060,2049,1056,162,37,163,4,2082,1060,137,0,1060,1]

def active1822 : List Nat := [0,1,2,4,6,9,10]

def tree1822 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1822 : H12WitnessSearch.Good tree1822 := H12GlobalWitnessIndex.good

theorem leafIdentity1822 : H12AffineFastState.composeSystem env1822 rootObs = leafEnv1822 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1822 rootObs == leafEnv1822) = true)

theorem terminalChecked1822 : H12PackedTerminal.terminalCheckFast leafEnv1822 active1822 tree1822 = true := by decide +kernel

def env1823 : List Nat := [2,4,8,1,32,1,128,37,136,1024,2048,1061,2088,1060,2049,2218,1060,2048,1025,2049,1061,33,1,139,2209,0,2048,1061,1061,2049,1056,4294967296,37,4294967297,1061,137]

theorem envBound1823 : H12AffineFastState.Bounded env1823 := by
  intro p hp
  have h : env1823.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1820_1823 : H12AffineEnvironment.transform 3 1 env1820 = env1823 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env1820 == env1823) = true)

theorem identity1823 : scanCanonicalize (H12AffineFastState.compose env1823 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 43) := by decide +kernel

theorem selectedBound1823 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1824 : List Nat := [2,4,8,1,32,1,128,37,136,1024,2048,1061,2088,1060,2049,2218,1060,2048,1025,2049,1061,33,1,139,2209,0,2048,1061,1061,2049,1056,43,37,42,1061,137]

theorem envBound1824 : H12AffineFastState.Bounded env1824 := by
  intro p hp
  have h : env1824.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1823_1824 : H12AffineEnvironment.transform 31 43 env1823 = env1824 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 43 env1823 == env1824) = true)

def leafEnv1824 : List Nat := [2,4,8,1,32,1,128,37,136,1024,2048,1061,2088,1060,2049,2218,1060,2048,1025,2049,1061,33,1,139,1057,2209,1,0,2048,1061,1061,2049,1056,43,37,42,4,2082,1061,137,0,1061,1]

def active1824 : List Nat := [0,1,2,4,6,9,10]

def tree1824 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1824 : H12WitnessSearch.Good tree1824 := H12GlobalWitnessIndex.good

theorem leafIdentity1824 : H12AffineFastState.composeSystem env1824 rootObs = leafEnv1824 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1824 rootObs == leafEnv1824) = true)

theorem terminalChecked1824 : H12PackedTerminal.terminalCheckFast leafEnv1824 active1824 tree1824 = true := by decide +kernel

def env1825 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1025,32768,4096,4194304,5377,16777216,33554432,17010964,21331968,17011732,131072,21105822,16876544,4294967296,256,4332954679,131073,33563272]

theorem envBound1825 : H12AffineFastState.Bounded env1825 := by
  intro p hp
  have h : env1825.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1808_1825 : H12AffineEnvironment.transform 5 17 env1808 = env1825 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env1808 == env1825) = true)

theorem identity1825 : scanCanonicalize (H12AffineFastState.compose env1825 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(24+1) ^^^ 17015964) := by decide +kernel

theorem selectedBound1825 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env1826 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1025,32768,4096,4194304,5377,16777216,17015964,17010964,21331968,17011732,131072,21105822,16876544,4294967296,256,4315938987,131073,17008148]

theorem envBound1826 : H12AffineFastState.Bounded env1826 := by
  intro p hp
  have h : env1826.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1825_1826 : H12AffineEnvironment.transform 24 17015964 env1825 = env1826 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 17015964 env1825 == env1826) = true)

def env1827 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,19104069,21352529,19125316,2232400,1073741824,18977793,4294967296,2101505,4335591479,131073,33563272]

theorem envBound1827 : H12AffineFastState.Bounded env1827 := by
  intro p hp
  have h : env1827.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1440_1827 : H12AffineEnvironment.transform 26 21352529 env1440 = env1827 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 21352529 env1440 == env1827) = true)

theorem identity1827 : scanCanonicalize (H12AffineFastState.compose env1827 (packedSelected [35] rootPS)) = affineNative (2^(23+1) ^^^ 2331716) := by decide +kernel

theorem selectedBound1827 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env1828 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,2331716,33554432,5377,6702101,16384,2232400,1073741824,131141,4294967296,2101505,4335591479,131073,33563272]

theorem envBound1828 : H12AffineFastState.Bounded env1828 := by
  intro p hp
  have h : env1828.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1827_1828 : H12AffineEnvironment.transform 23 2331716 env1827 = env1828 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 2331716 env1827 == env1828) = true)

def env1829 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,529408,4194304,17664,753732,33554432,5377,5132309,16384,656464,1073741824,131141,4294967296,525569,4332975159,131073,33563272]

theorem envBound1829 : H12AffineFastState.Bounded env1829 := by
  intro p hp
  have h : env1829.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1828_1829 : H12AffineEnvironment.transform 20 529408 env1828 = env1829 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 529408 env1828 == env1829) = true)

theorem identity1829 : scanCanonicalize (H12AffineFastState.compose env1829 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 4840666) := by decide +kernel

theorem selectedBound1829 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env1830 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,529408,4194304,17664,753732,33554432,5377,5132309,16384,656464,4840666,131141,4294967296,525569,4332975159,131073,33563272]

theorem envBound1830 : H12AffineFastState.Bounded env1830 := by
  intro p hp
  have h : env1830.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1829_1830 : H12AffineEnvironment.transform 29 4840666 env1829 = env1830 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4840666 env1829 == env1830) = true)

theorem identity1830 : scanCanonicalize (H12AffineFastState.compose env1830 (packedSelected [15,17,19,21,26,38] rootPS)) = affineNative (2^(24+1) ^^^ 554200) := by decide +kernel

theorem selectedBound1830 : packedSelected [15,17,19,21,26,38] rootPS < 2^1333 := by decide +kernel

def env1831 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,529408,4194304,17664,753732,554200,5377,5132309,16384,656464,4840666,131141,4294967296,525569,4299915503,131073,546384]

theorem envBound1831 : H12AffineFastState.Bounded env1831 := by
  intro p hp
  have h : env1831.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1830_1831 : H12AffineEnvironment.transform 24 554200 env1830 = env1831 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 554200 env1830 == env1831) = true)

theorem identity1831 : scanCanonicalize (H12AffineFastState.compose env1831 (packedSelected [3,6,10,24,25,26] rootPS)) = affineNative (2^(13+1) ^^^ 4177) := by decide +kernel

theorem selectedBound1831 : packedSelected [3,6,10,24,25,26] rootPS < 2^1333 := by decide +kernel

def env1832 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,529408,4194304,5457,753732,533641,5377,5111876,4177,656464,4820107,131141,4294967296,525569,4299915503,131073,525825]

theorem envBound1832 : H12AffineFastState.Bounded env1832 := by
  intro p hp
  have h : env1832.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1831_1832 : H12AffineEnvironment.transform 13 4177 env1831 = env1832 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env1831 == env1832) = true)

def env1833 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,8192,1345,32768,65536,131072,262144,524288,32768,524560,4194304,65,753732,533641,17,5111876,1345,656464,4820107,131141,4294967296,525569,4299915503,131073,525825]

theorem envBound1833 : H12AffineFastState.Bounded env1833 := by
  intro p hp
  have h : env1833.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1832_1833 : H12AffineEnvironment.transform 11 1296 env1832 = env1833 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env1832 == env1833) = true)

theorem identity1833 : scanCanonicalize (H12AffineFastState.compose env1833 (packedSelected [3,12,13,15,21,24] rootPS)) = affineNative (2^(17+1) ^^^ 76199) := by decide +kernel

theorem selectedBound1833 : packedSelected [3,12,13,15,21,24] rootPS < 2^1333 := by decide +kernel

def env1834 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,8192,1345,32768,65536,131072,76199,524288,32768,524560,4194304,65,753732,533641,17,4925923,1345,656464,4820107,131141,4294967296,525569,4299915503,131073,525825]

theorem envBound1834 : H12AffineFastState.Bounded env1834 := by
  intro p hp
  have h : env1834.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1833_1834 : H12AffineEnvironment.transform 17 76199 env1833 = env1834 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 76199 env1833 == env1834) = true)

theorem identity1834 : scanCanonicalize (H12AffineFastState.compose env1834 (packedSelected [10,11,12,13,15,16,17,18,19,20,23,32] rootPS)) = affineNative (2^(15+1) ^^^ 33167) := by decide +kernel

theorem selectedBound1834 : packedSelected [10,11,12,13,15,16,17,18,19,20,23,32] rootPS < 2^1333 := by decide +kernel

def env1835 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,8192,1345,32768,33167,131072,43048,524288,32768,524560,4194304,65,655819,533641,17,4892780,1345,656464,4721924,131141,4294967296,525569,4299817312,131073,525825]

theorem envBound1835 : H12AffineFastState.Bounded env1835 := by
  intro p hp
  have h : env1835.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1834_1835 : H12AffineEnvironment.transform 15 33167 env1834 = env1835 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33167 env1834 == env1835) = true)

theorem identity1835 : scanCanonicalize (H12AffineFastState.compose env1835 (packedSelected [10,12,13,15,17,19] rootPS)) = affineNative (2^(18+1) ^^^ 131393) := by decide +kernel

theorem selectedBound1835 : packedSelected [10,12,13,15,17,19] rootPS < 2^1333 := by decide +kernel

def env1836 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,8192,1345,32768,33167,131072,43048,131393,32768,131153,4194304,65,138,140744,17,4237613,1345,1297,4328517,131141,4294967296,132160,4299161633,131073,132928]

theorem envBound1836 : H12AffineFastState.Bounded env1836 := by
  intro p hp
  have h : env1836.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1835_1836 : H12AffineEnvironment.transform 18 131393 env1835 = env1836 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 131393 env1835 == env1836) = true)

def env1837 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,8192,1345,32768,33167,1344,43048,1025,32768,1297,4194304,65,138,8328,17,4237613,1345,1297,4196613,1285,4294967296,256,4299161633,1345,512]

theorem envBound1837 : H12AffineFastState.Bounded env1837 := by
  intro p hp
  have h : env1837.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1836_1837 : H12AffineEnvironment.transform 16 1344 env1836 = env1837 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env1836 == env1837) = true)

theorem identity1837 : scanCanonicalize (H12AffineFastState.compose env1837 (packedSelected [1,3] rootPS)) = affineNative (2^(14+1) ^^^ 8233) := by decide +kernel

theorem selectedBound1837 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env1838 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,8192,1345,8233,8614,1344,2049,1025,8233,1297,4194304,65,138,8328,17,4196612,1345,1297,4196613,1285,4294967296,256,4299161633,1345,512]

theorem envBound1838 : H12AffineFastState.Bounded env1838 := by
  intro p hp
  have h : env1838.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1837_1838 : H12AffineEnvironment.transform 14 8233 env1837 = env1838 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8233 env1837 == env1838) = true)

theorem identity1838 : scanCanonicalize (H12AffineFastState.compose env1838 (packedSelected [0,7] rootPS)) = affineNative (2^(12+1) ^^^ 501) := by decide +kernel

theorem selectedBound1838 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env1839 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,501,1345,476,83,1344,2049,1025,476,1297,4194304,65,138,381,17,4196612,1345,1297,4196613,1285,4294967296,256,4299161633,1345,512]

theorem envBound1839 : H12AffineFastState.Bounded env1839 := by
  intro p hp
  have h : env1839.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1838_1839 : H12AffineEnvironment.transform 12 501 env1838 = env1839 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 501 env1838 == env1839) = true)

theorem identity1839 : scanCanonicalize (H12AffineFastState.compose env1839 (packedSelected [5,8] rootPS)) = affineNative (2^(21+1) ^^^ 397) := by decide +kernel

theorem selectedBound1839 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env1840 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,501,1345,476,83,1344,2049,1025,476,1297,397,65,138,381,17,2185,1345,1297,2184,1285,4294967296,256,4294967724,1345,512]

theorem envBound1840 : H12AffineFastState.Bounded env1840 := by
  intro p hp
  have h : env1840.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1839_1840 : H12AffineEnvironment.transform 21 397 env1839 = env1840 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 397 env1839 == env1840) = true)

theorem identity1840 : scanCanonicalize (H12AffineFastState.compose env1840 (packedSelected [2,4] rootPS)) = affineNative (2^(8+1) ^^^ 268) := by decide +kernel

theorem selectedBound1840 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env1841 : List Nat := [2,4,8,16,32,64,128,256,268,1024,2048,1296,501,1345,476,83,1344,2049,1025,476,1297,397,65,138,381,17,2185,1345,1297,2184,1285,4294967296,256,4294967724,1345,268]

theorem envBound1841 : H12AffineFastState.Bounded env1841 := by
  intro p hp
  have h : env1841.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1840_1841 : H12AffineEnvironment.transform 8 268 env1840 = env1841 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 268 env1840 == env1841) = true)

theorem identity1841 : scanCanonicalize (H12AffineFastState.compose env1841 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 372) := by decide +kernel

theorem selectedBound1841 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1842 : List Nat := [2,4,8,16,32,64,128,256,268,1024,2048,1296,501,1345,476,83,1344,2049,1025,476,1297,397,65,138,381,17,2185,1345,1297,2184,1285,372,256,216,1345,268]

theorem envBound1842 : H12AffineFastState.Bounded env1842 := by
  intro p hp
  have h : env1842.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1841_1842 : H12AffineEnvironment.transform 31 372 env1841 = env1842 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 372 env1841 == env1842) = true)

theorem identity1842 : scanCanonicalize (H12AffineFastState.compose env1842 (packedSelected [2,9] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound1842 : packedSelected [2,9] rootPS < 2^1333 := by decide +kernel

def env1843 : List Nat := [2,4,8,16,32,64,8,256,268,1024,2048,1296,381,1345,340,83,1344,2049,1025,340,1297,261,65,2,381,17,2049,1345,1297,2048,1285,372,256,80,1345,268]

theorem envBound1843 : H12AffineFastState.Bounded env1843 := by
  intro p hp
  have h : env1843.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1842_1843 : H12AffineEnvironment.transform 6 8 env1842 = env1843 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env1842 == env1843) = true)

theorem identity1843 : scanCanonicalize (H12AffineFastState.compose env1843 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 114) := by decide +kernel

theorem selectedBound1843 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1844 : List Nat := [2,4,8,16,32,64,8,256,268,1024,114,1296,381,1345,340,83,1344,115,1025,340,1297,261,65,2,381,17,115,1345,1297,114,1285,372,256,80,1345,268]

theorem envBound1844 : H12AffineFastState.Bounded env1844 := by
  intro p hp
  have h : env1844.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1843_1844 : H12AffineEnvironment.transform 10 114 env1843 = env1844 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 114 env1843 == env1844) = true)

theorem identity1844 : scanCanonicalize (H12AffineFastState.compose env1844 (packedSelected [1,5,10] rootPS)) = affineNative (2^(9+1) ^^^ 264) := by decide +kernel

theorem selectedBound1844 : packedSelected [1,5,10] rootPS < 2^1333 := by decide +kernel

def env1845 : List Nat := [2,4,8,16,32,64,8,256,268,264,114,24,381,73,340,83,72,115,265,340,25,261,65,2,381,17,115,73,25,114,13,372,256,80,73,268]

theorem envBound1845 : H12AffineFastState.Bounded env1845 := by
  intro p hp
  have h : env1845.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1844_1845 : H12AffineEnvironment.transform 9 264 env1844 = env1845 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 264 env1844 == env1845) = true)

theorem identity1845 : scanCanonicalize (H12AffineFastState.compose env1845 (packedSelected [12] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound1845 : packedSelected [12] rootPS < 2^1333 := by decide +kernel

def env1846 : List Nat := [1,4,8,16,32,64,8,256,268,264,113,24,381,73,340,80,72,112,265,340,25,261,65,1,381,17,112,73,25,113,13,372,256,80,73,268]

theorem envBound1846 : H12AffineFastState.Bounded env1846 := by
  intro p hp
  have h : env1846.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1845_1846 : H12AffineEnvironment.transform 0 1 env1845 = env1846 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env1845 == env1846) = true)

theorem identity1846 : scanCanonicalize (H12AffineFastState.compose env1846 (packedSelected [1,5,13] rootPS)) = affineNative (2^(5+1) ^^^ 57) := by decide +kernel

theorem selectedBound1846 : packedSelected [1,5,13] rootPS < 2^1333 := by decide +kernel

def env1847 : List Nat := [1,4,8,16,32,57,8,256,268,264,8,24,260,48,301,41,49,9,265,301,25,261,56,1,260,17,9,48,25,8,13,269,256,41,48,268]

theorem envBound1847 : H12AffineFastState.Bounded env1847 := by
  intro p hp
  have h : env1847.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1846_1847 : H12AffineEnvironment.transform 5 57 env1846 = env1847 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 57 env1846 == env1847) = true)

theorem identity1847 : scanCanonicalize (H12AffineFastState.compose env1847 (packedSelected [1] rootPS)) = affineNative (2^(2+1) ^^^ 0) := by decide +kernel

theorem selectedBound1847 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1848 : List Nat := [1,4,0,16,32,49,0,256,260,256,0,16,260,48,293,33,49,1,257,293,17,261,48,1,260,17,1,48,17,0,5,261,256,33,48,260]

theorem envBound1848 : H12AffineFastState.Bounded env1848 := by
  intro p hp
  have h : env1848.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1847_1848 : H12AffineEnvironment.transform 2 0 env1847 = env1848 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env1847 == env1848) = true)

theorem identity1848 : scanCanonicalize (H12AffineFastState.compose env1848 (packedSelected [2] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound1848 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1849 : List Nat := [1,4,0,16,32,49,0,4,0,4,0,16,0,48,33,33,49,1,5,33,17,1,48,1,0,17,1,48,17,0,5,1,4,33,48,0]

theorem envBound1849 : H12AffineFastState.Bounded env1849 := by
  intro p hp
  have h : env1849.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1848_1849 : H12AffineEnvironment.transform 7 4 env1848 = env1849 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env1848 == env1849) = true)

theorem identity1849 : scanCanonicalize (H12AffineFastState.compose env1849 (packedSelected [21] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound1849 : packedSelected [21] rootPS < 2^1333 := by decide +kernel

def env1850 : List Nat := [1,4,0,16,1,16,0,4,0,4,0,16,0,17,0,0,16,1,5,0,17,1,17,1,0,17,1,17,17,0,5,1,4,0,17,0]

theorem envBound1850 : H12AffineFastState.Bounded env1850 := by
  intro p hp
  have h : env1850.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1849_1850 : H12AffineEnvironment.transform 4 1 env1849 = env1850 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env1849 == env1850) = true)

def leafEnv1850 : List Nat := [1,4,0,16,1,16,0,4,0,4,0,16,0,17,0,0,16,1,5,0,17,1,17,1,4,0,1,17,1,17,17,0,5,1,4,0,4,0,17,0,0,17,1]

def active1850 : List Nat := [1,3]

def tree1850 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1850 : H12WitnessSearch.Good tree1850 := H12GlobalWitnessIndex.good

theorem leafIdentity1850 : H12AffineFastState.composeSystem env1850 rootObs = leafEnv1850 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1850 rootObs == leafEnv1850) = true)

theorem terminalChecked1850 : H12PackedTerminal.terminalCheckFast leafEnv1850 active1850 tree1850 = true := by decide +kernel

def env1851 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,8192,1345,32768,33167,1345,43048,1024,32768,1296,4194304,65,138,8329,17,4237613,1345,1297,4196612,1284,4294967296,257,4299161633,1344,513]

theorem envBound1851 : H12AffineFastState.Bounded env1851 := by
  intro p hp
  have h : env1851.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1836_1851 : H12AffineEnvironment.transform 16 1345 env1836 = env1851 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env1836 == env1851) = true)

theorem identity1851 : scanCanonicalize (H12AffineFastState.compose env1851 (packedSelected [1,3] rootPS)) = affineNative (2^(31+1) ^^^ 10740) := by decide +kernel

theorem selectedBound1851 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env1852 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,8192,1345,32768,33167,1345,43048,1024,32768,1296,4194304,65,138,8329,17,4237613,1345,1297,4196612,1284,10740,257,4205013,1344,513]

theorem envBound1852 : H12AffineFastState.Bounded env1852 := by
  intro p hp
  have h : env1852.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1851_1852 : H12AffineEnvironment.transform 31 10740 env1851 = env1852 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 10740 env1851 == env1852) = true)

theorem identity1852 : scanCanonicalize (H12AffineFastState.compose env1852 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound1852 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env1853 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1296,8192,1345,32768,33167,1345,43048,1024,32768,1296,4194304,65,138,8329,17,4237613,1345,1297,4196612,1284,10740,257,4205013,1344,136]

theorem envBound1853 : H12AffineFastState.Bounded env1853 := by
  intro p hp
  have h : env1853.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1852_1853 : H12AffineEnvironment.transform 8 137 env1852 = env1853 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1852 == env1853) = true)

theorem identity1853 : scanCanonicalize (H12AffineFastState.compose env1853 (packedSelected [5] rootPS)) = affineNative (2^(21+1) ^^^ 10508) := by decide +kernel

theorem selectedBound1853 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1854 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1296,8192,1345,32768,33167,1345,43048,1024,32768,1296,10508,65,138,8329,17,32801,1345,1297,8200,1284,10740,257,217,1344,136]

theorem envBound1854 : H12AffineFastState.Bounded env1854 := by
  intro p hp
  have h : env1854.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1853_1854 : H12AffineEnvironment.transform 21 10508 env1853 = env1854 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10508 env1853 == env1854) = true)

theorem identity1854 : scanCanonicalize (H12AffineFastState.compose env1854 (packedSelected [1,10] rootPS)) = affineNative (2^(14+1) ^^^ 8493) := by decide +kernel

theorem selectedBound1854 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env1855 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1296,8192,1345,8493,8354,1345,2309,1024,8493,1296,10508,65,138,8329,17,8460,1345,1297,8200,1284,10740,257,217,1344,136]

theorem envBound1855 : H12AffineFastState.Bounded env1855 := by
  intro p hp
  have h : env1855.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1854_1855 : H12AffineEnvironment.transform 14 8493 env1854 = env1855 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8493 env1854 == env1855) = true)

theorem identity1855 : scanCanonicalize (H12AffineFastState.compose env1855 (packedSelected [6,7] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1855 : packedSelected [6,7] rootPS < 2^1333 := by decide +kernel

def env1856 : List Nat := [2,4,8,16,32,64,128,5,137,1024,2048,1045,8192,1092,8232,8354,1092,2048,1024,8232,1045,10249,65,138,8329,17,8201,1092,1044,8200,1025,10481,4,217,1093,136]

theorem envBound1856 : H12AffineFastState.Bounded env1856 := by
  intro p hp
  have h : env1856.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1855_1856 : H12AffineEnvironment.transform 7 5 env1855 = env1856 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1855 == env1856) = true)

theorem identity1856 : scanCanonicalize (H12AffineFastState.compose env1856 (packedSelected [1,13] rootPS)) = affineNative (2^(12+1) ^^^ 2057) := by decide +kernel

theorem selectedBound1856 : packedSelected [1,13] rootPS < 2^1333 := by decide +kernel

def env1857 : List Nat := [2,4,8,16,32,64,128,5,137,1024,2048,1045,2057,1092,2081,2219,1092,2048,1024,2081,1045,0,65,138,2176,17,2048,1092,1044,2049,1025,248,4,217,1093,136]

theorem envBound1857 : H12AffineFastState.Bounded env1857 := by
  intro p hp
  have h : env1857.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1856_1857 : H12AffineEnvironment.transform 12 2057 env1856 = env1857 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2057 env1856 == env1857) = true)

def env1858 : List Nat := [2,4,8,16,0,64,128,5,137,1024,2048,1045,2057,1092,2049,2187,1092,2048,1024,2049,1045,0,65,138,2176,17,2048,1092,1044,2049,1025,216,4,217,1093,136]

theorem envBound1858 : H12AffineFastState.Bounded env1858 := by
  intro p hp
  have h : env1858.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1857_1858 : H12AffineEnvironment.transform 4 0 env1857 = env1858 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1857 == env1858) = true)

theorem identity1858 : scanCanonicalize (H12AffineFastState.compose env1858 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 1039) := by decide +kernel

theorem selectedBound1858 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1859 : List Nat := [2,4,8,16,0,64,128,5,137,1024,1039,1045,1030,1092,1038,1156,1092,1039,1024,1038,1045,0,65,138,1167,17,1039,1092,1044,1038,1025,216,4,217,1093,136]

theorem envBound1859 : H12AffineFastState.Bounded env1859 := by
  intro p hp
  have h : env1859.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1858_1859 : H12AffineEnvironment.transform 10 1039 env1858 = env1859 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1039 env1858 == env1859) = true)

theorem identity1859 : scanCanonicalize (H12AffineFastState.compose env1859 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound1859 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1860 : List Nat := [2,4,8,16,0,64,8,5,1,1024,1039,1045,1030,1092,1038,1036,1092,1039,1024,1038,1045,0,65,2,1031,17,1039,1092,1044,1038,1025,80,4,81,1093,0]

theorem envBound1860 : H12AffineFastState.Bounded env1860 := by
  intro p hp
  have h : env1860.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1859_1860 : H12AffineEnvironment.transform 6 8 env1859 = env1860 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env1859 == env1860) = true)

def leafEnv1860 : List Nat := [2,4,8,16,0,64,8,5,1,1024,1039,1045,1030,1092,1038,1036,1092,1039,1024,1038,1045,0,65,2,1024,1031,1,17,1039,1092,1044,1038,1025,80,4,81,4,1037,1093,0,0,1045,1]

def active1860 : List Nat := [0,1,2,3,5,9]

def tree1860 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1860 : H12WitnessSearch.Good tree1860 := H12GlobalWitnessIndex.good

theorem leafIdentity1860 : H12AffineFastState.composeSystem env1860 rootObs = leafEnv1860 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1860 rootObs == leafEnv1860) = true)

theorem terminalChecked1860 : H12PackedTerminal.terminalCheckFast leafEnv1860 active1860 tree1860 = true := by decide +kernel

def env1861 : List Nat := [2,4,8,16,1,64,128,5,137,1024,2048,1045,2057,1092,2048,2186,1092,2048,1024,2048,1045,0,65,138,2176,17,2048,1092,1044,2049,1025,217,4,217,1093,136]

theorem envBound1861 : H12AffineFastState.Bounded env1861 := by
  intro p hp
  have h : env1861.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1857_1861 : H12AffineEnvironment.transform 4 1 env1857 = env1861 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env1857 == env1861) = true)

theorem identity1861 : scanCanonicalize (H12AffineFastState.compose env1861 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 1159) := by decide +kernel

theorem selectedBound1861 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1862 : List Nat := [2,4,8,16,1,64,128,5,137,1024,1159,1045,1166,1092,1159,1037,1092,1159,1024,1159,1045,0,65,138,1031,17,1159,1092,1044,1158,1025,217,4,217,1093,136]

theorem envBound1862 : H12AffineFastState.Bounded env1862 := by
  intro p hp
  have h : env1862.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1861_1862 : H12AffineEnvironment.transform 10 1159 env1861 = env1862 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1159 env1861 == env1862) = true)

theorem identity1862 : scanCanonicalize (H12AffineFastState.compose env1862 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound1862 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1863 : List Nat := [2,4,8,16,1,17,128,5,137,1024,1159,1045,1166,1045,1159,1037,1045,1159,1024,1159,1045,0,16,138,1031,17,1159,1045,1044,1158,1025,136,4,136,1044,136]

theorem envBound1863 : H12AffineFastState.Bounded env1863 := by
  intro p hp
  have h : env1863.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1862_1863 : H12AffineEnvironment.transform 5 17 env1862 = env1863 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env1862 == env1863) = true)

def leafEnv1863 : List Nat := [2,4,8,16,1,17,128,5,137,1024,1159,1045,1166,1045,1159,1037,1045,1159,1024,1159,1045,0,16,138,1024,1031,1,17,1159,1045,1044,1158,1025,136,4,136,4,1156,1044,136,0,1045,1]

def active1863 : List Nat := [0,1,2,3,6,9]

def tree1863 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1863 : H12WitnessSearch.Good tree1863 := H12GlobalWitnessIndex.good

theorem leafIdentity1863 : H12AffineFastState.composeSystem env1863 rootObs = leafEnv1863 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1863 rootObs == leafEnv1863) = true)

theorem terminalChecked1863 : H12PackedTerminal.terminalCheckFast leafEnv1863 active1863 tree1863 = true := by decide +kernel

def env1864 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,32768,65536,131072,262144,524288,32768,524561,4194304,64,753732,533641,16,5111876,1344,656464,4820107,131141,4294967296,525569,4299915503,131073,525825]

theorem envBound1864 : H12AffineFastState.Bounded env1864 := by
  intro p hp
  have h : env1864.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1832_1864 : H12AffineEnvironment.transform 11 1297 env1832 = env1864 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env1832 == env1864) = true)

theorem identity1864 : scanCanonicalize (H12AffineFastState.compose env1864 (packedSelected [3,12,13,15,21,24] rootPS)) = affineNative (2^(18+1) ^^^ 131393) := by decide +kernel

theorem selectedBound1864 : packedSelected [3,12,13,15,21,24] rootPS < 2^1333 := by decide +kernel

def env1865 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,32768,65536,131072,262144,131393,32768,131152,4194304,64,98565,140744,16,4456709,1344,1297,4427210,131141,4294967296,132160,4299260334,131073,132928]

theorem envBound1865 : H12AffineFastState.Bounded env1865 := by
  intro p hp
  have h : env1865.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1864_1865 : H12AffineEnvironment.transform 18 131393 env1864 = env1865 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 131393 env1864 == env1865) = true)

def env1866 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1297,8192,1296,32768,65536,131072,262144,131345,32768,131072,4194304,16,98565,140696,16,4456709,1296,1297,4427162,131093,4294967296,132112,4299260334,131073,132880]

theorem envBound1866 : H12AffineFastState.Bounded env1866 := by
  intro p hp
  have h : env1866.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1865_1866 : H12AffineEnvironment.transform 5 16 env1865 = env1866 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env1865 == env1866) = true)

theorem identity1866 : scanCanonicalize (H12AffineFastState.compose env1866 (packedSelected [1,3,4,5,8,9,13,16,17,21] rootPS)) = affineNative (2^(31+1) ^^^ 393394) := by decide +kernel

theorem selectedBound1866 : packedSelected [1,3,4,5,8,9,13,16,17,21] rootPS < 2^1333 := by decide +kernel

def env1867 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1297,8192,1296,32768,65536,131072,262144,131345,32768,131072,4194304,16,98565,140696,16,4456709,1296,1297,4427162,131093,393394,132112,4686108,131073,132880]

theorem envBound1867 : H12AffineFastState.Bounded env1867 := by
  intro p hp
  have h : env1867.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1866_1867 : H12AffineEnvironment.transform 31 393394 env1866 = env1867 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 393394 env1866 == env1867) = true)

theorem identity1867 : scanCanonicalize (H12AffineFastState.compose env1867 (packedSelected [0,1,3,5,7,8,9,10,13,15,20,22] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound1867 : packedSelected [0,1,3,5,7,8,9,10,13,15,20,22] rootPS < 2^1333 := by decide +kernel

def env1868 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8192,1296,32768,65536,131072,262144,131345,32768,131072,4194304,16,98565,140696,16,4456709,1296,1297,4427162,131093,393394,132112,4686108,131073,132505]

theorem envBound1868 : H12AffineFastState.Bounded env1868 := by
  intro p hp
  have h : env1868.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1867_1868 : H12AffineEnvironment.transform 8 137 env1867 = env1868 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1867 == env1868) = true)

def env1869 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8192,1296,32768,65536,131072,73728,131345,32768,131072,4194304,16,98565,140696,16,4268293,1296,1297,4427162,131093,204978,132112,4366620,131073,132505]

theorem envBound1869 : H12AffineFastState.Bounded env1869 := by
  intro p hp
  have h : env1869.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1868_1869 : H12AffineEnvironment.transform 17 73728 env1868 = env1869 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 73728 env1868 == env1869) = true)

theorem identity1869 : scanCanonicalize (H12AffineFastState.compose env1869 (packedSelected [1,3,4,8,9,12,15,16,17] rootPS)) = affineNative (2^(15+1) ^^^ 9) := by decide +kernel

theorem selectedBound1869 : packedSelected [1,3,4,8,9,12,15,16,17] rootPS < 2^1333 := by decide +kernel

def env1870 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8192,1296,32768,9,131072,8201,131345,32768,131072,4194304,16,33036,140696,16,4202764,1296,1297,4361619,131093,139451,132112,4366620,131073,132505]

theorem envBound1870 : H12AffineFastState.Bounded env1870 := by
  intro p hp
  have h : env1870.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1869_1870 : H12AffineEnvironment.transform 15 9 env1869 = env1870 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 9 env1869 == env1870) = true)

def env1871 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8192,1296,32768,9,1296,8201,1025,32768,1296,4194304,16,33036,8328,16,4202764,1296,1297,4229251,1285,9643,256,4236300,1297,137]

theorem envBound1871 : H12AffineFastState.Bounded env1871 := by
  intro p hp
  have h : env1871.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1870_1871 : H12AffineEnvironment.transform 16 1296 env1870 = env1871 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1296 env1870 == env1871) = true)

theorem identity1871 : scanCanonicalize (H12AffineFastState.compose env1871 (packedSelected [1,3,5] rootPS)) = affineNative (2^(21+1) ^^^ 10400) := by decide +kernel

theorem selectedBound1871 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1872 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8192,1296,32768,9,1296,8201,1025,32768,1296,10400,16,33036,8328,16,2476,1296,1297,40995,1285,9643,256,36012,1297,137]

theorem envBound1872 : H12AffineFastState.Bounded env1872 := by
  intro p hp
  have h : env1872.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1871_1872 : H12AffineEnvironment.transform 21 10400 env1871 = env1872 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10400 env1871 == env1872) = true)

theorem identity1872 : scanCanonicalize (H12AffineFastState.compose env1872 (packedSelected [1,3,8] rootPS)) = affineNative (2^(14+1) ^^^ 10411) := by decide +kernel

theorem selectedBound1872 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env1873 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8192,1296,10411,9,1296,8201,1025,10411,1296,10400,16,10663,8328,16,2476,1296,1297,2184,1285,9643,256,9223,1297,137]

theorem envBound1873 : H12AffineFastState.Bounded env1873 := by
  intro p hp
  have h : env1873.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1872_1873 : H12AffineEnvironment.transform 14 10411 env1872 = env1873 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 10411 env1872 == env1873) = true)

theorem identity1873 : scanCanonicalize (H12AffineFastState.compose env1873 (packedSelected [1,10] rootPS)) = affineNative (2^(12+1) ^^^ 3) := by decide +kernel

theorem selectedBound1873 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env1874 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,3,1296,2216,9,1296,10,1025,2216,1296,2211,16,2468,139,16,2476,1296,1297,2184,1285,1448,256,1028,1297,137]

theorem envBound1874 : H12AffineFastState.Bounded env1874 := by
  intro p hp
  have h : env1874.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1873_1874 : H12AffineEnvironment.transform 12 3 env1873 = env1874 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 3 env1873 == env1874) = true)

theorem identity1874 : scanCanonicalize (H12AffineFastState.compose env1874 (packedSelected [3,12] rootPS)) = affineNative (2^(10+1) ^^^ 423) := by decide +kernel

theorem selectedBound1874 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env1875 : List Nat := [2,4,8,16,32,16,128,256,137,1024,423,1297,3,1296,271,9,1296,10,1025,271,1296,260,16,3,139,16,11,1296,1297,303,1285,1448,256,1028,1297,137]

theorem envBound1875 : H12AffineFastState.Bounded env1875 := by
  intro p hp
  have h : env1875.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1874_1875 : H12AffineEnvironment.transform 10 423 env1874 = env1875 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 423 env1874 == env1875) = true)

theorem identity1875 : scanCanonicalize (H12AffineFastState.compose env1875 (packedSelected [6] rootPS)) = affineNative (2^(9+1) ^^^ 14) := by decide +kernel

theorem selectedBound1875 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1876 : List Nat := [2,4,8,16,32,16,128,256,137,14,423,287,3,286,271,9,286,10,15,271,286,260,16,3,139,16,11,286,287,303,267,422,256,10,287,137]

theorem envBound1876 : H12AffineFastState.Bounded env1876 := by
  intro p hp
  have h : env1876.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1875_1876 : H12AffineEnvironment.transform 9 14 env1875 = env1876 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 14 env1875 == env1876) = true)

theorem identity1876 : scanCanonicalize (H12AffineFastState.compose env1876 (packedSelected [7] rootPS)) = affineNative (2^(6+1) ^^^ 10) := by decide +kernel

theorem selectedBound1876 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1877 : List Nat := [2,4,8,16,32,16,10,256,3,14,301,287,3,286,271,9,286,10,15,271,286,260,16,3,1,16,11,286,287,303,267,300,256,10,287,3]

theorem envBound1877 : H12AffineFastState.Bounded env1877 := by
  intro p hp
  have h : env1877.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1876_1877 : H12AffineEnvironment.transform 6 10 env1876 = env1877 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 10 env1876 == env1877) = true)

theorem identity1877 : scanCanonicalize (H12AffineFastState.compose env1877 (packedSelected [0,2,4,11] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound1877 : packedSelected [0,2,4,11] rootPS < 2^1333 := by decide +kernel

def env1878 : List Nat := [2,4,3,16,32,16,1,256,3,5,294,276,3,277,260,2,277,1,4,260,277,260,16,3,1,16,0,277,276,292,256,295,256,1,276,3]

theorem envBound1878 : H12AffineFastState.Bounded env1878 := by
  intro p hp
  have h : env1878.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1877_1878 : H12AffineEnvironment.transform 2 3 env1877 = env1878 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env1877 == env1878) = true)

theorem identity1878 : scanCanonicalize (H12AffineFastState.compose env1878 (packedSelected [4,9] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound1878 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env1879 : List Nat := [2,4,3,16,32,16,1,37,3,5,3,49,3,48,33,2,48,1,4,33,48,33,16,3,1,16,0,48,49,1,37,2,37,1,49,3]

theorem envBound1879 : H12AffineFastState.Bounded env1879 := by
  intro p hp
  have h : env1879.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1878_1879 : H12AffineEnvironment.transform 7 37 env1878 = env1879 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env1878 == env1879) = true)

theorem identity1879 : scanCanonicalize (H12AffineFastState.compose env1879 (packedSelected [0] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound1879 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1880 : List Nat := [1,4,0,16,32,16,1,37,0,5,0,49,0,48,33,1,48,1,4,33,48,33,16,0,1,16,0,48,49,1,37,1,37,1,49,0]

theorem envBound1880 : H12AffineFastState.Bounded env1880 := by
  intro p hp
  have h : env1880.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1879_1880 : H12AffineEnvironment.transform 0 1 env1879 = env1880 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env1879 == env1880) = true)

def env1881 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8192,1296,32768,9,1297,8201,1024,32768,1297,4194304,16,33036,8329,16,4202764,1296,1297,4229250,1284,9642,257,4236301,1296,136]

theorem envBound1881 : H12AffineFastState.Bounded env1881 := by
  intro p hp
  have h : env1881.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1870_1881 : H12AffineEnvironment.transform 16 1297 env1870 = env1881 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1297 env1870 == env1881) = true)

theorem identity1881 : scanCanonicalize (H12AffineFastState.compose env1881 (packedSelected [1,3,5] rootPS)) = affineNative (2^(21+1) ^^^ 41260) := by decide +kernel

theorem selectedBound1881 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1882 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8192,1296,32768,9,1297,8201,1024,32768,1297,41260,16,33036,8329,16,32800,1296,1297,10670,1284,9642,257,1313,1296,136]

theorem envBound1882 : H12AffineFastState.Bounded env1882 := by
  intro p hp
  have h : env1882.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1881_1882 : H12AffineEnvironment.transform 21 41260 env1881 = env1882 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 41260 env1881 == env1882) = true)

theorem identity1882 : scanCanonicalize (H12AffineFastState.compose env1882 (packedSelected [1,3,8] rootPS)) = affineNative (2^(10+1) ^^^ 423) := by decide +kernel

theorem selectedBound1882 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env1883 : List Nat := [2,4,8,16,32,16,128,256,137,1024,423,1297,8192,1296,32768,9,1297,8201,1024,32768,1297,41260,16,33036,8329,16,32800,1296,1297,8201,1284,9642,257,1313,1296,136]

theorem envBound1883 : H12AffineFastState.Bounded env1883 := by
  intro p hp
  have h : env1883.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1882_1883 : H12AffineEnvironment.transform 10 423 env1882 = env1883 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 423 env1882 == env1883) = true)

theorem identity1883 : scanCanonicalize (H12AffineFastState.compose env1883 (packedSelected [3] rootPS)) = affineNative (2^(9+1) ^^^ 172) := by decide +kernel

theorem selectedBound1883 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1884 : List Nat := [2,4,8,16,32,16,128,256,137,172,423,445,8192,444,32768,9,445,8201,172,32768,445,41260,16,33036,8329,16,32800,444,445,8201,424,8454,257,397,444,136]

theorem envBound1884 : H12AffineFastState.Bounded env1884 := by
  intro p hp
  have h : env1884.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1883_1884 : H12AffineEnvironment.transform 9 172 env1883 = env1884 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 172 env1883 == env1884) = true)

theorem identity1884 : scanCanonicalize (H12AffineFastState.compose env1884 (packedSelected [1,10] rootPS)) = affineNative (2^(12+1) ^^^ 431) := by decide +kernel

theorem selectedBound1884 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env1885 : List Nat := [2,4,8,16,32,16,128,256,137,172,423,445,431,444,32768,9,445,422,172,32768,445,32899,16,33036,294,16,32800,444,445,422,424,169,257,397,444,136]

theorem envBound1885 : H12AffineFastState.Bounded env1885 := by
  intro p hp
  have h : env1885.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1884_1885 : H12AffineEnvironment.transform 12 431 env1884 = env1885 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 431 env1884 == env1885) = true)

theorem identity1885 : scanCanonicalize (H12AffineFastState.compose env1885 (packedSelected [2,4] rootPS)) = affineNative (2^(14+1) ^^^ 131) := by decide +kernel

theorem selectedBound1885 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env1886 : List Nat := [2,4,8,16,32,16,128,256,137,172,423,445,431,444,131,9,445,422,172,131,445,0,16,399,294,16,163,444,445,422,424,169,257,397,444,136]

theorem envBound1886 : H12AffineFastState.Bounded env1886 := by
  intro p hp
  have h : env1886.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1885_1886 : H12AffineEnvironment.transform 14 131 env1885 = env1886 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 131 env1885 == env1886) = true)

theorem identity1886 : scanCanonicalize (H12AffineFastState.compose env1886 (packedSelected [6,7] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1886 : packedSelected [6,7] rootPS < 2^1333 := by decide +kernel

def env1887 : List Nat := [2,4,8,16,32,16,128,5,137,172,162,184,170,185,131,9,184,163,172,131,184,0,16,138,35,16,163,185,184,163,173,169,4,136,185,136]

theorem envBound1887 : H12AffineFastState.Bounded env1887 := by
  intro p hp
  have h : env1887.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1886_1887 : H12AffineEnvironment.transform 7 5 env1886 = env1887 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1886 == env1887) = true)

def env1888 : List Nat := [2,4,8,16,0,16,128,5,137,140,130,152,138,153,131,9,152,131,140,131,152,0,16,138,3,16,131,153,152,131,141,137,4,136,153,136]

theorem envBound1888 : H12AffineFastState.Bounded env1888 := by
  intro p hp
  have h : env1888.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1887_1888 : H12AffineEnvironment.transform 4 0 env1887 = env1888 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1887 == env1888) = true)

theorem identity1888 : scanCanonicalize (H12AffineFastState.compose env1888 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound1888 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1889 : List Nat := [2,4,8,16,0,16,8,5,1,4,10,16,2,17,11,9,16,11,4,11,16,0,16,2,3,16,11,17,16,11,5,1,4,0,17,0]

theorem envBound1889 : H12AffineFastState.Bounded env1889 := by
  intro p hp
  have h : env1889.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1888_1889 : H12AffineEnvironment.transform 6 8 env1888 = env1889 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env1888 == env1889) = true)

def leafEnv1889 : List Nat := [2,4,8,16,0,16,8,5,1,4,10,16,2,17,11,9,16,11,4,11,16,0,16,2,4,3,1,16,11,17,16,11,5,1,4,0,4,8,17,0,0,17,1]

def active1889 : List Nat := [0,1,2,3]

def tree1889 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1889 : H12WitnessSearch.Good tree1889 := H12GlobalWitnessIndex.good

theorem leafIdentity1889 : H12AffineFastState.composeSystem env1889 rootObs = leafEnv1889 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1889 rootObs == leafEnv1889) = true)

theorem terminalChecked1889 : H12PackedTerminal.terminalCheckFast leafEnv1889 active1889 tree1889 = true := by decide +kernel

def env1890 : List Nat := [2,4,8,16,1,16,128,5,137,141,131,153,139,152,131,9,153,130,141,131,153,0,16,138,2,16,130,152,153,130,140,136,4,136,152,136]

theorem envBound1890 : H12AffineFastState.Bounded env1890 := by
  intro p hp
  have h : env1890.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1887_1890 : H12AffineEnvironment.transform 4 1 env1887 = env1890 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env1887 == env1890) = true)

def leafEnv1890 : List Nat := [2,4,8,16,1,16,128,5,137,141,131,153,139,152,131,9,153,130,141,131,153,0,16,138,141,2,1,16,130,152,153,130,140,136,4,136,4,128,152,136,0,152,1]

def active1890 : List Nat := [0,1,2,3,6]

def tree1890 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1890 : H12WitnessSearch.Good tree1890 := H12GlobalWitnessIndex.good

theorem leafIdentity1890 : H12AffineFastState.composeSystem env1890 rootObs = leafEnv1890 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1890 rootObs == leafEnv1890) = true)

theorem terminalChecked1890 : H12PackedTerminal.terminalCheckFast leafEnv1890 active1890 tree1890 = true := by decide +kernel

def env1891 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8192,1296,32768,65536,131072,73729,131345,32768,131072,4194304,16,98565,140696,16,4268292,1296,1297,4427162,131093,204979,132112,4366621,131073,132505]

theorem envBound1891 : H12AffineFastState.Bounded env1891 := by
  intro p hp
  have h : env1891.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1868_1891 : H12AffineEnvironment.transform 17 73729 env1868 = env1891 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 73729 env1868 == env1891) = true)

theorem identity1891 : scanCanonicalize (H12AffineFastState.compose env1891 (packedSelected [1,3,4,8,9,12,15,16,17] rootPS)) = affineNative (2^(16+1) ^^^ 66841) := by decide +kernel

theorem selectedBound1891 : packedSelected [1,3,4,8,9,12,15,16,17] rootPS < 2^1333 := by decide +kernel

def env1892 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8192,1296,32768,65536,66841,73729,66568,32768,66841,4194304,16,98565,73857,16,4268292,1296,1297,4229251,66828,9642,65801,4301828,66840,65664]

theorem envBound1892 : H12AffineFastState.Bounded env1892 := by
  intro p hp
  have h : env1892.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1891_1892 : H12AffineEnvironment.transform 16 66841 env1891 = env1892 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 66841 env1891 == env1892) = true)

def env1893 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8192,1296,32768,8,1297,8201,1024,32768,1297,4194304,16,33037,8329,16,4202764,1296,1297,4229251,1284,9642,257,4236300,1296,136]

theorem envBound1893 : H12AffineFastState.Bounded env1893 := by
  intro p hp
  have h : env1893.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1892_1893 : H12AffineEnvironment.transform 15 8 env1892 = env1893 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8 env1892 == env1893) = true)

theorem identity1893 : scanCanonicalize (H12AffineFastState.compose env1893 (packedSelected [1,3,5] rootPS)) = affineNative (2^(21+1) ^^^ 41260) := by decide +kernel

theorem selectedBound1893 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1894 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8192,1296,32768,8,1297,8201,1024,32768,1297,41260,16,33037,8329,16,32800,1296,1297,10671,1284,9642,257,1312,1296,136]

theorem envBound1894 : H12AffineFastState.Bounded env1894 := by
  intro p hp
  have h : env1894.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1893_1894 : H12AffineEnvironment.transform 21 41260 env1893 = env1894 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 41260 env1893 == env1894) = true)

theorem identity1894 : scanCanonicalize (H12AffineFastState.compose env1894 (packedSelected [1,3,8] rootPS)) = affineNative (2^(10+1) ^^^ 422) := by decide +kernel

theorem selectedBound1894 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env1895 : List Nat := [2,4,8,16,32,16,128,256,137,1024,422,1297,8192,1296,32768,8,1297,8201,1024,32768,1297,41260,16,33037,8329,16,32800,1296,1297,8201,1284,9642,257,1312,1296,136]

theorem envBound1895 : H12AffineFastState.Bounded env1895 := by
  intro p hp
  have h : env1895.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1894_1895 : H12AffineEnvironment.transform 10 422 env1894 = env1895 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 422 env1894 == env1895) = true)

theorem identity1895 : scanCanonicalize (H12AffineFastState.compose env1895 (packedSelected [3] rootPS)) = affineNative (2^(9+1) ^^^ 173) := by decide +kernel

theorem selectedBound1895 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1896 : List Nat := [2,4,8,16,32,16,128,256,137,173,422,444,8192,445,32768,8,444,8201,173,32768,444,41260,16,33037,8329,16,32800,445,444,8201,425,8455,257,397,445,136]

theorem envBound1896 : H12AffineFastState.Bounded env1896 := by
  intro p hp
  have h : env1896.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1895_1896 : H12AffineEnvironment.transform 9 173 env1895 = env1896 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 173 env1895 == env1896) = true)

theorem identity1896 : scanCanonicalize (H12AffineFastState.compose env1896 (packedSelected [1,10] rootPS)) = affineNative (2^(12+1) ^^^ 430) := by decide +kernel

theorem selectedBound1896 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env1897 : List Nat := [2,4,8,16,32,16,128,256,137,173,422,444,430,445,32768,8,444,423,173,32768,444,32898,16,33037,295,16,32800,445,444,423,425,169,257,397,445,136]

theorem envBound1897 : H12AffineFastState.Bounded env1897 := by
  intro p hp
  have h : env1897.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1896_1897 : H12AffineEnvironment.transform 12 430 env1896 = env1897 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 430 env1896 == env1897) = true)

theorem identity1897 : scanCanonicalize (H12AffineFastState.compose env1897 (packedSelected [2,4] rootPS)) = affineNative (2^(14+1) ^^^ 130) := by decide +kernel

theorem selectedBound1897 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env1898 : List Nat := [2,4,8,16,32,16,128,256,137,173,422,444,430,445,130,8,444,423,173,130,444,0,16,399,295,16,162,445,444,423,425,169,257,397,445,136]

theorem envBound1898 : H12AffineFastState.Bounded env1898 := by
  intro p hp
  have h : env1898.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1897_1898 : H12AffineEnvironment.transform 14 130 env1897 = env1898 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 130 env1897 == env1898) = true)

theorem identity1898 : scanCanonicalize (H12AffineFastState.compose env1898 (packedSelected [6,7] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1898 : packedSelected [6,7] rootPS < 2^1333 := by decide +kernel

def env1899 : List Nat := [2,4,8,16,32,16,128,5,137,173,163,185,171,184,130,8,185,162,173,130,185,0,16,138,34,16,162,184,185,162,172,169,4,136,184,136]

theorem envBound1899 : H12AffineFastState.Bounded env1899 := by
  intro p hp
  have h : env1899.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1898_1899 : H12AffineEnvironment.transform 7 5 env1898 = env1899 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1898 == env1899) = true)

def env1900 : List Nat := [2,4,8,16,0,16,128,5,137,141,131,153,139,152,130,8,153,130,141,130,153,0,16,138,2,16,130,152,153,130,140,137,4,136,152,136]

theorem envBound1900 : H12AffineFastState.Bounded env1900 := by
  intro p hp
  have h : env1900.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1899_1900 : H12AffineEnvironment.transform 4 0 env1899 = env1900 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1899 == env1900) = true)

theorem identity1900 : scanCanonicalize (H12AffineFastState.compose env1900 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound1900 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1901 : List Nat := [2,4,8,16,0,16,8,5,1,5,11,17,3,16,10,8,17,10,5,10,17,0,16,2,2,16,10,16,17,10,4,1,4,0,16,0]

theorem envBound1901 : H12AffineFastState.Bounded env1901 := by
  intro p hp
  have h : env1901.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1900_1901 : H12AffineEnvironment.transform 6 8 env1900 = env1901 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env1900 == env1901) = true)

def leafEnv1901 : List Nat := [2,4,8,16,0,16,8,5,1,5,11,17,3,16,10,8,17,10,5,10,17,0,16,2,5,2,1,16,10,16,17,10,4,1,4,0,4,9,16,0,0,16,1]

def active1901 : List Nat := [0,1,2,3]

def tree1901 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1901 : H12WitnessSearch.Good tree1901 := H12GlobalWitnessIndex.good

theorem leafIdentity1901 : H12AffineFastState.composeSystem env1901 rootObs = leafEnv1901 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1901 rootObs == leafEnv1901) = true)

theorem terminalChecked1901 : H12PackedTerminal.terminalCheckFast leafEnv1901 active1901 tree1901 = true := by decide +kernel

def env1902 : List Nat := [2,4,8,16,1,16,128,5,137,140,130,152,138,153,130,8,152,131,140,130,152,0,16,138,3,16,131,153,152,131,141,136,4,136,153,136]

theorem envBound1902 : H12AffineFastState.Bounded env1902 := by
  intro p hp
  have h : env1902.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1899_1902 : H12AffineEnvironment.transform 4 1 env1899 = env1902 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env1899 == env1902) = true)

def leafEnv1902 : List Nat := [2,4,8,16,1,16,128,5,137,140,130,152,138,153,130,8,152,131,140,130,152,0,16,138,140,3,1,16,131,153,152,131,141,136,4,136,4,129,153,136,0,153,1]

def active1902 : List Nat := [0,1,2,3,6]

def tree1902 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1902 : H12WitnessSearch.Good tree1902 := H12GlobalWitnessIndex.good

theorem leafIdentity1902 : H12AffineFastState.composeSystem env1902 rootObs = leafEnv1902 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1902 rootObs == leafEnv1902) = true)

theorem terminalChecked1902 : H12PackedTerminal.terminalCheckFast leafEnv1902 active1902 tree1902 = true := by decide +kernel

def env1903 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8192,1296,32768,9,1296,8200,1025,32768,1296,4194304,16,33036,8328,16,4202765,1296,1297,4229251,1285,9642,256,4236301,1297,137]

theorem envBound1903 : H12AffineFastState.Bounded env1903 := by
  intro p hp
  have h : env1903.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1892_1903 : H12AffineEnvironment.transform 15 9 env1892 = env1903 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 9 env1892 == env1903) = true)

theorem identity1903 : scanCanonicalize (H12AffineFastState.compose env1903 (packedSelected [1,3,5] rootPS)) = affineNative (2^(21+1) ^^^ 10401) := by decide +kernel

theorem selectedBound1903 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1904 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8192,1296,32768,9,1296,8200,1025,32768,1296,10401,16,33036,8328,16,2476,1296,1297,40994,1285,9642,256,36012,1297,137]

theorem envBound1904 : H12AffineFastState.Bounded env1904 := by
  intro p hp
  have h : env1904.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1903_1904 : H12AffineEnvironment.transform 21 10401 env1903 = env1904 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10401 env1903 == env1904) = true)

theorem identity1904 : scanCanonicalize (H12AffineFastState.compose env1904 (packedSelected [1,3,8] rootPS)) = affineNative (2^(14+1) ^^^ 10410) := by decide +kernel

theorem selectedBound1904 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env1905 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8192,1296,10410,9,1296,8200,1025,10410,1296,10401,16,10662,8328,16,2476,1296,1297,2184,1285,9642,256,9222,1297,137]

theorem envBound1905 : H12AffineFastState.Bounded env1905 := by
  intro p hp
  have h : env1905.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1904_1905 : H12AffineEnvironment.transform 14 10410 env1904 = env1905 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 10410 env1904 == env1905) = true)

theorem identity1905 : scanCanonicalize (H12AffineFastState.compose env1905 (packedSelected [1,10] rootPS)) = affineNative (2^(12+1) ^^^ 2) := by decide +kernel

theorem selectedBound1905 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env1906 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,2,1296,2216,9,1296,10,1025,2216,1296,2211,16,2468,138,16,2476,1296,1297,2184,1285,1448,256,1028,1297,137]

theorem envBound1906 : H12AffineFastState.Bounded env1906 := by
  intro p hp
  have h : env1906.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1905_1906 : H12AffineEnvironment.transform 12 2 env1905 = env1906 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2 env1905 == env1906) = true)

theorem identity1906 : scanCanonicalize (H12AffineFastState.compose env1906 (packedSelected [3,12] rootPS)) = affineNative (2^(10+1) ^^^ 422) := by decide +kernel

theorem selectedBound1906 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env1907 : List Nat := [2,4,8,16,32,16,128,256,137,1024,422,1297,2,1296,270,9,1296,10,1025,270,1296,261,16,2,138,16,10,1296,1297,302,1285,1448,256,1028,1297,137]

theorem envBound1907 : H12AffineFastState.Bounded env1907 := by
  intro p hp
  have h : env1907.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1906_1907 : H12AffineEnvironment.transform 10 422 env1906 = env1907 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 422 env1906 == env1907) = true)

theorem identity1907 : scanCanonicalize (H12AffineFastState.compose env1907 (packedSelected [6] rootPS)) = affineNative (2^(9+1) ^^^ 15) := by decide +kernel

theorem selectedBound1907 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1908 : List Nat := [2,4,8,16,32,16,128,256,137,15,422,286,2,287,270,9,287,10,14,270,287,261,16,2,138,16,10,287,286,302,266,423,256,11,286,137]

theorem envBound1908 : H12AffineFastState.Bounded env1908 := by
  intro p hp
  have h : env1908.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1907_1908 : H12AffineEnvironment.transform 9 15 env1907 = env1908 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 15 env1907 == env1908) = true)

theorem identity1908 : scanCanonicalize (H12AffineFastState.compose env1908 (packedSelected [7] rootPS)) = affineNative (2^(7+1) ^^^ 142) := by decide +kernel

theorem selectedBound1908 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1909 : List Nat := [2,4,8,16,32,16,128,142,137,15,40,144,2,145,128,9,145,10,14,128,145,139,16,2,138,16,10,145,144,160,132,41,142,11,144,137]

theorem envBound1909 : H12AffineFastState.Bounded env1909 := by
  intro p hp
  have h : env1909.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1908_1909 : H12AffineEnvironment.transform 7 142 env1908 = env1909 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 142 env1908 == env1909) = true)

theorem identity1909 : scanCanonicalize (H12AffineFastState.compose env1909 (packedSelected [0,2,4,11] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound1909 : packedSelected [0,2,4,11] rootPS < 2^1333 := by decide +kernel

def env1910 : List Nat := [2,4,8,16,32,16,2,12,11,15,40,18,2,19,2,9,19,10,14,2,19,9,16,2,8,16,10,19,18,34,6,41,12,11,18,11]

theorem envBound1910 : H12AffineFastState.Bounded env1910 := by
  intro p hp
  have h : env1910.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1909_1910 : H12AffineEnvironment.transform 6 2 env1909 = env1910 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env1909 == env1910) = true)

def env1911 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,8192,1297,32768,65536,131072,262144,131344,32768,131073,4194304,17,98565,140697,16,4456709,1297,1297,4427163,131092,4294967296,132113,4299260334,131073,132881]

theorem envBound1911 : H12AffineFastState.Bounded env1911 := by
  intro p hp
  have h : env1911.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1865_1911 : H12AffineEnvironment.transform 5 17 env1865 = env1911 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env1865 == env1911) = true)

theorem identity1911 : scanCanonicalize (H12AffineFastState.compose env1911 (packedSelected [1,3,4,5,8,9,13,16,17,21] rootPS)) = affineNative (2^(31+1) ^^^ 434623) := by decide +kernel

theorem selectedBound1911 : packedSelected [1,3,4,5,8,9,13,16,17,21] rootPS < 2^1333 := by decide +kernel

def env1912 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,8192,1297,32768,65536,131072,262144,131344,32768,131073,4194304,17,98565,140697,16,4456709,1297,1297,4427163,131092,434623,132113,4661265,131073,132881]

theorem envBound1912 : H12AffineFastState.Bounded env1912 := by
  intro p hp
  have h : env1912.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1911_1912 : H12AffineEnvironment.transform 31 434623 env1911 = env1912 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 434623 env1911 == env1912) = true)

theorem identity1912 : scanCanonicalize (H12AffineFastState.compose env1912 (packedSelected [0,1,3,5,7,8,9,10,13,15,20,22] rootPS)) = affineNative (2^(16+1) ^^^ 1945) := by decide +kernel

theorem selectedBound1912 : packedSelected [0,1,3,5,7,8,9,10,13,15,20,22] rootPS < 2^1333 := by decide +kernel

def env1913 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,8192,1297,32768,65536,1945,262144,1673,32768,1944,4194304,17,98565,8704,16,4456709,1297,1297,4295170,1933,304678,904,4532104,1944,136]

theorem envBound1913 : H12AffineFastState.Bounded env1913 := by
  intro p hp
  have h : env1913.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1912_1913 : H12AffineEnvironment.transform 16 1945 env1912 = env1913 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1945 env1912 == env1913) = true)

def env1914 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,8192,1297,32768,65536,1945,73728,1673,32768,1944,4194304,17,98565,8704,16,4268293,1297,1297,4295170,1933,99878,904,4196232,1944,136]

theorem envBound1914 : H12AffineFastState.Bounded env1914 := by
  intro p hp
  have h : env1914.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1913_1914 : H12AffineEnvironment.transform 17 73728 env1913 = env1914 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 73728 env1913 == env1914) = true)

theorem identity1914 : scanCanonicalize (H12AffineFastState.compose env1914 (packedSelected [1,3,4,8,9,12,15,16,17] rootPS)) = affineNative (2^(15+1) ^^^ 640) := by decide +kernel

theorem selectedBound1914 : packedSelected [1,3,4,8,9,12,15,16,17] rootPS < 2^1333 := by decide +kernel

def env1915 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,8192,1297,32768,640,1945,8832,1673,32768,1944,4194304,17,33669,8704,16,4203397,1297,1297,4229250,1933,33958,904,4196232,1944,136]

theorem envBound1915 : H12AffineFastState.Bounded env1915 := by
  intro p hp
  have h : env1915.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1914_1915 : H12AffineEnvironment.transform 15 640 env1914 = env1915 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 640 env1914 == env1915) = true)

def env1916 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,8192,1297,32768,8,1297,8200,1025,32768,1296,4194304,17,33037,8328,16,4202765,1297,1297,4229250,1285,33958,256,4195584,1296,136]

theorem envBound1916 : H12AffineFastState.Bounded env1916 := by
  intro p hp
  have h : env1916.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1915_1916 : H12AffineEnvironment.transform 8 136 env1915 = env1916 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1915 == env1916) = true)

theorem identity1916 : scanCanonicalize (H12AffineFastState.compose env1916 (packedSelected [1,3,5] rootPS)) = affineNative (2^(21+1) ^^^ 10401) := by decide +kernel

theorem selectedBound1916 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1917 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,8192,1297,32768,8,1297,8200,1025,32768,1296,10401,17,33037,8328,16,2476,1297,1297,40995,1285,33958,256,11681,1296,136]

theorem envBound1917 : H12AffineFastState.Bounded env1917 := by
  intro p hp
  have h : env1917.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1916_1917 : H12AffineEnvironment.transform 21 10401 env1916 = env1917 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10401 env1916 == env1917) = true)

theorem identity1917 : scanCanonicalize (H12AffineFastState.compose env1917 (packedSelected [1,3,8] rootPS)) = affineNative (2^(14+1) ^^^ 10411) := by decide +kernel

theorem selectedBound1917 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env1918 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,8192,1297,10411,8,1297,8200,1025,10411,1296,10401,17,10662,8328,16,2476,1297,1297,2184,1285,11277,256,11681,1296,136]

theorem envBound1918 : H12AffineFastState.Bounded env1918 := by
  intro p hp
  have h : env1918.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1917_1918 : H12AffineEnvironment.transform 14 10411 env1917 = env1918 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 10411 env1917 == env1918) = true)

theorem identity1918 : scanCanonicalize (H12AffineFastState.compose env1918 (packedSelected [1,10] rootPS)) = affineNative (2^(12+1) ^^^ 2469) := by decide +kernel

theorem selectedBound1918 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env1919 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,2469,1297,270,8,1297,2477,1025,270,1296,260,17,3,2349,16,2476,1297,1297,2184,1285,1448,256,1028,1296,136]

theorem envBound1919 : H12AffineFastState.Bounded env1919 := by
  intro p hp
  have h : env1919.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1918_1919 : H12AffineEnvironment.transform 12 2469 env1918 = env1919 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2469 env1918 == env1919) = true)

theorem identity1919 : scanCanonicalize (H12AffineFastState.compose env1919 (packedSelected [6,7] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound1919 : packedSelected [6,7] rootPS < 2^1333 := by decide +kernel

def env1920 : List Nat := [1,4,8,16,32,17,128,256,136,1024,2048,1297,2469,1297,269,8,1297,2477,1025,269,1296,260,17,0,2349,16,2476,1297,1297,2184,1285,1448,256,1028,1296,136]

theorem envBound1920 : H12AffineFastState.Bounded env1920 := by
  intro p hp
  have h : env1920.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1919_1920 : H12AffineEnvironment.transform 0 1 env1919 = env1920 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env1919 == env1920) = true)

theorem identity1920 : scanCanonicalize (H12AffineFastState.compose env1920 (packedSelected [3,12] rootPS)) = affineNative (2^(10+1) ^^^ 420) := by decide +kernel

theorem selectedBound1920 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env1921 : List Nat := [1,4,8,16,32,17,128,256,136,1024,420,1297,1,1297,269,8,1297,9,1025,269,1296,260,17,0,137,16,8,1297,1297,300,1285,1448,256,1028,1296,136]

theorem envBound1921 : H12AffineFastState.Bounded env1921 := by
  intro p hp
  have h : env1921.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1920_1921 : H12AffineEnvironment.transform 10 420 env1920 = env1921 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 420 env1920 == env1921) = true)

theorem identity1921 : scanCanonicalize (H12AffineFastState.compose env1921 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound1921 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1922 : List Nat := [1,4,8,16,32,17,9,256,1,1024,301,1297,1,1297,269,8,1297,9,1025,269,1296,260,17,0,0,16,8,1297,1297,300,1285,1313,256,1028,1296,1]

theorem envBound1922 : H12AffineFastState.Bounded env1922 := by
  intro p hp
  have h : env1922.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1921_1922 : H12AffineEnvironment.transform 6 9 env1921 = env1922 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env1921 == env1922) = true)

theorem identity1922 : scanCanonicalize (H12AffineFastState.compose env1922 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 289) := by decide +kernel

theorem selectedBound1922 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1923 : List Nat := [1,4,8,16,32,17,9,256,1,289,301,48,1,48,269,8,48,9,288,269,49,260,17,0,0,16,8,48,48,300,36,0,256,293,49,1]

theorem envBound1923 : H12AffineFastState.Bounded env1923 := by
  intro p hp
  have h : env1923.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1922_1923 : H12AffineEnvironment.transform 9 289 env1922 = env1923 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 289 env1922 == env1923) = true)

theorem identity1923 : scanCanonicalize (H12AffineFastState.compose env1923 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound1923 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1924 : List Nat := [1,4,8,16,32,17,9,36,1,5,9,48,1,48,41,8,48,9,4,41,49,32,17,0,0,16,8,48,48,8,36,0,36,1,49,1]

theorem envBound1924 : H12AffineFastState.Bounded env1924 := by
  intro p hp
  have h : env1924.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1923_1924 : H12AffineEnvironment.transform 7 36 env1923 = env1924 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env1923 == env1924) = true)

def env1925 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8192,1297,32768,9,1296,8201,1024,32768,1297,4194304,17,33036,8329,16,4202764,1297,1297,4229250,1284,33958,257,4195585,1297,136]

theorem envBound1925 : H12AffineFastState.Bounded env1925 := by
  intro p hp
  have h : env1925.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1915_1925 : H12AffineEnvironment.transform 8 137 env1915 = env1925 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1915 == env1925) = true)

theorem identity1925 : scanCanonicalize (H12AffineFastState.compose env1925 (packedSelected [1,3,5] rootPS)) = affineNative (2^(21+1) ^^^ 41260) := by decide +kernel

theorem selectedBound1925 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1926 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8192,1297,32768,9,1296,8201,1024,32768,1297,41260,17,33036,8329,16,32800,1297,1297,10670,1284,33958,257,42029,1297,136]

theorem envBound1926 : H12AffineFastState.Bounded env1926 := by
  intro p hp
  have h : env1926.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

end H12GlobalChart2
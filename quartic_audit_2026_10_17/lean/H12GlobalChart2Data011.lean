import H12GlobalChart2Data010

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem selectedBound2656 : packedSelected [1,5] rootPS < 2^1333 := by decide +kernel

def env2657 : List Nat := [2,4,8,16,32,64,26,54,42,102,32,65,8,16,50,16,16,50,102,50,64,32,64,16,26,16,32,16,65,50,84,80,54,80,16,42]

theorem envBound2657 : H12AffineFastState.Bounded env2657 := by
  intro p hp
  have h : env2657.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2656_2657 : H12AffineEnvironment.transform 6 26 env2656 = env2657 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 26 env2656 == env2657) = true)

theorem identity2657 : scanCanonicalize (H12AffineFastState.compose env2657 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 8) := by decide +kernel

theorem selectedBound2657 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2658 : List Nat := [2,4,8,8,32,64,2,46,42,102,32,65,8,8,42,8,8,42,102,42,64,32,64,8,2,8,32,8,65,42,76,72,46,72,8,42]

theorem envBound2658 : H12AffineFastState.Bounded env2658 := by
  intro p hp
  have h : env2658.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2657_2658 : H12AffineEnvironment.transform 3 8 env2657 = env2658 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 8 env2657 == env2658) = true)

theorem identity2658 : scanCanonicalize (H12AffineFastState.compose env2658 (packedSelected [7] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound2658 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env2659 : List Nat := [2,4,2,2,32,64,2,36,32,102,32,65,2,2,32,2,2,32,102,32,64,32,64,2,2,2,32,2,65,32,70,66,36,66,2,32]

theorem envBound2659 : H12AffineFastState.Bounded env2659 := by
  intro p hp
  have h : env2659.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2658_2659 : H12AffineEnvironment.transform 2 2 env2658 = env2659 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env2658 == env2659) = true)

theorem identity2659 : scanCanonicalize (H12AffineFastState.compose env2659 (packedSelected [13] rootPS)) = affineNative (2^(5+1) ^^^ 3) := by decide +kernel

theorem selectedBound2659 : packedSelected [13] rootPS < 2^1333 := by decide +kernel

def env2660 : List Nat := [2,4,2,2,32,3,2,36,32,37,32,2,2,2,32,2,2,32,37,32,3,32,3,2,2,2,32,2,2,32,5,1,36,1,2,32]

theorem envBound2660 : H12AffineFastState.Bounded env2660 := by
  intro p hp
  have h : env2660.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2659_2660 : H12AffineEnvironment.transform 5 3 env2659 = env2660 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 3 env2659 == env2660) = true)

def leafEnv2660 : List Nat := [2,4,2,2,32,3,2,36,32,37,32,2,2,2,32,2,2,32,37,32,3,32,3,2,5,2,1,2,32,2,2,32,5,1,36,1,4,2,2,32,0,3,1]

def active2660 : List Nat := [0,1,4]

def tree2660 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2660 : H12WitnessSearch.Good tree2660 := H12GlobalWitnessIndex.good

theorem leafIdentity2660 : H12AffineFastState.composeSystem env2660 rootObs = leafEnv2660 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2660 rootObs == leafEnv2660) = true)

theorem terminalChecked2660 : H12PackedTerminal.terminalCheckFast leafEnv2660 active2660 tree2660 = true := by decide +kernel

def env2661 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,10248,17664,230468,8329,67108864,67528988,67130625,67245392,1073741824,67245381,4294967296,67113985,4362857911,131072,513]

theorem envBound2661 : H12AffineFastState.Bounded env2661 := by
  intro p hp
  have h : env2661.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2640_2661 : H12AffineEnvironment.transform 24 8329 env2640 = env2661 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env2640 == env2661) = true)

def env2662 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,10248,5456,230468,8329,67108864,67516748,67110225,67245392,1073741824,67245381,4294967296,67113985,4362845671,131072,513]

theorem envBound2662 : H12AffineFastState.Bounded env2662 := by
  intro p hp
  have h : env2662.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2661_2662 : H12AffineEnvironment.transform 13 4176 env2661 = env2662 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env2661 == env2662) = true)

theorem identity2662 : scanCanonicalize (H12AffineFastState.compose env2662 (packedSelected [0,4,7,16,20,22] rootPS)) = affineNative (2^(29+1) ^^^ 67744131) := by decide +kernel

theorem selectedBound2662 : packedSelected [0,4,7,16,20,22] rootPS < 2^1333 := by decide +kernel

def env2663 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,10248,5456,230468,8329,67108864,67516748,67110225,67245392,67744131,67245381,4294967296,67113985,4362845671,131072,513]

theorem envBound2663 : H12AffineFastState.Bounded env2663 := by
  intro p hp
  have h : env2663.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2662_2663 : H12AffineEnvironment.transform 29 67744131 env2662 = env2663 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 67744131 env2662 == env2663) = true)

def env2664 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,8200,5456,230468,8329,67108864,67514700,67110225,67245392,67744131,67245381,4294967296,67113985,4362843623,131072,513]

theorem envBound2664 : H12AffineFastState.Bounded env2664 := by
  intro p hp
  have h : env2664.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2663_2664 : H12AffineEnvironment.transform 10 0 env2663 = env2664 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env2663 == env2664) = true)

def env2665 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,8200,5456,230468,8329,5376,402508,4177,131152,631939,131141,4294967296,257,4295729383,131072,513]

theorem envBound2665 : H12AffineFastState.Bounded env2665 := by
  intro p hp
  have h : env2665.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2664_2665 : H12AffineEnvironment.transform 25 5376 env2664 = env2665 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env2664 == env2665) = true)

theorem identity2665 : scanCanonicalize (H12AffineFastState.compose env2665 (packedSelected [11] rootPS)) = affineNative (2^(18+1) ^^^ 463666) := by decide +kernel

theorem selectedBound2665 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env2666 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,131072,262144,463666,32768,4097,8200,5456,230468,8329,5376,402508,4177,131152,440241,131141,4294967296,257,4295275477,131072,513]

theorem envBound2666 : H12AffineFastState.Bounded env2666 := by
  intro p hp
  have h : env2666.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2665_2666 : H12AffineEnvironment.transform 18 463666 env2665 = env2666 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 463666 env2665 == env2666) = true)

theorem identity2666 : scanCanonicalize (H12AffineFastState.compose env2666 (packedSelected [6,25] rootPS)) = affineNative (2^(17+1) ^^^ 202546) := by decide +kernel

theorem selectedBound2666 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env2667 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,131072,202546,1024,32768,4097,8200,5456,230468,8329,5376,78718,4177,131152,106627,131141,4294967296,257,4295206119,131072,513]

theorem envBound2667 : H12AffineFastState.Bounded env2667 := by
  intro p hp
  have h : env2667.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2666_2667 : H12AffineEnvironment.transform 17 202546 env2666 = env2667 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 202546 env2666 == env2667) = true)

def env2668 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,8200,5456,230468,8329,5377,402509,4176,131153,631938,131140,4294967296,256,4295729382,131072,513]

theorem envBound2668 : H12AffineFastState.Bounded env2668 := by
  intro p hp
  have h : env2668.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2664_2668 : H12AffineEnvironment.transform 25 5377 env2664 = env2668 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env2664 == env2668) = true)

theorem identity2668 : scanCanonicalize (H12AffineFastState.compose env2668 (packedSelected [11] rootPS)) = affineNative (2^(18+1) ^^^ 329251) := by decide +kernel

theorem selectedBound2668 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env2669 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,131072,262144,329251,32768,4097,8200,5456,230468,8329,5377,402509,4176,131153,303777,131140,4294967296,256,4295403205,131072,513]

theorem envBound2669 : H12AffineFastState.Bounded env2669 := by
  intro p hp
  have h : env2669.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2668_2669 : H12AffineEnvironment.transform 18 329251 env2668 = env2669 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 329251 env2668 == env2669) = true)

def env2670 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,131072,41000,108043,32768,4097,8200,5456,230468,8329,5377,164965,4176,131153,649,131140,4294967296,256,4295100141,131072,513]

theorem envBound2670 : H12AffineFastState.Bounded env2670 := by
  intro p hp
  have h : env2670.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2669_2670 : H12AffineEnvironment.transform 17 41000 env2669 = env2670 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41000 env2669 == env2670) = true)

theorem identity2670 : scanCanonicalize (H12AffineFastState.compose env2670 (packedSelected [16,18] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound2670 : packedSelected [16,18] rootPS < 2^1333 := by decide +kernel

def env2671 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,8192,4176,32768,65536,131072,41000,107651,32768,4097,8200,5456,230468,8329,5377,164965,4176,131153,1,131140,4294967296,256,4295099493,131072,137]

theorem envBound2671 : H12AffineFastState.Bounded env2671 := by
  intro p hp
  have h : env2671.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2670_2671 : H12AffineEnvironment.transform 8 136 env2670 = env2671 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env2670 == env2671) = true)

theorem identity2671 : scanCanonicalize (H12AffineFastState.compose env2671 (packedSelected [0,2,6,9,16] rootPS)) = affineNative (2^(16+1) ^^^ 99535) := by decide +kernel

theorem selectedBound2671 : packedSelected [0,2,6,9,16] rootPS < 2^1333 := by decide +kernel

def env2672 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,8192,4176,32768,65536,99535,41000,107651,32768,4097,8200,5456,139,8329,5377,65706,4176,99486,1,99467,4294967296,256,4295065770,99535,137]

theorem envBound2672 : H12AffineFastState.Bounded env2672 := by
  intro p hp
  have h : env2672.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2671_2672 : H12AffineEnvironment.transform 16 99535 env2671 = env2672 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 99535 env2671 == env2672) = true)

theorem identity2672 : scanCanonicalize (H12AffineFastState.compose env2672 (packedSelected [5,8,10,12,17] rootPS)) = affineNative (2^(12+1) ^^^ 5148) := by decide +kernel

theorem selectedBound2672 : packedSelected [5,8,10,12,17] rootPS < 2^1333 := by decide +kernel

def env2673 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,5148,4176,32768,65536,99535,37940,102559,32768,4097,5140,5456,139,5269,5377,65706,4176,99486,1,99467,4294967296,256,4295065770,99535,137]

theorem envBound2673 : H12AffineFastState.Bounded env2673 := by
  intro p hp
  have h : env2673.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2672_2673 : H12AffineEnvironment.transform 12 5148 env2672 = env2673 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5148 env2672 == env2673) = true)

theorem identity2673 : scanCanonicalize (H12AffineFastState.compose env2673 (packedSelected [4,9] rootPS)) = affineNative (2^(15+1) ^^^ 38046) := by decide +kernel

theorem selectedBound2673 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env2674 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,5148,4176,32768,38046,4177,37940,1025,32768,4097,5140,5456,139,5269,5377,37940,4176,4096,1,4117,4294967296,256,4294972468,4177,137]

theorem envBound2674 : H12AffineFastState.Bounded env2674 := by
  intro p hp
  have h : env2674.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2673_2674 : H12AffineEnvironment.transform 15 38046 env2673 = env2674 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 38046 env2673 == env2674) = true)

theorem identity2674 : scanCanonicalize (H12AffineFastState.compose env2674 (packedSelected [0,7] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound2674 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env2675 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,1297,269,1345,32768,33167,1344,33061,1025,32768,1296,261,65,139,388,16,33061,1345,1297,1,1284,4294967296,256,4294967589,1344,137]

theorem envBound2675 : H12AffineFastState.Bounded env2675 := by
  intro p hp
  have h : env2675.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2674_2675 : H12AffineEnvironment.transform 11 1297 env2674 = env2675 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env2674 == env2675) = true)

theorem identity2675 : scanCanonicalize (H12AffineFastState.compose env2675 (packedSelected [1,3] rootPS)) = affineNative (2^(14+1) ^^^ 373) := by decide +kernel

theorem selectedBound2675 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env2676 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,1297,269,1345,373,250,1344,80,1025,373,1296,261,65,139,388,16,80,1345,1297,1,1284,4294967296,256,4294967589,1344,137]

theorem envBound2676 : H12AffineFastState.Bounded env2676 := by
  intro p hp
  have h : env2676.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2675_2676 : H12AffineEnvironment.transform 14 373 env2675 = env2676 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 373 env2675 == env2676) = true)

theorem identity2676 : scanCanonicalize (H12AffineFastState.compose env2676 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 21) := by decide +kernel

theorem selectedBound2676 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env2677 : List Nat := [2,4,8,16,32,64,128,21,136,1024,0,1028,24,1108,96,250,1109,80,1025,96,1029,16,65,139,145,16,80,1108,1028,1,1041,4294967296,21,4294967344,1109,137]

theorem envBound2677 : H12AffineFastState.Bounded env2677 := by
  intro p hp
  have h : env2677.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2676_2677 : H12AffineEnvironment.transform 7 21 env2676 = env2677 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 21 env2676 == env2677) = true)

theorem identity2677 : scanCanonicalize (H12AffineFastState.compose env2677 (packedSelected [5] rootPS)) = affineNative (2^(6+1) ^^^ 35) := by decide +kernel

theorem selectedBound2677 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env2678 : List Nat := [2,4,8,16,32,64,35,21,43,1024,0,1028,24,1108,96,89,1109,80,1025,96,1029,16,65,40,50,16,80,1108,1028,1,1041,4294967296,21,4294967344,1109,42]

theorem envBound2678 : H12AffineFastState.Bounded env2678 := by
  intro p hp
  have h : env2678.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2677_2678 : H12AffineEnvironment.transform 6 35 env2677 = env2678 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 35 env2677 == env2678) = true)

theorem identity2678 : scanCanonicalize (H12AffineFastState.compose env2678 (packedSelected [8] rootPS)) = affineNative (2^(5+1) ^^^ 32) := by decide +kernel

theorem selectedBound2678 : packedSelected [8] rootPS < 2^1333 := by decide +kernel

def env2679 : List Nat := [2,4,8,16,32,32,35,21,43,1024,0,1028,24,1076,0,57,1077,48,1025,0,1029,16,33,40,50,16,48,1076,1028,1,1041,4294967296,21,4294967344,1077,42]

theorem envBound2679 : H12AffineFastState.Bounded env2679 := by
  intro p hp
  have h : env2679.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2678_2679 : H12AffineEnvironment.transform 5 32 env2678 = env2679 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 32 env2678 == env2679) = true)

theorem identity2679 : scanCanonicalize (H12AffineFastState.compose env2679 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 27) := by decide +kernel

theorem selectedBound2679 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2680 : List Nat := [2,4,8,16,32,32,35,21,43,1024,0,1028,24,1076,0,57,1077,48,1025,0,1029,16,33,40,50,16,48,1076,1028,1,1041,27,21,43,1077,42]

theorem envBound2680 : H12AffineFastState.Bounded env2680 := by
  intro p hp
  have h : env2680.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2679_2680 : H12AffineEnvironment.transform 31 27 env2679 = env2680 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 27 env2679 == env2680) = true)

theorem identity2680 : scanCanonicalize (H12AffineFastState.compose env2680 (packedSelected [1] rootPS)) = affineNative (2^(9+1) ^^^ 52) := by decide +kernel

theorem selectedBound2680 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2681 : List Nat := [2,4,8,16,32,32,35,21,43,52,0,48,24,0,0,57,1,48,53,0,49,16,33,40,50,16,48,0,48,1,37,27,21,43,1,42]

theorem envBound2681 : H12AffineFastState.Bounded env2681 := by
  intro p hp
  have h : env2681.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2680_2681 : H12AffineEnvironment.transform 9 52 env2680 = env2681 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 52 env2680 == env2681) = true)

theorem identity2681 : scanCanonicalize (H12AffineFastState.compose env2681 (packedSelected [10] rootPS)) = affineNative (2^(4+1) ^^^ 17) := by decide +kernel

theorem selectedBound2681 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env2682 : List Nat := [2,4,8,16,17,17,18,21,26,5,0,1,24,0,0,8,1,1,4,0,0,16,16,25,3,16,1,0,1,1,20,27,21,26,1,27]

theorem envBound2682 : H12AffineFastState.Bounded env2682 := by
  intro p hp
  have h : env2682.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2681_2682 : H12AffineEnvironment.transform 4 17 env2681 = env2682 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env2681 == env2682) = true)

theorem identity2682 : scanCanonicalize (H12AffineFastState.compose env2682 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound2682 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2683 : List Nat := [2,4,8,1,0,0,3,4,11,5,0,1,9,0,0,8,1,1,4,0,0,1,1,8,3,1,1,0,1,1,5,10,4,11,1,10]

theorem envBound2683 : H12AffineFastState.Bounded env2683 := by
  intro p hp
  have h : env2683.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2682_2683 : H12AffineEnvironment.transform 3 1 env2682 = env2683 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env2682 == env2683) = true)

def env2684 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,131072,41001,108042,32768,4097,8200,5456,230468,8329,5377,164964,4176,131153,648,131140,4294967296,256,4295100140,131072,513]

theorem envBound2684 : H12AffineFastState.Bounded env2684 := by
  intro p hp
  have h : env2684.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2669_2684 : H12AffineEnvironment.transform 17 41001 env2669 = env2684 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41001 env2669 == env2684) = true)

theorem identity2684 : scanCanonicalize (H12AffineFastState.compose env2684 (packedSelected [20,23] rootPS)) = affineNative (2^(16+1) ^^^ 9924) := by decide +kernel

theorem selectedBound2684 : packedSelected [20,23] rootPS < 2^1333 := by decide +kernel

def env2685 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,9924,41001,108042,32768,4097,8200,5456,107136,8329,5377,41632,4176,9877,648,9856,4294967296,256,4294975528,9924,513]

theorem envBound2685 : H12AffineFastState.Bounded env2685 := by
  intro p hp
  have h : env2685.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2684_2685 : H12AffineEnvironment.transform 16 9924 env2684 = env2685 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 9924 env2684 == env2685) = true)

def env2686 : List Nat := [2,4,8,16,32,64,88,256,512,1024,0,4096,8192,4176,32768,65536,9756,41001,108042,32768,4097,8200,5456,107096,8273,5377,41592,4176,9805,592,9816,4294967296,256,4294975528,9756,513]

theorem envBound2686 : H12AffineFastState.Bounded env2686 := by
  intro p hp
  have h : env2686.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2685_2686 : H12AffineEnvironment.transform 6 88 env2685 = env2686 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env2685 == env2686) = true)

theorem identity2686 : scanCanonicalize (H12AffineFastState.compose env2686 (packedSelected [5,8,10,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 13340) := by decide +kernel

theorem selectedBound2686 : packedSelected [5,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env2687 : List Nat := [2,4,8,16,32,64,88,256,512,1024,0,4096,8192,4176,13340,65536,9756,5173,70166,13340,4097,8200,5456,71236,8273,5377,5732,4176,9805,592,9816,4294967296,256,4294975528,9756,513]

theorem envBound2687 : H12AffineFastState.Bounded env2687 := by
  intro p hp
  have h : env2687.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2686_2687 : H12AffineEnvironment.transform 14 13340 env2686 = env2687 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13340 env2686 == env2687) = true)

theorem identity2687 : scanCanonicalize (H12AffineFastState.compose env2687 (packedSelected [0,4,5,7,8,9] rootPS)) = affineNative (2^(12+1) ^^^ 861) := by decide +kernel

theorem selectedBound2687 : packedSelected [0,4,5,7,8,9] rootPS < 2^1333 := by decide +kernel

def env2688 : List Nat := [2,4,8,16,32,64,88,256,512,1024,0,4096,861,4176,5953,65536,1345,5173,70166,5953,4097,853,5456,71236,780,5377,5732,4176,1296,592,1285,4294967296,256,4294968181,1345,513]

theorem envBound2688 : H12AffineFastState.Bounded env2688 := by
  intro p hp
  have h : env2688.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2687_2688 : H12AffineEnvironment.transform 12 861 env2687 = env2688 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 861 env2687 == env2688) = true)

theorem identity2688 : scanCanonicalize (H12AffineFastState.compose env2688 (packedSelected [0,5,6] rootPS)) = affineNative (2^(11+1) ^^^ 1076) := by decide +kernel

theorem selectedBound2688 : packedSelected [0,5,6] rootPS < 2^1333 := by decide +kernel

def env2689 : List Nat := [2,4,8,16,32,64,88,256,512,1024,0,1076,861,1124,885,65536,1345,1,67106,885,1077,853,356,66160,780,309,592,1124,1296,592,1285,4294967296,256,4294968181,1345,513]

theorem envBound2689 : H12AffineFastState.Bounded env2689 := by
  intro p hp
  have h : env2689.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2688_2689 : H12AffineEnvironment.transform 11 1076 env2688 = env2689 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1076 env2688 == env2689) = true)

theorem identity2689 : scanCanonicalize (H12AffineFastState.compose env2689 (packedSelected [0,7] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound2689 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env2690 : List Nat := [2,4,8,16,32,64,88,37,512,1024,0,1076,632,1124,592,65536,1124,1,67106,592,1077,624,65,66160,553,16,592,1124,1077,592,1056,4294967296,37,4294967888,1124,513]

theorem envBound2690 : H12AffineFastState.Bounded env2690 := by
  intro p hp
  have h : env2690.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2689_2690 : H12AffineEnvironment.transform 7 37 env2689 = env2690 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env2689 == env2690) = true)

theorem identity2690 : scanCanonicalize (H12AffineFastState.compose env2690 (packedSelected [1,3] rootPS)) = affineNative (2^(8+1) ^^^ 81) := by decide +kernel

theorem selectedBound2690 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env2691 : List Nat := [2,4,8,16,32,64,88,37,81,1024,0,1076,41,1124,1,65536,1124,1,66675,1,1077,33,65,65569,120,16,1,1124,1077,1,1056,4294967296,37,4294967297,1124,80]

theorem envBound2691 : H12AffineFastState.Bounded env2691 := by
  intro p hp
  have h : env2691.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2690_2691 : H12AffineEnvironment.transform 8 81 env2690 = env2691 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 81 env2690 == env2691) = true)

theorem identity2691 : scanCanonicalize (H12AffineFastState.compose env2691 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 122) := by decide +kernel

theorem selectedBound2691 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2692 : List Nat := [2,4,8,16,32,64,88,37,81,1024,0,1076,41,1124,1,65536,1124,1,66675,1,1077,33,65,65569,120,16,1,1124,1077,1,1056,122,37,123,1124,80]

theorem envBound2692 : H12AffineFastState.Bounded env2692 := by
  intro p hp
  have h : env2692.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2691_2692 : H12AffineEnvironment.transform 31 122 env2691 = env2692 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 122 env2691 == env2692) = true)

theorem identity2692 : scanCanonicalize (H12AffineFastState.compose env2692 (packedSelected [4] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound2692 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env2693 : List Nat := [2,4,8,1,32,64,73,37,64,1024,0,1061,41,1124,1,65536,1124,1,66658,1,1060,33,65,65569,105,1,1,1124,1060,1,1056,107,37,106,1124,65]

theorem envBound2693 : H12AffineFastState.Bounded env2693 := by
  intro p hp
  have h : env2693.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2692_2693 : H12AffineEnvironment.transform 3 1 env2692 = env2693 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env2692 == env2693) = true)

def env2694 : List Nat := [2,4,8,1,32,64,73,37,64,1024,0,1061,41,1124,1,8,1124,1,1130,1,1060,33,65,41,105,1,1,1124,1060,1,1056,107,37,106,1124,65]

theorem envBound2694 : H12AffineFastState.Bounded env2694 := by
  intro p hp
  have h : env2694.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2693_2694 : H12AffineEnvironment.transform 15 8 env2693 = env2694 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8 env2693 == env2694) = true)

theorem identity2694 : scanCanonicalize (H12AffineFastState.compose env2694 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 42) := by decide +kernel

theorem selectedBound2694 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2695 : List Nat := [2,4,8,1,32,42,35,37,42,1024,0,1061,41,1038,1,8,1038,1,1024,1,1060,33,43,41,3,1,1,1038,1060,1,1056,1,37,0,1038,43]

theorem envBound2695 : H12AffineFastState.Bounded env2695 := by
  intro p hp
  have h : env2695.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2694_2695 : H12AffineEnvironment.transform 5 42 env2694 = env2695 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 42 env2694 == env2695) = true)

theorem identity2695 : scanCanonicalize (H12AffineFastState.compose env2695 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound2695 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2696 : List Nat := [2,4,8,1,1,11,2,4,11,1024,0,1028,8,1038,1,8,1038,1,1024,1,1029,0,10,8,3,1,1,1038,1029,1,1025,1,4,0,1038,10]

theorem envBound2696 : H12AffineFastState.Bounded env2696 := by
  intro p hp
  have h : env2696.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2695_2696 : H12AffineEnvironment.transform 4 1 env2695 = env2696 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env2695 == env2696) = true)

def leafEnv2696 : List Nat := [2,4,8,1,1,11,2,4,11,1024,0,1028,8,1038,1,8,1038,1,1024,1,1029,0,10,8,1025,3,1,1,1,1038,1029,1,1025,1,4,0,4,3,1038,10,0,1028,1]

def active2696 : List Nat := [0,1,2,9]

def tree2696 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2696 : H12WitnessSearch.Good tree2696 := H12GlobalWitnessIndex.good

theorem leafIdentity2696 : H12AffineFastState.composeSystem env2696 rootObs = leafEnv2696 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2696 rootObs == leafEnv2696) = true)

theorem terminalChecked2696 : H12PackedTerminal.terminalCheckFast leafEnv2696 active2696 tree2696 = true := by decide +kernel

def env2697 : List Nat := [2,4,8,1,32,64,73,37,64,1024,0,1061,41,1124,1,9,1124,1,1131,1,1060,33,65,40,105,1,1,1124,1060,1,1056,107,37,106,1124,65]

theorem envBound2697 : H12AffineFastState.Bounded env2697 := by
  intro p hp
  have h : env2697.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2693_2697 : H12AffineEnvironment.transform 15 9 env2693 = env2697 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 9 env2693 == env2697) = true)

def env2698 : List Nat := [2,4,8,16,32,64,89,256,512,1024,0,4096,8192,4176,32768,65536,9757,41001,108042,32768,4097,8200,5456,107097,8272,5377,41593,4176,9804,593,9817,4294967296,256,4294975528,9757,513]

theorem envBound2698 : H12AffineFastState.Bounded env2698 := by
  intro p hp
  have h : env2698.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2685_2698 : H12AffineEnvironment.transform 6 89 env2685 = env2698 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env2685 == env2698) = true)

theorem identity2698 : scanCanonicalize (H12AffineFastState.compose env2698 (packedSelected [5,8,10,12,13] rootPS)) = affineNative (2^(15+1) ^^^ 5655) := by decide +kernel

theorem selectedBound2698 : packedSelected [5,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env2699 : List Nat := [2,4,8,16,32,64,89,256,512,1024,0,4096,8192,4176,32768,5655,9757,41001,45085,32768,4097,8200,5456,46158,8272,5377,41593,4176,9804,593,9817,4294967296,256,4294975528,9757,513]

theorem envBound2699 : H12AffineFastState.Bounded env2699 := by
  intro p hp
  have h : env2699.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2698_2699 : H12AffineEnvironment.transform 15 5655 env2698 = env2699 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5655 env2698 == env2699) = true)

theorem identity2699 : scanCanonicalize (H12AffineFastState.compose env2699 (packedSelected [0,5,7,8,16] rootPS)) = affineNative (2^(12+1) ^^^ 860) := by decide +kernel

theorem selectedBound2699 : packedSelected [0,5,7,8,16] rootPS < 2^1333 := by decide +kernel

def env2700 : List Nat := [2,4,8,16,32,64,89,256,512,1024,0,4096,860,4176,32768,5655,1345,33653,37697,32768,4097,852,5456,38674,780,5377,33061,4176,1296,593,1285,4294967296,256,4294968180,1345,513]

theorem envBound2700 : H12AffineFastState.Bounded env2700 := by
  intro p hp
  have h : env2700.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2699_2700 : H12AffineEnvironment.transform 12 860 env2699 = env2700 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 860 env2699 == env2700) = true)

theorem identity2700 : scanCanonicalize (H12AffineFastState.compose env2700 (packedSelected [0,5,6] rootPS)) = affineNative (2^(14+1) ^^^ 292) := by decide +kernel

theorem selectedBound2700 : packedSelected [0,5,6] rootPS < 2^1333 := by decide +kernel

def env2701 : List Nat := [2,4,8,16,32,64,89,256,512,1024,0,4096,860,4176,292,5655,1345,593,4709,292,4097,852,5456,5686,780,5377,1,4176,1296,593,1285,4294967296,256,4294968180,1345,513]

theorem envBound2701 : H12AffineFastState.Bounded env2701 := by
  intro p hp
  have h : env2701.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2700_2701 : H12AffineEnvironment.transform 14 292 env2700 = env2701 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 292 env2700 == env2701) = true)

theorem identity2701 : scanCanonicalize (H12AffineFastState.compose env2701 (packedSelected [0,7] rootPS)) = affineNative (2^(11+1) ^^^ 1857) := by decide +kernel

theorem selectedBound2701 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env2702 : List Nat := [2,4,8,16,32,64,89,256,512,1024,0,1857,860,1809,292,342,1345,593,1316,292,1856,852,529,375,780,576,1,1809,1296,593,1285,4294967296,256,4294968180,1345,513]

theorem envBound2702 : H12AffineFastState.Bounded env2702 := by
  intro p hp
  have h : env2702.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2701_2702 : H12AffineEnvironment.transform 11 1857 env2701 = env2702 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1857 env2701 == env2702) = true)

theorem identity2702 : scanCanonicalize (H12AffineFastState.compose env2702 (packedSelected [1,3] rootPS)) = affineNative (2^(8+1) ^^^ 80) := by decide +kernel

theorem selectedBound2702 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env2703 : List Nat := [2,4,8,16,32,64,89,256,80,1024,0,1297,268,1345,292,342,1345,1,1316,292,1296,260,65,375,348,16,1,1345,1296,1,1285,4294967296,256,4294967588,1345,81]

theorem envBound2703 : H12AffineFastState.Bounded env2703 := by
  intro p hp
  have h : env2703.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2702_2703 : H12AffineEnvironment.transform 8 80 env2702 = env2703 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 80 env2702 == env2703) = true)

theorem identity2703 : scanCanonicalize (H12AffineFastState.compose env2703 (packedSelected [1,2,4,10] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound2703 : packedSelected [1,2,4,10] rootPS < 2^1333 := by decide +kernel

def env2704 : List Nat := [2,4,8,16,32,64,89,37,80,1024,0,1076,41,1124,1,115,1124,1,1025,1,1077,33,65,82,121,16,1,1124,1077,1,1056,4294967296,37,4294967297,1124,81]

theorem envBound2704 : H12AffineFastState.Bounded env2704 := by
  intro p hp
  have h : env2704.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2703_2704 : H12AffineEnvironment.transform 7 37 env2703 = env2704 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env2703 == env2704) = true)

theorem identity2704 : scanCanonicalize (H12AffineFastState.compose env2704 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 122) := by decide +kernel

theorem selectedBound2704 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2705 : List Nat := [2,4,8,16,32,64,89,37,80,1024,0,1076,41,1124,1,115,1124,1,1025,1,1077,33,65,82,121,16,1,1124,1077,1,1056,122,37,123,1124,81]

theorem envBound2705 : H12AffineFastState.Bounded env2705 := by
  intro p hp
  have h : env2705.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2704_2705 : H12AffineEnvironment.transform 31 122 env2704 = env2705 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 122 env2704 == env2705) = true)

theorem identity2705 : scanCanonicalize (H12AffineFastState.compose env2705 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound2705 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2706 : List Nat := [2,4,8,0,32,64,73,37,64,1024,0,1060,41,1124,1,99,1124,1,1025,1,1061,33,65,66,105,0,1,1124,1061,1,1056,106,37,107,1124,65]

theorem envBound2706 : H12AffineFastState.Bounded env2706 := by
  intro p hp
  have h : env2706.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2705_2706 : H12AffineEnvironment.transform 3 0 env2705 = env2706 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env2705 == env2706) = true)

def leafEnv2706 : List Nat := [2,4,8,0,32,64,73,37,64,1024,0,1060,41,1124,1,99,1124,1,1025,1,1061,33,65,66,1057,105,1,0,1,1124,1061,1,1056,106,37,107,4,34,1124,65,0,1060,1]

def active2706 : List Nat := [0,1,2,4,5,9]

def tree2706 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2706 : H12WitnessSearch.Good tree2706 := H12GlobalWitnessIndex.good

theorem leafIdentity2706 : H12AffineFastState.composeSystem env2706 rootObs = leafEnv2706 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2706 rootObs == leafEnv2706) = true)

theorem terminalChecked2706 : H12PackedTerminal.terminalCheckFast leafEnv2706 active2706 tree2706 = true := by decide +kernel

def env2707 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,8201,5456,230468,8329,67108864,67514701,67110225,67245392,67744131,67245381,4294967296,67113985,4362843622,131072,513]

theorem envBound2707 : H12AffineFastState.Bounded env2707 := by
  intro p hp
  have h : env2707.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2663_2707 : H12AffineEnvironment.transform 10 1 env2663 = env2707 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env2663 == env2707) = true)

def env2708 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,8201,5456,230468,8329,5376,402509,4177,131152,631939,131141,4294967296,257,4295729382,131072,513]

theorem envBound2708 : H12AffineFastState.Bounded env2708 := by
  intro p hp
  have h : env2708.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2707_2708 : H12AffineEnvironment.transform 25 5376 env2707 = env2708 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env2707 == env2708) = true)

theorem identity2708 : scanCanonicalize (H12AffineFastState.compose env2708 (packedSelected [11] rootPS)) = affineNative (2^(18+1) ^^^ 242459) := by decide +kernel

theorem selectedBound2708 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env2709 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,131072,262144,242459,32768,4097,8201,5456,230468,8329,5376,402509,4177,131152,137112,131141,4294967296,257,4294972413,131072,513]

theorem envBound2709 : H12AffineFastState.Bounded env2709 := by
  intro p hp
  have h : env2709.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2708_2709 : H12AffineEnvironment.transform 18 242459 env2708 = env2709 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 242459 env2708 == env2709) = true)

theorem identity2709 : scanCanonicalize (H12AffineFastState.compose env2709 (packedSelected [6,25] rootPS)) = affineNative (2^(16+1) ^^^ 112411) := by decide +kernel

theorem selectedBound2709 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env2710 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,112411,262144,1024,32768,4097,8201,5456,13151,8329,5376,365398,4177,112459,106627,112478,4294967296,257,4294972413,112411,513]

theorem envBound2710 : H12AffineFastState.Bounded env2710 := by
  intro p hp
  have h : env2710.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2709_2710 : H12AffineEnvironment.transform 16 112411 env2709 = env2710 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 112411 env2709 == env2710) = true)

def env2711 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,8201,5456,230468,8329,5377,402508,4176,131153,631938,131140,4294967296,256,4295729383,131072,513]

theorem envBound2711 : H12AffineFastState.Bounded env2711 := by
  intro p hp
  have h : env2711.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2707_2711 : H12AffineEnvironment.transform 25 5377 env2707 = env2711 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env2707 == env2711) = true)

theorem identity2711 : scanCanonicalize (H12AffineFastState.compose env2711 (packedSelected [11] rootPS)) = affineNative (2^(18+1) ^^^ 108043) := by decide +kernel

theorem selectedBound2711 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env2712 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,131072,262144,108043,32768,4097,8201,5456,230468,8329,5377,402508,4176,131153,649,131140,4294967296,256,4295100140,131072,513]

theorem envBound2712 : H12AffineFastState.Bounded env2712 := by
  intro p hp
  have h : env2712.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2711_2712 : H12AffineEnvironment.transform 18 108043 env2711 = env2712 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 108043 env2711 == env2712) = true)

def env2713 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,131072,41000,108043,32768,4097,8201,5456,230468,8329,5377,164964,4176,131153,649,131140,4294967296,256,4295100140,131072,513]

theorem envBound2713 : H12AffineFastState.Bounded env2713 := by
  intro p hp
  have h : env2713.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2712_2713 : H12AffineEnvironment.transform 17 41000 env2712 = env2713 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41000 env2712 == env2713) = true)

theorem identity2713 : scanCanonicalize (H12AffineFastState.compose env2713 (packedSelected [20,23] rootPS)) = affineNative (2^(16+1) ^^^ 9925) := by decide +kernel

theorem selectedBound2713 : packedSelected [20,23] rootPS < 2^1333 := by decide +kernel

def env2714 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,9925,41000,108043,32768,4097,8201,5456,107137,8329,5377,41633,4176,9876,649,9857,4294967296,256,4294975529,9925,513]

theorem envBound2714 : H12AffineFastState.Bounded env2714 := by
  intro p hp
  have h : env2714.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2713_2714 : H12AffineEnvironment.transform 16 9925 env2713 = env2714 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 9925 env2713 == env2714) = true)

def env2715 : List Nat := [2,4,8,16,32,64,88,256,512,1024,1,4096,8192,4176,32768,65536,9757,41000,108043,32768,4097,8201,5456,107097,8273,5377,41593,4176,9804,593,9817,4294967296,256,4294975529,9757,513]

theorem envBound2715 : H12AffineFastState.Bounded env2715 := by
  intro p hp
  have h : env2715.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2714_2715 : H12AffineEnvironment.transform 6 88 env2714 = env2715 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env2714 == env2715) = true)

theorem identity2715 : scanCanonicalize (H12AffineFastState.compose env2715 (packedSelected [5,8,10,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 13340) := by decide +kernel

theorem selectedBound2715 : packedSelected [5,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env2716 : List Nat := [2,4,8,16,32,64,88,256,512,1024,1,4096,8192,4176,13340,65536,9757,5172,70167,13340,4097,8201,5456,71237,8273,5377,5733,4176,9804,593,9817,4294967296,256,4294975529,9757,513]

theorem envBound2716 : H12AffineFastState.Bounded env2716 := by
  intro p hp
  have h : env2716.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2715_2716 : H12AffineEnvironment.transform 14 13340 env2715 = env2716 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13340 env2715 == env2716) = true)

theorem identity2716 : scanCanonicalize (H12AffineFastState.compose env2716 (packedSelected [0,4,5,7,8,9] rootPS)) = affineNative (2^(12+1) ^^^ 860) := by decide +kernel

theorem selectedBound2716 : packedSelected [0,4,5,7,8,9] rootPS < 2^1333 := by decide +kernel

def env2717 : List Nat := [2,4,8,16,32,64,88,256,512,1024,1,4096,860,4176,5952,65536,1345,5172,70167,5952,4097,853,5456,71237,781,5377,5733,4176,1296,593,1285,4294967296,256,4294968181,1345,513]

theorem envBound2717 : H12AffineFastState.Bounded env2717 := by
  intro p hp
  have h : env2717.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2716_2717 : H12AffineEnvironment.transform 12 860 env2716 = env2717 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 860 env2716 == env2717) = true)

theorem identity2717 : scanCanonicalize (H12AffineFastState.compose env2717 (packedSelected [0,5,6] rootPS)) = affineNative (2^(11+1) ^^^ 1076) := by decide +kernel

theorem selectedBound2717 : packedSelected [0,5,6] rootPS < 2^1333 := by decide +kernel

def env2718 : List Nat := [2,4,8,16,32,64,88,256,512,1024,1,1076,860,1124,884,65536,1345,0,67107,884,1077,853,356,66161,781,309,593,1124,1296,593,1285,4294967296,256,4294968181,1345,513]

theorem envBound2718 : H12AffineFastState.Bounded env2718 := by
  intro p hp
  have h : env2718.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2717_2718 : H12AffineEnvironment.transform 11 1076 env2717 = env2718 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1076 env2717 == env2718) = true)

theorem identity2718 : scanCanonicalize (H12AffineFastState.compose env2718 (packedSelected [0,7] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound2718 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env2719 : List Nat := [2,4,8,16,32,64,88,37,512,1024,1,1076,633,1124,593,65536,1124,0,67107,593,1077,624,65,66161,552,16,593,1124,1077,593,1056,4294967296,37,4294967888,1124,513]

theorem envBound2719 : H12AffineFastState.Bounded env2719 := by
  intro p hp
  have h : env2719.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2718_2719 : H12AffineEnvironment.transform 7 37 env2718 = env2719 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env2718 == env2719) = true)

theorem identity2719 : scanCanonicalize (H12AffineFastState.compose env2719 (packedSelected [1,3] rootPS)) = affineNative (2^(8+1) ^^^ 81) := by decide +kernel

theorem selectedBound2719 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env2720 : List Nat := [2,4,8,16,32,64,88,37,81,1024,1,1076,40,1124,0,65536,1124,0,66674,0,1077,33,65,65568,121,16,0,1124,1077,0,1056,4294967296,37,4294967297,1124,80]

theorem envBound2720 : H12AffineFastState.Bounded env2720 := by
  intro p hp
  have h : env2720.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2719_2720 : H12AffineEnvironment.transform 8 81 env2719 = env2720 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 81 env2719 == env2720) = true)

theorem identity2720 : scanCanonicalize (H12AffineFastState.compose env2720 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 65545) := by decide +kernel

theorem selectedBound2720 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2721 : List Nat := [2,4,8,16,32,64,88,37,81,1024,1,1076,40,1124,0,65536,1124,0,66674,0,1077,33,65,65568,121,16,0,1124,1077,0,1056,65545,37,65544,1124,80]

theorem envBound2721 : H12AffineFastState.Bounded env2721 := by
  intro p hp
  have h : env2721.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2720_2721 : H12AffineEnvironment.transform 31 65545 env2720 = env2721 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65545 env2720 == env2721) = true)

theorem identity2721 : scanCanonicalize (H12AffineFastState.compose env2721 (packedSelected [4] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound2721 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env2722 : List Nat := [2,4,8,1,32,64,73,37,64,1024,1,1061,40,1124,0,65536,1124,0,66659,0,1060,33,65,65568,104,1,0,1124,1060,0,1056,65545,37,65544,1124,65]

theorem envBound2722 : H12AffineFastState.Bounded env2722 := by
  intro p hp
  have h : env2722.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2721_2722 : H12AffineEnvironment.transform 3 1 env2721 = env2722 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env2721 == env2722) = true)

def env2723 : List Nat := [2,4,8,1,32,64,73,37,64,1024,1,1061,40,1124,0,8,1124,0,1131,0,1060,33,65,40,104,1,0,1124,1060,0,1056,1,37,0,1124,65]

theorem envBound2723 : H12AffineFastState.Bounded env2723 := by
  intro p hp
  have h : env2723.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2722_2723 : H12AffineEnvironment.transform 15 8 env2722 = env2723 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8 env2722 == env2723) = true)

def env2724 : List Nat := [2,4,8,1,32,64,73,37,64,1024,1,1061,40,1124,0,9,1124,0,1130,0,1060,33,65,41,104,1,0,1124,1060,0,1056,0,37,1,1124,65]

theorem envBound2724 : H12AffineFastState.Bounded env2724 := by
  intro p hp
  have h : env2724.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2722_2724 : H12AffineEnvironment.transform 15 9 env2722 = env2724 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 9 env2722 == env2724) = true)

theorem identity2724 : scanCanonicalize (H12AffineFastState.compose env2724 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 42) := by decide +kernel

theorem selectedBound2724 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2725 : List Nat := [2,4,8,1,32,42,35,37,42,1024,1,1061,40,1038,0,9,1038,0,1024,0,1060,33,43,41,2,1,0,1038,1060,0,1056,0,37,1,1038,43]

theorem envBound2725 : H12AffineFastState.Bounded env2725 := by
  intro p hp
  have h : env2725.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2724_2725 : H12AffineEnvironment.transform 5 42 env2724 = env2725 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 42 env2724 == env2725) = true)

theorem identity2725 : scanCanonicalize (H12AffineFastState.compose env2725 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound2725 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2726 : List Nat := [2,4,8,1,1,11,2,4,11,1024,1,1028,9,1038,0,9,1038,0,1024,0,1029,0,10,8,2,1,0,1038,1029,0,1025,0,4,1,1038,10]

theorem envBound2726 : H12AffineFastState.Bounded env2726 := by
  intro p hp
  have h : env2726.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2725_2726 : H12AffineEnvironment.transform 4 1 env2725 = env2726 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env2725 == env2726) = true)

def leafEnv2726 : List Nat := [2,4,8,1,1,11,2,4,11,1024,1,1028,9,1038,0,9,1038,0,1024,0,1029,0,10,8,1025,2,1,1,0,1038,1029,0,1025,0,4,1,4,2,1038,10,0,1028,1]

def active2726 : List Nat := [0,1,2,9]

def tree2726 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2726 : H12WitnessSearch.Good tree2726 := H12GlobalWitnessIndex.good

theorem leafIdentity2726 : H12AffineFastState.composeSystem env2726 rootObs = leafEnv2726 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2726 rootObs == leafEnv2726) = true)

theorem terminalChecked2726 : H12PackedTerminal.terminalCheckFast leafEnv2726 active2726 tree2726 = true := by decide +kernel

def env2727 : List Nat := [2,4,8,16,32,64,89,256,512,1024,1,4096,8192,4176,32768,65536,9756,41000,108043,32768,4097,8201,5456,107096,8272,5377,41592,4176,9805,592,9816,4294967296,256,4294975529,9756,513]

theorem envBound2727 : H12AffineFastState.Bounded env2727 := by
  intro p hp
  have h : env2727.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2714_2727 : H12AffineEnvironment.transform 6 89 env2714 = env2727 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env2714 == env2727) = true)

theorem identity2727 : scanCanonicalize (H12AffineFastState.compose env2727 (packedSelected [5,8,10,12,13] rootPS)) = affineNative (2^(15+1) ^^^ 5654) := by decide +kernel

theorem selectedBound2727 : packedSelected [5,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env2728 : List Nat := [2,4,8,16,32,64,89,256,512,1024,1,4096,8192,4176,32768,5654,9756,41000,45085,32768,4097,8201,5456,46158,8272,5377,41592,4176,9805,592,9816,4294967296,256,4294975529,9756,513]

theorem envBound2728 : H12AffineFastState.Bounded env2728 := by
  intro p hp
  have h : env2728.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2727_2728 : H12AffineEnvironment.transform 15 5654 env2727 = env2728 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5654 env2727 == env2728) = true)

theorem identity2728 : scanCanonicalize (H12AffineFastState.compose env2728 (packedSelected [0,5,7,8,16] rootPS)) = affineNative (2^(12+1) ^^^ 861) := by decide +kernel

theorem selectedBound2728 : packedSelected [0,5,7,8,16] rootPS < 2^1333 := by decide +kernel

def env2729 : List Nat := [2,4,8,16,32,64,89,256,512,1024,1,4096,861,4176,32768,5654,1345,33653,37696,32768,4097,852,5456,38675,781,5377,33061,4176,1296,592,1285,4294967296,256,4294968180,1345,513]

theorem envBound2729 : H12AffineFastState.Bounded env2729 := by
  intro p hp
  have h : env2729.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2728_2729 : H12AffineEnvironment.transform 12 861 env2728 = env2729 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 861 env2728 == env2729) = true)

theorem identity2729 : scanCanonicalize (H12AffineFastState.compose env2729 (packedSelected [0,5,6] rootPS)) = affineNative (2^(14+1) ^^^ 293) := by decide +kernel

theorem selectedBound2729 : packedSelected [0,5,6] rootPS < 2^1333 := by decide +kernel

def env2730 : List Nat := [2,4,8,16,32,64,89,256,512,1024,1,4096,861,4176,293,5654,1345,592,4709,293,4097,852,5456,5686,781,5377,0,4176,1296,592,1285,4294967296,256,4294968180,1345,513]

theorem envBound2730 : H12AffineFastState.Bounded env2730 := by
  intro p hp
  have h : env2730.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2729_2730 : H12AffineEnvironment.transform 14 293 env2729 = env2730 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 293 env2729 == env2730) = true)

theorem identity2730 : scanCanonicalize (H12AffineFastState.compose env2730 (packedSelected [0,7] rootPS)) = affineNative (2^(11+1) ^^^ 1857) := by decide +kernel

theorem selectedBound2730 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env2731 : List Nat := [2,4,8,16,32,64,89,256,512,1024,1,1857,861,1809,293,343,1345,592,1316,293,1856,852,529,375,781,576,0,1809,1296,592,1285,4294967296,256,4294968180,1345,513]

theorem envBound2731 : H12AffineFastState.Bounded env2731 := by
  intro p hp
  have h : env2731.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2730_2731 : H12AffineEnvironment.transform 11 1857 env2730 = env2731 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1857 env2730 == env2731) = true)

theorem identity2731 : scanCanonicalize (H12AffineFastState.compose env2731 (packedSelected [1,3] rootPS)) = affineNative (2^(8+1) ^^^ 80) := by decide +kernel

theorem selectedBound2731 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env2732 : List Nat := [2,4,8,16,32,64,89,256,80,1024,1,1297,269,1345,293,343,1345,0,1316,293,1296,260,65,375,349,16,0,1345,1296,0,1285,4294967296,256,4294967588,1345,81]

theorem envBound2732 : H12AffineFastState.Bounded env2732 := by
  intro p hp
  have h : env2732.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2731_2732 : H12AffineEnvironment.transform 8 80 env2731 = env2732 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 80 env2731 == env2732) = true)

theorem identity2732 : scanCanonicalize (H12AffineFastState.compose env2732 (packedSelected [1,2,4,10] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound2732 : packedSelected [1,2,4,10] rootPS < 2^1333 := by decide +kernel

def env2733 : List Nat := [2,4,8,16,32,64,89,37,80,1024,1,1076,40,1124,0,114,1124,0,1025,0,1077,33,65,82,120,16,0,1124,1077,0,1056,4294967296,37,4294967297,1124,81]

theorem envBound2733 : H12AffineFastState.Bounded env2733 := by
  intro p hp
  have h : env2733.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2732_2733 : H12AffineEnvironment.transform 7 37 env2732 = env2733 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env2732 == env2733) = true)

theorem identity2733 : scanCanonicalize (H12AffineFastState.compose env2733 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 122) := by decide +kernel

theorem selectedBound2733 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2734 : List Nat := [2,4,8,16,32,64,89,37,80,1024,1,1076,40,1124,0,114,1124,0,1025,0,1077,33,65,82,120,16,0,1124,1077,0,1056,122,37,123,1124,81]

theorem envBound2734 : H12AffineFastState.Bounded env2734 := by
  intro p hp
  have h : env2734.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2733_2734 : H12AffineEnvironment.transform 31 122 env2733 = env2734 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 122 env2733 == env2734) = true)

theorem identity2734 : scanCanonicalize (H12AffineFastState.compose env2734 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound2734 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2735 : List Nat := [2,4,8,0,32,64,73,37,64,1024,1,1060,40,1124,0,98,1124,0,1025,0,1061,33,65,66,104,0,0,1124,1061,0,1056,106,37,107,1124,65]

theorem envBound2735 : H12AffineFastState.Bounded env2735 := by
  intro p hp
  have h : env2735.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2734_2735 : H12AffineEnvironment.transform 3 0 env2734 = env2735 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env2734 == env2735) = true)

def leafEnv2735 : List Nat := [2,4,8,0,32,64,73,37,64,1024,1,1060,40,1124,0,98,1124,0,1025,0,1061,33,65,66,1057,104,1,0,0,1124,1061,0,1056,106,37,107,4,35,1124,65,0,1060,1]

def active2735 : List Nat := [0,1,2,4,5,9]

def tree2735 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2735 : H12WitnessSearch.Good tree2735 := H12GlobalWitnessIndex.good

theorem leafIdentity2735 : H12AffineFastState.composeSystem env2735 rootObs = leafEnv2735 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2735 rootObs == leafEnv2735) = true)

theorem terminalChecked2735 : H12PackedTerminal.terminalCheckFast leafEnv2735 active2735 tree2735 = true := by decide +kernel

def env2736 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,131072,41001,108043,32768,4097,8201,5456,230468,8329,5377,164965,4176,131153,649,131140,4294967296,256,4295100140,131072,513]

theorem envBound2736 : H12AffineFastState.Bounded env2736 := by
  intro p hp
  have h : env2736.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2712_2736 : H12AffineEnvironment.transform 17 41001 env2712 = env2736 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41001 env2712 == env2736) = true)

theorem identity2736 : scanCanonicalize (H12AffineFastState.compose env2736 (packedSelected [16,18] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound2736 : packedSelected [16,18] rootPS < 2^1333 := by decide +kernel

def env2737 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,4096,8192,4176,32768,65536,131072,41001,107650,32768,4097,8201,5456,230468,8329,5377,164965,4176,131153,0,131140,4294967296,256,4295099493,131072,136]

theorem envBound2737 : H12AffineFastState.Bounded env2737 := by
  intro p hp
  have h : env2737.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2736_2737 : H12AffineEnvironment.transform 8 137 env2736 = env2737 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env2736 == env2737) = true)

theorem identity2737 : scanCanonicalize (H12AffineFastState.compose env2737 (packedSelected [0,2,6,9,16] rootPS)) = affineNative (2^(16+1) ^^^ 9292) := by decide +kernel

theorem selectedBound2737 : packedSelected [0,2,6,9,16] rootPS < 2^1333 := by decide +kernel

def env2738 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,4096,8192,4176,32768,65536,9292,41001,107650,32768,4097,8201,5456,106504,8329,5377,41001,4176,9245,0,9224,4294967296,256,4294975529,9292,136]

theorem envBound2738 : H12AffineFastState.Bounded env2738 := by
  intro p hp
  have h : env2738.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2737_2738 : H12AffineEnvironment.transform 16 9292 env2737 = env2738 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 9292 env2737 == env2738) = true)

theorem identity2738 : scanCanonicalize (H12AffineFastState.compose env2738 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound2738 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env2739 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1296,8192,1344,32768,65536,9292,41001,107650,32768,1297,8201,64,106504,8329,17,41001,1344,9245,0,9224,4294967296,256,4294975529,9292,136]

theorem envBound2739 : H12AffineFastState.Bounded env2739 := by
  intro p hp
  have h : env2739.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2738_2739 : H12AffineEnvironment.transform 11 1296 env2738 = env2739 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env2738 == env2739) = true)

theorem identity2739 : scanCanonicalize (H12AffineFastState.compose env2739 (packedSelected [0,2,4,5,6,8,10,12,17] rootPS)) = affineNative (2^(12+1) ^^^ 269) := by decide +kernel

theorem selectedBound2739 : packedSelected [0,2,4,5,6,8,10,12,17] rootPS < 2^1333 := by decide +kernel

def env2740 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1296,269,1344,32768,65536,1345,33060,99727,32768,1297,260,64,98565,388,17,33060,1344,1296,0,1285,4294967296,256,4294967588,1345,136]

theorem envBound2740 : H12AffineFastState.Bounded env2740 := by
  intro p hp
  have h : env2740.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2739_2740 : H12AffineEnvironment.transform 12 269 env2739 = env2740 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 269 env2739 == env2740) = true)

def env2741 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,10248,5457,230468,8329,67108864,67516749,67110224,67245392,1073741824,67245381,4294967296,67113985,4362845670,131072,513]

theorem envBound2741 : H12AffineFastState.Bounded env2741 := by
  intro p hp
  have h : env2741.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2661_2741 : H12AffineEnvironment.transform 13 4177 env2661 = env2741 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env2661 == env2741) = true)

theorem identity2741 : scanCanonicalize (H12AffineFastState.compose env2741 (packedSelected [1,3,4,5,8,9,10,16,19] rootPS)) = affineNative (2^(29+1) ^^^ 631938) := by decide +kernel

theorem selectedBound2741 : packedSelected [1,3,4,5,8,9,10,16,19] rootPS < 2^1333 := by decide +kernel

def env2742 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,10248,5457,230468,8329,67108864,67516749,67110224,67245392,631938,67245381,4294967296,67113985,4362845670,131072,513]

theorem envBound2742 : H12AffineFastState.Bounded env2742 := by
  intro p hp
  have h : env2742.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2741_2742 : H12AffineEnvironment.transform 29 631938 env2741 = env2742 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 631938 env2741 == env2742) = true)

theorem identity2742 : scanCanonicalize (H12AffineFastState.compose env2742 (packedSelected [0,4,7,16,20,22] rootPS)) = affineNative (2^(25+1) ^^^ 528641) := by decide +kernel

theorem selectedBound2742 : packedSelected [0,4,7,16,20,22] rootPS < 2^1333 := by decide +kernel

def env2743 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,10248,5457,230468,8329,528641,927820,529489,656465,631938,656452,4294967296,525568,4295208167,131072,513]

theorem envBound2743 : H12AffineFastState.Bounded env2743 := by
  intro p hp
  have h : env2743.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2742_2743 : H12AffineEnvironment.transform 25 528641 env2742 = env2743 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 528641 env2742 == env2743) = true)

theorem identity2743 : scanCanonicalize (H12AffineFastState.compose env2743 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(18+1) ^^^ 1024) := by decide +kernel

theorem selectedBound2743 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env2744 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1024,32768,4097,10248,5457,230468,8329,5377,404556,4177,131153,106626,131140,4294967296,256,4295208167,131072,513]

theorem envBound2744 : H12AffineFastState.Bounded env2744 := by
  intro p hp
  have h : env2744.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2743_2744 : H12AffineEnvironment.transform 18 1024 env2743 = env2744 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env2743 == env2744) = true)

theorem identity2744 : scanCanonicalize (H12AffineFastState.compose env2744 (packedSelected [13,21] rootPS)) = affineNative (2^(16+1) ^^^ 4176) := by decide +kernel

theorem selectedBound2744 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env2745 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4176,262144,1024,32768,4097,10248,5457,103444,8329,5377,277532,4177,4097,106626,4116,4294967296,256,4295081143,4176,513]

theorem envBound2745 : H12AffineFastState.Bounded env2745 := by
  intro p hp
  have h : env2745.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2744_2745 : H12AffineEnvironment.transform 16 4176 env2744 = env2745 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4176 env2744 == env2745) = true)

theorem identity2745 : scanCanonicalize (H12AffineFastState.compose env2745 (packedSelected [13,17] rootPS)) = affineNative (2^(15+1) ^^^ 38047) := by decide +kernel

theorem selectedBound2745 : packedSelected [13,17] rootPS < 2^1333 := by decide +kernel

def env2746 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,38047,4176,262144,1024,32768,4097,10248,5457,139,8329,5377,277532,4177,4097,13341,4116,4294967296,256,4294977576,4176,513]

theorem envBound2746 : H12AffineFastState.Bounded env2746 := by
  intro p hp
  have h : env2746.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2745_2746 : H12AffineEnvironment.transform 15 38047 env2745 = env2746 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 38047 env2745 == env2746) = true)

theorem identity2746 : scanCanonicalize (H12AffineFastState.compose env2746 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(11+1) ^^^ 1944) := by decide +kernel

theorem selectedBound2746 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env2747 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,8192,1993,32768,33543,1992,262144,1024,32768,1945,10248,713,139,8329,665,273284,1993,1945,9093,1932,4294967296,256,4294977576,1992,513]

theorem envBound2747 : H12AffineFastState.Bounded env2747 := by
  intro p hp
  have h : env2747.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2746_2747 : H12AffineEnvironment.transform 11 1944 env2746 = env2747 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env2746 == env2747) = true)

theorem identity2747 : scanCanonicalize (H12AffineFastState.compose env2747 (packedSelected [1,5,8,24] rootPS)) = affineNative (2^(17+1) ^^^ 43048) := by decide +kernel

theorem selectedBound2747 : packedSelected [1,5,8,24] rootPS < 2^1333 := by decide +kernel

def env2748 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,8192,1993,32768,33543,1992,43048,1024,32768,1945,10248,713,139,8329,665,33708,1993,1945,9093,1932,4294967296,256,4294977576,1992,513]

theorem envBound2748 : H12AffineFastState.Bounded env2748 := by
  intro p hp
  have h : env2748.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2747_2748 : H12AffineEnvironment.transform 17 43048 env2747 = env2748 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43048 env2747 == env2748) = true)

theorem identity2748 : scanCanonicalize (H12AffineFastState.compose env2748 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(12+1) ^^^ 2316) := by decide +kernel

theorem selectedBound2748 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env2749 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,2316,1993,32768,33543,1992,33060,1024,32768,1945,260,713,139,2437,665,33708,1993,1945,2697,1932,4294967296,256,4294967588,1992,513]

theorem envBound2749 : H12AffineFastState.Bounded env2749 := by
  intro p hp
  have h : env2749.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2748_2749 : H12AffineEnvironment.transform 12 2316 env2748 = env2749 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2316 env2748 == env2749) = true)

theorem identity2749 : scanCanonicalize (H12AffineFastState.compose env2749 (packedSelected [0,1,3,5,7,8] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound2749 : packedSelected [0,1,3,5,7,8] rootPS < 2^1333 := by decide +kernel

def env2750 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,1296,2316,1345,32768,33167,1344,33060,1024,32768,1297,260,65,139,2437,17,33060,1345,1297,2049,1284,4294967296,256,4294967588,1344,137]

theorem envBound2750 : H12AffineFastState.Bounded env2750 := by
  intro p hp
  have h : env2750.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2749_2750 : H12AffineEnvironment.transform 8 136 env2749 = env2750 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env2749 == env2750) = true)

theorem identity2750 : scanCanonicalize (H12AffineFastState.compose env2750 (packedSelected [1,3] rootPS)) = affineNative (2^(14+1) ^^^ 2048) := by decide +kernel

theorem selectedBound2750 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env2751 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,1296,2316,1345,2048,2447,1344,2340,1024,2048,1297,260,65,139,2437,17,2340,1345,1297,2049,1284,4294967296,256,4294967588,1344,137]

theorem envBound2751 : H12AffineFastState.Bounded env2751 := by
  intro p hp
  have h : env2751.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2750_2751 : H12AffineEnvironment.transform 14 2048 env2750 = env2751 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2048 env2750 == env2751) = true)

theorem identity2751 : scanCanonicalize (H12AffineFastState.compose env2751 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 75) := by decide +kernel

theorem selectedBound2751 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2752 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,1296,2316,1345,2048,2447,1344,2340,1024,2048,1297,260,65,139,2437,17,2340,1345,1297,2049,1284,75,256,367,1344,137]

theorem envBound2752 : H12AffineFastState.Bounded env2752 := by
  intro p hp
  have h : env2752.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2751_2752 : H12AffineEnvironment.transform 31 75 env2751 = env2752 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 75 env2751 == env2752) = true)

theorem identity2752 : scanCanonicalize (H12AffineFastState.compose env2752 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 111) := by decide +kernel

theorem selectedBound2752 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2753 : List Nat := [2,4,8,16,32,64,128,111,136,1024,2048,1151,2147,1070,2048,2272,1071,2123,1024,2048,1150,107,65,139,2282,17,2123,1070,1150,2049,1131,75,111,0,1071,137]

theorem envBound2753 : H12AffineFastState.Bounded env2753 := by
  intro p hp
  have h : env2753.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2752_2753 : H12AffineEnvironment.transform 7 111 env2752 = env2753 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 111 env2752 == env2753) = true)

theorem identity2753 : scanCanonicalize (H12AffineFastState.compose env2753 (packedSelected [2,4] rootPS)) = affineNative (2^(6+1) ^^^ 114) := by decide +kernel

theorem selectedBound2753 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env2754 : List Nat := [2,4,8,16,32,64,114,111,122,1024,2048,1151,2147,1070,2048,2066,1071,2123,1024,2048,1150,107,65,121,2072,17,2123,1070,1150,2049,1131,75,111,0,1071,123]

theorem envBound2754 : H12AffineFastState.Bounded env2754 := by
  intro p hp
  have h : env2754.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2753_2754 : H12AffineEnvironment.transform 6 114 env2753 = env2754 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 114 env2753 == env2754) = true)

theorem identity2754 : scanCanonicalize (H12AffineFastState.compose env2754 (packedSelected [10] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound2754 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env2755 : List Nat := [2,4,8,16,32,11,57,36,49,1024,2048,1076,2088,1070,2048,2066,1071,2048,1024,2048,1077,32,10,50,2072,17,2048,1070,1077,2049,1056,0,36,0,1071,48]

theorem envBound2755 : H12AffineFastState.Bounded env2755 := by
  intro p hp
  have h : env2755.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2754_2755 : H12AffineEnvironment.transform 5 11 env2754 = env2755 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env2754 == env2755) = true)

def env2756 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,10249,17664,230468,33554432,67108864,67528989,67130625,67245392,1073741824,67245381,4294967296,67113985,4396404031,131072,33563272]

theorem envBound2756 : H12AffineFastState.Bounded env2756 := by
  intro p hp
  have h : env2756.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2639_2756 : H12AffineEnvironment.transform 21 10249 env2639 = env2756 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10249 env2639 == env2756) = true)

def env2757 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,10249,17664,230468,8328,67108864,67528989,67130625,67245392,1073741824,67245381,4294967296,67113985,4362857911,131072,512]

theorem envBound2757 : H12AffineFastState.Bounded env2757 := by
  intro p hp
  have h : env2757.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2756_2757 : H12AffineEnvironment.transform 24 8328 env2756 = env2757 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8328 env2756 == env2757) = true)

theorem identity2757 : scanCanonicalize (H12AffineFastState.compose env2757 (packedSelected [4,7,9,16,20,27] rootPS)) = affineNative (2^(29+1) ^^^ 67233235) := by decide +kernel

theorem selectedBound2757 : packedSelected [4,7,9,16,20,27] rootPS < 2^1333 := by decide +kernel

def env2758 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,10249,17664,230468,8328,67108864,67528989,67130625,67245392,67233235,67245381,4294967296,67113985,4362857911,131072,512]

theorem envBound2758 : H12AffineFastState.Bounded env2758 := by
  intro p hp
  have h : env2758.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2757_2758 : H12AffineEnvironment.transform 29 67233235 env2757 = env2758 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 67233235 env2757 == env2758) = true)

theorem identity2758 : scanCanonicalize (H12AffineFastState.compose env2758 (packedSelected [1,5,8,19,24,26] rootPS)) = affineNative (2^(16+1) ^^^ 21777) := by decide +kernel

theorem selectedBound2758 : packedSelected [1,5,8,19,24,26] rootPS < 2^1333 := by decide +kernel

def env2759 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,524288,32768,4097,10249,17664,119125,8328,67108864,67386380,67130625,67125313,67233235,67125332,4294967296,67113985,4362713254,21777,512]

theorem envBound2759 : H12AffineFastState.Bounded env2759 := by
  intro p hp
  have h : env2759.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2758_2759 : H12AffineEnvironment.transform 16 21777 env2758 = env2759 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 21777 env2758 == env2759) = true)

theorem identity2759 : scanCanonicalize (H12AffineFastState.compose env2759 (packedSelected [0,6,7,9,20,22,25] rootPS)) = affineNative (2^(18+1) ^^^ 35977) := by decide +kernel

theorem selectedBound2759 : packedSelected [0,6,7,9,20,22,25] rootPS < 2^1333 := by decide +kernel

def env2760 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,35977,32768,4097,10249,17664,119125,8328,67108864,67386380,67130625,67125313,67233235,67125332,4294967296,67113985,4362155055,21777,512]

theorem envBound2760 : H12AffineFastState.Bounded env2760 := by
  intro p hp
  have h : env2760.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2759_2760 : H12AffineEnvironment.transform 18 35977 env2759 = env2760 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 35977 env2759 == env2760) = true)

theorem identity2760 : scanCanonicalize (H12AffineFastState.compose env2760 (packedSelected [3,5,8,10,28,31] rootPS)) = affineNative (2^(25+1) ^^^ 5377) := by decide +kernel

theorem selectedBound2760 : packedSelected [3,5,8,10,28,31] rootPS < 2^1333 := by decide +kernel

def env2761 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,35977,32768,4097,10249,17664,119125,8328,5377,272653,16384,21824,127186,21845,4294967296,256,4295041326,21777,512]

theorem envBound2761 : H12AffineFastState.Bounded env2761 := by
  intro p hp
  have h : env2761.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2760_2761 : H12AffineEnvironment.transform 25 5377 env2760 = env2761 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env2760 == env2761) = true)

theorem identity2761 : scanCanonicalize (H12AffineFastState.compose env2761 (packedSelected [4,9,16] rootPS)) = affineNative (2^(14+1) ^^^ 29021) := by decide +kernel

theorem selectedBound2761 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env2762 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,29021,65536,21777,262144,32212,29021,4097,10249,17664,73736,8328,5377,272653,16384,21824,65935,21845,4294967296,256,4295041326,21777,512]

theorem envBound2762 : H12AffineFastState.Bounded env2762 := by
  intro p hp
  have h : env2762.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2761_2762 : H12AffineEnvironment.transform 14 29021 env2761 = env2762 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 29021 env2761 == env2762) = true)

theorem identity2762 : scanCanonicalize (H12AffineFastState.compose env2762 (packedSelected [1,3,5,8,10,13,19,21] rootPS)) = affineNative (2^(13+1) ^^^ 4177) := by decide +kernel

theorem selectedBound2762 : packedSelected [1,3,5,8,10,13,19,21] rootPS < 2^1333 := by decide +kernel

def env2763 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,8460,65536,1344,262144,11653,8460,4097,10249,5457,73736,8328,5377,272653,4177,1297,65935,1284,4294967296,256,4295041326,1344,512]

theorem envBound2763 : H12AffineFastState.Bounded env2763 := by
  intro p hp
  have h : env2763.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2762_2763 : H12AffineEnvironment.transform 13 4177 env2762 = env2763 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env2762 == env2763) = true)

theorem identity2763 : scanCanonicalize (H12AffineFastState.compose env2763 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 65910) := by decide +kernel

theorem selectedBound2763 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env2764 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,8460,65536,1344,262144,11653,8460,4097,10249,5457,73736,8328,5377,272653,4177,1297,65935,1284,65910,256,8280,1344,512]

theorem envBound2764 : H12AffineFastState.Bounded env2764 := by
  intro p hp
  have h : env2764.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2763_2764 : H12AffineEnvironment.transform 31 65910 env2763 = env2764 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65910 env2763 == env2764) = true)

theorem identity2764 : scanCanonicalize (H12AffineFastState.compose env2764 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 8322) := by decide +kernel

theorem selectedBound2764 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env2765 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,8460,8322,1344,262144,11653,8460,4097,10249,5457,138,8328,5377,272653,4177,1297,8461,1284,8692,256,8280,1344,512]

theorem envBound2765 : H12AffineFastState.Bounded env2765 := by
  intro p hp
  have h : env2765.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2764_2765 : H12AffineEnvironment.transform 15 8322 env2764 = env2765 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8322 env2764 == env2765) = true)

theorem identity2765 : scanCanonicalize (H12AffineFastState.compose env2765 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(17+1) ^^^ 15421) := by decide +kernel

theorem selectedBound2765 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env2766 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,8460,8322,1344,15421,11653,8460,4097,10249,5457,138,8328,5377,5424,4177,1297,8461,1284,8692,256,8280,1344,512]

theorem envBound2766 : H12AffineFastState.Bounded env2766 := by
  intro p hp
  have h : env2766.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2765_2766 : H12AffineEnvironment.transform 17 15421 env2765 = env2766 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 15421 env2765 == env2766) = true)

theorem identity2766 : scanCanonicalize (H12AffineFastState.compose env2766 (packedSelected [0,3,5,10] rootPS)) = affineNative (2^(12+1) ^^^ 4186) := by decide +kernel

theorem selectedBound2766 : packedSelected [0,3,5,10] rootPS < 2^1333 := by decide +kernel

def env2767 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,4186,4177,4438,4312,1344,3175,7647,4438,4097,6227,5457,138,4306,5377,5424,4177,1297,4439,1284,4526,256,4098,1344,512]

theorem envBound2767 : H12AffineFastState.Bounded env2767 := by
  intro p hp
  have h : env2767.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2766_2767 : H12AffineEnvironment.transform 12 4186 env2766 = env2767 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4186 env2766 == env2767) = true)

theorem identity2767 : scanCanonicalize (H12AffineFastState.compose env2767 (packedSelected [0,2,4,11] rootPS)) = affineNative (2^(11+1) ^^^ 3060) := by decide +kernel

theorem selectedBound2767 : packedSelected [0,2,4,11] rootPS < 2^1333 := by decide +kernel

def env2768 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,3060,2990,2981,2722,2860,1344,3175,1579,2722,3061,935,3749,138,2854,3829,3780,2981,1297,2723,1284,2650,256,3062,1344,512]

theorem envBound2768 : H12AffineFastState.Bounded env2768 := by
  intro p hp
  have h : env2768.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2767_2768 : H12AffineEnvironment.transform 11 3060 env2767 = env2768 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3060 env2767 == env2768) = true)

theorem identity2768 : scanCanonicalize (H12AffineFastState.compose env2768 (packedSelected [13,17] rootPS)) = affineNative (2^(8+1) ^^^ 43) := by decide +kernel

theorem selectedBound2768 : packedSelected [13,17] rootPS < 2^1333 := by decide +kernel

def env2769 : List Nat := [2,4,8,16,32,64,128,256,43,1024,2048,2527,2437,2446,2185,2311,1344,3175,1024,2185,2526,396,3214,138,2317,3294,3311,2446,1297,2184,1284,2161,256,2525,1344,43]

theorem envBound2769 : H12AffineFastState.Bounded env2769 := by
  intro p hp
  have h : env2769.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2768_2769 : H12AffineEnvironment.transform 8 43 env2768 = env2769 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 43 env2768 == env2769) = true)

theorem identity2769 : scanCanonicalize (H12AffineFastState.compose env2769 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 50) := by decide +kernel

theorem selectedBound2769 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2770 : List Nat := [2,4,8,16,32,64,128,256,43,1024,50,493,439,444,187,309,1344,1109,1024,187,492,396,1212,138,319,1260,1245,444,1297,186,1284,67,256,495,1344,43]

theorem envBound2770 : H12AffineFastState.Bounded env2770 := by
  intro p hp
  have h : env2770.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2769_2770 : H12AffineEnvironment.transform 10 50 env2769 = env2770 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 50 env2769 == env2770) = true)

theorem identity2770 : scanCanonicalize (H12AffineFastState.compose env2770 (packedSelected [1,5,12] rootPS)) = affineNative (2^(9+1) ^^^ 323) := by decide +kernel

theorem selectedBound2770 : packedSelected [1,5,12] rootPS < 2^1333 := by decide +kernel

def env2771 : List Nat := [2,4,8,16,32,64,128,256,43,323,50,493,439,444,187,309,3,278,323,187,492,396,511,138,319,431,414,444,82,186,71,67,256,495,3,43]

theorem envBound2771 : H12AffineFastState.Bounded env2771 := by
  intro p hp
  have h : env2771.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2770_2771 : H12AffineEnvironment.transform 9 323 env2770 = env2771 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 323 env2770 == env2771) = true)

theorem identity2771 : scanCanonicalize (H12AffineFastState.compose env2771 (packedSelected [2,4] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound2771 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env2772 : List Nat := [2,4,8,2,32,64,128,256,43,323,32,493,421,430,169,295,3,260,323,169,492,396,493,138,301,431,396,430,64,168,71,67,256,495,3,43]

theorem envBound2772 : H12AffineFastState.Bounded env2772 := by
  intro p hp
  have h : env2772.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2771_2772 : H12AffineEnvironment.transform 3 2 env2771 = env2772 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env2771 == env2772) = true)

def env2773 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,10249,17664,230468,8329,67108864,67528989,67130625,67245392,1073741824,67245381,4294967296,67113985,4362857910,131072,513]

theorem envBound2773 : H12AffineFastState.Bounded env2773 := by
  intro p hp
  have h : env2773.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2756_2773 : H12AffineEnvironment.transform 24 8329 env2756 = env2773 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env2756 == env2773) = true)

def env2774 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,10249,5456,230468,8329,67108864,67516749,67110225,67245392,1073741824,67245381,4294967296,67113985,4362845670,131072,513]

theorem envBound2774 : H12AffineFastState.Bounded env2774 := by
  intro p hp
  have h : env2774.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2773_2774 : H12AffineEnvironment.transform 13 4176 env2773 = env2774 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env2773 == env2774) = true)

theorem identity2774 : scanCanonicalize (H12AffineFastState.compose env2774 (packedSelected [0,4,7,16,20,22] rootPS)) = affineNative (2^(29+1) ^^^ 67744130) := by decide +kernel

theorem selectedBound2774 : packedSelected [0,4,7,16,20,22] rootPS < 2^1333 := by decide +kernel

def env2775 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,10249,5456,230468,8329,67108864,67516749,67110225,67245392,67744130,67245381,4294967296,67113985,4362845670,131072,513]

theorem envBound2775 : H12AffineFastState.Bounded env2775 := by
  intro p hp
  have h : env2775.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2774_2775 : H12AffineEnvironment.transform 29 67744130 env2774 = env2775 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 67744130 env2774 == env2775) = true)

def env2776 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,8201,5456,230468,8329,67108864,67514701,67110225,67245392,67744130,67245381,4294967296,67113985,4362843622,131072,513]

theorem envBound2776 : H12AffineFastState.Bounded env2776 := by
  intro p hp
  have h : env2776.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2775_2776 : H12AffineEnvironment.transform 10 0 env2775 = env2776 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env2775 == env2776) = true)

def env2777 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,8201,5456,230468,8329,5376,402509,4177,131152,631938,131141,4294967296,257,4295729382,131072,513]

theorem envBound2777 : H12AffineFastState.Bounded env2777 := by
  intro p hp
  have h : env2777.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2776_2777 : H12AffineEnvironment.transform 25 5376 env2776 = env2777 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env2776 == env2777) = true)

theorem identity2777 : scanCanonicalize (H12AffineFastState.compose env2777 (packedSelected [11] rootPS)) = affineNative (2^(18+1) ^^^ 79742) := by decide +kernel

theorem selectedBound2777 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env2778 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,131072,262144,79742,32768,4097,8201,5456,230468,8329,5376,402509,4177,131152,37884,131141,4294967296,257,4295137176,131072,513]

theorem envBound2778 : H12AffineFastState.Bounded env2778 := by
  intro p hp
  have h : env2778.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2777_2778 : H12AffineEnvironment.transform 18 79742 env2777 = env2778 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 79742 env2777 == env2778) = true)

theorem identity2778 : scanCanonicalize (H12AffineFastState.compose env2778 (packedSelected [6,25] rootPS)) = affineNative (2^(15+1) ^^^ 13182) := by decide +kernel

theorem selectedBound2778 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env2779 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,13182,131072,262144,1024,32768,4097,8201,5456,177978,8329,5376,402509,4177,131152,37884,131141,4294967296,257,4295137176,131072,513]

theorem envBound2779 : H12AffineFastState.Bounded env2779 := by
  intro p hp
  have h : env2779.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2778_2779 : H12AffineEnvironment.transform 15 13182 env2778 = env2779 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13182 env2778 == env2779) = true)

def env2780 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,8201,5456,230468,8329,5377,402508,4176,131153,631939,131140,4294967296,256,4295729383,131072,513]

theorem envBound2780 : H12AffineFastState.Bounded env2780 := by
  intro p hp
  have h : env2780.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2776_2780 : H12AffineEnvironment.transform 25 5377 env2776 = env2780 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env2776 == env2780) = true)

theorem identity2780 : scanCanonicalize (H12AffineFastState.compose env2780 (packedSelected [11] rootPS)) = affineNative (2^(18+1) ^^^ 205422) := by decide +kernel

theorem selectedBound2780 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env2781 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,131072,262144,205422,32768,4097,8201,5456,230468,8329,5377,402508,4176,131153,165613,131140,4294967296,256,4295000713,131072,513]

theorem envBound2781 : H12AffineFastState.Bounded env2781 := by
  intro p hp
  have h : env2781.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2780_2781 : H12AffineEnvironment.transform 18 205422 env2780 = env2781 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 205422 env2780 == env2781) = true)

def env2782 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,131072,41000,205422,32768,4097,8201,5456,230468,8329,5377,164964,4176,131153,165613,131140,4294967296,256,4295000713,131072,513]

theorem envBound2782 : H12AffineFastState.Bounded env2782 := by
  intro p hp
  have h : env2782.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2781_2782 : H12AffineEnvironment.transform 17 41000 env2781 = env2782 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41000 env2781 == env2782) = true)

theorem identity2782 : scanCanonicalize (H12AffineFastState.compose env2782 (packedSelected [16,18] rootPS)) = affineNative (2^(16+1) ^^^ 9292) := by decide +kernel

theorem selectedBound2782 : packedSelected [16,18] rootPS < 2^1333 := by decide +kernel

def env2783 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,9292,41000,67106,32768,4097,8201,5456,106504,8329,5377,41000,4176,9245,41633,9224,4294967296,256,4295000713,9292,513]

theorem envBound2783 : H12AffineFastState.Bounded env2783 := by
  intro p hp
  have h : env2783.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2782_2783 : H12AffineEnvironment.transform 16 9292 env2782 = env2783 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 9292 env2782 == env2783) = true)

theorem identity2783 : scanCanonicalize (H12AffineFastState.compose env2783 (packedSelected [0,4,7,9,16] rootPS)) = affineNative (2^(14+1) ^^^ 13624) := by decide +kernel

theorem selectedBound2783 : packedSelected [0,4,7,9,16] rootPS < 2^1333 := by decide +kernel

def env2784 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,13624,65536,9292,5392,67106,13624,4097,8201,5456,70960,8329,5377,5392,4176,9245,6041,9224,4294967296,256,4294981553,9292,513]

theorem envBound2784 : H12AffineFastState.Bounded env2784 := by
  intro p hp
  have h : env2784.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2783_2784 : H12AffineEnvironment.transform 14 13624 env2783 = env2784 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13624 env2783 == env2784) = true)

theorem identity2784 : scanCanonicalize (H12AffineFastState.compose env2784 (packedSelected [0,1,3,4,5,7,8,9,12,13,15,17,20] rootPS)) = affineNative (2^(12+1) ^^^ 269) := by decide +kernel

theorem selectedBound2784 : packedSelected [0,1,3,4,5,7,8,9,12,13,15,17,20] rootPS < 2^1333 := by decide +kernel

def env2785 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,269,4176,5173,65536,1345,5392,67106,5173,4097,260,5456,70960,388,5377,5392,4176,1296,6041,1285,4294967296,256,4294973116,1345,513]

theorem envBound2785 : H12AffineFastState.Bounded env2785 := by
  intro p hp
  have h : env2785.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2784_2785 : H12AffineEnvironment.transform 12 269 env2784 = env2785 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 269 env2784 == env2785) = true)

def env2786 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,32768,65536,131072,41001,205422,32768,4097,8201,5456,230468,8329,5377,164965,4176,131153,165613,131140,4294967296,256,4295000713,131072,513]

theorem envBound2786 : H12AffineFastState.Bounded env2786 := by
  intro p hp
  have h : env2786.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2781_2786 : H12AffineEnvironment.transform 17 41001 env2781 = env2786 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41001 env2781 == env2786) = true)

theorem identity2786 : scanCanonicalize (H12AffineFastState.compose env2786 (packedSelected [16,18] rootPS)) = affineNative (2^(14+1) ^^^ 8864) := by decide +kernel

theorem selectedBound2786 : packedSelected [16,18] rootPS < 2^1333 := by decide +kernel

def env2787 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4176,8864,65536,131072,649,205422,8864,4097,8201,5456,206564,8329,5377,140997,4176,131153,140365,131140,4294967296,256,4294975529,131072,513]

theorem envBound2787 : H12AffineFastState.Bounded env2787 := by
  intro p hp
  have h : env2787.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2786_2787 : H12AffineEnvironment.transform 14 8864 env2786 = env2787 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8864 env2786 == env2787) = true)

def env2788 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,8192,4176,8232,65536,131072,1,205030,8232,4097,8201,5456,205932,8329,5377,140365,4176,131153,140365,131140,4294967296,256,4294975529,131072,137]

theorem envBound2788 : H12AffineFastState.Bounded env2788 := by
  intro p hp
  have h : env2788.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2787_2788 : H12AffineEnvironment.transform 8 136 env2787 = env2788 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env2787 == env2788) = true)

theorem identity2788 : scanCanonicalize (H12AffineFastState.compose env2788 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(15+1) ^^^ 5562) := by decide +kernel

theorem selectedBound2788 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env2789 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,8192,4176,8232,5562,131072,1,144732,8232,4097,8201,5456,143830,8329,5377,140365,4176,131153,140365,131140,4294967296,256,4294975529,131072,137]

theorem envBound2789 : H12AffineFastState.Bounded env2789 := by
  intro p hp
  have h : env2789.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2788_2789 : H12AffineEnvironment.transform 15 5562 env2788 = env2789 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5562 env2788 == env2789) = true)

theorem identity2789 : scanCanonicalize (H12AffineFastState.compose env2789 (packedSelected [3,5,10,12] rootPS)) = affineNative (2^(12+1) ^^^ 5148) := by decide +kernel

theorem selectedBound2789 : packedSelected [3,5,10,12] rootPS < 2^1333 := by decide +kernel

def env2790 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,5148,4176,5172,5562,131072,1,131392,5172,4097,5141,5456,132554,5269,5377,135249,4176,131153,135249,131140,4294967296,256,4294972469,131072,137]

theorem envBound2790 : H12AffineFastState.Bounded env2790 := by
  intro p hp
  have h : env2790.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2789_2790 : H12AffineEnvironment.transform 12 5148 env2789 = env2790 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5148 env2789 == env2790) = true)

def env2791 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,8192,4176,8233,65536,131072,0,205031,8233,4097,8201,5456,205933,8329,5377,140364,4176,131153,140365,131140,4294967296,256,4294975529,131072,136]

theorem envBound2791 : H12AffineFastState.Bounded env2791 := by
  intro p hp
  have h : env2791.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2787_2791 : H12AffineEnvironment.transform 8 137 env2787 = env2791 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env2787 == env2791) = true)

theorem identity2791 : scanCanonicalize (H12AffineFastState.compose env2791 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound2791 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env2792 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1296,8192,1344,8233,65536,131072,0,205031,8233,1297,8201,64,205933,8329,17,140364,1344,131153,140365,131140,4294967296,256,4294975529,131072,136]

theorem envBound2792 : H12AffineFastState.Bounded env2792 := by
  intro p hp
  have h : env2792.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2791_2792 : H12AffineEnvironment.transform 11 1296 env2791 = env2792 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env2791 == env2792) = true)

def env2793 : List Nat := [2,4,8,16,32,64,88,256,81,1024,0,1296,8192,1344,8233,65536,131072,0,204863,8233,1297,8201,64,205933,8273,17,140364,1344,131153,140365,131140,4294967296,256,4294975529,131072,80]

theorem envBound2793 : H12AffineFastState.Bounded env2793 := by
  intro p hp
  have h : env2793.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2792_2793 : H12AffineEnvironment.transform 6 88 env2792 = env2793 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env2792 == env2793) = true)

theorem identity2793 : scanCanonicalize (H12AffineFastState.compose env2793 (packedSelected [0,1,2,3,4,5,6,8] rootPS)) = affineNative (2^(12+1) ^^^ 40) := by decide +kernel

theorem selectedBound2793 : packedSelected [0,1,2,3,4,5,6,8] rootPS < 2^1333 := by decide +kernel

def env2794 : List Nat := [2,4,8,16,32,64,88,256,81,1024,0,1296,40,1344,1,65536,131072,0,196631,1,1297,33,64,197701,121,17,132196,1344,131153,132197,131140,4294967296,256,4294967297,131072,80]

theorem envBound2794 : H12AffineFastState.Bounded env2794 := by
  intro p hp
  have h : env2794.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2793_2794 : H12AffineEnvironment.transform 12 40 env2793 = env2794 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 40 env2793 == env2794) = true)

theorem identity2794 : scanCanonicalize (H12AffineFastState.compose env2794 (packedSelected [1,5,10] rootPS)) = affineNative (2^(16+1) ^^^ 1124) := by decide +kernel

theorem selectedBound2794 : packedSelected [1,5,10] rootPS < 2^1333 := by decide +kernel

def env2795 : List Nat := [2,4,8,16,32,64,88,256,81,1024,0,1296,40,1344,1,65536,1124,0,66675,1,1297,33,64,65569,121,17,0,1344,1077,1,1056,4294967296,256,4294967297,1124,80]

theorem envBound2795 : H12AffineFastState.Bounded env2795 := by
  intro p hp
  have h : env2795.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2794_2795 : H12AffineEnvironment.transform 16 1124 env2794 = env2795 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1124 env2794 == env2795) = true)

theorem identity2795 : scanCanonicalize (H12AffineFastState.compose env2795 (packedSelected [0,4] rootPS)) = affineNative (2^(31+1) ^^^ 107) := by decide +kernel

theorem selectedBound2795 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env2796 : List Nat := [2,4,8,16,32,64,88,256,81,1024,0,1296,40,1344,1,65536,1124,0,66675,1,1297,33,64,65569,121,17,0,1344,1077,1,1056,107,256,106,1124,80]

theorem envBound2796 : H12AffineFastState.Bounded env2796 := by
  intro p hp
  have h : env2796.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2795_2796 : H12AffineEnvironment.transform 31 107 env2795 = env2796 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 107 env2795 == env2796) = true)

theorem identity2796 : scanCanonicalize (H12AffineFastState.compose env2796 (packedSelected [3,5,13] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound2796 : packedSelected [3,5,13] rootPS < 2^1333 := by decide +kernel

def env2797 : List Nat := [2,4,8,16,32,64,88,37,81,1024,0,1077,40,1125,1,65536,1124,0,66675,1,1076,33,64,65569,121,17,0,1125,1077,1,1056,107,37,106,1124,80]

theorem envBound2797 : H12AffineFastState.Bounded env2797 := by
  intro p hp
  have h : env2797.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2796_2797 : H12AffineEnvironment.transform 7 37 env2796 = env2797 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env2796 == env2797) = true)

theorem identity2797 : scanCanonicalize (H12AffineFastState.compose env2797 (packedSelected [0] rootPS)) = affineNative (2^(5+1) ^^^ 0) := by decide +kernel

theorem selectedBound2797 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2798 : List Nat := [2,4,8,16,32,0,24,37,17,1024,0,1077,40,1061,1,65536,1060,0,66611,1,1076,33,0,65569,57,17,0,1061,1077,1,1056,43,37,42,1060,16]

theorem envBound2798 : H12AffineFastState.Bounded env2798 := by
  intro p hp
  have h : env2798.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2797_2798 : H12AffineEnvironment.transform 5 0 env2797 = env2798 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env2797 == env2798) = true)

def env2799 : List Nat := [2,4,8,16,32,0,24,37,17,1024,0,1077,40,1061,1,24,1060,0,1067,1,1076,33,0,57,57,17,0,1061,1077,1,1056,43,37,42,1060,16]

theorem envBound2799 : H12AffineFastState.Bounded env2799 := by
  intro p hp
  have h : env2799.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2798_2799 : H12AffineEnvironment.transform 15 24 env2798 = env2799 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 24 env2798 == env2799) = true)

def env2800 : List Nat := [2,4,8,16,32,0,24,37,17,1024,0,1077,40,1061,1,25,1060,0,1066,1,1076,33,0,56,57,17,0,1061,1077,1,1056,43,37,42,1060,16]

theorem envBound2800 : H12AffineFastState.Bounded env2800 := by
  intro p hp
  have h : env2800.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2798_2800 : H12AffineEnvironment.transform 15 25 env2798 = env2800 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 25 env2798 == env2800) = true)

theorem identity2800 : scanCanonicalize (H12AffineFastState.compose env2800 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound2800 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2801 : List Nat := [2,4,8,16,10,0,24,15,17,1024,0,1055,2,1039,1,25,1038,0,1024,1,1054,11,0,18,19,17,0,1039,1055,1,1034,1,15,0,1038,16]

theorem envBound2801 : H12AffineFastState.Bounded env2801 := by
  intro p hp
  have h : env2801.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2800_2801 : H12AffineEnvironment.transform 4 10 env2800 = env2801 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env2800 == env2801) = true)

theorem identity2801 : scanCanonicalize (H12AffineFastState.compose env2801 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound2801 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2802 : List Nat := [2,4,3,16,1,0,19,4,17,1024,0,1044,2,1028,1,18,1029,0,1024,1,1045,0,0,18,19,17,0,1028,1044,1,1025,1,4,0,1029,16]

theorem envBound2802 : H12AffineFastState.Bounded env2802 := by
  intro p hp
  have h : env2802.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2801_2802 : H12AffineEnvironment.transform 2 3 env2801 = env2802 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env2801 == env2802) = true)

def leafEnv2802 : List Nat := [2,4,3,16,1,0,19,4,17,1024,0,1044,2,1028,1,18,1029,0,1024,1,1045,0,0,18,1025,19,1,17,0,1028,1044,1,1025,1,4,0,4,3,1029,16,0,1045,1]

def active2802 : List Nat := [0,1,3,9]

def tree2802 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2802 : H12WitnessSearch.Good tree2802 := H12GlobalWitnessIndex.good

theorem leafIdentity2802 : H12AffineFastState.composeSystem env2802 rootObs = leafEnv2802 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2802 rootObs == leafEnv2802) = true)

theorem terminalChecked2802 : H12PackedTerminal.terminalCheckFast leafEnv2802 active2802 tree2802 = true := by decide +kernel

def env2803 : List Nat := [2,4,8,16,32,64,89,256,80,1024,0,1296,8192,1344,8233,65536,131072,0,204862,8233,1297,8201,64,205933,8272,17,140364,1344,131153,140365,131140,4294967296,256,4294975529,131072,81]

theorem envBound2803 : H12AffineFastState.Bounded env2803 := by
  intro p hp
  have h : env2803.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2792_2803 : H12AffineEnvironment.transform 6 89 env2792 = env2803 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env2792 == env2803) = true)

theorem identity2803 : scanCanonicalize (H12AffineFastState.compose env2803 (packedSelected [0,1,2,3,4,5,6,8] rootPS)) = affineNative (2^(16+1) ^^^ 66583) := by decide +kernel

theorem selectedBound2803 : packedSelected [0,1,2,3,4,5,6,8] rootPS < 2^1333 := by decide +kernel

def env2804 : List Nat := [2,4,8,16,32,64,89,256,80,1024,0,1296,8192,1344,8233,65536,66583,0,9257,8233,1297,8201,64,8314,8272,17,73819,1344,66630,73818,66643,4294967296,256,4294975529,66583,81]

theorem envBound2804 : H12AffineFastState.Bounded env2804 := by
  intro p hp
  have h : env2804.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2803_2804 : H12AffineEnvironment.transform 16 66583 env2803 = env2804 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 66583 env2803 == env2804) = true)

theorem identity2804 : scanCanonicalize (H12AffineFastState.compose env2804 (packedSelected [0,1,2,4,5,6,10] rootPS)) = affineNative (2^(15+1) ^^^ 115) := by decide +kernel

theorem selectedBound2804 : packedSelected [0,1,2,4,5,6,10] rootPS < 2^1333 := by decide +kernel

def env2805 : List Nat := [2,4,8,16,32,64,89,256,80,1024,0,1296,8192,1344,8233,115,1124,0,9257,8233,1297,8201,64,8314,8272,17,8232,1344,1077,8233,1056,4294967296,256,4294975529,1124,81]

theorem envBound2805 : H12AffineFastState.Bounded env2805 := by
  intro p hp
  have h : env2805.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2804_2805 : H12AffineEnvironment.transform 15 115 env2804 = env2805 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 115 env2804 == env2805) = true)

theorem identity2805 : scanCanonicalize (H12AffineFastState.compose env2805 (packedSelected [3,5,13] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound2805 : packedSelected [3,5,13] rootPS < 2^1333 := by decide +kernel

def env2806 : List Nat := [2,4,8,16,32,64,89,37,80,1024,0,1077,8192,1125,8233,115,1124,0,9257,8233,1076,8201,64,8314,8272,17,8232,1125,1077,8233,1056,4294967296,37,4294975529,1124,81]

theorem envBound2806 : H12AffineFastState.Bounded env2806 := by
  intro p hp
  have h : env2806.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2805_2806 : H12AffineEnvironment.transform 7 37 env2805 = env2806 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env2805 == env2806) = true)

theorem identity2806 : scanCanonicalize (H12AffineFastState.compose env2806 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 42) := by decide +kernel

theorem selectedBound2806 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2807 : List Nat := [2,4,8,16,32,64,89,37,80,1024,0,1077,8192,1125,8233,115,1124,0,9257,8233,1076,8201,64,8314,8272,17,8232,1125,1077,8233,1056,42,37,8195,1124,81]

theorem envBound2807 : H12AffineFastState.Bounded env2807 := by
  intro p hp
  have h : env2807.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2806_2807 : H12AffineEnvironment.transform 31 42 env2806 = env2807 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 42 env2806 == env2807) = true)

theorem identity2807 : scanCanonicalize (H12AffineFastState.compose env2807 (packedSelected [2,4,5] rootPS)) = affineNative (2^(12+1) ^^^ 40) := by decide +kernel

theorem selectedBound2807 : packedSelected [2,4,5] rootPS < 2^1333 := by decide +kernel

def env2808 : List Nat := [2,4,8,16,32,64,89,37,80,1024,0,1077,40,1125,1,115,1124,0,1025,1,1076,33,64,82,120,17,0,1125,1077,1,1056,42,37,43,1124,81]

theorem envBound2808 : H12AffineFastState.Bounded env2808 := by
  intro p hp
  have h : env2808.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2807_2808 : H12AffineEnvironment.transform 12 40 env2807 = env2808 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 40 env2807 == env2808) = true)

theorem identity2808 : scanCanonicalize (H12AffineFastState.compose env2808 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 1) := by decide +kernel

theorem selectedBound2808 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2809 : List Nat := [2,4,8,16,32,1,24,37,17,1024,0,1077,40,1060,1,50,1061,0,1025,1,1076,33,1,19,57,17,0,1060,1077,1,1056,42,37,43,1061,16]

theorem envBound2809 : H12AffineFastState.Bounded env2809 := by
  intro p hp
  have h : env2809.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2808_2809 : H12AffineEnvironment.transform 5 1 env2808 = env2809 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 1 env2808 == env2809) = true)

def leafEnv2809 : List Nat := [2,4,8,16,32,1,24,37,17,1024,0,1077,40,1060,1,50,1061,0,1025,1,1076,33,1,19,1057,57,1,17,0,1060,1077,1,1056,42,37,43,4,34,1061,16,0,1076,1]

def active2809 : List Nat := [0,1,2,3,4,9]

def tree2809 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2809 : H12WitnessSearch.Good tree2809 := H12GlobalWitnessIndex.good

theorem leafIdentity2809 : H12AffineFastState.composeSystem env2809 rootObs = leafEnv2809 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2809 rootObs == leafEnv2809) = true)

theorem terminalChecked2809 : H12PackedTerminal.terminalCheckFast leafEnv2809 active2809 tree2809 = true := by decide +kernel

def env2810 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,8200,5456,230468,8329,67108864,67514700,67110225,67245392,67744130,67245381,4294967296,67113985,4362843623,131072,513]

theorem envBound2810 : H12AffineFastState.Bounded env2810 := by
  intro p hp
  have h : env2810.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2775_2810 : H12AffineEnvironment.transform 10 1 env2775 = env2810 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env2775 == env2810) = true)

def env2811 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,8200,5456,230468,8329,5376,402508,4177,131152,631938,131141,4294967296,257,4295729383,131072,513]

theorem envBound2811 : H12AffineFastState.Bounded env2811 := by
  intro p hp
  have h : env2811.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2810_2811 : H12AffineEnvironment.transform 25 5376 env2810 = env2811 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env2810 == env2811) = true)

theorem identity2811 : scanCanonicalize (H12AffineFastState.compose env2811 (packedSelected [11] rootPS)) = affineNative (2^(18+1) ^^^ 366423) := by decide +kernel

theorem selectedBound2811 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env2812 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,131072,262144,366423,32768,4097,8200,5456,230468,8329,5376,402508,4177,131152,275413,131141,4294967296,257,4295374768,131072,513]

theorem envBound2812 : H12AffineFastState.Bounded env2812 := by
  intro p hp
  have h : env2812.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2811_2812 : H12AffineEnvironment.transform 18 366423 env2811 = env2812 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 366423 env2811 == env2812) = true)

theorem identity2812 : scanCanonicalize (H12AffineFastState.compose env2812 (packedSelected [6,25] rootPS)) = affineNative (2^(17+1) ^^^ 103255) := by decide +kernel

theorem selectedBound2812 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env2813 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,131072,103255,1024,32768,4097,8200,5456,230468,8329,5376,243483,4177,131152,106626,131141,4294967296,257,4295206119,131072,513]

theorem envBound2813 : H12AffineFastState.Bounded env2813 := by
  intro p hp
  have h : env2813.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2812_2813 : H12AffineEnvironment.transform 17 103255 env2812 = env2813 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 103255 env2812 == env2813) = true)

def env2814 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,8200,5456,230468,8329,5377,402509,4176,131153,631939,131140,4294967296,256,4295729382,131072,513]

theorem envBound2814 : H12AffineFastState.Bounded env2814 := by
  intro p hp
  have h : env2814.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2810_2814 : H12AffineEnvironment.transform 25 5377 env2810 = env2814 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env2810 == env2814) = true)

theorem identity2814 : scanCanonicalize (H12AffineFastState.compose env2814 (packedSelected [11] rootPS)) = affineNative (2^(18+1) ^^^ 492102) := by decide +kernel

theorem selectedBound2814 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env2815 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,131072,262144,492102,32768,4097,8200,5456,230468,8329,5377,402509,4176,131153,403141,131140,4294967296,256,4295238304,131072,513]

theorem envBound2815 : H12AffineFastState.Bounded env2815 := by
  intro p hp
  have h : env2815.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2814_2815 : H12AffineEnvironment.transform 18 492102 env2814 = env2815 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 492102 env2814 == env2815) = true)

def env2816 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,131072,41000,205422,32768,4097,8200,5456,230468,8329,5377,164965,4176,131153,165613,131140,4294967296,256,4295000712,131072,513]

theorem envBound2816 : H12AffineFastState.Bounded env2816 := by
  intro p hp
  have h : env2816.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2815_2816 : H12AffineEnvironment.transform 17 41000 env2815 = env2816 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41000 env2815 == env2816) = true)

theorem identity2816 : scanCanonicalize (H12AffineFastState.compose env2816 (packedSelected [16,18] rootPS)) = affineNative (2^(14+1) ^^^ 8864) := by decide +kernel

theorem selectedBound2816 : packedSelected [16,18] rootPS < 2^1333 := by decide +kernel

def env2817 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,8864,65536,131072,648,205422,8864,4097,8200,5456,206564,8329,5377,140997,4176,131153,140365,131140,4294967296,256,4294975528,131072,513]

theorem envBound2817 : H12AffineFastState.Bounded env2817 := by
  intro p hp
  have h : env2817.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2816_2817 : H12AffineEnvironment.transform 14 8864 env2816 = env2817 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8864 env2816 == env2817) = true)

def env2818 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,4096,8192,4176,8232,65536,131072,0,205030,8232,4097,8200,5456,205932,8329,5377,140365,4176,131153,140365,131140,4294967296,256,4294975528,131072,137]

theorem envBound2818 : H12AffineFastState.Bounded env2818 := by
  intro p hp
  have h : env2818.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2817_2818 : H12AffineEnvironment.transform 8 136 env2817 = env2818 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env2817 == env2818) = true)

theorem identity2818 : scanCanonicalize (H12AffineFastState.compose env2818 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(15+1) ^^^ 5563) := by decide +kernel

theorem selectedBound2818 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env2819 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,4096,8192,4176,8232,5563,131072,0,144733,8232,4097,8200,5456,143831,8329,5377,140365,4176,131153,140365,131140,4294967296,256,4294975528,131072,137]

theorem envBound2819 : H12AffineFastState.Bounded env2819 := by
  intro p hp
  have h : env2819.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2818_2819 : H12AffineEnvironment.transform 15 5563 env2818 = env2819 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5563 env2818 == env2819) = true)

theorem identity2819 : scanCanonicalize (H12AffineFastState.compose env2819 (packedSelected [3,5,10,12] rootPS)) = affineNative (2^(12+1) ^^^ 5149) := by decide +kernel

theorem selectedBound2819 : packedSelected [3,5,10,12] rootPS < 2^1333 := by decide +kernel

def env2820 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,4096,5149,4176,5173,5563,131072,0,131392,5173,4097,5141,5456,132554,5268,5377,135248,4176,131153,135248,131140,4294967296,256,4294972469,131072,137]

theorem envBound2820 : H12AffineFastState.Bounded env2820 := by
  intro p hp
  have h : env2820.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2819_2820 : H12AffineEnvironment.transform 12 5149 env2819 = env2820 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5149 env2819 == env2820) = true)

def env2821 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,4096,8192,4176,8233,65536,131072,1,205031,8233,4097,8200,5456,205933,8329,5377,140364,4176,131153,140365,131140,4294967296,256,4294975528,131072,136]

theorem envBound2821 : H12AffineFastState.Bounded env2821 := by
  intro p hp
  have h : env2821.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2817_2821 : H12AffineEnvironment.transform 8 137 env2817 = env2821 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env2817 == env2821) = true)

theorem identity2821 : scanCanonicalize (H12AffineFastState.compose env2821 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound2821 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env2822 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1296,8192,1344,8233,65536,131072,1,205031,8233,1297,8200,64,205933,8329,17,140364,1344,131153,140365,131140,4294967296,256,4294975528,131072,136]

theorem envBound2822 : H12AffineFastState.Bounded env2822 := by
  intro p hp
  have h : env2822.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2821_2822 : H12AffineEnvironment.transform 11 1296 env2821 = env2822 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env2821 == env2822) = true)

def env2823 : List Nat := [2,4,8,16,32,64,88,256,81,1024,1,1296,8192,1344,8233,65536,131072,1,204863,8233,1297,8200,64,205933,8273,17,140364,1344,131153,140365,131140,4294967296,256,4294975528,131072,80]

theorem envBound2823 : H12AffineFastState.Bounded env2823 := by
  intro p hp
  have h : env2823.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2822_2823 : H12AffineEnvironment.transform 6 88 env2822 = env2823 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env2822 == env2823) = true)

theorem identity2823 : scanCanonicalize (H12AffineFastState.compose env2823 (packedSelected [0,1,2,3,4,5,6,8] rootPS)) = affineNative (2^(12+1) ^^^ 41) := by decide +kernel

theorem selectedBound2823 : packedSelected [0,1,2,3,4,5,6,8] rootPS < 2^1333 := by decide +kernel

def env2824 : List Nat := [2,4,8,16,32,64,88,256,81,1024,1,1296,41,1344,0,65536,131072,1,196630,0,1297,33,64,197700,120,17,132197,1344,131153,132196,131140,4294967296,256,4294967297,131072,80]

theorem envBound2824 : H12AffineFastState.Bounded env2824 := by
  intro p hp
  have h : env2824.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2823_2824 : H12AffineEnvironment.transform 12 41 env2823 = env2824 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 41 env2823 == env2824) = true)

theorem identity2824 : scanCanonicalize (H12AffineFastState.compose env2824 (packedSelected [1,5,10] rootPS)) = affineNative (2^(16+1) ^^^ 1124) := by decide +kernel

theorem selectedBound2824 : packedSelected [1,5,10] rootPS < 2^1333 := by decide +kernel

def env2825 : List Nat := [2,4,8,16,32,64,88,256,81,1024,1,1296,41,1344,0,65536,1124,1,66674,0,1297,33,64,65568,120,17,1,1344,1077,0,1056,4294967296,256,4294967297,1124,80]

theorem envBound2825 : H12AffineFastState.Bounded env2825 := by
  intro p hp
  have h : env2825.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2824_2825 : H12AffineEnvironment.transform 16 1124 env2824 = env2825 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1124 env2824 == env2825) = true)

theorem identity2825 : scanCanonicalize (H12AffineFastState.compose env2825 (packedSelected [0,4] rootPS)) = affineNative (2^(31+1) ^^^ 65560) := by decide +kernel

theorem selectedBound2825 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env2826 : List Nat := [2,4,8,16,32,64,88,256,81,1024,1,1296,41,1344,0,65536,1124,1,66674,0,1297,33,64,65568,120,17,1,1344,1077,0,1056,65560,256,65561,1124,80]

theorem envBound2826 : H12AffineFastState.Bounded env2826 := by
  intro p hp
  have h : env2826.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2825_2826 : H12AffineEnvironment.transform 31 65560 env2825 = env2826 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65560 env2825 == env2826) = true)

theorem identity2826 : scanCanonicalize (H12AffineFastState.compose env2826 (packedSelected [3,5,13] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound2826 : packedSelected [3,5,13] rootPS < 2^1333 := by decide +kernel

def env2827 : List Nat := [2,4,8,16,32,64,88,37,81,1024,1,1077,41,1125,0,65536,1124,1,66674,0,1076,33,64,65568,120,17,1,1125,1077,0,1056,65560,37,65561,1124,80]

theorem envBound2827 : H12AffineFastState.Bounded env2827 := by
  intro p hp
  have h : env2827.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2826_2827 : H12AffineEnvironment.transform 7 37 env2826 = env2827 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env2826 == env2827) = true)

theorem identity2827 : scanCanonicalize (H12AffineFastState.compose env2827 (packedSelected [0] rootPS)) = affineNative (2^(5+1) ^^^ 0) := by decide +kernel

theorem selectedBound2827 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2828 : List Nat := [2,4,8,16,32,0,24,37,17,1024,1,1077,41,1061,0,65536,1060,1,66610,0,1076,33,0,65568,56,17,1,1061,1077,0,1056,65560,37,65561,1060,16]

theorem envBound2828 : H12AffineFastState.Bounded env2828 := by
  intro p hp
  have h : env2828.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2827_2828 : H12AffineEnvironment.transform 5 0 env2827 = env2828 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env2827 == env2828) = true)

def env2829 : List Nat := [2,4,8,16,32,0,24,37,17,1024,1,1077,41,1061,0,24,1060,1,1066,0,1076,33,0,56,56,17,1,1061,1077,0,1056,0,37,1,1060,16]

theorem envBound2829 : H12AffineFastState.Bounded env2829 := by
  intro p hp
  have h : env2829.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2828_2829 : H12AffineEnvironment.transform 15 24 env2828 = env2829 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 24 env2828 == env2829) = true)

theorem identity2829 : scanCanonicalize (H12AffineFastState.compose env2829 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound2829 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2830 : List Nat := [2,4,8,16,10,0,24,15,17,1024,1,1055,3,1039,0,24,1038,1,1024,0,1054,11,0,18,18,17,1,1039,1055,0,1034,0,15,1,1038,16]

theorem envBound2830 : H12AffineFastState.Bounded env2830 := by
  intro p hp
  have h : env2830.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2829_2830 : H12AffineEnvironment.transform 4 10 env2829 = env2830 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env2829 == env2830) = true)

theorem identity2830 : scanCanonicalize (H12AffineFastState.compose env2830 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound2830 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2831 : List Nat := [2,4,3,16,1,0,19,4,17,1024,1,1044,3,1028,0,19,1029,1,1024,0,1045,0,0,18,18,17,1,1028,1044,0,1025,0,4,1,1029,16]

theorem envBound2831 : H12AffineFastState.Bounded env2831 := by
  intro p hp
  have h : env2831.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2830_2831 : H12AffineEnvironment.transform 2 3 env2830 = env2831 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env2830 == env2831) = true)

def leafEnv2831 : List Nat := [2,4,3,16,1,0,19,4,17,1024,1,1044,3,1028,0,19,1029,1,1024,0,1045,0,0,18,1025,18,1,17,1,1028,1044,0,1025,0,4,1,4,2,1029,16,0,1045,1]

def active2831 : List Nat := [0,1,3,9]

def tree2831 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2831 : H12WitnessSearch.Good tree2831 := H12GlobalWitnessIndex.good

theorem leafIdentity2831 : H12AffineFastState.composeSystem env2831 rootObs = leafEnv2831 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2831 rootObs == leafEnv2831) = true)

theorem terminalChecked2831 : H12PackedTerminal.terminalCheckFast leafEnv2831 active2831 tree2831 = true := by decide +kernel

def env2832 : List Nat := [2,4,8,16,32,0,24,37,17,1024,1,1077,41,1061,0,25,1060,1,1067,0,1076,33,0,57,56,17,1,1061,1077,0,1056,1,37,0,1060,16]

theorem envBound2832 : H12AffineFastState.Bounded env2832 := by
  intro p hp
  have h : env2832.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2828_2832 : H12AffineEnvironment.transform 15 25 env2828 = env2832 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 25 env2828 == env2832) = true)

def env2833 : List Nat := [2,4,8,16,32,64,89,256,80,1024,1,1296,8192,1344,8233,65536,131072,1,204862,8233,1297,8200,64,205933,8272,17,140364,1344,131153,140365,131140,4294967296,256,4294975528,131072,81]

theorem envBound2833 : H12AffineFastState.Bounded env2833 := by
  intro p hp
  have h : env2833.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2822_2833 : H12AffineEnvironment.transform 6 89 env2822 = env2833 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env2822 == env2833) = true)

theorem identity2833 : scanCanonicalize (H12AffineFastState.compose env2833 (packedSelected [0,1,2,3,4,5,6,8] rootPS)) = affineNative (2^(16+1) ^^^ 66582) := by decide +kernel

theorem selectedBound2833 : packedSelected [0,1,2,3,4,5,6,8] rootPS < 2^1333 := by decide +kernel

def env2834 : List Nat := [2,4,8,16,32,64,89,256,80,1024,1,1296,8192,1344,8233,65536,66582,1,9256,8233,1297,8200,64,8315,8272,17,73818,1344,66631,73819,66642,4294967296,256,4294975528,66582,81]

theorem envBound2834 : H12AffineFastState.Bounded env2834 := by
  intro p hp
  have h : env2834.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2833_2834 : H12AffineEnvironment.transform 16 66582 env2833 = env2834 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 66582 env2833 == env2834) = true)

theorem identity2834 : scanCanonicalize (H12AffineFastState.compose env2834 (packedSelected [0,1,2,4,5,6,10] rootPS)) = affineNative (2^(15+1) ^^^ 114) := by decide +kernel

theorem selectedBound2834 : packedSelected [0,1,2,4,5,6,10] rootPS < 2^1333 := by decide +kernel

def env2835 : List Nat := [2,4,8,16,32,64,89,256,80,1024,1,1296,8192,1344,8233,114,1124,1,9256,8233,1297,8200,64,8315,8272,17,8232,1344,1077,8233,1056,4294967296,256,4294975528,1124,81]

theorem envBound2835 : H12AffineFastState.Bounded env2835 := by
  intro p hp
  have h : env2835.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2834_2835 : H12AffineEnvironment.transform 15 114 env2834 = env2835 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 114 env2834 == env2835) = true)

theorem identity2835 : scanCanonicalize (H12AffineFastState.compose env2835 (packedSelected [3,5,13] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound2835 : packedSelected [3,5,13] rootPS < 2^1333 := by decide +kernel

def env2836 : List Nat := [2,4,8,16,32,64,89,37,80,1024,1,1077,8192,1125,8233,114,1124,1,9256,8233,1076,8200,64,8315,8272,17,8232,1125,1077,8233,1056,4294967296,37,4294975528,1124,81]

theorem envBound2836 : H12AffineFastState.Bounded env2836 := by
  intro p hp
  have h : env2836.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2835_2836 : H12AffineEnvironment.transform 7 37 env2835 = env2836 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env2835 == env2836) = true)

theorem identity2836 : scanCanonicalize (H12AffineFastState.compose env2836 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 8195) := by decide +kernel

theorem selectedBound2836 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2837 : List Nat := [2,4,8,16,32,64,89,37,80,1024,1,1077,8192,1125,8233,114,1124,1,9256,8233,1076,8200,64,8315,8272,17,8232,1125,1077,8233,1056,8195,37,43,1124,81]

theorem envBound2837 : H12AffineFastState.Bounded env2837 := by
  intro p hp
  have h : env2837.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2836_2837 : H12AffineEnvironment.transform 31 8195 env2836 = env2837 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 8195 env2836 == env2837) = true)

theorem identity2837 : scanCanonicalize (H12AffineFastState.compose env2837 (packedSelected [2,4,5] rootPS)) = affineNative (2^(12+1) ^^^ 41) := by decide +kernel

theorem selectedBound2837 : packedSelected [2,4,5] rootPS < 2^1333 := by decide +kernel

def env2838 : List Nat := [2,4,8,16,32,64,89,37,80,1024,1,1077,41,1125,0,114,1124,1,1025,0,1076,33,64,82,121,17,1,1125,1077,0,1056,42,37,43,1124,81]

theorem envBound2838 : H12AffineFastState.Bounded env2838 := by
  intro p hp
  have h : env2838.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2837_2838 : H12AffineEnvironment.transform 12 41 env2837 = env2838 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 41 env2837 == env2838) = true)

theorem identity2838 : scanCanonicalize (H12AffineFastState.compose env2838 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 1) := by decide +kernel

theorem selectedBound2838 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2839 : List Nat := [2,4,8,16,32,1,24,37,17,1024,1,1077,41,1060,0,51,1061,1,1025,0,1076,33,1,19,56,17,1,1060,1077,0,1056,42,37,43,1061,16]

theorem envBound2839 : H12AffineFastState.Bounded env2839 := by
  intro p hp
  have h : env2839.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2838_2839 : H12AffineEnvironment.transform 5 1 env2838 = env2839 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 1 env2838 == env2839) = true)

def leafEnv2839 : List Nat := [2,4,8,16,32,1,24,37,17,1024,1,1077,41,1060,0,51,1061,1,1025,0,1076,33,1,19,1057,56,1,17,1,1060,1077,0,1056,42,37,43,4,35,1061,16,0,1076,1]

def active2839 : List Nat := [0,1,2,3,4,9]

def tree2839 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2839 : H12WitnessSearch.Good tree2839 := H12GlobalWitnessIndex.good

theorem leafIdentity2839 : H12AffineFastState.composeSystem env2839 rootObs = leafEnv2839 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2839 rootObs == leafEnv2839) = true)

theorem terminalChecked2839 : H12PackedTerminal.terminalCheckFast leafEnv2839 active2839 tree2839 = true := by decide +kernel

def env2840 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,131072,41001,205423,32768,4097,8200,5456,230468,8329,5377,164964,4176,131153,165612,131140,4294967296,256,4295000713,131072,513]

theorem envBound2840 : H12AffineFastState.Bounded env2840 := by
  intro p hp
  have h : env2840.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2815_2840 : H12AffineEnvironment.transform 17 41001 env2815 = env2840 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41001 env2815 == env2840) = true)

theorem identity2840 : scanCanonicalize (H12AffineFastState.compose env2840 (packedSelected [16,18] rootPS)) = affineNative (2^(16+1) ^^^ 9293) := by decide +kernel

theorem selectedBound2840 : packedSelected [16,18] rootPS < 2^1333 := by decide +kernel

def env2841 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,9293,41001,67106,32768,4097,8200,5456,106505,8329,5377,41001,4176,9244,41633,9225,4294967296,256,4295000713,9293,513]

theorem envBound2841 : H12AffineFastState.Bounded env2841 := by
  intro p hp
  have h : env2841.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2840_2841 : H12AffineEnvironment.transform 16 9293 env2840 = env2841 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 9293 env2840 == env2841) = true)

theorem identity2841 : scanCanonicalize (H12AffineFastState.compose env2841 (packedSelected [0,4,7,9,16] rootPS)) = affineNative (2^(11+1) ^^^ 1944) := by decide +kernel

theorem selectedBound2841 : packedSelected [0,4,7,9,16] rootPS < 2^1333 := by decide +kernel

def env2842 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1944,8192,1992,32768,65536,9293,41001,67106,32768,1945,8200,712,106505,8329,665,41001,1992,9244,41633,9225,4294967296,256,4295000713,9293,513]

theorem envBound2842 : H12AffineFastState.Bounded env2842 := by
  intro p hp
  have h : env2842.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2841_2842 : H12AffineEnvironment.transform 11 1944 env2841 = env2842 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env2841 == env2842) = true)

theorem identity2842 : scanCanonicalize (H12AffineFastState.compose env2842 (packedSelected [0,1,3,4,5,7,8,9,12,13,15,17,20] rootPS)) = affineNative (2^(12+1) ^^^ 268) := by decide +kernel

theorem selectedBound2842 : packedSelected [0,1,3,4,5,7,8,9,12,13,15,17,20] rootPS < 2^1333 := by decide +kernel

def env2843 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1944,268,1992,32768,65536,1345,33061,67106,32768,1945,260,712,98565,389,665,33061,1992,1296,33709,1285,4294967296,256,4295000713,1345,513]

theorem envBound2843 : H12AffineFastState.Bounded env2843 := by
  intro p hp
  have h : env2843.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2842_2843 : H12AffineEnvironment.transform 12 268 env2842 = env2843 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 268 env2842 == env2843) = true)

def env2844 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,10249,5457,230468,8329,67108864,67516748,67110224,67245392,1073741824,67245381,4294967296,67113985,4362845671,131072,513]

theorem envBound2844 : H12AffineFastState.Bounded env2844 := by
  intro p hp
  have h : env2844.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2773_2844 : H12AffineEnvironment.transform 13 4177 env2773 = env2844 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env2773 == env2844) = true)

theorem identity2844 : scanCanonicalize (H12AffineFastState.compose env2844 (packedSelected [1,3,4,5,8,9,10,16,19] rootPS)) = affineNative (2^(29+1) ^^^ 631939) := by decide +kernel

theorem selectedBound2844 : packedSelected [1,3,4,5,8,9,10,16,19] rootPS < 2^1333 := by decide +kernel

def env2845 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,10249,5457,230468,8329,67108864,67516748,67110224,67245392,631939,67245381,4294967296,67113985,4362845671,131072,513]

theorem envBound2845 : H12AffineFastState.Bounded env2845 := by
  intro p hp
  have h : env2845.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2844_2845 : H12AffineEnvironment.transform 29 631939 env2844 = env2845 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 631939 env2844 == env2845) = true)

theorem identity2845 : scanCanonicalize (H12AffineFastState.compose env2845 (packedSelected [0,4,7,16,20,22] rootPS)) = affineNative (2^(25+1) ^^^ 528641) := by decide +kernel

theorem selectedBound2845 : packedSelected [0,4,7,16,20,22] rootPS < 2^1333 := by decide +kernel

def env2846 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,10249,5457,230468,8329,528641,927821,529489,656465,631939,656452,4294967296,525568,4295208166,131072,513]

theorem envBound2846 : H12AffineFastState.Bounded env2846 := by
  intro p hp
  have h : env2846.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2845_2846 : H12AffineEnvironment.transform 25 528641 env2845 = env2846 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 528641 env2845 == env2846) = true)

theorem identity2846 : scanCanonicalize (H12AffineFastState.compose env2846 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(18+1) ^^^ 1024) := by decide +kernel

theorem selectedBound2846 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env2847 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1024,32768,4097,10249,5457,230468,8329,5377,404557,4177,131153,106627,131140,4294967296,256,4295208166,131072,513]

theorem envBound2847 : H12AffineFastState.Bounded env2847 := by
  intro p hp
  have h : env2847.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2846_2847 : H12AffineEnvironment.transform 18 1024 env2846 = env2847 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env2846 == env2847) = true)

theorem identity2847 : scanCanonicalize (H12AffineFastState.compose env2847 (packedSelected [13,21] rootPS)) = affineNative (2^(16+1) ^^^ 4176) := by decide +kernel

theorem selectedBound2847 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env2848 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4176,262144,1024,32768,4097,10249,5457,103444,8329,5377,277533,4177,4097,106627,4116,4294967296,256,4295081142,4176,513]

theorem envBound2848 : H12AffineFastState.Bounded env2848 := by
  intro p hp
  have h : env2848.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2847_2848 : H12AffineEnvironment.transform 16 4176 env2847 = env2848 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4176 env2847 == env2848) = true)

theorem identity2848 : scanCanonicalize (H12AffineFastState.compose env2848 (packedSelected [13,17] rootPS)) = affineNative (2^(15+1) ^^^ 38047) := by decide +kernel

theorem selectedBound2848 : packedSelected [13,17] rootPS < 2^1333 := by decide +kernel

def env2849 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,38047,4176,262144,1024,32768,4097,10249,5457,139,8329,5377,277533,4177,4097,13340,4116,4294967296,256,4294977577,4176,513]

theorem envBound2849 : H12AffineFastState.Bounded env2849 := by
  intro p hp
  have h : env2849.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2848_2849 : H12AffineEnvironment.transform 15 38047 env2848 = env2849 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 38047 env2848 == env2849) = true)

theorem identity2849 : scanCanonicalize (H12AffineFastState.compose env2849 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(11+1) ^^^ 1944) := by decide +kernel

theorem selectedBound2849 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env2850 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,8192,1993,32768,33543,1992,262144,1024,32768,1945,10249,713,139,8329,665,273285,1993,1945,9092,1932,4294967296,256,4294977577,1992,513]

theorem envBound2850 : H12AffineFastState.Bounded env2850 := by
  intro p hp
  have h : env2850.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2849_2850 : H12AffineEnvironment.transform 11 1944 env2849 = env2850 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env2849 == env2850) = true)

theorem identity2850 : scanCanonicalize (H12AffineFastState.compose env2850 (packedSelected [0,2,4,6,11] rootPS)) = affineNative (2^(17+1) ^^^ 43048) := by decide +kernel

theorem selectedBound2850 : packedSelected [0,2,4,6,11] rootPS < 2^1333 := by decide +kernel

def env2851 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,8192,1993,32768,33543,1992,43048,1024,32768,1945,10249,713,139,8329,665,33709,1993,1945,9092,1932,4294967296,256,4294977577,1992,513]

theorem envBound2851 : H12AffineFastState.Bounded env2851 := by
  intro p hp
  have h : env2851.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2850_2851 : H12AffineEnvironment.transform 17 43048 env2850 = env2851 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43048 env2850 == env2851) = true)

theorem identity2851 : scanCanonicalize (H12AffineFastState.compose env2851 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(14+1) ^^^ 8864) := by decide +kernel

theorem selectedBound2851 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env2852 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,8192,1993,8864,8615,1992,2696,1024,8864,1945,10249,713,139,8329,665,8461,1993,1945,9092,1932,4294967296,256,4294977577,1992,513]

theorem envBound2852 : H12AffineFastState.Bounded env2852 := by
  intro p hp
  have h : env2852.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2851_2852 : H12AffineEnvironment.transform 14 8864 env2851 = env2852 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8864 env2851 == env2852) = true)

theorem identity2852 : scanCanonicalize (H12AffineFastState.compose env2852 (packedSelected [0,1,3,5,7,8] rootPS)) = affineNative (2^(12+1) ^^^ 2948) := by decide +kernel

theorem selectedBound2852 : packedSelected [0,1,3,5,7,8] rootPS < 2^1333 := by decide +kernel

def env2853 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,2948,1993,2340,2595,1992,2696,1024,2340,1945,909,713,139,2829,665,2697,1993,1945,2048,1932,4294967296,256,4294968237,1992,513]

theorem envBound2853 : H12AffineFastState.Bounded env2853 := by
  intro p hp
  have h : env2853.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2852_2853 : H12AffineEnvironment.transform 12 2948 env2852 = env2853 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2948 env2852 == env2853) = true)

def env2854 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,889442641,4294967296,872567889,4417151347,34359738368,33563272]

theorem envBound2854 : H12AffineFastState.Bounded env2854 := by
  intro p hp
  have h : env2854.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5_2854 : H12AffineEnvironment.transform 22 17665 env5 = env2854 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 22 17665 env5 == env2854) = true)

def env2855 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,134217728,67130624,536870912,1073741824,553878609,4294967296,537002321,4417151347,34359738368,33563272]

theorem envBound2855 : H12AffineFastState.Bounded env2855 := by
  intro p hp
  have h : env2855.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2854_2855 : H12AffineEnvironment.transform 27 67130624 env2854 = env2855 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 27 67130624 env2854 == env2855) = true)

def env2856 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,134217728,67130624,536870912,1073741824,553878609,4294967296,537002321,4417151347,694534144,33563272]

theorem envBound2856 : H12AffineFastState.Bounded env2856 := by
  intro p hp
  have h : env2856.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2855_2856 : H12AffineEnvironment.transform 34 694534144 env2855 = env2856 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 34 694534144 env2855 == env2856) = true)

def env2857 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,134217728,67130624,157794304,1073741824,140788817,4294967296,157663569,4417151347,131072,33563272]

theorem envBound2857 : H12AffineFastState.Bounded env2857 := by
  intro p hp
  have h : env2857.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2856_2857 : H12AffineEnvironment.transform 28 157794304 env2856 = env2857 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 28 157794304 env2856 == env2857) = true)

theorem identity2857 : scanCanonicalize (H12AffineFastState.compose env2857 (packedSelected [14] rootPS)) = affineNative (2^(26+1) ^^^ 73814292) := by decide +kernel

theorem selectedBound2857 : packedSelected [14] rootPS < 2^1333 := by decide +kernel

def env2858 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,73814292,67130624,83988756,1073741824,67245381,4294967296,84119621,4417151347,131072,33563272]

theorem envBound2858 : H12AffineFastState.Bounded env2858 := by
  intro p hp
  have h : env2858.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2857_2858 : H12AffineEnvironment.transform 26 73814292 env2857 = env2858 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 73814292 env2857 == env2858) = true)

def env2859 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,5376,6702100,16384,16876564,1073741824,131141,4294967296,17007941,4350047347,131072,33563272]

theorem envBound2859 : H12AffineFastState.Bounded env2859 := by
  intro p hp
  have h : env2859.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2858_2859 : H12AffineEnvironment.transform 25 5376 env2858 = env2859 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env2858 == env2859) = true)

theorem identity2859 : scanCanonicalize (H12AffineFastState.compose env2859 (packedSelected [35] rootPS)) = affineNative (2^(23+1) ^^^ 230469) := by decide +kernel

theorem selectedBound2859 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env2860 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,230469,33554432,5376,6702100,16384,131153,1073741824,131141,4294967296,256,4333498422,131072,33563272]

theorem envBound2860 : H12AffineFastState.Bounded env2860 := by
  intro p hp
  have h : env2860.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2859_2860 : H12AffineEnvironment.transform 23 230469 env2859 = env2860 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230469 env2859 == env2860) = true)

def env2861 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,10248,17665,230469,33554432,5376,2518044,16384,131153,1073741824,131141,4294967296,256,4329297982,131072,33563272]

theorem envBound2861 : H12AffineFastState.Bounded env2861 := by
  intro p hp
  have h : env2861.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2860_2861 : H12AffineEnvironment.transform 21 10248 env2860 = env2861 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10248 env2860 == env2861) = true)

def env2862 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8832,65536,131072,262144,524288,8832,2097152,10248,17665,206533,33554432,5376,2518044,16384,131153,1073741824,131141,4294967296,256,4329274046,131072,33563272]

theorem envBound2862 : H12AffineFastState.Bounded env2862 := by
  intro p hp
  have h : env2862.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2861_2862 : H12AffineEnvironment.transform 14 8832 env2861 = env2862 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8832 env2861 == env2862) = true)

def env2863 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,131072,262144,524288,8832,2097152,8200,17665,206533,33554432,5376,2515996,16384,131153,1073741824,131141,4294967296,256,4329271998,131072,33563272]

theorem envBound2863 : H12AffineFastState.Bounded env2863 := by
  intro p hp
  have h : env2863.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2862_2863 : H12AffineEnvironment.transform 10 0 env2862 = env2863 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env2862 == env2863) = true)

theorem identity2863 : scanCanonicalize (H12AffineFastState.compose env2863 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 33972392) := by decide +kernel

theorem selectedBound2863 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env2864 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,131072,262144,524288,8832,2097152,8200,17665,206533,33554432,5376,2515996,16384,131153,33972392,131141,4294967296,256,4329271998,131072,33563272]

theorem envBound2864 : H12AffineFastState.Bounded env2864 := by
  intro p hp
  have h : env2864.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2863_2864 : H12AffineEnvironment.transform 29 33972392 env2863 = env2864 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 33972392 env2863 == env2864) = true)

def env2865 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,131072,0,524288,8832,2097152,8200,17665,206533,33554432,5376,2253852,16384,131153,33710248,131141,4294967296,256,4329271998,131072,33563272]

theorem envBound2865 : H12AffineFastState.Bounded env2865 := by
  intro p hp
  have h : env2865.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2864_2865 : H12AffineEnvironment.transform 17 0 env2864 = env2865 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env2864 == env2865) = true)

def env2866 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1344,0,524288,8832,2097152,8200,17665,74629,33554432,5376,2122076,16384,1297,33580520,1285,4294967296,256,4329142270,1344,33563272]

theorem envBound2866 : H12AffineFastState.Bounded env2866 := by
  intro p hp
  have h : env2866.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2865_2866 : H12AffineEnvironment.transform 16 1344 env2865 = env2866 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env2865 == env2866) = true)

theorem identity2866 : scanCanonicalize (H12AffineFastState.compose env2866 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound2866 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env2867 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1344,0,524288,8832,4096,8200,17665,74629,33554432,5376,29020,16384,1297,33580520,1285,4294967296,256,4329142270,1344,33563272]

theorem envBound2867 : H12AffineFastState.Bounded env2867 := by
  intro p hp
  have h : env2867.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2866_2867 : H12AffineEnvironment.transform 20 4096 env2866 = env2867 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env2866 == env2867) = true)

theorem identity2867 : scanCanonicalize (H12AffineFastState.compose env2867 (packedSelected [20] rootPS)) = affineNative (2^(12+1) ^^^ 5780) := by decide +kernel

theorem selectedBound2867 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env2868 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,5780,16384,5140,65536,1344,0,524288,5140,4096,5788,17665,70929,33554432,5376,18376,16384,1297,33575804,1285,4294967296,256,4329128298,1344,33559580]

theorem envBound2868 : H12AffineFastState.Bounded env2868 := by
  intro p hp
  have h : env2868.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2867_2868 : H12AffineEnvironment.transform 12 5780 env2867 = env2868 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5780 env2867 == env2868) = true)

theorem identity2868 : scanCanonicalize (H12AffineFastState.compose env2868 (packedSelected [5,8,12,13,15,17,24,28] rootPS)) = affineNative (2^(24+1) ^^^ 5301) := by decide +kernel

theorem selectedBound2868 : packedSelected [5,8,12,13,15,17,24,28] rootPS < 2^1333 := by decide +kernel

def env2869 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,5780,16384,5140,65536,1344,0,524288,5140,4096,5788,17665,70929,5301,5376,18376,16384,1297,18377,1285,4294967296,256,4295579103,1344,169]

theorem envBound2869 : H12AffineFastState.Bounded env2869 := by
  intro p hp
  have h : env2869.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2868_2869 : H12AffineEnvironment.transform 24 5301 env2868 = env2869 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 5301 env2868 == env2869) = true)

theorem identity2869 : scanCanonicalize (H12AffineFastState.compose env2869 (packedSelected [1,6,9,16,17,18,21,22,23,24,25] rootPS)) = affineNative (2^(13+1) ^^^ 4209) := by decide +kernel

theorem selectedBound2869 : packedSelected [1,6,9,16,17,18,21,22,23,24,25] rootPS < 2^1333 := by decide +kernel

def env2870 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,5780,4209,5140,65536,1344,0,524288,5140,4096,5788,5488,70929,5301,5376,6073,4209,1297,6072,1285,4294967296,256,4295558574,1344,169]

theorem envBound2870 : H12AffineFastState.Bounded env2870 := by
  intro p hp
  have h : env2870.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2869_2870 : H12AffineEnvironment.transform 13 4209 env2869 = env2870 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4209 env2869 == env2870) = true)

theorem identity2870 : scanCanonicalize (H12AffineFastState.compose env2870 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound2870 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env2871 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,5149,4209,5140,65536,1344,0,524288,5140,4096,5141,5488,70929,5301,5376,5424,4209,1297,5425,1285,4294967296,256,4295558574,1344,169]

theorem envBound2871 : H12AffineFastState.Bounded env2871 := by
  intro p hp
  have h : env2871.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2870_2871 : H12AffineEnvironment.transform 8 137 env2870 = env2871 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env2870 == env2871) = true)

def env2872 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,0,524288,8832,2097152,8200,17665,74628,33554432,5376,2122077,16384,1296,33580521,1284,4294967296,256,4329142271,1345,33563272]

theorem envBound2872 : H12AffineFastState.Bounded env2872 := by
  intro p hp
  have h : env2872.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2865_2872 : H12AffineEnvironment.transform 16 1345 env2865 = env2872 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env2865 == env2872) = true)

theorem identity2872 : scanCanonicalize (H12AffineFastState.compose env2872 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 2647256) := by decide +kernel

theorem selectedBound2872 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env2873 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,0,524288,8832,2097152,8200,17665,74628,2647256,5376,2122077,16384,1296,2621745,1284,4294967296,256,4297134887,1345,2639440]

theorem envBound2873 : H12AffineFastState.Bounded env2873 := by
  intro p hp
  have h : env2873.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2872_2873 : H12AffineEnvironment.transform 24 2647256 env2872 = env2873 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 2647256 env2872 == env2873) = true)

theorem identity2873 : scanCanonicalize (H12AffineFastState.compose env2873 (packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS)) = affineNative (2^(18+1) ^^^ 82786) := by decide +kernel

theorem selectedBound2873 : packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS < 2^1333 := by decide +kernel

def env2874 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,0,82786,8832,2097152,8200,17665,74628,2172858,5376,2122077,16384,1296,2179667,1284,4294967296,256,4297134887,1345,2164018]

theorem envBound2874 : H12AffineFastState.Bounded env2874 := by
  intro p hp
  have h : env2874.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2873_2874 : H12AffineEnvironment.transform 18 82786 env2873 = env2874 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 82786 env2873 == env2874) = true)

theorem identity2874 : scanCanonicalize (H12AffineFastState.compose env2874 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound2874 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env2875 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,0,82786,8832,4096,8200,17665,74628,79802,5376,29021,16384,1296,86611,1284,4294967296,256,4295033639,1345,70962]

theorem envBound2875 : H12AffineFastState.Bounded env2875 := by
  intro p hp
  have h : env2875.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2874_2875 : H12AffineEnvironment.transform 20 4096 env2874 = env2875 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env2874 == env2875) = true)

theorem identity2875 : scanCanonicalize (H12AffineFastState.compose env2875 (packedSelected [20] rootPS)) = affineNative (2^(12+1) ^^^ 900) := by decide +kernel

theorem selectedBound2875 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env2876 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,900,16384,260,65536,1345,0,82786,260,4096,908,17665,65536,70718,5376,21209,16384,1296,86611,1284,4294967296,256,4295033639,1345,70962]

theorem envBound2876 : H12AffineFastState.Bounded env2876 := by
  intro p hp
  have h : env2876.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2875_2876 : H12AffineEnvironment.transform 12 900 env2875 = env2876 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 900 env2875 == env2876) = true)

theorem identity2876 : scanCanonicalize (H12AffineFastState.compose env2876 (packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS)) = affineNative (2^(13+1) ^^^ 4857) := by decide +kernel

theorem selectedBound2876 : packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS < 2^1333 := by decide +kernel

def env2877 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,900,4857,260,65536,1345,0,70043,260,4096,908,6136,65536,70718,5376,32,4857,1296,65706,1284,4294967296,256,4295033639,1345,70962]

theorem envBound2877 : H12AffineFastState.Bounded env2877 := by
  intro p hp
  have h : env2877.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2876_2877 : H12AffineEnvironment.transform 13 4857 env2876 = env2877 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4857 env2876 == env2877) = true)

theorem identity2877 : scanCanonicalize (H12AffineFastState.compose env2877 (packedSelected [3,12,13,15,16,18,21,24] rootPS)) = affineNative (2^(11+1) ^^^ 1976) := by decide +kernel

theorem selectedBound2877 : packedSelected [3,12,13,15,16,18,21,24] rootPS < 2^1333 := by decide +kernel

def env2878 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1976,900,1345,260,65536,1345,0,67107,260,1976,908,64,65536,66438,696,32,1345,1296,65706,1284,4294967296,256,4295033639,1345,66186]

theorem envBound2878 : H12AffineFastState.Bounded env2878 := by
  intro p hp
  have h : env2878.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2877_2878 : H12AffineEnvironment.transform 11 1976 env2877 = env2878 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1976 env2877 == env2878) = true)

theorem identity2878 : scanCanonicalize (H12AffineFastState.compose env2878 (packedSelected [0,4,5,7,8,9,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 431) := by decide +kernel

theorem selectedBound2878 : packedSelected [0,4,5,7,8,9,12,15] rootPS < 2^1333 := by decide +kernel

def env2879 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1976,900,1345,260,431,1345,0,1932,260,1976,908,64,431,553,696,32,1345,1296,261,1284,4294967296,256,4294967944,1345,805]

theorem envBound2879 : H12AffineFastState.Bounded env2879 := by
  intro p hp
  have h : env2879.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2878_2879 : H12AffineEnvironment.transform 15 431 env2878 = env2879 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 431 env2878 == env2879) = true)

theorem identity2879 : scanCanonicalize (H12AffineFastState.compose env2879 (packedSelected [0,1,7,8,10,12] rootPS)) = affineNative (2^(8+1) ^^^ 429) := by decide +kernel

theorem selectedBound2879 : packedSelected [0,1,7,8,10,12] rootPS < 2^1333 := by decide +kernel

def env2880 : List Nat := [2,4,8,16,32,64,128,256,429,1024,0,1045,41,1345,260,431,1345,0,1057,260,1045,33,64,431,388,277,32,1345,1296,261,1284,4294967296,256,4294967589,1345,136]

theorem envBound2880 : H12AffineFastState.Bounded env2880 := by
  intro p hp
  have h : env2880.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2879_2880 : H12AffineEnvironment.transform 8 429 env2879 = env2880 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 429 env2879 == env2880) = true)

theorem identity2880 : scanCanonicalize (H12AffineFastState.compose env2880 (packedSelected [5,8] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound2880 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env2881 : List Nat := [2,4,8,16,32,64,128,36,137,1024,0,1045,41,1125,32,139,1125,0,1057,32,1045,33,64,139,160,49,32,1125,1076,33,1056,4294967296,36,4294967297,1125,136]

theorem envBound2881 : H12AffineFastState.Bounded env2881 := by
  intro p hp
  have h : env2881.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2880_2881 : H12AffineEnvironment.transform 7 36 env2880 = env2881 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env2880 == env2881) = true)

def env2882 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,131072,1,524288,8832,2097152,8200,17665,206533,33554432,5376,2253853,16384,131153,33710249,131141,4294967296,256,4329271998,131072,33563272]

theorem envBound2882 : H12AffineFastState.Bounded env2882 := by
  intro p hp
  have h : env2882.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2864_2882 : H12AffineEnvironment.transform 17 1 env2864 = env2882 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env2864 == env2882) = true)

def env2883 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1344,1,524288,8832,2097152,8200,17665,74629,33554432,5376,2122077,16384,1297,33580521,1285,4294967296,256,4329142270,1344,33563272]

theorem envBound2883 : H12AffineFastState.Bounded env2883 := by
  intro p hp
  have h : env2883.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2882_2883 : H12AffineEnvironment.transform 16 1344 env2882 = env2883 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env2882 == env2883) = true)

theorem identity2883 : scanCanonicalize (H12AffineFastState.compose env2883 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound2883 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env2884 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1344,1,524288,8832,4096,8200,17665,74629,33554432,5376,29021,16384,1297,33580521,1285,4294967296,256,4329142270,1344,33563272]

theorem envBound2884 : H12AffineFastState.Bounded env2884 := by
  intro p hp
  have h : env2884.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2883_2884 : H12AffineEnvironment.transform 20 4096 env2883 = env2884 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env2883 == env2884) = true)

theorem identity2884 : scanCanonicalize (H12AffineFastState.compose env2884 (packedSelected [20] rootPS)) = affineNative (2^(13+1) ^^^ 1992) := by decide +kernel

theorem selectedBound2884 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env2885 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,1992,8832,65536,1344,1,524288,8832,4096,8200,713,74629,33554432,5376,13973,1992,1297,33563169,1285,4294967296,256,4329123894,1344,33563272]

theorem envBound2885 : H12AffineFastState.Bounded env2885 := by
  intro p hp
  have h : env2885.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2884_2885 : H12AffineEnvironment.transform 13 1992 env2884 = env2885 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1992 env2884 == env2885) = true)

theorem identity2885 : scanCanonicalize (H12AffineFastState.compose env2885 (packedSelected [5,8,12,13,15,17,24,28] rootPS)) = affineNative (2^(24+1) ^^^ 5300) := by decide +kernel

theorem selectedBound2885 : packedSelected [5,8,12,13,15,17,24,28] rootPS < 2^1333 := by decide +kernel

def env2886 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,1992,8832,65536,1344,1,524288,8832,4096,8200,713,74629,5300,5376,13973,1992,1297,13973,1285,4294967296,256,4295566466,1344,13884]

theorem envBound2886 : H12AffineFastState.Bounded env2886 := by
  intro p hp
  have h : env2886.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2885_2886 : H12AffineEnvironment.transform 24 5300 env2885 = env2886 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 5300 env2885 == env2886) = true)

theorem identity2886 : scanCanonicalize (H12AffineFastState.compose env2886 (packedSelected [0,9,22,23,27] rootPS)) = affineNative (2^(11+1) ^^^ 1328) := by decide +kernel

theorem selectedBound2886 : packedSelected [0,9,22,23,27] rootPS < 2^1333 := by decide +kernel

def env2887 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1328,8192,1992,8832,65536,1344,1,524288,8832,1328,8200,713,74629,388,48,9125,1992,1297,9125,1285,4294967296,256,4295566466,1344,8972]

theorem envBound2887 : H12AffineFastState.Bounded env2887 := by
  intro p hp
  have h : env2887.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2886_2887 : H12AffineEnvironment.transform 11 1328 env2886 = env2887 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1328 env2886 == env2887) = true)

theorem identity2887 : scanCanonicalize (H12AffineFastState.compose env2887 (packedSelected [9,18,22,23] rootPS)) = affineNative (2^(12+1) ^^^ 900) := by decide +kernel

theorem selectedBound2887 : packedSelected [9,18,22,23] rootPS < 2^1333 := by decide +kernel

def env2888 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1328,900,1992,260,65536,1344,1,524288,260,1328,908,713,65537,388,48,33,1992,1297,33,1285,4294967296,256,4295558918,1344,136]

theorem envBound2888 : H12AffineFastState.Bounded env2888 := by
  intro p hp
  have h : env2888.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2887_2888 : H12AffineEnvironment.transform 12 900 env2887 = env2888 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 900 env2887 == env2888) = true)

theorem identity2888 : scanCanonicalize (H12AffineFastState.compose env2888 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound2888 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env2889 : List Nat := [2,4,8,16,1,64,128,256,512,1024,0,1297,900,1992,260,65536,1344,1,524288,260,1297,908,713,65537,388,17,0,1992,1297,0,1285,4294967296,256,4295558918,1344,136]

theorem envBound2889 : H12AffineFastState.Bounded env2889 := by
  intro p hp
  have h : env2889.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2888_2889 : H12AffineEnvironment.transform 4 1 env2888 = env2889 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env2888 == env2889) = true)

theorem identity2889 : scanCanonicalize (H12AffineFastState.compose env2889 (packedSelected [1,8,13] rootPS)) = affineNative (2^(18+1) ^^^ 66699) := by decide +kernel

theorem selectedBound2889 : packedSelected [1,8,13] rootPS < 2^1333 := by decide +kernel

def env2890 : List Nat := [2,4,8,16,1,64,128,256,512,1024,0,1297,900,1992,260,65536,1344,1,66699,260,1297,908,713,65537,388,17,0,1992,1297,0,1285,4294967296,256,4294968205,1344,136]

theorem envBound2890 : H12AffineFastState.Bounded env2890 := by
  intro p hp
  have h : env2890.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2889_2890 : H12AffineEnvironment.transform 18 66699 env2889 = env2890 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 66699 env2889 == env2890) = true)

theorem identity2890 : scanCanonicalize (H12AffineFastState.compose env2890 (packedSelected [1,10,15] rootPS)) = affineNative (2^(7+1) ^^^ 220) := by decide +kernel

theorem selectedBound2890 : packedSelected [1,10,15] rootPS < 2^1333 := by decide +kernel

def env2891 : List Nat := [2,4,8,16,1,64,128,220,512,1024,0,1229,600,1556,216,65536,1180,1,66699,216,1229,592,713,65537,88,17,0,1556,1229,0,1241,4294967296,220,4294967889,1180,136]

theorem envBound2891 : H12AffineFastState.Bounded env2891 := by
  intro p hp
  have h : env2891.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2890_2891 : H12AffineEnvironment.transform 7 220 env2890 = env2891 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 220 env2890 == env2891) = true)

theorem identity2891 : scanCanonicalize (H12AffineFastState.compose env2891 (packedSelected [16] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound2891 : packedSelected [16] rootPS < 2^1333 := by decide +kernel

def env2892 : List Nat := [2,4,8,16,1,64,128,220,137,1024,0,1229,209,1181,216,65536,1180,1,66699,216,1229,217,64,65537,88,17,0,1181,1229,0,1241,4294967296,220,4294967512,1180,136]

theorem envBound2892 : H12AffineFastState.Bounded env2892 := by
  intro p hp
  have h : env2892.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2891_2892 : H12AffineEnvironment.transform 8 137 env2891 = env2892 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env2891 == env2892) = true)

theorem identity2892 : scanCanonicalize (H12AffineFastState.compose env2892 (packedSelected [1,2,3,4] rootPS)) = affineNative (2^(15+1) ^^^ 138) := by decide +kernel

theorem selectedBound2892 : packedSelected [1,2,3,4] rootPS < 2^1333 := by decide +kernel

def env2893 : List Nat := [2,4,8,16,1,64,128,220,137,1024,0,1229,209,1181,216,138,1180,1,1025,216,1229,217,64,139,88,17,0,1181,1229,0,1241,4294967296,220,4294967512,1180,136]

theorem envBound2893 : H12AffineFastState.Bounded env2893 := by
  intro p hp
  have h : env2893.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2892_2893 : H12AffineEnvironment.transform 15 138 env2892 = env2893 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 138 env2892 == env2893) = true)

theorem identity2893 : scanCanonicalize (H12AffineFastState.compose env2893 (packedSelected [0,1] rootPS)) = affineNative (2^(5+1) ^^^ 0) := by decide +kernel

theorem selectedBound2893 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env2894 : List Nat := [2,4,8,16,1,0,128,156,137,1024,0,1165,145,1181,152,138,1180,1,1025,152,1165,153,0,139,24,17,0,1181,1165,0,1177,4294967296,156,4294967448,1180,136]

theorem envBound2894 : H12AffineFastState.Bounded env2894 := by
  intro p hp
  have h : env2894.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2893_2894 : H12AffineEnvironment.transform 5 0 env2893 = env2894 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env2893 == env2894) = true)

theorem identity2894 : scanCanonicalize (H12AffineFastState.compose env2894 (packedSelected [0,3] rootPS)) = affineNative (2^(6+1) ^^^ 25) := by decide +kernel

theorem selectedBound2894 : packedSelected [0,3] rootPS < 2^1333 := by decide +kernel

def env2895 : List Nat := [2,4,8,16,1,0,25,5,16,1024,0,1044,8,1028,1,19,1029,1,1025,1,1044,0,0,18,24,17,0,1028,1044,0,1024,4294967296,5,4294967297,1029,17]

theorem envBound2895 : H12AffineFastState.Bounded env2895 := by
  intro p hp
  have h : env2895.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2894_2895 : H12AffineEnvironment.transform 6 25 env2894 = env2895 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 25 env2894 == env2895) = true)

theorem identity2895 : scanCanonicalize (H12AffineFastState.compose env2895 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 11) := by decide +kernel

theorem selectedBound2895 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2896 : List Nat := [2,4,8,16,1,0,25,5,16,1024,0,1044,8,1028,1,19,1029,1,1025,1,1044,0,0,18,24,17,0,1028,1044,0,1024,11,5,10,1029,17]

theorem envBound2896 : H12AffineFastState.Bounded env2896 := by
  intro p hp
  have h : env2896.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2895_2896 : H12AffineEnvironment.transform 31 11 env2895 = env2896 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 11 env2895 == env2896) = true)

def leafEnv2896 : List Nat := [2,4,8,16,1,0,25,5,16,1024,0,1044,8,1028,1,19,1029,1,1025,1,1044,0,0,18,1025,24,1,17,0,1028,1044,0,1024,11,5,10,4,2,1029,17,0,1044,1]

def active2896 : List Nat := [0,1,2,3,9]

def tree2896 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2896 : H12WitnessSearch.Good tree2896 := H12GlobalWitnessIndex.good

theorem leafIdentity2896 : H12AffineFastState.composeSystem env2896 rootObs = leafEnv2896 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2896 rootObs == leafEnv2896) = true)

theorem terminalChecked2896 : H12PackedTerminal.terminalCheckFast leafEnv2896 active2896 tree2896 = true := by decide +kernel

def env2897 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,1,524288,8832,2097152,8200,17665,74628,33554432,5376,2122076,16384,1296,33580520,1284,4294967296,256,4329142271,1345,33563272]

theorem envBound2897 : H12AffineFastState.Bounded env2897 := by
  intro p hp
  have h : env2897.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2882_2897 : H12AffineEnvironment.transform 16 1345 env2882 = env2897 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env2882 == env2897) = true)

theorem identity2897 : scanCanonicalize (H12AffineFastState.compose env2897 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 2647256) := by decide +kernel

theorem selectedBound2897 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env2898 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,1,524288,8832,2097152,8200,17665,74628,2647256,5376,2122076,16384,1296,2621744,1284,4294967296,256,4297134887,1345,2639440]

theorem envBound2898 : H12AffineFastState.Bounded env2898 := by
  intro p hp
  have h : env2898.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2897_2898 : H12AffineEnvironment.transform 24 2647256 env2897 = env2898 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 2647256 env2897 == env2898) = true)

theorem identity2898 : scanCanonicalize (H12AffineFastState.compose env2898 (packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS)) = affineNative (2^(18+1) ^^^ 82787) := by decide +kernel

theorem selectedBound2898 : packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS < 2^1333 := by decide +kernel

def env2899 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,1,82787,8832,2097152,8200,17665,74628,2172859,5376,2122076,16384,1296,2179667,1284,4294967296,256,4297134887,1345,2164019]

theorem envBound2899 : H12AffineFastState.Bounded env2899 := by
  intro p hp
  have h : env2899.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2898_2899 : H12AffineEnvironment.transform 18 82787 env2898 = env2899 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 82787 env2898 == env2899) = true)

theorem identity2899 : scanCanonicalize (H12AffineFastState.compose env2899 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound2899 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env2900 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,1,82787,8832,4096,8200,17665,74628,79803,5376,29020,16384,1296,86611,1284,4294967296,256,4295033639,1345,70963]

theorem envBound2900 : H12AffineFastState.Bounded env2900 := by
  intro p hp
  have h : env2900.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2899_2900 : H12AffineEnvironment.transform 20 4096 env2899 = env2900 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env2899 == env2900) = true)

theorem identity2900 : scanCanonicalize (H12AffineFastState.compose env2900 (packedSelected [20] rootPS)) = affineNative (2^(13+1) ^^^ 4825) := by decide +kernel

theorem selectedBound2900 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env2901 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4825,8832,65536,1345,1,70074,8832,4096,8200,6104,74628,79803,5376,9093,4825,1296,65674,1284,4294967296,256,4295033639,1345,70963]

theorem envBound2901 : H12AffineFastState.Bounded env2901 := by
  intro p hp
  have h : env2901.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2900_2901 : H12AffineEnvironment.transform 13 4825 env2900 = env2901 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4825 env2900 == env2901) = true)

theorem identity2901 : scanCanonicalize (H12AffineFastState.compose env2901 (packedSelected [1,3,8,10,12,17] rootPS)) = affineNative (2^(12+1) ^^^ 5359) := by decide +kernel

theorem selectedBound2901 : packedSelected [1,3,8,10,12,17] rootPS < 2^1333 := by decide +kernel

def env2902 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,5359,4825,5743,65536,1345,1,70074,5743,4096,5351,6104,71531,66388,5376,5994,4825,1296,65674,1284,4294967296,256,4295033639,1345,70963]

theorem envBound2902 : H12AffineFastState.Bounded env2902 := by
  intro p hp
  have h : env2902.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2901_2902 : H12AffineEnvironment.transform 12 5359 env2901 = env2902 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5359 env2901 == env2902) = true)

theorem identity2902 : scanCanonicalize (H12AffineFastState.compose env2902 (packedSelected [1,3,5,13,15,19] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound2902 : packedSelected [1,3,5,13,15,19] rootPS < 2^1333 := by decide +kernel

def env2903 : List Nat := [2,4,8,16,32,64,128,37,512,1024,0,4096,5359,4825,5743,65536,1124,1,69791,5743,4096,5351,5885,71246,66161,5157,5711,4825,1077,65674,1057,4294967296,37,4295033346,1124,70678]

theorem envBound2903 : H12AffineFastState.Bounded env2903 := by
  intro p hp
  have h : env2903.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2902_2903 : H12AffineEnvironment.transform 7 37 env2902 = env2903 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env2902 == env2903) = true)

theorem identity2903 : scanCanonicalize (H12AffineFastState.compose env2903 (packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound2903 : packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS < 2^1333 := by decide +kernel

def env2904 : List Nat := [2,4,8,16,1,64,128,4,512,1024,0,4096,5326,4825,5710,65536,1093,1,69791,5710,4096,5318,5852,71246,66128,5124,5711,4825,1044,65674,1024,4294967296,4,4295033346,1093,70678]

theorem envBound2904 : H12AffineFastState.Bounded env2904 := by
  intro p hp
  have h : env2904.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2903_2904 : H12AffineEnvironment.transform 4 1 env2903 = env2904 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env2903 == env2904) = true)

theorem identity2904 : scanCanonicalize (H12AffineFastState.compose env2904 (packedSelected [0,2,4,5,6,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 138) := by decide +kernel

theorem selectedBound2904 : packedSelected [0,2,4,5,6,12,15] rootPS < 2^1333 := by decide +kernel

def env2905 : List Nat := [2,4,8,16,1,64,128,4,512,1024,0,4096,5326,4825,5710,138,1093,1,4117,5710,4096,5318,5852,5828,730,5124,5711,4825,1044,0,1024,4294967296,4,4294967944,1093,5276]

theorem envBound2905 : H12AffineFastState.Bounded env2905 := by
  intro p hp
  have h : env2905.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2904_2905 : H12AffineEnvironment.transform 15 138 env2904 = env2905 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 138 env2904 == env2905) = true)

theorem identity2905 : scanCanonicalize (H12AffineFastState.compose env2905 (packedSelected [0,1,2,3,6,8,9] rootPS)) = affineNative (2^(6+1) ^^^ 82) := by decide +kernel

theorem selectedBound2905 : packedSelected [0,1,2,3,6,8,9] rootPS < 2^1333 := by decide +kernel

def env2906 : List Nat := [2,4,8,16,1,64,82,4,512,1024,0,4096,5148,4619,5710,88,1093,1,4117,5710,4096,5140,5646,5654,520,5124,5711,4619,1044,0,1024,4294967296,4,4294967898,1093,5198]

theorem envBound2906 : H12AffineFastState.Bounded env2906 := by
  intro p hp
  have h : env2906.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2905_2906 : H12AffineEnvironment.transform 6 82 env2905 = env2906 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 82 env2905 == env2906) = true)

theorem identity2906 : scanCanonicalize (H12AffineFastState.compose env2906 (packedSelected [1,2,3,4,5,6,7] rootPS)) = affineNative (2^(8+1) ^^^ 90) := by decide +kernel

theorem selectedBound2906 : packedSelected [1,2,3,4,5,6,7] rootPS < 2^1333 := by decide +kernel

def env2907 : List Nat := [2,4,8,16,1,64,82,4,90,1024,0,4096,5148,4177,5140,88,1093,1,4117,5140,4096,5140,5204,5196,82,5124,5141,4177,1044,0,1024,4294967296,4,4294967296,1093,5198]

theorem envBound2907 : H12AffineFastState.Bounded env2907 := by
  intro p hp
  have h : env2907.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2906_2907 : H12AffineEnvironment.transform 8 90 env2906 = env2907 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 90 env2906 == env2907) = true)

theorem identity2907 : scanCanonicalize (H12AffineFastState.compose env2907 (packedSelected [2] rootPS)) = affineNative (2^(31+1) ^^^ 5141) := by decide +kernel

theorem selectedBound2907 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2908 : List Nat := [2,4,8,16,1,64,82,4,90,1024,0,4096,5148,4177,5140,88,1093,1,4117,5140,4096,5140,5204,5196,82,5124,5141,4177,1044,0,1024,5141,4,5141,1093,5198]

theorem envBound2908 : H12AffineFastState.Bounded env2908 := by
  intro p hp
  have h : env2908.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2907_2908 : H12AffineEnvironment.transform 31 5141 env2907 = env2908 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 5141 env2907 == env2908) = true)

def env2909 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,131072,262144,524288,8832,2097152,8201,17665,206533,33554432,5376,2515997,16384,131153,1073741824,131141,4294967296,256,4329271999,131072,33563272]

theorem envBound2909 : H12AffineFastState.Bounded env2909 := by
  intro p hp
  have h : env2909.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2862_2909 : H12AffineEnvironment.transform 10 1 env2862 = env2909 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env2862 == env2909) = true)

theorem identity2909 : scanCanonicalize (H12AffineFastState.compose env2909 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 2228953) := by decide +kernel

theorem selectedBound2909 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

end H12GlobalChart2
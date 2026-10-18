import H12GlobalChart2Data030

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem selectedBound7580 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7581 : List Nat := [2,4,8,0,10,0,9,5,0,1024,1,1028,9,1029,11,8,1029,1,1025,11,1029,0,0,2,9,0,0,1028,1029,1,1025,11,4,1,1028,1]

theorem envBound7581 : H12AffineFastState.Bounded env7581 := by
  intro p hp
  have h : env7581.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7580_7581 : H12AffineEnvironment.transform 3 0 env7580 = env7581 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7580 == env7581) = true)

def leafEnv7581 : List Nat := [2,4,8,0,10,0,9,5,0,1024,1,1028,9,1029,11,8,1029,1,1025,11,1029,0,0,2,1024,9,1,0,0,1028,1029,1,1025,11,4,1,5,9,1028,1,0,1028,1]

def active7581 : List Nat := [0,1,2,9]

def tree7581 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7581 : H12WitnessSearch.Good tree7581 := H12GlobalWitnessIndex.good

theorem leafIdentity7581 : H12AffineFastState.composeSystem env7581 rootObs = leafEnv7581 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7581 rootObs == leafEnv7581) = true)

theorem terminalChecked7581 : H12PackedTerminal.terminalCheckFast leafEnv7581 active7581 tree7581 = true := by decide +kernel

def env7582 : List Nat := [2,4,8,16,32,17,9,256,0,1024,1,1297,268,1297,292,34,1297,1,1025,292,1296,261,17,2,268,16,0,1296,1296,1,1284,271,257,42,1296,1]

theorem envBound7582 : H12AffineFastState.Bounded env7582 := by
  intro p hp
  have h : env7582.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7575_7582 : H12AffineEnvironment.transform 5 17 env7575 = env7582 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7575 == env7582) = true)

theorem identity7582 : scanCanonicalize (H12AffineFastState.compose env7582 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 31) := by decide +kernel

theorem selectedBound7582 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7583 : List Nat := [2,4,8,16,32,17,9,31,0,1024,1,1038,19,1038,59,34,1038,1,1025,59,1039,26,17,2,19,16,0,1039,1039,1,1051,16,30,42,1039,1]

theorem envBound7583 : H12AffineFastState.Bounded env7583 := by
  intro p hp
  have h : env7583.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7582_7583 : H12AffineEnvironment.transform 7 31 env7582 = env7583 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 31 env7582 == env7583) = true)

def env7584 : List Nat := [2,4,8,16,16,17,9,31,0,1024,1,1038,19,1038,11,18,1038,1,1025,11,1039,26,17,2,19,16,0,1039,1039,1,1051,16,30,26,1039,1]

theorem envBound7584 : H12AffineFastState.Bounded env7584 := by
  intro p hp
  have h : env7584.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7583_7584 : H12AffineEnvironment.transform 4 16 env7583 = env7584 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env7583 == env7584) = true)

theorem identity7584 : scanCanonicalize (H12AffineFastState.compose env7584 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound7584 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7585 : List Nat := [2,4,8,0,0,1,9,15,0,1024,1,1038,3,1038,11,2,1038,1,1025,11,1039,10,1,2,3,0,0,1039,1039,1,1035,0,14,10,1039,1]

theorem envBound7585 : H12AffineFastState.Bounded env7585 := by
  intro p hp
  have h : env7585.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7584_7585 : H12AffineEnvironment.transform 3 0 env7584 = env7585 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7584 == env7585) = true)

def leafEnv7585 : List Nat := [2,4,8,0,0,1,9,15,0,1024,1,1038,3,1038,11,2,1038,1,1025,11,1039,10,1,2,1034,3,1,0,0,1039,1039,1,1035,0,14,10,5,3,1039,1,0,1038,1]

def active7585 : List Nat := [0,1,2,9]

def tree7585 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7585 : H12WitnessSearch.Good tree7585 := H12GlobalWitnessIndex.good

theorem leafIdentity7585 : H12AffineFastState.composeSystem env7585 rootObs = leafEnv7585 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7585 rootObs == leafEnv7585) = true)

theorem terminalChecked7585 : H12PackedTerminal.terminalCheckFast leafEnv7585 active7585 tree7585 = true := by decide +kernel

def env7586 : List Nat := [2,4,8,16,17,17,9,31,0,1024,1,1038,19,1038,10,19,1038,1,1025,10,1039,26,17,2,19,16,0,1039,1039,1,1051,16,30,27,1039,1]

theorem envBound7586 : H12AffineFastState.Bounded env7586 := by
  intro p hp
  have h : env7586.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7583_7586 : H12AffineEnvironment.transform 4 17 env7583 = env7586 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env7583 == env7586) = true)

theorem identity7586 : scanCanonicalize (H12AffineFastState.compose env7586 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound7586 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7587 : List Nat := [2,4,8,11,10,10,9,4,0,1024,1,1038,8,1038,10,8,1038,1,1025,10,1039,1,10,2,8,11,0,1039,1039,1,1024,11,5,0,1039,1]

theorem envBound7587 : H12AffineFastState.Bounded env7587 := by
  intro p hp
  have h : env7587.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7586_7587 : H12AffineEnvironment.transform 3 11 env7586 = env7587 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env7586 == env7587) = true)

def leafEnv7587 : List Nat := [2,4,8,11,10,10,9,4,0,1024,1,1038,8,1038,10,8,1038,1,1025,10,1039,1,10,2,1025,8,1,11,0,1039,1039,1,1024,11,5,0,5,9,1039,1,0,1038,1]

def active7587 : List Nat := [0,1,2,9]

def tree7587 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7587 : H12WitnessSearch.Good tree7587 := H12GlobalWitnessIndex.good

theorem leafIdentity7587 : H12AffineFastState.composeSystem env7587 rootObs = leafEnv7587 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7587 rootObs == leafEnv7587) = true)

theorem terminalChecked7587 : H12PackedTerminal.terminalCheckFast leafEnv7587 active7587 tree7587 = true := by decide +kernel

def env7588 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4825,32768,65536,131072,262144,524288,32768,4097,8201,6105,230468,8329,5377,403141,4824,131152,0,131140,4294967296,257,4295729775,131073,513]

theorem envBound7588 : H12AffineFastState.Bounded env7588 := by
  intro p hp
  have h : env7588.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7517_7588 : H12AffineEnvironment.transform 13 4825 env7517 = env7588 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4825 env7517 == env7588) = true)

theorem identity7588 : scanCanonicalize (H12AffineFastState.compose env7588 (packedSelected [0,2,6,9,16] rootPS)) = affineNative (2^(16+1) ^^^ 99535) := by decide +kernel

theorem selectedBound7588 : packedSelected [0,2,6,9,16] rootPS < 2^1333 := by decide +kernel

def env7589 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4825,32768,65536,99535,262144,524288,32768,4097,8201,6105,139,8329,5377,369162,4824,99487,0,99467,4294967296,257,4295501472,99534,513]

theorem envBound7589 : H12AffineFastState.Bounded env7589 := by
  intro p hp
  have h : env7589.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7588_7589 : H12AffineEnvironment.transform 16 99535 env7588 = env7589 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 99535 env7588 == env7589) = true)

theorem identity7589 : scanCanonicalize (H12AffineFastState.compose env7589 (packedSelected [3,4,5,8,9,12,18,19,21,24] rootPS)) = affineNative (2^(18+1) ^^^ 1673) := by decide +kernel

theorem selectedBound7589 : packedSelected [3,4,5,8,9,12,18,19,21,24] rootPS < 2^1333 := by decide +kernel

def env7590 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4825,32768,65536,99535,262144,1673,32768,4097,8201,6105,139,8329,5377,369162,4824,99487,0,99467,4294967296,257,4294975529,99534,513]

theorem envBound7590 : H12AffineFastState.Bounded env7590 := by
  intro p hp
  have h : env7590.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7589_7590 : H12AffineEnvironment.transform 18 1673 env7589 = env7590 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1673 env7589 == env7590) = true)

theorem identity7590 : scanCanonicalize (H12AffineFastState.compose env7590 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 41482) := by decide +kernel

theorem selectedBound7590 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env7591 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4825,32768,41482,9925,262144,1673,32768,4097,8201,6105,139,8329,5377,262144,4824,9877,0,9857,4294967296,257,4294975529,9924,513]

theorem envBound7591 : H12AffineFastState.Bounded env7591 := by
  intro p hp
  have h : env7591.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7590_7591 : H12AffineEnvironment.transform 15 41482 env7590 = env7591 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 41482 env7590 == env7591) = true)

theorem identity7591 : scanCanonicalize (H12AffineFastState.compose env7591 (packedSelected [4,9,23,32] rootPS)) = affineNative (2^(17+1) ^^^ 41633) := by decide +kernel

theorem selectedBound7591 : packedSelected [4,9,23,32] rootPS < 2^1333 := by decide +kernel

def env7592 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4825,32768,41482,9925,41633,1673,32768,4097,8201,6105,139,8329,5377,41633,4824,9877,0,9857,4294967296,257,4294975529,9924,513]

theorem envBound7592 : H12AffineFastState.Bounded env7592 := by
  intro p hp
  have h : env7592.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7591_7592 : H12AffineEnvironment.transform 17 41633 env7591 = env7592 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41633 env7591 == env7592) = true)

def env7593 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,1993,32768,41482,9925,41633,1673,32768,1297,8201,713,139,8329,17,41633,1992,9877,0,9857,4294967296,257,4294975529,9924,513]

theorem envBound7593 : H12AffineFastState.Bounded env7593 := by
  intro p hp
  have h : env7593.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7592_7593 : H12AffineEnvironment.transform 11 1296 env7592 = env7593 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env7592 == env7593) = true)

theorem identity7593 : scanCanonicalize (H12AffineFastState.compose env7593 (packedSelected [4,9] rootPS)) = affineNative (2^(12+1) ^^^ 901) := by decide +kernel

theorem selectedBound7593 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env7594 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,901,1993,32768,33167,1344,33060,1673,32768,1297,908,713,139,780,17,33060,1992,1296,0,1284,4294967296,257,4294968236,1345,513]

theorem envBound7594 : H12AffineFastState.Bounded env7594 := by
  intro p hp
  have h : env7594.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7593_7594 : H12AffineEnvironment.transform 12 901 env7593 = env7594 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 901 env7593 == env7594) = true)

theorem identity7594 : scanCanonicalize (H12AffineFastState.compose env7594 (packedSelected [2,4] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound7594 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env7595 : List Nat := [2,4,8,16,32,64,9,256,512,1024,1,1296,780,1856,32768,33030,1344,33060,1536,32768,1297,773,576,2,780,17,33060,1857,1296,0,1284,4294967296,257,4294968101,1345,513]

theorem envBound7595 : H12AffineFastState.Bounded env7595 := by
  intro p hp
  have h : env7595.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7594_7595 : H12AffineEnvironment.transform 6 9 env7594 = env7595 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env7594 == env7595) = true)

theorem identity7595 : scanCanonicalize (H12AffineFastState.compose env7595 (packedSelected [1,3,5] rootPS)) = affineNative (2^(8+1) ^^^ 80) := by decide +kernel

theorem selectedBound7595 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env7596 : List Nat := [2,4,8,16,32,64,9,256,80,1024,1,1296,348,1296,32768,33030,1344,33060,1104,32768,1297,341,16,2,348,17,33060,1297,1296,0,1284,4294967296,257,4294967669,1345,81]

theorem envBound7596 : H12AffineFastState.Bounded env7596 := by
  intro p hp
  have h : env7596.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7595_7596 : H12AffineEnvironment.transform 8 80 env7595 = env7596 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 80 env7595 == env7596) = true)

theorem identity7596 : scanCanonicalize (H12AffineFastState.compose env7596 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 33119) := by decide +kernel

theorem selectedBound7596 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7597 : List Nat := [2,4,8,16,32,64,9,256,80,1024,1,1296,348,1296,32768,33030,1344,33060,1104,32768,1297,341,16,2,348,17,33060,1297,1296,0,1284,33119,257,32810,1345,81]

theorem envBound7597 : H12AffineFastState.Bounded env7597 := by
  intro p hp
  have h : env7597.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7596_7597 : H12AffineEnvironment.transform 31 33119 env7596 = env7597 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 33119 env7596 == env7597) = true)

def env7598 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,1992,32768,41482,9925,41633,1673,32768,1296,8201,712,139,8329,16,41633,1993,9877,0,9857,4294967296,257,4294975529,9924,513]

theorem envBound7598 : H12AffineFastState.Bounded env7598 := by
  intro p hp
  have h : env7598.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7592_7598 : H12AffineEnvironment.transform 11 1297 env7592 = env7598 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env7592 == env7598) = true)

theorem identity7598 : scanCanonicalize (H12AffineFastState.compose env7598 (packedSelected [1,5,13] rootPS)) = affineNative (2^(14+1) ^^^ 8233) := by decide +kernel

theorem selectedBound7598 : packedSelected [1,5,13] rootPS < 2^1333 := by decide +kernel

def env7599 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,1992,8233,547,9925,648,1673,8233,1296,8201,712,139,8329,16,648,1993,9877,0,9857,4294967296,257,4294975529,9924,513]

theorem envBound7599 : H12AffineFastState.Bounded env7599 := by
  intro p hp
  have h : env7599.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7598_7599 : H12AffineEnvironment.transform 14 8233 env7598 = env7599 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8233 env7598 == env7599) = true)

theorem identity7599 : scanCanonicalize (H12AffineFastState.compose env7599 (packedSelected [1,8,10] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound7599 : packedSelected [1,8,10] rootPS < 2^1333 := by decide +kernel

def env7600 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1297,8192,1345,8233,170,9292,1,1024,8233,1296,8201,65,139,8329,16,1,1344,9244,0,9224,4294967296,257,4294975529,9293,136]

theorem envBound7600 : H12AffineFastState.Bounded env7600 := by
  intro p hp
  have h : env7600.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7599_7600 : H12AffineEnvironment.transform 8 137 env7599 = env7600 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env7599 == env7600) = true)

theorem identity7600 : scanCanonicalize (H12AffineFastState.compose env7600 (packedSelected [0,7] rootPS)) = affineNative (2^(12+1) ^^^ 269) := by decide +kernel

theorem selectedBound7600 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env7601 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1297,269,1345,292,170,1345,1,1024,292,1296,260,65,139,388,16,1,1344,1297,0,1285,4294967296,257,4294967588,1344,136]

theorem envBound7601 : H12AffineFastState.Bounded env7601 := by
  intro p hp
  have h : env7601.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7600_7601 : H12AffineEnvironment.transform 12 269 env7600 = env7601 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 269 env7600 == env7601) = true)

def env7602 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,10249,17664,230468,33554432,2098432,2518045,2117632,131152,1073741824,131140,4294967296,257,4331391038,131073,33563272]

theorem envBound7602 : H12AffineFastState.Bounded env7602 := by
  intro p hp
  have h : env7602.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7360_7602 : H12AffineEnvironment.transform 21 10249 env7360 = env7602 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10249 env7360 == env7602) = true)

def env7603 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,10249,17664,230468,8328,2098432,2518045,2117632,131152,1073741824,131140,4294967296,257,4297844918,131073,512]

theorem envBound7603 : H12AffineFastState.Bounded env7603 := by
  intro p hp
  have h : env7603.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7602_7603 : H12AffineEnvironment.transform 24 8328 env7602 = env7603 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8328 env7602 == env7603) = true)

theorem identity7603 : scanCanonicalize (H12AffineFastState.compose env7603 (packedSelected [4,7,9,16,20,27] rootPS)) = affineNative (2^(29+1) ^^^ 2220243) := by decide +kernel

theorem selectedBound7603 : packedSelected [4,7,9,16,20,27] rootPS < 2^1333 := by decide +kernel

def env7604 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,10249,17664,230468,8328,2098432,2518045,2117632,131152,2220243,131140,4294967296,257,4297844918,131073,512]

theorem envBound7604 : H12AffineFastState.Bounded env7604 := by
  intro p hp
  have h : env7604.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7603_7604 : H12AffineEnvironment.transform 29 2220243 env7603 = env7604 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 2220243 env7603 == env7604) = true)

theorem identity7604 : scanCanonicalize (H12AffineFastState.compose env7604 (packedSelected [0,1,4,5,6,7,8,16,19,20,22,24,25,26] rootPS)) = affineNative (2^(20+1) ^^^ 57693) := by decide +kernel

theorem selectedBound7604 : packedSelected [0,1,4,5,6,7,8,16,19,20,22,24,25,26] rootPS < 2^1333 := by decide +kernel

def env7605 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,57693,10249,17664,230468,8328,58461,429376,45405,131152,65934,131140,4294967296,257,4295690731,131073,512]

theorem envBound7605 : H12AffineFastState.Bounded env7605 := by
  intro p hp
  have h : env7605.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7604_7605 : H12AffineEnvironment.transform 20 57693 env7604 = env7605 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 57693 env7604 == env7605) = true)

theorem identity7605 : scanCanonicalize (H12AffineFastState.compose env7605 (packedSelected [1,3,6,17,21,24,25,28] rootPS)) = affineNative (2^(14+1) ^^^ 8461) := by decide +kernel

theorem selectedBound7605 : packedSelected [1,3,6,17,21,24,25,28] rootPS < 2^1333 := by decide +kernel

def env7606 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8461,65536,131072,262144,524288,8461,16464,10249,17664,206153,8328,17744,404557,4176,131152,65934,131140,4294967296,257,4295690731,131073,512]

theorem envBound7606 : H12AffineFastState.Bounded env7606 := by
  intro p hp
  have h : env7606.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7605_7606 : H12AffineEnvironment.transform 14 8461 env7605 = env7606 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8461 env7605 == env7606) = true)

theorem identity7606 : scanCanonicalize (H12AffineFastState.compose env7606 (packedSelected [1,3,4,5,8,9,10,16,19] rootPS)) = affineNative (2^(16+1) ^^^ 11461) := by decide +kernel

theorem selectedBound7606 : packedSelected [1,3,4,5,8,9,10,16,19] rootPS < 2^1333 := by decide +kernel

def env7607 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8461,65536,11461,262144,524288,8461,16464,10249,17664,67980,8328,17744,262280,4176,11413,65934,11393,4294967296,257,4295566638,11460,512]

theorem envBound7607 : H12AffineFastState.Bounded env7607 := by
  intro p hp
  have h : env7607.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7606_7607 : H12AffineEnvironment.transform 16 11461 env7606 = env7607 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 11461 env7606 == env7607) = true)

def env7608 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8461,65536,11461,2048,524288,8461,16464,10249,17664,67980,8328,17744,2184,4176,11413,65934,11393,4294967296,257,4295566638,11460,512]

theorem envBound7608 : H12AffineFastState.Bounded env7608 := by
  intro p hp
  have h : env7608.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7607_7608 : H12AffineEnvironment.transform 17 2048 env7607 = env7608 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2048 env7607 == env7608) = true)

theorem identity7608 : scanCanonicalize (H12AffineFastState.compose env7608 (packedSelected [0,4,7,11,16,22,23] rootPS)) = affineNative (2^(15+1) ^^^ 2310) := by decide +kernel

theorem selectedBound7608 : packedSelected [0,4,7,11,16,22,23] rootPS < 2^1333 := by decide +kernel

def env7609 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8461,2310,11461,2048,524288,8461,16464,10249,17664,138,8328,17744,2184,4176,11413,2184,11393,4294967296,257,4295502888,11460,512]

theorem envBound7609 : H12AffineFastState.Bounded env7609 := by
  intro p hp
  have h : env7609.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7608_7609 : H12AffineEnvironment.transform 15 2310 env7608 = env7609 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2310 env7608 == env7609) = true)

theorem identity7609 : scanCanonicalize (H12AffineFastState.compose env7609 (packedSelected [16,20] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound7609 : packedSelected [16,20] rootPS < 2^1333 := by decide +kernel

def env7610 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,8192,16384,8232,2083,11461,2048,524288,8232,16464,10249,17445,138,8328,17525,2184,4176,11413,2184,11393,4294967296,36,4295502888,11460,512]

theorem envBound7610 : H12AffineFastState.Bounded env7610 := by
  intro p hp
  have h : env7610.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7609_7610 : H12AffineEnvironment.transform 7 37 env7609 = env7610 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env7609 == env7610) = true)

theorem identity7610 : scanCanonicalize (H12AffineFastState.compose env7610 (packedSelected [0,2,9] rootPS)) = affineNative (2^(31+1) ^^^ 16110) := by decide +kernel

theorem selectedBound7610 : packedSelected [0,2,9] rootPS < 2^1333 := by decide +kernel

def env7611 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,8192,16384,8232,2083,11461,2048,524288,8232,16464,10249,17445,138,8328,17525,2184,4176,11413,2184,11393,16110,36,529094,11460,512]

theorem envBound7611 : H12AffineFastState.Bounded env7611 := by
  intro p hp
  have h : env7611.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7610_7611 : H12AffineEnvironment.transform 31 16110 env7610 = env7611 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 16110 env7610 == env7611) = true)

def env7612 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,8192,4176,8232,2083,11461,2048,524288,8232,4096,10249,5237,138,8328,5157,2184,4176,11413,2184,11393,16110,36,529094,11460,512]

theorem envBound7612 : H12AffineFastState.Bounded env7612 := by
  intro p hp
  have h : env7612.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7611_7612 : H12AffineEnvironment.transform 13 4176 env7611 = env7612 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env7611 == env7612) = true)

theorem identity7612 : scanCanonicalize (H12AffineFastState.compose env7612 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(8+1) ^^^ 163) := by decide +kernel

theorem selectedBound7612 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env7613 : List Nat := [2,4,8,16,32,64,128,37,163,1024,2048,4096,8192,4176,8232,2083,11461,2048,524288,8232,4096,10249,5237,138,8328,5157,2184,4176,11413,2184,11393,15437,36,528485,11460,163]

theorem envBound7613 : H12AffineFastState.Bounded env7613 := by
  intro p hp
  have h : env7613.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7612_7613 : H12AffineEnvironment.transform 8 163 env7612 = env7613 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 163 env7612 == env7613) = true)

theorem identity7613 : scanCanonicalize (H12AffineFastState.compose env7613 (packedSelected [11] rootPS)) = affineNative (2^(11+1) ^^^ 3140) := by decide +kernel

theorem selectedBound7613 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env7614 : List Nat := [2,4,8,16,32,64,128,37,163,1024,2048,3140,8192,3092,8232,2083,11461,2048,524288,8232,3140,10249,2097,138,8328,2145,2184,3092,11413,2184,11393,8201,36,527393,11460,163]

theorem envBound7614 : H12AffineFastState.Bounded env7614 := by
  intro p hp
  have h : env7614.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7613_7614 : H12AffineEnvironment.transform 11 3140 env7613 = env7614 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3140 env7613 == env7614) = true)

def env7615 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,8192,4177,8232,2083,11461,2048,524288,8232,4097,10249,5236,138,8328,5156,2184,4176,11413,2184,11393,16110,36,529094,11460,512]

theorem envBound7615 : H12AffineFastState.Bounded env7615 := by
  intro p hp
  have h : env7615.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7611_7615 : H12AffineEnvironment.transform 13 4177 env7611 = env7615 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env7611 == env7615) = true)

theorem identity7615 : scanCanonicalize (H12AffineFastState.compose env7615 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(12+1) ^^^ 2563) := by decide +kernel

theorem selectedBound7615 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env7616 : List Nat := [2,4,8,16,32,64,128,37,512,1024,2048,4096,2563,4177,2603,2083,1734,2048,524288,2603,4097,522,5236,138,2699,5156,2184,4176,1686,2184,1666,5357,36,529094,1735,512]

theorem envBound7616 : H12AffineFastState.Bounded env7616 := by
  intro p hp
  have h : env7616.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7615_7616 : H12AffineEnvironment.transform 12 2563 env7615 = env7616 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2563 env7615 == env7616) = true)

theorem identity7616 : scanCanonicalize (H12AffineFastState.compose env7616 (packedSelected [11] rootPS)) = affineNative (2^(10+1) ^^^ 32) := by decide +kernel

theorem selectedBound7616 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env7617 : List Nat := [2,4,8,16,32,64,128,37,512,1024,32,4096,547,4177,523,3,1734,32,524288,523,4097,522,5236,138,683,5156,168,4176,1686,168,1666,5357,36,529094,1735,512]

theorem envBound7617 : H12AffineFastState.Bounded env7617 := by
  intro p hp
  have h : env7617.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7616_7617 : H12AffineEnvironment.transform 10 32 env7616 = env7617 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 32 env7616 == env7617) = true)

theorem identity7617 : scanCanonicalize (H12AffineFastState.compose env7617 (packedSelected [0,2,3,4,5,6,10,12] rootPS)) = affineNative (2^(18+1) ^^^ 4638) := by decide +kernel

theorem selectedBound7617 : packedSelected [0,2,3,4,5,6,10,12] rootPS < 2^1333 := by decide +kernel

def env7618 : List Nat := [2,4,8,16,32,64,128,37,512,1024,32,4096,547,4177,523,3,1734,32,4638,523,4097,522,5236,138,683,5156,168,4176,1686,168,1666,5357,36,216,1735,512]

theorem envBound7618 : H12AffineFastState.Bounded env7618 := by
  intro p hp
  have h : env7618.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7617_7618 : H12AffineEnvironment.transform 18 4638 env7617 = env7618 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 4638 env7617 == env7618) = true)

theorem identity7618 : scanCanonicalize (H12AffineFastState.compose env7618 (packedSelected [1,3,6] rootPS)) = affineNative (2^(8+1) ^^^ 42) := by decide +kernel

theorem selectedBound7618 : packedSelected [1,3,6] rootPS < 2^1333 := by decide +kernel

def env7619 : List Nat := [2,4,8,16,32,64,128,37,42,1024,32,4096,9,4177,33,3,1260,32,4148,33,4097,32,5236,138,129,5156,168,4176,1212,168,1192,5357,36,216,1261,42]

theorem envBound7619 : H12AffineFastState.Bounded env7619 := by
  intro p hp
  have h : env7619.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7618_7619 : H12AffineEnvironment.transform 8 42 env7618 = env7619 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 42 env7618 == env7619) = true)

theorem identity7619 : scanCanonicalize (H12AffineFastState.compose env7619 (packedSelected [0,2,4] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound7619 : packedSelected [0,2,4] rootPS < 2^1333 := by decide +kernel

def env7620 : List Nat := [2,4,8,16,32,64,9,37,42,1024,32,4096,9,4177,33,3,1125,32,4148,33,4097,32,5236,3,8,5156,33,4176,1077,33,1057,5220,36,81,1124,42]

theorem envBound7620 : H12AffineFastState.Bounded env7620 := by
  intro p hp
  have h : env7620.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7619_7620 : H12AffineEnvironment.transform 6 9 env7619 = env7620 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env7619 == env7620) = true)

theorem identity7620 : scanCanonicalize (H12AffineFastState.compose env7620 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 3) := by decide +kernel

theorem selectedBound7620 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7621 : List Nat := [2,4,8,16,3,64,9,6,9,1024,3,4096,9,4177,2,3,1094,3,4119,2,4097,3,5207,3,8,5127,2,4176,1046,2,1026,5191,7,81,1095,9]

theorem envBound7621 : H12AffineFastState.Bounded env7621 := by
  intro p hp
  have h : env7621.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7620_7621 : H12AffineEnvironment.transform 4 3 env7620 = env7621 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 3 env7620 == env7621) = true)

theorem identity7621 : scanCanonicalize (H12AffineFastState.compose env7621 (packedSelected [10,13] rootPS)) = affineNative (2^(9+1) ^^^ 7) := by decide +kernel

theorem selectedBound7621 : packedSelected [10,13] rootPS < 2^1333 := by decide +kernel

def env7622 : List Nat := [2,4,8,16,3,64,9,6,9,7,3,4096,9,4177,2,3,65,3,4119,2,4097,3,4176,3,8,4096,2,4176,17,2,5,4160,7,81,64,9]

theorem envBound7622 : H12AffineFastState.Bounded env7622 := by
  intro p hp
  have h : env7622.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7621_7622 : H12AffineEnvironment.transform 9 7 env7621 = env7622 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 7 env7621 == env7622) = true)

theorem identity7622 : scanCanonicalize (H12AffineFastState.compose env7622 (packedSelected [1,5] rootPS)) = affineNative (2^(11+1) ^^^ 19) := by decide +kernel

theorem selectedBound7622 : packedSelected [1,5] rootPS < 2^1333 := by decide +kernel

def env7623 : List Nat := [2,4,8,16,3,64,9,6,9,7,3,19,9,66,2,3,65,3,4,2,18,3,67,3,8,19,2,67,17,2,5,83,7,81,64,9]

theorem envBound7623 : H12AffineFastState.Bounded env7623 := by
  intro p hp
  have h : env7623.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7622_7623 : H12AffineEnvironment.transform 11 19 env7622 = env7623 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 19 env7622 == env7623) = true)

def env7624 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8461,65536,11461,2049,524288,8461,16464,10249,17664,67980,8328,17744,2185,4176,11413,65934,11393,4294967296,257,4295566638,11460,512]

theorem envBound7624 : H12AffineFastState.Bounded env7624 := by
  intro p hp
  have h : env7624.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7607_7624 : H12AffineEnvironment.transform 17 2049 env7607 = env7624 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2049 env7607 == env7624) = true)

theorem identity7624 : scanCanonicalize (H12AffineFastState.compose env7624 (packedSelected [0,4,7,11,16,22,23] rootPS)) = affineNative (2^(15+1) ^^^ 2082) := by decide +kernel

theorem selectedBound7624 : packedSelected [0,4,7,11,16,22,23] rootPS < 2^1333 := by decide +kernel

def env7625 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8461,2082,11461,2049,524288,8461,16464,10249,17664,430,8328,17744,2185,4176,11413,2476,11393,4294967296,257,4295503116,11460,512]

theorem envBound7625 : H12AffineFastState.Bounded env7625 := by
  intro p hp
  have h : env7625.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7624_7625 : H12AffineEnvironment.transform 15 2082 env7624 = env7625 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2082 env7624 == env7625) = true)

theorem identity7625 : scanCanonicalize (H12AffineFastState.compose env7625 (packedSelected [0,2,9] rootPS)) = affineNative (2^(31+1) ^^^ 16194) := by decide +kernel

theorem selectedBound7625 : packedSelected [0,2,9] rootPS < 2^1333 := by decide +kernel

def env7626 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8461,2082,11461,2049,524288,8461,16464,10249,17664,430,8328,17744,2185,4176,11413,2476,11393,16194,257,528974,11460,512]

theorem envBound7626 : H12AffineFastState.Bounded env7626 := by
  intro p hp
  have h : env7626.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7625_7626 : H12AffineEnvironment.transform 31 16194 env7625 = env7626 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 16194 env7625 == env7626) = true)

theorem identity7626 : scanCanonicalize (H12AffineFastState.compose env7626 (packedSelected [11,18,20] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound7626 : packedSelected [11,18,20] rootPS < 2^1333 := by decide +kernel

def env7627 : List Nat := [2,4,8,16,32,64,128,36,512,1024,2048,4096,8192,16384,8233,2082,11461,2049,524288,8233,16464,10249,17444,138,8328,17524,2185,4176,11413,2184,11393,15974,37,528974,11460,512]

theorem envBound7627 : H12AffineFastState.Bounded env7627 := by
  intro p hp
  have h : env7627.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7626_7627 : H12AffineEnvironment.transform 7 36 env7626 = env7627 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env7626 == env7627) = true)

def env7628 : List Nat := [2,4,8,16,32,64,128,36,512,1024,2048,4096,8192,4176,8233,2082,11461,2049,524288,8233,4096,10249,5236,138,8328,5156,2185,4176,11413,2184,11393,15974,37,528974,11460,512]

theorem envBound7628 : H12AffineFastState.Bounded env7628 := by
  intro p hp
  have h : env7628.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7627_7628 : H12AffineEnvironment.transform 13 4176 env7627 = env7628 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env7627 == env7628) = true)

theorem identity7628 : scanCanonicalize (H12AffineFastState.compose env7628 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(8+1) ^^^ 42) := by decide +kernel

theorem selectedBound7628 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env7629 : List Nat := [2,4,8,16,32,64,128,36,42,1024,2048,4096,8192,4176,8233,2082,11461,2049,524288,8233,4096,10249,5236,138,8328,5156,2185,4176,11413,2184,11393,15436,37,528484,11460,42]

theorem envBound7629 : H12AffineFastState.Bounded env7629 := by
  intro p hp
  have h : env7629.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7628_7629 : H12AffineEnvironment.transform 8 42 env7628 = env7629 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 42 env7628 == env7629) = true)

theorem identity7629 : scanCanonicalize (H12AffineFastState.compose env7629 (packedSelected [11] rootPS)) = affineNative (2^(11+1) ^^^ 3141) := by decide +kernel

theorem selectedBound7629 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env7630 : List Nat := [2,4,8,16,32,64,128,36,42,1024,2048,3141,8192,3093,8233,2082,11461,2049,524288,8233,3141,10249,2097,138,8328,2145,2185,3093,11413,2184,11393,8201,37,527393,11460,42]

theorem envBound7630 : H12AffineFastState.Bounded env7630 := by
  intro p hp
  have h : env7630.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7629_7630 : H12AffineEnvironment.transform 11 3141 env7629 = env7630 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3141 env7629 == env7630) = true)

theorem identity7630 : scanCanonicalize (H12AffineFastState.compose env7630 (packedSelected [0,2,3,4,5,6,10,12] rootPS)) = affineNative (2^(18+1) ^^^ 9305) := by decide +kernel

theorem selectedBound7630 : packedSelected [0,2,3,4,5,6,10,12] rootPS < 2^1333 := by decide +kernel

def env7631 : List Nat := [2,4,8,16,32,64,128,36,42,1024,2048,3141,8192,3093,8233,2082,11461,2049,9305,8233,3141,10249,2097,138,8328,2145,2185,3093,11413,2184,11393,8201,37,10360,11460,42]

theorem envBound7631 : H12AffineFastState.Bounded env7631 := by
  intro p hp
  have h : env7631.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7630_7631 : H12AffineEnvironment.transform 18 9305 env7630 = env7631 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 9305 env7630 == env7631) = true)

theorem identity7631 : scanCanonicalize (H12AffineFastState.compose env7631 (packedSelected [1,3,6] rootPS)) = affineNative (2^(12+1) ^^^ 89) := by decide +kernel

theorem selectedBound7631 : packedSelected [1,3,6] rootPS < 2^1333 := by decide +kernel

def env7632 : List Nat := [2,4,8,16,32,64,128,36,42,1024,2048,3141,89,3093,112,2082,3228,2049,1024,112,3141,2128,2097,138,209,2145,2185,3093,3276,2184,3288,80,37,2081,3229,42]

theorem envBound7632 : H12AffineFastState.Bounded env7632 := by
  intro p hp
  have h : env7632.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7631_7632 : H12AffineEnvironment.transform 12 89 env7631 = env7632 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 89 env7631 == env7632) = true)

theorem identity7632 : scanCanonicalize (H12AffineFastState.compose env7632 (packedSelected [0,1,2,3,4] rootPS)) = affineNative (2^(10+1) ^^^ 112) := by decide +kernel

theorem selectedBound7632 : packedSelected [0,1,2,3,4] rootPS < 2^1333 := by decide +kernel

def env7633 : List Nat := [2,4,8,16,32,64,128,36,42,1024,112,1077,89,1125,112,82,1260,113,1024,112,1077,32,65,138,209,17,249,1125,1212,248,1192,80,37,81,1261,42]

theorem envBound7633 : H12AffineFastState.Bounded env7633 := by
  intro p hp
  have h : env7633.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7632_7633 : H12AffineEnvironment.transform 10 112 env7632 = env7633 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 112 env7632 == env7633) = true)

theorem identity7633 : scanCanonicalize (H12AffineFastState.compose env7633 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 34) := by decide +kernel

theorem selectedBound7633 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7634 : List Nat := [2,4,8,16,32,64,34,36,42,1024,112,1077,89,1125,112,82,1102,113,1024,112,1077,32,65,40,115,17,91,1125,1054,90,1034,80,37,81,1103,42]

theorem envBound7634 : H12AffineFastState.Bounded env7634 := by
  intro p hp
  have h : env7634.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7633_7634 : H12AffineEnvironment.transform 6 34 env7633 = env7634 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 34 env7633 == env7634) = true)

theorem identity7634 : scanCanonicalize (H12AffineFastState.compose env7634 (packedSelected [1,3] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound7634 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7635 : List Nat := [2,4,8,16,10,64,8,14,0,1024,90,1055,89,1103,90,82,1102,91,1024,90,1055,10,65,2,89,17,91,1103,1054,90,1034,80,15,81,1103,0]

theorem envBound7635 : H12AffineFastState.Bounded env7635 := by
  intro p hp
  have h : env7635.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7634_7635 : H12AffineEnvironment.transform 4 10 env7634 = env7635 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env7634 == env7635) = true)

theorem identity7635 : scanCanonicalize (H12AffineFastState.compose env7635 (packedSelected [0] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound7635 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7636 : List Nat := [1,4,8,16,9,64,8,13,0,1024,89,1052,89,1100,89,81,1101,88,1024,89,1052,9,65,1,89,17,88,1100,1053,89,1033,80,12,81,1100,0]

theorem envBound7636 : H12AffineFastState.Bounded env7636 := by
  intro p hp
  have h : env7636.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7635_7636 : H12AffineEnvironment.transform 0 1 env7635 = env7636 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env7635 == env7636) = true)

theorem identity7636 : scanCanonicalize (H12AffineFastState.compose env7636 (packedSelected [1] rootPS)) = affineNative (2^(9+1) ^^^ 12) := by decide +kernel

theorem selectedBound7636 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7637 : List Nat := [1,4,8,16,9,64,8,13,0,12,89,16,89,64,89,81,65,88,12,89,16,9,65,1,89,17,88,64,17,89,5,80,12,81,64,0]

theorem envBound7637 : H12AffineFastState.Bounded env7637 := by
  intro p hp
  have h : env7637.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7636_7637 : H12AffineEnvironment.transform 9 12 env7636 = env7637 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 12 env7636 == env7637) = true)

theorem identity7637 : scanCanonicalize (H12AffineFastState.compose env7637 (packedSelected [5] rootPS)) = affineNative (2^(5+1) ^^^ 25) := by decide +kernel

theorem selectedBound7637 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env7638 : List Nat := [1,4,8,16,9,25,8,13,0,12,0,16,0,25,0,8,24,1,12,0,16,9,24,1,0,17,1,25,17,0,5,9,12,8,25,0]

theorem envBound7638 : H12AffineFastState.Bounded env7638 := by
  intro p hp
  have h : env7638.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7637_7638 : H12AffineEnvironment.transform 5 25 env7637 = env7638 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 25 env7637 == env7638) = true)

theorem identity7638 : scanCanonicalize (H12AffineFastState.compose env7638 (packedSelected [10] rootPS)) = affineNative (2^(2+1) ^^^ 0) := by decide +kernel

theorem selectedBound7638 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env7639 : List Nat := [1,4,0,16,1,17,0,5,0,4,0,16,0,17,0,0,16,1,4,0,16,1,16,1,0,17,1,17,17,0,5,1,4,0,17,0]

theorem envBound7639 : H12AffineFastState.Bounded env7639 := by
  intro p hp
  have h : env7639.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7638_7639 : H12AffineEnvironment.transform 2 0 env7638 = env7639 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env7638 == env7639) = true)

def leafEnv7639 : List Nat := [1,4,0,16,1,17,0,5,0,4,0,16,0,17,0,0,16,1,4,0,16,1,16,1,5,0,1,17,1,17,17,0,5,1,4,0,5,0,17,0,0,16,1]

def active7639 : List Nat := [1,3]

def tree7639 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7639 : H12WitnessSearch.Good tree7639 := H12GlobalWitnessIndex.good

theorem leafIdentity7639 : H12AffineFastState.composeSystem env7639 rootObs = leafEnv7639 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7639 rootObs == leafEnv7639) = true)

theorem terminalChecked7639 : H12PackedTerminal.terminalCheckFast leafEnv7639 active7639 tree7639 = true := by decide +kernel

def env7640 : List Nat := [2,4,8,16,32,64,128,36,512,1024,2048,4096,8192,4177,8233,2082,11461,2049,524288,8233,4097,10249,5237,138,8328,5157,2185,4176,11413,2184,11393,15974,37,528974,11460,512]

theorem envBound7640 : H12AffineFastState.Bounded env7640 := by
  intro p hp
  have h : env7640.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7627_7640 : H12AffineEnvironment.transform 13 4177 env7627 = env7640 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env7627 == env7640) = true)

theorem identity7640 : scanCanonicalize (H12AffineFastState.compose env7640 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(12+1) ^^^ 2699) := by decide +kernel

theorem selectedBound7640 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env7641 : List Nat := [2,4,8,16,32,64,128,36,512,1024,2048,4096,2699,4177,2722,2082,1614,2049,524288,2722,4097,642,5237,138,2563,5157,2185,4176,1566,2184,1546,5357,37,528974,1615,512]

theorem envBound7641 : H12AffineFastState.Bounded env7641 := by
  intro p hp
  have h : env7641.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7640_7641 : H12AffineEnvironment.transform 12 2699 env7640 = env7641 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2699 env7640 == env7641) = true)

theorem identity7641 : scanCanonicalize (H12AffineFastState.compose env7641 (packedSelected [11] rootPS)) = affineNative (2^(10+1) ^^^ 32) := by decide +kernel

theorem selectedBound7641 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env7642 : List Nat := [2,4,8,16,32,64,128,36,512,1024,32,4096,683,4177,642,2,1614,33,524288,642,4097,642,5237,138,547,5157,169,4176,1566,168,1546,5357,37,528974,1615,512]

theorem envBound7642 : H12AffineFastState.Bounded env7642 := by
  intro p hp
  have h : env7642.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7641_7642 : H12AffineEnvironment.transform 10 32 env7641 = env7642 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 32 env7641 == env7642) = true)

theorem identity7642 : scanCanonicalize (H12AffineFastState.compose env7642 (packedSelected [0,2,6,22] rootPS)) = affineNative (2^(8+1) ^^^ 43) := by decide +kernel

theorem selectedBound7642 : packedSelected [0,2,6,22] rootPS < 2^1333 := by decide +kernel

def env7643 : List Nat := [2,4,8,16,32,64,128,36,43,1024,32,4096,128,4177,169,2,1125,33,524288,169,4097,169,5237,138,8,5157,169,4176,1077,168,1057,5357,37,528485,1124,43]

theorem envBound7643 : H12AffineFastState.Bounded env7643 := by
  intro p hp
  have h : env7643.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7642_7643 : H12AffineEnvironment.transform 8 43 env7642 = env7643 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 43 env7642 == env7643) = true)

theorem identity7643 : scanCanonicalize (H12AffineFastState.compose env7643 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 74) := by decide +kernel

theorem selectedBound7643 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7644 : List Nat := [2,4,8,16,32,64,74,36,43,1024,32,4096,74,4177,99,2,1125,33,524288,99,4097,99,5237,64,8,5157,99,4176,1077,98,1057,5159,37,528485,1124,43]

theorem envBound7644 : H12AffineFastState.Bounded env7644 := by
  intro p hp
  have h : env7644.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7643_7644 : H12AffineEnvironment.transform 6 74 env7643 = env7644 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 74 env7643 == env7644) = true)

theorem identity7644 : scanCanonicalize (H12AffineFastState.compose env7644 (packedSelected [2,4] rootPS)) = affineNative (2^(18+1) ^^^ 4214) := by decide +kernel

theorem selectedBound7644 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env7645 : List Nat := [2,4,8,16,32,64,74,36,43,1024,32,4096,74,4177,99,2,1125,33,4214,99,4097,99,5237,64,8,5157,99,4176,1077,98,1057,5159,37,19,1124,43]

theorem envBound7645 : H12AffineFastState.Bounded env7645 := by
  intro p hp
  have h : env7645.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7644_7645 : H12AffineEnvironment.transform 18 4214 env7644 = env7645 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 4214 env7644 == env7645) = true)

theorem identity7645 : scanCanonicalize (H12AffineFastState.compose env7645 (packedSelected [1,3] rootPS)) = affineNative (2^(11+1) ^^^ 1142) := by decide +kernel

theorem selectedBound7645 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7646 : List Nat := [2,4,8,16,32,64,74,36,43,1024,32,1142,74,1063,99,2,1125,33,1024,99,1143,99,3,64,8,83,99,1062,1077,98,1057,81,37,19,1124,43]

theorem envBound7646 : H12AffineFastState.Bounded env7646 := by
  intro p hp
  have h : env7646.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7645_7646 : H12AffineEnvironment.transform 11 1142 env7645 = env7646 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1142 env7645 == env7646) = true)

theorem identity7646 : scanCanonicalize (H12AffineFastState.compose env7646 (packedSelected [1,5] rootPS)) = affineNative (2^(9+1) ^^^ 102) := by decide +kernel

theorem selectedBound7646 : packedSelected [1,5] rootPS < 2^1333 := by decide +kernel

def env7647 : List Nat := [2,4,8,16,32,64,74,36,43,102,32,16,74,65,99,2,3,33,102,99,17,99,3,64,8,83,99,64,83,98,71,81,37,19,2,43]

theorem envBound7647 : H12AffineFastState.Bounded env7647 := by
  intro p hp
  have h : env7647.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7646_7647 : H12AffineEnvironment.transform 9 102 env7646 = env7647 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 102 env7646 == env7647) = true)

def env7648 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,10249,17664,230468,8329,2098432,2518045,2117632,131152,1073741824,131140,4294967296,257,4297844919,131073,513]

theorem envBound7648 : H12AffineFastState.Bounded env7648 := by
  intro p hp
  have h : env7648.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7602_7648 : H12AffineEnvironment.transform 24 8329 env7602 = env7648 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env7602 == env7648) = true)

def env7649 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,8201,17664,230468,8329,2098432,2515997,2117632,131152,1073741824,131140,4294967296,257,4297842871,131073,513]

theorem envBound7649 : H12AffineFastState.Bounded env7649 := by
  intro p hp
  have h : env7649.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7648_7649 : H12AffineEnvironment.transform 10 0 env7648 = env7649 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env7648 == env7649) = true)

def env7650 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,8201,17664,230468,8329,5376,422941,16384,131152,1073741824,131140,4294967296,257,4295749815,131073,513]

theorem envBound7650 : H12AffineFastState.Bounded env7650 := by
  intro p hp
  have h : env7650.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7649_7650 : H12AffineEnvironment.transform 20 4096 env7649 = env7650 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env7649 == env7650) = true)

theorem identity7650 : scanCanonicalize (H12AffineFastState.compose env7650 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 181245) := by decide +kernel

theorem selectedBound7650 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env7651 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,8201,17664,230468,8329,5376,422941,16384,131152,181245,131140,4294967296,257,4295749815,131073,513]

theorem envBound7651 : H12AffineFastState.Bounded env7651 := by
  intro p hp
  have h : env7651.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7650_7651 : H12AffineEnvironment.transform 29 181245 env7650 = env7651 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 181245 env7650 == env7651) = true)

theorem identity7651 : scanCanonicalize (H12AffineFastState.compose env7651 (packedSelected [0,4,6,7,16,20,22,25] rootPS)) = affineNative (2^(18+1) ^^^ 21585) := by decide +kernel

theorem selectedBound7651 : packedSelected [0,4,6,7,16,20,22,25] rootPS < 2^1333 := by decide +kernel

def env7652 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,21585,32768,4096,8201,17664,230468,8329,5376,422941,16384,131152,181245,131140,4294967296,257,4295206118,131073,513]

theorem envBound7652 : H12AffineFastState.Bounded env7652 := by
  intro p hp
  have h : env7652.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7651_7652 : H12AffineEnvironment.transform 18 21585 env7651 = env7652 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 21585 env7651 == env7652) = true)

theorem identity7652 : scanCanonicalize (H12AffineFastState.compose env7652 (packedSelected [4,9,16] rootPS)) = affineNative (2^(16+1) ^^^ 91006) := by decide +kernel

theorem selectedBound7652 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env7653 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,91006,262144,21585,32768,4096,8201,17664,59194,8329,5376,333667,16384,90926,106627,90938,4294967296,257,4295018392,91007,513]

theorem envBound7653 : H12AffineFastState.Bounded env7653 := by
  intro p hp
  have h : env7653.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7652_7653 : H12AffineEnvironment.transform 16 91006 env7652 = env7653 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 91006 env7652 == env7653) = true)

theorem identity7653 : scanCanonicalize (H12AffineFastState.compose env7653 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 4177) := by decide +kernel

theorem selectedBound7653 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env7654 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,78639,262144,1024,32768,4096,8201,5457,46955,8329,5376,333667,4177,78719,106627,78699,4294967296,257,4295006153,78638,513]

theorem envBound7654 : H12AffineFastState.Bounded env7654 := by
  intro p hp
  have h : env7654.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7653_7654 : H12AffineEnvironment.transform 13 4177 env7653 = env7654 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env7653 == env7654) = true)

theorem identity7654 : scanCanonicalize (H12AffineFastState.compose env7654 (packedSelected [13,21] rootPS)) = affineNative (2^(14+1) ^^^ 8540) := by decide +kernel

theorem selectedBound7654 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env7655 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,8540,65536,78639,262144,1024,8540,4096,8201,5457,5687,8329,5376,333667,4177,78719,66015,78699,4294967296,257,4294981269,78638,513]

theorem envBound7655 : H12AffineFastState.Bounded env7655 := by
  intro p hp
  have h : env7655.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7654_7655 : H12AffineEnvironment.transform 14 8540 env7654 = env7655 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8540 env7654 == env7655) = true)

def env7656 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,8201,17664,230468,8329,5377,422940,16385,131152,1073741824,131140,4294967296,257,4295749814,131073,513]

theorem envBound7656 : H12AffineFastState.Bounded env7656 := by
  intro p hp
  have h : env7656.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7649_7656 : H12AffineEnvironment.transform 20 4097 env7649 = env7656 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env7649 == env7656) = true)

theorem identity7656 : scanCanonicalize (H12AffineFastState.compose env7656 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 186045) := by decide +kernel

theorem selectedBound7656 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env7657 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,8201,17664,230468,8329,5377,422940,16385,131152,186045,131140,4294967296,257,4295749814,131073,513]

theorem envBound7657 : H12AffineFastState.Bounded env7657 := by
  intro p hp
  have h : env7657.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7656_7657 : H12AffineEnvironment.transform 29 186045 env7656 = env7657 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 186045 env7656 == env7657) = true)

def env7658 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4824,32768,65536,131072,262144,524288,32768,4097,8201,6104,230468,8329,5377,403140,4825,131152,164965,131140,4294967296,257,4295729774,131073,513]

theorem envBound7658 : H12AffineFastState.Bounded env7658 := by
  intro p hp
  have h : env7658.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7657_7658 : H12AffineEnvironment.transform 13 4824 env7657 = env7658 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4824 env7657 == env7658) = true)

theorem identity7658 : scanCanonicalize (H12AffineFastState.compose env7658 (packedSelected [0,2,6,9,23] rootPS)) = affineNative (2^(17+1) ^^^ 1) := by decide +kernel

theorem selectedBound7658 : packedSelected [0,2,6,9,23] rootPS < 2^1333 := by decide +kernel

def env7659 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4824,32768,65536,131072,1,524288,32768,4097,8201,6104,230468,8329,5377,140997,4825,131152,164965,131140,4294967296,257,4295729774,131073,513]

theorem envBound7659 : H12AffineFastState.Bounded env7659 := by
  intro p hp
  have h : env7659.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7658_7659 : H12AffineEnvironment.transform 17 1 env7658 = env7659 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env7658 == env7659) = true)

theorem identity7659 : scanCanonicalize (H12AffineFastState.compose env7659 (packedSelected [18,20] rootPS)) = affineNative (2^(14+1) ^^^ 8864) := by decide +kernel

theorem selectedBound7659 : packedSelected [18,20] rootPS < 2^1333 := by decide +kernel

def env7660 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4824,8864,65536,131072,1,524288,8864,4097,8201,6104,206564,8329,5377,140997,4825,131152,140997,131140,4294967296,257,4295688398,131073,513]

theorem envBound7660 : H12AffineFastState.Bounded env7660 := by
  intro p hp
  have h : env7660.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7659_7660 : H12AffineEnvironment.transform 14 8864 env7659 = env7660 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8864 env7659 == env7660) = true)

def env7661 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4824,8864,65536,1344,1,524288,8864,4097,8201,6104,74660,8329,5377,9093,4825,1296,9093,1284,4294967296,257,4295558542,1345,513]

theorem envBound7661 : H12AffineFastState.Bounded env7661 := by
  intro p hp
  have h : env7661.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7660_7661 : H12AffineEnvironment.transform 16 1344 env7660 = env7661 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env7660 == env7661) = true)

theorem identity7661 : scanCanonicalize (H12AffineFastState.compose env7661 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(12+1) ^^^ 901) := by decide +kernel

theorem selectedBound7661 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env7662 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,901,4824,293,65536,1344,1,524288,293,4097,908,6104,65569,780,5377,0,4825,1296,0,1284,4294967296,257,4295558542,1345,513]

theorem envBound7662 : H12AffineFastState.Bounded env7662 := by
  intro p hp
  have h : env7662.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7661_7662 : H12AffineEnvironment.transform 12 901 env7661 = env7662 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 901 env7661 == env7662) = true)

def env7663 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,901,4824,293,65536,1344,1,1024,293,4097,908,6104,65569,780,5377,0,4825,1296,0,1284,4294967296,257,4295033230,1345,513]

theorem envBound7663 : H12AffineFastState.Bounded env7663 := by
  intro p hp
  have h : env7663.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7662_7663 : H12AffineEnvironment.transform 18 1024 env7662 = env7663 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env7662 == env7663) = true)

theorem identity7663 : scanCanonicalize (H12AffineFastState.compose env7663 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 170) := by decide +kernel

theorem selectedBound7663 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env7664 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,901,4824,293,170,1344,1,1024,293,4097,908,6104,139,780,5377,0,4825,1296,0,1284,4294967296,257,4294967588,1345,513]

theorem envBound7664 : H12AffineFastState.Bounded env7664 := by
  intro p hp
  have h : env7664.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7663_7664 : H12AffineEnvironment.transform 15 170 env7663 = env7664 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 170 env7663 == env7664) = true)

theorem identity7664 : scanCanonicalize (H12AffineFastState.compose env7664 (packedSelected [5,8] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound7664 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env7665 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,269,4176,293,170,1344,1,1024,293,4097,260,5456,139,388,5377,0,4177,1296,0,1284,4294967296,257,4294967588,1345,137]

theorem envBound7665 : H12AffineFastState.Bounded env7665 := by
  intro p hp
  have h : env7665.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7664_7665 : H12AffineEnvironment.transform 8 136 env7664 = env7665 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env7664 == env7665) = true)

theorem identity7665 : scanCanonicalize (H12AffineFastState.compose env7665 (packedSelected [1,3] rootPS)) = affineNative (2^(11+1) ^^^ 1077) := by decide +kernel

theorem selectedBound7665 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7666 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,1077,269,1125,293,170,1344,1,1024,293,1076,260,357,139,388,308,0,1124,1296,0,1284,4294967296,257,4294967588,1345,137]

theorem envBound7666 : H12AffineFastState.Bounded env7666 := by
  intro p hp
  have h : env7666.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7665_7666 : H12AffineEnvironment.transform 11 1077 env7665 = env7666 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1077 env7665 == env7666) = true)

def env7667 : List Nat := [2,4,8,16,32,64,8,256,0,1024,0,1077,269,1125,293,34,1344,1,1024,293,1076,260,357,3,268,308,0,1124,1296,0,1284,4294967296,257,4294967588,1345,1]

theorem envBound7667 : H12AffineFastState.Bounded env7667 := by
  intro p hp
  have h : env7667.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7666_7667 : H12AffineEnvironment.transform 6 8 env7666 = env7667 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env7666 == env7667) = true)

theorem identity7667 : scanCanonicalize (H12AffineFastState.compose env7667 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 42) := by decide +kernel

theorem selectedBound7667 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7668 : List Nat := [2,4,8,16,32,64,8,256,0,1024,0,1077,269,1125,293,34,1344,1,1024,293,1076,260,357,3,268,308,0,1124,1296,0,1284,42,257,270,1345,1]

theorem envBound7668 : H12AffineFastState.Bounded env7668 := by
  intro p hp
  have h : env7668.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7667_7668 : H12AffineEnvironment.transform 31 42 env7667 = env7668 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 42 env7667 == env7668) = true)

def env7669 : List Nat := [2,4,8,16,32,16,8,256,0,1024,0,1077,269,1077,293,34,1296,1,1024,293,1076,260,309,3,268,308,0,1076,1296,0,1284,42,257,270,1297,1]

theorem envBound7669 : H12AffineFastState.Bounded env7669 := by
  intro p hp
  have h : env7669.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7668_7669 : H12AffineEnvironment.transform 5 16 env7668 = env7669 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7668 == env7669) = true)

theorem identity7669 : scanCanonicalize (H12AffineFastState.compose env7669 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound7669 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7670 : List Nat := [2,4,8,1,32,1,8,256,0,1024,0,1060,269,1060,293,34,1281,1,1024,293,1061,260,292,3,268,293,0,1061,1281,0,1284,42,257,270,1280,1]

theorem envBound7670 : H12AffineFastState.Bounded env7670 := by
  intro p hp
  have h : env7670.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7669_7670 : H12AffineEnvironment.transform 3 1 env7669 = env7670 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7669 == env7670) = true)

def env7671 : List Nat := [2,4,8,1,32,1,8,36,0,1024,0,1060,41,1060,1,34,1061,1,1024,1,1061,32,0,3,40,1,0,1061,1061,0,1056,42,37,42,1060,1]

theorem envBound7671 : H12AffineFastState.Bounded env7671 := by
  intro p hp
  have h : env7671.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7670_7671 : H12AffineEnvironment.transform 7 36 env7670 = env7671 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env7670 == env7671) = true)

theorem identity7671 : scanCanonicalize (H12AffineFastState.compose env7671 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound7671 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7672 : List Nat := [2,4,3,1,32,1,3,36,0,1024,0,1060,34,1060,1,34,1061,1,1024,1,1061,32,0,3,35,1,0,1061,1061,0,1056,33,37,33,1060,1]

theorem envBound7672 : H12AffineFastState.Bounded env7672 := by
  intro p hp
  have h : env7672.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7671_7672 : H12AffineEnvironment.transform 2 3 env7671 = env7672 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env7671 == env7672) = true)

def leafEnv7672 : List Nat := [2,4,3,1,32,1,3,36,0,1024,0,1060,34,1060,1,34,1061,1,1024,1,1061,32,0,3,1056,35,1,1,0,1061,1061,0,1056,33,37,33,5,34,1060,1,0,1060,1]

def active7672 : List Nat := [0,1,4,9]

def tree7672 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7672 : H12WitnessSearch.Good tree7672 := H12GlobalWitnessIndex.good

theorem leafIdentity7672 : H12AffineFastState.composeSystem env7672 rootObs = leafEnv7672 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7672 rootObs == leafEnv7672) = true)

theorem terminalChecked7672 : H12PackedTerminal.terminalCheckFast leafEnv7672 active7672 tree7672 = true := by decide +kernel

def env7673 : List Nat := [2,4,8,1,32,1,8,37,0,1024,0,1060,40,1060,0,34,1060,1,1024,0,1061,33,1,3,41,0,0,1061,1060,0,1057,42,36,43,1061,1]

theorem envBound7673 : H12AffineFastState.Bounded env7673 := by
  intro p hp
  have h : env7673.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7670_7673 : H12AffineEnvironment.transform 7 37 env7670 = env7673 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env7670 == env7673) = true)

def leafEnv7673 : List Nat := [2,4,8,1,32,1,8,37,0,1024,0,1060,40,1060,0,34,1060,1,1024,0,1061,33,1,3,1057,41,1,0,0,1061,1060,0,1057,42,36,43,5,34,1061,1,0,1061,1]

def active7673 : List Nat := [0,1,2,4,9]

def tree7673 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7673 : H12WitnessSearch.Good tree7673 := H12GlobalWitnessIndex.good

theorem leafIdentity7673 : H12AffineFastState.composeSystem env7673 rootObs = leafEnv7673 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7673 rootObs == leafEnv7673) = true)

theorem terminalChecked7673 : H12PackedTerminal.terminalCheckFast leafEnv7673 active7673 tree7673 = true := by decide +kernel

def env7674 : List Nat := [2,4,8,16,32,17,8,256,0,1024,0,1077,269,1076,293,34,1297,1,1024,293,1076,260,308,3,268,308,0,1077,1296,0,1284,42,257,270,1296,1]

theorem envBound7674 : H12AffineFastState.Bounded env7674 := by
  intro p hp
  have h : env7674.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7668_7674 : H12AffineEnvironment.transform 5 17 env7668 = env7674 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7668 == env7674) = true)

theorem identity7674 : scanCanonicalize (H12AffineFastState.compose env7674 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 53) := by decide +kernel

theorem selectedBound7674 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7675 : List Nat := [2,4,8,16,32,17,8,53,0,1024,0,1077,56,1076,16,34,1060,1,1024,16,1076,49,1,3,57,1,0,1077,1061,0,1073,42,52,59,1061,1]

theorem envBound7675 : H12AffineFastState.Bounded env7675 := by
  intro p hp
  have h : env7675.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7674_7675 : H12AffineEnvironment.transform 7 53 env7674 = env7675 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 53 env7674 == env7675) = true)

def env7676 : List Nat := [2,4,8,0,32,1,8,37,0,1024,0,1061,40,1060,0,34,1060,1,1024,0,1060,33,1,3,41,1,0,1061,1061,0,1057,42,36,43,1061,1]

theorem envBound7676 : H12AffineFastState.Bounded env7676 := by
  intro p hp
  have h : env7676.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7675_7676 : H12AffineEnvironment.transform 3 0 env7675 = env7676 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7675 == env7676) = true)

def leafEnv7676 : List Nat := [2,4,8,0,32,1,8,37,0,1024,0,1061,40,1060,0,34,1060,1,1024,0,1060,33,1,3,1057,41,1,1,0,1061,1061,0,1057,42,36,43,5,34,1061,1,0,1060,1]

def active7676 : List Nat := [0,1,2,4,9]

def tree7676 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7676 : H12WitnessSearch.Good tree7676 := H12GlobalWitnessIndex.good

theorem leafIdentity7676 : H12AffineFastState.composeSystem env7676 rootObs = leafEnv7676 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7676 rootObs == leafEnv7676) = true)

theorem terminalChecked7676 : H12PackedTerminal.terminalCheckFast leafEnv7676 active7676 tree7676 = true := by decide +kernel

def env7677 : List Nat := [2,4,8,1,32,0,8,36,0,1024,0,1060,41,1061,1,34,1060,1,1024,1,1061,32,1,3,40,1,0,1060,1061,0,1056,42,37,42,1061,1]

theorem envBound7677 : H12AffineFastState.Bounded env7677 := by
  intro p hp
  have h : env7677.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7675_7677 : H12AffineEnvironment.transform 3 1 env7675 = env7677 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7675 == env7677) = true)

theorem identity7677 : scanCanonicalize (H12AffineFastState.compose env7677 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound7677 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7678 : List Nat := [2,4,3,1,32,0,3,36,0,1024,0,1060,34,1061,1,34,1060,1,1024,1,1061,32,1,3,35,1,0,1060,1061,0,1056,33,37,33,1061,1]

theorem envBound7678 : H12AffineFastState.Bounded env7678 := by
  intro p hp
  have h : env7678.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7677_7678 : H12AffineEnvironment.transform 2 3 env7677 = env7678 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env7677 == env7678) = true)

def leafEnv7678 : List Nat := [2,4,3,1,32,0,3,36,0,1024,0,1060,34,1061,1,34,1060,1,1024,1,1061,32,1,3,1056,35,1,1,0,1060,1061,0,1056,33,37,33,5,34,1061,1,0,1060,1]

def active7678 : List Nat := [0,1,4,9]

def tree7678 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7678 : H12WitnessSearch.Good tree7678 := H12GlobalWitnessIndex.good

theorem leafIdentity7678 : H12AffineFastState.composeSystem env7678 rootObs = leafEnv7678 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7678 rootObs == leafEnv7678) = true)

theorem terminalChecked7678 : H12PackedTerminal.terminalCheckFast leafEnv7678 active7678 tree7678 = true := by decide +kernel

def env7679 : List Nat := [2,4,8,16,32,64,9,256,1,1024,0,1077,269,1125,293,35,1344,1,1024,293,1076,260,357,2,269,308,0,1124,1296,0,1284,4294967296,257,4294967588,1345,0]

theorem envBound7679 : H12AffineFastState.Bounded env7679 := by
  intro p hp
  have h : env7679.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7666_7679 : H12AffineEnvironment.transform 6 9 env7666 = env7679 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env7666 == env7679) = true)

theorem identity7679 : scanCanonicalize (H12AffineFastState.compose env7679 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 271) := by decide +kernel

theorem selectedBound7679 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7680 : List Nat := [2,4,8,16,32,64,9,256,1,1024,0,1077,269,1125,293,35,1344,1,1024,293,1076,260,357,2,269,308,0,1124,1296,0,1284,271,257,43,1345,0]

theorem envBound7680 : H12AffineFastState.Bounded env7680 := by
  intro p hp
  have h : env7680.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7679_7680 : H12AffineEnvironment.transform 31 271 env7679 = env7680 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 271 env7679 == env7680) = true)

def env7681 : List Nat := [2,4,8,16,32,16,9,256,1,1024,0,1077,269,1077,293,35,1296,1,1024,293,1076,260,309,2,269,308,0,1076,1296,0,1284,271,257,43,1297,0]

theorem envBound7681 : H12AffineFastState.Bounded env7681 := by
  intro p hp
  have h : env7681.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7680_7681 : H12AffineEnvironment.transform 5 16 env7680 = env7681 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7680 == env7681) = true)

theorem identity7681 : scanCanonicalize (H12AffineFastState.compose env7681 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound7681 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7682 : List Nat := [2,4,8,1,32,1,9,256,1,1024,0,1060,269,1060,293,35,1281,1,1024,293,1061,260,292,2,269,293,0,1061,1281,0,1284,271,257,43,1280,0]

theorem envBound7682 : H12AffineFastState.Bounded env7682 := by
  intro p hp
  have h : env7682.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7681_7682 : H12AffineEnvironment.transform 3 1 env7681 = env7682 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7681 == env7682) = true)

def env7683 : List Nat := [2,4,8,1,32,1,9,36,1,1024,0,1060,41,1060,1,35,1061,1,1024,1,1061,32,0,2,41,1,0,1061,1061,0,1056,43,37,43,1060,0]

theorem envBound7683 : H12AffineFastState.Bounded env7683 := by
  intro p hp
  have h : env7683.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7682_7683 : H12AffineEnvironment.transform 7 36 env7682 = env7683 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env7682 == env7683) = true)

theorem identity7683 : scanCanonicalize (H12AffineFastState.compose env7683 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound7683 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7684 : List Nat := [2,4,2,1,32,1,3,36,1,1024,0,1060,35,1060,1,35,1061,1,1024,1,1061,32,0,2,35,1,0,1061,1061,0,1056,33,37,33,1060,0]

theorem envBound7684 : H12AffineFastState.Bounded env7684 := by
  intro p hp
  have h : env7684.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7683_7684 : H12AffineEnvironment.transform 2 2 env7683 = env7684 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env7683 == env7684) = true)

def leafEnv7684 : List Nat := [2,4,2,1,32,1,3,36,1,1024,0,1060,35,1060,1,35,1061,1,1024,1,1061,32,0,2,1056,35,1,1,0,1061,1061,0,1056,33,37,33,5,34,1060,0,0,1060,1]

def active7684 : List Nat := [0,1,4,9]

def tree7684 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7684 : H12WitnessSearch.Good tree7684 := H12GlobalWitnessIndex.good

theorem leafIdentity7684 : H12AffineFastState.composeSystem env7684 rootObs = leafEnv7684 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7684 rootObs == leafEnv7684) = true)

theorem terminalChecked7684 : H12PackedTerminal.terminalCheckFast leafEnv7684 active7684 tree7684 = true := by decide +kernel

def env7685 : List Nat := [2,4,8,1,32,1,9,37,1,1024,0,1060,40,1060,0,35,1060,1,1024,0,1061,33,1,2,40,0,0,1061,1060,0,1057,42,36,43,1061,0]

theorem envBound7685 : H12AffineFastState.Bounded env7685 := by
  intro p hp
  have h : env7685.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7682_7685 : H12AffineEnvironment.transform 7 37 env7682 = env7685 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env7682 == env7685) = true)

def leafEnv7685 : List Nat := [2,4,8,1,32,1,9,37,1,1024,0,1060,40,1060,0,35,1060,1,1024,0,1061,33,1,2,1057,40,1,0,0,1061,1060,0,1057,42,36,43,5,34,1061,0,0,1061,1]

def active7685 : List Nat := [0,1,2,4,9]

def tree7685 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7685 : H12WitnessSearch.Good tree7685 := H12GlobalWitnessIndex.good

theorem leafIdentity7685 : H12AffineFastState.composeSystem env7685 rootObs = leafEnv7685 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7685 rootObs == leafEnv7685) = true)

theorem terminalChecked7685 : H12PackedTerminal.terminalCheckFast leafEnv7685 active7685 tree7685 = true := by decide +kernel

def env7686 : List Nat := [2,4,8,16,32,17,9,256,1,1024,0,1077,269,1076,293,35,1297,1,1024,293,1076,260,308,2,269,308,0,1077,1296,0,1284,271,257,43,1296,0]

theorem envBound7686 : H12AffineFastState.Bounded env7686 := by
  intro p hp
  have h : env7686.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7680_7686 : H12AffineEnvironment.transform 5 17 env7680 = env7686 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7680 == env7686) = true)

theorem identity7686 : scanCanonicalize (H12AffineFastState.compose env7686 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 53) := by decide +kernel

theorem selectedBound7686 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7687 : List Nat := [2,4,8,16,32,17,9,53,1,1024,0,1077,56,1076,16,35,1060,1,1024,16,1076,49,1,2,56,1,0,1077,1061,0,1073,58,52,43,1061,0]

theorem envBound7687 : H12AffineFastState.Bounded env7687 := by
  intro p hp
  have h : env7687.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7686_7687 : H12AffineEnvironment.transform 7 53 env7686 = env7687 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 53 env7686 == env7687) = true)

def env7688 : List Nat := [2,4,8,0,32,1,9,37,1,1024,0,1061,40,1060,0,35,1060,1,1024,0,1060,33,1,2,40,1,0,1061,1061,0,1057,42,36,43,1061,0]

theorem envBound7688 : H12AffineFastState.Bounded env7688 := by
  intro p hp
  have h : env7688.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7687_7688 : H12AffineEnvironment.transform 3 0 env7687 = env7688 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7687 == env7688) = true)

def leafEnv7688 : List Nat := [2,4,8,0,32,1,9,37,1,1024,0,1061,40,1060,0,35,1060,1,1024,0,1060,33,1,2,1057,40,1,1,0,1061,1061,0,1057,42,36,43,5,34,1061,0,0,1060,1]

def active7688 : List Nat := [0,1,2,4,9]

def tree7688 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7688 : H12WitnessSearch.Good tree7688 := H12GlobalWitnessIndex.good

theorem leafIdentity7688 : H12AffineFastState.composeSystem env7688 rootObs = leafEnv7688 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7688 rootObs == leafEnv7688) = true)

theorem terminalChecked7688 : H12PackedTerminal.terminalCheckFast leafEnv7688 active7688 tree7688 = true := by decide +kernel

def env7689 : List Nat := [2,4,8,1,32,0,9,36,1,1024,0,1060,41,1061,1,35,1060,1,1024,1,1061,32,1,2,41,1,0,1060,1061,0,1056,43,37,43,1061,0]

theorem envBound7689 : H12AffineFastState.Bounded env7689 := by
  intro p hp
  have h : env7689.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7687_7689 : H12AffineEnvironment.transform 3 1 env7687 = env7689 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7687 == env7689) = true)

theorem identity7689 : scanCanonicalize (H12AffineFastState.compose env7689 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound7689 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7690 : List Nat := [2,4,2,1,32,0,3,36,1,1024,0,1060,35,1061,1,35,1060,1,1024,1,1061,32,1,2,35,1,0,1060,1061,0,1056,33,37,33,1061,0]

theorem envBound7690 : H12AffineFastState.Bounded env7690 := by
  intro p hp
  have h : env7690.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7689_7690 : H12AffineEnvironment.transform 2 2 env7689 = env7690 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env7689 == env7690) = true)

def leafEnv7690 : List Nat := [2,4,2,1,32,0,3,36,1,1024,0,1060,35,1061,1,35,1060,1,1024,1,1061,32,1,2,1056,35,1,1,0,1060,1061,0,1056,33,37,33,5,34,1061,0,0,1060,1]

def active7690 : List Nat := [0,1,4,9]

def tree7690 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7690 : H12WitnessSearch.Good tree7690 := H12GlobalWitnessIndex.good

theorem leafIdentity7690 : H12AffineFastState.composeSystem env7690 rootObs = leafEnv7690 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7690 rootObs == leafEnv7690) = true)

theorem terminalChecked7690 : H12PackedTerminal.terminalCheckFast leafEnv7690 active7690 tree7690 = true := by decide +kernel

def env7691 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,901,4824,293,65536,1344,1,1025,293,4097,908,6104,65569,780,5377,0,4825,1296,0,1284,4294967296,257,4295033231,1345,513]

theorem envBound7691 : H12AffineFastState.Bounded env7691 := by
  intro p hp
  have h : env7691.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7662_7691 : H12AffineEnvironment.transform 18 1025 env7662 = env7691 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env7662 == env7691) = true)

theorem identity7691 : scanCanonicalize (H12AffineFastState.compose env7691 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 547) := by decide +kernel

theorem selectedBound7691 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env7692 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,901,4824,293,547,1344,1,1025,293,4097,908,6104,514,780,5377,0,4825,1296,0,1284,4294967296,257,4294968236,1345,513]

theorem envBound7692 : H12AffineFastState.Bounded env7692 := by
  intro p hp
  have h : env7692.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7691_7692 : H12AffineEnvironment.transform 15 547 env7691 = env7692 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 547 env7691 == env7692) = true)

def env7693 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,269,4176,293,171,1344,1,1025,293,4097,260,5456,138,388,5377,0,4177,1296,0,1284,4294967296,257,4294967588,1345,137]

theorem envBound7693 : H12AffineFastState.Bounded env7693 := by
  intro p hp
  have h : env7693.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7692_7693 : H12AffineEnvironment.transform 8 136 env7692 = env7693 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env7692 == env7693) = true)

theorem identity7693 : scanCanonicalize (H12AffineFastState.compose env7693 (packedSelected [1,3] rootPS)) = affineNative (2^(11+1) ^^^ 1261) := by decide +kernel

theorem selectedBound7693 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7694 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,1261,269,1213,293,171,1344,1,1025,293,1260,260,445,138,388,492,0,1212,1296,0,1284,4294967296,257,4294967588,1345,137]

theorem envBound7694 : H12AffineFastState.Bounded env7694 := by
  intro p hp
  have h : env7694.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7693_7694 : H12AffineEnvironment.transform 11 1261 env7693 = env7694 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1261 env7693 == env7694) = true)

theorem identity7694 : scanCanonicalize (H12AffineFastState.compose env7694 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound7694 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env7695 : List Nat := [2,4,8,16,32,64,128,4,136,1024,0,1261,9,1213,33,171,1092,1,1025,33,1260,0,185,138,128,232,0,1212,1044,0,1024,4294967296,5,4294967328,1093,137]

theorem envBound7695 : H12AffineFastState.Bounded env7695 := by
  intro p hp
  have h : env7695.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7694_7695 : H12AffineEnvironment.transform 7 4 env7694 = env7695 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env7694 == env7695) = true)

theorem identity7695 : scanCanonicalize (H12AffineFastState.compose env7695 (packedSelected [5] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound7695 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env7696 : List Nat := [2,4,8,16,32,64,88,4,80,1024,0,1077,9,1125,33,115,1092,1,1025,33,1076,0,97,82,88,48,0,1124,1044,0,1024,4294967296,5,4294967328,1093,81]

theorem envBound7696 : H12AffineFastState.Bounded env7696 := by
  intro p hp
  have h : env7696.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7695_7696 : H12AffineEnvironment.transform 6 88 env7695 = env7696 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env7695 == env7696) = true)

theorem identity7696 : scanCanonicalize (H12AffineFastState.compose env7696 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 0) := by decide +kernel

theorem selectedBound7696 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7697 : List Nat := [2,4,8,16,32,64,88,4,80,1024,0,1077,9,1125,33,115,1092,1,1025,33,1076,0,97,82,88,48,0,1124,1044,0,1024,0,5,32,1093,81]

theorem envBound7697 : H12AffineFastState.Bounded env7697 := by
  intro p hp
  have h : env7697.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7696_7697 : H12AffineEnvironment.transform 31 0 env7696 = env7697 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 0 env7696 == env7697) = true)

theorem identity7697 : scanCanonicalize (H12AffineFastState.compose env7697 (packedSelected [0,2] rootPS)) = affineNative (2^(5+1) ^^^ 42) := by decide +kernel

theorem selectedBound7697 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env7698 : List Nat := [2,4,8,16,32,42,50,4,58,1024,0,1077,9,1039,33,25,1070,1,1025,33,1076,0,11,56,50,48,0,1038,1044,0,1024,0,5,32,1071,59]

theorem envBound7698 : H12AffineFastState.Bounded env7698 := by
  intro p hp
  have h : env7698.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7697_7698 : H12AffineEnvironment.transform 5 42 env7697 = env7698 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 42 env7697 == env7698) = true)

def env7699 : List Nat := [2,4,8,16,0,10,18,4,26,1024,0,1045,9,1039,1,25,1038,1,1025,1,1044,0,11,24,18,16,0,1038,1044,0,1024,0,5,0,1039,27]

theorem envBound7699 : H12AffineFastState.Bounded env7699 := by
  intro p hp
  have h : env7699.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7698_7699 : H12AffineEnvironment.transform 4 0 env7698 = env7699 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env7698 == env7699) = true)

theorem identity7699 : scanCanonicalize (H12AffineFastState.compose env7699 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound7699 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7700 : List Nat := [2,4,8,0,0,10,2,4,10,1024,0,1029,9,1039,1,9,1038,1,1025,1,1028,0,11,8,2,0,0,1038,1028,0,1024,0,5,0,1039,11]

theorem envBound7700 : H12AffineFastState.Bounded env7700 := by
  intro p hp
  have h : env7700.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7699_7700 : H12AffineEnvironment.transform 3 0 env7699 = env7700 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7699 == env7700) = true)

def leafEnv7700 : List Nat := [2,4,8,0,0,10,2,4,10,1024,0,1029,9,1039,1,9,1038,1,1025,1,1028,0,11,8,1025,2,1,0,0,1038,1028,0,1024,0,5,0,5,2,1039,11,0,1029,1]

def active7700 : List Nat := [0,1,2,9]

def tree7700 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7700 : H12WitnessSearch.Good tree7700 := H12GlobalWitnessIndex.good

theorem leafIdentity7700 : H12AffineFastState.composeSystem env7700 rootObs = leafEnv7700 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7700 rootObs == leafEnv7700) = true)

theorem terminalChecked7700 : H12PackedTerminal.terminalCheckFast leafEnv7700 active7700 tree7700 = true := by decide +kernel

def env7701 : List Nat := [2,4,8,16,1,11,19,4,27,1024,0,1044,9,1039,0,25,1039,1,1025,0,1045,0,11,25,19,17,0,1038,1044,0,1024,0,5,1,1038,26]

theorem envBound7701 : H12AffineFastState.Bounded env7701 := by
  intro p hp
  have h : env7701.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7698_7701 : H12AffineEnvironment.transform 4 1 env7698 = env7701 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env7698 == env7701) = true)

theorem identity7701 : scanCanonicalize (H12AffineFastState.compose env7701 (packedSelected [0] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound7701 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7702 : List Nat := [2,4,2,16,1,1,19,4,17,1024,0,1044,3,1029,0,19,1029,1,1025,0,1045,0,1,19,19,17,0,1028,1044,0,1024,0,5,1,1028,16]

theorem envBound7702 : H12AffineFastState.Bounded env7702 := by
  intro p hp
  have h : env7702.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7701_7702 : H12AffineEnvironment.transform 2 2 env7701 = env7702 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env7701 == env7702) = true)

def leafEnv7702 : List Nat := [2,4,2,16,1,1,19,4,17,1024,0,1044,3,1029,0,19,1029,1,1025,0,1045,0,1,19,1025,19,1,17,0,1028,1044,0,1024,0,5,1,5,3,1028,16,0,1045,1]

def active7702 : List Nat := [0,1,3,9]

def tree7702 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7702 : H12WitnessSearch.Good tree7702 := H12GlobalWitnessIndex.good

theorem leafIdentity7702 : H12AffineFastState.composeSystem env7702 rootObs = leafEnv7702 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7702 rootObs == leafEnv7702) = true)

theorem terminalChecked7702 : H12PackedTerminal.terminalCheckFast leafEnv7702 active7702 tree7702 = true := by decide +kernel

def env7703 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,268,4177,293,170,1344,1,1025,293,4097,261,5457,139,389,5377,0,4176,1296,0,1284,4294967296,257,4294967589,1345,136]

theorem envBound7703 : H12AffineFastState.Bounded env7703 := by
  intro p hp
  have h : env7703.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7692_7703 : H12AffineEnvironment.transform 8 137 env7692 = env7703 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env7692 == env7703) = true)

theorem identity7703 : scanCanonicalize (H12AffineFastState.compose env7703 (packedSelected [1,3] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound7703 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7704 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1297,268,1344,293,170,1344,1,1025,293,1296,261,64,139,389,16,0,1345,1296,0,1284,4294967296,257,4294967589,1345,136]

theorem envBound7704 : H12AffineFastState.Bounded env7704 := by
  intro p hp
  have h : env7704.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7703_7704 : H12AffineEnvironment.transform 11 1297 env7703 = env7704 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env7703 == env7704) = true)

def env7705 : List Nat := [2,4,8,16,32,64,8,256,1,1024,0,1297,268,1344,293,34,1344,1,1025,293,1296,261,64,3,269,16,0,1345,1296,0,1284,4294967296,257,4294967589,1345,0]

theorem envBound7705 : H12AffineFastState.Bounded env7705 := by
  intro p hp
  have h : env7705.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7704_7705 : H12AffineEnvironment.transform 6 8 env7704 = env7705 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env7704 == env7705) = true)

theorem identity7705 : scanCanonicalize (H12AffineFastState.compose env7705 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 123) := by decide +kernel

theorem selectedBound7705 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7706 : List Nat := [2,4,8,16,32,64,8,256,1,1024,0,1297,268,1344,293,34,1344,1,1025,293,1296,261,64,3,269,16,0,1345,1296,0,1284,123,257,350,1345,0]

theorem envBound7706 : H12AffineFastState.Bounded env7706 := by
  intro p hp
  have h : env7706.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7705_7706 : H12AffineEnvironment.transform 31 123 env7705 = env7706 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 123 env7705 == env7706) = true)

def env7707 : List Nat := [2,4,8,16,32,16,8,256,1,1024,0,1297,268,1296,293,34,1296,1,1025,293,1296,261,16,3,269,16,0,1297,1296,0,1284,43,257,270,1297,0]

theorem envBound7707 : H12AffineFastState.Bounded env7707 := by
  intro p hp
  have h : env7707.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7706_7707 : H12AffineEnvironment.transform 5 16 env7706 = env7707 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7706 == env7707) = true)

theorem identity7707 : scanCanonicalize (H12AffineFastState.compose env7707 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 31) := by decide +kernel

theorem selectedBound7707 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7708 : List Nat := [2,4,8,16,32,16,8,31,1,1024,0,1038,19,1039,58,34,1039,1,1025,58,1039,26,16,3,18,16,0,1038,1039,0,1051,43,30,17,1038,0]

theorem envBound7708 : H12AffineFastState.Bounded env7708 := by
  intro p hp
  have h : env7708.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7707_7708 : H12AffineEnvironment.transform 7 31 env7707 = env7708 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 31 env7707 == env7708) = true)

def env7709 : List Nat := [2,4,8,16,16,16,8,31,1,1024,0,1038,19,1039,10,18,1039,1,1025,10,1039,26,16,3,18,16,0,1038,1039,0,1051,27,30,17,1038,0]

theorem envBound7709 : H12AffineFastState.Bounded env7709 := by
  intro p hp
  have h : env7709.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7708_7709 : H12AffineEnvironment.transform 4 16 env7708 = env7709 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env7708 == env7709) = true)

theorem identity7709 : scanCanonicalize (H12AffineFastState.compose env7709 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound7709 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7710 : List Nat := [2,4,8,10,10,10,8,5,1,1024,0,1038,9,1039,10,8,1039,1,1025,10,1039,0,10,3,8,10,0,1038,1039,0,1025,1,4,11,1038,0]

theorem envBound7710 : H12AffineFastState.Bounded env7710 := by
  intro p hp
  have h : env7710.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7709_7710 : H12AffineEnvironment.transform 3 10 env7709 = env7710 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env7709 == env7710) = true)

def leafEnv7710 : List Nat := [2,4,8,10,10,10,8,5,1,1024,0,1038,9,1039,10,8,1039,1,1025,10,1039,0,10,3,1024,8,1,10,0,1038,1039,0,1025,1,4,11,5,8,1038,0,0,1038,1]

def active7710 : List Nat := [0,1,2,9]

def tree7710 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7710 : H12WitnessSearch.Good tree7710 := H12GlobalWitnessIndex.good

theorem leafIdentity7710 : H12AffineFastState.composeSystem env7710 rootObs = leafEnv7710 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7710 rootObs == leafEnv7710) = true)

theorem terminalChecked7710 : H12PackedTerminal.terminalCheckFast leafEnv7710 active7710 tree7710 = true := by decide +kernel

def env7711 : List Nat := [2,4,8,16,17,16,8,31,1,1024,0,1038,19,1039,11,19,1039,1,1025,11,1039,26,16,3,18,16,0,1038,1039,0,1051,26,30,17,1038,0]

theorem envBound7711 : H12AffineFastState.Bounded env7711 := by
  intro p hp
  have h : env7711.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7708_7711 : H12AffineEnvironment.transform 4 17 env7708 = env7711 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env7708 == env7711) = true)

theorem identity7711 : scanCanonicalize (H12AffineFastState.compose env7711 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound7711 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7712 : List Nat := [2,4,8,0,1,0,8,15,1,1024,0,1038,3,1039,11,3,1039,1,1025,11,1039,10,0,3,2,0,0,1038,1039,0,1035,10,14,1,1038,0]

theorem envBound7712 : H12AffineFastState.Bounded env7712 := by
  intro p hp
  have h : env7712.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7711_7712 : H12AffineEnvironment.transform 3 0 env7711 = env7712 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7711 == env7712) = true)

def leafEnv7712 : List Nat := [2,4,8,0,1,0,8,15,1,1024,0,1038,3,1039,11,3,1039,1,1025,11,1039,10,0,3,1034,2,1,0,0,1038,1039,0,1035,10,14,1,5,3,1038,0,0,1038,1]

def active7712 : List Nat := [0,1,2,9]

def tree7712 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7712 : H12WitnessSearch.Good tree7712 := H12GlobalWitnessIndex.good

theorem leafIdentity7712 : H12AffineFastState.composeSystem env7712 rootObs = leafEnv7712 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7712 rootObs == leafEnv7712) = true)

theorem terminalChecked7712 : H12PackedTerminal.terminalCheckFast leafEnv7712 active7712 tree7712 = true := by decide +kernel

def env7713 : List Nat := [2,4,8,16,32,17,8,256,1,1024,0,1297,268,1297,293,34,1297,1,1025,293,1296,261,17,3,269,16,0,1296,1296,0,1284,42,257,271,1296,0]

theorem envBound7713 : H12AffineFastState.Bounded env7713 := by
  intro p hp
  have h : env7713.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7706_7713 : H12AffineEnvironment.transform 5 17 env7706 = env7713 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7706 == env7713) = true)

theorem identity7713 : scanCanonicalize (H12AffineFastState.compose env7713 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 27) := by decide +kernel

theorem selectedBound7713 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7714 : List Nat := [2,4,8,16,27,17,8,256,1,1024,0,1297,268,1297,286,25,1297,1,1025,286,1296,261,17,3,269,16,0,1296,1296,0,1284,17,257,271,1296,0]

theorem envBound7714 : H12AffineFastState.Bounded env7714 := by
  intro p hp
  have h : env7714.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7713_7714 : H12AffineEnvironment.transform 4 27 env7713 = env7714 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 27 env7713 == env7714) = true)

def env7715 : List Nat := [2,4,8,16,27,17,8,20,1,1024,0,1029,24,1029,10,25,1029,1,1025,10,1028,17,17,3,25,16,0,1028,1028,0,1040,17,21,27,1028,0]

theorem envBound7715 : H12AffineFastState.Bounded env7715 := by
  intro p hp
  have h : env7715.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7714_7715 : H12AffineEnvironment.transform 7 20 env7714 = env7715 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 20 env7714 == env7715) = true)

theorem identity7715 : scanCanonicalize (H12AffineFastState.compose env7715 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound7715 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7716 : List Nat := [2,4,8,11,0,10,8,15,1,1024,0,1029,3,1029,10,2,1029,1,1025,10,1028,10,10,3,2,11,0,1028,1028,0,1035,10,14,0,1028,0]

theorem envBound7716 : H12AffineFastState.Bounded env7716 := by
  intro p hp
  have h : env7716.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7715_7716 : H12AffineEnvironment.transform 3 11 env7715 = env7716 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env7715 == env7716) = true)

def leafEnv7716 : List Nat := [2,4,8,11,0,10,8,15,1,1024,0,1029,3,1029,10,2,1029,1,1025,10,1028,10,10,3,1034,2,1,11,0,1028,1028,0,1035,10,14,0,5,2,1028,0,0,1029,1]

def active7716 : List Nat := [0,1,2,9]

def tree7716 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7716 : H12WitnessSearch.Good tree7716 := H12GlobalWitnessIndex.good

theorem leafIdentity7716 : H12AffineFastState.composeSystem env7716 rootObs = leafEnv7716 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7716 rootObs == leafEnv7716) = true)

theorem terminalChecked7716 : H12PackedTerminal.terminalCheckFast leafEnv7716 active7716 tree7716 = true := by decide +kernel

def env7717 : List Nat := [2,4,8,16,27,17,8,21,1,1024,0,1028,25,1028,11,25,1028,1,1025,11,1029,16,17,3,24,16,0,1029,1029,0,1041,17,20,26,1029,0]

theorem envBound7717 : H12AffineFastState.Bounded env7717 := by
  intro p hp
  have h : env7717.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7714_7717 : H12AffineEnvironment.transform 7 21 env7714 = env7717 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 21 env7714 == env7717) = true)

theorem identity7717 : scanCanonicalize (H12AffineFastState.compose env7717 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound7717 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7718 : List Nat := [2,4,8,1,10,0,8,4,1,1024,0,1028,8,1028,11,8,1028,1,1025,11,1029,1,0,3,9,1,0,1029,1029,0,1024,0,5,11,1029,0]

theorem envBound7718 : H12AffineFastState.Bounded env7718 := by
  intro p hp
  have h : env7718.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7717_7718 : H12AffineEnvironment.transform 3 1 env7717 = env7718 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7717 == env7718) = true)

def leafEnv7718 : List Nat := [2,4,8,1,10,0,8,4,1,1024,0,1028,8,1028,11,8,1028,1,1025,11,1029,1,0,3,1025,9,1,1,0,1029,1029,0,1024,0,5,11,5,8,1029,0,0,1028,1]

def active7718 : List Nat := [0,1,2,9]

def tree7718 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7718 : H12WitnessSearch.Good tree7718 := H12GlobalWitnessIndex.good

theorem leafIdentity7718 : H12AffineFastState.composeSystem env7718 rootObs = leafEnv7718 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7718 rootObs == leafEnv7718) = true)

theorem terminalChecked7718 : H12PackedTerminal.terminalCheckFast leafEnv7718 active7718 tree7718 = true := by decide +kernel

def env7719 : List Nat := [2,4,8,16,32,64,9,256,0,1024,0,1297,268,1344,293,35,1344,1,1025,293,1296,261,64,2,268,16,0,1345,1296,0,1284,4294967296,257,4294967589,1345,1]

theorem envBound7719 : H12AffineFastState.Bounded env7719 := by
  intro p hp
  have h : env7719.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7704_7719 : H12AffineEnvironment.transform 6 9 env7704 = env7719 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env7704 == env7719) = true)

theorem identity7719 : scanCanonicalize (H12AffineFastState.compose env7719 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 351) := by decide +kernel

theorem selectedBound7719 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7720 : List Nat := [2,4,8,16,32,64,9,256,0,1024,0,1297,268,1344,293,35,1344,1,1025,293,1296,261,64,2,268,16,0,1345,1296,0,1284,351,257,122,1345,1]

theorem envBound7720 : H12AffineFastState.Bounded env7720 := by
  intro p hp
  have h : env7720.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7719_7720 : H12AffineEnvironment.transform 31 351 env7719 = env7720 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 351 env7719 == env7720) = true)

def env7721 : List Nat := [2,4,8,16,32,16,9,256,0,1024,0,1297,268,1296,293,35,1296,1,1025,293,1296,261,16,2,268,16,0,1297,1296,0,1284,271,257,42,1297,1]

theorem envBound7721 : H12AffineFastState.Bounded env7721 := by
  intro p hp
  have h : env7721.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7720_7721 : H12AffineEnvironment.transform 5 16 env7720 = env7721 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7720 == env7721) = true)

theorem identity7721 : scanCanonicalize (H12AffineFastState.compose env7721 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 27) := by decide +kernel

theorem selectedBound7721 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7722 : List Nat := [2,4,8,16,27,16,9,256,0,1024,0,1297,268,1296,286,24,1296,1,1025,286,1296,261,16,2,268,16,0,1297,1296,0,1284,271,257,17,1297,1]

theorem envBound7722 : H12AffineFastState.Bounded env7722 := by
  intro p hp
  have h : env7722.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7721_7722 : H12AffineEnvironment.transform 4 27 env7721 = env7722 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 27 env7721 == env7722) = true)

def env7723 : List Nat := [2,4,8,16,27,16,9,20,0,1024,0,1029,24,1028,10,24,1028,1,1025,10,1028,17,16,2,24,16,0,1029,1028,0,1040,27,21,17,1029,1]

theorem envBound7723 : H12AffineFastState.Bounded env7723 := by
  intro p hp
  have h : env7723.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7722_7723 : H12AffineEnvironment.transform 7 20 env7722 = env7723 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 20 env7722 == env7723) = true)

theorem identity7723 : scanCanonicalize (H12AffineFastState.compose env7723 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound7723 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7724 : List Nat := [2,4,8,10,1,10,9,14,0,1024,0,1029,2,1028,10,2,1028,1,1025,10,1028,11,10,2,2,10,0,1029,1028,0,1034,1,15,11,1029,1]

theorem envBound7724 : H12AffineFastState.Bounded env7724 := by
  intro p hp
  have h : env7724.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7723_7724 : H12AffineEnvironment.transform 3 10 env7723 = env7724 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env7723 == env7724) = true)

def leafEnv7724 : List Nat := [2,4,8,10,1,10,9,14,0,1024,0,1029,2,1028,10,2,1028,1,1025,10,1028,11,10,2,1035,2,1,10,0,1029,1028,0,1034,1,15,11,5,3,1029,1,0,1029,1]

def active7724 : List Nat := [0,1,2,9]

def tree7724 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7724 : H12WitnessSearch.Good tree7724 := H12GlobalWitnessIndex.good

theorem leafIdentity7724 : H12AffineFastState.composeSystem env7724 rootObs = leafEnv7724 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7724 rootObs == leafEnv7724) = true)

theorem terminalChecked7724 : H12PackedTerminal.terminalCheckFast leafEnv7724 active7724 tree7724 = true := by decide +kernel

def env7725 : List Nat := [2,4,8,16,27,16,9,21,0,1024,0,1028,25,1029,11,24,1029,1,1025,11,1029,16,16,2,25,16,0,1028,1029,0,1041,26,20,17,1028,1]

theorem envBound7725 : H12AffineFastState.Bounded env7725 := by
  intro p hp
  have h : env7725.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7722_7725 : H12AffineEnvironment.transform 7 21 env7722 = env7725 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 21 env7722 == env7725) = true)

theorem identity7725 : scanCanonicalize (H12AffineFastState.compose env7725 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound7725 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7726 : List Nat := [2,4,8,0,11,0,9,5,0,1024,0,1028,9,1029,11,8,1029,1,1025,11,1029,0,0,2,9,0,0,1028,1029,0,1025,10,4,1,1028,1]

theorem envBound7726 : H12AffineFastState.Bounded env7726 := by
  intro p hp
  have h : env7726.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7725_7726 : H12AffineEnvironment.transform 3 0 env7725 = env7726 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7725 == env7726) = true)

def leafEnv7726 : List Nat := [2,4,8,0,11,0,9,5,0,1024,0,1028,9,1029,11,8,1029,1,1025,11,1029,0,0,2,1024,9,1,0,0,1028,1029,0,1025,10,4,1,5,9,1028,1,0,1028,1]

def active7726 : List Nat := [0,1,2,9]

def tree7726 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7726 : H12WitnessSearch.Good tree7726 := H12GlobalWitnessIndex.good

theorem leafIdentity7726 : H12AffineFastState.composeSystem env7726 rootObs = leafEnv7726 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7726 rootObs == leafEnv7726) = true)

theorem terminalChecked7726 : H12PackedTerminal.terminalCheckFast leafEnv7726 active7726 tree7726 = true := by decide +kernel

def env7727 : List Nat := [2,4,8,16,32,17,9,256,0,1024,0,1297,268,1297,293,35,1297,1,1025,293,1296,261,17,2,268,16,0,1296,1296,0,1284,270,257,43,1296,1]

theorem envBound7727 : H12AffineFastState.Bounded env7727 := by
  intro p hp
  have h : env7727.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7720_7727 : H12AffineEnvironment.transform 5 17 env7720 = env7727 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7720 == env7727) = true)

theorem identity7727 : scanCanonicalize (H12AffineFastState.compose env7727 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 31) := by decide +kernel

theorem selectedBound7727 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7728 : List Nat := [2,4,8,16,32,17,9,31,0,1024,0,1038,19,1038,58,35,1038,1,1025,58,1039,26,17,2,19,16,0,1039,1039,0,1051,17,30,43,1039,1]

theorem envBound7728 : H12AffineFastState.Bounded env7728 := by
  intro p hp
  have h : env7728.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7727_7728 : H12AffineEnvironment.transform 7 31 env7727 = env7728 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 31 env7727 == env7728) = true)

def env7729 : List Nat := [2,4,8,16,16,17,9,31,0,1024,0,1038,19,1038,10,19,1038,1,1025,10,1039,26,17,2,19,16,0,1039,1039,0,1051,17,30,27,1039,1]

theorem envBound7729 : H12AffineFastState.Bounded env7729 := by
  intro p hp
  have h : env7729.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7728_7729 : H12AffineEnvironment.transform 4 16 env7728 = env7729 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env7728 == env7729) = true)

theorem identity7729 : scanCanonicalize (H12AffineFastState.compose env7729 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound7729 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7730 : List Nat := [2,4,8,11,11,10,9,4,0,1024,0,1038,8,1038,10,8,1038,1,1025,10,1039,1,10,2,8,11,0,1039,1039,0,1024,10,5,0,1039,1]

theorem envBound7730 : H12AffineFastState.Bounded env7730 := by
  intro p hp
  have h : env7730.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7729_7730 : H12AffineEnvironment.transform 3 11 env7729 = env7730 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env7729 == env7730) = true)

def leafEnv7730 : List Nat := [2,4,8,11,11,10,9,4,0,1024,0,1038,8,1038,10,8,1038,1,1025,10,1039,1,10,2,1025,8,1,11,0,1039,1039,0,1024,10,5,0,5,9,1039,1,0,1038,1]

def active7730 : List Nat := [0,1,2,9]

def tree7730 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7730 : H12WitnessSearch.Good tree7730 := H12GlobalWitnessIndex.good

theorem leafIdentity7730 : H12AffineFastState.composeSystem env7730 rootObs = leafEnv7730 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7730 rootObs == leafEnv7730) = true)

theorem terminalChecked7730 : H12PackedTerminal.terminalCheckFast leafEnv7730 active7730 tree7730 = true := by decide +kernel

def env7731 : List Nat := [2,4,8,16,17,17,9,31,0,1024,0,1038,19,1038,11,18,1038,1,1025,11,1039,26,17,2,19,16,0,1039,1039,0,1051,17,30,26,1039,1]

theorem envBound7731 : H12AffineFastState.Bounded env7731 := by
  intro p hp
  have h : env7731.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7728_7731 : H12AffineEnvironment.transform 4 17 env7728 = env7731 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env7728 == env7731) = true)

theorem identity7731 : scanCanonicalize (H12AffineFastState.compose env7731 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound7731 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7732 : List Nat := [2,4,8,1,0,0,9,14,0,1024,0,1038,2,1038,11,3,1038,1,1025,11,1039,11,0,2,2,1,0,1039,1039,0,1034,0,15,11,1039,1]

theorem envBound7732 : H12AffineFastState.Bounded env7732 := by
  intro p hp
  have h : env7732.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7731_7732 : H12AffineEnvironment.transform 3 1 env7731 = env7732 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7731 == env7732) = true)

def leafEnv7732 : List Nat := [2,4,8,1,0,0,9,14,0,1024,0,1038,2,1038,11,3,1038,1,1025,11,1039,11,0,2,1035,2,1,1,0,1039,1039,0,1034,0,15,11,5,2,1039,1,0,1038,1]

def active7732 : List Nat := [0,1,2,9]

def tree7732 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7732 : H12WitnessSearch.Good tree7732 := H12GlobalWitnessIndex.good

theorem leafIdentity7732 : H12AffineFastState.composeSystem env7732 rootObs = leafEnv7732 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7732 rootObs == leafEnv7732) = true)

theorem terminalChecked7732 : H12PackedTerminal.terminalCheckFast leafEnv7732 active7732 tree7732 = true := by decide +kernel

def env7733 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4824,8864,65536,1345,1,524288,8864,4097,8201,6104,74661,8329,5377,9092,4825,1297,9092,1285,4294967296,257,4295558543,1344,513]

theorem envBound7733 : H12AffineFastState.Bounded env7733 := by
  intro p hp
  have h : env7733.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7660_7733 : H12AffineEnvironment.transform 16 1345 env7660 = env7733 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env7660 == env7733) = true)

theorem identity7733 : scanCanonicalize (H12AffineFastState.compose env7733 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(12+1) ^^^ 269) := by decide +kernel

theorem selectedBound7733 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env7734 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,269,4824,941,65536,1345,1,524288,941,4097,260,6104,66216,388,5377,649,4825,1297,649,1285,4294967296,257,4295558543,1344,513]

theorem envBound7734 : H12AffineFastState.Bounded env7734 := by
  intro p hp
  have h : env7734.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7733_7734 : H12AffineEnvironment.transform 12 269 env7733 = env7734 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 269 env7733 == env7734) = true)

theorem identity7734 : scanCanonicalize (H12AffineFastState.compose env7734 (packedSelected [4,9] rootPS)) = affineNative (2^(18+1) ^^^ 4368) := by decide +kernel

theorem selectedBound7734 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env7735 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,269,4824,941,65536,1345,1,4368,941,4097,260,6104,66216,388,5377,649,4825,1297,649,1285,4294967296,257,4295038111,1344,513]

theorem envBound7735 : H12AffineFastState.Bounded env7735 := by
  intro p hp
  have h : env7735.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7734_7735 : H12AffineEnvironment.transform 18 4368 env7734 = env7735 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 4368 env7734 == env7735) = true)

theorem identity7735 : scanCanonicalize (H12AffineFastState.compose env7735 (packedSelected [3,8,10,12] rootPS)) = affineNative (2^(15+1) ^^^ 5279) := by decide +kernel

theorem selectedBound7735 : packedSelected [3,8,10,12] rootPS < 2^1333 := by decide +kernel

def env7736 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,269,4824,941,5279,1345,1,4368,941,4097,260,6104,5687,388,5377,649,4825,1297,649,1285,4294967296,257,4294967296,1344,513]

theorem envBound7736 : H12AffineFastState.Bounded env7736 := by
  intro p hp
  have h : env7736.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7735_7736 : H12AffineEnvironment.transform 15 5279 env7735 = env7736 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5279 env7735 == env7736) = true)

theorem identity7736 : scanCanonicalize (H12AffineFastState.compose env7736 (packedSelected [0,1,2,4,5,6,10] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound7736 : packedSelected [0,1,2,4,5,6,10] rootPS < 2^1333 := by decide +kernel

def env7737 : List Nat := [2,4,8,16,32,64,128,36,512,1024,0,4096,41,4824,649,5279,1125,1,4148,649,4097,32,5884,5687,160,5157,649,4825,1077,649,1057,4294967296,37,4294967296,1124,513]

theorem envBound7737 : H12AffineFastState.Bounded env7737 := by
  intro p hp
  have h : env7737.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7736_7737 : H12AffineEnvironment.transform 7 36 env7736 = env7737 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env7736 == env7737) = true)

theorem identity7737 : scanCanonicalize (H12AffineFastState.compose env7737 (packedSelected [1,2,3,4,5] rootPS)) = affineNative (2^(8+1) ^^^ 195) := by decide +kernel

theorem selectedBound7737 : packedSelected [1,2,3,4,5] rootPS < 2^1333 := by decide +kernel

def env7738 : List Nat := [2,4,8,16,32,64,128,36,195,1024,0,4096,41,4123,74,5279,1125,1,4148,74,4097,32,5183,5364,160,5157,74,4122,1077,74,1057,4294967296,37,4294967296,1124,194]

theorem envBound7738 : H12AffineFastState.Bounded env7738 := by
  intro p hp
  have h : env7738.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7737_7738 : H12AffineEnvironment.transform 8 195 env7737 = env7738 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 195 env7737 == env7738) = true)

theorem identity7738 : scanCanonicalize (H12AffineFastState.compose env7738 (packedSelected [0,1,4,6] rootPS)) = affineNative (2^(31+1) ^^^ 5246) := by decide +kernel

theorem selectedBound7738 : packedSelected [0,1,4,6] rootPS < 2^1333 := by decide +kernel

def env7739 : List Nat := [2,4,8,16,32,64,128,36,195,1024,0,4096,41,4123,74,5279,1125,1,4148,74,4097,32,5183,5364,160,5157,74,4122,1077,74,1057,5246,37,5246,1124,194]

theorem envBound7739 : H12AffineFastState.Bounded env7739 := by
  intro p hp
  have h : env7739.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7738_7739 : H12AffineEnvironment.transform 31 5246 env7738 = env7739 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 5246 env7738 == env7739) = true)

theorem identity7739 : scanCanonicalize (H12AffineFastState.compose env7739 (packedSelected [3,4,8] rootPS)) = affineNative (2^(11+1) ^^^ 1076) := by decide +kernel

theorem selectedBound7739 : packedSelected [3,4,8] rootPS < 2^1333 := by decide +kernel

def env7740 : List Nat := [2,4,8,16,32,64,128,36,195,1024,0,1076,41,1071,74,171,1125,1,1024,74,1077,32,11,192,160,17,74,1070,1077,74,1057,74,37,74,1124,194]

theorem envBound7740 : H12AffineFastState.Bounded env7740 := by
  intro p hp
  have h : env7740.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7739_7740 : H12AffineEnvironment.transform 11 1076 env7739 = env7740 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1076 env7739 == env7740) = true)

theorem identity7740 : scanCanonicalize (H12AffineFastState.compose env7740 (packedSelected [0,1,3] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound7740 : packedSelected [0,1,3] rootPS < 2^1333 := by decide +kernel

def env7741 : List Nat := [2,4,8,16,32,11,128,36,136,1024,0,1076,41,1071,1,171,1070,1,1024,1,1077,32,11,139,160,17,1,1070,1077,1,1057,1,37,1,1071,137]

theorem envBound7741 : H12AffineFastState.Bounded env7741 := by
  intro p hp
  have h : env7741.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7740_7741 : H12AffineEnvironment.transform 5 11 env7740 = env7741 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env7740 == env7741) = true)

def env7742 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4825,32768,65536,131072,262144,524288,32768,4097,8201,6105,230468,8329,5377,403141,4824,131152,164964,131140,4294967296,257,4295729775,131073,513]

theorem envBound7742 : H12AffineFastState.Bounded env7742 := by
  intro p hp
  have h : env7742.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7657_7742 : H12AffineEnvironment.transform 13 4825 env7657 = env7742 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4825 env7657 == env7742) = true)

theorem identity7742 : scanCanonicalize (H12AffineFastState.compose env7742 (packedSelected [0,2,6,9,23] rootPS)) = affineNative (2^(16+1) ^^^ 75375) := by decide +kernel

theorem selectedBound7742 : packedSelected [0,2,6,9,23] rootPS < 2^1333 := by decide +kernel

def env7743 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4825,32768,65536,75375,262144,524288,32768,4097,8201,6105,41515,8329,5377,327850,4824,75327,107019,75307,4294967296,257,4295525376,75374,513]

theorem envBound7743 : H12AffineFastState.Bounded env7743 := by
  intro p hp
  have h : env7743.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7742_7743 : H12AffineEnvironment.transform 16 75375 env7742 = env7743 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 75375 env7742 == env7743) = true)

theorem identity7743 : scanCanonicalize (H12AffineFastState.compose env7743 (packedSelected [0,1,3,5,7,8,9,10,19,20,22] rootPS)) = affineNative (2^(18+1) ^^^ 1673) := by decide +kernel

theorem selectedBound7743 : packedSelected [0,1,3,5,7,8,9,10,19,20,22] rootPS < 2^1333 := by decide +kernel

def env7744 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4825,32768,65536,75375,262144,1673,32768,4097,8201,6105,41515,8329,5377,327850,4824,75327,107019,75307,4294967296,257,4295000713,75374,513]

theorem envBound7744 : H12AffineFastState.Bounded env7744 := by
  intro p hp
  have h : env7744.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7743_7744 : H12AffineEnvironment.transform 18 1673 env7743 = env7744 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1673 env7743 == env7744) = true)

theorem identity7744 : scanCanonicalize (H12AffineFastState.compose env7744 (packedSelected [4,9,18,32] rootPS)) = affineNative (2^(14+1) ^^^ 8864) := by decide +kernel

theorem selectedBound7744 : packedSelected [4,9,18,32] rootPS < 2^1333 := by decide +kernel

def env7745 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4825,8864,65536,75375,262144,1673,8864,4097,8201,6105,139,8329,5377,327850,4824,75327,65707,75307,4294967296,257,4294975529,75374,513]

theorem envBound7745 : H12AffineFastState.Bounded env7745 := by
  intro p hp
  have h : env7745.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7744_7745 : H12AffineEnvironment.transform 14 8864 env7744 = env7745 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8864 env7744 == env7745) = true)

theorem identity7745 : scanCanonicalize (H12AffineFastState.compose env7745 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(17+1) ^^^ 0) := by decide +kernel

theorem selectedBound7745 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env7746 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4825,8864,65536,75375,0,1673,8864,4097,8201,6105,139,8329,5377,65706,4824,75327,65707,75307,4294967296,257,4294975529,75374,513]

theorem envBound7746 : H12AffineFastState.Bounded env7746 := by
  intro p hp
  have h : env7746.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7745_7746 : H12AffineEnvironment.transform 17 0 env7745 = env7746 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env7745 == env7746) = true)

def env7747 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,1993,8864,65536,75375,0,1673,8864,1297,8201,713,139,8329,17,65706,1992,75327,65707,75307,4294967296,257,4294975529,75374,513]

theorem envBound7747 : H12AffineFastState.Bounded env7747 := by
  intro p hp
  have h : env7747.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7746_7747 : H12AffineEnvironment.transform 11 1296 env7746 = env7747 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env7746 == env7747) = true)

theorem identity7747 : scanCanonicalize (H12AffineFastState.compose env7747 (packedSelected [4,9] rootPS)) = affineNative (2^(15+1) ^^^ 9006) := by decide +kernel

theorem selectedBound7747 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env7748 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,1993,8864,9006,1345,0,1673,8864,1297,8201,713,139,8329,17,9092,1992,1297,9093,1285,4294967296,257,4294975529,1344,513]

theorem envBound7748 : H12AffineFastState.Bounded env7748 := by
  intro p hp
  have h : env7748.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7747_7748 : H12AffineEnvironment.transform 15 9006 env7747 = env7748 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 9006 env7747 == env7748) = true)

theorem identity7748 : scanCanonicalize (H12AffineFastState.compose env7748 (packedSelected [2,4] rootPS)) = affineNative (2^(12+1) ^^^ 584) := by decide +kernel

theorem selectedBound7748 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env7749 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,584,1993,232,358,1345,0,1673,232,1297,577,713,139,705,17,460,1992,1297,461,1285,4294967296,257,4294967905,1344,513]

theorem envBound7749 : H12AffineFastState.Bounded env7749 := by
  intro p hp
  have h : env7749.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7748_7749 : H12AffineEnvironment.transform 12 584 env7748 = env7749 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 584 env7748 == env7749) = true)

theorem identity7749 : scanCanonicalize (H12AffineFastState.compose env7749 (packedSelected [1,3,5] rootPS)) = affineNative (2^(6+1) ^^^ 18) := by decide +kernel

theorem selectedBound7749 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env7750 : List Nat := [2,4,8,16,32,64,18,256,512,1024,0,1296,584,1883,122,358,1345,0,1563,122,1297,577,603,25,595,17,350,1882,1297,351,1285,4294967296,257,4294967905,1344,513]

theorem envBound7750 : H12AffineFastState.Bounded env7750 := by
  intro p hp
  have h : env7750.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7749_7750 : H12AffineEnvironment.transform 6 18 env7749 = env7750 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 18 env7749 == env7750) = true)

theorem identity7750 : scanCanonicalize (H12AffineFastState.compose env7750 (packedSelected [0,7] rootPS)) = affineNative (2^(8+1) ^^^ 26) := by decide +kernel

theorem selectedBound7750 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env7751 : List Nat := [2,4,8,16,32,64,18,256,26,1024,0,1296,82,1345,122,358,1345,0,1025,122,1297,91,65,25,73,17,350,1344,1297,351,1285,4294967296,257,4294967419,1344,27]

theorem envBound7751 : H12AffineFastState.Bounded env7751 := by
  intro p hp
  have h : env7751.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7750_7751 : H12AffineEnvironment.transform 8 26 env7750 = env7751 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 26 env7750 == env7751) = true)

theorem identity7751 : scanCanonicalize (H12AffineFastState.compose env7751 (packedSelected [1,3] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound7751 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7752 : List Nat := [2,4,8,16,32,64,18,37,26,1024,0,1077,82,1124,122,67,1124,0,1025,122,1076,91,65,25,73,17,123,1125,1076,122,1056,4294967296,36,4294967419,1125,27]

theorem envBound7752 : H12AffineFastState.Bounded env7752 := by
  intro p hp
  have h : env7752.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7751_7752 : H12AffineEnvironment.transform 7 37 env7751 = env7752 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env7751 == env7752) = true)

theorem identity7752 : scanCanonicalize (H12AffineFastState.compose env7752 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 27) := by decide +kernel

theorem selectedBound7752 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7753 : List Nat := [2,4,8,16,32,64,18,37,26,1024,0,1077,82,1124,122,67,1124,0,1025,122,1076,91,65,25,73,17,123,1125,1076,122,1056,27,36,96,1125,27]

theorem envBound7753 : H12AffineFastState.Bounded env7753 := by
  intro p hp
  have h : env7753.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7752_7753 : H12AffineEnvironment.transform 31 27 env7752 = env7753 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 27 env7752 == env7753) = true)

theorem identity7753 : scanCanonicalize (H12AffineFastState.compose env7753 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound7753 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7754 : List Nat := [2,4,8,16,32,17,18,37,26,1024,0,1077,3,1077,43,18,1077,0,1025,43,1076,10,16,25,24,17,42,1076,1076,43,1056,27,36,49,1076,27]

theorem envBound7754 : H12AffineFastState.Bounded env7754 := by
  intro p hp
  have h : env7754.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7753_7754 : H12AffineEnvironment.transform 5 17 env7753 = env7754 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7753 == env7754) = true)

def env7755 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,1992,8864,65536,75375,0,1673,8864,1296,8201,712,139,8329,16,65706,1993,75327,65707,75307,4294967296,257,4294975529,75374,513]

theorem envBound7755 : H12AffineFastState.Bounded env7755 := by
  intro p hp
  have h : env7755.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7746_7755 : H12AffineEnvironment.transform 11 1297 env7746 = env7755 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env7746 == env7755) = true)

def env7756 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,8200,17664,230468,8329,2098432,2515996,2117632,131152,1073741824,131140,4294967296,257,4297842870,131073,513]

theorem envBound7756 : H12AffineFastState.Bounded env7756 := by
  intro p hp
  have h : env7756.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7648_7756 : H12AffineEnvironment.transform 10 1 env7648 = env7756 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env7648 == env7756) = true)

def env7757 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,8200,17664,230468,8329,5376,422940,16384,131152,1073741824,131140,4294967296,257,4295749814,131073,513]

theorem envBound7757 : H12AffineFastState.Bounded env7757 := by
  intro p hp
  have h : env7757.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7756_7757 : H12AffineEnvironment.transform 20 4096 env7756 = env7757 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env7756 == env7757) = true)

theorem identity7757 : scanCanonicalize (H12AffineFastState.compose env7757 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 406404) := by decide +kernel

theorem selectedBound7757 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env7758 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,8200,17664,230468,8329,5376,422940,16384,131152,406404,131140,4294967296,257,4295749814,131073,513]

theorem envBound7758 : H12AffineFastState.Bounded env7758 := by
  intro p hp
  have h : env7758.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7757_7758 : H12AffineEnvironment.transform 29 406404 env7757 = env7758 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 406404 env7757 == env7758) = true)

theorem identity7758 : scanCanonicalize (H12AffineFastState.compose env7758 (packedSelected [0,4,6,7,16,20,22,25] rootPS)) = affineNative (2^(18+1) ^^^ 21585) := by decide +kernel

theorem selectedBound7758 : packedSelected [0,4,6,7,16,20,22,25] rootPS < 2^1333 := by decide +kernel

def env7759 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,21585,32768,4096,8200,17664,230468,8329,5376,422940,16384,131152,406404,131140,4294967296,257,4295206119,131073,513]

theorem envBound7759 : H12AffineFastState.Bounded env7759 := by
  intro p hp
  have h : env7759.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7758_7759 : H12AffineEnvironment.transform 18 21585 env7758 = env7759 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 21585 env7758 == env7759) = true)

theorem identity7759 : scanCanonicalize (H12AffineFastState.compose env7759 (packedSelected [4,9,16] rootPS)) = affineNative (2^(17+1) ^^^ 234247) := by decide +kernel

theorem selectedBound7759 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env7760 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,234247,21585,32768,4096,8200,17664,230468,8329,5376,124699,16384,131152,106627,131140,4294967296,257,4295206119,131073,513]

theorem envBound7760 : H12AffineFastState.Bounded env7760 := by
  intro p hp
  have h : env7760.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7759_7760 : H12AffineEnvironment.transform 17 234247 env7759 = env7760 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 234247 env7759 == env7760) = true)

theorem identity7760 : scanCanonicalize (H12AffineFastState.compose env7760 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 4177) := by decide +kernel

theorem selectedBound7760 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env7761 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,131072,234247,1024,32768,4096,8200,5457,230468,8329,5376,112458,4177,131152,106627,131140,4294967296,257,4295206119,131073,513]

theorem envBound7761 : H12AffineFastState.Bounded env7761 := by
  intro p hp
  have h : env7761.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7760_7761 : H12AffineEnvironment.transform 13 4177 env7760 = env7761 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env7760 == env7761) = true)

theorem identity7761 : scanCanonicalize (H12AffineFastState.compose env7761 (packedSelected [13,21] rootPS)) = affineNative (2^(14+1) ^^^ 8540) := by decide +kernel

theorem selectedBound7761 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env7762 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,8540,65536,131072,209499,1024,8540,4096,8200,5457,206104,8329,5376,71190,4177,131152,66015,131140,4294967296,257,4295165371,131073,513]

theorem envBound7762 : H12AffineFastState.Bounded env7762 := by
  intro p hp
  have h : env7762.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7761_7762 : H12AffineEnvironment.transform 14 8540 env7761 = env7762 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8540 env7761 == env7762) = true)

def env7763 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,8200,17664,230468,8329,5377,422941,16385,131152,1073741824,131140,4294967296,257,4295749815,131073,513]

theorem envBound7763 : H12AffineFastState.Bounded env7763 := by
  intro p hp
  have h : env7763.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7756_7763 : H12AffineEnvironment.transform 20 4097 env7756 = env7763 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env7756 == env7763) = true)

theorem identity7763 : scanCanonicalize (H12AffineFastState.compose env7763 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 403141) := by decide +kernel

theorem selectedBound7763 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env7764 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,8200,17664,230468,8329,5377,422941,16385,131152,403141,131140,4294967296,257,4295749815,131073,513]

theorem envBound7764 : H12AffineFastState.Bounded env7764 := by
  intro p hp
  have h : env7764.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7763_7764 : H12AffineEnvironment.transform 29 403141 env7763 = env7764 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 403141 env7763 == env7764) = true)

def env7765 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,41632,524288,32768,4097,8200,17664,230468,8329,5377,186045,16385,131152,164965,131140,4294967296,257,4295749815,131073,513]

theorem envBound7765 : H12AffineFastState.Bounded env7765 := by
  intro p hp
  have h : env7765.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7764_7765 : H12AffineEnvironment.transform 17 41632 env7764 = env7765 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41632 env7764 == env7765) = true)

theorem identity7765 : scanCanonicalize (H12AffineFastState.compose env7765 (packedSelected [16,18,32] rootPS)) = affineNative (2^(14+1) ^^^ 8864) := by decide +kernel

theorem selectedBound7765 : packedSelected [16,18,32] rootPS < 2^1333 := by decide +kernel

def env7766 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8864,65536,131072,0,524288,8864,4097,8200,17664,206564,8329,5377,160797,16385,131152,140997,131140,4294967296,257,4295709207,131073,513]

theorem envBound7766 : H12AffineFastState.Bounded env7766 := by
  intro p hp
  have h : env7766.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7765_7766 : H12AffineEnvironment.transform 14 8864 env7765 = env7766 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8864 env7765 == env7766) = true)

theorem identity7766 : scanCanonicalize (H12AffineFastState.compose env7766 (packedSelected [18,20] rootPS)) = affineNative (2^(13+1) ^^^ 4824) := by decide +kernel

theorem selectedBound7766 : packedSelected [18,20] rootPS < 2^1333 := by decide +kernel

def env7767 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4824,8864,65536,131072,0,524288,8864,4097,8200,6104,206564,8329,5377,140997,4825,131152,140997,131140,4294967296,257,4295688399,131073,513]

theorem envBound7767 : H12AffineFastState.Bounded env7767 := by
  intro p hp
  have h : env7767.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7766_7767 : H12AffineEnvironment.transform 13 4824 env7766 = env7767 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4824 env7766 == env7767) = true)

def env7768 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4824,8864,65536,1344,0,524288,8864,4097,8200,6104,74660,8329,5377,9093,4825,1296,9093,1284,4294967296,257,4295558543,1345,513]

theorem envBound7768 : H12AffineFastState.Bounded env7768 := by
  intro p hp
  have h : env7768.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7767_7768 : H12AffineEnvironment.transform 16 1344 env7767 = env7768 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env7767 == env7768) = true)

theorem identity7768 : scanCanonicalize (H12AffineFastState.compose env7768 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(12+1) ^^^ 900) := by decide +kernel

theorem selectedBound7768 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env7769 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,900,4824,292,65536,1344,0,524288,292,4097,908,6104,65568,781,5377,1,4825,1296,1,1284,4294967296,257,4295558543,1345,513]

theorem envBound7769 : H12AffineFastState.Bounded env7769 := by
  intro p hp
  have h : env7769.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7768_7769 : H12AffineEnvironment.transform 12 900 env7768 = env7769 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 900 env7768 == env7769) = true)

def env7770 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,900,4824,292,65536,1344,0,1024,292,4097,908,6104,65568,781,5377,1,4825,1296,1,1284,4294967296,257,4295033231,1345,513]

theorem envBound7770 : H12AffineFastState.Bounded env7770 := by
  intro p hp
  have h : env7770.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7769_7770 : H12AffineEnvironment.transform 18 1024 env7769 = env7770 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env7769 == env7770) = true)

theorem identity7770 : scanCanonicalize (H12AffineFastState.compose env7770 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 171) := by decide +kernel

theorem selectedBound7770 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env7771 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,900,4824,292,171,1344,0,1024,292,4097,908,6104,139,781,5377,1,4825,1296,1,1284,4294967296,257,4294967588,1345,513]

theorem envBound7771 : H12AffineFastState.Bounded env7771 := by
  intro p hp
  have h : env7771.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7770_7771 : H12AffineEnvironment.transform 15 171 env7770 = env7771 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 171 env7770 == env7771) = true)

theorem identity7771 : scanCanonicalize (H12AffineFastState.compose env7771 (packedSelected [5,8] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound7771 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env7772 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,4096,268,4176,292,171,1344,0,1024,292,4097,260,5456,139,389,5377,1,4177,1296,1,1284,4294967296,257,4294967588,1345,137]

theorem envBound7772 : H12AffineFastState.Bounded env7772 := by
  intro p hp
  have h : env7772.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7771_7772 : H12AffineEnvironment.transform 8 136 env7771 = env7772 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env7771 == env7772) = true)

theorem identity7772 : scanCanonicalize (H12AffineFastState.compose env7772 (packedSelected [1,3] rootPS)) = affineNative (2^(11+1) ^^^ 1077) := by decide +kernel

theorem selectedBound7772 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7773 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,1077,268,1125,292,171,1344,0,1024,292,1076,260,357,139,389,308,1,1124,1296,1,1284,4294967296,257,4294967588,1345,137]

theorem envBound7773 : H12AffineFastState.Bounded env7773 := by
  intro p hp
  have h : env7773.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7772_7773 : H12AffineEnvironment.transform 11 1077 env7772 = env7773 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1077 env7772 == env7773) = true)

def env7774 : List Nat := [2,4,8,16,32,64,8,256,0,1024,1,1077,268,1125,292,35,1344,0,1024,292,1076,260,357,3,269,308,1,1124,1296,1,1284,4294967296,257,4294967588,1345,1]

theorem envBound7774 : H12AffineFastState.Bounded env7774 := by
  intro p hp
  have h : env7774.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7773_7774 : H12AffineEnvironment.transform 6 8 env7773 = env7774 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env7773 == env7774) = true)

theorem identity7774 : scanCanonicalize (H12AffineFastState.compose env7774 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 42) := by decide +kernel

theorem selectedBound7774 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7775 : List Nat := [2,4,8,16,32,64,8,256,0,1024,1,1077,268,1125,292,35,1344,0,1024,292,1076,260,357,3,269,308,1,1124,1296,1,1284,42,257,270,1345,1]

theorem envBound7775 : H12AffineFastState.Bounded env7775 := by
  intro p hp
  have h : env7775.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7774_7775 : H12AffineEnvironment.transform 31 42 env7774 = env7775 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 42 env7774 == env7775) = true)

def env7776 : List Nat := [2,4,8,16,32,16,8,256,0,1024,1,1077,268,1077,292,35,1296,0,1024,292,1076,260,309,3,269,308,1,1076,1296,1,1284,42,257,270,1297,1]

theorem envBound7776 : H12AffineFastState.Bounded env7776 := by
  intro p hp
  have h : env7776.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7775_7776 : H12AffineEnvironment.transform 5 16 env7775 = env7776 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7775 == env7776) = true)

theorem identity7776 : scanCanonicalize (H12AffineFastState.compose env7776 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound7776 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7777 : List Nat := [2,4,8,1,32,1,8,256,0,1024,1,1060,268,1060,292,35,1281,0,1024,292,1061,260,292,3,269,293,1,1061,1281,1,1284,42,257,270,1280,1]

theorem envBound7777 : H12AffineFastState.Bounded env7777 := by
  intro p hp
  have h : env7777.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7776_7777 : H12AffineEnvironment.transform 3 1 env7776 = env7777 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7776 == env7777) = true)

def env7778 : List Nat := [2,4,8,1,32,1,8,36,0,1024,1,1060,40,1060,0,35,1061,0,1024,0,1061,32,0,3,41,1,1,1061,1061,1,1056,42,37,42,1060,1]

theorem envBound7778 : H12AffineFastState.Bounded env7778 := by
  intro p hp
  have h : env7778.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7777_7778 : H12AffineEnvironment.transform 7 36 env7777 = env7778 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env7777 == env7778) = true)

theorem identity7778 : scanCanonicalize (H12AffineFastState.compose env7778 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound7778 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7779 : List Nat := [2,4,3,1,32,1,3,36,0,1024,1,1060,35,1060,0,35,1061,0,1024,0,1061,32,0,3,34,1,1,1061,1061,1,1056,33,37,33,1060,1]

theorem envBound7779 : H12AffineFastState.Bounded env7779 := by
  intro p hp
  have h : env7779.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7778_7779 : H12AffineEnvironment.transform 2 3 env7778 = env7779 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env7778 == env7779) = true)

def leafEnv7779 : List Nat := [2,4,3,1,32,1,3,36,0,1024,1,1060,35,1060,0,35,1061,0,1024,0,1061,32,0,3,1056,34,1,1,1,1061,1061,1,1056,33,37,33,5,35,1060,1,0,1060,1]

def active7779 : List Nat := [0,1,4,9]

def tree7779 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7779 : H12WitnessSearch.Good tree7779 := H12GlobalWitnessIndex.good

theorem leafIdentity7779 : H12AffineFastState.composeSystem env7779 rootObs = leafEnv7779 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7779 rootObs == leafEnv7779) = true)

theorem terminalChecked7779 : H12PackedTerminal.terminalCheckFast leafEnv7779 active7779 tree7779 = true := by decide +kernel

def env7780 : List Nat := [2,4,8,1,32,1,8,37,0,1024,1,1060,41,1060,1,35,1060,0,1024,1,1061,33,1,3,40,0,1,1061,1060,1,1057,42,36,43,1061,1]

theorem envBound7780 : H12AffineFastState.Bounded env7780 := by
  intro p hp
  have h : env7780.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7777_7780 : H12AffineEnvironment.transform 7 37 env7777 = env7780 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env7777 == env7780) = true)

def leafEnv7780 : List Nat := [2,4,8,1,32,1,8,37,0,1024,1,1060,41,1060,1,35,1060,0,1024,1,1061,33,1,3,1057,40,1,0,1,1061,1060,1,1057,42,36,43,5,35,1061,1,0,1061,1]

def active7780 : List Nat := [0,1,2,4,9]

def tree7780 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7780 : H12WitnessSearch.Good tree7780 := H12GlobalWitnessIndex.good

theorem leafIdentity7780 : H12AffineFastState.composeSystem env7780 rootObs = leafEnv7780 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7780 rootObs == leafEnv7780) = true)

theorem terminalChecked7780 : H12PackedTerminal.terminalCheckFast leafEnv7780 active7780 tree7780 = true := by decide +kernel

def env7781 : List Nat := [2,4,8,16,32,17,8,256,0,1024,1,1077,268,1076,292,35,1297,0,1024,292,1076,260,308,3,269,308,1,1077,1296,1,1284,42,257,270,1296,1]

theorem envBound7781 : H12AffineFastState.Bounded env7781 := by
  intro p hp
  have h : env7781.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7775_7781 : H12AffineEnvironment.transform 5 17 env7775 = env7781 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7775 == env7781) = true)

theorem identity7781 : scanCanonicalize (H12AffineFastState.compose env7781 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 53) := by decide +kernel

theorem selectedBound7781 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7782 : List Nat := [2,4,8,16,32,17,8,53,0,1024,1,1077,57,1076,17,35,1060,0,1024,17,1076,49,1,3,56,1,1,1077,1061,1,1073,42,52,59,1061,1]

theorem envBound7782 : H12AffineFastState.Bounded env7782 := by
  intro p hp
  have h : env7782.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7781_7782 : H12AffineEnvironment.transform 7 53 env7781 = env7782 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 53 env7781 == env7782) = true)

def env7783 : List Nat := [2,4,8,0,32,1,8,37,0,1024,1,1061,41,1060,1,35,1060,0,1024,1,1060,33,1,3,40,1,1,1061,1061,1,1057,42,36,43,1061,1]

theorem envBound7783 : H12AffineFastState.Bounded env7783 := by
  intro p hp
  have h : env7783.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7782_7783 : H12AffineEnvironment.transform 3 0 env7782 = env7783 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7782 == env7783) = true)

def leafEnv7783 : List Nat := [2,4,8,0,32,1,8,37,0,1024,1,1061,41,1060,1,35,1060,0,1024,1,1060,33,1,3,1057,40,1,1,1,1061,1061,1,1057,42,36,43,5,35,1061,1,0,1060,1]

def active7783 : List Nat := [0,1,2,4,9]

def tree7783 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7783 : H12WitnessSearch.Good tree7783 := H12GlobalWitnessIndex.good

theorem leafIdentity7783 : H12AffineFastState.composeSystem env7783 rootObs = leafEnv7783 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7783 rootObs == leafEnv7783) = true)

theorem terminalChecked7783 : H12PackedTerminal.terminalCheckFast leafEnv7783 active7783 tree7783 = true := by decide +kernel

def env7784 : List Nat := [2,4,8,1,32,0,8,36,0,1024,1,1060,40,1061,0,35,1060,0,1024,0,1061,32,1,3,41,1,1,1060,1061,1,1056,42,37,42,1061,1]

theorem envBound7784 : H12AffineFastState.Bounded env7784 := by
  intro p hp
  have h : env7784.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7782_7784 : H12AffineEnvironment.transform 3 1 env7782 = env7784 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7782 == env7784) = true)

theorem identity7784 : scanCanonicalize (H12AffineFastState.compose env7784 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound7784 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7785 : List Nat := [2,4,3,1,32,0,3,36,0,1024,1,1060,35,1061,0,35,1060,0,1024,0,1061,32,1,3,34,1,1,1060,1061,1,1056,33,37,33,1061,1]

theorem envBound7785 : H12AffineFastState.Bounded env7785 := by
  intro p hp
  have h : env7785.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7784_7785 : H12AffineEnvironment.transform 2 3 env7784 = env7785 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env7784 == env7785) = true)

def leafEnv7785 : List Nat := [2,4,3,1,32,0,3,36,0,1024,1,1060,35,1061,0,35,1060,0,1024,0,1061,32,1,3,1056,34,1,1,1,1060,1061,1,1056,33,37,33,5,35,1061,1,0,1060,1]

def active7785 : List Nat := [0,1,4,9]

def tree7785 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7785 : H12WitnessSearch.Good tree7785 := H12GlobalWitnessIndex.good

theorem leafIdentity7785 : H12AffineFastState.composeSystem env7785 rootObs = leafEnv7785 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7785 rootObs == leafEnv7785) = true)

theorem terminalChecked7785 : H12PackedTerminal.terminalCheckFast leafEnv7785 active7785 tree7785 = true := by decide +kernel

def env7786 : List Nat := [2,4,8,16,32,64,9,256,1,1024,1,1077,268,1125,292,34,1344,0,1024,292,1076,260,357,2,268,308,1,1124,1296,1,1284,4294967296,257,4294967588,1345,0]

theorem envBound7786 : H12AffineFastState.Bounded env7786 := by
  intro p hp
  have h : env7786.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7773_7786 : H12AffineEnvironment.transform 6 9 env7773 = env7786 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env7773 == env7786) = true)

theorem identity7786 : scanCanonicalize (H12AffineFastState.compose env7786 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 271) := by decide +kernel

theorem selectedBound7786 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7787 : List Nat := [2,4,8,16,32,64,9,256,1,1024,1,1077,268,1125,292,34,1344,0,1024,292,1076,260,357,2,268,308,1,1124,1296,1,1284,271,257,43,1345,0]

theorem envBound7787 : H12AffineFastState.Bounded env7787 := by
  intro p hp
  have h : env7787.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7786_7787 : H12AffineEnvironment.transform 31 271 env7786 = env7787 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 271 env7786 == env7787) = true)

def env7788 : List Nat := [2,4,8,16,32,16,9,256,1,1024,1,1077,268,1077,292,34,1296,0,1024,292,1076,260,309,2,268,308,1,1076,1296,1,1284,271,257,43,1297,0]

theorem envBound7788 : H12AffineFastState.Bounded env7788 := by
  intro p hp
  have h : env7788.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7787_7788 : H12AffineEnvironment.transform 5 16 env7787 = env7788 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7787 == env7788) = true)

theorem identity7788 : scanCanonicalize (H12AffineFastState.compose env7788 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound7788 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7789 : List Nat := [2,4,8,1,32,1,9,256,1,1024,1,1060,268,1060,292,34,1281,0,1024,292,1061,260,292,2,268,293,1,1061,1281,1,1284,271,257,43,1280,0]

theorem envBound7789 : H12AffineFastState.Bounded env7789 := by
  intro p hp
  have h : env7789.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7788_7789 : H12AffineEnvironment.transform 3 1 env7788 = env7789 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7788 == env7789) = true)

def env7790 : List Nat := [2,4,8,1,32,1,9,36,1,1024,1,1060,40,1060,0,34,1061,0,1024,0,1061,32,0,2,40,1,1,1061,1061,1,1056,43,37,43,1060,0]

theorem envBound7790 : H12AffineFastState.Bounded env7790 := by
  intro p hp
  have h : env7790.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7789_7790 : H12AffineEnvironment.transform 7 36 env7789 = env7790 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env7789 == env7790) = true)

theorem identity7790 : scanCanonicalize (H12AffineFastState.compose env7790 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound7790 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7791 : List Nat := [2,4,2,1,32,1,3,36,1,1024,1,1060,34,1060,0,34,1061,0,1024,0,1061,32,0,2,34,1,1,1061,1061,1,1056,33,37,33,1060,0]

theorem envBound7791 : H12AffineFastState.Bounded env7791 := by
  intro p hp
  have h : env7791.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7790_7791 : H12AffineEnvironment.transform 2 2 env7790 = env7791 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env7790 == env7791) = true)

def leafEnv7791 : List Nat := [2,4,2,1,32,1,3,36,1,1024,1,1060,34,1060,0,34,1061,0,1024,0,1061,32,0,2,1056,34,1,1,1,1061,1061,1,1056,33,37,33,5,35,1060,0,0,1060,1]

def active7791 : List Nat := [0,1,4,9]

def tree7791 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7791 : H12WitnessSearch.Good tree7791 := H12GlobalWitnessIndex.good

theorem leafIdentity7791 : H12AffineFastState.composeSystem env7791 rootObs = leafEnv7791 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7791 rootObs == leafEnv7791) = true)

theorem terminalChecked7791 : H12PackedTerminal.terminalCheckFast leafEnv7791 active7791 tree7791 = true := by decide +kernel

def env7792 : List Nat := [2,4,8,1,32,1,9,37,1,1024,1,1060,41,1060,1,34,1060,0,1024,1,1061,33,1,2,41,0,1,1061,1060,1,1057,42,36,43,1061,0]

theorem envBound7792 : H12AffineFastState.Bounded env7792 := by
  intro p hp
  have h : env7792.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7789_7792 : H12AffineEnvironment.transform 7 37 env7789 = env7792 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env7789 == env7792) = true)

def leafEnv7792 : List Nat := [2,4,8,1,32,1,9,37,1,1024,1,1060,41,1060,1,34,1060,0,1024,1,1061,33,1,2,1057,41,1,0,1,1061,1060,1,1057,42,36,43,5,35,1061,0,0,1061,1]

def active7792 : List Nat := [0,1,2,4,9]

def tree7792 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7792 : H12WitnessSearch.Good tree7792 := H12GlobalWitnessIndex.good

theorem leafIdentity7792 : H12AffineFastState.composeSystem env7792 rootObs = leafEnv7792 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7792 rootObs == leafEnv7792) = true)

theorem terminalChecked7792 : H12PackedTerminal.terminalCheckFast leafEnv7792 active7792 tree7792 = true := by decide +kernel

def env7793 : List Nat := [2,4,8,16,32,17,9,256,1,1024,1,1077,268,1076,292,34,1297,0,1024,292,1076,260,308,2,268,308,1,1077,1296,1,1284,271,257,43,1296,0]

theorem envBound7793 : H12AffineFastState.Bounded env7793 := by
  intro p hp
  have h : env7793.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7787_7793 : H12AffineEnvironment.transform 5 17 env7787 = env7793 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7787 == env7793) = true)

theorem identity7793 : scanCanonicalize (H12AffineFastState.compose env7793 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 53) := by decide +kernel

theorem selectedBound7793 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7794 : List Nat := [2,4,8,16,32,17,9,53,1,1024,1,1077,57,1076,17,34,1060,0,1024,17,1076,49,1,2,57,1,1,1077,1061,1,1073,58,52,43,1061,0]

theorem envBound7794 : H12AffineFastState.Bounded env7794 := by
  intro p hp
  have h : env7794.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7793_7794 : H12AffineEnvironment.transform 7 53 env7793 = env7794 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 53 env7793 == env7794) = true)

def env7795 : List Nat := [2,4,8,0,32,1,9,37,1,1024,1,1061,41,1060,1,34,1060,0,1024,1,1060,33,1,2,41,1,1,1061,1061,1,1057,42,36,43,1061,0]

theorem envBound7795 : H12AffineFastState.Bounded env7795 := by
  intro p hp
  have h : env7795.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7794_7795 : H12AffineEnvironment.transform 3 0 env7794 = env7795 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7794 == env7795) = true)

def leafEnv7795 : List Nat := [2,4,8,0,32,1,9,37,1,1024,1,1061,41,1060,1,34,1060,0,1024,1,1060,33,1,2,1057,41,1,1,1,1061,1061,1,1057,42,36,43,5,35,1061,0,0,1060,1]

def active7795 : List Nat := [0,1,2,4,9]

def tree7795 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7795 : H12WitnessSearch.Good tree7795 := H12GlobalWitnessIndex.good

theorem leafIdentity7795 : H12AffineFastState.composeSystem env7795 rootObs = leafEnv7795 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7795 rootObs == leafEnv7795) = true)

theorem terminalChecked7795 : H12PackedTerminal.terminalCheckFast leafEnv7795 active7795 tree7795 = true := by decide +kernel

def env7796 : List Nat := [2,4,8,1,32,0,9,36,1,1024,1,1060,40,1061,0,34,1060,0,1024,0,1061,32,1,2,40,1,1,1060,1061,1,1056,43,37,43,1061,0]

theorem envBound7796 : H12AffineFastState.Bounded env7796 := by
  intro p hp
  have h : env7796.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7794_7796 : H12AffineEnvironment.transform 3 1 env7794 = env7796 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7794 == env7796) = true)

theorem identity7796 : scanCanonicalize (H12AffineFastState.compose env7796 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound7796 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7797 : List Nat := [2,4,2,1,32,0,3,36,1,1024,1,1060,34,1061,0,34,1060,0,1024,0,1061,32,1,2,34,1,1,1060,1061,1,1056,33,37,33,1061,0]

theorem envBound7797 : H12AffineFastState.Bounded env7797 := by
  intro p hp
  have h : env7797.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7796_7797 : H12AffineEnvironment.transform 2 2 env7796 = env7797 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env7796 == env7797) = true)

def leafEnv7797 : List Nat := [2,4,2,1,32,0,3,36,1,1024,1,1060,34,1061,0,34,1060,0,1024,0,1061,32,1,2,1056,34,1,1,1,1060,1061,1,1056,33,37,33,5,35,1061,0,0,1060,1]

def active7797 : List Nat := [0,1,4,9]

def tree7797 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7797 : H12WitnessSearch.Good tree7797 := H12GlobalWitnessIndex.good

theorem leafIdentity7797 : H12AffineFastState.composeSystem env7797 rootObs = leafEnv7797 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7797 rootObs == leafEnv7797) = true)

theorem terminalChecked7797 : H12PackedTerminal.terminalCheckFast leafEnv7797 active7797 tree7797 = true := by decide +kernel

def env7798 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,900,4824,292,65536,1344,0,1025,292,4097,908,6104,65568,781,5377,1,4825,1296,1,1284,4294967296,257,4295033230,1345,513]

theorem envBound7798 : H12AffineFastState.Bounded env7798 := by
  intro p hp
  have h : env7798.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7769_7798 : H12AffineEnvironment.transform 18 1025 env7769 = env7798 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env7769 == env7798) = true)

theorem identity7798 : scanCanonicalize (H12AffineFastState.compose env7798 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 546) := by decide +kernel

theorem selectedBound7798 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env7799 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,900,4824,292,546,1344,0,1025,292,4097,908,6104,514,781,5377,1,4825,1296,1,1284,4294967296,257,4294968236,1345,513]

theorem envBound7799 : H12AffineFastState.Bounded env7799 := by
  intro p hp
  have h : env7799.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7798_7799 : H12AffineEnvironment.transform 15 546 env7798 = env7799 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 546 env7798 == env7799) = true)

def env7800 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,4096,268,4176,292,170,1344,0,1025,292,4097,260,5456,138,389,5377,1,4177,1296,1,1284,4294967296,257,4294967588,1345,137]

theorem envBound7800 : H12AffineFastState.Bounded env7800 := by
  intro p hp
  have h : env7800.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7799_7800 : H12AffineEnvironment.transform 8 136 env7799 = env7800 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env7799 == env7800) = true)

theorem identity7800 : scanCanonicalize (H12AffineFastState.compose env7800 (packedSelected [1,3] rootPS)) = affineNative (2^(11+1) ^^^ 1261) := by decide +kernel

theorem selectedBound7800 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7801 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,1261,268,1213,292,170,1344,0,1025,292,1260,260,445,138,389,492,1,1212,1296,1,1284,4294967296,257,4294967588,1345,137]

theorem envBound7801 : H12AffineFastState.Bounded env7801 := by
  intro p hp
  have h : env7801.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7800_7801 : H12AffineEnvironment.transform 11 1261 env7800 = env7801 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1261 env7800 == env7801) = true)

theorem identity7801 : scanCanonicalize (H12AffineFastState.compose env7801 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound7801 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env7802 : List Nat := [2,4,8,16,32,64,128,4,136,1024,1,1261,8,1213,32,170,1092,0,1025,32,1260,0,185,138,129,232,1,1212,1044,1,1024,4294967296,5,4294967328,1093,137]

theorem envBound7802 : H12AffineFastState.Bounded env7802 := by
  intro p hp
  have h : env7802.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7801_7802 : H12AffineEnvironment.transform 7 4 env7801 = env7802 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env7801 == env7802) = true)

theorem identity7802 : scanCanonicalize (H12AffineFastState.compose env7802 (packedSelected [5] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound7802 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env7803 : List Nat := [2,4,8,16,32,64,88,4,80,1024,1,1077,8,1125,32,114,1092,0,1025,32,1076,0,97,82,89,48,1,1124,1044,1,1024,4294967296,5,4294967328,1093,81]

theorem envBound7803 : H12AffineFastState.Bounded env7803 := by
  intro p hp
  have h : env7803.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7802_7803 : H12AffineEnvironment.transform 6 88 env7802 = env7803 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env7802 == env7803) = true)

theorem identity7803 : scanCanonicalize (H12AffineFastState.compose env7803 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 1) := by decide +kernel

theorem selectedBound7803 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7804 : List Nat := [2,4,8,16,32,64,88,4,80,1024,1,1077,8,1125,32,114,1092,0,1025,32,1076,0,97,82,89,48,1,1124,1044,1,1024,1,5,33,1093,81]

theorem envBound7804 : H12AffineFastState.Bounded env7804 := by
  intro p hp
  have h : env7804.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7803_7804 : H12AffineEnvironment.transform 31 1 env7803 = env7804 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1 env7803 == env7804) = true)

theorem identity7804 : scanCanonicalize (H12AffineFastState.compose env7804 (packedSelected [0,2] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound7804 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env7805 : List Nat := [2,4,8,16,32,11,19,4,27,1024,1,1077,8,1070,32,57,1039,0,1025,32,1076,0,42,25,18,48,1,1071,1044,1,1024,1,5,33,1038,26]

theorem envBound7805 : H12AffineFastState.Bounded env7805 := by
  intro p hp
  have h : env7805.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7804_7805 : H12AffineEnvironment.transform 5 11 env7804 = env7805 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env7804 == env7805) = true)

def env7806 : List Nat := [2,4,8,16,0,11,19,4,27,1024,1,1045,8,1038,0,25,1039,0,1025,0,1044,0,10,25,18,16,1,1039,1044,1,1024,1,5,1,1038,26]

theorem envBound7806 : H12AffineFastState.Bounded env7806 := by
  intro p hp
  have h : env7806.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7805_7806 : H12AffineEnvironment.transform 4 0 env7805 = env7806 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env7805 == env7806) = true)

theorem identity7806 : scanCanonicalize (H12AffineFastState.compose env7806 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound7806 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7807 : List Nat := [2,4,8,1,0,11,2,4,10,1024,1,1028,8,1038,0,8,1039,0,1025,0,1029,0,10,8,3,1,1,1039,1029,1,1024,1,5,1,1038,11]

theorem envBound7807 : H12AffineFastState.Bounded env7807 := by
  intro p hp
  have h : env7807.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7806_7807 : H12AffineEnvironment.transform 3 1 env7806 = env7807 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7806 == env7807) = true)

def leafEnv7807 : List Nat := [2,4,8,1,0,11,2,4,10,1024,1,1028,8,1038,0,8,1039,0,1025,0,1029,0,10,8,1025,3,1,1,1,1039,1029,1,1024,1,5,1,5,3,1038,11,0,1028,1]

def active7807 : List Nat := [0,1,2,9]

def tree7807 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7807 : H12WitnessSearch.Good tree7807 := H12GlobalWitnessIndex.good

theorem leafIdentity7807 : H12AffineFastState.composeSystem env7807 rootObs = leafEnv7807 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7807 rootObs == leafEnv7807) = true)

theorem terminalChecked7807 : H12PackedTerminal.terminalCheckFast leafEnv7807 active7807 tree7807 = true := by decide +kernel

def env7808 : List Nat := [2,4,8,16,1,11,19,4,27,1024,1,1044,8,1039,1,24,1039,0,1025,1,1045,0,11,25,18,17,1,1038,1044,1,1024,1,5,0,1038,26]

theorem envBound7808 : H12AffineFastState.Bounded env7808 := by
  intro p hp
  have h : env7808.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7805_7808 : H12AffineEnvironment.transform 4 1 env7805 = env7808 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env7805 == env7808) = true)

theorem identity7808 : scanCanonicalize (H12AffineFastState.compose env7808 (packedSelected [0] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound7808 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7809 : List Nat := [2,4,2,16,1,1,19,4,17,1024,1,1044,2,1029,1,18,1029,0,1025,1,1045,0,1,19,18,17,1,1028,1044,1,1024,1,5,0,1028,16]

theorem envBound7809 : H12AffineFastState.Bounded env7809 := by
  intro p hp
  have h : env7809.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7808_7809 : H12AffineEnvironment.transform 2 2 env7808 = env7809 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env7808 == env7809) = true)

def leafEnv7809 : List Nat := [2,4,2,16,1,1,19,4,17,1024,1,1044,2,1029,1,18,1029,0,1025,1,1045,0,1,19,1025,18,1,17,1,1028,1044,1,1024,1,5,0,5,2,1028,16,0,1045,1]

def active7809 : List Nat := [0,1,3,9]

def tree7809 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7809 : H12WitnessSearch.Good tree7809 := H12GlobalWitnessIndex.good

theorem leafIdentity7809 : H12AffineFastState.composeSystem env7809 rootObs = leafEnv7809 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7809 rootObs == leafEnv7809) = true)

theorem terminalChecked7809 : H12PackedTerminal.terminalCheckFast leafEnv7809 active7809 tree7809 = true := by decide +kernel

def env7810 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,4096,269,4177,292,171,1344,0,1025,292,4097,261,5457,139,388,5377,1,4176,1296,1,1284,4294967296,257,4294967589,1345,136]

theorem envBound7810 : H12AffineFastState.Bounded env7810 := by
  intro p hp
  have h : env7810.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7799_7810 : H12AffineEnvironment.transform 8 137 env7799 = env7810 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env7799 == env7810) = true)

theorem identity7810 : scanCanonicalize (H12AffineFastState.compose env7810 (packedSelected [1,3] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound7810 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7811 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1297,269,1344,292,171,1344,0,1025,292,1296,261,64,139,388,16,1,1345,1296,1,1284,4294967296,257,4294967589,1345,136]

theorem envBound7811 : H12AffineFastState.Bounded env7811 := by
  intro p hp
  have h : env7811.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7810_7811 : H12AffineEnvironment.transform 11 1297 env7810 = env7811 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env7810 == env7811) = true)

def env7812 : List Nat := [2,4,8,16,32,64,8,256,1,1024,1,1297,269,1344,292,35,1344,0,1025,292,1296,261,64,3,268,16,1,1345,1296,1,1284,4294967296,257,4294967589,1345,0]

theorem envBound7812 : H12AffineFastState.Bounded env7812 := by
  intro p hp
  have h : env7812.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7811_7812 : H12AffineEnvironment.transform 6 8 env7811 = env7812 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env7811 == env7812) = true)

theorem identity7812 : scanCanonicalize (H12AffineFastState.compose env7812 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 123) := by decide +kernel

theorem selectedBound7812 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7813 : List Nat := [2,4,8,16,32,64,8,256,1,1024,1,1297,269,1344,292,35,1344,0,1025,292,1296,261,64,3,268,16,1,1345,1296,1,1284,123,257,350,1345,0]

theorem envBound7813 : H12AffineFastState.Bounded env7813 := by
  intro p hp
  have h : env7813.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7812_7813 : H12AffineEnvironment.transform 31 123 env7812 = env7813 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 123 env7812 == env7813) = true)

def env7814 : List Nat := [2,4,8,16,32,16,8,256,1,1024,1,1297,269,1296,292,35,1296,0,1025,292,1296,261,16,3,268,16,1,1297,1296,1,1284,43,257,270,1297,0]

theorem envBound7814 : H12AffineFastState.Bounded env7814 := by
  intro p hp
  have h : env7814.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7813_7814 : H12AffineEnvironment.transform 5 16 env7813 = env7814 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7813 == env7814) = true)

theorem identity7814 : scanCanonicalize (H12AffineFastState.compose env7814 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 31) := by decide +kernel

theorem selectedBound7814 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7815 : List Nat := [2,4,8,16,32,16,8,31,1,1024,1,1038,18,1039,59,35,1039,0,1025,59,1039,26,16,3,19,16,1,1038,1039,1,1051,43,30,17,1038,0]

theorem envBound7815 : H12AffineFastState.Bounded env7815 := by
  intro p hp
  have h : env7815.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7814_7815 : H12AffineEnvironment.transform 7 31 env7814 = env7815 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 31 env7814 == env7815) = true)

def env7816 : List Nat := [2,4,8,16,16,16,8,31,1,1024,1,1038,18,1039,11,19,1039,0,1025,11,1039,26,16,3,19,16,1,1038,1039,1,1051,27,30,17,1038,0]

theorem envBound7816 : H12AffineFastState.Bounded env7816 := by
  intro p hp
  have h : env7816.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7815_7816 : H12AffineEnvironment.transform 4 16 env7815 = env7816 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env7815 == env7816) = true)

theorem identity7816 : scanCanonicalize (H12AffineFastState.compose env7816 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

end H12GlobalChart2
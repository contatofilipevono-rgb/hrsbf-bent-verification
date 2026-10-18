import H12GlobalChart2Data031

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem selectedBound7816 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7817 : List Nat := [2,4,8,10,10,10,8,5,1,1024,1,1038,8,1039,11,9,1039,0,1025,11,1039,0,10,3,9,10,1,1038,1039,1,1025,1,4,11,1038,0]

theorem envBound7817 : H12AffineFastState.Bounded env7817 := by
  intro p hp
  have h : env7817.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7816_7817 : H12AffineEnvironment.transform 3 10 env7816 = env7817 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env7816 == env7817) = true)

def leafEnv7817 : List Nat := [2,4,8,10,10,10,8,5,1,1024,1,1038,8,1039,11,9,1039,0,1025,11,1039,0,10,3,1024,9,1,10,1,1038,1039,1,1025,1,4,11,5,9,1038,0,0,1038,1]

def active7817 : List Nat := [0,1,2,9]

def tree7817 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7817 : H12WitnessSearch.Good tree7817 := H12GlobalWitnessIndex.good

theorem leafIdentity7817 : H12AffineFastState.composeSystem env7817 rootObs = leafEnv7817 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7817 rootObs == leafEnv7817) = true)

theorem terminalChecked7817 : H12PackedTerminal.terminalCheckFast leafEnv7817 active7817 tree7817 = true := by decide +kernel

def env7818 : List Nat := [2,4,8,16,17,16,8,31,1,1024,1,1038,18,1039,10,18,1039,0,1025,10,1039,26,16,3,19,16,1,1038,1039,1,1051,26,30,17,1038,0]

theorem envBound7818 : H12AffineFastState.Bounded env7818 := by
  intro p hp
  have h : env7818.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7815_7818 : H12AffineEnvironment.transform 4 17 env7815 = env7818 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env7815 == env7818) = true)

theorem identity7818 : scanCanonicalize (H12AffineFastState.compose env7818 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound7818 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7819 : List Nat := [2,4,8,0,1,0,8,15,1,1024,1,1038,2,1039,10,2,1039,0,1025,10,1039,10,0,3,3,0,1,1038,1039,1,1035,10,14,1,1038,0]

theorem envBound7819 : H12AffineFastState.Bounded env7819 := by
  intro p hp
  have h : env7819.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7818_7819 : H12AffineEnvironment.transform 3 0 env7818 = env7819 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7818 == env7819) = true)

def leafEnv7819 : List Nat := [2,4,8,0,1,0,8,15,1,1024,1,1038,2,1039,10,2,1039,0,1025,10,1039,10,0,3,1034,3,1,0,1,1038,1039,1,1035,10,14,1,5,2,1038,0,0,1038,1]

def active7819 : List Nat := [0,1,2,9]

def tree7819 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7819 : H12WitnessSearch.Good tree7819 := H12GlobalWitnessIndex.good

theorem leafIdentity7819 : H12AffineFastState.composeSystem env7819 rootObs = leafEnv7819 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7819 rootObs == leafEnv7819) = true)

theorem terminalChecked7819 : H12PackedTerminal.terminalCheckFast leafEnv7819 active7819 tree7819 = true := by decide +kernel

def env7820 : List Nat := [2,4,8,16,32,17,8,256,1,1024,1,1297,269,1297,292,35,1297,0,1025,292,1296,261,17,3,268,16,1,1296,1296,1,1284,42,257,271,1296,0]

theorem envBound7820 : H12AffineFastState.Bounded env7820 := by
  intro p hp
  have h : env7820.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7813_7820 : H12AffineEnvironment.transform 5 17 env7813 = env7820 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7813 == env7820) = true)

theorem identity7820 : scanCanonicalize (H12AffineFastState.compose env7820 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 27) := by decide +kernel

theorem selectedBound7820 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7821 : List Nat := [2,4,8,16,27,17,8,256,1,1024,1,1297,269,1297,287,24,1297,0,1025,287,1296,261,17,3,268,16,1,1296,1296,1,1284,17,257,271,1296,0]

theorem envBound7821 : H12AffineFastState.Bounded env7821 := by
  intro p hp
  have h : env7821.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7820_7821 : H12AffineEnvironment.transform 4 27 env7820 = env7821 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 27 env7820 == env7821) = true)

def env7822 : List Nat := [2,4,8,16,27,17,8,20,1,1024,1,1029,25,1029,11,24,1029,0,1025,11,1028,17,17,3,24,16,1,1028,1028,1,1040,17,21,27,1028,0]

theorem envBound7822 : H12AffineFastState.Bounded env7822 := by
  intro p hp
  have h : env7822.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7821_7822 : H12AffineEnvironment.transform 7 20 env7821 = env7822 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 20 env7821 == env7822) = true)

theorem identity7822 : scanCanonicalize (H12AffineFastState.compose env7822 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound7822 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7823 : List Nat := [2,4,8,11,0,10,8,15,1,1024,1,1029,2,1029,11,3,1029,0,1025,11,1028,10,10,3,3,11,1,1028,1028,1,1035,10,14,0,1028,0]

theorem envBound7823 : H12AffineFastState.Bounded env7823 := by
  intro p hp
  have h : env7823.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7822_7823 : H12AffineEnvironment.transform 3 11 env7822 = env7823 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env7822 == env7823) = true)

def leafEnv7823 : List Nat := [2,4,8,11,0,10,8,15,1,1024,1,1029,2,1029,11,3,1029,0,1025,11,1028,10,10,3,1034,3,1,11,1,1028,1028,1,1035,10,14,0,5,3,1028,0,0,1029,1]

def active7823 : List Nat := [0,1,2,9]

def tree7823 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7823 : H12WitnessSearch.Good tree7823 := H12GlobalWitnessIndex.good

theorem leafIdentity7823 : H12AffineFastState.composeSystem env7823 rootObs = leafEnv7823 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7823 rootObs == leafEnv7823) = true)

theorem terminalChecked7823 : H12PackedTerminal.terminalCheckFast leafEnv7823 active7823 tree7823 = true := by decide +kernel

def env7824 : List Nat := [2,4,8,16,27,17,8,21,1,1024,1,1028,24,1028,10,24,1028,0,1025,10,1029,16,17,3,25,16,1,1029,1029,1,1041,17,20,26,1029,0]

theorem envBound7824 : H12AffineFastState.Bounded env7824 := by
  intro p hp
  have h : env7824.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7821_7824 : H12AffineEnvironment.transform 7 21 env7821 = env7824 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 21 env7821 == env7824) = true)

theorem identity7824 : scanCanonicalize (H12AffineFastState.compose env7824 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound7824 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7825 : List Nat := [2,4,8,1,10,0,8,4,1,1024,1,1028,9,1028,10,9,1028,0,1025,10,1029,1,0,3,8,1,1,1029,1029,1,1024,0,5,11,1029,0]

theorem envBound7825 : H12AffineFastState.Bounded env7825 := by
  intro p hp
  have h : env7825.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7824_7825 : H12AffineEnvironment.transform 3 1 env7824 = env7825 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7824 == env7825) = true)

def leafEnv7825 : List Nat := [2,4,8,1,10,0,8,4,1,1024,1,1028,9,1028,10,9,1028,0,1025,10,1029,1,0,3,1025,8,1,1,1,1029,1029,1,1024,0,5,11,5,9,1029,0,0,1028,1]

def active7825 : List Nat := [0,1,2,9]

def tree7825 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7825 : H12WitnessSearch.Good tree7825 := H12GlobalWitnessIndex.good

theorem leafIdentity7825 : H12AffineFastState.composeSystem env7825 rootObs = leafEnv7825 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7825 rootObs == leafEnv7825) = true)

theorem terminalChecked7825 : H12PackedTerminal.terminalCheckFast leafEnv7825 active7825 tree7825 = true := by decide +kernel

def env7826 : List Nat := [2,4,8,16,32,64,9,256,0,1024,1,1297,269,1344,292,34,1344,0,1025,292,1296,261,64,2,269,16,1,1345,1296,1,1284,4294967296,257,4294967589,1345,1]

theorem envBound7826 : H12AffineFastState.Bounded env7826 := by
  intro p hp
  have h : env7826.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7811_7826 : H12AffineEnvironment.transform 6 9 env7811 = env7826 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env7811 == env7826) = true)

theorem identity7826 : scanCanonicalize (H12AffineFastState.compose env7826 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 351) := by decide +kernel

theorem selectedBound7826 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7827 : List Nat := [2,4,8,16,32,64,9,256,0,1024,1,1297,269,1344,292,34,1344,0,1025,292,1296,261,64,2,269,16,1,1345,1296,1,1284,351,257,122,1345,1]

theorem envBound7827 : H12AffineFastState.Bounded env7827 := by
  intro p hp
  have h : env7827.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7826_7827 : H12AffineEnvironment.transform 31 351 env7826 = env7827 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 351 env7826 == env7827) = true)

def env7828 : List Nat := [2,4,8,16,32,16,9,256,0,1024,1,1297,269,1296,292,34,1296,0,1025,292,1296,261,16,2,269,16,1,1297,1296,1,1284,271,257,42,1297,1]

theorem envBound7828 : H12AffineFastState.Bounded env7828 := by
  intro p hp
  have h : env7828.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7827_7828 : H12AffineEnvironment.transform 5 16 env7827 = env7828 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7827 == env7828) = true)

theorem identity7828 : scanCanonicalize (H12AffineFastState.compose env7828 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 27) := by decide +kernel

theorem selectedBound7828 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7829 : List Nat := [2,4,8,16,27,16,9,256,0,1024,1,1297,269,1296,287,25,1296,0,1025,287,1296,261,16,2,269,16,1,1297,1296,1,1284,271,257,17,1297,1]

theorem envBound7829 : H12AffineFastState.Bounded env7829 := by
  intro p hp
  have h : env7829.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7828_7829 : H12AffineEnvironment.transform 4 27 env7828 = env7829 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 27 env7828 == env7829) = true)

def env7830 : List Nat := [2,4,8,16,27,16,9,20,0,1024,1,1029,25,1028,11,25,1028,0,1025,11,1028,17,16,2,25,16,1,1029,1028,1,1040,27,21,17,1029,1]

theorem envBound7830 : H12AffineFastState.Bounded env7830 := by
  intro p hp
  have h : env7830.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7829_7830 : H12AffineEnvironment.transform 7 20 env7829 = env7830 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 20 env7829 == env7830) = true)

theorem identity7830 : scanCanonicalize (H12AffineFastState.compose env7830 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound7830 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7831 : List Nat := [2,4,8,10,1,10,9,14,0,1024,1,1029,3,1028,11,3,1028,0,1025,11,1028,11,10,2,3,10,1,1029,1028,1,1034,1,15,11,1029,1]

theorem envBound7831 : H12AffineFastState.Bounded env7831 := by
  intro p hp
  have h : env7831.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7830_7831 : H12AffineEnvironment.transform 3 10 env7830 = env7831 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env7830 == env7831) = true)

def leafEnv7831 : List Nat := [2,4,8,10,1,10,9,14,0,1024,1,1029,3,1028,11,3,1028,0,1025,11,1028,11,10,2,1035,3,1,10,1,1029,1028,1,1034,1,15,11,5,2,1029,1,0,1029,1]

def active7831 : List Nat := [0,1,2,9]

def tree7831 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7831 : H12WitnessSearch.Good tree7831 := H12GlobalWitnessIndex.good

theorem leafIdentity7831 : H12AffineFastState.composeSystem env7831 rootObs = leafEnv7831 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7831 rootObs == leafEnv7831) = true)

theorem terminalChecked7831 : H12PackedTerminal.terminalCheckFast leafEnv7831 active7831 tree7831 = true := by decide +kernel

def env7832 : List Nat := [2,4,8,16,27,16,9,21,0,1024,1,1028,24,1029,10,25,1029,0,1025,10,1029,16,16,2,24,16,1,1028,1029,1,1041,26,20,17,1028,1]

theorem envBound7832 : H12AffineFastState.Bounded env7832 := by
  intro p hp
  have h : env7832.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7829_7832 : H12AffineEnvironment.transform 7 21 env7829 = env7832 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 21 env7829 == env7832) = true)

theorem identity7832 : scanCanonicalize (H12AffineFastState.compose env7832 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound7832 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7833 : List Nat := [2,4,8,0,11,0,9,5,0,1024,1,1028,8,1029,10,9,1029,0,1025,10,1029,0,0,2,8,0,1,1028,1029,1,1025,10,4,1,1028,1]

theorem envBound7833 : H12AffineFastState.Bounded env7833 := by
  intro p hp
  have h : env7833.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7832_7833 : H12AffineEnvironment.transform 3 0 env7832 = env7833 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7832 == env7833) = true)

def leafEnv7833 : List Nat := [2,4,8,0,11,0,9,5,0,1024,1,1028,8,1029,10,9,1029,0,1025,10,1029,0,0,2,1024,8,1,0,1,1028,1029,1,1025,10,4,1,5,8,1028,1,0,1028,1]

def active7833 : List Nat := [0,1,2,9]

def tree7833 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7833 : H12WitnessSearch.Good tree7833 := H12GlobalWitnessIndex.good

theorem leafIdentity7833 : H12AffineFastState.composeSystem env7833 rootObs = leafEnv7833 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7833 rootObs == leafEnv7833) = true)

theorem terminalChecked7833 : H12PackedTerminal.terminalCheckFast leafEnv7833 active7833 tree7833 = true := by decide +kernel

def env7834 : List Nat := [2,4,8,16,32,17,9,256,0,1024,1,1297,269,1297,292,34,1297,0,1025,292,1296,261,17,2,269,16,1,1296,1296,1,1284,270,257,43,1296,1]

theorem envBound7834 : H12AffineFastState.Bounded env7834 := by
  intro p hp
  have h : env7834.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7827_7834 : H12AffineEnvironment.transform 5 17 env7827 = env7834 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7827 == env7834) = true)

theorem identity7834 : scanCanonicalize (H12AffineFastState.compose env7834 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 31) := by decide +kernel

theorem selectedBound7834 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7835 : List Nat := [2,4,8,16,32,17,9,31,0,1024,1,1038,18,1038,59,34,1038,0,1025,59,1039,26,17,2,18,16,1,1039,1039,1,1051,17,30,43,1039,1]

theorem envBound7835 : H12AffineFastState.Bounded env7835 := by
  intro p hp
  have h : env7835.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7834_7835 : H12AffineEnvironment.transform 7 31 env7834 = env7835 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 31 env7834 == env7835) = true)

def env7836 : List Nat := [2,4,8,16,16,17,9,31,0,1024,1,1038,18,1038,11,18,1038,0,1025,11,1039,26,17,2,18,16,1,1039,1039,1,1051,17,30,27,1039,1]

theorem envBound7836 : H12AffineFastState.Bounded env7836 := by
  intro p hp
  have h : env7836.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7835_7836 : H12AffineEnvironment.transform 4 16 env7835 = env7836 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env7835 == env7836) = true)

theorem identity7836 : scanCanonicalize (H12AffineFastState.compose env7836 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound7836 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7837 : List Nat := [2,4,8,11,11,10,9,4,0,1024,1,1038,9,1038,11,9,1038,0,1025,11,1039,1,10,2,9,11,1,1039,1039,1,1024,10,5,0,1039,1]

theorem envBound7837 : H12AffineFastState.Bounded env7837 := by
  intro p hp
  have h : env7837.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7836_7837 : H12AffineEnvironment.transform 3 11 env7836 = env7837 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env7836 == env7837) = true)

def leafEnv7837 : List Nat := [2,4,8,11,11,10,9,4,0,1024,1,1038,9,1038,11,9,1038,0,1025,11,1039,1,10,2,1025,9,1,11,1,1039,1039,1,1024,10,5,0,5,8,1039,1,0,1038,1]

def active7837 : List Nat := [0,1,2,9]

def tree7837 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7837 : H12WitnessSearch.Good tree7837 := H12GlobalWitnessIndex.good

theorem leafIdentity7837 : H12AffineFastState.composeSystem env7837 rootObs = leafEnv7837 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7837 rootObs == leafEnv7837) = true)

theorem terminalChecked7837 : H12PackedTerminal.terminalCheckFast leafEnv7837 active7837 tree7837 = true := by decide +kernel

def env7838 : List Nat := [2,4,8,16,17,17,9,31,0,1024,1,1038,18,1038,10,19,1038,0,1025,10,1039,26,17,2,18,16,1,1039,1039,1,1051,17,30,26,1039,1]

theorem envBound7838 : H12AffineFastState.Bounded env7838 := by
  intro p hp
  have h : env7838.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7835_7838 : H12AffineEnvironment.transform 4 17 env7835 = env7838 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env7835 == env7838) = true)

theorem identity7838 : scanCanonicalize (H12AffineFastState.compose env7838 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound7838 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7839 : List Nat := [2,4,8,1,0,0,9,14,0,1024,1,1038,3,1038,10,2,1038,0,1025,10,1039,11,0,2,3,1,1,1039,1039,1,1034,0,15,11,1039,1]

theorem envBound7839 : H12AffineFastState.Bounded env7839 := by
  intro p hp
  have h : env7839.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7838_7839 : H12AffineEnvironment.transform 3 1 env7838 = env7839 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7838 == env7839) = true)

def leafEnv7839 : List Nat := [2,4,8,1,0,0,9,14,0,1024,1,1038,3,1038,10,2,1038,0,1025,10,1039,11,0,2,1035,3,1,1,1,1039,1039,1,1034,0,15,11,5,3,1039,1,0,1038,1]

def active7839 : List Nat := [0,1,2,9]

def tree7839 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7839 : H12WitnessSearch.Good tree7839 := H12GlobalWitnessIndex.good

theorem leafIdentity7839 : H12AffineFastState.composeSystem env7839 rootObs = leafEnv7839 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7839 rootObs == leafEnv7839) = true)

theorem terminalChecked7839 : H12PackedTerminal.terminalCheckFast leafEnv7839 active7839 tree7839 = true := by decide +kernel

def env7840 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4824,8864,65536,1345,0,524288,8864,4097,8200,6104,74661,8329,5377,9092,4825,1297,9092,1285,4294967296,257,4295558542,1344,513]

theorem envBound7840 : H12AffineFastState.Bounded env7840 := by
  intro p hp
  have h : env7840.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7767_7840 : H12AffineEnvironment.transform 16 1345 env7767 = env7840 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env7767 == env7840) = true)

theorem identity7840 : scanCanonicalize (H12AffineFastState.compose env7840 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(12+1) ^^^ 268) := by decide +kernel

theorem selectedBound7840 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env7841 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,268,4824,940,65536,1345,0,524288,940,4097,260,6104,66217,389,5377,648,4825,1297,648,1285,4294967296,257,4295558542,1344,513]

theorem envBound7841 : H12AffineFastState.Bounded env7841 := by
  intro p hp
  have h : env7841.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7840_7841 : H12AffineEnvironment.transform 12 268 env7840 = env7841 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 268 env7840 == env7841) = true)

theorem identity7841 : scanCanonicalize (H12AffineFastState.compose env7841 (packedSelected [4,9] rootPS)) = affineNative (2^(18+1) ^^^ 4368) := by decide +kernel

theorem selectedBound7841 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env7842 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,268,4824,940,65536,1345,0,4368,940,4097,260,6104,66217,389,5377,648,4825,1297,648,1285,4294967296,257,4295038110,1344,513]

theorem envBound7842 : H12AffineFastState.Bounded env7842 := by
  intro p hp
  have h : env7842.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7841_7842 : H12AffineEnvironment.transform 18 4368 env7841 = env7842 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 4368 env7841 == env7842) = true)

theorem identity7842 : scanCanonicalize (H12AffineFastState.compose env7842 (packedSelected [3,8,10,12] rootPS)) = affineNative (2^(15+1) ^^^ 5278) := by decide +kernel

theorem selectedBound7842 : packedSelected [3,8,10,12] rootPS < 2^1333 := by decide +kernel

def env7843 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,268,4824,940,5278,1345,0,4368,940,4097,260,6104,5687,389,5377,648,4825,1297,648,1285,4294967296,257,4294967296,1344,513]

theorem envBound7843 : H12AffineFastState.Bounded env7843 := by
  intro p hp
  have h : env7843.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7842_7843 : H12AffineEnvironment.transform 15 5278 env7842 = env7843 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5278 env7842 == env7843) = true)

theorem identity7843 : scanCanonicalize (H12AffineFastState.compose env7843 (packedSelected [0,1,2,4,5,6,10] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound7843 : packedSelected [0,1,2,4,5,6,10] rootPS < 2^1333 := by decide +kernel

def env7844 : List Nat := [2,4,8,16,32,64,128,36,512,1024,1,4096,40,4824,648,5278,1125,0,4148,648,4097,32,5884,5687,161,5157,648,4825,1077,648,1057,4294967296,37,4294967296,1124,513]

theorem envBound7844 : H12AffineFastState.Bounded env7844 := by
  intro p hp
  have h : env7844.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7843_7844 : H12AffineEnvironment.transform 7 36 env7843 = env7844 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env7843 == env7844) = true)

theorem identity7844 : scanCanonicalize (H12AffineFastState.compose env7844 (packedSelected [1,2,3,4,5] rootPS)) = affineNative (2^(8+1) ^^^ 195) := by decide +kernel

theorem selectedBound7844 : packedSelected [1,2,3,4,5] rootPS < 2^1333 := by decide +kernel

def env7845 : List Nat := [2,4,8,16,32,64,128,36,195,1024,1,4096,40,4123,75,5278,1125,0,4148,75,4097,32,5183,5364,161,5157,75,4122,1077,75,1057,4294967296,37,4294967296,1124,194]

theorem envBound7845 : H12AffineFastState.Bounded env7845 := by
  intro p hp
  have h : env7845.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7844_7845 : H12AffineEnvironment.transform 8 195 env7844 = env7845 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 195 env7844 == env7845) = true)

theorem identity7845 : scanCanonicalize (H12AffineFastState.compose env7845 (packedSelected [0,1,4,6] rootPS)) = affineNative (2^(31+1) ^^^ 1) := by decide +kernel

theorem selectedBound7845 : packedSelected [0,1,4,6] rootPS < 2^1333 := by decide +kernel

def env7846 : List Nat := [2,4,8,16,32,64,128,36,195,1024,1,4096,40,4123,75,5278,1125,0,4148,75,4097,32,5183,5364,161,5157,75,4122,1077,75,1057,1,37,1,1124,194]

theorem envBound7846 : H12AffineFastState.Bounded env7846 := by
  intro p hp
  have h : env7846.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7845_7846 : H12AffineEnvironment.transform 31 1 env7845 = env7846 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1 env7845 == env7846) = true)

theorem identity7846 : scanCanonicalize (H12AffineFastState.compose env7846 (packedSelected [3,4,8] rootPS)) = affineNative (2^(11+1) ^^^ 1076) := by decide +kernel

theorem selectedBound7846 : packedSelected [3,4,8] rootPS < 2^1333 := by decide +kernel

def env7847 : List Nat := [2,4,8,16,32,64,128,36,195,1024,1,1076,40,1071,75,170,1125,0,1024,75,1077,32,11,192,161,17,75,1070,1077,75,1057,1,37,1,1124,194]

theorem envBound7847 : H12AffineFastState.Bounded env7847 := by
  intro p hp
  have h : env7847.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7846_7847 : H12AffineEnvironment.transform 11 1076 env7846 = env7847 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1076 env7846 == env7847) = true)

theorem identity7847 : scanCanonicalize (H12AffineFastState.compose env7847 (packedSelected [0,1,3] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound7847 : packedSelected [0,1,3] rootPS < 2^1333 := by decide +kernel

def env7848 : List Nat := [2,4,8,16,32,11,128,36,136,1024,1,1076,40,1071,0,170,1070,0,1024,0,1077,32,11,139,161,17,0,1070,1077,0,1057,1,37,1,1071,137]

theorem envBound7848 : H12AffineFastState.Bounded env7848 := by
  intro p hp
  have h : env7848.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7847_7848 : H12AffineEnvironment.transform 5 11 env7847 = env7848 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env7847 == env7848) = true)

def env7849 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,32768,65536,131072,41633,524288,32768,4097,8200,17664,230468,8329,5377,186044,16385,131152,164964,131140,4294967296,257,4295749815,131073,513]

theorem envBound7849 : H12AffineFastState.Bounded env7849 := by
  intro p hp
  have h : env7849.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7764_7849 : H12AffineEnvironment.transform 17 41633 env7764 = env7849 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41633 env7764 == env7849) = true)

theorem identity7849 : scanCanonicalize (H12AffineFastState.compose env7849 (packedSelected [16,18,32] rootPS)) = affineNative (2^(14+1) ^^^ 28793) := by decide +kernel

theorem selectedBound7849 : packedSelected [16,18,32] rootPS < 2^1333 := by decide +kernel

def env7850 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,28793,65536,131072,21208,524288,28793,4097,8200,17664,226365,8329,5377,140997,16385,131152,160797,131140,4294967296,257,4295688398,131073,513]

theorem envBound7850 : H12AffineFastState.Bounded env7850 := by
  intro p hp
  have h : env7850.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7849_7850 : H12AffineEnvironment.transform 14 28793 env7849 = env7850 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 28793 env7849 == env7850) = true)

theorem identity7850 : scanCanonicalize (H12AffineFastState.compose env7850 (packedSelected [16,23] rootPS)) = affineNative (2^(13+1) ^^^ 4825) := by decide +kernel

theorem selectedBound7850 : packedSelected [16,23] rootPS < 2^1333 := by decide +kernel

def env7851 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4825,8864,65536,131072,1,524288,8864,4097,8200,6105,206564,8329,5377,140997,4824,131152,140996,131140,4294967296,257,4295688398,131073,513]

theorem envBound7851 : H12AffineFastState.Bounded env7851 := by
  intro p hp
  have h : env7851.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7850_7851 : H12AffineEnvironment.transform 13 4825 env7850 = env7851 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4825 env7850 == env7851) = true)

theorem identity7851 : scanCanonicalize (H12AffineFastState.compose env7851 (packedSelected [0,2,6,9,16] rootPS)) = affineNative (2^(16+1) ^^^ 75375) := by decide +kernel

theorem selectedBound7851 : packedSelected [0,2,6,9,16] rootPS < 2^1333 := by decide +kernel

def env7852 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4825,8864,65536,75375,1,524288,8864,4097,8200,6105,139,8329,5377,65706,4824,75327,65707,75307,4294967296,257,4295501473,75374,513]

theorem envBound7852 : H12AffineFastState.Bounded env7852 := by
  intro p hp
  have h : env7852.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7851_7852 : H12AffineEnvironment.transform 16 75375 env7851 = env7852 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 75375 env7851 == env7852) = true)

theorem identity7852 : scanCanonicalize (H12AffineFastState.compose env7852 (packedSelected [5,8,10,12,17] rootPS)) = affineNative (2^(18+1) ^^^ 1673) := by decide +kernel

theorem selectedBound7852 : packedSelected [5,8,10,12,17] rootPS < 2^1333 := by decide +kernel

def env7853 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4825,8864,65536,75375,1,1673,8864,4097,8200,6105,139,8329,5377,65706,4824,75327,65707,75307,4294967296,257,4294975528,75374,513]

theorem envBound7853 : H12AffineFastState.Bounded env7853 := by
  intro p hp
  have h : env7853.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7852_7853 : H12AffineEnvironment.transform 18 1673 env7852 = env7853 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1673 env7852 == env7853) = true)

def env7854 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,1993,8864,65536,75375,1,1673,8864,1297,8200,713,139,8329,17,65706,1992,75327,65707,75307,4294967296,257,4294975528,75374,513]

theorem envBound7854 : H12AffineFastState.Bounded env7854 := by
  intro p hp
  have h : env7854.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7853_7854 : H12AffineEnvironment.transform 11 1296 env7853 = env7854 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env7853 == env7854) = true)

theorem identity7854 : scanCanonicalize (H12AffineFastState.compose env7854 (packedSelected [4,9] rootPS)) = affineNative (2^(15+1) ^^^ 9006) := by decide +kernel

theorem selectedBound7854 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env7855 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,8192,1993,8864,9006,1345,1,1673,8864,1297,8200,713,139,8329,17,9092,1992,1297,9093,1285,4294967296,257,4294975528,1344,513]

theorem envBound7855 : H12AffineFastState.Bounded env7855 := by
  intro p hp
  have h : env7855.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7854_7855 : H12AffineEnvironment.transform 15 9006 env7854 = env7855 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 9006 env7854 == env7855) = true)

theorem identity7855 : scanCanonicalize (H12AffineFastState.compose env7855 (packedSelected [2,4] rootPS)) = affineNative (2^(12+1) ^^^ 585) := by decide +kernel

theorem selectedBound7855 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env7856 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1296,585,1993,233,359,1345,1,1673,233,1297,577,713,139,704,17,461,1992,1297,460,1285,4294967296,257,4294967905,1344,513]

theorem envBound7856 : H12AffineFastState.Bounded env7856 := by
  intro p hp
  have h : env7856.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7855_7856 : H12AffineEnvironment.transform 12 585 env7855 = env7856 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 585 env7855 == env7856) = true)

theorem identity7856 : scanCanonicalize (H12AffineFastState.compose env7856 (packedSelected [1,3,5] rootPS)) = affineNative (2^(6+1) ^^^ 18) := by decide +kernel

theorem selectedBound7856 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env7857 : List Nat := [2,4,8,16,32,64,18,256,512,1024,1,1296,585,1883,123,359,1345,1,1563,123,1297,577,603,25,594,17,351,1882,1297,350,1285,4294967296,257,4294967905,1344,513]

theorem envBound7857 : H12AffineFastState.Bounded env7857 := by
  intro p hp
  have h : env7857.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7856_7857 : H12AffineEnvironment.transform 6 18 env7856 = env7857 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 18 env7856 == env7857) = true)

theorem identity7857 : scanCanonicalize (H12AffineFastState.compose env7857 (packedSelected [0,7] rootPS)) = affineNative (2^(8+1) ^^^ 26) := by decide +kernel

theorem selectedBound7857 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env7858 : List Nat := [2,4,8,16,32,64,18,256,26,1024,1,1296,83,1345,123,359,1345,1,1025,123,1297,91,65,25,72,17,351,1344,1297,350,1285,4294967296,257,4294967419,1344,27]

theorem envBound7858 : H12AffineFastState.Bounded env7858 := by
  intro p hp
  have h : env7858.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7857_7858 : H12AffineEnvironment.transform 8 26 env7857 = env7858 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 26 env7857 == env7858) = true)

theorem identity7858 : scanCanonicalize (H12AffineFastState.compose env7858 (packedSelected [1,3] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound7858 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7859 : List Nat := [2,4,8,16,32,64,18,37,26,1024,1,1077,83,1124,123,66,1124,1,1025,123,1076,91,65,25,72,17,122,1125,1076,123,1056,4294967296,36,4294967419,1125,27]

theorem envBound7859 : H12AffineFastState.Bounded env7859 := by
  intro p hp
  have h : env7859.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7858_7859 : H12AffineEnvironment.transform 7 37 env7858 = env7859 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env7858 == env7859) = true)

theorem identity7859 : scanCanonicalize (H12AffineFastState.compose env7859 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 27) := by decide +kernel

theorem selectedBound7859 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7860 : List Nat := [2,4,8,16,32,64,18,37,26,1024,1,1077,83,1124,123,66,1124,1,1025,123,1076,91,65,25,72,17,122,1125,1076,123,1056,27,36,96,1125,27]

theorem envBound7860 : H12AffineFastState.Bounded env7860 := by
  intro p hp
  have h : env7860.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7859_7860 : H12AffineEnvironment.transform 31 27 env7859 = env7860 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 27 env7859 == env7860) = true)

theorem identity7860 : scanCanonicalize (H12AffineFastState.compose env7860 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound7860 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7861 : List Nat := [2,4,8,16,32,17,18,37,26,1024,1,1077,2,1077,42,19,1077,1,1025,42,1076,10,16,25,25,17,43,1076,1076,42,1056,27,36,49,1076,27]

theorem envBound7861 : H12AffineFastState.Bounded env7861 := by
  intro p hp
  have h : env7861.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7860_7861 : H12AffineEnvironment.transform 5 17 env7860 = env7861 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7860 == env7861) = true)

def env7862 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1297,8192,1992,8864,65536,75375,1,1673,8864,1296,8200,712,139,8329,16,65706,1993,75327,65707,75307,4294967296,257,4294975528,75374,513]

theorem envBound7862 : H12AffineFastState.Bounded env7862 := by
  intro p hp
  have h : env7862.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7853_7862 : H12AffineEnvironment.transform 11 1297 env7853 = env7862 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env7853 == env7862) = true)

def env7863 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,2098433,23445585,2117633,131153,1073741824,16876545,4294967296,256,4352140402,131073,33563272]

theorem envBound7863 : H12AffineFastState.Bounded env7863 := by
  intro p hp
  have h : env7863.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7358_7863 : H12AffineEnvironment.transform 25 2098433 env7358 = env7863 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 2098433 env7358 == env7863) = true)

theorem identity7863 : scanCanonicalize (H12AffineFastState.compose env7863 (packedSelected [1,3,10,19,24,26,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound7863 : packedSelected [1,3,10,19,24,26,28,31] rootPS < 2^1333 := by decide +kernel

def env7864 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,8329,2098433,23445585,2117633,131153,1073741824,16876545,4294967296,256,4318577915,131073,513]

theorem envBound7864 : H12AffineFastState.Bounded env7864 := by
  intro p hp
  have h : env7864.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7863_7864 : H12AffineEnvironment.transform 24 8329 env7863 = env7864 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env7863 == env7864) = true)

theorem identity7864 : scanCanonicalize (H12AffineFastState.compose env7864 (packedSelected [4,7,9,16,20,27] rootPS)) = affineNative (2^(20+1) ^^^ 4097) := by decide +kernel

theorem selectedBound7864 : packedSelected [4,7,9,16,20,27] rootPS < 2^1333 := by decide +kernel

def env7865 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,4194304,17664,16777216,8329,5376,21352528,16384,131153,1073741824,16876545,4294967296,256,4316484858,131073,513]

theorem envBound7865 : H12AffineFastState.Bounded env7865 := by
  intro p hp
  have h : env7865.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7864_7865 : H12AffineEnvironment.transform 20 4097 env7864 = env7865 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env7864 == env7865) = true)

def env7866 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,4194304,5456,16777216,8329,5376,21331968,4176,131153,1073741824,16876545,4294967296,256,4316464298,131073,513]

theorem envBound7866 : H12AffineFastState.Bounded env7866 := by
  intro p hp
  have h : env7866.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7865_7866 : H12AffineEnvironment.transform 13 4176 env7865 = env7866 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env7865 == env7866) = true)

theorem identity7866 : scanCanonicalize (H12AffineFastState.compose env7866 (packedSelected [6,25] rootPS)) = affineNative (2^(29+1) ^^^ 4294795) := by decide +kernel

theorem selectedBound7866 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env7867 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,4194304,5456,16777216,8329,5376,21331968,4176,131153,4294795,16876545,4294967296,256,4316464298,131073,513]

theorem envBound7867 : H12AffineFastState.Bounded env7867 := by
  intro p hp
  have h : env7867.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7866_7867 : H12AffineEnvironment.transform 29 4294795 env7866 = env7867 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4294795 env7866 == env7867) = true)

def env7868 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,524288,32768,4097,4194304,5456,16777216,8329,5376,21331968,4176,4177,4294795,16876545,4294967296,256,4316464298,4097,513]

theorem envBound7868 : H12AffineFastState.Bounded env7868 := by
  intro p hp
  have h : env7868.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7867_7868 : H12AffineEnvironment.transform 16 4096 env7867 = env7868 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env7867 == env7868) = true)

def env7869 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1344,8192,1296,32768,65536,1344,262144,524288,32768,1345,4194304,16,16777216,8329,64,21331968,1296,1297,4294795,16876545,4294967296,256,4316464298,1345,513]

theorem envBound7869 : H12AffineFastState.Bounded env7869 := by
  intro p hp
  have h : env7869.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7868_7869 : H12AffineEnvironment.transform 11 1344 env7868 = env7869 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1344 env7868 == env7869) = true)

theorem identity7869 : scanCanonicalize (H12AffineFastState.compose env7869 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(23+1) ^^^ 99293) := by decide +kernel

theorem selectedBound7869 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env7870 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1344,8192,1296,32768,65536,1344,262144,524288,32768,1345,4194304,16,99293,8329,64,4457437,1296,1297,4294795,2012,4294967296,256,4299786103,1345,513]

theorem envBound7870 : H12AffineFastState.Bounded env7870 := by
  intro p hp
  have h : env7870.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7869_7870 : H12AffineEnvironment.transform 23 99293 env7869 = env7870 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 99293 env7869 == env7870) = true)

theorem identity7870 : scanCanonicalize (H12AffineFastState.compose env7870 (packedSelected [4,16,22] rootPS)) = affineNative (2^(18+1) ^^^ 1753) := by decide +kernel

theorem selectedBound7870 : packedSelected [4,16,22] rootPS < 2^1333 := by decide +kernel

def env7871 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1344,8192,1296,32768,65536,1344,262144,1753,32768,1345,4194304,16,99293,8329,64,4457437,1296,1297,4294795,2012,4294967296,256,4299260334,1345,513]

theorem envBound7871 : H12AffineFastState.Bounded env7871 := by
  intro p hp
  have h : env7871.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7870_7871 : H12AffineEnvironment.transform 18 1753 env7870 = env7871 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1753 env7870 == env7871) = true)

theorem identity7871 : scanCanonicalize (H12AffineFastState.compose env7871 (packedSelected [4,9,16] rootPS)) = affineNative (2^(8+1) ^^^ 216) := by decide +kernel

theorem selectedBound7871 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env7872 : List Nat := [2,4,8,16,32,64,128,256,216,1024,2048,1344,8192,1296,32768,65536,1344,262144,1025,32768,1345,4194304,16,98565,8329,64,4456709,1296,1297,4294795,1284,4294967296,256,4299260334,1345,217]

theorem envBound7872 : H12AffineFastState.Bounded env7872 := by
  intro p hp
  have h : env7872.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7871_7872 : H12AffineEnvironment.transform 8 216 env7871 = env7872 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 216 env7871 == env7872) = true)

theorem identity7872 : scanCanonicalize (H12AffineFastState.compose env7872 (packedSelected [3,5,10] rootPS)) = affineNative (2^(31+1) ^^^ 98599) := by decide +kernel

theorem selectedBound7872 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env7873 : List Nat := [2,4,8,16,32,64,128,256,216,1024,2048,1344,8192,1296,32768,65536,1344,262144,1025,32768,1345,4194304,16,98565,8329,64,4456709,1296,1297,4294795,1284,98599,256,4194441,1345,217]

theorem envBound7873 : H12AffineFastState.Bounded env7873 := by
  intro p hp
  have h : env7873.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7872_7873 : H12AffineEnvironment.transform 31 98599 env7872 = env7873 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 98599 env7872 == env7873) = true)

theorem identity7873 : scanCanonicalize (H12AffineFastState.compose env7873 (packedSelected [1,12,13] rootPS)) = affineNative (2^(15+1) ^^^ 33008) := by decide +kernel

theorem selectedBound7873 : packedSelected [1,12,13] rootPS < 2^1333 := by decide +kernel

def env7874 : List Nat := [2,4,8,16,32,64,128,256,216,1024,2048,1344,8192,1296,32768,33008,1344,262144,1025,32768,1345,4194304,16,501,8329,64,4456709,1296,1297,4196475,1284,471,256,4194441,1345,217]

theorem envBound7874 : H12AffineFastState.Bounded env7874 := by
  intro p hp
  have h : env7874.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7873_7874 : H12AffineEnvironment.transform 15 33008 env7873 = env7874 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33008 env7873 == env7874) = true)

theorem identity7874 : scanCanonicalize (H12AffineFastState.compose env7874 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 43350) := by decide +kernel

theorem selectedBound7874 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env7875 : List Nat := [2,4,8,16,32,64,128,256,216,1024,2048,1344,8192,1296,32768,33008,1344,43350,1025,32768,1345,4194304,16,501,8329,64,4237395,1296,1297,4196475,1284,471,256,4194441,1345,217]

theorem envBound7875 : H12AffineFastState.Bounded env7875 := by
  intro p hp
  have h : env7875.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7874_7875 : H12AffineEnvironment.transform 17 43350 env7874 = env7875 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43350 env7874 == env7875) = true)

theorem identity7875 : scanCanonicalize (H12AffineFastState.compose env7875 (packedSelected [3,5,12,17] rootPS)) = affineNative (2^(14+1) ^^^ 8460) := by decide +kernel

theorem selectedBound7875 : packedSelected [3,5,12,17] rootPS < 2^1333 := by decide +kernel

def env7876 : List Nat := [2,4,8,16,32,64,128,256,216,1024,2048,1344,8192,1296,8460,8700,1344,2138,1025,8460,1345,4194304,16,501,8329,64,4196703,1296,1297,4196475,1284,471,256,4194441,1345,217]

theorem envBound7876 : H12AffineFastState.Bounded env7876 := by
  intro p hp
  have h : env7876.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7875_7876 : H12AffineEnvironment.transform 14 8460 env7875 = env7876 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8460 env7875 == env7876) = true)

theorem identity7876 : scanCanonicalize (H12AffineFastState.compose env7876 (packedSelected [6] rootPS)) = affineNative (2^(21+1) ^^^ 3318) := by decide +kernel

theorem selectedBound7876 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7877 : List Nat := [2,4,8,16,32,64,128,256,216,1024,2048,1344,8192,1296,8460,8700,1344,2138,1025,8460,1345,3318,16,501,8329,64,1449,1296,1297,1165,1284,471,256,3199,1345,217]

theorem envBound7877 : H12AffineFastState.Bounded env7877 := by
  intro p hp
  have h : env7877.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7876_7877 : H12AffineEnvironment.transform 21 3318 env7876 = env7877 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 3318 env7876 == env7877) = true)

theorem identity7877 : scanCanonicalize (H12AffineFastState.compose env7877 (packedSelected [1,12,21] rootPS)) = affineNative (2^(10+1) ^^^ 1528) := by decide +kernel

theorem selectedBound7877 : packedSelected [1,12,21] rootPS < 2^1333 := by decide +kernel

def env7878 : List Nat := [2,4,8,16,32,64,128,256,216,1024,1528,1344,8192,1296,8460,8700,1344,1442,1025,8460,1345,270,16,501,8329,64,1449,1296,1297,1165,1284,471,256,391,1345,217]

theorem envBound7878 : H12AffineFastState.Bounded env7878 := by
  intro p hp
  have h : env7878.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7877_7878 : H12AffineEnvironment.transform 10 1528 env7877 = env7878 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1528 env7877 == env7878) = true)

def env7879 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1345,8192,1297,32768,65536,1345,262144,524288,32768,1344,4194304,17,16777216,8329,65,21331968,1297,1296,4294795,16876545,4294967296,256,4316464298,1344,513]

theorem envBound7879 : H12AffineFastState.Bounded env7879 := by
  intro p hp
  have h : env7879.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7868_7879 : H12AffineEnvironment.transform 11 1345 env7868 = env7879 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1345 env7868 == env7879) = true)

theorem identity7879 : scanCanonicalize (H12AffineFastState.compose env7879 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(23+1) ^^^ 99213) := by decide +kernel

theorem selectedBound7879 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env7880 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1345,8192,1297,32768,65536,1345,262144,524288,32768,1344,4194304,17,99213,8329,65,4457357,1297,1296,4294795,1932,4294967296,256,4299786023,1344,513]

theorem envBound7880 : H12AffineFastState.Bounded env7880 := by
  intro p hp
  have h : env7880.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7879_7880 : H12AffineEnvironment.transform 23 99213 env7879 = env7880 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 99213 env7879 == env7880) = true)

theorem identity7880 : scanCanonicalize (H12AffineFastState.compose env7880 (packedSelected [4,16,22] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound7880 : packedSelected [4,16,22] rootPS < 2^1333 := by decide +kernel

def env7881 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1345,8192,1297,32768,65536,1345,262144,524288,32768,1344,4194304,17,98564,8329,65,4456708,1297,1296,4294795,1285,4294967296,256,4299785646,1344,136]

theorem envBound7881 : H12AffineFastState.Bounded env7881 := by
  intro p hp
  have h : env7881.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7880_7881 : H12AffineEnvironment.transform 8 137 env7880 = env7881 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env7880 == env7881) = true)

def env7882 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1345,8192,1297,32768,65536,1345,262144,524288,32768,1344,41088,17,98564,8329,65,303492,1297,1296,75787,1285,4294967296,256,4295566638,1344,136]

theorem envBound7882 : H12AffineFastState.Bounded env7882 := by
  intro p hp
  have h : env7882.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7881_7882 : H12AffineEnvironment.transform 21 41088 env7881 = env7882 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 41088 env7881 == env7882) = true)

theorem identity7882 : scanCanonicalize (H12AffineFastState.compose env7882 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 304554) := by decide +kernel

theorem selectedBound7882 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7883 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1345,8192,1297,32768,65536,1345,262144,524288,32768,1344,41088,17,98564,8329,65,303492,1297,1296,75787,1285,304554,256,884868,1344,136]

theorem envBound7883 : H12AffineFastState.Bounded env7883 := by
  intro p hp
  have h : env7883.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7882_7883 : H12AffineEnvironment.transform 31 304554 env7882 = env7883 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 304554 env7882 == env7883) = true)

theorem identity7883 : scanCanonicalize (H12AffineFastState.compose env7883 (packedSelected [3,5,10] rootPS)) = affineNative (2^(17+1) ^^^ 42239) := by decide +kernel

theorem selectedBound7883 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env7884 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1345,8192,1297,32768,65536,1345,42239,524288,32768,1344,41088,17,98564,8329,65,1403,1297,1296,75787,1285,341,256,599163,1344,136]

theorem envBound7884 : H12AffineFastState.Bounded env7884 := by
  intro p hp
  have h : env7884.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7883_7884 : H12AffineEnvironment.transform 17 42239 env7883 = env7884 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 42239 env7883 == env7884) = true)

def env7885 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1345,8192,1297,8580,65536,1345,1403,524288,8580,1344,260,17,73856,8329,65,1403,1297,1296,75787,1285,341,256,599163,1344,136]

theorem envBound7885 : H12AffineFastState.Bounded env7885 := by
  intro p hp
  have h : env7885.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7884_7885 : H12AffineEnvironment.transform 14 8580 env7884 = env7885 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8580 env7884 == env7885) = true)

theorem identity7885 : scanCanonicalize (H12AffineFastState.compose env7885 (packedSelected [7] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound7885 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env7886 : List Nat := [2,4,8,16,32,64,128,5,137,1024,2048,1092,8192,1044,8321,65536,1092,1150,524288,8321,1093,1,17,73856,8329,65,1150,1044,1045,75787,1024,80,5,599163,1093,136]

theorem envBound7886 : H12AffineFastState.Bounded env7886 := by
  intro p hp
  have h : env7886.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7885_7886 : H12AffineEnvironment.transform 7 5 env7885 = env7886 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env7885 == env7886) = true)

theorem identity7886 : scanCanonicalize (H12AffineFastState.compose env7886 (packedSelected [1,12,13] rootPS)) = affineNative (2^(18+1) ^^^ 1024) := by decide +kernel

theorem selectedBound7886 : packedSelected [1,12,13] rootPS < 2^1333 := by decide +kernel

def env7887 : List Nat := [2,4,8,16,32,64,128,5,137,1024,2048,1092,8192,1044,8321,65536,1092,1150,1024,8321,1093,1,17,73856,8329,65,1150,1044,1045,75787,1024,80,5,73851,1093,136]

theorem envBound7887 : H12AffineFastState.Bounded env7887 := by
  intro p hp
  have h : env7887.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7886_7887 : H12AffineEnvironment.transform 18 1024 env7886 = env7887 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env7886 == env7887) = true)

theorem identity7887 : scanCanonicalize (H12AffineFastState.compose env7887 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 8315) := by decide +kernel

theorem selectedBound7887 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env7888 : List Nat := [2,4,8,16,32,64,128,5,137,1024,2048,1092,8192,1044,8321,8315,1092,1150,1024,8321,1093,1,17,251,8329,65,1150,1044,1045,2160,1024,80,5,0,1093,136]

theorem envBound7888 : H12AffineFastState.Bounded env7888 := by
  intro p hp
  have h : env7888.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7887_7888 : H12AffineEnvironment.transform 15 8315 env7887 = env7888 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8315 env7887 == env7888) = true)

theorem identity7888 : scanCanonicalize (H12AffineFastState.compose env7888 (packedSelected [2,23,32] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound7888 : packedSelected [2,23,32] rootPS < 2^1333 := by decide +kernel

def env7889 : List Nat := [2,4,8,16,32,64,9,5,0,1024,2048,1092,8192,1044,8200,8315,1092,1150,1024,8200,1093,1,17,114,8192,65,1150,1044,1045,2160,1024,80,5,0,1093,1]

theorem envBound7889 : H12AffineFastState.Bounded env7889 := by
  intro p hp
  have h : env7889.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7888_7889 : H12AffineEnvironment.transform 6 9 env7888 = env7889 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env7888 == env7889) = true)

theorem identity7889 : scanCanonicalize (H12AffineFastState.compose env7889 (packedSelected [1,8,12] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound7889 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env7890 : List Nat := [2,4,8,16,32,17,9,5,0,1024,2048,1045,8192,1044,8200,8234,1045,1071,1024,8200,1044,1,17,35,8192,16,1071,1044,1045,2081,1024,1,5,0,1044,1]

theorem envBound7890 : H12AffineFastState.Bounded env7890 := by
  intro p hp
  have h : env7890.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7889_7890 : H12AffineEnvironment.transform 5 17 env7889 = env7890 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7889 == env7890) = true)

theorem identity7890 : scanCanonicalize (H12AffineFastState.compose env7890 (packedSelected [1,3,5] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound7890 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env7891 : List Nat := [2,4,8,16,0,17,9,5,0,1024,2048,1045,8192,1044,8200,8202,1045,1039,1024,8200,1044,1,17,3,8192,16,1039,1044,1045,2049,1024,1,5,0,1044,1]

theorem envBound7891 : H12AffineFastState.Bounded env7891 := by
  intro p hp
  have h : env7891.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7890_7891 : H12AffineEnvironment.transform 4 0 env7890 = env7891 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env7890 == env7891) = true)

theorem identity7891 : scanCanonicalize (H12AffineFastState.compose env7891 (packedSelected [0] rootPS)) = affineNative (2^(12+1) ^^^ 1030) := by decide +kernel

theorem selectedBound7891 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7892 : List Nat := [2,4,8,16,0,17,9,5,0,1024,2048,1045,1030,1044,1038,1036,1045,1039,1024,1038,1044,1,17,3,1030,16,1039,1044,1045,2049,1024,1,5,0,1044,1]

theorem envBound7892 : H12AffineFastState.Bounded env7892 := by
  intro p hp
  have h : env7892.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7891_7892 : H12AffineEnvironment.transform 12 1030 env7891 = env7892 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1030 env7891 == env7892) = true)

theorem identity7892 : scanCanonicalize (H12AffineFastState.compose env7892 (packedSelected [2] rootPS)) = affineNative (2^(10+1) ^^^ 1039) := by decide +kernel

theorem selectedBound7892 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7893 : List Nat := [2,4,8,16,0,17,9,5,0,1024,1039,1045,1030,1044,1038,1036,1045,1039,1024,1038,1044,1,17,3,1030,16,1039,1044,1045,1038,1024,1,5,0,1044,1]

theorem envBound7893 : H12AffineFastState.Bounded env7893 := by
  intro p hp
  have h : env7893.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7892_7893 : H12AffineEnvironment.transform 10 1039 env7892 = env7893 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1039 env7892 == env7893) = true)

def env7894 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1345,8192,1297,8581,65536,1345,1402,524288,8581,1344,261,17,73857,8329,65,1403,1297,1296,75787,1285,341,256,599163,1344,136]

theorem envBound7894 : H12AffineFastState.Bounded env7894 := by
  intro p hp
  have h : env7894.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7884_7894 : H12AffineEnvironment.transform 14 8581 env7884 = env7894 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8581 env7884 == env7894) = true)

theorem identity7894 : scanCanonicalize (H12AffineFastState.compose env7894 (packedSelected [7] rootPS)) = affineNative (2^(12+1) ^^^ 1395) := by decide +kernel

theorem selectedBound7894 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env7895 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1345,1395,1297,1270,65536,1345,1402,524288,1270,1344,261,17,67058,1530,65,1403,1297,1296,68984,1285,341,256,590088,1344,136]

theorem envBound7895 : H12AffineFastState.Bounded env7895 := by
  intro p hp
  have h : env7895.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7894_7895 : H12AffineEnvironment.transform 12 1395 env7894 = env7895 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1395 env7894 == env7895) = true)

def env7896 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1345,1395,1297,1270,65536,1345,1402,524288,1270,1344,261,17,67058,1530,65,1403,1297,1296,66936,1285,341,256,590088,1344,136]

theorem envBound7896 : H12AffineFastState.Bounded env7896 := by
  intro p hp
  have h : env7896.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7895_7896 : H12AffineEnvironment.transform 10 0 env7895 = env7896 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env7895 == env7896) = true)

theorem identity7896 : scanCanonicalize (H12AffineFastState.compose env7896 (packedSelected [0] rootPS)) = affineNative (2^(15+1) ^^^ 171) := by decide +kernel

theorem selectedBound7896 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7897 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1345,1395,1297,1270,171,1345,1402,524288,1270,1344,261,17,1369,1530,65,1403,1297,1296,1491,1285,341,256,524707,1344,136]

theorem envBound7897 : H12AffineFastState.Bounded env7897 := by
  intro p hp
  have h : env7897.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7896_7897 : H12AffineEnvironment.transform 15 171 env7896 = env7897 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 171 env7896 == env7897) = true)

theorem identity7897 : scanCanonicalize (H12AffineFastState.compose env7897 (packedSelected [2,4] rootPS)) = affineNative (2^(9+1) ^^^ 215) := by decide +kernel

theorem selectedBound7897 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env7898 : List Nat := [2,4,8,16,32,64,128,256,137,215,0,406,420,454,33,171,406,429,524288,33,407,261,17,398,301,65,428,454,455,260,466,341,256,524707,407,136]

theorem envBound7898 : H12AffineFastState.Bounded env7898 := by
  intro p hp
  have h : env7898.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7897_7898 : H12AffineEnvironment.transform 9 215 env7897 = env7898 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 215 env7897 == env7898) = true)

theorem identity7898 : scanCanonicalize (H12AffineFastState.compose env7898 (packedSelected [2,9,11] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound7898 : packedSelected [2,9,11] rootPS < 2^1333 := by decide +kernel

def env7899 : List Nat := [2,4,8,16,32,64,128,4,137,215,0,146,160,194,33,171,146,169,524288,33,147,1,17,138,41,65,168,194,195,0,214,81,4,524455,147,136]

theorem envBound7899 : H12AffineFastState.Bounded env7899 := by
  intro p hp
  have h : env7899.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7898_7899 : H12AffineEnvironment.transform 7 4 env7898 = env7899 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env7898 == env7899) = true)

def env7900 : List Nat := [2,4,8,16,0,64,128,4,137,215,0,146,128,194,1,139,146,137,524288,1,147,1,17,138,9,65,136,194,195,0,214,81,4,524423,147,136]

theorem envBound7900 : H12AffineFastState.Bounded env7900 := by
  intro p hp
  have h : env7900.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7899_7900 : H12AffineEnvironment.transform 4 0 env7899 = env7900 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env7899 == env7900) = true)

theorem identity7900 : scanCanonicalize (H12AffineFastState.compose env7900 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound7900 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7901 : List Nat := [2,4,8,16,0,64,88,4,81,15,0,74,88,26,1,83,74,81,524288,1,75,1,17,82,9,65,80,26,27,0,14,81,4,524383,75,80]

theorem envBound7901 : H12AffineFastState.Bounded env7901 := by
  intro p hp
  have h : env7901.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7900_7901 : H12AffineEnvironment.transform 6 88 env7900 = env7901 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env7900 == env7901) = true)

def env7902 : List Nat := [2,4,8,16,0,16,8,4,1,15,0,26,8,26,1,3,26,1,524288,1,27,1,17,2,9,17,0,26,27,0,14,1,4,524303,27,0]

theorem envBound7902 : H12AffineFastState.Bounded env7902 := by
  intro p hp
  have h : env7902.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7901_7902 : H12AffineEnvironment.transform 5 16 env7901 = env7902 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7901 == env7902) = true)

theorem identity7902 : scanCanonicalize (H12AffineFastState.compose env7902 (packedSelected [3] rootPS)) = affineNative (2^(18+1) ^^^ 14) := by decide +kernel

theorem selectedBound7902 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env7903 : List Nat := [2,4,8,16,0,16,8,4,1,15,0,26,8,26,1,3,26,1,14,1,27,1,17,2,9,17,0,26,27,0,14,1,4,1,27,0]

theorem envBound7903 : H12AffineFastState.Bounded env7903 := by
  intro p hp
  have h : env7903.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7902_7903 : H12AffineEnvironment.transform 18 14 env7902 = env7903 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 14 env7902 == env7903) = true)

def leafEnv7903 : List Nat := [2,4,8,16,0,16,8,4,1,15,0,26,8,26,1,3,26,1,14,1,27,1,17,2,14,9,1,17,0,26,27,0,14,1,4,1,5,2,27,0,0,27,1]

def active7903 : List Nat := [0,1,2,3]

def tree7903 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7903 : H12WitnessSearch.Good tree7903 := H12GlobalWitnessIndex.good

theorem leafIdentity7903 : H12AffineFastState.composeSystem env7903 rootObs = leafEnv7903 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7903 rootObs == leafEnv7903) = true)

theorem terminalChecked7903 : H12PackedTerminal.terminalCheckFast leafEnv7903 active7903 tree7903 = true := by decide +kernel

def env7904 : List Nat := [2,4,8,16,0,17,9,4,0,15,0,27,9,26,1,2,27,0,524288,1,26,1,17,3,9,16,1,26,27,0,14,0,4,524302,26,1]

theorem envBound7904 : H12AffineFastState.Bounded env7904 := by
  intro p hp
  have h : env7904.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7901_7904 : H12AffineEnvironment.transform 5 17 env7901 = env7904 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7901 == env7904) = true)

def leafEnv7904 : List Nat := [2,4,8,16,0,17,9,4,0,15,0,27,9,26,1,2,27,0,524288,1,26,1,17,3,524288,9,1,16,1,26,27,0,14,0,4,524302,5,2,26,1,0,27,1]

def active7904 : List Nat := [0,1,2,3,18]

def tree7904 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7904 : H12WitnessSearch.Good tree7904 := H12GlobalWitnessIndex.good

theorem leafIdentity7904 : H12AffineFastState.composeSystem env7904 rootObs = leafEnv7904 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7904 rootObs == leafEnv7904) = true)

theorem terminalChecked7904 : H12PackedTerminal.terminalCheckFast leafEnv7904 active7904 tree7904 = true := by decide +kernel

def env7905 : List Nat := [2,4,8,16,1,64,128,4,137,215,0,146,129,194,0,138,146,136,524288,0,147,1,17,138,8,65,137,194,195,0,214,81,4,524422,147,136]

theorem envBound7905 : H12AffineFastState.Bounded env7905 := by
  intro p hp
  have h : env7905.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7899_7905 : H12AffineEnvironment.transform 4 1 env7899 = env7905 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env7899 == env7905) = true)

theorem identity7905 : scanCanonicalize (H12AffineFastState.compose env7905 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound7905 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7906 : List Nat := [2,4,8,16,1,64,9,4,0,94,0,27,8,75,0,3,27,1,524288,0,26,1,17,3,8,65,0,75,74,0,95,81,4,524303,26,1]

theorem envBound7906 : H12AffineFastState.Bounded env7906 := by
  intro p hp
  have h : env7906.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7905_7906 : H12AffineEnvironment.transform 6 9 env7905 = env7906 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env7905 == env7906) = true)

theorem identity7906 : scanCanonicalize (H12AffineFastState.compose env7906 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound7906 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7907 : List Nat := [2,4,8,16,1,16,9,4,0,14,0,27,8,27,0,3,27,1,524288,0,26,1,17,3,8,17,0,27,26,0,15,1,4,524303,26,1]

theorem envBound7907 : H12AffineFastState.Bounded env7907 := by
  intro p hp
  have h : env7907.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7906_7907 : H12AffineEnvironment.transform 5 16 env7906 = env7907 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7906 == env7907) = true)

def leafEnv7907 : List Nat := [2,4,8,16,1,16,9,4,0,14,0,27,8,27,0,3,27,1,524288,0,26,1,17,3,524288,8,1,17,0,27,26,0,15,1,4,524303,5,3,26,1,0,26,1]

def active7907 : List Nat := [0,1,2,3,18]

def tree7907 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7907 : H12WitnessSearch.Good tree7907 := H12GlobalWitnessIndex.good

theorem leafIdentity7907 : H12AffineFastState.composeSystem env7907 rootObs = leafEnv7907 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7907 rootObs == leafEnv7907) = true)

theorem terminalChecked7907 : H12PackedTerminal.terminalCheckFast leafEnv7907 active7907 tree7907 = true := by decide +kernel

def env7908 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1345,1395,1297,1270,65536,1345,1402,524288,1270,1344,261,17,67058,1530,65,1403,1297,1296,66937,1285,341,256,590088,1344,136]

theorem envBound7908 : H12AffineFastState.Bounded env7908 := by
  intro p hp
  have h : env7908.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7895_7908 : H12AffineEnvironment.transform 10 1 env7895 = env7908 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env7895 == env7908) = true)

theorem identity7908 : scanCanonicalize (H12AffineFastState.compose env7908 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 466) := by decide +kernel

theorem selectedBound7908 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7909 : List Nat := [2,4,8,16,32,64,128,256,137,466,1,147,161,195,292,65536,147,168,524288,292,146,261,17,65568,40,65,169,195,194,65707,215,341,256,590088,146,136]

theorem envBound7909 : H12AffineFastState.Bounded env7909 := by
  intro p hp
  have h : env7909.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7908_7909 : H12AffineEnvironment.transform 9 466 env7908 = env7909 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 466 env7908 == env7909) = true)

theorem identity7909 : scanCanonicalize (H12AffineFastState.compose env7909 (packedSelected [11,18] rootPS)) = affineNative (2^(15+1) ^^^ 430) := by decide +kernel

theorem selectedBound7909 : packedSelected [11,18] rootPS < 2^1333 := by decide +kernel

def env7910 : List Nat := [2,4,8,16,32,64,128,256,137,466,1,147,161,195,292,430,147,168,524288,292,146,261,17,398,40,65,169,195,194,261,215,341,256,524454,146,136]

theorem envBound7910 : H12AffineFastState.Bounded env7910 := by
  intro p hp
  have h : env7910.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7909_7910 : H12AffineEnvironment.transform 15 430 env7909 = env7910 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 430 env7909 == env7910) = true)

theorem identity7910 : scanCanonicalize (H12AffineFastState.compose env7910 (packedSelected [2,4,11] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound7910 : packedSelected [2,4,11] rootPS < 2^1333 := by decide +kernel

def env7911 : List Nat := [2,4,8,16,32,64,128,4,137,214,1,147,161,195,32,170,147,168,524288,32,146,1,17,138,40,65,169,195,194,1,215,81,4,524454,146,136]

theorem envBound7911 : H12AffineFastState.Bounded env7911 := by
  intro p hp
  have h : env7911.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7910_7911 : H12AffineEnvironment.transform 7 4 env7910 = env7911 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env7910 == env7911) = true)

def env7912 : List Nat := [2,4,8,16,0,64,128,4,137,214,1,147,129,195,0,138,147,136,524288,0,146,1,17,138,8,65,137,195,194,1,215,81,4,524422,146,136]

theorem envBound7912 : H12AffineFastState.Bounded env7912 := by
  intro p hp
  have h : env7912.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7911_7912 : H12AffineEnvironment.transform 4 0 env7911 = env7912 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env7911 == env7912) = true)

theorem identity7912 : scanCanonicalize (H12AffineFastState.compose env7912 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound7912 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7913 : List Nat := [2,4,8,16,0,64,88,4,81,14,1,75,89,27,0,82,75,80,524288,0,74,1,17,82,8,65,81,27,26,1,15,81,4,524382,74,80]

theorem envBound7913 : H12AffineFastState.Bounded env7913 := by
  intro p hp
  have h : env7913.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7912_7913 : H12AffineEnvironment.transform 6 88 env7912 = env7913 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env7912 == env7913) = true)

def env7914 : List Nat := [2,4,8,16,0,16,8,4,1,14,1,27,9,27,0,2,27,0,524288,0,26,1,17,2,8,17,1,27,26,1,15,1,4,524302,26,0]

theorem envBound7914 : H12AffineFastState.Bounded env7914 := by
  intro p hp
  have h : env7914.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7913_7914 : H12AffineEnvironment.transform 5 16 env7913 = env7914 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7913 == env7914) = true)

theorem identity7914 : scanCanonicalize (H12AffineFastState.compose env7914 (packedSelected [3] rootPS)) = affineNative (2^(18+1) ^^^ 15) := by decide +kernel

theorem selectedBound7914 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env7915 : List Nat := [2,4,8,16,0,16,8,4,1,14,1,27,9,27,0,2,27,0,15,0,26,1,17,2,8,17,1,27,26,1,15,1,4,1,26,0]

theorem envBound7915 : H12AffineFastState.Bounded env7915 := by
  intro p hp
  have h : env7915.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7914_7915 : H12AffineEnvironment.transform 18 15 env7914 = env7915 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 15 env7914 == env7915) = true)

def leafEnv7915 : List Nat := [2,4,8,16,0,16,8,4,1,14,1,27,9,27,0,2,27,0,15,0,26,1,17,2,15,8,1,17,1,27,26,1,15,1,4,1,5,3,26,0,0,26,1]

def active7915 : List Nat := [0,1,2,3]

def tree7915 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7915 : H12WitnessSearch.Good tree7915 := H12GlobalWitnessIndex.good

theorem leafIdentity7915 : H12AffineFastState.composeSystem env7915 rootObs = leafEnv7915 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7915 rootObs == leafEnv7915) = true)

theorem terminalChecked7915 : H12PackedTerminal.terminalCheckFast leafEnv7915 active7915 tree7915 = true := by decide +kernel

def env7916 : List Nat := [2,4,8,16,0,17,9,4,0,14,1,26,8,27,0,3,26,1,524288,0,27,1,17,3,8,16,0,27,26,1,15,0,4,524303,27,1]

theorem envBound7916 : H12AffineFastState.Bounded env7916 := by
  intro p hp
  have h : env7916.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7913_7916 : H12AffineEnvironment.transform 5 17 env7913 = env7916 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7913 == env7916) = true)

def leafEnv7916 : List Nat := [2,4,8,16,0,17,9,4,0,14,1,26,8,27,0,3,26,1,524288,0,27,1,17,3,524288,8,1,16,0,27,26,1,15,0,4,524303,5,3,27,1,0,26,1]

def active7916 : List Nat := [0,1,2,3,18]

def tree7916 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7916 : H12WitnessSearch.Good tree7916 := H12GlobalWitnessIndex.good

theorem leafIdentity7916 : H12AffineFastState.composeSystem env7916 rootObs = leafEnv7916 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7916 rootObs == leafEnv7916) = true)

theorem terminalChecked7916 : H12PackedTerminal.terminalCheckFast leafEnv7916 active7916 tree7916 = true := by decide +kernel

def env7917 : List Nat := [2,4,8,16,1,64,128,4,137,214,1,147,128,195,1,139,147,137,524288,1,146,1,17,138,9,65,136,195,194,1,215,81,4,524423,146,136]

theorem envBound7917 : H12AffineFastState.Bounded env7917 := by
  intro p hp
  have h : env7917.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7911_7917 : H12AffineEnvironment.transform 4 1 env7911 = env7917 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env7911 == env7917) = true)

theorem identity7917 : scanCanonicalize (H12AffineFastState.compose env7917 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound7917 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7918 : List Nat := [2,4,8,16,1,64,9,4,0,95,1,26,9,74,1,2,26,0,524288,1,27,1,17,3,9,65,1,74,75,1,94,81,4,524302,27,1]

theorem envBound7918 : H12AffineFastState.Bounded env7918 := by
  intro p hp
  have h : env7918.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7917_7918 : H12AffineEnvironment.transform 6 9 env7917 = env7918 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env7917 == env7918) = true)

theorem identity7918 : scanCanonicalize (H12AffineFastState.compose env7918 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound7918 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7919 : List Nat := [2,4,8,16,1,16,9,4,0,15,1,26,9,26,1,2,26,0,524288,1,27,1,17,3,9,17,1,26,27,1,14,1,4,524302,27,1]

theorem envBound7919 : H12AffineFastState.Bounded env7919 := by
  intro p hp
  have h : env7919.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7918_7919 : H12AffineEnvironment.transform 5 16 env7918 = env7919 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7918 == env7919) = true)

def leafEnv7919 : List Nat := [2,4,8,16,1,16,9,4,0,15,1,26,9,26,1,2,26,0,524288,1,27,1,17,3,524288,9,1,17,1,26,27,1,14,1,4,524302,5,2,27,1,0,27,1]

def active7919 : List Nat := [0,1,2,3,18]

def tree7919 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7919 : H12WitnessSearch.Good tree7919 := H12GlobalWitnessIndex.good

theorem leafIdentity7919 : H12AffineFastState.composeSystem env7919 rootObs = leafEnv7919 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7919 rootObs == leafEnv7919) = true)

theorem terminalChecked7919 : H12PackedTerminal.terminalCheckFast leafEnv7919 active7919 tree7919 = true := by decide +kernel

def env7920 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1345,8192,1297,32768,65536,1345,262144,524288,32768,1344,41089,17,98564,8329,65,303493,1297,1296,75786,1285,4294967296,256,4295566639,1344,136]

theorem envBound7920 : H12AffineFastState.Bounded env7920 := by
  intro p hp
  have h : env7920.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7881_7920 : H12AffineEnvironment.transform 21 41089 env7881 = env7920 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 41089 env7881 == env7920) = true)

theorem identity7920 : scanCanonicalize (H12AffineFastState.compose env7920 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 263334) := by decide +kernel

theorem selectedBound7920 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7921 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1345,8192,1297,32768,65536,1345,262144,524288,32768,1344,41089,17,98564,8329,65,303493,1297,1296,75786,1285,263334,256,860553,1344,136]

theorem envBound7921 : H12AffineFastState.Bounded env7921 := by
  intro p hp
  have h : env7921.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7920_7921 : H12AffineEnvironment.transform 31 263334 env7920 = env7921 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 263334 env7920 == env7921) = true)

theorem identity7921 : scanCanonicalize (H12AffineFastState.compose env7921 (packedSelected [3,5,10] rootPS)) = affineNative (2^(18+1) ^^^ 262643) := by decide +kernel

theorem selectedBound7921 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env7922 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1345,8192,1297,32768,65536,1345,262144,262643,32768,1344,41089,17,98564,8329,65,303493,1297,1296,75786,1285,263334,256,73850,1344,136]

theorem envBound7922 : H12AffineFastState.Bounded env7922 := by
  intro p hp
  have h : env7922.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7921_7922 : H12AffineEnvironment.transform 18 262643 env7921 = env7922 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 262643 env7921 == env7922) = true)

def env7923 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1345,8192,1297,32768,65536,1345,32904,33147,32768,1344,41089,17,98564,8329,65,8461,1297,1296,75786,1285,33838,256,73850,1344,136]

theorem envBound7923 : H12AffineFastState.Bounded env7923 := by
  intro p hp
  have h : env7923.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7922_7923 : H12AffineEnvironment.transform 17 32904 env7922 = env7923 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 32904 env7922 == env7923) = true)

theorem identity7923 : scanCanonicalize (H12AffineFastState.compose env7923 (packedSelected [7] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound7923 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env7924 : List Nat := [2,4,8,16,32,64,128,5,137,1024,2048,1092,8192,1044,32768,65536,1092,32904,32894,32768,1093,41089,17,98305,8329,65,8200,1044,1045,75786,1024,33838,5,73850,1093,136]

theorem envBound7924 : H12AffineFastState.Bounded env7924 := by
  intro p hp
  have h : env7924.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7923_7924 : H12AffineEnvironment.transform 7 5 env7923 = env7924 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env7923 == env7924) = true)

theorem identity7924 : scanCanonicalize (H12AffineFastState.compose env7924 (packedSelected [1,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 1150) := by decide +kernel

theorem selectedBound7924 : packedSelected [1,12,13] rootPS < 2^1333 := by decide +kernel

def env7925 : List Nat := [2,4,8,16,32,64,128,5,137,1024,2048,1092,8192,1044,1150,65536,1092,1270,1024,1150,1093,9471,17,66687,8329,65,8200,1044,1045,75786,1024,80,5,73850,1093,136]

theorem envBound7925 : H12AffineFastState.Bounded env7925 := by
  intro p hp
  have h : env7925.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7924_7925 : H12AffineEnvironment.transform 14 1150 env7924 = env7925 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 1150 env7924 == env7925) = true)

theorem identity7925 : scanCanonicalize (H12AffineFastState.compose env7925 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 8314) := by decide +kernel

theorem selectedBound7925 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env7926 : List Nat := [2,4,8,16,32,64,128,5,137,1024,2048,1092,8192,1044,1150,8314,1092,1270,1024,1150,1093,9471,17,9221,8329,65,8200,1044,1045,2160,1024,80,5,0,1093,136]

theorem envBound7926 : H12AffineFastState.Bounded env7926 := by
  intro p hp
  have h : env7926.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7925_7926 : H12AffineEnvironment.transform 15 8314 env7925 = env7926 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8314 env7925 == env7926) = true)

theorem identity7926 : scanCanonicalize (H12AffineFastState.compose env7926 (packedSelected [2,23,32] rootPS)) = affineNative (2^(12+1) ^^^ 1143) := by decide +kernel

theorem selectedBound7926 : packedSelected [2,23,32] rootPS < 2^1333 := by decide +kernel

def env7927 : List Nat := [2,4,8,16,32,64,128,5,137,1024,2048,1092,1143,1044,1150,1037,1092,1270,1024,1150,1093,136,17,114,1278,65,1151,1044,1045,2160,1024,80,5,0,1093,136]

theorem envBound7927 : H12AffineFastState.Bounded env7927 := by
  intro p hp
  have h : env7927.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7926_7927 : H12AffineEnvironment.transform 12 1143 env7926 = env7927 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1143 env7926 == env7927) = true)

theorem identity7927 : scanCanonicalize (H12AffineFastState.compose env7927 (packedSelected [1,8,12] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound7927 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env7928 : List Nat := [2,4,8,16,32,16,128,5,137,1024,2048,1044,1063,1044,1070,1037,1044,1190,1024,1070,1045,136,17,34,1198,17,1071,1044,1045,2080,1024,0,5,0,1045,136]

theorem envBound7928 : H12AffineFastState.Bounded env7928 := by
  intro p hp
  have h : env7928.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7927_7928 : H12AffineEnvironment.transform 5 16 env7927 = env7928 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7927 == env7928) = true)

theorem identity7928 : scanCanonicalize (H12AffineFastState.compose env7928 (packedSelected [1,3,5] rootPS)) = affineNative (2^(10+1) ^^^ 1071) := by decide +kernel

theorem selectedBound7928 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env7929 : List Nat := [2,4,8,16,32,16,128,5,137,1024,1071,1044,1063,1044,1070,1037,1044,1190,1024,1070,1045,136,17,34,1198,17,1071,1044,1045,1039,1024,0,5,0,1045,136]

theorem envBound7929 : H12AffineFastState.Bounded env7929 := by
  intro p hp
  have h : env7929.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7928_7929 : H12AffineEnvironment.transform 10 1071 env7928 = env7929 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1071 env7928 == env7929) = true)

theorem identity7929 : scanCanonicalize (H12AffineFastState.compose env7929 (packedSelected [0,2] rootPS)) = affineNative (2^(6+1) ^^^ 40) := by decide +kernel

theorem selectedBound7929 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env7930 : List Nat := [2,4,8,16,32,16,40,5,33,1024,1071,1044,1063,1044,1070,1037,1044,1038,1024,1070,1045,32,17,34,1030,17,1071,1044,1045,1039,1024,0,5,0,1045,32]

theorem envBound7930 : H12AffineFastState.Bounded env7930 := by
  intro p hp
  have h : env7930.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7929_7930 : H12AffineEnvironment.transform 6 40 env7929 = env7930 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 40 env7929 == env7930) = true)

def env7931 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1345,8192,1297,32768,65536,1345,32905,33146,32768,1344,41089,17,98564,8329,65,8460,1297,1296,75786,1285,33839,256,73850,1344,136]

theorem envBound7931 : H12AffineFastState.Bounded env7931 := by
  intro p hp
  have h : env7931.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7922_7931 : H12AffineEnvironment.transform 17 32905 env7922 = env7931 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 32905 env7922 == env7931) = true)

theorem identity7931 : scanCanonicalize (H12AffineFastState.compose env7931 (packedSelected [7] rootPS)) = affineNative (2^(14+1) ^^^ 8320) := by decide +kernel

theorem selectedBound7931 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env7932 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1345,8192,1297,8320,65536,1345,8201,8698,8320,1344,1,17,74116,8329,65,8460,1297,1296,75786,1285,9391,256,73850,1344,136]

theorem envBound7932 : H12AffineFastState.Bounded env7932 := by
  intro p hp
  have h : env7932.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7931_7932 : H12AffineEnvironment.transform 14 8320 env7931 = env7932 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8320 env7931 == env7932) = true)

def env7933 : List Nat := [2,4,8,16,32,64,128,256,137,320,2048,1,8192,81,8320,65536,1,8201,8698,8320,0,1,17,74116,8329,65,8460,81,80,75786,69,8687,256,73850,0,136]

theorem envBound7933 : H12AffineFastState.Bounded env7933 := by
  intro p hp
  have h : env7933.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7932_7933 : H12AffineEnvironment.transform 9 320 env7932 = env7933 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 320 env7932 == env7933) = true)

theorem identity7933 : scanCanonicalize (H12AffineFastState.compose env7933 (packedSelected [12] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound7933 : packedSelected [12] rootPS < 2^1333 := by decide +kernel

def env7934 : List Nat := [2,4,8,16,32,64,128,4,137,68,2048,1,8192,81,8320,65536,1,8201,8446,8320,0,1,17,73856,8329,65,8200,81,80,75786,69,8427,4,73850,0,136]

theorem envBound7934 : H12AffineFastState.Bounded env7934 := by
  intro p hp
  have h : env7934.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7933_7934 : H12AffineEnvironment.transform 7 4 env7933 = env7934 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env7933 == env7934) = true)

def env7935 : List Nat := [2,4,8,16,32,64,128,4,137,68,0,1,8192,81,8320,65536,1,8201,8446,8320,0,1,17,73856,8329,65,8200,81,80,73738,69,8427,4,73850,0,136]

theorem envBound7935 : H12AffineFastState.Bounded env7935 := by
  intro p hp
  have h : env7935.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7934_7935 : H12AffineEnvironment.transform 10 0 env7934 = env7935 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env7934 == env7935) = true)

theorem identity7935 : scanCanonicalize (H12AffineFastState.compose env7935 (packedSelected [0] rootPS)) = affineNative (2^(15+1) ^^^ 171) := by decide +kernel

theorem selectedBound7935 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7936 : List Nat := [2,4,8,16,32,64,128,4,137,68,0,1,8192,81,8320,171,1,8201,8446,8320,0,1,17,8235,8329,65,8200,81,80,8353,69,8427,4,8401,0,136]

theorem envBound7936 : H12AffineFastState.Bounded env7936 := by
  intro p hp
  have h : env7936.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7935_7936 : H12AffineEnvironment.transform 15 171 env7935 = env7936 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 171 env7935 == env7936) = true)

theorem identity7936 : scanCanonicalize (H12AffineFastState.compose env7936 (packedSelected [2,4] rootPS)) = affineNative (2^(12+1) ^^^ 161) := by decide +kernel

theorem selectedBound7936 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env7937 : List Nat := [2,4,8,16,32,64,128,4,137,68,0,1,161,81,33,171,1,168,95,33,0,1,17,138,40,65,169,81,80,0,69,74,4,112,0,136]

theorem envBound7937 : H12AffineFastState.Bounded env7937 := by
  intro p hp
  have h : env7937.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7936_7937 : H12AffineEnvironment.transform 12 161 env7936 = env7937 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 161 env7936 == env7937) = true)

def env7938 : List Nat := [2,4,8,16,0,64,128,4,137,68,0,1,129,81,1,139,1,136,95,1,0,1,17,138,8,65,137,81,80,0,69,74,4,80,0,136]

theorem envBound7938 : H12AffineFastState.Bounded env7938 := by
  intro p hp
  have h : env7938.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7937_7938 : H12AffineEnvironment.transform 4 0 env7937 = env7938 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env7937 == env7938) = true)

theorem identity7938 : scanCanonicalize (H12AffineFastState.compose env7938 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 67) := by decide +kernel

theorem selectedBound7938 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7939 : List Nat := [2,4,8,16,0,64,67,4,74,68,0,1,66,81,1,72,1,75,95,1,0,1,17,73,8,65,74,81,80,0,69,74,4,80,0,75]

theorem envBound7939 : H12AffineFastState.Bounded env7939 := by
  intro p hp
  have h : env7939.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7938_7939 : H12AffineEnvironment.transform 6 67 env7938 = env7939 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 67 env7938 == env7939) = true)

theorem identity7939 : scanCanonicalize (H12AffineFastState.compose env7939 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound7939 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7940 : List Nat := [2,4,8,10,0,64,67,4,74,68,0,1,66,75,1,72,1,75,69,1,0,1,11,73,8,65,74,75,74,0,69,74,4,74,0,75]

theorem envBound7940 : H12AffineFastState.Bounded env7940 := by
  intro p hp
  have h : env7940.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7939_7940 : H12AffineEnvironment.transform 3 10 env7939 = env7940 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env7939 == env7940) = true)

def leafEnv7940 : List Nat := [2,4,8,10,0,64,67,4,74,68,0,1,66,75,1,72,1,75,69,1,0,1,11,73,69,8,1,65,74,75,74,0,69,74,4,74,5,2,0,75,0,74,1]

def active7940 : List Nat := [0,1,2,5]

def tree7940 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7940 : H12WitnessSearch.Good tree7940 := H12GlobalWitnessIndex.good

theorem leafIdentity7940 : H12AffineFastState.composeSystem env7940 rootObs = leafEnv7940 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7940 rootObs == leafEnv7940) = true)

theorem terminalChecked7940 : H12PackedTerminal.terminalCheckFast leafEnv7940 active7940 tree7940 = true := by decide +kernel

def env7941 : List Nat := [2,4,8,16,1,64,128,4,137,68,0,1,128,81,0,138,1,137,95,0,0,1,17,138,9,65,136,81,80,0,69,74,4,81,0,136]

theorem envBound7941 : H12AffineFastState.Bounded env7941 := by
  intro p hp
  have h : env7941.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7937_7941 : H12AffineEnvironment.transform 4 1 env7937 = env7941 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env7937 == env7941) = true)

theorem identity7941 : scanCanonicalize (H12AffineFastState.compose env7941 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound7941 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7942 : List Nat := [2,4,8,16,1,64,9,4,0,68,0,1,9,81,0,3,1,0,95,0,0,1,17,3,9,65,1,81,80,0,69,74,4,81,0,1]

theorem envBound7942 : H12AffineFastState.Bounded env7942 := by
  intro p hp
  have h : env7942.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7941_7942 : H12AffineEnvironment.transform 6 9 env7941 = env7942 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env7941 == env7942) = true)

theorem identity7942 : scanCanonicalize (H12AffineFastState.compose env7942 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound7942 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7943 : List Nat := [2,4,8,16,1,11,9,4,0,15,0,1,9,26,0,3,1,0,20,0,0,1,17,3,9,10,1,26,27,0,14,1,4,26,0,1]

theorem envBound7943 : H12AffineFastState.Bounded env7943 := by
  intro p hp
  have h : env7943.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7942_7943 : H12AffineEnvironment.transform 5 11 env7942 = env7943 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env7942 == env7943) = true)

theorem identity7943 : scanCanonicalize (H12AffineFastState.compose env7943 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound7943 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7944 : List Nat := [2,4,8,10,1,11,9,4,0,15,0,1,9,0,0,3,1,0,14,0,0,1,11,3,9,10,1,0,1,0,14,1,4,0,0,1]

theorem envBound7944 : H12AffineFastState.Bounded env7944 := by
  intro p hp
  have h : env7944.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7943_7944 : H12AffineEnvironment.transform 3 10 env7943 = env7944 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env7943 == env7944) = true)

def leafEnv7944 : List Nat := [2,4,8,10,1,11,9,4,0,15,0,1,9,0,0,3,1,0,14,0,0,1,11,3,14,9,1,10,1,0,1,0,14,1,4,0,5,3,0,1,0,1,1]

def active7944 : List Nat := [0,1,2]

def tree7944 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7944 : H12WitnessSearch.Good tree7944 := H12GlobalWitnessIndex.good

theorem leafIdentity7944 : H12AffineFastState.composeSystem env7944 rootObs = leafEnv7944 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7944 rootObs == leafEnv7944) = true)

theorem terminalChecked7944 : H12PackedTerminal.terminalCheckFast leafEnv7944 active7944 tree7944 = true := by decide +kernel

def env7945 : List Nat := [2,4,8,16,32,64,128,4,137,68,1,1,8192,81,8320,65536,1,8201,8446,8320,0,1,17,73856,8329,65,8200,81,80,73739,69,8427,4,73850,0,136]

theorem envBound7945 : H12AffineFastState.Bounded env7945 := by
  intro p hp
  have h : env7945.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7934_7945 : H12AffineEnvironment.transform 10 1 env7934 = env7945 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env7934 == env7945) = true)

theorem identity7945 : scanCanonicalize (H12AffineFastState.compose env7945 (packedSelected [0] rootPS)) = affineNative (2^(12+1) ^^^ 160) := by decide +kernel

theorem selectedBound7945 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7946 : List Nat := [2,4,8,16,32,64,128,4,137,68,1,1,160,81,32,65536,1,169,94,32,0,1,17,65568,41,65,168,81,80,65707,69,75,4,65754,0,136]

theorem envBound7946 : H12AffineFastState.Bounded env7946 := by
  intro p hp
  have h : env7946.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7945_7946 : H12AffineEnvironment.transform 12 160 env7945 = env7946 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 160 env7945 == env7946) = true)

theorem identity7946 : scanCanonicalize (H12AffineFastState.compose env7946 (packedSelected [2,9] rootPS)) = affineNative (2^(15+1) ^^^ 170) := by decide +kernel

theorem selectedBound7946 : packedSelected [2,9] rootPS < 2^1333 := by decide +kernel

def env7947 : List Nat := [2,4,8,16,32,64,128,4,137,68,1,1,160,81,32,170,1,169,94,32,0,1,17,138,41,65,168,81,80,1,69,75,4,112,0,136]

theorem envBound7947 : H12AffineFastState.Bounded env7947 := by
  intro p hp
  have h : env7947.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7946_7947 : H12AffineEnvironment.transform 15 170 env7946 = env7947 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 170 env7946 == env7947) = true)

def env7948 : List Nat := [2,4,8,16,0,64,128,4,137,68,1,1,128,81,0,138,1,137,94,0,0,1,17,138,9,65,136,81,80,1,69,75,4,80,0,136]

theorem envBound7948 : H12AffineFastState.Bounded env7948 := by
  intro p hp
  have h : env7948.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7947_7948 : H12AffineEnvironment.transform 4 0 env7947 = env7948 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env7947 == env7948) = true)

theorem identity7948 : scanCanonicalize (H12AffineFastState.compose env7948 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 66) := by decide +kernel

theorem selectedBound7948 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7949 : List Nat := [2,4,8,16,0,64,66,4,75,68,1,1,66,81,0,72,1,75,94,0,0,1,17,72,9,65,74,81,80,1,69,75,4,80,0,74]

theorem envBound7949 : H12AffineFastState.Bounded env7949 := by
  intro p hp
  have h : env7949.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7948_7949 : H12AffineEnvironment.transform 6 66 env7948 = env7949 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 66 env7948 == env7949) = true)

theorem identity7949 : scanCanonicalize (H12AffineFastState.compose env7949 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound7949 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7950 : List Nat := [2,4,8,11,0,64,66,4,75,68,1,1,66,74,0,72,1,75,69,0,0,1,10,72,9,65,74,74,75,1,69,75,4,75,0,74]

theorem envBound7950 : H12AffineFastState.Bounded env7950 := by
  intro p hp
  have h : env7950.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7949_7950 : H12AffineEnvironment.transform 3 11 env7949 = env7950 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env7949 == env7950) = true)

def leafEnv7950 : List Nat := [2,4,8,11,0,64,66,4,75,68,1,1,66,74,0,72,1,75,69,0,0,1,10,72,69,9,1,65,74,74,75,1,69,75,4,75,5,3,0,74,0,75,1]

def active7950 : List Nat := [0,1,2,5]

def tree7950 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7950 : H12WitnessSearch.Good tree7950 := H12GlobalWitnessIndex.good

theorem leafIdentity7950 : H12AffineFastState.composeSystem env7950 rootObs = leafEnv7950 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7950 rootObs == leafEnv7950) = true)

theorem terminalChecked7950 : H12PackedTerminal.terminalCheckFast leafEnv7950 active7950 tree7950 = true := by decide +kernel

def env7951 : List Nat := [2,4,8,16,1,64,128,4,137,68,1,1,129,81,1,139,1,136,94,1,0,1,17,138,8,65,137,81,80,1,69,75,4,81,0,136]

theorem envBound7951 : H12AffineFastState.Bounded env7951 := by
  intro p hp
  have h : env7951.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7947_7951 : H12AffineEnvironment.transform 4 1 env7947 = env7951 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env7947 == env7951) = true)

theorem identity7951 : scanCanonicalize (H12AffineFastState.compose env7951 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound7951 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7952 : List Nat := [2,4,8,16,1,64,9,4,0,68,1,1,8,81,1,2,1,1,94,1,0,1,17,3,8,65,0,81,80,1,69,75,4,81,0,1]

theorem envBound7952 : H12AffineFastState.Bounded env7952 := by
  intro p hp
  have h : env7952.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7951_7952 : H12AffineEnvironment.transform 6 9 env7951 = env7952 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env7951 == env7952) = true)

theorem identity7952 : scanCanonicalize (H12AffineFastState.compose env7952 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound7952 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7953 : List Nat := [2,4,8,16,1,10,9,4,0,14,1,1,8,27,1,2,1,1,20,1,0,1,17,3,8,11,0,27,26,1,15,1,4,27,0,1]

theorem envBound7953 : H12AffineFastState.Bounded env7953 := by
  intro p hp
  have h : env7953.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7952_7953 : H12AffineEnvironment.transform 5 10 env7952 = env7953 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env7952 == env7953) = true)

theorem identity7953 : scanCanonicalize (H12AffineFastState.compose env7953 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound7953 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7954 : List Nat := [2,4,8,11,1,10,9,4,0,14,1,1,8,0,1,2,1,1,15,1,0,1,10,3,8,11,0,0,1,1,15,1,4,0,0,1]

theorem envBound7954 : H12AffineFastState.Bounded env7954 := by
  intro p hp
  have h : env7954.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7953_7954 : H12AffineEnvironment.transform 3 11 env7953 = env7954 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env7953 == env7954) = true)

def leafEnv7954 : List Nat := [2,4,8,11,1,10,9,4,0,14,1,1,8,0,1,2,1,1,15,1,0,1,10,3,15,8,1,11,0,0,1,1,15,1,4,0,5,2,0,1,0,1,1]

def active7954 : List Nat := [0,1,2]

def tree7954 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7954 : H12WitnessSearch.Good tree7954 := H12GlobalWitnessIndex.good

theorem leafIdentity7954 : H12AffineFastState.composeSystem env7954 rootObs = leafEnv7954 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7954 rootObs == leafEnv7954) = true)

theorem terminalChecked7954 : H12PackedTerminal.terminalCheckFast leafEnv7954 active7954 tree7954 = true := by decide +kernel

def env7955 : List Nat := [2,4,8,16,32,64,128,256,137,321,2048,0,8192,80,8320,65536,0,8201,8698,8320,1,1,17,74116,8329,65,8460,80,81,75786,68,8686,256,73850,1,136]

theorem envBound7955 : H12AffineFastState.Bounded env7955 := by
  intro p hp
  have h : env7955.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7932_7955 : H12AffineEnvironment.transform 9 321 env7932 = env7955 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 321 env7932 == env7955) = true)

theorem identity7955 : scanCanonicalize (H12AffineFastState.compose env7955 (packedSelected [12] rootPS)) = affineNative (2^(15+1) ^^^ 2219) := by decide +kernel

theorem selectedBound7955 : packedSelected [12] rootPS < 2^1333 := by decide +kernel

def env7956 : List Nat := [2,4,8,16,32,64,128,256,137,321,2048,0,8192,80,8320,2219,0,8201,8698,8320,1,1,17,10543,8329,65,8460,80,81,8353,68,8686,256,10449,1,136]

theorem envBound7956 : H12AffineFastState.Bounded env7956 := by
  intro p hp
  have h : env7956.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7955_7956 : H12AffineEnvironment.transform 15 2219 env7955 = env7956 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2219 env7955 == env7956) = true)

theorem identity7956 : scanCanonicalize (H12AffineFastState.compose env7956 (packedSelected [1,5,8,13,15] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound7956 : packedSelected [1,5,8,13,15] rootPS < 2^1333 := by decide +kernel

def env7957 : List Nat := [2,4,8,16,32,64,128,4,137,69,2048,0,8192,80,8320,2219,0,8201,8446,8320,1,1,17,10283,8329,65,8200,80,81,8353,68,8426,4,10449,1,136]

theorem envBound7957 : H12AffineFastState.Bounded env7957 := by
  intro p hp
  have h : env7957.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7956_7957 : H12AffineEnvironment.transform 7 4 env7956 = env7957 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env7956 == env7957) = true)

theorem identity7957 : scanCanonicalize (H12AffineFastState.compose env7957 (packedSelected [2,4] rootPS)) = affineNative (2^(12+1) ^^^ 2209) := by decide +kernel

theorem selectedBound7957 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env7958 : List Nat := [2,4,8,16,32,64,128,4,137,69,2048,0,2209,80,2081,2219,0,2216,2143,2081,1,1,17,138,2088,65,2217,80,81,2048,68,2123,4,112,1,136]

theorem envBound7958 : H12AffineFastState.Bounded env7958 := by
  intro p hp
  have h : env7958.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7957_7958 : H12AffineEnvironment.transform 12 2209 env7957 = env7958 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2209 env7957 == env7958) = true)

def env7959 : List Nat := [2,4,8,16,0,64,128,4,137,69,2048,0,2177,80,2049,2187,0,2184,2143,2049,1,1,17,138,2056,65,2185,80,81,2048,68,2123,4,80,1,136]

theorem envBound7959 : H12AffineFastState.Bounded env7959 := by
  intro p hp
  have h : env7959.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7958_7959 : H12AffineEnvironment.transform 4 0 env7958 = env7959 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env7958 == env7959) = true)

theorem identity7959 : scanCanonicalize (H12AffineFastState.compose env7959 (packedSelected [2] rootPS)) = affineNative (2^(10+1) ^^^ 194) := by decide +kernel

theorem selectedBound7959 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7960 : List Nat := [2,4,8,16,0,64,128,4,137,69,194,0,67,80,195,73,0,74,157,195,1,1,17,138,202,65,75,80,81,194,68,137,4,80,1,136]

theorem envBound7960 : H12AffineFastState.Bounded env7960 := by
  intro p hp
  have h : env7960.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7959_7960 : H12AffineEnvironment.transform 10 194 env7959 = env7960 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 194 env7959 == env7960) = true)

theorem identity7960 : scanCanonicalize (H12AffineFastState.compose env7960 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 89) := by decide +kernel

theorem selectedBound7960 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7961 : List Nat := [2,4,8,16,0,64,89,4,80,69,27,0,67,80,26,73,0,74,68,26,1,1,17,83,19,65,75,80,81,27,68,80,4,80,1,81]

theorem envBound7961 : H12AffineFastState.Bounded env7961 := by
  intro p hp
  have h : env7961.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7960_7961 : H12AffineEnvironment.transform 6 89 env7960 = env7961 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env7960 == env7961) = true)

def leafEnv7961 : List Nat := [2,4,8,16,0,64,89,4,80,69,27,0,67,80,26,73,0,74,68,26,1,1,17,83,68,19,1,65,75,80,81,27,68,80,4,80,5,25,1,81,0,81,1]

def active7961 : List Nat := [0,1,2,3,5]

def tree7961 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7961 : H12WitnessSearch.Good tree7961 := H12GlobalWitnessIndex.good

theorem leafIdentity7961 : H12AffineFastState.composeSystem env7961 rootObs = leafEnv7961 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7961 rootObs == leafEnv7961) = true)

theorem terminalChecked7961 : H12PackedTerminal.terminalCheckFast leafEnv7961 active7961 tree7961 = true := by decide +kernel

def env7962 : List Nat := [2,4,8,16,1,64,128,4,137,69,2048,0,2176,80,2048,2186,0,2185,2143,2048,1,1,17,138,2057,65,2184,80,81,2048,68,2123,4,81,1,136]

theorem envBound7962 : H12AffineFastState.Bounded env7962 := by
  intro p hp
  have h : env7962.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7958_7962 : H12AffineEnvironment.transform 4 1 env7958 = env7962 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env7958 == env7962) = true)

theorem identity7962 : scanCanonicalize (H12AffineFastState.compose env7962 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound7962 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7963 : List Nat := [2,4,8,16,1,64,9,4,0,69,2048,0,2057,80,2048,2051,0,2048,2143,2048,1,1,17,3,2057,65,2049,80,81,2048,68,2123,4,81,1,1]

theorem envBound7963 : H12AffineFastState.Bounded env7963 := by
  intro p hp
  have h : env7963.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7962_7963 : H12AffineEnvironment.transform 6 9 env7962 = env7963 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env7962 == env7963) = true)

theorem identity7963 : scanCanonicalize (H12AffineFastState.compose env7963 (packedSelected [1,3] rootPS)) = affineNative (2^(10+1) ^^^ 74) := by decide +kernel

theorem selectedBound7963 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7964 : List Nat := [2,4,8,16,1,64,9,4,0,69,74,0,67,80,74,73,0,74,21,74,1,1,17,3,67,65,75,80,81,74,68,1,4,81,1,1]

theorem envBound7964 : H12AffineFastState.Bounded env7964 := by
  intro p hp
  have h : env7964.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7963_7964 : H12AffineEnvironment.transform 10 74 env7963 = env7964 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 74 env7963 == env7964) = true)

theorem identity7964 : scanCanonicalize (H12AffineFastState.compose env7964 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound7964 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7965 : List Nat := [2,4,8,16,1,17,9,4,0,20,27,0,18,1,27,24,0,27,21,27,1,1,17,3,18,16,26,1,0,27,21,1,4,0,1,1]

theorem envBound7965 : H12AffineFastState.Bounded env7965 := by
  intro p hp
  have h : env7965.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7964_7965 : H12AffineEnvironment.transform 5 17 env7964 = env7965 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7964 == env7965) = true)

def leafEnv7965 : List Nat := [2,4,8,16,1,17,9,4,0,20,27,0,18,1,27,24,0,27,21,27,1,1,17,3,21,18,1,16,26,1,0,27,21,1,4,0,5,24,1,1,0,0,1]

def active7965 : List Nat := [0,1,2,3]

def tree7965 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7965 : H12WitnessSearch.Good tree7965 := H12GlobalWitnessIndex.good

theorem leafIdentity7965 : H12AffineFastState.composeSystem env7965 rootObs = leafEnv7965 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7965 rootObs == leafEnv7965) = true)

theorem terminalChecked7965 : H12PackedTerminal.terminalCheckFast leafEnv7965 active7965 tree7965 = true := by decide +kernel

def env7966 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,524288,32768,4097,4194304,5456,16777216,8329,5376,21331968,4176,4176,4294795,16876545,4294967296,256,4316464298,4096,513]

theorem envBound7966 : H12AffineFastState.Bounded env7966 := by
  intro p hp
  have h : env7966.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7867_7966 : H12AffineEnvironment.transform 16 4097 env7867 = env7966 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env7867 == env7966) = true)

def env7967 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1344,8192,1296,32768,65536,1345,262144,524288,32768,1345,4194304,16,16777216,8329,64,21331968,1296,1296,4294795,16876545,4294967296,256,4316464298,1344,513]

theorem envBound7967 : H12AffineFastState.Bounded env7967 := by
  intro p hp
  have h : env7967.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7966_7967 : H12AffineEnvironment.transform 11 1344 env7966 = env7967 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1344 env7966 == env7967) = true)

theorem identity7967 : scanCanonicalize (H12AffineFastState.compose env7967 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound7967 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env7968 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1344,8192,1296,32768,65536,1345,262144,524288,32768,1345,4194304,16,16777216,8329,64,21331968,1296,1296,4294795,16876545,4294967296,256,4316464298,1344,136]

theorem envBound7968 : H12AffineFastState.Bounded env7968 := by
  intro p hp
  have h : env7968.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7967_7968 : H12AffineEnvironment.transform 8 137 env7967 = env7968 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env7967 == env7968) = true)

theorem identity7968 : scanCanonicalize (H12AffineFastState.compose env7968 (packedSelected [4,16,22] rootPS)) = affineNative (2^(23+1) ^^^ 98564) := by decide +kernel

theorem selectedBound7968 : packedSelected [4,16,22] rootPS < 2^1333 := by decide +kernel

def env7969 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1344,8192,1296,32768,65536,1345,262144,524288,32768,1345,4194304,16,98564,8329,64,4456708,1296,1296,4294795,1285,4294967296,256,4299785646,1344,136]

theorem envBound7969 : H12AffineFastState.Bounded env7969 := by
  intro p hp
  have h : env7969.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7968_7969 : H12AffineEnvironment.transform 23 98564 env7968 = env7969 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98564 env7968 == env7969) = true)

def env7970 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1344,8192,1296,32768,65536,1345,262144,524288,32768,1345,41088,16,98564,8329,64,303492,1296,1296,75787,1285,4294967296,256,4295566638,1344,136]

theorem envBound7970 : H12AffineFastState.Bounded env7970 := by
  intro p hp
  have h : env7970.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7969_7970 : H12AffineEnvironment.transform 21 41088 env7969 = env7970 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 41088 env7969 == env7970) = true)

theorem identity7970 : scanCanonicalize (H12AffineFastState.compose env7970 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 304555) := by decide +kernel

theorem selectedBound7970 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7971 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1344,8192,1296,32768,65536,1345,262144,524288,32768,1345,41088,16,98564,8329,64,303492,1296,1296,75787,1285,304555,256,884869,1344,136]

theorem envBound7971 : H12AffineFastState.Bounded env7971 := by
  intro p hp
  have h : env7971.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7970_7971 : H12AffineEnvironment.transform 31 304555 env7970 = env7971 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 304555 env7970 == env7971) = true)

theorem identity7971 : scanCanonicalize (H12AffineFastState.compose env7971 (packedSelected [3,5,10] rootPS)) = affineNative (2^(17+1) ^^^ 42238) := by decide +kernel

theorem selectedBound7971 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env7972 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1344,8192,1296,32768,65536,1345,42238,524288,32768,1345,41088,16,98564,8329,64,1402,1296,1296,75787,1285,341,256,599163,1344,136]

theorem envBound7972 : H12AffineFastState.Bounded env7972 := by
  intro p hp
  have h : env7972.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7971_7972 : H12AffineEnvironment.transform 17 42238 env7971 = env7972 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 42238 env7971 == env7972) = true)

def env7973 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1344,8192,1296,8580,65536,1345,1402,524288,8580,1345,260,16,73856,8329,64,1402,1296,1296,75787,1285,341,256,599163,1344,136]

theorem envBound7973 : H12AffineFastState.Bounded env7973 := by
  intro p hp
  have h : env7973.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7972_7973 : H12AffineEnvironment.transform 14 8580 env7972 = env7973 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8580 env7972 == env7973) = true)

theorem identity7973 : scanCanonicalize (H12AffineFastState.compose env7973 (packedSelected [7] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound7973 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env7974 : List Nat := [2,4,8,16,32,64,128,5,137,1024,2048,1093,8192,1045,8321,65536,1092,1151,524288,8321,1092,1,16,73856,8329,64,1151,1045,1045,75787,1024,80,5,599163,1093,136]

theorem envBound7974 : H12AffineFastState.Bounded env7974 := by
  intro p hp
  have h : env7974.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7973_7974 : H12AffineEnvironment.transform 7 5 env7973 = env7974 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env7973 == env7974) = true)

theorem identity7974 : scanCanonicalize (H12AffineFastState.compose env7974 (packedSelected [1,12,13] rootPS)) = affineNative (2^(18+1) ^^^ 1024) := by decide +kernel

theorem selectedBound7974 : packedSelected [1,12,13] rootPS < 2^1333 := by decide +kernel

def env7975 : List Nat := [2,4,8,16,32,64,128,5,137,1024,2048,1093,8192,1045,8321,65536,1092,1151,1024,8321,1092,1,16,73856,8329,64,1151,1045,1045,75787,1024,80,5,73851,1093,136]

theorem envBound7975 : H12AffineFastState.Bounded env7975 := by
  intro p hp
  have h : env7975.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7974_7975 : H12AffineEnvironment.transform 18 1024 env7974 = env7975 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env7974 == env7975) = true)

theorem identity7975 : scanCanonicalize (H12AffineFastState.compose env7975 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 8314) := by decide +kernel

theorem selectedBound7975 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env7976 : List Nat := [2,4,8,16,32,64,128,5,137,1024,2048,1093,8192,1045,8321,8314,1092,1151,1024,8321,1092,1,16,250,8329,64,1151,1045,1045,2161,1024,80,5,1,1093,136]

theorem envBound7976 : H12AffineFastState.Bounded env7976 := by
  intro p hp
  have h : env7976.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7975_7976 : H12AffineEnvironment.transform 15 8314 env7975 = env7976 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8314 env7975 == env7976) = true)

theorem identity7976 : scanCanonicalize (H12AffineFastState.compose env7976 (packedSelected [2,23,32] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound7976 : packedSelected [2,23,32] rootPS < 2^1333 := by decide +kernel

def env7977 : List Nat := [2,4,8,16,32,64,9,5,0,1024,2048,1093,8192,1045,8200,8314,1092,1151,1024,8200,1092,1,16,115,8192,64,1151,1045,1045,2161,1024,80,5,1,1093,1]

theorem envBound7977 : H12AffineFastState.Bounded env7977 := by
  intro p hp
  have h : env7977.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7976_7977 : H12AffineEnvironment.transform 6 9 env7976 = env7977 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env7976 == env7977) = true)

theorem identity7977 : scanCanonicalize (H12AffineFastState.compose env7977 (packedSelected [1,8,12] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound7977 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env7978 : List Nat := [2,4,8,16,32,17,9,5,0,1024,2048,1044,8192,1045,8200,8235,1045,1070,1024,8200,1045,1,16,34,8192,17,1070,1045,1045,2080,1024,1,5,1,1044,1]

theorem envBound7978 : H12AffineFastState.Bounded env7978 := by
  intro p hp
  have h : env7978.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7977_7978 : H12AffineEnvironment.transform 5 17 env7977 = env7978 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7977 == env7978) = true)

theorem identity7978 : scanCanonicalize (H12AffineFastState.compose env7978 (packedSelected [1,3,5] rootPS)) = affineNative (2^(10+1) ^^^ 1071) := by decide +kernel

theorem selectedBound7978 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env7979 : List Nat := [2,4,8,16,32,17,9,5,0,1024,1071,1044,8192,1045,8200,8235,1045,1070,1024,8200,1045,1,16,34,8192,17,1070,1045,1045,1039,1024,1,5,1,1044,1]

theorem envBound7979 : H12AffineFastState.Bounded env7979 := by
  intro p hp
  have h : env7979.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7978_7979 : H12AffineEnvironment.transform 10 1071 env7978 = env7979 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1071 env7978 == env7979) = true)

def env7980 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1344,8192,1296,8581,65536,1345,1403,524288,8581,1345,261,16,73857,8329,64,1402,1296,1296,75787,1285,341,256,599163,1344,136]

theorem envBound7980 : H12AffineFastState.Bounded env7980 := by
  intro p hp
  have h : env7980.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7972_7980 : H12AffineEnvironment.transform 14 8581 env7972 = env7980 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8581 env7972 == env7980) = true)

theorem identity7980 : scanCanonicalize (H12AffineFastState.compose env7980 (packedSelected [7] rootPS)) = affineNative (2^(12+1) ^^^ 1394) := by decide +kernel

theorem selectedBound7980 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env7981 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1344,1394,1296,1271,65536,1345,1403,524288,1271,1345,261,16,67059,1531,64,1402,1296,1296,68985,1285,341,256,590089,1344,136]

theorem envBound7981 : H12AffineFastState.Bounded env7981 := by
  intro p hp
  have h : env7981.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7980_7981 : H12AffineEnvironment.transform 12 1394 env7980 = env7981 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1394 env7980 == env7981) = true)

def env7982 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1344,1394,1296,1271,65536,1345,1403,524288,1271,1345,261,16,67059,1531,64,1402,1296,1296,66937,1285,341,256,590089,1344,136]

theorem envBound7982 : H12AffineFastState.Bounded env7982 := by
  intro p hp
  have h : env7982.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7981_7982 : H12AffineEnvironment.transform 10 0 env7981 = env7982 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env7981 == env7982) = true)

theorem identity7982 : scanCanonicalize (H12AffineFastState.compose env7982 (packedSelected [0] rootPS)) = affineNative (2^(15+1) ^^^ 171) := by decide +kernel

theorem selectedBound7982 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7983 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1344,1394,1296,1271,171,1345,1403,524288,1271,1345,261,16,1368,1531,64,1402,1296,1296,1490,1285,341,256,524706,1344,136]

theorem envBound7983 : H12AffineFastState.Bounded env7983 := by
  intro p hp
  have h : env7983.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7982_7983 : H12AffineEnvironment.transform 15 171 env7982 = env7983 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 171 env7982 == env7983) = true)

theorem identity7983 : scanCanonicalize (H12AffineFastState.compose env7983 (packedSelected [2,4] rootPS)) = affineNative (2^(9+1) ^^^ 214) := by decide +kernel

theorem selectedBound7983 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env7984 : List Nat := [2,4,8,16,32,64,128,256,137,214,0,406,420,454,33,171,407,429,524288,33,407,261,16,398,301,64,428,454,454,260,467,341,256,524706,406,136]

theorem envBound7984 : H12AffineFastState.Bounded env7984 := by
  intro p hp
  have h : env7984.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7983_7984 : H12AffineEnvironment.transform 9 214 env7983 = env7984 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 214 env7983 == env7984) = true)

theorem identity7984 : scanCanonicalize (H12AffineFastState.compose env7984 (packedSelected [2,9,11] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound7984 : packedSelected [2,9,11] rootPS < 2^1333 := by decide +kernel

def env7985 : List Nat := [2,4,8,16,32,64,128,4,137,214,0,146,160,194,33,171,147,169,524288,33,147,1,16,138,41,64,168,194,194,0,215,81,4,524454,146,136]

theorem envBound7985 : H12AffineFastState.Bounded env7985 := by
  intro p hp
  have h : env7985.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7984_7985 : H12AffineEnvironment.transform 7 4 env7984 = env7985 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env7984 == env7985) = true)

def env7986 : List Nat := [2,4,8,16,0,64,128,4,137,214,0,146,128,194,1,139,147,137,524288,1,147,1,16,138,9,64,136,194,194,0,215,81,4,524422,146,136]

theorem envBound7986 : H12AffineFastState.Bounded env7986 := by
  intro p hp
  have h : env7986.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7985_7986 : H12AffineEnvironment.transform 4 0 env7985 = env7986 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env7985 == env7986) = true)

theorem identity7986 : scanCanonicalize (H12AffineFastState.compose env7986 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound7986 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7987 : List Nat := [2,4,8,16,0,64,9,4,0,95,0,27,9,75,1,2,26,0,524288,1,26,1,16,3,9,64,1,75,75,0,94,81,4,524303,27,1]

theorem envBound7987 : H12AffineFastState.Bounded env7987 := by
  intro p hp
  have h : env7987.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7986_7987 : H12AffineEnvironment.transform 6 9 env7986 = env7987 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env7986 == env7987) = true)

theorem identity7987 : scanCanonicalize (H12AffineFastState.compose env7987 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound7987 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env7988 : List Nat := [2,4,8,16,0,16,9,4,0,15,0,27,9,27,1,2,26,0,524288,1,26,1,16,3,9,16,1,27,27,0,14,1,4,524303,27,1]

theorem envBound7988 : H12AffineFastState.Bounded env7988 := by
  intro p hp
  have h : env7988.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7987_7988 : H12AffineEnvironment.transform 5 16 env7987 = env7988 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7987 == env7988) = true)

def leafEnv7988 : List Nat := [2,4,8,16,0,16,9,4,0,15,0,27,9,27,1,2,26,0,524288,1,26,1,16,3,524288,9,1,16,1,27,27,0,14,1,4,524303,5,2,27,1,0,27,1]

def active7988 : List Nat := [0,1,2,3,18]

def tree7988 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7988 : H12WitnessSearch.Good tree7988 := H12GlobalWitnessIndex.good

theorem leafIdentity7988 : H12AffineFastState.composeSystem env7988 rootObs = leafEnv7988 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7988 rootObs == leafEnv7988) = true)

theorem terminalChecked7988 : H12PackedTerminal.terminalCheckFast leafEnv7988 active7988 tree7988 = true := by decide +kernel

def env7989 : List Nat := [2,4,8,16,1,64,128,4,137,214,0,146,129,194,0,138,147,136,524288,0,147,1,16,138,8,64,137,194,194,0,215,81,4,524423,146,136]

theorem envBound7989 : H12AffineFastState.Bounded env7989 := by
  intro p hp
  have h : env7989.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7985_7989 : H12AffineEnvironment.transform 4 1 env7985 = env7989 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env7985 == env7989) = true)

theorem identity7989 : scanCanonicalize (H12AffineFastState.compose env7989 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound7989 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7990 : List Nat := [2,4,8,16,1,64,88,4,81,14,0,74,89,26,0,82,75,80,524288,0,75,1,16,82,8,64,81,26,26,0,15,81,4,524383,74,80]

theorem envBound7990 : H12AffineFastState.Bounded env7990 := by
  intro p hp
  have h : env7990.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7989_7990 : H12AffineEnvironment.transform 6 88 env7989 = env7990 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env7989 == env7990) = true)

def env7991 : List Nat := [2,4,8,16,1,16,8,4,1,14,0,26,9,26,0,2,27,0,524288,0,27,1,16,2,8,16,1,26,26,0,15,1,4,524303,26,0]

theorem envBound7991 : H12AffineFastState.Bounded env7991 := by
  intro p hp
  have h : env7991.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7990_7991 : H12AffineEnvironment.transform 5 16 env7990 = env7991 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7990 == env7991) = true)

theorem identity7991 : scanCanonicalize (H12AffineFastState.compose env7991 (packedSelected [3] rootPS)) = affineNative (2^(18+1) ^^^ 15) := by decide +kernel

theorem selectedBound7991 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env7992 : List Nat := [2,4,8,16,1,16,8,4,1,14,0,26,9,26,0,2,27,0,15,0,27,1,16,2,8,16,1,26,26,0,15,1,4,0,26,0]

theorem envBound7992 : H12AffineFastState.Bounded env7992 := by
  intro p hp
  have h : env7992.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7991_7992 : H12AffineEnvironment.transform 18 15 env7991 = env7992 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 15 env7991 == env7992) = true)

def leafEnv7992 : List Nat := [2,4,8,16,1,16,8,4,1,14,0,26,9,26,0,2,27,0,15,0,27,1,16,2,15,8,1,16,1,26,26,0,15,1,4,0,5,3,26,0,0,26,1]

def active7992 : List Nat := [0,1,2,3]

def tree7992 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7992 : H12WitnessSearch.Good tree7992 := H12GlobalWitnessIndex.good

theorem leafIdentity7992 : H12AffineFastState.composeSystem env7992 rootObs = leafEnv7992 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7992 rootObs == leafEnv7992) = true)

theorem terminalChecked7992 : H12PackedTerminal.terminalCheckFast leafEnv7992 active7992 tree7992 = true := by decide +kernel

def env7993 : List Nat := [2,4,8,16,1,17,9,4,0,14,0,27,8,26,0,3,26,1,524288,0,26,1,16,3,8,17,0,26,26,0,15,0,4,524302,27,1]

theorem envBound7993 : H12AffineFastState.Bounded env7993 := by
  intro p hp
  have h : env7993.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7990_7993 : H12AffineEnvironment.transform 5 17 env7990 = env7993 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7990 == env7993) = true)

def leafEnv7993 : List Nat := [2,4,8,16,1,17,9,4,0,14,0,27,8,26,0,3,26,1,524288,0,26,1,16,3,524288,8,1,17,0,26,26,0,15,0,4,524302,5,3,27,1,0,26,1]

def active7993 : List Nat := [0,1,2,3,18]

def tree7993 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7993 : H12WitnessSearch.Good tree7993 := H12GlobalWitnessIndex.good

theorem leafIdentity7993 : H12AffineFastState.composeSystem env7993 rootObs = leafEnv7993 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7993 rootObs == leafEnv7993) = true)

theorem terminalChecked7993 : H12PackedTerminal.terminalCheckFast leafEnv7993 active7993 tree7993 = true := by decide +kernel

def env7994 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1344,1394,1296,1271,65536,1345,1403,524288,1271,1345,261,16,67059,1531,64,1402,1296,1296,66936,1285,341,256,590089,1344,136]

theorem envBound7994 : H12AffineFastState.Bounded env7994 := by
  intro p hp
  have h : env7994.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7981_7994 : H12AffineEnvironment.transform 10 1 env7981 = env7994 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env7981 == env7994) = true)

theorem identity7994 : scanCanonicalize (H12AffineFastState.compose env7994 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 467) := by decide +kernel

theorem selectedBound7994 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7995 : List Nat := [2,4,8,16,32,64,128,256,137,467,1,147,161,195,292,65536,146,168,524288,292,146,261,16,65568,40,64,169,195,195,65707,214,341,256,590089,147,136]

theorem envBound7995 : H12AffineFastState.Bounded env7995 := by
  intro p hp
  have h : env7995.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7994_7995 : H12AffineEnvironment.transform 9 467 env7994 = env7995 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 467 env7994 == env7995) = true)

theorem identity7995 : scanCanonicalize (H12AffineFastState.compose env7995 (packedSelected [11,18] rootPS)) = affineNative (2^(15+1) ^^^ 430) := by decide +kernel

theorem selectedBound7995 : packedSelected [11,18] rootPS < 2^1333 := by decide +kernel

def env7996 : List Nat := [2,4,8,16,32,64,128,256,137,467,1,147,161,195,292,430,146,168,524288,292,146,261,16,398,40,64,169,195,195,261,214,341,256,524455,147,136]

theorem envBound7996 : H12AffineFastState.Bounded env7996 := by
  intro p hp
  have h : env7996.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7995_7996 : H12AffineEnvironment.transform 15 430 env7995 = env7996 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 430 env7995 == env7996) = true)

theorem identity7996 : scanCanonicalize (H12AffineFastState.compose env7996 (packedSelected [2,4,11] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound7996 : packedSelected [2,4,11] rootPS < 2^1333 := by decide +kernel

def env7997 : List Nat := [2,4,8,16,32,64,128,4,137,215,1,147,161,195,32,170,146,168,524288,32,146,1,16,138,40,64,169,195,195,1,214,81,4,524455,147,136]

theorem envBound7997 : H12AffineFastState.Bounded env7997 := by
  intro p hp
  have h : env7997.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7996_7997 : H12AffineEnvironment.transform 7 4 env7996 = env7997 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env7996 == env7997) = true)

def env7998 : List Nat := [2,4,8,16,0,64,128,4,137,215,1,147,129,195,0,138,146,136,524288,0,146,1,16,138,8,64,137,195,195,1,214,81,4,524423,147,136]

theorem envBound7998 : H12AffineFastState.Bounded env7998 := by
  intro p hp
  have h : env7998.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7997_7998 : H12AffineEnvironment.transform 4 0 env7997 = env7998 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env7997 == env7998) = true)

theorem identity7998 : scanCanonicalize (H12AffineFastState.compose env7998 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound7998 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7999 : List Nat := [2,4,8,16,0,64,9,4,0,94,1,26,8,74,0,3,27,1,524288,0,27,1,16,3,8,64,0,74,74,1,95,81,4,524302,26,1]

theorem envBound7999 : H12AffineFastState.Bounded env7999 := by
  intro p hp
  have h : env7999.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7998_7999 : H12AffineEnvironment.transform 6 9 env7998 = env7999 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env7998 == env7999) = true)

theorem identity7999 : scanCanonicalize (H12AffineFastState.compose env7999 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound7999 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env8000 : List Nat := [2,4,8,16,0,16,9,4,0,14,1,26,8,26,0,3,27,1,524288,0,27,1,16,3,8,16,0,26,26,1,15,1,4,524302,26,1]

theorem envBound8000 : H12AffineFastState.Bounded env8000 := by
  intro p hp
  have h : env8000.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7999_8000 : H12AffineEnvironment.transform 5 16 env7999 = env8000 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7999 == env8000) = true)

def leafEnv8000 : List Nat := [2,4,8,16,0,16,9,4,0,14,1,26,8,26,0,3,27,1,524288,0,27,1,16,3,524288,8,1,16,0,26,26,1,15,1,4,524302,5,3,26,1,0,26,1]

def active8000 : List Nat := [0,1,2,3,18]

def tree8000 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood8000 : H12WitnessSearch.Good tree8000 := H12GlobalWitnessIndex.good

theorem leafIdentity8000 : H12AffineFastState.composeSystem env8000 rootObs = leafEnv8000 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env8000 rootObs == leafEnv8000) = true)

theorem terminalChecked8000 : H12PackedTerminal.terminalCheckFast leafEnv8000 active8000 tree8000 = true := by decide +kernel

def env8001 : List Nat := [2,4,8,16,1,64,128,4,137,215,1,147,128,195,1,139,146,137,524288,1,146,1,16,138,9,64,136,195,195,1,214,81,4,524422,147,136]

theorem envBound8001 : H12AffineFastState.Bounded env8001 := by
  intro p hp
  have h : env8001.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7997_8001 : H12AffineEnvironment.transform 4 1 env7997 = env8001 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env7997 == env8001) = true)

theorem identity8001 : scanCanonicalize (H12AffineFastState.compose env8001 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound8001 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env8002 : List Nat := [2,4,8,16,1,64,88,4,81,15,1,75,88,27,1,83,74,81,524288,1,74,1,16,82,9,64,80,27,27,1,14,81,4,524382,75,80]

theorem envBound8002 : H12AffineFastState.Bounded env8002 := by
  intro p hp
  have h : env8002.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8001_8002 : H12AffineEnvironment.transform 6 88 env8001 = env8002 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env8001 == env8002) = true)

def env8003 : List Nat := [2,4,8,16,1,16,8,4,1,15,1,27,8,27,1,3,26,1,524288,1,26,1,16,2,9,16,0,27,27,1,14,1,4,524302,27,0]

theorem envBound8003 : H12AffineFastState.Bounded env8003 := by
  intro p hp
  have h : env8003.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8002_8003 : H12AffineEnvironment.transform 5 16 env8002 = env8003 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env8002 == env8003) = true)

theorem identity8003 : scanCanonicalize (H12AffineFastState.compose env8003 (packedSelected [3] rootPS)) = affineNative (2^(18+1) ^^^ 14) := by decide +kernel

theorem selectedBound8003 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env8004 : List Nat := [2,4,8,16,1,16,8,4,1,15,1,27,8,27,1,3,26,1,14,1,26,1,16,2,9,16,0,27,27,1,14,1,4,0,27,0]

theorem envBound8004 : H12AffineFastState.Bounded env8004 := by
  intro p hp
  have h : env8004.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8003_8004 : H12AffineEnvironment.transform 18 14 env8003 = env8004 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 14 env8003 == env8004) = true)

def leafEnv8004 : List Nat := [2,4,8,16,1,16,8,4,1,15,1,27,8,27,1,3,26,1,14,1,26,1,16,2,14,9,1,16,0,27,27,1,14,1,4,0,5,2,27,0,0,27,1]

def active8004 : List Nat := [0,1,2,3]

def tree8004 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood8004 : H12WitnessSearch.Good tree8004 := H12GlobalWitnessIndex.good

theorem leafIdentity8004 : H12AffineFastState.composeSystem env8004 rootObs = leafEnv8004 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env8004 rootObs == leafEnv8004) = true)

theorem terminalChecked8004 : H12PackedTerminal.terminalCheckFast leafEnv8004 active8004 tree8004 = true := by decide +kernel

def env8005 : List Nat := [2,4,8,16,1,17,9,4,0,15,1,26,9,27,1,2,27,0,524288,1,27,1,16,3,9,17,1,27,27,1,14,0,4,524303,26,1]

theorem envBound8005 : H12AffineFastState.Bounded env8005 := by
  intro p hp
  have h : env8005.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8002_8005 : H12AffineEnvironment.transform 5 17 env8002 = env8005 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env8002 == env8005) = true)

def leafEnv8005 : List Nat := [2,4,8,16,1,17,9,4,0,15,1,26,9,27,1,2,27,0,524288,1,27,1,16,3,524288,9,1,17,1,27,27,1,14,0,4,524303,5,2,26,1,0,27,1]

def active8005 : List Nat := [0,1,2,3,18]

def tree8005 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood8005 : H12WitnessSearch.Good tree8005 := H12GlobalWitnessIndex.good

theorem leafIdentity8005 : H12AffineFastState.composeSystem env8005 rootObs = leafEnv8005 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env8005 rootObs == leafEnv8005) = true)

theorem terminalChecked8005 : H12PackedTerminal.terminalCheckFast leafEnv8005 active8005 tree8005 = true := by decide +kernel

def env8006 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1344,8192,1296,32768,65536,1345,262144,524288,32768,1345,41089,16,98564,8329,64,303493,1296,1296,75786,1285,4294967296,256,4295566639,1344,136]

theorem envBound8006 : H12AffineFastState.Bounded env8006 := by
  intro p hp
  have h : env8006.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7969_8006 : H12AffineEnvironment.transform 21 41089 env7969 = env8006 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 41089 env7969 == env8006) = true)

theorem identity8006 : scanCanonicalize (H12AffineFastState.compose env8006 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 263335) := by decide +kernel

theorem selectedBound8006 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env8007 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1344,8192,1296,32768,65536,1345,262144,524288,32768,1345,41089,16,98564,8329,64,303493,1296,1296,75786,1285,263335,256,860552,1344,136]

theorem envBound8007 : H12AffineFastState.Bounded env8007 := by
  intro p hp
  have h : env8007.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8006_8007 : H12AffineEnvironment.transform 31 263335 env8006 = env8007 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 263335 env8006 == env8007) = true)

theorem identity8007 : scanCanonicalize (H12AffineFastState.compose env8007 (packedSelected [3,5,10] rootPS)) = affineNative (2^(18+1) ^^^ 262642) := by decide +kernel

theorem selectedBound8007 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env8008 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1344,8192,1296,32768,65536,1345,262144,262642,32768,1345,41089,16,98564,8329,64,303493,1296,1296,75786,1285,263335,256,73850,1344,136]

theorem envBound8008 : H12AffineFastState.Bounded env8008 := by
  intro p hp
  have h : env8008.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8007_8008 : H12AffineEnvironment.transform 18 262642 env8007 = env8008 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 262642 env8007 == env8008) = true)

def env8009 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1344,8192,1296,32768,65536,1345,32904,33146,32768,1345,41089,16,98564,8329,64,8461,1296,1296,75786,1285,33839,256,73850,1344,136]

theorem envBound8009 : H12AffineFastState.Bounded env8009 := by
  intro p hp
  have h : env8009.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8008_8009 : H12AffineEnvironment.transform 17 32904 env8008 = env8009 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 32904 env8008 == env8009) = true)

theorem identity8009 : scanCanonicalize (H12AffineFastState.compose env8009 (packedSelected [7] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound8009 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env8010 : List Nat := [2,4,8,16,32,64,128,5,137,1024,2048,1093,8192,1045,32768,65536,1092,32904,32895,32768,1092,41089,16,98305,8329,64,8200,1045,1045,75786,1024,33839,5,73850,1093,136]

theorem envBound8010 : H12AffineFastState.Bounded env8010 := by
  intro p hp
  have h : env8010.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8009_8010 : H12AffineEnvironment.transform 7 5 env8009 = env8010 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env8009 == env8010) = true)

theorem identity8010 : scanCanonicalize (H12AffineFastState.compose env8010 (packedSelected [1,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 1151) := by decide +kernel

theorem selectedBound8010 : packedSelected [1,12,13] rootPS < 2^1333 := by decide +kernel

def env8011 : List Nat := [2,4,8,16,32,64,128,5,137,1024,2048,1093,8192,1045,1151,65536,1092,1271,1024,1151,1092,9470,16,66686,8329,64,8200,1045,1045,75786,1024,80,5,73850,1093,136]

theorem envBound8011 : H12AffineFastState.Bounded env8011 := by
  intro p hp
  have h : env8011.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8010_8011 : H12AffineEnvironment.transform 14 1151 env8010 = env8011 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 1151 env8010 == env8011) = true)

theorem identity8011 : scanCanonicalize (H12AffineFastState.compose env8011 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 8315) := by decide +kernel

theorem selectedBound8011 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env8012 : List Nat := [2,4,8,16,32,64,128,5,137,1024,2048,1093,8192,1045,1151,8315,1092,1271,1024,1151,1092,9470,16,9221,8329,64,8200,1045,1045,2161,1024,80,5,1,1093,136]

theorem envBound8012 : H12AffineFastState.Bounded env8012 := by
  intro p hp
  have h : env8012.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8011_8012 : H12AffineEnvironment.transform 15 8315 env8011 = env8012 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8315 env8011 == env8012) = true)

theorem identity8012 : scanCanonicalize (H12AffineFastState.compose env8012 (packedSelected [2,23,32] rootPS)) = affineNative (2^(12+1) ^^^ 1142) := by decide +kernel

theorem selectedBound8012 : packedSelected [2,23,32] rootPS < 2^1333 := by decide +kernel

def env8013 : List Nat := [2,4,8,16,32,64,128,5,137,1024,2048,1093,1142,1045,1151,1037,1092,1271,1024,1151,1092,136,16,115,1279,64,1150,1045,1045,2161,1024,80,5,1,1093,136]

theorem envBound8013 : H12AffineFastState.Bounded env8013 := by
  intro p hp
  have h : env8013.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8012_8013 : H12AffineEnvironment.transform 12 1142 env8012 = env8013 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1142 env8012 == env8013) = true)

theorem identity8013 : scanCanonicalize (H12AffineFastState.compose env8013 (packedSelected [1,8,12] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound8013 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env8014 : List Nat := [2,4,8,16,32,17,128,5,137,1024,2048,1044,1063,1045,1070,1037,1045,1190,1024,1070,1045,136,16,34,1198,17,1071,1045,1045,2080,1024,1,5,1,1044,136]

theorem envBound8014 : H12AffineFastState.Bounded env8014 := by
  intro p hp
  have h : env8014.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8013_8014 : H12AffineEnvironment.transform 5 17 env8013 = env8014 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env8013 == env8014) = true)

theorem identity8014 : scanCanonicalize (H12AffineFastState.compose env8014 (packedSelected [1,3,5] rootPS)) = affineNative (2^(10+1) ^^^ 1071) := by decide +kernel

theorem selectedBound8014 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env8015 : List Nat := [2,4,8,16,32,17,128,5,137,1024,1071,1044,1063,1045,1070,1037,1045,1190,1024,1070,1045,136,16,34,1198,17,1071,1045,1045,1039,1024,1,5,1,1044,136]

theorem envBound8015 : H12AffineFastState.Bounded env8015 := by
  intro p hp
  have h : env8015.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8014_8015 : H12AffineEnvironment.transform 10 1071 env8014 = env8015 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1071 env8014 == env8015) = true)

theorem identity8015 : scanCanonicalize (H12AffineFastState.compose env8015 (packedSelected [0,2] rootPS)) = affineNative (2^(6+1) ^^^ 40) := by decide +kernel

theorem selectedBound8015 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env8016 : List Nat := [2,4,8,16,32,17,40,5,33,1024,1071,1044,1063,1045,1070,1037,1045,1038,1024,1070,1045,32,16,34,1030,17,1071,1045,1045,1039,1024,1,5,1,1044,32]

theorem envBound8016 : H12AffineFastState.Bounded env8016 := by
  intro p hp
  have h : env8016.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8015_8016 : H12AffineEnvironment.transform 6 40 env8015 = env8016 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 40 env8015 == env8016) = true)

def env8017 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1344,8192,1296,32768,65536,1345,32905,33147,32768,1345,41089,16,98564,8329,64,8460,1296,1296,75786,1285,33838,256,73850,1344,136]

theorem envBound8017 : H12AffineFastState.Bounded env8017 := by
  intro p hp
  have h : env8017.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8008_8017 : H12AffineEnvironment.transform 17 32905 env8008 = env8017 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 32905 env8008 == env8017) = true)

theorem identity8017 : scanCanonicalize (H12AffineFastState.compose env8017 (packedSelected [7] rootPS)) = affineNative (2^(14+1) ^^^ 8320) := by decide +kernel

theorem selectedBound8017 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env8018 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1344,8192,1296,8320,65536,1345,8201,8699,8320,1345,1,16,74116,8329,64,8460,1296,1296,75786,1285,9390,256,73850,1344,136]

theorem envBound8018 : H12AffineFastState.Bounded env8018 := by
  intro p hp
  have h : env8018.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8017_8018 : H12AffineEnvironment.transform 14 8320 env8017 = env8018 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8320 env8017 == env8018) = true)

def env8019 : List Nat := [2,4,8,16,32,64,128,256,137,320,2048,0,8192,80,8320,65536,1,8201,8699,8320,1,1,16,74116,8329,64,8460,80,80,75786,69,8686,256,73850,0,136]

theorem envBound8019 : H12AffineFastState.Bounded env8019 := by
  intro p hp
  have h : env8019.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8018_8019 : H12AffineEnvironment.transform 9 320 env8018 = env8019 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 320 env8018 == env8019) = true)

theorem identity8019 : scanCanonicalize (H12AffineFastState.compose env8019 (packedSelected [12] rootPS)) = affineNative (2^(12+1) ^^^ 2469) := by decide +kernel

theorem selectedBound8019 : packedSelected [12] rootPS < 2^1333 := by decide +kernel

def env8020 : List Nat := [2,4,8,16,32,64,128,256,137,320,2048,0,2469,80,2341,65536,1,2476,2142,2341,1,1,16,67617,2348,64,2217,80,80,65967,69,2123,256,68063,0,136]

theorem envBound8020 : H12AffineFastState.Bounded env8020 := by
  intro p hp
  have h : env8020.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8019_8020 : H12AffineEnvironment.transform 12 2469 env8019 = env8020 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2469 env8019 == env8020) = true)

theorem identity8020 : scanCanonicalize (H12AffineFastState.compose env8020 (packedSelected [1,13,15] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound8020 : packedSelected [1,13,15] rootPS < 2^1333 := by decide +kernel

def env8021 : List Nat := [2,4,8,16,32,64,128,4,137,68,2048,0,2209,80,2081,65536,1,2216,2142,2081,1,1,16,67617,2088,64,2217,80,80,65707,69,2123,4,67803,0,136]

theorem envBound8021 : H12AffineFastState.Bounded env8021 := by
  intro p hp
  have h : env8021.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8020_8021 : H12AffineEnvironment.transform 7 4 env8020 = env8021 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env8020 == env8021) = true)

theorem identity8021 : scanCanonicalize (H12AffineFastState.compose env8021 (packedSelected [8] rootPS)) = affineNative (2^(15+1) ^^^ 2219) := by decide +kernel

theorem selectedBound8021 : packedSelected [8] rootPS < 2^1333 := by decide +kernel

def env8022 : List Nat := [2,4,8,16,32,64,128,4,137,68,2048,0,2209,80,2081,2219,1,2216,2142,2081,1,1,16,138,2088,64,2217,80,80,2048,69,2123,4,112,0,136]

theorem envBound8022 : H12AffineFastState.Bounded env8022 := by
  intro p hp
  have h : env8022.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8021_8022 : H12AffineEnvironment.transform 15 2219 env8021 = env8022 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2219 env8021 == env8022) = true)

def env8023 : List Nat := [2,4,8,16,0,64,128,4,137,68,2048,0,2177,80,2049,2187,1,2184,2142,2049,1,1,16,138,2056,64,2185,80,80,2048,69,2123,4,80,0,136]

theorem envBound8023 : H12AffineFastState.Bounded env8023 := by
  intro p hp
  have h : env8023.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8022_8023 : H12AffineEnvironment.transform 4 0 env8022 = env8023 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env8022 == env8023) = true)

theorem identity8023 : scanCanonicalize (H12AffineFastState.compose env8023 (packedSelected [2] rootPS)) = affineNative (2^(10+1) ^^^ 147) := by decide +kernel

theorem selectedBound8023 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env8024 : List Nat := [2,4,8,16,0,64,128,4,137,68,147,0,18,80,146,24,1,27,205,146,1,1,16,138,155,64,26,80,80,147,69,216,4,80,0,136]

theorem envBound8024 : H12AffineFastState.Bounded env8024 := by
  intro p hp
  have h : env8024.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8023_8024 : H12AffineEnvironment.transform 10 147 env8023 = env8024 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 147 env8023 == env8024) = true)

theorem identity8024 : scanCanonicalize (H12AffineFastState.compose env8024 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound8024 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env8025 : List Nat := [2,4,8,16,0,16,128,4,137,20,147,0,18,0,146,24,1,27,157,146,1,1,16,138,155,16,26,0,0,147,21,136,4,0,0,136]

theorem envBound8025 : H12AffineFastState.Bounded env8025 := by
  intro p hp
  have h : env8025.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8024_8025 : H12AffineEnvironment.transform 5 16 env8024 = env8025 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env8024 == env8025) = true)

def leafEnv8025 : List Nat := [2,4,8,16,0,16,128,4,137,20,147,0,18,0,146,24,1,27,157,146,1,1,16,138,157,155,1,16,26,0,0,147,21,136,4,0,5,145,0,136,0,0,1]

def active8025 : List Nat := [0,1,2,3,6]

def tree8025 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood8025 : H12WitnessSearch.Good tree8025 := H12GlobalWitnessIndex.good

theorem leafIdentity8025 : H12AffineFastState.composeSystem env8025 rootObs = leafEnv8025 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env8025 rootObs == leafEnv8025) = true)

theorem terminalChecked8025 : H12PackedTerminal.terminalCheckFast leafEnv8025 active8025 tree8025 = true := by decide +kernel

def env8026 : List Nat := [2,4,8,16,1,64,128,4,137,68,2048,0,2176,80,2048,2186,1,2185,2142,2048,1,1,16,138,2057,64,2184,80,80,2048,69,2123,4,81,0,136]

theorem envBound8026 : H12AffineFastState.Bounded env8026 := by
  intro p hp
  have h : env8026.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8022_8026 : H12AffineEnvironment.transform 4 1 env8022 = env8026 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env8022 == env8026) = true)

theorem identity8026 : scanCanonicalize (H12AffineFastState.compose env8026 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound8026 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env8027 : List Nat := [2,4,8,16,1,64,88,4,81,68,2048,0,2136,80,2048,2130,1,2129,2142,2048,1,1,16,82,2057,64,2128,80,80,2048,69,2123,4,81,0,80]

theorem envBound8027 : H12AffineFastState.Bounded env8027 := by
  intro p hp
  have h : env8027.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8026_8027 : H12AffineEnvironment.transform 6 88 env8026 = env8027 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env8026 == env8027) = true)

theorem identity8027 : scanCanonicalize (H12AffineFastState.compose env8027 (packedSelected [3] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound8027 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env8028 : List Nat := [2,4,8,16,1,17,9,4,0,21,2048,0,2057,1,2048,2051,1,2048,2063,2048,1,1,16,3,2057,17,2049,1,1,2048,20,2074,4,0,0,1]

theorem envBound8028 : H12AffineFastState.Bounded env8028 := by
  intro p hp
  have h : env8028.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8027_8028 : H12AffineEnvironment.transform 5 17 env8027 = env8028 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env8027 == env8028) = true)

theorem identity8028 : scanCanonicalize (H12AffineFastState.compose env8028 (packedSelected [1] rootPS)) = affineNative (2^(10+1) ^^^ 26) := by decide +kernel

theorem selectedBound8028 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env8029 : List Nat := [2,4,8,16,1,17,9,4,0,21,26,0,19,1,26,25,1,26,21,26,1,1,16,3,19,17,27,1,1,26,20,0,4,0,0,1]

theorem envBound8029 : H12AffineFastState.Bounded env8029 := by
  intro p hp
  have h : env8029.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8028_8029 : H12AffineEnvironment.transform 10 26 env8028 = env8029 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 26 env8028 == env8029) = true)

def leafEnv8029 : List Nat := [2,4,8,16,1,17,9,4,0,21,26,0,19,1,26,25,1,26,21,26,1,1,16,3,21,19,1,17,27,1,1,26,20,0,4,0,5,25,0,1,0,1,1]

def active8029 : List Nat := [0,1,2,3]

def tree8029 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood8029 : H12WitnessSearch.Good tree8029 := H12GlobalWitnessIndex.good

theorem leafIdentity8029 : H12AffineFastState.composeSystem env8029 rootObs = leafEnv8029 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env8029 rootObs == leafEnv8029) = true)

theorem terminalChecked8029 : H12PackedTerminal.terminalCheckFast leafEnv8029 active8029 tree8029 = true := by decide +kernel

def env8030 : List Nat := [2,4,8,16,32,64,128,256,137,321,2048,1,8192,81,8320,65536,0,8201,8699,8320,0,1,16,74116,8329,64,8460,81,81,75786,68,8687,256,73850,1,136]

theorem envBound8030 : H12AffineFastState.Bounded env8030 := by
  intro p hp
  have h : env8030.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8018_8030 : H12AffineEnvironment.transform 9 321 env8018 = env8030 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 321 env8018 == env8030) = true)

theorem identity8030 : scanCanonicalize (H12AffineFastState.compose env8030 (packedSelected [12] rootPS)) = affineNative (2^(15+1) ^^^ 8202) := by decide +kernel

theorem selectedBound8030 : packedSelected [12] rootPS < 2^1333 := by decide +kernel

def env8031 : List Nat := [2,4,8,16,32,64,128,256,137,321,2048,1,8192,81,8320,8202,0,8201,8699,8320,0,1,16,398,8329,64,8460,81,81,2048,68,8687,256,112,1,136]

theorem envBound8031 : H12AffineFastState.Bounded env8031 := by
  intro p hp
  have h : env8031.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8030_8031 : H12AffineEnvironment.transform 15 8202 env8030 = env8031 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8202 env8030 == env8031) = true)

theorem identity8031 : scanCanonicalize (H12AffineFastState.compose env8031 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound8031 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env8032 : List Nat := [2,4,8,16,32,64,128,4,137,69,2048,1,8192,81,8320,8202,0,8201,8447,8320,0,1,16,138,8329,64,8200,81,81,2048,68,8427,4,112,1,136]

theorem envBound8032 : H12AffineFastState.Bounded env8032 := by
  intro p hp
  have h : env8032.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8031_8032 : H12AffineEnvironment.transform 7 4 env8031 = env8032 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env8031 == env8032) = true)

theorem identity8032 : scanCanonicalize (H12AffineFastState.compose env8032 (packedSelected [0] rootPS)) = affineNative (2^(12+1) ^^^ 2209) := by decide +kernel

theorem selectedBound8032 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env8033 : List Nat := [2,4,8,16,32,64,128,4,137,69,2048,1,2209,81,2081,2219,0,2216,2142,2081,0,1,16,138,2088,64,2217,81,81,2048,68,2122,4,112,1,136]

theorem envBound8033 : H12AffineFastState.Bounded env8033 := by
  intro p hp
  have h : env8033.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8032_8033 : H12AffineEnvironment.transform 12 2209 env8032 = env8033 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2209 env8032 == env8033) = true)

def env8034 : List Nat := [2,4,8,16,0,64,128,4,137,69,2048,1,2177,81,2049,2187,0,2184,2142,2049,0,1,16,138,2056,64,2185,81,81,2048,68,2122,4,80,1,136]

theorem envBound8034 : H12AffineFastState.Bounded env8034 := by
  intro p hp
  have h : env8034.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8033_8034 : H12AffineEnvironment.transform 4 0 env8033 = env8034 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env8033 == env8034) = true)

theorem identity8034 : scanCanonicalize (H12AffineFastState.compose env8034 (packedSelected [2] rootPS)) = affineNative (2^(10+1) ^^^ 146) := by decide +kernel

theorem selectedBound8034 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env8035 : List Nat := [2,4,8,16,0,64,128,4,137,69,146,1,19,81,147,25,0,26,204,147,0,1,16,138,154,64,27,81,81,146,68,216,4,80,1,136]

theorem envBound8035 : H12AffineFastState.Bounded env8035 := by
  intro p hp
  have h : env8035.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8034_8035 : H12AffineEnvironment.transform 10 146 env8034 = env8035 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 146 env8034 == env8035) = true)

theorem identity8035 : scanCanonicalize (H12AffineFastState.compose env8035 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound8035 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env8036 : List Nat := [2,4,8,16,0,16,128,4,137,21,146,1,19,1,147,25,0,26,156,147,0,1,16,138,154,16,27,1,1,146,20,136,4,0,1,136]

theorem envBound8036 : H12AffineFastState.Bounded env8036 := by
  intro p hp
  have h : env8036.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8035_8036 : H12AffineEnvironment.transform 5 16 env8035 = env8036 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env8035 == env8036) = true)

def leafEnv8036 : List Nat := [2,4,8,16,0,16,128,4,137,21,146,1,19,1,147,25,0,26,156,147,0,1,16,138,156,154,1,16,27,1,1,146,20,136,4,0,5,144,1,136,0,1,1]

def active8036 : List Nat := [0,1,2,3,6]

def tree8036 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood8036 : H12WitnessSearch.Good tree8036 := H12GlobalWitnessIndex.good

theorem leafIdentity8036 : H12AffineFastState.composeSystem env8036 rootObs = leafEnv8036 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env8036 rootObs == leafEnv8036) = true)

theorem terminalChecked8036 : H12PackedTerminal.terminalCheckFast leafEnv8036 active8036 tree8036 = true := by decide +kernel

def env8037 : List Nat := [2,4,8,16,1,64,128,4,137,69,2048,1,2176,81,2048,2186,0,2185,2142,2048,0,1,16,138,2057,64,2184,81,81,2048,68,2122,4,81,1,136]

theorem envBound8037 : H12AffineFastState.Bounded env8037 := by
  intro p hp
  have h : env8037.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8033_8037 : H12AffineEnvironment.transform 4 1 env8033 = env8037 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env8033 == env8037) = true)

theorem identity8037 : scanCanonicalize (H12AffineFastState.compose env8037 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound8037 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env8038 : List Nat := [2,4,8,16,1,64,88,4,81,69,2048,1,2136,81,2048,2130,0,2129,2142,2048,0,1,16,82,2057,64,2128,81,81,2048,68,2122,4,81,1,80]

theorem envBound8038 : H12AffineFastState.Bounded env8038 := by
  intro p hp
  have h : env8038.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8037_8038 : H12AffineEnvironment.transform 6 88 env8037 = env8038 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env8037 == env8038) = true)

theorem identity8038 : scanCanonicalize (H12AffineFastState.compose env8038 (packedSelected [3] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound8038 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env8039 : List Nat := [2,4,8,16,1,17,9,4,0,20,2048,1,2057,0,2048,2051,0,2048,2063,2048,0,1,16,3,2057,17,2049,0,0,2048,21,2075,4,0,1,1]

theorem envBound8039 : H12AffineFastState.Bounded env8039 := by
  intro p hp
  have h : env8039.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8038_8039 : H12AffineEnvironment.transform 5 17 env8038 = env8039 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env8038 == env8039) = true)

theorem identity8039 : scanCanonicalize (H12AffineFastState.compose env8039 (packedSelected [1] rootPS)) = affineNative (2^(10+1) ^^^ 27) := by decide +kernel

theorem selectedBound8039 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env8040 : List Nat := [2,4,8,16,1,17,9,4,0,20,27,1,18,0,27,24,0,27,20,27,0,1,16,3,18,17,26,0,0,27,21,0,4,0,1,1]

theorem envBound8040 : H12AffineFastState.Bounded env8040 := by
  intro p hp
  have h : env8040.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8039_8040 : H12AffineEnvironment.transform 10 27 env8039 = env8040 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 27 env8039 == env8040) = true)

def leafEnv8040 : List Nat := [2,4,8,16,1,17,9,4,0,20,27,1,18,0,27,24,0,27,20,27,0,1,16,3,20,18,1,17,26,0,0,27,21,0,4,0,5,24,1,1,0,0,1]

def active8040 : List Nat := [0,1,2,3]

def tree8040 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood8040 : H12WitnessSearch.Good tree8040 := H12GlobalWitnessIndex.good

theorem leafIdentity8040 : H12AffineFastState.composeSystem env8040 rootObs = leafEnv8040 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env8040 rootObs == leafEnv8040) = true)

theorem terminalChecked8040 : H12PackedTerminal.terminalCheckFast leafEnv8040 active8040 tree8040 = true := by decide +kernel

def env8041 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1345,8192,1297,32768,65536,1344,262144,524288,32768,1344,4194304,17,16777216,8329,65,21331968,1297,1297,4294795,16876545,4294967296,256,4316464298,1345,513]

theorem envBound8041 : H12AffineFastState.Bounded env8041 := by
  intro p hp
  have h : env8041.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7966_8041 : H12AffineEnvironment.transform 11 1345 env7966 = env8041 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1345 env7966 == env8041) = true)

theorem identity8041 : scanCanonicalize (H12AffineFastState.compose env8041 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(8+1) ^^^ 217) := by decide +kernel

theorem selectedBound8041 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env8042 : List Nat := [2,4,8,16,32,64,128,256,217,1024,2048,1345,8192,1297,32768,65536,1344,262144,524288,32768,1344,4194304,17,16777216,8329,65,21331968,1297,1297,4294795,16876545,4294967296,256,4316464298,1345,216]

theorem envBound8042 : H12AffineFastState.Bounded env8042 := by
  intro p hp
  have h : env8042.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8041_8042 : H12AffineEnvironment.transform 8 217 env8041 = env8042 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 217 env8041 == env8042) = true)

theorem identity8042 : scanCanonicalize (H12AffineFastState.compose env8042 (packedSelected [4,16,22] rootPS)) = affineNative (2^(23+1) ^^^ 623876) := by decide +kernel

theorem selectedBound8042 : packedSelected [4,16,22] rootPS < 2^1333 := by decide +kernel

def env8043 : List Nat := [2,4,8,16,32,64,128,256,217,1024,2048,1345,8192,1297,32768,65536,1344,262144,524288,32768,1344,4194304,17,623876,8329,65,4982020,1297,1297,4294795,524549,4294967296,256,4299260334,1345,216]

theorem envBound8043 : H12AffineFastState.Bounded env8043 := by
  intro p hp
  have h : env8043.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8042_8043 : H12AffineEnvironment.transform 23 623876 env8042 = env8043 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 623876 env8042 == env8043) = true)

theorem identity8043 : scanCanonicalize (H12AffineFastState.compose env8043 (packedSelected [4,9,16] rootPS)) = affineNative (2^(18+1) ^^^ 1025) := by decide +kernel

theorem selectedBound8043 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env8044 : List Nat := [2,4,8,16,32,64,128,256,217,1024,2048,1345,8192,1297,32768,65536,1344,262144,1025,32768,1344,4194304,17,98565,8329,65,4456709,1297,1297,4294795,1284,4294967296,256,4299260334,1345,216]

theorem envBound8044 : H12AffineFastState.Bounded env8044 := by
  intro p hp
  have h : env8044.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8043_8044 : H12AffineEnvironment.transform 18 1025 env8043 = env8044 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env8043 == env8044) = true)

theorem identity8044 : scanCanonicalize (H12AffineFastState.compose env8044 (packedSelected [3,5,10] rootPS)) = affineNative (2^(31+1) ^^^ 98598) := by decide +kernel

theorem selectedBound8044 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env8045 : List Nat := [2,4,8,16,32,64,128,256,217,1024,2048,1345,8192,1297,32768,65536,1344,262144,1025,32768,1344,4194304,17,98565,8329,65,4456709,1297,1297,4294795,1284,98598,256,4194440,1345,216]

theorem envBound8045 : H12AffineFastState.Bounded env8045 := by
  intro p hp
  have h : env8045.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8044_8045 : H12AffineEnvironment.transform 31 98598 env8044 = env8045 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 98598 env8044 == env8045) = true)

theorem identity8045 : scanCanonicalize (H12AffineFastState.compose env8045 (packedSelected [1,12,13] rootPS)) = affineNative (2^(15+1) ^^^ 32929) := by decide +kernel

theorem selectedBound8045 : packedSelected [1,12,13] rootPS < 2^1333 := by decide +kernel

def env8046 : List Nat := [2,4,8,16,32,64,128,256,217,1024,2048,1345,8192,1297,32768,32929,1344,262144,1025,32768,1344,4194304,17,420,8329,65,4456709,1297,1297,4196394,1284,391,256,4194440,1345,216]

theorem envBound8046 : H12AffineFastState.Bounded env8046 := by
  intro p hp
  have h : env8046.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8045_8046 : H12AffineEnvironment.transform 15 32929 env8045 = env8046 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 32929 env8045 == env8046) = true)

theorem identity8046 : scanCanonicalize (H12AffineFastState.compose env8046 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 43271) := by decide +kernel

theorem selectedBound8046 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env8047 : List Nat := [2,4,8,16,32,64,128,256,217,1024,2048,1345,8192,1297,32768,32929,1344,43271,1025,32768,1344,4194304,17,420,8329,65,4237314,1297,1297,4196394,1284,391,256,4194440,1345,216]

theorem envBound8047 : H12AffineFastState.Bounded env8047 := by
  intro p hp
  have h : env8047.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8046_8047 : H12AffineEnvironment.transform 17 43271 env8046 = env8047 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43271 env8046 == env8047) = true)

theorem identity8047 : scanCanonicalize (H12AffineFastState.compose env8047 (packedSelected [3,5,12,17] rootPS)) = affineNative (2^(14+1) ^^^ 8460) := by decide +kernel

theorem selectedBound8047 : packedSelected [3,5,12,17] rootPS < 2^1333 := by decide +kernel

def env8048 : List Nat := [2,4,8,16,32,64,128,256,217,1024,2048,1345,8192,1297,8460,8621,1344,2059,1025,8460,1344,4194304,17,420,8329,65,4196622,1297,1297,4196394,1284,391,256,4194440,1345,216]

theorem envBound8048 : H12AffineFastState.Bounded env8048 := by
  intro p hp
  have h : env8048.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8047_8048 : H12AffineEnvironment.transform 14 8460 env8047 = env8048 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8460 env8047 == env8048) = true)

theorem identity8048 : scanCanonicalize (H12AffineFastState.compose env8048 (packedSelected [6] rootPS)) = affineNative (2^(21+1) ^^^ 3319) := by decide +kernel

theorem selectedBound8048 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env8049 : List Nat := [2,4,8,16,32,64,128,256,217,1024,2048,1345,8192,1297,8460,8621,1344,2059,1025,8460,1344,3319,17,420,8329,65,1529,1297,1297,1245,1284,391,256,3199,1345,216]

end H12GlobalChart2
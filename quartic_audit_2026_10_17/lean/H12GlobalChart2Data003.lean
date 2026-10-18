import H12GlobalChart2Data002

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem envTrans707_714 : H12AffineEnvironment.transform 10 1 env707 = env714 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env707 == env714) = true)

theorem identity714 : scanCanonicalize (H12AffineFastState.compose env714 (packedSelected [0] rootPS)) = affineNative (2^(12+1) ^^^ 5433) := by decide +kernel

theorem selectedBound714 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env715 : List Nat := [2,4,8,16,32,16,9,256,0,1024,1,4096,5433,4096,292,5416,1297,5173,1025,292,4097,260,5376,5384,5433,5377,5172,4097,1297,5387,1284,5435,256,277,1296,1]

theorem envBound715 : H12AffineFastState.Bounded env715 := by
  intro p hp
  have h : env715.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans714_715 : H12AffineEnvironment.transform 12 5433 env714 = env715 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5433 env714 == env715) = true)

theorem identity715 : scanCanonicalize (H12AffineFastState.compose env715 (packedSelected [1,3,5] rootPS)) = affineNative (2^(11+1) ^^^ 1290) := by decide +kernel

theorem selectedBound715 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env716 : List Nat := [2,4,8,16,32,16,9,256,0,1024,1,1290,51,1290,292,34,1297,319,1025,292,1291,260,10,2,51,11,318,1291,1297,1,1284,49,256,277,1296,1]

theorem envBound716 : H12AffineFastState.Bounded env716 := by
  intro p hp
  have h : env716.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans715_716 : H12AffineEnvironment.transform 11 1290 env715 = env716 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1290 env715 == env716) = true)

def env717 : List Nat := [2,4,8,0,32,0,9,256,0,1024,1,1290,35,1290,292,34,1281,303,1025,292,1291,260,10,2,35,11,302,1291,1281,1,1284,33,256,261,1280,1]

theorem envBound717 : H12AffineFastState.Bounded env717 := by
  intro p hp
  have h : env717.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans716_717 : H12AffineEnvironment.transform 3 0 env716 = env717 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env716 == env717) = true)

def leafEnv717 : List Nat := [2,4,8,0,32,0,9,256,0,1024,1,1290,35,1290,292,34,1281,303,1025,292,1291,260,10,2,1285,35,1,11,302,1291,1281,1,1284,33,256,261,4,35,1280,1,0,1280,1]

def active717 : List Nat := [0,1,2,4,7,9]

def tree717 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood717 : H12WitnessSearch.Good tree717 := H12GlobalWitnessIndex.good

theorem leafIdentity717 : H12AffineFastState.composeSystem env717 rootObs = leafEnv717 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env717 rootObs == leafEnv717) = true)

theorem terminalChecked717 : H12PackedTerminal.terminalCheckFast leafEnv717 active717 tree717 = true := by decide +kernel

def env718 : List Nat := [2,4,8,1,32,1,9,256,0,1024,1,1290,34,1290,292,34,1280,302,1025,292,1291,260,10,2,34,11,303,1291,1280,1,1284,32,256,260,1281,1]

theorem envBound718 : H12AffineFastState.Bounded env718 := by
  intro p hp
  have h : env718.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans716_718 : H12AffineEnvironment.transform 3 1 env716 = env718 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env716 == env718) = true)

theorem identity718 : scanCanonicalize (H12AffineFastState.compose env718 (packedSelected [2] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound718 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env719 : List Nat := [2,4,8,1,32,1,9,36,0,1024,1,1070,34,1070,0,34,1060,10,1025,0,1071,32,10,2,34,11,11,1071,1060,1,1056,32,36,32,1061,1]

theorem envBound719 : H12AffineFastState.Bounded env719 := by
  intro p hp
  have h : env719.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans718_719 : H12AffineEnvironment.transform 7 36 env718 = env719 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env718 == env719) = true)

def leafEnv719 : List Nat := [2,4,8,1,32,1,9,36,0,1024,1,1070,34,1070,0,34,1060,10,1025,0,1071,32,10,2,1057,34,1,11,11,1071,1060,1,1056,32,36,32,4,35,1061,1,0,1061,1]

def active719 : List Nat := [0,1,2,4,9]

def tree719 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood719 : H12WitnessSearch.Good tree719 := H12GlobalWitnessIndex.good

theorem leafIdentity719 : H12AffineFastState.composeSystem env719 rootObs = leafEnv719 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env719 rootObs == leafEnv719) = true)

theorem terminalChecked719 : H12PackedTerminal.terminalCheckFast leafEnv719 active719 tree719 = true := by decide +kernel

def env720 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,13972,65536,1296,262144,1025,13972,4097,4194304,5376,79760,8328,5377,4456708,4097,1297,4275742,1284,4294967296,256,4299241275,1297,512]

theorem envBound720 : H12AffineFastState.Bounded env720 := by
  intro p hp
  have h : env720.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans699_720 : H12AffineEnvironment.transform 5 17 env699 = env720 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env699 == env720) = true)

theorem identity720 : scanCanonicalize (H12AffineFastState.compose env720 (packedSelected [3,5,10] rootPS)) = affineNative (2^(21+1) ^^^ 1165) := by decide +kernel

theorem selectedBound720 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env721 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,13972,65536,1296,262144,1025,13972,4097,1165,5376,79760,8328,5377,263561,4097,1297,80531,1284,4294967296,256,4295046070,1297,512]

theorem envBound721 : H12AffineFastState.Bounded env721 := by
  intro p hp
  have h : env721.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans720_721 : H12AffineEnvironment.transform 21 1165 env720 = env721 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 1165 env720 == env721) = true)

theorem identity721 : scanCanonicalize (H12AffineFastState.compose env721 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(9+1) ^^^ 257) := by decide +kernel

theorem selectedBound721 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env722 : List Nat := [2,4,8,16,32,17,128,256,512,257,2048,4096,8192,4096,13205,65536,17,262144,256,13205,4097,396,4097,78481,8328,4096,262280,4097,16,80531,5,4294967296,256,4295046070,16,512]

theorem envBound722 : H12AffineFastState.Bounded env722 := by
  intro p hp
  have h : env722.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans721_722 : H12AffineEnvironment.transform 9 257 env721 = env722 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 257 env721 == env722) = true)

theorem identity722 : scanCanonicalize (H12AffineFastState.compose env722 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 69943) := by decide +kernel

theorem selectedBound722 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env723 : List Nat := [2,4,8,16,32,17,128,256,512,257,2048,4096,8192,4096,13205,65536,17,262144,256,13205,4097,396,4097,78481,8328,4096,262280,4097,16,80531,5,69943,256,8833,16,512]

theorem envBound723 : H12AffineFastState.Bounded env723 := by
  intro p hp
  have h : env723.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans722_723 : H12AffineEnvironment.transform 31 69943 env722 = env723 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 69943 env722 == env723) = true)

theorem identity723 : scanCanonicalize (H12AffineFastState.compose env723 (packedSelected [8,13] rootPS)) = affineNative (2^(17+1) ^^^ 78612) := by decide +kernel

theorem selectedBound723 : packedSelected [8,13] rootPS < 2^1333 := by decide +kernel

def env724 : List Nat := [2,4,8,16,32,17,128,256,512,257,2048,4096,8192,4096,13205,65536,17,78612,256,13205,4097,396,4097,78481,8328,4096,78748,4097,16,80531,5,69943,256,8833,16,512]

theorem envBound724 : H12AffineFastState.Bounded env724 := by
  intro p hp
  have h : env724.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans723_724 : H12AffineEnvironment.transform 17 78612 env723 = env724 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 78612 env723 == env724) = true)

theorem identity724 : scanCanonicalize (H12AffineFastState.compose env724 (packedSelected [0,7,20] rootPS)) = affineNative (2^(12+1) ^^^ 4753) := by decide +kernel

theorem selectedBound724 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env725 : List Nat := [2,4,8,16,32,17,128,256,512,257,2048,4096,4753,4096,260,65536,17,65925,256,260,4097,396,4097,65536,4633,4096,65805,4097,16,67586,5,69943,256,4112,16,512]

theorem envBound725 : H12AffineFastState.Bounded env725 := by
  intro p hp
  have h : env725.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans724_725 : H12AffineEnvironment.transform 12 4753 env724 = env725 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4753 env724 == env725) = true)

theorem identity725 : scanCanonicalize (H12AffineFastState.compose env725 (packedSelected [8,21] rootPS)) = affineNative (2^(11+1) ^^^ 665) := by decide +kernel

theorem selectedBound725 : packedSelected [8,21] rootPS < 2^1333 := by decide +kernel

def env726 : List Nat := [2,4,8,16,32,17,128,256,512,257,2048,665,8,665,260,65536,17,65925,256,260,664,396,664,65536,128,665,65805,664,16,67586,5,66478,256,649,16,512]

theorem envBound726 : H12AffineFastState.Bounded env726 := by
  intro p hp
  have h : env726.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans725_726 : H12AffineEnvironment.transform 11 665 env725 = env726 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 665 env725 == env726) = true)

theorem identity726 : scanCanonicalize (H12AffineFastState.compose env726 (packedSelected [1,8,12] rootPS)) = affineNative (2^(8+1) ^^^ 396) := by decide +kernel

theorem selectedBound726 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env727 : List Nat := [2,4,8,16,32,17,128,256,396,257,2048,277,8,277,260,65536,17,65925,256,260,276,396,276,65536,128,277,65805,276,16,67586,5,65570,256,261,16,396]

theorem envBound727 : H12AffineFastState.Bounded env727 := by
  intro p hp
  have h : env727.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans726_727 : H12AffineEnvironment.transform 8 396 env726 = env727 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 396 env726 == env727) = true)

theorem identity727 : scanCanonicalize (H12AffineFastState.compose env727 (packedSelected [2,23,32] rootPS)) = affineNative (2^(15+1) ^^^ 295) := by decide +kernel

theorem selectedBound727 : packedSelected [2,23,32] rootPS < 2^1333 := by decide +kernel

def env728 : List Nat := [2,4,8,16,32,17,128,256,396,257,2048,277,8,277,260,295,17,162,256,260,276,396,276,295,128,277,42,276,16,2341,5,261,256,261,16,396]

theorem envBound728 : H12AffineFastState.Bounded env728 := by
  intro p hp
  have h : env728.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans727_728 : H12AffineEnvironment.transform 15 295 env727 = env728 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 295 env727 == env728) = true)

theorem identity728 : scanCanonicalize (H12AffineFastState.compose env728 (packedSelected [2,5,8] rootPS)) = affineNative (2^(7+1) ^^^ 173) := by decide +kernel

theorem selectedBound728 : packedSelected [2,5,8] rootPS < 2^1333 := by decide +kernel

def env729 : List Nat := [2,4,8,16,32,17,128,173,33,172,2048,184,8,184,169,138,17,162,173,169,185,33,185,138,128,184,42,185,16,2184,5,168,173,168,16,33]

theorem envBound729 : H12AffineFastState.Bounded env729 := by
  intro p hp
  have h : env729.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans728_729 : H12AffineEnvironment.transform 7 173 env728 = env729 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 173 env728 == env729) = true)

theorem identity729 : scanCanonicalize (H12AffineFastState.compose env729 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(10+1) ^^^ 43) := by decide +kernel

theorem selectedBound729 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env730 : List Nat := [2,4,8,16,32,17,128,173,33,172,43,184,8,184,169,138,17,162,173,169,185,33,185,138,128,184,42,185,16,163,5,168,173,168,16,33]

theorem envBound730 : H12AffineFastState.Bounded env730 := by
  intro p hp
  have h : env730.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans729_730 : H12AffineEnvironment.transform 10 43 env729 = env730 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 43 env729 == env730) = true)

def env731 : List Nat := [2,4,8,16,32,17,8,37,33,36,43,48,8,48,33,2,17,42,37,33,49,33,49,2,8,48,42,49,16,43,5,32,37,32,16,33]

theorem envBound731 : H12AffineFastState.Bounded env731 := by
  intro p hp
  have h : env731.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans730_731 : H12AffineEnvironment.transform 6 8 env730 = env731 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env730 == env731) = true)

theorem identity731 : scanCanonicalize (H12AffineFastState.compose env731 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 9) := by decide +kernel

theorem selectedBound731 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env732 : List Nat := [2,4,8,16,9,17,8,12,8,13,2,25,8,25,8,2,17,3,12,8,24,8,24,2,8,25,3,24,16,2,5,9,12,9,16,8]

theorem envBound732 : H12AffineFastState.Bounded env732 := by
  intro p hp
  have h : env732.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans731_732 : H12AffineEnvironment.transform 4 9 env731 = env732 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 9 env731 == env732) = true)

def env733 : List Nat := [2,4,0,16,1,17,0,4,0,5,2,17,0,17,0,2,17,3,4,0,16,0,16,2,0,17,3,16,16,2,5,1,4,1,16,0]

theorem envBound733 : H12AffineFastState.Bounded env733 := by
  intro p hp
  have h : env733.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans732_733 : H12AffineEnvironment.transform 2 0 env732 = env733 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env732 == env733) = true)

def leafEnv733 : List Nat := [2,4,0,16,1,17,0,4,0,5,2,17,0,17,0,2,17,3,4,0,16,0,16,2,4,0,1,17,3,16,16,2,5,1,4,1,4,2,16,0,0,17,1]

def active733 : List Nat := [0,1,3]

def tree733 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood733 : H12WitnessSearch.Good tree733 := H12GlobalWitnessIndex.good

theorem leafIdentity733 : H12AffineFastState.composeSystem env733 rootObs = leafEnv733 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env733 rootObs == leafEnv733) = true)

theorem terminalChecked733 : H12PackedTerminal.terminalCheckFast leafEnv733 active733 tree733 = true := by decide +kernel

def env734 : List Nat := [2,4,1,16,0,17,1,5,1,4,2,16,1,16,1,2,17,3,5,1,17,1,17,2,1,16,3,17,16,2,5,0,5,0,16,1]

theorem envBound734 : H12AffineFastState.Bounded env734 := by
  intro p hp
  have h : env734.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans732_734 : H12AffineEnvironment.transform 2 1 env732 = env734 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env732 == env734) = true)

theorem identity734 : scanCanonicalize (H12AffineFastState.compose env734 (packedSelected [1] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound734 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env735 : List Nat := [0,4,1,16,0,17,1,5,1,4,0,16,1,16,1,0,17,1,5,1,17,1,17,0,1,16,1,17,16,0,5,0,5,0,16,1]

theorem envBound735 : H12AffineFastState.Bounded env735 := by
  intro p hp
  have h : env735.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans734_735 : H12AffineEnvironment.transform 0 0 env734 = env735 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env734 == env735) = true)

def leafEnv735 : List Nat := [0,4,1,16,0,17,1,5,1,4,0,16,1,16,1,0,17,1,5,1,17,1,17,0,4,1,1,16,1,17,16,0,5,0,5,0,4,0,16,1,0,17,1]

def active735 : List Nat := [1,3]

def tree735 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood735 : H12WitnessSearch.Good tree735 := H12GlobalWitnessIndex.good

theorem leafIdentity735 : H12AffineFastState.composeSystem env735 rootObs = leafEnv735 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env735 rootObs == leafEnv735) = true)

theorem terminalChecked735 : H12PackedTerminal.terminalCheckFast leafEnv735 active735 tree735 = true := by decide +kernel

def env736 : List Nat := [2,4,8,16,32,17,9,36,33,37,43,49,8,49,32,3,17,43,36,32,48,33,48,3,9,49,42,48,16,42,5,33,36,33,16,33]

theorem envBound736 : H12AffineFastState.Bounded env736 := by
  intro p hp
  have h : env736.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans730_736 : H12AffineEnvironment.transform 6 9 env730 = env736 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env730 == env736) = true)

theorem identity736 : scanCanonicalize (H12AffineFastState.compose env736 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 3) := by decide +kernel

theorem selectedBound736 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env737 : List Nat := [2,4,8,16,3,17,9,7,2,6,8,18,8,18,3,3,17,8,7,3,19,2,19,3,9,18,9,19,16,9,5,2,7,2,16,2]

theorem envBound737 : H12AffineFastState.Bounded env737 := by
  intro p hp
  have h : env737.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans736_737 : H12AffineEnvironment.transform 4 3 env736 = env737 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 3 env736 == env737) = true)

theorem identity737 : scanCanonicalize (H12AffineFastState.compose env737 (packedSelected [1,3] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound737 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env738 : List Nat := [1,4,8,16,0,17,9,4,1,5,8,17,8,17,0,0,17,8,4,0,16,1,16,0,9,17,9,16,16,9,5,1,4,1,16,1]

theorem envBound738 : H12AffineFastState.Bounded env738 := by
  intro p hp
  have h : env738.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans737_738 : H12AffineEnvironment.transform 0 1 env737 = env738 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env737 == env738) = true)

def leafEnv738 : List Nat := [1,4,8,16,0,17,9,4,1,5,8,17,8,17,0,0,17,8,4,0,16,1,16,0,4,9,1,17,9,16,16,9,5,1,4,1,4,1,16,1,0,17,1]

def active738 : List Nat := [1,2,3]

def tree738 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood738 : H12WitnessSearch.Good tree738 := H12GlobalWitnessIndex.good

theorem leafIdentity738 : H12AffineFastState.composeSystem env738 rootObs = leafEnv738 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env738 rootObs == leafEnv738) = true)

theorem terminalChecked738 : H12PackedTerminal.terminalCheckFast leafEnv738 active738 tree738 = true := by decide +kernel

def env739 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4097,32768,65536,1345,262144,1025,32768,4097,4194304,5377,98564,8408,5377,4456788,4096,1297,4294874,1284,4294967296,256,4299260335,1344,592]

theorem envBound739 : H12AffineFastState.Bounded env739 := by
  intro p hp
  have h : env739.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans697_739 : H12AffineEnvironment.transform 13 4097 env697 = env739 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4097 env697 == env739) = true)

theorem identity739 : scanCanonicalize (H12AffineFastState.compose env739 (packedSelected [3,4,9,10,15,16,17,24] rootPS)) = affineNative (2^(14+1) ^^^ 14021) := by decide +kernel

theorem selectedBound739 : packedSelected [3,4,9,10,15,16,17,24] rootPS < 2^1333 := by decide +kernel

def env740 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4097,14021,65536,1345,262144,1025,14021,4097,4194304,5377,79809,8408,5377,4456788,4096,1297,4275743,1284,4294967296,256,4299241322,1344,592]

theorem envBound740 : H12AffineFastState.Bounded env740 := by
  intro p hp
  have h : env740.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans739_740 : H12AffineEnvironment.transform 14 14021 env739 = env740 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 14021 env739 == env740) = true)

def env741 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,13973,65536,1297,262144,1025,13973,4097,4194304,5377,79761,8328,5377,4456708,4096,1297,4275743,1284,4294967296,256,4299241274,1296,512]

theorem envBound741 : H12AffineFastState.Bounded env741 := by
  intro p hp
  have h : env741.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans740_741 : H12AffineEnvironment.transform 5 16 env740 = env741 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env740 == env741) = true)

theorem identity741 : scanCanonicalize (H12AffineFastState.compose env741 (packedSelected [3,5,10] rootPS)) = affineNative (2^(21+1) ^^^ 1165) := by decide +kernel

theorem selectedBound741 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env742 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,13973,65536,1297,262144,1025,13973,4097,1165,5377,79761,8328,5377,263561,4096,1297,80530,1284,4294967296,256,4295046071,1296,512]

theorem envBound742 : H12AffineFastState.Bounded env742 := by
  intro p hp
  have h : env742.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans741_742 : H12AffineEnvironment.transform 21 1165 env741 = env742 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 1165 env741 == env742) = true)

theorem identity742 : scanCanonicalize (H12AffineFastState.compose env742 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(9+1) ^^^ 257) := by decide +kernel

theorem selectedBound742 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env743 : List Nat := [2,4,8,16,32,16,128,256,512,257,2048,4096,8192,4097,13204,65536,16,262144,256,13204,4097,396,4096,78480,8328,4096,262280,4096,16,80530,5,4294967296,256,4295046071,17,512]

theorem envBound743 : H12AffineFastState.Bounded env743 := by
  intro p hp
  have h : env743.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans742_743 : H12AffineEnvironment.transform 9 257 env742 = env743 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 257 env742 == env743) = true)

theorem identity743 : scanCanonicalize (H12AffineFastState.compose env743 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 69942) := by decide +kernel

theorem selectedBound743 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env744 : List Nat := [2,4,8,16,32,16,128,256,512,257,2048,4096,8192,4097,13204,65536,16,262144,256,13204,4097,396,4096,78480,8328,4096,262280,4096,16,80530,5,69942,256,8833,17,512]

theorem envBound744 : H12AffineFastState.Bounded env744 := by
  intro p hp
  have h : env744.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans743_744 : H12AffineEnvironment.transform 31 69942 env743 = env744 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 69942 env743 == env744) = true)

theorem identity744 : scanCanonicalize (H12AffineFastState.compose env744 (packedSelected [8,13] rootPS)) = affineNative (2^(17+1) ^^^ 78613) := by decide +kernel

theorem selectedBound744 : packedSelected [8,13] rootPS < 2^1333 := by decide +kernel

def env745 : List Nat := [2,4,8,16,32,16,128,256,512,257,2048,4096,8192,4097,13204,65536,16,78613,256,13204,4097,396,4096,78480,8328,4096,78749,4096,16,80530,5,69942,256,8833,17,512]

theorem envBound745 : H12AffineFastState.Bounded env745 := by
  intro p hp
  have h : env745.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans744_745 : H12AffineEnvironment.transform 17 78613 env744 = env745 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 78613 env744 == env745) = true)

theorem identity745 : scanCanonicalize (H12AffineFastState.compose env745 (packedSelected [0,7,20] rootPS)) = affineNative (2^(12+1) ^^^ 4752) := by decide +kernel

theorem selectedBound745 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env746 : List Nat := [2,4,8,16,32,16,128,256,512,257,2048,4096,4752,4097,260,65536,16,65925,256,260,4097,396,4096,65536,4632,4096,65805,4096,16,67586,5,69942,256,4113,17,512]

theorem envBound746 : H12AffineFastState.Bounded env746 := by
  intro p hp
  have h : env746.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans745_746 : H12AffineEnvironment.transform 12 4752 env745 = env746 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4752 env745 == env746) = true)

theorem identity746 : scanCanonicalize (H12AffineFastState.compose env746 (packedSelected [8,21] rootPS)) = affineNative (2^(11+1) ^^^ 664) := by decide +kernel

theorem selectedBound746 : packedSelected [8,21] rootPS < 2^1333 := by decide +kernel

def env747 : List Nat := [2,4,8,16,32,16,128,256,512,257,2048,664,8,665,260,65536,16,65925,256,260,665,396,664,65536,128,664,65805,664,16,67586,5,66478,256,649,17,512]

theorem envBound747 : H12AffineFastState.Bounded env747 := by
  intro p hp
  have h : env747.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans746_747 : H12AffineEnvironment.transform 11 664 env746 = env747 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 664 env746 == env747) = true)

theorem identity747 : scanCanonicalize (H12AffineFastState.compose env747 (packedSelected [1,8,12] rootPS)) = affineNative (2^(8+1) ^^^ 396) := by decide +kernel

theorem selectedBound747 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env748 : List Nat := [2,4,8,16,32,16,128,256,396,257,2048,276,8,277,260,65536,16,65925,256,260,277,396,276,65536,128,276,65805,276,16,67586,5,65570,256,261,17,396]

theorem envBound748 : H12AffineFastState.Bounded env748 := by
  intro p hp
  have h : env748.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans747_748 : H12AffineEnvironment.transform 8 396 env747 = env748 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 396 env747 == env748) = true)

theorem identity748 : scanCanonicalize (H12AffineFastState.compose env748 (packedSelected [2,23,32] rootPS)) = affineNative (2^(15+1) ^^^ 34) := by decide +kernel

theorem selectedBound748 : packedSelected [2,23,32] rootPS < 2^1333 := by decide +kernel

def env749 : List Nat := [2,4,8,16,32,16,128,256,396,257,2048,276,8,277,260,34,16,423,256,260,277,396,276,34,128,276,303,276,16,2080,5,0,256,261,17,396]

theorem envBound749 : H12AffineFastState.Bounded env749 := by
  intro p hp
  have h : env749.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans748_749 : H12AffineEnvironment.transform 15 34 env748 = env749 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 34 env748 == env749) = true)

theorem identity749 : scanCanonicalize (H12AffineFastState.compose env749 (packedSelected [2,5,8,11,18] rootPS)) = affineNative (2^(6+1) ^^^ 40) := by decide +kernel

theorem selectedBound749 : packedSelected [2,5,8,11,18] rootPS < 2^1333 := by decide +kernel

def env750 : List Nat := [2,4,8,16,32,16,40,256,292,257,2048,276,8,277,260,34,16,271,256,260,277,292,276,34,40,276,303,276,16,2080,5,0,256,261,17,292]

theorem envBound750 : H12AffineFastState.Bounded env750 := by
  intro p hp
  have h : env750.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans749_750 : H12AffineEnvironment.transform 6 40 env749 = env750 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 40 env749 == env750) = true)

theorem identity750 : scanCanonicalize (H12AffineFastState.compose env750 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(10+1) ^^^ 43) := by decide +kernel

theorem selectedBound750 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env751 : List Nat := [2,4,8,16,32,16,40,256,292,257,43,276,8,277,260,34,16,271,256,260,277,292,276,34,40,276,303,276,16,11,5,0,256,261,17,292]

theorem envBound751 : H12AffineFastState.Bounded env751 := by
  intro p hp
  have h : env751.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans750_751 : H12AffineEnvironment.transform 10 43 env750 = env751 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 43 env750 == env751) = true)

def env752 : List Nat := [2,4,8,16,0,16,8,256,260,257,11,276,8,277,260,2,16,271,256,260,277,260,276,2,8,276,271,276,16,11,5,0,256,261,17,260]

theorem envBound752 : H12AffineFastState.Bounded env752 := by
  intro p hp
  have h : env752.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans751_752 : H12AffineEnvironment.transform 4 0 env751 = env752 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env751 == env752) = true)

theorem identity752 : scanCanonicalize (H12AffineFastState.compose env752 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 13) := by decide +kernel

theorem selectedBound752 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env753 : List Nat := [2,4,8,16,0,16,8,13,9,12,11,25,8,24,9,2,16,2,13,9,24,9,25,2,8,25,2,25,16,11,5,0,13,8,17,9]

theorem envBound753 : H12AffineFastState.Bounded env753 := by
  intro p hp
  have h : env753.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans752_753 : H12AffineEnvironment.transform 7 13 env752 = env753 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 13 env752 == env753) = true)

def env754 : List Nat := [2,4,0,16,0,16,0,5,1,4,3,17,0,16,1,2,16,2,5,1,16,1,17,2,0,17,2,17,16,3,5,0,5,0,17,1]

theorem envBound754 : H12AffineFastState.Bounded env754 := by
  intro p hp
  have h : env754.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans753_754 : H12AffineEnvironment.transform 2 0 env753 = env754 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env753 == env754) = true)

def leafEnv754 : List Nat := [2,4,0,16,0,16,0,5,1,4,3,17,0,16,1,2,16,2,5,1,16,1,17,2,4,0,1,17,2,17,16,3,5,0,5,0,4,2,17,1,0,17,1]

def active754 : List Nat := [0,1,3]

def tree754 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood754 : H12WitnessSearch.Good tree754 := H12GlobalWitnessIndex.good

theorem leafIdentity754 : H12AffineFastState.composeSystem env754 rootObs = leafEnv754 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env754 rootObs == leafEnv754) = true)

theorem terminalChecked754 : H12PackedTerminal.terminalCheckFast leafEnv754 active754 tree754 = true := by decide +kernel

def env755 : List Nat := [2,4,1,16,0,16,1,4,0,5,2,16,1,17,0,2,16,2,4,0,17,0,16,2,1,16,2,16,16,2,5,0,4,1,17,0]

theorem envBound755 : H12AffineFastState.Bounded env755 := by
  intro p hp
  have h : env755.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans753_755 : H12AffineEnvironment.transform 2 1 env753 = env755 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env753 == env755) = true)

theorem identity755 : scanCanonicalize (H12AffineFastState.compose env755 (packedSelected [1] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound755 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env756 : List Nat := [0,4,1,16,0,16,1,4,0,5,0,16,1,17,0,0,16,0,4,0,17,0,16,0,1,16,0,16,16,0,5,0,4,1,17,0]

theorem envBound756 : H12AffineFastState.Bounded env756 := by
  intro p hp
  have h : env756.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans755_756 : H12AffineEnvironment.transform 0 0 env755 = env756 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env755 == env756) = true)

def leafEnv756 : List Nat := [0,4,1,16,0,16,1,4,0,5,0,16,1,17,0,0,16,0,4,0,17,0,16,0,4,1,1,16,0,16,16,0,5,0,4,1,4,0,17,0,0,17,1]

def active756 : List Nat := [1,3]

def tree756 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood756 : H12WitnessSearch.Good tree756 := H12GlobalWitnessIndex.good

theorem leafIdentity756 : H12AffineFastState.composeSystem env756 rootObs = leafEnv756 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env756 rootObs == leafEnv756) = true)

theorem terminalChecked756 : H12PackedTerminal.terminalCheckFast leafEnv756 active756 tree756 = true := by decide +kernel

def env757 : List Nat := [2,4,8,16,1,16,9,256,261,257,10,276,8,277,260,3,16,271,256,260,277,261,276,3,9,276,270,276,16,11,5,0,256,261,17,261]

theorem envBound757 : H12AffineFastState.Bounded env757 := by
  intro p hp
  have h : env757.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans751_757 : H12AffineEnvironment.transform 4 1 env751 = env757 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env751 == env757) = true)

theorem identity757 : scanCanonicalize (H12AffineFastState.compose env757 (packedSelected [0] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound757 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env758 : List Nat := [1,4,8,16,1,16,9,256,261,257,9,276,8,277,260,0,16,268,256,260,277,261,276,0,9,276,269,276,16,8,5,0,256,261,17,261]

theorem envBound758 : H12AffineFastState.Bounded env758 := by
  intro p hp
  have h : env758.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans757_758 : H12AffineEnvironment.transform 0 1 env757 = env758 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env757 == env758) = true)

theorem identity758 : scanCanonicalize (H12AffineFastState.compose env758 (packedSelected [2] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound758 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env759 : List Nat := [1,4,8,16,1,16,9,5,0,4,9,17,8,16,1,0,16,9,5,1,16,0,17,0,9,17,8,17,16,8,5,0,5,0,17,0]

theorem envBound759 : H12AffineFastState.Bounded env759 := by
  intro p hp
  have h : env759.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans758_759 : H12AffineEnvironment.transform 7 5 env758 = env759 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env758 == env759) = true)

def leafEnv759 : List Nat := [1,4,8,16,1,16,9,5,0,4,9,17,8,16,1,0,16,9,5,1,16,0,17,0,4,9,1,17,8,17,16,8,5,0,5,0,4,1,17,0,0,17,1]

def active759 : List Nat := [1,2,3]

def tree759 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood759 : H12WitnessSearch.Good tree759 := H12GlobalWitnessIndex.good

theorem leafIdentity759 : H12AffineFastState.composeSystem env759 rootObs = leafEnv759 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env759 rootObs == leafEnv759) = true)

theorem terminalChecked759 : H12PackedTerminal.terminalCheckFast leafEnv759 active759 tree759 = true := by decide +kernel

def env760 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,13972,65536,1296,262144,1025,13972,4097,4194304,5377,79760,8329,5377,4456709,4096,1297,4275743,1284,4294967296,256,4299241275,1297,513]

theorem envBound760 : H12AffineFastState.Bounded env760 := by
  intro p hp
  have h : env760.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans740_760 : H12AffineEnvironment.transform 5 17 env740 = env760 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env740 == env760) = true)

theorem identity760 : scanCanonicalize (H12AffineFastState.compose env760 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound760 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env761 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8192,4097,13341,65536,1296,262144,1025,13341,4097,4194304,5377,79129,8329,5377,4456709,4096,1297,4275350,1284,4294967296,256,4299240882,1297,136]

theorem envBound761 : H12AffineFastState.Bounded env761 := by
  intro p hp
  have h : env761.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans760_761 : H12AffineEnvironment.transform 8 137 env760 = env761 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env760 == env761) = true)

theorem identity761 : scanCanonicalize (H12AffineFastState.compose env761 (packedSelected [1,6,8,12] rootPS)) = affineNative (2^(31+1) ^^^ 4268470) := by decide +kernel

theorem selectedBound761 : packedSelected [1,6,8,12] rootPS < 2^1333 := by decide +kernel

def env762 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8192,4097,13341,65536,1296,262144,1025,13341,4097,4194304,5377,79129,8329,5377,4456709,4096,1297,4275350,1284,4268470,256,5124,1297,136]

theorem envBound762 : H12AffineFastState.Bounded env762 := by
  intro p hp
  have h : env762.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans761_762 : H12AffineEnvironment.transform 31 4268470 env761 = env762 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4268470 env761 == env762) = true)

theorem identity762 : scanCanonicalize (H12AffineFastState.compose env762 (packedSelected [6,8,13] rootPS)) = affineNative (2^(21+1) ^^^ 396) := by decide +kernel

theorem selectedBound762 : packedSelected [6,8,13] rootPS < 2^1333 := by decide +kernel

def env763 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8192,4097,13341,65536,1296,262144,1025,13341,4097,396,5377,79129,8329,5377,262281,4096,1297,81178,1284,73786,256,5124,1297,136]

theorem envBound763 : H12AffineFastState.Bounded env763 := by
  intro p hp
  have h : env763.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans762_763 : H12AffineEnvironment.transform 21 396 env762 = env763 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 396 env762 == env763) = true)

theorem identity763 : scanCanonicalize (H12AffineFastState.compose env763 (packedSelected [6] rootPS)) = affineNative (2^(17+1) ^^^ 65941) := by decide +kernel

theorem selectedBound763 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env764 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8192,4097,13341,65536,1296,65941,1025,13341,4097,396,5377,79129,8329,5377,65820,4096,1297,81178,1284,73786,256,5124,1297,136]

theorem envBound764 : H12AffineFastState.Bounded env764 := by
  intro p hp
  have h : env764.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans763_764 : H12AffineEnvironment.transform 17 65941 env763 = env764 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 65941 env763 == env764) = true)

def env765 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8192,4097,13341,8208,1296,8581,1025,13341,4097,396,5377,5385,8329,5377,8460,4096,1297,7434,1284,42,256,5124,1297,136]

theorem envBound765 : H12AffineFastState.Bounded env765 := by
  intro p hp
  have h : env765.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans764_765 : H12AffineEnvironment.transform 15 8208 env764 = env765 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8208 env764 == env765) = true)

def env766 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8192,4097,13341,8209,1296,8580,1025,13341,4097,396,5377,5384,8329,5377,8461,4096,1297,7435,1284,43,256,5124,1297,136]

theorem envBound766 : H12AffineFastState.Bounded env766 := by
  intro p hp
  have h : env766.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans764_766 : H12AffineEnvironment.transform 15 8209 env764 = env766 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8209 env764 == env766) = true)

theorem identity766 : scanCanonicalize (H12AffineFastState.compose env766 (packedSelected [7] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound766 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env767 : List Nat := [2,4,8,16,32,17,8,256,1,1024,2048,4096,8192,4097,13341,8209,1296,8460,1025,13341,4097,260,5377,5384,8193,5377,8461,4096,1297,7435,1284,43,256,5124,1297,0]

theorem envBound767 : H12AffineFastState.Bounded env767 := by
  intro p hp
  have h : env767.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans766_767 : H12AffineEnvironment.transform 6 8 env766 = env767 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env766 == env767) = true)

def env768 : List Nat := [2,4,8,16,32,17,8,256,1,1024,0,4096,8192,4097,13341,8209,1296,8460,1025,13341,4097,260,5377,5384,8193,5377,8461,4096,1297,5387,1284,43,256,5124,1297,0]

theorem envBound768 : H12AffineFastState.Bounded env768 := by
  intro p hp
  have h : env768.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans767_768 : H12AffineEnvironment.transform 10 0 env767 = env768 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env767 == env768) = true)

theorem identity768 : scanCanonicalize (H12AffineFastState.compose env768 (packedSelected [0] rootPS)) = affineNative (2^(12+1) ^^^ 51) := by decide +kernel

theorem selectedBound768 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env769 : List Nat := [2,4,8,16,32,17,8,256,1,1024,0,4096,51,4097,5166,34,1296,319,1025,5166,4097,260,5377,5384,50,5377,318,4096,1297,5387,1284,43,256,5124,1297,0]

theorem envBound769 : H12AffineFastState.Bounded env769 := by
  intro p hp
  have h : env769.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans768_769 : H12AffineEnvironment.transform 12 51 env768 = env769 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 51 env768 == env769) = true)

theorem identity769 : scanCanonicalize (H12AffineFastState.compose env769 (packedSelected [2,4] rootPS)) = affineNative (2^(11+1) ^^^ 1291) := by decide +kernel

theorem selectedBound769 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env770 : List Nat := [2,4,8,16,32,17,8,256,1,1024,0,1291,51,1290,293,34,1296,319,1025,293,1290,260,10,3,50,10,318,1291,1297,0,1284,43,256,271,1297,0]

theorem envBound770 : H12AffineFastState.Bounded env770 := by
  intro p hp
  have h : env770.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans769_770 : H12AffineEnvironment.transform 11 1291 env769 = env770 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1291 env769 == env770) = true)

def env771 : List Nat := [2,4,8,16,32,17,8,36,1,1024,0,1071,51,1070,1,34,1076,27,1025,1,1070,32,10,3,50,10,26,1071,1077,0,1056,43,36,43,1077,0]

theorem envBound771 : H12AffineFastState.Bounded env771 := by
  intro p hp
  have h : env771.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans770_771 : H12AffineEnvironment.transform 7 36 env770 = env771 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env770 == env771) = true)

def leafEnv771 : List Nat := [2,4,8,16,32,17,8,36,1,1024,0,1071,51,1070,1,34,1076,27,1025,1,1070,32,10,3,1057,50,1,10,26,1071,1077,0,1056,43,36,43,4,34,1077,0,0,1076,1]

def active771 : List Nat := [0,1,2,3,4,9]

def tree771 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood771 : H12WitnessSearch.Good tree771 := H12GlobalWitnessIndex.good

theorem leafIdentity771 : H12AffineFastState.composeSystem env771 rootObs = leafEnv771 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env771 rootObs == leafEnv771) = true)

theorem terminalChecked771 : H12PackedTerminal.terminalCheckFast leafEnv771 active771 tree771 = true := by decide +kernel

def env772 : List Nat := [2,4,8,16,32,17,8,37,1,1024,0,1070,51,1071,0,34,1077,26,1025,0,1071,33,10,3,50,10,27,1070,1076,0,1057,43,37,42,1076,0]

theorem envBound772 : H12AffineFastState.Bounded env772 := by
  intro p hp
  have h : env772.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans770_772 : H12AffineEnvironment.transform 7 37 env770 = env772 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env770 == env772) = true)

theorem identity772 : scanCanonicalize (H12AffineFastState.compose env772 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound772 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env773 : List Nat := [2,4,2,16,32,17,2,37,1,1024,0,1060,51,1061,0,34,1077,16,1025,0,1061,33,0,3,50,0,17,1060,1076,0,1057,33,37,32,1076,0]

theorem envBound773 : H12AffineFastState.Bounded env773 := by
  intro p hp
  have h : env773.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans772_773 : H12AffineEnvironment.transform 2 2 env772 = env773 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env772 == env773) = true)

def leafEnv773 : List Nat := [2,4,2,16,32,17,2,37,1,1024,0,1060,51,1061,0,34,1077,16,1025,0,1061,33,0,3,1056,50,1,0,17,1060,1076,0,1057,33,37,32,4,34,1076,0,0,1077,1]

def active773 : List Nat := [0,1,3,4,9]

def tree773 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood773 : H12WitnessSearch.Good tree773 := H12GlobalWitnessIndex.good

theorem leafIdentity773 : H12AffineFastState.composeSystem env773 rootObs = leafEnv773 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env773 rootObs == leafEnv773) = true)

theorem terminalChecked773 : H12PackedTerminal.terminalCheckFast leafEnv773 active773 tree773 = true := by decide +kernel

def env774 : List Nat := [2,4,8,16,32,17,8,256,1,1024,1,4096,8192,4097,13341,8209,1296,8460,1025,13341,4097,260,5377,5384,8193,5377,8461,4096,1297,5386,1284,43,256,5124,1297,0]

theorem envBound774 : H12AffineFastState.Bounded env774 := by
  intro p hp
  have h : env774.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans767_774 : H12AffineEnvironment.transform 10 1 env767 = env774 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env767 == env774) = true)

theorem identity774 : scanCanonicalize (H12AffineFastState.compose env774 (packedSelected [0] rootPS)) = affineNative (2^(12+1) ^^^ 5433) := by decide +kernel

theorem selectedBound774 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env775 : List Nat := [2,4,8,16,32,17,8,256,1,1024,1,4096,5433,4097,292,5416,1296,5173,1025,292,4097,260,5377,5384,5432,5377,5172,4096,1297,5386,1284,43,256,5124,1297,0]

theorem envBound775 : H12AffineFastState.Bounded env775 := by
  intro p hp
  have h : env775.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans774_775 : H12AffineEnvironment.transform 12 5433 env774 = env775 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5433 env774 == env775) = true)

theorem identity775 : scanCanonicalize (H12AffineFastState.compose env775 (packedSelected [1,3,5] rootPS)) = affineNative (2^(11+1) ^^^ 1291) := by decide +kernel

theorem selectedBound775 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env776 : List Nat := [2,4,8,16,32,17,8,256,1,1024,1,1291,50,1290,292,35,1296,318,1025,292,1290,260,10,3,51,10,319,1291,1297,1,1284,43,256,271,1297,0]

theorem envBound776 : H12AffineFastState.Bounded env776 := by
  intro p hp
  have h : env776.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans775_776 : H12AffineEnvironment.transform 11 1291 env775 = env776 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1291 env775 == env776) = true)

def env777 : List Nat := [2,4,8,16,32,17,8,36,1,1024,1,1071,50,1070,0,35,1076,26,1025,0,1070,32,10,3,51,10,27,1071,1077,1,1056,43,36,43,1077,0]

theorem envBound777 : H12AffineFastState.Bounded env777 := by
  intro p hp
  have h : env777.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans776_777 : H12AffineEnvironment.transform 7 36 env776 = env777 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env776 == env777) = true)

def leafEnv777 : List Nat := [2,4,8,16,32,17,8,36,1,1024,1,1071,50,1070,0,35,1076,26,1025,0,1070,32,10,3,1057,51,1,10,27,1071,1077,1,1056,43,36,43,4,35,1077,0,0,1076,1]

def active777 : List Nat := [0,1,2,3,4,9]

def tree777 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood777 : H12WitnessSearch.Good tree777 := H12GlobalWitnessIndex.good

theorem leafIdentity777 : H12AffineFastState.composeSystem env777 rootObs = leafEnv777 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env777 rootObs == leafEnv777) = true)

theorem terminalChecked777 : H12PackedTerminal.terminalCheckFast leafEnv777 active777 tree777 = true := by decide +kernel

def env778 : List Nat := [2,4,8,16,32,17,8,37,1,1024,1,1070,50,1071,1,35,1077,27,1025,1,1071,33,10,3,51,10,26,1070,1076,1,1057,43,37,42,1076,0]

theorem envBound778 : H12AffineFastState.Bounded env778 := by
  intro p hp
  have h : env778.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans776_778 : H12AffineEnvironment.transform 7 37 env776 = env778 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env776 == env778) = true)

theorem identity778 : scanCanonicalize (H12AffineFastState.compose env778 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound778 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env779 : List Nat := [2,4,2,16,32,17,2,37,1,1024,1,1060,50,1061,1,35,1077,17,1025,1,1061,33,0,3,51,0,16,1060,1076,1,1057,33,37,32,1076,0]

theorem envBound779 : H12AffineFastState.Bounded env779 := by
  intro p hp
  have h : env779.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans778_779 : H12AffineEnvironment.transform 2 2 env778 = env779 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env778 == env779) = true)

def leafEnv779 : List Nat := [2,4,2,16,32,17,2,37,1,1024,1,1060,50,1061,1,35,1077,17,1025,1,1061,33,0,3,1056,51,1,0,16,1060,1076,1,1057,33,37,32,4,35,1076,0,0,1077,1]

def active779 : List Nat := [0,1,3,4,9]

def tree779 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood779 : H12WitnessSearch.Good tree779 := H12GlobalWitnessIndex.good

theorem leafIdentity779 : H12AffineFastState.composeSystem env779 rootObs = leafEnv779 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env779 rootObs == leafEnv779) = true)

theorem terminalChecked779 : H12PackedTerminal.terminalCheckFast leafEnv779 active779 tree779 = true := by decide +kernel

def env780 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,134217728,67130624,157794305,1073741824,140788817,4294967296,157663569,4417151346,131072,33563272]

theorem envBound780 : H12AffineFastState.Bounded env780 := by
  intro p hp
  have h : env780.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans529_780 : H12AffineEnvironment.transform 28 157794305 env529 = env780 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 28 157794305 env529 == env780) = true)

theorem identity780 : scanCanonicalize (H12AffineFastState.compose env780 (packedSelected [14] rootPS)) = affineNative (2^(25+1) ^^^ 16880644) := by decide +kernel

theorem selectedBound780 : packedSelected [14] rootPS < 2^1333 := by decide +kernel

def env781 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,16880644,134217728,16892164,157794305,1073741824,140788817,4294967296,157663569,4333368694,131072,33563272]

theorem envBound781 : H12AffineFastState.Bounded env781 := by
  intro p hp
  have h : env781.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans780_781 : H12AffineEnvironment.transform 25 16880644 env780 = env781 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 16880644 env780 == env781) = true)

def env782 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,8328,16880644,134217728,16892164,157794305,1073741824,140788817,4294967296,157663569,4299806206,131072,512]

theorem envBound782 : H12AffineFastState.Bounded env782 := by
  intro p hp
  have h : env782.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans781_782 : H12AffineEnvironment.transform 24 8328 env781 = env782 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8328 env781 == env782) = true)

theorem identity782 : scanCanonicalize (H12AffineFastState.compose env782 (packedSelected [1,3,10,19,24,26,28,31] rootPS)) = affineNative (2^(23+1) ^^^ 2199813) := by decide +kernel

theorem selectedBound782 : packedSelected [1,3,10,19,24,26,28,31] rootPS < 2^1333 := by decide +kernel

def env783 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,2199813,8328,2098433,134217728,2117633,138825988,1073741824,140788817,4294967296,138694740,4299806206,131072,512]

theorem envBound783 : H12AffineFastState.Bounded env783 := by
  intro p hp
  have h : env783.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans782_783 : H12AffineEnvironment.transform 23 2199813 env782 = env783 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 2199813 env782 == env783) = true)

theorem identity783 : scanCanonicalize (H12AffineFastState.compose env783 (packedSelected [0,1,4,5,6,7,8,13,16,17,19,20,21,22,24,25,26,33] rootPS)) = affineNative (2^(29+1) ^^^ 136801683) := by decide +kernel

theorem selectedBound783 : packedSelected [0,1,4,5,6,7,8,13,16,17,19,20,21,22,24,25,26,33] rootPS < 2^1333 := by decide +kernel

def env784 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,2199813,8328,2098433,134217728,2117633,138825988,136801683,140788817,4294967296,138694740,4299806206,131072,512]

theorem envBound784 : H12AffineFastState.Bounded env784 := by
  intro p hp
  have h : env784.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans783_784 : H12AffineEnvironment.transform 29 136801683 env783 = env784 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 136801683 env783 == env784) = true)

theorem identity784 : scanCanonicalize (H12AffineFastState.compose env784 (packedSelected [4,7,9,16,20,27,35] rootPS)) = affineNative (2^(16+1) ^^^ 62492) := by decide +kernel

theorem selectedBound784 : packedSelected [4,7,9,16,20,27,35] rootPS < 2^1333 := by decide +kernel

def env785 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,62492,262144,524288,32768,2097152,4194304,17664,2199813,8328,2098433,134217728,2117633,138716440,136681871,140788817,4294967296,138694740,4299806206,62492,512]

theorem envBound785 : H12AffineFastState.Bounded env785 := by
  intro p hp
  have h : env785.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans784_785 : H12AffineEnvironment.transform 16 62492 env784 = env785 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 62492 env784 == env785) = true)

theorem identity785 : scanCanonicalize (H12AffineFastState.compose env785 (packedSelected [6,12,15,17,21,25,38,41] rootPS)) = affineNative (2^(26+1) ^^^ 6557957) := by decide +kernel

theorem selectedBound785 : packedSelected [6,12,15,17,21,25,38,41] rootPS < 2^1333 := by decide +kernel

def env786 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,62492,262144,524288,32768,2097152,4194304,17664,2199813,8328,2098433,6557957,2117633,2143261,4294794,21844,4294967296,2113873,4299806206,62492,512]

theorem envBound786 : H12AffineFastState.Bounded env786 := by
  intro p hp
  have h : env786.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans785_786 : H12AffineEnvironment.transform 26 6557957 env785 = env786 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 6557957 env785 == env786) = true)

theorem identity786 : scanCanonicalize (H12AffineFastState.compose env786 (packedSelected [1,3,4,5,8,9,10,16,19] rootPS)) = affineNative (2^(21+1) ^^^ 20957) := by decide +kernel

theorem selectedBound786 : packedSelected [1,3,4,5,8,9,10,16,19] rootPS < 2^1333 := by decide +kernel

def env787 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,62492,262144,524288,32768,2097152,20957,17664,2199813,8328,2098433,2375896,2117633,2143261,121175,21844,4294967296,2113873,4295590947,62492,512]

theorem envBound787 : H12AffineFastState.Bounded env787 := by
  intro p hp
  have h : env787.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans786_787 : H12AffineEnvironment.transform 21 20957 env786 = env787 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 20957 env786 == env787) = true)

def env788 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,62492,262144,524288,32768,16464,20957,17664,119125,8328,17745,262280,4177,62541,121175,21844,4294967296,257,4295590947,62492,512]

theorem envBound788 : H12AffineFastState.Bounded env788 := by
  intro p hp
  have h : env788.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans787_788 : H12AffineEnvironment.transform 20 16464 env787 = env788 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 16464 env787 == env788) = true)

theorem identity788 : scanCanonicalize (H12AffineFastState.compose env788 (packedSelected [0,4,6,7,9,16,20] rootPS)) = affineNative (2^(31+1) ^^^ 116018) := by decide +kernel

theorem selectedBound788 : packedSelected [0,4,6,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env789 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,62492,262144,524288,32768,16464,20957,17664,119125,8328,17745,262280,4177,62541,121175,21844,116018,257,540945,62492,512]

theorem envBound789 : H12AffineFastState.Bounded env789 := by
  intro p hp
  have h : env789.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans788_789 : H12AffineEnvironment.transform 31 116018 env788 = env789 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 116018 env788 == env789) = true)

def env790 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,62492,262144,524288,32768,16465,20957,17664,119124,8328,17744,262281,4176,62540,121175,21844,4294967296,256,4295590947,62492,512]

theorem envBound790 : H12AffineFastState.Bounded env790 := by
  intro p hp
  have h : env790.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans787_790 : H12AffineEnvironment.transform 20 16465 env787 = env790 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 16465 env787 == env790) = true)

theorem identity790 : scanCanonicalize (H12AffineFastState.compose env790 (packedSelected [0,4,6,7,9,16,20] rootPS)) = affineNative (2^(31+1) ^^^ 103778) := by decide +kernel

theorem selectedBound790 : packedSelected [0,4,6,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env791 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,62492,262144,524288,32768,16465,20957,17664,119124,8328,17744,262281,4176,62540,121175,21844,103778,256,528705,62492,512]

theorem envBound791 : H12AffineFastState.Bounded env791 := by
  intro p hp
  have h : env791.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans790_791 : H12AffineEnvironment.transform 31 103778 env790 = env791 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 103778 env790 == env791) = true)

theorem identity791 : scanCanonicalize (H12AffineFastState.compose env791 (packedSelected [0,6,27] rootPS)) = affineNative (2^(14+1) ^^^ 8460) := by decide +kernel

theorem selectedBound791 : packedSelected [0,6,27] rootPS < 2^1333 := by decide +kernel

def env792 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8460,65536,21776,262144,524288,8460,16465,20957,17664,94296,8328,17744,262281,4176,21824,96347,21844,78958,256,528705,21776,512]

theorem envBound792 : H12AffineFastState.Bounded env792 := by
  intro p hp
  have h : env792.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans791_792 : H12AffineEnvironment.transform 14 8460 env791 = env792 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8460 env791 == env792) = true)

theorem identity792 : scanCanonicalize (H12AffineFastState.compose env792 (packedSelected [4,6,16,22] rootPS)) = affineNative (2^(13+1) ^^^ 4177) := by decide +kernel

theorem selectedBound792 : packedSelected [4,6,16,22] rootPS < 2^1333 := by decide +kernel

def env793 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,8460,65536,1345,262144,524288,8460,4096,396,5457,73737,8328,5377,262281,4176,1297,75786,1285,78958,256,528705,1345,512]

theorem envBound793 : H12AffineFastState.Bounded env793 := by
  intro p hp
  have h : env793.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans792_793 : H12AffineEnvironment.transform 13 4177 env792 = env793 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env792 == env793) = true)

theorem identity793 : scanCanonicalize (H12AffineFastState.compose env793 (packedSelected [6] rootPS)) = affineNative (2^(12+1) ^^^ 5448) := by decide +kernel

theorem selectedBound793 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env794 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,5448,4177,5188,65536,1345,262144,524288,5188,4096,396,5457,70977,5568,5377,262281,4176,1297,73026,1285,65830,256,528705,1345,512]

theorem envBound794 : H12AffineFastState.Bounded env794 := by
  intro p hp
  have h : env794.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans793_794 : H12AffineEnvironment.transform 12 5448 env793 = env794 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5448 env793 == env794) = true)

theorem identity794 : scanCanonicalize (H12AffineFastState.compose env794 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(18+1) ^^^ 1025) := by decide +kernel

theorem selectedBound794 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env795 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,5448,4177,5188,65536,1345,262144,1025,5188,4096,396,5457,70977,5568,5377,262281,4176,1297,73026,1285,65830,256,5440,1345,512]

theorem envBound795 : H12AffineFastState.Bounded env795 := by
  intro p hp
  have h : env795.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans794_795 : H12AffineEnvironment.transform 18 1025 env794 = env795 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env794 == env795) = true)

theorem identity795 : scanCanonicalize (H12AffineFastState.compose env795 (packedSelected [3,5,10] rootPS)) = affineNative (2^(15+1) ^^^ 4842) := by decide +kernel

theorem selectedBound795 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env796 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,5448,4177,5188,4842,1345,262144,1025,5188,4096,396,5457,1963,5568,5377,262281,4176,1297,4008,1285,5068,256,5440,1345,512]

theorem envBound796 : H12AffineFastState.Bounded env796 := by
  intro p hp
  have h : env796.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans795_796 : H12AffineEnvironment.transform 15 4842 env795 = env796 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 4842 env795 == env796) = true)

theorem identity796 : scanCanonicalize (H12AffineFastState.compose env796 (packedSelected [1,8,12] rootPS)) = affineNative (2^(17+1) ^^^ 4667) := by decide +kernel

theorem selectedBound796 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env797 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,5448,4177,5188,4842,1345,4667,1025,5188,4096,396,5457,1963,5568,5377,4786,4176,1297,4008,1285,5068,256,5440,1345,512]

theorem envBound797 : H12AffineFastState.Bounded env797 := by
  intro p hp
  have h : env797.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans796_797 : H12AffineEnvironment.transform 17 4667 env796 = env797 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 4667 env796 == env797) = true)

theorem identity797 : scanCanonicalize (H12AffineFastState.compose env797 (packedSelected [3,5,8,13,24] rootPS)) = affineNative (2^(11+1) ^^^ 1992) := by decide +kernel

theorem selectedBound797 : packedSelected [3,5,8,13,24] rootPS < 2^1333 := by decide +kernel

def env798 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1992,640,1945,908,1314,1345,1523,1025,908,1992,396,665,1963,520,713,1402,1944,1297,4008,1285,1028,256,648,1345,512]

theorem envBound798 : H12AffineFastState.Bounded env798 := by
  intro p hp
  have h : env798.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans797_798 : H12AffineEnvironment.transform 11 1992 env797 = env798 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1992 env797 == env798) = true)

theorem identity798 : scanCanonicalize (H12AffineFastState.compose env798 (packedSelected [8,13] rootPS)) = affineNative (2^(8+1) ^^^ 396) := by decide +kernel

theorem selectedBound798 : packedSelected [8,13] rootPS < 2^1333 := by decide +kernel

def env799 : List Nat := [2,4,8,16,32,64,128,256,396,1024,2048,1092,268,1045,0,1314,1345,1523,1025,0,1092,396,277,1063,388,325,1402,1044,1297,3108,1285,1028,256,260,1345,396]

theorem envBound799 : H12AffineFastState.Bounded env799 := by
  intro p hp
  have h : env799.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans798_799 : H12AffineEnvironment.transform 8 396 env798 = env799 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 396 env798 == env799) = true)

def env800 : List Nat := [2,4,8,16,32,64,128,256,396,1024,0,1092,268,1045,0,1314,1345,1523,1025,0,1092,396,277,1063,388,325,1402,1044,1297,1060,1285,1028,256,260,1345,396]

theorem envBound800 : H12AffineFastState.Bounded env800 := by
  intro p hp
  have h : env800.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans799_800 : H12AffineEnvironment.transform 10 0 env799 = env800 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env799 == env800) = true)

theorem identity800 : scanCanonicalize (H12AffineFastState.compose env800 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 106) := by decide +kernel

theorem selectedBound800 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env801 : List Nat := [2,4,8,16,32,64,106,256,358,1024,0,1092,268,1045,0,1314,1345,1305,1025,0,1092,358,277,1063,366,325,1402,1044,1297,1060,1285,1028,256,260,1345,358]

theorem envBound801 : H12AffineFastState.Bounded env801 := by
  intro p hp
  have h : env801.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans800_801 : H12AffineEnvironment.transform 6 106 env800 = env801 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 106 env800 == env801) = true)

theorem identity801 : scanCanonicalize (H12AffineFastState.compose env801 (packedSelected [7,11] rootPS)) = affineNative (2^(9+1) ^^^ 379) := by decide +kernel

theorem selectedBound801 : packedSelected [7,11] rootPS < 2^1333 := by decide +kernel

def env802 : List Nat := [2,4,8,16,32,64,106,256,358,379,0,319,268,366,0,89,58,98,378,0,319,358,277,348,366,325,1,367,106,351,126,383,256,260,58,358]

theorem envBound802 : H12AffineFastState.Bounded env802 := by
  intro p hp
  have h : env802.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans801_802 : H12AffineEnvironment.transform 9 379 env801 = env802 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 379 env801 == env802) = true)

theorem identity802 : scanCanonicalize (H12AffineFastState.compose env802 (packedSelected [7] rootPS)) = affineNative (2^(5+1) ^^^ 58) := by decide +kernel

theorem selectedBound802 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env803 : List Nat := [2,4,8,16,32,58,16,256,284,257,0,319,268,276,0,35,58,24,256,0,319,284,277,294,276,319,1,277,16,293,4,261,256,260,58,284]

theorem envBound803 : H12AffineFastState.Bounded env803 := by
  intro p hp
  have h : env803.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans802_803 : H12AffineEnvironment.transform 5 58 env802 = env803 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 58 env802 == env803) = true)

theorem identity803 : scanCanonicalize (H12AffineFastState.compose env803 (packedSelected [4,9] rootPS)) = affineNative (2^(7+1) ^^^ 60) := by decide +kernel

theorem selectedBound803 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env804 : List Nat := [2,4,8,16,32,58,16,60,32,61,0,3,48,40,0,35,58,24,60,0,3,32,41,26,40,3,1,41,16,25,4,57,60,56,58,32]

theorem envBound804 : H12AffineFastState.Bounded env804 := by
  intro p hp
  have h : env804.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans803_804 : H12AffineEnvironment.transform 7 60 env803 = env804 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 60 env803 == env804) = true)

def env805 : List Nat := [2,4,8,8,32,34,8,36,32,37,0,3,40,40,0,35,34,0,36,0,3,32,41,2,40,3,1,41,8,1,4,33,36,32,34,32]

theorem envBound805 : H12AffineFastState.Bounded env805 := by
  intro p hp
  have h : env805.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans804_805 : H12AffineEnvironment.transform 3 8 env804 = env805 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 8 env804 == env805) = true)

theorem identity805 : scanCanonicalize (H12AffineFastState.compose env805 (packedSelected [1] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound805 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env806 : List Nat := [2,4,3,3,32,34,3,36,32,37,0,3,35,35,0,35,34,0,36,0,3,32,34,2,35,3,1,34,3,1,4,33,36,32,34,32]

theorem envBound806 : H12AffineFastState.Bounded env806 := by
  intro p hp
  have h : env806.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans805_806 : H12AffineEnvironment.transform 2 3 env805 = env806 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env805 == env806) = true)

def env807 : List Nat := [2,4,8,9,32,35,9,37,32,36,0,3,41,40,0,35,35,1,37,0,3,32,41,3,40,3,1,41,9,0,4,32,37,33,35,32]

theorem envBound807 : H12AffineFastState.Bounded env807 := by
  intro p hp
  have h : env807.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans804_807 : H12AffineEnvironment.transform 3 9 env804 = env807 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 9 env804 == env807) = true)

def env808 : List Nat := [2,4,8,9,0,3,9,5,0,4,0,3,9,8,0,3,3,1,5,0,3,0,9,3,8,3,1,9,9,0,4,0,5,1,3,0]

theorem envBound808 : H12AffineFastState.Bounded env808 := by
  intro p hp
  have h : env808.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans807_808 : H12AffineEnvironment.transform 4 0 env807 = env808 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env807 == env808) = true)

theorem identity808 : scanCanonicalize (H12AffineFastState.compose env808 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound808 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env809 : List Nat := [2,4,3,2,0,3,2,5,0,4,0,3,2,3,0,3,3,1,5,0,3,0,2,3,3,3,1,2,2,0,4,0,5,1,3,0]

theorem envBound809 : H12AffineFastState.Bounded env809 := by
  intro p hp
  have h : env809.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans808_809 : H12AffineEnvironment.transform 2 3 env808 = env809 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env808 == env809) = true)

def leafEnv809 : List Nat := [2,4,3,2,0,3,2,5,0,4,0,3,2,3,0,3,3,1,5,0,3,0,2,3,5,3,1,3,1,2,2,0,4,0,5,1,4,2,3,0,0,3,1]

def active809 : List Nat := [0,1]

def tree809 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood809 : H12WitnessSearch.Good tree809 := H12GlobalWitnessIndex.good

theorem leafIdentity809 : H12AffineFastState.composeSystem env809 rootObs = leafEnv809 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env809 rootObs == leafEnv809) = true)

theorem terminalChecked809 : H12PackedTerminal.terminalCheckFast leafEnv809 active809 tree809 = true := by decide +kernel

def env810 : List Nat := [2,4,8,9,1,2,9,4,1,5,0,3,8,9,0,2,2,1,4,0,3,1,8,3,9,3,1,8,9,0,4,1,4,0,2,1]

theorem envBound810 : H12AffineFastState.Bounded env810 := by
  intro p hp
  have h : env810.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans807_810 : H12AffineEnvironment.transform 4 1 env807 = env810 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env807 == env810) = true)

def env811 : List Nat := [2,4,8,16,32,64,128,256,396,1024,1,1092,268,1045,0,1314,1345,1523,1025,0,1092,396,277,1063,388,325,1402,1044,1297,1061,1285,1028,256,260,1345,396]

theorem envBound811 : H12AffineFastState.Bounded env811 := by
  intro p hp
  have h : env811.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans799_811 : H12AffineEnvironment.transform 10 1 env799 = env811 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env799 == env811) = true)

theorem identity811 : scanCanonicalize (H12AffineFastState.compose env811 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 207) := by decide +kernel

theorem selectedBound811 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env812 : List Nat := [2,4,8,16,32,64,128,256,396,207,1,139,268,218,0,493,398,316,206,0,139,396,277,232,388,325,437,219,478,234,458,203,256,260,398,396]

theorem envBound812 : H12AffineFastState.Bounded env812 := by
  intro p hp
  have h : env812.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans811_812 : H12AffineEnvironment.transform 9 207 env811 = env812 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 207 env811 == env812) = true)

theorem identity812 : scanCanonicalize (H12AffineFastState.compose env812 (packedSelected [7,11] rootPS)) = affineNative (2^(5+1) ^^^ 59) := by decide +kernel

theorem selectedBound812 : packedSelected [7,11] rootPS < 2^1333 := by decide +kernel

def env813 : List Nat := [2,4,8,16,32,59,128,256,396,180,1,139,268,161,0,406,398,316,181,0,139,396,277,147,388,318,437,160,421,145,433,176,256,260,398,396]

theorem envBound813 : H12AffineFastState.Bounded env813 := by
  intro p hp
  have h : env813.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans812_813 : H12AffineEnvironment.transform 5 59 env812 = env813 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 59 env812 == env813) = true)

theorem identity813 : scanCanonicalize (H12AffineFastState.compose env813 (packedSelected [4,7,9,18] rootPS)) = affineNative (2^(3+1) ^^^ 9) := by decide +kernel

theorem selectedBound813 : packedSelected [4,7,9,18] rootPS < 2^1333 := by decide +kernel

def env814 : List Nat := [2,4,8,9,32,34,128,256,396,173,1,139,268,161,0,399,398,293,172,0,139,396,268,138,388,295,428,160,421,136,424,169,256,260,398,396]

theorem envBound814 : H12AffineFastState.Bounded env814 := by
  intro p hp
  have h : env814.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans813_814 : H12AffineEnvironment.transform 3 9 env813 = env814 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 9 env813 == env814) = true)

def env815 : List Nat := [2,4,8,9,32,34,128,36,168,173,1,139,40,161,0,171,170,1,172,0,139,168,40,138,160,3,136,160,129,136,140,169,36,32,170,168]

theorem envBound815 : H12AffineFastState.Bounded env815 := by
  intro p hp
  have h : env815.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans814_815 : H12AffineEnvironment.transform 7 36 env814 = env815 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env814 == env815) = true)

def env816 : List Nat := [2,4,8,9,0,2,128,4,136,141,1,139,8,129,0,139,138,1,140,0,139,136,8,138,128,3,136,128,129,136,140,137,4,0,138,136]

theorem envBound816 : H12AffineFastState.Bounded env816 := by
  intro p hp
  have h : env816.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans815_816 : H12AffineEnvironment.transform 4 0 env815 = env816 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env815 == env816) = true)

theorem identity816 : scanCanonicalize (H12AffineFastState.compose env816 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound816 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env817 : List Nat := [2,4,8,9,0,2,9,4,1,4,1,2,8,8,0,2,3,1,5,0,2,1,8,3,9,3,1,9,8,1,5,0,4,0,3,1]

theorem envBound817 : H12AffineFastState.Bounded env817 := by
  intro p hp
  have h : env817.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans816_817 : H12AffineEnvironment.transform 6 9 env816 = env817 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env816 == env817) = true)

def leafEnv817 : List Nat := [2,4,8,9,0,2,9,4,1,4,1,2,8,8,0,2,3,1,5,0,2,1,8,3,4,9,1,3,1,9,8,1,5,0,4,0,4,3,3,1,0,9,1]

def active817 : List Nat := [0,1,2]

def tree817 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood817 : H12WitnessSearch.Good tree817 := H12GlobalWitnessIndex.good

theorem leafIdentity817 : H12AffineFastState.composeSystem env817 rootObs = leafEnv817 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env817 rootObs == leafEnv817) = true)

theorem terminalChecked817 : H12PackedTerminal.terminalCheckFast leafEnv817 active817 tree817 = true := by decide +kernel

def env818 : List Nat := [2,4,8,9,1,3,128,5,137,140,1,139,9,128,0,138,139,1,141,0,139,137,9,138,129,3,136,129,129,136,140,136,5,1,139,137]

theorem envBound818 : H12AffineFastState.Bounded env818 := by
  intro p hp
  have h : env818.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans815_818 : H12AffineEnvironment.transform 4 1 env815 = env818 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env815 == env818) = true)

theorem identity818 : scanCanonicalize (H12AffineFastState.compose env818 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound818 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env819 : List Nat := [2,4,8,9,1,3,3,5,10,15,1,8,9,3,0,9,8,1,14,0,8,10,9,9,2,3,11,2,2,11,15,11,5,1,8,10]

theorem envBound819 : H12AffineFastState.Bounded env819 := by
  intro p hp
  have h : env819.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans818_819 : H12AffineEnvironment.transform 6 3 env818 = env819 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env818 == env819) = true)

theorem identity819 : scanCanonicalize (H12AffineFastState.compose env819 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound819 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env820 : List Nat := [2,4,2,3,1,3,3,5,0,5,1,2,3,3,0,3,2,1,4,0,2,0,3,3,2,3,1,2,2,1,5,1,5,1,2,0]

theorem envBound820 : H12AffineFastState.Bounded env820 := by
  intro p hp
  have h : env820.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans819_820 : H12AffineEnvironment.transform 2 2 env819 = env820 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env819 == env820) = true)

def leafEnv820 : List Nat := [2,4,2,3,1,3,3,5,0,5,1,2,3,3,0,3,2,1,4,0,2,0,3,3,4,2,1,3,1,2,2,1,5,1,5,1,4,2,2,0,0,3,1]

def active820 : List Nat := [0,1]

def tree820 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood820 : H12WitnessSearch.Good tree820 := H12GlobalWitnessIndex.good

theorem leafIdentity820 : H12AffineFastState.composeSystem env820 rootObs = leafEnv820 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env820 rootObs == leafEnv820) = true)

theorem terminalChecked820 : H12PackedTerminal.terminalCheckFast leafEnv820 active820 tree820 = true := by decide +kernel

def env821 : List Nat := [2,4,8,9,32,34,128,37,169,173,1,139,41,161,0,170,171,0,172,0,139,169,41,138,161,2,137,160,128,136,141,169,37,33,171,169]

theorem envBound821 : H12AffineFastState.Bounded env821 := by
  intro p hp
  have h : env821.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans814_821 : H12AffineEnvironment.transform 7 37 env814 = env821 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env814 == env821) = true)

theorem identity821 : scanCanonicalize (H12AffineFastState.compose env821 (packedSelected [1] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound821 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env822 : List Nat := [2,4,3,2,32,34,128,37,162,166,1,128,34,161,0,161,160,0,167,0,128,162,34,129,161,2,130,160,128,131,134,162,37,33,160,162]

theorem envBound822 : H12AffineFastState.Bounded env822 := by
  intro p hp
  have h : env822.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans821_822 : H12AffineEnvironment.transform 2 3 env821 = env822 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env821 == env822) = true)

def env823 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,8329,16880644,134217728,16892164,157794305,1073741824,140788817,4294967296,157663569,4299806207,131072,513]

theorem envBound823 : H12AffineFastState.Bounded env823 := by
  intro p hp
  have h : env823.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans781_823 : H12AffineEnvironment.transform 24 8329 env781 = env823 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env781 == env823) = true)

def env824 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,8329,16880644,21352528,16892164,2232401,1073741824,18977793,4294967296,2101505,4299806207,131072,513]

theorem envBound824 : H12AffineFastState.Bounded env824 := by
  intro p hp
  have h : env824.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans823_824 : H12AffineEnvironment.transform 26 21352528 env823 = env824 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 21352528 env823 == env824) = true)

theorem identity824 : scanCanonicalize (H12AffineFastState.compose env824 (packedSelected [0,3,4,6,7,10,16,20,22,24,25,26] rootPS)) = affineNative (2^(23+1) ^^^ 230468) := by decide +kernel

theorem selectedBound824 : packedSelected [0,3,4,6,7,10,16,20,22,24,25,26] rootPS < 2^1333 := by decide +kernel

def env825 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,230468,8329,135232,4609044,148800,2232401,1073741824,2232389,4294967296,2101505,4299806207,131072,513]

theorem envBound825 : H12AffineFastState.Bounded env825 := by
  intro p hp
  have h : env825.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans824_825 : H12AffineEnvironment.transform 23 230468 env824 = env825 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230468 env824 == env825) = true)

theorem identity825 : scanCanonicalize (H12AffineFastState.compose env825 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(20+1) ^^^ 137160) := by decide +kernel

theorem selectedBound825 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env826 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,137160,4194304,17664,230468,8329,135232,4609044,148800,1945,1073741824,1933,4294967296,132809,4299806207,131072,513]

theorem envBound826 : H12AffineFastState.Bounded env826 := by
  intro p hp
  have h : env826.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans825_826 : H12AffineEnvironment.transform 20 137160 env825 = env826 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 137160 env825 == env826) = true)

def env827 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,524288,32768,4744,4194304,17664,98564,8329,5376,4477268,16384,1945,1073741824,1933,4294967296,905,4299806207,1344,513]

theorem envBound827 : H12AffineFastState.Bounded env827 := by
  intro p hp
  have h : env827.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans826_827 : H12AffineEnvironment.transform 16 1344 env826 = env827 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env826 == env827) = true)

theorem identity827 : scanCanonicalize (H12AffineFastState.compose env827 (packedSelected [0,27] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound827 : packedSelected [0,27] rootPS < 2^1333 := by decide +kernel

def env828 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,16384,32768,65536,1344,262144,524288,32768,4097,4194304,17664,98564,8329,5376,4477268,16384,1296,1073741824,1284,4294967296,256,4299806207,1344,136]

theorem envBound828 : H12AffineFastState.Bounded env828 := by
  intro p hp
  have h : env828.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans827_828 : H12AffineEnvironment.transform 8 137 env827 = env828 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env827 == env828) = true)

theorem identity828 : scanCanonicalize (H12AffineFastState.compose env828 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(17+1) ^^^ 43049) := by decide +kernel

theorem selectedBound828 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env829 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,16384,32768,65536,1344,43049,524288,32768,4097,4194304,17664,98564,8329,5376,4258173,16384,1296,1073741824,1284,4294967296,256,4299806207,1344,136]

theorem envBound829 : H12AffineFastState.Bounded env829 := by
  intro p hp
  have h : env829.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans828_829 : H12AffineEnvironment.transform 17 43049 env828 = env829 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43049 env828 == env829) = true)

theorem identity829 : scanCanonicalize (H12AffineFastState.compose env829 (packedSelected [1,4,8,9,13,16,19,21] rootPS)) = affineNative (2^(29+1) ^^^ 4840667) := by decide +kernel

theorem selectedBound829 : packedSelected [1,4,8,9,13,16,19,21] rootPS < 2^1333 := by decide +kernel

def env830 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,16384,32768,65536,1344,43049,524288,32768,4097,4194304,17664,98564,8329,5376,4258173,16384,1296,4840667,1284,4294967296,256,4299806207,1344,136]

theorem envBound830 : H12AffineFastState.Bounded env830 := by
  intro p hp
  have h : env830.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans829_830 : H12AffineEnvironment.transform 29 4840667 env829 = env830 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4840667 env829 == env830) = true)

theorem identity830 : scanCanonicalize (H12AffineFastState.compose env830 (packedSelected [1,3,4,5,8,9,10,16,19] rootPS)) = affineNative (2^(13+1) ^^^ 4177) := by decide +kernel

theorem selectedBound830 : packedSelected [1,3,4,5,8,9,10,16,19] rootPS < 2^1333 := by decide +kernel

def env831 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4177,32768,65536,1344,43049,524288,32768,4097,4194304,5457,98564,8329,5376,4237612,4177,1296,4820106,1284,4294967296,256,4299785646,1344,136]

theorem envBound831 : H12AffineFastState.Bounded env831 := by
  intro p hp
  have h : env831.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans830_831 : H12AffineEnvironment.transform 13 4177 env830 = env831 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env830 == env831) = true)

theorem identity831 : scanCanonicalize (H12AffineFastState.compose env831 (packedSelected [0,4,7,9,18,23] rootPS)) = affineNative (2^(18+1) ^^^ 99726) := by decide +kernel

theorem selectedBound831 : packedSelected [0,4,7,9,18,23] rootPS < 2^1333 := by decide +kernel

def env832 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4177,32768,65536,1344,43049,99726,32768,4097,4194304,5457,98564,8329,5376,4237612,4177,1296,4196612,1284,4294967296,256,4299161632,1344,136]

theorem envBound832 : H12AffineFastState.Bounded env832 := by
  intro p hp
  have h : env832.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans831_832 : H12AffineEnvironment.transform 18 99726 env831 = env832 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 99726 env831 == env832) = true)

def env833 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4177,32768,65536,1344,43049,99726,32768,4097,10248,5457,98564,8329,5376,33060,4177,1296,8460,1284,4294967296,256,4294977576,1344,136]

theorem envBound833 : H12AffineFastState.Bounded env833 := by
  intro p hp
  have h : env833.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans832_833 : H12AffineEnvironment.transform 21 10248 env832 = env833 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10248 env832 == env833) = true)

theorem identity833 : scanCanonicalize (H12AffineFastState.compose env833 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(12+1) ^^^ 2317) := by decide +kernel

theorem selectedBound833 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env834 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,2317,4177,32768,65536,1344,33060,99726,32768,4097,261,5457,98564,2436,5376,33060,4177,1296,2049,1284,4294967296,256,4294967589,1344,136]

theorem envBound834 : H12AffineFastState.Bounded env834 := by
  intro p hp
  have h : env834.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans833_834 : H12AffineEnvironment.transform 12 2317 env833 = env834 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2317 env833 == env834) = true)

theorem identity834 : scanCanonicalize (H12AffineFastState.compose env834 (packedSelected [0,7] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound834 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env835 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1297,2317,1344,32768,65536,1344,33060,99726,32768,1296,261,64,98564,2436,17,33060,1344,1296,2049,1284,4294967296,256,4294967589,1344,136]

theorem envBound835 : H12AffineFastState.Bounded env835 := by
  intro p hp
  have h : env835.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans834_835 : H12AffineEnvironment.transform 11 1297 env834 = env835 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env834 == env835) = true)

theorem identity835 : scanCanonicalize (H12AffineFastState.compose env835 (packedSelected [2,3,4,10] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound835 : packedSelected [2,3,4,10] rootPS < 2^1333 := by decide +kernel

def env836 : List Nat := [2,4,8,16,32,64,128,37,137,1024,2048,1076,2088,1125,32768,65536,1125,32769,99499,32768,1077,32,64,98337,2209,17,32769,1125,1077,2049,1057,4294967296,37,4294967296,1125,136]

theorem envBound836 : H12AffineFastState.Bounded env836 := by
  intro p hp
  have h : env836.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans835_836 : H12AffineEnvironment.transform 7 37 env835 = env836 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env835 == env836) = true)

theorem identity836 : scanCanonicalize (H12AffineFastState.compose env836 (packedSelected [1,3,4] rootPS)) = affineNative (2^(31+1) ^^^ 35001) := by decide +kernel

theorem selectedBound836 : packedSelected [1,3,4] rootPS < 2^1333 := by decide +kernel

def env837 : List Nat := [2,4,8,16,32,64,128,37,137,1024,2048,1076,2088,1125,32768,65536,1125,32769,99499,32768,1077,32,64,98337,2209,17,32769,1125,1077,2049,1057,35001,37,35001,1125,136]

theorem envBound837 : H12AffineFastState.Bounded env837 := by
  intro p hp
  have h : env837.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans836_837 : H12AffineEnvironment.transform 31 35001 env836 = env837 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 35001 env836 == env837) = true)

theorem identity837 : scanCanonicalize (H12AffineFastState.compose env837 (packedSelected [1,3,12] rootPS)) = affineNative (2^(14+1) ^^^ 2048) := by decide +kernel

theorem selectedBound837 : packedSelected [1,3,12] rootPS < 2^1333 := by decide +kernel

def env838 : List Nat := [2,4,8,16,32,64,128,37,137,1024,2048,1076,2088,1125,2048,65536,1125,2049,68779,2048,1077,32,64,67617,2209,17,2049,1125,1077,2049,1057,185,37,185,1125,136]

theorem envBound838 : H12AffineFastState.Bounded env838 := by
  intro p hp
  have h : env838.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans837_838 : H12AffineEnvironment.transform 14 2048 env837 = env838 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2048 env837 == env838) = true)

def env839 : List Nat := [2,4,8,16,32,64,128,37,137,1024,0,1076,40,1125,0,65536,1125,1,66731,0,1077,32,64,65569,161,17,1,1125,1077,1,1057,185,37,185,1125,136]

theorem envBound839 : H12AffineFastState.Bounded env839 := by
  intro p hp
  have h : env839.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans838_839 : H12AffineEnvironment.transform 10 0 env838 = env839 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env838 == env839) = true)

theorem identity839 : scanCanonicalize (H12AffineFastState.compose env839 (packedSelected [0] rootPS)) = affineNative (2^(15+1) ^^^ 225) := by decide +kernel

theorem selectedBound839 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env840 : List Nat := [2,4,8,16,32,64,128,37,137,1024,0,1076,40,1125,0,225,1125,1,1098,0,1077,32,64,192,161,17,1,1125,1077,1,1057,185,37,185,1125,136]

theorem envBound840 : H12AffineFastState.Bounded env840 := by
  intro p hp
  have h : env840.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans839_840 : H12AffineEnvironment.transform 15 225 env839 = env840 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 225 env839 == env840) = true)

theorem identity840 : scanCanonicalize (H12AffineFastState.compose env840 (packedSelected [2,3] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound840 : packedSelected [2,3] rootPS < 2^1333 := by decide +kernel

def env841 : List Nat := [2,4,8,16,32,11,128,37,137,1024,0,1076,40,1070,0,170,1070,1,1025,0,1077,32,11,139,161,17,1,1070,1077,1,1057,185,37,185,1070,136]

theorem envBound841 : H12AffineFastState.Bounded env841 := by
  intro p hp
  have h : env841.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans840_841 : H12AffineEnvironment.transform 5 11 env840 = env841 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env840 == env841) = true)

theorem identity841 : scanCanonicalize (H12AffineFastState.compose env841 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 18) := by decide +kernel

theorem selectedBound841 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env842 : List Nat := [2,4,8,16,32,11,18,37,27,1024,0,1076,40,1070,0,56,1070,1,1025,0,1077,32,11,25,51,17,1,1070,1077,1,1057,43,37,43,1070,26]

theorem envBound842 : H12AffineFastState.Bounded env842 := by
  intro p hp
  have h : env842.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans841_842 : H12AffineEnvironment.transform 6 18 env841 = env842 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 18 env841 == env842) = true)

def leafEnv842 : List Nat := [2,4,8,16,32,11,18,37,27,1024,0,1076,40,1070,0,56,1070,1,1025,0,1077,32,11,25,1056,51,1,17,1,1070,1077,1,1057,43,37,43,4,34,1070,26,0,1076,1]

def active842 : List Nat := [0,1,2,3,4,9]

def tree842 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood842 : H12WitnessSearch.Good tree842 := H12GlobalWitnessIndex.good

theorem leafIdentity842 : H12AffineFastState.composeSystem env842 rootObs = leafEnv842 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env842 rootObs == leafEnv842) = true)

theorem terminalChecked842 : H12PackedTerminal.terminalCheckFast leafEnv842 active842 tree842 = true := by decide +kernel

def env843 : List Nat := [2,4,8,16,32,64,128,37,137,1024,1,1076,41,1125,1,65536,1125,0,66730,1,1077,32,64,65568,160,17,0,1125,1077,0,1057,185,37,185,1125,136]

theorem envBound843 : H12AffineFastState.Bounded env843 := by
  intro p hp
  have h : env843.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans838_843 : H12AffineEnvironment.transform 10 1 env838 = env843 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env838 == env843) = true)

theorem identity843 : scanCanonicalize (H12AffineFastState.compose env843 (packedSelected [0] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound843 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env844 : List Nat := [2,4,8,16,32,11,128,37,137,1024,1,1076,41,1070,1,65536,1070,0,66730,1,1077,32,11,65568,160,17,0,1070,1077,0,1057,185,37,185,1070,136]

theorem envBound844 : H12AffineFastState.Bounded env844 := by
  intro p hp
  have h : env844.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans843_844 : H12AffineEnvironment.transform 5 11 env843 = env844 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env843 == env844) = true)

def env845 : List Nat := [2,4,8,16,0,11,128,5,137,1024,1,1044,9,1038,1,65536,1038,0,66698,1,1045,0,11,65536,128,17,0,1038,1045,0,1025,153,5,153,1038,136]

theorem envBound845 : H12AffineFastState.Bounded env845 := by
  intro p hp
  have h : env845.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans844_845 : H12AffineEnvironment.transform 4 0 env844 = env845 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env844 == env845) = true)

theorem identity845 : scanCanonicalize (H12AffineFastState.compose env845 (packedSelected [1] rootPS)) = affineNative (2^(15+1) ^^^ 25) := by decide +kernel

theorem selectedBound845 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env846 : List Nat := [2,4,8,16,0,11,128,5,137,1024,1,1044,9,1038,1,25,1038,0,1171,1,1045,0,11,25,128,17,0,1038,1045,0,1025,153,5,153,1038,136]

theorem envBound846 : H12AffineFastState.Bounded env846 := by
  intro p hp
  have h : env846.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans845_846 : H12AffineEnvironment.transform 15 25 env845 = env846 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 25 env845 == env846) = true)

def leafEnv846 : List Nat := [2,4,8,16,0,11,128,5,137,1024,1,1044,9,1038,1,25,1038,0,1171,1,1045,0,11,25,1170,128,1,17,0,1038,1045,0,1025,153,5,153,4,3,1038,136,0,1044,1]

def active846 : List Nat := [0,1,2,3,6,9]

def tree846 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood846 : H12WitnessSearch.Good tree846 := H12GlobalWitnessIndex.good

theorem leafIdentity846 : H12AffineFastState.composeSystem env846 rootObs = leafEnv846 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env846 rootObs == leafEnv846) = true)

theorem terminalChecked846 : H12PackedTerminal.terminalCheckFast leafEnv846 active846 tree846 = true := by decide +kernel

def env847 : List Nat := [2,4,8,16,1,11,128,4,137,1024,1,1045,8,1039,1,65536,1039,0,66699,1,1044,1,11,65537,129,17,0,1039,1044,0,1024,152,4,152,1039,136]

theorem envBound847 : H12AffineFastState.Bounded env847 := by
  intro p hp
  have h : env847.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans844_847 : H12AffineEnvironment.transform 4 1 env844 = env847 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env844 == env847) = true)

theorem identity847 : scanCanonicalize (H12AffineFastState.compose env847 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 18) := by decide +kernel

theorem selectedBound847 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env848 : List Nat := [2,4,8,16,1,11,18,4,27,1024,1,1045,8,1039,1,65536,1039,0,66585,1,1044,1,11,65537,19,17,0,1039,1044,0,1024,10,4,10,1039,26]

theorem envBound848 : H12AffineFastState.Bounded env848 := by
  intro p hp
  have h : env848.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans847_848 : H12AffineEnvironment.transform 6 18 env847 = env848 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 18 env847 == env848) = true)

theorem identity848 : scanCanonicalize (H12AffineFastState.compose env848 (packedSelected [2] rootPS)) = affineNative (2^(15+1) ^^^ 24) := by decide +kernel

theorem selectedBound848 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env849 : List Nat := [2,4,8,16,1,11,18,4,27,1024,1,1045,8,1039,1,24,1039,0,1025,1,1044,1,11,25,19,17,0,1039,1044,0,1024,10,4,10,1039,26]

theorem envBound849 : H12AffineFastState.Bounded env849 := by
  intro p hp
  have h : env849.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans848_849 : H12AffineEnvironment.transform 15 24 env848 = env849 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 24 env848 == env849) = true)

def leafEnv849 : List Nat := [2,4,8,16,1,11,18,4,27,1024,1,1045,8,1039,1,24,1039,0,1025,1,1044,1,11,25,1025,19,1,17,0,1039,1044,0,1024,10,4,10,4,2,1039,26,0,1045,1]

def active849 : List Nat := [0,1,2,3,9]

def tree849 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood849 : H12WitnessSearch.Good tree849 := H12GlobalWitnessIndex.good

theorem leafIdentity849 : H12AffineFastState.composeSystem env849 rootObs = leafEnv849 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env849 rootObs == leafEnv849) = true)

theorem terminalChecked849 : H12PackedTerminal.terminalCheckFast leafEnv849 active849 tree849 = true := by decide +kernel

def env850 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4177,32768,65536,1344,43049,99726,32768,4097,10249,5457,98564,8329,5376,33061,4177,1296,8461,1284,4294967296,256,4294977577,1344,136]

theorem envBound850 : H12AffineFastState.Bounded env850 := by
  intro p hp
  have h : env850.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans832_850 : H12AffineEnvironment.transform 21 10249 env832 = env850 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10249 env832 == env850) = true)

theorem identity850 : scanCanonicalize (H12AffineFastState.compose env850 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(14+1) ^^^ 8233) := by decide +kernel

theorem selectedBound850 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env851 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4177,8233,65536,1344,2048,75175,8233,4097,10249,5457,74029,8329,5376,8460,4177,1296,8461,1284,4294967296,256,4294977577,1344,136]

theorem envBound851 : H12AffineFastState.Bounded env851 := by
  intro p hp
  have h : env851.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans850_851 : H12AffineEnvironment.transform 14 8233 env850 = env851 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8233 env850 == env851) = true)

theorem identity851 : scanCanonicalize (H12AffineFastState.compose env851 (packedSelected [0,7] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound851 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env852 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1296,8192,1345,8233,65536,1344,2048,75175,8233,1297,10249,65,74029,8329,16,8460,1345,1296,8461,1284,4294967296,256,4294977577,1344,136]

theorem envBound852 : H12AffineFastState.Bounded env852 := by
  intro p hp
  have h : env852.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans851_852 : H12AffineEnvironment.transform 11 1296 env851 = env852 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env851 == env852) = true)

theorem identity852 : scanCanonicalize (H12AffineFastState.compose env852 (packedSelected [1,2,3,4,5,10,13] rootPS)) = affineNative (2^(12+1) ^^^ 2089) := by decide +kernel

theorem selectedBound852 : packedSelected [1,2,3,4,5,10,13] rootPS < 2^1333 := by decide +kernel

def env853 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1296,2089,1345,2048,65536,1344,2048,69006,2048,1297,32,65,67844,2208,16,2341,1345,1296,2340,1284,4294967296,256,4294967296,1344,136]

theorem envBound853 : H12AffineFastState.Bounded env853 := by
  intro p hp
  have h : env853.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans852_853 : H12AffineEnvironment.transform 12 2089 env852 = env853 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2089 env852 == env853) = true)

theorem identity853 : scanCanonicalize (H12AffineFastState.compose env853 (packedSelected [2,5] rootPS)) = affineNative (2^(31+1) ^^^ 232) := by decide +kernel

theorem selectedBound853 : packedSelected [2,5] rootPS < 2^1333 := by decide +kernel

def env854 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1296,2089,1345,2048,65536,1344,2048,69006,2048,1297,32,65,67844,2208,16,2341,1345,1296,2340,1284,232,256,232,1344,136]

theorem envBound854 : H12AffineFastState.Bounded env854 := by
  intro p hp
  have h : env854.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans853_854 : H12AffineEnvironment.transform 31 232 env853 = env854 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 232 env853 == env854) = true)

theorem identity854 : scanCanonicalize (H12AffineFastState.compose env854 (packedSelected [1,2,10] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound854 : packedSelected [1,2,10] rootPS < 2^1333 := by decide +kernel

def env855 : List Nat := [2,4,8,16,32,64,128,37,137,1024,2048,1077,2089,1124,2048,65536,1125,2048,68779,2048,1076,32,65,67617,2208,16,2048,1124,1077,2049,1057,232,37,232,1125,136]

theorem envBound855 : H12AffineFastState.Bounded env855 := by
  intro p hp
  have h : env855.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans854_855 : H12AffineEnvironment.transform 7 37 env854 = env855 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env854 == env855) = true)

def env856 : List Nat := [2,4,8,16,32,64,128,37,137,1024,0,1077,41,1124,0,65536,1125,0,66731,0,1076,32,65,65569,160,16,0,1124,1077,1,1057,232,37,232,1125,136]

theorem envBound856 : H12AffineFastState.Bounded env856 := by
  intro p hp
  have h : env856.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans855_856 : H12AffineEnvironment.transform 10 0 env855 = env856 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env855 == env856) = true)

theorem identity856 : scanCanonicalize (H12AffineFastState.compose env856 (packedSelected [0] rootPS)) = affineNative (2^(15+1) ^^^ 57) := by decide +kernel

theorem selectedBound856 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env857 : List Nat := [2,4,8,16,32,64,128,37,137,1024,0,1077,41,1124,0,57,1125,0,1170,0,1076,32,65,24,160,16,0,1124,1077,1,1057,232,37,232,1125,136]

theorem envBound857 : H12AffineFastState.Bounded env857 := by
  intro p hp
  have h : env857.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans856_857 : H12AffineEnvironment.transform 15 57 env856 = env857 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 57 env856 == env857) = true)

theorem identity857 : scanCanonicalize (H12AffineFastState.compose env857 (packedSelected [1,2] rootPS)) = affineNative (2^(6+1) ^^^ 19) := by decide +kernel

theorem selectedBound857 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env858 : List Nat := [2,4,8,16,32,64,19,37,26,1024,0,1077,41,1124,0,57,1125,0,1025,0,1076,32,65,24,51,16,0,1124,1077,1,1057,123,37,123,1125,27]

theorem envBound858 : H12AffineFastState.Bounded env858 := by
  intro p hp
  have h : env858.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans857_858 : H12AffineEnvironment.transform 6 19 env857 = env858 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 19 env857 == env858) = true)

theorem identity858 : scanCanonicalize (H12AffineFastState.compose env858 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound858 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env859 : List Nat := [2,4,8,16,32,10,19,37,26,1024,0,1077,41,1070,0,57,1071,0,1025,0,1076,32,11,24,51,16,0,1070,1077,1,1057,49,37,49,1071,27]

theorem envBound859 : H12AffineFastState.Bounded env859 := by
  intro p hp
  have h : env859.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans858_859 : H12AffineEnvironment.transform 5 10 env858 = env859 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env858 == env859) = true)

def leafEnv859 : List Nat := [2,4,8,16,32,10,19,37,26,1024,0,1077,41,1070,0,57,1071,0,1025,0,1076,32,11,24,1056,51,1,16,0,1070,1077,1,1057,49,37,49,4,34,1071,27,0,1076,1]

def active859 : List Nat := [0,1,2,3,4,9]

def tree859 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood859 : H12WitnessSearch.Good tree859 := H12GlobalWitnessIndex.good

theorem leafIdentity859 : H12AffineFastState.composeSystem env859 rootObs = leafEnv859 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env859 rootObs == leafEnv859) = true)

theorem terminalChecked859 : H12PackedTerminal.terminalCheckFast leafEnv859 active859 tree859 = true := by decide +kernel

def env860 : List Nat := [2,4,8,16,32,64,128,37,137,1024,1,1077,40,1124,1,65536,1125,1,66730,1,1076,32,65,65568,161,16,1,1124,1077,0,1057,232,37,232,1125,136]

theorem envBound860 : H12AffineFastState.Bounded env860 := by
  intro p hp
  have h : env860.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans855_860 : H12AffineEnvironment.transform 10 1 env855 = env860 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env855 == env860) = true)

theorem identity860 : scanCanonicalize (H12AffineFastState.compose env860 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 19) := by decide +kernel

theorem selectedBound860 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env861 : List Nat := [2,4,8,16,32,64,19,37,26,1024,1,1077,40,1124,1,65536,1125,1,66617,1,1076,32,65,65568,50,16,1,1124,1077,0,1057,123,37,123,1125,27]

theorem envBound861 : H12AffineFastState.Bounded env861 := by
  intro p hp
  have h : env861.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans860_861 : H12AffineEnvironment.transform 6 19 env860 = env861 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 19 env860 == env861) = true)

def env862 : List Nat := [2,4,8,16,32,64,19,37,26,1024,1,1077,40,1124,1,56,1125,1,1025,1,1076,32,65,24,50,16,1,1124,1077,0,1057,123,37,123,1125,27]

theorem envBound862 : H12AffineFastState.Bounded env862 := by
  intro p hp
  have h : env862.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans861_862 : H12AffineEnvironment.transform 15 56 env861 = env862 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 56 env861 == env862) = true)

theorem identity862 : scanCanonicalize (H12AffineFastState.compose env862 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound862 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env863 : List Nat := [2,4,8,16,32,10,19,37,26,1024,1,1077,40,1070,1,56,1071,1,1025,1,1076,32,11,24,50,16,1,1070,1077,0,1057,49,37,49,1071,27]

theorem envBound863 : H12AffineFastState.Bounded env863 := by
  intro p hp
  have h : env863.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans862_863 : H12AffineEnvironment.transform 5 10 env862 = env863 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env862 == env863) = true)

def leafEnv863 : List Nat := [2,4,8,16,32,10,19,37,26,1024,1,1077,40,1070,1,56,1071,1,1025,1,1076,32,11,24,1056,50,1,16,1,1070,1077,0,1057,49,37,49,4,35,1071,27,0,1076,1]

def active863 : List Nat := [0,1,2,3,4,9]

def tree863 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood863 : H12WitnessSearch.Good tree863 := H12GlobalWitnessIndex.good

theorem leafIdentity863 : H12AffineFastState.composeSystem env863 rootObs = leafEnv863 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env863 rootObs == leafEnv863) = true)

theorem terminalChecked863 : H12PackedTerminal.terminalCheckFast leafEnv863 active863 tree863 = true := by decide +kernel

def env864 : List Nat := [2,4,8,16,32,64,19,37,26,1024,1,1077,40,1124,1,57,1125,1,1024,1,1076,32,65,25,50,16,1,1124,1077,0,1057,123,37,123,1125,27]

theorem envBound864 : H12AffineFastState.Bounded env864 := by
  intro p hp
  have h : env864.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans861_864 : H12AffineEnvironment.transform 15 57 env861 = env864 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 57 env861 == env864) = true)

theorem identity864 : scanCanonicalize (H12AffineFastState.compose env864 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound864 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env865 : List Nat := [2,4,8,16,0,64,19,5,26,1024,1,1045,8,1092,1,25,1093,1,1024,1,1044,0,65,25,18,16,1,1092,1045,0,1025,91,5,91,1093,27]

theorem envBound865 : H12AffineFastState.Bounded env865 := by
  intro p hp
  have h : env865.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans864_865 : H12AffineEnvironment.transform 4 0 env864 = env865 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env864 == env865) = true)

theorem identity865 : scanCanonicalize (H12AffineFastState.compose env865 (packedSelected [3] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound865 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env866 : List Nat := [2,4,8,16,0,11,19,5,26,1024,1,1045,8,1039,1,25,1038,1,1024,1,1044,0,10,25,18,16,1,1039,1045,0,1025,16,5,16,1038,27]

theorem envBound866 : H12AffineFastState.Bounded env866 := by
  intro p hp
  have h : env866.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans865_866 : H12AffineEnvironment.transform 5 11 env865 = env866 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env865 == env866) = true)

def leafEnv866 : List Nat := [2,4,8,16,0,11,19,5,26,1024,1,1045,8,1039,1,25,1038,1,1024,1,1044,0,10,25,1025,18,1,16,1,1039,1045,0,1025,16,5,16,4,3,1038,27,0,1044,1]

def active866 : List Nat := [0,1,2,3,9]

def tree866 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood866 : H12WitnessSearch.Good tree866 := H12GlobalWitnessIndex.good

theorem leafIdentity866 : H12AffineFastState.composeSystem env866 rootObs = leafEnv866 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env866 rootObs == leafEnv866) = true)

theorem terminalChecked866 : H12PackedTerminal.terminalCheckFast leafEnv866 active866 tree866 = true := by decide +kernel

def env867 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4745,4194304,17664,98565,8329,5377,4477269,16385,1945,1073741824,1933,4294967296,904,4299806207,1345,513]

theorem envBound867 : H12AffineFastState.Bounded env867 := by
  intro p hp
  have h : env867.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans826_867 : H12AffineEnvironment.transform 16 1345 env826 = env867 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env826 == env867) = true)

def env868 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,8329,16880644,21352529,16892164,2232400,1073741824,18977792,4294967296,2101504,4299806207,131072,513]

theorem envBound868 : H12AffineFastState.Bounded env868 := by
  intro p hp
  have h : env868.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans823_868 : H12AffineEnvironment.transform 26 21352529 env823 = env868 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 21352529 env823 == env868) = true)

theorem identity868 : scanCanonicalize (H12AffineFastState.compose env868 (packedSelected [0,3,4,6,7,10,16,20,22,24,25,26] rootPS)) = affineNative (2^(18+1) ^^^ 151825) := by decide +kernel

theorem selectedBound868 : packedSelected [0,3,4,6,7,10,16,20,22,24,25,26] rootPS < 2^1333 := by decide +kernel

def env869 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,151825,32768,2097152,4194304,17664,16777216,8329,16880644,21352529,16892164,2232400,1073741824,18977792,4294967296,2101504,4299392238,131072,513]

theorem envBound869 : H12AffineFastState.Bounded env869 := by
  intro p hp
  have h : env869.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans868_869 : H12AffineEnvironment.transform 18 151825 env868 = env869 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 151825 env868 == env869) = true)

theorem identity869 : scanCanonicalize (H12AffineFastState.compose env869 (packedSelected [0,4,6,7,16,20,22,25] rootPS)) = affineNative (2^(23+1) ^^^ 230469) := by decide +kernel

theorem selectedBound869 : packedSelected [0,4,6,7,16,20,22,25] rootPS < 2^1333 := by decide +kernel

def env870 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,151825,32768,2097152,4194304,17664,230469,8329,135233,4609044,148801,2232400,1073741824,2232389,4294967296,2101504,4299392238,131072,513]

theorem envBound870 : H12AffineFastState.Bounded env870 := by
  intro p hp
  have h : env870.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans869_870 : H12AffineEnvironment.transform 23 230469 env869 = env870 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230469 env869 == env870) = true)

theorem identity870 : scanCanonicalize (H12AffineFastState.compose env870 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(16+1) ^^^ 17032) := by decide +kernel

theorem selectedBound870 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env871 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,17032,262144,5017,32768,2097152,4194304,17664,116429,8329,21193,4462236,1993,2118360,1073741824,2118349,4294967296,2101504,4299277926,17032,513]

theorem envBound871 : H12AffineFastState.Bounded env871 := by
  intro p hp
  have h : env871.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans870_871 : H12AffineEnvironment.transform 16 17032 env870 = env871 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 17032 env870 == env871) = true)

def env872 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,17032,262144,5017,32768,4096,4194304,17664,116429,8329,21193,4462236,1993,17112,1073741824,17101,4294967296,256,4299277926,17032,513]

theorem envBound872 : H12AffineFastState.Bounded env872 := by
  intro p hp
  have h : env872.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans871_872 : H12AffineEnvironment.transform 20 4096 env871 = env872 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env871 == env872) = true)

def env873 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,17032,262144,5017,32768,4097,4194304,17664,116429,8329,21193,4462236,1993,17113,1073741824,17100,4294967296,257,4299277926,17032,513]

theorem envBound873 : H12AffineFastState.Bounded env873 := by
  intro p hp
  have h : env873.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans871_873 : H12AffineEnvironment.transform 20 4097 env871 = env873 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env871 == env873) = true)

theorem identity873 : scanCanonicalize (H12AffineFastState.compose env873 (packedSelected [0,27] rootPS)) = affineNative (2^(13+1) ^^^ 1992) := by decide +kernel

theorem selectedBound873 : packedSelected [0,27] rootPS < 2^1333 := by decide +kernel

def env874 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,1992,32768,65536,1344,262144,5017,32768,4097,4194304,712,98565,8329,5377,4462236,1993,1297,1073741824,1284,4294967296,257,4299260334,1344,513]

theorem envBound874 : H12AffineFastState.Bounded env874 := by
  intro p hp
  have h : env874.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans873_874 : H12AffineEnvironment.transform 13 1992 env873 = env874 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1992 env873 == env874) = true)

theorem identity874 : scanCanonicalize (H12AffineFastState.compose env874 (packedSelected [4,9,16] rootPS)) = affineNative (2^(29+1) ^^^ 4294795) := by decide +kernel

theorem selectedBound874 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env875 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,1992,32768,65536,1344,262144,5017,32768,4097,4194304,712,98565,8329,5377,4462236,1993,1297,4294795,1284,4294967296,257,4299260334,1344,513]

theorem envBound875 : H12AffineFastState.Bounded env875 := by
  intro p hp
  have h : env875.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans874_875 : H12AffineEnvironment.transform 29 4294795 env874 = env875 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4294795 env874 == env875) = true)

theorem identity875 : scanCanonicalize (H12AffineFastState.compose env875 (packedSelected [1,8,10,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 38423) := by decide +kernel

theorem selectedBound875 : packedSelected [1,8,10,12,15] rootPS < 2^1333 := by decide +kernel

def env876 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,1992,32768,38423,1344,262144,5017,32768,4097,4194304,712,5906,8329,5377,4462236,1993,1297,4202140,1284,4294967296,257,4299167673,1344,513]

theorem envBound876 : H12AffineFastState.Bounded env876 := by
  intro p hp
  have h : env876.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans875_876 : H12AffineEnvironment.transform 15 38423 env875 = env876 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 38423 env875 == env876) = true)

theorem identity876 : scanCanonicalize (H12AffineFastState.compose env876 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(21+1) ^^^ 269980) := by decide +kernel

theorem selectedBound876 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env877 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,1992,32768,38423,1344,262144,5017,32768,4097,269980,712,5906,8329,5377,2048,1993,1297,262144,1284,4294967296,257,4295231781,1344,513]

theorem envBound877 : H12AffineFastState.Bounded env877 := by
  intro p hp
  have h : env877.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans876_877 : H12AffineEnvironment.transform 21 269980 env876 = env877 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 269980 env876 == env877) = true)

theorem identity877 : scanCanonicalize (H12AffineFastState.compose env877 (packedSelected [0,7] rootPS)) = affineNative (2^(17+1) ^^^ 40637) := by decide +kernel

theorem selectedBound877 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env878 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,1992,32768,38423,1344,40637,5017,32768,4097,32801,712,5906,8329,5377,2048,1993,1297,40637,1284,4294967296,257,4295006104,1344,513]

theorem envBound878 : H12AffineFastState.Bounded env878 := by
  intro p hp
  have h : env878.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans877_878 : H12AffineEnvironment.transform 17 40637 env877 = env878 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 40637 env877 == env878) = true)

theorem identity878 : scanCanonicalize (H12AffineFastState.compose env878 (packedSelected [0,2,4,5,6,8,11,18] rootPS)) = affineNative (2^(14+1) ^^^ 649) := by decide +kernel

theorem selectedBound878 : packedSelected [0,2,4,5,6,8,11,18] rootPS < 2^1333 := by decide +kernel

def env879 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,1992,649,5278,1344,7220,5017,649,4097,680,712,5906,8329,5377,2048,1993,1297,7220,1284,4294967296,257,4294972689,1344,513]

theorem envBound879 : H12AffineFastState.Bounded env879 := by
  intro p hp
  have h : env879.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans878_879 : H12AffineEnvironment.transform 14 649 env878 = env879 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 649 env878 == env879) = true)

theorem identity879 : scanCanonicalize (H12AffineFastState.compose env879 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(11+1) ^^^ 1945) := by decide +kernel

theorem selectedBound879 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env880 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,8192,1992,649,775,1344,2989,1024,649,1944,680,712,139,8329,664,2048,1993,1297,2989,1284,4294967296,257,4294967944,1344,513]

theorem envBound880 : H12AffineFastState.Bounded env880 := by
  intro p hp
  have h : env880.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans879_880 : H12AffineEnvironment.transform 11 1945 env879 = env880 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1945 env879 == env880) = true)

def env881 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,134217728,67130625,536870912,1073741824,553878609,4294967296,537002321,4417151346,34359738368,33563272]

theorem envBound881 : H12AffineFastState.Bounded env881 := by
  intro p hp
  have h : env881.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6_881 : H12AffineEnvironment.transform 27 67130625 env6 = env881 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 27 67130625 env6 == env881) = true)

def env882 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,134217728,67130625,536870912,1073741824,553878609,4294967296,537002321,4417151346,694534144,33563272]

theorem envBound882 : H12AffineFastState.Bounded env882 := by
  intro p hp
  have h : env882.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans881_882 : H12AffineEnvironment.transform 34 694534144 env881 = env882 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 34 694534144 env881 == env882) = true)

def env883 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,134217728,67130625,157794304,1073741824,140788817,4294967296,157663569,4417151346,131072,33563272]

theorem envBound883 : H12AffineFastState.Bounded env883 := by
  intro p hp
  have h : env883.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans882_883 : H12AffineEnvironment.transform 28 157794304 env882 = env883 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 28 157794304 env882 == env883) = true)

theorem identity883 : scanCanonicalize (H12AffineFastState.compose env883 (packedSelected [14] rootPS)) = affineNative (2^(25+1) ^^^ 17011013) := by decide +kernel

theorem selectedBound883 : packedSelected [14] rootPS < 2^1333 := by decide +kernel

def env884 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,17011013,134217728,17024068,157794304,1073741824,140788817,4294967296,157663569,4333498423,131072,33563272]

theorem envBound884 : H12AffineFastState.Bounded env884 := by
  intro p hp
  have h : env884.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans883_884 : H12AffineEnvironment.transform 25 17011013 env883 = env884 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 17011013 env883 == env884) = true)

def env885 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,17011013,21352528,17024068,2232400,1073741824,18977793,4294967296,2101505,4333498423,131072,33563272]

theorem envBound885 : H12AffineFastState.Bounded env885 := by
  intro p hp
  have h : env885.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans884_885 : H12AffineEnvironment.transform 26 21352528 env884 = env885 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 21352528 env884 == env885) = true)

theorem identity885 : scanCanonicalize (H12AffineFastState.compose env885 (packedSelected [35] rootPS)) = affineNative (2^(23+1) ^^^ 2331717) := by decide +kernel

theorem selectedBound885 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env886 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,2331717,33554432,2098432,6702101,2117633,2232400,1073741824,131140,4294967296,2101505,4333498423,131072,33563272]

theorem envBound886 : H12AffineFastState.Bounded env886 := by
  intro p hp
  have h : env886.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans885_886 : H12AffineEnvironment.transform 23 2331717 env885 = env886 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 2331717 env885 == env886) = true)

theorem identity886 : scanCanonicalize (H12AffineFastState.compose env886 (packedSelected [1,3,10,19,24,26,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound886 : packedSelected [1,3,10,19,24,26,28,31] rootPS < 2^1333 := by decide +kernel

def env887 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,2331717,8329,2098432,6702101,2117633,2232400,1073741824,131140,4294967296,2101505,4299935934,131072,513]

theorem envBound887 : H12AffineFastState.Bounded env887 := by
  intro p hp
  have h : env887.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans886_887 : H12AffineEnvironment.transform 24 8329 env886 = env887 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env886 == env887) = true)

def env888 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,2097152,4194304,5456,2331717,8329,2098432,6689861,2097233,2232400,1073741824,131140,4294967296,2101505,4299915502,131072,513]

theorem envBound888 : H12AffineFastState.Bounded env888 := by
  intro p hp
  have h : env888.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans887_888 : H12AffineEnvironment.transform 13 4176 env887 = env888 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env887 == env888) = true)

theorem identity888 : scanCanonicalize (H12AffineFastState.compose env888 (packedSelected [6,25] rootPS)) = affineNative (2^(29+1) ^^^ 4294795) := by decide +kernel

theorem selectedBound888 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env889 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,2097152,4194304,5456,2331717,8329,2098432,6689861,2097233,2232400,4294795,131140,4294967296,2101505,4299915502,131072,513]

theorem envBound889 : H12AffineFastState.Bounded env889 := by
  intro p hp
  have h : env889.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans888_889 : H12AffineEnvironment.transform 29 4294795 env888 = env889 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4294795 env888 == env889) = true)

def env890 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,136512,4194304,5456,98565,8329,135232,4456709,136465,1296,4294795,131140,4294967296,132161,4299915502,131072,513]

theorem envBound890 : H12AffineFastState.Bounded env890 := by
  intro p hp
  have h : env890.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans889_890 : H12AffineEnvironment.transform 20 136512 env889 = env890 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 136512 env889 == env890) = true)

theorem identity890 : scanCanonicalize (H12AffineFastState.compose env890 (packedSelected [0,7,9,20,22] rootPS)) = affineNative (2^(16+1) ^^^ 1344) := by decide +kernel

theorem selectedBound890 : packedSelected [0,7,9,20,22] rootPS < 2^1333 := by decide +kernel

def env891 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1344,262144,524288,32768,4096,4194304,5456,98565,8329,5376,4456709,4177,1296,4294795,1284,4294967296,257,4299785646,1344,513]

theorem envBound891 : H12AffineFastState.Bounded env891 := by
  intro p hp
  have h : env891.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans890_891 : H12AffineEnvironment.transform 16 1344 env890 = env891 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env890 == env891) = true)

theorem identity891 : scanCanonicalize (H12AffineFastState.compose env891 (packedSelected [0,7,20] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound891 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env892 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4176,32768,65536,1344,262144,524288,32768,4096,4194304,5456,98565,8329,5376,4456709,4177,1296,4294795,1284,4294967296,257,4299785646,1344,136]

theorem envBound892 : H12AffineFastState.Bounded env892 := by
  intro p hp
  have h : env892.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans891_892 : H12AffineEnvironment.transform 8 137 env891 = env892 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env891 == env892) = true)

def env893 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4176,32768,65536,1344,262144,524288,32768,4096,41088,5456,98565,8329,5376,303493,4177,1296,75787,1284,4294967296,257,4295566638,1344,136]

theorem envBound893 : H12AffineFastState.Bounded env893 := by
  intro p hp
  have h : env893.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans892_893 : H12AffineEnvironment.transform 21 41088 env892 = env893 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 41088 env892 == env893) = true)

theorem identity893 : scanCanonicalize (H12AffineFastState.compose env893 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 307435) := by decide +kernel

theorem selectedBound893 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env894 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4176,32768,65536,1344,262144,524288,32768,4096,41088,5456,98565,8329,5376,303493,4177,1296,75787,1284,307435,257,890309,1344,136]

theorem envBound894 : H12AffineFastState.Bounded env894 := by
  intro p hp
  have h : env894.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans893_894 : H12AffineEnvironment.transform 31 307435 env893 = env894 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 307435 env893 == env894) = true)

theorem identity894 : scanCanonicalize (H12AffineFastState.compose env894 (packedSelected [3,5,10] rootPS)) = affineNative (2^(18+1) ^^^ 308670) := by decide +kernel

theorem selectedBound894 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env895 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4176,32768,65536,1344,262144,308670,32768,4096,41088,5456,98565,8329,5376,303493,4177,1296,75787,1284,307435,257,73851,1344,136]

theorem envBound895 : H12AffineFastState.Bounded env895 := by
  intro p hp
  have h : env895.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans894_895 : H12AffineEnvironment.transform 18 308670 env894 = env895 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 308670 env894 == env895) = true)

def env896 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4176,32768,65536,1344,32904,13622,32768,4096,41088,5456,98565,8329,5376,8461,4177,1296,75787,1284,12387,257,73851,1344,136]

theorem envBound896 : H12AffineFastState.Bounded env896 := by
  intro p hp
  have h : env896.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans895_896 : H12AffineEnvironment.transform 17 32904 env895 = env896 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 32904 env895 == env896) = true)

theorem identity896 : scanCanonicalize (H12AffineFastState.compose env896 (packedSelected [7] rootPS)) = affineNative (2^(14+1) ^^^ 8321) := by decide +kernel

theorem selectedBound896 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env897 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4176,8321,65536,1344,8201,13622,8321,4096,1,5456,74116,8329,5376,8461,4177,1296,75787,1284,12387,257,73851,1344,136]

theorem envBound897 : H12AffineFastState.Bounded env897 := by
  intro p hp
  have h : env897.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans896_897 : H12AffineEnvironment.transform 14 8321 env896 = env897 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8321 env896 == env897) = true)

def env898 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,420,4176,293,65536,1344,429,5266,293,4096,1,5456,65568,301,5376,169,4177,1296,68015,1284,4551,257,66015,1344,136]

theorem envBound898 : H12AffineFastState.Bounded env898 := by
  intro p hp
  have h : env898.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans897_898 : H12AffineEnvironment.transform 12 420 env897 = env898 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 420 env897 == env898) = true)

theorem identity898 : scanCanonicalize (H12AffineFastState.compose env898 (packedSelected [18] rootPS)) = affineNative (2^(10+1) ^^^ 1) := by decide +kernel

theorem selectedBound898 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env899 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,4096,420,4176,293,65536,1344,429,5266,293,4096,1,5456,65568,301,5376,169,4177,1296,65966,1284,4551,257,66015,1344,136]

theorem envBound899 : H12AffineFastState.Bounded env899 := by
  intro p hp
  have h : env899.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans898_899 : H12AffineEnvironment.transform 10 1 env898 = env899 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env898 == env899) = true)

theorem identity899 : scanCanonicalize (H12AffineFastState.compose env899 (packedSelected [2,9] rootPS)) = affineNative (2^(15+1) ^^^ 431) := by decide +kernel

theorem selectedBound899 : packedSelected [2,9] rootPS < 2^1333 := by decide +kernel

def env900 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,4096,420,4176,293,431,1344,429,5266,293,4096,1,5456,399,301,5376,169,4177,1296,1,1284,4551,257,112,1344,136]

theorem envBound900 : H12AffineFastState.Bounded env900 := by
  intro p hp
  have h : env900.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans899_900 : H12AffineEnvironment.transform 15 431 env899 = env900 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 431 env899 == env900) = true)

theorem identity900 : scanCanonicalize (H12AffineFastState.compose env900 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound900 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env901 : List Nat := [2,4,8,16,32,64,128,5,137,1024,1,4096,161,4176,32,170,1093,168,5266,32,4096,1,5205,138,40,5125,169,4177,1045,1,1025,4290,4,112,1093,136]

theorem envBound901 : H12AffineFastState.Bounded env901 := by
  intro p hp
  have h : env901.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans900_901 : H12AffineEnvironment.transform 7 5 env900 = env901 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env900 == env901) = true)

def env902 : List Nat := [2,4,8,16,32,64,8,5,1,1024,1,4096,41,4176,32,34,1093,32,5146,32,4096,1,5205,2,40,5125,33,4177,1045,1,1025,4170,4,112,1093,0]

theorem envBound902 : H12AffineFastState.Bounded env902 := by
  intro p hp
  have h : env902.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans901_902 : H12AffineEnvironment.transform 6 8 env901 = env902 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env901 == env902) = true)

theorem identity902 : scanCanonicalize (H12AffineFastState.compose env902 (packedSelected [1,3] rootPS)) = affineNative (2^(9+1) ^^^ 46) := by decide +kernel

theorem selectedBound902 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env903 : List Nat := [2,4,8,16,32,64,8,5,1,46,1,4096,41,4176,32,34,107,32,4148,32,4096,1,4219,2,40,4139,33,4177,59,1,47,4170,4,112,107,0]

theorem envBound903 : H12AffineFastState.Bounded env903 := by
  intro p hp
  have h : env903.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans902_903 : H12AffineEnvironment.transform 9 46 env902 = env903 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 46 env902 == env903) = true)

theorem identity903 : scanCanonicalize (H12AffineFastState.compose env903 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 48) := by decide +kernel

theorem selectedBound903 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env904 : List Nat := [2,4,8,16,32,48,8,5,1,46,1,4096,41,4128,32,34,27,32,4148,32,4096,1,4107,2,40,4139,33,4129,59,1,47,4154,4,0,27,0]

theorem envBound904 : H12AffineFastState.Bounded env904 := by
  intro p hp
  have h : env904.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans903_904 : H12AffineEnvironment.transform 5 48 env903 = env904 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 48 env903 == env904) = true)

def leafEnv904 : List Nat := [2,4,8,16,32,48,8,5,1,46,1,4096,41,4128,32,34,27,32,4148,32,4096,1,4107,2,4148,40,1,4139,33,4129,59,1,47,4154,4,0,4,35,27,0,0,58,1]

def active904 : List Nat := [0,1,2,3,4,11]

def tree904 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood904 : H12WitnessSearch.Good tree904 := H12GlobalWitnessIndex.good

theorem leafIdentity904 : H12AffineFastState.composeSystem env904 rootObs = leafEnv904 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env904 rootObs == leafEnv904) = true)

theorem terminalChecked904 : H12PackedTerminal.terminalCheckFast leafEnv904 active904 tree904 = true := by decide +kernel

def env905 : List Nat := [2,4,8,16,32,64,9,5,0,1024,1,4096,40,4176,32,35,1093,33,5147,32,4096,1,5205,3,40,5125,32,4177,1045,1,1025,4171,4,112,1093,1]

theorem envBound905 : H12AffineFastState.Bounded env905 := by
  intro p hp
  have h : env905.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans901_905 : H12AffineEnvironment.transform 6 9 env901 = env905 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env901 == env905) = true)

theorem identity905 : scanCanonicalize (H12AffineFastState.compose env905 (packedSelected [1,3] rootPS)) = affineNative (2^(11+1) ^^^ 1077) := by decide +kernel

theorem selectedBound905 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env906 : List Nat := [2,4,8,16,32,64,9,5,0,1024,1,1077,40,1125,32,35,1093,33,46,32,1077,1,96,3,40,48,32,1124,1045,1,1025,1150,4,112,1093,1]

theorem envBound906 : H12AffineFastState.Bounded env906 := by
  intro p hp
  have h : env906.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans905_906 : H12AffineEnvironment.transform 11 1077 env905 = env906 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1077 env905 == env906) = true)

theorem identity906 : scanCanonicalize (H12AffineFastState.compose env906 (packedSelected [1] rootPS)) = affineNative (2^(9+1) ^^^ 14) := by decide +kernel

theorem selectedBound906 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env907 : List Nat := [2,4,8,16,32,64,9,5,0,14,1,59,40,107,32,35,75,33,46,32,59,1,96,3,40,48,32,106,27,1,15,112,4,112,75,1]

theorem envBound907 : H12AffineFastState.Bounded env907 := by
  intro p hp
  have h : env907.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans906_907 : H12AffineEnvironment.transform 9 14 env906 = env907 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 14 env906 == env907) = true)

theorem identity907 : scanCanonicalize (H12AffineFastState.compose env907 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound907 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env908 : List Nat := [2,4,8,16,0,64,9,5,0,14,1,27,8,75,0,3,75,1,14,0,27,1,64,3,8,16,0,74,27,1,15,80,4,80,75,1]

theorem envBound908 : H12AffineFastState.Bounded env908 := by
  intro p hp
  have h : env908.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans907_908 : H12AffineEnvironment.transform 4 0 env907 = env908 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env907 == env908) = true)

def leafEnv908 : List Nat := [2,4,8,16,0,64,9,5,0,14,1,27,8,75,0,3,75,1,14,0,27,1,64,3,14,8,1,16,0,74,27,1,15,80,4,80,4,3,75,1,0,26,1]

def active908 : List Nat := [0,1,2,3,5]

def tree908 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood908 : H12WitnessSearch.Good tree908 := H12GlobalWitnessIndex.good

theorem leafIdentity908 : H12AffineFastState.composeSystem env908 rootObs = leafEnv908 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env908 rootObs == leafEnv908) = true)

theorem terminalChecked908 : H12PackedTerminal.terminalCheckFast leafEnv908 active908 tree908 = true := by decide +kernel

def env909 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,421,4176,292,65536,1344,428,5267,292,4096,1,5456,65569,300,5376,168,4177,1296,68014,1284,4550,257,66014,1344,136]

theorem envBound909 : H12AffineFastState.Bounded env909 := by
  intro p hp
  have h : env909.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans897_909 : H12AffineEnvironment.transform 12 421 env897 = env909 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 421 env897 == env909) = true)

theorem identity909 : scanCanonicalize (H12AffineFastState.compose env909 (packedSelected [18] rootPS)) = affineNative (2^(15+1) ^^^ 430) := by decide +kernel

theorem selectedBound909 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env910 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,421,4176,292,430,1344,428,5267,292,4096,1,5456,399,300,5376,168,4177,1296,2048,1284,4550,257,112,1344,136]

theorem envBound910 : H12AffineFastState.Bounded env910 := by
  intro p hp
  have h : env910.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans909_910 : H12AffineEnvironment.transform 15 430 env909 = env910 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 430 env909 == env910) = true)

theorem identity910 : scanCanonicalize (H12AffineFastState.compose env910 (packedSelected [0,11] rootPS)) = affineNative (2^(10+1) ^^^ 261) := by decide +kernel

theorem selectedBound910 : packedSelected [0,11] rootPS < 2^1333 := by decide +kernel

def env911 : List Nat := [2,4,8,16,32,64,128,256,137,1024,261,4096,421,4176,292,430,1344,428,5267,292,4096,1,5456,399,300,5376,168,4177,1296,261,1284,4550,257,112,1344,136]

theorem envBound911 : H12AffineFastState.Bounded env911 := by
  intro p hp
  have h : env911.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans910_911 : H12AffineEnvironment.transform 10 261 env910 = env911 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 261 env910 == env911) = true)

theorem identity911 : scanCanonicalize (H12AffineFastState.compose env911 (packedSelected [1,8,13,15] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound911 : packedSelected [1,8,13,15] rootPS < 2^1333 := by decide +kernel

def env912 : List Nat := [2,4,8,16,32,64,128,5,137,1024,0,4096,160,4176,33,171,1093,169,5267,33,4096,1,5205,138,41,5125,168,4177,1045,0,1025,4291,4,112,1093,136]

theorem envBound912 : H12AffineFastState.Bounded env912 := by
  intro p hp
  have h : env912.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans911_912 : H12AffineEnvironment.transform 7 5 env911 = env912 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env911 == env912) = true)

def env913 : List Nat := [2,4,8,16,32,64,8,5,1,1024,0,4096,40,4176,33,35,1093,33,5147,33,4096,1,5205,2,41,5125,32,4177,1045,0,1025,4171,4,112,1093,0]

theorem envBound913 : H12AffineFastState.Bounded env913 := by
  intro p hp
  have h : env913.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans912_913 : H12AffineEnvironment.transform 6 8 env912 = env913 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env912 == env913) = true)

theorem identity913 : scanCanonicalize (H12AffineFastState.compose env913 (packedSelected [1,3] rootPS)) = affineNative (2^(9+1) ^^^ 47) := by decide +kernel

theorem selectedBound913 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env914 : List Nat := [2,4,8,16,32,64,8,5,1,47,0,4096,40,4176,33,35,106,33,4148,33,4096,1,4218,2,41,4138,32,4177,58,0,46,4171,4,112,106,0]

theorem envBound914 : H12AffineFastState.Bounded env914 := by
  intro p hp
  have h : env914.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans913_914 : H12AffineEnvironment.transform 9 47 env913 = env914 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 47 env913 == env914) = true)

theorem identity914 : scanCanonicalize (H12AffineFastState.compose env914 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 48) := by decide +kernel

theorem selectedBound914 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env915 : List Nat := [2,4,8,16,32,48,8,5,1,47,0,4096,40,4128,33,35,26,33,4148,33,4096,1,4106,2,41,4138,32,4129,58,0,46,4155,4,0,26,0]

theorem envBound915 : H12AffineFastState.Bounded env915 := by
  intro p hp
  have h : env915.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans914_915 : H12AffineEnvironment.transform 5 48 env914 = env915 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 48 env914 == env915) = true)

def leafEnv915 : List Nat := [2,4,8,16,32,48,8,5,1,47,0,4096,40,4128,33,35,26,33,4148,33,4096,1,4106,2,4148,41,1,4138,32,4129,58,0,46,4155,4,0,4,34,26,0,0,59,1]

def active915 : List Nat := [0,1,2,3,4,11]

def tree915 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood915 : H12WitnessSearch.Good tree915 := H12GlobalWitnessIndex.good

theorem leafIdentity915 : H12AffineFastState.composeSystem env915 rootObs = leafEnv915 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env915 rootObs == leafEnv915) = true)

theorem terminalChecked915 : H12PackedTerminal.terminalCheckFast leafEnv915 active915 tree915 = true := by decide +kernel

def env916 : List Nat := [2,4,8,16,32,64,9,5,0,1024,0,4096,41,4176,33,34,1093,32,5146,33,4096,1,5205,3,41,5125,33,4177,1045,0,1025,4170,4,112,1093,1]

theorem envBound916 : H12AffineFastState.Bounded env916 := by
  intro p hp
  have h : env916.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans912_916 : H12AffineEnvironment.transform 6 9 env912 = env916 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env912 == env916) = true)

theorem identity916 : scanCanonicalize (H12AffineFastState.compose env916 (packedSelected [1,3] rootPS)) = affineNative (2^(11+1) ^^^ 1077) := by decide +kernel

theorem selectedBound916 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env917 : List Nat := [2,4,8,16,32,64,9,5,0,1024,0,1077,41,1125,33,34,1093,32,47,33,1077,1,96,3,41,48,33,1124,1045,0,1025,1151,4,112,1093,1]

theorem envBound917 : H12AffineFastState.Bounded env917 := by
  intro p hp
  have h : env917.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans916_917 : H12AffineEnvironment.transform 11 1077 env916 = env917 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1077 env916 == env917) = true)

theorem identity917 : scanCanonicalize (H12AffineFastState.compose env917 (packedSelected [1] rootPS)) = affineNative (2^(9+1) ^^^ 15) := by decide +kernel

theorem selectedBound917 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env918 : List Nat := [2,4,8,16,32,64,9,5,0,15,0,58,41,106,33,34,74,32,47,33,58,1,96,3,41,48,33,107,26,0,14,112,4,112,74,1]

theorem envBound918 : H12AffineFastState.Bounded env918 := by
  intro p hp
  have h : env918.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans917_918 : H12AffineEnvironment.transform 9 15 env917 = env918 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 15 env917 == env918) = true)

theorem identity918 : scanCanonicalize (H12AffineFastState.compose env918 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound918 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env919 : List Nat := [2,4,8,16,0,64,9,5,0,15,0,26,9,74,1,2,74,0,15,1,26,1,64,3,9,16,1,75,26,0,14,80,4,80,74,1]

theorem envBound919 : H12AffineFastState.Bounded env919 := by
  intro p hp
  have h : env919.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans918_919 : H12AffineEnvironment.transform 4 0 env918 = env919 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env918 == env919) = true)

def leafEnv919 : List Nat := [2,4,8,16,0,64,9,5,0,15,0,26,9,74,1,2,74,0,15,1,26,1,64,3,15,9,1,16,1,75,26,0,14,80,4,80,4,2,74,1,0,27,1]

def active919 : List Nat := [0,1,2,3,5]

def tree919 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood919 : H12WitnessSearch.Good tree919 := H12GlobalWitnessIndex.good

theorem leafIdentity919 : H12AffineFastState.composeSystem env919 rootObs = leafEnv919 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env919 rootObs == leafEnv919) = true)

theorem terminalChecked919 : H12PackedTerminal.terminalCheckFast leafEnv919 active919 tree919 = true := by decide +kernel

def env920 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4176,32768,65536,1344,32905,13623,32768,4096,41088,5456,98565,8329,5376,8460,4177,1296,75787,1284,12386,257,73851,1344,136]

theorem envBound920 : H12AffineFastState.Bounded env920 := by
  intro p hp
  have h : env920.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans895_920 : H12AffineEnvironment.transform 17 32905 env895 = env920 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 32905 env895 == env920) = true)

theorem identity920 : scanCanonicalize (H12AffineFastState.compose env920 (packedSelected [7] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound920 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env921 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,4096,8192,4176,32768,65536,1092,32905,13363,32768,4096,41088,5204,98305,8329,5124,8200,4177,1044,75787,1024,12386,5,73851,1092,136]

theorem envBound921 : H12AffineFastState.Bounded env921 := by
  intro p hp
  have h : env921.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans920_921 : H12AffineEnvironment.transform 7 4 env920 = env921 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env920 == env921) = true)

theorem identity921 : scanCanonicalize (H12AffineFastState.compose env921 (packedSelected [1,12,13] rootPS)) = affineNative (2^(12+1) ^^^ 4146) := by decide +kernel

theorem selectedBound921 : packedSelected [1,12,13] rootPS < 2^1333 := by decide +kernel

def env922 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,4096,4146,4176,32768,65536,1092,32905,1025,32768,4096,37042,5204,98305,4283,5124,4154,4177,1044,71737,1024,80,5,69705,1092,136]

theorem envBound922 : H12AffineFastState.Bounded env922 := by
  intro p hp
  have h : env922.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans921_922 : H12AffineEnvironment.transform 12 4146 env921 = env922 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4146 env921 == env922) = true)

theorem identity922 : scanCanonicalize (H12AffineFastState.compose env922 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 1036) := by decide +kernel

theorem selectedBound922 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env923 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,4096,4146,4176,32768,1036,1092,32905,1025,32768,4096,37042,5204,33805,4283,5124,4154,4177,1044,7221,1024,80,5,5189,1092,136]

theorem envBound923 : H12AffineFastState.Bounded env923 := by
  intro p hp
  have h : env923.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans922_923 : H12AffineEnvironment.transform 15 1036 env922 = env923 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 1036 env922 == env923) = true)

theorem identity923 : scanCanonicalize (H12AffineFastState.compose env923 (packedSelected [2,23,32] rootPS)) = affineNative (2^(14+1) ^^^ 4155) := by decide +kernel

theorem selectedBound923 : packedSelected [2,23,32] rootPS < 2^1333 := by decide +kernel

def env924 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,4096,4146,4176,4155,1036,1092,4274,1025,4155,4096,137,5204,5174,4283,5124,4154,4177,1044,7221,1024,80,5,5189,1092,136]

theorem envBound924 : H12AffineFastState.Bounded env924 := by
  intro p hp
  have h : env924.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans923_924 : H12AffineEnvironment.transform 14 4155 env923 = env924 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 4155 env923 == env924) = true)

theorem identity924 : scanCanonicalize (H12AffineFastState.compose env924 (packedSelected [1,8,12] rootPS)) = affineNative (2^(11+1) ^^^ 1045) := by decide +kernel

theorem selectedBound924 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env925 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,1045,1063,1093,1070,1036,1092,1191,1025,1070,1045,137,65,35,1198,17,1071,1092,1044,2080,1024,80,5,80,1092,136]

theorem envBound925 : H12AffineFastState.Bounded env925 := by
  intro p hp
  have h : env925.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans924_925 : H12AffineEnvironment.transform 11 1045 env924 = env925 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1045 env924 == env925) = true)

theorem identity925 : scanCanonicalize (H12AffineFastState.compose env925 (packedSelected [1,3,5] rootPS)) = affineNative (2^(10+1) ^^^ 1071) := by decide +kernel

theorem selectedBound925 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env926 : List Nat := [2,4,8,16,32,64,128,4,137,1024,1071,1045,1063,1093,1070,1036,1092,1191,1025,1070,1045,137,65,35,1198,17,1071,1092,1044,1039,1024,80,5,80,1092,136]

theorem envBound926 : H12AffineFastState.Bounded env926 := by
  intro p hp
  have h : env926.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans925_926 : H12AffineEnvironment.transform 10 1071 env925 = env926 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1071 env925 == env926) = true)

theorem identity926 : scanCanonicalize (H12AffineFastState.compose env926 (packedSelected [0,2] rootPS)) = affineNative (2^(6+1) ^^^ 41) := by decide +kernel

theorem selectedBound926 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env927 : List Nat := [2,4,8,16,32,64,41,4,32,1024,1071,1045,1063,1093,1070,1036,1092,1038,1025,1070,1045,32,65,35,1031,17,1071,1092,1044,1039,1024,80,5,80,1092,33]

theorem envBound927 : H12AffineFastState.Bounded env927 := by
  intro p hp
  have h : env927.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans926_927 : H12AffineEnvironment.transform 6 41 env926 = env927 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 41 env926 == env927) = true)

def env928 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4176,32768,65536,1344,262144,524288,32768,4096,41089,5456,98565,8329,5376,303492,4177,1296,75786,1284,4294967296,257,4295566639,1344,136]

theorem envBound928 : H12AffineFastState.Bounded env928 := by
  intro p hp
  have h : env928.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans892_928 : H12AffineEnvironment.transform 21 41089 env892 = env928 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 41089 env892 == env928) = true)

theorem identity928 : scanCanonicalize (H12AffineFastState.compose env928 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 266726) := by decide +kernel

theorem selectedBound928 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env929 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4176,32768,65536,1344,262144,524288,32768,4096,41089,5456,98565,8329,5376,303492,4177,1296,75786,1284,266726,257,865481,1344,136]

theorem envBound929 : H12AffineFastState.Bounded env929 := by
  intro p hp
  have h : env929.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans928_929 : H12AffineEnvironment.transform 31 266726 env928 = env929 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 266726 env928 == env929) = true)

theorem identity929 : scanCanonicalize (H12AffineFastState.compose env929 (packedSelected [3,5,10] rootPS)) = affineNative (2^(17+1) ^^^ 4274) := by decide +kernel

theorem selectedBound929 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env930 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4176,32768,65536,1344,4274,524288,32768,4096,41089,5456,98565,8329,5376,45366,4177,1296,75786,1284,340,257,599163,1344,136]

theorem envBound930 : H12AffineFastState.Bounded env930 := by
  intro p hp
  have h : env930.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans929_930 : H12AffineEnvironment.transform 17 4274 env929 = env930 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 4274 env929 == env930) = true)

def env931 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4176,8580,65536,1344,4274,524288,8580,4096,261,5456,73857,8329,5376,4274,4177,1296,75786,1284,340,257,599163,1344,136]

theorem envBound931 : H12AffineFastState.Bounded env931 := by
  intro p hp
  have h : env931.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans930_931 : H12AffineEnvironment.transform 14 8580 env930 = env931 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8580 env930 == env931) = true)

theorem identity931 : scanCanonicalize (H12AffineFastState.compose env931 (packedSelected [7] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound931 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env932 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,4096,8192,4176,8320,65536,1092,4274,524288,8320,4096,1,5204,73857,8329,5124,4274,4177,1044,75786,1024,80,5,599163,1092,136]

theorem envBound932 : H12AffineFastState.Bounded env932 := by
  intro p hp
  have h : env932.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans931_932 : H12AffineEnvironment.transform 7 4 env931 = env932 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env931 == env932) = true)

theorem identity932 : scanCanonicalize (H12AffineFastState.compose env932 (packedSelected [1,12,13] rootPS)) = affineNative (2^(18+1) ^^^ 1025) := by decide +kernel

theorem selectedBound932 : packedSelected [1,12,13] rootPS < 2^1333 := by decide +kernel

def env933 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,4096,8192,4176,8320,65536,1092,4274,1025,8320,4096,1,5204,73857,8329,5124,4274,4177,1044,75786,1024,80,5,73850,1092,136]

theorem envBound933 : H12AffineFastState.Bounded env933 := by
  intro p hp
  have h : env933.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans932_933 : H12AffineEnvironment.transform 18 1025 env932 = env933 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env932 == env933) = true)

theorem identity933 : scanCanonicalize (H12AffineFastState.compose env933 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 13375) := by decide +kernel

theorem selectedBound933 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env934 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,4096,8192,4176,8320,13375,1092,4274,1025,8320,4096,1,5204,5310,8329,5124,4274,4177,1044,7221,1024,80,5,5189,1092,136]

theorem envBound934 : H12AffineFastState.Bounded env934 := by
  intro p hp
  have h : env934.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans933_934 : H12AffineEnvironment.transform 15 13375 env933 = env934 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13375 env933 == env934) = true)

theorem identity934 : scanCanonicalize (H12AffineFastState.compose env934 (packedSelected [2,23,32] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound934 : packedSelected [2,23,32] rootPS < 2^1333 := by decide +kernel

def env935 : List Nat := [2,4,8,16,32,64,8,4,1,1024,2048,4096,8192,4176,8200,13375,1092,4154,1025,8200,4096,1,5204,5174,8193,5124,4154,4177,1044,7221,1024,80,5,5189,1092,0]

theorem envBound935 : H12AffineFastState.Bounded env935 := by
  intro p hp
  have h : env935.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans934_935 : H12AffineEnvironment.transform 6 8 env934 = env935 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env934 == env935) = true)

theorem identity935 : scanCanonicalize (H12AffineFastState.compose env935 (packedSelected [1,8,12] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound935 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env936 : List Nat := [2,4,8,16,32,17,8,4,1,1024,2048,4096,8192,4097,8200,13375,1045,4154,1025,8200,4096,1,5125,5174,8193,5124,4154,4096,1044,7221,1024,1,5,5140,1045,0]

theorem envBound936 : H12AffineFastState.Bounded env936 := by
  intro p hp
  have h : env936.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans935_936 : H12AffineEnvironment.transform 5 17 env935 = env936 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env935 == env936) = true)

theorem identity936 : scanCanonicalize (H12AffineFastState.compose env936 (packedSelected [2,5,8,11,18] rootPS)) = affineNative (2^(11+1) ^^^ 1076) := by decide +kernel

theorem selectedBound936 : packedSelected [2,5,8,11,18] rootPS < 2^1333 := by decide +kernel

def env937 : List Nat := [2,4,8,16,32,17,8,4,1,1024,2048,1076,8192,1077,8200,8203,1045,1038,1025,8200,1076,1,49,2,8193,48,1038,1076,1044,2049,1024,1,5,32,1045,0]

theorem envBound937 : H12AffineFastState.Bounded env937 := by
  intro p hp
  have h : env937.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans936_937 : H12AffineEnvironment.transform 11 1076 env936 = env937 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1076 env936 == env937) = true)

theorem identity937 : scanCanonicalize (H12AffineFastState.compose env937 (packedSelected [0] rootPS)) = affineNative (2^(12+1) ^^^ 1063) := by decide +kernel

theorem selectedBound937 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env938 : List Nat := [2,4,8,16,32,17,8,4,1,1024,2048,1076,1063,1077,1071,1068,1045,1038,1025,1071,1076,1,49,2,1062,48,1038,1076,1044,2049,1024,1,5,32,1045,0]

theorem envBound938 : H12AffineFastState.Bounded env938 := by
  intro p hp
  have h : env938.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans937_938 : H12AffineEnvironment.transform 12 1063 env937 = env938 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1063 env937 == env938) = true)

theorem identity938 : scanCanonicalize (H12AffineFastState.compose env938 (packedSelected [2] rootPS)) = affineNative (2^(10+1) ^^^ 1070) := by decide +kernel

theorem selectedBound938 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env939 : List Nat := [2,4,8,16,32,17,8,4,1,1024,1070,1076,1063,1077,1071,1068,1045,1038,1025,1071,1076,1,49,2,1062,48,1038,1076,1044,1071,1024,1,5,32,1045,0]

theorem envBound939 : H12AffineFastState.Bounded env939 := by
  intro p hp
  have h : env939.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans938_939 : H12AffineEnvironment.transform 10 1070 env938 = env939 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1070 env938 == env939) = true)

def env940 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4176,8581,65536,1344,4274,524288,8581,4096,260,5456,73856,8329,5376,4275,4177,1296,75786,1284,340,257,599163,1344,136]

theorem envBound940 : H12AffineFastState.Bounded env940 := by
  intro p hp
  have h : env940.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans930_940 : H12AffineEnvironment.transform 14 8581 env930 = env940 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8581 env930 == env940) = true)

theorem identity940 : scanCanonicalize (H12AffineFastState.compose env940 (packedSelected [7] rootPS)) = affineNative (2^(12+1) ^^^ 4283) := by decide +kernel

theorem selectedBound940 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env941 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,4283,4176,4414,65536,1344,4274,524288,4414,4096,260,5456,69691,4146,5376,4275,4177,1296,71857,1284,340,257,595136,1344,136]

theorem envBound941 : H12AffineFastState.Bounded env941 := by
  intro p hp
  have h : env941.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans940_941 : H12AffineEnvironment.transform 12 4283 env940 = env941 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4283 env940 == env941) = true)

def env942 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,4283,4176,4414,65536,1344,4274,524288,4414,4096,260,5456,69691,4146,5376,4275,4177,1296,69809,1284,340,257,595136,1344,136]

theorem envBound942 : H12AffineFastState.Bounded env942 := by
  intro p hp
  have h : env942.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans941_942 : H12AffineEnvironment.transform 10 0 env941 = env942 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env941 == env942) = true)

theorem identity942 : scanCanonicalize (H12AffineFastState.compose env942 (packedSelected [0] rootPS)) = affineNative (2^(15+1) ^^^ 171) := by decide +kernel

theorem selectedBound942 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env943 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,4283,4176,4414,171,1344,4274,524288,4414,4096,260,5456,4240,4146,5376,4275,4177,1296,4122,1284,340,257,529515,1344,136]

theorem envBound943 : H12AffineFastState.Bounded env943 := by
  intro p hp
  have h : env943.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans942_943 : H12AffineEnvironment.transform 15 171 env942 = env943 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 171 env942 == env943) = true)

theorem identity943 : scanCanonicalize (H12AffineFastState.compose env943 (packedSelected [2,4] rootPS)) = affineNative (2^(11+1) ^^^ 287) := by decide +kernel

theorem selectedBound943 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env944 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,287,420,335,33,171,1344,429,524288,33,287,260,1103,399,301,1055,428,334,1296,261,1284,340,257,525684,1344,136]

theorem envBound944 : H12AffineFastState.Bounded env944 := by
  intro p hp
  have h : env944.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans943_944 : H12AffineEnvironment.transform 11 287 env943 = env944 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 287 env943 == env944) = true)

theorem identity944 : scanCanonicalize (H12AffineFastState.compose env944 (packedSelected [2,9,11] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound944 : packedSelected [2,9,11] rootPS < 2^1333 := by decide +kernel

def env945 : List Nat := [2,4,8,16,32,64,128,5,137,1024,0,26,161,74,33,171,1093,168,524288,33,26,1,1103,138,40,1055,169,75,1045,0,1025,81,4,525425,1093,136]

theorem envBound945 : H12AffineFastState.Bounded env945 := by
  intro p hp
  have h : env945.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans944_945 : H12AffineEnvironment.transform 7 5 env944 = env945 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env944 == env945) = true)

def env946 : List Nat := [2,4,8,16,32,16,128,5,137,1024,0,26,161,26,33,171,1045,168,524288,33,26,1,1055,138,40,1055,169,27,1045,0,1025,1,4,525345,1045,136]

theorem envBound946 : H12AffineFastState.Bounded env946 := by
  intro p hp
  have h : env946.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans945_946 : H12AffineEnvironment.transform 5 16 env945 = env946 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env945 == env946) = true)

theorem identity946 : scanCanonicalize (H12AffineFastState.compose env946 (packedSelected [2] rootPS)) = affineNative (2^(9+1) ^^^ 167) := by decide +kernel

theorem selectedBound946 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env947 : List Nat := [2,4,8,16,32,16,128,5,137,167,0,26,161,26,33,171,178,168,524288,33,26,1,184,138,40,184,169,27,178,0,166,1,4,524422,178,136]

theorem envBound947 : H12AffineFastState.Bounded env947 := by
  intro p hp
  have h : env947.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans946_947 : H12AffineEnvironment.transform 9 167 env946 = env947 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 167 env946 == env947) = true)

def env948 : List Nat := [2,4,8,16,32,16,8,5,1,47,0,26,41,26,33,35,58,32,524288,33,26,1,48,2,40,48,33,27,58,0,46,1,4,524302,58,0]

theorem envBound948 : H12AffineFastState.Bounded env948 := by
  intro p hp
  have h : env948.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans947_948 : H12AffineEnvironment.transform 6 8 env947 = env948 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env947 == env948) = true)

def leafEnv948 : List Nat := [2,4,8,16,32,16,8,5,1,47,0,26,41,26,33,35,58,32,524288,33,26,1,48,2,524288,40,1,48,33,27,58,0,46,1,4,524302,4,34,58,0,0,59,1]

def active948 : List Nat := [0,1,2,3,4,18]

def tree948 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood948 : H12WitnessSearch.Good tree948 := H12GlobalWitnessIndex.good

theorem leafIdentity948 : H12AffineFastState.composeSystem env948 rootObs = leafEnv948 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env948 rootObs == leafEnv948) = true)

theorem terminalChecked948 : H12PackedTerminal.terminalCheckFast leafEnv948 active948 tree948 = true := by decide +kernel

def env949 : List Nat := [2,4,8,16,32,16,9,5,0,46,0,26,40,26,33,34,59,33,524288,33,26,1,49,3,40,49,32,27,59,0,47,1,4,524303,59,1]

theorem envBound949 : H12AffineFastState.Bounded env949 := by
  intro p hp
  have h : env949.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans947_949 : H12AffineEnvironment.transform 6 9 env947 = env949 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env947 == env949) = true)

theorem identity949 : scanCanonicalize (H12AffineFastState.compose env949 (packedSelected [1] rootPS)) = affineNative (2^(18+1) ^^^ 46) := by decide +kernel

theorem selectedBound949 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env950 : List Nat := [2,4,8,16,32,16,9,5,0,46,0,26,40,26,33,34,59,33,46,33,26,1,49,3,40,49,32,27,59,0,47,1,4,33,59,1]

theorem envBound950 : H12AffineFastState.Bounded env950 := by
  intro p hp
  have h : env950.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans949_950 : H12AffineEnvironment.transform 18 46 env949 = env950 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 46 env949 == env950) = true)

def leafEnv950 : List Nat := [2,4,8,16,32,16,9,5,0,46,0,26,40,26,33,34,59,33,46,33,26,1,49,3,46,40,1,49,32,27,59,0,47,1,4,33,4,34,59,1,0,58,1]

def active950 : List Nat := [0,1,2,3,4]

def tree950 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood950 : H12WitnessSearch.Good tree950 := H12GlobalWitnessIndex.good

theorem leafIdentity950 : H12AffineFastState.composeSystem env950 rootObs = leafEnv950 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env950 rootObs == leafEnv950) = true)

theorem terminalChecked950 : H12PackedTerminal.terminalCheckFast leafEnv950 active950 tree950 = true := by decide +kernel

def env951 : List Nat := [2,4,8,16,32,17,128,5,137,1024,0,26,161,27,33,171,1044,168,524288,33,26,1,1054,138,40,1055,169,26,1045,0,1025,0,4,525344,1044,136]

theorem envBound951 : H12AffineFastState.Bounded env951 := by
  intro p hp
  have h : env951.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans945_951 : H12AffineEnvironment.transform 5 17 env945 = env951 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env945 == env951) = true)

theorem identity951 : scanCanonicalize (H12AffineFastState.compose env951 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound951 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env952 : List Nat := [2,4,8,16,32,17,8,5,1,1024,0,26,41,27,33,35,1044,32,524288,33,26,1,1054,2,40,1055,33,26,1045,0,1025,0,4,525344,1044,0]

theorem envBound952 : H12AffineFastState.Bounded env952 := by
  intro p hp
  have h : env952.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

end H12GlobalChart2
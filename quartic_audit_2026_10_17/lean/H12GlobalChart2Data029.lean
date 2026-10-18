import H12GlobalChart2Data028

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem envTrans7097_7098 : H12AffineEnvironment.transform 17 2341 env7097 = env7098 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2341 env7097 == env7098) = true)

def env7099 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,8,1297,261,139,1297,2341,1025,261,1296,4194304,17,139,129,17,4196384,1296,1297,4196612,1285,2179,257,4196515,1296,137]

theorem envBound7099 : H12AffineFastState.Bounded env7099 := by
  intro p hp
  have h : env7099.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7098_7099 : H12AffineEnvironment.transform 8 136 env7098 = env7099 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env7098 == env7099) = true)

theorem identity7099 : scanCanonicalize (H12AffineFastState.compose env7099 (packedSelected [1] rootPS)) = affineNative (2^(21+1) ^^^ 287) := by decide +kernel

theorem selectedBound7099 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7100 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,8,1297,261,139,1297,2341,1025,261,1296,287,17,139,129,17,2367,1296,1297,2075,1285,2179,257,2492,1296,137]

theorem envBound7100 : H12AffineFastState.Bounded env7100 := by
  intro p hp
  have h : env7100.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7099_7100 : H12AffineEnvironment.transform 21 287 env7099 = env7100 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 287 env7099 == env7100) = true)

theorem identity7100 : scanCanonicalize (H12AffineFastState.compose env7100 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound7100 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env7101 : List Nat := [2,4,8,10,32,10,128,256,136,1024,2048,1290,8,1291,261,139,1291,2341,1025,261,1290,261,11,139,129,11,2341,1290,1291,2049,1285,2179,257,2470,1290,137]

theorem envBound7101 : H12AffineFastState.Bounded env7101 := by
  intro p hp
  have h : env7101.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7100_7101 : H12AffineEnvironment.transform 3 10 env7100 = env7101 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env7100 == env7101) = true)

theorem identity7101 : scanCanonicalize (H12AffineFastState.compose env7101 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 130) := by decide +kernel

theorem selectedBound7101 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7102 : List Nat := [2,4,8,10,32,10,128,256,136,1024,130,1290,8,1291,261,139,1291,423,1025,261,1290,261,11,139,129,11,423,1290,1291,131,1285,1,257,292,1290,137]

theorem envBound7102 : H12AffineFastState.Bounded env7102 := by
  intro p hp
  have h : env7102.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7101_7102 : H12AffineEnvironment.transform 10 130 env7101 = env7102 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 130 env7101 == env7102) = true)

theorem identity7102 : scanCanonicalize (H12AffineFastState.compose env7102 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound7102 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env7103 : List Nat := [2,4,8,10,32,10,128,37,136,1024,130,1071,8,1070,32,139,1070,130,1025,32,1071,32,11,139,129,11,130,1071,1070,131,1056,1,36,1,1071,137]

theorem envBound7103 : H12AffineFastState.Bounded env7103 := by
  intro p hp
  have h : env7103.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7102_7103 : H12AffineEnvironment.transform 7 37 env7102 = env7103 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env7102 == env7103) = true)

theorem identity7103 : scanCanonicalize (H12AffineFastState.compose env7103 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 35) := by decide +kernel

theorem selectedBound7103 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7104 : List Nat := [2,4,8,10,32,10,35,37,43,1024,33,1071,8,1070,32,40,1070,33,1025,32,1071,32,11,40,34,11,33,1071,1070,32,1056,1,36,1,1071,42]

theorem envBound7104 : H12AffineFastState.Bounded env7104 := by
  intro p hp
  have h : env7104.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7103_7104 : H12AffineEnvironment.transform 6 35 env7103 = env7104 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 35 env7103 == env7104) = true)

def env7105 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,9,1297,261,139,1296,2341,1025,261,1297,4194304,17,138,128,16,4196384,1296,1296,4196612,1284,2179,257,4196515,1297,136]

theorem envBound7105 : H12AffineFastState.Bounded env7105 := by
  intro p hp
  have h : env7105.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7098_7105 : H12AffineEnvironment.transform 8 137 env7098 = env7105 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env7098 == env7105) = true)

theorem identity7105 : scanCanonicalize (H12AffineFastState.compose env7105 (packedSelected [1] rootPS)) = affineNative (2^(21+1) ^^^ 162) := by decide +kernel

theorem selectedBound7105 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7106 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,9,1297,261,139,1296,2341,1025,261,1297,162,17,138,128,16,2178,1296,1296,2470,1284,2179,257,2049,1297,136]

theorem envBound7106 : H12AffineFastState.Bounded env7106 := by
  intro p hp
  have h : env7106.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7105_7106 : H12AffineEnvironment.transform 21 162 env7105 = env7106 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 162 env7105 == env7106) = true)

theorem identity7106 : scanCanonicalize (H12AffineFastState.compose env7106 (packedSelected [3] rootPS)) = affineNative (2^(10+1) ^^^ 43) := by decide +kernel

theorem selectedBound7106 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env7107 : List Nat := [2,4,8,16,32,16,128,256,137,1024,43,1297,9,1297,261,139,1296,270,1025,261,1297,162,17,138,128,16,169,1296,1296,397,1284,168,257,42,1297,136]

theorem envBound7107 : H12AffineFastState.Bounded env7107 := by
  intro p hp
  have h : env7107.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7106_7107 : H12AffineEnvironment.transform 10 43 env7106 = env7107 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 43 env7106 == env7107) = true)

theorem identity7107 : scanCanonicalize (H12AffineFastState.compose env7107 (packedSelected [0,4] rootPS)) = affineNative (2^(7+1) ^^^ 156) := by decide +kernel

theorem selectedBound7107 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env7108 : List Nat := [2,4,8,16,32,16,128,156,137,1024,43,1165,9,1165,153,139,1164,146,1025,153,1165,162,17,138,128,16,169,1164,1164,17,1176,168,157,42,1165,136]

theorem envBound7108 : H12AffineFastState.Bounded env7108 := by
  intro p hp
  have h : env7108.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7107_7108 : H12AffineEnvironment.transform 7 156 env7107 = env7108 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 156 env7107 == env7108) = true)

theorem identity7108 : scanCanonicalize (H12AffineFastState.compose env7108 (packedSelected [5] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound7108 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env7109 : List Nat := [2,4,8,16,1,16,128,156,137,1024,10,1165,9,1165,153,139,1164,146,1025,153,1165,131,17,138,128,16,136,1164,1164,17,1176,137,157,11,1165,136]

theorem envBound7109 : H12AffineFastState.Bounded env7109 := by
  intro p hp
  have h : env7109.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7108_7109 : H12AffineEnvironment.transform 4 1 env7108 = env7109 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env7108 == env7109) = true)

theorem identity7109 : scanCanonicalize (H12AffineFastState.compose env7109 (packedSelected [10] rootPS)) = affineNative (2^(6+1) ^^^ 18) := by decide +kernel

theorem selectedBound7109 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env7110 : List Nat := [2,4,8,16,1,16,18,14,27,1024,10,1055,9,1055,11,25,1054,0,1025,11,1055,17,17,24,18,16,26,1054,1054,17,1034,27,15,11,1055,26]

theorem envBound7110 : H12AffineFastState.Bounded env7110 := by
  intro p hp
  have h : env7110.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7109_7110 : H12AffineEnvironment.transform 6 18 env7109 = env7110 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 18 env7109 == env7110) = true)

theorem identity7110 : scanCanonicalize (H12AffineFastState.compose env7110 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound7110 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7111 : List Nat := [2,4,8,1,1,1,3,14,10,1024,10,1038,9,1038,11,8,1039,0,1025,11,1038,0,0,9,3,1,11,1039,1039,0,1034,10,15,11,1038,11]

theorem envBound7111 : H12AffineFastState.Bounded env7111 := by
  intro p hp
  have h : env7111.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7110_7111 : H12AffineEnvironment.transform 3 1 env7110 = env7111 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7110 == env7111) = true)

theorem identity7111 : scanCanonicalize (H12AffineFastState.compose env7111 (packedSelected [7] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound7111 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env7112 : List Nat := [2,4,3,1,1,1,3,5,1,1024,1,1029,2,1029,0,3,1028,0,1025,0,1029,0,0,2,3,1,0,1028,1028,0,1025,1,4,0,1029,0]

theorem envBound7112 : H12AffineFastState.Bounded env7112 := by
  intro p hp
  have h : env7112.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7111_7112 : H12AffineEnvironment.transform 2 3 env7111 = env7112 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env7111 == env7112) = true)

def leafEnv7112 : List Nat := [2,4,3,1,1,1,3,5,1,1024,1,1029,2,1029,0,3,1028,0,1025,0,1029,0,0,2,1024,3,1,1,0,1028,1028,0,1025,1,4,0,5,2,1029,0,0,1028,1]

def active7112 : List Nat := [0,1,9]

def tree7112 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7112 : H12WitnessSearch.Good tree7112 := H12GlobalWitnessIndex.good

theorem leafIdentity7112 : H12AffineFastState.composeSystem env7112 rootObs = leafEnv7112 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7112 rootObs == leafEnv7112) = true)

theorem terminalChecked7112 : H12PackedTerminal.terminalCheckFast leafEnv7112 active7112 tree7112 = true := by decide +kernel

def env7113 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,16777216,33554432,17010965,21352449,17024021,131072,21105822,16876544,4294967296,257,4332967606,131073,33554441]

theorem envBound7113 : H12AffineFastState.Bounded env7113 := by
  intro p hp
  have h : env7113.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7051_7113 : H12AffineEnvironment.transform 12 641 env7051 = env7113 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 641 env7051 == env7113) = true)

def env7114 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,16777216,33554432,16875797,21352449,16897045,4096,20978846,16876544,4294967296,257,4332832438,4097,33554441]

theorem envBound7114 : H12AffineFastState.Bounded env7114 := by
  intro p hp
  have h : env7114.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7113_7114 : H12AffineEnvironment.transform 16 4096 env7113 = env7114 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env7113 == env7114) = true)

theorem identity7114 : scanCanonicalize (H12AffineFastState.compose env7114 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(24+1) ^^^ 16880789) := by decide +kernel

theorem selectedBound7114 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env7115 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,16777216,16880789,16875797,21352449,16897045,4096,20978846,16876544,4294967296,257,4315959843,4097,16880796]

theorem envBound7115 : H12AffineFastState.Bounded env7115 := by
  intro p hp
  have h : env7115.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7114_7115 : H12AffineEnvironment.transform 24 16880789 env7114 = env7115 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 16880789 env7114 == env7115) = true)

def env7116 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,9,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,16777216,16880789,16875797,21352449,16897045,4096,20978846,16876544,4294967296,257,4315959467,4097,16880796]

theorem envBound7116 : H12AffineFastState.Bounded env7116 := by
  intro p hp
  have h : env7116.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7115_7116 : H12AffineEnvironment.transform 8 136 env7115 = env7116 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env7115 == env7116) = true)

theorem identity7116 : scanCanonicalize (H12AffineFastState.compose env7116 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(13+1) ^^^ 4097) := by decide +kernel

theorem selectedBound7116 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env7117 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,9,4097,32768,65536,4096,262144,1025,32768,4096,4194304,5377,16777216,16880789,16875797,21331968,16876564,4096,20978846,16876544,4294967296,257,4315938986,4097,16880796]

theorem envBound7117 : H12AffineFastState.Bounded env7117 := by
  intro p hp
  have h : env7117.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7116_7117 : H12AffineEnvironment.transform 13 4097 env7116 = env7117 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4097 env7116 == env7117) = true)

theorem identity7117 : scanCanonicalize (H12AffineFastState.compose env7117 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound7117 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env7118 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,9,1297,32768,65536,1296,262144,1025,32768,1296,4194304,17,16777216,16875909,16875797,21331968,16876564,1296,20973966,16876544,4294967296,257,4315938986,1297,16875916]

theorem envBound7118 : H12AffineFastState.Bounded env7118 := by
  intro p hp
  have h : env7118.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7117_7118 : H12AffineEnvironment.transform 11 1296 env7117 = env7118 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env7117 == env7118) = true)

theorem identity7118 : scanCanonicalize (H12AffineFastState.compose env7118 (packedSelected [1,3,4,9,12,13,15,16,17] rootPS)) = affineNative (2^(23+1) ^^^ 4524200) := by decide +kernel

theorem selectedBound7118 : packedSelected [1,3,4,9,12,13,15,16,17] rootPS < 2^1333 := by decide +kernel

def env7119 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,9,1297,32768,65536,1296,262144,1025,32768,1296,4194304,17,4524200,4491565,4491709,34984,4492476,1296,327974,4492456,4294967296,257,4295297026,1297,4491556]

theorem envBound7119 : H12AffineFastState.Bounded env7119 := by
  intro p hp
  have h : env7119.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7118_7119 : H12AffineEnvironment.transform 23 4524200 env7118 = env7119 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 4524200 env7118 == env7119) = true)

def env7120 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,16777216,16880789,16875797,21352449,16897045,4096,20978846,16876544,4294967296,257,4315959466,4097,16880796]

theorem envBound7120 : H12AffineFastState.Bounded env7120 := by
  intro p hp
  have h : env7120.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7115_7120 : H12AffineEnvironment.transform 8 137 env7115 = env7120 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env7115 == env7120) = true)

theorem identity7120 : scanCanonicalize (H12AffineFastState.compose env7120 (packedSelected [1,3,10,19,24,26,28,31] rootPS)) = affineNative (2^(23+1) ^^^ 103444) := by decide +kernel

theorem selectedBound7120 : packedSelected [1,3,10,19,24,26,28,31] rootPS < 2^1333 := by decide +kernel

def env7121 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,103444,129,5377,4473877,16385,4096,4294794,4116,4294967296,257,4299277502,4097,136]

theorem envBound7121 : H12AffineFastState.Bounded env7121 := by
  intro p hp
  have h : env7121.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7120_7121 : H12AffineEnvironment.transform 23 103444 env7120 = env7121 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 103444 env7120 == env7121) = true)

def env7122 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,16384,32768,65536,4096,262144,1025,32768,4096,32904,17664,103444,129,5377,312477,16385,4096,67586,4116,4294967296,257,4295050294,4097,136]

theorem envBound7122 : H12AffineFastState.Bounded env7122 := by
  intro p hp
  have h : env7122.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7121_7122 : H12AffineEnvironment.transform 21 32904 env7121 = env7122 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 32904 env7121 == env7122) = true)

theorem identity7122 : scanCanonicalize (H12AffineFastState.compose env7122 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 262566) := by decide +kernel

theorem selectedBound7122 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7123 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,16384,32768,65536,4096,262144,1025,32768,4096,32904,17664,103444,129,5377,312477,16385,4096,67586,4116,262566,257,345488,4097,136]

theorem envBound7123 : H12AffineFastState.Bounded env7123 := by
  intro p hp
  have h : env7123.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7122_7123 : H12AffineEnvironment.transform 31 262566 env7122 = env7123 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 262566 env7122 == env7123) = true)

theorem identity7123 : scanCanonicalize (H12AffineFastState.compose env7123 (packedSelected [1,3,4,9,13,16,17,24,28] rootPS)) = affineNative (2^(13+1) ^^^ 4096) := by decide +kernel

theorem selectedBound7123 : packedSelected [1,3,4,9,13,16,17,24,28] rootPS < 2^1333 := by decide +kernel

def env7124 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,4096,32768,65536,4096,262144,1025,32768,4096,32904,5376,103444,129,5377,300189,4097,4096,67586,4116,262566,257,333200,4097,136]

theorem envBound7124 : H12AffineFastState.Bounded env7124 := by
  intro p hp
  have h : env7124.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7123_7124 : H12AffineEnvironment.transform 13 4096 env7123 = env7124 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4096 env7123 == env7124) = true)

theorem identity7124 : scanCanonicalize (H12AffineFastState.compose env7124 (packedSelected [4,9,16] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound7124 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env7125 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,8,1296,32768,65536,1296,262144,1025,32768,1296,32904,16,98564,129,17,295309,1297,1296,67586,1284,262566,257,327808,1297,136]

theorem envBound7125 : H12AffineFastState.Bounded env7125 := by
  intro p hp
  have h : env7125.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7124_7125 : H12AffineEnvironment.transform 11 1296 env7124 = env7125 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env7124 == env7125) = true)

theorem identity7125 : scanCanonicalize (H12AffineFastState.compose env7125 (packedSelected [1,3,5] rootPS)) = affineNative (2^(15+1) ^^^ 34987) := by decide +kernel

theorem selectedBound7125 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env7126 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,8,1296,32768,34987,1296,262144,1025,32768,1296,32904,16,2479,129,17,295309,1297,1296,32937,1284,262566,257,297003,1297,136]

theorem envBound7126 : H12AffineFastState.Bounded env7126 := by
  intro p hp
  have h : env7126.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7125_7126 : H12AffineEnvironment.transform 15 34987 env7125 = env7126 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 34987 env7125 == env7126) = true)

theorem identity7126 : scanCanonicalize (H12AffineFastState.compose env7126 (packedSelected [1,3,8] rootPS)) = affineNative (2^(17+1) ^^^ 34849) := by decide +kernel

theorem selectedBound7126 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env7127 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,8,1296,32768,34987,1296,34849,1025,32768,1296,32904,16,2479,129,17,2476,1297,1296,32937,1284,35207,257,10,1297,136]

theorem envBound7127 : H12AffineFastState.Bounded env7127 := by
  intro p hp
  have h : env7127.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7126_7127 : H12AffineEnvironment.transform 17 34849 env7126 = env7127 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 34849 env7126 == env7127) = true)

theorem identity7127 : scanCanonicalize (H12AffineFastState.compose env7127 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound7127 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7128 : List Nat := [2,4,8,16,11,16,128,256,137,1024,2048,1296,8,1296,32768,34944,1296,34826,1025,32768,1296,32904,16,2436,129,17,2439,1297,1296,32898,1284,35207,257,10,1297,136]

theorem envBound7128 : H12AffineFastState.Bounded env7128 := by
  intro p hp
  have h : env7128.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7127_7128 : H12AffineEnvironment.transform 4 11 env7127 = env7128 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env7127 == env7128) = true)

theorem identity7128 : scanCanonicalize (H12AffineFastState.compose env7128 (packedSelected [10] rootPS)) = affineNative (2^(14+1) ^^^ 261) := by decide +kernel

theorem selectedBound7128 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env7129 : List Nat := [2,4,8,16,11,16,128,256,137,1024,2048,1296,8,1296,261,2437,1296,2319,1025,261,1296,397,16,2436,129,17,2439,1297,1296,391,1284,2178,257,10,1297,136]

theorem envBound7129 : H12AffineFastState.Bounded env7129 := by
  intro p hp
  have h : env7129.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7128_7129 : H12AffineEnvironment.transform 14 261 env7128 = env7129 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 261 env7128 == env7129) = true)

theorem identity7129 : scanCanonicalize (H12AffineFastState.compose env7129 (packedSelected [3,12] rootPS)) = affineNative (2^(7+1) ^^^ 141) := by decide +kernel

theorem selectedBound7129 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env7130 : List Nat := [2,4,8,16,11,16,128,141,137,1024,2048,1181,8,1181,136,2056,1181,2178,1025,136,1181,0,16,2057,129,17,2058,1180,1181,10,1161,2178,140,10,1180,136]

theorem envBound7130 : H12AffineFastState.Bounded env7130 := by
  intro p hp
  have h : env7130.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7129_7130 : H12AffineEnvironment.transform 7 141 env7129 = env7130 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 141 env7129 == env7130) = true)

theorem identity7130 : scanCanonicalize (H12AffineFastState.compose env7130 (packedSelected [4,7] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound7130 : packedSelected [4,7] rootPS < 2^1333 := by decide +kernel

def env7131 : List Nat := [2,4,8,10,11,10,128,141,137,1024,2048,1159,8,1159,136,2056,1159,2178,1025,136,1159,0,10,2057,129,11,2058,1158,1159,10,1161,2178,140,10,1158,136]

theorem envBound7131 : H12AffineFastState.Bounded env7131 := by
  intro p hp
  have h : env7131.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7130_7131 : H12AffineEnvironment.transform 3 10 env7130 = env7131 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env7130 == env7131) = true)

theorem identity7131 : scanCanonicalize (H12AffineFastState.compose env7131 (packedSelected [0,2,4,9] rootPS)) = affineNative (2^(10+1) ^^^ 137) := by decide +kernel

theorem selectedBound7131 : packedSelected [0,2,4,9] rootPS < 2^1333 := by decide +kernel

def env7132 : List Nat := [2,4,8,10,11,10,128,141,137,1024,137,1159,8,1159,136,129,1159,11,1025,136,1159,0,10,128,129,11,131,1158,1159,10,1161,11,140,10,1158,136]

theorem envBound7132 : H12AffineFastState.Bounded env7132 := by
  intro p hp
  have h : env7132.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7131_7132 : H12AffineEnvironment.transform 10 137 env7131 = env7132 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 137 env7131 == env7132) = true)

theorem identity7132 : scanCanonicalize (H12AffineFastState.compose env7132 (packedSelected [0,2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound7132 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env7133 : List Nat := [2,4,2,0,1,0,128,135,131,1024,131,1159,2,1159,130,129,1159,1,1025,130,1159,0,0,128,129,1,131,1158,1159,0,1155,1,134,0,1158,130]

theorem envBound7133 : H12AffineFastState.Bounded env7133 := by
  intro p hp
  have h : env7133.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7132_7133 : H12AffineEnvironment.transform 2 2 env7132 = env7133 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env7132 == env7133) = true)

theorem identity7133 : scanCanonicalize (H12AffineFastState.compose env7133 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound7133 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7134 : List Nat := [2,4,2,0,1,0,2,5,1,1024,1,1029,2,1029,0,3,1029,1,1025,0,1029,0,0,2,3,1,1,1028,1029,0,1025,1,4,0,1028,0]

theorem envBound7134 : H12AffineFastState.Bounded env7134 := by
  intro p hp
  have h : env7134.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7133_7134 : H12AffineEnvironment.transform 6 2 env7133 = env7134 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env7133 == env7134) = true)

def leafEnv7134 : List Nat := [2,4,2,0,1,0,2,5,1,1024,1,1029,2,1029,0,3,1029,1,1025,0,1029,0,0,2,1024,3,1,1,1,1028,1029,0,1025,1,4,0,5,2,1028,0,0,1029,1]

def active7134 : List Nat := [0,1,9]

def tree7134 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7134 : H12WitnessSearch.Good tree7134 := H12GlobalWitnessIndex.good

theorem leafIdentity7134 : H12AffineFastState.composeSystem env7134 rootObs = leafEnv7134 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7134 rootObs == leafEnv7134) = true)

theorem terminalChecked7134 : H12PackedTerminal.terminalCheckFast leafEnv7134 active7134 tree7134 = true := by decide +kernel

def env7135 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,16384,32768,65536,4096,262144,1025,32768,4096,32905,17664,103444,129,5377,312476,16385,4096,67587,4116,4294967296,257,4295050295,4097,136]

theorem envBound7135 : H12AffineFastState.Bounded env7135 := by
  intro p hp
  have h : env7135.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7121_7135 : H12AffineEnvironment.transform 21 32905 env7121 = env7135 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 32905 env7121 == env7135) = true)

theorem identity7135 : scanCanonicalize (H12AffineFastState.compose env7135 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 300466) := by decide +kernel

theorem selectedBound7135 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7136 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,16384,32768,65536,4096,262144,1025,32768,4096,32905,17664,103444,129,5377,312476,16385,4096,67587,4116,300466,257,381317,4097,136]

theorem envBound7136 : H12AffineFastState.Bounded env7136 := by
  intro p hp
  have h : env7136.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7135_7136 : H12AffineEnvironment.transform 31 300466 env7135 = env7136 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 300466 env7135 == env7136) = true)

def env7137 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,16777216,33554432,16875796,21352449,16897044,4097,20978847,16876544,4294967296,257,4332832439,4096,33554441]

theorem envBound7137 : H12AffineFastState.Bounded env7137 := by
  intro p hp
  have h : env7137.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7113_7137 : H12AffineEnvironment.transform 16 4097 env7113 = env7137 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env7113 == env7137) = true)

theorem identity7137 : scanCanonicalize (H12AffineFastState.compose env7137 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(24+1) ^^^ 16875909) := by decide +kernel

theorem selectedBound7137 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env7138 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,16777216,16875909,16875796,21352449,16897044,4097,20978847,16876544,4294967296,257,4315957042,4096,16875916]

theorem envBound7138 : H12AffineFastState.Bounded env7138 := by
  intro p hp
  have h : env7138.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7137_7138 : H12AffineEnvironment.transform 24 16875909 env7137 = env7138 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 16875909 env7137 == env7138) = true)

def env7139 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,1296,32768,65536,4097,262144,1025,32768,4096,4194304,16,16777216,16875909,16875796,21337361,16879876,4097,20978847,16876544,4294967296,257,4315939362,4096,16875916]

theorem envBound7139 : H12AffineFastState.Bounded env7139 := by
  intro p hp
  have h : env7139.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7138_7139 : H12AffineEnvironment.transform 13 1296 env7138 = env7139 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1296 env7138 == env7139) = true)

theorem identity7139 : scanCanonicalize (H12AffineFastState.compose env7139 (packedSelected [3,6,10,24,25,26] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound7139 : packedSelected [3,6,10,24,25,26] rootPS < 2^1333 := by decide +kernel

def env7140 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1297,641,1296,32768,65536,1296,262144,1025,32768,1297,4194304,16,16777216,16875909,16875796,21331968,16876565,1296,20973966,16876544,4294967296,257,4315939362,1297,16875916]

theorem envBound7140 : H12AffineFastState.Bounded env7140 := by
  intro p hp
  have h : env7140.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7139_7140 : H12AffineEnvironment.transform 11 1297 env7139 = env7140 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env7139 == env7140) = true)

theorem identity7140 : scanCanonicalize (H12AffineFastState.compose env7140 (packedSelected [1,3,5,6,8,10,19,25] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound7140 : packedSelected [1,3,5,6,8,10,19,25] rootPS < 2^1333 := by decide +kernel

def env7141 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8,1296,32768,65536,1296,262144,1025,32768,1297,4194304,16,16777216,16875909,16875796,21331968,16876565,1296,20973966,16876544,4294967296,257,4315938987,1297,16875916]

theorem envBound7141 : H12AffineFastState.Bounded env7141 := by
  intro p hp
  have h : env7141.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7140_7141 : H12AffineEnvironment.transform 8 137 env7140 = env7141 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env7140 == env7141) = true)

theorem identity7141 : scanCanonicalize (H12AffineFastState.compose env7141 (packedSelected [1,3,4,9,12,13,15,16,17] rootPS)) = affineNative (2^(23+1) ^^^ 330021) := by decide +kernel

theorem selectedBound7141 : packedSelected [1,3,4,9,12,13,15,16,17] rootPS < 2^1333 := by decide +kernel

def env7142 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8,1296,32768,65536,1296,262144,1025,32768,1297,4194304,16,330021,297120,297009,4229413,298288,1296,4522155,298277,4294967296,257,4299491726,1297,297129]

theorem envBound7142 : H12AffineFastState.Bounded env7142 := by
  intro p hp
  have h : env7142.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7141_7142 : H12AffineEnvironment.transform 23 330021 env7141 = env7142 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 330021 env7141 == env7142) = true)

theorem identity7142 : scanCanonicalize (H12AffineFastState.compose env7142 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(17+1) ^^^ 34849) := by decide +kernel

theorem selectedBound7142 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env7143 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8,1296,32768,65536,1296,34849,1025,32768,1297,4194304,16,98564,129,16,4229413,1297,1296,4294794,1284,4294967296,257,4299260335,1297,136]

theorem envBound7143 : H12AffineFastState.Bounded env7143 := by
  intro p hp
  have h : env7143.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7142_7143 : H12AffineEnvironment.transform 17 34849 env7142 = env7143 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 34849 env7142 == env7143) = true)

theorem identity7143 : scanCanonicalize (H12AffineFastState.compose env7143 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 4195469) := by decide +kernel

theorem selectedBound7143 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7144 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8,1296,32768,65536,1296,34849,1025,32768,1297,4194304,16,98564,129,16,4229413,1297,1296,4294794,1284,4195469,257,99618,1297,136]

theorem envBound7144 : H12AffineFastState.Bounded env7144 := by
  intro p hp
  have h : env7144.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7143_7144 : H12AffineEnvironment.transform 31 4195469 env7143 = env7144 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4195469 env7143 == env7144) = true)

theorem identity7144 : scanCanonicalize (H12AffineFastState.compose env7144 (packedSelected [3,5] rootPS)) = affineNative (2^(21+1) ^^^ 2476) := by decide +kernel

theorem selectedBound7144 : packedSelected [3,5] rootPS < 2^1333 := by decide +kernel

def env7145 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8,1296,32768,65536,1296,34849,1025,32768,1297,2476,16,98564,129,16,32905,1297,1296,98598,1284,3361,257,99618,1297,136]

theorem envBound7145 : H12AffineFastState.Bounded env7145 := by
  intro p hp
  have h : env7145.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7144_7145 : H12AffineEnvironment.transform 21 2476 env7144 = env7145 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 2476 env7144 == env7145) = true)

theorem identity7145 : scanCanonicalize (H12AffineFastState.compose env7145 (packedSelected [3,8] rootPS)) = affineNative (2^(15+1) ^^^ 33166) := by decide +kernel

theorem selectedBound7145 : packedSelected [3,8] rootPS < 2^1333 := by decide +kernel

def env7146 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8,1296,32768,33166,1296,34849,1025,32768,1297,2476,16,138,129,16,32905,1297,1296,168,1284,3361,257,1196,1297,136]

theorem envBound7146 : H12AffineFastState.Bounded env7146 := by
  intro p hp
  have h : env7146.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7145_7146 : H12AffineEnvironment.transform 15 33166 env7145 = env7146 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33166 env7145 == env7146) = true)

theorem identity7146 : scanCanonicalize (H12AffineFastState.compose env7146 (packedSelected [3] rootPS)) = affineNative (2^(14+1) ^^^ 1329) := by decide +kernel

theorem selectedBound7146 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env7147 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8,1296,1329,1215,1296,3344,1025,1329,1297,2476,16,138,129,16,1464,1297,1296,168,1284,3361,257,1196,1297,136]

theorem envBound7147 : H12AffineFastState.Bounded env7147 := by
  intro p hp
  have h : env7147.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7146_7147 : H12AffineEnvironment.transform 14 1329 env7146 = env7147 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 1329 env7146 == env7147) = true)

theorem identity7147 : scanCanonicalize (H12AffineFastState.compose env7147 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(10+1) ^^^ 1464) := by decide +kernel

theorem selectedBound7147 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env7148 : List Nat := [2,4,8,16,32,16,128,256,137,1024,1464,1297,8,1296,1329,1215,1296,168,1025,1329,1297,1044,16,138,129,16,1464,1297,1296,168,1284,153,257,1196,1297,136]

theorem envBound7148 : H12AffineFastState.Bounded env7148 := by
  intro p hp
  have h : env7148.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7147_7148 : H12AffineEnvironment.transform 10 1464 env7147 = env7148 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1464 env7147 == env7148) = true)

theorem identity7148 : scanCanonicalize (H12AffineFastState.compose env7148 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(9+1) ^^^ 441) := by decide +kernel

theorem selectedBound7148 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env7149 : List Nat := [2,4,8,16,32,16,128,256,137,441,1,168,8,169,136,262,169,168,440,136,168,429,16,138,129,16,1,168,169,168,189,153,257,277,168,136]

theorem envBound7149 : H12AffineFastState.Bounded env7149 := by
  intro p hp
  have h : env7149.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7148_7149 : H12AffineEnvironment.transform 9 441 env7148 = env7149 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 441 env7148 == env7149) = true)

theorem identity7149 : scanCanonicalize (H12AffineFastState.compose env7149 (packedSelected [0,7] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound7149 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env7150 : List Nat := [2,4,8,16,32,16,128,5,137,188,1,168,8,169,136,3,169,168,189,136,168,168,16,138,129,16,1,168,169,168,189,153,4,16,168,136]

theorem envBound7150 : H12AffineFastState.Bounded env7150 := by
  intro p hp
  have h : env7150.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7149_7150 : H12AffineEnvironment.transform 7 5 env7149 = env7150 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env7149 == env7150) = true)

theorem identity7150 : scanCanonicalize (H12AffineFastState.compose env7150 (packedSelected [2,4] rootPS)) = affineNative (2^(6+1) ^^^ 40) := by decide +kernel

theorem selectedBound7150 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env7151 : List Nat := [2,4,8,16,32,16,40,5,33,20,1,0,8,1,32,3,1,0,21,32,0,0,16,34,41,16,1,0,1,0,21,49,4,16,0,32]

theorem envBound7151 : H12AffineFastState.Bounded env7151 := by
  intro p hp
  have h : env7151.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7150_7151 : H12AffineEnvironment.transform 6 40 env7150 = env7151 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 40 env7150 == env7151) = true)

theorem identity7151 : scanCanonicalize (H12AffineFastState.compose env7151 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 27) := by decide +kernel

theorem selectedBound7151 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7152 : List Nat := [2,4,8,16,27,16,19,5,26,20,1,0,8,1,27,3,1,0,21,27,0,0,16,25,18,16,1,0,1,0,21,10,4,16,0,27]

theorem envBound7152 : H12AffineFastState.Bounded env7152 := by
  intro p hp
  have h : env7152.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7151_7152 : H12AffineEnvironment.transform 4 27 env7151 = env7152 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 27 env7151 == env7152) = true)

def env7153 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,1297,32768,65536,4097,262144,1025,32768,4096,4194304,17,16777216,16875909,16875796,21337360,16879877,4097,20978847,16876544,4294967296,257,4315939363,4096,16875916]

theorem envBound7153 : H12AffineFastState.Bounded env7153 := by
  intro p hp
  have h : env7153.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7138_7153 : H12AffineEnvironment.transform 13 1297 env7138 = env7153 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1297 env7138 == env7153) = true)

theorem identity7153 : scanCanonicalize (H12AffineFastState.compose env7153 (packedSelected [3,6,10,24,25,26] rootPS)) = affineNative (2^(11+1) ^^^ 1944) := by decide +kernel

theorem selectedBound7153 : packedSelected [3,6,10,24,25,26] rootPS < 2^1333 := by decide +kernel

def env7154 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,641,1297,32768,65536,1945,262144,1025,32768,1944,4194304,17,16777216,16875909,16875796,21332616,16877213,1945,20974343,16876544,4294967296,257,4315939363,1944,16875916]

theorem envBound7154 : H12AffineFastState.Bounded env7154 := by
  intro p hp
  have h : env7154.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7153_7154 : H12AffineEnvironment.transform 11 1944 env7153 = env7154 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env7153 == env7154) = true)

theorem identity7154 : scanCanonicalize (H12AffineFastState.compose env7154 (packedSelected [3,5,6,8,10,25,28,31] rootPS)) = affineNative (2^(23+1) ^^^ 99213) := by decide +kernel

theorem selectedBound7154 : packedSelected [3,5,6,8,10,25,28,31] rootPS < 2^1333 := by decide +kernel

def env7155 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,641,1297,32768,65536,1945,262144,1025,32768,1944,4194304,17,99213,520,665,4456709,1296,1945,4294794,1933,4294967296,257,4299260334,1944,513]

theorem envBound7155 : H12AffineFastState.Bounded env7155 := by
  intro p hp
  have h : env7155.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7154_7155 : H12AffineEnvironment.transform 23 99213 env7154 = env7155 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 99213 env7154 == env7155) = true)

theorem identity7155 : scanCanonicalize (H12AffineFastState.compose env7155 (packedSelected [5,8,17,21] rootPS)) = affineNative (2^(14+1) ^^^ 260) := by decide +kernel

theorem selectedBound7155 : packedSelected [5,8,17,21] rootPS < 2^1333 := by decide +kernel

def env7156 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,641,1297,260,65536,1945,262144,1025,260,1944,4194304,17,66185,520,665,4456709,1296,1945,4262286,1933,4294967296,257,4299227306,1944,513]

theorem envBound7156 : H12AffineFastState.Bounded env7156 := by
  intro p hp
  have h : env7156.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7155_7156 : H12AffineEnvironment.transform 14 260 env7155 = env7156 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 260 env7155 == env7156) = true)

theorem identity7156 : scanCanonicalize (H12AffineFastState.compose env7156 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 262959) := by decide +kernel

theorem selectedBound7156 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7157 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,641,1297,260,65536,1945,262144,1025,260,1944,4194304,17,66185,520,665,4456709,1296,1945,4262286,1933,262959,257,4522885,1944,513]

theorem envBound7157 : H12AffineFastState.Bounded env7157 := by
  intro p hp
  have h : env7157.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7156_7157 : H12AffineEnvironment.transform 31 262959 env7156 = env7157 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 262959 env7156 == env7157) = true)

theorem identity7157 : scanCanonicalize (H12AffineFastState.compose env7157 (packedSelected [10,12,17] rootPS)) = affineNative (2^(15+1) ^^^ 138) := by decide +kernel

theorem selectedBound7157 : packedSelected [10,12,17] rootPS < 2^1333 := by decide +kernel

def env7158 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,641,1297,260,138,1945,262144,1025,260,1944,4194304,17,515,520,665,4456709,1296,1945,4196612,1933,262959,257,4457231,1944,513]

theorem envBound7158 : H12AffineFastState.Bounded env7158 := by
  intro p hp
  have h : env7158.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7157_7158 : H12AffineEnvironment.transform 15 138 env7157 = env7158 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 138 env7157 == env7158) = true)

theorem identity7158 : scanCanonicalize (H12AffineFastState.compose env7158 (packedSelected [1,5,8,24] rootPS)) = affineNative (2^(17+1) ^^^ 2341) := by decide +kernel

theorem selectedBound7158 : packedSelected [1,5,8,24] rootPS < 2^1333 := by decide +kernel

def env7159 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,641,1297,260,138,1945,2341,1025,260,1944,4194304,17,515,520,665,4196384,1296,1945,4196612,1933,2570,257,4196906,1944,513]

theorem envBound7159 : H12AffineFastState.Bounded env7159 := by
  intro p hp
  have h : env7159.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7158_7159 : H12AffineEnvironment.transform 17 2341 env7158 = env7159 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2341 env7158 == env7159) = true)

def env7160 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,9,1297,260,138,1297,2341,1025,260,1296,4194304,17,139,128,17,4196384,1296,1297,4196612,1285,2178,257,4196514,1296,137]

theorem envBound7160 : H12AffineFastState.Bounded env7160 := by
  intro p hp
  have h : env7160.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7159_7160 : H12AffineEnvironment.transform 8 136 env7159 = env7160 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env7159 == env7160) = true)

theorem identity7160 : scanCanonicalize (H12AffineFastState.compose env7160 (packedSelected [1] rootPS)) = affineNative (2^(21+1) ^^^ 287) := by decide +kernel

theorem selectedBound7160 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7161 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,9,1297,260,138,1297,2341,1025,260,1296,287,17,139,128,17,2367,1296,1297,2075,1285,2178,257,2493,1296,137]

theorem envBound7161 : H12AffineFastState.Bounded env7161 := by
  intro p hp
  have h : env7161.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7160_7161 : H12AffineEnvironment.transform 21 287 env7160 = env7161 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 287 env7160 == env7161) = true)

theorem identity7161 : scanCanonicalize (H12AffineFastState.compose env7161 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound7161 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env7162 : List Nat := [2,4,8,10,32,10,128,256,136,1024,2048,1290,9,1291,260,138,1291,2341,1025,260,1290,261,11,139,128,11,2341,1290,1291,2049,1285,2178,257,2471,1290,137]

theorem envBound7162 : H12AffineFastState.Bounded env7162 := by
  intro p hp
  have h : env7162.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7161_7162 : H12AffineEnvironment.transform 3 10 env7161 = env7162 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env7161 == env7162) = true)

theorem identity7162 : scanCanonicalize (H12AffineFastState.compose env7162 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 131) := by decide +kernel

theorem selectedBound7162 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7163 : List Nat := [2,4,8,10,32,10,128,256,136,1024,131,1290,9,1291,260,138,1291,422,1025,260,1290,261,11,139,128,11,422,1290,1291,130,1285,1,257,292,1290,137]

theorem envBound7163 : H12AffineFastState.Bounded env7163 := by
  intro p hp
  have h : env7163.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7162_7163 : H12AffineEnvironment.transform 10 131 env7162 = env7163 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 131 env7162 == env7163) = true)

theorem identity7163 : scanCanonicalize (H12AffineFastState.compose env7163 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound7163 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env7164 : List Nat := [2,4,8,10,32,10,128,37,136,1024,131,1071,9,1070,33,138,1070,131,1025,33,1071,32,11,139,128,11,131,1071,1070,130,1056,1,36,1,1071,137]

theorem envBound7164 : H12AffineFastState.Bounded env7164 := by
  intro p hp
  have h : env7164.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7163_7164 : H12AffineEnvironment.transform 7 37 env7163 = env7164 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env7163 == env7164) = true)

theorem identity7164 : scanCanonicalize (H12AffineFastState.compose env7164 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 35) := by decide +kernel

theorem selectedBound7164 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7165 : List Nat := [2,4,8,10,32,10,35,37,43,1024,32,1071,9,1070,33,41,1070,32,1025,33,1071,32,11,40,35,11,32,1071,1070,33,1056,1,36,1,1071,42]

theorem envBound7165 : H12AffineFastState.Bounded env7165 := by
  intro p hp
  have h : env7165.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7164_7165 : H12AffineEnvironment.transform 6 35 env7164 = env7165 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 35 env7164 == env7165) = true)

def env7166 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8,1297,260,138,1296,2341,1025,260,1297,4194304,17,138,129,16,4196384,1296,1296,4196612,1284,2179,257,4196515,1297,136]

theorem envBound7166 : H12AffineFastState.Bounded env7166 := by
  intro p hp
  have h : env7166.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7159_7166 : H12AffineEnvironment.transform 8 137 env7159 = env7166 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env7159 == env7166) = true)

theorem identity7166 : scanCanonicalize (H12AffineFastState.compose env7166 (packedSelected [1] rootPS)) = affineNative (2^(21+1) ^^^ 162) := by decide +kernel

theorem selectedBound7166 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7167 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8,1297,260,138,1296,2341,1025,260,1297,162,17,138,129,16,2178,1296,1296,2470,1284,2179,257,2049,1297,136]

theorem envBound7167 : H12AffineFastState.Bounded env7167 := by
  intro p hp
  have h : env7167.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7166_7167 : H12AffineEnvironment.transform 21 162 env7166 = env7167 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 162 env7166 == env7167) = true)

theorem identity7167 : scanCanonicalize (H12AffineFastState.compose env7167 (packedSelected [3] rootPS)) = affineNative (2^(10+1) ^^^ 42) := by decide +kernel

theorem selectedBound7167 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env7168 : List Nat := [2,4,8,16,32,16,128,256,137,1024,42,1297,8,1297,260,138,1296,271,1025,260,1297,162,17,138,129,16,168,1296,1296,396,1284,169,257,43,1297,136]

theorem envBound7168 : H12AffineFastState.Bounded env7168 := by
  intro p hp
  have h : env7168.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7167_7168 : H12AffineEnvironment.transform 10 42 env7167 = env7168 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 42 env7167 == env7168) = true)

theorem identity7168 : scanCanonicalize (H12AffineFastState.compose env7168 (packedSelected [0,4] rootPS)) = affineNative (2^(7+1) ^^^ 31) := by decide +kernel

theorem selectedBound7168 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env7169 : List Nat := [2,4,8,16,32,16,128,31,137,1024,42,1038,8,1038,27,138,1039,16,1025,27,1038,162,17,138,129,16,168,1039,1039,147,1051,169,30,43,1038,136]

theorem envBound7169 : H12AffineFastState.Bounded env7169 := by
  intro p hp
  have h : env7169.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7168_7169 : H12AffineEnvironment.transform 7 31 env7168 = env7169 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 31 env7168 == env7169) = true)

theorem identity7169 : scanCanonicalize (H12AffineFastState.compose env7169 (packedSelected [5] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound7169 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env7170 : List Nat := [2,4,8,16,1,16,128,31,137,1024,11,1038,8,1038,27,138,1039,16,1025,27,1038,131,17,138,129,16,137,1039,1039,147,1051,136,30,10,1038,136]

theorem envBound7170 : H12AffineFastState.Bounded env7170 := by
  intro p hp
  have h : env7170.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7169_7170 : H12AffineEnvironment.transform 4 1 env7169 = env7170 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env7169 == env7170) = true)

theorem identity7170 : scanCanonicalize (H12AffineFastState.compose env7170 (packedSelected [10] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound7170 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env7171 : List Nat := [2,4,8,1,1,1,128,14,137,1024,11,1038,8,1038,10,138,1039,1,1025,10,1038,131,0,138,129,1,137,1039,1039,130,1034,136,15,10,1038,136]

theorem envBound7171 : H12AffineFastState.Bounded env7171 := by
  intro p hp
  have h : env7171.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7170_7171 : H12AffineEnvironment.transform 3 1 env7170 = env7171 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7170 == env7171) = true)

theorem identity7171 : scanCanonicalize (H12AffineFastState.compose env7171 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound7171 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7172 : List Nat := [2,4,8,1,1,1,3,14,10,1024,11,1038,8,1038,10,9,1039,1,1025,10,1038,0,0,9,2,1,10,1039,1039,1,1034,11,15,10,1038,11]

theorem envBound7172 : H12AffineFastState.Bounded env7172 := by
  intro p hp
  have h : env7172.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7171_7172 : H12AffineEnvironment.transform 6 3 env7171 = env7172 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env7171 == env7172) = true)

theorem identity7172 : scanCanonicalize (H12AffineFastState.compose env7172 (packedSelected [7] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound7172 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env7173 : List Nat := [2,4,3,1,1,1,3,5,1,1024,0,1029,3,1029,1,2,1028,1,1025,1,1029,0,0,2,2,1,1,1028,1028,1,1025,0,4,1,1029,0]

theorem envBound7173 : H12AffineFastState.Bounded env7173 := by
  intro p hp
  have h : env7173.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7172_7173 : H12AffineEnvironment.transform 2 3 env7172 = env7173 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env7172 == env7173) = true)

def leafEnv7173 : List Nat := [2,4,3,1,1,1,3,5,1,1024,0,1029,3,1029,1,2,1028,1,1025,1,1029,0,0,2,1024,2,1,1,1,1028,1028,1,1025,0,4,1,5,3,1029,0,0,1028,1]

def active7173 : List Nat := [0,1,9]

def tree7173 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7173 : H12WitnessSearch.Good tree7173 := H12GlobalWitnessIndex.good

theorem leafIdentity7173 : H12AffineFastState.composeSystem env7173 rootObs = leafEnv7173 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7173 rootObs == leafEnv7173) = true)

theorem terminalChecked7173 : H12PackedTerminal.terminalCheckFast leafEnv7173 active7173 tree7173 = true := by decide +kernel

def env7174 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,16777216,33554432,17010964,21352448,17024020,131073,21105823,16876544,4294967296,257,4332975159,131073,33563272]

theorem envBound7174 : H12AffineFastState.Bounded env7174 := by
  intro p hp
  have h : env7174.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7050_7174 : H12AffineEnvironment.transform 5 17 env7050 = env7174 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7050 == env7174) = true)

def env7175 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,16777216,33554432,17010964,21352448,17024020,131073,21105823,16876544,4294967296,257,4332967607,131073,33554440]

theorem envBound7175 : H12AffineFastState.Bounded env7175 := by
  intro p hp
  have h : env7175.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7174_7175 : H12AffineEnvironment.transform 12 640 env7174 = env7175 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 640 env7174 == env7175) = true)

def env7176 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,16777216,33554432,16875796,21352448,16897044,4097,20978847,16876544,4294967296,257,4332832439,4097,33554440]

theorem envBound7176 : H12AffineFastState.Bounded env7176 := by
  intro p hp
  have h : env7176.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7175_7176 : H12AffineEnvironment.transform 16 4096 env7175 = env7176 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env7175 == env7176) = true)

theorem identity7176 : scanCanonicalize (H12AffineFastState.compose env7176 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(11+1) ^^^ 1944) := by decide +kernel

theorem selectedBound7176 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env7177 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1944,640,16384,32768,65536,1944,262144,1025,32768,1944,4194304,17664,16777216,33554432,16875796,21350296,16892812,1945,20974343,16876544,4294967296,257,4332832439,1945,33554440]

theorem envBound7177 : H12AffineFastState.Bounded env7177 := by
  intro p hp
  have h : env7177.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7176_7177 : H12AffineEnvironment.transform 11 1944 env7176 = env7177 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env7176 == env7177) = true)

def env7178 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1944,640,16384,32768,65536,1944,262144,1025,32768,1944,4194304,17664,16777216,128,16875796,21350296,16892812,1945,20974343,16876544,4294967296,257,4299277879,1945,136]

theorem envBound7178 : H12AffineFastState.Bounded env7178 := by
  intro p hp
  have h : env7178.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7177_7178 : H12AffineEnvironment.transform 24 128 env7177 = env7178 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 128 env7177 == env7178) = true)

theorem identity7178 : scanCanonicalize (H12AffineFastState.compose env7178 (packedSelected [1,5,8,19,24,26] rootPS)) = affineNative (2^(23+1) ^^^ 99213) := by decide +kernel

theorem selectedBound7178 : packedSelected [1,5,8,19,24,26] rootPS < 2^1333 := by decide +kernel

def env7179 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1944,640,16384,32768,65536,1944,262144,1025,32768,1944,4194304,17664,99213,128,665,4473877,16385,1945,4294794,1933,4294967296,257,4299277879,1945,136]

theorem envBound7179 : H12AffineFastState.Bounded env7179 := by
  intro p hp
  have h : env7179.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7178_7179 : H12AffineEnvironment.transform 23 99213 env7178 = env7179 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 99213 env7178 == env7179) = true)

theorem identity7179 : scanCanonicalize (H12AffineFastState.compose env7179 (packedSelected [1,3,5,6,8,10,19,25] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound7179 : packedSelected [1,3,5,6,8,10,19,25] rootPS < 2^1333 := by decide +kernel

def env7180 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,16384,32768,65536,1297,262144,1025,32768,1297,4194304,17664,98564,128,16,4473877,16385,1296,4294794,1284,4294967296,257,4299277502,1296,136]

theorem envBound7180 : H12AffineFastState.Bounded env7180 := by
  intro p hp
  have h : env7180.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7179_7180 : H12AffineEnvironment.transform 8 137 env7179 = env7180 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env7179 == env7180) = true)

theorem identity7180 : scanCanonicalize (H12AffineFastState.compose env7180 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(17+1) ^^^ 34848) := by decide +kernel

theorem selectedBound7180 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env7181 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,16384,32768,65536,1297,34848,1025,32768,1297,4194304,17664,98564,128,16,4246581,16385,1296,4294794,1284,4294967296,257,4299277502,1296,136]

theorem envBound7181 : H12AffineFastState.Bounded env7181 := by
  intro p hp
  have h : env7181.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7180_7181 : H12AffineEnvironment.transform 17 34848 env7180 = env7181 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 34848 env7180 == env7181) = true)

theorem identity7181 : scanCanonicalize (H12AffineFastState.compose env7181 (packedSelected [5,8] rootPS)) = affineNative (2^(15+1) ^^^ 33166) := by decide +kernel

theorem selectedBound7181 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env7182 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,16384,32768,33166,1297,34848,1025,32768,1297,4194304,17664,138,128,16,4246581,16385,1296,4196612,1284,4294967296,257,4299179312,1296,136]

theorem envBound7182 : H12AffineFastState.Bounded env7182 := by
  intro p hp
  have h : env7182.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7181_7182 : H12AffineEnvironment.transform 15 33166 env7181 = env7182 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33166 env7181 == env7182) = true)

theorem identity7182 : scanCanonicalize (H12AffineFastState.compose env7182 (packedSelected [0,2,3,4,5,6,10,11,12] rootPS)) = affineNative (2^(21+1) ^^^ 19729) := by decide +kernel

theorem selectedBound7182 : packedSelected [0,2,3,4,5,6,10,11,12] rootPS < 2^1333 := by decide +kernel

def env7183 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,16384,32768,33166,1297,34848,1025,32768,1297,19729,17664,138,128,16,33060,16385,1296,17429,1284,4294967296,257,4294969377,1296,136]

theorem envBound7183 : H12AffineFastState.Bounded env7183 := by
  intro p hp
  have h : env7183.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7182_7183 : H12AffineEnvironment.transform 21 19729 env7182 = env7183 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 19729 env7182 == env7183) = true)

theorem identity7183 : scanCanonicalize (H12AffineFastState.compose env7183 (packedSelected [0,3,5,6,10] rootPS)) = affineNative (2^(10+1) ^^^ 1) := by decide +kernel

theorem selectedBound7183 : packedSelected [0,3,5,6,10] rootPS < 2^1333 := by decide +kernel

def env7184 : List Nat := [2,4,8,16,32,17,128,256,137,1024,1,1297,9,16384,32768,33166,1297,32801,1025,32768,1297,17680,17664,138,128,16,33060,16385,1296,17429,1284,4294967296,257,4294967328,1296,136]

theorem envBound7184 : H12AffineFastState.Bounded env7184 := by
  intro p hp
  have h : env7184.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7183_7184 : H12AffineEnvironment.transform 10 1 env7183 = env7184 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env7183 == env7184) = true)

theorem identity7184 : scanCanonicalize (H12AffineFastState.compose env7184 (packedSelected [0,4,7,9,11] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound7184 : packedSelected [0,4,7,9,11] rootPS < 2^1333 := by decide +kernel

def env7185 : List Nat := [2,4,8,16,32,17,128,5,137,1024,1,1044,9,16384,32768,32907,1044,32801,1025,32768,1044,17429,17413,138,128,16,32801,16385,1045,17429,1025,4294967296,4,4294967328,1045,136]

theorem envBound7185 : H12AffineFastState.Bounded env7185 := by
  intro p hp
  have h : env7185.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7184_7185 : H12AffineEnvironment.transform 7 5 env7184 = env7185 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env7184 == env7185) = true)

theorem identity7185 : scanCanonicalize (H12AffineFastState.compose env7185 (packedSelected [0,7] rootPS)) = affineNative (2^(13+1) ^^^ 1045) := by decide +kernel

theorem selectedBound7185 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env7186 : List Nat := [2,4,8,16,32,17,128,5,137,1024,1,1044,9,1045,32768,32907,1044,32801,1025,32768,1044,0,16,138,128,16,32801,1044,1045,0,1025,4294967296,4,4294967328,1045,136]

theorem envBound7186 : H12AffineFastState.Bounded env7186 := by
  intro p hp
  have h : env7186.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7185_7186 : H12AffineEnvironment.transform 13 1045 env7185 = env7186 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1045 env7185 == env7186) = true)

theorem identity7186 : scanCanonicalize (H12AffineFastState.compose env7186 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 32) := by decide +kernel

theorem selectedBound7186 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7187 : List Nat := [2,4,8,16,32,17,128,5,137,1024,1,1044,9,1045,32768,32907,1044,32801,1025,32768,1044,0,16,138,128,16,32801,1044,1045,0,1025,32,4,0,1045,136]

theorem envBound7187 : H12AffineFastState.Bounded env7187 := by
  intro p hp
  have h : env7187.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7186_7187 : H12AffineEnvironment.transform 31 32 env7186 = env7187 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 32 env7186 == env7187) = true)

theorem identity7187 : scanCanonicalize (H12AffineFastState.compose env7187 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 24) := by decide +kernel

theorem selectedBound7187 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7188 : List Nat := [2,4,8,16,32,17,24,5,17,1024,1,1044,9,1045,32768,32787,1044,32801,1025,32768,1044,0,16,18,24,16,32801,1044,1045,0,1025,32,4,0,1045,16]

theorem envBound7188 : H12AffineFastState.Bounded env7188 := by
  intro p hp
  have h : env7188.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7187_7188 : H12AffineEnvironment.transform 6 24 env7187 = env7188 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 24 env7187 == env7188) = true)

theorem identity7188 : scanCanonicalize (H12AffineFastState.compose env7188 (packedSelected [3] rootPS)) = affineNative (2^(14+1) ^^^ 17) := by decide +kernel

theorem selectedBound7188 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env7189 : List Nat := [2,4,8,16,32,17,24,5,17,1024,1,1044,9,1045,17,2,1044,48,1025,17,1044,0,16,18,24,16,48,1044,1045,0,1025,32,4,0,1045,16]

theorem envBound7189 : H12AffineFastState.Bounded env7189 := by
  intro p hp
  have h : env7189.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7188_7189 : H12AffineEnvironment.transform 14 17 env7188 = env7189 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 17 env7188 == env7189) = true)

theorem identity7189 : scanCanonicalize (H12AffineFastState.compose env7189 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 26) := by decide +kernel

theorem selectedBound7189 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7190 : List Nat := [2,4,8,16,26,17,24,5,17,1024,1,1044,9,1045,17,2,1044,10,1025,17,1044,0,16,18,24,16,10,1044,1045,0,1025,26,4,0,1045,16]

theorem envBound7190 : H12AffineFastState.Bounded env7190 := by
  intro p hp
  have h : env7190.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7189_7190 : H12AffineEnvironment.transform 4 26 env7189 = env7190 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 26 env7189 == env7190) = true)

theorem identity7190 : scanCanonicalize (H12AffineFastState.compose env7190 (packedSelected [4] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound7190 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env7191 : List Nat := [2,4,8,1,11,0,9,5,0,1024,1,1029,9,1028,0,2,1029,10,1025,0,1029,0,1,3,9,1,10,1029,1028,0,1025,11,4,0,1028,1]

theorem envBound7191 : H12AffineFastState.Bounded env7191 := by
  intro p hp
  have h : env7191.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7190_7191 : H12AffineEnvironment.transform 3 1 env7190 = env7191 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7190 == env7191) = true)

theorem identity7191 : scanCanonicalize (H12AffineFastState.compose env7191 (packedSelected [5] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound7191 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env7192 : List Nat := [2,4,2,1,1,0,3,5,0,1024,1,1029,3,1028,0,2,1029,0,1025,0,1029,0,1,3,3,1,0,1029,1028,0,1025,1,4,0,1028,1]

theorem envBound7192 : H12AffineFastState.Bounded env7192 := by
  intro p hp
  have h : env7192.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7191_7192 : H12AffineEnvironment.transform 2 2 env7191 = env7192 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env7191 == env7192) = true)

def leafEnv7192 : List Nat := [2,4,2,1,1,0,3,5,0,1024,1,1029,3,1028,0,2,1029,0,1025,0,1029,0,1,3,1024,3,1,1,0,1029,1028,0,1025,1,4,0,5,2,1028,1,0,1028,1]

def active7192 : List Nat := [0,1,9]

def tree7192 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7192 : H12WitnessSearch.Good tree7192 := H12GlobalWitnessIndex.good

theorem leafIdentity7192 : H12AffineFastState.composeSystem env7192 rootObs = leafEnv7192 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7192 rootObs == leafEnv7192) = true)

theorem terminalChecked7192 : H12PackedTerminal.terminalCheckFast leafEnv7192 active7192 tree7192 = true := by decide +kernel

def env7193 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1944,640,16384,32768,65536,1944,262144,1025,32768,1944,4194304,17664,16777216,129,16875796,21350296,16892812,1945,20974343,16876544,4294967296,257,4299277878,1945,137]

theorem envBound7193 : H12AffineFastState.Bounded env7193 := by
  intro p hp
  have h : env7193.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7177_7193 : H12AffineEnvironment.transform 24 129 env7177 = env7193 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 129 env7177 == env7193) = true)

theorem identity7193 : scanCanonicalize (H12AffineFastState.compose env7193 (packedSelected [1,5,8,19,24,26] rootPS)) = affineNative (2^(23+1) ^^^ 98565) := by decide +kernel

theorem selectedBound7193 : packedSelected [1,5,8,19,24,26] rootPS < 2^1333 := by decide +kernel

def env7194 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1944,640,16384,32768,65536,1944,262144,1025,32768,1944,4194304,17664,98565,129,17,4474525,17033,1945,4295170,1285,4294967296,257,4299277878,1945,137]

theorem envBound7194 : H12AffineFastState.Bounded env7194 := by
  intro p hp
  have h : env7194.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7193_7194 : H12AffineEnvironment.transform 23 98565 env7193 = env7194 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98565 env7193 == env7194) = true)

theorem identity7194 : scanCanonicalize (H12AffineFastState.compose env7194 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 1296) := by decide +kernel

theorem selectedBound7194 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env7195 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1944,640,1296,32768,65536,1944,262144,1025,32768,1944,4194304,16,98565,129,17,4457357,1945,1945,4295170,1285,4294967296,257,4299260710,1945,137]

theorem envBound7195 : H12AffineFastState.Bounded env7195 := by
  intro p hp
  have h : env7195.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7194_7195 : H12AffineEnvironment.transform 13 1296 env7194 = env7195 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1296 env7194 == env7195) = true)

theorem identity7195 : scanCanonicalize (H12AffineFastState.compose env7195 (packedSelected [3,5,8,28] rootPS)) = affineNative (2^(17+1) ^^^ 34848) := by decide +kernel

theorem selectedBound7195 : packedSelected [3,5,8,28] rootPS < 2^1333 := by decide +kernel

def env7196 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1944,640,1296,32768,65536,1944,34848,1025,32768,1944,4194304,16,98565,129,17,4230061,1945,1945,4295170,1285,4294967296,257,4299260710,1945,137]

theorem envBound7196 : H12AffineFastState.Bounded env7196 := by
  intro p hp
  have h : env7196.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7195_7196 : H12AffineEnvironment.transform 17 34848 env7195 = env7196 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 34848 env7195 == env7196) = true)

theorem identity7196 : scanCanonicalize (H12AffineFastState.compose env7196 (packedSelected [0,1,3,7,12,13,15,20,21] rootPS)) = affineNative (2^(14+1) ^^^ 909) := by decide +kernel

theorem selectedBound7196 : packedSelected [0,1,3,7,12,13,15,20,21] rootPS < 2^1333 := by decide +kernel

def env7197 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1944,640,1296,909,65536,1944,2989,1025,909,1944,4194304,16,66184,129,17,4196384,1945,1945,4262287,1285,4294967296,257,4299227307,1945,137]

theorem envBound7197 : H12AffineFastState.Bounded env7197 := by
  intro p hp
  have h : env7197.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7196_7197 : H12AffineEnvironment.transform 14 909 env7196 = env7197 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 909 env7196 == env7197) = true)

theorem identity7197 : scanCanonicalize (H12AffineFastState.compose env7197 (packedSelected [1,3,10,12,24] rootPS)) = affineNative (2^(21+1) ^^^ 423) := by decide +kernel

theorem selectedBound7197 : packedSelected [1,3,10,12,24] rootPS < 2^1333 := by decide +kernel

def env7198 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1944,640,1296,909,65536,1944,2989,1025,909,1944,423,16,66184,129,17,2439,1945,1945,67624,1285,4294967296,257,4295033100,1945,137]

theorem envBound7198 : H12AffineFastState.Bounded env7198 := by
  intro p hp
  have h : env7198.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7197_7198 : H12AffineEnvironment.transform 21 423 env7197 = env7198 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 423 env7197 == env7198) = true)

theorem identity7198 : scanCanonicalize (H12AffineFastState.compose env7198 (packedSelected [3,6,8,10] rootPS)) = affineNative (2^(31+1) ^^^ 2309) := by decide +kernel

theorem selectedBound7198 : packedSelected [3,6,8,10] rootPS < 2^1333 := by decide +kernel

def env7199 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1944,640,1296,909,65536,1944,2989,1025,909,1944,423,16,66184,129,17,2439,1945,1945,67624,1285,2309,257,67593,1945,137]

theorem envBound7199 : H12AffineFastState.Bounded env7199 := by
  intro p hp
  have h : env7199.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7198_7199 : H12AffineEnvironment.transform 31 2309 env7198 = env7199 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 2309 env7198 == env7199) = true)

theorem identity7199 : scanCanonicalize (H12AffineFastState.compose env7199 (packedSelected [3,4,8,9,12,15,16,17] rootPS)) = affineNative (2^(15+1) ^^^ 2981) := by decide +kernel

theorem selectedBound7199 : packedSelected [3,4,8,9,12,15,16,17] rootPS < 2^1333 := by decide +kernel

def env7200 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1944,640,1296,909,2981,1944,2989,1025,909,1944,423,16,2349,129,17,2439,1945,1945,909,1285,2309,257,940,1945,137]

theorem envBound7200 : H12AffineFastState.Bounded env7200 := by
  intro p hp
  have h : env7200.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7199_7200 : H12AffineEnvironment.transform 15 2981 env7199 = env7200 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2981 env7199 == env7200) = true)

theorem identity7200 : scanCanonicalize (H12AffineFastState.compose env7200 (packedSelected [0,1,4,5,7,8,9,11,15] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound7200 : packedSelected [0,1,4,5,7,8,9,11,15] rootPS < 2^1333 := by decide +kernel

def env7201 : List Nat := [2,4,8,11,32,10,128,256,512,1024,2048,1923,640,1291,909,2981,1923,2989,1025,909,1923,423,11,2349,129,10,2439,1922,1922,909,1285,2309,257,940,1922,137]

theorem envBound7201 : H12AffineFastState.Bounded env7201 := by
  intro p hp
  have h : env7201.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7200_7201 : H12AffineEnvironment.transform 3 11 env7200 = env7201 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env7200 == env7201) = true)

theorem identity7201 : scanCanonicalize (H12AffineFastState.compose env7201 (packedSelected [3,8] rootPS)) = affineNative (2^(8+1) ^^^ 42) := by decide +kernel

theorem selectedBound7201 : packedSelected [3,8] rootPS < 2^1333 := by decide +kernel

def env7202 : List Nat := [2,4,8,11,32,10,128,256,42,1024,2048,1449,170,1291,423,2447,1449,2439,1025,423,1449,423,11,2349,129,10,2439,1448,1448,423,1285,2309,257,390,1448,137]

theorem envBound7202 : H12AffineFastState.Bounded env7202 := by
  intro p hp
  have h : env7202.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7201_7202 : H12AffineEnvironment.transform 8 42 env7201 = env7202 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 42 env7201 == env7202) = true)

theorem identity7202 : scanCanonicalize (H12AffineFastState.compose env7202 (packedSelected [0,2,3,4,5,6,11] rootPS)) = affineNative (2^(10+1) ^^^ 260) := by decide +kernel

theorem selectedBound7202 : packedSelected [0,2,3,4,5,6,11] rootPS < 2^1333 := by decide +kernel

def env7203 : List Nat := [2,4,8,11,32,10,128,256,42,1024,260,1449,170,1291,423,139,1449,131,1025,423,1449,423,11,41,129,10,131,1448,1448,423,1285,1,257,390,1448,137]

theorem envBound7203 : H12AffineFastState.Bounded env7203 := by
  intro p hp
  have h : env7203.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7202_7203 : H12AffineEnvironment.transform 10 260 env7202 = env7203 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 260 env7202 == env7203) = true)

theorem identity7203 : scanCanonicalize (H12AffineFastState.compose env7203 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 34) := by decide +kernel

theorem selectedBound7203 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env7204 : List Nat := [2,4,8,11,32,10,34,256,42,1024,260,1291,8,1291,261,41,1291,33,1025,261,1291,261,11,41,35,10,33,1290,1290,261,1285,1,257,292,1290,43]

theorem envBound7204 : H12AffineFastState.Bounded env7204 := by
  intro p hp
  have h : env7204.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7203_7204 : H12AffineEnvironment.transform 6 34 env7203 = env7204 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 34 env7203 == env7204) = true)

theorem identity7204 : scanCanonicalize (H12AffineFastState.compose env7204 (packedSelected [6] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound7204 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7205 : List Nat := [2,4,8,11,32,10,34,37,42,1024,33,1070,8,1070,32,41,1070,33,1025,32,1070,32,11,41,35,10,33,1071,1071,32,1056,1,36,1,1071,43]

theorem envBound7205 : H12AffineFastState.Bounded env7205 := by
  intro p hp
  have h : env7205.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7204_7205 : H12AffineEnvironment.transform 7 37 env7204 = env7205 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env7204 == env7205) = true)

def env7206 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,16777216,33554432,16875797,21352448,16897045,4096,20978846,16876544,4294967296,257,4332832438,4096,33554440]

theorem envBound7206 : H12AffineFastState.Bounded env7206 := by
  intro p hp
  have h : env7206.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7175_7206 : H12AffineEnvironment.transform 16 4097 env7175 = env7206 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env7175 == env7206) = true)

theorem identity7206 : scanCanonicalize (H12AffineFastState.compose env7206 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound7206 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env7207 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,16777216,33554432,16875797,21352448,16897045,4096,20978846,16876544,4294967296,257,4332831807,4096,33554440]

theorem envBound7207 : H12AffineFastState.Bounded env7207 := by
  intro p hp
  have h : env7207.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7206_7207 : H12AffineEnvironment.transform 8 137 env7206 = env7207 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env7206 == env7207) = true)

def env7208 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,16777216,16859280,16875797,21352448,16897045,4096,20978846,16876544,4294967296,257,4315972783,4096,16859288]

theorem envBound7208 : H12AffineFastState.Bounded env7208 := by
  intro p hp
  have h : env7208.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7207_7208 : H12AffineEnvironment.transform 24 16859280 env7207 = env7208 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 16859280 env7207 == env7208) = true)

def env7209 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,9,16384,32768,65536,4097,262144,257,32768,4096,4194304,16384,16777216,16859280,16875797,21352448,16896277,4096,20978078,16875776,4294967296,257,4315972015,4096,16859288]

theorem envBound7209 : H12AffineFastState.Bounded env7209 := by
  intro p hp
  have h : env7209.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7208_7209 : H12AffineEnvironment.transform 9 256 env7208 = env7209 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 256 env7208 == env7209) = true)

theorem identity7209 : scanCanonicalize (H12AffineFastState.compose env7209 (packedSelected [0,3,4,7,9,10,13,16,17,20,21,24,26,33] rootPS)) = affineNative (2^(23+1) ^^^ 81936) := by decide +kernel

theorem selectedBound7209 : packedSelected [0,3,4,7,9,10,13,16,17,20,21,24,26,33] rootPS < 2^1333 := by decide +kernel

def env7210 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,9,16384,32768,65536,4097,262144,257,32768,4096,4194304,16384,81936,128,49413,4493328,37125,4096,4282766,49424,4294967296,257,4299276735,4096,136]

theorem envBound7210 : H12AffineFastState.Bounded env7210 := by
  intro p hp
  have h : env7210.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7209_7210 : H12AffineEnvironment.transform 23 81936 env7209 = env7210 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 81936 env7209 == env7210) = true)

theorem identity7210 : scanCanonicalize (H12AffineFastState.compose env7210 (packedSelected [3,4,9,10,16,24,26] rootPS)) = affineNative (2^(14+1) ^^^ 20740) := by decide +kernel

theorem selectedBound7210 : packedSelected [3,4,9,10,16,24,26] rootPS < 2^1333 := by decide +kernel

def env7211 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,9,16384,20740,65536,4097,262144,257,20740,4096,4194304,16384,81936,128,4097,4473108,16385,4096,4282766,4116,4294967296,257,4299231419,4096,136]

theorem envBound7211 : H12AffineFastState.Bounded env7211 := by
  intro p hp
  have h : env7211.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7210_7211 : H12AffineEnvironment.transform 14 20740 env7210 = env7211 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 20740 env7210 == env7211) = true)

theorem identity7211 : scanCanonicalize (H12AffineFastState.compose env7211 (packedSelected [4,5,8,9,16,17,21] rootPS)) = affineNative (2^(11+1) ^^^ 17) := by decide +kernel

theorem selectedBound7211 : packedSelected [4,5,8,9,16,17,21] rootPS < 2^1333 := by decide +kernel

def env7212 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,17,9,16384,16661,65536,16,262144,257,16661,17,4194304,16384,81936,128,16,4473108,16385,17,4278687,5,4294967296,257,4299227306,17,136]

theorem envBound7212 : H12AffineFastState.Bounded env7212 := by
  intro p hp
  have h : env7212.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7211_7212 : H12AffineEnvironment.transform 11 17 env7211 = env7212 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 17 env7211 == env7212) = true)

theorem identity7212 : scanCanonicalize (H12AffineFastState.compose env7212 (packedSelected [3,5,6,10] rootPS)) = affineNative (2^(31+1) ^^^ 4522253) := by decide +kernel

theorem selectedBound7212 : packedSelected [3,5,6,10] rootPS < 2^1333 := by decide +kernel

def env7213 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,17,9,16384,16661,65536,16,262144,257,16661,17,4194304,16384,81936,128,16,4473108,16385,17,4278687,5,4522253,257,262567,17,136]

theorem envBound7213 : H12AffineFastState.Bounded env7213 := by
  intro p hp
  have h : env7213.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7212_7213 : H12AffineEnvironment.transform 31 4522253 env7212 = env7213 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4522253 env7212 == env7213) = true)

theorem identity7213 : scanCanonicalize (H12AffineFastState.compose env7213 (packedSelected [1,3,5,6,8,12,15] rootPS)) = affineNative (2^(21+1) ^^^ 16433) := by decide +kernel

theorem selectedBound7213 : packedSelected [1,3,5,6,8,12,15] rootPS < 2^1333 := by decide +kernel

def env7214 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,17,9,16384,16661,65536,16,262144,257,16661,17,16433,16384,81936,128,16,262437,16385,17,68014,5,344380,257,262567,17,136]

theorem envBound7214 : H12AffineFastState.Bounded env7214 := by
  intro p hp
  have h : env7214.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7213_7214 : H12AffineEnvironment.transform 21 16433 env7213 = env7214 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 16433 env7213 == env7214) = true)

theorem identity7214 : scanCanonicalize (H12AffineFastState.compose env7214 (packedSelected [4,9,16] rootPS)) = affineNative (2^(13+1) ^^^ 17) := by decide +kernel

theorem selectedBound7214 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env7215 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,17,9,17,260,65536,16,262144,257,260,17,32,17,65537,128,16,262437,16,17,68014,5,327981,257,262567,17,136]

theorem envBound7215 : H12AffineFastState.Bounded env7215 := by
  intro p hp
  have h : env7215.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7214_7215 : H12AffineEnvironment.transform 13 17 env7214 = env7215 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 17 env7214 == env7215) = true)

theorem identity7215 : scanCanonicalize (H12AffineFastState.compose env7215 (packedSelected [1,3,5] rootPS)) = affineNative (2^(17+1) ^^^ 65544) := by decide +kernel

theorem selectedBound7215 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env7216 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,17,9,17,260,65536,16,65544,257,260,17,32,17,65537,128,16,65837,16,17,68014,5,293,257,65967,17,136]

theorem envBound7216 : H12AffineFastState.Bounded env7216 := by
  intro p hp
  have h : env7216.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7215_7216 : H12AffineEnvironment.transform 17 65544 env7215 = env7216 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 65544 env7215 == env7216) = true)

theorem identity7216 : scanCanonicalize (H12AffineFastState.compose env7216 (packedSelected [2] rootPS)) = affineNative (2^(15+1) ^^^ 2218) := by decide +kernel

theorem selectedBound7216 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7217 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,17,9,17,260,2218,16,2210,257,260,17,32,17,2219,128,16,2439,16,17,260,5,293,257,2309,17,136]

theorem envBound7217 : H12AffineFastState.Bounded env7217 := by
  intro p hp
  have h : env7217.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7216_7217 : H12AffineEnvironment.transform 15 2218 env7216 = env7217 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2218 env7216 == env7217) = true)

theorem identity7217 : scanCanonicalize (H12AffineFastState.compose env7217 (packedSelected [6] rootPS)) = affineNative (2^(10+1) ^^^ 33) := by decide +kernel

theorem selectedBound7217 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7218 : List Nat := [2,4,8,16,32,17,128,256,137,256,33,17,9,17,260,139,16,131,257,260,17,32,17,138,128,16,422,16,17,260,5,293,257,292,17,136]

theorem envBound7218 : H12AffineFastState.Bounded env7218 := by
  intro p hp
  have h : env7218.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7217_7218 : H12AffineEnvironment.transform 10 33 env7217 = env7218 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 33 env7217 == env7218) = true)

theorem identity7218 : scanCanonicalize (H12AffineFastState.compose env7218 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 151) := by decide +kernel

theorem selectedBound7218 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7219 : List Nat := [2,4,8,16,32,17,128,151,137,151,33,17,9,17,147,139,16,131,150,147,17,32,17,138,128,16,49,16,17,147,5,178,150,179,17,136]

theorem envBound7219 : H12AffineFastState.Bounded env7219 := by
  intro p hp
  have h : env7219.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7218_7219 : H12AffineEnvironment.transform 7 151 env7218 = env7219 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 151 env7218 == env7219) = true)

theorem identity7219 : scanCanonicalize (H12AffineFastState.compose env7219 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 19) := by decide +kernel

theorem selectedBound7219 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7220 : List Nat := [2,4,8,16,32,17,19,4,26,4,33,17,9,17,0,24,16,16,5,0,17,32,17,25,19,16,49,16,17,0,5,33,5,32,17,27]

theorem envBound7220 : H12AffineFastState.Bounded env7220 := by
  intro p hp
  have h : env7220.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7219_7220 : H12AffineEnvironment.transform 6 19 env7219 = env7220 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 19 env7219 == env7220) = true)

theorem identity7220 : scanCanonicalize (H12AffineFastState.compose env7220 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound7220 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env7221 : List Nat := [2,4,8,0,32,1,3,4,10,4,33,1,9,1,0,8,0,0,5,0,1,32,1,9,3,0,33,0,1,0,5,33,5,32,1,11]

theorem envBound7221 : H12AffineFastState.Bounded env7221 := by
  intro p hp
  have h : env7221.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7220_7221 : H12AffineEnvironment.transform 3 0 env7220 = env7221 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7220 == env7221) = true)

def env7222 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,9,16384,32768,65536,4097,262144,256,32768,4096,4194304,16385,16777216,16859280,16875797,21352448,16896276,4096,20978079,16875777,4294967296,257,4315972014,4096,16859288]

theorem envBound7222 : H12AffineFastState.Bounded env7222 := by
  intro p hp
  have h : env7222.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7208_7222 : H12AffineEnvironment.transform 9 257 env7208 = env7222 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 257 env7208 == env7222) = true)

def env7223 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,9,16384,32768,65536,4097,262144,256,32768,4096,4194304,16385,65536,16528,33045,4509696,53524,4096,4266399,33025,4294967296,257,4299260334,4096,16536]

theorem envBound7223 : H12AffineFastState.Bounded env7223 := by
  intro p hp
  have h : env7223.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7222_7223 : H12AffineEnvironment.transform 23 65536 env7222 = env7223 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 65536 env7222 == env7223) = true)

theorem identity7223 : scanCanonicalize (H12AffineFastState.compose env7223 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(14+1) ^^^ 4373) := by decide +kernel

theorem selectedBound7223 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env7224 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,9,16384,4373,65536,4097,262144,256,4373,4096,4194304,16385,65536,16528,4096,4473109,16385,4096,4266399,4116,4294967296,257,4299231419,4096,16536]

theorem envBound7224 : H12AffineFastState.Bounded env7224 := by
  intro p hp
  have h : env7224.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7223_7224 : H12AffineEnvironment.transform 14 4373 env7223 = env7224 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 4373 env7223 == env7224) = true)

theorem identity7224 : scanCanonicalize (H12AffineFastState.compose env7224 (packedSelected [0,1,3,4,5,7,8,9,10,16,19,20] rootPS)) = affineNative (2^(13+1) ^^^ 16) := by decide +kernel

theorem selectedBound7224 : packedSelected [0,1,3,4,5,7,8,9,10,16,19,20] rootPS < 2^1333 := by decide +kernel

def env7225 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,9,16,4373,65536,4097,262144,256,4373,4096,4194304,17,65536,128,4096,4456709,17,4096,4266399,4116,4294967296,257,4299231419,4096,136]

theorem envBound7225 : H12AffineFastState.Bounded env7225 := by
  intro p hp
  have h : env7225.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7224_7225 : H12AffineEnvironment.transform 13 16 env7224 = env7225 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 16 env7224 == env7225) = true)

theorem identity7225 : scanCanonicalize (H12AffineFastState.compose env7225 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 4460602) := by decide +kernel

theorem selectedBound7225 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7226 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,9,16,4373,65536,4097,262144,256,4373,4096,4194304,17,65536,128,4096,4456709,17,4096,4266399,4116,4460602,257,327809,4096,136]

theorem envBound7226 : H12AffineFastState.Bounded env7226 := by
  intro p hp
  have h : env7226.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7225_7226 : H12AffineEnvironment.transform 31 4460602 env7225 = env7226 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4460602 env7225 == env7226) = true)

theorem identity7226 : scanCanonicalize (H12AffineFastState.compose env7226 (packedSelected [10,12,17] rootPS)) = affineNative (2^(17+1) ^^^ 6453) := by decide +kernel

theorem selectedBound7226 : packedSelected [10,12,17] rootPS < 2^1333 := by decide +kernel

def env7227 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,9,16,4373,65536,4097,6453,256,4373,4096,4194304,17,65536,128,4096,4200496,17,4096,4266399,4116,4196623,257,72116,4096,136]

theorem envBound7227 : H12AffineFastState.Bounded env7227 := by
  intro p hp
  have h : env7227.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7226_7227 : H12AffineEnvironment.transform 17 6453 env7226 = env7227 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 6453 env7226 == env7227) = true)

theorem identity7227 : scanCanonicalize (H12AffineFastState.compose env7227 (packedSelected [5,8] rootPS)) = affineNative (2^(11+1) ^^^ 17) := by decide +kernel

theorem selectedBound7227 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env7228 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,17,9,16,260,65536,16,2340,256,260,17,4194304,17,65536,128,17,4196385,17,17,4262286,5,4196623,257,68005,17,136]

theorem envBound7228 : H12AffineFastState.Bounded env7228 := by
  intro p hp
  have h : env7228.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7227_7228 : H12AffineEnvironment.transform 11 17 env7227 = env7228 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 17 env7227 == env7228) = true)

theorem identity7228 : scanCanonicalize (H12AffineFastState.compose env7228 (packedSelected [1] rootPS)) = affineNative (2^(21+1) ^^^ 2179) := by decide +kernel

theorem selectedBound7228 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7229 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,17,9,16,260,65536,16,2340,256,260,17,2179,17,65536,128,17,162,17,17,65805,5,396,257,68005,17,136]

theorem envBound7229 : H12AffineFastState.Bounded env7229 := by
  intro p hp
  have h : env7229.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7228_7229 : H12AffineEnvironment.transform 21 2179 env7228 = env7229 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 2179 env7228 == env7229) = true)

theorem identity7229 : scanCanonicalize (H12AffineFastState.compose env7229 (packedSelected [3,5] rootPS)) = affineNative (2^(15+1) ^^^ 161) := by decide +kernel

theorem selectedBound7229 : packedSelected [3,5] rootPS < 2^1333 := by decide +kernel

def env7230 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,17,9,16,260,161,16,2340,256,260,17,2179,17,161,128,17,162,17,17,428,5,396,257,2308,17,136]

theorem envBound7230 : H12AffineFastState.Bounded env7230 := by
  intro p hp
  have h : env7230.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7229_7230 : H12AffineEnvironment.transform 15 161 env7229 = env7230 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 161 env7229 == env7230) = true)

theorem identity7230 : scanCanonicalize (H12AffineFastState.compose env7230 (packedSelected [10] rootPS)) = affineNative (2^(10+1) ^^^ 271) := by decide +kernel

theorem selectedBound7230 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env7231 : List Nat := [2,4,8,16,32,17,128,256,137,257,271,17,9,16,260,161,16,43,256,260,17,396,17,161,128,17,162,17,17,428,5,396,257,11,17,136]

theorem envBound7231 : H12AffineFastState.Bounded env7231 := by
  intro p hp
  have h : env7231.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7230_7231 : H12AffineEnvironment.transform 10 271 env7230 = env7231 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 271 env7230 == env7231) = true)

theorem identity7231 : scanCanonicalize (H12AffineFastState.compose env7231 (packedSelected [3,12] rootPS)) = affineNative (2^(7+1) ^^^ 167) := by decide +kernel

theorem selectedBound7231 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env7232 : List Nat := [2,4,8,16,32,17,128,167,137,166,168,17,9,16,163,161,16,43,167,163,17,43,17,161,128,17,162,17,17,11,5,43,166,11,17,136]

theorem envBound7232 : H12AffineFastState.Bounded env7232 := by
  intro p hp
  have h : env7232.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7231_7232 : H12AffineEnvironment.transform 7 167 env7231 = env7232 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 167 env7231 == env7232) = true)

theorem identity7232 : scanCanonicalize (H12AffineFastState.compose env7232 (packedSelected [4] rootPS)) = affineNative (2^(6+1) ^^^ 24) := by decide +kernel

theorem selectedBound7232 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env7233 : List Nat := [2,4,8,16,32,17,24,63,17,62,48,17,9,16,59,57,16,43,63,59,17,43,17,57,24,17,58,17,17,11,5,43,62,11,17,16]

theorem envBound7233 : H12AffineFastState.Bounded env7233 := by
  intro p hp
  have h : env7233.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7232_7233 : H12AffineEnvironment.transform 6 24 env7232 = env7233 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 24 env7232 == env7233) = true)

theorem identity7233 : scanCanonicalize (H12AffineFastState.compose env7233 (packedSelected [2,3] rootPS)) = affineNative (2^(4+1) ^^^ 26) := by decide +kernel

theorem selectedBound7233 : packedSelected [2,3] rootPS < 2^1333 := by decide +kernel

def env7234 : List Nat := [2,4,8,16,26,17,24,5,17,4,10,17,9,16,1,3,16,17,5,1,17,17,17,3,24,17,0,17,17,11,5,17,4,11,17,16]

theorem envBound7234 : H12AffineFastState.Bounded env7234 := by
  intro p hp
  have h : env7234.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7233_7234 : H12AffineEnvironment.transform 4 26 env7233 = env7234 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 26 env7233 == env7234) = true)

theorem identity7234 : scanCanonicalize (H12AffineFastState.compose env7234 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound7234 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7235 : List Nat := [2,4,8,11,1,10,3,5,10,4,10,10,9,11,1,3,11,10,5,1,10,10,10,3,3,10,0,10,10,11,5,10,4,11,10,11]

theorem envBound7235 : H12AffineFastState.Bounded env7235 := by
  intro p hp
  have h : env7235.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7234_7235 : H12AffineEnvironment.transform 3 11 env7234 = env7235 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env7234 == env7235) = true)

theorem identity7235 : scanCanonicalize (H12AffineFastState.compose env7235 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound7235 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7236 : List Nat := [2,4,2,1,1,0,3,5,0,4,0,0,3,1,1,3,1,0,5,1,0,0,0,3,3,0,0,0,0,1,5,0,4,1,0,1]

theorem envBound7236 : H12AffineFastState.Bounded env7236 := by
  intro p hp
  have h : env7236.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7235_7236 : H12AffineEnvironment.transform 2 2 env7235 = env7236 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env7235 == env7236) = true)

def leafEnv7236 : List Nat := [2,4,2,1,1,0,3,5,0,4,0,0,3,1,1,3,1,0,5,1,0,0,0,3,4,3,1,0,0,0,0,1,5,0,4,1,5,3,0,1,0,0,1]

def active7236 : List Nat := [0,1]

def tree7236 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7236 : H12WitnessSearch.Good tree7236 := H12GlobalWitnessIndex.good

theorem leafIdentity7236 : H12AffineFastState.composeSystem env7236 rootObs = leafEnv7236 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7236 rootObs == leafEnv7236) = true)

theorem terminalChecked7236 : H12PackedTerminal.terminalCheckFast leafEnv7236 active7236 tree7236 = true := by decide +kernel

def env7237 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,9,16384,32768,65536,4097,262144,256,32768,4096,4194304,16385,65537,16529,33044,4509697,53525,4096,4266398,33024,4294967296,257,4299260335,4096,16537]

theorem envBound7237 : H12AffineFastState.Bounded env7237 := by
  intro p hp
  have h : env7237.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7222_7237 : H12AffineEnvironment.transform 23 65537 env7222 = env7237 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 65537 env7222 == env7237) = true)

theorem identity7237 : scanCanonicalize (H12AffineFastState.compose env7237 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(11+1) ^^^ 17) := by decide +kernel

theorem selectedBound7237 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env7238 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,17,9,16384,32768,65536,16,262144,256,32768,17,4194304,16385,65537,16529,33044,4505616,49412,17,4262287,33024,4294967296,257,4299260335,17,16537]

theorem envBound7238 : H12AffineFastState.Bounded env7238 := by
  intro p hp
  have h : env7238.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7237_7238 : H12AffineEnvironment.transform 11 17 env7237 = env7238 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 17 env7237 == env7238) = true)

theorem identity7238 : scanCanonicalize (H12AffineFastState.compose env7238 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(14+1) ^^^ 16660) := by decide +kernel

theorem selectedBound7238 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env7239 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,17,9,16384,16660,65536,16,262144,256,16660,17,4194304,16385,65537,16529,16384,4456708,16,17,4262287,16404,4294967296,257,4299243707,17,16537]

theorem envBound7239 : H12AffineFastState.Bounded env7239 := by
  intro p hp
  have h : env7239.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7238_7239 : H12AffineEnvironment.transform 14 16660 env7238 = env7239 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 16660 env7238 == env7239) = true)

theorem identity7239 : scanCanonicalize (H12AffineFastState.compose env7239 (packedSelected [1,3,4,9,12,13,15,16,17] rootPS)) = affineNative (2^(17+1) ^^^ 18740) := by decide +kernel

theorem selectedBound7239 : packedSelected [1,3,4,9,12,13,15,16,17] rootPS < 2^1333 := by decide +kernel

def env7240 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,17,9,16384,16660,65536,16,18740,256,16660,17,4194304,16385,65537,16529,16384,4212784,16,17,4262287,16404,4294967296,257,4299243707,17,16537]

theorem envBound7240 : H12AffineFastState.Bounded env7240 := by
  intro p hp
  have h : env7240.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7239_7240 : H12AffineEnvironment.transform 17 18740 env7239 = env7240 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 18740 env7239 == env7240) = true)

theorem identity7240 : scanCanonicalize (H12AffineFastState.compose env7240 (packedSelected [5,6,15,21] rootPS)) = affineNative (2^(15+1) ^^^ 41) := by decide +kernel

theorem selectedBound7240 : packedSelected [5,6,15,21] rootPS < 2^1333 := by decide +kernel

def env7241 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,17,9,16384,16660,41,16,18740,256,16660,17,4194304,16385,40,16529,16384,4212784,16,17,4196774,16404,4294967296,257,4299178130,17,16537]

theorem envBound7241 : H12AffineFastState.Bounded env7241 := by
  intro p hp
  have h : env7241.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7240_7241 : H12AffineEnvironment.transform 15 41 env7240 = env7241 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 41 env7240 == env7241) = true)

theorem identity7241 : scanCanonicalize (H12AffineFastState.compose env7241 (packedSelected [4,8,9,10,12,15,16] rootPS)) = affineNative (2^(31+1) ^^^ 2081) := by decide +kernel

theorem selectedBound7241 : packedSelected [4,8,9,10,12,15,16] rootPS < 2^1333 := by decide +kernel

def env7242 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,17,9,16384,16660,41,16,18740,256,16660,17,4194304,16385,40,16529,16384,4212784,16,17,4196774,16404,2081,257,4212915,17,16537]

theorem envBound7242 : H12AffineFastState.Bounded env7242 := by
  intro p hp
  have h : env7242.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7241_7242 : H12AffineEnvironment.transform 31 2081 env7241 = env7242 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 2081 env7241 == env7242) = true)

theorem identity7242 : scanCanonicalize (H12AffineFastState.compose env7242 (packedSelected [1,8,10,13,15] rootPS)) = affineNative (2^(21+1) ^^^ 2318) := by decide +kernel

theorem selectedBound7242 : packedSelected [1,8,10,13,15] rootPS < 2^1333 := by decide +kernel

def env7243 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,17,9,16384,16660,41,16,18740,256,16660,17,2318,16385,40,16529,16384,16702,16,17,168,16404,2081,257,16829,17,16537]

theorem envBound7243 : H12AffineFastState.Bounded env7243 := by
  intro p hp
  have h : env7243.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7242_7243 : H12AffineEnvironment.transform 21 2318 env7242 = env7243 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 2318 env7242 == env7243) = true)

theorem identity7243 : scanCanonicalize (H12AffineFastState.compose env7243 (packedSelected [3,5,6,10] rootPS)) = affineNative (2^(6+1) ^^^ 34) := by decide +kernel

theorem selectedBound7243 : packedSelected [3,5,6,10] rootPS < 2^1333 := by decide +kernel

def env7244 : List Nat := [2,4,8,16,32,17,34,256,43,257,2048,17,9,16384,16660,41,16,18740,256,16660,17,2318,16385,40,16435,16384,16702,16,17,10,16404,2081,257,16671,17,16443]

theorem envBound7244 : H12AffineFastState.Bounded env7244 := by
  intro p hp
  have h : env7244.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7243_7244 : H12AffineEnvironment.transform 6 34 env7243 = env7244 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 34 env7243 == env7244) = true)

theorem identity7244 : scanCanonicalize (H12AffineFastState.compose env7244 (packedSelected [0,3,4,5,7,9] rootPS)) = affineNative (2^(13+1) ^^^ 2366) := by decide +kernel

theorem selectedBound7244 : packedSelected [0,3,4,5,7,9] rootPS < 2^1333 := by decide +kernel

def env7245 : List Nat := [2,4,8,16,32,17,34,256,43,257,2048,17,9,2366,2090,41,16,10,256,2090,17,2318,2367,40,2317,2366,2048,16,17,10,2346,2081,257,2081,17,2309]

theorem envBound7245 : H12AffineFastState.Bounded env7245 := by
  intro p hp
  have h : env7245.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7244_7245 : H12AffineEnvironment.transform 13 2366 env7244 = env7245 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 2366 env7244 == env7245) = true)

theorem identity7245 : scanCanonicalize (H12AffineFastState.compose env7245 (packedSelected [0,1,3,4] rootPS)) = affineNative (2^(10+1) ^^^ 48) := by decide +kernel

theorem selectedBound7245 : packedSelected [0,1,3,4] rootPS < 2^1333 := by decide +kernel

def env7246 : List Nat := [2,4,8,16,32,17,34,256,43,257,48,17,9,270,26,41,16,10,256,26,17,318,271,40,317,270,48,16,17,10,282,17,257,17,17,309]

theorem envBound7246 : H12AffineFastState.Bounded env7246 := by
  intro p hp
  have h : env7246.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7245_7246 : H12AffineEnvironment.transform 10 48 env7245 = env7246 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 48 env7245 == env7246) = true)

theorem identity7246 : scanCanonicalize (H12AffineFastState.compose env7246 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 15) := by decide +kernel

theorem selectedBound7246 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env7247 : List Nat := [2,4,8,16,32,17,34,15,43,14,48,17,9,1,26,41,16,10,15,26,17,49,0,40,50,1,48,16,17,10,21,17,14,17,17,58]

theorem envBound7247 : H12AffineFastState.Bounded env7247 := by
  intro p hp
  have h : env7247.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7246_7247 : H12AffineEnvironment.transform 7 15 env7246 = env7247 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 15 env7246 == env7247) = true)

theorem identity7247 : scanCanonicalize (H12AffineFastState.compose env7247 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound7247 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7248 : List Nat := [2,4,8,16,1,17,3,15,10,14,17,17,9,1,26,8,16,10,15,26,17,16,0,9,19,1,17,16,17,10,21,17,14,17,17,27]

theorem envBound7248 : H12AffineFastState.Bounded env7248 := by
  intro p hp
  have h : env7248.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7247_7248 : H12AffineEnvironment.transform 4 1 env7247 = env7248 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env7247 == env7248) = true)

theorem identity7248 : scanCanonicalize (H12AffineFastState.compose env7248 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound7248 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7249 : List Nat := [2,4,8,0,1,1,3,15,10,14,1,1,9,1,10,8,0,10,15,10,1,0,0,9,3,1,1,0,1,10,5,1,14,1,1,11]

theorem envBound7249 : H12AffineFastState.Bounded env7249 := by
  intro p hp
  have h : env7249.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7248_7249 : H12AffineEnvironment.transform 3 0 env7248 = env7249 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7248 == env7249) = true)

theorem identity7249 : scanCanonicalize (H12AffineFastState.compose env7249 (packedSelected [0] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound7249 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7250 : List Nat := [2,4,2,0,1,1,3,5,0,4,1,1,3,1,0,2,0,0,5,0,1,0,0,3,3,1,1,0,1,0,5,1,4,1,1,1]

theorem envBound7250 : H12AffineFastState.Bounded env7250 := by
  intro p hp
  have h : env7250.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7249_7250 : H12AffineEnvironment.transform 2 2 env7249 = env7250 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env7249 == env7250) = true)

def env7251 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,16777216,16859281,16875797,21352448,16897045,4096,20978846,16876544,4294967296,257,4315972782,4096,16859289]

theorem envBound7251 : H12AffineFastState.Bounded env7251 := by
  intro p hp
  have h : env7251.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7207_7251 : H12AffineEnvironment.transform 24 16859281 env7207 = env7251 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 16859281 env7207 == env7251) = true)

def env7252 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,9,16384,32768,65536,4097,262144,257,32768,4096,4194304,16384,16777216,16859281,16875797,21352448,16896277,4096,20978078,16875776,4294967296,257,4315972014,4096,16859289]

theorem envBound7252 : H12AffineFastState.Bounded env7252 := by
  intro p hp
  have h : env7252.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7251_7252 : H12AffineEnvironment.transform 9 256 env7251 = env7252 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 256 env7251 == env7252) = true)

def env7253 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,9,16384,32768,65536,4097,262144,257,32768,4096,4194304,16384,65536,16529,33045,4509696,53525,4096,4266398,33024,4294967296,257,4299260334,4096,16537]

theorem envBound7253 : H12AffineFastState.Bounded env7253 := by
  intro p hp
  have h : env7253.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7252_7253 : H12AffineEnvironment.transform 23 65536 env7252 = env7253 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 65536 env7252 == env7253) = true)

theorem identity7253 : scanCanonicalize (H12AffineFastState.compose env7253 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(14+1) ^^^ 4372) := by decide +kernel

theorem selectedBound7253 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env7254 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,9,16384,4372,65536,4097,262144,257,4372,4096,4194304,16384,65536,16529,4097,4473108,16385,4096,4266398,4116,4294967296,257,4299231418,4096,16537]

theorem envBound7254 : H12AffineFastState.Bounded env7254 := by
  intro p hp
  have h : env7254.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7253_7254 : H12AffineEnvironment.transform 14 4372 env7253 = env7254 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 4372 env7253 == env7254) = true)

theorem identity7254 : scanCanonicalize (H12AffineFastState.compose env7254 (packedSelected [0,1,3,4,5,7,8,9,10,16,19,20] rootPS)) = affineNative (2^(13+1) ^^^ 17) := by decide +kernel

theorem selectedBound7254 : packedSelected [0,1,3,4,5,7,8,9,10,16,19,20] rootPS < 2^1333 := by decide +kernel

def env7255 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,9,17,4372,65536,4097,262144,257,4372,4096,4194304,17,65536,128,4097,4456709,16,4096,4266398,4116,4294967296,257,4299231418,4096,136]

theorem envBound7255 : H12AffineFastState.Bounded env7255 := by
  intro p hp
  have h : env7255.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7254_7255 : H12AffineEnvironment.transform 13 17 env7254 = env7255 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 17 env7254 == env7255) = true)

theorem identity7255 : scanCanonicalize (H12AffineFastState.compose env7255 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 4460603) := by decide +kernel

theorem selectedBound7255 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7256 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,9,17,4372,65536,4097,262144,257,4372,4096,4194304,17,65536,128,4097,4456709,16,4096,4266398,4116,4460603,257,327809,4096,136]

theorem envBound7256 : H12AffineFastState.Bounded env7256 := by
  intro p hp
  have h : env7256.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7255_7256 : H12AffineEnvironment.transform 31 4460603 env7255 = env7256 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4460603 env7255 == env7256) = true)

theorem identity7256 : scanCanonicalize (H12AffineFastState.compose env7256 (packedSelected [10,12,17] rootPS)) = affineNative (2^(17+1) ^^^ 6452) := by decide +kernel

theorem selectedBound7256 : packedSelected [10,12,17] rootPS < 2^1333 := by decide +kernel

def env7257 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,9,17,4372,65536,4097,6452,257,4372,4096,4194304,17,65536,128,4097,4200497,16,4096,4266398,4116,4196623,257,72117,4096,136]

theorem envBound7257 : H12AffineFastState.Bounded env7257 := by
  intro p hp
  have h : env7257.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7256_7257 : H12AffineEnvironment.transform 17 6452 env7256 = env7257 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 6452 env7256 == env7257) = true)

theorem identity7257 : scanCanonicalize (H12AffineFastState.compose env7257 (packedSelected [5,8] rootPS)) = affineNative (2^(11+1) ^^^ 16) := by decide +kernel

theorem selectedBound7257 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env7258 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,16,9,17,260,65536,17,2340,257,260,16,4194304,17,65536,128,17,4196385,16,16,4262286,4,4196623,257,68005,16,136]

theorem envBound7258 : H12AffineFastState.Bounded env7258 := by
  intro p hp
  have h : env7258.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7257_7258 : H12AffineEnvironment.transform 11 16 env7257 = env7258 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 16 env7257 == env7258) = true)

theorem identity7258 : scanCanonicalize (H12AffineFastState.compose env7258 (packedSelected [1] rootPS)) = affineNative (2^(21+1) ^^^ 2179) := by decide +kernel

theorem selectedBound7258 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7259 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,16,9,17,260,65536,17,2340,257,260,16,2179,17,65536,128,17,162,16,16,65805,4,396,257,68005,16,136]

theorem envBound7259 : H12AffineFastState.Bounded env7259 := by
  intro p hp
  have h : env7259.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7258_7259 : H12AffineEnvironment.transform 21 2179 env7258 = env7259 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 2179 env7258 == env7259) = true)

theorem identity7259 : scanCanonicalize (H12AffineFastState.compose env7259 (packedSelected [3,5] rootPS)) = affineNative (2^(15+1) ^^^ 161) := by decide +kernel

theorem selectedBound7259 : packedSelected [3,5] rootPS < 2^1333 := by decide +kernel

def env7260 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,16,9,17,260,161,17,2340,257,260,16,2179,17,161,128,17,162,16,16,428,4,396,257,2308,16,136]

theorem envBound7260 : H12AffineFastState.Bounded env7260 := by
  intro p hp
  have h : env7260.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7259_7260 : H12AffineEnvironment.transform 15 161 env7259 = env7260 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 161 env7259 == env7260) = true)

theorem identity7260 : scanCanonicalize (H12AffineFastState.compose env7260 (packedSelected [10] rootPS)) = affineNative (2^(10+1) ^^^ 271) := by decide +kernel

theorem selectedBound7260 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env7261 : List Nat := [2,4,8,16,32,17,128,256,137,256,271,16,9,17,260,161,17,43,257,260,16,396,17,161,128,17,162,16,16,428,4,396,257,11,16,136]

theorem envBound7261 : H12AffineFastState.Bounded env7261 := by
  intro p hp
  have h : env7261.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7260_7261 : H12AffineEnvironment.transform 10 271 env7260 = env7261 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 271 env7260 == env7261) = true)

theorem identity7261 : scanCanonicalize (H12AffineFastState.compose env7261 (packedSelected [3,12] rootPS)) = affineNative (2^(7+1) ^^^ 167) := by decide +kernel

theorem selectedBound7261 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env7262 : List Nat := [2,4,8,16,32,17,128,167,137,167,168,16,9,17,163,161,17,43,166,163,16,43,17,161,128,17,162,16,16,11,4,43,166,11,16,136]

theorem envBound7262 : H12AffineFastState.Bounded env7262 := by
  intro p hp
  have h : env7262.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7261_7262 : H12AffineEnvironment.transform 7 167 env7261 = env7262 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 167 env7261 == env7262) = true)

theorem identity7262 : scanCanonicalize (H12AffineFastState.compose env7262 (packedSelected [4] rootPS)) = affineNative (2^(6+1) ^^^ 24) := by decide +kernel

theorem selectedBound7262 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env7263 : List Nat := [2,4,8,16,32,17,24,63,17,63,48,16,9,17,59,57,17,43,62,59,16,43,17,57,24,17,58,16,16,11,4,43,62,11,16,16]

theorem envBound7263 : H12AffineFastState.Bounded env7263 := by
  intro p hp
  have h : env7263.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7262_7263 : H12AffineEnvironment.transform 6 24 env7262 = env7263 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 24 env7262 == env7263) = true)

theorem identity7263 : scanCanonicalize (H12AffineFastState.compose env7263 (packedSelected [2,3] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound7263 : packedSelected [2,3] rootPS < 2^1333 := by decide +kernel

def env7264 : List Nat := [2,4,8,1,32,0,9,46,0,46,33,1,9,0,42,40,0,43,47,42,1,43,0,40,9,0,43,1,1,11,4,43,47,11,1,1]

theorem envBound7264 : H12AffineFastState.Bounded env7264 := by
  intro p hp
  have h : env7264.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7263_7264 : H12AffineEnvironment.transform 3 1 env7263 = env7264 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7263 == env7264) = true)

theorem identity7264 : scanCanonicalize (H12AffineFastState.compose env7264 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound7264 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7265 : List Nat := [2,4,8,1,1,0,9,15,0,15,0,1,9,0,11,9,0,10,14,11,1,10,0,9,9,0,10,1,1,11,4,10,14,11,1,1]

theorem envBound7265 : H12AffineFastState.Bounded env7265 := by
  intro p hp
  have h : env7265.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7264_7265 : H12AffineEnvironment.transform 4 1 env7264 = env7265 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env7264 == env7265) = true)

theorem identity7265 : scanCanonicalize (H12AffineFastState.compose env7265 (packedSelected [0] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound7265 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7266 : List Nat := [2,4,2,1,1,0,3,5,0,5,0,1,3,0,1,3,0,0,4,1,1,0,0,3,3,0,0,1,1,1,4,0,4,1,1,1]

theorem envBound7266 : H12AffineFastState.Bounded env7266 := by
  intro p hp
  have h : env7266.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7265_7266 : H12AffineEnvironment.transform 2 2 env7265 = env7266 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env7265 == env7266) = true)

def leafEnv7266 : List Nat := [2,4,2,1,1,0,3,5,0,5,0,1,3,0,1,3,0,0,4,1,1,0,0,3,5,3,1,0,0,1,1,1,4,0,4,1,5,3,1,1,0,1,1]

def active7266 : List Nat := [0,1]

def tree7266 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7266 : H12WitnessSearch.Good tree7266 := H12GlobalWitnessIndex.good

theorem leafIdentity7266 : H12AffineFastState.composeSystem env7266 rootObs = leafEnv7266 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7266 rootObs == leafEnv7266) = true)

theorem terminalChecked7266 : H12PackedTerminal.terminalCheckFast leafEnv7266 active7266 tree7266 = true := by decide +kernel

def env7267 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,4096,9,16384,32768,65536,4097,262144,257,32768,4096,4194304,16384,65537,16528,33044,4509697,53524,4096,4266399,33025,4294967296,257,4299260335,4096,16536]

theorem envBound7267 : H12AffineFastState.Bounded env7267 := by
  intro p hp
  have h : env7267.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7252_7267 : H12AffineEnvironment.transform 23 65537 env7252 = env7267 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 65537 env7252 == env7267) = true)

theorem identity7267 : scanCanonicalize (H12AffineFastState.compose env7267 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(11+1) ^^^ 16) := by decide +kernel

theorem selectedBound7267 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env7268 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,16,9,16384,32768,65536,17,262144,257,32768,16,4194304,16384,65537,16528,33044,4505617,49412,16,4262287,33025,4294967296,257,4299260335,16,16536]

theorem envBound7268 : H12AffineFastState.Bounded env7268 := by
  intro p hp
  have h : env7268.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7267_7268 : H12AffineEnvironment.transform 11 16 env7267 = env7268 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 16 env7267 == env7268) = true)

theorem identity7268 : scanCanonicalize (H12AffineFastState.compose env7268 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(14+1) ^^^ 16661) := by decide +kernel

theorem selectedBound7268 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env7269 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,16,9,16384,16661,65536,17,262144,257,16661,16,4194304,16384,65537,16528,16385,4456708,17,16,4262287,16404,4294967296,257,4299243706,16,16536]

theorem envBound7269 : H12AffineFastState.Bounded env7269 := by
  intro p hp
  have h : env7269.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7268_7269 : H12AffineEnvironment.transform 14 16661 env7268 = env7269 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 16661 env7268 == env7269) = true)

theorem identity7269 : scanCanonicalize (H12AffineFastState.compose env7269 (packedSelected [1,3,4,9,12,13,15,16,17] rootPS)) = affineNative (2^(17+1) ^^^ 18741) := by decide +kernel

theorem selectedBound7269 : packedSelected [1,3,4,9,12,13,15,16,17] rootPS < 2^1333 := by decide +kernel

def env7270 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,16,9,16384,16661,65536,17,18741,257,16661,16,4194304,16384,65537,16528,16385,4212785,17,16,4262287,16404,4294967296,257,4299243706,16,16536]

theorem envBound7270 : H12AffineFastState.Bounded env7270 := by
  intro p hp
  have h : env7270.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7269_7270 : H12AffineEnvironment.transform 17 18741 env7269 = env7270 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 18741 env7269 == env7270) = true)

theorem identity7270 : scanCanonicalize (H12AffineFastState.compose env7270 (packedSelected [5,6,15,21] rootPS)) = affineNative (2^(15+1) ^^^ 16440) := by decide +kernel

theorem selectedBound7270 : packedSelected [5,6,15,21] rootPS < 2^1333 := by decide +kernel

def env7271 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,16,9,16384,16661,16440,17,18741,257,16661,16,4194304,16384,16441,16528,16385,4212785,17,16,4213175,16404,4294967296,257,4299161730,16,16536]

theorem envBound7271 : H12AffineFastState.Bounded env7271 := by
  intro p hp
  have h : env7271.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7270_7271 : H12AffineEnvironment.transform 15 16440 env7270 = env7271 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 16440 env7270 == env7271) = true)

theorem identity7271 : scanCanonicalize (H12AffineFastState.compose env7271 (packedSelected [4,8,9,10,12,15,16] rootPS)) = affineNative (2^(31+1) ^^^ 2080) := by decide +kernel

theorem selectedBound7271 : packedSelected [4,8,9,10,12,15,16] rootPS < 2^1333 := by decide +kernel

def env7272 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,16,9,16384,16661,16440,17,18741,257,16661,16,4194304,16384,16441,16528,16385,4212785,17,16,4213175,16404,2080,257,4196514,16,16536]

theorem envBound7272 : H12AffineFastState.Bounded env7272 := by
  intro p hp
  have h : env7272.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7271_7272 : H12AffineEnvironment.transform 31 2080 env7271 = env7272 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 2080 env7271 == env7272) = true)

theorem identity7272 : scanCanonicalize (H12AffineFastState.compose env7272 (packedSelected [1,8,10,13,15] rootPS)) = affineNative (2^(21+1) ^^^ 18719) := by decide +kernel

theorem selectedBound7272 : packedSelected [1,8,10,13,15] rootPS < 2^1333 := by decide +kernel

def env7273 : List Nat := [2,4,8,16,32,17,128,256,137,256,2048,16,9,16384,16661,16440,17,18741,257,16661,16,18719,16384,16441,16528,16385,302,17,16,168,16404,2080,257,16829,16,16536]

theorem envBound7273 : H12AffineFastState.Bounded env7273 := by
  intro p hp
  have h : env7273.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7272_7273 : H12AffineEnvironment.transform 21 18719 env7272 = env7273 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 18719 env7272 == env7273) = true)

theorem identity7273 : scanCanonicalize (H12AffineFastState.compose env7273 (packedSelected [3,5,6,10] rootPS)) = affineNative (2^(6+1) ^^^ 35) := by decide +kernel

theorem selectedBound7273 : packedSelected [3,5,6,10] rootPS < 2^1333 := by decide +kernel

def env7274 : List Nat := [2,4,8,16,32,17,35,256,42,256,2048,16,9,16384,16661,16440,17,18741,257,16661,16,18719,16384,16441,16435,16385,302,17,16,11,16404,2080,257,16670,16,16443]

theorem envBound7274 : H12AffineFastState.Bounded env7274 := by
  intro p hp
  have h : env7274.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7273_7274 : H12AffineEnvironment.transform 6 35 env7273 = env7274 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 35 env7273 == env7274) = true)

theorem identity7274 : scanCanonicalize (H12AffineFastState.compose env7274 (packedSelected [3,5,6] rootPS)) = affineNative (2^(13+1) ^^^ 16) := by decide +kernel

theorem selectedBound7274 : packedSelected [3,5,6] rootPS < 2^1333 := by decide +kernel

def env7275 : List Nat := [2,4,8,16,32,17,35,256,42,256,2048,16,9,16,261,40,17,2341,257,261,16,2319,16,41,35,17,302,17,16,11,4,2080,257,270,16,43]

theorem envBound7275 : H12AffineFastState.Bounded env7275 := by
  intro p hp
  have h : env7275.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7274_7275 : H12AffineEnvironment.transform 13 16 env7274 = env7275 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 16 env7274 == env7275) = true)

theorem identity7275 : scanCanonicalize (H12AffineFastState.compose env7275 (packedSelected [3] rootPS)) = affineNative (2^(10+1) ^^^ 319) := by decide +kernel

theorem selectedBound7275 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env7276 : List Nat := [2,4,8,16,32,17,35,256,42,256,319,16,9,16,261,40,17,26,257,261,16,48,16,41,35,17,302,17,16,11,4,287,257,270,16,43]

theorem envBound7276 : H12AffineFastState.Bounded env7276 := by
  intro p hp
  have h : env7276.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7275_7276 : H12AffineEnvironment.transform 10 319 env7275 = env7276 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 319 env7275 == env7276) = true)

def env7277 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,9,16384,32768,65536,4097,262144,256,32768,4096,4194304,16385,16777216,16859281,16875797,21352448,16896276,4096,20978079,16875777,4294967296,257,4315972015,4096,16859289]

theorem envBound7277 : H12AffineFastState.Bounded env7277 := by
  intro p hp
  have h : env7277.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7251_7277 : H12AffineEnvironment.transform 9 257 env7251 = env7277 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 257 env7251 == env7277) = true)

theorem identity7277 : scanCanonicalize (H12AffineFastState.compose env7277 (packedSelected [0,3,4,7,9,10,13,16,17,20,21,24,26,33] rootPS)) = affineNative (2^(23+1) ^^^ 81937) := by decide +kernel

theorem selectedBound7277 : packedSelected [0,3,4,7,9,10,13,16,17,20,21,24,26,33] rootPS < 2^1333 := by decide +kernel

def env7278 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,9,16384,32768,65536,4097,262144,256,32768,4096,4194304,16385,81937,128,49412,4493329,37125,4096,4282766,49424,4294967296,257,4299276734,4096,136]

theorem envBound7278 : H12AffineFastState.Bounded env7278 := by
  intro p hp
  have h : env7278.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7277_7278 : H12AffineEnvironment.transform 23 81937 env7277 = env7278 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 81937 env7277 == env7278) = true)

theorem identity7278 : scanCanonicalize (H12AffineFastState.compose env7278 (packedSelected [3,4,9,10,16,24,26] rootPS)) = affineNative (2^(14+1) ^^^ 20740) := by decide +kernel

theorem selectedBound7278 : packedSelected [3,4,9,10,16,24,26] rootPS < 2^1333 := by decide +kernel

def env7279 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,4096,9,16384,20740,65536,4097,262144,256,20740,4096,4194304,16385,81937,128,4096,4473109,16385,4096,4282766,4116,4294967296,257,4299231418,4096,136]

theorem envBound7279 : H12AffineFastState.Bounded env7279 := by
  intro p hp
  have h : env7279.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7278_7279 : H12AffineEnvironment.transform 14 20740 env7278 = env7279 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 20740 env7278 == env7279) = true)

theorem identity7279 : scanCanonicalize (H12AffineFastState.compose env7279 (packedSelected [4,5,8,9,16,17,21] rootPS)) = affineNative (2^(11+1) ^^^ 16) := by decide +kernel

theorem selectedBound7279 : packedSelected [4,5,8,9,16,17,21] rootPS < 2^1333 := by decide +kernel

def env7280 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,16,9,16384,16660,65536,17,262144,256,16660,16,4194304,16385,81937,128,16,4473109,16385,16,4278686,4,4294967296,257,4299227306,16,136]

theorem envBound7280 : H12AffineFastState.Bounded env7280 := by
  intro p hp
  have h : env7280.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7279_7280 : H12AffineEnvironment.transform 11 16 env7279 = env7280 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 16 env7279 == env7280) = true)

theorem identity7280 : scanCanonicalize (H12AffineFastState.compose env7280 (packedSelected [3,5,6,10] rootPS)) = affineNative (2^(31+1) ^^^ 4522253) := by decide +kernel

theorem selectedBound7280 : packedSelected [3,5,6,10] rootPS < 2^1333 := by decide +kernel

def env7281 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,16,9,16384,16660,65536,17,262144,256,16660,16,4194304,16385,81937,128,16,4473109,16385,16,4278686,4,4522253,257,262567,16,136]

theorem envBound7281 : H12AffineFastState.Bounded env7281 := by
  intro p hp
  have h : env7281.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7280_7281 : H12AffineEnvironment.transform 31 4522253 env7280 = env7281 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4522253 env7280 == env7281) = true)

theorem identity7281 : scanCanonicalize (H12AffineFastState.compose env7281 (packedSelected [1,3,5,6,8,12,15] rootPS)) = affineNative (2^(21+1) ^^^ 16432) := by decide +kernel

theorem selectedBound7281 : packedSelected [1,3,5,6,8,12,15] rootPS < 2^1333 := by decide +kernel

def env7282 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,16,9,16384,16660,65536,17,262144,256,16660,16,16432,16385,81937,128,16,262437,16385,16,68014,4,344381,257,262567,16,136]

theorem envBound7282 : H12AffineFastState.Bounded env7282 := by
  intro p hp
  have h : env7282.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7281_7282 : H12AffineEnvironment.transform 21 16432 env7281 = env7282 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 16432 env7281 == env7282) = true)

theorem identity7282 : scanCanonicalize (H12AffineFastState.compose env7282 (packedSelected [4,9,16] rootPS)) = affineNative (2^(13+1) ^^^ 16) := by decide +kernel

theorem selectedBound7282 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env7283 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,16,9,16,260,65536,17,262144,256,260,16,32,17,65537,128,16,262437,17,16,68014,4,327981,257,262567,16,136]

theorem envBound7283 : H12AffineFastState.Bounded env7283 := by
  intro p hp
  have h : env7283.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7282_7283 : H12AffineEnvironment.transform 13 16 env7282 = env7283 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 16 env7282 == env7283) = true)

theorem identity7283 : scanCanonicalize (H12AffineFastState.compose env7283 (packedSelected [1,3,5] rootPS)) = affineNative (2^(17+1) ^^^ 65544) := by decide +kernel

theorem selectedBound7283 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env7284 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,16,9,16,260,65536,17,65544,256,260,16,32,17,65537,128,16,65837,17,16,68014,4,293,257,65967,16,136]

theorem envBound7284 : H12AffineFastState.Bounded env7284 := by
  intro p hp
  have h : env7284.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7283_7284 : H12AffineEnvironment.transform 17 65544 env7283 = env7284 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 65544 env7283 == env7284) = true)

theorem identity7284 : scanCanonicalize (H12AffineFastState.compose env7284 (packedSelected [2] rootPS)) = affineNative (2^(15+1) ^^^ 2218) := by decide +kernel

theorem selectedBound7284 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7285 : List Nat := [2,4,8,16,32,17,128,256,137,257,2048,16,9,16,260,2218,17,2210,256,260,16,32,17,2219,128,16,2439,17,16,260,4,293,257,2309,16,136]

theorem envBound7285 : H12AffineFastState.Bounded env7285 := by
  intro p hp
  have h : env7285.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7284_7285 : H12AffineEnvironment.transform 15 2218 env7284 = env7285 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2218 env7284 == env7285) = true)

theorem identity7285 : scanCanonicalize (H12AffineFastState.compose env7285 (packedSelected [6] rootPS)) = affineNative (2^(10+1) ^^^ 33) := by decide +kernel

theorem selectedBound7285 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7286 : List Nat := [2,4,8,16,32,17,128,256,137,257,33,16,9,16,260,139,17,131,256,260,16,32,17,138,128,16,422,17,16,260,4,293,257,292,16,136]

theorem envBound7286 : H12AffineFastState.Bounded env7286 := by
  intro p hp
  have h : env7286.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7285_7286 : H12AffineEnvironment.transform 10 33 env7285 = env7286 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 33 env7285 == env7286) = true)

theorem identity7286 : scanCanonicalize (H12AffineFastState.compose env7286 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 151) := by decide +kernel

theorem selectedBound7286 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7287 : List Nat := [2,4,8,16,32,17,128,151,137,150,33,16,9,16,147,139,17,131,151,147,16,32,17,138,128,16,49,17,16,147,4,178,150,179,16,136]

theorem envBound7287 : H12AffineFastState.Bounded env7287 := by
  intro p hp
  have h : env7287.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7286_7287 : H12AffineEnvironment.transform 7 151 env7286 = env7287 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 151 env7286 == env7287) = true)

theorem identity7287 : scanCanonicalize (H12AffineFastState.compose env7287 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound7287 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7288 : List Nat := [2,4,8,16,32,17,3,20,10,21,33,16,9,16,16,8,17,0,20,16,16,32,17,9,3,16,49,17,16,16,4,49,21,48,16,11]

theorem envBound7288 : H12AffineFastState.Bounded env7288 := by
  intro p hp
  have h : env7288.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7287_7288 : H12AffineEnvironment.transform 6 3 env7287 = env7288 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env7287 == env7288) = true)

theorem identity7288 : scanCanonicalize (H12AffineFastState.compose env7288 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound7288 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env7289 : List Nat := [2,4,8,1,32,0,3,5,10,4,33,1,9,1,1,8,0,0,5,1,1,32,0,9,3,1,32,0,1,1,4,32,4,33,1,11]

theorem envBound7289 : H12AffineFastState.Bounded env7289 := by
  intro p hp
  have h : env7289.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7288_7289 : H12AffineEnvironment.transform 3 1 env7288 = env7289 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env7288 == env7289) = true)

theorem identity7289 : scanCanonicalize (H12AffineFastState.compose env7289 (packedSelected [4] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound7289 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env7290 : List Nat := [2,4,8,1,0,0,3,5,10,4,1,1,9,1,1,8,0,0,5,1,1,0,0,9,3,1,0,0,1,1,4,0,4,1,1,11]

theorem envBound7290 : H12AffineFastState.Bounded env7290 := by
  intro p hp
  have h : env7290.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7289_7290 : H12AffineEnvironment.transform 4 0 env7289 = env7290 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env7289 == env7290) = true)

def env7291 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,16777216,33554432,17010964,21352448,17024020,131073,21105823,16876544,4294967296,257,4332967606,131073,33554441]

theorem envBound7291 : H12AffineFastState.Bounded env7291 := by
  intro p hp
  have h : env7291.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7174_7291 : H12AffineEnvironment.transform 12 641 env7174 = env7291 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 641 env7174 == env7291) = true)

def env7292 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,16777216,33554432,16875796,21352448,16897044,4097,20978847,16876544,4294967296,257,4332832438,4097,33554441]

theorem envBound7292 : H12AffineFastState.Bounded env7292 := by
  intro p hp
  have h : env7292.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7291_7292 : H12AffineEnvironment.transform 16 4096 env7291 = env7292 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env7291 == env7292) = true)

theorem identity7292 : scanCanonicalize (H12AffineFastState.compose env7292 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(24+1) ^^^ 5520) := by decide +kernel

theorem selectedBound7292 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env7293 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,16777216,5520,16875796,21352448,16897044,4097,20978847,16876544,4294967296,257,4299281190,4097,5529]

theorem envBound7293 : H12AffineFastState.Bounded env7293 := by
  intro p hp
  have h : env7293.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7292_7293 : H12AffineEnvironment.transform 24 5520 env7292 = env7293 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 5520 env7292 == env7293) = true)

def env7294 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,641,16384,32768,65536,1296,262144,1025,32768,1296,4194304,17664,16777216,128,16875796,21349648,16892164,1297,20973967,16876544,4294967296,257,4299277878,1297,137]

theorem envBound7294 : H12AffineFastState.Bounded env7294 := by
  intro p hp
  have h : env7294.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7293_7294 : H12AffineEnvironment.transform 11 1296 env7293 = env7294 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env7293 == env7294) = true)

theorem identity7294 : scanCanonicalize (H12AffineFastState.compose env7294 (packedSelected [1,5,8,19,24,26] rootPS)) = affineNative (2^(23+1) ^^^ 98565) := by decide +kernel

theorem selectedBound7294 : packedSelected [1,5,8,19,24,26] rootPS < 2^1333 := by decide +kernel

def env7295 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,641,16384,32768,65536,1296,262144,1025,32768,1296,4194304,17664,98565,128,17,4473877,16385,1297,4294794,1285,4294967296,257,4299277878,1297,137]

theorem envBound7295 : H12AffineFastState.Bounded env7295 := by
  intro p hp
  have h : env7295.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7294_7295 : H12AffineEnvironment.transform 23 98565 env7294 = env7295 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98565 env7294 == env7295) = true)

theorem identity7295 : scanCanonicalize (H12AffineFastState.compose env7295 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(15+1) ^^^ 18194) := by decide +kernel

theorem selectedBound7295 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env7296 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,641,16384,32768,18194,1296,262144,1025,32768,1296,4194304,17664,50711,128,17,4473877,16385,1297,4247448,1285,4294967296,257,4299194660,1297,137]

theorem envBound7296 : H12AffineFastState.Bounded env7296 := by
  intro p hp
  have h : env7296.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7295_7296 : H12AffineEnvironment.transform 15 18194 env7295 = env7296 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 18194 env7295 == env7296) = true)

theorem identity7296 : scanCanonicalize (H12AffineFastState.compose env7296 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 1944) := by decide +kernel

theorem selectedBound7296 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env7297 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,641,1944,32768,138,1296,262144,1025,32768,1296,4194304,664,33167,128,17,4457357,1945,1297,4229120,1285,4294967296,257,4299194660,1297,137]

theorem envBound7297 : H12AffineFastState.Bounded env7297 := by
  intro p hp
  have h : env7297.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7296_7297 : H12AffineEnvironment.transform 13 1944 env7296 = env7297 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1944 env7296 == env7297) = true)

theorem identity7297 : scanCanonicalize (H12AffineFastState.compose env7297 (packedSelected [5,10,12] rootPS)) = affineNative (2^(17+1) ^^^ 33087) := by decide +kernel

theorem selectedBound7297 : packedSelected [5,10,12] rootPS < 2^1333 := by decide +kernel

def env7298 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,641,1944,32768,138,1296,33087,1025,32768,1296,4194304,664,33167,128,17,4227762,1945,1297,4229120,1285,4294967296,257,4299194660,1297,137]

theorem envBound7298 : H12AffineFastState.Bounded env7298 := by
  intro p hp
  have h : env7298.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7297_7298 : H12AffineEnvironment.transform 17 33087 env7297 = env7298 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 33087 env7297 == env7298) = true)

theorem identity7298 : scanCanonicalize (H12AffineFastState.compose env7298 (packedSelected [4,8,9,13,16] rootPS)) = affineNative (2^(14+1) ^^^ 908) := by decide +kernel

theorem selectedBound7298 : packedSelected [4,8,9,13,16] rootPS < 2^1333 := by decide +kernel

def env7299 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,641,1944,908,138,1296,691,1025,908,1296,4194304,664,515,128,17,4194622,1945,1297,4197260,1285,4294967296,257,4299162280,1297,137]

theorem envBound7299 : H12AffineFastState.Bounded env7299 := by
  intro p hp
  have h : env7299.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7298_7299 : H12AffineEnvironment.transform 14 908 env7298 = env7299 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 908 env7298 == env7299) = true)

theorem identity7299 : scanCanonicalize (H12AffineFastState.compose env7299 (packedSelected [1,5,8,24] rootPS)) = affineNative (2^(10+1) ^^^ 918) := by decide +kernel

theorem selectedBound7299 : packedSelected [1,5,8,24] rootPS < 2^1333 := by decide +kernel

def env7300 : List Nat := [2,4,8,16,32,17,128,256,512,1024,918,1296,641,1944,908,138,1296,691,1025,908,1296,4194304,664,515,128,17,4194622,1945,1297,4194330,1285,4294967296,257,4299162280,1297,137]

theorem envBound7300 : H12AffineFastState.Bounded env7300 := by
  intro p hp
  have h : env7300.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7299_7300 : H12AffineEnvironment.transform 10 918 env7299 = env7300 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 918 env7299 == env7300) = true)

theorem identity7300 : scanCanonicalize (H12AffineFastState.compose env7300 (packedSelected [5,8] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound7300 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env7301 : List Nat := [2,4,8,16,32,17,128,256,136,1024,286,1296,9,1296,260,138,1296,59,1025,260,1296,4194304,16,139,128,17,4194622,1297,1297,4194330,1285,4294967296,257,4299161632,1297,137]

theorem envBound7301 : H12AffineFastState.Bounded env7301 := by
  intro p hp
  have h : env7301.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7300_7301 : H12AffineEnvironment.transform 8 136 env7300 = env7301 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env7300 == env7301) = true)

theorem identity7301 : scanCanonicalize (H12AffineFastState.compose env7301 (packedSelected [1] rootPS)) = affineNative (2^(21+1) ^^^ 286) := by decide +kernel

theorem selectedBound7301 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7302 : List Nat := [2,4,8,16,32,17,128,256,136,1024,286,1296,9,1296,260,138,1296,59,1025,260,1296,286,16,139,128,17,32,1297,1297,260,1285,4294967296,257,4294967614,1297,137]

theorem envBound7302 : H12AffineFastState.Bounded env7302 := by
  intro p hp
  have h : env7302.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7301_7302 : H12AffineEnvironment.transform 21 286 env7301 = env7302 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 286 env7301 == env7302) = true)

theorem identity7302 : scanCanonicalize (H12AffineFastState.compose env7302 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 26) := by decide +kernel

theorem selectedBound7302 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7303 : List Nat := [2,4,8,16,32,17,128,256,136,1024,286,1296,9,1296,260,138,1296,59,1025,260,1296,286,16,139,128,17,32,1297,1297,260,1285,26,257,292,1297,137]

theorem envBound7303 : H12AffineFastState.Bounded env7303 := by
  intro p hp
  have h : env7303.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7302_7303 : H12AffineEnvironment.transform 31 26 env7302 = env7303 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 26 env7302 == env7303) = true)

theorem identity7303 : scanCanonicalize (H12AffineFastState.compose env7303 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound7303 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env7304 : List Nat := [2,4,8,11,32,10,128,256,136,1024,261,1291,9,1291,260,138,1291,32,1025,260,1291,261,11,139,128,10,32,1290,1290,260,1285,1,257,292,1290,137]

theorem envBound7304 : H12AffineFastState.Bounded env7304 := by
  intro p hp
  have h : env7304.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7303_7304 : H12AffineEnvironment.transform 3 11 env7303 = env7304 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env7303 == env7304) = true)

theorem identity7304 : scanCanonicalize (H12AffineFastState.compose env7304 (packedSelected [2,4] rootPS)) = affineNative (2^(6+1) ^^^ 34) := by decide +kernel

theorem selectedBound7304 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env7305 : List Nat := [2,4,8,11,32,10,34,256,42,1024,261,1291,9,1291,260,40,1291,32,1025,260,1291,261,11,41,34,10,32,1290,1290,260,1285,1,257,292,1290,43]

theorem envBound7305 : H12AffineFastState.Bounded env7305 := by
  intro p hp
  have h : env7305.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7304_7305 : H12AffineEnvironment.transform 6 34 env7304 = env7305 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 34 env7304 == env7305) = true)

theorem identity7305 : scanCanonicalize (H12AffineFastState.compose env7305 (packedSelected [6] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound7305 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7306 : List Nat := [2,4,8,11,32,10,34,37,42,1024,32,1070,9,1070,33,40,1070,32,1025,33,1070,32,11,41,34,10,32,1071,1071,33,1056,1,36,1,1071,43]

theorem envBound7306 : H12AffineFastState.Bounded env7306 := by
  intro p hp
  have h : env7306.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7305_7306 : H12AffineEnvironment.transform 7 37 env7305 = env7306 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env7305 == env7306) = true)

def env7307 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,641,16384,32768,65536,1297,262144,1025,32768,1297,4194304,17664,16777216,129,16875796,21349649,16892165,1296,20973966,16876544,4294967296,257,4299277879,1296,136]

theorem envBound7307 : H12AffineFastState.Bounded env7307 := by
  intro p hp
  have h : env7307.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7293_7307 : H12AffineEnvironment.transform 11 1297 env7293 = env7307 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env7293 == env7307) = true)

theorem identity7307 : scanCanonicalize (H12AffineFastState.compose env7307 (packedSelected [1,5,8,19,24,26] rootPS)) = affineNative (2^(23+1) ^^^ 99213) := by decide +kernel

theorem selectedBound7307 : packedSelected [1,5,8,19,24,26] rootPS < 2^1333 := by decide +kernel

def env7308 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,641,16384,32768,65536,1297,262144,1025,32768,1297,4194304,17664,99213,129,665,4474524,17032,1296,4295171,1933,4294967296,257,4299277879,1296,136]

theorem envBound7308 : H12AffineFastState.Bounded env7308 := by
  intro p hp
  have h : env7308.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7307_7308 : H12AffineEnvironment.transform 23 99213 env7307 = env7308 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 99213 env7307 == env7308) = true)

theorem identity7308 : scanCanonicalize (H12AffineFastState.compose env7308 (packedSelected [1,3,4,9,12,13,15,16,17] rootPS)) = affineNative (2^(17+1) ^^^ 34849) := by decide +kernel

theorem selectedBound7308 : packedSelected [1,3,4,9,12,13,15,16,17] rootPS < 2^1333 := by decide +kernel

def env7309 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,641,16384,32768,65536,1297,34849,1025,32768,1297,4194304,17664,99213,129,665,4247229,17032,1296,4295171,1933,4294967296,257,4299277879,1296,136]

theorem envBound7309 : H12AffineFastState.Bounded env7309 := by
  intro p hp
  have h : env7309.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7308_7309 : H12AffineEnvironment.transform 17 34849 env7308 = env7309 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 34849 env7308 == env7309) = true)

theorem identity7309 : scanCanonicalize (H12AffineFastState.compose env7309 (packedSelected [3,5,8,10,28,31] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound7309 : packedSelected [3,5,8,10,28,31] rootPS < 2^1333 := by decide +kernel

def env7310 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,16384,32768,65536,1297,34849,1025,32768,1297,4194304,17664,98564,129,16,4246580,16385,1296,4294794,1284,4294967296,257,4299277502,1296,136]

theorem envBound7310 : H12AffineFastState.Bounded env7310 := by
  intro p hp
  have h : env7310.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7309_7310 : H12AffineEnvironment.transform 8 137 env7309 = env7310 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env7309 == env7310) = true)

theorem identity7310 : scanCanonicalize (H12AffineFastState.compose env7310 (packedSelected [5,8] rootPS)) = affineNative (2^(15+1) ^^^ 33166) := by decide +kernel

theorem selectedBound7310 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env7311 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,16384,32768,33166,1297,34849,1025,32768,1297,4194304,17664,138,129,16,4246580,16385,1296,4196612,1284,4294967296,257,4299179312,1296,136]

theorem envBound7311 : H12AffineFastState.Bounded env7311 := by
  intro p hp
  have h : env7311.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7310_7311 : H12AffineEnvironment.transform 15 33166 env7310 = env7311 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33166 env7310 == env7311) = true)

theorem identity7311 : scanCanonicalize (H12AffineFastState.compose env7311 (packedSelected [0,2,3,4,5,6,10,11,12] rootPS)) = affineNative (2^(21+1) ^^^ 19728) := by decide +kernel

theorem selectedBound7311 : packedSelected [0,2,3,4,5,6,10,11,12] rootPS < 2^1333 := by decide +kernel

def env7312 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,16384,32768,33166,1297,34849,1025,32768,1297,19728,17664,138,129,16,33060,16385,1296,17428,1284,4294967296,257,4294969376,1296,136]

theorem envBound7312 : H12AffineFastState.Bounded env7312 := by
  intro p hp
  have h : env7312.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7311_7312 : H12AffineEnvironment.transform 21 19728 env7311 = env7312 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 19728 env7311 == env7312) = true)

theorem identity7312 : scanCanonicalize (H12AffineFastState.compose env7312 (packedSelected [0,3,5,6,10] rootPS)) = affineNative (2^(13+1) ^^^ 3344) := by decide +kernel

theorem selectedBound7312 : packedSelected [0,3,5,6,10] rootPS < 2^1333 := by decide +kernel

def env7313 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,3344,32768,33166,1297,34849,1025,32768,1297,0,2064,138,129,16,33060,3345,1296,2308,1284,4294967296,257,4294969376,1296,136]

theorem envBound7313 : H12AffineFastState.Bounded env7313 := by
  intro p hp
  have h : env7313.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7312_7313 : H12AffineEnvironment.transform 13 3344 env7312 = env7313 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 3344 env7312 == env7313) = true)

theorem identity7313 : scanCanonicalize (H12AffineFastState.compose env7313 (packedSelected [0,4,7,9,11] rootPS)) = affineNative (2^(10+1) ^^^ 261) := by decide +kernel

theorem selectedBound7313 : packedSelected [0,4,7,9,11] rootPS < 2^1333 := by decide +kernel

def env7314 : List Nat := [2,4,8,16,32,17,128,256,137,1024,261,1297,8,1045,32768,33166,1297,33060,1025,32768,1297,0,277,138,129,16,33060,1044,1296,1,1284,4294967296,257,4294967589,1296,136]

theorem envBound7314 : H12AffineFastState.Bounded env7314 := by
  intro p hp
  have h : env7314.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7313_7314 : H12AffineEnvironment.transform 10 261 env7313 = env7314 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 261 env7313 == env7314) = true)

theorem identity7314 : scanCanonicalize (H12AffineFastState.compose env7314 (packedSelected [0,7] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound7314 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env7315 : List Nat := [2,4,8,16,32,17,128,5,137,1024,0,1044,8,1045,32768,32907,1044,32801,1025,32768,1044,0,16,138,129,16,32801,1044,1045,1,1025,4294967296,4,4294967328,1045,136]

theorem envBound7315 : H12AffineFastState.Bounded env7315 := by
  intro p hp
  have h : env7315.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7314_7315 : H12AffineEnvironment.transform 7 5 env7314 = env7315 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env7314 == env7315) = true)

theorem identity7315 : scanCanonicalize (H12AffineFastState.compose env7315 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 33) := by decide +kernel

theorem selectedBound7315 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7316 : List Nat := [2,4,8,16,32,17,128,5,137,1024,0,1044,8,1045,32768,32907,1044,32801,1025,32768,1044,0,16,138,129,16,32801,1044,1045,1,1025,33,4,1,1045,136]

theorem envBound7316 : H12AffineFastState.Bounded env7316 := by
  intro p hp
  have h : env7316.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7315_7316 : H12AffineEnvironment.transform 31 33 env7315 = env7316 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 33 env7315 == env7316) = true)

theorem identity7316 : scanCanonicalize (H12AffineFastState.compose env7316 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 57) := by decide +kernel

theorem selectedBound7316 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7317 : List Nat := [2,4,8,16,32,17,57,5,48,1024,0,1044,8,1045,32768,32818,1044,32801,1025,32768,1044,0,16,51,56,16,32801,1044,1045,1,1025,33,4,1,1045,49]

theorem envBound7317 : H12AffineFastState.Bounded env7317 := by
  intro p hp
  have h : env7317.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7316_7317 : H12AffineEnvironment.transform 6 57 env7316 = env7317 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 57 env7316 == env7317) = true)

theorem identity7317 : scanCanonicalize (H12AffineFastState.compose env7317 (packedSelected [3] rootPS)) = affineNative (2^(14+1) ^^^ 49) := by decide +kernel

theorem selectedBound7317 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env7318 : List Nat := [2,4,8,16,32,17,57,5,48,1024,0,1044,8,1045,49,3,1044,16,1025,49,1044,0,16,51,56,16,16,1044,1045,1,1025,33,4,1,1045,49]

theorem envBound7318 : H12AffineFastState.Bounded env7318 := by
  intro p hp
  have h : env7318.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7317_7318 : H12AffineEnvironment.transform 14 49 env7317 = env7318 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 49 env7317 == env7318) = true)

theorem identity7318 : scanCanonicalize (H12AffineFastState.compose env7318 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound7318 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7319 : List Nat := [2,4,8,11,32,10,34,5,43,1024,0,1039,8,1038,42,3,1039,11,1025,42,1039,0,11,40,35,11,11,1039,1038,1,1025,33,4,1,1038,42]

theorem envBound7319 : H12AffineFastState.Bounded env7319 := by
  intro p hp
  have h : env7319.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7318_7319 : H12AffineEnvironment.transform 3 11 env7318 = env7319 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env7318 == env7319) = true)

theorem identity7319 : scanCanonicalize (H12AffineFastState.compose env7319 (packedSelected [4] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound7319 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env7320 : List Nat := [2,4,8,11,11,10,9,5,0,1024,0,1039,8,1038,1,3,1039,11,1025,1,1039,0,11,3,8,11,11,1039,1038,1,1025,10,4,1,1038,1]

theorem envBound7320 : H12AffineFastState.Bounded env7320 := by
  intro p hp
  have h : env7320.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7319_7320 : H12AffineEnvironment.transform 4 11 env7319 = env7320 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env7319 == env7320) = true)

theorem identity7320 : scanCanonicalize (H12AffineFastState.compose env7320 (packedSelected [5] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound7320 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env7321 : List Nat := [2,4,2,1,1,0,3,5,0,1024,0,1029,2,1028,1,3,1029,1,1025,1,1029,0,1,3,2,1,1,1029,1028,1,1025,0,4,1,1028,1]

theorem envBound7321 : H12AffineFastState.Bounded env7321 := by
  intro p hp
  have h : env7321.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7320_7321 : H12AffineEnvironment.transform 2 2 env7320 = env7321 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env7320 == env7321) = true)

def leafEnv7321 : List Nat := [2,4,2,1,1,0,3,5,0,1024,0,1029,2,1028,1,3,1029,1,1025,1,1029,0,1,3,1024,2,1,1,1,1029,1028,1,1025,0,4,1,5,3,1028,1,0,1028,1]

def active7321 : List Nat := [0,1,9]

def tree7321 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7321 : H12WitnessSearch.Good tree7321 := H12GlobalWitnessIndex.good

theorem leafIdentity7321 : H12AffineFastState.composeSystem env7321 rootObs = leafEnv7321 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7321 rootObs == leafEnv7321) = true)

theorem terminalChecked7321 : H12PackedTerminal.terminalCheckFast leafEnv7321 active7321 tree7321 = true := by decide +kernel

def env7322 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,16777216,33554432,16875797,21352448,16897045,4096,20978846,16876544,4294967296,257,4332832439,4096,33554441]

theorem envBound7322 : H12AffineFastState.Bounded env7322 := by
  intro p hp
  have h : env7322.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7291_7322 : H12AffineEnvironment.transform 16 4097 env7291 = env7322 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env7291 == env7322) = true)

theorem identity7322 : scanCanonicalize (H12AffineFastState.compose env7322 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(24+1) ^^^ 129) := by decide +kernel

theorem selectedBound7322 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env7323 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,16777216,129,16875797,21352448,16897045,4096,20978846,16876544,4294967296,257,4299277878,4096,136]

theorem envBound7323 : H12AffineFastState.Bounded env7323 := by
  intro p hp
  have h : env7323.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7322_7323 : H12AffineEnvironment.transform 24 129 env7322 = env7323 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 129 env7322 == env7323) = true)

def env7324 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,4293120,129,4195093,283136,4216341,4096,106142,4195840,4294967296,257,4299277878,4096,136]

theorem envBound7324 : H12AffineFastState.Bounded env7324 := by
  intro p hp
  have h : env7324.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7323_7324 : H12AffineEnvironment.transform 23 4293120 env7323 = env7324 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 4293120 env7323 == env7324) = true)

theorem identity7324 : scanCanonicalize (H12AffineFastState.compose env7324 (packedSelected [1,3,4,5,8,9,10,16,19] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound7324 : packedSelected [1,3,4,5,8,9,10,16,19] rootPS < 2^1333 := by decide +kernel

def env7325 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,4292745,129,4194716,282761,4215964,4096,105495,4195465,4294967296,257,4299277503,4096,136]

theorem envBound7325 : H12AffineFastState.Bounded env7325 := by
  intro p hp
  have h : env7325.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7324_7325 : H12AffineEnvironment.transform 8 137 env7324 = env7325 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env7324 == env7325) = true)

theorem identity7325 : scanCanonicalize (H12AffineFastState.compose env7325 (packedSelected [3,4,9,10,16,24,26] rootPS)) = affineNative (2^(21+1) ^^^ 5277) := by decide +kernel

theorem selectedBound7325 : packedSelected [3,4,9,10,16,24,26] rootPS < 2^1333 := by decide +kernel

def env7326 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8,16384,32768,65536,4097,262144,1025,32768,4096,5277,17664,103444,129,5377,282761,16385,4096,105495,4116,4294967296,257,4295086114,4096,136]

theorem envBound7326 : H12AffineFastState.Bounded env7326 := by
  intro p hp
  have h : env7326.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7325_7326 : H12AffineEnvironment.transform 21 5277 env7325 = env7326 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5277 env7325 == env7326) = true)

theorem identity7326 : scanCanonicalize (H12AffineFastState.compose env7326 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 283047) := by decide +kernel

theorem selectedBound7326 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7327 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8,16384,32768,65536,4097,262144,1025,32768,4096,5277,17664,103444,129,5377,282761,16385,4096,105495,4116,283047,257,360837,4096,136]

theorem envBound7327 : H12AffineFastState.Bounded env7327 := by
  intro p hp
  have h : env7327.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7326_7327 : H12AffineEnvironment.transform 31 283047 env7326 = env7327 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 283047 env7326 == env7327) = true)

def env7328 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,4293121,129,4195092,283137,4216340,4096,106143,4195841,4294967296,257,4299277878,4096,136]

theorem envBound7328 : H12AffineFastState.Bounded env7328 := by
  intro p hp
  have h : env7328.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7323_7328 : H12AffineEnvironment.transform 23 4293121 env7323 = env7328 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 4293121 env7323 == env7328) = true)

def env7329 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,4292745,129,4194716,282761,4215964,4096,105495,4195465,4294967296,257,4299277502,4096,136]

theorem envBound7329 : H12AffineFastState.Bounded env7329 := by
  intro p hp
  have h : env7329.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7328_7329 : H12AffineEnvironment.transform 8 136 env7328 = env7329 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env7328 == env7329) = true)

theorem identity7329 : scanCanonicalize (H12AffineFastState.compose env7329 (packedSelected [6,25] rootPS)) = affineNative (2^(21+1) ^^^ 17565) := by decide +kernel

theorem selectedBound7329 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env7330 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,16384,32768,65536,4097,262144,1025,32768,4096,17565,17664,115732,129,17665,282761,4097,4096,105495,16404,4294967296,257,4295065635,4096,136]

theorem envBound7330 : H12AffineFastState.Bounded env7330 := by
  intro p hp
  have h : env7330.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7329_7330 : H12AffineEnvironment.transform 21 17565 env7329 = env7330 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 17565 env7329 == env7330) = true)

theorem identity7330 : scanCanonicalize (H12AffineFastState.compose env7330 (packedSelected [4,9,16] rootPS)) = affineNative (2^(13+1) ^^^ 4097) := by decide +kernel

theorem selectedBound7330 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env7331 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,4097,32768,65536,4097,262144,1025,32768,4096,5276,5377,103445,129,5376,262280,4097,4096,105495,4117,4294967296,257,4295065635,4096,136]

theorem envBound7331 : H12AffineFastState.Bounded env7331 := by
  intro p hp
  have h : env7331.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7330_7331 : H12AffineEnvironment.transform 13 4097 env7330 = env7331 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4097 env7330 == env7331) = true)

theorem identity7331 : scanCanonicalize (H12AffineFastState.compose env7331 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 69943) := by decide +kernel

theorem selectedBound7331 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7332 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,4097,32768,65536,4097,262144,1025,32768,4096,5276,5377,103445,129,5376,262280,4097,4096,105495,4117,69943,257,37140,4096,136]

theorem envBound7332 : H12AffineFastState.Bounded env7332 := by
  intro p hp
  have h : env7332.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7331_7332 : H12AffineEnvironment.transform 31 69943 env7331 = env7332 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 69943 env7331 == env7332) = true)

theorem identity7332 : scanCanonicalize (H12AffineFastState.compose env7332 (packedSelected [13,17] rootPS)) = affineNative (2^(14+1) ^^^ 4540) := by decide +kernel

theorem selectedBound7332 : packedSelected [13,17] rootPS < 2^1333 := by decide +kernel

def env7333 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,4097,4540,65536,4097,262144,1025,4540,4096,5276,5377,66985,129,5376,262280,4097,4096,69035,4117,69943,257,168,4096,136]

theorem envBound7333 : H12AffineFastState.Bounded env7333 := by
  intro p hp
  have h : env7333.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7332_7333 : H12AffineEnvironment.transform 14 4540 env7332 = env7333 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 4540 env7332 == env7333) = true)

theorem identity7333 : scanCanonicalize (H12AffineFastState.compose env7333 (packedSelected [3,5,15] rootPS)) = affineNative (2^(15+1) ^^^ 5395) := by decide +kernel

theorem selectedBound7333 : packedSelected [3,5,15] rootPS < 2^1333 := by decide +kernel

def env7334 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,4097,4540,5395,4097,262144,1025,4540,4096,5276,5377,4282,129,5376,262280,4097,4096,6328,4117,1060,257,168,4096,136]

theorem envBound7334 : H12AffineFastState.Bounded env7334 := by
  intro p hp
  have h : env7334.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7333_7334 : H12AffineEnvironment.transform 15 5395 env7333 = env7334 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5395 env7333 == env7334) = true)

theorem identity7334 : scanCanonicalize (H12AffineFastState.compose env7334 (packedSelected [0,7,20] rootPS)) = affineNative (2^(9+1) ^^^ 424) := by decide +kernel

theorem selectedBound7334 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env7335 : List Nat := [2,4,8,16,32,17,128,256,136,424,2048,4096,9,4097,4540,4283,4097,262144,425,4540,4096,4404,4265,4282,129,4264,262280,4097,4096,6328,4117,396,257,168,4096,136]

theorem envBound7335 : H12AffineFastState.Bounded env7335 := by
  intro p hp
  have h : env7335.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7334_7335 : H12AffineEnvironment.transform 9 424 env7334 = env7335 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 424 env7334 == env7335) = true)

theorem identity7335 : scanCanonicalize (H12AffineFastState.compose env7335 (packedSelected [5,8] rootPS)) = affineNative (2^(10+1) ^^^ 396) := by decide +kernel

theorem selectedBound7335 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env7336 : List Nat := [2,4,8,16,32,17,128,256,136,424,396,4096,9,4097,4540,4283,4097,262144,425,4540,4096,4404,4265,4282,129,4264,262280,4097,4096,4404,4117,396,257,168,4096,136]

theorem envBound7336 : H12AffineFastState.Bounded env7336 := by
  intro p hp
  have h : env7336.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7335_7336 : H12AffineEnvironment.transform 10 396 env7335 = env7336 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 396 env7335 == env7336) = true)

theorem identity7336 : scanCanonicalize (H12AffineFastState.compose env7336 (packedSelected [1,2,4,5,9,12] rootPS)) = affineNative (2^(17+1) ^^^ 48) := by decide +kernel

theorem selectedBound7336 : packedSelected [1,2,4,5,9,12] rootPS < 2^1333 := by decide +kernel

def env7337 : List Nat := [2,4,8,16,32,17,128,256,136,424,396,4096,9,4097,4540,4283,4097,48,425,4540,4096,4404,4265,4282,129,4264,184,4097,4096,4404,4117,396,257,168,4096,136]

theorem envBound7337 : H12AffineFastState.Bounded env7337 := by
  intro p hp
  have h : env7337.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7336_7337 : H12AffineEnvironment.transform 17 48 env7336 = env7337 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 48 env7336 == env7337) = true)

theorem identity7337 : scanCanonicalize (H12AffineFastState.compose env7337 (packedSelected [0,1,2,3,4,7,9] rootPS)) = affineNative (2^(11+1) ^^^ 185) := by decide +kernel

theorem selectedBound7337 : packedSelected [0,1,2,3,4,7,9] rootPS < 2^1333 := by decide +kernel

def env7338 : List Nat := [2,4,8,16,32,17,128,256,136,424,396,185,9,184,261,2,184,48,425,261,185,397,16,3,129,17,184,184,185,397,172,396,257,168,185,136]

theorem envBound7338 : H12AffineFastState.Bounded env7338 := by
  intro p hp
  have h : env7338.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7337_7338 : H12AffineEnvironment.transform 11 185 env7337 = env7338 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 185 env7337 == env7338) = true)

theorem identity7338 : scanCanonicalize (H12AffineFastState.compose env7338 (packedSelected [0,2] rootPS)) = affineNative (2^(7+1) ^^^ 6) := by decide +kernel

theorem selectedBound7338 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env7339 : List Nat := [2,4,8,16,32,17,128,6,136,174,138,185,9,184,3,2,184,48,175,3,185,139,16,3,129,17,184,184,185,139,172,138,7,168,185,136]

theorem envBound7339 : H12AffineFastState.Bounded env7339 := by
  intro p hp
  have h : env7339.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7338_7339 : H12AffineEnvironment.transform 7 6 env7338 = env7339 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 6 env7338 == env7339) = true)

theorem identity7339 : scanCanonicalize (H12AffineFastState.compose env7339 (packedSelected [1,3,5] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound7339 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env7340 : List Nat := [1,4,8,16,32,17,128,5,136,173,137,185,9,184,0,1,184,48,172,0,185,136,16,0,129,17,184,184,185,136,172,137,4,168,185,136]

theorem envBound7340 : H12AffineFastState.Bounded env7340 := by
  intro p hp
  have h : env7340.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7339_7340 : H12AffineEnvironment.transform 0 1 env7339 = env7340 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env7339 == env7340) = true)

def env7341 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,4292744,129,4194717,282760,4215965,4096,105494,4195464,4294967296,257,4299277503,4096,136]

theorem envBound7341 : H12AffineFastState.Bounded env7341 := by
  intro p hp
  have h : env7341.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7328_7341 : H12AffineEnvironment.transform 8 137 env7328 = env7341 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env7328 == env7341) = true)

theorem identity7341 : scanCanonicalize (H12AffineFastState.compose env7341 (packedSelected [3,4,9,10,16,24,26] rootPS)) = affineNative (2^(21+1) ^^^ 5276) := by decide +kernel

theorem selectedBound7341 : packedSelected [3,4,9,10,16,24,26] rootPS < 2^1333 := by decide +kernel

def env7342 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8,16384,32768,65536,4097,262144,1025,32768,4096,5276,17664,103444,129,5377,282760,16385,4096,105494,4116,4294967296,257,4295086115,4096,136]

theorem envBound7342 : H12AffineFastState.Bounded env7342 := by
  intro p hp
  have h : env7342.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7341_7342 : H12AffineEnvironment.transform 21 5276 env7341 = env7342 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5276 env7341 == env7342) = true)

theorem identity7342 : scanCanonicalize (H12AffineFastState.compose env7342 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 312755) := by decide +kernel

theorem selectedBound7342 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7343 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8,16384,32768,65536,4097,262144,1025,32768,4096,5276,17664,103444,129,5377,282760,16385,4096,105494,4116,312755,257,333200,4096,136]

theorem envBound7343 : H12AffineFastState.Bounded env7343 := by
  intro p hp
  have h : env7343.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7342_7343 : H12AffineEnvironment.transform 31 312755 env7342 = env7343 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 312755 env7342 == env7343) = true)

theorem identity7343 : scanCanonicalize (H12AffineFastState.compose env7343 (packedSelected [13,21] rootPS)) = affineNative (2^(13+1) ^^^ 4097) := by decide +kernel

theorem selectedBound7343 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env7344 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8,4097,32768,65536,4097,262144,1025,32768,4096,5276,5377,103444,129,5377,262281,4096,4096,105494,4116,300466,257,333200,4096,136]

theorem envBound7344 : H12AffineFastState.Bounded env7344 := by
  intro p hp
  have h : env7344.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7343_7344 : H12AffineEnvironment.transform 13 4097 env7343 = env7344 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4097 env7343 == env7344) = true)

theorem identity7344 : scanCanonicalize (H12AffineFastState.compose env7344 (packedSelected [4,9,16] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound7344 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env7345 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1297,32768,65536,1297,262144,1025,32768,1296,396,17,98564,129,17,262281,1296,1296,100614,1284,295074,257,327808,1296,136]

end H12GlobalChart2
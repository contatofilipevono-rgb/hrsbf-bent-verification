import H12GlobalChart2Data004

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

def env1194 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,1296,32768,65536,4097,262144,1024,32768,4096,4194304,16,103444,129,5377,4456708,1296,4097,4294794,4116,4294967296,256,4299260335,4097,137]

theorem envBound1194 : H12AffineFastState.Bounded env1194 := by
  intro p hp
  have h : env1194.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1193_1194 : H12AffineEnvironment.transform 23 103444 env1193 = env1194 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 103444 env1193 == env1194) = true)

theorem identity1194 : scanCanonicalize (H12AffineFastState.compose env1194 (packedSelected [5,8,17,21] rootPS)) = affineNative (2^(14+1) ^^^ 261) := by decide +kernel

theorem selectedBound1194 : packedSelected [5,8,17,21] rootPS < 2^1333 := by decide +kernel

def env1195 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,1296,261,65536,4097,262144,1024,261,4096,4194304,16,70929,129,5377,4456708,1296,4097,4262287,4116,4294967296,256,4299227306,4097,137]

theorem envBound1195 : H12AffineFastState.Bounded env1195 := by
  intro p hp
  have h : env1195.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1194_1195 : H12AffineEnvironment.transform 14 261 env1194 = env1195 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 261 env1194 == env1195) = true)

theorem identity1195 : scanCanonicalize (H12AffineFastState.compose env1195 (packedSelected [5,6,8,10,12,13] rootPS)) = affineNative (2^(31+1) ^^^ 4201503) := by decide +kernel

theorem selectedBound1195 : packedSelected [5,6,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env1196 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,1296,261,65536,4097,262144,1024,261,4096,4194304,16,70929,129,5377,4456708,1296,4097,4262287,4116,4201503,256,72885,4097,137]

theorem envBound1196 : H12AffineFastState.Bounded env1196 := by
  intro p hp
  have h : env1196.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1195_1196 : H12AffineEnvironment.transform 31 4201503 env1195 = env1196 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4201503 env1195 == env1196) = true)

theorem identity1196 : scanCanonicalize (H12AffineFastState.compose env1196 (packedSelected [10,12,17] rootPS)) = affineNative (2^(17+1) ^^^ 7221) := by decide +kernel

theorem selectedBound1196 : packedSelected [10,12,17] rootPS < 2^1333 := by decide +kernel

def env1197 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,1296,261,65536,4097,7221,1024,261,4096,4194304,16,70929,129,5377,4201777,1296,4097,4262287,4116,4201503,256,72885,4097,137]

theorem envBound1197 : H12AffineFastState.Bounded env1197 := by
  intro p hp
  have h : env1197.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1196_1197 : H12AffineEnvironment.transform 17 7221 env1196 = env1197 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 7221 env1196 == env1197) = true)

theorem identity1197 : scanCanonicalize (H12AffineFastState.compose env1197 (packedSelected [5,8] rootPS)) = affineNative (2^(15+1) ^^^ 138) := by decide +kernel

theorem selectedBound1197 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env1198 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,1296,261,138,4097,7221,1024,261,4096,4194304,16,5531,129,5377,4201777,1296,4097,4196613,4116,4201503,256,7231,4097,137]

theorem envBound1198 : H12AffineFastState.Bounded env1198 := by
  intro p hp
  have h : env1198.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1197_1198 : H12AffineEnvironment.transform 15 138 env1197 = env1198 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 138 env1197 == env1198) = true)

def env1199 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,1296,261,138,4097,7221,1024,261,4096,5408,16,5531,129,5377,2065,1296,4097,7205,4116,2367,256,7231,4097,137]

theorem envBound1199 : H12AffineFastState.Bounded env1199 := by
  intro p hp
  have h : env1199.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1198_1199 : H12AffineEnvironment.transform 21 5408 env1198 = env1199 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5408 env1198 == env1199) = true)

theorem identity1199 : scanCanonicalize (H12AffineFastState.compose env1199 (packedSelected [1] rootPS)) = affineNative (2^(10+1) ^^^ 178) := by decide +kernel

theorem selectedBound1199 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1200 : List Nat := [2,4,8,16,32,17,128,256,136,1024,178,4096,8,1296,261,138,4097,5255,1024,261,4096,5408,16,5531,129,5377,163,1296,4097,5271,4116,397,256,5261,4097,137]

theorem envBound1200 : H12AffineFastState.Bounded env1200 := by
  intro p hp
  have h : env1200.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1199_1200 : H12AffineEnvironment.transform 10 178 env1199 = env1200 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 178 env1199 == env1200) = true)

theorem identity1200 : scanCanonicalize (H12AffineFastState.compose env1200 (packedSelected [5] rootPS)) = affineNative (2^(11+1) ^^^ 1038) := by decide +kernel

theorem selectedBound1200 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1201 : List Nat := [2,4,8,16,32,17,128,256,136,1024,178,1038,8,1296,261,138,1039,137,1024,261,1038,302,16,405,129,271,163,1296,1039,153,1050,397,256,131,1039,137]

theorem envBound1201 : H12AffineFastState.Bounded env1201 := by
  intro p hp
  have h : env1201.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1200_1201 : H12AffineEnvironment.transform 11 1038 env1200 = env1201 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1038 env1200 == env1201) = true)

def env1202 : List Nat := [2,4,8,16,0,17,128,256,136,1024,146,1038,8,1296,261,138,1039,137,1024,261,1038,270,16,405,129,271,131,1296,1039,153,1050,397,256,131,1039,137]

theorem envBound1202 : H12AffineFastState.Bounded env1202 := by
  intro p hp
  have h : env1202.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1201_1202 : H12AffineEnvironment.transform 4 0 env1201 = env1202 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1201 == env1202) = true)

theorem identity1202 : scanCanonicalize (H12AffineFastState.compose env1202 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound1202 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1203 : List Nat := [2,4,8,10,0,11,128,256,136,1024,136,1038,8,1290,261,138,1039,137,1024,261,1038,270,10,399,129,271,131,1290,1039,131,1024,397,256,131,1039,137]

theorem envBound1203 : H12AffineFastState.Bounded env1203 := by
  intro p hp
  have h : env1203.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1202_1203 : H12AffineEnvironment.transform 3 10 env1202 = env1203 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env1202 == env1203) = true)

theorem identity1203 : scanCanonicalize (H12AffineFastState.compose env1203 (packedSelected [0,7] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound1203 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env1204 : List Nat := [2,4,8,10,0,11,9,256,1,1024,1,1038,8,1290,261,3,1039,0,1024,261,1038,270,10,262,8,271,10,1290,1039,10,1024,260,256,10,1039,0]

theorem envBound1204 : H12AffineFastState.Bounded env1204 := by
  intro p hp
  have h : env1204.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1203_1204 : H12AffineEnvironment.transform 6 9 env1203 = env1204 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env1203 == env1204) = true)

theorem identity1204 : scanCanonicalize (H12AffineFastState.compose env1204 (packedSelected [4] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1204 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env1205 : List Nat := [2,4,8,10,0,11,9,5,1,1024,1,1038,8,1039,0,3,1039,0,1024,0,1038,11,10,3,8,10,10,1039,1039,10,1024,1,5,10,1039,0]

theorem envBound1205 : H12AffineFastState.Bounded env1205 := by
  intro p hp
  have h : env1205.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1204_1205 : H12AffineEnvironment.transform 7 5 env1204 = env1205 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1204 == env1205) = true)

theorem identity1205 : scanCanonicalize (H12AffineFastState.compose env1205 (packedSelected [6] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound1205 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1206 : List Nat := [2,4,3,1,0,0,2,5,1,1024,1,1029,3,1028,0,3,1028,0,1024,0,1029,0,1,3,3,1,1,1028,1028,1,1024,1,5,1,1028,0]

theorem envBound1206 : H12AffineFastState.Bounded env1206 := by
  intro p hp
  have h : env1206.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1205_1206 : H12AffineEnvironment.transform 2 3 env1205 = env1206 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env1205 == env1206) = true)

def leafEnv1206 : List Nat := [2,4,3,1,0,0,2,5,1,1024,1,1029,3,1028,0,3,1028,0,1024,0,1029,0,1,3,1024,3,1,1,1,1028,1028,1,1024,1,5,1,4,3,1028,0,0,1028,1]

def active1206 : List Nat := [0,1,9]

def tree1206 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1206 : H12WitnessSearch.Good tree1206 := H12GlobalWitnessIndex.good

theorem leafIdentity1206 : H12AffineFastState.composeSystem env1206 rootObs = leafEnv1206 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1206 rootObs == leafEnv1206) = true)

theorem terminalChecked1206 : H12PackedTerminal.terminalCheckFast leafEnv1206 active1206 tree1206 = true := by decide +kernel

def env1207 : List Nat := [2,4,8,16,1,17,128,256,136,1024,147,1038,8,1296,261,138,1039,137,1024,261,1038,271,16,405,129,271,130,1296,1039,153,1050,397,256,131,1039,137]

theorem envBound1207 : H12AffineFastState.Bounded env1207 := by
  intro p hp
  have h : env1207.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1201_1207 : H12AffineEnvironment.transform 4 1 env1201 = env1207 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env1201 == env1207) = true)

theorem identity1207 : scanCanonicalize (H12AffineFastState.compose env1207 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1207 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1208 : List Nat := [2,4,8,16,1,17,128,5,136,1024,147,1038,8,1045,0,138,1039,137,1024,0,1038,10,16,144,129,10,130,1045,1039,153,1050,136,5,131,1039,137]

theorem envBound1208 : H12AffineFastState.Bounded env1208 := by
  intro p hp
  have h : env1208.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1207_1208 : H12AffineEnvironment.transform 7 5 env1207 = env1208 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1207 == env1208) = true)

theorem identity1208 : scanCanonicalize (H12AffineFastState.compose env1208 (packedSelected [0,2,6] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound1208 : packedSelected [0,2,6] rootPS < 2^1333 := by decide +kernel

def env1209 : List Nat := [2,4,3,16,1,17,128,5,131,1024,147,1029,3,1045,0,129,1028,130,1024,0,1029,1,16,144,129,1,130,1045,1028,146,1041,131,5,131,1028,130]

theorem envBound1209 : H12AffineFastState.Bounded env1209 := by
  intro p hp
  have h : env1209.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1208_1209 : H12AffineEnvironment.transform 2 3 env1208 = env1209 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env1208 == env1209) = true)

theorem identity1209 : scanCanonicalize (H12AffineFastState.compose env1209 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1209 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1210 : List Nat := [2,4,3,0,1,1,128,5,131,1024,131,1029,3,1029,0,129,1028,130,1024,0,1029,1,0,128,129,1,130,1029,1028,130,1025,131,5,131,1028,130]

theorem envBound1210 : H12AffineFastState.Bounded env1210 := by
  intro p hp
  have h : env1210.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1209_1210 : H12AffineEnvironment.transform 3 0 env1209 = env1210 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1209 == env1210) = true)

theorem identity1210 : scanCanonicalize (H12AffineFastState.compose env1210 (packedSelected [4] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound1210 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env1211 : List Nat := [2,4,3,0,1,1,2,5,1,1024,1,1029,3,1029,0,3,1028,0,1024,0,1029,1,0,2,3,1,0,1029,1028,0,1025,1,5,1,1028,0]

theorem envBound1211 : H12AffineFastState.Bounded env1211 := by
  intro p hp
  have h : env1211.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1210_1211 : H12AffineEnvironment.transform 6 2 env1210 = env1211 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env1210 == env1211) = true)

def env1212 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,1296,261,138,4097,7221,1024,261,4096,5409,16,5531,129,5377,2064,1296,4097,7204,4116,2366,256,7231,4097,137]

theorem envBound1212 : H12AffineFastState.Bounded env1212 := by
  intro p hp
  have h : env1212.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1198_1212 : H12AffineEnvironment.transform 21 5409 env1198 = env1212 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5409 env1198 == env1212) = true)

theorem identity1212 : scanCanonicalize (H12AffineFastState.compose env1212 (packedSelected [1] rootPS)) = affineNative (2^(11+1) ^^^ 3490) := by decide +kernel

theorem selectedBound1212 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1213 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,3490,8,1296,261,138,3491,407,1024,261,3490,2179,16,2105,129,2211,2064,1296,3491,390,3510,2366,256,413,3491,137]

theorem envBound1213 : H12AffineFastState.Bounded env1213 := by
  intro p hp
  have h : env1213.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1212_1213 : H12AffineEnvironment.transform 11 3490 env1212 = env1213 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3490 env1212 == env1213) = true)

theorem identity1213 : scanCanonicalize (H12AffineFastState.compose env1213 (packedSelected [5] rootPS)) = affineNative (2^(10+1) ^^^ 429) := by decide +kernel

theorem selectedBound1213 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1214 : List Nat := [2,4,8,16,32,17,128,256,136,1024,429,1039,8,1296,261,138,1038,407,1024,261,1039,302,16,404,129,270,445,1296,1038,390,1051,147,256,413,1038,137]

theorem envBound1214 : H12AffineFastState.Bounded env1214 := by
  intro p hp
  have h : env1214.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1213_1214 : H12AffineEnvironment.transform 10 429 env1213 = env1214 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 429 env1213 == env1214) = true)

def env1215 : List Nat := [2,4,8,16,0,17,128,256,136,1024,397,1039,8,1296,261,138,1038,407,1024,261,1039,270,16,404,129,270,413,1296,1038,390,1051,147,256,413,1038,137]

theorem envBound1215 : H12AffineFastState.Bounded env1215 := by
  intro p hp
  have h : env1215.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1214_1215 : H12AffineEnvironment.transform 4 0 env1214 = env1215 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1214 == env1215) = true)

theorem identity1215 : scanCanonicalize (H12AffineFastState.compose env1215 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound1215 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1216 : List Nat := [2,4,8,11,0,10,128,256,136,1024,397,1039,8,1291,261,138,1038,396,1024,261,1039,270,11,399,129,270,390,1291,1038,390,1024,136,256,390,1038,137]

theorem envBound1216 : H12AffineFastState.Bounded env1216 := by
  intro p hp
  have h : env1216.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1215_1216 : H12AffineEnvironment.transform 3 11 env1215 = env1216 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env1215 == env1216) = true)

theorem identity1216 : scanCanonicalize (H12AffineFastState.compose env1216 (packedSelected [0,2] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound1216 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env1217 : List Nat := [2,4,8,11,0,10,128,4,136,1024,137,1039,8,1039,1,138,1038,136,1024,1,1039,10,11,139,129,10,130,1039,1038,130,1024,136,4,130,1038,137]

theorem envBound1217 : H12AffineFastState.Bounded env1217 := by
  intro p hp
  have h : env1217.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1216_1217 : H12AffineEnvironment.transform 7 4 env1216 = env1217 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env1216 == env1217) = true)

theorem identity1217 : scanCanonicalize (H12AffineFastState.compose env1217 (packedSelected [0,4] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound1217 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env1218 : List Nat := [2,4,8,11,0,10,9,4,1,1024,0,1039,8,1039,1,3,1038,1,1024,1,1039,10,11,2,8,10,11,1039,1038,11,1024,1,4,11,1038,0]

theorem envBound1218 : H12AffineFastState.Bounded env1218 := by
  intro p hp
  have h : env1218.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1217_1218 : H12AffineEnvironment.transform 6 9 env1217 = env1218 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env1217 == env1218) = true)

theorem identity1218 : scanCanonicalize (H12AffineFastState.compose env1218 (packedSelected [0] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1218 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1219 : List Nat := [2,4,2,1,0,0,3,4,1,1024,0,1029,2,1029,1,3,1028,1,1024,1,1029,0,1,2,2,0,1,1029,1028,1,1024,1,4,1,1028,0]

theorem envBound1219 : H12AffineFastState.Bounded env1219 := by
  intro p hp
  have h : env1219.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1218_1219 : H12AffineEnvironment.transform 2 2 env1218 = env1219 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1218 == env1219) = true)

def env1220 : List Nat := [2,4,8,16,1,17,128,256,136,1024,396,1039,8,1296,261,138,1038,407,1024,261,1039,271,16,404,129,270,412,1296,1038,390,1051,147,256,413,1038,137]

theorem envBound1220 : H12AffineFastState.Bounded env1220 := by
  intro p hp
  have h : env1220.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1214_1220 : H12AffineEnvironment.transform 4 1 env1214 = env1220 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env1214 == env1220) = true)

theorem identity1220 : scanCanonicalize (H12AffineFastState.compose env1220 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1220 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1221 : List Nat := [2,4,8,16,1,17,128,5,136,1024,137,1039,8,1045,0,138,1038,146,1024,0,1039,10,16,145,129,11,153,1045,1038,131,1051,147,5,152,1038,137]

theorem envBound1221 : H12AffineFastState.Bounded env1221 := by
  intro p hp
  have h : env1221.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1220_1221 : H12AffineEnvironment.transform 7 5 env1220 = env1221 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1220 == env1221) = true)

theorem identity1221 : scanCanonicalize (H12AffineFastState.compose env1221 (packedSelected [0,2,6] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound1221 : packedSelected [0,2,6] rootPS < 2^1333 := by decide +kernel

def env1222 : List Nat := [2,4,8,1,1,0,128,5,136,1024,137,1039,8,1028,0,138,1038,131,1024,0,1039,10,1,128,129,11,136,1028,1038,131,1034,130,5,137,1038,137]

theorem envBound1222 : H12AffineFastState.Bounded env1222 := by
  intro p hp
  have h : env1222.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1221_1222 : H12AffineEnvironment.transform 3 1 env1221 = env1222 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env1221 == env1222) = true)

theorem identity1222 : scanCanonicalize (H12AffineFastState.compose env1222 (packedSelected [4] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound1222 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env1223 : List Nat := [2,4,8,1,1,0,3,5,11,1024,10,1039,8,1028,0,9,1038,0,1024,0,1039,10,1,3,2,11,11,1028,1038,0,1034,1,5,10,1038,10]

theorem envBound1223 : H12AffineFastState.Bounded env1223 := by
  intro p hp
  have h : env1223.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1222_1223 : H12AffineEnvironment.transform 6 3 env1222 = env1223 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env1222 == env1223) = true)

theorem identity1223 : scanCanonicalize (H12AffineFastState.compose env1223 (packedSelected [7] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1223 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1224 : List Nat := [2,4,2,1,1,0,3,5,1,1024,0,1029,2,1028,0,3,1028,0,1024,0,1029,0,1,3,2,1,1,1028,1028,0,1024,1,5,0,1028,0]

theorem envBound1224 : H12AffineFastState.Bounded env1224 := by
  intro p hp
  have h : env1224.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1223_1224 : H12AffineEnvironment.transform 2 2 env1223 = env1224 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1223 == env1224) = true)

def leafEnv1224 : List Nat := [2,4,2,1,1,0,3,5,1,1024,0,1029,2,1028,0,3,1028,0,1024,0,1029,0,1,3,1024,2,1,1,1,1028,1028,0,1024,1,5,0,4,3,1028,0,0,1028,1]

def active1224 : List Nat := [0,1,9]

def tree1224 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1224 : H12WitnessSearch.Good tree1224 := H12GlobalWitnessIndex.good

theorem leafIdentity1224 : H12AffineFastState.composeSystem env1224 rootObs = leafEnv1224 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1224 rootObs == leafEnv1224) = true)

theorem terminalChecked1224 : H12PackedTerminal.terminalCheckFast leafEnv1224 active1224 tree1224 = true := by decide +kernel

def env1225 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,1297,32768,65536,4097,262144,1024,32768,4096,4194304,17,16777216,33554432,16875797,21337361,16879877,4097,20978846,16876544,4294967296,256,4332814638,4097,33554440]

theorem envBound1225 : H12AffineFastState.Bounded env1225 := by
  intro p hp
  have h : env1225.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1191_1225 : H12AffineEnvironment.transform 8 137 env1191 = env1225 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1191 == env1225) = true)

theorem identity1225 : scanCanonicalize (H12AffineFastState.compose env1225 (packedSelected [3,6,10,24,25,26] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound1225 : packedSelected [3,6,10,24,25,26] rootPS < 2^1333 := by decide +kernel

def env1226 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,1297,32768,65536,1296,262144,1024,32768,1297,4194304,17,16777216,33554432,16875797,21331968,16876564,1296,20973967,16876544,4294967296,256,4332814638,1296,33554440]

theorem envBound1226 : H12AffineFastState.Bounded env1226 := by
  intro p hp
  have h : env1226.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1225_1226 : H12AffineEnvironment.transform 11 1297 env1225 = env1226 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env1225 == env1226) = true)

theorem identity1226 : scanCanonicalize (H12AffineFastState.compose env1226 (packedSelected [1,3,5,6,8,10,19,25] rootPS)) = affineNative (2^(24+1) ^^^ 16875909) := by decide +kernel

theorem selectedBound1226 : packedSelected [1,3,5,6,8,10,19,25] rootPS < 2^1333 := by decide +kernel

def env1227 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,1297,32768,65536,1296,262144,1024,32768,1297,4194304,17,16777216,16875909,16875797,21331968,16876564,1296,20973967,16876544,4294967296,256,4315938987,1296,16875917]

theorem envBound1227 : H12AffineFastState.Bounded env1227 := by
  intro p hp
  have h : env1227.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1226_1227 : H12AffineEnvironment.transform 24 16875909 env1226 = env1227 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 16875909 env1226 == env1227) = true)

theorem identity1227 : scanCanonicalize (H12AffineFastState.compose env1227 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(23+1) ^^^ 98565) := by decide +kernel

theorem selectedBound1227 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env1228 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,1297,32768,65536,1296,262144,1024,32768,1297,4194304,17,98565,128,16,4456709,1297,1296,4294794,1285,4294967296,256,4299260334,1296,136]

theorem envBound1228 : H12AffineFastState.Bounded env1228 := by
  intro p hp
  have h : env1228.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1227_1228 : H12AffineEnvironment.transform 23 98565 env1227 = env1228 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98565 env1227 == env1228) = true)

theorem identity1228 : scanCanonicalize (H12AffineFastState.compose env1228 (packedSelected [1,3,5] rootPS)) = affineNative (2^(17+1) ^^^ 34849) := by decide +kernel

theorem selectedBound1228 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1229 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,1297,32768,65536,1296,34849,1024,32768,1297,4194304,17,98565,128,16,4229412,1297,1296,4294794,1285,4294967296,256,4299260334,1296,136]

theorem envBound1229 : H12AffineFastState.Bounded env1229 := by
  intro p hp
  have h : env1229.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1228_1229 : H12AffineEnvironment.transform 17 34849 env1228 = env1229 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 34849 env1228 == env1229) = true)

theorem identity1229 : scanCanonicalize (H12AffineFastState.compose env1229 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 100798) := by decide +kernel

theorem selectedBound1229 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1230 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,1297,32768,65536,1296,34849,1024,32768,1297,4194304,17,98565,128,16,4229412,1297,1296,4294794,1285,100798,256,4196368,1296,136]

theorem envBound1230 : H12AffineFastState.Bounded env1230 := by
  intro p hp
  have h : env1230.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1229_1230 : H12AffineEnvironment.transform 31 100798 env1229 = env1230 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 100798 env1229 == env1230) = true)

theorem identity1230 : scanCanonicalize (H12AffineFastState.compose env1230 (packedSelected [3,8] rootPS)) = affineNative (2^(15+1) ^^^ 33166) := by decide +kernel

theorem selectedBound1230 : packedSelected [3,8] rootPS < 2^1333 := by decide +kernel

def env1231 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,1297,32768,33166,1296,34849,1024,32768,1297,4194304,17,139,128,16,4229412,1297,1296,4196612,1285,2096,256,4196368,1296,136]

theorem envBound1231 : H12AffineFastState.Bounded env1231 := by
  intro p hp
  have h : env1231.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1230_1231 : H12AffineEnvironment.transform 15 33166 env1230 = env1231 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33166 env1230 == env1231) = true)

theorem identity1231 : scanCanonicalize (H12AffineFastState.compose env1231 (packedSelected [3] rootPS)) = affineNative (2^(21+1) ^^^ 260) := by decide +kernel

theorem selectedBound1231 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1232 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,1297,32768,33166,1296,34849,1024,32768,1297,260,17,139,128,16,34848,1297,1296,2048,1285,2096,256,2324,1296,136]

theorem envBound1232 : H12AffineFastState.Bounded env1232 := by
  intro p hp
  have h : env1232.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1231_1232 : H12AffineEnvironment.transform 21 260 env1231 = env1232 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 260 env1231 == env1232) = true)

theorem identity1232 : scanCanonicalize (H12AffineFastState.compose env1232 (packedSelected [0,7] rootPS)) = affineNative (2^(14+1) ^^^ 2340) := by decide +kernel

theorem selectedBound1232 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env1233 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,1297,2340,2218,1296,261,1024,2340,1297,260,17,139,128,16,260,1297,1296,2048,1285,2096,256,2324,1296,136]

theorem envBound1233 : H12AffineFastState.Bounded env1233 := by
  intro p hp
  have h : env1233.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1232_1233 : H12AffineEnvironment.transform 14 2340 env1232 = env1233 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2340 env1232 == env1233) = true)

def env1234 : List Nat := [2,4,8,16,32,17,128,256,137,1024,32,1297,9,1297,260,138,1296,261,1024,260,1297,260,17,139,128,16,260,1297,1296,32,1285,16,256,308,1296,136]

theorem envBound1234 : H12AffineFastState.Bounded env1234 := by
  intro p hp
  have h : env1234.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1233_1234 : H12AffineEnvironment.transform 10 32 env1233 = env1234 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 32 env1233 == env1234) = true)

theorem identity1234 : scanCanonicalize (H12AffineFastState.compose env1234 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 50) := by decide +kernel

theorem selectedBound1234 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1235 : List Nat := [2,4,8,16,32,17,50,256,59,1024,32,1297,9,1297,260,56,1296,261,1024,260,1297,260,17,57,50,16,260,1297,1296,32,1285,16,256,308,1296,58]

theorem envBound1235 : H12AffineFastState.Bounded env1235 := by
  intro p hp
  have h : env1235.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1234_1235 : H12AffineEnvironment.transform 6 50 env1234 = env1235 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 50 env1234 == env1235) = true)

def env1236 : List Nat := [2,4,8,16,16,17,2,256,11,1024,16,1297,9,1297,260,8,1296,261,1024,260,1297,260,17,9,2,16,260,1297,1296,16,1285,16,256,260,1296,10]

theorem envBound1236 : H12AffineFastState.Bounded env1236 := by
  intro p hp
  have h : env1236.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1235_1236 : H12AffineEnvironment.transform 4 16 env1235 = env1236 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env1235 == env1236) = true)

theorem identity1236 : scanCanonicalize (H12AffineFastState.compose env1236 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound1236 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1237 : List Nat := [2,4,8,1,1,0,2,256,11,1024,1,1280,9,1280,260,8,1281,261,1024,260,1280,260,0,9,2,1,260,1280,1281,1,1285,1,256,260,1281,10]

theorem envBound1237 : H12AffineFastState.Bounded env1237 := by
  intro p hp
  have h : env1237.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1236_1237 : H12AffineEnvironment.transform 3 1 env1236 = env1237 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env1236 == env1237) = true)

def leafEnv1237 : List Nat := [2,4,8,1,1,0,2,256,11,1024,1,1280,9,1280,260,8,1281,261,1024,260,1280,260,0,9,1285,2,1,1,260,1280,1281,1,1285,1,256,260,4,2,1281,10,0,1281,1]

def active1237 : List Nat := [0,1,2,7,9]

def tree1237 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1237 : H12WitnessSearch.Good tree1237 := H12GlobalWitnessIndex.good

theorem leafIdentity1237 : H12AffineFastState.composeSystem env1237 rootObs = leafEnv1237 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1237 rootObs == leafEnv1237) = true)

theorem terminalChecked1237 : H12PackedTerminal.terminalCheckFast leafEnv1237 active1237 tree1237 = true := by decide +kernel

def env1238 : List Nat := [2,4,8,16,17,17,3,256,10,1024,17,1297,9,1297,260,9,1296,261,1024,260,1297,260,17,8,3,16,260,1297,1296,17,1285,16,256,261,1296,11]

theorem envBound1238 : H12AffineFastState.Bounded env1238 := by
  intro p hp
  have h : env1238.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1235_1238 : H12AffineEnvironment.transform 4 17 env1235 = env1238 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env1235 == env1238) = true)

theorem identity1238 : scanCanonicalize (H12AffineFastState.compose env1238 (packedSelected [2] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound1238 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1239 : List Nat := [2,4,8,16,17,17,3,4,10,1024,17,1045,9,1045,0,9,1044,1,1024,0,1045,0,17,8,3,16,0,1045,1044,17,1025,16,4,1,1044,11]

theorem envBound1239 : H12AffineFastState.Bounded env1239 := by
  intro p hp
  have h : env1239.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1238_1239 : H12AffineEnvironment.transform 7 4 env1238 = env1239 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env1238 == env1239) = true)

def leafEnv1239 : List Nat := [2,4,8,16,17,17,3,4,10,1024,17,1045,9,1045,0,9,1044,1,1024,0,1045,0,17,8,1025,3,1,16,0,1045,1044,17,1025,16,4,1,4,2,1044,11,0,1044,1]

def active1239 : List Nat := [0,1,2,3,9]

def tree1239 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1239 : H12WitnessSearch.Good tree1239 := H12GlobalWitnessIndex.good

theorem leafIdentity1239 : H12AffineFastState.composeSystem env1239 rootObs = leafEnv1239 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1239 rootObs == leafEnv1239) = true)

theorem terminalChecked1239 : H12PackedTerminal.terminalCheckFast leafEnv1239 active1239 tree1239 = true := by decide +kernel

def env1240 : List Nat := [2,4,8,16,32,17,128,256,137,1024,33,1297,9,1297,261,139,1296,261,1024,261,1297,260,17,139,128,16,260,1297,1296,33,1285,17,256,309,1296,136]

theorem envBound1240 : H12AffineFastState.Bounded env1240 := by
  intro p hp
  have h : env1240.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1233_1240 : H12AffineEnvironment.transform 10 33 env1233 = env1240 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 33 env1233 == env1240) = true)

theorem identity1240 : scanCanonicalize (H12AffineFastState.compose env1240 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 27) := by decide +kernel

theorem selectedBound1240 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1241 : List Nat := [2,4,8,16,27,17,128,256,137,1024,26,1297,9,1297,261,139,1296,261,1024,261,1297,260,17,139,128,16,260,1297,1296,26,1285,17,256,270,1296,136]

theorem envBound1241 : H12AffineFastState.Bounded env1241 := by
  intro p hp
  have h : env1241.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1240_1241 : H12AffineEnvironment.transform 4 27 env1240 = env1241 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 27 env1240 == env1241) = true)

def env1242 : List Nat := [2,4,8,16,27,17,128,20,137,1024,26,1029,9,1029,17,139,1028,17,1024,17,1029,16,17,139,128,16,16,1029,1028,26,1041,17,20,26,1028,136]

theorem envBound1242 : H12AffineFastState.Bounded env1242 := by
  intro p hp
  have h : env1242.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1241_1242 : H12AffineEnvironment.transform 7 20 env1241 = env1242 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 20 env1241 == env1242) = true)

theorem identity1242 : scanCanonicalize (H12AffineFastState.compose env1242 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1242 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1243 : List Nat := [2,4,8,0,11,1,128,4,137,1024,10,1029,9,1029,1,139,1028,1,1024,1,1029,0,1,139,128,0,0,1029,1028,10,1025,1,4,10,1028,136]

theorem envBound1243 : H12AffineFastState.Bounded env1243 := by
  intro p hp
  have h : env1243.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1242_1243 : H12AffineEnvironment.transform 3 0 env1242 = env1243 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1242 == env1243) = true)

def leafEnv1243 : List Nat := [2,4,8,0,11,1,128,4,137,1024,10,1029,9,1029,1,139,1028,1,1024,1,1029,0,1,139,1025,128,1,0,0,1029,1028,10,1025,1,4,10,4,3,1028,136,0,1028,1]

def active1243 : List Nat := [0,1,2,6,9]

def tree1243 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1243 : H12WitnessSearch.Good tree1243 := H12GlobalWitnessIndex.good

theorem leafIdentity1243 : H12AffineFastState.composeSystem env1243 rootObs = leafEnv1243 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1243 rootObs == leafEnv1243) = true)

theorem terminalChecked1243 : H12PackedTerminal.terminalCheckFast leafEnv1243 active1243 tree1243 = true := by decide +kernel

def env1244 : List Nat := [2,4,8,16,27,17,128,21,137,1024,26,1028,9,1028,16,139,1029,16,1024,16,1028,17,17,139,128,16,17,1028,1029,26,1040,17,21,27,1029,136]

theorem envBound1244 : H12AffineFastState.Bounded env1244 := by
  intro p hp
  have h : env1244.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1241_1244 : H12AffineEnvironment.transform 7 21 env1241 = env1244 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 21 env1241 == env1244) = true)

theorem identity1244 : scanCanonicalize (H12AffineFastState.compose env1244 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound1244 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1245 : List Nat := [2,4,8,10,1,11,128,15,137,1024,0,1028,9,1028,10,139,1029,10,1024,10,1028,11,11,139,128,10,11,1028,1029,0,1034,11,15,1,1029,136]

theorem envBound1245 : H12AffineFastState.Bounded env1245 := by
  intro p hp
  have h : env1245.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1244_1245 : H12AffineEnvironment.transform 3 10 env1244 = env1245 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env1244 == env1245) = true)

def leafEnv1245 : List Nat := [2,4,8,10,1,11,128,15,137,1024,0,1028,9,1028,10,139,1029,10,1024,10,1028,11,11,139,1034,128,1,10,11,1028,1029,0,1034,11,15,1,4,3,1029,136,0,1029,1]

def active1245 : List Nat := [0,1,2,6,9]

def tree1245 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1245 : H12WitnessSearch.Good tree1245 := H12GlobalWitnessIndex.good

theorem leafIdentity1245 : H12AffineFastState.composeSystem env1245 rootObs = leafEnv1245 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1245 rootObs == leafEnv1245) = true)

theorem terminalChecked1245 : H12PackedTerminal.terminalCheckFast leafEnv1245 active1245 tree1245 = true := by decide +kernel

def env1246 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,16777216,33554432,17010964,21352448,17024021,131072,21105823,16876544,4294967296,256,4332967606,131072,33554441]

theorem envBound1246 : H12AffineFastState.Bounded env1246 := by
  intro p hp
  have h : env1246.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1136_1246 : H12AffineEnvironment.transform 12 641 env1136 = env1246 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 641 env1136 == env1246) = true)

def env1247 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,16777216,33554432,16875796,21352448,16897045,4096,20978847,16876544,4294967296,256,4332832438,4096,33554441]

theorem envBound1247 : H12AffineFastState.Bounded env1247 := by
  intro p hp
  have h : env1247.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1246_1247 : H12AffineEnvironment.transform 16 4096 env1246 = env1247 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env1246 == env1247) = true)

theorem identity1247 : scanCanonicalize (H12AffineFastState.compose env1247 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(24+1) ^^^ 20609) := by decide +kernel

theorem selectedBound1247 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env1248 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,16777216,20609,16875796,21352448,16897045,4096,20978847,16876544,4294967296,256,4299265591,4096,20616]

theorem envBound1248 : H12AffineFastState.Bounded env1248 := by
  intro p hp
  have h : env1248.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1247_1248 : H12AffineEnvironment.transform 24 20609 env1247 = env1248 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 20609 env1247 == env1248) = true)

def env1249 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,4096,32768,65536,4096,262144,1024,32768,4096,4194304,5376,16777216,129,16875796,21331968,16876565,4096,20978847,16876544,4294967296,256,4299265591,4096,136]

theorem envBound1249 : H12AffineFastState.Bounded env1249 := by
  intro p hp
  have h : env1249.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1248_1249 : H12AffineEnvironment.transform 13 4096 env1248 = env1249 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4096 env1248 == env1249) = true)

def env1250 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,4096,32768,65536,4096,262144,1024,32768,4096,4194304,5376,4293120,129,4195092,262656,4195861,4096,106143,4195840,4294967296,256,4299265591,4096,136]

theorem envBound1250 : H12AffineFastState.Bounded env1250 := by
  intro p hp
  have h : env1250.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1249_1250 : H12AffineEnvironment.transform 23 4293120 env1249 = env1250 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 4293120 env1249 == env1250) = true)

theorem identity1250 : scanCanonicalize (H12AffineFastState.compose env1250 (packedSelected [1,3,4,5,8,9,10,16,19] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound1250 : packedSelected [1,3,4,5,8,9,10,16,19] rootPS < 2^1333 := by decide +kernel

def env1251 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8,4096,32768,65536,4096,262144,1024,32768,4096,4194304,5376,4292745,129,4194717,262281,4195484,4096,105494,4195465,4294967296,256,4299265214,4096,136]

theorem envBound1251 : H12AffineFastState.Bounded env1251 := by
  intro p hp
  have h : env1251.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1250_1251 : H12AffineEnvironment.transform 8 137 env1250 = env1251 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1250 == env1251) = true)

theorem identity1251 : scanCanonicalize (H12AffineFastState.compose env1251 (packedSelected [0,7,20] rootPS)) = affineNative (2^(21+1) ^^^ 5276) := by decide +kernel

theorem selectedBound1251 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env1252 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8,4096,32768,65536,4096,262144,1024,32768,4096,5276,5376,103445,129,5377,262281,4096,4096,105494,4117,4294967296,256,4295065634,4096,136]

theorem envBound1252 : H12AffineFastState.Bounded env1252 := by
  intro p hp
  have h : env1252.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1251_1252 : H12AffineEnvironment.transform 21 5276 env1251 = env1252 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5276 env1251 == env1252) = true)

theorem identity1252 : scanCanonicalize (H12AffineFastState.compose env1252 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 262567) := by decide +kernel

theorem selectedBound1252 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1253 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8,4096,32768,65536,4096,262144,1024,32768,4096,5276,5376,103445,129,5377,262281,4096,4096,105494,4117,262567,256,360837,4096,136]

theorem envBound1253 : H12AffineFastState.Bounded env1253 := by
  intro p hp
  have h : env1253.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1252_1253 : H12AffineEnvironment.transform 31 262567 env1252 = env1253 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 262567 env1252 == env1253) = true)

def env1254 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,4096,32768,65536,4096,262144,1024,32768,4096,4194304,5376,4293121,129,4195093,262657,4195860,4096,106142,4195841,4294967296,256,4299265591,4096,136]

theorem envBound1254 : H12AffineFastState.Bounded env1254 := by
  intro p hp
  have h : env1254.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1249_1254 : H12AffineEnvironment.transform 23 4293121 env1249 = env1254 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 4293121 env1249 == env1254) = true)

def env1255 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,641,1296,32768,65536,1296,262144,1024,32768,1296,4194304,16,4293121,129,4195093,262657,4195860,1296,101262,4195841,4294967296,256,4299260711,1296,136]

theorem envBound1255 : H12AffineFastState.Bounded env1255 := by
  intro p hp
  have h : env1255.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1254_1255 : H12AffineEnvironment.transform 11 1296 env1254 = env1255 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env1254 == env1255) = true)

theorem identity1255 : scanCanonicalize (H12AffineFastState.compose env1255 (packedSelected [4,6,9,16,25] rootPS)) = affineNative (2^(21+1) ^^^ 397) := by decide +kernel

theorem selectedBound1255 : packedSelected [4,6,9,16,25] rootPS < 2^1333 := by decide +kernel

def env1256 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,641,1296,32768,65536,1296,262144,1024,32768,1296,397,16,99212,129,664,262657,1945,1296,101262,1932,4294967296,256,4295066282,1296,136]

theorem envBound1256 : H12AffineFastState.Bounded env1256 := by
  intro p hp
  have h : env1256.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1255_1256 : H12AffineEnvironment.transform 21 397 env1255 = env1256 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 397 env1255 == env1256) = true)

theorem identity1256 : scanCanonicalize (H12AffineFastState.compose env1256 (packedSelected [4,9,16] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound1256 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env1257 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1296,32768,65536,1296,262144,1024,32768,1296,397,16,98565,129,17,262280,1296,1296,100615,1285,4294967296,256,4295065635,1296,136]

theorem envBound1257 : H12AffineFastState.Bounded env1257 := by
  intro p hp
  have h : env1257.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1256_1257 : H12AffineEnvironment.transform 8 137 env1256 = env1257 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1256 == env1257) = true)

theorem identity1257 : scanCanonicalize (H12AffineFastState.compose env1257 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 295074) := by decide +kernel

theorem selectedBound1257 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1258 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,8,1296,32768,65536,1296,262144,1024,32768,1296,397,16,98565,129,17,262280,1296,1296,100615,1285,295074,256,327809,1296,136]

theorem envBound1258 : H12AffineFastState.Bounded env1258 := by
  intro p hp
  have h : env1258.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1257_1258 : H12AffineEnvironment.transform 31 295074 env1257 = env1258 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 295074 env1257 == env1258) = true)

def env1259 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,641,1297,32768,65536,1297,262144,1024,32768,1297,4194304,17,4293121,129,4195093,262657,4195860,1297,101263,4195841,4294967296,256,4299260710,1297,136]

theorem envBound1259 : H12AffineFastState.Bounded env1259 := by
  intro p hp
  have h : env1259.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1254_1259 : H12AffineEnvironment.transform 11 1297 env1254 = env1259 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env1254 == env1259) = true)

theorem identity1259 : scanCanonicalize (H12AffineFastState.compose env1259 (packedSelected [1,3,4,9,12,13,15,16,17] rootPS)) = affineNative (2^(17+1) ^^^ 100522) := by decide +kernel

theorem selectedBound1259 : packedSelected [1,3,4,9,12,13,15,16,17] rootPS < 2^1333 := by decide +kernel

def env1260 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,641,1297,32768,65536,1297,100522,1024,32768,1297,4194304,17,4293121,129,4195093,101035,4195860,1297,101263,4195841,4294967296,256,4299260710,1297,136]

theorem envBound1260 : H12AffineFastState.Bounded env1260 := by
  intro p hp
  have h : env1260.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1259_1260 : H12AffineEnvironment.transform 17 100522 env1259 = env1260 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 100522 env1259 == env1260) = true)

theorem identity1260 : scanCanonicalize (H12AffineFastState.compose env1260 (packedSelected [1,3,4,9,12,13,15,16,21] rootPS)) = affineNative (2^(21+1) ^^^ 773) := by decide +kernel

theorem selectedBound1260 : packedSelected [1,3,4,9,12,13,15,16,21] rootPS < 2^1333 := by decide +kernel

def env1261 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,641,1297,32768,65536,1297,100522,1024,32768,1297,773,17,98564,129,16,101035,1297,1297,101263,1284,4294967296,256,4295065635,1297,136]

theorem envBound1261 : H12AffineFastState.Bounded env1261 := by
  intro p hp
  have h : env1261.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1260_1261 : H12AffineEnvironment.transform 21 773 env1260 = env1261 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 773 env1260 == env1261) = true)

theorem identity1261 : scanCanonicalize (H12AffineFastState.compose env1261 (packedSelected [1,3,5] rootPS)) = affineNative (2^(15+1) ^^^ 33409) := by decide +kernel

theorem selectedBound1261 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1262 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,641,1297,32768,33409,1297,2603,1024,32768,1297,773,17,901,129,16,2090,1297,1297,2318,1284,4294967296,256,4294967970,1297,136]

theorem envBound1262 : H12AffineFastState.Bounded env1262 := by
  intro p hp
  have h : env1262.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1261_1262 : H12AffineEnvironment.transform 15 33409 env1261 = env1262 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33409 env1261 == env1262) = true)

theorem identity1262 : scanCanonicalize (H12AffineFastState.compose env1262 (packedSelected [1,3,8] rootPS)) = affineNative (2^(14+1) ^^^ 261) := by decide +kernel

theorem selectedBound1262 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env1263 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,641,1297,261,900,1297,2603,1024,261,1297,773,17,901,129,16,2090,1297,1297,2318,1284,4294967296,256,4294967970,1297,136]

theorem envBound1263 : H12AffineFastState.Bounded env1263 := by
  intro p hp
  have h : env1263.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1262_1263 : H12AffineEnvironment.transform 14 261 env1262 = env1263 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 261 env1262 == env1263) = true)

theorem identity1263 : scanCanonicalize (H12AffineFastState.compose env1263 (packedSelected [1,10,12] rootPS)) = affineNative (2^(7+1) ^^^ 134) := by decide +kernel

theorem selectedBound1263 : packedSelected [1,10,12] rootPS < 2^1333 := by decide +kernel

def env1264 : List Nat := [2,4,8,16,32,17,128,134,512,1024,2048,1175,641,1175,131,514,1175,2603,1024,131,1175,643,17,515,129,16,2090,1175,1175,2184,1154,4294967296,134,4294967970,1175,136]

theorem envBound1264 : H12AffineFastState.Bounded env1264 := by
  intro p hp
  have h : env1264.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1263_1264 : H12AffineEnvironment.transform 7 134 env1263 = env1264 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 134 env1263 == env1264) = true)

theorem identity1264 : scanCanonicalize (H12AffineFastState.compose env1264 (packedSelected [1,3] rootPS)) = affineNative (2^(9+1) ^^^ 564) := by decide +kernel

theorem selectedBound1264 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env1265 : List Nat := [2,4,8,16,32,17,128,134,512,564,2048,675,641,675,131,514,675,2603,564,131,675,643,17,515,129,16,2090,675,675,2184,694,4294967296,134,4294967970,675,136]

theorem envBound1265 : H12AffineFastState.Bounded env1265 := by
  intro p hp
  have h : env1265.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1264_1265 : H12AffineEnvironment.transform 9 564 env1264 = env1265 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 564 env1264 == env1265) = true)

theorem identity1265 : scanCanonicalize (H12AffineFastState.compose env1265 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(8+1) ^^^ 163) := by decide +kernel

theorem selectedBound1265 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env1266 : List Nat := [2,4,8,16,32,17,128,134,163,151,2048,0,34,0,131,161,0,2184,151,131,0,32,17,160,129,16,2090,0,0,2184,21,4294967296,134,4294967297,0,136]

theorem envBound1266 : H12AffineFastState.Bounded env1266 := by
  intro p hp
  have h : env1266.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1265_1266 : H12AffineEnvironment.transform 8 163 env1265 = env1266 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 163 env1265 == env1266) = true)

theorem identity1266 : scanCanonicalize (H12AffineFastState.compose env1266 (packedSelected [0,6,7] rootPS)) = affineNative (2^(31+1) ^^^ 2048) := by decide +kernel

theorem selectedBound1266 : packedSelected [0,6,7] rootPS < 2^1333 := by decide +kernel

def env1267 : List Nat := [2,4,8,16,32,17,128,134,163,151,2048,0,34,0,131,161,0,2184,151,131,0,32,17,160,129,16,2090,0,0,2184,21,2048,134,2049,0,136]

theorem envBound1267 : H12AffineFastState.Bounded env1267 := by
  intro p hp
  have h : env1267.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1266_1267 : H12AffineEnvironment.transform 31 2048 env1266 = env1267 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 2048 env1266 == env1267) = true)

theorem identity1267 : scanCanonicalize (H12AffineFastState.compose env1267 (packedSelected [2,6,10] rootPS)) = affineNative (2^(10+1) ^^^ 185) := by decide +kernel

theorem selectedBound1267 : packedSelected [2,6,10] rootPS < 2^1333 := by decide +kernel

def env1268 : List Nat := [2,4,8,16,32,17,128,134,163,151,185,0,34,0,131,161,0,49,151,131,0,32,17,160,129,16,147,0,0,49,21,185,134,184,0,136]

theorem envBound1268 : H12AffineFastState.Bounded env1268 := by
  intro p hp
  have h : env1268.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1267_1268 : H12AffineEnvironment.transform 10 185 env1267 = env1268 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 185 env1267 == env1268) = true)

theorem identity1268 : scanCanonicalize (H12AffineFastState.compose env1268 (packedSelected [1,2] rootPS)) = affineNative (2^(6+1) ^^^ 40) := by decide +kernel

theorem selectedBound1268 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env1269 : List Nat := [2,4,8,16,32,17,40,46,11,63,17,0,34,0,43,9,0,49,63,43,0,32,17,8,41,16,59,0,0,49,21,17,46,16,0,32]

theorem envBound1269 : H12AffineFastState.Bounded env1269 := by
  intro p hp
  have h : env1269.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1268_1269 : H12AffineEnvironment.transform 6 40 env1268 = env1269 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 40 env1268 == env1269) = true)

theorem identity1269 : scanCanonicalize (H12AffineFastState.compose env1269 (packedSelected [1,6] rootPS)) = affineNative (2^(4+1) ^^^ 27) := by decide +kernel

theorem selectedBound1269 : packedSelected [1,6] rootPS < 2^1333 := by decide +kernel

def env1270 : List Nat := [2,4,8,16,27,17,19,21,11,4,17,0,25,0,16,9,0,10,4,16,0,27,17,8,18,16,0,0,0,10,21,17,21,16,0,27]

theorem envBound1270 : H12AffineFastState.Bounded env1270 := by
  intro p hp
  have h : env1270.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1269_1270 : H12AffineEnvironment.transform 4 27 env1269 = env1270 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 27 env1269 == env1270) = true)

theorem identity1270 : scanCanonicalize (H12AffineFastState.compose env1270 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound1270 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1271 : List Nat := [2,4,8,1,10,0,2,4,11,4,0,0,8,0,1,9,0,10,4,1,0,10,0,8,3,1,0,0,0,10,4,0,4,1,0,10]

theorem envBound1271 : H12AffineFastState.Bounded env1271 := by
  intro p hp
  have h : env1271.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1270_1271 : H12AffineEnvironment.transform 3 1 env1270 = env1271 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env1270 == env1271) = true)

theorem identity1271 : scanCanonicalize (H12AffineFastState.compose env1271 (packedSelected [0] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1271 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1272 : List Nat := [2,4,2,1,0,0,2,4,1,4,0,0,2,0,1,3,0,0,4,1,0,0,0,2,3,1,0,0,0,0,4,0,4,1,0,0]

theorem envBound1272 : H12AffineFastState.Bounded env1272 := by
  intro p hp
  have h : env1272.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1271_1272 : H12AffineEnvironment.transform 2 2 env1271 = env1272 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1271 == env1272) = true)

def env1273 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,4097,32768,65536,4096,262144,1024,32768,4096,4194304,5377,16777216,128,16875796,21331969,16876564,4096,20978847,16876544,4294967296,256,4299265591,4096,137]

theorem envBound1273 : H12AffineFastState.Bounded env1273 := by
  intro p hp
  have h : env1273.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1248_1273 : H12AffineEnvironment.transform 13 4097 env1248 = env1273 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4097 env1248 == env1273) = true)

theorem identity1273 : scanCanonicalize (H12AffineFastState.compose env1273 (packedSelected [3,5,8,17,21,28] rootPS)) = affineNative (2^(23+1) ^^^ 138) := by decide +kernel

theorem selectedBound1273 : packedSelected [3,5,8,17,21,28] rootPS < 2^1333 := by decide +kernel

def env1274 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,4097,32768,65536,4096,262144,1024,32768,4096,4194304,5377,138,128,98718,4554891,99486,4096,4201493,99466,4294967296,256,4299265591,4096,137]

theorem envBound1274 : H12AffineFastState.Bounded env1274 := by
  intro p hp
  have h : env1274.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1273_1274 : H12AffineEnvironment.transform 23 138 env1273 = env1274 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 138 env1273 == env1274) = true)

theorem identity1274 : scanCanonicalize (H12AffineFastState.compose env1274 (packedSelected [1,5,6,8,10,17,19,21,24,25,26,31] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound1274 : packedSelected [1,5,6,8,10,17,19,21,24,25,26,31] rootPS < 2^1333 := by decide +kernel

def env1275 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,4097,32768,65536,4096,262144,1024,32768,4096,4194304,5377,138,128,98718,4554891,99486,4096,4201493,99466,4294967296,256,4299265215,4096,137]

theorem envBound1275 : H12AffineFastState.Bounded env1275 := by
  intro p hp
  have h : env1275.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1274_1275 : H12AffineEnvironment.transform 8 136 env1274 = env1275 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1274 == env1275) = true)

theorem identity1275 : scanCanonicalize (H12AffineFastState.compose env1275 (packedSelected [3,4,9,10,16,24,26] rootPS)) = affineNative (2^(15+1) ^^^ 38047) := by decide +kernel

theorem selectedBound1275 : packedSelected [3,4,9,10,16,24,26] rootPS < 2^1333 := by decide +kernel

def env1276 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,4097,32768,38047,4096,262144,1024,32768,4096,4194304,5377,138,128,5377,4461588,4097,4096,4201493,4117,4294967296,256,4299161632,4096,137]

theorem envBound1276 : H12AffineFastState.Bounded env1276 := by
  intro p hp
  have h : env1276.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1275_1276 : H12AffineEnvironment.transform 15 38047 env1275 = env1276 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 38047 env1275 == env1276) = true)

theorem identity1276 : scanCanonicalize (H12AffineFastState.compose env1276 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound1276 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env1277 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1296,9,1297,32768,33167,1296,262144,1024,32768,1296,4194304,17,138,128,17,4456708,1297,1296,4196613,1285,4294967296,256,4299161632,1296,137]

theorem envBound1277 : H12AffineFastState.Bounded env1277 := by
  intro p hp
  have h : env1277.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1276_1277 : H12AffineEnvironment.transform 11 1296 env1276 = env1277 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env1276 == env1277) = true)

theorem identity1277 : scanCanonicalize (H12AffineFastState.compose env1277 (packedSelected [1,3] rootPS)) = affineNative (2^(21+1) ^^^ 295309) := by decide +kernel

theorem selectedBound1277 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env1278 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1296,9,1297,32768,33167,1296,262144,1024,32768,1296,295309,17,138,128,17,32905,1297,1296,297096,1285,4294967296,256,4295262637,1296,137]

theorem envBound1278 : H12AffineFastState.Bounded env1278 := by
  intro p hp
  have h : env1278.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1277_1278 : H12AffineEnvironment.transform 21 295309 env1277 = env1278 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 295309 env1277 == env1278) = true)

theorem identity1278 : scanCanonicalize (H12AffineFastState.compose env1278 (packedSelected [5] rootPS)) = affineNative (2^(17+1) ^^^ 2080) := by decide +kernel

theorem selectedBound1278 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1279 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1296,9,1297,32768,33167,1296,2080,1024,32768,1296,35245,17,138,128,17,32905,1297,1296,32936,1285,4294967296,256,4295002509,1296,137]

theorem envBound1279 : H12AffineFastState.Bounded env1279 := by
  intro p hp
  have h : env1279.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1278_1279 : H12AffineEnvironment.transform 17 2080 env1278 = env1279 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2080 env1278 == env1279) = true)

theorem identity1279 : scanCanonicalize (H12AffineFastState.compose env1279 (packedSelected [8] rootPS)) = affineNative (2^(14+1) ^^^ 0) := by decide +kernel

theorem selectedBound1279 : packedSelected [8] rootPS < 2^1333 := by decide +kernel

def env1280 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1296,9,1297,0,399,1296,2080,1024,0,1296,2477,17,138,128,17,137,1297,1296,168,1285,4294967296,256,4294969741,1296,137]

theorem envBound1280 : H12AffineFastState.Bounded env1280 := by
  intro p hp
  have h : env1280.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1279_1280 : H12AffineEnvironment.transform 14 0 env1279 = env1280 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 0 env1279 == env1280) = true)

theorem identity1280 : scanCanonicalize (H12AffineFastState.compose env1280 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 136) := by decide +kernel

theorem selectedBound1280 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1281 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1296,9,1297,0,399,1296,2080,1024,0,1296,2477,17,138,128,17,137,1297,1296,168,1285,136,256,2309,1296,137]

theorem envBound1281 : H12AffineFastState.Bounded env1281 := by
  intro p hp
  have h : env1281.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1280_1281 : H12AffineEnvironment.transform 31 136 env1280 = env1281 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 136 env1280 == env1281) = true)

theorem identity1281 : scanCanonicalize (H12AffineFastState.compose env1281 (packedSelected [10] rootPS)) = affineNative (2^(10+1) ^^^ 33) := by decide +kernel

theorem selectedBound1281 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env1282 : List Nat := [2,4,8,16,32,17,128,256,136,1024,33,1296,9,1297,0,399,1296,1,1024,0,1296,396,17,138,128,17,137,1297,1296,168,1285,136,256,292,1296,137]

theorem envBound1282 : H12AffineFastState.Bounded env1282 := by
  intro p hp
  have h : env1282.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1281_1282 : H12AffineEnvironment.transform 10 33 env1281 = env1282 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 33 env1281 == env1282) = true)

theorem identity1282 : scanCanonicalize (H12AffineFastState.compose env1282 (packedSelected [6] rootPS)) = affineNative (2^(7+1) ^^^ 47) := by decide +kernel

theorem selectedBound1282 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1283 : List Nat := [2,4,8,16,32,17,128,47,136,1024,33,1087,9,1086,0,160,1087,1,1024,0,1087,163,17,138,128,17,137,1086,1087,168,1066,136,47,11,1087,137]

theorem envBound1283 : H12AffineFastState.Bounded env1283 := by
  intro p hp
  have h : env1283.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1282_1283 : H12AffineEnvironment.transform 7 47 env1282 = env1283 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 47 env1282 == env1283) = true)

theorem identity1283 : scanCanonicalize (H12AffineFastState.compose env1283 (packedSelected [0,4,7] rootPS)) = affineNative (2^(6+1) ^^^ 51) := by decide +kernel

theorem selectedBound1283 : packedSelected [0,4,7] rootPS < 2^1333 := by decide +kernel

def env1284 : List Nat := [2,4,8,16,32,17,51,47,59,1024,33,1087,9,1086,0,19,1087,1,1024,0,1087,16,17,57,51,17,58,1086,1087,27,1066,59,47,11,1087,58]

theorem envBound1284 : H12AffineFastState.Bounded env1284 := by
  intro p hp
  have h : env1284.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1283_1284 : H12AffineEnvironment.transform 6 51 env1283 = env1284 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 51 env1283 == env1284) = true)

theorem identity1284 : scanCanonicalize (H12AffineFastState.compose env1284 (packedSelected [12] rootPS)) = affineNative (2^(4+1) ^^^ 26) := by decide +kernel

theorem selectedBound1284 : packedSelected [12] rootPS < 2^1333 := by decide +kernel

def env1285 : List Nat := [2,4,8,16,26,17,9,21,1,1024,27,1029,9,1028,0,19,1029,1,1024,0,1029,16,17,3,9,17,0,1028,1029,27,1040,1,21,11,1029,0]

theorem envBound1285 : H12AffineFastState.Bounded env1285 := by
  intro p hp
  have h : env1285.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1284_1285 : H12AffineEnvironment.transform 4 26 env1284 = env1285 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 26 env1284 == env1285) = true)

theorem identity1285 : scanCanonicalize (H12AffineFastState.compose env1285 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1285 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1286 : List Nat := [2,4,8,0,10,1,9,5,1,1024,11,1029,9,1028,0,3,1029,1,1024,0,1029,0,1,3,9,1,0,1028,1029,11,1024,1,5,11,1029,0]

theorem envBound1286 : H12AffineFastState.Bounded env1286 := by
  intro p hp
  have h : env1286.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1285_1286 : H12AffineEnvironment.transform 3 0 env1285 = env1286 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1285 == env1286) = true)

def leafEnv1286 : List Nat := [2,4,8,0,10,1,9,5,1,1024,11,1029,9,1028,0,3,1029,1,1024,0,1029,0,1,3,1024,9,1,1,0,1028,1029,11,1024,1,5,11,4,3,1029,0,0,1029,1]

def active1286 : List Nat := [0,1,2,9]

def tree1286 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1286 : H12WitnessSearch.Good tree1286 := H12GlobalWitnessIndex.good

theorem leafIdentity1286 : H12AffineFastState.composeSystem env1286 rootObs = leafEnv1286 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1286 rootObs == leafEnv1286) = true)

theorem terminalChecked1286 : H12PackedTerminal.terminalCheckFast leafEnv1286 active1286 tree1286 = true := by decide +kernel

def env1287 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,16777216,33554432,16875797,21352448,16897044,4097,20978846,16876544,4294967296,256,4332832439,4097,33554441]

theorem envBound1287 : H12AffineFastState.Bounded env1287 := by
  intro p hp
  have h : env1287.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1246_1287 : H12AffineEnvironment.transform 16 4097 env1246 = env1287 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env1246 == env1287) = true)

theorem identity1287 : scanCanonicalize (H12AffineFastState.compose env1287 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(24+1) ^^^ 17808) := by decide +kernel

theorem selectedBound1287 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env1288 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,641,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,16777216,17808,16875797,21352448,16897044,4097,20978846,16876544,4294967296,256,4299260711,4097,17817]

theorem envBound1288 : H12AffineFastState.Bounded env1288 := by
  intro p hp
  have h : env1288.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1287_1288 : H12AffineEnvironment.transform 24 17808 env1287 = env1288 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 17808 env1287 == env1288) = true)

def env1289 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,16777216,17808,16875797,21352448,16897044,4097,20978846,16876544,4294967296,256,4299260335,4097,17817]

theorem envBound1289 : H12AffineFastState.Bounded env1289 := by
  intro p hp
  have h : env1289.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1288_1289 : H12AffineEnvironment.transform 8 136 env1288 = env1289 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1288 == env1289) = true)

theorem identity1289 : scanCanonicalize (H12AffineFastState.compose env1289 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(23+1) ^^^ 103444) := by decide +kernel

theorem selectedBound1289 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env1290 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,103444,17808,5377,4473876,16384,4097,4294794,4116,4294967296,256,4299260335,4097,17817]

theorem envBound1290 : H12AffineFastState.Bounded env1290 := by
  intro p hp
  have h : env1290.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1289_1290 : H12AffineEnvironment.transform 23 103444 env1289 = env1290 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 103444 env1289 == env1290) = true)

theorem identity1290 : scanCanonicalize (H12AffineFastState.compose env1290 (packedSelected [0,1,3,4,7,9,10,16,17,19,20,21] rootPS)) = affineNative (2^(14+1) ^^^ 260) := by decide +kernel

theorem selectedBound1290 : packedSelected [0,1,3,4,7,9,10,16,17,19,20,21] rootPS < 2^1333 := by decide +kernel

def env1291 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,16384,260,65536,4097,262144,1024,260,4096,4194304,17664,70928,17808,5377,4473876,16384,4097,4262286,4116,4294967296,256,4299227307,4097,17817]

theorem envBound1291 : H12AffineFastState.Bounded env1291 := by
  intro p hp
  have h : env1291.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1290_1291 : H12AffineEnvironment.transform 14 260 env1290 = env1291 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 260 env1290 == env1291) = true)

theorem identity1291 : scanCanonicalize (H12AffineFastState.compose env1291 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(13+1) ^^^ 1296) := by decide +kernel

theorem selectedBound1291 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env1292 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,1296,260,65536,4097,262144,1024,260,4096,4194304,16,70928,128,5377,4456708,1296,4097,4262286,4116,4294967296,256,4299227307,4097,137]

theorem envBound1292 : H12AffineFastState.Bounded env1292 := by
  intro p hp
  have h : env1292.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1291_1292 : H12AffineEnvironment.transform 13 1296 env1291 = env1292 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1296 env1291 == env1292) = true)

theorem identity1292 : scanCanonicalize (H12AffineFastState.compose env1292 (packedSelected [5,6,8,10,12,13] rootPS)) = affineNative (2^(31+1) ^^^ 4196622) := by decide +kernel

theorem selectedBound1292 : packedSelected [5,6,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env1293 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,1296,260,65536,4097,262144,1024,260,4096,4194304,16,70928,128,5377,4456708,1296,4097,4262286,4116,4196622,256,68005,4097,137]

theorem envBound1293 : H12AffineFastState.Bounded env1293 := by
  intro p hp
  have h : env1293.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1292_1293 : H12AffineEnvironment.transform 31 4196622 env1292 = env1293 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4196622 env1292 == env1293) = true)

theorem identity1293 : scanCanonicalize (H12AffineFastState.compose env1293 (packedSelected [10,12,17] rootPS)) = affineNative (2^(17+1) ^^^ 7221) := by decide +kernel

theorem selectedBound1293 : packedSelected [10,12,17] rootPS < 2^1333 := by decide +kernel

def env1294 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,1296,260,65536,4097,7221,1024,260,4096,4194304,16,70928,128,5377,4201777,1296,4097,4262286,4116,4196622,256,68005,4097,137]

theorem envBound1294 : H12AffineFastState.Bounded env1294 := by
  intro p hp
  have h : env1294.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1293_1294 : H12AffineEnvironment.transform 17 7221 env1293 = env1294 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 7221 env1293 == env1294) = true)

theorem identity1294 : scanCanonicalize (H12AffineFastState.compose env1294 (packedSelected [5,8] rootPS)) = affineNative (2^(15+1) ^^^ 139) := by decide +kernel

theorem selectedBound1294 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env1295 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,1296,260,139,4097,7221,1024,260,4096,4194304,16,5531,128,5377,4201777,1296,4097,4196613,4116,4196622,256,2350,4097,137]

theorem envBound1295 : H12AffineFastState.Bounded env1295 := by
  intro p hp
  have h : env1295.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1294_1295 : H12AffineEnvironment.transform 15 139 env1294 = env1295 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 139 env1294 == env1295) = true)

def env1296 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,1296,260,139,4097,7221,1024,260,4096,5408,16,5531,128,5377,2065,1296,4097,7205,4116,7214,256,2350,4097,137]

theorem envBound1296 : H12AffineFastState.Bounded env1296 := by
  intro p hp
  have h : env1296.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1295_1296 : H12AffineEnvironment.transform 21 5408 env1295 = env1296 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5408 env1295 == env1296) = true)

theorem identity1296 : scanCanonicalize (H12AffineFastState.compose env1296 (packedSelected [1] rootPS)) = affineNative (2^(10+1) ^^^ 179) := by decide +kernel

theorem selectedBound1296 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1297 : List Nat := [2,4,8,16,32,17,128,256,136,1024,179,4096,9,1296,260,139,4097,5254,1024,260,4096,5408,16,5531,128,5377,162,1296,4097,5270,4116,5277,256,413,4097,137]

theorem envBound1297 : H12AffineFastState.Bounded env1297 := by
  intro p hp
  have h : env1297.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1296_1297 : H12AffineEnvironment.transform 10 179 env1296 = env1297 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 179 env1296 == env1297) = true)

theorem identity1297 : scanCanonicalize (H12AffineFastState.compose env1297 (packedSelected [5] rootPS)) = affineNative (2^(11+1) ^^^ 1038) := by decide +kernel

theorem selectedBound1297 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1298 : List Nat := [2,4,8,16,32,17,128,256,136,1024,179,1038,9,1296,260,139,1039,136,1024,260,1038,302,16,405,128,271,162,1296,1039,152,1050,147,256,413,1039,137]

theorem envBound1298 : H12AffineFastState.Bounded env1298 := by
  intro p hp
  have h : env1298.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1297_1298 : H12AffineEnvironment.transform 11 1038 env1297 = env1298 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1038 env1297 == env1298) = true)

def env1299 : List Nat := [2,4,8,16,0,17,128,256,136,1024,147,1038,9,1296,260,139,1039,136,1024,260,1038,270,16,405,128,271,130,1296,1039,152,1050,147,256,413,1039,137]

theorem envBound1299 : H12AffineFastState.Bounded env1299 := by
  intro p hp
  have h : env1299.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1298_1299 : H12AffineEnvironment.transform 4 0 env1298 = env1299 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1298 == env1299) = true)

theorem identity1299 : scanCanonicalize (H12AffineFastState.compose env1299 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound1299 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1300 : List Nat := [2,4,8,10,0,11,128,256,136,1024,137,1038,9,1290,260,139,1039,136,1024,260,1038,270,10,399,128,271,130,1290,1039,130,1024,137,256,391,1039,137]

theorem envBound1300 : H12AffineFastState.Bounded env1300 := by
  intro p hp
  have h : env1300.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1299_1300 : H12AffineEnvironment.transform 3 10 env1299 = env1300 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env1299 == env1300) = true)

theorem identity1300 : scanCanonicalize (H12AffineFastState.compose env1300 (packedSelected [0,4,6] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound1300 : packedSelected [0,4,6] rootPS < 2^1333 := by decide +kernel

def env1301 : List Nat := [2,4,8,10,0,11,8,256,0,1024,1,1038,9,1290,260,3,1039,0,1024,260,1038,270,10,263,8,271,10,1290,1039,10,1024,1,256,271,1039,1]

theorem envBound1301 : H12AffineFastState.Bounded env1301 := by
  intro p hp
  have h : env1301.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1300_1301 : H12AffineEnvironment.transform 6 8 env1300 = env1301 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env1300 == env1301) = true)

theorem identity1301 : scanCanonicalize (H12AffineFastState.compose env1301 (packedSelected [0] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1301 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1302 : List Nat := [2,4,2,0,0,1,2,256,0,1024,1,1028,3,1280,260,3,1029,0,1024,260,1028,260,0,263,2,261,0,1280,1029,0,1024,1,256,261,1029,1]

theorem envBound1302 : H12AffineFastState.Bounded env1302 := by
  intro p hp
  have h : env1302.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1301_1302 : H12AffineEnvironment.transform 2 2 env1301 = env1302 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1301 == env1302) = true)

def env1303 : List Nat := [2,4,8,16,1,17,128,256,136,1024,146,1038,9,1296,260,139,1039,136,1024,260,1038,271,16,405,128,271,131,1296,1039,152,1050,147,256,413,1039,137]

theorem envBound1303 : H12AffineFastState.Bounded env1303 := by
  intro p hp
  have h : env1303.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1298_1303 : H12AffineEnvironment.transform 4 1 env1298 = env1303 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env1298 == env1303) = true)

theorem identity1303 : scanCanonicalize (H12AffineFastState.compose env1303 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1303 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1304 : List Nat := [2,4,8,16,1,17,128,5,136,1024,146,1038,9,1045,1,139,1039,136,1024,1,1038,10,16,144,128,10,131,1045,1039,152,1050,147,5,152,1039,137]

theorem envBound1304 : H12AffineFastState.Bounded env1304 := by
  intro p hp
  have h : env1304.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1303_1304 : H12AffineEnvironment.transform 7 5 env1303 = env1304 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1303 == env1304) = true)

theorem identity1304 : scanCanonicalize (H12AffineFastState.compose env1304 (packedSelected [0,4,6] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound1304 : packedSelected [0,4,6] rootPS < 2^1333 := by decide +kernel

def env1305 : List Nat := [2,4,8,16,1,17,2,5,10,1024,16,1038,9,1045,1,9,1039,10,1024,1,1038,10,16,18,2,10,1,1045,1039,26,1050,17,5,26,1039,11]

theorem envBound1305 : H12AffineFastState.Bounded env1305 := by
  intro p hp
  have h : env1305.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1304_1305 : H12AffineEnvironment.transform 6 2 env1304 = env1305 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env1304 == env1305) = true)

theorem identity1305 : scanCanonicalize (H12AffineFastState.compose env1305 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound1305 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1306 : List Nat := [2,4,8,11,1,10,2,5,10,1024,11,1038,9,1038,1,9,1039,10,1024,1,1038,10,11,9,2,10,1,1038,1039,1,1025,10,5,1,1039,11]

theorem envBound1306 : H12AffineFastState.Bounded env1306 := by
  intro p hp
  have h : env1306.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1305_1306 : H12AffineEnvironment.transform 3 11 env1305 = env1306 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env1305 == env1306) = true)

theorem identity1306 : scanCanonicalize (H12AffineFastState.compose env1306 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound1306 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1307 : List Nat := [2,4,3,0,1,1,2,5,1,1024,0,1029,2,1029,1,2,1028,1,1024,1,1029,1,0,2,2,1,1,1029,1028,1,1025,1,5,1,1028,0]

theorem envBound1307 : H12AffineFastState.Bounded env1307 := by
  intro p hp
  have h : env1307.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1306_1307 : H12AffineEnvironment.transform 2 3 env1306 = env1307 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env1306 == env1307) = true)

def env1308 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,9,1296,260,139,4097,7221,1024,260,4096,5409,16,5531,128,5377,2064,1296,4097,7204,4116,7215,256,2350,4097,137]

theorem envBound1308 : H12AffineFastState.Bounded env1308 := by
  intro p hp
  have h : env1308.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1295_1308 : H12AffineEnvironment.transform 21 5409 env1295 = env1308 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5409 env1295 == env1308) = true)

theorem identity1308 : scanCanonicalize (H12AffineFastState.compose env1308 (packedSelected [1] rootPS)) = affineNative (2^(11+1) ^^^ 3491) := by decide +kernel

theorem selectedBound1308 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1309 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,3491,9,1296,260,139,3490,406,1024,260,3491,2178,16,2104,128,2210,2064,1296,3490,391,3511,396,256,2350,3490,137]

theorem envBound1309 : H12AffineFastState.Bounded env1309 := by
  intro p hp
  have h : env1309.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1308_1309 : H12AffineEnvironment.transform 11 3491 env1308 = env1309 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3491 env1308 == env1309) = true)

theorem identity1309 : scanCanonicalize (H12AffineFastState.compose env1309 (packedSelected [5] rootPS)) = affineNative (2^(10+1) ^^^ 428) := by decide +kernel

theorem selectedBound1309 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1310 : List Nat := [2,4,8,16,32,17,128,256,136,1024,428,1039,9,1296,260,139,1038,406,1024,260,1039,302,16,404,128,270,444,1296,1038,391,1051,396,256,130,1038,137]

theorem envBound1310 : H12AffineFastState.Bounded env1310 := by
  intro p hp
  have h : env1310.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1309_1310 : H12AffineEnvironment.transform 10 428 env1309 = env1310 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 428 env1309 == env1310) = true)

def env1311 : List Nat := [2,4,8,16,0,17,128,256,136,1024,396,1039,9,1296,260,139,1038,406,1024,260,1039,270,16,404,128,270,412,1296,1038,391,1051,396,256,130,1038,137]

theorem envBound1311 : H12AffineFastState.Bounded env1311 := by
  intro p hp
  have h : env1311.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1310_1311 : H12AffineEnvironment.transform 4 0 env1310 = env1311 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1310 == env1311) = true)

theorem identity1311 : scanCanonicalize (H12AffineFastState.compose env1311 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound1311 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1312 : List Nat := [2,4,8,11,0,10,128,256,136,1024,396,1039,9,1291,260,139,1038,397,1024,260,1039,270,11,399,128,270,391,1291,1038,391,1024,396,256,130,1038,137]

theorem envBound1312 : H12AffineFastState.Bounded env1312 := by
  intro p hp
  have h : env1312.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1311_1312 : H12AffineEnvironment.transform 3 11 env1311 = env1312 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env1311 == env1312) = true)

theorem identity1312 : scanCanonicalize (H12AffineFastState.compose env1312 (packedSelected [0,4,6] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound1312 : packedSelected [0,4,6] rootPS < 2^1333 := by decide +kernel

def env1313 : List Nat := [2,4,8,11,0,10,9,256,1,1024,261,1039,9,1291,260,2,1038,260,1024,260,1039,270,11,262,9,270,270,1291,1038,270,1024,261,256,11,1038,0]

theorem envBound1313 : H12AffineFastState.Bounded env1313 := by
  intro p hp
  have h : env1313.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1312_1313 : H12AffineEnvironment.transform 6 9 env1312 = env1313 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env1312 == env1313) = true)

theorem identity1313 : scanCanonicalize (H12AffineFastState.compose env1313 (packedSelected [2] rootPS)) = affineNative (2^(7+1) ^^^ 14) := by decide +kernel

theorem selectedBound1313 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1314 : List Nat := [2,4,8,11,0,10,9,14,1,1024,11,1039,9,1029,10,2,1038,10,1024,10,1039,0,11,8,9,0,0,1029,1038,0,1024,11,14,11,1038,0]

theorem envBound1314 : H12AffineFastState.Bounded env1314 := by
  intro p hp
  have h : env1314.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1313_1314 : H12AffineEnvironment.transform 7 14 env1313 = env1314 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 14 env1313 == env1314) = true)

theorem identity1314 : scanCanonicalize (H12AffineFastState.compose env1314 (packedSelected [7] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound1314 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1315 : List Nat := [2,4,3,0,0,1,2,5,1,1024,0,1028,2,1029,1,2,1029,1,1024,1,1028,0,0,3,2,0,0,1029,1029,0,1024,0,5,0,1029,0]

theorem envBound1315 : H12AffineFastState.Bounded env1315 := by
  intro p hp
  have h : env1315.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1314_1315 : H12AffineEnvironment.transform 2 3 env1314 = env1315 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env1314 == env1315) = true)

def leafEnv1315 : List Nat := [2,4,3,0,0,1,2,5,1,1024,0,1028,2,1029,1,2,1029,1,1024,1,1028,0,0,3,1024,2,1,0,0,1029,1029,0,1024,0,5,0,4,2,1029,0,0,1029,1]

def active1315 : List Nat := [0,1,9]

def tree1315 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1315 : H12WitnessSearch.Good tree1315 := H12GlobalWitnessIndex.good

theorem leafIdentity1315 : H12AffineFastState.composeSystem env1315 rootObs = leafEnv1315 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1315 rootObs == leafEnv1315) = true)

theorem terminalChecked1315 : H12PackedTerminal.terminalCheckFast leafEnv1315 active1315 tree1315 = true := by decide +kernel

def env1316 : List Nat := [2,4,8,16,1,17,128,256,136,1024,397,1039,9,1296,260,139,1038,406,1024,260,1039,271,16,404,128,270,413,1296,1038,391,1051,396,256,130,1038,137]

theorem envBound1316 : H12AffineFastState.Bounded env1316 := by
  intro p hp
  have h : env1316.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1310_1316 : H12AffineEnvironment.transform 4 1 env1310 = env1316 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env1310 == env1316) = true)

theorem identity1316 : scanCanonicalize (H12AffineFastState.compose env1316 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1316 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1317 : List Nat := [2,4,8,16,1,17,128,5,136,1024,136,1039,9,1045,1,139,1038,147,1024,1,1039,10,16,145,128,11,152,1045,1038,130,1051,137,5,130,1038,137]

theorem envBound1317 : H12AffineFastState.Bounded env1317 := by
  intro p hp
  have h : env1317.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1316_1317 : H12AffineEnvironment.transform 7 5 env1316 = env1317 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1316 == env1317) = true)

theorem identity1317 : scanCanonicalize (H12AffineFastState.compose env1317 (packedSelected [0,4,6] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound1317 : packedSelected [0,4,6] rootPS < 2^1333 := by decide +kernel

def env1318 : List Nat := [2,4,8,16,1,17,3,5,11,1024,11,1039,9,1045,1,8,1038,16,1024,1,1039,10,16,18,3,11,27,1045,1038,1,1051,10,5,1,1038,10]

theorem envBound1318 : H12AffineFastState.Bounded env1318 := by
  intro p hp
  have h : env1318.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1317_1318 : H12AffineEnvironment.transform 6 3 env1317 = env1318 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env1317 == env1318) = true)

theorem identity1318 : scanCanonicalize (H12AffineFastState.compose env1318 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound1318 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1319 : List Nat := [2,4,8,1,1,0,3,5,11,1024,11,1039,9,1028,1,8,1038,1,1024,1,1039,10,1,3,3,11,10,1028,1038,1,1034,10,5,1,1038,10]

theorem envBound1319 : H12AffineFastState.Bounded env1319 := by
  intro p hp
  have h : env1319.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1318_1319 : H12AffineEnvironment.transform 3 1 env1318 = env1319 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env1318 == env1319) = true)

theorem identity1319 : scanCanonicalize (H12AffineFastState.compose env1319 (packedSelected [7] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1319 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1320 : List Nat := [2,4,2,1,1,0,3,5,1,1024,1,1029,3,1028,1,2,1028,1,1024,1,1029,0,1,3,3,1,0,1028,1028,1,1024,0,5,1,1028,0]

theorem envBound1320 : H12AffineFastState.Bounded env1320 := by
  intro p hp
  have h : env1320.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1319_1320 : H12AffineEnvironment.transform 2 2 env1319 = env1320 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1319 == env1320) = true)

def leafEnv1320 : List Nat := [2,4,2,1,1,0,3,5,1,1024,1,1029,3,1028,1,2,1028,1,1024,1,1029,0,1,3,1024,3,1,1,0,1028,1028,1,1024,0,5,1,4,2,1028,0,0,1028,1]

def active1320 : List Nat := [0,1,9]

def tree1320 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1320 : H12WitnessSearch.Good tree1320 := H12GlobalWitnessIndex.good

theorem leafIdentity1320 : H12AffineFastState.composeSystem env1320 rootObs = leafEnv1320 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1320 rootObs == leafEnv1320) = true)

theorem terminalChecked1320 : H12PackedTerminal.terminalCheckFast leafEnv1320 active1320 tree1320 = true := by decide +kernel

def env1321 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,16777216,17808,16875797,21352448,16897044,4097,20978846,16876544,4294967296,256,4299260334,4097,17817]

theorem envBound1321 : H12AffineFastState.Bounded env1321 := by
  intro p hp
  have h : env1321.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1288_1321 : H12AffineEnvironment.transform 8 137 env1288 = env1321 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1288 == env1321) = true)

theorem identity1321 : scanCanonicalize (H12AffineFastState.compose env1321 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound1321 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env1322 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,16384,32768,65536,1296,262144,1024,32768,1297,4194304,17664,16777216,17808,16875797,21349649,16892165,1296,20973967,16876544,4294967296,256,4299260334,1296,17817]

theorem envBound1322 : H12AffineFastState.Bounded env1322 := by
  intro p hp
  have h : env1322.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1321_1322 : H12AffineEnvironment.transform 11 1297 env1321 = env1322 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env1321 == env1322) = true)

theorem identity1322 : scanCanonicalize (H12AffineFastState.compose env1322 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(23+1) ^^^ 115732) := by decide +kernel

theorem selectedBound1322 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env1323 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,16384,32768,65536,1296,262144,1024,32768,1297,4194304,17664,115732,17808,17665,4456709,1297,1296,4312475,16404,4294967296,256,4299260334,1296,17817]

theorem envBound1323 : H12AffineFastState.Bounded env1323 := by
  intro p hp
  have h : env1323.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1322_1323 : H12AffineEnvironment.transform 23 115732 env1322 = env1323 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 115732 env1322 == env1323) = true)

theorem identity1323 : scanCanonicalize (H12AffineFastState.compose env1323 (packedSelected [3,5,8,28] rootPS)) = affineNative (2^(17+1) ^^^ 52529) := by decide +kernel

theorem selectedBound1323 : packedSelected [3,5,8,28] rootPS < 2^1333 := by decide +kernel

def env1324 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,16384,32768,65536,1296,52529,1024,32768,1297,4194304,17664,115732,17808,17665,4246580,1297,1296,4312475,16404,4294967296,256,4299260334,1296,17817]

theorem envBound1324 : H12AffineFastState.Bounded env1324 := by
  intro p hp
  have h : env1324.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1323_1324 : H12AffineEnvironment.transform 17 52529 env1323 = env1324 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 52529 env1323 == env1324) = true)

theorem identity1324 : scanCanonicalize (H12AffineFastState.compose env1324 (packedSelected [10,31] rootPS)) = affineNative (2^(13+1) ^^^ 1297) := by decide +kernel

theorem selectedBound1324 : packedSelected [10,31] rootPS < 2^1333 := by decide +kernel

def env1325 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,1297,32768,65536,1296,34848,1024,32768,1297,4194304,17,98565,129,16,4229413,1297,1296,4294794,1285,4294967296,256,4299260334,1296,136]

theorem envBound1325 : H12AffineFastState.Bounded env1325 := by
  intro p hp
  have h : env1325.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1324_1325 : H12AffineEnvironment.transform 13 1297 env1324 = env1325 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1297 env1324 == env1325) = true)

theorem identity1325 : scanCanonicalize (H12AffineFastState.compose env1325 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 100799) := by decide +kernel

theorem selectedBound1325 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1326 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,1297,32768,65536,1296,34848,1024,32768,1297,4194304,17,98565,129,16,4229413,1297,1296,4294794,1285,100799,256,4196369,1296,136]

theorem envBound1326 : H12AffineFastState.Bounded env1326 := by
  intro p hp
  have h : env1326.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1325_1326 : H12AffineEnvironment.transform 31 100799 env1325 = env1326 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 100799 env1325 == env1326) = true)

theorem identity1326 : scanCanonicalize (H12AffineFastState.compose env1326 (packedSelected [3,8] rootPS)) = affineNative (2^(15+1) ^^^ 33166) := by decide +kernel

theorem selectedBound1326 : packedSelected [3,8] rootPS < 2^1333 := by decide +kernel

def env1327 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,1297,32768,33166,1296,34848,1024,32768,1297,4194304,17,139,129,16,4229413,1297,1296,4196612,1285,2097,256,4196369,1296,136]

theorem envBound1327 : H12AffineFastState.Bounded env1327 := by
  intro p hp
  have h : env1327.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1326_1327 : H12AffineEnvironment.transform 15 33166 env1326 = env1327 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33166 env1326 == env1327) = true)

theorem identity1327 : scanCanonicalize (H12AffineFastState.compose env1327 (packedSelected [3] rootPS)) = affineNative (2^(21+1) ^^^ 260) := by decide +kernel

theorem selectedBound1327 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1328 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,1297,32768,33166,1296,34848,1024,32768,1297,260,17,139,129,16,34849,1297,1296,2048,1285,2097,256,2325,1296,136]

theorem envBound1328 : H12AffineFastState.Bounded env1328 := by
  intro p hp
  have h : env1328.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1327_1328 : H12AffineEnvironment.transform 21 260 env1327 = env1328 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 260 env1327 == env1328) = true)

theorem identity1328 : scanCanonicalize (H12AffineFastState.compose env1328 (packedSelected [0,7] rootPS)) = affineNative (2^(14+1) ^^^ 2340) := by decide +kernel

theorem selectedBound1328 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env1329 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8,1297,2340,2218,1296,260,1024,2340,1297,260,17,139,129,16,261,1297,1296,2048,1285,2097,256,2325,1296,136]

theorem envBound1329 : H12AffineFastState.Bounded env1329 := by
  intro p hp
  have h : env1329.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1328_1329 : H12AffineEnvironment.transform 14 2340 env1328 = env1329 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2340 env1328 == env1329) = true)

def env1330 : List Nat := [2,4,8,16,32,17,128,256,137,1024,32,1297,8,1297,260,138,1296,260,1024,260,1297,260,17,139,129,16,261,1297,1296,32,1285,17,256,309,1296,136]

theorem envBound1330 : H12AffineFastState.Bounded env1330 := by
  intro p hp
  have h : env1330.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1329_1330 : H12AffineEnvironment.transform 10 32 env1329 = env1330 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 32 env1329 == env1330) = true)

theorem identity1330 : scanCanonicalize (H12AffineFastState.compose env1330 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 27) := by decide +kernel

theorem selectedBound1330 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1331 : List Nat := [2,4,8,16,27,17,128,256,137,1024,27,1297,8,1297,260,138,1296,260,1024,260,1297,260,17,139,129,16,261,1297,1296,27,1285,17,256,270,1296,136]

theorem envBound1331 : H12AffineFastState.Bounded env1331 := by
  intro p hp
  have h : env1331.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1330_1331 : H12AffineEnvironment.transform 4 27 env1330 = env1331 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 27 env1330 == env1331) = true)

def env1332 : List Nat := [2,4,8,16,27,17,128,20,137,1024,27,1029,8,1029,16,138,1028,16,1024,16,1029,16,17,139,129,16,17,1029,1028,27,1041,17,20,26,1028,136]

theorem envBound1332 : H12AffineFastState.Bounded env1332 := by
  intro p hp
  have h : env1332.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1331_1332 : H12AffineEnvironment.transform 7 20 env1331 = env1332 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 20 env1331 == env1332) = true)

theorem identity1332 : scanCanonicalize (H12AffineFastState.compose env1332 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1332 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1333 : List Nat := [2,4,8,0,11,1,128,4,137,1024,11,1029,8,1029,0,138,1028,0,1024,0,1029,0,1,139,129,0,1,1029,1028,11,1025,1,4,10,1028,136]

theorem envBound1333 : H12AffineFastState.Bounded env1333 := by
  intro p hp
  have h : env1333.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1332_1333 : H12AffineEnvironment.transform 3 0 env1332 = env1333 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1332 == env1333) = true)

def leafEnv1333 : List Nat := [2,4,8,0,11,1,128,4,137,1024,11,1029,8,1029,0,138,1028,0,1024,0,1029,0,1,139,1025,129,1,0,1,1029,1028,11,1025,1,4,10,4,2,1028,136,0,1028,1]

def active1333 : List Nat := [0,1,2,6,9]

def tree1333 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1333 : H12WitnessSearch.Good tree1333 := H12GlobalWitnessIndex.good

theorem leafIdentity1333 : H12AffineFastState.composeSystem env1333 rootObs = leafEnv1333 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1333 rootObs == leafEnv1333) = true)

theorem terminalChecked1333 : H12PackedTerminal.terminalCheckFast leafEnv1333 active1333 tree1333 = true := by decide +kernel

def env1334 : List Nat := [2,4,8,16,27,17,128,21,137,1024,27,1028,8,1028,17,138,1029,17,1024,17,1028,17,17,139,129,16,16,1028,1029,27,1040,17,21,27,1029,136]

theorem envBound1334 : H12AffineFastState.Bounded env1334 := by
  intro p hp
  have h : env1334.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1331_1334 : H12AffineEnvironment.transform 7 21 env1331 = env1334 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 21 env1331 == env1334) = true)

theorem identity1334 : scanCanonicalize (H12AffineFastState.compose env1334 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound1334 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1335 : List Nat := [2,4,8,10,1,11,128,15,137,1024,1,1028,8,1028,11,138,1029,11,1024,11,1028,11,11,139,129,10,10,1028,1029,1,1034,11,15,1,1029,136]

theorem envBound1335 : H12AffineFastState.Bounded env1335 := by
  intro p hp
  have h : env1335.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1334_1335 : H12AffineEnvironment.transform 3 10 env1334 = env1335 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env1334 == env1335) = true)

def leafEnv1335 : List Nat := [2,4,8,10,1,11,128,15,137,1024,1,1028,8,1028,11,138,1029,11,1024,11,1028,11,11,139,1034,129,1,10,10,1028,1029,1,1034,11,15,1,4,2,1029,136,0,1029,1]

def active1335 : List Nat := [0,1,2,6,9]

def tree1335 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1335 : H12WitnessSearch.Good tree1335 := H12GlobalWitnessIndex.good

theorem leafIdentity1335 : H12AffineFastState.composeSystem env1335 rootObs = leafEnv1335 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1335 rootObs == leafEnv1335) = true)

theorem terminalChecked1335 : H12PackedTerminal.terminalCheckFast leafEnv1335 active1335 tree1335 = true := by decide +kernel

def env1336 : List Nat := [2,4,8,16,32,17,128,256,137,1024,33,1297,8,1297,261,139,1296,260,1024,261,1297,260,17,139,129,16,261,1297,1296,33,1285,16,256,308,1296,136]

theorem envBound1336 : H12AffineFastState.Bounded env1336 := by
  intro p hp
  have h : env1336.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1329_1336 : H12AffineEnvironment.transform 10 33 env1329 = env1336 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 33 env1329 == env1336) = true)

theorem identity1336 : scanCanonicalize (H12AffineFastState.compose env1336 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 50) := by decide +kernel

theorem selectedBound1336 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1337 : List Nat := [2,4,8,16,32,17,50,256,59,1024,33,1297,8,1297,261,57,1296,260,1024,261,1297,260,17,57,51,16,261,1297,1296,33,1285,16,256,308,1296,58]

theorem envBound1337 : H12AffineFastState.Bounded env1337 := by
  intro p hp
  have h : env1337.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1336_1337 : H12AffineEnvironment.transform 6 50 env1336 = env1337 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 50 env1336 == env1337) = true)

def env1338 : List Nat := [2,4,8,16,16,17,2,256,11,1024,17,1297,8,1297,261,9,1296,260,1024,261,1297,260,17,9,3,16,261,1297,1296,17,1285,16,256,260,1296,10]

theorem envBound1338 : H12AffineFastState.Bounded env1338 := by
  intro p hp
  have h : env1338.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1337_1338 : H12AffineEnvironment.transform 4 16 env1337 = env1338 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env1337 == env1338) = true)

theorem identity1338 : scanCanonicalize (H12AffineFastState.compose env1338 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound1338 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1339 : List Nat := [2,4,8,1,1,0,2,256,11,1024,0,1280,8,1280,261,9,1281,260,1024,261,1280,260,0,9,3,1,261,1280,1281,0,1285,1,256,260,1281,10]

theorem envBound1339 : H12AffineFastState.Bounded env1339 := by
  intro p hp
  have h : env1339.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1338_1339 : H12AffineEnvironment.transform 3 1 env1338 = env1339 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env1338 == env1339) = true)

def leafEnv1339 : List Nat := [2,4,8,1,1,0,2,256,11,1024,0,1280,8,1280,261,9,1281,260,1024,261,1280,260,0,9,1285,3,1,1,261,1280,1281,0,1285,1,256,260,4,3,1281,10,0,1281,1]

def active1339 : List Nat := [0,1,2,7,9]

def tree1339 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1339 : H12WitnessSearch.Good tree1339 := H12GlobalWitnessIndex.good

theorem leafIdentity1339 : H12AffineFastState.composeSystem env1339 rootObs = leafEnv1339 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1339 rootObs == leafEnv1339) = true)

theorem terminalChecked1339 : H12PackedTerminal.terminalCheckFast leafEnv1339 active1339 tree1339 = true := by decide +kernel

def env1340 : List Nat := [2,4,8,16,17,17,3,256,10,1024,16,1297,8,1297,261,8,1296,260,1024,261,1297,260,17,8,2,16,261,1297,1296,16,1285,16,256,261,1296,11]

theorem envBound1340 : H12AffineFastState.Bounded env1340 := by
  intro p hp
  have h : env1340.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1337_1340 : H12AffineEnvironment.transform 4 17 env1337 = env1340 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env1337 == env1340) = true)

theorem identity1340 : scanCanonicalize (H12AffineFastState.compose env1340 (packedSelected [2] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound1340 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1341 : List Nat := [2,4,8,16,17,17,3,4,10,1024,16,1045,8,1045,1,8,1044,0,1024,1,1045,0,17,8,2,16,1,1045,1044,16,1025,16,4,1,1044,11]

theorem envBound1341 : H12AffineFastState.Bounded env1341 := by
  intro p hp
  have h : env1341.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1340_1341 : H12AffineEnvironment.transform 7 4 env1340 = env1341 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env1340 == env1341) = true)

def leafEnv1341 : List Nat := [2,4,8,16,17,17,3,4,10,1024,16,1045,8,1045,1,8,1044,0,1024,1,1045,0,17,8,1025,2,1,16,1,1045,1044,16,1025,16,4,1,4,3,1044,11,0,1044,1]

def active1341 : List Nat := [0,1,2,3,9]

def tree1341 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1341 : H12WitnessSearch.Good tree1341 := H12GlobalWitnessIndex.good

theorem leafIdentity1341 : H12AffineFastState.composeSystem env1341 rootObs = leafEnv1341 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1341 rootObs == leafEnv1341) = true)

theorem terminalChecked1341 : H12PackedTerminal.terminalCheckFast leafEnv1341 active1341 tree1341 = true := by decide +kernel

def env1342 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,16777216,33554432,17011013,21352529,17024068,131153,1073741824,16876544,4294967296,256,4332975158,131072,33563272]

theorem envBound1342 : H12AffineFastState.Bounded env1342 := by
  intro p hp
  have h : env1342.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans981_1342 : H12AffineEnvironment.transform 18 1025 env981 = env1342 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env981 == env1342) = true)

theorem identity1342 : scanCanonicalize (H12AffineFastState.compose env1342 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 21126303) := by decide +kernel

theorem selectedBound1342 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env1343 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,16777216,33554432,17011013,21352529,17024068,131153,21126303,16876544,4294967296,256,4332975158,131072,33563272]

theorem envBound1343 : H12AffineFastState.Bounded env1343 := by
  intro p hp
  have h : env1343.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1342_1343 : H12AffineEnvironment.transform 29 21126303 env1342 = env1343 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 21126303 env1342 == env1343) = true)

def env1344 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1025,32768,4096,4194304,5376,16777216,33554432,17011013,21332049,17011780,131153,21105823,16876544,4294967296,256,4332954678,131072,33563272]

theorem envBound1344 : H12AffineFastState.Bounded env1344 := by
  intro p hp
  have h : env1344.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1343_1344 : H12AffineEnvironment.transform 13 4096 env1343 = env1344 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4096 env1343 == env1344) = true)

def env1345 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1025,32768,4096,4194304,5376,16777216,33554432,17010965,21331969,17011732,131073,21105823,16876544,4294967296,256,4332954678,131072,33563272]

theorem envBound1345 : H12AffineFastState.Bounded env1345 := by
  intro p hp
  have h : env1345.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1344_1345 : H12AffineEnvironment.transform 5 16 env1344 = env1345 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env1344 == env1345) = true)

theorem identity1345 : scanCanonicalize (H12AffineFastState.compose env1345 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(23+1) ^^^ 230420) := by decide +kernel

theorem selectedBound1345 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env1346 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1025,32768,4096,4194304,5376,230420,33554432,5377,4588565,4096,131073,4294795,131092,4294967296,256,4332954678,131072,33563272]

theorem envBound1346 : H12AffineFastState.Bounded env1346 := by
  intro p hp
  have h : env1346.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1345_1346 : H12AffineEnvironment.transform 23 230420 env1345 = env1346 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230420 env1345 == env1346) = true)

theorem identity1346 : scanCanonicalize (H12AffineFastState.compose env1346 (packedSelected [1,3,17,21,24,28] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound1346 : packedSelected [1,3,17,21,24,28] rootPS < 2^1333 := by decide +kernel

def env1347 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1025,32768,4096,4194304,5376,230420,8329,5377,4588565,4096,131073,4294795,131092,4294967296,256,4299392191,131072,513]

theorem envBound1347 : H12AffineFastState.Bounded env1347 := by
  intro p hp
  have h : env1347.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1346_1347 : H12AffineEnvironment.transform 24 8329 env1346 = env1347 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env1346 == env1347) = true)

theorem identity1347 : scanCanonicalize (H12AffineFastState.compose env1347 (packedSelected [13,21] rootPS)) = affineNative (2^(14+1) ^^^ 13340) := by decide +kernel

theorem selectedBound1347 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env1348 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,13340,65536,131072,262144,1025,13340,4096,4194304,5376,208904,8329,5377,4588565,4096,131073,4275351,131092,4294967296,256,4299370659,131072,513]

theorem envBound1348 : H12AffineFastState.Bounded env1348 := by
  intro p hp
  have h : env1348.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1347_1348 : H12AffineEnvironment.transform 14 13340 env1347 = env1348 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13340 env1347 == env1348) = true)

theorem identity1348 : scanCanonicalize (H12AffineFastState.compose env1348 (packedSelected [0,5,7,8,13,17,20] rootPS)) = affineNative (2^(16+1) ^^^ 1297) := by decide +kernel

theorem selectedBound1348 : packedSelected [0,5,7,8,13,17,20] rootPS < 2^1333 := by decide +kernel

def env1349 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,13340,65536,1297,262144,1025,13340,4096,4194304,5376,79129,8329,5377,4456708,4096,1296,4275351,1285,4294967296,256,4299240882,1297,513]

theorem envBound1349 : H12AffineFastState.Bounded env1349 := by
  intro p hp
  have h : env1349.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1348_1349 : H12AffineEnvironment.transform 16 1297 env1348 = env1349 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1297 env1348 == env1349) = true)

theorem identity1349 : scanCanonicalize (H12AffineFastState.compose env1349 (packedSelected [3,5,10] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound1349 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env1350 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8192,4096,13340,65536,1297,262144,1025,13340,4096,4194304,5376,79129,8329,5377,4456708,4096,1296,4275351,1285,4294967296,256,4299240882,1297,137]

theorem envBound1350 : H12AffineFastState.Bounded env1350 := by
  intro p hp
  have h : env1350.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1349_1350 : H12AffineEnvironment.transform 8 136 env1349 = env1350 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1349 == env1350) = true)

theorem identity1350 : scanCanonicalize (H12AffineFastState.compose env1350 (packedSelected [1,6,8,12] rootPS)) = affineNative (2^(21+1) ^^^ 79266) := by decide +kernel

theorem selectedBound1350 : packedSelected [1,6,8,12] rootPS < 2^1333 := by decide +kernel

def env1351 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8192,4096,13340,65536,1297,262144,1025,13340,4096,79266,5376,79129,8329,5377,341158,4096,1296,2357,1285,4294967296,256,4294967312,1297,137]

theorem envBound1351 : H12AffineFastState.Bounded env1351 := by
  intro p hp
  have h : env1351.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1350_1351 : H12AffineEnvironment.transform 21 79266 env1350 = env1351 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 79266 env1350 == env1351) = true)

def env1352 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,8192,1296,8460,65536,1297,262144,1025,8460,1296,73906,16,73737,8329,17,336310,1296,1296,2357,1285,4294967296,256,4294967312,1297,137]

theorem envBound1352 : H12AffineFastState.Bounded env1352 := by
  intro p hp
  have h : env1352.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1351_1352 : H12AffineEnvironment.transform 11 1296 env1351 = env1352 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env1351 == env1352) = true)

theorem identity1352 : scanCanonicalize (H12AffineFastState.compose env1352 (packedSelected [1,3,5] rootPS)) = affineNative (2^(17+1) ^^^ 76199) := by decide +kernel

theorem selectedBound1352 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1353 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,8192,1296,8460,65536,1297,76199,1025,8460,1296,73906,16,73737,8329,17,2065,1296,1296,2357,1285,4294967296,256,4294967312,1297,137]

theorem envBound1353 : H12AffineFastState.Bounded env1353 := by
  intro p hp
  have h : env1353.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1352_1353 : H12AffineEnvironment.transform 17 76199 env1352 = env1353 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 76199 env1352 == env1353) = true)

theorem identity1353 : scanCanonicalize (H12AffineFastState.compose env1353 (packedSelected [3] rootPS)) = affineNative (2^(31+1) ^^^ 74141) := by decide +kernel

theorem selectedBound1353 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1354 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,8192,1296,8460,65536,1297,76199,1025,8460,1296,73906,16,73737,8329,17,2065,1296,1296,2357,1285,74141,256,74125,1297,137]

theorem envBound1354 : H12AffineFastState.Bounded env1354 := by
  intro p hp
  have h : env1354.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1353_1354 : H12AffineEnvironment.transform 31 74141 env1353 = env1354 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 74141 env1353 == env1354) = true)

theorem identity1354 : scanCanonicalize (H12AffineFastState.compose env1354 (packedSelected [6] rootPS)) = affineNative (2^(15+1) ^^^ 2218) := by decide +kernel

theorem selectedBound1354 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1355 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,8192,1296,8460,2218,1297,8461,1025,8460,1296,10264,16,10403,8329,17,2065,1296,1296,2357,1285,10551,256,10535,1297,137]

theorem envBound1355 : H12AffineFastState.Bounded env1355 := by
  intro p hp
  have h : env1355.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1354_1355 : H12AffineEnvironment.transform 15 2218 env1354 = env1355 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2218 env1354 == env1355) = true)

theorem identity1355 : scanCanonicalize (H12AffineFastState.compose env1355 (packedSelected [7] rootPS)) = affineNative (2^(12+1) ^^^ 2333) := by decide +kernel

theorem selectedBound1355 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1356 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,2333,1296,2065,2218,1297,2064,1025,2065,1296,261,16,446,2452,17,2065,1296,1296,2357,1285,42,256,58,1297,137]

theorem envBound1356 : H12AffineFastState.Bounded env1356 := by
  intro p hp
  have h : env1356.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1355_1356 : H12AffineEnvironment.transform 12 2333 env1355 = env1356 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2333 env1355 == env1356) = true)

theorem identity1356 : scanCanonicalize (H12AffineFastState.compose env1356 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 53) := by decide +kernel

theorem selectedBound1356 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env1357 : List Nat := [2,4,8,16,32,16,128,53,136,1024,2048,1061,2088,1061,2065,2218,1060,2064,1025,2065,1061,48,16,139,2209,17,2065,1061,1061,2048,1072,42,53,58,1060,137]

theorem envBound1357 : H12AffineFastState.Bounded env1357 := by
  intro p hp
  have h : env1357.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1356_1357 : H12AffineEnvironment.transform 7 53 env1356 = env1357 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 53 env1356 == env1357) = true)

def env1358 : List Nat := [2,4,8,0,32,0,128,37,136,1024,2048,1061,2088,1061,2049,2218,1060,2048,1025,2049,1061,32,0,139,2209,1,2049,1061,1061,2048,1056,42,37,42,1060,137]

theorem envBound1358 : H12AffineFastState.Bounded env1358 := by
  intro p hp
  have h : env1358.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1357_1358 : H12AffineEnvironment.transform 3 0 env1357 = env1358 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1357 == env1358) = true)

theorem identity1358 : scanCanonicalize (H12AffineFastState.compose env1358 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1358 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1359 : List Nat := [2,4,2,0,32,0,128,37,130,1024,2048,1061,2082,1061,2049,2208,1060,2048,1025,2049,1061,32,0,129,2209,1,2049,1061,1061,2048,1056,32,37,32,1060,131]

theorem envBound1359 : H12AffineFastState.Bounded env1359 := by
  intro p hp
  have h : env1359.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1358_1359 : H12AffineEnvironment.transform 2 2 env1358 = env1359 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1358 == env1359) = true)

def leafEnv1359 : List Nat := [2,4,2,0,32,0,128,37,130,1024,2048,1061,2082,1061,2049,2208,1060,2048,1025,2049,1061,32,0,129,1057,2209,1,1,2049,1061,1061,2048,1056,32,37,32,4,2082,1060,131,0,1061,1]

def active1359 : List Nat := [0,1,4,6,9,10]

def tree1359 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1359 : H12WitnessSearch.Good tree1359 := H12GlobalWitnessIndex.good

theorem leafIdentity1359 : H12AffineFastState.composeSystem env1359 rootObs = leafEnv1359 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1359 rootObs == leafEnv1359) = true)

theorem terminalChecked1359 : H12PackedTerminal.terminalCheckFast leafEnv1359 active1359 tree1359 = true := by decide +kernel

def env1360 : List Nat := [2,4,8,1,32,1,128,36,136,1024,2048,1061,2088,1061,2048,2218,1060,2049,1025,2048,1061,33,1,139,2209,0,2048,1061,1061,2048,1057,42,36,43,1060,137]

theorem envBound1360 : H12AffineFastState.Bounded env1360 := by
  intro p hp
  have h : env1360.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1357_1360 : H12AffineEnvironment.transform 3 1 env1357 = env1360 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env1357 == env1360) = true)

def leafEnv1360 : List Nat := [2,4,8,1,32,1,128,36,136,1024,2048,1061,2088,1061,2048,2218,1060,2049,1025,2048,1061,33,1,139,1056,2209,1,0,2048,1061,1061,2048,1057,42,36,43,4,2082,1060,137,0,1061,1]

def active1360 : List Nat := [0,1,2,4,6,9,10]

def tree1360 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1360 : H12WitnessSearch.Good tree1360 := H12GlobalWitnessIndex.good

theorem leafIdentity1360 : H12AffineFastState.composeSystem env1360 rootObs = leafEnv1360 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1360 rootObs == leafEnv1360) = true)

theorem terminalChecked1360 : H12PackedTerminal.terminalCheckFast leafEnv1360 active1360 tree1360 = true := by decide +kernel

def env1361 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1297,8192,1297,8461,65536,1297,262144,1025,8461,1297,73907,17,73736,8329,16,336311,1297,1296,2357,1285,4294967296,256,4294967312,1297,137]

theorem envBound1361 : H12AffineFastState.Bounded env1361 := by
  intro p hp
  have h : env1361.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1351_1361 : H12AffineEnvironment.transform 11 1297 env1351 = env1361 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env1351 == env1361) = true)

theorem identity1361 : scanCanonicalize (H12AffineFastState.compose env1361 (packedSelected [1,3,5] rootPS)) = affineNative (2^(15+1) ^^^ 8323) := by decide +kernel

theorem selectedBound1361 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1362 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1297,8192,1297,8461,8323,1297,262144,1025,8461,1297,48,17,139,8329,16,262452,1297,1296,2357,1285,4294967296,256,4294967312,1297,137]

theorem envBound1362 : H12AffineFastState.Bounded env1362 := by
  intro p hp
  have h : env1362.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1361_1362 : H12AffineEnvironment.transform 15 8323 env1361 = env1362 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8323 env1361 == env1362) = true)

theorem identity1362 : scanCanonicalize (H12AffineFastState.compose env1362 (packedSelected [1,3] rootPS)) = affineNative (2^(12+1) ^^^ 2089) := by decide +kernel

theorem selectedBound1362 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env1363 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1297,2089,1297,2340,2218,1297,262144,1025,2340,1297,48,17,139,2208,16,262452,1297,1296,2357,1285,4294967296,256,4294967312,1297,137]

theorem envBound1363 : H12AffineFastState.Bounded env1363 := by
  intro p hp
  have h : env1363.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1362_1363 : H12AffineEnvironment.transform 12 2089 env1362 = env1363 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2089 env1362 == env1363) = true)

theorem identity1363 : scanCanonicalize (H12AffineFastState.compose env1363 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 264582) := by decide +kernel

theorem selectedBound1363 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1364 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1297,2089,1297,2340,2218,1297,262144,1025,2340,1297,48,17,139,2208,16,262452,1297,1296,2357,1285,264582,256,264598,1297,137]

theorem envBound1364 : H12AffineFastState.Bounded env1364 := by
  intro p hp
  have h : env1364.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1363_1364 : H12AffineEnvironment.transform 31 264582 env1363 = env1364 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 264582 env1363 == env1364) = true)

theorem identity1364 : scanCanonicalize (H12AffineFastState.compose env1364 (packedSelected [8] rootPS)) = affineNative (2^(17+1) ^^^ 2340) := by decide +kernel

theorem selectedBound1364 : packedSelected [8] rootPS < 2^1333 := by decide +kernel

def env1365 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1297,2089,1297,2340,2218,1297,2340,1025,2340,1297,48,17,139,2208,16,2064,1297,1296,2357,1285,162,256,178,1297,137]

theorem envBound1365 : H12AffineFastState.Bounded env1365 := by
  intro p hp
  have h : env1365.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1364_1365 : H12AffineEnvironment.transform 17 2340 env1364 = env1365 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2340 env1364 == env1365) = true)

theorem identity1365 : scanCanonicalize (H12AffineFastState.compose env1365 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 53) := by decide +kernel

theorem selectedBound1365 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1366 : List Nat := [2,4,8,16,32,16,128,53,136,1024,2048,1060,2089,1060,2065,2218,1060,2065,1025,2065,1060,48,17,139,2208,16,2064,1060,1061,2048,1072,162,53,178,1060,137]

theorem envBound1366 : H12AffineFastState.Bounded env1366 := by
  intro p hp
  have h : env1366.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1365_1366 : H12AffineEnvironment.transform 7 53 env1365 = env1366 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 53 env1365 == env1366) = true)

def env1367 : List Nat := [2,4,8,0,32,0,128,37,136,1024,2048,1060,2089,1060,2049,2218,1060,2049,1025,2049,1060,32,1,139,2208,0,2048,1060,1061,2048,1056,162,37,162,1060,137]

theorem envBound1367 : H12AffineFastState.Bounded env1367 := by
  intro p hp
  have h : env1367.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1366_1367 : H12AffineEnvironment.transform 3 0 env1366 = env1367 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1366 == env1367) = true)

theorem identity1367 : scanCanonicalize (H12AffineFastState.compose env1367 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound1367 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1368 : List Nat := [2,4,8,0,32,0,2,37,10,1024,2048,1060,2089,1060,2049,2088,1060,2049,1025,2049,1060,32,1,9,2082,0,2048,1060,1061,2048,1056,32,37,32,1060,11]

theorem envBound1368 : H12AffineFastState.Bounded env1368 := by
  intro p hp
  have h : env1368.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1367_1368 : H12AffineEnvironment.transform 6 2 env1367 = env1368 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env1367 == env1368) = true)

def leafEnv1368 : List Nat := [2,4,8,0,32,0,2,37,10,1024,2048,1060,2089,1060,2049,2088,1060,2049,1025,2049,1060,32,1,9,1057,2082,1,0,2048,1060,1061,2048,1056,32,37,32,4,2082,1060,11,0,1061,1]

def active1368 : List Nat := [0,1,2,4,9,10]

def tree1368 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1368 : H12WitnessSearch.Good tree1368 := H12GlobalWitnessIndex.good

theorem leafIdentity1368 : H12AffineFastState.composeSystem env1368 rootObs = leafEnv1368 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1368 rootObs == leafEnv1368) = true)

theorem terminalChecked1368 : H12PackedTerminal.terminalCheckFast leafEnv1368 active1368 tree1368 = true := by decide +kernel

def env1369 : List Nat := [2,4,8,1,32,1,128,36,136,1024,2048,1060,2089,1060,2048,2218,1060,2048,1025,2048,1060,33,0,139,2208,1,2049,1060,1061,2048,1057,162,36,163,1060,137]

theorem envBound1369 : H12AffineFastState.Bounded env1369 := by
  intro p hp
  have h : env1369.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1366_1369 : H12AffineEnvironment.transform 3 1 env1366 = env1369 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env1366 == env1369) = true)

def leafEnv1369 : List Nat := [2,4,8,1,32,1,128,36,136,1024,2048,1060,2089,1060,2048,2218,1060,2048,1025,2048,1060,33,0,139,1056,2208,1,1,2049,1060,1061,2048,1057,162,36,163,4,2082,1060,137,0,1061,1]

def active1369 : List Nat := [0,1,2,4,6,9,10]

def tree1369 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1369 : H12WitnessSearch.Good tree1369 := H12GlobalWitnessIndex.good

theorem leafIdentity1369 : H12AffineFastState.composeSystem env1369 rootObs = leafEnv1369 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1369 rootObs == leafEnv1369) = true)

theorem terminalChecked1369 : H12PackedTerminal.terminalCheckFast leafEnv1369 active1369 tree1369 = true := by decide +kernel

def env1370 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1025,32768,4096,4194304,5376,16777216,33554432,17010964,21331968,17011733,131072,21105823,16876544,4294967296,256,4332954678,131072,33563272]

theorem envBound1370 : H12AffineFastState.Bounded env1370 := by
  intro p hp
  have h : env1370.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1344_1370 : H12AffineEnvironment.transform 5 17 env1344 = env1370 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env1344 == env1370) = true)

theorem identity1370 : scanCanonicalize (H12AffineFastState.compose env1370 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(24+1) ^^^ 17015965) := by decide +kernel

theorem selectedBound1370 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env1371 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1025,32768,4096,4194304,5376,16777216,17015965,17010964,21331968,17011733,131072,21105823,16876544,4294967296,256,4315938987,131072,17008149]

theorem envBound1371 : H12AffineFastState.Bounded env1371 := by
  intro p hp
  have h : env1371.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1370_1371 : H12AffineEnvironment.transform 24 17015965 env1370 = env1371 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 17015965 env1370 == env1371) = true)

theorem identity1371 : scanCanonicalize (H12AffineFastState.compose env1371 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(23+1) ^^^ 230421) := by decide +kernel

theorem selectedBound1371 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env1372 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1025,32768,4096,4194304,5376,230421,8328,5377,4588565,4096,131072,4294794,131093,4294967296,256,4299392190,131072,512]

theorem envBound1372 : H12AffineFastState.Bounded env1372 := by
  intro p hp
  have h : env1372.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1371_1372 : H12AffineEnvironment.transform 23 230421 env1371 = env1372 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230421 env1371 == env1372) = true)

theorem identity1372 : scanCanonicalize (H12AffineFastState.compose env1372 (packedSelected [4,9,16] rootPS)) = affineNative (2^(21+1) ^^^ 397) := by decide +kernel

theorem selectedBound1372 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env1373 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1025,32768,4096,397,5376,230421,8328,5377,394648,4096,131072,100615,131093,4294967296,256,4295198003,131072,512]

theorem envBound1373 : H12AffineFastState.Bounded env1373 := by
  intro p hp
  have h : env1373.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1372_1373 : H12AffineEnvironment.transform 21 397 env1372 = env1373 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 397 env1372 == env1373) = true)

theorem identity1373 : scanCanonicalize (H12AffineFastState.compose env1373 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(16+1) ^^^ 1297) := by decide +kernel

theorem selectedBound1373 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env1374 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,1297,262144,1025,32768,4096,397,5376,98564,8328,5377,262281,4096,1297,100615,1284,4294967296,256,4295065634,1297,512]

theorem envBound1374 : H12AffineFastState.Bounded env1374 := by
  intro p hp
  have h : env1374.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1373_1374 : H12AffineEnvironment.transform 16 1297 env1373 = env1374 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1297 env1373 == env1374) = true)

theorem identity1374 : scanCanonicalize (H12AffineFastState.compose env1374 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 106539) := by decide +kernel

theorem selectedBound1374 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1375 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,1297,262144,1025,32768,4096,397,5376,98564,8328,5377,262281,4096,1297,100615,1284,106539,256,8201,1297,512]

theorem envBound1375 : H12AffineFastState.Bounded env1375 := by
  intro p hp
  have h : env1375.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1374_1375 : H12AffineEnvironment.transform 31 106539 env1374 = env1375 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 106539 env1374 == env1375) = true)

theorem identity1375 : scanCanonicalize (H12AffineFastState.compose env1375 (packedSelected [3,5,10] rootPS)) = affineNative (2^(15+1) ^^^ 37563) := by decide +kernel

theorem selectedBound1375 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env1376 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,37563,1297,262144,1025,32768,4096,397,5376,5055,8328,5377,262281,4096,1297,7100,1284,12944,256,8201,1297,512]

theorem envBound1376 : H12AffineFastState.Bounded env1376 := by
  intro p hp
  have h : env1376.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1375_1376 : H12AffineEnvironment.transform 15 37563 env1375 = env1376 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 37563 env1375 == env1376) = true)

theorem identity1376 : scanCanonicalize (H12AffineFastState.compose env1376 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 47901) := by decide +kernel

theorem selectedBound1376 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env1377 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,37563,1297,47901,1025,32768,4096,397,5376,5055,8328,5377,48020,4096,1297,7100,1284,12944,256,8201,1297,512]

theorem envBound1377 : H12AffineFastState.Bounded env1377 := by
  intro p hp
  have h : env1377.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1376_1377 : H12AffineEnvironment.transform 17 47901 env1376 = env1377 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 47901 env1376 == env1377) = true)

theorem identity1377 : scanCanonicalize (H12AffineFastState.compose env1377 (packedSelected [3,8,12,13] rootPS)) = affineNative (2^(9+1) ^^^ 173) := by decide +kernel

theorem selectedBound1377 : packedSelected [3,8,12,13] rootPS < 2^1333 := by decide +kernel

def env1378 : List Nat := [2,4,8,16,32,17,128,256,512,173,2048,4096,8192,4096,32768,37563,444,47901,172,32768,4096,397,4525,5055,8328,4524,48020,4096,444,7100,425,12944,256,8201,444,512]

theorem envBound1378 : H12AffineFastState.Bounded env1378 := by
  intro p hp
  have h : env1378.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1377_1378 : H12AffineEnvironment.transform 9 173 env1377 = env1378 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 173 env1377 == env1378) = true)

theorem identity1378 : scanCanonicalize (H12AffineFastState.compose env1378 (packedSelected [1,3,5] rootPS)) = affineNative (2^(14+1) ^^^ 12986) := by decide +kernel

theorem selectedBound1378 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1379 : List Nat := [2,4,8,16,32,17,128,256,512,173,2048,4096,8192,4096,12986,8193,444,2471,172,12986,4096,397,4525,5055,8328,4524,2350,4096,444,7100,425,12944,256,8201,444,512]

theorem envBound1379 : H12AffineFastState.Bounded env1379 := by
  intro p hp
  have h : env1379.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1378_1379 : H12AffineEnvironment.transform 14 12986 env1378 = env1379 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 12986 env1378 == env1379) = true)

theorem identity1379 : scanCanonicalize (H12AffineFastState.compose env1379 (packedSelected [1,12,17] rootPS)) = affineNative (2^(11+1) ^^^ 950) := by decide +kernel

theorem selectedBound1379 : packedSelected [1,12,17] rootPS < 2^1333 := by decide +kernel

def env1380 : List Nat := [2,4,8,16,32,17,128,256,512,173,2048,950,8192,950,8460,8193,444,2471,172,8460,950,397,539,9,8328,538,2350,950,444,2058,425,8486,256,8201,444,512]

theorem envBound1380 : H12AffineFastState.Bounded env1380 := by
  intro p hp
  have h : env1380.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1379_1380 : H12AffineEnvironment.transform 11 950 env1379 = env1380 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 950 env1379 == env1380) = true)

theorem identity1380 : scanCanonicalize (H12AffineFastState.compose env1380 (packedSelected [1,8,12] rootPS)) = affineNative (2^(10+1) ^^^ 429) := by decide +kernel

theorem selectedBound1380 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env1381 : List Nat := [2,4,8,16,32,17,128,256,512,173,429,950,8192,950,8460,8193,444,10,172,8460,950,397,539,9,8328,538,131,950,444,423,425,8486,256,8201,444,512]

theorem envBound1381 : H12AffineFastState.Bounded env1381 := by
  intro p hp
  have h : env1381.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1380_1381 : H12AffineEnvironment.transform 10 429 env1380 = env1381 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 429 env1380 == env1381) = true)

theorem identity1381 : scanCanonicalize (H12AffineFastState.compose env1381 (packedSelected [0,2,7,18] rootPS)) = affineNative (2^(12+1) ^^^ 161) := by decide +kernel

theorem selectedBound1381 : packedSelected [0,2,7,18] rootPS < 2^1333 := by decide +kernel

def env1382 : List Nat := [2,4,8,16,32,17,128,256,512,173,429,950,161,950,429,160,444,10,172,429,950,397,539,9,41,538,131,950,444,423,425,391,256,168,444,512]

theorem envBound1382 : H12AffineFastState.Bounded env1382 := by
  intro p hp
  have h : env1382.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1381_1382 : H12AffineEnvironment.transform 12 161 env1381 = env1382 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 161 env1381 == env1382) = true)

theorem identity1382 : scanCanonicalize (H12AffineFastState.compose env1382 (packedSelected [2,7] rootPS)) = affineNative (2^(8+1) ^^^ 446) := by decide +kernel

theorem selectedBound1382 : packedSelected [2,7] rootPS < 2^1333 := by decide +kernel

def env1383 : List Nat := [2,4,8,16,32,17,128,256,446,173,429,8,161,8,429,160,444,10,172,429,8,397,421,9,41,420,131,8,444,423,425,391,256,168,444,446]

theorem envBound1383 : H12AffineFastState.Bounded env1383 := by
  intro p hp
  have h : env1383.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1382_1383 : H12AffineEnvironment.transform 8 446 env1382 = env1383 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 446 env1382 == env1383) = true)

theorem identity1383 : scanCanonicalize (H12AffineFastState.compose env1383 (packedSelected [2,4,9] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound1383 : packedSelected [2,4,9] rootPS < 2^1333 := by decide +kernel

def env1384 : List Nat := [2,4,8,16,32,17,3,256,317,46,302,8,34,8,302,35,319,10,47,302,8,270,294,9,41,295,0,8,319,292,298,260,256,43,319,317]

theorem envBound1384 : H12AffineFastState.Bounded env1384 := by
  intro p hp
  have h : env1384.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1383_1384 : H12AffineEnvironment.transform 6 3 env1383 = env1384 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env1383 == env1384) = true)

theorem identity1384 : scanCanonicalize (H12AffineFastState.compose env1384 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 29) := by decide +kernel

theorem selectedBound1384 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1385 : List Nat := [2,4,8,16,32,17,3,29,32,46,51,8,34,8,51,35,34,10,47,51,8,19,59,9,41,58,0,8,34,57,55,25,29,43,34,32]

theorem envBound1385 : H12AffineFastState.Bounded env1385 := by
  intro p hp
  have h : env1385.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1384_1385 : H12AffineEnvironment.transform 7 29 env1384 = env1385 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 29 env1384 == env1385) = true)

def env1386 : List Nat := [2,4,8,16,24,17,3,29,24,22,11,8,26,8,11,27,26,10,23,11,8,19,3,9,17,2,0,8,26,1,15,25,29,19,26,24]

theorem envBound1386 : H12AffineFastState.Bounded env1386 := by
  intro p hp
  have h : env1386.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1385_1386 : H12AffineEnvironment.transform 4 24 env1385 = env1386 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 24 env1385 == env1386) = true)

theorem identity1386 : scanCanonicalize (H12AffineFastState.compose env1386 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 9) := by decide +kernel

theorem selectedBound1386 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1387 : List Nat := [2,4,8,9,1,8,3,4,1,15,11,8,3,8,11,2,3,10,14,11,8,10,3,9,8,2,0,8,3,1,15,0,4,10,3,1]

theorem envBound1387 : H12AffineFastState.Bounded env1387 := by
  intro p hp
  have h : env1387.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1386_1387 : H12AffineEnvironment.transform 3 9 env1386 = env1387 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 9 env1386 == env1387) = true)

def env1388 : List Nat := [2,4,8,16,25,17,3,29,25,23,10,8,27,8,10,26,27,10,22,10,8,19,2,9,16,3,0,8,27,0,14,25,29,18,27,25]

theorem envBound1388 : H12AffineFastState.Bounded env1388 := by
  intro p hp
  have h : env1388.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1385_1388 : H12AffineEnvironment.transform 4 25 env1385 = env1388 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 25 env1385 == env1388) = true)

theorem identity1388 : scanCanonicalize (H12AffineFastState.compose env1388 (packedSelected [1] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound1388 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1389 : List Nat := [2,4,3,16,18,17,3,22,18,23,1,3,16,3,1,17,16,1,22,1,3,19,2,2,16,3,0,3,16,0,5,18,22,18,16,18]

theorem envBound1389 : H12AffineFastState.Bounded env1389 := by
  intro p hp
  have h : env1389.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1388_1389 : H12AffineEnvironment.transform 2 3 env1388 = env1389 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env1388 == env1389) = true)

theorem identity1389 : scanCanonicalize (H12AffineFastState.compose env1389 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound1389 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1390 : List Nat := [2,4,3,3,1,2,3,5,1,4,1,3,3,3,1,2,3,1,5,1,3,0,2,2,3,3,0,3,3,0,5,1,5,1,3,1]

theorem envBound1390 : H12AffineFastState.Bounded env1390 := by
  intro p hp
  have h : env1390.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1389_1390 : H12AffineEnvironment.transform 3 3 env1389 = env1390 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env1389 == env1390) = true)

def env1391 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1025,32768,4096,4194304,5377,16777216,33554432,17011013,21332048,17011781,131153,21105822,16876544,4294967296,256,4332954679,131072,33563272]

theorem envBound1391 : H12AffineFastState.Bounded env1391 := by
  intro p hp
  have h : env1391.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1343_1391 : H12AffineEnvironment.transform 13 4097 env1343 = env1391 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4097 env1343 == env1391) = true)

def env1392 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1025,32768,4096,4194304,5377,16777216,33554432,17010965,21331968,17011733,131073,21105822,16876544,4294967296,256,4332954679,131072,33563272]

theorem envBound1392 : H12AffineFastState.Bounded env1392 := by
  intro p hp
  have h : env1392.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1391_1392 : H12AffineEnvironment.transform 5 16 env1391 = env1392 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env1391 == env1392) = true)

theorem identity1392 : scanCanonicalize (H12AffineFastState.compose env1392 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(24+1) ^^^ 17015964) := by decide +kernel

theorem selectedBound1392 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env1393 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1025,32768,4096,4194304,5377,16777216,17015964,17010965,21331968,17011733,131073,21105822,16876544,4294967296,256,4315938987,131072,17008148]

theorem envBound1393 : H12AffineFastState.Bounded env1393 := by
  intro p hp
  have h : env1393.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1392_1393 : H12AffineEnvironment.transform 24 17015964 env1392 = env1393 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 17015964 env1392 == env1393) = true)

theorem identity1393 : scanCanonicalize (H12AffineFastState.compose env1393 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(23+1) ^^^ 230420) := by decide +kernel

theorem selectedBound1393 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env1394 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1025,32768,4096,4194304,5377,230420,8328,5377,4588564,4097,131073,4294794,131092,4294967296,256,4299392191,131072,512]

theorem envBound1394 : H12AffineFastState.Bounded env1394 := by
  intro p hp
  have h : env1394.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1393_1394 : H12AffineEnvironment.transform 23 230420 env1393 = env1394 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230420 env1393 == env1394) = true)

theorem identity1394 : scanCanonicalize (H12AffineFastState.compose env1394 (packedSelected [4,9,16] rootPS)) = affineNative (2^(21+1) ^^^ 397) := by decide +kernel

theorem selectedBound1394 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env1395 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1025,32768,4096,397,5377,230420,8328,5377,394649,4097,131073,100615,131092,4294967296,256,4295198002,131072,512]

theorem envBound1395 : H12AffineFastState.Bounded env1395 := by
  intro p hp
  have h : env1395.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1394_1395 : H12AffineEnvironment.transform 21 397 env1394 = env1395 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 397 env1394 == env1395) = true)

theorem identity1395 : scanCanonicalize (H12AffineFastState.compose env1395 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(16+1) ^^^ 1296) := by decide +kernel

theorem selectedBound1395 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env1396 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,1296,262144,1025,32768,4096,397,5377,98564,8328,5377,262281,4097,1297,100615,1284,4294967296,256,4295065634,1296,512]

theorem envBound1396 : H12AffineFastState.Bounded env1396 := by
  intro p hp
  have h : env1396.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1395_1396 : H12AffineEnvironment.transform 16 1296 env1395 = env1396 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1296 env1395 == env1396) = true)

theorem identity1396 : scanCanonicalize (H12AffineFastState.compose env1396 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 106538) := by decide +kernel

theorem selectedBound1396 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1397 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,1296,262144,1025,32768,4096,397,5377,98564,8328,5377,262281,4097,1297,100615,1284,106538,256,8200,1296,512]

theorem envBound1397 : H12AffineFastState.Bounded env1397 := by
  intro p hp
  have h : env1397.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1396_1397 : H12AffineEnvironment.transform 31 106538 env1396 = env1397 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 106538 env1396 == env1397) = true)

theorem identity1397 : scanCanonicalize (H12AffineFastState.compose env1397 (packedSelected [3,5,10] rootPS)) = affineNative (2^(15+1) ^^^ 37562) := by decide +kernel

theorem selectedBound1397 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env1398 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,37562,1296,262144,1025,32768,4096,397,5377,5054,8328,5377,262281,4097,1297,7101,1284,12944,256,8200,1296,512]

theorem envBound1398 : H12AffineFastState.Bounded env1398 := by
  intro p hp
  have h : env1398.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1397_1398 : H12AffineEnvironment.transform 15 37562 env1397 = env1398 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 37562 env1397 == env1398) = true)

theorem identity1398 : scanCanonicalize (H12AffineFastState.compose env1398 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 47900) := by decide +kernel

theorem selectedBound1398 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env1399 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,37562,1296,47900,1025,32768,4096,397,5377,5054,8328,5377,48021,4097,1297,7101,1284,12944,256,8200,1296,512]

theorem envBound1399 : H12AffineFastState.Bounded env1399 := by
  intro p hp
  have h : env1399.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1398_1399 : H12AffineEnvironment.transform 17 47900 env1398 = env1399 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 47900 env1398 == env1399) = true)

theorem identity1399 : scanCanonicalize (H12AffineFastState.compose env1399 (packedSelected [3,8,12,13] rootPS)) = affineNative (2^(9+1) ^^^ 173) := by decide +kernel

theorem selectedBound1399 : packedSelected [3,8,12,13] rootPS < 2^1333 := by decide +kernel

def env1400 : List Nat := [2,4,8,16,32,16,128,256,512,173,2048,4096,8192,4097,32768,37562,445,47900,172,32768,4096,397,4524,5054,8328,4524,48021,4097,444,7101,425,12944,256,8200,445,512]

theorem envBound1400 : H12AffineFastState.Bounded env1400 := by
  intro p hp
  have h : env1400.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1399_1400 : H12AffineEnvironment.transform 9 173 env1399 = env1400 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 173 env1399 == env1400) = true)

theorem identity1400 : scanCanonicalize (H12AffineFastState.compose env1400 (packedSelected [1,3,5] rootPS)) = affineNative (2^(14+1) ^^^ 8591) := by decide +kernel

theorem selectedBound1400 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1401 : List Nat := [2,4,8,16,32,16,128,256,512,173,2048,4096,8192,4097,8591,13109,445,6803,172,8591,4096,397,4524,5054,8328,4524,6682,4097,444,7101,425,12944,256,8200,445,512]

theorem envBound1401 : H12AffineFastState.Bounded env1401 := by
  intro p hp
  have h : env1401.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1400_1401 : H12AffineEnvironment.transform 14 8591 env1400 = env1401 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8591 env1400 == env1401) = true)

theorem identity1401 : scanCanonicalize (H12AffineFastState.compose env1401 (packedSelected [1,12,17] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound1401 : packedSelected [1,12,17] rootPS < 2^1333 := by decide +kernel

def env1402 : List Nat := [2,4,8,16,32,16,3,256,512,46,2048,4096,8192,4097,8460,13109,318,6672,47,8460,4096,270,4399,4925,8203,4399,6682,4097,319,6974,298,12819,256,8200,318,512]

theorem envBound1402 : H12AffineFastState.Bounded env1402 := by
  intro p hp
  have h : env1402.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1401_1402 : H12AffineEnvironment.transform 6 3 env1401 = env1402 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env1401 == env1402) = true)

theorem identity1402 : scanCanonicalize (H12AffineFastState.compose env1402 (packedSelected [1,8,12] rootPS)) = affineNative (2^(11+1) ^^^ 2587) := by decide +kernel

theorem selectedBound1402 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env1403 : List Nat := [2,4,8,16,32,16,3,256,512,46,2048,2587,8192,2586,8460,10542,318,11,47,8460,2587,270,2868,2342,8203,2868,1,2586,319,293,298,10248,256,8200,318,512]

theorem envBound1403 : H12AffineFastState.Bounded env1403 := by
  intro p hp
  have h : env1403.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1402_1403 : H12AffineEnvironment.transform 11 2587 env1402 = env1403 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 2587 env1402 == env1403) = true)

theorem identity1403 : scanCanonicalize (H12AffineFastState.compose env1403 (packedSelected [2,4,9,18] rootPS)) = affineNative (2^(10+1) ^^^ 261) := by decide +kernel

theorem selectedBound1403 : packedSelected [2,4,9,18] rootPS < 2^1333 := by decide +kernel

def env1404 : List Nat := [2,4,8,16,32,16,3,256,512,46,261,798,8192,799,8460,8235,318,11,47,8460,798,270,561,35,8203,561,1,799,319,293,298,8461,256,8200,318,512]

theorem envBound1404 : H12AffineFastState.Bounded env1404 := by
  intro p hp
  have h : env1404.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1403_1404 : H12AffineEnvironment.transform 10 261 env1403 = env1404 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 261 env1403 == env1404) = true)

theorem identity1404 : scanCanonicalize (H12AffineFastState.compose env1404 (packedSelected [0,7,20] rootPS)) = affineNative (2^(12+1) ^^^ 553) := by decide +kernel

theorem selectedBound1404 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env1405 : List Nat := [2,4,8,16,32,16,3,256,512,46,261,798,553,799,805,514,318,11,47,805,798,270,561,35,546,561,1,799,319,293,298,804,256,545,318,512]

theorem envBound1405 : H12AffineFastState.Bounded env1405 := by
  intro p hp
  have h : env1405.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1404_1405 : H12AffineEnvironment.transform 12 553 env1404 = env1405 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 553 env1404 == env1405) = true)

theorem identity1405 : scanCanonicalize (H12AffineFastState.compose env1405 (packedSelected [2,4,9,23] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound1405 : packedSelected [2,4,9,23] rootPS < 2^1333 := by decide +kernel

def env1406 : List Nat := [2,4,8,16,10,16,3,256,512,4,261,798,515,799,783,514,276,11,5,783,798,270,539,9,520,539,1,799,277,271,256,782,256,523,276,512]

theorem envBound1406 : H12AffineFastState.Bounded env1406 := by
  intro p hp
  have h : env1406.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1405_1406 : H12AffineEnvironment.transform 4 10 env1405 = env1406 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env1405 == env1406) = true)

theorem identity1406 : scanCanonicalize (H12AffineFastState.compose env1406 (packedSelected [0,1,3] rootPS)) = affineNative (2^(3+1) ^^^ 9) := by decide +kernel

theorem selectedBound1406 : packedSelected [0,1,3] rootPS < 2^1333 := by decide +kernel

def env1407 : List Nat := [2,4,8,9,10,9,3,256,512,4,261,775,515,774,783,514,269,11,5,783,775,270,514,9,520,514,1,774,268,271,256,782,256,523,269,512]

theorem envBound1407 : H12AffineFastState.Bounded env1407 := by
  intro p hp
  have h : env1407.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1406_1407 : H12AffineEnvironment.transform 3 9 env1406 = env1407 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 9 env1406 == env1407) = true)

def env1408 : List Nat := [2,4,8,9,10,9,3,256,0,4,261,263,3,262,271,2,269,11,5,271,263,270,2,9,8,2,1,262,268,271,256,270,256,11,269,0]

theorem envBound1408 : H12AffineFastState.Bounded env1408 := by
  intro p hp
  have h : env1408.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1407_1408 : H12AffineEnvironment.transform 8 0 env1407 = env1408 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 0 env1407 == env1408) = true)

theorem identity1408 : scanCanonicalize (H12AffineFastState.compose env1408 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 15) := by decide +kernel

theorem selectedBound1408 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1409 : List Nat := [2,4,8,9,10,9,3,15,0,4,10,8,3,9,0,2,2,11,5,0,8,1,2,9,8,2,1,9,3,0,15,1,15,11,2,0]

theorem envBound1409 : H12AffineFastState.Bounded env1409 := by
  intro p hp
  have h : env1409.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1408_1409 : H12AffineEnvironment.transform 7 15 env1408 = env1409 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 15 env1408 == env1409) = true)

theorem identity1409 : scanCanonicalize (H12AffineFastState.compose env1409 (packedSelected [1] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1409 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1410 : List Nat := [2,4,2,3,0,3,3,5,0,4,0,2,3,3,0,2,2,1,5,0,2,1,2,3,2,2,1,3,3,0,5,1,5,1,2,0]

theorem envBound1410 : H12AffineFastState.Bounded env1410 := by
  intro p hp
  have h : env1410.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1409_1410 : H12AffineEnvironment.transform 2 2 env1409 = env1410 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1409 == env1410) = true)

def env1411 : List Nat := [2,4,8,9,10,9,3,256,1,4,261,262,2,263,270,3,269,11,5,270,262,270,3,9,9,3,1,263,268,271,256,271,256,10,269,1]

theorem envBound1411 : H12AffineFastState.Bounded env1411 := by
  intro p hp
  have h : env1411.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1407_1411 : H12AffineEnvironment.transform 8 1 env1407 = env1411 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 1 env1407 == env1411) = true)

theorem identity1411 : scanCanonicalize (H12AffineFastState.compose env1411 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1411 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1412 : List Nat := [2,4,8,9,10,9,3,5,1,4,0,3,2,2,11,3,8,11,5,11,3,11,3,9,9,3,1,2,9,10,5,10,5,10,8,1]

theorem envBound1412 : H12AffineFastState.Bounded env1412 := by
  intro p hp
  have h : env1412.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1411_1412 : H12AffineEnvironment.transform 7 5 env1411 = env1412 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1411 == env1412) = true)

theorem identity1412 : scanCanonicalize (H12AffineFastState.compose env1412 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1412 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1413 : List Nat := [2,4,2,3,0,3,3,5,1,4,0,3,2,2,1,3,2,1,5,1,3,1,3,3,3,3,1,2,3,0,5,0,5,0,2,1]

theorem envBound1413 : H12AffineFastState.Bounded env1413 := by
  intro p hp
  have h : env1413.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1412_1413 : H12AffineEnvironment.transform 2 2 env1412 = env1413 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1412 == env1413) = true)

def leafEnv1413 : List Nat := [2,4,2,3,0,3,3,5,1,4,0,3,2,2,1,3,2,1,5,1,3,1,3,3,4,3,1,3,1,2,3,0,5,0,5,0,4,2,2,1,0,3,1]

def active1413 : List Nat := [0,1]

def tree1413 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1413 : H12WitnessSearch.Good tree1413 := H12GlobalWitnessIndex.good

theorem leafIdentity1413 : H12AffineFastState.composeSystem env1413 rootObs = leafEnv1413 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1413 rootObs == leafEnv1413) = true)

theorem terminalChecked1413 : H12PackedTerminal.terminalCheckFast leafEnv1413 active1413 tree1413 = true := by decide +kernel

def env1414 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1025,32768,4096,4194304,5377,16777216,33554432,17010964,21331969,17011732,131072,21105822,16876544,4294967296,256,4332954679,131072,33563272]

theorem envBound1414 : H12AffineFastState.Bounded env1414 := by
  intro p hp
  have h : env1414.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1391_1414 : H12AffineEnvironment.transform 5 17 env1391 = env1414 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env1391 == env1414) = true)

theorem identity1414 : scanCanonicalize (H12AffineFastState.compose env1414 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(23+1) ^^^ 230421) := by decide +kernel

theorem selectedBound1414 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env1415 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1025,32768,4096,4194304,5377,230421,33554432,5377,4588564,4097,131072,4294795,131093,4294967296,256,4332954679,131072,33563272]

theorem envBound1415 : H12AffineFastState.Bounded env1415 := by
  intro p hp
  have h : env1415.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1414_1415 : H12AffineEnvironment.transform 23 230421 env1414 = env1415 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230421 env1414 == env1415) = true)

theorem identity1415 : scanCanonicalize (H12AffineFastState.compose env1415 (packedSelected [1,3,17,21,24,28] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound1415 : packedSelected [1,3,17,21,24,28] rootPS < 2^1333 := by decide +kernel

def env1416 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1025,32768,4096,4194304,5377,230421,8329,5377,4588564,4097,131072,4294795,131093,4294967296,256,4299392190,131072,513]

theorem envBound1416 : H12AffineFastState.Bounded env1416 := by
  intro p hp
  have h : env1416.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1415_1416 : H12AffineEnvironment.transform 24 8329 env1415 = env1416 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env1415 == env1416) = true)

theorem identity1416 : scanCanonicalize (H12AffineFastState.compose env1416 (packedSelected [13,21] rootPS)) = affineNative (2^(14+1) ^^^ 13340) := by decide +kernel

theorem selectedBound1416 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env1417 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,13340,65536,131072,262144,1025,13340,4096,4194304,5377,208905,8329,5377,4588564,4097,131072,4275351,131093,4294967296,256,4299370658,131072,513]

theorem envBound1417 : H12AffineFastState.Bounded env1417 := by
  intro p hp
  have h : env1417.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1416_1417 : H12AffineEnvironment.transform 14 13340 env1416 = env1417 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13340 env1416 == env1417) = true)

theorem identity1417 : scanCanonicalize (H12AffineFastState.compose env1417 (packedSelected [0,5,7,8,13,17,20] rootPS)) = affineNative (2^(16+1) ^^^ 1296) := by decide +kernel

theorem selectedBound1417 : packedSelected [0,5,7,8,13,17,20] rootPS < 2^1333 := by decide +kernel

def env1418 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,13340,65536,1296,262144,1025,13340,4096,4194304,5377,79129,8329,5377,4456708,4097,1296,4275351,1285,4294967296,256,4299240882,1296,513]

theorem envBound1418 : H12AffineFastState.Bounded env1418 := by
  intro p hp
  have h : env1418.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1417_1418 : H12AffineEnvironment.transform 16 1296 env1417 = env1418 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1296 env1417 == env1418) = true)

theorem identity1418 : scanCanonicalize (H12AffineFastState.compose env1418 (packedSelected [3,5,10] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound1418 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env1419 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8192,4097,13340,65536,1296,262144,1025,13340,4096,4194304,5377,79129,8329,5377,4456708,4097,1296,4275351,1285,4294967296,256,4299240882,1296,137]

theorem envBound1419 : H12AffineFastState.Bounded env1419 := by
  intro p hp
  have h : env1419.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1418_1419 : H12AffineEnvironment.transform 8 136 env1418 = env1419 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1418 == env1419) = true)

theorem identity1419 : scanCanonicalize (H12AffineFastState.compose env1419 (packedSelected [1,6,8,12] rootPS)) = affineNative (2^(21+1) ^^^ 73907) := by decide +kernel

theorem selectedBound1419 : packedSelected [1,6,8,12] rootPS < 2^1333 := by decide +kernel

def env1420 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8192,4097,13340,65536,1296,262144,1025,13340,4096,73907,5377,79129,8329,5377,336311,4097,1296,7204,1285,4294967296,256,4294972673,1296,137]

theorem envBound1420 : H12AffineFastState.Bounded env1420 := by
  intro p hp
  have h : env1420.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1419_1420 : H12AffineEnvironment.transform 21 73907 env1419 = env1420 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 73907 env1419 == env1420) = true)

def env1421 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1296,8192,1297,8460,65536,1296,262144,1025,8460,1296,73907,17,73737,8329,17,336311,1297,1296,2356,1285,4294967296,256,4294967313,1296,137]

theorem envBound1421 : H12AffineFastState.Bounded env1421 := by
  intro p hp
  have h : env1421.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1420_1421 : H12AffineEnvironment.transform 11 1296 env1420 = env1421 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env1420 == env1421) = true)

theorem identity1421 : scanCanonicalize (H12AffineFastState.compose env1421 (packedSelected [1,3,5] rootPS)) = affineNative (2^(17+1) ^^^ 76199) := by decide +kernel

theorem selectedBound1421 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1422 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1296,8192,1297,8460,65536,1296,76199,1025,8460,1296,73907,17,73737,8329,17,2064,1297,1296,2356,1285,4294967296,256,4294967313,1296,137]

theorem envBound1422 : H12AffineFastState.Bounded env1422 := by
  intro p hp
  have h : env1422.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1421_1422 : H12AffineEnvironment.transform 17 76199 env1421 = env1422 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 76199 env1421 == env1422) = true)

theorem identity1422 : scanCanonicalize (H12AffineFastState.compose env1422 (packedSelected [3] rootPS)) = affineNative (2^(31+1) ^^^ 286) := by decide +kernel

theorem selectedBound1422 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1423 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1296,8192,1297,8460,65536,1296,76199,1025,8460,1296,73907,17,73737,8329,17,2064,1297,1296,2356,1285,286,256,271,1296,137]

theorem envBound1423 : H12AffineFastState.Bounded env1423 := by
  intro p hp
  have h : env1423.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1422_1423 : H12AffineEnvironment.transform 31 286 env1422 = env1423 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 286 env1422 == env1423) = true)

theorem identity1423 : scanCanonicalize (H12AffineFastState.compose env1423 (packedSelected [6] rootPS)) = affineNative (2^(12+1) ^^^ 2088) := by decide +kernel

theorem selectedBound1423 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1424 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1296,2088,1297,2340,65536,1296,65935,1025,2340,1296,67739,17,67617,2209,17,2064,1297,1296,2356,1285,286,256,271,1296,137]

theorem envBound1424 : H12AffineFastState.Bounded env1424 := by
  intro p hp
  have h : env1424.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1423_1424 : H12AffineEnvironment.transform 12 2088 env1423 = env1424 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2088 env1423 == env1424) = true)

theorem identity1424 : scanCanonicalize (H12AffineFastState.compose env1424 (packedSelected [1,8] rootPS)) = affineNative (2^(15+1) ^^^ 2218) := by decide +kernel

theorem selectedBound1424 : packedSelected [1,8] rootPS < 2^1333 := by decide +kernel

def env1425 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1296,2088,1297,2340,2218,1296,2341,1025,2340,1296,49,17,139,2209,17,2064,1297,1296,2356,1285,286,256,271,1296,137]

theorem envBound1425 : H12AffineFastState.Bounded env1425 := by
  intro p hp
  have h : env1425.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1424_1425 : H12AffineEnvironment.transform 15 2218 env1424 = env1425 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2218 env1424 == env1425) = true)

theorem identity1425 : scanCanonicalize (H12AffineFastState.compose env1425 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 52) := by decide +kernel

theorem selectedBound1425 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1426 : List Nat := [2,4,8,16,32,17,128,52,136,1024,2048,1060,2088,1061,2064,2218,1060,2065,1025,2064,1060,49,17,139,2209,17,2064,1061,1060,2048,1073,42,52,59,1060,137]

theorem envBound1426 : H12AffineFastState.Bounded env1426 := by
  intro p hp
  have h : env1426.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1425_1426 : H12AffineEnvironment.transform 7 52 env1425 = env1426 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 52 env1425 == env1426) = true)

def env1427 : List Nat := [2,4,8,0,32,1,128,36,136,1024,2048,1060,2088,1061,2048,2218,1060,2049,1025,2048,1060,33,1,139,2209,1,2048,1061,1060,2048,1057,42,36,43,1060,137]

theorem envBound1427 : H12AffineFastState.Bounded env1427 := by
  intro p hp
  have h : env1427.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1426_1427 : H12AffineEnvironment.transform 3 0 env1426 = env1427 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1426 == env1427) = true)

def leafEnv1427 : List Nat := [2,4,8,0,32,1,128,36,136,1024,2048,1060,2088,1061,2048,2218,1060,2049,1025,2048,1060,33,1,139,1056,2209,1,1,2048,1061,1060,2048,1057,42,36,43,4,2082,1060,137,0,1060,1]

def active1427 : List Nat := [0,1,2,4,6,9,10]

def tree1427 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1427 : H12WitnessSearch.Good tree1427 := H12GlobalWitnessIndex.good

theorem leafIdentity1427 : H12AffineFastState.composeSystem env1427 rootObs = leafEnv1427 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1427 rootObs == leafEnv1427) = true)

theorem terminalChecked1427 : H12PackedTerminal.terminalCheckFast leafEnv1427 active1427 tree1427 = true := by decide +kernel

def env1428 : List Nat := [2,4,8,1,32,0,128,37,136,1024,2048,1060,2088,1061,2049,2218,1060,2048,1025,2049,1060,32,0,139,2209,0,2049,1061,1060,2048,1056,42,37,42,1060,137]

theorem envBound1428 : H12AffineFastState.Bounded env1428 := by
  intro p hp
  have h : env1428.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1426_1428 : H12AffineEnvironment.transform 3 1 env1426 = env1428 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env1426 == env1428) = true)

theorem identity1428 : scanCanonicalize (H12AffineFastState.compose env1428 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1428 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1429 : List Nat := [2,4,2,1,32,0,128,37,130,1024,2048,1060,2082,1061,2049,2208,1060,2048,1025,2049,1060,32,0,129,2209,0,2049,1061,1060,2048,1056,32,37,32,1060,131]

theorem envBound1429 : H12AffineFastState.Bounded env1429 := by
  intro p hp
  have h : env1429.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1428_1429 : H12AffineEnvironment.transform 2 2 env1428 = env1429 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1428 == env1429) = true)

def leafEnv1429 : List Nat := [2,4,2,1,32,0,128,37,130,1024,2048,1060,2082,1061,2049,2208,1060,2048,1025,2049,1060,32,0,129,1057,2209,1,0,2049,1061,1060,2048,1056,32,37,32,4,2082,1060,131,0,1060,1]

def active1429 : List Nat := [0,1,4,6,9,10]

def tree1429 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1429 : H12WitnessSearch.Good tree1429 := H12GlobalWitnessIndex.good

theorem leafIdentity1429 : H12AffineFastState.composeSystem env1429 rootObs = leafEnv1429 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1429 rootObs == leafEnv1429) = true)

theorem terminalChecked1429 : H12PackedTerminal.terminalCheckFast leafEnv1429 active1429 tree1429 = true := by decide +kernel

def env1430 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,8192,1296,8461,65536,1296,262144,1025,8461,1297,73907,16,73736,8329,16,336311,1296,1296,2357,1285,4294967296,256,4294967312,1296,137]

theorem envBound1430 : H12AffineFastState.Bounded env1430 := by
  intro p hp
  have h : env1430.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1420_1430 : H12AffineEnvironment.transform 11 1297 env1420 = env1430 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env1420 == env1430) = true)

theorem identity1430 : scanCanonicalize (H12AffineFastState.compose env1430 (packedSelected [1,3,5] rootPS)) = affineNative (2^(15+1) ^^^ 8323) := by decide +kernel

theorem selectedBound1430 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1431 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,8192,1296,8461,8323,1296,262144,1025,8461,1297,48,16,139,8329,16,262452,1296,1296,2357,1285,4294967296,256,4294967312,1296,137]

theorem envBound1431 : H12AffineFastState.Bounded env1431 := by
  intro p hp
  have h : env1431.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1430_1431 : H12AffineEnvironment.transform 15 8323 env1430 = env1431 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8323 env1430 == env1431) = true)

theorem identity1431 : scanCanonicalize (H12AffineFastState.compose env1431 (packedSelected [1,3] rootPS)) = affineNative (2^(17+1) ^^^ 8461) := by decide +kernel

theorem selectedBound1431 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env1432 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,8192,1296,8461,8323,1296,8461,1025,8461,1297,48,16,139,8329,16,8249,1296,1296,2357,1285,4294967296,256,4294967312,1296,137]

theorem envBound1432 : H12AffineFastState.Bounded env1432 := by
  intro p hp
  have h : env1432.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1431_1432 : H12AffineEnvironment.transform 17 8461 env1431 = env1432 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 8461 env1431 == env1432) = true)

theorem identity1432 : scanCanonicalize (H12AffineFastState.compose env1432 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 162) := by decide +kernel

end H12GlobalChart2
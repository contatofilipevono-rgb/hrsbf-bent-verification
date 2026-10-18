import H12GlobalChart2Data000

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem envTrans233_234 : H12AffineEnvironment.transform 4 10 env233 = env234 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env233 == env234) = true)

def leafEnv234 : List Nat := [2,4,8,16,10,17,19,15,26,1024,1,1055,25,1054,1,18,1054,27,1024,1,1055,10,17,24,1035,3,1,16,26,1054,1055,1,1035,0,15,0,4,9,1054,27,0,1055,1]

def active234 : List Nat := [0,1,2,3,9]

def tree234 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood234 : H12WitnessSearch.Good tree234 := H12GlobalWitnessIndex.good

theorem leafIdentity234 : H12AffineFastState.composeSystem env234 rootObs = leafEnv234 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env234 rootObs == leafEnv234) = true)

theorem terminalChecked234 : H12PackedTerminal.terminalCheckFast leafEnv234 active234 tree234 = true := by decide +kernel

def env235 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,524288,32768,4097,4194304,17664,98564,33554432,67108864,134217728,67130624,138695749,1073741824,138695761,4294967296,138694741,4400472182,1344,33563272]

theorem envBound235 : H12AffineFastState.Bounded env235 := by
  intro p hp
  have h : env235.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans11_235 : H12AffineEnvironment.transform 20 4097 env11 = env235 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env11 == env235) = true)

theorem identity235 : scanCanonicalize (H12AffineFastState.compose env235 (packedSelected [35] rootPS)) = affineNative (2^(26+1) ^^^ 4477269) := by decide +kernel

theorem selectedBound235 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env236 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,524288,32768,4097,4194304,17664,98564,33554432,67108864,4477269,67130624,1296,1073741824,1284,4294967296,256,4400472182,1344,33563272]

theorem envBound236 : H12AffineFastState.Bounded env236 := by
  intro p hp
  have h : env236.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans235_236 : H12AffineEnvironment.transform 26 4477269 env235 = env236 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 4477269 env235 == env236) = true)

def env237 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,524288,32768,4097,4194304,17664,98564,33554432,5376,4477269,16384,1296,1073741824,1284,4294967296,256,4333368694,1344,33563272]

theorem envBound237 : H12AffineFastState.Bounded env237 := by
  intro p hp
  have h : env237.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans236_237 : H12AffineEnvironment.transform 25 5376 env236 = env237 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env236 == env237) = true)

theorem identity237 : scanCanonicalize (H12AffineFastState.compose env237 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(24+1) ^^^ 8328) := by decide +kernel

theorem selectedBound237 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env238 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,524288,32768,4097,4194304,17664,98564,8328,5376,4477269,16384,1296,1073741824,1284,4294967296,256,4299806206,1344,512]

theorem envBound238 : H12AffineFastState.Bounded env238 := by
  intro p hp
  have h : env238.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans237_238 : H12AffineEnvironment.transform 24 8328 env237 = env238 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8328 env237 == env238) = true)

theorem identity238 : scanCanonicalize (H12AffineFastState.compose env238 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(29+1) ^^^ 4267215) := by decide +kernel

theorem selectedBound238 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env239 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,524288,32768,4097,4194304,17664,98564,8328,5376,4477269,16384,1296,4267215,1284,4294967296,256,4299806206,1344,512]

theorem envBound239 : H12AffineFastState.Bounded env239 := by
  intro p hp
  have h : env239.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans238_239 : H12AffineEnvironment.transform 29 4267215 env238 = env239 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4267215 env238 == env239) = true)

theorem identity239 : scanCanonicalize (H12AffineFastState.compose env239 (packedSelected [4,16,22] rootPS)) = affineNative (2^(21+1) ^^^ 25749) := by decide +kernel

theorem selectedBound239 : packedSelected [4,16,22] rootPS < 2^1333 := by decide +kernel

def env240 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,524288,32768,4097,25749,17664,98564,8328,5376,275904,16384,1296,96346,1284,4294967296,256,4295602539,1344,512]

theorem envBound240 : H12AffineFastState.Bounded env240 := by
  intro p hp
  have h : env240.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans239_240 : H12AffineEnvironment.transform 21 25749 env239 = env240 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 25749 env239 == env240) = true)

theorem identity240 : scanCanonicalize (H12AffineFastState.compose env240 (packedSelected [5,15,17,24] rootPS)) = affineNative (2^(31+1) ^^^ 24981) := by decide +kernel

theorem selectedBound240 : packedSelected [5,15,17,24] rootPS < 2^1333 := by decide +kernel

def env241 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,524288,32768,4097,25749,17664,98564,8328,5376,275904,16384,1296,96346,1284,24981,256,643326,1344,512]

theorem envBound241 : H12AffineFastState.Bounded env241 := by
  intro p hp
  have h : env241.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans240_241 : H12AffineEnvironment.transform 31 24981 env240 = env241 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 24981 env240 == env241) = true)

theorem identity241 : scanCanonicalize (H12AffineFastState.compose env241 (packedSelected [4,6,9,16,25] rootPS)) = affineNative (2^(18+1) ^^^ 12616) := by decide +kernel

theorem selectedBound241 : packedSelected [4,6,9,16,25] rootPS < 2^1333 := by decide +kernel

def env242 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,12616,32768,4097,25749,17664,98564,8328,5376,275904,16384,1296,96346,1284,24981,256,123318,1344,512]

theorem envBound242 : H12AffineFastState.Bounded env242 := by
  intro p hp
  have h : env242.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans241_242 : H12AffineEnvironment.transform 18 12616 env241 = env242 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 12616 env241 == env242) = true)

theorem identity242 : scanCanonicalize (H12AffineFastState.compose env242 (packedSelected [0,27] rootPS)) = affineNative (2^(14+1) ^^^ 17428) := by decide +kernel

theorem selectedBound242 : packedSelected [0,27] rootPS < 2^1333 := by decide +kernel

def env243 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,17428,65536,1344,262144,12616,17428,4097,25749,17664,83216,8328,5376,275904,16384,1296,96346,1284,24981,256,75170,1344,512]

theorem envBound243 : H12AffineFastState.Bounded env243 := by
  intro p hp
  have h : env243.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans242_243 : H12AffineEnvironment.transform 14 17428 env242 = env243 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 17428 env242 == env243) = true)

theorem identity243 : scanCanonicalize (H12AffineFastState.compose env243 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 9513) := by decide +kernel

theorem selectedBound243 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env244 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,17428,65536,1344,9513,12616,17428,4097,25749,17664,83216,8328,5376,4329,16384,1296,96346,1284,24981,256,75170,1344,512]

theorem envBound244 : H12AffineFastState.Bounded env244 := by
  intro p hp
  have h : env244.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans243_244 : H12AffineEnvironment.transform 17 9513 env243 = env244 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 9513 env243 == env244) = true)

theorem identity244 : scanCanonicalize (H12AffineFastState.compose env244 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 4177) := by decide +kernel

theorem selectedBound244 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env245 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,5189,65536,1344,9513,12616,5189,4097,13508,5457,70977,8328,5376,4329,4177,1296,75787,1284,12740,256,75170,1344,512]

theorem envBound245 : H12AffineFastState.Bounded env245 := by
  intro p hp
  have h : env245.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans244_245 : H12AffineEnvironment.transform 13 4177 env244 = env245 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env244 == env245) = true)

theorem identity245 : scanCanonicalize (H12AffineFastState.compose env245 (packedSelected [6] rootPS)) = affineNative (2^(15+1) ^^^ 13794) := by decide +kernel

theorem selectedBound245 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env246 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,5189,13794,1344,9513,12616,5189,4097,13508,5457,8355,8328,5376,4329,4177,1296,7657,1284,12740,256,4160,1344,512]

theorem envBound246 : H12AffineFastState.Bounded env246 := by
  intro p hp
  have h : env246.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans245_246 : H12AffineEnvironment.transform 15 13794 env245 = env246 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13794 env245 == env246) = true)

def env247 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,524288,32768,4097,4194304,17664,98564,33554432,5377,4477269,16385,1296,1073741824,1284,4294967296,256,4333368695,1344,33563272]

theorem envBound247 : H12AffineFastState.Bounded env247 := by
  intro p hp
  have h : env247.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans236_247 : H12AffineEnvironment.transform 25 5377 env236 = env247 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env236 == env247) = true)

theorem identity247 : scanCanonicalize (H12AffineFastState.compose env247 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(24+1) ^^^ 554201) := by decide +kernel

theorem selectedBound247 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env248 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,524288,32768,4097,4194304,17664,98564,554201,5377,4477269,16385,1296,1073741824,1284,4294967296,256,4299260334,1344,546385]

theorem envBound248 : H12AffineFastState.Bounded env248 := by
  intro p hp
  have h : env248.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans247_248 : H12AffineEnvironment.transform 24 554201 env247 = env248 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 554201 env247 == env248) = true)

theorem identity248 : scanCanonicalize (H12AffineFastState.compose env248 (packedSelected [5,8,12,13,15,17,24,28] rootPS)) = affineNative (2^(29+1) ^^^ 4721924) := by decide +kernel

theorem selectedBound248 : packedSelected [5,8,12,13,15,17,24,28] rootPS < 2^1333 := by decide +kernel

def env249 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,524288,32768,4097,4194304,17664,98564,554201,5377,4477269,16385,1296,4721924,1284,4294967296,256,4299260334,1344,546385]

theorem envBound249 : H12AffineFastState.Bounded env249 := by
  intro p hp
  have h : env249.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans248_249 : H12AffineEnvironment.transform 29 4721924 env248 = env249 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4721924 env248 == env249) = true)

theorem identity249 : scanCanonicalize (H12AffineFastState.compose env249 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(17+1) ^^^ 63609) := by decide +kernel

theorem selectedBound249 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env250 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,63609,524288,32768,4097,4194304,17664,98564,554201,5377,4237612,16385,1296,4721924,1284,4294967296,256,4299260334,1344,546385]

theorem envBound250 : H12AffineFastState.Bounded env250 := by
  intro p hp
  have h : env250.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans249_250 : H12AffineEnvironment.transform 17 63609 env249 = env250 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 63609 env249 == env250) = true)

theorem identity250 : scanCanonicalize (H12AffineFastState.compose env250 (packedSelected [0,4,7,10,12,13,15,17,18,19,22,23] rootPS)) = affineNative (2^(15+1) ^^^ 53727) := by decide +kernel

theorem selectedBound250 : packedSelected [0,4,7,10,12,13,15,17,18,19,22,23] rootPS < 2^1333 := by decide +kernel

def env251 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,53727,1344,63609,524288,32768,4097,4194304,17664,20699,554201,5377,4237612,16385,1296,4721924,1284,4294967296,256,4299182193,1344,546385]

theorem envBound251 : H12AffineFastState.Bounded env251 := by
  intro p hp
  have h : env251.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans250_251 : H12AffineEnvironment.transform 15 53727 env250 = env251 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 53727 env250 == env251) = true)

theorem identity251 : scanCanonicalize (H12AffineFastState.compose env251 (packedSelected [11,16,18] rootPS)) = affineNative (2^(18+1) ^^^ 21585) := by decide +kernel

theorem selectedBound251 : packedSelected [11,16,18] rootPS < 2^1333 := by decide +kernel

def env252 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,53727,1344,63609,21585,32768,4097,4194304,17664,20699,8328,5377,4237612,16385,1296,4217173,1284,4294967296,256,4299182193,1344,512]

theorem envBound252 : H12AffineFastState.Bounded env252 := by
  intro p hp
  have h : env252.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans251_252 : H12AffineEnvironment.transform 18 21585 env251 = env252 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 21585 env251 == env252) = true)

theorem identity252 : scanCanonicalize (H12AffineFastState.compose env252 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(14+1) ^^^ 20741) := by decide +kernel

theorem selectedBound252 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env253 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,20741,218,1344,10620,21585,20741,4097,4194304,17664,20699,8328,5377,4225065,16385,1296,4217173,1284,4294967296,256,4299182193,1344,512]

theorem envBound253 : H12AffineFastState.Bounded env253 := by
  intro p hp
  have h : env253.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans252_253 : H12AffineEnvironment.transform 14 20741 env252 = env253 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 20741 env252 == env253) = true)

theorem identity253 : scanCanonicalize (H12AffineFastState.compose env253 (packedSelected [0,2,4,5,6,8,11] rootPS)) = affineNative (2^(21+1) ^^^ 20283) := by decide +kernel

theorem selectedBound253 : packedSelected [0,2,4,5,6,8,11] rootPS < 2^1333 := by decide +kernel

def env254 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,20741,218,1344,10620,21585,20741,4097,20283,17664,20699,8328,5377,14098,16385,1296,5742,1284,4294967296,256,4294975306,1344,512]

theorem envBound254 : H12AffineFastState.Bounded env254 := by
  intro p hp
  have h : env254.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans253_254 : H12AffineEnvironment.transform 21 20283 env253 = env254 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 20283 env253 == env254) = true)

theorem identity254 : scanCanonicalize (H12AffineFastState.compose env254 (packedSelected [1,3,10,13,15] rootPS)) = affineNative (2^(13+1) ^^^ 9545) := by decide +kernel

theorem selectedBound254 : packedSelected [1,3,10,13,15] rootPS < 2^1333 := by decide +kernel

def env255 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,9545,13388,218,1344,10620,12568,13388,4097,10866,8265,13714,8328,5377,14098,9544,1296,5742,1284,4294967296,256,4294975306,1344,512]

theorem envBound255 : H12AffineFastState.Bounded env255 := by
  intro p hp
  have h : env255.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans254_255 : H12AffineEnvironment.transform 13 9545 env254 = env255 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 9545 env254 == env255) = true)

theorem identity255 : scanCanonicalize (H12AffineFastState.compose env255 (packedSelected [3,8,10] rootPS)) = affineNative (2^(31+1) ^^^ 6991) := by decide +kernel

theorem selectedBound255 : packedSelected [3,8,10] rootPS < 2^1333 := by decide +kernel

def env256 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,9545,13388,218,1344,10620,12568,13388,4097,10866,8265,13714,8328,5377,14098,9544,1296,5742,1284,6991,256,1029,1344,512]

theorem envBound256 : H12AffineFastState.Bounded env256 := by
  intro p hp
  have h : env256.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans255_256 : H12AffineEnvironment.transform 31 6991 env255 = env256 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 6991 env255 == env256) = true)

theorem identity256 : scanCanonicalize (H12AffineFastState.compose env256 (packedSelected [0,7,16] rootPS)) = affineNative (2^(12+1) ^^^ 3070) := by decide +kernel

theorem selectedBound256 : packedSelected [0,7,16] rootPS < 2^1333 := by decide +kernel

def env257 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,3070,3767,8114,218,1344,642,6886,8114,4097,396,2999,7788,2934,5377,7404,3766,1296,5742,1284,6991,256,1029,1344,512]

theorem envBound257 : H12AffineFastState.Bounded env257 := by
  intro p hp
  have h : env257.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans256_257 : H12AffineEnvironment.transform 12 3070 env256 = env257 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 3070 env256 == env257) = true)

theorem identity257 : scanCanonicalize (H12AffineFastState.compose env257 (packedSelected [3,5,12,17] rootPS)) = affineNative (2^(11+1) ^^^ 3814) := by decide +kernel

theorem selectedBound257 : packedSelected [3,5,12,17] rootPS < 2^1333 := by decide +kernel

def env258 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,3814,3070,3767,340,218,1344,642,1024,340,3815,396,2999,138,2934,3047,522,3766,1296,2184,1284,1449,256,1029,1344,512]

theorem envBound258 : H12AffineFastState.Bounded env258 := by
  intro p hp
  have h : env258.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans257_258 : H12AffineEnvironment.transform 11 3814 env257 = env258 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3814 env257 == env258) = true)

theorem identity258 : scanCanonicalize (H12AffineFastState.compose env258 (packedSelected [6] rootPS)) = affineNative (2^(10+1) ^^^ 1955) := by decide +kernel

theorem selectedBound258 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env259 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1955,325,1117,276,340,218,1344,642,1024,340,324,396,1044,138,1237,1092,522,277,1296,1835,1284,1449,256,1029,1344,512]

theorem envBound259 : H12AffineFastState.Bounded env259 := by
  intro p hp
  have h : env259.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans258_259 : H12AffineEnvironment.transform 10 1955 env258 = env259 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1955 env258 == env259) = true)

theorem identity259 : scanCanonicalize (H12AffineFastState.compose env259 (packedSelected [1,5,12] rootPS)) = affineNative (2^(9+1) ^^^ 5) := by decide +kernel

theorem selectedBound259 : packedSelected [1,5,12] rootPS < 2^1333 := by decide +kernel

def env260 : List Nat := [2,4,8,16,32,64,128,256,512,5,934,325,88,276,340,218,325,642,5,340,324,396,17,138,208,65,522,277,277,814,257,428,256,0,325,512]

theorem envBound260 : H12AffineFastState.Bounded env260 := by
  intro p hp
  have h : env260.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans259_260 : H12AffineEnvironment.transform 9 5 env259 = env260 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 5 env259 == env260) = true)

theorem identity260 : scanCanonicalize (H12AffineFastState.compose env260 (packedSelected [1,3,5] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound260 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env261 : List Nat := [2,4,8,16,32,64,8,256,512,5,814,325,88,276,340,82,325,522,5,340,324,260,17,2,88,65,522,277,277,814,257,292,256,0,325,512]

theorem envBound261 : H12AffineFastState.Bounded env261 := by
  intro p hp
  have h : env261.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans260_261 : H12AffineEnvironment.transform 6 8 env260 = env261 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env260 == env261) = true)

theorem identity261 : scanCanonicalize (H12AffineFastState.compose env261 (packedSelected [0] rootPS)) = affineNative (2^(8+1) ^^^ 349) := by decide +kernel

theorem selectedBound261 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env262 : List Nat := [2,4,8,16,32,64,8,256,349,5,115,325,88,276,340,82,325,343,5,340,324,260,17,2,88,65,343,277,277,115,257,292,256,0,325,349]

theorem envBound262 : H12AffineFastState.Bounded env262 := by
  intro p hp
  have h : env262.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans261_262 : H12AffineEnvironment.transform 8 349 env261 = env262 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 349 env261 == env262) = true)

def env263 : List Nat := [2,4,8,16,32,16,8,256,269,5,35,277,8,276,260,2,277,263,5,260,276,260,17,2,8,17,263,277,277,35,257,292,256,0,277,269]

theorem envBound263 : H12AffineFastState.Bounded env263 := by
  intro p hp
  have h : env263.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans262_263 : H12AffineEnvironment.transform 5 16 env262 = env263 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env262 == env263) = true)

theorem identity263 : scanCanonicalize (H12AffineFastState.compose env263 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 39) := by decide +kernel

theorem selectedBound263 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env264 : List Nat := [2,4,8,16,32,16,8,39,42,5,35,50,8,51,35,2,50,32,5,35,51,35,17,2,8,17,32,50,50,35,38,3,39,0,50,42]

theorem envBound264 : H12AffineFastState.Bounded env264 := by
  intro p hp
  have h : env264.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans263_264 : H12AffineEnvironment.transform 7 39 env263 = env264 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 39 env263 == env264) = true)

def env265 : List Nat := [2,4,8,16,32,17,8,256,268,5,34,276,9,276,261,3,276,262,5,261,277,260,17,2,9,16,262,277,277,34,257,292,256,0,276,268]

theorem envBound265 : H12AffineFastState.Bounded env265 := by
  intro p hp
  have h : env265.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans262_265 : H12AffineEnvironment.transform 5 17 env262 = env265 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env262 == env265) = true)

theorem identity265 : scanCanonicalize (H12AffineFastState.compose env265 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound265 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env266 : List Nat := [2,4,8,16,32,17,8,36,40,5,34,48,9,48,33,3,48,34,5,33,49,32,17,2,9,16,34,49,49,34,37,0,36,0,48,40]

theorem envBound266 : H12AffineFastState.Bounded env266 := by
  intro p hp
  have h : env266.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans265_266 : H12AffineEnvironment.transform 7 36 env265 = env266 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env265 == env266) = true)

theorem identity266 : scanCanonicalize (H12AffineFastState.compose env266 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 0) := by decide +kernel

theorem selectedBound266 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env267 : List Nat := [2,4,0,16,32,17,0,36,32,5,34,48,1,48,33,3,48,34,5,33,49,32,17,2,1,16,34,49,49,34,37,0,36,0,48,32]

theorem envBound267 : H12AffineFastState.Bounded env267 := by
  intro p hp
  have h : env267.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans266_267 : H12AffineEnvironment.transform 2 0 env266 = env267 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env266 == env267) = true)

theorem identity267 : scanCanonicalize (H12AffineFastState.compose env267 (packedSelected [4] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound267 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env268 : List Nat := [1,4,0,16,32,17,0,36,32,5,33,48,1,48,33,0,48,33,5,33,49,32,17,1,1,16,33,49,49,33,37,0,36,0,48,32]

theorem envBound268 : H12AffineFastState.Bounded env268 := by
  intro p hp
  have h : env268.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans267_268 : H12AffineEnvironment.transform 0 1 env267 = env268 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env267 == env268) = true)

def leafEnv268 : List Nat := [1,4,0,16,32,17,0,36,32,5,33,48,1,48,33,0,48,33,5,33,49,32,17,1,37,1,1,16,33,49,49,33,37,0,36,0,4,0,48,32,0,49,1]

def active268 : List Nat := [1,3,4]

def tree268 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood268 : H12WitnessSearch.Good tree268 := H12GlobalWitnessIndex.good

theorem leafIdentity268 : H12AffineFastState.composeSystem env268 rootObs = leafEnv268 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env268 rootObs == leafEnv268) = true)

theorem terminalChecked268 : H12PackedTerminal.terminalCheckFast leafEnv268 active268 tree268 = true := by decide +kernel

def env269 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,2097152,4194304,17664,98564,33554432,67108864,134217728,67130624,140788805,1073741824,140788816,4294967296,140787796,4400472182,1345,33563272]

theorem envBound269 : H12AffineFastState.Bounded env269 := by
  intro p hp
  have h : env269.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans10_269 : H12AffineEnvironment.transform 16 1345 env10 = env269 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env10 == env269) = true)

def env270 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4096,4194304,17664,98564,33554432,67108864,134217728,67130624,138695749,1073741824,138695760,4294967296,138694740,4400472182,1345,33563272]

theorem envBound270 : H12AffineFastState.Bounded env270 := by
  intro p hp
  have h : env270.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans269_270 : H12AffineEnvironment.transform 20 4096 env269 = env270 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env269 == env270) = true)

theorem identity270 : scanCanonicalize (H12AffineFastState.compose env270 (packedSelected [35] rootPS)) = affineNative (2^(25+1) ^^^ 5377) := by decide +kernel

theorem selectedBound270 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env271 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4096,4194304,17664,98564,33554432,5377,134217728,16385,138695749,1073741824,138695760,4294967296,138694740,4333368695,1345,33563272]

theorem envBound271 : H12AffineFastState.Bounded env271 := by
  intro p hp
  have h : env271.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans270_271 : H12AffineEnvironment.transform 25 5377 env270 = env271 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env270 == env271) = true)

theorem identity271 : scanCanonicalize (H12AffineFastState.compose env271 (packedSelected [1,3,10,19,24,26,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound271 : packedSelected [1,3,10,19,24,26,28,31] rootPS < 2^1333 := by decide +kernel

def env272 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4096,4194304,17664,98564,8329,5377,134217728,16385,138695749,1073741824,138695760,4294967296,138694740,4299806206,1345,513]

theorem envBound272 : H12AffineFastState.Bounded env272 := by
  intro p hp
  have h : env272.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans271_272 : H12AffineEnvironment.transform 24 8329 env271 = env272 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env271 == env272) = true)

theorem identity272 : scanCanonicalize (H12AffineFastState.compose env272 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(26+1) ^^^ 4477269) := by decide +kernel

theorem selectedBound272 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env273 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4096,4194304,17664,98564,8329,5377,4477269,16385,1296,1073741824,1285,4294967296,257,4299806206,1345,513]

theorem envBound273 : H12AffineFastState.Bounded env273 := by
  intro p hp
  have h : env273.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans272_273 : H12AffineEnvironment.transform 26 4477269 env272 = env273 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 4477269 env272 == env273) = true)

theorem identity273 : scanCanonicalize (H12AffineFastState.compose env273 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(13+1) ^^^ 4824) := by decide +kernel

theorem selectedBound273 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env274 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4824,32768,65536,1345,262144,524288,32768,4096,4194304,6104,98564,8329,5377,4457357,4825,1296,1073741824,1285,4294967296,257,4299786022,1345,513]

theorem envBound274 : H12AffineFastState.Bounded env274 := by
  intro p hp
  have h : env274.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans273_274 : H12AffineEnvironment.transform 13 4824 env273 = env274 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4824 env273 == env274) = true)

def env275 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4824,32768,65536,1345,262144,1672,32768,4096,4194304,6104,98564,8329,5377,4457357,4825,1296,1073741824,1285,4294967296,257,4299260334,1345,513]

theorem envBound275 : H12AffineFastState.Bounded env275 := by
  intro p hp
  have h : env275.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans274_275 : H12AffineEnvironment.transform 18 1672 env274 = env275 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1672 env274 == env275) = true)

theorem identity275 : scanCanonicalize (H12AffineFastState.compose env275 (packedSelected [4,9,16] rootPS)) = affineNative (2^(29+1) ^^^ 4295170) := by decide +kernel

theorem selectedBound275 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env276 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4824,32768,65536,1345,262144,1672,32768,4096,4194304,6104,98564,8329,5377,4457357,4825,1296,4295170,1285,4294967296,257,4299260334,1345,513]

theorem envBound276 : H12AffineFastState.Bounded env276 := by
  intro p hp
  have h : env276.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans275_276 : H12AffineEnvironment.transform 29 4295170 env275 = env276 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4295170 env275 == env276) = true)

theorem identity276 : scanCanonicalize (H12AffineFastState.compose env276 (packedSelected [1,8,10,12,15] rootPS)) = affineNative (2^(21+1) ^^^ 103991) := by decide +kernel

theorem selectedBound276 : packedSelected [1,8,10,12,15] rootPS < 2^1333 := by decide +kernel

def env277 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4824,32768,65536,1345,262144,1672,32768,4096,103991,6104,98564,8329,5377,366010,4825,1296,7221,1285,4294967296,257,4294973337,1345,513]

theorem envBound277 : H12AffineFastState.Bounded env277 := by
  intro p hp
  have h : env277.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans276_277 : H12AffineEnvironment.transform 21 103991 env276 = env277 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 103991 env276 == env277) = true)

theorem identity277 : scanCanonicalize (H12AffineFastState.compose env277 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound277 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env278 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4177,32768,65536,1345,262144,1025,32768,4096,103614,5457,98564,8329,5377,366010,4176,1296,7221,1285,4294967296,257,4294972688,1345,136]

theorem envBound278 : H12AffineFastState.Bounded env278 := by
  intro p hp
  have h : env278.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans277_278 : H12AffineEnvironment.transform 8 137 env277 = env278 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env277 == env278) = true)

theorem identity278 : scanCanonicalize (H12AffineFastState.compose env278 (packedSelected [3,5,10] rootPS)) = affineNative (2^(31+1) ^^^ 341) := by decide +kernel

theorem selectedBound278 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env279 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4177,32768,65536,1345,262144,1025,32768,4096,103614,5457,98564,8329,5377,366010,4176,1296,7221,1285,341,257,5189,1345,136]

theorem envBound279 : H12AffineFastState.Bounded env279 := by
  intro p hp
  have h : env279.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans278_279 : H12AffineEnvironment.transform 31 341 env278 = env279 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 341 env278 == env279) = true)

theorem identity279 : scanCanonicalize (H12AffineFastState.compose env279 (packedSelected [2,23,32] rootPS)) = affineNative (2^(15+1) ^^^ 37942) := by decide +kernel

theorem selectedBound279 : packedSelected [2,23,32] rootPS < 2^1333 := by decide +kernel

def env280 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4177,32768,37942,1345,262144,1025,32768,4096,136,5457,5426,8329,5377,262540,4176,1296,7221,1285,341,257,5189,1345,136]

theorem envBound280 : H12AffineFastState.Bounded env280 := by
  intro p hp
  have h : env280.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans279_280 : H12AffineEnvironment.transform 15 37942 env279 = env280 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 37942 env279 == env280) = true)

def env281 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4177,8200,13374,1345,262144,1025,8200,4096,136,5457,5426,8329,5377,262540,4176,1296,7221,1285,341,257,5189,1345,136]

theorem envBound281 : H12AffineFastState.Bounded env281 := by
  intro p hp
  have h : env281.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans280_281 : H12AffineEnvironment.transform 14 8200 env280 = env281 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8200 env280 == env281) = true)

theorem identity281 : scanCanonicalize (H12AffineFastState.compose env281 (packedSelected [6] rootPS)) = affineNative (2^(17+1) ^^^ 4534) := by decide +kernel

theorem selectedBound281 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env282 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4177,8200,13374,1345,4534,1025,8200,4096,136,5457,5426,8329,5377,4154,4176,1296,7221,1285,341,257,5189,1345,136]

theorem envBound282 : H12AffineFastState.Bounded env282 := by
  intro p hp
  have h : env282.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans281_282 : H12AffineEnvironment.transform 17 4534 env281 = env282 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 4534 env281 == env282) = true)

def env283 : List Nat := [2,4,8,16,32,64,128,140,137,1024,2048,4096,8192,4177,8200,13374,1229,4154,1025,8200,4096,136,5341,5310,8329,5261,4154,4176,1180,7221,1161,217,141,5189,1229,136]

theorem envBound283 : H12AffineFastState.Bounded env283 := by
  intro p hp
  have h : env283.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans282_283 : H12AffineEnvironment.transform 7 140 env282 = env283 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 140 env282 == env283) = true)

theorem identity283 : scanCanonicalize (H12AffineFastState.compose env283 (packedSelected [7] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound283 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env284 : List Nat := [2,4,8,16,32,64,9,5,0,1024,2048,4096,8192,4177,8200,13374,1092,4154,1025,8200,4096,1,5204,5175,8192,5124,4154,4176,1045,7221,1024,80,4,5189,1092,1]

theorem envBound284 : H12AffineFastState.Bounded env284 := by
  intro p hp
  have h : env284.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans283_284 : H12AffineEnvironment.transform 6 9 env283 = env284 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env283 == env284) = true)

theorem identity284 : scanCanonicalize (H12AffineFastState.compose env284 (packedSelected [1,8,12] rootPS)) = affineNative (2^(11+1) ^^^ 1045) := by decide +kernel

theorem selectedBound284 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env285 : List Nat := [2,4,8,16,32,64,9,5,0,1024,2048,1045,8192,1092,8200,8235,1092,1071,1025,8200,1045,1,65,34,8192,17,1071,1093,1045,2080,1024,80,4,80,1092,1]

theorem envBound285 : H12AffineFastState.Bounded env285 := by
  intro p hp
  have h : env285.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans284_285 : H12AffineEnvironment.transform 11 1045 env284 = env285 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1045 env284 == env285) = true)

theorem identity285 : scanCanonicalize (H12AffineFastState.compose env285 (packedSelected [1,3,5] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound285 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env286 : List Nat := [2,4,8,16,1,64,9,5,0,1024,2048,1045,8192,1092,8200,8202,1092,1038,1025,8200,1045,1,65,3,8192,17,1038,1093,1045,2049,1024,80,4,80,1092,1]

theorem envBound286 : H12AffineFastState.Bounded env286 := by
  intro p hp
  have h : env286.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans285_286 : H12AffineEnvironment.transform 4 1 env285 = env286 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env285 == env286) = true)

theorem identity286 : scanCanonicalize (H12AffineFastState.compose env286 (packedSelected [0] rootPS)) = affineNative (2^(12+1) ^^^ 1030) := by decide +kernel

theorem selectedBound286 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env287 : List Nat := [2,4,8,16,1,64,9,5,0,1024,2048,1045,1030,1092,1038,1036,1092,1038,1025,1038,1045,1,65,3,1030,17,1038,1093,1045,2049,1024,80,4,80,1092,1]

theorem envBound287 : H12AffineFastState.Bounded env287 := by
  intro p hp
  have h : env287.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans286_287 : H12AffineEnvironment.transform 12 1030 env286 = env287 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1030 env286 == env287) = true)

theorem identity287 : scanCanonicalize (H12AffineFastState.compose env287 (packedSelected [2] rootPS)) = affineNative (2^(10+1) ^^^ 1039) := by decide +kernel

theorem selectedBound287 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env288 : List Nat := [2,4,8,16,1,64,9,5,0,1024,1039,1045,1030,1092,1038,1036,1092,1038,1025,1038,1045,1,65,3,1030,17,1038,1093,1045,1038,1024,80,4,80,1092,1]

theorem envBound288 : H12AffineFastState.Bounded env288 := by
  intro p hp
  have h : env288.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans287_288 : H12AffineEnvironment.transform 10 1039 env287 = env288 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1039 env287 == env288) = true)

def env289 : List Nat := [2,4,8,16,32,64,128,141,137,1024,2048,4096,8192,4177,8200,13374,1228,4155,1025,8200,4096,136,5340,5311,8329,5260,4154,4176,1181,7221,1160,216,140,5189,1228,136]

theorem envBound289 : H12AffineFastState.Bounded env289 := by
  intro p hp
  have h : env289.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans282_289 : H12AffineEnvironment.transform 7 141 env282 = env289 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 141 env282 == env289) = true)

theorem identity289 : scanCanonicalize (H12AffineFastState.compose env289 (packedSelected [7] rootPS)) = affineNative (2^(12+1) ^^^ 4146) := by decide +kernel

theorem selectedBound289 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env290 : List Nat := [2,4,8,16,32,64,128,141,137,1024,2048,4096,4146,4177,4154,1036,1228,4155,1025,4154,4096,136,5340,5311,4283,5260,4154,4176,1181,7221,1160,216,140,5189,1228,136]

theorem envBound290 : H12AffineFastState.Bounded env290 := by
  intro p hp
  have h : env290.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans289_290 : H12AffineEnvironment.transform 12 4146 env289 = env290 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4146 env289 == env290) = true)

theorem identity290 : scanCanonicalize (H12AffineFastState.compose env290 (packedSelected [0,1,2,3,4,8,11] rootPS)) = affineNative (2^(10+1) ^^^ 1070) := by decide +kernel

theorem selectedBound290 : packedSelected [0,1,2,3,4,8,11] rootPS < 2^1333 := by decide +kernel

def env291 : List Nat := [2,4,8,16,32,64,128,141,137,1024,1070,4096,4146,4177,4154,1036,1228,4155,1025,4154,4096,136,5340,5311,4283,5260,4154,4176,1181,4123,1160,216,140,5189,1228,136]

theorem envBound291 : H12AffineFastState.Bounded env291 := by
  intro p hp
  have h : env291.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans290_291 : H12AffineEnvironment.transform 10 1070 env290 = env291 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1070 env290 == env291) = true)

theorem identity291 : scanCanonicalize (H12AffineFastState.compose env291 (packedSelected [0,1,2,3,5] rootPS)) = affineNative (2^(11+1) ^^^ 1077) := by decide +kernel

theorem selectedBound291 : packedSelected [0,1,2,3,5] rootPS < 2^1333 := by decide +kernel

def env292 : List Nat := [2,4,8,16,32,64,128,141,137,1024,1070,1077,1031,1124,1039,1036,1228,1038,1025,1039,1077,136,233,138,1166,185,1039,1125,1181,1070,1160,216,140,112,1228,136]

theorem envBound292 : H12AffineFastState.Bounded env292 := by
  intro p hp
  have h : env292.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans291_292 : H12AffineEnvironment.transform 11 1077 env291 = env292 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1077 env291 == env292) = true)

theorem identity292 : scanCanonicalize (H12AffineFastState.compose env292 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound292 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env293 : List Nat := [2,4,8,16,32,64,9,4,0,1024,1070,1077,1031,1124,1039,1036,1093,1038,1025,1039,1077,1,96,3,1031,48,1039,1125,1044,1070,1025,81,5,112,1093,1]

theorem envBound293 : H12AffineFastState.Bounded env293 := by
  intro p hp
  have h : env293.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans292_293 : H12AffineEnvironment.transform 6 9 env292 = env293 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env292 == env293) = true)

theorem identity293 : scanCanonicalize (H12AffineFastState.compose env293 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 48) := by decide +kernel

theorem selectedBound293 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env294 : List Nat := [2,4,8,16,32,48,9,4,0,1024,1070,1077,1031,1044,1039,1036,1077,1038,1025,1039,1077,1,16,3,1031,48,1039,1045,1044,1070,1025,33,5,0,1077,1]

theorem envBound294 : H12AffineFastState.Bounded env294 := by
  intro p hp
  have h : env294.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans293_294 : H12AffineEnvironment.transform 5 48 env293 = env294 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 48 env293 == env294) = true)

def leafEnv294 : List Nat := [2,4,8,16,32,48,9,4,0,1024,1070,1077,1031,1044,1039,1036,1077,1038,1025,1039,1077,1,16,3,1025,1031,1,48,1039,1045,1044,1070,1025,33,5,0,4,1036,1077,1,0,1045,1]

def active294 : List Nat := [0,1,2,3,4,9]

def tree294 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood294 : H12WitnessSearch.Good tree294 := H12GlobalWitnessIndex.good

theorem leafIdentity294 : H12AffineFastState.composeSystem env294 rootObs = leafEnv294 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env294 rootObs == leafEnv294) = true)

theorem terminalChecked294 : H12PackedTerminal.terminalCheckFast leafEnv294 active294 tree294 = true := by decide +kernel

def env295 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4177,8201,13375,1345,262144,1025,8201,4096,136,5457,5426,8329,5377,262540,4176,1296,7221,1285,341,257,5189,1345,136]

theorem envBound295 : H12AffineFastState.Bounded env295 := by
  intro p hp
  have h : env295.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans280_295 : H12AffineEnvironment.transform 14 8201 env280 = env295 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8201 env280 == env295) = true)

theorem identity295 : scanCanonicalize (H12AffineFastState.compose env295 (packedSelected [6] rootPS)) = affineNative (2^(17+1) ^^^ 4274) := by decide +kernel

theorem selectedBound295 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env296 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4177,8201,13375,1345,4274,1025,8201,4096,136,5457,5426,8329,5377,4414,4176,1296,7221,1285,341,257,5189,1345,136]

theorem envBound296 : H12AffineFastState.Bounded env296 := by
  intro p hp
  have h : env296.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans295_296 : H12AffineEnvironment.transform 17 4274 env295 = env296 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 4274 env295 == env296) = true)

def env297 : List Nat := [2,4,8,16,32,64,128,140,137,1024,2048,4096,8192,4177,8201,13375,1229,4274,1025,8201,4096,136,5341,5310,8329,5261,4274,4176,1180,7221,1161,217,141,5189,1229,136]

theorem envBound297 : H12AffineFastState.Bounded env297 := by
  intro p hp
  have h : env297.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans296_297 : H12AffineEnvironment.transform 7 140 env296 = env297 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 140 env296 == env297) = true)

theorem identity297 : scanCanonicalize (H12AffineFastState.compose env297 (packedSelected [7] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound297 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env298 : List Nat := [2,4,8,16,32,64,9,5,0,1024,2048,4096,8192,4177,8201,13375,1092,4155,1025,8201,4096,1,5204,5175,8192,5124,4155,4176,1045,7221,1024,80,4,5189,1092,1]

theorem envBound298 : H12AffineFastState.Bounded env298 := by
  intro p hp
  have h : env298.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans297_298 : H12AffineEnvironment.transform 6 9 env297 = env298 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env297 == env298) = true)

theorem identity298 : scanCanonicalize (H12AffineFastState.compose env298 (packedSelected [1,8,12] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound298 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env299 : List Nat := [2,4,8,16,32,17,9,5,0,1024,2048,4096,8192,4096,8201,13375,1045,4155,1025,8201,4096,1,5125,5175,8192,5124,4155,4097,1045,7221,1024,1,4,5140,1045,1]

theorem envBound299 : H12AffineFastState.Bounded env299 := by
  intro p hp
  have h : env299.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans298_299 : H12AffineEnvironment.transform 5 17 env298 = env299 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env298 == env299) = true)

theorem identity299 : scanCanonicalize (H12AffineFastState.compose env299 (packedSelected [2,5,8,11,18] rootPS)) = affineNative (2^(11+1) ^^^ 1076) := by decide +kernel

theorem selectedBound299 : packedSelected [2,5,8,11,18] rootPS < 2^1333 := by decide +kernel

def env300 : List Nat := [2,4,8,16,32,17,9,5,0,1024,2048,1076,8192,1076,8201,8203,1045,1039,1025,8201,1076,1,49,3,8192,48,1039,1077,1045,2049,1024,1,4,32,1045,1]

theorem envBound300 : H12AffineFastState.Bounded env300 := by
  intro p hp
  have h : env300.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans299_300 : H12AffineEnvironment.transform 11 1076 env299 = env300 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1076 env299 == env300) = true)

theorem identity300 : scanCanonicalize (H12AffineFastState.compose env300 (packedSelected [0] rootPS)) = affineNative (2^(12+1) ^^^ 1063) := by decide +kernel

theorem selectedBound300 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env301 : List Nat := [2,4,8,16,32,17,9,5,0,1024,2048,1076,1063,1076,1070,1068,1045,1039,1025,1070,1076,1,49,3,1063,48,1039,1077,1045,2049,1024,1,4,32,1045,1]

theorem envBound301 : H12AffineFastState.Bounded env301 := by
  intro p hp
  have h : env301.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans300_301 : H12AffineEnvironment.transform 12 1063 env300 = env301 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1063 env300 == env301) = true)

theorem identity301 : scanCanonicalize (H12AffineFastState.compose env301 (packedSelected [2] rootPS)) = affineNative (2^(10+1) ^^^ 1070) := by decide +kernel

theorem selectedBound301 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env302 : List Nat := [2,4,8,16,32,17,9,5,0,1024,1070,1076,1063,1076,1070,1068,1045,1039,1025,1070,1076,1,49,3,1063,48,1039,1077,1045,1071,1024,1,4,32,1045,1]

theorem envBound302 : H12AffineFastState.Bounded env302 := by
  intro p hp
  have h : env302.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans301_302 : H12AffineEnvironment.transform 10 1070 env301 = env302 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1070 env301 == env302) = true)

def env303 : List Nat := [2,4,8,16,32,64,128,141,137,1024,2048,4096,8192,4177,8201,13375,1228,4274,1025,8201,4096,136,5340,5311,8329,5260,4275,4176,1181,7221,1160,216,140,5189,1228,136]

theorem envBound303 : H12AffineFastState.Bounded env303 := by
  intro p hp
  have h : env303.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans296_303 : H12AffineEnvironment.transform 7 141 env296 = env303 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 141 env296 == env303) = true)

theorem identity303 : scanCanonicalize (H12AffineFastState.compose env303 (packedSelected [7] rootPS)) = affineNative (2^(12+1) ^^^ 4283) := by decide +kernel

theorem selectedBound303 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env304 : List Nat := [2,4,8,16,32,64,128,141,137,1024,2048,4096,4283,4177,4274,1156,1228,4274,1025,4274,4096,136,5340,5311,4146,5260,4275,4176,1181,7221,1160,216,140,5189,1228,136]

theorem envBound304 : H12AffineFastState.Bounded env304 := by
  intro p hp
  have h : env304.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans303_304 : H12AffineEnvironment.transform 12 4283 env303 = env304 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4283 env303 == env304) = true)

def env305 : List Nat := [2,4,8,16,32,64,128,141,137,1024,0,4096,4283,4177,4274,1156,1228,4274,1025,4274,4096,136,5340,5311,4146,5260,4275,4176,1181,5173,1160,216,140,5189,1228,136]

theorem envBound305 : H12AffineFastState.Bounded env305 := by
  intro p hp
  have h : env305.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans304_305 : H12AffineEnvironment.transform 10 0 env304 = env305 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env304 == env305) = true)

theorem identity305 : scanCanonicalize (H12AffineFastState.compose env305 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 47) := by decide +kernel

theorem selectedBound305 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env306 : List Nat := [2,4,8,16,32,64,128,141,137,47,0,4096,4283,4177,4274,171,227,4274,46,4274,4096,136,4339,4240,4146,4259,4275,4176,178,4122,167,216,140,4202,227,136]

theorem envBound306 : H12AffineFastState.Bounded env306 := by
  intro p hp
  have h : env306.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans305_306 : H12AffineEnvironment.transform 9 47 env305 = env306 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 47 env305 == env306) = true)

theorem identity306 : scanCanonicalize (H12AffineFastState.compose env306 (packedSelected [2,4] rootPS)) = affineNative (2^(11+1) ^^^ 147) := by decide +kernel

theorem selectedBound306 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env307 : List Nat := [2,4,8,16,32,64,128,141,137,47,0,147,40,194,33,171,227,33,46,33,147,136,96,3,161,48,32,195,178,137,167,216,140,249,227,136]

theorem envBound307 : H12AffineFastState.Bounded env307 := by
  intro p hp
  have h : env307.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans306_307 : H12AffineEnvironment.transform 11 147 env306 = env307 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 147 env306 == env307) = true)

theorem identity307 : scanCanonicalize (H12AffineFastState.compose env307 (packedSelected [3,5] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound307 : packedSelected [3,5] rootPS < 2^1333 := by decide +kernel

def env308 : List Nat := [2,4,8,16,32,64,9,4,0,47,0,26,40,75,33,34,106,33,46,33,26,1,96,3,40,48,32,74,59,0,46,81,5,112,106,1]

theorem envBound308 : H12AffineFastState.Bounded env308 := by
  intro p hp
  have h : env308.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans307_308 : H12AffineEnvironment.transform 6 9 env307 = env308 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env307 == env308) = true)

def leafEnv308 : List Nat := [2,4,8,16,32,64,9,4,0,47,0,26,40,75,33,34,106,33,46,33,26,1,96,3,46,40,1,48,32,74,59,0,46,81,5,112,4,34,106,1,0,58,1]

def active308 : List Nat := [0,1,2,3,4,5]

def tree308 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood308 : H12WitnessSearch.Good tree308 := H12GlobalWitnessIndex.good

theorem leafIdentity308 : H12AffineFastState.composeSystem env308 rootObs = leafEnv308 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env308 rootObs == leafEnv308) = true)

theorem terminalChecked308 : H12PackedTerminal.terminalCheckFast leafEnv308 active308 tree308 = true := by decide +kernel

def env309 : List Nat := [2,4,8,16,32,64,128,141,137,1024,1,4096,4283,4177,4274,1156,1228,4274,1025,4274,4096,136,5340,5311,4146,5260,4275,4176,1181,5172,1160,216,140,5189,1228,136]

theorem envBound309 : H12AffineFastState.Bounded env309 := by
  intro p hp
  have h : env309.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans304_309 : H12AffineEnvironment.transform 10 1 env304 = env309 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env304 == env309) = true)

theorem identity309 : scanCanonicalize (H12AffineFastState.compose env309 (packedSelected [0] rootPS)) = affineNative (2^(11+1) ^^^ 27) := by decide +kernel

theorem selectedBound309 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env310 : List Nat := [2,4,8,16,32,64,128,141,137,1024,1,27,160,74,169,1156,1228,169,1025,169,27,136,1223,1188,41,1175,168,75,1181,1071,1160,216,140,1118,1228,136]

theorem envBound310 : H12AffineFastState.Bounded env310 := by
  intro p hp
  have h : env310.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans309_310 : H12AffineEnvironment.transform 11 27 env309 = env310 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 27 env309 == env310) = true)

theorem identity310 : scanCanonicalize (H12AffineFastState.compose env310 (packedSelected [4] rootPS)) = affineNative (2^(9+1) ^^^ 46) := by decide +kernel

theorem selectedBound310 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env311 : List Nat := [2,4,8,16,32,64,128,141,137,46,1,27,160,74,169,170,226,169,47,169,27,136,233,138,41,185,168,75,179,1,166,216,140,112,226,136]

theorem envBound311 : H12AffineFastState.Bounded env311 := by
  intro p hp
  have h : env311.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans310_311 : H12AffineEnvironment.transform 9 46 env310 = env311 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 46 env310 == env311) = true)

theorem identity311 : scanCanonicalize (H12AffineFastState.compose env311 (packedSelected [5,8] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound311 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env312 : List Nat := [2,4,8,16,32,64,9,4,0,46,1,27,41,74,32,35,107,32,47,32,27,1,96,3,41,48,33,75,58,1,47,81,5,112,107,1]

theorem envBound312 : H12AffineFastState.Bounded env312 := by
  intro p hp
  have h : env312.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans311_312 : H12AffineEnvironment.transform 6 9 env311 = env312 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env311 == env312) = true)

def leafEnv312 : List Nat := [2,4,8,16,32,64,9,4,0,46,1,27,41,74,32,35,107,32,47,32,27,1,96,3,47,41,1,48,33,75,58,1,47,81,5,112,4,35,107,1,0,59,1]

def active312 : List Nat := [0,1,2,3,4,5]

def tree312 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood312 : H12WitnessSearch.Good tree312 := H12GlobalWitnessIndex.good

theorem leafIdentity312 : H12AffineFastState.composeSystem env312 rootObs = leafEnv312 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env312 rootObs == leafEnv312) = true)

theorem terminalChecked312 : H12PackedTerminal.terminalCheckFast leafEnv312 active312 tree312 = true := by decide +kernel

def env313 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4824,32768,65536,1345,262144,1673,32768,4096,4194304,6104,98564,8329,5377,4457357,4825,1296,1073741824,1285,4294967296,257,4299260335,1345,513]

theorem envBound313 : H12AffineFastState.Bounded env313 := by
  intro p hp
  have h : env313.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans274_313 : H12AffineEnvironment.transform 18 1673 env274 = env313 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1673 env274 == env313) = true)

theorem identity313 : scanCanonicalize (H12AffineFastState.compose env313 (packedSelected [1,12,13] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound313 : packedSelected [1,12,13] rootPS < 2^1333 := by decide +kernel

def env314 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4824,32768,65536,1093,262144,1673,32768,4096,4194304,5852,98304,8329,5125,4457097,4825,1044,1073741824,1025,4294967296,5,4299260075,1093,513]

theorem envBound314 : H12AffineFastState.Bounded env314 := by
  intro p hp
  have h : env314.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans313_314 : H12AffineEnvironment.transform 7 4 env313 = env314 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env313 == env314) = true)

theorem identity314 : scanCanonicalize (H12AffineFastState.compose env314 (packedSelected [4,9,16] rootPS)) = affineNative (2^(29+1) ^^^ 4294795) := by decide +kernel

theorem selectedBound314 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env315 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4824,32768,65536,1093,262144,1673,32768,4096,4194304,5852,98304,8329,5125,4457097,4825,1044,4294795,1025,4294967296,5,4299260075,1093,513]

theorem envBound315 : H12AffineFastState.Bounded env315 := by
  intro p hp
  have h : env315.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans314_315 : H12AffineEnvironment.transform 29 4294795 env314 = env315 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4294795 env314 == env315) = true)

theorem identity315 : scanCanonicalize (H12AffineFastState.compose env315 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound315 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env316 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,4096,8192,4177,32768,65536,1093,262144,1024,32768,4096,4194304,5205,98304,8329,5125,4456448,4176,1044,4294795,1025,4294967296,5,4299260075,1093,136]

theorem envBound316 : H12AffineFastState.Bounded env316 := by
  intro p hp
  have h : env316.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans315_316 : H12AffineEnvironment.transform 8 137 env315 = env316 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env315 == env316) = true)

theorem identity316 : scanCanonicalize (H12AffineFastState.compose env316 (packedSelected [3,5,10] rootPS)) = affineNative (2^(31+1) ^^^ 4235472) := by decide +kernel

theorem selectedBound316 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env317 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,4096,8192,4177,32768,65536,1093,262144,1024,32768,4096,4194304,5205,98304,8329,5125,4456448,4176,1044,4294795,1025,4235472,5,73851,1093,136]

theorem envBound317 : H12AffineFastState.Bounded env317 := by
  intro p hp
  have h : env317.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans316_317 : H12AffineEnvironment.transform 31 4235472 env316 = env317 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4235472 env316 == env317) = true)

theorem identity317 : scanCanonicalize (H12AffineFastState.compose env317 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(21+1) ^^^ 79031) := by decide +kernel

theorem selectedBound317 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env318 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,4096,8192,4177,32768,65536,1093,262144,1024,32768,4096,79031,5205,98304,8329,5125,341175,4176,1044,48188,1025,103527,5,73851,1093,136]

theorem envBound318 : H12AffineFastState.Bounded env318 := by
  intro p hp
  have h : env318.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans317_318 : H12AffineEnvironment.transform 21 79031 env317 = env318 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 79031 env317 == env318) = true)

def env319 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,4096,8192,4177,8200,65536,1093,262144,1024,8200,4096,79031,5205,73736,8329,5125,341175,4176,1044,7220,1025,78959,5,73851,1093,136]

theorem envBound319 : H12AffineFastState.Bounded env319 := by
  intro p hp
  have h : env319.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans318_319 : H12AffineEnvironment.transform 14 8200 env318 = env319 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8200 env318 == env319) = true)

theorem identity319 : scanCanonicalize (H12AffineFastState.compose env319 (packedSelected [6] rootPS)) = affineNative (2^(17+1) ^^^ 74892) := by decide +kernel

theorem selectedBound319 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env320 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,4096,8192,4177,8200,65536,1093,74892,1024,8200,4096,79031,5205,73736,8329,5125,4155,4176,1044,7220,1025,78959,5,73851,1093,136]

theorem envBound320 : H12AffineFastState.Bounded env320 := by
  intro p hp
  have h : env320.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans319_320 : H12AffineEnvironment.transform 17 74892 env319 = env320 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 74892 env319 == env320) = true)

def env321 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,4096,8192,4177,8200,1156,1093,8200,1024,8200,4096,12339,5205,9356,8329,5125,4155,4176,1044,7220,1025,12523,5,9471,1093,136]

theorem envBound321 : H12AffineFastState.Bounded env321 := by
  intro p hp
  have h : env321.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans320_321 : H12AffineEnvironment.transform 15 1156 env320 = env321 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 1156 env320 == env321) = true)

def env322 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,4096,8192,4177,8200,1157,1093,8201,1024,8200,4096,12338,5205,9357,8329,5125,4155,4176,1044,7220,1025,12522,5,9470,1093,136]

theorem envBound322 : H12AffineFastState.Bounded env322 := by
  intro p hp
  have h : env322.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans320_322 : H12AffineEnvironment.transform 15 1157 env320 = env322 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 1157 env320 == env322) = true)

theorem identity322 : scanCanonicalize (H12AffineFastState.compose env322 (packedSelected [7] rootPS)) = affineNative (2^(12+1) ^^^ 4147) := by decide +kernel

theorem selectedBound322 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env323 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,4096,4147,4177,4155,1157,1093,4154,1024,4155,4096,1,5205,5310,4282,5125,4155,4176,1044,7220,1025,217,5,5325,1093,136]

theorem envBound323 : H12AffineFastState.Bounded env323 := by
  intro p hp
  have h : env323.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans322_323 : H12AffineEnvironment.transform 12 4147 env322 = env323 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4147 env322 == env323) = true)

def env324 : List Nat := [2,4,8,16,32,64,128,4,137,1024,0,4096,4147,4177,4155,1157,1093,4154,1024,4155,4096,1,5205,5310,4282,5125,4155,4176,1044,5172,1025,217,5,5325,1093,136]

theorem envBound324 : H12AffineFastState.Bounded env324 := by
  intro p hp
  have h : env324.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans323_324 : H12AffineEnvironment.transform 10 0 env323 = env324 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env323 == env324) = true)

theorem identity324 : scanCanonicalize (H12AffineFastState.compose env324 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 46) := by decide +kernel

theorem selectedBound324 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env325 : List Nat := [2,4,8,16,32,64,128,4,137,46,0,4096,4147,4177,4155,171,107,4154,46,4155,4096,1,4219,4240,4282,4139,4155,4176,58,4122,47,217,5,4323,107,136]

theorem envBound325 : H12AffineFastState.Bounded env325 := by
  intro p hp
  have h : env325.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans324_325 : H12AffineEnvironment.transform 9 46 env324 = env325 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 46 env324 == env325) = true)

theorem identity325 : scanCanonicalize (H12AffineFastState.compose env325 (packedSelected [2,4] rootPS)) = affineNative (2^(11+1) ^^^ 26) := by decide +kernel

theorem selectedBound325 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env326 : List Nat := [2,4,8,16,32,64,128,4,137,46,0,26,41,75,33,171,107,32,46,33,26,1,97,138,160,49,33,74,58,0,47,217,5,249,107,136]

theorem envBound326 : H12AffineFastState.Bounded env326 := by
  intro p hp
  have h : env326.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans325_326 : H12AffineEnvironment.transform 11 26 env325 = env326 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 26 env325 == env326) = true)

def env327 : List Nat := [2,4,8,16,0,64,128,4,137,14,0,26,9,75,1,139,75,0,14,1,26,1,65,138,128,17,1,74,26,0,15,217,5,217,75,136]

theorem envBound327 : H12AffineFastState.Bounded env327 := by
  intro p hp
  have h : env327.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans326_327 : H12AffineEnvironment.transform 4 0 env326 = env327 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env326 == env327) = true)

theorem identity327 : scanCanonicalize (H12AffineFastState.compose env327 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound327 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env328 : List Nat := [2,4,8,16,0,16,128,4,137,14,0,26,9,27,1,139,27,0,14,1,26,1,17,138,128,17,1,26,26,0,15,137,5,137,27,136]

theorem envBound328 : H12AffineFastState.Bounded env328 := by
  intro p hp
  have h : env328.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans327_328 : H12AffineEnvironment.transform 5 16 env327 = env328 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env327 == env328) = true)

def leafEnv328 : List Nat := [2,4,8,16,0,16,128,4,137,14,0,26,9,27,1,139,27,0,14,1,26,1,17,138,14,128,1,17,1,26,26,0,15,137,5,137,4,2,27,136,0,27,1]

def active328 : List Nat := [0,1,2,3,6]

def tree328 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood328 : H12WitnessSearch.Good tree328 := H12GlobalWitnessIndex.good

theorem leafIdentity328 : H12AffineFastState.composeSystem env328 rootObs = leafEnv328 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env328 rootObs == leafEnv328) = true)

theorem terminalChecked328 : H12PackedTerminal.terminalCheckFast leafEnv328 active328 tree328 = true := by decide +kernel

def env329 : List Nat := [2,4,8,16,1,64,128,4,137,15,0,26,8,75,0,138,74,1,15,0,26,1,64,138,129,16,0,74,27,0,14,217,5,216,74,136]

theorem envBound329 : H12AffineFastState.Bounded env329 := by
  intro p hp
  have h : env329.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans326_329 : H12AffineEnvironment.transform 4 1 env326 = env329 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env326 == env329) = true)

theorem identity329 : scanCanonicalize (H12AffineFastState.compose env329 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound329 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env330 : List Nat := [2,4,8,16,1,64,88,4,81,15,0,26,8,75,0,82,74,1,15,0,26,1,64,82,89,16,0,74,27,0,14,1,5,0,74,80]

theorem envBound330 : H12AffineFastState.Bounded env330 := by
  intro p hp
  have h : env330.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans329_330 : H12AffineEnvironment.transform 6 88 env329 = env330 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env329 == env330) = true)

def leafEnv330 : List Nat := [2,4,8,16,1,64,88,4,81,15,0,26,8,75,0,82,74,1,15,0,26,1,64,82,15,89,1,16,0,74,27,0,14,1,5,0,4,3,74,80,0,26,1]

def active330 : List Nat := [0,1,2,3,5]

def tree330 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood330 : H12WitnessSearch.Good tree330 := H12GlobalWitnessIndex.good

theorem leafIdentity330 : H12AffineFastState.composeSystem env330 rootObs = leafEnv330 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env330 rootObs == leafEnv330) = true)

theorem terminalChecked330 : H12PackedTerminal.terminalCheckFast leafEnv330 active330 tree330 = true := by decide +kernel

def env331 : List Nat := [2,4,8,16,32,64,128,4,137,1024,1,4096,4147,4177,4155,1157,1093,4154,1024,4155,4096,1,5205,5310,4282,5125,4155,4176,1044,5173,1025,217,5,5325,1093,136]

theorem envBound331 : H12AffineFastState.Bounded env331 := by
  intro p hp
  have h : env331.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans323_331 : H12AffineEnvironment.transform 10 1 env323 = env331 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env323 == env331) = true)

theorem identity331 : scanCanonicalize (H12AffineFastState.compose env331 (packedSelected [0] rootPS)) = affineNative (2^(11+1) ^^^ 27) := by decide +kernel

theorem selectedBound331 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env332 : List Nat := [2,4,8,16,32,64,128,4,137,1024,1,27,40,74,32,1157,1093,33,1024,32,27,1,1102,1189,161,1054,32,75,1044,1070,1025,217,5,1238,1093,136]

theorem envBound332 : H12AffineFastState.Bounded env332 := by
  intro p hp
  have h : env332.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans331_332 : H12AffineEnvironment.transform 11 27 env331 = env332 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 27 env331 == env332) = true)

theorem identity332 : scanCanonicalize (H12AffineFastState.compose env332 (packedSelected [1,3,5] rootPS)) = affineNative (2^(9+1) ^^^ 47) := by decide +kernel

theorem selectedBound332 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env333 : List Nat := [2,4,8,16,32,64,128,4,137,47,1,27,40,74,32,170,106,33,47,32,27,1,97,138,161,49,32,75,59,1,46,217,5,249,106,136]

theorem envBound333 : H12AffineFastState.Bounded env333 := by
  intro p hp
  have h : env333.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans332_333 : H12AffineEnvironment.transform 9 47 env332 = env333 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 47 env332 == env333) = true)

def env334 : List Nat := [2,4,8,16,0,64,128,4,137,15,1,27,8,74,0,138,74,1,15,0,27,1,65,138,129,17,0,75,27,1,14,217,5,217,74,136]

theorem envBound334 : H12AffineFastState.Bounded env334 := by
  intro p hp
  have h : env334.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans333_334 : H12AffineEnvironment.transform 4 0 env333 = env334 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env333 == env334) = true)

theorem identity334 : scanCanonicalize (H12AffineFastState.compose env334 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound334 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env335 : List Nat := [2,4,8,16,0,16,128,4,137,15,1,27,8,26,0,138,26,1,15,0,27,1,17,138,129,17,0,27,27,1,14,137,5,137,26,136]

theorem envBound335 : H12AffineFastState.Bounded env335 := by
  intro p hp
  have h : env335.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans334_335 : H12AffineEnvironment.transform 5 16 env334 = env335 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env334 == env335) = true)

def leafEnv335 : List Nat := [2,4,8,16,0,16,128,4,137,15,1,27,8,26,0,138,26,1,15,0,27,1,17,138,15,129,1,17,0,27,27,1,14,137,5,137,4,3,26,136,0,26,1]

def active335 : List Nat := [0,1,2,3,6]

def tree335 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood335 : H12WitnessSearch.Good tree335 := H12GlobalWitnessIndex.good

theorem leafIdentity335 : H12AffineFastState.composeSystem env335 rootObs = leafEnv335 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env335 rootObs == leafEnv335) = true)

theorem terminalChecked335 : H12PackedTerminal.terminalCheckFast leafEnv335 active335 tree335 = true := by decide +kernel

def env336 : List Nat := [2,4,8,16,1,64,128,4,137,14,1,27,9,74,1,139,75,0,14,1,27,1,64,138,128,16,1,75,26,1,15,217,5,216,75,136]

theorem envBound336 : H12AffineFastState.Bounded env336 := by
  intro p hp
  have h : env336.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans333_336 : H12AffineEnvironment.transform 4 1 env333 = env336 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env333 == env336) = true)

theorem identity336 : scanCanonicalize (H12AffineFastState.compose env336 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound336 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env337 : List Nat := [2,4,8,16,1,64,88,4,81,14,1,27,9,74,1,83,75,0,14,1,27,1,64,82,88,16,1,75,26,1,15,1,5,0,75,80]

theorem envBound337 : H12AffineFastState.Bounded env337 := by
  intro p hp
  have h : env337.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans336_337 : H12AffineEnvironment.transform 6 88 env336 = env337 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env336 == env337) = true)

def leafEnv337 : List Nat := [2,4,8,16,1,64,88,4,81,14,1,27,9,74,1,83,75,0,14,1,27,1,64,82,14,88,1,16,1,75,26,1,15,1,5,0,4,2,75,80,0,27,1]

def active337 : List Nat := [0,1,2,3,5]

def tree337 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood337 : H12WitnessSearch.Good tree337 := H12GlobalWitnessIndex.good

theorem leafIdentity337 : H12AffineFastState.composeSystem env337 rootObs = leafEnv337 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env337 rootObs == leafEnv337) = true)

theorem terminalChecked337 : H12PackedTerminal.terminalCheckFast leafEnv337 active337 tree337 = true := by decide +kernel

def env338 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,4096,8192,4177,8201,65536,1093,262144,1024,8201,4096,79031,5205,73737,8329,5125,341175,4176,1044,7221,1025,78958,5,73851,1093,136]

theorem envBound338 : H12AffineFastState.Bounded env338 := by
  intro p hp
  have h : env338.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans318_338 : H12AffineEnvironment.transform 14 8201 env318 = env338 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8201 env318 == env338) = true)

theorem identity338 : scanCanonicalize (H12AffineFastState.compose env338 (packedSelected [6] rootPS)) = affineNative (2^(17+1) ^^^ 4274) := by decide +kernel

theorem selectedBound338 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env339 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,4096,8192,4177,8201,65536,1093,4274,1024,8201,4096,79031,5205,73737,8329,5125,74757,4176,1044,7221,1025,78958,5,73851,1093,136]

theorem envBound339 : H12AffineFastState.Bounded env339 := by
  intro p hp
  have h : env339.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans338_339 : H12AffineEnvironment.transform 17 4274 env338 = env339 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 4274 env338 == env339) = true)

def env340 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,4096,8192,4177,8201,1036,1093,4274,1024,8201,4096,12475,5205,9221,8329,5125,8201,4176,1044,7221,1025,12386,5,9335,1093,136]

theorem envBound340 : H12AffineFastState.Bounded env340 := by
  intro p hp
  have h : env340.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans339_340 : H12AffineEnvironment.transform 15 1036 env339 = env340 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 1036 env339 == env340) = true)

def env341 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,4096,8192,4177,8201,1037,1093,4274,1024,8201,4096,12474,5205,9220,8329,5125,8200,4176,1044,7221,1025,12387,5,9334,1093,136]

theorem envBound341 : H12AffineFastState.Bounded env341 := by
  intro p hp
  have h : env341.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans339_341 : H12AffineEnvironment.transform 15 1037 env339 = env341 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 1037 env339 == env341) = true)

theorem identity341 : scanCanonicalize (H12AffineFastState.compose env341 (packedSelected [7] rootPS)) = affineNative (2^(12+1) ^^^ 4283) := by decide +kernel

theorem selectedBound341 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env342 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,4096,4283,4177,4274,1037,1093,4274,1024,4274,4096,1,5205,5311,4146,5125,4275,4176,1044,7221,1025,216,5,5325,1093,136]

theorem envBound342 : H12AffineFastState.Bounded env342 := by
  intro p hp
  have h : env342.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans341_342 : H12AffineEnvironment.transform 12 4283 env341 = env342 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4283 env341 == env342) = true)

def env343 : List Nat := [2,4,8,16,32,64,128,4,137,1024,0,4096,4283,4177,4274,1037,1093,4274,1024,4274,4096,1,5205,5311,4146,5125,4275,4176,1044,5173,1025,216,5,5325,1093,136]

theorem envBound343 : H12AffineFastState.Bounded env343 := by
  intro p hp
  have h : env343.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans342_343 : H12AffineEnvironment.transform 10 0 env342 = env343 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env342 == env343) = true)

theorem identity343 : scanCanonicalize (H12AffineFastState.compose env343 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 166) := by decide +kernel

theorem selectedBound343 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env344 : List Nat := [2,4,8,16,32,64,128,4,137,166,0,4096,4283,4177,4274,171,227,4274,166,4274,4096,1,4339,4121,4146,4259,4275,4176,178,4243,167,216,5,4203,227,136]

theorem envBound344 : H12AffineFastState.Bounded env344 := by
  intro p hp
  have h : env344.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans343_344 : H12AffineEnvironment.transform 9 166 env343 = env344 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 166 env343 == env344) = true)

theorem identity344 : scanCanonicalize (H12AffineFastState.compose env344 (packedSelected [2,4] rootPS)) = affineNative (2^(11+1) ^^^ 147) := by decide +kernel

theorem selectedBound344 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env345 : List Nat := [2,4,8,16,32,64,128,4,137,166,0,147,40,194,33,171,227,33,166,33,147,1,96,138,161,48,32,195,178,0,167,216,5,248,227,136]

theorem envBound345 : H12AffineFastState.Bounded env345 := by
  intro p hp
  have h : env345.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans344_345 : H12AffineEnvironment.transform 11 147 env344 = env345 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 147 env344 == env345) = true)

def env346 : List Nat := [2,4,8,16,0,64,128,4,137,134,0,147,8,194,1,139,195,1,134,1,147,1,64,138,129,16,0,195,146,0,135,216,5,216,195,136]

theorem envBound346 : H12AffineFastState.Bounded env346 := by
  intro p hp
  have h : env346.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans345_346 : H12AffineEnvironment.transform 4 0 env345 = env346 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env345 == env346) = true)

def leafEnv346 : List Nat := [2,4,8,16,0,64,128,4,137,134,0,147,8,194,1,139,195,1,134,1,147,1,64,138,134,129,1,16,0,195,146,0,135,216,5,216,4,2,195,136,0,147,1]

def active346 : List Nat := [0,1,2,3,5,6]

def tree346 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood346 : H12WitnessSearch.Good tree346 := H12GlobalWitnessIndex.good

theorem leafIdentity346 : H12AffineFastState.composeSystem env346 rootObs = leafEnv346 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env346 rootObs == leafEnv346) = true)

theorem terminalChecked346 : H12PackedTerminal.terminalCheckFast leafEnv346 active346 tree346 = true := by decide +kernel

def env347 : List Nat := [2,4,8,16,1,64,128,4,137,135,0,147,9,194,0,138,194,0,135,0,147,1,65,138,128,17,1,195,147,0,134,216,5,217,194,136]

theorem envBound347 : H12AffineFastState.Bounded env347 := by
  intro p hp
  have h : env347.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans345_347 : H12AffineEnvironment.transform 4 1 env345 = env347 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env345 == env347) = true)

theorem identity347 : scanCanonicalize (H12AffineFastState.compose env347 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound347 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env348 : List Nat := [2,4,8,16,1,64,9,4,0,14,0,26,9,75,0,3,75,0,14,0,26,1,65,3,9,17,1,74,26,0,15,81,5,80,75,1]

theorem envBound348 : H12AffineFastState.Bounded env348 := by
  intro p hp
  have h : env348.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans347_348 : H12AffineEnvironment.transform 6 9 env347 = env348 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env347 == env348) = true)

def leafEnv348 : List Nat := [2,4,8,16,1,64,9,4,0,14,0,26,9,75,0,3,75,0,14,0,26,1,65,3,14,9,1,17,1,74,26,0,15,81,5,80,4,3,75,1,0,27,1]

def active348 : List Nat := [0,1,2,3,5]

def tree348 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood348 : H12WitnessSearch.Good tree348 := H12GlobalWitnessIndex.good

theorem leafIdentity348 : H12AffineFastState.composeSystem env348 rootObs = leafEnv348 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env348 rootObs == leafEnv348) = true)

theorem terminalChecked348 : H12PackedTerminal.terminalCheckFast leafEnv348 active348 tree348 = true := by decide +kernel

def env349 : List Nat := [2,4,8,16,32,64,128,4,137,1024,1,4096,4283,4177,4274,1037,1093,4274,1024,4274,4096,1,5205,5311,4146,5125,4275,4176,1044,5172,1025,216,5,5325,1093,136]

theorem envBound349 : H12AffineFastState.Bounded env349 := by
  intro p hp
  have h : env349.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans342_349 : H12AffineEnvironment.transform 10 1 env342 = env349 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env342 == env349) = true)

theorem identity349 : scanCanonicalize (H12AffineFastState.compose env349 (packedSelected [0] rootPS)) = affineNative (2^(11+1) ^^^ 146) := by decide +kernel

theorem selectedBound349 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env350 : List Nat := [2,4,8,16,32,64,128,4,137,1024,1,146,41,195,32,1037,1093,32,1024,32,146,1,1223,1069,160,1175,33,194,1044,1190,1025,216,5,1119,1093,136]

theorem envBound350 : H12AffineFastState.Bounded env350 := by
  intro p hp
  have h : env350.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans349_350 : H12AffineEnvironment.transform 11 146 env349 = env350 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 146 env349 == env350) = true)

theorem identity350 : scanCanonicalize (H12AffineFastState.compose env350 (packedSelected [1,3,5] rootPS)) = affineNative (2^(9+1) ^^^ 167) := by decide +kernel

theorem selectedBound350 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env351 : List Nat := [2,4,8,16,32,64,128,4,137,167,1,146,41,195,32,170,226,32,167,32,146,1,96,138,160,48,33,194,179,1,166,216,5,248,226,136]

theorem envBound351 : H12AffineFastState.Bounded env351 := by
  intro p hp
  have h : env351.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans350_351 : H12AffineEnvironment.transform 9 167 env350 = env351 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 167 env350 == env351) = true)

def env352 : List Nat := [2,4,8,16,0,64,128,4,137,135,1,146,9,195,0,138,194,0,135,0,146,1,64,138,128,16,1,194,147,1,134,216,5,216,194,136]

theorem envBound352 : H12AffineFastState.Bounded env352 := by
  intro p hp
  have h : env352.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans351_352 : H12AffineEnvironment.transform 4 0 env351 = env352 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env351 == env352) = true)

def leafEnv352 : List Nat := [2,4,8,16,0,64,128,4,137,135,1,146,9,195,0,138,194,0,135,0,146,1,64,138,135,128,1,16,1,194,147,1,134,216,5,216,4,3,194,136,0,146,1]

def active352 : List Nat := [0,1,2,3,5,6]

def tree352 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood352 : H12WitnessSearch.Good tree352 := H12GlobalWitnessIndex.good

theorem leafIdentity352 : H12AffineFastState.composeSystem env352 rootObs = leafEnv352 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env352 rootObs == leafEnv352) = true)

theorem terminalChecked352 : H12PackedTerminal.terminalCheckFast leafEnv352 active352 tree352 = true := by decide +kernel

def env353 : List Nat := [2,4,8,16,1,64,128,4,137,134,1,146,8,195,1,139,195,1,134,1,146,1,65,138,129,17,0,194,146,1,135,216,5,217,195,136]

theorem envBound353 : H12AffineFastState.Bounded env353 := by
  intro p hp
  have h : env353.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans351_353 : H12AffineEnvironment.transform 4 1 env351 = env353 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env351 == env353) = true)

theorem identity353 : scanCanonicalize (H12AffineFastState.compose env353 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound353 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env354 : List Nat := [2,4,8,16,1,64,9,4,0,15,1,27,8,74,1,2,74,1,15,1,27,1,65,3,8,17,0,75,27,1,14,81,5,80,74,1]

theorem envBound354 : H12AffineFastState.Bounded env354 := by
  intro p hp
  have h : env354.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans353_354 : H12AffineEnvironment.transform 6 9 env353 = env354 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env353 == env354) = true)

def leafEnv354 : List Nat := [2,4,8,16,1,64,9,4,0,15,1,27,8,74,1,2,74,1,15,1,27,1,65,3,15,8,1,17,0,75,27,1,14,81,5,80,4,2,74,1,0,26,1]

def active354 : List Nat := [0,1,2,3,5]

def tree354 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood354 : H12WitnessSearch.Good tree354 := H12GlobalWitnessIndex.good

theorem leafIdentity354 : H12AffineFastState.composeSystem env354 rootObs = leafEnv354 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env354 rootObs == leafEnv354) = true)

theorem terminalChecked354 : H12PackedTerminal.terminalCheckFast leafEnv354 active354 tree354 = true := by decide +kernel

def env355 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4097,4194304,17664,98564,33554432,67108864,134217728,67130624,138695748,1073741824,138695761,4294967296,138694741,4400472182,1345,33563272]

theorem envBound355 : H12AffineFastState.Bounded env355 := by
  intro p hp
  have h : env355.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans269_355 : H12AffineEnvironment.transform 20 4097 env269 = env355 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env269 == env355) = true)

def env356 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,134217728,67130624,157794305,1073741824,140788817,4294967296,157663569,4417151346,131073,33563272]

theorem envBound356 : H12AffineFastState.Bounded env356 := by
  intro p hp
  have h : env356.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans8_356 : H12AffineEnvironment.transform 28 157794305 env8 = env356 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 28 157794305 env8 == env356) = true)

theorem identity356 : scanCanonicalize (H12AffineFastState.compose env356 (packedSelected [14] rootPS)) = affineNative (2^(23+1) ^^^ 2199812) := by decide +kernel

theorem selectedBound356 : packedSelected [14] rootPS < 2^1333 := by decide +kernel

def env357 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,2199812,33554432,67108864,134217728,67130624,138825989,1073741824,140788817,4294967296,138694741,4402573430,131073,33563272]

theorem envBound357 : H12AffineFastState.Bounded env357 := by
  intro p hp
  have h : env357.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans356_357 : H12AffineEnvironment.transform 23 2199812 env356 = env357 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 2199812 env356 == env357) = true)

def env358 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,2199812,8328,67108864,134217728,67130624,138825989,1073741824,140788817,4294967296,138694741,4369010942,131073,512]

theorem envBound358 : H12AffineFastState.Bounded env358 := by
  intro p hp
  have h : env358.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans357_358 : H12AffineEnvironment.transform 24 8328 env357 = env358 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8328 env357 == env358) = true)

theorem identity358 : scanCanonicalize (H12AffineFastState.compose env358 (packedSelected [1,3,10,19,24,26,28,31] rootPS)) = affineNative (2^(25+1) ^^^ 2098433) := by decide +kernel

theorem selectedBound358 : packedSelected [1,3,10,19,24,26,28,31] rootPS < 2^1333 := by decide +kernel

def env359 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,2199812,8328,2098433,134217728,2117633,138825989,1073741824,140788817,4294967296,138694741,4299806207,131073,512]

theorem envBound359 : H12AffineFastState.Bounded env359 := by
  intro p hp
  have h : env359.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans358_359 : H12AffineEnvironment.transform 25 2098433 env358 = env359 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 2098433 env358 == env359) = true)

theorem identity359 : scanCanonicalize (H12AffineFastState.compose env359 (packedSelected [0,1,4,5,6,7,8,13,16,17,19,20,21,22,24,25,26,33] rootPS)) = affineNative (2^(29+1) ^^^ 136801682) := by decide +kernel

theorem selectedBound359 : packedSelected [0,1,4,5,6,7,8,13,16,17,19,20,21,22,24,25,26,33] rootPS < 2^1333 := by decide +kernel

def env360 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,2199812,8328,2098433,134217728,2117633,138825989,136801682,140788817,4294967296,138694741,4299806207,131073,512]

theorem envBound360 : H12AffineFastState.Bounded env360 := by
  intro p hp
  have h : env360.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans359_360 : H12AffineEnvironment.transform 29 136801682 env359 = env360 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 136801682 env359 == env360) = true)

theorem identity360 : scanCanonicalize (H12AffineFastState.compose env360 (packedSelected [4,7,9,16,20,27,35] rootPS)) = affineNative (2^(16+1) ^^^ 62492) := by decide +kernel

theorem selectedBound360 : packedSelected [4,7,9,16,20,27,35] rootPS < 2^1333 := by decide +kernel

def env361 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,62492,262144,524288,32768,2097152,4194304,17664,2199812,8328,2098433,134217728,2117633,138716441,136681870,140788817,4294967296,138694741,4299806207,62493,512]

theorem envBound361 : H12AffineFastState.Bounded env361 := by
  intro p hp
  have h : env361.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans360_361 : H12AffineEnvironment.transform 16 62492 env360 = env361 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 62492 env360 == env361) = true)

theorem identity361 : scanCanonicalize (H12AffineFastState.compose env361 (packedSelected [6,12,15,17,21,25,38,41] rootPS)) = affineNative (2^(26+1) ^^^ 6557956) := by decide +kernel

theorem selectedBound361 : packedSelected [6,12,15,17,21,25,38,41] rootPS < 2^1333 := by decide +kernel

def env362 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,62492,262144,524288,32768,2097152,4194304,17664,2199812,8328,2098433,6557956,2117633,2143261,4294794,21845,4294967296,2113873,4299806207,62493,512]

theorem envBound362 : H12AffineFastState.Bounded env362 := by
  intro p hp
  have h : env362.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans361_362 : H12AffineEnvironment.transform 26 6557956 env361 = env362 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 6557956 env361 == env362) = true)

theorem identity362 : scanCanonicalize (H12AffineFastState.compose env362 (packedSelected [1,3,4,5,8,9,10,16,19] rootPS)) = affineNative (2^(21+1) ^^^ 20956) := by decide +kernel

theorem selectedBound362 : packedSelected [1,3,4,5,8,9,10,16,19] rootPS < 2^1333 := by decide +kernel

def env363 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,62492,262144,524288,32768,2097152,20956,17664,2199812,8328,2098433,2375896,2117633,2143261,121174,21845,4294967296,2113873,4295590947,62493,512]

theorem envBound363 : H12AffineFastState.Bounded env363 := by
  intro p hp
  have h : env363.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans362_363 : H12AffineEnvironment.transform 21 20956 env362 = env363 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 20956 env362 == env363) = true)

def env364 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,62492,262144,524288,32768,16464,20956,17664,119124,8328,17745,262280,4177,62541,121174,21845,4294967296,257,4295590947,62493,512]

theorem envBound364 : H12AffineFastState.Bounded env364 := by
  intro p hp
  have h : env364.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans363_364 : H12AffineEnvironment.transform 20 16464 env363 = env364 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 16464 env363 == env364) = true)

theorem identity364 : scanCanonicalize (H12AffineFastState.compose env364 (packedSelected [0,4,6,7,9,16,20] rootPS)) = affineNative (2^(31+1) ^^^ 116018) := by decide +kernel

theorem selectedBound364 : packedSelected [0,4,6,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env365 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,62492,262144,524288,32768,16464,20956,17664,119124,8328,17745,262280,4177,62541,121174,21845,116018,257,540945,62493,512]

theorem envBound365 : H12AffineFastState.Bounded env365 := by
  intro p hp
  have h : env365.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans364_365 : H12AffineEnvironment.transform 31 116018 env364 = env365 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 116018 env364 == env365) = true)

def env366 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,62492,262144,524288,32768,16465,20956,17664,119125,8328,17744,262281,4176,62540,121174,21845,4294967296,256,4295590947,62493,512]

theorem envBound366 : H12AffineFastState.Bounded env366 := by
  intro p hp
  have h : env366.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans363_366 : H12AffineEnvironment.transform 20 16465 env363 = env366 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 16465 env363 == env366) = true)

theorem identity366 : scanCanonicalize (H12AffineFastState.compose env366 (packedSelected [0,4,6,7,9,16,20] rootPS)) = affineNative (2^(31+1) ^^^ 103779) := by decide +kernel

theorem selectedBound366 : packedSelected [0,4,6,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env367 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,62492,262144,524288,32768,16465,20956,17664,119125,8328,17744,262281,4176,62540,121174,21845,103779,256,528704,62493,512]

theorem envBound367 : H12AffineFastState.Bounded env367 := by
  intro p hp
  have h : env367.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans366_367 : H12AffineEnvironment.transform 31 103779 env366 = env367 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 103779 env366 == env367) = true)

theorem identity367 : scanCanonicalize (H12AffineFastState.compose env367 (packedSelected [0,6,27] rootPS)) = affineNative (2^(14+1) ^^^ 8460) := by decide +kernel

theorem selectedBound367 : packedSelected [0,6,27] rootPS < 2^1333 := by decide +kernel

def env368 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8460,65536,21776,262144,524288,8460,16465,20956,17664,94297,8328,17744,262281,4176,21824,96346,21845,78959,256,528704,21777,512]

theorem envBound368 : H12AffineFastState.Bounded env368 := by
  intro p hp
  have h : env368.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans367_368 : H12AffineEnvironment.transform 14 8460 env367 = env368 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8460 env367 == env368) = true)

theorem identity368 : scanCanonicalize (H12AffineFastState.compose env368 (packedSelected [4,6,16,22] rootPS)) = affineNative (2^(13+1) ^^^ 4176) := by decide +kernel

theorem selectedBound368 : packedSelected [4,6,16,22] rootPS < 2^1333 := by decide +kernel

def env369 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,8460,65536,1344,262144,524288,8460,4097,396,5456,73737,8328,5376,262281,4176,1296,75786,1285,78959,256,528704,1345,512]

theorem envBound369 : H12AffineFastState.Bounded env369 := by
  intro p hp
  have h : env369.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans368_369 : H12AffineEnvironment.transform 13 4176 env368 = env369 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env368 == env369) = true)

theorem identity369 : scanCanonicalize (H12AffineFastState.compose env369 (packedSelected [6] rootPS)) = affineNative (2^(12+1) ^^^ 5449) := by decide +kernel

theorem selectedBound369 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env370 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,5449,4176,5189,65536,1344,262144,524288,5189,4097,396,5456,70976,5569,5376,262281,4176,1296,73027,1285,65830,256,528704,1345,512]

theorem envBound370 : H12AffineFastState.Bounded env370 := by
  intro p hp
  have h : env370.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans369_370 : H12AffineEnvironment.transform 12 5449 env369 = env370 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5449 env369 == env370) = true)

theorem identity370 : scanCanonicalize (H12AffineFastState.compose env370 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(18+1) ^^^ 1025) := by decide +kernel

theorem selectedBound370 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env371 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,5449,4176,5189,65536,1344,262144,1025,5189,4097,396,5456,70976,5569,5376,262281,4176,1296,73027,1285,65830,256,5441,1345,512]

theorem envBound371 : H12AffineFastState.Bounded env371 := by
  intro p hp
  have h : env371.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans370_371 : H12AffineEnvironment.transform 18 1025 env370 = env371 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env370 == env371) = true)

theorem identity371 : scanCanonicalize (H12AffineFastState.compose env371 (packedSelected [3,5,10] rootPS)) = affineNative (2^(15+1) ^^^ 4842) := by decide +kernel

theorem selectedBound371 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env372 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,5449,4176,5189,4842,1344,262144,1025,5189,4097,396,5456,1962,5569,5376,262281,4176,1296,4009,1285,5068,256,5441,1345,512]

theorem envBound372 : H12AffineFastState.Bounded env372 := by
  intro p hp
  have h : env372.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans371_372 : H12AffineEnvironment.transform 15 4842 env371 = env372 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 4842 env371 == env372) = true)

theorem identity372 : scanCanonicalize (H12AffineFastState.compose env372 (packedSelected [1,8,12] rootPS)) = affineNative (2^(17+1) ^^^ 4666) := by decide +kernel

theorem selectedBound372 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env373 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,5449,4176,5189,4842,1344,4666,1025,5189,4097,396,5456,1962,5569,5376,4787,4176,1296,4009,1285,5068,256,5441,1345,512]

theorem envBound373 : H12AffineFastState.Bounded env373 := by
  intro p hp
  have h : env373.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans372_373 : H12AffineEnvironment.transform 17 4666 env372 = env373 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 4666 env372 == env373) = true)

theorem identity373 : scanCanonicalize (H12AffineFastState.compose env373 (packedSelected [3,5,8,13,24] rootPS)) = affineNative (2^(11+1) ^^^ 1993) := by decide +kernel

theorem selectedBound373 : packedSelected [3,5,8,13,24] rootPS < 2^1333 := by decide +kernel

def env374 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1993,640,1945,908,1315,1344,1523,1025,908,1992,396,665,1962,520,713,1402,1945,1296,4009,1285,1029,256,648,1345,512]

theorem envBound374 : H12AffineFastState.Bounded env374 := by
  intro p hp
  have h : env374.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans373_374 : H12AffineEnvironment.transform 11 1993 env373 = env374 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1993 env373 == env374) = true)

theorem identity374 : scanCanonicalize (H12AffineFastState.compose env374 (packedSelected [8,13] rootPS)) = affineNative (2^(8+1) ^^^ 396) := by decide +kernel

theorem selectedBound374 : packedSelected [8,13] rootPS < 2^1333 := by decide +kernel

def env375 : List Nat := [2,4,8,16,32,64,128,256,396,1024,2048,1093,268,1045,0,1315,1344,1523,1025,0,1092,396,277,1062,388,325,1402,1045,1296,3109,1285,1029,256,260,1345,396]

theorem envBound375 : H12AffineFastState.Bounded env375 := by
  intro p hp
  have h : env375.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans374_375 : H12AffineEnvironment.transform 8 396 env374 = env375 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 396 env374 == env375) = true)

def env376 : List Nat := [2,4,8,16,32,64,128,256,396,1024,0,1093,268,1045,0,1315,1344,1523,1025,0,1092,396,277,1062,388,325,1402,1045,1296,1061,1285,1029,256,260,1345,396]

theorem envBound376 : H12AffineFastState.Bounded env376 := by
  intro p hp
  have h : env376.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans375_376 : H12AffineEnvironment.transform 10 0 env375 = env376 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env375 == env376) = true)

theorem identity376 : scanCanonicalize (H12AffineFastState.compose env376 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 58) := by decide +kernel

theorem selectedBound376 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env377 : List Nat := [2,4,8,16,32,64,58,256,310,1024,0,1093,268,1045,0,1315,1344,1353,1025,0,1092,310,277,1062,318,325,1402,1045,1296,1061,1285,1029,256,260,1345,310]

theorem envBound377 : H12AffineFastState.Bounded env377 := by
  intro p hp
  have h : env377.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans376_377 : H12AffineEnvironment.transform 6 58 env376 = env377 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 58 env376 == env377) = true)

theorem identity377 : scanCanonicalize (H12AffineFastState.compose env377 (packedSelected [7,11] rootPS)) = affineNative (2^(9+1) ^^^ 379) := by decide +kernel

theorem selectedBound377 : packedSelected [7,11] rootPS < 2^1333 := by decide +kernel

def env378 : List Nat := [2,4,8,16,32,64,58,256,310,379,0,318,268,366,0,88,59,50,378,0,319,310,277,349,318,325,1,366,107,350,126,382,256,260,58,310]

theorem envBound378 : H12AffineFastState.Bounded env378 := by
  intro p hp
  have h : env378.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans377_378 : H12AffineEnvironment.transform 9 379 env377 = env378 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 379 env377 == env378) = true)

theorem identity378 : scanCanonicalize (H12AffineFastState.compose env378 (packedSelected [7] rootPS)) = affineNative (2^(5+1) ^^^ 59) := by decide +kernel

theorem selectedBound378 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env379 : List Nat := [2,4,8,16,32,59,58,256,310,256,0,318,268,277,0,35,59,50,257,0,319,310,277,294,318,318,1,277,16,293,5,261,256,260,58,310]

theorem envBound379 : H12AffineFastState.Bounded env379 := by
  intro p hp
  have h : env379.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans378_379 : H12AffineEnvironment.transform 5 59 env378 = env379 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 59 env378 == env379) = true)

theorem identity379 : scanCanonicalize (H12AffineFastState.compose env379 (packedSelected [4,9] rootPS)) = affineNative (2^(7+1) ^^^ 22) := by decide +kernel

theorem selectedBound379 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env380 : List Nat := [2,4,8,16,32,59,58,22,32,22,0,40,26,3,0,35,59,50,23,0,41,32,3,48,40,40,1,3,16,51,5,19,22,18,58,32]

theorem envBound380 : H12AffineFastState.Bounded env380 := by
  intro p hp
  have h : env380.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans379_380 : H12AffineEnvironment.transform 7 22 env379 = env380 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 22 env379 == env380) = true)

def env381 : List Nat := [2,4,8,16,24,3,2,22,24,22,0,16,26,3,0,27,3,10,23,0,17,24,3,8,16,16,1,3,16,11,5,19,22,18,2,24]

theorem envBound381 : H12AffineFastState.Bounded env381 := by
  intro p hp
  have h : env381.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans380_381 : H12AffineEnvironment.transform 4 24 env380 = env381 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 24 env380 == env381) = true)

def env382 : List Nat := [2,4,8,16,25,2,3,22,25,22,0,17,26,3,0,26,2,11,23,0,16,25,3,9,17,17,1,3,16,10,5,19,22,18,3,25]

theorem envBound382 : H12AffineFastState.Bounded env382 := by
  intro p hp
  have h : env382.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans380_382 : H12AffineEnvironment.transform 4 25 env380 = env382 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 25 env380 == env382) = true)

theorem identity382 : scanCanonicalize (H12AffineFastState.compose env382 (packedSelected [1] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound382 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env383 : List Nat := [2,4,2,16,19,2,3,22,19,22,0,17,16,3,0,16,2,1,23,0,16,19,3,3,17,17,1,3,16,0,5,19,22,18,3,19]

theorem envBound383 : H12AffineFastState.Bounded env383 := by
  intro p hp
  have h : env383.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans382_383 : H12AffineEnvironment.transform 2 2 env382 = env383 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env382 == env383) = true)

theorem identity383 : scanCanonicalize (H12AffineFastState.compose env383 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound383 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env384 : List Nat := [2,4,2,3,0,2,3,5,0,5,0,2,3,3,0,3,2,1,4,0,3,0,3,3,2,2,1,3,3,0,5,0,5,1,3,0]

theorem envBound384 : H12AffineFastState.Bounded env384 := by
  intro p hp
  have h : env384.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans383_384 : H12AffineEnvironment.transform 3 3 env383 = env384 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env383 == env384) = true)

def leafEnv384 : List Nat := [2,4,2,3,0,2,3,5,0,5,0,2,3,3,0,3,2,1,4,0,3,0,3,3,4,2,1,2,1,3,3,0,5,0,5,1,4,2,3,0,0,3,1]

def active384 : List Nat := [0,1]

def tree384 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood384 : H12WitnessSearch.Good tree384 := H12GlobalWitnessIndex.good

theorem leafIdentity384 : H12AffineFastState.composeSystem env384 rootObs = leafEnv384 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env384 rootObs == leafEnv384) = true)

theorem terminalChecked384 : H12PackedTerminal.terminalCheckFast leafEnv384 active384 tree384 = true := by decide +kernel

def env385 : List Nat := [2,4,8,16,32,64,128,256,396,1024,1,1093,268,1045,0,1315,1344,1523,1025,0,1092,396,277,1062,388,325,1402,1045,1296,1060,1285,1029,256,260,1345,396]

theorem envBound385 : H12AffineFastState.Bounded env385 := by
  intro p hp
  have h : env385.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans375_385 : H12AffineEnvironment.transform 10 1 env375 = env385 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env375 == env385) = true)

theorem identity385 : scanCanonicalize (H12AffineFastState.compose env385 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 158) := by decide +kernel

theorem selectedBound385 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env386 : List Nat := [2,4,8,16,32,64,128,256,396,158,1,219,268,139,0,445,478,365,159,0,218,396,277,184,388,325,484,139,398,186,411,155,256,260,479,396]

theorem envBound386 : H12AffineFastState.Bounded env386 := by
  intro p hp
  have h : env386.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans385_386 : H12AffineEnvironment.transform 9 158 env385 = env386 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 158 env385 == env386) = true)

theorem identity386 : scanCanonicalize (H12AffineFastState.compose env386 (packedSelected [7,11] rootPS)) = affineNative (2^(5+1) ^^^ 58) := by decide +kernel

theorem selectedBound386 : packedSelected [7,11] rootPS < 2^1333 := by decide +kernel

def env387 : List Nat := [2,4,8,16,32,58,128,256,396,158,1,161,268,139,0,445,420,279,159,0,160,396,277,184,388,319,414,139,398,186,411,155,256,260,421,396]

theorem envBound387 : H12AffineFastState.Bounded env387 := by
  intro p hp
  have h : env387.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans386_387 : H12AffineEnvironment.transform 5 58 env386 = env387 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 58 env386 == env387) = true)

theorem identity387 : scanCanonicalize (H12AffineFastState.compose env387 (packedSelected [4,7,9,18] rootPS)) = affineNative (2^(4+1) ^^^ 18) := by decide +kernel

theorem selectedBound387 : packedSelected [4,7,9,18] rootPS < 2^1333 := by decide +kernel

def env388 : List Nat := [2,4,8,16,18,8,128,256,396,158,1,147,268,139,0,399,406,279,159,0,146,396,277,138,388,269,414,139,398,136,411,155,256,260,407,396]

theorem envBound388 : H12AffineFastState.Bounded env388 := by
  intro p hp
  have h : env388.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans387_388 : H12AffineEnvironment.transform 4 18 env387 = env388 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 18 env387 == env388) = true)

def env389 : List Nat := [2,4,8,16,18,8,128,28,144,158,1,147,16,139,0,147,138,11,159,0,146,144,9,138,152,17,130,139,146,136,135,155,28,24,139,144]

theorem envBound389 : H12AffineFastState.Bounded env389 := by
  intro p hp
  have h : env389.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans388_389 : H12AffineEnvironment.transform 7 28 env388 = env389 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 28 env388 == env389) = true)

theorem identity389 : scanCanonicalize (H12AffineFastState.compose env389 (packedSelected [1] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound389 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env390 : List Nat := [2,4,2,16,18,2,128,22,144,148,1,147,16,129,0,147,128,1,149,0,146,144,3,128,146,17,130,129,146,130,135,145,22,18,129,144]

theorem envBound390 : H12AffineFastState.Bounded env390 := by
  intro p hp
  have h : env390.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans389_390 : H12AffineEnvironment.transform 2 2 env389 = env390 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env389 == env390) = true)

theorem identity390 : scanCanonicalize (H12AffineFastState.compose env390 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 17) := by decide +kernel

theorem selectedBound390 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env391 : List Nat := [2,4,2,16,18,2,17,22,1,5,1,2,16,16,0,2,17,1,4,0,3,1,3,17,3,17,19,16,3,19,22,0,22,18,16,1]

theorem envBound391 : H12AffineFastState.Bounded env391 := by
  intro p hp
  have h : env391.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans390_391 : H12AffineEnvironment.transform 6 17 env390 = env391 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 17 env390 == env391) = true)

theorem identity391 : scanCanonicalize (H12AffineFastState.compose env391 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound391 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env392 : List Nat := [2,4,2,2,0,2,3,4,1,5,1,2,2,2,0,2,3,1,4,0,3,1,3,3,3,3,1,2,3,1,4,0,4,0,2,1]

theorem envBound392 : H12AffineFastState.Bounded env392 := by
  intro p hp
  have h : env392.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans391_392 : H12AffineEnvironment.transform 3 2 env391 = env392 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env391 == env392) = true)

def leafEnv392 : List Nat := [2,4,2,2,0,2,3,4,1,5,1,2,2,2,0,2,3,1,4,0,3,1,3,3,5,3,1,3,1,2,3,1,4,0,4,0,4,3,2,1,0,3,1]

def active392 : List Nat := [0,1]

def tree392 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood392 : H12WitnessSearch.Good tree392 := H12GlobalWitnessIndex.good

theorem leafIdentity392 : H12AffineFastState.composeSystem env392 rootObs = leafEnv392 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env392 rootObs == leafEnv392) = true)

theorem terminalChecked392 : H12PackedTerminal.terminalCheckFast leafEnv392 active392 tree392 = true := by decide +kernel

def env393 : List Nat := [2,4,8,16,18,8,128,29,145,158,1,147,17,139,0,146,139,10,159,0,146,145,8,138,153,16,131,139,147,136,134,155,29,25,138,145]

theorem envBound393 : H12AffineFastState.Bounded env393 := by
  intro p hp
  have h : env393.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans388_393 : H12AffineEnvironment.transform 7 29 env388 = env393 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 29 env388 == env393) = true)

theorem identity393 : scanCanonicalize (H12AffineFastState.compose env393 (packedSelected [4] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound393 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env394 : List Nat := [2,4,8,16,18,8,2,29,19,28,1,17,17,9,0,16,9,10,29,0,16,19,8,8,27,16,1,9,17,10,4,25,29,25,8,19]

theorem envBound394 : H12AffineFastState.Bounded env394 := by
  intro p hp
  have h : env394.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans393_394 : H12AffineEnvironment.transform 6 2 env393 = env394 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env393 == env394) = true)

theorem identity394 : scanCanonicalize (H12AffineFastState.compose env394 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound394 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env395 : List Nat := [2,4,3,16,18,3,2,22,19,23,1,17,17,2,0,16,2,1,22,0,16,19,3,3,16,16,1,2,17,1,4,18,22,18,3,19]

theorem envBound395 : H12AffineFastState.Bounded env395 := by
  intro p hp
  have h : env395.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans394_395 : H12AffineEnvironment.transform 2 3 env394 = env395 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env394 == env395) = true)

def leafEnv395 : List Nat := [2,4,3,16,18,3,2,22,19,23,1,17,17,2,0,16,2,1,22,0,16,19,3,3,5,16,1,16,1,2,17,1,4,18,22,18,4,17,3,19,0,17,1]

def active395 : List Nat := [0,1,3]

def tree395 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood395 : H12WitnessSearch.Good tree395 := H12GlobalWitnessIndex.good

theorem leafIdentity395 : H12AffineFastState.composeSystem env395 rootObs = leafEnv395 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env395 rootObs == leafEnv395) = true)

theorem terminalChecked395 : H12PackedTerminal.terminalCheckFast leafEnv395 active395 tree395 = true := by decide +kernel

def env396 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,2199812,8329,67108864,134217728,67130624,138825989,1073741824,140788817,4294967296,138694741,4369010943,131073,513]

theorem envBound396 : H12AffineFastState.Bounded env396 := by
  intro p hp
  have h : env396.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans357_396 : H12AffineEnvironment.transform 24 8329 env357 = env396 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env357 == env396) = true)

def env397 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,136512,4194304,17664,230468,8329,67108864,134217728,67130624,138825989,1073741824,138826001,4294967296,138694741,4367041983,131073,513]

theorem envBound397 : H12AffineFastState.Bounded env397 := by
  intro p hp
  have h : env397.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans396_397 : H12AffineEnvironment.transform 20 136512 env396 = env397 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 136512 env396 == env397) = true)

def env398 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,136512,4194304,17664,230468,8329,5376,134217728,16384,138825989,1073741824,138826001,4294967296,138694741,4299935935,131073,513]

theorem envBound398 : H12AffineFastState.Bounded env398 := by
  intro p hp
  have h : env398.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans397_398 : H12AffineEnvironment.transform 25 5376 env397 = env398 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env397 == env398) = true)

theorem identity398 : scanCanonicalize (H12AffineFastState.compose env398 (packedSelected [4,7,9,16,20,27] rootPS)) = affineNative (2^(16+1) ^^^ 1344) := by decide +kernel

theorem selectedBound398 : packedSelected [4,7,9,16,20,27] rootPS < 2^1333 := by decide +kernel

def env399 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,524288,32768,4096,4194304,17664,98564,8329,5376,134217728,16384,138695749,1073741824,138695761,4294967296,138694741,4299806207,1345,513]

theorem envBound399 : H12AffineFastState.Bounded env399 := by
  intro p hp
  have h : env399.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans398_399 : H12AffineEnvironment.transform 16 1344 env398 = env399 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env398 == env399) = true)

theorem identity399 : scanCanonicalize (H12AffineFastState.compose env399 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(26+1) ^^^ 4477268) := by decide +kernel

theorem selectedBound399 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env400 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1344,262144,524288,32768,4096,4194304,17664,98564,8329,5376,4477268,16384,1297,1073741824,1285,4294967296,257,4299806207,1345,513]

theorem envBound400 : H12AffineFastState.Bounded env400 := by
  intro p hp
  have h : env400.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans399_400 : H12AffineEnvironment.transform 26 4477268 env399 = env400 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 4477268 env399 == env400) = true)

theorem identity400 : scanCanonicalize (H12AffineFastState.compose env400 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(13+1) ^^^ 4825) := by decide +kernel

theorem selectedBound400 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env401 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4825,32768,65536,1344,262144,524288,32768,4096,4194304,6105,98564,8329,5376,4457357,4825,1297,1073741824,1285,4294967296,257,4299786022,1345,513]

theorem envBound401 : H12AffineFastState.Bounded env401 := by
  intro p hp
  have h : env401.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans400_401 : H12AffineEnvironment.transform 13 4825 env400 = env401 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4825 env400 == env401) = true)

theorem identity401 : scanCanonicalize (H12AffineFastState.compose env401 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(17+1) ^^^ 43681) := by decide +kernel

theorem selectedBound401 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env402 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4825,32768,65536,1344,43681,524288,32768,4096,4194304,6105,98564,8329,5376,4237612,4825,1297,1073741824,1285,4294967296,257,4299786022,1345,513]

theorem envBound402 : H12AffineFastState.Bounded env402 := by
  intro p hp
  have h : env402.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans401_402 : H12AffineEnvironment.transform 17 43681 env401 = env402 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43681 env401 == env402) = true)

theorem identity402 : scanCanonicalize (H12AffineFastState.compose env402 (packedSelected [0,4,7,9,18,23] rootPS)) = affineNative (2^(29+1) ^^^ 4197260) := by decide +kernel

theorem selectedBound402 : packedSelected [0,4,7,9,18,23] rootPS < 2^1333 := by decide +kernel

def env403 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4825,32768,65536,1344,43681,524288,32768,4096,4194304,6105,98564,8329,5376,4237612,4825,1297,4197260,1285,4294967296,257,4299786022,1345,513]

theorem envBound403 : H12AffineFastState.Bounded env403 := by
  intro p hp
  have h : env403.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans402_403 : H12AffineEnvironment.transform 29 4197260 env402 = env403 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4197260 env402 == env403) = true)

def env404 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4825,32768,65536,1344,43681,524288,32768,4096,10248,6105,98564,8329,5376,33060,4825,1297,9092,1285,4294967296,257,4295601966,1345,513]

theorem envBound404 : H12AffineFastState.Bounded env404 := by
  intro p hp
  have h : env404.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans403_404 : H12AffineEnvironment.transform 21 10248 env403 = env404 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10248 env403 == env404) = true)

theorem identity404 : scanCanonicalize (H12AffineFastState.compose env404 (packedSelected [2,6,7,9] rootPS)) = affineNative (2^(12+1) ^^^ 2316) := by decide +kernel

theorem selectedBound404 : packedSelected [2,6,7,9] rootPS < 2^1333 := by decide +kernel

def env405 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,2316,4825,32768,65536,1344,33709,524288,32768,4096,260,6105,98564,2437,5376,33060,4825,1297,2696,1285,4294967296,257,4295591458,1345,513]

theorem envBound405 : H12AffineFastState.Bounded env405 := by
  intro p hp
  have h : env405.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans404_405 : H12AffineEnvironment.transform 12 2316 env404 = env405 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2316 env404 == env405) = true)

def env406 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,4096,2316,4177,32768,65536,1344,33061,524288,32768,4096,260,5457,98564,2437,5376,33060,4177,1297,2048,1285,4294967296,257,4295591082,1345,137]

theorem envBound406 : H12AffineFastState.Bounded env406 := by
  intro p hp
  have h : env406.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans405_406 : H12AffineEnvironment.transform 8 136 env405 = env406 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env405 == env406) = true)

theorem identity406 : scanCanonicalize (H12AffineFastState.compose env406 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(18+1) ^^^ 99726) := by decide +kernel

theorem selectedBound406 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env407 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,4096,2316,4177,32768,65536,1344,33061,99726,32768,4096,260,5457,98564,2437,5376,33060,4177,1297,2048,1285,4294967296,257,4294967588,1345,137]

theorem envBound407 : H12AffineFastState.Bounded env407 := by
  intro p hp
  have h : env407.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans406_407 : H12AffineEnvironment.transform 18 99726 env406 = env407 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 99726 env406 == env407) = true)

theorem identity407 : scanCanonicalize (H12AffineFastState.compose env407 (packedSelected [0,7] rootPS)) = affineNative (2^(14+1) ^^^ 7221) := by decide +kernel

theorem selectedBound407 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env408 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,4096,2316,4177,7221,65536,1344,7440,72123,7221,4096,260,5457,73009,2437,5376,7441,4177,1297,2048,1285,4294967296,257,4294967588,1345,137]

theorem envBound408 : H12AffineFastState.Bounded env408 := by
  intro p hp
  have h : env408.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans407_408 : H12AffineEnvironment.transform 14 7221 env407 = env408 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 7221 env407 == env408) = true)

def env409 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,2316,4176,32768,65536,1344,33060,524288,32768,4096,260,5456,98564,2437,5376,33060,4176,1297,2049,1285,4294967296,257,4295591083,1345,136]

theorem envBound409 : H12AffineFastState.Bounded env409 := by
  intro p hp
  have h : env409.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans405_409 : H12AffineEnvironment.transform 8 137 env405 = env409 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env405 == env409) = true)

theorem identity409 : scanCanonicalize (H12AffineFastState.compose env409 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 33166) := by decide +kernel

theorem selectedBound409 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env410 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,2316,4176,32768,33166,1344,33060,524288,32768,4096,260,5456,138,2437,5376,33060,4176,1297,2049,1285,4294967296,257,4295492901,1345,136]

theorem envBound410 : H12AffineFastState.Bounded env410 := by
  intro p hp
  have h : env410.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans409_410 : H12AffineEnvironment.transform 15 33166 env409 = env410 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33166 env409 == env410) = true)

theorem identity410 : scanCanonicalize (H12AffineFastState.compose env410 (packedSelected [2,4] rootPS)) = affineNative (2^(11+1) ^^^ 1045) := by decide +kernel

theorem selectedBound410 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env411 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1045,2316,1093,32768,33166,1344,33060,524288,32768,1045,260,325,138,2437,277,33060,1093,1297,2049,1285,4294967296,257,4295492901,1345,136]

theorem envBound411 : H12AffineFastState.Bounded env411 := by
  intro p hp
  have h : env411.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans410_411 : H12AffineEnvironment.transform 11 1045 env410 = env411 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1045 env410 == env411) = true)

theorem identity411 : scanCanonicalize (H12AffineFastState.compose env411 (packedSelected [0,7] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound411 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env412 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,1045,2056,1093,32768,32906,1092,32800,524288,32768,1045,0,65,138,2177,17,32800,1093,1045,2049,1025,4294967296,5,4295492641,1093,136]

theorem envBound412 : H12AffineFastState.Bounded env412 := by
  intro p hp
  have h : env412.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans411_412 : H12AffineEnvironment.transform 7 4 env411 = env412 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env411 == env412) = true)

theorem identity412 : scanCanonicalize (H12AffineFastState.compose env412 (packedSelected [3,10] rootPS)) = affineNative (2^(14+1) ^^^ 2081) := by decide +kernel

theorem selectedBound412 : packedSelected [3,10] rootPS < 2^1333 := by decide +kernel

def env413 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,1045,2056,1093,2081,2219,1092,2049,524288,2081,1045,0,65,138,2177,17,2049,1093,1045,2049,1025,4294967296,5,4295492641,1093,136]

theorem envBound413 : H12AffineFastState.Bounded env413 := by
  intro p hp
  have h : env413.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans412_413 : H12AffineEnvironment.transform 14 2081 env412 = env413 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2081 env412 == env413) = true)

def env414 : List Nat := [2,4,8,16,0,64,128,4,137,1024,2048,1045,2056,1093,2049,2187,1092,2049,524288,2049,1045,0,65,138,2177,17,2049,1093,1045,2049,1025,4294967296,5,4295492609,1093,136]

theorem envBound414 : H12AffineFastState.Bounded env414 := by
  intro p hp
  have h : env414.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans413_414 : H12AffineEnvironment.transform 4 0 env413 = env414 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env413 == env414) = true)

theorem identity414 : scanCanonicalize (H12AffineFastState.compose env414 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 3167) := by decide +kernel

theorem selectedBound414 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env415 : List Nat := [2,4,8,16,0,64,128,4,137,1024,2048,1045,2056,1093,2049,2187,1092,2049,524288,2049,1045,0,65,138,2177,17,2049,1093,1045,2049,1025,3167,5,526430,1093,136]

theorem envBound415 : H12AffineFastState.Bounded env415 := by
  intro p hp
  have h : env415.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans414_415 : H12AffineEnvironment.transform 31 3167 env414 = env415 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 3167 env414 == env415) = true)

theorem identity415 : scanCanonicalize (H12AffineFastState.compose env415 (packedSelected [1,2] rootPS)) = affineNative (2^(10+1) ^^^ 1158) := by decide +kernel

theorem selectedBound415 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env416 : List Nat := [2,4,8,16,0,64,128,4,137,1024,1158,1045,1166,1093,1159,1037,1092,1159,524288,1159,1045,0,65,138,1031,17,1159,1093,1045,1159,1025,217,5,525528,1093,136]

theorem envBound416 : H12AffineFastState.Bounded env416 := by
  intro p hp
  have h : env416.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans415_416 : H12AffineEnvironment.transform 10 1158 env415 = env416 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1158 env415 == env416) = true)

theorem identity416 : scanCanonicalize (H12AffineFastState.compose env416 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound416 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env417 : List Nat := [2,4,8,16,0,64,9,4,0,1024,1039,1045,1031,1093,1038,1037,1092,1038,524288,1038,1045,0,65,3,1031,17,1038,1093,1045,1038,1025,80,5,525393,1093,1]

theorem envBound417 : H12AffineFastState.Bounded env417 := by
  intro p hp
  have h : env417.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans416_417 : H12AffineEnvironment.transform 6 9 env416 = env417 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env416 == env417) = true)

def leafEnv417 : List Nat := [2,4,8,16,0,64,9,4,0,1024,1039,1045,1031,1093,1038,1037,1092,1038,524288,1038,1045,0,65,3,524288,1031,1,17,1038,1093,1045,1038,1025,80,5,525393,4,1037,1093,1,0,1044,1]

def active417 : List Nat := [0,1,2,3,5,9,18]

def tree417 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood417 : H12WitnessSearch.Good tree417 := H12GlobalWitnessIndex.good

theorem leafIdentity417 : H12AffineFastState.composeSystem env417 rootObs = leafEnv417 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env417 rootObs == leafEnv417) = true)

theorem terminalChecked417 : H12PackedTerminal.terminalCheckFast leafEnv417 active417 tree417 = true := by decide +kernel

def env418 : List Nat := [2,4,8,16,1,64,128,4,137,1024,2048,1045,2056,1093,2048,2186,1092,2049,524288,2048,1045,0,65,138,2177,17,2049,1093,1045,2049,1025,4294967296,5,4295492608,1093,136]

theorem envBound418 : H12AffineFastState.Bounded env418 := by
  intro p hp
  have h : env418.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans413_418 : H12AffineEnvironment.transform 4 1 env413 = env418 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env413 == env418) = true)

theorem identity418 : scanCanonicalize (H12AffineFastState.compose env418 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 3286) := by decide +kernel

theorem selectedBound418 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env419 : List Nat := [2,4,8,16,1,64,128,4,137,1024,2048,1045,2056,1093,2048,2186,1092,2049,524288,2048,1045,0,65,138,2177,17,2049,1093,1045,2049,1025,3286,5,526550,1093,136]

theorem envBound419 : H12AffineFastState.Bounded env419 := by
  intro p hp
  have h : env419.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans418_419 : H12AffineEnvironment.transform 31 3286 env418 = env419 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 3286 env418 == env419) = true)

theorem identity419 : scanCanonicalize (H12AffineFastState.compose env419 (packedSelected [2,3] rootPS)) = affineNative (2^(18+1) ^^^ 2062) := by decide +kernel

theorem selectedBound419 : packedSelected [2,3] rootPS < 2^1333 := by decide +kernel

def env420 : List Nat := [2,4,8,16,1,64,128,4,137,1024,2048,1045,2056,1093,2048,2186,1092,2049,2062,2048,1045,0,65,138,2177,17,2049,1093,1045,2049,1025,3286,5,216,1093,136]

theorem envBound420 : H12AffineFastState.Bounded env420 := by
  intro p hp
  have h : env420.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans419_420 : H12AffineEnvironment.transform 18 2062 env419 = env420 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 2062 env419 == env420) = true)

theorem identity420 : scanCanonicalize (H12AffineFastState.compose env420 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound420 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env421 : List Nat := [2,4,8,16,1,17,128,4,137,1024,2048,1045,2056,1044,2048,2186,1045,2049,2062,2048,1045,0,16,138,2177,17,2049,1044,1045,2049,1025,3207,5,137,1044,136]

theorem envBound421 : H12AffineFastState.Bounded env421 := by
  intro p hp
  have h : env421.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans420_421 : H12AffineEnvironment.transform 5 17 env420 = env421 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env420 == env421) = true)

theorem identity421 : scanCanonicalize (H12AffineFastState.compose env421 (packedSelected [2,5] rootPS)) = affineNative (2^(10+1) ^^^ 1038) := by decide +kernel

theorem selectedBound421 : packedSelected [2,5] rootPS < 2^1333 := by decide +kernel

def env422 : List Nat := [2,4,8,16,1,17,128,4,137,1024,1038,1045,1030,1044,1038,1156,1045,1039,1024,1038,1045,0,16,138,1167,17,1039,1044,1045,1039,1025,137,5,137,1044,136]

theorem envBound422 : H12AffineFastState.Bounded env422 := by
  intro p hp
  have h : env422.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans421_422 : H12AffineEnvironment.transform 10 1038 env421 = env422 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1038 env421 == env422) = true)

def leafEnv422 : List Nat := [2,4,8,16,1,17,128,4,137,1024,1038,1045,1030,1044,1038,1156,1045,1039,1024,1038,1045,0,16,138,1024,1167,1,17,1039,1044,1045,1039,1025,137,5,137,4,1037,1044,136,0,1044,1]

def active422 : List Nat := [0,1,2,3,6,9]

def tree422 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood422 : H12WitnessSearch.Good tree422 := H12GlobalWitnessIndex.good

theorem leafIdentity422 : H12AffineFastState.composeSystem env422 rootObs = leafEnv422 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env422 rootObs == leafEnv422) = true)

theorem terminalChecked422 : H12PackedTerminal.terminalCheckFast leafEnv422 active422 tree422 = true := by decide +kernel

def env423 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4825,32768,65536,1344,43681,524288,32768,4096,10249,6105,98564,8329,5376,33061,4825,1297,9093,1285,4294967296,257,4295601967,1345,513]

theorem envBound423 : H12AffineFastState.Bounded env423 := by
  intro p hp
  have h : env423.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans403_423 : H12AffineEnvironment.transform 21 10249 env403 = env423 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10249 env403 == env423) = true)

theorem identity423 : scanCanonicalize (H12AffineFastState.compose env423 (packedSelected [2,6,7,9] rootPS)) = affineNative (2^(14+1) ^^^ 8232) := by decide +kernel

theorem selectedBound423 : packedSelected [2,6,7,9] rootPS < 2^1333 := by decide +kernel

def env424 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4825,8232,65536,1344,2697,524288,8232,4096,10249,6105,74028,8329,5376,8461,4825,1297,9093,1285,4294967296,257,4295560967,1345,513]

theorem envBound424 : H12AffineFastState.Bounded env424 := by
  intro p hp
  have h : env424.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans423_424 : H12AffineEnvironment.transform 14 8232 env423 = env424 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8232 env423 == env424) = true)

def env425 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,4096,8192,4177,8232,65536,1344,2049,524288,8232,4096,10249,5457,74028,8329,5376,8461,4177,1297,8461,1285,4294967296,257,4295560591,1345,137]

theorem envBound425 : H12AffineFastState.Bounded env425 := by
  intro p hp
  have h : env425.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans424_425 : H12AffineEnvironment.transform 8 136 env424 = env425 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env424 == env425) = true)

theorem identity425 : scanCanonicalize (H12AffineFastState.compose env425 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(18+1) ^^^ 75174) := by decide +kernel

theorem selectedBound425 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env426 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,4096,8192,4177,8232,65536,1344,2049,75174,8232,4096,10249,5457,74028,8329,5376,8461,4177,1297,8461,1285,4294967296,257,4294977577,1345,137]

theorem envBound426 : H12AffineFastState.Bounded env426 := by
  intro p hp
  have h : env426.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans425_426 : H12AffineEnvironment.transform 18 75174 env425 = env426 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 75174 env425 == env426) = true)

theorem identity426 : scanCanonicalize (H12AffineFastState.compose env426 (packedSelected [0,7] rootPS)) = affineNative (2^(12+1) ^^^ 7197) := by decide +kernel

theorem selectedBound426 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env427 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,4096,7197,4177,7221,65536,1344,2049,72123,7221,4096,5140,5457,73009,7316,5376,7440,4177,1297,7440,1285,4294967296,257,4294972468,1345,137]

theorem envBound427 : H12AffineFastState.Bounded env427 := by
  intro p hp
  have h : env427.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans426_427 : H12AffineEnvironment.transform 12 7197 env426 = env427 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 7197 env426 == env427) = true)

def env428 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4176,8232,65536,1344,2048,524288,8232,4096,10249,5456,74028,8329,5376,8461,4176,1297,8460,1285,4294967296,257,4295560590,1345,136]

theorem envBound428 : H12AffineFastState.Bounded env428 := by
  intro p hp
  have h : env428.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans424_428 : H12AffineEnvironment.transform 8 137 env424 = env428 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env424 == env428) = true)

theorem identity428 : scanCanonicalize (H12AffineFastState.compose env428 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 8614) := by decide +kernel

theorem selectedBound428 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env429 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,4096,8192,4176,8232,8614,1344,2048,524288,8232,4096,10249,5456,138,8329,5376,8461,4176,1297,8460,1285,4294967296,257,4295502888,1345,136]

theorem envBound429 : H12AffineFastState.Bounded env429 := by
  intro p hp
  have h : env429.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans428_429 : H12AffineEnvironment.transform 15 8614 env428 = env429 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8614 env428 == env429) = true)

theorem identity429 : scanCanonicalize (H12AffineFastState.compose env429 (packedSelected [2,4] rootPS)) = affineNative (2^(11+1) ^^^ 1044) := by decide +kernel

theorem selectedBound429 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env430 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1044,8192,1092,8232,8614,1344,2048,524288,8232,1044,10249,324,138,8329,276,8461,1092,1297,8460,1285,4294967296,257,4295502888,1345,136]

theorem envBound430 : H12AffineFastState.Bounded env430 := by
  intro p hp
  have h : env430.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans429_430 : H12AffineEnvironment.transform 11 1044 env429 = env430 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1044 env429 == env430) = true)

theorem identity430 : scanCanonicalize (H12AffineFastState.compose env430 (packedSelected [0,7] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound430 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env431 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,1044,8192,1092,8232,8354,1092,2048,524288,8232,1044,10249,64,138,8329,16,8201,1092,1045,8200,1025,4294967296,5,4295502888,1093,136]

theorem envBound431 : H12AffineFastState.Bounded env431 := by
  intro p hp
  have h : env431.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans430_431 : H12AffineEnvironment.transform 7 4 env430 = env431 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env430 == env431) = true)

theorem identity431 : scanCanonicalize (H12AffineFastState.compose env431 (packedSelected [1,3,5,10,13] rootPS)) = affineNative (2^(12+1) ^^^ 2057) := by decide +kernel

theorem selectedBound431 : packedSelected [1,3,5,10,13] rootPS < 2^1333 := by decide +kernel

def env432 : List Nat := [2,4,8,16,32,64,128,4,137,1024,2048,1044,2057,1092,2081,2219,1092,2048,524288,2081,1044,0,64,138,2176,16,2048,1092,1045,2049,1025,4294967296,5,4295492641,1093,136]

theorem envBound432 : H12AffineFastState.Bounded env432 := by
  intro p hp
  have h : env432.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans431_432 : H12AffineEnvironment.transform 12 2057 env431 = env432 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2057 env431 == env432) = true)

def env433 : List Nat := [2,4,8,16,0,64,128,4,137,1024,2048,1044,2057,1092,2049,2187,1092,2048,524288,2049,1044,0,64,138,2176,16,2048,1092,1045,2049,1025,4294967296,5,4295492609,1093,136]

theorem envBound433 : H12AffineFastState.Bounded env433 := by
  intro p hp
  have h : env433.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans432_433 : H12AffineEnvironment.transform 4 0 env432 = env433 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env432 == env433) = true)

theorem identity433 : scanCanonicalize (H12AffineFastState.compose env433 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 3287) := by decide +kernel

theorem selectedBound433 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env434 : List Nat := [2,4,8,16,0,64,128,4,137,1024,2048,1044,2057,1092,2049,2187,1092,2048,524288,2049,1044,0,64,138,2176,16,2048,1092,1045,2049,1025,3287,5,526550,1093,136]

theorem envBound434 : H12AffineFastState.Bounded env434 := by
  intro p hp
  have h : env434.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans433_434 : H12AffineEnvironment.transform 31 3287 env433 = env434 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 3287 env433 == env434) = true)

theorem identity434 : scanCanonicalize (H12AffineFastState.compose env434 (packedSelected [2,3] rootPS)) = affineNative (2^(18+1) ^^^ 1024) := by decide +kernel

theorem selectedBound434 : packedSelected [2,3] rootPS < 2^1333 := by decide +kernel

def env435 : List Nat := [2,4,8,16,0,64,128,4,137,1024,2048,1044,2057,1092,2049,2187,1092,2048,1024,2049,1044,0,64,138,2176,16,2048,1092,1045,2049,1025,3287,5,3286,1093,136]

theorem envBound435 : H12AffineFastState.Bounded env435 := by
  intro p hp
  have h : env435.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans434_435 : H12AffineEnvironment.transform 18 1024 env434 = env435 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env434 == env435) = true)

theorem identity435 : scanCanonicalize (H12AffineFastState.compose env435 (packedSelected [1] rootPS)) = affineNative (2^(10+1) ^^^ 1238) := by decide +kernel

theorem selectedBound435 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env436 : List Nat := [2,4,8,16,0,64,128,4,137,1024,1238,1044,1247,1092,1239,1117,1092,1238,1024,1239,1044,0,64,138,1110,16,1238,1092,1045,1239,1025,1,5,0,1093,136]

theorem envBound436 : H12AffineFastState.Bounded env436 := by
  intro p hp
  have h : env436.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans435_436 : H12AffineEnvironment.transform 10 1238 env435 = env436 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1238 env435 == env436) = true)

theorem identity436 : scanCanonicalize (H12AffineFastState.compose env436 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 89) := by decide +kernel

theorem selectedBound436 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env437 : List Nat := [2,4,8,16,0,64,89,4,80,1024,1039,1044,1030,1092,1038,1117,1092,1039,1024,1038,1044,0,64,83,1110,16,1039,1092,1045,1038,1025,1,5,0,1093,81]

theorem envBound437 : H12AffineFastState.Bounded env437 := by
  intro p hp
  have h : env437.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans436_437 : H12AffineEnvironment.transform 6 89 env436 = env437 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env436 == env437) = true)

def leafEnv437 : List Nat := [2,4,8,16,0,64,89,4,80,1024,1039,1044,1030,1092,1038,1117,1092,1039,1024,1038,1044,0,64,83,1024,1110,1,16,1039,1092,1045,1038,1025,1,5,0,4,1037,1093,81,0,1044,1]

def active437 : List Nat := [0,1,2,3,5,9]

def tree437 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood437 : H12WitnessSearch.Good tree437 := H12GlobalWitnessIndex.good

theorem leafIdentity437 : H12AffineFastState.composeSystem env437 rootObs = leafEnv437 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env437 rootObs == leafEnv437) = true)

theorem terminalChecked437 : H12PackedTerminal.terminalCheckFast leafEnv437 active437 tree437 = true := by decide +kernel

def env438 : List Nat := [2,4,8,16,1,64,128,4,137,1024,2048,1044,2057,1092,2048,2186,1092,2048,524288,2048,1044,0,64,138,2176,16,2048,1092,1045,2049,1025,4294967296,5,4295492608,1093,136]

theorem envBound438 : H12AffineFastState.Bounded env438 := by
  intro p hp
  have h : env438.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans432_438 : H12AffineEnvironment.transform 4 1 env432 = env438 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env432 == env438) = true)

theorem identity438 : scanCanonicalize (H12AffineFastState.compose env438 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 3166) := by decide +kernel

theorem selectedBound438 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env439 : List Nat := [2,4,8,16,1,64,128,4,137,1024,2048,1044,2057,1092,2048,2186,1092,2048,524288,2048,1044,0,64,138,2176,16,2048,1092,1045,2049,1025,3166,5,526430,1093,136]

theorem envBound439 : H12AffineFastState.Bounded env439 := by
  intro p hp
  have h : env439.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans438_439 : H12AffineEnvironment.transform 31 3166 env438 = env439 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 3166 env438 == env439) = true)

def env440 : List Nat := [2,4,8,16,1,64,128,4,137,1024,2048,1044,2057,1092,2048,2186,1092,2048,1024,2048,1044,0,64,138,2176,16,2048,1092,1045,2049,1025,3166,5,3166,1093,136]

theorem envBound440 : H12AffineFastState.Bounded env440 := by
  intro p hp
  have h : env440.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans439_440 : H12AffineEnvironment.transform 18 1024 env439 = env440 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env439 == env440) = true)

theorem identity440 : scanCanonicalize (H12AffineFastState.compose env440 (packedSelected [1] rootPS)) = affineNative (2^(10+1) ^^^ 1159) := by decide +kernel

theorem selectedBound440 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env441 : List Nat := [2,4,8,16,1,64,128,4,137,1024,1159,1044,1166,1092,1159,1037,1092,1159,1024,1159,1044,0,64,138,1031,16,1159,1092,1045,1158,1025,217,5,217,1093,136]

theorem envBound441 : H12AffineFastState.Bounded env441 := by
  intro p hp
  have h : env441.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans440_441 : H12AffineEnvironment.transform 10 1159 env440 = env441 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1159 env440 == env441) = true)

def leafEnv441 : List Nat := [2,4,8,16,1,64,128,4,137,1024,1159,1044,1166,1092,1159,1037,1092,1159,1024,1159,1044,0,64,138,1024,1031,1,16,1159,1092,1045,1158,1025,217,5,217,4,1156,1093,136,0,1044,1]

def active441 : List Nat := [0,1,2,3,5,6,9]

def tree441 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood441 : H12WitnessSearch.Good tree441 := H12GlobalWitnessIndex.good

theorem leafIdentity441 : H12AffineFastState.composeSystem env441 rootObs = leafEnv441 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env441 rootObs == leafEnv441) = true)

theorem terminalChecked441 : H12PackedTerminal.terminalCheckFast leafEnv441 active441 tree441 = true := by decide +kernel

def env442 : List Nat := [2,4,8,16,1,64,128,4,137,1024,2048,1044,2057,1092,2048,2186,1092,2048,1025,2048,1044,0,64,138,2176,16,2048,1092,1045,2049,1025,3166,5,3167,1093,136]

theorem envBound442 : H12AffineFastState.Bounded env442 := by
  intro p hp
  have h : env442.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans439_442 : H12AffineEnvironment.transform 18 1025 env439 = env442 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env439 == env442) = true)

theorem identity442 : scanCanonicalize (H12AffineFastState.compose env442 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound442 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env443 : List Nat := [2,4,8,16,1,64,9,4,0,1024,2048,1044,2057,1092,2048,2051,1092,2048,1025,2048,1044,0,64,3,2057,16,2048,1092,1045,2049,1025,3166,5,3167,1093,1]

theorem envBound443 : H12AffineFastState.Bounded env443 := by
  intro p hp
  have h : env443.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans442_443 : H12AffineEnvironment.transform 6 9 env442 = env443 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env442 == env443) = true)

theorem identity443 : scanCanonicalize (H12AffineFastState.compose env443 (packedSelected [3] rootPS)) = affineNative (2^(10+1) ^^^ 1038) := by decide +kernel

theorem selectedBound443 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env444 : List Nat := [2,4,8,16,1,64,9,4,0,1024,1038,1044,1031,1092,1038,1037,1092,1038,1025,1038,1044,0,64,3,1031,16,1038,1092,1045,1039,1025,80,5,81,1093,1]

theorem envBound444 : H12AffineFastState.Bounded env444 := by
  intro p hp
  have h : env444.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans443_444 : H12AffineEnvironment.transform 10 1038 env443 = env444 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1038 env443 == env444) = true)

def leafEnv444 : List Nat := [2,4,8,16,1,64,9,4,0,1024,1038,1044,1031,1092,1038,1037,1092,1038,1025,1038,1044,0,64,3,1025,1031,1,16,1038,1092,1045,1039,1025,80,5,81,4,1037,1093,1,0,1044,1]

def active444 : List Nat := [0,1,2,3,5,9]

def tree444 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood444 : H12WitnessSearch.Good tree444 := H12GlobalWitnessIndex.good

theorem leafIdentity444 : H12AffineFastState.composeSystem env444 rootObs = leafEnv444 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env444 rootObs == leafEnv444) = true)

theorem terminalChecked444 : H12PackedTerminal.terminalCheckFast leafEnv444 active444 tree444 = true := by decide +kernel

def env445 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,136512,4194304,17664,230468,8329,5377,134217728,16385,138825989,1073741824,138826001,4294967296,138694741,4299935934,131073,513]

theorem envBound445 : H12AffineFastState.Bounded env445 := by
  intro p hp
  have h : env445.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans397_445 : H12AffineEnvironment.transform 25 5377 env397 = env445 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env397 == env445) = true)

def env446 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,136513,4194304,17664,230469,8329,67108864,134217728,67130624,138825989,1073741824,138826000,4294967296,138694741,4367041982,131073,513]

theorem envBound446 : H12AffineFastState.Bounded env446 := by
  intro p hp
  have h : env446.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans396_446 : H12AffineEnvironment.transform 20 136513 env396 = env446 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 136513 env396 == env446) = true)

def env447 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,136513,4194304,17664,230469,8329,5376,134217728,16384,138825989,1073741824,138826000,4294967296,138694741,4299935934,131073,513]

theorem envBound447 : H12AffineFastState.Bounded env447 := by
  intro p hp
  have h : env447.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans446_447 : H12AffineEnvironment.transform 25 5376 env446 = env447 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env446 == env447) = true)

theorem identity447 : scanCanonicalize (H12AffineFastState.compose env447 (packedSelected [4,7,9,16,20,27] rootPS)) = affineNative (2^(26+1) ^^^ 4609045) := by decide +kernel

theorem selectedBound447 : packedSelected [4,7,9,16,20,27] rootPS < 2^1333 := by decide +kernel

def env448 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,136513,4194304,17664,230469,8329,5376,4609045,16384,1296,1073741824,1285,4294967296,132160,4299935934,131073,513]

theorem envBound448 : H12AffineFastState.Bounded env448 := by
  intro p hp
  have h : env448.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans447_448 : H12AffineEnvironment.transform 26 4609045 env447 = env448 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 4609045 env447 == env448) = true)

theorem identity448 : scanCanonicalize (H12AffineFastState.compose env448 (packedSelected [0,4,6,7,16,20,22,25] rootPS)) = affineNative (2^(18+1) ^^^ 21584) := by decide +kernel

theorem selectedBound448 : packedSelected [0,4,6,7,16,20,22,25] rootPS < 2^1333 := by decide +kernel

def env449 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,21584,32768,136513,4194304,17664,230469,8329,5376,4609045,16384,1296,1073741824,1285,4294967296,132160,4299392238,131073,513]

theorem envBound449 : H12AffineFastState.Bounded env449 := by
  intro p hp
  have h : env449.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans448_449 : H12AffineEnvironment.transform 18 21584 env448 = env449 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 21584 env448 == env449) = true)

theorem identity449 : scanCanonicalize (H12AffineFastState.compose env449 (packedSelected [0,7,9,20,22] rootPS)) = affineNative (2^(16+1) ^^^ 21776) := by decide +kernel

theorem selectedBound449 : packedSelected [0,7,9,20,22] rootPS < 2^1333 := by decide +kernel

def env450 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21776,262144,21584,32768,16465,4194304,17664,119125,8329,5376,4456709,16384,1296,1073741824,1285,4294967296,20816,4299280894,21777,513]

theorem envBound450 : H12AffineFastState.Bounded env450 := by
  intro p hp
  have h : env450.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans449_450 : H12AffineEnvironment.transform 16 21776 env449 = env450 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 21776 env449 == env450) = true)

theorem identity450 : scanCanonicalize (H12AffineFastState.compose env450 (packedSelected [4,9,16] rootPS)) = affineNative (2^(29+1) ^^^ 4315354) := by decide +kernel

theorem selectedBound450 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env451 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21776,262144,21584,32768,16465,4194304,17664,119125,8329,5376,4456709,16384,1296,4315354,1285,4294967296,20816,4299280894,21777,513]

theorem envBound451 : H12AffineFastState.Bounded env451 := by
  intro p hp
  have h : env451.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans450_451 : H12AffineEnvironment.transform 29 4315354 env450 = env451 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4315354 env450 == env451) = true)

theorem identity451 : scanCanonicalize (H12AffineFastState.compose env451 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 4177) := by decide +kernel

theorem selectedBound451 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env452 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,1345,262144,1025,32768,4096,4194304,5457,98564,8329,5376,4456709,4177,1296,4294795,1285,4294967296,257,4299260335,1344,513]

theorem envBound452 : H12AffineFastState.Bounded env452 := by
  intro p hp
  have h : env452.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans451_452 : H12AffineEnvironment.transform 13 4177 env451 = env452 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env451 == env452) = true)

theorem identity452 : scanCanonicalize (H12AffineFastState.compose env452 (packedSelected [3,5,10] rootPS)) = affineNative (2^(21+1) ^^^ 79282) := by decide +kernel

theorem selectedBound452 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env453 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,1345,262144,1025,32768,4096,79282,5457,98564,8329,5376,341175,4177,1296,48441,1285,4294967296,257,4295013405,1344,513]

theorem envBound453 : H12AffineFastState.Bounded env453 := by
  intro p hp
  have h : env453.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans452_453 : H12AffineEnvironment.transform 21 79282 env452 = env453 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 79282 env452 == env453) = true)

theorem identity453 : scanCanonicalize (H12AffineFastState.compose env453 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(31+1) ^^^ 305573) := by decide +kernel

theorem selectedBound453 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env454 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,1345,262144,1025,32768,4096,79282,5457,98564,8329,5376,341175,4177,1296,48441,1285,305573,257,269752,1344,513]

theorem envBound454 : H12AffineFastState.Bounded env454 := by
  intro p hp
  have h : env454.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans453_454 : H12AffineEnvironment.transform 31 305573 env453 = env454 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 305573 env453 == env454) = true)

theorem identity454 : scanCanonicalize (H12AffineFastState.compose env454 (packedSelected [5,8,13,17] rootPS)) = affineNative (2^(17+1) ^^^ 7952) := by decide +kernel

theorem selectedBound454 : packedSelected [5,8,13,17] rootPS < 2^1333 := by decide +kernel

def env455 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,1345,7952,1025,32768,4096,79282,5457,98564,8329,5376,76711,4177,1296,48441,1285,46773,257,680,1344,513]

theorem envBound455 : H12AffineFastState.Bounded env455 := by
  intro p hp
  have h : env455.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans454_455 : H12AffineEnvironment.transform 17 7952 env454 = env455 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 7952 env454 == env455) = true)

theorem identity455 : scanCanonicalize (H12AffineFastState.compose env455 (packedSelected [0,7,20] rootPS)) = affineNative (2^(8+1) ^^^ 216) := by decide +kernel

theorem selectedBound455 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env456 : List Nat := [2,4,8,16,32,64,128,256,216,1024,2048,4096,8192,4177,32768,65536,1345,7624,1025,32768,4096,79282,5457,98564,8329,5376,76159,4177,1296,48441,1285,46189,257,112,1344,217]

theorem envBound456 : H12AffineFastState.Bounded env456 := by
  intro p hp
  have h : env456.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans455_456 : H12AffineEnvironment.transform 8 216 env455 = env456 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 216 env455 == env456) = true)

theorem identity456 : scanCanonicalize (H12AffineFastState.compose env456 (packedSelected [13,21] rootPS)) = affineNative (2^(15+1) ^^^ 37959) := by decide +kernel

theorem selectedBound456 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env457 : List Nat := [2,4,8,16,32,64,128,256,216,1024,2048,4096,8192,4177,32768,37959,1345,7624,1025,32768,4096,41461,5457,5443,8329,5376,48440,4177,1296,48441,1285,46189,257,112,1344,217]

theorem envBound457 : H12AffineFastState.Bounded env457 := by
  intro p hp
  have h : env457.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans456_457 : H12AffineEnvironment.transform 15 37959 env456 = env457 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 37959 env456 == env457) = true)

theorem identity457 : scanCanonicalize (H12AffineFastState.compose env457 (packedSelected [0,3,4,5,7,9,12,13,18,23] rootPS)) = affineNative (2^(14+1) ^^^ 7488) := by decide +kernel

theorem selectedBound457 : packedSelected [0,3,4,5,7,9,12,13,18,23] rootPS < 2^1333 := by decide +kernel

def env458 : List Nat := [2,4,8,16,32,64,128,256,216,1024,2048,4096,8192,4177,7488,2311,1345,7624,1025,7488,4096,15541,5457,5443,8329,5376,8312,4177,1296,8313,1285,10541,257,112,1344,217]

theorem envBound458 : H12AffineFastState.Bounded env458 := by
  intro p hp
  have h : env458.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans457_458 : H12AffineEnvironment.transform 14 7488 env457 = env458 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 7488 env457 == env458) = true)

theorem identity458 : scanCanonicalize (H12AffineFastState.compose env458 (packedSelected [0,1,3,11,13,18] rootPS)) = affineNative (2^(12+1) ^^^ 1515) := by decide +kernel

theorem selectedBound458 : packedSelected [0,1,3,11,13,18] rootPS < 2^1333 := by decide +kernel

def env459 : List Nat := [2,4,8,16,32,64,128,256,216,1024,2048,4096,1515,4177,7488,2311,1345,7624,1025,7488,4096,6494,5457,5443,1378,5376,1427,4177,1296,1426,1285,3270,257,112,1344,217]

theorem envBound459 : H12AffineFastState.Bounded env459 := by
  intro p hp
  have h : env459.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans458_459 : H12AffineEnvironment.transform 12 1515 env458 = env459 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1515 env458 == env459) = true)

theorem identity459 : scanCanonicalize (H12AffineFastState.compose env459 (packedSelected [1,3,5,12,13,24] rootPS)) = affineNative (2^(11+1) ^^^ 2179) := by decide +kernel

theorem selectedBound459 : packedSelected [1,3,5,12,13,24] rootPS < 2^1333 := by decide +kernel

def env460 : List Nat := [2,4,8,16,32,64,128,256,216,1024,2048,2179,1515,2258,1475,2311,1345,1355,1025,1475,2179,477,3538,3520,1378,3459,1427,2258,1296,1426,1285,3270,257,112,1344,217]

theorem envBound460 : H12AffineFastState.Bounded env460 := by
  intro p hp
  have h : env460.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans459_460 : H12AffineEnvironment.transform 11 2179 env459 = env460 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 2179 env459 == env460) = true)

theorem identity460 : scanCanonicalize (H12AffineFastState.compose env460 (packedSelected [0,1,2,3,5] rootPS)) = affineNative (2^(10+1) ^^^ 1181) := by decide +kernel

theorem selectedBound460 : packedSelected [0,1,2,3,5] rootPS < 2^1333 := by decide +kernel

def env461 : List Nat := [2,4,8,16,32,64,128,256,216,1024,1181,1054,1515,1103,1475,1434,1345,1355,1025,1475,1054,477,335,349,1378,286,1427,1103,1296,1426,1285,91,257,112,1344,217]

theorem envBound461 : H12AffineFastState.Bounded env461 := by
  intro p hp
  have h : env461.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans460_461 : H12AffineEnvironment.transform 10 1181 env460 = env461 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1181 env460 == env461) = true)

theorem identity461 : scanCanonicalize (H12AffineFastState.compose env461 (packedSelected [1,2,3,4,7,8,9] rootPS)) = affineNative (2^(7+1) ^^^ 15) := by decide +kernel

theorem selectedBound461 : packedSelected [1,2,3,4,7,8,9] rootPS < 2^1333 := by decide +kernel

def env462 : List Nat := [2,4,8,16,32,64,128,15,216,1024,1181,1054,1252,1103,1228,1173,1102,1092,1025,1228,1054,210,64,82,1133,17,1180,1103,1055,1181,1034,91,14,112,1103,217]

theorem envBound462 : H12AffineFastState.Bounded env462 := by
  intro p hp
  have h : env462.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans461_462 : H12AffineEnvironment.transform 7 15 env461 = env462 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 15 env461 == env462) = true)

theorem identity462 : scanCanonicalize (H12AffineFastState.compose env462 (packedSelected [0,2] rootPS)) = affineNative (2^(9+1) ^^^ 231) := by decide +kernel

theorem selectedBound462 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env463 : List Nat := [2,4,8,16,32,64,128,15,216,231,122,249,3,168,43,114,169,163,230,43,249,210,64,82,138,17,123,168,248,122,237,91,14,112,168,217]

theorem envBound463 : H12AffineFastState.Bounded env463 := by
  intro p hp
  have h : env463.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans462_463 : H12AffineEnvironment.transform 9 231 env462 = env463 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 231 env462 == env463) = true)

theorem identity463 : scanCanonicalize (H12AffineFastState.compose env463 (packedSelected [0,6] rootPS)) = affineNative (2^(5+1) ^^^ 27) := by decide +kernel

theorem selectedBound463 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env464 : List Nat := [2,4,8,16,32,27,128,15,131,188,33,162,3,168,43,41,169,163,189,43,162,137,27,9,138,17,32,168,163,33,182,0,14,43,168,130]

theorem envBound464 : H12AffineFastState.Bounded env464 := by
  intro p hp
  have h : env464.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans463_464 : H12AffineEnvironment.transform 5 27 env463 = env464 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 27 env463 == env464) = true)

theorem identity464 : scanCanonicalize (H12AffineFastState.compose env464 (packedSelected [1,4] rootPS)) = affineNative (2^(6+1) ^^^ 34) := by decide +kernel

theorem selectedBound464 : packedSelected [1,4] rootPS < 2^1333 := by decide +kernel

def env465 : List Nat := [2,4,8,16,32,27,34,15,33,30,33,0,3,10,43,41,11,1,31,43,0,43,27,9,40,17,32,10,1,33,20,0,14,43,10,32]

theorem envBound465 : H12AffineFastState.Bounded env465 := by
  intro p hp
  have h : env465.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans464_465 : H12AffineEnvironment.transform 6 34 env464 = env465 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 34 env464 == env465) = true)

theorem identity465 : scanCanonicalize (H12AffineFastState.compose env465 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 16) := by decide +kernel

theorem selectedBound465 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env466 : List Nat := [2,4,8,16,16,27,18,15,17,30,17,0,3,10,27,25,11,1,31,27,0,27,27,9,24,17,16,10,1,17,20,0,14,27,10,16]

theorem envBound466 : H12AffineFastState.Bounded env466 := by
  intro p hp
  have h : env466.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans465_466 : H12AffineEnvironment.transform 4 16 env465 = env466 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env465 == env466) = true)

theorem identity466 : scanCanonicalize (H12AffineFastState.compose env466 (packedSelected [0,7] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound466 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env467 : List Nat := [2,4,3,16,16,16,18,4,17,21,17,0,3,1,16,18,0,1,20,16,0,16,16,2,19,17,16,1,1,17,20,0,5,16,1,16]

theorem envBound467 : H12AffineFastState.Bounded env467 := by
  intro p hp
  have h : env467.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans466_467 : H12AffineEnvironment.transform 2 3 env466 = env467 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env466 == env467) = true)

theorem identity467 : scanCanonicalize (H12AffineFastState.compose env467 (packedSelected [8] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound467 : packedSelected [8] rootPS < 2^1333 := by decide +kernel

def env468 : List Nat := [2,4,3,1,1,1,3,4,0,4,0,0,3,1,1,3,0,1,5,1,0,1,1,2,2,0,1,1,1,0,5,0,5,1,1,1]

theorem envBound468 : H12AffineFastState.Bounded env468 := by
  intro p hp
  have h : env468.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans467_468 : H12AffineEnvironment.transform 3 1 env467 = env468 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env467 == env468) = true)

def env469 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,136513,4194304,17664,230469,8329,5377,134217728,16385,138825989,1073741824,138826000,4294967296,138694741,4299935935,131073,513]

theorem envBound469 : H12AffineFastState.Bounded env469 := by
  intro p hp
  have h : env469.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans446_469 : H12AffineEnvironment.transform 25 5377 env446 = env469 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env446 == env469) = true)

theorem identity469 : scanCanonicalize (H12AffineFastState.compose env469 (packedSelected [4,7,9,16,20,27] rootPS)) = affineNative (2^(26+1) ^^^ 4477269) := by decide +kernel

theorem selectedBound469 : packedSelected [4,7,9,16,20,27] rootPS < 2^1333 := by decide +kernel

def env470 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,136513,4194304,17664,230469,8329,5377,4477269,16385,131152,1073741824,131141,4294967296,256,4299935935,131073,513]

theorem envBound470 : H12AffineFastState.Bounded env470 := by
  intro p hp
  have h : env470.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans469_470 : H12AffineEnvironment.transform 26 4477269 env469 = env470 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 4477269 env469 == env470) = true)

theorem identity470 : scanCanonicalize (H12AffineFastState.compose env470 (packedSelected [0,3,4,6,7,10,16,20,22,24,25,26] rootPS)) = affineNative (2^(16+1) ^^^ 1345) := by decide +kernel

theorem selectedBound470 : packedSelected [0,3,4,6,7,10,16,20,22,24,25,26] rootPS < 2^1333 := by decide +kernel

def env471 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4096,4194304,17664,98564,8329,5377,4477269,16385,1297,1073741824,1284,4294967296,256,4299806206,1344,513]

theorem envBound471 : H12AffineFastState.Bounded env471 := by
  intro p hp
  have h : env471.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans470_471 : H12AffineEnvironment.transform 16 1345 env470 = env471 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env470 == env471) = true)

theorem identity471 : scanCanonicalize (H12AffineFastState.compose env471 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(13+1) ^^^ 4824) := by decide +kernel

theorem selectedBound471 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env472 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4824,32768,65536,1345,262144,524288,32768,4096,4194304,6104,98564,8329,5377,4457357,4825,1297,1073741824,1284,4294967296,256,4299786022,1344,513]

theorem envBound472 : H12AffineFastState.Bounded env472 := by
  intro p hp
  have h : env472.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans471_472 : H12AffineEnvironment.transform 13 4824 env471 = env472 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4824 env471 == env472) = true)

theorem identity472 : scanCanonicalize (H12AffineFastState.compose env472 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(17+1) ^^^ 43681) := by decide +kernel

theorem selectedBound472 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env473 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4824,32768,65536,1345,43681,524288,32768,4096,4194304,6104,98564,8329,5377,4237612,4825,1297,1073741824,1284,4294967296,256,4299786022,1344,513]

theorem envBound473 : H12AffineFastState.Bounded env473 := by
  intro p hp
  have h : env473.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans472_473 : H12AffineEnvironment.transform 17 43681 env472 = env473 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43681 env472 == env473) = true)

theorem identity473 : scanCanonicalize (H12AffineFastState.compose env473 (packedSelected [0,4,7,9,18,23] rootPS)) = affineNative (2^(29+1) ^^^ 4197260) := by decide +kernel

theorem selectedBound473 : packedSelected [0,4,7,9,18,23] rootPS < 2^1333 := by decide +kernel

def env474 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4824,32768,65536,1345,43681,524288,32768,4096,4194304,6104,98564,8329,5377,4237612,4825,1297,4197260,1284,4294967296,256,4299786022,1344,513]

theorem envBound474 : H12AffineFastState.Bounded env474 := by
  intro p hp
  have h : env474.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans473_474 : H12AffineEnvironment.transform 29 4197260 env473 = env474 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4197260 env473 == env474) = true)

def env475 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4824,32768,65536,1345,43681,524288,32768,4096,10248,6104,98564,8329,5377,33060,4825,1297,9092,1284,4294967296,256,4295601966,1344,513]

theorem envBound475 : H12AffineFastState.Bounded env475 := by
  intro p hp
  have h : env475.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans474_475 : H12AffineEnvironment.transform 21 10248 env474 = env475 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10248 env474 == env475) = true)

end H12GlobalChart2
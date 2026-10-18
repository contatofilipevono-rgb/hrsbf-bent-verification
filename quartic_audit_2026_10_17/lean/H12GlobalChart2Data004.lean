import H12GlobalChart2Data003

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem envTrans951_952 : H12AffineEnvironment.transform 6 8 env951 = env952 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env951 == env952) = true)

theorem identity952 : scanCanonicalize (H12AffineFastState.compose env952 (packedSelected [1,3] rootPS)) = affineNative (2^(9+1) ^^^ 47) := by decide +kernel

theorem selectedBound952 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env953 : List Nat := [2,4,8,16,32,17,8,5,1,47,0,26,41,27,33,35,59,32,524288,33,26,1,49,2,40,48,33,26,58,0,46,0,4,524303,59,0]

theorem envBound953 : H12AffineFastState.Bounded env953 := by
  intro p hp
  have h : env953.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans952_953 : H12AffineEnvironment.transform 9 47 env952 = env953 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 47 env952 == env953) = true)

def leafEnv953 : List Nat := [2,4,8,16,32,17,8,5,1,47,0,26,41,27,33,35,59,32,524288,33,26,1,49,2,524288,40,1,48,33,26,58,0,46,0,4,524303,4,34,59,0,0,59,1]

def active953 : List Nat := [0,1,2,3,4,18]

def tree953 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood953 : H12WitnessSearch.Good tree953 := H12GlobalWitnessIndex.good

theorem leafIdentity953 : H12AffineFastState.composeSystem env953 rootObs = leafEnv953 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env953 rootObs == leafEnv953) = true)

theorem terminalChecked953 : H12PackedTerminal.terminalCheckFast leafEnv953 active953 tree953 = true := by decide +kernel

def env954 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,4096,4283,4176,4414,65536,1344,4274,524288,4414,4096,260,5456,69691,4146,5376,4275,4177,1296,69808,1284,340,257,595136,1344,136]

theorem envBound954 : H12AffineFastState.Bounded env954 := by
  intro p hp
  have h : env954.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans941_954 : H12AffineEnvironment.transform 10 1 env941 = env954 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env941 == env954) = true)

theorem identity954 : scanCanonicalize (H12AffineFastState.compose env954 (packedSelected [0] rootPS)) = affineNative (2^(11+1) ^^^ 27) := by decide +kernel

theorem selectedBound954 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env955 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,27,160,75,293,65536,1344,169,524288,293,27,260,1355,65568,41,1307,168,74,1296,65707,1284,340,257,591067,1344,136]

theorem envBound955 : H12AffineFastState.Bounded env955 := by
  intro p hp
  have h : env955.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans954_955 : H12AffineEnvironment.transform 11 27 env954 = env955 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 27 env954 == env955) = true)

theorem identity955 : scanCanonicalize (H12AffineFastState.compose env955 (packedSelected [11,18] rootPS)) = affineNative (2^(15+1) ^^^ 431) := by decide +kernel

theorem selectedBound955 : packedSelected [11,18] rootPS < 2^1333 := by decide +kernel

def env956 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,27,160,75,293,431,1344,169,524288,293,27,260,1355,399,41,1307,168,74,1296,260,1284,340,257,525684,1344,136]

theorem envBound956 : H12AffineFastState.Bounded env956 := by
  intro p hp
  have h : env956.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans955_956 : H12AffineEnvironment.transform 15 431 env955 = env956 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 431 env955 == env956) = true)

theorem identity956 : scanCanonicalize (H12AffineFastState.compose env956 (packedSelected [2,4,11] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound956 : packedSelected [2,4,11] rootPS < 2^1333 := by decide +kernel

def env957 : List Nat := [2,4,8,16,32,64,128,5,137,1024,1,27,160,75,32,170,1093,169,524288,32,27,1,1102,138,41,1054,168,74,1045,1,1025,81,4,525425,1093,136]

theorem envBound957 : H12AffineFastState.Bounded env957 := by
  intro p hp
  have h : env957.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans956_957 : H12AffineEnvironment.transform 7 5 env956 = env957 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env956 == env957) = true)

def env958 : List Nat := [2,4,8,16,32,16,128,5,137,1024,1,27,160,27,32,170,1045,169,524288,32,27,1,1054,138,41,1054,168,26,1045,1,1025,1,4,525345,1045,136]

theorem envBound958 : H12AffineFastState.Bounded env958 := by
  intro p hp
  have h : env958.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans957_958 : H12AffineEnvironment.transform 5 16 env957 = env958 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env957 == env958) = true)

theorem identity958 : scanCanonicalize (H12AffineFastState.compose env958 (packedSelected [2] rootPS)) = affineNative (2^(9+1) ^^^ 166) := by decide +kernel

theorem selectedBound958 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env959 : List Nat := [2,4,8,16,32,16,128,5,137,166,1,27,160,27,32,170,179,169,524288,32,27,1,184,138,41,184,168,26,179,1,167,1,4,524423,179,136]

theorem envBound959 : H12AffineFastState.Bounded env959 := by
  intro p hp
  have h : env959.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans958_959 : H12AffineEnvironment.transform 9 166 env958 = env959 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 166 env958 == env959) = true)

def env960 : List Nat := [2,4,8,16,32,16,8,5,1,46,1,27,40,27,32,34,59,33,524288,32,27,1,48,2,41,48,32,26,59,1,47,1,4,524303,59,0]

theorem envBound960 : H12AffineFastState.Bounded env960 := by
  intro p hp
  have h : env960.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans959_960 : H12AffineEnvironment.transform 6 8 env959 = env960 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env959 == env960) = true)

def leafEnv960 : List Nat := [2,4,8,16,32,16,8,5,1,46,1,27,40,27,32,34,59,33,524288,32,27,1,48,2,524288,41,1,48,32,26,59,1,47,1,4,524303,4,35,59,0,0,58,1]

def active960 : List Nat := [0,1,2,3,4,18]

def tree960 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood960 : H12WitnessSearch.Good tree960 := H12GlobalWitnessIndex.good

theorem leafIdentity960 : H12AffineFastState.composeSystem env960 rootObs = leafEnv960 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env960 rootObs == leafEnv960) = true)

theorem terminalChecked960 : H12PackedTerminal.terminalCheckFast leafEnv960 active960 tree960 = true := by decide +kernel

def env961 : List Nat := [2,4,8,16,32,16,9,5,0,47,1,27,41,27,32,35,58,32,524288,32,27,1,49,3,41,49,33,26,58,1,46,1,4,524302,58,1]

theorem envBound961 : H12AffineFastState.Bounded env961 := by
  intro p hp
  have h : env961.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans959_961 : H12AffineEnvironment.transform 6 9 env959 = env961 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env959 == env961) = true)

theorem identity961 : scanCanonicalize (H12AffineFastState.compose env961 (packedSelected [1] rootPS)) = affineNative (2^(18+1) ^^^ 47) := by decide +kernel

theorem selectedBound961 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env962 : List Nat := [2,4,8,16,32,16,9,5,0,47,1,27,41,27,32,35,58,32,47,32,27,1,49,3,41,49,33,26,58,1,46,1,4,33,58,1]

theorem envBound962 : H12AffineFastState.Bounded env962 := by
  intro p hp
  have h : env962.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans961_962 : H12AffineEnvironment.transform 18 47 env961 = env962 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 47 env961 == env962) = true)

def leafEnv962 : List Nat := [2,4,8,16,32,16,9,5,0,47,1,27,41,27,32,35,58,32,47,32,27,1,49,3,47,41,1,49,33,26,58,1,46,1,4,33,4,35,58,1,0,59,1]

def active962 : List Nat := [0,1,2,3,4]

def tree962 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood962 : H12WitnessSearch.Good tree962 := H12GlobalWitnessIndex.good

theorem leafIdentity962 : H12AffineFastState.composeSystem env962 rootObs = leafEnv962 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env962 rootObs == leafEnv962) = true)

theorem terminalChecked962 : H12PackedTerminal.terminalCheckFast leafEnv962 active962 tree962 = true := by decide +kernel

def env963 : List Nat := [2,4,8,16,32,17,128,5,137,1024,1,27,160,26,32,170,1044,169,524288,32,27,1,1055,138,41,1054,168,27,1045,1,1025,0,4,525344,1044,136]

theorem envBound963 : H12AffineFastState.Bounded env963 := by
  intro p hp
  have h : env963.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans957_963 : H12AffineEnvironment.transform 5 17 env957 = env963 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env957 == env963) = true)

theorem identity963 : scanCanonicalize (H12AffineFastState.compose env963 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound963 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env964 : List Nat := [2,4,8,16,32,17,8,5,1,1024,1,27,40,26,32,34,1044,33,524288,32,27,1,1055,2,41,1054,32,27,1045,1,1025,0,4,525344,1044,0]

theorem envBound964 : H12AffineFastState.Bounded env964 := by
  intro p hp
  have h : env964.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans963_964 : H12AffineEnvironment.transform 6 8 env963 = env964 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env963 == env964) = true)

theorem identity964 : scanCanonicalize (H12AffineFastState.compose env964 (packedSelected [1,3] rootPS)) = affineNative (2^(9+1) ^^^ 46) := by decide +kernel

theorem selectedBound964 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env965 : List Nat := [2,4,8,16,32,17,8,5,1,46,1,27,40,26,32,34,58,33,524288,32,27,1,49,2,41,48,32,27,59,1,47,0,4,524302,58,0]

theorem envBound965 : H12AffineFastState.Bounded env965 := by
  intro p hp
  have h : env965.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans964_965 : H12AffineEnvironment.transform 9 46 env964 = env965 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 46 env964 == env965) = true)

def leafEnv965 : List Nat := [2,4,8,16,32,17,8,5,1,46,1,27,40,26,32,34,58,33,524288,32,27,1,49,2,524288,41,1,48,32,27,59,1,47,0,4,524302,4,35,58,0,0,58,1]

def active965 : List Nat := [0,1,2,3,4,18]

def tree965 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood965 : H12WitnessSearch.Good tree965 := H12GlobalWitnessIndex.good

theorem leafIdentity965 : H12AffineFastState.composeSystem env965 rootObs = leafEnv965 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env965 rootObs == leafEnv965) = true)

theorem terminalChecked965 : H12PackedTerminal.terminalCheckFast leafEnv965 active965 tree965 = true := by decide +kernel

def env966 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,136513,4194304,5456,98564,8329,135233,4456708,136464,1297,4294795,131140,4294967296,132160,4299915502,131072,513]

theorem envBound966 : H12AffineFastState.Bounded env966 := by
  intro p hp
  have h : env966.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans889_966 : H12AffineEnvironment.transform 20 136513 env889 = env966 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 136513 env889 == env966) = true)

theorem identity966 : scanCanonicalize (H12AffineFastState.compose env966 (packedSelected [0,7,9,20,22] rootPS)) = affineNative (2^(18+1) ^^^ 1024) := by decide +kernel

theorem selectedBound966 : packedSelected [0,7,9,20,22] rootPS < 2^1333 := by decide +kernel

def env967 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1024,32768,136513,4194304,5456,98564,8329,135233,4456708,136464,1297,4294795,131140,4294967296,132160,4299392238,131072,513]

theorem envBound967 : H12AffineFastState.Bounded env967 := by
  intro p hp
  have h : env967.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans966_967 : H12AffineEnvironment.transform 18 1024 env966 = env967 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env966 == env967) = true)

theorem identity967 : scanCanonicalize (H12AffineFastState.compose env967 (packedSelected [4,9,16] rootPS)) = affineNative (2^(16+1) ^^^ 1345) := by decide +kernel

theorem selectedBound967 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env968 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1345,262144,1024,32768,4096,4194304,5456,98564,8329,5376,4456708,4177,1297,4294795,1285,4294967296,257,4299260335,1345,513]

theorem envBound968 : H12AffineFastState.Bounded env968 := by
  intro p hp
  have h : env968.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans967_968 : H12AffineEnvironment.transform 16 1345 env967 = env968 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env967 == env968) = true)

theorem identity968 : scanCanonicalize (H12AffineFastState.compose env968 (packedSelected [3,5,10] rootPS)) = affineNative (2^(31+1) ^^^ 99327) := by decide +kernel

theorem selectedBound968 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env969 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1345,262144,1024,32768,4096,4194304,5456,98564,8329,5376,4456708,4177,1297,4294795,1285,99327,257,4194896,1345,513]

theorem envBound969 : H12AffineFastState.Bounded env969 := by
  intro p hp
  have h : env969.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans968_969 : H12AffineEnvironment.transform 31 99327 env968 = env969 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 99327 env968 == env969) = true)

theorem identity969 : scanCanonicalize (H12AffineFastState.compose env969 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 81471) := by decide +kernel

theorem selectedBound969 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env970 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1345,81471,1024,32768,4096,4194304,5456,98564,8329,5376,4276027,4177,1297,4294795,1285,99327,257,4194896,1345,513]

theorem envBound970 : H12AffineFastState.Bounded env970 := by
  intro p hp
  have h : env970.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans969_970 : H12AffineEnvironment.transform 17 81471 env969 = env970 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 81471 env969 == env970) = true)

theorem identity970 : scanCanonicalize (H12AffineFastState.compose env970 (packedSelected [5,8,13,17] rootPS)) = affineNative (2^(14+1) ^^^ 13973) := by decide +kernel

theorem selectedBound970 : packedSelected [5,8,13,17] rootPS < 2^1333 := by decide +kernel

def env971 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,13973,65536,1345,81471,1024,13973,4096,4194304,5456,79761,8329,5376,4276027,4177,1297,4275742,1285,79210,257,4194896,1345,513]

theorem envBound971 : H12AffineFastState.Bounded env971 := by
  intro p hp
  have h : env971.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans970_971 : H12AffineEnvironment.transform 14 13973 env970 = env971 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13973 env970 == env971) = true)

theorem identity971 : scanCanonicalize (H12AffineFastState.compose env971 (packedSelected [0,7,20] rootPS)) = affineNative (2^(11+1) ^^^ 1944) := by decide +kernel

theorem selectedBound971 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env972 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,8192,1992,8461,65536,1345,76199,1024,8461,1944,4194304,712,73737,8329,664,4270243,1993,1297,4270470,1285,74482,257,4194896,1345,513]

theorem envBound972 : H12AffineFastState.Bounded env972 := by
  intro p hp
  have h : env972.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans971_972 : H12AffineEnvironment.transform 11 1944 env971 = env972 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env971 == env972) = true)

theorem identity972 : scanCanonicalize (H12AffineFastState.compose env972 (packedSelected [6] rootPS)) = affineNative (2^(21+1) ^^^ 3631) := by decide +kernel

theorem selectedBound972 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env973 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,8192,1992,8461,65536,1345,76199,1024,8461,1944,3631,712,73737,8329,664,75404,1993,1297,75689,1285,74482,257,3199,1345,513]

theorem envBound973 : H12AffineFastState.Bounded env973 := by
  intro p hp
  have h : env973.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans972_973 : H12AffineEnvironment.transform 21 3631 env972 = env973 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 3631 env972 == env973) = true)

theorem identity973 : scanCanonicalize (H12AffineFastState.compose env973 (packedSelected [3,8,12,21] rootPS)) = affineNative (2^(15+1) ^^^ 11269) := by decide +kernel

theorem selectedBound973 : packedSelected [3,8,12,21] rootPS < 2^1333 := by decide +kernel

def env974 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1944,8192,1992,8461,11269,1345,1442,1024,8461,1944,3631,712,3084,8329,664,2697,1993,1297,2988,1285,3831,257,3199,1345,513]

theorem envBound974 : H12AffineFastState.Bounded env974 := by
  intro p hp
  have h : env974.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans973_974 : H12AffineEnvironment.transform 15 11269 env973 = env974 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 11269 env973 == env974) = true)

def env975 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,2097152,4194304,5457,2331717,8329,2098432,6689860,2097232,2232400,1073741824,131140,4294967296,2101505,4299915503,131072,513]

theorem envBound975 : H12AffineFastState.Bounded env975 := by
  intro p hp
  have h : env975.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans887_975 : H12AffineEnvironment.transform 13 4177 env887 = env975 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env887 == env975) = true)

theorem identity975 : scanCanonicalize (H12AffineFastState.compose env975 (packedSelected [1,3,4,5,8,9,10,16,19] rootPS)) = affineNative (2^(29+1) ^^^ 4820107) := by decide +kernel

theorem selectedBound975 : packedSelected [1,3,4,5,8,9,10,16,19] rootPS < 2^1333 := by decide +kernel

def env976 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,2097152,4194304,5457,2331717,8329,2098432,6689860,2097232,2232400,4820107,131140,4294967296,2101505,4299915503,131072,513]

theorem envBound976 : H12AffineFastState.Bounded env976 := by
  intro p hp
  have h : env976.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans975_976 : H12AffineEnvironment.transform 29 4820107 env975 = env976 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4820107 env975 == env976) = true)

theorem identity976 : scanCanonicalize (H12AffineFastState.compose env976 (packedSelected [6,25] rootPS)) = affineNative (2^(20+1) ^^^ 4097) := by decide +kernel

theorem selectedBound976 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env977 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,4194304,5457,230468,8329,5377,4588613,4177,131153,4820107,131140,4294967296,256,4299915503,131072,513]

theorem envBound977 : H12AffineFastState.Bounded env977 := by
  intro p hp
  have h : env977.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans976_977 : H12AffineEnvironment.transform 20 4097 env976 = env977 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env976 == env977) = true)

theorem identity977 : scanCanonicalize (H12AffineFastState.compose env977 (packedSelected [0,4,7,16,20,22] rootPS)) = affineNative (2^(18+1) ^^^ 1024) := by decide +kernel

theorem selectedBound977 : packedSelected [0,4,7,16,20,22] rootPS < 2^1333 := by decide +kernel

def env978 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1024,32768,4097,4194304,5457,230468,8329,5377,4588613,4177,131153,4294795,131140,4294967296,256,4299392239,131072,513]

theorem envBound978 : H12AffineFastState.Bounded env978 := by
  intro p hp
  have h : env978.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans977_978 : H12AffineEnvironment.transform 18 1024 env977 = env978 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env977 == env978) = true)

theorem identity978 : scanCanonicalize (H12AffineFastState.compose env978 (packedSelected [13,21] rootPS)) = affineNative (2^(31+1) ^^^ 4329689) := by decide +kernel

theorem selectedBound978 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env979 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1024,32768,4097,4194304,5457,230468,8329,5377,4588613,4177,131153,4294795,131140,4329689,256,103478,131072,513]

theorem envBound979 : H12AffineFastState.Bounded env979 := by
  intro p hp
  have h : env979.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans978_979 : H12AffineEnvironment.transform 31 4329689 env978 = env979 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4329689 env978 == env979) = true)

def env980 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,17011013,21352529,17024068,2232401,1073741824,18977792,4294967296,2101504,4333498423,131072,33563272]

theorem envBound980 : H12AffineFastState.Bounded env980 := by
  intro p hp
  have h : env980.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans884_980 : H12AffineEnvironment.transform 26 21352529 env884 = env980 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 21352529 env884 == env980) = true)

theorem identity980 : scanCanonicalize (H12AffineFastState.compose env980 (packedSelected [35] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound980 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env981 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17664,16777216,33554432,17011013,21352529,17024068,131153,1073741824,16876544,4294967296,256,4333498423,131072,33563272]

theorem envBound981 : H12AffineFastState.Bounded env981 := by
  intro p hp
  have h : env981.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans980_981 : H12AffineEnvironment.transform 20 4096 env980 = env981 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env980 == env981) = true)

def env982 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,16777216,33554432,17011013,21352529,17024068,131153,1073741824,16876544,4294967296,256,4332975159,131072,33563272]

theorem envBound982 : H12AffineFastState.Bounded env982 := by
  intro p hp
  have h : env982.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans981_982 : H12AffineEnvironment.transform 18 1024 env981 = env982 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env981 == env982) = true)

theorem identity982 : scanCanonicalize (H12AffineFastState.compose env982 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 21105870) := by decide +kernel

theorem selectedBound982 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env983 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,16777216,33554432,17011013,21352529,17024068,131153,21105870,16876544,4294967296,256,4332975159,131072,33563272]

theorem envBound983 : H12AffineFastState.Bounded env983 := by
  intro p hp
  have h : env983.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans982_983 : H12AffineEnvironment.transform 29 21105870 env982 = env983 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 21105870 env982 == env983) = true)

def env984 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,16777216,33554432,17010965,21352449,17024020,131073,21105822,16876544,4294967296,256,4332975159,131072,33563272]

theorem envBound984 : H12AffineFastState.Bounded env984 := by
  intro p hp
  have h : env984.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans983_984 : H12AffineEnvironment.transform 5 16 env983 = env984 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env983 == env984) = true)

def env985 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,16777216,33554432,17010965,21352449,17024020,131073,21105822,16876544,4294967296,256,4332967607,131072,33554440]

theorem envBound985 : H12AffineFastState.Bounded env985 := by
  intro p hp
  have h : env985.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans984_985 : H12AffineEnvironment.transform 12 640 env984 = env985 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 640 env984 == env985) = true)

def env986 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,16777216,33554432,16875797,21352449,16897044,4097,20978846,16876544,4294967296,256,4332832439,4096,33554440]

theorem envBound986 : H12AffineFastState.Bounded env986 := by
  intro p hp
  have h : env986.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans985_986 : H12AffineEnvironment.transform 16 4096 env985 = env986 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env985 == env986) = true)

theorem identity986 : scanCanonicalize (H12AffineFastState.compose env986 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(23+1) ^^^ 119693) := by decide +kernel

theorem selectedBound986 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env987 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,119693,33554432,21144,4457356,1945,4097,4312851,22413,4294967296,256,4332832439,4096,33554440]

theorem envBound987 : H12AffineFastState.Bounded env987 := by
  intro p hp
  have h : env987.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans986_987 : H12AffineEnvironment.transform 23 119693 env986 = env987 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 119693 env986 == env987) = true)

def env988 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,119693,128,21144,4457356,1945,4097,4312851,22413,4294967296,256,4299277879,4096,136]

theorem envBound988 : H12AffineFastState.Bounded env988 := by
  intro p hp
  have h : env988.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans987_988 : H12AffineEnvironment.transform 24 128 env987 = env988 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 128 env987 == env988) = true)

theorem identity988 : scanCanonicalize (H12AffineFastState.compose env988 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(13+1) ^^^ 1945) := by decide +kernel

theorem selectedBound988 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env989 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,1945,32768,65536,4096,262144,1024,32768,4096,4194304,665,103444,128,5377,4457356,1945,4097,4294794,4116,4294967296,256,4299260334,4096,136]

theorem envBound989 : H12AffineFastState.Bounded env989 := by
  intro p hp
  have h : env989.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans988_989 : H12AffineEnvironment.transform 13 1945 env988 = env989 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1945 env988 == env989) = true)

theorem identity989 : scanCanonicalize (H12AffineFastState.compose env989 (packedSelected [0,4,5,7,8,9,16,17,20,21] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound989 : packedSelected [0,4,5,7,8,9,16,17,20,21] rootPS < 2^1333 := by decide +kernel

def env990 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,1296,32768,65536,4096,262144,1024,32768,4096,4194304,16,103444,128,5377,4456709,1296,4097,4294794,4116,4294967296,256,4299260334,4096,136]

theorem envBound990 : H12AffineFastState.Bounded env990 := by
  intro p hp
  have h : env990.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans989_990 : H12AffineEnvironment.transform 8 137 env989 = env990 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env989 == env990) = true)

theorem identity990 : scanCanonicalize (H12AffineFastState.compose env990 (packedSelected [4,9,16] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound990 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env991 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,9,1296,32768,65536,1297,262144,1024,32768,1297,4194304,16,98565,128,16,4456709,1296,1296,4294794,1285,4294967296,256,4299260334,1297,136]

theorem envBound991 : H12AffineFastState.Bounded env991 := by
  intro p hp
  have h : env991.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans990_991 : H12AffineEnvironment.transform 11 1297 env990 = env991 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env990 == env991) = true)

theorem identity991 : scanCanonicalize (H12AffineFastState.compose env991 (packedSelected [1,3,5] rootPS)) = affineNative (2^(17+1) ^^^ 34849) := by decide +kernel

theorem selectedBound991 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env992 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,9,1296,32768,65536,1297,34849,1024,32768,1297,4194304,16,98565,128,16,4229412,1296,1296,4294794,1285,4294967296,256,4299260334,1297,136]

theorem envBound992 : H12AffineFastState.Bounded env992 := by
  intro p hp
  have h : env992.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans991_992 : H12AffineEnvironment.transform 17 34849 env991 = env992 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 34849 env991 == env992) = true)

theorem identity992 : scanCanonicalize (H12AffineFastState.compose env992 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 35124) := by decide +kernel

theorem selectedBound992 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env993 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,9,1296,32768,65536,1297,34849,1024,32768,1297,4194304,16,98565,128,16,4229412,1296,1296,4294794,1285,35124,256,4262042,1297,136]

theorem envBound993 : H12AffineFastState.Bounded env993 := by
  intro p hp
  have h : env993.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans992_993 : H12AffineEnvironment.transform 31 35124 env992 = env993 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 35124 env992 == env993) = true)

theorem identity993 : scanCanonicalize (H12AffineFastState.compose env993 (packedSelected [3,8] rootPS)) = affineNative (2^(15+1) ^^^ 33166) := by decide +kernel

theorem selectedBound993 : packedSelected [3,8] rootPS < 2^1333 := by decide +kernel

def env994 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,9,1296,32768,33166,1297,34849,1024,32768,1297,4194304,16,139,128,16,4229412,1296,1296,4196612,1285,35124,256,4229396,1297,136]

theorem envBound994 : H12AffineFastState.Bounded env994 := by
  intro p hp
  have h : env994.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans993_994 : H12AffineEnvironment.transform 15 33166 env993 = env994 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33166 env993 == env994) = true)

theorem identity994 : scanCanonicalize (H12AffineFastState.compose env994 (packedSelected [3] rootPS)) = affineNative (2^(21+1) ^^^ 260) := by decide +kernel

theorem selectedBound994 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env995 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,9,1296,32768,33166,1297,34849,1024,32768,1297,260,16,139,128,16,34848,1296,1296,2048,1285,35124,256,34832,1297,136]

theorem envBound995 : H12AffineFastState.Bounded env995 := by
  intro p hp
  have h : env995.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans994_995 : H12AffineEnvironment.transform 21 260 env994 = env995 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 260 env994 == env995) = true)

theorem identity995 : scanCanonicalize (H12AffineFastState.compose env995 (packedSelected [0,7] rootPS)) = affineNative (2^(14+1) ^^^ 2340) := by decide +kernel

theorem selectedBound995 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env996 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,9,1296,2340,2218,1297,261,1024,2340,1297,260,16,139,128,16,260,1296,1296,2048,1285,16,256,308,1297,136]

theorem envBound996 : H12AffineFastState.Bounded env996 := by
  intro p hp
  have h : env996.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans995_996 : H12AffineEnvironment.transform 14 2340 env995 = env996 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2340 env995 == env996) = true)

def env997 : List Nat := [2,4,8,16,32,16,128,256,137,1024,32,1297,9,1296,260,138,1297,261,1024,260,1297,260,16,139,128,16,260,1296,1296,32,1285,16,256,308,1297,136]

theorem envBound997 : H12AffineFastState.Bounded env997 := by
  intro p hp
  have h : env997.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans996_997 : H12AffineEnvironment.transform 10 32 env996 = env997 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 32 env996 == env997) = true)

theorem identity997 : scanCanonicalize (H12AffineFastState.compose env997 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 51) := by decide +kernel

theorem selectedBound997 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env998 : List Nat := [2,4,8,16,32,16,51,256,58,1024,32,1297,9,1296,260,57,1297,261,1024,260,1297,260,16,56,51,16,260,1296,1296,32,1285,16,256,308,1297,59]

theorem envBound998 : H12AffineFastState.Bounded env998 := by
  intro p hp
  have h : env998.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans997_998 : H12AffineEnvironment.transform 6 51 env997 = env998 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 51 env997 == env998) = true)

def env999 : List Nat := [2,4,8,16,16,16,3,256,10,1024,16,1297,9,1296,260,9,1297,261,1024,260,1297,260,16,8,3,16,260,1296,1296,16,1285,16,256,260,1297,11]

theorem envBound999 : H12AffineFastState.Bounded env999 := by
  intro p hp
  have h : env999.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans998_999 : H12AffineEnvironment.transform 4 16 env998 = env999 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env998 == env999) = true)

theorem identity999 : scanCanonicalize (H12AffineFastState.compose env999 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound999 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1000 : List Nat := [2,4,8,0,0,0,3,256,10,1024,0,1281,9,1280,260,9,1281,261,1024,260,1281,260,0,8,3,0,260,1280,1280,0,1285,0,256,260,1281,11]

theorem envBound1000 : H12AffineFastState.Bounded env1000 := by
  intro p hp
  have h : env1000.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans999_1000 : H12AffineEnvironment.transform 3 0 env999 = env1000 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env999 == env1000) = true)

def leafEnv1000 : List Nat := [2,4,8,0,0,0,3,256,10,1024,0,1281,9,1280,260,9,1281,261,1024,260,1281,260,0,8,1285,3,1,0,260,1280,1280,0,1285,0,256,260,4,2,1281,11,0,1280,1]

def active1000 : List Nat := [0,1,2,7,9]

def tree1000 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1000 : H12WitnessSearch.Good tree1000 := H12GlobalWitnessIndex.good

theorem leafIdentity1000 : H12AffineFastState.composeSystem env1000 rootObs = leafEnv1000 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1000 rootObs == leafEnv1000) = true)

theorem terminalChecked1000 : H12PackedTerminal.terminalCheckFast leafEnv1000 active1000 tree1000 = true := by decide +kernel

def env1001 : List Nat := [2,4,8,16,17,16,2,256,11,1024,17,1297,9,1296,260,8,1297,261,1024,260,1297,260,16,9,2,16,260,1296,1296,17,1285,16,256,261,1297,10]

theorem envBound1001 : H12AffineFastState.Bounded env1001 := by
  intro p hp
  have h : env1001.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans998_1001 : H12AffineEnvironment.transform 4 17 env998 = env1001 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env998 == env1001) = true)

theorem identity1001 : scanCanonicalize (H12AffineFastState.compose env1001 (packedSelected [2] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1001 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1002 : List Nat := [2,4,8,16,17,16,2,5,11,1024,17,1044,9,1045,1,8,1044,0,1024,1,1044,1,16,9,2,16,1,1045,1045,17,1024,16,5,0,1044,10]

theorem envBound1002 : H12AffineFastState.Bounded env1002 := by
  intro p hp
  have h : env1002.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1001_1002 : H12AffineEnvironment.transform 7 5 env1001 = env1002 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1001 == env1002) = true)

def leafEnv1002 : List Nat := [2,4,8,16,17,16,2,5,11,1024,17,1044,9,1045,1,8,1044,0,1024,1,1044,1,16,9,1024,2,1,16,1,1045,1045,17,1024,16,5,0,4,2,1044,10,0,1045,1]

def active1002 : List Nat := [0,1,2,3,9]

def tree1002 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1002 : H12WitnessSearch.Good tree1002 := H12GlobalWitnessIndex.good

theorem leafIdentity1002 : H12AffineFastState.composeSystem env1002 rootObs = leafEnv1002 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1002 rootObs == leafEnv1002) = true)

theorem terminalChecked1002 : H12PackedTerminal.terminalCheckFast leafEnv1002 active1002 tree1002 = true := by decide +kernel

def env1003 : List Nat := [2,4,8,16,32,16,128,256,137,1024,33,1297,9,1296,261,139,1297,261,1024,261,1297,260,16,139,128,16,260,1296,1296,33,1285,16,256,308,1297,136]

theorem envBound1003 : H12AffineFastState.Bounded env1003 := by
  intro p hp
  have h : env1003.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans996_1003 : H12AffineEnvironment.transform 10 33 env996 = env1003 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 33 env996 == env1003) = true)

theorem identity1003 : scanCanonicalize (H12AffineFastState.compose env1003 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 27) := by decide +kernel

theorem selectedBound1003 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1004 : List Nat := [2,4,8,16,27,16,128,256,137,1024,26,1297,9,1296,261,139,1297,261,1024,261,1297,260,16,139,128,16,260,1296,1296,26,1285,16,256,271,1297,136]

theorem envBound1004 : H12AffineFastState.Bounded env1004 := by
  intro p hp
  have h : env1004.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1003_1004 : H12AffineEnvironment.transform 4 27 env1003 = env1004 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 27 env1003 == env1004) = true)

def env1005 : List Nat := [2,4,8,16,27,16,128,20,137,1024,26,1029,9,1028,17,139,1029,17,1024,17,1029,16,16,139,128,16,16,1028,1028,26,1041,16,20,27,1029,136]

theorem envBound1005 : H12AffineFastState.Bounded env1005 := by
  intro p hp
  have h : env1005.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1004_1005 : H12AffineEnvironment.transform 7 20 env1004 = env1005 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 20 env1004 == env1005) = true)

theorem identity1005 : scanCanonicalize (H12AffineFastState.compose env1005 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound1005 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1006 : List Nat := [2,4,8,11,0,11,128,15,137,1024,1,1029,9,1028,10,139,1029,10,1024,10,1029,11,11,139,128,11,11,1028,1028,1,1034,11,15,0,1029,136]

theorem envBound1006 : H12AffineFastState.Bounded env1006 := by
  intro p hp
  have h : env1006.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1005_1006 : H12AffineEnvironment.transform 3 11 env1005 = env1006 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env1005 == env1006) = true)

def leafEnv1006 : List Nat := [2,4,8,11,0,11,128,15,137,1024,1,1029,9,1028,10,139,1029,10,1024,10,1029,11,11,139,1034,128,1,11,11,1028,1028,1,1034,11,15,0,4,3,1029,136,0,1028,1]

def active1006 : List Nat := [0,1,2,6,9]

def tree1006 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1006 : H12WitnessSearch.Good tree1006 := H12GlobalWitnessIndex.good

theorem leafIdentity1006 : H12AffineFastState.composeSystem env1006 rootObs = leafEnv1006 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1006 rootObs == leafEnv1006) = true)

theorem terminalChecked1006 : H12PackedTerminal.terminalCheckFast leafEnv1006 active1006 tree1006 = true := by decide +kernel

def env1007 : List Nat := [2,4,8,16,27,16,128,21,137,1024,26,1028,9,1029,16,139,1028,16,1024,16,1028,17,16,139,128,16,17,1029,1029,26,1040,16,21,26,1028,136]

theorem envBound1007 : H12AffineFastState.Bounded env1007 := by
  intro p hp
  have h : env1007.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1004_1007 : H12AffineEnvironment.transform 7 21 env1004 = env1007 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 21 env1004 == env1007) = true)

theorem identity1007 : scanCanonicalize (H12AffineFastState.compose env1007 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1007 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1008 : List Nat := [2,4,8,0,11,0,128,5,137,1024,10,1028,9,1029,0,139,1028,0,1024,0,1028,1,0,139,128,0,1,1029,1029,10,1024,0,5,10,1028,136]

theorem envBound1008 : H12AffineFastState.Bounded env1008 := by
  intro p hp
  have h : env1008.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1007_1008 : H12AffineEnvironment.transform 3 0 env1007 = env1008 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1007 == env1008) = true)

def leafEnv1008 : List Nat := [2,4,8,0,11,0,128,5,137,1024,10,1028,9,1029,0,139,1028,0,1024,0,1028,1,0,139,1024,128,1,0,1,1029,1029,10,1024,0,5,10,4,3,1028,136,0,1029,1]

def active1008 : List Nat := [0,1,2,6,9]

def tree1008 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1008 : H12WitnessSearch.Good tree1008 := H12GlobalWitnessIndex.good

theorem leafIdentity1008 : H12AffineFastState.composeSystem env1008 rootObs = leafEnv1008 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1008 rootObs == leafEnv1008) = true)

theorem terminalChecked1008 : H12PackedTerminal.terminalCheckFast leafEnv1008 active1008 tree1008 = true := by decide +kernel

def env1009 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,119693,129,21144,4457356,1945,4097,4312851,22413,4294967296,256,4299277878,4096,137]

theorem envBound1009 : H12AffineFastState.Bounded env1009 := by
  intro p hp
  have h : env1009.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans987_1009 : H12AffineEnvironment.transform 24 129 env987 = env1009 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 129 env987 == env1009) = true)

theorem identity1009 : scanCanonicalize (H12AffineFastState.compose env1009 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(13+1) ^^^ 1297) := by decide +kernel

theorem selectedBound1009 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env1010 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,1297,32768,65536,4096,262144,1024,32768,4096,4194304,17,104092,129,6025,4457356,1945,4097,4295170,4764,4294967296,256,4299260711,4096,137]

theorem envBound1010 : H12AffineFastState.Bounded env1010 := by
  intro p hp
  have h : env1010.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1009_1010 : H12AffineEnvironment.transform 13 1297 env1009 = env1010 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1297 env1009 == env1010) = true)

theorem identity1010 : scanCanonicalize (H12AffineFastState.compose env1010 (packedSelected [3,5,6,8,10,25,28,31] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound1010 : packedSelected [3,5,6,8,10,25,28,31] rootPS < 2^1333 := by decide +kernel

def env1011 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,1297,32768,65536,4096,262144,1024,32768,4096,4194304,17,103444,129,5377,4456708,1297,4097,4294794,4116,4294967296,256,4299260335,4096,137]

theorem envBound1011 : H12AffineFastState.Bounded env1011 := by
  intro p hp
  have h : env1011.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1010_1011 : H12AffineEnvironment.transform 8 136 env1010 = env1011 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1010 == env1011) = true)

theorem identity1011 : scanCanonicalize (H12AffineFastState.compose env1011 (packedSelected [5,8,17,21] rootPS)) = affineNative (2^(14+1) ^^^ 261) := by decide +kernel

theorem selectedBound1011 : packedSelected [5,8,17,21] rootPS < 2^1333 := by decide +kernel

def env1012 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,1297,261,65536,4096,262144,1024,261,4096,4194304,17,70929,129,5377,4456708,1297,4097,4262287,4116,4294967296,256,4299227306,4096,137]

theorem envBound1012 : H12AffineFastState.Bounded env1012 := by
  intro p hp
  have h : env1012.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1011_1012 : H12AffineEnvironment.transform 14 261 env1011 = env1012 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 261 env1011 == env1012) = true)

theorem identity1012 : scanCanonicalize (H12AffineFastState.compose env1012 (packedSelected [5,6,8,10,12,13] rootPS)) = affineNative (2^(31+1) ^^^ 4201502) := by decide +kernel

theorem selectedBound1012 : packedSelected [5,6,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env1013 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,1297,261,65536,4096,262144,1024,261,4096,4194304,17,70929,129,5377,4456708,1297,4097,4262287,4116,4201502,256,72884,4096,137]

theorem envBound1013 : H12AffineFastState.Bounded env1013 := by
  intro p hp
  have h : env1013.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1012_1013 : H12AffineEnvironment.transform 31 4201502 env1012 = env1013 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4201502 env1012 == env1013) = true)

theorem identity1013 : scanCanonicalize (H12AffineFastState.compose env1013 (packedSelected [10,12,17] rootPS)) = affineNative (2^(17+1) ^^^ 7221) := by decide +kernel

theorem selectedBound1013 : packedSelected [10,12,17] rootPS < 2^1333 := by decide +kernel

def env1014 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,1297,261,65536,4096,7221,1024,261,4096,4194304,17,70929,129,5377,4201777,1297,4097,4262287,4116,4201502,256,72884,4096,137]

theorem envBound1014 : H12AffineFastState.Bounded env1014 := by
  intro p hp
  have h : env1014.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1013_1014 : H12AffineEnvironment.transform 17 7221 env1013 = env1014 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 7221 env1013 == env1014) = true)

theorem identity1014 : scanCanonicalize (H12AffineFastState.compose env1014 (packedSelected [5,8] rootPS)) = affineNative (2^(15+1) ^^^ 138) := by decide +kernel

theorem selectedBound1014 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env1015 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,1297,261,138,4096,7221,1024,261,4096,4194304,17,5531,129,5377,4201777,1297,4097,4196613,4116,4201502,256,7230,4096,137]

theorem envBound1015 : H12AffineFastState.Bounded env1015 := by
  intro p hp
  have h : env1015.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1014_1015 : H12AffineEnvironment.transform 15 138 env1014 = env1015 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 138 env1014 == env1015) = true)

def env1016 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,1297,261,138,4096,7221,1024,261,4096,5408,17,5531,129,5377,2065,1297,4097,7205,4116,2366,256,7230,4096,137]

theorem envBound1016 : H12AffineFastState.Bounded env1016 := by
  intro p hp
  have h : env1016.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1015_1016 : H12AffineEnvironment.transform 21 5408 env1015 = env1016 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5408 env1015 == env1016) = true)

theorem identity1016 : scanCanonicalize (H12AffineFastState.compose env1016 (packedSelected [1] rootPS)) = affineNative (2^(10+1) ^^^ 178) := by decide +kernel

theorem selectedBound1016 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1017 : List Nat := [2,4,8,16,32,16,128,256,136,1024,178,4096,8,1297,261,138,4096,5255,1024,261,4096,5408,17,5531,129,5377,163,1297,4097,5271,4116,396,256,5260,4096,137]

theorem envBound1017 : H12AffineFastState.Bounded env1017 := by
  intro p hp
  have h : env1017.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1016_1017 : H12AffineEnvironment.transform 10 178 env1016 = env1017 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 178 env1016 == env1017) = true)

theorem identity1017 : scanCanonicalize (H12AffineFastState.compose env1017 (packedSelected [5] rootPS)) = affineNative (2^(11+1) ^^^ 1039) := by decide +kernel

theorem selectedBound1017 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1018 : List Nat := [2,4,8,16,32,16,128,256,136,1024,178,1039,8,1297,261,138,1039,136,1024,261,1039,303,17,404,129,270,163,1297,1038,152,1051,396,256,131,1039,137]

theorem envBound1018 : H12AffineFastState.Bounded env1018 := by
  intro p hp
  have h : env1018.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1017_1018 : H12AffineEnvironment.transform 11 1039 env1017 = env1018 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1039 env1017 == env1018) = true)

def env1019 : List Nat := [2,4,8,16,0,16,128,256,136,1024,146,1039,8,1297,261,138,1039,136,1024,261,1039,271,17,404,129,270,131,1297,1038,152,1051,396,256,131,1039,137]

theorem envBound1019 : H12AffineFastState.Bounded env1019 := by
  intro p hp
  have h : env1019.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1018_1019 : H12AffineEnvironment.transform 4 0 env1018 = env1019 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1018 == env1019) = true)

theorem identity1019 : scanCanonicalize (H12AffineFastState.compose env1019 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound1019 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1020 : List Nat := [2,4,8,11,0,11,128,256,136,1024,137,1039,8,1290,261,138,1039,136,1024,261,1039,271,10,399,129,270,131,1290,1038,131,1024,396,256,131,1039,137]

theorem envBound1020 : H12AffineFastState.Bounded env1020 := by
  intro p hp
  have h : env1020.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1019_1020 : H12AffineEnvironment.transform 3 11 env1019 = env1020 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env1019 == env1020) = true)

theorem identity1020 : scanCanonicalize (H12AffineFastState.compose env1020 (packedSelected [0,7] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound1020 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env1021 : List Nat := [2,4,8,11,0,11,8,256,0,1024,1,1039,8,1290,261,2,1039,0,1024,261,1039,271,10,263,9,270,11,1290,1038,11,1024,260,256,11,1039,1]

theorem envBound1021 : H12AffineFastState.Bounded env1021 := by
  intro p hp
  have h : env1021.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1020_1021 : H12AffineEnvironment.transform 6 8 env1020 = env1021 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env1020 == env1021) = true)

theorem identity1021 : scanCanonicalize (H12AffineFastState.compose env1021 (packedSelected [4] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1021 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env1022 : List Nat := [2,4,8,11,0,11,8,5,0,1024,1,1039,8,1039,0,2,1039,0,1024,0,1039,10,10,2,9,11,11,1039,1038,11,1024,1,5,11,1039,1]

theorem envBound1022 : H12AffineFastState.Bounded env1022 := by
  intro p hp
  have h : env1022.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1021_1022 : H12AffineEnvironment.transform 7 5 env1021 = env1022 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1021 == env1022) = true)

theorem identity1022 : scanCanonicalize (H12AffineFastState.compose env1022 (packedSelected [6] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1022 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1023 : List Nat := [2,4,2,1,0,1,2,5,0,1024,1,1029,2,1029,0,2,1029,0,1024,0,1029,0,0,2,3,1,1,1029,1028,1,1024,1,5,1,1029,1]

theorem envBound1023 : H12AffineFastState.Bounded env1023 := by
  intro p hp
  have h : env1023.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1022_1023 : H12AffineEnvironment.transform 2 2 env1022 = env1023 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1022 == env1023) = true)

def leafEnv1023 : List Nat := [2,4,2,1,0,1,2,5,0,1024,1,1029,2,1029,0,2,1029,0,1024,0,1029,0,0,2,1024,3,1,1,1,1029,1028,1,1024,1,5,1,4,3,1029,1,0,1028,1]

def active1023 : List Nat := [0,1,9]

def tree1023 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1023 : H12WitnessSearch.Good tree1023 := H12GlobalWitnessIndex.good

theorem leafIdentity1023 : H12AffineFastState.composeSystem env1023 rootObs = leafEnv1023 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1023 rootObs == leafEnv1023) = true)

theorem terminalChecked1023 : H12PackedTerminal.terminalCheckFast leafEnv1023 active1023 tree1023 = true := by decide +kernel

def env1024 : List Nat := [2,4,8,16,1,16,128,256,136,1024,147,1039,8,1297,261,138,1039,136,1024,261,1039,270,17,404,129,270,130,1297,1038,152,1051,396,256,131,1039,137]

theorem envBound1024 : H12AffineFastState.Bounded env1024 := by
  intro p hp
  have h : env1024.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1018_1024 : H12AffineEnvironment.transform 4 1 env1018 = env1024 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env1018 == env1024) = true)

theorem identity1024 : scanCanonicalize (H12AffineFastState.compose env1024 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1024 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1025 : List Nat := [2,4,8,16,1,16,128,5,136,1024,147,1039,8,1044,0,138,1039,136,1024,0,1039,11,17,145,129,11,130,1044,1038,152,1051,137,5,131,1039,137]

theorem envBound1025 : H12AffineFastState.Bounded env1025 := by
  intro p hp
  have h : env1025.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1024_1025 : H12AffineEnvironment.transform 7 5 env1024 = env1025 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1024 == env1025) = true)

theorem identity1025 : scanCanonicalize (H12AffineFastState.compose env1025 (packedSelected [0,2,6] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1025 : packedSelected [0,2,6] rootPS < 2^1333 := by decide +kernel

def env1026 : List Nat := [2,4,2,16,1,16,128,5,130,1024,147,1029,2,1044,0,128,1029,130,1024,0,1029,1,17,145,129,1,130,1044,1028,146,1041,131,5,131,1029,131]

theorem envBound1026 : H12AffineFastState.Bounded env1026 := by
  intro p hp
  have h : env1026.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1025_1026 : H12AffineEnvironment.transform 2 2 env1025 = env1026 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1025 == env1026) = true)

theorem identity1026 : scanCanonicalize (H12AffineFastState.compose env1026 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1026 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1027 : List Nat := [2,4,2,0,1,0,128,5,130,1024,131,1029,2,1028,0,128,1029,130,1024,0,1029,1,1,129,129,1,130,1028,1028,130,1025,131,5,131,1029,131]

theorem envBound1027 : H12AffineFastState.Bounded env1027 := by
  intro p hp
  have h : env1027.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1026_1027 : H12AffineEnvironment.transform 3 0 env1026 = env1027 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1026 == env1027) = true)

theorem identity1027 : scanCanonicalize (H12AffineFastState.compose env1027 (packedSelected [4] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound1027 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env1028 : List Nat := [2,4,2,0,1,0,2,5,0,1024,1,1029,2,1028,0,2,1029,0,1024,0,1029,1,1,3,3,1,0,1028,1028,0,1025,1,5,1,1029,1]

theorem envBound1028 : H12AffineFastState.Bounded env1028 := by
  intro p hp
  have h : env1028.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1027_1028 : H12AffineEnvironment.transform 6 2 env1027 = env1028 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env1027 == env1028) = true)

def env1029 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,8,1297,261,138,4096,7221,1024,261,4096,5409,17,5531,129,5377,2064,1297,4097,7204,4116,2367,256,7230,4096,137]

theorem envBound1029 : H12AffineFastState.Bounded env1029 := by
  intro p hp
  have h : env1029.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1015_1029 : H12AffineEnvironment.transform 21 5409 env1015 = env1029 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5409 env1015 == env1029) = true)

theorem identity1029 : scanCanonicalize (H12AffineFastState.compose env1029 (packedSelected [1] rootPS)) = affineNative (2^(11+1) ^^^ 3490) := by decide +kernel

theorem selectedBound1029 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1030 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,3490,8,1297,261,138,3490,407,1024,261,3490,2179,17,2105,129,2211,2064,1297,3491,390,3510,2367,256,412,3490,137]

theorem envBound1030 : H12AffineFastState.Bounded env1030 := by
  intro p hp
  have h : env1030.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1029_1030 : H12AffineEnvironment.transform 11 3490 env1029 = env1030 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3490 env1029 == env1030) = true)

theorem identity1030 : scanCanonicalize (H12AffineFastState.compose env1030 (packedSelected [5] rootPS)) = affineNative (2^(10+1) ^^^ 428) := by decide +kernel

theorem selectedBound1030 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1031 : List Nat := [2,4,8,16,32,16,128,256,136,1024,428,1038,8,1297,261,138,1038,407,1024,261,1038,303,17,405,129,271,444,1297,1039,390,1050,147,256,412,1038,137]

theorem envBound1031 : H12AffineFastState.Bounded env1031 := by
  intro p hp
  have h : env1031.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1030_1031 : H12AffineEnvironment.transform 10 428 env1030 = env1031 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 428 env1030 == env1031) = true)

def env1032 : List Nat := [2,4,8,16,0,16,128,256,136,1024,396,1038,8,1297,261,138,1038,407,1024,261,1038,271,17,405,129,271,412,1297,1039,390,1050,147,256,412,1038,137]

theorem envBound1032 : H12AffineFastState.Bounded env1032 := by
  intro p hp
  have h : env1032.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1031_1032 : H12AffineEnvironment.transform 4 0 env1031 = env1032 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1031 == env1032) = true)

theorem identity1032 : scanCanonicalize (H12AffineFastState.compose env1032 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound1032 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1033 : List Nat := [2,4,8,10,0,10,128,256,136,1024,396,1038,8,1291,261,138,1038,397,1024,261,1038,271,11,399,129,271,390,1291,1039,390,1024,137,256,390,1038,137]

theorem envBound1033 : H12AffineFastState.Bounded env1033 := by
  intro p hp
  have h : env1033.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1032_1033 : H12AffineEnvironment.transform 3 10 env1032 = env1033 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env1032 == env1033) = true)

theorem identity1033 : scanCanonicalize (H12AffineFastState.compose env1033 (packedSelected [0,2] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound1033 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env1034 : List Nat := [2,4,8,10,0,10,128,4,136,1024,136,1038,8,1039,1,138,1038,137,1024,1,1038,11,11,139,129,11,130,1039,1039,130,1024,137,4,130,1038,137]

theorem envBound1034 : H12AffineFastState.Bounded env1034 := by
  intro p hp
  have h : env1034.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1033_1034 : H12AffineEnvironment.transform 7 4 env1033 = env1034 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env1033 == env1034) = true)

theorem identity1034 : scanCanonicalize (H12AffineFastState.compose env1034 (packedSelected [0,4] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound1034 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env1035 : List Nat := [2,4,8,10,0,10,8,4,0,1024,0,1038,8,1039,1,2,1038,1,1024,1,1038,11,11,3,9,11,10,1039,1039,10,1024,1,4,10,1038,1]

theorem envBound1035 : H12AffineFastState.Bounded env1035 := by
  intro p hp
  have h : env1035.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1034_1035 : H12AffineEnvironment.transform 6 8 env1034 = env1035 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env1034 == env1035) = true)

theorem identity1035 : scanCanonicalize (H12AffineFastState.compose env1035 (packedSelected [0] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound1035 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1036 : List Nat := [2,4,3,1,0,1,3,4,0,1024,0,1029,3,1028,1,2,1029,1,1024,1,1029,0,0,3,2,0,1,1028,1028,1,1024,1,4,1,1029,1]

theorem envBound1036 : H12AffineFastState.Bounded env1036 := by
  intro p hp
  have h : env1036.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1035_1036 : H12AffineEnvironment.transform 2 3 env1035 = env1036 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env1035 == env1036) = true)

def env1037 : List Nat := [2,4,8,16,1,16,128,256,136,1024,397,1038,8,1297,261,138,1038,407,1024,261,1038,270,17,405,129,271,413,1297,1039,390,1050,147,256,412,1038,137]

theorem envBound1037 : H12AffineFastState.Bounded env1037 := by
  intro p hp
  have h : env1037.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1031_1037 : H12AffineEnvironment.transform 4 1 env1031 = env1037 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env1031 == env1037) = true)

theorem identity1037 : scanCanonicalize (H12AffineFastState.compose env1037 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1037 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1038 : List Nat := [2,4,8,16,1,16,128,5,136,1024,136,1038,8,1044,0,138,1038,146,1024,0,1038,11,17,144,129,10,152,1044,1039,131,1050,147,5,153,1038,137]

theorem envBound1038 : H12AffineFastState.Bounded env1038 := by
  intro p hp
  have h : env1038.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1037_1038 : H12AffineEnvironment.transform 7 5 env1037 = env1038 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1037 == env1038) = true)

theorem identity1038 : scanCanonicalize (H12AffineFastState.compose env1038 (packedSelected [0,2,6] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound1038 : packedSelected [0,2,6] rootPS < 2^1333 := by decide +kernel

def env1039 : List Nat := [2,4,8,1,1,1,128,5,136,1024,136,1038,8,1029,0,138,1038,131,1024,0,1038,11,0,129,129,10,137,1029,1039,131,1035,130,5,136,1038,137]

theorem envBound1039 : H12AffineFastState.Bounded env1039 := by
  intro p hp
  have h : env1039.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1038_1039 : H12AffineEnvironment.transform 3 1 env1038 = env1039 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env1038 == env1039) = true)

theorem identity1039 : scanCanonicalize (H12AffineFastState.compose env1039 (packedSelected [4] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound1039 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env1040 : List Nat := [2,4,8,1,1,1,3,5,11,1024,11,1038,8,1029,0,9,1038,0,1024,0,1038,11,0,2,2,10,10,1029,1039,0,1035,1,5,11,1038,10]

theorem envBound1040 : H12AffineFastState.Bounded env1040 := by
  intro p hp
  have h : env1040.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1039_1040 : H12AffineEnvironment.transform 6 3 env1039 = env1040 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env1039 == env1040) = true)

theorem identity1040 : scanCanonicalize (H12AffineFastState.compose env1040 (packedSelected [7] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound1040 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1041 : List Nat := [2,4,3,1,1,1,3,5,0,1024,0,1029,3,1029,0,2,1029,0,1024,0,1029,0,0,2,2,1,1,1029,1028,0,1024,1,5,0,1029,1]

theorem envBound1041 : H12AffineFastState.Bounded env1041 := by
  intro p hp
  have h : env1041.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1040_1041 : H12AffineEnvironment.transform 2 3 env1040 = env1041 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env1040 == env1041) = true)

def leafEnv1041 : List Nat := [2,4,3,1,1,1,3,5,0,1024,0,1029,3,1029,0,2,1029,0,1024,0,1029,0,0,2,1024,2,1,1,1,1029,1028,0,1024,1,5,0,4,3,1029,1,0,1028,1]

def active1041 : List Nat := [0,1,9]

def tree1041 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1041 : H12WitnessSearch.Good tree1041 := H12GlobalWitnessIndex.good

theorem leafIdentity1041 : H12AffineFastState.composeSystem env1041 rootObs = leafEnv1041 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1041 rootObs == leafEnv1041) = true)

theorem terminalChecked1041 : H12PackedTerminal.terminalCheckFast leafEnv1041 active1041 tree1041 = true := by decide +kernel

def env1042 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,16777216,33554432,16875796,21352449,16897045,4096,20978847,16876544,4294967296,256,4332832438,4097,33554440]

theorem envBound1042 : H12AffineFastState.Bounded env1042 := by
  intro p hp
  have h : env1042.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans985_1042 : H12AffineEnvironment.transform 16 4097 env985 = env1042 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env985 == env1042) = true)

theorem identity1042 : scanCanonicalize (H12AffineFastState.compose env1042 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(23+1) ^^^ 116381) := by decide +kernel

theorem selectedBound1042 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env1043 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,116381,33554432,18313,4462236,4744,4096,4315650,17053,4294967296,256,4332832438,4097,33554440]

theorem envBound1043 : H12AffineFastState.Bounded env1043 := by
  intro p hp
  have h : env1043.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1042_1043 : H12AffineEnvironment.transform 23 116381 env1042 = env1043 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 116381 env1042 == env1043) = true)

def env1044 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,116381,128,18313,4462236,4744,4096,4315650,17053,4294967296,256,4299277878,4097,136]

theorem envBound1044 : H12AffineFastState.Bounded env1044 := by
  intro p hp
  have h : env1044.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1043_1044 : H12AffineEnvironment.transform 24 128 env1043 = env1044 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 128 env1043 == env1044) = true)

theorem identity1044 : scanCanonicalize (H12AffineFastState.compose env1044 (packedSelected [6,25] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound1044 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env1045 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,115732,128,17664,4461589,4097,4096,4315275,16404,4294967296,256,4299277503,4097,136]

theorem envBound1045 : H12AffineFastState.Bounded env1045 := by
  intro p hp
  have h : env1045.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1044_1045 : H12AffineEnvironment.transform 8 137 env1044 = env1045 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1044 == env1045) = true)

theorem identity1045 : scanCanonicalize (H12AffineFastState.compose env1045 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(13+1) ^^^ 4097) := by decide +kernel

theorem selectedBound1045 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env1046 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,4097,32768,65536,4097,262144,1024,32768,4096,4194304,5377,103445,128,5377,4461589,4097,4096,4294794,4117,4294967296,256,4299265214,4097,136]

theorem envBound1046 : H12AffineFastState.Bounded env1046 := by
  intro p hp
  have h : env1046.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1045_1046 : H12AffineEnvironment.transform 13 4097 env1045 = env1046 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4097 env1045 == env1046) = true)

def env1047 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,116381,129,18313,4462236,4744,4096,4315650,17053,4294967296,256,4299277879,4097,137]

theorem envBound1047 : H12AffineFastState.Bounded env1047 := by
  intro p hp
  have h : env1047.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1043_1047 : H12AffineEnvironment.transform 24 129 env1043 = env1047 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 129 env1043 == env1047) = true)

theorem identity1047 : scanCanonicalize (H12AffineFastState.compose env1047 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound1047 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env1048 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1296,640,16384,32768,65536,1297,262144,1024,32768,1296,4194304,17664,116381,129,18313,4457356,1944,1296,4312850,17053,4294967296,256,4299277879,1297,137]

theorem envBound1048 : H12AffineFastState.Bounded env1048 := by
  intro p hp
  have h : env1048.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1047_1048 : H12AffineEnvironment.transform 11 1296 env1047 = env1048 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env1047 == env1048) = true)

theorem identity1048 : scanCanonicalize (H12AffineFastState.compose env1048 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 1296) := by decide +kernel

theorem selectedBound1048 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env1049 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1296,640,1296,32768,65536,1297,262144,1024,32768,1296,4194304,16,99213,129,665,4457356,1944,1296,4295170,1933,4294967296,256,4299260711,1297,137]

theorem envBound1049 : H12AffineFastState.Bounded env1049 := by
  intro p hp
  have h : env1049.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1048_1049 : H12AffineEnvironment.transform 13 1296 env1048 = env1049 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1296 env1048 == env1049) = true)

theorem identity1049 : scanCanonicalize (H12AffineFastState.compose env1049 (packedSelected [1,4,5,8,9,12,13,15,16,21,28] rootPS)) = affineNative (2^(15+1) ^^^ 33543) := by decide +kernel

theorem selectedBound1049 : packedSelected [1,4,5,8,9,12,13,15,16,21,28] rootPS < 2^1333 := by decide +kernel

def env1050 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1296,640,1296,32768,33543,1297,262144,1024,32768,1296,4194304,16,138,129,665,4457356,1944,1296,4196613,1933,4294967296,256,4299161632,1297,137]

theorem envBound1050 : H12AffineFastState.Bounded env1050 := by
  intro p hp
  have h : env1050.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1049_1050 : H12AffineEnvironment.transform 15 33543 env1049 = env1050 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33543 env1049 == env1050) = true)

theorem identity1050 : scanCanonicalize (H12AffineFastState.compose env1050 (packedSelected [1,3,4,9,13,16] rootPS)) = affineNative (2^(31+1) ^^^ 0) := by decide +kernel

theorem selectedBound1050 : packedSelected [1,3,4,9,13,16] rootPS < 2^1333 := by decide +kernel

def env1051 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1296,640,1296,32768,33543,1297,262144,1024,32768,1296,4194304,16,138,129,665,4457356,1944,1296,4196613,1933,0,256,4194336,1297,137]

theorem envBound1051 : H12AffineFastState.Bounded env1051 := by
  intro p hp
  have h : env1051.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1050_1051 : H12AffineEnvironment.transform 31 0 env1050 = env1051 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 0 env1050 == env1051) = true)

theorem identity1051 : scanCanonicalize (H12AffineFastState.compose env1051 (packedSelected [0,4,7,9,12,15,21] rootPS)) = affineNative (2^(17+1) ^^^ 2341) := by decide +kernel

theorem selectedBound1051 : packedSelected [0,4,7,9,12,15,21] rootPS < 2^1333 := by decide +kernel

def env1052 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1296,640,1296,32768,33543,1297,2341,1024,32768,1296,4194304,16,138,129,665,4197033,1944,1296,4196613,1933,0,256,4194336,1297,137]

theorem envBound1052 : H12AffineFastState.Bounded env1052 := by
  intro p hp
  have h : env1052.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1051_1052 : H12AffineEnvironment.transform 17 2341 env1051 = env1052 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2341 env1051 == env1052) = true)

theorem identity1052 : scanCanonicalize (H12AffineFastState.compose env1052 (packedSelected [1,12,15,24] rootPS)) = affineNative (2^(10+1) ^^^ 32) := by decide +kernel

theorem selectedBound1052 : packedSelected [1,12,15,24] rootPS < 2^1333 := by decide +kernel

def env1053 : List Nat := [2,4,8,16,32,16,128,256,512,1024,32,1296,640,1296,32768,33543,1297,261,1024,32768,1296,4194304,16,138,129,665,4194953,1944,1296,4194597,1933,0,256,4194336,1297,137]

theorem envBound1053 : H12AffineFastState.Bounded env1053 := by
  intro p hp
  have h : env1053.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1052_1053 : H12AffineEnvironment.transform 10 32 env1052 = env1053 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 32 env1052 == env1053) = true)

theorem identity1053 : scanCanonicalize (H12AffineFastState.compose env1053 (packedSelected [1,2,3,4,5,6,7,10,11,15,18,20,23] rootPS)) = affineNative (2^(14+1) ^^^ 649) := by decide +kernel

theorem selectedBound1053 : packedSelected [1,2,3,4,5,6,7,10,11,15,18,20,23] rootPS < 2^1333 := by decide +kernel

def env1054 : List Nat := [2,4,8,16,32,16,128,256,512,1024,32,1296,640,1296,649,398,1297,261,1024,649,1296,4194304,16,138,129,665,4194953,1944,1296,4194597,1933,0,256,4194336,1297,137]

theorem envBound1054 : H12AffineFastState.Bounded env1054 := by
  intro p hp
  have h : env1054.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1053_1054 : H12AffineEnvironment.transform 14 649 env1053 = env1054 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 649 env1053 == env1054) = true)

theorem identity1054 : scanCanonicalize (H12AffineFastState.compose env1054 (packedSelected [0,1,3,4,6,8,10,13,15,18] rootPS)) = affineNative (2^(21+1) ^^^ 309) := by decide +kernel

theorem selectedBound1054 : packedSelected [0,1,3,4,6,8,10,13,15,18] rootPS < 2^1333 := by decide +kernel

def env1055 : List Nat := [2,4,8,16,32,16,128,256,512,1024,32,1296,640,1296,649,398,1297,261,1024,649,1296,309,16,138,129,665,956,1944,1296,16,1933,0,256,277,1297,137]

theorem envBound1055 : H12AffineFastState.Bounded env1055 := by
  intro p hp
  have h : env1055.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1054_1055 : H12AffineEnvironment.transform 21 309 env1054 = env1055 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 309 env1054 == env1055) = true)

theorem identity1055 : scanCanonicalize (H12AffineFastState.compose env1055 (packedSelected [0,2,3,5,7,11,15] rootPS)) = affineNative (2^(7+1) ^^^ 53) := by decide +kernel

theorem selectedBound1055 : packedSelected [0,2,3,5,7,11,15] rootPS < 2^1333 := by decide +kernel

def env1056 : List Nat := [2,4,8,16,32,16,128,53,512,1024,32,1061,640,1061,649,187,1060,48,1024,649,1061,0,16,138,129,665,649,1709,1061,16,1720,0,53,32,1060,137]

theorem envBound1056 : H12AffineFastState.Bounded env1056 := by
  intro p hp
  have h : env1056.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1055_1056 : H12AffineEnvironment.transform 7 53 env1055 = env1056 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 53 env1055 == env1056) = true)

theorem identity1056 : scanCanonicalize (H12AffineFastState.compose env1056 (packedSelected [1,3] rootPS)) = affineNative (2^(8+1) ^^^ 48) := by decide +kernel

theorem selectedBound1056 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env1057 : List Nat := [2,4,8,16,32,16,128,53,48,1024,32,1061,176,1061,185,187,1060,48,1024,185,1061,0,16,138,129,169,185,1181,1061,16,1160,0,53,32,1060,137]

theorem envBound1057 : H12AffineFastState.Bounded env1057 := by
  intro p hp
  have h : env1057.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1056_1057 : H12AffineEnvironment.transform 8 48 env1056 = env1057 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 48 env1056 == env1057) = true)

theorem identity1057 : scanCanonicalize (H12AffineFastState.compose env1057 (packedSelected [0,4,5,6] rootPS)) = affineNative (2^(6+1) ^^^ 56) := by decide +kernel

theorem selectedBound1057 : packedSelected [0,4,5,6] rootPS < 2^1333 := by decide +kernel

def env1058 : List Nat := [2,4,8,16,32,16,56,53,48,1024,32,1061,8,1061,1,3,1060,48,1024,1,1061,0,16,50,57,17,1,1061,1061,16,1072,0,53,32,1060,49]

theorem envBound1058 : H12AffineFastState.Bounded env1058 := by
  intro p hp
  have h : env1058.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1057_1058 : H12AffineEnvironment.transform 6 56 env1057 = env1058 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 56 env1057 == env1058) = true)

theorem identity1058 : scanCanonicalize (H12AffineFastState.compose env1058 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 16) := by decide +kernel

theorem selectedBound1058 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1059 : List Nat := [2,4,8,16,16,16,8,5,0,1024,16,1045,8,1045,1,3,1044,0,1024,1,1045,0,16,2,9,17,1,1045,1045,16,1024,0,5,16,1044,1]

theorem envBound1059 : H12AffineFastState.Bounded env1059 := by
  intro p hp
  have h : env1059.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1058_1059 : H12AffineEnvironment.transform 4 16 env1058 = env1059 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env1058 == env1059) = true)

theorem identity1059 : scanCanonicalize (H12AffineFastState.compose env1059 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound1059 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1060 : List Nat := [2,4,8,10,10,10,8,5,0,1024,10,1039,8,1039,1,3,1038,0,1024,1,1039,0,10,2,9,11,1,1039,1039,10,1024,0,5,10,1038,1]

theorem envBound1060 : H12AffineFastState.Bounded env1060 := by
  intro p hp
  have h : env1060.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1059_1060 : H12AffineEnvironment.transform 3 10 env1059 = env1060 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env1059 == env1060) = true)

def leafEnv1060 : List Nat := [2,4,8,10,10,10,8,5,0,1024,10,1039,8,1039,1,3,1038,0,1024,1,1039,0,10,2,1024,9,1,11,1,1039,1039,10,1024,0,5,10,4,2,1038,1,0,1039,1]

def active1060 : List Nat := [0,1,2,9]

def tree1060 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1060 : H12WitnessSearch.Good tree1060 := H12GlobalWitnessIndex.good

theorem leafIdentity1060 : H12AffineFastState.composeSystem env1060 rootObs = leafEnv1060 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1060 rootObs == leafEnv1060) = true)

theorem terminalChecked1060 : H12PackedTerminal.terminalCheckFast leafEnv1060 active1060 tree1060 = true := by decide +kernel

def env1061 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,16777216,33554432,17010965,21352449,17024020,131073,21105822,16876544,4294967296,256,4332967606,131072,33554441]

theorem envBound1061 : H12AffineFastState.Bounded env1061 := by
  intro p hp
  have h : env1061.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans984_1061 : H12AffineEnvironment.transform 12 641 env984 = env1061 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 641 env984 == env1061) = true)

def env1062 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,16777216,33554432,16875797,21352449,16897044,4097,20978846,16876544,4294967296,256,4332832438,4096,33554441]

theorem envBound1062 : H12AffineFastState.Bounded env1062 := by
  intro p hp
  have h : env1062.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1061_1062 : H12AffineEnvironment.transform 16 4096 env1061 = env1062 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env1061 == env1062) = true)

theorem identity1062 : scanCanonicalize (H12AffineFastState.compose env1062 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(24+1) ^^^ 16896389) := by decide +kernel

theorem selectedBound1062 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env1063 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,16777216,16896389,16875797,21352449,16897044,4097,20978846,16876544,4294967296,256,4315944755,4096,16896396]

theorem envBound1063 : H12AffineFastState.Bounded env1063 := by
  intro p hp
  have h : env1063.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1062_1063 : H12AffineEnvironment.transform 24 16896389 env1062 = env1063 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 16896389 env1062 == env1063) = true)

def env1064 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,9,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,16777216,16896389,16875797,21352449,16897044,4097,20978846,16876544,4294967296,256,4315944379,4096,16896396]

theorem envBound1064 : H12AffineFastState.Bounded env1064 := by
  intro p hp
  have h : env1064.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1063_1064 : H12AffineEnvironment.transform 8 136 env1063 = env1064 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1063 == env1064) = true)

theorem identity1064 : scanCanonicalize (H12AffineFastState.compose env1064 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(13+1) ^^^ 1297) := by decide +kernel

theorem selectedBound1064 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env1065 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,9,1297,32768,65536,4096,262144,1024,32768,4096,4194304,17,16777216,16880788,16875797,21337360,16879877,4097,20978846,16876544,4294967296,256,4315944379,4096,16880797]

theorem envBound1065 : H12AffineFastState.Bounded env1065 := by
  intro p hp
  have h : env1065.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1064_1065 : H12AffineEnvironment.transform 13 1297 env1064 = env1065 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1297 env1064 == env1065) = true)

theorem identity1065 : scanCanonicalize (H12AffineFastState.compose env1065 (packedSelected [3,5,6,8,10,25,28,31] rootPS)) = affineNative (2^(23+1) ^^^ 103444) := by decide +kernel

theorem selectedBound1065 : packedSelected [3,5,6,8,10,25,28,31] rootPS < 2^1333 := by decide +kernel

def env1066 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,9,1297,32768,65536,4096,262144,1024,32768,4096,4194304,17,103444,128,5377,4456708,1297,4097,4294794,4116,4294967296,256,4299260335,4096,137]

theorem envBound1066 : H12AffineFastState.Bounded env1066 := by
  intro p hp
  have h : env1066.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1065_1066 : H12AffineEnvironment.transform 23 103444 env1065 = env1066 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 103444 env1065 == env1066) = true)

theorem identity1066 : scanCanonicalize (H12AffineFastState.compose env1066 (packedSelected [5,8,17,21] rootPS)) = affineNative (2^(14+1) ^^^ 260) := by decide +kernel

theorem selectedBound1066 : packedSelected [5,8,17,21] rootPS < 2^1333 := by decide +kernel

def env1067 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,9,1297,260,65536,4096,262144,1024,260,4096,4194304,17,70928,128,5377,4456708,1297,4097,4262286,4116,4294967296,256,4299227307,4096,137]

theorem envBound1067 : H12AffineFastState.Bounded env1067 := by
  intro p hp
  have h : env1067.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1066_1067 : H12AffineEnvironment.transform 14 260 env1066 = env1067 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 260 env1066 == env1067) = true)

theorem identity1067 : scanCanonicalize (H12AffineFastState.compose env1067 (packedSelected [5,6,8,10,12,13] rootPS)) = affineNative (2^(31+1) ^^^ 4196623) := by decide +kernel

theorem selectedBound1067 : packedSelected [5,6,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env1068 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,9,1297,260,65536,4096,262144,1024,260,4096,4194304,17,70928,128,5377,4456708,1297,4097,4262286,4116,4196623,256,68004,4096,137]

theorem envBound1068 : H12AffineFastState.Bounded env1068 := by
  intro p hp
  have h : env1068.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1067_1068 : H12AffineEnvironment.transform 31 4196623 env1067 = env1068 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4196623 env1067 == env1068) = true)

theorem identity1068 : scanCanonicalize (H12AffineFastState.compose env1068 (packedSelected [10,12,17] rootPS)) = affineNative (2^(17+1) ^^^ 7221) := by decide +kernel

theorem selectedBound1068 : packedSelected [10,12,17] rootPS < 2^1333 := by decide +kernel

def env1069 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,9,1297,260,65536,4096,7221,1024,260,4096,4194304,17,70928,128,5377,4201777,1297,4097,4262286,4116,4196623,256,68004,4096,137]

theorem envBound1069 : H12AffineFastState.Bounded env1069 := by
  intro p hp
  have h : env1069.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1068_1069 : H12AffineEnvironment.transform 17 7221 env1068 = env1069 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 7221 env1068 == env1069) = true)

theorem identity1069 : scanCanonicalize (H12AffineFastState.compose env1069 (packedSelected [5,8] rootPS)) = affineNative (2^(15+1) ^^^ 139) := by decide +kernel

theorem selectedBound1069 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env1070 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,9,1297,260,139,4096,7221,1024,260,4096,4194304,17,5531,128,5377,4201777,1297,4097,4196613,4116,4196623,256,2351,4096,137]

theorem envBound1070 : H12AffineFastState.Bounded env1070 := by
  intro p hp
  have h : env1070.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1069_1070 : H12AffineEnvironment.transform 15 139 env1069 = env1070 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 139 env1069 == env1070) = true)

def env1071 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,9,1297,260,139,4096,7221,1024,260,4096,5408,17,5531,128,5377,2065,1297,4097,7205,4116,7215,256,2351,4096,137]

theorem envBound1071 : H12AffineFastState.Bounded env1071 := by
  intro p hp
  have h : env1071.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1070_1071 : H12AffineEnvironment.transform 21 5408 env1070 = env1071 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5408 env1070 == env1071) = true)

theorem identity1071 : scanCanonicalize (H12AffineFastState.compose env1071 (packedSelected [1] rootPS)) = affineNative (2^(10+1) ^^^ 179) := by decide +kernel

theorem selectedBound1071 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1072 : List Nat := [2,4,8,16,32,16,128,256,136,1024,179,4096,9,1297,260,139,4096,5254,1024,260,4096,5408,17,5531,128,5377,162,1297,4097,5270,4116,5276,256,412,4096,137]

theorem envBound1072 : H12AffineFastState.Bounded env1072 := by
  intro p hp
  have h : env1072.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1071_1072 : H12AffineEnvironment.transform 10 179 env1071 = env1072 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 179 env1071 == env1072) = true)

theorem identity1072 : scanCanonicalize (H12AffineFastState.compose env1072 (packedSelected [5] rootPS)) = affineNative (2^(11+1) ^^^ 1039) := by decide +kernel

theorem selectedBound1072 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1073 : List Nat := [2,4,8,16,32,16,128,256,136,1024,179,1039,9,1297,260,139,1039,137,1024,260,1039,303,17,404,128,270,162,1297,1038,153,1051,147,256,412,1039,137]

theorem envBound1073 : H12AffineFastState.Bounded env1073 := by
  intro p hp
  have h : env1073.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1072_1073 : H12AffineEnvironment.transform 11 1039 env1072 = env1073 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1039 env1072 == env1073) = true)

def env1074 : List Nat := [2,4,8,16,0,16,128,256,136,1024,147,1039,9,1297,260,139,1039,137,1024,260,1039,271,17,404,128,270,130,1297,1038,153,1051,147,256,412,1039,137]

theorem envBound1074 : H12AffineFastState.Bounded env1074 := by
  intro p hp
  have h : env1074.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1073_1074 : H12AffineEnvironment.transform 4 0 env1073 = env1074 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1073 == env1074) = true)

theorem identity1074 : scanCanonicalize (H12AffineFastState.compose env1074 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound1074 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1075 : List Nat := [2,4,8,11,0,11,128,256,136,1024,136,1039,9,1290,260,139,1039,137,1024,260,1039,271,10,399,128,270,130,1290,1038,130,1024,136,256,391,1039,137]

theorem envBound1075 : H12AffineFastState.Bounded env1075 := by
  intro p hp
  have h : env1075.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1074_1075 : H12AffineEnvironment.transform 3 11 env1074 = env1075 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env1074 == env1075) = true)

theorem identity1075 : scanCanonicalize (H12AffineFastState.compose env1075 (packedSelected [0,4,6] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound1075 : packedSelected [0,4,6] rootPS < 2^1333 := by decide +kernel

def env1076 : List Nat := [2,4,8,11,0,11,9,256,1,1024,1,1039,9,1290,260,2,1039,0,1024,260,1039,271,10,262,9,270,11,1290,1038,11,1024,1,256,270,1039,0]

theorem envBound1076 : H12AffineFastState.Bounded env1076 := by
  intro p hp
  have h : env1076.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1075_1076 : H12AffineEnvironment.transform 6 9 env1075 = env1076 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env1075 == env1076) = true)

theorem identity1076 : scanCanonicalize (H12AffineFastState.compose env1076 (packedSelected [0] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound1076 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1077 : List Nat := [2,4,3,0,0,0,2,256,1,1024,1,1028,2,1281,260,2,1028,0,1024,260,1028,260,1,262,2,261,0,1281,1029,0,1024,1,256,261,1028,0]

theorem envBound1077 : H12AffineFastState.Bounded env1077 := by
  intro p hp
  have h : env1077.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1076_1077 : H12AffineEnvironment.transform 2 3 env1076 = env1077 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env1076 == env1077) = true)

def env1078 : List Nat := [2,4,8,16,1,16,128,256,136,1024,146,1039,9,1297,260,139,1039,137,1024,260,1039,270,17,404,128,270,131,1297,1038,153,1051,147,256,412,1039,137]

theorem envBound1078 : H12AffineFastState.Bounded env1078 := by
  intro p hp
  have h : env1078.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1073_1078 : H12AffineEnvironment.transform 4 1 env1073 = env1078 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env1073 == env1078) = true)

theorem identity1078 : scanCanonicalize (H12AffineFastState.compose env1078 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1078 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1079 : List Nat := [2,4,8,16,1,16,128,5,136,1024,146,1039,9,1044,1,139,1039,137,1024,1,1039,11,17,145,128,11,131,1044,1038,153,1051,147,5,153,1039,137]

theorem envBound1079 : H12AffineFastState.Bounded env1079 := by
  intro p hp
  have h : env1079.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1078_1079 : H12AffineEnvironment.transform 7 5 env1078 = env1079 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1078 == env1079) = true)

theorem identity1079 : scanCanonicalize (H12AffineFastState.compose env1079 (packedSelected [0,4,6] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound1079 : packedSelected [0,4,6] rootPS < 2^1333 := by decide +kernel

def env1080 : List Nat := [2,4,8,16,1,16,2,5,10,1024,16,1039,9,1044,1,9,1039,11,1024,1,1039,11,17,19,2,11,1,1044,1038,27,1051,17,5,27,1039,11]

theorem envBound1080 : H12AffineFastState.Bounded env1080 := by
  intro p hp
  have h : env1080.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1079_1080 : H12AffineEnvironment.transform 6 2 env1079 = env1080 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env1079 == env1080) = true)

theorem identity1080 : scanCanonicalize (H12AffineFastState.compose env1080 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound1080 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1081 : List Nat := [2,4,8,10,1,10,2,5,10,1024,10,1039,9,1038,1,9,1039,11,1024,1,1039,11,11,9,2,11,1,1038,1038,1,1025,11,5,1,1039,11]

theorem envBound1081 : H12AffineFastState.Bounded env1081 := by
  intro p hp
  have h : env1081.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1080_1081 : H12AffineEnvironment.transform 3 10 env1080 = env1081 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env1080 == env1081) = true)

theorem identity1081 : scanCanonicalize (H12AffineFastState.compose env1081 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1081 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1082 : List Nat := [2,4,2,0,1,0,2,5,0,1024,0,1029,3,1028,1,3,1029,1,1024,1,1029,1,1,3,2,1,1,1028,1028,1,1025,1,5,1,1029,1]

theorem envBound1082 : H12AffineFastState.Bounded env1082 := by
  intro p hp
  have h : env1082.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1081_1082 : H12AffineEnvironment.transform 2 2 env1081 = env1082 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1081 == env1082) = true)

def env1083 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,9,1297,260,139,4096,7221,1024,260,4096,5409,17,5531,128,5377,2064,1297,4097,7204,4116,7214,256,2351,4096,137]

theorem envBound1083 : H12AffineFastState.Bounded env1083 := by
  intro p hp
  have h : env1083.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1070_1083 : H12AffineEnvironment.transform 21 5409 env1070 = env1083 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5409 env1070 == env1083) = true)

theorem identity1083 : scanCanonicalize (H12AffineFastState.compose env1083 (packedSelected [1] rootPS)) = affineNative (2^(11+1) ^^^ 3491) := by decide +kernel

theorem selectedBound1083 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1084 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,3491,9,1297,260,139,3491,406,1024,260,3491,2178,17,2104,128,2210,2064,1297,3490,391,3511,397,256,2351,3491,137]

theorem envBound1084 : H12AffineFastState.Bounded env1084 := by
  intro p hp
  have h : env1084.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1083_1084 : H12AffineEnvironment.transform 11 3491 env1083 = env1084 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3491 env1083 == env1084) = true)

theorem identity1084 : scanCanonicalize (H12AffineFastState.compose env1084 (packedSelected [5] rootPS)) = affineNative (2^(10+1) ^^^ 429) := by decide +kernel

theorem selectedBound1084 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1085 : List Nat := [2,4,8,16,32,16,128,256,136,1024,429,1038,9,1297,260,139,1038,406,1024,260,1038,303,17,405,128,271,445,1297,1039,391,1050,397,256,130,1038,137]

theorem envBound1085 : H12AffineFastState.Bounded env1085 := by
  intro p hp
  have h : env1085.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1084_1085 : H12AffineEnvironment.transform 10 429 env1084 = env1085 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 429 env1084 == env1085) = true)

def env1086 : List Nat := [2,4,8,16,0,16,128,256,136,1024,397,1038,9,1297,260,139,1038,406,1024,260,1038,271,17,405,128,271,413,1297,1039,391,1050,397,256,130,1038,137]

theorem envBound1086 : H12AffineFastState.Bounded env1086 := by
  intro p hp
  have h : env1086.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1085_1086 : H12AffineEnvironment.transform 4 0 env1085 = env1086 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1085 == env1086) = true)

theorem identity1086 : scanCanonicalize (H12AffineFastState.compose env1086 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound1086 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1087 : List Nat := [2,4,8,10,0,10,128,256,136,1024,397,1038,9,1291,260,139,1038,396,1024,260,1038,271,11,399,128,271,391,1291,1039,391,1024,397,256,130,1038,137]

theorem envBound1087 : H12AffineFastState.Bounded env1087 := by
  intro p hp
  have h : env1087.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1086_1087 : H12AffineEnvironment.transform 3 10 env1086 = env1087 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env1086 == env1087) = true)

theorem identity1087 : scanCanonicalize (H12AffineFastState.compose env1087 (packedSelected [0,4,6] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound1087 : packedSelected [0,4,6] rootPS < 2^1333 := by decide +kernel

def env1088 : List Nat := [2,4,8,10,0,10,8,256,0,1024,261,1038,9,1291,260,3,1038,260,1024,260,1038,271,11,263,8,271,271,1291,1039,271,1024,261,256,10,1038,1]

theorem envBound1088 : H12AffineFastState.Bounded env1088 := by
  intro p hp
  have h : env1088.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1087_1088 : H12AffineEnvironment.transform 6 8 env1087 = env1088 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env1087 == env1088) = true)

theorem identity1088 : scanCanonicalize (H12AffineFastState.compose env1088 (packedSelected [2] rootPS)) = affineNative (2^(7+1) ^^^ 15) := by decide +kernel

theorem selectedBound1088 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1089 : List Nat := [2,4,8,10,0,10,8,15,0,1024,10,1038,9,1028,11,3,1038,11,1024,11,1038,0,11,8,8,0,0,1028,1039,0,1024,10,15,10,1038,1]

theorem envBound1089 : H12AffineFastState.Bounded env1089 := by
  intro p hp
  have h : env1089.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1088_1089 : H12AffineEnvironment.transform 7 15 env1088 = env1089 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 15 env1088 == env1089) = true)

theorem identity1089 : scanCanonicalize (H12AffineFastState.compose env1089 (packedSelected [7] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound1089 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1090 : List Nat := [2,4,2,0,0,0,2,5,0,1024,0,1028,3,1028,1,3,1028,1,1024,1,1028,0,1,2,2,0,0,1028,1029,0,1024,0,5,0,1028,1]

theorem envBound1090 : H12AffineFastState.Bounded env1090 := by
  intro p hp
  have h : env1090.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1089_1090 : H12AffineEnvironment.transform 2 2 env1089 = env1090 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env1089 == env1090) = true)

def leafEnv1090 : List Nat := [2,4,2,0,0,0,2,5,0,1024,0,1028,3,1028,1,3,1028,1,1024,1,1028,0,1,2,1024,2,1,0,0,1028,1029,0,1024,0,5,0,4,2,1028,1,0,1029,1]

def active1090 : List Nat := [0,1,9]

def tree1090 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1090 : H12WitnessSearch.Good tree1090 := H12GlobalWitnessIndex.good

theorem leafIdentity1090 : H12AffineFastState.composeSystem env1090 rootObs = leafEnv1090 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1090 rootObs == leafEnv1090) = true)

theorem terminalChecked1090 : H12PackedTerminal.terminalCheckFast leafEnv1090 active1090 tree1090 = true := by decide +kernel

def env1091 : List Nat := [2,4,8,16,1,16,128,256,136,1024,396,1038,9,1297,260,139,1038,406,1024,260,1038,270,17,405,128,271,412,1297,1039,391,1050,397,256,130,1038,137]

theorem envBound1091 : H12AffineFastState.Bounded env1091 := by
  intro p hp
  have h : env1091.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1085_1091 : H12AffineEnvironment.transform 4 1 env1085 = env1091 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env1085 == env1091) = true)

theorem identity1091 : scanCanonicalize (H12AffineFastState.compose env1091 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1091 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1092 : List Nat := [2,4,8,16,1,16,128,5,136,1024,137,1038,9,1044,1,139,1038,147,1024,1,1038,11,17,144,128,10,153,1044,1039,130,1050,136,5,130,1038,137]

theorem envBound1092 : H12AffineFastState.Bounded env1092 := by
  intro p hp
  have h : env1092.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1091_1092 : H12AffineEnvironment.transform 7 5 env1091 = env1092 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1091 == env1092) = true)

theorem identity1092 : scanCanonicalize (H12AffineFastState.compose env1092 (packedSelected [0,4,6] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound1092 : packedSelected [0,4,6] rootPS < 2^1333 := by decide +kernel

def env1093 : List Nat := [2,4,8,16,1,16,3,5,11,1024,10,1038,9,1044,1,8,1038,16,1024,1,1038,11,17,19,3,10,26,1044,1039,1,1050,11,5,1,1038,10]

theorem envBound1093 : H12AffineFastState.Bounded env1093 := by
  intro p hp
  have h : env1093.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1092_1093 : H12AffineEnvironment.transform 6 3 env1092 = env1093 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env1092 == env1093) = true)

theorem identity1093 : scanCanonicalize (H12AffineFastState.compose env1093 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound1093 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1094 : List Nat := [2,4,8,1,1,1,3,5,11,1024,10,1038,9,1029,1,8,1038,1,1024,1,1038,11,0,2,3,10,11,1029,1039,1,1035,11,5,1,1038,10]

theorem envBound1094 : H12AffineFastState.Bounded env1094 := by
  intro p hp
  have h : env1094.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1093_1094 : H12AffineEnvironment.transform 3 1 env1093 = env1094 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env1093 == env1094) = true)

theorem identity1094 : scanCanonicalize (H12AffineFastState.compose env1094 (packedSelected [7] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound1094 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1095 : List Nat := [2,4,3,1,1,1,3,5,0,1024,1,1029,2,1029,1,3,1029,1,1024,1,1029,0,0,2,3,1,0,1029,1028,1,1024,0,5,1,1029,1]

theorem envBound1095 : H12AffineFastState.Bounded env1095 := by
  intro p hp
  have h : env1095.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1094_1095 : H12AffineEnvironment.transform 2 3 env1094 = env1095 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env1094 == env1095) = true)

def leafEnv1095 : List Nat := [2,4,3,1,1,1,3,5,0,1024,1,1029,2,1029,1,3,1029,1,1024,1,1029,0,0,2,1024,3,1,1,0,1029,1028,1,1024,0,5,1,4,2,1029,1,0,1028,1]

def active1095 : List Nat := [0,1,9]

def tree1095 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1095 : H12WitnessSearch.Good tree1095 := H12GlobalWitnessIndex.good

theorem leafIdentity1095 : H12AffineFastState.composeSystem env1095 rootObs = leafEnv1095 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1095 rootObs == leafEnv1095) = true)

theorem terminalChecked1095 : H12PackedTerminal.terminalCheckFast leafEnv1095 active1095 tree1095 = true := by decide +kernel

def env1096 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,16777216,16896389,16875797,21352449,16897044,4097,20978846,16876544,4294967296,256,4315944378,4096,16896396]

theorem envBound1096 : H12AffineFastState.Bounded env1096 := by
  intro p hp
  have h : env1096.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1063_1096 : H12AffineEnvironment.transform 8 137 env1063 = env1096 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1063 == env1096) = true)

theorem identity1096 : scanCanonicalize (H12AffineFastState.compose env1096 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(23+1) ^^^ 103444) := by decide +kernel

theorem selectedBound1096 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env1097 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,103444,17809,5377,4473877,16384,4097,4294794,4116,4294967296,256,4299260334,4096,17816]

theorem envBound1097 : H12AffineFastState.Bounded env1097 := by
  intro p hp
  have h : env1097.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1096_1097 : H12AffineEnvironment.transform 23 103444 env1096 = env1097 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 103444 env1096 == env1097) = true)

theorem identity1097 : scanCanonicalize (H12AffineFastState.compose env1097 (packedSelected [0,1,3,4,7,9,10,16,17,19,20,21] rootPS)) = affineNative (2^(13+1) ^^^ 4097) := by decide +kernel

theorem selectedBound1097 : packedSelected [0,1,3,4,7,9,10,16,17,19,20,21] rootPS < 2^1333 := by decide +kernel

def env1098 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,4097,32768,65536,4096,262144,1024,32768,4096,4194304,5377,103444,5520,5377,4461588,4097,4097,4294794,4116,4294967296,256,4299260334,4096,5529]

theorem envBound1098 : H12AffineFastState.Bounded env1098 := by
  intro p hp
  have h : env1098.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1097_1098 : H12AffineEnvironment.transform 13 4097 env1097 = env1098 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4097 env1097 == env1098) = true)

theorem identity1098 : scanCanonicalize (H12AffineFastState.compose env1098 (packedSelected [13,17] rootPS)) = affineNative (2^(15+1) ^^^ 33166) := by decide +kernel

theorem selectedBound1098 : packedSelected [13,17] rootPS < 2^1333 := by decide +kernel

def env1099 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,4097,32768,33166,4096,262144,1024,32768,4096,4194304,5377,5530,5520,5377,4461588,4097,4097,4196612,4116,4294967296,256,4299161632,4096,5529]

theorem envBound1099 : H12AffineFastState.Bounded env1099 := by
  intro p hp
  have h : env1099.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1098_1099 : H12AffineEnvironment.transform 15 33166 env1098 = env1099 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33166 env1098 == env1099) = true)

theorem identity1099 : scanCanonicalize (H12AffineFastState.compose env1099 (packedSelected [5,8,10,12,13] rootPS)) = affineNative (2^(17+1) ^^^ 40241) := by decide +kernel

theorem selectedBound1099 : packedSelected [5,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env1100 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,4097,32768,33166,4096,40241,1024,32768,4096,4194304,5377,5530,5520,5377,4229413,4097,4097,4196612,4116,4294967296,256,4299161632,4096,5529]

theorem envBound1100 : H12AffineFastState.Bounded env1100 := by
  intro p hp
  have h : env1100.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1099_1100 : H12AffineEnvironment.transform 17 40241 env1099 = env1100 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 40241 env1099 == env1100) = true)

theorem identity1100 : scanCanonicalize (H12AffineFastState.compose env1100 (packedSelected [0,2,4,6,8,16,18] rootPS)) = affineNative (2^(21+1) ^^^ 260) := by decide +kernel

theorem selectedBound1100 : packedSelected [0,2,4,6,8,16,18] rootPS < 2^1333 := by decide +kernel

def env1101 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,4097,32768,33166,4096,40241,1024,32768,4096,260,5377,5530,5520,5377,34849,4097,4097,2048,4116,4294967296,256,4294967588,4096,5529]

theorem envBound1101 : H12AffineFastState.Bounded env1101 := by
  intro p hp
  have h : env1101.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1100_1101 : H12AffineEnvironment.transform 21 260 env1100 = env1101 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 260 env1100 == env1101) = true)

theorem identity1101 : scanCanonicalize (H12AffineFastState.compose env1101 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound1101 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env1102 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8,1296,32768,33166,1297,34848,1024,32768,1297,260,16,139,129,16,34849,1296,1296,2048,1285,4294967296,256,4294967588,1297,136]

theorem envBound1102 : H12AffineFastState.Bounded env1102 := by
  intro p hp
  have h : env1102.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1101_1102 : H12AffineEnvironment.transform 11 1297 env1101 = env1102 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env1101 == env1102) = true)

theorem identity1102 : scanCanonicalize (H12AffineFastState.compose env1102 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 35124) := by decide +kernel

theorem selectedBound1102 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1103 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8,1296,32768,33166,1297,34848,1024,32768,1297,260,16,139,129,16,34849,1296,1296,2048,1285,35124,256,34832,1297,136]

theorem envBound1103 : H12AffineFastState.Bounded env1103 := by
  intro p hp
  have h : env1103.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1102_1103 : H12AffineEnvironment.transform 31 35124 env1102 = env1103 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 35124 env1102 == env1103) = true)

theorem identity1103 : scanCanonicalize (H12AffineFastState.compose env1103 (packedSelected [0,7] rootPS)) = affineNative (2^(14+1) ^^^ 2340) := by decide +kernel

theorem selectedBound1103 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env1104 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,8,1296,2340,2218,1297,260,1024,2340,1297,260,16,139,129,16,261,1296,1296,2048,1285,16,256,308,1297,136]

theorem envBound1104 : H12AffineFastState.Bounded env1104 := by
  intro p hp
  have h : env1104.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1103_1104 : H12AffineEnvironment.transform 14 2340 env1103 = env1104 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2340 env1103 == env1104) = true)

def env1105 : List Nat := [2,4,8,16,32,16,128,256,137,1024,32,1297,8,1296,260,138,1297,260,1024,260,1297,260,16,139,129,16,261,1296,1296,32,1285,16,256,308,1297,136]

theorem envBound1105 : H12AffineFastState.Bounded env1105 := by
  intro p hp
  have h : env1105.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1104_1105 : H12AffineEnvironment.transform 10 32 env1104 = env1105 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 32 env1104 == env1105) = true)

theorem identity1105 : scanCanonicalize (H12AffineFastState.compose env1105 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 27) := by decide +kernel

theorem selectedBound1105 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1106 : List Nat := [2,4,8,16,27,16,128,256,137,1024,27,1297,8,1296,260,138,1297,260,1024,260,1297,260,16,139,129,16,261,1296,1296,27,1285,16,256,271,1297,136]

theorem envBound1106 : H12AffineFastState.Bounded env1106 := by
  intro p hp
  have h : env1106.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1105_1106 : H12AffineEnvironment.transform 4 27 env1105 = env1106 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 27 env1105 == env1106) = true)

def env1107 : List Nat := [2,4,8,16,27,16,128,20,137,1024,27,1029,8,1028,16,138,1029,16,1024,16,1029,16,16,139,129,16,17,1028,1028,27,1041,16,20,27,1029,136]

theorem envBound1107 : H12AffineFastState.Bounded env1107 := by
  intro p hp
  have h : env1107.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1106_1107 : H12AffineEnvironment.transform 7 20 env1106 = env1107 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 20 env1106 == env1107) = true)

theorem identity1107 : scanCanonicalize (H12AffineFastState.compose env1107 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound1107 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1108 : List Nat := [2,4,8,11,0,11,128,15,137,1024,0,1029,8,1028,11,138,1029,11,1024,11,1029,11,11,139,129,11,10,1028,1028,0,1034,11,15,0,1029,136]

theorem envBound1108 : H12AffineFastState.Bounded env1108 := by
  intro p hp
  have h : env1108.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1107_1108 : H12AffineEnvironment.transform 3 11 env1107 = env1108 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env1107 == env1108) = true)

def leafEnv1108 : List Nat := [2,4,8,11,0,11,128,15,137,1024,0,1029,8,1028,11,138,1029,11,1024,11,1029,11,11,139,1034,129,1,11,10,1028,1028,0,1034,11,15,0,4,2,1029,136,0,1028,1]

def active1108 : List Nat := [0,1,2,6,9]

def tree1108 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1108 : H12WitnessSearch.Good tree1108 := H12GlobalWitnessIndex.good

theorem leafIdentity1108 : H12AffineFastState.composeSystem env1108 rootObs = leafEnv1108 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1108 rootObs == leafEnv1108) = true)

theorem terminalChecked1108 : H12PackedTerminal.terminalCheckFast leafEnv1108 active1108 tree1108 = true := by decide +kernel

def env1109 : List Nat := [2,4,8,16,27,16,128,21,137,1024,27,1028,8,1029,17,138,1028,17,1024,17,1028,17,16,139,129,16,16,1029,1029,27,1040,16,21,26,1028,136]

theorem envBound1109 : H12AffineFastState.Bounded env1109 := by
  intro p hp
  have h : env1109.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1106_1109 : H12AffineEnvironment.transform 7 21 env1106 = env1109 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 21 env1106 == env1109) = true)

theorem identity1109 : scanCanonicalize (H12AffineFastState.compose env1109 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1109 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1110 : List Nat := [2,4,8,0,11,0,128,5,137,1024,11,1028,8,1029,1,138,1028,1,1024,1,1028,1,0,139,129,0,0,1029,1029,11,1024,0,5,10,1028,136]

theorem envBound1110 : H12AffineFastState.Bounded env1110 := by
  intro p hp
  have h : env1110.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1109_1110 : H12AffineEnvironment.transform 3 0 env1109 = env1110 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1109 == env1110) = true)

def leafEnv1110 : List Nat := [2,4,8,0,11,0,128,5,137,1024,11,1028,8,1029,1,138,1028,1,1024,1,1028,1,0,139,1024,129,1,0,0,1029,1029,11,1024,0,5,10,4,2,1028,136,0,1029,1]

def active1110 : List Nat := [0,1,2,6,9]

def tree1110 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1110 : H12WitnessSearch.Good tree1110 := H12GlobalWitnessIndex.good

theorem leafIdentity1110 : H12AffineFastState.composeSystem env1110 rootObs = leafEnv1110 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1110 rootObs == leafEnv1110) = true)

theorem terminalChecked1110 : H12PackedTerminal.terminalCheckFast leafEnv1110 active1110 tree1110 = true := by decide +kernel

def env1111 : List Nat := [2,4,8,16,32,16,128,256,137,1024,33,1297,8,1296,261,139,1297,260,1024,261,1297,260,16,139,129,16,261,1296,1296,33,1285,16,256,308,1297,136]

theorem envBound1111 : H12AffineFastState.Bounded env1111 := by
  intro p hp
  have h : env1111.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1104_1111 : H12AffineEnvironment.transform 10 33 env1104 = env1111 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 33 env1104 == env1111) = true)

theorem identity1111 : scanCanonicalize (H12AffineFastState.compose env1111 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 51) := by decide +kernel

theorem selectedBound1111 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1112 : List Nat := [2,4,8,16,32,16,51,256,58,1024,33,1297,8,1296,261,56,1297,260,1024,261,1297,260,16,56,50,16,261,1296,1296,33,1285,16,256,308,1297,59]

theorem envBound1112 : H12AffineFastState.Bounded env1112 := by
  intro p hp
  have h : env1112.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1111_1112 : H12AffineEnvironment.transform 6 51 env1111 = env1112 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 51 env1111 == env1112) = true)

def env1113 : List Nat := [2,4,8,16,16,16,3,256,10,1024,17,1297,8,1296,261,8,1297,260,1024,261,1297,260,16,8,2,16,261,1296,1296,17,1285,16,256,260,1297,11]

theorem envBound1113 : H12AffineFastState.Bounded env1113 := by
  intro p hp
  have h : env1113.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1112_1113 : H12AffineEnvironment.transform 4 16 env1112 = env1113 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env1112 == env1113) = true)

theorem identity1113 : scanCanonicalize (H12AffineFastState.compose env1113 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1113 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1114 : List Nat := [2,4,8,0,0,0,3,256,10,1024,1,1281,8,1280,261,8,1281,260,1024,261,1281,260,0,8,2,0,261,1280,1280,1,1285,0,256,260,1281,11]

theorem envBound1114 : H12AffineFastState.Bounded env1114 := by
  intro p hp
  have h : env1114.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1113_1114 : H12AffineEnvironment.transform 3 0 env1113 = env1114 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1113 == env1114) = true)

def leafEnv1114 : List Nat := [2,4,8,0,0,0,3,256,10,1024,1,1281,8,1280,261,8,1281,260,1024,261,1281,260,0,8,1285,2,1,0,261,1280,1280,1,1285,0,256,260,4,3,1281,11,0,1280,1]

def active1114 : List Nat := [0,1,2,7,9]

def tree1114 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1114 : H12WitnessSearch.Good tree1114 := H12GlobalWitnessIndex.good

theorem leafIdentity1114 : H12AffineFastState.composeSystem env1114 rootObs = leafEnv1114 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1114 rootObs == leafEnv1114) = true)

theorem terminalChecked1114 : H12PackedTerminal.terminalCheckFast leafEnv1114 active1114 tree1114 = true := by decide +kernel

def env1115 : List Nat := [2,4,8,16,17,16,2,256,11,1024,16,1297,8,1296,261,9,1297,260,1024,261,1297,260,16,9,3,16,261,1296,1296,16,1285,16,256,261,1297,10]

theorem envBound1115 : H12AffineFastState.Bounded env1115 := by
  intro p hp
  have h : env1115.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1112_1115 : H12AffineEnvironment.transform 4 17 env1112 = env1115 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env1112 == env1115) = true)

theorem identity1115 : scanCanonicalize (H12AffineFastState.compose env1115 (packedSelected [2] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1115 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1116 : List Nat := [2,4,8,16,17,16,2,5,11,1024,16,1044,8,1045,0,9,1044,1,1024,0,1044,1,16,9,3,16,0,1045,1045,16,1024,16,5,0,1044,10]

theorem envBound1116 : H12AffineFastState.Bounded env1116 := by
  intro p hp
  have h : env1116.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1115_1116 : H12AffineEnvironment.transform 7 5 env1115 = env1116 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1115 == env1116) = true)

def leafEnv1116 : List Nat := [2,4,8,16,17,16,2,5,11,1024,16,1044,8,1045,0,9,1044,1,1024,0,1044,1,16,9,1024,3,1,16,0,1045,1045,16,1024,16,5,0,4,3,1044,10,0,1045,1]

def active1116 : List Nat := [0,1,2,3,9]

def tree1116 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1116 : H12WitnessSearch.Good tree1116 := H12GlobalWitnessIndex.good

theorem leafIdentity1116 : H12AffineFastState.composeSystem env1116 rootObs = leafEnv1116 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1116 rootObs == leafEnv1116) = true)

theorem terminalChecked1116 : H12PackedTerminal.terminalCheckFast leafEnv1116 active1116 tree1116 = true := by decide +kernel

def env1117 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,16777216,33554432,16875796,21352449,16897045,4096,20978847,16876544,4294967296,256,4332832439,4097,33554441]

theorem envBound1117 : H12AffineFastState.Bounded env1117 := by
  intro p hp
  have h : env1117.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1061_1117 : H12AffineEnvironment.transform 16 4097 env1061 = env1117 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env1061 == env1117) = true)

theorem identity1117 : scanCanonicalize (H12AffineFastState.compose env1117 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(24+1) ^^^ 16893077) := by decide +kernel

theorem selectedBound1117 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env1118 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,641,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,16777216,16893077,16875796,21352449,16897045,4096,20978847,16876544,4294967296,256,4315939362,4097,16893084]

theorem envBound1118 : H12AffineFastState.Bounded env1118 := by
  intro p hp
  have h : env1118.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1117_1118 : H12AffineEnvironment.transform 24 16893077 env1117 = env1118 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 16893077 env1117 == env1118) = true)

def env1119 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,4096,9,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,16777216,16893077,16875796,21352449,16897045,4096,20978847,16876544,4294967296,256,4315938986,4097,16893084]

theorem envBound1119 : H12AffineFastState.Bounded env1119 := by
  intro p hp
  have h : env1119.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1118_1119 : H12AffineEnvironment.transform 8 136 env1118 = env1119 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1118 == env1119) = true)

theorem identity1119 : scanCanonicalize (H12AffineFastState.compose env1119 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound1119 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env1120 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,9,16384,32768,65536,1297,262144,1024,32768,1296,4194304,17664,16777216,16893077,16875796,21349649,16892165,1296,20973967,16876544,4294967296,256,4315938986,1297,16893084]

theorem envBound1120 : H12AffineFastState.Bounded env1120 := by
  intro p hp
  have h : env1120.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1119_1120 : H12AffineEnvironment.transform 11 1296 env1119 = env1120 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env1119 == env1120) = true)

theorem identity1120 : scanCanonicalize (H12AffineFastState.compose env1120 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 1296) := by decide +kernel

theorem selectedBound1120 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env1121 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,9,1296,32768,65536,1297,262144,1024,32768,1296,4194304,16,16777216,16875909,16875796,21331969,16876565,1296,20973967,16876544,4294967296,256,4315938986,1297,16875916]

theorem envBound1121 : H12AffineFastState.Bounded env1121 := by
  intro p hp
  have h : env1121.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1120_1121 : H12AffineEnvironment.transform 13 1296 env1120 = env1121 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1296 env1120 == env1121) = true)

theorem identity1121 : scanCanonicalize (H12AffineFastState.compose env1121 (packedSelected [1,3,4,9,12,13,15,16,17] rootPS)) = affineNative (2^(23+1) ^^^ 98565) := by decide +kernel

theorem selectedBound1121 : packedSelected [1,3,4,9,12,13,15,16,17] rootPS < 2^1333 := by decide +kernel

def env1122 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,9,1296,32768,65536,1297,262144,1024,32768,1296,4194304,16,98565,128,17,4456708,1296,1296,4294794,1285,4294967296,256,4299260335,1297,137]

theorem envBound1122 : H12AffineFastState.Bounded env1122 := by
  intro p hp
  have h : env1122.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1121_1122 : H12AffineEnvironment.transform 23 98565 env1121 = env1122 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98565 env1121 == env1122) = true)

theorem identity1122 : scanCanonicalize (H12AffineFastState.compose env1122 (packedSelected [1,3,5] rootPS)) = affineNative (2^(17+1) ^^^ 100783) := by decide +kernel

theorem selectedBound1122 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1123 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,9,1296,32768,65536,1297,100783,1024,32768,1296,4194304,16,98565,128,17,4294827,1296,1296,4294794,1285,4294967296,256,4299260335,1297,137]

theorem envBound1123 : H12AffineFastState.Bounded env1123 := by
  intro p hp
  have h : env1123.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1122_1123 : H12AffineEnvironment.transform 17 100783 env1122 = env1123 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 100783 env1122 == env1123) = true)

theorem identity1123 : scanCanonicalize (H12AffineFastState.compose env1123 (packedSelected [1,3,8] rootPS)) = affineNative (2^(15+1) ^^^ 399) := by decide +kernel

theorem selectedBound1123 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env1124 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,9,1296,32768,399,1297,34848,1024,32768,1296,4194304,16,32906,128,17,4229412,1296,1296,4229381,1285,4294967296,256,4299194400,1297,137]

theorem envBound1124 : H12AffineFastState.Bounded env1124 := by
  intro p hp
  have h : env1124.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1123_1124 : H12AffineEnvironment.transform 15 399 env1123 = env1124 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 399 env1123 == env1124) = true)

theorem identity1124 : scanCanonicalize (H12AffineFastState.compose env1124 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 4229152) := by decide +kernel

theorem selectedBound1124 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1125 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,9,1296,32768,399,1297,34848,1024,32768,1296,4194304,16,32906,128,17,4229412,1296,1296,4229381,1285,4229152,256,2048,1297,137]

theorem envBound1125 : H12AffineFastState.Bounded env1125 := by
  intro p hp
  have h : env1125.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1124_1125 : H12AffineEnvironment.transform 31 4229152 env1124 = env1125 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4229152 env1124 == env1125) = true)

theorem identity1125 : scanCanonicalize (H12AffineFastState.compose env1125 (packedSelected [10] rootPS)) = affineNative (2^(21+1) ^^^ 397) := by decide +kernel

theorem selectedBound1125 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env1126 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,9,1296,32768,399,1297,34848,1024,32768,1296,397,16,32906,128,17,34985,1296,1296,34952,1285,35245,256,2048,1297,137]

theorem envBound1126 : H12AffineFastState.Bounded env1126 := by
  intro p hp
  have h : env1126.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1125_1126 : H12AffineEnvironment.transform 21 397 env1125 = env1126 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 397 env1125 == env1126) = true)

theorem identity1126 : scanCanonicalize (H12AffineFastState.compose env1126 (packedSelected [6] rootPS)) = affineNative (2^(14+1) ^^^ 303) := by decide +kernel

theorem selectedBound1126 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1127 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1296,9,1296,303,399,1297,2319,1024,303,1296,397,16,421,128,17,2438,1296,1296,2471,1285,2178,256,2048,1297,137]

theorem envBound1127 : H12AffineFastState.Bounded env1127 := by
  intro p hp
  have h : env1127.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1126_1127 : H12AffineEnvironment.transform 14 303 env1126 = env1127 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 303 env1126 == env1127) = true)

theorem identity1127 : scanCanonicalize (H12AffineFastState.compose env1127 (packedSelected [3,12] rootPS)) = affineNative (2^(10+1) ^^^ 169) := by decide +kernel

theorem selectedBound1127 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env1128 : List Nat := [2,4,8,16,32,16,128,256,136,1024,169,1296,9,1296,303,399,1297,422,1024,303,1296,397,16,421,128,17,303,1296,1296,270,1285,43,256,169,1297,137]

theorem envBound1128 : H12AffineFastState.Bounded env1128 := by
  intro p hp
  have h : env1128.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1127_1128 : H12AffineEnvironment.transform 10 169 env1127 = env1128 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 169 env1127 == env1128) = true)

theorem identity1128 : scanCanonicalize (H12AffineFastState.compose env1128 (packedSelected [3,13] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1128 : packedSelected [3,13] rootPS < 2^1333 := by decide +kernel

def env1129 : List Nat := [2,4,8,16,32,16,128,5,136,1024,169,1045,9,1045,42,138,1044,163,1024,42,1045,136,16,160,128,17,42,1045,1045,11,1024,43,5,169,1044,137]

theorem envBound1129 : H12AffineFastState.Bounded env1129 := by
  intro p hp
  have h : env1129.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1128_1129 : H12AffineEnvironment.transform 7 5 env1128 = env1129 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1128 == env1129) = true)

theorem identity1129 : scanCanonicalize (H12AffineFastState.compose env1129 (packedSelected [0,2] rootPS)) = affineNative (2^(6+1) ^^^ 25) := by decide +kernel

theorem selectedBound1129 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env1130 : List Nat := [2,4,8,16,32,16,25,5,17,1024,48,1045,9,1045,42,19,1044,58,1024,42,1045,17,16,57,25,17,42,1045,1045,11,1024,43,5,48,1044,16]

theorem envBound1130 : H12AffineFastState.Bounded env1130 := by
  intro p hp
  have h : env1130.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1129_1130 : H12AffineEnvironment.transform 6 25 env1129 = env1130 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 25 env1129 == env1130) = true)

theorem identity1130 : scanCanonicalize (H12AffineFastState.compose env1130 (packedSelected [9] rootPS)) = affineNative (2^(4+1) ^^^ 27) := by decide +kernel

theorem selectedBound1130 : packedSelected [9] rootPS < 2^1333 := by decide +kernel

def env1131 : List Nat := [2,4,8,16,27,16,25,5,17,1024,11,1045,9,1045,17,19,1044,1,1024,17,1045,17,16,2,25,17,17,1045,1045,11,1024,16,5,11,1044,16]

theorem envBound1131 : H12AffineFastState.Bounded env1131 := by
  intro p hp
  have h : env1131.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1130_1131 : H12AffineEnvironment.transform 4 27 env1130 = env1131 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 27 env1130 == env1131) = true)

theorem identity1131 : scanCanonicalize (H12AffineFastState.compose env1131 (packedSelected [7] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound1131 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1132 : List Nat := [2,4,8,1,10,1,8,5,0,1024,11,1028,9,1028,0,2,1029,1,1024,0,1028,0,1,2,8,0,0,1028,1028,11,1024,1,5,11,1029,1]

theorem envBound1132 : H12AffineFastState.Bounded env1132 := by
  intro p hp
  have h : env1132.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1131_1132 : H12AffineEnvironment.transform 3 1 env1131 = env1132 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env1131 == env1132) = true)

def leafEnv1132 : List Nat := [2,4,8,1,10,1,8,5,0,1024,11,1028,9,1028,0,2,1029,1,1024,0,1028,0,1,2,1024,8,1,0,0,1028,1028,11,1024,1,5,11,4,3,1029,1,0,1028,1]

def active1132 : List Nat := [0,1,2,9]

def tree1132 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1132 : H12WitnessSearch.Good tree1132 := H12GlobalWitnessIndex.good

theorem leafIdentity1132 : H12AffineFastState.composeSystem env1132 rootObs = leafEnv1132 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1132 rootObs == leafEnv1132) = true)

theorem terminalChecked1132 : H12PackedTerminal.terminalCheckFast leafEnv1132 active1132 tree1132 = true := by decide +kernel

def env1133 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,16777216,16893077,16875796,21352449,16897045,4096,20978847,16876544,4294967296,256,4315938987,4097,16893084]

theorem envBound1133 : H12AffineFastState.Bounded env1133 := by
  intro p hp
  have h : env1133.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1118_1133 : H12AffineEnvironment.transform 8 137 env1118 = env1133 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1118 == env1133) = true)

theorem identity1133 : scanCanonicalize (H12AffineFastState.compose env1133 (packedSelected [6,25] rootPS)) = affineNative (2^(23+1) ^^^ 115732) := by decide +kernel

theorem selectedBound1133 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env1134 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,115732,129,17664,4461589,4097,4096,4315275,16404,4294967296,256,4299277503,4097,136]

theorem envBound1134 : H12AffineFastState.Bounded env1134 := by
  intro p hp
  have h : env1134.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1133_1134 : H12AffineEnvironment.transform 23 115732 env1133 = env1134 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 115732 env1133 == env1134) = true)

theorem identity1134 : scanCanonicalize (H12AffineFastState.compose env1134 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(13+1) ^^^ 4097) := by decide +kernel

theorem selectedBound1134 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env1135 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8,4097,32768,65536,4097,262144,1024,32768,4096,4194304,5377,103445,129,5377,4461589,4097,4096,4294794,4117,4294967296,256,4299265214,4097,136]

theorem envBound1135 : H12AffineFastState.Bounded env1135 := by
  intro p hp
  have h : env1135.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1134_1135 : H12AffineEnvironment.transform 13 4097 env1134 = env1135 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4097 env1134 == env1135) = true)

def env1136 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,16777216,33554432,17010964,21352448,17024021,131072,21105823,16876544,4294967296,256,4332975159,131072,33563272]

theorem envBound1136 : H12AffineFastState.Bounded env1136 := by
  intro p hp
  have h : env1136.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans983_1136 : H12AffineEnvironment.transform 5 17 env983 = env1136 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env983 == env1136) = true)

def env1137 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,16777216,33554432,17010964,21352448,17024021,131072,21105823,16876544,4294967296,256,4332967607,131072,33554440]

theorem envBound1137 : H12AffineFastState.Bounded env1137 := by
  intro p hp
  have h : env1137.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1136_1137 : H12AffineEnvironment.transform 12 640 env1136 = env1137 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 640 env1136 == env1137) = true)

def env1138 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,16384,32768,65536,4096,262144,1024,32768,4096,4194304,17664,16777216,33554432,16875796,21352448,16897045,4096,20978847,16876544,4294967296,256,4332832439,4096,33554440]

theorem envBound1138 : H12AffineFastState.Bounded env1138 := by
  intro p hp
  have h : env1138.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1137_1138 : H12AffineEnvironment.transform 16 4096 env1137 = env1138 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env1137 == env1138) = true)

theorem identity1138 : scanCanonicalize (H12AffineFastState.compose env1138 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(13+1) ^^^ 4745) := by decide +kernel

theorem selectedBound1138 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env1139 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,4745,32768,65536,4096,262144,1024,32768,4096,4194304,6025,16777216,33554432,16875796,21332617,16877212,4096,20978847,16876544,4294967296,256,4332819518,4096,33554440]

theorem envBound1139 : H12AffineFastState.Bounded env1139 := by
  intro p hp
  have h : env1139.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1138_1139 : H12AffineEnvironment.transform 13 4745 env1138 = env1139 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4745 env1138 == env1139) = true)

def env1140 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,4097,32768,65536,4096,262144,1024,32768,4096,4194304,5377,16777216,33554432,16875796,21331969,16876564,4096,20978847,16876544,4294967296,256,4332819518,4096,33554440]

theorem envBound1140 : H12AffineFastState.Bounded env1140 := by
  intro p hp
  have h : env1140.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1139_1140 : H12AffineEnvironment.transform 8 136 env1139 = env1140 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1139 == env1140) = true)

theorem identity1140 : scanCanonicalize (H12AffineFastState.compose env1140 (packedSelected [3,5,8,17,21,28] rootPS)) = affineNative (2^(23+1) ^^^ 138) := by decide +kernel

theorem selectedBound1140 : packedSelected [3,5,8,17,21,28] rootPS < 2^1333 := by decide +kernel

def env1141 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,4097,32768,65536,4096,262144,1024,32768,4096,4194304,5377,138,33554432,98718,4554891,99486,4096,4201493,99466,4294967296,256,4332819518,4096,33554440]

theorem envBound1141 : H12AffineFastState.Bounded env1141 := by
  intro p hp
  have h : env1141.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1140_1141 : H12AffineEnvironment.transform 23 138 env1140 = env1141 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 138 env1140 == env1141) = true)

theorem identity1141 : scanCanonicalize (H12AffineFastState.compose env1141 (packedSelected [1,5,6,8,10,17,19,21,24,25,26,31] rootPS)) = affineNative (2^(24+1) ^^^ 129) := by decide +kernel

theorem selectedBound1141 : packedSelected [1,5,6,8,10,17,19,21,24,25,26,31] rootPS < 2^1333 := by decide +kernel

def env1142 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,4097,32768,65536,4096,262144,1024,32768,4096,4194304,5377,138,129,98718,4554891,99486,4096,4201493,99466,4294967296,256,4299265215,4096,137]

theorem envBound1142 : H12AffineFastState.Bounded env1142 := by
  intro p hp
  have h : env1142.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1141_1142 : H12AffineEnvironment.transform 24 129 env1141 = env1142 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 129 env1141 == env1142) = true)

theorem identity1142 : scanCanonicalize (H12AffineFastState.compose env1142 (packedSelected [3,4,9,10,16,24,26] rootPS)) = affineNative (2^(15+1) ^^^ 38047) := by decide +kernel

theorem selectedBound1142 : packedSelected [3,4,9,10,16,24,26] rootPS < 2^1333 := by decide +kernel

def env1143 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,4097,32768,38047,4096,262144,1024,32768,4096,4194304,5377,138,129,5377,4461588,4097,4096,4201493,4117,4294967296,256,4299161632,4096,137]

theorem envBound1143 : H12AffineFastState.Bounded env1143 := by
  intro p hp
  have h : env1143.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1142_1143 : H12AffineEnvironment.transform 15 38047 env1142 = env1143 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 38047 env1142 == env1143) = true)

theorem identity1143 : scanCanonicalize (H12AffineFastState.compose env1143 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound1143 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env1144 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1296,8,1297,32768,33167,1296,262144,1024,32768,1296,4194304,17,138,129,17,4456708,1297,1296,4196613,1285,4294967296,256,4299161632,1296,137]

theorem envBound1144 : H12AffineFastState.Bounded env1144 := by
  intro p hp
  have h : env1144.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1143_1144 : H12AffineEnvironment.transform 11 1296 env1143 = env1144 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env1143 == env1144) = true)

theorem identity1144 : scanCanonicalize (H12AffineFastState.compose env1144 (packedSelected [1,3] rootPS)) = affineNative (2^(21+1) ^^^ 295309) := by decide +kernel

theorem selectedBound1144 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env1145 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1296,8,1297,32768,33167,1296,262144,1024,32768,1296,295309,17,138,129,17,32905,1297,1296,297096,1285,4294967296,256,4295262637,1296,137]

theorem envBound1145 : H12AffineFastState.Bounded env1145 := by
  intro p hp
  have h : env1145.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1144_1145 : H12AffineEnvironment.transform 21 295309 env1144 = env1145 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 295309 env1144 == env1145) = true)

theorem identity1145 : scanCanonicalize (H12AffineFastState.compose env1145 (packedSelected [5] rootPS)) = affineNative (2^(17+1) ^^^ 2080) := by decide +kernel

theorem selectedBound1145 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env1146 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1296,8,1297,32768,33167,1296,2080,1024,32768,1296,35245,17,138,129,17,32905,1297,1296,32936,1285,4294967296,256,4295002509,1296,137]

theorem envBound1146 : H12AffineFastState.Bounded env1146 := by
  intro p hp
  have h : env1146.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1145_1146 : H12AffineEnvironment.transform 17 2080 env1145 = env1146 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2080 env1145 == env1146) = true)

theorem identity1146 : scanCanonicalize (H12AffineFastState.compose env1146 (packedSelected [8] rootPS)) = affineNative (2^(14+1) ^^^ 1) := by decide +kernel

theorem selectedBound1146 : packedSelected [8] rootPS < 2^1333 := by decide +kernel

def env1147 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1296,8,1297,1,398,1296,2080,1024,1,1296,2476,17,138,129,17,136,1297,1296,169,1285,4294967296,256,4294969740,1296,137]

theorem envBound1147 : H12AffineFastState.Bounded env1147 := by
  intro p hp
  have h : env1147.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1146_1147 : H12AffineEnvironment.transform 14 1 env1146 = env1147 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 1 env1146 == env1147) = true)

theorem identity1147 : scanCanonicalize (H12AffineFastState.compose env1147 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 137) := by decide +kernel

theorem selectedBound1147 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1148 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1296,8,1297,1,398,1296,2080,1024,1,1296,2476,17,138,129,17,136,1297,1296,169,1285,137,256,2309,1296,137]

theorem envBound1148 : H12AffineFastState.Bounded env1148 := by
  intro p hp
  have h : env1148.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1147_1148 : H12AffineEnvironment.transform 31 137 env1147 = env1148 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 137 env1147 == env1148) = true)

theorem identity1148 : scanCanonicalize (H12AffineFastState.compose env1148 (packedSelected [10] rootPS)) = affineNative (2^(10+1) ^^^ 32) := by decide +kernel

theorem selectedBound1148 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env1149 : List Nat := [2,4,8,16,32,17,128,256,136,1024,32,1296,8,1297,1,398,1296,0,1024,1,1296,396,17,138,129,17,136,1297,1296,169,1285,137,256,293,1296,137]

theorem envBound1149 : H12AffineFastState.Bounded env1149 := by
  intro p hp
  have h : env1149.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1148_1149 : H12AffineEnvironment.transform 10 32 env1148 = env1149 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 32 env1148 == env1149) = true)

theorem identity1149 : scanCanonicalize (H12AffineFastState.compose env1149 (packedSelected [6] rootPS)) = affineNative (2^(7+1) ^^^ 47) := by decide +kernel

theorem selectedBound1149 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1150 : List Nat := [2,4,8,16,32,17,128,47,136,1024,32,1087,8,1086,1,161,1087,0,1024,1,1087,163,17,138,129,17,136,1086,1087,169,1066,137,47,10,1087,137]

theorem envBound1150 : H12AffineFastState.Bounded env1150 := by
  intro p hp
  have h : env1150.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1149_1150 : H12AffineEnvironment.transform 7 47 env1149 = env1150 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 47 env1149 == env1150) = true)

theorem identity1150 : scanCanonicalize (H12AffineFastState.compose env1150 (packedSelected [0,4,7] rootPS)) = affineNative (2^(4+1) ^^^ 17) := by decide +kernel

theorem selectedBound1150 : packedSelected [0,4,7] rootPS < 2^1333 := by decide +kernel

def env1151 : List Nat := [2,4,8,16,17,17,128,30,136,1024,17,1038,8,1039,1,144,1038,0,1024,1,1038,146,17,138,129,17,136,1039,1038,152,1051,137,30,10,1038,137]

theorem envBound1151 : H12AffineFastState.Bounded env1151 := by
  intro p hp
  have h : env1151.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1150_1151 : H12AffineEnvironment.transform 4 17 env1150 = env1151 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env1150 == env1151) = true)

theorem identity1151 : scanCanonicalize (H12AffineFastState.compose env1151 (packedSelected [12] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound1151 : packedSelected [12] rootPS < 2^1333 := by decide +kernel

def env1152 : List Nat := [2,4,8,16,17,17,9,30,1,1024,17,1038,8,1039,1,25,1038,0,1024,1,1038,27,17,3,8,17,1,1039,1038,17,1051,0,30,10,1038,0]

theorem envBound1152 : H12AffineFastState.Bounded env1152 := by
  intro p hp
  have h : env1152.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1151_1152 : H12AffineEnvironment.transform 6 9 env1151 = env1152 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env1151 == env1152) = true)

theorem identity1152 : scanCanonicalize (H12AffineFastState.compose env1152 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound1152 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1153 : List Nat := [2,4,8,11,10,10,9,5,1,1024,10,1038,8,1039,1,2,1038,0,1024,1,1038,0,10,3,8,10,1,1039,1038,10,1024,0,5,10,1038,0]

theorem envBound1153 : H12AffineFastState.Bounded env1153 := by
  intro p hp
  have h : env1153.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1152_1153 : H12AffineEnvironment.transform 3 11 env1152 = env1153 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env1152 == env1153) = true)

def leafEnv1153 : List Nat := [2,4,8,11,10,10,9,5,1,1024,10,1038,8,1039,1,2,1038,0,1024,1,1038,0,10,3,1024,8,1,10,1,1039,1038,10,1024,0,5,10,4,2,1038,0,0,1038,1]

def active1153 : List Nat := [0,1,2,9]

def tree1153 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1153 : H12WitnessSearch.Good tree1153 := H12GlobalWitnessIndex.good

theorem leafIdentity1153 : H12AffineFastState.composeSystem env1153 rootObs = leafEnv1153 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1153 rootObs == leafEnv1153) = true)

theorem terminalChecked1153 : H12PackedTerminal.terminalCheckFast leafEnv1153 active1153 tree1153 = true := by decide +kernel

def env1154 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,4096,32768,65536,4096,262144,1024,32768,4096,4194304,5376,16777216,33554432,16875796,21331968,16876565,4096,20978847,16876544,4294967296,256,4332819518,4096,33554440]

theorem envBound1154 : H12AffineFastState.Bounded env1154 := by
  intro p hp
  have h : env1154.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1139_1154 : H12AffineEnvironment.transform 8 137 env1139 = env1154 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1139 == env1154) = true)

def env1155 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,4096,32768,65536,4096,262144,1024,32768,4096,65544,5376,16777216,33554432,16875796,17072136,16876565,4096,16850071,16876544,4294967296,256,4328559670,4096,33554440]

theorem envBound1155 : H12AffineFastState.Bounded env1155 := by
  intro p hp
  have h : env1155.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1154_1155 : H12AffineEnvironment.transform 21 65544 env1154 = env1155 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 65544 env1154 == env1155) = true)

def env1156 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,9,1296,32768,65536,1296,262144,1024,32768,1296,65544,16,16777216,33554432,16875796,17072136,16876565,1296,16845191,16876544,4294967296,256,4328554790,1296,33554440]

theorem envBound1156 : H12AffineFastState.Bounded env1156 := by
  intro p hp
  have h : env1156.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1155_1156 : H12AffineEnvironment.transform 11 1296 env1155 = env1156 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env1155 == env1156) = true)

theorem identity1156 : scanCanonicalize (H12AffineFastState.compose env1156 (packedSelected [1,3,5,6,8,10,19,25] rootPS)) = affineNative (2^(24+1) ^^^ 16875909) := by decide +kernel

theorem selectedBound1156 : packedSelected [1,3,5,6,8,10,19,25] rootPS < 2^1333 := by decide +kernel

def env1157 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,9,1296,32768,65536,1296,262144,1024,32768,1296,65544,16,16777216,16875909,16875796,17072136,16876565,1296,16845191,16876544,4294967296,256,4311810211,1296,16875917]

theorem envBound1157 : H12AffineFastState.Bounded env1157 := by
  intro p hp
  have h : env1157.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1156_1157 : H12AffineEnvironment.transform 24 16875909 env1156 = env1157 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 16875909 env1156 == env1157) = true)

theorem identity1157 : scanCanonicalize (H12AffineFastState.compose env1157 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(23+1) ^^^ 98565) := by decide +kernel

theorem selectedBound1157 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env1158 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,9,1296,32768,65536,1296,262144,1024,32768,1296,65544,16,98565,128,17,327949,1296,1296,34946,1285,4294967296,256,4295000486,1296,136]

theorem envBound1158 : H12AffineFastState.Bounded env1158 := by
  intro p hp
  have h : env1158.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1157_1158 : H12AffineEnvironment.transform 23 98565 env1157 = env1158 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98565 env1157 == env1158) = true)

def env1159 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,1297,32768,65536,1297,262144,1024,32768,1297,65544,17,16777216,33554432,16875796,17072136,16876565,1297,16845190,16876544,4294967296,256,4328554791,1297,33554440]

theorem envBound1159 : H12AffineFastState.Bounded env1159 := by
  intro p hp
  have h : env1159.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1155_1159 : H12AffineEnvironment.transform 11 1297 env1155 = env1159 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env1155 == env1159) = true)

theorem identity1159 : scanCanonicalize (H12AffineFastState.compose env1159 (packedSelected [3,5,24] rootPS)) = affineNative (2^(24+1) ^^^ 8) := by decide +kernel

theorem selectedBound1159 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env1160 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,1297,32768,65536,1297,262144,1024,32768,1297,65544,17,16777216,8,16875796,17072136,16876565,1297,16845190,16876544,4294967296,256,4295000367,1297,0]

theorem envBound1160 : H12AffineFastState.Bounded env1160 := by
  intro p hp
  have h : env1160.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1159_1160 : H12AffineEnvironment.transform 24 8 env1159 = env1160 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8 env1159 == env1160) = true)

theorem identity1160 : scanCanonicalize (H12AffineFastState.compose env1160 (packedSelected [10,12,21] rootPS)) = affineNative (2^(15+1) ^^^ 3) := by decide +kernel

theorem selectedBound1160 : packedSelected [10,12,21] rootPS < 2^1333 := by decide +kernel

def env1161 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,1297,32768,3,1297,262144,1024,32768,1297,11,17,16777216,8,16810263,17072136,16811030,1297,16779653,16811011,4294967296,256,4295000367,1297,0]

theorem envBound1161 : H12AffineFastState.Bounded env1161 := by
  intro p hp
  have h : env1161.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1160_1161 : H12AffineEnvironment.transform 15 3 env1160 = env1161 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 3 env1160 == env1161) = true)

theorem identity1161 : scanCanonicalize (H12AffineFastState.compose env1161 (packedSelected [1,3,5,6,8,10,19,25] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound1161 : packedSelected [1,3,5,6,8,10,19,25] rootPS < 2^1333 := by decide +kernel

def env1162 : List Nat := [2,4,8,16,32,17,8,256,1,1024,2048,1297,9,1297,32768,3,1297,262144,1024,32768,1297,11,17,16777216,8,16810263,17072136,16811030,1297,16779533,16811011,4294967296,256,4295000367,1297,0]

theorem envBound1162 : H12AffineFastState.Bounded env1162 := by
  intro p hp
  have h : env1162.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1161_1162 : H12AffineEnvironment.transform 6 8 env1161 = env1162 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env1161 == env1162) = true)

theorem identity1162 : scanCanonicalize (H12AffineFastState.compose env1162 (packedSelected [3,5,8,13,15] rootPS)) = affineNative (2^(17+1) ^^^ 34827) := by decide +kernel

theorem selectedBound1162 : packedSelected [3,5,8,13,15] rootPS < 2^1333 := by decide +kernel

def env1163 : List Nat := [2,4,8,16,32,17,8,256,1,1024,2048,1297,9,1297,32768,3,1297,34827,1024,32768,1297,11,17,16777216,8,16810263,16779267,16811030,1297,16779533,16811011,4294967296,256,4295000367,1297,0]

theorem envBound1163 : H12AffineFastState.Bounded env1163 := by
  intro p hp
  have h : env1163.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1162_1163 : H12AffineEnvironment.transform 17 34827 env1162 = env1163 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 34827 env1162 == env1163) = true)

theorem identity1163 : scanCanonicalize (H12AffineFastState.compose env1163 (packedSelected [0,7,20] rootPS)) = affineNative (2^(23+1) ^^^ 33031) := by decide +kernel

theorem selectedBound1163 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env1164 : List Nat := [2,4,8,16,32,17,8,256,1,1024,2048,1297,9,1297,32768,3,1297,34827,1024,32768,1297,11,17,33031,8,16,35076,1297,1297,34826,1284,4294967296,256,4295000367,1297,0]

theorem envBound1164 : H12AffineFastState.Bounded env1164 := by
  intro p hp
  have h : env1164.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1163_1164 : H12AffineEnvironment.transform 23 33031 env1163 = env1164 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 33031 env1163 == env1164) = true)

theorem identity1164 : scanCanonicalize (H12AffineFastState.compose env1164 (packedSelected [1,3,5] rootPS)) = affineNative (2^(14+1) ^^^ 260) := by decide +kernel

theorem selectedBound1164 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1165 : List Nat := [2,4,8,16,32,17,8,256,1,1024,2048,1297,9,1297,260,3,1297,2319,1024,260,1297,11,17,3,8,16,2048,1297,1297,2318,1284,4294967296,256,4294967339,1297,0]

theorem envBound1165 : H12AffineFastState.Bounded env1165 := by
  intro p hp
  have h : env1165.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1164_1165 : H12AffineEnvironment.transform 14 260 env1164 = env1165 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 260 env1164 == env1165) = true)

theorem identity1165 : scanCanonicalize (H12AffineFastState.compose env1165 (packedSelected [1,3] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound1165 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env1166 : List Nat := [2,4,8,16,11,17,8,256,1,1024,2048,1297,9,1297,260,3,1297,2319,1024,260,1297,11,17,3,8,16,2048,1297,1297,2318,1284,4294967296,256,4294967296,1297,0]

theorem envBound1166 : H12AffineFastState.Bounded env1166 := by
  intro p hp
  have h : env1166.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1165_1166 : H12AffineEnvironment.transform 4 11 env1165 = env1166 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env1165 == env1166) = true)

theorem identity1166 : scanCanonicalize (H12AffineFastState.compose env1166 (packedSelected [1] rootPS)) = affineNative (2^(9+1) ^^^ 5) := by decide +kernel

theorem selectedBound1166 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1167 : List Nat := [2,4,8,16,11,17,8,256,1,5,2048,276,9,276,260,3,276,2319,5,260,276,11,17,3,8,16,2048,276,276,2318,257,4294967296,256,4294967296,276,0]

theorem envBound1167 : H12AffineFastState.Bounded env1167 := by
  intro p hp
  have h : env1167.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1166_1167 : H12AffineEnvironment.transform 9 5 env1166 = env1167 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 5 env1166 == env1167) = true)

theorem identity1167 : scanCanonicalize (H12AffineFastState.compose env1167 (packedSelected [2] rootPS)) = affineNative (2^(31+1) ^^^ 2058) := by decide +kernel

theorem selectedBound1167 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1168 : List Nat := [2,4,8,16,11,17,8,256,1,5,2048,276,9,276,260,3,276,2319,5,260,276,11,17,3,8,16,2048,276,276,2318,257,2058,256,2058,276,0]

theorem envBound1168 : H12AffineFastState.Bounded env1168 := by
  intro p hp
  have h : env1168.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1167_1168 : H12AffineEnvironment.transform 31 2058 env1167 = env1168 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 2058 env1167 == env1168) = true)

theorem identity1168 : scanCanonicalize (H12AffineFastState.compose env1168 (packedSelected [0,4] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound1168 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env1169 : List Nat := [2,4,3,16,0,17,3,256,1,5,2048,276,2,276,260,3,276,2308,5,260,276,0,17,3,3,16,2048,276,276,2309,257,2049,256,2049,276,0]

theorem envBound1169 : H12AffineFastState.Bounded env1169 := by
  intro p hp
  have h : env1169.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1168_1169 : H12AffineEnvironment.transform 2 3 env1168 = env1169 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env1168 == env1169) = true)

theorem identity1169 : scanCanonicalize (H12AffineFastState.compose env1169 (packedSelected [6] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1169 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1170 : List Nat := [2,4,3,16,0,17,3,5,1,5,2048,17,2,17,1,3,17,2049,5,1,17,0,17,3,3,16,2048,17,17,2048,4,2049,5,2049,17,0]

theorem envBound1170 : H12AffineFastState.Bounded env1170 := by
  intro p hp
  have h : env1170.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1169_1170 : H12AffineEnvironment.transform 7 5 env1169 = env1170 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1169 == env1170) = true)

theorem identity1170 : scanCanonicalize (H12AffineFastState.compose env1170 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1170 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1171 : List Nat := [2,4,3,0,0,1,3,5,1,5,2048,1,2,1,1,3,1,2049,5,1,1,0,1,3,3,0,2048,1,1,2048,4,2049,5,2049,1,0]

theorem envBound1171 : H12AffineFastState.Bounded env1171 := by
  intro p hp
  have h : env1171.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1170_1171 : H12AffineEnvironment.transform 3 0 env1170 = env1171 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1170 == env1171) = true)

theorem identity1171 : scanCanonicalize (H12AffineFastState.compose env1171 (packedSelected [7] rootPS)) = affineNative (2^(10+1) ^^^ 1) := by decide +kernel

theorem selectedBound1171 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1172 : List Nat := [2,4,3,0,0,1,3,5,1,5,1,1,2,1,1,3,1,0,5,1,1,0,1,3,3,0,1,1,1,1,4,0,5,0,1,0]

theorem envBound1172 : H12AffineFastState.Bounded env1172 := by
  intro p hp
  have h : env1172.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1171_1172 : H12AffineEnvironment.transform 10 1 env1171 = env1172 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env1171 == env1172) = true)

def env1173 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,9,4096,32768,65536,4096,262144,1024,32768,4096,65545,5376,16777216,33554432,16875796,17072137,16876565,4096,16850070,16876544,4294967296,256,4328559671,4096,33554440]

theorem envBound1173 : H12AffineFastState.Bounded env1173 := by
  intro p hp
  have h : env1173.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1154_1173 : H12AffineEnvironment.transform 21 65545 env1154 = env1173 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 65545 env1154 == env1173) = true)

def env1174 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,9,1296,32768,65536,1296,262144,1024,32768,1296,65545,16,16777216,33554432,16875796,17072137,16876565,1296,16845190,16876544,4294967296,256,4328554791,1296,33554440]

theorem envBound1174 : H12AffineFastState.Bounded env1174 := by
  intro p hp
  have h : env1174.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1173_1174 : H12AffineEnvironment.transform 11 1296 env1173 = env1174 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env1173 == env1174) = true)

theorem identity1174 : scanCanonicalize (H12AffineFastState.compose env1174 (packedSelected [3,5,24] rootPS)) = affineNative (2^(23+1) ^^^ 98565) := by decide +kernel

theorem selectedBound1174 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env1175 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,9,1296,32768,65536,1296,262144,1024,32768,1296,65545,16,98565,33554432,17,327948,1296,1296,34947,1285,4294967296,256,4328554791,1296,33554440]

theorem envBound1175 : H12AffineFastState.Bounded env1175 := by
  intro p hp
  have h : env1175.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1174_1175 : H12AffineEnvironment.transform 23 98565 env1174 = env1175 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98565 env1174 == env1175) = true)

def env1176 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,1297,32768,65536,1297,262144,1024,32768,1297,65545,17,16777216,33554432,16875796,17072137,16876565,1297,16845191,16876544,4294967296,256,4328554790,1297,33554440]

theorem envBound1176 : H12AffineFastState.Bounded env1176 := by
  intro p hp
  have h : env1176.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1173_1176 : H12AffineEnvironment.transform 11 1297 env1173 = env1176 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env1173 == env1176) = true)

theorem identity1176 : scanCanonicalize (H12AffineFastState.compose env1176 (packedSelected [3,5,24] rootPS)) = affineNative (2^(24+1) ^^^ 16875789) := by decide +kernel

theorem selectedBound1176 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env1177 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,1297,32768,65536,1297,262144,1024,32768,1297,65545,17,16777216,16875789,16875796,17072137,16876565,1297,16845191,16876544,4294967296,256,4311810091,1297,16875781]

theorem envBound1177 : H12AffineFastState.Bounded env1177 := by
  intro p hp
  have h : env1177.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1176_1177 : H12AffineEnvironment.transform 24 16875789 env1176 = env1177 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 16875789 env1176 == env1177) = true)

theorem identity1177 : scanCanonicalize (H12AffineFastState.compose env1177 (packedSelected [10,12,21] rootPS)) = affineNative (2^(23+1) ^^^ 33030) := by decide +kernel

theorem selectedBound1177 : packedSelected [10,12,21] rootPS < 2^1333 := by decide +kernel

def env1178 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,1297,32768,65536,1297,262144,1024,32768,1297,65545,17,33030,65547,65554,262415,66835,1297,100481,66822,4294967296,256,4295065901,1297,65539]

theorem envBound1178 : H12AffineFastState.Bounded env1178 := by
  intro p hp
  have h : env1178.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1177_1178 : H12AffineEnvironment.transform 23 33030 env1177 = env1178 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 33030 env1177 == env1178) = true)

theorem identity1178 : scanCanonicalize (H12AffineFastState.compose env1178 (packedSelected [1,3,5,6,8,10,19,25] rootPS)) = affineNative (2^(15+1) ^^^ 139) := by decide +kernel

theorem selectedBound1178 : packedSelected [1,3,5,6,8,10,19,25] rootPS < 2^1333 := by decide +kernel

def env1179 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,1297,32768,139,1297,262144,1024,32768,1297,130,17,33030,128,153,262415,1432,1297,34826,1421,4294967296,256,4295000486,1297,136]

theorem envBound1179 : H12AffineFastState.Bounded env1179 := by
  intro p hp
  have h : env1179.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1178_1179 : H12AffineEnvironment.transform 15 139 env1178 = env1179 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 139 env1178 == env1179) = true)

theorem identity1179 : scanCanonicalize (H12AffineFastState.compose env1179 (packedSelected [3,5,8,13,15] rootPS)) = affineNative (2^(17+1) ^^^ 34946) := by decide +kernel

theorem selectedBound1179 : packedSelected [3,5,8,13,15] rootPS < 2^1333 := by decide +kernel

def env1180 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,9,1297,32768,139,1297,34946,1024,32768,1297,130,17,33030,128,153,35213,1432,1297,34826,1421,4294967296,256,4295000486,1297,136]

theorem envBound1180 : H12AffineFastState.Bounded env1180 := by
  intro p hp
  have h : env1180.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1179_1180 : H12AffineEnvironment.transform 17 34946 env1179 = env1180 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 34946 env1179 == env1180) = true)

theorem identity1180 : scanCanonicalize (H12AffineFastState.compose env1180 (packedSelected [0,7,20] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound1180 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env1181 : List Nat := [2,4,8,16,32,17,9,256,0,1024,2048,1297,9,1297,32768,2,1297,34827,1024,32768,1297,11,17,33030,9,16,35076,1297,1297,34826,1284,4294967296,256,4295000367,1297,1]

theorem envBound1181 : H12AffineFastState.Bounded env1181 := by
  intro p hp
  have h : env1181.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1180_1181 : H12AffineEnvironment.transform 6 9 env1180 = env1181 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env1180 == env1181) = true)

theorem identity1181 : scanCanonicalize (H12AffineFastState.compose env1181 (packedSelected [1,3,5] rootPS)) = affineNative (2^(14+1) ^^^ 260) := by decide +kernel

theorem selectedBound1181 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1182 : List Nat := [2,4,8,16,32,17,9,256,0,1024,2048,1297,9,1297,260,2,1297,2319,1024,260,1297,11,17,2,9,16,2048,1297,1297,2318,1284,4294967296,256,4294967339,1297,1]

theorem envBound1182 : H12AffineFastState.Bounded env1182 := by
  intro p hp
  have h : env1182.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1181_1182 : H12AffineEnvironment.transform 14 260 env1181 = env1182 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 260 env1181 == env1182) = true)

theorem identity1182 : scanCanonicalize (H12AffineFastState.compose env1182 (packedSelected [1,3] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound1182 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env1183 : List Nat := [2,4,8,16,11,17,9,256,0,1024,2048,1297,9,1297,260,2,1297,2319,1024,260,1297,11,17,2,9,16,2048,1297,1297,2318,1284,4294967296,256,4294967296,1297,1]

theorem envBound1183 : H12AffineFastState.Bounded env1183 := by
  intro p hp
  have h : env1183.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1182_1183 : H12AffineEnvironment.transform 4 11 env1182 = env1183 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env1182 == env1183) = true)

theorem identity1183 : scanCanonicalize (H12AffineFastState.compose env1183 (packedSelected [1] rootPS)) = affineNative (2^(9+1) ^^^ 5) := by decide +kernel

theorem selectedBound1183 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1184 : List Nat := [2,4,8,16,11,17,9,256,0,5,2048,276,9,276,260,2,276,2319,5,260,276,11,17,2,9,16,2048,276,276,2318,257,4294967296,256,4294967296,276,1]

theorem envBound1184 : H12AffineFastState.Bounded env1184 := by
  intro p hp
  have h : env1184.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1183_1184 : H12AffineEnvironment.transform 9 5 env1183 = env1184 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 5 env1183 == env1184) = true)

theorem identity1184 : scanCanonicalize (H12AffineFastState.compose env1184 (packedSelected [2] rootPS)) = affineNative (2^(31+1) ^^^ 2058) := by decide +kernel

theorem selectedBound1184 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1185 : List Nat := [2,4,8,16,11,17,9,256,0,5,2048,276,9,276,260,2,276,2319,5,260,276,11,17,2,9,16,2048,276,276,2318,257,2058,256,2058,276,1]

theorem envBound1185 : H12AffineFastState.Bounded env1185 := by
  intro p hp
  have h : env1185.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1184_1185 : H12AffineEnvironment.transform 31 2058 env1184 = env1185 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 2058 env1184 == env1185) = true)

theorem identity1185 : scanCanonicalize (H12AffineFastState.compose env1185 (packedSelected [0,4] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound1185 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env1186 : List Nat := [2,4,3,16,0,17,2,256,0,5,2048,276,2,276,260,2,276,2308,5,260,276,0,17,2,2,16,2048,276,276,2309,257,2049,256,2049,276,1]

theorem envBound1186 : H12AffineFastState.Bounded env1186 := by
  intro p hp
  have h : env1186.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1185_1186 : H12AffineEnvironment.transform 2 3 env1185 = env1186 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env1185 == env1186) = true)

theorem identity1186 : scanCanonicalize (H12AffineFastState.compose env1186 (packedSelected [6] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1186 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env1187 : List Nat := [2,4,3,16,0,17,2,5,0,5,2048,17,2,17,1,2,17,2049,5,1,17,0,17,2,2,16,2048,17,17,2048,4,2049,5,2049,17,1]

theorem envBound1187 : H12AffineFastState.Bounded env1187 := by
  intro p hp
  have h : env1187.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1186_1187 : H12AffineEnvironment.transform 7 5 env1186 = env1187 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1186 == env1187) = true)

theorem identity1187 : scanCanonicalize (H12AffineFastState.compose env1187 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound1187 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1188 : List Nat := [2,4,3,0,0,1,2,5,0,5,2048,1,2,1,1,2,1,2049,5,1,1,0,1,2,2,0,2048,1,1,2048,4,2049,5,2049,1,1]

theorem envBound1188 : H12AffineFastState.Bounded env1188 := by
  intro p hp
  have h : env1188.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1187_1188 : H12AffineEnvironment.transform 3 0 env1187 = env1188 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env1187 == env1188) = true)

theorem identity1188 : scanCanonicalize (H12AffineFastState.compose env1188 (packedSelected [7] rootPS)) = affineNative (2^(10+1) ^^^ 1) := by decide +kernel

theorem selectedBound1188 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env1189 : List Nat := [2,4,3,0,0,1,2,5,0,5,1,1,2,1,1,2,1,0,5,1,1,0,1,2,2,0,1,1,1,1,4,0,5,0,1,1]

theorem envBound1189 : H12AffineFastState.Bounded env1189 := by
  intro p hp
  have h : env1189.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1188_1189 : H12AffineEnvironment.transform 10 1 env1188 = env1189 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env1188 == env1189) = true)

def env1190 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,16384,32768,65536,4097,262144,1024,32768,4096,4194304,17664,16777216,33554432,16875797,21352448,16897044,4097,20978846,16876544,4294967296,256,4332832438,4097,33554440]

theorem envBound1190 : H12AffineFastState.Bounded env1190 := by
  intro p hp
  have h : env1190.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1137_1190 : H12AffineEnvironment.transform 16 4097 env1137 = env1190 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env1137 == env1190) = true)

theorem identity1190 : scanCanonicalize (H12AffineFastState.compose env1190 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(13+1) ^^^ 1944) := by decide +kernel

theorem selectedBound1190 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env1191 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,640,1944,32768,65536,4097,262144,1024,32768,4096,4194304,664,16777216,33554432,16875797,21338008,16880524,4097,20978846,16876544,4294967296,256,4332814638,4097,33554440]

theorem envBound1191 : H12AffineFastState.Bounded env1191 := by
  intro p hp
  have h : env1191.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1190_1191 : H12AffineEnvironment.transform 13 1944 env1190 = env1191 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1944 env1190 == env1191) = true)

def env1192 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,1296,32768,65536,4097,262144,1024,32768,4096,4194304,16,16777216,33554432,16875797,21337360,16879876,4097,20978846,16876544,4294967296,256,4332814638,4097,33554440]

theorem envBound1192 : H12AffineFastState.Bounded env1192 := by
  intro p hp
  have h : env1192.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1191_1192 : H12AffineEnvironment.transform 8 136 env1191 = env1192 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1191 == env1192) = true)

theorem identity1192 : scanCanonicalize (H12AffineFastState.compose env1192 (packedSelected [3,6,10,24,25,26] rootPS)) = affineNative (2^(24+1) ^^^ 16880789) := by decide +kernel

theorem selectedBound1192 : packedSelected [3,6,10,24,25,26] rootPS < 2^1333 := by decide +kernel

def env1193 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,4096,8,1296,32768,65536,4097,262144,1024,32768,4096,4194304,16,16777216,16880789,16875797,21337360,16879876,4097,20978846,16876544,4294967296,256,4315944379,4097,16880797]

theorem envBound1193 : H12AffineFastState.Bounded env1193 := by
  intro p hp
  have h : env1193.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1192_1193 : H12AffineEnvironment.transform 24 16880789 env1192 = env1193 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 16880789 env1192 == env1193) = true)

theorem identity1193 : scanCanonicalize (H12AffineFastState.compose env1193 (packedSelected [3,5,6,8,10,25,28,31] rootPS)) = affineNative (2^(23+1) ^^^ 103444) := by decide +kernel

theorem selectedBound1193 : packedSelected [3,5,6,8,10,25,28,31] rootPS < 2^1333 := by decide +kernel

end H12GlobalChart2
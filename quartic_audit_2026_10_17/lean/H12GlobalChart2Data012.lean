import H12GlobalChart2Data011

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

def env2910 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,131072,262144,524288,8832,2097152,8201,17665,206533,33554432,5376,2515997,16384,131153,2228953,131141,4294967296,256,4329271999,131072,33563272]

theorem envBound2910 : H12AffineFastState.Bounded env2910 := by
  intro p hp
  have h : env2910.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2909_2910 : H12AffineEnvironment.transform 29 2228953 env2909 = env2910 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 2228953 env2909 == env2910) = true)

def env2911 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,131072,0,524288,8832,2097152,8201,17665,206533,33554432,5376,2253853,16384,131153,2228953,131141,4294967296,256,4329271999,131072,33563272]

theorem envBound2911 : H12AffineFastState.Bounded env2911 := by
  intro p hp
  have h : env2911.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2910_2911 : H12AffineEnvironment.transform 17 0 env2910 = env2911 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env2910 == env2911) = true)

def env2912 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1344,0,524288,8832,2097152,8201,17665,74629,33554432,5376,2122077,16384,1297,2099097,1285,4294967296,256,4329142271,1344,33563272]

theorem envBound2912 : H12AffineFastState.Bounded env2912 := by
  intro p hp
  have h : env2912.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2911_2912 : H12AffineEnvironment.transform 16 1344 env2911 = env2912 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env2911 == env2912) = true)

theorem identity2912 : scanCanonicalize (H12AffineFastState.compose env2912 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound2912 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env2913 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1344,0,524288,8832,4096,8201,17665,74629,33554432,5376,29021,16384,1297,6041,1285,4294967296,256,4329142271,1344,33563272]

theorem envBound2913 : H12AffineFastState.Bounded env2913 := by
  intro p hp
  have h : env2913.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2912_2913 : H12AffineEnvironment.transform 20 4096 env2912 = env2913 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env2912 == env2913) = true)

theorem identity2913 : scanCanonicalize (H12AffineFastState.compose env2913 (packedSelected [20] rootPS)) = affineNative (2^(13+1) ^^^ 13300) := by decide +kernel

theorem selectedBound2913 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env2914 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,13300,8832,65536,1344,0,524288,8832,4096,8201,14069,74629,33554432,5376,681,13300,1297,6041,1285,4294967296,256,4329112587,1344,33563272]

theorem envBound2914 : H12AffineFastState.Bounded env2914 := by
  intro p hp
  have h : env2914.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2913_2914 : H12AffineEnvironment.transform 13 13300 env2913 = env2914 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 13300 env2913 == env2914) = true)

theorem identity2914 : scanCanonicalize (H12AffineFastState.compose env2914 (packedSelected [5,8,12,13,15,17,24,28] rootPS)) = affineNative (2^(11+1) ^^^ 1328) := by decide +kernel

theorem selectedBound2914 : packedSelected [5,8,12,13,15,17,24,28] rootPS < 2^1333 := by decide +kernel

def env2915 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1328,8192,9924,8832,65536,1344,0,524288,8832,1328,8201,9157,74629,33554432,48,681,9924,1297,681,1285,4294967296,256,4329112587,1344,33563272]

theorem envBound2915 : H12AffineFastState.Bounded env2915 := by
  intro p hp
  have h : env2915.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2914_2915 : H12AffineEnvironment.transform 11 1328 env2914 = env2915 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1328 env2914 == env2915) = true)

theorem identity2915 : scanCanonicalize (H12AffineFastState.compose env2915 (packedSelected [0,9,22,23,27] rootPS)) = affineNative (2^(12+1) ^^^ 268) := by decide +kernel

theorem selectedBound2915 : packedSelected [0,9,22,23,27] rootPS < 2^1333 := by decide +kernel

def env2916 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1328,268,1992,908,65536,1344,0,524288,908,1328,261,713,66185,33554432,48,681,1992,1297,681,1285,4294967296,256,4329112587,1344,33555332]

theorem envBound2916 : H12AffineFastState.Bounded env2916 := by
  intro p hp
  have h : env2916.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2915_2916 : H12AffineEnvironment.transform 12 268 env2915 = env2916 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 268 env2915 == env2916) = true)

theorem identity2916 : scanCanonicalize (H12AffineFastState.compose env2916 (packedSelected [9,18,22,23] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound2916 : packedSelected [9,18,22,23] rootPS < 2^1333 := by decide +kernel

def env2917 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1328,268,1345,261,65536,1344,0,524288,261,1328,261,64,65536,33554432,48,32,1345,1297,32,1285,4294967296,256,4329112587,1344,33554701]

theorem envBound2917 : H12AffineFastState.Bounded env2917 := by
  intro p hp
  have h : env2917.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2916_2917 : H12AffineEnvironment.transform 8 137 env2916 = env2917 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env2916 == env2917) = true)

theorem identity2917 : scanCanonicalize (H12AffineFastState.compose env2917 (packedSelected [3,8,12,15,17] rootPS)) = affineNative (2^(18+1) ^^^ 66698) := by decide +kernel

theorem selectedBound2917 : packedSelected [3,8,12,15,17] rootPS < 2^1333 := by decide +kernel

def env2918 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1328,268,1345,261,65536,1344,0,66698,261,1328,261,64,65536,33554432,48,32,1345,1297,32,1285,4294967296,256,4328521857,1344,33554701]

theorem envBound2918 : H12AffineFastState.Bounded env2918 := by
  intro p hp
  have h : env2918.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2917_2918 : H12AffineEnvironment.transform 18 66698 env2917 = env2918 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 66698 env2917 == env2918) = true)

theorem identity2918 : scanCanonicalize (H12AffineFastState.compose env2918 (packedSelected [5,8,16] rootPS)) = affineNative (2^(24+1) ^^^ 389) := by decide +kernel

theorem selectedBound2918 : packedSelected [5,8,16] rootPS < 2^1333 := by decide +kernel

def env2919 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1328,268,1345,261,65536,1344,0,66698,261,1328,261,64,65536,389,48,32,1345,1297,32,1285,4294967296,256,4294967556,1344,136]

theorem envBound2919 : H12AffineFastState.Bounded env2919 := by
  intro p hp
  have h : env2919.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2918_2919 : H12AffineEnvironment.transform 24 389 env2918 = env2919 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 389 env2918 == env2919) = true)

theorem identity2919 : scanCanonicalize (H12AffineFastState.compose env2919 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound2919 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env2920 : List Nat := [2,4,8,16,1,64,128,256,137,1024,1,1297,268,1345,261,65536,1344,0,66698,261,1297,261,64,65536,389,17,1,1345,1297,1,1285,4294967296,256,4294967556,1344,136]

theorem envBound2920 : H12AffineFastState.Bounded env2920 := by
  intro p hp
  have h : env2920.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2919_2920 : H12AffineEnvironment.transform 4 1 env2919 = env2920 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env2919 == env2920) = true)

theorem identity2920 : scanCanonicalize (H12AffineFastState.compose env2920 (packedSelected [1,3,5] rootPS)) = affineNative (2^(7+1) ^^^ 220) := by decide +kernel

theorem selectedBound2920 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env2921 : List Nat := [2,4,8,16,1,64,128,220,137,1024,1,1229,208,1181,217,65536,1180,0,66698,217,1229,217,64,65536,89,17,1,1181,1229,1,1241,4294967296,220,4294967512,1180,136]

theorem envBound2921 : H12AffineFastState.Bounded env2921 := by
  intro p hp
  have h : env2921.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2920_2921 : H12AffineEnvironment.transform 7 220 env2920 = env2921 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 220 env2920 == env2921) = true)

theorem identity2921 : scanCanonicalize (H12AffineFastState.compose env2921 (packedSelected [1,2,3,4] rootPS)) = affineNative (2^(15+1) ^^^ 139) := by decide +kernel

theorem selectedBound2921 : packedSelected [1,2,3,4] rootPS < 2^1333 := by decide +kernel

def env2922 : List Nat := [2,4,8,16,1,64,128,220,137,1024,1,1229,208,1181,217,139,1180,0,1025,217,1229,217,64,139,89,17,1,1181,1229,1,1241,4294967296,220,4294967512,1180,136]

theorem envBound2922 : H12AffineFastState.Bounded env2922 := by
  intro p hp
  have h : env2922.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2921_2922 : H12AffineEnvironment.transform 15 139 env2921 = env2922 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 139 env2921 == env2922) = true)

theorem identity2922 : scanCanonicalize (H12AffineFastState.compose env2922 (packedSelected [0,1] rootPS)) = affineNative (2^(5+1) ^^^ 0) := by decide +kernel

theorem selectedBound2922 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env2923 : List Nat := [2,4,8,16,1,0,128,156,137,1024,1,1165,144,1181,153,139,1180,0,1025,153,1165,153,0,139,25,17,1,1181,1165,1,1177,4294967296,156,4294967448,1180,136]

theorem envBound2923 : H12AffineFastState.Bounded env2923 := by
  intro p hp
  have h : env2923.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2922_2923 : H12AffineEnvironment.transform 5 0 env2922 = env2923 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env2922 == env2923) = true)

theorem identity2923 : scanCanonicalize (H12AffineFastState.compose env2923 (packedSelected [0,3] rootPS)) = affineNative (2^(6+1) ^^^ 25) := by decide +kernel

theorem selectedBound2923 : packedSelected [0,3] rootPS < 2^1333 := by decide +kernel

def env2924 : List Nat := [2,4,8,16,1,0,25,5,16,1024,1,1044,9,1028,0,18,1029,0,1025,0,1044,0,0,18,25,17,1,1028,1044,1,1024,4294967296,5,4294967297,1029,17]

theorem envBound2924 : H12AffineFastState.Bounded env2924 := by
  intro p hp
  have h : env2924.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2923_2924 : H12AffineEnvironment.transform 6 25 env2923 = env2924 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 25 env2923 == env2924) = true)

theorem identity2924 : scanCanonicalize (H12AffineFastState.compose env2924 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 11) := by decide +kernel

theorem selectedBound2924 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2925 : List Nat := [2,4,8,16,1,0,25,5,16,1024,1,1044,9,1028,0,18,1029,0,1025,0,1044,0,0,18,25,17,1,1028,1044,1,1024,11,5,10,1029,17]

theorem envBound2925 : H12AffineFastState.Bounded env2925 := by
  intro p hp
  have h : env2925.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2924_2925 : H12AffineEnvironment.transform 31 11 env2924 = env2925 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 11 env2924 == env2925) = true)

def leafEnv2925 : List Nat := [2,4,8,16,1,0,25,5,16,1024,1,1044,9,1028,0,18,1029,0,1025,0,1044,0,0,18,1025,25,1,17,1,1028,1044,1,1024,11,5,10,4,3,1029,17,0,1044,1]

def active2925 : List Nat := [0,1,2,3,9]

def tree2925 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2925 : H12WitnessSearch.Good tree2925 := H12GlobalWitnessIndex.good

theorem leafIdentity2925 : H12AffineFastState.composeSystem env2925 rootObs = leafEnv2925 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2925 rootObs == leafEnv2925) = true)

theorem terminalChecked2925 : H12PackedTerminal.terminalCheckFast leafEnv2925 active2925 tree2925 = true := by decide +kernel

def env2926 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1345,0,524288,8832,2097152,8201,17665,74628,33554432,5376,2122076,16384,1296,2099096,1284,4294967296,256,4329142270,1345,33563272]

theorem envBound2926 : H12AffineFastState.Bounded env2926 := by
  intro p hp
  have h : env2926.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2911_2926 : H12AffineEnvironment.transform 16 1345 env2911 = env2926 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env2911 == env2926) = true)

theorem identity2926 : scanCanonicalize (H12AffineFastState.compose env2926 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 2647256) := by decide +kernel

theorem selectedBound2926 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env2927 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1345,0,524288,8832,2097152,8201,17665,74628,2647256,5376,2122076,16384,1296,2099096,1284,4294967296,256,4297134886,1345,2639440]

theorem envBound2927 : H12AffineFastState.Bounded env2927 := by
  intro p hp
  have h : env2927.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2926_2927 : H12AffineEnvironment.transform 24 2647256 env2926 = env2927 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 2647256 env2926 == env2927) = true)

theorem identity2927 : scanCanonicalize (H12AffineFastState.compose env2927 (packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS)) = affineNative (2^(15+1) ^^^ 17867) := by decide +kernel

theorem selectedBound2927 : packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS < 2^1333 := by decide +kernel

def env2928 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,17867,1345,0,524288,8832,2097152,8201,17665,26191,2647256,5376,2122076,16384,1296,2099096,1284,4294967296,256,4297086701,1345,2639440]

theorem envBound2928 : H12AffineFastState.Bounded env2928 := by
  intro p hp
  have h : env2928.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2927_2928 : H12AffineEnvironment.transform 15 17867 env2927 = env2928 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 17867 env2927 == env2928) = true)

theorem identity2928 : scanCanonicalize (H12AffineFastState.compose env2928 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound2928 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env2929 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,17867,1345,0,524288,8832,4096,8201,17665,26191,554200,5376,29020,16384,1296,6040,1284,4294967296,256,4294985453,1345,546384]

theorem envBound2929 : H12AffineFastState.Bounded env2929 := by
  intro p hp
  have h : env2929.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2928_2929 : H12AffineEnvironment.transform 20 4096 env2928 = env2929 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env2928 == env2929) = true)

theorem identity2929 : scanCanonicalize (H12AffineFastState.compose env2929 (packedSelected [20] rootPS)) = affineNative (2^(13+1) ^^^ 9957) := by decide +kernel

theorem selectedBound2929 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env2930 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,9957,8832,9006,1345,0,524288,8832,4096,8201,9188,170,528957,5376,6073,9957,1296,6040,1284,4294967296,256,4294975496,1345,536757]

theorem envBound2930 : H12AffineFastState.Bounded env2930 := by
  intro p hp
  have h : env2930.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2929_2930 : H12AffineEnvironment.transform 13 9957 env2929 = env2930 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 9957 env2929 == env2930) = true)

theorem identity2930 : scanCanonicalize (H12AffineFastState.compose env2930 (packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS)) = affineNative (2^(12+1) ^^^ 5149) := by decide +kernel

theorem selectedBound2930 : packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS < 2^1333 := by decide +kernel

def env2931 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,5149,4856,5789,5939,1345,0,524288,5789,4096,5140,6137,170,528957,5376,6073,4856,1296,6040,1284,4294967296,256,4294972437,1345,525480]

theorem envBound2931 : H12AffineFastState.Bounded env2931 := by
  intro p hp
  have h : env2931.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2930_2931 : H12AffineEnvironment.transform 12 5149 env2930 = env2931 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5149 env2930 == env2931) = true)

theorem identity2931 : scanCanonicalize (H12AffineFastState.compose env2931 (packedSelected [3,5,8,10,12,13,16,17] rootPS)) = affineNative (2^(18+1) ^^^ 4970) := by decide +kernel

theorem selectedBound2931 : packedSelected [3,5,8,10,12,13,16,17] rootPS < 2^1333 := by decide +kernel

def env2932 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,5149,4856,5789,5939,1345,0,4970,5789,4096,5140,6137,170,343,5376,6073,4856,1296,6040,1284,4294967296,256,4294972437,1345,6082]

theorem envBound2932 : H12AffineFastState.Bounded env2932 := by
  intro p hp
  have h : env2932.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2931_2932 : H12AffineEnvironment.transform 18 4970 env2931 = env2932 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 4970 env2931 == env2932) = true)

theorem identity2932 : scanCanonicalize (H12AffineFastState.compose env2932 (packedSelected [0,2,5,6,8,9,10,12,18,21] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound2932 : packedSelected [0,2,5,6,8,9,10,12,18,21] rootPS < 2^1333 := by decide +kernel

def env2933 : List Nat := [2,4,8,16,1,64,128,256,512,1024,1,4096,5149,4825,5789,5906,1345,0,4939,5789,4096,5140,6104,139,343,5376,6040,4825,1296,6040,1284,4294967296,256,4294972437,1345,6082]

theorem envBound2933 : H12AffineFastState.Bounded env2933 := by
  intro p hp
  have h : env2933.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2932_2933 : H12AffineEnvironment.transform 4 1 env2932 = env2933 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env2932 == env2933) = true)

theorem identity2933 : scanCanonicalize (H12AffineFastState.compose env2933 (packedSelected [0,1,4,7,8,9,13] rootPS)) = affineNative (2^(11+1) ^^^ 1223) := by decide +kernel

theorem selectedBound2933 : packedSelected [0,1,4,7,8,9,13] rootPS < 2^1333 := by decide +kernel

def env2934 : List Nat := [2,4,8,16,1,64,128,256,512,1024,1,1223,218,1566,602,981,1345,0,1932,602,1223,211,799,139,343,455,863,1566,1296,863,1284,4294967296,256,4294967506,1345,773]

theorem envBound2934 : H12AffineFastState.Bounded env2934 := by
  intro p hp
  have h : env2934.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2933_2934 : H12AffineEnvironment.transform 11 1223 env2933 = env2934 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1223 env2933 == env2934) = true)

theorem identity2934 : scanCanonicalize (H12AffineFastState.compose env2934 (packedSelected [0,1,2,4,6,8,10,12] rootPS)) = affineNative (2^(8+1) ^^^ 396) := by decide +kernel

theorem selectedBound2934 : packedSelected [0,1,2,4,6,8,10,12] rootPS < 2^1333 := by decide +kernel

def env2935 : List Nat := [2,4,8,16,1,64,128,256,396,1024,1,1223,218,1426,470,89,1345,0,1024,470,1223,211,147,139,343,455,211,1426,1296,211,1284,4294967296,256,4294967506,1345,137]

theorem envBound2935 : H12AffineFastState.Bounded env2935 := by
  intro p hp
  have h : env2935.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2934_2935 : H12AffineEnvironment.transform 8 396 env2934 = env2935 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 396 env2934 == env2935) = true)

theorem identity2935 : scanCanonicalize (H12AffineFastState.compose env2935 (packedSelected [0,1,2,3,4,5] rootPS)) = affineNative (2^(31+1) ^^^ 471) := by decide +kernel

theorem selectedBound2935 : packedSelected [0,1,2,3,4,5] rootPS < 2^1333 := by decide +kernel

def env2936 : List Nat := [2,4,8,16,1,64,128,256,396,1024,1,1223,218,1426,470,89,1345,0,1024,470,1223,211,147,139,343,455,211,1426,1296,211,1284,471,256,261,1345,137]

theorem envBound2936 : H12AffineFastState.Bounded env2936 := by
  intro p hp
  have h : env2936.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2935_2936 : H12AffineEnvironment.transform 31 471 env2935 = env2936 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 471 env2935 == env2936) = true)

theorem identity2936 : scanCanonicalize (H12AffineFastState.compose env2936 (packedSelected [4,6,9] rootPS)) = affineNative (2^(6+1) ^^^ 82) := by decide +kernel

theorem selectedBound2936 : packedSelected [4,6,9] rootPS < 2^1333 := by decide +kernel

def env2937 : List Nat := [2,4,8,16,1,64,82,256,350,1024,1,1045,8,1344,260,89,1345,0,1024,260,1045,1,65,89,343,277,1,1344,1296,1,1284,261,256,261,1345,91]

theorem envBound2937 : H12AffineFastState.Bounded env2937 := by
  intro p hp
  have h : env2937.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2936_2937 : H12AffineEnvironment.transform 6 82 env2936 = env2937 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 82 env2936 == env2937) = true)

theorem identity2937 : scanCanonicalize (H12AffineFastState.compose env2937 (packedSelected [3,6] rootPS)) = affineNative (2^(7+1) ^^^ 79) := by decide +kernel

theorem selectedBound2937 : packedSelected [3,6] rootPS < 2^1333 := by decide +kernel

def env2938 : List Nat := [2,4,8,16,1,64,82,79,17,1024,1,1045,8,1039,75,89,1038,0,1024,75,1045,1,65,89,24,90,1,1039,1119,1,1099,74,79,74,1038,91]

theorem envBound2938 : H12AffineFastState.Bounded env2938 := by
  intro p hp
  have h : env2938.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2937_2938 : H12AffineEnvironment.transform 7 79 env2937 = env2938 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 79 env2937 == env2938) = true)

theorem identity2938 : scanCanonicalize (H12AffineFastState.compose env2938 (packedSelected [0,3,4] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound2938 : packedSelected [0,3,4] rootPS < 2^1333 := by decide +kernel

def env2939 : List Nat := [2,4,8,16,1,10,24,5,17,1024,1,1045,8,1039,1,19,1038,0,1024,1,1045,1,11,19,24,16,1,1039,1045,1,1025,0,5,0,1038,17]

theorem envBound2939 : H12AffineFastState.Bounded env2939 := by
  intro p hp
  have h : env2939.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2938_2939 : H12AffineEnvironment.transform 5 10 env2938 = env2939 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env2938 == env2939) = true)

theorem identity2939 : scanCanonicalize (H12AffineFastState.compose env2939 (packedSelected [0] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound2939 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2940 : List Nat := [1,4,8,16,1,9,24,5,17,1024,1,1045,8,1036,1,16,1037,0,1024,1,1045,1,8,16,24,16,1,1036,1045,1,1025,0,5,0,1037,17]

theorem envBound2940 : H12AffineFastState.Bounded env2940 := by
  intro p hp
  have h : env2940.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2939_2940 : H12AffineEnvironment.transform 0 1 env2939 = env2940 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env2939 == env2940) = true)

theorem identity2940 : scanCanonicalize (H12AffineFastState.compose env2940 (packedSelected [1] rootPS)) = affineNative (2^(9+1) ^^^ 20) := by decide +kernel

theorem selectedBound2940 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2941 : List Nat := [1,4,8,16,1,9,24,5,17,20,1,1,8,24,1,16,25,0,20,1,1,1,8,16,24,16,1,24,1,1,21,0,5,0,25,17]

theorem envBound2941 : H12AffineFastState.Bounded env2941 := by
  intro p hp
  have h : env2941.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2940_2941 : H12AffineEnvironment.transform 9 20 env2940 = env2941 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 20 env2940 == env2941) = true)

theorem identity2941 : scanCanonicalize (H12AffineFastState.compose env2941 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 0) := by decide +kernel

theorem selectedBound2941 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2942 : List Nat := [1,4,0,16,1,1,16,5,17,20,1,1,0,16,1,16,17,0,20,1,1,1,0,16,16,16,1,16,1,1,21,0,5,0,17,17]

theorem envBound2942 : H12AffineFastState.Bounded env2942 := by
  intro p hp
  have h : env2942.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2941_2942 : H12AffineEnvironment.transform 2 0 env2941 = env2942 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env2941 == env2942) = true)

theorem identity2942 : scanCanonicalize (H12AffineFastState.compose env2942 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound2942 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env2943 : List Nat := [1,4,0,1,1,1,1,5,0,5,1,1,0,1,1,1,0,0,5,1,1,1,0,1,1,1,1,1,1,1,4,0,5,0,0,0]

theorem envBound2943 : H12AffineFastState.Bounded env2943 := by
  intro p hp
  have h : env2943.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2942_2943 : H12AffineEnvironment.transform 3 1 env2942 = env2943 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env2942 == env2943) = true)

def env2944 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,131072,1,524288,8832,2097152,8201,17665,206533,33554432,5376,2253852,16384,131153,2228953,131141,4294967296,256,4329271999,131072,33563272]

theorem envBound2944 : H12AffineFastState.Bounded env2944 := by
  intro p hp
  have h : env2944.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2910_2944 : H12AffineEnvironment.transform 17 1 env2910 = env2944 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env2910 == env2944) = true)

def env2945 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1344,1,524288,8832,2097152,8201,17665,74629,33554432,5376,2122076,16384,1297,2099097,1285,4294967296,256,4329142271,1344,33563272]

theorem envBound2945 : H12AffineFastState.Bounded env2945 := by
  intro p hp
  have h : env2945.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2944_2945 : H12AffineEnvironment.transform 16 1344 env2944 = env2945 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env2944 == env2945) = true)

theorem identity2945 : scanCanonicalize (H12AffineFastState.compose env2945 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound2945 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env2946 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1344,1,524288,8832,4096,8201,17665,74629,33554432,5376,29020,16384,1297,6041,1285,4294967296,256,4329142271,1344,33563272]

theorem envBound2946 : H12AffineFastState.Bounded env2946 := by
  intro p hp
  have h : env2946.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2945_2946 : H12AffineEnvironment.transform 20 4096 env2945 = env2946 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env2945 == env2946) = true)

theorem identity2946 : scanCanonicalize (H12AffineFastState.compose env2946 (packedSelected [20] rootPS)) = affineNative (2^(8+1) ^^^ 168) := by decide +kernel

theorem selectedBound2946 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env2947 : List Nat := [2,4,8,16,32,64,128,256,168,1024,1,4096,8192,16384,8232,65536,1344,1,524288,8232,4096,8201,17665,74029,33554432,5376,29020,16384,1297,5425,1285,4294967296,256,4329141591,1344,33562656]

theorem envBound2947 : H12AffineFastState.Bounded env2947 := by
  intro p hp
  have h : env2947.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2946_2947 : H12AffineEnvironment.transform 8 168 env2946 = env2947 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 168 env2946 == env2947) = true)

theorem identity2947 : scanCanonicalize (H12AffineFastState.compose env2947 (packedSelected [5,8,12,13,15,17,24,28] rootPS)) = affineNative (2^(13+1) ^^^ 9324) := by decide +kernel

theorem selectedBound2947 : packedSelected [5,8,12,13,15,17,24,28] rootPS < 2^1333 := by decide +kernel

def env2948 : List Nat := [2,4,8,16,32,64,128,256,168,1024,1,4096,8192,9324,8232,65536,1344,1,524288,8232,4096,8201,8557,74029,33554432,5376,5424,9324,1297,5425,1285,4294967296,256,4329115963,1344,33562656]

theorem envBound2948 : H12AffineFastState.Bounded env2948 := by
  intro p hp
  have h : env2948.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2947_2948 : H12AffineEnvironment.transform 13 9324 env2947 = env2948 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 9324 env2947 == env2948) = true)

theorem identity2948 : scanCanonicalize (H12AffineFastState.compose env2948 (packedSelected [1,9,10,12,13,15,18,19,21,22,23,24] rootPS)) = affineNative (2^(24+1) ^^^ 5268) := by decide +kernel

theorem selectedBound2948 : packedSelected [1,9,10,12,13,15,18,19,21,22,23,24] rootPS < 2^1333 := by decide +kernel

def env2949 : List Nat := [2,4,8,16,32,64,128,256,168,1024,1,4096,8192,9324,8232,65536,1344,1,524288,8232,4096,8201,8557,74029,5268,5376,5424,9324,1297,5425,1285,4294967296,256,4295558575,1344,13492]

theorem envBound2949 : H12AffineFastState.Bounded env2949 := by
  intro p hp
  have h : env2949.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2948_2949 : H12AffineEnvironment.transform 24 5268 env2948 = env2949 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 5268 env2948 == env2949) = true)

theorem identity2949 : scanCanonicalize (H12AffineFastState.compose env2949 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound2949 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env2950 : List Nat := [2,4,8,16,1,64,128,256,137,1024,1,4096,8192,9293,8201,65536,1344,1,524288,8201,4096,8201,8524,73996,5268,5376,5393,9293,1297,5392,1285,4294967296,256,4295558542,1344,13461]

theorem envBound2950 : H12AffineFastState.Bounded env2950 := by
  intro p hp
  have h : env2950.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2949_2950 : H12AffineEnvironment.transform 4 1 env2949 = env2950 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env2949 == env2950) = true)

theorem identity2950 : scanCanonicalize (H12AffineFastState.compose env2950 (packedSelected [5,8,16] rootPS)) = affineNative (2^(12+1) ^^^ 5148) := by decide +kernel

theorem selectedBound2950 : packedSelected [5,8,16] rootPS < 2^1333 := by decide +kernel

def env2951 : List Nat := [2,4,8,16,1,64,128,256,137,1024,1,4096,5148,4177,5141,65536,1344,1,524288,5141,4096,5141,5456,70928,5268,5376,5393,4177,1297,5392,1285,4294967296,256,4295558542,1344,137]

theorem envBound2951 : H12AffineFastState.Bounded env2951 := by
  intro p hp
  have h : env2951.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2950_2951 : H12AffineEnvironment.transform 12 5148 env2950 = env2951 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5148 env2950 == env2951) = true)

theorem identity2951 : scanCanonicalize (H12AffineFastState.compose env2951 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(18+1) ^^^ 69780) := by decide +kernel

theorem selectedBound2951 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env2952 : List Nat := [2,4,8,16,1,64,128,256,137,1024,1,4096,5148,4177,5141,65536,1344,1,69780,5141,4096,5141,5456,70928,5268,5376,5393,4177,1297,5392,1285,4294967296,256,4294972698,1344,137]

theorem envBound2952 : H12AffineFastState.Bounded env2952 := by
  intro p hp
  have h : env2952.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2951_2952 : H12AffineEnvironment.transform 18 69780 env2951 = env2952 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 69780 env2951 == env2952) = true)

theorem identity2952 : scanCanonicalize (H12AffineFastState.compose env2952 (packedSelected [0,7] rootPS)) = affineNative (2^(15+1) ^^^ 5395) := by decide +kernel

theorem selectedBound2952 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env2953 : List Nat := [2,4,8,16,1,64,128,256,137,1024,1,4096,5148,4177,5141,5395,1344,1,1415,5141,4096,5141,5456,3,5268,5376,5393,4177,1297,5392,1285,4294967296,256,4294972698,1344,137]

theorem envBound2953 : H12AffineFastState.Bounded env2953 := by
  intro p hp
  have h : env2953.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2952_2953 : H12AffineEnvironment.transform 15 5395 env2952 = env2953 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5395 env2952 == env2953) = true)

theorem identity2953 : scanCanonicalize (H12AffineFastState.compose env2953 (packedSelected [5,8] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound2953 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env2954 : List Nat := [2,4,8,16,1,64,128,256,137,1024,1,1297,269,1344,260,2,1344,1,1415,260,1297,260,65,3,389,17,0,1344,1297,1,1285,4294967296,256,4294967307,1344,137]

theorem envBound2954 : H12AffineFastState.Bounded env2954 := by
  intro p hp
  have h : env2954.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2953_2954 : H12AffineEnvironment.transform 11 1297 env2953 = env2954 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env2953 == env2954) = true)

theorem identity2954 : scanCanonicalize (H12AffineFastState.compose env2954 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 398) := by decide +kernel

theorem selectedBound2954 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2955 : List Nat := [2,4,8,16,1,64,128,256,137,1024,1,1297,269,1344,260,2,1344,1,1415,260,1297,260,65,3,389,17,0,1344,1297,1,1285,398,256,389,1344,137]

theorem envBound2955 : H12AffineFastState.Bounded env2955 := by
  intro p hp
  have h : env2955.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2954_2955 : H12AffineEnvironment.transform 31 398 env2954 = env2955 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 398 env2954 == env2955) = true)

theorem identity2955 : scanCanonicalize (H12AffineFastState.compose env2955 (packedSelected [1,3,5] rootPS)) = affineNative (2^(7+1) ^^^ 221) := by decide +kernel

theorem selectedBound2955 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env2956 : List Nat := [2,4,8,16,1,64,128,221,137,1024,1,1228,208,1181,217,2,1181,1,1114,217,1228,217,65,3,88,17,0,1181,1228,1,1240,83,221,88,1181,137]

theorem envBound2956 : H12AffineFastState.Bounded env2956 := by
  intro p hp
  have h : env2956.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2955_2956 : H12AffineEnvironment.transform 7 221 env2955 = env2956 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 221 env2955 == env2956) = true)

theorem identity2956 : scanCanonicalize (H12AffineFastState.compose env2956 (packedSelected [4,9] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound2956 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env2957 : List Nat := [2,4,8,16,1,64,9,84,0,1024,1,1093,89,1044,80,2,1044,1,1114,80,1093,80,65,3,88,17,0,1044,1093,1,1105,83,84,88,1044,0]

theorem envBound2957 : H12AffineFastState.Bounded env2957 := by
  intro p hp
  have h : env2957.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2956_2957 : H12AffineEnvironment.transform 6 9 env2956 = env2957 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env2956 == env2957) = true)

theorem identity2957 : scanCanonicalize (H12AffineFastState.compose env2957 (packedSelected [1,3] rootPS)) = affineNative (2^(9+1) ^^^ 20) := by decide +kernel

theorem selectedBound2957 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env2958 : List Nat := [2,4,8,16,1,64,9,84,0,20,1,81,89,0,80,2,0,1,78,80,81,80,65,3,88,17,0,0,81,1,69,83,84,88,0,0]

theorem envBound2958 : H12AffineFastState.Bounded env2958 := by
  intro p hp
  have h : env2958.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2957_2958 : H12AffineEnvironment.transform 9 20 env2957 = env2958 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 20 env2957 == env2958) = true)

theorem identity2958 : scanCanonicalize (H12AffineFastState.compose env2958 (packedSelected [2,4] rootPS)) = affineNative (2^(5+1) ^^^ 19) := by decide +kernel

theorem selectedBound2958 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env2959 : List Nat := [2,4,8,16,1,19,9,7,0,20,1,2,10,0,3,2,0,1,29,3,2,3,18,3,11,17,0,0,2,1,22,0,7,11,0,0]

theorem envBound2959 : H12AffineFastState.Bounded env2959 := by
  intro p hp
  have h : env2959.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2958_2959 : H12AffineEnvironment.transform 5 19 env2958 = env2959 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 19 env2958 == env2959) = true)

theorem identity2959 : scanCanonicalize (H12AffineFastState.compose env2959 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound2959 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2960 : List Nat := [2,4,2,16,1,19,3,7,0,20,1,2,0,0,3,2,0,1,23,3,2,3,18,3,1,17,0,0,2,1,22,0,7,1,0,0]

theorem envBound2960 : H12AffineFastState.Bounded env2960 := by
  intro p hp
  have h : env2960.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2959_2960 : H12AffineEnvironment.transform 2 2 env2959 = env2960 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env2959 == env2960) = true)

theorem identity2960 : scanCanonicalize (H12AffineFastState.compose env2960 (packedSelected [1,10] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound2960 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env2961 : List Nat := [2,4,2,1,1,2,3,7,0,5,1,2,0,0,3,2,0,1,6,3,2,3,3,3,1,0,0,0,2,1,7,0,7,1,0,0]

theorem envBound2961 : H12AffineFastState.Bounded env2961 := by
  intro p hp
  have h : env2961.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2960_2961 : H12AffineEnvironment.transform 3 1 env2960 = env2961 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env2960 == env2961) = true)

theorem identity2961 : scanCanonicalize (H12AffineFastState.compose env2961 (packedSelected [1] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound2961 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2962 : List Nat := [0,4,0,1,1,0,1,5,0,5,1,0,0,0,1,0,0,1,4,1,0,1,1,1,1,0,0,0,0,1,5,0,5,1,0,0]

theorem envBound2962 : H12AffineFastState.Bounded env2962 := by
  intro p hp
  have h : env2962.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2961_2962 : H12AffineEnvironment.transform 0 0 env2961 = env2962 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env2961 == env2962) = true)

def env2963 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1345,1,524288,8832,2097152,8201,17665,74628,33554432,5376,2122077,16384,1296,2099096,1284,4294967296,256,4329142270,1345,33563272]

theorem envBound2963 : H12AffineFastState.Bounded env2963 := by
  intro p hp
  have h : env2963.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2944_2963 : H12AffineEnvironment.transform 16 1345 env2944 = env2963 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env2944 == env2963) = true)

theorem identity2963 : scanCanonicalize (H12AffineFastState.compose env2963 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 2647256) := by decide +kernel

theorem selectedBound2963 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env2964 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,65536,1345,1,524288,8832,2097152,8201,17665,74628,2647256,5376,2122077,16384,1296,2099096,1284,4294967296,256,4297134886,1345,2639440]

theorem envBound2964 : H12AffineFastState.Bounded env2964 := by
  intro p hp
  have h : env2964.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2963_2964 : H12AffineEnvironment.transform 24 2647256 env2963 = env2964 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 2647256 env2963 == env2964) = true)

theorem identity2964 : scanCanonicalize (H12AffineFastState.compose env2964 (packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS)) = affineNative (2^(15+1) ^^^ 17867) := by decide +kernel

theorem selectedBound2964 : packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS < 2^1333 := by decide +kernel

def env2965 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,17867,1345,1,524288,8832,2097152,8201,17665,26191,2647256,5376,2122077,16384,1296,2099096,1284,4294967296,256,4297086701,1345,2639440]

theorem envBound2965 : H12AffineFastState.Bounded env2965 := by
  intro p hp
  have h : env2965.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2964_2965 : H12AffineEnvironment.transform 15 17867 env2964 = env2965 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 17867 env2964 == env2965) = true)

theorem identity2965 : scanCanonicalize (H12AffineFastState.compose env2965 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound2965 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env2966 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8832,17867,1345,1,524288,8832,4096,8201,17665,26191,554200,5376,29021,16384,1296,6040,1284,4294967296,256,4294985453,1345,546384]

theorem envBound2966 : H12AffineFastState.Bounded env2966 := by
  intro p hp
  have h : env2966.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2965_2966 : H12AffineEnvironment.transform 20 4096 env2965 = env2966 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env2965 == env2966) = true)

theorem identity2966 : scanCanonicalize (H12AffineFastState.compose env2966 (packedSelected [20] rootPS)) = affineNative (2^(11+1) ^^^ 1976) := by decide +kernel

theorem selectedBound2966 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env2967 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1976,8192,16384,8832,17867,1345,1,524288,8832,1976,8201,17665,26191,549728,696,26341,16384,1296,32,1284,4294967296,256,4294985453,1345,541160]

theorem envBound2967 : H12AffineFastState.Bounded env2967 := by
  intro p hp
  have h : env2967.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2966_2967 : H12AffineEnvironment.transform 11 1976 env2966 = env2967 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1976 env2966 == env2967) = true)

theorem identity2967 : scanCanonicalize (H12AffineFastState.compose env2967 (packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS)) = affineNative (2^(13+1) ^^^ 1345) := by decide +kernel

theorem selectedBound2967 : packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS < 2^1333 := by decide +kernel

def env2968 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1976,8192,1345,8832,138,1345,1,524288,8832,1976,8201,64,8974,534049,696,9124,1345,1296,32,1284,4294967296,256,4294968236,1345,525481]

theorem envBound2968 : H12AffineFastState.Bounded env2968 := by
  intro p hp
  have h : env2968.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2967_2968 : H12AffineEnvironment.transform 13 1345 env2967 = env2968 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1345 env2967 == env2968) = true)

theorem identity2968 : scanCanonicalize (H12AffineFastState.compose env2968 (packedSelected [23,32] rootPS)) = affineNative (2^(18+1) ^^^ 9517) := by decide +kernel

theorem selectedBound2968 : packedSelected [23,32] rootPS < 2^1333 := by decide +kernel

def env2969 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1976,8192,1345,8832,138,1345,1,9517,8832,1976,8201,64,8974,780,696,9124,1345,1296,32,1284,4294967296,256,4294968236,1345,8580]

theorem envBound2969 : H12AffineFastState.Bounded env2969 := by
  intro p hp
  have h : env2969.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2968_2969 : H12AffineEnvironment.transform 18 9517 env2968 = env2969 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 9517 env2968 == env2969) = true)

theorem identity2969 : scanCanonicalize (H12AffineFastState.compose env2969 (packedSelected [3,8,10,12] rootPS)) = affineNative (2^(8+1) ^^^ 428) := by decide +kernel

theorem selectedBound2969 : packedSelected [3,8,10,12] rootPS < 2^1333 := by decide +kernel

def env2970 : List Nat := [2,4,8,16,32,64,128,256,428,1024,1,1044,8192,1345,8492,138,1345,1,9517,8492,1044,8201,64,8354,160,276,8200,1345,1296,32,1284,4294967296,256,4294967296,1345,8580]

theorem envBound2970 : H12AffineFastState.Bounded env2970 := by
  intro p hp
  have h : env2970.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2969_2970 : H12AffineEnvironment.transform 8 428 env2969 = env2970 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 428 env2969 == env2970) = true)

theorem identity2970 : scanCanonicalize (H12AffineFastState.compose env2970 (packedSelected [0,1,3,5,7,8] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound2970 : packedSelected [0,1,3,5,7,8] rootPS < 2^1333 := by decide +kernel

def env2971 : List Nat := [2,4,8,16,32,64,128,5,169,1024,1,1044,8192,1092,8233,138,1092,1,9256,8233,1044,8201,64,8354,160,17,8200,1092,1045,32,1025,4294967296,5,4294967296,1092,8321]

theorem envBound2971 : H12AffineFastState.Bounded env2971 := by
  intro p hp
  have h : env2971.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2970_2971 : H12AffineEnvironment.transform 7 5 env2970 = env2971 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env2970 == env2971) = true)

theorem identity2971 : scanCanonicalize (H12AffineFastState.compose env2971 (packedSelected [0,1,3,7] rootPS)) = affineNative (2^(12+1) ^^^ 40) := by decide +kernel

theorem selectedBound2971 : packedSelected [0,1,3,7] rootPS < 2^1333 := by decide +kernel

def env2972 : List Nat := [2,4,8,16,32,64,128,5,169,1024,1,1044,40,1092,1,138,1092,1,1024,1,1044,33,64,138,160,17,32,1092,1045,32,1025,4294967296,5,4294967296,1092,169]

theorem envBound2972 : H12AffineFastState.Bounded env2972 := by
  intro p hp
  have h : env2972.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2971_2972 : H12AffineEnvironment.transform 12 40 env2971 = env2972 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 40 env2971 == env2972) = true)

theorem identity2972 : scanCanonicalize (H12AffineFastState.compose env2972 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 187) := by decide +kernel

theorem selectedBound2972 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2973 : List Nat := [2,4,8,16,32,64,128,5,169,1024,1,1044,40,1092,1,138,1092,1,1024,1,1044,33,64,138,160,17,32,1092,1045,32,1025,187,5,187,1092,169]

theorem envBound2973 : H12AffineFastState.Bounded env2973 := by
  intro p hp
  have h : env2973.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2972_2973 : H12AffineEnvironment.transform 31 187 env2972 = env2973 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 187 env2972 == env2973) = true)

theorem identity2973 : scanCanonicalize (H12AffineFastState.compose env2973 (packedSelected [1] rootPS)) = affineNative (2^(9+1) ^^^ 135) := by decide +kernel

theorem selectedBound2973 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2974 : List Nat := [2,4,8,16,32,64,128,5,169,135,1,147,40,195,1,138,195,1,135,1,147,33,64,138,160,17,32,195,146,32,134,187,5,187,195,169]

theorem envBound2974 : H12AffineFastState.Bounded env2974 := by
  intro p hp
  have h : env2974.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2973_2974 : H12AffineEnvironment.transform 9 135 env2973 = env2974 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 135 env2973 == env2974) = true)

theorem identity2974 : scanCanonicalize (H12AffineFastState.compose env2974 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 11) := by decide +kernel

theorem selectedBound2974 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2975 : List Nat := [2,4,8,16,32,64,11,5,34,12,1,24,40,72,1,1,72,1,12,1,24,33,64,1,43,17,32,72,25,32,13,48,5,48,72,34]

theorem envBound2975 : H12AffineFastState.Bounded env2975 := by
  intro p hp
  have h : env2975.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2974_2975 : H12AffineEnvironment.transform 6 11 env2974 = env2975 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 11 env2974 == env2975) = true)

theorem identity2975 : scanCanonicalize (H12AffineFastState.compose env2975 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 3) := by decide +kernel

theorem selectedBound2975 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env2976 : List Nat := [2,4,8,16,3,64,11,5,1,12,1,24,11,72,1,1,72,1,12,1,24,2,64,1,8,17,3,72,25,3,13,19,5,19,72,1]

theorem envBound2976 : H12AffineFastState.Bounded env2976 := by
  intro p hp
  have h : env2976.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2975_2976 : H12AffineEnvironment.transform 4 3 env2975 = env2976 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 3 env2975 == env2976) = true)

theorem identity2976 : scanCanonicalize (H12AffineFastState.compose env2976 (packedSelected [4] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound2976 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env2977 : List Nat := [2,4,8,10,3,64,11,5,1,12,1,2,11,72,1,1,72,1,12,1,2,2,64,1,8,11,3,72,3,3,13,9,5,9,72,1]

theorem envBound2977 : H12AffineFastState.Bounded env2977 := by
  intro p hp
  have h : env2977.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2976_2977 : H12AffineEnvironment.transform 3 10 env2976 = env2977 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env2976 == env2977) = true)

theorem identity2977 : scanCanonicalize (H12AffineFastState.compose env2977 (packedSelected [6] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound2977 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env2978 : List Nat := [2,4,2,0,3,64,1,5,1,6,1,2,1,66,1,1,66,1,6,1,2,2,64,1,2,1,3,66,3,3,7,3,5,3,66,1]

theorem envBound2978 : H12AffineFastState.Bounded env2978 := by
  intro p hp
  have h : env2978.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2977_2978 : H12AffineEnvironment.transform 2 2 env2977 = env2978 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env2977 == env2978) = true)

theorem identity2978 : scanCanonicalize (H12AffineFastState.compose env2978 (packedSelected [5,10] rootPS)) = affineNative (2^(5+1) ^^^ 1) := by decide +kernel

theorem selectedBound2978 : packedSelected [5,10] rootPS < 2^1333 := by decide +kernel

def env2979 : List Nat := [2,4,2,0,3,1,1,5,1,6,1,2,1,3,1,1,3,1,6,1,2,2,1,1,2,1,3,3,3,3,7,3,5,3,3,1]

theorem envBound2979 : H12AffineFastState.Bounded env2979 := by
  intro p hp
  have h : env2979.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2978_2979 : H12AffineEnvironment.transform 5 1 env2978 = env2979 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 1 env2978 == env2979) = true)

def env2980 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8833,65536,131072,262144,524288,8833,2097152,10248,17665,206532,33554432,5376,2518044,16384,131153,1073741824,131141,4294967296,256,4329274047,131072,33563272]

theorem envBound2980 : H12AffineFastState.Bounded env2980 := by
  intro p hp
  have h : env2980.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2861_2980 : H12AffineEnvironment.transform 14 8833 env2861 = env2980 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8833 env2861 == env2980) = true)

def env2981 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,131072,262144,524288,8833,2097152,8200,17665,206532,33554432,5376,2515996,16384,131153,1073741824,131141,4294967296,256,4329271999,131072,33563272]

theorem envBound2981 : H12AffineFastState.Bounded env2981 := by
  intro p hp
  have h : env2981.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2980_2981 : H12AffineEnvironment.transform 10 0 env2980 = env2981 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env2980 == env2981) = true)

theorem identity2981 : scanCanonicalize (H12AffineFastState.compose env2981 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 409632) := by decide +kernel

theorem selectedBound2981 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env2982 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,131072,262144,524288,8833,2097152,8200,17665,206532,33554432,5376,2515996,16384,131153,409632,131141,4294967296,256,4329271999,131072,33563272]

theorem envBound2982 : H12AffineFastState.Bounded env2982 := by
  intro p hp
  have h : env2982.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2981_2982 : H12AffineEnvironment.transform 29 409632 env2981 = env2982 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 409632 env2981 == env2982) = true)

def env2983 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,131072,0,524288,8833,2097152,8200,17665,206532,33554432,5376,2253852,16384,131153,147488,131141,4294967296,256,4329271999,131072,33563272]

theorem envBound2983 : H12AffineFastState.Bounded env2983 := by
  intro p hp
  have h : env2983.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2982_2983 : H12AffineEnvironment.transform 17 0 env2982 = env2983 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env2982 == env2983) = true)

def env2984 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1344,0,524288,8833,2097152,8200,17665,74628,33554432,5376,2122076,16384,1297,17760,1285,4294967296,256,4329142271,1344,33563272]

theorem envBound2984 : H12AffineFastState.Bounded env2984 := by
  intro p hp
  have h : env2984.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2983_2984 : H12AffineEnvironment.transform 16 1344 env2983 = env2984 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env2983 == env2984) = true)

theorem identity2984 : scanCanonicalize (H12AffineFastState.compose env2984 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound2984 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env2985 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1344,0,524288,8833,4096,8200,17665,74628,33554432,5376,29020,16384,1297,17760,1285,4294967296,256,4329142271,1344,33563272]

theorem envBound2985 : H12AffineFastState.Bounded env2985 := by
  intro p hp
  have h : env2985.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2984_2985 : H12AffineEnvironment.transform 20 4096 env2984 = env2985 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env2984 == env2985) = true)

theorem identity2985 : scanCanonicalize (H12AffineFastState.compose env2985 (packedSelected [20] rootPS)) = affineNative (2^(24+1) ^^^ 5661) := by decide +kernel

theorem selectedBound2985 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env2986 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1344,0,524288,8833,4096,8200,17665,74628,5661,5376,29020,16384,1297,17760,1285,4294967296,256,4295582178,1344,13461]

theorem envBound2986 : H12AffineFastState.Bounded env2986 := by
  intro p hp
  have h : env2986.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2985_2986 : H12AffineEnvironment.transform 24 5661 env2985 = env2986 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 5661 env2985 == env2986) = true)

theorem identity2986 : scanCanonicalize (H12AffineFastState.compose env2986 (packedSelected [1,17,18,21,24] rootPS)) = affineNative (2^(13+1) ^^^ 9325) := by decide +kernel

theorem selectedBound2986 : packedSelected [1,17,18,21,24] rootPS < 2^1333 := by decide +kernel

def env2987 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,9325,8833,65536,1344,0,524288,8833,4096,8200,8556,74628,5661,5376,5425,9325,1297,8461,1285,4294967296,256,4295558543,1344,13461]

theorem envBound2987 : H12AffineFastState.Bounded env2987 := by
  intro p hp
  have h : env2987.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2986_2987 : H12AffineEnvironment.transform 13 9325 env2986 = env2987 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 9325 env2986 == env2987) = true)

theorem identity2987 : scanCanonicalize (H12AffineFastState.compose env2987 (packedSelected [6,9,16,18,22,23,25] rootPS)) = affineNative (2^(11+1) ^^^ 1976) := by decide +kernel

theorem selectedBound2987 : packedSelected [6,9,16,18,22,23,25] rootPS < 2^1333 := by decide +kernel

def env2988 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1976,8192,9325,8833,65536,1344,0,524288,8833,1976,8200,8556,74628,421,696,649,9325,1297,8461,1285,4294967296,256,4295558543,1344,9005]

theorem envBound2988 : H12AffineFastState.Bounded env2988 := by
  intro p hp
  have h : env2988.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2987_2988 : H12AffineEnvironment.transform 11 1976 env2987 = env2988 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1976 env2987 == env2988) = true)

theorem identity2988 : scanCanonicalize (H12AffineFastState.compose env2988 (packedSelected [10,12,13,15,17,19] rootPS)) = affineNative (2^(12+1) ^^^ 900) := by decide +kernel

theorem selectedBound2988 : packedSelected [10,12,13,15,17,19] rootPS < 2^1333 := by decide +kernel

def env2989 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1976,900,2025,261,65536,1344,0,524288,261,1976,908,744,65536,421,696,649,2025,1297,649,1285,4294967296,256,4295558543,1344,169]

theorem envBound2989 : H12AffineFastState.Bounded env2989 := by
  intro p hp
  have h : env2989.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2988_2989 : H12AffineEnvironment.transform 12 900 env2988 = env2989 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 900 env2988 == env2989) = true)

theorem identity2989 : scanCanonicalize (H12AffineFastState.compose env2989 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(15+1) ^^^ 138) := by decide +kernel

theorem selectedBound2989 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env2990 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1976,900,2025,261,138,1344,0,524288,261,1976,908,744,138,421,696,649,2025,1297,649,1285,4294967296,256,4295492869,1344,169]

theorem envBound2990 : H12AffineFastState.Bounded env2990 := by
  intro p hp
  have h : env2990.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2989_2990 : H12AffineEnvironment.transform 15 138 env2989 = env2990 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 138 env2989 == env2990) = true)

theorem identity2990 : scanCanonicalize (H12AffineFastState.compose env2990 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(8+1) ^^^ 168) := by decide +kernel

theorem selectedBound2990 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env2991 : List Nat := [2,4,8,16,32,64,128,256,168,1024,0,1296,300,1345,261,138,1344,0,524288,261,1296,292,64,138,421,16,33,1345,1297,33,1285,4294967296,256,4295492869,1344,169]

theorem envBound2991 : H12AffineFastState.Bounded env2991 := by
  intro p hp
  have h : env2991.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2990_2991 : H12AffineEnvironment.transform 8 168 env2990 = env2991 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 168 env2990 == env2991) = true)

theorem identity2991 : scanCanonicalize (H12AffineFastState.compose env2991 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(18+1) ^^^ 1057) := by decide +kernel

theorem selectedBound2991 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env2992 : List Nat := [2,4,8,16,32,64,128,256,168,1024,0,1296,300,1345,261,138,1344,0,1057,261,1296,292,64,138,421,16,33,1345,1297,33,1285,4294967296,256,4294967588,1344,169]

theorem envBound2992 : H12AffineFastState.Bounded env2992 := by
  intro p hp
  have h : env2992.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2991_2992 : H12AffineEnvironment.transform 18 1057 env2991 = env2992 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1057 env2991 == env2992) = true)

theorem identity2992 : scanCanonicalize (H12AffineFastState.compose env2992 (packedSelected [1,2,3,4] rootPS)) = affineNative (2^(9+1) ^^^ 273) := by decide +kernel

theorem selectedBound2992 : packedSelected [1,2,3,4] rootPS < 2^1333 := by decide +kernel

def env2993 : List Nat := [2,4,8,16,32,64,128,256,168,273,0,1,300,80,261,138,81,0,304,261,1,292,64,138,421,16,33,80,0,33,20,4294967296,256,4294967588,81,169]

theorem envBound2993 : H12AffineFastState.Bounded env2993 := by
  intro p hp
  have h : env2993.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2992_2993 : H12AffineEnvironment.transform 9 273 env2992 = env2993 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 273 env2992 == env2993) = true)

theorem identity2993 : scanCanonicalize (H12AffineFastState.compose env2993 (packedSelected [0,7] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound2993 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env2994 : List Nat := [2,4,8,16,1,64,128,256,137,273,0,1,269,80,261,138,81,0,273,261,1,261,64,138,388,16,0,80,0,0,20,4294967296,256,4294967557,81,136]

theorem envBound2994 : H12AffineFastState.Bounded env2994 := by
  intro p hp
  have h : env2994.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2993_2994 : H12AffineEnvironment.transform 4 1 env2993 = env2994 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env2993 == env2994) = true)

theorem identity2994 : scanCanonicalize (H12AffineFastState.compose env2994 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound2994 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env2995 : List Nat := [2,4,8,16,1,16,128,256,137,273,0,1,269,0,261,138,1,0,273,261,1,261,16,138,388,16,0,0,0,0,20,4294967296,256,4294967557,1,136]

theorem envBound2995 : H12AffineFastState.Bounded env2995 := by
  intro p hp
  have h : env2995.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2994_2995 : H12AffineEnvironment.transform 5 16 env2994 = env2995 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env2994 == env2995) = true)

theorem identity2995 : scanCanonicalize (H12AffineFastState.compose env2995 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 413) := by decide +kernel

theorem selectedBound2995 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2996 : List Nat := [2,4,8,16,1,16,128,256,137,273,0,1,269,0,261,138,1,0,273,261,1,261,16,138,388,16,0,0,0,0,20,413,256,152,1,136]

theorem envBound2996 : H12AffineFastState.Bounded env2996 := by
  intro p hp
  have h : env2996.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2995_2996 : H12AffineEnvironment.transform 31 413 env2995 = env2996 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 413 env2995 == env2996) = true)

theorem identity2996 : scanCanonicalize (H12AffineFastState.compose env2996 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 140) := by decide +kernel

theorem selectedBound2996 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env2997 : List Nat := [2,4,8,16,1,16,128,140,137,157,0,1,129,0,137,138,1,0,157,137,1,137,16,138,8,16,0,0,0,0,20,17,140,152,1,136]

theorem envBound2997 : H12AffineFastState.Bounded env2997 := by
  intro p hp
  have h : env2997.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2996_2997 : H12AffineEnvironment.transform 7 140 env2996 = env2997 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 140 env2996 == env2997) = true)

theorem identity2997 : scanCanonicalize (H12AffineFastState.compose env2997 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound2997 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2998 : List Nat := [2,4,8,11,1,11,128,140,137,134,0,1,129,0,137,138,1,0,134,137,1,137,11,138,8,11,0,0,0,0,15,10,140,131,1,136]

theorem envBound2998 : H12AffineFastState.Bounded env2998 := by
  intro p hp
  have h : env2998.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2997_2998 : H12AffineEnvironment.transform 3 11 env2997 = env2998 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env2997 == env2998) = true)

def env2999 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1345,0,524288,8833,2097152,8200,17665,74629,33554432,5376,2122077,16384,1296,17761,1284,4294967296,256,4329142270,1345,33563272]

theorem envBound2999 : H12AffineFastState.Bounded env2999 := by
  intro p hp
  have h : env2999.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2983_2999 : H12AffineEnvironment.transform 16 1345 env2983 = env2999 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env2983 == env2999) = true)

theorem identity2999 : scanCanonicalize (H12AffineFastState.compose env2999 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 2647256) := by decide +kernel

theorem selectedBound2999 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3000 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1345,0,524288,8833,2097152,8200,17665,74629,2647256,5376,2122077,16384,1296,17761,1284,4294967296,256,4297134886,1345,2639440]

theorem envBound3000 : H12AffineFastState.Bounded env3000 := by
  intro p hp
  have h : env3000.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2999_3000 : H12AffineEnvironment.transform 24 2647256 env2999 = env3000 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 2647256 env2999 == env3000) = true)

theorem identity3000 : scanCanonicalize (H12AffineFastState.compose env3000 (packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS)) = affineNative (2^(20+1) ^^^ 67379) := by decide +kernel

theorem selectedBound3000 : packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS < 2^1333 := by decide +kernel

def env3001 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1345,0,524288,8833,67379,8200,17665,74629,615403,5376,91758,16384,1296,17761,1284,4294967296,256,4294972437,1345,606563]

theorem envBound3001 : H12AffineFastState.Bounded env3001 := by
  intro p hp
  have h : env3001.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3000_3001 : H12AffineEnvironment.transform 20 67379 env3000 = env3001 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 67379 env3000 == env3001) = true)

theorem identity3001 : scanCanonicalize (H12AffineFastState.compose env3001 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(15+1) ^^^ 5939) := by decide +kernel

theorem selectedBound3001 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env3002 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,5939,1345,0,524288,8833,4096,8200,17665,13494,554200,5376,29021,16384,1296,17761,1284,4294967296,256,4294972437,1345,546384]

theorem envBound3002 : H12AffineFastState.Bounded env3002 := by
  intro p hp
  have h : env3002.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3001_3002 : H12AffineEnvironment.transform 15 5939 env3001 = env3002 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5939 env3001 == env3002) = true)

theorem identity3002 : scanCanonicalize (H12AffineFastState.compose env3002 (packedSelected [20] rootPS)) = affineNative (2^(18+1) ^^^ 30677) := by decide +kernel

theorem selectedBound3002 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3003 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,5939,1345,0,30677,8833,4096,8200,17665,13494,781,5376,29021,16384,1296,17761,1284,4294967296,256,4294972437,1345,8581]

theorem envBound3003 : H12AffineFastState.Bounded env3003 := by
  intro p hp
  have h : env3003.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3002_3003 : H12AffineEnvironment.transform 18 30677 env3002 = env3003 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 30677 env3002 == env3003) = true)

theorem identity3003 : scanCanonicalize (H12AffineFastState.compose env3003 (packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS)) = affineNative (2^(13+1) ^^^ 4856) := by decide +kernel

theorem selectedBound3003 : packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS < 2^1333 := by decide +kernel

def env3004 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4856,8833,5939,1345,0,9517,8833,4096,8200,6137,13494,781,5376,9125,4856,1296,6041,1284,4294967296,256,4294972437,1345,8581]

theorem envBound3004 : H12AffineFastState.Bounded env3004 := by
  intro p hp
  have h : env3004.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3003_3004 : H12AffineEnvironment.transform 13 4856 env3003 = env3004 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4856 env3003 == env3004) = true)

theorem identity3004 : scanCanonicalize (H12AffineFastState.compose env3004 (packedSelected [3,12,13,15,16,18,21,24] rootPS)) = affineNative (2^(11+1) ^^^ 1977) := by decide +kernel

theorem selectedBound3004 : packedSelected [3,12,13,15,16,18,21,24] rootPS < 2^1333 := by decide +kernel

def env3005 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1977,8192,1345,8833,138,1345,0,9517,8833,1977,8200,64,8975,781,697,9125,1345,1296,32,1284,4294967296,256,4294968236,1345,8581]

theorem envBound3005 : H12AffineFastState.Bounded env3005 := by
  intro p hp
  have h : env3005.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3004_3005 : H12AffineEnvironment.transform 11 1977 env3004 = env3005 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1977 env3004 == env3005) = true)

theorem identity3005 : scanCanonicalize (H12AffineFastState.compose env3005 (packedSelected [3,8,10,12] rootPS)) = affineNative (2^(8+1) ^^^ 428) := by decide +kernel

theorem selectedBound3005 : packedSelected [3,8,10,12] rootPS < 2^1333 := by decide +kernel

def env3006 : List Nat := [2,4,8,16,32,64,128,256,428,1024,0,1045,8192,1345,8493,138,1345,0,9517,8493,1045,8200,64,8355,161,277,8201,1345,1296,32,1284,4294967296,256,4294967296,1345,8581]

theorem envBound3006 : H12AffineFastState.Bounded env3006 := by
  intro p hp
  have h : env3006.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3005_3006 : H12AffineEnvironment.transform 8 428 env3005 = env3006 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 428 env3005 == env3006) = true)

theorem identity3006 : scanCanonicalize (H12AffineFastState.compose env3006 (packedSelected [0,1,3,5,7,8] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound3006 : packedSelected [0,1,3,5,7,8] rootPS < 2^1333 := by decide +kernel

def env3007 : List Nat := [2,4,8,16,32,64,128,4,168,1024,0,1045,8192,1093,8233,138,1093,0,9257,8233,1045,8200,64,8355,161,17,8201,1093,1044,32,1024,4294967296,4,4294967296,1093,8321]

theorem envBound3007 : H12AffineFastState.Bounded env3007 := by
  intro p hp
  have h : env3007.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3006_3007 : H12AffineEnvironment.transform 7 4 env3006 = env3007 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env3006 == env3007) = true)

theorem identity3007 : scanCanonicalize (H12AffineFastState.compose env3007 (packedSelected [0,1,3,7] rootPS)) = affineNative (2^(12+1) ^^^ 41) := by decide +kernel

theorem selectedBound3007 : packedSelected [0,1,3,7] rootPS < 2^1333 := by decide +kernel

def env3008 : List Nat := [2,4,8,16,32,64,128,4,168,1024,0,1045,41,1093,0,138,1093,0,1024,0,1045,33,64,138,161,17,32,1093,1044,32,1024,4294967296,4,4294967296,1093,168]

theorem envBound3008 : H12AffineFastState.Bounded env3008 := by
  intro p hp
  have h : env3008.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3007_3008 : H12AffineEnvironment.transform 12 41 env3007 = env3008 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 41 env3007 == env3008) = true)

theorem identity3008 : scanCanonicalize (H12AffineFastState.compose env3008 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 186) := by decide +kernel

theorem selectedBound3008 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3009 : List Nat := [2,4,8,16,32,64,128,4,168,1024,0,1045,41,1093,0,138,1093,0,1024,0,1045,33,64,138,161,17,32,1093,1044,32,1024,186,4,186,1093,168]

theorem envBound3009 : H12AffineFastState.Bounded env3009 := by
  intro p hp
  have h : env3009.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3008_3009 : H12AffineEnvironment.transform 31 186 env3008 = env3009 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 186 env3008 == env3009) = true)

theorem identity3009 : scanCanonicalize (H12AffineFastState.compose env3009 (packedSelected [1] rootPS)) = affineNative (2^(9+1) ^^^ 134) := by decide +kernel

theorem selectedBound3009 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3010 : List Nat := [2,4,8,16,32,64,128,4,168,134,0,147,41,195,0,138,195,0,134,0,147,33,64,138,161,17,32,195,146,32,134,186,4,186,195,168]

theorem envBound3010 : H12AffineFastState.Bounded env3010 := by
  intro p hp
  have h : env3010.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3009_3010 : H12AffineEnvironment.transform 9 134 env3009 = env3010 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 134 env3009 == env3010) = true)

theorem identity3010 : scanCanonicalize (H12AffineFastState.compose env3010 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 11) := by decide +kernel

theorem selectedBound3010 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3011 : List Nat := [2,4,8,16,32,64,11,4,35,13,0,24,41,72,0,1,72,0,13,0,24,33,64,1,42,17,32,72,25,32,13,49,4,49,72,35]

theorem envBound3011 : H12AffineFastState.Bounded env3011 := by
  intro p hp
  have h : env3011.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3010_3011 : H12AffineEnvironment.transform 6 11 env3010 = env3011 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 11 env3010 == env3011) = true)

theorem identity3011 : scanCanonicalize (H12AffineFastState.compose env3011 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 2) := by decide +kernel

theorem selectedBound3011 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env3012 : List Nat := [2,4,8,16,2,64,11,4,1,13,0,24,11,72,0,1,72,0,13,0,24,3,64,1,8,17,2,72,25,2,13,19,4,19,72,1]

theorem envBound3012 : H12AffineFastState.Bounded env3012 := by
  intro p hp
  have h : env3012.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3011_3012 : H12AffineEnvironment.transform 4 2 env3011 = env3012 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 2 env3011 == env3012) = true)

theorem identity3012 : scanCanonicalize (H12AffineFastState.compose env3012 (packedSelected [4] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound3012 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env3013 : List Nat := [2,4,8,11,2,64,11,4,1,13,0,3,11,72,0,1,72,0,13,0,3,3,64,1,8,10,2,72,2,2,13,8,4,8,72,1]

theorem envBound3013 : H12AffineFastState.Bounded env3013 := by
  intro p hp
  have h : env3013.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3012_3013 : H12AffineEnvironment.transform 3 11 env3012 = env3013 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env3012 == env3013) = true)

theorem identity3013 : scanCanonicalize (H12AffineFastState.compose env3013 (packedSelected [6] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound3013 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env3014 : List Nat := [2,4,3,0,2,64,0,4,1,6,0,3,0,67,0,1,67,0,6,0,3,3,64,1,3,1,2,67,2,2,6,3,4,3,67,1]

theorem envBound3014 : H12AffineFastState.Bounded env3014 := by
  intro p hp
  have h : env3014.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3013_3014 : H12AffineEnvironment.transform 2 3 env3013 = env3014 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env3013 == env3014) = true)

theorem identity3014 : scanCanonicalize (H12AffineFastState.compose env3014 (packedSelected [5,10] rootPS)) = affineNative (2^(5+1) ^^^ 0) := by decide +kernel

theorem selectedBound3014 : packedSelected [5,10] rootPS < 2^1333 := by decide +kernel

def env3015 : List Nat := [2,4,3,0,2,0,0,4,1,6,0,3,0,3,0,1,3,0,6,0,3,3,0,1,3,1,2,3,2,2,6,3,4,3,3,1]

theorem envBound3015 : H12AffineFastState.Bounded env3015 := by
  intro p hp
  have h : env3015.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3014_3015 : H12AffineEnvironment.transform 5 0 env3014 = env3015 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env3014 == env3015) = true)

theorem identity3015 : scanCanonicalize (H12AffineFastState.compose env3015 (packedSelected [5] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound3015 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env3016 : List Nat := [0,4,1,0,0,0,0,4,1,4,0,1,0,1,0,1,1,0,4,0,1,1,0,1,1,1,0,1,0,0,4,1,4,1,1,1]

theorem envBound3016 : H12AffineFastState.Bounded env3016 := by
  intro p hp
  have h : env3016.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3015_3016 : H12AffineEnvironment.transform 0 0 env3015 = env3016 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env3015 == env3016) = true)

def env3017 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,131072,1,524288,8833,2097152,8200,17665,206532,33554432,5376,2253853,16384,131153,147489,131141,4294967296,256,4329271999,131072,33563272]

theorem envBound3017 : H12AffineFastState.Bounded env3017 := by
  intro p hp
  have h : env3017.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2982_3017 : H12AffineEnvironment.transform 17 1 env2982 = env3017 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env2982 == env3017) = true)

def env3018 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1344,1,524288,8833,2097152,8200,17665,74628,33554432,5376,2122077,16384,1297,17761,1285,4294967296,256,4329142271,1344,33563272]

theorem envBound3018 : H12AffineFastState.Bounded env3018 := by
  intro p hp
  have h : env3018.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3017_3018 : H12AffineEnvironment.transform 16 1344 env3017 = env3018 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env3017 == env3018) = true)

theorem identity3018 : scanCanonicalize (H12AffineFastState.compose env3018 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound3018 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3019 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1344,1,524288,8833,4096,8200,17665,74628,33554432,5376,29021,16384,1297,17761,1285,4294967296,256,4329142271,1344,33563272]

theorem envBound3019 : H12AffineFastState.Bounded env3019 := by
  intro p hp
  have h : env3019.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3018_3019 : H12AffineEnvironment.transform 20 4096 env3018 = env3019 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3018 == env3019) = true)

theorem identity3019 : scanCanonicalize (H12AffineFastState.compose env3019 (packedSelected [20] rootPS)) = affineNative (2^(24+1) ^^^ 26433) := by decide +kernel

theorem selectedBound3019 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3020 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1344,1,524288,8833,4096,8200,17665,74628,26433,5376,29021,16384,1297,17761,1285,4294967296,256,4295561406,1344,17865]

theorem envBound3020 : H12AffineFastState.Bounded env3020 := by
  intro p hp
  have h : env3020.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3019_3020 : H12AffineEnvironment.transform 24 26433 env3019 = env3020 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 26433 env3019 == env3020) = true)

theorem identity3020 : scanCanonicalize (H12AffineFastState.compose env3020 (packedSelected [5,8,12,13,15,17,24,28] rootPS)) = affineNative (2^(12+1) ^^^ 5180) := by decide +kernel

theorem selectedBound3020 : packedSelected [5,8,12,13,15,17,24,28] rootPS < 2^1333 := by decide +kernel

def env3021 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,5180,16384,5821,65536,1344,1,524288,5821,4096,5172,17665,71608,21373,5376,17761,16384,1297,17761,1285,4294967296,256,4295561406,1344,17865]

theorem envBound3021 : H12AffineFastState.Bounded env3021 := by
  intro p hp
  have h : env3021.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3020_3021 : H12AffineEnvironment.transform 12 5180 env3020 = env3021 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5180 env3020 == env3021) = true)

theorem identity3021 : scanCanonicalize (H12AffineFastState.compose env3021 (packedSelected [0,9,22,23,27] rootPS)) = affineNative (2^(13+1) ^^^ 4857) := by decide +kernel

theorem selectedBound3021 : packedSelected [0,9,22,23,27] rootPS < 2^1333 := by decide +kernel

def env3022 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,5180,4857,5821,65536,1344,1,524288,5821,4096,5172,6136,71608,388,5376,6040,4857,1297,6040,1285,4294967296,256,4295561406,1344,5936]

theorem envBound3022 : H12AffineFastState.Bounded env3022 := by
  intro p hp
  have h : env3022.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3021_3022 : H12AffineEnvironment.transform 13 4857 env3021 = env3022 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4857 env3021 == env3022) = true)

theorem identity3022 : scanCanonicalize (H12AffineFastState.compose env3022 (packedSelected [9,18,22,23] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound3022 : packedSelected [9,18,22,23] rootPS < 2^1333 := by decide +kernel

def env3023 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,5180,4208,5172,65536,1344,1,524288,5172,4096,5172,5489,70961,388,5376,5393,4208,1297,5393,1285,4294967296,256,4295561406,1344,5561]

theorem envBound3023 : H12AffineFastState.Bounded env3023 := by
  intro p hp
  have h : env3023.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3022_3023 : H12AffineEnvironment.transform 8 137 env3022 = env3023 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env3022 == env3023) = true)

theorem identity3023 : scanCanonicalize (H12AffineFastState.compose env3023 (packedSelected [1,3,12,13,15,17,18] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound3023 : packedSelected [1,3,12,13,15,17,18] rootPS < 2^1333 := by decide +kernel

def env3024 : List Nat := [2,4,8,16,0,64,128,256,137,1024,0,4096,5148,4176,5140,65536,1344,1,524288,5140,4096,5140,5457,70929,388,5376,5393,4176,1297,5393,1285,4294967296,256,4295561374,1344,5529]

theorem envBound3024 : H12AffineFastState.Bounded env3024 := by
  intro p hp
  have h : env3024.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3023_3024 : H12AffineEnvironment.transform 4 0 env3023 = env3024 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env3023 == env3024) = true)

theorem identity3024 : scanCanonicalize (H12AffineFastState.compose env3024 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(18+1) ^^^ 70043) := by decide +kernel

theorem selectedBound3024 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env3025 : List Nat := [2,4,8,16,0,64,128,256,137,1024,0,4096,5148,4176,5140,65536,1344,1,70043,5140,4096,5140,5457,70929,388,5376,5393,4176,1297,5393,1285,4294967296,256,4294967557,1344,5529]

theorem envBound3025 : H12AffineFastState.Bounded env3025 := by
  intro p hp
  have h : env3025.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3024_3025 : H12AffineEnvironment.transform 18 70043 env3024 = env3025 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 70043 env3024 == env3025) = true)

theorem identity3025 : scanCanonicalize (H12AffineFastState.compose env3025 (packedSelected [1,10,15] rootPS)) = affineNative (2^(15+1) ^^^ 5191) := by decide +kernel

theorem selectedBound3025 : packedSelected [1,10,15] rootPS < 2^1333 := by decide +kernel

def env3026 : List Nat := [2,4,8,16,0,64,128,256,137,1024,0,4096,5148,4176,5140,5191,1344,1,1500,5140,4096,5140,5457,342,388,5376,5393,4176,1297,5393,1285,4294967296,256,4294967557,1344,5529]

theorem envBound3026 : H12AffineFastState.Bounded env3026 := by
  intro p hp
  have h : env3026.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3025_3026 : H12AffineEnvironment.transform 15 5191 env3025 = env3026 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5191 env3025 == env3026) = true)

theorem identity3026 : scanCanonicalize (H12AffineFastState.compose env3026 (packedSelected [5,8,16] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound3026 : packedSelected [5,8,16] rootPS < 2^1333 := by decide +kernel

def env3027 : List Nat := [2,4,8,16,0,64,128,256,137,1024,0,1297,269,1345,261,342,1344,1,1500,261,1297,261,64,342,388,17,0,1345,1297,0,1285,4294967296,256,4294967557,1344,136]

theorem envBound3027 : H12AffineFastState.Bounded env3027 := by
  intro p hp
  have h : env3027.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3026_3027 : H12AffineEnvironment.transform 11 1297 env3026 = env3027 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env3026 == env3027) = true)

theorem identity3027 : scanCanonicalize (H12AffineFastState.compose env3027 (packedSelected [1,10] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound3027 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env3028 : List Nat := [2,4,8,16,0,64,128,4,137,1024,0,1045,9,1093,1,82,1092,1,1240,1,1045,1,64,82,128,17,0,1093,1045,0,1025,4294967296,4,4294967297,1092,136]

theorem envBound3028 : H12AffineFastState.Bounded env3028 := by
  intro p hp
  have h : env3028.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3027_3028 : H12AffineEnvironment.transform 7 4 env3027 = env3028 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env3027 == env3028) = true)

theorem identity3028 : scanCanonicalize (H12AffineFastState.compose env3028 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 211) := by decide +kernel

theorem selectedBound3028 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3029 : List Nat := [2,4,8,16,0,64,128,4,137,1024,0,1045,9,1093,1,82,1092,1,1240,1,1045,1,64,82,128,17,0,1093,1045,0,1025,211,4,210,1092,136]

theorem envBound3029 : H12AffineFastState.Bounded env3029 := by
  intro p hp
  have h : env3029.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3028_3029 : H12AffineEnvironment.transform 31 211 env3028 = env3029 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 211 env3028 == env3029) = true)

theorem identity3029 : scanCanonicalize (H12AffineFastState.compose env3029 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 25) := by decide +kernel

theorem selectedBound3029 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3030 : List Nat := [2,4,8,16,0,64,25,4,16,1024,0,1045,9,1093,1,82,1092,1,1089,1,1045,1,64,82,25,17,0,1093,1045,0,1025,74,4,75,1092,17]

theorem envBound3030 : H12AffineFastState.Bounded env3030 := by
  intro p hp
  have h : env3030.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3029_3030 : H12AffineEnvironment.transform 6 25 env3029 = env3030 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 25 env3029 == env3030) = true)

def env3031 : List Nat := [2,4,8,16,0,0,25,4,16,1024,0,1045,9,1029,1,18,1028,1,1025,1,1045,1,0,18,25,17,0,1029,1045,0,1025,10,4,11,1028,17]

theorem envBound3031 : H12AffineFastState.Bounded env3031 := by
  intro p hp
  have h : env3031.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3030_3031 : H12AffineEnvironment.transform 5 0 env3030 = env3031 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env3030 == env3031) = true)

def leafEnv3031 : List Nat := [2,4,8,16,0,0,25,4,16,1024,0,1045,9,1029,1,18,1028,1,1025,1,1045,1,0,18,1024,25,1,17,0,1029,1045,0,1025,10,4,11,4,3,1028,17,0,1045,1]

def active3031 : List Nat := [0,1,2,3,9]

def tree3031 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3031 : H12WitnessSearch.Good tree3031 := H12GlobalWitnessIndex.good

theorem leafIdentity3031 : H12AffineFastState.composeSystem env3031 rootObs = leafEnv3031 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3031 rootObs == leafEnv3031) = true)

theorem terminalChecked3031 : H12PackedTerminal.terminalCheckFast leafEnv3031 active3031 tree3031 = true := by decide +kernel

def env3032 : List Nat := [2,4,8,16,0,1,25,4,16,1024,0,1045,9,1028,1,19,1029,1,1024,1,1045,1,1,19,25,17,0,1028,1045,0,1025,11,4,10,1029,17]

theorem envBound3032 : H12AffineFastState.Bounded env3032 := by
  intro p hp
  have h : env3032.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3030_3032 : H12AffineEnvironment.transform 5 1 env3030 = env3032 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 1 env3030 == env3032) = true)

theorem identity3032 : scanCanonicalize (H12AffineFastState.compose env3032 (packedSelected [1] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound3032 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3033 : List Nat := [2,4,3,16,0,1,18,4,16,1024,0,1045,2,1028,1,19,1029,1,1024,1,1045,1,1,19,18,17,0,1028,1045,0,1025,0,4,1,1029,17]

theorem envBound3033 : H12AffineFastState.Bounded env3033 := by
  intro p hp
  have h : env3033.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3032_3033 : H12AffineEnvironment.transform 2 3 env3032 = env3033 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env3032 == env3033) = true)

def leafEnv3033 : List Nat := [2,4,3,16,0,1,18,4,16,1024,0,1045,2,1028,1,19,1029,1,1024,1,1045,1,1,19,1025,18,1,17,0,1028,1045,0,1025,0,4,1,4,3,1029,17,0,1045,1]

def active3033 : List Nat := [0,1,3,9]

def tree3033 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3033 : H12WitnessSearch.Good tree3033 := H12GlobalWitnessIndex.good

theorem leafIdentity3033 : H12AffineFastState.composeSystem env3033 rootObs = leafEnv3033 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3033 rootObs == leafEnv3033) = true)

theorem terminalChecked3033 : H12PackedTerminal.terminalCheckFast leafEnv3033 active3033 tree3033 = true := by decide +kernel

def env3034 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1345,1,524288,8833,2097152,8200,17665,74629,33554432,5376,2122076,16384,1296,17760,1284,4294967296,256,4329142270,1345,33563272]

theorem envBound3034 : H12AffineFastState.Bounded env3034 := by
  intro p hp
  have h : env3034.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3017_3034 : H12AffineEnvironment.transform 16 1345 env3017 = env3034 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env3017 == env3034) = true)

theorem identity3034 : scanCanonicalize (H12AffineFastState.compose env3034 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 2647256) := by decide +kernel

theorem selectedBound3034 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3035 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1345,1,524288,8833,2097152,8200,17665,74629,2647256,5376,2122076,16384,1296,17760,1284,4294967296,256,4297134886,1345,2639440]

theorem envBound3035 : H12AffineFastState.Bounded env3035 := by
  intro p hp
  have h : env3035.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3034_3035 : H12AffineEnvironment.transform 24 2647256 env3034 = env3035 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 2647256 env3034 == env3035) = true)

theorem identity3035 : scanCanonicalize (H12AffineFastState.compose env3035 (packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS)) = affineNative (2^(20+1) ^^^ 67378) := by decide +kernel

theorem selectedBound3035 : packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS < 2^1333 := by decide +kernel

def env3036 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,65536,1345,1,524288,8833,67378,8200,17665,74629,615402,5376,91758,16384,1296,17760,1284,4294967296,256,4294972436,1345,606562]

theorem envBound3036 : H12AffineFastState.Bounded env3036 := by
  intro p hp
  have h : env3036.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3035_3036 : H12AffineEnvironment.transform 20 67378 env3035 = env3036 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 67378 env3035 == env3036) = true)

theorem identity3036 : scanCanonicalize (H12AffineFastState.compose env3036 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(15+1) ^^^ 5938) := by decide +kernel

theorem selectedBound3036 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env3037 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,5938,1345,1,524288,8833,4096,8200,17665,13495,554200,5376,29020,16384,1296,17760,1284,4294967296,256,4294972436,1345,546384]

theorem envBound3037 : H12AffineFastState.Bounded env3037 := by
  intro p hp
  have h : env3037.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3036_3037 : H12AffineEnvironment.transform 15 5938 env3036 = env3037 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5938 env3036 == env3037) = true)

theorem identity3037 : scanCanonicalize (H12AffineFastState.compose env3037 (packedSelected [20] rootPS)) = affineNative (2^(18+1) ^^^ 1672) := by decide +kernel

theorem selectedBound3037 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3038 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8833,5938,1345,1,1672,8833,4096,8200,17665,13495,29264,5376,29020,16384,1296,17760,1284,4294967296,256,4294972436,1345,20696]

theorem envBound3038 : H12AffineFastState.Bounded env3038 := by
  intro p hp
  have h : env3038.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3037_3038 : H12AffineEnvironment.transform 18 1672 env3037 = env3038 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1672 env3037 == env3038) = true)

theorem identity3038 : scanCanonicalize (H12AffineFastState.compose env3038 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound3038 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env3039 : List Nat := [2,4,8,16,32,64,128,37,512,1024,0,4096,8192,16384,8833,5655,1124,1,1672,8833,4096,8200,17444,13495,29264,5157,28793,16384,1077,17477,1057,4294967296,37,4294972436,1124,20696]

theorem envBound3039 : H12AffineFastState.Bounded env3039 := by
  intro p hp
  have h : env3039.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3038_3039 : H12AffineEnvironment.transform 7 37 env3038 = env3039 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env3038 == env3039) = true)

theorem identity3039 : scanCanonicalize (H12AffineFastState.compose env3039 (packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS)) = affineNative (2^(13+1) ^^^ 4857) := by decide +kernel

theorem selectedBound3039 : packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS < 2^1333 := by decide +kernel

def env3040 : List Nat := [2,4,8,16,32,64,128,37,512,1024,0,4096,8192,4857,8833,5655,1124,1,1672,8833,4096,8200,5853,13495,8361,5157,8832,4857,1077,5820,1057,4294967296,37,4294972436,1124,545]

theorem envBound3040 : H12AffineFastState.Bounded env3040 := by
  intro p hp
  have h : env3040.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3039_3040 : H12AffineEnvironment.transform 13 4857 env3039 = env3040 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4857 env3039 == env3040) = true)

theorem identity3040 : scanCanonicalize (H12AffineFastState.compose env3040 (packedSelected [0,5,7,12,15,18] rootPS)) = affineNative (2^(8+1) ^^^ 123) := by decide +kernel

theorem selectedBound3040 : packedSelected [0,5,7,12,15,18] rootPS < 2^1333 := by decide +kernel

def env3041 : List Nat := [2,4,8,16,32,64,128,37,123,1024,0,4096,8192,4226,8442,5228,1124,1,1267,8442,4096,8200,5286,13495,8361,5157,8443,4226,1077,5319,1057,4294967296,37,4294972436,1124,90]

theorem envBound3041 : H12AffineFastState.Bounded env3041 := by
  intro p hp
  have h : env3041.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3040_3041 : H12AffineEnvironment.transform 8 123 env3040 = env3041 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 123 env3040 == env3041) = true)

theorem identity3041 : scanCanonicalize (H12AffineFastState.compose env3041 (packedSelected [0,1,2,3,4,5,6,10,12,13,16] rootPS)) = affineNative (2^(11+1) ^^^ 1076) := by decide +kernel

theorem selectedBound3041 : packedSelected [0,1,2,3,4,5,6,10,12,13,16] rootPS < 2^1333 := by decide +kernel

def env3042 : List Nat := [2,4,8,16,32,64,128,37,123,1024,0,1076,8192,1206,8442,88,1124,1,1267,8442,1076,8200,146,8323,8361,17,8443,1206,1077,243,1057,4294967296,37,4294967328,1124,90]

theorem envBound3042 : H12AffineFastState.Bounded env3042 := by
  intro p hp
  have h : env3042.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3041_3042 : H12AffineEnvironment.transform 11 1076 env3041 = env3042 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1076 env3041 == env3042) = true)

theorem identity3042 : scanCanonicalize (H12AffineFastState.compose env3042 (packedSelected [5,8] rootPS)) = affineNative (2^(12+1) ^^^ 40) := by decide +kernel

theorem selectedBound3042 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env3043 : List Nat := [2,4,8,16,32,64,128,37,123,1024,0,1076,40,1206,210,88,1124,1,1267,210,1076,32,146,171,129,17,211,1206,1077,243,1057,4294967296,37,4294967328,1124,90]

theorem envBound3043 : H12AffineFastState.Bounded env3043 := by
  intro p hp
  have h : env3043.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3042_3043 : H12AffineEnvironment.transform 12 40 env3042 = env3043 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 40 env3042 == env3043) = true)

theorem identity3043 : scanCanonicalize (H12AffineFastState.compose env3043 (packedSelected [0,5,7] rootPS)) = affineNative (2^(6+1) ^^^ 82) := by decide +kernel

theorem selectedBound3043 : packedSelected [0,5,7] rootPS < 2^1333 := by decide +kernel

def env3044 : List Nat := [2,4,8,16,32,64,82,37,123,1024,0,1076,40,1124,0,88,1124,1,1057,0,1076,32,64,121,83,17,1,1124,1077,33,1057,4294967296,37,4294967328,1124,90]

theorem envBound3044 : H12AffineFastState.Bounded env3044 := by
  intro p hp
  have h : env3044.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3043_3044 : H12AffineEnvironment.transform 6 82 env3043 = env3044 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 82 env3043 == env3044) = true)

theorem identity3044 : scanCanonicalize (H12AffineFastState.compose env3044 (packedSelected [0,2,4] rootPS)) = affineNative (2^(31+1) ^^^ 10) := by decide +kernel

theorem selectedBound3044 : packedSelected [0,2,4] rootPS < 2^1333 := by decide +kernel

def env3045 : List Nat := [2,4,8,16,32,64,82,37,123,1024,0,1076,40,1124,0,88,1124,1,1057,0,1076,32,64,121,83,17,1,1124,1077,33,1057,10,37,42,1124,90]

theorem envBound3045 : H12AffineFastState.Bounded env3045 := by
  intro p hp
  have h : env3045.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3044_3045 : H12AffineEnvironment.transform 31 10 env3044 = env3045 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 10 env3044 == env3045) = true)

theorem identity3045 : scanCanonicalize (H12AffineFastState.compose env3045 (packedSelected [1,2,3] rootPS)) = affineNative (2^(5+1) ^^^ 42) := by decide +kernel

theorem selectedBound3045 : packedSelected [1,2,3] rootPS < 2^1333 := by decide +kernel

def env3046 : List Nat := [2,4,8,16,32,42,56,37,17,1024,0,1076,40,1038,0,50,1038,1,1057,0,1076,32,42,19,57,17,1,1038,1077,33,1057,10,37,42,1038,48]

theorem envBound3046 : H12AffineFastState.Bounded env3046 := by
  intro p hp
  have h : env3046.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3045_3046 : H12AffineEnvironment.transform 5 42 env3045 = env3046 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 42 env3045 == env3046) = true)

theorem identity3046 : scanCanonicalize (H12AffineFastState.compose env3046 (packedSelected [2,5] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound3046 : packedSelected [2,5] rootPS < 2^1333 := by decide +kernel

def env3047 : List Nat := [2,4,8,16,1,11,25,4,17,1024,0,1045,9,1038,0,19,1038,1,1024,0,1045,1,11,19,24,17,1,1038,1044,0,1024,10,4,11,1038,17]

theorem envBound3047 : H12AffineFastState.Bounded env3047 := by
  intro p hp
  have h : env3047.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3046_3047 : H12AffineEnvironment.transform 4 1 env3046 = env3047 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env3046 == env3047) = true)

theorem identity3047 : scanCanonicalize (H12AffineFastState.compose env3047 (packedSelected [0] rootPS)) = affineNative (2^(2+1) ^^^ 1) := by decide +kernel

theorem selectedBound3047 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3048 : List Nat := [2,4,1,16,1,2,16,4,17,1024,0,1045,0,1031,0,19,1031,1,1024,0,1045,1,2,19,17,17,1,1031,1044,0,1024,3,4,2,1031,17]

theorem envBound3048 : H12AffineFastState.Bounded env3048 := by
  intro p hp
  have h : env3048.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3047_3048 : H12AffineEnvironment.transform 2 1 env3047 = env3048 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env3047 == env3048) = true)

theorem identity3048 : scanCanonicalize (H12AffineFastState.compose env3048 (packedSelected [1] rootPS)) = affineNative (2^(9+1) ^^^ 23) := by decide +kernel

theorem selectedBound3048 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3049 : List Nat := [2,4,1,16,1,2,16,4,17,23,0,2,0,16,0,19,16,1,23,0,2,1,2,19,17,17,1,16,3,0,23,3,4,2,16,17]

theorem envBound3049 : H12AffineFastState.Bounded env3049 := by
  intro p hp
  have h : env3049.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3048_3049 : H12AffineEnvironment.transform 9 23 env3048 = env3049 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 23 env3048 == env3049) = true)

theorem identity3049 : scanCanonicalize (H12AffineFastState.compose env3049 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound3049 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3050 : List Nat := [2,4,1,0,1,2,0,4,1,7,0,2,0,0,0,3,0,1,7,0,2,1,2,3,1,1,1,0,3,0,7,3,4,2,0,1]

theorem envBound3050 : H12AffineFastState.Bounded env3050 := by
  intro p hp
  have h : env3050.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3049_3050 : H12AffineEnvironment.transform 3 0 env3049 = env3050 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env3049 == env3050) = true)

theorem identity3050 : scanCanonicalize (H12AffineFastState.compose env3050 (packedSelected [6] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound3050 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env3051 : List Nat := [1,4,1,0,1,1,0,4,1,4,0,1,0,0,0,0,0,1,4,0,1,1,1,0,1,1,1,0,0,0,4,0,4,1,0,1]

theorem envBound3051 : H12AffineFastState.Bounded env3051 := by
  intro p hp
  have h : env3051.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3050_3051 : H12AffineEnvironment.transform 0 1 env3050 = env3051 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env3050 == env3051) = true)

def env3052 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,131072,262144,524288,8833,2097152,8201,17665,206532,33554432,5376,2515997,16384,131153,1073741824,131141,4294967296,256,4329271998,131072,33563272]

theorem envBound3052 : H12AffineFastState.Bounded env3052 := by
  intro p hp
  have h : env3052.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2980_3052 : H12AffineEnvironment.transform 10 1 env2980 = env3052 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env2980 == env3052) = true)

theorem identity3052 : scanCanonicalize (H12AffineFastState.compose env3052 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 35791440) := by decide +kernel

theorem selectedBound3052 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3053 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,131072,262144,524288,8833,2097152,8201,17665,206532,33554432,5376,2515997,16384,131153,35791440,131141,4294967296,256,4329271998,131072,33563272]

theorem envBound3053 : H12AffineFastState.Bounded env3053 := by
  intro p hp
  have h : env3053.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3052_3053 : H12AffineEnvironment.transform 29 35791440 env3052 = env3053 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 35791440 env3052 == env3053) = true)

def env3054 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,131072,0,524288,8833,2097152,8201,17665,206532,33554432,5376,2253853,16384,131153,35791440,131141,4294967296,256,4329271998,131072,33563272]

theorem envBound3054 : H12AffineFastState.Bounded env3054 := by
  intro p hp
  have h : env3054.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3053_3054 : H12AffineEnvironment.transform 17 0 env3053 = env3054 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env3053 == env3054) = true)

def env3055 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1344,0,524288,8833,2097152,8201,17665,74628,33554432,5376,2122077,16384,1297,35661584,1285,4294967296,256,4329142270,1344,33563272]

theorem envBound3055 : H12AffineFastState.Bounded env3055 := by
  intro p hp
  have h : env3055.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3054_3055 : H12AffineEnvironment.transform 16 1344 env3054 = env3055 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env3054 == env3055) = true)

theorem identity3055 : scanCanonicalize (H12AffineFastState.compose env3055 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound3055 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3056 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1344,0,524288,8833,4096,8201,17665,74628,33554432,5376,29021,16384,1297,33568528,1285,4294967296,256,4329142270,1344,33563272]

theorem envBound3056 : H12AffineFastState.Bounded env3056 := by
  intro p hp
  have h : env3056.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3055_3056 : H12AffineEnvironment.transform 20 4096 env3055 = env3056 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3055 == env3056) = true)

theorem identity3056 : scanCanonicalize (H12AffineFastState.compose env3056 (packedSelected [20] rootPS)) = affineNative (2^(13+1) ^^^ 13301) := by decide +kernel

theorem selectedBound3056 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3057 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,13301,8833,65536,1344,0,524288,8833,4096,8201,14068,74628,33554432,5376,680,13301,1297,33568528,1285,4294967296,256,4329112587,1344,33563272]

theorem envBound3057 : H12AffineFastState.Bounded env3057 := by
  intro p hp
  have h : env3057.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3056_3057 : H12AffineEnvironment.transform 13 13301 env3056 = env3057 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 13301 env3056 == env3057) = true)

theorem identity3057 : scanCanonicalize (H12AffineFastState.compose env3057 (packedSelected [5,8,12,13,15,17,24,28] rootPS)) = affineNative (2^(24+1) ^^^ 13752) := by decide +kernel

theorem selectedBound3057 : packedSelected [5,8,12,13,15,17,24,28] rootPS < 2^1333 := by decide +kernel

def env3058 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,13301,8833,65536,1344,0,524288,8833,4096,8201,14068,74628,13752,5376,680,13301,1297,680,1285,4294967296,256,4295569843,1344,5936]

theorem envBound3058 : H12AffineFastState.Bounded env3058 := by
  intro p hp
  have h : env3058.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3057_3058 : H12AffineEnvironment.transform 24 13752 env3057 = env3058 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 13752 env3057 == env3058) = true)

theorem identity3058 : scanCanonicalize (H12AffineFastState.compose env3058 (packedSelected [0,9,22,23,27] rootPS)) = affineNative (2^(12+1) ^^^ 268) := by decide +kernel

theorem selectedBound3058 : packedSelected [0,9,22,23,27] rootPS < 2^1333 := by decide +kernel

def env3059 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,268,4857,909,65536,1344,0,524288,909,4096,261,6136,66184,5300,5376,680,4857,1297,680,1285,4294967296,256,4295561407,1344,5936]

theorem envBound3059 : H12AffineFastState.Bounded env3059 := by
  intro p hp
  have h : env3059.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3058_3059 : H12AffineEnvironment.transform 12 268 env3058 = env3059 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 268 env3058 == env3059) = true)

theorem identity3059 : scanCanonicalize (H12AffineFastState.compose env3059 (packedSelected [9,18,22,23] rootPS)) = affineNative (2^(11+1) ^^^ 1976) := by decide +kernel

theorem selectedBound3059 : packedSelected [9,18,22,23] rootPS < 2^1333 := by decide +kernel

def env3060 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1976,268,1345,909,65536,1344,0,524288,909,1976,261,64,66184,780,696,680,1345,1297,680,1285,4294967296,256,4295558919,1344,136]

theorem envBound3060 : H12AffineFastState.Bounded env3060 := by
  intro p hp
  have h : env3060.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3059_3060 : H12AffineEnvironment.transform 11 1976 env3059 = env3060 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1976 env3059 == env3060) = true)

theorem identity3060 : scanCanonicalize (H12AffineFastState.compose env3060 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound3060 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env3061 : List Nat := [2,4,8,16,0,64,128,256,512,1024,1,1944,268,1345,909,65536,1344,0,524288,909,1944,261,64,66184,780,664,648,1345,1297,648,1285,4294967296,256,4295558919,1344,136]

theorem envBound3061 : H12AffineFastState.Bounded env3061 := by
  intro p hp
  have h : env3061.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3060_3061 : H12AffineEnvironment.transform 4 0 env3060 = env3061 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env3060 == env3061) = true)

theorem identity3061 : scanCanonicalize (H12AffineFastState.compose env3061 (packedSelected [0,1,4,7,8,9,13] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound3061 : packedSelected [0,1,4,7,8,9,13] rootPS < 2^1333 := by decide +kernel

def env3062 : List Nat := [2,4,8,16,0,64,128,256,137,1024,1,1297,268,1345,260,65536,1344,0,524288,260,1297,261,64,65537,389,17,1,1345,1297,1,1285,4294967296,256,4295558542,1344,136]

theorem envBound3062 : H12AffineFastState.Bounded env3062 := by
  intro p hp
  have h : env3062.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3061_3062 : H12AffineEnvironment.transform 8 137 env3061 = env3062 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env3061 == env3062) = true)

theorem identity3062 : scanCanonicalize (H12AffineFastState.compose env3062 (packedSelected [1,3,5] rootPS)) = affineNative (2^(15+1) ^^^ 343) := by decide +kernel

theorem selectedBound3062 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env3063 : List Nat := [2,4,8,16,0,64,128,256,137,1024,1,1297,268,1345,260,343,1344,0,524288,260,1297,261,64,342,389,17,1,1345,1297,1,1285,4294967296,256,4295492825,1344,136]

theorem envBound3063 : H12AffineFastState.Bounded env3063 := by
  intro p hp
  have h : env3063.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3062_3063 : H12AffineEnvironment.transform 15 343 env3062 = env3063 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 343 env3062 == env3063) = true)

theorem identity3063 : scanCanonicalize (H12AffineFastState.compose env3063 (packedSelected [0,7] rootPS)) = affineNative (2^(18+1) ^^^ 1500) := by decide +kernel

theorem selectedBound3063 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env3064 : List Nat := [2,4,8,16,0,64,128,256,137,1024,1,1297,268,1345,260,343,1344,0,1500,260,1297,261,64,342,389,17,1,1345,1297,1,1285,4294967296,256,4294967557,1344,136]

theorem envBound3064 : H12AffineFastState.Bounded env3064 := by
  intro p hp
  have h : env3064.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3063_3064 : H12AffineEnvironment.transform 18 1500 env3063 = env3064 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1500 env3063 == env3064) = true)

theorem identity3064 : scanCanonicalize (H12AffineFastState.compose env3064 (packedSelected [1,10] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound3064 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env3065 : List Nat := [2,4,8,16,0,64,128,4,137,1024,1,1045,8,1093,0,83,1092,0,1240,0,1045,1,64,82,129,17,1,1093,1045,1,1025,4294967296,4,4294967297,1092,136]

theorem envBound3065 : H12AffineFastState.Bounded env3065 := by
  intro p hp
  have h : env3065.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3064_3065 : H12AffineEnvironment.transform 7 4 env3064 = env3065 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env3064 == env3065) = true)

theorem identity3065 : scanCanonicalize (H12AffineFastState.compose env3065 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 10) := by decide +kernel

theorem selectedBound3065 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3066 : List Nat := [2,4,8,16,0,64,128,4,137,1024,1,1045,8,1093,0,83,1092,0,1240,0,1045,1,64,82,129,17,1,1093,1045,1,1025,10,4,11,1092,136]

theorem envBound3066 : H12AffineFastState.Bounded env3066 := by
  intro p hp
  have h : env3066.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3065_3066 : H12AffineEnvironment.transform 31 10 env3065 = env3066 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 10 env3065 == env3066) = true)

theorem identity3066 : scanCanonicalize (H12AffineFastState.compose env3066 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 25) := by decide +kernel

theorem selectedBound3066 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3067 : List Nat := [2,4,8,16,0,64,25,4,16,1024,1,1045,8,1093,0,83,1092,0,1089,0,1045,1,64,82,24,17,1,1093,1045,1,1025,10,4,11,1092,17]

theorem envBound3067 : H12AffineFastState.Bounded env3067 := by
  intro p hp
  have h : env3067.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3066_3067 : H12AffineEnvironment.transform 6 25 env3066 = env3067 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 25 env3066 == env3067) = true)

def env3068 : List Nat := [2,4,8,16,0,0,25,4,16,1024,1,1045,8,1029,0,19,1028,0,1025,0,1045,1,0,18,24,17,1,1029,1045,1,1025,10,4,11,1028,17]

theorem envBound3068 : H12AffineFastState.Bounded env3068 := by
  intro p hp
  have h : env3068.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3067_3068 : H12AffineEnvironment.transform 5 0 env3067 = env3068 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env3067 == env3068) = true)

def leafEnv3068 : List Nat := [2,4,8,16,0,0,25,4,16,1024,1,1045,8,1029,0,19,1028,0,1025,0,1045,1,0,18,1024,24,1,17,1,1029,1045,1,1025,10,4,11,4,2,1028,17,0,1045,1]

def active3068 : List Nat := [0,1,2,3,9]

def tree3068 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3068 : H12WitnessSearch.Good tree3068 := H12GlobalWitnessIndex.good

theorem leafIdentity3068 : H12AffineFastState.composeSystem env3068 rootObs = leafEnv3068 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3068 rootObs == leafEnv3068) = true)

theorem terminalChecked3068 : H12PackedTerminal.terminalCheckFast leafEnv3068 active3068 tree3068 = true := by decide +kernel

def env3069 : List Nat := [2,4,8,16,0,1,25,4,16,1024,1,1045,8,1028,0,18,1029,0,1024,0,1045,1,1,19,24,17,1,1028,1045,1,1025,10,4,11,1029,17]

theorem envBound3069 : H12AffineFastState.Bounded env3069 := by
  intro p hp
  have h : env3069.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3067_3069 : H12AffineEnvironment.transform 5 1 env3067 = env3069 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 1 env3067 == env3069) = true)

theorem identity3069 : scanCanonicalize (H12AffineFastState.compose env3069 (packedSelected [1] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound3069 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3070 : List Nat := [2,4,3,16,0,1,18,4,16,1024,1,1045,3,1028,0,18,1029,0,1024,0,1045,1,1,19,19,17,1,1028,1045,1,1025,1,4,0,1029,17]

theorem envBound3070 : H12AffineFastState.Bounded env3070 := by
  intro p hp
  have h : env3070.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3069_3070 : H12AffineEnvironment.transform 2 3 env3069 = env3070 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env3069 == env3070) = true)

def leafEnv3070 : List Nat := [2,4,3,16,0,1,18,4,16,1024,1,1045,3,1028,0,18,1029,0,1024,0,1045,1,1,19,1025,19,1,17,1,1028,1045,1,1025,1,4,0,4,2,1029,17,0,1045,1]

def active3070 : List Nat := [0,1,3,9]

def tree3070 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3070 : H12WitnessSearch.Good tree3070 := H12GlobalWitnessIndex.good

theorem leafIdentity3070 : H12AffineFastState.composeSystem env3070 rootObs = leafEnv3070 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3070 rootObs == leafEnv3070) = true)

theorem terminalChecked3070 : H12PackedTerminal.terminalCheckFast leafEnv3070 active3070 tree3070 = true := by decide +kernel

def env3071 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,0,524288,8833,2097152,8201,17665,74629,33554432,5376,2122076,16384,1296,35661585,1284,4294967296,256,4329142271,1345,33563272]

theorem envBound3071 : H12AffineFastState.Bounded env3071 := by
  intro p hp
  have h : env3071.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3054_3071 : H12AffineEnvironment.transform 16 1345 env3054 = env3071 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env3054 == env3071) = true)

theorem identity3071 : scanCanonicalize (H12AffineFastState.compose env3071 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 2647256) := by decide +kernel

theorem selectedBound3071 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3072 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,0,524288,8833,2097152,8201,17665,74629,2647256,5376,2122076,16384,1296,541641,1284,4294967296,256,4297134887,1345,2639440]

theorem envBound3072 : H12AffineFastState.Bounded env3072 := by
  intro p hp
  have h : env3072.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3071_3072 : H12AffineEnvironment.transform 24 2647256 env3071 = env3072 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 2647256 env3071 == env3072) = true)

theorem identity3072 : scanCanonicalize (H12AffineFastState.compose env3072 (packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS)) = affineNative (2^(20+1) ^^^ 590235) := by decide +kernel

theorem selectedBound3072 : packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS < 2^1333 := by decide +kernel

def env3073 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,0,524288,8833,590235,8201,17665,74629,91459,5376,614599,16384,1296,541641,1284,4294967296,256,4295496380,1345,83915]

theorem envBound3073 : H12AffineFastState.Bounded env3073 := by
  intro p hp
  have h : env3073.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3072_3073 : H12AffineEnvironment.transform 20 590235 env3072 = env3073 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 590235 env3072 == env3073) = true)

theorem identity3073 : scanCanonicalize (H12AffineFastState.compose env3073 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(18+1) ^^^ 70043) := by decide +kernel

theorem selectedBound3073 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env3074 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,0,70043,8833,4096,8201,17665,74629,91459,5376,29020,16384,1296,86610,1284,4294967296,256,4295033639,1345,83915]

theorem envBound3074 : H12AffineFastState.Bounded env3074 := by
  intro p hp
  have h : env3074.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3073_3074 : H12AffineEnvironment.transform 18 70043 env3073 = env3074 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 70043 env3073 == env3074) = true)

theorem identity3074 : scanCanonicalize (H12AffineFastState.compose env3074 (packedSelected [20] rootPS)) = affineNative (2^(13+1) ^^^ 9956) := by decide +kernel

theorem selectedBound3074 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3075 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,9956,8833,65536,1345,0,70043,8833,4096,8201,9189,74629,66471,5376,6072,9956,1296,79030,1284,4294967296,256,4295033639,1345,74031]

theorem envBound3075 : H12AffineFastState.Bounded env3075 := by
  intro p hp
  have h : env3075.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3074_3075 : H12AffineEnvironment.transform 13 9956 env3074 = env3075 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 9956 env3074 == env3075) = true)

theorem identity3075 : scanCanonicalize (H12AffineFastState.compose env3075 (packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS)) = affineNative (2^(12+1) ^^^ 5149) := by decide +kernel

theorem selectedBound3075 : packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS < 2^1333 := by decide +kernel

def env3076 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,5149,4857,5788,65536,1345,0,70043,5788,4096,5140,6136,71576,66471,5376,6072,4857,1296,65707,1284,4294967296,256,4295033639,1345,70962]

theorem envBound3076 : H12AffineFastState.Bounded env3076 := by
  intro p hp
  have h : env3076.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3075_3076 : H12AffineEnvironment.transform 12 5149 env3075 = env3076 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5149 env3075 == env3076) = true)

theorem identity3076 : scanCanonicalize (H12AffineFastState.compose env3076 (packedSelected [1,5,8,12,15,17] rootPS)) = affineNative (2^(15+1) ^^^ 753) := by decide +kernel

theorem selectedBound3076 : packedSelected [1,5,8,12,15,17] rootPS < 2^1333 := by decide +kernel

def env3077 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,5149,4857,5788,753,1345,0,4970,5788,4096,5140,6136,5481,342,5376,6072,4857,1296,602,1284,4294967296,256,4294967766,1345,6083]

theorem envBound3077 : H12AffineFastState.Bounded env3077 := by
  intro p hp
  have h : env3077.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3076_3077 : H12AffineEnvironment.transform 15 753 env3076 = env3077 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 753 env3076 == env3077) = true)

theorem identity3077 : scanCanonicalize (H12AffineFastState.compose env3077 (packedSelected [0,2,5,6,8,9,10,12,18,21] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound3077 : packedSelected [0,2,5,6,8,9,10,12,18,21] rootPS < 2^1333 := by decide +kernel

def env3078 : List Nat := [2,4,8,16,0,64,128,256,512,1024,1,4096,5149,4825,5788,721,1345,0,4938,5788,4096,5140,6104,5449,342,5376,6040,4825,1296,602,1284,4294967296,256,4294967766,1345,6083]

theorem envBound3078 : H12AffineFastState.Bounded env3078 := by
  intro p hp
  have h : env3078.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3077_3078 : H12AffineEnvironment.transform 4 0 env3077 = env3078 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env3077 == env3078) = true)

theorem identity3078 : scanCanonicalize (H12AffineFastState.compose env3078 (packedSelected [3,5,10,15] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound3078 : packedSelected [3,5,10,15] rootPS < 2^1333 := by decide +kernel

def env3079 : List Nat := [2,4,8,16,0,64,128,256,512,1024,1,1297,268,1992,909,721,1345,0,1627,909,1297,261,713,88,342,17,649,1992,1296,602,1284,4294967296,256,4294967766,1345,722]

theorem envBound3079 : H12AffineFastState.Bounded env3079 := by
  intro p hp
  have h : env3079.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3078_3079 : H12AffineEnvironment.transform 11 1297 env3078 = env3079 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env3078 == env3079) = true)

theorem identity3079 : scanCanonicalize (H12AffineFastState.compose env3079 (packedSelected [3,5,10,12] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound3079 : packedSelected [3,5,10,12] rootPS < 2^1333 := by decide +kernel

def env3080 : List Nat := [2,4,8,16,0,64,128,256,137,1024,1,1297,268,1345,260,88,1345,0,1234,260,1297,261,64,88,342,17,0,1345,1296,211,1284,4294967296,256,4294967766,1345,91]

theorem envBound3080 : H12AffineFastState.Bounded env3080 := by
  intro p hp
  have h : env3080.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3079_3080 : H12AffineEnvironment.transform 8 137 env3079 = env3080 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env3079 == env3080) = true)

def env3081 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,131072,1,524288,8833,2097152,8201,17665,206532,33554432,5376,2253852,16384,131153,35791440,131141,4294967296,256,4329271998,131072,33563272]

theorem envBound3081 : H12AffineFastState.Bounded env3081 := by
  intro p hp
  have h : env3081.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3053_3081 : H12AffineEnvironment.transform 17 1 env3053 = env3081 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env3053 == env3081) = true)

def env3082 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1344,1,524288,8833,2097152,8201,17665,74628,33554432,5376,2122076,16384,1297,35661584,1285,4294967296,256,4329142270,1344,33563272]

theorem envBound3082 : H12AffineFastState.Bounded env3082 := by
  intro p hp
  have h : env3082.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3081_3082 : H12AffineEnvironment.transform 16 1344 env3081 = env3082 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env3081 == env3082) = true)

theorem identity3082 : scanCanonicalize (H12AffineFastState.compose env3082 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound3082 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3083 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1344,1,524288,8833,4096,8201,17665,74628,33554432,5376,29020,16384,1297,33568528,1285,4294967296,256,4329142270,1344,33563272]

theorem envBound3083 : H12AffineFastState.Bounded env3083 := by
  intro p hp
  have h : env3083.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3082_3083 : H12AffineEnvironment.transform 20 4096 env3082 = env3083 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3082 == env3083) = true)

theorem identity3083 : scanCanonicalize (H12AffineFastState.compose env3083 (packedSelected [20] rootPS)) = affineNative (2^(8+1) ^^^ 169) := by decide +kernel

theorem selectedBound3083 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3084 : List Nat := [2,4,8,16,32,64,128,256,169,1024,1,4096,8192,16384,8232,65536,1344,1,524288,8232,4096,8201,17665,74029,33554432,5376,29020,16384,1297,33568185,1285,4294967296,256,4329141591,1344,33562657]

theorem envBound3084 : H12AffineFastState.Bounded env3084 := by
  intro p hp
  have h : env3084.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3083_3084 : H12AffineEnvironment.transform 8 169 env3083 = env3084 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 169 env3083 == env3084) = true)

theorem identity3084 : scanCanonicalize (H12AffineFastState.compose env3084 (packedSelected [5,8,12,13,15,17,24,28] rootPS)) = affineNative (2^(24+1) ^^^ 17636) := by decide +kernel

theorem selectedBound3084 : packedSelected [5,8,12,13,15,17,24,28] rootPS < 2^1333 := by decide +kernel

def env3085 : List Nat := [2,4,8,16,32,64,128,256,169,1024,1,4096,8192,16384,8232,65536,1344,1,524288,8232,4096,8201,17665,74029,17636,5376,29020,16384,1297,29021,1285,4294967296,256,4295569843,1344,25797]

theorem envBound3085 : H12AffineFastState.Bounded env3085 := by
  intro p hp
  have h : env3085.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3084_3085 : H12AffineEnvironment.transform 24 17636 env3084 = env3085 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 17636 env3084 == env3085) = true)

theorem identity3085 : scanCanonicalize (H12AffineFastState.compose env3085 (packedSelected [1,6,10,12,13,15,16,18,19,21,24,25] rootPS)) = affineNative (2^(13+1) ^^^ 4176) := by decide +kernel

theorem selectedBound3085 : packedSelected [1,6,10,12,13,15,16,18,19,21,24,25] rootPS < 2^1333 := by decide +kernel

def env3086 : List Nat := [2,4,8,16,32,64,128,256,169,1024,1,4096,8192,4176,8232,65536,1344,1,524288,8232,4096,8201,5457,74029,5300,5376,8460,4176,1297,8461,1285,4294967296,256,4295569843,1344,13461]

theorem envBound3086 : H12AffineFastState.Bounded env3086 := by
  intro p hp
  have h : env3086.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3085_3086 : H12AffineEnvironment.transform 13 4176 env3085 = env3086 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env3085 == env3086) = true)

theorem identity3086 : scanCanonicalize (H12AffineFastState.compose env3086 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(18+1) ^^^ 70074) := by decide +kernel

theorem selectedBound3086 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env3087 : List Nat := [2,4,8,16,32,64,128,256,169,1024,1,4096,8192,4176,8232,65536,1344,1,70074,8232,4096,8201,5457,74029,5300,5376,8460,4176,1297,8461,1285,4294967296,256,4294975497,1344,13461]

theorem envBound3087 : H12AffineFastState.Bounded env3087 := by
  intro p hp
  have h : env3087.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3086_3087 : H12AffineEnvironment.transform 18 70074 env3086 = env3087 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 70074 env3086 == env3087) = true)

theorem identity3087 : scanCanonicalize (H12AffineFastState.compose env3087 (packedSelected [5,8,16] rootPS)) = affineNative (2^(12+1) ^^^ 5148) := by decide +kernel

theorem selectedBound3087 : packedSelected [5,8,16] rootPS < 2^1333 := by decide +kernel

def env3088 : List Nat := [2,4,8,16,32,64,128,256,169,1024,1,4096,5148,4176,5172,65536,1344,1,70074,5172,4096,5141,5457,70961,5300,5376,5392,4176,1297,5393,1285,4294967296,256,4294972437,1344,137]

theorem envBound3088 : H12AffineFastState.Bounded env3088 := by
  intro p hp
  have h : env3088.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3087_3088 : H12AffineEnvironment.transform 12 5148 env3087 = env3088 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5148 env3087 == env3088) = true)

theorem identity3088 : scanCanonicalize (H12AffineFastState.compose env3088 (packedSelected [3,13] rootPS)) = affineNative (2^(15+1) ^^^ 4470) := by decide +kernel

theorem selectedBound3088 : packedSelected [3,13] rootPS < 2^1333 := by decide +kernel

def env3089 : List Nat := [2,4,8,16,32,64,128,256,169,1024,1,4096,5148,4176,5172,4470,1344,1,204,5172,4096,5141,5457,1095,5300,5376,5392,4176,1297,5393,1285,4294967296,256,4294972437,1344,137]

theorem envBound3089 : H12AffineFastState.Bounded env3089 := by
  intro p hp
  have h : env3089.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3088_3089 : H12AffineEnvironment.transform 15 4470 env3088 = env3089 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 4470 env3088 == env3089) = true)

theorem identity3089 : scanCanonicalize (H12AffineFastState.compose env3089 (packedSelected [1,12,15,17] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound3089 : packedSelected [1,12,15,17] rootPS < 2^1333 := by decide +kernel

def env3090 : List Nat := [2,4,8,16,0,64,128,256,137,1024,1,4096,5148,4176,5140,4438,1344,1,204,5140,4096,5141,5457,1095,5268,5376,5392,4176,1297,5393,1285,4294967296,256,4294972437,1344,137]

theorem envBound3090 : H12AffineFastState.Bounded env3090 := by
  intro p hp
  have h : env3090.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3089_3090 : H12AffineEnvironment.transform 4 0 env3089 = env3090 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env3089 == env3090) = true)

theorem identity3090 : scanCanonicalize (H12AffineFastState.compose env3090 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(7+1) ^^^ 15) := by decide +kernel

theorem selectedBound3090 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env3091 : List Nat := [2,4,8,16,0,64,128,15,137,1024,1,4096,5148,4176,5140,4185,1103,1,204,5140,4096,5141,5214,1095,5268,5135,5151,4176,1054,5150,1034,4294967296,15,4294972437,1103,137]

theorem envBound3091 : H12AffineFastState.Bounded env3091 := by
  intro p hp
  have h : env3091.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3090_3091 : H12AffineEnvironment.transform 7 15 env3090 = env3091 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 15 env3090 == env3091) = true)

theorem identity3091 : scanCanonicalize (H12AffineFastState.compose env3091 (packedSelected [0,7] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound3091 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env3092 : List Nat := [2,4,8,16,0,64,8,15,1,1024,1,4096,5148,4176,5140,4185,1103,1,68,5140,4096,5141,5214,1095,5148,5135,5151,4176,1054,5150,1034,4294967296,15,4294972437,1103,1]

theorem envBound3092 : H12AffineFastState.Bounded env3092 := by
  intro p hp
  have h : env3092.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3091_3092 : H12AffineEnvironment.transform 6 8 env3091 = env3092 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env3091 == env3092) = true)

theorem identity3092 : scanCanonicalize (H12AffineFastState.compose env3092 (packedSelected [5,8] rootPS)) = affineNative (2^(11+1) ^^^ 91) := by decide +kernel

theorem selectedBound3092 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env3093 : List Nat := [2,4,8,16,0,64,8,15,1,1024,1,91,1095,11,1103,2,1103,1,68,1103,91,1102,1029,1095,1095,1108,1092,11,1054,1093,1034,4294967296,15,4294968398,1103,1]

theorem envBound3093 : H12AffineFastState.Bounded env3093 := by
  intro p hp
  have h : env3093.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3092_3093 : H12AffineEnvironment.transform 11 91 env3092 = env3093 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 91 env3092 == env3093) = true)

theorem identity3093 : scanCanonicalize (H12AffineFastState.compose env3093 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 1052) := by decide +kernel

theorem selectedBound3093 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3094 : List Nat := [2,4,8,16,0,64,8,15,1,1024,1,91,1095,11,1103,2,1103,1,68,1103,91,1102,1029,1095,1095,1108,1092,11,1054,1093,1034,1052,15,82,1103,1]

theorem envBound3094 : H12AffineFastState.Bounded env3094 := by
  intro p hp
  have h : env3094.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3093_3094 : H12AffineEnvironment.transform 31 1052 env3093 = env3094 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1052 env3093 == env3094) = true)

theorem identity3094 : scanCanonicalize (H12AffineFastState.compose env3094 (packedSelected [1,3,5] rootPS)) = affineNative (2^(9+1) ^^^ 78) := by decide +kernel

theorem selectedBound3094 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env3095 : List Nat := [2,4,8,16,0,64,8,15,1,78,1,91,9,11,1,2,1,1,68,1,91,0,75,9,9,26,10,11,80,11,68,82,15,82,1,1]

theorem envBound3095 : H12AffineFastState.Bounded env3095 := by
  intro p hp
  have h : env3095.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3094_3095 : H12AffineEnvironment.transform 9 78 env3094 = env3095 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 78 env3094 == env3095) = true)

theorem identity3095 : scanCanonicalize (H12AffineFastState.compose env3095 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 9) := by decide +kernel

theorem selectedBound3095 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3096 : List Nat := [2,4,8,9,0,64,8,15,1,78,1,66,9,11,1,2,1,1,68,1,66,0,75,9,9,3,10,11,73,11,68,75,15,75,1,1]

theorem envBound3096 : H12AffineFastState.Bounded env3096 := by
  intro p hp
  have h : env3096.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3095_3096 : H12AffineEnvironment.transform 3 9 env3095 = env3096 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 9 env3095 == env3096) = true)

theorem identity3096 : scanCanonicalize (H12AffineFastState.compose env3096 (packedSelected [4] rootPS)) = affineNative (2^(5+1) ^^^ 0) := by decide +kernel

theorem selectedBound3096 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env3097 : List Nat := [2,4,8,9,0,0,8,15,1,14,1,2,9,11,1,2,1,1,4,1,2,0,11,9,9,3,10,11,9,11,4,11,15,11,1,1]

theorem envBound3097 : H12AffineFastState.Bounded env3097 := by
  intro p hp
  have h : env3097.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3096_3097 : H12AffineEnvironment.transform 5 0 env3096 = env3097 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env3096 == env3097) = true)

theorem identity3097 : scanCanonicalize (H12AffineFastState.compose env3097 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 1) := by decide +kernel

theorem selectedBound3097 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env3098 : List Nat := [2,4,1,0,0,0,1,6,1,7,1,2,0,2,1,2,1,1,4,1,2,0,2,0,0,3,3,2,0,2,4,2,6,2,1,1]

theorem envBound3098 : H12AffineFastState.Bounded env3098 := by
  intro p hp
  have h : env3098.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3097_3098 : H12AffineEnvironment.transform 2 1 env3097 = env3098 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env3097 == env3098) = true)

def env3099 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,1,524288,8833,2097152,8201,17665,74629,33554432,5376,2122077,16384,1296,35661585,1284,4294967296,256,4329142271,1345,33563272]

theorem envBound3099 : H12AffineFastState.Bounded env3099 := by
  intro p hp
  have h : env3099.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3081_3099 : H12AffineEnvironment.transform 16 1345 env3081 = env3099 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env3081 == env3099) = true)

theorem identity3099 : scanCanonicalize (H12AffineFastState.compose env3099 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 2647256) := by decide +kernel

theorem selectedBound3099 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3100 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,1,524288,8833,2097152,8201,17665,74629,2647256,5376,2122077,16384,1296,541641,1284,4294967296,256,4297134887,1345,2639440]

theorem envBound3100 : H12AffineFastState.Bounded env3100 := by
  intro p hp
  have h : env3100.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3099_3100 : H12AffineEnvironment.transform 24 2647256 env3099 = env3100 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 2647256 env3099 == env3100) = true)

theorem identity3100 : scanCanonicalize (H12AffineFastState.compose env3100 (packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS)) = affineNative (2^(20+1) ^^^ 590235) := by decide +kernel

theorem selectedBound3100 : packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS < 2^1333 := by decide +kernel

def env3101 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,1,524288,8833,590235,8201,17665,74629,91459,5376,614598,16384,1296,541641,1284,4294967296,256,4295496380,1345,83915]

theorem envBound3101 : H12AffineFastState.Bounded env3101 := by
  intro p hp
  have h : env3101.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3100_3101 : H12AffineEnvironment.transform 20 590235 env3100 = env3101 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 590235 env3100 == env3101) = true)

theorem identity3101 : scanCanonicalize (H12AffineFastState.compose env3101 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(18+1) ^^^ 70043) := by decide +kernel

theorem selectedBound3101 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env3102 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,16384,8833,65536,1345,1,70043,8833,4096,8201,17665,74629,91459,5376,29021,16384,1296,86610,1284,4294967296,256,4295033639,1345,83915]

theorem envBound3102 : H12AffineFastState.Bounded env3102 := by
  intro p hp
  have h : env3102.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3101_3102 : H12AffineEnvironment.transform 18 70043 env3101 = env3102 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 70043 env3101 == env3102) = true)

theorem identity3102 : scanCanonicalize (H12AffineFastState.compose env3102 (packedSelected [20] rootPS)) = affineNative (2^(11+1) ^^^ 1977) := by decide +kernel

theorem selectedBound3102 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3103 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1977,8192,16384,8833,65536,1345,1,67106,8833,1977,8201,17665,74629,91459,697,26340,16384,1296,83435,1284,4294967296,256,4295033639,1345,83915]

theorem envBound3103 : H12AffineFastState.Bounded env3103 := by
  intro p hp
  have h : env3103.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3102_3103 : H12AffineEnvironment.transform 11 1977 env3102 = env3103 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1977 env3102 == env3103) = true)

theorem identity3103 : scanCanonicalize (H12AffineFastState.compose env3103 (packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS)) = affineNative (2^(13+1) ^^^ 1345) := by decide +kernel

theorem selectedBound3103 : packedSelected [0,1,3,4,5,7,8,12,13,15,16,21,22] rootPS < 2^1333 := by decide +kernel

def env3104 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1977,8192,1345,8833,65536,1345,1,67106,8833,1977,8201,64,74629,73730,697,9125,1345,1296,65706,1284,4294967296,256,4295033639,1345,66186]

theorem envBound3104 : H12AffineFastState.Bounded env3104 := by
  intro p hp
  have h : env3104.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3103_3104 : H12AffineEnvironment.transform 13 1345 env3103 = env3104 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1345 env3103 == env3104) = true)

theorem identity3104 : scanCanonicalize (H12AffineFastState.compose env3104 (packedSelected [23,32] rootPS)) = affineNative (2^(12+1) ^^^ 901) := by decide +kernel

theorem selectedBound3104 : packedSelected [23,32] rootPS < 2^1333 := by decide +kernel

def env3105 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1977,901,1345,260,65536,1345,1,67106,260,1977,908,64,65536,66439,697,32,1345,1296,65706,1284,4294967296,256,4295033639,1345,66186]

theorem envBound3105 : H12AffineFastState.Bounded env3105 := by
  intro p hp
  have h : env3105.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3104_3105 : H12AffineEnvironment.transform 12 901 env3104 = env3105 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 901 env3104 == env3105) = true)

theorem identity3105 : scanCanonicalize (H12AffineFastState.compose env3105 (packedSelected [0,4,5,7,8,9,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 431) := by decide +kernel

theorem selectedBound3105 : packedSelected [0,4,5,7,8,9,12,15] rootPS < 2^1333 := by decide +kernel

def env3106 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,1977,901,1345,260,431,1345,1,1933,260,1977,908,64,431,552,697,32,1345,1296,261,1284,4294967296,256,4294967944,1345,805]

theorem envBound3106 : H12AffineFastState.Bounded env3106 := by
  intro p hp
  have h : env3106.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3105_3106 : H12AffineEnvironment.transform 15 431 env3105 = env3106 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 431 env3105 == env3106) = true)

theorem identity3106 : scanCanonicalize (H12AffineFastState.compose env3106 (packedSelected [0,1,7,8,10,12] rootPS)) = affineNative (2^(8+1) ^^^ 429) := by decide +kernel

theorem selectedBound3106 : packedSelected [0,1,7,8,10,12] rootPS < 2^1333 := by decide +kernel

def env3107 : List Nat := [2,4,8,16,32,64,128,256,429,1024,1,1044,40,1345,260,431,1345,1,1056,260,1044,33,64,431,389,276,32,1345,1296,261,1284,4294967296,256,4294967589,1345,136]

theorem envBound3107 : H12AffineFastState.Bounded env3107 := by
  intro p hp
  have h : env3107.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3106_3107 : H12AffineEnvironment.transform 8 429 env3106 = env3107 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 429 env3106 == env3107) = true)

theorem identity3107 : scanCanonicalize (H12AffineFastState.compose env3107 (packedSelected [5,8] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound3107 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env3108 : List Nat := [2,4,8,16,32,64,128,36,137,1024,1,1044,40,1125,32,139,1125,1,1056,32,1044,33,64,139,161,48,32,1125,1076,33,1056,4294967296,36,4294967297,1125,136]

theorem envBound3108 : H12AffineFastState.Bounded env3108 := by
  intro p hp
  have h : env3108.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3107_3108 : H12AffineEnvironment.transform 7 36 env3107 = env3108 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env3107 == env3108) = true)

def env3109 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,10249,17665,230469,33554432,5376,2518045,16384,131153,1073741824,131141,4294967296,256,4329297983,131072,33563272]

theorem envBound3109 : H12AffineFastState.Bounded env3109 := by
  intro p hp
  have h : env3109.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2860_3109 : H12AffineEnvironment.transform 21 10249 env2860 = env3109 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10249 env2860 == env3109) = true)

def env3110 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,8832,65536,131072,262144,524288,8832,2097152,10249,17665,206533,33554432,5376,2518045,16384,131153,1073741824,131141,4294967296,256,4329274047,131072,33563272]

theorem envBound3110 : H12AffineFastState.Bounded env3110 := by
  intro p hp
  have h : env3110.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3109_3110 : H12AffineEnvironment.transform 14 8832 env3109 = env3110 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8832 env3109 == env3110) = true)

def env3111 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,131072,262144,524288,8832,2097152,8201,17665,206533,33554432,5376,2515997,16384,131153,1073741824,131141,4294967296,256,4329271999,131072,33563272]

theorem envBound3111 : H12AffineFastState.Bounded env3111 := by
  intro p hp
  have h : env3111.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3110_3111 : H12AffineEnvironment.transform 10 0 env3110 = env3111 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env3110 == env3111) = true)

theorem identity3111 : scanCanonicalize (H12AffineFastState.compose env3111 (packedSelected [11] rootPS)) = affineNative (2^(29+1) ^^^ 35652789) := by decide +kernel

theorem selectedBound3111 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3112 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,131072,262144,524288,8832,2097152,8201,17665,206533,33554432,5376,2515997,16384,131153,35652789,131141,4294967296,256,4329271999,131072,33563272]

theorem envBound3112 : H12AffineFastState.Bounded env3112 := by
  intro p hp
  have h : env3112.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3111_3112 : H12AffineEnvironment.transform 29 35652789 env3111 = env3112 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 35652789 env3111 == env3112) = true)

def env3113 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,131072,0,524288,8832,2097152,8201,17665,206533,33554432,5376,2253853,16384,131153,35652789,131141,4294967296,256,4329271999,131072,33563272]

theorem envBound3113 : H12AffineFastState.Bounded env3113 := by
  intro p hp
  have h : env3113.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3112_3113 : H12AffineEnvironment.transform 17 0 env3112 = env3113 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env3112 == env3113) = true)

def env3114 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1344,0,524288,8832,2097152,8201,17665,74629,33554432,5376,2122077,16384,1297,35652789,1285,4294967296,256,4329142271,1344,33563272]

theorem envBound3114 : H12AffineFastState.Bounded env3114 := by
  intro p hp
  have h : env3114.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3113_3114 : H12AffineEnvironment.transform 16 1344 env3113 = env3114 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env3113 == env3114) = true)

theorem identity3114 : scanCanonicalize (H12AffineFastState.compose env3114 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound3114 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3115 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1344,0,524288,8832,4096,8201,17665,74629,33554432,5376,29021,16384,1297,33559733,1285,4294967296,256,4329142271,1344,33563272]

theorem envBound3115 : H12AffineFastState.Bounded env3115 := by
  intro p hp
  have h : env3115.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3114_3115 : H12AffineEnvironment.transform 20 4096 env3114 = env3115 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3114 == env3115) = true)

theorem identity3115 : scanCanonicalize (H12AffineFastState.compose env3115 (packedSelected [20] rootPS)) = affineNative (2^(24+1) ^^^ 26432) := by decide +kernel

theorem selectedBound3115 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3116 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1344,0,524288,8832,4096,8201,17665,74629,26432,5376,29021,16384,1297,29685,1285,4294967296,256,4295561407,1344,17864]

theorem envBound3116 : H12AffineFastState.Bounded env3116 := by
  intro p hp
  have h : env3116.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3115_3116 : H12AffineEnvironment.transform 24 26432 env3115 = env3116 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 26432 env3115 == env3116) = true)

theorem identity3116 : scanCanonicalize (H12AffineFastState.compose env3116 (packedSelected [5,8,12,13,15,17,24,28] rootPS)) = affineNative (2^(8+1) ^^^ 169) := by decide +kernel

theorem selectedBound3116 : packedSelected [5,8,12,13,15,17,24,28] rootPS < 2^1333 := by decide +kernel

def env3117 : List Nat := [2,4,8,16,32,64,128,256,169,1024,0,4096,8192,16384,8233,65536,1344,0,524288,8233,4096,8201,17665,74028,26089,5376,29021,16384,1297,29020,1285,4294967296,256,4295561407,1344,17864]

theorem envBound3117 : H12AffineFastState.Bounded env3117 := by
  intro p hp
  have h : env3117.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3116_3117 : H12AffineEnvironment.transform 8 169 env3116 = env3117 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 169 env3116 == env3117) = true)

theorem identity3117 : scanCanonicalize (H12AffineFastState.compose env3117 (packedSelected [1,6,9,10,12,13,15,16,19,21,22,23,24,25] rootPS)) = affineNative (2^(13+1) ^^^ 4176) := by decide +kernel

theorem selectedBound3117 : packedSelected [1,6,9,10,12,13,15,16,19,21,22,23,24,25] rootPS < 2^1333 := by decide +kernel

def env3118 : List Nat := [2,4,8,16,32,64,128,256,169,1024,0,4096,8192,4176,8233,65536,1344,0,524288,8233,4096,8201,5457,74028,13753,5376,8461,4176,1297,8460,1285,4294967296,256,4295561407,1344,5528]

theorem envBound3118 : H12AffineFastState.Bounded env3118 := by
  intro p hp
  have h : env3118.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3117_3118 : H12AffineEnvironment.transform 13 4176 env3117 = env3118 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env3117 == env3118) = true)

theorem identity3118 : scanCanonicalize (H12AffineFastState.compose env3118 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(18+1) ^^^ 78006) := by decide +kernel

theorem selectedBound3118 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env3119 : List Nat := [2,4,8,16,32,64,128,256,169,1024,0,4096,8192,4176,8233,65536,1344,0,78006,8233,4096,8201,5457,74028,13753,5376,8461,4176,1297,8460,1285,4294967296,256,4294975497,1344,5528]

theorem envBound3119 : H12AffineFastState.Bounded env3119 := by
  intro p hp
  have h : env3119.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3118_3119 : H12AffineEnvironment.transform 18 78006 env3118 = env3119 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 78006 env3118 == env3119) = true)

theorem identity3119 : scanCanonicalize (H12AffineFastState.compose env3119 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound3119 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env3120 : List Nat := [2,4,8,16,0,64,128,256,137,1024,0,4096,8192,4176,8201,65536,1344,0,77974,8201,4096,8201,5457,73996,13721,5376,8461,4176,1297,8460,1285,4294967296,256,4294975497,1344,5528]

theorem envBound3120 : H12AffineFastState.Bounded env3120 := by
  intro p hp
  have h : env3120.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3119_3120 : H12AffineEnvironment.transform 4 0 env3119 = env3120 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env3119 == env3120) = true)

theorem identity3120 : scanCanonicalize (H12AffineFastState.compose env3120 (packedSelected [5,10,13,15] rootPS)) = affineNative (2^(15+1) ^^^ 13642) := by decide +kernel

theorem selectedBound3120 : packedSelected [5,10,13,15] rootPS < 2^1333 := by decide +kernel

def env3121 : List Nat := [2,4,8,16,0,64,128,256,137,1024,0,4096,8192,4176,8201,13642,1344,0,1500,8201,4096,8201,5457,5190,13721,5376,8461,4176,1297,8460,1285,4294967296,256,4294975497,1344,5528]

theorem envBound3121 : H12AffineFastState.Bounded env3121 := by
  intro p hp
  have h : env3121.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3120_3121 : H12AffineEnvironment.transform 15 13642 env3120 = env3121 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13642 env3120 == env3121) = true)

theorem identity3121 : scanCanonicalize (H12AffineFastState.compose env3121 (packedSelected [3,16,21] rootPS)) = affineNative (2^(12+1) ^^^ 5400) := by decide +kernel

theorem selectedBound3121 : packedSelected [3,16,21] rootPS < 2^1333 := by decide +kernel

def env3122 : List Nat := [2,4,8,16,0,64,128,256,137,1024,0,4096,5400,4176,5393,82,1344,0,1500,5393,4096,5393,5457,5190,129,5376,5141,4176,1297,5140,1285,4294967296,256,4294972689,1344,5528]

theorem envBound3122 : H12AffineFastState.Bounded env3122 := by
  intro p hp
  have h : env3122.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3121_3122 : H12AffineEnvironment.transform 12 5400 env3121 = env3122 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5400 env3121 == env3122) = true)

theorem identity3122 : scanCanonicalize (H12AffineFastState.compose env3122 (packedSelected [5,8,10,12,13] rootPS)) = affineNative (2^(11+1) ^^^ 1044) := by decide +kernel

theorem selectedBound3122 : packedSelected [5,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env3123 : List Nat := [2,4,8,16,0,64,128,256,137,1024,0,1044,268,1092,261,82,1344,0,1500,261,1044,261,325,82,129,276,1,1092,1297,0,1285,4294967296,256,4294967557,1344,396]

theorem envBound3123 : H12AffineFastState.Bounded env3123 := by
  intro p hp
  have h : env3123.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3122_3123 : H12AffineEnvironment.transform 11 1044 env3122 = env3123 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1044 env3122 == env3123) = true)

theorem identity3123 : scanCanonicalize (H12AffineFastState.compose env3123 (packedSelected [2,4,7] rootPS)) = affineNative (2^(31+1) ^^^ 91) := by decide +kernel

theorem selectedBound3123 : packedSelected [2,4,7] rootPS < 2^1333 := by decide +kernel

def env3124 : List Nat := [2,4,8,16,0,64,128,256,137,1024,0,1044,268,1092,261,82,1344,0,1500,261,1044,261,325,82,129,276,1,1092,1297,0,1285,91,256,350,1344,396]

theorem envBound3124 : H12AffineFastState.Bounded env3124 := by
  intro p hp
  have h : env3124.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3123_3124 : H12AffineEnvironment.transform 31 91 env3123 = env3124 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 91 env3123 == env3124) = true)

theorem identity3124 : scanCanonicalize (H12AffineFastState.compose env3124 (packedSelected [2,6] rootPS)) = affineNative (2^(7+1) ^^^ 205) := by decide +kernel

theorem selectedBound3124 : packedSelected [2,6] rootPS < 2^1333 := by decide +kernel

def env3125 : List Nat := [2,4,8,16,0,64,128,205,137,1024,0,1044,193,1092,200,82,1165,0,1041,200,1044,200,136,82,129,217,1,1092,1244,0,1224,91,205,147,1165,65]

theorem envBound3125 : H12AffineFastState.Bounded env3125 := by
  intro p hp
  have h : env3125.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3124_3125 : H12AffineEnvironment.transform 7 205 env3124 = env3125 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 205 env3124 == env3125) = true)

theorem identity3125 : scanCanonicalize (H12AffineFastState.compose env3125 (packedSelected [0,1,2,3,4,8] rootPS)) = affineNative (2^(6+1) ^^^ 73) := by decide +kernel

theorem selectedBound3125 : packedSelected [0,1,2,3,4,8] rootPS < 2^1333 := by decide +kernel

def env3126 : List Nat := [2,4,8,16,0,64,73,4,64,1024,0,1044,8,1092,1,82,1092,0,1041,1,1044,1,65,82,72,16,1,1092,1045,0,1025,91,4,90,1092,65]

theorem envBound3126 : H12AffineFastState.Bounded env3126 := by
  intro p hp
  have h : env3126.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3125_3126 : H12AffineEnvironment.transform 6 73 env3125 = env3126 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 73 env3125 == env3126) = true)

def env3127 : List Nat := [2,4,8,0,0,64,73,4,64,1024,0,1028,8,1092,1,66,1092,0,1025,1,1028,1,65,66,72,0,1,1092,1029,0,1025,75,4,74,1092,65]

theorem envBound3127 : H12AffineFastState.Bounded env3127 := by
  intro p hp
  have h : env3127.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3126_3127 : H12AffineEnvironment.transform 3 0 env3126 = env3127 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env3126 == env3127) = true)

def leafEnv3127 : List Nat := [2,4,8,0,0,64,73,4,64,1024,0,1028,8,1092,1,66,1092,0,1025,1,1028,1,65,66,1024,72,1,0,1,1092,1029,0,1025,75,4,74,4,3,1092,65,0,1029,1]

def active3127 : List Nat := [0,1,2,5,9]

def tree3127 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3127 : H12WitnessSearch.Good tree3127 := H12GlobalWitnessIndex.good

theorem leafIdentity3127 : H12AffineFastState.composeSystem env3127 rootObs = leafEnv3127 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3127 rootObs == leafEnv3127) = true)

theorem terminalChecked3127 : H12PackedTerminal.terminalCheckFast leafEnv3127 active3127 tree3127 = true := by decide +kernel

def env3128 : List Nat := [2,4,8,1,0,64,73,4,64,1024,0,1029,8,1092,1,67,1092,0,1024,1,1029,1,65,67,72,1,1,1092,1028,0,1025,74,4,75,1092,65]

theorem envBound3128 : H12AffineFastState.Bounded env3128 := by
  intro p hp
  have h : env3128.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3126_3128 : H12AffineEnvironment.transform 3 1 env3126 = env3128 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env3126 == env3128) = true)

theorem identity3128 : scanCanonicalize (H12AffineFastState.compose env3128 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound3128 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3129 : List Nat := [2,4,8,1,0,10,3,4,10,1024,0,1029,8,1038,1,9,1038,0,1024,1,1029,1,11,9,2,1,1,1038,1028,0,1025,0,4,1,1038,11]

theorem envBound3129 : H12AffineFastState.Bounded env3129 := by
  intro p hp
  have h : env3129.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3128_3129 : H12AffineEnvironment.transform 5 10 env3128 = env3129 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env3128 == env3129) = true)

def leafEnv3129 : List Nat := [2,4,8,1,0,10,3,4,10,1024,0,1029,8,1038,1,9,1038,0,1024,1,1029,1,11,9,1025,2,1,1,1,1038,1028,0,1025,0,4,1,4,3,1038,11,0,1028,1]

def active3129 : List Nat := [0,1,2,9]

def tree3129 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3129 : H12WitnessSearch.Good tree3129 := H12GlobalWitnessIndex.good

theorem leafIdentity3129 : H12AffineFastState.composeSystem env3129 rootObs = leafEnv3129 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3129 rootObs == leafEnv3129) = true)

theorem terminalChecked3129 : H12PackedTerminal.terminalCheckFast leafEnv3129 active3129 tree3129 = true := by decide +kernel

def env3130 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,0,524288,8832,2097152,8201,17665,74628,33554432,5376,2122076,16384,1296,35652789,1284,4294967296,256,4329142270,1345,33563272]

theorem envBound3130 : H12AffineFastState.Bounded env3130 := by
  intro p hp
  have h : env3130.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3113_3130 : H12AffineEnvironment.transform 16 1345 env3113 = env3130 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env3113 == env3130) = true)

theorem identity3130 : scanCanonicalize (H12AffineFastState.compose env3130 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 2647256) := by decide +kernel

theorem selectedBound3130 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3131 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,0,524288,8832,2097152,8201,17665,74628,2647256,5376,2122076,16384,1296,548973,1284,4294967296,256,4297134886,1345,2639440]

theorem envBound3131 : H12AffineFastState.Bounded env3131 := by
  intro p hp
  have h : env3131.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3130_3131 : H12AffineEnvironment.transform 24 2647256 env3130 = env3131 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 2647256 env3130 == env3131) = true)

theorem identity3131 : scanCanonicalize (H12AffineFastState.compose env3131 (packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS)) = affineNative (2^(20+1) ^^^ 598591) := by decide +kernel

theorem selectedBound3131 : packedSelected [1,3,4,5,6,7,8,9,10,13,16,17,19,20,21,25,27,33] rootPS < 2^1333 := by decide +kernel

def env3132 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,0,524288,8832,598591,8201,17665,74628,83687,5376,607075,16384,1296,548973,1284,4294967296,256,4295504153,1345,91247]

theorem envBound3132 : H12AffineFastState.Bounded env3132 := by
  intro p hp
  have h : env3132.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3131_3132 : H12AffineEnvironment.transform 20 598591 env3131 = env3132 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 598591 env3131 == env3132) = true)

theorem identity3132 : scanCanonicalize (H12AffineFastState.compose env3132 (packedSelected [1,5,6,8,19,24,25,26] rootPS)) = affineNative (2^(18+1) ^^^ 78399) := by decide +kernel

theorem selectedBound3132 : packedSelected [1,5,6,8,19,24,25,26] rootPS < 2^1333 := by decide +kernel

def env3133 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1345,0,78399,8832,4096,8201,17665,74628,83687,5376,29020,16384,1296,86610,1284,4294967296,256,4295033638,1345,91247]

theorem envBound3133 : H12AffineFastState.Bounded env3133 := by
  intro p hp
  have h : env3133.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3132_3133 : H12AffineEnvironment.transform 18 78399 env3132 = env3133 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 78399 env3132 == env3133) = true)

theorem identity3133 : scanCanonicalize (H12AffineFastState.compose env3133 (packedSelected [20] rootPS)) = affineNative (2^(15+1) ^^^ 13494) := by decide +kernel

theorem selectedBound3133 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3134 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,13494,1345,0,1673,8832,4096,8201,17665,5938,29265,5376,29020,16384,1296,26340,1284,4294967296,256,4294981520,1345,20697]

theorem envBound3134 : H12AffineFastState.Bounded env3134 := by
  intro p hp
  have h : env3134.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3133_3134 : H12AffineEnvironment.transform 15 13494 env3133 = env3134 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13494 env3133 == env3134) = true)

theorem identity3134 : scanCanonicalize (H12AffineFastState.compose env3134 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(13+1) ^^^ 4469) := by decide +kernel

theorem selectedBound3134 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env3135 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4469,8832,13494,1345,0,1673,8832,4096,8201,5236,5938,8996,5376,8233,4469,1296,14225,1284,4294967296,256,4294981520,1345,428]

theorem envBound3135 : H12AffineFastState.Bounded env3135 := by
  intro p hp
  have h : env3135.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3134_3135 : H12AffineEnvironment.transform 13 4469 env3134 = env3135 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4469 env3134 == env3135) = true)

theorem identity3135 : scanCanonicalize (H12AffineFastState.compose env3135 (packedSelected [4,5,9,12,15,16] rootPS)) = affineNative (2^(12+1) ^^^ 515) := by decide +kernel

theorem selectedBound3135 : packedSelected [4,5,9,12,15,16] rootPS < 2^1333 := by decide +kernel

def env3136 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,515,4469,131,5813,1345,0,1673,131,4096,522,5236,5938,295,5376,554,4469,1296,5522,1284,4294967296,256,4294972819,1345,428]

theorem envBound3136 : H12AffineFastState.Bounded env3136 := by
  intro p hp
  have h : env3136.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3135_3136 : H12AffineEnvironment.transform 12 515 env3135 = env3136 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 515 env3135 == env3136) = true)

theorem identity3136 : scanCanonicalize (H12AffineFastState.compose env3136 (packedSelected [2,5,6,7,9,10,13,19,21] rootPS)) = affineNative (2^(8+1) ^^^ 169) := by decide +kernel

theorem selectedBound3136 : packedSelected [2,5,6,7,9,10,13,19,21] rootPS < 2^1333 := by decide +kernel

def env3137 : List Nat := [2,4,8,16,32,64,128,256,169,1024,0,4096,170,4469,131,5148,1345,0,1056,131,4096,163,5236,5531,295,5376,131,4469,1296,5522,1284,4294967296,256,4294972819,1345,428]

theorem envBound3137 : H12AffineFastState.Bounded env3137 := by
  intro p hp
  have h : env3137.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3136_3137 : H12AffineEnvironment.transform 8 169 env3136 = env3137 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 169 env3136 == env3137) = true)

theorem identity3137 : scanCanonicalize (H12AffineFastState.compose env3137 (packedSelected [1,3,5] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound3137 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env3138 : List Nat := [2,4,8,16,32,64,128,5,169,1024,0,4096,170,4208,131,5148,1092,0,1056,131,4096,163,5236,5278,34,5125,131,4208,1045,5271,1025,4294967296,5,4294972566,1092,169]

theorem envBound3138 : H12AffineFastState.Bounded env3138 := by
  intro p hp
  have h : env3138.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3137_3138 : H12AffineEnvironment.transform 7 5 env3137 = env3138 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env3137 == env3138) = true)

theorem identity3138 : scanCanonicalize (H12AffineFastState.compose env3138 (packedSelected [0,6] rootPS)) = affineNative (2^(11+1) ^^^ 1031) := by decide +kernel

theorem selectedBound3138 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env3139 : List Nat := [2,4,8,16,32,64,128,5,169,1024,0,1031,170,1143,131,27,1092,0,1056,131,1031,163,115,153,34,2,131,1143,1045,144,1025,4294967296,5,4294967441,1092,169]

theorem envBound3139 : H12AffineFastState.Bounded env3139 := by
  intro p hp
  have h : env3139.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3138_3139 : H12AffineEnvironment.transform 11 1031 env3138 = env3139 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1031 env3138 == env3139) = true)

theorem identity3139 : scanCanonicalize (H12AffineFastState.compose env3139 (packedSelected [0,7] rootPS)) = affineNative (2^(6+1) ^^^ 59) := by decide +kernel

theorem selectedBound3139 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env3140 : List Nat := [2,4,8,16,32,64,59,5,18,1024,0,1031,17,1143,56,27,1092,0,1056,56,1031,24,115,34,34,2,56,1143,1045,43,1025,4294967296,5,4294967338,1092,18]

theorem envBound3140 : H12AffineFastState.Bounded env3140 := by
  intro p hp
  have h : env3140.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3139_3140 : H12AffineEnvironment.transform 6 59 env3139 = env3140 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 59 env3139 == env3140) = true)

theorem identity3140 : scanCanonicalize (H12AffineFastState.compose env3140 (packedSelected [1,3,8] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound3140 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env3141 : List Nat := [2,4,8,16,0,64,27,5,18,1024,0,1031,17,1111,24,27,1092,0,1024,24,1031,24,83,2,2,2,24,1111,1045,11,1025,4294967296,5,4294967306,1092,18]

theorem envBound3141 : H12AffineFastState.Bounded env3141 := by
  intro p hp
  have h : env3141.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3140_3141 : H12AffineEnvironment.transform 4 0 env3140 = env3141 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env3140 == env3141) = true)

theorem identity3141 : scanCanonicalize (H12AffineFastState.compose env3141 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 10) := by decide +kernel

theorem selectedBound3141 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3142 : List Nat := [2,4,8,16,0,64,27,5,18,1024,0,1031,17,1111,24,27,1092,0,1024,24,1031,24,83,2,2,2,24,1111,1045,11,1025,10,5,0,1092,18]

theorem envBound3142 : H12AffineFastState.Bounded env3142 := by
  intro p hp
  have h : env3142.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3141_3142 : H12AffineEnvironment.transform 31 10 env3141 = env3142 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 10 env3141 == env3142) = true)

theorem identity3142 : scanCanonicalize (H12AffineFastState.compose env3142 (packedSelected [1,2] rootPS)) = affineNative (2^(9+1) ^^^ 31) := by decide +kernel

theorem selectedBound3142 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env3143 : List Nat := [2,4,8,16,0,64,27,5,18,31,0,24,17,72,24,27,91,0,31,24,24,24,83,2,2,2,24,72,10,11,30,10,5,0,91,18]

theorem envBound3143 : H12AffineFastState.Bounded env3143 := by
  intro p hp
  have h : env3143.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3142_3143 : H12AffineEnvironment.transform 9 31 env3142 = env3143 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 31 env3142 == env3143) = true)

def env3144 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,131072,1,524288,8832,2097152,8201,17665,206533,33554432,5376,2253852,16384,131153,35652789,131141,4294967296,256,4329271999,131072,33563272]

theorem envBound3144 : H12AffineFastState.Bounded env3144 := by
  intro p hp
  have h : env3144.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3112_3144 : H12AffineEnvironment.transform 17 1 env3112 = env3144 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env3112 == env3144) = true)

def env3145 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1344,1,524288,8832,2097152,8201,17665,74629,33554432,5376,2122076,16384,1297,35652789,1285,4294967296,256,4329142271,1344,33563272]

theorem envBound3145 : H12AffineFastState.Bounded env3145 := by
  intro p hp
  have h : env3145.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3144_3145 : H12AffineEnvironment.transform 16 1344 env3144 = env3145 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env3144 == env3145) = true)

theorem identity3145 : scanCanonicalize (H12AffineFastState.compose env3145 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(20+1) ^^^ 4096) := by decide +kernel

theorem selectedBound3145 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env3146 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1344,1,524288,8832,4096,8201,17665,74629,33554432,5376,29020,16384,1297,33559733,1285,4294967296,256,4329142271,1344,33563272]

theorem envBound3146 : H12AffineFastState.Bounded env3146 := by
  intro p hp
  have h : env3146.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3145_3146 : H12AffineEnvironment.transform 20 4096 env3145 = env3146 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env3145 == env3146) = true)

theorem identity3146 : scanCanonicalize (H12AffineFastState.compose env3146 (packedSelected [20] rootPS)) = affineNative (2^(24+1) ^^^ 5660) := by decide +kernel

theorem selectedBound3146 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env3147 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,16384,8832,65536,1344,1,524288,8832,4096,8201,17665,74629,5660,5376,29020,16384,1297,681,1285,4294967296,256,4295582179,1344,13460]

theorem envBound3147 : H12AffineFastState.Bounded env3147 := by
  intro p hp
  have h : env3147.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3146_3147 : H12AffineEnvironment.transform 24 5660 env3146 = env3147 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 5660 env3146 == env3147) = true)

theorem identity3147 : scanCanonicalize (H12AffineFastState.compose env3147 (packedSelected [5,8,12,13,15,17,24,28] rootPS)) = affineNative (2^(13+1) ^^^ 13301) := by decide +kernel

theorem selectedBound3147 : packedSelected [5,8,12,13,15,17,24,28] rootPS < 2^1333 := by decide +kernel

def env3148 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,13301,8832,65536,1344,1,524288,8832,4096,8201,14068,74629,5660,5376,681,13301,1297,681,1285,4294967296,256,4295561750,1344,13460]

theorem envBound3148 : H12AffineFastState.Bounded env3148 := by
  intro p hp
  have h : env3148.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3147_3148 : H12AffineEnvironment.transform 13 13301 env3147 = env3148 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 13301 env3147 == env3148) = true)

theorem identity3148 : scanCanonicalize (H12AffineFastState.compose env3148 (packedSelected [0,9,22,23,27] rootPS)) = affineNative (2^(11+1) ^^^ 1944) := by decide +kernel

theorem selectedBound3148 : packedSelected [0,9,22,23,27] rootPS < 2^1333 := by decide +kernel

def env3149 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1944,8192,9325,8832,65536,1344,1,524288,8832,1944,8201,8556,74629,388,664,681,9325,1297,681,1285,4294967296,256,4295558542,1344,8972]

theorem envBound3149 : H12AffineFastState.Bounded env3149 := by
  intro p hp
  have h : env3149.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3148_3149 : H12AffineEnvironment.transform 11 1944 env3148 = env3149 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env3148 == env3149) = true)

theorem identity3149 : scanCanonicalize (H12AffineFastState.compose env3149 (packedSelected [18] rootPS)) = affineNative (2^(12+1) ^^^ 269) := by decide +kernel

theorem selectedBound3149 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env3150 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1944,269,1376,909,65536,1344,1,524288,909,1944,260,97,66184,388,664,681,1376,1297,681,1285,4294967296,256,4295558542,1344,513]

theorem envBound3150 : H12AffineFastState.Bounded env3150 := by
  intro p hp
  have h : env3150.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3149_3150 : H12AffineEnvironment.transform 12 269 env3149 = env3150 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 269 env3149 == env3150) = true)

theorem identity3150 : scanCanonicalize (H12AffineFastState.compose env3150 (packedSelected [0,5,7,8,12,15] rootPS)) = affineNative (2^(15+1) ^^^ 547) := by decide +kernel

theorem selectedBound3150 : packedSelected [0,5,7,8,12,15] rootPS < 2^1333 := by decide +kernel

def env3151 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1944,269,1376,909,547,1344,1,524288,909,1944,260,97,171,388,664,681,1376,1297,681,1285,4294967296,256,4295493549,1344,513]

theorem envBound3151 : H12AffineFastState.Bounded env3151 := by
  intro p hp
  have h : env3151.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3150_3151 : H12AffineEnvironment.transform 15 547 env3150 = env3151 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 547 env3150 == env3151) = true)

theorem identity3151 : scanCanonicalize (H12AffineFastState.compose env3151 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(18+1) ^^^ 1024) := by decide +kernel

theorem selectedBound3151 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env3152 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1944,269,1376,909,547,1344,1,1024,909,1944,260,97,171,388,664,681,1376,1297,681,1285,4294967296,256,4294968237,1344,513]

theorem envBound3152 : H12AffineFastState.Bounded env3152 := by
  intro p hp
  have h : env3152.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3151_3152 : H12AffineEnvironment.transform 18 1024 env3151 = env3152 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env3151 == env3152) = true)

theorem identity3152 : scanCanonicalize (H12AffineFastState.compose env3152 (packedSelected [5,8] rootPS)) = affineNative (2^(8+1) ^^^ 168) := by decide +kernel

theorem selectedBound3152 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env3153 : List Nat := [2,4,8,16,32,64,128,256,168,1024,0,1328,269,1376,293,139,1344,1,1024,293,1328,260,97,171,388,48,1,1376,1297,1,1285,4294967296,256,4294967557,1344,169]

theorem envBound3153 : H12AffineFastState.Bounded env3153 := by
  intro p hp
  have h : env3153.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3152_3153 : H12AffineEnvironment.transform 8 168 env3152 = env3153 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 168 env3152 == env3153) = true)

theorem identity3153 : scanCanonicalize (H12AffineFastState.compose env3153 (packedSelected [1,10] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound3153 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env3154 : List Nat := [2,4,8,16,32,64,128,5,168,1024,0,1077,8,1125,32,139,1093,1,1024,32,1077,1,97,171,129,48,1,1125,1044,1,1024,4294967296,5,4294967296,1093,169]

theorem envBound3154 : H12AffineFastState.Bounded env3154 := by
  intro p hp
  have h : env3154.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3153_3154 : H12AffineEnvironment.transform 7 5 env3153 = env3154 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env3153 == env3154) = true)

theorem identity3154 : scanCanonicalize (H12AffineFastState.compose env3154 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 210) := by decide +kernel

theorem selectedBound3154 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3155 : List Nat := [2,4,8,16,32,64,128,5,168,1024,0,1077,8,1125,32,139,1093,1,1024,32,1077,1,97,171,129,48,1,1125,1044,1,1024,210,5,210,1093,169]

theorem envBound3155 : H12AffineFastState.Bounded env3155 := by
  intro p hp
  have h : env3155.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3154_3155 : H12AffineEnvironment.transform 31 210 env3154 = env3155 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 210 env3154 == env3155) = true)

end H12GlobalChart2
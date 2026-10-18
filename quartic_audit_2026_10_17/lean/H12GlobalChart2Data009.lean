import H12GlobalChart2Data008

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem selectedBound2162 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2163 : List Nat := [2,4,8,11,32,11,128,134,137,141,0,1,139,0,1,8,1,162,140,1,0,131,11,139,2,10,162,1,0,1,15,0,134,163,0,136]

theorem envBound2163 : H12AffineFastState.Bounded env2163 := by
  intro p hp
  have h : env2163.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2162_2163 : H12AffineEnvironment.transform 9 141 env2162 = env2163 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 141 env2162 == env2163) = true)

theorem identity2163 : scanCanonicalize (H12AffineFastState.compose env2163 (packedSelected [10] rootPS)) = affineNative (2^(6+1) ^^^ 34) := by decide +kernel

theorem selectedBound2163 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env2164 : List Nat := [2,4,8,11,32,11,34,36,43,47,0,1,41,0,1,8,1,0,46,1,0,33,11,41,2,10,0,1,0,1,15,0,36,1,0,42]

theorem envBound2164 : H12AffineFastState.Bounded env2164 := by
  intro p hp
  have h : env2164.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2163_2164 : H12AffineEnvironment.transform 6 34 env2163 = env2164 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 34 env2163 == env2164) = true)

theorem identity2164 : scanCanonicalize (H12AffineFastState.compose env2164 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound2164 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2165 : List Nat := [2,4,2,1,32,1,34,36,33,37,0,1,35,0,1,2,1,0,36,1,0,33,1,35,2,0,0,1,0,1,5,0,36,1,0,32]

theorem envBound2165 : H12AffineFastState.Bounded env2165 := by
  intro p hp
  have h : env2165.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2164_2165 : H12AffineEnvironment.transform 2 2 env2164 = env2165 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env2164 == env2165) = true)

def env2166 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,131072,41001,108043,32768,4097,8200,5457,230469,8329,5376,164965,4176,131153,649,131141,4294967296,256,4295100140,131073,513]

theorem envBound2166 : H12AffineFastState.Bounded env2166 := by
  intro p hp
  have h : env2166.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2151_2166 : H12AffineEnvironment.transform 17 41001 env2151 = env2166 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41001 env2151 == env2166) = true)

theorem identity2166 : scanCanonicalize (H12AffineFastState.compose env2166 (packedSelected [20,23] rootPS)) = affineNative (2^(16+1) ^^^ 9924) := by decide +kernel

theorem selectedBound2166 : packedSelected [20,23] rootPS < 2^1333 := by decide +kernel

def env2167 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,9924,41001,108043,32768,4097,8200,5457,107137,8329,5376,41633,4176,9877,649,9857,4294967296,256,4294975528,9925,513]

theorem envBound2167 : H12AffineFastState.Bounded env2167 := by
  intro p hp
  have h : env2167.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2166_2167 : H12AffineEnvironment.transform 16 9924 env2166 = env2167 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 9924 env2166 == env2167) = true)

def env2168 : List Nat := [2,4,8,16,32,64,88,256,512,1024,0,4096,8192,4177,32768,65536,9756,41001,108043,32768,4097,8200,5457,107097,8273,5376,41593,4176,9805,593,9817,4294967296,256,4294975528,9757,513]

theorem envBound2168 : H12AffineFastState.Bounded env2168 := by
  intro p hp
  have h : env2168.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2167_2168 : H12AffineEnvironment.transform 6 88 env2167 = env2168 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env2167 == env2168) = true)

theorem identity2168 : scanCanonicalize (H12AffineFastState.compose env2168 (packedSelected [5,8,10,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 13341) := by decide +kernel

theorem selectedBound2168 : packedSelected [5,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env2169 : List Nat := [2,4,8,16,32,64,88,256,512,1024,0,4096,8192,4177,13341,65536,9756,5172,70166,13341,4097,8200,5457,71236,8273,5376,5732,4176,9805,593,9817,4294967296,256,4294975528,9757,513]

theorem envBound2169 : H12AffineFastState.Bounded env2169 := by
  intro p hp
  have h : env2169.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2168_2169 : H12AffineEnvironment.transform 14 13341 env2168 = env2169 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13341 env2168 == env2169) = true)

theorem identity2169 : scanCanonicalize (H12AffineFastState.compose env2169 (packedSelected [0,4,5,7,8,9] rootPS)) = affineNative (2^(12+1) ^^^ 860) := by decide +kernel

theorem selectedBound2169 : packedSelected [0,4,5,7,8,9] rootPS < 2^1333 := by decide +kernel

def env2170 : List Nat := [2,4,8,16,32,64,88,256,512,1024,0,4096,860,4177,5953,65536,1344,5172,70166,5953,4097,852,5457,71236,781,5376,5732,4176,1297,593,1285,4294967296,256,4294968180,1345,513]

theorem envBound2170 : H12AffineFastState.Bounded env2170 := by
  intro p hp
  have h : env2170.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2169_2170 : H12AffineEnvironment.transform 12 860 env2169 = env2170 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 860 env2169 == env2170) = true)

theorem identity2170 : scanCanonicalize (H12AffineFastState.compose env2170 (packedSelected [0,5,6] rootPS)) = affineNative (2^(11+1) ^^^ 1076) := by decide +kernel

theorem selectedBound2170 : packedSelected [0,5,6] rootPS < 2^1333 := by decide +kernel

def env2171 : List Nat := [2,4,8,16,32,64,88,256,512,1024,0,1076,860,1125,885,65536,1344,0,67106,885,1077,852,357,66160,781,308,592,1124,1297,593,1285,4294967296,256,4294968180,1345,513]

theorem envBound2171 : H12AffineFastState.Bounded env2171 := by
  intro p hp
  have h : env2171.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2170_2171 : H12AffineEnvironment.transform 11 1076 env2170 = env2171 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1076 env2170 == env2171) = true)

theorem identity2171 : scanCanonicalize (H12AffineFastState.compose env2171 (packedSelected [0,7] rootPS)) = affineNative (2^(8+1) ^^^ 81) := by decide +kernel

theorem selectedBound2171 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env2172 : List Nat := [2,4,8,16,32,64,88,256,81,1024,0,1076,269,1125,292,65536,1344,0,66675,292,1077,261,357,65569,348,308,1,1124,1297,0,1285,4294967296,256,4294967589,1345,80]

theorem envBound2172 : H12AffineFastState.Bounded env2172 := by
  intro p hp
  have h : env2172.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2171_2172 : H12AffineEnvironment.transform 8 81 env2171 = env2172 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 81 env2171 == env2172) = true)

def env2173 : List Nat := [2,4,8,16,32,64,88,36,81,1024,0,1076,41,1125,0,65536,1124,0,66675,0,1077,33,65,65569,120,16,1,1124,1077,0,1057,4294967296,36,4294967297,1125,80]

theorem envBound2173 : H12AffineFastState.Bounded env2173 := by
  intro p hp
  have h : env2173.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2172_2173 : H12AffineEnvironment.transform 7 36 env2172 = env2173 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env2172 == env2173) = true)

theorem identity2173 : scanCanonicalize (H12AffineFastState.compose env2173 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 65544) := by decide +kernel

theorem selectedBound2173 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2174 : List Nat := [2,4,8,16,32,64,88,36,81,1024,0,1076,41,1125,0,65536,1124,0,66675,0,1077,33,65,65569,120,16,1,1124,1077,0,1057,65544,36,65545,1125,80]

theorem envBound2174 : H12AffineFastState.Bounded env2174 := by
  intro p hp
  have h : env2174.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2173_2174 : H12AffineEnvironment.transform 31 65544 env2173 = env2174 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65544 env2173 == env2174) = true)

theorem identity2174 : scanCanonicalize (H12AffineFastState.compose env2174 (packedSelected [4] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound2174 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env2175 : List Nat := [2,4,8,0,32,64,72,36,65,1024,0,1060,41,1125,0,65536,1124,0,66659,0,1061,33,65,65569,104,0,1,1124,1061,0,1057,65544,36,65545,1125,64]

theorem envBound2175 : H12AffineFastState.Bounded env2175 := by
  intro p hp
  have h : env2175.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2174_2175 : H12AffineEnvironment.transform 3 0 env2174 = env2175 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env2174 == env2175) = true)

def env2176 : List Nat := [2,4,8,0,32,64,72,36,65,1024,0,1060,41,1125,0,8,1124,0,1131,0,1061,33,65,41,104,0,1,1124,1061,0,1057,0,36,1,1125,64]

theorem envBound2176 : H12AffineFastState.Bounded env2176 := by
  intro p hp
  have h : env2176.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2175_2176 : H12AffineEnvironment.transform 15 8 env2175 = env2176 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8 env2175 == env2176) = true)

def env2177 : List Nat := [2,4,8,0,32,64,72,36,65,1024,0,1060,41,1125,0,9,1124,0,1130,0,1061,33,65,40,104,0,1,1124,1061,0,1057,1,36,0,1125,64]

theorem envBound2177 : H12AffineFastState.Bounded env2177 := by
  intro p hp
  have h : env2177.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2175_2177 : H12AffineEnvironment.transform 15 9 env2175 = env2177 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 9 env2175 == env2177) = true)

theorem identity2177 : scanCanonicalize (H12AffineFastState.compose env2177 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 42) := by decide +kernel

theorem selectedBound2177 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2178 : List Nat := [2,4,8,0,32,42,34,36,43,1024,0,1060,41,1039,0,9,1038,0,1024,0,1061,33,43,40,2,0,1,1038,1061,0,1057,1,36,0,1039,42]

theorem envBound2178 : H12AffineFastState.Bounded env2178 := by
  intro p hp
  have h : env2178.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2177_2178 : H12AffineEnvironment.transform 5 42 env2177 = env2178 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 42 env2177 == env2178) = true)

theorem identity2178 : scanCanonicalize (H12AffineFastState.compose env2178 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound2178 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2179 : List Nat := [2,4,8,0,0,10,2,4,11,1024,0,1028,9,1039,0,9,1038,0,1024,0,1029,1,11,8,2,0,1,1038,1029,0,1025,1,4,0,1039,10]

theorem envBound2179 : H12AffineFastState.Bounded env2179 := by
  intro p hp
  have h : env2179.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2178_2179 : H12AffineEnvironment.transform 4 0 env2178 = env2179 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env2178 == env2179) = true)

def leafEnv2179 : List Nat := [2,4,8,0,0,10,2,4,11,1024,0,1028,9,1039,0,9,1038,0,1024,0,1029,1,11,8,1025,2,1,0,1,1038,1029,0,1025,1,4,0,4,2,1039,10,0,1028,1]

def active2179 : List Nat := [0,1,2,9]

def tree2179 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2179 : H12WitnessSearch.Good tree2179 := H12GlobalWitnessIndex.good

theorem leafIdentity2179 : H12AffineFastState.composeSystem env2179 rootObs = leafEnv2179 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2179 rootObs == leafEnv2179) = true)

theorem terminalChecked2179 : H12PackedTerminal.terminalCheckFast leafEnv2179 active2179 tree2179 = true := by decide +kernel

def env2180 : List Nat := [2,4,8,16,32,64,88,37,81,1024,0,1076,40,1125,1,65536,1125,0,66675,1,1077,32,64,65569,121,17,1,1124,1076,0,1056,4294967296,37,4294967296,1124,80]

theorem envBound2180 : H12AffineFastState.Bounded env2180 := by
  intro p hp
  have h : env2180.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2172_2180 : H12AffineEnvironment.transform 7 37 env2172 = env2180 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env2172 == env2180) = true)

theorem identity2180 : scanCanonicalize (H12AffineFastState.compose env2180 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 42) := by decide +kernel

theorem selectedBound2180 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2181 : List Nat := [2,4,8,16,32,64,88,37,81,1024,0,1076,40,1125,1,65536,1125,0,66675,1,1077,32,64,65569,121,17,1,1124,1076,0,1056,42,37,42,1124,80]

theorem envBound2181 : H12AffineFastState.Bounded env2181 := by
  intro p hp
  have h : env2181.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2180_2181 : H12AffineEnvironment.transform 31 42 env2180 = env2181 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 42 env2180 == env2181) = true)

theorem identity2181 : scanCanonicalize (H12AffineFastState.compose env2181 (packedSelected [4] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound2181 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env2182 : List Nat := [2,4,8,16,32,11,19,37,26,1024,0,1076,40,1070,1,65536,1070,0,66616,1,1077,32,11,65569,50,17,1,1071,1076,0,1056,42,37,42,1071,27]

theorem envBound2182 : H12AffineFastState.Bounded env2182 := by
  intro p hp
  have h : env2182.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2181_2182 : H12AffineEnvironment.transform 5 11 env2181 = env2182 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env2181 == env2182) = true)

theorem identity2182 : scanCanonicalize (H12AffineFastState.compose env2182 (packedSelected [1,2] rootPS)) = affineNative (2^(15+1) ^^^ 51) := by decide +kernel

theorem selectedBound2182 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env2183 : List Nat := [2,4,8,16,32,11,19,37,26,1024,0,1076,40,1070,1,51,1070,0,1035,1,1077,32,11,18,50,17,1,1071,1076,0,1056,42,37,42,1071,27]

theorem envBound2183 : H12AffineFastState.Bounded env2183 := by
  intro p hp
  have h : env2183.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2182_2183 : H12AffineEnvironment.transform 15 51 env2182 = env2183 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 51 env2182 == env2183) = true)

def env2184 : List Nat := [2,4,8,16,0,11,19,5,26,1024,0,1044,8,1038,1,19,1038,0,1035,1,1045,0,11,18,18,17,1,1039,1044,0,1024,10,5,10,1039,27]

theorem envBound2184 : H12AffineFastState.Bounded env2184 := by
  intro p hp
  have h : env2184.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2183_2184 : H12AffineEnvironment.transform 4 0 env2183 = env2184 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env2183 == env2184) = true)

def env2185 : List Nat := [2,4,8,16,1,11,19,4,26,1024,0,1045,9,1039,1,18,1039,0,1035,1,1044,1,11,18,19,17,1,1038,1045,0,1025,11,4,11,1038,27]

theorem envBound2185 : H12AffineFastState.Bounded env2185 := by
  intro p hp
  have h : env2185.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2183_2185 : H12AffineEnvironment.transform 4 1 env2183 = env2185 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env2183 == env2185) = true)

theorem identity2185 : scanCanonicalize (H12AffineFastState.compose env2185 (packedSelected [1] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound2185 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2186 : List Nat := [2,4,3,16,1,0,19,4,17,1024,0,1045,2,1028,1,18,1028,0,1024,1,1044,1,0,18,19,17,1,1029,1045,0,1025,0,4,0,1029,16]

theorem envBound2186 : H12AffineFastState.Bounded env2186 := by
  intro p hp
  have h : env2186.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2185_2186 : H12AffineEnvironment.transform 2 3 env2185 = env2186 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env2185 == env2186) = true)

def leafEnv2186 : List Nat := [2,4,3,16,1,0,19,4,17,1024,0,1045,2,1028,1,18,1028,0,1024,1,1044,1,0,18,1025,19,1,17,1,1029,1045,0,1025,0,4,0,4,3,1029,16,0,1044,1]

def active2186 : List Nat := [0,1,3,9]

def tree2186 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2186 : H12WitnessSearch.Good tree2186 := H12GlobalWitnessIndex.good

theorem leafIdentity2186 : H12AffineFastState.composeSystem env2186 rootObs = leafEnv2186 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2186 rootObs == leafEnv2186) = true)

theorem terminalChecked2186 : H12PackedTerminal.terminalCheckFast leafEnv2186 active2186 tree2186 = true := by decide +kernel

def env2187 : List Nat := [2,4,8,16,32,64,89,256,512,1024,0,4096,8192,4177,32768,65536,9757,41001,108043,32768,4097,8200,5457,107096,8272,5376,41592,4176,9804,592,9816,4294967296,256,4294975528,9756,513]

theorem envBound2187 : H12AffineFastState.Bounded env2187 := by
  intro p hp
  have h : env2187.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2167_2187 : H12AffineEnvironment.transform 6 89 env2167 = env2187 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env2167 == env2187) = true)

theorem identity2187 : scanCanonicalize (H12AffineFastState.compose env2187 (packedSelected [5,8,10,12,13] rootPS)) = affineNative (2^(15+1) ^^^ 5655) := by decide +kernel

theorem selectedBound2187 : packedSelected [5,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env2188 : List Nat := [2,4,8,16,32,64,89,256,512,1024,0,4096,8192,4177,32768,5655,9757,41001,45084,32768,4097,8200,5457,46159,8272,5376,41592,4176,9804,592,9816,4294967296,256,4294975528,9756,513]

theorem envBound2188 : H12AffineFastState.Bounded env2188 := by
  intro p hp
  have h : env2188.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2187_2188 : H12AffineEnvironment.transform 15 5655 env2187 = env2188 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5655 env2187 == env2188) = true)

theorem identity2188 : scanCanonicalize (H12AffineFastState.compose env2188 (packedSelected [0,5,7,8,16] rootPS)) = affineNative (2^(12+1) ^^^ 861) := by decide +kernel

theorem selectedBound2188 : packedSelected [0,5,7,8,16] rootPS < 2^1333 := by decide +kernel

def env2189 : List Nat := [2,4,8,16,32,64,89,256,512,1024,0,4096,861,4177,32768,5655,1344,33652,37697,32768,4097,853,5457,38674,781,5376,33061,4176,1297,592,1285,4294967296,256,4294968181,1345,513]

theorem envBound2189 : H12AffineFastState.Bounded env2189 := by
  intro p hp
  have h : env2189.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2188_2189 : H12AffineEnvironment.transform 12 861 env2188 = env2189 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 861 env2188 == env2189) = true)

theorem identity2189 : scanCanonicalize (H12AffineFastState.compose env2189 (packedSelected [0,5,6] rootPS)) = affineNative (2^(14+1) ^^^ 292) := by decide +kernel

theorem selectedBound2189 : packedSelected [0,5,6] rootPS < 2^1333 := by decide +kernel

def env2190 : List Nat := [2,4,8,16,32,64,89,256,512,1024,0,4096,861,4177,292,5655,1344,592,4709,292,4097,853,5457,5686,781,5376,1,4176,1297,592,1285,4294967296,256,4294968181,1345,513]

theorem envBound2190 : H12AffineFastState.Bounded env2190 := by
  intro p hp
  have h : env2190.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2189_2190 : H12AffineEnvironment.transform 14 292 env2189 = env2190 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 292 env2189 == env2190) = true)

theorem identity2190 : scanCanonicalize (H12AffineFastState.compose env2190 (packedSelected [0,7] rootPS)) = affineNative (2^(8+1) ^^^ 80) := by decide +kernel

theorem selectedBound2190 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env2191 : List Nat := [2,4,8,16,32,64,89,256,80,1024,0,4096,269,4177,292,5191,1344,0,4149,292,4097,261,5457,5222,349,5376,1,4176,1297,0,1285,4294967296,256,4294967589,1345,81]

theorem envBound2191 : H12AffineFastState.Bounded env2191 := by
  intro p hp
  have h : env2191.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2190_2191 : H12AffineEnvironment.transform 8 80 env2190 = env2191 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 80 env2190 == env2191) = true)

theorem identity2191 : scanCanonicalize (H12AffineFastState.compose env2191 (packedSelected [1,2,4,10] rootPS)) = affineNative (2^(11+1) ^^^ 1076) := by decide +kernel

theorem selectedBound2191 : packedSelected [1,2,4,10] rootPS < 2^1333 := by decide +kernel

def env2192 : List Nat := [2,4,8,16,32,64,89,256,80,1024,0,1076,269,1125,292,115,1344,0,1025,292,1077,261,357,82,349,308,1,1124,1297,0,1285,4294967296,256,4294967589,1345,81]

theorem envBound2192 : H12AffineFastState.Bounded env2192 := by
  intro p hp
  have h : env2192.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2191_2192 : H12AffineEnvironment.transform 11 1076 env2191 = env2192 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1076 env2191 == env2192) = true)

theorem identity2192 : scanCanonicalize (H12AffineFastState.compose env2192 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 107) := by decide +kernel

theorem selectedBound2192 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2193 : List Nat := [2,4,8,16,32,64,89,256,80,1024,0,1076,269,1125,292,115,1344,0,1025,292,1077,261,357,82,349,308,1,1124,1297,0,1285,107,256,334,1345,81]

theorem envBound2193 : H12AffineFastState.Bounded env2193 := by
  intro p hp
  have h : env2193.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2192_2193 : H12AffineEnvironment.transform 31 107 env2192 = env2193 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 107 env2192 == env2193) = true)

def env2194 : List Nat := [2,4,8,16,32,16,9,256,0,1024,0,1076,269,1077,292,35,1296,0,1025,292,1077,261,309,2,269,308,1,1076,1297,0,1285,59,256,286,1297,1]

theorem envBound2194 : H12AffineFastState.Bounded env2194 := by
  intro p hp
  have h : env2194.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2193_2194 : H12AffineEnvironment.transform 5 16 env2193 = env2194 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env2193 == env2194) = true)

theorem identity2194 : scanCanonicalize (H12AffineFastState.compose env2194 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 53) := by decide +kernel

theorem selectedBound2194 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2195 : List Nat := [2,4,8,16,32,16,9,53,0,1024,0,1076,56,1077,17,35,1061,0,1025,17,1077,48,0,2,56,1,1,1076,1060,0,1072,59,53,43,1060,1]

theorem envBound2195 : H12AffineFastState.Bounded env2195 := by
  intro p hp
  have h : env2195.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2194_2195 : H12AffineEnvironment.transform 7 53 env2194 = env2195 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 53 env2194 == env2195) = true)

def env2196 : List Nat := [2,4,8,0,32,0,9,37,0,1024,0,1060,40,1061,1,35,1061,0,1025,1,1061,32,0,2,40,1,1,1060,1060,0,1056,43,37,43,1060,1]

theorem envBound2196 : H12AffineFastState.Bounded env2196 := by
  intro p hp
  have h : env2196.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2195_2196 : H12AffineEnvironment.transform 3 0 env2195 = env2196 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env2195 == env2196) = true)

theorem identity2196 : scanCanonicalize (H12AffineFastState.compose env2196 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound2196 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2197 : List Nat := [2,4,3,0,32,0,2,37,0,1024,0,1060,35,1061,1,35,1061,0,1025,1,1061,32,0,2,35,1,1,1060,1060,0,1056,32,37,32,1060,1]

theorem envBound2197 : H12AffineFastState.Bounded env2197 := by
  intro p hp
  have h : env2197.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2196_2197 : H12AffineEnvironment.transform 2 3 env2196 = env2197 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env2196 == env2197) = true)

def leafEnv2197 : List Nat := [2,4,3,0,32,0,2,37,0,1024,0,1060,35,1061,1,35,1061,0,1025,1,1061,32,0,2,1057,35,1,1,1,1060,1060,0,1056,32,37,32,4,34,1060,1,0,1061,1]

def active2197 : List Nat := [0,1,4,9]

def tree2197 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2197 : H12WitnessSearch.Good tree2197 := H12GlobalWitnessIndex.good

theorem leafIdentity2197 : H12AffineFastState.composeSystem env2197 rootObs = leafEnv2197 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2197 rootObs == leafEnv2197) = true)

theorem terminalChecked2197 : H12PackedTerminal.terminalCheckFast leafEnv2197 active2197 tree2197 = true := by decide +kernel

def env2198 : List Nat := [2,4,8,1,32,1,9,36,0,1024,0,1061,41,1060,0,35,1061,0,1025,0,1060,33,0,2,41,1,1,1061,1060,0,1057,42,36,43,1060,1]

theorem envBound2198 : H12AffineFastState.Bounded env2198 := by
  intro p hp
  have h : env2198.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2195_2198 : H12AffineEnvironment.transform 3 1 env2195 = env2198 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env2195 == env2198) = true)

def leafEnv2198 : List Nat := [2,4,8,1,32,1,9,36,0,1024,0,1061,41,1060,0,35,1061,0,1025,0,1060,33,0,2,1056,41,1,1,1,1061,1060,0,1057,42,36,43,4,34,1060,1,0,1061,1]

def active2198 : List Nat := [0,1,2,4,9]

def tree2198 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2198 : H12WitnessSearch.Good tree2198 := H12GlobalWitnessIndex.good

theorem leafIdentity2198 : H12AffineFastState.composeSystem env2198 rootObs = leafEnv2198 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2198 rootObs == leafEnv2198) = true)

theorem terminalChecked2198 : H12PackedTerminal.terminalCheckFast leafEnv2198 active2198 tree2198 = true := by decide +kernel

def env2199 : List Nat := [2,4,8,16,32,17,8,256,1,1024,0,1076,269,1076,292,34,1297,0,1025,292,1077,261,308,3,268,308,1,1077,1297,0,1285,58,256,287,1296,0]

theorem envBound2199 : H12AffineFastState.Bounded env2199 := by
  intro p hp
  have h : env2199.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2193_2199 : H12AffineEnvironment.transform 5 17 env2193 = env2199 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env2193 == env2199) = true)

theorem identity2199 : scanCanonicalize (H12AffineFastState.compose env2199 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound2199 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2200 : List Nat := [2,4,8,1,32,0,8,256,1,1024,0,1061,269,1061,292,34,1280,0,1025,292,1060,261,293,3,268,293,1,1060,1280,0,1285,43,256,270,1281,0]

theorem envBound2200 : H12AffineFastState.Bounded env2200 := by
  intro p hp
  have h : env2200.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2199_2200 : H12AffineEnvironment.transform 3 1 env2199 = env2200 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env2199 == env2200) = true)

def env2201 : List Nat := [2,4,8,1,32,0,8,36,1,1024,0,1061,41,1061,0,34,1060,0,1025,0,1060,33,1,3,40,1,1,1060,1060,0,1057,43,36,42,1061,0]

theorem envBound2201 : H12AffineFastState.Bounded env2201 := by
  intro p hp
  have h : env2201.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2200_2201 : H12AffineEnvironment.transform 7 36 env2200 = env2201 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env2200 == env2201) = true)

def leafEnv2201 : List Nat := [2,4,8,1,32,0,8,36,1,1024,0,1061,41,1061,0,34,1060,0,1025,0,1060,33,1,3,1056,40,1,1,1,1060,1060,0,1057,43,36,42,4,34,1061,0,0,1061,1]

def active2201 : List Nat := [0,1,2,4,9]

def tree2201 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2201 : H12WitnessSearch.Good tree2201 := H12GlobalWitnessIndex.good

theorem leafIdentity2201 : H12AffineFastState.composeSystem env2201 rootObs = leafEnv2201 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2201 rootObs == leafEnv2201) = true)

theorem terminalChecked2201 : H12PackedTerminal.terminalCheckFast leafEnv2201 active2201 tree2201 = true := by decide +kernel

def env2202 : List Nat := [2,4,8,1,32,0,8,37,1,1024,0,1061,40,1061,1,34,1061,0,1025,1,1060,32,0,3,41,0,1,1060,1061,0,1056,43,37,43,1060,0]

theorem envBound2202 : H12AffineFastState.Bounded env2202 := by
  intro p hp
  have h : env2202.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2200_2202 : H12AffineEnvironment.transform 7 37 env2200 = env2202 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env2200 == env2202) = true)

theorem identity2202 : scanCanonicalize (H12AffineFastState.compose env2202 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound2202 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2203 : List Nat := [2,4,3,1,32,0,3,37,1,1024,0,1061,35,1061,1,34,1061,0,1025,1,1060,32,0,3,34,0,1,1060,1061,0,1056,32,37,32,1060,0]

theorem envBound2203 : H12AffineFastState.Bounded env2203 := by
  intro p hp
  have h : env2203.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2202_2203 : H12AffineEnvironment.transform 2 3 env2202 = env2203 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env2202 == env2203) = true)

def leafEnv2203 : List Nat := [2,4,3,1,32,0,3,37,1,1024,0,1061,35,1061,1,34,1061,0,1025,1,1060,32,0,3,1057,34,1,0,1,1060,1061,0,1056,32,37,32,4,34,1060,0,0,1060,1]

def active2203 : List Nat := [0,1,4,9]

def tree2203 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2203 : H12WitnessSearch.Good tree2203 := H12GlobalWitnessIndex.good

theorem leafIdentity2203 : H12AffineFastState.composeSystem env2203 rootObs = leafEnv2203 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2203 rootObs == leafEnv2203) = true)

theorem terminalChecked2203 : H12PackedTerminal.terminalCheckFast leafEnv2203 active2203 tree2203 = true := by decide +kernel

def env2204 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,8200,5457,230469,8329,5377,402509,4177,131152,631939,131140,4294967296,257,4295729382,131073,513]

theorem envBound2204 : H12AffineFastState.Bounded env2204 := by
  intro p hp
  have h : env2204.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2149_2204 : H12AffineEnvironment.transform 25 5377 env2149 = env2204 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env2149 == env2204) = true)

theorem identity2204 : scanCanonicalize (H12AffineFastState.compose env2204 (packedSelected [11] rootPS)) = affineNative (2^(18+1) ^^^ 463667) := by decide +kernel

theorem selectedBound2204 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env2205 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,131072,262144,463667,32768,4097,8200,5457,230469,8329,5377,402509,4177,131152,440240,131140,4294967296,257,4295275477,131073,513]

theorem envBound2205 : H12AffineFastState.Bounded env2205 := by
  intro p hp
  have h : env2205.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2204_2205 : H12AffineEnvironment.transform 18 463667 env2204 = env2205 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 463667 env2204 == env2205) = true)

theorem identity2205 : scanCanonicalize (H12AffineFastState.compose env2205 (packedSelected [6,25] rootPS)) = affineNative (2^(17+1) ^^^ 202547) := by decide +kernel

theorem selectedBound2205 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env2206 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,131072,202547,1024,32768,4097,8200,5457,230469,8329,5377,78718,4177,131152,106627,131140,4294967296,257,4295206118,131073,513]

theorem envBound2206 : H12AffineFastState.Bounded env2206 := by
  intro p hp
  have h : env2206.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2205_2206 : H12AffineEnvironment.transform 17 202547 env2205 = env2206 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 202547 env2205 == env2206) = true)

def env2207 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,8201,5457,230469,8329,67108864,67514701,67110224,67245393,67744130,67245381,4294967296,67113984,4362843622,131073,513]

theorem envBound2207 : H12AffineFastState.Bounded env2207 := by
  intro p hp
  have h : env2207.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2148_2207 : H12AffineEnvironment.transform 10 1 env2148 = env2207 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env2148 == env2207) = true)

def env2208 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,8201,5457,230469,8329,5376,402509,4176,131153,631938,131141,4294967296,256,4295729382,131073,513]

theorem envBound2208 : H12AffineFastState.Bounded env2208 := by
  intro p hp
  have h : env2208.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2207_2208 : H12AffineEnvironment.transform 25 5376 env2207 = env2208 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env2207 == env2208) = true)

theorem identity2208 : scanCanonicalize (H12AffineFastState.compose env2208 (packedSelected [11] rootPS)) = affineNative (2^(18+1) ^^^ 108042) := by decide +kernel

theorem selectedBound2208 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env2209 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,131072,262144,108042,32768,4097,8201,5457,230469,8329,5376,402509,4176,131153,648,131141,4294967296,256,4295100140,131073,513]

theorem envBound2209 : H12AffineFastState.Bounded env2209 := by
  intro p hp
  have h : env2209.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2208_2209 : H12AffineEnvironment.transform 18 108042 env2208 = env2209 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 108042 env2208 == env2209) = true)

def env2210 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,131072,41000,108042,32768,4097,8201,5457,230469,8329,5376,164965,4176,131153,648,131141,4294967296,256,4295100140,131073,513]

theorem envBound2210 : H12AffineFastState.Bounded env2210 := by
  intro p hp
  have h : env2210.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2209_2210 : H12AffineEnvironment.transform 17 41000 env2209 = env2210 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41000 env2209 == env2210) = true)

theorem identity2210 : scanCanonicalize (H12AffineFastState.compose env2210 (packedSelected [20,23] rootPS)) = affineNative (2^(16+1) ^^^ 9925) := by decide +kernel

theorem selectedBound2210 : packedSelected [20,23] rootPS < 2^1333 := by decide +kernel

def env2211 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,9925,41000,108042,32768,4097,8201,5457,107136,8329,5376,41632,4176,9876,648,9856,4294967296,256,4294975529,9924,513]

theorem envBound2211 : H12AffineFastState.Bounded env2211 := by
  intro p hp
  have h : env2211.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2210_2211 : H12AffineEnvironment.transform 16 9925 env2210 = env2211 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 9925 env2210 == env2211) = true)

def env2212 : List Nat := [2,4,8,16,32,64,88,256,512,1024,1,4096,8192,4177,32768,65536,9757,41000,108042,32768,4097,8201,5457,107096,8273,5376,41592,4176,9804,592,9816,4294967296,256,4294975529,9756,513]

theorem envBound2212 : H12AffineFastState.Bounded env2212 := by
  intro p hp
  have h : env2212.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2211_2212 : H12AffineEnvironment.transform 6 88 env2211 = env2212 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env2211 == env2212) = true)

theorem identity2212 : scanCanonicalize (H12AffineFastState.compose env2212 (packedSelected [5,8,10,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 13341) := by decide +kernel

theorem selectedBound2212 : packedSelected [5,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env2213 : List Nat := [2,4,8,16,32,64,88,256,512,1024,1,4096,8192,4177,13341,65536,9757,5173,70167,13341,4097,8201,5457,71237,8273,5376,5733,4176,9804,592,9816,4294967296,256,4294975529,9756,513]

theorem envBound2213 : H12AffineFastState.Bounded env2213 := by
  intro p hp
  have h : env2213.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2212_2213 : H12AffineEnvironment.transform 14 13341 env2212 = env2213 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13341 env2212 == env2213) = true)

theorem identity2213 : scanCanonicalize (H12AffineFastState.compose env2213 (packedSelected [0,4,5,7,8,9] rootPS)) = affineNative (2^(12+1) ^^^ 861) := by decide +kernel

theorem selectedBound2213 : packedSelected [0,4,5,7,8,9] rootPS < 2^1333 := by decide +kernel

def env2214 : List Nat := [2,4,8,16,32,64,88,256,512,1024,1,4096,861,4177,5952,65536,1344,5173,70167,5952,4097,852,5457,71237,780,5376,5733,4176,1297,592,1285,4294967296,256,4294968180,1345,513]

theorem envBound2214 : H12AffineFastState.Bounded env2214 := by
  intro p hp
  have h : env2214.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2213_2214 : H12AffineEnvironment.transform 12 861 env2213 = env2214 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 861 env2213 == env2214) = true)

theorem identity2214 : scanCanonicalize (H12AffineFastState.compose env2214 (packedSelected [0,5,6] rootPS)) = affineNative (2^(11+1) ^^^ 1076) := by decide +kernel

theorem selectedBound2214 : packedSelected [0,5,6] rootPS < 2^1333 := by decide +kernel

def env2215 : List Nat := [2,4,8,16,32,64,88,256,512,1024,1,1076,861,1125,884,65536,1344,1,67107,884,1077,852,357,66161,780,308,593,1124,1297,592,1285,4294967296,256,4294968180,1345,513]

theorem envBound2215 : H12AffineFastState.Bounded env2215 := by
  intro p hp
  have h : env2215.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2214_2215 : H12AffineEnvironment.transform 11 1076 env2214 = env2215 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1076 env2214 == env2215) = true)

theorem identity2215 : scanCanonicalize (H12AffineFastState.compose env2215 (packedSelected [0,7] rootPS)) = affineNative (2^(8+1) ^^^ 81) := by decide +kernel

theorem selectedBound2215 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env2216 : List Nat := [2,4,8,16,32,64,88,256,81,1024,1,1076,268,1125,293,65536,1344,1,66674,293,1077,261,357,65568,349,308,0,1124,1297,1,1285,4294967296,256,4294967589,1345,80]

theorem envBound2216 : H12AffineFastState.Bounded env2216 := by
  intro p hp
  have h : env2216.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2215_2216 : H12AffineEnvironment.transform 8 81 env2215 = env2216 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 81 env2215 == env2216) = true)

def env2217 : List Nat := [2,4,8,16,32,64,88,36,81,1024,1,1076,40,1125,1,65536,1124,1,66674,1,1077,33,65,65568,121,16,0,1124,1077,1,1057,4294967296,36,4294967297,1125,80]

theorem envBound2217 : H12AffineFastState.Bounded env2217 := by
  intro p hp
  have h : env2217.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2216_2217 : H12AffineEnvironment.transform 7 36 env2216 = env2217 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env2216 == env2217) = true)

theorem identity2217 : scanCanonicalize (H12AffineFastState.compose env2217 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 122) := by decide +kernel

theorem selectedBound2217 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2218 : List Nat := [2,4,8,16,32,64,88,36,81,1024,1,1076,40,1125,1,65536,1124,1,66674,1,1077,33,65,65568,121,16,0,1124,1077,1,1057,122,36,123,1125,80]

theorem envBound2218 : H12AffineFastState.Bounded env2218 := by
  intro p hp
  have h : env2218.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2217_2218 : H12AffineEnvironment.transform 31 122 env2217 = env2218 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 122 env2217 == env2218) = true)

theorem identity2218 : scanCanonicalize (H12AffineFastState.compose env2218 (packedSelected [4] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound2218 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env2219 : List Nat := [2,4,8,0,32,64,72,36,65,1024,1,1060,40,1125,1,65536,1124,1,66658,1,1061,33,65,65568,105,0,0,1124,1061,1,1057,106,36,107,1125,64]

theorem envBound2219 : H12AffineFastState.Bounded env2219 := by
  intro p hp
  have h : env2219.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2218_2219 : H12AffineEnvironment.transform 3 0 env2218 = env2219 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env2218 == env2219) = true)

def env2220 : List Nat := [2,4,8,0,32,64,72,36,65,1024,1,1060,40,1125,1,8,1124,1,1130,1,1061,33,65,40,105,0,0,1124,1061,1,1057,106,36,107,1125,64]

theorem envBound2220 : H12AffineFastState.Bounded env2220 := by
  intro p hp
  have h : env2220.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2219_2220 : H12AffineEnvironment.transform 15 8 env2219 = env2220 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8 env2219 == env2220) = true)

theorem identity2220 : scanCanonicalize (H12AffineFastState.compose env2220 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 42) := by decide +kernel

theorem selectedBound2220 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2221 : List Nat := [2,4,8,0,32,42,34,36,43,1024,1,1060,40,1039,1,8,1038,1,1024,1,1061,33,43,40,3,0,0,1038,1061,1,1057,0,36,1,1039,42]

theorem envBound2221 : H12AffineFastState.Bounded env2221 := by
  intro p hp
  have h : env2221.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2220_2221 : H12AffineEnvironment.transform 5 42 env2220 = env2221 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 42 env2220 == env2221) = true)

theorem identity2221 : scanCanonicalize (H12AffineFastState.compose env2221 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound2221 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2222 : List Nat := [2,4,8,0,0,10,2,4,11,1024,1,1028,8,1039,1,8,1038,1,1024,1,1029,1,11,8,3,0,0,1038,1029,1,1025,0,4,1,1039,10]

theorem envBound2222 : H12AffineFastState.Bounded env2222 := by
  intro p hp
  have h : env2222.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2221_2222 : H12AffineEnvironment.transform 4 0 env2221 = env2222 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env2221 == env2222) = true)

def leafEnv2222 : List Nat := [2,4,8,0,0,10,2,4,11,1024,1,1028,8,1039,1,8,1038,1,1024,1,1029,1,11,8,1025,3,1,0,0,1038,1029,1,1025,0,4,1,4,3,1039,10,0,1028,1]

def active2222 : List Nat := [0,1,2,9]

def tree2222 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2222 : H12WitnessSearch.Good tree2222 := H12GlobalWitnessIndex.good

theorem leafIdentity2222 : H12AffineFastState.composeSystem env2222 rootObs = leafEnv2222 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2222 rootObs == leafEnv2222) = true)

theorem terminalChecked2222 : H12PackedTerminal.terminalCheckFast leafEnv2222 active2222 tree2222 = true := by decide +kernel

def env2223 : List Nat := [2,4,8,0,32,64,72,36,65,1024,1,1060,40,1125,1,9,1124,1,1131,1,1061,33,65,41,105,0,0,1124,1061,1,1057,106,36,107,1125,64]

theorem envBound2223 : H12AffineFastState.Bounded env2223 := by
  intro p hp
  have h : env2223.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2219_2223 : H12AffineEnvironment.transform 15 9 env2219 = env2223 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 9 env2219 == env2223) = true)

def env2224 : List Nat := [2,4,8,16,32,64,88,37,81,1024,1,1076,41,1125,0,65536,1125,1,66674,0,1077,32,64,65568,120,17,0,1124,1076,1,1056,4294967296,37,4294967296,1124,80]

theorem envBound2224 : H12AffineFastState.Bounded env2224 := by
  intro p hp
  have h : env2224.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2216_2224 : H12AffineEnvironment.transform 7 37 env2216 = env2224 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env2216 == env2224) = true)

theorem identity2224 : scanCanonicalize (H12AffineFastState.compose env2224 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 65625) := by decide +kernel

theorem selectedBound2224 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2225 : List Nat := [2,4,8,16,32,64,88,37,81,1024,1,1076,41,1125,0,65536,1125,1,66674,0,1077,32,64,65568,120,17,0,1124,1076,1,1056,65625,37,65625,1124,80]

theorem envBound2225 : H12AffineFastState.Bounded env2225 := by
  intro p hp
  have h : env2225.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2224_2225 : H12AffineEnvironment.transform 31 65625 env2224 = env2225 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65625 env2224 == env2225) = true)

theorem identity2225 : scanCanonicalize (H12AffineFastState.compose env2225 (packedSelected [4] rootPS)) = affineNative (2^(15+1) ^^^ 56) := by decide +kernel

theorem selectedBound2225 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env2226 : List Nat := [2,4,8,16,32,64,88,37,81,1024,1,1076,41,1125,0,56,1125,1,1098,0,1077,32,64,24,120,17,0,1124,1076,1,1056,97,37,97,1124,80]

theorem envBound2226 : H12AffineFastState.Bounded env2226 := by
  intro p hp
  have h : env2226.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2225_2226 : H12AffineEnvironment.transform 15 56 env2225 = env2226 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 56 env2225 == env2226) = true)

theorem identity2226 : scanCanonicalize (H12AffineFastState.compose env2226 (packedSelected [1,2] rootPS)) = affineNative (2^(5+1) ^^^ 1) := by decide +kernel

theorem selectedBound2226 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env2227 : List Nat := [2,4,8,16,32,1,25,37,16,1024,1,1076,41,1060,0,56,1060,1,1035,0,1077,32,1,24,57,17,0,1061,1076,1,1056,32,37,32,1061,17]

theorem envBound2227 : H12AffineFastState.Bounded env2227 := by
  intro p hp
  have h : env2227.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2226_2227 : H12AffineEnvironment.transform 5 1 env2226 = env2227 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 1 env2226 == env2227) = true)

def env2228 : List Nat := [2,4,8,16,0,1,25,5,16,1024,1,1044,9,1028,0,24,1028,1,1035,0,1045,0,1,24,25,17,0,1029,1044,1,1024,0,5,0,1029,17]

theorem envBound2228 : H12AffineFastState.Bounded env2228 := by
  intro p hp
  have h : env2228.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2227_2228 : H12AffineEnvironment.transform 4 0 env2227 = env2228 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env2227 == env2228) = true)

def env2229 : List Nat := [2,4,8,16,1,1,25,4,16,1024,1,1045,8,1029,0,25,1029,1,1035,0,1044,1,1,24,24,17,0,1028,1045,1,1025,1,4,1,1028,17]

theorem envBound2229 : H12AffineFastState.Bounded env2229 := by
  intro p hp
  have h : env2229.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2227_2229 : H12AffineEnvironment.transform 4 1 env2227 = env2229 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env2227 == env2229) = true)

theorem identity2229 : scanCanonicalize (H12AffineFastState.compose env2229 (packedSelected [1] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound2229 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2230 : List Nat := [2,4,3,16,1,1,18,4,16,1024,1,1045,3,1029,0,18,1029,1,1024,0,1044,1,1,19,19,17,0,1028,1045,1,1025,1,4,1,1028,17]

theorem envBound2230 : H12AffineFastState.Bounded env2230 := by
  intro p hp
  have h : env2230.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2229_2230 : H12AffineEnvironment.transform 2 3 env2229 = env2230 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env2229 == env2230) = true)

def leafEnv2230 : List Nat := [2,4,3,16,1,1,18,4,16,1024,1,1045,3,1029,0,18,1029,1,1024,0,1044,1,1,19,1025,19,1,17,0,1028,1045,1,1025,1,4,1,4,2,1028,17,0,1044,1]

def active2230 : List Nat := [0,1,3,9]

def tree2230 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2230 : H12WitnessSearch.Good tree2230 := H12GlobalWitnessIndex.good

theorem leafIdentity2230 : H12AffineFastState.composeSystem env2230 rootObs = leafEnv2230 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2230 rootObs == leafEnv2230) = true)

theorem terminalChecked2230 : H12PackedTerminal.terminalCheckFast leafEnv2230 active2230 tree2230 = true := by decide +kernel

def env2231 : List Nat := [2,4,8,16,32,64,89,256,512,1024,1,4096,8192,4177,32768,65536,9756,41000,108042,32768,4097,8201,5457,107097,8272,5376,41593,4176,9805,593,9817,4294967296,256,4294975529,9757,513]

theorem envBound2231 : H12AffineFastState.Bounded env2231 := by
  intro p hp
  have h : env2231.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2211_2231 : H12AffineEnvironment.transform 6 89 env2211 = env2231 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env2211 == env2231) = true)

theorem identity2231 : scanCanonicalize (H12AffineFastState.compose env2231 (packedSelected [5,8,10,12,13] rootPS)) = affineNative (2^(15+1) ^^^ 5654) := by decide +kernel

theorem selectedBound2231 : packedSelected [5,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env2232 : List Nat := [2,4,8,16,32,64,89,256,512,1024,1,4096,8192,4177,32768,5654,9756,41000,45084,32768,4097,8201,5457,46159,8272,5376,41593,4176,9805,593,9817,4294967296,256,4294975529,9757,513]

theorem envBound2232 : H12AffineFastState.Bounded env2232 := by
  intro p hp
  have h : env2232.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2231_2232 : H12AffineEnvironment.transform 15 5654 env2231 = env2232 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5654 env2231 == env2232) = true)

theorem identity2232 : scanCanonicalize (H12AffineFastState.compose env2232 (packedSelected [0,5,7,8,16] rootPS)) = affineNative (2^(12+1) ^^^ 860) := by decide +kernel

theorem selectedBound2232 : packedSelected [0,5,7,8,16] rootPS < 2^1333 := by decide +kernel

def env2233 : List Nat := [2,4,8,16,32,64,89,256,512,1024,1,4096,860,4177,32768,5654,1344,33652,37696,32768,4097,853,5457,38675,780,5376,33061,4176,1297,593,1285,4294967296,256,4294968181,1345,513]

theorem envBound2233 : H12AffineFastState.Bounded env2233 := by
  intro p hp
  have h : env2233.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2232_2233 : H12AffineEnvironment.transform 12 860 env2232 = env2233 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 860 env2232 == env2233) = true)

theorem identity2233 : scanCanonicalize (H12AffineFastState.compose env2233 (packedSelected [0,5,6] rootPS)) = affineNative (2^(14+1) ^^^ 293) := by decide +kernel

theorem selectedBound2233 : packedSelected [0,5,6] rootPS < 2^1333 := by decide +kernel

def env2234 : List Nat := [2,4,8,16,32,64,89,256,512,1024,1,4096,860,4177,293,5654,1344,593,4709,293,4097,853,5457,5686,780,5376,0,4176,1297,593,1285,4294967296,256,4294968181,1345,513]

theorem envBound2234 : H12AffineFastState.Bounded env2234 := by
  intro p hp
  have h : env2234.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2233_2234 : H12AffineEnvironment.transform 14 293 env2233 = env2234 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 293 env2233 == env2234) = true)

theorem identity2234 : scanCanonicalize (H12AffineFastState.compose env2234 (packedSelected [0,7] rootPS)) = affineNative (2^(8+1) ^^^ 80) := by decide +kernel

theorem selectedBound2234 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env2235 : List Nat := [2,4,8,16,32,64,89,256,80,1024,1,4096,268,4177,293,5190,1344,1,4149,293,4097,261,5457,5222,348,5376,0,4176,1297,1,1285,4294967296,256,4294967589,1345,81]

theorem envBound2235 : H12AffineFastState.Bounded env2235 := by
  intro p hp
  have h : env2235.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2234_2235 : H12AffineEnvironment.transform 8 80 env2234 = env2235 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 80 env2234 == env2235) = true)

theorem identity2235 : scanCanonicalize (H12AffineFastState.compose env2235 (packedSelected [1,2,4,10] rootPS)) = affineNative (2^(11+1) ^^^ 1076) := by decide +kernel

theorem selectedBound2235 : packedSelected [1,2,4,10] rootPS < 2^1333 := by decide +kernel

def env2236 : List Nat := [2,4,8,16,32,64,89,256,80,1024,1,1076,268,1125,293,114,1344,1,1025,293,1077,261,357,82,348,308,0,1124,1297,1,1285,4294967296,256,4294967589,1345,81]

theorem envBound2236 : H12AffineFastState.Bounded env2236 := by
  intro p hp
  have h : env2236.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2235_2236 : H12AffineEnvironment.transform 11 1076 env2235 = env2236 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1076 env2235 == env2236) = true)

theorem identity2236 : scanCanonicalize (H12AffineFastState.compose env2236 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 107) := by decide +kernel

theorem selectedBound2236 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2237 : List Nat := [2,4,8,16,32,64,89,256,80,1024,1,1076,268,1125,293,114,1344,1,1025,293,1077,261,357,82,348,308,0,1124,1297,1,1285,107,256,334,1345,81]

theorem envBound2237 : H12AffineFastState.Bounded env2237 := by
  intro p hp
  have h : env2237.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2236_2237 : H12AffineEnvironment.transform 31 107 env2236 = env2237 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 107 env2236 == env2237) = true)

def env2238 : List Nat := [2,4,8,16,32,16,9,256,0,1024,1,1076,268,1077,293,34,1296,1,1025,293,1077,261,309,2,268,308,0,1076,1297,1,1285,59,256,286,1297,1]

theorem envBound2238 : H12AffineFastState.Bounded env2238 := by
  intro p hp
  have h : env2238.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2237_2238 : H12AffineEnvironment.transform 5 16 env2237 = env2238 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env2237 == env2238) = true)

theorem identity2238 : scanCanonicalize (H12AffineFastState.compose env2238 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 53) := by decide +kernel

theorem selectedBound2238 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2239 : List Nat := [2,4,8,16,32,16,9,53,0,1024,1,1076,57,1077,16,34,1061,1,1025,16,1077,48,0,2,57,1,0,1076,1060,1,1072,59,53,43,1060,1]

theorem envBound2239 : H12AffineFastState.Bounded env2239 := by
  intro p hp
  have h : env2239.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2238_2239 : H12AffineEnvironment.transform 7 53 env2238 = env2239 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 53 env2238 == env2239) = true)

def env2240 : List Nat := [2,4,8,0,32,0,9,37,0,1024,1,1060,41,1061,0,34,1061,1,1025,0,1061,32,0,2,41,1,0,1060,1060,1,1056,43,37,43,1060,1]

theorem envBound2240 : H12AffineFastState.Bounded env2240 := by
  intro p hp
  have h : env2240.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2239_2240 : H12AffineEnvironment.transform 3 0 env2239 = env2240 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env2239 == env2240) = true)

theorem identity2240 : scanCanonicalize (H12AffineFastState.compose env2240 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound2240 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2241 : List Nat := [2,4,3,0,32,0,2,37,0,1024,1,1060,34,1061,0,34,1061,1,1025,0,1061,32,0,2,34,1,0,1060,1060,1,1056,32,37,32,1060,1]

theorem envBound2241 : H12AffineFastState.Bounded env2241 := by
  intro p hp
  have h : env2241.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2240_2241 : H12AffineEnvironment.transform 2 3 env2240 = env2241 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env2240 == env2241) = true)

def leafEnv2241 : List Nat := [2,4,3,0,32,0,2,37,0,1024,1,1060,34,1061,0,34,1061,1,1025,0,1061,32,0,2,1057,34,1,1,0,1060,1060,1,1056,32,37,32,4,35,1060,1,0,1061,1]

def active2241 : List Nat := [0,1,4,9]

def tree2241 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2241 : H12WitnessSearch.Good tree2241 := H12GlobalWitnessIndex.good

theorem leafIdentity2241 : H12AffineFastState.composeSystem env2241 rootObs = leafEnv2241 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2241 rootObs == leafEnv2241) = true)

theorem terminalChecked2241 : H12PackedTerminal.terminalCheckFast leafEnv2241 active2241 tree2241 = true := by decide +kernel

def env2242 : List Nat := [2,4,8,1,32,1,9,36,0,1024,1,1061,40,1060,1,34,1061,1,1025,1,1060,33,0,2,40,1,0,1061,1060,1,1057,42,36,43,1060,1]

theorem envBound2242 : H12AffineFastState.Bounded env2242 := by
  intro p hp
  have h : env2242.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2239_2242 : H12AffineEnvironment.transform 3 1 env2239 = env2242 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env2239 == env2242) = true)

def leafEnv2242 : List Nat := [2,4,8,1,32,1,9,36,0,1024,1,1061,40,1060,1,34,1061,1,1025,1,1060,33,0,2,1056,40,1,1,0,1061,1060,1,1057,42,36,43,4,35,1060,1,0,1061,1]

def active2242 : List Nat := [0,1,2,4,9]

def tree2242 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2242 : H12WitnessSearch.Good tree2242 := H12GlobalWitnessIndex.good

theorem leafIdentity2242 : H12AffineFastState.composeSystem env2242 rootObs = leafEnv2242 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2242 rootObs == leafEnv2242) = true)

theorem terminalChecked2242 : H12PackedTerminal.terminalCheckFast leafEnv2242 active2242 tree2242 = true := by decide +kernel

def env2243 : List Nat := [2,4,8,16,32,17,8,256,1,1024,1,1076,268,1076,293,35,1297,1,1025,293,1077,261,308,3,269,308,0,1077,1297,1,1285,58,256,287,1296,0]

theorem envBound2243 : H12AffineFastState.Bounded env2243 := by
  intro p hp
  have h : env2243.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2237_2243 : H12AffineEnvironment.transform 5 17 env2237 = env2243 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env2237 == env2243) = true)

theorem identity2243 : scanCanonicalize (H12AffineFastState.compose env2243 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound2243 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2244 : List Nat := [2,4,8,1,32,0,8,256,1,1024,1,1061,268,1061,293,35,1280,1,1025,293,1060,261,293,3,269,293,0,1060,1280,1,1285,43,256,270,1281,0]

theorem envBound2244 : H12AffineFastState.Bounded env2244 := by
  intro p hp
  have h : env2244.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2243_2244 : H12AffineEnvironment.transform 3 1 env2243 = env2244 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env2243 == env2244) = true)

def env2245 : List Nat := [2,4,8,1,32,0,8,36,1,1024,1,1061,40,1061,1,35,1060,1,1025,1,1060,33,1,3,41,1,0,1060,1060,1,1057,43,36,42,1061,0]

theorem envBound2245 : H12AffineFastState.Bounded env2245 := by
  intro p hp
  have h : env2245.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2244_2245 : H12AffineEnvironment.transform 7 36 env2244 = env2245 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env2244 == env2245) = true)

def leafEnv2245 : List Nat := [2,4,8,1,32,0,8,36,1,1024,1,1061,40,1061,1,35,1060,1,1025,1,1060,33,1,3,1056,41,1,1,0,1060,1060,1,1057,43,36,42,4,35,1061,0,0,1061,1]

def active2245 : List Nat := [0,1,2,4,9]

def tree2245 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2245 : H12WitnessSearch.Good tree2245 := H12GlobalWitnessIndex.good

theorem leafIdentity2245 : H12AffineFastState.composeSystem env2245 rootObs = leafEnv2245 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2245 rootObs == leafEnv2245) = true)

theorem terminalChecked2245 : H12PackedTerminal.terminalCheckFast leafEnv2245 active2245 tree2245 = true := by decide +kernel

def env2246 : List Nat := [2,4,8,1,32,0,8,37,1,1024,1,1061,41,1061,0,35,1061,1,1025,0,1060,32,0,3,40,0,0,1060,1061,1,1056,43,37,43,1060,0]

theorem envBound2246 : H12AffineFastState.Bounded env2246 := by
  intro p hp
  have h : env2246.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2244_2246 : H12AffineEnvironment.transform 7 37 env2244 = env2246 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env2244 == env2246) = true)

theorem identity2246 : scanCanonicalize (H12AffineFastState.compose env2246 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound2246 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2247 : List Nat := [2,4,3,1,32,0,3,37,1,1024,1,1061,34,1061,0,35,1061,1,1025,0,1060,32,0,3,35,0,0,1060,1061,1,1056,32,37,32,1060,0]

theorem envBound2247 : H12AffineFastState.Bounded env2247 := by
  intro p hp
  have h : env2247.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2246_2247 : H12AffineEnvironment.transform 2 3 env2246 = env2247 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env2246 == env2247) = true)

def leafEnv2247 : List Nat := [2,4,3,1,32,0,3,37,1,1024,1,1061,34,1061,0,35,1061,1,1025,0,1060,32,0,3,1057,35,1,0,0,1060,1061,1,1056,32,37,32,4,35,1060,0,0,1060,1]

def active2247 : List Nat := [0,1,4,9]

def tree2247 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2247 : H12WitnessSearch.Good tree2247 := H12GlobalWitnessIndex.good

theorem leafIdentity2247 : H12AffineFastState.composeSystem env2247 rootObs = leafEnv2247 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2247 rootObs == leafEnv2247) = true)

theorem terminalChecked2247 : H12PackedTerminal.terminalCheckFast leafEnv2247 active2247 tree2247 = true := by decide +kernel

def env2248 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,131072,41001,108042,32768,4097,8201,5457,230469,8329,5376,164964,4176,131153,648,131141,4294967296,256,4295100140,131073,513]

theorem envBound2248 : H12AffineFastState.Bounded env2248 := by
  intro p hp
  have h : env2248.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2209_2248 : H12AffineEnvironment.transform 17 41001 env2209 = env2248 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41001 env2209 == env2248) = true)

theorem identity2248 : scanCanonicalize (H12AffineFastState.compose env2248 (packedSelected [16,18] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound2248 : packedSelected [16,18] rootPS < 2^1333 := by decide +kernel

def env2249 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,4096,8192,4177,32768,65536,131072,41001,107650,32768,4097,8201,5457,230469,8329,5376,164964,4176,131153,0,131141,4294967296,256,4295099492,131073,137]

theorem envBound2249 : H12AffineFastState.Bounded env2249 := by
  intro p hp
  have h : env2249.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2248_2249 : H12AffineEnvironment.transform 8 136 env2248 = env2249 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env2248 == env2249) = true)

theorem identity2249 : scanCanonicalize (H12AffineFastState.compose env2249 (packedSelected [0,2,6,9,16] rootPS)) = affineNative (2^(16+1) ^^^ 99534) := by decide +kernel

theorem selectedBound2249 : packedSelected [0,2,6,9,16] rootPS < 2^1333 := by decide +kernel

def env2250 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,4096,8192,4177,32768,65536,99534,41001,107650,32768,4097,8201,5457,139,8329,5376,65706,4176,99487,0,99467,4294967296,256,4295065770,99535,137]

theorem envBound2250 : H12AffineFastState.Bounded env2250 := by
  intro p hp
  have h : env2250.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2249_2250 : H12AffineEnvironment.transform 16 99534 env2249 = env2250 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 99534 env2249 == env2250) = true)

theorem identity2250 : scanCanonicalize (H12AffineFastState.compose env2250 (packedSelected [5,8,10,12,17] rootPS)) = affineNative (2^(15+1) ^^^ 38046) := by decide +kernel

theorem selectedBound2250 : packedSelected [5,8,10,12,17] rootPS < 2^1333 := by decide +kernel

def env2251 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,4096,8192,4177,32768,38046,4176,41001,12316,32768,4097,8201,5457,139,8329,5376,37940,4176,4097,0,4117,4294967296,256,4294972468,4177,137]

theorem envBound2251 : H12AffineFastState.Bounded env2251 := by
  intro p hp
  have h : env2251.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2250_2251 : H12AffineEnvironment.transform 15 38046 env2250 = env2251 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 38046 env2250 == env2251) = true)

theorem identity2251 : scanCanonicalize (H12AffineFastState.compose env2251 (packedSelected [0,2,6,9] rootPS)) = affineNative (2^(12+1) ^^^ 268) := by decide +kernel

theorem selectedBound2251 : packedSelected [0,2,6,9] rootPS < 2^1333 := by decide +kernel

def env2252 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,4096,268,4177,32768,38046,4176,33061,4368,32768,4097,261,5457,139,389,5376,37940,4176,4097,0,4117,4294967296,256,4294972468,4177,137]

theorem envBound2252 : H12AffineFastState.Bounded env2252 := by
  intro p hp
  have h : env2252.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2251_2252 : H12AffineEnvironment.transform 12 268 env2251 = env2252 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 268 env2251 == env2252) = true)

theorem identity2252 : scanCanonicalize (H12AffineFastState.compose env2252 (packedSelected [0,3,5,7,12,13] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound2252 : packedSelected [0,3,5,7,12,13] rootPS < 2^1333 := by decide +kernel

def env2253 : List Nat := [2,4,8,16,32,64,128,36,136,1024,1,4096,40,4177,32768,38046,4176,32769,4148,32768,4097,33,5237,139,161,5156,37940,4176,4097,0,4117,4294967296,36,4294972468,4177,137]

theorem envBound2253 : H12AffineFastState.Bounded env2253 := by
  intro p hp
  have h : env2253.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2252_2253 : H12AffineEnvironment.transform 7 36 env2252 = env2253 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env2252 == env2253) = true)

theorem identity2253 : scanCanonicalize (H12AffineFastState.compose env2253 (packedSelected [0,5,7,8] rootPS)) = affineNative (2^(14+1) ^^^ 5173) := by decide +kernel

theorem selectedBound2253 : packedSelected [0,5,7,8] rootPS < 2^1333 := by decide +kernel

def env2254 : List Nat := [2,4,8,16,32,64,128,36,136,1024,1,4096,40,4177,5173,171,4176,5172,4148,5173,4097,33,5237,139,161,5156,1,4176,4097,0,4117,4294967296,36,4294972468,4177,137]

theorem envBound2254 : H12AffineFastState.Bounded env2254 := by
  intro p hp
  have h : env2254.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2253_2254 : H12AffineEnvironment.transform 14 5173 env2253 = env2254 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 5173 env2253 == env2254) = true)

def env2255 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,8201,5457,230469,8329,5377,402508,4177,131152,631939,131140,4294967296,257,4295729383,131073,513]

theorem envBound2255 : H12AffineFastState.Bounded env2255 := by
  intro p hp
  have h : env2255.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2207_2255 : H12AffineEnvironment.transform 25 5377 env2207 = env2255 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env2207 == env2255) = true)

theorem identity2255 : scanCanonicalize (H12AffineFastState.compose env2255 (packedSelected [11] rootPS)) = affineNative (2^(18+1) ^^^ 242458) := by decide +kernel

theorem selectedBound2255 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env2256 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,131072,262144,242458,32768,4097,8201,5457,230469,8329,5377,402508,4177,131152,137113,131140,4294967296,257,4294972413,131073,513]

theorem envBound2256 : H12AffineFastState.Bounded env2256 := by
  intro p hp
  have h : env2256.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2255_2256 : H12AffineEnvironment.transform 18 242458 env2255 = env2256 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 242458 env2255 == env2256) = true)

theorem identity2256 : scanCanonicalize (H12AffineFastState.compose env2256 (packedSelected [6,25] rootPS)) = affineNative (2^(16+1) ^^^ 112410) := by decide +kernel

theorem selectedBound2256 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env2257 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,112410,262144,1024,32768,4097,8201,5457,13151,8329,5377,365398,4177,112458,106627,112478,4294967296,257,4294972413,112411,513]

theorem envBound2257 : H12AffineFastState.Bounded env2257 := by
  intro p hp
  have h : env2257.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2256_2257 : H12AffineEnvironment.transform 16 112410 env2256 = env2257 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 112410 env2256 == env2257) = true)

def env2258 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,10249,17664,230469,33554432,67108864,67528988,67130625,67245393,1073741824,67245381,4294967296,67113984,4396404030,131073,33563272]

theorem envBound2258 : H12AffineFastState.Bounded env2258 := by
  intro p hp
  have h : env2258.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2113_2258 : H12AffineEnvironment.transform 21 10249 env2113 = env2258 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10249 env2113 == env2258) = true)

def env2259 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,10249,17664,230469,8328,67108864,67528988,67130625,67245393,1073741824,67245381,4294967296,67113984,4362857910,131073,512]

theorem envBound2259 : H12AffineFastState.Bounded env2259 := by
  intro p hp
  have h : env2259.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2258_2259 : H12AffineEnvironment.transform 24 8328 env2258 = env2259 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8328 env2258 == env2259) = true)

theorem identity2259 : scanCanonicalize (H12AffineFastState.compose env2259 (packedSelected [4,7,9,16,20,27] rootPS)) = affineNative (2^(29+1) ^^^ 67233235) := by decide +kernel

theorem selectedBound2259 : packedSelected [4,7,9,16,20,27] rootPS < 2^1333 := by decide +kernel

def env2260 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,10249,17664,230469,8328,67108864,67528988,67130625,67245393,67233235,67245381,4294967296,67113984,4362857910,131073,512]

theorem envBound2260 : H12AffineFastState.Bounded env2260 := by
  intro p hp
  have h : env2260.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2259_2260 : H12AffineEnvironment.transform 29 67233235 env2259 = env2260 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 67233235 env2259 == env2260) = true)

theorem identity2260 : scanCanonicalize (H12AffineFastState.compose env2260 (packedSelected [1,5,8,19,24,26] rootPS)) = affineNative (2^(16+1) ^^^ 21777) := by decide +kernel

theorem selectedBound2260 : packedSelected [1,5,8,19,24,26] rootPS < 2^1333 := by decide +kernel

def env2261 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,524288,32768,4097,10249,17664,119124,8328,67108864,67386381,67130625,67125312,67233235,67125332,4294967296,67113984,4362713255,21776,512]

theorem envBound2261 : H12AffineFastState.Bounded env2261 := by
  intro p hp
  have h : env2261.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2260_2261 : H12AffineEnvironment.transform 16 21777 env2260 = env2261 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 21777 env2260 == env2261) = true)

theorem identity2261 : scanCanonicalize (H12AffineFastState.compose env2261 (packedSelected [0,6,7,9,20,22,25] rootPS)) = affineNative (2^(18+1) ^^^ 35977) := by decide +kernel

theorem selectedBound2261 : packedSelected [0,6,7,9,20,22,25] rootPS < 2^1333 := by decide +kernel

def env2262 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,35977,32768,4097,10249,17664,119124,8328,67108864,67386381,67130625,67125312,67233235,67125332,4294967296,67113984,4362155054,21776,512]

theorem envBound2262 : H12AffineFastState.Bounded env2262 := by
  intro p hp
  have h : env2262.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2261_2262 : H12AffineEnvironment.transform 18 35977 env2261 = env2262 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 35977 env2261 == env2262) = true)

theorem identity2262 : scanCanonicalize (H12AffineFastState.compose env2262 (packedSelected [3,5,8,10,28,31] rootPS)) = affineNative (2^(25+1) ^^^ 5376) := by decide +kernel

theorem selectedBound2262 : packedSelected [3,5,8,10,28,31] rootPS < 2^1333 := by decide +kernel

def env2263 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,35977,32768,4097,10249,17664,119124,8328,5376,272653,16385,21824,127187,21844,4294967296,256,4295041326,21776,512]

theorem envBound2263 : H12AffineFastState.Bounded env2263 := by
  intro p hp
  have h : env2263.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2262_2263 : H12AffineEnvironment.transform 25 5376 env2262 = env2263 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env2262 == env2263) = true)

theorem identity2263 : scanCanonicalize (H12AffineFastState.compose env2263 (packedSelected [4,9,16] rootPS)) = affineNative (2^(14+1) ^^^ 29020) := by decide +kernel

theorem selectedBound2263 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env2264 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,29020,65536,21777,262144,32213,29020,4097,10249,17664,73736,8328,5376,272653,16385,21824,65935,21844,4294967296,256,4295041326,21776,512]

theorem envBound2264 : H12AffineFastState.Bounded env2264 := by
  intro p hp
  have h : env2264.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2263_2264 : H12AffineEnvironment.transform 14 29020 env2263 = env2264 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 29020 env2263 == env2264) = true)

theorem identity2264 : scanCanonicalize (H12AffineFastState.compose env2264 (packedSelected [1,3,5,8,10,13,19,21] rootPS)) = affineNative (2^(13+1) ^^^ 14804) := by decide +kernel

theorem selectedBound2264 : packedSelected [1,3,5,8,10,13,19,21] rootPS < 2^1333 := by decide +kernel

def env2265 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,14804,2184,65536,11461,262144,1025,2184,4097,10249,15572,73736,8328,5376,272653,14805,11412,65935,11392,4294967296,256,4295041326,11460,512]

theorem envBound2265 : H12AffineFastState.Bounded env2265 := by
  intro p hp
  have h : env2265.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2264_2265 : H12AffineEnvironment.transform 13 14804 env2264 = env2265 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 14804 env2264 == env2265) = true)

theorem identity2265 : scanCanonicalize (H12AffineFastState.compose env2265 (packedSelected [1,3,13,17,24,28] rootPS)) = affineNative (2^(12+1) ^^^ 2436) := by decide +kernel

theorem selectedBound2265 : packedSelected [1,3,13,17,24,28] rootPS < 2^1333 := by decide +kernel

def env2266 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,2436,4176,2184,65536,1345,262144,1025,2184,4097,397,5456,67980,2316,5376,262281,4177,1296,65935,1284,4294967296,256,4295035050,1344,512]

theorem envBound2266 : H12AffineFastState.Bounded env2266 := by
  intro p hp
  have h : env2266.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2265_2266 : H12AffineEnvironment.transform 12 2436 env2265 = env2266 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2436 env2265 == env2266) = true)

theorem identity2266 : scanCanonicalize (H12AffineFastState.compose env2266 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 65910) := by decide +kernel

theorem selectedBound2266 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env2267 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,2436,4176,2184,65536,1345,262144,1025,2184,4097,397,5456,67980,2316,5376,262281,4177,1296,65935,1284,65910,256,2524,1344,512]

theorem envBound2267 : H12AffineFastState.Bounded env2267 := by
  intro p hp
  have h : env2267.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2266_2267 : H12AffineEnvironment.transform 31 65910 env2266 = env2267 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65910 env2266 == env2267) = true)

theorem identity2267 : scanCanonicalize (H12AffineFastState.compose env2267 (packedSelected [3,5,10] rootPS)) = affineNative (2^(15+1) ^^^ 6754) := by decide +kernel

theorem selectedBound2267 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env2268 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,2436,4176,2184,6754,1345,262144,1025,2184,4097,397,5456,5102,2316,5376,262281,4177,1296,7149,1284,6932,256,2524,1344,512]

theorem envBound2268 : H12AffineFastState.Bounded env2268 := by
  intro p hp
  have h : env2268.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2267_2268 : H12AffineEnvironment.transform 15 6754 env2267 = env2268 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 6754 env2267 == env2268) = true)

theorem identity2268 : scanCanonicalize (H12AffineFastState.compose env2268 (packedSelected [1,8,12] rootPS)) = affineNative (2^(11+1) ^^^ 2586) := by decide +kernel

theorem selectedBound2268 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env2269 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,2586,2436,2634,2184,120,1345,262144,1025,2184,2587,397,3914,2548,2316,3866,262281,2635,1296,503,1284,270,256,2524,1344,512]

theorem envBound2269 : H12AffineFastState.Bounded env2269 := by
  intro p hp
  have h : env2269.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2268_2269 : H12AffineEnvironment.transform 11 2586 env2268 = env2269 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 2586 env2268 == env2269) = true)

theorem identity2269 : scanCanonicalize (H12AffineFastState.compose env2269 (packedSelected [3,5,15] rootPS)) = affineNative (2^(17+1) ^^^ 90) := by decide +kernel

theorem selectedBound2269 : packedSelected [3,5,15] rootPS < 2^1333 := by decide +kernel

def env2270 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,2586,2436,2634,2184,120,1345,90,1025,2184,2587,397,3914,2548,2316,3866,211,2635,1296,503,1284,270,256,2524,1344,512]

theorem envBound2270 : H12AffineFastState.Bounded env2270 := by
  intro p hp
  have h : env2270.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2269_2270 : H12AffineEnvironment.transform 17 90 env2269 = env2270 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 90 env2269 == env2270) = true)

theorem identity2270 : scanCanonicalize (H12AffineFastState.compose env2270 (packedSelected [0,11] rootPS)) = affineNative (2^(9+1) ^^^ 238) := by decide +kernel

theorem selectedBound2270 : packedSelected [0,11] rootPS < 2^1333 := by decide +kernel

def env2271 : List Nat := [2,4,8,16,32,64,128,256,512,238,2048,2586,2436,2634,2184,120,431,90,239,2184,2587,397,2980,2548,2316,3060,211,2635,510,503,490,270,256,2524,430,512]

theorem envBound2271 : H12AffineFastState.Bounded env2271 := by
  intro p hp
  have h : env2271.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2270_2271 : H12AffineEnvironment.transform 9 238 env2270 = env2271 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 238 env2270 == env2271) = true)

theorem identity2271 : scanCanonicalize (H12AffineFastState.compose env2271 (packedSelected [1,3,13] rootPS)) = affineNative (2^(5+1) ^^^ 2) := by decide +kernel

theorem selectedBound2271 : packedSelected [1,3,13] rootPS < 2^1333 := by decide +kernel

def env2272 : List Nat := [2,4,8,16,32,2,128,256,512,172,2048,2586,2436,2568,2184,58,431,24,173,2184,2587,397,2980,2486,2316,2998,145,2569,444,437,424,270,256,2462,430,512]

theorem envBound2272 : H12AffineFastState.Bounded env2272 := by
  intro p hp
  have h : env2272.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2271_2272 : H12AffineEnvironment.transform 5 2 env2271 = env2272 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 2 env2271 == env2272) = true)

theorem identity2272 : scanCanonicalize (H12AffineFastState.compose env2272 (packedSelected [0,2,9,18] rootPS)) = affineNative (2^(8+1) ^^^ 42) := by decide +kernel

theorem selectedBound2272 : packedSelected [0,2,9,18] rootPS < 2^1333 := by decide +kernel

def env2273 : List Nat := [2,4,8,16,32,2,128,256,42,172,2048,2096,2436,2082,2184,58,431,24,173,2184,2097,397,2446,2486,2316,2460,145,2083,444,437,424,270,256,2462,430,42]

theorem envBound2273 : H12AffineFastState.Bounded env2273 := by
  intro p hp
  have h : env2273.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2272_2273 : H12AffineEnvironment.transform 8 42 env2272 = env2273 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 42 env2272 == env2273) = true)

theorem identity2273 : scanCanonicalize (H12AffineFastState.compose env2273 (packedSelected [0,2,9,23] rootPS)) = affineNative (2^(10+1) ^^^ 316) := by decide +kernel

theorem selectedBound2273 : packedSelected [0,2,9,23] rootPS < 2^1333 := by decide +kernel

def env2274 : List Nat := [2,4,8,16,32,2,128,256,42,172,316,268,184,286,436,58,431,24,173,436,269,397,178,138,48,160,145,287,444,437,424,270,256,162,430,42]

theorem envBound2274 : H12AffineFastState.Bounded env2274 := by
  intro p hp
  have h : env2274.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2273_2274 : H12AffineEnvironment.transform 10 316 env2273 = env2274 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 316 env2273 == env2274) = true)

theorem identity2274 : scanCanonicalize (H12AffineFastState.compose env2274 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 28) := by decide +kernel

theorem selectedBound2274 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2275 : List Nat := [2,4,8,16,32,2,128,28,42,172,32,16,184,2,168,58,179,24,173,168,17,145,178,138,48,160,145,3,160,169,180,18,28,162,178,42]

theorem envBound2275 : H12AffineFastState.Bounded env2275 := by
  intro p hp
  have h : env2275.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2274_2275 : H12AffineEnvironment.transform 7 28 env2274 = env2275 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 28 env2274 == env2275) = true)

theorem identity2275 : scanCanonicalize (H12AffineFastState.compose env2275 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 18) := by decide +kernel

theorem selectedBound2275 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2276 : List Nat := [2,4,8,16,18,2,128,28,24,158,18,16,138,2,154,8,129,24,159,154,17,145,128,138,2,146,145,3,146,155,134,18,28,144,128,24]

theorem envBound2276 : H12AffineFastState.Bounded env2276 := by
  intro p hp
  have h : env2276.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2275_2276 : H12AffineEnvironment.transform 4 18 env2275 = env2276 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 18 env2275 == env2276) = true)

theorem identity2276 : scanCanonicalize (H12AffineFastState.compose env2276 (packedSelected [3,5] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound2276 : packedSelected [3,5] rootPS < 2^1333 := by decide +kernel

def env2277 : List Nat := [2,4,8,16,18,2,2,28,24,28,18,16,8,2,24,8,3,24,29,24,17,19,2,8,2,16,19,3,16,25,4,18,28,18,2,24]

theorem envBound2277 : H12AffineFastState.Bounded env2277 := by
  intro p hp
  have h : env2277.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2276_2277 : H12AffineEnvironment.transform 6 2 env2276 = env2277 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env2276 == env2277) = true)

theorem identity2277 : scanCanonicalize (H12AffineFastState.compose env2277 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 9) := by decide +kernel

theorem selectedBound2277 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2278 : List Nat := [2,4,8,9,11,2,2,5,1,5,11,9,8,2,1,8,3,1,4,1,8,10,2,8,2,9,10,3,9,0,4,11,5,11,2,1]

theorem envBound2278 : H12AffineFastState.Bounded env2278 := by
  intro p hp
  have h : env2278.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2277_2278 : H12AffineEnvironment.transform 3 9 env2277 = env2278 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 9 env2277 == env2278) = true)

theorem identity2278 : scanCanonicalize (H12AffineFastState.compose env2278 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound2278 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env2279 : List Nat := [2,4,3,2,0,2,2,5,1,5,0,2,3,2,1,3,3,1,4,1,3,1,2,3,2,2,1,3,2,0,4,0,5,0,2,1]

theorem envBound2279 : H12AffineFastState.Bounded env2279 := by
  intro p hp
  have h : env2279.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2278_2279 : H12AffineEnvironment.transform 2 3 env2278 = env2279 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env2278 == env2279) = true)

def leafEnv2279 : List Nat := [2,4,3,2,0,2,2,5,1,5,0,2,3,2,1,3,3,1,4,1,3,1,2,3,5,2,1,2,1,3,2,0,4,0,5,0,4,2,2,1,0,3,1]

def active2279 : List Nat := [0,1]

def tree2279 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2279 : H12WitnessSearch.Good tree2279 := H12GlobalWitnessIndex.good

theorem leafIdentity2279 : H12AffineFastState.composeSystem env2279 rootObs = leafEnv2279 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2279 rootObs == leafEnv2279) = true)

theorem terminalChecked2279 : H12PackedTerminal.terminalCheckFast leafEnv2279 active2279 tree2279 = true := by decide +kernel

def env2280 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,10249,17664,230469,8329,67108864,67528988,67130625,67245393,1073741824,67245381,4294967296,67113984,4362857911,131073,513]

theorem envBound2280 : H12AffineFastState.Bounded env2280 := by
  intro p hp
  have h : env2280.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2258_2280 : H12AffineEnvironment.transform 24 8329 env2258 = env2280 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env2258 == env2280) = true)

def env2281 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,10249,5456,230469,8329,67108864,67516748,67110225,67245393,1073741824,67245381,4294967296,67113984,4362845671,131073,513]

theorem envBound2281 : H12AffineFastState.Bounded env2281 := by
  intro p hp
  have h : env2281.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2280_2281 : H12AffineEnvironment.transform 13 4176 env2280 = env2281 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env2280 == env2281) = true)

theorem identity2281 : scanCanonicalize (H12AffineFastState.compose env2281 (packedSelected [1,3,4,5,8,9,10,16,19] rootPS)) = affineNative (2^(29+1) ^^^ 631939) := by decide +kernel

theorem selectedBound2281 : packedSelected [1,3,4,5,8,9,10,16,19] rootPS < 2^1333 := by decide +kernel

def env2282 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,10249,5456,230469,8329,67108864,67516748,67110225,67245393,631939,67245381,4294967296,67113984,4362845671,131073,513]

theorem envBound2282 : H12AffineFastState.Bounded env2282 := by
  intro p hp
  have h : env2282.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2281_2282 : H12AffineEnvironment.transform 29 631939 env2281 = env2282 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 631939 env2281 == env2282) = true)

theorem identity2282 : scanCanonicalize (H12AffineFastState.compose env2282 (packedSelected [0,4,7,16,20,22] rootPS)) = affineNative (2^(25+1) ^^^ 528640) := by decide +kernel

theorem selectedBound2282 : packedSelected [0,4,7,16,20,22] rootPS < 2^1333 := by decide +kernel

def env2283 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,10249,5456,230469,8329,528640,927820,529489,656465,631939,656453,4294967296,525568,4295208167,131073,513]

theorem envBound2283 : H12AffineFastState.Bounded env2283 := by
  intro p hp
  have h : env2283.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2282_2283 : H12AffineEnvironment.transform 25 528640 env2282 = env2283 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 528640 env2282 == env2283) = true)

theorem identity2283 : scanCanonicalize (H12AffineFastState.compose env2283 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(18+1) ^^^ 1024) := by decide +kernel

theorem selectedBound2283 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env2284 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1024,32768,4097,10249,5456,230469,8329,5376,404556,4177,131153,106627,131141,4294967296,256,4295208167,131073,513]

theorem envBound2284 : H12AffineFastState.Bounded env2284 := by
  intro p hp
  have h : env2284.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2283_2284 : H12AffineEnvironment.transform 18 1024 env2283 = env2284 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env2283 == env2284) = true)

theorem identity2284 : scanCanonicalize (H12AffineFastState.compose env2284 (packedSelected [13,21] rootPS)) = affineNative (2^(16+1) ^^^ 4176) := by decide +kernel

theorem selectedBound2284 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env2285 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4176,262144,1024,32768,4097,10249,5456,103445,8329,5376,277532,4177,4097,106627,4117,4294967296,256,4295081143,4177,513]

theorem envBound2285 : H12AffineFastState.Bounded env2285 := by
  intro p hp
  have h : env2285.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2284_2285 : H12AffineEnvironment.transform 16 4176 env2284 = env2285 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4176 env2284 == env2285) = true)

theorem identity2285 : scanCanonicalize (H12AffineFastState.compose env2285 (packedSelected [13,17] rootPS)) = affineNative (2^(15+1) ^^^ 38046) := by decide +kernel

theorem selectedBound2285 : packedSelected [13,17] rootPS < 2^1333 := by decide +kernel

def env2286 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,38046,4176,262144,1024,32768,4097,10249,5456,139,8329,5376,277532,4177,4097,13341,4117,4294967296,256,4294977577,4177,513]

theorem envBound2286 : H12AffineFastState.Bounded env2286 := by
  intro p hp
  have h : env2286.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2285_2286 : H12AffineEnvironment.transform 15 38046 env2285 = env2286 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 38046 env2285 == env2286) = true)

theorem identity2286 : scanCanonicalize (H12AffineFastState.compose env2286 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(11+1) ^^^ 1945) := by decide +kernel

theorem selectedBound2286 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env2287 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,8192,1993,32768,33543,1993,262144,1024,32768,1944,10249,713,139,8329,665,273285,1992,1944,9092,1932,4294967296,256,4294977577,1992,513]

theorem envBound2287 : H12AffineFastState.Bounded env2287 := by
  intro p hp
  have h : env2287.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2286_2287 : H12AffineEnvironment.transform 11 1945 env2286 = env2287 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1945 env2286 == env2287) = true)

theorem identity2287 : scanCanonicalize (H12AffineFastState.compose env2287 (packedSelected [0,2,4,6,11] rootPS)) = affineNative (2^(17+1) ^^^ 43048) := by decide +kernel

theorem selectedBound2287 : packedSelected [0,2,4,6,11] rootPS < 2^1333 := by decide +kernel

def env2288 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,8192,1993,32768,33543,1993,43048,1024,32768,1944,10249,713,139,8329,665,33709,1992,1944,9092,1932,4294967296,256,4294977577,1992,513]

theorem envBound2288 : H12AffineFastState.Bounded env2288 := by
  intro p hp
  have h : env2288.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2287_2288 : H12AffineEnvironment.transform 17 43048 env2287 = env2288 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43048 env2287 == env2288) = true)

theorem identity2288 : scanCanonicalize (H12AffineFastState.compose env2288 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(14+1) ^^^ 8864) := by decide +kernel

theorem selectedBound2288 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env2289 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,8192,1993,8864,8615,1993,2696,1024,8864,1944,10249,713,139,8329,665,8461,1992,1944,9092,1932,4294967296,256,4294977577,1992,513]

theorem envBound2289 : H12AffineFastState.Bounded env2289 := by
  intro p hp
  have h : env2289.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2288_2289 : H12AffineEnvironment.transform 14 8864 env2288 = env2289 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8864 env2288 == env2289) = true)

theorem identity2289 : scanCanonicalize (H12AffineFastState.compose env2289 (packedSelected [0,1,3,5,7,8] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound2289 : packedSelected [0,1,3,5,7,8] rootPS < 2^1333 := by decide +kernel

def env2290 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1296,8192,1344,8233,8615,1344,2049,1024,8233,1297,10249,64,139,8329,16,8461,1345,1297,8461,1285,4294967296,256,4294977577,1345,136]

theorem envBound2290 : H12AffineFastState.Bounded env2290 := by
  intro p hp
  have h : env2290.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2289_2290 : H12AffineEnvironment.transform 8 137 env2289 = env2290 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env2289 == env2290) = true)

theorem identity2290 : scanCanonicalize (H12AffineFastState.compose env2290 (packedSelected [1,3] rootPS)) = affineNative (2^(12+1) ^^^ 2316) := by decide +kernel

theorem selectedBound2290 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env2291 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1296,2316,1344,2341,2219,1344,2049,1024,2341,1297,261,64,139,2437,16,2049,1345,1297,2049,1285,4294967296,256,4294967589,1345,136]

theorem envBound2291 : H12AffineFastState.Bounded env2291 := by
  intro p hp
  have h : env2291.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2290_2291 : H12AffineEnvironment.transform 12 2316 env2290 = env2291 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2316 env2290 == env2291) = true)

theorem identity2291 : scanCanonicalize (H12AffineFastState.compose env2291 (packedSelected [2,4] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound2291 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env2292 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,2316,1296,2341,2219,1296,2049,1024,2341,1297,261,16,139,2437,16,2049,1297,1297,2049,1285,4294967296,256,4294967589,1297,136]

theorem envBound2292 : H12AffineFastState.Bounded env2292 := by
  intro p hp
  have h : env2292.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2291_2292 : H12AffineEnvironment.transform 5 16 env2291 = env2292 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env2291 == env2292) = true)

theorem identity2292 : scanCanonicalize (H12AffineFastState.compose env2292 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 444) := by decide +kernel

theorem selectedBound2292 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2293 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,2316,1296,2341,2219,1296,2049,1024,2341,1297,261,16,139,2437,16,2049,1297,1297,2049,1285,444,256,153,1297,136]

theorem envBound2293 : H12AffineFastState.Bounded env2293 := by
  intro p hp
  have h : env2293.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2292_2293 : H12AffineEnvironment.transform 31 444 env2292 = env2293 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 444 env2292 == env2293) = true)

theorem identity2293 : scanCanonicalize (H12AffineFastState.compose env2293 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 173) := by decide +kernel

theorem selectedBound2293 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env2294 : List Nat := [2,4,8,16,32,16,128,173,137,1024,2048,1213,2209,1213,2184,2219,1213,2049,1024,2184,1212,168,16,139,2088,16,2049,1212,1212,2049,1192,17,173,153,1212,136]

theorem envBound2294 : H12AffineFastState.Bounded env2294 := by
  intro p hp
  have h : env2294.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2293_2294 : H12AffineEnvironment.transform 7 173 env2293 = env2294 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 173 env2293 == env2294) = true)

theorem identity2294 : scanCanonicalize (H12AffineFastState.compose env2294 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 26) := by decide +kernel

theorem selectedBound2294 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2295 : List Nat := [2,4,8,16,26,16,128,151,137,1024,2048,1159,2203,1159,2184,2193,1159,2049,1024,2184,1158,146,16,139,2066,16,2049,1158,1158,2049,1170,17,151,153,1158,136]

theorem envBound2295 : H12AffineFastState.Bounded env2295 := by
  intro p hp
  have h : env2295.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2294_2295 : H12AffineEnvironment.transform 4 26 env2294 = env2295 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 26 env2294 == env2295) = true)

def env2296 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,10249,5457,230469,8329,67108864,67516749,67110224,67245393,1073741824,67245381,4294967296,67113984,4362845670,131073,513]

theorem envBound2296 : H12AffineFastState.Bounded env2296 := by
  intro p hp
  have h : env2296.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2280_2296 : H12AffineEnvironment.transform 13 4177 env2280 = env2296 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env2280 == env2296) = true)

theorem identity2296 : scanCanonicalize (H12AffineFastState.compose env2296 (packedSelected [0,4,7,16,20,22] rootPS)) = affineNative (2^(29+1) ^^^ 67744131) := by decide +kernel

theorem selectedBound2296 : packedSelected [0,4,7,16,20,22] rootPS < 2^1333 := by decide +kernel

def env2297 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,10249,5457,230469,8329,67108864,67516749,67110224,67245393,67744131,67245381,4294967296,67113984,4362845670,131073,513]

theorem envBound2297 : H12AffineFastState.Bounded env2297 := by
  intro p hp
  have h : env2297.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2296_2297 : H12AffineEnvironment.transform 29 67744131 env2296 = env2297 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 67744131 env2296 == env2297) = true)

def env2298 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,8201,5457,230469,8329,67108864,67514701,67110224,67245393,67744131,67245381,4294967296,67113984,4362843622,131073,513]

theorem envBound2298 : H12AffineFastState.Bounded env2298 := by
  intro p hp
  have h : env2298.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2297_2298 : H12AffineEnvironment.transform 10 0 env2297 = env2298 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env2297 == env2298) = true)

def env2299 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,8201,5457,230469,8329,5376,402509,4176,131153,631939,131141,4294967296,256,4295729382,131073,513]

theorem envBound2299 : H12AffineFastState.Bounded env2299 := by
  intro p hp
  have h : env2299.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2298_2299 : H12AffineEnvironment.transform 25 5376 env2298 = env2299 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env2298 == env2299) = true)

theorem identity2299 : scanCanonicalize (H12AffineFastState.compose env2299 (packedSelected [11] rootPS)) = affineNative (2^(18+1) ^^^ 205422) := by decide +kernel

theorem selectedBound2299 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env2300 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,131072,262144,205422,32768,4097,8201,5457,230469,8329,5376,402509,4176,131153,165613,131141,4294967296,256,4295000712,131073,513]

theorem envBound2300 : H12AffineFastState.Bounded env2300 := by
  intro p hp
  have h : env2300.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2299_2300 : H12AffineEnvironment.transform 18 205422 env2299 = env2300 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 205422 env2299 == env2300) = true)

def env2301 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,131072,41000,205422,32768,4097,8201,5457,230469,8329,5376,164965,4176,131153,165613,131141,4294967296,256,4295000712,131073,513]

theorem envBound2301 : H12AffineFastState.Bounded env2301 := by
  intro p hp
  have h : env2301.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2300_2301 : H12AffineEnvironment.transform 17 41000 env2300 = env2301 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41000 env2300 == env2301) = true)

theorem identity2301 : scanCanonicalize (H12AffineFastState.compose env2301 (packedSelected [16,18] rootPS)) = affineNative (2^(16+1) ^^^ 9293) := by decide +kernel

theorem selectedBound2301 : packedSelected [16,18] rootPS < 2^1333 := by decide +kernel

def env2302 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,9293,41000,67107,32768,4097,8201,5457,106504,8329,5376,41000,4176,9244,41632,9224,4294967296,256,4295000712,9292,513]

theorem envBound2302 : H12AffineFastState.Bounded env2302 := by
  intro p hp
  have h : env2302.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2301_2302 : H12AffineEnvironment.transform 16 9293 env2301 = env2302 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 9293 env2301 == env2302) = true)

theorem identity2302 : scanCanonicalize (H12AffineFastState.compose env2302 (packedSelected [0,4,7,9,16] rootPS)) = affineNative (2^(14+1) ^^^ 293) := by decide +kernel

theorem selectedBound2302 : packedSelected [0,4,7,9,16] rootPS < 2^1333 := by decide +kernel

def env2303 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,293,65536,9293,8461,67107,293,4097,8201,5457,74029,8329,5376,8461,4176,9244,9093,9224,4294967296,256,4294968237,9292,513]

theorem envBound2303 : H12AffineFastState.Bounded env2303 := by
  intro p hp
  have h : env2303.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2302_2303 : H12AffineEnvironment.transform 14 293 env2302 = env2303 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 293 env2302 == env2303) = true)

theorem identity2303 : scanCanonicalize (H12AffineFastState.compose env2303 (packedSelected [2,5,6,7,8,9,10,12,17,20] rootPS)) = affineNative (2^(12+1) ^^^ 5148) := by decide +kernel

theorem selectedBound2303 : packedSelected [2,5,6,7,8,9,10,12,17,20] rootPS < 2^1333 := by decide +kernel

def env2304 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,5148,4177,293,65536,4177,5393,67107,293,4097,5141,5457,70961,5269,5376,5393,4176,4096,6041,4116,4294967296,256,4294968237,4176,513]

theorem envBound2304 : H12AffineFastState.Bounded env2304 := by
  intro p hp
  have h : env2304.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2303_2304 : H12AffineEnvironment.transform 12 5148 env2303 = env2304 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5148 env2303 == env2304) = true)

theorem identity2304 : scanCanonicalize (H12AffineFastState.compose env2304 (packedSelected [0,1,2,3,4,6,10,13,15] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound2304 : packedSelected [0,1,2,3,4,6,10,13,15] rootPS < 2^1333 := by decide +kernel

def env2305 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,268,1345,293,65536,1345,1,67107,293,1297,261,65,65569,389,16,1,1344,1296,649,1284,4294967296,256,4294968237,1344,513]

theorem envBound2305 : H12AffineFastState.Bounded env2305 := by
  intro p hp
  have h : env2305.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2304_2305 : H12AffineEnvironment.transform 11 1296 env2304 = env2305 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env2304 == env2305) = true)

theorem identity2305 : scanCanonicalize (H12AffineFastState.compose env2305 (packedSelected [0,7] rootPS)) = affineNative (2^(15+1) ^^^ 546) := by decide +kernel

theorem selectedBound2305 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env2306 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,268,1345,293,546,1345,1,1025,293,1297,261,65,515,389,16,1,1344,1296,649,1284,4294967296,256,4294968237,1344,513]

theorem envBound2306 : H12AffineFastState.Bounded env2306 := by
  intro p hp
  have h : env2306.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2305_2306 : H12AffineEnvironment.transform 15 546 env2305 = env2306 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 546 env2305 == env2306) = true)

theorem identity2306 : scanCanonicalize (H12AffineFastState.compose env2306 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound2306 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env2307 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1296,268,1345,293,171,1345,1,1025,293,1297,261,65,138,389,16,1,1344,1296,0,1284,4294967296,256,4294967588,1344,136]

theorem envBound2307 : H12AffineFastState.Bounded env2307 := by
  intro p hp
  have h : env2307.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2306_2307 : H12AffineEnvironment.transform 8 137 env2306 = env2307 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env2306 == env2307) = true)

theorem identity2307 : scanCanonicalize (H12AffineFastState.compose env2307 (packedSelected [1,3] rootPS)) = affineNative (2^(9+1) ^^^ 321) := by decide +kernel

theorem selectedBound2307 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env2308 : List Nat := [2,4,8,16,32,64,128,256,137,321,0,81,268,0,293,171,0,1,320,293,80,261,65,138,389,16,1,1,81,0,69,4294967296,256,4294967588,1,136]

theorem envBound2308 : H12AffineFastState.Bounded env2308 := by
  intro p hp
  have h : env2308.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2307_2308 : H12AffineEnvironment.transform 9 321 env2307 = env2308 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 321 env2307 == env2308) = true)

theorem identity2308 : scanCanonicalize (H12AffineFastState.compose env2308 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 156) := by decide +kernel

theorem selectedBound2308 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env2309 : List Nat := [2,4,8,16,32,64,128,156,137,221,0,81,144,0,185,171,0,1,220,185,80,153,65,138,25,16,1,1,81,0,69,4294967296,156,4294967480,1,136]

theorem envBound2309 : H12AffineFastState.Bounded env2309 := by
  intro p hp
  have h : env2309.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2308_2309 : H12AffineEnvironment.transform 7 156 env2308 = env2309 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 156 env2308 == env2309) = true)

theorem identity2309 : scanCanonicalize (H12AffineFastState.compose env2309 (packedSelected [5] rootPS)) = affineNative (2^(6+1) ^^^ 115) := by decide +kernel

theorem selectedBound2309 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env2310 : List Nat := [2,4,8,16,32,64,115,111,122,46,0,81,99,0,74,88,0,1,47,74,80,106,65,121,25,16,1,1,81,0,69,4294967296,111,4294967371,1,123]

theorem envBound2310 : H12AffineFastState.Bounded env2310 := by
  intro p hp
  have h : env2310.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2309_2310 : H12AffineEnvironment.transform 6 115 env2309 = env2310 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 115 env2309 == env2310) = true)

theorem identity2310 : scanCanonicalize (H12AffineFastState.compose env2310 (packedSelected [8] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound2310 : packedSelected [8] rootPS < 2^1333 := by decide +kernel

def env2311 : List Nat := [2,4,8,16,32,10,57,37,48,46,0,27,41,0,0,18,0,1,47,0,26,32,11,51,25,16,1,1,27,0,15,4294967296,37,4294967297,1,49]

theorem envBound2311 : H12AffineFastState.Bounded env2311 := by
  intro p hp
  have h : env2311.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2310_2311 : H12AffineEnvironment.transform 5 10 env2310 = env2311 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env2310 == env2311) = true)

theorem identity2311 : scanCanonicalize (H12AffineFastState.compose env2311 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 26) := by decide +kernel

theorem selectedBound2311 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2312 : List Nat := [2,4,8,16,32,10,57,37,48,46,0,27,41,0,0,18,0,1,47,0,26,32,11,51,25,16,1,1,27,0,15,26,37,27,1,49]

theorem envBound2312 : H12AffineFastState.Bounded env2312 := by
  intro p hp
  have h : env2312.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2311_2312 : H12AffineEnvironment.transform 31 26 env2311 = env2312 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 26 env2311 == env2312) = true)

theorem identity2312 : scanCanonicalize (H12AffineFastState.compose env2312 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 16) := by decide +kernel

theorem selectedBound2312 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2313 : List Nat := [2,4,8,16,16,10,9,21,0,30,0,27,25,0,0,18,0,1,31,0,26,16,11,3,25,16,1,1,27,0,15,26,21,27,1,1]

theorem envBound2313 : H12AffineFastState.Bounded env2313 := by
  intro p hp
  have h : env2313.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2312_2313 : H12AffineEnvironment.transform 4 16 env2312 = env2313 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env2312 == env2313) = true)

theorem identity2313 : scanCanonicalize (H12AffineFastState.compose env2313 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound2313 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2314 : List Nat := [2,4,8,0,0,10,9,5,0,14,0,11,9,0,0,2,0,1,15,0,10,0,11,3,9,0,1,1,11,0,15,10,5,11,1,1]

theorem envBound2314 : H12AffineFastState.Bounded env2314 := by
  intro p hp
  have h : env2314.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2313_2314 : H12AffineEnvironment.transform 3 0 env2313 = env2314 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env2313 == env2314) = true)

def env2315 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,131072,41001,205422,32768,4097,8201,5457,230469,8329,5376,164964,4176,131153,165613,131141,4294967296,256,4295000712,131073,513]

theorem envBound2315 : H12AffineFastState.Bounded env2315 := by
  intro p hp
  have h : env2315.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2300_2315 : H12AffineEnvironment.transform 17 41001 env2300 = env2315 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41001 env2300 == env2315) = true)

theorem identity2315 : scanCanonicalize (H12AffineFastState.compose env2315 (packedSelected [16,18] rootPS)) = affineNative (2^(14+1) ^^^ 8865) := by decide +kernel

theorem selectedBound2315 : packedSelected [16,18] rootPS < 2^1333 := by decide +kernel

def env2316 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,8865,65536,131072,648,205422,8865,4097,8201,5457,206564,8329,5376,140997,4176,131153,140364,131141,4294967296,256,4294975529,131073,513]

theorem envBound2316 : H12AffineFastState.Bounded env2316 := by
  intro p hp
  have h : env2316.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2315_2316 : H12AffineEnvironment.transform 14 8865 env2315 = env2316 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8865 env2315 == env2316) = true)

def env2317 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,8192,4177,8233,65536,131072,0,205030,8233,4097,8201,5457,205932,8329,5376,140365,4176,131153,140364,131141,4294967296,256,4294975529,131073,137]

theorem envBound2317 : H12AffineFastState.Bounded env2317 := by
  intro p hp
  have h : env2317.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2316_2317 : H12AffineEnvironment.transform 8 136 env2316 = env2317 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env2316 == env2317) = true)

theorem identity2317 : scanCanonicalize (H12AffineFastState.compose env2317 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(15+1) ^^^ 8615) := by decide +kernel

theorem selectedBound2317 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env2318 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,8192,4177,8233,8615,131072,0,131393,8233,4097,8201,5457,132555,8329,5376,140365,4176,131153,140364,131141,4294967296,256,4294975529,131073,137]

theorem envBound2318 : H12AffineFastState.Bounded env2318 := by
  intro p hp
  have h : env2318.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2317_2318 : H12AffineEnvironment.transform 15 8615 env2317 = env2318 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8615 env2317 == env2318) = true)

theorem identity2318 : scanCanonicalize (H12AffineFastState.compose env2318 (packedSelected [3,5,10,12] rootPS)) = affineNative (2^(12+1) ^^^ 5148) := by decide +kernel

theorem selectedBound2318 : packedSelected [3,5,10,12] rootPS < 2^1333 := by decide +kernel

def env2319 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,5148,4177,5173,5563,131072,0,131393,5173,4097,5141,5457,132555,5269,5376,135249,4176,131153,135248,131141,4294967296,256,4294972469,131073,137]

theorem envBound2319 : H12AffineFastState.Bounded env2319 := by
  intro p hp
  have h : env2319.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2318_2319 : H12AffineEnvironment.transform 12 5148 env2318 = env2319 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5148 env2318 == env2319) = true)

def env2320 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,8192,4177,8232,65536,131072,1,205031,8232,4097,8201,5457,205933,8329,5376,140364,4176,131153,140364,131141,4294967296,256,4294975529,131073,136]

theorem envBound2320 : H12AffineFastState.Bounded env2320 := by
  intro p hp
  have h : env2320.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2316_2320 : H12AffineEnvironment.transform 8 137 env2316 = env2320 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env2316 == env2320) = true)

theorem identity2320 : scanCanonicalize (H12AffineFastState.compose env2320 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(12+1) ^^^ 268) := by decide +kernel

theorem selectedBound2320 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env2321 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,268,4177,292,65536,131072,1,197099,292,4097,261,5457,197985,389,5376,132416,4176,131153,132416,131141,4294967296,256,4294967589,131073,136]

theorem envBound2321 : H12AffineFastState.Bounded env2321 := by
  intro p hp
  have h : env2321.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2320_2321 : H12AffineEnvironment.transform 12 268 env2320 = env2321 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 268 env2320 == env2321) = true)

def env2322 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,268,4177,292,65536,4524,1,69703,292,4097,261,5457,70861,389,5376,5356,4176,4605,5356,4585,4294967296,256,4294967589,4525,136]

theorem envBound2322 : H12AffineFastState.Bounded env2322 := by
  intro p hp
  have h : env2322.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2321_2322 : H12AffineEnvironment.transform 16 4524 env2321 = env2322 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4524 env2321 == env2322) = true)

theorem identity2322 : scanCanonicalize (H12AffineFastState.compose env2322 (packedSelected [3,5,10] rootPS)) = affineNative (2^(15+1) ^^^ 115) := by decide +kernel

theorem selectedBound2322 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env2323 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,268,4177,292,115,4524,1,4148,292,4097,261,5457,5310,389,5376,5356,4176,4605,5356,4585,4294967296,256,4294967589,4525,136]

theorem envBound2323 : H12AffineFastState.Bounded env2323 := by
  intro p hp
  have h : env2323.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2322_2323 : H12AffineEnvironment.transform 15 115 env2322 = env2323 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 115 env2322 == env2323) = true)

theorem identity2323 : scanCanonicalize (H12AffineFastState.compose env2323 (packedSelected [0,1,2,3,4,6] rootPS)) = affineNative (2^(6+1) ^^^ 89) := by decide +kernel

theorem selectedBound2323 : packedSelected [0,1,2,3,4,6] rootPS < 2^1333 := by decide +kernel

def env2324 : List Nat := [2,4,8,16,32,64,89,256,80,1024,0,4096,268,4177,292,115,4469,1,4148,292,4097,261,5457,5223,348,5376,5173,4176,4388,5173,4400,4294967296,256,4294967589,4468,81]

theorem envBound2324 : H12AffineFastState.Bounded env2324 := by
  intro p hp
  have h : env2324.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2323_2324 : H12AffineEnvironment.transform 6 89 env2323 = env2324 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env2323 == env2324) = true)

theorem identity2324 : scanCanonicalize (H12AffineFastState.compose env2324 (packedSelected [1,3] rootPS)) = affineNative (2^(11+1) ^^^ 1077) := by decide +kernel

theorem selectedBound2324 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env2325 : List Nat := [2,4,8,16,32,64,89,256,80,1024,0,1077,268,1124,292,115,1344,1,1025,292,1076,261,356,82,348,309,0,1125,1297,0,1285,4294967296,256,4294967589,1345,81]

theorem envBound2325 : H12AffineFastState.Bounded env2325 := by
  intro p hp
  have h : env2325.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2324_2325 : H12AffineEnvironment.transform 11 1077 env2324 = env2325 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1077 env2324 == env2325) = true)

theorem identity2325 : scanCanonicalize (H12AffineFastState.compose env2325 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 106) := by decide +kernel

theorem selectedBound2325 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2326 : List Nat := [2,4,8,16,32,64,89,256,80,1024,0,1077,268,1124,292,115,1344,1,1025,292,1076,261,356,82,348,309,0,1125,1297,0,1285,106,256,335,1345,81]

theorem envBound2326 : H12AffineFastState.Bounded env2326 := by
  intro p hp
  have h : env2326.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2325_2326 : H12AffineEnvironment.transform 31 106 env2325 = env2326 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 106 env2325 == env2326) = true)

def env2327 : List Nat := [2,4,8,16,32,16,9,256,0,1024,0,1077,268,1076,292,35,1296,1,1025,292,1076,261,308,2,268,309,0,1077,1297,0,1285,58,256,287,1297,1]

theorem envBound2327 : H12AffineFastState.Bounded env2327 := by
  intro p hp
  have h : env2327.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2326_2327 : H12AffineEnvironment.transform 5 16 env2326 = env2327 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env2326 == env2327) = true)

theorem identity2327 : scanCanonicalize (H12AffineFastState.compose env2327 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 53) := by decide +kernel

theorem selectedBound2327 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2328 : List Nat := [2,4,8,16,32,16,9,53,0,1024,0,1077,57,1076,17,35,1061,1,1025,17,1076,48,1,2,57,0,0,1077,1060,0,1072,58,53,42,1060,1]

theorem envBound2328 : H12AffineFastState.Bounded env2328 := by
  intro p hp
  have h : env2328.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2327_2328 : H12AffineEnvironment.transform 7 53 env2327 = env2328 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 53 env2327 == env2328) = true)

def env2329 : List Nat := [2,4,8,0,32,0,9,37,0,1024,0,1061,41,1060,1,35,1061,1,1025,1,1060,32,1,2,41,0,0,1061,1060,0,1056,42,37,42,1060,1]

theorem envBound2329 : H12AffineFastState.Bounded env2329 := by
  intro p hp
  have h : env2329.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2328_2329 : H12AffineEnvironment.transform 3 0 env2328 = env2329 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env2328 == env2329) = true)

theorem identity2329 : scanCanonicalize (H12AffineFastState.compose env2329 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound2329 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2330 : List Nat := [2,4,2,0,32,0,3,37,0,1024,0,1061,35,1060,1,35,1061,1,1025,1,1060,32,1,2,35,0,0,1061,1060,0,1056,32,37,32,1060,1]

theorem envBound2330 : H12AffineFastState.Bounded env2330 := by
  intro p hp
  have h : env2330.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2329_2330 : H12AffineEnvironment.transform 2 2 env2329 = env2330 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env2329 == env2330) = true)

def leafEnv2330 : List Nat := [2,4,2,0,32,0,3,37,0,1024,0,1061,35,1060,1,35,1061,1,1025,1,1060,32,1,2,1057,35,1,0,0,1061,1060,0,1056,32,37,32,4,34,1060,1,0,1061,1]

def active2330 : List Nat := [0,1,4,9]

def tree2330 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2330 : H12WitnessSearch.Good tree2330 := H12GlobalWitnessIndex.good

theorem leafIdentity2330 : H12AffineFastState.composeSystem env2330 rootObs = leafEnv2330 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2330 rootObs == leafEnv2330) = true)

theorem terminalChecked2330 : H12PackedTerminal.terminalCheckFast leafEnv2330 active2330 tree2330 = true := by decide +kernel

def env2331 : List Nat := [2,4,8,1,32,1,9,36,0,1024,0,1060,40,1061,0,35,1061,1,1025,0,1061,33,1,2,40,0,0,1060,1060,0,1057,43,36,42,1060,1]

theorem envBound2331 : H12AffineFastState.Bounded env2331 := by
  intro p hp
  have h : env2331.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2328_2331 : H12AffineEnvironment.transform 3 1 env2328 = env2331 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env2328 == env2331) = true)

def leafEnv2331 : List Nat := [2,4,8,1,32,1,9,36,0,1024,0,1060,40,1061,0,35,1061,1,1025,0,1061,33,1,2,1056,40,1,0,0,1060,1060,0,1057,43,36,42,4,34,1060,1,0,1061,1]

def active2331 : List Nat := [0,1,2,4,9]

def tree2331 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2331 : H12WitnessSearch.Good tree2331 := H12GlobalWitnessIndex.good

theorem leafIdentity2331 : H12AffineFastState.composeSystem env2331 rootObs = leafEnv2331 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2331 rootObs == leafEnv2331) = true)

theorem terminalChecked2331 : H12PackedTerminal.terminalCheckFast leafEnv2331 active2331 tree2331 = true := by decide +kernel

def env2332 : List Nat := [2,4,8,16,32,17,8,256,1,1024,0,1077,268,1077,292,34,1297,1,1025,292,1076,261,309,3,269,309,0,1076,1297,0,1285,59,256,286,1296,0]

theorem envBound2332 : H12AffineFastState.Bounded env2332 := by
  intro p hp
  have h : env2332.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2326_2332 : H12AffineEnvironment.transform 5 17 env2326 = env2332 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env2326 == env2332) = true)

theorem identity2332 : scanCanonicalize (H12AffineFastState.compose env2332 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound2332 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2333 : List Nat := [2,4,8,0,32,1,8,256,1,1024,0,1061,268,1061,292,34,1281,1,1025,292,1060,261,293,3,269,293,0,1060,1281,0,1285,43,256,270,1280,0]

theorem envBound2333 : H12AffineFastState.Bounded env2333 := by
  intro p hp
  have h : env2333.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2332_2333 : H12AffineEnvironment.transform 3 0 env2332 = env2333 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env2332 == env2333) = true)

def env2334 : List Nat := [2,4,8,0,32,1,8,36,1,1024,0,1061,40,1061,0,34,1061,1,1025,0,1060,33,1,3,41,1,0,1060,1061,0,1057,43,36,42,1060,0]

theorem envBound2334 : H12AffineFastState.Bounded env2334 := by
  intro p hp
  have h : env2334.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2333_2334 : H12AffineEnvironment.transform 7 36 env2333 = env2334 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env2333 == env2334) = true)

def leafEnv2334 : List Nat := [2,4,8,0,32,1,8,36,1,1024,0,1061,40,1061,0,34,1061,1,1025,0,1060,33,1,3,1056,41,1,1,0,1060,1061,0,1057,43,36,42,4,34,1060,0,0,1060,1]

def active2334 : List Nat := [0,1,2,4,9]

def tree2334 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2334 : H12WitnessSearch.Good tree2334 := H12GlobalWitnessIndex.good

theorem leafIdentity2334 : H12AffineFastState.composeSystem env2334 rootObs = leafEnv2334 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2334 rootObs == leafEnv2334) = true)

theorem terminalChecked2334 : H12PackedTerminal.terminalCheckFast leafEnv2334 active2334 tree2334 = true := by decide +kernel

def env2335 : List Nat := [2,4,8,0,32,1,8,37,1,1024,0,1061,41,1061,1,34,1060,1,1025,1,1060,32,0,3,40,0,0,1060,1060,0,1056,43,37,43,1061,0]

theorem envBound2335 : H12AffineFastState.Bounded env2335 := by
  intro p hp
  have h : env2335.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2333_2335 : H12AffineEnvironment.transform 7 37 env2333 = env2335 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env2333 == env2335) = true)

theorem identity2335 : scanCanonicalize (H12AffineFastState.compose env2335 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound2335 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2336 : List Nat := [2,4,3,0,32,1,3,37,1,1024,0,1061,34,1061,1,34,1060,1,1025,1,1060,32,0,3,35,0,0,1060,1060,0,1056,32,37,32,1061,0]

theorem envBound2336 : H12AffineFastState.Bounded env2336 := by
  intro p hp
  have h : env2336.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2335_2336 : H12AffineEnvironment.transform 2 3 env2335 = env2336 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env2335 == env2336) = true)

def leafEnv2336 : List Nat := [2,4,3,0,32,1,3,37,1,1024,0,1061,34,1061,1,34,1060,1,1025,1,1060,32,0,3,1057,35,1,0,0,1060,1060,0,1056,32,37,32,4,34,1061,0,0,1061,1]

def active2336 : List Nat := [0,1,4,9]

def tree2336 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2336 : H12WitnessSearch.Good tree2336 := H12GlobalWitnessIndex.good

theorem leafIdentity2336 : H12AffineFastState.composeSystem env2336 rootObs = leafEnv2336 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2336 rootObs == leafEnv2336) = true)

theorem terminalChecked2336 : H12PackedTerminal.terminalCheckFast leafEnv2336 active2336 tree2336 = true := by decide +kernel

def env2337 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,268,4177,292,65536,4525,1,69702,292,4097,261,5457,70860,389,5376,5357,4176,4604,5357,4584,4294967296,256,4294967589,4524,136]

theorem envBound2337 : H12AffineFastState.Bounded env2337 := by
  intro p hp
  have h : env2337.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2321_2337 : H12AffineEnvironment.transform 16 4525 env2321 = env2337 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4525 env2321 == env2337) = true)

theorem identity2337 : scanCanonicalize (H12AffineFastState.compose env2337 (packedSelected [3,5,10] rootPS)) = affineNative (2^(11+1) ^^^ 1077) := by decide +kernel

theorem selectedBound2337 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env2338 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1077,268,1124,292,65536,1432,1,66675,292,1076,261,356,65785,389,309,216,1125,1481,216,1501,4294967296,256,4294967589,1433,136]

theorem envBound2338 : H12AffineFastState.Bounded env2338 := by
  intro p hp
  have h : env2338.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2337_2338 : H12AffineEnvironment.transform 11 1077 env2337 = env2338 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1077 env2337 == env2338) = true)

theorem identity2338 : scanCanonicalize (H12AffineFastState.compose env2338 (packedSelected [1,3] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound2338 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env2339 : List Nat := [2,4,8,16,32,64,88,256,81,1024,0,1077,268,1124,292,65536,1344,1,66675,292,1076,261,356,65569,349,309,0,1125,1297,0,1285,4294967296,256,4294967589,1345,80]

theorem envBound2339 : H12AffineFastState.Bounded env2339 := by
  intro p hp
  have h : env2339.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2338_2339 : H12AffineEnvironment.transform 6 88 env2338 = env2339 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env2338 == env2339) = true)

def env2340 : List Nat := [2,4,8,16,32,64,88,36,81,1024,0,1077,40,1124,0,65536,1124,1,66675,0,1076,33,64,65569,121,17,0,1125,1077,0,1057,4294967296,36,4294967297,1125,80]

theorem envBound2340 : H12AffineFastState.Bounded env2340 := by
  intro p hp
  have h : env2340.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2339_2340 : H12AffineEnvironment.transform 7 36 env2339 = env2340 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env2339 == env2340) = true)

theorem identity2340 : scanCanonicalize (H12AffineFastState.compose env2340 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 65624) := by decide +kernel

theorem selectedBound2340 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2341 : List Nat := [2,4,8,16,32,64,88,36,81,1024,0,1077,40,1124,0,65536,1124,1,66675,0,1076,33,64,65569,121,17,0,1125,1077,0,1057,65624,36,65625,1125,80]

theorem envBound2341 : H12AffineFastState.Bounded env2341 := by
  intro p hp
  have h : env2341.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2340_2341 : H12AffineEnvironment.transform 31 65624 env2340 = env2341 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65624 env2340 == env2341) = true)

theorem identity2341 : scanCanonicalize (H12AffineFastState.compose env2341 (packedSelected [4] rootPS)) = affineNative (2^(5+1) ^^^ 0) := by decide +kernel

theorem selectedBound2341 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env2342 : List Nat := [2,4,8,16,32,0,24,36,17,1024,0,1077,40,1060,0,65536,1060,1,66611,0,1076,33,0,65569,57,17,0,1061,1077,0,1057,65560,36,65561,1061,16]

theorem envBound2342 : H12AffineFastState.Bounded env2342 := by
  intro p hp
  have h : env2342.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2341_2342 : H12AffineEnvironment.transform 5 0 env2341 = env2342 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env2341 == env2342) = true)

def env2343 : List Nat := [2,4,8,16,32,0,24,36,17,1024,0,1077,40,1060,0,24,1060,1,1067,0,1076,33,0,57,57,17,0,1061,1077,0,1057,0,36,1,1061,16]

theorem envBound2343 : H12AffineFastState.Bounded env2343 := by
  intro p hp
  have h : env2343.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2342_2343 : H12AffineEnvironment.transform 15 24 env2342 = env2343 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 24 env2342 == env2343) = true)

def env2344 : List Nat := [2,4,8,16,32,0,24,36,17,1024,0,1077,40,1060,0,25,1060,1,1066,0,1076,33,0,56,57,17,0,1061,1077,0,1057,1,36,0,1061,16]

theorem envBound2344 : H12AffineFastState.Bounded env2344 := by
  intro p hp
  have h : env2344.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2342_2344 : H12AffineEnvironment.transform 15 25 env2342 = env2344 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 25 env2342 == env2344) = true)

theorem identity2344 : scanCanonicalize (H12AffineFastState.compose env2344 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound2344 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2345 : List Nat := [2,4,8,16,10,0,24,14,17,1024,0,1055,2,1038,0,25,1038,1,1024,0,1054,11,0,18,19,17,0,1039,1055,0,1035,1,14,0,1039,16]

theorem envBound2345 : H12AffineFastState.Bounded env2345 := by
  intro p hp
  have h : env2345.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2344_2345 : H12AffineEnvironment.transform 4 10 env2344 = env2345 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env2344 == env2345) = true)

theorem identity2345 : scanCanonicalize (H12AffineFastState.compose env2345 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound2345 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2346 : List Nat := [2,4,2,16,0,0,18,4,17,1024,0,1045,2,1028,0,19,1028,1,1024,0,1044,1,0,18,19,17,0,1029,1045,0,1025,1,4,0,1029,16]

theorem envBound2346 : H12AffineFastState.Bounded env2346 := by
  intro p hp
  have h : env2346.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2345_2346 : H12AffineEnvironment.transform 2 2 env2345 = env2346 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env2345 == env2346) = true)

def leafEnv2346 : List Nat := [2,4,2,16,0,0,18,4,17,1024,0,1045,2,1028,0,19,1028,1,1024,0,1044,1,0,18,1025,19,1,17,0,1029,1045,0,1025,1,4,0,4,2,1029,16,0,1044,1]

def active2346 : List Nat := [0,1,3,9]

def tree2346 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2346 : H12WitnessSearch.Good tree2346 := H12GlobalWitnessIndex.good

theorem leafIdentity2346 : H12AffineFastState.composeSystem env2346 rootObs = leafEnv2346 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2346 rootObs == leafEnv2346) = true)

theorem terminalChecked2346 : H12PackedTerminal.terminalCheckFast leafEnv2346 active2346 tree2346 = true := by decide +kernel

def env2347 : List Nat := [2,4,8,16,32,64,88,37,81,1024,0,1077,41,1124,1,65536,1125,1,66675,1,1076,32,65,65569,120,16,0,1125,1076,0,1056,4294967296,37,4294967296,1124,80]

theorem envBound2347 : H12AffineFastState.Bounded env2347 := by
  intro p hp
  have h : env2347.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2339_2347 : H12AffineEnvironment.transform 7 37 env2339 = env2347 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env2339 == env2347) = true)

theorem identity2347 : scanCanonicalize (H12AffineFastState.compose env2347 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 122) := by decide +kernel

theorem selectedBound2347 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2348 : List Nat := [2,4,8,16,32,64,88,37,81,1024,0,1077,41,1124,1,65536,1125,1,66675,1,1076,32,65,65569,120,16,0,1125,1076,0,1056,122,37,122,1124,80]

theorem envBound2348 : H12AffineFastState.Bounded env2348 := by
  intro p hp
  have h : env2348.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2347_2348 : H12AffineEnvironment.transform 31 122 env2347 = env2348 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 122 env2347 == env2348) = true)

theorem identity2348 : scanCanonicalize (H12AffineFastState.compose env2348 (packedSelected [4] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound2348 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env2349 : List Nat := [2,4,8,16,32,11,19,37,26,1024,0,1077,41,1071,1,65536,1070,1,66616,1,1076,32,10,65569,51,16,0,1070,1076,0,1056,49,37,49,1071,27]

theorem envBound2349 : H12AffineFastState.Bounded env2349 := by
  intro p hp
  have h : env2349.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2348_2349 : H12AffineEnvironment.transform 5 11 env2348 = env2349 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env2348 == env2349) = true)

theorem identity2349 : scanCanonicalize (H12AffineFastState.compose env2349 (packedSelected [1,2] rootPS)) = affineNative (2^(15+1) ^^^ 40) := by decide +kernel

theorem selectedBound2349 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env2350 : List Nat := [2,4,8,16,32,11,19,37,26,1024,0,1077,41,1071,1,40,1070,1,1040,1,1076,32,10,9,51,16,0,1070,1076,0,1056,49,37,49,1071,27]

theorem envBound2350 : H12AffineFastState.Bounded env2350 := by
  intro p hp
  have h : env2350.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2349_2350 : H12AffineEnvironment.transform 15 40 env2349 = env2350 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 40 env2349 == env2350) = true)

def env2351 : List Nat := [2,4,8,16,0,11,19,5,26,1024,0,1045,9,1039,1,8,1038,1,1040,1,1044,0,10,9,19,16,0,1038,1044,0,1024,17,5,17,1039,27]

theorem envBound2351 : H12AffineFastState.Bounded env2351 := by
  intro p hp
  have h : env2351.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2350_2351 : H12AffineEnvironment.transform 4 0 env2350 = env2351 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env2350 == env2351) = true)

def env2352 : List Nat := [2,4,8,16,1,11,19,4,26,1024,0,1044,8,1038,1,9,1039,1,1040,1,1045,1,10,9,18,16,0,1039,1045,0,1025,16,4,16,1038,27]

theorem envBound2352 : H12AffineFastState.Bounded env2352 := by
  intro p hp
  have h : env2352.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2350_2352 : H12AffineEnvironment.transform 4 1 env2350 = env2352 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env2350 == env2352) = true)

theorem identity2352 : scanCanonicalize (H12AffineFastState.compose env2352 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound2352 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2353 : List Nat := [2,4,8,0,1,11,3,4,10,1024,0,1028,8,1038,1,9,1039,1,1024,1,1029,1,10,9,2,0,0,1039,1029,0,1025,0,4,0,1038,11]

theorem envBound2353 : H12AffineFastState.Bounded env2353 := by
  intro p hp
  have h : env2353.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2352_2353 : H12AffineEnvironment.transform 3 0 env2352 = env2353 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env2352 == env2353) = true)

def leafEnv2353 : List Nat := [2,4,8,0,1,11,3,4,10,1024,0,1028,8,1038,1,9,1039,1,1024,1,1029,1,10,9,1025,2,1,0,0,1039,1029,0,1025,0,4,0,4,3,1038,11,0,1028,1]

def active2353 : List Nat := [0,1,2,9]

def tree2353 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2353 : H12WitnessSearch.Good tree2353 := H12GlobalWitnessIndex.good

theorem leafIdentity2353 : H12AffineFastState.composeSystem env2353 rootObs = leafEnv2353 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2353 rootObs == leafEnv2353) = true)

theorem terminalChecked2353 : H12PackedTerminal.terminalCheckFast leafEnv2353 active2353 tree2353 = true := by decide +kernel

def env2354 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,8201,5457,230469,8329,5377,402508,4177,131152,631938,131140,4294967296,257,4295729383,131073,513]

theorem envBound2354 : H12AffineFastState.Bounded env2354 := by
  intro p hp
  have h : env2354.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2298_2354 : H12AffineEnvironment.transform 25 5377 env2298 = env2354 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env2298 == env2354) = true)

theorem identity2354 : scanCanonicalize (H12AffineFastState.compose env2354 (packedSelected [11] rootPS)) = affineNative (2^(18+1) ^^^ 79742) := by decide +kernel

theorem selectedBound2354 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env2355 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,131072,262144,79742,32768,4097,8201,5457,230469,8329,5377,402508,4177,131152,37884,131140,4294967296,257,4295137177,131073,513]

theorem envBound2355 : H12AffineFastState.Bounded env2355 := by
  intro p hp
  have h : env2355.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2354_2355 : H12AffineEnvironment.transform 18 79742 env2354 = env2355 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 79742 env2354 == env2355) = true)

theorem identity2355 : scanCanonicalize (H12AffineFastState.compose env2355 (packedSelected [6,25] rootPS)) = affineNative (2^(15+1) ^^^ 13182) := by decide +kernel

theorem selectedBound2355 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env2356 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,13182,131072,262144,1024,32768,4097,8201,5457,177979,8329,5377,402508,4177,131152,37884,131140,4294967296,257,4295137177,131073,513]

theorem envBound2356 : H12AffineFastState.Bounded env2356 := by
  intro p hp
  have h : env2356.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2355_2356 : H12AffineEnvironment.transform 15 13182 env2355 = env2356 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13182 env2355 == env2356) = true)

def env2357 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,8200,5457,230469,8329,67108864,67514700,67110224,67245393,67744131,67245381,4294967296,67113984,4362843623,131073,513]

theorem envBound2357 : H12AffineFastState.Bounded env2357 := by
  intro p hp
  have h : env2357.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2297_2357 : H12AffineEnvironment.transform 10 1 env2297 = env2357 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env2297 == env2357) = true)

def env2358 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,8200,5457,230469,8329,5376,402508,4176,131153,631939,131141,4294967296,256,4295729383,131073,513]

theorem envBound2358 : H12AffineFastState.Bounded env2358 := by
  intro p hp
  have h : env2358.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2357_2358 : H12AffineEnvironment.transform 25 5376 env2357 = env2358 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env2357 == env2358) = true)

theorem identity2358 : scanCanonicalize (H12AffineFastState.compose env2358 (packedSelected [11] rootPS)) = affineNative (2^(18+1) ^^^ 492102) := by decide +kernel

theorem selectedBound2358 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env2359 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,131072,262144,492102,32768,4097,8200,5457,230469,8329,5376,402508,4176,131153,403141,131141,4294967296,256,4295238305,131073,513]

theorem envBound2359 : H12AffineFastState.Bounded env2359 := by
  intro p hp
  have h : env2359.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2358_2359 : H12AffineEnvironment.transform 18 492102 env2358 = env2359 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 492102 env2358 == env2359) = true)

def env2360 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,131072,41000,205422,32768,4097,8200,5457,230469,8329,5376,164964,4176,131153,165613,131141,4294967296,256,4295000713,131073,513]

theorem envBound2360 : H12AffineFastState.Bounded env2360 := by
  intro p hp
  have h : env2360.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2359_2360 : H12AffineEnvironment.transform 17 41000 env2359 = env2360 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41000 env2359 == env2360) = true)

theorem identity2360 : scanCanonicalize (H12AffineFastState.compose env2360 (packedSelected [16,18] rootPS)) = affineNative (2^(14+1) ^^^ 8865) := by decide +kernel

theorem selectedBound2360 : packedSelected [16,18] rootPS < 2^1333 := by decide +kernel

def env2361 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,8865,65536,131072,649,205422,8865,4097,8200,5457,206564,8329,5376,140997,4176,131153,140364,131141,4294967296,256,4294975528,131073,513]

theorem envBound2361 : H12AffineFastState.Bounded env2361 := by
  intro p hp
  have h : env2361.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2360_2361 : H12AffineEnvironment.transform 14 8865 env2360 = env2361 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8865 env2360 == env2361) = true)

def env2362 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,4096,8192,4177,8233,65536,131072,1,205030,8233,4097,8200,5457,205932,8329,5376,140365,4176,131153,140364,131141,4294967296,256,4294975528,131073,137]

theorem envBound2362 : H12AffineFastState.Bounded env2362 := by
  intro p hp
  have h : env2362.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2361_2362 : H12AffineEnvironment.transform 8 136 env2361 = env2362 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env2361 == env2362) = true)

theorem identity2362 : scanCanonicalize (H12AffineFastState.compose env2362 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(15+1) ^^^ 8615) := by decide +kernel

theorem selectedBound2362 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env2363 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,4096,8192,4177,8233,8615,131072,1,131393,8233,4097,8200,5457,132555,8329,5376,140365,4176,131153,140364,131141,4294967296,256,4294975528,131073,137]

theorem envBound2363 : H12AffineFastState.Bounded env2363 := by
  intro p hp
  have h : env2363.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2362_2363 : H12AffineEnvironment.transform 15 8615 env2362 = env2363 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8615 env2362 == env2363) = true)

theorem identity2363 : scanCanonicalize (H12AffineFastState.compose env2363 (packedSelected [3,5,10,12] rootPS)) = affineNative (2^(12+1) ^^^ 5149) := by decide +kernel

theorem selectedBound2363 : packedSelected [3,5,10,12] rootPS < 2^1333 := by decide +kernel

def env2364 : List Nat := [2,4,8,16,32,64,128,256,136,1024,1,4096,5149,4177,5172,5562,131072,1,131393,5172,4097,5141,5457,132555,5268,5376,135248,4176,131153,135249,131141,4294967296,256,4294972469,131073,137]

theorem envBound2364 : H12AffineFastState.Bounded env2364 := by
  intro p hp
  have h : env2364.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2363_2364 : H12AffineEnvironment.transform 12 5149 env2363 = env2364 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5149 env2363 == env2364) = true)

def env2365 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,4096,8192,4177,8232,65536,131072,0,205031,8232,4097,8200,5457,205933,8329,5376,140364,4176,131153,140364,131141,4294967296,256,4294975528,131073,136]

theorem envBound2365 : H12AffineFastState.Bounded env2365 := by
  intro p hp
  have h : env2365.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2361_2365 : H12AffineEnvironment.transform 8 137 env2361 = env2365 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env2361 == env2365) = true)

theorem identity2365 : scanCanonicalize (H12AffineFastState.compose env2365 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(12+1) ^^^ 269) := by decide +kernel

theorem selectedBound2365 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env2366 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,4096,269,4177,293,65536,131072,0,197098,293,4097,261,5457,197984,388,5376,132417,4176,131153,132417,131141,4294967296,256,4294967589,131073,136]

theorem envBound2366 : H12AffineFastState.Bounded env2366 := by
  intro p hp
  have h : env2366.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2365_2366 : H12AffineEnvironment.transform 12 269 env2365 = env2366 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 269 env2365 == env2366) = true)

def env2367 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,4096,269,4177,293,65536,4524,0,69702,293,4097,261,5457,70860,388,5376,5357,4176,4605,5357,4585,4294967296,256,4294967589,4525,136]

theorem envBound2367 : H12AffineFastState.Bounded env2367 := by
  intro p hp
  have h : env2367.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2366_2367 : H12AffineEnvironment.transform 16 4524 env2366 = env2367 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4524 env2366 == env2367) = true)

theorem identity2367 : scanCanonicalize (H12AffineFastState.compose env2367 (packedSelected [3,5,10] rootPS)) = affineNative (2^(15+1) ^^^ 114) := by decide +kernel

theorem selectedBound2367 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env2368 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,4096,269,4177,293,114,4524,0,4148,293,4097,261,5457,5310,388,5376,5357,4176,4605,5357,4585,4294967296,256,4294967589,4525,136]

theorem envBound2368 : H12AffineFastState.Bounded env2368 := by
  intro p hp
  have h : env2368.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2367_2368 : H12AffineEnvironment.transform 15 114 env2367 = env2368 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 114 env2367 == env2368) = true)

theorem identity2368 : scanCanonicalize (H12AffineFastState.compose env2368 (packedSelected [0,1,2,3,4,6] rootPS)) = affineNative (2^(6+1) ^^^ 89) := by decide +kernel

theorem selectedBound2368 : packedSelected [0,1,2,3,4,6] rootPS < 2^1333 := by decide +kernel

def env2369 : List Nat := [2,4,8,16,32,64,89,256,80,1024,1,4096,269,4177,293,114,4469,0,4148,293,4097,261,5457,5223,349,5376,5172,4176,4388,5172,4400,4294967296,256,4294967589,4468,81]

theorem envBound2369 : H12AffineFastState.Bounded env2369 := by
  intro p hp
  have h : env2369.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2368_2369 : H12AffineEnvironment.transform 6 89 env2368 = env2369 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env2368 == env2369) = true)

theorem identity2369 : scanCanonicalize (H12AffineFastState.compose env2369 (packedSelected [1,3] rootPS)) = affineNative (2^(11+1) ^^^ 1077) := by decide +kernel

theorem selectedBound2369 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env2370 : List Nat := [2,4,8,16,32,64,89,256,80,1024,1,1077,269,1124,293,114,1344,0,1025,293,1076,261,356,82,349,309,1,1125,1297,1,1285,4294967296,256,4294967589,1345,81]

theorem envBound2370 : H12AffineFastState.Bounded env2370 := by
  intro p hp
  have h : env2370.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2369_2370 : H12AffineEnvironment.transform 11 1077 env2369 = env2370 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1077 env2369 == env2370) = true)

theorem identity2370 : scanCanonicalize (H12AffineFastState.compose env2370 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 106) := by decide +kernel

theorem selectedBound2370 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2371 : List Nat := [2,4,8,16,32,64,89,256,80,1024,1,1077,269,1124,293,114,1344,0,1025,293,1076,261,356,82,349,309,1,1125,1297,1,1285,106,256,335,1345,81]

theorem envBound2371 : H12AffineFastState.Bounded env2371 := by
  intro p hp
  have h : env2371.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2370_2371 : H12AffineEnvironment.transform 31 106 env2370 = env2371 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 106 env2370 == env2371) = true)

def env2372 : List Nat := [2,4,8,16,32,16,9,256,0,1024,1,1077,269,1076,293,34,1296,0,1025,293,1076,261,308,2,269,309,1,1077,1297,1,1285,58,256,287,1297,1]

theorem envBound2372 : H12AffineFastState.Bounded env2372 := by
  intro p hp
  have h : env2372.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2371_2372 : H12AffineEnvironment.transform 5 16 env2371 = env2372 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env2371 == env2372) = true)

theorem identity2372 : scanCanonicalize (H12AffineFastState.compose env2372 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 53) := by decide +kernel

theorem selectedBound2372 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2373 : List Nat := [2,4,8,16,32,16,9,53,0,1024,1,1077,56,1076,16,34,1061,0,1025,16,1076,48,1,2,56,0,1,1077,1060,1,1072,58,53,42,1060,1]

theorem envBound2373 : H12AffineFastState.Bounded env2373 := by
  intro p hp
  have h : env2373.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2372_2373 : H12AffineEnvironment.transform 7 53 env2372 = env2373 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 53 env2372 == env2373) = true)

def env2374 : List Nat := [2,4,8,0,32,0,9,37,0,1024,1,1061,40,1060,0,34,1061,0,1025,0,1060,32,1,2,40,0,1,1061,1060,1,1056,42,37,42,1060,1]

theorem envBound2374 : H12AffineFastState.Bounded env2374 := by
  intro p hp
  have h : env2374.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2373_2374 : H12AffineEnvironment.transform 3 0 env2373 = env2374 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env2373 == env2374) = true)

theorem identity2374 : scanCanonicalize (H12AffineFastState.compose env2374 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound2374 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2375 : List Nat := [2,4,2,0,32,0,3,37,0,1024,1,1061,34,1060,0,34,1061,0,1025,0,1060,32,1,2,34,0,1,1061,1060,1,1056,32,37,32,1060,1]

theorem envBound2375 : H12AffineFastState.Bounded env2375 := by
  intro p hp
  have h : env2375.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2374_2375 : H12AffineEnvironment.transform 2 2 env2374 = env2375 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env2374 == env2375) = true)

def leafEnv2375 : List Nat := [2,4,2,0,32,0,3,37,0,1024,1,1061,34,1060,0,34,1061,0,1025,0,1060,32,1,2,1057,34,1,0,1,1061,1060,1,1056,32,37,32,4,35,1060,1,0,1061,1]

def active2375 : List Nat := [0,1,4,9]

def tree2375 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2375 : H12WitnessSearch.Good tree2375 := H12GlobalWitnessIndex.good

theorem leafIdentity2375 : H12AffineFastState.composeSystem env2375 rootObs = leafEnv2375 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2375 rootObs == leafEnv2375) = true)

theorem terminalChecked2375 : H12PackedTerminal.terminalCheckFast leafEnv2375 active2375 tree2375 = true := by decide +kernel

def env2376 : List Nat := [2,4,8,1,32,1,9,36,0,1024,1,1060,41,1061,1,34,1061,0,1025,1,1061,33,1,2,41,0,1,1060,1060,1,1057,43,36,42,1060,1]

theorem envBound2376 : H12AffineFastState.Bounded env2376 := by
  intro p hp
  have h : env2376.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2373_2376 : H12AffineEnvironment.transform 3 1 env2373 = env2376 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env2373 == env2376) = true)

def leafEnv2376 : List Nat := [2,4,8,1,32,1,9,36,0,1024,1,1060,41,1061,1,34,1061,0,1025,1,1061,33,1,2,1056,41,1,0,1,1060,1060,1,1057,43,36,42,4,35,1060,1,0,1061,1]

def active2376 : List Nat := [0,1,2,4,9]

def tree2376 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2376 : H12WitnessSearch.Good tree2376 := H12GlobalWitnessIndex.good

theorem leafIdentity2376 : H12AffineFastState.composeSystem env2376 rootObs = leafEnv2376 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2376 rootObs == leafEnv2376) = true)

theorem terminalChecked2376 : H12PackedTerminal.terminalCheckFast leafEnv2376 active2376 tree2376 = true := by decide +kernel

def env2377 : List Nat := [2,4,8,16,32,17,8,256,1,1024,1,1077,269,1077,293,35,1297,0,1025,293,1076,261,309,3,268,309,1,1076,1297,1,1285,59,256,286,1296,0]

theorem envBound2377 : H12AffineFastState.Bounded env2377 := by
  intro p hp
  have h : env2377.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2371_2377 : H12AffineEnvironment.transform 5 17 env2371 = env2377 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env2371 == env2377) = true)

theorem identity2377 : scanCanonicalize (H12AffineFastState.compose env2377 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound2377 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2378 : List Nat := [2,4,8,0,32,1,8,256,1,1024,1,1061,269,1061,293,35,1281,0,1025,293,1060,261,293,3,268,293,1,1060,1281,1,1285,43,256,270,1280,0]

theorem envBound2378 : H12AffineFastState.Bounded env2378 := by
  intro p hp
  have h : env2378.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2377_2378 : H12AffineEnvironment.transform 3 0 env2377 = env2378 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env2377 == env2378) = true)

def env2379 : List Nat := [2,4,8,0,32,1,8,36,1,1024,1,1061,41,1061,1,35,1061,0,1025,1,1060,33,1,3,40,1,1,1060,1061,1,1057,43,36,42,1060,0]

theorem envBound2379 : H12AffineFastState.Bounded env2379 := by
  intro p hp
  have h : env2379.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2378_2379 : H12AffineEnvironment.transform 7 36 env2378 = env2379 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env2378 == env2379) = true)

def leafEnv2379 : List Nat := [2,4,8,0,32,1,8,36,1,1024,1,1061,41,1061,1,35,1061,0,1025,1,1060,33,1,3,1056,40,1,1,1,1060,1061,1,1057,43,36,42,4,35,1060,0,0,1060,1]

def active2379 : List Nat := [0,1,2,4,9]

def tree2379 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2379 : H12WitnessSearch.Good tree2379 := H12GlobalWitnessIndex.good

theorem leafIdentity2379 : H12AffineFastState.composeSystem env2379 rootObs = leafEnv2379 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2379 rootObs == leafEnv2379) = true)

theorem terminalChecked2379 : H12PackedTerminal.terminalCheckFast leafEnv2379 active2379 tree2379 = true := by decide +kernel

def env2380 : List Nat := [2,4,8,0,32,1,8,37,1,1024,1,1061,40,1061,0,35,1060,0,1025,0,1060,32,0,3,41,0,1,1060,1060,1,1056,43,37,43,1061,0]

theorem envBound2380 : H12AffineFastState.Bounded env2380 := by
  intro p hp
  have h : env2380.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2378_2380 : H12AffineEnvironment.transform 7 37 env2378 = env2380 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env2378 == env2380) = true)

theorem identity2380 : scanCanonicalize (H12AffineFastState.compose env2380 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound2380 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2381 : List Nat := [2,4,3,0,32,1,3,37,1,1024,1,1061,35,1061,0,35,1060,0,1025,0,1060,32,0,3,34,0,1,1060,1060,1,1056,32,37,32,1061,0]

theorem envBound2381 : H12AffineFastState.Bounded env2381 := by
  intro p hp
  have h : env2381.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2380_2381 : H12AffineEnvironment.transform 2 3 env2380 = env2381 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env2380 == env2381) = true)

def leafEnv2381 : List Nat := [2,4,3,0,32,1,3,37,1,1024,1,1061,35,1061,0,35,1060,0,1025,0,1060,32,0,3,1057,34,1,0,1,1060,1060,1,1056,32,37,32,4,35,1061,0,0,1061,1]

def active2381 : List Nat := [0,1,4,9]

def tree2381 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2381 : H12WitnessSearch.Good tree2381 := H12GlobalWitnessIndex.good

theorem leafIdentity2381 : H12AffineFastState.composeSystem env2381 rootObs = leafEnv2381 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2381 rootObs == leafEnv2381) = true)

theorem terminalChecked2381 : H12PackedTerminal.terminalCheckFast leafEnv2381 active2381 tree2381 = true := by decide +kernel

def env2382 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,4096,269,4177,293,65536,4525,0,69703,293,4097,261,5457,70861,388,5376,5356,4176,4604,5356,4584,4294967296,256,4294967589,4524,136]

theorem envBound2382 : H12AffineFastState.Bounded env2382 := by
  intro p hp
  have h : env2382.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2366_2382 : H12AffineEnvironment.transform 16 4525 env2366 = env2382 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4525 env2366 == env2382) = true)

theorem identity2382 : scanCanonicalize (H12AffineFastState.compose env2382 (packedSelected [3,5,10] rootPS)) = affineNative (2^(11+1) ^^^ 1077) := by decide +kernel

theorem selectedBound2382 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env2383 : List Nat := [2,4,8,16,32,64,128,256,137,1024,1,1077,269,1124,293,65536,1432,0,66674,293,1076,261,356,65784,388,309,217,1125,1481,217,1501,4294967296,256,4294967589,1433,136]

theorem envBound2383 : H12AffineFastState.Bounded env2383 := by
  intro p hp
  have h : env2383.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2382_2383 : H12AffineEnvironment.transform 11 1077 env2382 = env2383 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1077 env2382 == env2383) = true)

theorem identity2383 : scanCanonicalize (H12AffineFastState.compose env2383 (packedSelected [1,3] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound2383 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env2384 : List Nat := [2,4,8,16,32,64,88,256,81,1024,1,1077,269,1124,293,65536,1344,0,66674,293,1076,261,356,65568,348,309,1,1125,1297,1,1285,4294967296,256,4294967589,1345,80]

theorem envBound2384 : H12AffineFastState.Bounded env2384 := by
  intro p hp
  have h : env2384.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2383_2384 : H12AffineEnvironment.transform 6 88 env2383 = env2384 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env2383 == env2384) = true)

def env2385 : List Nat := [2,4,8,16,32,64,88,36,81,1024,1,1077,41,1124,1,65536,1124,0,66674,1,1076,33,64,65568,120,17,1,1125,1077,1,1057,4294967296,36,4294967297,1125,80]

theorem envBound2385 : H12AffineFastState.Bounded env2385 := by
  intro p hp
  have h : env2385.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2384_2385 : H12AffineEnvironment.transform 7 36 env2384 = env2385 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env2384 == env2385) = true)

theorem identity2385 : scanCanonicalize (H12AffineFastState.compose env2385 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 42) := by decide +kernel

theorem selectedBound2385 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2386 : List Nat := [2,4,8,16,32,64,88,36,81,1024,1,1077,41,1124,1,65536,1124,0,66674,1,1076,33,64,65568,120,17,1,1125,1077,1,1057,42,36,43,1125,80]

theorem envBound2386 : H12AffineFastState.Bounded env2386 := by
  intro p hp
  have h : env2386.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2385_2386 : H12AffineEnvironment.transform 31 42 env2385 = env2386 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 42 env2385 == env2386) = true)

theorem identity2386 : scanCanonicalize (H12AffineFastState.compose env2386 (packedSelected [4] rootPS)) = affineNative (2^(5+1) ^^^ 0) := by decide +kernel

theorem selectedBound2386 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env2387 : List Nat := [2,4,8,16,32,0,24,36,17,1024,1,1077,41,1060,1,65536,1060,0,66610,1,1076,33,0,65568,56,17,1,1061,1077,1,1057,42,36,43,1061,16]

theorem envBound2387 : H12AffineFastState.Bounded env2387 := by
  intro p hp
  have h : env2387.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2386_2387 : H12AffineEnvironment.transform 5 0 env2386 = env2387 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 0 env2386 == env2387) = true)

def env2388 : List Nat := [2,4,8,16,32,0,24,36,17,1024,1,1077,41,1060,1,24,1060,0,1066,1,1076,33,0,56,56,17,1,1061,1077,1,1057,42,36,43,1061,16]

theorem envBound2388 : H12AffineFastState.Bounded env2388 := by
  intro p hp
  have h : env2388.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2387_2388 : H12AffineEnvironment.transform 15 24 env2387 = env2388 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 24 env2387 == env2388) = true)

theorem identity2388 : scanCanonicalize (H12AffineFastState.compose env2388 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound2388 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2389 : List Nat := [2,4,8,16,10,0,24,14,17,1024,1,1055,3,1038,1,24,1038,0,1024,1,1054,11,0,18,18,17,1,1039,1055,1,1035,0,14,1,1039,16]

theorem envBound2389 : H12AffineFastState.Bounded env2389 := by
  intro p hp
  have h : env2389.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2388_2389 : H12AffineEnvironment.transform 4 10 env2388 = env2389 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env2388 == env2389) = true)

theorem identity2389 : scanCanonicalize (H12AffineFastState.compose env2389 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound2389 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2390 : List Nat := [2,4,2,16,0,0,18,4,17,1024,1,1045,3,1028,1,18,1028,0,1024,1,1044,1,0,18,18,17,1,1029,1045,1,1025,0,4,1,1029,16]

theorem envBound2390 : H12AffineFastState.Bounded env2390 := by
  intro p hp
  have h : env2390.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2389_2390 : H12AffineEnvironment.transform 2 2 env2389 = env2390 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env2389 == env2390) = true)

def leafEnv2390 : List Nat := [2,4,2,16,0,0,18,4,17,1024,1,1045,3,1028,1,18,1028,0,1024,1,1044,1,0,18,1025,18,1,17,1,1029,1045,1,1025,0,4,1,4,3,1029,16,0,1044,1]

def active2390 : List Nat := [0,1,3,9]

def tree2390 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2390 : H12WitnessSearch.Good tree2390 := H12GlobalWitnessIndex.good

theorem leafIdentity2390 : H12AffineFastState.composeSystem env2390 rootObs = leafEnv2390 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2390 rootObs == leafEnv2390) = true)

theorem terminalChecked2390 : H12PackedTerminal.terminalCheckFast leafEnv2390 active2390 tree2390 = true := by decide +kernel

def env2391 : List Nat := [2,4,8,16,32,0,24,36,17,1024,1,1077,41,1060,1,25,1060,0,1067,1,1076,33,0,57,56,17,1,1061,1077,1,1057,42,36,43,1061,16]

theorem envBound2391 : H12AffineFastState.Bounded env2391 := by
  intro p hp
  have h : env2391.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2387_2391 : H12AffineEnvironment.transform 15 25 env2387 = env2391 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 25 env2387 == env2391) = true)

def env2392 : List Nat := [2,4,8,16,32,64,88,37,81,1024,1,1077,40,1124,0,65536,1125,0,66674,0,1076,32,65,65568,121,16,1,1125,1076,1,1056,4294967296,37,4294967296,1124,80]

theorem envBound2392 : H12AffineFastState.Bounded env2392 := by
  intro p hp
  have h : env2392.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2384_2392 : H12AffineEnvironment.transform 7 37 env2384 = env2392 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env2384 == env2392) = true)

theorem identity2392 : scanCanonicalize (H12AffineFastState.compose env2392 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 65545) := by decide +kernel

theorem selectedBound2392 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2393 : List Nat := [2,4,8,16,32,64,88,37,81,1024,1,1077,40,1124,0,65536,1125,0,66674,0,1076,32,65,65568,121,16,1,1125,1076,1,1056,65545,37,65545,1124,80]

theorem envBound2393 : H12AffineFastState.Bounded env2393 := by
  intro p hp
  have h : env2393.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2392_2393 : H12AffineEnvironment.transform 31 65545 env2392 = env2393 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65545 env2392 == env2393) = true)

theorem identity2393 : scanCanonicalize (H12AffineFastState.compose env2393 (packedSelected [4] rootPS)) = affineNative (2^(15+1) ^^^ 56) := by decide +kernel

theorem selectedBound2393 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env2394 : List Nat := [2,4,8,16,32,64,88,37,81,1024,1,1077,40,1124,0,56,1125,0,1098,0,1076,32,65,24,121,16,1,1125,1076,1,1056,49,37,49,1124,80]

theorem envBound2394 : H12AffineFastState.Bounded env2394 := by
  intro p hp
  have h : env2394.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2393_2394 : H12AffineEnvironment.transform 15 56 env2393 = env2394 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 56 env2393 == env2394) = true)

theorem identity2394 : scanCanonicalize (H12AffineFastState.compose env2394 (packedSelected [1,2] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound2394 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env2395 : List Nat := [2,4,8,1,32,64,73,37,64,1024,1,1060,40,1124,0,41,1125,0,1098,0,1061,32,65,9,104,1,1,1125,1061,1,1056,32,37,32,1124,65]

theorem envBound2395 : H12AffineFastState.Bounded env2395 := by
  intro p hp
  have h : env2395.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2394_2395 : H12AffineEnvironment.transform 3 1 env2394 = env2395 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env2394 == env2395) = true)

def env2396 : List Nat := [2,4,8,1,0,64,73,5,64,1024,1,1028,8,1092,0,9,1093,0,1098,0,1029,0,65,9,72,1,1,1093,1029,1,1024,0,5,0,1092,65]

theorem envBound2396 : H12AffineFastState.Bounded env2396 := by
  intro p hp
  have h : env2396.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2395_2396 : H12AffineEnvironment.transform 4 0 env2395 = env2396 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env2395 == env2396) = true)

def env2397 : List Nat := [2,4,8,1,1,64,73,4,64,1024,1,1029,9,1093,0,8,1092,0,1098,0,1028,1,65,9,73,1,1,1092,1028,1,1025,1,4,1,1093,65]

theorem envBound2397 : H12AffineFastState.Bounded env2397 := by
  intro p hp
  have h : env2397.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2395_2397 : H12AffineEnvironment.transform 4 1 env2395 = env2397 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env2395 == env2397) = true)

theorem identity2397 : scanCanonicalize (H12AffineFastState.compose env2397 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound2397 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2398 : List Nat := [2,4,8,1,1,10,3,4,10,1024,1,1029,9,1039,0,8,1038,0,1024,0,1028,1,11,9,3,1,1,1038,1028,1,1025,1,4,1,1039,11]

theorem envBound2398 : H12AffineFastState.Bounded env2398 := by
  intro p hp
  have h : env2398.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2397_2398 : H12AffineEnvironment.transform 5 10 env2397 = env2398 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env2397 == env2398) = true)

def leafEnv2398 : List Nat := [2,4,8,1,1,10,3,4,10,1024,1,1029,9,1039,0,8,1038,0,1024,0,1028,1,11,9,1025,3,1,1,1,1038,1028,1,1025,1,4,1,4,2,1039,11,0,1029,1]

def active2398 : List Nat := [0,1,2,9]

def tree2398 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2398 : H12WitnessSearch.Good tree2398 := H12GlobalWitnessIndex.good

theorem leafIdentity2398 : H12AffineFastState.composeSystem env2398 rootObs = leafEnv2398 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2398 rootObs == leafEnv2398) = true)

theorem terminalChecked2398 : H12PackedTerminal.terminalCheckFast leafEnv2398 active2398 tree2398 = true := by decide +kernel

def env2399 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,131072,41001,205423,32768,4097,8200,5457,230469,8329,5376,164965,4176,131153,165612,131141,4294967296,256,4295000712,131073,513]

theorem envBound2399 : H12AffineFastState.Bounded env2399 := by
  intro p hp
  have h : env2399.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2359_2399 : H12AffineEnvironment.transform 17 41001 env2359 = env2399 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41001 env2359 == env2399) = true)

theorem identity2399 : scanCanonicalize (H12AffineFastState.compose env2399 (packedSelected [16,18] rootPS)) = affineNative (2^(16+1) ^^^ 9292) := by decide +kernel

theorem selectedBound2399 : packedSelected [16,18] rootPS < 2^1333 := by decide +kernel

def env2400 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,9292,41001,67107,32768,4097,8200,5457,106505,8329,5376,41001,4176,9245,41632,9225,4294967296,256,4295000712,9293,513]

theorem envBound2400 : H12AffineFastState.Bounded env2400 := by
  intro p hp
  have h : env2400.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2399_2400 : H12AffineEnvironment.transform 16 9292 env2399 = env2400 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 9292 env2399 == env2400) = true)

theorem identity2400 : scanCanonicalize (H12AffineFastState.compose env2400 (packedSelected [0,4,7,9,16] rootPS)) = affineNative (2^(12+1) ^^^ 901) := by decide +kernel

theorem selectedBound2400 : packedSelected [0,4,7,9,16] rootPS < 2^1333 := by decide +kernel

def env2401 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,901,4177,32768,65536,1993,33708,67107,32768,4097,909,5457,99212,780,5376,33708,4176,1944,33061,1932,4294967296,256,4295000712,1992,513]

theorem envBound2401 : H12AffineFastState.Bounded env2401 := by
  intro p hp
  have h : env2401.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2400_2401 : H12AffineEnvironment.transform 12 901 env2400 = env2401 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 901 env2400 == env2401) = true)

theorem identity2401 : scanCanonicalize (H12AffineFastState.compose env2401 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(14+1) ^^^ 292) := by decide +kernel

theorem selectedBound2401 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env2402 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,901,4177,292,65536,1993,648,67107,292,4097,909,5457,66216,780,5376,648,4176,1944,1,1932,4294967296,256,4294968236,1992,513]

theorem envBound2402 : H12AffineFastState.Bounded env2402 := by
  intro p hp
  have h : env2402.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2401_2402 : H12AffineEnvironment.transform 14 292 env2401 = env2402 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 292 env2401 == env2402) = true)

theorem identity2402 : scanCanonicalize (H12AffineFastState.compose env2402 (packedSelected [3,4,5,9,10,12] rootPS)) = affineNative (2^(15+1) ^^^ 627) := by decide +kernel

theorem selectedBound2402 : packedSelected [3,4,5,9,10,12] rootPS < 2^1333 := by decide +kernel

def env2403 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,901,4177,292,627,1993,648,1104,292,4097,909,5457,219,780,5376,648,4176,1944,1,1932,4294967296,256,4294968236,1992,513]

theorem envBound2403 : H12AffineFastState.Bounded env2403 := by
  intro p hp
  have h : env2403.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2402_2403 : H12AffineEnvironment.transform 15 627 env2402 = env2403 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 627 env2402 == env2403) = true)

theorem identity2403 : scanCanonicalize (H12AffineFastState.compose env2403 (packedSelected [1,4,5,9,13] rootPS)) = affineNative (2^(9+1) ^^^ 921) := by decide +kernel

theorem selectedBound2403 : packedSelected [1,4,5,9,13] rootPS < 2^1333 := by decide +kernel

def env2404 : List Nat := [2,4,8,16,32,64,128,256,512,921,1,4096,901,4177,292,627,80,648,969,292,4097,909,4808,219,780,4761,648,4176,1,1,21,4294967296,256,4294968236,81,513]

theorem envBound2404 : H12AffineFastState.Bounded env2404 := by
  intro p hp
  have h : env2404.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2403_2404 : H12AffineEnvironment.transform 9 921 env2403 = env2404 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 921 env2403 == env2404) = true)

theorem identity2404 : scanCanonicalize (H12AffineFastState.compose env2404 (packedSelected [3,4,5,9,10,15] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound2404 : packedSelected [3,4,5,9,10,15] rootPS < 2^1333 := by decide +kernel

def env2405 : List Nat := [2,4,8,16,32,64,128,256,136,273,1,4096,269,4177,292,251,80,0,321,292,4097,261,4160,219,388,4113,0,4176,1,1,21,4294967296,256,4294967588,81,137]

end H12GlobalChart2
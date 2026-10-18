import H12GlobalChart2Data019

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem identity4891 : scanCanonicalize (H12AffineFastState.compose env4891 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 33) := by decide +kernel

theorem selectedBound4891 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4892 : List Nat := [2,4,8,16,32,33,41,15,10,62,0,32,3,17,42,3,17,43,63,42,33,11,33,9,35,58,42,58,10,0,53,42,36,1,17,11]

theorem envBound4892 : H12AffineFastState.Bounded env4892 := by
  intro p hp
  have h : env4892.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4891_4892 : H12AffineEnvironment.transform 5 33 env4891 = env4892 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 33 env4891 == env4892) = true)

theorem identity4892 : scanCanonicalize (H12AffineFastState.compose env4892 (packedSelected [3,5] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound4892 : packedSelected [3,5] rootPS < 2^1333 := by decide +kernel

def env4893 : List Nat := [2,4,8,16,11,10,2,15,10,21,0,11,3,17,1,3,17,0,20,1,10,11,10,9,8,17,1,17,10,0,30,1,15,1,17,11]

theorem envBound4893 : H12AffineFastState.Bounded env4893 := by
  intro p hp
  have h : env4893.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4892_4893 : H12AffineEnvironment.transform 4 11 env4892 = env4893 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env4892 == env4893) = true)

def env4894 : List Nat := [2,4,8,16,32,64,73,110,11,95,0,32,98,112,75,99,112,74,94,75,33,106,64,8,34,91,75,58,107,0,53,75,36,1,112,10]

theorem envBound4894 : H12AffineFastState.Bounded env4894 := by
  intro p hp
  have h : env4894.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4890_4894 : H12AffineEnvironment.transform 6 73 env4890 = env4894 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 73 env4890 == env4894) = true)

theorem identity4894 : scanCanonicalize (H12AffineFastState.compose env4894 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound4894 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4895 : List Nat := [2,4,8,16,11,64,73,69,11,95,0,11,73,91,75,72,91,74,94,75,10,65,64,8,9,91,75,17,64,0,30,75,15,1,91,10]

theorem envBound4895 : H12AffineFastState.Bounded env4895 := by
  intro p hp
  have h : env4895.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4894_4895 : H12AffineEnvironment.transform 4 11 env4894 = env4895 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env4894 == env4895) = true)

theorem identity4895 : scanCanonicalize (H12AffineFastState.compose env4895 (packedSelected [3,5] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound4895 : packedSelected [3,5] rootPS < 2^1333 := by decide +kernel

def env4896 : List Nat := [2,4,8,16,11,10,3,15,11,21,0,11,3,17,1,2,17,0,20,1,10,11,10,8,9,17,1,17,10,0,30,1,15,1,17,10]

theorem envBound4896 : H12AffineFastState.Bounded env4896 := by
  intro p hp
  have h : env4896.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4895_4896 : H12AffineEnvironment.transform 5 10 env4895 = env4896 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env4895 == env4896) = true)

def env4897 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,1345,262144,524288,32768,4097,8200,5457,16777216,8329,16880644,270605,16879956,16876564,106626,1284,4294967296,16875524,4295599526,1345,513]

theorem envBound4897 : H12AffineFastState.Bounded env4897 := by
  intro p hp
  have h : env4897.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4854_4897 : H12AffineEnvironment.transform 10 1 env4854 = env4897 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env4854 == env4897) = true)

theorem identity4897 : scanCanonicalize (H12AffineFastState.compose env4897 (packedSelected [11] rootPS)) = affineNative (2^(23+1) ^^^ 268050) := by decide +kernel

theorem selectedBound4897 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env4898 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4176,32768,65536,1345,262144,524288,32768,4097,8200,5457,268050,8329,361238,270605,362054,365318,106626,1284,4294967296,366358,4295599526,1345,513]

theorem envBound4898 : H12AffineFastState.Bounded env4898 := by
  intro p hp
  have h : env4898.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4897_4898 : H12AffineEnvironment.transform 23 268050 env4897 = env4898 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 268050 env4897 == env4898) = true)

def env4899 : List Nat := [2,4,8,16,32,64,128,36,512,1024,1,4096,8192,4176,32768,65536,1125,262144,524288,32768,4097,8200,5237,267830,8329,361010,270377,362054,365090,106626,1056,4294967296,366130,4295599234,1125,513]

theorem envBound4899 : H12AffineFastState.Bounded env4899 := by
  intro p hp
  have h : env4899.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4898_4899 : H12AffineEnvironment.transform 7 36 env4898 = env4899 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env4898 == env4899) = true)

theorem identity4899 : scanCanonicalize (H12AffineFastState.compose env4899 (packedSelected [1,3,9,12,13,15,17,22] rootPS)) = affineNative (2^(14+1) ^^^ 13340) := by decide +kernel

theorem selectedBound4899 : packedSelected [1,3,9,12,13,15,17,22] rootPS < 2^1333 := by decide +kernel

def env4900 : List Nat := [2,4,8,16,32,64,128,36,512,1024,1,4096,8192,4176,13340,65536,1125,262144,524288,13340,4097,8200,5237,267830,8329,341550,270377,340570,337470,70814,1056,4294967296,336430,4295561374,1125,513]

theorem envBound4900 : H12AffineFastState.Bounded env4900 := by
  intro p hp
  have h : env4900.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4899_4900 : H12AffineEnvironment.transform 14 13340 env4899 = env4900 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13340 env4899 == env4900) = true)

def env4901 : List Nat := [2,4,8,16,32,64,128,36,136,1024,1,4096,8192,4176,13340,65536,1125,262144,524288,13340,4097,8200,5237,267454,8329,341158,270377,340178,337078,70814,1056,4294967296,336038,4295561374,1125,137]

theorem envBound4901 : H12AffineFastState.Bounded env4901 := by
  intro p hp
  have h : env4901.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4900_4901 : H12AffineEnvironment.transform 8 136 env4900 = env4901 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env4900 == env4901) = true)

theorem identity4901 : scanCanonicalize (H12AffineFastState.compose env4901 (packedSelected [0,1,3,5,7,8,10,13,15,18] rootPS)) = affineNative (2^(18+1) ^^^ 12317) := by decide +kernel

theorem selectedBound4901 : packedSelected [0,1,3,5,7,8,10,13,15,18] rootPS < 2^1333 := by decide +kernel

def env4902 : List Nat := [2,4,8,16,32,64,128,36,136,1024,1,4096,8192,4176,13340,65536,1125,262144,12317,13340,4097,8200,5237,267454,8329,341158,270377,340178,337078,70814,1056,4294967296,336038,4295041155,1125,137]

theorem envBound4902 : H12AffineFastState.Bounded env4902 := by
  intro p hp
  have h : env4902.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4901_4902 : H12AffineEnvironment.transform 18 12317 env4901 = env4902 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 12317 env4901 == env4902) = true)

theorem identity4902 : scanCanonicalize (H12AffineFastState.compose env4902 (packedSelected [0,3,4,5,7,9,12,13,20] rootPS)) = affineNative (2^(17+1) ^^^ 13341) := by decide +kernel

theorem selectedBound4902 : packedSelected [0,3,4,5,7,9,12,13,20] rootPS < 2^1333 := by decide +kernel

def env4903 : List Nat := [2,4,8,16,32,64,128,36,136,1024,1,4096,8192,4176,13340,65536,1125,13341,12317,13340,4097,8200,5237,8355,8329,65723,5172,66767,69803,70814,1056,4294967296,70843,4295041155,1125,137]

theorem envBound4903 : H12AffineFastState.Bounded env4903 := by
  intro p hp
  have h : env4903.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4902_4903 : H12AffineEnvironment.transform 17 13341 env4902 = env4903 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 13341 env4902 == env4903) = true)

theorem identity4903 : scanCanonicalize (H12AffineFastState.compose env4903 (packedSelected [0,4,5,7,8,9] rootPS)) = affineNative (2^(15+1) ^^^ 5278) := by decide +kernel

theorem selectedBound4903 : packedSelected [0,4,5,7,8,9] rootPS < 2^1333 := by decide +kernel

def env4904 : List Nat := [2,4,8,16,32,64,128,36,136,1024,1,4096,8192,4176,13340,5278,1125,13341,12317,13340,4097,8200,5237,8355,8329,5157,5172,4177,1077,0,1056,4294967296,37,4294980637,1125,137]

theorem envBound4904 : H12AffineFastState.Bounded env4904 := by
  intro p hp
  have h : env4904.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4903_4904 : H12AffineEnvironment.transform 15 5278 env4903 = env4904 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5278 env4903 == env4904) = true)

theorem identity4904 : scanCanonicalize (H12AffineFastState.compose env4904 (packedSelected [2,4] rootPS)) = affineNative (2^(12+1) ^^^ 5300) := by decide +kernel

theorem selectedBound4904 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env4905 : List Nat := [2,4,8,16,32,64,128,36,136,1024,1,4096,5300,4176,168,5278,1125,169,1193,168,4097,5308,5237,5143,5181,5157,5172,4177,1077,0,1056,4294967296,37,4294967465,1125,137]

theorem envBound4905 : H12AffineFastState.Bounded env4905 := by
  intro p hp
  have h : env4905.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4904_4905 : H12AffineEnvironment.transform 12 5300 env4904 = env4905 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5300 env4904 == env4905) = true)

theorem identity4905 : scanCanonicalize (H12AffineFastState.compose env4905 (packedSelected [0,6] rootPS)) = affineNative (2^(11+1) ^^^ 1181) := by decide +kernel

theorem selectedBound4905 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env4906 : List Nat := [2,4,8,16,32,64,128,36,136,1024,1,1181,41,1229,168,3,1125,169,1193,168,1180,33,232,138,160,184,169,1228,1077,0,1056,4294967296,37,4294967465,1125,137]

theorem envBound4906 : H12AffineFastState.Bounded env4906 := by
  intro p hp
  have h : env4906.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4905_4906 : H12AffineEnvironment.transform 11 1181 env4905 = env4906 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1181 env4905 == env4906) = true)

theorem identity4906 : scanCanonicalize (H12AffineFastState.compose env4906 (packedSelected [0,1,3] rootPS)) = affineNative (2^(9+1) ^^^ 214) := by decide +kernel

theorem selectedBound4906 : packedSelected [0,1,3] rootPS < 2^1333 := by decide +kernel

def env4907 : List Nat := [2,4,8,16,32,64,128,36,136,214,1,75,41,27,168,3,179,169,127,168,74,33,232,138,160,184,169,26,227,0,246,4294967296,37,4294967465,179,137]

theorem envBound4907 : H12AffineFastState.Bounded env4907 := by
  intro p hp
  have h : env4907.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4906_4907 : H12AffineEnvironment.transform 9 214 env4906 = env4907 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 214 env4906 == env4907) = true)

theorem identity4907 : scanCanonicalize (H12AffineFastState.compose env4907 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 179) := by decide +kernel

theorem selectedBound4907 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4908 : List Nat := [2,4,8,16,32,64,128,36,136,214,1,75,41,27,168,3,179,169,127,168,74,33,232,138,160,184,169,26,227,0,246,179,37,26,179,137]

theorem envBound4908 : H12AffineFastState.Bounded env4908 := by
  intro p hp
  have h : env4908.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4907_4908 : H12AffineEnvironment.transform 31 179 env4907 = env4908 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 179 env4907 == env4908) = true)

theorem identity4908 : scanCanonicalize (H12AffineFastState.compose env4908 (packedSelected [5] rootPS)) = affineNative (2^(5+1) ^^^ 43) := by decide +kernel

theorem selectedBound4908 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env4909 : List Nat := [2,4,8,16,32,43,128,36,136,189,1,32,41,27,168,3,179,169,20,168,33,33,131,138,160,184,169,26,136,0,157,179,37,26,179,137]

theorem envBound4909 : H12AffineFastState.Bounded env4909 := by
  intro p hp
  have h : env4909.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4908_4909 : H12AffineEnvironment.transform 5 43 env4908 = env4909 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 43 env4908 == env4909) = true)

theorem identity4909 : scanCanonicalize (H12AffineFastState.compose env4909 (packedSelected [0,7] rootPS)) = affineNative (2^(6+1) ^^^ 40) := by decide +kernel

theorem selectedBound4909 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4910 : List Nat := [2,4,8,16,32,43,40,36,32,21,1,32,41,27,0,3,27,1,20,0,33,33,43,34,8,16,1,26,32,0,53,27,37,26,27,33]

theorem envBound4910 : H12AffineFastState.Bounded env4910 := by
  intro p hp
  have h : env4910.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4909_4910 : H12AffineEnvironment.transform 6 40 env4909 = env4910 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 40 env4909 == env4910) = true)

theorem identity4910 : scanCanonicalize (H12AffineFastState.compose env4910 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 27) := by decide +kernel

theorem selectedBound4910 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4911 : List Nat := [2,4,8,16,27,16,19,31,27,21,1,27,18,27,0,3,27,1,20,0,26,26,16,25,8,16,1,26,27,0,14,27,30,26,27,26]

theorem envBound4911 : H12AffineFastState.Bounded env4911 := by
  intro p hp
  have h : env4911.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4910_4911 : H12AffineEnvironment.transform 4 27 env4910 = env4911 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 27 env4910 == env4911) = true)

def env4912 : List Nat := [2,4,8,16,32,64,128,36,137,1024,1,4096,8192,4176,13340,65536,1125,262144,524288,13340,4097,8200,5237,267455,8329,341159,270377,340179,337079,70814,1056,4294967296,336039,4295561374,1125,136]

theorem envBound4912 : H12AffineFastState.Bounded env4912 := by
  intro p hp
  have h : env4912.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4900_4912 : H12AffineEnvironment.transform 8 137 env4900 = env4912 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env4900 == env4912) = true)

theorem identity4912 : scanCanonicalize (H12AffineFastState.compose env4912 (packedSelected [1,2,5,6,7,8,9,10,12,21,24] rootPS)) = affineNative (2^(15+1) ^^^ 13495) := by decide +kernel

theorem selectedBound4912 : packedSelected [1,2,5,6,7,8,9,10,12,21,24] rootPS < 2^1333 := by decide +kernel

def env4913 : List Nat := [2,4,8,16,32,64,128,36,137,1024,1,4096,8192,4176,13340,13495,1125,262144,524288,13340,4097,8200,5237,267455,8329,262160,270377,263268,266240,8233,1056,4294967296,267280,4295500841,1125,136]

theorem envBound4913 : H12AffineFastState.Bounded env4913 := by
  intro p hp
  have h : env4913.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4912_4913 : H12AffineEnvironment.transform 15 13495 env4912 = env4913 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13495 env4912 == env4913) = true)

theorem identity4913 : scanCanonicalize (H12AffineFastState.compose env4913 (packedSelected [5,8,10,13] rootPS)) = affineNative (2^(17+1) ^^^ 0) := by decide +kernel

theorem selectedBound4913 : packedSelected [5,8,10,13] rootPS < 2^1333 := by decide +kernel

def env4914 : List Nat := [2,4,8,16,32,64,128,36,137,1024,1,4096,8192,4176,13340,13495,1125,0,524288,13340,4097,8200,5237,5311,8329,16,8233,1124,4096,8233,1056,4294967296,5136,4295500841,1125,136]

theorem envBound4914 : H12AffineFastState.Bounded env4914 := by
  intro p hp
  have h : env4914.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4913_4914 : H12AffineEnvironment.transform 17 0 env4913 = env4914 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env4913 == env4914) = true)

theorem identity4914 : scanCanonicalize (H12AffineFastState.compose env4914 (packedSelected [0,7] rootPS)) = affineNative (2^(12+1) ^^^ 5148) := by decide +kernel

theorem selectedBound4914 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4915 : List Nat := [2,4,8,16,32,64,128,36,137,1024,1,4096,5148,4176,0,171,1125,0,524288,0,4097,5140,5237,5311,5269,16,5173,1124,4096,5173,1056,4294967296,5136,4295495733,1125,136]

theorem envBound4915 : H12AffineFastState.Bounded env4915 := by
  intro p hp
  have h : env4915.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4914_4915 : H12AffineEnvironment.transform 12 5148 env4914 = env4915 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5148 env4914 == env4915) = true)

def env4916 : List Nat := [2,4,8,16,32,64,128,36,137,1024,1,168,1204,248,0,171,1125,0,524288,0,169,1212,1245,1047,1085,16,1181,1124,168,1181,1056,4294967296,1208,4295491741,1125,136]

theorem envBound4916 : H12AffineFastState.Bounded env4916 := by
  intro p hp
  have h : env4916.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4915_4916 : H12AffineEnvironment.transform 11 168 env4915 = env4916 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 168 env4915 == env4916) = true)

theorem identity4916 : scanCanonicalize (H12AffineFastState.compose env4916 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 75) := by decide +kernel

theorem selectedBound4916 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4917 : List Nat := [2,4,8,16,32,64,128,36,137,1024,1,168,1204,248,0,171,1125,0,524288,0,169,1212,1245,1047,1085,16,1181,1124,168,1181,1056,75,1208,524502,1125,136]

theorem envBound4917 : H12AffineFastState.Bounded env4917 := by
  intro p hp
  have h : env4917.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4916_4917 : H12AffineEnvironment.transform 31 75 env4916 = env4917 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 75 env4916 == env4917) = true)

theorem identity4917 : scanCanonicalize (H12AffineFastState.compose env4917 (packedSelected [1,4,8] rootPS)) = affineNative (2^(9+1) ^^^ 157) := by decide +kernel

theorem selectedBound4917 : packedSelected [1,4,8] rootPS < 2^1333 := by decide +kernel

def env4918 : List Nat := [2,4,8,16,32,64,128,36,137,157,1,168,41,248,0,171,248,0,524288,0,169,33,64,138,160,16,0,249,168,0,189,75,37,524502,248,136]

theorem envBound4918 : H12AffineFastState.Bounded env4918 := by
  intro p hp
  have h : env4918.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4917_4918 : H12AffineEnvironment.transform 9 157 env4917 = env4918 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 157 env4917 == env4918) = true)

theorem identity4918 : scanCanonicalize (H12AffineFastState.compose env4918 (packedSelected [2,4] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound4918 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env4919 : List Nat := [2,4,8,16,1,64,128,5,137,157,1,137,8,217,0,138,217,0,524288,0,136,0,64,138,129,16,0,216,137,0,156,75,4,524502,217,136]

theorem envBound4919 : H12AffineFastState.Bounded env4919 := by
  intro p hp
  have h : env4919.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4918_4919 : H12AffineEnvironment.transform 4 1 env4918 = env4919 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4918 == env4919) = true)

def env4920 : List Nat := [2,4,8,16,1,64,128,5,137,157,1,137,8,217,0,138,217,0,156,0,136,0,64,138,129,16,0,216,137,0,156,75,4,74,217,136]

theorem envBound4920 : H12AffineFastState.Bounded env4920 := by
  intro p hp
  have h : env4920.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4919_4920 : H12AffineEnvironment.transform 18 156 env4919 = env4920 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 156 env4919 == env4920) = true)

theorem identity4920 : scanCanonicalize (H12AffineFastState.compose env4920 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 19) := by decide +kernel

theorem selectedBound4920 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4921 : List Nat := [2,4,8,16,1,64,19,5,26,14,1,26,8,74,0,25,74,0,15,0,27,0,64,25,18,16,0,75,26,0,15,75,4,74,74,27]

theorem envBound4921 : H12AffineFastState.Bounded env4921 := by
  intro p hp
  have h : env4921.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4920_4921 : H12AffineEnvironment.transform 6 19 env4920 = env4921 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 19 env4920 == env4921) = true)

theorem identity4921 : scanCanonicalize (H12AffineFastState.compose env4921 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound4921 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4922 : List Nat := [2,4,8,11,1,64,8,5,1,14,1,1,8,74,0,2,74,0,15,0,0,0,64,2,9,11,0,75,1,0,15,75,4,74,74,0]

theorem envBound4922 : H12AffineFastState.Bounded env4922 := by
  intro p hp
  have h : env4922.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4921_4922 : H12AffineEnvironment.transform 3 11 env4921 = env4922 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env4921 == env4922) = true)

def leafEnv4922 : List Nat := [2,4,8,11,1,64,8,5,1,14,1,1,8,74,0,2,74,0,15,0,0,0,64,2,15,9,1,11,0,75,1,0,15,75,4,74,4,3,74,0,0,1,1]

def active4922 : List Nat := [0,1,2,5]

def tree4922 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4922 : H12WitnessSearch.Good tree4922 := H12GlobalWitnessIndex.good

theorem leafIdentity4922 : H12AffineFastState.composeSystem env4922 rootObs = leafEnv4922 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4922 rootObs == leafEnv4922) = true)

theorem terminalChecked4922 : H12PackedTerminal.terminalCheckFast leafEnv4922 active4922 tree4922 = true := by decide +kernel

def env4923 : List Nat := [2,4,8,16,1,64,128,5,137,157,1,137,8,217,0,138,217,0,157,0,136,0,64,138,129,16,0,216,137,0,156,75,4,75,217,136]

theorem envBound4923 : H12AffineFastState.Bounded env4923 := by
  intro p hp
  have h : env4923.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4919_4923 : H12AffineEnvironment.transform 18 157 env4919 = env4923 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 157 env4919 == env4923) = true)

theorem identity4923 : scanCanonicalize (H12AffineFastState.compose env4923 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 19) := by decide +kernel

theorem selectedBound4923 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4924 : List Nat := [2,4,8,16,1,64,19,5,26,14,1,26,8,74,0,25,74,0,14,0,27,0,64,25,18,16,0,75,26,0,15,75,4,75,74,27]

theorem envBound4924 : H12AffineFastState.Bounded env4924 := by
  intro p hp
  have h : env4924.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4923_4924 : H12AffineEnvironment.transform 6 19 env4923 = env4924 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 19 env4923 == env4924) = true)

def leafEnv4924 : List Nat := [2,4,8,16,1,64,19,5,26,14,1,26,8,74,0,25,74,0,14,0,27,0,64,25,14,18,1,16,0,75,26,0,15,75,4,75,4,3,74,27,0,26,1]

def active4924 : List Nat := [0,1,2,3,5]

def tree4924 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4924 : H12WitnessSearch.Good tree4924 := H12GlobalWitnessIndex.good

theorem leafIdentity4924 : H12AffineFastState.composeSystem env4924 rootObs = leafEnv4924 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4924 rootObs == leafEnv4924) = true)

theorem terminalChecked4924 : H12PackedTerminal.terminalCheckFast leafEnv4924 active4924 tree4924 = true := by decide +kernel

def env4925 : List Nat := [2,4,8,16,32,64,128,36,137,1024,1,169,1205,249,0,171,1125,0,524288,0,168,1213,1244,1046,1084,16,1180,1124,169,1180,1056,4294967296,1209,4295491740,1125,136]

theorem envBound4925 : H12AffineFastState.Bounded env4925 := by
  intro p hp
  have h : env4925.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4915_4925 : H12AffineEnvironment.transform 11 169 env4915 = env4925 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 169 env4915 == env4925) = true)

theorem identity4925 : scanCanonicalize (H12AffineFastState.compose env4925 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 1238) := by decide +kernel

theorem selectedBound4925 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4926 : List Nat := [2,4,8,16,32,64,128,36,137,1024,1,169,1205,249,0,171,1125,0,524288,0,168,1213,1244,1046,1084,16,1180,1124,169,1180,1056,1238,1209,525386,1125,136]

theorem envBound4926 : H12AffineFastState.Bounded env4926 := by
  intro p hp
  have h : env4926.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4925_4926 : H12AffineEnvironment.transform 31 1238 env4925 = env4926 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1238 env4925 == env4926) = true)

theorem identity4926 : scanCanonicalize (H12AffineFastState.compose env4926 (packedSelected [1,4,5] rootPS)) = affineNative (2^(9+1) ^^^ 156) := by decide +kernel

theorem selectedBound4926 : packedSelected [1,4,5] rootPS < 2^1333 := by decide +kernel

def env4927 : List Nat := [2,4,8,16,32,64,128,36,137,156,1,169,41,249,0,171,249,0,524288,0,168,33,64,138,160,16,0,248,169,0,188,74,37,524502,249,136]

theorem envBound4927 : H12AffineFastState.Bounded env4927 := by
  intro p hp
  have h : env4927.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4926_4927 : H12AffineEnvironment.transform 9 156 env4926 = env4927 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 156 env4926 == env4927) = true)

theorem identity4927 : scanCanonicalize (H12AffineFastState.compose env4927 (packedSelected [2,4] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound4927 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env4928 : List Nat := [2,4,8,16,1,64,128,5,137,156,1,136,8,216,0,138,216,0,524288,0,137,0,64,138,129,16,0,217,136,0,157,74,4,524502,216,136]

theorem envBound4928 : H12AffineFastState.Bounded env4928 := by
  intro p hp
  have h : env4928.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4927_4928 : H12AffineEnvironment.transform 4 1 env4927 = env4928 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4927 == env4928) = true)

def env4929 : List Nat := [2,4,8,16,1,64,128,5,137,156,1,136,8,216,0,138,216,0,156,0,137,0,64,138,129,16,0,217,136,0,157,74,4,74,216,136]

theorem envBound4929 : H12AffineFastState.Bounded env4929 := by
  intro p hp
  have h : env4929.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4928_4929 : H12AffineEnvironment.transform 18 156 env4928 = env4929 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 156 env4928 == env4929) = true)

theorem identity4929 : scanCanonicalize (H12AffineFastState.compose env4929 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 18) := by decide +kernel

theorem selectedBound4929 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4930 : List Nat := [2,4,8,16,1,64,18,5,27,14,1,26,8,74,0,24,74,0,14,0,27,0,64,24,19,16,0,75,26,0,15,74,4,74,74,26]

theorem envBound4930 : H12AffineFastState.Bounded env4930 := by
  intro p hp
  have h : env4930.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4929_4930 : H12AffineEnvironment.transform 6 18 env4929 = env4930 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 18 env4929 == env4930) = true)

def leafEnv4930 : List Nat := [2,4,8,16,1,64,18,5,27,14,1,26,8,74,0,24,74,0,14,0,27,0,64,24,14,19,1,16,0,75,26,0,15,74,4,74,4,3,74,26,0,26,1]

def active4930 : List Nat := [0,1,2,3,5]

def tree4930 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4930 : H12WitnessSearch.Good tree4930 := H12GlobalWitnessIndex.good

theorem leafIdentity4930 : H12AffineFastState.composeSystem env4930 rootObs = leafEnv4930 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4930 rootObs == leafEnv4930) = true)

theorem terminalChecked4930 : H12PackedTerminal.terminalCheckFast leafEnv4930 active4930 tree4930 = true := by decide +kernel

def env4931 : List Nat := [2,4,8,16,1,64,128,5,137,156,1,136,8,216,0,138,216,0,157,0,137,0,64,138,129,16,0,217,136,0,157,74,4,75,216,136]

theorem envBound4931 : H12AffineFastState.Bounded env4931 := by
  intro p hp
  have h : env4931.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4928_4931 : H12AffineEnvironment.transform 18 157 env4928 = env4931 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 157 env4928 == env4931) = true)

theorem identity4931 : scanCanonicalize (H12AffineFastState.compose env4931 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 18) := by decide +kernel

theorem selectedBound4931 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4932 : List Nat := [2,4,8,16,1,64,18,5,27,14,1,26,8,74,0,24,74,0,15,0,27,0,64,24,19,16,0,75,26,0,15,74,4,75,74,26]

theorem envBound4932 : H12AffineFastState.Bounded env4932 := by
  intro p hp
  have h : env4932.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4931_4932 : H12AffineEnvironment.transform 6 18 env4931 = env4932 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 18 env4931 == env4932) = true)

theorem identity4932 : scanCanonicalize (H12AffineFastState.compose env4932 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound4932 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4933 : List Nat := [2,4,8,10,1,64,8,5,1,14,1,0,8,74,0,2,74,0,15,0,1,0,64,2,9,10,0,75,0,0,15,74,4,75,74,0]

theorem envBound4933 : H12AffineFastState.Bounded env4933 := by
  intro p hp
  have h : env4933.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4932_4933 : H12AffineEnvironment.transform 3 10 env4932 = env4933 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env4932 == env4933) = true)

def leafEnv4933 : List Nat := [2,4,8,10,1,64,8,5,1,14,1,0,8,74,0,2,74,0,15,0,1,0,64,2,15,9,1,10,0,75,0,0,15,74,4,75,4,3,74,0,0,0,1]

def active4933 : List Nat := [0,1,2,5]

def tree4933 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4933 : H12WitnessSearch.Good tree4933 := H12GlobalWitnessIndex.good

theorem leafIdentity4933 : H12AffineFastState.composeSystem env4933 rootObs = leafEnv4933 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4933 rootObs == leafEnv4933) = true)

theorem terminalChecked4933 : H12PackedTerminal.terminalCheckFast leafEnv4933 active4933 tree4933 = true := by decide +kernel

def env4934 : List Nat := [2,4,8,16,32,64,128,37,512,1024,1,4096,8192,4176,32768,65536,1124,262144,524288,32768,4097,8200,5236,267831,8329,361011,270376,362054,365091,106626,1057,4294967296,366131,4295599235,1124,513]

theorem envBound4934 : H12AffineFastState.Bounded env4934 := by
  intro p hp
  have h : env4934.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4898_4934 : H12AffineEnvironment.transform 7 37 env4898 = env4934 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env4898 == env4934) = true)

theorem identity4934 : scanCanonicalize (H12AffineFastState.compose env4934 (packedSelected [1,3,9,12,13,15,17,22] rootPS)) = affineNative (2^(17+1) ^^^ 74250) := by decide +kernel

theorem selectedBound4934 : packedSelected [1,3,9,12,13,15,17,22] rootPS < 2^1333 := by decide +kernel

def env4935 : List Nat := [2,4,8,16,32,64,128,37,512,1024,1,4096,8192,4176,32768,65536,1124,74250,524288,32768,4097,8200,5236,78909,8329,41017,66082,42060,45097,106626,1057,4294967296,46137,4295599235,1124,513]

theorem envBound4935 : H12AffineFastState.Bounded env4935 := by
  intro p hp
  have h : env4935.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4934_4935 : H12AffineEnvironment.transform 17 74250 env4934 = env4935 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 74250 env4934 == env4935) = true)

theorem identity4935 : scanCanonicalize (H12AffineFastState.compose env4935 (packedSelected [1,5,8,17,20,21,23,24] rootPS)) = affineNative (2^(15+1) ^^^ 32938) := by decide +kernel

theorem selectedBound4935 : packedSelected [1,5,8,17,20,21,23,24] rootPS < 2^1333 := by decide +kernel

def env4936 : List Nat := [2,4,8,16,32,64,128,37,512,1024,1,4096,8192,4176,32768,32938,1124,41632,524288,32768,4097,8200,5236,46231,8329,41017,33416,42060,45097,8232,1057,4294967296,46137,4295500841,1124,513]

theorem envBound4936 : H12AffineFastState.Bounded env4936 := by
  intro p hp
  have h : env4936.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4935_4936 : H12AffineEnvironment.transform 15 32938 env4935 = env4936 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 32938 env4935 == env4936) = true)

theorem identity4936 : scanCanonicalize (H12AffineFastState.compose env4936 (packedSelected [0,1,5,7,8,12,13,15,21,23,28] rootPS)) = affineNative (2^(14+1) ^^^ 13972) := by decide +kernel

theorem selectedBound4936 : packedSelected [0,1,5,7,8,12,13,15,21,23,28] rootPS < 2^1333 := by decide +kernel

def env4937 : List Nat := [2,4,8,16,32,64,128,37,512,1024,1,4096,8192,4176,13972,13886,1124,5172,524288,13972,4097,8200,5236,515,8329,5805,13340,4824,1725,8232,1057,4294967296,685,4295500841,1124,513]

theorem envBound4937 : H12AffineFastState.Bounded env4937 := by
  intro p hp
  have h : env4937.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4936_4937 : H12AffineEnvironment.transform 14 13972 env4936 = env4937 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13972 env4936 == env4937) = true)

theorem identity4937 : scanCanonicalize (H12AffineFastState.compose env4937 (packedSelected [0,5,7,8,10,13,18] rootPS)) = affineNative (2^(18+1) ^^^ 4148) := by decide +kernel

theorem selectedBound4937 : packedSelected [0,5,7,8,10,13,18] rootPS < 2^1333 := by decide +kernel

def env4938 : List Nat := [2,4,8,16,32,64,128,37,512,1024,1,4096,8192,4176,13972,13886,1124,5172,4148,13972,4097,8200,5236,515,8329,5805,13340,4824,1725,8232,1057,4294967296,685,4294980637,1124,513]

theorem envBound4938 : H12AffineFastState.Bounded env4938 := by
  intro p hp
  have h : env4938.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4937_4938 : H12AffineEnvironment.transform 18 4148 env4937 = env4938 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 4148 env4937 == env4938) = true)

theorem identity4938 : scanCanonicalize (H12AffineFastState.compose env4938 (packedSelected [5,8] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound4938 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env4939 : List Nat := [2,4,8,16,32,64,128,37,137,1024,1,4096,8192,4176,13341,13495,1124,5172,4148,13341,4097,8200,5236,138,8329,5156,13340,4177,1076,8232,1057,4294967296,36,4294980637,1124,136]

theorem envBound4939 : H12AffineFastState.Bounded env4939 := by
  intro p hp
  have h : env4939.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4938_4939 : H12AffineEnvironment.transform 8 137 env4938 = env4939 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env4938 == env4939) = true)

theorem identity4939 : scanCanonicalize (H12AffineFastState.compose env4939 (packedSelected [0,1,3] rootPS)) = affineNative (2^(12+1) ^^^ 4282) := by decide +kernel

theorem selectedBound4939 : packedSelected [0,1,3] rootPS < 2^1333 := by decide +kernel

def env4940 : List Nat := [2,4,8,16,32,64,128,37,137,1024,1,4096,4282,4176,1191,1037,1124,5172,4148,1191,4097,4274,5236,138,4147,5156,1190,4177,1076,4242,1057,4294967296,36,4294968487,1124,136]

theorem envBound4940 : H12AffineFastState.Bounded env4940 := by
  intro p hp
  have h : env4940.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4939_4940 : H12AffineEnvironment.transform 12 4282 env4939 = env4940 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4282 env4939 == env4940) = true)

theorem identity4940 : scanCanonicalize (H12AffineFastState.compose env4940 (packedSelected [2,4] rootPS)) = affineNative (2^(11+1) ^^^ 1044) := by decide +kernel

theorem selectedBound4940 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env4941 : List Nat := [2,4,8,16,32,64,128,37,137,1024,1,1044,1198,1092,1191,1037,1124,32,1056,1191,1045,1190,96,138,1063,48,1190,1093,1076,1158,1057,4294967296,36,4294968487,1124,136]

theorem envBound4941 : H12AffineFastState.Bounded env4941 := by
  intro p hp
  have h : env4941.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4940_4941 : H12AffineEnvironment.transform 11 1044 env4940 = env4941 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1044 env4940 == env4941) = true)

theorem identity4941 : scanCanonicalize (H12AffineFastState.compose env4941 (packedSelected [0,5] rootPS)) = affineNative (2^(9+1) ^^^ 166) := by decide +kernel

theorem selectedBound4941 : packedSelected [0,5] rootPS < 2^1333 := by decide +kernel

def env4942 : List Nat := [2,4,8,16,32,64,128,37,137,166,1,178,8,226,1,171,194,32,134,1,179,0,96,138,129,48,0,227,146,32,135,4294967296,36,4294967297,194,136]

theorem envBound4942 : H12AffineFastState.Bounded env4942 := by
  intro p hp
  have h : env4942.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4941_4942 : H12AffineEnvironment.transform 9 166 env4941 = env4942 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 166 env4941 == env4942) = true)

theorem identity4942 : scanCanonicalize (H12AffineFastState.compose env4942 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 120) := by decide +kernel

theorem selectedBound4942 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4943 : List Nat := [2,4,8,16,32,64,120,37,113,94,1,74,8,26,1,83,58,32,126,1,75,0,96,114,121,48,0,27,106,32,127,4294967296,36,4294967297,58,112]

theorem envBound4943 : H12AffineFastState.Bounded env4943 := by
  intro p hp
  have h : env4943.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4942_4943 : H12AffineEnvironment.transform 6 120 env4942 = env4943 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 120 env4942 == env4943) = true)

theorem identity4943 : scanCanonicalize (H12AffineFastState.compose env4943 (packedSelected [0,7] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound4943 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4944 : List Nat := [2,4,8,16,0,64,88,5,81,94,1,74,8,26,1,83,26,0,94,1,75,0,64,82,89,16,0,27,74,0,95,4294967296,4,4294967297,26,80]

theorem envBound4944 : H12AffineFastState.Bounded env4944 := by
  intro p hp
  have h : env4944.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4943_4944 : H12AffineEnvironment.transform 4 0 env4943 = env4944 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4943 == env4944) = true)

theorem identity4944 : scanCanonicalize (H12AffineFastState.compose env4944 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 1) := by decide +kernel

theorem selectedBound4944 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4945 : List Nat := [2,4,8,16,0,64,88,5,81,94,1,74,8,26,1,83,26,0,94,1,75,0,64,82,89,16,0,27,74,0,95,1,4,0,26,80]

theorem envBound4945 : H12AffineFastState.Bounded env4945 := by
  intro p hp
  have h : env4945.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4944_4945 : H12AffineEnvironment.transform 31 1 env4944 = env4945 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1 env4944 == env4945) = true)

def leafEnv4945 : List Nat := [2,4,8,16,0,64,88,5,81,94,1,74,8,26,1,83,26,0,94,1,75,0,64,82,94,89,1,16,0,27,74,0,95,1,4,0,4,2,26,80,0,74,1]

def active4945 : List Nat := [0,1,2,3,5]

def tree4945 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4945 : H12WitnessSearch.Good tree4945 := H12GlobalWitnessIndex.good

theorem leafIdentity4945 : H12AffineFastState.composeSystem env4945 rootObs = leafEnv4945 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4945 rootObs == leafEnv4945) = true)

theorem terminalChecked4945 : H12PackedTerminal.terminalCheckFast leafEnv4945 active4945 tree4945 = true := by decide +kernel

def env4946 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,4194304,5456,16777216,33554432,17011013,4588613,17011732,16876564,1073741824,131141,4294967296,17007941,4333477991,131072,33563272]

theorem envBound4946 : H12AffineFastState.Bounded env4946 := by
  intro p hp
  have h : env4946.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4614_4946 : H12AffineEnvironment.transform 13 4177 env4614 = env4946 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env4614 == env4946) = true)

def env4947 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,4194304,5456,16777216,4395008,17011013,4588613,17011732,16876564,1073741824,131141,4294967296,17007941,4295536743,131072,4403848]

theorem envBound4947 : H12AffineFastState.Bounded env4947 := by
  intro p hp
  have h : env4947.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4946_4947 : H12AffineEnvironment.transform 24 4395008 env4946 = env4947 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 4395008 env4946 == env4947) = true)

def env4948 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4096,262144,524288,32768,4097,4194304,5456,16777216,4259840,16875845,4461637,16876564,16876564,1073741824,4165,4294967296,16880965,4295536743,4096,4268680]

theorem envBound4948 : H12AffineFastState.Bounded env4948 := by
  intro p hp
  have h : env4948.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4947_4948 : H12AffineEnvironment.transform 16 4096 env4947 = env4948 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env4947 == env4948) = true)

def env4949 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4096,262144,524288,32768,4097,4194304,5456,98304,4259840,325,4461637,1044,1044,1073741824,4165,4294967296,5445,4295536743,4096,4268680]

theorem envBound4949 : H12AffineFastState.Bounded env4949 := by
  intro p hp
  have h : env4949.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4948_4949 : H12AffineEnvironment.transform 23 98304 env4948 = env4949 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98304 env4948 == env4949) = true)

theorem identity4949 : scanCanonicalize (H12AffineFastState.compose env4949 (packedSelected [3,5,24] rootPS)) = affineNative (2^(17+1) ^^^ 71245) := by decide +kernel

theorem selectedBound4949 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env4950 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4096,71245,524288,32768,4097,4194304,5456,98304,4259840,325,4260360,1044,1044,1073741824,4165,4294967296,5445,4295536743,4096,4268680]

theorem envBound4950 : H12AffineFastState.Bounded env4950 := by
  intro p hp
  have h : env4950.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4949_4950 : H12AffineEnvironment.transform 17 71245 env4949 = env4950 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 71245 env4949 == env4950) = true)

def env4951 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4096,71197,524288,32768,4097,4194304,5376,98304,4259840,277,4260360,1044,1044,1073741824,4117,4294967296,5397,4295536695,4096,4268680]

theorem envBound4951 : H12AffineFastState.Bounded env4951 := by
  intro p hp
  have h : env4951.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4950_4951 : H12AffineEnvironment.transform 5 16 env4950 = env4951 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env4950 == env4951) = true)

theorem identity4951 : scanCanonicalize (H12AffineFastState.compose env4951 (packedSelected [3,5,8,17,21,28] rootPS)) = affineNative (2^(29+1) ^^^ 38589) := by decide +kernel

theorem selectedBound4951 : packedSelected [3,5,8,17,21,28] rootPS < 2^1333 := by decide +kernel

def env4952 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4096,71197,524288,32768,4097,4194304,5376,98304,4259840,277,4260360,1044,1044,38589,4117,4294967296,5397,4295536695,4096,4268680]

theorem envBound4952 : H12AffineFastState.Bounded env4952 := by
  intro p hp
  have h : env4952.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4951_4952 : H12AffineEnvironment.transform 29 38589 env4951 = env4952 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 38589 env4951 == env4952) = true)

theorem identity4952 : scanCanonicalize (H12AffineFastState.compose env4952 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(15+1) ^^^ 43552) := by decide +kernel

theorem selectedBound4952 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env4953 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,43552,4096,48189,524288,32768,4097,4194304,5376,10784,4237856,277,4237352,1044,1044,38589,4117,4294967296,5397,4295536695,4096,4229288]

theorem envBound4953 : H12AffineFastState.Bounded env4953 := by
  intro p hp
  have h : env4953.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4952_4953 : H12AffineEnvironment.transform 15 43552 env4952 = env4953 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 43552 env4952 == env4953) = true)

def env4954 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,43552,4096,48189,45336,32768,4097,4194304,5376,10784,4237856,277,4237352,1044,1044,38589,4117,4294967296,5397,4294967599,4096,4229288]

theorem envBound4954 : H12AffineFastState.Bounded env4954 := by
  intro p hp
  have h : env4954.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4953_4954 : H12AffineEnvironment.transform 18 45336 env4953 = env4954 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 45336 env4953 == env4954) = true)

theorem identity4954 : scanCanonicalize (H12AffineFastState.compose env4954 (packedSelected [3,5,17] rootPS)) = affineNative (2^(11+1) ^^^ 1944) := by decide +kernel

theorem selectedBound4954 : packedSelected [3,5,17] rootPS < 2^1333 := by decide +kernel

def env4955 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,8192,1945,32768,43552,1944,43941,42624,32768,1945,4194304,664,10784,4237856,277,4237352,1044,1044,33061,1933,4294967296,653,4294967599,1944,4229288]

theorem envBound4955 : H12AffineFastState.Bounded env4955 := by
  intro p hp
  have h : env4955.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4954_4955 : H12AffineEnvironment.transform 11 1944 env4954 = env4955 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env4954 == env4955) = true)

theorem identity4955 : scanCanonicalize (H12AffineFastState.compose env4955 (packedSelected [0,1,2,4,6,8,11,12,16,19,20] rootPS)) = affineNative (2^(21+1) ^^^ 271) := by decide +kernel

theorem selectedBound4955 : packedSelected [0,1,2,4,6,8,11,12,16,19,20] rootPS < 2^1333 := by decide +kernel

def env4956 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,8192,1945,32768,43552,1944,43941,42624,32768,1945,271,664,10784,43823,277,43303,1044,1044,33061,1933,4294967296,653,4294967599,1944,35239]

theorem envBound4956 : H12AffineFastState.Bounded env4956 := by
  intro p hp
  have h : env4956.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4955_4956 : H12AffineEnvironment.transform 21 271 env4955 = env4956 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 271 env4955 == env4956) = true)

theorem identity4956 : scanCanonicalize (H12AffineFastState.compose env4956 (packedSelected [0,2,4,6,11,18,23] rootPS)) = affineNative (2^(14+1) ^^^ 8461) := by decide +kernel

theorem selectedBound4956 : packedSelected [0,2,4,6,11,18,23] rootPS < 2^1333 := by decide +kernel

def env4957 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,8192,1945,8461,2861,1944,2728,1933,8461,1945,271,664,10784,2594,277,2090,1044,1044,8232,1933,4294967296,653,4294967599,1944,10410]

theorem envBound4957 : H12AffineFastState.Bounded env4957 := by
  intro p hp
  have h : env4957.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4956_4957 : H12AffineEnvironment.transform 14 8461 env4956 = env4957 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8461 env4956 == env4957) = true)

theorem identity4957 : scanCanonicalize (H12AffineFastState.compose env4957 (packedSelected [3,12,26] rootPS)) = affineNative (2^(12+1) ^^^ 2342) := by decide +kernel

theorem selectedBound4957 : packedSelected [3,12,26] rootPS < 2^1333 := by decide +kernel

def env4958 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,2342,1945,2091,2861,1944,2728,1933,2091,1945,271,664,774,2594,277,2090,1044,1044,2318,1933,4294967296,653,4294967599,1944,396]

theorem envBound4958 : H12AffineFastState.Bounded env4958 := by
  intro p hp
  have h : env4958.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4957_4958 : H12AffineEnvironment.transform 12 2342 env4957 = env4958 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2342 env4957 == env4958) = true)

theorem identity4958 : scanCanonicalize (H12AffineFastState.compose env4958 (packedSelected [0,1,2,3,4,5,6,10,11,31] rootPS)) = affineNative (2^(8+1) ^^^ 397) := by decide +kernel

theorem selectedBound4958 : packedSelected [0,1,2,3,4,5,6,10,11,31] rootPS < 2^1333 := by decide +kernel

def env4959 : List Nat := [2,4,8,16,32,16,128,256,397,1024,2048,1045,2342,1044,2091,2208,1045,2341,1024,2091,1044,271,277,139,2479,277,2090,1044,1044,2318,1024,4294967296,256,4294967599,1045,396]

theorem envBound4959 : H12AffineFastState.Bounded env4959 := by
  intro p hp
  have h : env4959.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4958_4959 : H12AffineEnvironment.transform 8 397 env4958 = env4959 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 397 env4958 == env4959) = true)

theorem identity4959 : scanCanonicalize (H12AffineFastState.compose env4959 (packedSelected [1,2,3,4,6,7] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound4959 : packedSelected [1,2,3,4,6,7] rootPS < 2^1333 := by decide +kernel

def env4960 : List Nat := [2,4,8,16,32,16,128,4,137,1024,2048,1045,2082,1044,2091,2208,1045,2081,1024,2091,1044,11,17,139,2219,17,2090,1044,1044,2058,1024,4294967296,4,4294967339,1045,136]

theorem envBound4960 : H12AffineFastState.Bounded env4960 := by
  intro p hp
  have h : env4960.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4959_4960 : H12AffineEnvironment.transform 7 4 env4959 = env4960 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env4959 == env4960) = true)

theorem identity4960 : scanCanonicalize (H12AffineFastState.compose env4960 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 24) := by decide +kernel

theorem selectedBound4960 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4961 : List Nat := [2,4,8,16,32,16,24,4,17,1024,2048,1045,2082,1044,2091,2104,1045,2081,1024,2091,1044,11,17,19,2099,17,2090,1044,1044,2058,1024,4294967296,4,4294967339,1045,16]

theorem envBound4961 : H12AffineFastState.Bounded env4961 := by
  intro p hp
  have h : env4961.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4960_4961 : H12AffineEnvironment.transform 6 24 env4960 = env4961 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 24 env4960 == env4961) = true)

theorem identity4961 : scanCanonicalize (H12AffineFastState.compose env4961 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound4961 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4962 : List Nat := [2,4,2,16,32,16,18,4,17,1024,2048,1045,2082,1044,2081,2098,1045,2081,1024,2081,1044,1,17,19,2099,17,2080,1044,1044,2048,1024,4294967296,4,4294967329,1045,16]

theorem envBound4962 : H12AffineFastState.Bounded env4962 := by
  intro p hp
  have h : env4962.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4961_4962 : H12AffineEnvironment.transform 2 2 env4961 = env4962 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env4961 == env4962) = true)

theorem identity4962 : scanCanonicalize (H12AffineFastState.compose env4962 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 49) := by decide +kernel

theorem selectedBound4962 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4963 : List Nat := [2,4,2,16,32,16,18,4,17,1024,2048,1045,2082,1044,2081,2098,1045,2081,1024,2081,1044,1,17,19,2099,17,2080,1044,1044,2048,1024,49,4,16,1045,16]

theorem envBound4963 : H12AffineFastState.Bounded env4963 := by
  intro p hp
  have h : env4963.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4962_4963 : H12AffineEnvironment.transform 31 49 env4962 = env4963 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 49 env4962 == env4963) = true)

theorem identity4963 : scanCanonicalize (H12AffineFastState.compose env4963 (packedSelected [2,4] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound4963 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env4964 : List Nat := [2,4,2,1,32,1,3,4,0,1024,2048,1028,2082,1029,2081,2083,1028,2081,1024,2081,1029,1,0,2,2082,0,2080,1029,1029,2048,1024,32,4,1,1028,1]

theorem envBound4964 : H12AffineFastState.Bounded env4964 := by
  intro p hp
  have h : env4964.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4963_4964 : H12AffineEnvironment.transform 3 1 env4963 = env4964 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env4963 == env4964) = true)

theorem identity4964 : scanCanonicalize (H12AffineFastState.compose env4964 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound4964 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4965 : List Nat := [2,4,2,1,0,1,3,4,0,1024,2048,1028,2050,1029,2049,2051,1028,2049,1024,2049,1029,1,0,2,2050,0,2048,1029,1029,2048,1024,0,4,1,1028,1]

theorem envBound4965 : H12AffineFastState.Bounded env4965 := by
  intro p hp
  have h : env4965.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4964_4965 : H12AffineEnvironment.transform 4 0 env4964 = env4965 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4964 == env4965) = true)

def env4966 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,43552,4096,48189,45337,32768,4097,4194304,5376,10784,4237856,277,4237352,1044,1044,38589,4117,4294967296,5397,4294967598,4096,4229288]

theorem envBound4966 : H12AffineFastState.Bounded env4966 := by
  intro p hp
  have h : env4966.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4953_4966 : H12AffineEnvironment.transform 18 45337 env4953 = env4966 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 45337 env4953 == env4966) = true)

theorem identity4966 : scanCanonicalize (H12AffineFastState.compose env4966 (packedSelected [3,5,17] rootPS)) = affineNative (2^(11+1) ^^^ 1693) := by decide +kernel

theorem selectedBound4966 : packedSelected [3,5,17] rootPS < 2^1333 := by decide +kernel

def env4967 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1693,8192,1692,32768,43552,1693,43680,42884,32768,1692,4194304,925,10784,4237856,277,4237352,1044,1044,32800,1672,4294967296,904,4294967598,1693,4229288]

theorem envBound4967 : H12AffineFastState.Bounded env4967 := by
  intro p hp
  have h : env4967.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4966_4967 : H12AffineEnvironment.transform 11 1693 env4966 = env4967 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1693 env4966 == env4967) = true)

theorem identity4967 : scanCanonicalize (H12AffineFastState.compose env4967 (packedSelected [0,1,2,4,5,6,8,11,13,15,16,19,20,21] rootPS)) = affineNative (2^(14+1) ^^^ 2722) := by decide +kernel

theorem selectedBound4967 : packedSelected [0,1,2,4,5,6,8,11,13,15,16,19,20,21] rootPS < 2^1333 := by decide +kernel

def env4968 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1693,8192,1692,2722,8322,1693,8194,11558,2722,1692,4194304,925,10784,4202626,277,4203146,1044,1044,2690,1672,4294967296,904,4294967598,1693,4194826]

theorem envBound4968 : H12AffineFastState.Bounded env4968 := by
  intro p hp
  have h : env4968.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4967_4968 : H12AffineEnvironment.transform 14 2722 env4967 = env4968 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2722 env4967 == env4968) = true)

theorem identity4968 : scanCanonicalize (H12AffineFastState.compose env4968 (packedSelected [0,2,4,5,6,8,11,16,18,20,23] rootPS)) = affineNative (2^(21+1) ^^^ 10912) := by decide +kernel

theorem selectedBound4968 : packedSelected [0,2,4,5,6,8,11,16,18,20,23] rootPS < 2^1333 := by decide +kernel

def env4969 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1693,8192,1692,2722,8322,1693,8194,11558,2722,1692,10912,925,10784,2594,277,2090,1044,1044,2690,1672,4294967296,904,4294967598,1693,10410]

theorem envBound4969 : H12AffineFastState.Bounded env4969 := by
  intro p hp
  have h : env4969.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4968_4969 : H12AffineEnvironment.transform 21 10912 env4968 = env4969 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10912 env4968 == env4969) = true)

theorem identity4969 : scanCanonicalize (H12AffineFastState.compose env4969 (packedSelected [0,2,3,4,6,8,10,12,18,20] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound4969 : packedSelected [0,2,3,4,6,8,10,12,18,20] rootPS < 2^1333 := by decide +kernel

def env4970 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1045,8192,1044,2090,8322,1045,8194,11558,2090,1044,10280,277,10408,2218,277,2090,1044,1044,2058,1024,4294967296,256,4294967598,1045,10410]

theorem envBound4970 : H12AffineFastState.Bounded env4970 := by
  intro p hp
  have h : env4970.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4969_4970 : H12AffineEnvironment.transform 8 136 env4969 = env4970 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env4969 == env4970) = true)

theorem identity4970 : scanCanonicalize (H12AffineFastState.compose env4970 (packedSelected [1,3,8] rootPS)) = affineNative (2^(12+1) ^^^ 2342) := by decide +kernel

theorem selectedBound4970 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env4971 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1045,2342,1044,2090,2468,1045,2340,1024,2090,1044,270,277,398,2218,277,2090,1044,1044,2058,1024,4294967296,256,4294967598,1045,396]

theorem envBound4971 : H12AffineFastState.Bounded env4971 := by
  intro p hp
  have h : env4971.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4970_4971 : H12AffineEnvironment.transform 12 2342 env4970 = env4971 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2342 env4970 == env4971) = true)

theorem identity4971 : scanCanonicalize (H12AffineFastState.compose env4971 (packedSelected [0,6,7,16] rootPS)) = affineNative (2^(31+1) ^^^ 303) := by decide +kernel

theorem selectedBound4971 : packedSelected [0,6,7,16] rootPS < 2^1333 := by decide +kernel

def env4972 : List Nat := [2,4,8,16,32,16,128,256,136,1024,2048,1045,2342,1044,2090,2468,1045,2340,1024,2090,1044,270,277,398,2218,277,2090,1044,1044,2058,1024,303,256,1,1045,396]

theorem envBound4972 : H12AffineFastState.Bounded env4972 := by
  intro p hp
  have h : env4972.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4971_4972 : H12AffineEnvironment.transform 31 303 env4971 = env4972 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 303 env4971 == env4972) = true)

theorem identity4972 : scanCanonicalize (H12AffineFastState.compose env4972 (packedSelected [0,2,6,7] rootPS)) = affineNative (2^(7+1) ^^^ 46) := by decide +kernel

theorem selectedBound4972 : packedSelected [0,2,6,7] rootPS < 2^1333 := by decide +kernel

def env4973 : List Nat := [2,4,8,16,32,16,128,46,136,1024,2048,1045,2056,1044,2090,2186,1045,2058,1024,2090,1044,32,59,160,2218,59,2090,1044,1044,2058,1024,1,46,1,1045,162]

theorem envBound4973 : H12AffineFastState.Bounded env4973 := by
  intro p hp
  have h : env4973.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4972_4973 : H12AffineEnvironment.transform 7 46 env4972 = env4973 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 46 env4972 == env4973) = true)

theorem identity4973 : scanCanonicalize (H12AffineFastState.compose env4973 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound4973 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4974 : List Nat := [2,4,2,16,32,16,128,36,130,1024,2048,1045,2050,1044,2080,2176,1045,2048,1024,2080,1044,32,49,160,2208,49,2080,1044,1044,2048,1024,1,36,1,1045,162]

theorem envBound4974 : H12AffineFastState.Bounded env4974 := by
  intro p hp
  have h : env4974.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4973_4974 : H12AffineEnvironment.transform 2 2 env4973 = env4974 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env4973 == env4974) = true)

theorem identity4974 : scanCanonicalize (H12AffineFastState.compose env4974 (packedSelected [1,3] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound4974 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4975 : List Nat := [2,4,2,16,0,16,128,4,130,1024,2048,1045,2050,1044,2048,2176,1045,2048,1024,2048,1044,0,17,128,2176,17,2048,1044,1044,2048,1024,1,4,1,1045,130]

theorem envBound4975 : H12AffineFastState.Bounded env4975 := by
  intro p hp
  have h : env4975.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4974_4975 : H12AffineEnvironment.transform 4 0 env4974 = env4975 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4974 == env4975) = true)

theorem identity4975 : scanCanonicalize (H12AffineFastState.compose env4975 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 17) := by decide +kernel

theorem selectedBound4975 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4976 : List Nat := [2,4,2,16,0,16,17,4,19,1024,2048,1045,2050,1044,2048,2065,1045,2048,1024,2048,1044,0,17,17,2065,17,2048,1044,1044,2048,1024,1,4,1,1045,19]

theorem envBound4976 : H12AffineFastState.Bounded env4976 := by
  intro p hp
  have h : env4976.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4975_4976 : H12AffineEnvironment.transform 6 17 env4975 = env4976 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 17 env4975 == env4976) = true)

theorem identity4976 : scanCanonicalize (H12AffineFastState.compose env4976 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound4976 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4977 : List Nat := [2,4,2,3,0,3,2,4,0,1024,2048,1030,2050,1031,2048,2050,1030,2048,1024,2048,1031,0,2,2,2050,2,2048,1031,1031,2048,1024,1,4,1,1030,0]

theorem envBound4977 : H12AffineFastState.Bounded env4977 := by
  intro p hp
  have h : env4977.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4976_4977 : H12AffineEnvironment.transform 3 3 env4976 = env4977 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env4976 == env4977) = true)

theorem identity4977 : scanCanonicalize (H12AffineFastState.compose env4977 (packedSelected [6] rootPS)) = affineNative (2^(10+1) ^^^ 1) := by decide +kernel

theorem selectedBound4977 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env4978 : List Nat := [2,4,2,3,0,3,2,4,0,1024,1,1030,3,1031,1,3,1030,1,1024,1,1031,0,2,2,3,2,1,1031,1031,1,1024,1,4,1,1030,0]

theorem envBound4978 : H12AffineFastState.Bounded env4978 := by
  intro p hp
  have h : env4978.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4977_4978 : H12AffineEnvironment.transform 10 1 env4977 = env4978 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env4977 == env4978) = true)

theorem identity4978 : scanCanonicalize (H12AffineFastState.compose env4978 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 4) := by decide +kernel

theorem selectedBound4978 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env4979 : List Nat := [2,4,2,3,0,3,2,4,0,4,1,2,3,3,1,3,2,1,4,1,3,0,2,2,3,2,1,3,3,1,4,1,4,1,2,0]

theorem envBound4979 : H12AffineFastState.Bounded env4979 := by
  intro p hp
  have h : env4979.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4978_4979 : H12AffineEnvironment.transform 9 4 env4978 = env4979 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 4 env4978 == env4979) = true)

def leafEnv4979 : List Nat := [2,4,2,3,0,3,2,4,0,4,1,2,3,3,1,3,2,1,4,1,3,0,2,2,4,3,1,2,1,3,3,1,4,1,4,1,4,3,2,0,0,2,1]

def active4979 : List Nat := [0,1]

def tree4979 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4979 : H12WitnessSearch.Good tree4979 := H12GlobalWitnessIndex.good

theorem leafIdentity4979 : H12AffineFastState.composeSystem env4979 rootObs = leafEnv4979 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4979 rootObs == leafEnv4979) = true)

theorem terminalChecked4979 : H12PackedTerminal.terminalCheckFast leafEnv4979 active4979 tree4979 = true := by decide +kernel

def env4980 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,71196,524288,32768,4097,4194304,5377,98304,4259840,276,4260360,1044,1044,1073741824,4116,4294967296,5396,4295536694,4096,4268680]

theorem envBound4980 : H12AffineFastState.Bounded env4980 := by
  intro p hp
  have h : env4980.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4950_4980 : H12AffineEnvironment.transform 5 17 env4950 = env4980 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env4950 == env4980) = true)

def env4981 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,4096,8192,4096,32768,65536,4096,71196,524288,32768,4097,4194304,5125,98304,4259840,16,4260360,1044,1044,1073741824,4116,4294967296,5136,4295536694,4096,4268680]

theorem envBound4981 : H12AffineFastState.Bounded env4981 := by
  intro p hp
  have h : env4981.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4980_4981 : H12AffineEnvironment.transform 7 4 env4980 = env4981 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env4980 == env4981) = true)

theorem identity4981 : scanCanonicalize (H12AffineFastState.compose env4981 (packedSelected [10,12,13,15,17,19] rootPS)) = affineNative (2^(29+1) ^^^ 4299934) := by decide +kernel

theorem selectedBound4981 : packedSelected [10,12,13,15,17,19] rootPS < 2^1333 := by decide +kernel

def env4982 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,4096,8192,4096,32768,65536,4096,71196,524288,32768,4097,4194304,5125,98304,4259840,16,4260360,1044,1044,4299934,4116,4294967296,5136,4295536694,4096,4268680]

theorem envBound4982 : H12AffineFastState.Bounded env4982 := by
  intro p hp
  have h : env4982.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4981_4982 : H12AffineEnvironment.transform 29 4299934 env4981 = env4982 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4299934 env4981 == env4982) = true)

theorem identity4982 : scanCanonicalize (H12AffineFastState.compose env4982 (packedSelected [5,12,13,15,21] rootPS)) = affineNative (2^(18+1) ^^^ 4116) := by decide +kernel

theorem selectedBound4982 : packedSelected [5,12,13,15,21] rootPS < 2^1333 := by decide +kernel

def env4983 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,4096,8192,4096,32768,65536,4096,71196,4116,32768,4097,4194304,5125,98304,4259840,16,4260360,1044,1044,4299934,4116,4294967296,5136,4295008290,4096,4268680]

theorem envBound4983 : H12AffineFastState.Bounded env4983 := by
  intro p hp
  have h : env4983.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4982_4983 : H12AffineEnvironment.transform 18 4116 env4982 = env4983 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 4116 env4982 == env4983) = true)

theorem identity4983 : scanCanonicalize (H12AffineFastState.compose env4983 (packedSelected [1,3,5,8,10,13,15] rootPS)) = affineNative (2^(21+1) ^^^ 98432) := by decide +kernel

theorem selectedBound4983 : packedSelected [1,3,5,8,10,13,15] rootPS < 2^1333 := by decide +kernel

def env4984 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,4096,8192,4096,32768,65536,4096,71196,4116,32768,4097,98432,5125,98304,32896,16,33416,1044,1044,7198,4116,4294967296,5136,4295008290,4096,41480]

theorem envBound4984 : H12AffineFastState.Bounded env4984 := by
  intro p hp
  have h : env4984.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4983_4984 : H12AffineEnvironment.transform 21 98432 env4983 = env4984 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 98432 env4983 == env4984) = true)

theorem identity4984 : scanCanonicalize (H12AffineFastState.compose env4984 (packedSelected [5,12,17,26] rootPS)) = affineNative (2^(11+1) ^^^ 1044) := by decide +kernel

theorem selectedBound4984 : packedSelected [5,12,17,26] rootPS < 2^1333 := by decide +kernel

def env4985 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,1044,8192,1044,32768,65536,1044,66056,1024,32768,1045,98432,17,98304,32896,16,33416,1044,1044,2058,1024,4294967296,4,4295008290,1044,41480]

theorem envBound4985 : H12AffineFastState.Bounded env4985 := by
  intro p hp
  have h : env4985.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4984_4985 : H12AffineEnvironment.transform 11 1044 env4984 = env4985 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1044 env4984 == env4985) = true)

theorem identity4985 : scanCanonicalize (H12AffineFastState.compose env4985 (packedSelected [10,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 8200) := by decide +kernel

theorem selectedBound4985 : packedSelected [10,12,13] rootPS < 2^1333 := by decide +kernel

def env4986 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,1044,8192,1044,8200,65536,1044,66056,1024,8200,1045,73864,17,73736,8328,16,8832,1044,1044,2058,1024,4294967296,4,4294967338,1044,512]

theorem envBound4986 : H12AffineFastState.Bounded env4986 := by
  intro p hp
  have h : env4986.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4985_4986 : H12AffineEnvironment.transform 14 8200 env4985 = env4986 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8200 env4985 == env4986) = true)

theorem identity4986 : scanCanonicalize (H12AffineFastState.compose env4986 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 65571) := by decide +kernel

theorem selectedBound4986 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env4987 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,1044,8192,1044,8200,65536,1044,66056,1024,8200,1045,73864,17,73736,8328,16,8832,1044,1044,2058,1024,65571,4,65545,1044,512]

theorem envBound4987 : H12AffineFastState.Bounded env4987 := by
  intro p hp
  have h : env4987.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4986_4987 : H12AffineEnvironment.transform 31 65571 env4986 = env4987 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65571 env4986 == env4987) = true)

theorem identity4987 : scanCanonicalize (H12AffineFastState.compose env4987 (packedSelected [1,10] rootPS)) = affineNative (2^(9+1) ^^^ 46) := by decide +kernel

theorem selectedBound4987 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env4988 : List Nat := [2,4,8,16,32,17,128,4,512,46,2048,58,8192,58,8200,65536,58,66056,46,8200,59,73864,17,73736,8328,16,8832,58,58,2058,46,65571,4,65545,58,512]

theorem envBound4988 : H12AffineFastState.Bounded env4988 := by
  intro p hp
  have h : env4988.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4987_4988 : H12AffineEnvironment.transform 9 46 env4987 = env4988 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 46 env4987 == env4988) = true)

theorem identity4988 : scanCanonicalize (H12AffineFastState.compose env4988 (packedSelected [4,9,16] rootPS)) = affineNative (2^(15+1) ^^^ 8192) := by decide +kernel

theorem selectedBound4988 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env4989 : List Nat := [2,4,8,16,32,17,128,4,512,46,2048,58,8192,58,8200,8192,58,8712,46,8200,59,136,17,8,8328,16,8832,58,58,2058,46,8227,4,8201,58,512]

theorem envBound4989 : H12AffineFastState.Bounded env4989 := by
  intro p hp
  have h : env4989.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4988_4989 : H12AffineEnvironment.transform 15 8192 env4988 = env4989 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8192 env4988 == env4989) = true)

theorem identity4989 : scanCanonicalize (H12AffineFastState.compose env4989 (packedSelected [0,7,20] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound4989 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env4990 : List Nat := [2,4,8,16,32,17,128,4,512,46,2048,58,8,58,0,8,58,512,46,0,59,136,17,8,128,16,648,58,58,2058,46,43,4,1,58,512]

theorem envBound4990 : H12AffineFastState.Bounded env4990 := by
  intro p hp
  have h : env4990.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4989_4990 : H12AffineEnvironment.transform 12 8 env4989 = env4990 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 8 env4989 == env4990) = true)

theorem identity4990 : scanCanonicalize (H12AffineFastState.compose env4990 (packedSelected [2,23,32] rootPS)) = affineNative (2^(8+1) ^^^ 162) := by decide +kernel

theorem selectedBound4990 : packedSelected [2,23,32] rootPS < 2^1333 := by decide +kernel

def env4991 : List Nat := [2,4,8,16,32,17,128,4,162,46,2048,58,8,58,0,8,58,162,46,0,59,136,17,8,128,16,42,58,58,2058,46,43,4,1,58,162]

theorem envBound4991 : H12AffineFastState.Bounded env4991 := by
  intro p hp
  have h : env4991.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4990_4991 : H12AffineEnvironment.transform 8 162 env4990 = env4991 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 162 env4990 == env4991) = true)

theorem identity4991 : scanCanonicalize (H12AffineFastState.compose env4991 (packedSelected [2,7] rootPS)) = affineNative (2^(4+1) ^^^ 19) := by decide +kernel

theorem selectedBound4991 : packedSelected [2,7] rootPS < 2^1333 := by decide +kernel

def env4992 : List Nat := [2,4,8,16,19,17,128,4,145,29,2048,9,8,9,0,8,9,145,29,0,8,136,17,8,128,16,25,9,9,2058,29,24,4,1,9,145]

theorem envBound4992 : H12AffineFastState.Bounded env4992 := by
  intro p hp
  have h : env4992.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4991_4992 : H12AffineEnvironment.transform 4 19 env4991 = env4992 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 19 env4991 == env4992) = true)

def env4993 : List Nat := [2,4,8,16,19,17,128,4,145,29,0,9,8,9,0,8,9,145,29,0,8,136,17,8,128,16,25,9,9,10,29,24,4,1,9,145]

theorem envBound4993 : H12AffineFastState.Bounded env4993 := by
  intro p hp
  have h : env4993.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4992_4993 : H12AffineEnvironment.transform 10 0 env4992 = env4993 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env4992 == env4993) = true)

theorem identity4993 : scanCanonicalize (H12AffineFastState.compose env4993 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound4993 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4994 : List Nat := [2,4,8,16,19,17,2,4,19,29,0,9,8,9,0,8,9,19,29,0,8,10,17,8,2,16,25,9,9,10,29,24,4,1,9,19]

theorem envBound4994 : H12AffineFastState.Bounded env4994 := by
  intro p hp
  have h : env4994.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4993_4994 : H12AffineEnvironment.transform 6 2 env4993 = env4994 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env4993 == env4994) = true)

def env4995 : List Nat := [2,4,8,8,11,9,2,4,11,5,0,9,8,9,0,8,9,11,5,0,8,10,9,8,2,8,1,9,9,10,5,0,4,1,9,11]

theorem envBound4995 : H12AffineFastState.Bounded env4995 := by
  intro p hp
  have h : env4995.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4994_4995 : H12AffineEnvironment.transform 3 8 env4994 = env4995 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 8 env4994 == env4995) = true)

def leafEnv4995 : List Nat := [2,4,8,8,11,9,2,4,11,5,0,9,8,9,0,8,9,11,5,0,8,10,9,8,5,2,1,8,1,9,9,10,5,0,4,1,4,2,9,11,0,8,1]

def active4995 : List Nat := [0,1,2]

def tree4995 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4995 : H12WitnessSearch.Good tree4995 := H12GlobalWitnessIndex.good

theorem leafIdentity4995 : H12AffineFastState.composeSystem env4995 rootObs = leafEnv4995 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4995 rootObs == leafEnv4995) = true)

theorem terminalChecked4995 : H12PackedTerminal.terminalCheckFast leafEnv4995 active4995 tree4995 = true := by decide +kernel

def env4996 : List Nat := [2,4,8,9,10,8,2,4,10,4,0,9,8,9,0,8,9,10,4,0,8,10,8,8,2,9,0,9,9,10,4,1,4,1,9,10]

theorem envBound4996 : H12AffineFastState.Bounded env4996 := by
  intro p hp
  have h : env4996.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4994_4996 : H12AffineEnvironment.transform 3 9 env4994 = env4996 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 9 env4994 == env4996) = true)

theorem identity4996 : scanCanonicalize (H12AffineFastState.compose env4996 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound4996 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4997 : List Nat := [2,4,2,3,0,2,2,4,0,4,0,3,2,3,0,2,3,0,4,0,2,0,2,2,2,3,0,3,3,0,4,1,4,1,3,0]

theorem envBound4997 : H12AffineFastState.Bounded env4997 := by
  intro p hp
  have h : env4997.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4996_4997 : H12AffineEnvironment.transform 2 2 env4996 = env4997 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env4996 == env4997) = true)

def leafEnv4997 : List Nat := [2,4,2,3,0,2,2,4,0,4,0,3,2,3,0,2,3,0,4,0,2,0,2,2,4,2,1,3,0,3,3,0,4,1,4,1,4,2,3,0,0,2,1]

def active4997 : List Nat := [0,1]

def tree4997 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4997 : H12WitnessSearch.Good tree4997 := H12GlobalWitnessIndex.good

theorem leafIdentity4997 : H12AffineFastState.composeSystem env4997 rootObs = leafEnv4997 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4997 rootObs == leafEnv4997) = true)

theorem terminalChecked4997 : H12PackedTerminal.terminalCheckFast leafEnv4997 active4997 tree4997 = true := by decide +kernel

def env4998 : List Nat := [2,4,8,16,19,17,128,4,145,29,1,9,8,9,0,8,9,145,29,0,8,136,17,8,128,16,25,9,9,11,29,24,4,1,9,145]

theorem envBound4998 : H12AffineFastState.Bounded env4998 := by
  intro p hp
  have h : env4998.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4992_4998 : H12AffineEnvironment.transform 10 1 env4992 = env4998 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env4992 == env4998) = true)

theorem identity4998 : scanCanonicalize (H12AffineFastState.compose env4998 (packedSelected [0] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound4998 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4999 : List Nat := [2,4,3,16,19,17,128,4,145,22,1,2,3,2,0,3,2,145,22,0,3,131,17,3,128,16,18,2,2,0,22,19,4,1,2,145]

theorem envBound4999 : H12AffineFastState.Bounded env4999 := by
  intro p hp
  have h : env4999.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4998_4999 : H12AffineEnvironment.transform 2 3 env4998 = env4999 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env4998 == env4999) = true)

theorem identity4999 : scanCanonicalize (H12AffineFastState.compose env4999 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 0) := by decide +kernel

theorem selectedBound4999 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env5000 : List Nat := [2,4,3,16,19,17,0,4,17,22,1,2,3,2,0,3,2,17,22,0,3,3,17,3,0,16,18,2,2,0,22,19,4,1,2,17]

theorem envBound5000 : H12AffineFastState.Bounded env5000 := by
  intro p hp
  have h : env5000.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4999_5000 : H12AffineEnvironment.transform 6 0 env4999 = env5000 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 0 env4999 == env5000) = true)

def env5001 : List Nat := [2,4,8,16,32,17,128,5,512,1024,2048,4096,8192,4096,32768,65536,4096,71196,524288,32768,4097,4194304,5124,98304,4259840,17,4260360,1044,1044,1073741824,4116,4294967296,5137,4295536694,4096,4268680]

theorem envBound5001 : H12AffineFastState.Bounded env5001 := by
  intro p hp
  have h : env5001.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4980_5001 : H12AffineEnvironment.transform 7 5 env4980 = env5001 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env4980 == env5001) = true)

theorem identity5001 : scanCanonicalize (H12AffineFastState.compose env5001 (packedSelected [10,12,13,15,17,19] rootPS)) = affineNative (2^(29+1) ^^^ 38588) := by decide +kernel

theorem selectedBound5001 : packedSelected [10,12,13,15,17,19] rootPS < 2^1333 := by decide +kernel

def env5002 : List Nat := [2,4,8,16,32,17,128,5,512,1024,2048,4096,8192,4096,32768,65536,4096,71196,524288,32768,4097,4194304,5124,98304,4259840,17,4260360,1044,1044,38588,4116,4294967296,5137,4295536694,4096,4268680]

theorem envBound5002 : H12AffineFastState.Bounded env5002 := by
  intro p hp
  have h : env5002.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5001_5002 : H12AffineEnvironment.transform 29 38588 env5001 = env5002 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 38588 env5001 == env5002) = true)

theorem identity5002 : scanCanonicalize (H12AffineFastState.compose env5002 (packedSelected [3,5,17] rootPS)) = affineNative (2^(21+1) ^^^ 35496) := by decide +kernel

theorem selectedBound5002 : packedSelected [3,5,17] rootPS < 2^1333 := by decide +kernel

def env5003 : List Nat := [2,4,8,16,32,17,128,5,512,1024,2048,4096,8192,4096,32768,65536,4096,71196,524288,32768,4097,35496,5124,98304,101032,17,100512,1044,1044,38588,4116,4294967296,5137,4295536694,4096,108576]

theorem envBound5003 : H12AffineFastState.Bounded env5003 := by
  intro p hp
  have h : env5003.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5002_5003 : H12AffineEnvironment.transform 21 35496 env5002 = env5003 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 35496 env5002 == env5003) = true)

theorem identity5003 : scanCanonicalize (H12AffineFastState.compose env5003 (packedSelected [1,3,8,10,31] rootPS)) = affineNative (2^(15+1) ^^^ 43553) := by decide +kernel

theorem selectedBound5003 : packedSelected [1,3,8,10,31] rootPS < 2^1333 := by decide +kernel

def env5004 : List Nat := [2,4,8,16,32,17,128,5,512,1024,2048,4096,8192,4096,32768,43553,4096,48189,524288,32768,4097,35496,5124,10785,8329,17,8833,1044,1044,38588,4116,4294967296,5137,4295536694,4096,513]

theorem envBound5004 : H12AffineFastState.Bounded env5004 := by
  intro p hp
  have h : env5004.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5003_5004 : H12AffineEnvironment.transform 15 43553 env5003 = env5004 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 43553 env5003 == env5004) = true)

theorem identity5004 : scanCanonicalize (H12AffineFastState.compose env5004 (packedSelected [0,1,4,5,7,8,9,12,13] rootPS)) = affineNative (2^(18+1) ^^^ 4790) := by decide +kernel

theorem selectedBound5004 : packedSelected [0,1,4,5,7,8,9,12,13] rootPS < 2^1333 := by decide +kernel

def env5005 : List Nat := [2,4,8,16,32,17,128,5,512,1024,2048,4096,8192,4096,32768,43553,4096,48189,4790,32768,4097,35496,5124,10785,8329,17,8833,1044,1044,38588,4116,4294967296,5137,4295008896,4096,513]

theorem envBound5005 : H12AffineFastState.Bounded env5005 := by
  intro p hp
  have h : env5005.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5004_5005 : H12AffineEnvironment.transform 18 4790 env5004 = env5005 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 4790 env5004 == env5005) = true)

theorem identity5005 : scanCanonicalize (H12AffineFastState.compose env5005 (packedSelected [2,3,4,6,7,8,10,12] rootPS)) = affineNative (2^(11+1) ^^^ 1693) := by decide +kernel

theorem selectedBound5005 : packedSelected [2,3,4,6,7,8,10,12] rootPS < 2^1333 := by decide +kernel

def env5006 : List Nat := [2,4,8,16,32,17,128,5,512,1024,2048,1693,8192,1693,32768,43553,1693,43680,1067,32768,1692,35496,665,10785,8329,17,8833,1044,1044,32801,1673,4294967296,652,4295008896,1693,513]

theorem envBound5006 : H12AffineFastState.Bounded env5006 := by
  intro p hp
  have h : env5006.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5005_5006 : H12AffineEnvironment.transform 11 1693 env5005 = env5006 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1693 env5005 == env5006) = true)

def env5007 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4096,262144,524288,32768,4097,4194304,5456,98305,4259840,324,4461637,1045,1045,1073741824,4165,4294967296,5444,4295536743,4096,4268680]

theorem envBound5007 : H12AffineFastState.Bounded env5007 := by
  intro p hp
  have h : env5007.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4948_5007 : H12AffineEnvironment.transform 23 98305 env4948 = env5007 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98305 env4948 == env5007) = true)

theorem identity5007 : scanCanonicalize (H12AffineFastState.compose env5007 (packedSelected [3,5,24] rootPS)) = affineNative (2^(18+1) ^^^ 332364) := by decide +kernel

theorem selectedBound5007 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env5008 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4096,262144,332364,32768,4097,4194304,5456,98305,4259840,324,4461637,1045,1045,1073741824,4165,4294967296,5444,4295336491,4096,4268680]

theorem envBound5008 : H12AffineFastState.Bounded env5008 := by
  intro p hp
  have h : env5008.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5007_5008 : H12AffineEnvironment.transform 18 332364 env5007 = env5008 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 332364 env5007 == env5008) = true)

def env5009 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4096,262144,332364,32768,4097,4194304,5456,98305,4259840,324,4461637,1045,1045,360608,4165,4294967296,5444,4295336491,4096,4268680]

theorem envBound5009 : H12AffineFastState.Bounded env5009 := by
  intro p hp
  have h : env5009.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5008_5009 : H12AffineEnvironment.transform 29 360608 env5008 = env5009 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360608 env5008 == env5009) = true)

theorem identity5009 : scanCanonicalize (H12AffineFastState.compose env5009 (packedSelected [3,5,8,17,21,28] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound5009 : packedSelected [3,5,8,17,21,28] rootPS < 2^1333 := by decide +kernel

def env5010 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,262144,332317,32768,4097,4194304,5377,98305,4259840,277,4461588,1045,1045,360608,4116,4294967296,5397,4295336491,4096,4268680]

theorem envBound5010 : H12AffineFastState.Bounded env5010 := by
  intro p hp
  have h : env5010.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5009_5010 : H12AffineEnvironment.transform 5 17 env5009 = env5010 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env5009 == env5010) = true)

def env5011 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4096,262144,332364,32768,4097,4194304,5456,98305,4259840,324,4461637,1045,1045,360609,4165,4294967296,5444,4295336491,4096,4268680]

theorem envBound5011 : H12AffineFastState.Bounded env5011 := by
  intro p hp
  have h : env5011.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5008_5011 : H12AffineEnvironment.transform 29 360609 env5008 = env5011 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360609 env5008 == env5011) = true)

theorem identity5011 : scanCanonicalize (H12AffineFastState.compose env5011 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(17+1) ^^^ 48236) := by decide +kernel

theorem selectedBound5011 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env5012 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4096,48236,110112,32768,4097,4194304,5456,98305,4259840,324,4237353,1045,1045,81101,4165,4294967296,5444,4295040583,4096,4268680]

theorem envBound5012 : H12AffineFastState.Bounded env5012 := by
  intro p hp
  have h : env5012.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5011_5012 : H12AffineEnvironment.transform 17 48236 env5011 = env5012 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 48236 env5011 == env5012) = true)

def env5013 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4177,32768,65536,4096,48236,110112,32768,4097,4194304,5204,98305,4259840,64,4237353,1045,1045,81101,4165,4294967296,5184,4295040583,4096,4268680]

theorem envBound5013 : H12AffineFastState.Bounded env5013 := by
  intro p hp
  have h : env5013.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5012_5013 : H12AffineEnvironment.transform 7 4 env5012 = env5013 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env5012 == env5013) = true)

theorem identity5013 : scanCanonicalize (H12AffineFastState.compose env5013 (packedSelected [1,3,8,10,31] rootPS)) = affineNative (2^(21+1) ^^^ 73865) := by decide +kernel

theorem selectedBound5013 : packedSelected [1,3,8,10,31] rootPS < 2^1333 := by decide +kernel

def env5014 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4177,32768,65536,4096,48236,110112,32768,4097,73865,5204,98305,8329,64,100512,1045,1045,81101,4165,4294967296,5184,4295040583,4096,513]

theorem envBound5014 : H12AffineFastState.Bounded env5014 := by
  intro p hp
  have h : env5014.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5013_5014 : H12AffineEnvironment.transform 21 73865 env5013 = env5014 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 73865 env5013 == env5014) = true)

theorem identity5014 : scanCanonicalize (H12AffineFastState.compose env5014 (packedSelected [0,1,4,5,7,8,9,12,13] rootPS)) = affineNative (2^(12+1) ^^^ 7271) := by decide +kernel

theorem selectedBound5014 : packedSelected [0,1,4,5,7,8,9,12,13] rootPS < 2^1333 := by decide +kernel

def env5015 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,7271,4177,32768,65536,4096,32779,102983,32768,4097,72942,5204,98305,7406,64,100512,1045,1045,65706,4165,4294967296,5184,4295040583,4096,513]

theorem envBound5015 : H12AffineFastState.Bounded env5015 := by
  intro p hp
  have h : env5015.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5014_5015 : H12AffineEnvironment.transform 12 7271 env5014 = env5015 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 7271 env5014 == env5015) = true)

theorem identity5015 : scanCanonicalize (H12AffineFastState.compose env5015 (packedSelected [0,7,16] rootPS)) = affineNative (2^(11+1) ^^^ 1741) := by decide +kernel

theorem selectedBound5015 : packedSelected [0,7,16] rootPS < 2^1333 := by decide +kernel

def env5016 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1741,2730,1692,32768,65536,1741,32779,99466,32768,1740,68131,665,98305,2595,64,100512,1045,1045,65706,1672,4294967296,653,4295035018,1741,513]

theorem envBound5016 : H12AffineFastState.Bounded env5016 := by
  intro p hp
  have h : env5016.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5015_5016 : H12AffineEnvironment.transform 11 1741 env5015 = env5016 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1741 env5015 == env5016) = true)

def env5017 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1741,2730,1692,32768,2176,1741,32779,35850,32768,1740,675,665,34945,2595,64,32800,1045,1045,2090,1672,4294967296,653,4294967306,1741,513]

theorem envBound5017 : H12AffineFastState.Bounded env5017 := by
  intro p hp
  have h : env5017.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5016_5017 : H12AffineEnvironment.transform 15 2176 env5016 = env5017 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2176 env5016 == env5017) = true)

theorem identity5017 : scanCanonicalize (H12AffineFastState.compose env5017 (packedSelected [0,6] rootPS)) = affineNative (2^(14+1) ^^^ 2138) := by decide +kernel

theorem selectedBound5017 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env5018 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1741,2730,1692,2138,2176,1741,2129,1104,2138,1740,675,665,219,2595,64,2170,1045,1045,2090,1672,4294967296,653,4294967306,1741,513]

theorem envBound5018 : H12AffineFastState.Bounded env5018 := by
  intro p hp
  have h : env5018.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5017_5018 : H12AffineEnvironment.transform 14 2138 env5017 = env5018 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2138 env5017 == env5018) = true)

def env5019 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1741,2730,1692,32768,2177,1741,32779,35851,32768,1740,674,665,34944,2595,64,32801,1045,1045,2091,1672,4294967296,653,4294967307,1741,513]

theorem envBound5019 : H12AffineFastState.Bounded env5019 := by
  intro p hp
  have h : env5019.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5016_5019 : H12AffineEnvironment.transform 15 2177 env5016 = env5019 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2177 env5016 == env5019) = true)

theorem identity5019 : scanCanonicalize (H12AffineFastState.compose env5019 (packedSelected [0,6] rootPS)) = affineNative (2^(14+1) ^^^ 2160) := by decide +kernel

theorem selectedBound5019 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env5020 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1741,2730,1692,2160,2177,1741,2171,1147,2160,1740,674,665,240,2595,64,2129,1045,1045,2091,1672,4294967296,653,4294967307,1741,513]

theorem envBound5020 : H12AffineFastState.Bounded env5020 := by
  intro p hp
  have h : env5020.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5019_5020 : H12AffineEnvironment.transform 14 2160 env5019 = env5020 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2160 env5019 == env5020) = true)

theorem identity5020 : scanCanonicalize (H12AffineFastState.compose env5020 (packedSelected [2,4,5,8] rootPS)) = affineNative (2^(5+1) ^^^ 58) := by decide +kernel

theorem selectedBound5020 : packedSelected [2,4,5,8] rootPS < 2^1333 := by decide +kernel

def env5021 : List Nat := [2,4,8,16,32,58,128,4,512,1024,2048,1719,2730,1692,2058,2177,1719,2049,1025,2058,1718,674,665,138,2595,58,2091,1045,1045,2091,1672,4294967296,653,4294967307,1719,513]

theorem envBound5021 : H12AffineFastState.Bounded env5021 := by
  intro p hp
  have h : env5021.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5020_5021 : H12AffineEnvironment.transform 5 58 env5020 = env5021 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 58 env5020 == env5021) = true)

def env5022 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,4096,8192,4177,32768,65536,4096,48236,110112,32768,4097,4194304,5205,98305,4259840,65,4237353,1045,1045,81101,4165,4294967296,5185,4295040583,4096,4268680]

theorem envBound5022 : H12AffineFastState.Bounded env5022 := by
  intro p hp
  have h : env5022.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5012_5022 : H12AffineEnvironment.transform 7 5 env5012 = env5022 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env5012 == env5022) = true)

theorem identity5022 : scanCanonicalize (H12AffineFastState.compose env5022 (packedSelected [10,12,13,15,17,19] rootPS)) = affineNative (2^(21+1) ^^^ 40963) := by decide +kernel

theorem selectedBound5022 : packedSelected [10,12,13,15,17,19] rootPS < 2^1333 := by decide +kernel

def env5023 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,4096,8192,4177,32768,65536,4096,48236,110112,32768,4097,40963,5205,98305,106499,65,2090,1045,1045,81101,4165,4294967296,5185,4295040583,4096,98955]

theorem envBound5023 : H12AffineFastState.Bounded env5023 := by
  intro p hp
  have h : env5023.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5022_5023 : H12AffineEnvironment.transform 21 40963 env5022 = env5023 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 40963 env5022 == env5023) = true)

theorem identity5023 : scanCanonicalize (H12AffineFastState.compose env5023 (packedSelected [11,18,20] rootPS)) = affineNative (2^(11+1) ^^^ 1092) := by decide +kernel

theorem selectedBound5023 : packedSelected [11,18,20] rootPS < 2^1333 := by decide +kernel

def env5024 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1092,8192,1045,32768,65536,1092,43048,110112,32768,1093,40963,17,98305,106499,65,2090,1045,1045,75913,1025,4294967296,5,4295035395,1092,98955]

theorem envBound5024 : H12AffineFastState.Bounded env5024 := by
  intro p hp
  have h : env5024.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5023_5024 : H12AffineEnvironment.transform 11 1092 env5023 = env5024 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1092 env5023 == env5024) = true)

theorem identity5024 : scanCanonicalize (H12AffineFastState.compose env5024 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(14+1) ^^^ 2722) := by decide +kernel

theorem selectedBound5024 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env5025 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1092,8192,1045,2722,65536,1092,8842,74882,2722,1093,10913,17,68259,76449,65,2090,1045,1045,75913,1025,4294967296,5,4295035395,1092,67625]

theorem envBound5025 : H12AffineFastState.Bounded env5025 := by
  intro p hp
  have h : env5025.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5024_5025 : H12AffineEnvironment.transform 14 2722 env5024 = env5025 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2722 env5024 == env5025) = true)

theorem identity5025 : scanCanonicalize (H12AffineFastState.compose env5025 (packedSelected [0,2,4,6,11] rootPS)) = affineNative (2^(15+1) ^^^ 8322) := by decide +kernel

theorem selectedBound5025 : packedSelected [0,2,4,6,11] rootPS < 2^1333 := by decide +kernel

def env5026 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1092,8192,1045,2722,8322,1092,8842,1024,2722,1093,10913,17,10785,2595,65,2090,1045,1045,2059,1025,4294967296,5,4294978177,1092,10411]

theorem envBound5026 : H12AffineFastState.Bounded env5026 := by
  intro p hp
  have h : env5026.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5025_5026 : H12AffineEnvironment.transform 15 8322 env5025 = env5026 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8322 env5025 == env5026) = true)

theorem identity5026 : scanCanonicalize (H12AffineFastState.compose env5026 (packedSelected [0,6,7,16] rootPS)) = affineNative (2^(31+1) ^^^ 10880) := by decide +kernel

theorem selectedBound5026 : packedSelected [0,6,7,16] rootPS < 2^1333 := by decide +kernel

def env5027 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1092,8192,1045,2722,8322,1092,8842,1024,2722,1093,10913,17,10785,2595,65,2090,1045,1045,2059,1025,10880,5,1,1092,10411]

theorem envBound5027 : H12AffineFastState.Bounded env5027 := by
  intro p hp
  have h : env5027.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5026_5027 : H12AffineEnvironment.transform 31 10880 env5026 = env5027 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 10880 env5026 == env5027) = true)

theorem identity5027 : scanCanonicalize (H12AffineFastState.compose env5027 (packedSelected [0,2,6,7] rootPS)) = affineNative (2^(12+1) ^^^ 2082) := by decide +kernel

theorem selectedBound5027 : packedSelected [0,2,6,7] rootPS < 2^1333 := by decide +kernel

def env5028 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1092,2082,1045,2722,2208,1092,2728,1024,2722,1093,643,17,515,2595,65,2090,1045,1045,2059,1025,674,5,1,1092,137]

theorem envBound5028 : H12AffineFastState.Bounded env5028 := by
  intro p hp
  have h : env5028.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5027_5028 : H12AffineEnvironment.transform 12 2082 env5027 = env5028 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2082 env5027 == env5028) = true)

theorem identity5028 : scanCanonicalize (H12AffineFastState.compose env5028 (packedSelected [1,10,12] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound5028 : packedSelected [1,10,12] rootPS < 2^1333 := by decide +kernel

def env5029 : List Nat := [2,4,8,16,32,17,128,5,512,1024,2048,1045,2082,1045,2722,2208,1045,2728,1024,2722,1044,643,17,515,2595,16,2090,1045,1045,2059,1025,674,5,1,1045,137]

theorem envBound5029 : H12AffineFastState.Bounded env5029 := by
  intro p hp
  have h : env5029.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5028_5029 : H12AffineEnvironment.transform 5 17 env5028 = env5029 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env5028 == env5029) = true)

theorem identity5029 : scanCanonicalize (H12AffineFastState.compose env5029 (packedSelected [1,3] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound5029 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5030 : List Nat := [2,4,8,16,32,17,128,5,137,1024,2048,1045,2082,1045,2091,2208,1045,2081,1024,2091,1044,10,17,138,2218,16,2090,1045,1045,2059,1025,43,5,1,1045,137]

theorem envBound5030 : H12AffineFastState.Bounded env5030 := by
  intro p hp
  have h : env5030.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5029_5030 : H12AffineEnvironment.transform 8 137 env5029 = env5030 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env5029 == env5030) = true)

theorem identity5030 : scanCanonicalize (H12AffineFastState.compose env5030 (packedSelected [0,2] rootPS)) = affineNative (2^(3+1) ^^^ 9) := by decide +kernel

theorem selectedBound5030 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env5031 : List Nat := [2,4,8,9,32,8,128,5,137,1024,2048,1036,2082,1036,2091,2208,1036,2081,1024,2091,1037,10,8,138,2218,9,2090,1036,1036,2059,1025,43,5,1,1036,137]

theorem envBound5031 : H12AffineFastState.Bounded env5031 := by
  intro p hp
  have h : env5031.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5030_5031 : H12AffineEnvironment.transform 3 9 env5030 = env5031 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 9 env5030 == env5031) = true)

theorem identity5031 : scanCanonicalize (H12AffineFastState.compose env5031 (packedSelected [0,4] rootPS)) = affineNative (2^(6+1) ^^^ 40) := by decide +kernel

theorem selectedBound5031 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env5032 : List Nat := [2,4,8,9,32,8,40,5,33,1024,2048,1036,2082,1036,2091,2056,1036,2081,1024,2091,1037,10,8,34,2050,9,2090,1036,1036,2059,1025,43,5,1,1036,33]

theorem envBound5032 : H12AffineFastState.Bounded env5032 := by
  intro p hp
  have h : env5032.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5031_5032 : H12AffineEnvironment.transform 6 40 env5031 = env5032 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 40 env5031 == env5032) = true)

theorem identity5032 : scanCanonicalize (H12AffineFastState.compose env5032 (packedSelected [6] rootPS)) = affineNative (2^(10+1) ^^^ 1) := by decide +kernel

theorem selectedBound5032 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env5033 : List Nat := [2,4,8,9,32,8,40,5,33,1024,1,1036,35,1036,42,9,1036,32,1024,42,1037,10,8,34,3,9,43,1036,1036,10,1025,43,5,1,1036,33]

theorem envBound5033 : H12AffineFastState.Bounded env5033 := by
  intro p hp
  have h : env5033.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5032_5033 : H12AffineEnvironment.transform 10 1 env5032 = env5033 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env5032 == env5033) = true)

theorem identity5033 : scanCanonicalize (H12AffineFastState.compose env5033 (packedSelected [9] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound5033 : packedSelected [9] rootPS < 2^1333 := by decide +kernel

def env5034 : List Nat := [2,4,8,9,11,8,3,5,10,1024,1,1036,8,1036,1,9,1036,11,1024,1,1037,10,8,9,3,9,0,1036,1036,10,1025,0,5,1,1036,10]

theorem envBound5034 : H12AffineFastState.Bounded env5034 := by
  intro p hp
  have h : env5034.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5033_5034 : H12AffineEnvironment.transform 4 11 env5033 = env5034 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env5033 == env5034) = true)

theorem identity5034 : scanCanonicalize (H12AffineFastState.compose env5034 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 4) := by decide +kernel

theorem selectedBound5034 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env5035 : List Nat := [2,4,8,9,11,8,3,5,10,4,1,8,8,8,1,9,8,11,4,1,9,10,8,9,3,9,0,8,8,10,5,0,5,1,8,10]

theorem envBound5035 : H12AffineFastState.Bounded env5035 := by
  intro p hp
  have h : env5035.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5034_5035 : H12AffineEnvironment.transform 9 4 env5034 = env5035 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 4 env5034 == env5035) = true)

def leafEnv5035 : List Nat := [2,4,8,9,11,8,3,5,10,4,1,8,8,8,1,9,8,11,4,1,9,10,8,9,5,3,1,9,0,8,8,10,5,0,5,1,4,2,8,10,0,9,1]

def active5035 : List Nat := [0,1,2]

def tree5035 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5035 : H12WitnessSearch.Good tree5035 := H12GlobalWitnessIndex.good

theorem leafIdentity5035 : H12AffineFastState.composeSystem env5035 rootObs = leafEnv5035 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5035 rootObs == leafEnv5035) = true)

theorem terminalChecked5035 : H12PackedTerminal.terminalCheckFast leafEnv5035 active5035 tree5035 = true := by decide +kernel

def env5036 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,524288,32768,4097,4194304,5456,16777216,4259841,16875844,4461636,16876565,16876564,1073741824,4164,4294967296,16880964,4295536743,4097,4268681]

theorem envBound5036 : H12AffineFastState.Bounded env5036 := by
  intro p hp
  have h : env5036.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4947_5036 : H12AffineEnvironment.transform 16 4097 env4947 = env5036 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env4947 == env5036) = true)

def env5037 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,524288,32768,4097,4194304,5456,98304,4259841,324,4461636,1045,1044,1073741824,4164,4294967296,5444,4295536743,4097,4268681]

theorem envBound5037 : H12AffineFastState.Bounded env5037 := by
  intro p hp
  have h : env5037.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5036_5037 : H12AffineEnvironment.transform 23 98304 env5036 = env5037 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98304 env5036 == env5037) = true)

theorem identity5037 : scanCanonicalize (H12AffineFastState.compose env5037 (packedSelected [3,5,24] rootPS)) = affineNative (2^(21+1) ^^^ 270605) := by decide +kernel

theorem selectedBound5037 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env5038 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,524288,32768,4097,270605,5456,98304,336140,324,13641,1045,1044,1073741824,4164,4294967296,5444,4295536743,4097,328580]

theorem envBound5038 : H12AffineFastState.Bounded env5038 := by
  intro p hp
  have h : env5038.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5037_5038 : H12AffineEnvironment.transform 21 270605 env5037 = env5038 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 270605 env5037 == env5038) = true)

def env5039 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,524288,32768,4097,270605,5456,98304,336140,324,13641,1045,1044,360608,4164,4294967296,5444,4295536743,4097,328580]

theorem envBound5039 : H12AffineFastState.Bounded env5039 := by
  intro p hp
  have h : env5039.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5038_5039 : H12AffineEnvironment.transform 29 360608 env5038 = env5039 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360608 env5038 == env5039) = true)

theorem identity5039 : scanCanonicalize (H12AffineFastState.compose env5039 (packedSelected [3,5,8,17,21,28] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound5039 : packedSelected [3,5,8,17,21,28] rootPS < 2^1333 := by decide +kernel

def env5040 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4097,262144,524288,32768,4097,270605,5376,98304,336140,276,13593,1045,1044,360608,4116,4294967296,5396,4295536695,4097,328580]

theorem envBound5040 : H12AffineFastState.Bounded env5040 := by
  intro p hp
  have h : env5040.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5039_5040 : H12AffineEnvironment.transform 5 16 env5039 = env5040 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env5039 == env5040) = true)

def env5041 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,524288,32768,4097,270605,5456,98304,336140,324,13641,1045,1044,360609,4164,4294967296,5444,4295536743,4097,328580]

theorem envBound5041 : H12AffineFastState.Bounded env5041 := by
  intro p hp
  have h : env5041.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5038_5041 : H12AffineEnvironment.transform 29 360609 env5038 = env5041 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360609 env5038 == env5041) = true)

theorem identity5041 : scanCanonicalize (H12AffineFastState.compose env5041 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(17+1) ^^^ 48236) := by decide +kernel

theorem selectedBound5041 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env5042 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,48236,524288,32768,4097,40289,5456,98304,105824,324,13641,1045,1044,81101,4164,4294967296,5444,4295536743,4097,114664]

theorem envBound5042 : H12AffineFastState.Bounded env5042 := by
  intro p hp
  have h : env5042.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5041_5042 : H12AffineEnvironment.transform 17 48236 env5041 = env5042 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 48236 env5041 == env5042) = true)

def env5043 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,48236,109816,32768,4097,40289,5456,98304,105824,324,13641,1045,1044,81101,4164,4294967296,5444,4295040159,4097,114664]

theorem envBound5043 : H12AffineFastState.Bounded env5043 := by
  intro p hp
  have h : env5043.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5042_5043 : H12AffineEnvironment.transform 18 109816 env5042 = env5043 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 109816 env5042 == env5043) = true)

theorem identity5043 : scanCanonicalize (H12AffineFastState.compose env5043 (packedSelected [1,8,10,13,15,17] rootPS)) = affineNative (2^(15+1) ^^^ 48616) := by decide +kernel

theorem selectedBound5043 : packedSelected [1,8,10,13,15,17] rootPS < 2^1333 := by decide +kernel

def env5044 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,48616,4097,48236,4368,32768,4097,40289,5456,15848,8328,324,13641,1045,1044,33061,4164,4294967296,5444,4295008631,4097,512]

theorem envBound5044 : H12AffineFastState.Bounded env5044 := by
  intro p hp
  have h : env5044.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5043_5044 : H12AffineEnvironment.transform 15 48616 env5043 = env5044 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 48616 env5043 == env5044) = true)

theorem identity5044 : scanCanonicalize (H12AffineFastState.compose env5044 (packedSelected [0,7,16] rootPS)) = affineNative (2^(12+1) ^^^ 5327) := by decide +kernel

theorem selectedBound5044 : packedSelected [0,7,16] rootPS < 2^1333 := by decide +kernel

def env5045 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,5327,4177,32768,35111,4097,34979,4368,32768,4097,40289,5456,2343,5191,324,390,1045,1044,33061,4164,4294967296,5444,4295005624,4097,512]

theorem envBound5045 : H12AffineFastState.Bounded env5045 := by
  intro p hp
  have h : env5045.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5044_5045 : H12AffineEnvironment.transform 12 5327 env5044 = env5045 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5327 env5044 == env5045) = true)

theorem identity5045 : scanCanonicalize (H12AffineFastState.compose env5045 (packedSelected [0,1,3,4,5,7,8,9,10,19] rootPS)) = affineNative (2^(14+1) ^^^ 2477) := by decide +kernel

theorem selectedBound5045 : packedSelected [0,1,3,4,5,7,8,9,10,19] rootPS < 2^1333 := by decide +kernel

def env5046 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,5327,4177,2477,138,4097,270,4368,2477,4097,5324,5456,2343,5191,324,390,1045,1044,2184,4164,4294967296,5444,4294974485,4097,512]

theorem envBound5046 : H12AffineFastState.Bounded env5046 := by
  intro p hp
  have h : env5046.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5045_5046 : H12AffineEnvironment.transform 14 2477 env5045 = env5046 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2477 env5045 == env5046) = true)

theorem identity5046 : scanCanonicalize (H12AffineFastState.compose env5046 (packedSelected [0,4,7,22] rootPS)) = affineNative (2^(11+1) ^^^ 1223) := by decide +kernel

theorem selectedBound5046 : packedSelected [0,4,7,22] rootPS < 2^1333 := by decide +kernel

def env5047 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1223,8,1174,2477,138,1222,270,1495,2477,1222,11,407,2343,128,324,390,1045,1044,2184,1155,4294967296,387,4294969554,1222,512]

theorem envBound5047 : H12AffineFastState.Bounded env5047 := by
  intro p hp
  have h : env5047.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5046_5047 : H12AffineEnvironment.transform 11 1223 env5046 = env5047 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1223 env5046 == env5047) = true)

theorem identity5047 : scanCanonicalize (H12AffineFastState.compose env5047 (packedSelected [0,1,4,5,7,8,9,11,12,13,20] rootPS)) = affineNative (2^(10+1) ^^^ 1071) := by decide +kernel

theorem selectedBound5047 : packedSelected [0,1,4,5,7,8,9,11,12,13,20] rootPS < 2^1333 := by decide +kernel

def env5048 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1071,1223,8,1174,1410,138,1222,270,1495,1410,1222,11,407,1288,128,324,390,1045,1044,1191,1155,4294967296,387,4294968573,1222,512]

theorem envBound5048 : H12AffineFastState.Bounded env5048 := by
  intro p hp
  have h : env5048.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5047_5048 : H12AffineEnvironment.transform 10 1071 env5047 = env5048 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1071 env5047 == env5048) = true)

theorem identity5048 : scanCanonicalize (H12AffineFastState.compose env5048 (packedSelected [1,4,5,8,9,11,12,13,18,23] rootPS)) = affineNative (2^(9+1) ^^^ 386) := by decide +kernel

theorem selectedBound5048 : packedSelected [1,4,5,8,9,11,12,13,18,23] rootPS < 2^1333 := by decide +kernel

def env5049 : List Nat := [2,4,8,16,32,64,128,256,512,386,429,325,8,276,0,138,324,270,85,0,324,11,407,138,128,324,390,407,406,293,257,4294967296,387,4294967679,324,512]

theorem envBound5049 : H12AffineFastState.Bounded env5049 := by
  intro p hp
  have h : env5049.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5048_5049 : H12AffineEnvironment.transform 9 386 env5048 = env5049 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 386 env5048 == env5049) = true)

theorem identity5049 : scanCanonicalize (H12AffineFastState.compose env5049 (packedSelected [2,6,7,9,11] rootPS)) = affineNative (2^(8+1) ^^^ 271) := by decide +kernel

theorem selectedBound5049 : packedSelected [2,6,7,9,11] rootPS < 2^1333 := by decide +kernel

def env5050 : List Nat := [2,4,8,16,32,64,128,256,271,386,429,325,8,276,0,138,324,270,85,0,324,11,407,138,128,324,390,407,406,293,257,4294967296,387,4294967679,324,271]

theorem envBound5050 : H12AffineFastState.Bounded env5050 := by
  intro p hp
  have h : env5050.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5049_5050 : H12AffineEnvironment.transform 8 271 env5049 = env5050 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 271 env5049 == env5050) = true)

theorem identity5050 : scanCanonicalize (H12AffineFastState.compose env5050 (packedSelected [0,4,5,6,7,8,9] rootPS)) = affineNative (2^(31+1) ^^^ 43) := by decide +kernel

theorem selectedBound5050 : packedSelected [0,4,5,6,7,8,9] rootPS < 2^1333 := by decide +kernel

def env5051 : List Nat := [2,4,8,16,32,64,128,256,271,386,429,325,8,276,0,138,324,270,85,0,324,11,407,138,128,324,390,407,406,293,257,43,387,340,324,271]

theorem envBound5051 : H12AffineFastState.Bounded env5051 := by
  intro p hp
  have h : env5051.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5050_5051 : H12AffineEnvironment.transform 31 43 env5050 = env5051 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 43 env5050 == env5051) = true)

theorem identity5051 : scanCanonicalize (H12AffineFastState.compose env5051 (packedSelected [3,5,8] rootPS)) = affineNative (2^(7+1) ^^^ 84) := by decide +kernel

theorem selectedBound5051 : packedSelected [3,5,8] rootPS < 2^1333 := by decide +kernel

def env5052 : List Nat := [2,4,8,16,32,64,128,84,91,214,249,17,8,64,0,138,16,90,85,0,16,11,195,138,128,16,210,195,194,113,85,43,215,0,16,91]

theorem envBound5052 : H12AffineFastState.Bounded env5052 := by
  intro p hp
  have h : env5052.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5051_5052 : H12AffineEnvironment.transform 7 84 env5051 = env5052 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 84 env5051 == env5052) = true)

theorem identity5052 : scanCanonicalize (H12AffineFastState.compose env5052 (packedSelected [1,2,4,7,10] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound5052 : packedSelected [1,2,4,7,10] rootPS < 2^1333 := by decide +kernel

def env5053 : List Nat := [2,4,8,16,32,64,2,84,91,84,123,17,8,64,0,8,16,90,85,0,16,11,65,8,2,16,80,65,64,113,85,43,85,0,16,91]

theorem envBound5053 : H12AffineFastState.Bounded env5053 := by
  intro p hp
  have h : env5053.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5052_5053 : H12AffineEnvironment.transform 6 2 env5052 = env5053 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env5052 == env5053) = true)

theorem identity5053 : scanCanonicalize (H12AffineFastState.compose env5053 (packedSelected [3] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound5053 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env5054 : List Nat := [2,4,8,16,32,16,2,4,11,4,43,17,8,16,0,8,16,10,5,0,16,11,17,8,2,16,0,17,16,33,5,43,5,0,16,11]

theorem envBound5054 : H12AffineFastState.Bounded env5054 := by
  intro p hp
  have h : env5054.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5053_5054 : H12AffineEnvironment.transform 5 16 env5053 = env5054 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env5053 == env5054) = true)

def env5055 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,48236,109817,32768,4097,40289,5456,98304,105824,324,13641,1045,1044,81101,4164,4294967296,5444,4295040158,4097,114664]

theorem envBound5055 : H12AffineFastState.Bounded env5055 := by
  intro p hp
  have h : env5055.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5042_5055 : H12AffineEnvironment.transform 18 109817 env5042 = env5055 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 109817 env5042 == env5055) = true)

theorem identity5055 : scanCanonicalize (H12AffineFastState.compose env5055 (packedSelected [1,8,10,13,15,17] rootPS)) = affineNative (2^(15+1) ^^^ 48365) := by decide +kernel

theorem selectedBound5055 : packedSelected [1,8,10,13,15,17] rootPS < 2^1333 := by decide +kernel

def env5056 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,48365,4097,48236,4116,32768,4097,40289,5456,15597,8589,324,13641,1045,1044,32800,4164,4294967296,5444,4295008371,4097,773]

theorem envBound5056 : H12AffineFastState.Bounded env5056 := by
  intro p hp
  have h : env5056.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5055_5056 : H12AffineEnvironment.transform 15 48365 env5055 = env5056 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 48365 env5055 == env5056) = true)

theorem identity5056 : scanCanonicalize (H12AffineFastState.compose env5056 (packedSelected [0,1,3,4,5,7,8,10,11,19,20,22,23] rootPS)) = affineNative (2^(12+1) ^^^ 7522) := by decide +kernel

theorem selectedBound5056 : packedSelected [0,1,3,4,5,7,8,10,11,19,20,22,23] rootPS < 2^1333 := by decide +kernel

def env5057 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,7522,4177,32768,33167,4097,33038,4116,32768,4097,40289,5456,399,7407,324,2091,1045,1044,32800,4164,4294967296,5444,4295007505,4097,773]

theorem envBound5057 : H12AffineFastState.Bounded env5057 := by
  intro p hp
  have h : env5057.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5056_5057 : H12AffineEnvironment.transform 12 7522 env5056 = env5057 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 7522 env5056 == env5057) = true)

theorem identity5057 : scanCanonicalize (H12AffineFastState.compose env5057 (packedSelected [3,5,13,15,16,20,21,26] rootPS)) = affineNative (2^(11+1) ^^^ 1344) := by decide +kernel

theorem selectedBound5057 : packedSelected [3,5,13,15,16,20,21,26] rootPS < 2^1333 := by decide +kernel

def env5058 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1344,2082,1297,32768,33167,1345,33038,1364,32768,1345,34849,16,399,2479,324,2091,1045,1044,32800,1284,4294967296,4,4295002193,1345,773]

theorem envBound5058 : H12AffineFastState.Bounded env5058 := by
  intro p hp
  have h : env5058.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5057_5058 : H12AffineEnvironment.transform 11 1344 env5057 = env5058 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1344 env5057 == env5058) = true)

theorem identity5058 : scanCanonicalize (H12AffineFastState.compose env5058 (packedSelected [0,2,4,5,6,8,11] rootPS)) = affineNative (2^(14+1) ^^^ 2091) := by decide +kernel

theorem selectedBound5058 : packedSelected [0,2,4,5,6,8,11] rootPS < 2^1333 := by decide +kernel

def env5059 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1344,2082,1297,2091,2468,1345,2341,1364,2091,1345,10,16,399,2479,324,2091,1045,1044,2059,1284,4294967296,4,4294967418,1345,773]

theorem envBound5059 : H12AffineFastState.Bounded env5059 := by
  intro p hp
  have h : env5059.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5058_5059 : H12AffineEnvironment.transform 14 2091 env5058 = env5059 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2091 env5058 == env5059) = true)

theorem identity5059 : scanCanonicalize (H12AffineFastState.compose env5059 (packedSelected [0,4,5,6,7,8,9,10,13] rootPS)) = affineNative (2^(31+1) ^^^ 729) := by decide +kernel

theorem selectedBound5059 : packedSelected [0,4,5,6,7,8,9,10,13] rootPS < 2^1333 := by decide +kernel

def env5060 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1344,2082,1297,2091,2468,1345,2341,1364,2091,1345,10,16,399,2479,324,2091,1045,1044,2059,1284,729,4,675,1345,773]

theorem envBound5060 : H12AffineFastState.Bounded env5060 := by
  intro p hp
  have h : env5060.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5059_5060 : H12AffineEnvironment.transform 31 729 env5059 = env5060 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 729 env5059 == env5060) = true)

theorem identity5060 : scanCanonicalize (H12AffineFastState.compose env5060 (packedSelected [1,3,8,12,15] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound5060 : packedSelected [1,3,8,12,15] rootPS < 2^1333 := by decide +kernel

def env5061 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1296,2082,1297,2091,2468,1297,2341,1284,2091,1297,10,16,399,2479,276,2091,1045,1044,2059,1284,649,4,675,1297,773]

theorem envBound5061 : H12AffineFastState.Bounded env5061 := by
  intro p hp
  have h : env5061.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5060_5061 : H12AffineEnvironment.transform 5 16 env5060 = env5061 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env5060 == env5061) = true)

theorem identity5061 : scanCanonicalize (H12AffineFastState.compose env5061 (packedSelected [0,3,4,5,6,7,8,9,10] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound5061 : packedSelected [0,3,4,5,6,7,8,9,10] rootPS < 2^1333 := by decide +kernel

def env5062 : List Nat := [2,4,8,16,32,16,128,4,512,1024,2048,1044,2082,1045,2091,2208,1045,2081,1024,2091,1045,10,16,139,2219,16,2091,1045,1044,2059,1024,649,4,675,1045,513]

theorem envBound5062 : H12AffineFastState.Bounded env5062 := by
  intro p hp
  have h : env5062.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5061_5062 : H12AffineEnvironment.transform 7 4 env5061 = env5062 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env5061 == env5062) = true)

theorem identity5062 : scanCanonicalize (H12AffineFastState.compose env5062 (packedSelected [1] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound5062 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5063 : List Nat := [2,4,8,1,32,1,128,4,512,1024,2048,1029,2082,1028,2091,2208,1028,2081,1024,2091,1028,10,1,139,2219,1,2091,1028,1029,2059,1024,649,4,675,1028,513]

theorem envBound5063 : H12AffineFastState.Bounded env5063 := by
  intro p hp
  have h : env5063.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5062_5063 : H12AffineEnvironment.transform 3 1 env5062 = env5063 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env5062 == env5063) = true)

def env5064 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,524288,32768,4097,4194304,5456,98305,4259841,325,4461636,1044,1045,1073741824,4164,4294967296,5445,4295536743,4097,4268681]

theorem envBound5064 : H12AffineFastState.Bounded env5064 := by
  intro p hp
  have h : env5064.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5036_5064 : H12AffineEnvironment.transform 23 98305 env5036 = env5064 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98305 env5036 == env5064) = true)

theorem identity5064 : scanCanonicalize (H12AffineFastState.compose env5064 (packedSelected [3,5,24] rootPS)) = affineNative (2^(21+1) ^^^ 795916) := by decide +kernel

theorem selectedBound5064 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env5065 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,524288,32768,4097,795916,5456,98305,861453,325,536904,1044,1045,1073741824,4164,4294967296,5445,4295536743,4097,853893]

theorem envBound5065 : H12AffineFastState.Bounded env5065 := by
  intro p hp
  have h : env5065.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5064_5065 : H12AffineEnvironment.transform 21 795916 env5064 = env5065 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 795916 env5064 == env5065) = true)

def env5066 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,524288,32768,4097,795916,5456,98305,861453,325,536904,1044,1045,360608,4164,4294967296,5445,4295536743,4097,853893]

theorem envBound5066 : H12AffineFastState.Bounded env5066 := by
  intro p hp
  have h : env5066.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5065_5066 : H12AffineEnvironment.transform 29 360608 env5065 = env5066 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360608 env5065 == env5066) = true)

theorem identity5066 : scanCanonicalize (H12AffineFastState.compose env5066 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(17+1) ^^^ 48237) := by decide +kernel

theorem selectedBound5066 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env5067 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,48237,524288,32768,4097,563553,5456,98305,629088,325,536904,1044,1045,81101,4164,4294967296,5445,4295536743,4097,637928]

theorem envBound5067 : H12AffineFastState.Bounded env5067 := by
  intro p hp
  have h : env5067.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5066_5067 : H12AffineEnvironment.transform 17 48237 env5066 = env5067 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 48237 env5066 == env5067) = true)

def env5068 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4177,32768,65536,4097,48237,524288,32768,4097,563301,5204,98305,628836,65,536652,1044,1045,81101,4164,4294967296,5185,4295536743,4097,637676]

theorem envBound5068 : H12AffineFastState.Bounded env5068 := by
  intro p hp
  have h : env5068.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5067_5068 : H12AffineEnvironment.transform 7 4 env5067 = env5068 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env5067 == env5068) = true)

theorem identity5068 : scanCanonicalize (H12AffineFastState.compose env5068 (packedSelected [1,3,8,10,31] rootPS)) = affineNative (2^(18+1) ^^^ 112877) := by decide +kernel

theorem selectedBound5068 : packedSelected [1,3,8,10,31] rootPS < 2^1333 := by decide +kernel

def env5069 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4177,32768,65536,4097,48237,112877,32768,4097,73864,5204,98305,8329,65,100513,1044,1045,81101,4164,4294967296,5185,4295035018,4097,513]

theorem envBound5069 : H12AffineFastState.Bounded env5069 := by
  intro p hp
  have h : env5069.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5068_5069 : H12AffineEnvironment.transform 18 112877 env5068 = env5069 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 112877 env5068 == env5069) = true)

theorem identity5069 : scanCanonicalize (H12AffineFastState.compose env5069 (packedSelected [0,1,4,5,7,8,9,12,13] rootPS)) = affineNative (2^(12+1) ^^^ 2731) := by decide +kernel

theorem selectedBound5069 : packedSelected [0,1,4,5,7,8,9,12,13] rootPS < 2^1333 := by decide +kernel

def env5070 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,2731,4177,32768,65536,4097,38598,102982,32768,4097,68131,5204,98305,2594,65,100513,1044,1045,71270,4164,4294967296,5185,4295035018,4097,513]

theorem envBound5070 : H12AffineFastState.Bounded env5070 := by
  intro p hp
  have h : env5070.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5069_5070 : H12AffineEnvironment.transform 12 2731 env5069 = env5070 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2731 env5069 == env5070) = true)

theorem identity5070 : scanCanonicalize (H12AffineFastState.compose env5070 (packedSelected [0,7,16] rootPS)) = affineNative (2^(11+1) ^^^ 1740) := by decide +kernel

theorem selectedBound5070 : packedSelected [0,7,16] rootPS < 2^1333 := by decide +kernel

def env5071 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1740,2731,1693,32768,65536,1741,32778,99466,32768,1741,68131,664,98305,2594,65,100513,1044,1045,65706,1672,4294967296,653,4295035018,1741,513]

theorem envBound5071 : H12AffineFastState.Bounded env5071 := by
  intro p hp
  have h : env5071.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5070_5071 : H12AffineEnvironment.transform 11 1740 env5070 = env5071 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1740 env5070 == env5071) = true)

def env5072 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1740,2731,1693,32768,2176,1741,32778,35850,32768,1741,675,664,34945,2594,65,32801,1044,1045,2090,1672,4294967296,653,4294967306,1741,513]

theorem envBound5072 : H12AffineFastState.Bounded env5072 := by
  intro p hp
  have h : env5072.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5071_5072 : H12AffineEnvironment.transform 15 2176 env5071 = env5072 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2176 env5071 == env5072) = true)

theorem identity5072 : scanCanonicalize (H12AffineFastState.compose env5072 (packedSelected [0,6] rootPS)) = affineNative (2^(14+1) ^^^ 2161) := by decide +kernel

theorem selectedBound5072 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env5073 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1740,2731,1693,2161,2176,1741,2171,1147,2161,1741,675,664,240,2594,65,2128,1044,1045,2090,1672,4294967296,653,4294967306,1741,513]

theorem envBound5073 : H12AffineFastState.Bounded env5073 := by
  intro p hp
  have h : env5073.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5072_5073 : H12AffineEnvironment.transform 14 2161 env5072 = env5073 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2161 env5072 == env5073) = true)

theorem identity5073 : scanCanonicalize (H12AffineFastState.compose env5073 (packedSelected [2,4,5,8] rootPS)) = affineNative (2^(5+1) ^^^ 58) := by decide +kernel

theorem selectedBound5073 : packedSelected [2,4,5,8] rootPS < 2^1333 := by decide +kernel

def env5074 : List Nat := [2,4,8,16,32,58,128,4,512,1024,2048,1718,2731,1693,2059,2176,1719,2049,1025,2059,1719,675,664,138,2594,59,2090,1044,1045,2090,1672,4294967296,653,4294967306,1719,513]

theorem envBound5074 : H12AffineFastState.Bounded env5074 := by
  intro p hp
  have h : env5074.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5073_5074 : H12AffineEnvironment.transform 5 58 env5073 = env5074 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 58 env5073 == env5074) = true)

def env5075 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1740,2731,1693,32768,2177,1741,32778,35851,32768,1741,674,664,34944,2594,65,32800,1044,1045,2091,1672,4294967296,653,4294967307,1741,513]

theorem envBound5075 : H12AffineFastState.Bounded env5075 := by
  intro p hp
  have h : env5075.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5071_5075 : H12AffineEnvironment.transform 15 2177 env5071 = env5075 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2177 env5071 == env5075) = true)

theorem identity5075 : scanCanonicalize (H12AffineFastState.compose env5075 (packedSelected [0,6] rootPS)) = affineNative (2^(14+1) ^^^ 2138) := by decide +kernel

theorem selectedBound5075 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env5076 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1740,2731,1693,2138,2177,1741,2128,1105,2138,1741,674,664,218,2594,65,2170,1044,1045,2091,1672,4294967296,653,4294967307,1741,513]

theorem envBound5076 : H12AffineFastState.Bounded env5076 := by
  intro p hp
  have h : env5076.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5075_5076 : H12AffineEnvironment.transform 14 2138 env5075 = env5076 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2138 env5075 == env5076) = true)

def env5077 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,4096,8192,4177,32768,65536,4097,48237,524288,32768,4097,563300,5205,98305,628837,64,536653,1044,1045,81101,4164,4294967296,5184,4295536743,4097,637677]

theorem envBound5077 : H12AffineFastState.Bounded env5077 := by
  intro p hp
  have h : env5077.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5067_5077 : H12AffineEnvironment.transform 7 5 env5067 = env5077 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env5067 == env5077) = true)

theorem identity5077 : scanCanonicalize (H12AffineFastState.compose env5077 (packedSelected [10,12,13,15,17,19] rootPS)) = affineNative (2^(18+1) ^^^ 14438) := by decide +kernel

theorem selectedBound5077 : packedSelected [10,12,13,15,17,19] rootPS < 2^1333 := by decide +kernel

def env5078 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,4096,8192,4177,32768,65536,4097,48237,14438,32768,4097,40962,5205,98305,106499,64,2091,1044,1045,81101,4164,4294967296,5184,4295002113,4097,98955]

theorem envBound5078 : H12AffineFastState.Bounded env5078 := by
  intro p hp
  have h : env5078.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5077_5078 : H12AffineEnvironment.transform 18 14438 env5077 = env5078 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 14438 env5077 == env5078) = true)

theorem identity5078 : scanCanonicalize (H12AffineFastState.compose env5078 (packedSelected [11,18,20] rootPS)) = affineNative (2^(11+1) ^^^ 1093) := by decide +kernel

theorem selectedBound5078 : packedSelected [11,18,20] rootPS < 2^1333 := by decide +kernel

def env5079 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1093,8192,1044,32768,65536,1092,43048,11299,32768,1092,40962,16,98305,106499,64,2091,1044,1045,75912,1025,4294967296,5,4295002113,1092,98955]

theorem envBound5079 : H12AffineFastState.Bounded env5079 := by
  intro p hp
  have h : env5079.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5078_5079 : H12AffineEnvironment.transform 11 1093 env5078 = env5079 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1093 env5078 == env5079) = true)

theorem identity5079 : scanCanonicalize (H12AffineFastState.compose env5079 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(15+1) ^^^ 2209) := by decide +kernel

theorem selectedBound5079 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env5080 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1093,8192,1044,32768,2209,1092,43048,11299,32768,1092,40962,16,34976,43170,64,2091,1044,1045,8233,1025,4294967296,5,4295002113,1092,35370]

theorem envBound5080 : H12AffineFastState.Bounded env5080 := by
  intro p hp
  have h : env5080.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5079_5080 : H12AffineEnvironment.transform 15 2209 env5079 = env5080 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2209 env5079 == env5080) = true)

theorem identity5080 : scanCanonicalize (H12AffineFastState.compose env5080 (packedSelected [1,3,12,13,15,21] rootPS)) = affineNative (2^(12+1) ^^^ 2083) := by decide +kernel

theorem selectedBound5080 : packedSelected [1,3,12,13,15,21] rootPS < 2^1333 := by decide +kernel

def env5081 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1093,2083,1044,32768,2209,1092,32779,1024,32768,1092,34849,16,34976,32897,64,2091,1044,1045,2058,1025,4294967296,5,4295002113,1092,35370]

theorem envBound5081 : H12AffineFastState.Bounded env5081 := by
  intro p hp
  have h : env5081.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5080_5081 : H12AffineEnvironment.transform 12 2083 env5080 = env5081 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2083 env5080 == env5081) = true)

theorem identity5081 : scanCanonicalize (H12AffineFastState.compose env5081 (packedSelected [1,10,12] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound5081 : packedSelected [1,10,12] rootPS < 2^1333 := by decide +kernel

def env5082 : List Nat := [2,4,8,16,32,16,128,5,512,1024,2048,1045,2083,1044,32768,2209,1044,32779,1024,32768,1044,34849,16,34976,32897,16,2091,1044,1045,2058,1025,4294967296,5,4295002113,1044,35370]

theorem envBound5082 : H12AffineFastState.Bounded env5082 := by
  intro p hp
  have h : env5082.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5081_5082 : H12AffineEnvironment.transform 5 16 env5081 = env5082 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env5081 == env5082) = true)

theorem identity5082 : scanCanonicalize (H12AffineFastState.compose env5082 (packedSelected [1,3] rootPS)) = affineNative (2^(14+1) ^^^ 2090) := by decide +kernel

theorem selectedBound5082 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5083 : List Nat := [2,4,8,16,32,16,128,5,512,1024,2048,1045,2083,1044,2090,2209,1044,2081,1024,2090,1044,11,16,138,2219,16,2091,1044,1045,2058,1025,4294967296,5,4294967339,1044,512]

theorem envBound5083 : H12AffineFastState.Bounded env5083 := by
  intro p hp
  have h : env5083.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5082_5083 : H12AffineEnvironment.transform 14 2090 env5082 = env5083 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2090 env5082 == env5083) = true)

theorem identity5083 : scanCanonicalize (H12AffineFastState.compose env5083 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 2178) := by decide +kernel

theorem selectedBound5083 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env5084 : List Nat := [2,4,8,16,32,16,128,5,512,1024,2048,1045,2083,1044,2090,2209,1044,2081,1024,2090,1044,11,16,138,2219,16,2091,1044,1045,2058,1025,2178,5,2217,1044,512]

theorem envBound5084 : H12AffineFastState.Bounded env5084 := by
  intro p hp
  have h : env5084.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5083_5084 : H12AffineEnvironment.transform 31 2178 env5083 = env5084 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 2178 env5083 == env5084) = true)

theorem identity5084 : scanCanonicalize (H12AffineFastState.compose env5084 (packedSelected [2,4,7] rootPS)) = affineNative (2^(8+1) ^^^ 32) := by decide +kernel

theorem selectedBound5084 : packedSelected [2,4,7] rootPS < 2^1333 := by decide +kernel

def env5085 : List Nat := [2,4,8,16,32,16,128,5,32,1024,2048,1045,2083,1044,2090,2209,1044,2081,1024,2090,1044,11,16,138,2219,16,2091,1044,1045,2058,1025,2178,5,2217,1044,32]

theorem envBound5085 : H12AffineFastState.Bounded env5085 := by
  intro p hp
  have h : env5085.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5084_5085 : H12AffineEnvironment.transform 8 32 env5084 = env5085 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 32 env5084 == env5085) = true)

theorem identity5085 : scanCanonicalize (H12AffineFastState.compose env5085 (packedSelected [0,2,9] rootPS)) = affineNative (2^(10+1) ^^^ 43) := by decide +kernel

theorem selectedBound5085 : packedSelected [0,2,9] rootPS < 2^1333 := by decide +kernel

def env5086 : List Nat := [2,4,8,16,32,16,128,5,32,1024,43,1045,8,1044,1,138,1044,10,1024,1,1044,11,16,138,128,16,0,1044,1045,33,1025,169,5,130,1044,32]

theorem envBound5086 : H12AffineFastState.Bounded env5086 := by
  intro p hp
  have h : env5086.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5085_5086 : H12AffineEnvironment.transform 10 43 env5085 = env5086 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 43 env5085 == env5086) = true)

theorem identity5086 : scanCanonicalize (H12AffineFastState.compose env5086 (packedSelected [0,2] rootPS)) = affineNative (2^(3+1) ^^^ 9) := by decide +kernel

theorem selectedBound5086 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env5087 : List Nat := [2,4,8,9,32,9,128,5,32,1024,43,1036,8,1037,1,138,1037,10,1024,1,1037,11,9,138,128,9,0,1037,1036,33,1025,169,5,130,1037,32]

theorem envBound5087 : H12AffineFastState.Bounded env5087 := by
  intro p hp
  have h : env5087.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5086_5087 : H12AffineEnvironment.transform 3 9 env5086 = env5087 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 9 env5086 == env5087) = true)

theorem identity5087 : scanCanonicalize (H12AffineFastState.compose env5087 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 47) := by decide +kernel

theorem selectedBound5087 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env5088 : List Nat := [2,4,8,9,32,9,128,5,32,47,43,35,8,34,1,138,34,10,47,1,34,11,9,138,128,9,0,34,35,33,46,169,5,130,34,32]

theorem envBound5088 : H12AffineFastState.Bounded env5088 := by
  intro p hp
  have h : env5088.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5087_5088 : H12AffineEnvironment.transform 9 47 env5087 = env5088 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 47 env5087 == env5088) = true)

theorem identity5088 : scanCanonicalize (H12AffineFastState.compose env5088 (packedSelected [4,11] rootPS)) = affineNative (2^(6+1) ^^^ 40) := by decide +kernel

theorem selectedBound5088 : packedSelected [4,11] rootPS < 2^1333 := by decide +kernel

def env5089 : List Nat := [2,4,8,9,32,9,40,5,32,47,43,35,8,34,1,34,34,10,47,1,34,11,9,34,40,9,0,34,35,33,46,1,5,42,34,32]

theorem envBound5089 : H12AffineFastState.Bounded env5089 := by
  intro p hp
  have h : env5089.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5088_5089 : H12AffineEnvironment.transform 6 40 env5088 = env5089 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 40 env5088 == env5089) = true)

theorem identity5089 : scanCanonicalize (H12AffineFastState.compose env5089 (packedSelected [0,4] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound5089 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env5090 : List Nat := [2,4,8,9,10,9,2,5,10,5,1,9,8,8,1,8,8,10,5,1,8,11,9,8,2,9,0,8,9,11,4,1,5,0,8,10]

theorem envBound5090 : H12AffineFastState.Bounded env5090 := by
  intro p hp
  have h : env5090.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5089_5090 : H12AffineEnvironment.transform 4 10 env5089 = env5090 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env5089 == env5090) = true)

def env5091 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,524288,32768,4097,795916,5456,98305,861453,325,536904,1044,1045,360609,4164,4294967296,5445,4295536743,4097,853893]

theorem envBound5091 : H12AffineFastState.Bounded env5091 := by
  intro p hp
  have h : env5091.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5065_5091 : H12AffineEnvironment.transform 29 360609 env5065 = env5091 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360609 env5065 == env5091) = true)

theorem identity5091 : scanCanonicalize (H12AffineFastState.compose env5091 (packedSelected [3,5,8,17,21,28] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound5091 : packedSelected [3,5,8,17,21,28] rootPS < 2^1333 := by decide +kernel

def env5092 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4097,262144,524288,32768,4097,795916,5376,98305,861453,277,536856,1044,1045,360609,4116,4294967296,5397,4295536695,4097,853893]

theorem envBound5092 : H12AffineFastState.Bounded env5092 := by
  intro p hp
  have h : env5092.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5091_5092 : H12AffineEnvironment.transform 5 16 env5091 = env5092 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env5091 == env5092) = true)

def env5093 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,4194304,5456,16777216,4395009,17011013,4588613,17011732,16876564,1073741824,131141,4294967296,17007941,4295536742,131072,4403849]

theorem envBound5093 : H12AffineFastState.Bounded env5093 := by
  intro p hp
  have h : env5093.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4946_5093 : H12AffineEnvironment.transform 24 4395009 env4946 = env5093 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 4395009 env4946 == env5093) = true)

def env5094 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4096,262144,524288,32768,4097,4194304,5456,16777216,4259841,16875845,4461637,16876564,16876564,1073741824,4165,4294967296,16880965,4295536742,4096,4268681]

theorem envBound5094 : H12AffineFastState.Bounded env5094 := by
  intro p hp
  have h : env5094.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5093_5094 : H12AffineEnvironment.transform 16 4096 env5093 = env5094 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env5093 == env5094) = true)

def env5095 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4096,262144,524288,32768,4097,4194304,5456,98304,4259841,325,4461637,1044,1044,1073741824,4165,4294967296,5445,4295536742,4096,4268681]

theorem envBound5095 : H12AffineFastState.Bounded env5095 := by
  intro p hp
  have h : env5095.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5094_5095 : H12AffineEnvironment.transform 23 98304 env5094 = env5095 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98304 env5094 == env5095) = true)

theorem identity5095 : scanCanonicalize (H12AffineFastState.compose env5095 (packedSelected [3,5,24] rootPS)) = affineNative (2^(17+1) ^^^ 71497) := by decide +kernel

theorem selectedBound5095 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env5096 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4096,71497,524288,32768,4097,4194304,5456,98304,4259841,325,4260620,1044,1044,1073741824,4165,4294967296,5445,4295536742,4096,4268681]

theorem envBound5096 : H12AffineFastState.Bounded env5096 := by
  intro p hp
  have h : env5096.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5095_5096 : H12AffineEnvironment.transform 17 71497 env5095 = env5096 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 71497 env5095 == env5096) = true)

def env5097 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4096,71449,524288,32768,4097,4194304,5376,98304,4259841,277,4260620,1044,1044,1073741824,4117,4294967296,5397,4295536694,4096,4268681]

theorem envBound5097 : H12AffineFastState.Bounded env5097 := by
  intro p hp
  have h : env5097.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5096_5097 : H12AffineEnvironment.transform 5 16 env5096 = env5097 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env5096 == env5097) = true)

theorem identity5097 : scanCanonicalize (H12AffineFastState.compose env5097 (packedSelected [3,5,8,17,21,28] rootPS)) = affineNative (2^(29+1) ^^^ 38840) := by decide +kernel

theorem selectedBound5097 : packedSelected [3,5,8,17,21,28] rootPS < 2^1333 := by decide +kernel

def env5098 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4096,71449,524288,32768,4097,4194304,5376,98304,4259841,277,4260620,1044,1044,38840,4117,4294967296,5397,4295536694,4096,4268681]

theorem envBound5098 : H12AffineFastState.Bounded env5098 := by
  intro p hp
  have h : env5098.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5097_5098 : H12AffineEnvironment.transform 29 38840 env5097 = env5098 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 38840 env5097 == env5098) = true)

theorem identity5098 : scanCanonicalize (H12AffineFastState.compose env5098 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(15+1) ^^^ 43812) := by decide +kernel

theorem selectedBound5098 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env5099 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,43812,4096,48189,524288,32768,4097,4194304,5376,11044,4238117,277,4237352,1044,1044,38840,4117,4294967296,5397,4295536694,4096,4229549]

theorem envBound5099 : H12AffineFastState.Bounded env5099 := by
  intro p hp
  have h : env5099.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5098_5099 : H12AffineEnvironment.transform 15 43812 env5098 = env5099 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 43812 env5098 == env5099) = true)

def env5100 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,8200,2860,4096,7221,524288,8200,4097,4194304,5376,11044,4197165,277,4196384,1044,1044,14256,4117,4294967296,5397,4295495742,4096,4204965]

theorem envBound5100 : H12AffineFastState.Bounded env5100 := by
  intro p hp
  have h : env5100.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5099_5100 : H12AffineEnvironment.transform 14 8200 env5099 = env5100 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8200 env5099 == env5100) = true)

theorem identity5100 : scanCanonicalize (H12AffineFastState.compose env5100 (packedSelected [3,5,17] rootPS)) = affineNative (2^(11+1) ^^^ 1944) := by decide +kernel

theorem selectedBound5100 : packedSelected [3,5,17] rootPS < 2^1333 := by decide +kernel

def env5101 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,8192,1945,8200,2860,1944,2989,524288,8200,1945,4194304,664,11044,4197165,277,4196384,1044,1044,8232,1933,4294967296,653,4295493542,1944,4204965]

theorem envBound5101 : H12AffineFastState.Bounded env5101 := by
  intro p hp
  have h : env5101.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5100_5101 : H12AffineEnvironment.transform 11 1944 env5100 = env5101 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env5100 == env5101) = true)

theorem identity5101 : scanCanonicalize (H12AffineFastState.compose env5101 (packedSelected [0,1,3,4,7,10,11,13,15,16,18,22] rootPS)) = affineNative (2^(21+1) ^^^ 11) := by decide +kernel

theorem selectedBound5101 : packedSelected [0,1,3,4,7,10,11,13,15,16,18,22] rootPS < 2^1333 := by decide +kernel

def env5102 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,8192,1945,8200,2860,1944,2989,524288,8200,1945,11,664,11044,2854,277,2091,1044,1044,8232,1933,4294967296,653,4295493542,1944,10670]

theorem envBound5102 : H12AffineFastState.Bounded env5102 := by
  intro p hp
  have h : env5102.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5101_5102 : H12AffineEnvironment.transform 21 11 env5101 = env5102 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 11 env5101 == env5102) = true)

theorem identity5102 : scanCanonicalize (H12AffineFastState.compose env5102 (packedSelected [3,12,16,20,26] rootPS)) = affineNative (2^(12+1) ^^^ 2343) := by decide +kernel

theorem selectedBound5102 : packedSelected [3,12,16,20,26] rootPS < 2^1333 := by decide +kernel

def env5103 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,2343,1945,2351,2860,1944,2989,524288,2351,1945,11,664,515,2854,277,2091,1044,1044,2319,1933,4294967296,653,4295493542,1944,137]

theorem envBound5103 : H12AffineFastState.Bounded env5103 := by
  intro p hp
  have h : env5103.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5102_5103 : H12AffineEnvironment.transform 12 2343 env5102 = env5103 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2343 env5102 == env5103) = true)

theorem identity5103 : scanCanonicalize (H12AffineFastState.compose env5103 (packedSelected [0,1,2,3,4,5,6,8,10,11,13,15] rootPS)) = affineNative (2^(18+1) ^^^ 1024) := by decide +kernel

theorem selectedBound5103 : packedSelected [0,1,2,3,4,5,6,8,10,11,13,15] rootPS < 2^1333 := by decide +kernel

def env5104 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,2343,1945,2351,2860,1944,2989,1024,2351,1945,11,664,515,2854,277,2091,1044,1044,2319,1933,4294967296,653,4294968230,1944,137]

theorem envBound5104 : H12AffineFastState.Bounded env5104 := by
  intro p hp
  have h : env5104.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5103_5104 : H12AffineEnvironment.transform 18 1024 env5103 = env5104 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env5103 == env5104) = true)

theorem identity5104 : scanCanonicalize (H12AffineFastState.compose env5104 (packedSelected [16,20] rootPS)) = affineNative (2^(8+1) ^^^ 397) := by decide +kernel

theorem selectedBound5104 : packedSelected [16,20] rootPS < 2^1333 := by decide +kernel

def env5105 : List Nat := [2,4,8,16,32,16,128,256,397,1024,2048,1045,2343,1044,2351,2209,1045,2080,1024,2351,1044,11,277,398,2219,277,2091,1044,1044,2319,1024,4294967296,256,4294967339,1045,137]

theorem envBound5105 : H12AffineFastState.Bounded env5105 := by
  intro p hp
  have h : env5105.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5104_5105 : H12AffineEnvironment.transform 8 397 env5104 = env5105 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 397 env5104 == env5105) = true)

theorem identity5105 : scanCanonicalize (H12AffineFastState.compose env5105 (packedSelected [0,4,6,7,9] rootPS)) = affineNative (2^(31+1) ^^^ 429) := by decide +kernel

theorem selectedBound5105 : packedSelected [0,4,6,7,9] rootPS < 2^1333 := by decide +kernel

def env5106 : List Nat := [2,4,8,16,32,16,128,256,397,1024,2048,1045,2343,1044,2351,2209,1045,2080,1024,2351,1044,11,277,398,2219,277,2091,1044,1044,2319,1024,429,256,390,1045,137]

theorem envBound5106 : H12AffineFastState.Bounded env5106 := by
  intro p hp
  have h : env5106.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5105_5106 : H12AffineEnvironment.transform 31 429 env5105 = env5106 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 429 env5105 == env5106) = true)

def env5107 : List Nat := [2,4,8,16,32,16,128,4,137,1024,2048,1045,2083,1044,2091,2209,1045,2080,1024,2091,1044,11,17,138,2219,17,2091,1044,1044,2059,1024,169,4,130,1045,137]

theorem envBound5107 : H12AffineFastState.Bounded env5107 := by
  intro p hp
  have h : env5107.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5106_5107 : H12AffineEnvironment.transform 7 4 env5106 = env5107 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env5106 == env5107) = true)

theorem identity5107 : scanCanonicalize (H12AffineFastState.compose env5107 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound5107 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5108 : List Nat := [2,4,8,16,32,16,8,4,1,1024,2048,1045,2083,1044,2091,2089,1045,2080,1024,2091,1044,11,17,2,2083,17,2091,1044,1044,2059,1024,33,4,10,1045,1]

theorem envBound5108 : H12AffineFastState.Bounded env5108 := by
  intro p hp
  have h : env5108.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5107_5108 : H12AffineEnvironment.transform 6 8 env5107 = env5108 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env5107 == env5108) = true)

theorem identity5108 : scanCanonicalize (H12AffineFastState.compose env5108 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound5108 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5109 : List Nat := [2,4,8,16,10,16,8,4,1,1024,2048,1045,2057,1044,2049,2051,1045,2058,1024,2049,1044,11,17,2,2057,17,2049,1044,1044,2059,1024,11,4,10,1045,1]

theorem envBound5109 : H12AffineFastState.Bounded env5109 := by
  intro p hp
  have h : env5109.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5108_5109 : H12AffineEnvironment.transform 4 10 env5108 = env5109 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env5108 == env5109) = true)

theorem identity5109 : scanCanonicalize (H12AffineFastState.compose env5109 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 8) := by decide +kernel

theorem selectedBound5109 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5110 : List Nat := [2,4,8,8,10,8,8,4,1,1024,2048,1037,2057,1036,2049,2051,1037,2058,1024,2049,1036,11,9,2,2057,9,2049,1036,1036,2059,1024,11,4,10,1037,1]

theorem envBound5110 : H12AffineFastState.Bounded env5110 := by
  intro p hp
  have h : env5110.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5109_5110 : H12AffineEnvironment.transform 3 8 env5109 = env5110 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 8 env5109 == env5110) = true)

theorem identity5110 : scanCanonicalize (H12AffineFastState.compose env5110 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound5110 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env5111 : List Nat := [2,4,3,3,1,3,3,4,1,1024,2048,1030,2050,1031,2049,2051,1030,2049,1024,2049,1031,0,2,2,2050,2,2049,1031,1031,2048,1024,0,4,1,1030,1]

theorem envBound5111 : H12AffineFastState.Bounded env5111 := by
  intro p hp
  have h : env5111.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5110_5111 : H12AffineEnvironment.transform 2 3 env5110 = env5111 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env5110 == env5111) = true)

theorem identity5111 : scanCanonicalize (H12AffineFastState.compose env5111 (packedSelected [6] rootPS)) = affineNative (2^(10+1) ^^^ 0) := by decide +kernel

theorem selectedBound5111 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env5112 : List Nat := [2,4,3,3,1,3,3,4,1,1024,0,1030,2,1031,1,3,1030,1,1024,1,1031,0,2,2,2,2,1,1031,1031,0,1024,0,4,1,1030,1]

theorem envBound5112 : H12AffineFastState.Bounded env5112 := by
  intro p hp
  have h : env5112.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5111_5112 : H12AffineEnvironment.transform 10 0 env5111 = env5112 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env5111 == env5112) = true)

theorem identity5112 : scanCanonicalize (H12AffineFastState.compose env5112 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 5) := by decide +kernel

theorem selectedBound5112 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env5113 : List Nat := [2,4,3,3,1,3,3,4,1,5,0,3,2,2,1,3,3,1,5,1,2,0,2,2,2,2,1,2,2,0,5,0,4,1,3,1]

theorem envBound5113 : H12AffineFastState.Bounded env5113 := by
  intro p hp
  have h : env5113.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5112_5113 : H12AffineEnvironment.transform 9 5 env5112 = env5113 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 5 env5112 == env5113) = true)

def leafEnv5113 : List Nat := [2,4,3,3,1,3,3,4,1,5,0,3,2,2,1,3,3,1,5,1,2,0,2,2,5,2,1,2,1,2,2,0,5,0,4,1,4,3,3,1,0,3,1]

def active5113 : List Nat := [0,1]

def tree5113 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5113 : H12WitnessSearch.Good tree5113 := H12GlobalWitnessIndex.good

theorem leafIdentity5113 : H12AffineFastState.composeSystem env5113 rootObs = leafEnv5113 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5113 rootObs == leafEnv5113) = true)

theorem terminalChecked5113 : H12PackedTerminal.terminalCheckFast leafEnv5113 active5113 tree5113 = true := by decide +kernel

def env5114 : List Nat := [2,4,8,16,32,16,128,5,136,1024,2048,1045,2082,1044,2090,2209,1045,2080,1024,2090,1044,11,16,139,2219,16,2091,1044,1044,2058,1024,168,5,131,1045,137]

theorem envBound5114 : H12AffineFastState.Bounded env5114 := by
  intro p hp
  have h : env5114.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5106_5114 : H12AffineEnvironment.transform 7 5 env5106 = env5114 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env5106 == env5114) = true)

theorem identity5114 : scanCanonicalize (H12AffineFastState.compose env5114 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 51) := by decide +kernel

theorem selectedBound5114 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5115 : List Nat := [2,4,8,16,32,16,51,5,59,1024,2048,1045,2082,1044,2090,2066,1045,2080,1024,2090,1044,11,16,56,2072,16,2091,1044,1044,2058,1024,27,5,48,1045,58]

theorem envBound5115 : H12AffineFastState.Bounded env5115 := by
  intro p hp
  have h : env5115.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5114_5115 : H12AffineEnvironment.transform 6 51 env5114 = env5115 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 51 env5114 == env5115) = true)

theorem identity5115 : scanCanonicalize (H12AffineFastState.compose env5115 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound5115 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env5116 : List Nat := [2,4,8,16,1,16,18,5,26,1024,2048,1045,2051,1044,2059,2066,1045,2049,1024,2059,1044,11,16,25,2072,16,2058,1044,1044,2058,1024,27,5,17,1045,27]

theorem envBound5116 : H12AffineFastState.Bounded env5116 := by
  intro p hp
  have h : env5116.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5115_5116 : H12AffineEnvironment.transform 4 1 env5115 = env5116 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env5115 == env5116) = true)

theorem identity5116 : scanCanonicalize (H12AffineFastState.compose env5116 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound5116 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5117 : List Nat := [2,4,8,10,1,10,8,5,0,1024,2048,1039,2051,1038,2059,2056,1039,2049,1024,2059,1038,11,10,3,2050,10,2058,1038,1038,2058,1024,1,5,11,1039,1]

theorem envBound5117 : H12AffineFastState.Bounded env5117 := by
  intro p hp
  have h : env5117.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5116_5117 : H12AffineEnvironment.transform 3 10 env5116 = env5117 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env5116 == env5117) = true)

theorem identity5117 : scanCanonicalize (H12AffineFastState.compose env5117 (packedSelected [4] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound5117 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env5118 : List Nat := [2,4,3,1,1,1,3,5,0,1024,2048,1028,2051,1029,2048,2051,1028,2049,1024,2048,1029,0,1,3,2050,1,2049,1029,1029,2049,1024,1,5,0,1028,1]

theorem envBound5118 : H12AffineFastState.Bounded env5118 := by
  intro p hp
  have h : env5118.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5117_5118 : H12AffineEnvironment.transform 2 3 env5117 = env5118 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env5117 == env5118) = true)

def env5119 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,8201,2861,4096,7220,524288,8201,4097,4194304,5376,11044,4197164,277,4196385,1044,1044,14257,4117,4294967296,5397,4295495743,4096,4204964]

theorem envBound5119 : H12AffineFastState.Bounded env5119 := by
  intro p hp
  have h : env5119.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5099_5119 : H12AffineEnvironment.transform 14 8201 env5099 = env5119 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8201 env5099 == env5119) = true)

theorem identity5119 : scanCanonicalize (H12AffineFastState.compose env5119 (packedSelected [3,5,17] rootPS)) = affineNative (2^(11+1) ^^^ 1693) := by decide +kernel

theorem selectedBound5119 : packedSelected [3,5,17] rootPS < 2^1333 := by decide +kernel

def env5120 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1693,8192,1692,8201,2861,1693,2729,524288,8201,1692,4194304,925,11044,4197164,277,4196385,1044,1044,8492,1672,4294967296,904,4295493282,1693,4204964]

theorem envBound5120 : H12AffineFastState.Bounded env5120 := by
  intro p hp
  have h : env5120.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5119_5120 : H12AffineEnvironment.transform 11 1693 env5119 = env5120 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1693 env5119 == env5120) = true)

theorem identity5120 : scanCanonicalize (H12AffineFastState.compose env5120 (packedSelected [0,1,4,7,13,15,16,19,20,21,22] rootPS)) = affineNative (2^(12+1) ^^^ 2991) := by decide +kernel

theorem selectedBound5120 : packedSelected [0,1,4,7,13,15,16,19,20,21,22] rootPS < 2^1333 := by decide +kernel

def env5121 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1693,2991,1692,2982,2861,1693,2729,524288,2982,1692,4194304,925,139,4197164,277,4196385,1044,1044,2691,1672,4294967296,904,4295493282,1693,4194827]

theorem envBound5121 : H12AffineFastState.Bounded env5121 := by
  intro p hp
  have h : env5121.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5120_5121 : H12AffineEnvironment.transform 12 2991 env5120 = env5121 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2991 env5120 == env5121) = true)

theorem identity5121 : scanCanonicalize (H12AffineFastState.compose env5121 (packedSelected [0,1,2,4,5,6,11,12,19] rootPS)) = affineNative (2^(21+1) ^^^ 10) := by decide +kernel

theorem selectedBound5121 : packedSelected [0,1,2,4,5,6,11,12,19] rootPS < 2^1333 := by decide +kernel

def env5122 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1693,2991,1692,2982,2861,1693,2729,524288,2982,1692,10,925,139,2854,277,2091,1044,1044,2691,1672,4294967296,904,4295493282,1693,513]

theorem envBound5122 : H12AffineFastState.Bounded env5122 := by
  intro p hp
  have h : env5122.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5121_5122 : H12AffineEnvironment.transform 21 10 env5121 = env5122 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10 env5121 == env5122) = true)

theorem identity5122 : scanCanonicalize (H12AffineFastState.compose env5122 (packedSelected [0,4,5,7,8,9] rootPS)) = affineNative (2^(18+1) ^^^ 1932) := by decide +kernel

theorem selectedBound5122 : packedSelected [0,4,5,7,8,9] rootPS < 2^1333 := by decide +kernel

def env5123 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1693,2991,1692,2982,2861,1693,2729,1932,2982,1692,10,925,139,2854,277,2091,1044,1044,2691,1672,4294967296,904,4294967598,1693,513]

theorem envBound5123 : H12AffineFastState.Bounded env5123 := by
  intro p hp
  have h : env5123.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5122_5123 : H12AffineEnvironment.transform 18 1932 env5122 = env5123 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1932 env5122 == env5123) = true)

theorem identity5123 : scanCanonicalize (H12AffineFastState.compose env5123 (packedSelected [0,2,4,5,6,8,11] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound5123 : packedSelected [0,2,4,5,6,8,11] rootPS < 2^1333 := by decide +kernel

def env5124 : List Nat := [2,4,8,16,32,16,128,4,512,1024,2048,1693,2731,1692,2722,2601,1693,2729,1672,2722,1692,10,665,139,2594,17,2091,1044,1044,2691,1672,4294967296,652,4294967338,1693,513]

theorem envBound5124 : H12AffineFastState.Bounded env5124 := by
  intro p hp
  have h : env5124.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5123_5124 : H12AffineEnvironment.transform 7 4 env5123 = env5124 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env5123 == env5124) = true)

theorem identity5124 : scanCanonicalize (H12AffineFastState.compose env5124 (packedSelected [2,4] rootPS)) = affineNative (2^(6+1) ^^^ 18) := by decide +kernel

theorem selectedBound5124 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env5125 : List Nat := [2,4,8,16,32,16,18,4,512,1024,2048,1551,2617,1550,2608,2601,1551,2619,1562,2608,1550,10,523,25,2594,17,2091,1044,1044,2577,1562,4294967296,542,4294967338,1551,513]

theorem envBound5125 : H12AffineFastState.Bounded env5125 := by
  intro p hp
  have h : env5125.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5124_5125 : H12AffineEnvironment.transform 6 18 env5124 = env5125 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 18 env5124 == env5125) = true)

theorem identity5125 : scanCanonicalize (H12AffineFastState.compose env5125 (packedSelected [6,7] rootPS)) = affineNative (2^(8+1) ^^^ 17) := by decide +kernel

theorem selectedBound5125 : packedSelected [6,7] rootPS < 2^1333 := by decide +kernel

def env5126 : List Nat := [2,4,8,16,32,16,18,4,17,1024,2048,1054,2088,1055,2081,2104,1054,2090,1035,2081,1055,10,26,25,2099,17,2091,1044,1044,2048,1035,4294967296,15,4294967338,1054,16]

theorem envBound5126 : H12AffineFastState.Bounded env5126 := by
  intro p hp
  have h : env5126.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5125_5126 : H12AffineEnvironment.transform 8 17 env5125 = env5126 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 17 env5125 == env5126) = true)

theorem identity5126 : scanCanonicalize (H12AffineFastState.compose env5126 (packedSelected [0,6] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound5126 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env5127 : List Nat := [2,4,3,16,32,16,18,4,17,1024,2048,1045,2083,1044,2081,2099,1045,2081,1024,2081,1044,1,17,18,2099,17,2080,1044,1044,2048,1024,4294967296,4,4294967329,1045,16]

theorem envBound5127 : H12AffineFastState.Bounded env5127 := by
  intro p hp
  have h : env5127.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5126_5127 : H12AffineEnvironment.transform 2 3 env5126 = env5127 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env5126 == env5127) = true)

theorem identity5127 : scanCanonicalize (H12AffineFastState.compose env5127 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 32) := by decide +kernel

theorem selectedBound5127 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5128 : List Nat := [2,4,3,16,32,16,18,4,17,1024,2048,1045,2083,1044,2081,2099,1045,2081,1024,2081,1044,1,17,18,2099,17,2080,1044,1044,2048,1024,32,4,1,1045,16]

theorem envBound5128 : H12AffineFastState.Bounded env5128 := by
  intro p hp
  have h : env5128.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5127_5128 : H12AffineEnvironment.transform 31 32 env5127 = env5128 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 32 env5127 == env5128) = true)

def env5129 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,71448,524288,32768,4097,4194304,5377,98304,4259841,276,4260620,1044,1044,1073741824,4116,4294967296,5396,4295536695,4096,4268681]

theorem envBound5129 : H12AffineFastState.Bounded env5129 := by
  intro p hp
  have h : env5129.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5096_5129 : H12AffineEnvironment.transform 5 17 env5096 = env5129 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env5096 == env5129) = true)

def env5130 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,4096,8192,4096,32768,65536,4096,71196,524288,32768,4097,4194304,5125,98304,4259841,16,4260360,1044,1044,1073741824,4116,4294967296,5136,4295536695,4096,4268681]

theorem envBound5130 : H12AffineFastState.Bounded env5130 := by
  intro p hp
  have h : env5130.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5129_5130 : H12AffineEnvironment.transform 7 4 env5129 = env5130 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env5129 == env5130) = true)

theorem identity5130 : scanCanonicalize (H12AffineFastState.compose env5130 (packedSelected [10,12,13,15,17,19] rootPS)) = affineNative (2^(29+1) ^^^ 4299934) := by decide +kernel

theorem selectedBound5130 : packedSelected [10,12,13,15,17,19] rootPS < 2^1333 := by decide +kernel

def env5131 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,4096,8192,4096,32768,65536,4096,71196,524288,32768,4097,4194304,5125,98304,4259841,16,4260360,1044,1044,4299934,4116,4294967296,5136,4295536695,4096,4268681]

theorem envBound5131 : H12AffineFastState.Bounded env5131 := by
  intro p hp
  have h : env5131.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5130_5131 : H12AffineEnvironment.transform 29 4299934 env5130 = env5131 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4299934 env5130 == env5131) = true)

theorem identity5131 : scanCanonicalize (H12AffineFastState.compose env5131 (packedSelected [5,12,13,15,21] rootPS)) = affineNative (2^(18+1) ^^^ 4116) := by decide +kernel

theorem selectedBound5131 : packedSelected [5,12,13,15,21] rootPS < 2^1333 := by decide +kernel

def env5132 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,4096,8192,4096,32768,65536,4096,71196,4116,32768,4097,4194304,5125,98304,4259841,16,4260360,1044,1044,4299934,4116,4294967296,5136,4295008291,4096,4268681]

theorem envBound5132 : H12AffineFastState.Bounded env5132 := by
  intro p hp
  have h : env5132.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5131_5132 : H12AffineEnvironment.transform 18 4116 env5131 = env5132 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 4116 env5131 == env5132) = true)

theorem identity5132 : scanCanonicalize (H12AffineFastState.compose env5132 (packedSelected [1,3,5,8,10,13,15] rootPS)) = affineNative (2^(21+1) ^^^ 98433) := by decide +kernel

theorem selectedBound5132 : packedSelected [1,3,5,8,10,13,15] rootPS < 2^1333 := by decide +kernel

def env5133 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,4096,8192,4096,32768,65536,4096,71196,4116,32768,4097,98433,5125,98304,32896,16,33417,1044,1044,7199,4116,4294967296,5136,4295008291,4096,41480]

theorem envBound5133 : H12AffineFastState.Bounded env5133 := by
  intro p hp
  have h : env5133.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5132_5133 : H12AffineEnvironment.transform 21 98433 env5132 = env5133 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 98433 env5132 == env5133) = true)

theorem identity5133 : scanCanonicalize (H12AffineFastState.compose env5133 (packedSelected [5,12,17,26] rootPS)) = affineNative (2^(11+1) ^^^ 1044) := by decide +kernel

theorem selectedBound5133 : packedSelected [5,12,17,26] rootPS < 2^1333 := by decide +kernel

def env5134 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,1044,8192,1044,32768,65536,1044,66056,1024,32768,1045,98433,17,98304,32896,16,33417,1044,1044,2059,1024,4294967296,4,4295008291,1044,41480]

theorem envBound5134 : H12AffineFastState.Bounded env5134 := by
  intro p hp
  have h : env5134.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5133_5134 : H12AffineEnvironment.transform 11 1044 env5133 = env5134 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1044 env5133 == env5134) = true)

theorem identity5134 : scanCanonicalize (H12AffineFastState.compose env5134 (packedSelected [10,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 8200) := by decide +kernel

theorem selectedBound5134 : packedSelected [10,12,13] rootPS < 2^1333 := by decide +kernel

def env5135 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,1044,8192,1044,8200,65536,1044,66056,1024,8200,1045,73865,17,73736,8328,16,8833,1044,1044,2059,1024,4294967296,4,4294967339,1044,512]

theorem envBound5135 : H12AffineFastState.Bounded env5135 := by
  intro p hp
  have h : env5135.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5134_5135 : H12AffineEnvironment.transform 14 8200 env5134 = env5135 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8200 env5134 == env5135) = true)

theorem identity5135 : scanCanonicalize (H12AffineFastState.compose env5135 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 65571) := by decide +kernel

theorem selectedBound5135 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env5136 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,1044,8192,1044,8200,65536,1044,66056,1024,8200,1045,73865,17,73736,8328,16,8833,1044,1044,2059,1024,65571,4,65544,1044,512]

theorem envBound5136 : H12AffineFastState.Bounded env5136 := by
  intro p hp
  have h : env5136.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5135_5136 : H12AffineEnvironment.transform 31 65571 env5135 = env5136 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65571 env5135 == env5136) = true)

theorem identity5136 : scanCanonicalize (H12AffineFastState.compose env5136 (packedSelected [1,10] rootPS)) = affineNative (2^(9+1) ^^^ 47) := by decide +kernel

theorem selectedBound5136 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env5137 : List Nat := [2,4,8,16,32,17,128,4,512,47,2048,59,8192,59,8200,65536,59,66056,47,8200,58,73865,17,73736,8328,16,8833,59,59,2059,47,65571,4,65544,59,512]

theorem envBound5137 : H12AffineFastState.Bounded env5137 := by
  intro p hp
  have h : env5137.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5136_5137 : H12AffineEnvironment.transform 9 47 env5136 = env5137 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 47 env5136 == env5137) = true)

theorem identity5137 : scanCanonicalize (H12AffineFastState.compose env5137 (packedSelected [4,9,16] rootPS)) = affineNative (2^(15+1) ^^^ 8193) := by decide +kernel

theorem selectedBound5137 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env5138 : List Nat := [2,4,8,16,32,17,128,4,512,47,2048,59,8192,59,8200,8193,59,8713,47,8200,58,136,17,9,8328,16,8833,59,59,2059,47,8226,4,8201,59,512]

theorem envBound5138 : H12AffineFastState.Bounded env5138 := by
  intro p hp
  have h : env5138.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5137_5138 : H12AffineEnvironment.transform 15 8193 env5137 = env5138 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8193 env5137 == env5138) = true)

theorem identity5138 : scanCanonicalize (H12AffineFastState.compose env5138 (packedSelected [0,7,20] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound5138 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env5139 : List Nat := [2,4,8,16,32,17,128,4,512,47,2048,59,8,59,0,9,59,513,47,0,58,136,17,9,128,16,649,59,59,2059,47,42,4,1,59,512]

theorem envBound5139 : H12AffineFastState.Bounded env5139 := by
  intro p hp
  have h : env5139.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5138_5139 : H12AffineEnvironment.transform 12 8 env5138 = env5139 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 8 env5138 == env5139) = true)

theorem identity5139 : scanCanonicalize (H12AffineFastState.compose env5139 (packedSelected [2,23,32] rootPS)) = affineNative (2^(8+1) ^^^ 163) := by decide +kernel

theorem selectedBound5139 : packedSelected [2,23,32] rootPS < 2^1333 := by decide +kernel

def env5140 : List Nat := [2,4,8,16,32,17,128,4,163,47,2048,59,8,59,0,9,59,162,47,0,58,136,17,9,128,16,42,59,59,2059,47,42,4,1,59,163]

theorem envBound5140 : H12AffineFastState.Bounded env5140 := by
  intro p hp
  have h : env5140.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5139_5140 : H12AffineEnvironment.transform 8 163 env5139 = env5140 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 163 env5139 == env5140) = true)

theorem identity5140 : scanCanonicalize (H12AffineFastState.compose env5140 (packedSelected [2,7] rootPS)) = affineNative (2^(6+1) ^^^ 58) := by decide +kernel

theorem selectedBound5140 : packedSelected [2,7] rootPS < 2^1333 := by decide +kernel

def env5141 : List Nat := [2,4,8,16,32,17,58,4,25,47,2048,59,8,59,0,9,59,24,47,0,58,50,17,9,58,16,42,59,59,2059,47,42,4,1,59,25]

theorem envBound5141 : H12AffineFastState.Bounded env5141 := by
  intro p hp
  have h : env5141.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5140_5141 : H12AffineEnvironment.transform 6 58 env5140 = env5141 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 58 env5140 == env5141) = true)

theorem identity5141 : scanCanonicalize (H12AffineFastState.compose env5141 (packedSelected [2,4,9,23] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound5141 : packedSelected [2,4,9,23] rootPS < 2^1333 := by decide +kernel

end H12GlobalChart2
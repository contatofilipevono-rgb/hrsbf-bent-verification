import H12GlobalChart2Data027

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem envTrans6849_6850 : H12AffineEnvironment.transform 15 807 env6849 = env6850 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 807 env6849 == env6850) = true)

theorem identity6850 : scanCanonicalize (H12AffineFastState.compose env6850 (packedSelected [6,25] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound6850 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env6851 : List Nat := [2,4,8,16,32,16,9,256,512,1024,2048,1296,8192,1297,11053,807,1297,2340,1025,11053,1297,8999,17,10510,8192,16,11015,1297,1297,815,1284,261,257,2831,1297,513]

theorem envBound6851 : H12AffineFastState.Bounded env6851 := by
  intro p hp
  have h : env6851.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6850_6851 : H12AffineEnvironment.transform 11 1296 env6850 = env6851 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env6850 == env6851) = true)

def env6852 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4097,41600,1025,32768,4097,4194304,5377,103444,4259840,5377,4241044,4096,4097,4294794,4116,4294967296,257,4295013430,4097,4268680]

theorem envBound6852 : H12AffineFastState.Bounded env6852 := by
  intro p hp
  have h : env6852.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6844_6852 : H12AffineEnvironment.transform 25 5377 env6844 = env6852 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5377 env6844 == env6852) = true)

theorem identity6852 : scanCanonicalize (H12AffineFastState.compose env6852 (packedSelected [1,3,8] rootPS)) = affineNative (2^(21+1) ^^^ 73864) := by decide +kernel

theorem selectedBound6852 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env6853 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4097,41600,1025,32768,4097,73864,5377,103444,8328,5377,103964,4096,4097,43010,4116,4294967296,257,4295013430,4097,512]

theorem envBound6853 : H12AffineFastState.Bounded env6853 := by
  intro p hp
  have h : env6853.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6852_6853 : H12AffineEnvironment.transform 21 73864 env6852 = env6853 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 73864 env6852 == env6853) = true)

theorem identity6853 : scanCanonicalize (H12AffineFastState.compose env6853 (packedSelected [4,9,16] rootPS)) = affineNative (2^(15+1) ^^^ 13332) := by decide +kernel

theorem selectedBound6853 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env6854 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,13332,4097,41600,1025,32768,4097,5276,5377,40960,8328,5377,41480,4096,4097,43010,4116,4294967296,257,4295013430,4097,512]

theorem envBound6854 : H12AffineFastState.Bounded env6854 := by
  intro p hp
  have h : env6854.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6853_6854 : H12AffineEnvironment.transform 15 13332 env6853 = env6854 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13332 env6853 == env6854) = true)

theorem identity6854 : scanCanonicalize (H12AffineFastState.compose env6854 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 8226) := by decide +kernel

theorem selectedBound6854 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6855 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,13332,4097,41600,1025,32768,4097,5276,5377,40960,8328,5377,41480,4096,4097,43010,4116,8226,257,37908,4097,512]

theorem envBound6855 : H12AffineFastState.Bounded env6855 := by
  intro p hp
  have h : env6855.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6854_6855 : H12AffineEnvironment.transform 31 8226 env6854 = env6855 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 8226 env6854 == env6855) = true)

theorem identity6855 : scanCanonicalize (H12AffineFastState.compose env6855 (packedSelected [0,7,20] rootPS)) = affineNative (2^(14+1) ^^^ 260) := by decide +kernel

theorem selectedBound6855 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env6856 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,260,13332,4097,9092,1025,260,4097,5276,5377,8452,8328,5377,8972,4096,4097,10502,4116,8226,257,5392,4097,512]

theorem envBound6856 : H12AffineFastState.Bounded env6856 := by
  intro p hp
  have h : env6856.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6855_6856 : H12AffineEnvironment.transform 14 260 env6855 = env6856 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 260 env6855 == env6856) = true)

theorem identity6856 : scanCanonicalize (H12AffineFastState.compose env6856 (packedSelected [9,22] rootPS)) = affineNative (2^(12+1) ^^^ 5400) := by decide +kernel

theorem selectedBound6856 : packedSelected [9,22] rootPS < 2^1333 := by decide +kernel

def env6857 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,5400,4097,260,268,4097,5788,1025,260,4097,5276,5377,5148,5520,5377,5652,4096,4097,7198,4116,5434,257,5392,4097,512]

theorem envBound6857 : H12AffineFastState.Bounded env6857 := by
  intro p hp
  have h : env6857.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6856_6857 : H12AffineEnvironment.transform 12 5400 env6856 = env6857 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5400 env6856 == env6857) = true)

theorem identity6857 : scanCanonicalize (H12AffineFastState.compose env6857 (packedSelected [1,3,10,26] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound6857 : packedSelected [1,3,10,26] rootPS < 2^1333 := by decide +kernel

def env6858 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1297,9,1296,260,268,1296,909,1025,260,1296,397,16,269,129,16,773,1297,1296,2319,1285,43,257,1,1296,512]

theorem envBound6858 : H12AffineFastState.Bounded env6858 := by
  intro p hp
  have h : env6858.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6857_6858 : H12AffineEnvironment.transform 11 1297 env6857 = env6858 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env6857 == env6858) = true)

theorem identity6858 : scanCanonicalize (H12AffineFastState.compose env6858 (packedSelected [1,10] rootPS)) = affineNative (2^(9+1) ^^^ 46) := by decide +kernel

theorem selectedBound6858 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env6859 : List Nat := [2,4,8,16,32,16,128,256,512,46,2048,319,9,318,260,268,318,909,47,260,318,397,16,269,129,16,773,319,318,2319,299,43,257,1,318,512]

theorem envBound6859 : H12AffineFastState.Bounded env6859 := by
  intro p hp
  have h : env6859.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6858_6859 : H12AffineEnvironment.transform 9 46 env6858 = env6859 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 46 env6858 == env6859) = true)

theorem identity6859 : scanCanonicalize (H12AffineFastState.compose env6859 (packedSelected [3,12] rootPS)) = affineNative (2^(7+1) ^^^ 135) := by decide +kernel

theorem selectedBound6859 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env6860 : List Nat := [2,4,8,16,32,16,128,135,512,46,2048,184,9,185,131,139,185,522,47,131,185,10,16,138,129,16,642,184,185,2184,172,43,134,1,185,512]

theorem envBound6860 : H12AffineFastState.Bounded env6860 := by
  intro p hp
  have h : env6860.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6859_6860 : H12AffineEnvironment.transform 7 135 env6859 = env6860 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 135 env6859 == env6860) = true)

theorem identity6860 : scanCanonicalize (H12AffineFastState.compose env6860 (packedSelected [1,3] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound6860 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env6861 : List Nat := [2,4,8,16,10,16,128,135,512,4,2048,146,9,147,131,139,147,522,5,131,147,10,16,138,129,16,642,146,147,2184,134,1,134,1,147,512]

theorem envBound6861 : H12AffineFastState.Bounded env6861 := by
  intro p hp
  have h : env6861.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6860_6861 : H12AffineEnvironment.transform 4 10 env6860 = env6861 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env6860 == env6861) = true)

theorem identity6861 : scanCanonicalize (H12AffineFastState.compose env6861 (packedSelected [2] rootPS)) = affineNative (2^(8+1) ^^^ 130) := by decide +kernel

theorem selectedBound6861 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6862 : List Nat := [2,4,8,16,10,16,128,135,130,4,2048,146,9,147,131,139,147,136,5,131,147,10,16,138,129,16,0,146,147,2184,134,1,134,1,147,130]

theorem envBound6862 : H12AffineFastState.Bounded env6862 := by
  intro p hp
  have h : env6862.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6861_6862 : H12AffineEnvironment.transform 8 130 env6861 = env6862 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 130 env6861 == env6862) = true)

theorem identity6862 : scanCanonicalize (H12AffineFastState.compose env6862 (packedSelected [0,4] rootPS)) = affineNative (2^(10+1) ^^^ 131) := by decide +kernel

theorem selectedBound6862 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env6863 : List Nat := [2,4,8,16,10,16,128,135,130,4,131,146,9,147,131,139,147,136,5,131,147,10,16,138,129,16,0,146,147,11,134,1,134,1,147,130]

theorem envBound6863 : H12AffineFastState.Bounded env6863 := by
  intro p hp
  have h : env6863.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6862_6863 : H12AffineEnvironment.transform 10 131 env6862 = env6863 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 131 env6862 == env6863) = true)

theorem identity6863 : scanCanonicalize (H12AffineFastState.compose env6863 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 8) := by decide +kernel

theorem selectedBound6863 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6864 : List Nat := [2,4,8,8,10,8,128,135,130,4,131,138,9,139,131,139,139,136,5,131,139,10,8,138,129,8,0,138,139,11,134,1,134,1,139,130]

theorem envBound6864 : H12AffineFastState.Bounded env6864 := by
  intro p hp
  have h : env6864.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6863_6864 : H12AffineEnvironment.transform 3 8 env6863 = env6864 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 8 env6863 == env6864) = true)

theorem identity6864 : scanCanonicalize (H12AffineFastState.compose env6864 (packedSelected [7,9] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound6864 : packedSelected [7,9] rootPS < 2^1333 := by decide +kernel

def env6865 : List Nat := [2,4,8,8,10,8,3,4,1,4,0,9,9,8,0,8,8,11,5,0,8,10,8,9,2,8,0,9,8,11,5,1,5,1,8,1]

theorem envBound6865 : H12AffineFastState.Bounded env6865 := by
  intro p hp
  have h : env6865.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6864_6865 : H12AffineEnvironment.transform 6 3 env6864 = env6865 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env6864 == env6865) = true)

theorem identity6865 : scanCanonicalize (H12AffineFastState.compose env6865 (packedSelected [7] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound6865 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env6866 : List Nat := [2,4,3,3,1,3,3,4,1,4,0,2,2,3,0,3,3,0,5,0,3,1,3,2,2,3,0,2,3,0,5,1,5,1,3,1]

theorem envBound6866 : H12AffineFastState.Bounded env6866 := by
  intro p hp
  have h : env6866.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6865_6866 : H12AffineEnvironment.transform 2 3 env6865 = env6866 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env6865 == env6866) = true)

def env6867 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,4097,41600,1025,32768,4097,4194304,5376,103445,4259840,67108864,4241045,67110144,4096,71409035,4117,4294967296,257,4362117430,4097,4268680]

theorem envBound6867 : H12AffineFastState.Bounded env6867 := by
  intro p hp
  have h : env6867.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6843_6867 : H12AffineEnvironment.transform 5 17 env6843 = env6867 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env6843 == env6867) = true)

theorem identity6867 : scanCanonicalize (H12AffineFastState.compose env6867 (packedSelected [1,3,8,17,21] rootPS)) = affineNative (2^(10+1) ^^^ 680) := by decide +kernel

theorem selectedBound6867 : packedSelected [1,3,8,17,21] rootPS < 2^1333 := by decide +kernel

def env6868 : List Nat := [2,4,8,16,32,17,128,256,512,1024,680,4096,8192,4096,32768,65536,4097,41600,1025,32768,4097,4194304,5376,103445,4259840,67108864,4241045,67110144,4096,71407395,4117,4294967296,257,4362117430,4097,4268680]

theorem envBound6868 : H12AffineFastState.Bounded env6868 := by
  intro p hp
  have h : env6868.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6867_6868 : H12AffineEnvironment.transform 10 680 env6867 = env6868 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 680 env6867 == env6868) = true)

theorem identity6868 : scanCanonicalize (H12AffineFastState.compose env6868 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(21+1) ^^^ 46103) := by decide +kernel

theorem selectedBound6868 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env6869 : List Nat := [2,4,8,16,32,17,128,256,512,1024,680,4096,8192,4096,32768,65536,4097,41600,1025,32768,4097,46103,5376,103445,111639,67108864,642,67110144,4096,67183412,4117,4294967296,257,4362117430,4097,104095]

theorem envBound6869 : H12AffineFastState.Bounded env6869 := by
  intro p hp
  have h : env6869.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6868_6869 : H12AffineEnvironment.transform 21 46103 env6868 = env6869 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 46103 env6868 == env6869) = true)

theorem identity6869 : scanCanonicalize (H12AffineFastState.compose env6869 (packedSelected [0,4,7,10,11,12,13,15,16,17,19,22,23] rootPS)) = affineNative (2^(25+1) ^^^ 98718) := by decide +kernel

theorem selectedBound6869 : packedSelected [0,4,7,10,11,12,13,15,16,17,19,22,23] rootPS < 2^1333 := by decide +kernel

def env6870 : List Nat := [2,4,8,16,32,17,128,256,512,1024,680,4096,8192,4096,32768,65536,4097,41600,1025,32768,4097,46103,5376,103445,111639,98718,642,99486,4096,41642,4117,4294967296,257,4295041192,4097,104095]

theorem envBound6870 : H12AffineFastState.Bounded env6870 := by
  intro p hp
  have h : env6870.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6869_6870 : H12AffineEnvironment.transform 25 98718 env6869 = env6870 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 98718 env6869 == env6870) = true)

theorem identity6870 : scanCanonicalize (H12AffineFastState.compose env6870 (packedSelected [0,1,3,4,5,7,8,9,12,13,15,17] rootPS)) = affineNative (2^(15+1) ^^^ 139) := by decide +kernel

theorem selectedBound6870 : packedSelected [0,1,3,4,5,7,8,9,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env6871 : List Nat := [2,4,8,16,32,17,128,256,512,1024,680,4096,8192,4096,32768,139,4097,41600,1025,32768,4097,46103,5376,38046,46236,33045,642,33813,4096,41642,4117,4294967296,257,4294975523,4097,38420]

theorem envBound6871 : H12AffineFastState.Bounded env6871 := by
  intro p hp
  have h : env6871.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6870_6871 : H12AffineEnvironment.transform 15 139 env6870 = env6871 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 139 env6870 == env6871) = true)

theorem identity6871 : scanCanonicalize (H12AffineFastState.compose env6871 (packedSelected [0,1,2,3,4,6,8,11,16,20] rootPS)) = affineNative (2^(7+1) ^^^ 14) := by decide +kernel

theorem selectedBound6871 : packedSelected [0,1,2,3,4,6,8,11,16,20] rootPS < 2^1333 := by decide +kernel

def env6872 : List Nat := [2,4,8,16,32,17,128,14,512,1024,680,4096,8192,4096,32768,139,4097,41600,1025,32768,4097,46103,5134,38046,46236,32795,642,33813,4096,41642,4117,4294967296,15,4294975523,4097,38420]

theorem envBound6872 : H12AffineFastState.Bounded env6872 := by
  intro p hp
  have h : env6872.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6871_6872 : H12AffineEnvironment.transform 7 14 env6871 = env6872 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 14 env6871 == env6872) = true)

theorem identity6872 : scanCanonicalize (H12AffineFastState.compose env6872 (packedSelected [0,4,7,8,9,10,13,15] rootPS)) = affineNative (2^(14+1) ^^^ 13340) := by decide +kernel

theorem selectedBound6872 : packedSelected [0,4,7,8,9,10,13,15] rootPS < 2^1333 := by decide +kernel

def env6873 : List Nat := [2,4,8,16,32,17,128,14,512,1024,680,4096,8192,4096,13340,139,4097,5788,1025,13340,4097,11,5134,8322,128,13319,642,12297,4096,5814,4117,4294967296,15,4294975523,4097,8712]

theorem envBound6873 : H12AffineFastState.Bounded env6873 := by
  intro p hp
  have h : env6873.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6872_6873 : H12AffineEnvironment.transform 14 13340 env6872 = env6873 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13340 env6872 == env6873) = true)

theorem identity6873 : scanCanonicalize (H12AffineFastState.compose env6873 (packedSelected [0,4,5,7,8,9] rootPS)) = affineNative (2^(12+1) ^^^ 129) := by decide +kernel

theorem selectedBound6873 : packedSelected [0,4,5,7,8,9] rootPS < 2^1333 := by decide +kernel

def env6874 : List Nat := [2,4,8,16,32,17,128,14,512,1024,680,4096,129,4096,5277,139,4097,5788,1025,5277,4097,11,5134,3,128,5254,642,4232,4096,5814,4117,4294967296,15,4294967458,4097,649]

theorem envBound6874 : H12AffineFastState.Bounded env6874 := by
  intro p hp
  have h : env6874.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6873_6874 : H12AffineEnvironment.transform 12 129 env6873 = env6874 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 129 env6873 == env6874) = true)

theorem identity6874 : scanCanonicalize (H12AffineFastState.compose env6874 (packedSelected [2,4,6,7,8,11] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound6874 : packedSelected [2,4,6,7,8,11] rootPS < 2^1333 := by decide +kernel

def env6875 : List Nat := [2,4,8,16,10,17,128,14,512,1024,642,4096,129,4096,5277,139,4097,5788,1025,5277,4097,11,5134,3,128,5254,642,4232,4096,5788,4117,4294967296,15,4294967432,4097,649]

theorem envBound6875 : H12AffineFastState.Bounded env6875 := by
  intro p hp
  have h : env6875.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6874_6875 : H12AffineEnvironment.transform 4 10 env6874 = env6875 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env6874 == env6875) = true)

theorem identity6875 : scanCanonicalize (H12AffineFastState.compose env6875 (packedSelected [0,1,3,7] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound6875 : packedSelected [0,1,3,7] rootPS < 2^1333 := by decide +kernel

def env6876 : List Nat := [2,4,8,16,10,17,9,14,512,1024,523,4096,8,4096,5140,2,4097,5653,1025,5140,4097,11,5134,3,9,5135,523,4097,4096,5653,4117,4294967296,15,4294967297,4097,512]

theorem envBound6876 : H12AffineFastState.Bounded env6876 := by
  intro p hp
  have h : env6876.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6875_6876 : H12AffineEnvironment.transform 6 9 env6875 = env6876 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env6875 == env6876) = true)

theorem identity6876 : scanCanonicalize (H12AffineFastState.compose env6876 (packedSelected [2] rootPS)) = affineNative (2^(8+1) ^^^ 0) := by decide +kernel

theorem selectedBound6876 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6877 : List Nat := [2,4,8,16,10,17,9,14,0,1024,11,4096,8,4096,5140,2,4097,5141,1025,5140,4097,11,5134,3,9,5135,11,4097,4096,5141,4117,4294967296,15,4294967297,4097,0]

theorem envBound6877 : H12AffineFastState.Bounded env6877 := by
  intro p hp
  have h : env6877.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6876_6877 : H12AffineEnvironment.transform 8 0 env6876 = env6877 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 0 env6876 == env6877) = true)

theorem identity6877 : scanCanonicalize (H12AffineFastState.compose env6877 (packedSelected [1,3] rootPS)) = affineNative (2^(11+1) ^^^ 1054) := by decide +kernel

theorem selectedBound6877 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env6878 : List Nat := [2,4,8,16,10,17,9,14,0,1024,11,1054,8,1054,10,2,1055,11,1025,10,1055,11,16,3,9,17,11,1055,1054,11,1035,4294967296,15,4294967297,1055,0]

theorem envBound6878 : H12AffineFastState.Bounded env6878 := by
  intro p hp
  have h : env6878.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6877_6878 : H12AffineEnvironment.transform 11 1054 env6877 = env6878 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1054 env6877 == env6878) = true)

theorem identity6878 : scanCanonicalize (H12AffineFastState.compose env6878 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 24) := by decide +kernel

theorem selectedBound6878 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6879 : List Nat := [2,4,8,16,10,17,9,14,0,1024,11,1054,8,1054,10,2,1055,11,1025,10,1055,11,16,3,9,17,11,1055,1054,11,1035,24,15,25,1055,0]

theorem envBound6879 : H12AffineFastState.Bounded env6879 := by
  intro p hp
  have h : env6879.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6878_6879 : H12AffineEnvironment.transform 31 24 env6878 = env6879 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 24 env6878 == env6879) = true)

def env6880 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,1025,32768,4097,4194304,5457,230469,4259841,67108864,4588613,67110225,131152,71409035,131141,4294967296,257,4362252647,131072,4268681]

theorem envBound6880 : H12AffineFastState.Bounded env6880 := by
  intro p hp
  have h : env6880.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6802_6880 : H12AffineEnvironment.transform 24 4259841 env6802 = env6880 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 4259841 env6802 == env6880) = true)

def env6881 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4096,262144,1025,32768,4097,4194304,5457,103493,4259841,67108864,4461637,67110225,4176,71409035,4165,4294967296,257,4362117479,4096,4268681]

theorem envBound6881 : H12AffineFastState.Bounded env6881 := by
  intro p hp
  have h : env6881.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6880_6881 : H12AffineEnvironment.transform 16 4096 env6880 = env6881 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env6880 == env6881) = true)

theorem identity6881 : scanCanonicalize (H12AffineFastState.compose env6881 (packedSelected [3,5,24] rootPS)) = affineNative (2^(25+1) ^^^ 4554944) := by decide +kernel

theorem selectedBound6881 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env6882 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4096,262144,1025,32768,4097,4194304,5457,103493,4259841,4554944,4461637,4556177,4176,269643,4165,4294967296,257,4299497895,4096,4268681]

theorem envBound6882 : H12AffineFastState.Bounded env6882 := by
  intro p hp
  have h : env6882.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6881_6882 : H12AffineEnvironment.transform 25 4554944 env6881 = env6882 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 4554944 env6881 == env6882) = true)

def env6883 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4096,262144,1025,32768,4097,4194304,5377,103445,4259841,4554896,4461589,4556177,4096,269595,4117,4294967296,257,4299497895,4096,4268681]

theorem envBound6883 : H12AffineFastState.Bounded env6883 := by
  intro p hp
  have h : env6883.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6882_6883 : H12AffineEnvironment.transform 5 16 env6882 = env6883 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env6882 == env6883) = true)

theorem identity6883 : scanCanonicalize (H12AffineFastState.compose env6883 (packedSelected [1,3,8,17,21] rootPS)) = affineNative (2^(17+1) ^^^ 43048) := by decide +kernel

theorem selectedBound6883 : packedSelected [1,3,8,17,21] rootPS < 2^1333 := by decide +kernel

def env6884 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4096,43048,1025,32768,4097,4194304,5377,103445,4259841,4270264,4242493,4271545,4096,46387,4117,4294967296,257,4299262351,4096,4268681]

theorem envBound6884 : H12AffineFastState.Bounded env6884 := by
  intro p hp
  have h : env6884.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6883_6884 : H12AffineEnvironment.transform 17 43048 env6883 = env6884 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43048 env6883 == env6884) = true)

theorem identity6884 : scanCanonicalize (H12AffineFastState.compose env6884 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(21+1) ^^^ 46102) := by decide +kernel

theorem selectedBound6884 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env6885 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4096,43048,1025,32768,4097,46102,5377,103445,111639,105646,2091,104879,4096,46387,4117,4294967296,257,4295048601,4096,104095]

theorem envBound6885 : H12AffineFastState.Bounded env6885 := by
  intro p hp
  have h : env6885.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6884_6885 : H12AffineEnvironment.transform 21 46102 env6884 = env6885 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 46102 env6884 == env6885) = true)

theorem identity6885 : scanCanonicalize (H12AffineFastState.compose env6885 (packedSelected [0,4,7,10,11,12,13,15,16,17,19,22,23] rootPS)) = affineNative (2^(11+1) ^^^ 3376) := by decide +kernel

theorem selectedBound6885 : packedSelected [0,4,7,10,11,12,13,15,16,17,19,22,23] rootPS < 2^1333 := by decide +kernel

def env6886 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,3376,8192,3377,32768,65536,3376,43048,1025,32768,3377,43302,2097,100645,108839,98718,2091,99487,3376,43011,3365,4294967296,257,4295041193,3376,101295]

theorem envBound6886 : H12AffineFastState.Bounded env6886 := by
  intro p hp
  have h : env6886.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6885_6886 : H12AffineEnvironment.transform 11 3376 env6885 = env6886 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 3376 env6885 == env6886) = true)

theorem identity6886 : scanCanonicalize (H12AffineFastState.compose env6886 (packedSelected [0,1,2,3,4,6,8,11,16,20] rootPS)) = affineNative (2^(14+1) ^^^ 642) := by decide +kernel

theorem selectedBound6886 : packedSelected [0,1,2,3,4,6,8,11,16,20] rootPS < 2^1333 := by decide +kernel

def env6887 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,3376,8192,3377,642,65536,3376,10922,1025,642,3377,11172,2097,68519,76709,66332,2091,67101,3376,10881,3365,4294967296,257,4295041193,3376,67885]

theorem envBound6887 : H12AffineFastState.Bounded env6887 := by
  intro p hp
  have h : env6887.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6886_6887 : H12AffineEnvironment.transform 14 642 env6886 = env6887 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 642 env6886 == env6887) = true)

theorem identity6887 : scanCanonicalize (H12AffineFastState.compose env6887 (packedSelected [2,5,6,7,8,9,10,11,12,17] rootPS)) = affineNative (2^(15+1) ^^^ 11045) := by decide +kernel

theorem selectedBound6887 : packedSelected [2,5,6,7,8,9,10,11,12,17] rootPS < 2^1333 := by decide +kernel

def env6888 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,3376,8192,3377,642,11045,3376,10922,1025,642,3377,11172,2097,8322,128,10297,2091,11576,3376,10881,3365,4294967296,257,4294970252,3376,8712]

theorem envBound6888 : H12AffineFastState.Bounded env6888 := by
  intro p hp
  have h : env6888.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6887_6888 : H12AffineEnvironment.transform 15 11045 env6887 = env6888 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 11045 env6887 == env6888) = true)

theorem identity6888 : scanCanonicalize (H12AffineFastState.compose env6888 (packedSelected [0,1,2,3,4,6,9,10,11,13,15,22] rootPS)) = affineNative (2^(10+1) ^^^ 935) := by decide +kernel

theorem selectedBound6888 : packedSelected [0,1,2,3,4,6,9,10,11,13,15,22] rootPS < 2^1333 := by decide +kernel

def env6889 : List Nat := [2,4,8,16,32,16,128,256,512,1024,935,1687,8192,1686,642,8322,1687,8461,1025,642,1686,8195,918,8322,128,9118,908,9887,1687,8486,1666,4294967296,257,4294967339,1687,8712]

theorem envBound6889 : H12AffineFastState.Bounded env6889 := by
  intro p hp
  have h : env6889.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6888_6889 : H12AffineEnvironment.transform 10 935 env6888 = env6889 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 935 env6888 == env6889) = true)

theorem identity6889 : scanCanonicalize (H12AffineFastState.compose env6889 (packedSelected [0,2,4,5,6,8,11] rootPS)) = affineNative (2^(8+1) ^^^ 1) := by decide +kernel

theorem selectedBound6889 : packedSelected [0,2,4,5,6,8,11] rootPS < 2^1333 := by decide +kernel

def env6890 : List Nat := [2,4,8,16,32,16,128,256,1,1024,422,1174,8192,1175,131,8322,1174,8461,1025,131,1175,8195,407,8322,128,8607,397,9374,1174,8486,1155,4294967296,257,4294967339,1174,8201]

theorem envBound6890 : H12AffineFastState.Bounded env6890 := by
  intro p hp
  have h : env6890.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6889_6890 : H12AffineEnvironment.transform 8 1 env6889 = env6890 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 1 env6889 == env6890) = true)

theorem identity6890 : scanCanonicalize (H12AffineFastState.compose env6890 (packedSelected [6,8,12] rootPS)) = affineNative (2^(12+1) ^^^ 1063) := by decide +kernel

theorem selectedBound6890 : packedSelected [6,8,12] rootPS < 2^1333 := by decide +kernel

def env6891 : List Nat := [2,4,8,16,32,16,128,256,1,1024,422,1174,1063,1175,131,1189,1174,1322,1025,131,1175,1060,407,1189,128,1464,397,185,1174,1281,1155,4294967296,257,4294967339,1174,1070]

theorem envBound6891 : H12AffineFastState.Bounded env6891 := by
  intro p hp
  have h : env6891.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6890_6891 : H12AffineEnvironment.transform 12 1063 env6890 = env6891 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1063 env6890 == env6891) = true)

theorem identity6891 : scanCanonicalize (H12AffineFastState.compose env6891 (packedSelected [0,2,3,4,5,6,8,13] rootPS)) = affineNative (2^(9+1) ^^^ 425) := by decide +kernel

theorem selectedBound6891 : packedSelected [0,2,3,4,5,6,8,13] rootPS < 2^1333 := by decide +kernel

def env6892 : List Nat := [2,4,8,16,32,16,128,256,1,425,422,319,398,318,131,268,319,131,424,131,318,397,407,268,128,17,397,185,319,168,298,4294967296,257,4294967339,319,391]

theorem envBound6892 : H12AffineFastState.Bounded env6892 := by
  intro p hp
  have h : env6892.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6891_6892 : H12AffineEnvironment.transform 9 425 env6891 = env6892 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 425 env6891 == env6892) = true)

theorem identity6892 : scanCanonicalize (H12AffineFastState.compose env6892 (packedSelected [0,1,2,3,4,5,6] rootPS)) = affineNative (2^(7+1) ^^^ 134) := by decide +kernel

theorem selectedBound6892 : packedSelected [0,1,2,3,4,5,6] rootPS < 2^1333 := by decide +kernel

def env6893 : List Nat := [2,4,8,16,32,16,128,134,1,47,32,185,8,184,131,138,185,131,46,131,184,11,17,138,128,17,11,185,185,168,172,4294967296,135,4294967339,185,1]

theorem envBound6893 : H12AffineFastState.Bounded env6893 := by
  intro p hp
  have h : env6893.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6892_6893 : H12AffineEnvironment.transform 7 134 env6892 = env6893 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 134 env6892 == env6893) = true)

theorem identity6893 : scanCanonicalize (H12AffineFastState.compose env6893 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 35) := by decide +kernel

theorem selectedBound6893 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6894 : List Nat := [2,4,8,16,32,16,35,37,1,47,32,26,8,27,32,41,26,32,46,32,27,11,17,41,35,17,11,26,26,11,15,4294967296,36,4294967339,26,1]

theorem envBound6894 : H12AffineFastState.Bounded env6894 := by
  intro p hp
  have h : env6894.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6893_6894 : H12AffineEnvironment.transform 6 35 env6893 = env6894 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 35 env6893 == env6894) = true)

theorem identity6894 : scanCanonicalize (H12AffineFastState.compose env6894 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 25) := by decide +kernel

theorem selectedBound6894 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6895 : List Nat := [2,4,8,16,32,16,35,37,1,47,32,26,8,27,32,41,26,32,46,32,27,11,17,41,35,17,11,26,26,11,15,25,36,50,26,1]

theorem envBound6895 : H12AffineFastState.Bounded env6895 := by
  intro p hp
  have h : env6895.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6894_6895 : H12AffineEnvironment.transform 31 25 env6894 = env6895 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 25 env6894 == env6895) = true)

theorem identity6895 : scanCanonicalize (H12AffineFastState.compose env6895 (packedSelected [2,4] rootPS)) = affineNative (2^(4+1) ^^^ 18) := by decide +kernel

theorem selectedBound6895 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env6896 : List Nat := [2,4,8,16,18,16,17,23,1,29,18,26,8,27,18,27,26,18,28,18,27,11,17,27,17,17,11,26,26,11,15,25,22,0,26,1]

theorem envBound6896 : H12AffineFastState.Bounded env6896 := by
  intro p hp
  have h : env6896.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6895_6896 : H12AffineEnvironment.transform 4 18 env6895 = env6896 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 18 env6895 == env6896) = true)

def env6897 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,262144,1025,32768,4097,4194304,5376,103444,4259841,4554897,4461588,4556177,4097,269594,4116,4294967296,257,4299497895,4096,4268681]

theorem envBound6897 : H12AffineFastState.Bounded env6897 := by
  intro p hp
  have h : env6897.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6882_6897 : H12AffineEnvironment.transform 5 17 env6882 = env6897 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env6882 == env6897) = true)

def env6898 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,262144,1025,32768,4097,365968,5376,103444,300433,5377,98692,4097,4097,269594,4116,4294967296,257,4295013431,4096,309017]

theorem envBound6898 : H12AffineFastState.Bounded env6898 := by
  intro p hp
  have h : env6898.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6897_6898 : H12AffineEnvironment.transform 21 365968 env6897 = env6898 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 365968 env6897 == env6898) = true)

theorem identity6898 : scanCanonicalize (H12AffineFastState.compose env6898 (packedSelected [1,3,8] rootPS)) = affineNative (2^(17+1) ^^^ 46361) := by decide +kernel

theorem selectedBound6898 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env6899 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,46361,1025,32768,4097,73865,5376,103444,8328,5377,98692,4097,4097,43011,4116,4294967296,257,4295013431,4096,512]

theorem envBound6899 : H12AffineFastState.Bounded env6899 := by
  intro p hp
  have h : env6899.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6898_6899 : H12AffineEnvironment.transform 17 46361 env6898 = env6899 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 46361 env6898 == env6899) = true)

theorem identity6899 : scanCanonicalize (H12AffineFastState.compose env6899 (packedSelected [4,9,16] rootPS)) = affineNative (2^(15+1) ^^^ 13333) := by decide +kernel

theorem selectedBound6899 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env6900 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,13333,4096,46361,1025,32768,4097,5276,5376,40961,8328,5377,46481,4097,4097,43011,4116,4294967296,257,4295013431,4096,512]

theorem envBound6900 : H12AffineFastState.Bounded env6900 := by
  intro p hp
  have h : env6900.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6899_6900 : H12AffineEnvironment.transform 15 13333 env6899 = env6900 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13333 env6899 == env6900) = true)

theorem identity6900 : scanCanonicalize (H12AffineFastState.compose env6900 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 8227) := by decide +kernel

theorem selectedBound6900 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6901 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,13333,4096,46361,1025,32768,4097,5276,5376,40961,8328,5377,46481,4097,4097,43011,4116,8227,257,37908,4096,512]

theorem envBound6901 : H12AffineFastState.Bounded env6901 := by
  intro p hp
  have h : env6901.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6900_6901 : H12AffineEnvironment.transform 31 8227 env6900 = env6901 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 8227 env6900 == env6901) = true)

theorem identity6901 : scanCanonicalize (H12AffineFastState.compose env6901 (packedSelected [0,7,20] rootPS)) = affineNative (2^(14+1) ^^^ 261) := by decide +kernel

theorem selectedBound6901 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env6902 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,261,13333,4096,13340,1025,261,4097,5276,5376,8452,8328,5377,13460,4097,4097,10502,4116,8227,257,5393,4096,512]

theorem envBound6902 : H12AffineFastState.Bounded env6902 := by
  intro p hp
  have h : env6902.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6901_6902 : H12AffineEnvironment.transform 14 261 env6901 = env6902 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 261 env6901 == env6902) = true)

theorem identity6902 : scanCanonicalize (H12AffineFastState.compose env6902 (packedSelected [9,22] rootPS)) = affineNative (2^(12+1) ^^^ 5401) := by decide +kernel

theorem selectedBound6902 : packedSelected [9,22] rootPS < 2^1333 := by decide +kernel

def env6903 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,5401,4096,261,268,4096,261,1025,261,4097,5276,5376,5149,5521,5377,397,4097,4097,7199,4116,5434,257,5393,4096,512]

theorem envBound6903 : H12AffineFastState.Bounded env6903 := by
  intro p hp
  have h : env6903.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6902_6903 : H12AffineEnvironment.transform 12 5401 env6902 = env6903 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5401 env6902 == env6903) = true)

theorem identity6903 : scanCanonicalize (H12AffineFastState.compose env6903 (packedSelected [1,3,10,26] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound6903 : packedSelected [1,3,10,26] rootPS < 2^1333 := by decide +kernel

def env6904 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,8,1297,261,268,1297,261,1025,261,1296,397,17,268,128,16,397,1296,1296,2318,1285,43,257,0,1297,512]

theorem envBound6904 : H12AffineFastState.Bounded env6904 := by
  intro p hp
  have h : env6904.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6903_6904 : H12AffineEnvironment.transform 11 1297 env6903 = env6904 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env6903 == env6904) = true)

theorem identity6904 : scanCanonicalize (H12AffineFastState.compose env6904 (packedSelected [7] rootPS)) = affineNative (2^(6+1) ^^^ 17) := by decide +kernel

theorem selectedBound6904 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env6905 : List Nat := [2,4,8,16,32,17,17,256,512,1024,2048,1297,8,1297,261,268,1297,261,1025,261,1296,284,17,268,17,16,284,1296,1296,2318,1285,43,257,0,1297,512]

theorem envBound6905 : H12AffineFastState.Bounded env6905 := by
  intro p hp
  have h : env6905.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6904_6905 : H12AffineEnvironment.transform 6 17 env6904 = env6905 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 17 env6904 == env6905) = true)

theorem identity6905 : scanCanonicalize (H12AffineFastState.compose env6905 (packedSelected [1,10] rootPS)) = affineNative (2^(9+1) ^^^ 47) := by decide +kernel

theorem selectedBound6905 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env6906 : List Nat := [2,4,8,16,32,17,17,256,512,47,2048,318,8,318,261,268,318,261,46,261,319,284,17,268,17,16,284,319,319,2318,298,43,257,0,318,512]

theorem envBound6906 : H12AffineFastState.Bounded env6906 := by
  intro p hp
  have h : env6906.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6905_6906 : H12AffineEnvironment.transform 9 47 env6905 = env6906 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 47 env6905 == env6906) = true)

theorem identity6906 : scanCanonicalize (H12AffineFastState.compose env6906 (packedSelected [3,12] rootPS)) = affineNative (2^(7+1) ^^^ 23) := by decide +kernel

theorem selectedBound6906 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env6907 : List Nat := [2,4,8,16,32,17,17,23,512,47,2048,41,8,41,18,27,41,18,46,18,40,11,17,27,17,16,11,40,40,2073,61,43,22,0,41,512]

theorem envBound6907 : H12AffineFastState.Bounded env6907 := by
  intro p hp
  have h : env6907.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6906_6907 : H12AffineEnvironment.transform 7 23 env6906 = env6907 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 23 env6906 == env6907) = true)

theorem identity6907 : scanCanonicalize (H12AffineFastState.compose env6907 (packedSelected [1,3] rootPS)) = affineNative (2^(10+1) ^^^ 11) := by decide +kernel

theorem selectedBound6907 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env6908 : List Nat := [2,4,8,16,32,17,17,23,512,47,11,41,8,41,18,27,41,18,46,18,40,11,17,27,17,16,11,40,40,18,61,43,22,0,41,512]

theorem envBound6908 : H12AffineFastState.Bounded env6908 := by
  intro p hp
  have h : env6908.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6907_6908 : H12AffineEnvironment.transform 10 11 env6907 = env6908 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 11 env6907 == env6908) = true)

theorem identity6908 : scanCanonicalize (H12AffineFastState.compose env6908 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 18) := by decide +kernel

theorem selectedBound6908 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6909 : List Nat := [2,4,8,16,18,17,17,23,512,29,11,27,8,27,18,27,27,18,28,18,26,11,17,27,17,16,11,26,26,18,15,25,22,0,27,512]

theorem envBound6909 : H12AffineFastState.Bounded env6909 := by
  intro p hp
  have h : env6909.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6908_6909 : H12AffineEnvironment.transform 4 18 env6908 = env6909 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 18 env6908 == env6909) = true)

theorem identity6909 : scanCanonicalize (H12AffineFastState.compose env6909 (packedSelected [4] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound6909 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env6910 : List Nat := [2,4,2,16,18,17,17,23,512,23,1,17,2,17,18,17,17,18,22,18,16,1,17,17,17,16,1,16,16,18,5,19,22,0,17,512]

theorem envBound6910 : H12AffineFastState.Bounded env6910 := by
  intro p hp
  have h : env6910.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6909_6910 : H12AffineEnvironment.transform 2 2 env6909 = env6910 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env6909 == env6910) = true)

theorem identity6910 : scanCanonicalize (H12AffineFastState.compose env6910 (packedSelected [2] rootPS)) = affineNative (2^(8+1) ^^^ 0) := by decide +kernel

theorem selectedBound6910 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6911 : List Nat := [2,4,2,16,18,17,17,23,0,23,1,17,2,17,18,17,17,18,22,18,16,1,17,17,17,16,1,16,16,18,5,19,22,0,17,0]

theorem envBound6911 : H12AffineFastState.Bounded env6911 := by
  intro p hp
  have h : env6911.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6910_6911 : H12AffineEnvironment.transform 8 0 env6910 = env6911 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 0 env6910 == env6911) = true)

theorem identity6911 : scanCanonicalize (H12AffineFastState.compose env6911 (packedSelected [9] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound6911 : packedSelected [9] rootPS < 2^1333 := by decide +kernel

def env6912 : List Nat := [2,4,2,3,1,2,2,4,0,4,1,2,2,2,1,2,2,1,5,1,3,1,2,2,2,3,1,3,3,1,5,0,5,0,2,0]

theorem envBound6912 : H12AffineFastState.Bounded env6912 := by
  intro p hp
  have h : env6912.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6911_6912 : H12AffineEnvironment.transform 3 3 env6911 = env6912 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env6911 == env6912) = true)

def leafEnv6912 : List Nat := [2,4,2,3,1,2,2,4,0,4,1,2,2,2,1,2,2,1,5,1,3,1,2,2,4,2,1,3,1,3,3,1,5,0,5,0,5,2,2,0,0,3,1]

def active6912 : List Nat := [0,1]

def tree6912 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6912 : H12WitnessSearch.Good tree6912 := H12GlobalWitnessIndex.good

theorem leafIdentity6912 : H12AffineFastState.composeSystem env6912 rootObs = leafEnv6912 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6912 rootObs == leafEnv6912) = true)

theorem terminalChecked6912 : H12PackedTerminal.terminalCheckFast leafEnv6912 active6912 tree6912 = true := by decide +kernel

def env6913 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,262144,1025,32768,4097,365969,5376,103444,300432,5376,98693,4096,4097,269594,4116,4294967296,257,4295013430,4096,309016]

theorem envBound6913 : H12AffineFastState.Bounded env6913 := by
  intro p hp
  have h : env6913.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6897_6913 : H12AffineEnvironment.transform 21 365969 env6897 = env6913 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 365969 env6897 == env6913) = true)

theorem identity6913 : scanCanonicalize (H12AffineFastState.compose env6913 (packedSelected [1,3,8] rootPS)) = affineNative (2^(17+1) ^^^ 2340) := by decide +kernel

theorem selectedBound6913 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env6914 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,2340,1025,32768,4097,105653,5376,103444,40116,5376,98693,4096,4097,5182,4116,4294967296,257,4295013430,4096,48700]

theorem envBound6914 : H12AffineFastState.Bounded env6914 := by
  intro p hp
  have h : env6914.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6913_6914 : H12AffineEnvironment.transform 17 2340 env6913 = env6914 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2340 env6913 == env6914) = true)

theorem identity6914 : scanCanonicalize (H12AffineFastState.compose env6914 (packedSelected [13,17] rootPS)) = affineNative (2^(31+1) ^^^ 5140) := by decide +kernel

theorem selectedBound6914 : packedSelected [13,17] rootPS < 2^1333 := by decide +kernel

def env6915 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,4096,2340,1025,32768,4097,105653,5376,103444,40116,5376,98693,4096,4097,5182,4116,5140,257,40994,4096,48700]

theorem envBound6915 : H12AffineFastState.Bounded env6915 := by
  intro p hp
  have h : env6915.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6914_6915 : H12AffineEnvironment.transform 31 5140 env6914 = env6915 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 5140 env6914 == env6915) = true)

theorem identity6915 : scanCanonicalize (H12AffineFastState.compose env6915 (packedSelected [5,10,19] rootPS)) = affineNative (2^(14+1) ^^^ 10541) := by decide +kernel

theorem selectedBound6915 : packedSelected [5,10,19] rootPS < 2^1333 := by decide +kernel

def env6916 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,10541,65536,4096,2340,1025,10541,4097,79256,5376,81209,13721,5376,75944,4096,4097,5182,4116,5140,257,2319,4096,5905]

theorem envBound6916 : H12AffineFastState.Bounded env6916 := by
  intro p hp
  have h : env6916.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6915_6916 : H12AffineEnvironment.transform 14 10541 env6915 = env6916 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 10541 env6915 == env6916) = true)

theorem identity6916 : scanCanonicalize (H12AffineFastState.compose env6916 (packedSelected [5,10,13,15] rootPS)) = affineNative (2^(11+1) ^^^ 1433) := by decide +kernel

theorem selectedBound6916 : packedSelected [5,10,13,15] rootPS < 2^1333 := by decide +kernel

def env6917 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1433,8192,1433,10541,65536,1433,2340,1025,10541,1432,73729,153,75936,8192,153,75944,1433,1432,423,1421,397,257,2319,1433,648]

theorem envBound6917 : H12AffineFastState.Bounded env6917 := by
  intro p hp
  have h : env6917.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6916_6917 : H12AffineEnvironment.transform 11 1433 env6916 = env6917 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1433 env6916 == env6917) = true)

theorem identity6917 : scanCanonicalize (H12AffineFastState.compose env6917 (packedSelected [0,1,3,4,5,7,16,20,22] rootPS)) = affineNative (2^(15+1) ^^^ 295) := by decide +kernel

theorem selectedBound6917 : packedSelected [0,1,3,4,5,7,16,20,22] rootPS < 2^1333 := by decide +kernel

def env6918 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1433,8192,1433,10541,295,1433,2340,1025,10541,1432,8486,153,10631,8192,153,10639,1433,1432,423,1421,397,257,2319,1433,648]

theorem envBound6918 : H12AffineFastState.Bounded env6918 := by
  intro p hp
  have h : env6918.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6917_6918 : H12AffineEnvironment.transform 15 295 env6917 = env6918 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 295 env6917 == env6918) = true)

theorem identity6918 : scanCanonicalize (H12AffineFastState.compose env6918 (packedSelected [6,25] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound6918 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env6919 : List Nat := [2,4,8,16,32,17,9,256,512,1024,2048,1296,8192,1296,10541,295,1296,2340,1025,10541,1297,8486,16,10510,8192,16,10502,1296,1297,302,1284,260,257,2319,1296,513]

theorem envBound6919 : H12AffineFastState.Bounded env6919 := by
  intro p hp
  have h : env6919.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6918_6919 : H12AffineEnvironment.transform 6 9 env6918 = env6919 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env6918 == env6919) = true)

def env6920 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,1025,32768,4097,4194304,5457,103492,4259841,67108864,4461636,67110225,4177,71409035,4164,4294967296,257,4362117478,4097,4268681]

theorem envBound6920 : H12AffineFastState.Bounded env6920 := by
  intro p hp
  have h : env6920.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6880_6920 : H12AffineEnvironment.transform 16 4097 env6880 = env6920 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env6880 == env6920) = true)

theorem identity6920 : scanCanonicalize (H12AffineFastState.compose env6920 (packedSelected [3,5,24] rootPS)) = affineNative (2^(25+1) ^^^ 303808) := by decide +kernel

theorem selectedBound6920 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env6921 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,4097,262144,1025,32768,4097,4194304,5457,103492,4259841,303808,4461636,305041,4177,4538187,4164,4294967296,257,4295230374,4097,4268681]

theorem envBound6921 : H12AffineFastState.Bounded env6921 := by
  intro p hp
  have h : env6921.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6920_6921 : H12AffineEnvironment.transform 25 303808 env6920 = env6921 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 303808 env6920 == env6921) = true)

def env6922 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4097,262144,1025,32768,4097,4194304,5377,103444,4259841,303760,4461588,305041,4097,4538139,4116,4294967296,257,4295230374,4097,4268681]

theorem envBound6922 : H12AffineFastState.Bounded env6922 := by
  intro p hp
  have h : env6922.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6921_6922 : H12AffineEnvironment.transform 5 16 env6921 = env6922 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env6921 == env6922) = true)

def env6923 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4097,46992,1025,32768,4097,4194304,5377,103444,4259841,5376,4236164,4097,4097,4294795,4116,4294967296,257,4295013430,4097,4268681]

theorem envBound6923 : H12AffineFastState.Bounded env6923 := by
  intro p hp
  have h : env6923.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6922_6923 : H12AffineEnvironment.transform 17 46992 env6922 = env6923 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 46992 env6922 == env6923) = true)

theorem identity6923 : scanCanonicalize (H12AffineFastState.compose env6923 (packedSelected [1,3,8] rootPS)) = affineNative (2^(14+1) ^^^ 16052) := by decide +kernel

theorem selectedBound6923 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env6924 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,16052,65536,4097,2340,1025,16052,4097,4194304,5377,76448,4259841,5376,4201776,4097,4097,4273727,4116,4294967296,257,4294969986,4097,4268681]

theorem envBound6924 : H12AffineFastState.Bounded env6924 := by
  intro p hp
  have h : env6924.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6923_6924 : H12AffineEnvironment.transform 14 16052 env6923 = env6924 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 16052 env6923 == env6924) = true)

theorem identity6924 : scanCanonicalize (H12AffineFastState.compose env6924 (packedSelected [13,17] rootPS)) = affineNative (2^(31+1) ^^^ 5141) := by decide +kernel

theorem selectedBound6924 : packedSelected [13,17] rootPS < 2^1333 := by decide +kernel

def env6925 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,16052,65536,4097,2340,1025,16052,4097,4194304,5377,76448,4259841,5376,4201776,4097,4097,4273727,4116,5141,257,7831,4097,4268681]

theorem envBound6925 : H12AffineFastState.Bounded env6925 := by
  intro p hp
  have h : env6925.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6924_6925 : H12AffineEnvironment.transform 31 5141 env6924 = env6925 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 5141 env6924 == env6925) = true)

theorem identity6925 : scanCanonicalize (H12AffineFastState.compose env6925 (packedSelected [5,10,19] rootPS)) = affineNative (2^(21+1) ^^^ 79256) := by decide +kernel

theorem selectedBound6925 : packedSelected [5,10,19] rootPS < 2^1333 := by decide +kernel

def env6926 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,16052,65536,4097,2340,1025,16052,4097,79256,5377,76448,13721,5376,75944,4097,4097,935,4116,5141,257,7831,4097,5905]

theorem envBound6926 : H12AffineFastState.Bounded env6926 := by
  intro p hp
  have h : env6926.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6925_6926 : H12AffineEnvironment.transform 21 79256 env6925 = env6926 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 79256 env6925 == env6926) = true)

theorem identity6926 : scanCanonicalize (H12AffineFastState.compose env6926 (packedSelected [5,10,13,15] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound6926 : packedSelected [5,10,13,15] rootPS < 2^1333 := by decide +kernel

def env6927 : List Nat := [2,4,8,16,32,16,9,256,512,1024,2048,4096,8192,4097,15933,65536,4097,2340,1025,15933,4097,79121,5377,76329,13584,5376,75809,4097,4097,814,4116,5141,257,7710,4097,5905]

theorem envBound6927 : H12AffineFastState.Bounded env6927 := by
  intro p hp
  have h : env6927.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6926_6927 : H12AffineEnvironment.transform 6 9 env6926 = env6927 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env6926 == env6927) = true)

theorem identity6927 : scanCanonicalize (H12AffineFastState.compose env6927 (packedSelected [0,1,3,4,5,7,16,20,22] rootPS)) = affineNative (2^(15+1) ^^^ 5687) := by decide +kernel

theorem selectedBound6927 : packedSelected [0,1,3,4,5,7,16,20,22] rootPS < 2^1333 := by decide +kernel

def env6928 : List Nat := [2,4,8,16,32,16,9,256,512,1024,2048,4096,8192,4097,15933,5687,4097,2340,1025,15933,4097,8998,5377,15390,13584,5376,15894,4097,4097,814,4116,5141,257,7710,4097,5905]

theorem envBound6928 : H12AffineFastState.Bounded env6928 := by
  intro p hp
  have h : env6928.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6927_6928 : H12AffineEnvironment.transform 15 5687 env6927 = env6928 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 5687 env6927 == env6928) = true)

theorem identity6928 : scanCanonicalize (H12AffineFastState.compose env6928 (packedSelected [6,25] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound6928 : packedSelected [6,25] rootPS < 2^1333 := by decide +kernel

def env6929 : List Nat := [2,4,8,16,32,16,9,256,512,1024,2048,1296,8192,1297,11053,807,1297,2340,1025,11053,1297,8998,17,10510,8192,16,11014,1297,1297,814,1284,261,257,2830,1297,513]

theorem envBound6929 : H12AffineFastState.Bounded env6929 := by
  intro p hp
  have h : env6929.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6928_6929 : H12AffineEnvironment.transform 11 1296 env6928 = env6929 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env6928 == env6929) = true)

def env6930 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4097,46993,1025,32768,4097,4194304,5377,103444,4259841,5377,4236165,4096,4097,4294794,4116,4294967296,257,4295013431,4097,4268681]

theorem envBound6930 : H12AffineFastState.Bounded env6930 := by
  intro p hp
  have h : env6930.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6922_6930 : H12AffineEnvironment.transform 17 46993 env6922 = env6930 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 46993 env6922 == env6930) = true)

theorem identity6930 : scanCanonicalize (H12AffineFastState.compose env6930 (packedSelected [1,3,8] rootPS)) = affineNative (2^(21+1) ^^^ 73865) := by decide +kernel

theorem selectedBound6930 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env6931 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,4097,46993,1025,32768,4097,73865,5377,103444,8328,5377,99084,4096,4097,43011,4116,4294967296,257,4295013431,4097,512]

theorem envBound6931 : H12AffineFastState.Bounded env6931 := by
  intro p hp
  have h : env6931.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6930_6931 : H12AffineEnvironment.transform 21 73865 env6930 = env6931 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 73865 env6930 == env6931) = true)

theorem identity6931 : scanCanonicalize (H12AffineFastState.compose env6931 (packedSelected [4,9,16] rootPS)) = affineNative (2^(15+1) ^^^ 13333) := by decide +kernel

theorem selectedBound6931 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env6932 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,13333,4097,46993,1025,32768,4097,5276,5377,40961,8328,5377,46873,4096,4097,43011,4116,4294967296,257,4295013431,4097,512]

theorem envBound6932 : H12AffineFastState.Bounded env6932 := by
  intro p hp
  have h : env6932.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6931_6932 : H12AffineEnvironment.transform 15 13333 env6931 = env6932 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13333 env6931 == env6932) = true)

theorem identity6932 : scanCanonicalize (H12AffineFastState.compose env6932 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 8227) := by decide +kernel

theorem selectedBound6932 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6933 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,13333,4097,46993,1025,32768,4097,5276,5377,40961,8328,5377,46873,4096,4097,43011,4116,8227,257,37908,4097,512]

theorem envBound6933 : H12AffineFastState.Bounded env6933 := by
  intro p hp
  have h : env6933.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6932_6933 : H12AffineEnvironment.transform 31 8227 env6932 = env6933 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 8227 env6932 == env6933) = true)

theorem identity6933 : scanCanonicalize (H12AffineFastState.compose env6933 (packedSelected [0,7,20] rootPS)) = affineNative (2^(14+1) ^^^ 260) := by decide +kernel

theorem selectedBound6933 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env6934 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,260,13333,4097,13973,1025,260,4097,5276,5377,8453,8328,5377,13853,4096,4097,10503,4116,8227,257,5392,4097,512]

theorem envBound6934 : H12AffineFastState.Bounded env6934 := by
  intro p hp
  have h : env6934.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6933_6934 : H12AffineEnvironment.transform 14 260 env6933 = env6934 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 260 env6933 == env6934) = true)

theorem identity6934 : scanCanonicalize (H12AffineFastState.compose env6934 (packedSelected [9,22] rootPS)) = affineNative (2^(12+1) ^^^ 5400) := by decide +kernel

theorem selectedBound6934 : packedSelected [9,22] rootPS < 2^1333 := by decide +kernel

def env6935 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,5400,4097,260,269,4097,909,1025,260,4097,5276,5377,5149,5520,5377,773,4096,4097,7199,4116,5435,257,5392,4097,512]

theorem envBound6935 : H12AffineFastState.Bounded env6935 := by
  intro p hp
  have h : env6935.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6934_6935 : H12AffineEnvironment.transform 12 5400 env6934 = env6935 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5400 env6934 == env6935) = true)

theorem identity6935 : scanCanonicalize (H12AffineFastState.compose env6935 (packedSelected [1,3,10,26] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound6935 : packedSelected [1,3,10,26] rootPS < 2^1333 := by decide +kernel

def env6936 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1297,9,1296,260,269,1296,909,1025,260,1296,397,16,268,129,16,773,1297,1296,2318,1285,42,257,1,1296,512]

theorem envBound6936 : H12AffineFastState.Bounded env6936 := by
  intro p hp
  have h : env6936.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6935_6936 : H12AffineEnvironment.transform 11 1297 env6935 = env6936 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env6935 == env6936) = true)

theorem identity6936 : scanCanonicalize (H12AffineFastState.compose env6936 (packedSelected [1,10] rootPS)) = affineNative (2^(9+1) ^^^ 47) := by decide +kernel

theorem selectedBound6936 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env6937 : List Nat := [2,4,8,16,32,16,128,256,512,47,2048,318,9,319,260,269,319,909,46,260,319,397,16,268,129,16,773,318,319,2318,298,42,257,1,319,512]

theorem envBound6937 : H12AffineFastState.Bounded env6937 := by
  intro p hp
  have h : env6937.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6936_6937 : H12AffineEnvironment.transform 9 47 env6936 = env6937 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 47 env6936 == env6937) = true)

theorem identity6937 : scanCanonicalize (H12AffineFastState.compose env6937 (packedSelected [3,12] rootPS)) = affineNative (2^(7+1) ^^^ 134) := by decide +kernel

theorem selectedBound6937 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env6938 : List Nat := [2,4,8,16,32,16,128,134,512,47,2048,184,9,185,130,139,185,523,46,130,185,11,16,138,129,16,643,184,185,2184,172,42,135,1,185,512]

theorem envBound6938 : H12AffineFastState.Bounded env6938 := by
  intro p hp
  have h : env6938.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6937_6938 : H12AffineEnvironment.transform 7 134 env6937 = env6938 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 134 env6937 == env6938) = true)

theorem identity6938 : scanCanonicalize (H12AffineFastState.compose env6938 (packedSelected [1,3] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound6938 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env6939 : List Nat := [2,4,8,16,11,16,128,134,512,4,2048,147,9,146,130,139,146,523,5,130,146,11,16,138,129,16,643,147,146,2184,135,1,135,1,146,512]

theorem envBound6939 : H12AffineFastState.Bounded env6939 := by
  intro p hp
  have h : env6939.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6938_6939 : H12AffineEnvironment.transform 4 11 env6938 = env6939 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env6938 == env6939) = true)

theorem identity6939 : scanCanonicalize (H12AffineFastState.compose env6939 (packedSelected [2] rootPS)) = affineNative (2^(8+1) ^^^ 131) := by decide +kernel

theorem selectedBound6939 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6940 : List Nat := [2,4,8,16,11,16,128,134,131,4,2048,147,9,146,130,139,146,136,5,130,146,11,16,138,129,16,0,147,146,2184,135,1,135,1,146,131]

theorem envBound6940 : H12AffineFastState.Bounded env6940 := by
  intro p hp
  have h : env6940.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6939_6940 : H12AffineEnvironment.transform 8 131 env6939 = env6940 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 131 env6939 == env6940) = true)

theorem identity6940 : scanCanonicalize (H12AffineFastState.compose env6940 (packedSelected [0,4] rootPS)) = affineNative (2^(10+1) ^^^ 131) := by decide +kernel

theorem selectedBound6940 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env6941 : List Nat := [2,4,8,16,11,16,128,134,131,4,131,147,9,146,130,139,146,136,5,130,146,11,16,138,129,16,0,147,146,11,135,1,135,1,146,131]

theorem envBound6941 : H12AffineFastState.Bounded env6941 := by
  intro p hp
  have h : env6941.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6940_6941 : H12AffineEnvironment.transform 10 131 env6940 = env6941 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 131 env6940 == env6941) = true)

theorem identity6941 : scanCanonicalize (H12AffineFastState.compose env6941 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 16) := by decide +kernel

theorem selectedBound6941 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6942 : List Nat := [2,4,8,16,11,16,16,22,19,4,19,3,9,2,18,27,2,24,5,18,2,11,16,26,17,16,0,3,2,11,23,1,23,1,2,19]

theorem envBound6942 : H12AffineFastState.Bounded env6942 := by
  intro p hp
  have h : env6942.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6941_6942 : H12AffineEnvironment.transform 6 16 env6941 = env6942 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 16 env6941 == env6942) = true)

theorem identity6942 : scanCanonicalize (H12AffineFastState.compose env6942 (packedSelected [7,9] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound6942 : packedSelected [7,9] rootPS < 2^1333 := by decide +kernel

def env6943 : List Nat := [2,4,8,3,11,3,3,5,0,4,0,3,9,2,1,8,2,11,5,1,2,11,3,9,2,3,0,3,2,11,4,1,4,1,2,0]

theorem envBound6943 : H12AffineFastState.Bounded env6943 := by
  intro p hp
  have h : env6943.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6942_6943 : H12AffineEnvironment.transform 3 3 env6942 = env6943 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env6942 == env6943) = true)

theorem identity6943 : scanCanonicalize (H12AffineFastState.compose env6943 (packedSelected [7] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound6943 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env6944 : List Nat := [2,4,3,3,0,3,3,5,0,4,0,3,2,2,1,3,2,0,5,1,2,0,3,2,2,3,0,3,2,0,4,1,4,1,2,0]

theorem envBound6944 : H12AffineFastState.Bounded env6944 := by
  intro p hp
  have h : env6944.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6943_6944 : H12AffineEnvironment.transform 2 3 env6943 = env6944 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env6943 == env6944) = true)

def env6945 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,4097,262144,1025,32768,4097,4194304,5376,103445,4259841,303761,4461589,305041,4096,4538138,4117,4294967296,257,4295230374,4097,4268681]

theorem envBound6945 : H12AffineFastState.Bounded env6945 := by
  intro p hp
  have h : env6945.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6921_6945 : H12AffineEnvironment.transform 5 17 env6921 = env6945 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env6921 == env6945) = true)

theorem identity6945 : scanCanonicalize (H12AffineFastState.compose env6945 (packedSelected [1,3,8,17,21] rootPS)) = affineNative (2^(17+1) ^^^ 43048) := by decide +kernel

theorem selectedBound6945 : packedSelected [1,3,8,17,21] rootPS < 2^1333 := by decide +kernel

def env6946 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,4097,43048,1025,32768,4097,4194304,5376,103445,4259841,2745,4242493,4025,4096,4298546,4117,4294967296,257,4295011214,4097,4268681]

theorem envBound6946 : H12AffineFastState.Bounded env6946 := by
  intro p hp
  have h : env6946.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6945_6946 : H12AffineEnvironment.transform 17 43048 env6945 = env6946 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43048 env6945 == env6946) = true)

theorem identity6946 : scanCanonicalize (H12AffineFastState.compose env6946 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(21+1) ^^^ 46102) := by decide +kernel

theorem selectedBound6946 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env6947 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,4097,43048,1025,32768,4097,46102,5376,103445,111639,2745,2091,4025,4096,74532,4117,4294967296,257,4295011214,4097,104095]

theorem envBound6947 : H12AffineFastState.Bounded env6947 := by
  intro p hp
  have h : env6947.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6946_6947 : H12AffineEnvironment.transform 21 46102 env6946 = env6947 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 46102 env6946 == env6947) = true)

theorem identity6947 : scanCanonicalize (H12AffineFastState.compose env6947 (packedSelected [0,4,7,10,11,12,13,15,16,17,19,22,23] rootPS)) = affineNative (2^(15+1) ^^^ 35623) := by decide +kernel

theorem selectedBound6947 : packedSelected [0,4,7,10,11,12,13,15,16,17,19,22,23] rootPS < 2^1333 := by decide +kernel

def env6948 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,35623,4097,43048,1025,32768,4097,46102,5376,7986,16176,2745,2091,4025,4096,43011,4117,4294967296,257,4295011214,4097,7608]

theorem envBound6948 : H12AffineFastState.Bounded env6948 := by
  intro p hp
  have h : env6948.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6947_6948 : H12AffineEnvironment.transform 15 35623 env6947 = env6948 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 35623 env6947 == env6948) = true)

theorem identity6948 : scanCanonicalize (H12AffineFastState.compose env6948 (packedSelected [0,4,7,9,11,16,18] rootPS)) = affineNative (2^(14+1) ^^^ 2988) := by decide +kernel

theorem selectedBound6948 : packedSelected [0,4,7,9,11,16,18] rootPS < 2^1333 := by decide +kernel

def env6949 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,2988,139,4097,9092,1025,2988,4097,16314,5376,7986,16176,2745,2091,4025,4096,9135,4117,4294967296,257,4294975522,4097,7608]

theorem envBound6949 : H12AffineFastState.Bounded env6949 := by
  intro p hp
  have h : env6949.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6948_6949 : H12AffineEnvironment.transform 14 2988 env6948 = env6949 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2988 env6948 == env6949) = true)

theorem identity6949 : scanCanonicalize (H12AffineFastState.compose env6949 (packedSelected [0,1,2,3,4,6,8,11,16,20] rootPS)) = affineNative (2^(11+1) ^^^ 1054) := by decide +kernel

theorem selectedBound6949 : packedSelected [0,1,2,3,4,6,8,11,16,20] rootPS < 2^1333 := by decide +kernel

def env6950 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1054,8192,1054,2988,139,1055,9092,1025,2988,1055,11172,286,2860,11054,2745,2091,4025,1054,9135,1035,4294967296,257,4294975522,1055,2470]

theorem envBound6950 : H12AffineFastState.Bounded env6950 := by
  intro p hp
  have h : env6950.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6949_6950 : H12AffineEnvironment.transform 11 1054 env6949 = env6950 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1054 env6949 == env6950) = true)

theorem identity6950 : scanCanonicalize (H12AffineFastState.compose env6950 (packedSelected [0,4,7,8,9,10,13,15] rootPS)) = affineNative (2^(12+1) ^^^ 2990) := by decide +kernel

theorem selectedBound6950 : packedSelected [0,4,7,8,9,10,13,15] rootPS < 2^1333 := by decide +kernel

def env6951 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1054,2990,1054,2988,139,1055,2090,1025,2988,1055,10,286,2860,128,2745,2091,4025,1054,2049,1035,4294967296,257,4294970252,1055,2470]

theorem envBound6951 : H12AffineFastState.Bounded env6951 := by
  intro p hp
  have h : env6951.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6950_6951 : H12AffineEnvironment.transform 12 2990 env6950 = env6951 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2990 env6950 == env6951) = true)

theorem identity6951 : scanCanonicalize (H12AffineFastState.compose env6951 (packedSelected [0,1,3,4,5,7,9] rootPS)) = affineNative (2^(7+1) ^^^ 134) := by decide +kernel

theorem selectedBound6951 : packedSelected [0,1,3,4,5,7,9] rootPS < 2^1333 := by decide +kernel

def env6952 : List Nat := [2,4,8,16,32,17,128,134,512,1024,2048,1054,2600,1054,2602,139,1055,2090,1025,2602,1055,10,152,2730,128,2745,2091,3647,1054,2049,1035,4294967296,135,4294969866,1055,2080]

theorem envBound6952 : H12AffineFastState.Bounded env6952 := by
  intro p hp
  have h : env6952.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6951_6952 : H12AffineEnvironment.transform 7 134 env6951 = env6952 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 134 env6951 == env6952) = true)

theorem identity6952 : scanCanonicalize (H12AffineFastState.compose env6952 (packedSelected [0,2,4,5,11,12] rootPS)) = affineNative (2^(9+1) ^^^ 558) := by decide +kernel

theorem selectedBound6952 : packedSelected [0,2,4,5,11,12] rootPS < 2^1333 := by decide +kernel

def env6953 : List Nat := [2,4,8,16,32,17,128,134,512,558,2048,560,2600,560,2602,139,561,2090,559,2602,561,10,152,2730,128,2745,2091,2065,560,2049,549,4294967296,135,4294969866,561,2080]

theorem envBound6953 : H12AffineFastState.Bounded env6953 := by
  intro p hp
  have h : env6953.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6952_6953 : H12AffineEnvironment.transform 9 558 env6952 = env6953 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 558 env6952 == env6953) = true)

theorem identity6953 : scanCanonicalize (H12AffineFastState.compose env6953 (packedSelected [0,3,7,8,13] rootPS)) = affineNative (2^(10+1) ^^^ 33) := by decide +kernel

theorem selectedBound6953 : packedSelected [0,3,7,8,13] rootPS < 2^1333 := by decide +kernel

def env6954 : List Nat := [2,4,8,16,32,17,128,134,512,558,33,560,521,560,523,139,561,11,559,523,561,10,152,651,128,664,10,48,560,32,549,4294967296,135,4294967851,561,1]

theorem envBound6954 : H12AffineFastState.Bounded env6954 := by
  intro p hp
  have h : env6954.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6953_6954 : H12AffineEnvironment.transform 10 33 env6953 = env6954 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 33 env6953 == env6954) = true)

theorem identity6954 : scanCanonicalize (H12AffineFastState.compose env6954 (packedSelected [0,2,4,5,6,8] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound6954 : packedSelected [0,2,4,5,6,8] rootPS < 2^1333 := by decide +kernel

def env6955 : List Nat := [2,4,8,16,32,17,8,14,512,558,33,560,521,560,523,3,561,11,559,523,561,10,16,515,8,528,10,48,560,32,549,4294967296,15,4294967851,561,1]

theorem envBound6955 : H12AffineFastState.Bounded env6955 := by
  intro p hp
  have h : env6955.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6954_6955 : H12AffineEnvironment.transform 6 8 env6954 = env6955 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env6954 == env6955) = true)

theorem identity6955 : scanCanonicalize (H12AffineFastState.compose env6955 (packedSelected [1] rootPS)) = affineNative (2^(8+1) ^^^ 0) := by decide +kernel

theorem selectedBound6955 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6956 : List Nat := [2,4,8,16,32,17,8,14,0,46,33,48,9,48,11,3,49,11,47,11,49,10,16,3,8,16,10,48,48,32,37,4294967296,15,4294967339,49,1]

theorem envBound6956 : H12AffineFastState.Bounded env6956 := by
  intro p hp
  have h : env6956.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6955_6956 : H12AffineEnvironment.transform 8 0 env6955 = env6956 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 0 env6955 == env6956) = true)

theorem identity6956 : scanCanonicalize (H12AffineFastState.compose env6956 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 27) := by decide +kernel

theorem selectedBound6956 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6957 : List Nat := [2,4,8,16,32,17,8,14,0,46,33,48,9,48,11,3,49,11,47,11,49,10,16,3,8,16,10,48,48,32,37,27,15,48,49,1]

theorem envBound6957 : H12AffineFastState.Bounded env6957 := by
  intro p hp
  have h : env6957.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6956_6957 : H12AffineEnvironment.transform 31 27 env6956 = env6957 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 27 env6956 == env6957) = true)

theorem identity6957 : scanCanonicalize (H12AffineFastState.compose env6957 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 26) := by decide +kernel

theorem selectedBound6957 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6958 : List Nat := [2,4,8,16,26,17,8,14,0,20,27,10,9,10,11,3,11,11,21,11,11,10,16,3,8,16,10,10,10,26,31,27,15,10,11,1]

theorem envBound6958 : H12AffineFastState.Bounded env6958 := by
  intro p hp
  have h : env6958.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6957_6958 : H12AffineEnvironment.transform 4 26 env6957 = env6958 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 26 env6957 == env6958) = true)

theorem identity6958 : scanCanonicalize (H12AffineFastState.compose env6958 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 10) := by decide +kernel

theorem selectedBound6958 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6959 : List Nat := [2,4,8,10,0,11,8,14,0,14,1,10,9,10,11,3,11,11,15,11,11,10,10,3,8,10,10,10,10,0,5,1,15,10,11,1]

theorem envBound6959 : H12AffineFastState.Bounded env6959 := by
  intro p hp
  have h : env6959.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6958_6959 : H12AffineEnvironment.transform 3 10 env6958 = env6959 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 10 env6958 == env6959) = true)

theorem identity6959 : scanCanonicalize (H12AffineFastState.compose env6959 (packedSelected [5] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound6959 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env6960 : List Nat := [2,4,3,1,0,0,3,5,0,5,1,1,2,1,0,3,0,0,4,0,0,1,1,3,3,1,1,1,1,0,5,1,4,1,0,1]

theorem envBound6960 : H12AffineFastState.Bounded env6960 := by
  intro p hp
  have h : env6960.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6959_6960 : H12AffineEnvironment.transform 2 3 env6959 = env6960 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env6959 == env6960) = true)

def env6961 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,134217728,67130624,157794305,1073741824,140788817,4294967296,157663568,4417151347,131073,33563272]

theorem envBound6961 : H12AffineFastState.Bounded env6961 := by
  intro p hp
  have h : env6961.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6396_6961 : H12AffineEnvironment.transform 28 157794305 env6396 = env6961 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 28 157794305 env6396 == env6961) = true)

theorem identity6961 : scanCanonicalize (H12AffineFastState.compose env6961 (packedSelected [14] rootPS)) = affineNative (2^(26+1) ^^^ 21352529) := by decide +kernel

theorem selectedBound6961 : packedSelected [14] rootPS < 2^1333 := by decide +kernel

def env6962 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,21352529,67130624,2232400,1073741824,18977792,4294967296,2101505,4417151347,131073,33563272]

theorem envBound6962 : H12AffineFastState.Bounded env6962 := by
  intro p hp
  have h : env6962.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6961_6962 : H12AffineEnvironment.transform 26 21352529 env6961 = env6962 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 21352529 env6961 == env6962) = true)

def env6963 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17664,16777216,33554432,67108864,21352529,67130624,131152,1073741824,16876544,4294967296,257,4417151347,131073,33563272]

theorem envBound6963 : H12AffineFastState.Bounded env6963 := by
  intro p hp
  have h : env6963.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6962_6963 : H12AffineEnvironment.transform 20 4096 env6962 = env6963 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env6962 == env6963) = true)

theorem identity6963 : scanCanonicalize (H12AffineFastState.compose env6963 (packedSelected [35] rootPS)) = affineNative (2^(25+1) ^^^ 17011013) := by decide +kernel

theorem selectedBound6963 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env6964 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17664,16777216,33554432,17011013,21352529,17024069,131152,1073741824,16876544,4294967296,257,4333498422,131073,33563272]

theorem envBound6964 : H12AffineFastState.Bounded env6964 := by
  intro p hp
  have h : env6964.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6963_6964 : H12AffineEnvironment.transform 25 17011013 env6963 = env6964 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 17011013 env6963 == env6964) = true)

def env6965 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,16777216,33554432,17011013,21352529,17024069,131152,1073741824,16876544,4294967296,257,4332975158,131073,33563272]

theorem envBound6965 : H12AffineFastState.Bounded env6965 := by
  intro p hp
  have h : env6965.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6964_6965 : H12AffineEnvironment.transform 18 1024 env6964 = env6965 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env6964 == env6965) = true)

theorem identity6965 : scanCanonicalize (H12AffineFastState.compose env6965 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 21126303) := by decide +kernel

theorem selectedBound6965 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env6966 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1024,32768,4096,4194304,17664,16777216,33554432,17011013,21352529,17024069,131152,21126303,16876544,4294967296,257,4332975158,131073,33563272]

theorem envBound6966 : H12AffineFastState.Bounded env6966 := by
  intro p hp
  have h : env6966.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6965_6966 : H12AffineEnvironment.transform 29 21126303 env6965 = env6966 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 21126303 env6965 == env6966) = true)

def env6967 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1024,32768,4096,4194304,5376,16777216,33554432,17011013,21332049,17011781,131152,21105823,16876544,4294967296,257,4332954678,131073,33563272]

theorem envBound6967 : H12AffineFastState.Bounded env6967 := by
  intro p hp
  have h : env6967.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6966_6967 : H12AffineEnvironment.transform 13 4096 env6966 = env6967 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4096 env6966 == env6967) = true)

def env6968 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1024,32768,4096,4194304,5376,16777216,33554432,17010965,21331969,17011733,131072,21105823,16876544,4294967296,257,4332954678,131073,33563272]

theorem envBound6968 : H12AffineFastState.Bounded env6968 := by
  intro p hp
  have h : env6968.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6967_6968 : H12AffineEnvironment.transform 5 16 env6967 = env6968 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env6967 == env6968) = true)

theorem identity6968 : scanCanonicalize (H12AffineFastState.compose env6968 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(23+1) ^^^ 230420) := by decide +kernel

theorem selectedBound6968 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env6969 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1024,32768,4096,4194304,5376,230420,33554432,5377,4588565,4097,131072,4294795,131092,4294967296,257,4332954678,131073,33563272]

theorem envBound6969 : H12AffineFastState.Bounded env6969 := by
  intro p hp
  have h : env6969.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6968_6969 : H12AffineEnvironment.transform 23 230420 env6968 = env6969 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230420 env6968 == env6969) = true)

theorem identity6969 : scanCanonicalize (H12AffineFastState.compose env6969 (packedSelected [1,3,17,21,24,28] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound6969 : packedSelected [1,3,17,21,24,28] rootPS < 2^1333 := by decide +kernel

def env6970 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1024,32768,4096,4194304,5376,230420,8329,5377,4588565,4097,131072,4294795,131092,4294967296,257,4299392191,131073,513]

theorem envBound6970 : H12AffineFastState.Bounded env6970 := by
  intro p hp
  have h : env6970.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6969_6970 : H12AffineEnvironment.transform 24 8329 env6969 = env6970 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env6969 == env6970) = true)

theorem identity6970 : scanCanonicalize (H12AffineFastState.compose env6970 (packedSelected [13,21] rootPS)) = affineNative (2^(14+1) ^^^ 13341) := by decide +kernel

theorem selectedBound6970 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env6971 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,13341,65536,131072,262144,1024,13341,4096,4194304,5376,208905,8329,5377,4588565,4097,131072,4275350,131092,4294967296,257,4299370658,131073,513]

theorem envBound6971 : H12AffineFastState.Bounded env6971 := by
  intro p hp
  have h : env6971.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6970_6971 : H12AffineEnvironment.transform 14 13341 env6970 = env6971 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13341 env6970 == env6971) = true)

theorem identity6971 : scanCanonicalize (H12AffineFastState.compose env6971 (packedSelected [0,5,7,8,13,17,20] rootPS)) = affineNative (2^(16+1) ^^^ 1296) := by decide +kernel

theorem selectedBound6971 : packedSelected [0,5,7,8,13,17,20] rootPS < 2^1333 := by decide +kernel

def env6972 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,13341,65536,1296,262144,1024,13341,4096,4194304,5376,79129,8329,5377,4456709,4097,1296,4275350,1284,4294967296,257,4299240882,1297,513]

theorem envBound6972 : H12AffineFastState.Bounded env6972 := by
  intro p hp
  have h : env6972.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6971_6972 : H12AffineEnvironment.transform 16 1296 env6971 = env6972 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1296 env6971 == env6972) = true)

theorem identity6972 : scanCanonicalize (H12AffineFastState.compose env6972 (packedSelected [3,5,10] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound6972 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env6973 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8192,4096,13341,65536,1296,262144,1024,13341,4096,4194304,5376,79129,8329,5377,4456709,4097,1296,4275350,1284,4294967296,257,4299240882,1297,136]

theorem envBound6973 : H12AffineFastState.Bounded env6973 := by
  intro p hp
  have h : env6973.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6972_6973 : H12AffineEnvironment.transform 8 137 env6972 = env6973 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6972 == env6973) = true)

theorem identity6973 : scanCanonicalize (H12AffineFastState.compose env6973 (packedSelected [1,6,8,12] rootPS)) = affineNative (2^(21+1) ^^^ 5408) := by decide +kernel

theorem selectedBound6973 : packedSelected [1,6,8,12] rootPS < 2^1333 := by decide +kernel

def env6974 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8192,4096,13341,65536,1296,262144,1024,13341,4096,5408,5376,79129,8329,5377,267301,4097,1296,76214,1284,4294967296,257,4295041170,1297,136]

theorem envBound6974 : H12AffineFastState.Bounded env6974 := by
  intro p hp
  have h : env6974.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6973_6974 : H12AffineEnvironment.transform 21 5408 env6973 = env6974 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5408 env6973 == env6974) = true)

theorem identity6974 : scanCanonicalize (H12AffineFastState.compose env6974 (packedSelected [6,8,13] rootPS)) = affineNative (2^(15+1) ^^^ 7174) := by decide +kernel

theorem selectedBound6974 : packedSelected [6,8,13] rootPS < 2^1333 := by decide +kernel

def env6975 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8192,4096,13341,7174,1296,262144,1024,13341,4096,5408,5376,10527,8329,5377,267301,4097,1296,13744,1284,4294967296,257,4294982804,1297,136]

theorem envBound6975 : H12AffineFastState.Bounded env6975 := by
  intro p hp
  have h : env6975.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6974_6975 : H12AffineEnvironment.transform 15 7174 env6974 = env6975 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 7174 env6974 == env6975) = true)

theorem identity6975 : scanCanonicalize (H12AffineFastState.compose env6975 (packedSelected [3,5,6,15] rootPS)) = affineNative (2^(17+1) ^^^ 7220) := by decide +kernel

theorem selectedBound6975 : packedSelected [3,5,6,15] rootPS < 2^1333 := by decide +kernel

def env6976 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8192,4096,13341,7174,1296,7220,1024,13341,4096,5408,5376,10527,8329,5377,2065,4097,1296,13744,1284,4294967296,257,4294982804,1297,136]

theorem envBound6976 : H12AffineFastState.Bounded env6976 := by
  intro p hp
  have h : env6976.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6975_6976 : H12AffineEnvironment.transform 17 7220 env6975 = env6976 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 7220 env6975 == env6976) = true)

theorem identity6976 : scanCanonicalize (H12AffineFastState.compose env6976 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 5254) := by decide +kernel

theorem selectedBound6976 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6977 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,8192,4096,13341,7174,1296,7220,1024,13341,4096,5408,5376,10527,8329,5377,2065,4097,1296,13744,1284,5254,257,10258,1297,136]

theorem envBound6977 : H12AffineFastState.Bounded env6977 := by
  intro p hp
  have h : env6977.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6976_6977 : H12AffineEnvironment.transform 31 5254 env6976 = env6977 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 5254 env6976 == env6977) = true)

theorem identity6977 : scanCanonicalize (H12AffineFastState.compose env6977 (packedSelected [0,4,7,9,18,23] rootPS)) = affineNative (2^(12+1) ^^^ 2452) := by decide +kernel

theorem selectedBound6977 : packedSelected [0,4,7,9,18,23] rootPS < 2^1333 := by decide +kernel

def env6978 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,2452,4096,7561,7174,1296,7220,1024,7561,4096,5408,5376,139,2333,5377,2065,4097,1296,7204,1284,5254,257,390,1297,136]

theorem envBound6978 : H12AffineFastState.Bounded env6978 := by
  intro p hp
  have h : env6978.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6977_6978 : H12AffineEnvironment.transform 12 2452 env6977 = env6978 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2452 env6977 == env6978) = true)

def env6979 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,2452,1296,2201,2326,1296,2340,1024,2201,1296,48,16,139,2333,17,2065,1297,1296,2356,1284,406,257,390,1297,136]

theorem envBound6979 : H12AffineFastState.Bounded env6979 := by
  intro p hp
  have h : env6979.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6978_6979 : H12AffineEnvironment.transform 11 1296 env6978 = env6979 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env6978 == env6979) = true)

theorem identity6979 : scanCanonicalize (H12AffineFastState.compose env6979 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 24) := by decide +kernel

theorem selectedBound6979 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6980 : List Nat := [2,4,8,16,32,16,24,256,17,1024,2048,1296,2316,1296,2049,2326,1296,2340,1024,2049,1296,48,16,19,2333,17,2065,1297,1296,2356,1284,270,257,286,1297,16]

theorem envBound6980 : H12AffineFastState.Bounded env6980 := by
  intro p hp
  have h : env6980.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6979_6980 : H12AffineEnvironment.transform 6 24 env6979 = env6980 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 24 env6979 == env6980) = true)

theorem identity6980 : scanCanonicalize (H12AffineFastState.compose env6980 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 1) := by decide +kernel

theorem selectedBound6980 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6981 : List Nat := [2,4,8,1,32,1,9,256,0,1024,2048,1281,2316,1281,2049,2311,1281,2340,1024,2049,1281,33,1,2,2316,0,2048,1280,1281,2341,1284,270,257,271,1280,1]

theorem envBound6981 : H12AffineFastState.Bounded env6981 := by
  intro p hp
  have h : env6981.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6980_6981 : H12AffineEnvironment.transform 3 1 env6980 = env6981 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env6980 == env6981) = true)

theorem identity6981 : scanCanonicalize (H12AffineFastState.compose env6981 (packedSelected [6] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound6981 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6982 : List Nat := [2,4,8,1,32,1,9,36,0,1024,2048,1061,2088,1061,2049,2083,1061,2048,1024,2049,1061,33,1,2,2088,0,2048,1060,1061,2049,1056,42,37,43,1060,1]

theorem envBound6982 : H12AffineFastState.Bounded env6982 := by
  intro p hp
  have h : env6982.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6981_6982 : H12AffineEnvironment.transform 7 36 env6981 = env6982 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env6981 == env6982) = true)

def leafEnv6982 : List Nat := [2,4,8,1,32,1,9,36,0,1024,2048,1061,2088,1061,2049,2083,1061,2048,1024,2049,1061,33,1,2,1056,2088,1,0,2048,1060,1061,2049,1056,42,37,43,5,2082,1060,1,0,1061,1]

def active6982 : List Nat := [0,1,2,4,9,10]

def tree6982 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6982 : H12WitnessSearch.Good tree6982 := H12GlobalWitnessIndex.good

theorem leafIdentity6982 : H12AffineFastState.composeSystem env6982 rootObs = leafEnv6982 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6982 rootObs == leafEnv6982) = true)

theorem terminalChecked6982 : H12PackedTerminal.terminalCheckFast leafEnv6982 active6982 tree6982 = true := by decide +kernel

def env6983 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,2452,1297,2200,2327,1296,2341,1024,2200,1297,49,17,139,2333,16,2065,1296,1296,2357,1284,407,257,390,1297,136]

theorem envBound6983 : H12AffineFastState.Bounded env6983 := by
  intro p hp
  have h : env6983.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6978_6983 : H12AffineEnvironment.transform 11 1297 env6978 = env6983 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env6978 == env6983) = true)

theorem identity6983 : scanCanonicalize (H12AffineFastState.compose env6983 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 173) := by decide +kernel

theorem selectedBound6983 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6984 : List Nat := [2,4,8,16,32,16,128,173,137,1024,2048,1212,2105,1212,2200,2234,1213,2184,1024,2200,1212,49,17,139,2224,16,2065,1213,1213,2200,1193,58,172,43,1212,136]

theorem envBound6984 : H12AffineFastState.Bounded env6984 := by
  intro p hp
  have h : env6984.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6983_6984 : H12AffineEnvironment.transform 7 173 env6983 = env6984 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 173 env6983 == env6984) = true)

theorem identity6984 : scanCanonicalize (H12AffineFastState.compose env6984 (packedSelected [2,4] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound6984 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env6985 : List Nat := [2,4,8,0,32,0,128,173,137,1024,2048,1196,2089,1196,2184,2218,1197,2184,1024,2184,1196,33,1,139,2208,0,2049,1197,1197,2184,1193,42,172,43,1196,136]

theorem envBound6985 : H12AffineFastState.Bounded env6985 := by
  intro p hp
  have h : env6985.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6984_6985 : H12AffineEnvironment.transform 3 0 env6984 = env6985 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env6984 == env6985) = true)

theorem identity6985 : scanCanonicalize (H12AffineFastState.compose env6985 (packedSelected [6] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound6985 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6986 : List Nat := [2,4,8,0,32,0,9,36,0,1024,2048,1061,2089,1061,2049,2083,1060,2049,1024,2049,1061,33,1,2,2089,0,2049,1060,1060,2049,1056,42,37,43,1061,1]

theorem envBound6986 : H12AffineFastState.Bounded env6986 := by
  intro p hp
  have h : env6986.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6985_6986 : H12AffineEnvironment.transform 6 9 env6985 = env6986 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env6985 == env6986) = true)

def leafEnv6986 : List Nat := [2,4,8,0,32,0,9,36,0,1024,2048,1061,2089,1061,2049,2083,1060,2049,1024,2049,1061,33,1,2,1056,2089,1,0,2049,1060,1060,2049,1056,42,37,43,5,2082,1061,1,0,1060,1]

def active6986 : List Nat := [0,1,2,4,9,10]

def tree6986 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6986 : H12WitnessSearch.Good tree6986 := H12GlobalWitnessIndex.good

theorem leafIdentity6986 : H12AffineFastState.composeSystem env6986 rootObs = leafEnv6986 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6986 rootObs == leafEnv6986) = true)

theorem terminalChecked6986 : H12PackedTerminal.terminalCheckFast leafEnv6986 active6986 tree6986 = true := by decide +kernel

def env6987 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1024,32768,4096,4194304,5376,16777216,33554432,17010964,21331968,17011732,131073,21105823,16876544,4294967296,257,4332954678,131073,33563272]

theorem envBound6987 : H12AffineFastState.Bounded env6987 := by
  intro p hp
  have h : env6987.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6967_6987 : H12AffineEnvironment.transform 5 17 env6967 = env6987 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env6967 == env6987) = true)

theorem identity6987 : scanCanonicalize (H12AffineFastState.compose env6987 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(24+1) ^^^ 17015965) := by decide +kernel

theorem selectedBound6987 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env6988 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1024,32768,4096,4194304,5376,16777216,17015965,17010964,21331968,17011732,131073,21105823,16876544,4294967296,257,4315938987,131073,17008149]

theorem envBound6988 : H12AffineFastState.Bounded env6988 := by
  intro p hp
  have h : env6988.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6987_6988 : H12AffineEnvironment.transform 24 17015965 env6987 = env6988 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 17015965 env6987 == env6988) = true)

theorem identity6988 : scanCanonicalize (H12AffineFastState.compose env6988 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(23+1) ^^^ 230421) := by decide +kernel

theorem selectedBound6988 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env6989 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1024,32768,4096,4194304,5376,230421,8328,5377,4588565,4097,131073,4294794,131093,4294967296,257,4299392190,131073,512]

theorem envBound6989 : H12AffineFastState.Bounded env6989 := by
  intro p hp
  have h : env6989.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6988_6989 : H12AffineEnvironment.transform 23 230421 env6988 = env6989 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230421 env6988 == env6989) = true)

theorem identity6989 : scanCanonicalize (H12AffineFastState.compose env6989 (packedSelected [4,9,16] rootPS)) = affineNative (2^(21+1) ^^^ 396) := by decide +kernel

theorem selectedBound6989 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env6990 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,131072,262144,1024,32768,4096,396,5376,230421,8328,5377,394649,4097,131073,100614,131093,4294967296,257,4295198002,131073,512]

theorem envBound6990 : H12AffineFastState.Bounded env6990 := by
  intro p hp
  have h : env6990.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6989_6990 : H12AffineEnvironment.transform 21 396 env6989 = env6990 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 396 env6989 == env6990) = true)

theorem identity6990 : scanCanonicalize (H12AffineFastState.compose env6990 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(16+1) ^^^ 1296) := by decide +kernel

theorem selectedBound6990 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env6991 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,1296,262144,1024,32768,4096,396,5376,98565,8328,5377,262281,4097,1297,100614,1285,4294967296,257,4295065634,1297,512]

theorem envBound6991 : H12AffineFastState.Bounded env6991 := by
  intro p hp
  have h : env6991.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6990_6991 : H12AffineEnvironment.transform 16 1296 env6990 = env6991 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1296 env6990 == env6991) = true)

theorem identity6991 : scanCanonicalize (H12AffineFastState.compose env6991 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 106538) := by decide +kernel

theorem selectedBound6991 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6992 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,65536,1296,262144,1024,32768,4096,396,5376,98565,8328,5377,262281,4097,1297,100614,1285,106538,257,8200,1297,512]

theorem envBound6992 : H12AffineFastState.Bounded env6992 := by
  intro p hp
  have h : env6992.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6991_6992 : H12AffineEnvironment.transform 31 106538 env6991 = env6992 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 106538 env6991 == env6992) = true)

theorem identity6992 : scanCanonicalize (H12AffineFastState.compose env6992 (packedSelected [3,5,10] rootPS)) = affineNative (2^(15+1) ^^^ 37562) := by decide +kernel

theorem selectedBound6992 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env6993 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4096,32768,37562,1296,262144,1024,32768,4096,396,5376,5055,8328,5377,262281,4097,1297,7100,1285,12944,257,8200,1297,512]

theorem envBound6993 : H12AffineFastState.Bounded env6993 := by
  intro p hp
  have h : env6993.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6992_6993 : H12AffineEnvironment.transform 15 37562 env6992 = env6993 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 37562 env6992 == env6993) = true)

theorem identity6993 : scanCanonicalize (H12AffineFastState.compose env6993 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(11+1) ^^^ 821) := by decide +kernel

theorem selectedBound6993 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env6994 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,821,8192,821,32768,33167,1296,262144,1024,32768,821,396,1589,138,8328,1588,262281,820,1297,2185,1285,8613,257,8200,1297,512]

theorem envBound6994 : H12AffineFastState.Bounded env6994 := by
  intro p hp
  have h : env6994.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6993_6994 : H12AffineEnvironment.transform 11 821 env6993 = env6994 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 821 env6993 == env6994) = true)

theorem identity6994 : scanCanonicalize (H12AffineFastState.compose env6994 (packedSelected [5,8] rootPS)) = affineNative (2^(14+1) ^^^ 8461) := by decide +kernel

theorem selectedBound6994 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env6995 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,821,8192,821,8461,8322,1296,262144,1024,8461,821,396,1589,138,8328,1588,262281,820,1297,2185,1285,8613,257,8200,1297,512]

theorem envBound6995 : H12AffineFastState.Bounded env6995 := by
  intro p hp
  have h : env6995.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6994_6995 : H12AffineEnvironment.transform 14 8461 env6994 = env6995 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8461 env6994 == env6995) = true)

theorem identity6995 : scanCanonicalize (H12AffineFastState.compose env6995 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(17+1) ^^^ 12041) := by decide +kernel

theorem selectedBound6995 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env6996 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,821,8192,821,8461,8322,1296,12041,1024,8461,821,396,1589,138,8328,1588,12160,820,1297,2185,1285,8613,257,8200,1297,512]

theorem envBound6996 : H12AffineFastState.Bounded env6996 := by
  intro p hp
  have h : env6996.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6995_6996 : H12AffineEnvironment.transform 17 12041 env6995 = env6996 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 12041 env6995 == env6996) = true)

theorem identity6996 : scanCanonicalize (H12AffineFastState.compose env6996 (packedSelected [1,5,12] rootPS)) = affineNative (2^(10+1) ^^^ 303) := by decide +kernel

theorem selectedBound6996 : packedSelected [1,5,12] rootPS < 2^1333 := by decide +kernel

def env6997 : List Nat := [2,4,8,16,32,17,128,256,512,1024,303,821,8192,821,8461,8322,1296,9766,1024,8461,821,396,1589,138,8328,1588,9903,820,1297,422,1285,8613,257,8200,1297,512]

theorem envBound6997 : H12AffineFastState.Bounded env6997 := by
  intro p hp
  have h : env6997.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6996_6997 : H12AffineEnvironment.transform 10 303 env6996 = env6997 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 303 env6996 == env6997) = true)

theorem identity6997 : scanCanonicalize (H12AffineFastState.compose env6997 (packedSelected [0,7,20] rootPS)) = affineNative (2^(12+1) ^^^ 1580) := by decide +kernel

theorem selectedBound6997 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env6998 : List Nat := [2,4,8,16,32,17,128,256,512,1024,303,821,1580,821,1825,1710,1296,10,1024,1825,821,396,1589,138,1700,1588,131,820,1297,422,1285,1929,257,1572,1297,512]

theorem envBound6998 : H12AffineFastState.Bounded env6998 := by
  intro p hp
  have h : env6998.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6997_6998 : H12AffineEnvironment.transform 12 1580 env6997 = env6998 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1580 env6997 == env6998) = true)

theorem identity6998 : scanCanonicalize (H12AffineFastState.compose env6998 (packedSelected [0,2,4,11] rootPS)) = affineNative (2^(9+1) ^^^ 172) := by decide +kernel

theorem selectedBound6998 : packedSelected [0,2,4,11] rootPS < 2^1333 := by decide +kernel

def env6999 : List Nat := [2,4,8,16,32,17,128,256,512,172,303,821,640,821,909,514,444,10,172,909,821,396,665,138,520,664,131,820,445,422,425,805,257,648,445,512]

theorem envBound6999 : H12AffineFastState.Bounded env6999 := by
  intro p hp
  have h : env6999.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6998_6999 : H12AffineEnvironment.transform 9 172 env6998 = env6999 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 172 env6998 == env6999) = true)

theorem identity6999 : scanCanonicalize (H12AffineFastState.compose env6999 (packedSelected [1,3,5] rootPS)) = affineNative (2^(8+1) ^^^ 261) := by decide +kernel

theorem selectedBound6999 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env7000 : List Nat := [2,4,8,16,32,17,128,256,261,172,303,48,389,48,136,263,444,10,172,136,48,396,412,138,269,413,131,49,445,422,425,32,257,397,445,261]

theorem envBound7000 : H12AffineFastState.Bounded env7000 := by
  intro p hp
  have h : env7000.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6999_7000 : H12AffineEnvironment.transform 8 261 env6999 = env7000 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 261 env6999 == env7000) = true)

theorem identity7000 : scanCanonicalize (H12AffineFastState.compose env7000 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 41) := by decide +kernel

theorem selectedBound7000 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7001 : List Nat := [2,4,8,16,32,17,41,256,261,5,303,48,300,48,33,263,277,10,5,33,48,293,309,35,269,308,42,49,276,271,256,32,257,292,276,261]

theorem envBound7001 : H12AffineFastState.Bounded env7001 := by
  intro p hp
  have h : env7001.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7000_7001 : H12AffineEnvironment.transform 6 41 env7000 = env7001 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 41 env7000 == env7001) = true)

theorem identity7001 : scanCanonicalize (H12AffineFastState.compose env7001 (packedSelected [3,4] rootPS)) = affineNative (2^(4+1) ^^^ 19) := by decide +kernel

theorem selectedBound7001 : packedSelected [3,4] rootPS < 2^1333 := by decide +kernel

def env7002 : List Nat := [2,4,8,16,19,17,26,256,261,5,284,3,287,3,18,263,277,10,5,18,3,278,262,16,269,263,25,2,276,271,256,19,257,279,276,261]

theorem envBound7002 : H12AffineFastState.Bounded env7002 := by
  intro p hp
  have h : env7002.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7001_7002 : H12AffineEnvironment.transform 4 19 env7001 = env7002 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 19 env7001 == env7002) = true)

def env7003 : List Nat := [2,4,8,16,19,17,26,28,25,5,0,3,3,3,18,27,9,10,5,18,3,10,26,16,17,27,25,2,8,19,28,19,29,11,8,25]

theorem envBound7003 : H12AffineFastState.Bounded env7003 := by
  intro p hp
  have h : env7003.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7002_7003 : H12AffineEnvironment.transform 7 28 env7002 = env7003 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 28 env7002 == env7003) = true)

theorem identity7003 : scanCanonicalize (H12AffineFastState.compose env7003 (packedSelected [0] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound7003 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7004 : List Nat := [2,4,3,16,19,17,17,23,18,5,0,3,3,3,18,16,2,1,5,18,3,1,17,16,17,16,18,2,3,19,23,19,22,0,3,18]

theorem envBound7004 : H12AffineFastState.Bounded env7004 := by
  intro p hp
  have h : env7004.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7003_7004 : H12AffineEnvironment.transform 2 3 env7003 = env7004 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env7003 == env7004) = true)

theorem identity7004 : scanCanonicalize (H12AffineFastState.compose env7004 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound7004 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env7005 : List Nat := [2,4,3,3,0,2,2,4,1,5,0,3,3,3,1,3,2,1,5,1,3,1,2,3,2,3,1,2,3,0,4,0,5,0,3,1]

theorem envBound7005 : H12AffineFastState.Bounded env7005 := by
  intro p hp
  have h : env7005.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7004_7005 : H12AffineEnvironment.transform 3 3 env7004 = env7005 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env7004 == env7005) = true)

def leafEnv7005 : List Nat := [2,4,3,3,0,2,2,4,1,5,0,3,3,3,1,3,2,1,5,1,3,1,2,3,4,2,1,3,1,2,3,0,4,0,5,0,5,2,3,1,0,3,1]

def active7005 : List Nat := [0,1]

def tree7005 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7005 : H12WitnessSearch.Good tree7005 := H12GlobalWitnessIndex.good

theorem leafIdentity7005 : H12AffineFastState.composeSystem env7005 rootObs = leafEnv7005 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7005 rootObs == leafEnv7005) = true)

theorem terminalChecked7005 : H12PackedTerminal.terminalCheckFast leafEnv7005 active7005 tree7005 = true := by decide +kernel

def env7006 : List Nat := [2,4,8,16,19,17,26,29,24,5,1,3,2,3,18,26,8,10,5,18,3,11,27,16,16,26,25,2,9,18,29,19,28,10,9,24]

theorem envBound7006 : H12AffineFastState.Bounded env7006 := by
  intro p hp
  have h : env7006.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7002_7006 : H12AffineEnvironment.transform 7 29 env7002 = env7006 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 29 env7002 == env7006) = true)

theorem identity7006 : scanCanonicalize (H12AffineFastState.compose env7006 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 8) := by decide +kernel

theorem selectedBound7006 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7007 : List Nat := [2,4,8,8,11,9,2,5,0,5,1,3,2,3,10,2,8,10,5,10,3,11,3,8,8,2,1,2,9,10,5,11,4,10,9,0]

theorem envBound7007 : H12AffineFastState.Bounded env7007 := by
  intro p hp
  have h : env7007.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7006_7007 : H12AffineEnvironment.transform 3 8 env7006 = env7007 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 8 env7006 == env7007) = true)

def env7008 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1024,32768,4096,4194304,5377,16777216,33554432,17011013,21332048,17011780,131152,21105822,16876544,4294967296,257,4332954679,131073,33563272]

theorem envBound7008 : H12AffineFastState.Bounded env7008 := by
  intro p hp
  have h : env7008.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6966_7008 : H12AffineEnvironment.transform 13 4097 env6966 = env7008 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4097 env6966 == env7008) = true)

def env7009 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1024,32768,4096,4194304,5377,16777216,33554432,17010965,21331968,17011732,131072,21105822,16876544,4294967296,257,4332954679,131073,33563272]

theorem envBound7009 : H12AffineFastState.Bounded env7009 := by
  intro p hp
  have h : env7009.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7008_7009 : H12AffineEnvironment.transform 5 16 env7008 = env7009 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7008 == env7009) = true)

theorem identity7009 : scanCanonicalize (H12AffineFastState.compose env7009 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(24+1) ^^^ 17015964) := by decide +kernel

theorem selectedBound7009 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env7010 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1024,32768,4096,4194304,5377,16777216,17015964,17010965,21331968,17011732,131072,21105822,16876544,4294967296,257,4315938987,131073,17008148]

theorem envBound7010 : H12AffineFastState.Bounded env7010 := by
  intro p hp
  have h : env7010.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7009_7010 : H12AffineEnvironment.transform 24 17015964 env7009 = env7010 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 17015964 env7009 == env7010) = true)

theorem identity7010 : scanCanonicalize (H12AffineFastState.compose env7010 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(23+1) ^^^ 230420) := by decide +kernel

theorem selectedBound7010 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env7011 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1024,32768,4096,4194304,5377,230420,8328,5377,4588564,4096,131072,4294794,131092,4294967296,257,4299392191,131073,512]

theorem envBound7011 : H12AffineFastState.Bounded env7011 := by
  intro p hp
  have h : env7011.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7010_7011 : H12AffineEnvironment.transform 23 230420 env7010 = env7011 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230420 env7010 == env7011) = true)

theorem identity7011 : scanCanonicalize (H12AffineFastState.compose env7011 (packedSelected [4,9,16] rootPS)) = affineNative (2^(21+1) ^^^ 396) := by decide +kernel

theorem selectedBound7011 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env7012 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1024,32768,4096,396,5377,230420,8328,5377,394648,4096,131072,100614,131092,4294967296,257,4295198003,131073,512]

theorem envBound7012 : H12AffineFastState.Bounded env7012 := by
  intro p hp
  have h : env7012.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7011_7012 : H12AffineEnvironment.transform 21 396 env7011 = env7012 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 396 env7011 == env7012) = true)

theorem identity7012 : scanCanonicalize (H12AffineFastState.compose env7012 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(16+1) ^^^ 1297) := by decide +kernel

theorem selectedBound7012 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env7013 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,1297,262144,1024,32768,4096,396,5377,98565,8328,5377,262281,4096,1297,100614,1285,4294967296,257,4295065634,1296,512]

theorem envBound7013 : H12AffineFastState.Bounded env7013 := by
  intro p hp
  have h : env7013.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7012_7013 : H12AffineEnvironment.transform 16 1297 env7012 = env7013 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1297 env7012 == env7013) = true)

theorem identity7013 : scanCanonicalize (H12AffineFastState.compose env7013 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 106539) := by decide +kernel

theorem selectedBound7013 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7014 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,65536,1297,262144,1024,32768,4096,396,5377,98565,8328,5377,262281,4096,1297,100614,1285,106539,257,8201,1296,512]

theorem envBound7014 : H12AffineFastState.Bounded env7014 := by
  intro p hp
  have h : env7014.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7013_7014 : H12AffineEnvironment.transform 31 106539 env7013 = env7014 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 106539 env7013 == env7014) = true)

theorem identity7014 : scanCanonicalize (H12AffineFastState.compose env7014 (packedSelected [3,5,10] rootPS)) = affineNative (2^(15+1) ^^^ 37563) := by decide +kernel

theorem selectedBound7014 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env7015 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4097,32768,37563,1297,262144,1024,32768,4096,396,5377,5054,8328,5377,262281,4096,1297,7101,1285,12944,257,8201,1296,512]

theorem envBound7015 : H12AffineFastState.Bounded env7015 := by
  intro p hp
  have h : env7015.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7014_7015 : H12AffineEnvironment.transform 15 37563 env7014 = env7015 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 37563 env7014 == env7015) = true)

theorem identity7015 : scanCanonicalize (H12AffineFastState.compose env7015 (packedSelected [1,3,5,8,12,15] rootPS)) = affineNative (2^(11+1) ^^^ 820) := by decide +kernel

theorem selectedBound7015 : packedSelected [1,3,5,8,12,15] rootPS < 2^1333 := by decide +kernel

def env7016 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,820,8192,821,32768,33167,1297,262144,1024,32768,820,396,1589,138,8328,1589,262281,820,1297,2185,1285,8612,257,8201,1296,512]

theorem envBound7016 : H12AffineFastState.Bounded env7016 := by
  intro p hp
  have h : env7016.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7015_7016 : H12AffineEnvironment.transform 11 820 env7015 = env7016 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 820 env7015 == env7016) = true)

theorem identity7016 : scanCanonicalize (H12AffineFastState.compose env7016 (packedSelected [5,8] rootPS)) = affineNative (2^(14+1) ^^^ 8461) := by decide +kernel

theorem selectedBound7016 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env7017 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,820,8192,821,8461,8322,1297,262144,1024,8461,820,396,1589,138,8328,1589,262281,820,1297,2185,1285,8612,257,8201,1296,512]

theorem envBound7017 : H12AffineFastState.Bounded env7017 := by
  intro p hp
  have h : env7017.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7016_7017 : H12AffineEnvironment.transform 14 8461 env7016 = env7017 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8461 env7016 == env7017) = true)

theorem identity7017 : scanCanonicalize (H12AffineFastState.compose env7017 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(17+1) ^^^ 12040) := by decide +kernel

theorem selectedBound7017 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env7018 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,820,8192,821,8461,8322,1297,12040,1024,8461,820,396,1589,138,8328,1589,12161,820,1297,2185,1285,8612,257,8201,1296,512]

theorem envBound7018 : H12AffineFastState.Bounded env7018 := by
  intro p hp
  have h : env7018.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7017_7018 : H12AffineEnvironment.transform 17 12040 env7017 = env7018 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 12040 env7017 == env7018) = true)

theorem identity7018 : scanCanonicalize (H12AffineFastState.compose env7018 (packedSelected [1,5,12] rootPS)) = affineNative (2^(10+1) ^^^ 302) := by decide +kernel

theorem selectedBound7018 : packedSelected [1,5,12] rootPS < 2^1333 := by decide +kernel

def env7019 : List Nat := [2,4,8,16,32,16,128,256,512,1024,302,820,8192,821,8461,8322,1297,9766,1024,8461,820,396,1589,138,8328,1589,9903,820,1297,423,1285,8612,257,8201,1296,512]

theorem envBound7019 : H12AffineFastState.Bounded env7019 := by
  intro p hp
  have h : env7019.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7018_7019 : H12AffineEnvironment.transform 10 302 env7018 = env7019 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 302 env7018 == env7019) = true)

theorem identity7019 : scanCanonicalize (H12AffineFastState.compose env7019 (packedSelected [0,7,20] rootPS)) = affineNative (2^(12+1) ^^^ 1581) := by decide +kernel

theorem selectedBound7019 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env7020 : List Nat := [2,4,8,16,32,16,128,256,512,1024,302,820,1581,821,1824,1711,1297,11,1024,1824,820,396,1589,138,1701,1589,130,820,1297,423,1285,1929,257,1572,1296,512]

theorem envBound7020 : H12AffineFastState.Bounded env7020 := by
  intro p hp
  have h : env7020.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7019_7020 : H12AffineEnvironment.transform 12 1581 env7019 = env7020 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1581 env7019 == env7020) = true)

theorem identity7020 : scanCanonicalize (H12AffineFastState.compose env7020 (packedSelected [0,2,4,11] rootPS)) = affineNative (2^(9+1) ^^^ 172) := by decide +kernel

theorem selectedBound7020 : packedSelected [0,2,4,11] rootPS < 2^1333 := by decide +kernel

def env7021 : List Nat := [2,4,8,16,32,16,128,256,512,172,302,820,641,821,908,515,445,11,172,908,820,396,665,138,521,665,130,820,445,423,425,805,257,648,444,512]

theorem envBound7021 : H12AffineFastState.Bounded env7021 := by
  intro p hp
  have h : env7021.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7020_7021 : H12AffineEnvironment.transform 9 172 env7020 = env7021 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 172 env7020 == env7021) = true)

theorem identity7021 : scanCanonicalize (H12AffineFastState.compose env7021 (packedSelected [1,3,5] rootPS)) = affineNative (2^(8+1) ^^^ 261) := by decide +kernel

theorem selectedBound7021 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env7022 : List Nat := [2,4,8,16,32,16,128,256,261,172,302,49,388,48,137,262,445,11,172,137,49,396,412,138,268,412,130,49,445,423,425,32,257,397,444,261]

theorem envBound7022 : H12AffineFastState.Bounded env7022 := by
  intro p hp
  have h : env7022.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7021_7022 : H12AffineEnvironment.transform 8 261 env7021 = env7022 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 261 env7021 == env7022) = true)

theorem identity7022 : scanCanonicalize (H12AffineFastState.compose env7022 (packedSelected [2] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound7022 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env7023 : List Nat := [2,4,8,16,32,16,128,37,32,172,11,49,161,48,137,35,152,11,172,137,49,169,185,138,41,185,130,49,152,130,140,32,36,168,153,32]

theorem envBound7023 : H12AffineFastState.Bounded env7023 := by
  intro p hp
  have h : env7023.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7022_7023 : H12AffineEnvironment.transform 7 37 env7022 = env7023 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env7022 == env7023) = true)

theorem identity7023 : scanCanonicalize (H12AffineFastState.compose env7023 (packedSelected [4] rootPS)) = affineNative (2^(6+1) ^^^ 59) := by decide +kernel

theorem selectedBound7023 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env7024 : List Nat := [2,4,8,16,32,16,59,37,32,23,11,49,26,48,50,35,35,11,23,50,49,18,2,49,41,2,57,49,35,57,55,32,36,19,34,32]

theorem envBound7024 : H12AffineFastState.Bounded env7024 := by
  intro p hp
  have h : env7024.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7023_7024 : H12AffineEnvironment.transform 6 59 env7023 = env7024 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 59 env7023 == env7024) = true)

def env7025 : List Nat := [2,4,8,16,24,16,3,29,24,23,11,9,26,8,10,27,27,11,23,10,9,18,2,9,17,2,1,9,27,1,15,24,28,19,26,24]

theorem envBound7025 : H12AffineFastState.Bounded env7025 := by
  intro p hp
  have h : env7025.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7024_7025 : H12AffineEnvironment.transform 4 24 env7024 = env7025 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 24 env7024 == env7025) = true)

theorem identity7025 : scanCanonicalize (H12AffineFastState.compose env7025 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 9) := by decide +kernel

theorem selectedBound7025 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7026 : List Nat := [2,4,8,9,1,9,3,4,1,14,11,9,3,8,10,2,2,11,14,10,9,11,2,9,8,2,1,9,2,1,15,1,5,10,3,1]

theorem envBound7026 : H12AffineFastState.Bounded env7026 := by
  intro p hp
  have h : env7026.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7025_7026 : H12AffineEnvironment.transform 3 9 env7025 = env7026 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 9 env7025 == env7026) = true)

def env7027 : List Nat := [2,4,8,16,25,16,2,28,25,23,11,8,26,9,11,26,26,11,23,11,8,18,2,8,16,2,0,8,26,0,14,25,29,19,27,25]

theorem envBound7027 : H12AffineFastState.Bounded env7027 := by
  intro p hp
  have h : env7027.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7024_7027 : H12AffineEnvironment.transform 4 25 env7024 = env7027 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 25 env7024 == env7027) = true)

theorem identity7027 : scanCanonicalize (H12AffineFastState.compose env7027 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound7027 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7028 : List Nat := [2,4,8,2,11,2,2,14,11,5,11,8,8,9,11,8,8,11,5,11,8,0,2,8,2,2,0,8,8,0,14,11,15,1,9,11]

theorem envBound7028 : H12AffineFastState.Bounded env7028 := by
  intro p hp
  have h : env7028.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7027_7028 : H12AffineEnvironment.transform 3 2 env7027 = env7028 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env7027 == env7028) = true)

theorem identity7028 : scanCanonicalize (H12AffineFastState.compose env7028 (packedSelected [1] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound7028 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7029 : List Nat := [2,4,2,2,1,2,2,4,1,5,1,2,2,3,1,2,2,1,5,1,2,0,2,2,2,2,0,2,2,0,4,1,5,1,3,1]

theorem envBound7029 : H12AffineFastState.Bounded env7029 := by
  intro p hp
  have h : env7029.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7028_7029 : H12AffineEnvironment.transform 2 2 env7028 = env7029 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env7028 == env7029) = true)

def env7030 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1024,32768,4096,4194304,5377,16777216,33554432,17010964,21331969,17011733,131073,21105822,16876544,4294967296,257,4332954679,131073,33563272]

theorem envBound7030 : H12AffineFastState.Bounded env7030 := by
  intro p hp
  have h : env7030.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7008_7030 : H12AffineEnvironment.transform 5 17 env7008 = env7030 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env7008 == env7030) = true)

theorem identity7030 : scanCanonicalize (H12AffineFastState.compose env7030 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(23+1) ^^^ 230421) := by decide +kernel

theorem selectedBound7030 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env7031 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1024,32768,4096,4194304,5377,230421,33554432,5377,4588564,4096,131073,4294795,131093,4294967296,257,4332954679,131073,33563272]

theorem envBound7031 : H12AffineFastState.Bounded env7031 := by
  intro p hp
  have h : env7031.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7030_7031 : H12AffineEnvironment.transform 23 230421 env7030 = env7031 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 230421 env7030 == env7031) = true)

theorem identity7031 : scanCanonicalize (H12AffineFastState.compose env7031 (packedSelected [1,3,17,21,24,28] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound7031 : packedSelected [1,3,17,21,24,28] rootPS < 2^1333 := by decide +kernel

def env7032 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,131072,262144,1024,32768,4096,4194304,5377,230421,8329,5377,4588564,4096,131073,4294795,131093,4294967296,257,4299392190,131073,513]

theorem envBound7032 : H12AffineFastState.Bounded env7032 := by
  intro p hp
  have h : env7032.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7031_7032 : H12AffineEnvironment.transform 24 8329 env7031 = env7032 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env7031 == env7032) = true)

theorem identity7032 : scanCanonicalize (H12AffineFastState.compose env7032 (packedSelected [13,21] rootPS)) = affineNative (2^(14+1) ^^^ 13341) := by decide +kernel

theorem selectedBound7032 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env7033 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,13341,65536,131072,262144,1024,13341,4096,4194304,5377,208904,8329,5377,4588564,4096,131073,4275350,131093,4294967296,257,4299370659,131073,513]

theorem envBound7033 : H12AffineFastState.Bounded env7033 := by
  intro p hp
  have h : env7033.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7032_7033 : H12AffineEnvironment.transform 14 13341 env7032 = env7033 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13341 env7032 == env7033) = true)

theorem identity7033 : scanCanonicalize (H12AffineFastState.compose env7033 (packedSelected [0,5,7,8,13,17,20] rootPS)) = affineNative (2^(16+1) ^^^ 1297) := by decide +kernel

theorem selectedBound7033 : packedSelected [0,5,7,8,13,17,20] rootPS < 2^1333 := by decide +kernel

def env7034 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,13341,65536,1297,262144,1024,13341,4096,4194304,5377,79129,8329,5377,4456709,4096,1296,4275350,1284,4294967296,257,4299240882,1296,513]

theorem envBound7034 : H12AffineFastState.Bounded env7034 := by
  intro p hp
  have h : env7034.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7033_7034 : H12AffineEnvironment.transform 16 1297 env7033 = env7034 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1297 env7033 == env7034) = true)

theorem identity7034 : scanCanonicalize (H12AffineFastState.compose env7034 (packedSelected [3,5,10] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound7034 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env7035 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8192,4097,13341,65536,1297,262144,1024,13341,4096,4194304,5377,79129,8329,5377,4456709,4096,1296,4275350,1284,4294967296,257,4299240882,1296,136]

theorem envBound7035 : H12AffineFastState.Bounded env7035 := by
  intro p hp
  have h : env7035.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7034_7035 : H12AffineEnvironment.transform 8 137 env7034 = env7035 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env7034 == env7035) = true)

theorem identity7035 : scanCanonicalize (H12AffineFastState.compose env7035 (packedSelected [1,6,8,12] rootPS)) = affineNative (2^(21+1) ^^^ 49) := by decide +kernel

theorem selectedBound7035 : packedSelected [1,6,8,12] rootPS < 2^1333 := by decide +kernel

def env7036 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8192,4097,13341,65536,1297,262144,1024,13341,4096,49,5377,79129,8329,5377,262452,4096,1296,81063,1284,4294967296,257,4295046531,1296,136]

theorem envBound7036 : H12AffineFastState.Bounded env7036 := by
  intro p hp
  have h : env7036.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7035_7036 : H12AffineEnvironment.transform 21 49 env7035 = env7036 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 49 env7035 == env7036) = true)

theorem identity7036 : scanCanonicalize (H12AffineFastState.compose env7036 (packedSelected [6,8,13] rootPS)) = affineNative (2^(15+1) ^^^ 2326) := by decide +kernel

theorem selectedBound7036 : packedSelected [6,8,13] rootPS < 2^1333 := by decide +kernel

def env7037 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8192,4097,13341,2326,1297,262144,1024,13341,4096,49,5377,15375,8329,5377,262452,4096,1296,13745,1284,4294967296,257,4294982805,1296,136]

theorem envBound7037 : H12AffineFastState.Bounded env7037 := by
  intro p hp
  have h : env7037.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7036_7037 : H12AffineEnvironment.transform 15 2326 env7036 = env7037 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2326 env7036 == env7037) = true)

theorem identity7037 : scanCanonicalize (H12AffineFastState.compose env7037 (packedSelected [3,5,6,15] rootPS)) = affineNative (2^(17+1) ^^^ 7220) := by decide +kernel

theorem selectedBound7037 : packedSelected [3,5,6,15] rootPS < 2^1333 := by decide +kernel

def env7038 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8192,4097,13341,2326,1297,7220,1024,13341,4096,49,5377,15375,8329,5377,7424,4096,1296,13745,1284,4294967296,257,4294982805,1296,136]

theorem envBound7038 : H12AffineFastState.Bounded env7038 := by
  intro p hp
  have h : env7038.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7037_7038 : H12AffineEnvironment.transform 17 7220 env7037 = env7038 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 7220 env7037 == env7038) = true)

theorem identity7038 : scanCanonicalize (H12AffineFastState.compose env7038 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 10242) := by decide +kernel

theorem selectedBound7038 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7039 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,8192,4097,13341,2326,1297,7220,1024,13341,4096,49,5377,15375,8329,5377,7424,4096,1296,13745,1284,10242,257,5271,1296,136]

theorem envBound7039 : H12AffineFastState.Bounded env7039 := by
  intro p hp
  have h : env7039.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7038_7039 : H12AffineEnvironment.transform 31 10242 env7038 = env7039 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 10242 env7038 == env7039) = true)

theorem identity7039 : scanCanonicalize (H12AffineFastState.compose env7039 (packedSelected [0,4,7,9,18,23] rootPS)) = affineNative (2^(12+1) ^^^ 7300) := by decide +kernel

theorem selectedBound7039 : packedSelected [0,4,7,9,18,23] rootPS < 2^1333 := by decide +kernel

def env7040 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,4096,7300,4097,2201,2326,1297,7220,1024,2201,4096,49,5377,139,7181,5377,7424,4096,1296,2357,1284,5254,257,5271,1296,136]

theorem envBound7040 : H12AffineFastState.Bounded env7040 := by
  intro p hp
  have h : env7040.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7039_7040 : H12AffineEnvironment.transform 12 7300 env7039 = env7040 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 7300 env7039 == env7040) = true)

def env7041 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1296,2452,1297,2201,2326,1297,2340,1024,2201,1296,49,17,139,2333,17,2064,1296,1296,2357,1284,406,257,391,1296,136]

theorem envBound7041 : H12AffineFastState.Bounded env7041 := by
  intro p hp
  have h : env7041.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7040_7041 : H12AffineEnvironment.transform 11 1296 env7040 = env7041 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env7040 == env7041) = true)

theorem identity7041 : scanCanonicalize (H12AffineFastState.compose env7041 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 24) := by decide +kernel

theorem selectedBound7041 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env7042 : List Nat := [2,4,8,16,32,17,24,256,17,1024,2048,1296,2316,1297,2049,2326,1297,2340,1024,2049,1296,49,17,19,2333,17,2064,1296,1296,2357,1284,270,257,287,1296,16]

theorem envBound7042 : H12AffineFastState.Bounded env7042 := by
  intro p hp
  have h : env7042.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7041_7042 : H12AffineEnvironment.transform 6 24 env7041 = env7042 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 24 env7041 == env7042) = true)

theorem identity7042 : scanCanonicalize (H12AffineFastState.compose env7042 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound7042 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7043 : List Nat := [2,4,8,0,32,1,8,256,1,1024,2048,1280,2316,1281,2049,2310,1281,2340,1024,2049,1280,33,1,3,2317,1,2048,1280,1280,2341,1284,270,257,271,1280,0]

theorem envBound7043 : H12AffineFastState.Bounded env7043 := by
  intro p hp
  have h : env7043.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7042_7043 : H12AffineEnvironment.transform 3 0 env7042 = env7043 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7042 == env7043) = true)

theorem identity7043 : scanCanonicalize (H12AffineFastState.compose env7043 (packedSelected [6] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound7043 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7044 : List Nat := [2,4,8,0,32,1,8,36,1,1024,2048,1060,2088,1061,2049,2082,1061,2048,1024,2049,1060,33,1,3,2089,1,2048,1060,1060,2049,1056,42,37,43,1060,0]

theorem envBound7044 : H12AffineFastState.Bounded env7044 := by
  intro p hp
  have h : env7044.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7043_7044 : H12AffineEnvironment.transform 7 36 env7043 = env7044 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env7043 == env7044) = true)

def leafEnv7044 : List Nat := [2,4,8,0,32,1,8,36,1,1024,2048,1060,2088,1061,2049,2082,1061,2048,1024,2049,1060,33,1,3,1056,2089,1,1,2048,1060,1060,2049,1056,42,37,43,5,2082,1060,0,0,1060,1]

def active7044 : List Nat := [0,1,2,4,9,10]

def tree7044 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7044 : H12WitnessSearch.Good tree7044 := H12GlobalWitnessIndex.good

theorem leafIdentity7044 : H12AffineFastState.composeSystem env7044 rootObs = leafEnv7044 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7044 rootObs == leafEnv7044) = true)

theorem terminalChecked7044 : H12PackedTerminal.terminalCheckFast leafEnv7044 active7044 tree7044 = true := by decide +kernel

def env7045 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,2453,1296,2201,2326,1297,2341,1024,2201,1297,49,16,139,2332,16,2065,1297,1296,2357,1284,407,257,390,1296,136]

theorem envBound7045 : H12AffineFastState.Bounded env7045 := by
  intro p hp
  have h : env7045.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7040_7045 : H12AffineEnvironment.transform 11 1297 env7040 = env7045 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env7040 == env7045) = true)

theorem identity7045 : scanCanonicalize (H12AffineFastState.compose env7045 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 172) := by decide +kernel

theorem selectedBound7045 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env7046 : List Nat := [2,4,8,16,32,17,128,172,137,1024,2048,1213,2105,1212,2201,2234,1213,2185,1024,2201,1213,49,16,139,2224,16,2065,1213,1212,2201,1192,59,173,42,1212,136]

theorem envBound7046 : H12AffineFastState.Bounded env7046 := by
  intro p hp
  have h : env7046.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7045_7046 : H12AffineEnvironment.transform 7 172 env7045 = env7046 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 172 env7045 == env7046) = true)

theorem identity7046 : scanCanonicalize (H12AffineFastState.compose env7046 (packedSelected [2,4] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound7046 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env7047 : List Nat := [2,4,8,0,32,1,128,172,137,1024,2048,1197,2089,1196,2185,2218,1197,2185,1024,2185,1197,33,0,139,2208,0,2049,1197,1196,2185,1192,43,173,42,1196,136]

theorem envBound7047 : H12AffineFastState.Bounded env7047 := by
  intro p hp
  have h : env7047.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7046_7047 : H12AffineEnvironment.transform 3 0 env7046 = env7047 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7046 == env7047) = true)

theorem identity7047 : scanCanonicalize (H12AffineFastState.compose env7047 (packedSelected [6] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound7047 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7048 : List Nat := [2,4,8,0,32,1,8,36,1,1024,2048,1061,2089,1060,2049,2082,1061,2049,1024,2049,1061,33,0,3,2088,0,2049,1061,1060,2049,1056,43,37,42,1060,0]

theorem envBound7048 : H12AffineFastState.Bounded env7048 := by
  intro p hp
  have h : env7048.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7047_7048 : H12AffineEnvironment.transform 6 8 env7047 = env7048 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env7047 == env7048) = true)

def leafEnv7048 : List Nat := [2,4,8,0,32,1,8,36,1,1024,2048,1061,2089,1060,2049,2082,1061,2049,1024,2049,1061,33,0,3,1056,2088,1,0,2049,1061,1060,2049,1056,43,37,42,5,2082,1060,0,0,1060,1]

def active7048 : List Nat := [0,1,2,4,9,10]

def tree7048 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7048 : H12WitnessSearch.Good tree7048 := H12GlobalWitnessIndex.good

theorem leafIdentity7048 : H12AffineFastState.composeSystem env7048 rootObs = leafEnv7048 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7048 rootObs == leafEnv7048) = true)

theorem terminalChecked7048 : H12PackedTerminal.terminalCheckFast leafEnv7048 active7048 tree7048 = true := by decide +kernel

def env7049 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,16777216,33554432,17011013,21352529,17024069,131152,1073741824,16876544,4294967296,257,4332975159,131073,33563272]

theorem envBound7049 : H12AffineFastState.Bounded env7049 := by
  intro p hp
  have h : env7049.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6964_7049 : H12AffineEnvironment.transform 18 1025 env6964 = env7049 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env6964 == env7049) = true)

theorem identity7049 : scanCanonicalize (H12AffineFastState.compose env7049 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 21105870) := by decide +kernel

theorem selectedBound7049 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env7050 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,16777216,33554432,17011013,21352529,17024069,131152,21105870,16876544,4294967296,257,4332975159,131073,33563272]

theorem envBound7050 : H12AffineFastState.Bounded env7050 := by
  intro p hp
  have h : env7050.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7049_7050 : H12AffineEnvironment.transform 29 21105870 env7049 = env7050 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 21105870 env7049 == env7050) = true)

def env7051 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,16777216,33554432,17010965,21352449,17024021,131072,21105822,16876544,4294967296,257,4332975159,131073,33563272]

theorem envBound7051 : H12AffineFastState.Bounded env7051 := by
  intro p hp
  have h : env7051.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7050_7051 : H12AffineEnvironment.transform 5 16 env7050 = env7051 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env7050 == env7051) = true)

def env7052 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,131072,262144,1025,32768,4096,4194304,17664,16777216,33554432,17010965,21352449,17024021,131072,21105822,16876544,4294967296,257,4332967607,131073,33554440]

theorem envBound7052 : H12AffineFastState.Bounded env7052 := by
  intro p hp
  have h : env7052.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7051_7052 : H12AffineEnvironment.transform 12 640 env7051 = env7052 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 640 env7051 == env7052) = true)

def env7053 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,16777216,33554432,16875797,21352449,16897045,4096,20978846,16876544,4294967296,257,4332832439,4097,33554440]

theorem envBound7053 : H12AffineFastState.Bounded env7053 := by
  intro p hp
  have h : env7053.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7052_7053 : H12AffineEnvironment.transform 16 4096 env7052 = env7053 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env7052 == env7053) = true)

theorem identity7053 : scanCanonicalize (H12AffineFastState.compose env7053 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(23+1) ^^^ 104093) := by decide +kernel

theorem selectedBound7053 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env7054 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,104093,33554432,6024,4474524,17032,4096,4295171,4765,4294967296,257,4332832439,4097,33554440]

theorem envBound7054 : H12AffineFastState.Bounded env7054 := by
  intro p hp
  have h : env7054.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7053_7054 : H12AffineEnvironment.transform 23 104093 env7053 = env7054 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 104093 env7053 == env7054) = true)

def env7055 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,104093,128,6024,4474524,17032,4096,4295171,4765,4294967296,257,4299277879,4097,136]

theorem envBound7055 : H12AffineFastState.Bounded env7055 := by
  intro p hp
  have h : env7055.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7054_7055 : H12AffineEnvironment.transform 24 128 env7054 = env7055 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 128 env7054 == env7055) = true)

theorem identity7055 : scanCanonicalize (H12AffineFastState.compose env7055 (packedSelected [1,3,10,19,24,26,28,31] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound7055 : packedSelected [1,3,10,19,24,26,28,31] rootPS < 2^1333 := by decide +kernel

def env7056 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,103444,128,5377,4473877,16385,4096,4294794,4116,4294967296,257,4299277502,4097,136]

theorem envBound7056 : H12AffineFastState.Bounded env7056 := by
  intro p hp
  have h : env7056.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7055_7056 : H12AffineEnvironment.transform 8 137 env7055 = env7056 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env7055 == env7056) = true)

def env7057 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,16384,32768,65536,4096,262144,1025,32768,4096,32904,17664,103444,128,5377,312477,16385,4096,67586,4116,4294967296,257,4295050294,4097,136]

theorem envBound7057 : H12AffineFastState.Bounded env7057 := by
  intro p hp
  have h : env7057.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7056_7057 : H12AffineEnvironment.transform 21 32904 env7056 = env7057 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 32904 env7056 == env7057) = true)

theorem identity7057 : scanCanonicalize (H12AffineFastState.compose env7057 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 312755) := by decide +kernel

theorem selectedBound7057 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7058 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,16384,32768,65536,4096,262144,1025,32768,4096,32904,17664,103444,128,5377,312477,16385,4096,67586,4116,312755,257,360837,4097,136]

theorem envBound7058 : H12AffineFastState.Bounded env7058 := by
  intro p hp
  have h : env7058.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7057_7058 : H12AffineEnvironment.transform 31 312755 env7057 = env7058 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 312755 env7057 == env7058) = true)

def env7059 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,16384,32768,65536,4096,262144,1025,32768,4096,32905,17664,103444,128,5377,312476,16385,4096,67587,4116,4294967296,257,4295050295,4097,136]

theorem envBound7059 : H12AffineFastState.Bounded env7059 := by
  intro p hp
  have h : env7059.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7056_7059 : H12AffineEnvironment.transform 21 32905 env7056 = env7059 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 32905 env7056 == env7059) = true)

theorem identity7059 : scanCanonicalize (H12AffineFastState.compose env7059 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 283046) := by decide +kernel

theorem selectedBound7059 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7060 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,16384,32768,65536,4096,262144,1025,32768,4096,32905,17664,103444,128,5377,312476,16385,4096,67587,4116,283046,257,333201,4097,136]

theorem envBound7060 : H12AffineFastState.Bounded env7060 := by
  intro p hp
  have h : env7060.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7059_7060 : H12AffineEnvironment.transform 31 283046 env7059 = env7060 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 283046 env7059 == env7060) = true)

theorem identity7060 : scanCanonicalize (H12AffineFastState.compose env7060 (packedSelected [1,3,4,9,13,16,17,24,28] rootPS)) = affineNative (2^(13+1) ^^^ 4096) := by decide +kernel

theorem selectedBound7060 : packedSelected [1,3,4,9,13,16,17,24,28] rootPS < 2^1333 := by decide +kernel

def env7061 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,4096,9,4096,32768,65536,4096,262144,1025,32768,4096,32905,5376,103444,128,5377,300188,4097,4096,67587,4116,262566,257,333201,4097,136]

theorem envBound7061 : H12AffineFastState.Bounded env7061 := by
  intro p hp
  have h : env7061.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7060_7061 : H12AffineEnvironment.transform 13 4096 env7060 = env7061 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4096 env7060 == env7061) = true)

theorem identity7061 : scanCanonicalize (H12AffineFastState.compose env7061 (packedSelected [4,9,16] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound7061 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env7062 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,9,1296,32768,65536,1296,262144,1025,32768,1296,32905,16,98564,128,17,295308,1297,1296,67587,1284,262566,257,327809,1297,136]

theorem envBound7062 : H12AffineFastState.Bounded env7062 := by
  intro p hp
  have h : env7062.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7061_7062 : H12AffineEnvironment.transform 11 1296 env7061 = env7062 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env7061 == env7062) = true)

theorem identity7062 : scanCanonicalize (H12AffineFastState.compose env7062 (packedSelected [1,3,5] rootPS)) = affineNative (2^(15+1) ^^^ 34986) := by decide +kernel

theorem selectedBound7062 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env7063 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,9,1296,32768,34986,1296,262144,1025,32768,1296,32905,16,2478,128,17,295308,1297,1296,32937,1284,262566,257,297003,1297,136]

theorem envBound7063 : H12AffineFastState.Bounded env7063 := by
  intro p hp
  have h : env7063.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7062_7063 : H12AffineEnvironment.transform 15 34986 env7062 = env7063 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 34986 env7062 == env7063) = true)

theorem identity7063 : scanCanonicalize (H12AffineFastState.compose env7063 (packedSelected [1,3,8] rootPS)) = affineNative (2^(17+1) ^^^ 34848) := by decide +kernel

theorem selectedBound7063 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env7064 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1296,9,1296,32768,34986,1296,34848,1025,32768,1296,32905,16,2478,128,17,2476,1297,1296,32937,1284,35206,257,11,1297,136]

theorem envBound7064 : H12AffineFastState.Bounded env7064 := by
  intro p hp
  have h : env7064.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7063_7064 : H12AffineEnvironment.transform 17 34848 env7063 = env7064 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 34848 env7063 == env7064) = true)

theorem identity7064 : scanCanonicalize (H12AffineFastState.compose env7064 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 11) := by decide +kernel

theorem selectedBound7064 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7065 : List Nat := [2,4,8,16,11,16,128,256,137,1024,2048,1296,9,1296,32768,34945,1296,34827,1025,32768,1296,32905,16,2437,128,17,2439,1297,1296,32898,1284,35206,257,11,1297,136]

theorem envBound7065 : H12AffineFastState.Bounded env7065 := by
  intro p hp
  have h : env7065.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7064_7065 : H12AffineEnvironment.transform 4 11 env7064 = env7065 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 11 env7064 == env7065) = true)

theorem identity7065 : scanCanonicalize (H12AffineFastState.compose env7065 (packedSelected [10] rootPS)) = affineNative (2^(14+1) ^^^ 260) := by decide +kernel

theorem selectedBound7065 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env7066 : List Nat := [2,4,8,16,11,16,128,256,137,1024,2048,1296,9,1296,260,2437,1296,2319,1025,260,1296,397,16,2437,128,17,2439,1297,1296,390,1284,2178,257,11,1297,136]

theorem envBound7066 : H12AffineFastState.Bounded env7066 := by
  intro p hp
  have h : env7066.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7065_7066 : H12AffineEnvironment.transform 14 260 env7065 = env7066 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 260 env7065 == env7066) = true)

theorem identity7066 : scanCanonicalize (H12AffineFastState.compose env7066 (packedSelected [3,12] rootPS)) = affineNative (2^(7+1) ^^^ 141) := by decide +kernel

theorem selectedBound7066 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env7067 : List Nat := [2,4,8,16,11,16,128,141,137,1024,2048,1181,9,1181,137,2056,1181,2178,1025,137,1181,0,16,2056,128,17,2058,1180,1181,11,1161,2178,140,11,1180,136]

theorem envBound7067 : H12AffineFastState.Bounded env7067 := by
  intro p hp
  have h : env7067.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7066_7067 : H12AffineEnvironment.transform 7 141 env7066 = env7067 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 141 env7066 == env7067) = true)

theorem identity7067 : scanCanonicalize (H12AffineFastState.compose env7067 (packedSelected [4,7] rootPS)) = affineNative (2^(10+1) ^^^ 146) := by decide +kernel

theorem selectedBound7067 : packedSelected [4,7] rootPS < 2^1333 := by decide +kernel

def env7068 : List Nat := [2,4,8,16,11,16,128,141,137,1024,146,1181,9,1181,137,154,1181,16,1025,137,1181,0,16,154,128,17,152,1180,1181,11,1161,16,140,11,1180,136]

theorem envBound7068 : H12AffineFastState.Bounded env7068 := by
  intro p hp
  have h : env7068.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7067_7068 : H12AffineEnvironment.transform 10 146 env7067 = env7068 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 146 env7067 == env7068) = true)

theorem identity7068 : scanCanonicalize (H12AffineFastState.compose env7068 (packedSelected [0,2,4,9] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound7068 : packedSelected [0,2,4,9] rootPS < 2^1333 := by decide +kernel

def env7069 : List Nat := [2,4,2,16,1,16,128,135,131,1024,146,1175,3,1175,131,144,1175,16,1025,131,1175,0,16,144,128,17,146,1174,1175,1,1155,16,134,1,1174,130]

theorem envBound7069 : H12AffineFastState.Bounded env7069 := by
  intro p hp
  have h : env7069.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7068_7069 : H12AffineEnvironment.transform 2 2 env7068 = env7069 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env7068 == env7069) = true)

theorem identity7069 : scanCanonicalize (H12AffineFastState.compose env7069 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 18) := by decide +kernel

theorem selectedBound7069 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7070 : List Nat := [2,4,2,16,1,16,18,21,17,1024,0,1029,3,1029,17,2,1029,16,1025,17,1029,0,16,2,18,17,0,1028,1029,1,1041,16,20,1,1028,16]

theorem envBound7070 : H12AffineFastState.Bounded env7070 := by
  intro p hp
  have h : env7070.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7069_7070 : H12AffineEnvironment.transform 6 18 env7069 = env7070 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 18 env7069 == env7070) = true)

theorem identity7070 : scanCanonicalize (H12AffineFastState.compose env7070 (packedSelected [18] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound7070 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env7071 : List Nat := [2,4,2,0,1,0,2,5,1,1024,0,1029,3,1029,1,2,1029,0,1025,1,1029,0,0,2,2,1,0,1028,1029,1,1025,0,4,1,1028,0]

theorem envBound7071 : H12AffineFastState.Bounded env7071 := by
  intro p hp
  have h : env7071.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7070_7071 : H12AffineEnvironment.transform 3 0 env7070 = env7071 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env7070 == env7071) = true)

def leafEnv7071 : List Nat := [2,4,2,0,1,0,2,5,1,1024,0,1029,3,1029,1,2,1029,0,1025,1,1029,0,0,2,1024,2,1,1,0,1028,1029,1,1025,0,4,1,5,3,1028,0,0,1029,1]

def active7071 : List Nat := [0,1,9]

def tree7071 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood7071 : H12WitnessSearch.Good tree7071 := H12GlobalWitnessIndex.good

theorem leafIdentity7071 : H12AffineFastState.composeSystem env7071 rootObs = leafEnv7071 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env7071 rootObs == leafEnv7071) = true)

theorem terminalChecked7071 : H12PackedTerminal.terminalCheckFast leafEnv7071 active7071 tree7071 = true := by decide +kernel

def env7072 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4096,262144,1025,32768,4096,4194304,17664,104093,129,6024,4474524,17032,4096,4295171,4765,4294967296,257,4299277878,4097,137]

theorem envBound7072 : H12AffineFastState.Bounded env7072 := by
  intro p hp
  have h : env7072.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7054_7072 : H12AffineEnvironment.transform 24 129 env7054 = env7072 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 129 env7054 == env7072) = true)

theorem identity7072 : scanCanonicalize (H12AffineFastState.compose env7072 (packedSelected [13,17,21,33] rootPS)) = affineNative (2^(13+1) ^^^ 4097) := by decide +kernel

theorem selectedBound7072 : packedSelected [13,17,21,33] rootPS < 2^1333 := by decide +kernel

def env7073 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,4097,32768,65536,4096,262144,1025,32768,4096,4194304,5377,104093,129,6024,4462237,4745,4096,4295171,4765,4294967296,257,4299265591,4097,137]

theorem envBound7073 : H12AffineFastState.Bounded env7073 := by
  intro p hp
  have h : env7073.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7072_7073 : H12AffineEnvironment.transform 13 4097 env7072 = env7073 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4097 env7072 == env7073) = true)

theorem identity7073 : scanCanonicalize (H12AffineFastState.compose env7073 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(11+1) ^^^ 1296) := by decide +kernel

theorem selectedBound7073 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env7074 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1296,640,1297,32768,65536,1296,262144,1025,32768,1296,4194304,17,99213,129,664,4457357,1945,1296,4295171,1933,4294967296,257,4299260711,1297,137]

theorem envBound7074 : H12AffineFastState.Bounded env7074 := by
  intro p hp
  have h : env7074.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7073_7074 : H12AffineEnvironment.transform 11 1296 env7073 = env7074 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env7073 == env7074) = true)

theorem identity7074 : scanCanonicalize (H12AffineFastState.compose env7074 (packedSelected [1,3,4,9,12,13,15,16,17] rootPS)) = affineNative (2^(21+1) ^^^ 297388) := by decide +kernel

theorem selectedBound7074 : packedSelected [1,3,4,9,12,13,15,16,17] rootPS < 2^1333 := by decide +kernel

def env7075 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1296,640,1297,32768,65536,1296,262144,1025,32768,1296,297388,17,99213,129,664,35361,1945,1296,328623,1933,4294967296,257,4295297675,1297,137]

theorem envBound7075 : H12AffineFastState.Bounded env7075 := by
  intro p hp
  have h : env7075.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7074_7075 : H12AffineEnvironment.transform 21 297388 env7074 = env7075 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 297388 env7074 == env7075) = true)

def env7076 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,16777216,33554432,16875796,21352449,16897044,4097,20978847,16876544,4294967296,257,4332832438,4096,33554440]

theorem envBound7076 : H12AffineFastState.Bounded env7076 := by
  intro p hp
  have h : env7076.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7052_7076 : H12AffineEnvironment.transform 16 4097 env7052 = env7076 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env7052 == env7076) = true)

theorem identity7076 : scanCanonicalize (H12AffineFastState.compose env7076 (packedSelected [1,3,5,8,9,10,19,22] rootPS)) = affineNative (2^(23+1) ^^^ 99213) := by decide +kernel

theorem selectedBound7076 : packedSelected [1,3,5,8,9,10,19,22] rootPS < 2^1333 := by decide +kernel

def env7077 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,16384,32768,65536,4097,262144,1025,32768,4096,4194304,17664,99213,33554432,665,4477836,22425,4097,4300562,1933,4294967296,257,4332832438,4096,33554440]

theorem envBound7077 : H12AffineFastState.Bounded env7077 := by
  intro p hp
  have h : env7077.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7076_7077 : H12AffineEnvironment.transform 23 99213 env7076 = env7077 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 99213 env7076 == env7077) = true)

def env7078 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,1296,32768,65536,4097,262144,1025,32768,4096,4194304,16,99213,33554432,665,4462236,4745,4097,4300562,1933,4294967296,257,4332815270,4096,33554440]

theorem envBound7078 : H12AffineFastState.Bounded env7078 := by
  intro p hp
  have h : env7078.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7077_7078 : H12AffineEnvironment.transform 13 1296 env7077 = env7078 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1296 env7077 == env7078) = true)

theorem identity7078 : scanCanonicalize (H12AffineFastState.compose env7078 (packedSelected [3,6,10,24,25,26] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound7078 : packedSelected [3,6,10,24,25,26] rootPS < 2^1333 := by decide +kernel

def env7079 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1297,640,1296,32768,65536,1296,262144,1025,32768,1297,4194304,16,99213,33554432,665,4457357,1944,1296,4295171,1933,4294967296,257,4332815270,1297,33554440]

theorem envBound7079 : H12AffineFastState.Bounded env7079 := by
  intro p hp
  have h : env7079.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7078_7079 : H12AffineEnvironment.transform 11 1297 env7078 = env7079 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env7078 == env7079) = true)

theorem identity7079 : scanCanonicalize (H12AffineFastState.compose env7079 (packedSelected [1,3,5,6,8,10,19,25] rootPS)) = affineNative (2^(24+1) ^^^ 128) := by decide +kernel

theorem selectedBound7079 : packedSelected [1,3,5,6,8,10,19,25] rootPS < 2^1333 := by decide +kernel

def env7080 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1297,640,1296,32768,65536,1296,262144,1025,32768,1297,4194304,16,99213,128,665,4457357,1944,1296,4295171,1933,4294967296,257,4299260710,1297,136]

theorem envBound7080 : H12AffineFastState.Bounded env7080 := by
  intro p hp
  have h : env7080.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7079_7080 : H12AffineEnvironment.transform 24 128 env7079 = env7080 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 128 env7079 == env7080) = true)

theorem identity7080 : scanCanonicalize (H12AffineFastState.compose env7080 (packedSelected [1,3,4,9,12,13,15,16,17] rootPS)) = affineNative (2^(17+1) ^^^ 34848) := by decide +kernel

theorem selectedBound7080 : packedSelected [1,3,4,9,12,13,15,16,17] rootPS < 2^1333 := by decide +kernel

def env7081 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1297,640,1296,32768,65536,1296,34848,1025,32768,1297,4194304,16,99213,128,665,4230061,1944,1296,4295171,1933,4294967296,257,4299260710,1297,136]

theorem envBound7081 : H12AffineFastState.Bounded env7081 := by
  intro p hp
  have h : env7081.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7080_7081 : H12AffineEnvironment.transform 17 34848 env7080 = env7081 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 34848 env7080 == env7081) = true)

theorem identity7081 : scanCanonicalize (H12AffineFastState.compose env7081 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound7081 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env7082 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,9,1296,32768,65536,1296,34848,1025,32768,1297,4194304,16,98564,128,16,4229412,1297,1296,4294794,1284,4294967296,257,4299260335,1297,136]

theorem envBound7082 : H12AffineFastState.Bounded env7082 := by
  intro p hp
  have h : env7082.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7081_7082 : H12AffineEnvironment.transform 8 137 env7081 = env7082 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env7081 == env7082) = true)

theorem identity7082 : scanCanonicalize (H12AffineFastState.compose env7082 (packedSelected [1] rootPS)) = affineNative (2^(31+1) ^^^ 4195469) := by decide +kernel

theorem selectedBound7082 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env7083 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,9,1296,32768,65536,1296,34848,1025,32768,1297,4194304,16,98564,128,16,4229412,1297,1296,4294794,1284,4195469,257,99618,1297,136]

theorem envBound7083 : H12AffineFastState.Bounded env7083 := by
  intro p hp
  have h : env7083.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7082_7083 : H12AffineEnvironment.transform 31 4195469 env7082 = env7083 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 4195469 env7082 == env7083) = true)

theorem identity7083 : scanCanonicalize (H12AffineFastState.compose env7083 (packedSelected [3,5] rootPS)) = affineNative (2^(21+1) ^^^ 2477) := by decide +kernel

theorem selectedBound7083 : packedSelected [3,5] rootPS < 2^1333 := by decide +kernel

def env7084 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,9,1296,32768,65536,1296,34848,1025,32768,1297,2477,16,98564,128,16,32905,1297,1296,98599,1284,3360,257,99618,1297,136]

theorem envBound7084 : H12AffineFastState.Bounded env7084 := by
  intro p hp
  have h : env7084.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7083_7084 : H12AffineEnvironment.transform 21 2477 env7083 = env7084 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 2477 env7083 == env7084) = true)

theorem identity7084 : scanCanonicalize (H12AffineFastState.compose env7084 (packedSelected [3,8] rootPS)) = affineNative (2^(15+1) ^^^ 33166) := by decide +kernel

theorem selectedBound7084 : packedSelected [3,8] rootPS < 2^1333 := by decide +kernel

def env7085 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,9,1296,32768,33166,1296,34848,1025,32768,1297,2477,16,138,128,16,32905,1297,1296,169,1284,3360,257,1196,1297,136]

theorem envBound7085 : H12AffineFastState.Bounded env7085 := by
  intro p hp
  have h : env7085.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7084_7085 : H12AffineEnvironment.transform 15 33166 env7084 = env7085 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33166 env7084 == env7085) = true)

theorem identity7085 : scanCanonicalize (H12AffineFastState.compose env7085 (packedSelected [3] rootPS)) = affineNative (2^(14+1) ^^^ 1328) := by decide +kernel

theorem selectedBound7085 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env7086 : List Nat := [2,4,8,16,32,16,128,256,137,1024,2048,1297,9,1296,1328,1214,1296,3344,1025,1328,1297,2477,16,138,128,16,1465,1297,1296,169,1284,3360,257,1196,1297,136]

theorem envBound7086 : H12AffineFastState.Bounded env7086 := by
  intro p hp
  have h : env7086.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7085_7086 : H12AffineEnvironment.transform 14 1328 env7085 = env7086 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 1328 env7085 == env7086) = true)

theorem identity7086 : scanCanonicalize (H12AffineFastState.compose env7086 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(10+1) ^^^ 1465) := by decide +kernel

theorem selectedBound7086 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env7087 : List Nat := [2,4,8,16,32,16,128,256,137,1024,1465,1297,9,1296,1328,1214,1296,169,1025,1328,1297,1044,16,138,128,16,1465,1297,1296,169,1284,153,257,1196,1297,136]

theorem envBound7087 : H12AffineFastState.Bounded env7087 := by
  intro p hp
  have h : env7087.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7086_7087 : H12AffineEnvironment.transform 10 1465 env7086 = env7087 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1465 env7086 == env7087) = true)

theorem identity7087 : scanCanonicalize (H12AffineFastState.compose env7087 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(9+1) ^^^ 440) := by decide +kernel

theorem selectedBound7087 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env7088 : List Nat := [2,4,8,16,32,16,128,256,137,440,1,169,9,168,136,262,168,169,441,136,169,428,16,138,128,16,1,169,168,169,188,153,257,276,169,136]

theorem envBound7088 : H12AffineFastState.Bounded env7088 := by
  intro p hp
  have h : env7088.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7087_7088 : H12AffineEnvironment.transform 9 440 env7087 = env7088 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 440 env7087 == env7088) = true)

theorem identity7088 : scanCanonicalize (H12AffineFastState.compose env7088 (packedSelected [0,7] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound7088 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env7089 : List Nat := [2,4,8,16,32,16,128,4,137,188,1,169,9,168,136,2,168,169,189,136,169,168,16,138,128,16,1,169,168,169,188,153,5,16,169,136]

theorem envBound7089 : H12AffineFastState.Bounded env7089 := by
  intro p hp
  have h : env7089.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7088_7089 : H12AffineEnvironment.transform 7 4 env7088 = env7089 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env7088 == env7089) = true)

theorem identity7089 : scanCanonicalize (H12AffineFastState.compose env7089 (packedSelected [2,4] rootPS)) = affineNative (2^(6+1) ^^^ 41) := by decide +kernel

theorem selectedBound7089 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env7090 : List Nat := [2,4,8,16,32,16,41,4,32,21,1,0,9,1,33,2,1,0,20,33,0,1,16,35,41,16,1,0,1,0,21,48,5,16,0,33]

theorem envBound7090 : H12AffineFastState.Bounded env7090 := by
  intro p hp
  have h : env7090.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7089_7090 : H12AffineEnvironment.transform 6 41 env7089 = env7090 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 41 env7089 == env7090) = true)

theorem identity7090 : scanCanonicalize (H12AffineFastState.compose env7090 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 27) := by decide +kernel

theorem selectedBound7090 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env7091 : List Nat := [2,4,8,16,27,16,18,4,27,21,1,0,9,1,26,2,1,0,20,26,0,1,16,24,18,16,1,0,1,0,21,11,5,16,0,26]

theorem envBound7091 : H12AffineFastState.Bounded env7091 := by
  intro p hp
  have h : env7091.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7090_7091 : H12AffineEnvironment.transform 4 27 env7090 = env7091 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 27 env7090 == env7091) = true)

def env7092 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,1297,32768,65536,4097,262144,1025,32768,4096,4194304,17,99213,33554432,665,4462237,4744,4097,4300562,1933,4294967296,257,4332815271,4096,33554440]

theorem envBound7092 : H12AffineFastState.Bounded env7092 := by
  intro p hp
  have h : env7092.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7077_7092 : H12AffineEnvironment.transform 13 1297 env7077 = env7092 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 1297 env7077 == env7092) = true)

theorem identity7092 : scanCanonicalize (H12AffineFastState.compose env7092 (packedSelected [3,6,10,24,25,26] rootPS)) = affineNative (2^(24+1) ^^^ 5521) := by decide +kernel

theorem selectedBound7092 : packedSelected [3,6,10,24,25,26] rootPS < 2^1333 := by decide +kernel

def env7093 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,640,1297,32768,65536,4097,262144,1025,32768,4096,4194304,17,99213,5521,665,4462237,4744,4097,4300562,1933,4294967296,257,4299265590,4096,5529]

theorem envBound7093 : H12AffineFastState.Bounded env7093 := by
  intro p hp
  have h : env7093.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7092_7093 : H12AffineEnvironment.transform 24 5521 env7092 = env7093 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 5521 env7092 == env7093) = true)

theorem identity7093 : scanCanonicalize (H12AffineFastState.compose env7093 (packedSelected [3,5,6,8,10,25,28,31] rootPS)) = affineNative (2^(11+1) ^^^ 1944) := by decide +kernel

theorem selectedBound7093 : packedSelected [3,5,6,8,10,25,28,31] rootPS < 2^1333 := by decide +kernel

def env7094 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,640,1297,32768,65536,1945,262144,1025,32768,1944,4194304,17,99213,521,665,4456709,1296,1945,4294794,1933,4294967296,257,4299260334,1944,513]

theorem envBound7094 : H12AffineFastState.Bounded env7094 := by
  intro p hp
  have h : env7094.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7093_7094 : H12AffineEnvironment.transform 11 1944 env7093 = env7094 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1944 env7093 == env7094) = true)

theorem identity7094 : scanCanonicalize (H12AffineFastState.compose env7094 (packedSelected [5,8,17,21] rootPS)) = affineNative (2^(14+1) ^^^ 261) := by decide +kernel

theorem selectedBound7094 : packedSelected [5,8,17,21] rootPS < 2^1333 := by decide +kernel

def env7095 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,640,1297,261,65536,1945,262144,1025,261,1944,4194304,17,66184,521,665,4456709,1296,1945,4262287,1933,4294967296,257,4299227307,1944,513]

theorem envBound7095 : H12AffineFastState.Bounded env7095 := by
  intro p hp
  have h : env7095.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7094_7095 : H12AffineEnvironment.transform 14 261 env7094 = env7095 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 261 env7094 == env7095) = true)

theorem identity7095 : scanCanonicalize (H12AffineFastState.compose env7095 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 262566) := by decide +kernel

theorem selectedBound7095 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env7096 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,640,1297,261,65536,1945,262144,1025,261,1944,4194304,17,66184,521,665,4456709,1296,1945,4262287,1933,262566,257,4522253,1944,513]

theorem envBound7096 : H12AffineFastState.Bounded env7096 := by
  intro p hp
  have h : env7096.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7095_7096 : H12AffineEnvironment.transform 31 262566 env7095 = env7096 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 262566 env7095 == env7096) = true)

theorem identity7096 : scanCanonicalize (H12AffineFastState.compose env7096 (packedSelected [10,12,17] rootPS)) = affineNative (2^(15+1) ^^^ 139) := by decide +kernel

theorem selectedBound7096 : packedSelected [10,12,17] rootPS < 2^1333 := by decide +kernel

def env7097 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,640,1297,261,139,1945,262144,1025,261,1944,4194304,17,515,521,665,4456709,1296,1945,4196612,1933,262566,257,4456838,1944,513]

theorem envBound7097 : H12AffineFastState.Bounded env7097 := by
  intro p hp
  have h : env7097.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans7096_7097 : H12AffineEnvironment.transform 15 139 env7096 = env7097 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 139 env7096 == env7097) = true)

theorem identity7097 : scanCanonicalize (H12AffineFastState.compose env7097 (packedSelected [1,5,8,24] rootPS)) = affineNative (2^(17+1) ^^^ 2341) := by decide +kernel

theorem selectedBound7097 : packedSelected [1,5,8,24] rootPS < 2^1333 := by decide +kernel

def env7098 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1944,640,1297,261,139,1945,2341,1025,261,1944,4194304,17,515,521,665,4196384,1296,1945,4196612,1933,2179,257,4196515,1944,513]

theorem envBound7098 : H12AffineFastState.Bounded env7098 := by
  intro p hp
  have h : env7098.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

end H12GlobalChart2
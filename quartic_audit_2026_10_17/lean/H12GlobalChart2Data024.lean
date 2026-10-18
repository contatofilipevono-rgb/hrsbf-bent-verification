import H12GlobalChart2Data023

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

def env5894 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4096,4194304,17665,16777216,8328,5377,4477269,16384,16876565,1073741824,1284,4294967296,16875524,4316484858,1344,512]

theorem envBound5894 : H12AffineFastState.Bounded env5894 := by
  intro p hp
  have h : env5894.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5893_5894 : H12AffineEnvironment.transform 24 8328 env5893 = env5894 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8328 env5893 == env5894) = true)

theorem identity5894 : scanCanonicalize (H12AffineFastState.compose env5894 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(29+1) ^^^ 4279454) := by decide +kernel

theorem selectedBound5894 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env5895 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4096,4194304,17665,16777216,8328,5377,4477269,16384,16876565,4279454,1284,4294967296,16875524,4316484858,1344,512]

theorem envBound5895 : H12AffineFastState.Bounded env5895 := by
  intro p hp
  have h : env5895.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5894_5895 : H12AffineEnvironment.transform 29 4279454 env5894 = env5895 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4279454 env5894 == env5895) = true)

theorem identity5895 : scanCanonicalize (H12AffineFastState.compose env5895 (packedSelected [4,16,22] rootPS)) = affineNative (2^(23+1) ^^^ 4306368) := by decide +kernel

theorem selectedBound5895 : packedSelected [4,16,22] rootPS < 2^1333 := by decide +kernel

def env5896 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,524288,32768,4096,4194304,17665,4306368,8328,5377,4477269,16384,4207061,4279454,1284,4294967296,4208068,4295614778,1344,512]

theorem envBound5896 : H12AffineFastState.Bounded env5896 := by
  intro p hp
  have h : env5896.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5895_5896 : H12AffineEnvironment.transform 23 4306368 env5895 = env5896 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 4306368 env5895 == env5896) = true)

theorem identity5896 : scanCanonicalize (H12AffineFastState.compose env5896 (packedSelected [4,6,9,16,25] rootPS)) = affineNative (2^(18+1) ^^^ 24857) := by decide +kernel

theorem selectedBound5896 : packedSelected [4,6,9,16,25] rootPS < 2^1333 := by decide +kernel

def env5897 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,24857,32768,4096,4194304,17665,4306368,8328,5377,4477269,16384,4207061,4279454,1284,4294967296,4208068,4295065635,1344,512]

theorem envBound5897 : H12AffineFastState.Bounded env5897 := by
  intro p hp
  have h : env5897.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5896_5897 : H12AffineEnvironment.transform 18 24857 env5896 = env5897 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 24857 env5896 == env5897) = true)

theorem identity5897 : scanCanonicalize (H12AffineFastState.compose env5897 (packedSelected [0,27] rootPS)) = affineNative (2^(21+1) ^^^ 41089) := by decide +kernel

theorem selectedBound5897 : packedSelected [0,27] rootPS < 2^1333 := by decide +kernel

def env5898 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,1345,262144,24857,32768,4096,41089,17665,70977,8328,5377,324052,16384,37204,125983,1284,4294967296,38213,4295065635,1344,512]

theorem envBound5898 : H12AffineFastState.Bounded env5898 := by
  intro p hp
  have h : env5898.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5897_5898 : H12AffineEnvironment.transform 21 41089 env5897 = env5898 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 41089 env5897 == env5898) = true)

theorem identity5898 : scanCanonicalize (H12AffineFastState.compose env5898 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 4176) := by decide +kernel

theorem selectedBound5898 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env5899 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1345,262144,12617,32768,4096,41089,5457,70977,8328,5377,303492,4176,37204,113743,1284,4294967296,38213,4295065635,1344,512]

theorem envBound5899 : H12AffineFastState.Bounded env5899 := by
  intro p hp
  have h : env5899.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5898_5899 : H12AffineEnvironment.transform 13 4176 env5898 = env5899 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env5898 == env5899) = true)

theorem identity5899 : scanCanonicalize (H12AffineFastState.compose env5899 (packedSelected [13,21] rootPS)) = affineNative (2^(31+1) ^^^ 38208) := by decide +kernel

theorem selectedBound5899 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env5900 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1345,262144,12617,32768,4096,41089,5457,70977,8328,5377,303492,4176,37204,113743,1284,38208,38213,71011,1344,512]

theorem envBound5900 : H12AffineFastState.Bounded env5900 := by
  intro p hp
  have h : env5900.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5899_5900 : H12AffineEnvironment.transform 31 38208 env5899 = env5900 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 38208 env5899 == env5900) = true)

def env5901 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,134217728,67130625,536870912,1073741824,553878608,4294967296,537002320,4417151347,694534145,33563272]

theorem envBound5901 : H12AffineFastState.Bounded env5901 := by
  intro p hp
  have h : env5901.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5260_5901 : H12AffineEnvironment.transform 34 694534145 env5260 = env5901 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 34 694534145 env5260 == env5901) = true)

def env5902 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,134217728,67130625,157794304,1073741824,140788816,4294967296,157663568,4417151347,131073,33563272]

theorem envBound5902 : H12AffineFastState.Bounded env5902 := by
  intro p hp
  have h : env5902.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5901_5902 : H12AffineEnvironment.transform 28 157794304 env5901 = env5902 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 28 157794304 env5901 == env5902) = true)

theorem identity5902 : scanCanonicalize (H12AffineFastState.compose env5902 (packedSelected [14] rootPS)) = affineNative (2^(26+1) ^^^ 71582805) := by decide +kernel

theorem selectedBound5902 : packedSelected [14] rootPS < 2^1333 := by decide +kernel

def env5903 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,71582805,67130625,86213717,1073741824,69206021,4294967296,86082821,4417151347,131073,33563272]

theorem envBound5903 : H12AffineFastState.Bounded env5903 := by
  intro p hp
  have h : env5903.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5902_5903 : H12AffineEnvironment.transform 26 71582805 env5902 = env5903 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 71582805 env5902 == env5903) = true)

def env5904 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21776,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,71582805,67130625,86102341,1073741824,69206021,4294967296,86082821,4417151347,21777,33563272]

theorem envBound5904 : H12AffineFastState.Bounded env5904 := by
  intro p hp
  have h : env5904.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5903_5904 : H12AffineEnvironment.transform 16 21776 env5903 = env5904 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 21776 env5903 == env5904) = true)

theorem identity5904 : scanCanonicalize (H12AffineFastState.compose env5904 (packedSelected [5,8,13,17,21,24,26,28,31,33] rootPS)) = affineNative (2^(25+1) ^^^ 33580505) := by decide +kernel

theorem selectedBound5904 : packedSelected [5,8,13,17,21,24,26,28,31,33] rootPS < 2^1333 := by decide +kernel

def env5905 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21776,262144,524288,32768,2097152,4194304,17665,16777216,33554432,33580505,38019468,33566936,52540572,1073741824,35677660,4294967296,52551900,4316464298,21777,33563272]

theorem envBound5905 : H12AffineFastState.Bounded env5905 := by
  intro p hp
  have h : env5905.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5904_5905 : H12AffineEnvironment.transform 25 33580505 env5904 = env5905 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 33580505 env5904 == env5905) = true)

def env5906 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21776,262144,524288,32768,2097152,4194304,17665,16777216,2109576,2118993,6557956,2097232,16876564,1073741824,21844,4294967296,16896084,4316464298,21777,2101760]

theorem envBound5906 : H12AffineFastState.Bounded env5906 := by
  intro p hp
  have h : env5906.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5905_5906 : H12AffineEnvironment.transform 24 2109576 env5905 = env5906 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 2109576 env5905 == env5906) = true)

theorem identity5906 : scanCanonicalize (H12AffineFastState.compose env5906 (packedSelected [1,3,10,19,24,26,28,31,35] rootPS)) = affineNative (2^(23+1) ^^^ 98564) := by decide +kernel

theorem selectedBound5906 : packedSelected [1,3,10,19,24,26,28,31,35] rootPS < 2^1333 := by decide +kernel

def env5907 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21776,262144,524288,32768,2097152,4194304,17665,98564,2109576,2118993,6557956,2097232,1296,1073741824,21844,4294967296,20816,4299785646,21777,2101760]

theorem envBound5907 : H12AffineFastState.Bounded env5907 := by
  intro p hp
  have h : env5907.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5906_5907 : H12AffineEnvironment.transform 23 98564 env5906 = env5907 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98564 env5906 == env5907) = true)

theorem identity5907 : scanCanonicalize (H12AffineFastState.compose env5907 (packedSelected [1,4,6,7,9,16,19,20,25,27,28,31] rootPS)) = affineNative (2^(29+1) ^^^ 4820106) := by decide +kernel

theorem selectedBound5907 : packedSelected [1,4,6,7,9,16,19,20,25,27,28,31] rootPS < 2^1333 := by decide +kernel

def env5908 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21776,262144,524288,32768,2097152,4194304,17665,98564,2109576,2118993,6557956,2097232,1296,4820106,21844,4294967296,20816,4299785646,21777,2101760]

theorem envBound5908 : H12AffineFastState.Bounded env5908 := by
  intro p hp
  have h : env5908.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5907_5908 : H12AffineEnvironment.transform 29 4820106 env5907 = env5908 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4820106 env5907 == env5908) = true)

theorem identity5908 : scanCanonicalize (H12AffineFastState.compose env5908 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(13+1) ^^^ 4176) := by decide +kernel

theorem selectedBound5908 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env5909 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1344,262144,524288,32768,2097152,4194304,5457,98564,2109576,2098433,6557956,2097232,1296,4820106,1284,4294967296,256,4299785646,1345,2101760]

theorem envBound5909 : H12AffineFastState.Bounded env5909 := by
  intro p hp
  have h : env5909.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5908_5909 : H12AffineEnvironment.transform 13 4176 env5908 = env5909 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env5908 == env5909) = true)

def env5910 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1344,262144,524288,32768,4096,4194304,5457,98564,8328,5377,4456708,4176,1296,4820106,1284,4294967296,256,4299785646,1345,512]

theorem envBound5910 : H12AffineFastState.Bounded env5910 := by
  intro p hp
  have h : env5910.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5909_5910 : H12AffineEnvironment.transform 20 4096 env5909 = env5910 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env5909 == env5910) = true)

theorem identity5910 : scanCanonicalize (H12AffineFastState.compose env5910 (packedSelected [4,9,16] rootPS)) = affineNative (2^(21+1) ^^^ 396) := by decide +kernel

theorem selectedBound5910 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env5911 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1344,262144,524288,32768,4096,396,5457,98564,8328,5377,262280,4176,1296,625926,1284,4294967296,256,4295590946,1345,512]

theorem envBound5911 : H12AffineFastState.Bounded env5911 := by
  intro p hp
  have h : env5911.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5910_5911 : H12AffineEnvironment.transform 21 396 env5910 = env5911 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 396 env5910 == env5911) = true)

theorem identity5911 : scanCanonicalize (H12AffineFastState.compose env5911 (packedSelected [0,7,20] rootPS)) = affineNative (2^(18+1) ^^^ 34132) := by decide +kernel

theorem selectedBound5911 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env5912 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1344,262144,34132,32768,4096,396,5457,98564,8328,5377,262280,4176,1296,67666,1284,4294967296,256,4295033206,1345,512]

theorem envBound5912 : H12AffineFastState.Bounded env5912 := by
  intro p hp
  have h : env5912.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5911_5912 : H12AffineEnvironment.transform 18 34132 env5911 = env5912 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 34132 env5911 == env5912) = true)

theorem identity5912 : scanCanonicalize (H12AffineFastState.compose env5912 (packedSelected [1,3,5,6,8,12,15] rootPS)) = affineNative (2^(31+1) ^^^ 103778) := by decide +kernel

theorem selectedBound5912 : packedSelected [1,3,5,6,8,12,15] rootPS < 2^1333 := by decide +kernel

def env5913 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1344,262144,34132,32768,4096,396,5457,98564,8328,5377,262280,4176,1296,67666,1284,103778,256,37908,1345,512]

theorem envBound5913 : H12AffineFastState.Bounded env5913 := by
  intro p hp
  have h : env5913.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5912_5913 : H12AffineEnvironment.transform 31 103778 env5912 = env5913 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 103778 env5912 == env5913) = true)

theorem identity5913 : scanCanonicalize (H12AffineFastState.compose env5913 (packedSelected [9,22] rootPS)) = affineNative (2^(14+1) ^^^ 8460) := by decide +kernel

theorem selectedBound5913 : packedSelected [9,22] rootPS < 2^1333 := by decide +kernel

def env5914 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,8460,65536,1344,262144,9304,8460,4096,396,5457,73736,8328,5377,262280,4176,1296,67666,1284,78958,256,13592,1345,512]

theorem envBound5914 : H12AffineFastState.Bounded env5914 := by
  intro p hp
  have h : env5914.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5913_5914 : H12AffineEnvironment.transform 14 8460 env5913 = env5914 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8460 env5913 == env5914) = true)

theorem identity5914 : scanCanonicalize (H12AffineFastState.compose env5914 (packedSelected [1,3,5,12,13,24] rootPS)) = affineNative (2^(11+1) ^^^ 324) := by decide +kernel

theorem selectedBound5914 : packedSelected [1,3,5,12,13,24] rootPS < 2^1333 := by decide +kernel

def env5915 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,324,8192,276,8460,65536,1344,262144,9304,8460,324,396,1045,73736,8328,1093,262280,276,1296,67666,1284,75050,256,9308,1345,512]

theorem envBound5915 : H12AffineFastState.Bounded env5915 := by
  intro p hp
  have h : env5915.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5914_5915 : H12AffineEnvironment.transform 11 324 env5914 = env5915 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 324 env5914 == env5915) = true)

theorem identity5915 : scanCanonicalize (H12AffineFastState.compose env5915 (packedSelected [1,5,10,12,13,26] rootPS)) = affineNative (2^(12+1) ^^^ 88) := by decide +kernel

theorem selectedBound5915 : packedSelected [1,5,10,12,13,26] rootPS < 2^1333 := by decide +kernel

def env5916 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,324,88,276,340,65536,1344,262144,1024,340,324,396,1045,65616,208,1093,262280,276,1296,67666,1284,66930,256,1028,1345,512]

theorem envBound5916 : H12AffineFastState.Bounded env5916 := by
  intro p hp
  have h : env5916.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5915_5916 : H12AffineEnvironment.transform 12 88 env5915 = env5916 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 88 env5915 == env5916) = true)

theorem identity5916 : scanCanonicalize (H12AffineFastState.compose env5916 (packedSelected [3,5,10] rootPS)) = affineNative (2^(9+1) ^^^ 4) := by decide +kernel

theorem selectedBound5916 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env5917 : List Nat := [2,4,8,16,32,64,128,256,512,4,2048,324,88,276,340,65536,324,262144,4,340,324,396,17,65616,208,65,262280,276,276,67666,256,65910,256,0,325,512]

theorem envBound5917 : H12AffineFastState.Bounded env5917 := by
  intro p hp
  have h : env5917.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5916_5917 : H12AffineEnvironment.transform 9 4 env5916 = env5917 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 4 env5916 == env5917) = true)

theorem identity5917 : scanCanonicalize (H12AffineFastState.compose env5917 (packedSelected [8,13] rootPS)) = affineNative (2^(17+1) ^^^ 66136) := by decide +kernel

theorem selectedBound5917 : packedSelected [8,13] rootPS < 2^1333 := by decide +kernel

def env5918 : List Nat := [2,4,8,16,32,64,128,256,512,4,2048,324,88,276,340,65536,324,66136,4,340,324,396,17,65616,208,65,66256,276,276,67666,256,65910,256,0,325,512]

theorem envBound5918 : H12AffineFastState.Bounded env5918 := by
  intro p hp
  have h : env5918.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5917_5918 : H12AffineEnvironment.transform 17 66136 env5917 = env5918 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 66136 env5917 == env5918) = true)

def env5919 : List Nat := [2,4,8,16,32,64,8,256,512,4,2048,324,88,276,340,65536,324,66136,4,340,324,260,17,65616,88,65,66136,276,276,67666,256,65910,256,0,325,512]

theorem envBound5919 : H12AffineFastState.Bounded env5919 := by
  intro p hp
  have h : env5919.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5918_5919 : H12AffineEnvironment.transform 6 8 env5918 = env5919 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env5918 == env5919) = true)

theorem identity5919 : scanCanonicalize (H12AffineFastState.compose env5919 (packedSelected [7] rootPS)) = affineNative (2^(8+1) ^^^ 348) := by decide +kernel

theorem selectedBound5919 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env5920 : List Nat := [2,4,8,16,32,64,8,256,348,4,2048,324,88,276,340,65536,324,65796,4,340,324,260,17,65616,88,65,65796,276,276,67666,256,65910,256,0,325,348]

theorem envBound5920 : H12AffineFastState.Bounded env5920 := by
  intro p hp
  have h : env5920.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5919_5920 : H12AffineEnvironment.transform 8 348 env5919 = env5920 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 348 env5919 == env5920) = true)

def env5921 : List Nat := [2,4,8,16,32,64,8,256,348,4,0,324,88,276,340,65536,324,65796,4,340,324,260,17,65616,88,65,65796,276,276,65618,256,65910,256,0,325,348]

theorem envBound5921 : H12AffineFastState.Bounded env5921 := by
  intro p hp
  have h : env5921.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5920_5921 : H12AffineEnvironment.transform 10 0 env5920 = env5921 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env5920 == env5921) = true)

theorem identity5921 : scanCanonicalize (H12AffineFastState.compose env5921 (packedSelected [0] rootPS)) = affineNative (2^(5+1) ^^^ 50) := by decide +kernel

theorem selectedBound5921 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5922 : List Nat := [2,4,8,16,32,50,8,256,302,4,0,310,42,276,294,65536,310,65796,4,294,310,260,17,65570,42,51,65796,276,276,65568,256,65796,256,0,311,302]

theorem envBound5922 : H12AffineFastState.Bounded env5922 := by
  intro p hp
  have h : env5922.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5921_5922 : H12AffineEnvironment.transform 5 50 env5921 = env5922 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 50 env5921 == env5922) = true)

theorem identity5922 : scanCanonicalize (H12AffineFastState.compose env5922 (packedSelected [18,23] rootPS)) = affineNative (2^(15+1) ^^^ 32) := by decide +kernel

theorem selectedBound5922 : packedSelected [18,23] rootPS < 2^1333 := by decide +kernel

def env5923 : List Nat := [2,4,8,16,32,50,8,256,302,4,0,310,42,276,294,32,310,292,4,294,310,260,17,2,42,51,292,276,276,0,256,292,256,0,311,302]

theorem envBound5923 : H12AffineFastState.Bounded env5923 := by
  intro p hp
  have h : env5923.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5922_5923 : H12AffineEnvironment.transform 15 32 env5922 = env5923 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 32 env5922 == env5923) = true)

def env5924 : List Nat := [2,4,8,16,0,18,8,256,270,4,0,278,10,276,262,0,278,260,4,262,278,260,17,2,10,19,260,276,276,0,256,260,256,0,279,270]

theorem envBound5924 : H12AffineFastState.Bounded env5924 := by
  intro p hp
  have h : env5924.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5923_5924 : H12AffineEnvironment.transform 4 0 env5923 = env5924 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5923 == env5924) = true)

theorem identity5924 : scanCanonicalize (H12AffineFastState.compose env5924 (packedSelected [2] rootPS)) = affineNative (2^(7+1) ^^^ 14) := by decide +kernel

theorem selectedBound5924 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5925 : List Nat := [2,4,8,16,0,18,8,14,0,4,0,24,10,26,8,0,24,10,4,8,24,10,17,2,10,19,10,26,26,0,14,10,14,0,25,0]

theorem envBound5925 : H12AffineFastState.Bounded env5925 := by
  intro p hp
  have h : env5925.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5924_5925 : H12AffineEnvironment.transform 7 14 env5924 = env5925 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 14 env5924 == env5925) = true)

def env5926 : List Nat := [2,4,0,16,0,18,0,6,0,4,0,16,2,18,0,0,16,2,4,0,16,2,17,2,2,19,2,18,18,0,6,2,6,0,17,0]

theorem envBound5926 : H12AffineFastState.Bounded env5926 := by
  intro p hp
  have h : env5926.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5925_5926 : H12AffineEnvironment.transform 2 0 env5925 = env5926 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env5925 == env5926) = true)

def leafEnv5926 : List Nat := [2,4,0,16,0,18,0,6,0,4,0,16,2,18,0,0,16,2,4,0,16,2,17,2,6,2,1,19,2,18,18,0,6,2,6,0,4,0,17,0,0,19,1]

def active5926 : List Nat := [0,1,3]

def tree5926 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5926 : H12WitnessSearch.Good tree5926 := H12GlobalWitnessIndex.good

theorem leafIdentity5926 : H12AffineFastState.composeSystem env5926 rootObs = leafEnv5926 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5926 rootObs == leafEnv5926) = true)

theorem terminalChecked5926 : H12PackedTerminal.terminalCheckFast leafEnv5926 active5926 tree5926 = true := by decide +kernel

def env5927 : List Nat := [2,4,1,16,0,18,1,7,0,4,0,17,3,19,1,0,17,3,4,1,17,3,17,2,3,19,3,19,19,0,7,3,7,0,16,0]

theorem envBound5927 : H12AffineFastState.Bounded env5927 := by
  intro p hp
  have h : env5927.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5925_5927 : H12AffineEnvironment.transform 2 1 env5925 = env5927 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env5925 == env5927) = true)

theorem identity5927 : scanCanonicalize (H12AffineFastState.compose env5927 (packedSelected [4] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5927 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env5928 : List Nat := [0,4,1,16,0,16,1,5,0,4,0,17,1,17,1,0,17,1,4,1,17,1,17,0,1,17,1,17,17,0,5,1,5,0,16,0]

theorem envBound5928 : H12AffineFastState.Bounded env5928 := by
  intro p hp
  have h : env5928.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5927_5928 : H12AffineEnvironment.transform 0 0 env5927 = env5928 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5927 == env5928) = true)

def leafEnv5928 : List Nat := [0,4,1,16,0,16,1,5,0,4,0,17,1,17,1,0,17,1,4,1,17,1,17,0,5,1,1,17,1,17,17,0,5,1,5,0,4,0,16,0,0,16,1]

def active5928 : List Nat := [1,3]

def tree5928 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5928 : H12WitnessSearch.Good tree5928 := H12GlobalWitnessIndex.good

theorem leafIdentity5928 : H12AffineFastState.composeSystem env5928 rootObs = leafEnv5928 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5928 rootObs == leafEnv5928) = true)

theorem terminalChecked5928 : H12PackedTerminal.terminalCheckFast leafEnv5928 active5928 tree5928 = true := by decide +kernel

def env5929 : List Nat := [2,4,8,16,1,19,8,256,271,4,0,279,11,276,263,1,279,261,4,263,279,260,17,2,11,18,261,276,276,0,256,261,256,0,278,271]

theorem envBound5929 : H12AffineFastState.Bounded env5929 := by
  intro p hp
  have h : env5929.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5923_5929 : H12AffineEnvironment.transform 4 1 env5923 = env5929 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env5923 == env5929) = true)

theorem identity5929 : scanCanonicalize (H12AffineFastState.compose env5929 (packedSelected [1] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5929 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5930 : List Nat := [0,4,8,16,1,17,8,256,269,4,0,277,9,276,261,1,277,261,4,261,277,260,17,0,9,16,261,276,276,0,256,261,256,0,276,269]

theorem envBound5930 : H12AffineFastState.Bounded env5930 := by
  intro p hp
  have h : env5930.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5929_5930 : H12AffineEnvironment.transform 0 0 env5929 = env5930 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5929 == env5930) = true)

theorem identity5930 : scanCanonicalize (H12AffineFastState.compose env5930 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 1) := by decide +kernel

theorem selectedBound5930 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5931 : List Nat := [0,4,1,16,1,17,1,256,260,4,0,277,0,276,261,1,277,261,4,261,277,260,17,0,0,16,261,276,276,0,256,261,256,0,276,260]

theorem envBound5931 : H12AffineFastState.Bounded env5931 := by
  intro p hp
  have h : env5931.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5930_5931 : H12AffineEnvironment.transform 2 1 env5930 = env5931 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env5930 == env5931) = true)

def leafEnv5931 : List Nat := [0,4,1,16,1,17,1,256,260,4,0,277,0,276,261,1,277,261,4,261,277,260,17,0,256,0,1,16,261,276,276,0,256,261,256,0,4,1,276,260,0,277,1]

def active5931 : List Nat := [1,3,7]

def tree5931 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5931 : H12WitnessSearch.Good tree5931 := H12GlobalWitnessIndex.good

theorem leafIdentity5931 : H12AffineFastState.composeSystem env5931 rootObs = leafEnv5931 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5931 rootObs == leafEnv5931) = true)

theorem terminalChecked5931 : H12PackedTerminal.terminalCheckFast leafEnv5931 active5931 tree5931 = true := by decide +kernel

def env5932 : List Nat := [2,4,8,16,32,64,8,256,348,4,1,324,88,276,340,65536,324,65796,4,340,324,260,17,65616,88,65,65796,276,276,65619,256,65910,256,0,325,348]

theorem envBound5932 : H12AffineFastState.Bounded env5932 := by
  intro p hp
  have h : env5932.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5920_5932 : H12AffineEnvironment.transform 10 1 env5920 = env5932 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env5920 == env5932) = true)

theorem identity5932 : scanCanonicalize (H12AffineFastState.compose env5932 (packedSelected [0] rootPS)) = affineNative (2^(15+1) ^^^ 33) := by decide +kernel

theorem selectedBound5932 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5933 : List Nat := [2,4,8,16,32,64,8,256,348,4,1,324,88,276,340,33,324,293,4,340,324,260,17,113,88,65,293,276,276,114,256,343,256,0,325,348]

theorem envBound5933 : H12AffineFastState.Bounded env5933 := by
  intro p hp
  have h : env5933.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5932_5933 : H12AffineEnvironment.transform 15 33 env5932 = env5933 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33 env5932 == env5933) = true)

theorem identity5933 : scanCanonicalize (H12AffineFastState.compose env5933 (packedSelected [11,32] rootPS)) = affineNative (2^(5+1) ^^^ 51) := by decide +kernel

theorem selectedBound5933 : packedSelected [11,32] rootPS < 2^1333 := by decide +kernel

def env5934 : List Nat := [2,4,8,16,32,51,8,256,303,4,1,311,43,276,295,33,311,293,4,295,311,260,17,2,43,50,293,276,276,1,256,292,256,0,310,303]

theorem envBound5934 : H12AffineFastState.Bounded env5934 := by
  intro p hp
  have h : env5934.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5933_5934 : H12AffineEnvironment.transform 5 51 env5933 = env5934 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 51 env5933 == env5934) = true)

def env5935 : List Nat := [2,4,8,16,0,19,8,256,271,4,1,279,11,276,263,1,279,261,4,263,279,260,17,2,11,18,261,276,276,1,256,260,256,0,278,271]

theorem envBound5935 : H12AffineFastState.Bounded env5935 := by
  intro p hp
  have h : env5935.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5934_5935 : H12AffineEnvironment.transform 4 0 env5934 = env5935 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5934 == env5935) = true)

theorem identity5935 : scanCanonicalize (H12AffineFastState.compose env5935 (packedSelected [1] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5935 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5936 : List Nat := [0,4,8,16,0,17,8,256,269,4,1,277,9,276,261,1,277,261,4,261,277,260,17,0,9,16,261,276,276,1,256,260,256,0,276,269]

theorem envBound5936 : H12AffineFastState.Bounded env5936 := by
  intro p hp
  have h : env5936.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5935_5936 : H12AffineEnvironment.transform 0 0 env5935 = env5936 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5935 == env5936) = true)

theorem identity5936 : scanCanonicalize (H12AffineFastState.compose env5936 (packedSelected [2] rootPS)) = affineNative (2^(7+1) ^^^ 13) := by decide +kernel

theorem selectedBound5936 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5937 : List Nat := [0,4,8,16,0,17,8,13,0,4,1,24,9,25,8,1,24,8,4,8,24,9,17,0,9,16,8,25,25,1,13,9,13,0,25,0]

theorem envBound5937 : H12AffineFastState.Bounded env5937 := by
  intro p hp
  have h : env5937.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5936_5937 : H12AffineEnvironment.transform 7 13 env5936 = env5937 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 13 env5936 == env5937) = true)

def leafEnv5937 : List Nat := [0,4,8,16,0,17,8,13,0,4,1,24,9,25,8,1,24,8,4,8,24,9,17,0,13,9,1,16,8,25,25,1,13,9,13,0,4,1,25,0,0,24,1]

def active5937 : List Nat := [1,2,3]

def tree5937 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5937 : H12WitnessSearch.Good tree5937 := H12GlobalWitnessIndex.good

theorem leafIdentity5937 : H12AffineFastState.composeSystem env5937 rootObs = leafEnv5937 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5937 rootObs == leafEnv5937) = true)

theorem terminalChecked5937 : H12PackedTerminal.terminalCheckFast leafEnv5937 active5937 tree5937 = true := by decide +kernel

def env5938 : List Nat := [2,4,8,16,1,18,8,256,270,4,1,278,10,276,262,0,278,260,4,262,278,260,17,2,10,19,260,276,276,1,256,261,256,0,279,270]

theorem envBound5938 : H12AffineFastState.Bounded env5938 := by
  intro p hp
  have h : env5938.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5934_5938 : H12AffineEnvironment.transform 4 1 env5934 = env5938 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env5934 == env5938) = true)

theorem identity5938 : scanCanonicalize (H12AffineFastState.compose env5938 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound5938 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5939 : List Nat := [2,4,2,16,1,18,2,256,260,4,1,278,0,276,262,0,278,260,4,262,278,260,17,2,0,19,260,276,276,1,256,261,256,0,279,260]

theorem envBound5939 : H12AffineFastState.Bounded env5939 := by
  intro p hp
  have h : env5939.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5938_5939 : H12AffineEnvironment.transform 2 2 env5938 = env5939 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env5938 == env5939) = true)

def env5940 : List Nat := [2,4,2,16,1,18,2,4,0,4,1,18,0,16,2,0,18,0,4,2,18,0,17,2,0,19,0,16,16,1,4,1,4,0,19,0]

theorem envBound5940 : H12AffineFastState.Bounded env5940 := by
  intro p hp
  have h : env5940.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5939_5940 : H12AffineEnvironment.transform 7 4 env5939 = env5940 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env5939 == env5940) = true)

def leafEnv5940 : List Nat := [2,4,2,16,1,18,2,4,0,4,1,18,0,16,2,0,18,0,4,2,18,0,17,2,4,0,1,19,0,16,16,1,4,1,4,0,4,0,19,0,0,17,1]

def active5940 : List Nat := [0,1,3]

def tree5940 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5940 : H12WitnessSearch.Good tree5940 := H12GlobalWitnessIndex.good

theorem leafIdentity5940 : H12AffineFastState.composeSystem env5940 rootObs = leafEnv5940 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5940 rootObs == leafEnv5940) = true)

theorem terminalChecked5940 : H12PackedTerminal.terminalCheckFast leafEnv5940 active5940 tree5940 = true := by decide +kernel

def env5941 : List Nat := [2,4,2,16,1,18,2,5,1,4,1,19,0,17,3,0,19,1,4,3,19,1,17,2,0,19,1,17,17,1,5,0,5,0,18,1]

theorem envBound5941 : H12AffineFastState.Bounded env5941 := by
  intro p hp
  have h : env5941.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5939_5941 : H12AffineEnvironment.transform 7 5 env5939 = env5941 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env5939 == env5941) = true)

theorem identity5941 : scanCanonicalize (H12AffineFastState.compose env5941 (packedSelected [4] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5941 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env5942 : List Nat := [0,4,0,16,1,16,0,5,1,4,1,17,0,17,1,0,17,1,4,1,17,1,17,0,0,17,1,17,17,1,5,0,5,0,16,1]

theorem envBound5942 : H12AffineFastState.Bounded env5942 := by
  intro p hp
  have h : env5942.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5941_5942 : H12AffineEnvironment.transform 0 0 env5941 = env5942 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5941 == env5942) = true)

def leafEnv5942 : List Nat := [0,4,0,16,1,16,0,5,1,4,1,17,0,17,1,0,17,1,4,1,17,1,17,0,5,0,1,17,1,17,17,1,5,0,5,0,4,0,16,1,0,16,1]

def active5942 : List Nat := [1,3]

def tree5942 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5942 : H12WitnessSearch.Good tree5942 := H12GlobalWitnessIndex.good

theorem leafIdentity5942 : H12AffineFastState.composeSystem env5942 rootObs = leafEnv5942 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5942 rootObs == leafEnv5942) = true)

theorem terminalChecked5942 : H12PackedTerminal.terminalCheckFast leafEnv5942 active5942 tree5942 = true := by decide +kernel

def env5943 : List Nat := [2,4,8,16,32,64,9,256,512,4,2048,324,88,276,340,65536,324,66136,4,340,324,261,17,65616,89,65,66137,276,276,67666,256,65910,256,0,325,512]

theorem envBound5943 : H12AffineFastState.Bounded env5943 := by
  intro p hp
  have h : env5943.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5918_5943 : H12AffineEnvironment.transform 6 9 env5918 = env5943 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env5918 == env5943) = true)

theorem identity5943 : scanCanonicalize (H12AffineFastState.compose env5943 (packedSelected [7] rootPS)) = affineNative (2^(15+1) ^^^ 81) := by decide +kernel

theorem selectedBound5943 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env5944 : List Nat := [2,4,8,16,32,64,9,256,512,4,2048,324,88,276,340,81,324,521,4,340,324,261,17,1,89,65,520,276,276,2051,256,295,256,0,325,512]

theorem envBound5944 : H12AffineFastState.Bounded env5944 := by
  intro p hp
  have h : env5944.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5943_5944 : H12AffineEnvironment.transform 15 81 env5943 = env5944 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 81 env5943 == env5944) = true)

def env5945 : List Nat := [2,4,8,16,32,64,9,256,512,4,0,324,88,276,340,81,324,521,4,340,324,261,17,1,89,65,520,276,276,3,256,295,256,0,325,512]

theorem envBound5945 : H12AffineFastState.Bounded env5945 := by
  intro p hp
  have h : env5945.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5944_5945 : H12AffineEnvironment.transform 10 0 env5944 = env5945 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env5944 == env5945) = true)

theorem identity5945 : scanCanonicalize (H12AffineFastState.compose env5945 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 38) := by decide +kernel

theorem selectedBound5945 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5946 : List Nat := [2,4,8,16,32,64,9,38,512,4,0,98,88,50,114,81,98,521,4,114,98,35,17,1,89,65,520,50,50,3,38,1,38,0,99,512]

theorem envBound5946 : H12AffineFastState.Bounded env5946 := by
  intro p hp
  have h : env5946.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5945_5946 : H12AffineEnvironment.transform 7 38 env5945 = env5946 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 38 env5945 == env5946) = true)

theorem identity5946 : scanCanonicalize (H12AffineFastState.compose env5946 (packedSelected [2,4] rootPS)) = affineNative (2^(8+1) ^^^ 11) := by decide +kernel

theorem selectedBound5946 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env5947 : List Nat := [2,4,8,16,32,64,9,38,11,4,0,98,88,50,114,81,98,2,4,114,98,35,17,1,89,65,3,50,50,3,38,1,38,0,99,11]

theorem envBound5947 : H12AffineFastState.Bounded env5947 := by
  intro p hp
  have h : env5947.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5946_5947 : H12AffineEnvironment.transform 8 11 env5946 = env5947 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 11 env5946 == env5947) = true)

theorem identity5947 : scanCanonicalize (H12AffineFastState.compose env5947 (packedSelected [2,9] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5947 : packedSelected [2,9] rootPS < 2^1333 := by decide +kernel

def env5948 : List Nat := [0,4,8,16,32,64,9,36,9,4,0,96,88,48,112,81,96,0,4,112,96,33,17,1,89,65,1,48,48,1,36,1,36,0,97,9]

theorem envBound5948 : H12AffineFastState.Bounded env5948 := by
  intro p hp
  have h : env5948.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5947_5948 : H12AffineEnvironment.transform 0 0 env5947 = env5948 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5947 == env5948) = true)

theorem identity5948 : scanCanonicalize (H12AffineFastState.compose env5948 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 0) := by decide +kernel

theorem selectedBound5948 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5949 : List Nat := [0,4,0,16,32,64,1,36,1,4,0,96,80,48,112,81,96,0,4,112,96,33,17,1,81,65,1,48,48,1,36,1,36,0,97,1]

theorem envBound5949 : H12AffineFastState.Bounded env5949 := by
  intro p hp
  have h : env5949.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5948_5949 : H12AffineEnvironment.transform 2 0 env5948 = env5949 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env5948 == env5949) = true)

theorem identity5949 : scanCanonicalize (H12AffineFastState.compose env5949 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound5949 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5950 : List Nat := [0,4,0,16,32,17,1,36,1,4,0,49,1,48,33,0,49,0,4,33,49,33,17,1,0,16,1,48,48,1,36,1,36,0,48,1]

theorem envBound5950 : H12AffineFastState.Bounded env5950 := by
  intro p hp
  have h : env5950.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5949_5950 : H12AffineEnvironment.transform 5 17 env5949 = env5950 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env5949 == env5950) = true)

def leafEnv5950 : List Nat := [0,4,0,16,32,17,1,36,1,4,0,49,1,48,33,0,49,0,4,33,49,33,17,1,36,0,1,16,1,48,48,1,36,1,36,0,4,1,48,1,0,49,1]

def active5950 : List Nat := [1,3,4]

def tree5950 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5950 : H12WitnessSearch.Good tree5950 := H12GlobalWitnessIndex.good

theorem leafIdentity5950 : H12AffineFastState.composeSystem env5950 rootObs = leafEnv5950 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5950 rootObs == leafEnv5950) = true)

theorem terminalChecked5950 : H12PackedTerminal.terminalCheckFast leafEnv5950 active5950 tree5950 = true := by decide +kernel

def env5951 : List Nat := [2,4,8,16,32,64,9,256,512,4,1,324,88,276,340,81,324,521,4,340,324,261,17,1,89,65,520,276,276,2,256,295,256,0,325,512]

theorem envBound5951 : H12AffineFastState.Bounded env5951 := by
  intro p hp
  have h : env5951.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5944_5951 : H12AffineEnvironment.transform 10 1 env5944 = env5951 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env5944 == env5951) = true)

theorem identity5951 : scanCanonicalize (H12AffineFastState.compose env5951 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound5951 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5952 : List Nat := [2,4,8,16,32,64,9,36,512,4,1,96,88,48,112,81,96,521,4,112,96,33,17,1,89,65,520,48,48,2,36,3,36,0,97,512]

theorem envBound5952 : H12AffineFastState.Bounded env5952 := by
  intro p hp
  have h : env5952.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5951_5952 : H12AffineEnvironment.transform 7 36 env5951 = env5952 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env5951 == env5952) = true)

theorem identity5952 : scanCanonicalize (H12AffineFastState.compose env5952 (packedSelected [2,5,8] rootPS)) = affineNative (2^(8+1) ^^^ 1) := by decide +kernel

theorem selectedBound5952 : packedSelected [2,5,8] rootPS < 2^1333 := by decide +kernel

def env5953 : List Nat := [2,4,8,16,32,64,9,36,1,4,1,96,88,48,112,81,96,8,4,112,96,33,17,1,89,65,9,48,48,2,36,3,36,0,97,1]

theorem envBound5953 : H12AffineFastState.Bounded env5953 := by
  intro p hp
  have h : env5953.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5952_5953 : H12AffineEnvironment.transform 8 1 env5952 = env5953 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 1 env5952 == env5953) = true)

theorem identity5953 : scanCanonicalize (H12AffineFastState.compose env5953 (packedSelected [2,4,11,23] rootPS)) = affineNative (2^(2+1) ^^^ 1) := by decide +kernel

theorem selectedBound5953 : packedSelected [2,4,11,23] rootPS < 2^1333 := by decide +kernel

def env5954 : List Nat := [2,4,1,16,32,64,0,36,1,4,1,96,81,48,112,81,96,1,4,112,96,33,17,1,80,65,0,48,48,2,36,3,36,0,97,1]

theorem envBound5954 : H12AffineFastState.Bounded env5954 := by
  intro p hp
  have h : env5954.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5953_5954 : H12AffineEnvironment.transform 2 1 env5953 = env5954 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env5953 == env5954) = true)

theorem identity5954 : scanCanonicalize (H12AffineFastState.compose env5954 (packedSelected [11] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound5954 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env5955 : List Nat := [0,4,1,16,32,64,0,36,1,4,1,96,81,48,112,81,96,1,4,112,96,33,17,1,80,65,0,48,48,0,36,1,36,0,97,1]

theorem envBound5955 : H12AffineFastState.Bounded env5955 := by
  intro p hp
  have h : env5955.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5954_5955 : H12AffineEnvironment.transform 0 0 env5954 = env5955 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env5954 == env5955) = true)

theorem identity5955 : scanCanonicalize (H12AffineFastState.compose env5955 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound5955 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5956 : List Nat := [0,4,1,16,32,17,0,36,1,4,1,49,0,48,33,0,49,1,4,33,49,33,17,1,1,16,0,48,48,0,36,1,36,0,48,1]

theorem envBound5956 : H12AffineFastState.Bounded env5956 := by
  intro p hp
  have h : env5956.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5955_5956 : H12AffineEnvironment.transform 5 17 env5955 = env5956 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env5955 == env5956) = true)

def leafEnv5956 : List Nat := [0,4,1,16,32,17,0,36,1,4,1,49,0,48,33,0,49,1,4,33,49,33,17,1,36,1,1,16,0,48,48,0,36,1,36,0,4,1,48,1,0,49,1]

def active5956 : List Nat := [1,3,4]

def tree5956 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5956 : H12WitnessSearch.Good tree5956 := H12GlobalWitnessIndex.good

theorem leafIdentity5956 : H12AffineFastState.composeSystem env5956 rootObs = leafEnv5956 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5956 rootObs == leafEnv5956) = true)

theorem terminalChecked5956 : H12PackedTerminal.terminalCheckFast leafEnv5956 active5956 tree5956 = true := by decide +kernel

def env5957 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1344,262144,524288,32768,4097,4194304,5457,98564,8329,5376,4456709,4177,1296,4820106,1284,4294967296,256,4299785646,1345,513]

theorem envBound5957 : H12AffineFastState.Bounded env5957 := by
  intro p hp
  have h : env5957.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5909_5957 : H12AffineEnvironment.transform 20 4097 env5909 = env5957 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env5909 == env5957) = true)

theorem identity5957 : scanCanonicalize (H12AffineFastState.compose env5957 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(18+1) ^^^ 100102) := by decide +kernel

theorem selectedBound5957 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env5958 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,1344,262144,100102,32768,4097,4194304,5457,98564,8329,5376,4456709,4177,1296,4197260,1284,4294967296,256,4299162280,1345,513]

theorem envBound5958 : H12AffineFastState.Bounded env5958 := by
  intro p hp
  have h : env5958.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5957_5958 : H12AffineEnvironment.transform 18 100102 env5957 = env5958 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 100102 env5957 == env5958) = true)

theorem identity5958 : scanCanonicalize (H12AffineFastState.compose env5958 (packedSelected [0,7,20] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound5958 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env5959 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,4096,8192,4176,32768,65536,1344,262144,99726,32768,4097,4194304,5457,98564,8329,5376,4456709,4177,1296,4196612,1284,4294967296,256,4299161632,1345,137]

theorem envBound5959 : H12AffineFastState.Bounded env5959 := by
  intro p hp
  have h : env5959.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5958_5959 : H12AffineEnvironment.transform 8 136 env5958 = env5959 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env5958 == env5959) = true)

theorem identity5959 : scanCanonicalize (H12AffineFastState.compose env5959 (packedSelected [5,8] rootPS)) = affineNative (2^(17+1) ^^^ 43049) := by decide +kernel

theorem selectedBound5959 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env5960 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,4096,8192,4176,32768,65536,1344,43049,99726,32768,4097,4194304,5457,98564,8329,5376,4237612,4177,1296,4196612,1284,4294967296,256,4299161632,1345,137]

theorem envBound5960 : H12AffineFastState.Bounded env5960 := by
  intro p hp
  have h : env5960.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5959_5960 : H12AffineEnvironment.transform 17 43049 env5959 = env5960 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43049 env5959 == env5960) = true)

def env5961 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,4096,8192,4176,32768,65536,1344,43049,99726,32768,4097,10248,5457,98564,8329,5376,33060,4177,1296,8460,1284,4294967296,256,4294977576,1345,137]

theorem envBound5961 : H12AffineFastState.Bounded env5961 := by
  intro p hp
  have h : env5961.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5960_5961 : H12AffineEnvironment.transform 21 10248 env5960 = env5961 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10248 env5960 == env5961) = true)

theorem identity5961 : scanCanonicalize (H12AffineFastState.compose env5961 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(12+1) ^^^ 7196) := by decide +kernel

theorem selectedBound5961 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env5962 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,4096,7196,4176,32768,65536,1344,37941,99726,32768,4097,5140,5457,98564,7317,5376,33060,4177,1296,7440,1284,4294967296,256,4294972468,1345,137]

theorem envBound5962 : H12AffineFastState.Bounded env5962 := by
  intro p hp
  have h : env5962.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5961_5962 : H12AffineEnvironment.transform 12 7196 env5961 = env5962 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 7196 env5961 == env5962) = true)

def env5963 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,4096,7196,4176,2524,65536,1344,7657,68690,2524,4097,5140,5457,67800,7317,5376,2296,4177,1296,7440,1284,4294967296,256,4294972468,1345,137]

theorem envBound5963 : H12AffineFastState.Bounded env5963 := by
  intro p hp
  have h : env5963.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5962_5963 : H12AffineEnvironment.transform 14 2524 env5962 = env5963 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2524 env5962 == env5963) = true)

theorem identity5963 : scanCanonicalize (H12AffineFastState.compose env5963 (packedSelected [5] rootPS)) = affineNative (2^(11+1) ^^^ 1076) := by decide +kernel

theorem selectedBound5963 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env5964 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,1076,2088,1124,2524,65536,1344,2525,68690,2524,1077,32,357,67800,2209,308,2296,1125,1296,2340,1284,4294967296,256,4294967296,1345,137]

theorem envBound5964 : H12AffineFastState.Bounded env5964 := by
  intro p hp
  have h : env5964.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5963_5964 : H12AffineEnvironment.transform 11 1076 env5963 = env5964 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1076 env5963 == env5964) = true)

theorem identity5964 : scanCanonicalize (H12AffineFastState.compose env5964 (packedSelected [0,1,2,4,7,10,12] rootPS)) = affineNative (2^(7+1) ^^^ 220) := by decide +kernel

theorem selectedBound5964 : packedSelected [0,1,2,4,7,10,12] rootPS < 2^1333 := by decide +kernel

def env5965 : List Nat := [2,4,8,16,32,64,128,220,136,1024,2048,1076,2088,1124,2048,65536,1180,2049,68690,2048,1077,32,185,67800,2209,232,2296,1125,1228,2296,1240,4294967296,220,4294967296,1181,137]

theorem envBound5965 : H12AffineFastState.Bounded env5965 := by
  intro p hp
  have h : env5965.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5964_5965 : H12AffineEnvironment.transform 7 220 env5964 = env5965 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 220 env5964 == env5965) = true)

theorem identity5965 : scanCanonicalize (H12AffineFastState.compose env5965 (packedSelected [0,7] rootPS)) = affineNative (2^(6+1) ^^^ 120) := by decide +kernel

theorem selectedBound5965 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env5966 : List Nat := [2,4,8,16,32,64,120,36,112,1024,2048,1076,2088,1124,2048,65536,1124,2049,68690,2048,1077,32,65,67616,2137,16,2048,1125,1076,2048,1056,4294967296,36,4294967296,1125,113]

theorem envBound5966 : H12AffineFastState.Bounded env5966 := by
  intro p hp
  have h : env5966.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5965_5966 : H12AffineEnvironment.transform 6 120 env5965 = env5966 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 120 env5965 == env5966) = true)

theorem identity5966 : scanCanonicalize (H12AffineFastState.compose env5966 (packedSelected [2] rootPS)) = affineNative (2^(31+1) ^^^ 48) := by decide +kernel

theorem selectedBound5966 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5967 : List Nat := [2,4,8,16,32,64,120,36,112,1024,2048,1076,2088,1124,2048,65536,1124,2049,68690,2048,1077,32,65,67616,2137,16,2048,1125,1076,2048,1056,48,36,48,1125,113]

theorem envBound5967 : H12AffineFastState.Bounded env5967 := by
  intro p hp
  have h : env5967.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5966_5967 : H12AffineEnvironment.transform 31 48 env5966 = env5967 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 48 env5966 == env5967) = true)

def env5968 : List Nat := [2,4,8,16,32,64,120,36,112,1024,0,1076,40,1124,0,65536,1124,1,66642,0,1077,32,65,65568,89,16,0,1125,1076,0,1056,48,36,48,1125,113]

theorem envBound5968 : H12AffineFastState.Bounded env5968 := by
  intro p hp
  have h : env5968.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5967_5968 : H12AffineEnvironment.transform 10 0 env5967 = env5968 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env5967 == env5968) = true)

theorem identity5968 : scanCanonicalize (H12AffineFastState.compose env5968 (packedSelected [0] rootPS)) = affineNative (2^(15+1) ^^^ 56) := by decide +kernel

theorem selectedBound5968 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5969 : List Nat := [2,4,8,16,32,64,120,36,112,1024,0,1076,40,1124,0,56,1124,1,1130,0,1077,32,65,24,89,16,0,1125,1076,0,1056,48,36,48,1125,113]

theorem envBound5969 : H12AffineFastState.Bounded env5969 := by
  intro p hp
  have h : env5969.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5968_5969 : H12AffineEnvironment.transform 15 56 env5968 = env5969 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 56 env5968 == env5969) = true)

def env5970 : List Nat := [2,4,8,16,0,64,88,4,80,1024,0,1044,8,1092,0,24,1092,1,1098,0,1045,0,65,24,89,16,0,1093,1044,0,1024,16,4,16,1093,81]

theorem envBound5970 : H12AffineFastState.Bounded env5970 := by
  intro p hp
  have h : env5970.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5969_5970 : H12AffineEnvironment.transform 4 0 env5969 = env5970 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5969 == env5970) = true)

def leafEnv5970 : List Nat := [2,4,8,16,0,64,88,4,80,1024,0,1044,8,1092,0,24,1092,1,1098,0,1045,0,65,24,1098,89,1,16,0,1093,1044,0,1024,16,4,16,4,3,1093,81,0,1045,1]

def active5970 : List Nat := [0,1,2,3,5,9]

def tree5970 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5970 : H12WitnessSearch.Good tree5970 := H12GlobalWitnessIndex.good

theorem leafIdentity5970 : H12AffineFastState.composeSystem env5970 rootObs = leafEnv5970 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5970 rootObs == leafEnv5970) = true)

theorem terminalChecked5970 : H12PackedTerminal.terminalCheckFast leafEnv5970 active5970 tree5970 = true := by decide +kernel

def env5971 : List Nat := [2,4,8,16,1,64,89,5,81,1024,0,1045,9,1093,0,25,1093,1,1099,0,1044,1,65,24,89,16,0,1092,1045,0,1025,17,5,17,1092,80]

theorem envBound5971 : H12AffineFastState.Bounded env5971 := by
  intro p hp
  have h : env5971.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5969_5971 : H12AffineEnvironment.transform 4 1 env5969 = env5971 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env5969 == env5971) = true)

theorem identity5971 : scanCanonicalize (H12AffineFastState.compose env5971 (packedSelected [3] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound5971 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env5972 : List Nat := [2,4,8,16,1,10,19,5,27,1024,0,1045,9,1039,0,25,1039,1,1025,0,1044,1,11,24,19,16,0,1038,1045,0,1025,17,5,17,1038,26]

theorem envBound5972 : H12AffineFastState.Bounded env5972 := by
  intro p hp
  have h : env5972.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5971_5972 : H12AffineEnvironment.transform 5 10 env5971 = env5972 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env5971 == env5972) = true)

def leafEnv5972 : List Nat := [2,4,8,16,1,10,19,5,27,1024,0,1045,9,1039,0,25,1039,1,1025,0,1044,1,11,24,1024,19,1,16,0,1038,1045,0,1025,17,5,17,4,2,1038,26,0,1044,1]

def active5972 : List Nat := [0,1,2,3,9]

def tree5972 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5972 : H12WitnessSearch.Good tree5972 := H12GlobalWitnessIndex.good

theorem leafIdentity5972 : H12AffineFastState.composeSystem env5972 rootObs = leafEnv5972 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5972 rootObs == leafEnv5972) = true)

theorem terminalChecked5972 : H12PackedTerminal.terminalCheckFast leafEnv5972 active5972 tree5972 = true := by decide +kernel

def env5973 : List Nat := [2,4,8,16,32,64,120,36,112,1024,1,1076,41,1124,1,65536,1124,0,66643,1,1077,32,65,65569,88,16,1,1125,1076,1,1056,48,36,48,1125,113]

theorem envBound5973 : H12AffineFastState.Bounded env5973 := by
  intro p hp
  have h : env5973.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5967_5973 : H12AffineEnvironment.transform 10 1 env5967 = env5973 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env5967 == env5973) = true)

theorem identity5973 : scanCanonicalize (H12AffineFastState.compose env5973 (packedSelected [0] rootPS)) = affineNative (2^(5+1) ^^^ 43) := by decide +kernel

theorem selectedBound5973 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5974 : List Nat := [2,4,8,16,32,43,19,36,27,1024,1,1076,41,1039,1,65536,1039,0,66616,1,1077,32,42,65569,51,16,1,1038,1076,1,1056,48,36,48,1038,26]

theorem envBound5974 : H12AffineFastState.Bounded env5974 := by
  intro p hp
  have h : env5974.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5973_5974 : H12AffineEnvironment.transform 5 43 env5973 = env5974 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 43 env5973 == env5974) = true)

theorem identity5974 : scanCanonicalize (H12AffineFastState.compose env5974 (packedSelected [1] rootPS)) = affineNative (2^(15+1) ^^^ 57) := by decide +kernel

theorem selectedBound5974 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5975 : List Nat := [2,4,8,16,32,43,19,36,27,1024,1,1076,41,1039,1,57,1039,0,1025,1,1077,32,42,24,51,16,1,1038,1076,1,1056,48,36,48,1038,26]

theorem envBound5975 : H12AffineFastState.Bounded env5975 := by
  intro p hp
  have h : env5975.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5974_5975 : H12AffineEnvironment.transform 15 57 env5974 = env5975 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 57 env5974 == env5975) = true)

def leafEnv5975 : List Nat := [2,4,8,16,32,43,19,36,27,1024,1,1076,41,1039,1,57,1039,0,1025,1,1077,32,42,24,1057,51,1,16,1,1038,1076,1,1056,48,36,48,4,34,1038,26,0,1077,1]

def active5975 : List Nat := [0,1,2,3,4,9]

def tree5975 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5975 : H12WitnessSearch.Good tree5975 := H12GlobalWitnessIndex.good

theorem leafIdentity5975 : H12AffineFastState.composeSystem env5975 rootObs = leafEnv5975 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5975 rootObs == leafEnv5975) = true)

theorem terminalChecked5975 : H12PackedTerminal.terminalCheckFast leafEnv5975 active5975 tree5975 = true := by decide +kernel

def env5976 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,4096,7196,4176,2525,65536,1344,7656,68691,2525,4097,5140,5457,67801,7317,5376,2297,4177,1296,7440,1284,4294967296,256,4294972468,1345,137]

theorem envBound5976 : H12AffineFastState.Bounded env5976 := by
  intro p hp
  have h : env5976.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5962_5976 : H12AffineEnvironment.transform 14 2525 env5962 = env5976 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2525 env5962 == env5976) = true)

theorem identity5976 : scanCanonicalize (H12AffineFastState.compose env5976 (packedSelected [5] rootPS)) = affineNative (2^(15+1) ^^^ 7270) := by decide +kernel

theorem selectedBound5976 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env5977 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,4096,7196,4176,2525,7270,1344,7656,4149,2525,4097,5140,5457,5311,7317,5376,2297,4177,1296,7440,1284,4294967296,256,4294972468,1345,137]

theorem envBound5977 : H12AffineFastState.Bounded env5977 := by
  intro p hp
  have h : env5977.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5976_5977 : H12AffineEnvironment.transform 15 7270 env5976 = env5977 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 7270 env5976 == env5977) = true)

theorem identity5977 : scanCanonicalize (H12AffineFastState.compose env5977 (packedSelected [0,1,2,4,7,10,12] rootPS)) = affineNative (2^(7+1) ^^^ 221) := by decide +kernel

theorem selectedBound5977 : packedSelected [0,1,2,4,7,10,12] rootPS < 2^1333 := by decide +kernel

def env5978 : List Nat := [2,4,8,16,32,64,128,221,136,1024,2048,4096,7196,4176,2048,7270,1181,7221,4149,2048,4097,5140,5260,5311,7317,5341,2297,4177,1229,7373,1241,4294967296,221,4294972468,1180,137]

theorem envBound5978 : H12AffineFastState.Bounded env5978 := by
  intro p hp
  have h : env5978.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5977_5978 : H12AffineEnvironment.transform 7 221 env5977 = env5978 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 221 env5977 == env5978) = true)

def env5979 : List Nat := [2,4,8,16,32,64,88,5,80,1024,2048,4096,7196,4176,2048,7270,1093,7221,4149,2048,4097,5140,5204,5223,7245,5125,2081,4177,1045,7189,1025,4294967296,5,4294972468,1092,81]

theorem envBound5979 : H12AffineFastState.Bounded env5979 := by
  intro p hp
  have h : env5979.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5978_5979 : H12AffineEnvironment.transform 6 88 env5978 = env5979 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env5978 == env5979) = true)

theorem identity5979 : scanCanonicalize (H12AffineFastState.compose env5979 (packedSelected [1,3] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound5979 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5980 : List Nat := [2,4,8,16,1,64,88,5,80,1024,2048,4096,7196,4176,2048,7239,1093,7188,4116,2048,4097,5140,5204,5190,7245,5125,2048,4177,1045,7189,1025,4294967296,5,4294972437,1092,81]

theorem envBound5980 : H12AffineFastState.Bounded env5980 := by
  intro p hp
  have h : env5980.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5979_5980 : H12AffineEnvironment.transform 4 1 env5979 = env5980 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env5979 == env5980) = true)

theorem identity5980 : scanCanonicalize (H12AffineFastState.compose env5980 (packedSelected [0,7] rootPS)) = affineNative (2^(11+1) ^^^ 1045) := by decide +kernel

theorem selectedBound5980 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env5981 : List Nat := [2,4,8,16,1,64,88,5,80,1024,2048,1045,2057,1093,2048,2130,1093,2049,1025,2048,1044,1,65,83,2136,16,2048,1092,1045,2048,1025,4294967296,5,4294967296,1092,81]

theorem envBound5981 : H12AffineFastState.Bounded env5981 := by
  intro p hp
  have h : env5981.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5980_5981 : H12AffineEnvironment.transform 11 1045 env5980 = env5981 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1045 env5980 == env5981) = true)

theorem identity5981 : scanCanonicalize (H12AffineFastState.compose env5981 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 90) := by decide +kernel

theorem selectedBound5981 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5982 : List Nat := [2,4,8,16,1,64,88,5,80,1024,2048,1045,2057,1093,2048,2130,1093,2049,1025,2048,1044,1,65,83,2136,16,2048,1092,1045,2048,1025,90,5,90,1092,81]

theorem envBound5982 : H12AffineFastState.Bounded env5982 := by
  intro p hp
  have h : env5982.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5981_5982 : H12AffineEnvironment.transform 31 90 env5981 = env5982 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 90 env5981 == env5982) = true)

theorem identity5982 : scanCanonicalize (H12AffineFastState.compose env5982 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound5982 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5983 : List Nat := [2,4,8,16,1,11,19,5,27,1024,2048,1045,2057,1038,2048,2073,1038,2049,1025,2048,1044,1,10,24,2067,16,2048,1039,1045,2048,1025,17,5,17,1039,26]

theorem envBound5983 : H12AffineFastState.Bounded env5983 := by
  intro p hp
  have h : env5983.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5982_5983 : H12AffineEnvironment.transform 5 11 env5982 = env5983 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env5982 == env5983) = true)

def leafEnv5983 : List Nat := [2,4,8,16,1,11,19,5,27,1024,2048,1045,2057,1038,2048,2073,1038,2049,1025,2048,1044,1,10,24,1024,2067,1,16,2048,1039,1045,2048,1025,17,5,17,4,2050,1039,26,0,1044,1]

def active5983 : List Nat := [0,1,2,3,9,10]

def tree5983 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5983 : H12WitnessSearch.Good tree5983 := H12GlobalWitnessIndex.good

theorem leafIdentity5983 : H12AffineFastState.composeSystem env5983 rootObs = leafEnv5983 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5983 rootObs == leafEnv5983) = true)

theorem terminalChecked5983 : H12PackedTerminal.terminalCheckFast leafEnv5983 active5983 tree5983 = true := by decide +kernel

def env5984 : List Nat := [2,4,8,16,32,64,89,4,81,1024,2048,4096,7196,4176,2048,7270,1092,7221,4149,2048,4097,5140,5205,5222,7244,5124,2080,4177,1044,7188,1024,4294967296,4,4294972468,1093,80]

theorem envBound5984 : H12AffineFastState.Bounded env5984 := by
  intro p hp
  have h : env5984.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5978_5984 : H12AffineEnvironment.transform 6 89 env5978 = env5984 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env5978 == env5984) = true)

theorem identity5984 : scanCanonicalize (H12AffineFastState.compose env5984 (packedSelected [1,3] rootPS)) = affineNative (2^(11+1) ^^^ 1044) := by decide +kernel

theorem selectedBound5984 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env5985 : List Nat := [2,4,8,16,32,64,89,4,81,1024,2048,1044,2056,1092,2048,2162,1092,2081,1057,2048,1045,0,65,114,2136,16,2080,1093,1044,2048,1024,4294967296,4,4294967328,1093,80]

theorem envBound5985 : H12AffineFastState.Bounded env5985 := by
  intro p hp
  have h : env5985.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5984_5985 : H12AffineEnvironment.transform 11 1044 env5984 = env5985 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1044 env5984 == env5985) = true)

theorem identity5985 : scanCanonicalize (H12AffineFastState.compose env5985 (packedSelected [0,7] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound5985 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env5986 : List Nat := [2,4,8,16,0,64,89,4,81,1024,2048,1044,2056,1092,2048,2130,1092,2049,1025,2048,1045,0,65,82,2136,16,2048,1093,1044,2048,1024,4294967296,4,4294967296,1093,80]

theorem envBound5986 : H12AffineFastState.Bounded env5986 := by
  intro p hp
  have h : env5986.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5985_5986 : H12AffineEnvironment.transform 4 0 env5985 = env5986 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5985 == env5986) = true)

theorem identity5986 : scanCanonicalize (H12AffineFastState.compose env5986 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 90) := by decide +kernel

theorem selectedBound5986 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5987 : List Nat := [2,4,8,16,0,64,89,4,81,1024,2048,1044,2056,1092,2048,2130,1092,2049,1025,2048,1045,0,65,82,2136,16,2048,1093,1044,2048,1024,90,4,90,1093,80]

theorem envBound5987 : H12AffineFastState.Bounded env5987 := by
  intro p hp
  have h : env5987.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5986_5987 : H12AffineEnvironment.transform 31 90 env5986 = env5987 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 90 env5986 == env5987) = true)

theorem identity5987 : scanCanonicalize (H12AffineFastState.compose env5987 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound5987 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env5988 : List Nat := [2,4,8,16,0,10,19,4,27,1024,2048,1044,2056,1038,2048,2072,1038,2049,1025,2048,1045,0,11,24,2066,16,2048,1039,1044,2048,1024,16,4,16,1039,26]

theorem envBound5988 : H12AffineFastState.Bounded env5988 := by
  intro p hp
  have h : env5988.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5987_5988 : H12AffineEnvironment.transform 5 10 env5987 = env5988 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env5987 == env5988) = true)

def leafEnv5988 : List Nat := [2,4,8,16,0,10,19,4,27,1024,2048,1044,2056,1038,2048,2072,1038,2049,1025,2048,1045,0,11,24,1025,2066,1,16,2048,1039,1044,2048,1024,16,4,16,4,2051,1039,26,0,1045,1]

def active5988 : List Nat := [0,1,2,3,9,10]

def tree5988 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5988 : H12WitnessSearch.Good tree5988 := H12GlobalWitnessIndex.good

theorem leafIdentity5988 : H12AffineFastState.composeSystem env5988 rootObs = leafEnv5988 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5988 rootObs == leafEnv5988) = true)

theorem terminalChecked5988 : H12PackedTerminal.terminalCheckFast leafEnv5988 active5988 tree5988 = true := by decide +kernel

def env5989 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,4096,8192,4176,32768,65536,1344,43049,99726,32768,4097,10249,5457,98564,8329,5376,33061,4177,1296,8461,1284,4294967296,256,4294977577,1345,137]

theorem envBound5989 : H12AffineFastState.Bounded env5989 := by
  intro p hp
  have h : env5989.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5960_5989 : H12AffineEnvironment.transform 21 10249 env5960 = env5989 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10249 env5960 == env5989) = true)

theorem identity5989 : scanCanonicalize (H12AffineFastState.compose env5989 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(14+1) ^^^ 13624) := by decide +kernel

theorem selectedBound5989 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env5990 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,4096,8192,4176,13624,65536,1344,7441,78006,13624,4097,10249,5457,78908,8329,5376,13341,4177,1296,8461,1284,4294967296,256,4294977577,1345,137]

theorem envBound5990 : H12AffineFastState.Bounded env5990 := by
  intro p hp
  have h : env5990.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5989_5990 : H12AffineEnvironment.transform 14 13624 env5989 = env5990 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13624 env5989 == env5990) = true)

theorem identity5990 : scanCanonicalize (H12AffineFastState.compose env5990 (packedSelected [1,2,4,12,13] rootPS)) = affineNative (2^(12+1) ^^^ 2317) := by decide +kernel

theorem selectedBound5990 : packedSelected [1,2,4,12,13] rootPS < 2^1333 := by decide +kernel

def env5991 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,4096,2317,4176,7221,65536,1344,7441,72123,7221,4097,260,5457,73009,2436,5376,7440,4177,1296,2048,1284,4294967296,256,4294967588,1345,137]

theorem envBound5991 : H12AffineFastState.Bounded env5991 := by
  intro p hp
  have h : env5991.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5990_5991 : H12AffineEnvironment.transform 12 2317 env5990 = env5991 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2317 env5990 == env5991) = true)

theorem identity5991 : scanCanonicalize (H12AffineFastState.compose env5991 (packedSelected [0,7] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound5991 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env5992 : List Nat := [2,4,8,16,32,64,128,256,136,1024,2048,1297,2317,1345,2340,65536,1344,2048,68778,2340,1296,260,64,67616,2436,17,2049,1344,1296,2048,1284,4294967296,256,4294967588,1345,137]

theorem envBound5992 : H12AffineFastState.Bounded env5992 := by
  intro p hp
  have h : env5992.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5991_5992 : H12AffineEnvironment.transform 11 1297 env5991 = env5992 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env5991 == env5992) = true)

def env5993 : List Nat := [2,4,8,16,32,64,120,256,112,1024,2048,1297,2317,1345,2340,65536,1344,2048,68690,2340,1296,260,64,67616,2428,17,2049,1344,1296,2048,1284,4294967296,256,4294967588,1345,113]

theorem envBound5993 : H12AffineFastState.Bounded env5993 := by
  intro p hp
  have h : env5993.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5992_5993 : H12AffineEnvironment.transform 6 120 env5992 = env5993 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 120 env5992 == env5993) = true)

theorem identity5993 : scanCanonicalize (H12AffineFastState.compose env5993 (packedSelected [5] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound5993 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env5994 : List Nat := [2,4,8,16,32,64,120,36,112,1024,2048,1077,2089,1125,2048,65536,1124,2048,68690,2048,1076,32,64,67616,2136,17,2049,1124,1076,2048,1056,4294967296,36,4294967296,1125,113]

theorem envBound5994 : H12AffineFastState.Bounded env5994 := by
  intro p hp
  have h : env5994.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5993_5994 : H12AffineEnvironment.transform 7 36 env5993 = env5994 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env5993 == env5994) = true)

theorem identity5994 : scanCanonicalize (H12AffineFastState.compose env5994 (packedSelected [2] rootPS)) = affineNative (2^(31+1) ^^^ 96) := by decide +kernel

theorem selectedBound5994 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env5995 : List Nat := [2,4,8,16,32,64,120,36,112,1024,2048,1077,2089,1125,2048,65536,1124,2048,68690,2048,1076,32,64,67616,2136,17,2049,1124,1076,2048,1056,96,36,96,1125,113]

theorem envBound5995 : H12AffineFastState.Bounded env5995 := by
  intro p hp
  have h : env5995.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5994_5995 : H12AffineEnvironment.transform 31 96 env5994 = env5995 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 96 env5994 == env5995) = true)

def env5996 : List Nat := [2,4,8,16,32,64,120,36,112,1024,0,1077,41,1125,0,65536,1124,0,66642,0,1076,32,64,65568,88,17,1,1124,1076,0,1056,96,36,96,1125,113]

theorem envBound5996 : H12AffineFastState.Bounded env5996 := by
  intro p hp
  have h : env5996.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5995_5996 : H12AffineEnvironment.transform 10 0 env5995 = env5996 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env5995 == env5996) = true)

theorem identity5996 : scanCanonicalize (H12AffineFastState.compose env5996 (packedSelected [0] rootPS)) = affineNative (2^(15+1) ^^^ 24) := by decide +kernel

theorem selectedBound5996 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env5997 : List Nat := [2,4,8,16,32,64,120,36,112,1024,0,1077,41,1125,0,24,1124,0,1098,0,1076,32,64,56,88,17,1,1124,1076,0,1056,96,36,96,1125,113]

theorem envBound5997 : H12AffineFastState.Bounded env5997 := by
  intro p hp
  have h : env5997.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5996_5997 : H12AffineEnvironment.transform 15 24 env5996 = env5997 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 24 env5996 == env5997) = true)

def env5998 : List Nat := [2,4,8,16,0,64,88,4,80,1024,0,1045,9,1093,0,24,1092,0,1098,0,1044,0,64,24,88,17,1,1092,1044,0,1024,64,4,64,1093,81]

theorem envBound5998 : H12AffineFastState.Bounded env5998 := by
  intro p hp
  have h : env5998.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5997_5998 : H12AffineEnvironment.transform 4 0 env5997 = env5998 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env5997 == env5998) = true)

def leafEnv5998 : List Nat := [2,4,8,16,0,64,88,4,80,1024,0,1045,9,1093,0,24,1092,0,1098,0,1044,0,64,24,1098,88,1,17,1,1092,1044,0,1024,64,4,64,4,3,1093,81,0,1045,1]

def active5998 : List Nat := [0,1,2,3,5,9]

def tree5998 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood5998 : H12WitnessSearch.Good tree5998 := H12GlobalWitnessIndex.good

theorem leafIdentity5998 : H12AffineFastState.composeSystem env5998 rootObs = leafEnv5998 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env5998 rootObs == leafEnv5998) = true)

theorem terminalChecked5998 : H12PackedTerminal.terminalCheckFast leafEnv5998 active5998 tree5998 = true := by decide +kernel

def env5999 : List Nat := [2,4,8,16,1,64,89,5,81,1024,0,1044,8,1092,0,24,1093,0,1098,0,1045,1,64,25,88,17,1,1093,1045,0,1025,65,5,65,1092,80]

theorem envBound5999 : H12AffineFastState.Bounded env5999 := by
  intro p hp
  have h : env5999.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5997_5999 : H12AffineEnvironment.transform 4 1 env5997 = env5999 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env5997 == env5999) = true)

theorem identity5999 : scanCanonicalize (H12AffineFastState.compose env5999 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound5999 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6000 : List Nat := [2,4,8,16,1,11,18,5,26,1024,0,1044,8,1039,0,24,1038,0,1025,0,1045,1,11,25,19,17,1,1038,1045,0,1025,10,5,10,1039,27]

theorem envBound6000 : H12AffineFastState.Bounded env6000 := by
  intro p hp
  have h : env6000.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5999_6000 : H12AffineEnvironment.transform 5 11 env5999 = env6000 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env5999 == env6000) = true)

def leafEnv6000 : List Nat := [2,4,8,16,1,11,18,5,26,1024,0,1044,8,1039,0,24,1038,0,1025,0,1045,1,11,25,1024,19,1,17,1,1038,1045,0,1025,10,5,10,4,2,1039,27,0,1044,1]

def active6000 : List Nat := [0,1,2,3,9]

def tree6000 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6000 : H12WitnessSearch.Good tree6000 := H12GlobalWitnessIndex.good

theorem leafIdentity6000 : H12AffineFastState.composeSystem env6000 rootObs = leafEnv6000 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6000 rootObs == leafEnv6000) = true)

theorem terminalChecked6000 : H12PackedTerminal.terminalCheckFast leafEnv6000 active6000 tree6000 = true := by decide +kernel

def env6001 : List Nat := [2,4,8,16,32,64,120,36,112,1024,1,1077,40,1125,1,65536,1124,1,66643,1,1076,32,64,65569,89,17,0,1124,1076,1,1056,96,36,96,1125,113]

theorem envBound6001 : H12AffineFastState.Bounded env6001 := by
  intro p hp
  have h : env6001.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5995_6001 : H12AffineEnvironment.transform 10 1 env5995 = env6001 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env5995 == env6001) = true)

theorem identity6001 : scanCanonicalize (H12AffineFastState.compose env6001 (packedSelected [0] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound6001 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6002 : List Nat := [2,4,8,16,32,11,51,36,59,1024,1,1077,40,1070,1,65536,1071,1,66584,1,1076,32,11,65569,18,17,0,1071,1076,1,1056,43,36,43,1070,58]

theorem envBound6002 : H12AffineFastState.Bounded env6002 := by
  intro p hp
  have h : env6002.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6001_6002 : H12AffineEnvironment.transform 5 11 env6001 = env6002 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env6001 == env6002) = true)

theorem identity6002 : scanCanonicalize (H12AffineFastState.compose env6002 (packedSelected [3] rootPS)) = affineNative (2^(15+1) ^^^ 25) := by decide +kernel

theorem selectedBound6002 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6003 : List Nat := [2,4,8,16,32,11,51,36,59,1024,1,1077,40,1070,1,25,1071,1,1025,1,1076,32,11,56,18,17,0,1071,1076,1,1056,43,36,43,1070,58]

theorem envBound6003 : H12AffineFastState.Bounded env6003 := by
  intro p hp
  have h : env6003.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6002_6003 : H12AffineEnvironment.transform 15 25 env6002 = env6003 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 25 env6002 == env6003) = true)

def leafEnv6003 : List Nat := [2,4,8,16,32,11,51,36,59,1024,1,1077,40,1070,1,25,1071,1,1025,1,1076,32,11,56,1057,18,1,17,0,1071,1076,1,1056,43,36,43,4,34,1070,58,0,1077,1]

def active6003 : List Nat := [0,1,2,3,4,9]

def tree6003 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6003 : H12WitnessSearch.Good tree6003 := H12GlobalWitnessIndex.good

theorem leafIdentity6003 : H12AffineFastState.composeSystem env6003 rootObs = leafEnv6003 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6003 rootObs == leafEnv6003) = true)

theorem terminalChecked6003 : H12PackedTerminal.terminalCheckFast leafEnv6003 active6003 tree6003 = true := by decide +kernel

def env6004 : List Nat := [2,4,8,16,32,64,121,256,113,1024,2048,1297,2317,1345,2340,65536,1344,2048,68691,2340,1296,260,64,67616,2429,17,2049,1344,1296,2048,1284,4294967296,256,4294967588,1345,112]

theorem envBound6004 : H12AffineFastState.Bounded env6004 := by
  intro p hp
  have h : env6004.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5992_6004 : H12AffineEnvironment.transform 6 121 env5992 = env6004 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 121 env5992 == env6004) = true)

theorem identity6004 : scanCanonicalize (H12AffineFastState.compose env6004 (packedSelected [5] rootPS)) = affineNative (2^(15+1) ^^^ 2422) := by decide +kernel

theorem selectedBound6004 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env6005 : List Nat := [2,4,8,16,32,64,121,256,113,1024,2048,1297,2317,1345,2340,2422,1344,2048,1317,2340,1296,260,64,342,2429,17,2049,1344,1296,2048,1284,4294967296,256,4294967588,1345,112]

theorem envBound6005 : H12AffineFastState.Bounded env6005 := by
  intro p hp
  have h : env6005.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6004_6005 : H12AffineEnvironment.transform 15 2422 env6004 = env6005 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2422 env6004 == env6005) = true)

theorem identity6005 : scanCanonicalize (H12AffineFastState.compose env6005 (packedSelected [1,2,3,4] rootPS)) = affineNative (2^(7+1) ^^^ 36) := by decide +kernel

theorem selectedBound6005 : packedSelected [1,2,3,4] rootPS < 2^1333 := by decide +kernel

def env6006 : List Nat := [2,4,8,16,32,64,121,36,113,1024,2048,1077,2089,1125,2048,2130,1124,2048,1025,2048,1076,32,64,114,2137,17,2049,1124,1076,2048,1056,4294967296,36,4294967296,1125,112]

theorem envBound6006 : H12AffineFastState.Bounded env6006 := by
  intro p hp
  have h : env6006.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6005_6006 : H12AffineEnvironment.transform 7 36 env6005 = env6006 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env6005 == env6006) = true)

theorem identity6006 : scanCanonicalize (H12AffineFastState.compose env6006 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 43) := by decide +kernel

theorem selectedBound6006 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6007 : List Nat := [2,4,8,16,32,64,121,36,113,1024,2048,1077,2089,1125,2048,2130,1124,2048,1025,2048,1076,32,64,114,2137,17,2049,1124,1076,2048,1056,43,36,43,1125,112]

theorem envBound6007 : H12AffineFastState.Bounded env6007 := by
  intro p hp
  have h : env6007.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6006_6007 : H12AffineEnvironment.transform 31 43 env6006 = env6007 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 43 env6006 == env6007) = true)

theorem identity6007 : scanCanonicalize (H12AffineFastState.compose env6007 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 11) := by decide +kernel

theorem selectedBound6007 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6008 : List Nat := [2,4,8,16,32,11,50,36,58,1024,2048,1077,2089,1070,2048,2073,1071,2048,1025,2048,1076,32,11,57,2066,17,2049,1071,1076,2048,1056,43,36,43,1070,59]

theorem envBound6008 : H12AffineFastState.Bounded env6008 := by
  intro p hp
  have h : env6008.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6007_6008 : H12AffineEnvironment.transform 5 11 env6007 = env6008 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 11 env6007 == env6008) = true)

def leafEnv6008 : List Nat := [2,4,8,16,32,11,50,36,58,1024,2048,1077,2089,1070,2048,2073,1071,2048,1025,2048,1076,32,11,57,1057,2066,1,17,2049,1071,1076,2048,1056,43,36,43,4,2083,1070,59,0,1077,1]

def active6008 : List Nat := [0,1,2,3,4,9,10]

def tree6008 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6008 : H12WitnessSearch.Good tree6008 := H12GlobalWitnessIndex.good

theorem leafIdentity6008 : H12AffineFastState.composeSystem env6008 rootObs = leafEnv6008 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6008 rootObs == leafEnv6008) = true)

theorem terminalChecked6008 : H12PackedTerminal.terminalCheckFast leafEnv6008 active6008 tree6008 = true := by decide +kernel

def env6009 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21776,262144,524288,32768,2097152,4194304,17665,16777216,2109577,2118992,6557957,2097233,16876565,1073741824,21845,4294967296,16896085,4316464298,21777,2101761]

theorem envBound6009 : H12AffineFastState.Bounded env6009 := by
  intro p hp
  have h : env6009.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5905_6009 : H12AffineEnvironment.transform 24 2109577 env5905 = env6009 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 2109577 env5905 == env6009) = true)

def env6010 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,524288,32768,2097152,4194304,17665,16777216,33554432,67108864,71582805,67130625,86102340,1073741824,69206021,4294967296,86082821,4417151347,21776,33563272]

theorem envBound6010 : H12AffineFastState.Bounded env6010 := by
  intro p hp
  have h : env6010.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans5903_6010 : H12AffineEnvironment.transform 16 21777 env5903 = env6010 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 21777 env5903 == env6010) = true)

theorem identity6010 : scanCanonicalize (H12AffineFastState.compose env6010 (packedSelected [5,8,13,17,21,24,26,28,31,33] rootPS)) = affineNative (2^(25+1) ^^^ 17745) := by decide +kernel

theorem selectedBound6010 : packedSelected [5,8,13,17,21,24,26,28,31,33] rootPS < 2^1333 := by decide +kernel

def env6011 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,524288,32768,2097152,4194304,17665,16777216,33554432,17745,4456708,4176,18977813,1073741824,2114900,4294967296,18989140,4350026786,21776,33563272]

theorem envBound6011 : H12AffineFastState.Bounded env6011 := by
  intro p hp
  have h : env6011.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6010_6011 : H12AffineEnvironment.transform 25 17745 env6010 = env6011 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 17745 env6010 == env6011) = true)

def env6012 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,524288,32768,4096,4194304,17665,16777216,33554432,17745,4456708,4176,16876565,1073741824,21844,4294967296,16896084,4350026786,21776,33563272]

theorem envBound6012 : H12AffineFastState.Bounded env6012 := by
  intro p hp
  have h : env6012.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6011_6012 : H12AffineEnvironment.transform 20 4096 env6011 = env6012 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env6011 == env6012) = true)

theorem identity6012 : scanCanonicalize (H12AffineFastState.compose env6012 (packedSelected [1,19,28,31] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound6012 : packedSelected [1,19,28,31] rootPS < 2^1333 := by decide +kernel

def env6013 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,524288,32768,4096,4194304,17665,16777216,8329,17745,4456708,4176,16876565,1073741824,21844,4294967296,16896084,4316464299,21776,513]

theorem envBound6013 : H12AffineFastState.Bounded env6013 := by
  intro p hp
  have h : env6013.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6012_6013 : H12AffineEnvironment.transform 24 8329 env6012 = env6013 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env6012 == env6013) = true)

theorem identity6013 : scanCanonicalize (H12AffineFastState.compose env6013 (packedSelected [0,4,7,9,16,20] rootPS)) = affineNative (2^(23+1) ^^^ 99213) := by decide +kernel

theorem selectedBound6013 : packedSelected [0,4,7,9,16,20] rootPS < 2^1333 := by decide +kernel

def env6014 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,524288,32768,4096,4194304,17665,99213,8329,17745,4456708,4176,1944,1073741824,21844,4294967296,21465,4299786022,21776,513]

theorem envBound6014 : H12AffineFastState.Bounded env6014 := by
  intro p hp
  have h : env6014.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6013_6014 : H12AffineEnvironment.transform 23 99213 env6013 = env6014 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 99213 env6013 == env6014) = true)

def env6015 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,524288,32768,4097,4194304,17665,16777216,33554432,17745,4456708,4176,16876564,1073741824,21845,4294967296,16896085,4350026786,21776,33563272]

theorem envBound6015 : H12AffineFastState.Bounded env6015 := by
  intro p hp
  have h : env6015.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6011_6015 : H12AffineEnvironment.transform 20 4097 env6011 = env6015 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env6011 == env6015) = true)

theorem identity6015 : scanCanonicalize (H12AffineFastState.compose env6015 (packedSelected [35] rootPS)) = affineNative (2^(23+1) ^^^ 98564) := by decide +kernel

theorem selectedBound6015 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env6016 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,524288,32768,4097,4194304,17665,98564,33554432,17745,4456708,4176,1296,1073741824,21845,4294967296,20817,4333348134,21776,33563272]

theorem envBound6016 : H12AffineFastState.Bounded env6016 := by
  intro p hp
  have h : env6016.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6015_6016 : H12AffineEnvironment.transform 23 98564 env6015 = env6016 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98564 env6015 == env6016) = true)

theorem identity6016 : scanCanonicalize (H12AffineFastState.compose env6016 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(29+1) ^^^ 37759372) := by decide +kernel

theorem selectedBound6016 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env6017 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,524288,32768,4097,4194304,17665,98564,33554432,17745,4456708,4176,1296,37759372,21845,4294967296,20817,4333348134,21776,33563272]

theorem envBound6017 : H12AffineFastState.Bounded env6017 := by
  intro p hp
  have h : env6017.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6016_6017 : H12AffineEnvironment.transform 29 37759372 env6016 = env6017 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 37759372 env6016 == env6017) = true)

theorem identity6017 : scanCanonicalize (H12AffineFastState.compose env6017 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(24+1) ^^^ 127319) := by decide +kernel

theorem selectedBound6017 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env6018 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,524288,32768,4097,4194304,17665,98564,127319,17745,4456708,4176,1296,4315355,21845,4294967296,20817,4299707505,21776,119775]

theorem envBound6018 : H12AffineFastState.Bounded env6018 := by
  intro p hp
  have h : env6018.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6017_6018 : H12AffineEnvironment.transform 24 127319 env6017 = env6018 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 127319 env6017 == env6018) = true)

theorem identity6018 : scanCanonicalize (H12AffineFastState.compose env6018 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(17+1) ^^^ 43048) := by decide +kernel

theorem selectedBound6018 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env6019 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,43048,524288,32768,4097,4194304,17665,98564,127319,17745,4237612,4176,1296,4315355,21845,4294967296,20817,4299707505,21776,119775]

theorem envBound6019 : H12AffineFastState.Bounded env6019 := by
  intro p hp
  have h : env6019.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6018_6019 : H12AffineEnvironment.transform 17 43048 env6018 = env6019 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43048 env6018 == env6019) = true)

def env6020 : List Nat := [2,4,8,16,32,64,128,256,512,256,2048,4096,8192,16384,32768,65536,20497,43048,524288,32768,4097,4194304,16385,98564,127319,16465,4237612,4176,16,4315355,20565,4294967296,20817,4299706737,20496,119775]

theorem envBound6020 : H12AffineFastState.Bounded env6020 := by
  intro p hp
  have h : env6020.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6019_6020 : H12AffineEnvironment.transform 9 256 env6019 = env6020 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 256 env6019 == env6020) = true)

theorem identity6020 : scanCanonicalize (H12AffineFastState.compose env6020 (packedSelected [1,5,15,21] rootPS)) = affineNative (2^(15+1) ^^^ 53726) := by decide +kernel

theorem selectedBound6020 : packedSelected [1,5,15,21] rootPS < 2^1333 := by decide +kernel

def env6021 : List Nat := [2,4,8,16,32,64,128,256,512,256,2048,4096,8192,16384,32768,53726,20497,43048,524288,32768,4097,4194304,16385,20698,8329,16465,4237612,4176,16,4196613,20565,4294967296,20817,4299706737,20496,513]

theorem envBound6021 : H12AffineFastState.Bounded env6021 := by
  intro p hp
  have h : env6021.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6020_6021 : H12AffineEnvironment.transform 15 53726 env6020 = env6021 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 53726 env6020 == env6021) = true)

theorem identity6021 : scanCanonicalize (H12AffineFastState.compose env6021 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound6021 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env6022 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,4096,8192,16384,32768,53726,20497,43048,524288,32768,4097,4194304,16385,20698,8329,16465,4237612,4176,16,4196613,20565,4294967296,20817,4299706737,20496,136]

theorem envBound6022 : H12AffineFastState.Bounded env6022 := by
  intro p hp
  have h : env6022.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6021_6022 : H12AffineEnvironment.transform 8 137 env6021 = env6022 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6021 == env6022) = true)

def env6023 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,4096,8192,16384,32768,53726,20497,43048,524288,32768,4097,10248,16385,20698,8329,16465,33060,4176,16,8461,20565,4294967296,20817,4295522681,20496,136]

theorem envBound6023 : H12AffineFastState.Bounded env6023 := by
  intro p hp
  have h : env6023.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6022_6023 : H12AffineEnvironment.transform 21 10248 env6022 = env6023 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10248 env6022 == env6023) = true)

theorem identity6023 : scanCanonicalize (H12AffineFastState.compose env6023 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(13+1) ^^^ 10572) := by decide +kernel

theorem selectedBound6023 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env6024 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,4096,8192,10572,32768,47250,14685,43048,524288,32768,4097,10248,10573,14742,8329,10525,33060,4176,16,8461,14617,4294967296,14365,4295495733,14684,136]

theorem envBound6024 : H12AffineFastState.Bounded env6024 := by
  intro p hp
  have h : env6024.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6023_6024 : H12AffineEnvironment.transform 13 10572 env6023 = env6024 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 10572 env6023 == env6024) = true)

def env6025 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,4096,8192,10572,8232,6330,14685,2048,524288,8232,4097,10248,10573,14742,8329,10525,8460,4176,16,8461,14617,4294967296,14365,4295495733,14684,136]

theorem envBound6025 : H12AffineFastState.Bounded env6025 := by
  intro p hp
  have h : env6025.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6024_6025 : H12AffineEnvironment.transform 14 8232 env6024 = env6025 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8232 env6024 == env6025) = true)

theorem identity6025 : scanCanonicalize (H12AffineFastState.compose env6025 (packedSelected [0,7] rootPS)) = affineNative (2^(12+1) ^^^ 6429) := by decide +kernel

theorem selectedBound6025 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env6026 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,4096,6429,4177,6453,6330,64,2048,524288,6453,4097,4373,4176,139,6548,4096,6161,4176,16,6160,4,4294967296,256,4295495733,65,136]

theorem envBound6026 : H12AffineFastState.Bounded env6026 := by
  intro p hp
  have h : env6026.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6025_6026 : H12AffineEnvironment.transform 12 6429 env6025 = env6026 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 6429 env6025 == env6026) = true)

theorem identity6026 : scanCanonicalize (H12AffineFastState.compose env6026 (packedSelected [2,4] rootPS)) = affineNative (2^(11+1) ^^^ 17) := by decide +kernel

theorem selectedBound6026 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env6027 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,17,2316,64,2340,2219,64,2048,524288,2340,16,260,65,139,2437,17,2048,65,16,2049,4,4294967296,256,4295491620,65,136]

theorem envBound6027 : H12AffineFastState.Bounded env6027 := by
  intro p hp
  have h : env6027.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6026_6027 : H12AffineEnvironment.transform 11 17 env6026 = env6027 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 17 env6026 == env6027) = true)

theorem identity6027 : scanCanonicalize (H12AffineFastState.compose env6027 (packedSelected [5,8] rootPS)) = affineNative (2^(18+1) ^^^ 256) := by decide +kernel

theorem selectedBound6027 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env6028 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,17,2316,64,2340,2219,64,2048,256,2340,16,260,65,139,2437,17,2048,65,16,2049,4,4294967296,256,4294967588,65,136]

theorem envBound6028 : H12AffineFastState.Bounded env6028 := by
  intro p hp
  have h : env6028.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6027_6028 : H12AffineEnvironment.transform 18 256 env6027 = env6028 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 256 env6027 == env6028) = true)

def env6029 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,4096,8192,10572,8233,6331,14685,2049,524288,8233,4097,10248,10573,14742,8329,10525,8461,4176,16,8461,14617,4294967296,14365,4295495733,14684,136]

theorem envBound6029 : H12AffineFastState.Bounded env6029 := by
  intro p hp
  have h : env6029.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6024_6029 : H12AffineEnvironment.transform 14 8233 env6024 = env6029 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8233 env6024 == env6029) = true)

theorem identity6029 : scanCanonicalize (H12AffineFastState.compose env6029 (packedSelected [0,7] rootPS)) = affineNative (2^(11+1) ^^^ 17) := by decide +kernel

theorem selectedBound6029 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env6030 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,17,8192,10572,8233,2218,10572,2049,524288,8233,16,10248,10573,10631,8329,10525,8461,65,16,8461,10504,4294967296,10252,4295491620,10573,136]

theorem envBound6030 : H12AffineFastState.Bounded env6030 := by
  intro p hp
  have h : env6030.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6029_6030 : H12AffineEnvironment.transform 11 17 env6029 = env6030 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 17 env6029 == env6030) = true)

theorem identity6030 : scanCanonicalize (H12AffineFastState.compose env6030 (packedSelected [3,8,10,12] rootPS)) = affineNative (2^(12+1) ^^^ 2317) := by decide +kernel

theorem selectedBound6030 : packedSelected [3,8,10,12] rootPS < 2^1333 := by decide +kernel

def env6031 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,17,2317,65,2340,2218,65,2049,524288,2340,16,261,64,138,2436,16,2048,65,16,2048,5,4294967296,257,4295491620,64,136]

theorem envBound6031 : H12AffineFastState.Bounded env6031 := by
  intro p hp
  have h : env6031.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6030_6031 : H12AffineEnvironment.transform 12 2317 env6030 = env6031 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2317 env6030 == env6031) = true)

theorem identity6031 : scanCanonicalize (H12AffineFastState.compose env6031 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound6031 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env6032 : List Nat := [2,4,8,16,32,64,128,4,137,4,2048,17,2057,65,2080,2218,65,2049,524288,2080,16,1,64,138,2176,16,2048,65,16,2048,5,4294967296,5,4295491620,64,136]

theorem envBound6032 : H12AffineFastState.Bounded env6032 := by
  intro p hp
  have h : env6032.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6031_6032 : H12AffineEnvironment.transform 7 4 env6031 = env6032 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env6031 == env6032) = true)

def env6033 : List Nat := [2,4,8,16,0,64,128,4,137,4,2048,17,2057,65,2048,2186,65,2049,524288,2048,16,1,64,138,2176,16,2048,65,16,2048,5,4294967296,5,4295491588,64,136]

theorem envBound6033 : H12AffineFastState.Bounded env6033 := by
  intro p hp
  have h : env6033.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6032_6033 : H12AffineEnvironment.transform 4 0 env6032 = env6033 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env6032 == env6033) = true)

theorem identity6033 : scanCanonicalize (H12AffineFastState.compose env6033 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 2139) := by decide +kernel

theorem selectedBound6033 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6034 : List Nat := [2,4,8,16,0,64,128,4,137,4,2048,17,2057,65,2048,2186,65,2049,524288,2048,16,1,64,138,2176,16,2048,65,16,2048,5,2139,5,526431,64,136]

theorem envBound6034 : H12AffineFastState.Bounded env6034 := by
  intro p hp
  have h : env6034.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6033_6034 : H12AffineEnvironment.transform 31 2139 env6033 = env6034 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 2139 env6033 == env6034) = true)

def env6035 : List Nat := [2,4,8,16,0,64,128,4,137,4,2048,17,2057,65,2048,2186,65,2049,4,2048,16,1,64,138,2176,16,2048,65,16,2048,5,2139,5,2139,64,136]

theorem envBound6035 : H12AffineFastState.Bounded env6035 := by
  intro p hp
  have h : env6035.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6034_6035 : H12AffineEnvironment.transform 18 4 env6034 = env6035 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 4 env6034 == env6035) = true)

theorem identity6035 : scanCanonicalize (H12AffineFastState.compose env6035 (packedSelected [1] rootPS)) = affineNative (2^(10+1) ^^^ 131) := by decide +kernel

theorem selectedBound6035 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6036 : List Nat := [2,4,8,16,0,64,128,4,137,4,131,17,138,65,131,9,65,130,4,131,16,1,64,138,3,16,131,65,16,131,5,216,5,216,64,136]

theorem envBound6036 : H12AffineFastState.Bounded env6036 := by
  intro p hp
  have h : env6036.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6035_6036 : H12AffineEnvironment.transform 10 131 env6035 = env6036 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 131 env6035 == env6036) = true)

def leafEnv6036 : List Nat := [2,4,8,16,0,64,128,4,137,4,131,17,138,65,131,9,65,130,4,131,16,1,64,138,4,3,1,16,131,65,16,131,5,216,5,216,4,128,64,136,0,16,1]

def active6036 : List Nat := [0,1,2,3,5,6]

def tree6036 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6036 : H12WitnessSearch.Good tree6036 := H12GlobalWitnessIndex.good

theorem leafIdentity6036 : H12AffineFastState.composeSystem env6036 rootObs = leafEnv6036 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6036 rootObs == leafEnv6036) = true)

theorem terminalChecked6036 : H12PackedTerminal.terminalCheckFast leafEnv6036 active6036 tree6036 = true := by decide +kernel

def env6037 : List Nat := [2,4,8,16,0,64,128,4,137,4,2048,17,2057,65,2048,2186,65,2049,5,2048,16,1,64,138,2176,16,2048,65,16,2048,5,2139,5,2138,64,136]

theorem envBound6037 : H12AffineFastState.Bounded env6037 := by
  intro p hp
  have h : env6037.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6034_6037 : H12AffineEnvironment.transform 18 5 env6034 = env6037 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 5 env6034 == env6037) = true)

theorem identity6037 : scanCanonicalize (H12AffineFastState.compose env6037 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound6037 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6038 : List Nat := [2,4,8,16,0,64,9,4,0,4,2048,17,2057,65,2048,2051,65,2049,5,2048,16,1,64,3,2057,16,2048,65,16,2048,5,2139,5,2138,64,1]

theorem envBound6038 : H12AffineFastState.Bounded env6038 := by
  intro p hp
  have h : env6038.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6037_6038 : H12AffineEnvironment.transform 6 9 env6037 = env6038 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env6037 == env6038) = true)

theorem identity6038 : scanCanonicalize (H12AffineFastState.compose env6038 (packedSelected [3] rootPS)) = affineNative (2^(10+1) ^^^ 10) := by decide +kernel

theorem selectedBound6038 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6039 : List Nat := [2,4,8,16,0,64,9,4,0,4,10,17,3,65,10,9,65,11,5,10,16,1,64,3,3,16,10,65,16,10,5,81,5,80,64,1]

theorem envBound6039 : H12AffineFastState.Bounded env6039 := by
  intro p hp
  have h : env6039.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6038_6039 : H12AffineEnvironment.transform 10 10 env6038 = env6039 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 10 env6038 == env6039) = true)

def leafEnv6039 : List Nat := [2,4,8,16,0,64,9,4,0,4,10,17,3,65,10,9,65,11,5,10,16,1,64,3,5,3,1,16,10,65,16,10,5,81,5,80,4,9,64,1,0,16,1]

def active6039 : List Nat := [0,1,2,3,5]

def tree6039 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6039 : H12WitnessSearch.Good tree6039 := H12GlobalWitnessIndex.good

theorem leafIdentity6039 : H12AffineFastState.composeSystem env6039 rootObs = leafEnv6039 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6039 rootObs == leafEnv6039) = true)

theorem terminalChecked6039 : H12PackedTerminal.terminalCheckFast leafEnv6039 active6039 tree6039 = true := by decide +kernel

def env6040 : List Nat := [2,4,8,16,1,64,128,4,137,4,2048,17,2057,65,2049,2187,65,2049,524288,2049,16,1,64,138,2176,16,2048,65,16,2048,5,4294967296,5,4295491589,64,136]

theorem envBound6040 : H12AffineFastState.Bounded env6040 := by
  intro p hp
  have h : env6040.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6032_6040 : H12AffineEnvironment.transform 4 1 env6032 = env6040 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env6032 == env6040) = true)

theorem identity6040 : scanCanonicalize (H12AffineFastState.compose env6040 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 2259) := by decide +kernel

theorem selectedBound6040 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6041 : List Nat := [2,4,8,16,1,64,128,4,137,4,2048,17,2057,65,2049,2187,65,2049,524288,2049,16,1,64,138,2176,16,2048,65,16,2048,5,2259,5,526550,64,136]

theorem envBound6041 : H12AffineFastState.Bounded env6041 := by
  intro p hp
  have h : env6041.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6040_6041 : H12AffineEnvironment.transform 31 2259 env6040 = env6041 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 2259 env6040 == env6041) = true)

theorem identity6041 : scanCanonicalize (H12AffineFastState.compose env6041 (packedSelected [1,2,5] rootPS)) = affineNative (2^(18+1) ^^^ 4) := by decide +kernel

theorem selectedBound6041 : packedSelected [1,2,5] rootPS < 2^1333 := by decide +kernel

def env6042 : List Nat := [2,4,8,16,1,64,128,4,137,4,2048,17,2057,65,2049,2187,65,2049,4,2049,16,1,64,138,2176,16,2048,65,16,2048,5,2259,5,2258,64,136]

theorem envBound6042 : H12AffineFastState.Bounded env6042 := by
  intro p hp
  have h : env6042.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6041_6042 : H12AffineEnvironment.transform 18 4 env6041 = env6042 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 4 env6041 == env6042) = true)

theorem identity6042 : scanCanonicalize (H12AffineFastState.compose env6042 (packedSelected [1] rootPS)) = affineNative (2^(10+1) ^^^ 210) := by decide +kernel

theorem selectedBound6042 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6043 : List Nat := [2,4,8,16,1,64,128,4,137,4,210,17,219,65,211,89,65,211,4,211,16,1,64,138,82,16,210,65,16,210,5,1,5,0,64,136]

theorem envBound6043 : H12AffineFastState.Bounded env6043 := by
  intro p hp
  have h : env6043.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6042_6043 : H12AffineEnvironment.transform 10 210 env6042 = env6043 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 210 env6042 == env6043) = true)

theorem identity6043 : scanCanonicalize (H12AffineFastState.compose env6043 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 88) := by decide +kernel

theorem selectedBound6043 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6044 : List Nat := [2,4,8,16,1,64,88,4,81,4,10,17,3,65,11,89,65,11,4,11,16,1,64,82,82,16,10,65,16,10,5,1,5,0,64,80]

theorem envBound6044 : H12AffineFastState.Bounded env6044 := by
  intro p hp
  have h : env6044.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6043_6044 : H12AffineEnvironment.transform 6 88 env6043 = env6044 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 88 env6043 == env6044) = true)

def leafEnv6044 : List Nat := [2,4,8,16,1,64,88,4,81,4,10,17,3,65,11,89,65,11,4,11,16,1,64,82,4,82,1,16,10,65,16,10,5,1,5,0,4,8,64,80,0,16,1]

def active6044 : List Nat := [0,1,2,3,5]

def tree6044 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6044 : H12WitnessSearch.Good tree6044 := H12GlobalWitnessIndex.good

theorem leafIdentity6044 : H12AffineFastState.composeSystem env6044 rootObs = leafEnv6044 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6044 rootObs == leafEnv6044) = true)

theorem terminalChecked6044 : H12PackedTerminal.terminalCheckFast leafEnv6044 active6044 tree6044 = true := by decide +kernel

def env6045 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,4096,8192,16384,32768,53726,20497,43048,524288,32768,4097,10249,16385,20698,8329,16465,33061,4176,16,8460,20565,4294967296,20817,4295522680,20496,136]

theorem envBound6045 : H12AffineFastState.Bounded env6045 := by
  intro p hp
  have h : env6045.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6022_6045 : H12AffineEnvironment.transform 21 10249 env6022 = env6045 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10249 env6022 == env6045) = true)

theorem identity6045 : scanCanonicalize (H12AffineFastState.compose env6045 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(14+1) ^^^ 24680) := by decide +kernel

theorem selectedBound6045 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env6046 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,4096,8192,16384,24680,12726,20497,18496,524288,24680,4097,10249,16385,20698,8329,16465,24909,4176,16,8460,20565,4294967296,20817,4295522680,20496,136]

theorem envBound6046 : H12AffineFastState.Bounded env6046 := by
  intro p hp
  have h : env6046.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6045_6046 : H12AffineEnvironment.transform 14 24680 env6045 = env6046 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 24680 env6045 == env6046) = true)

def env6047 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,4096,8192,64,8232,12726,4177,2048,524288,8232,4097,10249,65,4250,8329,17,8461,4176,16,8460,4117,4294967296,4369,4295506232,4176,136]

theorem envBound6047 : H12AffineFastState.Bounded env6047 := by
  intro p hp
  have h : env6047.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6046_6047 : H12AffineEnvironment.transform 13 64 env6046 = env6047 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 64 env6046 == env6047) = true)

theorem identity6047 : scanCanonicalize (H12AffineFastState.compose env6047 (packedSelected [0,7] rootPS)) = affineNative (2^(11+1) ^^^ 16) := by decide +kernel

theorem selectedBound6047 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env6048 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,16,8192,64,8232,8614,65,2048,524288,8232,17,10249,65,138,8329,17,8461,64,16,8460,5,4294967296,257,4295502120,64,136]

theorem envBound6048 : H12AffineFastState.Bounded env6048 := by
  intro p hp
  have h : env6048.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6047_6048 : H12AffineEnvironment.transform 11 16 env6047 = env6048 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 16 env6047 == env6048) = true)

theorem identity6048 : scanCanonicalize (H12AffineFastState.compose env6048 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound6048 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env6049 : List Nat := [2,4,8,16,32,64,128,4,137,4,2048,16,8192,64,8232,8354,65,2048,524288,8232,17,10249,65,138,8329,17,8201,64,16,8200,5,4294967296,5,4295501868,64,136]

theorem envBound6049 : H12AffineFastState.Bounded env6049 := by
  intro p hp
  have h : env6049.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6048_6049 : H12AffineEnvironment.transform 7 4 env6048 = env6049 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env6048 == env6049) = true)

theorem identity6049 : scanCanonicalize (H12AffineFastState.compose env6049 (packedSelected [1,3,5,10,13] rootPS)) = affineNative (2^(12+1) ^^^ 2056) := by decide +kernel

theorem selectedBound6049 : packedSelected [1,3,5,10,13] rootPS < 2^1333 := by decide +kernel

def env6050 : List Nat := [2,4,8,16,32,64,128,4,137,4,2048,16,2056,64,2080,2218,65,2048,524288,2080,17,1,65,138,2177,17,2049,64,16,2048,5,4294967296,5,4295491620,64,136]

theorem envBound6050 : H12AffineFastState.Bounded env6050 := by
  intro p hp
  have h : env6050.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6049_6050 : H12AffineEnvironment.transform 12 2056 env6049 = env6050 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2056 env6049 == env6050) = true)

def env6051 : List Nat := [2,4,8,16,0,64,128,4,137,4,2048,16,2056,64,2048,2186,65,2048,524288,2048,17,1,65,138,2177,17,2049,64,16,2048,5,4294967296,5,4295491588,64,136]

theorem envBound6051 : H12AffineFastState.Bounded env6051 := by
  intro p hp
  have h : env6051.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6050_6051 : H12AffineEnvironment.transform 4 0 env6050 = env6051 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env6050 == env6051) = true)

theorem identity6051 : scanCanonicalize (H12AffineFastState.compose env6051 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 2258) := by decide +kernel

theorem selectedBound6051 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6052 : List Nat := [2,4,8,16,0,64,128,4,137,4,2048,16,2056,64,2048,2186,65,2048,524288,2048,17,1,65,138,2177,17,2049,64,16,2048,5,2258,5,526550,64,136]

theorem envBound6052 : H12AffineFastState.Bounded env6052 := by
  intro p hp
  have h : env6052.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6051_6052 : H12AffineEnvironment.transform 31 2258 env6051 = env6052 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 2258 env6051 == env6052) = true)

theorem identity6052 : scanCanonicalize (H12AffineFastState.compose env6052 (packedSelected [2,3] rootPS)) = affineNative (2^(10+1) ^^^ 11) := by decide +kernel

theorem selectedBound6052 : packedSelected [2,3] rootPS < 2^1333 := by decide +kernel

def env6053 : List Nat := [2,4,8,16,0,64,128,4,137,4,11,16,3,64,11,129,65,11,524288,11,17,1,65,138,138,17,10,64,16,11,5,217,5,524509,64,136]

theorem envBound6053 : H12AffineFastState.Bounded env6053 := by
  intro p hp
  have h : env6053.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6052_6053 : H12AffineEnvironment.transform 10 11 env6052 = env6053 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 11 env6052 == env6053) = true)

theorem identity6053 : scanCanonicalize (H12AffineFastState.compose env6053 (packedSelected [1] rootPS)) = affineNative (2^(18+1) ^^^ 84) := by decide +kernel

theorem selectedBound6053 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6054 : List Nat := [2,4,8,16,0,64,128,4,137,4,11,16,3,64,11,129,65,11,84,11,17,1,65,138,138,17,10,64,16,11,5,217,5,137,64,136]

theorem envBound6054 : H12AffineFastState.Bounded env6054 := by
  intro p hp
  have h : env6054.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6053_6054 : H12AffineEnvironment.transform 18 84 env6053 = env6054 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 84 env6053 == env6054) = true)

theorem identity6054 : scanCanonicalize (H12AffineFastState.compose env6054 (packedSelected [2,5] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound6054 : packedSelected [2,5] rootPS < 2^1333 := by decide +kernel

def env6055 : List Nat := [2,4,8,16,0,16,128,4,137,4,11,16,3,16,11,129,17,11,4,11,17,1,17,138,138,17,10,16,16,11,5,137,5,137,16,136]

theorem envBound6055 : H12AffineFastState.Bounded env6055 := by
  intro p hp
  have h : env6055.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6054_6055 : H12AffineEnvironment.transform 5 16 env6054 = env6055 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env6054 == env6055) = true)

def leafEnv6055 : List Nat := [2,4,8,16,0,16,128,4,137,4,11,16,3,16,11,129,17,11,4,11,17,1,17,138,4,138,1,17,10,16,16,11,5,137,5,137,4,8,16,136,0,16,1]

def active6055 : List Nat := [0,1,2,3,6]

def tree6055 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6055 : H12WitnessSearch.Good tree6055 := H12GlobalWitnessIndex.good

theorem leafIdentity6055 : H12AffineFastState.composeSystem env6055 rootObs = leafEnv6055 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6055 rootObs == leafEnv6055) = true)

theorem terminalChecked6055 : H12PackedTerminal.terminalCheckFast leafEnv6055 active6055 tree6055 = true := by decide +kernel

def env6056 : List Nat := [2,4,8,16,1,64,128,4,137,4,2048,16,2056,64,2049,2187,65,2048,524288,2049,17,1,65,138,2177,17,2049,64,16,2048,5,4294967296,5,4295491589,64,136]

theorem envBound6056 : H12AffineFastState.Bounded env6056 := by
  intro p hp
  have h : env6056.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6050_6056 : H12AffineEnvironment.transform 4 1 env6050 = env6056 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env6050 == env6056) = true)

theorem identity6056 : scanCanonicalize (H12AffineFastState.compose env6056 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 2138) := by decide +kernel

theorem selectedBound6056 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6057 : List Nat := [2,4,8,16,1,64,128,4,137,4,2048,16,2056,64,2049,2187,65,2048,524288,2049,17,1,65,138,2177,17,2049,64,16,2048,5,2138,5,526431,64,136]

theorem envBound6057 : H12AffineFastState.Bounded env6057 := by
  intro p hp
  have h : env6057.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6056_6057 : H12AffineEnvironment.transform 31 2138 env6056 = env6057 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 2138 env6056 == env6057) = true)

theorem identity6057 : scanCanonicalize (H12AffineFastState.compose env6057 (packedSelected [1,2] rootPS)) = affineNative (2^(10+1) ^^^ 130) := by decide +kernel

theorem selectedBound6057 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env6058 : List Nat := [2,4,8,16,1,64,128,4,137,4,130,16,138,64,131,9,65,130,524288,131,17,1,65,138,3,17,131,64,16,130,5,216,5,524509,64,136]

theorem envBound6058 : H12AffineFastState.Bounded env6058 := by
  intro p hp
  have h : env6058.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6057_6058 : H12AffineEnvironment.transform 10 130 env6057 = env6058 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 130 env6057 == env6058) = true)

theorem identity6058 : scanCanonicalize (H12AffineFastState.compose env6058 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound6058 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6059 : List Nat := [2,4,8,16,1,64,9,4,0,4,11,16,3,64,10,9,65,11,524288,10,17,1,65,3,3,17,10,64,16,11,5,81,5,524372,64,1]

theorem envBound6059 : H12AffineFastState.Bounded env6059 := by
  intro p hp
  have h : env6059.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6058_6059 : H12AffineEnvironment.transform 6 9 env6058 = env6059 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env6058 == env6059) = true)

def leafEnv6059 : List Nat := [2,4,8,16,1,64,9,4,0,4,11,16,3,64,10,9,65,11,524288,10,17,1,65,3,524288,3,1,17,10,64,16,11,5,81,5,524372,4,9,64,1,0,16,1]

def active6059 : List Nat := [0,1,2,3,5,18]

def tree6059 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6059 : H12WitnessSearch.Good tree6059 := H12GlobalWitnessIndex.good

theorem leafIdentity6059 : H12AffineFastState.composeSystem env6059 rootObs = leafEnv6059 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6059 rootObs == leafEnv6059) = true)

theorem terminalChecked6059 : H12PackedTerminal.terminalCheckFast leafEnv6059 active6059 tree6059 = true := by decide +kernel

def env6060 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,4096,8192,65,8233,12726,4176,2049,524288,8233,4097,10249,64,4251,8329,16,8460,4176,16,8460,4116,4294967296,4368,4295506233,4177,136]

theorem envBound6060 : H12AffineFastState.Bounded env6060 := by
  intro p hp
  have h : env6060.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6046_6060 : H12AffineEnvironment.transform 13 65 env6046 = env6060 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 65 env6046 == env6060) = true)

theorem identity6060 : scanCanonicalize (H12AffineFastState.compose env6060 (packedSelected [0,7] rootPS)) = affineNative (2^(12+1) ^^^ 6428) := by decide +kernel

theorem selectedBound6060 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env6061 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,4096,6428,65,6453,2218,4176,2049,524288,6453,4097,4373,64,4251,6549,16,6160,4176,16,6160,4116,4294967296,4368,4295491621,4177,136]

theorem envBound6061 : H12AffineFastState.Bounded env6061 := by
  intro p hp
  have h : env6061.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6060_6061 : H12AffineEnvironment.transform 12 6428 env6060 = env6061 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 6428 env6060 == env6061) = true)

theorem identity6061 : scanCanonicalize (H12AffineFastState.compose env6061 (packedSelected [3,8,10,12] rootPS)) = affineNative (2^(18+1) ^^^ 257) := by decide +kernel

theorem selectedBound6061 : packedSelected [3,8,10,12] rootPS < 2^1333 := by decide +kernel

def env6062 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,4096,6428,65,6453,2218,4176,2049,257,6453,4097,4373,64,4251,6549,16,6160,4176,16,6160,4116,4294967296,4368,4294967588,4177,136]

theorem envBound6062 : H12AffineFastState.Bounded env6062 := by
  intro p hp
  have h : env6062.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6061_6062 : H12AffineEnvironment.transform 18 257 env6061 = env6062 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 257 env6061 == env6062) = true)

theorem identity6062 : scanCanonicalize (H12AffineFastState.compose env6062 (packedSelected [1,2,3,4,5] rootPS)) = affineNative (2^(11+1) ^^^ 49) := by decide +kernel

theorem selectedBound6062 : packedSelected [1,2,3,4,5] rootPS < 2^1333 := by decide +kernel

def env6063 : List Nat := [2,4,8,16,32,64,128,256,137,256,2048,49,2349,65,2308,2218,97,2049,257,2308,48,292,64,170,2468,16,2081,97,16,2081,37,4294967296,289,4294967588,96,136]

theorem envBound6063 : H12AffineFastState.Bounded env6063 := by
  intro p hp
  have h : env6063.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6062_6063 : H12AffineEnvironment.transform 11 49 env6062 = env6063 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 49 env6062 == env6063) = true)

theorem identity6063 : scanCanonicalize (H12AffineFastState.compose env6063 (packedSelected [1,2,3,4,8] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound6063 : packedSelected [1,2,3,4,8] rootPS < 2^1333 := by decide +kernel

def env6064 : List Nat := [2,4,8,16,0,64,128,256,137,256,2048,17,2317,65,2308,2186,65,2049,257,2308,16,260,64,138,2436,16,2049,65,16,2049,5,4294967296,257,4294967556,64,136]

theorem envBound6064 : H12AffineFastState.Bounded env6064 := by
  intro p hp
  have h : env6064.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6063_6064 : H12AffineEnvironment.transform 4 0 env6063 = env6064 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env6063 == env6064) = true)

theorem identity6064 : scanCanonicalize (H12AffineFastState.compose env6064 (packedSelected [1,3] rootPS)) = affineNative (2^(31+1) ^^^ 80) := by decide +kernel

theorem selectedBound6064 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env6065 : List Nat := [2,4,8,16,0,64,128,256,137,256,2048,17,2317,65,2308,2186,65,2049,257,2308,16,260,64,138,2436,16,2049,65,16,2049,5,80,257,340,64,136]

theorem envBound6065 : H12AffineFastState.Bounded env6065 := by
  intro p hp
  have h : env6065.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6064_6065 : H12AffineEnvironment.transform 31 80 env6064 = env6065 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 80 env6064 == env6065) = true)

theorem identity6065 : scanCanonicalize (H12AffineFastState.compose env6065 (packedSelected [1,2] rootPS)) = affineNative (2^(7+1) ^^^ 85) := by decide +kernel

theorem selectedBound6065 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env6066 : List Nat := [2,4,8,16,0,64,128,85,137,85,2048,17,2136,65,2129,2186,65,2049,84,2129,16,81,64,138,2257,16,2049,65,16,2049,5,80,84,1,64,136]

theorem envBound6066 : H12AffineFastState.Bounded env6066 := by
  intro p hp
  have h : env6066.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6065_6066 : H12AffineEnvironment.transform 7 85 env6065 = env6066 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 85 env6065 == env6066) = true)

theorem identity6066 : scanCanonicalize (H12AffineFastState.compose env6066 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound6066 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6067 : List Nat := [2,4,8,16,0,64,9,85,0,85,2048,17,2136,65,2129,2051,65,2049,84,2129,16,81,64,3,2136,16,2049,65,16,2049,5,80,84,1,64,1]

theorem envBound6067 : H12AffineFastState.Bounded env6067 := by
  intro p hp
  have h : env6067.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6066_6067 : H12AffineEnvironment.transform 6 9 env6066 = env6067 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env6066 == env6067) = true)

theorem identity6067 : scanCanonicalize (H12AffineFastState.compose env6067 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 91) := by decide +kernel

theorem selectedBound6067 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6068 : List Nat := [2,4,8,16,0,64,9,85,0,85,91,17,3,65,10,88,65,90,84,10,16,81,64,3,3,16,90,65,16,90,5,80,84,1,64,1]

theorem envBound6068 : H12AffineFastState.Bounded env6068 := by
  intro p hp
  have h : env6068.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6067_6068 : H12AffineEnvironment.transform 10 91 env6067 = env6068 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 91 env6067 == env6068) = true)

theorem identity6068 : scanCanonicalize (H12AffineFastState.compose env6068 (packedSelected [4] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound6068 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env6069 : List Nat := [2,4,8,16,0,17,9,4,0,4,10,17,3,16,10,9,16,11,5,10,16,0,17,3,3,16,11,16,16,11,5,1,5,1,17,1]

theorem envBound6069 : H12AffineFastState.Bounded env6069 := by
  intro p hp
  have h : env6069.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6068_6069 : H12AffineEnvironment.transform 5 17 env6068 = env6069 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env6068 == env6069) = true)

def env6070 : List Nat := [2,4,8,16,32,64,128,256,512,257,2048,4096,8192,16384,32768,65536,20496,43048,524288,32768,4097,4194304,16384,98564,127319,16464,4237612,4176,17,4315355,20564,4294967296,20817,4299706736,20497,119775]

theorem envBound6070 : H12AffineFastState.Bounded env6070 := by
  intro p hp
  have h : env6070.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6019_6070 : H12AffineEnvironment.transform 9 257 env6019 = env6070 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 257 env6019 == env6070) = true)

def env6071 : List Nat := [2,4,8,16,32,64,128,256,512,257,2048,4096,8192,16384,10880,65536,20496,680,524288,10880,4097,4194304,16384,76676,89047,16464,4195244,4176,17,4289115,20564,4294967296,20817,4299706736,20497,96607]

theorem envBound6071 : H12AffineFastState.Bounded env6071 := by
  intro p hp
  have h : env6071.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6070_6071 : H12AffineEnvironment.transform 14 10880 env6070 = env6071 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 10880 env6070 == env6071) = true)

def env6072 : List Nat := [2,4,8,16,32,64,128,256,512,257,2048,4096,8192,16384,10880,65536,20496,680,524288,10880,4097,10248,16384,76676,89047,16464,11172,4176,17,88659,20564,4294967296,20817,4295522680,20497,96607]

theorem envBound6072 : H12AffineFastState.Bounded env6072 := by
  intro p hp
  have h : env6072.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6071_6072 : H12AffineEnvironment.transform 21 10248 env6071 = env6072 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10248 env6071 == env6072) = true)

theorem identity6072 : scanCanonicalize (H12AffineFastState.compose env6072 (packedSelected [11] rootPS)) = affineNative (2^(13+1) ^^^ 11204) := by decide +kernel

theorem selectedBound6072 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env6073 : List Nat := [2,4,8,16,32,64,128,256,512,257,2048,4096,8192,11204,10880,65536,15316,680,524288,10880,4097,10248,11204,76676,77843,11156,11172,4176,17,78231,15248,4294967296,14997,4295496380,15317,70299]

theorem envBound6073 : H12AffineFastState.Bounded env6073 := by
  intro p hp
  have h : env6073.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6072_6073 : H12AffineEnvironment.transform 13 11204 env6072 = env6073 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 11204 env6072 == env6073) = true)

def env6074 : List Nat := [2,4,8,16,32,64,128,256,512,257,680,4096,8192,8556,8232,65536,12668,680,524288,8232,4097,8864,8556,74028,77843,8508,8460,4176,17,78231,12600,4294967296,12349,4295496380,12669,70299]

theorem envBound6074 : H12AffineFastState.Bounded env6074 := by
  intro p hp
  have h : env6074.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6073_6074 : H12AffineEnvironment.transform 10 680 env6073 = env6074 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 680 env6073 == env6074) = true)

theorem identity6074 : scanCanonicalize (H12AffineFastState.compose env6074 (packedSelected [18] rootPS)) = affineNative (2^(12+1) ^^^ 4413) := by decide +kernel

theorem selectedBound6074 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env6075 : List Nat := [2,4,8,16,32,64,128,256,512,257,680,4096,4413,4177,4373,65536,65,680,524288,4373,4097,5021,4177,69649,65838,4097,4145,4176,17,65706,5,4294967296,256,4295496380,64,70299]

theorem envBound6075 : H12AffineFastState.Bounded env6075 := by
  intro p hp
  have h : env6075.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6074_6075 : H12AffineEnvironment.transform 12 4413 env6074 = env6075 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 4413 env6074 == env6075) = true)

theorem identity6075 : scanCanonicalize (H12AffineFastState.compose env6075 (packedSelected [3,8,10,12] rootPS)) = affineNative (2^(18+1) ^^^ 66307) := by decide +kernel

theorem selectedBound6075 : packedSelected [3,8,10,12] rootPS < 2^1333 := by decide +kernel

def env6076 : List Nat := [2,4,8,16,32,64,128,256,512,257,680,4096,4413,4177,4373,65536,65,680,66307,4373,4097,5021,4177,69649,65838,4097,4145,4176,17,65706,5,4294967296,256,4295037375,64,70299]

theorem envBound6076 : H12AffineFastState.Bounded env6076 := by
  intro p hp
  have h : env6076.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6075_6076 : H12AffineEnvironment.transform 18 66307 env6075 = env6076 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 66307 env6075 == env6076) = true)

theorem identity6076 : scanCanonicalize (H12AffineFastState.compose env6076 (packedSelected [0,4,5,7,8,9] rootPS)) = affineNative (2^(11+1) ^^^ 17) := by decide +kernel

theorem selectedBound6076 : packedSelected [0,4,5,7,8,9] rootPS < 2^1333 := by decide +kernel

def env6077 : List Nat := [2,4,8,16,32,64,128,256,512,257,680,17,300,64,260,65536,65,680,66307,260,16,908,64,65536,65838,16,32,65,17,65706,5,4294967296,256,4295033262,64,66186]

theorem envBound6077 : H12AffineFastState.Bounded env6077 := by
  intro p hp
  have h : env6077.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6076_6077 : H12AffineEnvironment.transform 11 17 env6076 = env6077 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 17 env6076 == env6077) = true)

theorem identity6077 : scanCanonicalize (H12AffineFastState.compose env6077 (packedSelected [3,5,10,15] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound6077 : packedSelected [3,5,10,15] rootPS < 2^1333 := by decide +kernel

def env6078 : List Nat := [2,4,8,16,32,64,128,256,136,257,32,17,300,64,260,65536,65,32,65931,260,16,260,64,65536,65838,16,32,65,17,65706,5,4294967296,256,4295033262,64,65538]

theorem envBound6078 : H12AffineFastState.Bounded env6078 := by
  intro p hp
  have h : env6078.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6077_6078 : H12AffineEnvironment.transform 8 136 env6077 = env6078 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env6077 == env6078) = true)

theorem identity6078 : scanCanonicalize (H12AffineFastState.compose env6078 (packedSelected [0,1,3,7] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound6078 : packedSelected [0,1,3,7] rootPS < 2^1333 := by decide +kernel

def env6079 : List Nat := [2,4,8,16,32,64,8,256,0,257,32,17,300,64,260,65536,65,32,65795,260,16,260,64,65536,65838,16,32,65,17,65570,5,4294967296,256,4295033126,64,65538]

theorem envBound6079 : H12AffineFastState.Bounded env6079 := by
  intro p hp
  have h : env6079.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6078_6079 : H12AffineEnvironment.transform 6 8 env6078 = env6079 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env6078 == env6079) = true)

theorem identity6079 : scanCanonicalize (H12AffineFastState.compose env6079 (packedSelected [1,3] rootPS)) = affineNative (2^(15+1) ^^^ 2) := by decide +kernel

theorem selectedBound6079 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env6080 : List Nat := [2,4,8,16,32,64,8,256,0,257,32,17,300,64,260,2,65,32,257,260,16,260,64,2,300,16,32,65,17,32,5,4294967296,256,4294967588,64,0]

theorem envBound6080 : H12AffineFastState.Bounded env6080 := by
  intro p hp
  have h : env6080.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6079_6080 : H12AffineEnvironment.transform 15 2 env6079 = env6080 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2 env6079 == env6080) = true)

theorem identity6080 : scanCanonicalize (H12AffineFastState.compose env6080 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 115) := by decide +kernel

theorem selectedBound6080 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6081 : List Nat := [2,4,8,16,32,64,8,256,0,257,32,17,300,64,260,2,65,32,257,260,16,260,64,2,300,16,32,65,17,32,5,115,256,343,64,0]

theorem envBound6081 : H12AffineFastState.Bounded env6081 := by
  intro p hp
  have h : env6081.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6080_6081 : H12AffineEnvironment.transform 31 115 env6080 = env6081 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 115 env6080 == env6081) = true)

theorem identity6081 : scanCanonicalize (H12AffineFastState.compose env6081 (packedSelected [2,4] rootPS)) = affineNative (2^(2+1) ^^^ 1) := by decide +kernel

theorem selectedBound6081 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env6082 : List Nat := [2,4,1,16,32,64,1,256,0,257,32,17,293,64,260,2,65,32,257,260,16,260,64,2,293,16,32,65,17,32,5,115,256,343,64,0]

theorem envBound6082 : H12AffineFastState.Bounded env6082 := by
  intro p hp
  have h : env6082.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6081_6082 : H12AffineEnvironment.transform 2 1 env6081 = env6082 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env6081 == env6082) = true)

theorem identity6082 : scanCanonicalize (H12AffineFastState.compose env6082 (packedSelected [6] rootPS)) = affineNative (2^(7+1) ^^^ 7) := by decide +kernel

theorem selectedBound6082 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env6083 : List Nat := [2,4,1,16,32,64,1,7,0,6,32,17,34,64,3,2,65,32,6,3,16,3,64,2,34,16,32,65,17,32,5,115,7,80,64,0]

theorem envBound6083 : H12AffineFastState.Bounded env6083 := by
  intro p hp
  have h : env6083.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6082_6083 : H12AffineEnvironment.transform 7 7 env6082 = env6083 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 7 env6082 == env6083) = true)

theorem identity6083 : scanCanonicalize (H12AffineFastState.compose env6083 (packedSelected [1,10] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound6083 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env6084 : List Nat := [2,4,1,16,32,16,1,7,0,6,32,17,34,16,3,2,17,32,6,3,16,3,16,2,34,16,32,17,17,32,5,35,7,0,16,0]

theorem envBound6084 : H12AffineFastState.Bounded env6084 := by
  intro p hp
  have h : env6084.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6083_6084 : H12AffineEnvironment.transform 5 16 env6083 = env6084 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env6083 == env6084) = true)

theorem identity6084 : scanCanonicalize (H12AffineFastState.compose env6084 (packedSelected [2,22] rootPS)) = affineNative (2^(4+1) ^^^ 3) := by decide +kernel

theorem selectedBound6084 : packedSelected [2,22] rootPS < 2^1333 := by decide +kernel

def env6085 : List Nat := [2,4,1,16,3,16,1,7,0,6,3,17,1,16,3,2,17,3,6,3,16,3,16,2,1,16,3,17,17,3,5,0,7,0,16,0]

theorem envBound6085 : H12AffineFastState.Bounded env6085 := by
  intro p hp
  have h : env6085.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6084_6085 : H12AffineEnvironment.transform 4 3 env6084 = env6085 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 3 env6084 == env6085) = true)

theorem identity6085 : scanCanonicalize (H12AffineFastState.compose env6085 (packedSelected [2] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound6085 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6086 : List Nat := [1,4,1,16,0,16,1,4,0,5,0,17,1,16,0,1,17,0,5,0,16,0,16,1,1,16,0,17,17,0,5,0,4,0,16,0]

theorem envBound6086 : H12AffineFastState.Bounded env6086 := by
  intro p hp
  have h : env6086.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6085_6086 : H12AffineEnvironment.transform 0 1 env6085 = env6086 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env6085 == env6086) = true)

def leafEnv6086 : List Nat := [1,4,1,16,0,16,1,4,0,5,0,17,1,16,0,1,17,0,5,0,16,0,16,1,5,1,1,16,0,17,17,0,5,0,4,0,4,1,16,0,0,16,1]

def active6086 : List Nat := [1,3]

def tree6086 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6086 : H12WitnessSearch.Good tree6086 := H12GlobalWitnessIndex.good

theorem leafIdentity6086 : H12AffineFastState.composeSystem env6086 rootObs = leafEnv6086 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6086 rootObs == leafEnv6086) = true)

theorem terminalChecked6086 : H12PackedTerminal.terminalCheckFast leafEnv6086 active6086 tree6086 = true := by decide +kernel

def env6087 : List Nat := [2,4,8,16,32,64,128,256,512,257,681,4096,8192,8557,8233,65536,12669,680,524288,8233,4097,8865,8557,74029,77843,8509,8461,4176,17,78231,12601,4294967296,12348,4295496380,12668,70299]

theorem envBound6087 : H12AffineFastState.Bounded env6087 := by
  intro p hp
  have h : env6087.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6073_6087 : H12AffineEnvironment.transform 10 681 env6073 = env6087 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 681 env6073 == env6087) = true)

theorem identity6087 : scanCanonicalize (H12AffineFastState.compose env6087 (packedSelected [18] rootPS)) = affineNative (2^(11+1) ^^^ 665) := by decide +kernel

theorem selectedBound6087 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env6088 : List Nat := [2,4,8,16,32,64,128,256,512,257,681,665,8192,8557,8233,65536,9188,680,524288,8233,664,8865,8557,74029,74378,8509,8461,713,17,74510,9120,4294967296,8869,4295491621,9189,65538]

theorem envBound6088 : H12AffineFastState.Bounded env6088 := by
  intro p hp
  have h : env6088.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6087_6088 : H12AffineEnvironment.transform 11 665 env6087 = env6088 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 665 env6087 == env6088) = true)

theorem identity6088 : scanCanonicalize (H12AffineFastState.compose env6088 (packedSelected [3,8,10,12] rootPS)) = affineNative (2^(15+1) ^^^ 9006) := by decide +kernel

theorem selectedBound6088 : packedSelected [3,8,10,12] rootPS < 2^1333 := by decide +kernel

def env6089 : List Nat := [2,4,8,16,32,64,128,256,512,257,681,665,8192,8557,8233,9006,9188,680,524288,8233,664,8865,8557,515,420,8509,8461,713,17,32,9120,4294967296,8869,4295491621,9189,9004]

theorem envBound6089 : H12AffineFastState.Bounded env6089 := by
  intro p hp
  have h : env6089.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6088_6089 : H12AffineEnvironment.transform 15 9006 env6088 = env6089 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 9006 env6088 == env6089) = true)

theorem identity6089 : scanCanonicalize (H12AffineFastState.compose env6089 (packedSelected [0,3,4,7,8,9,10,15] rootPS)) = affineNative (2^(12+1) ^^^ 301) := by decide +kernel

theorem selectedBound6089 : packedSelected [0,3,4,7,8,9,10,15] rootPS < 2^1333 := by decide +kernel

def env6090 : List Nat := [2,4,8,16,32,64,128,256,512,257,681,665,301,64,260,515,713,680,524288,260,664,908,64,515,420,16,32,713,17,32,653,4294967296,904,4295491621,712,513]

theorem envBound6090 : H12AffineFastState.Bounded env6090 := by
  intro p hp
  have h : env6090.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6089_6090 : H12AffineEnvironment.transform 12 301 env6089 = env6090 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 301 env6089 == env6090) = true)

theorem identity6090 : scanCanonicalize (H12AffineFastState.compose env6090 (packedSelected [0,7] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound6090 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env6091 : List Nat := [2,4,8,16,32,64,128,256,137,257,32,16,301,64,260,138,64,33,524288,260,17,261,64,138,420,16,32,64,17,32,4,4294967296,257,4295491621,65,136]

theorem envBound6091 : H12AffineFastState.Bounded env6091 := by
  intro p hp
  have h : env6091.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6090_6091 : H12AffineEnvironment.transform 8 137 env6090 = env6091 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6090 == env6091) = true)

theorem identity6091 : scanCanonicalize (H12AffineFastState.compose env6091 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound6091 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env6092 : List Nat := [2,4,8,16,32,64,128,4,137,5,32,16,41,64,0,138,64,33,524288,0,17,1,64,138,160,16,32,64,17,32,4,4294967296,5,4295491621,65,136]

theorem envBound6092 : H12AffineFastState.Bounded env6092 := by
  intro p hp
  have h : env6092.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6091_6092 : H12AffineEnvironment.transform 7 4 env6091 = env6092 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env6091 == env6092) = true)

def env6093 : List Nat := [2,4,8,16,0,64,128,4,137,5,0,16,9,64,0,138,64,1,524288,0,17,1,64,138,128,16,0,64,17,0,4,4294967296,5,4295491589,65,136]

theorem envBound6093 : H12AffineFastState.Bounded env6093 := by
  intro p hp
  have h : env6093.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6092_6093 : H12AffineEnvironment.transform 4 0 env6092 = env6093 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env6092 == env6093) = true)

theorem identity6093 : scanCanonicalize (H12AffineFastState.compose env6093 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 90) := by decide +kernel

theorem selectedBound6093 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6094 : List Nat := [2,4,8,16,0,64,128,4,137,5,0,16,9,64,0,138,64,1,524288,0,17,1,64,138,128,16,0,64,17,0,4,90,5,524383,65,136]

theorem envBound6094 : H12AffineFastState.Bounded env6094 := by
  intro p hp
  have h : env6094.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6093_6094 : H12AffineEnvironment.transform 31 90 env6093 = env6094 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 90 env6093 == env6094) = true)

def env6095 : List Nat := [2,4,8,16,0,64,128,4,137,5,0,16,9,64,0,138,64,1,4,0,17,1,64,138,128,16,0,64,17,0,4,90,5,91,65,136]

theorem envBound6095 : H12AffineFastState.Bounded env6095 := by
  intro p hp
  have h : env6095.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6094_6095 : H12AffineEnvironment.transform 18 4 env6094 = env6095 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 4 env6094 == env6095) = true)

theorem identity6095 : scanCanonicalize (H12AffineFastState.compose env6095 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound6095 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6096 : List Nat := [2,4,8,16,0,64,9,4,0,5,0,16,9,64,0,3,64,1,4,0,17,1,64,3,9,16,0,64,17,0,4,90,5,91,65,1]

theorem envBound6096 : H12AffineFastState.Bounded env6096 := by
  intro p hp
  have h : env6096.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6095_6096 : H12AffineEnvironment.transform 6 9 env6095 = env6096 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env6095 == env6096) = true)

theorem identity6096 : scanCanonicalize (H12AffineFastState.compose env6096 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound6096 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6097 : List Nat := [2,4,3,16,0,64,2,4,0,5,0,16,2,64,0,3,64,1,4,0,17,1,64,3,2,16,0,64,17,0,4,81,5,80,65,1]

theorem envBound6097 : H12AffineFastState.Bounded env6097 := by
  intro p hp
  have h : env6097.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6096_6097 : H12AffineEnvironment.transform 2 3 env6096 = env6097 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env6096 == env6097) = true)

def leafEnv6097 : List Nat := [2,4,3,16,0,64,2,4,0,5,0,16,2,64,0,3,64,1,4,0,17,1,64,3,4,2,1,16,0,64,17,0,4,81,5,80,4,3,65,1,0,17,1]

def active6097 : List Nat := [0,1,3,5]

def tree6097 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6097 : H12WitnessSearch.Good tree6097 := H12GlobalWitnessIndex.good

theorem leafIdentity6097 : H12AffineFastState.composeSystem env6097 rootObs = leafEnv6097 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6097 rootObs == leafEnv6097) = true)

theorem terminalChecked6097 : H12PackedTerminal.terminalCheckFast leafEnv6097 active6097 tree6097 = true := by decide +kernel

def env6098 : List Nat := [2,4,8,16,0,64,128,4,137,5,0,16,9,64,0,138,64,1,5,0,17,1,64,138,128,16,0,64,17,0,4,90,5,90,65,136]

theorem envBound6098 : H12AffineFastState.Bounded env6098 := by
  intro p hp
  have h : env6098.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6094_6098 : H12AffineEnvironment.transform 18 5 env6094 = env6098 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 5 env6094 == env6098) = true)

theorem identity6098 : scanCanonicalize (H12AffineFastState.compose env6098 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 2) := by decide +kernel

theorem selectedBound6098 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6099 : List Nat := [2,4,8,16,0,64,2,4,11,5,0,16,9,64,0,8,64,1,5,0,17,1,64,8,2,16,0,64,17,0,4,90,5,90,65,10]

theorem envBound6099 : H12AffineFastState.Bounded env6099 := by
  intro p hp
  have h : env6099.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6098_6099 : H12AffineEnvironment.transform 6 2 env6098 = env6099 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 2 env6098 == env6099) = true)

def leafEnv6099 : List Nat := [2,4,8,16,0,64,2,4,11,5,0,16,9,64,0,8,64,1,5,0,17,1,64,8,5,2,1,16,0,64,17,0,4,90,5,90,4,3,65,10,0,17,1]

def active6099 : List Nat := [0,1,2,3,5]

def tree6099 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6099 : H12WitnessSearch.Good tree6099 := H12GlobalWitnessIndex.good

theorem leafIdentity6099 : H12AffineFastState.composeSystem env6099 rootObs = leafEnv6099 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6099 rootObs == leafEnv6099) = true)

theorem terminalChecked6099 : H12PackedTerminal.terminalCheckFast leafEnv6099 active6099 tree6099 = true := by decide +kernel

def env6100 : List Nat := [2,4,8,16,1,64,128,4,137,5,1,16,8,64,0,138,64,0,524288,0,17,1,64,138,129,16,1,64,17,1,4,4294967296,5,4295491588,65,136]

theorem envBound6100 : H12AffineFastState.Bounded env6100 := by
  intro p hp
  have h : env6100.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6092_6100 : H12AffineEnvironment.transform 4 1 env6092 = env6100 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env6092 == env6100) = true)

theorem identity6100 : scanCanonicalize (H12AffineFastState.compose env6100 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 211) := by decide +kernel

theorem selectedBound6100 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6101 : List Nat := [2,4,8,16,1,64,128,4,137,5,1,16,8,64,0,138,64,0,524288,0,17,1,64,138,129,16,1,64,17,1,4,211,5,524503,65,136]

theorem envBound6101 : H12AffineFastState.Bounded env6101 := by
  intro p hp
  have h : env6101.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6100_6101 : H12AffineEnvironment.transform 31 211 env6100 = env6101 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 211 env6100 == env6101) = true)

theorem identity6101 : scanCanonicalize (H12AffineFastState.compose env6101 (packedSelected [1,2,5] rootPS)) = affineNative (2^(18+1) ^^^ 5) := by decide +kernel

theorem selectedBound6101 : packedSelected [1,2,5] rootPS < 2^1333 := by decide +kernel

def env6102 : List Nat := [2,4,8,16,1,64,128,4,137,5,1,16,8,64,0,138,64,0,5,0,17,1,64,138,129,16,1,64,17,1,4,211,5,210,65,136]

theorem envBound6102 : H12AffineFastState.Bounded env6102 := by
  intro p hp
  have h : env6102.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6101_6102 : H12AffineEnvironment.transform 18 5 env6101 = env6102 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 5 env6101 == env6102) = true)

theorem identity6102 : scanCanonicalize (H12AffineFastState.compose env6102 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 82) := by decide +kernel

theorem selectedBound6102 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6103 : List Nat := [2,4,8,16,1,64,82,4,91,5,1,16,8,64,0,88,64,0,5,0,17,1,64,88,83,16,1,64,17,1,4,1,5,0,65,90]

theorem envBound6103 : H12AffineFastState.Bounded env6103 := by
  intro p hp
  have h : env6103.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6102_6103 : H12AffineEnvironment.transform 6 82 env6102 = env6103 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 82 env6102 == env6103) = true)

theorem identity6103 : scanCanonicalize (H12AffineFastState.compose env6103 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound6103 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env6104 : List Nat := [2,4,2,16,1,64,82,4,81,5,1,16,2,64,0,82,64,0,5,0,17,1,64,82,83,16,1,64,17,1,4,1,5,0,65,80]

theorem envBound6104 : H12AffineFastState.Bounded env6104 := by
  intro p hp
  have h : env6104.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6103_6104 : H12AffineEnvironment.transform 2 2 env6103 = env6104 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env6103 == env6104) = true)

def leafEnv6104 : List Nat := [2,4,2,16,1,64,82,4,81,5,1,16,2,64,0,82,64,0,5,0,17,1,64,82,5,83,1,16,1,64,17,1,4,1,5,0,4,3,65,80,0,17,1]

def active6104 : List Nat := [0,1,3,5]

def tree6104 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6104 : H12WitnessSearch.Good tree6104 := H12GlobalWitnessIndex.good

theorem leafIdentity6104 : H12AffineFastState.composeSystem env6104 rootObs = leafEnv6104 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6104 rootObs == leafEnv6104) = true)

theorem terminalChecked6104 : H12PackedTerminal.terminalCheckFast leafEnv6104 active6104 tree6104 = true := by decide +kernel

def env6105 : List Nat := [2,4,8,16,32,64,128,256,512,257,2048,4096,8192,16384,10880,65536,20496,680,524288,10880,4097,10249,16384,76676,89047,16464,11173,4176,17,88658,20564,4294967296,20817,4295522681,20497,96607]

theorem envBound6105 : H12AffineFastState.Bounded env6105 := by
  intro p hp
  have h : env6105.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6071_6105 : H12AffineEnvironment.transform 21 10249 env6071 = env6105 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10249 env6071 == env6105) = true)

theorem identity6105 : scanCanonicalize (H12AffineFastState.compose env6105 (packedSelected [11] rootPS)) = affineNative (2^(13+1) ^^^ 2144) := by decide +kernel

theorem selectedBound6105 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env6106 : List Nat := [2,4,8,16,32,64,128,256,512,257,2048,4096,8192,2144,10880,65536,6256,680,524288,10880,4097,10249,2144,76676,70583,2096,11173,4176,17,70194,6196,4294967296,6449,4295504153,6257,78143]

theorem envBound6106 : H12AffineFastState.Bounded env6106 := by
  intro p hp
  have h : env6106.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6105_6106 : H12AffineEnvironment.transform 13 2144 env6105 = env6106 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 2144 env6105 == env6106) = true)

def env6107 : List Nat := [2,4,8,16,32,64,128,256,512,257,680,4096,8192,712,8232,65536,4824,680,524288,8232,4097,8865,712,74028,70583,664,8461,4176,17,70194,4764,4294967296,5017,4295504153,4825,78143]

theorem envBound6107 : H12AffineFastState.Bounded env6107 := by
  intro p hp
  have h : env6107.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6106_6107 : H12AffineEnvironment.transform 10 680 env6106 = env6107 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 680 env6106 == env6107) = true)

theorem identity6107 : scanCanonicalize (H12AffineFastState.compose env6107 (packedSelected [18] rootPS)) = affineNative (2^(15+1) ^^^ 8614) := by decide +kernel

theorem selectedBound6107 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env6108 : List Nat := [2,4,8,16,32,64,128,256,512,257,680,4096,8192,712,8232,8614,4824,680,524288,8232,4097,8865,712,138,12817,664,8461,4176,17,13204,4764,4294967296,5017,4295504153,4825,4249]

theorem envBound6108 : H12AffineFastState.Bounded env6108 := by
  intro p hp
  have h : env6108.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6107_6108 : H12AffineEnvironment.transform 15 8614 env6107 = env6108 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8614 env6107 == env6108) = true)

theorem identity6108 : scanCanonicalize (H12AffineFastState.compose env6108 (packedSelected [0,3,4,5,7,9,10,12] rootPS)) = affineNative (2^(11+1) ^^^ 664) := by decide +kernel

theorem selectedBound6108 : packedSelected [0,3,4,5,7,9,10,12] rootPS < 2^1333 := by decide +kernel

def env6109 : List Nat := [2,4,8,16,32,64,128,256,512,257,680,664,8192,712,8232,8614,64,680,524288,8232,665,8865,712,138,8329,664,8461,712,17,8460,4,4294967296,257,4295500673,65,513]

theorem envBound6109 : H12AffineFastState.Bounded env6109 := by
  intro p hp
  have h : env6109.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6108_6109 : H12AffineEnvironment.transform 11 664 env6108 = env6109 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 664 env6108 == env6109) = true)

theorem identity6109 : scanCanonicalize (H12AffineFastState.compose env6109 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound6109 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env6110 : List Nat := [2,4,8,16,32,64,128,256,137,257,33,17,8192,65,8232,8614,64,33,524288,8232,16,8232,65,138,8329,17,8461,65,17,8460,4,4294967296,257,4295500040,65,136]

theorem envBound6110 : H12AffineFastState.Bounded env6110 := by
  intro p hp
  have h : env6110.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6109_6110 : H12AffineEnvironment.transform 8 137 env6109 = env6110 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6109 == env6110) = true)

theorem identity6110 : scanCanonicalize (H12AffineFastState.compose env6110 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 4) := by decide +kernel

theorem selectedBound6110 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env6111 : List Nat := [2,4,8,16,32,64,128,4,137,5,33,17,8192,65,8232,8354,64,33,524288,8232,16,8232,65,138,8329,17,8201,65,17,8200,4,4294967296,5,4295499788,65,136]

theorem envBound6111 : H12AffineFastState.Bounded env6111 := by
  intro p hp
  have h : env6111.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6110_6111 : H12AffineEnvironment.transform 7 4 env6110 = env6111 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env6110 == env6111) = true)

theorem identity6111 : scanCanonicalize (H12AffineFastState.compose env6111 (packedSelected [1,3,5,10,13] rootPS)) = affineNative (2^(12+1) ^^^ 41) := by decide +kernel

theorem selectedBound6111 : packedSelected [1,3,5,10,13] rootPS < 2^1333 := by decide +kernel

def env6112 : List Nat := [2,4,8,16,32,64,128,4,137,5,33,17,41,65,1,139,64,33,524288,1,16,1,65,138,160,17,32,65,17,33,4,4294967296,5,4295491621,65,136]

theorem envBound6112 : H12AffineFastState.Bounded env6112 := by
  intro p hp
  have h : env6112.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6111_6112 : H12AffineEnvironment.transform 12 41 env6111 = env6112 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 41 env6111 == env6112) = true)

def env6113 : List Nat := [2,4,8,16,0,64,128,4,137,5,1,17,9,65,1,139,64,1,524288,1,16,1,65,138,128,17,0,65,17,1,4,4294967296,5,4295491589,65,136]

theorem envBound6113 : H12AffineFastState.Bounded env6113 := by
  intro p hp
  have h : env6113.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6112_6113 : H12AffineEnvironment.transform 4 0 env6112 = env6113 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env6112 == env6113) = true)

theorem identity6113 : scanCanonicalize (H12AffineFastState.compose env6113 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 210) := by decide +kernel

theorem selectedBound6113 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6114 : List Nat := [2,4,8,16,0,64,128,4,137,5,1,17,9,65,1,139,64,1,524288,1,16,1,65,138,128,17,0,65,17,1,4,210,5,524503,65,136]

theorem envBound6114 : H12AffineFastState.Bounded env6114 := by
  intro p hp
  have h : env6114.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6113_6114 : H12AffineEnvironment.transform 31 210 env6113 = env6114 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 210 env6113 == env6114) = true)

theorem identity6114 : scanCanonicalize (H12AffineFastState.compose env6114 (packedSelected [2,3] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound6114 : packedSelected [2,3] rootPS < 2^1333 := by decide +kernel

def env6115 : List Nat := [2,4,3,16,0,64,128,4,130,5,1,17,2,65,1,128,64,1,524288,1,16,1,65,129,128,17,0,65,17,1,4,210,5,524503,65,131]

theorem envBound6115 : H12AffineFastState.Bounded env6115 := by
  intro p hp
  have h : env6115.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6114_6115 : H12AffineEnvironment.transform 2 3 env6114 = env6115 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env6114 == env6115) = true)

theorem identity6115 : scanCanonicalize (H12AffineFastState.compose env6115 (packedSelected [1] rootPS)) = affineNative (2^(18+1) ^^^ 85) := by decide +kernel

theorem selectedBound6115 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env6116 : List Nat := [2,4,3,16,0,64,128,4,130,5,1,17,2,65,1,128,64,1,85,1,16,1,65,129,128,17,0,65,17,1,4,210,5,130,65,131]

theorem envBound6116 : H12AffineFastState.Bounded env6116 := by
  intro p hp
  have h : env6116.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6115_6116 : H12AffineEnvironment.transform 18 85 env6115 = env6116 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 85 env6115 == env6116) = true)

theorem identity6116 : scanCanonicalize (H12AffineFastState.compose env6116 (packedSelected [2,5] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound6116 : packedSelected [2,5] rootPS < 2^1333 := by decide +kernel

def env6117 : List Nat := [2,4,3,16,0,16,128,4,130,5,1,17,2,17,1,128,16,1,5,1,16,1,17,129,128,17,0,17,17,1,4,130,5,130,17,131]

theorem envBound6117 : H12AffineFastState.Bounded env6117 := by
  intro p hp
  have h : env6117.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6116_6117 : H12AffineEnvironment.transform 5 16 env6116 = env6117 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env6116 == env6117) = true)

def leafEnv6117 : List Nat := [2,4,3,16,0,16,128,4,130,5,1,17,2,17,1,128,16,1,5,1,16,1,17,129,5,128,1,17,0,17,17,1,4,130,5,130,4,2,17,131,0,17,1]

def active6117 : List Nat := [0,1,3,6]

def tree6117 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6117 : H12WitnessSearch.Good tree6117 := H12GlobalWitnessIndex.good

theorem leafIdentity6117 : H12AffineFastState.composeSystem env6117 rootObs = leafEnv6117 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6117 rootObs == leafEnv6117) = true)

theorem terminalChecked6117 : H12PackedTerminal.terminalCheckFast leafEnv6117 active6117 tree6117 = true := by decide +kernel

def env6118 : List Nat := [2,4,8,16,1,64,128,4,137,5,0,17,8,65,1,139,64,0,524288,1,16,1,65,138,129,17,1,65,17,0,4,4294967296,5,4295491588,65,136]

theorem envBound6118 : H12AffineFastState.Bounded env6118 := by
  intro p hp
  have h : env6118.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6112_6118 : H12AffineEnvironment.transform 4 1 env6112 = env6118 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env6112 == env6118) = true)

theorem identity6118 : scanCanonicalize (H12AffineFastState.compose env6118 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 91) := by decide +kernel

theorem selectedBound6118 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env6119 : List Nat := [2,4,8,16,1,64,128,4,137,5,0,17,8,65,1,139,64,0,524288,1,16,1,65,138,129,17,1,65,17,0,4,91,5,524383,65,136]

theorem envBound6119 : H12AffineFastState.Bounded env6119 := by
  intro p hp
  have h : env6119.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6118_6119 : H12AffineEnvironment.transform 31 91 env6118 = env6119 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 91 env6118 == env6119) = true)

theorem identity6119 : scanCanonicalize (H12AffineFastState.compose env6119 (packedSelected [1,2] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound6119 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env6120 : List Nat := [2,4,8,16,1,64,3,4,10,5,0,17,8,65,1,8,64,0,524288,1,16,1,65,9,2,17,1,65,17,0,4,91,5,524383,65,11]

theorem envBound6120 : H12AffineFastState.Bounded env6120 := by
  intro p hp
  have h : env6120.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6119_6120 : H12AffineEnvironment.transform 6 3 env6119 = env6120 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env6119 == env6120) = true)

theorem identity6120 : scanCanonicalize (H12AffineFastState.compose env6120 (packedSelected [3] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound6120 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env6121 : List Nat := [2,4,2,16,1,64,3,4,0,5,0,17,2,65,1,2,64,0,524288,1,16,1,65,3,2,17,1,65,17,0,4,81,5,524373,65,1]

theorem envBound6121 : H12AffineFastState.Bounded env6121 := by
  intro p hp
  have h : env6121.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6120_6121 : H12AffineEnvironment.transform 2 2 env6120 = env6121 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env6120 == env6121) = true)

def leafEnv6121 : List Nat := [2,4,2,16,1,64,3,4,0,5,0,17,2,65,1,2,64,0,524288,1,16,1,65,3,524288,2,1,17,1,65,17,0,4,81,5,524373,4,2,65,1,0,17,1]

def active6121 : List Nat := [0,1,3,5,18]

def tree6121 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood6121 : H12WitnessSearch.Good tree6121 := H12GlobalWitnessIndex.good

theorem leafIdentity6121 : H12AffineFastState.composeSystem env6121 rootObs = leafEnv6121 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env6121 rootObs == leafEnv6121) = true)

theorem terminalChecked6121 : H12PackedTerminal.terminalCheckFast leafEnv6121 active6121 tree6121 = true := by decide +kernel

def env6122 : List Nat := [2,4,8,16,32,64,128,256,512,257,681,4096,8192,713,8233,65536,4825,680,524288,8233,4097,8864,713,74029,70583,665,8460,4176,17,70194,4765,4294967296,5016,4295504153,4824,78143]

theorem envBound6122 : H12AffineFastState.Bounded env6122 := by
  intro p hp
  have h : env6122.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6106_6122 : H12AffineEnvironment.transform 10 681 env6106 = env6122 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 681 env6106 == env6122) = true)

theorem identity6122 : scanCanonicalize (H12AffineFastState.compose env6122 (packedSelected [18] rootPS)) = affineNative (2^(15+1) ^^^ 515) := by decide +kernel

theorem selectedBound6122 : packedSelected [18] rootPS < 2^1333 := by decide +kernel

def env6123 : List Nat := [2,4,8,16,32,64,128,256,512,257,681,4096,8192,713,8233,515,4825,680,524288,8233,4097,8864,713,9006,4532,665,8460,4176,17,4145,4765,4294967296,5016,4295504153,4824,13116]

theorem envBound6123 : H12AffineFastState.Bounded env6123 := by
  intro p hp
  have h : env6123.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6122_6123 : H12AffineEnvironment.transform 15 515 env6122 = env6123 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 515 env6122 == env6123) = true)

theorem identity6123 : scanCanonicalize (H12AffineFastState.compose env6123 (packedSelected [0,3,4,7,8,9,10,12] rootPS)) = affineNative (2^(18+1) ^^^ 905) := by decide +kernel

theorem selectedBound6123 : packedSelected [0,3,4,7,8,9,10,12] rootPS < 2^1333 := by decide +kernel

def env6124 : List Nat := [2,4,8,16,32,64,128,256,512,257,681,4096,8192,713,8233,515,4825,680,905,8233,4097,8864,713,9006,4532,665,8460,4176,17,4145,4765,4294967296,5016,4294980240,4824,13116]

theorem envBound6124 : H12AffineFastState.Bounded env6124 := by
  intro p hp
  have h : env6124.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6123_6124 : H12AffineEnvironment.transform 18 905 env6123 = env6124 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 905 env6123 == env6124) = true)

theorem identity6124 : scanCanonicalize (H12AffineFastState.compose env6124 (packedSelected [3,5,10,15] rootPS)) = affineNative (2^(12+1) ^^^ 301) := by decide +kernel

theorem selectedBound6124 : packedSelected [3,5,10,15] rootPS < 2^1333 := by decide +kernel

def env6125 : List Nat := [2,4,8,16,32,64,128,256,512,257,681,4096,301,713,260,515,4825,680,905,260,4097,909,713,515,4532,665,33,4176,17,4145,4765,4294967296,5016,4294972349,4824,4625]

theorem envBound6125 : H12AffineFastState.Bounded env6125 := by
  intro p hp
  have h : env6125.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6124_6125 : H12AffineEnvironment.transform 12 301 env6124 = env6125 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 301 env6124 == env6125) = true)

theorem identity6125 : scanCanonicalize (H12AffineFastState.compose env6125 (packedSelected [0,4,5,7,8,9] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound6125 : packedSelected [0,4,5,7,8,9] rootPS < 2^1333 := by decide +kernel

def env6126 : List Nat := [2,4,8,16,32,64,128,256,137,257,32,4096,301,64,260,138,4176,33,256,260,4097,260,64,138,4532,16,33,4176,17,4145,4116,4294967296,4369,4294971700,4177,4248]

theorem envBound6126 : H12AffineFastState.Bounded env6126 := by
  intro p hp
  have h : env6126.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans6125_6126 : H12AffineEnvironment.transform 8 137 env6125 = env6126 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env6125 == env6126) = true)

theorem identity6126 : scanCanonicalize (H12AffineFastState.compose env6126 (packedSelected [10,13] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound6126 : packedSelected [10,13] rootPS < 2^1333 := by decide +kernel

def env6127 : List Nat := [2,4,8,16,32,64,128,37,137,36,32,4096,8,64,33,138,4176,33,37,33,4097,33,64,138,4241,16,33,4176,17,4145,4116,4294967296,4148,4294971409,4177,4248]

end H12GlobalChart2
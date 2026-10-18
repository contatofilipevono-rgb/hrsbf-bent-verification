import H12GlobalChart2Data015

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem envBound3907 : H12AffineFastState.Bounded env3907 := by
  intro p hp
  have h : env3907.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3906_3907 : H12AffineEnvironment.transform 14 13382 env3906 = env3907 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13382 env3906 == env3907) = true)

theorem identity3907 : scanCanonicalize (H12AffineFastState.compose env3907 (packedSelected [0,7,16] rootPS)) = affineNative (2^(11+1) ^^^ 1741) := by decide +kernel

theorem selectedBound3907 : packedSelected [0,7,16] rootPS < 2^1333 := by decide +kernel

def env3908 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1741,8192,1693,8843,65536,1740,2090,75265,8843,1740,73864,664,74378,8329,65,76330,1045,1044,76289,1672,4294967296,653,4295041569,1741,513]

theorem envBound3908 : H12AffineFastState.Bounded env3908 := by
  intro p hp
  have h : env3908.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3907_3908 : H12AffineEnvironment.transform 11 1741 env3907 = env3908 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1741 env3907 == env3908) = true)

def env3909 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1741,8192,1693,8843,2176,1740,2090,11905,8843,1740,10248,664,10762,8329,65,8874,1045,1044,8833,1672,4294967296,653,4294978209,1741,513]

theorem envBound3909 : H12AffineFastState.Bounded env3909 := by
  intro p hp
  have h : env3909.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3908_3909 : H12AffineEnvironment.transform 15 2176 env3908 = env3909 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2176 env3908 == env3909) = true)

def env3910 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1741,8192,1693,8843,2177,1740,2090,11904,8843,1740,10249,664,10763,8329,65,8875,1045,1044,8832,1672,4294967296,653,4294978208,1741,513]

theorem envBound3910 : H12AffineFastState.Bounded env3910 := by
  intro p hp
  have h : env3910.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3908_3910 : H12AffineEnvironment.transform 15 2177 env3908 = env3910 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2177 env3908 == env3910) = true)

theorem identity3910 : scanCanonicalize (H12AffineFastState.compose env3910 (packedSelected [0,6] rootPS)) = affineNative (2^(12+1) ^^^ 2689) := by decide +kernel

theorem selectedBound3910 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env3911 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1741,2689,1693,2058,2177,1740,2090,1025,2058,1740,648,664,138,2568,65,2090,1045,1044,2049,1672,4294967296,653,4294967329,1741,513]

theorem envBound3911 : H12AffineFastState.Bounded env3911 := by
  intro p hp
  have h : env3911.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3910_3911 : H12AffineEnvironment.transform 12 2689 env3910 = env3911 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2689 env3910 == env3911) = true)

theorem identity3911 : scanCanonicalize (H12AffineFastState.compose env3911 (packedSelected [2,4] rootPS)) = affineNative (2^(5+1) ^^^ 58) := by decide +kernel

theorem selectedBound3911 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env3912 : List Nat := [2,4,8,16,32,58,128,4,512,1024,2048,1719,2689,1693,2058,2177,1718,2090,1025,2058,1718,648,664,138,2568,59,2090,1045,1044,2049,1672,4294967296,653,4294967329,1719,513]

theorem envBound3912 : H12AffineFastState.Bounded env3912 := by
  intro p hp
  have h : env3912.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3911_3912 : H12AffineEnvironment.transform 5 58 env3911 = env3912 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 58 env3911 == env3912) = true)

def env3913 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,4096,8192,4176,32768,65536,4097,48236,524288,32768,4097,525960,5204,98305,591497,64,568993,1045,1044,81100,4165,4294967296,5185,4295536742,4096,599041]

theorem envBound3913 : H12AffineFastState.Bounded env3913 := by
  intro p hp
  have h : env3913.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3904_3913 : H12AffineEnvironment.transform 7 5 env3904 = env3913 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env3904 == env3913) = true)

theorem identity3913 : scanCanonicalize (H12AffineFastState.compose env3913 (packedSelected [10,12,13,15,17,19] rootPS)) = affineNative (2^(18+1) ^^^ 42634) := by decide +kernel

theorem selectedBound3913 : packedSelected [10,12,13,15,17,19] rootPS < 2^1333 := by decide +kernel

def env3914 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,4096,8192,4176,32768,65536,4097,48236,42634,32768,4097,40962,5204,98305,106499,64,2091,1045,1044,81100,4165,4294967296,5185,4294973164,4096,98955]

theorem envBound3914 : H12AffineFastState.Bounded env3914 := by
  intro p hp
  have h : env3914.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3913_3914 : H12AffineEnvironment.transform 18 42634 env3913 = env3914 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 42634 env3913 == env3914) = true)

theorem identity3914 : scanCanonicalize (H12AffineFastState.compose env3914 (packedSelected [11,18,20] rootPS)) = affineNative (2^(11+1) ^^^ 1092) := by decide +kernel

theorem selectedBound3914 : packedSelected [11,18,20] rootPS < 2^1333 := by decide +kernel

def env3915 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1092,8192,1044,32768,65536,1093,43048,42634,32768,1093,40962,16,98305,106499,64,2091,1045,1044,75912,1025,4294967296,5,4294967976,1092,98955]

theorem envBound3915 : H12AffineFastState.Bounded env3915 := by
  intro p hp
  have h : env3915.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3914_3915 : H12AffineEnvironment.transform 11 1092 env3914 = env3915 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1092 env3914 == env3915) = true)

theorem identity3915 : scanCanonicalize (H12AffineFastState.compose env3915 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(8+1) ^^^ 130) := by decide +kernel

theorem selectedBound3915 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env3916 : List Nat := [2,4,8,16,32,64,128,5,130,1024,2048,1092,8192,1044,32768,65536,1093,43048,41992,32768,1093,40962,16,98305,106499,64,2091,1045,1044,75912,1025,4294967296,5,4294967338,1092,98313]

theorem envBound3916 : H12AffineFastState.Bounded env3916 := by
  intro p hp
  have h : env3916.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3915_3916 : H12AffineEnvironment.transform 8 130 env3915 = env3916 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 130 env3915 == env3916) = true)

theorem identity3916 : scanCanonicalize (H12AffineFastState.compose env3916 (packedSelected [5,12,13,15,21] rootPS)) = affineNative (2^(15+1) ^^^ 8322) := by decide +kernel

theorem selectedBound3916 : packedSelected [5,12,13,15,21] rootPS < 2^1333 := by decide +kernel

def env3917 : List Nat := [2,4,8,16,32,64,128,5,130,1024,2048,1092,8192,1044,32768,8322,1093,43048,41992,32768,1093,40962,16,41091,32897,64,2091,1045,1044,2058,1025,4294967296,5,4294967338,1092,41099]

theorem envBound3917 : H12AffineFastState.Bounded env3917 := by
  intro p hp
  have h : env3917.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3916_3917 : H12AffineEnvironment.transform 15 8322 env3916 = env3917 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8322 env3916 == env3917) = true)

theorem identity3917 : scanCanonicalize (H12AffineFastState.compose env3917 (packedSelected [2,4,7,11,16] rootPS)) = affineNative (2^(31+1) ^^^ 10242) := by decide +kernel

theorem selectedBound3917 : packedSelected [2,4,7,11,16] rootPS < 2^1333 := by decide +kernel

def env3918 : List Nat := [2,4,8,16,32,64,128,5,130,1024,2048,1092,8192,1044,32768,8322,1093,43048,41992,32768,1093,40962,16,41091,32897,64,2091,1045,1044,2058,1025,10242,5,10280,1092,41099]

theorem envBound3918 : H12AffineFastState.Bounded env3918 := by
  intro p hp
  have h : env3918.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3917_3918 : H12AffineEnvironment.transform 31 10242 env3917 = env3918 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 10242 env3917 == env3918) = true)

theorem identity3918 : scanCanonicalize (H12AffineFastState.compose env3918 (packedSelected [4,6,7,10,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 8307) := by decide +kernel

theorem selectedBound3918 : packedSelected [4,6,7,10,12,13] rootPS < 2^1333 := by decide +kernel

def env3919 : List Nat := [2,4,8,16,32,64,128,5,130,1024,2048,1092,8192,1044,8307,8322,1093,2139,1147,8307,1093,113,16,240,8434,64,2091,1045,1044,2058,1025,10242,5,10280,1092,248]

theorem envBound3919 : H12AffineFastState.Bounded env3919 := by
  intro p hp
  have h : env3919.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3918_3919 : H12AffineEnvironment.transform 14 8307 env3918 = env3919 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8307 env3918 == env3919) = true)

theorem identity3919 : scanCanonicalize (H12AffineFastState.compose env3919 (packedSelected [2,3,4,9,10,12] rootPS)) = affineNative (2^(5+1) ^^^ 48) := by decide +kernel

theorem selectedBound3919 : packedSelected [2,3,4,9,10,12] rootPS < 2^1333 := by decide +kernel

def env3920 : List Nat := [2,4,8,16,32,48,128,5,130,1024,2048,1076,8192,1044,8195,8322,1077,2091,1035,8195,1077,1,16,128,8322,48,2091,1045,1044,2058,1025,10242,5,10280,1076,136]

theorem envBound3920 : H12AffineFastState.Bounded env3920 := by
  intro p hp
  have h : env3920.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3919_3920 : H12AffineEnvironment.transform 5 48 env3919 = env3920 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 48 env3919 == env3920) = true)

theorem identity3920 : scanCanonicalize (H12AffineFastState.compose env3920 (packedSelected [0,1,3,4] rootPS)) = affineNative (2^(12+1) ^^^ 2088) := by decide +kernel

theorem selectedBound3920 : packedSelected [0,1,3,4] rootPS < 2^1333 := by decide +kernel

def env3921 : List Nat := [2,4,8,16,32,48,128,5,130,1024,2048,1076,2088,1044,2091,2218,1077,2091,1035,2091,1077,1,16,128,2218,48,2091,1045,1044,2058,1025,42,5,0,1076,136]

theorem envBound3921 : H12AffineFastState.Bounded env3921 := by
  intro p hp
  have h : env3921.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3920_3921 : H12AffineEnvironment.transform 12 2088 env3920 = env3921 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2088 env3920 == env3921) = true)

theorem identity3921 : scanCanonicalize (H12AffineFastState.compose env3921 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound3921 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3922 : List Nat := [2,4,8,16,10,26,128,5,130,1024,2048,1054,2050,1044,2049,2176,1055,2049,1035,2049,1055,1,16,128,2176,26,2049,1045,1044,2058,1025,0,5,0,1054,136]

theorem envBound3922 : H12AffineFastState.Bounded env3922 := by
  intro p hp
  have h : env3922.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3921_3922 : H12AffineEnvironment.transform 4 10 env3921 = env3922 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env3921 == env3922) = true)

theorem identity3922 : scanCanonicalize (H12AffineFastState.compose env3922 (packedSelected [0,6,7] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound3922 : packedSelected [0,6,7] rootPS < 2^1333 := by decide +kernel

def env3923 : List Nat := [2,4,2,16,0,16,128,5,130,1024,2048,1044,2050,1044,2049,2176,1045,2049,1025,2049,1045,1,16,128,2176,16,2049,1045,1044,2048,1025,0,5,0,1044,130]

theorem envBound3923 : H12AffineFastState.Bounded env3923 := by
  intro p hp
  have h : env3923.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3922_3923 : H12AffineEnvironment.transform 2 2 env3922 = env3923 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env3922 == env3923) = true)

theorem identity3923 : scanCanonicalize (H12AffineFastState.compose env3923 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 17) := by decide +kernel

theorem selectedBound3923 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3924 : List Nat := [2,4,2,16,0,16,17,5,19,1024,2048,1044,2050,1044,2049,2065,1045,2049,1025,2049,1045,1,16,17,2065,16,2049,1045,1044,2048,1025,0,5,0,1044,19]

theorem envBound3924 : H12AffineFastState.Bounded env3924 := by
  intro p hp
  have h : env3924.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3923_3924 : H12AffineEnvironment.transform 6 17 env3923 = env3924 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 17 env3923 == env3924) = true)

theorem identity3924 : scanCanonicalize (H12AffineFastState.compose env3924 (packedSelected [1] rootPS)) = affineNative (2^(10+1) ^^^ 1029) := by decide +kernel

theorem selectedBound3924 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3925 : List Nat := [2,4,2,16,0,16,17,5,19,1024,1029,1044,1031,1044,1028,1044,1045,1028,1025,1028,1045,1,16,17,1044,16,1028,1045,1044,1029,1025,0,5,0,1044,19]

theorem envBound3925 : H12AffineFastState.Bounded env3925 := by
  intro p hp
  have h : env3925.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3924_3925 : H12AffineEnvironment.transform 10 1029 env3924 = env3925 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1029 env3924 == env3925) = true)

theorem identity3925 : scanCanonicalize (H12AffineFastState.compose env3925 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound3925 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env3926 : List Nat := [2,4,2,2,0,2,3,5,1,1024,1029,1030,1031,1030,1028,1030,1031,1028,1025,1028,1031,1,2,3,1030,2,1028,1031,1030,1029,1025,0,5,0,1030,1]

theorem envBound3926 : H12AffineFastState.Bounded env3926 := by
  intro p hp
  have h : env3926.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3925_3926 : H12AffineEnvironment.transform 3 2 env3925 = env3926 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env3925 == env3926) = true)

theorem identity3926 : scanCanonicalize (H12AffineFastState.compose env3926 (packedSelected [6] rootPS)) = affineNative (2^(9+1) ^^^ 5) := by decide +kernel

theorem selectedBound3926 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env3927 : List Nat := [2,4,2,2,0,2,3,5,1,5,0,3,2,3,1,3,2,1,4,1,2,1,2,3,3,2,1,2,3,0,4,0,5,0,3,1]

theorem envBound3927 : H12AffineFastState.Bounded env3927 := by
  intro p hp
  have h : env3927.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3926_3927 : H12AffineEnvironment.transform 9 5 env3926 = env3927 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 5 env3926 == env3927) = true)

def leafEnv3927 : List Nat := [2,4,2,2,0,2,3,5,1,5,0,3,2,3,1,3,2,1,4,1,2,1,2,3,5,3,1,2,1,2,3,0,4,0,5,0,4,2,3,1,0,2,1]

def active3927 : List Nat := [0,1]

def tree3927 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood3927 : H12WitnessSearch.Good tree3927 := H12GlobalWitnessIndex.good

theorem leafIdentity3927 : H12AffineFastState.composeSystem env3927 rootObs = leafEnv3927 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env3927 rootObs == leafEnv3927) = true)

theorem terminalChecked3927 : H12PackedTerminal.terminalCheckFast leafEnv3927 active3927 tree3927 = true := by decide +kernel

def env3928 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,524288,32768,4097,526221,5457,98305,591756,325,791496,1045,1044,360609,4165,4294967296,5444,4295536742,4096,599300]

theorem envBound3928 : H12AffineFastState.Bounded env3928 := by
  intro p hp
  have h : env3928.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3902_3928 : H12AffineEnvironment.transform 29 360609 env3902 = env3928 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360609 env3902 == env3928) = true)

theorem identity3928 : scanCanonicalize (H12AffineFastState.compose env3928 (packedSelected [3,5,8,17,21,28] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound3928 : packedSelected [3,5,8,17,21,28] rootPS < 2^1333 := by decide +kernel

def env3929 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,4097,262144,524288,32768,4097,526221,5377,98305,591756,277,791448,1045,1044,360609,4117,4294967296,5396,4295536694,4096,599300]

theorem envBound3929 : H12AffineFastState.Bounded env3929 := by
  intro p hp
  have h : env3929.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3928_3929 : H12AffineEnvironment.transform 5 16 env3928 = env3929 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env3928 == env3929) = true)

def env3930 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,4194304,5457,16777216,4395009,17011013,4588612,17011733,16876565,1073741824,131140,4294967296,17007940,4295536743,131073,4403849]

theorem envBound3930 : H12AffineFastState.Bounded env3930 := by
  intro p hp
  have h : env3930.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3742_3930 : H12AffineEnvironment.transform 24 4395009 env3742 = env3930 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 4395009 env3742 == env3930) = true)

def env3931 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,524288,32768,4097,4194304,5457,16777216,4259841,16875845,4461636,16876565,16876565,1073741824,4164,4294967296,16880964,4295536743,4097,4268681]

theorem envBound3931 : H12AffineFastState.Bounded env3931 := by
  intro p hp
  have h : env3931.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3930_3931 : H12AffineEnvironment.transform 16 4096 env3930 = env3931 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4096 env3930 == env3931) = true)

def env3932 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,524288,32768,4097,4194304,5457,98304,4259841,325,4461636,1045,1045,1073741824,4164,4294967296,5444,4295536743,4097,4268681]

theorem envBound3932 : H12AffineFastState.Bounded env3932 := by
  intro p hp
  have h : env3932.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3931_3932 : H12AffineEnvironment.transform 23 98304 env3931 = env3932 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98304 env3931 == env3932) = true)

theorem identity3932 : scanCanonicalize (H12AffineFastState.compose env3932 (packedSelected [3,5,24] rootPS)) = affineNative (2^(15+1) ^^^ 13768) := by decide +kernel

theorem selectedBound3932 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env3933 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,13768,4096,262144,524288,32768,4097,4194304,5457,46536,4208073,325,4461636,1045,1045,1073741824,4164,4294967296,5444,4295536743,4097,4200257]

theorem envBound3933 : H12AffineFastState.Bounded env3933 := by
  intro p hp
  have h : env3933.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3932_3933 : H12AffineEnvironment.transform 15 13768 env3932 = env3933 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 13768 env3932 == env3933) = true)

def env3934 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,13720,4096,262144,524288,32768,4097,4194304,5377,46488,4208025,277,4461588,1045,1045,1073741824,4116,4294967296,5396,4295536695,4097,4200209]

theorem envBound3934 : H12AffineFastState.Bounded env3934 := by
  intro p hp
  have h : env3934.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3933_3934 : H12AffineEnvironment.transform 5 16 env3933 = env3934 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env3933 == env3934) = true)

theorem identity3934 : scanCanonicalize (H12AffineFastState.compose env3934 (packedSelected [3,5,8,17,21,28] rootPS)) = affineNative (2^(29+1) ^^^ 308537) := by decide +kernel

theorem selectedBound3934 : packedSelected [3,5,8,17,21,28] rootPS < 2^1333 := by decide +kernel

def env3935 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,13720,4096,262144,524288,32768,4097,4194304,5377,46488,4208025,277,4461588,1045,1045,308537,4116,4294967296,5396,4295536695,4097,4200209]

theorem envBound3935 : H12AffineFastState.Bounded env3935 := by
  intro p hp
  have h : env3935.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3934_3935 : H12AffineEnvironment.transform 29 308537 env3934 = env3935 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 308537 env3934 == env3935) = true)

theorem identity3935 : scanCanonicalize (H12AffineFastState.compose env3935 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(17+1) ^^^ 48188) := by decide +kernel

theorem selectedBound3935 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env3936 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,13720,4096,48188,524288,32768,4097,4194304,5377,46488,4208025,277,4237352,1045,1045,2309,4116,4294967296,5396,4295536695,4097,4200209]

theorem envBound3936 : H12AffineFastState.Bounded env3936 := by
  intro p hp
  have h : env3936.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3935_3936 : H12AffineEnvironment.transform 17 48188 env3935 = env3936 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 48188 env3935 == env3936) = true)

def env3937 : List Nat := [2,4,8,16,32,16,128,4,512,1024,2048,4096,8192,4096,32768,13468,4096,48188,524288,32768,4097,4194304,5125,46236,4207773,17,4237352,1045,1045,2049,4116,4294967296,5136,4295536695,4097,4199957]

theorem envBound3937 : H12AffineFastState.Bounded env3937 := by
  intro p hp
  have h : env3937.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3936_3937 : H12AffineEnvironment.transform 7 4 env3936 = env3937 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env3936 == env3937) = true)

theorem identity3937 : scanCanonicalize (H12AffineFastState.compose env3937 (packedSelected [1,3,5,8,13,17] rootPS)) = affineNative (2^(21+1) ^^^ 5183) := by decide +kernel

theorem selectedBound3937 : packedSelected [1,3,5,8,13,17] rootPS < 2^1333 := by decide +kernel

def env3938 : List Nat := [2,4,8,16,32,16,128,4,512,1024,2048,4096,8192,4096,32768,13468,4096,48188,524288,32768,4097,5183,5125,46236,8354,17,48151,1045,1045,2049,4116,4294967296,5136,4295536695,4097,554]

theorem envBound3938 : H12AffineFastState.Bounded env3938 := by
  intro p hp
  have h : env3938.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3937_3938 : H12AffineEnvironment.transform 21 5183 env3937 = env3938 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5183 env3937 == env3938) = true)

theorem identity3938 : scanCanonicalize (H12AffineFastState.compose env3938 (packedSelected [1,3,5,8,10,12,15,19] rootPS)) = affineNative (2^(14+1) ^^^ 13372) := by decide +kernel

theorem selectedBound3938 : packedSelected [1,3,5,8,10,12,15,19] rootPS < 2^1333 := by decide +kernel

def env3939 : List Nat := [2,4,8,16,32,16,128,4,512,1024,2048,4096,8192,4096,13372,13468,4096,2048,524288,13372,4097,5183,5125,160,8354,17,2091,1045,1045,2049,4116,4294967296,5136,4295492619,4097,554]

theorem envBound3939 : H12AffineFastState.Bounded env3939 := by
  intro p hp
  have h : env3939.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3938_3939 : H12AffineEnvironment.transform 14 13372 env3938 = env3939 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13372 env3938 == env3939) = true)

theorem identity3939 : scanCanonicalize (H12AffineFastState.compose env3939 (packedSelected [0,4,7,9,16,18] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound3939 : packedSelected [0,4,7,9,16,18] rootPS < 2^1333 := by decide +kernel

def env3940 : List Nat := [2,4,8,16,10,16,128,4,512,1024,2048,4096,8192,4096,13334,13468,4096,2048,524288,13334,4097,5141,5125,138,8328,17,2049,1045,1045,2049,4116,4294967296,5136,4295492619,4097,512]

theorem envBound3940 : H12AffineFastState.Bounded env3940 := by
  intro p hp
  have h : env3940.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3939_3940 : H12AffineEnvironment.transform 4 10 env3939 = env3940 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env3939 == env3940) = true)

theorem identity3940 : scanCanonicalize (H12AffineFastState.compose env3940 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(12+1) ^^^ 7702) := by decide +kernel

theorem selectedBound3940 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env3941 : List Nat := [2,4,8,16,10,16,128,4,512,1024,2048,4096,7702,4096,2560,2698,4096,2048,524288,2560,4097,5141,5125,138,7838,17,2049,1045,1045,2049,4116,4294967296,5136,4295492619,4097,512]

theorem envBound3941 : H12AffineFastState.Bounded env3941 := by
  intro p hp
  have h : env3941.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3940_3941 : H12AffineEnvironment.transform 12 7702 env3940 = env3941 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 7702 env3940 == env3941) = true)

theorem identity3941 : scanCanonicalize (H12AffineFastState.compose env3941 (packedSelected [4,9] rootPS)) = affineNative (2^(18+1) ^^^ 1160) := by decide +kernel

theorem selectedBound3941 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env3942 : List Nat := [2,4,8,16,10,16,128,4,512,1024,2048,4096,7702,4096,2560,2698,4096,2048,1160,2560,4097,5141,5125,138,7838,17,2049,1045,1045,2049,4116,4294967296,5136,4294967427,4097,512]

theorem envBound3942 : H12AffineFastState.Bounded env3942 := by
  intro p hp
  have h : env3942.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3941_3942 : H12AffineEnvironment.transform 18 1160 env3941 = env3942 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1160 env3941 == env3942) = true)

theorem identity3942 : scanCanonicalize (H12AffineFastState.compose env3942 (packedSelected [2,3,4,5,8,10] rootPS)) = affineNative (2^(11+1) ^^^ 641) := by decide +kernel

theorem selectedBound3942 : packedSelected [2,3,4,5,8,10] rootPS < 2^1333 := by decide +kernel

def env3943 : List Nat := [2,4,8,16,10,16,128,4,512,1024,2048,641,3223,641,2560,2698,641,2048,1160,2560,640,1684,1668,138,3103,17,2049,1045,1045,2049,661,4294967296,1681,4294967427,640,512]

theorem envBound3943 : H12AffineFastState.Bounded env3943 := by
  intro p hp
  have h : env3943.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3942_3943 : H12AffineEnvironment.transform 11 641 env3942 = env3943 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 641 env3942 == env3943) = true)

theorem identity3943 : scanCanonicalize (H12AffineFastState.compose env3943 (packedSelected [11] rootPS)) = affineNative (2^(10+1) ^^^ 1172) := by decide +kernel

theorem selectedBound3943 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env3944 : List Nat := [2,4,8,16,10,16,128,4,512,1024,1172,641,3,641,1684,1566,641,1172,1160,1684,640,1684,1668,138,139,17,1173,1045,1045,1173,661,4294967296,1681,4294967427,640,512]

theorem envBound3944 : H12AffineFastState.Bounded env3944 := by
  intro p hp
  have h : env3944.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3943_3944 : H12AffineEnvironment.transform 10 1172 env3943 = env3944 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1172 env3943 == env3944) = true)

theorem identity3944 : scanCanonicalize (H12AffineFastState.compose env3944 (packedSelected [0,1,2,3,4,5,6,8,12] rootPS)) = affineNative (2^(6+1) ^^^ 27) := by decide +kernel

theorem selectedBound3944 : packedSelected [0,1,2,3,4,5,6,8,12] rootPS < 2^1333 := by decide +kernel

def env3945 : List Nat := [2,4,8,16,10,16,27,4,512,1024,1039,538,3,538,1551,1566,538,1039,1043,1551,539,1551,1567,17,16,17,1038,1045,1045,1038,526,4294967296,1546,4294967320,539,512]

theorem envBound3945 : H12AffineFastState.Bounded env3945 := by
  intro p hp
  have h : env3945.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3944_3945 : H12AffineEnvironment.transform 6 27 env3944 = env3945 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 27 env3944 == env3945) = true)

theorem identity3945 : scanCanonicalize (H12AffineFastState.compose env3945 (packedSelected [0,1,2,3,4,5] rootPS)) = affineNative (2^(31+1) ^^^ 1558) := by decide +kernel

theorem selectedBound3945 : packedSelected [0,1,2,3,4,5] rootPS < 2^1333 := by decide +kernel

def env3946 : List Nat := [2,4,8,16,10,16,27,4,512,1024,1039,538,3,538,1551,1566,538,1039,1043,1551,539,1551,1567,17,16,17,1038,1045,1045,1038,526,1558,1546,1550,539,512]

theorem envBound3946 : H12AffineFastState.Bounded env3946 := by
  intro p hp
  have h : env3946.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3945_3946 : H12AffineEnvironment.transform 31 1558 env3945 = env3946 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1558 env3945 == env3946) = true)

theorem identity3946 : scanCanonicalize (H12AffineFastState.compose env3946 (packedSelected [3] rootPS)) = affineNative (2^(8+1) ^^^ 10) := by decide +kernel

theorem selectedBound3946 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env3947 : List Nat := [2,4,8,16,10,16,27,4,10,1024,1039,16,3,16,1029,1044,16,1039,1043,1029,17,1029,1045,17,16,17,1038,1045,1045,1038,4,1052,1024,1028,17,10]

theorem envBound3947 : H12AffineFastState.Bounded env3947 := by
  intro p hp
  have h : env3947.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3946_3947 : H12AffineEnvironment.transform 8 10 env3946 = env3947 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 10 env3946 == env3947) = true)

theorem identity3947 : scanCanonicalize (H12AffineFastState.compose env3947 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound3947 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3948 : List Nat := [2,4,8,2,10,2,9,4,10,1024,1039,2,3,2,1029,1030,2,1039,1025,1029,3,1029,1031,3,2,3,1038,1031,1031,1038,4,1038,1024,1028,3,10]

theorem envBound3948 : H12AffineFastState.Bounded env3948 := by
  intro p hp
  have h : env3948.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3947_3948 : H12AffineEnvironment.transform 3 2 env3947 = env3948 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env3947 == env3948) = true)

theorem identity3948 : scanCanonicalize (H12AffineFastState.compose env3948 (packedSelected [1] rootPS)) = affineNative (2^(9+1) ^^^ 15) := by decide +kernel

theorem selectedBound3948 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3949 : List Nat := [2,4,8,2,10,2,9,4,10,15,0,2,3,2,10,9,2,0,14,10,3,10,8,3,2,3,1,8,8,1,4,1,15,11,3,10]

theorem envBound3949 : H12AffineFastState.Bounded env3949 := by
  intro p hp
  have h : env3949.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3948_3949 : H12AffineEnvironment.transform 9 15 env3948 = env3949 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 15 env3948 == env3949) = true)

theorem identity3949 : scanCanonicalize (H12AffineFastState.compose env3949 (packedSelected [6] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound3949 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env3950 : List Nat := [2,4,3,2,1,2,2,4,1,4,0,2,3,2,1,2,2,0,5,1,3,1,3,3,2,3,1,3,3,1,4,1,4,0,3,1]

theorem envBound3950 : H12AffineFastState.Bounded env3950 := by
  intro p hp
  have h : env3950.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3949_3950 : H12AffineEnvironment.transform 2 3 env3949 = env3950 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env3949 == env3950) = true)

def env3951 : List Nat := [2,4,8,16,32,16,128,5,512,1024,2048,4096,8192,4096,32768,13469,4096,48188,524288,32768,4097,4194304,5124,46237,4207772,16,4237352,1045,1045,2048,4116,4294967296,5137,4295536695,4097,4199956]

theorem envBound3951 : H12AffineFastState.Bounded env3951 := by
  intro p hp
  have h : env3951.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3936_3951 : H12AffineEnvironment.transform 7 5 env3936 = env3951 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env3936 == env3951) = true)

theorem identity3951 : scanCanonicalize (H12AffineFastState.compose env3951 (packedSelected [1,3,5,8,13,17] rootPS)) = affineNative (2^(21+1) ^^^ 5140) := by decide +kernel

theorem selectedBound3951 : packedSelected [1,3,5,8,13,17] rootPS < 2^1333 := by decide +kernel

def env3952 : List Nat := [2,4,8,16,32,16,128,5,512,1024,2048,4096,8192,4096,32768,13469,4096,48188,524288,32768,4097,5140,5124,46237,8328,16,48188,1045,1045,2048,4116,4294967296,5137,4295536695,4097,512]

theorem envBound3952 : H12AffineFastState.Bounded env3952 := by
  intro p hp
  have h : env3952.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3951_3952 : H12AffineEnvironment.transform 21 5140 env3951 = env3952 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5140 env3951 == env3952) = true)

theorem identity3952 : scanCanonicalize (H12AffineFastState.compose env3952 (packedSelected [4,9] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound3952 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env3953 : List Nat := [2,4,8,16,32,16,8,5,512,1024,2048,4096,8192,4096,32768,13333,4096,48188,524288,32768,4097,5140,5124,46101,8192,16,48188,1045,1045,2048,4116,4294967296,5137,4295536695,4097,512]

theorem envBound3953 : H12AffineFastState.Bounded env3953 := by
  intro p hp
  have h : env3953.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3952_3953 : H12AffineEnvironment.transform 6 8 env3952 = env3953 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env3952 == env3953) = true)

theorem identity3953 : scanCanonicalize (H12AffineFastState.compose env3953 (packedSelected [0,6] rootPS)) = affineNative (2^(10+1) ^^^ 35) := by decide +kernel

theorem selectedBound3953 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env3954 : List Nat := [2,4,8,16,32,16,8,5,512,1024,35,4096,8192,4096,32768,13333,4096,46111,524288,32768,4097,5140,5124,46101,8192,16,46111,1045,1045,35,4116,4294967296,5137,4295536695,4097,512]

theorem envBound3954 : H12AffineFastState.Bounded env3954 := by
  intro p hp
  have h : env3954.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3953_3954 : H12AffineEnvironment.transform 10 35 env3953 = env3954 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 35 env3953 == env3954) = true)

theorem identity3954 : scanCanonicalize (H12AffineFastState.compose env3954 (packedSelected [0,1,5,7,8,12,13] rootPS)) = affineNative (2^(12+1) ^^^ 1030) := by decide +kernel

theorem selectedBound3954 : packedSelected [0,1,5,7,8,12,13] rootPS < 2^1333 := by decide +kernel

def env3955 : List Nat := [2,4,8,16,32,16,8,5,512,1024,35,4096,1030,4096,32768,4115,4096,36889,524288,32768,4097,5140,5124,36883,1030,16,36889,1045,1045,35,4116,4294967296,5137,4295529521,4097,512]

theorem envBound3955 : H12AffineFastState.Bounded env3955 := by
  intro p hp
  have h : env3955.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3954_3955 : H12AffineEnvironment.transform 12 1030 env3954 = env3955 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1030 env3954 == env3955) = true)

theorem identity3955 : scanCanonicalize (H12AffineFastState.compose env3955 (packedSelected [0,7,12,15] rootPS)) = affineNative (2^(11+1) ^^^ 16) := by decide +kernel

theorem selectedBound3955 : packedSelected [0,7,12,15] rootPS < 2^1333 := by decide +kernel

def env3956 : List Nat := [2,4,8,16,32,16,8,5,512,1024,35,16,1030,16,32768,3,16,32777,524288,32768,17,1028,1044,32771,1030,16,32777,1045,1045,35,4,4294967296,1025,4295525409,17,512]

theorem envBound3956 : H12AffineFastState.Bounded env3956 := by
  intro p hp
  have h : env3956.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3955_3956 : H12AffineEnvironment.transform 11 16 env3955 = env3956 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 16 env3955 == env3956) = true)

theorem identity3956 : scanCanonicalize (H12AffineFastState.compose env3956 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 1061) := by decide +kernel

theorem selectedBound3956 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3957 : List Nat := [2,4,8,16,32,16,8,5,512,1024,35,16,1030,16,32768,3,16,32777,524288,32768,17,1028,1044,32771,1030,16,32777,1045,1045,35,4,1061,1025,557060,17,512]

theorem envBound3957 : H12AffineFastState.Bounded env3957 := by
  intro p hp
  have h : env3957.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3956_3957 : H12AffineEnvironment.transform 31 1061 env3956 = env3957 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1061 env3956 == env3957) = true)

def env3958 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,13721,4096,262144,524288,32768,4097,4194304,5376,46489,4208024,276,4461589,1045,1045,1073741824,4117,4294967296,5397,4295536694,4097,4200208]

theorem envBound3958 : H12AffineFastState.Bounded env3958 := by
  intro p hp
  have h : env3958.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3933_3958 : H12AffineEnvironment.transform 5 17 env3933 = env3958 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env3933 == env3958) = true)

def env3959 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,4096,8192,4097,32768,13469,4096,262144,524288,32768,4097,4194304,5124,46237,4207772,16,4461589,1045,1045,1073741824,4117,4294967296,5137,4295536694,4097,4199956]

theorem envBound3959 : H12AffineFastState.Bounded env3959 := by
  intro p hp
  have h : env3959.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3958_3959 : H12AffineEnvironment.transform 7 4 env3958 = env3959 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env3958 == env3959) = true)

theorem identity3959 : scanCanonicalize (H12AffineFastState.compose env3959 (packedSelected [10,12,13,15,17,19] rootPS)) = affineNative (2^(29+1) ^^^ 4461631) := by decide +kernel

theorem selectedBound3959 : packedSelected [10,12,13,15,17,19] rootPS < 2^1333 := by decide +kernel

def env3960 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,4096,8192,4097,32768,13469,4096,262144,524288,32768,4097,4194304,5124,46237,4207772,16,4461589,1045,1045,4461631,4117,4294967296,5137,4295536694,4097,4199956]

theorem envBound3960 : H12AffineFastState.Bounded env3960 := by
  intro p hp
  have h : env3960.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3959_3960 : H12AffineEnvironment.transform 29 4461631 env3959 = env3960 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4461631 env3959 == env3960) = true)

theorem identity3960 : scanCanonicalize (H12AffineFastState.compose env3960 (packedSelected [5,12,13,15,21] rootPS)) = affineNative (2^(21+1) ^^^ 525312) := by decide +kernel

theorem selectedBound3960 : packedSelected [5,12,13,15,21] rootPS < 2^1333 := by decide +kernel

def env3961 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,4096,8192,4097,32768,13469,4096,262144,524288,32768,4097,525312,5124,46237,536732,16,790549,1045,1045,790591,4117,4294967296,5137,4295536694,4097,528916]

theorem envBound3961 : H12AffineFastState.Bounded env3961 := by
  intro p hp
  have h : env3961.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3960_3961 : H12AffineEnvironment.transform 21 525312 env3960 = env3961 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 525312 env3960 == env3961) = true)

theorem identity3961 : scanCanonicalize (H12AffineFastState.compose env3961 (packedSelected [1,3,5,8,12,13,15,17] rootPS)) = affineNative (2^(11+1) ^^^ 1045) := by decide +kernel

theorem selectedBound3961 : packedSelected [1,3,5,8,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env3962 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,1045,8192,1044,32768,8328,1045,262144,524288,32768,1044,525312,17,41096,533641,16,787456,1045,1045,787498,1024,4294967296,4,4295533603,1044,525825]

theorem envBound3962 : H12AffineFastState.Bounded env3962 := by
  intro p hp
  have h : env3962.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3961_3962 : H12AffineEnvironment.transform 11 1045 env3961 = env3962 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1045 env3961 == env3962) = true)

theorem identity3962 : scanCanonicalize (H12AffineFastState.compose env3962 (packedSelected [5,8] rootPS)) = affineNative (2^(18+1) ^^^ 41993) := by decide +kernel

theorem selectedBound3962 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env3963 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,1045,8192,1044,32768,8328,1045,262144,41993,32768,1044,40969,17,41096,32896,16,303113,1045,1045,303139,1024,4294967296,4,4294967338,1044,41480]

theorem envBound3963 : H12AffineFastState.Bounded env3963 := by
  intro p hp
  have h : env3963.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3962_3963 : H12AffineEnvironment.transform 18 41993 env3962 = env3963 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 41993 env3962 == env3963) = true)

theorem identity3963 : scanCanonicalize (H12AffineFastState.compose env3963 (packedSelected [0,4,7,16,20,22] rootPS)) = affineNative (2^(17+1) ^^^ 43048) := by decide +kernel

theorem selectedBound3963 : packedSelected [0,4,7,16,20,22] rootPS < 2^1333 := by decide +kernel

def env3964 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,1045,8192,1044,32768,8328,1045,43048,41993,32768,1044,40969,17,41096,32896,16,2081,1045,1045,2059,1024,4294967296,4,4294967338,1044,41480]

theorem envBound3964 : H12AffineFastState.Bounded env3964 := by
  intro p hp
  have h : env3964.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3963_3964 : H12AffineEnvironment.transform 17 43048 env3963 = env3964 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43048 env3963 == env3964) = true)

theorem identity3964 : scanCanonicalize (H12AffineFastState.compose env3964 (packedSelected [1,3,4,9,12,15,16] rootPS)) = affineNative (2^(14+1) ^^^ 8200) := by decide +kernel

theorem selectedBound3964 : packedSelected [1,3,4,9,12,15,16] rootPS < 2^1333 := by decide +kernel

def env3965 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,1045,8192,1044,8200,8328,1045,2080,1025,8200,1044,1,17,128,8328,16,2081,1045,1045,2059,1024,4294967296,4,4294967338,1044,512]

theorem envBound3965 : H12AffineFastState.Bounded env3965 := by
  intro p hp
  have h : env3965.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3964_3965 : H12AffineEnvironment.transform 14 8200 env3964 = env3965 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8200 env3964 == env3965) = true)

theorem identity3965 : scanCanonicalize (H12AffineFastState.compose env3965 (packedSelected [1] rootPS)) = affineNative (2^(12+1) ^^^ 1711) := by decide +kernel

theorem selectedBound3965 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env3966 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,1045,1711,1044,1703,1575,1045,2080,1025,1703,1044,1,17,128,1575,16,2081,1045,1045,2059,1024,4294967296,4,4294967338,1044,512]

theorem envBound3966 : H12AffineFastState.Bounded env3966 := by
  intro p hp
  have h : env3966.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3965_3966 : H12AffineEnvironment.transform 12 1711 env3965 = env3966 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1711 env3965 == env3966) = true)

theorem identity3966 : scanCanonicalize (H12AffineFastState.compose env3966 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 1540) := by decide +kernel

theorem selectedBound3966 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env3967 : List Nat := [2,4,8,16,32,17,128,4,512,1024,2048,1045,1711,1044,1703,1575,1045,2080,1025,1703,1044,1,17,128,1575,16,2081,1045,1045,2059,1024,1540,4,1582,1044,512]

theorem envBound3967 : H12AffineFastState.Bounded env3967 := by
  intro p hp
  have h : env3967.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3966_3967 : H12AffineEnvironment.transform 31 1540 env3966 = env3967 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1540 env3966 == env3967) = true)

theorem identity3967 : scanCanonicalize (H12AffineFastState.compose env3967 (packedSelected [10] rootPS)) = affineNative (2^(9+1) ^^^ 559) := by decide +kernel

theorem selectedBound3967 : packedSelected [10] rootPS < 2^1333 := by decide +kernel

def env3968 : List Nat := [2,4,8,16,32,17,128,4,512,559,2048,570,128,571,136,8,570,2080,558,136,571,1,17,128,8,16,2081,570,570,2059,559,43,4,1,571,512]

theorem envBound3968 : H12AffineFastState.Bounded env3968 := by
  intro p hp
  have h : env3968.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3967_3968 : H12AffineEnvironment.transform 9 559 env3967 = env3968 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 559 env3967 == env3968) = true)

theorem identity3968 : scanCanonicalize (H12AffineFastState.compose env3968 (packedSelected [4,7,11] rootPS)) = affineNative (2^(10+1) ^^^ 131) := by decide +kernel

theorem selectedBound3968 : packedSelected [4,7,11] rootPS < 2^1333 := by decide +kernel

def env3969 : List Nat := [2,4,8,16,32,17,128,4,512,559,131,570,128,571,136,8,570,163,558,136,571,1,17,128,8,16,162,570,570,136,559,43,4,1,571,512]

theorem envBound3969 : H12AffineFastState.Bounded env3969 := by
  intro p hp
  have h : env3969.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3968_3969 : H12AffineEnvironment.transform 10 131 env3968 = env3969 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 131 env3968 == env3969) = true)

theorem identity3969 : scanCanonicalize (H12AffineFastState.compose env3969 (packedSelected [0,2,7] rootPS)) = affineNative (2^(8+1) ^^^ 162) := by decide +kernel

theorem selectedBound3969 : packedSelected [0,2,7] rootPS < 2^1333 := by decide +kernel

def env3970 : List Nat := [2,4,8,16,32,17,128,4,162,141,131,152,128,153,136,8,152,163,140,136,153,1,17,128,8,16,162,152,152,136,141,43,4,1,153,162]

theorem envBound3970 : H12AffineFastState.Bounded env3970 := by
  intro p hp
  have h : env3970.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3969_3970 : H12AffineEnvironment.transform 8 162 env3969 = env3970 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 162 env3969 == env3970) = true)

theorem identity3970 : scanCanonicalize (H12AffineFastState.compose env3970 (packedSelected [0,9] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound3970 : packedSelected [0,9] rootPS < 2^1333 := by decide +kernel

def env3971 : List Nat := [2,4,2,16,32,17,128,4,162,135,131,146,128,147,130,2,146,163,134,130,147,1,17,128,2,16,162,146,146,130,135,33,4,1,147,162]

theorem envBound3971 : H12AffineFastState.Bounded env3971 := by
  intro p hp
  have h : env3971.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3970_3971 : H12AffineEnvironment.transform 2 2 env3970 = env3971 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env3970 == env3971) = true)

theorem identity3971 : scanCanonicalize (H12AffineFastState.compose env3971 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound3971 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env3972 : List Nat := [2,4,2,16,0,17,128,4,130,135,131,146,128,147,130,2,146,131,134,130,147,1,17,128,2,16,130,146,146,130,135,1,4,1,147,130]

theorem envBound3972 : H12AffineFastState.Bounded env3972 := by
  intro p hp
  have h : env3972.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3971_3972 : H12AffineEnvironment.transform 4 0 env3971 = env3972 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env3971 == env3972) = true)

theorem identity3972 : scanCanonicalize (H12AffineFastState.compose env3972 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 17) := by decide +kernel

theorem selectedBound3972 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env3973 : List Nat := [2,4,2,16,0,17,17,4,19,22,18,3,17,2,19,2,3,18,23,19,2,1,17,17,2,16,19,3,3,19,22,1,4,1,2,19]

theorem envBound3973 : H12AffineFastState.Bounded env3973 := by
  intro p hp
  have h : env3973.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3972_3973 : H12AffineEnvironment.transform 6 17 env3972 = env3973 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 17 env3972 == env3973) = true)

theorem identity3973 : scanCanonicalize (H12AffineFastState.compose env3973 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound3973 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env3974 : List Nat := [2,4,2,2,0,3,3,4,1,4,0,3,3,2,1,2,3,0,5,1,2,1,3,3,2,2,1,3,3,1,4,1,4,1,2,1]

theorem envBound3974 : H12AffineFastState.Bounded env3974 := by
  intro p hp
  have h : env3974.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3973_3974 : H12AffineEnvironment.transform 3 2 env3973 = env3974 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env3973 == env3974) = true)

def env3975 : List Nat := [2,4,8,16,32,17,128,5,512,1024,2048,4096,8192,4097,32768,13468,4096,262144,524288,32768,4097,4194304,5125,46236,4207773,17,4461589,1045,1045,1073741824,4117,4294967296,5136,4295536694,4097,4199957]

theorem envBound3975 : H12AffineFastState.Bounded env3975 := by
  intro p hp
  have h : env3975.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3958_3975 : H12AffineEnvironment.transform 7 5 env3958 = env3975 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env3958 == env3975) = true)

theorem identity3975 : scanCanonicalize (H12AffineFastState.compose env3975 (packedSelected [10,12,13,15,17,19] rootPS)) = affineNative (2^(29+1) ^^^ 2048) := by decide +kernel

theorem selectedBound3975 : packedSelected [10,12,13,15,17,19] rootPS < 2^1333 := by decide +kernel

def env3976 : List Nat := [2,4,8,16,32,17,128,5,512,1024,2048,4096,8192,4097,32768,13468,4096,262144,524288,32768,4097,4194304,5125,46236,4207773,17,4461589,1045,1045,2048,4117,4294967296,5136,4295536694,4097,4199957]

theorem envBound3976 : H12AffineFastState.Bounded env3976 := by
  intro p hp
  have h : env3976.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3975_3976 : H12AffineEnvironment.transform 29 2048 env3975 = env3976 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 2048 env3975 == env3976) = true)

theorem identity3976 : scanCanonicalize (H12AffineFastState.compose env3976 (packedSelected [1,3,5,8,13,17] rootPS)) = affineNative (2^(21+1) ^^^ 5141) := by decide +kernel

theorem selectedBound3976 : packedSelected [1,3,5,8,13,17] rootPS < 2^1333 := by decide +kernel

def env3977 : List Nat := [2,4,8,16,32,17,128,5,512,1024,2048,4096,8192,4097,32768,13468,4096,262144,524288,32768,4097,5141,5125,46236,8328,17,262144,1045,1045,2048,4117,4294967296,5136,4295536694,4097,512]

theorem envBound3977 : H12AffineFastState.Bounded env3977 := by
  intro p hp
  have h : env3977.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3976_3977 : H12AffineEnvironment.transform 21 5141 env3976 = env3977 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 5141 env3976 == env3977) = true)

theorem identity3977 : scanCanonicalize (H12AffineFastState.compose env3977 (packedSelected [4,9] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound3977 : packedSelected [4,9] rootPS < 2^1333 := by decide +kernel

def env3978 : List Nat := [2,4,8,16,32,17,8,5,512,1024,2048,4096,8192,4097,32768,13332,4096,262144,524288,32768,4097,5141,5125,46100,8192,17,262144,1045,1045,2048,4117,4294967296,5136,4295536694,4097,512]

theorem envBound3978 : H12AffineFastState.Bounded env3978 := by
  intro p hp
  have h : env3978.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3977_3978 : H12AffineEnvironment.transform 6 8 env3977 = env3978 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env3977 == env3978) = true)

theorem identity3978 : scanCanonicalize (H12AffineFastState.compose env3978 (packedSelected [0,6] rootPS)) = affineNative (2^(10+1) ^^^ 35) := by decide +kernel

theorem selectedBound3978 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env3979 : List Nat := [2,4,8,16,32,17,8,5,512,1024,35,4096,8192,4097,32768,13332,4096,262144,524288,32768,4097,5141,5125,46100,8192,17,262144,1045,1045,35,4117,4294967296,5136,4295536694,4097,512]

theorem envBound3979 : H12AffineFastState.Bounded env3979 := by
  intro p hp
  have h : env3979.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3978_3979 : H12AffineEnvironment.transform 10 35 env3978 = env3979 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 35 env3978 == env3979) = true)

theorem identity3979 : scanCanonicalize (H12AffineFastState.compose env3979 (packedSelected [0,1,5,7,8,12,13] rootPS)) = affineNative (2^(12+1) ^^^ 1030) := by decide +kernel

theorem selectedBound3979 : packedSelected [0,1,5,7,8,12,13] rootPS < 2^1333 := by decide +kernel

def env3980 : List Nat := [2,4,8,16,32,17,8,5,512,1024,35,4096,1030,4097,32768,4114,4096,262144,524288,32768,4097,5141,5125,36882,1030,17,262144,1045,1045,35,4117,4294967296,5136,4295529520,4097,512]

theorem envBound3980 : H12AffineFastState.Bounded env3980 := by
  intro p hp
  have h : env3980.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3979_3980 : H12AffineEnvironment.transform 12 1030 env3979 = env3980 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1030 env3979 == env3980) = true)

theorem identity3980 : scanCanonicalize (H12AffineFastState.compose env3980 (packedSelected [0,7,12,15] rootPS)) = affineNative (2^(17+1) ^^^ 32777) := by decide +kernel

theorem selectedBound3980 : packedSelected [0,7,12,15] rootPS < 2^1333 := by decide +kernel

def env3981 : List Nat := [2,4,8,16,32,17,8,5,512,1024,35,4096,1030,4097,32768,4114,4096,32777,524288,32768,4097,5141,5125,36882,1030,17,32777,1045,1045,35,4117,4294967296,5136,4295529520,4097,512]

theorem envBound3981 : H12AffineFastState.Bounded env3981 := by
  intro p hp
  have h : env3981.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3980_3981 : H12AffineEnvironment.transform 17 32777 env3980 = env3981 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 32777 env3980 == env3981) = true)

def env3982 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,524288,32768,4097,4194304,5457,98305,4259841,324,4461636,1044,1044,1073741824,4164,4294967296,5445,4295536743,4097,4268681]

theorem envBound3982 : H12AffineFastState.Bounded env3982 := by
  intro p hp
  have h : env3982.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3931_3982 : H12AffineEnvironment.transform 23 98305 env3931 = env3982 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98305 env3931 == env3982) = true)

theorem identity3982 : scanCanonicalize (H12AffineFastState.compose env3982 (packedSelected [3,5,24] rootPS)) = affineNative (2^(18+1) ^^^ 78281) := by decide +kernel

theorem selectedBound3982 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env3983 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,78281,32768,4097,4194304,5457,98305,4259841,324,4461636,1044,1044,1073741824,4164,4294967296,5445,4295066030,4097,4268681]

theorem envBound3983 : H12AffineFastState.Bounded env3983 := by
  intro p hp
  have h : env3983.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3982_3983 : H12AffineEnvironment.transform 18 78281 env3982 = env3983 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 78281 env3982 == env3983) = true)

def env3984 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,78281,32768,4097,4194304,5457,98305,4259841,324,4461636,1044,1044,360608,4164,4294967296,5445,4295066030,4097,4268681]

theorem envBound3984 : H12AffineFastState.Bounded env3984 := by
  intro p hp
  have h : env3984.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3983_3984 : H12AffineEnvironment.transform 29 360608 env3983 = env3984 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360608 env3983 == env3984) = true)

theorem identity3984 : scanCanonicalize (H12AffineFastState.compose env3984 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(17+1) ^^^ 48237) := by decide +kernel

theorem selectedBound3984 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env3985 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,48237,78281,32768,4097,4194304,5457,98305,4259841,324,4237353,1044,1044,81101,4164,4294967296,5445,4295066030,4097,4268681]

theorem envBound3985 : H12AffineFastState.Bounded env3985 := by
  intro p hp
  have h : env3985.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3984_3985 : H12AffineEnvironment.transform 17 48237 env3984 = env3985 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 48237 env3984 == env3985) = true)

def env3986 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4176,32768,65536,4096,48237,78029,32768,4097,4194304,5205,98305,4259841,64,4237353,1044,1044,81101,4164,4294967296,5185,4295065770,4097,4268681]

theorem envBound3986 : H12AffineFastState.Bounded env3986 := by
  intro p hp
  have h : env3986.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3985_3986 : H12AffineEnvironment.transform 7 4 env3985 = env3986 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env3985 == env3986) = true)

theorem identity3986 : scanCanonicalize (H12AffineFastState.compose env3986 (packedSelected [5,12,13,15,21] rootPS)) = affineNative (2^(21+1) ^^^ 73864) := by decide +kernel

theorem selectedBound3986 : packedSelected [5,12,13,15,21] rootPS < 2^1333 := by decide +kernel

def env3987 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4176,32768,65536,4096,48237,78029,32768,4097,73864,5205,98305,8329,64,100513,1044,1044,81101,4164,4294967296,5185,4295065770,4097,513]

theorem envBound3987 : H12AffineFastState.Bounded env3987 := by
  intro p hp
  have h : env3987.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3986_3987 : H12AffineEnvironment.transform 21 73864 env3986 = env3987 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 73864 env3986 == env3987) = true)

theorem identity3987 : scanCanonicalize (H12AffineFastState.compose env3987 (packedSelected [0,1,4,5,7,8,9,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 8843) := by decide +kernel

theorem selectedBound3987 : packedSelected [0,1,4,5,7,8,9,12,13] rootPS < 2^1333 := by decide +kernel

def env3988 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4176,8843,65536,4096,7910,78029,8843,4097,73864,5205,74378,8329,64,76330,1044,1044,81101,4164,4294967296,5185,4295041569,4097,513]

theorem envBound3988 : H12AffineFastState.Bounded env3988 := by
  intro p hp
  have h : env3988.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3987_3988 : H12AffineEnvironment.transform 14 8843 env3987 = env3988 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8843 env3987 == env3988) = true)

theorem identity3988 : scanCanonicalize (H12AffineFastState.compose env3988 (packedSelected [0,7,16] rootPS)) = affineNative (2^(11+1) ^^^ 1740) := by decide +kernel

theorem selectedBound3988 : packedSelected [0,7,16] rootPS < 2^1333 := by decide +kernel

def env3989 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1740,8192,1692,8843,65536,1740,2090,75265,8843,1741,73864,665,74378,8329,64,76330,1044,1044,76289,1672,4294967296,653,4295041569,1741,513]

theorem envBound3989 : H12AffineFastState.Bounded env3989 := by
  intro p hp
  have h : env3989.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3988_3989 : H12AffineEnvironment.transform 11 1740 env3988 = env3989 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1740 env3988 == env3989) = true)

def env3990 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1740,8192,1692,8843,2176,1740,2090,11905,8843,1741,10248,665,10762,8329,64,8874,1044,1044,8833,1672,4294967296,653,4294978209,1741,513]

theorem envBound3990 : H12AffineFastState.Bounded env3990 := by
  intro p hp
  have h : env3990.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3989_3990 : H12AffineEnvironment.transform 15 2176 env3989 = env3990 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2176 env3989 == env3990) = true)

def env3991 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1740,8192,1692,8843,2177,1740,2090,11904,8843,1741,10249,665,10763,8329,64,8875,1044,1044,8832,1672,4294967296,653,4294978208,1741,513]

theorem envBound3991 : H12AffineFastState.Bounded env3991 := by
  intro p hp
  have h : env3991.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3989_3991 : H12AffineEnvironment.transform 15 2177 env3989 = env3991 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2177 env3989 == env3991) = true)

theorem identity3991 : scanCanonicalize (H12AffineFastState.compose env3991 (packedSelected [0,6] rootPS)) = affineNative (2^(12+1) ^^^ 2689) := by decide +kernel

theorem selectedBound3991 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env3992 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1740,2689,1692,2058,2177,1740,2090,1025,2058,1741,648,665,138,2568,64,2090,1044,1044,2049,1672,4294967296,653,4294967329,1741,513]

theorem envBound3992 : H12AffineFastState.Bounded env3992 := by
  intro p hp
  have h : env3992.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3991_3992 : H12AffineEnvironment.transform 12 2689 env3991 = env3992 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2689 env3991 == env3992) = true)

theorem identity3992 : scanCanonicalize (H12AffineFastState.compose env3992 (packedSelected [2,4] rootPS)) = affineNative (2^(5+1) ^^^ 59) := by decide +kernel

theorem selectedBound3992 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env3993 : List Nat := [2,4,8,16,32,59,128,4,512,1024,2048,1719,2689,1692,2058,2177,1719,2090,1025,2058,1718,648,665,138,2568,59,2090,1044,1044,2049,1672,4294967296,653,4294967329,1718,513]

theorem envBound3993 : H12AffineFastState.Bounded env3993 := by
  intro p hp
  have h : env3993.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3992_3993 : H12AffineEnvironment.transform 5 59 env3992 = env3993 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 59 env3992 == env3993) = true)

def env3994 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,4096,8192,4176,32768,65536,4096,48237,78028,32768,4097,4194304,5204,98305,4259841,65,4237353,1044,1044,81101,4164,4294967296,5184,4295065771,4097,4268681]

theorem envBound3994 : H12AffineFastState.Bounded env3994 := by
  intro p hp
  have h : env3994.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3985_3994 : H12AffineEnvironment.transform 7 5 env3985 = env3994 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env3985 == env3994) = true)

theorem identity3994 : scanCanonicalize (H12AffineFastState.compose env3994 (packedSelected [10,12,13,15,17,19] rootPS)) = affineNative (2^(21+1) ^^^ 40962) := by decide +kernel

theorem selectedBound3994 : packedSelected [10,12,13,15,17,19] rootPS < 2^1333 := by decide +kernel

def env3995 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,4096,8192,4176,32768,65536,4096,48237,78028,32768,4097,40962,5204,98305,106499,65,2091,1044,1044,81101,4164,4294967296,5184,4295065771,4097,98955]

theorem envBound3995 : H12AffineFastState.Bounded env3995 := by
  intro p hp
  have h : env3995.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3994_3995 : H12AffineEnvironment.transform 21 40962 env3994 = env3995 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 40962 env3994 == env3995) = true)

theorem identity3995 : scanCanonicalize (H12AffineFastState.compose env3995 (packedSelected [11,18,20] rootPS)) = affineNative (2^(11+1) ^^^ 1093) := by decide +kernel

theorem selectedBound3995 : packedSelected [11,18,20] rootPS < 2^1333 := by decide +kernel

def env3996 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1093,8192,1045,32768,65536,1093,43048,74889,32768,1092,40962,17,98305,106499,65,2091,1044,1044,75912,1025,4294967296,5,4295065771,1092,98955]

theorem envBound3996 : H12AffineFastState.Bounded env3996 := by
  intro p hp
  have h : env3996.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3995_3996 : H12AffineEnvironment.transform 11 1093 env3995 = env3996 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1093 env3995 == env3996) = true)

theorem identity3996 : scanCanonicalize (H12AffineFastState.compose env3996 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(15+1) ^^^ 32897) := by decide +kernel

theorem selectedBound3996 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env3997 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1093,8192,1045,32768,32897,1093,43048,41992,32768,1092,40962,17,128,8322,65,2091,1044,1044,43017,1025,4294967296,5,4294967338,1092,522]

theorem envBound3997 : H12AffineFastState.Bounded env3997 := by
  intro p hp
  have h : env3997.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3996_3997 : H12AffineEnvironment.transform 15 32897 env3996 = env3997 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 32897 env3996 == env3997) = true)

theorem identity3997 : scanCanonicalize (H12AffineFastState.compose env3997 (packedSelected [5,12,13,15,21] rootPS)) = affineNative (2^(14+1) ^^^ 8195) := by decide +kernel

theorem selectedBound3997 : packedSelected [5,12,13,15,21] rootPS < 2^1333 := by decide +kernel

def env3998 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1093,8192,1045,8195,8322,1093,2091,1035,8195,1092,1,17,128,8322,65,2091,1044,1044,2058,1025,4294967296,5,4294967338,1092,522]

theorem envBound3998 : H12AffineFastState.Bounded env3998 := by
  intro p hp
  have h : env3998.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3997_3998 : H12AffineEnvironment.transform 14 8195 env3997 = env3998 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8195 env3997 == env3998) = true)

theorem identity3998 : scanCanonicalize (H12AffineFastState.compose env3998 (packedSelected [1,2,3,7,9,11] rootPS)) = affineNative (2^(31+1) ^^^ 10913) := by decide +kernel

theorem selectedBound3998 : packedSelected [1,2,3,7,9,11] rootPS < 2^1333 := by decide +kernel

def env3999 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1093,8192,1045,8195,8322,1093,2091,1035,8195,1092,1,17,128,8322,65,2091,1044,1044,2058,1025,10913,5,10891,1092,522]

theorem envBound3999 : H12AffineFastState.Bounded env3999 := by
  intro p hp
  have h : env3999.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3998_3999 : H12AffineEnvironment.transform 31 10913 env3998 = env3999 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 10913 env3998 == env3999) = true)

theorem identity3999 : scanCanonicalize (H12AffineFastState.compose env3999 (packedSelected [1,3,4,9,16] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound3999 : packedSelected [1,3,4,9,16] rootPS < 2^1333 := by decide +kernel

def env4000 : List Nat := [2,4,8,16,0,64,128,5,512,1024,2048,1093,8192,1045,8195,8322,1093,2059,1035,8195,1092,1,17,128,8322,65,2059,1044,1044,2058,1025,10881,5,10891,1092,522]

theorem envBound4000 : H12AffineFastState.Bounded env4000 := by
  intro p hp
  have h : env4000.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3999_4000 : H12AffineEnvironment.transform 4 0 env3999 = env4000 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env3999 == env4000) = true)

theorem identity4000 : scanCanonicalize (H12AffineFastState.compose env4000 (packedSelected [0,1,2,3,4] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound4000 : packedSelected [0,1,2,3,4] rootPS < 2^1333 := by decide +kernel

def env4001 : List Nat := [2,4,2,16,0,64,128,5,512,1024,2048,1093,8192,1045,8195,8322,1093,2049,1025,8195,1092,1,17,128,8322,65,2049,1044,1044,2048,1025,10881,5,10881,1092,512]

theorem envBound4001 : H12AffineFastState.Bounded env4001 := by
  intro p hp
  have h : env4001.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4000_4001 : H12AffineEnvironment.transform 2 2 env4000 = env4001 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env4000 == env4001) = true)

theorem identity4001 : scanCanonicalize (H12AffineFastState.compose env4001 (packedSelected [2] rootPS)) = affineNative (2^(12+1) ^^^ 2130) := by decide +kernel

theorem selectedBound4001 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4002 : List Nat := [2,4,2,16,0,64,128,5,512,1024,2048,1093,2130,1045,2129,2256,1093,2049,1025,2129,1092,1,17,128,2256,65,2049,1044,1044,2048,1025,723,5,723,1092,512]

theorem envBound4002 : H12AffineFastState.Bounded env4002 := by
  intro p hp
  have h : env4002.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4001_4002 : H12AffineEnvironment.transform 12 2130 env4001 = env4002 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2130 env4001 == env4002) = true)

theorem identity4002 : scanCanonicalize (H12AffineFastState.compose env4002 (packedSelected [1,3] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound4002 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4003 : List Nat := [2,4,2,16,0,64,3,5,512,1024,2048,1093,2130,1045,2129,2131,1093,2049,1025,2129,1092,1,17,3,2131,65,2049,1044,1044,2048,1025,592,5,592,1092,512]

theorem envBound4003 : H12AffineFastState.Bounded env4003 := by
  intro p hp
  have h : env4003.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4002_4003 : H12AffineEnvironment.transform 6 3 env4002 = env4003 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env4002 == env4003) = true)

theorem identity4003 : scanCanonicalize (H12AffineFastState.compose env4003 (packedSelected [0] rootPS)) = affineNative (2^(5+1) ^^^ 2) := by decide +kernel

theorem selectedBound4003 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4004 : List Nat := [2,4,2,16,0,2,3,5,512,1024,2048,1031,2064,1045,2067,2065,1031,2049,1025,2067,1030,1,17,3,2065,3,2049,1044,1044,2048,1025,530,5,530,1030,512]

theorem envBound4004 : H12AffineFastState.Bounded env4004 := by
  intro p hp
  have h : env4004.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4003_4004 : H12AffineEnvironment.transform 5 2 env4003 = env4004 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 2 env4003 == env4004) = true)

theorem identity4004 : scanCanonicalize (H12AffineFastState.compose env4004 (packedSelected [1] rootPS)) = affineNative (2^(10+1) ^^^ 1541) := by decide +kernel

theorem selectedBound4004 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4005 : List Nat := [2,4,2,16,0,2,3,5,512,1024,1541,1031,1557,1045,1558,1556,1031,1540,1025,1558,1030,1,17,3,1556,3,1540,1044,1044,1541,1025,530,5,530,1030,512]

theorem envBound4005 : H12AffineFastState.Bounded env4005 := by
  intro p hp
  have h : env4005.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4004_4005 : H12AffineEnvironment.transform 10 1541 env4004 = env4005 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1541 env4004 == env4005) = true)

theorem identity4005 : scanCanonicalize (H12AffineFastState.compose env4005 (packedSelected [6] rootPS)) = affineNative (2^(9+1) ^^^ 23) := by decide +kernel

theorem selectedBound4005 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env4006 : List Nat := [2,4,2,16,0,2,3,5,512,23,530,16,514,2,513,515,16,531,22,513,17,1,17,3,515,3,531,3,3,530,22,530,5,530,17,512]

theorem envBound4006 : H12AffineFastState.Bounded env4006 := by
  intro p hp
  have h : env4006.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4005_4006 : H12AffineEnvironment.transform 9 23 env4005 = env4006 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 23 env4005 == env4006) = true)

theorem identity4006 : scanCanonicalize (H12AffineFastState.compose env4006 (packedSelected [7] rootPS)) = affineNative (2^(8+1) ^^^ 0) := by decide +kernel

theorem selectedBound4006 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env4007 : List Nat := [2,4,2,16,0,2,3,5,0,23,18,16,2,2,1,3,16,19,22,1,17,1,17,3,3,3,19,3,3,18,22,18,5,18,17,0]

theorem envBound4007 : H12AffineFastState.Bounded env4007 := by
  intro p hp
  have h : env4007.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4006_4007 : H12AffineEnvironment.transform 8 0 env4006 = env4007 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 0 env4006 == env4007) = true)

theorem identity4007 : scanCanonicalize (H12AffineFastState.compose env4007 (packedSelected [9] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound4007 : packedSelected [9] rootPS < 2^1333 := by decide +kernel

def env4008 : List Nat := [2,4,2,3,0,2,3,5,0,4,1,3,2,2,1,3,3,0,5,1,2,1,2,3,3,3,0,3,3,1,5,1,5,1,2,0]

theorem envBound4008 : H12AffineFastState.Bounded env4008 := by
  intro p hp
  have h : env4008.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4007_4008 : H12AffineEnvironment.transform 3 3 env4007 = env4008 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env4007 == env4008) = true)

def env4009 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4096,262144,78281,32768,4097,4194304,5457,98305,4259841,324,4461636,1044,1044,360609,4164,4294967296,5445,4295066030,4097,4268681]

theorem envBound4009 : H12AffineFastState.Bounded env4009 := by
  intro p hp
  have h : env4009.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3983_4009 : H12AffineEnvironment.transform 29 360609 env3983 = env4009 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360609 env3983 == env4009) = true)

theorem identity4009 : scanCanonicalize (H12AffineFastState.compose env4009 (packedSelected [3,5,8,17,21,28] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound4009 : packedSelected [3,5,8,17,21,28] rootPS < 2^1333 := by decide +kernel

def env4010 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,4096,8192,4097,32768,65536,4096,262144,78232,32768,4097,4194304,5376,98305,4259841,277,4461589,1044,1044,360609,4117,4294967296,5396,4295066030,4097,4268681]

theorem envBound4010 : H12AffineFastState.Bounded env4010 := by
  intro p hp
  have h : env4010.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4009_4010 : H12AffineEnvironment.transform 5 17 env4009 = env4010 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env4009 == env4010) = true)

def env4011 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,524288,32768,4097,4194304,5457,16777216,4259840,16875844,4461637,16876564,16876565,1073741824,4165,4294967296,16880965,4295536743,4096,4268680]

theorem envBound4011 : H12AffineFastState.Bounded env4011 := by
  intro p hp
  have h : env4011.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3930_4011 : H12AffineEnvironment.transform 16 4097 env3930 = env4011 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4097 env3930 == env4011) = true)

def env4012 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,524288,32768,4097,4194304,5457,98304,4259840,324,4461637,1044,1045,1073741824,4165,4294967296,5445,4295536743,4096,4268680]

theorem envBound4012 : H12AffineFastState.Bounded env4012 := by
  intro p hp
  have h : env4012.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4011_4012 : H12AffineEnvironment.transform 23 98304 env4011 = env4012 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98304 env4011 == env4012) = true)

theorem identity4012 : scanCanonicalize (H12AffineFastState.compose env4012 (packedSelected [3,5,24] rootPS)) = affineNative (2^(21+1) ^^^ 648) := by decide +kernel

theorem selectedBound4012 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env4013 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,524288,32768,4097,648,5457,98304,66184,324,267981,1044,1045,1073741824,4165,4294967296,5445,4295536743,4096,73728]

theorem envBound4013 : H12AffineFastState.Bounded env4013 := by
  intro p hp
  have h : env4013.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4012_4013 : H12AffineEnvironment.transform 21 648 env4012 = env4013 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 648 env4012 == env4013) = true)

def env4014 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,524288,32768,4097,648,5457,98304,66184,324,267981,1044,1045,360608,4165,4294967296,5445,4295536743,4096,73728]

theorem envBound4014 : H12AffineFastState.Bounded env4014 := by
  intro p hp
  have h : env4014.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4013_4014 : H12AffineEnvironment.transform 29 360608 env4013 = env4014 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360608 env4013 == env4014) = true)

theorem identity4014 : scanCanonicalize (H12AffineFastState.compose env4014 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(17+1) ^^^ 48237) := by decide +kernel

theorem selectedBound4014 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env4015 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,48237,524288,32768,4097,648,5457,98304,66184,324,43680,1044,1045,81101,4165,4294967296,5445,4295536743,4096,73728]

theorem envBound4015 : H12AffineFastState.Bounded env4015 := by
  intro p hp
  have h : env4015.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4014_4015 : H12AffineEnvironment.transform 17 48237 env4014 = env4015 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 48237 env4014 == env4015) = true)

def env4016 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4176,32768,65536,4097,48237,524288,32768,4097,648,5205,98304,66184,64,43680,1044,1045,81101,4165,4294967296,5185,4295536743,4096,73728]

theorem envBound4016 : H12AffineFastState.Bounded env4016 := by
  intro p hp
  have h : env4016.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4015_4016 : H12AffineEnvironment.transform 7 4 env4015 = env4016 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env4015 == env4016) = true)

theorem identity4016 : scanCanonicalize (H12AffineFastState.compose env4016 (packedSelected [10,12,13,15,17,19] rootPS)) = affineNative (2^(14+1) ^^^ 8842) := by decide +kernel

theorem selectedBound4016 : packedSelected [10,12,13,15,17,19] rootPS < 2^1333 := by decide +kernel

def env4017 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4176,8842,65536,4097,7911,524288,8842,4097,648,5205,74378,66184,64,2090,1044,1045,81101,4165,4294967296,5185,4295496429,4096,73728]

theorem envBound4017 : H12AffineFastState.Bounded env4017 := by
  intro p hp
  have h : env4017.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4016_4017 : H12AffineEnvironment.transform 14 8842 env4016 = env4017 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8842 env4016 == env4017) = true)

theorem identity4017 : scanCanonicalize (H12AffineFastState.compose env4017 (packedSelected [11,18,20] rootPS)) = affineNative (2^(11+1) ^^^ 1093) := by decide +kernel

theorem selectedBound4017 : packedSelected [11,18,20] rootPS < 2^1333 := by decide +kernel

def env4018 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1093,8192,1045,8842,65536,1092,2722,524288,8842,1092,648,16,74378,66184,64,2090,1044,1045,75912,1024,4294967296,4,4295493288,1093,73728]

theorem envBound4018 : H12AffineFastState.Bounded env4018 := by
  intro p hp
  have h : env4018.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4017_4018 : H12AffineEnvironment.transform 11 1093 env4017 = env4018 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1093 env4017 == env4018) = true)

theorem identity4018 : scanCanonicalize (H12AffineFastState.compose env4018 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(18+1) ^^^ 1667) := by decide +kernel

theorem selectedBound4018 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env4019 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1093,8192,1045,8842,65536,1092,2722,1667,8842,1092,648,16,74378,66184,64,2090,1044,1045,75912,1024,4294967296,4,4294967339,1093,73728]

theorem envBound4019 : H12AffineFastState.Bounded env4019 := by
  intro p hp
  have h : env4019.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4018_4019 : H12AffineEnvironment.transform 18 1667 env4018 = env4019 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1667 env4018 == env4019) = true)

theorem identity4019 : scanCanonicalize (H12AffineFastState.compose env4019 (packedSelected [5,12,13,15,21] rootPS)) = affineNative (2^(15+1) ^^^ 8322) := by decide +kernel

theorem selectedBound4019 : packedSelected [5,12,13,15,21] rootPS < 2^1333 := by decide +kernel

def env4020 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1093,8192,1045,8842,8322,1092,2722,1667,8842,1092,648,16,520,8714,64,2090,1044,1045,2058,1024,4294967296,4,4294967339,1093,130]

theorem envBound4020 : H12AffineFastState.Bounded env4020 := by
  intro p hp
  have h : env4020.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4019_4020 : H12AffineEnvironment.transform 15 8322 env4019 = env4020 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8322 env4019 == env4020) = true)

theorem identity4020 : scanCanonicalize (H12AffineFastState.compose env4020 (packedSelected [2,4,7,11,16] rootPS)) = affineNative (2^(31+1) ^^^ 10880) := by decide +kernel

theorem selectedBound4020 : packedSelected [2,4,7,11,16] rootPS < 2^1333 := by decide +kernel

def env4021 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1093,8192,1045,8842,8322,1092,2722,1667,8842,1092,648,16,520,8714,64,2090,1044,1045,2058,1024,10880,4,10923,1093,130]

theorem envBound4021 : H12AffineFastState.Bounded env4021 := by
  intro p hp
  have h : env4021.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4020_4021 : H12AffineEnvironment.transform 31 10880 env4020 = env4021 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 10880 env4020 == env4021) = true)

def env4022 : List Nat := [2,4,8,16,32,64,128,4,512,1024,168,1093,8192,1045,8842,8322,1092,522,1667,8842,1092,648,16,520,8714,64,130,1044,1045,162,1024,8744,4,8707,1093,130]

theorem envBound4022 : H12AffineFastState.Bounded env4022 := by
  intro p hp
  have h : env4022.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4021_4022 : H12AffineEnvironment.transform 10 168 env4021 = env4022 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 168 env4021 == env4022) = true)

theorem identity4022 : scanCanonicalize (H12AffineFastState.compose env4022 (packedSelected [6] rootPS)) = affineNative (2^(5+1) ^^^ 26) := by decide +kernel

theorem selectedBound4022 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env4023 : List Nat := [2,4,8,16,32,26,128,4,512,1024,168,1055,8192,1045,8842,8322,1054,522,1667,8842,1054,648,16,520,8714,26,130,1044,1045,162,1024,8744,4,8707,1055,130]

theorem envBound4023 : H12AffineFastState.Bounded env4023 := by
  intro p hp
  have h : env4023.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4022_4023 : H12AffineEnvironment.transform 5 26 env4022 = env4023 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 26 env4022 == env4023) = true)

theorem identity4023 : scanCanonicalize (H12AffineFastState.compose env4023 (packedSelected [1,2,3,7,9,11] rootPS)) = affineNative (2^(8+1) ^^^ 169) := by decide +kernel

theorem selectedBound4023 : packedSelected [1,2,3,7,9,11] rootPS < 2^1333 := by decide +kernel

def env4024 : List Nat := [2,4,8,16,32,26,128,4,169,1024,168,1055,8192,1045,8227,8322,1054,163,1066,8227,1054,33,16,161,8355,26,130,1044,1045,162,1024,8321,4,8362,1055,130]

theorem envBound4024 : H12AffineFastState.Bounded env4024 := by
  intro p hp
  have h : env4024.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4023_4024 : H12AffineEnvironment.transform 8 169 env4023 = env4024 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 169 env4023 == env4024) = true)

theorem identity4024 : scanCanonicalize (H12AffineFastState.compose env4024 (packedSelected [2] rootPS)) = affineNative (2^(12+1) ^^^ 161) := by decide +kernel

theorem selectedBound4024 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4025 : List Nat := [2,4,8,16,32,26,128,4,169,1024,168,1055,161,1045,130,35,1054,163,1066,130,1054,33,16,161,2,26,130,1044,1045,162,1024,32,4,11,1055,130]

theorem envBound4025 : H12AffineFastState.Bounded env4025 := by
  intro p hp
  have h : env4025.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4024_4025 : H12AffineEnvironment.transform 12 161 env4024 = env4025 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 161 env4024 == env4025) = true)

def env4026 : List Nat := [2,4,8,16,32,64,128,4,512,1024,169,1093,8192,1045,8842,8322,1092,523,1667,8842,1092,648,16,520,8714,64,131,1044,1045,163,1024,8745,4,8706,1093,130]

theorem envBound4026 : H12AffineFastState.Bounded env4026 := by
  intro p hp
  have h : env4026.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4021_4026 : H12AffineEnvironment.transform 10 169 env4021 = env4026 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 169 env4021 == env4026) = true)

theorem identity4026 : scanCanonicalize (H12AffineFastState.compose env4026 (packedSelected [6] rootPS)) = affineNative (2^(8+1) ^^^ 217) := by decide +kernel

theorem selectedBound4026 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env4027 : List Nat := [2,4,8,16,32,64,128,4,217,1024,169,1093,8192,1045,8275,8322,1092,210,1114,8275,1092,81,16,209,8403,64,131,1044,1045,163,1024,8432,4,8411,1093,130]

theorem envBound4027 : H12AffineFastState.Bounded env4027 := by
  intro p hp
  have h : env4027.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4026_4027 : H12AffineEnvironment.transform 8 217 env4026 = env4027 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 217 env4026 == env4027) = true)

theorem identity4027 : scanCanonicalize (H12AffineFastState.compose env4027 (packedSelected [2,7,9,10,11,12,13] rootPS)) = affineNative (2^(5+1) ^^^ 17) := by decide +kernel

theorem selectedBound4027 : packedSelected [2,7,9,10,11,12,13] rootPS < 2^1333 := by decide +kernel

def env4028 : List Nat := [2,4,8,16,32,17,128,4,136,1024,169,1044,8192,1045,8194,8322,1045,131,1035,8194,1045,0,16,128,8322,17,131,1044,1045,163,1024,8353,4,8330,1044,130]

theorem envBound4028 : H12AffineFastState.Bounded env4028 := by
  intro p hp
  have h : env4028.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4027_4028 : H12AffineEnvironment.transform 5 17 env4027 = env4028 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env4027 == env4028) = true)

theorem identity4028 : scanCanonicalize (H12AffineFastState.compose env4028 (packedSelected [0,1,3,4] rootPS)) = affineNative (2^(12+1) ^^^ 139) := by decide +kernel

theorem selectedBound4028 : packedSelected [0,1,3,4] rootPS < 2^1333 := by decide +kernel

def env4029 : List Nat := [2,4,8,16,32,17,128,4,136,1024,169,1044,139,1045,137,9,1045,131,1035,137,1045,0,16,128,9,17,131,1044,1045,163,1024,42,4,1,1044,130]

theorem envBound4029 : H12AffineFastState.Bounded env4029 := by
  intro p hp
  have h : env4029.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4028_4029 : H12AffineEnvironment.transform 12 139 env4028 = env4029 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 139 env4028 == env4029) = true)

theorem identity4029 : scanCanonicalize (H12AffineFastState.compose env4029 (packedSelected [0,2,7] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound4029 : packedSelected [0,2,7] rootPS < 2^1333 := by decide +kernel

def env4030 : List Nat := [2,4,8,16,1,17,128,4,136,1024,136,1044,139,1045,137,9,1045,131,1035,137,1045,0,16,128,9,17,131,1044,1045,130,1024,11,4,1,1044,130]

theorem envBound4030 : H12AffineFastState.Bounded env4030 := by
  intro p hp
  have h : env4030.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4029_4030 : H12AffineEnvironment.transform 4 1 env4029 = env4030 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4029 == env4030) = true)

theorem identity4030 : scanCanonicalize (H12AffineFastState.compose env4030 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound4030 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4031 : List Nat := [2,4,2,16,1,17,128,4,130,1024,130,1044,129,1045,131,3,1045,131,1025,131,1045,0,16,128,3,17,131,1044,1045,130,1024,1,4,1,1044,130]

theorem envBound4031 : H12AffineFastState.Bounded env4031 := by
  intro p hp
  have h : env4031.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4030_4031 : H12AffineEnvironment.transform 2 2 env4030 = env4031 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env4030 == env4031) = true)

theorem identity4031 : scanCanonicalize (H12AffineFastState.compose env4031 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 17) := by decide +kernel

theorem selectedBound4031 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4032 : List Nat := [2,4,2,16,1,17,17,4,19,1024,19,1044,16,1045,18,3,1045,18,1025,18,1045,0,16,17,3,17,18,1044,1045,19,1024,1,4,1,1044,19]

theorem envBound4032 : H12AffineFastState.Bounded env4032 := by
  intro p hp
  have h : env4032.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4031_4032 : H12AffineEnvironment.transform 6 17 env4031 = env4032 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 17 env4031 == env4032) = true)

theorem identity4032 : scanCanonicalize (H12AffineFastState.compose env4032 (packedSelected [1] rootPS)) = affineNative (2^(9+1) ^^^ 4) := by decide +kernel

theorem selectedBound4032 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4033 : List Nat := [2,4,2,16,1,17,17,4,19,4,19,16,16,17,18,3,17,18,5,18,17,0,16,17,3,17,18,16,17,19,4,1,4,1,16,19]

theorem envBound4033 : H12AffineFastState.Bounded env4033 := by
  intro p hp
  have h : env4033.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4032_4033 : H12AffineEnvironment.transform 9 4 env4032 = env4033 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 4 env4032 == env4033) = true)

theorem identity4033 : scanCanonicalize (H12AffineFastState.compose env4033 (packedSelected [3] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound4033 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4034 : List Nat := [2,4,2,2,1,3,3,4,1,4,1,2,2,3,0,3,3,0,5,0,3,0,2,3,3,3,0,2,3,1,4,1,4,1,2,1]

theorem envBound4034 : H12AffineFastState.Bounded env4034 := by
  intro p hp
  have h : env4034.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4033_4034 : H12AffineEnvironment.transform 3 2 env4033 = env4034 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env4033 == env4034) = true)

def env4035 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,4096,8192,4176,32768,65536,4097,48237,524288,32768,4097,648,5204,98304,66184,65,43680,1044,1045,81101,4165,4294967296,5184,4295536743,4096,73728]

theorem envBound4035 : H12AffineFastState.Bounded env4035 := by
  intro p hp
  have h : env4035.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4015_4035 : H12AffineEnvironment.transform 7 5 env4015 = env4035 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env4015 == env4035) = true)

theorem identity4035 : scanCanonicalize (H12AffineFastState.compose env4035 (packedSelected [5,12,13,15,21] rootPS)) = affineNative (2^(15+1) ^^^ 8705) := by decide +kernel

theorem selectedBound4035 : packedSelected [5,12,13,15,21] rootPS < 2^1333 := by decide +kernel

def env4036 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,4096,8192,4176,32768,8705,4097,48237,524288,32768,4097,648,5204,41473,8329,65,43680,1044,1045,7884,4165,4294967296,5184,4295536743,4096,513]

theorem envBound4036 : H12AffineFastState.Bounded env4036 := by
  intro p hp
  have h : env4036.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4035_4036 : H12AffineEnvironment.transform 15 8705 env4035 = env4036 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8705 env4035 == env4036) = true)

theorem identity4036 : scanCanonicalize (H12AffineFastState.compose env4036 (packedSelected [0,1,4,5,7,8,9,12,13] rootPS)) = affineNative (2^(18+1) ^^^ 45126) := by decide +kernel

theorem selectedBound4036 : packedSelected [0,1,4,5,7,8,9,12,13] rootPS < 2^1333 := by decide +kernel

def env4037 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,4096,8192,4176,32768,8705,4097,48237,45126,32768,4097,648,5204,41473,8329,65,43680,1044,1045,7884,4165,4294967296,5184,4294967329,4096,513]

theorem envBound4037 : H12AffineFastState.Bounded env4037 := by
  intro p hp
  have h : env4037.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4036_4037 : H12AffineEnvironment.transform 18 45126 env4036 = env4037 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 45126 env4036 == env4037) = true)

theorem identity4037 : scanCanonicalize (H12AffineFastState.compose env4037 (packedSelected [0,7,16] rootPS)) = affineNative (2^(11+1) ^^^ 1740) := by decide +kernel

theorem selectedBound4037 : packedSelected [0,7,16] rootPS < 2^1333 := by decide +kernel

def env4038 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1740,8192,1692,32768,8705,1741,43681,42634,32768,1741,648,664,41473,8329,65,43680,1044,1045,2048,1673,4294967296,652,4294967329,1740,513]

theorem envBound4038 : H12AffineFastState.Bounded env4038 := by
  intro p hp
  have h : env4038.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4037_4038 : H12AffineEnvironment.transform 11 1740 env4037 = env4038 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1740 env4037 == env4038) = true)

def env4039 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,524288,32768,4097,648,5457,98304,66184,324,267981,1044,1045,360609,4165,4294967296,5445,4295536743,4096,73728]

theorem envBound4039 : H12AffineFastState.Bounded env4039 := by
  intro p hp
  have h : env4039.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4013_4039 : H12AffineEnvironment.transform 29 360609 env4013 = env4039 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360609 env4013 == env4039) = true)

theorem identity4039 : scanCanonicalize (H12AffineFastState.compose env4039 (packedSelected [3,5,8,17,21,28] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound4039 : packedSelected [3,5,8,17,21,28] rootPS < 2^1333 := by decide +kernel

def env4040 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,4097,262144,524288,32768,4097,648,5377,98304,66184,276,267933,1044,1045,360609,4117,4294967296,5397,4295536695,4096,73728]

theorem envBound4040 : H12AffineFastState.Bounded env4040 := by
  intro p hp
  have h : env4040.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4039_4040 : H12AffineEnvironment.transform 5 16 env4039 = env4040 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env4039 == env4040) = true)

def env4041 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,524288,32768,4097,4194304,5457,98305,4259840,325,4461637,1045,1044,1073741824,4165,4294967296,5444,4295536743,4096,4268680]

theorem envBound4041 : H12AffineFastState.Bounded env4041 := by
  intro p hp
  have h : env4041.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4011_4041 : H12AffineEnvironment.transform 23 98305 env4011 = env4041 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 98305 env4011 == env4041) = true)

theorem identity4041 : scanCanonicalize (H12AffineFastState.compose env4041 (packedSelected [3,5,24] rootPS)) = affineNative (2^(21+1) ^^^ 525961) := by decide +kernel

theorem selectedBound4041 : packedSelected [3,5,24] rootPS < 2^1333 := by decide +kernel

def env4042 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,524288,32768,4097,525961,5457,98305,591497,325,791244,1045,1044,1073741824,4165,4294967296,5444,4295536743,4096,599041]

theorem envBound4042 : H12AffineFastState.Bounded env4042 := by
  intro p hp
  have h : env4042.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4041_4042 : H12AffineEnvironment.transform 21 525961 env4041 = env4042 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 525961 env4041 == env4042) = true)

def env4043 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,524288,32768,4097,525961,5457,98305,591497,325,791244,1045,1044,360608,4165,4294967296,5444,4295536743,4096,599041]

theorem envBound4043 : H12AffineFastState.Bounded env4043 := by
  intro p hp
  have h : env4043.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4042_4043 : H12AffineEnvironment.transform 29 360608 env4042 = env4043 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360608 env4042 == env4043) = true)

theorem identity4043 : scanCanonicalize (H12AffineFastState.compose env4043 (packedSelected [3,5,8,17,21,28] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound4043 : packedSelected [3,5,8,17,21,28] rootPS < 2^1333 := by decide +kernel

def env4044 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,4096,8192,4096,32768,65536,4097,262144,524288,32768,4097,525961,5377,98305,591497,277,791196,1045,1044,360608,4117,4294967296,5396,4295536695,4096,599041]

theorem envBound4044 : H12AffineFastState.Bounded env4044 := by
  intro p hp
  have h : env4044.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4043_4044 : H12AffineEnvironment.transform 5 16 env4043 = env4044 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env4043 == env4044) = true)

def env4045 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,262144,524288,32768,4097,525961,5457,98305,591497,325,791244,1045,1044,360609,4165,4294967296,5444,4295536743,4096,599041]

theorem envBound4045 : H12AffineFastState.Bounded env4045 := by
  intro p hp
  have h : env4045.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4042_4045 : H12AffineEnvironment.transform 29 360609 env4042 = env4045 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 360609 env4042 == env4045) = true)

theorem identity4045 : scanCanonicalize (H12AffineFastState.compose env4045 (packedSelected [6,11,16,18,20,23,25,32] rootPS)) = affineNative (2^(17+1) ^^^ 48236) := by decide +kernel

theorem selectedBound4045 : packedSelected [6,11,16,18,20,23,25,32] rootPS < 2^1333 := by decide +kernel

def env4046 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4097,48236,524288,32768,4097,525961,5457,98305,591497,325,568992,1045,1044,81101,4165,4294967296,5444,4295536743,4096,599041]

theorem envBound4046 : H12AffineFastState.Bounded env4046 := by
  intro p hp
  have h : env4046.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4045_4046 : H12AffineEnvironment.transform 17 48236 env4045 = env4046 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 48236 env4045 == env4046) = true)

def env4047 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4176,32768,65536,4097,48236,524288,32768,4097,525961,5205,98305,591497,65,568992,1045,1044,81101,4165,4294967296,5184,4295536743,4096,599041]

theorem envBound4047 : H12AffineFastState.Bounded env4047 := by
  intro p hp
  have h : env4047.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4046_4047 : H12AffineEnvironment.transform 7 4 env4046 = env4047 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env4046 == env4047) = true)

theorem identity4047 : scanCanonicalize (H12AffineFastState.compose env4047 (packedSelected [5,12,13,15,21] rootPS)) = affineNative (2^(18+1) ^^^ 75264) := by decide +kernel

theorem selectedBound4047 : packedSelected [5,12,13,15,21] rootPS < 2^1333 := by decide +kernel

def env4048 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4176,32768,65536,4097,48236,75264,32768,4097,73865,5205,98305,8329,65,100512,1045,1044,81101,4165,4294967296,5184,4295071335,4096,513]

theorem envBound4048 : H12AffineFastState.Bounded env4048 := by
  intro p hp
  have h : env4048.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4047_4048 : H12AffineEnvironment.transform 18 75264 env4047 = env4048 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 75264 env4047 == env4048) = true)

theorem identity4048 : scanCanonicalize (H12AffineFastState.compose env4048 (packedSelected [0,1,4,5,7,8,9,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 13383) := by decide +kernel

theorem selectedBound4048 : packedSelected [0,1,4,5,7,8,9,12,13] rootPS < 2^1333 := by decide +kernel

def env4049 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,4096,8192,4176,13383,65536,4097,2091,75264,13383,4097,73865,5205,78918,8329,65,81127,1045,1044,81101,4165,4294967296,5184,4295041568,4096,513]

theorem envBound4049 : H12AffineFastState.Bounded env4049 := by
  intro p hp
  have h : env4049.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4048_4049 : H12AffineEnvironment.transform 14 13383 env4048 = env4049 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13383 env4048 == env4049) = true)

theorem identity4049 : scanCanonicalize (H12AffineFastState.compose env4049 (packedSelected [0,7,16] rootPS)) = affineNative (2^(11+1) ^^^ 1741) := by decide +kernel

theorem selectedBound4049 : packedSelected [0,7,16] rootPS < 2^1333 := by decide +kernel

def env4050 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1741,8192,1693,8842,65536,1740,2091,75264,8842,1740,73865,664,74379,8329,65,76330,1045,1044,76288,1672,4294967296,653,4295041568,1741,513]

theorem envBound4050 : H12AffineFastState.Bounded env4050 := by
  intro p hp
  have h : env4050.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4049_4050 : H12AffineEnvironment.transform 11 1741 env4049 = env4050 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1741 env4049 == env4050) = true)

def env4051 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1741,8192,1693,8842,2176,1740,2091,11904,8842,1740,10249,664,10763,8329,65,8874,1045,1044,8832,1672,4294967296,653,4294978208,1741,513]

theorem envBound4051 : H12AffineFastState.Bounded env4051 := by
  intro p hp
  have h : env4051.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4050_4051 : H12AffineEnvironment.transform 15 2176 env4050 = env4051 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2176 env4050 == env4051) = true)

theorem identity4051 : scanCanonicalize (H12AffineFastState.compose env4051 (packedSelected [0,6] rootPS)) = affineNative (2^(12+1) ^^^ 2689) := by decide +kernel

theorem selectedBound4051 : packedSelected [0,6] rootPS < 2^1333 := by decide +kernel

def env4052 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1741,2689,1693,2059,2176,1740,2091,1025,2059,1740,648,664,138,2568,65,2091,1045,1044,2049,1672,4294967296,653,4294967329,1741,513]

theorem envBound4052 : H12AffineFastState.Bounded env4052 := by
  intro p hp
  have h : env4052.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4051_4052 : H12AffineEnvironment.transform 12 2689 env4051 = env4052 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2689 env4051 == env4052) = true)

theorem identity4052 : scanCanonicalize (H12AffineFastState.compose env4052 (packedSelected [2,4] rootPS)) = affineNative (2^(5+1) ^^^ 59) := by decide +kernel

theorem selectedBound4052 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env4053 : List Nat := [2,4,8,16,32,59,128,4,512,1024,2048,1718,2689,1693,2059,2176,1719,2091,1025,2059,1719,648,664,138,2568,58,2091,1045,1044,2049,1672,4294967296,653,4294967329,1718,513]

theorem envBound4053 : H12AffineFastState.Bounded env4053 := by
  intro p hp
  have h : env4053.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4052_4053 : H12AffineEnvironment.transform 5 59 env4052 = env4053 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 59 env4052 == env4053) = true)

def env4054 : List Nat := [2,4,8,16,32,64,128,4,512,1024,2048,1741,8192,1693,8842,2177,1740,2091,11905,8842,1740,10248,664,10762,8329,65,8875,1045,1044,8833,1672,4294967296,653,4294978209,1741,513]

theorem envBound4054 : H12AffineFastState.Bounded env4054 := by
  intro p hp
  have h : env4054.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4050_4054 : H12AffineEnvironment.transform 15 2177 env4050 = env4054 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 2177 env4050 == env4054) = true)

def env4055 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,4096,8192,4176,32768,65536,4097,48236,524288,32768,4097,525961,5204,98305,591497,64,568992,1045,1044,81101,4165,4294967296,5185,4295536743,4096,599041]

theorem envBound4055 : H12AffineFastState.Bounded env4055 := by
  intro p hp
  have h : env4055.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4046_4055 : H12AffineEnvironment.transform 7 5 env4046 = env4055 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env4046 == env4055) = true)

theorem identity4055 : scanCanonicalize (H12AffineFastState.compose env4055 (packedSelected [10,12,13,15,17,19] rootPS)) = affineNative (2^(18+1) ^^^ 42634) := by decide +kernel

theorem selectedBound4055 : packedSelected [10,12,13,15,17,19] rootPS < 2^1333 := by decide +kernel

def env4056 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,4096,8192,4176,32768,65536,4097,48236,42634,32768,4097,40963,5204,98305,106499,64,2090,1045,1044,81101,4165,4294967296,5185,4294973165,4096,98955]

theorem envBound4056 : H12AffineFastState.Bounded env4056 := by
  intro p hp
  have h : env4056.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4055_4056 : H12AffineEnvironment.transform 18 42634 env4055 = env4056 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 42634 env4055 == env4056) = true)

theorem identity4056 : scanCanonicalize (H12AffineFastState.compose env4056 (packedSelected [11,18,20] rootPS)) = affineNative (2^(11+1) ^^^ 1092) := by decide +kernel

theorem selectedBound4056 : packedSelected [11,18,20] rootPS < 2^1333 := by decide +kernel

def env4057 : List Nat := [2,4,8,16,32,64,128,5,512,1024,2048,1092,8192,1044,32768,65536,1093,43048,42634,32768,1093,40963,16,98305,106499,64,2090,1045,1044,75913,1025,4294967296,5,4294967977,1092,98955]

theorem envBound4057 : H12AffineFastState.Bounded env4057 := by
  intro p hp
  have h : env4057.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4056_4057 : H12AffineEnvironment.transform 11 1092 env4056 = env4057 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1092 env4056 == env4057) = true)

theorem identity4057 : scanCanonicalize (H12AffineFastState.compose env4057 (packedSelected [1,3,12,13,15,17] rootPS)) = affineNative (2^(8+1) ^^^ 130) := by decide +kernel

theorem selectedBound4057 : packedSelected [1,3,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env4058 : List Nat := [2,4,8,16,32,64,128,5,130,1024,2048,1092,8192,1044,32768,65536,1093,43048,41992,32768,1093,40963,16,98305,106499,64,2090,1045,1044,75913,1025,4294967296,5,4294967339,1092,98313]

theorem envBound4058 : H12AffineFastState.Bounded env4058 := by
  intro p hp
  have h : env4058.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4057_4058 : H12AffineEnvironment.transform 8 130 env4057 = env4058 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 130 env4057 == env4058) = true)

theorem identity4058 : scanCanonicalize (H12AffineFastState.compose env4058 (packedSelected [5,12,13,15,21] rootPS)) = affineNative (2^(15+1) ^^^ 8322) := by decide +kernel

theorem selectedBound4058 : packedSelected [5,12,13,15,21] rootPS < 2^1333 := by decide +kernel

def env4059 : List Nat := [2,4,8,16,32,64,128,5,130,1024,2048,1092,8192,1044,32768,8322,1093,43048,41992,32768,1093,40963,16,41091,32897,64,2090,1045,1044,2059,1025,4294967296,5,4294967339,1092,41099]

theorem envBound4059 : H12AffineFastState.Bounded env4059 := by
  intro p hp
  have h : env4059.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4058_4059 : H12AffineEnvironment.transform 15 8322 env4058 = env4059 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8322 env4058 == env4059) = true)

theorem identity4059 : scanCanonicalize (H12AffineFastState.compose env4059 (packedSelected [2,4,7,11,16] rootPS)) = affineNative (2^(31+1) ^^^ 10243) := by decide +kernel

theorem selectedBound4059 : packedSelected [2,4,7,11,16] rootPS < 2^1333 := by decide +kernel

def env4060 : List Nat := [2,4,8,16,32,64,128,5,130,1024,2048,1092,8192,1044,32768,8322,1093,43048,41992,32768,1093,40963,16,41091,32897,64,2090,1045,1044,2059,1025,10243,5,10280,1092,41099]

theorem envBound4060 : H12AffineFastState.Bounded env4060 := by
  intro p hp
  have h : env4060.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4059_4060 : H12AffineEnvironment.transform 31 10243 env4059 = env4060 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 10243 env4059 == env4060) = true)

theorem identity4060 : scanCanonicalize (H12AffineFastState.compose env4060 (packedSelected [4,6,7,10,12,13] rootPS)) = affineNative (2^(5+1) ^^^ 59) := by decide +kernel

theorem selectedBound4060 : packedSelected [4,6,7,10,12,13] rootPS < 2^1333 := by decide +kernel

def env4061 : List Nat := [2,4,8,16,32,59,128,5,130,1024,2048,1087,8192,1044,32768,8322,1086,43048,41992,32768,1086,40963,16,41091,32897,59,2090,1045,1044,2059,1025,10243,5,10280,1087,41099]

theorem envBound4061 : H12AffineFastState.Bounded env4061 := by
  intro p hp
  have h : env4061.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4060_4061 : H12AffineEnvironment.transform 5 59 env4060 = env4061 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 59 env4060 == env4061) = true)

theorem identity4061 : scanCanonicalize (H12AffineFastState.compose env4061 (packedSelected [0,1,3,4] rootPS)) = affineNative (2^(14+1) ^^^ 2080) := by decide +kernel

theorem selectedBound4061 : packedSelected [0,1,3,4] rootPS < 2^1333 := by decide +kernel

def env4062 : List Nat := [2,4,8,16,32,59,128,5,130,1024,2048,1087,8192,1044,2080,8322,1086,8200,11304,2080,1086,10275,16,10403,2209,59,2090,1045,1044,2059,1025,10243,5,10280,1087,10411]

theorem envBound4062 : H12AffineFastState.Bounded env4062 := by
  intro p hp
  have h : env4062.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4061_4062 : H12AffineEnvironment.transform 14 2080 env4061 = env4062 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2080 env4061 == env4062) = true)

theorem identity4062 : scanCanonicalize (H12AffineFastState.compose env4062 (packedSelected [0,2,6,7] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound4062 : packedSelected [0,2,6,7] rootPS < 2^1333 := by decide +kernel

def env4063 : List Nat := [2,4,8,16,1,26,128,5,130,1024,2048,1054,8192,1044,2049,8322,1055,8200,11273,2049,1055,10242,16,10370,2176,26,2059,1045,1044,2059,1025,10243,5,10249,1054,10378]

theorem envBound4063 : H12AffineFastState.Bounded env4063 := by
  intro p hp
  have h : env4063.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4062_4063 : H12AffineEnvironment.transform 4 1 env4062 = env4063 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4062 == env4063) = true)

theorem identity4063 : scanCanonicalize (H12AffineFastState.compose env4063 (packedSelected [2] rootPS)) = affineNative (2^(12+1) ^^^ 2051) := by decide +kernel

theorem selectedBound4063 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4064 : List Nat := [2,4,8,16,1,26,128,5,130,1024,2048,1054,2051,1044,2049,2177,1055,2059,1034,2049,1055,1,16,129,2176,26,2059,1045,1044,2059,1025,0,5,10,1054,137]

theorem envBound4064 : H12AffineFastState.Bounded env4064 := by
  intro p hp
  have h : env4064.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4063_4064 : H12AffineEnvironment.transform 12 2051 env4063 = env4064 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2051 env4063 == env4064) = true)

theorem identity4064 : scanCanonicalize (H12AffineFastState.compose env4064 (packedSelected [0,9] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound4064 : packedSelected [0,9] rootPS < 2^1333 := by decide +kernel

def env4065 : List Nat := [2,4,3,16,1,17,128,5,130,1024,2048,1045,2051,1044,2049,2177,1044,2048,1025,2049,1044,1,16,129,2176,17,2048,1045,1044,2048,1025,0,5,1,1045,130]

theorem envBound4065 : H12AffineFastState.Bounded env4065 := by
  intro p hp
  have h : env4065.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4064_4065 : H12AffineEnvironment.transform 2 3 env4064 = env4065 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env4064 == env4065) = true)

theorem identity4065 : scanCanonicalize (H12AffineFastState.compose env4065 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound4065 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4066 : List Nat := [2,4,3,2,1,3,128,5,130,1024,2048,1031,2051,1030,2049,2177,1030,2048,1025,2049,1030,1,2,129,2176,3,2048,1031,1030,2048,1025,0,5,1,1031,130]

theorem envBound4066 : H12AffineFastState.Bounded env4066 := by
  intro p hp
  have h : env4066.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4065_4066 : H12AffineEnvironment.transform 3 2 env4065 = env4066 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env4065 == env4066) = true)

theorem identity4066 : scanCanonicalize (H12AffineFastState.compose env4066 (packedSelected [1] rootPS)) = affineNative (2^(10+1) ^^^ 1158) := by decide +kernel

theorem selectedBound4066 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4067 : List Nat := [2,4,3,2,1,3,128,5,130,1024,1158,1031,1157,1030,1159,1031,1030,1158,1025,1159,1030,1,2,129,1030,3,1158,1031,1030,1158,1025,0,5,1,1031,130]

theorem envBound4067 : H12AffineFastState.Bounded env4067 := by
  intro p hp
  have h : env4067.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4066_4067 : H12AffineEnvironment.transform 10 1158 env4066 = env4067 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1158 env4066 == env4067) = true)

theorem identity4067 : scanCanonicalize (H12AffineFastState.compose env4067 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound4067 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4068 : List Nat := [2,4,3,2,1,3,3,5,1,1024,1029,1031,1030,1030,1028,1031,1030,1029,1025,1028,1030,1,2,2,1030,3,1029,1031,1030,1029,1025,0,5,1,1031,1]

theorem envBound4068 : H12AffineFastState.Bounded env4068 := by
  intro p hp
  have h : env4068.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4067_4068 : H12AffineEnvironment.transform 6 3 env4067 = env4068 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env4067 == env4068) = true)

theorem identity4068 : scanCanonicalize (H12AffineFastState.compose env4068 (packedSelected [6] rootPS)) = affineNative (2^(9+1) ^^^ 4) := by decide +kernel

theorem selectedBound4068 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env4069 : List Nat := [2,4,3,2,1,3,3,5,1,4,1,3,2,2,0,3,2,1,5,0,2,1,2,2,2,3,1,3,2,1,5,0,5,1,3,1]

theorem envBound4069 : H12AffineFastState.Bounded env4069 := by
  intro p hp
  have h : env4069.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4068_4069 : H12AffineEnvironment.transform 9 4 env4068 = env4069 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 4 env4068 == env4069) = true)

def env4070 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,4194304,5456,16777216,33554432,17011013,4588613,17011732,16876565,1073741824,131140,4294967296,17007940,4333477991,131073,33563272]

theorem envBound4070 : H12AffineFastState.Bounded env4070 := by
  intro p hp
  have h : env4070.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans3741_4070 : H12AffineEnvironment.transform 13 4177 env3741 = env4070 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env3741 == env4070) = true)

theorem identity4070 : scanCanonicalize (H12AffineFastState.compose env4070 (packedSelected [1,3,10,13,15,24,28,31,33,38] rootPS)) = affineNative (2^(24+1) ^^^ 8329) := by decide +kernel

theorem selectedBound4070 : packedSelected [1,3,10,13,15,24,28,31,33,38] rootPS < 2^1333 := by decide +kernel

def env4071 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,4194304,5456,16777216,8329,17011013,4588613,17011732,16876565,1073741824,131140,4294967296,17007940,4299915502,131073,513]

theorem envBound4071 : H12AffineFastState.Bounded env4071 := by
  intro p hp
  have h : env4071.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4070_4071 : H12AffineEnvironment.transform 24 8329 env4070 = env4071 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env4070 == env4071) = true)

def env4072 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,140616,5456,16777216,8329,17011013,270605,17011732,16876565,1073741824,131140,4294967296,17007940,4295599526,131073,513]

theorem envBound4072 : H12AffineFastState.Bounded env4072 := by
  intro p hp
  have h : env4072.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4071_4072 : H12AffineEnvironment.transform 21 140616 env4071 = env4072 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 140616 env4071 == env4072) = true)

def env4073 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,1344,262144,524288,32768,4097,8200,5456,16777216,8329,16880645,270605,16879956,16876565,1073741824,1284,4294967296,16875524,4295599526,1345,513]

theorem envBound4073 : H12AffineFastState.Bounded env4073 := by
  intro p hp
  have h : env4073.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4072_4073 : H12AffineEnvironment.transform 16 1344 env4072 = env4073 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1344 env4072 == env4073) = true)

theorem identity4073 : scanCanonicalize (H12AffineFastState.compose env4073 (packedSelected [4,9,16] rootPS)) = affineNative (2^(29+1) ^^^ 108675) := by decide +kernel

theorem selectedBound4073 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env4074 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,1344,262144,524288,32768,4097,8200,5456,16777216,8329,16880645,270605,16879956,16876565,108675,1284,4294967296,16875524,4295599526,1345,513]

theorem envBound4074 : H12AffineFastState.Bounded env4074 := by
  intro p hp
  have h : env4074.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4073_4074 : H12AffineEnvironment.transform 29 108675 env4073 = env4074 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 108675 env4073 == env4074) = true)

def env4075 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,1344,262144,524288,32768,4097,8200,5456,16777216,8329,16880645,270605,16879956,16876565,106627,1284,4294967296,16875524,4295599526,1345,513]

theorem envBound4075 : H12AffineFastState.Bounded env4075 := by
  intro p hp
  have h : env4075.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4074_4075 : H12AffineEnvironment.transform 10 0 env4074 = env4075 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env4074 == env4075) = true)

theorem identity4075 : scanCanonicalize (H12AffineFastState.compose env4075 (packedSelected [11] rootPS)) = affineNative (2^(17+1) ^^^ 71475) := by decide +kernel

theorem selectedBound4075 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env4076 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,1344,71475,524288,32768,4097,8200,5456,16777216,8329,16880645,79422,16879956,16876565,106627,1284,4294967296,16875524,4295599526,1345,513]

theorem envBound4076 : H12AffineFastState.Bounded env4076 := by
  intro p hp
  have h : env4076.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4075_4076 : H12AffineEnvironment.transform 17 71475 env4075 = env4076 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 71475 env4075 == env4076) = true)

def env4077 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,1345,32768,65536,1344,66083,524288,32768,1297,8200,64,16777216,8329,16875797,74542,16876612,16876565,106627,1284,4294967296,16875524,4295599526,1345,513]

theorem envBound4077 : H12AffineFastState.Bounded env4077 := by
  intro p hp
  have h : env4077.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4076_4077 : H12AffineEnvironment.transform 11 1296 env4076 = env4077 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env4076 == env4077) = true)

theorem identity4077 : scanCanonicalize (H12AffineFastState.compose env4077 (packedSelected [0,7,20] rootPS)) = affineNative (2^(23+1) ^^^ 99212) := by decide +kernel

theorem selectedBound4077 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env4078 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,1345,32768,65536,1344,66083,524288,32768,1297,8200,64,99212,8329,665,74542,1992,1945,106627,1284,4294967296,904,4295599526,1345,513]

theorem envBound4078 : H12AffineFastState.Bounded env4078 := by
  intro p hp
  have h : env4078.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4077_4078 : H12AffineEnvironment.transform 23 99212 env4077 = env4078 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 99212 env4077 == env4078) = true)

theorem identity4078 : scanCanonicalize (H12AffineFastState.compose env4078 (packedSelected [4,18,22] rootPS)) = affineNative (2^(15+1) ^^^ 41090) := by decide +kernel

theorem selectedBound4078 : packedSelected [4,18,22] rootPS < 2^1333 := by decide +kernel

def env4079 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,8192,1345,32768,41090,1344,41633,524288,32768,1297,8200,64,8974,8329,665,33708,1992,1945,1,1284,4294967296,904,4295492900,1345,513]

theorem envBound4079 : H12AffineFastState.Bounded env4079 := by
  intro p hp
  have h : env4079.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4078_4079 : H12AffineEnvironment.transform 15 41090 env4078 = env4079 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 41090 env4078 == env4079) = true)

theorem identity4079 : scanCanonicalize (H12AffineFastState.compose env4079 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(12+1) ^^^ 269) := by decide +kernel

theorem selectedBound4079 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env4080 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1296,269,1345,32768,33167,1344,33708,524288,32768,1297,261,64,515,388,665,33708,1992,1945,1,1284,4294967296,904,4295492900,1345,513]

theorem envBound4080 : H12AffineFastState.Bounded env4080 := by
  intro p hp
  have h : env4080.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4079_4080 : H12AffineEnvironment.transform 12 269 env4079 = env4080 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 269 env4079 == env4080) = true)

theorem identity4080 : scanCanonicalize (H12AffineFastState.compose env4080 (packedSelected [0,7] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound4080 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4081 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,1296,269,1345,32768,33167,1344,33060,524288,32768,1297,261,64,139,388,17,33060,1344,1297,1,1284,4294967296,256,4295492900,1345,137]

theorem envBound4081 : H12AffineFastState.Bounded env4081 := by
  intro p hp
  have h : env4081.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4080_4081 : H12AffineEnvironment.transform 8 136 env4080 = env4081 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env4080 == env4081) = true)

theorem identity4081 : scanCanonicalize (H12AffineFastState.compose env4081 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 69) := by decide +kernel

theorem selectedBound4081 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env4082 : List Nat := [2,4,8,16,32,64,128,69,136,1024,0,1109,72,1028,32768,32970,1029,32865,524288,32768,1108,64,64,139,193,17,32865,1029,1108,1,1089,4294967296,69,4295492705,1028,137]

theorem envBound4082 : H12AffineFastState.Bounded env4082 := by
  intro p hp
  have h : env4082.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4081_4082 : H12AffineEnvironment.transform 7 69 env4081 = env4082 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 69 env4081 == env4082) = true)

theorem identity4082 : scanCanonicalize (H12AffineFastState.compose env4082 (packedSelected [5,8] rootPS)) = affineNative (2^(18+1) ^^^ 33793) := by decide +kernel

theorem selectedBound4082 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env4083 : List Nat := [2,4,8,16,32,64,128,69,136,1024,0,1109,72,1028,32768,32970,1029,32865,33793,32768,1108,64,64,139,193,17,32865,1029,1108,1,1089,4294967296,69,4295000160,1028,137]

theorem envBound4083 : H12AffineFastState.Bounded env4083 := by
  intro p hp
  have h : env4083.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4082_4083 : H12AffineEnvironment.transform 18 33793 env4082 = env4083 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 33793 env4082 == env4083) = true)

theorem identity4083 : scanCanonicalize (H12AffineFastState.compose env4083 (packedSelected [0,1,3] rootPS)) = affineNative (2^(31+1) ^^^ 74) := by decide +kernel

theorem selectedBound4083 : packedSelected [0,1,3] rootPS < 2^1333 := by decide +kernel

def env4084 : List Nat := [2,4,8,16,32,64,128,69,136,1024,0,1109,72,1028,32768,32970,1029,32865,33793,32768,1108,64,64,139,193,17,32865,1029,1108,1,1089,74,69,32810,1028,137]

theorem envBound4084 : H12AffineFastState.Bounded env4084 := by
  intro p hp
  have h : env4084.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4083_4084 : H12AffineEnvironment.transform 31 74 env4083 = env4084 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 74 env4083 == env4084) = true)

theorem identity4084 : scanCanonicalize (H12AffineFastState.compose env4084 (packedSelected [2,9] rootPS)) = affineNative (2^(14+1) ^^^ 0) := by decide +kernel

theorem selectedBound4084 : packedSelected [2,9] rootPS < 2^1333 := by decide +kernel

def env4085 : List Nat := [2,4,8,16,32,64,128,69,136,1024,0,1109,72,1028,0,202,1029,97,1025,0,1108,64,64,139,193,17,97,1029,1108,1,1089,74,69,42,1028,137]

theorem envBound4085 : H12AffineFastState.Bounded env4085 := by
  intro p hp
  have h : env4085.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4084_4085 : H12AffineEnvironment.transform 14 0 env4084 = env4085 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 0 env4084 == env4085) = true)

def env4086 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,1297,8192,1344,32768,65536,1344,66082,524288,32768,1296,8200,65,16777216,8329,16875796,74543,16876613,16876565,106627,1284,4294967296,16875524,4295599526,1345,513]

theorem envBound4086 : H12AffineFastState.Bounded env4086 := by
  intro p hp
  have h : env4086.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4076_4086 : H12AffineEnvironment.transform 11 1297 env4076 = env4086 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env4076 == env4086) = true)

theorem identity4086 : scanCanonicalize (H12AffineFastState.compose env4086 (packedSelected [0,7,20] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound4086 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env4087 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1297,8192,1344,32768,65536,1344,65707,524288,32768,1296,8200,65,16777216,8329,16875796,74150,16876613,16876565,106627,1284,4294967296,16875524,4295599526,1345,136]

theorem envBound4087 : H12AffineFastState.Bounded env4087 := by
  intro p hp
  have h : env4087.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4086_4087 : H12AffineEnvironment.transform 8 137 env4086 = env4087 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env4086 == env4087) = true)

theorem identity4087 : scanCanonicalize (H12AffineFastState.compose env4087 (packedSelected [1,3,4,9,10,13,15,18] rootPS)) = affineNative (2^(23+1) ^^^ 8582) := by decide +kernel

theorem selectedBound4087 : packedSelected [1,3,4,9,10,13,15,18] rootPS < 2^1333 := by decide +kernel

def env4088 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1297,8192,1344,32768,65536,1344,65707,524288,32768,1296,8200,65,8582,8329,106642,74150,107971,107923,106627,1284,4294967296,106882,4295599526,1345,136]

theorem envBound4088 : H12AffineFastState.Bounded env4088 := by
  intro p hp
  have h : env4088.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4087_4088 : H12AffineEnvironment.transform 23 8582 env4087 = env4088 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 8582 env4087 == env4088) = true)

theorem identity4088 : scanCanonicalize (H12AffineFastState.compose env4088 (packedSelected [0,1,2,3,4,5,6,8,12,13,15,17] rootPS)) = affineNative (2^(15+1) ^^^ 33167) := by decide +kernel

theorem selectedBound4088 : packedSelected [0,1,2,3,4,5,6,8,12,13,15,17] rootPS < 2^1333 := by decide +kernel

def env4089 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1297,8192,1344,32768,33167,1344,33060,524288,32768,1296,8200,65,8582,8329,8477,41001,9292,9244,8460,1284,4294967296,8205,4295500841,1345,136]

theorem envBound4089 : H12AffineFastState.Bounded env4089 := by
  intro p hp
  have h : env4089.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4088_4089 : H12AffineEnvironment.transform 15 33167 env4088 = env4089 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33167 env4088 == env4089) = true)

theorem identity4089 : scanCanonicalize (H12AffineFastState.compose env4089 (packedSelected [0,1,4,5,7,9,12,21] rootPS)) = affineNative (2^(14+1) ^^^ 293) := by decide +kernel

theorem selectedBound4089 : packedSelected [0,1,4,5,7,9,12,21] rootPS < 2^1333 := by decide +kernel

def env4090 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1297,8192,1344,293,170,1344,1,524288,293,1296,8200,65,8582,8329,8477,8460,9292,9244,8460,1284,4294967296,8205,4295500841,1345,136]

theorem envBound4090 : H12AffineFastState.Bounded env4090 := by
  intro p hp
  have h : env4090.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4089_4090 : H12AffineEnvironment.transform 14 293 env4089 = env4090 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 293 env4089 == env4090) = true)

theorem identity4090 : scanCanonicalize (H12AffineFastState.compose env4090 (packedSelected [0,7] rootPS)) = affineNative (2^(12+1) ^^^ 268) := by decide +kernel

theorem selectedBound4090 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4091 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,1297,268,1344,293,170,1344,1,524288,293,1296,260,65,138,389,17,0,1344,1296,0,1284,4294967296,257,4295492901,1345,136]

theorem envBound4091 : H12AffineFastState.Bounded env4091 := by
  intro p hp
  have h : env4091.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4090_4091 : H12AffineEnvironment.transform 12 268 env4090 = env4091 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 268 env4090 == env4091) = true)

theorem identity4091 : scanCanonicalize (H12AffineFastState.compose env4091 (packedSelected [2,4] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound4091 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env4092 : List Nat := [2,4,8,16,32,64,128,5,137,1024,0,1044,9,1093,32,170,1093,1,524288,32,1045,1,65,138,128,17,0,1093,1045,0,1025,4294967296,4,4295492640,1092,136]

theorem envBound4092 : H12AffineFastState.Bounded env4092 := by
  intro p hp
  have h : env4092.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4091_4092 : H12AffineEnvironment.transform 7 5 env4091 = env4092 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env4091 == env4092) = true)

def env4093 : List Nat := [2,4,8,16,0,64,128,5,137,1024,0,1044,9,1093,0,138,1093,1,524288,0,1045,1,65,138,128,17,0,1093,1045,0,1025,4294967296,4,4295492608,1092,136]

theorem envBound4093 : H12AffineFastState.Bounded env4093 := by
  intro p hp
  have h : env4093.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4092_4093 : H12AffineEnvironment.transform 4 0 env4092 = env4093 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4092 == env4093) = true)

theorem identity4093 : scanCanonicalize (H12AffineFastState.compose env4093 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 1118) := by decide +kernel

theorem selectedBound4093 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4094 : List Nat := [2,4,8,16,0,64,128,5,137,1024,0,1044,9,1093,0,138,1093,1,524288,0,1045,1,65,138,128,17,0,1093,1045,0,1025,1118,4,524382,1092,136]

theorem envBound4094 : H12AffineFastState.Bounded env4094 := by
  intro p hp
  have h : env4094.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4093_4094 : H12AffineEnvironment.transform 31 1118 env4093 = env4094 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1118 env4093 == env4094) = true)

theorem identity4094 : scanCanonicalize (H12AffineFastState.compose env4094 (packedSelected [1,2] rootPS)) = affineNative (2^(18+1) ^^^ 134) := by decide +kernel

theorem selectedBound4094 : packedSelected [1,2] rootPS < 2^1333 := by decide +kernel

def env4095 : List Nat := [2,4,8,16,0,64,128,5,137,1024,0,1044,9,1093,0,138,1093,1,134,0,1045,1,65,138,128,17,0,1093,1045,0,1025,1118,4,216,1092,136]

theorem envBound4095 : H12AffineFastState.Bounded env4095 := by
  intro p hp
  have h : env4095.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4094_4095 : H12AffineEnvironment.transform 18 134 env4094 = env4095 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 134 env4094 == env4095) = true)

theorem identity4095 : scanCanonicalize (H12AffineFastState.compose env4095 (packedSelected [3] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound4095 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4096 : List Nat := [2,4,8,16,0,16,128,5,137,1024,0,1044,9,1045,0,138,1045,1,134,0,1045,1,17,138,128,17,0,1045,1045,0,1025,1038,4,136,1044,136]

theorem envBound4096 : H12AffineFastState.Bounded env4096 := by
  intro p hp
  have h : env4096.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4095_4096 : H12AffineEnvironment.transform 5 16 env4095 = env4096 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env4095 == env4096) = true)

theorem identity4096 : scanCanonicalize (H12AffineFastState.compose env4096 (packedSelected [1,5] rootPS)) = affineNative (2^(9+1) ^^^ 134) := by decide +kernel

theorem selectedBound4096 : packedSelected [1,5] rootPS < 2^1333 := by decide +kernel

def env4097 : List Nat := [2,4,8,16,0,16,128,5,137,134,0,146,9,147,0,138,147,1,134,0,147,1,17,138,128,17,0,147,147,0,135,136,4,136,146,136]

theorem envBound4097 : H12AffineFastState.Bounded env4097 := by
  intro p hp
  have h : env4097.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4096_4097 : H12AffineEnvironment.transform 9 134 env4096 = env4097 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 134 env4096 == env4097) = true)

def leafEnv4097 : List Nat := [2,4,8,16,0,16,128,5,137,134,0,146,9,147,0,138,147,1,134,0,147,1,17,138,134,128,1,17,0,147,147,0,135,136,4,136,4,3,146,136,0,147,1]

def active4097 : List Nat := [0,1,2,3,6]

def tree4097 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4097 : H12WitnessSearch.Good tree4097 := H12GlobalWitnessIndex.good

theorem leafIdentity4097 : H12AffineFastState.composeSystem env4097 rootObs = leafEnv4097 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4097 rootObs == leafEnv4097) = true)

theorem terminalChecked4097 : H12PackedTerminal.terminalCheckFast leafEnv4097 active4097 tree4097 = true := by decide +kernel

def env4098 : List Nat := [2,4,8,16,1,64,128,5,137,1024,0,1044,9,1093,1,139,1093,1,524288,1,1045,1,65,138,128,17,0,1093,1045,0,1025,4294967296,4,4295492609,1092,136]

theorem envBound4098 : H12AffineFastState.Bounded env4098 := by
  intro p hp
  have h : env4098.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4092_4098 : H12AffineEnvironment.transform 4 1 env4092 = env4098 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4092 == env4098) = true)

theorem identity4098 : scanCanonicalize (H12AffineFastState.compose env4098 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 1238) := by decide +kernel

theorem selectedBound4098 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4099 : List Nat := [2,4,8,16,1,64,128,5,137,1024,0,1044,9,1093,1,139,1093,1,524288,1,1045,1,65,138,128,17,0,1093,1045,0,1025,1238,4,524503,1092,136]

theorem envBound4099 : H12AffineFastState.Bounded env4099 := by
  intro p hp
  have h : env4099.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4098_4099 : H12AffineEnvironment.transform 31 1238 env4098 = env4099 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 1238 env4098 == env4099) = true)

theorem identity4099 : scanCanonicalize (H12AffineFastState.compose env4099 (packedSelected [2,3] rootPS)) = affineNative (2^(9+1) ^^^ 15) := by decide +kernel

theorem selectedBound4099 : packedSelected [2,3] rootPS < 2^1333 := by decide +kernel

def env4100 : List Nat := [2,4,8,16,1,64,128,5,137,15,0,27,9,74,1,139,74,1,524288,1,26,1,65,138,128,17,0,74,26,0,14,217,4,524503,75,136]

theorem envBound4100 : H12AffineFastState.Bounded env4100 := by
  intro p hp
  have h : env4100.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4099_4100 : H12AffineEnvironment.transform 9 15 env4099 = env4100 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 15 env4099 == env4100) = true)

theorem identity4100 : scanCanonicalize (H12AffineFastState.compose env4100 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound4100 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4101 : List Nat := [2,4,8,16,1,64,8,5,1,15,0,27,9,74,1,3,74,1,524288,1,26,1,65,2,8,17,0,74,26,0,14,81,4,524383,75,0]

theorem envBound4101 : H12AffineFastState.Bounded env4101 := by
  intro p hp
  have h : env4101.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4100_4101 : H12AffineEnvironment.transform 6 8 env4100 = env4101 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env4100 == env4101) = true)

def leafEnv4101 : List Nat := [2,4,8,16,1,64,8,5,1,15,0,27,9,74,1,3,74,1,524288,1,26,1,65,2,524288,8,1,17,0,74,26,0,14,81,4,524383,4,2,75,0,0,26,1]

def active4101 : List Nat := [0,1,2,3,5,18]

def tree4101 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4101 : H12WitnessSearch.Good tree4101 := H12GlobalWitnessIndex.good

theorem leafIdentity4101 : H12AffineFastState.composeSystem env4101 rootObs = leafEnv4101 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4101 rootObs == leafEnv4101) = true)

theorem terminalChecked4101 : H12PackedTerminal.terminalCheckFast leafEnv4101 active4101 tree4101 = true := by decide +kernel

def env4102 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,1344,262144,524288,32768,4097,8200,5456,16777216,8329,16880645,270605,16879956,16876565,106626,1284,4294967296,16875524,4295599526,1345,513]

theorem envBound4102 : H12AffineFastState.Bounded env4102 := by
  intro p hp
  have h : env4102.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4074_4102 : H12AffineEnvironment.transform 10 1 env4074 = env4102 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env4074 == env4102) = true)

theorem identity4102 : scanCanonicalize (H12AffineFastState.compose env4102 (packedSelected [11] rootPS)) = affineNative (2^(23+1) ^^^ 268050) := by decide +kernel

theorem selectedBound4102 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env4103 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1,4096,8192,4177,32768,65536,1344,262144,524288,32768,4097,8200,5456,268050,8329,361239,270605,362054,365319,106626,1284,4294967296,366358,4295599526,1345,513]

theorem envBound4103 : H12AffineFastState.Bounded env4103 := by
  intro p hp
  have h : env4103.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4102_4103 : H12AffineEnvironment.transform 23 268050 env4102 = env4103 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 268050 env4102 == env4103) = true)

def env4104 : List Nat := [2,4,8,16,32,64,128,36,512,1024,1,4096,8192,4177,32768,65536,1124,262144,524288,32768,4097,8200,5236,267830,8329,361011,270377,362054,365091,106626,1056,4294967296,366130,4295599234,1125,513]

theorem envBound4104 : H12AffineFastState.Bounded env4104 := by
  intro p hp
  have h : env4104.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4103_4104 : H12AffineEnvironment.transform 7 36 env4103 = env4104 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env4103 == env4104) = true)

theorem identity4104 : scanCanonicalize (H12AffineFastState.compose env4104 (packedSelected [1,3,9,12,13,15,17,22] rootPS)) = affineNative (2^(17+1) ^^^ 5173) := by decide +kernel

theorem selectedBound4104 : packedSelected [1,3,9,12,13,15,17,22] rootPS < 2^1333 := by decide +kernel

def env4105 : List Nat := [2,4,8,16,32,64,128,36,512,1024,1,4096,8192,4177,32768,65536,1124,5173,524288,32768,4097,8200,5236,515,8329,103942,13340,103027,99862,106626,1056,4294967296,98823,4295599234,1125,513]

theorem envBound4105 : H12AffineFastState.Bounded env4105 := by
  intro p hp
  have h : env4105.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4104_4105 : H12AffineEnvironment.transform 17 5173 env4104 = env4105 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 5173 env4104 == env4105) = true)

theorem identity4105 : scanCanonicalize (H12AffineFastState.compose env4105 (packedSelected [1,5,8,17,20,21,23,24] rootPS)) = affineNative (2^(15+1) ^^^ 32939) := by decide +kernel

theorem selectedBound4105 : packedSelected [1,5,8,17,20,21,23,24] rootPS < 2^1333 := by decide +kernel

def env4106 : List Nat := [2,4,8,16,32,64,128,36,512,1024,1,4096,8192,4177,32768,32939,1124,5173,524288,32768,4097,8200,5236,515,8329,5805,13340,4824,1725,8233,1056,4294967296,684,4295500841,1125,513]

theorem envBound4106 : H12AffineFastState.Bounded env4106 := by
  intro p hp
  have h : env4106.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4105_4106 : H12AffineEnvironment.transform 15 32939 env4105 = env4106 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 32939 env4105 == env4106) = true)

theorem identity4106 : scanCanonicalize (H12AffineFastState.compose env4106 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(14+1) ^^^ 13973) := by decide +kernel

theorem selectedBound4106 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env4107 : List Nat := [2,4,8,16,32,64,128,36,512,1024,1,4096,8192,4177,13973,13886,1124,5173,524288,13973,4097,8200,5236,515,8329,5805,13340,4824,1725,8233,1056,4294967296,684,4295500841,1125,513]

theorem envBound4107 : H12AffineFastState.Bounded env4107 := by
  intro p hp
  have h : env4107.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4106_4107 : H12AffineEnvironment.transform 14 13973 env4106 = env4107 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13973 env4106 == env4107) = true)

theorem identity4107 : scanCanonicalize (H12AffineFastState.compose env4107 (packedSelected [0,5,7,8,10,13,18] rootPS)) = affineNative (2^(18+1) ^^^ 12316) := by decide +kernel

theorem selectedBound4107 : packedSelected [0,5,7,8,10,13,18] rootPS < 2^1333 := by decide +kernel

def env4108 : List Nat := [2,4,8,16,32,64,128,36,512,1024,1,4096,8192,4177,13973,13886,1124,5173,12316,13973,4097,8200,5236,515,8329,5805,13340,4824,1725,8233,1056,4294967296,684,4294972469,1125,513]

theorem envBound4108 : H12AffineFastState.Bounded env4108 := by
  intro p hp
  have h : env4108.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4107_4108 : H12AffineEnvironment.transform 18 12316 env4107 = env4108 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 12316 env4107 == env4108) = true)

theorem identity4108 : scanCanonicalize (H12AffineFastState.compose env4108 (packedSelected [0,1,5,7,10] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound4108 : packedSelected [0,1,5,7,10] rootPS < 2^1333 := by decide +kernel

def env4109 : List Nat := [2,4,8,16,32,64,128,36,137,1024,1,4096,8192,4177,13340,13495,1124,5173,12316,13340,4097,8200,5236,138,8329,5156,13340,4177,1076,8233,1056,4294967296,37,4294972469,1125,136]

theorem envBound4109 : H12AffineFastState.Bounded env4109 := by
  intro p hp
  have h : env4109.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4108_4109 : H12AffineEnvironment.transform 8 137 env4108 = env4109 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env4108 == env4109) = true)

theorem identity4109 : scanCanonicalize (H12AffineFastState.compose env4109 (packedSelected [2,4] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound4109 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env4110 : List Nat := [2,4,8,16,1,64,128,5,137,1024,1,4096,8192,4177,13340,13462,1093,5140,12316,13340,4097,8200,5205,138,8329,5125,13340,4177,1045,8200,1025,4294967296,4,4294972436,1092,136]

theorem envBound4110 : H12AffineFastState.Bounded env4110 := by
  intro p hp
  have h : env4110.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4109_4110 : H12AffineEnvironment.transform 4 1 env4109 = env4110 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4109 == env4110) = true)

theorem identity4110 : scanCanonicalize (H12AffineFastState.compose env4110 (packedSelected [0,1,3,5,7] rootPS)) = affineNative (2^(12+1) ^^^ 5148) := by decide +kernel

theorem selectedBound4110 : packedSelected [0,1,3,5,7] rootPS < 2^1333 := by decide +kernel

def env4111 : List Nat := [2,4,8,16,1,64,128,5,137,1024,1,4096,5148,4177,0,138,1093,5140,1024,0,4097,5140,5205,138,5269,5125,0,4177,1045,5140,1025,4294967296,4,4294972436,1092,136]

theorem envBound4111 : H12AffineFastState.Bounded env4111 := by
  intro p hp
  have h : env4111.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4110_4111 : H12AffineEnvironment.transform 12 5148 env4110 = env4111 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5148 env4110 == env4111) = true)

theorem identity4111 : scanCanonicalize (H12AffineFastState.compose env4111 (packedSelected [1,3] rootPS)) = affineNative (2^(31+1) ^^^ 216) := by decide +kernel

theorem selectedBound4111 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4112 : List Nat := [2,4,8,16,1,64,128,5,137,1024,1,4096,5148,4177,0,138,1093,5140,1024,0,4097,5140,5205,138,5269,5125,0,4177,1045,5140,1025,216,4,5324,1092,136]

theorem envBound4112 : H12AffineFastState.Bounded env4112 := by
  intro p hp
  have h : env4112.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4111_4112 : H12AffineEnvironment.transform 31 216 env4111 = env4112 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 216 env4111 == env4112) = true)

theorem identity4112 : scanCanonicalize (H12AffineFastState.compose env4112 (packedSelected [0,2] rootPS)) = affineNative (2^(11+1) ^^^ 74) := by decide +kernel

theorem selectedBound4112 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env4113 : List Nat := [2,4,8,16,1,64,128,5,137,1024,1,74,1110,27,0,138,1093,1118,1024,0,75,1118,1055,138,1247,1103,0,27,1045,1118,1025,216,4,1158,1092,136]

theorem envBound4113 : H12AffineFastState.Bounded env4113 := by
  intro p hp
  have h : env4113.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4112_4113 : H12AffineEnvironment.transform 11 74 env4112 = env4113 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 74 env4112 == env4113) = true)

theorem identity4113 : scanCanonicalize (H12AffineFastState.compose env4113 (packedSelected [12] rootPS)) = affineNative (2^(9+1) ^^^ 95) := by decide +kernel

theorem selectedBound4113 : packedSelected [12] rootPS < 2^1333 := by decide +kernel

def env4114 : List Nat := [2,4,8,16,1,64,128,5,137,95,1,74,9,27,0,138,26,1,95,0,75,1,64,138,128,16,0,27,74,1,94,216,4,217,27,136]

theorem envBound4114 : H12AffineFastState.Bounded env4114 := by
  intro p hp
  have h : env4114.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4113_4114 : H12AffineEnvironment.transform 9 95 env4113 = env4114 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 95 env4113 == env4114) = true)

theorem identity4114 : scanCanonicalize (H12AffineFastState.compose env4114 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 89) := by decide +kernel

theorem selectedBound4114 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4115 : List Nat := [2,4,8,16,1,64,89,5,80,95,1,74,9,27,0,83,26,1,95,0,75,1,64,83,89,16,0,27,74,1,94,1,4,0,27,81]

theorem envBound4115 : H12AffineFastState.Bounded env4115 := by
  intro p hp
  have h : env4115.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4114_4115 : H12AffineEnvironment.transform 6 89 env4114 = env4115 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 89 env4114 == env4115) = true)

def leafEnv4115 : List Nat := [2,4,8,16,1,64,89,5,80,95,1,74,9,27,0,83,26,1,95,0,75,1,64,83,95,89,1,16,0,27,74,1,94,1,4,0,4,3,27,81,0,74,1]

def active4115 : List Nat := [0,1,2,3,5]

def tree4115 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4115 : H12WitnessSearch.Good tree4115 := H12GlobalWitnessIndex.good

theorem leafIdentity4115 : H12AffineFastState.composeSystem env4115 rootObs = leafEnv4115 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4115 rootObs == leafEnv4115) = true)

theorem terminalChecked4115 : H12PackedTerminal.terminalCheckFast leafEnv4115 active4115 tree4115 = true := by decide +kernel

def env4116 : List Nat := [2,4,8,16,32,64,128,37,512,1024,1,4096,8192,4177,32768,65536,1125,262144,524288,32768,4097,8200,5237,267831,8329,361010,270376,362054,365090,106626,1057,4294967296,366131,4295599235,1124,513]

theorem envBound4116 : H12AffineFastState.Bounded env4116 := by
  intro p hp
  have h : env4116.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4103_4116 : H12AffineEnvironment.transform 7 37 env4103 = env4116 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env4103 == env4116) = true)

theorem identity4116 : scanCanonicalize (H12AffineFastState.compose env4116 (packedSelected [1,3,9,12,13,15,17,22] rootPS)) = affineNative (2^(15+1) ^^^ 33315) := by decide +kernel

theorem selectedBound4116 : packedSelected [1,3,9,12,13,15,17,22] rootPS < 2^1333 := by decide +kernel

def env4117 : List Nat := [2,4,8,16,32,64,128,37,512,1024,1,4096,8192,4177,32768,33315,1125,262144,524288,32768,4097,8200,5237,267831,8329,262161,270376,263269,266241,8865,1057,4294967296,267280,4295501472,1124,513]

theorem envBound4117 : H12AffineFastState.Bounded env4117 := by
  intro p hp
  have h : env4117.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4116_4117 : H12AffineEnvironment.transform 15 33315 env4116 = env4117 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33315 env4116 == env4117) = true)

theorem identity4117 : scanCanonicalize (H12AffineFastState.compose env4117 (packedSelected [0,1,2,3,6,9,20,24,28] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound4117 : packedSelected [0,1,2,3,6,9,20,24,28] rootPS < 2^1333 := by decide +kernel

def env4118 : List Nat := [2,4,8,16,32,64,128,37,137,1024,1,4096,8192,4177,32768,32938,1125,262144,524288,32768,4097,8200,5237,267454,8329,262161,270376,263269,266241,8232,1057,4294967296,267280,4295500841,1124,136]

theorem envBound4118 : H12AffineFastState.Bounded env4118 := by
  intro p hp
  have h : env4118.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4117_4118 : H12AffineEnvironment.transform 8 137 env4117 = env4118 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env4117 == env4118) = true)

theorem identity4118 : scanCanonicalize (H12AffineFastState.compose env4118 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(14+1) ^^^ 13341) := by decide +kernel

theorem selectedBound4118 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env4119 : List Nat := [2,4,8,16,32,64,128,37,137,1024,1,4096,8192,4177,13341,13495,1125,262144,524288,13341,4097,8200,5237,267454,8329,262161,270376,263269,266241,8232,1057,4294967296,267280,4295500841,1124,136]

theorem envBound4119 : H12AffineFastState.Bounded env4119 := by
  intro p hp
  have h : env4119.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4118_4119 : H12AffineEnvironment.transform 14 13341 env4118 = env4119 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13341 env4118 == env4119) = true)

theorem identity4119 : scanCanonicalize (H12AffineFastState.compose env4119 (packedSelected [5,8,10,13] rootPS)) = affineNative (2^(12+1) ^^^ 5148) := by decide +kernel

theorem selectedBound4119 : packedSelected [5,8,10,13] rootPS < 2^1333 := by decide +kernel

def env4120 : List Nat := [2,4,8,16,32,64,128,37,137,1024,1,4096,5148,4177,1,171,1125,262144,524288,1,4097,5140,5237,267454,5269,262161,267316,263269,266241,5172,1057,4294967296,267280,4295495733,1124,136]

theorem envBound4120 : H12AffineFastState.Bounded env4120 := by
  intro p hp
  have h : env4120.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4119_4120 : H12AffineEnvironment.transform 12 5148 env4119 = env4120 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 5148 env4119 == env4120) = true)

def env4121 : List Nat := [2,4,8,16,32,64,128,37,137,1024,1,4096,5148,4177,1,171,1125,262144,1024,1,4097,5140,5237,267454,5269,262161,267316,263269,266241,5172,1057,4294967296,267280,4294972469,1124,136]

theorem envBound4121 : H12AffineFastState.Bounded env4121 := by
  intro p hp
  have h : env4121.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4120_4121 : H12AffineEnvironment.transform 18 1024 env4120 = env4121 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env4120 == env4121) = true)

theorem identity4121 : scanCanonicalize (H12AffineFastState.compose env4121 (packedSelected [0,5,7,8] rootPS)) = affineNative (2^(17+1) ^^^ 5172) := by decide +kernel

theorem selectedBound4121 : packedSelected [0,5,7,8] rootPS < 2^1333 := by decide +kernel

def env4122 : List Nat := [2,4,8,16,32,64,128,37,137,1024,1,4096,5148,4177,1,171,1125,5172,1024,1,4097,5140,5237,138,5269,5157,0,4177,1077,5172,1057,4294967296,36,4294972469,1124,136]

theorem envBound4122 : H12AffineFastState.Bounded env4122 := by
  intro p hp
  have h : env4122.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4121_4122 : H12AffineEnvironment.transform 17 5172 env4121 = env4122 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 5172 env4121 == env4122) = true)

theorem identity4122 : scanCanonicalize (H12AffineFastState.compose env4122 (packedSelected [1,3] rootPS)) = affineNative (2^(31+1) ^^^ 249) := by decide +kernel

theorem selectedBound4122 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4123 : List Nat := [2,4,8,16,32,64,128,37,137,1024,1,4096,5148,4177,1,171,1125,5172,1024,1,4097,5140,5237,138,5269,5157,0,4177,1077,5172,1057,249,36,5324,1124,136]

theorem envBound4123 : H12AffineFastState.Bounded env4123 := by
  intro p hp
  have h : env4123.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4122_4123 : H12AffineEnvironment.transform 31 249 env4122 = env4123 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 249 env4122 == env4123) = true)

theorem identity4123 : scanCanonicalize (H12AffineFastState.compose env4123 (packedSelected [0,2] rootPS)) = affineNative (2^(11+1) ^^^ 58) := by decide +kernel

theorem selectedBound4123 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env4124 : List Nat := [2,4,8,16,32,64,128,37,137,1024,1,58,1062,107,1,171,1125,1038,1024,1,59,1070,1103,138,1199,1055,0,107,1077,1038,1057,249,36,1270,1124,136]

theorem envBound4124 : H12AffineFastState.Bounded env4124 := by
  intro p hp
  have h : env4124.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4123_4124 : H12AffineEnvironment.transform 11 58 env4123 = env4124 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 58 env4123 == env4124) = true)

theorem identity4124 : scanCanonicalize (H12AffineFastState.compose env4124 (packedSelected [0,4] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound4124 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env4125 : List Nat := [2,4,8,16,0,64,128,5,137,1024,1,26,1030,75,1,139,1093,1038,1024,1,27,1038,1103,138,1167,1055,0,75,1045,1038,1025,217,4,1238,1092,136]

theorem envBound4125 : H12AffineFastState.Bounded env4125 := by
  intro p hp
  have h : env4125.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4124_4125 : H12AffineEnvironment.transform 4 0 env4124 = env4125 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4124 == env4125) = true)

theorem identity4125 : scanCanonicalize (H12AffineFastState.compose env4125 (packedSelected [12] rootPS)) = affineNative (2^(9+1) ^^^ 15) := by decide +kernel

theorem selectedBound4125 : packedSelected [12] rootPS < 2^1333 := by decide +kernel

def env4126 : List Nat := [2,4,8,16,0,64,128,5,137,15,1,26,9,75,1,139,74,1,15,1,27,1,64,138,128,16,0,75,26,1,14,217,4,217,75,136]

theorem envBound4126 : H12AffineFastState.Bounded env4126 := by
  intro p hp
  have h : env4126.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4125_4126 : H12AffineEnvironment.transform 9 15 env4125 = env4126 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 15 env4125 == env4126) = true)

def leafEnv4126 : List Nat := [2,4,8,16,0,64,128,5,137,15,1,26,9,75,1,139,74,1,15,1,27,1,64,138,15,128,1,16,0,75,26,1,14,217,4,217,4,2,75,136,0,26,1]

def active4126 : List Nat := [0,1,2,3,5,6]

def tree4126 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4126 : H12WitnessSearch.Good tree4126 := H12GlobalWitnessIndex.good

theorem leafIdentity4126 : H12AffineFastState.composeSystem env4126 rootObs = leafEnv4126 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4126 rootObs == leafEnv4126) = true)

theorem terminalChecked4126 : H12PackedTerminal.terminalCheckFast leafEnv4126 active4126 tree4126 = true := by decide +kernel

def env4127 : List Nat := [2,4,8,16,32,64,128,37,137,1024,1,4096,5148,4177,1,171,1125,262144,1025,1,4097,5140,5237,267454,5269,262161,267316,263269,266241,5172,1057,4294967296,267280,4294972468,1124,136]

theorem envBound4127 : H12AffineFastState.Bounded env4127 := by
  intro p hp
  have h : env4127.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4120_4127 : H12AffineEnvironment.transform 18 1025 env4120 = env4127 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env4120 == env4127) = true)

def env4128 : List Nat := [2,4,8,16,32,64,128,37,137,1024,1,4096,5148,4177,1,171,1125,5172,1025,1,4097,5140,5237,138,5269,5157,0,4177,1077,5172,1057,4294967296,36,4294972468,1124,136]

theorem envBound4128 : H12AffineFastState.Bounded env4128 := by
  intro p hp
  have h : env4128.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4127_4128 : H12AffineEnvironment.transform 17 5172 env4127 = env4128 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 5172 env4127 == env4128) = true)

theorem identity4128 : scanCanonicalize (H12AffineFastState.compose env4128 (packedSelected [1,3] rootPS)) = affineNative (2^(31+1) ^^^ 113) := by decide +kernel

theorem selectedBound4128 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env4129 : List Nat := [2,4,8,16,32,64,128,37,137,1024,1,4096,5148,4177,1,171,1125,5172,1025,1,4097,5140,5237,138,5269,5157,0,4177,1077,5172,1057,113,36,5189,1124,136]

theorem envBound4129 : H12AffineFastState.Bounded env4129 := by
  intro p hp
  have h : env4129.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4128_4129 : H12AffineEnvironment.transform 31 113 env4128 = env4129 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 113 env4128 == env4129) = true)

theorem identity4129 : scanCanonicalize (H12AffineFastState.compose env4129 (packedSelected [2] rootPS)) = affineNative (2^(11+1) ^^^ 1181) := by decide +kernel

theorem selectedBound4129 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4130 : List Nat := [2,4,8,16,32,64,128,37,137,1024,1,1181,129,1228,1,171,1125,169,1025,1,1180,137,232,138,8,184,0,1228,1077,169,1057,113,36,216,1124,136]

theorem envBound4130 : H12AffineFastState.Bounded env4130 := by
  intro p hp
  have h : env4130.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4129_4130 : H12AffineEnvironment.transform 11 1181 env4129 = env4130 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1181 env4129 == env4130) = true)

theorem identity4130 : scanCanonicalize (H12AffineFastState.compose env4130 (packedSelected [4] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound4130 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env4131 : List Nat := [2,4,8,16,0,64,128,5,137,1024,1,1181,129,1228,1,139,1093,137,1025,1,1180,137,200,138,8,152,0,1228,1045,137,1025,81,4,216,1092,136]

theorem envBound4131 : H12AffineFastState.Bounded env4131 := by
  intro p hp
  have h : env4131.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4130_4131 : H12AffineEnvironment.transform 4 0 env4130 = env4131 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4130 == env4131) = true)

theorem identity4131 : scanCanonicalize (H12AffineFastState.compose env4131 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 15) := by decide +kernel

theorem selectedBound4131 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4132 : List Nat := [2,4,8,16,0,64,128,5,137,15,1,146,129,195,1,139,74,137,14,1,147,137,200,138,8,152,0,195,26,137,14,81,4,216,75,136]

theorem envBound4132 : H12AffineFastState.Bounded env4132 := by
  intro p hp
  have h : env4132.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4131_4132 : H12AffineEnvironment.transform 9 15 env4131 = env4132 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 15 env4131 == env4132) = true)

theorem identity4132 : scanCanonicalize (H12AffineFastState.compose env4132 (packedSelected [5] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound4132 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env4133 : List Nat := [2,4,8,16,0,64,8,5,1,15,1,26,9,75,1,3,74,1,14,1,27,1,64,2,8,16,0,75,26,1,14,81,4,80,75,0]

theorem envBound4133 : H12AffineFastState.Bounded env4133 := by
  intro p hp
  have h : env4133.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4132_4133 : H12AffineEnvironment.transform 6 8 env4132 = env4133 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env4132 == env4133) = true)

def leafEnv4133 : List Nat := [2,4,8,16,0,64,8,5,1,15,1,26,9,75,1,3,74,1,14,1,27,1,64,2,14,8,1,16,0,75,26,1,14,81,4,80,4,2,75,0,0,26,1]

def active4133 : List Nat := [0,1,2,3,5]

def tree4133 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4133 : H12WitnessSearch.Good tree4133 := H12GlobalWitnessIndex.good

theorem leafIdentity4133 : H12AffineFastState.composeSystem env4133 rootObs = leafEnv4133 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4133 rootObs == leafEnv4133) = true)

theorem terminalChecked4133 : H12PackedTerminal.terminalCheckFast leafEnv4133 active4133 tree4133 = true := by decide +kernel

def env4134 : List Nat := [2,4,8,16,32,64,128,37,137,1024,1,4096,5148,4177,1,171,1125,5173,1025,1,4097,5140,5237,139,5269,5156,1,4176,1076,5172,1057,4294967296,37,4294972468,1124,136]

theorem envBound4134 : H12AffineFastState.Bounded env4134 := by
  intro p hp
  have h : env4134.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4127_4134 : H12AffineEnvironment.transform 17 5173 env4127 = env4134 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 5173 env4127 == env4134) = true)

def env4135 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,1345,262144,524288,32768,4097,8201,5456,16777216,8329,16880644,270605,16879957,16876565,1073741824,1285,4294967296,16875525,4295599526,1344,513]

theorem envBound4135 : H12AffineFastState.Bounded env4135 := by
  intro p hp
  have h : env4135.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4072_4135 : H12AffineEnvironment.transform 16 1345 env4072 = env4135 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env4072 == env4135) = true)

theorem identity4135 : scanCanonicalize (H12AffineFastState.compose env4135 (packedSelected [4,9,16] rootPS)) = affineNative (2^(29+1) ^^^ 17313158) := by decide +kernel

theorem selectedBound4135 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env4136 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,1345,262144,524288,32768,4097,8201,5456,16777216,8329,16880644,270605,16879957,16876565,17313158,1285,4294967296,16875525,4295599526,1344,513]

theorem envBound4136 : H12AffineFastState.Bounded env4136 := by
  intro p hp
  have h : env4136.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4135_4136 : H12AffineEnvironment.transform 29 17313158 env4135 = env4136 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 17313158 env4135 == env4136) = true)

def env4137 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,1345,262144,524288,32768,4097,8201,5456,16777216,8329,16880644,270605,16879957,16876565,17311110,1285,4294967296,16875525,4295599526,1344,513]

theorem envBound4137 : H12AffineFastState.Bounded env4137 := by
  intro p hp
  have h : env4137.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4136_4137 : H12AffineEnvironment.transform 10 0 env4136 = env4137 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env4136 == env4137) = true)

theorem identity4137 : scanCanonicalize (H12AffineFastState.compose env4137 (packedSelected [11] rootPS)) = affineNative (2^(18+1) ^^^ 78399) := by decide +kernel

theorem selectedBound4137 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env4138 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,1345,262144,78399,32768,4097,8201,5456,16777216,8329,16880644,270605,16879957,16876565,16848825,1285,4294967296,16875525,4295006105,1344,513]

theorem envBound4138 : H12AffineFastState.Bounded env4138 := by
  intro p hp
  have h : env4138.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4137_4138 : H12AffineEnvironment.transform 18 78399 env4137 = env4138 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 78399 env4137 == env4138) = true)

def env4139 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,1345,0,78399,32768,4097,8201,5456,16777216,8329,16880644,8461,16879957,16876565,16848825,1285,4294967296,16875525,4295006105,1344,513]

theorem envBound4139 : H12AffineFastState.Bounded env4139 := by
  intro p hp
  have h : env4139.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4138_4139 : H12AffineEnvironment.transform 17 0 env4138 = env4139 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env4138 == env4139) = true)

theorem identity4139 : scanCanonicalize (H12AffineFastState.compose env4139 (packedSelected [0,7] rootPS)) = affineNative (2^(23+1) ^^^ 103444) := by decide +kernel

theorem selectedBound4139 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env4140 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,1345,0,78399,32768,4097,8201,5456,103444,8329,16,8461,1345,4097,33709,1285,4294967296,5137,4295006105,1344,513]

theorem envBound4140 : H12AffineFastState.Bounded env4140 := by
  intro p hp
  have h : env4140.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4139_4140 : H12AffineEnvironment.transform 23 103444 env4139 = env4140 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 103444 env4139 == env4140) = true)

theorem identity4140 : scanCanonicalize (H12AffineFastState.compose env4140 (packedSelected [20] rootPS)) = affineNative (2^(8+1) ^^^ 136) := by decide +kernel

theorem selectedBound4140 : packedSelected [20] rootPS < 2^1333 := by decide +kernel

def env4141 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,8192,4177,32768,65536,1345,0,78007,32768,4097,8201,5456,103444,8329,16,8461,1345,4097,33061,1285,4294967296,5137,4295005457,1344,137]

theorem envBound4141 : H12AffineFastState.Bounded env4141 := by
  intro p hp
  have h : env4141.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4140_4141 : H12AffineEnvironment.transform 8 136 env4140 = env4141 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env4140 == env4141) = true)

theorem identity4141 : scanCanonicalize (H12AffineFastState.compose env4141 (packedSelected [0,1,2,5,6,15,18,21,22] rootPS)) = affineNative (2^(14+1) ^^^ 13624) := by decide +kernel

theorem selectedBound4141 : packedSelected [0,1,2,5,6,15,18,21,22] rootPS < 2^1333 := by decide +kernel

def env4142 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,4096,8192,4177,13624,65536,1345,0,78007,13624,4097,8201,5456,74028,8329,16,8461,1345,4097,13341,1285,4294967296,5137,4294975529,1344,137]

theorem envBound4142 : H12AffineFastState.Bounded env4142 := by
  intro p hp
  have h : env4142.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4141_4142 : H12AffineEnvironment.transform 14 13624 env4141 = env4142 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 13624 env4141 == env4142) = true)

theorem identity4142 : scanCanonicalize (H12AffineFastState.compose env4142 (packedSelected [0,1,2,3,4,6,10,13,15,18] rootPS)) = affineNative (2^(11+1) ^^^ 1297) := by decide +kernel

theorem selectedBound4142 : packedSelected [0,1,2,3,4,6,10,13,15,18] rootPS < 2^1333 := by decide +kernel

def env4143 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,1297,8192,1344,8233,65536,1345,0,75174,8233,1296,8201,65,74028,8329,16,8461,1345,1296,8460,1285,4294967296,256,4294975529,1344,137]

theorem envBound4143 : H12AffineFastState.Bounded env4143 := by
  intro p hp
  have h : env4143.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4142_4143 : H12AffineEnvironment.transform 11 1297 env4142 = env4143 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env4142 == env4143) = true)

theorem identity4143 : scanCanonicalize (H12AffineFastState.compose env4143 (packedSelected [1,2,3,4,5,10,13] rootPS)) = affineNative (2^(12+1) ^^^ 268) := by decide +kernel

theorem selectedBound4143 : packedSelected [1,2,3,4,5,10,13] rootPS < 2^1333 := by decide +kernel

def env4144 : List Nat := [2,4,8,16,32,64,128,256,136,1024,0,1297,268,1344,293,65536,1345,0,66730,293,1296,261,65,65568,389,16,1,1345,1296,0,1285,4294967296,256,4294967589,1344,137]

theorem envBound4144 : H12AffineFastState.Bounded env4144 := by
  intro p hp
  have h : env4144.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4143_4144 : H12AffineEnvironment.transform 12 268 env4143 = env4144 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 268 env4143 == env4144) = true)

def env4145 : List Nat := [2,4,8,16,32,64,128,36,136,1024,0,1077,40,1124,1,65536,1125,0,66730,1,1076,33,65,65568,161,16,1,1125,1076,0,1057,4294967296,36,4294967297,1124,137]

theorem envBound4145 : H12AffineFastState.Bounded env4145 := by
  intro p hp
  have h : env4145.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4144_4145 : H12AffineEnvironment.transform 7 36 env4144 = env4145 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 36 env4144 == env4145) = true)

theorem identity4145 : scanCanonicalize (H12AffineFastState.compose env4145 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 163) := by decide +kernel

theorem selectedBound4145 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4146 : List Nat := [2,4,8,16,32,64,128,36,136,1024,0,1077,40,1124,1,65536,1125,0,66730,1,1076,33,65,65568,161,16,1,1125,1076,0,1057,163,36,162,1124,137]

theorem envBound4146 : H12AffineFastState.Bounded env4146 := by
  intro p hp
  have h : env4146.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4145_4146 : H12AffineEnvironment.transform 31 163 env4145 = env4146 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 163 env4145 == env4146) = true)

theorem identity4146 : scanCanonicalize (H12AffineFastState.compose env4146 (packedSelected [1,3,4] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound4146 : packedSelected [1,3,4] rootPS < 2^1333 := by decide +kernel

def env4147 : List Nat := [2,4,8,0,32,64,128,36,136,1024,0,1061,40,1124,1,65536,1125,0,66730,1,1060,33,65,65568,161,0,1,1125,1060,0,1057,163,36,162,1124,137]

theorem envBound4147 : H12AffineFastState.Bounded env4147 := by
  intro p hp
  have h : env4147.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4146_4147 : H12AffineEnvironment.transform 3 0 env4146 = env4147 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env4146 == env4147) = true)

def env4148 : List Nat := [2,4,8,0,32,64,128,36,136,1024,0,1061,40,1124,1,192,1125,0,1130,1,1060,33,65,224,161,0,1,1125,1060,0,1057,163,36,162,1124,137]

theorem envBound4148 : H12AffineFastState.Bounded env4148 := by
  intro p hp
  have h : env4148.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4147_4148 : H12AffineEnvironment.transform 15 192 env4147 = env4148 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 192 env4147 == env4148) = true)

theorem identity4148 : scanCanonicalize (H12AffineFastState.compose env4148 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 43) := by decide +kernel

theorem selectedBound4148 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env4149 : List Nat := [2,4,8,0,32,43,128,36,136,1024,0,1061,40,1039,1,171,1038,0,1025,1,1060,33,42,139,161,0,1,1038,1060,0,1057,163,36,162,1039,137]

theorem envBound4149 : H12AffineFastState.Bounded env4149 := by
  intro p hp
  have h : env4149.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4148_4149 : H12AffineEnvironment.transform 5 43 env4148 = env4149 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 43 env4148 == env4149) = true)

def leafEnv4149 : List Nat := [2,4,8,0,32,43,128,36,136,1024,0,1061,40,1039,1,171,1038,0,1025,1,1060,33,42,139,1056,161,1,0,1,1038,1060,0,1057,163,36,162,4,35,1039,137,0,1061,1]

def active4149 : List Nat := [0,1,2,4,6,9]

def tree4149 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4149 : H12WitnessSearch.Good tree4149 := H12GlobalWitnessIndex.good

theorem leafIdentity4149 : H12AffineFastState.composeSystem env4149 rootObs = leafEnv4149 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4149 rootObs == leafEnv4149) = true)

theorem terminalChecked4149 : H12PackedTerminal.terminalCheckFast leafEnv4149 active4149 tree4149 = true := by decide +kernel

def env4150 : List Nat := [2,4,8,0,32,64,128,36,136,1024,0,1061,40,1124,1,193,1125,0,1131,1,1060,33,65,225,161,0,1,1125,1060,0,1057,163,36,162,1124,137]

theorem envBound4150 : H12AffineFastState.Bounded env4150 := by
  intro p hp
  have h : env4150.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4147_4150 : H12AffineEnvironment.transform 15 193 env4147 = env4150 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 193 env4147 == env4150) = true)

def env4151 : List Nat := [2,4,8,0,32,64,104,36,96,1024,0,1061,40,1124,1,41,1125,0,1131,1,1060,33,65,9,73,0,1,1125,1060,0,1057,75,36,74,1124,97]

theorem envBound4151 : H12AffineFastState.Bounded env4151 := by
  intro p hp
  have h : env4151.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4150_4151 : H12AffineEnvironment.transform 6 104 env4150 = env4151 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 104 env4150 == env4151) = true)

theorem identity4151 : scanCanonicalize (H12AffineFastState.compose env4151 (packedSelected [2] rootPS)) = affineNative (2^(5+1) ^^^ 42) := by decide +kernel

theorem selectedBound4151 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env4152 : List Nat := [2,4,8,0,32,42,2,36,10,1024,0,1061,40,1038,1,41,1039,0,1025,1,1060,33,43,9,35,0,1,1039,1060,0,1057,33,36,32,1038,11]

theorem envBound4152 : H12AffineFastState.Bounded env4152 := by
  intro p hp
  have h : env4152.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4151_4152 : H12AffineEnvironment.transform 5 42 env4151 = env4152 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 42 env4151 == env4152) = true)

def leafEnv4152 : List Nat := [2,4,8,0,32,42,2,36,10,1024,0,1061,40,1038,1,41,1039,0,1025,1,1060,33,43,9,1056,35,1,0,1,1039,1060,0,1057,33,36,32,4,35,1038,11,0,1061,1]

def active4152 : List Nat := [0,1,2,4,9]

def tree4152 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4152 : H12WitnessSearch.Good tree4152 := H12GlobalWitnessIndex.good

theorem leafIdentity4152 : H12AffineFastState.composeSystem env4152 rootObs = leafEnv4152 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4152 rootObs == leafEnv4152) = true)

theorem terminalChecked4152 : H12PackedTerminal.terminalCheckFast leafEnv4152 active4152 tree4152 = true := by decide +kernel

def env4153 : List Nat := [2,4,8,0,32,64,105,36,97,1024,0,1061,40,1124,1,40,1125,0,1131,1,1060,33,65,8,72,0,1,1125,1060,0,1057,74,36,75,1124,96]

theorem envBound4153 : H12AffineFastState.Bounded env4153 := by
  intro p hp
  have h : env4153.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4150_4153 : H12AffineEnvironment.transform 6 105 env4150 = env4153 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 105 env4150 == env4153) = true)

def env4154 : List Nat := [2,4,8,0,0,64,73,4,65,1024,0,1029,8,1092,1,8,1093,0,1099,1,1028,1,65,8,72,0,1,1093,1028,0,1025,74,4,75,1092,64]

theorem envBound4154 : H12AffineFastState.Bounded env4154 := by
  intro p hp
  have h : env4154.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4153_4154 : H12AffineEnvironment.transform 4 0 env4153 = env4154 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env4153 == env4154) = true)

theorem identity4154 : scanCanonicalize (H12AffineFastState.compose env4154 (packedSelected [3] rootPS)) = affineNative (2^(5+1) ^^^ 10) := by decide +kernel

theorem selectedBound4154 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env4155 : List Nat := [2,4,8,0,0,10,3,4,11,1024,0,1029,8,1038,1,8,1039,0,1025,1,1028,1,11,8,2,0,1,1039,1028,0,1025,0,4,1,1038,10]

theorem envBound4155 : H12AffineFastState.Bounded env4155 := by
  intro p hp
  have h : env4155.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4154_4155 : H12AffineEnvironment.transform 5 10 env4154 = env4155 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 10 env4154 == env4155) = true)

def leafEnv4155 : List Nat := [2,4,8,0,0,10,3,4,11,1024,0,1029,8,1038,1,8,1039,0,1025,1,1028,1,11,8,1024,2,1,0,1,1039,1028,0,1025,0,4,1,4,3,1038,10,0,1029,1]

def active4155 : List Nat := [0,1,2,9]

def tree4155 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4155 : H12WitnessSearch.Good tree4155 := H12GlobalWitnessIndex.good

theorem leafIdentity4155 : H12AffineFastState.composeSystem env4155 rootObs = leafEnv4155 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4155 rootObs == leafEnv4155) = true)

theorem terminalChecked4155 : H12PackedTerminal.terminalCheckFast leafEnv4155 active4155 tree4155 = true := by decide +kernel

def env4156 : List Nat := [2,4,8,0,1,64,72,5,64,1024,0,1028,9,1093,1,9,1092,0,1098,1,1029,0,65,8,72,0,1,1092,1029,0,1024,74,5,75,1093,65]

theorem envBound4156 : H12AffineFastState.Bounded env4156 := by
  intro p hp
  have h : env4156.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4153_4156 : H12AffineEnvironment.transform 4 1 env4153 = env4156 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env4153 == env4156) = true)

def leafEnv4156 : List Nat := [2,4,8,0,1,64,72,5,64,1024,0,1028,9,1093,1,9,1092,0,1098,1,1029,0,65,8,1098,72,1,0,1,1092,1029,0,1024,74,5,75,4,2,1093,65,0,1028,1]

def active4156 : List Nat := [0,1,2,5,9]

def tree4156 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood4156 : H12WitnessSearch.Good tree4156 := H12GlobalWitnessIndex.good

theorem leafIdentity4156 : H12AffineFastState.composeSystem env4156 rootObs = leafEnv4156 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env4156 rootObs == leafEnv4156) = true)

theorem terminalChecked4156 : H12PackedTerminal.terminalCheckFast leafEnv4156 active4156 tree4156 = true := by decide +kernel

def env4157 : List Nat := [2,4,8,16,32,64,128,37,136,1024,0,1076,41,1125,0,65536,1124,0,66730,0,1077,32,65,65568,160,16,1,1124,1077,0,1056,4294967296,37,4294967296,1125,137]

theorem envBound4157 : H12AffineFastState.Bounded env4157 := by
  intro p hp
  have h : env4157.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4144_4157 : H12AffineEnvironment.transform 7 37 env4144 = env4157 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env4144 == env4157) = true)

theorem identity4157 : scanCanonicalize (H12AffineFastState.compose env4157 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 65664) := by decide +kernel

theorem selectedBound4157 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env4158 : List Nat := [2,4,8,16,32,64,128,37,136,1024,0,1076,41,1125,0,65536,1124,0,66730,0,1077,32,65,65568,160,16,1,1124,1077,0,1056,65664,37,65664,1125,137]

theorem envBound4158 : H12AffineFastState.Bounded env4158 := by
  intro p hp
  have h : env4158.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4157_4158 : H12AffineEnvironment.transform 31 65664 env4157 = env4158 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65664 env4157 == env4158) = true)

theorem identity4158 : scanCanonicalize (H12AffineFastState.compose env4158 (packedSelected [1,3,4] rootPS)) = affineNative (2^(15+1) ^^^ 176) := by decide +kernel

theorem selectedBound4158 : packedSelected [1,3,4] rootPS < 2^1333 := by decide +kernel

def env4159 : List Nat := [2,4,8,16,32,64,128,37,136,1024,0,1076,41,1125,0,176,1124,0,1050,0,1077,32,65,144,160,16,1,1124,1077,0,1056,48,37,48,1125,137]

theorem envBound4159 : H12AffineFastState.Bounded env4159 := by
  intro p hp
  have h : env4159.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans4158_4159 : H12AffineEnvironment.transform 15 176 env4158 = env4159 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 176 env4158 == env4159) = true)

end H12GlobalChart2
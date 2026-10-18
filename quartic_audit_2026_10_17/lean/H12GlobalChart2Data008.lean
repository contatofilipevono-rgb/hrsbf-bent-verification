import H12GlobalChart2Data007

namespace H12GlobalChart2

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem envTrans1925_1926 : H12AffineEnvironment.transform 21 41260 env1925 = env1926 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 41260 env1925 == env1926) = true)

theorem identity1926 : scanCanonicalize (H12AffineFastState.compose env1926 (packedSelected [1,3,8] rootPS)) = affineNative (2^(10+1) ^^^ 423) := by decide +kernel

theorem selectedBound1926 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env1927 : List Nat := [2,4,8,16,32,17,128,256,137,1024,423,1297,8192,1297,32768,9,1296,8201,1024,32768,1297,41260,17,33036,8329,16,32800,1297,1297,8201,1284,33958,257,42029,1297,136]

theorem envBound1927 : H12AffineFastState.Bounded env1927 := by
  intro p hp
  have h : env1927.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1926_1927 : H12AffineEnvironment.transform 10 423 env1926 = env1927 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 423 env1926 == env1927) = true)

theorem identity1927 : scanCanonicalize (H12AffineFastState.compose env1927 (packedSelected [3] rootPS)) = affineNative (2^(12+1) ^^^ 1063) := by decide +kernel

theorem selectedBound1927 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1928 : List Nat := [2,4,8,16,32,17,128,256,137,1024,423,1297,1063,1297,32768,9,1296,1070,1024,32768,1297,34059,17,33036,1198,16,32800,1297,1297,1070,1284,33958,257,32778,1297,136]

theorem envBound1928 : H12AffineFastState.Bounded env1928 := by
  intro p hp
  have h : env1928.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1927_1928 : H12AffineEnvironment.transform 12 1063 env1927 = env1928 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1063 env1927 == env1928) = true)

theorem identity1928 : scanCanonicalize (H12AffineFastState.compose env1928 (packedSelected [1,10] rootPS)) = affineNative (2^(14+1) ^^^ 1038) := by decide +kernel

theorem selectedBound1928 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env1929 : List Nat := [2,4,8,16,32,17,128,256,137,1024,423,1297,1063,1297,1038,9,1296,1070,1024,1038,1297,261,17,1282,1198,16,1070,1297,1297,1070,1284,168,257,1028,1297,136]

theorem envBound1929 : H12AffineFastState.Bounded env1929 := by
  intro p hp
  have h : env1929.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1928_1929 : H12AffineEnvironment.transform 14 1038 env1928 = env1929 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 1038 env1928 == env1929) = true)

theorem identity1929 : scanCanonicalize (H12AffineFastState.compose env1929 (packedSelected [6,7] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1929 : packedSelected [6,7] rootPS < 2^1333 := by decide +kernel

def env1930 : List Nat := [2,4,8,16,32,17,128,5,137,1024,162,1044,1063,1044,1038,9,1045,1070,1024,1038,1044,0,17,1031,1198,16,1070,1044,1044,1070,1025,168,4,1028,1044,136]

theorem envBound1930 : H12AffineFastState.Bounded env1930 := by
  intro p hp
  have h : env1930.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1929_1930 : H12AffineEnvironment.transform 7 5 env1929 = env1930 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1929 == env1930) = true)

theorem identity1930 : scanCanonicalize (H12AffineFastState.compose env1930 (packedSelected [2,4] rootPS)) = affineNative (2^(9+1) ^^^ 141) := by decide +kernel

theorem selectedBound1930 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env1931 : List Nat := [2,4,8,16,32,17,128,5,137,141,162,153,170,153,131,9,152,163,141,131,153,0,17,138,35,16,163,153,153,163,140,168,4,137,153,136]

theorem envBound1931 : H12AffineFastState.Bounded env1931 := by
  intro p hp
  have h : env1931.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1930_1931 : H12AffineEnvironment.transform 9 141 env1930 = env1931 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 141 env1930 == env1931) = true)

def env1932 : List Nat := [2,4,8,16,0,17,128,5,137,141,130,153,138,153,131,9,152,131,141,131,153,0,17,138,3,16,131,153,153,131,140,136,4,137,153,136]

theorem envBound1932 : H12AffineFastState.Bounded env1932 := by
  intro p hp
  have h : env1932.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1931_1932 : H12AffineEnvironment.transform 4 0 env1931 = env1932 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1931 == env1932) = true)

theorem identity1932 : scanCanonicalize (H12AffineFastState.compose env1932 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound1932 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1933 : List Nat := [2,4,8,16,0,17,9,5,0,4,11,16,3,16,10,9,17,10,4,10,16,0,17,3,3,16,10,16,16,10,5,1,4,0,16,1]

theorem envBound1933 : H12AffineFastState.Bounded env1933 := by
  intro p hp
  have h : env1933.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1932_1933 : H12AffineEnvironment.transform 6 9 env1932 = env1933 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env1932 == env1933) = true)

def leafEnv1933 : List Nat := [2,4,8,16,0,17,9,5,0,4,11,16,3,16,10,9,17,10,4,10,16,0,17,3,4,3,1,16,10,16,16,10,5,1,4,0,4,9,16,1,0,17,1]

def active1933 : List Nat := [0,1,2,3]

def tree1933 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1933 : H12WitnessSearch.Good tree1933 := H12GlobalWitnessIndex.good

theorem leafIdentity1933 : H12AffineFastState.composeSystem env1933 rootObs = leafEnv1933 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1933 rootObs == leafEnv1933) = true)

theorem terminalChecked1933 : H12PackedTerminal.terminalCheckFast leafEnv1933 active1933 tree1933 = true := by decide +kernel

def env1934 : List Nat := [2,4,8,16,1,17,128,5,137,141,131,153,139,153,131,9,152,130,141,131,153,0,17,138,2,16,130,153,153,130,140,137,4,137,153,136]

theorem envBound1934 : H12AffineFastState.Bounded env1934 := by
  intro p hp
  have h : env1934.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1931_1934 : H12AffineEnvironment.transform 4 1 env1931 = env1934 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env1931 == env1934) = true)

def leafEnv1934 : List Nat := [2,4,8,16,1,17,128,5,137,141,131,153,139,153,131,9,152,130,141,131,153,0,17,138,141,2,1,16,130,153,153,130,140,137,4,137,4,128,153,136,0,152,1]

def active1934 : List Nat := [0,1,2,3,6]

def tree1934 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1934 : H12WitnessSearch.Good tree1934 := H12GlobalWitnessIndex.good

theorem leafIdentity1934 : H12AffineFastState.composeSystem env1934 rootObs = leafEnv1934 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1934 rootObs == leafEnv1934) = true)

theorem terminalChecked1934 : H12PackedTerminal.terminalCheckFast leafEnv1934 active1934 tree1934 = true := by decide +kernel

def env1935 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,8192,1297,32768,65536,1945,73729,1673,32768,1944,4194304,17,98565,8704,16,4268292,1297,1297,4295170,1933,99879,904,4196233,1944,136]

theorem envBound1935 : H12AffineFastState.Bounded env1935 := by
  intro p hp
  have h : env1935.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1913_1935 : H12AffineEnvironment.transform 17 73729 env1913 = env1935 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 73729 env1913 == env1935) = true)

theorem identity1935 : scanCanonicalize (H12AffineFastState.compose env1935 (packedSelected [1,3,4,8,9,12,15,16,17] rootPS)) = affineNative (2^(15+1) ^^^ 8) := by decide +kernel

theorem selectedBound1935 : packedSelected [1,3,4,8,9,12,15,16,17] rootPS < 2^1333 := by decide +kernel

def env1936 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1297,8192,1297,32768,8,1945,8201,1673,32768,1944,4194304,17,33037,8704,16,4202764,1297,1297,4229642,1933,34351,904,4196233,1944,136]

theorem envBound1936 : H12AffineFastState.Bounded env1936 := by
  intro p hp
  have h : env1936.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1935_1936 : H12AffineEnvironment.transform 15 8 env1935 = env1936 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8 env1935 == env1936) = true)

def env1937 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,8192,1297,32768,8,1297,8201,1025,32768,1296,4194304,17,33037,8328,16,4202764,1297,1297,4229250,1285,33959,256,4195585,1296,136]

theorem envBound1937 : H12AffineFastState.Bounded env1937 := by
  intro p hp
  have h : env1937.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1936_1937 : H12AffineEnvironment.transform 8 136 env1936 = env1937 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 136 env1936 == env1937) = true)

theorem identity1937 : scanCanonicalize (H12AffineFastState.compose env1937 (packedSelected [1,3,5] rootPS)) = affineNative (2^(21+1) ^^^ 10400) := by decide +kernel

theorem selectedBound1937 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1938 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,8192,1297,32768,8,1297,8201,1025,32768,1296,10400,17,33037,8328,16,2476,1297,1297,40994,1285,33959,256,11681,1296,136]

theorem envBound1938 : H12AffineFastState.Bounded env1938 := by
  intro p hp
  have h : env1938.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1937_1938 : H12AffineEnvironment.transform 21 10400 env1937 = env1938 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10400 env1937 == env1938) = true)

theorem identity1938 : scanCanonicalize (H12AffineFastState.compose env1938 (packedSelected [1,3,8] rootPS)) = affineNative (2^(14+1) ^^^ 10410) := by decide +kernel

theorem selectedBound1938 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env1939 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,8192,1297,10410,8,1297,8201,1025,10410,1296,10400,17,10663,8328,16,2476,1297,1297,2184,1285,11277,256,11681,1296,136]

theorem envBound1939 : H12AffineFastState.Bounded env1939 := by
  intro p hp
  have h : env1939.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1938_1939 : H12AffineEnvironment.transform 14 10410 env1938 = env1939 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 10410 env1938 == env1939) = true)

theorem identity1939 : scanCanonicalize (H12AffineFastState.compose env1939 (packedSelected [1,10] rootPS)) = affineNative (2^(12+1) ^^^ 2469) := by decide +kernel

theorem selectedBound1939 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env1940 : List Nat := [2,4,8,16,32,17,128,256,136,1024,2048,1297,2469,1297,271,8,1297,2476,1025,271,1296,261,17,2,2349,16,2476,1297,1297,2184,1285,1448,256,1028,1296,136]

theorem envBound1940 : H12AffineFastState.Bounded env1940 := by
  intro p hp
  have h : env1940.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1939_1940 : H12AffineEnvironment.transform 12 2469 env1939 = env1940 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2469 env1939 == env1940) = true)

theorem identity1940 : scanCanonicalize (H12AffineFastState.compose env1940 (packedSelected [6,7] rootPS)) = affineNative (2^(7+1) ^^^ 7) := by decide +kernel

theorem selectedBound1940 : packedSelected [6,7] rootPS < 2^1333 := by decide +kernel

def env1941 : List Nat := [2,4,8,16,32,17,128,7,136,1024,2048,1046,2210,1046,8,8,1046,2219,1025,8,1047,2,17,2,2090,16,2219,1046,1046,2184,1026,1199,7,1028,1047,136]

theorem envBound1941 : H12AffineFastState.Bounded env1941 := by
  intro p hp
  have h : env1941.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1940_1941 : H12AffineEnvironment.transform 7 7 env1940 = env1941 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 7 env1940 == env1941) = true)

theorem identity1941 : scanCanonicalize (H12AffineFastState.compose env1941 (packedSelected [3,12] rootPS)) = affineNative (2^(10+1) ^^^ 161) := by decide +kernel

theorem selectedBound1941 : packedSelected [3,12] rootPS < 2^1333 := by decide +kernel

def env1942 : List Nat := [2,4,8,16,32,17,128,7,136,1024,161,1046,3,1046,8,8,1046,10,1025,8,1047,2,17,2,139,16,10,1046,1046,41,1026,1199,7,1028,1047,136]

theorem envBound1942 : H12AffineFastState.Bounded env1942 := by
  intro p hp
  have h : env1942.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1941_1942 : H12AffineEnvironment.transform 10 161 env1941 = env1942 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 161 env1941 == env1942) = true)

theorem identity1942 : scanCanonicalize (H12AffineFastState.compose env1942 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound1942 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1943 : List Nat := [2,4,8,16,32,17,8,7,0,1024,41,1046,3,1046,8,8,1046,10,1025,8,1047,2,17,2,3,16,10,1046,1046,41,1026,1063,7,1028,1047,0]

theorem envBound1943 : H12AffineFastState.Bounded env1943 := by
  intro p hp
  have h : env1943.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1942_1943 : H12AffineEnvironment.transform 6 8 env1942 = env1943 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env1942 == env1943) = true)

theorem identity1943 : scanCanonicalize (H12AffineFastState.compose env1943 (packedSelected [0] rootPS)) = affineNative (2^(9+1) ^^^ 5) := by decide +kernel

theorem selectedBound1943 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1944 : List Nat := [2,4,8,16,32,17,8,7,0,5,41,19,3,19,8,8,19,10,4,8,18,2,17,2,3,16,10,19,19,41,7,34,7,1,18,0]

theorem envBound1944 : H12AffineFastState.Bounded env1944 := by
  intro p hp
  have h : env1944.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1943_1944 : H12AffineEnvironment.transform 9 5 env1943 = env1944 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 5 env1943 == env1944) = true)

theorem identity1944 : scanCanonicalize (H12AffineFastState.compose env1944 (packedSelected [1] rootPS)) = affineNative (2^(4+1) ^^^ 2) := by decide +kernel

theorem selectedBound1944 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1945 : List Nat := [2,4,8,16,2,17,8,7,0,5,11,19,3,19,8,8,19,10,4,8,18,2,17,2,3,16,10,19,19,11,7,0,7,1,18,0]

theorem envBound1945 : H12AffineFastState.Bounded env1945 := by
  intro p hp
  have h : env1945.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1944_1945 : H12AffineEnvironment.transform 4 2 env1944 = env1945 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 2 env1944 == env1945) = true)

def env1946 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8192,1297,32768,8,1296,8201,1024,32768,1297,4194304,17,33037,8329,16,4202764,1297,1297,4229251,1284,33958,257,4195584,1297,136]

theorem envBound1946 : H12AffineFastState.Bounded env1946 := by
  intro p hp
  have h : env1946.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1936_1946 : H12AffineEnvironment.transform 8 137 env1936 = env1946 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1936 == env1946) = true)

theorem identity1946 : scanCanonicalize (H12AffineFastState.compose env1946 (packedSelected [1,3,5] rootPS)) = affineNative (2^(21+1) ^^^ 41260) := by decide +kernel

theorem selectedBound1946 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env1947 : List Nat := [2,4,8,16,32,17,128,256,137,1024,2048,1297,8192,1297,32768,8,1296,8201,1024,32768,1297,41260,17,33037,8329,16,32800,1297,1297,10671,1284,33958,257,42028,1297,136]

theorem envBound1947 : H12AffineFastState.Bounded env1947 := by
  intro p hp
  have h : env1947.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1946_1947 : H12AffineEnvironment.transform 21 41260 env1946 = env1947 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 41260 env1946 == env1947) = true)

theorem identity1947 : scanCanonicalize (H12AffineFastState.compose env1947 (packedSelected [1,3,8] rootPS)) = affineNative (2^(10+1) ^^^ 422) := by decide +kernel

theorem selectedBound1947 : packedSelected [1,3,8] rootPS < 2^1333 := by decide +kernel

def env1948 : List Nat := [2,4,8,16,32,17,128,256,137,1024,422,1297,8192,1297,32768,8,1296,8201,1024,32768,1297,41260,17,33037,8329,16,32800,1297,1297,8201,1284,33958,257,42028,1297,136]

theorem envBound1948 : H12AffineFastState.Bounded env1948 := by
  intro p hp
  have h : env1948.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1947_1948 : H12AffineEnvironment.transform 10 422 env1947 = env1948 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 422 env1947 == env1948) = true)

theorem identity1948 : scanCanonicalize (H12AffineFastState.compose env1948 (packedSelected [3] rootPS)) = affineNative (2^(12+1) ^^^ 1063) := by decide +kernel

theorem selectedBound1948 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1949 : List Nat := [2,4,8,16,32,17,128,256,137,1024,422,1297,1063,1297,32768,8,1296,1070,1024,32768,1297,34059,17,33037,1198,16,32800,1297,1297,1070,1284,33958,257,32779,1297,136]

theorem envBound1949 : H12AffineFastState.Bounded env1949 := by
  intro p hp
  have h : env1949.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1948_1949 : H12AffineEnvironment.transform 12 1063 env1948 = env1949 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1063 env1948 == env1949) = true)

theorem identity1949 : scanCanonicalize (H12AffineFastState.compose env1949 (packedSelected [1,10] rootPS)) = affineNative (2^(14+1) ^^^ 1038) := by decide +kernel

theorem selectedBound1949 : packedSelected [1,10] rootPS < 2^1333 := by decide +kernel

def env1950 : List Nat := [2,4,8,16,32,17,128,256,137,1024,422,1297,1063,1297,1038,8,1296,1070,1024,1038,1297,261,17,1283,1198,16,1070,1297,1297,1070,1284,168,257,1029,1297,136]

theorem envBound1950 : H12AffineFastState.Bounded env1950 := by
  intro p hp
  have h : env1950.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1949_1950 : H12AffineEnvironment.transform 14 1038 env1949 = env1950 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 1038 env1949 == env1950) = true)

theorem identity1950 : scanCanonicalize (H12AffineFastState.compose env1950 (packedSelected [6,7] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound1950 : packedSelected [6,7] rootPS < 2^1333 := by decide +kernel

def env1951 : List Nat := [2,4,8,16,32,17,128,5,137,1024,163,1044,1063,1044,1038,8,1045,1070,1024,1038,1044,0,17,1030,1198,16,1070,1044,1044,1070,1025,168,4,1029,1044,136]

theorem envBound1951 : H12AffineFastState.Bounded env1951 := by
  intro p hp
  have h : env1951.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1950_1951 : H12AffineEnvironment.transform 7 5 env1950 = env1951 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env1950 == env1951) = true)

theorem identity1951 : scanCanonicalize (H12AffineFastState.compose env1951 (packedSelected [2,4] rootPS)) = affineNative (2^(9+1) ^^^ 140) := by decide +kernel

theorem selectedBound1951 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env1952 : List Nat := [2,4,8,16,32,17,128,5,137,140,163,152,171,152,130,8,153,162,140,130,152,0,17,138,34,16,162,152,152,162,141,168,4,137,152,136]

theorem envBound1952 : H12AffineFastState.Bounded env1952 := by
  intro p hp
  have h : env1952.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1951_1952 : H12AffineEnvironment.transform 9 140 env1951 = env1952 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 140 env1951 == env1952) = true)

def env1953 : List Nat := [2,4,8,16,0,17,128,5,137,140,131,152,139,152,130,8,153,130,140,130,152,0,17,138,2,16,130,152,152,130,141,136,4,137,152,136]

theorem envBound1953 : H12AffineFastState.Bounded env1953 := by
  intro p hp
  have h : env1953.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1952_1953 : H12AffineEnvironment.transform 4 0 env1952 = env1953 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1952 == env1953) = true)

theorem identity1953 : scanCanonicalize (H12AffineFastState.compose env1953 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound1953 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1954 : List Nat := [2,4,8,16,0,17,9,5,0,5,10,17,2,17,11,8,16,11,5,11,17,0,17,3,2,16,11,17,17,11,4,1,4,0,17,1]

theorem envBound1954 : H12AffineFastState.Bounded env1954 := by
  intro p hp
  have h : env1954.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1953_1954 : H12AffineEnvironment.transform 6 9 env1953 = env1954 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env1953 == env1954) = true)

def leafEnv1954 : List Nat := [2,4,8,16,0,17,9,5,0,5,10,17,2,17,11,8,16,11,5,11,17,0,17,3,5,2,1,16,11,17,17,11,4,1,4,0,4,8,17,1,0,16,1]

def active1954 : List Nat := [0,1,2,3]

def tree1954 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1954 : H12WitnessSearch.Good tree1954 := H12GlobalWitnessIndex.good

theorem leafIdentity1954 : H12AffineFastState.composeSystem env1954 rootObs = leafEnv1954 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1954 rootObs == leafEnv1954) = true)

theorem terminalChecked1954 : H12PackedTerminal.terminalCheckFast leafEnv1954 active1954 tree1954 = true := by decide +kernel

def env1955 : List Nat := [2,4,8,16,1,17,128,5,137,140,130,152,138,152,130,8,153,131,140,130,152,0,17,138,3,16,131,152,152,131,141,137,4,137,152,136]

theorem envBound1955 : H12AffineFastState.Bounded env1955 := by
  intro p hp
  have h : env1955.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1952_1955 : H12AffineEnvironment.transform 4 1 env1952 = env1955 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env1952 == env1955) = true)

def leafEnv1955 : List Nat := [2,4,8,16,1,17,128,5,137,140,130,152,138,152,130,8,153,131,140,130,152,0,17,138,140,3,1,16,131,152,152,131,141,137,4,137,4,129,152,136,0,153,1]

def active1955 : List Nat := [0,1,2,3,6]

def tree1955 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1955 : H12WitnessSearch.Good tree1955 := H12GlobalWitnessIndex.good

theorem leafIdentity1955 : H12AffineFastState.composeSystem env1955 rootObs = leafEnv1955 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1955 rootObs == leafEnv1955) = true)

theorem terminalChecked1955 : H12PackedTerminal.terminalCheckFast leafEnv1955 active1955 tree1955 = true := by decide +kernel

def env1956 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,529409,4194304,17664,753733,33554432,5377,5132308,16384,656465,1073741824,131141,4294967296,525568,4332975158,131073,33563272]

theorem envBound1956 : H12AffineFastState.Bounded env1956 := by
  intro p hp
  have h : env1956.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1828_1956 : H12AffineEnvironment.transform 20 529409 env1828 = env1956 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 529409 env1828 == env1956) = true)

theorem identity1956 : scanCanonicalize (H12AffineFastState.compose env1956 (packedSelected [4,6,7,9,16,20,25,27] rootPS)) = affineNative (2^(29+1) ^^^ 4820106) := by decide +kernel

theorem selectedBound1956 : packedSelected [4,6,7,9,16,20,25,27] rootPS < 2^1333 := by decide +kernel

def env1957 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,529409,4194304,17664,753733,33554432,5377,5132308,16384,656465,4820106,131141,4294967296,525568,4332975158,131073,33563272]

theorem envBound1957 : H12AffineFastState.Bounded env1957 := by
  intro p hp
  have h : env1957.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1956_1957 : H12AffineEnvironment.transform 29 4820106 env1956 = env1957 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 4820106 env1956 == env1957) = true)

theorem identity1957 : scanCanonicalize (H12AffineFastState.compose env1957 (packedSelected [15,17,19,21,26,38] rootPS)) = affineNative (2^(13+1) ^^^ 4177) := by decide +kernel

theorem selectedBound1957 : packedSelected [15,17,19,21,26,38] rootPS < 2^1333 := by decide +kernel

def env1958 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,529409,4194304,5457,753733,33554432,5377,5111877,4177,656465,4820106,131141,4294967296,525568,4332954727,131073,33563272]

theorem envBound1958 : H12AffineFastState.Bounded env1958 := by
  intro p hp
  have h : env1958.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1957_1958 : H12AffineEnvironment.transform 13 4177 env1957 = env1958 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env1957 == env1958) = true)

def env1959 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,8192,1345,32768,65536,131072,262144,524288,32768,524561,4194304,65,753733,33554432,17,5111877,1345,656465,4820106,131141,4294967296,525568,4332954727,131073,33563272]

theorem envBound1959 : H12AffineFastState.Bounded env1959 := by
  intro p hp
  have h : env1959.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1958_1959 : H12AffineEnvironment.transform 11 1296 env1958 = env1959 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1296 env1958 == env1959) = true)

theorem identity1959 : scanCanonicalize (H12AffineFastState.compose env1959 (packedSelected [3,6,12,13,15,21,24,25] rootPS)) = affineNative (2^(24+1) ^^^ 461935) := by decide +kernel

theorem selectedBound1959 : packedSelected [3,6,12,13,15,21,24,25] rootPS < 2^1333 := by decide +kernel

def env1960 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,8192,1345,32768,65536,131072,262144,524288,32768,524561,4194304,65,753733,461935,17,5111877,1345,656465,4820106,131141,4294967296,525568,4299466760,131073,470759]

theorem envBound1960 : H12AffineFastState.Bounded env1960 := by
  intro p hp
  have h : env1960.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1959_1960 : H12AffineEnvironment.transform 24 461935 env1959 = env1960 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 461935 env1959 == env1960) = true)

theorem identity1960 : scanCanonicalize (H12AffineFastState.compose env1960 (packedSelected [3,11,12,13,15,16,18,20,21,23,24,32] rootPS)) = affineNative (2^(17+1) ^^^ 43048) := by decide +kernel

theorem selectedBound1960 : packedSelected [3,11,12,13,15,16,18,20,21,23,24,32] rootPS < 2^1333 := by decide +kernel

def env1961 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,8192,1345,32768,65536,131072,43048,524288,32768,524561,4194304,65,753733,238663,17,4892781,1345,656465,4820106,131141,4294967296,525568,4299161632,131073,231119]

theorem envBound1961 : H12AffineFastState.Bounded env1961 := by
  intro p hp
  have h : env1961.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1960_1961 : H12AffineEnvironment.transform 17 43048 env1960 = env1961 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43048 env1960 == env1961) = true)

theorem identity1961 : scanCanonicalize (H12AffineFastState.compose env1961 (packedSelected [1,3,5,8,10,11,18,19,20] rootPS)) = affineNative (2^(18+1) ^^^ 229583) := by decide +kernel

theorem selectedBound1961 : packedSelected [1,3,5,8,10,11,18,19,20] rootPS < 2^1333 := by decide +kernel

def env1962 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,8192,1345,32768,65536,131072,43048,229583,32768,229854,4194304,65,138,238663,17,4270242,1345,99486,4328517,131141,4294967296,230863,4299161632,131073,231119]

theorem envBound1962 : H12AffineFastState.Bounded env1962 := by
  intro p hp
  have h : env1962.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1961_1962 : H12AffineEnvironment.transform 18 229583 env1961 = env1962 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 229583 env1961 == env1962) = true)

theorem identity1962 : scanCanonicalize (H12AffineFastState.compose env1962 (packedSelected [10,12,13,15,21,26] rootPS)) = affineNative (2^(16+1) ^^^ 1345) := by decide +kernel

theorem selectedBound1962 : packedSelected [10,12,13,15,21,26] rootPS < 2^1333 := by decide +kernel

def env1963 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,8192,1345,32768,65536,1345,43048,99726,32768,99487,4194304,65,138,106758,17,4270242,1345,99486,4196612,1284,4294967296,98446,4299161632,1344,99214]

theorem envBound1963 : H12AffineFastState.Bounded env1963 := by
  intro p hp
  have h : env1963.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1962_1963 : H12AffineEnvironment.transform 16 1345 env1962 = env1963 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env1962 == env1963) = true)

def env1964 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,3204,1345,32768,65536,1345,33964,99726,32768,99487,4194304,65,138,101762,17,4260902,1345,99486,4196612,1284,4294967296,98446,4299161632,1344,99214]

theorem envBound1964 : H12AffineFastState.Bounded env1964 := by
  intro p hp
  have h : env1964.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1963_1964 : H12AffineEnvironment.transform 12 3204 env1963 = env1964 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 3204 env1963 == env1964) = true)

theorem identity1964 : scanCanonicalize (H12AffineFastState.compose env1964 (packedSelected [12] rootPS)) = affineNative (2^(31+1) ^^^ 36345) := by decide +kernel

theorem selectedBound1964 : packedSelected [12] rootPS < 2^1333 := by decide +kernel

def env1965 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,3204,1345,32768,65536,1345,33964,99726,32768,99487,4194304,65,138,101762,17,4260902,1345,99486,4196612,1284,36345,98446,4230617,1344,99214]

theorem envBound1965 : H12AffineFastState.Bounded env1965 := by
  intro p hp
  have h : env1965.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1964_1965 : H12AffineEnvironment.transform 31 36345 env1964 = env1965 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 36345 env1964 == env1965) = true)

theorem identity1965 : scanCanonicalize (H12AffineFastState.compose env1965 (packedSelected [1,4,5,9,10,16] rootPS)) = affineNative (2^(15+1) ^^^ 34082) := by decide +kernel

theorem selectedBound1965 : packedSelected [1,4,5,9,10,16] rootPS < 2^1333 := by decide +kernel

def env1966 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,3204,1345,32768,34082,1345,33964,172,32768,445,4194304,65,138,2208,17,4227332,1345,444,4196612,1284,36345,1452,4230617,1344,1708]

theorem envBound1966 : H12AffineFastState.Bounded env1966 := by
  intro p hp
  have h : env1966.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1965_1966 : H12AffineEnvironment.transform 15 34082 env1965 = env1966 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 34082 env1965 == env1966) = true)

theorem identity1966 : scanCanonicalize (H12AffineFastState.compose env1966 (packedSelected [1,8,10,13,15,21] rootPS)) = affineNative (2^(21+1) ^^^ 35980) := by decide +kernel

theorem selectedBound1966 : packedSelected [1,8,10,13,15,21] rootPS < 2^1333 := by decide +kernel

def env1967 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,3204,1345,32768,34082,1345,33964,172,32768,445,35980,65,138,2208,17,3464,1345,444,34184,1284,36345,1452,341,1344,1708]

theorem envBound1967 : H12AffineFastState.Bounded env1967 := by
  intro p hp
  have h : env1967.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1966_1967 : H12AffineEnvironment.transform 21 35980 env1966 = env1967 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 35980 env1966 == env1967) = true)

def env1968 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1296,3204,1297,32768,34082,1297,33964,172,32768,445,35980,17,138,2208,17,3464,1297,444,34184,1284,36265,1452,261,1296,1708]

theorem envBound1968 : H12AffineFastState.Bounded env1968 := by
  intro p hp
  have h : env1968.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1967_1968 : H12AffineEnvironment.transform 5 16 env1967 = env1968 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env1967 == env1968) = true)

theorem identity1968 : scanCanonicalize (H12AffineFastState.compose env1968 (packedSelected [0,4,7,8,9] rootPS)) = affineNative (2^(14+1) ^^^ 2989) := by decide +kernel

theorem selectedBound1968 : packedSelected [0,4,7,8,9] rootPS < 2^1333 := by decide +kernel

def env1969 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1296,3204,1297,2989,3727,1297,3841,172,2989,445,1825,17,138,2208,17,3464,1297,444,3621,1284,1540,1452,261,1296,1708]

theorem envBound1969 : H12AffineFastState.Bounded env1969 := by
  intro p hp
  have h : env1969.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1968_1969 : H12AffineEnvironment.transform 14 2989 env1968 = env1969 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2989 env1968 == env1969) = true)

theorem identity1969 : scanCanonicalize (H12AffineFastState.compose env1969 (packedSelected [1,5,13] rootPS)) = affineNative (2^(9+1) ^^^ 173) := by decide +kernel

theorem selectedBound1969 : packedSelected [1,5,13] rootPS < 2^1333 := by decide +kernel

def env1970 : List Nat := [2,4,8,16,32,16,128,256,512,173,2048,445,2089,444,2989,2594,444,2988,172,2989,445,908,17,138,2208,17,2341,444,444,2696,425,681,257,261,445,513]

theorem envBound1970 : H12AffineFastState.Bounded env1970 := by
  intro p hp
  have h : env1970.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1969_1970 : H12AffineEnvironment.transform 9 173 env1969 = env1970 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 173 env1969 == env1970) = true)

theorem identity1970 : scanCanonicalize (H12AffineFastState.compose env1970 (packedSelected [1] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound1970 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1971 : List Nat := [2,4,8,16,32,16,128,256,137,173,2048,445,2089,444,2340,2219,444,2341,172,2340,445,261,17,138,2208,17,2341,444,444,2049,425,32,257,261,445,136]

theorem envBound1971 : H12AffineFastState.Bounded env1971 := by
  intro p hp
  have h : env1971.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1970_1971 : H12AffineEnvironment.transform 8 137 env1970 = env1971 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1970 == env1971) = true)

theorem identity1971 : scanCanonicalize (H12AffineFastState.compose env1971 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 303) := by decide +kernel

theorem selectedBound1971 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1972 : List Nat := [2,4,8,16,32,16,128,256,137,173,303,445,262,444,11,388,444,10,172,11,445,261,17,138,399,17,10,444,444,302,425,32,257,261,445,136]

theorem envBound1972 : H12AffineFastState.Bounded env1972 := by
  intro p hp
  have h : env1972.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1971_1972 : H12AffineEnvironment.transform 10 303 env1971 = env1972 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 303 env1971 == env1972) = true)

theorem identity1972 : scanCanonicalize (H12AffineFastState.compose env1972 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 40) := by decide +kernel

theorem selectedBound1972 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1973 : List Nat := [2,4,8,16,32,16,40,256,33,5,303,277,262,276,11,300,276,10,4,11,277,261,17,34,295,17,10,276,276,302,257,32,257,261,277,32]

theorem envBound1973 : H12AffineFastState.Bounded env1973 := by
  intro p hp
  have h : env1973.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1972_1973 : H12AffineEnvironment.transform 6 40 env1972 = env1973 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 40 env1972 == env1973) = true)

theorem identity1973 : scanCanonicalize (H12AffineFastState.compose env1973 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound1973 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1974 : List Nat := [2,4,8,16,32,16,40,37,33,5,10,48,35,49,11,9,49,10,4,11,48,32,17,34,2,17,10,49,49,11,36,32,36,32,48,32]

theorem envBound1974 : H12AffineFastState.Bounded env1974 := by
  intro p hp
  have h : env1974.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1973_1974 : H12AffineEnvironment.transform 7 37 env1973 = env1974 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env1973 == env1974) = true)

theorem identity1974 : scanCanonicalize (H12AffineFastState.compose env1974 (packedSelected [4] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound1974 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env1975 : List Nat := [2,4,8,16,0,16,8,5,1,5,10,16,3,17,11,9,17,10,4,11,16,0,17,2,2,17,10,17,17,11,4,0,4,0,16,0]

theorem envBound1975 : H12AffineFastState.Bounded env1975 := by
  intro p hp
  have h : env1975.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1974_1975 : H12AffineEnvironment.transform 4 0 env1974 = env1975 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1974 == env1975) = true)

def leafEnv1975 : List Nat := [2,4,8,16,0,16,8,5,1,5,10,16,3,17,11,9,17,10,4,11,16,0,17,2,4,2,1,17,10,17,17,11,4,0,4,0,4,8,16,0,0,16,1]

def active1975 : List Nat := [0,1,2,3]

def tree1975 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1975 : H12WitnessSearch.Good tree1975 := H12GlobalWitnessIndex.good

theorem leafIdentity1975 : H12AffineFastState.composeSystem env1975 rootObs = leafEnv1975 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1975 rootObs == leafEnv1975) = true)

theorem terminalChecked1975 : H12PackedTerminal.terminalCheckFast leafEnv1975 active1975 tree1975 = true := by decide +kernel

def env1976 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,3204,1296,32768,34082,1296,33964,172,32768,445,35980,16,138,2208,17,3464,1296,444,34184,1284,36264,1452,260,1297,1708]

theorem envBound1976 : H12AffineFastState.Bounded env1976 := by
  intro p hp
  have h : env1976.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1967_1976 : H12AffineEnvironment.transform 5 17 env1967 = env1976 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env1967 == env1976) = true)

theorem identity1976 : scanCanonicalize (H12AffineFastState.compose env1976 (packedSelected [0,4,7,8,9] rootPS)) = affineNative (2^(14+1) ^^^ 2340) := by decide +kernel

theorem selectedBound1976 : packedSelected [0,4,7,8,9] rootPS < 2^1333 := by decide +kernel

def env1977 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,3204,1296,2340,3078,1296,3464,172,2340,445,1448,16,138,2208,17,3464,1296,444,3244,1284,1164,1452,260,1297,1708]

theorem envBound1977 : H12AffineFastState.Bounded env1977 := by
  intro p hp
  have h : env1977.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1976_1977 : H12AffineEnvironment.transform 14 2340 env1976 = env1977 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2340 env1976 == env1977) = true)

theorem identity1977 : scanCanonicalize (H12AffineFastState.compose env1977 (packedSelected [0,2,3,4] rootPS)) = affineNative (2^(10+1) ^^^ 1550) := by decide +kernel

theorem selectedBound1977 : packedSelected [0,2,3,4] rootPS < 2^1333 := by decide +kernel

def env1978 : List Nat := [2,4,8,16,32,17,128,256,512,1024,1550,1296,650,1296,1834,520,1296,902,172,1834,445,1448,16,138,1710,17,902,1296,444,674,1284,1164,1452,260,1297,1708]

theorem envBound1978 : H12AffineFastState.Bounded env1978 := by
  intro p hp
  have h : env1978.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1977_1978 : H12AffineEnvironment.transform 10 1550 env1977 = env1978 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1550 env1977 == env1978) = true)

theorem identity1978 : scanCanonicalize (H12AffineFastState.compose env1978 (packedSelected [1,2,3,5,6] rootPS)) = affineNative (2^(9+1) ^^^ 937) := by decide +kernel

theorem selectedBound1978 : packedSelected [1,2,3,5,6] rootPS < 2^1333 := by decide +kernel

def env1979 : List Nat := [2,4,8,16,32,17,128,256,512,937,423,697,650,697,131,520,697,902,172,131,445,513,16,138,263,17,902,697,444,674,685,805,517,260,696,261]

theorem envBound1979 : H12AffineFastState.Bounded env1979 := by
  intro p hp
  have h : env1979.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1978_1979 : H12AffineEnvironment.transform 9 937 env1978 = env1979 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 937 env1978 == env1979) = true)

def env1980 : List Nat := [2,4,8,16,32,17,128,256,260,173,423,445,398,445,131,268,445,130,172,131,445,261,16,138,263,17,130,445,444,422,425,33,257,260,444,261]

theorem envBound1980 : H12AffineFastState.Bounded env1980 := by
  intro p hp
  have h : env1980.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1979_1980 : H12AffineEnvironment.transform 8 260 env1979 = env1980 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 260 env1979 == env1980) = true)

theorem identity1980 : scanCanonicalize (H12AffineFastState.compose env1980 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 141) := by decide +kernel

theorem selectedBound1980 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1981 : List Nat := [2,4,8,16,32,17,128,141,137,173,42,48,3,48,131,129,48,130,172,131,48,136,16,138,138,17,130,48,49,43,36,33,140,137,49,136]

theorem envBound1981 : H12AffineFastState.Bounded env1981 := by
  intro p hp
  have h : env1981.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1980_1981 : H12AffineEnvironment.transform 7 141 env1980 = env1981 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 141 env1980 == env1981) = true)

theorem identity1981 : scanCanonicalize (H12AffineFastState.compose env1981 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 8) := by decide +kernel

theorem selectedBound1981 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1982 : List Nat := [2,4,8,16,32,17,8,5,1,37,42,48,3,48,11,9,48,10,36,11,48,0,16,2,2,17,10,48,49,43,36,33,4,1,49,0]

theorem envBound1982 : H12AffineFastState.Bounded env1982 := by
  intro p hp
  have h : env1982.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1981_1982 : H12AffineEnvironment.transform 6 8 env1981 = env1982 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env1981 == env1982) = true)

theorem identity1982 : scanCanonicalize (H12AffineFastState.compose env1982 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound1982 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1983 : List Nat := [2,4,8,16,0,17,8,5,1,5,10,16,3,16,11,9,16,10,4,11,16,0,16,2,2,17,10,16,17,11,4,1,4,1,17,0]

theorem envBound1983 : H12AffineFastState.Bounded env1983 := by
  intro p hp
  have h : env1983.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1982_1983 : H12AffineEnvironment.transform 4 0 env1982 = env1983 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1982 == env1983) = true)

def leafEnv1983 : List Nat := [2,4,8,16,0,17,8,5,1,5,10,16,3,16,11,9,16,10,4,11,16,0,16,2,4,2,1,17,10,16,17,11,4,1,4,1,4,8,17,0,0,16,1]

def active1983 : List Nat := [0,1,2,3]

def tree1983 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1983 : H12WitnessSearch.Good tree1983 := H12GlobalWitnessIndex.good

theorem leafIdentity1983 : H12AffineFastState.composeSystem env1983 rootObs = leafEnv1983 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1983 rootObs == leafEnv1983) = true)

theorem terminalChecked1983 : H12PackedTerminal.terminalCheckFast leafEnv1983 active1983 tree1983 = true := by decide +kernel

def env1984 : List Nat := [2,4,8,16,32,17,128,256,261,172,423,444,399,444,131,269,444,131,172,131,445,260,16,138,263,17,131,444,444,423,424,32,256,260,445,261]

theorem envBound1984 : H12AffineFastState.Bounded env1984 := by
  intro p hp
  have h : env1984.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1979_1984 : H12AffineEnvironment.transform 8 261 env1979 = env1984 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 261 env1979 == env1984) = true)

theorem identity1984 : scanCanonicalize (H12AffineFastState.compose env1984 (packedSelected [1] rootPS)) = affineNative (2^(7+1) ^^^ 135) := by decide +kernel

theorem selectedBound1984 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1985 : List Nat := [2,4,8,16,32,17,128,135,130,172,32,59,8,59,131,138,59,131,172,131,58,131,16,138,128,17,131,59,59,32,47,32,135,131,58,130]

theorem envBound1985 : H12AffineFastState.Bounded env1985 := by
  intro p hp
  have h : env1985.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1984_1985 : H12AffineEnvironment.transform 7 135 env1984 = env1985 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 135 env1984 == env1985) = true)

theorem identity1985 : scanCanonicalize (H12AffineFastState.compose env1985 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 3) := by decide +kernel

theorem selectedBound1985 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1986 : List Nat := [2,4,3,16,32,17,128,135,130,167,32,48,3,48,131,129,48,131,167,131,49,131,16,129,128,17,131,48,48,32,36,32,135,131,49,130]

theorem envBound1986 : H12AffineFastState.Bounded env1986 := by
  intro p hp
  have h : env1986.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1985_1986 : H12AffineEnvironment.transform 2 3 env1985 = env1986 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 3 env1985 == env1986) = true)

theorem identity1986 : scanCanonicalize (H12AffineFastState.compose env1986 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 2) := by decide +kernel

theorem selectedBound1986 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1987 : List Nat := [2,4,3,2,32,3,128,135,130,167,32,34,3,34,131,129,34,131,167,131,35,131,2,129,128,3,131,34,34,32,36,32,135,131,35,130]

theorem envBound1987 : H12AffineFastState.Bounded env1987 := by
  intro p hp
  have h : env1987.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1986_1987 : H12AffineEnvironment.transform 3 2 env1986 = env1987 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 2 env1986 == env1987) = true)

theorem identity1987 : scanCanonicalize (H12AffineFastState.compose env1987 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 3) := by decide +kernel

theorem selectedBound1987 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1988 : List Nat := [2,4,3,2,32,3,3,4,1,36,32,34,3,34,0,2,34,0,36,0,35,0,2,2,3,3,0,34,34,32,36,32,4,0,35,1]

theorem envBound1988 : H12AffineFastState.Bounded env1988 := by
  intro p hp
  have h : env1988.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1987_1988 : H12AffineEnvironment.transform 6 3 env1987 = env1988 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 3 env1987 == env1988) = true)

def leafEnv1988 : List Nat := [2,4,3,2,32,3,3,4,1,36,32,34,3,34,0,2,34,0,36,0,35,0,2,2,36,3,1,3,0,34,34,32,36,32,4,0,4,2,35,1,0,34,1]

def active1988 : List Nat := [0,1,4]

def tree1988 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood1988 : H12WitnessSearch.Good tree1988 := H12GlobalWitnessIndex.good

theorem leafIdentity1988 : H12AffineFastState.composeSystem env1988 rootObs = leafEnv1988 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env1988 rootObs == leafEnv1988) = true)

theorem terminalChecked1988 : H12PackedTerminal.terminalCheckFast leafEnv1988 active1988 tree1988 = true := by decide +kernel

def env1989 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,3205,1345,32768,65536,1345,33965,99726,32768,99487,4194304,65,138,101763,17,4260903,1345,99486,4196612,1284,4294967296,98446,4299161632,1344,99214]

theorem envBound1989 : H12AffineFastState.Bounded env1989 := by
  intro p hp
  have h : env1989.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1963_1989 : H12AffineEnvironment.transform 12 3205 env1963 = env1989 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 3205 env1963 == env1989) = true)

theorem identity1989 : scanCanonicalize (H12AffineFastState.compose env1989 (packedSelected [12] rootPS)) = affineNative (2^(31+1) ^^^ 68727) := by decide +kernel

theorem selectedBound1989 : packedSelected [12] rootPS < 2^1333 := by decide +kernel

def env1990 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,3205,1345,32768,65536,1345,33965,99726,32768,99487,4194304,65,138,101763,17,4260903,1345,99486,4196612,1284,68727,98446,4262999,1344,99214]

theorem envBound1990 : H12AffineFastState.Bounded env1990 := by
  intro p hp
  have h : env1990.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1989_1990 : H12AffineEnvironment.transform 31 68727 env1989 = env1990 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 68727 env1989 == env1990) = true)

theorem identity1990 : scanCanonicalize (H12AffineFastState.compose env1990 (packedSelected [1,4,5,9,10,16] rootPS)) = affineNative (2^(15+1) ^^^ 34083) := by decide +kernel

theorem selectedBound1990 : packedSelected [1,4,5,9,10,16] rootPS < 2^1333 := by decide +kernel

def env1991 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,3205,1345,32768,34083,1345,33965,173,32768,444,4194304,65,138,2208,17,4227332,1345,445,4196612,1284,35156,1453,4229492,1344,1709]

theorem envBound1991 : H12AffineFastState.Bounded env1991 := by
  intro p hp
  have h : env1991.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1990_1991 : H12AffineEnvironment.transform 15 34083 env1990 = env1991 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 34083 env1990 == env1991) = true)

theorem identity1991 : scanCanonicalize (H12AffineFastState.compose env1991 (packedSelected [1,8,10,13,15,21] rootPS)) = affineNative (2^(21+1) ^^^ 35981) := by decide +kernel

theorem selectedBound1991 : packedSelected [1,8,10,13,15,21] rootPS < 2^1333 := by decide +kernel

def env1992 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1296,3205,1345,32768,34083,1345,33965,173,32768,444,35981,65,138,2208,17,3465,1345,445,34185,1284,35156,1453,1529,1344,1709]

theorem envBound1992 : H12AffineFastState.Bounded env1992 := by
  intro p hp
  have h : env1992.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1991_1992 : H12AffineEnvironment.transform 21 35981 env1991 = env1992 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 35981 env1991 == env1992) = true)

def env1993 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1296,3205,1297,32768,34083,1297,33965,173,32768,444,35981,17,138,2208,17,3465,1297,445,34185,1284,35076,1453,1449,1296,1709]

theorem envBound1993 : H12AffineFastState.Bounded env1993 := by
  intro p hp
  have h : env1993.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1992_1993 : H12AffineEnvironment.transform 5 16 env1992 = env1993 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env1992 == env1993) = true)

theorem identity1993 : scanCanonicalize (H12AffineFastState.compose env1993 (packedSelected [0,4,7,8,9] rootPS)) = affineNative (2^(14+1) ^^^ 2989) := by decide +kernel

theorem selectedBound1993 : packedSelected [0,4,7,8,9] rootPS < 2^1333 := by decide +kernel

def env1994 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1296,3205,1297,2989,3726,1297,3840,173,2989,444,1824,17,138,2208,17,3465,1297,445,3620,1284,681,1453,1449,1296,1709]

theorem envBound1994 : H12AffineFastState.Bounded env1994 := by
  intro p hp
  have h : env1994.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1993_1994 : H12AffineEnvironment.transform 14 2989 env1993 = env1994 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2989 env1993 == env1994) = true)

theorem identity1994 : scanCanonicalize (H12AffineFastState.compose env1994 (packedSelected [1,5,13] rootPS)) = affineNative (2^(9+1) ^^^ 172) := by decide +kernel

theorem selectedBound1994 : packedSelected [1,5,13] rootPS < 2^1333 := by decide +kernel

def env1995 : List Nat := [2,4,8,16,32,16,128,256,512,172,2048,444,2089,445,2989,2594,445,2988,173,2989,444,908,17,138,2208,17,2341,445,445,2696,424,681,257,261,444,513]

theorem envBound1995 : H12AffineFastState.Bounded env1995 := by
  intro p hp
  have h : env1995.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1994_1995 : H12AffineEnvironment.transform 9 172 env1994 = env1995 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 172 env1994 == env1995) = true)

theorem identity1995 : scanCanonicalize (H12AffineFastState.compose env1995 (packedSelected [1] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound1995 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env1996 : List Nat := [2,4,8,16,32,16,128,256,137,172,2048,444,2089,445,2340,2219,445,2341,173,2340,444,261,17,138,2208,17,2341,445,445,2049,424,32,257,261,444,136]

theorem envBound1996 : H12AffineFastState.Bounded env1996 := by
  intro p hp
  have h : env1996.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1995_1996 : H12AffineEnvironment.transform 8 137 env1995 = env1996 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env1995 == env1996) = true)

theorem identity1996 : scanCanonicalize (H12AffineFastState.compose env1996 (packedSelected [0] rootPS)) = affineNative (2^(10+1) ^^^ 302) := by decide +kernel

theorem selectedBound1996 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env1997 : List Nat := [2,4,8,16,32,16,128,256,137,172,302,444,263,445,10,389,445,11,173,10,444,261,17,138,398,17,11,445,445,303,424,32,257,261,444,136]

theorem envBound1997 : H12AffineFastState.Bounded env1997 := by
  intro p hp
  have h : env1997.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1996_1997 : H12AffineEnvironment.transform 10 302 env1996 = env1997 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 302 env1996 == env1997) = true)

theorem identity1997 : scanCanonicalize (H12AffineFastState.compose env1997 (packedSelected [2] rootPS)) = affineNative (2^(6+1) ^^^ 40) := by decide +kernel

theorem selectedBound1997 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env1998 : List Nat := [2,4,8,16,32,16,40,256,33,4,302,276,263,277,10,301,277,11,5,10,276,261,17,34,294,17,11,277,277,303,256,32,257,261,276,32]

theorem envBound1998 : H12AffineFastState.Bounded env1998 := by
  intro p hp
  have h : env1998.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1997_1998 : H12AffineEnvironment.transform 6 40 env1997 = env1998 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 40 env1997 == env1998) = true)

theorem identity1998 : scanCanonicalize (H12AffineFastState.compose env1998 (packedSelected [3] rootPS)) = affineNative (2^(7+1) ^^^ 37) := by decide +kernel

theorem selectedBound1998 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env1999 : List Nat := [2,4,8,16,32,16,40,37,33,4,11,49,34,48,10,8,48,11,5,10,49,32,17,34,3,17,11,48,48,10,37,32,36,32,49,32]

theorem envBound1999 : H12AffineFastState.Bounded env1999 := by
  intro p hp
  have h : env1999.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1998_1999 : H12AffineEnvironment.transform 7 37 env1998 = env1999 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 37 env1998 == env1999) = true)

theorem identity1999 : scanCanonicalize (H12AffineFastState.compose env1999 (packedSelected [4] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound1999 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env2000 : List Nat := [2,4,8,16,0,16,8,5,1,4,11,17,2,16,10,8,16,11,5,10,17,0,17,2,3,17,11,16,16,10,5,0,4,0,17,0]

theorem envBound2000 : H12AffineFastState.Bounded env2000 := by
  intro p hp
  have h : env2000.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1999_2000 : H12AffineEnvironment.transform 4 0 env1999 = env2000 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env1999 == env2000) = true)

def leafEnv2000 : List Nat := [2,4,8,16,0,16,8,5,1,4,11,17,2,16,10,8,16,11,5,10,17,0,17,2,5,3,1,17,11,16,16,10,5,0,4,0,4,9,17,0,0,17,1]

def active2000 : List Nat := [0,1,2,3]

def tree2000 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2000 : H12WitnessSearch.Good tree2000 := H12GlobalWitnessIndex.good

theorem leafIdentity2000 : H12AffineFastState.composeSystem env2000 rootObs = leafEnv2000 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2000 rootObs == leafEnv2000) = true)

theorem terminalChecked2000 : H12PackedTerminal.terminalCheckFast leafEnv2000 active2000 tree2000 = true := by decide +kernel

def env2001 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,3205,1296,32768,34083,1296,33965,173,32768,444,35981,16,138,2208,17,3465,1296,445,34185,1284,35077,1453,1448,1297,1709]

theorem envBound2001 : H12AffineFastState.Bounded env2001 := by
  intro p hp
  have h : env2001.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1992_2001 : H12AffineEnvironment.transform 5 17 env1992 = env2001 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 17 env1992 == env2001) = true)

theorem identity2001 : scanCanonicalize (H12AffineFastState.compose env2001 (packedSelected [0,4,7,8,9] rootPS)) = affineNative (2^(14+1) ^^^ 2340) := by decide +kernel

theorem selectedBound2001 : packedSelected [0,4,7,8,9] rootPS < 2^1333 := by decide +kernel

def env2002 : List Nat := [2,4,8,16,32,17,128,256,512,1024,2048,1296,3205,1296,2340,3079,1296,3465,173,2340,444,1449,16,138,2208,17,3465,1296,445,3245,1284,33,1453,1448,1297,1709]

theorem envBound2002 : H12AffineFastState.Bounded env2002 := by
  intro p hp
  have h : env2002.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2001_2002 : H12AffineEnvironment.transform 14 2340 env2001 = env2002 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2340 env2001 == env2002) = true)

theorem identity2002 : scanCanonicalize (H12AffineFastState.compose env2002 (packedSelected [0,2,3,4] rootPS)) = affineNative (2^(10+1) ^^^ 1550) := by decide +kernel

theorem selectedBound2002 : packedSelected [0,2,3,4] rootPS < 2^1333 := by decide +kernel

def env2003 : List Nat := [2,4,8,16,32,17,128,256,512,1024,1550,1296,651,1296,1834,521,1296,903,173,1834,444,1449,16,138,1710,17,903,1296,445,675,1284,33,1453,1448,1297,1709]

theorem envBound2003 : H12AffineFastState.Bounded env2003 := by
  intro p hp
  have h : env2003.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2002_2003 : H12AffineEnvironment.transform 10 1550 env2002 = env2003 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1550 env2002 == env2003) = true)

theorem identity2003 : scanCanonicalize (H12AffineFastState.compose env2003 (packedSelected [1,2,6] rootPS)) = affineNative (2^(8+1) ^^^ 33) := by decide +kernel

theorem selectedBound2003 : packedSelected [1,2,6] rootPS < 2^1333 := by decide +kernel

def env2004 : List Nat := [2,4,8,16,32,17,128,256,33,1024,1071,1296,170,1296,1291,40,1296,422,173,1291,444,1449,16,138,1167,17,422,1296,445,130,1284,33,1453,1448,1297,1164]

theorem envBound2004 : H12AffineFastState.Bounded env2004 := by
  intro p hp
  have h : env2004.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2003_2004 : H12AffineEnvironment.transform 8 33 env2003 = env2004 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 33 env2003 == env2004) = true)

def env2005 : List Nat := [2,4,8,16,32,17,128,256,33,172,131,444,170,444,423,40,444,422,173,423,444,261,16,138,35,17,422,444,445,130,424,33,257,260,445,32]

theorem envBound2005 : H12AffineFastState.Bounded env2005 := by
  intro p hp
  have h : env2005.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2004_2005 : H12AffineEnvironment.transform 9 172 env2004 = env2005 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 172 env2004 == env2005) = true)

theorem identity2005 : scanCanonicalize (H12AffineFastState.compose env2005 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 40) := by decide +kernel

theorem selectedBound2005 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2006 : List Nat := [2,4,8,16,32,17,40,256,33,4,43,276,2,276,271,40,276,270,5,271,276,261,16,34,35,17,270,276,277,42,256,33,257,260,277,32]

theorem envBound2006 : H12AffineFastState.Bounded env2006 := by
  intro p hp
  have h : env2006.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2005_2006 : H12AffineEnvironment.transform 6 40 env2005 = env2006 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 40 env2005 == env2006) = true)

theorem identity2006 : scanCanonicalize (H12AffineFastState.compose env2006 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound2006 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2007 : List Nat := [2,4,8,16,32,17,40,5,33,4,43,17,2,17,10,40,17,11,5,10,17,0,16,34,35,17,11,17,16,42,5,33,4,1,16,32]

theorem envBound2007 : H12AffineFastState.Bounded env2007 := by
  intro p hp
  have h : env2007.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2006_2007 : H12AffineEnvironment.transform 7 5 env2006 = env2007 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env2006 == env2007) = true)

theorem identity2007 : scanCanonicalize (H12AffineFastState.compose env2007 (packedSelected [2] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound2007 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2008 : List Nat := [2,4,8,16,0,17,8,5,1,4,11,17,2,17,10,8,17,11,5,10,17,0,16,2,3,17,11,17,16,10,5,1,4,1,16,0]

theorem envBound2008 : H12AffineFastState.Bounded env2008 := by
  intro p hp
  have h : env2008.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2007_2008 : H12AffineEnvironment.transform 4 0 env2007 = env2008 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env2007 == env2008) = true)

def leafEnv2008 : List Nat := [2,4,8,16,0,17,8,5,1,4,11,17,2,17,10,8,17,11,5,10,17,0,16,2,5,3,1,17,11,17,16,10,5,1,4,1,4,9,16,0,0,17,1]

def active2008 : List Nat := [0,1,2,3]

def tree2008 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2008 : H12WitnessSearch.Good tree2008 := H12GlobalWitnessIndex.good

theorem leafIdentity2008 : H12AffineFastState.composeSystem env2008 rootObs = leafEnv2008 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2008 rootObs == leafEnv2008) = true)

theorem terminalChecked2008 : H12PackedTerminal.terminalCheckFast leafEnv2008 active2008 tree2008 = true := by decide +kernel

def env2009 : List Nat := [2,4,8,16,32,17,128,256,33,173,130,445,170,445,422,40,445,422,173,422,444,260,16,138,34,17,422,445,445,130,425,33,256,261,444,33]

theorem envBound2009 : H12AffineFastState.Bounded env2009 := by
  intro p hp
  have h : env2009.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2004_2009 : H12AffineEnvironment.transform 9 173 env2004 = env2009 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 173 env2004 == env2009) = true)

theorem identity2009 : scanCanonicalize (H12AffineFastState.compose env2009 (packedSelected [1] rootPS)) = affineNative (2^(6+1) ^^^ 34) := by decide +kernel

theorem selectedBound2009 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2010 : List Nat := [2,4,8,16,32,17,34,256,33,15,32,287,8,287,260,40,287,260,15,260,286,260,16,40,34,17,260,287,287,32,267,33,256,261,286,33]

theorem envBound2010 : H12AffineFastState.Bounded env2010 := by
  intro p hp
  have h : env2010.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2009_2010 : H12AffineEnvironment.transform 6 34 env2009 = env2010 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 34 env2009 == env2010) = true)

theorem identity2010 : scanCanonicalize (H12AffineFastState.compose env2010 (packedSelected [2] rootPS)) = affineNative (2^(7+1) ^^^ 47) := by decide +kernel

theorem selectedBound2010 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2011 : List Nat := [2,4,8,16,32,17,34,47,33,15,32,48,8,48,43,40,48,43,15,43,49,43,16,40,34,17,43,48,48,32,36,33,47,42,49,33]

theorem envBound2011 : H12AffineFastState.Bounded env2011 := by
  intro p hp
  have h : env2011.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2010_2011 : H12AffineEnvironment.transform 7 47 env2010 = env2011 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 47 env2010 == env2011) = true)

theorem identity2011 : scanCanonicalize (H12AffineFastState.compose env2011 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound2011 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env2012 : List Nat := [2,4,8,16,10,17,8,5,11,15,10,26,8,26,1,2,26,1,15,1,27,1,16,2,8,17,1,26,26,10,14,11,5,0,27,11]

theorem envBound2012 : H12AffineFastState.Bounded env2012 := by
  intro p hp
  have h : env2012.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2011_2012 : H12AffineEnvironment.transform 4 10 env2011 = env2012 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 10 env2011 == env2012) = true)

theorem identity2012 : scanCanonicalize (H12AffineFastState.compose env2012 (packedSelected [0] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound2012 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2013 : List Nat := [2,4,8,3,10,2,8,5,11,15,10,9,8,9,1,2,9,1,15,1,8,1,3,2,8,2,1,9,9,10,14,11,5,0,8,11]

theorem envBound2013 : H12AffineFastState.Bounded env2013 := by
  intro p hp
  have h : env2013.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2012_2013 : H12AffineEnvironment.transform 3 3 env2012 = env2013 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env2012 == env2013) = true)

def leafEnv2013 : List Nat := [2,4,8,3,10,2,8,5,11,15,10,9,8,9,1,2,9,1,15,1,8,1,3,2,14,8,1,2,1,9,9,10,14,11,5,0,4,2,8,11,0,9,1]

def active2013 : List Nat := [0,1,2]

def tree2013 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2013 : H12WitnessSearch.Good tree2013 := H12GlobalWitnessIndex.good

theorem leafIdentity2013 : H12AffineFastState.composeSystem env2013 rootObs = leafEnv2013 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2013 rootObs == leafEnv2013) = true)

theorem terminalChecked2013 : H12PackedTerminal.terminalCheckFast leafEnv2013 active2013 tree2013 = true := by decide +kernel

def env2014 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,32768,65536,131072,262144,524288,32768,524560,4194304,64,753733,33554432,16,5111877,1344,656465,4820106,131141,4294967296,525568,4332954727,131073,33563272]

theorem envBound2014 : H12AffineFastState.Bounded env2014 := by
  intro p hp
  have h : env2014.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans1958_2014 : H12AffineEnvironment.transform 11 1297 env1958 = env2014 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1297 env1958 == env2014) = true)

def env2015 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,32768,65536,131072,262144,524288,32768,524560,4194304,64,753733,4752392,16,5111877,1344,656465,4820106,131141,4294967296,525568,4295696495,131073,4761216]

theorem envBound2015 : H12AffineFastState.Bounded env2015 := by
  intro p hp
  have h : env2015.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2014_2015 : H12AffineEnvironment.transform 24 4752392 env2014 = env2015 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 4752392 env2014 == env2015) = true)

theorem identity2015 : scanCanonicalize (H12AffineFastState.compose env2015 (packedSelected [0,1,3,5,7,8,9,10,19,20,22] rootPS)) = affineNative (2^(21+1) ^^^ 41088) := by decide +kernel

theorem selectedBound2015 : packedSelected [0,1,3,5,7,8,9,10,19,20,22] rootPS < 2^1333 := by decide +kernel

def env2016 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,32768,65536,131072,262144,524288,32768,524560,41088,64,753733,533640,16,958661,1344,656465,601098,131141,4294967296,525568,4295696495,131073,525824]

theorem envBound2016 : H12AffineFastState.Bounded env2016 := by
  intro p hp
  have h : env2016.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2015_2016 : H12AffineEnvironment.transform 21 41088 env2015 = env2016 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 41088 env2015 == env2016) = true)

theorem identity2016 : scanCanonicalize (H12AffineFastState.compose env2016 (packedSelected [10,12,13,15,21,26] rootPS)) = affineNative (2^(16+1) ^^^ 1345) := by decide +kernel

theorem selectedBound2016 : packedSelected [10,12,13,15,21,26] rootPS < 2^1333 := by decide +kernel

def env2017 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,32768,65536,1345,262144,524288,32768,524560,41088,64,623876,533640,16,828804,1344,524560,601098,1284,4294967296,525568,4295566638,1344,525824]

theorem envBound2017 : H12AffineFastState.Bounded env2017 := by
  intro p hp
  have h : env2017.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2016_2017 : H12AffineEnvironment.transform 16 1345 env2016 = env2017 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env2016 == env2017) = true)

def env2018 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,32768,65536,1345,262144,1024,32768,1296,41088,64,98564,8328,16,303492,1344,1296,75786,1284,4294967296,256,4295041326,1344,512]

theorem envBound2018 : H12AffineFastState.Bounded env2018 := by
  intro p hp
  have h : env2018.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2017_2018 : H12AffineEnvironment.transform 18 1024 env2017 = env2018 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env2017 == env2018) = true)

theorem identity2018 : scanCanonicalize (H12AffineFastState.compose env2018 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 106538) := by decide +kernel

theorem selectedBound2018 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env2019 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,32768,65536,1345,262144,1024,32768,1296,41088,64,98564,8328,16,303492,1344,1296,75786,1284,106538,256,33028,1344,512]

theorem envBound2019 : H12AffineFastState.Bounded env2019 := by
  intro p hp
  have h : env2019.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2018_2019 : H12AffineEnvironment.transform 31 106538 env2018 = env2019 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 106538 env2018 == env2019) = true)

theorem identity2019 : scanCanonicalize (H12AffineFastState.compose env2019 (packedSelected [3,5,10] rootPS)) = affineNative (2^(15+1) ^^^ 1394) := by decide +kernel

theorem selectedBound2019 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env2020 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,32768,1394,1345,262144,1024,32768,1296,41088,64,33910,8328,16,303492,1344,1296,11640,1284,42328,256,33028,1344,512]

theorem envBound2020 : H12AffineFastState.Bounded env2020 := by
  intro p hp
  have h : env2020.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2019_2020 : H12AffineEnvironment.transform 15 1394 env2019 = env2020 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 1394 env2019 == env2020) = true)

theorem identity2020 : scanCanonicalize (H12AffineFastState.compose env2020 (packedSelected [3,5,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 8540) := by decide +kernel

theorem selectedBound2020 : packedSelected [3,5,12,13] rootPS < 2^1333 := by decide +kernel

def env2021 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,8540,1394,1345,262144,1024,8540,1296,476,64,9514,8328,16,262360,1344,1296,11640,1284,1028,256,8280,1344,512]

theorem envBound2021 : H12AffineFastState.Bounded env2021 := by
  intro p hp
  have h : env2021.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2020_2021 : H12AffineEnvironment.transform 14 8540 env2020 = env2021 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8540 env2020 == env2021) = true)

theorem identity2021 : scanCanonicalize (H12AffineFastState.compose env2021 (packedSelected [4,9,16] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound2021 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env2022 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1297,8192,1296,8460,1314,1297,262144,1024,8460,1296,396,16,9514,8328,16,262280,1296,1296,11560,1284,1028,256,8200,1296,512]

theorem envBound2022 : H12AffineFastState.Bounded env2022 := by
  intro p hp
  have h : env2022.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2021_2022 : H12AffineEnvironment.transform 5 16 env2021 = env2022 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env2021 == env2022) = true)

theorem identity2022 : scanCanonicalize (H12AffineFastState.compose env2022 (packedSelected [1,3,5] rootPS)) = affineNative (2^(12+1) ^^^ 8) := by decide +kernel

theorem selectedBound2022 : packedSelected [1,3,5] rootPS < 2^1333 := by decide +kernel

def env2023 : List Nat := [2,4,8,16,32,16,128,256,512,1024,2048,1297,8,1296,260,1314,1297,262144,1024,260,1296,396,16,1314,128,16,262280,1296,1296,3360,1284,1028,256,0,1296,512]

theorem envBound2023 : H12AffineFastState.Bounded env2023 := by
  intro p hp
  have h : env2023.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2022_2023 : H12AffineEnvironment.transform 12 8 env2022 = env2023 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 8 env2022 == env2023) = true)

def env2024 : List Nat := [2,4,8,16,32,16,128,256,512,272,2048,1,8,0,260,50,1,262144,272,260,0,396,16,50,128,16,262280,0,0,2096,20,276,256,0,0,512]

theorem envBound2024 : H12AffineFastState.Bounded env2024 := by
  intro p hp
  have h : env2024.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2023_2024 : H12AffineEnvironment.transform 9 272 env2023 = env2024 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 272 env2023 == env2024) = true)

def env2025 : List Nat := [2,4,8,16,32,16,8,256,512,272,2048,1,8,0,260,50,1,262144,272,260,0,260,16,50,8,16,262144,0,0,2096,20,276,256,0,0,512]

theorem envBound2025 : H12AffineFastState.Bounded env2025 := by
  intro p hp
  have h : env2025.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2024_2025 : H12AffineEnvironment.transform 6 8 env2024 = env2025 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 8 env2024 == env2025) = true)

theorem identity2025 : scanCanonicalize (H12AffineFastState.compose env2025 (packedSelected [7] rootPS)) = affineNative (2^(17+1) ^^^ 34) := by decide +kernel

theorem selectedBound2025 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env2026 : List Nat := [2,4,8,16,32,16,8,256,512,272,2048,1,8,0,260,50,1,34,272,260,0,260,16,50,8,16,34,0,0,2096,20,276,256,0,0,512]

theorem envBound2026 : H12AffineFastState.Bounded env2026 := by
  intro p hp
  have h : env2026.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2025_2026 : H12AffineEnvironment.transform 17 34 env2025 = env2026 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 34 env2025 == env2026) = true)

def env2027 : List Nat := [2,4,8,16,32,16,8,256,512,272,0,1,8,0,260,50,1,34,272,260,0,260,16,50,8,16,34,0,0,48,20,276,256,0,0,512]

theorem envBound2027 : H12AffineFastState.Bounded env2027 := by
  intro p hp
  have h : env2027.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2026_2027 : H12AffineEnvironment.transform 10 0 env2026 = env2027 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env2026 == env2027) = true)

theorem identity2027 : scanCanonicalize (H12AffineFastState.compose env2027 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 54) := by decide +kernel

theorem selectedBound2027 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2028 : List Nat := [2,4,8,16,32,16,8,54,512,38,0,1,8,0,50,50,1,34,38,50,0,50,16,50,8,16,34,0,0,48,20,34,54,0,0,512]

theorem envBound2028 : H12AffineFastState.Bounded env2028 := by
  intro p hp
  have h : env2028.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2027_2028 : H12AffineEnvironment.transform 7 54 env2027 = env2028 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 54 env2027 == env2028) = true)

theorem identity2028 : scanCanonicalize (H12AffineFastState.compose env2028 (packedSelected [2,4,11] rootPS)) = affineNative (2^(8+1) ^^^ 25) := by decide +kernel

theorem selectedBound2028 : packedSelected [2,4,11] rootPS < 2^1333 := by decide +kernel

def env2029 : List Nat := [2,4,8,16,32,16,8,54,25,38,0,1,8,0,50,50,1,34,38,50,0,50,16,50,8,16,34,0,0,48,20,34,54,0,0,25]

theorem envBound2029 : H12AffineFastState.Bounded env2029 := by
  intro p hp
  have h : env2029.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2028_2029 : H12AffineEnvironment.transform 8 25 env2028 = env2029 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 25 env2028 == env2029) = true)

theorem identity2029 : scanCanonicalize (H12AffineFastState.compose env2029 (packedSelected [2,4,9,18] rootPS)) = affineNative (2^(4+1) ^^^ 8) := by decide +kernel

theorem selectedBound2029 : packedSelected [2,4,9,18] rootPS < 2^1333 := by decide +kernel

def env2030 : List Nat := [2,4,8,16,8,16,8,30,25,14,0,1,8,0,26,26,1,10,14,26,0,26,16,26,8,16,10,0,0,24,20,10,30,0,0,25]

theorem envBound2030 : H12AffineFastState.Bounded env2030 := by
  intro p hp
  have h : env2030.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2029_2030 : H12AffineEnvironment.transform 4 8 env2029 = env2030 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 8 env2029 == env2030) = true)

theorem identity2030 : scanCanonicalize (H12AffineFastState.compose env2030 (packedSelected [2,4,9,23] rootPS)) = affineNative (2^(3+1) ^^^ 8) := by decide +kernel

theorem selectedBound2030 : packedSelected [2,4,9,23] rootPS < 2^1333 := by decide +kernel

def env2031 : List Nat := [2,4,8,8,8,8,8,6,1,14,0,1,8,0,2,2,1,10,14,2,0,2,8,2,8,8,10,0,0,0,12,10,6,0,0,1]

theorem envBound2031 : H12AffineFastState.Bounded env2031 := by
  intro p hp
  have h : env2031.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2030_2031 : H12AffineEnvironment.transform 3 8 env2030 = env2031 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 8 env2030 == env2031) = true)

def env2032 : List Nat := [2,4,0,0,0,0,0,6,1,6,0,1,0,0,2,2,1,2,6,2,0,2,0,2,0,0,2,0,0,0,4,2,6,0,0,1]

theorem envBound2032 : H12AffineFastState.Bounded env2032 := by
  intro p hp
  have h : env2032.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2031_2032 : H12AffineEnvironment.transform 2 0 env2031 = env2032 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env2031 == env2032) = true)

def leafEnv2032 : List Nat := [2,4,0,0,0,0,0,6,1,6,0,1,0,0,2,2,1,2,6,2,0,2,0,2,4,0,1,0,2,0,0,0,4,2,6,0,4,2,0,1,0,0,1]

def active2032 : List Nat := [0,1]

def tree2032 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2032 : H12WitnessSearch.Good tree2032 := H12GlobalWitnessIndex.good

theorem leafIdentity2032 : H12AffineFastState.composeSystem env2032 rootObs = leafEnv2032 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2032 rootObs == leafEnv2032) = true)

theorem terminalChecked2032 : H12PackedTerminal.terminalCheckFast leafEnv2032 active2032 tree2032 = true := by decide +kernel

def env2033 : List Nat := [2,4,1,1,1,1,1,6,1,7,0,1,1,0,2,2,1,3,7,2,0,2,1,2,1,1,3,0,0,0,5,3,6,0,0,1]

theorem envBound2033 : H12AffineFastState.Bounded env2033 := by
  intro p hp
  have h : env2033.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2031_2033 : H12AffineEnvironment.transform 2 1 env2031 = env2033 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env2031 == env2033) = true)

theorem identity2033 : scanCanonicalize (H12AffineFastState.compose env2033 (packedSelected [2] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound2033 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2034 : List Nat := [0,4,1,1,1,1,1,4,1,5,0,1,1,0,0,0,1,1,5,0,0,0,1,0,1,1,1,0,0,0,5,1,4,0,0,1]

theorem envBound2034 : H12AffineFastState.Bounded env2034 := by
  intro p hp
  have h : env2034.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2033_2034 : H12AffineEnvironment.transform 0 0 env2033 = env2034 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env2033 == env2034) = true)

def leafEnv2034 : List Nat := [0,4,1,1,1,1,1,4,1,5,0,1,1,0,0,0,1,1,5,0,0,0,1,0,5,1,1,1,1,0,0,0,5,1,4,0,4,0,0,1,0,0,1]

def active2034 : List Nat := [1]

def tree2034 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2034 : H12WitnessSearch.Good tree2034 := H12GlobalWitnessIndex.good

theorem leafIdentity2034 : H12AffineFastState.composeSystem env2034 rootObs = leafEnv2034 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2034 rootObs == leafEnv2034) = true)

theorem terminalChecked2034 : H12PackedTerminal.terminalCheckFast leafEnv2034 active2034 tree2034 = true := by decide +kernel

def env2035 : List Nat := [2,4,8,16,32,16,8,256,512,272,1,1,8,0,260,50,1,34,272,260,0,260,16,50,8,16,34,0,0,49,20,276,256,0,0,512]

theorem envBound2035 : H12AffineFastState.Bounded env2035 := by
  intro p hp
  have h : env2035.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2026_2035 : H12AffineEnvironment.transform 10 1 env2026 = env2035 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env2026 == env2035) = true)

theorem identity2035 : scanCanonicalize (H12AffineFastState.compose env2035 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 7) := by decide +kernel

theorem selectedBound2035 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2036 : List Nat := [2,4,8,16,32,16,8,7,512,23,1,1,8,0,3,50,1,34,23,3,0,3,16,50,8,16,34,0,0,49,20,19,7,0,0,512]

theorem envBound2036 : H12AffineFastState.Bounded env2036 := by
  intro p hp
  have h : env2036.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2035_2036 : H12AffineEnvironment.transform 7 7 env2035 = env2036 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 7 env2035 == env2036) = true)

theorem identity2036 : scanCanonicalize (H12AffineFastState.compose env2036 (packedSelected [2,11] rootPS)) = affineNative (2^(8+1) ^^^ 19) := by decide +kernel

theorem selectedBound2036 : packedSelected [2,11] rootPS < 2^1333 := by decide +kernel

def env2037 : List Nat := [2,4,8,16,32,16,8,7,19,23,1,1,8,0,3,50,1,34,23,3,0,3,16,50,8,16,34,0,0,49,20,19,7,0,0,19]

theorem envBound2037 : H12AffineFastState.Bounded env2037 := by
  intro p hp
  have h : env2037.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2036_2037 : H12AffineEnvironment.transform 8 19 env2036 = env2037 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 19 env2036 == env2037) = true)

theorem identity2037 : scanCanonicalize (H12AffineFastState.compose env2037 (packedSelected [2,9,18] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound2037 : packedSelected [2,9,18] rootPS < 2^1333 := by decide +kernel

def env2038 : List Nat := [2,4,2,16,32,16,2,7,19,23,1,1,2,0,3,50,1,34,23,3,0,3,16,50,2,16,34,0,0,49,20,19,7,0,0,19]

theorem envBound2038 : H12AffineFastState.Bounded env2038 := by
  intro p hp
  have h : env2038.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2037_2038 : H12AffineEnvironment.transform 2 2 env2037 = env2038 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env2037 == env2038) = true)

theorem identity2038 : scanCanonicalize (H12AffineFastState.compose env2038 (packedSelected [2,32] rootPS)) = affineNative (2^(4+1) ^^^ 16) := by decide +kernel

theorem selectedBound2038 : packedSelected [2,32] rootPS < 2^1333 := by decide +kernel

def env2039 : List Nat := [2,4,2,16,16,16,2,7,19,23,1,1,2,0,3,2,1,18,23,3,0,3,16,2,2,16,18,0,0,1,20,19,7,0,0,19]

theorem envBound2039 : H12AffineFastState.Bounded env2039 := by
  intro p hp
  have h : env2039.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2038_2039 : H12AffineEnvironment.transform 4 16 env2038 = env2039 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env2038 == env2039) = true)

def env2040 : List Nat := [2,4,2,0,0,0,2,7,3,7,1,1,2,0,3,2,1,2,7,3,0,3,0,2,2,0,2,0,0,1,4,3,7,0,0,3]

theorem envBound2040 : H12AffineFastState.Bounded env2040 := by
  intro p hp
  have h : env2040.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2039_2040 : H12AffineEnvironment.transform 3 0 env2039 = env2040 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env2039 == env2040) = true)

theorem identity2040 : scanCanonicalize (H12AffineFastState.compose env2040 (packedSelected [2] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound2040 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2041 : List Nat := [0,4,0,0,0,0,0,5,1,5,1,1,0,0,1,0,1,0,5,1,0,1,0,0,0,0,0,0,0,1,4,1,5,0,0,1]

theorem envBound2041 : H12AffineFastState.Bounded env2041 := by
  intro p hp
  have h : env2041.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2040_2041 : H12AffineEnvironment.transform 0 0 env2040 = env2041 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env2040 == env2041) = true)

def leafEnv2041 : List Nat := [0,4,0,0,0,0,0,5,1,5,1,1,0,0,1,0,1,0,5,1,0,1,0,0,4,0,1,0,0,0,0,1,4,1,5,0,4,0,0,1,0,0,1]

def active2041 : List Nat := [1]

def tree2041 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2041 : H12WitnessSearch.Good tree2041 := H12GlobalWitnessIndex.good

theorem leafIdentity2041 : H12AffineFastState.composeSystem env2041 rootObs = leafEnv2041 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2041 rootObs == leafEnv2041) = true)

theorem terminalChecked2041 : H12PackedTerminal.terminalCheckFast leafEnv2041 active2041 tree2041 = true := by decide +kernel

def env2042 : List Nat := [2,4,2,1,1,1,2,7,2,6,1,1,2,0,3,2,1,3,6,3,0,3,1,2,2,1,3,0,0,1,5,2,7,0,0,2]

theorem envBound2042 : H12AffineFastState.Bounded env2042 := by
  intro p hp
  have h : env2042.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2039_2042 : H12AffineEnvironment.transform 3 1 env2039 = env2042 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env2039 == env2042) = true)

def leafEnv2042 : List Nat := [2,4,2,1,1,1,2,7,2,6,1,1,2,0,3,2,1,3,6,3,0,3,1,2,5,2,1,1,3,0,0,1,5,2,7,0,4,2,0,2,0,0,1]

def active2042 : List Nat := [0,1]

def tree2042 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2042 : H12WitnessSearch.Good tree2042 := H12GlobalWitnessIndex.good

theorem leafIdentity2042 : H12AffineFastState.composeSystem env2042 rootObs = leafEnv2042 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2042 rootObs == leafEnv2042) = true)

theorem terminalChecked2042 : H12PackedTerminal.terminalCheckFast leafEnv2042 active2042 tree2042 = true := by decide +kernel

def env2043 : List Nat := [2,4,8,16,32,16,9,256,512,272,2048,1,8,0,260,50,1,262144,272,260,0,261,16,50,9,16,262145,0,0,2096,20,276,256,0,0,512]

theorem envBound2043 : H12AffineFastState.Bounded env2043 := by
  intro p hp
  have h : env2043.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2024_2043 : H12AffineEnvironment.transform 6 9 env2024 = env2043 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 9 env2024 == env2043) = true)

theorem identity2043 : scanCanonicalize (H12AffineFastState.compose env2043 (packedSelected [7] rootPS)) = affineNative (2^(7+1) ^^^ 39) := by decide +kernel

theorem selectedBound2043 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env2044 : List Nat := [2,4,8,16,32,16,9,39,512,55,2048,1,8,0,35,50,1,262144,55,35,0,34,16,50,9,16,262145,0,0,2096,20,51,39,0,0,512]

theorem envBound2044 : H12AffineFastState.Bounded env2044 := by
  intro p hp
  have h : env2044.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2043_2044 : H12AffineEnvironment.transform 7 39 env2043 = env2044 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 39 env2043 == env2044) = true)

def env2045 : List Nat := [2,4,8,16,32,16,9,39,512,55,0,1,8,0,35,50,1,262144,55,35,0,34,16,50,9,16,262145,0,0,48,20,51,39,0,0,512]

theorem envBound2045 : H12AffineFastState.Bounded env2045 := by
  intro p hp
  have h : env2045.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2044_2045 : H12AffineEnvironment.transform 10 0 env2044 = env2045 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env2044 == env2045) = true)

theorem identity2045 : scanCanonicalize (H12AffineFastState.compose env2045 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 18) := by decide +kernel

theorem selectedBound2045 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2046 : List Nat := [2,4,8,16,18,16,9,21,512,5,0,1,8,0,17,0,1,262144,5,17,0,16,16,0,9,16,262145,0,0,2,20,1,21,0,0,512]

theorem envBound2046 : H12AffineFastState.Bounded env2046 := by
  intro p hp
  have h : env2046.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2045_2046 : H12AffineEnvironment.transform 4 18 env2045 = env2046 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 18 env2045 == env2046) = true)

theorem identity2046 : scanCanonicalize (H12AffineFastState.compose env2046 (packedSelected [2,4] rootPS)) = affineNative (2^(8+1) ^^^ 10) := by decide +kernel

theorem selectedBound2046 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env2047 : List Nat := [2,4,8,16,18,16,9,21,10,5,0,1,8,0,17,0,1,262144,5,17,0,16,16,0,9,16,262145,0,0,2,20,1,21,0,0,10]

theorem envBound2047 : H12AffineFastState.Bounded env2047 := by
  intro p hp
  have h : env2047.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2046_2047 : H12AffineEnvironment.transform 8 10 env2046 = env2047 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 10 env2046 == env2047) = true)

theorem identity2047 : scanCanonicalize (H12AffineFastState.compose env2047 (packedSelected [2,11,18] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound2047 : packedSelected [2,11,18] rootPS < 2^1333 := by decide +kernel

def env2048 : List Nat := [2,4,2,16,18,16,3,21,0,5,0,1,2,0,17,0,1,262144,5,17,0,16,16,0,3,16,262145,0,0,2,20,1,21,0,0,0]

theorem envBound2048 : H12AffineFastState.Bounded env2048 := by
  intro p hp
  have h : env2048.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2047_2048 : H12AffineEnvironment.transform 2 2 env2047 = env2048 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 2 env2047 == env2048) = true)

def env2049 : List Nat := [2,4,2,0,2,0,3,5,0,5,0,1,2,0,1,0,1,262144,5,1,0,0,0,0,3,0,262145,0,0,2,4,1,5,0,0,0]

theorem envBound2049 : H12AffineFastState.Bounded env2049 := by
  intro p hp
  have h : env2049.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2048_2049 : H12AffineEnvironment.transform 3 0 env2048 = env2049 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env2048 == env2049) = true)

theorem identity2049 : scanCanonicalize (H12AffineFastState.compose env2049 (packedSelected [2] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound2049 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2050 : List Nat := [1,4,1,0,1,0,0,5,0,5,0,1,1,0,1,0,1,262144,5,1,0,0,0,0,0,0,262145,0,0,1,4,1,5,0,0,0]

theorem envBound2050 : H12AffineFastState.Bounded env2050 := by
  intro p hp
  have h : env2050.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2049_2050 : H12AffineEnvironment.transform 0 1 env2049 = env2050 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env2049 == env2050) = true)

theorem identity2050 : scanCanonicalize (H12AffineFastState.compose env2050 (packedSelected [9] rootPS)) = affineNative (2^(17+1) ^^^ 0) := by decide +kernel

theorem selectedBound2050 : packedSelected [9] rootPS < 2^1333 := by decide +kernel

def env2051 : List Nat := [1,4,1,0,1,0,0,5,0,5,0,1,1,0,1,0,1,0,5,1,0,0,0,0,0,0,1,0,0,1,4,1,5,0,0,0]

theorem envBound2051 : H12AffineFastState.Bounded env2051 := by
  intro p hp
  have h : env2051.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2050_2051 : H12AffineEnvironment.transform 17 0 env2050 = env2051 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env2050 == env2051) = true)

def leafEnv2051 : List Nat := [1,4,1,0,1,0,0,5,0,5,0,1,1,0,1,0,1,0,5,1,0,0,0,0,4,0,1,0,1,0,0,1,4,1,5,0,4,1,0,0,0,0,1]

def active2051 : List Nat := [1]

def tree2051 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2051 : H12WitnessSearch.Good tree2051 := H12GlobalWitnessIndex.good

theorem leafIdentity2051 : H12AffineFastState.composeSystem env2051 rootObs = leafEnv2051 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2051 rootObs == leafEnv2051) = true)

theorem terminalChecked2051 : H12PackedTerminal.terminalCheckFast leafEnv2051 active2051 tree2051 = true := by decide +kernel

def env2052 : List Nat := [2,4,2,1,3,1,3,4,0,5,0,1,2,0,0,0,1,262144,5,0,0,1,1,0,3,1,262145,0,0,2,5,1,4,0,0,0]

theorem envBound2052 : H12AffineFastState.Bounded env2052 := by
  intro p hp
  have h : env2052.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2048_2052 : H12AffineEnvironment.transform 3 1 env2048 = env2052 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env2048 == env2052) = true)

def env2053 : List Nat := [2,4,2,1,3,1,3,4,0,5,0,1,2,0,0,0,1,0,5,0,0,1,1,0,3,1,1,0,0,2,5,1,4,0,0,0]

theorem envBound2053 : H12AffineFastState.Bounded env2053 := by
  intro p hp
  have h : env2053.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2052_2053 : H12AffineEnvironment.transform 17 0 env2052 = env2053 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 0 env2052 == env2053) = true)

theorem identity2053 : scanCanonicalize (H12AffineFastState.compose env2053 (packedSelected [9] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound2053 : packedSelected [9] rootPS < 2^1333 := by decide +kernel

def env2054 : List Nat := [1,4,1,1,0,1,0,4,0,5,0,1,1,0,0,0,1,0,5,0,0,1,1,0,0,1,1,0,0,1,5,1,4,0,0,0]

theorem envBound2054 : H12AffineFastState.Bounded env2054 := by
  intro p hp
  have h : env2054.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2053_2054 : H12AffineEnvironment.transform 0 1 env2053 = env2054 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env2053 == env2054) = true)

def leafEnv2054 : List Nat := [1,4,1,1,0,1,0,4,0,5,0,1,1,0,0,0,1,0,5,0,0,1,1,0,5,0,1,1,1,0,0,1,5,1,4,0,4,1,0,0,0,0,1]

def active2054 : List Nat := [1]

def tree2054 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2054 : H12WitnessSearch.Good tree2054 := H12GlobalWitnessIndex.good

theorem leafIdentity2054 : H12AffineFastState.composeSystem env2054 rootObs = leafEnv2054 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2054 rootObs == leafEnv2054) = true)

theorem terminalChecked2054 : H12PackedTerminal.terminalCheckFast leafEnv2054 active2054 tree2054 = true := by decide +kernel

def env2055 : List Nat := [2,4,2,1,3,1,3,4,0,5,0,1,2,0,0,0,1,1,5,0,0,1,1,0,3,1,0,0,0,2,5,1,4,0,0,0]

theorem envBound2055 : H12AffineFastState.Bounded env2055 := by
  intro p hp
  have h : env2055.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2052_2055 : H12AffineEnvironment.transform 17 1 env2052 = env2055 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1 env2052 == env2055) = true)

def env2056 : List Nat := [2,4,8,16,32,16,9,39,512,55,1,1,8,0,35,50,1,262144,55,35,0,34,16,50,9,16,262145,0,0,49,20,51,39,0,0,512]

theorem envBound2056 : H12AffineFastState.Bounded env2056 := by
  intro p hp
  have h : env2056.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2044_2056 : H12AffineEnvironment.transform 10 1 env2044 = env2056 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1 env2044 == env2056) = true)

theorem identity2056 : scanCanonicalize (H12AffineFastState.compose env2056 (packedSelected [0] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound2056 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2057 : List Nat := [1,4,8,16,32,16,9,36,512,52,1,1,8,0,32,49,1,262144,52,32,0,33,16,49,9,16,262145,0,0,49,20,48,36,0,0,512]

theorem envBound2057 : H12AffineFastState.Bounded env2057 := by
  intro p hp
  have h : env2057.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2056_2057 : H12AffineEnvironment.transform 0 1 env2056 = env2057 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env2056 == env2057) = true)

theorem identity2057 : scanCanonicalize (H12AffineFastState.compose env2057 (packedSelected [2] rootPS)) = affineNative (2^(8+1) ^^^ 49) := by decide +kernel

theorem selectedBound2057 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2058 : List Nat := [1,4,8,16,32,16,9,36,49,52,1,1,8,0,32,49,1,262144,52,32,0,33,16,49,9,16,262145,0,0,49,20,48,36,0,0,49]

theorem envBound2058 : H12AffineFastState.Bounded env2058 := by
  intro p hp
  have h : env2058.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2057_2058 : H12AffineEnvironment.transform 8 49 env2057 = env2058 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 49 env2057 == env2058) = true)

theorem identity2058 : scanCanonicalize (H12AffineFastState.compose env2058 (packedSelected [4,11,18] rootPS)) = affineNative (2^(17+1) ^^^ 9) := by decide +kernel

theorem selectedBound2058 : packedSelected [4,11,18] rootPS < 2^1333 := by decide +kernel

def env2059 : List Nat := [1,4,8,16,32,16,9,36,49,52,1,1,8,0,32,49,1,9,52,32,0,33,16,49,9,16,8,0,0,49,20,48,36,0,0,49]

theorem envBound2059 : H12AffineFastState.Bounded env2059 := by
  intro p hp
  have h : env2059.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2058_2059 : H12AffineEnvironment.transform 17 9 env2058 = env2059 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 9 env2058 == env2059) = true)

theorem identity2059 : scanCanonicalize (H12AffineFastState.compose env2059 (packedSelected [4,11,23] rootPS)) = affineNative (2^(2+1) ^^^ 0) := by decide +kernel

theorem selectedBound2059 : packedSelected [4,11,23] rootPS < 2^1333 := by decide +kernel

def env2060 : List Nat := [1,4,0,16,32,16,1,36,49,52,1,1,0,0,32,49,1,1,52,32,0,33,16,49,1,16,0,0,0,49,20,48,36,0,0,49]

theorem envBound2060 : H12AffineFastState.Bounded env2060 := by
  intro p hp
  have h : env2060.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2059_2060 : H12AffineEnvironment.transform 2 0 env2059 = env2060 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env2059 == env2060) = true)

theorem identity2060 : scanCanonicalize (H12AffineFastState.compose env2060 (packedSelected [11] rootPS)) = affineNative (2^(4+1) ^^^ 17) := by decide +kernel

theorem selectedBound2060 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env2061 : List Nat := [1,4,0,16,17,16,1,21,0,5,1,1,0,0,17,0,1,1,5,17,0,16,16,0,1,16,0,0,0,0,20,1,21,0,0,0]

theorem envBound2061 : H12AffineFastState.Bounded env2061 := by
  intro p hp
  have h : env2061.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2060_2061 : H12AffineEnvironment.transform 4 17 env2060 = env2061 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env2060 == env2061) = true)

def leafEnv2061 : List Nat := [1,4,0,16,17,16,1,21,0,5,1,1,0,0,17,0,1,1,5,17,0,16,16,0,20,1,1,16,0,0,0,0,20,1,21,0,4,1,0,0,0,0,1]

def active2061 : List Nat := [1,3]

def tree2061 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2061 : H12WitnessSearch.Good tree2061 := H12GlobalWitnessIndex.good

theorem leafIdentity2061 : H12AffineFastState.composeSystem env2061 rootObs = leafEnv2061 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2061 rootObs == leafEnv2061) = true)

theorem terminalChecked2061 : H12PackedTerminal.terminalCheckFast leafEnv2061 active2061 tree2061 = true := by decide +kernel

def env2062 : List Nat := [2,4,8,16,32,16,128,256,512,273,2048,0,8,1,260,51,0,262144,273,260,1,396,16,51,128,16,262280,1,1,2097,21,277,256,0,1,512]

theorem envBound2062 : H12AffineFastState.Bounded env2062 := by
  intro p hp
  have h : env2062.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2023_2062 : H12AffineEnvironment.transform 9 273 env2023 = env2062 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 273 env2023 == env2062) = true)

theorem identity2062 : scanCanonicalize (H12AffineFastState.compose env2062 (packedSelected [1] rootPS)) = affineNative (2^(17+1) ^^^ 2340) := by decide +kernel

theorem selectedBound2062 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2063 : List Nat := [2,4,8,16,32,16,128,256,512,273,2048,0,8,1,260,51,0,2340,273,260,1,396,16,51,128,16,2476,1,1,2097,21,277,256,0,1,512]

theorem envBound2063 : H12AffineFastState.Bounded env2063 := by
  intro p hp
  have h : env2063.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2062_2063 : H12AffineEnvironment.transform 17 2340 env2062 = env2063 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 2340 env2062 == env2063) = true)

theorem identity2063 : scanCanonicalize (H12AffineFastState.compose env2063 (packedSelected [3] rootPS)) = affineNative (2^(6+1) ^^^ 57) := by decide +kernel

theorem selectedBound2063 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env2064 : List Nat := [2,4,8,16,32,16,57,256,512,273,2048,0,8,1,260,51,0,2340,273,260,1,309,16,51,57,16,2325,1,1,2097,21,277,256,0,1,512]

theorem envBound2064 : H12AffineFastState.Bounded env2064 := by
  intro p hp
  have h : env2064.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2063_2064 : H12AffineEnvironment.transform 6 57 env2063 = env2064 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 57 env2063 == env2064) = true)

theorem identity2064 : scanCanonicalize (H12AffineFastState.compose env2064 (packedSelected [0,2,4,11] rootPS)) = affineNative (2^(10+1) ^^^ 798) := by decide +kernel

theorem selectedBound2064 : packedSelected [0,2,4,11] rootPS < 2^1333 := by decide +kernel

def env2065 : List Nat := [2,4,8,16,32,16,57,256,512,273,798,0,8,1,260,51,0,570,273,260,1,309,16,51,57,16,523,1,1,815,21,277,256,0,1,512]

theorem envBound2065 : H12AffineFastState.Bounded env2065 := by
  intro p hp
  have h : env2065.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2064_2065 : H12AffineEnvironment.transform 10 798 env2064 = env2065 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 798 env2064 == env2065) = true)

def env2066 : List Nat := [2,4,8,16,16,16,9,256,512,273,798,0,8,1,260,3,0,522,273,260,1,261,16,3,9,16,523,1,1,799,21,277,256,0,1,512]

theorem envBound2066 : H12AffineFastState.Bounded env2066 := by
  intro p hp
  have h : env2066.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2065_2066 : H12AffineEnvironment.transform 4 16 env2065 = env2066 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 16 env2065 == env2066) = true)

theorem identity2066 : scanCanonicalize (H12AffineFastState.compose env2066 (packedSelected [0] rootPS)) = affineNative (2^(0+1) ^^^ 0) := by decide +kernel

theorem selectedBound2066 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2067 : List Nat := [0,4,8,16,16,16,9,256,512,273,796,0,8,1,260,1,0,520,273,260,1,261,16,1,9,16,521,1,1,797,21,277,256,0,1,512]

theorem envBound2067 : H12AffineFastState.Bounded env2067 := by
  intro p hp
  have h : env2067.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2066_2067 : H12AffineEnvironment.transform 0 0 env2066 = env2067 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 0 env2066 == env2067) = true)

theorem identity2067 : scanCanonicalize (H12AffineFastState.compose env2067 (packedSelected [7] rootPS)) = affineNative (2^(7+1) ^^^ 20) := by decide +kernel

theorem selectedBound2067 : packedSelected [7] rootPS < 2^1333 := by decide +kernel

def env2068 : List Nat := [0,4,8,16,16,16,9,20,512,5,520,0,8,1,16,1,0,520,5,16,1,17,16,1,9,16,521,1,1,521,21,1,20,0,1,512]

theorem envBound2068 : H12AffineFastState.Bounded env2068 := by
  intro p hp
  have h : env2068.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2067_2068 : H12AffineEnvironment.transform 7 20 env2067 = env2068 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 20 env2067 == env2068) = true)

theorem identity2068 : scanCanonicalize (H12AffineFastState.compose env2068 (packedSelected [2] rootPS)) = affineNative (2^(8+1) ^^^ 0) := by decide +kernel

theorem selectedBound2068 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2069 : List Nat := [0,4,8,16,16,16,9,20,0,5,8,0,8,1,16,1,0,8,5,16,1,17,16,1,9,16,9,1,1,9,21,1,20,0,1,0]

theorem envBound2069 : H12AffineFastState.Bounded env2069 := by
  intro p hp
  have h : env2069.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2068_2069 : H12AffineEnvironment.transform 8 0 env2068 = env2069 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 0 env2068 == env2069) = true)

def leafEnv2069 : List Nat := [0,4,8,16,16,16,9,20,0,5,8,0,8,1,16,1,0,8,5,16,1,17,16,1,21,9,1,16,9,1,1,9,21,1,20,0,4,0,1,0,0,1,1]

def active2069 : List Nat := [1,2,3]

def tree2069 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2069 : H12WitnessSearch.Good tree2069 := H12GlobalWitnessIndex.good

theorem leafIdentity2069 : H12AffineFastState.composeSystem env2069 rootObs = leafEnv2069 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2069 rootObs == leafEnv2069) = true)

theorem terminalChecked2069 : H12PackedTerminal.terminalCheckFast leafEnv2069 active2069 tree2069 = true := by decide +kernel

def env2070 : List Nat := [2,4,8,16,17,16,8,256,512,273,798,0,8,1,260,2,0,523,273,260,1,260,16,2,8,16,523,1,1,798,21,277,256,0,1,512]

theorem envBound2070 : H12AffineFastState.Bounded env2070 := by
  intro p hp
  have h : env2070.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2065_2070 : H12AffineEnvironment.transform 4 17 env2065 = env2070 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 17 env2065 == env2070) = true)

theorem identity2070 : scanCanonicalize (H12AffineFastState.compose env2070 (packedSelected [0] rootPS)) = affineNative (2^(8+1) ^^^ 25) := by decide +kernel

theorem selectedBound2070 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2071 : List Nat := [2,4,8,16,17,16,8,256,25,273,263,0,8,1,260,2,0,18,273,260,1,260,16,2,8,16,18,1,1,263,21,277,256,0,1,25]

theorem envBound2071 : H12AffineFastState.Bounded env2071 := by
  intro p hp
  have h : env2071.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2070_2071 : H12AffineEnvironment.transform 8 25 env2070 = env2071 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 25 env2070 == env2071) = true)

def env2072 : List Nat := [2,4,8,0,1,0,8,256,9,257,263,0,8,1,260,2,0,2,257,260,1,260,0,2,8,0,2,1,1,263,5,261,256,0,1,9]

theorem envBound2072 : H12AffineFastState.Bounded env2072 := by
  intro p hp
  have h : env2072.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2071_2072 : H12AffineEnvironment.transform 3 0 env2071 = env2072 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 0 env2071 == env2072) = true)

theorem identity2072 : scanCanonicalize (H12AffineFastState.compose env2072 (packedSelected [2] rootPS)) = affineNative (2^(7+1) ^^^ 12) := by decide +kernel

theorem selectedBound2072 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2073 : List Nat := [2,4,8,0,1,0,8,12,9,13,11,0,8,1,8,2,0,2,13,8,1,8,0,2,8,0,2,1,1,11,5,9,12,0,1,9]

theorem envBound2073 : H12AffineFastState.Bounded env2073 := by
  intro p hp
  have h : env2073.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2072_2073 : H12AffineEnvironment.transform 7 12 env2072 = env2073 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 12 env2072 == env2073) = true)

def env2074 : List Nat := [2,4,0,0,1,0,0,4,1,5,3,0,0,1,0,2,0,2,5,0,1,0,0,2,0,0,2,1,1,3,5,1,4,0,1,1]

theorem envBound2074 : H12AffineFastState.Bounded env2074 := by
  intro p hp
  have h : env2074.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2073_2074 : H12AffineEnvironment.transform 2 0 env2073 = env2074 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 0 env2073 == env2074) = true)

def leafEnv2074 : List Nat := [2,4,0,0,1,0,0,4,1,5,3,0,0,1,0,2,0,2,5,0,1,0,0,2,5,0,1,0,2,1,1,3,5,1,4,0,4,2,1,1,0,1,1]

def active2074 : List Nat := [0,1]

def tree2074 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2074 : H12WitnessSearch.Good tree2074 := H12GlobalWitnessIndex.good

theorem leafIdentity2074 : H12AffineFastState.composeSystem env2074 rootObs = leafEnv2074 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2074 rootObs == leafEnv2074) = true)

theorem terminalChecked2074 : H12PackedTerminal.terminalCheckFast leafEnv2074 active2074 tree2074 = true := by decide +kernel

def env2075 : List Nat := [2,4,1,0,1,0,1,5,0,4,2,0,1,1,1,2,0,2,4,1,1,1,0,2,1,0,2,1,1,2,5,0,5,0,1,0]

theorem envBound2075 : H12AffineFastState.Bounded env2075 := by
  intro p hp
  have h : env2075.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2073_2075 : H12AffineEnvironment.transform 2 1 env2073 = env2075 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env2073 == env2075) = true)

theorem identity2075 : scanCanonicalize (H12AffineFastState.compose env2075 (packedSelected [4] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound2075 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env2076 : List Nat := [1,4,1,0,1,0,1,5,0,4,1,0,1,1,1,1,0,1,4,1,1,1,0,1,1,0,1,1,1,1,5,0,5,0,1,0]

theorem envBound2076 : H12AffineFastState.Bounded env2076 := by
  intro p hp
  have h : env2076.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2075_2076 : H12AffineEnvironment.transform 0 1 env2075 = env2076 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env2075 == env2076) = true)

def leafEnv2076 : List Nat := [1,4,1,0,1,0,1,5,0,4,1,0,1,1,1,1,0,1,4,1,1,1,0,1,5,1,1,0,1,1,1,1,5,0,5,0,4,1,1,0,0,1,1]

def active2076 : List Nat := [1]

def tree2076 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2076 : H12WitnessSearch.Good tree2076 := H12GlobalWitnessIndex.good

theorem leafIdentity2076 : H12AffineFastState.composeSystem env2076 rootObs = leafEnv2076 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2076 rootObs == leafEnv2076) = true)

theorem terminalChecked2076 : H12PackedTerminal.terminalCheckFast leafEnv2076 active2076 tree2076 = true := by decide +kernel

def env2077 : List Nat := [2,4,8,1,0,1,8,256,8,256,263,0,8,1,260,2,0,3,256,260,1,260,1,2,8,1,3,1,1,263,4,260,256,0,1,8]

theorem envBound2077 : H12AffineFastState.Bounded env2077 := by
  intro p hp
  have h : env2077.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2071_2077 : H12AffineEnvironment.transform 3 1 env2071 = env2077 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 1 env2071 == env2077) = true)

theorem identity2077 : scanCanonicalize (H12AffineFastState.compose env2077 (packedSelected [2] rootPS)) = affineNative (2^(2+1) ^^^ 1) := by decide +kernel

theorem selectedBound2077 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2078 : List Nat := [2,4,1,1,0,1,1,256,1,256,263,0,1,1,260,2,0,3,256,260,1,260,1,2,1,1,3,1,1,263,4,260,256,0,1,1]

theorem envBound2078 : H12AffineFastState.Bounded env2078 := by
  intro p hp
  have h : env2078.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2077_2078 : H12AffineEnvironment.transform 2 1 env2077 = env2078 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 2 1 env2077 == env2078) = true)

def env2079 : List Nat := [2,4,1,1,0,1,1,4,1,4,3,0,1,1,0,2,0,3,4,0,1,0,1,2,1,1,3,1,1,3,4,0,4,0,1,1]

theorem envBound2079 : H12AffineFastState.Bounded env2079 := by
  intro p hp
  have h : env2079.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2078_2079 : H12AffineEnvironment.transform 7 4 env2078 = env2079 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 4 env2078 == env2079) = true)

theorem identity2079 : scanCanonicalize (H12AffineFastState.compose env2079 (packedSelected [4] rootPS)) = affineNative (2^(0+1) ^^^ 1) := by decide +kernel

theorem selectedBound2079 : packedSelected [4] rootPS < 2^1333 := by decide +kernel

def env2080 : List Nat := [1,4,1,1,0,1,1,4,1,4,0,0,1,1,0,1,0,0,4,0,1,0,1,1,1,1,0,1,1,0,4,0,4,0,1,1]

theorem envBound2080 : H12AffineFastState.Bounded env2080 := by
  intro p hp
  have h : env2080.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2079_2080 : H12AffineEnvironment.transform 0 1 env2079 = env2080 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 0 1 env2079 == env2080) = true)

def leafEnv2080 : List Nat := [1,4,1,1,0,1,1,4,1,4,0,0,1,1,0,1,0,0,4,0,1,0,1,1,4,1,1,1,0,1,1,0,4,0,4,0,4,1,1,1,0,1,1]

def active2080 : List Nat := [1]

def tree2080 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2080 : H12WitnessSearch.Good tree2080 := H12GlobalWitnessIndex.good

theorem leafIdentity2080 : H12AffineFastState.composeSystem env2080 rootObs = leafEnv2080 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2080 rootObs == leafEnv2080) = true)

theorem terminalChecked2080 : H12PackedTerminal.terminalCheckFast leafEnv2080 active2080 tree2080 = true := by decide +kernel

def env2081 : List Nat := [2,4,1,1,0,1,1,5,1,5,2,0,1,1,1,2,0,3,5,1,1,1,1,2,1,1,3,1,1,2,4,1,5,0,1,1]

theorem envBound2081 : H12AffineFastState.Bounded env2081 := by
  intro p hp
  have h : env2081.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2078_2081 : H12AffineEnvironment.transform 7 5 env2078 = env2081 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env2078 == env2081) = true)

def leafEnv2081 : List Nat := [2,4,1,1,0,1,1,5,1,5,2,0,1,1,1,2,0,3,5,1,1,1,1,2,4,1,1,1,3,1,1,2,4,1,5,0,4,2,1,1,0,1,1]

def active2081 : List Nat := [0,1]

def tree2081 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2081 : H12WitnessSearch.Good tree2081 := H12GlobalWitnessIndex.good

theorem leafIdentity2081 : H12AffineFastState.composeSystem env2081 rootObs = leafEnv2081 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2081 rootObs == leafEnv2081) = true)

theorem terminalChecked2081 : H12PackedTerminal.terminalCheckFast leafEnv2081 active2081 tree2081 = true := by decide +kernel

def env2082 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,32768,65536,1345,262144,1025,32768,1297,41088,64,98565,8329,16,303493,1344,1297,75787,1284,4294967296,257,4295041327,1344,513]

theorem envBound2082 : H12AffineFastState.Bounded env2082 := by
  intro p hp
  have h : env2082.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2017_2082 : H12AffineEnvironment.transform 18 1025 env2017 = env2082 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env2017 == env2082) = true)

theorem identity2082 : scanCanonicalize (H12AffineFastState.compose env2082 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 304635) := by decide +kernel

theorem selectedBound2082 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env2083 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,32768,65536,1345,262144,1025,32768,1297,41088,64,98565,8329,16,303493,1344,1297,75787,1284,304635,257,361684,1344,513]

theorem envBound2083 : H12AffineFastState.Bounded env2083 := by
  intro p hp
  have h : env2083.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2082_2083 : H12AffineEnvironment.transform 31 304635 env2082 = env2083 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 304635 env2082 == env2083) = true)

theorem identity2083 : scanCanonicalize (H12AffineFastState.compose env2083 (packedSelected [5,8] rootPS)) = affineNative (2^(17+1) ^^^ 76199) := by decide +kernel

theorem selectedBound2083 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env2084 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,32768,65536,1345,76199,1025,32768,1297,41088,64,98565,8329,16,100386,1344,1297,75787,1284,101468,257,44403,1344,513]

theorem envBound2084 : H12AffineFastState.Bounded env2084 := by
  intro p hp
  have h : env2084.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2083_2084 : H12AffineEnvironment.transform 17 76199 env2083 = env2084 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 76199 env2083 == env2084) = true)

theorem identity2084 : scanCanonicalize (H12AffineFastState.compose env2084 (packedSelected [3,5,10] rootPS)) = affineNative (2^(15+1) ^^^ 36105) := by decide +kernel

theorem selectedBound2084 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env2085 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,32768,36105,1345,42158,1025,32768,1297,41088,64,3084,8329,16,1323,1344,1297,42242,1284,341,257,44403,1344,513]

theorem envBound2085 : H12AffineFastState.Bounded env2085 := by
  intro p hp
  have h : env2085.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2084_2085 : H12AffineEnvironment.transform 15 36105 env2084 = env2085 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 36105 env2084 == env2085) = true)

theorem identity2085 : scanCanonicalize (H12AffineFastState.compose env2085 (packedSelected [3,5,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 8353) := by decide +kernel

theorem selectedBound2085 : packedSelected [3,5,12,13] rootPS < 2^1333 := by decide +kernel

def env2086 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,8353,11688,1345,1039,1025,8353,1297,33,64,3084,8329,16,1323,1344,1297,1443,1284,341,257,3538,1344,513]

theorem envBound2086 : H12AffineFastState.Bounded env2086 := by
  intro p hp
  have h : env2086.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2085_2086 : H12AffineEnvironment.transform 14 8353 env2085 = env2086 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8353 env2085 == env2086) = true)

theorem identity2086 : scanCanonicalize (H12AffineFastState.compose env2086 (packedSelected [3,5,12,17] rootPS)) = affineNative (2^(10+1) ^^^ 1158) := by decide +kernel

theorem selectedBound2086 : packedSelected [3,5,12,17] rootPS < 2^1333 := by decide +kernel

def env2087 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1158,1297,8192,1344,8353,8494,1345,1039,1025,8353,1297,33,64,138,8329,16,1323,1344,1297,1443,1284,341,257,340,1344,513]

theorem envBound2087 : H12AffineFastState.Bounded env2087 := by
  intro p hp
  have h : env2087.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2086_2087 : H12AffineEnvironment.transform 10 1158 env2086 = env2087 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1158 env2086 == env2087) = true)

theorem identity2087 : scanCanonicalize (H12AffineFastState.compose env2087 (packedSelected [1,3] rootPS)) = affineNative (2^(12+1) ^^^ 1419) := by decide +kernel

theorem selectedBound2087 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env2088 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1158,1297,1419,1344,1322,1189,1345,1039,1025,1322,1297,33,64,138,1282,16,1323,1344,1297,1443,1284,341,257,340,1344,513]

theorem envBound2088 : H12AffineFastState.Bounded env2088 := by
  intro p hp
  have h : env2088.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2087_2088 : H12AffineEnvironment.transform 12 1419 env2087 = env2088 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1419 env2087 == env2088) = true)

theorem identity2088 : scanCanonicalize (H12AffineFastState.compose env2088 (packedSelected [0,4] rootPS)) = affineNative (2^(8+1) ^^^ 260) := by decide +kernel

theorem selectedBound2088 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env2089 : List Nat := [2,4,8,16,32,64,128,256,260,1024,1158,1297,1419,1344,1322,1189,1345,1039,1025,1322,1297,33,64,138,1282,16,1323,1344,1297,1443,1284,341,257,340,1344,261]

theorem envBound2089 : H12AffineFastState.Bounded env2089 := by
  intro p hp
  have h : env2089.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2088_2089 : H12AffineEnvironment.transform 8 260 env2088 = env2089 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 260 env2088 == env2089) = true)

theorem identity2089 : scanCanonicalize (H12AffineFastState.compose env2089 (packedSelected [0,2,7] rootPS)) = affineNative (2^(6+1) ^^^ 41) := by decide +kernel

theorem selectedBound2089 : packedSelected [0,2,7] rootPS < 2^1333 := by decide +kernel

def env2090 : List Nat := [2,4,8,16,32,64,41,256,260,1024,1071,1297,1314,1344,1322,1036,1345,1039,1025,1322,1297,33,64,35,1282,16,1323,1344,1297,1290,1284,341,257,340,1344,261]

theorem envBound2090 : H12AffineFastState.Bounded env2090 := by
  intro p hp
  have h : env2090.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2089_2090 : H12AffineEnvironment.transform 6 41 env2089 = env2090 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 41 env2089 == env2090) = true)

theorem identity2090 : scanCanonicalize (H12AffineFastState.compose env2090 (packedSelected [0,2] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound2090 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env2091 : List Nat := [2,4,8,16,1,64,8,256,260,1024,1038,1297,1283,1344,1291,1036,1345,1039,1025,1291,1297,0,64,2,1282,16,1290,1344,1297,1290,1284,341,257,340,1344,261]

theorem envBound2091 : H12AffineFastState.Bounded env2091 := by
  intro p hp
  have h : env2091.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2090_2091 : H12AffineEnvironment.transform 4 1 env2090 = env2091 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env2090 == env2091) = true)

theorem identity2091 : scanCanonicalize (H12AffineFastState.compose env2091 (packedSelected [0] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound2091 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2092 : List Nat := [2,4,8,16,1,64,8,5,1,1024,1038,1044,1030,1093,1038,1036,1092,1039,1025,1038,1044,0,64,2,1031,16,1039,1093,1044,1039,1025,80,4,81,1093,0]

theorem envBound2092 : H12AffineFastState.Bounded env2092 := by
  intro p hp
  have h : env2092.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2091_2092 : H12AffineEnvironment.transform 7 5 env2091 = env2092 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env2091 == env2092) = true)

def leafEnv2092 : List Nat := [2,4,8,16,1,64,8,5,1,1024,1038,1044,1030,1093,1038,1036,1092,1039,1025,1038,1044,0,64,2,1025,1031,1,16,1039,1093,1044,1039,1025,80,4,81,4,1037,1093,0,0,1045,1]

def active2092 : List Nat := [0,1,2,3,5,9]

def tree2092 : H12WitnessSearch.Tree := H12GlobalWitnessIndex.tree

theorem treeGood2092 : H12WitnessSearch.Good tree2092 := H12GlobalWitnessIndex.good

theorem leafIdentity2092 : H12AffineFastState.composeSystem env2092 rootObs = leafEnv2092 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineFastState.composeSystem env2092 rootObs == leafEnv2092) = true)

theorem terminalChecked2092 : H12PackedTerminal.terminalCheckFast leafEnv2092 active2092 tree2092 = true := by decide +kernel

def env2093 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,32768,65536,131072,262144,524288,32768,524560,4194304,64,753733,4752393,16,5111877,1344,656465,4820106,131141,4294967296,525568,4295696494,131073,4761217]

theorem envBound2093 : H12AffineFastState.Bounded env2093 := by
  intro p hp
  have h : env2093.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2014_2093 : H12AffineEnvironment.transform 24 4752393 env2014 = env2093 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 4752393 env2014 == env2093) = true)

theorem identity2093 : scanCanonicalize (H12AffineFastState.compose env2093 (packedSelected [0,1,3,5,7,8,9,10,19,20,22] rootPS)) = affineNative (2^(18+1) ^^^ 1025) := by decide +kernel

theorem selectedBound2093 : packedSelected [0,1,3,5,7,8,9,10,19,20,22] rootPS < 2^1333 := by decide +kernel

def env2094 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,32768,65536,131072,262144,1025,32768,1297,4194304,64,230468,4227080,16,4588612,1344,131152,4294795,131141,4294967296,257,4295173231,131073,4235904]

theorem envBound2094 : H12AffineFastState.Bounded env2094 := by
  intro p hp
  have h : env2094.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2093_2094 : H12AffineEnvironment.transform 18 1025 env2093 = env2094 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1025 env2093 == env2094) = true)

theorem identity2094 : scanCanonicalize (H12AffineFastState.compose env2094 (packedSelected [1,3,5,8,10,19] rootPS)) = affineNative (2^(21+1) ^^^ 173504) := by decide +kernel

theorem selectedBound2094 : packedSelected [1,3,5,8,10,19] rootPS < 2^1333 := by decide +kernel

def env2095 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,32768,65536,131072,262144,1025,32768,1297,173504,64,230468,140744,16,303492,1344,131152,208203,131141,4294967296,257,4295173231,131073,132928]

theorem envBound2095 : H12AffineFastState.Bounded env2095 := by
  intro p hp
  have h : env2095.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2094_2095 : H12AffineEnvironment.transform 21 173504 env2094 = env2095 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 173504 env2094 == env2095) = true)

theorem identity2095 : scanCanonicalize (H12AffineFastState.compose env2095 (packedSelected [4,5,8,9,13,16,17] rootPS)) = affineNative (2^(31+1) ^^^ 206139) := by decide +kernel

theorem selectedBound2095 : packedSelected [4,5,8,9,13,16,17] rootPS < 2^1333 := by decide +kernel

def env2096 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,32768,65536,131072,262144,1025,32768,1297,173504,64,230468,140744,16,303492,1344,131152,208203,131141,206139,257,340,131073,132928]

theorem envBound2096 : H12AffineFastState.Bounded env2096 := by
  intro p hp
  have h : env2096.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2095_2096 : H12AffineEnvironment.transform 31 206139 env2095 = env2096 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 206139 env2095 == env2096) = true)

theorem identity2096 : scanCanonicalize (H12AffineFastState.compose env2096 (packedSelected [13,21] rootPS)) = affineNative (2^(15+1) ^^^ 8495) := by decide +kernel

theorem selectedBound2096 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env2097 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,32768,8495,131072,262144,1025,32768,1297,173504,64,173419,140744,16,303492,1344,131152,134244,131141,132116,257,340,131073,132928]

theorem envBound2097 : H12AffineFastState.Bounded env2097 := by
  intro p hp
  have h : env2097.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2096_2097 : H12AffineEnvironment.transform 15 8495 env2096 = env2097 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 8495 env2096 == env2097) = true)

theorem identity2097 : scanCanonicalize (H12AffineFastState.compose env2097 (packedSelected [3,12,15,24] rootPS)) = affineNative (2^(16+1) ^^^ 1345) := by decide +kernel

theorem selectedBound2097 : packedSelected [3,12,15,24] rootPS < 2^1333 := by decide +kernel

def env2098 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,32768,8495,1345,262144,1025,32768,1297,41089,64,41002,8329,16,303492,1344,1297,2341,1284,341,257,340,1344,513]

theorem envBound2098 : H12AffineFastState.Bounded env2098 := by
  intro p hp
  have h : env2098.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2097_2098 : H12AffineEnvironment.transform 16 1345 env2097 = env2098 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 1345 env2097 == env2098) = true)

theorem identity2098 : scanCanonicalize (H12AffineFastState.compose env2098 (packedSelected [6] rootPS)) = affineNative (2^(17+1) ^^^ 1443) := by decide +kernel

theorem selectedBound2098 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env2099 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1297,8192,1344,32768,8495,1345,1443,1025,32768,1297,41089,64,41002,8329,16,42023,1344,1297,2341,1284,341,257,340,1344,513]

theorem envBound2099 : H12AffineFastState.Bounded env2099 := by
  intro p hp
  have h : env2099.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2098_2099 : H12AffineEnvironment.transform 17 1443 env2098 = env2099 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 1443 env2098 == env2099) = true)

theorem identity2099 : scanCanonicalize (H12AffineFastState.compose env2099 (packedSelected [5,8] rootPS)) = affineNative (2^(10+1) ^^^ 1323) := by decide +kernel

theorem selectedBound2099 : packedSelected [5,8] rootPS < 2^1333 := by decide +kernel

def env2100 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1323,1297,8192,1344,32768,8495,1345,1443,1025,32768,1297,41089,64,41002,8329,16,42023,1344,1297,1038,1284,341,257,340,1344,513]

theorem envBound2100 : H12AffineFastState.Bounded env2100 := by
  intro p hp
  have h : env2100.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2099_2100 : H12AffineEnvironment.transform 10 1323 env2099 = env2100 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1323 env2099 == env2100) = true)

theorem identity2100 : scanCanonicalize (H12AffineFastState.compose env2100 (packedSelected [3,5,12,13] rootPS)) = affineNative (2^(14+1) ^^^ 8352) := by decide +kernel

theorem selectedBound2100 : packedSelected [3,5,12,13] rootPS < 2^1333 := by decide +kernel

def env2101 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1323,1297,8192,1344,8352,8495,1345,1443,1025,8352,1297,33,64,138,8329,16,1159,1344,1297,1038,1284,341,257,340,1344,513]

theorem envBound2101 : H12AffineFastState.Bounded env2101 := by
  intro p hp
  have h : env2101.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2100_2101 : H12AffineEnvironment.transform 14 8352 env2100 = env2101 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 8352 env2100 == env2101) = true)

theorem identity2101 : scanCanonicalize (H12AffineFastState.compose env2101 (packedSelected [1,3] rootPS)) = affineNative (2^(12+1) ^^^ 1062) := by decide +kernel

theorem selectedBound2101 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env2102 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1323,1297,1062,1344,1158,1289,1345,1443,1025,1158,1297,33,64,138,1199,16,1159,1344,1297,1038,1284,341,257,340,1344,513]

theorem envBound2102 : H12AffineFastState.Bounded env2102 := by
  intro p hp
  have h : env2102.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2101_2102 : H12AffineEnvironment.transform 12 1062 env2101 = env2102 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 1062 env2101 == env2102) = true)

theorem identity2102 : scanCanonicalize (H12AffineFastState.compose env2102 (packedSelected [0,4] rootPS)) = affineNative (2^(8+1) ^^^ 260) := by decide +kernel

theorem selectedBound2102 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env2103 : List Nat := [2,4,8,16,32,64,128,256,260,1024,1323,1297,1062,1344,1158,1289,1345,1443,1025,1158,1297,33,64,138,1199,16,1159,1344,1297,1038,1284,341,257,340,1344,261]

theorem envBound2103 : H12AffineFastState.Bounded env2103 := by
  intro p hp
  have h : env2103.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2102_2103 : H12AffineEnvironment.transform 8 260 env2102 = env2103 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 260 env2102 == env2103) = true)

theorem identity2103 : scanCanonicalize (H12AffineFastState.compose env2103 (packedSelected [0,2,7] rootPS)) = affineNative (2^(6+1) ^^^ 41) := by decide +kernel

theorem selectedBound2103 : packedSelected [0,2,7] rootPS < 2^1333 := by decide +kernel

def env2104 : List Nat := [2,4,8,16,32,64,41,256,260,1024,1323,1297,1062,1344,1071,1289,1345,1290,1025,1071,1297,33,64,35,1030,16,1070,1344,1297,1038,1284,341,257,340,1344,261]

theorem envBound2104 : H12AffineFastState.Bounded env2104 := by
  intro p hp
  have h : env2104.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2103_2104 : H12AffineEnvironment.transform 6 41 env2103 = env2104 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 41 env2103 == env2104) = true)

theorem identity2104 : scanCanonicalize (H12AffineFastState.compose env2104 (packedSelected [0,2] rootPS)) = affineNative (2^(7+1) ^^^ 5) := by decide +kernel

theorem selectedBound2104 : packedSelected [0,2] rootPS < 2^1333 := by decide +kernel

def env2105 : List Nat := [2,4,8,16,32,64,41,5,1,1024,1070,1044,1062,1093,1071,1036,1092,1039,1025,1071,1044,33,64,35,1030,16,1070,1093,1044,1038,1025,80,4,81,1093,0]

theorem envBound2105 : H12AffineFastState.Bounded env2105 := by
  intro p hp
  have h : env2105.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2104_2105 : H12AffineEnvironment.transform 7 5 env2104 = env2105 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 5 env2104 == env2105) = true)

theorem identity2105 : scanCanonicalize (H12AffineFastState.compose env2105 (packedSelected [0] rootPS)) = affineNative (2^(4+1) ^^^ 1) := by decide +kernel

theorem selectedBound2105 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2106 : List Nat := [2,4,8,16,1,64,8,5,1,1024,1039,1044,1031,1093,1038,1036,1092,1039,1025,1038,1044,0,64,2,1030,16,1039,1093,1044,1038,1025,80,4,81,1093,0]

theorem envBound2106 : H12AffineFastState.Bounded env2106 := by
  intro p hp
  have h : env2106.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2105_2106 : H12AffineEnvironment.transform 4 1 env2105 = env2106 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 1 env2105 == env2106) = true)

theorem identity2106 : scanCanonicalize (H12AffineFastState.compose env2106 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound2106 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2107 : List Nat := [2,4,8,16,1,16,8,5,1,1024,1039,1044,1031,1045,1038,1036,1044,1039,1025,1038,1044,0,16,2,1030,16,1039,1045,1044,1038,1025,0,4,1,1045,0]

theorem envBound2107 : H12AffineFastState.Bounded env2107 := by
  intro p hp
  have h : env2107.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2106_2107 : H12AffineEnvironment.transform 5 16 env2106 = env2107 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env2106 == env2107) = true)

def env2108 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,134217728,67130625,536870912,1073741824,553878609,4294967296,537002321,4417151346,694534145,33563272]

theorem envBound2108 : H12AffineFastState.Bounded env2108 := by
  intro p hp
  have h : env2108.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans881_2108 : H12AffineEnvironment.transform 34 694534145 env881 = env2108 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 34 694534145 env881 == env2108) = true)

def env2109 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,16777216,33554432,67108864,134217728,67130625,157794304,1073741824,140788817,4294967296,157663569,4417151346,131073,33563272]

theorem envBound2109 : H12AffineFastState.Bounded env2109 := by
  intro p hp
  have h : env2109.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2108_2109 : H12AffineEnvironment.transform 28 157794304 env2108 = env2109 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 28 157794304 env2108 == env2109) = true)

theorem identity2109 : scanCanonicalize (H12AffineFastState.compose env2109 (packedSelected [14] rootPS)) = affineNative (2^(23+1) ^^^ 2331716) := by decide +kernel

theorem selectedBound2109 : packedSelected [14] rootPS < 2^1333 := by decide +kernel

def env2110 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,2097152,4194304,17664,2331716,33554432,67108864,134217728,67130625,138695748,1073741824,140788817,4294967296,138827029,4402705718,131073,33563272]

theorem envBound2110 : H12AffineFastState.Bounded env2110 := by
  intro p hp
  have h : env2110.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2109_2110 : H12AffineEnvironment.transform 23 2331716 env2109 = env2110 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 23 2331716 env2109 == env2110) = true)

def env2111 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4096,4194304,17664,230468,33554432,67108864,134217728,67130625,138695748,1073741824,138695761,4294967296,138827029,4400604470,131073,33563272]

theorem envBound2111 : H12AffineFastState.Bounded env2111 := by
  intro p hp
  have h : env2111.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2110_2111 : H12AffineEnvironment.transform 20 4096 env2110 = env2111 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4096 env2110 == env2111) = true)

def env2112 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,4194304,17664,230469,33554432,67108864,134217728,67130625,138695748,1073741824,138695760,4294967296,138827029,4400604471,131073,33563272]

theorem envBound2112 : H12AffineFastState.Bounded env2112 := by
  intro p hp
  have h : env2112.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2110_2112 : H12AffineEnvironment.transform 20 4097 env2110 = env2112 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 20 4097 env2110 == env2112) = true)

theorem identity2112 : scanCanonicalize (H12AffineFastState.compose env2112 (packedSelected [35] rootPS)) = affineNative (2^(26+1) ^^^ 71713045) := by decide +kernel

theorem selectedBound2112 : packedSelected [35] rootPS < 2^1333 := by decide +kernel

def env2113 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,4194304,17664,230469,33554432,67108864,71713045,67130625,67245393,1073741824,67245381,4294967296,67113984,4400604471,131073,33563272]

theorem envBound2113 : H12AffineFastState.Bounded env2113 := by
  intro p hp
  have h : env2113.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2112_2113 : H12AffineEnvironment.transform 26 71713045 env2112 = env2113 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 26 71713045 env2112 == env2113) = true)

def env2114 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,10248,17664,230469,33554432,67108864,67528989,67130625,67245393,1073741824,67245381,4294967296,67113984,4396404031,131073,33563272]

theorem envBound2114 : H12AffineFastState.Bounded env2114 := by
  intro p hp
  have h : env2114.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2113_2114 : H12AffineEnvironment.transform 21 10248 env2113 = env2114 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 21 10248 env2113 == env2114) = true)

def env2115 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,10248,17664,230469,8328,67108864,67528989,67130625,67245393,1073741824,67245381,4294967296,67113984,4362857911,131073,512]

theorem envBound2115 : H12AffineFastState.Bounded env2115 := by
  intro p hp
  have h : env2115.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2114_2115 : H12AffineEnvironment.transform 24 8328 env2114 = env2115 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8328 env2114 == env2115) = true)

theorem identity2115 : scanCanonicalize (H12AffineFastState.compose env2115 (packedSelected [4,7,9,16,20,27] rootPS)) = affineNative (2^(29+1) ^^^ 67233234) := by decide +kernel

theorem selectedBound2115 : packedSelected [4,7,9,16,20,27] rootPS < 2^1333 := by decide +kernel

def env2116 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,10248,17664,230469,8328,67108864,67528989,67130625,67245393,67233234,67245381,4294967296,67113984,4362857911,131073,512]

theorem envBound2116 : H12AffineFastState.Bounded env2116 := by
  intro p hp
  have h : env2116.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2115_2116 : H12AffineEnvironment.transform 29 67233234 env2115 = env2116 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 67233234 env2115 == env2116) = true)

theorem identity2116 : scanCanonicalize (H12AffineFastState.compose env2116 (packedSelected [1,5,8,19,24,26] rootPS)) = affineNative (2^(16+1) ^^^ 21777) := by decide +kernel

theorem selectedBound2116 : packedSelected [1,5,8,19,24,26] rootPS < 2^1333 := by decide +kernel

def env2117 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,524288,32768,4097,10248,17664,119124,8328,67108864,67386380,67130625,67125312,67233234,67125332,4294967296,67113984,4362713254,21776,512]

theorem envBound2117 : H12AffineFastState.Bounded env2117 := by
  intro p hp
  have h : env2117.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2116_2117 : H12AffineEnvironment.transform 16 21777 env2116 = env2117 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 21777 env2116 == env2117) = true)

theorem identity2117 : scanCanonicalize (H12AffineFastState.compose env2117 (packedSelected [0,6,7,9,20,22,25] rootPS)) = affineNative (2^(18+1) ^^^ 35976) := by decide +kernel

theorem selectedBound2117 : packedSelected [0,6,7,9,20,22,25] rootPS < 2^1333 := by decide +kernel

def env2118 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,35976,32768,4097,10248,17664,119124,8328,67108864,67386380,67130625,67125312,67233234,67125332,4294967296,67113984,4362155054,21776,512]

theorem envBound2118 : H12AffineFastState.Bounded env2118 := by
  intro p hp
  have h : env2118.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2117_2118 : H12AffineEnvironment.transform 18 35976 env2117 = env2118 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 35976 env2117 == env2118) = true)

theorem identity2118 : scanCanonicalize (H12AffineFastState.compose env2118 (packedSelected [3,5,8,10,28,31] rootPS)) = affineNative (2^(25+1) ^^^ 5376) := by decide +kernel

theorem selectedBound2118 : packedSelected [3,5,8,10,28,31] rootPS < 2^1333 := by decide +kernel

def env2119 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,21777,262144,35976,32768,4097,10248,17664,119124,8328,5376,272652,16385,21824,127186,21844,4294967296,256,4295041326,21776,512]

theorem envBound2119 : H12AffineFastState.Bounded env2119 := by
  intro p hp
  have h : env2119.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2118_2119 : H12AffineEnvironment.transform 25 5376 env2118 = env2119 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env2118 == env2119) = true)

theorem identity2119 : scanCanonicalize (H12AffineFastState.compose env2119 (packedSelected [4,9,16] rootPS)) = affineNative (2^(14+1) ^^^ 29020) := by decide +kernel

theorem selectedBound2119 : packedSelected [4,9,16] rootPS < 2^1333 := by decide +kernel

def env2120 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,29020,65536,21777,262144,32212,29020,4097,10248,17664,73736,8328,5376,272652,16385,21824,65934,21844,4294967296,256,4295041326,21776,512]

theorem envBound2120 : H12AffineFastState.Bounded env2120 := by
  intro p hp
  have h : env2120.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2119_2120 : H12AffineEnvironment.transform 14 29020 env2119 = env2120 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 29020 env2119 == env2120) = true)

theorem identity2120 : scanCanonicalize (H12AffineFastState.compose env2120 (packedSelected [1,3,5,8,10,13,19,21] rootPS)) = affineNative (2^(13+1) ^^^ 14805) := by decide +kernel

theorem selectedBound2120 : packedSelected [1,3,5,8,10,13,19,21] rootPS < 2^1333 := by decide +kernel

def env2121 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,14805,2185,65536,11460,262144,1025,2185,4097,10248,15573,73736,8328,5376,272652,14804,11413,65934,11393,4294967296,256,4295041326,11461,512]

theorem envBound2121 : H12AffineFastState.Bounded env2121 := by
  intro p hp
  have h : env2121.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2120_2121 : H12AffineEnvironment.transform 13 14805 env2120 = env2121 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 14805 env2120 == env2121) = true)

theorem identity2121 : scanCanonicalize (H12AffineFastState.compose env2121 (packedSelected [1,3,13,17,24,28] rootPS)) = affineNative (2^(12+1) ^^^ 2437) := by decide +kernel

theorem selectedBound2121 : packedSelected [1,3,13,17,24,28] rootPS < 2^1333 := by decide +kernel

def env2122 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,2437,4176,2185,65536,1345,262144,1025,2185,4097,397,5456,67981,2317,5376,262281,4177,1296,65934,1284,4294967296,256,4295035051,1344,512]

theorem envBound2122 : H12AffineFastState.Bounded env2122 := by
  intro p hp
  have h : env2122.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2121_2122 : H12AffineEnvironment.transform 12 2437 env2121 = env2122 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2437 env2121 == env2122) = true)

theorem identity2122 : scanCanonicalize (H12AffineFastState.compose env2122 (packedSelected [6] rootPS)) = affineNative (2^(31+1) ^^^ 65910) := by decide +kernel

theorem selectedBound2122 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env2123 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,2437,4176,2185,65536,1345,262144,1025,2185,4097,397,5456,67981,2317,5376,262281,4177,1296,65934,1284,65910,256,2525,1344,512]

theorem envBound2123 : H12AffineFastState.Bounded env2123 := by
  intro p hp
  have h : env2123.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2122_2123 : H12AffineEnvironment.transform 31 65910 env2122 = env2123 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 65910 env2122 == env2123) = true)

theorem identity2123 : scanCanonicalize (H12AffineFastState.compose env2123 (packedSelected [3,5,10] rootPS)) = affineNative (2^(15+1) ^^^ 6755) := by decide +kernel

theorem selectedBound2123 : packedSelected [3,5,10] rootPS < 2^1333 := by decide +kernel

def env2124 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,2437,4176,2185,6755,1345,262144,1025,2185,4097,397,5456,5102,2317,5376,262281,4177,1296,7149,1284,6933,256,2525,1344,512]

theorem envBound2124 : H12AffineFastState.Bounded env2124 := by
  intro p hp
  have h : env2124.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2123_2124 : H12AffineEnvironment.transform 15 6755 env2123 = env2124 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 6755 env2123 == env2124) = true)

theorem identity2124 : scanCanonicalize (H12AffineFastState.compose env2124 (packedSelected [1,8,12] rootPS)) = affineNative (2^(11+1) ^^^ 2586) := by decide +kernel

theorem selectedBound2124 : packedSelected [1,8,12] rootPS < 2^1333 := by decide +kernel

def env2125 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,2586,2437,2634,2185,121,1345,262144,1025,2185,2587,397,3914,2548,2317,3866,262281,2635,1296,503,1284,271,256,2525,1344,512]

theorem envBound2125 : H12AffineFastState.Bounded env2125 := by
  intro p hp
  have h : env2125.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2124_2125 : H12AffineEnvironment.transform 11 2586 env2124 = env2125 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 2586 env2124 == env2125) = true)

theorem identity2125 : scanCanonicalize (H12AffineFastState.compose env2125 (packedSelected [3,5,15] rootPS)) = affineNative (2^(17+1) ^^^ 90) := by decide +kernel

theorem selectedBound2125 : packedSelected [3,5,15] rootPS < 2^1333 := by decide +kernel

def env2126 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,2586,2437,2634,2185,121,1345,90,1025,2185,2587,397,3914,2548,2317,3866,211,2635,1296,503,1284,271,256,2525,1344,512]

theorem envBound2126 : H12AffineFastState.Bounded env2126 := by
  intro p hp
  have h : env2126.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2125_2126 : H12AffineEnvironment.transform 17 90 env2125 = env2126 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 90 env2125 == env2126) = true)

theorem identity2126 : scanCanonicalize (H12AffineFastState.compose env2126 (packedSelected [0,11] rootPS)) = affineNative (2^(10+1) ^^^ 1204) := by decide +kernel

theorem selectedBound2126 : packedSelected [0,11] rootPS < 2^1333 := by decide +kernel

def env2127 : List Nat := [2,4,8,16,32,64,128,256,512,1024,1204,1710,1329,1790,1085,121,1345,90,1025,1085,1711,397,1022,1344,1465,942,211,1791,1296,503,1284,271,256,1385,1344,512]

theorem envBound2127 : H12AffineFastState.Bounded env2127 := by
  intro p hp
  have h : env2127.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2126_2127 : H12AffineEnvironment.transform 10 1204 env2126 = env2127 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 1204 env2126 == env2127) = true)

theorem identity2127 : scanCanonicalize (H12AffineFastState.compose env2127 (packedSelected [1,3,13] rootPS)) = affineNative (2^(9+1) ^^^ 172) := by decide +kernel

theorem selectedBound2127 : packedSelected [1,3,13] rootPS < 2^1333 := by decide +kernel

def env2128 : List Nat := [2,4,8,16,32,64,128,256,512,172,24,514,413,594,145,121,493,90,173,145,515,397,1022,492,277,942,211,595,444,503,424,271,256,453,492,512]

theorem envBound2128 : H12AffineFastState.Bounded env2128 := by
  intro p hp
  have h : env2128.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2127_2128 : H12AffineEnvironment.transform 9 172 env2127 = env2128 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 9 172 env2127 == env2128) = true)

theorem identity2128 : scanCanonicalize (H12AffineFastState.compose env2128 (packedSelected [0,2,9,18] rootPS)) = affineNative (2^(8+1) ^^^ 333) := by decide +kernel

theorem selectedBound2128 : packedSelected [0,2,9,18] rootPS < 2^1333 := by decide +kernel

def env2129 : List Nat := [2,4,8,16,32,64,128,256,333,172,24,335,413,287,145,121,493,90,173,145,334,397,179,492,277,227,211,286,444,503,424,271,256,453,492,333]

theorem envBound2129 : H12AffineFastState.Bounded env2129 := by
  intro p hp
  have h : env2129.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2128_2129 : H12AffineEnvironment.transform 8 333 env2128 = env2129 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 333 env2128 == env2129) = true)

theorem identity2129 : scanCanonicalize (H12AffineFastState.compose env2129 (packedSelected [0,7,20] rootPS)) = affineNative (2^(7+1) ^^^ 102) := by decide +kernel

theorem selectedBound2129 : packedSelected [0,7,20] rootPS < 2^1333 := by decide +kernel

def env2130 : List Nat := [2,4,8,16,32,64,128,102,43,172,24,41,251,121,145,121,139,90,173,145,40,235,179,138,115,227,211,120,218,145,206,105,102,163,138,43]

theorem envBound2130 : H12AffineFastState.Bounded env2130 := by
  intro p hp
  have h : env2130.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2129_2130 : H12AffineEnvironment.transform 7 102 env2129 = env2130 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 102 env2129 == env2130) = true)

theorem identity2130 : scanCanonicalize (H12AffineFastState.compose env2130 (packedSelected [0] rootPS)) = affineNative (2^(6+1) ^^^ 115) := by decide +kernel

theorem selectedBound2130 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2131 : List Nat := [2,4,8,16,32,64,115,102,43,95,24,41,8,121,98,121,120,90,94,98,40,24,64,121,115,16,32,120,41,98,61,105,102,80,121,43]

theorem envBound2131 : H12AffineFastState.Bounded env2131 := by
  intro p hp
  have h : env2131.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2130_2131 : H12AffineEnvironment.transform 6 115 env2130 = env2131 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 6 115 env2130 == env2131) = true)

theorem identity2131 : scanCanonicalize (H12AffineFastState.compose env2131 (packedSelected [1] rootPS)) = affineNative (2^(5+1) ^^^ 48) := by decide +kernel

theorem selectedBound2131 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env2132 : List Nat := [2,4,8,16,32,48,3,22,43,47,24,41,8,9,18,9,8,42,46,18,40,24,48,9,3,16,32,8,41,18,61,25,22,32,9,43]

theorem envBound2132 : H12AffineFastState.Bounded env2132 := by
  intro p hp
  have h : env2132.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2131_2132 : H12AffineEnvironment.transform 5 48 env2131 = env2132 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 48 env2131 == env2132) = true)

theorem identity2132 : scanCanonicalize (H12AffineFastState.compose env2132 (packedSelected [2] rootPS)) = affineNative (2^(3+1) ^^^ 3) := by decide +kernel

theorem selectedBound2132 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env2133 : List Nat := [2,4,8,3,32,35,3,5,43,47,11,41,8,9,1,9,8,42,46,1,40,11,35,9,3,3,32,8,41,1,46,10,5,32,9,43]

theorem envBound2133 : H12AffineFastState.Bounded env2133 := by
  intro p hp
  have h : env2133.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2132_2133 : H12AffineEnvironment.transform 3 3 env2132 = env2133 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 3 env2132 == env2133) = true)

theorem identity2133 : scanCanonicalize (H12AffineFastState.compose env2133 (packedSelected [3] rootPS)) = affineNative (2^(4+1) ^^^ 0) := by decide +kernel

theorem selectedBound2133 : packedSelected [3] rootPS < 2^1333 := by decide +kernel

def env2134 : List Nat := [2,4,8,3,0,3,3,5,11,15,11,9,8,9,1,9,8,10,14,1,8,11,3,9,3,3,0,8,9,1,14,10,5,0,9,11]

theorem envBound2134 : H12AffineFastState.Bounded env2134 := by
  intro p hp
  have h : env2134.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2133_2134 : H12AffineEnvironment.transform 4 0 env2133 = env2134 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 4 0 env2133 == env2134) = true)

def env2135 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,32768,4097,10248,17664,230469,8329,67108864,67528989,67130625,67245393,1073741824,67245381,4294967296,67113984,4362857910,131073,513]

theorem envBound2135 : H12AffineFastState.Bounded env2135 := by
  intro p hp
  have h : env2135.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2114_2135 : H12AffineEnvironment.transform 24 8329 env2114 = env2135 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 24 8329 env2114 == env2135) = true)

def env2136 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,10248,5456,230469,8329,67108864,67516749,67110225,67245393,1073741824,67245381,4294967296,67113984,4362845670,131073,513]

theorem envBound2136 : H12AffineFastState.Bounded env2136 := by
  intro p hp
  have h : env2136.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2135_2136 : H12AffineEnvironment.transform 13 4176 env2135 = env2136 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4176 env2135 == env2136) = true)

theorem identity2136 : scanCanonicalize (H12AffineFastState.compose env2136 (packedSelected [1,3,4,5,8,9,10,16,19] rootPS)) = affineNative (2^(29+1) ^^^ 631938) := by decide +kernel

theorem selectedBound2136 : packedSelected [1,3,4,5,8,9,10,16,19] rootPS < 2^1333 := by decide +kernel

def env2137 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,10248,5456,230469,8329,67108864,67516749,67110225,67245393,631938,67245381,4294967296,67113984,4362845670,131073,513]

theorem envBound2137 : H12AffineFastState.Bounded env2137 := by
  intro p hp
  have h : env2137.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2136_2137 : H12AffineEnvironment.transform 29 631938 env2136 = env2137 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 631938 env2136 == env2137) = true)

theorem identity2137 : scanCanonicalize (H12AffineFastState.compose env2137 (packedSelected [0,4,7,16,20,22] rootPS)) = affineNative (2^(25+1) ^^^ 528640) := by decide +kernel

theorem selectedBound2137 : packedSelected [0,4,7,16,20,22] rootPS < 2^1333 := by decide +kernel

def env2138 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,524288,32768,4097,10248,5456,230469,8329,528640,927821,529489,656465,631938,656453,4294967296,525568,4295208166,131073,513]

theorem envBound2138 : H12AffineFastState.Bounded env2138 := by
  intro p hp
  have h : env2138.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2137_2138 : H12AffineEnvironment.transform 25 528640 env2137 = env2138 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 528640 env2137 == env2138) = true)

theorem identity2138 : scanCanonicalize (H12AffineFastState.compose env2138 (packedSelected [3,10,24,26] rootPS)) = affineNative (2^(18+1) ^^^ 1024) := by decide +kernel

theorem selectedBound2138 : packedSelected [3,10,24,26] rootPS < 2^1333 := by decide +kernel

def env2139 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,131072,262144,1024,32768,4097,10248,5456,230469,8329,5376,404557,4177,131153,106626,131141,4294967296,256,4295208166,131073,513]

theorem envBound2139 : H12AffineFastState.Bounded env2139 := by
  intro p hp
  have h : env2139.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2138_2139 : H12AffineEnvironment.transform 18 1024 env2138 = env2139 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 1024 env2138 == env2139) = true)

theorem identity2139 : scanCanonicalize (H12AffineFastState.compose env2139 (packedSelected [13,21] rootPS)) = affineNative (2^(16+1) ^^^ 4176) := by decide +kernel

theorem selectedBound2139 : packedSelected [13,21] rootPS < 2^1333 := by decide +kernel

def env2140 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,65536,4176,262144,1024,32768,4097,10248,5456,103445,8329,5376,277533,4177,4097,106626,4117,4294967296,256,4295081142,4177,513]

theorem envBound2140 : H12AffineFastState.Bounded env2140 := by
  intro p hp
  have h : env2140.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2139_2140 : H12AffineEnvironment.transform 16 4176 env2139 = env2140 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 4176 env2139 == env2140) = true)

theorem identity2140 : scanCanonicalize (H12AffineFastState.compose env2140 (packedSelected [13,17] rootPS)) = affineNative (2^(15+1) ^^^ 38046) := by decide +kernel

theorem selectedBound2140 : packedSelected [13,17] rootPS < 2^1333 := by decide +kernel

def env2141 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4176,32768,38046,4176,262144,1024,32768,4097,10248,5456,139,8329,5376,277533,4177,4097,13340,4117,4294967296,256,4294977576,4177,513]

theorem envBound2141 : H12AffineFastState.Bounded env2141 := by
  intro p hp
  have h : env2141.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2140_2141 : H12AffineEnvironment.transform 15 38046 env2140 = env2141 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 38046 env2140 == env2141) = true)

theorem identity2141 : scanCanonicalize (H12AffineFastState.compose env2141 (packedSelected [0,4,7,9] rootPS)) = affineNative (2^(11+1) ^^^ 1945) := by decide +kernel

theorem selectedBound2141 : packedSelected [0,4,7,9] rootPS < 2^1333 := by decide +kernel

def env2142 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,8192,1993,32768,33543,1993,262144,1024,32768,1944,10248,713,139,8329,665,273284,1992,1944,9093,1932,4294967296,256,4294977576,1992,513]

theorem envBound2142 : H12AffineFastState.Bounded env2142 := by
  intro p hp
  have h : env2142.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2141_2142 : H12AffineEnvironment.transform 11 1945 env2141 = env2142 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1945 env2141 == env2142) = true)

theorem identity2142 : scanCanonicalize (H12AffineFastState.compose env2142 (packedSelected [5,8,10,12,13] rootPS)) = affineNative (2^(17+1) ^^^ 43048) := by decide +kernel

theorem selectedBound2142 : packedSelected [5,8,10,12,13] rootPS < 2^1333 := by decide +kernel

def env2143 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,8192,1993,32768,33543,1993,43048,1024,32768,1944,10248,713,139,8329,665,33708,1992,1944,9093,1932,4294967296,256,4294977576,1992,513]

theorem envBound2143 : H12AffineFastState.Bounded env2143 := by
  intro p hp
  have h : env2143.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2142_2143 : H12AffineEnvironment.transform 17 43048 env2142 = env2143 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 43048 env2142 == env2143) = true)

theorem identity2143 : scanCanonicalize (H12AffineFastState.compose env2143 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(12+1) ^^^ 2316) := by decide +kernel

theorem selectedBound2143 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env2144 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,2316,1993,32768,33543,1993,33060,1024,32768,1944,260,713,139,2437,665,33708,1992,1944,2697,1932,4294967296,256,4294967588,1992,513]

theorem envBound2144 : H12AffineFastState.Bounded env2144 := by
  intro p hp
  have h : env2144.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2143_2144 : H12AffineEnvironment.transform 12 2316 env2143 = env2144 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 2316 env2143 == env2144) = true)

theorem identity2144 : scanCanonicalize (H12AffineFastState.compose env2144 (packedSelected [0,1,3,5,7,8] rootPS)) = affineNative (2^(14+1) ^^^ 2340) := by decide +kernel

theorem selectedBound2144 : packedSelected [0,1,3,5,7,8] rootPS < 2^1333 := by decide +kernel

def env2145 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,1945,2316,1993,2340,2595,1993,2048,1024,2340,1944,260,713,139,2437,665,2696,1992,1944,2697,1932,4294967296,256,4294967588,1992,513]

theorem envBound2145 : H12AffineFastState.Bounded env2145 := by
  intro p hp
  have h : env2145.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2144_2145 : H12AffineEnvironment.transform 14 2340 env2144 = env2145 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 2340 env2144 == env2145) = true)

theorem identity2145 : scanCanonicalize (H12AffineFastState.compose env2145 (packedSelected [0,7] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound2145 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env2146 : List Nat := [2,4,8,16,32,64,128,256,137,1024,2048,1296,2316,1344,2340,2218,1344,2048,1024,2340,1297,260,64,139,2437,16,2049,1345,1297,2048,1285,4294967296,256,4294967588,1345,136]

theorem envBound2146 : H12AffineFastState.Bounded env2146 := by
  intro p hp
  have h : env2146.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2145_2146 : H12AffineEnvironment.transform 8 137 env2145 = env2146 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env2145 == env2146) = true)

def env2147 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,10248,5457,230469,8329,67108864,67516748,67110224,67245393,1073741824,67245381,4294967296,67113984,4362845671,131073,513]

theorem envBound2147 : H12AffineFastState.Bounded env2147 := by
  intro p hp
  have h : env2147.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2135_2147 : H12AffineEnvironment.transform 13 4177 env2135 = env2147 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 13 4177 env2135 == env2147) = true)

theorem identity2147 : scanCanonicalize (H12AffineFastState.compose env2147 (packedSelected [0,4,7,16,20,22] rootPS)) = affineNative (2^(29+1) ^^^ 67744130) := by decide +kernel

theorem selectedBound2147 : packedSelected [0,4,7,16,20,22] rootPS < 2^1333 := by decide +kernel

def env2148 : List Nat := [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,10248,5457,230469,8329,67108864,67516748,67110224,67245393,67744130,67245381,4294967296,67113984,4362845671,131073,513]

theorem envBound2148 : H12AffineFastState.Bounded env2148 := by
  intro p hp
  have h : env2148.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2147_2148 : H12AffineEnvironment.transform 29 67744130 env2147 = env2148 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 29 67744130 env2147 == env2148) = true)

def env2149 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,8200,5457,230469,8329,67108864,67514700,67110224,67245393,67744130,67245381,4294967296,67113984,4362843623,131073,513]

theorem envBound2149 : H12AffineFastState.Bounded env2149 := by
  intro p hp
  have h : env2149.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2148_2149 : H12AffineEnvironment.transform 10 0 env2148 = env2149 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 10 0 env2148 == env2149) = true)

def env2150 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,131072,262144,524288,32768,4097,8200,5457,230469,8329,5376,402508,4176,131153,631938,131141,4294967296,256,4295729383,131073,513]

theorem envBound2150 : H12AffineFastState.Bounded env2150 := by
  intro p hp
  have h : env2150.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2149_2150 : H12AffineEnvironment.transform 25 5376 env2149 = env2150 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 25 5376 env2149 == env2150) = true)

theorem identity2150 : scanCanonicalize (H12AffineFastState.compose env2150 (packedSelected [11] rootPS)) = affineNative (2^(18+1) ^^^ 329250) := by decide +kernel

theorem selectedBound2150 : packedSelected [11] rootPS < 2^1333 := by decide +kernel

def env2151 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,131072,262144,329250,32768,4097,8200,5457,230469,8329,5376,402508,4176,131153,303776,131141,4294967296,256,4295403205,131073,513]

theorem envBound2151 : H12AffineFastState.Bounded env2151 := by
  intro p hp
  have h : env2151.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2150_2151 : H12AffineEnvironment.transform 18 329250 env2150 = env2151 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 18 329250 env2150 == env2151) = true)

def env2152 : List Nat := [2,4,8,16,32,64,128,256,512,1024,0,4096,8192,4177,32768,65536,131072,41000,108042,32768,4097,8200,5457,230469,8329,5376,164964,4176,131153,648,131141,4294967296,256,4295100141,131073,513]

theorem envBound2152 : H12AffineFastState.Bounded env2152 := by
  intro p hp
  have h : env2152.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2151_2152 : H12AffineEnvironment.transform 17 41000 env2151 = env2152 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 17 41000 env2151 == env2152) = true)

theorem identity2152 : scanCanonicalize (H12AffineFastState.compose env2152 (packedSelected [16,18] rootPS)) = affineNative (2^(8+1) ^^^ 137) := by decide +kernel

theorem selectedBound2152 : packedSelected [16,18] rootPS < 2^1333 := by decide +kernel

def env2153 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,8192,4177,32768,65536,131072,41000,107651,32768,4097,8200,5457,230469,8329,5376,164964,4176,131153,1,131141,4294967296,256,4295099492,131073,136]

theorem envBound2153 : H12AffineFastState.Bounded env2153 := by
  intro p hp
  have h : env2153.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2152_2153 : H12AffineEnvironment.transform 8 137 env2152 = env2153 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 8 137 env2152 == env2153) = true)

theorem identity2153 : scanCanonicalize (H12AffineFastState.compose env2153 (packedSelected [0,2,6,9,16] rootPS)) = affineNative (2^(16+1) ^^^ 9292) := by decide +kernel

theorem selectedBound2153 : packedSelected [0,2,6,9,16] rootPS < 2^1333 := by decide +kernel

def env2154 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,8192,4177,32768,65536,9292,41000,107651,32768,4097,8200,5457,106505,8329,5376,41000,4176,9245,1,9225,4294967296,256,4294975528,9293,136]

theorem envBound2154 : H12AffineFastState.Bounded env2154 := by
  intro p hp
  have h : env2154.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2153_2154 : H12AffineEnvironment.transform 16 9292 env2153 = env2154 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 16 9292 env2153 == env2154) = true)

theorem identity2154 : scanCanonicalize (H12AffineFastState.compose env2154 (packedSelected [2,4,6,7] rootPS)) = affineNative (2^(12+1) ^^^ 269) := by decide +kernel

theorem selectedBound2154 : packedSelected [2,4,6,7] rootPS < 2^1333 := by decide +kernel

def env2155 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,269,4177,32768,65536,1345,33061,99726,32768,4097,261,5457,98564,388,5376,33061,4176,1296,1,1284,4294967296,256,4294967589,1344,136]

theorem envBound2155 : H12AffineFastState.Bounded env2155 := by
  intro p hp
  have h : env2155.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2154_2155 : H12AffineEnvironment.transform 12 269 env2154 = env2155 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 12 269 env2154 == env2155) = true)

theorem identity2155 : scanCanonicalize (H12AffineFastState.compose env2155 (packedSelected [0,2,4,6] rootPS)) = affineNative (2^(15+1) ^^^ 33167) := by decide +kernel

theorem selectedBound2155 : packedSelected [0,2,4,6] rootPS < 2^1333 := by decide +kernel

def env2156 : List Nat := [2,4,8,16,32,64,128,256,137,1024,0,4096,269,4177,32768,33167,1345,33061,1025,32768,4097,261,5457,139,388,5376,33061,4176,1296,1,1284,4294967296,256,4294967589,1344,136]

theorem envBound2156 : H12AffineFastState.Bounded env2156 := by
  intro p hp
  have h : env2156.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2155_2156 : H12AffineEnvironment.transform 15 33167 env2155 = env2156 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 15 33167 env2155 == env2156) = true)

theorem identity2156 : scanCanonicalize (H12AffineFastState.compose env2156 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound2156 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env2157 : List Nat := [2,4,8,16,32,16,128,256,137,1024,0,4096,269,4097,32768,33167,1297,33061,1025,32768,4097,261,5377,139,388,5376,33061,4096,1296,1,1284,4294967296,256,4294967589,1296,136]

theorem envBound2157 : H12AffineFastState.Bounded env2157 := by
  intro p hp
  have h : env2157.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2156_2157 : H12AffineEnvironment.transform 5 16 env2156 = env2157 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 5 16 env2156 == env2157) = true)

theorem identity2157 : scanCanonicalize (H12AffineFastState.compose env2157 (packedSelected [2,4] rootPS)) = affineNative (2^(11+1) ^^^ 1164) := by decide +kernel

theorem selectedBound2157 : packedSelected [2,4] rootPS < 2^1333 := by decide +kernel

def env2158 : List Nat := [2,4,8,16,32,16,128,256,137,1024,0,1164,269,1165,32768,33167,1297,33061,1025,32768,1165,261,397,139,388,396,33061,1164,1296,1,1284,4294967296,256,4294967589,1296,136]

theorem envBound2158 : H12AffineFastState.Bounded env2158 := by
  intro p hp
  have h : env2158.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2157_2158 : H12AffineEnvironment.transform 11 1164 env2157 = env2158 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 11 1164 env2157 == env2158) = true)

theorem identity2158 : scanCanonicalize (H12AffineFastState.compose env2158 (packedSelected [5] rootPS)) = affineNative (2^(14+1) ^^^ 391) := by decide +kernel

theorem selectedBound2158 : packedSelected [5] rootPS < 2^1333 := by decide +kernel

def env2159 : List Nat := [2,4,8,16,32,16,128,256,137,1024,0,1164,269,1165,391,8,1297,162,1025,391,1165,261,397,139,388,396,162,1164,1296,1,1284,4294967296,256,4294967589,1296,136]

theorem envBound2159 : H12AffineFastState.Bounded env2159 := by
  intro p hp
  have h : env2159.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2158_2159 : H12AffineEnvironment.transform 14 391 env2158 = env2159 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 14 391 env2158 == env2159) = true)

theorem identity2159 : scanCanonicalize (H12AffineFastState.compose env2159 (packedSelected [8] rootPS)) = affineNative (2^(7+1) ^^^ 134) := by decide +kernel

theorem selectedBound2159 : packedSelected [8] rootPS < 2^1333 := by decide +kernel

def env2160 : List Nat := [2,4,8,16,32,16,128,134,137,1024,0,1164,139,1165,1,8,1175,162,1025,1,1165,131,11,139,2,10,162,1164,1174,1,1154,4294967296,134,4294967459,1174,136]

theorem envBound2160 : H12AffineFastState.Bounded env2160 := by
  intro p hp
  have h : env2160.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2159_2160 : H12AffineEnvironment.transform 7 134 env2159 = env2160 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 7 134 env2159 == env2160) = true)

theorem identity2160 : scanCanonicalize (H12AffineFastState.compose env2160 (packedSelected [0] rootPS)) = affineNative (2^(31+1) ^^^ 27) := by decide +kernel

theorem selectedBound2160 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env2161 : List Nat := [2,4,8,16,32,16,128,134,137,1024,0,1164,139,1165,1,8,1175,162,1025,1,1165,131,11,139,2,10,162,1164,1174,1,1154,27,134,184,1174,136]

theorem envBound2161 : H12AffineFastState.Bounded env2161 := by
  intro p hp
  have h : env2161.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2160_2161 : H12AffineEnvironment.transform 31 27 env2160 = env2161 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 31 27 env2160 == env2161) = true)

theorem identity2161 : scanCanonicalize (H12AffineFastState.compose env2161 (packedSelected [2,9] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound2161 : packedSelected [2,9] rootPS < 2^1333 := by decide +kernel

def env2162 : List Nat := [2,4,8,11,32,11,128,134,137,1024,0,1164,139,1165,1,8,1164,162,1025,1,1165,131,11,139,2,10,162,1164,1165,1,1154,0,134,163,1165,136]

theorem envBound2162 : H12AffineFastState.Bounded env2162 := by
  intro p hp
  have h : env2162.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans2161_2162 : H12AffineEnvironment.transform 3 11 env2161 = env2162 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12AffineEnvironment.transform 3 11 env2161 == env2162) = true)

theorem identity2162 : scanCanonicalize (H12AffineFastState.compose env2162 (packedSelected [1] rootPS)) = affineNative (2^(9+1) ^^^ 141) := by decide +kernel

end H12GlobalChart2
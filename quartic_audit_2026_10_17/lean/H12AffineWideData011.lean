import H12AffineWideData010

namespace H12AffineWide

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem identity115 : scanCanonicalize (H12AffineState.compose env115 (packedSelected [2,11] rootPS)) = affineNative (2^(8+1) ^^^ 32) := by decide +kernel

theorem selectedBound115 : packedSelected [2,11] rootPS < 2^1333 := by decide +kernel

def env116 : List Nat := [2,4,8,16,32,64,128,253,32,1024,2048,1045,160,184,1,35,248,2185,1104,1048576,1029,32,65,16777216,33554432,17,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,185,68719476736]

theorem envBound116 : H12AffineState.Bounded env116 := by
  intro p hp
  have h : env116.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans115_116 : H12PackedSparse.directTransform 8 32 env115 = env116 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 8 32 env115 == env116) = true)

theorem identity116 : scanCanonicalize (H12AffineState.compose env116 (packedSelected [2] rootPS)) = affineNative (2^(9+1) ^^^ 5) := by decide +kernel

theorem selectedBound116 : packedSelected [2] rootPS < 2^1333 := by decide +kernel

def env117 : List Nat := [2,4,8,16,32,64,128,253,32,5,2048,16,160,184,1,35,248,2185,85,1048576,0,32,65,16777216,33554432,17,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,185,68719476736]

theorem envBound117 : H12AffineState.Bounded env117 := by
  intro p hp
  have h : env117.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans116_117 : H12PackedSparse.directTransform 9 5 env116 = env117 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 9 5 env116 == env117) = true)

theorem identity117 : scanCanonicalize (H12AffineState.compose env117 (packedSelected [0,4] rootPS)) = affineNative (2^(10+1) ^^^ 147) := by decide +kernel

theorem selectedBound117 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env118 : List Nat := [2,4,8,16,32,64,128,253,32,5,147,16,160,184,1,35,248,26,85,1048576,0,32,65,16777216,33554432,17,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,185,68719476736]

theorem envBound118 : H12AffineState.Bounded env118 := by
  intro p hp
  have h : env118.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans117_118 : H12PackedSparse.directTransform 10 147 env117 = env118 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 10 147 env117 == env118) = true)

theorem identity118 : scanCanonicalize (H12AffineState.compose env118 (packedSelected [1,5] rootPS)) = affineNative (2^(6+1) ^^^ 9) := by decide +kernel

theorem selectedBound118 : packedSelected [1,5] rootPS < 2^1333 := by decide +kernel

def env119 : List Nat := [2,4,8,16,32,64,9,116,32,5,26,16,41,49,1,35,113,26,85,1048576,0,32,65,16777216,33554432,17,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,48,68719476736]

theorem envBound119 : H12AffineState.Bounded env119 := by
  intro p hp
  have h : env119.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans118_119 : H12PackedSparse.directTransform 6 9 env118 = env119 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 6 9 env118 == env119) = true)

theorem identity119 : scanCanonicalize (H12AffineState.compose env119 (packedSelected [1,8] rootPS)) = affineNative (2^(3+1) ^^^ 11) := by decide +kernel

theorem selectedBound119 : packedSelected [1,8] rootPS < 2^1333 := by decide +kernel

def env120 : List Nat := [2,4,8,11,32,64,9,111,32,5,1,11,41,42,1,35,106,1,78,1048576,0,32,65,16777216,33554432,10,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,43,68719476736]

theorem envBound120 : H12AffineState.Bounded env120 := by
  intro p hp
  have h : env120.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans119_120 : H12PackedSparse.directTransform 3 11 env119 = env120 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 3 11 env119 == env120) = true)

theorem identity120 : scanCanonicalize (H12AffineState.compose env120 (packedSelected [0,1] rootPS)) = affineNative (2^(5+1) ^^^ 12) := by decide +kernel

theorem selectedBound120 : packedSelected [0,1] rootPS < 2^1333 := by decide +kernel

def env121 : List Nat := [2,4,8,11,32,12,9,35,32,5,1,11,41,42,1,35,38,1,2,1048576,0,32,13,16777216,33554432,10,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,43,68719476736]

theorem envBound121 : H12AffineState.Bounded env121 := by
  intro p hp
  have h : env121.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans120_121 : H12PackedSparse.directTransform 5 12 env120 = env121 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 5 12 env120 == env121) = true)

end H12AffineWide
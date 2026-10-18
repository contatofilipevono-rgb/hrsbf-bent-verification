import H12AffineWideData000

namespace H12AffineWide

open H12PackedPolynomial

set_option maxRecDepth 100000

set_option maxHeartbeats 1000000000

theorem envBound13 : H12AffineState.Bounded env13 := by
  intro p hp
  have h : env13.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans12_13 : H12PackedSparse.directTransform 17 34848 env12 = env13 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 17 34848 env12 == env13) = true)

theorem identity13 : scanCanonicalize (H12AffineState.compose env13 (packedSelected [0,2,4,7,9] rootPS)) = affineNative (2^(14+1) ^^^ 0) := by decide +kernel

theorem selectedBound13 : packedSelected [0,2,4,7,9] rootPS < 2^1333 := by decide +kernel

def env14 : List Nat := [2,4,8,16,32,64,40,84,512,68,2048,4096,8,16384,0,34,4096,2080,20564,1048576,16464,32,20480,16777216,33554432,20560,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4160,68719476736]

theorem envBound14 : H12AffineState.Bounded env14 := by
  intro p hp
  have h : env14.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans13_14 : H12PackedSparse.directTransform 14 0 env13 = env14 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 14 0 env13 == env14) = true)

theorem identity14 : scanCanonicalize (H12AffineState.compose env14 (packedSelected [1,3] rootPS)) = affineNative (2^(5+1) ^^^ 16) := by decide +kernel

theorem selectedBound14 : packedSelected [1,3] rootPS < 2^1333 := by decide +kernel

def env15 : List Nat := [2,4,8,16,32,16,40,4,512,20,2048,4096,8,16384,0,34,4096,2080,20484,1048576,16384,32,20480,16777216,33554432,20480,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4112,68719476736]

theorem envBound15 : H12AffineState.Bounded env15 := by
  intro p hp
  have h : env15.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans14_15 : H12PackedSparse.directTransform 5 16 env14 = env15 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 5 16 env14 == env15) = true)

theorem identity15 : scanCanonicalize (H12AffineState.compose env15 (packedSelected [6] rootPS)) = affineNative (2^(13+1) ^^^ 4112) := by decide +kernel

theorem selectedBound15 : packedSelected [6] rootPS < 2^1333 := by decide +kernel

def env16 : List Nat := [2,4,8,16,32,16,40,4,512,20,2048,4096,8,4112,0,34,4096,2080,20,1048576,4112,32,16,16777216,33554432,16,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4112,68719476736]

theorem envBound16 : H12AffineState.Bounded env16 := by
  intro p hp
  have h : env16.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans15_16 : H12PackedSparse.directTransform 13 4112 env15 = env16 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 13 4112 env15 == env16) = true)

theorem identity16 : scanCanonicalize (H12AffineState.compose env16 (packedSelected [0,4] rootPS)) = affineNative (2^(4+1) ^^^ 10) := by decide +kernel

theorem selectedBound16 : packedSelected [0,4] rootPS < 2^1333 := by decide +kernel

def env17 : List Nat := [2,4,8,16,10,16,2,4,512,20,2048,4096,8,4112,0,8,4096,2058,20,1048576,4112,10,16,16777216,33554432,16,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4112,68719476736]

theorem envBound17 : H12AffineState.Bounded env17 := by
  intro p hp
  have h : env17.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans16_17 : H12PackedSparse.directTransform 4 10 env16 = env17 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 4 10 env16 == env17) = true)

theorem identity17 : scanCanonicalize (H12AffineState.compose env17 (packedSelected [1,5] rootPS)) = affineNative (2^(3+1) ^^^ 0) := by decide +kernel

theorem selectedBound17 : packedSelected [1,5] rootPS < 2^1333 := by decide +kernel

def env18 : List Nat := [2,4,8,0,10,0,2,4,512,4,2048,4096,8,4096,0,8,4096,2058,4,1048576,4096,10,0,16777216,33554432,0,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4096,68719476736]

theorem envBound18 : H12AffineState.Bounded env18 := by
  intro p hp
  have h : env18.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans17_18 : H12PackedSparse.directTransform 3 0 env17 = env18 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 3 0 env17 == env18) = true)

theorem identity18 : scanCanonicalize (H12AffineState.compose env18 (packedSelected [0,7] rootPS)) = affineNative (2^(2+1) ^^^ 2) := by decide +kernel

theorem selectedBound18 : packedSelected [0,7] rootPS < 2^1333 := by decide +kernel

def env19 : List Nat := [2,4,2,0,0,0,2,4,512,4,2048,4096,2,4096,0,2,4096,2048,4,1048576,4096,0,0,16777216,33554432,0,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,4096,68719476736]

theorem envBound19 : H12AffineState.Bounded env19 := by
  intro p hp
  have h : env19.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans18_19 : H12PackedSparse.directTransform 2 2 env18 = env19 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 2 2 env18 == env19) = true)

theorem identity19 : scanCanonicalize (H12AffineState.compose env19 (packedSelected [0] rootPS)) = affineNative (2^(11+1) ^^^ 2050) := by decide +kernel

theorem selectedBound19 : packedSelected [0] rootPS < 2^1333 := by decide +kernel

def env20 : List Nat := [2,4,2,0,0,0,2,4,512,4,2048,2050,2,2050,0,2,2050,2048,4,1048576,2050,0,0,16777216,33554432,0,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,2050,68719476736]

theorem envBound20 : H12AffineState.Bounded env20 := by
  intro p hp
  have h : env20.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans19_20 : H12PackedSparse.directTransform 11 2050 env19 = env20 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 11 2050 env19 == env20) = true)

theorem identity20 : scanCanonicalize (H12AffineState.compose env20 (packedSelected [1] rootPS)) = affineNative (2^(1+1) ^^^ 0) := by decide +kernel

theorem selectedBound20 : packedSelected [1] rootPS < 2^1333 := by decide +kernel

def env21 : List Nat := [2,0,2,0,0,0,2,0,512,0,2048,2050,2,2050,0,2,2050,2048,0,1048576,2050,0,0,16777216,33554432,0,134217728,268435456,536870912,1073741824,2147483648,4294967296,8589934592,17179869184,2050,68719476736]

theorem envBound21 : H12AffineState.Bounded env21 := by
  intro p hp
  have h : env21.all (fun p => decide (p < 2^37)) = true := by decide +kernel
  exact of_decide_eq_true (List.all_eq_true.mp h p hp)

theorem envTrans20_21 : H12PackedSparse.directTransform 1 0 env20 = env21 := by
  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform 1 0 env20 == env21) = true)

def w0 : H12WitnessTheory.Witness := H12WitnessData000.batch0[0]'(by decide)

theorem w0_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w0.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData000.batch0 H12WitnessData000.batch0_checked _ (List.getElem_mem (by decide))

theorem w0_good : H12WitnessSearch.Good (.leaf w0) := by
  intro c hc
  have he : w0.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w0_reject

def w1 : H12WitnessTheory.Witness := H12WitnessData001.batch7[19]'(by decide)

theorem w1_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w1.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData001.batch7 H12WitnessData001.batch7_checked _ (List.getElem_mem (by decide))

theorem w1_good : H12WitnessSearch.Good (.leaf w1) := by
  intro c hc
  have he : w1.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w1_reject

def w2 : H12WitnessTheory.Witness := H12WitnessData005.batch11[32]'(by decide)

theorem w2_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w2.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData005.batch11 H12WitnessData005.batch11_checked _ (List.getElem_mem (by decide))

theorem w2_good : H12WitnessSearch.Good (.leaf w2) := by
  intro c hc
  have he : w2.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w2_reject

def w3 : H12WitnessTheory.Witness := H12WitnessData007.batch2[57]'(by decide)

theorem w3_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w3.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData007.batch2 H12WitnessData007.batch2_checked _ (List.getElem_mem (by decide))

theorem w3_good : H12WitnessSearch.Good (.leaf w3) := by
  intro c hc
  have he : w3.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w3_reject

def w4 : H12WitnessTheory.Witness := H12WitnessData014.batch4[17]'(by decide)

theorem w4_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w4.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData014.batch4 H12WitnessData014.batch4_checked _ (List.getElem_mem (by decide))

theorem w4_good : H12WitnessSearch.Good (.leaf w4) := by
  intro c hc
  have he : w4.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w4_reject

def w5 : H12WitnessTheory.Witness := H12WitnessData015.batch10[187]'(by decide)

theorem w5_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w5.coefficient)) :=
  H12WitnessTheory.checked_list_sound H12WitnessData015.batch10 H12WitnessData015.batch10_checked _ (List.getElem_mem (by decide))

theorem w5_good : H12WitnessSearch.Good (.leaf w5) := by
  intro c hc
  have he : w5.coefficient = c := beq_iff_eq.mp hc
  rw [← he]
  exact w5_reject

end H12AffineWide
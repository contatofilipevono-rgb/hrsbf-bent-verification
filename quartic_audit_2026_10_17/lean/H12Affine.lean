import H12Audit

namespace H12Affine
open H12BooleanPolynomial H12CertificateTheory H12Refutation
set_option maxRecDepth 100000
set_option maxHeartbeats 1000000000

def cases : List Nat := [2,3,8,15]
def offsets : List Nat := [1099578736640, 3367338246144, 4398113619968, 5566294392832]
def basis : List Nat := [137438953473, 68719476738, 2336462209028, 2199023255560, 16, 2199023255584, 2336462209088, 68719476864, 2199023255808, 68719477248, 1024, 2199023257600, 2336462213120, 2199023263744, 16384, 2405198495744, 2199023321088, 2199023386624, 17039360, 2267760033792, 2199024304128, 2199025352704, 2199027449856, 2405206851584, 2336495763456, 2199157473280, 2199291691008, 2199560126464, 2200096997376, 2147483648, 73014444032, 8589934592, 85899345920, 34359738368, 2473901162496, 2748779069440]
def free : List Nat := [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 25, 27, 28, 29, 30, 31, 32, 33, 34, 35, 38, 39]
def forms : List (List Nat) := [[32768, 262144, 524288, 8388608, 16777216], [1099511627776], [2, 4, 8, 32, 64, 128, 256, 512, 2048, 4096, 8192, 65536, 131072, 1048576, 2097152, 4194304, 33554432, 134217728, 268435456, 536870912, 1073741824, 4294967296, 17179869184, 68719476736, 274877906944, 549755813888, 2199023255552], [4398046511104], [2, 128, 512, 262144, 16777216, 4294967296, 17179869184, 68719476736], [67108864, 1099511627776, 4398046511104], [1, 2, 4, 64, 128, 512, 4096, 32768, 262144, 8388608, 16777216, 33554432, 4294967296, 17179869184, 68719476736, 137438953472]]
def witnesses : List (List Nat) := [[], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [0], [], [1, 3, 5], [], [], [], [], [], [], [], [], [], [0, 4], [4, 6], [], [], [1], [0, 2, 4], [3]]

def fromFn {n : Nat} (f : Fin n → Bool) : BitVec n :=
  (BitVec.ofBoolListLE (List.ofFn f)).cast List.length_ofFn

theorem get_fromFn {n : Nat} (f : Fin n → Bool) (i : Nat) (hi : i < n) :
    (fromFn f).getLsbD i = f ⟨i,hi⟩ := by
  simp only [fromFn, BitVec.getLsbD_cast, BitVec.getLsbD_ofBoolListLE,
    List.getD_eq_getElem?_getD, List.getElem?_ofFn, hi, ↓reduceDIte, Option.getD_some]

def affine (b : Bool) (indices : List Nat) : List Nat :=
  (if b then [0] else []) ++ indices.map (fun i => 2^i)

theorem evaluate_constant (n : Nat) (f : Nat → Bool) (b : Bool) :
    evaluate n f (if b then [0] else []) = b := by
  cases b <;> simp [evaluate, monomial_zero]

theorem evaluate_units (n : Nat) (f : Nat → Bool) (indices : List Nat)
    (bounds : ∀ i ∈ indices, i < n) :
    evaluate n f (indices.map (fun i => 2^i)) = indices.foldr (fun i b => f i ^^ b) false := by
  induction indices with
  | nil => rfl
  | cons i indices ih =>
    rw [List.map_cons, evaluate_cons, monomial_unit n f i (bounds i List.mem_cons_self),
      ih (fun j hj => bounds j (List.mem_cons_of_mem i hj)), List.foldr_cons]

theorem evaluate_affine (n : Nat) (f : Nat → Bool) (b : Bool) (indices : List Nat)
    (bounds : ∀ i ∈ indices, i < n) :
    evaluate n f (affine b indices) = (b ^^ indices.foldr (fun i v => f i ^^ v) false) := by
  rw [affine, evaluate_append, evaluate_constant, evaluate_units n f indices bounds]

theorem evaluate_relabel (n m : Nat) (f g : Nat → Bool) (b : Bool)
    (indices : List Nat) (label : Nat → Nat)
    (hn : ∀ i ∈ indices, i < n) (hm : ∀ i ∈ indices, label i < m)
    (he : ∀ i ∈ indices, f i = g (label i)) :
    evaluate n f (affine b indices) = evaluate m g (affine b (indices.map label)) := by
  rw [evaluate_affine n f b indices hn, evaluate_affine m g b _ (by
    intro j hj; obtain ⟨i,hi,rfl⟩ := List.mem_map.mp hj; exact hm i hi)]
  have hlist := List.map_congr_left he
  have hx := congrArg (fun vs : List Bool => vs.foldr Bool.xor false) hlist
  simp only [List.foldr_map] at hx
  rw [List.foldr_map, hx]

def contributors (t : Nat) : List Nat := (List.range 36).filter (fun i => basis[i]!.testBit t)
def rowU (k t : Nat) : List Nat := affine (offsets[k]!.testBit t) (contributors t)
def rowC (k t : Nat) : List Nat := affine (offsets[k]!.testBit t) ((contributors t).map (fun i => free[i]!))
def rhs (k : Nat) : List Bool := ((List.range 4).map (fun i => cases[k]!.testBit i)) ++ [false,false,false]
def constraints (k : Nat) : List (List Nat) :=
  (List.range 7).map (fun i => forms[i]! ++ (if (rhs k)[i]! then [0] else []))
def project (c : BitVec 43) : BitVec 36 := fromFn (fun i => c.getLsbD free[i.val]!)
def embed (k : Nat) (u : BitVec 36) : BitVec 43 :=
  fromFn (fun t => evaluate 36 u.getLsbD (rowU k t.val))

theorem free_bounds : ∀ i : Fin 36, free[i.val]! < 43 := by decide +kernel

theorem contributors_bounds (t : Nat) : ∀ i ∈ contributors t, i < 36 := by
  intro i hi
  exact List.mem_range.mp (List.mem_filter.mp hi).1

theorem project_row (c : BitVec 43) (k t : Nat) :
    evaluate 36 (project c).getLsbD (rowU k t) = evaluate 43 c.getLsbD (rowC k t) := by
  apply evaluate_relabel 36 43 _ _ _ _ (fun i => free[i]!) (contributors_bounds t)
  · intro i hi
    exact free_bounds ⟨i,contributors_bounds t i hi⟩
  · intro i hi
    exact get_fromFn _ i (contributors_bounds t i hi)

def reconstructionCheck (k t : Nat) : Bool :=
  normalizeFuel 20 ([2^t] ++ rowC k t ++ selected witnesses[t]! (constraints k)) == []

theorem reconstructionChecks : (List.range 4).all (fun k =>
    (List.range 43).all (fun t => reconstructionCheck k t)) = true := by decide +kernel

theorem component_reconstructed (c : BitVec 43) (k : Fin 4) (t : Fin 43)
    (h : Models 43 c.getLsbD (constraints k.val)) :
    evaluate 43 c.getLsbD (rowC k.val t.val) = c.getLsbD t.val := by
  have hd := List.all_eq_true.mp reconstructionChecks k.val (List.mem_range.mpr k.isLt)
  have ht := beq_iff_eq.mp (List.all_eq_true.mp hd t.val (List.mem_range.mpr t.isLt))
  have hv := congrArg (evaluate 43 c.getLsbD) ht
  rw [evaluate_normalize, evaluate_append, evaluate_append, evaluate_cons, evaluate_nil,
    monomial_unit 43 c.getLsbD t.val t.isLt, Bool.xor_false,
    selected_zero 43 c.getLsbD (constraints k.val) h witnesses[t.val]!, Bool.xor_false] at hv
  exact ((xor_zero_iff _ _).mp hv).symm

theorem reconstruct (c : BitVec 43) (k : Fin 4)
    (h : Models 43 c.getLsbD (constraints k.val)) : embed k.val (project c) = c := by
  apply BitVec.eq_of_getLsbD_eq
  intro t ht
  rw [embed, get_fromFn _ t ht, project_row c k.val t]
  exact component_reconstructed c k ⟨t,ht⟩ h

#print axioms reconstruct
theorem u0 (c : BitVec 43) : monomial 43 c.getLsbD 1 = c.getLsbD 0 := monomial_unit 43 c.getLsbD 0 (by decide)
theorem u1 (c : BitVec 43) : monomial 43 c.getLsbD 2 = c.getLsbD 1 := monomial_unit 43 c.getLsbD 1 (by decide)
theorem u2 (c : BitVec 43) : monomial 43 c.getLsbD 4 = c.getLsbD 2 := monomial_unit 43 c.getLsbD 2 (by decide)
theorem u3 (c : BitVec 43) : monomial 43 c.getLsbD 8 = c.getLsbD 3 := monomial_unit 43 c.getLsbD 3 (by decide)
theorem u4 (c : BitVec 43) : monomial 43 c.getLsbD 16 = c.getLsbD 4 := monomial_unit 43 c.getLsbD 4 (by decide)
theorem u5 (c : BitVec 43) : monomial 43 c.getLsbD 32 = c.getLsbD 5 := monomial_unit 43 c.getLsbD 5 (by decide)
theorem u6 (c : BitVec 43) : monomial 43 c.getLsbD 64 = c.getLsbD 6 := monomial_unit 43 c.getLsbD 6 (by decide)
theorem u7 (c : BitVec 43) : monomial 43 c.getLsbD 128 = c.getLsbD 7 := monomial_unit 43 c.getLsbD 7 (by decide)
theorem u8 (c : BitVec 43) : monomial 43 c.getLsbD 256 = c.getLsbD 8 := monomial_unit 43 c.getLsbD 8 (by decide)
theorem u9 (c : BitVec 43) : monomial 43 c.getLsbD 512 = c.getLsbD 9 := monomial_unit 43 c.getLsbD 9 (by decide)
theorem u10 (c : BitVec 43) : monomial 43 c.getLsbD 1024 = c.getLsbD 10 := monomial_unit 43 c.getLsbD 10 (by decide)
theorem u11 (c : BitVec 43) : monomial 43 c.getLsbD 2048 = c.getLsbD 11 := monomial_unit 43 c.getLsbD 11 (by decide)
theorem u12 (c : BitVec 43) : monomial 43 c.getLsbD 4096 = c.getLsbD 12 := monomial_unit 43 c.getLsbD 12 (by decide)
theorem u13 (c : BitVec 43) : monomial 43 c.getLsbD 8192 = c.getLsbD 13 := monomial_unit 43 c.getLsbD 13 (by decide)
theorem u14 (c : BitVec 43) : monomial 43 c.getLsbD 16384 = c.getLsbD 14 := monomial_unit 43 c.getLsbD 14 (by decide)
theorem u15 (c : BitVec 43) : monomial 43 c.getLsbD 32768 = c.getLsbD 15 := monomial_unit 43 c.getLsbD 15 (by decide)
theorem u16 (c : BitVec 43) : monomial 43 c.getLsbD 65536 = c.getLsbD 16 := monomial_unit 43 c.getLsbD 16 (by decide)
theorem u17 (c : BitVec 43) : monomial 43 c.getLsbD 131072 = c.getLsbD 17 := monomial_unit 43 c.getLsbD 17 (by decide)
theorem u18 (c : BitVec 43) : monomial 43 c.getLsbD 262144 = c.getLsbD 18 := monomial_unit 43 c.getLsbD 18 (by decide)
theorem u19 (c : BitVec 43) : monomial 43 c.getLsbD 524288 = c.getLsbD 19 := monomial_unit 43 c.getLsbD 19 (by decide)
theorem u20 (c : BitVec 43) : monomial 43 c.getLsbD 1048576 = c.getLsbD 20 := monomial_unit 43 c.getLsbD 20 (by decide)
theorem u21 (c : BitVec 43) : monomial 43 c.getLsbD 2097152 = c.getLsbD 21 := monomial_unit 43 c.getLsbD 21 (by decide)
theorem u22 (c : BitVec 43) : monomial 43 c.getLsbD 4194304 = c.getLsbD 22 := monomial_unit 43 c.getLsbD 22 (by decide)
theorem u23 (c : BitVec 43) : monomial 43 c.getLsbD 8388608 = c.getLsbD 23 := monomial_unit 43 c.getLsbD 23 (by decide)
theorem u24 (c : BitVec 43) : monomial 43 c.getLsbD 16777216 = c.getLsbD 24 := monomial_unit 43 c.getLsbD 24 (by decide)
theorem u25 (c : BitVec 43) : monomial 43 c.getLsbD 33554432 = c.getLsbD 25 := monomial_unit 43 c.getLsbD 25 (by decide)
theorem u26 (c : BitVec 43) : monomial 43 c.getLsbD 67108864 = c.getLsbD 26 := monomial_unit 43 c.getLsbD 26 (by decide)
theorem u27 (c : BitVec 43) : monomial 43 c.getLsbD 134217728 = c.getLsbD 27 := monomial_unit 43 c.getLsbD 27 (by decide)
theorem u28 (c : BitVec 43) : monomial 43 c.getLsbD 268435456 = c.getLsbD 28 := monomial_unit 43 c.getLsbD 28 (by decide)
theorem u29 (c : BitVec 43) : monomial 43 c.getLsbD 536870912 = c.getLsbD 29 := monomial_unit 43 c.getLsbD 29 (by decide)
theorem u30 (c : BitVec 43) : monomial 43 c.getLsbD 1073741824 = c.getLsbD 30 := monomial_unit 43 c.getLsbD 30 (by decide)
theorem u31 (c : BitVec 43) : monomial 43 c.getLsbD 2147483648 = c.getLsbD 31 := monomial_unit 43 c.getLsbD 31 (by decide)
theorem u32 (c : BitVec 43) : monomial 43 c.getLsbD 4294967296 = c.getLsbD 32 := monomial_unit 43 c.getLsbD 32 (by decide)
theorem u33 (c : BitVec 43) : monomial 43 c.getLsbD 8589934592 = c.getLsbD 33 := monomial_unit 43 c.getLsbD 33 (by decide)
theorem u34 (c : BitVec 43) : monomial 43 c.getLsbD 17179869184 = c.getLsbD 34 := monomial_unit 43 c.getLsbD 34 (by decide)
theorem u35 (c : BitVec 43) : monomial 43 c.getLsbD 34359738368 = c.getLsbD 35 := monomial_unit 43 c.getLsbD 35 (by decide)
theorem u36 (c : BitVec 43) : monomial 43 c.getLsbD 68719476736 = c.getLsbD 36 := monomial_unit 43 c.getLsbD 36 (by decide)
theorem u37 (c : BitVec 43) : monomial 43 c.getLsbD 137438953472 = c.getLsbD 37 := monomial_unit 43 c.getLsbD 37 (by decide)
theorem u38 (c : BitVec 43) : monomial 43 c.getLsbD 274877906944 = c.getLsbD 38 := monomial_unit 43 c.getLsbD 38 (by decide)
theorem u39 (c : BitVec 43) : monomial 43 c.getLsbD 549755813888 = c.getLsbD 39 := monomial_unit 43 c.getLsbD 39 (by decide)
theorem u40 (c : BitVec 43) : monomial 43 c.getLsbD 1099511627776 = c.getLsbD 40 := monomial_unit 43 c.getLsbD 40 (by decide)
theorem u41 (c : BitVec 43) : monomial 43 c.getLsbD 2199023255552 = c.getLsbD 41 := monomial_unit 43 c.getLsbD 41 (by decide)
theorem u42 (c : BitVec 43) : monomial 43 c.getLsbD 4398046511104 = c.getLsbD 42 := monomial_unit 43 c.getLsbD 42 (by decide)
theorem pack0 : ∀ a b c d : Bool, (H12.pack4 a b c d).getLsbD 0 = a := by decide +kernel
theorem pack1 : ∀ a b c d : Bool, (H12.pack4 a b c d).getLsbD 1 = b := by decide +kernel
theorem pack2 : ∀ a b c d : Bool, (H12.pack4 a b c d).getLsbD 2 = c := by decide +kernel
theorem pack3 : ∀ a b c d : Bool, (H12.pack4 a b c d).getLsbD 3 = d := by decide +kernel

def baseValues (c : BitVec 43) : List Bool := forms.map (evaluate 43 c.getLsbD)
def caseValue (k : Fin 4) : BitVec 4 := BitVec.ofNat 4 cases[k.val]!

theorem base_values (c : BitVec 43) : baseValues c =
    [(H12.parameters c).getLsbD 0, (H12.parameters c).getLsbD 1,
     (H12.parameters c).getLsbD 2, (H12.parameters c).getLsbD 3,
     H12Quadratic.r1 c, H12Quadratic.r2 c, H12Quadratic.r3 c] := by
  simp only [baseValues, forms, List.map_cons, List.map_nil,
    H12.parameters, pack0,pack1,pack2,pack3,
    H12Quadratic.r1,H12Quadratic.r2,H12Quadratic.r3,
    H12Quadratic.rm1,H12Quadratic.rm2,H12Quadratic.rm3,
    evaluate_cons,evaluate_nil,u0,u1,u2,u3,u4,u5,u6,u7,u8,u9,u10,u11,u12,u13,u14,u15,u16,u17,u18,u19,u20,u21,u22,u23,u24,u25,u26,u27,u28,u29,u30,u31,u32,u33,u34,u35,u36,u37,u38,u39,u40,u41,u42,Bool.xor_false,Bool.xor_assoc]

theorem rhs_by_case : ∀ k : Fin 4, rhs k.val =
    [(caseValue k).getLsbD 0,(caseValue k).getLsbD 1,(caseValue k).getLsbD 2,
     (caseValue k).getLsbD 3,false,false,false] := by decide +kernel

theorem models_of_base_values (c : BitVec 43) (k : Fin 4)
    (h : baseValues c = rhs k.val) : Models 43 c.getLsbD (constraints k.val) := by
  intro p hp
  obtain ⟨i,hi,rfl⟩ := List.mem_map.mp hp
  rw [evaluate_append, evaluate_constant]
  have hib : i < forms.length := by simpa [forms] using List.mem_range.mp hi
  have he := H12FilterLink.map_lookup forms (evaluate 43 c.getLsbD) i hib
  rw [← he]
  change ((baseValues c)[i]! ^^ (rhs k.val)[i]!) = false
  rw [h, Bool.xor_self]

theorem models_of_parameters (c : BitVec 43) (k : Fin 4)
    (hp : H12.parameters c = caseValue k)
    (h1 : H12Quadratic.r1 c = false) (h2 : H12Quadratic.r2 c = false)
    (h3 : H12Quadratic.r3 c = false) : Models 43 c.getLsbD (constraints k.val) := by
  apply models_of_base_values
  rw [base_values, hp, h1,h2,h3]
  exact (rhs_by_case k).symm

theorem covers_bent (c : BitVec 43) (hb : H12Descent.BentAC (H12.quarticFunction c)) :
    ∃ k : Fin 3, embed k.val (project c) = c := by
  obtain ⟨hc,h1,h2,h3⟩ := H12Audit.necessary_chart_constraints c hb
  rcases hc with h | h | h
  · refine ⟨⟨0,by decide⟩, reconstruct c ⟨0,by decide⟩ (models_of_parameters c _ ?_ h1 h2 h3)⟩
    apply BitVec.eq_of_toNat_eq
    simpa [caseValue,cases] using h
  · refine ⟨⟨1,by decide⟩, reconstruct c ⟨1,by decide⟩ (models_of_parameters c _ ?_ h1 h2 h3)⟩
    apply BitVec.eq_of_toNat_eq
    simpa [caseValue,cases] using h
  · refine ⟨⟨2,by decide⟩, reconstruct c ⟨2,by decide⟩ (models_of_parameters c _ ?_ h1 h2 h3)⟩
    apply BitVec.eq_of_toNat_eq
    simpa [caseValue,cases] using h

#print axioms covers_bent

def cpuSpan (u : BitVec 36) (indices : List Nat) : BitVec 43 :=
  indices.foldr (fun i acc => if u.getLsbD i then BitVec.ofNat 43 basis[i]! ^^^ acc else acc) 0
def cpuEmbed (k : Nat) (u : BitVec 36) : BitVec 43 :=
  BitVec.ofNat 43 offsets[k]! ^^^ cpuSpan u (List.range 36)

theorem filter_fold (indices : List Nat) (p f : Nat → Bool) :
    (indices.filter p).foldr (fun i a => f i ^^ a) false =
      indices.foldr (fun i a => (p i && f i) ^^ a) false := by
  induction indices with
  | nil => rfl
  | cons i indices ih => cases h : p i <;> simp [h, ih]

theorem cpuSpan_bit (u : BitVec 36) (indices : List Nat) (t : Nat) (ht : t < 43) :
    (cpuSpan u indices).getLsbD t = indices.foldr
      (fun i a => (basis[i]!.testBit t && u.getLsbD i) ^^ a) false := by
  induction indices with
  | nil => simp [cpuSpan]
  | cons i indices ih =>
    cases h : u.getLsbD i <;>
      simp only [cpuSpan, List.foldr_cons, h, Bool.false_eq_true, ↓reduceIte,
        BitVec.getLsbD_xor, BitVec.getLsbD_ofNat, ht, decide_true,
        Bool.true_and, Bool.and_false, Bool.and_true, Bool.false_xor] at *
    · exact ih
    · rw [ih]

theorem embed_cpu_agree (k : Nat) (u : BitVec 36) : embed k u = cpuEmbed k u := by
  apply BitVec.eq_of_getLsbD_eq
  intro t ht
  rw [embed, get_fromFn _ t ht]
  rw [rowU, evaluate_affine 36 u.getLsbD _ _ (contributors_bounds t)]
  rw [cpuEmbed, BitVec.getLsbD_xor, cpuSpan_bit u (List.range 36) t ht]
  simp only [BitVec.getLsbD_ofNat, ht, decide_true, Bool.true_and]
  rw [contributors, filter_fold]

theorem covers_bent_cpu (c : BitVec 43) (hb : H12Descent.BentAC (H12.quarticFunction c)) :
    ∃ k : Fin 3, cpuEmbed k.val (project c) = c := by
  obtain ⟨k,hk⟩ := covers_bent c hb
  exact ⟨k, (embed_cpu_agree k.val (project c)).symm.trans hk⟩

theorem numeric_data_bounds : offsets.length = 4 ∧ basis.length = 36 ∧ free.length = 36 ∧
    offsets.all (fun v => decide (v < 2^43)) = true ∧
    basis.all (fun v => decide (v < 2^43)) = true := by decide +kernel

#print axioms embed_cpu_agree
#print axioms covers_bent_cpu
end H12Affine

import sys,json,hashlib
from pathlib import Path
sys.path.insert(0,str(Path('work').resolve()))
from T113_h12_sat import build
root=Path('outputs/hrsbf-bent-verification/quartic_audit_2026_10_17')
ld=root/'lean';ld.mkdir(parents=True,exist_ok=True)
c,oo,xx,tv=build()
columns=[sum((sum(((y|(y<<4)|(y<<8))&s)==s for s in o)%2)<<y for y in range(16)) for o in oo]
rows=[sum(((v>>y)&1)<<j for j,v in enumerate(columns)) for y in [3,5,7,15]]
assert rows==[0x18c8000,0x10000000000,0x3d57a733bee,0x40000000000]
orbits='['+',\n'.join('['+','.join(map(str,o))+']' for o in oo)+']'
cols='['+','.join(map(str,columns))+']'
def parity(mask):
 return '('+' ^^ '.join(f'c.getLsbD {j}' for j in range(43) if mask>>j&1)+')'
restriction=' ^^^\n  '.join(f'(if c.getLsbD {j} then {v} else 0)' for j,v in enumerate(columns) if v)
original=' ^^\n  '.join(f'(c.getLsbD {j} && orbitValue (quarticOrbits[({j} : Fin 43).val]!) x)' for j in range(43))
bool_full=' ^^ '.join(f'(c.getLsbD {j} && ({v} : BitVec 16).getLsbD y.val)' for j,v in enumerate(columns))
bool_nonzero=' ^^ '.join(f'(c.getLsbD {j} && ({v} : BitVec 16).getLsbD y.val)' for j,v in enumerate(columns) if v)
src='''import Std

/-! Exact finite periodic reduction for the quartic cyclic space in 12 variables.
No theorem of global H(12,4) nonexistence is asserted in this file.
All finite proofs use kernel reduction or elementary XOR identities.
No native_decide, bv_decide, sorry, or project-specific axiom is used.
-/
namespace H12
set_option maxRecDepth 100000
set_option maxHeartbeats 10000000

def quarticOrbits : List (List Nat) := ORBITS
def periodicColumns : List (BitVec 16) := COLS
def repeated4 (y : Nat) : Nat := y + 16*y + 256*y
def monomialValue (s x : Nat) : Bool := (x &&& s) == s
def orbitValue (o : List Nat) (x : Nat) : Bool :=
  o.foldl (fun a s => a ^^ monomialValue s x) false

theorem basis_periodic_columns : ∀ j : Fin 43, ∀ y : Fin 16,
    orbitValue (quarticOrbits[j.val]!) (repeated4 y.val) =
      (periodicColumns[j.val]!).getLsbD y.val := by decide

def parityMask (c : BitVec 43) (mask : Nat) : Bool :=
  (List.range 43).foldl
    (fun a j => a ^^ (c.getLsbD j && mask.testBit j)) false

def pack4 (a b c d : Bool) : BitVec 4 :=
  (if a then 1 else 0) ||| (if b then 2 else 0) |||
  (if c then 4 else 0) ||| (if d then 8 else 0)

def parameters (c : BitVec 43) : BitVec 4 :=
  pack4 PARITY_A (c.getLsbD 40) PARITY_C (c.getLsbD 42)

def restrictionTable (c : BitVec 43) : BitVec 16 :=
  RESTRICTION

def normalTable (p : BitVec 4) : BitVec 16 :=
  (if p.getLsbD 0 then 0x1248 else 0) ^^^
  (if p.getLsbD 1 then 0x6ca0 else 0) ^^^
  (if p.getLsbD 2 then 0x6880 else 0) ^^^
  (if p.getLsbD 3 then 0x8000 else 0)

theorem normal_pack : ∀ a b c d : Bool,
    normalTable (pack4 a b c d) =
      (if a then 0x1248 else 0) ^^^ (if b then 0x6ca0 else 0) ^^^
      (if c then 0x6880 else 0) ^^^ (if d then 0x8000 else 0) := by decide

theorem select_xor (a b : Bool) (x : BitVec 16) :
    (if a ^^ b then x else 0) = (if a then x else 0) ^^^ (if b then x else 0) := by
  cases a <;> cases b <;> simp

theorem restriction_normal_form (c : BitVec 43) :
    restrictionTable c = normalTable (parameters c) := by
  simp only [parameters, normal_pack, restrictionTable, select_xor]
  ac_rfl

def quarticFunction (c : BitVec 43) (x : Nat) : Bool :=
  ORIGINAL_FUNCTION

theorem bit_select (b : Bool) (v : BitVec 16) (i : Nat) :
    (if b then v else 0).getLsbD i = (b && v.getLsbD i) := by
  cases b <;> simp

theorem quartic_periodic (c : BitVec 43) (y : Fin 16) :
    quarticFunction c (repeated4 y.val) = (restrictionTable c).getLsbD y.val := by
  unfold quarticFunction
  simp only [basis_periodic_columns, restrictionTable, BitVec.getLsbD_xor, bit_select]
  change (BOOL_FULL) = (BOOL_NONZERO)
  simp
  all_goals ac_rfl

def autocorrelation4 (table : BitVec 16) (u : Nat) : Int :=
  ((List.range 16).map (fun x =>
    if table.getLsbD x == table.getLsbD (x ^^^ u) then (1 : Int) else -1)).sum

def admissibleMod3 (p : Nat) : Prop :=
  ∀ u : Fin 15, autocorrelation4 (normalTable (BitVec.ofNat 4 p)) (u.val+1) % 3 = 0

theorem four_case_classification : ∀ p : Fin 16,
    admissibleMod3 p.val ↔
      p.val = 2 ∨ p.val = 3 ∨ p.val = 8 ∨ p.val = 15 := by
  unfold admissibleMod3
  decide

theorem four_case_tables :
    normalTable 2 = 0x6ca0 ∧ normalTable 3 = 0x7ee8 ∧
    normalTable 8 = 0x8000 ∧ normalTable 15 = 0x9668 := by decide

theorem periodic_reduction (c : BitVec 43)
    (h : admissibleMod3 (parameters c).toNat) :
    restrictionTable c = 0x6ca0 ∨ restrictionTable c = 0x7ee8 ∨
    restrictionTable c = 0x8000 ∨ restrictionTable c = 0x9668 := by
  have hp := (four_case_classification ⟨(parameters c).toNat,
    (parameters c).isLt⟩).mp h
  rw [restriction_normal_form]
  rcases hp with h2 | h3 | h8 | h15
  · left; have he : parameters c = 2 := by apply BitVec.eq_of_toNat_eq; exact h2
    rw [he]; decide
  · right; left; have he : parameters c = 3 := by apply BitVec.eq_of_toNat_eq; exact h3
    rw [he]; decide
  · right; right; left; have he : parameters c = 8 := by apply BitVec.eq_of_toNat_eq; exact h8
    rw [he]; decide
  · right; right; right; have he : parameters c = 15 := by apply BitVec.eq_of_toNat_eq; exact h15
    rw [he]; decide

#print axioms basis_periodic_columns
#print axioms restriction_normal_form
#print axioms four_case_classification
#print axioms periodic_reduction
#print axioms quartic_periodic
end H12
'''.replace('ORBITS',orbits).replace('COLS',cols).replace('PARITY_A',parity(rows[0])).replace('PARITY_C',parity(rows[2]^(1<<40))).replace('RESTRICTION',restriction).replace('ORIGINAL_FUNCTION',original).replace('BOOL_FULL',bool_full).replace('BOOL_NONZERO',bool_nonzero)
(ld/'H12PeriodFour.lean').write_text(src,encoding='utf-8')
(ld/'lean-toolchain').write_text('leanprover/lean4:v4.35.0\n')
(ld/'lakefile.toml').write_text('name = "H12Audit"\nversion = "0.1.0"\ndefaultTargets = ["H12Audit"]\n\n[[lean_lib]]\nname = "H12Audit"\nroots = ["H12Audit", "H12PeriodFour", "H12Descent"]\n')
print(ld)

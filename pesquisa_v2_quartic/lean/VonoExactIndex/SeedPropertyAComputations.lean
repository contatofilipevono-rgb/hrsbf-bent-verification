import VonoExactIndex.Seed8
import VonoExactIndex.QuarticSeedPropertyA

/-! Integration of the quartic certificate with the project's SeedVec and
full seed, including its quadratic orbit. All old modules are preserved. -/
set_option maxHeartbeats 0
set_option maxRecDepth 4096

namespace VonoExactIndex.SeedPropertyABridge

abbrev Byte := Fin 256

def decode (n : Nat) : SeedVec := fun i =>
  if n.testBit i.val then 1 else 0

private theorem xor_bound : ∀ a b : Byte, Nat.xor a.val b.val < 256 := by
  native_decide

def xorByte (a b : Byte) : Byte := ⟨Nat.xor a.val b.val, xor_bound a b⟩

theorem decode_xor : ∀ a b : Byte,
    decode (xorByte a b).val = decode a.val + decode b.val := by
  native_decide

theorem decode_surjective : ∀ x : SeedVec, ∃ n : Byte, decode n.val = x := by
  native_decide

theorem decode_zero : decode 0 = (0 : SeedVec) := by
  native_decide

@[irreducible] private def fullSeedTable : Array (ZMod 2) :=
  ((List.range 256).map (fun n => VonoExactIndex.seed (decode n))).toArray

@[irreducible] def fullSeedEncoded (n : Nat) : ZMod 2 := fullSeedTable[n % 256]!

theorem fullSeed_matches : ∀ n : Byte,
    fullSeedEncoded n.val = VonoExactIndex.seed (decode n.val) := by
  native_decide

def natDiff (a : Nat) (g : Nat → ZMod 2) (x : Nat) : ZMod 2 :=
  g (Nat.xor x a) + g x

def fullFourth (a b c d : Nat) : ZMod 2 :=
  natDiff a (natDiff b (natDiff c (natDiff d fullSeedEncoded))) 0

private theorem diff_transport (a : Byte)
    (f : SeedVec → ZMod 2) (g : Nat → ZMod 2)
    (hg : ∀ x : Byte, g x.val = f (decode x.val)) :
    ∀ x : Byte, natDiff a.val g x.val =
      VonoExactIndex.diff (decode a.val) f (decode x.val) := by
  intro x
  change g (xorByte x a).val + g x.val = _
  rw [hg (xorByte x a), hg x, decode_xor]
  rfl

theorem fourth_transport (a b c d : Byte) :
    fullFourth a.val b.val c.val d.val =
      VonoExactIndex.diff (decode a.val)
        (VonoExactIndex.diff (decode b.val)
          (VonoExactIndex.diff (decode c.val)
            (VonoExactIndex.diff (decode d.val) VonoExactIndex.seed))) 0 := by
  have hd := diff_transport d VonoExactIndex.seed fullSeedEncoded fullSeed_matches
  have hc := diff_transport c
    (VonoExactIndex.diff (decode d.val) VonoExactIndex.seed)
    (natDiff d.val fullSeedEncoded) hd
  have hb := diff_transport b
    (VonoExactIndex.diff (decode c.val)
      (VonoExactIndex.diff (decode d.val) VonoExactIndex.seed))
    (natDiff c.val (natDiff d.val fullSeedEncoded)) hc
  have ha := diff_transport a
    (VonoExactIndex.diff (decode b.val)
      (VonoExactIndex.diff (decode c.val)
        (VonoExactIndex.diff (decode d.val) VonoExactIndex.seed)))
    (natDiff b.val (natDiff c.val (natDiff d.val fullSeedEncoded))) hb
  exact (ha (0 : Byte)).trans
    (congrArg (VonoExactIndex.diff (decode a.val)
      (VonoExactIndex.diff (decode b.val)
        (VonoExactIndex.diff (decode c.val)
          (VonoExactIndex.diff (decode d.val) VonoExactIndex.seed)))) decode_zero)

def boolValue (b : Bool) : ZMod 2 := if b then 1 else 0

/-- Direct check also includes the quadratic orbit in the repository seed.
It vanishes in these fourth differences. No multilinearity hypothesis. -/
theorem fullFourth_matches_quartic_basis :
    ∀ a b : Byte, ∀ p : Fin 28,
      let ij := QuarticSeedPropertyA.pairs[p.val]!
      fullFourth a.val b.val (2 ^ ij.1) (2 ^ ij.2) =
        boolValue (QuarticSeedPropertyA.fourth
          a.val b.val (2 ^ ij.1) (2 ^ ij.2)) := by
  native_decide

theorem basis_bounds : ∀ p : Fin 28,
    2 ^ (QuarticSeedPropertyA.pairs[p.val]!).1 < 256 ∧
    2 ^ (QuarticSeedPropertyA.pairs[p.val]!).2 < 256 := by
  native_decide


#print axioms fullFourth_matches_quartic_basis
end VonoExactIndex.SeedPropertyABridge

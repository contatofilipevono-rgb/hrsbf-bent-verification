import H12PackedSparse
import H12PackedProductOptimization
import H12PackedTerminal
import H12PackedRoots
namespace H12AffineState
open H12PackedPolynomial H12PackedSparse H12BooleanPolynomial H12CertificateTheory
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def assignment (env : List Nat) (f : Nat → Bool) (i : Nat) : Bool :=
  affineValue f ((env[i]?).getD 0)

def column (env : List Nat) (j : Nat) : Nat :=
  if j = 0 then 1
  else if j < 37 then affineNative ((env[j-1]?).getD 0)
  else H12PackedProductOptimization.product ((env[(j-37)/36]?).getD 0) ((env[(j-37)%36]?).getD 0)

theorem column_sound (env : List Nat) (f : Nat → Bool) (j : Nat) (hj : j < 1333) :
    value 36 f denseBook (column env j) = monomial 36 (assignment env f) (denseMask j) := by
  by_cases hz : j = 0
  · subst j
    have hv := constantNative_sound f true
    simpa [column, denseMask, monomial_zero] using hv
  · by_cases hl : j < 37
    · have hk : j-1 < 36 := by omega
      have he : j = 1+(j-1) := by omega
      have hm : denseMask j = 2^(j-1) := (congrArg denseMask he).trans (dense_unit _ hk)
      simp only [column, hz, hl, ↓reduceIte, affineNative_sound, hm,
        monomial_unit 36 (assignment env f) _ hk, assignment]
    · have hr : (j-37)/36 < 36 := by omega
      have ht : (j-37)%36 < 36 := by omega
      have he : j = 37+((j-37)/36)*36+(j-37)%36 := by omega
      have hm : denseMask j = (2^((j-37)/36) ||| 2^((j-37)%36)) :=
        (congrArg denseMask he).trans (dense_pair _ _ hr ht)
      simp only [column, hz, hl, ↓reduceIte, H12PackedProductOptimization.product_sound, hm, monomial_union,
        monomial_unit 36 (assignment env f) _ hr, monomial_unit 36 (assignment env f) _ ht, assignment]

def compose (env : List Nat) (word : Nat) : Nat := applyFast 1333 (column env) word

theorem compose_sound (env : List Nat) (f : Nat → Bool) (word : Nat) (hw : word < 2^1333) :
    value 36 f denseBook (compose env word) = value 36 (assignment env f) denseBook word := by
  have hwide : word < 2^2048 := Nat.lt_of_lt_of_le hw (Nat.pow_le_pow_right (by decide) (by decide))
  rw [compose, applyFast_eq_sparse _ _ _ hwide]
  apply applySparse_sound
  · intro j hj
    have hj' : j < 1333 := by simpa only [dense_length] using hj
    rw [dense_get j hj']
    exact column_sound env f j hj'
  · simp only [dense_length, Nat.le_refl]
  · exact hw

def Bounded (env : List Nat) : Prop := ∀ word ∈ env, word < 2^37

theorem lookup_bound (env : List Nat) (hb : Bounded env) (j : Nat) : (env[j]?).getD 0 < 2^37 := by
  cases h : env[j]? with
  | none => exact Nat.two_pow_pos _
  | some word => exact hb word (List.mem_of_getElem? h)

theorem lookup_transform (env : List Nat) (i a j : Nat) :
    ((directTransform i a env)[j]?).getD 0 = directSubstitute i a ((env[j]?).getD 0) := by
  cases h : env[j]? <;> simp only [directTransform, List.getElem?_map, h]
  · simp only [Option.map_none, Option.getD_none, directSubstitute, applyFast, ↓reduceIte]
  · rfl

theorem assignment_transform (env : List Nat) (f : Nat → Bool) (i a : Nat) (hi : i < 36)
    (hb : Bounded env) (hn : Bounded (directTransform i a env)) :
    assignment (directTransform i a env) f = assignment env (update f i (affineValue f a)) := by
  funext j
  have ho := lookup_bound env hb j
  have ht := lookup_bound (directTransform i a env) hn j
  have hwide : (env[j]?).getD 0 < 2^1333 :=
    Nat.lt_of_lt_of_le ho (Nat.pow_le_pow_right (by decide) (by decide))
  unfold assignment
  rw [← H12PackedTerminal.value_affine f _ ht, lookup_transform,
    directSubstitute_eq i a _ hwide, scanSubstitute_sound f i a _ hi,
    H12PackedTerminal.value_affine _ _ ho]

#print axioms compose_sound
#print axioms assignment_transform

def composeSystem (env ps : List Nat) : List Nat := ps.map (compose env)

theorem observation_compose (env ps : List Nat) (f : Nat → Bool) (hb : packedBounded ps) :
    packedObservation f (composeSystem env ps) = packedObservation (assignment env f) ps := by
  simp only [packedObservation, composeSystem, List.map_map, Function.comp_def]
  apply List.map_congr_left
  intro word hw
  exact compose_sound env f word (hb word hw)

inductive Refutes (target : List Bool → Prop) (rootPS rootObs : List Nat) : List Nat → Prop
  | contradiction (env indices : List Nat)
      (bounded : packedSelected indices rootPS < 2^1333)
      (identity : scanCanonicalize (compose env (packedSelected indices rootPS)) = 1) : Refutes target rootPS rootObs env
  | eliminate (env : List Nat) (i a : Nat) (hi : i < 36) (indices : List Nat)
      (bounded : packedSelected indices rootPS < 2^1333)
      (identity : scanCanonicalize (compose env (packedSelected indices rootPS)) = affineNative (2^(i+1) ^^^ a))
      (oldBound : Bounded env) (newBound : Bounded (directTransform i a env))
      (child : Refutes target rootPS rootObs (directTransform i a env)) : Refutes target rootPS rootObs env
  | split (env : List Nat) (i a : Nat) (hi : i < 36) (oldBound : Bounded env)
      (zeroBound : Bounded (directTransform i a env))
      (oneBound : Bounded (directTransform i (a ^^^ 1) env))
      (zero : Refutes target rootPS rootObs (directTransform i a env))
      (one : Refutes target rootPS rootObs (directTransform i (a ^^^ 1) env)) : Refutes target rootPS rootObs env
  | terminal (env : List Nat)
      (rejection : ∀ f, ¬target (packedObservation (assignment env f) rootObs)) : Refutes target rootPS rootObs env

theorem refutes_sound (target : List Bool → Prop) (rootPS rootObs env : List Nat)
    (proof : Refutes target rootPS rootObs env) :
    ∀ f, packedModels (assignment env f) rootPS → ¬target (packedObservation (assignment env f) rootObs) := by
  induction proof with
  | contradiction env indices bounded identity =>
    intro f hm _
    have hz := packedSelected_zero (assignment env f) rootPS indices hm
    have he := (scanCanonicalize_sound f (compose env (packedSelected indices rootPS))).trans
      (compose_sound env f (packedSelected indices rootPS) bounded)
    rw [identity, hz] at he
    have ht : value 36 f denseBook 1 = true := by simpa using constantNative_sound f true
    rw [ht] at he
    cases he
  | eliminate env i a hi indices bounded identity oldBound newBound child ih =>
    intro f hm ht
    have hz := packedSelected_zero (assignment env f) rootPS indices hm
    have he := (scanCanonicalize_sound f (compose env (packedSelected indices rootPS))).trans
      (compose_sound env f (packedSelected indices rootPS) bounded)
    rw [identity, hz] at he
    have hu := packedUpdate_eq f i a hi he
    have hg := assignment_transform env f i a hi oldBound newBound
    rw [hu] at hg
    apply ih f (by rwa [hg])
    rwa [hg]
  | split env i a hi oldBound zeroBound oneBound zero one ih0 ih1 =>
    intro f hm ht
    rcases packedUpdate_choice f i a with hu | hu
    · have hg := assignment_transform env f i a hi oldBound zeroBound
      rw [hu] at hg
      apply ih0 f (by rwa [hg])
      rwa [hg]
    · have hg := assignment_transform env f i (a ^^^ 1) hi oldBound oneBound
      rw [hu] at hg
      apply ih1 f (by rwa [hg])
      rwa [hg]
  | terminal env rejection => intro f _; exact rejection f

theorem leaf_sound (env rootObs leafEnv active : List Nat) (tree : H12WitnessSearch.Tree)
    (hb : packedBounded rootObs) (hg : H12WitnessSearch.Good tree)
    (identity : composeSystem env rootObs = leafEnv)
    (hc : H12PackedTerminal.terminalCheckFast leafEnv active tree = true) :
    ∀ f, ¬H12CertificateBridge.Target (packedObservation (assignment env f) rootObs) := by
  intro f
  have hr := H12PackedTerminal.terminalCheckFast_sound leafEnv active tree hg hc f
  rw [← identity, observation_compose env rootObs f hb] at hr
  exact hr

#print axioms refutes_sound
#print axioms leaf_sound

def identityEnv : List Nat := (List.range 36).map (fun i => 2^(i+1))

theorem assignment_identity (f : Nat → Bool) (i : Nat) (hi : i < 36) :
    assignment identityEnv f i = f i := by
  have he : (identityEnv[i]?).getD 0 = 2^(i+1) := by simp [identityEnv, hi]
  rw [assignment, he, affineValue_unit f i hi]

theorem value_assignment_identity (f : Nat → Bool) (word : Nat) :
    value 36 (assignment identityEnv f) denseBook word = value 36 f denseBook word :=
  H12Compose.evaluate_congr 36 _ _ _ (fun i hi => assignment_identity f i hi)

theorem observation_identity (f : Nat → Bool) (ps : List Nat) :
    packedObservation (assignment identityEnv f) ps = packedObservation f ps := by
  apply List.map_congr_left
  intro word _
  exact value_assignment_identity f word

theorem reject_identity (target : List Bool → Prop) (rootPS rootObs : List Nat)
    (proof : Refutes target rootPS rootObs identityEnv) :
    ∀ f, packedModels f rootPS → ¬target (packedObservation f rootObs) := by
  intro f hm ht
  have hr := refutes_sound target rootPS rootObs identityEnv proof f (by
    intro word hw
    rw [value_assignment_identity]
    exact hm word hw)
  apply hr
  rwa [observation_identity]

theorem no_bent_of_affine_state_refutations
    (proof : ∀ k : Fin 3, Refutes H12CertificateBridge.Target
      (H12PackedRoots.rootPS k.val) (H12PackedRoots.rootEnv k.val) identityEnv) :
    ∀ c : BitVec 43, ¬H12Descent.BentAC (H12.quarticFunction c) := by
  intro c hb
  obtain ⟨k,u,he,hm⟩ := H12ChartFilters.bent_root c hb
  have hc := H12PackedRoots.rootClosed k
  have hp : packedModels u.getLsbD (H12PackedRoots.rootPS k.val) :=
    H12PackedRoots.packSystem_models _ _ hc.1 hm
  have hr := reject_identity H12CertificateBridge.Target _ _ (proof k) u.getLsbD hp
  apply hr
  rw [H12PackedRoots.rootEnv, H12PackedRoots.packSystem_observation _ _ hc.2]
  change H12Descent.BentAC (H12.quarticFunction (H12TerminalTheory.fromObservation
    (H12Refutation.observation 36 u.getLsbD (H12CertificateBridge.rootEnv k.val))))
  rw [H12CertificateBridge.root_observation, he]
  exact hb

#print axioms reject_identity
#print axioms no_bent_of_affine_state_refutations
end H12AffineState

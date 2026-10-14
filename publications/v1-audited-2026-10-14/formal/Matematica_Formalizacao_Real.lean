/-!
HRSBF — versão reparada e verificada com Lean 4.15.0.
Este arquivo é autossuficiente: usa apenas Lean Core e não importa Mathlib.

Resultados incondicionais: certificado completo de n=12; identidade de Möbius em
qualquer dimensão; reindexação e ortogonalidade de Walsh; traço M^32 = 85032960;
álgebra condicional de Ward e de desacoplamento; fatoração de Walsh no espaço produto.

Limites explícitos: BitWalkBridge 32 continua hipótese, e a divisibilidade universal
em n=16 e a inexistência cúbica homogênea geral em n=32 não são teoremas deste arquivo.
Os campos e hipóteses dos certificados não foram removidos para fazer o código compilar.
As verificações computacionais usam decide +kernel, sem avaliação nativa admitida.
-/

/- ===== Módulo Core ===== -/
set_option maxRecDepth 1000000
set_option maxHeartbeats 0

namespace HRSBF_Formalizacao_Real

/-!
================================================================================
PARTE I — DEFINIÇÕES REAIS E COMPUTÁVEIS (LEAN 4 CORE PURO)
================================================================================
-/

/-- XOR booleano explícito em `𝔽₂`. -/
def bxor (a b : Bool) : Bool :=
  match a, b with
  | true, false => true
  | false, true => true
  | _, _ => false

/-- Extrai o `i`-ésimo bit de um inteiro natural `x` (representando um vetor em `𝔽₂^n`). -/
def bitAt (x i : Nat) : Bool :=
  decide (x / 2^i % 2 = 1)

/-- Soma sobre `0 ≤ k < m` de uma função natural `f : Nat → Nat`. -/
def sumNatUpTo (m : Nat) (f : Nat → Nat) : Nat :=
  match m with
  | 0 => 0
  | k + 1 => sumNatUpTo k f + f k

/-- Soma sobre `0 ≤ k < m` de uma função inteira `f : Nat → Int`. -/
def sumIntUpTo (m : Nat) (f : Nat → Int) : Int :=
  match m with
  | 0 => 0
  | k + 1 => sumIntUpTo k f + f k

/-- XOR acumulado sobre `0 ≤ k < m` de um predicado booleano `f : Nat → Bool`. -/
def xorUpTo (m : Nat) (f : Nat → Bool) : Bool :=
  match m with
  | 0 => false
  | k + 1 => bxor (xorUpTo k f) (f k)

/-- Peso de Hamming de uma máscara de `n` bits (`|{i < n : bitAt x i = true}|`). -/
def popcount (n x : Nat) : Nat :=
  sumNatUpTo n (fun i => if bitAt x i then 1 else 0)

/-- Paridade do produto escalar `⟨x, u⟩ = ∑_{i=0}^{n-1} x_i u_i (mod 2)` em `𝔽₂^n`. -/
def dotParity (n x u : Nat) : Bool :=
  xorUpTo n (fun i => bitAt x i && bitAt u i)

/-- Caractere aditivo `χ(b) = (-1)^b ∈ ℤ`. -/
def signInt (b : Bool) : Int :=
  if b then -1 else 1

/-- Peso de Hamming exato de uma função booleana `f` em `n` variáveis (`0 ≤ x < 2^n`). -/
def hammingWeight (n : Nat) (f : Nat → Bool) : Nat :=
  sumNatUpTo (2 ^ n) (fun x => if f x then 1 else 0)

/-- Transformada de Walsh-Hadamard inteira exata:
    `W_f(u) = ∑_{x=0}^{2^n - 1} (-1)^{f(x) ⊕ ⟨x, u⟩}`. -/
def walsh (n : Nat) (f : Nat → Bool) (u : Nat) : Int :=
  sumIntUpTo (2 ^ n) (fun x => signInt (bxor (f x) (dotParity n x u)))

/-- Definição real de função *bent* em dimensão par `n`:
    para toda frequência `u < 2^n`, `(walsh n f u) * (walsh n f u) = 2^n`. -/
def IsBent (n : Nat) (f : Nat → Bool) : Prop :=
  ∀ u : Nat, u < 2 ^ n → walsh n f u * walsh n f u = (2 : Int) ^ n

/-- Rotação cíclica de 1 passo das `n` coordenadas binárias de `x < 2^n`. -/
def rotShift (n x : Nat) : Nat :=
  sumNatUpTo n (fun i => if bitAt x ((i + 1) % n) then 2 ^ i else 0)

/-- Definição real de simetria por rotação (RS) em `n` variáveis. -/
def IsRotationSymmetric (n : Nat) (f : Nat → Bool) : Prop :=
  ∀ x : Nat, x < 2 ^ n → f (rotShift n x) = f x

/-- Coeficiente da Forma Normal Algébrica (ANF) no monômio codificado pela máscara `s < 2^n`,
    calculado por inversão de Möbius booleana sobre todos os subconjuntos `t ⊆ s`. -/
def anfCoeffDirect (n : Nat) (f : Nat → Bool) (s : Nat) : Bool :=
  xorUpTo (2 ^ n) (fun t => (((t &&& s) == t) && f t))

/-- Möbius recursion on the low bit; proved equal to the full subset sum in Mobius. -/
def anfCoeff : Nat → (Nat → Bool) → Nat → Bool
  | 0, f, _ => f 0
  | k+1, f, s => bxor
      (anfCoeff k (fun t => f (2*t)) (s/2))
      (if s % 2 == 1 then anfCoeff k (fun t => f (2*t+1)) (s/2) else false)

/-- `f` possui grau algébrico no máximo `d` se todo monômio ativo `s < 2^n` tem `popcount n s ≤ d`. -/
def HasDegreeAtMost (n d : Nat) (f : Nat → Bool) : Prop :=
  ∀ s : Nat, s < 2 ^ n → anfCoeff n f s = true → popcount n s ≤ d

/-- `f` é cúbica (grau algébrico exato 3) se tem grau `≤ 3` e possui ao menos um monômio ativo de peso 3. -/
def IsCubic (n : Nat) (f : Nat → Bool) : Prop :=
  HasDegreeAtMost n 3 f ∧ (∃ s : Nat, s < 2 ^ n ∧ anfCoeff n f s = true ∧ popcount n s = 3)

/-- `f` é cúbica homogênea se é cúbica e todo monômio ativo na ANF tem peso exatamente 3. -/
def IsHomogeneousCubic (n : Nat) (f : Nat → Bool) : Prop :=
  IsCubic n f ∧ (∀ s : Nat, s < 2 ^ n → anfCoeff n f s = true → popcount n s = 3)

/-- **Definição Explícita da Função Contraexemplo Não-Homogênea `f₁₂` em `n = 12`**:
    `f₁₂(x) = ⨁_{i=0}^{11} x_i x_{i+2} x_{i+6} ⊕ ⨁_{i=0}^{11} x_i x_{i+1} ⊕ ⨁_{i=0}^{5} x_i x_{i+6}`. -/
def f12_explicit (x : Nat) : Bool :=
  let cubic_026 := xorUpTo 12 (fun i =>
    bitAt x i && bitAt x ((i + 2) % 12) && bitAt x ((i + 6) % 12))
  let quad_01 := xorUpTo 12 (fun i =>
    bitAt x i && bitAt x ((i + 1) % 12))
  let quad_06 := xorUpTo 6 (fun i =>
    bitAt x i && bitAt x (i + 6))
  bxor (bxor cubic_026 quad_01) quad_06

/-- Permutação `π₆ : 𝔽₂^6 → 𝔽₂^6` de Maiorana–McFarland induzida por `f₁₂` nas fibras `x = (u, u ⊕ z)`. -/
def pi6Bit (z i : Nat) : Bool :=
  let zi   := bitAt z (i % 6)
  let zi2  := bitAt z ((i + 2) % 6)
  let zi1  := bitAt z ((i + 1) % 6)
  let zi5  := bitAt z ((i + 5) % 6)
  bxor (bxor ((!zi) && (!zi2)) zi1) zi5

def pi6 (z : Nat) : Nat :=
  sumNatUpTo 6 (fun i => if pi6Bit z i then 2 ^ i else 0)

/-- Fase `h₆(z) = ⨁_{i=0}^{4} z_i z_{i+1}` nas fibras antipodais de `f₁₂`. -/
def h6 (z : Nat) : Bool :=
  xorUpTo 5 (fun i => bitAt z i && bitAt z (i + 1))

/-- Representação de Maiorana–McFarland de `f₁₂` nas coordenadas `(u, z) ∈ 𝔽₂^6 × 𝔽₂^6`. -/
def f12_mm (u z : Nat) : Bool :=
  bxor (dotParity 6 (pi6 z) u) (h6 z)

/-- Avaliação rápida de Walsh de `f₁₂` via redução analítica nas `64` fibras de Maiorana–McFarland. -/
def walshMM12 (w : Nat) : Int :=
  let a := w &&& 63
  let b := (w >>> 6) &&& 63
  let target := a ^^^ b
  sumIntUpTo 64 (fun z =>
    if pi6 z == target then
      (64 : Int) * signInt (bxor (h6 z) (dotParity 6 b z))
    else 0)

/-- **Definição Explícita da Órbita Cúbica Elementar `H_n` e `H₃₂`**:
    `H_n(x) = ⨁_{i=0}^{n-1} x_i x_{i+1} x_{i+2}` (índices módulo `n`). -/
def Hn_explicit (n x : Nat) : Bool :=
  xorUpTo n (fun i =>
    bitAt x i && bitAt x ((i + 1) % n) && bitAt x ((i + 2) % n))

def H32_explicit (x : Nat) : Bool :=
  Hn_explicit 32 x

/-- Matriz inteira `4 × 4` representada como função de índices `(i, j) ∈ {0,1,2,3}²`. -/
abbrev Mat4 := Nat → Nat → Int

def mat4Id : Mat4 :=
  fun i j => if i == j then 1 else 0

def mat4Mul (A B : Mat4) : Mat4 :=
  fun i j => sumIntUpTo 4 (fun k => A i k * B k j)

def mat4Pow (M : Mat4) (e : Nat) : Mat4 :=
  match e with
  | 0 => mat4Id
  | k + 1 => mat4Mul (mat4Pow M k) M

def mat4Trace (M : Mat4) : Int :=
  M 0 0 + M 1 1 + M 2 2 + M 3 3

/-- Matriz de transferência `4 × 4` para `H_n(x)`:
    estados `s = 2*a + b ∈ {0,1,2,3}` codificam pares consecutivos `(x_i, x_{i+1}) ∈ {0,1}²`. -/
def M_H32 : Mat4 :=
  fun sFrom sTo =>
    let a := (sFrom >>> 1) &&& 1
    let b := sFrom &&& 1
    let b' := (sTo >>> 1) &&& 1
    let c := sTo &&& 1
    if b == b' then
      if (a == 1) && (b == 1) && (c == 1) then -1 else 1
    else 0

/-- Soma exponencial recursiva de caminhadas abertas de comprimento `k` entre os estados de borda
    `s0 = (x_0, x_1)` e `sk = (x_k, x_{k+1})` no grafo de de Bruijn de 2 bits com pesos `(-1)^{x_i x_{i+1} x_{i+2}}`. -/
def openWalkSum (k : Nat) (s0 sk : Nat) : Int :=
  match k with
  | 0 => if s0 == sk then 1 else 0
  | m + 1 => sumIntUpTo 4 (fun sm => openWalkSum m s0 sm * M_H32 sm sk)

/-- Soma exponencial cíclica fechada de comprimento `n` sobre todas as caminhadas periódicas
    `(x_n, x_{n+1}) = (x_0, x_1)`: `∑_{s0=0}^3 openWalkSum n s0 s0`. -/
def closedCycleWalsh (n : Nat) : Int :=
  sumIntUpTo 4 (fun s0 => openWalkSum n s0 s0)

/-- Projeção nas 16 coordenadas de índices pares `x_E = (x_0, x_2, ..., x_{30})`. -/
def projEven32 (x : Nat) : Nat :=
  sumNatUpTo 16 (fun i => if bitAt x (2 * i) then 2 ^ i else 0)

/-- Projeção nas 16 coordenadas de índices ímpares `x_O = (x_1, x_3, ..., x_{31})`. -/
def projOdd32 (x : Nat) : Nat :=
  sumNatUpTo 16 (fun i => if bitAt x (2 * i + 1) then 2 ^ i else 0)

/-- Órbita cúbica de 16 variáveis gerada pela tripla `(i, j, k)`:
    `orbit16(i,j,k)(y) = ⨁_{t=0}^{15} y_{(i+t) mod 16} y_{(j+t) mod 16} y_{(k+t) mod 16}`. -/
def orbit16 (i j k : Nat) (y : Nat) : Bool :=
  xorUpTo 16 (fun t =>
    bitAt y ((i + t) % 16) && bitAt y ((j + t) % 16) && bitAt y ((k + t) % 16))


/-!
================================================================================
PARTE II — HIPÓTESES EXTERNAS E ESTRUTURAS DE CERTIFICADOS CORRIGIDAS
================================================================================
-/

/-- **CORREÇÃO 1**: `CounterexampleN12Certificate f` exige diretamente `bent : IsBent 12 f`
    (isto é, `∀ u < 4096, walsh 12 f u * walsh 12 f u = 2^{12}`), dependendo explicitamente de `f`. -/
structure CounterexampleN12Certificate (f : Nat → Bool) : Prop where
  rot_symm : IsRotationSymmetric 12 f
  deg_le_3 : HasDegreeAtMost 12 3 f
  has_cubic_term : anfCoeff 12 f 69 = true ∧ popcount 12 69 = 3
  has_quad_term : anfCoeff 12 f 3 = true ∧ popcount 12 3 = 2
  non_homogeneous : ¬ IsHomogeneousCubic 12 f
  weight_eq_2080 : hammingWeight 12 f = 2080
  bent : IsBent 12 f

/-- Estrutura de Certificado para a Barreira de Divisibilidade de Ward em `n = 16`. -/
structure WardDivisibilityN16Certificate (C : (Nat → Bool) → Prop) : Prop where
  walsh_zero_link : ∀ g : Nat → Bool,
    walsh 16 g 0 = (65536 : Int) - 2 * (Int.ofNat (hammingWeight 16 g))
  weight_div_256 : ∀ g : Nat → Bool, C g → ∃ k : Nat, hammingWeight 16 g = 256 * k

/-- Estrutura de Certificado para o Desacoplamento por Paridade em `n = 32`. -/
structure ParityDecouplingN32Certificate (f g : Nat → Bool) : Prop where
  splits : ∀ x : Nat, x < 2 ^ 32 → f x = bxor (g (projEven32 x)) (g (projOdd32 x))
  walsh_diagonal_factor : ∀ u : Nat, u < 2 ^ 16 → ∃ u_pair : Nat,
    u_pair < 2 ^ 32 ∧ walsh 32 f u_pair = walsh 16 g u * walsh 16 g u


/-!
================================================================================
PARTE III — ÁLGEBRA EXATA SEM `omega` NÃO-LINEAR, PONTE `allUpTo_sound`,
            FATORAÇÃO 2D DE WALSH E PROVAS PARA `n = 12`, `n = 16`, `n = 32`
================================================================================
-/

/-- Verificador booleano recursivo para quantificação universal limitada `∀ k < m, p k = true`. -/
def allUpTo (m : Nat) (p : Nat → Bool) : Bool :=
  match m with
  | 0 => true
  | k + 1 => allUpTo k p && p k

theorem band_eq_true_left {a b : Bool} (h : (a && b) = true) : a = true := by
  cases a <;> cases b <;> first | rfl | contradiction

theorem band_eq_true_right {a b : Bool} (h : (a && b) = true) : b = true := by
  cases a <;> cases b <;> first | rfl | contradiction

/-- **Teorema de Correção (Soundness) de `allUpTo`**:
    Converte `allUpTo m p = true` em `∀ i < m, p i = true` por indução em `m`. -/
theorem allUpTo_sound (m : Nat) (p : Nat → Bool) (h : allUpTo m p = true) :
    ∀ i : Nat, i < m → p i = true := by
  induction m with
  | zero =>
    intro i hi
    omega
  | succ k ih =>
    intro i hi
    change (allUpTo k p && p k) = true at h
    have h1 : allUpTo k p = true := band_eq_true_left h
    have h2 : p k = true := band_eq_true_right h
    by_cases hik : i = k
    · subst hik
      exact h2
    · have hilt : i < k := by omega
      exact ih h1 i hilt


/-!
### III.A — CORREÇÃO 3: Identidades Algébricas Não-Lineares sobre `Int` Provadas Explicitamente
Nenhum passo polinomial de grau `≥ 2` é entregue a `omega`.
-/

/-- **Identidade Algébrica da Diferença de Quadrados (`diff_of_squares`)**:
    Demonstrada passo a passo via `Int.mul_add`, `Int.add_mul`, `Int.neg_mul` e `Int.mul_comm`. -/
theorem diff_of_squares (x y : Int) : (x - y) * (x + y) = x * x - y * y := by
  calc
    (x - y) * (x + y) = (x + -y) * (x + y) := by rw [Int.sub_eq_add_neg]
    _ = (x + -y) * x + (x + -y) * y := by rw [Int.mul_add]
    _ = (x * x + (-y) * x) + (x * y + (-y) * y) := by rw [Int.add_mul, Int.add_mul]
    _ = (x * x + -(y * x)) + (x * y + -(y * y)) := by rw [Int.neg_mul, Int.neg_mul]
    _ = (x * x + -(x * y)) + (x * y + -(y * y)) := by rw [Int.mul_comm y x]
    _ = x * x - y * y := by omega

/-- **Monotonicidade Estrita de Quadrados para Inteiros Não-Negativos (`sq_lt_sq_of_nonneg`)**:
    Se `0 ≤ b` e `b < a`, então `b * b < a * a`.
    Prova: `a * a - b * b = (a - b) * (a + b) > 0` por `diff_of_squares` e `Int.mul_pos`. -/
theorem sq_lt_sq_of_nonneg {a b : Int} (hb : 0 ≤ b) (hab : b < a) :
    b * b < a * a := by
  have h_sub : 0 < a - b := by omega
  have h_add : 0 < a + b := by omega
  have h_prod : 0 < (a - b) * (a + b) := Int.mul_pos h_sub h_add
  rw [diff_of_squares] at h_prod
  omega

/-- Simetria do quadrado sob negação: `(-x) * (-x) = x * x`. -/
theorem neg_sq_eq_sq (x : Int) : (-x) * (-x) = x * x := by
  rw [Int.neg_mul_neg]

/-- **Lema Condicional 1 Reparado (Aritmética de Ward em `n = 16` sem `omega` não-linear)**:
    Se `W₀ = 65536 - 2 * wt` e `wt = 256 * k`, então `W₀ * W₀ ≠ 65536`.
    Prova explícita por divisão nos 3 casos lineares `k = 128`, `k < 128` e `k > 128`. -/
theorem walsh_zero_sq_ne_65536_of_dvd_256
    (W0 : Int) (wt : Nat)
    (h_link : W0 = 65536 - 2 * (Int.ofNat wt))
    (h_div : ∃ k : Nat, wt = 256 * k) :
    W0 * W0 ≠ (2 : Int) ^ 16 := by
  rcases h_div with ⟨k, rfl⟩
  change W0 = 65536 - 2 * ((256 : Int) * (k : Int)) at h_link
  have h_pow : ((2 : Int) ^ 16) = 65536 := by decide
  rw [h_pow]
  have h_256 : (256 : Int) * 256 = 65536 := by decide
  have h_tri : k = 128 ∨ k < 128 ∨ 128 < k := by omega
  rcases h_tri with h_eq | h_lt | h_gt
  · subst h_eq
    have hW0 : W0 = 0 := by omega
    rw [hW0]
    decide +kernel
  · have hW0_ge : 512 ≤ W0 := by omega
    have h_lt256 : (256 : Int) < W0 := by omega
    have h_sq_gt : (256 : Int) * 256 < W0 * W0 :=
      sq_lt_sq_of_nonneg (by decide : (0 : Int) ≤ 256) h_lt256
    rw [h_256] at h_sq_gt
    omega
  · have hW0_le : W0 ≤ -512 := by omega
    have h_lt256 : (256 : Int) < -W0 := by omega
    have h_sq_gt : (256 : Int) * 256 < (-W0) * (-W0) :=
      sq_lt_sq_of_nonneg (by decide : (0 : Int) ≤ 256) h_lt256
    rw [neg_sq_eq_sq, h_256] at h_sq_gt
    omega

/-- **Lema Condicional 2 (Exclusão em `n = 16` via `WardDivisibilityN16Certificate`)**: -/
theorem not_bent_n16_of_ward_certificate
    {C : (Nat → Bool) → Prop}
    (cert : WardDivisibilityN16Certificate C)
    {g : Nat → Bool} (hg : C g) :
    ¬ IsBent 16 g := by
  intro h_bent
  have h0_lt : (0 : Nat) < 2 ^ 16 := by decide
  have h_zero : walsh 16 g 0 * walsh 16 g 0 = (2 : Int) ^ 16 := h_bent 0 h0_lt
  have h_ne := walsh_zero_sq_ne_65536_of_dvd_256
    (walsh 16 g 0) (hammingWeight 16 g) (cert.walsh_zero_link g) (cert.weight_div_256 g hg)
  exact h_ne h_zero

/-- **Lema Condicional 3 Reparado (Exclusão em `n = 32` via Desacoplamento sem `omega` não-linear)**:
    Se `W_f(u_pair) = W_g(u₀) * W_g(u₀)` e `W_g(u₀) * W_g(u₀) ≠ 2^{16}`, então
    `W_f(u_pair) * W_f(u_pair) ≠ 2^{32}`, logo `f` não é *bent* em 32 variáveis.
    Prova explícita via `sq_lt_sq_of_nonneg` e `Int.mul_self_nonneg`. -/
theorem walsh32_sq_ne_of_walsh16_sq_ne
    (Wf Wg : Int)
    (h_mul : Wf = Wg * Wg)
    (h_ne16 : Wg * Wg ≠ (2 : Int) ^ 16) :
    Wf * Wf ≠ (2 : Int) ^ 32 := by
  have h_p16 : ((2 : Int) ^ 16) = 65536 := by decide
  have h_p32 : ((2 : Int) ^ 32) = (65536 : Int) * 65536 := by decide
  rw [h_p16] at h_ne16
  rw [h_p32, h_mul]
  have h_nonneg : (0 : Int) ≤ Wg * Wg := by
    by_cases h : 0 ≤ Wg
    · exact Int.mul_nonneg h h
    · have hn : 0 ≤ -Wg := by omega
      have hp := Int.mul_nonneg hn hn
      simpa only [Int.neg_mul_neg] using hp
  have h_split : Wg * Wg < 65536 ∨ 65536 < Wg * Wg := by omega
  rcases h_split with h_lt | h_gt
  · have h_sq := sq_lt_sq_of_nonneg h_nonneg h_lt
    omega
  · have h_sq := sq_lt_sq_of_nonneg (by decide : (0 : Int) ≤ 65536) h_gt
    omega

theorem not_bent_n32_of_parity_decoupling
    {f g : Nat → Bool}
    (cert : ParityDecouplingN32Certificate f g)
    {u0 : Nat} (hu0 : u0 < 2 ^ 16)
    (h_not_bent_u0 : walsh 16 g u0 * walsh 16 g u0 ≠ (2 : Int) ^ 16) :
    ¬ IsBent 32 f := by
  intro h_bent32
  rcases cert.walsh_diagonal_factor u0 hu0 with ⟨u_pair, hu_pair, h_mul⟩
  have h_sq32 : walsh 32 f u_pair * walsh 32 f u_pair = (2 : Int) ^ 32 := h_bent32 u_pair hu_pair
  have h_ne32 := walsh32_sq_ne_of_walsh16_sq_ne (walsh 32 f u_pair) (walsh 16 g u0) h_mul h_not_bent_u0
  exact h_ne32 h_sq32


/-!
### III.B — CORREÇÃO 1: Provas para `n = 12` com Ponte Completa para `walsh 12 f12_explicit` e `IsBent 12 f12_explicit`
-/


-- Balanced finite sums, with proofs relating them to the original definitions.
def sumNatTree (n start : Nat) (f : Nat → Nat) : Nat :=
  match n with
  | 0 => f start
  | k+1 => sumNatTree k start f + sumNatTree k (start + 2^k) f

def sumIntTree (n start : Nat) (f : Nat → Int) : Int :=
  match n with
  | 0 => f start
  | k+1 => sumIntTree k start f + sumIntTree k (start + 2^k) f

def xorTree (n start : Nat) (f : Nat → Bool) : Bool :=
  match n with
  | 0 => f start
  | k+1 => bxor (xorTree k start f) (xorTree k (start + 2^k) f)

def allTree (n start : Nat) (f : Nat → Bool) : Bool :=
  match n with
  | 0 => f start
  | k+1 => allTree k start f && allTree k (start + 2^k) f

theorem sumNatUpTo_add (m n : Nat) (f : Nat → Nat) :
    sumNatUpTo (m+n) f = sumNatUpTo m f + sumNatUpTo n (fun i => f (m+i)) := by
  induction n with
  | zero => simp [sumNatUpTo]
  | succ n ih =>
    change sumNatUpTo (m+n) f + f (m+n) = sumNatUpTo m f + (sumNatUpTo n (fun i => f (m+i)) + f (m+n))
    rw [ih]
    omega

theorem sumIntUpTo_add (m n : Nat) (f : Nat → Int) :
    sumIntUpTo (m+n) f = sumIntUpTo m f + sumIntUpTo n (fun i => f (m+i)) := by
  induction n with
  | zero => simp [sumIntUpTo]
  | succ n ih =>
    change sumIntUpTo (m+n) f + f (m+n) = sumIntUpTo m f + (sumIntUpTo n (fun i => f (m+i)) + f (m+n))
    rw [ih]
    omega

theorem bxor_assoc (a b c : Bool) : bxor (bxor a b) c = bxor a (bxor b c) := by
  cases a <;> cases b <;> cases c <;> rfl

theorem xorUpTo_add (m n : Nat) (f : Nat → Bool) :
    xorUpTo (m+n) f = bxor (xorUpTo m f) (xorUpTo n (fun i => f (m+i))) := by
  induction n with
  | zero => simp only [Nat.add_zero, xorUpTo]; cases xorUpTo m f <;> rfl
  | succ n ih =>
    change bxor (xorUpTo (m+n) f) (f (m+n)) = bxor (xorUpTo m f) (bxor (xorUpTo n (fun i => f (m+i))) (f (m+n)))
    rw [ih, bxor_assoc]

theorem allUpTo_add (m n : Nat) (f : Nat → Bool) :
    allUpTo (m+n) f = (allUpTo m f && allUpTo n (fun i => f (m+i))) := by
  induction n with
  | zero => simp [allUpTo]
  | succ n ih =>
    change (allUpTo (m+n) f && f (m+n)) = (allUpTo m f && (allUpTo n (fun i => f (m+i)) && f (m+n)))
    rw [ih, Bool.and_assoc]

theorem sumNatTree_eq (n start : Nat) (f : Nat → Nat) :
    sumNatTree n start f = sumNatUpTo (2^n) (fun i => f (start+i)) := by
  induction n generalizing start with
  | zero => simp [sumNatTree, sumNatUpTo]
  | succ n ih =>
    have hp : 2^(n+1) = 2^n + 2^n := by simp [Nat.pow_succ, Nat.mul_two]
    simp only [sumNatTree, ih, hp, sumNatUpTo_add]
    simp only [Nat.add_assoc]

theorem sumIntTree_eq (n start : Nat) (f : Nat → Int) :
    sumIntTree n start f = sumIntUpTo (2^n) (fun i => f (start+i)) := by
  induction n generalizing start with
  | zero => simp [sumIntTree, sumIntUpTo]
  | succ n ih =>
    have hp : 2^(n+1) = 2^n + 2^n := by simp [Nat.pow_succ, Nat.mul_two]
    simp only [sumIntTree, ih, hp, sumIntUpTo_add]
    simp only [Nat.add_assoc]

theorem xorTree_eq (n start : Nat) (f : Nat → Bool) :
    xorTree n start f = xorUpTo (2^n) (fun i => f (start+i)) := by
  induction n generalizing start with
  | zero => simp only [Nat.pow_zero, xorUpTo, Nat.zero_add, Nat.add_zero, xorTree]; cases f start <;> rfl
  | succ n ih =>
    have hp : 2^(n+1) = 2^n + 2^n := by simp [Nat.pow_succ, Nat.mul_two]
    simp only [xorTree, ih, hp, xorUpTo_add]
    simp only [Nat.add_assoc]

theorem allTree_eq (n start : Nat) (f : Nat → Bool) :
    allTree n start f = allUpTo (2^n) (fun i => f (start+i)) := by
  induction n generalizing start with
  | zero => simp [allTree, allUpTo]
  | succ n ih =>
    have hp : 2^(n+1) = 2^n + 2^n := by simp [Nat.pow_succ, Nat.mul_two]
    simp only [allTree, ih, hp, allUpTo_add]
    simp only [Nat.add_assoc]



end HRSBF_Formalizacao_Real

/- ===== Módulo Fourier ===== -/
namespace HRSBF_Formalizacao_Real
set_option maxRecDepth 10000
set_option maxHeartbeats 0

theorem sumInt_congr (m : Nat) (f g : Nat → Int)
    (h : ∀ i, i < m → f i = g i) : sumIntUpTo m f = sumIntUpTo m g := by
  induction m with
  | zero => rfl
  | succ m ih =>
    change sumIntUpTo m f + f m = sumIntUpTo m g + g m
    rw [ih (fun i hi => h i (by omega)), h m (by omega)]

theorem sumNat_congr (m : Nat) (f g : Nat → Nat)
    (h : ∀ i, i < m → f i = g i) : sumNatUpTo m f = sumNatUpTo m g := by
  induction m with
  | zero => rfl
  | succ m ih =>
    change sumNatUpTo m f + f m = sumNatUpTo m g + g m
    rw [ih (fun i hi => h i (by omega)), h m (by omega)]

theorem xor_congr (m : Nat) (f g : Nat → Bool)
    (h : ∀ i, i < m → f i = g i) : xorUpTo m f = xorUpTo m g := by
  induction m with
  | zero => rfl
  | succ m ih =>
    change bxor (xorUpTo m f) (f m) = bxor (xorUpTo m g) (g m)
    rw [ih (fun i hi => h i (by omega)), h m (by omega)]

theorem sumInt_add (m : Nat) (f g : Nat → Int) :
    sumIntUpTo m (fun i => f i + g i) = sumIntUpTo m f + sumIntUpTo m g := by
  induction m with
  | zero => rfl
  | succ m ih =>
    change sumIntUpTo m (fun i => f i + g i) + (f m + g m) = (sumIntUpTo m f + f m) + (sumIntUpTo m g + g m)
    rw [ih]; omega

theorem sumInt_swap (m n : Nat) (f : Nat → Nat → Int) :
    sumIntUpTo m (fun i => sumIntUpTo n (f i)) =
      sumIntUpTo n (fun j => sumIntUpTo m (fun i => f i j)) := by
  induction m with
  | zero =>
    induction n with
    | zero => rfl
    | succ n ih =>
      change (0 : Int) = sumIntUpTo n (fun _ => 0) at ih
      change (0 : Int) = sumIntUpTo n (fun _ => 0) + 0
      omega
  | succ m ih =>
    change sumIntUpTo m (fun i => sumIntUpTo n (f i)) + sumIntUpTo n (f m) = _
    rw [ih, ← sumInt_add]
    rfl

theorem sumInt_blocks (m n : Nat) (f : Nat → Int) :
    sumIntUpTo (m*n) f = sumIntUpTo m (fun b => sumIntUpTo n (fun a => f (b*n+a))) := by
  induction m with
  | zero => simp only [Nat.zero_mul, sumIntUpTo]
  | succ m ih =>
    rw [Nat.succ_mul, sumIntUpTo_add, ih]
    rfl

def listSumI : List Int → Int
  | [] => 0
  | a::xs => a + listSumI xs

theorem listSumI_append (xs ys : List Int) : listSumI (xs++ys) = listSumI xs + listSumI ys := by
  induction xs with
  | nil => simp [listSumI]
  | cons x xs ih =>
    change x + listSumI (xs++ys) = (x + listSumI xs) + listSumI ys
    rw [ih]
    omega

theorem listSumI_perm {xs ys : List Int} (h : xs.Perm ys) : listSumI xs = listSumI ys := by
  induction h with
  | nil => rfl
  | cons a h ih => simp only [listSumI, ih]
  | swap a b xs => simp only [listSumI]; omega
  | trans _ _ ih1 ih2 => exact ih1.trans ih2

theorem sumInt_list (n : Nat) (f : Nat → Int) : sumIntUpTo n f = listSumI ((List.range n).map f) := by
  induction n with
  | zero => rfl
  | succ n ih =>
    rw [List.range_succ, List.map_append, listSumI_append]
    change sumIntUpTo n f + f n = listSumI ((List.range n).map f) + (f n + 0)
    rw [ih]; omega

theorem sumInt_reindex (n : Nat) (s : Nat → Nat)
    (hp : ((List.range n).map s).Perm (List.range n)) (f : Nat → Int) :
    sumIntUpTo n (fun i => f (s i)) = sumIntUpTo n f := by
  rw [sumInt_list, sumInt_list]
  have h := listSumI_perm (hp.map f)
  simpa only [List.map_map] using h

theorem bitAt_testBit (x i : Nat) : bitAt x i = x.testBit i := by
  exact Nat.testBit_to_div_mod.symm

theorem bitAt_xor (x y i : Nat) : bitAt (x ^^^ y) i = bxor (bitAt x i) (bitAt y i) := by
  simp only [bitAt_testBit, Nat.testBit_xor]
  cases x.testBit i <;> cases y.testBit i <;> rfl

theorem dotParity_xor_right (n x a b : Nat) :
    dotParity n x (a ^^^ b) = bxor (dotParity n x a) (dotParity n x b) := by
  induction n with
  | zero => rfl
  | succ n ih =>
    change bxor (dotParity n x (a ^^^ b)) (bitAt x n && bitAt (a ^^^ b) n) =
      bxor (bxor (dotParity n x a) (bitAt x n && bitAt a n)) (bxor (dotParity n x b) (bitAt x n && bitAt b n))
    rw [ih, bitAt_xor]
    cases dotParity n x a <;> cases dotParity n x b <;> cases bitAt x n <;>
      cases bitAt a n <;> cases bitAt b n <;> rfl

theorem dotParity_comm (n a b : Nat) : dotParity n a b = dotParity n b a := by
  unfold dotParity
  congr 1
  funext i
  exact Bool.and_comm _ _

theorem bitAt_join_low (u v i : Nat) (hu : u < 64) (hi : i < 6) :
    bitAt (u+64*v) i = bitAt u i := by
  have he : u+64*v = 2^6*v+u := by omega
  rw [he]
  simp only [bitAt_testBit, Nat.testBit_mul_pow_two_add v (by exact hu : u < 2^6) i, if_pos hi]

theorem bitAt_join_high (u v i : Nat) (hu : u < 64) :
    bitAt (u+64*v) (6+i) = bitAt v i := by
  have he : u+64*v = 2^6*v+u := by omega
  rw [he]
  simp only [bitAt_testBit, Nat.testBit_mul_pow_two_add v (by exact hu : u < 2^6) (6+i)]
  rw [if_neg (by omega), show 6+i-6=i by omega]

theorem dotParity_join (u v a b : Nat) (hu : u < 64) (ha : a < 64) :
    dotParity 12 (u+64*v) (a+64*b) = bxor (dotParity 6 u a) (dotParity 6 v b) := by
  change xorUpTo (6+6) _ = _
  rw [xorUpTo_add]
  have h1 : xorUpTo 6 (fun i => bitAt (u+64*v) i && bitAt (a+64*b) i) = dotParity 6 u a := by
    apply xor_congr
    intro i hi
    rw [bitAt_join_low u v i hu hi, bitAt_join_low a b i ha hi]
  rw [h1]
  have h2 : xorUpTo 6 (fun i => bitAt (u+64*v) (6+i) && bitAt (a+64*b) (6+i)) = dotParity 6 v b := by
    apply xor_congr
    intro i hi
    rw [bitAt_join_high u v i hu, bitAt_join_high a b i ha]
  rw [h2]

theorem dotParity_xor_left (n a b u : Nat) :
    dotParity n (a ^^^ b) u = bxor (dotParity n a u) (dotParity n b u) := by
  rw [dotParity_comm n (a ^^^ b) u, dotParity_xor_right]
  rw [dotParity_comm n u a, dotParity_comm n u b]

theorem sumInt_mul_right (m : Nat) (f : Nat → Int) (c : Int) :
    sumIntUpTo m (fun i => f i * c) = sumIntUpTo m f * c := by
  induction m with
  | zero => simp [sumIntUpTo]
  | succ m ih =>
    change sumIntUpTo m (fun i => f i*c) + f m*c = (sumIntUpTo m f + f m)*c
    rw [ih, Int.add_mul]

theorem signInt_bxor (a b : Bool) : signInt (bxor a b) = signInt a * signInt b := by
  cases a <;> cases b <;> rfl

theorem character_five (p h a b z : Bool) :
    signInt (bxor (bxor p h) (bxor a (bxor b z))) =
      signInt (bxor p (bxor a b)) * signInt (bxor h z) := by
  cases p <;> cases h <;> cases a <;> cases b <;> cases z <;> rfl

end HRSBF_Formalizacao_Real

/- ===== Módulo Mobius ===== -/
namespace HRSBF_Formalizacao_Real
set_option maxRecDepth 10000
set_option maxHeartbeats 0

theorem bxor_zero_right (a : Bool) : bxor a false = a := by cases a <;> rfl
theorem bxor_zero_left (a : Bool) : bxor false a = a := by cases a <;> rfl

theorem subset_even (t s : Nat) : ((2*t &&& s) == 2*t) = ((t &&& (s/2)) == t) := by
  apply Bool.eq_iff_iff.mpr
  simp only [beq_iff_eq]
  have hd := Nat.and_div_two (a := 2*t) (b := s)
  have hm : (2*t &&& s) % 2 = 0 := by
    have hz : (2*t) % 2 = 0 := by omega
    have hne : ¬ (2*t &&& s) % 2 = 1 := by
      rw [Nat.and_mod_two_eq_one, hz]
      omega
    omega
  have ht : 2*t/2=t := by omega
  rw [ht] at hd
  constructor
  · intro h; rw [h] at hd; omega
  · intro h; rw [h] at hd; omega

theorem subset_odd (t s : Nat) : ((2*t+1 &&& s) == 2*t+1) =
    ((s % 2 == 1) && ((t &&& (s/2)) == t)) := by
  apply Bool.eq_iff_iff.mpr
  simp only [Bool.and_eq_true, beq_iff_eq]
  have hd := Nat.and_div_two (a := 2*t+1) (b := s)
  have ht : (2*t+1)/2=t := by omega
  rw [ht] at hd
  have hm : (2*t+1 &&& s) % 2 = 1 ↔ s % 2 = 1 := by
    rw [Nat.and_mod_two_eq_one]
    omega
  constructor
  · intro h
    have hmod : (2*t+1 &&& s)%2=1 := by rw [h]; omega
    have hq : (t &&& (s/2))=t := by rw [h] at hd; omega
    exact ⟨hm.mp hmod, hq⟩
  · intro h
    have hmod := hm.mpr h.1
    rw [h.2] at hd
    omega

theorem xor_even_odd (m : Nat) (f : Nat → Bool) :
    xorUpTo (2*m) f = xorUpTo m (fun t => bxor (f (2*t)) (f (2*t+1))) := by
  induction m with
  | zero => rfl
  | succ m ih =>
    have he : 2*(m+1)=(2*m+1)+1 := by omega
    rw [he]
    change bxor (bxor (xorUpTo (2*m) f) (f (2*m))) (f (2*m+1)) =
      bxor (xorUpTo m (fun t => bxor (f (2*t)) (f (2*t+1)))) (bxor (f (2*m)) (f (2*m+1)))
    rw [ih, bxor_assoc]

theorem xor_bxor (m : Nat) (f g : Nat → Bool) :
    xorUpTo m (fun i => bxor (f i) (g i)) = bxor (xorUpTo m f) (xorUpTo m g) := by
  induction m with
  | zero => rfl
  | succ m ih =>
    change bxor (xorUpTo m (fun i => bxor (f i) (g i))) (bxor (f m) (g m)) =
      bxor (bxor (xorUpTo m f) (f m)) (bxor (xorUpTo m g) (g m))
    rw [ih]
    cases xorUpTo m f <;> cases xorUpTo m g <;> cases f m <;> cases g m <;> rfl

theorem xor_false (m : Nat) : xorUpTo m (fun _ => false) = false := by
  induction m with
  | zero => rfl
  | succ m ih => change bxor (xorUpTo m (fun _ => false)) false = false; rw [ih]; rfl

/-- The optimized coefficients are exactly the original subset-sum coefficients, in all dimensions. -/
theorem anfCoeffDirect_eq (n : Nat) (f : Nat → Bool) (s : Nat) :
    anfCoeffDirect n f s = anfCoeff n f s := by
  induction n generalizing f s with
  | zero => simp only [anfCoeffDirect, Nat.pow_zero, xorUpTo, Nat.zero_and, beq_self_eq_true, Bool.true_and, anfCoeff, bxor_zero_left]
  | succ n ih =>
    have hp : 2^(n+1) = 2*(2^n) := by rw [Nat.pow_succ, Nat.mul_comm]
    unfold anfCoeffDirect
    rw [hp, xor_even_odd]
    simp only [subset_even, subset_odd]
    have he : (fun t => bxor (((t &&& (s/2)) == t) && f (2*t))
        (((s % 2 == 1) && ((t &&& (s/2)) == t)) && f (2*t+1))) =
        (fun t => bxor (((t &&& (s/2)) == t) && f (2*t))
          (if s % 2 == 1 then ((t &&& (s/2)) == t) && f (2*t+1) else false)) := by
      funext t
      cases s % 2 == 1 <;> rfl
    rw [he, xor_bxor]
    change bxor (anfCoeffDirect n (fun t => f (2*t)) (s/2)) _ = _
    rw [ih]
    cases hs : s%2 == 1 with
    | false => simp only [hs, Bool.false_eq_true, ↓reduceIte, xor_false, anfCoeff]
    | true =>
      simp only [hs, ↓reduceIte]
      change bxor (anfCoeff n (fun t => f (2*t)) (s/2)) (anfCoeffDirect n (fun t => f (2*t+1)) (s/2)) = _
      rw [ih]
      simp only [anfCoeff, hs, ↓reduceIte]

theorem anfCoeff_congr (n : Nat) (f g : Nat → Bool) (s : Nat)
    (h : ∀ x, x < 2^n → f x = g x) : anfCoeff n f s = anfCoeff n g s := by
  induction n generalizing f g s with
  | zero => exact h 0 (by decide)
  | succ n ih =>
    have hp : 2^(n+1)=2*(2^n) := by rw [Nat.pow_succ, Nat.mul_comm]
    have he : anfCoeff n (fun t => f (2*t)) (s/2) = anfCoeff n (fun t => g (2*t)) (s/2) := by
      apply ih; intro x hx; exact h (2*x) (by rw [hp]; omega)
    have ho : anfCoeff n (fun t => f (2*t+1)) (s/2) = anfCoeff n (fun t => g (2*t+1)) (s/2) := by
      apply ih; intro x hx; exact h (2*x+1) (by rw [hp]; omega)
    simp only [anfCoeff, he, ho]

end HRSBF_Formalizacao_Real

/- ===== Módulo TruthDef ===== -/
namespace HRSBF_Formalizacao_Real
set_option maxRecDepth 10000
set_option maxHeartbeats 0
def truthWord12 : Nat := 94521894126579650650843058759343239252155329891988579473554797140530524788116273579532236930514303938150723609863791876220113441358821446405824397389750212014764971930987200564584881795270531231502638896774306622504101136633031816567328364302400099096366607764336704042866305860371204756355386044475288574306870341488382344409441089633970896174441731436944945646372034437282923683159416760544292108930496961336992014945643993782075880570158665078194372915261360399623123869557813934062120777785709299427606445014671574254003853121043263874152307589396848033881277819536830173534903854628089462371467637787205038143743576111036291392856034733083409050160404799573068853805963687351241987557100081936751915760568898375844857173297133870588936305576730845934121878925216141519001635424047631425500532717379220712727681049907823944177360738998922526987459859600497517161553956326696344780112031464279502648700905390829192685965262833537126192283295219001693376628580032273309929719620408404457906132843325726981056779244562552150431513663504394036669790495935681128467383630059308639410974237509331780974601773877972044229766680539453616043380934644412264453508071099399632122893744758920954633157796384832437602291011786750388678998088
def truth12 (x : Nat) : Bool := bitAt truthWord12 x

end HRSBF_Formalizacao_Real

/- ===== Módulo Truth0 ===== -/
namespace HRSBF_Formalizacao_Real
set_option maxRecDepth 10000
set_option maxHeartbeats 0
theorem truth_check_0 : allUpTo 64 (fun i => f12_explicit (0*64+i) == truth12 (0*64+i)) = true := by decide +kernel
theorem truth_check_1 : allUpTo 64 (fun i => f12_explicit (1*64+i) == truth12 (1*64+i)) = true := by decide +kernel
theorem truth_check_2 : allUpTo 64 (fun i => f12_explicit (2*64+i) == truth12 (2*64+i)) = true := by decide +kernel
theorem truth_check_3 : allUpTo 64 (fun i => f12_explicit (3*64+i) == truth12 (3*64+i)) = true := by decide +kernel
theorem truth_check_4 : allUpTo 64 (fun i => f12_explicit (4*64+i) == truth12 (4*64+i)) = true := by decide +kernel
theorem truth_check_5 : allUpTo 64 (fun i => f12_explicit (5*64+i) == truth12 (5*64+i)) = true := by decide +kernel
theorem truth_check_6 : allUpTo 64 (fun i => f12_explicit (6*64+i) == truth12 (6*64+i)) = true := by decide +kernel
theorem truth_check_7 : allUpTo 64 (fun i => f12_explicit (7*64+i) == truth12 (7*64+i)) = true := by decide +kernel
theorem truth_check_8 : allUpTo 64 (fun i => f12_explicit (8*64+i) == truth12 (8*64+i)) = true := by decide +kernel
theorem truth_check_9 : allUpTo 64 (fun i => f12_explicit (9*64+i) == truth12 (9*64+i)) = true := by decide +kernel
theorem truth_check_10 : allUpTo 64 (fun i => f12_explicit (10*64+i) == truth12 (10*64+i)) = true := by decide +kernel
theorem truth_check_11 : allUpTo 64 (fun i => f12_explicit (11*64+i) == truth12 (11*64+i)) = true := by decide +kernel
theorem truth_check_12 : allUpTo 64 (fun i => f12_explicit (12*64+i) == truth12 (12*64+i)) = true := by decide +kernel
theorem truth_check_13 : allUpTo 64 (fun i => f12_explicit (13*64+i) == truth12 (13*64+i)) = true := by decide +kernel
theorem truth_check_14 : allUpTo 64 (fun i => f12_explicit (14*64+i) == truth12 (14*64+i)) = true := by decide +kernel
theorem truth_check_15 : allUpTo 64 (fun i => f12_explicit (15*64+i) == truth12 (15*64+i)) = true := by decide +kernel

end HRSBF_Formalizacao_Real

/- ===== Módulo Truth1 ===== -/
namespace HRSBF_Formalizacao_Real
set_option maxRecDepth 10000
set_option maxHeartbeats 0
theorem truth_check_16 : allUpTo 64 (fun i => f12_explicit (16*64+i) == truth12 (16*64+i)) = true := by decide +kernel
theorem truth_check_17 : allUpTo 64 (fun i => f12_explicit (17*64+i) == truth12 (17*64+i)) = true := by decide +kernel
theorem truth_check_18 : allUpTo 64 (fun i => f12_explicit (18*64+i) == truth12 (18*64+i)) = true := by decide +kernel
theorem truth_check_19 : allUpTo 64 (fun i => f12_explicit (19*64+i) == truth12 (19*64+i)) = true := by decide +kernel
theorem truth_check_20 : allUpTo 64 (fun i => f12_explicit (20*64+i) == truth12 (20*64+i)) = true := by decide +kernel
theorem truth_check_21 : allUpTo 64 (fun i => f12_explicit (21*64+i) == truth12 (21*64+i)) = true := by decide +kernel
theorem truth_check_22 : allUpTo 64 (fun i => f12_explicit (22*64+i) == truth12 (22*64+i)) = true := by decide +kernel
theorem truth_check_23 : allUpTo 64 (fun i => f12_explicit (23*64+i) == truth12 (23*64+i)) = true := by decide +kernel
theorem truth_check_24 : allUpTo 64 (fun i => f12_explicit (24*64+i) == truth12 (24*64+i)) = true := by decide +kernel
theorem truth_check_25 : allUpTo 64 (fun i => f12_explicit (25*64+i) == truth12 (25*64+i)) = true := by decide +kernel
theorem truth_check_26 : allUpTo 64 (fun i => f12_explicit (26*64+i) == truth12 (26*64+i)) = true := by decide +kernel
theorem truth_check_27 : allUpTo 64 (fun i => f12_explicit (27*64+i) == truth12 (27*64+i)) = true := by decide +kernel
theorem truth_check_28 : allUpTo 64 (fun i => f12_explicit (28*64+i) == truth12 (28*64+i)) = true := by decide +kernel
theorem truth_check_29 : allUpTo 64 (fun i => f12_explicit (29*64+i) == truth12 (29*64+i)) = true := by decide +kernel
theorem truth_check_30 : allUpTo 64 (fun i => f12_explicit (30*64+i) == truth12 (30*64+i)) = true := by decide +kernel
theorem truth_check_31 : allUpTo 64 (fun i => f12_explicit (31*64+i) == truth12 (31*64+i)) = true := by decide +kernel

end HRSBF_Formalizacao_Real

/- ===== Módulo Truth2 ===== -/
namespace HRSBF_Formalizacao_Real
set_option maxRecDepth 10000
set_option maxHeartbeats 0
theorem truth_check_32 : allUpTo 64 (fun i => f12_explicit (32*64+i) == truth12 (32*64+i)) = true := by decide +kernel
theorem truth_check_33 : allUpTo 64 (fun i => f12_explicit (33*64+i) == truth12 (33*64+i)) = true := by decide +kernel
theorem truth_check_34 : allUpTo 64 (fun i => f12_explicit (34*64+i) == truth12 (34*64+i)) = true := by decide +kernel
theorem truth_check_35 : allUpTo 64 (fun i => f12_explicit (35*64+i) == truth12 (35*64+i)) = true := by decide +kernel
theorem truth_check_36 : allUpTo 64 (fun i => f12_explicit (36*64+i) == truth12 (36*64+i)) = true := by decide +kernel
theorem truth_check_37 : allUpTo 64 (fun i => f12_explicit (37*64+i) == truth12 (37*64+i)) = true := by decide +kernel
theorem truth_check_38 : allUpTo 64 (fun i => f12_explicit (38*64+i) == truth12 (38*64+i)) = true := by decide +kernel
theorem truth_check_39 : allUpTo 64 (fun i => f12_explicit (39*64+i) == truth12 (39*64+i)) = true := by decide +kernel
theorem truth_check_40 : allUpTo 64 (fun i => f12_explicit (40*64+i) == truth12 (40*64+i)) = true := by decide +kernel
theorem truth_check_41 : allUpTo 64 (fun i => f12_explicit (41*64+i) == truth12 (41*64+i)) = true := by decide +kernel
theorem truth_check_42 : allUpTo 64 (fun i => f12_explicit (42*64+i) == truth12 (42*64+i)) = true := by decide +kernel
theorem truth_check_43 : allUpTo 64 (fun i => f12_explicit (43*64+i) == truth12 (43*64+i)) = true := by decide +kernel
theorem truth_check_44 : allUpTo 64 (fun i => f12_explicit (44*64+i) == truth12 (44*64+i)) = true := by decide +kernel
theorem truth_check_45 : allUpTo 64 (fun i => f12_explicit (45*64+i) == truth12 (45*64+i)) = true := by decide +kernel
theorem truth_check_46 : allUpTo 64 (fun i => f12_explicit (46*64+i) == truth12 (46*64+i)) = true := by decide +kernel
theorem truth_check_47 : allUpTo 64 (fun i => f12_explicit (47*64+i) == truth12 (47*64+i)) = true := by decide +kernel

end HRSBF_Formalizacao_Real

/- ===== Módulo Truth3 ===== -/
namespace HRSBF_Formalizacao_Real
set_option maxRecDepth 10000
set_option maxHeartbeats 0
theorem truth_check_48 : allUpTo 64 (fun i => f12_explicit (48*64+i) == truth12 (48*64+i)) = true := by decide +kernel
theorem truth_check_49 : allUpTo 64 (fun i => f12_explicit (49*64+i) == truth12 (49*64+i)) = true := by decide +kernel
theorem truth_check_50 : allUpTo 64 (fun i => f12_explicit (50*64+i) == truth12 (50*64+i)) = true := by decide +kernel
theorem truth_check_51 : allUpTo 64 (fun i => f12_explicit (51*64+i) == truth12 (51*64+i)) = true := by decide +kernel
theorem truth_check_52 : allUpTo 64 (fun i => f12_explicit (52*64+i) == truth12 (52*64+i)) = true := by decide +kernel
theorem truth_check_53 : allUpTo 64 (fun i => f12_explicit (53*64+i) == truth12 (53*64+i)) = true := by decide +kernel
theorem truth_check_54 : allUpTo 64 (fun i => f12_explicit (54*64+i) == truth12 (54*64+i)) = true := by decide +kernel
theorem truth_check_55 : allUpTo 64 (fun i => f12_explicit (55*64+i) == truth12 (55*64+i)) = true := by decide +kernel
theorem truth_check_56 : allUpTo 64 (fun i => f12_explicit (56*64+i) == truth12 (56*64+i)) = true := by decide +kernel
theorem truth_check_57 : allUpTo 64 (fun i => f12_explicit (57*64+i) == truth12 (57*64+i)) = true := by decide +kernel
theorem truth_check_58 : allUpTo 64 (fun i => f12_explicit (58*64+i) == truth12 (58*64+i)) = true := by decide +kernel
theorem truth_check_59 : allUpTo 64 (fun i => f12_explicit (59*64+i) == truth12 (59*64+i)) = true := by decide +kernel
theorem truth_check_60 : allUpTo 64 (fun i => f12_explicit (60*64+i) == truth12 (60*64+i)) = true := by decide +kernel
theorem truth_check_61 : allUpTo 64 (fun i => f12_explicit (61*64+i) == truth12 (61*64+i)) = true := by decide +kernel
theorem truth_check_62 : allUpTo 64 (fun i => f12_explicit (62*64+i) == truth12 (62*64+i)) = true := by decide +kernel
theorem truth_check_63 : allUpTo 64 (fun i => f12_explicit (63*64+i) == truth12 (63*64+i)) = true := by decide +kernel

end HRSBF_Formalizacao_Real

/- ===== Módulo Checks0 ===== -/
namespace HRSBF_Formalizacao_Real
set_option maxRecDepth 20000
set_option maxHeartbeats 0
theorem degree_check_0 : allUpTo 64 (fun j => decide (popcount 12 (0*64+j) ≤ 3) || !(anfCoeff 12 truth12 (0*64+j))) = true := by decide +kernel
theorem mm_check_0 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 0)) == f12_mm u 0) = true := by decide +kernel
theorem rot_check_0 : allUpTo 64 (fun j => truth12 (rotShift 12 (0*64+j)) == truth12 (0*64+j)) = true := by decide +kernel
theorem spectrum_check_0 : allUpTo 64 (fun j => decide (walshMM12 (0*64+j) * walshMM12 (0*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_1 : allUpTo 64 (fun j => decide (popcount 12 (1*64+j) ≤ 3) || !(anfCoeff 12 truth12 (1*64+j))) = true := by decide +kernel
theorem mm_check_1 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 1)) == f12_mm u 1) = true := by decide +kernel
theorem rot_check_1 : allUpTo 64 (fun j => truth12 (rotShift 12 (1*64+j)) == truth12 (1*64+j)) = true := by decide +kernel
theorem spectrum_check_1 : allUpTo 64 (fun j => decide (walshMM12 (1*64+j) * walshMM12 (1*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_2 : allUpTo 64 (fun j => decide (popcount 12 (2*64+j) ≤ 3) || !(anfCoeff 12 truth12 (2*64+j))) = true := by decide +kernel
theorem mm_check_2 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 2)) == f12_mm u 2) = true := by decide +kernel
theorem rot_check_2 : allUpTo 64 (fun j => truth12 (rotShift 12 (2*64+j)) == truth12 (2*64+j)) = true := by decide +kernel
theorem spectrum_check_2 : allUpTo 64 (fun j => decide (walshMM12 (2*64+j) * walshMM12 (2*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_3 : allUpTo 64 (fun j => decide (popcount 12 (3*64+j) ≤ 3) || !(anfCoeff 12 truth12 (3*64+j))) = true := by decide +kernel
theorem mm_check_3 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 3)) == f12_mm u 3) = true := by decide +kernel
theorem rot_check_3 : allUpTo 64 (fun j => truth12 (rotShift 12 (3*64+j)) == truth12 (3*64+j)) = true := by decide +kernel
theorem spectrum_check_3 : allUpTo 64 (fun j => decide (walshMM12 (3*64+j) * walshMM12 (3*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_4 : allUpTo 64 (fun j => decide (popcount 12 (4*64+j) ≤ 3) || !(anfCoeff 12 truth12 (4*64+j))) = true := by decide +kernel
theorem mm_check_4 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 4)) == f12_mm u 4) = true := by decide +kernel
theorem rot_check_4 : allUpTo 64 (fun j => truth12 (rotShift 12 (4*64+j)) == truth12 (4*64+j)) = true := by decide +kernel
theorem spectrum_check_4 : allUpTo 64 (fun j => decide (walshMM12 (4*64+j) * walshMM12 (4*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_5 : allUpTo 64 (fun j => decide (popcount 12 (5*64+j) ≤ 3) || !(anfCoeff 12 truth12 (5*64+j))) = true := by decide +kernel
theorem mm_check_5 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 5)) == f12_mm u 5) = true := by decide +kernel
theorem rot_check_5 : allUpTo 64 (fun j => truth12 (rotShift 12 (5*64+j)) == truth12 (5*64+j)) = true := by decide +kernel
theorem spectrum_check_5 : allUpTo 64 (fun j => decide (walshMM12 (5*64+j) * walshMM12 (5*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_6 : allUpTo 64 (fun j => decide (popcount 12 (6*64+j) ≤ 3) || !(anfCoeff 12 truth12 (6*64+j))) = true := by decide +kernel
theorem mm_check_6 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 6)) == f12_mm u 6) = true := by decide +kernel
theorem rot_check_6 : allUpTo 64 (fun j => truth12 (rotShift 12 (6*64+j)) == truth12 (6*64+j)) = true := by decide +kernel
theorem spectrum_check_6 : allUpTo 64 (fun j => decide (walshMM12 (6*64+j) * walshMM12 (6*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_7 : allUpTo 64 (fun j => decide (popcount 12 (7*64+j) ≤ 3) || !(anfCoeff 12 truth12 (7*64+j))) = true := by decide +kernel
theorem mm_check_7 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 7)) == f12_mm u 7) = true := by decide +kernel
theorem rot_check_7 : allUpTo 64 (fun j => truth12 (rotShift 12 (7*64+j)) == truth12 (7*64+j)) = true := by decide +kernel
theorem spectrum_check_7 : allUpTo 64 (fun j => decide (walshMM12 (7*64+j) * walshMM12 (7*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_8 : allUpTo 64 (fun j => decide (popcount 12 (8*64+j) ≤ 3) || !(anfCoeff 12 truth12 (8*64+j))) = true := by decide +kernel
theorem mm_check_8 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 8)) == f12_mm u 8) = true := by decide +kernel
theorem rot_check_8 : allUpTo 64 (fun j => truth12 (rotShift 12 (8*64+j)) == truth12 (8*64+j)) = true := by decide +kernel
theorem spectrum_check_8 : allUpTo 64 (fun j => decide (walshMM12 (8*64+j) * walshMM12 (8*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_9 : allUpTo 64 (fun j => decide (popcount 12 (9*64+j) ≤ 3) || !(anfCoeff 12 truth12 (9*64+j))) = true := by decide +kernel
theorem mm_check_9 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 9)) == f12_mm u 9) = true := by decide +kernel
theorem rot_check_9 : allUpTo 64 (fun j => truth12 (rotShift 12 (9*64+j)) == truth12 (9*64+j)) = true := by decide +kernel
theorem spectrum_check_9 : allUpTo 64 (fun j => decide (walshMM12 (9*64+j) * walshMM12 (9*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_10 : allUpTo 64 (fun j => decide (popcount 12 (10*64+j) ≤ 3) || !(anfCoeff 12 truth12 (10*64+j))) = true := by decide +kernel
theorem mm_check_10 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 10)) == f12_mm u 10) = true := by decide +kernel
theorem rot_check_10 : allUpTo 64 (fun j => truth12 (rotShift 12 (10*64+j)) == truth12 (10*64+j)) = true := by decide +kernel
theorem spectrum_check_10 : allUpTo 64 (fun j => decide (walshMM12 (10*64+j) * walshMM12 (10*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_11 : allUpTo 64 (fun j => decide (popcount 12 (11*64+j) ≤ 3) || !(anfCoeff 12 truth12 (11*64+j))) = true := by decide +kernel
theorem mm_check_11 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 11)) == f12_mm u 11) = true := by decide +kernel
theorem rot_check_11 : allUpTo 64 (fun j => truth12 (rotShift 12 (11*64+j)) == truth12 (11*64+j)) = true := by decide +kernel
theorem spectrum_check_11 : allUpTo 64 (fun j => decide (walshMM12 (11*64+j) * walshMM12 (11*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_12 : allUpTo 64 (fun j => decide (popcount 12 (12*64+j) ≤ 3) || !(anfCoeff 12 truth12 (12*64+j))) = true := by decide +kernel
theorem mm_check_12 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 12)) == f12_mm u 12) = true := by decide +kernel
theorem rot_check_12 : allUpTo 64 (fun j => truth12 (rotShift 12 (12*64+j)) == truth12 (12*64+j)) = true := by decide +kernel
theorem spectrum_check_12 : allUpTo 64 (fun j => decide (walshMM12 (12*64+j) * walshMM12 (12*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_13 : allUpTo 64 (fun j => decide (popcount 12 (13*64+j) ≤ 3) || !(anfCoeff 12 truth12 (13*64+j))) = true := by decide +kernel
theorem mm_check_13 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 13)) == f12_mm u 13) = true := by decide +kernel
theorem rot_check_13 : allUpTo 64 (fun j => truth12 (rotShift 12 (13*64+j)) == truth12 (13*64+j)) = true := by decide +kernel
theorem spectrum_check_13 : allUpTo 64 (fun j => decide (walshMM12 (13*64+j) * walshMM12 (13*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_14 : allUpTo 64 (fun j => decide (popcount 12 (14*64+j) ≤ 3) || !(anfCoeff 12 truth12 (14*64+j))) = true := by decide +kernel
theorem mm_check_14 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 14)) == f12_mm u 14) = true := by decide +kernel
theorem rot_check_14 : allUpTo 64 (fun j => truth12 (rotShift 12 (14*64+j)) == truth12 (14*64+j)) = true := by decide +kernel
theorem spectrum_check_14 : allUpTo 64 (fun j => decide (walshMM12 (14*64+j) * walshMM12 (14*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_15 : allUpTo 64 (fun j => decide (popcount 12 (15*64+j) ≤ 3) || !(anfCoeff 12 truth12 (15*64+j))) = true := by decide +kernel
theorem mm_check_15 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 15)) == f12_mm u 15) = true := by decide +kernel
theorem rot_check_15 : allUpTo 64 (fun j => truth12 (rotShift 12 (15*64+j)) == truth12 (15*64+j)) = true := by decide +kernel
theorem spectrum_check_15 : allUpTo 64 (fun j => decide (walshMM12 (15*64+j) * walshMM12 (15*64+j) = (2 : Int)^12)) = true := by decide +kernel

end HRSBF_Formalizacao_Real

/- ===== Módulo Checks1 ===== -/
namespace HRSBF_Formalizacao_Real
set_option maxRecDepth 20000
set_option maxHeartbeats 0
theorem degree_check_16 : allUpTo 64 (fun j => decide (popcount 12 (16*64+j) ≤ 3) || !(anfCoeff 12 truth12 (16*64+j))) = true := by decide +kernel
theorem mm_check_16 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 16)) == f12_mm u 16) = true := by decide +kernel
theorem rot_check_16 : allUpTo 64 (fun j => truth12 (rotShift 12 (16*64+j)) == truth12 (16*64+j)) = true := by decide +kernel
theorem spectrum_check_16 : allUpTo 64 (fun j => decide (walshMM12 (16*64+j) * walshMM12 (16*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_17 : allUpTo 64 (fun j => decide (popcount 12 (17*64+j) ≤ 3) || !(anfCoeff 12 truth12 (17*64+j))) = true := by decide +kernel
theorem mm_check_17 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 17)) == f12_mm u 17) = true := by decide +kernel
theorem rot_check_17 : allUpTo 64 (fun j => truth12 (rotShift 12 (17*64+j)) == truth12 (17*64+j)) = true := by decide +kernel
theorem spectrum_check_17 : allUpTo 64 (fun j => decide (walshMM12 (17*64+j) * walshMM12 (17*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_18 : allUpTo 64 (fun j => decide (popcount 12 (18*64+j) ≤ 3) || !(anfCoeff 12 truth12 (18*64+j))) = true := by decide +kernel
theorem mm_check_18 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 18)) == f12_mm u 18) = true := by decide +kernel
theorem rot_check_18 : allUpTo 64 (fun j => truth12 (rotShift 12 (18*64+j)) == truth12 (18*64+j)) = true := by decide +kernel
theorem spectrum_check_18 : allUpTo 64 (fun j => decide (walshMM12 (18*64+j) * walshMM12 (18*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_19 : allUpTo 64 (fun j => decide (popcount 12 (19*64+j) ≤ 3) || !(anfCoeff 12 truth12 (19*64+j))) = true := by decide +kernel
theorem mm_check_19 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 19)) == f12_mm u 19) = true := by decide +kernel
theorem rot_check_19 : allUpTo 64 (fun j => truth12 (rotShift 12 (19*64+j)) == truth12 (19*64+j)) = true := by decide +kernel
theorem spectrum_check_19 : allUpTo 64 (fun j => decide (walshMM12 (19*64+j) * walshMM12 (19*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_20 : allUpTo 64 (fun j => decide (popcount 12 (20*64+j) ≤ 3) || !(anfCoeff 12 truth12 (20*64+j))) = true := by decide +kernel
theorem mm_check_20 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 20)) == f12_mm u 20) = true := by decide +kernel
theorem rot_check_20 : allUpTo 64 (fun j => truth12 (rotShift 12 (20*64+j)) == truth12 (20*64+j)) = true := by decide +kernel
theorem spectrum_check_20 : allUpTo 64 (fun j => decide (walshMM12 (20*64+j) * walshMM12 (20*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_21 : allUpTo 64 (fun j => decide (popcount 12 (21*64+j) ≤ 3) || !(anfCoeff 12 truth12 (21*64+j))) = true := by decide +kernel
theorem mm_check_21 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 21)) == f12_mm u 21) = true := by decide +kernel
theorem rot_check_21 : allUpTo 64 (fun j => truth12 (rotShift 12 (21*64+j)) == truth12 (21*64+j)) = true := by decide +kernel
theorem spectrum_check_21 : allUpTo 64 (fun j => decide (walshMM12 (21*64+j) * walshMM12 (21*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_22 : allUpTo 64 (fun j => decide (popcount 12 (22*64+j) ≤ 3) || !(anfCoeff 12 truth12 (22*64+j))) = true := by decide +kernel
theorem mm_check_22 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 22)) == f12_mm u 22) = true := by decide +kernel
theorem rot_check_22 : allUpTo 64 (fun j => truth12 (rotShift 12 (22*64+j)) == truth12 (22*64+j)) = true := by decide +kernel
theorem spectrum_check_22 : allUpTo 64 (fun j => decide (walshMM12 (22*64+j) * walshMM12 (22*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_23 : allUpTo 64 (fun j => decide (popcount 12 (23*64+j) ≤ 3) || !(anfCoeff 12 truth12 (23*64+j))) = true := by decide +kernel
theorem mm_check_23 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 23)) == f12_mm u 23) = true := by decide +kernel
theorem rot_check_23 : allUpTo 64 (fun j => truth12 (rotShift 12 (23*64+j)) == truth12 (23*64+j)) = true := by decide +kernel
theorem spectrum_check_23 : allUpTo 64 (fun j => decide (walshMM12 (23*64+j) * walshMM12 (23*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_24 : allUpTo 64 (fun j => decide (popcount 12 (24*64+j) ≤ 3) || !(anfCoeff 12 truth12 (24*64+j))) = true := by decide +kernel
theorem mm_check_24 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 24)) == f12_mm u 24) = true := by decide +kernel
theorem rot_check_24 : allUpTo 64 (fun j => truth12 (rotShift 12 (24*64+j)) == truth12 (24*64+j)) = true := by decide +kernel
theorem spectrum_check_24 : allUpTo 64 (fun j => decide (walshMM12 (24*64+j) * walshMM12 (24*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_25 : allUpTo 64 (fun j => decide (popcount 12 (25*64+j) ≤ 3) || !(anfCoeff 12 truth12 (25*64+j))) = true := by decide +kernel
theorem mm_check_25 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 25)) == f12_mm u 25) = true := by decide +kernel
theorem rot_check_25 : allUpTo 64 (fun j => truth12 (rotShift 12 (25*64+j)) == truth12 (25*64+j)) = true := by decide +kernel
theorem spectrum_check_25 : allUpTo 64 (fun j => decide (walshMM12 (25*64+j) * walshMM12 (25*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_26 : allUpTo 64 (fun j => decide (popcount 12 (26*64+j) ≤ 3) || !(anfCoeff 12 truth12 (26*64+j))) = true := by decide +kernel
theorem mm_check_26 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 26)) == f12_mm u 26) = true := by decide +kernel
theorem rot_check_26 : allUpTo 64 (fun j => truth12 (rotShift 12 (26*64+j)) == truth12 (26*64+j)) = true := by decide +kernel
theorem spectrum_check_26 : allUpTo 64 (fun j => decide (walshMM12 (26*64+j) * walshMM12 (26*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_27 : allUpTo 64 (fun j => decide (popcount 12 (27*64+j) ≤ 3) || !(anfCoeff 12 truth12 (27*64+j))) = true := by decide +kernel
theorem mm_check_27 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 27)) == f12_mm u 27) = true := by decide +kernel
theorem rot_check_27 : allUpTo 64 (fun j => truth12 (rotShift 12 (27*64+j)) == truth12 (27*64+j)) = true := by decide +kernel
theorem spectrum_check_27 : allUpTo 64 (fun j => decide (walshMM12 (27*64+j) * walshMM12 (27*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_28 : allUpTo 64 (fun j => decide (popcount 12 (28*64+j) ≤ 3) || !(anfCoeff 12 truth12 (28*64+j))) = true := by decide +kernel
theorem mm_check_28 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 28)) == f12_mm u 28) = true := by decide +kernel
theorem rot_check_28 : allUpTo 64 (fun j => truth12 (rotShift 12 (28*64+j)) == truth12 (28*64+j)) = true := by decide +kernel
theorem spectrum_check_28 : allUpTo 64 (fun j => decide (walshMM12 (28*64+j) * walshMM12 (28*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_29 : allUpTo 64 (fun j => decide (popcount 12 (29*64+j) ≤ 3) || !(anfCoeff 12 truth12 (29*64+j))) = true := by decide +kernel
theorem mm_check_29 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 29)) == f12_mm u 29) = true := by decide +kernel
theorem rot_check_29 : allUpTo 64 (fun j => truth12 (rotShift 12 (29*64+j)) == truth12 (29*64+j)) = true := by decide +kernel
theorem spectrum_check_29 : allUpTo 64 (fun j => decide (walshMM12 (29*64+j) * walshMM12 (29*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_30 : allUpTo 64 (fun j => decide (popcount 12 (30*64+j) ≤ 3) || !(anfCoeff 12 truth12 (30*64+j))) = true := by decide +kernel
theorem mm_check_30 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 30)) == f12_mm u 30) = true := by decide +kernel
theorem rot_check_30 : allUpTo 64 (fun j => truth12 (rotShift 12 (30*64+j)) == truth12 (30*64+j)) = true := by decide +kernel
theorem spectrum_check_30 : allUpTo 64 (fun j => decide (walshMM12 (30*64+j) * walshMM12 (30*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_31 : allUpTo 64 (fun j => decide (popcount 12 (31*64+j) ≤ 3) || !(anfCoeff 12 truth12 (31*64+j))) = true := by decide +kernel
theorem mm_check_31 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 31)) == f12_mm u 31) = true := by decide +kernel
theorem rot_check_31 : allUpTo 64 (fun j => truth12 (rotShift 12 (31*64+j)) == truth12 (31*64+j)) = true := by decide +kernel
theorem spectrum_check_31 : allUpTo 64 (fun j => decide (walshMM12 (31*64+j) * walshMM12 (31*64+j) = (2 : Int)^12)) = true := by decide +kernel

end HRSBF_Formalizacao_Real

/- ===== Módulo Checks2 ===== -/
namespace HRSBF_Formalizacao_Real
set_option maxRecDepth 20000
set_option maxHeartbeats 0
theorem degree_check_32 : allUpTo 64 (fun j => decide (popcount 12 (32*64+j) ≤ 3) || !(anfCoeff 12 truth12 (32*64+j))) = true := by decide +kernel
theorem mm_check_32 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 32)) == f12_mm u 32) = true := by decide +kernel
theorem rot_check_32 : allUpTo 64 (fun j => truth12 (rotShift 12 (32*64+j)) == truth12 (32*64+j)) = true := by decide +kernel
theorem spectrum_check_32 : allUpTo 64 (fun j => decide (walshMM12 (32*64+j) * walshMM12 (32*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_33 : allUpTo 64 (fun j => decide (popcount 12 (33*64+j) ≤ 3) || !(anfCoeff 12 truth12 (33*64+j))) = true := by decide +kernel
theorem mm_check_33 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 33)) == f12_mm u 33) = true := by decide +kernel
theorem rot_check_33 : allUpTo 64 (fun j => truth12 (rotShift 12 (33*64+j)) == truth12 (33*64+j)) = true := by decide +kernel
theorem spectrum_check_33 : allUpTo 64 (fun j => decide (walshMM12 (33*64+j) * walshMM12 (33*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_34 : allUpTo 64 (fun j => decide (popcount 12 (34*64+j) ≤ 3) || !(anfCoeff 12 truth12 (34*64+j))) = true := by decide +kernel
theorem mm_check_34 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 34)) == f12_mm u 34) = true := by decide +kernel
theorem rot_check_34 : allUpTo 64 (fun j => truth12 (rotShift 12 (34*64+j)) == truth12 (34*64+j)) = true := by decide +kernel
theorem spectrum_check_34 : allUpTo 64 (fun j => decide (walshMM12 (34*64+j) * walshMM12 (34*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_35 : allUpTo 64 (fun j => decide (popcount 12 (35*64+j) ≤ 3) || !(anfCoeff 12 truth12 (35*64+j))) = true := by decide +kernel
theorem mm_check_35 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 35)) == f12_mm u 35) = true := by decide +kernel
theorem rot_check_35 : allUpTo 64 (fun j => truth12 (rotShift 12 (35*64+j)) == truth12 (35*64+j)) = true := by decide +kernel
theorem spectrum_check_35 : allUpTo 64 (fun j => decide (walshMM12 (35*64+j) * walshMM12 (35*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_36 : allUpTo 64 (fun j => decide (popcount 12 (36*64+j) ≤ 3) || !(anfCoeff 12 truth12 (36*64+j))) = true := by decide +kernel
theorem mm_check_36 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 36)) == f12_mm u 36) = true := by decide +kernel
theorem rot_check_36 : allUpTo 64 (fun j => truth12 (rotShift 12 (36*64+j)) == truth12 (36*64+j)) = true := by decide +kernel
theorem spectrum_check_36 : allUpTo 64 (fun j => decide (walshMM12 (36*64+j) * walshMM12 (36*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_37 : allUpTo 64 (fun j => decide (popcount 12 (37*64+j) ≤ 3) || !(anfCoeff 12 truth12 (37*64+j))) = true := by decide +kernel
theorem mm_check_37 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 37)) == f12_mm u 37) = true := by decide +kernel
theorem rot_check_37 : allUpTo 64 (fun j => truth12 (rotShift 12 (37*64+j)) == truth12 (37*64+j)) = true := by decide +kernel
theorem spectrum_check_37 : allUpTo 64 (fun j => decide (walshMM12 (37*64+j) * walshMM12 (37*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_38 : allUpTo 64 (fun j => decide (popcount 12 (38*64+j) ≤ 3) || !(anfCoeff 12 truth12 (38*64+j))) = true := by decide +kernel
theorem mm_check_38 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 38)) == f12_mm u 38) = true := by decide +kernel
theorem rot_check_38 : allUpTo 64 (fun j => truth12 (rotShift 12 (38*64+j)) == truth12 (38*64+j)) = true := by decide +kernel
theorem spectrum_check_38 : allUpTo 64 (fun j => decide (walshMM12 (38*64+j) * walshMM12 (38*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_39 : allUpTo 64 (fun j => decide (popcount 12 (39*64+j) ≤ 3) || !(anfCoeff 12 truth12 (39*64+j))) = true := by decide +kernel
theorem mm_check_39 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 39)) == f12_mm u 39) = true := by decide +kernel
theorem rot_check_39 : allUpTo 64 (fun j => truth12 (rotShift 12 (39*64+j)) == truth12 (39*64+j)) = true := by decide +kernel
theorem spectrum_check_39 : allUpTo 64 (fun j => decide (walshMM12 (39*64+j) * walshMM12 (39*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_40 : allUpTo 64 (fun j => decide (popcount 12 (40*64+j) ≤ 3) || !(anfCoeff 12 truth12 (40*64+j))) = true := by decide +kernel
theorem mm_check_40 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 40)) == f12_mm u 40) = true := by decide +kernel
theorem rot_check_40 : allUpTo 64 (fun j => truth12 (rotShift 12 (40*64+j)) == truth12 (40*64+j)) = true := by decide +kernel
theorem spectrum_check_40 : allUpTo 64 (fun j => decide (walshMM12 (40*64+j) * walshMM12 (40*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_41 : allUpTo 64 (fun j => decide (popcount 12 (41*64+j) ≤ 3) || !(anfCoeff 12 truth12 (41*64+j))) = true := by decide +kernel
theorem mm_check_41 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 41)) == f12_mm u 41) = true := by decide +kernel
theorem rot_check_41 : allUpTo 64 (fun j => truth12 (rotShift 12 (41*64+j)) == truth12 (41*64+j)) = true := by decide +kernel
theorem spectrum_check_41 : allUpTo 64 (fun j => decide (walshMM12 (41*64+j) * walshMM12 (41*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_42 : allUpTo 64 (fun j => decide (popcount 12 (42*64+j) ≤ 3) || !(anfCoeff 12 truth12 (42*64+j))) = true := by decide +kernel
theorem mm_check_42 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 42)) == f12_mm u 42) = true := by decide +kernel
theorem rot_check_42 : allUpTo 64 (fun j => truth12 (rotShift 12 (42*64+j)) == truth12 (42*64+j)) = true := by decide +kernel
theorem spectrum_check_42 : allUpTo 64 (fun j => decide (walshMM12 (42*64+j) * walshMM12 (42*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_43 : allUpTo 64 (fun j => decide (popcount 12 (43*64+j) ≤ 3) || !(anfCoeff 12 truth12 (43*64+j))) = true := by decide +kernel
theorem mm_check_43 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 43)) == f12_mm u 43) = true := by decide +kernel
theorem rot_check_43 : allUpTo 64 (fun j => truth12 (rotShift 12 (43*64+j)) == truth12 (43*64+j)) = true := by decide +kernel
theorem spectrum_check_43 : allUpTo 64 (fun j => decide (walshMM12 (43*64+j) * walshMM12 (43*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_44 : allUpTo 64 (fun j => decide (popcount 12 (44*64+j) ≤ 3) || !(anfCoeff 12 truth12 (44*64+j))) = true := by decide +kernel
theorem mm_check_44 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 44)) == f12_mm u 44) = true := by decide +kernel
theorem rot_check_44 : allUpTo 64 (fun j => truth12 (rotShift 12 (44*64+j)) == truth12 (44*64+j)) = true := by decide +kernel
theorem spectrum_check_44 : allUpTo 64 (fun j => decide (walshMM12 (44*64+j) * walshMM12 (44*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_45 : allUpTo 64 (fun j => decide (popcount 12 (45*64+j) ≤ 3) || !(anfCoeff 12 truth12 (45*64+j))) = true := by decide +kernel
theorem mm_check_45 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 45)) == f12_mm u 45) = true := by decide +kernel
theorem rot_check_45 : allUpTo 64 (fun j => truth12 (rotShift 12 (45*64+j)) == truth12 (45*64+j)) = true := by decide +kernel
theorem spectrum_check_45 : allUpTo 64 (fun j => decide (walshMM12 (45*64+j) * walshMM12 (45*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_46 : allUpTo 64 (fun j => decide (popcount 12 (46*64+j) ≤ 3) || !(anfCoeff 12 truth12 (46*64+j))) = true := by decide +kernel
theorem mm_check_46 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 46)) == f12_mm u 46) = true := by decide +kernel
theorem rot_check_46 : allUpTo 64 (fun j => truth12 (rotShift 12 (46*64+j)) == truth12 (46*64+j)) = true := by decide +kernel
theorem spectrum_check_46 : allUpTo 64 (fun j => decide (walshMM12 (46*64+j) * walshMM12 (46*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_47 : allUpTo 64 (fun j => decide (popcount 12 (47*64+j) ≤ 3) || !(anfCoeff 12 truth12 (47*64+j))) = true := by decide +kernel
theorem mm_check_47 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 47)) == f12_mm u 47) = true := by decide +kernel
theorem rot_check_47 : allUpTo 64 (fun j => truth12 (rotShift 12 (47*64+j)) == truth12 (47*64+j)) = true := by decide +kernel
theorem spectrum_check_47 : allUpTo 64 (fun j => decide (walshMM12 (47*64+j) * walshMM12 (47*64+j) = (2 : Int)^12)) = true := by decide +kernel

end HRSBF_Formalizacao_Real

/- ===== Módulo Checks3 ===== -/
namespace HRSBF_Formalizacao_Real
set_option maxRecDepth 20000
set_option maxHeartbeats 0
theorem degree_check_48 : allUpTo 64 (fun j => decide (popcount 12 (48*64+j) ≤ 3) || !(anfCoeff 12 truth12 (48*64+j))) = true := by decide +kernel
theorem mm_check_48 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 48)) == f12_mm u 48) = true := by decide +kernel
theorem rot_check_48 : allUpTo 64 (fun j => truth12 (rotShift 12 (48*64+j)) == truth12 (48*64+j)) = true := by decide +kernel
theorem spectrum_check_48 : allUpTo 64 (fun j => decide (walshMM12 (48*64+j) * walshMM12 (48*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_49 : allUpTo 64 (fun j => decide (popcount 12 (49*64+j) ≤ 3) || !(anfCoeff 12 truth12 (49*64+j))) = true := by decide +kernel
theorem mm_check_49 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 49)) == f12_mm u 49) = true := by decide +kernel
theorem rot_check_49 : allUpTo 64 (fun j => truth12 (rotShift 12 (49*64+j)) == truth12 (49*64+j)) = true := by decide +kernel
theorem spectrum_check_49 : allUpTo 64 (fun j => decide (walshMM12 (49*64+j) * walshMM12 (49*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_50 : allUpTo 64 (fun j => decide (popcount 12 (50*64+j) ≤ 3) || !(anfCoeff 12 truth12 (50*64+j))) = true := by decide +kernel
theorem mm_check_50 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 50)) == f12_mm u 50) = true := by decide +kernel
theorem rot_check_50 : allUpTo 64 (fun j => truth12 (rotShift 12 (50*64+j)) == truth12 (50*64+j)) = true := by decide +kernel
theorem spectrum_check_50 : allUpTo 64 (fun j => decide (walshMM12 (50*64+j) * walshMM12 (50*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_51 : allUpTo 64 (fun j => decide (popcount 12 (51*64+j) ≤ 3) || !(anfCoeff 12 truth12 (51*64+j))) = true := by decide +kernel
theorem mm_check_51 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 51)) == f12_mm u 51) = true := by decide +kernel
theorem rot_check_51 : allUpTo 64 (fun j => truth12 (rotShift 12 (51*64+j)) == truth12 (51*64+j)) = true := by decide +kernel
theorem spectrum_check_51 : allUpTo 64 (fun j => decide (walshMM12 (51*64+j) * walshMM12 (51*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_52 : allUpTo 64 (fun j => decide (popcount 12 (52*64+j) ≤ 3) || !(anfCoeff 12 truth12 (52*64+j))) = true := by decide +kernel
theorem mm_check_52 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 52)) == f12_mm u 52) = true := by decide +kernel
theorem rot_check_52 : allUpTo 64 (fun j => truth12 (rotShift 12 (52*64+j)) == truth12 (52*64+j)) = true := by decide +kernel
theorem spectrum_check_52 : allUpTo 64 (fun j => decide (walshMM12 (52*64+j) * walshMM12 (52*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_53 : allUpTo 64 (fun j => decide (popcount 12 (53*64+j) ≤ 3) || !(anfCoeff 12 truth12 (53*64+j))) = true := by decide +kernel
theorem mm_check_53 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 53)) == f12_mm u 53) = true := by decide +kernel
theorem rot_check_53 : allUpTo 64 (fun j => truth12 (rotShift 12 (53*64+j)) == truth12 (53*64+j)) = true := by decide +kernel
theorem spectrum_check_53 : allUpTo 64 (fun j => decide (walshMM12 (53*64+j) * walshMM12 (53*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_54 : allUpTo 64 (fun j => decide (popcount 12 (54*64+j) ≤ 3) || !(anfCoeff 12 truth12 (54*64+j))) = true := by decide +kernel
theorem mm_check_54 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 54)) == f12_mm u 54) = true := by decide +kernel
theorem rot_check_54 : allUpTo 64 (fun j => truth12 (rotShift 12 (54*64+j)) == truth12 (54*64+j)) = true := by decide +kernel
theorem spectrum_check_54 : allUpTo 64 (fun j => decide (walshMM12 (54*64+j) * walshMM12 (54*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_55 : allUpTo 64 (fun j => decide (popcount 12 (55*64+j) ≤ 3) || !(anfCoeff 12 truth12 (55*64+j))) = true := by decide +kernel
theorem mm_check_55 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 55)) == f12_mm u 55) = true := by decide +kernel
theorem rot_check_55 : allUpTo 64 (fun j => truth12 (rotShift 12 (55*64+j)) == truth12 (55*64+j)) = true := by decide +kernel
theorem spectrum_check_55 : allUpTo 64 (fun j => decide (walshMM12 (55*64+j) * walshMM12 (55*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_56 : allUpTo 64 (fun j => decide (popcount 12 (56*64+j) ≤ 3) || !(anfCoeff 12 truth12 (56*64+j))) = true := by decide +kernel
theorem mm_check_56 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 56)) == f12_mm u 56) = true := by decide +kernel
theorem rot_check_56 : allUpTo 64 (fun j => truth12 (rotShift 12 (56*64+j)) == truth12 (56*64+j)) = true := by decide +kernel
theorem spectrum_check_56 : allUpTo 64 (fun j => decide (walshMM12 (56*64+j) * walshMM12 (56*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_57 : allUpTo 64 (fun j => decide (popcount 12 (57*64+j) ≤ 3) || !(anfCoeff 12 truth12 (57*64+j))) = true := by decide +kernel
theorem mm_check_57 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 57)) == f12_mm u 57) = true := by decide +kernel
theorem rot_check_57 : allUpTo 64 (fun j => truth12 (rotShift 12 (57*64+j)) == truth12 (57*64+j)) = true := by decide +kernel
theorem spectrum_check_57 : allUpTo 64 (fun j => decide (walshMM12 (57*64+j) * walshMM12 (57*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_58 : allUpTo 64 (fun j => decide (popcount 12 (58*64+j) ≤ 3) || !(anfCoeff 12 truth12 (58*64+j))) = true := by decide +kernel
theorem mm_check_58 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 58)) == f12_mm u 58) = true := by decide +kernel
theorem rot_check_58 : allUpTo 64 (fun j => truth12 (rotShift 12 (58*64+j)) == truth12 (58*64+j)) = true := by decide +kernel
theorem spectrum_check_58 : allUpTo 64 (fun j => decide (walshMM12 (58*64+j) * walshMM12 (58*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_59 : allUpTo 64 (fun j => decide (popcount 12 (59*64+j) ≤ 3) || !(anfCoeff 12 truth12 (59*64+j))) = true := by decide +kernel
theorem mm_check_59 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 59)) == f12_mm u 59) = true := by decide +kernel
theorem rot_check_59 : allUpTo 64 (fun j => truth12 (rotShift 12 (59*64+j)) == truth12 (59*64+j)) = true := by decide +kernel
theorem spectrum_check_59 : allUpTo 64 (fun j => decide (walshMM12 (59*64+j) * walshMM12 (59*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_60 : allUpTo 64 (fun j => decide (popcount 12 (60*64+j) ≤ 3) || !(anfCoeff 12 truth12 (60*64+j))) = true := by decide +kernel
theorem mm_check_60 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 60)) == f12_mm u 60) = true := by decide +kernel
theorem rot_check_60 : allUpTo 64 (fun j => truth12 (rotShift 12 (60*64+j)) == truth12 (60*64+j)) = true := by decide +kernel
theorem spectrum_check_60 : allUpTo 64 (fun j => decide (walshMM12 (60*64+j) * walshMM12 (60*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_61 : allUpTo 64 (fun j => decide (popcount 12 (61*64+j) ≤ 3) || !(anfCoeff 12 truth12 (61*64+j))) = true := by decide +kernel
theorem mm_check_61 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 61)) == f12_mm u 61) = true := by decide +kernel
theorem rot_check_61 : allUpTo 64 (fun j => truth12 (rotShift 12 (61*64+j)) == truth12 (61*64+j)) = true := by decide +kernel
theorem spectrum_check_61 : allUpTo 64 (fun j => decide (walshMM12 (61*64+j) * walshMM12 (61*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_62 : allUpTo 64 (fun j => decide (popcount 12 (62*64+j) ≤ 3) || !(anfCoeff 12 truth12 (62*64+j))) = true := by decide +kernel
theorem mm_check_62 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 62)) == f12_mm u 62) = true := by decide +kernel
theorem rot_check_62 : allUpTo 64 (fun j => truth12 (rotShift 12 (62*64+j)) == truth12 (62*64+j)) = true := by decide +kernel
theorem spectrum_check_62 : allUpTo 64 (fun j => decide (walshMM12 (62*64+j) * walshMM12 (62*64+j) = (2 : Int)^12)) = true := by decide +kernel
theorem degree_check_63 : allUpTo 64 (fun j => decide (popcount 12 (63*64+j) ≤ 3) || !(anfCoeff 12 truth12 (63*64+j))) = true := by decide +kernel
theorem mm_check_63 : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ 63)) == f12_mm u 63) = true := by decide +kernel
theorem rot_check_63 : allUpTo 64 (fun j => truth12 (rotShift 12 (63*64+j)) == truth12 (63*64+j)) = true := by decide +kernel
theorem spectrum_check_63 : allUpTo 64 (fun j => decide (walshMM12 (63*64+j) * walshMM12 (63*64+j) = (2 : Int)^12)) = true := by decide +kernel

end HRSBF_Formalizacao_Real

/- ===== Módulo SmallChecks ===== -/
namespace HRSBF_Formalizacao_Real
set_option maxRecDepth 20000
set_option maxHeartbeats 0
theorem xor_perm_0 : ((List.range 64).map (fun z => 0 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_0 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 0)) = 64 := by decide +kernel
theorem xor_perm_1 : ((List.range 64).map (fun z => 1 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_1 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 1)) = 0 := by decide +kernel
theorem xor_perm_2 : ((List.range 64).map (fun z => 2 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_2 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 2)) = 0 := by decide +kernel
theorem xor_perm_3 : ((List.range 64).map (fun z => 3 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_3 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 3)) = 0 := by decide +kernel
theorem xor_perm_4 : ((List.range 64).map (fun z => 4 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_4 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 4)) = 0 := by decide +kernel
theorem xor_perm_5 : ((List.range 64).map (fun z => 5 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_5 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 5)) = 0 := by decide +kernel
theorem xor_perm_6 : ((List.range 64).map (fun z => 6 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_6 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 6)) = 0 := by decide +kernel
theorem xor_perm_7 : ((List.range 64).map (fun z => 7 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_7 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 7)) = 0 := by decide +kernel
theorem xor_perm_8 : ((List.range 64).map (fun z => 8 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_8 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 8)) = 0 := by decide +kernel
theorem xor_perm_9 : ((List.range 64).map (fun z => 9 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_9 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 9)) = 0 := by decide +kernel
theorem xor_perm_10 : ((List.range 64).map (fun z => 10 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_10 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 10)) = 0 := by decide +kernel
theorem xor_perm_11 : ((List.range 64).map (fun z => 11 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_11 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 11)) = 0 := by decide +kernel
theorem xor_perm_12 : ((List.range 64).map (fun z => 12 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_12 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 12)) = 0 := by decide +kernel
theorem xor_perm_13 : ((List.range 64).map (fun z => 13 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_13 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 13)) = 0 := by decide +kernel
theorem xor_perm_14 : ((List.range 64).map (fun z => 14 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_14 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 14)) = 0 := by decide +kernel
theorem xor_perm_15 : ((List.range 64).map (fun z => 15 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_15 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 15)) = 0 := by decide +kernel
theorem xor_perm_16 : ((List.range 64).map (fun z => 16 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_16 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 16)) = 0 := by decide +kernel
theorem xor_perm_17 : ((List.range 64).map (fun z => 17 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_17 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 17)) = 0 := by decide +kernel
theorem xor_perm_18 : ((List.range 64).map (fun z => 18 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_18 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 18)) = 0 := by decide +kernel
theorem xor_perm_19 : ((List.range 64).map (fun z => 19 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_19 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 19)) = 0 := by decide +kernel
theorem xor_perm_20 : ((List.range 64).map (fun z => 20 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_20 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 20)) = 0 := by decide +kernel
theorem xor_perm_21 : ((List.range 64).map (fun z => 21 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_21 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 21)) = 0 := by decide +kernel
theorem xor_perm_22 : ((List.range 64).map (fun z => 22 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_22 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 22)) = 0 := by decide +kernel
theorem xor_perm_23 : ((List.range 64).map (fun z => 23 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_23 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 23)) = 0 := by decide +kernel
theorem xor_perm_24 : ((List.range 64).map (fun z => 24 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_24 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 24)) = 0 := by decide +kernel
theorem xor_perm_25 : ((List.range 64).map (fun z => 25 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_25 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 25)) = 0 := by decide +kernel
theorem xor_perm_26 : ((List.range 64).map (fun z => 26 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_26 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 26)) = 0 := by decide +kernel
theorem xor_perm_27 : ((List.range 64).map (fun z => 27 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_27 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 27)) = 0 := by decide +kernel
theorem xor_perm_28 : ((List.range 64).map (fun z => 28 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_28 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 28)) = 0 := by decide +kernel
theorem xor_perm_29 : ((List.range 64).map (fun z => 29 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_29 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 29)) = 0 := by decide +kernel
theorem xor_perm_30 : ((List.range 64).map (fun z => 30 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_30 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 30)) = 0 := by decide +kernel
theorem xor_perm_31 : ((List.range 64).map (fun z => 31 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_31 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 31)) = 0 := by decide +kernel
theorem xor_perm_32 : ((List.range 64).map (fun z => 32 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_32 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 32)) = 0 := by decide +kernel
theorem xor_perm_33 : ((List.range 64).map (fun z => 33 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_33 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 33)) = 0 := by decide +kernel
theorem xor_perm_34 : ((List.range 64).map (fun z => 34 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_34 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 34)) = 0 := by decide +kernel
theorem xor_perm_35 : ((List.range 64).map (fun z => 35 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_35 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 35)) = 0 := by decide +kernel
theorem xor_perm_36 : ((List.range 64).map (fun z => 36 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_36 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 36)) = 0 := by decide +kernel
theorem xor_perm_37 : ((List.range 64).map (fun z => 37 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_37 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 37)) = 0 := by decide +kernel
theorem xor_perm_38 : ((List.range 64).map (fun z => 38 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_38 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 38)) = 0 := by decide +kernel
theorem xor_perm_39 : ((List.range 64).map (fun z => 39 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_39 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 39)) = 0 := by decide +kernel
theorem xor_perm_40 : ((List.range 64).map (fun z => 40 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_40 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 40)) = 0 := by decide +kernel
theorem xor_perm_41 : ((List.range 64).map (fun z => 41 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_41 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 41)) = 0 := by decide +kernel
theorem xor_perm_42 : ((List.range 64).map (fun z => 42 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_42 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 42)) = 0 := by decide +kernel
theorem xor_perm_43 : ((List.range 64).map (fun z => 43 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_43 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 43)) = 0 := by decide +kernel
theorem xor_perm_44 : ((List.range 64).map (fun z => 44 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_44 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 44)) = 0 := by decide +kernel
theorem xor_perm_45 : ((List.range 64).map (fun z => 45 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_45 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 45)) = 0 := by decide +kernel
theorem xor_perm_46 : ((List.range 64).map (fun z => 46 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_46 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 46)) = 0 := by decide +kernel
theorem xor_perm_47 : ((List.range 64).map (fun z => 47 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_47 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 47)) = 0 := by decide +kernel
theorem xor_perm_48 : ((List.range 64).map (fun z => 48 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_48 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 48)) = 0 := by decide +kernel
theorem xor_perm_49 : ((List.range 64).map (fun z => 49 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_49 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 49)) = 0 := by decide +kernel
theorem xor_perm_50 : ((List.range 64).map (fun z => 50 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_50 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 50)) = 0 := by decide +kernel
theorem xor_perm_51 : ((List.range 64).map (fun z => 51 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_51 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 51)) = 0 := by decide +kernel
theorem xor_perm_52 : ((List.range 64).map (fun z => 52 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_52 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 52)) = 0 := by decide +kernel
theorem xor_perm_53 : ((List.range 64).map (fun z => 53 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_53 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 53)) = 0 := by decide +kernel
theorem xor_perm_54 : ((List.range 64).map (fun z => 54 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_54 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 54)) = 0 := by decide +kernel
theorem xor_perm_55 : ((List.range 64).map (fun z => 55 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_55 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 55)) = 0 := by decide +kernel
theorem xor_perm_56 : ((List.range 64).map (fun z => 56 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_56 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 56)) = 0 := by decide +kernel
theorem xor_perm_57 : ((List.range 64).map (fun z => 57 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_57 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 57)) = 0 := by decide +kernel
theorem xor_perm_58 : ((List.range 64).map (fun z => 58 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_58 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 58)) = 0 := by decide +kernel
theorem xor_perm_59 : ((List.range 64).map (fun z => 59 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_59 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 59)) = 0 := by decide +kernel
theorem xor_perm_60 : ((List.range 64).map (fun z => 60 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_60 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 60)) = 0 := by decide +kernel
theorem xor_perm_61 : ((List.range 64).map (fun z => 61 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_61 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 61)) = 0 := by decide +kernel
theorem xor_perm_62 : ((List.range 64).map (fun z => 62 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_62 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 62)) = 0 := by decide +kernel
theorem xor_perm_63 : ((List.range 64).map (fun z => 63 ^^^ z)).Perm (List.range 64) := by decide +kernel
theorem orth_63 : sumIntUpTo 64 (fun u => signInt (dotParity 6 u 63)) = 0 := by decide +kernel
theorem pi6_bound_check : allUpTo 64 (fun z => decide (pi6 z < 64)) = true := by decide +kernel

end HRSBF_Formalizacao_Real

/- ===== Módulo N12Certificates ===== -/
namespace HRSBF_Formalizacao_Real
set_option maxRecDepth 20000
set_option maxHeartbeats 0
theorem truthBlock (b : Nat) (hb : b < 64) : allUpTo 64 (fun i => f12_explicit (b*64+i) == truth12 (b*64+i)) = true := by
  match b with
  | 0 => exact truth_check_0
  | 1 => exact truth_check_1
  | 2 => exact truth_check_2
  | 3 => exact truth_check_3
  | 4 => exact truth_check_4
  | 5 => exact truth_check_5
  | 6 => exact truth_check_6
  | 7 => exact truth_check_7
  | 8 => exact truth_check_8
  | 9 => exact truth_check_9
  | 10 => exact truth_check_10
  | 11 => exact truth_check_11
  | 12 => exact truth_check_12
  | 13 => exact truth_check_13
  | 14 => exact truth_check_14
  | 15 => exact truth_check_15
  | 16 => exact truth_check_16
  | 17 => exact truth_check_17
  | 18 => exact truth_check_18
  | 19 => exact truth_check_19
  | 20 => exact truth_check_20
  | 21 => exact truth_check_21
  | 22 => exact truth_check_22
  | 23 => exact truth_check_23
  | 24 => exact truth_check_24
  | 25 => exact truth_check_25
  | 26 => exact truth_check_26
  | 27 => exact truth_check_27
  | 28 => exact truth_check_28
  | 29 => exact truth_check_29
  | 30 => exact truth_check_30
  | 31 => exact truth_check_31
  | 32 => exact truth_check_32
  | 33 => exact truth_check_33
  | 34 => exact truth_check_34
  | 35 => exact truth_check_35
  | 36 => exact truth_check_36
  | 37 => exact truth_check_37
  | 38 => exact truth_check_38
  | 39 => exact truth_check_39
  | 40 => exact truth_check_40
  | 41 => exact truth_check_41
  | 42 => exact truth_check_42
  | 43 => exact truth_check_43
  | 44 => exact truth_check_44
  | 45 => exact truth_check_45
  | 46 => exact truth_check_46
  | 47 => exact truth_check_47
  | 48 => exact truth_check_48
  | 49 => exact truth_check_49
  | 50 => exact truth_check_50
  | 51 => exact truth_check_51
  | 52 => exact truth_check_52
  | 53 => exact truth_check_53
  | 54 => exact truth_check_54
  | 55 => exact truth_check_55
  | 56 => exact truth_check_56
  | 57 => exact truth_check_57
  | 58 => exact truth_check_58
  | 59 => exact truth_check_59
  | 60 => exact truth_check_60
  | 61 => exact truth_check_61
  | 62 => exact truth_check_62
  | 63 => exact truth_check_63
  | k+64 => omega

theorem degreeBlock (b : Nat) (hb : b < 64) : allUpTo 64 (fun j => decide (popcount 12 (b*64+j) ≤ 3) || !(anfCoeff 12 truth12 (b*64+j))) = true := by
  match b with
  | 0 => exact degree_check_0
  | 1 => exact degree_check_1
  | 2 => exact degree_check_2
  | 3 => exact degree_check_3
  | 4 => exact degree_check_4
  | 5 => exact degree_check_5
  | 6 => exact degree_check_6
  | 7 => exact degree_check_7
  | 8 => exact degree_check_8
  | 9 => exact degree_check_9
  | 10 => exact degree_check_10
  | 11 => exact degree_check_11
  | 12 => exact degree_check_12
  | 13 => exact degree_check_13
  | 14 => exact degree_check_14
  | 15 => exact degree_check_15
  | 16 => exact degree_check_16
  | 17 => exact degree_check_17
  | 18 => exact degree_check_18
  | 19 => exact degree_check_19
  | 20 => exact degree_check_20
  | 21 => exact degree_check_21
  | 22 => exact degree_check_22
  | 23 => exact degree_check_23
  | 24 => exact degree_check_24
  | 25 => exact degree_check_25
  | 26 => exact degree_check_26
  | 27 => exact degree_check_27
  | 28 => exact degree_check_28
  | 29 => exact degree_check_29
  | 30 => exact degree_check_30
  | 31 => exact degree_check_31
  | 32 => exact degree_check_32
  | 33 => exact degree_check_33
  | 34 => exact degree_check_34
  | 35 => exact degree_check_35
  | 36 => exact degree_check_36
  | 37 => exact degree_check_37
  | 38 => exact degree_check_38
  | 39 => exact degree_check_39
  | 40 => exact degree_check_40
  | 41 => exact degree_check_41
  | 42 => exact degree_check_42
  | 43 => exact degree_check_43
  | 44 => exact degree_check_44
  | 45 => exact degree_check_45
  | 46 => exact degree_check_46
  | 47 => exact degree_check_47
  | 48 => exact degree_check_48
  | 49 => exact degree_check_49
  | 50 => exact degree_check_50
  | 51 => exact degree_check_51
  | 52 => exact degree_check_52
  | 53 => exact degree_check_53
  | 54 => exact degree_check_54
  | 55 => exact degree_check_55
  | 56 => exact degree_check_56
  | 57 => exact degree_check_57
  | 58 => exact degree_check_58
  | 59 => exact degree_check_59
  | 60 => exact degree_check_60
  | 61 => exact degree_check_61
  | 62 => exact degree_check_62
  | 63 => exact degree_check_63
  | k+64 => omega

theorem mmBlock (b : Nat) (hb : b < 64) : allUpTo 64 (fun u => truth12 (u+64*(u ^^^ b)) == f12_mm u b) = true := by
  match b with
  | 0 => exact mm_check_0
  | 1 => exact mm_check_1
  | 2 => exact mm_check_2
  | 3 => exact mm_check_3
  | 4 => exact mm_check_4
  | 5 => exact mm_check_5
  | 6 => exact mm_check_6
  | 7 => exact mm_check_7
  | 8 => exact mm_check_8
  | 9 => exact mm_check_9
  | 10 => exact mm_check_10
  | 11 => exact mm_check_11
  | 12 => exact mm_check_12
  | 13 => exact mm_check_13
  | 14 => exact mm_check_14
  | 15 => exact mm_check_15
  | 16 => exact mm_check_16
  | 17 => exact mm_check_17
  | 18 => exact mm_check_18
  | 19 => exact mm_check_19
  | 20 => exact mm_check_20
  | 21 => exact mm_check_21
  | 22 => exact mm_check_22
  | 23 => exact mm_check_23
  | 24 => exact mm_check_24
  | 25 => exact mm_check_25
  | 26 => exact mm_check_26
  | 27 => exact mm_check_27
  | 28 => exact mm_check_28
  | 29 => exact mm_check_29
  | 30 => exact mm_check_30
  | 31 => exact mm_check_31
  | 32 => exact mm_check_32
  | 33 => exact mm_check_33
  | 34 => exact mm_check_34
  | 35 => exact mm_check_35
  | 36 => exact mm_check_36
  | 37 => exact mm_check_37
  | 38 => exact mm_check_38
  | 39 => exact mm_check_39
  | 40 => exact mm_check_40
  | 41 => exact mm_check_41
  | 42 => exact mm_check_42
  | 43 => exact mm_check_43
  | 44 => exact mm_check_44
  | 45 => exact mm_check_45
  | 46 => exact mm_check_46
  | 47 => exact mm_check_47
  | 48 => exact mm_check_48
  | 49 => exact mm_check_49
  | 50 => exact mm_check_50
  | 51 => exact mm_check_51
  | 52 => exact mm_check_52
  | 53 => exact mm_check_53
  | 54 => exact mm_check_54
  | 55 => exact mm_check_55
  | 56 => exact mm_check_56
  | 57 => exact mm_check_57
  | 58 => exact mm_check_58
  | 59 => exact mm_check_59
  | 60 => exact mm_check_60
  | 61 => exact mm_check_61
  | 62 => exact mm_check_62
  | 63 => exact mm_check_63
  | k+64 => omega

theorem rotBlock (b : Nat) (hb : b < 64) : allUpTo 64 (fun j => truth12 (rotShift 12 (b*64+j)) == truth12 (b*64+j)) = true := by
  match b with
  | 0 => exact rot_check_0
  | 1 => exact rot_check_1
  | 2 => exact rot_check_2
  | 3 => exact rot_check_3
  | 4 => exact rot_check_4
  | 5 => exact rot_check_5
  | 6 => exact rot_check_6
  | 7 => exact rot_check_7
  | 8 => exact rot_check_8
  | 9 => exact rot_check_9
  | 10 => exact rot_check_10
  | 11 => exact rot_check_11
  | 12 => exact rot_check_12
  | 13 => exact rot_check_13
  | 14 => exact rot_check_14
  | 15 => exact rot_check_15
  | 16 => exact rot_check_16
  | 17 => exact rot_check_17
  | 18 => exact rot_check_18
  | 19 => exact rot_check_19
  | 20 => exact rot_check_20
  | 21 => exact rot_check_21
  | 22 => exact rot_check_22
  | 23 => exact rot_check_23
  | 24 => exact rot_check_24
  | 25 => exact rot_check_25
  | 26 => exact rot_check_26
  | 27 => exact rot_check_27
  | 28 => exact rot_check_28
  | 29 => exact rot_check_29
  | 30 => exact rot_check_30
  | 31 => exact rot_check_31
  | 32 => exact rot_check_32
  | 33 => exact rot_check_33
  | 34 => exact rot_check_34
  | 35 => exact rot_check_35
  | 36 => exact rot_check_36
  | 37 => exact rot_check_37
  | 38 => exact rot_check_38
  | 39 => exact rot_check_39
  | 40 => exact rot_check_40
  | 41 => exact rot_check_41
  | 42 => exact rot_check_42
  | 43 => exact rot_check_43
  | 44 => exact rot_check_44
  | 45 => exact rot_check_45
  | 46 => exact rot_check_46
  | 47 => exact rot_check_47
  | 48 => exact rot_check_48
  | 49 => exact rot_check_49
  | 50 => exact rot_check_50
  | 51 => exact rot_check_51
  | 52 => exact rot_check_52
  | 53 => exact rot_check_53
  | 54 => exact rot_check_54
  | 55 => exact rot_check_55
  | 56 => exact rot_check_56
  | 57 => exact rot_check_57
  | 58 => exact rot_check_58
  | 59 => exact rot_check_59
  | 60 => exact rot_check_60
  | 61 => exact rot_check_61
  | 62 => exact rot_check_62
  | 63 => exact rot_check_63
  | k+64 => omega

theorem spectrumBlock (b : Nat) (hb : b < 64) : allUpTo 64 (fun j => decide (walshMM12 (b*64+j) * walshMM12 (b*64+j) = (2 : Int)^12)) = true := by
  match b with
  | 0 => exact spectrum_check_0
  | 1 => exact spectrum_check_1
  | 2 => exact spectrum_check_2
  | 3 => exact spectrum_check_3
  | 4 => exact spectrum_check_4
  | 5 => exact spectrum_check_5
  | 6 => exact spectrum_check_6
  | 7 => exact spectrum_check_7
  | 8 => exact spectrum_check_8
  | 9 => exact spectrum_check_9
  | 10 => exact spectrum_check_10
  | 11 => exact spectrum_check_11
  | 12 => exact spectrum_check_12
  | 13 => exact spectrum_check_13
  | 14 => exact spectrum_check_14
  | 15 => exact spectrum_check_15
  | 16 => exact spectrum_check_16
  | 17 => exact spectrum_check_17
  | 18 => exact spectrum_check_18
  | 19 => exact spectrum_check_19
  | 20 => exact spectrum_check_20
  | 21 => exact spectrum_check_21
  | 22 => exact spectrum_check_22
  | 23 => exact spectrum_check_23
  | 24 => exact spectrum_check_24
  | 25 => exact spectrum_check_25
  | 26 => exact spectrum_check_26
  | 27 => exact spectrum_check_27
  | 28 => exact spectrum_check_28
  | 29 => exact spectrum_check_29
  | 30 => exact spectrum_check_30
  | 31 => exact spectrum_check_31
  | 32 => exact spectrum_check_32
  | 33 => exact spectrum_check_33
  | 34 => exact spectrum_check_34
  | 35 => exact spectrum_check_35
  | 36 => exact spectrum_check_36
  | 37 => exact spectrum_check_37
  | 38 => exact spectrum_check_38
  | 39 => exact spectrum_check_39
  | 40 => exact spectrum_check_40
  | 41 => exact spectrum_check_41
  | 42 => exact spectrum_check_42
  | 43 => exact spectrum_check_43
  | 44 => exact spectrum_check_44
  | 45 => exact spectrum_check_45
  | 46 => exact spectrum_check_46
  | 47 => exact spectrum_check_47
  | 48 => exact spectrum_check_48
  | 49 => exact spectrum_check_49
  | 50 => exact spectrum_check_50
  | 51 => exact spectrum_check_51
  | 52 => exact spectrum_check_52
  | 53 => exact spectrum_check_53
  | 54 => exact spectrum_check_54
  | 55 => exact spectrum_check_55
  | 56 => exact spectrum_check_56
  | 57 => exact spectrum_check_57
  | 58 => exact spectrum_check_58
  | 59 => exact spectrum_check_59
  | 60 => exact spectrum_check_60
  | 61 => exact spectrum_check_61
  | 62 => exact spectrum_check_62
  | 63 => exact spectrum_check_63
  | k+64 => omega

theorem xorPerm (b : Nat) (hb : b < 64) : ((List.range 64).map (fun z => b ^^^ z)).Perm (List.range 64) := by
  match b with
  | 0 => exact xor_perm_0
  | 1 => exact xor_perm_1
  | 2 => exact xor_perm_2
  | 3 => exact xor_perm_3
  | 4 => exact xor_perm_4
  | 5 => exact xor_perm_5
  | 6 => exact xor_perm_6
  | 7 => exact xor_perm_7
  | 8 => exact xor_perm_8
  | 9 => exact xor_perm_9
  | 10 => exact xor_perm_10
  | 11 => exact xor_perm_11
  | 12 => exact xor_perm_12
  | 13 => exact xor_perm_13
  | 14 => exact xor_perm_14
  | 15 => exact xor_perm_15
  | 16 => exact xor_perm_16
  | 17 => exact xor_perm_17
  | 18 => exact xor_perm_18
  | 19 => exact xor_perm_19
  | 20 => exact xor_perm_20
  | 21 => exact xor_perm_21
  | 22 => exact xor_perm_22
  | 23 => exact xor_perm_23
  | 24 => exact xor_perm_24
  | 25 => exact xor_perm_25
  | 26 => exact xor_perm_26
  | 27 => exact xor_perm_27
  | 28 => exact xor_perm_28
  | 29 => exact xor_perm_29
  | 30 => exact xor_perm_30
  | 31 => exact xor_perm_31
  | 32 => exact xor_perm_32
  | 33 => exact xor_perm_33
  | 34 => exact xor_perm_34
  | 35 => exact xor_perm_35
  | 36 => exact xor_perm_36
  | 37 => exact xor_perm_37
  | 38 => exact xor_perm_38
  | 39 => exact xor_perm_39
  | 40 => exact xor_perm_40
  | 41 => exact xor_perm_41
  | 42 => exact xor_perm_42
  | 43 => exact xor_perm_43
  | 44 => exact xor_perm_44
  | 45 => exact xor_perm_45
  | 46 => exact xor_perm_46
  | 47 => exact xor_perm_47
  | 48 => exact xor_perm_48
  | 49 => exact xor_perm_49
  | 50 => exact xor_perm_50
  | 51 => exact xor_perm_51
  | 52 => exact xor_perm_52
  | 53 => exact xor_perm_53
  | 54 => exact xor_perm_54
  | 55 => exact xor_perm_55
  | 56 => exact xor_perm_56
  | 57 => exact xor_perm_57
  | 58 => exact xor_perm_58
  | 59 => exact xor_perm_59
  | 60 => exact xor_perm_60
  | 61 => exact xor_perm_61
  | 62 => exact xor_perm_62
  | 63 => exact xor_perm_63
  | k+64 => omega

theorem orthogonal6 (b : Nat) (hb : b < 64) : sumIntUpTo 64 (fun u => signInt (dotParity 6 u b)) = (if b == 0 then 64 else 0) := by
  match b with
  | 0 => exact orth_0
  | 1 => exact orth_1
  | 2 => exact orth_2
  | 3 => exact orth_3
  | 4 => exact orth_4
  | 5 => exact orth_5
  | 6 => exact orth_6
  | 7 => exact orth_7
  | 8 => exact orth_8
  | 9 => exact orth_9
  | 10 => exact orth_10
  | 11 => exact orth_11
  | 12 => exact orth_12
  | 13 => exact orth_13
  | 14 => exact orth_14
  | 15 => exact orth_15
  | 16 => exact orth_16
  | 17 => exact orth_17
  | 18 => exact orth_18
  | 19 => exact orth_19
  | 20 => exact orth_20
  | 21 => exact orth_21
  | 22 => exact orth_22
  | 23 => exact orth_23
  | 24 => exact orth_24
  | 25 => exact orth_25
  | 26 => exact orth_26
  | 27 => exact orth_27
  | 28 => exact orth_28
  | 29 => exact orth_29
  | 30 => exact orth_30
  | 31 => exact orth_31
  | 32 => exact orth_32
  | 33 => exact orth_33
  | 34 => exact orth_34
  | 35 => exact orth_35
  | 36 => exact orth_36
  | 37 => exact orth_37
  | 38 => exact orth_38
  | 39 => exact orth_39
  | 40 => exact orth_40
  | 41 => exact orth_41
  | 42 => exact orth_42
  | 43 => exact orth_43
  | 44 => exact orth_44
  | 45 => exact orth_45
  | 46 => exact orth_46
  | 47 => exact orth_47
  | 48 => exact orth_48
  | 49 => exact orth_49
  | 50 => exact orth_50
  | 51 => exact orth_51
  | 52 => exact orth_52
  | 53 => exact orth_53
  | 54 => exact orth_54
  | 55 => exact orth_55
  | 56 => exact orth_56
  | 57 => exact orth_57
  | 58 => exact orth_58
  | 59 => exact orth_59
  | 60 => exact orth_60
  | 61 => exact orth_61
  | 62 => exact orth_62
  | 63 => exact orth_63
  | k+64 => omega

theorem f12_eq_truth (x : Nat) (hx : x < 4096) : f12_explicit x = truth12 x := by
  have hb : x/64 < 64 := by omega
  have he : x/64*64+x%64=x := by omega
  have hr := allUpTo_sound 64 _ (truthBlock (x/64) hb) (x%64) (by omega)
  try dsimp only at hr
  rw [he] at hr
  exact of_decide_eq_true hr

theorem pi6_bound (z : Nat) (hz : z < 64) : pi6 z < 64 := by
  exact of_decide_eq_true (allUpTo_sound 64 _ pi6_bound_check z hz)

theorem f12_mm_identity (u z : Nat) (hu : u < 64) (hz : z < 64) :
    f12_explicit (u+64*(u ^^^ z)) = f12_mm u z := by
  have hxor : u ^^^ z < 64 := Nat.xor_lt_two_pow (n:=6) hu hz
  rw [f12_eq_truth _ (by omega)]
  exact of_decide_eq_true (allUpTo_sound 64 _ (mmBlock z hz) u hu)

theorem f12_has_degree_at_most_3 : HasDegreeAtMost 12 3 f12_explicit := by
  intro s hs hc
  have hcoef := anfCoeff_congr 12 f12_explicit truth12 s f12_eq_truth
  rw [hcoef] at hc
  have hr := allUpTo_sound 64 _ (degreeBlock (s/64) (by omega)) (s%64) (by omega)
  have he : s/64*64+s%64=s := by omega
  try dsimp only at hr
  rw [he] at hr
  change (decide (popcount 12 s ≤ 3) || !(anfCoeff 12 truth12 s)) = true at hr
  rw [hc] at hr
  simp only [Bool.not_true, Bool.or_false] at hr
  exact of_decide_eq_true hr

theorem f12_walsh_mm_sq_proved (u : Nat) (hu : u < 4096) :
    walshMM12 u * walshMM12 u = (2 : Int)^12 := by
  have hr := allUpTo_sound 64 _ (spectrumBlock (u/64) (by omega)) (u%64) (by omega)
  have he : u/64*64+u%64=u := by omega
  try dsimp only at hr
  rw [he] at hr
  exact of_decide_eq_true hr

theorem sumNat_le (m : Nat) (f g : Nat → Nat) (h : ∀ i, i < m → f i ≤ g i) :
    sumNatUpTo m f ≤ sumNatUpTo m g := by
  induction m with
  | zero => exact Nat.le_refl 0
  | succ m ih =>
    change sumNatUpTo m f + f m ≤ sumNatUpTo m g + g m
    exact Nat.add_le_add (ih (fun i hi => h i (by omega))) (h m (by omega))

theorem rotShift12_bound (x : Nat) : rotShift 12 x < 4096 := by
  have h : rotShift 12 x ≤ sumNatUpTo 12 (fun i => 2^i) := by
    apply sumNat_le
    intro i hi
    split
    · exact Nat.le_refl _
    · exact Nat.zero_le _
  have hc : sumNatUpTo 12 (fun i => 2^i) = 4095 := by decide +kernel
  omega

theorem f12_is_rotation_symmetric : IsRotationSymmetric 12 f12_explicit := by
  intro x hx
  rw [f12_eq_truth _ (rotShift12_bound x), f12_eq_truth x hx]
  have hr := allUpTo_sound 64 _ (rotBlock (x/64) (by omega)) (x%64) (by omega)
  have he : x/64*64+x%64=x := by omega
  try dsimp only at hr
  rw [he] at hr
  exact of_decide_eq_true hr

theorem f12_hamming_weight_eq_2080 : hammingWeight 12 f12_explicit = 2080 := by
  unfold hammingWeight
  have he : sumNatUpTo (2^12) (fun x => if f12_explicit x then 1 else 0) =
      sumNatUpTo (2^12) (fun x => if truth12 x then 1 else 0) := by
    apply sumNat_congr
    intro x hx
    rw [f12_eq_truth x hx]
  rw [he, ← show sumNatTree 12 0 (fun x => if truth12 x then 1 else 0) =
    sumNatUpTo (2^12) (fun x => if truth12 x then 1 else 0) by simpa using sumNatTree_eq 12 0 (fun x => if truth12 x then 1 else 0)]
  decide +kernel

theorem f12_anf_cubic_and_quad_witnesses :
    (anfCoeff 12 f12_explicit 69 = true ∧ popcount 12 69 = 3) ∧
    (anfCoeff 12 f12_explicit 3 = true ∧ popcount 12 3 = 2) := by decide +kernel

theorem f12_not_homogeneous_cubic : ¬ IsHomogeneousCubic 12 f12_explicit := by
  intro h
  have h3 := h.2 3 (by decide) f12_anf_cubic_and_quad_witnesses.2.1
  have h2 := f12_anf_cubic_and_quad_witnesses.2.2
  omega

end HRSBF_Formalizacao_Real

/- ===== Módulo N12Bent ===== -/
namespace HRSBF_Formalizacao_Real
set_option maxRecDepth 20000
set_option maxHeartbeats 0

theorem mm_character (u z a b : Nat) (hu : u < 64) (hz : z < 64) (ha : a < 64) :
    signInt (bxor (f12_explicit (u+64*(u ^^^ z)))
      (dotParity 12 (u+64*(u ^^^ z)) (a+64*b))) =
    signInt (dotParity 6 u (pi6 z ^^^ (a ^^^ b))) *
      signInt (bxor (h6 z) (dotParity 6 z b)) := by
  rw [f12_mm_identity u z hu hz, dotParity_join u (u ^^^ z) a b hu ha]
  unfold f12_mm
  rw [dotParity_comm 6 (pi6 z) u, dotParity_xor_left]
  rw [dotParity_xor_right, dotParity_xor_right]
  exact character_five _ _ _ _ _

theorem xor_ne_zero_of_ne (a b : Nat) (h : a ≠ b) : a ^^^ b ≠ 0 := by
  intro he
  have hh := congrArg (fun q => a ^^^ q) he
  simp only [← Nat.xor_assoc, Nat.xor_self, Nat.zero_xor, Nat.xor_zero] at hh
  exact h hh.symm

theorem mm_inner (z a b : Nat) (hz : z < 64) (ha : a < 64) (hb : b < 64) :
    sumIntUpTo 64 (fun u =>
      signInt (bxor (f12_explicit (u+64*(u ^^^ z)))
        (dotParity 12 (u+64*(u ^^^ z)) (a+64*b)))) =
    (if pi6 z == (a ^^^ b) then
      (64 : Int) * signInt (bxor (h6 z) (dotParity 6 b z)) else 0) := by
  have he := sumInt_congr 64 _ _ (fun u hu => mm_character u z a b hu hz ha)
  rw [he, sumInt_mul_right]
  have ht : pi6 z ^^^ (a ^^^ b) < 64 :=
    Nat.xor_lt_two_pow (n:=6) (pi6_bound z hz) (Nat.xor_lt_two_pow (n:=6) ha hb)
  rw [orthogonal6 _ ht, dotParity_comm 6 z b]
  by_cases h : pi6 z = (a ^^^ b)
  · simp only [h, Nat.xor_self, beq_self_eq_true, ↓reduceIte]
  · have hn := xor_ne_zero_of_ne _ _ h
    simp only [beq_iff_eq, h, hn, ↓reduceIte, Int.zero_mul]

theorem walsh12_join (a b : Nat) (ha : a < 64) (hb : b < 64) :
    walsh 12 f12_explicit (a+64*b) =
    sumIntUpTo 64 (fun z => if pi6 z == (a ^^^ b) then
      (64 : Int) * signInt (bxor (h6 z) (dotParity 6 b z)) else 0) := by
  unfold walsh
  change sumIntUpTo (64*64) _ = _
  rw [sumInt_blocks, sumInt_swap]
  have he : sumIntUpTo 64 (fun u => sumIntUpTo 64 (fun v =>
      signInt (bxor (f12_explicit (u+64*v)) (dotParity 12 (u+64*v) (a+64*b))))) =
    sumIntUpTo 64 (fun u => sumIntUpTo 64 (fun z =>
      signInt (bxor (f12_explicit (u+64*(u ^^^ z)))
        (dotParity 12 (u+64*(u ^^^ z)) (a+64*b))))) := by
    apply sumInt_congr
    intro u hu
    exact (sumInt_reindex 64 (fun z => u ^^^ z) (xorPerm u hu) _).symm
  -- The original blocks use v*64+u; commutativity changes only their notation.
  have he0 : (fun u => sumIntUpTo 64 (fun v =>
      signInt (bxor (f12_explicit (v*64+u)) (dotParity 12 (v*64+u) (a+64*b))))) =
    (fun u => sumIntUpTo 64 (fun v =>
      signInt (bxor (f12_explicit (u+64*v)) (dotParity 12 (u+64*v) (a+64*b))))) := by
    funext u
    apply sumInt_congr
    intro v hv
    rw [show v*64+u=u+64*v by omega]
  rw [he0, he, sumInt_swap]
  apply sumInt_congr
  intro z hz
  exact mm_inner z a b hz ha hb

theorem walshMM12_join (a b : Nat) (ha : a < 64) (hb : b < 64) :
    walshMM12 (a+64*b) = sumIntUpTo 64 (fun z => if pi6 z == (a ^^^ b) then
      (64 : Int) * signInt (bxor (h6 z) (dotParity 6 b z)) else 0) := by
  have hlow : (a+64*b) &&& 63 = a := by
    have hm : (a+64*b) % 64 = a := by omega
    simpa only [show 63=2^6-1 from rfl, Nat.and_pow_two_sub_one_eq_mod] using hm
  have hhigh : ((a+64*b) >>> 6) &&& 63 = b := by
    rw [Nat.shiftRight_eq_div_pow]
    have hd : (a+64*b)/2^6=b := by omega
    rw [hd]
    exact Nat.and_pow_two_sub_one_of_lt_two_pow (n:=6) hb
  unfold walshMM12
  rw [hlow, hhigh]

theorem walsh12_eq_walshMM12 (w : Nat) (hw : w < 4096) :
    walsh 12 f12_explicit w = walshMM12 w := by
  have ha : w%64<64 := by omega
  have hb : w/64<64 := by omega
  have hw' : w=w%64+64*(w/64) := by omega
  rw [hw', walsh12_join _ _ ha hb, walshMM12_join _ _ ha hb]

theorem f12_is_bent : IsBent 12 f12_explicit := by
  intro u hu
  rw [walsh12_eq_walshMM12 u hu]
  exact f12_walsh_mm_sq_proved u hu

theorem counterexample_n12_certificate_proved : CounterexampleN12Certificate f12_explicit :=
  { rot_symm := f12_is_rotation_symmetric
    deg_le_3 := f12_has_degree_at_most_3
    has_cubic_term := f12_anf_cubic_and_quad_witnesses.1
    has_quad_term := f12_anf_cubic_and_quad_witnesses.2
    non_homogeneous := f12_not_homogeneous_cubic
    weight_eq_2080 := f12_hamming_weight_eq_2080
    bent := f12_is_bent }

end HRSBF_Formalizacao_Real

/- ===== Módulo Transfer ===== -/
namespace HRSBF_Formalizacao_Real
set_option maxRecDepth 10000
set_option maxHeartbeats 0
def matrixCert_1 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 1
  | 0,1 => 1
  | 0,2 => 0
  | 0,3 => 0
  | 1,0 => 0
  | 1,1 => 0
  | 1,2 => 1
  | 1,3 => 1
  | 2,0 => 1
  | 2,1 => 1
  | 2,2 => 0
  | 2,3 => 0
  | 3,0 => 0
  | 3,1 => 0
  | 3,2 => 1
  | 3,3 => -1
  | _,_ => 0
def matrixCert_2 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 1
  | 0,1 => 1
  | 0,2 => 1
  | 0,3 => 1
  | 1,0 => 1
  | 1,1 => 1
  | 1,2 => 1
  | 1,3 => -1
  | 2,0 => 1
  | 2,1 => 1
  | 2,2 => 1
  | 2,3 => 1
  | 3,0 => 1
  | 3,1 => 1
  | 3,2 => -1
  | 3,3 => 1
  | _,_ => 0
def matrixCert_3 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 2
  | 0,1 => 2
  | 0,2 => 2
  | 0,3 => 0
  | 1,0 => 2
  | 1,1 => 2
  | 1,2 => 0
  | 1,3 => 2
  | 2,0 => 2
  | 2,1 => 2
  | 2,2 => 2
  | 2,3 => 0
  | 3,0 => 0
  | 3,1 => 0
  | 3,2 => 2
  | 3,3 => 0
  | _,_ => 0
def matrixCert_4 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 4
  | 0,1 => 4
  | 0,2 => 2
  | 0,3 => 2
  | 1,0 => 2
  | 1,1 => 2
  | 1,2 => 4
  | 1,3 => 0
  | 2,0 => 4
  | 2,1 => 4
  | 2,2 => 2
  | 2,3 => 2
  | 3,0 => 2
  | 3,1 => 2
  | 3,2 => 0
  | 3,3 => 0
  | _,_ => 0
def matrixCert_5 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 6
  | 0,1 => 6
  | 0,2 => 6
  | 0,3 => 2
  | 1,0 => 6
  | 1,1 => 6
  | 1,2 => 2
  | 1,3 => 2
  | 2,0 => 6
  | 2,1 => 6
  | 2,2 => 6
  | 2,3 => 2
  | 3,0 => 2
  | 3,1 => 2
  | 3,2 => 2
  | 3,3 => 2
  | _,_ => 0
def matrixCert_6 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 12
  | 0,1 => 12
  | 0,2 => 8
  | 0,3 => 4
  | 1,0 => 8
  | 1,1 => 8
  | 1,2 => 8
  | 1,3 => 4
  | 2,0 => 12
  | 2,1 => 12
  | 2,2 => 8
  | 2,3 => 4
  | 3,0 => 4
  | 3,1 => 4
  | 3,2 => 4
  | 3,3 => 0
  | _,_ => 0
def matrixCert_7 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 20
  | 0,1 => 20
  | 0,2 => 16
  | 0,3 => 8
  | 1,0 => 16
  | 1,1 => 16
  | 1,2 => 12
  | 1,3 => 4
  | 2,0 => 20
  | 2,1 => 20
  | 2,2 => 16
  | 2,3 => 8
  | 3,0 => 8
  | 3,1 => 8
  | 3,2 => 4
  | 3,3 => 4
  | _,_ => 0
def matrixCert_8 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 36
  | 0,1 => 36
  | 0,2 => 28
  | 0,3 => 12
  | 1,0 => 28
  | 1,1 => 28
  | 1,2 => 20
  | 1,3 => 12
  | 2,0 => 36
  | 2,1 => 36
  | 2,2 => 28
  | 2,3 => 12
  | 3,0 => 12
  | 3,1 => 12
  | 3,2 => 12
  | 3,3 => 4
  | _,_ => 0
def matrixCert_9 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 64
  | 0,1 => 64
  | 0,2 => 48
  | 0,3 => 24
  | 1,0 => 48
  | 1,1 => 48
  | 1,2 => 40
  | 1,3 => 16
  | 2,0 => 64
  | 2,1 => 64
  | 2,2 => 48
  | 2,3 => 24
  | 3,0 => 24
  | 3,1 => 24
  | 3,2 => 16
  | 3,3 => 8
  | _,_ => 0
def matrixCert_10 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 112
  | 0,1 => 112
  | 0,2 => 88
  | 0,3 => 40
  | 1,0 => 88
  | 1,1 => 88
  | 1,2 => 64
  | 1,3 => 32
  | 2,0 => 112
  | 2,1 => 112
  | 2,2 => 88
  | 2,3 => 40
  | 3,0 => 40
  | 3,1 => 40
  | 3,2 => 32
  | 3,3 => 16
  | _,_ => 0
def matrixCert_11 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 200
  | 0,1 => 200
  | 0,2 => 152
  | 0,3 => 72
  | 1,0 => 152
  | 1,1 => 152
  | 1,2 => 120
  | 1,3 => 56
  | 2,0 => 200
  | 2,1 => 200
  | 2,2 => 152
  | 2,3 => 72
  | 3,0 => 72
  | 3,1 => 72
  | 3,2 => 56
  | 3,3 => 24
  | _,_ => 0
def matrixCert_12 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 352
  | 0,1 => 352
  | 0,2 => 272
  | 0,3 => 128
  | 1,0 => 272
  | 1,1 => 272
  | 1,2 => 208
  | 1,3 => 96
  | 2,0 => 352
  | 2,1 => 352
  | 2,2 => 272
  | 2,3 => 128
  | 3,0 => 128
  | 3,1 => 128
  | 3,2 => 96
  | 3,3 => 48
  | _,_ => 0
def matrixCert_13 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 624
  | 0,1 => 624
  | 0,2 => 480
  | 0,3 => 224
  | 1,0 => 480
  | 1,1 => 480
  | 1,2 => 368
  | 1,3 => 176
  | 2,0 => 624
  | 2,1 => 624
  | 2,2 => 480
  | 2,3 => 224
  | 3,0 => 224
  | 3,1 => 224
  | 3,2 => 176
  | 3,3 => 80
  | _,_ => 0
def matrixCert_14 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 1104
  | 0,1 => 1104
  | 0,2 => 848
  | 0,3 => 400
  | 1,0 => 848
  | 1,1 => 848
  | 1,2 => 656
  | 1,3 => 304
  | 2,0 => 1104
  | 2,1 => 1104
  | 2,2 => 848
  | 2,3 => 400
  | 3,0 => 400
  | 3,1 => 400
  | 3,2 => 304
  | 3,3 => 144
  | _,_ => 0
def matrixCert_15 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 1952
  | 0,1 => 1952
  | 0,2 => 1504
  | 0,3 => 704
  | 1,0 => 1504
  | 1,1 => 1504
  | 1,2 => 1152
  | 1,3 => 544
  | 2,0 => 1952
  | 2,1 => 1952
  | 2,2 => 1504
  | 2,3 => 704
  | 3,0 => 704
  | 3,1 => 704
  | 3,2 => 544
  | 3,3 => 256
  | _,_ => 0
def matrixCert_16 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 3456
  | 0,1 => 3456
  | 0,2 => 2656
  | 0,3 => 1248
  | 1,0 => 2656
  | 1,1 => 2656
  | 1,2 => 2048
  | 1,3 => 960
  | 2,0 => 3456
  | 2,1 => 3456
  | 2,2 => 2656
  | 2,3 => 1248
  | 3,0 => 1248
  | 3,1 => 1248
  | 3,2 => 960
  | 3,3 => 448
  | _,_ => 0
def matrixCert_17 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 6112
  | 0,1 => 6112
  | 0,2 => 4704
  | 0,3 => 2208
  | 1,0 => 4704
  | 1,1 => 4704
  | 1,2 => 3616
  | 1,3 => 1696
  | 2,0 => 6112
  | 2,1 => 6112
  | 2,2 => 4704
  | 2,3 => 2208
  | 3,0 => 2208
  | 3,1 => 2208
  | 3,2 => 1696
  | 3,3 => 800
  | _,_ => 0
def matrixCert_18 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 10816
  | 0,1 => 10816
  | 0,2 => 8320
  | 0,3 => 3904
  | 1,0 => 8320
  | 1,1 => 8320
  | 1,2 => 6400
  | 1,3 => 3008
  | 2,0 => 10816
  | 2,1 => 10816
  | 2,2 => 8320
  | 2,3 => 3904
  | 3,0 => 3904
  | 3,1 => 3904
  | 3,2 => 3008
  | 3,3 => 1408
  | _,_ => 0
def matrixCert_19 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 19136
  | 0,1 => 19136
  | 0,2 => 14720
  | 0,3 => 6912
  | 1,0 => 14720
  | 1,1 => 14720
  | 1,2 => 11328
  | 1,3 => 5312
  | 2,0 => 19136
  | 2,1 => 19136
  | 2,2 => 14720
  | 2,3 => 6912
  | 3,0 => 6912
  | 3,1 => 6912
  | 3,2 => 5312
  | 3,3 => 2496
  | _,_ => 0
def matrixCert_20 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 33856
  | 0,1 => 33856
  | 0,2 => 26048
  | 0,3 => 12224
  | 1,0 => 26048
  | 1,1 => 26048
  | 1,2 => 20032
  | 1,3 => 9408
  | 2,0 => 33856
  | 2,1 => 33856
  | 2,2 => 26048
  | 2,3 => 12224
  | 3,0 => 12224
  | 3,1 => 12224
  | 3,2 => 9408
  | 3,3 => 4416
  | _,_ => 0
def matrixCert_21 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 59904
  | 0,1 => 59904
  | 0,2 => 46080
  | 0,3 => 21632
  | 1,0 => 46080
  | 1,1 => 46080
  | 1,2 => 35456
  | 1,3 => 16640
  | 2,0 => 59904
  | 2,1 => 59904
  | 2,2 => 46080
  | 2,3 => 21632
  | 3,0 => 21632
  | 3,1 => 21632
  | 3,2 => 16640
  | 3,3 => 7808
  | _,_ => 0
def matrixCert_22 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 105984
  | 0,1 => 105984
  | 0,2 => 81536
  | 0,3 => 38272
  | 1,0 => 81536
  | 1,1 => 81536
  | 1,2 => 62720
  | 1,3 => 29440
  | 2,0 => 105984
  | 2,1 => 105984
  | 2,2 => 81536
  | 2,3 => 38272
  | 3,0 => 38272
  | 3,1 => 38272
  | 3,2 => 29440
  | 3,3 => 13824
  | _,_ => 0
def matrixCert_23 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 187520
  | 0,1 => 187520
  | 0,2 => 144256
  | 0,3 => 67712
  | 1,0 => 144256
  | 1,1 => 144256
  | 1,2 => 110976
  | 1,3 => 52096
  | 2,0 => 187520
  | 2,1 => 187520
  | 2,2 => 144256
  | 2,3 => 67712
  | 3,0 => 67712
  | 3,1 => 67712
  | 3,2 => 52096
  | 3,3 => 24448
  | _,_ => 0
def matrixCert_24 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 331776
  | 0,1 => 331776
  | 0,2 => 255232
  | 0,3 => 119808
  | 1,0 => 255232
  | 1,1 => 255232
  | 1,2 => 196352
  | 1,3 => 92160
  | 2,0 => 331776
  | 2,1 => 331776
  | 2,2 => 255232
  | 2,3 => 119808
  | 3,0 => 119808
  | 3,1 => 119808
  | 3,2 => 92160
  | 3,3 => 43264
  | _,_ => 0
def matrixCert_25 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 587008
  | 0,1 => 587008
  | 0,2 => 451584
  | 0,3 => 211968
  | 1,0 => 451584
  | 1,1 => 451584
  | 1,2 => 347392
  | 1,3 => 163072
  | 2,0 => 587008
  | 2,1 => 587008
  | 2,2 => 451584
  | 2,3 => 211968
  | 3,0 => 211968
  | 3,1 => 211968
  | 3,2 => 163072
  | 3,3 => 76544
  | _,_ => 0
def matrixCert_26 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 1038592
  | 0,1 => 1038592
  | 0,2 => 798976
  | 0,3 => 375040
  | 1,0 => 798976
  | 1,1 => 798976
  | 1,2 => 614656
  | 1,3 => 288512
  | 2,0 => 1038592
  | 2,1 => 1038592
  | 2,2 => 798976
  | 2,3 => 375040
  | 3,0 => 375040
  | 3,1 => 375040
  | 3,2 => 288512
  | 3,3 => 135424
  | _,_ => 0
def matrixCert_27 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 1837568
  | 0,1 => 1837568
  | 0,2 => 1413632
  | 0,3 => 663552
  | 1,0 => 1413632
  | 1,1 => 1413632
  | 1,2 => 1087488
  | 1,3 => 510464
  | 2,0 => 1837568
  | 2,1 => 1837568
  | 2,2 => 1413632
  | 2,3 => 663552
  | 3,0 => 663552
  | 3,1 => 663552
  | 3,2 => 510464
  | 3,3 => 239616
  | _,_ => 0
def matrixCert_28 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 3251200
  | 0,1 => 3251200
  | 0,2 => 2501120
  | 0,3 => 1174016
  | 1,0 => 2501120
  | 1,1 => 2501120
  | 1,2 => 1924096
  | 1,3 => 903168
  | 2,0 => 3251200
  | 2,1 => 3251200
  | 2,2 => 2501120
  | 2,3 => 1174016
  | 3,0 => 1174016
  | 3,1 => 1174016
  | 3,2 => 903168
  | 3,3 => 423936
  | _,_ => 0
def matrixCert_29 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 5752320
  | 0,1 => 5752320
  | 0,2 => 4425216
  | 0,3 => 2077184
  | 1,0 => 4425216
  | 1,1 => 4425216
  | 1,2 => 3404288
  | 1,3 => 1597952
  | 2,0 => 5752320
  | 2,1 => 5752320
  | 2,2 => 4425216
  | 2,3 => 2077184
  | 3,0 => 2077184
  | 3,1 => 2077184
  | 3,2 => 1597952
  | 3,3 => 750080
  | _,_ => 0
def matrixCert_30 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 10177536
  | 0,1 => 10177536
  | 0,2 => 7829504
  | 0,3 => 3675136
  | 1,0 => 7829504
  | 1,1 => 7829504
  | 1,2 => 6023168
  | 1,3 => 2827264
  | 2,0 => 10177536
  | 2,1 => 10177536
  | 2,2 => 7829504
  | 2,3 => 3675136
  | 3,0 => 3675136
  | 3,1 => 3675136
  | 3,2 => 2827264
  | 3,3 => 1327104
  | _,_ => 0
def matrixCert_31 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 18007040
  | 0,1 => 18007040
  | 0,2 => 13852672
  | 0,3 => 6502400
  | 1,0 => 13852672
  | 1,1 => 13852672
  | 1,2 => 10656768
  | 1,3 => 5002240
  | 2,0 => 18007040
  | 2,1 => 18007040
  | 2,2 => 13852672
  | 2,3 => 6502400
  | 3,0 => 6502400
  | 3,1 => 6502400
  | 3,2 => 5002240
  | 3,3 => 2348032
  | _,_ => 0
def matrixCert_32 : Mat4 := fun i j =>
  match i,j with
  | 0,0 => 31859712
  | 0,1 => 31859712
  | 0,2 => 24509440
  | 0,3 => 11504640
  | 1,0 => 24509440
  | 1,1 => 24509440
  | 1,2 => 18854912
  | 1,3 => 8850432
  | 2,0 => 31859712
  | 2,1 => 31859712
  | 2,2 => 24509440
  | 2,3 => 11504640
  | 3,0 => 11504640
  | 3,1 => 11504640
  | 3,2 => 8850432
  | 3,3 => 4154368
  | _,_ => 0
def matrixCert (n : Nat) : Mat4 :=
  match n with
  | 0 => mat4Id
  | 1 => matrixCert_1
  | 2 => matrixCert_2
  | 3 => matrixCert_3
  | 4 => matrixCert_4
  | 5 => matrixCert_5
  | 6 => matrixCert_6
  | 7 => matrixCert_7
  | 8 => matrixCert_8
  | 9 => matrixCert_9
  | 10 => matrixCert_10
  | 11 => matrixCert_11
  | 12 => matrixCert_12
  | 13 => matrixCert_13
  | 14 => matrixCert_14
  | 15 => matrixCert_15
  | 16 => matrixCert_16
  | 17 => matrixCert_17
  | 18 => matrixCert_18
  | 19 => matrixCert_19
  | 20 => matrixCert_20
  | 21 => matrixCert_21
  | 22 => matrixCert_22
  | 23 => matrixCert_23
  | 24 => matrixCert_24
  | 25 => matrixCert_25
  | 26 => matrixCert_26
  | 27 => matrixCert_27
  | 28 => matrixCert_28
  | 29 => matrixCert_29
  | 30 => matrixCert_30
  | 31 => matrixCert_31
  | 32 => matrixCert_32
  | _ => fun _ _ => 0

def MatEq4 (A B : Mat4) : Prop := ∀ i, i < 4 → ∀ j, j < 4 → A i j = B i j

theorem matrix_steps_check : allUpTo 32 (fun n =>
    allUpTo 4 (fun i => allUpTo 4 (fun j =>
      decide (mat4Mul (matrixCert n) M_H32 i j = matrixCert (n+1) i j)))) = true := by
  decide +kernel

theorem matrix_step (n : Nat) (hn : n < 32) :
    MatEq4 (mat4Mul (matrixCert n) M_H32) (matrixCert (n+1)) := by
  intro i hi j hj
  have h := allUpTo_sound 32 _ matrix_steps_check n hn
  have h' := allUpTo_sound 4 _ h i hi
  exact of_decide_eq_true (allUpTo_sound 4 _ h' j hj)

theorem mat4Mul_congr_left (A B C : Mat4) (h : MatEq4 A B) :
    MatEq4 (mat4Mul A C) (mat4Mul B C) := by
  intro i hi j hj
  apply sumInt_congr
  intro k hk
  rw [h i hi k hk]

theorem mat4Pow_certified (n : Nat) (hn : n ≤ 32) :
    MatEq4 (mat4Pow M_H32 n) (matrixCert n) := by
  induction n with
  | zero => intro i hi j hj; rfl
  | succ n ih =>
    intro i hi j hj
    have he := mat4Mul_congr_left _ _ M_H32 (ih (by omega)) i hi j hj
    exact he.trans (matrix_step n (by omega) i hi j hj)

theorem trace_certified (n : Nat) (hn : n ≤ 32) :
    mat4Trace (mat4Pow M_H32 n) = mat4Trace (matrixCert n) := by
  unfold mat4Trace
  have h := mat4Pow_certified n hn
  rw [h 0 (by decide) 0 (by decide), h 1 (by decide) 1 (by decide),
      h 2 (by decide) 2 (by decide), h 3 (by decide) 3 (by decide)]

theorem trace_M_H32_pow32_eq_85032960 :
    mat4Trace (mat4Pow M_H32 32) = 85032960 := by
  rw [trace_certified 32 (by decide)]
  decide +kernel

theorem openWalkSum_eq_mat4Pow (k i j : Nat) :
    openWalkSum k i j = mat4Pow M_H32 k i j := by
  induction k generalizing i j with
  | zero => rfl
  | succ m ih => simp only [openWalkSum, mat4Pow, mat4Mul, sumIntUpTo, ih]

theorem closedCycleWalsh_eq_trace (n : Nat) :
    closedCycleWalsh n = mat4Trace (mat4Pow M_H32 n) := by
  simp only [closedCycleWalsh, mat4Trace, sumIntUpTo, openWalkSum_eq_mat4Pow]
  omega

theorem closedCycleWalsh_32_eq_85032960 : closedCycleWalsh 32 = 85032960 := by
  rw [closedCycleWalsh_eq_trace, trace_M_H32_pow32_eq_85032960]

/-- This equality is a genuine remaining hypothesis, not a proved theorem. -/
def BitWalkBridge (n : Nat) : Prop := walsh n (Hn_explicit n) 0 = closedCycleWalsh n

theorem bitWalkBridge_n6_n8_proved : BitWalkBridge 6 ∧ BitWalkBridge 8 := by
  unfold BitWalkBridge
  rw [closedCycleWalsh_eq_trace, closedCycleWalsh_eq_trace,
      trace_certified 6 (by decide), trace_certified 8 (by decide)]
  decide +kernel

theorem elementary_orbit_H32_barrier_from_bridge (h : BitWalkBridge 32) :
    walsh 32 H32_explicit 0 = 85032960 ∧ ¬ IsBent 32 H32_explicit := by
  have hw : walsh 32 H32_explicit 0 = 85032960 := by
    change walsh 32 (Hn_explicit 32) 0 = 85032960
    rw [h, closedCycleWalsh_32_eq_85032960]
  refine ⟨hw, ?_⟩
  intro hb
  have he := hb 0 (by decide)
  rw [hw] at he
  have hn : ¬ ((85032960 : Int)*85032960 = 2^32) := by decide +kernel
  exact hn he

end HRSBF_Formalizacao_Real

/- ===== Módulo Splitting ===== -/
namespace HRSBF_Formalizacao_Real
set_option maxRecDepth 10000
set_option maxHeartbeats 0
theorem bxor_four_rearrange (a b c d : Bool) :
    bxor (bxor a b) (bxor c d) = bxor (bxor a c) (bxor b d) := by
  cases a <;> cases b <;> cases c <;> cases d <;> rfl

/-- Distributividade à direita da soma finita `sumIntUpTo`:
    `∑_{i=0}^{m-1} (A i * c) = (∑_{i=0}^{m-1} A i) * c`. -/
theorem sumIntUpTo_mul_right (m : Nat) (A : Nat → Int) (c : Int) :
    sumIntUpTo m (fun i => A i * c) = (sumIntUpTo m A) * c := by
  induction m with
  | zero =>
    change (0 : Int) = 0 * c
    omega
  | succ k ih =>
    simp only [sumIntUpTo, ih, Int.add_mul]

/-- Distributividade à esquerda da soma finita `sumIntUpTo`:
    `∑_{j=0}^{n-1} (c * B j) = c * (∑_{j=0}^{n-1} B j)`. -/
theorem sumIntUpTo_mul_left (n : Nat) (c : Int) (B : Nat → Int) :
    sumIntUpTo n (fun j => c * B j) = c * (sumIntUpTo n B) := by
  induction n with
  | zero =>
    change (0 : Int) = c * 0
    omega
  | succ k ih =>
    simp only [sumIntUpTo, ih, Int.mul_add]

/-- **Teorema de Fatoração de Somas Duplas (`sumIntUpTo_product_factor`)**:
    `∑_{i=0}^{m-1} ∑_{j=0}^{n-1} (A i * B j) = (∑_{i=0}^{m-1} A i) * (∑_{j=0}^{n-1} B j)`. -/
theorem sumIntUpTo_product_factor (m n : Nat) (A B : Nat → Int) :
    sumIntUpTo m (fun i => sumIntUpTo n (fun j => A i * B j)) =
    (sumIntUpTo m A) * (sumIntUpTo n B) := by
  have h_inner : (fun i => sumIntUpTo n (fun j => A i * B j)) =
                 (fun i => A i * sumIntUpTo n B) := by
    funext i
    exact sumIntUpTo_mul_left n (A i) B
  rw [h_inner]
  exact sumIntUpTo_mul_right m A (sumIntUpTo n B)

/-- Transformada de Walsh 2D sobre o espaço produto `𝔽₂^r × 𝔽₂^r` de uma função decomposta
    `f(x_E, x_O) = g_E(x_E) ⊕ g_O(x_O)`. -/
def walshSplit2D (r : Nat) (gE gO : Nat → Bool) (uE uO : Nat) : Int :=
  sumIntUpTo (2 ^ r) (fun xE =>
    sumIntUpTo (2 ^ r) (fun xO =>
      signInt (bxor (bxor (gE xE) (gO xO))
                    (bxor (dotParity r xE uE) (dotParity r xO uO)))))

/-- **Teorema Geral da Multiplicatividade de Walsh sob Desacoplamento (`walshSplit2D_eq_mul`)**:
    Para toda dimensão `r`, quaisquer funções `gE, gO : Nat → Bool` e quaisquer frequências `uE, uO`,
    `walshSplit2D r gE gO uE uO = walsh r gE uE * walsh r gO uO`. -/
theorem walshSplit2D_eq_mul (r : Nat) (gE gO : Nat → Bool) (uE uO : Nat) :
    walshSplit2D r gE gO uE uO = walsh r gE uE * walsh r gO uO := by
  unfold walshSplit2D walsh
  have h_term :
      (fun xE => sumIntUpTo (2 ^ r) (fun xO =>
        signInt (bxor (bxor (gE xE) (gO xO))
                      (bxor (dotParity r xE uE) (dotParity r xO uO))))) =
      (fun xE => sumIntUpTo (2 ^ r) (fun xO =>
        signInt (bxor (gE xE) (dotParity r xE uE)) *
        signInt (bxor (gO xO) (dotParity r xO uO)))) := by
    funext xE
    have h_inner :
        (fun xO => signInt (bxor (bxor (gE xE) (gO xO))
                                 (bxor (dotParity r xE uE) (dotParity r xO uO)))) =
        (fun xO => signInt (bxor (gE xE) (dotParity r xE uE)) *
                   signInt (bxor (gO xO) (dotParity r xO uO))) := by
      funext xO
      rw [bxor_four_rearrange (gE xE) (gO xO) (dotParity r xE uE) (dotParity r xO uO)]
      exact signInt_bxor (bxor (gE xE) (dotParity r xE uE)) (bxor (gO xO) (dotParity r xO uO))
    rw [h_inner]
  rw [h_term]
  exact sumIntUpTo_product_factor (2 ^ r) (2 ^ r)
    (fun xE => signInt (bxor (gE xE) (dotParity r xE uE)))
    (fun xO => signInt (bxor (gO xO) (dotParity r xO uO)))

/-- **Fechamento Linear da Decomposição Par/Ímpar sob XOR (`split_xor_closed`)**:
    Se `f₁(x) = g₁(x_E) ⊕ g₁(x_O)` e `f₂(x) = g₂(x_E) ⊕ g₂(x_O)`, então a soma
    `(f₁ ⊕ f₂)(x) = (g₁ ⊕ g₂)(x_E) ⊕ (g₁ ⊕ g₂)(x_O)`. -/
theorem split_xor_closed
    {f1 f2 g1 g2 : Nat → Bool} {x : Nat}
    (h1 : f1 x = bxor (g1 (projEven32 x)) (g1 (projOdd32 x)))
    (h2 : f2 x = bxor (g2 (projEven32 x)) (g2 (projOdd32 x))) :
    bxor (f1 x) (f2 x) =
      bxor (bxor (g1 (projEven32 x)) (g2 (projEven32 x)))
           (bxor (g1 (projOdd32 x)) (g2 (projOdd32 x))) := by
  rw [h1, h2]
  exact bxor_four_rearrange
    (g1 (projEven32 x)) (g1 (projOdd32 x))
    (g2 (projEven32 x)) (g2 (projOdd32 x))

/-- **Decomposição Funcional de uma Órbita Cúbica de Mesma Paridade (`sameParityOrbit32_splits`)**:
    Se uma órbita de 32 variáveis gerada por `(2i, 2j, 2k)` é particionada nos 16 deslocamentos
    pares `s = 2t` e nos 16 deslocamentos ímpares `s = 2t + 1`, e as leituras de bits coincidem com
    `projEven32 x` e `projOdd32 x`, então sua avaliação em `x` é exatamente
    `orbit16 i j k (projEven32 x) ⊕ orbit16 i j k (projOdd32 x)`. -/
theorem sameParityOrbit32_splits (i j k x : Nat)
    (h_even : (fun t =>
                bitAt x ((2 * i + 2 * t) % 32) &&
                bitAt x ((2 * j + 2 * t) % 32) &&
                bitAt x ((2 * k + 2 * t) % 32)) =
              (fun t =>
                bitAt (projEven32 x) ((i + t) % 16) &&
                bitAt (projEven32 x) ((j + t) % 16) &&
                bitAt (projEven32 x) ((k + t) % 16)))
    (h_odd  : (fun t =>
                bitAt x ((2 * i + 2 * t + 1) % 32) &&
                bitAt x ((2 * j + 2 * t + 1) % 32) &&
                bitAt x ((2 * k + 2 * t + 1) % 32)) =
              (fun t =>
                bitAt (projOdd32 x) ((i + t) % 16) &&
                bitAt (projOdd32 x) ((j + t) % 16) &&
                bitAt (projOdd32 x) ((k + t) % 16))) :
    bxor (xorUpTo 16 (fun t =>
            bitAt x ((2 * i + 2 * t) % 32) &&
            bitAt x ((2 * j + 2 * t) % 32) &&
            bitAt x ((2 * k + 2 * t) % 32)))
         (xorUpTo 16 (fun t =>
            bitAt x ((2 * i + 2 * t + 1) % 32) &&
            bitAt x ((2 * j + 2 * t + 1) % 32) &&
            bitAt x ((2 * k + 2 * t + 1) % 32)))
    = bxor (orbit16 i j k (projEven32 x)) (orbit16 i j k (projOdd32 x)) := by
  unfold orbit16
  rw [h_even, h_odd]



end HRSBF_Formalizacao_Real

namespace HRSBF_Formalizacao_Real

theorem f12_is_cubic : IsCubic 12 f12_explicit := by
  refine ⟨f12_has_degree_at_most_3, 69, ?_⟩
  exact ⟨by decide, f12_anf_cubic_and_quad_witnesses.1.1,
    f12_anf_cubic_and_quad_witnesses.1.2⟩

/-- Enunciados pendentes, declarados como Prop, sem termo de prova. -/
def PendingSpec_BitWalkBridge32 : Prop := BitWalkBridge 32

def PendingSpec_WardDivisibility_HomogeneousCubic_N16 : Prop :=
  WardDivisibilityN16Certificate (fun g => IsRotationSymmetric 16 g ∧ IsHomogeneousCubic 16 g)

def PendingSpec_NoHomogeneousCubicRSBent_N16 : Prop :=
  ¬ ∃ g : Nat → Bool, IsRotationSymmetric 16 g ∧ IsHomogeneousCubic 16 g ∧ IsBent 16 g

def PendingSpec_NoHomogeneousCubicRSBent_N32 : Prop :=
  ¬ ∃ f : Nat → Bool, IsRotationSymmetric 32 f ∧ IsHomogeneousCubic 32 f ∧ IsBent 32 f

end HRSBF_Formalizacao_Real

-- Auditoria exaustiva dos teoremas declarados neste arquivo:
#print axioms HRSBF_Formalizacao_Real.band_eq_true_left
#print axioms HRSBF_Formalizacao_Real.band_eq_true_right
#print axioms HRSBF_Formalizacao_Real.allUpTo_sound
#print axioms HRSBF_Formalizacao_Real.diff_of_squares
#print axioms HRSBF_Formalizacao_Real.sq_lt_sq_of_nonneg
#print axioms HRSBF_Formalizacao_Real.neg_sq_eq_sq
#print axioms HRSBF_Formalizacao_Real.walsh_zero_sq_ne_65536_of_dvd_256
#print axioms HRSBF_Formalizacao_Real.not_bent_n16_of_ward_certificate
#print axioms HRSBF_Formalizacao_Real.walsh32_sq_ne_of_walsh16_sq_ne
#print axioms HRSBF_Formalizacao_Real.not_bent_n32_of_parity_decoupling
#print axioms HRSBF_Formalizacao_Real.sumNatUpTo_add
#print axioms HRSBF_Formalizacao_Real.sumIntUpTo_add
#print axioms HRSBF_Formalizacao_Real.bxor_assoc
#print axioms HRSBF_Formalizacao_Real.xorUpTo_add
#print axioms HRSBF_Formalizacao_Real.allUpTo_add
#print axioms HRSBF_Formalizacao_Real.sumNatTree_eq
#print axioms HRSBF_Formalizacao_Real.sumIntTree_eq
#print axioms HRSBF_Formalizacao_Real.xorTree_eq
#print axioms HRSBF_Formalizacao_Real.allTree_eq
#print axioms HRSBF_Formalizacao_Real.sumInt_congr
#print axioms HRSBF_Formalizacao_Real.sumNat_congr
#print axioms HRSBF_Formalizacao_Real.xor_congr
#print axioms HRSBF_Formalizacao_Real.sumInt_add
#print axioms HRSBF_Formalizacao_Real.sumInt_swap
#print axioms HRSBF_Formalizacao_Real.sumInt_blocks
#print axioms HRSBF_Formalizacao_Real.listSumI_append
#print axioms HRSBF_Formalizacao_Real.listSumI_perm
#print axioms HRSBF_Formalizacao_Real.sumInt_list
#print axioms HRSBF_Formalizacao_Real.sumInt_reindex
#print axioms HRSBF_Formalizacao_Real.bitAt_testBit
#print axioms HRSBF_Formalizacao_Real.bitAt_xor
#print axioms HRSBF_Formalizacao_Real.dotParity_xor_right
#print axioms HRSBF_Formalizacao_Real.dotParity_comm
#print axioms HRSBF_Formalizacao_Real.bitAt_join_low
#print axioms HRSBF_Formalizacao_Real.bitAt_join_high
#print axioms HRSBF_Formalizacao_Real.dotParity_join
#print axioms HRSBF_Formalizacao_Real.dotParity_xor_left
#print axioms HRSBF_Formalizacao_Real.sumInt_mul_right
#print axioms HRSBF_Formalizacao_Real.signInt_bxor
#print axioms HRSBF_Formalizacao_Real.character_five
#print axioms HRSBF_Formalizacao_Real.bxor_zero_right
#print axioms HRSBF_Formalizacao_Real.bxor_zero_left
#print axioms HRSBF_Formalizacao_Real.subset_even
#print axioms HRSBF_Formalizacao_Real.subset_odd
#print axioms HRSBF_Formalizacao_Real.xor_even_odd
#print axioms HRSBF_Formalizacao_Real.xor_bxor
#print axioms HRSBF_Formalizacao_Real.xor_false
#print axioms HRSBF_Formalizacao_Real.anfCoeffDirect_eq
#print axioms HRSBF_Formalizacao_Real.anfCoeff_congr
#print axioms HRSBF_Formalizacao_Real.truth_check_0
#print axioms HRSBF_Formalizacao_Real.truth_check_1
#print axioms HRSBF_Formalizacao_Real.truth_check_2
#print axioms HRSBF_Formalizacao_Real.truth_check_3
#print axioms HRSBF_Formalizacao_Real.truth_check_4
#print axioms HRSBF_Formalizacao_Real.truth_check_5
#print axioms HRSBF_Formalizacao_Real.truth_check_6
#print axioms HRSBF_Formalizacao_Real.truth_check_7
#print axioms HRSBF_Formalizacao_Real.truth_check_8
#print axioms HRSBF_Formalizacao_Real.truth_check_9
#print axioms HRSBF_Formalizacao_Real.truth_check_10
#print axioms HRSBF_Formalizacao_Real.truth_check_11
#print axioms HRSBF_Formalizacao_Real.truth_check_12
#print axioms HRSBF_Formalizacao_Real.truth_check_13
#print axioms HRSBF_Formalizacao_Real.truth_check_14
#print axioms HRSBF_Formalizacao_Real.truth_check_15
#print axioms HRSBF_Formalizacao_Real.truth_check_16
#print axioms HRSBF_Formalizacao_Real.truth_check_17
#print axioms HRSBF_Formalizacao_Real.truth_check_18
#print axioms HRSBF_Formalizacao_Real.truth_check_19
#print axioms HRSBF_Formalizacao_Real.truth_check_20
#print axioms HRSBF_Formalizacao_Real.truth_check_21
#print axioms HRSBF_Formalizacao_Real.truth_check_22
#print axioms HRSBF_Formalizacao_Real.truth_check_23
#print axioms HRSBF_Formalizacao_Real.truth_check_24
#print axioms HRSBF_Formalizacao_Real.truth_check_25
#print axioms HRSBF_Formalizacao_Real.truth_check_26
#print axioms HRSBF_Formalizacao_Real.truth_check_27
#print axioms HRSBF_Formalizacao_Real.truth_check_28
#print axioms HRSBF_Formalizacao_Real.truth_check_29
#print axioms HRSBF_Formalizacao_Real.truth_check_30
#print axioms HRSBF_Formalizacao_Real.truth_check_31
#print axioms HRSBF_Formalizacao_Real.truth_check_32
#print axioms HRSBF_Formalizacao_Real.truth_check_33
#print axioms HRSBF_Formalizacao_Real.truth_check_34
#print axioms HRSBF_Formalizacao_Real.truth_check_35
#print axioms HRSBF_Formalizacao_Real.truth_check_36
#print axioms HRSBF_Formalizacao_Real.truth_check_37
#print axioms HRSBF_Formalizacao_Real.truth_check_38
#print axioms HRSBF_Formalizacao_Real.truth_check_39
#print axioms HRSBF_Formalizacao_Real.truth_check_40
#print axioms HRSBF_Formalizacao_Real.truth_check_41
#print axioms HRSBF_Formalizacao_Real.truth_check_42
#print axioms HRSBF_Formalizacao_Real.truth_check_43
#print axioms HRSBF_Formalizacao_Real.truth_check_44
#print axioms HRSBF_Formalizacao_Real.truth_check_45
#print axioms HRSBF_Formalizacao_Real.truth_check_46
#print axioms HRSBF_Formalizacao_Real.truth_check_47
#print axioms HRSBF_Formalizacao_Real.truth_check_48
#print axioms HRSBF_Formalizacao_Real.truth_check_49
#print axioms HRSBF_Formalizacao_Real.truth_check_50
#print axioms HRSBF_Formalizacao_Real.truth_check_51
#print axioms HRSBF_Formalizacao_Real.truth_check_52
#print axioms HRSBF_Formalizacao_Real.truth_check_53
#print axioms HRSBF_Formalizacao_Real.truth_check_54
#print axioms HRSBF_Formalizacao_Real.truth_check_55
#print axioms HRSBF_Formalizacao_Real.truth_check_56
#print axioms HRSBF_Formalizacao_Real.truth_check_57
#print axioms HRSBF_Formalizacao_Real.truth_check_58
#print axioms HRSBF_Formalizacao_Real.truth_check_59
#print axioms HRSBF_Formalizacao_Real.truth_check_60
#print axioms HRSBF_Formalizacao_Real.truth_check_61
#print axioms HRSBF_Formalizacao_Real.truth_check_62
#print axioms HRSBF_Formalizacao_Real.truth_check_63
#print axioms HRSBF_Formalizacao_Real.degree_check_0
#print axioms HRSBF_Formalizacao_Real.mm_check_0
#print axioms HRSBF_Formalizacao_Real.rot_check_0
#print axioms HRSBF_Formalizacao_Real.spectrum_check_0
#print axioms HRSBF_Formalizacao_Real.degree_check_1
#print axioms HRSBF_Formalizacao_Real.mm_check_1
#print axioms HRSBF_Formalizacao_Real.rot_check_1
#print axioms HRSBF_Formalizacao_Real.spectrum_check_1
#print axioms HRSBF_Formalizacao_Real.degree_check_2
#print axioms HRSBF_Formalizacao_Real.mm_check_2
#print axioms HRSBF_Formalizacao_Real.rot_check_2
#print axioms HRSBF_Formalizacao_Real.spectrum_check_2
#print axioms HRSBF_Formalizacao_Real.degree_check_3
#print axioms HRSBF_Formalizacao_Real.mm_check_3
#print axioms HRSBF_Formalizacao_Real.rot_check_3
#print axioms HRSBF_Formalizacao_Real.spectrum_check_3
#print axioms HRSBF_Formalizacao_Real.degree_check_4
#print axioms HRSBF_Formalizacao_Real.mm_check_4
#print axioms HRSBF_Formalizacao_Real.rot_check_4
#print axioms HRSBF_Formalizacao_Real.spectrum_check_4
#print axioms HRSBF_Formalizacao_Real.degree_check_5
#print axioms HRSBF_Formalizacao_Real.mm_check_5
#print axioms HRSBF_Formalizacao_Real.rot_check_5
#print axioms HRSBF_Formalizacao_Real.spectrum_check_5
#print axioms HRSBF_Formalizacao_Real.degree_check_6
#print axioms HRSBF_Formalizacao_Real.mm_check_6
#print axioms HRSBF_Formalizacao_Real.rot_check_6
#print axioms HRSBF_Formalizacao_Real.spectrum_check_6
#print axioms HRSBF_Formalizacao_Real.degree_check_7
#print axioms HRSBF_Formalizacao_Real.mm_check_7
#print axioms HRSBF_Formalizacao_Real.rot_check_7
#print axioms HRSBF_Formalizacao_Real.spectrum_check_7
#print axioms HRSBF_Formalizacao_Real.degree_check_8
#print axioms HRSBF_Formalizacao_Real.mm_check_8
#print axioms HRSBF_Formalizacao_Real.rot_check_8
#print axioms HRSBF_Formalizacao_Real.spectrum_check_8
#print axioms HRSBF_Formalizacao_Real.degree_check_9
#print axioms HRSBF_Formalizacao_Real.mm_check_9
#print axioms HRSBF_Formalizacao_Real.rot_check_9
#print axioms HRSBF_Formalizacao_Real.spectrum_check_9
#print axioms HRSBF_Formalizacao_Real.degree_check_10
#print axioms HRSBF_Formalizacao_Real.mm_check_10
#print axioms HRSBF_Formalizacao_Real.rot_check_10
#print axioms HRSBF_Formalizacao_Real.spectrum_check_10
#print axioms HRSBF_Formalizacao_Real.degree_check_11
#print axioms HRSBF_Formalizacao_Real.mm_check_11
#print axioms HRSBF_Formalizacao_Real.rot_check_11
#print axioms HRSBF_Formalizacao_Real.spectrum_check_11
#print axioms HRSBF_Formalizacao_Real.degree_check_12
#print axioms HRSBF_Formalizacao_Real.mm_check_12
#print axioms HRSBF_Formalizacao_Real.rot_check_12
#print axioms HRSBF_Formalizacao_Real.spectrum_check_12
#print axioms HRSBF_Formalizacao_Real.degree_check_13
#print axioms HRSBF_Formalizacao_Real.mm_check_13
#print axioms HRSBF_Formalizacao_Real.rot_check_13
#print axioms HRSBF_Formalizacao_Real.spectrum_check_13
#print axioms HRSBF_Formalizacao_Real.degree_check_14
#print axioms HRSBF_Formalizacao_Real.mm_check_14
#print axioms HRSBF_Formalizacao_Real.rot_check_14
#print axioms HRSBF_Formalizacao_Real.spectrum_check_14
#print axioms HRSBF_Formalizacao_Real.degree_check_15
#print axioms HRSBF_Formalizacao_Real.mm_check_15
#print axioms HRSBF_Formalizacao_Real.rot_check_15
#print axioms HRSBF_Formalizacao_Real.spectrum_check_15
#print axioms HRSBF_Formalizacao_Real.degree_check_16
#print axioms HRSBF_Formalizacao_Real.mm_check_16
#print axioms HRSBF_Formalizacao_Real.rot_check_16
#print axioms HRSBF_Formalizacao_Real.spectrum_check_16
#print axioms HRSBF_Formalizacao_Real.degree_check_17
#print axioms HRSBF_Formalizacao_Real.mm_check_17
#print axioms HRSBF_Formalizacao_Real.rot_check_17
#print axioms HRSBF_Formalizacao_Real.spectrum_check_17
#print axioms HRSBF_Formalizacao_Real.degree_check_18
#print axioms HRSBF_Formalizacao_Real.mm_check_18
#print axioms HRSBF_Formalizacao_Real.rot_check_18
#print axioms HRSBF_Formalizacao_Real.spectrum_check_18
#print axioms HRSBF_Formalizacao_Real.degree_check_19
#print axioms HRSBF_Formalizacao_Real.mm_check_19
#print axioms HRSBF_Formalizacao_Real.rot_check_19
#print axioms HRSBF_Formalizacao_Real.spectrum_check_19
#print axioms HRSBF_Formalizacao_Real.degree_check_20
#print axioms HRSBF_Formalizacao_Real.mm_check_20
#print axioms HRSBF_Formalizacao_Real.rot_check_20
#print axioms HRSBF_Formalizacao_Real.spectrum_check_20
#print axioms HRSBF_Formalizacao_Real.degree_check_21
#print axioms HRSBF_Formalizacao_Real.mm_check_21
#print axioms HRSBF_Formalizacao_Real.rot_check_21
#print axioms HRSBF_Formalizacao_Real.spectrum_check_21
#print axioms HRSBF_Formalizacao_Real.degree_check_22
#print axioms HRSBF_Formalizacao_Real.mm_check_22
#print axioms HRSBF_Formalizacao_Real.rot_check_22
#print axioms HRSBF_Formalizacao_Real.spectrum_check_22
#print axioms HRSBF_Formalizacao_Real.degree_check_23
#print axioms HRSBF_Formalizacao_Real.mm_check_23
#print axioms HRSBF_Formalizacao_Real.rot_check_23
#print axioms HRSBF_Formalizacao_Real.spectrum_check_23
#print axioms HRSBF_Formalizacao_Real.degree_check_24
#print axioms HRSBF_Formalizacao_Real.mm_check_24
#print axioms HRSBF_Formalizacao_Real.rot_check_24
#print axioms HRSBF_Formalizacao_Real.spectrum_check_24
#print axioms HRSBF_Formalizacao_Real.degree_check_25
#print axioms HRSBF_Formalizacao_Real.mm_check_25
#print axioms HRSBF_Formalizacao_Real.rot_check_25
#print axioms HRSBF_Formalizacao_Real.spectrum_check_25
#print axioms HRSBF_Formalizacao_Real.degree_check_26
#print axioms HRSBF_Formalizacao_Real.mm_check_26
#print axioms HRSBF_Formalizacao_Real.rot_check_26
#print axioms HRSBF_Formalizacao_Real.spectrum_check_26
#print axioms HRSBF_Formalizacao_Real.degree_check_27
#print axioms HRSBF_Formalizacao_Real.mm_check_27
#print axioms HRSBF_Formalizacao_Real.rot_check_27
#print axioms HRSBF_Formalizacao_Real.spectrum_check_27
#print axioms HRSBF_Formalizacao_Real.degree_check_28
#print axioms HRSBF_Formalizacao_Real.mm_check_28
#print axioms HRSBF_Formalizacao_Real.rot_check_28
#print axioms HRSBF_Formalizacao_Real.spectrum_check_28
#print axioms HRSBF_Formalizacao_Real.degree_check_29
#print axioms HRSBF_Formalizacao_Real.mm_check_29
#print axioms HRSBF_Formalizacao_Real.rot_check_29
#print axioms HRSBF_Formalizacao_Real.spectrum_check_29
#print axioms HRSBF_Formalizacao_Real.degree_check_30
#print axioms HRSBF_Formalizacao_Real.mm_check_30
#print axioms HRSBF_Formalizacao_Real.rot_check_30
#print axioms HRSBF_Formalizacao_Real.spectrum_check_30
#print axioms HRSBF_Formalizacao_Real.degree_check_31
#print axioms HRSBF_Formalizacao_Real.mm_check_31
#print axioms HRSBF_Formalizacao_Real.rot_check_31
#print axioms HRSBF_Formalizacao_Real.spectrum_check_31
#print axioms HRSBF_Formalizacao_Real.degree_check_32
#print axioms HRSBF_Formalizacao_Real.mm_check_32
#print axioms HRSBF_Formalizacao_Real.rot_check_32
#print axioms HRSBF_Formalizacao_Real.spectrum_check_32
#print axioms HRSBF_Formalizacao_Real.degree_check_33
#print axioms HRSBF_Formalizacao_Real.mm_check_33
#print axioms HRSBF_Formalizacao_Real.rot_check_33
#print axioms HRSBF_Formalizacao_Real.spectrum_check_33
#print axioms HRSBF_Formalizacao_Real.degree_check_34
#print axioms HRSBF_Formalizacao_Real.mm_check_34
#print axioms HRSBF_Formalizacao_Real.rot_check_34
#print axioms HRSBF_Formalizacao_Real.spectrum_check_34
#print axioms HRSBF_Formalizacao_Real.degree_check_35
#print axioms HRSBF_Formalizacao_Real.mm_check_35
#print axioms HRSBF_Formalizacao_Real.rot_check_35
#print axioms HRSBF_Formalizacao_Real.spectrum_check_35
#print axioms HRSBF_Formalizacao_Real.degree_check_36
#print axioms HRSBF_Formalizacao_Real.mm_check_36
#print axioms HRSBF_Formalizacao_Real.rot_check_36
#print axioms HRSBF_Formalizacao_Real.spectrum_check_36
#print axioms HRSBF_Formalizacao_Real.degree_check_37
#print axioms HRSBF_Formalizacao_Real.mm_check_37
#print axioms HRSBF_Formalizacao_Real.rot_check_37
#print axioms HRSBF_Formalizacao_Real.spectrum_check_37
#print axioms HRSBF_Formalizacao_Real.degree_check_38
#print axioms HRSBF_Formalizacao_Real.mm_check_38
#print axioms HRSBF_Formalizacao_Real.rot_check_38
#print axioms HRSBF_Formalizacao_Real.spectrum_check_38
#print axioms HRSBF_Formalizacao_Real.degree_check_39
#print axioms HRSBF_Formalizacao_Real.mm_check_39
#print axioms HRSBF_Formalizacao_Real.rot_check_39
#print axioms HRSBF_Formalizacao_Real.spectrum_check_39
#print axioms HRSBF_Formalizacao_Real.degree_check_40
#print axioms HRSBF_Formalizacao_Real.mm_check_40
#print axioms HRSBF_Formalizacao_Real.rot_check_40
#print axioms HRSBF_Formalizacao_Real.spectrum_check_40
#print axioms HRSBF_Formalizacao_Real.degree_check_41
#print axioms HRSBF_Formalizacao_Real.mm_check_41
#print axioms HRSBF_Formalizacao_Real.rot_check_41
#print axioms HRSBF_Formalizacao_Real.spectrum_check_41
#print axioms HRSBF_Formalizacao_Real.degree_check_42
#print axioms HRSBF_Formalizacao_Real.mm_check_42
#print axioms HRSBF_Formalizacao_Real.rot_check_42
#print axioms HRSBF_Formalizacao_Real.spectrum_check_42
#print axioms HRSBF_Formalizacao_Real.degree_check_43
#print axioms HRSBF_Formalizacao_Real.mm_check_43
#print axioms HRSBF_Formalizacao_Real.rot_check_43
#print axioms HRSBF_Formalizacao_Real.spectrum_check_43
#print axioms HRSBF_Formalizacao_Real.degree_check_44
#print axioms HRSBF_Formalizacao_Real.mm_check_44
#print axioms HRSBF_Formalizacao_Real.rot_check_44
#print axioms HRSBF_Formalizacao_Real.spectrum_check_44
#print axioms HRSBF_Formalizacao_Real.degree_check_45
#print axioms HRSBF_Formalizacao_Real.mm_check_45
#print axioms HRSBF_Formalizacao_Real.rot_check_45
#print axioms HRSBF_Formalizacao_Real.spectrum_check_45
#print axioms HRSBF_Formalizacao_Real.degree_check_46
#print axioms HRSBF_Formalizacao_Real.mm_check_46
#print axioms HRSBF_Formalizacao_Real.rot_check_46
#print axioms HRSBF_Formalizacao_Real.spectrum_check_46
#print axioms HRSBF_Formalizacao_Real.degree_check_47
#print axioms HRSBF_Formalizacao_Real.mm_check_47
#print axioms HRSBF_Formalizacao_Real.rot_check_47
#print axioms HRSBF_Formalizacao_Real.spectrum_check_47
#print axioms HRSBF_Formalizacao_Real.degree_check_48
#print axioms HRSBF_Formalizacao_Real.mm_check_48
#print axioms HRSBF_Formalizacao_Real.rot_check_48
#print axioms HRSBF_Formalizacao_Real.spectrum_check_48
#print axioms HRSBF_Formalizacao_Real.degree_check_49
#print axioms HRSBF_Formalizacao_Real.mm_check_49
#print axioms HRSBF_Formalizacao_Real.rot_check_49
#print axioms HRSBF_Formalizacao_Real.spectrum_check_49
#print axioms HRSBF_Formalizacao_Real.degree_check_50
#print axioms HRSBF_Formalizacao_Real.mm_check_50
#print axioms HRSBF_Formalizacao_Real.rot_check_50
#print axioms HRSBF_Formalizacao_Real.spectrum_check_50
#print axioms HRSBF_Formalizacao_Real.degree_check_51
#print axioms HRSBF_Formalizacao_Real.mm_check_51
#print axioms HRSBF_Formalizacao_Real.rot_check_51
#print axioms HRSBF_Formalizacao_Real.spectrum_check_51
#print axioms HRSBF_Formalizacao_Real.degree_check_52
#print axioms HRSBF_Formalizacao_Real.mm_check_52
#print axioms HRSBF_Formalizacao_Real.rot_check_52
#print axioms HRSBF_Formalizacao_Real.spectrum_check_52
#print axioms HRSBF_Formalizacao_Real.degree_check_53
#print axioms HRSBF_Formalizacao_Real.mm_check_53
#print axioms HRSBF_Formalizacao_Real.rot_check_53
#print axioms HRSBF_Formalizacao_Real.spectrum_check_53
#print axioms HRSBF_Formalizacao_Real.degree_check_54
#print axioms HRSBF_Formalizacao_Real.mm_check_54
#print axioms HRSBF_Formalizacao_Real.rot_check_54
#print axioms HRSBF_Formalizacao_Real.spectrum_check_54
#print axioms HRSBF_Formalizacao_Real.degree_check_55
#print axioms HRSBF_Formalizacao_Real.mm_check_55
#print axioms HRSBF_Formalizacao_Real.rot_check_55
#print axioms HRSBF_Formalizacao_Real.spectrum_check_55
#print axioms HRSBF_Formalizacao_Real.degree_check_56
#print axioms HRSBF_Formalizacao_Real.mm_check_56
#print axioms HRSBF_Formalizacao_Real.rot_check_56
#print axioms HRSBF_Formalizacao_Real.spectrum_check_56
#print axioms HRSBF_Formalizacao_Real.degree_check_57
#print axioms HRSBF_Formalizacao_Real.mm_check_57
#print axioms HRSBF_Formalizacao_Real.rot_check_57
#print axioms HRSBF_Formalizacao_Real.spectrum_check_57
#print axioms HRSBF_Formalizacao_Real.degree_check_58
#print axioms HRSBF_Formalizacao_Real.mm_check_58
#print axioms HRSBF_Formalizacao_Real.rot_check_58
#print axioms HRSBF_Formalizacao_Real.spectrum_check_58
#print axioms HRSBF_Formalizacao_Real.degree_check_59
#print axioms HRSBF_Formalizacao_Real.mm_check_59
#print axioms HRSBF_Formalizacao_Real.rot_check_59
#print axioms HRSBF_Formalizacao_Real.spectrum_check_59
#print axioms HRSBF_Formalizacao_Real.degree_check_60
#print axioms HRSBF_Formalizacao_Real.mm_check_60
#print axioms HRSBF_Formalizacao_Real.rot_check_60
#print axioms HRSBF_Formalizacao_Real.spectrum_check_60
#print axioms HRSBF_Formalizacao_Real.degree_check_61
#print axioms HRSBF_Formalizacao_Real.mm_check_61
#print axioms HRSBF_Formalizacao_Real.rot_check_61
#print axioms HRSBF_Formalizacao_Real.spectrum_check_61
#print axioms HRSBF_Formalizacao_Real.degree_check_62
#print axioms HRSBF_Formalizacao_Real.mm_check_62
#print axioms HRSBF_Formalizacao_Real.rot_check_62
#print axioms HRSBF_Formalizacao_Real.spectrum_check_62
#print axioms HRSBF_Formalizacao_Real.degree_check_63
#print axioms HRSBF_Formalizacao_Real.mm_check_63
#print axioms HRSBF_Formalizacao_Real.rot_check_63
#print axioms HRSBF_Formalizacao_Real.spectrum_check_63
#print axioms HRSBF_Formalizacao_Real.xor_perm_0
#print axioms HRSBF_Formalizacao_Real.orth_0
#print axioms HRSBF_Formalizacao_Real.xor_perm_1
#print axioms HRSBF_Formalizacao_Real.orth_1
#print axioms HRSBF_Formalizacao_Real.xor_perm_2
#print axioms HRSBF_Formalizacao_Real.orth_2
#print axioms HRSBF_Formalizacao_Real.xor_perm_3
#print axioms HRSBF_Formalizacao_Real.orth_3
#print axioms HRSBF_Formalizacao_Real.xor_perm_4
#print axioms HRSBF_Formalizacao_Real.orth_4
#print axioms HRSBF_Formalizacao_Real.xor_perm_5
#print axioms HRSBF_Formalizacao_Real.orth_5
#print axioms HRSBF_Formalizacao_Real.xor_perm_6
#print axioms HRSBF_Formalizacao_Real.orth_6
#print axioms HRSBF_Formalizacao_Real.xor_perm_7
#print axioms HRSBF_Formalizacao_Real.orth_7
#print axioms HRSBF_Formalizacao_Real.xor_perm_8
#print axioms HRSBF_Formalizacao_Real.orth_8
#print axioms HRSBF_Formalizacao_Real.xor_perm_9
#print axioms HRSBF_Formalizacao_Real.orth_9
#print axioms HRSBF_Formalizacao_Real.xor_perm_10
#print axioms HRSBF_Formalizacao_Real.orth_10
#print axioms HRSBF_Formalizacao_Real.xor_perm_11
#print axioms HRSBF_Formalizacao_Real.orth_11
#print axioms HRSBF_Formalizacao_Real.xor_perm_12
#print axioms HRSBF_Formalizacao_Real.orth_12
#print axioms HRSBF_Formalizacao_Real.xor_perm_13
#print axioms HRSBF_Formalizacao_Real.orth_13
#print axioms HRSBF_Formalizacao_Real.xor_perm_14
#print axioms HRSBF_Formalizacao_Real.orth_14
#print axioms HRSBF_Formalizacao_Real.xor_perm_15
#print axioms HRSBF_Formalizacao_Real.orth_15
#print axioms HRSBF_Formalizacao_Real.xor_perm_16
#print axioms HRSBF_Formalizacao_Real.orth_16
#print axioms HRSBF_Formalizacao_Real.xor_perm_17
#print axioms HRSBF_Formalizacao_Real.orth_17
#print axioms HRSBF_Formalizacao_Real.xor_perm_18
#print axioms HRSBF_Formalizacao_Real.orth_18
#print axioms HRSBF_Formalizacao_Real.xor_perm_19
#print axioms HRSBF_Formalizacao_Real.orth_19
#print axioms HRSBF_Formalizacao_Real.xor_perm_20
#print axioms HRSBF_Formalizacao_Real.orth_20
#print axioms HRSBF_Formalizacao_Real.xor_perm_21
#print axioms HRSBF_Formalizacao_Real.orth_21
#print axioms HRSBF_Formalizacao_Real.xor_perm_22
#print axioms HRSBF_Formalizacao_Real.orth_22
#print axioms HRSBF_Formalizacao_Real.xor_perm_23
#print axioms HRSBF_Formalizacao_Real.orth_23
#print axioms HRSBF_Formalizacao_Real.xor_perm_24
#print axioms HRSBF_Formalizacao_Real.orth_24
#print axioms HRSBF_Formalizacao_Real.xor_perm_25
#print axioms HRSBF_Formalizacao_Real.orth_25
#print axioms HRSBF_Formalizacao_Real.xor_perm_26
#print axioms HRSBF_Formalizacao_Real.orth_26
#print axioms HRSBF_Formalizacao_Real.xor_perm_27
#print axioms HRSBF_Formalizacao_Real.orth_27
#print axioms HRSBF_Formalizacao_Real.xor_perm_28
#print axioms HRSBF_Formalizacao_Real.orth_28
#print axioms HRSBF_Formalizacao_Real.xor_perm_29
#print axioms HRSBF_Formalizacao_Real.orth_29
#print axioms HRSBF_Formalizacao_Real.xor_perm_30
#print axioms HRSBF_Formalizacao_Real.orth_30
#print axioms HRSBF_Formalizacao_Real.xor_perm_31
#print axioms HRSBF_Formalizacao_Real.orth_31
#print axioms HRSBF_Formalizacao_Real.xor_perm_32
#print axioms HRSBF_Formalizacao_Real.orth_32
#print axioms HRSBF_Formalizacao_Real.xor_perm_33
#print axioms HRSBF_Formalizacao_Real.orth_33
#print axioms HRSBF_Formalizacao_Real.xor_perm_34
#print axioms HRSBF_Formalizacao_Real.orth_34
#print axioms HRSBF_Formalizacao_Real.xor_perm_35
#print axioms HRSBF_Formalizacao_Real.orth_35
#print axioms HRSBF_Formalizacao_Real.xor_perm_36
#print axioms HRSBF_Formalizacao_Real.orth_36
#print axioms HRSBF_Formalizacao_Real.xor_perm_37
#print axioms HRSBF_Formalizacao_Real.orth_37
#print axioms HRSBF_Formalizacao_Real.xor_perm_38
#print axioms HRSBF_Formalizacao_Real.orth_38
#print axioms HRSBF_Formalizacao_Real.xor_perm_39
#print axioms HRSBF_Formalizacao_Real.orth_39
#print axioms HRSBF_Formalizacao_Real.xor_perm_40
#print axioms HRSBF_Formalizacao_Real.orth_40
#print axioms HRSBF_Formalizacao_Real.xor_perm_41
#print axioms HRSBF_Formalizacao_Real.orth_41
#print axioms HRSBF_Formalizacao_Real.xor_perm_42
#print axioms HRSBF_Formalizacao_Real.orth_42
#print axioms HRSBF_Formalizacao_Real.xor_perm_43
#print axioms HRSBF_Formalizacao_Real.orth_43
#print axioms HRSBF_Formalizacao_Real.xor_perm_44
#print axioms HRSBF_Formalizacao_Real.orth_44
#print axioms HRSBF_Formalizacao_Real.xor_perm_45
#print axioms HRSBF_Formalizacao_Real.orth_45
#print axioms HRSBF_Formalizacao_Real.xor_perm_46
#print axioms HRSBF_Formalizacao_Real.orth_46
#print axioms HRSBF_Formalizacao_Real.xor_perm_47
#print axioms HRSBF_Formalizacao_Real.orth_47
#print axioms HRSBF_Formalizacao_Real.xor_perm_48
#print axioms HRSBF_Formalizacao_Real.orth_48
#print axioms HRSBF_Formalizacao_Real.xor_perm_49
#print axioms HRSBF_Formalizacao_Real.orth_49
#print axioms HRSBF_Formalizacao_Real.xor_perm_50
#print axioms HRSBF_Formalizacao_Real.orth_50
#print axioms HRSBF_Formalizacao_Real.xor_perm_51
#print axioms HRSBF_Formalizacao_Real.orth_51
#print axioms HRSBF_Formalizacao_Real.xor_perm_52
#print axioms HRSBF_Formalizacao_Real.orth_52
#print axioms HRSBF_Formalizacao_Real.xor_perm_53
#print axioms HRSBF_Formalizacao_Real.orth_53
#print axioms HRSBF_Formalizacao_Real.xor_perm_54
#print axioms HRSBF_Formalizacao_Real.orth_54
#print axioms HRSBF_Formalizacao_Real.xor_perm_55
#print axioms HRSBF_Formalizacao_Real.orth_55
#print axioms HRSBF_Formalizacao_Real.xor_perm_56
#print axioms HRSBF_Formalizacao_Real.orth_56
#print axioms HRSBF_Formalizacao_Real.xor_perm_57
#print axioms HRSBF_Formalizacao_Real.orth_57
#print axioms HRSBF_Formalizacao_Real.xor_perm_58
#print axioms HRSBF_Formalizacao_Real.orth_58
#print axioms HRSBF_Formalizacao_Real.xor_perm_59
#print axioms HRSBF_Formalizacao_Real.orth_59
#print axioms HRSBF_Formalizacao_Real.xor_perm_60
#print axioms HRSBF_Formalizacao_Real.orth_60
#print axioms HRSBF_Formalizacao_Real.xor_perm_61
#print axioms HRSBF_Formalizacao_Real.orth_61
#print axioms HRSBF_Formalizacao_Real.xor_perm_62
#print axioms HRSBF_Formalizacao_Real.orth_62
#print axioms HRSBF_Formalizacao_Real.xor_perm_63
#print axioms HRSBF_Formalizacao_Real.orth_63
#print axioms HRSBF_Formalizacao_Real.pi6_bound_check
#print axioms HRSBF_Formalizacao_Real.truthBlock
#print axioms HRSBF_Formalizacao_Real.degreeBlock
#print axioms HRSBF_Formalizacao_Real.mmBlock
#print axioms HRSBF_Formalizacao_Real.rotBlock
#print axioms HRSBF_Formalizacao_Real.spectrumBlock
#print axioms HRSBF_Formalizacao_Real.xorPerm
#print axioms HRSBF_Formalizacao_Real.orthogonal6
#print axioms HRSBF_Formalizacao_Real.f12_eq_truth
#print axioms HRSBF_Formalizacao_Real.pi6_bound
#print axioms HRSBF_Formalizacao_Real.f12_mm_identity
#print axioms HRSBF_Formalizacao_Real.f12_has_degree_at_most_3
#print axioms HRSBF_Formalizacao_Real.f12_walsh_mm_sq_proved
#print axioms HRSBF_Formalizacao_Real.sumNat_le
#print axioms HRSBF_Formalizacao_Real.rotShift12_bound
#print axioms HRSBF_Formalizacao_Real.f12_is_rotation_symmetric
#print axioms HRSBF_Formalizacao_Real.f12_hamming_weight_eq_2080
#print axioms HRSBF_Formalizacao_Real.f12_anf_cubic_and_quad_witnesses
#print axioms HRSBF_Formalizacao_Real.f12_not_homogeneous_cubic
#print axioms HRSBF_Formalizacao_Real.mm_character
#print axioms HRSBF_Formalizacao_Real.xor_ne_zero_of_ne
#print axioms HRSBF_Formalizacao_Real.mm_inner
#print axioms HRSBF_Formalizacao_Real.walsh12_join
#print axioms HRSBF_Formalizacao_Real.walshMM12_join
#print axioms HRSBF_Formalizacao_Real.walsh12_eq_walshMM12
#print axioms HRSBF_Formalizacao_Real.f12_is_bent
#print axioms HRSBF_Formalizacao_Real.counterexample_n12_certificate_proved
#print axioms HRSBF_Formalizacao_Real.matrix_steps_check
#print axioms HRSBF_Formalizacao_Real.matrix_step
#print axioms HRSBF_Formalizacao_Real.mat4Mul_congr_left
#print axioms HRSBF_Formalizacao_Real.mat4Pow_certified
#print axioms HRSBF_Formalizacao_Real.trace_certified
#print axioms HRSBF_Formalizacao_Real.trace_M_H32_pow32_eq_85032960
#print axioms HRSBF_Formalizacao_Real.openWalkSum_eq_mat4Pow
#print axioms HRSBF_Formalizacao_Real.closedCycleWalsh_eq_trace
#print axioms HRSBF_Formalizacao_Real.closedCycleWalsh_32_eq_85032960
#print axioms HRSBF_Formalizacao_Real.bitWalkBridge_n6_n8_proved
#print axioms HRSBF_Formalizacao_Real.elementary_orbit_H32_barrier_from_bridge
#print axioms HRSBF_Formalizacao_Real.bxor_four_rearrange
#print axioms HRSBF_Formalizacao_Real.sumIntUpTo_mul_right
#print axioms HRSBF_Formalizacao_Real.sumIntUpTo_mul_left
#print axioms HRSBF_Formalizacao_Real.sumIntUpTo_product_factor
#print axioms HRSBF_Formalizacao_Real.walshSplit2D_eq_mul
#print axioms HRSBF_Formalizacao_Real.split_xor_closed
#print axioms HRSBF_Formalizacao_Real.sameParityOrbit32_splits
#print axioms HRSBF_Formalizacao_Real.f12_is_cubic

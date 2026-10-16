/-
  StanicaMaitraDeg4_v2.lean
  Verificação Formal em Lean 4 Core (Zero `sorry`) de Identidades Algébricas Finitas
  e Passos Aritméticos Auxiliares — Preprint v2 (Edição Auditada)

  Nota Transparente de Escopo:
  Este arquivo formaliza e verifica por decisão finita (`decide`) e aritmética linear
  inteira (`omega`) as identidades algébricas finitas auxiliares do manuscrito:
    1. O contraexemplo aritmético módulo 5 em n = 10 (Seção 5, Observação 5.3).
    2. A sizígia linear tripla l_1 + l_2 + l_3 = 0 (mod 2) em n = 8 (Teorema 4.6).
    3. A parametrização afim sobre F_2^2 nas 4 órbitas negacíclicas em n = 10 (Teorema 5.4).
    4. A sizígia negacíclica v_1 + ... + v_5 = v_6 (mod 2) e 16 | A_{63} em n = 12 (Teorema 6.1).
    5. A partição exata de F_2^6 em 16 órbitas de tamanho 4 sob o operador de quarto de
       período T_z(u) = sigma_6^3(u) + tau_3(z) para z in {9, 27} (Teorema 6.2(1)).
    6. A tabela dos 8 setores bi-antipodais e a equivalência W_{g_0}(63)^2 == 256 (mod 384)
       <==> c_{40} + c_{26}*c_{42} = 1 (Teorema 6.2(3)).
    7. As identidades finitas de sinais de Poisson em V_3 (gamma = 21) e V_4 (módulo 32)
       (Teorema 6.3(2)-(3)).
    8. Os passos aritméticos lineares (via `omega`, assumindo a decomposição de Fermat
       2^{h-1} = p*q + 1 como hipótese aritmética de entrada) para A_{1_h} != 0 em n = 2p^r
       e n = 4p^r, e a paridade do radical de período 2 z_2 (Teoremas 5.2, 6.5 e 6.6).
  A cascata computacional de 9 estágios (postos 12 -> 43 em n = 12) não é executada dentro
  do Lean; ela é executada e certificada pelo script Python/NumPy `verify_stanica_maitra_deg4_v2.py`.
-/

set_option maxRecDepth 100000
set_option maxHeartbeats 10000000

namespace StanicaMaitraDeg4

/--
  1. CONTRAEXEMPLO ARITMÉTICO AO ARGUMENTO MÓDULO 5 DA VERSÃO V1 (Observação 5.3):
     Em n = 10, para a_0 = 0 e a_{1_5} = 8 (ou -8), temos:
       a_0^2 + a_{1_5}^2 = 64 ≡ 4 (mod 5)
       (a_0 + a_{1_5})^2 = 64 ≡ 4 (mod 5)
     Portanto, a condição de congruência módulo 5 da v1 NÃO força a_{1_5} ∈ {±32}.
-/
theorem counterexample_v1_lemma52 :
    let a0 : Int := 0
    let a31 : Int := 8
    (a0 ^ 2 + a31 ^ 2) % 5 = 4 ∧ ((a0 + a31) ^ 2) % 5 = 4 ∧ a31 ≠ 32 ∧ a31 ≠ -32 := by
  decide

/--
  2. TEOREMA 4.6 (SIZÍGIA LINEAR TRIPLA EM n = 8):
     As três formas lineares em F_2^3:
       l_1(a,b,c) = a + b,  l_2(a,b,c) = a + c,  l_3(a,b,c) = b + c
     satisfazem l_1 + l_2 + l_3 = 0 (mod 2). Logo, no máximo 2 são iguais a 1,
     sem identificar esta contagem abstrata com uma autocorrelação de f.
-/
def n8_triple_syzygy_holds : Bool :=
  List.all [false, true] (fun a =>
    List.all [false, true] (fun b =>
      List.all [false, true] (fun c =>
        let l1 := xor a b
        let l2 := xor a c
        let l3 := xor b c
        let count_ones : Nat := (if l1 then 1 else 0) + (if l2 then 1 else 0) + (if l3 then 1 else 0)
        (xor (xor l1 l2) l3 == false) && (count_ones <= 2))))

theorem theorem_4_6_n8_triple_syzygy : n8_triple_syzygy_holds = true := by
  decide

/--
  3. TEOREMA 5.4(1) (ESTRUTURA AFIM E SIZÍGIA NEGACÍCLICA EM n = 10):
     Verifica para as 64 escolhas de (c1, c5, c6, c9, c14, c19) ∈ Bool^6 que
     w1 + w2 + w3 = w4 (mod 2) e A_{1_5} ∈ {±32} (se g1 = g2 = 0) ou {±8} (caso contrário).
-/
def check_n10_negacyclic_all : Bool :=
  let bools := [false, true]
  List.all bools (fun c1 =>
    List.all bools (fun c5 =>
      List.all bools (fun c6 =>
        List.all bools (fun c9 =>
          List.all bools (fun c14 =>
            List.all bools (fun c19 =>
              let w1 := xor (xor c1 c5) c6
              let g1 := xor (xor (xor c6 c9) c14) c19
              let g2 := xor (xor (xor c1 c5) c6) c19
              let w2 := xor w1 g1
              let w3 := xor (xor w1 g1) g2
              let w4 := c19
              let syzygy_ok := (xor (xor w1 w2) w3 == w4)
              let wt : Int := 10 * (if w1 then 1 else 0) + 10 * (if w2 then 1 else 0) +
                              10 * (if w3 then 1 else 0) + 2 * (if w4 then 1 else 0)
              let A31 : Int := 32 - 2 * wt
              let formula_ok :=
                if (!g1 && !g2) then
                  A31 == (if w1 then -32 else 32)
                else
                  A31 == (if c19 then 8 else -8)
              syzygy_ok && formula_ok))))))

theorem theorem_5_4_n10_negacyclic_syzygy : check_n10_negacyclic_all = true := by
  decide

/--
  4. TEOREMA 6.1 (SIZÍGIA DE PARIDADE NEGACÍCLICA E DIVISIBILIDADE 16 | A_{63} EM n = 12):
     Para toda tupla (v1, v2, v3, v4, v5, v6) satisfazendo v1 + v2 + v3 + v4 + v5 = v6 (mod 2),
     o peso wt = 12*(v1 + v2 + v3 + v4 + v5) + 4*v6 é múltiplo de 8 e A_{63} = 64 - 2*wt
     é múltiplo não-nulo de 16 (pertence a {-64, -32, -16, 16, 32, 64}).
-/
def check_n12_negacyclic_div16 : Bool :=
  let bools := [false, true]
  List.all bools (fun v1 =>
    List.all bools (fun v2 =>
      List.all bools (fun v3 =>
        List.all bools (fun v4 =>
          List.all bools (fun v5 =>
            let v6 := xor (xor (xor (xor v1 v2) v3) v4) v5
            let s5 : Int := (if v1 then 1 else 0) + (if v2 then 1 else 0) +
                            (if v3 then 1 else 0) + (if v4 then 1 else 0) + (if v5 then 1 else 0)
            let wt : Int := 12 * s5 + 4 * (if v6 then 1 else 0)
            let A63 : Int := 64 - 2 * wt
            (wt % 8 == 0) && (A63 % 16 == 0) && (A63 != 0))))))

theorem theorem_6_1_n12_divisibility_16 : check_n12_negacyclic_div16 = true := by
  decide

/--
  5. TEOREMA 6.2(1) (OPERADOR DE QUARTO DE PERÍODO T_z EM z = 9 E z = 27):
     Em F_2^6 (representado por Nat < 64), a rotação de 3 passos sigma_6^3(u) = ((u << 3) & 63) | (u >> 3)
     composta com tau_3(9) = 1 (para z = 9) ou tau_3(27) = 3 (para z = 27) define T_z(u).
     Verificamos exaustivamente para todos os 64 vetores u ∈ F_2^6 que:
       - T_z^2(u) = u ^^^ z ≠ u  e  T_z^4(u) = u;
       - Cada órbita {u, T_z(u), T_z^2(u), T_z^3(u)} possui exatamente 4 elementos distintos;
       - Em z = 9 (tau_3(9) = 1, peso ímpar 1), <1_6, T_9(u)> inverte a paridade de <1_6, u>,
         anulando a soma de Walsh em b = 63 sobre cada órbita de tamanho 4 (logo W_{g_9}(63) = 0);
       - Em z = 27 (tau_3(27) = 3, peso par 2), <1_6, T_{27}(u)> preserva a paridade de <1_6, u>.
-/
def rot6_3 (u : Nat) : Nat :=
  ((u <<< 3) &&& 63) ||| (u >>> 3)

def T_z (tau3 : Nat) (u : Nat) : Nat :=
  Nat.xor (rot6_3 u) tau3

def parity6 (u : Nat) : Bool :=
  let b0 := (u &&& 1) != 0
  let b1 := (u &&& 2) != 0
  let b2 := (u &&& 4) != 0
  let b3 := (u &&& 8) != 0
  let b4 := (u &&& 16) != 0
  let b5 := (u &&& 32) != 0
  xor (xor (xor (xor (xor b0 b1) b2) b3) b4) b5

def check_Tz_orbits_9_and_27 : Bool :=
  let u_list := List.range 64
  let ok9 := List.all u_list (fun u =>
    let u1 := T_z 1 u
    let u2 := T_z 1 u1
    let u3 := T_z 1 u2
    let u4 := T_z 1 u3
    (u2 == Nat.xor u 9) && (u4 == u) &&
    (u != u1) && (u != u2) && (u != u3) && (u1 != u2) && (u1 != u3) && (u2 != u3) &&
    (parity6 u1 == !(parity6 u)) && (parity6 u2 == parity6 u))
  let ok27 := List.all u_list (fun u =>
    let u1 := T_z 3 u
    let u2 := T_z 3 u1
    let u3 := T_z 3 u2
    let u4 := T_z 3 u3
    (u2 == Nat.xor u 27) && (u4 == u) &&
    (u != u1) && (u != u2) && (u != u3) && (u1 != u2) && (u1 != u3) && (u2 != u3) &&
    (parity6 u1 == parity6 u) && (parity6 u2 == parity6 u))
  ok9 && ok27

theorem theorem_6_2_quarter_period_orbits : check_Tz_orbits_9_and_27 = true := by
  decide

/--
  6. TEOREMA 6.2(3) (TABELA DOS 8 SETORES BI-ANTIPODAIS E LEI MÓDULO 384 EM b = 63):
     Verifica que W_{g_0}(63)^2 ≡ 256 (mod 384) se, e somente se, c40 ⊕ (c26 ∧ c42) = 1,
     eliminando analiticamente 4 dos 8 setores bi-antipodais para f bent.
-/
def w_g0_63 (c26 c40 c42 : Bool) : Int :=
  match c26, c40, c42 with
  | false, false, false =>   0
  | false, false, true  =>  -8
  | false, true,  false =>  16
  | false, true,  true  => -16
  | true,  false, false =>   0
  | true,  false, true  => -32
  | true,  true,  false => -32
  | true,  true,  true  =>   8

def a_0_sector (c26 c40 c42 : Bool) : Int :=
  match c26, c40, c42 with
  | false, false, false =>  64
  | false, false, true  =>   8
  | false, true,  false =>   0
  | false, true,  true  =>  16
  | true,  false, false =>  16
  | true,  false, true  =>  32
  | true,  true,  false =>   0
  | true,  true,  true  =>  -8

def check_n12_biantipodal_law : Bool :=
  let bools := [false, true]
  List.all bools (fun c26 =>
    List.all bools (fun c40 =>
      List.all bools (fun c42 =>
        let w := w_g0_63 c26 c40 c42
        let a0 := a_0_sector c26 c40 c42
        let mod384_ok := ((w * w) % 384 == 256)
        let div16_ok  := (a0 % 16 == 0)
        let alg_law   := xor c40 (c26 && c42)
        (mod384_ok == alg_law) && (if alg_law then div16_ok else true))))

theorem theorem_6_2_n12_biantipodal_law : check_n12_biantipodal_law = true := by
  decide

/--
  7. TEOREMA 6.3(2)-(3) (SOMAS DE SINAIS DE POISSON EM V_3 E V_4):
     Verifica que 16*s_{21} + 48*s_7 ∈ {-64, -32, 32, 64} e que 16*(s_1+s_2+s_3+s_4)
     é sempre múltiplo de 32 para s_i ∈ {-1, +1}.
-/
def check_v3_and_v4_poisson : Bool :=
  let signs : List Int := [-1, 1]
  let ok_v3 := List.all signs (fun s21 =>
    List.all signs (fun s7 =>
      let rhs : Int := 16 * s21 + 48 * s7
      (rhs == -64 || rhs == -32 || rhs == 32 || rhs == 64) && (rhs != 0)))
  let ok_v4 := List.all signs (fun s1 =>
    List.all signs (fun s2 =>
      List.all signs (fun s3 =>
        List.all signs (fun s4 =>
          let lv4 : Int := 16 * (s1 + s2 + s3 + s4)
          (lv4 % 32 == 0) &&
          (lv4 == -64 || lv4 == -32 || lv4 == 0 || lv4 == 32 || lv4 == 64)))))
  ok_v3 && ok_v4

theorem theorem_6_3_v3_and_v4_poisson : check_v3_and_v4_poisson = true := by
  decide

/--
  8. TEOREMAS 5.2, 6.5 E 6.6 (PASSOS ARITMÉTICOS PARA n = 2p^r E n = 4p^r E PARIDADE DE z_2):
     Assumindo p >= 3 e δ ∈ {0, 1}, o núcleo inteiro p*(q - 2*k) + (1 - 2*δ) jamais se anula
     (logo A_{1_h} != 0), e para o vetor de período 2 z_2(i) = (i+1) mod 2 vale
     z_2(i+d) ⊕ z_2(i-d) = 0 identicamente.
-/
theorem negacyclic_core_nonzero (p q k δ : Int) (hp : p ≥ 3) (hδ : δ = 0 ∨ δ = 1) :
    p * (q - 2 * k) + (1 - 2 * δ) ≠ 0 := by
  by_cases hn : q - 2 * k < 0
  · have hb := Int.mul_le_mul_of_nonneg_left (show q - 2 * k ≤ -1 by omega) (show 0 ≤ p by omega)
    simp only [Int.mul_neg_one] at hb
    rcases hδ with hδ | hδ <;> omega
  · by_cases hz : q - 2 * k = 0
    · rw [hz, Int.mul_zero]
      rcases hδ with hδ | hδ <;> omega
    · have hb := Int.mul_le_mul_of_nonneg_left (show 1 ≤ q - 2 * k by omega) (show 0 ≤ p by omega)
      simp only [Int.mul_one] at hb
      rcases hδ with hδ | hδ <;> omega

def check_z2_radical_parity : Bool :=
  List.all [false, true] (fun i_par =>
    List.all [false, true] (fun d_par =>
      let z_i_plus_d  := xor (xor i_par d_par) true
      let z_i_minus_d := xor (xor i_par d_par) true
      xor z_i_plus_d z_i_minus_d == false))

theorem theorem_6_6_z2_radical_parity : check_z2_radical_parity = true := by
  decide

-- Direct bridge: these are the actual 43 lexicographic quartic orbit representatives.
def quarticMasks12 : List Nat := [15, 23, 39, 71, 135, 263, 519, 1031, 27, 43, 75, 139, 267, 523, 1035, 51, 83, 147, 275, 531, 1043, 99, 163, 291, 547, 1059, 195, 323, 579, 1091, 643, 1155, 1283, 85, 149, 277, 533, 165, 293, 549, 325, 581, 585]

def rotate12 (m : Nat) : Nat := ((m <<< 1) &&& 4095) ||| (m >>> 11)
def orbit12 (m : Nat) : List Nat :=
  ((List.range 12).foldl (fun st _ =>
    (rotate12 st.1, if st.2.contains st.1 then st.2 else st.2 ++ [st.1]))
    (m, ([] : List Nat))).2

def orbitValue12 (m x : Nat) : Bool :=
  (orbit12 m).foldl (fun acc t => xor acc ((x &&& t) == t)) false

def generatorSyzygy12 : Bool :=
  quarticMasks12.all (fun m =>
    ([0,2,4,6,10,12] : List Nat).foldl (fun acc u =>
      xor acc (orbitValue12 m (u ||| ((u ^^^ 63) <<< 6)))) false == false)

theorem all_43_actual_generators_syzygy : generatorSyzygy12 = true := by
  decide

end StanicaMaitraDeg4

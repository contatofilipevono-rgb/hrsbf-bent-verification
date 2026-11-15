## Polar d4e871b24d8e…

Fase homogênea depois de (L5)+(L3): dimensão 18. Raios Z_d = {z : B_z d = 0} fixados pela polar.
Coeficientes livres no início: t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t16, t17, t18.
Os demais t_j são determinados (afins) por estes; o ponto-base tem t = t15 + t19 + t20 + t21 + t22 + t24 + t26 + t27 + t29 + t30 + t32 + t35 + t37 + t39 + t40 + t41.

- **Caso** t0 + t1 + t12 + t9 = 1:
  - **Restrição** por S_d = 0, d ∈ [5, 11, 13, 15, 27] (nível k0 de cada: d=5:k0=2, d=11:k0=2, d=13:k0=2, d=15:k0=2, d=27:k0=3) (dim 17 → 16):
    - t2 + t9 + t6 + t18 = 1
  - **Restrição** por S_d = 0, d ∈ [3, 5, 9, 11, 13] (nível k0 de cada: d=3:k0=2, d=5:k0=2, d=9:k0=3, d=11:k0=2, d=13:k0=2) (dim 16 → 14):
    - t2 + t3 + t5 + t6 = 0
    - t14 + t10 + t11 + t13 + t8 = 1
  - **Caso** t16 + t11 = 0:
    - **Restrição** por S_d = 0, d ∈ [3, 5, 7, 63] (nível k0 de cada: d=3:k0=2, d=5:k0=2, d=7:k0=2, d=63:k0=4) (dim 13 → 10):
      - t2 + t0 + t3 + t10 + t17 = 0
      - t1 + t7 + t4 = 0
      - t2 + t0 + t5 = 0
    - **Restrição** por S_d = 0, d ∈ [3] (nível k0 de cada: d=3:k0=2) (dim 10 → 9):
      - t0 + t2 + t3 = 1
    - **Folha `const`** (coeficientes livres: t0, t1, t2, t4, t8, t9, t10, t11, t13)
      - d = 1 = 000001, N_d = 16; D_d f(z,0) por z ∈ Z_d: 0 ×11, 1 ×3, t10 + t13 ×1, 1+t10 + t13 ×1
        ⇒ os termos com fase cancelam aos pares; **S_1 = 8 ≠ 0**
  - **Caso** t16 + t11 = 1:
    - **Restrição** por S_d = 0, d ∈ [1, 63] (nível k0 de cada: d=1:k0=2, d=63:k0=4) (dim 13 → 11):
      - t1 + t3 + t10 + t17 + t7 + t4 + t5 = 0
      - t2 + t0 + t3 + t17 + t13 = 1
    - **Folha `const`** (coeficientes livres: t0, t1, t2, t3, t4, t5, t7, t8, t9, t10, t11)
      - d = 1 = 000001, N_d = 16; D_d f(z,0) por z ∈ Z_d: 0 ×12, 1 ×4
        ⇒ os termos com fase cancelam aos pares; **S_1 = 8 ≠ 0**
- **Caso** t0 + t1 + t12 + t9 = 0:
  - **Folha `lin`** (coeficientes livres: t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t13, t14, t16, t17, t18)
    - d = 5 = 000101, N_d = 16; D_d f(z,0) por z ∈ Z_d: 0 ×4, t13 ×1, 1+t11 + t16 ×1, 1+t0 + t1 + t4 + t5 + t6 + t7 + t8 + t10 + t14 + t16 ×1, t10 + t17 ×1, 1+t2 + t6 + t10 + t17 ×1, t0 + t5 + t6 + t13 + t17 ×1, 1+t0 + t5 + t6 + t11 + t13 + t16 + t17 ×1, 1+t2 + t3 + t5 + t6 + t10 + t11 + t13 + t16 + t17 ×1, t9 + t18 ×1, 1+t0 + t1 + t3 + t4 + t6 + t7 + t8 + t9 + t11 + t14 + t17 + t18 ×1, 1+t1 + t4 + t7 + t9 + t10 + t11 + t16 + t17 + t18 ×2
    - d = 11 = 001011, N_d = 16; D_d f(z,0) por z ∈ Z_d: 0 ×5, 1+t11 + t16 ×1, t8 + t10 + t13 + t14 + t16 ×1, t2 + t3 + t5 + t6 + t8 + t10 + t13 + t14 + t16 ×1, t0 + t5 + t6 + t13 + t17 ×1, 1+t0 + t5 + t6 + t11 + t13 + t16 + t17 ×1, 1+t3 + t5 + t9 + t18 ×1, 1+t2 + t6 + t9 + t18 ×1, t0 + t1 + t4 + t5 + t6 + t7 + t9 + t10 + t13 + t18 ×1, 1+t0 + t1 + t4 + t5 + t6 + t7 + t9 + t10 + t11 + t13 + t16 + t18 ×1, t1 + t4 + t7 + t9 + t10 + t17 + t18 ×1, 1+t1 + t4 + t7 + t9 + t10 + t11 + t16 + t17 + t18 ×1
    - d = 13 = 001101, N_d = 16; D_d f(z,0) por z ∈ Z_d: 0 ×5, t2 + t3 + t5 + t6 ×1, 1+t11 + t16 ×1, t8 + t10 + t13 + t14 + t16 ×1, t0 + t5 + t6 + t13 + t17 ×1, 1+t0 + t5 + t6 + t11 + t13 + t16 + t17 ×1, 1+t2 + t6 + t9 + t18 ×1, t0 + t1 + t4 + t5 + t6 + t7 + t9 + t10 + t13 + t18 ×1, 1+t0 + t1 + t4 + t5 + t6 + t7 + t9 + t10 + t11 + t13 + t16 + t18 ×1, 1+t3 + t5 + t8 + t9 + t10 + t13 + t14 + t16 + t18 ×1, t1 + t4 + t7 + t9 + t10 + t17 + t18 ×1, 1+t1 + t4 + t7 + t9 + t10 + t11 + t16 + t17 + t18 ×1
    - d = 15 = 001111, N_d = 16; D_d f(z,0) por z ∈ Z_d: 0 ×3, t3 + t5 ×1, 1+t0 + t1 + t2 + t4 + t5 + t7 + t8 + t13 + t14 + t16 ×1, t0 + t5 + t6 + t13 + t17 ×1, 1+t2 + t6 + t10 + t11 + t16 + t17 ×1, 1+t0 + t5 + t6 + t11 + t13 + t16 + t17 ×1, t2 + t3 + t5 + t6 + t9 + t10 + t18 ×1, t0 + t1 + t4 + t5 + t6 + t7 + t9 + t10 + t13 + t18 ×1, 1+t0 + t1 + t4 + t5 + t6 + t7 + t9 + t10 + t11 + t13 + t16 + t18 ×1, t2 + t3 + t5 + t6 + t9 + t17 + t18 ×1, t1 + t4 + t7 + t9 + t10 + t17 + t18 ×2, t3 + t5 + t9 + t10 + t11 + t16 + t17 + t18 ×1, t0 + t1 + t4 + t5 + t6 + t7 + t8 + t9 + t10 + t13 + t14 + t16 + t17 + t18 ×1
    - d = 27 = 011011, N_d = 64; D_d f(z,0) por z ∈ Z_d: 0 ×14, 1 ×4, t2 + t3 + t5 + t6 ×2, t3 + t5 + t13 ×2, 1+t11 + t16 ×2, 1+t0 + t1 + t4 + t5 + t6 + t7 + t8 + t10 + t14 + t16 ×2, t8 + t10 + t13 + t14 + t16 ×4, t2 + t3 + t5 + t6 + t8 + t10 + t13 + t14 + t16 ×2, t10 + t17 ×2, 1+t2 + t3 + t5 + t6 + t10 + t11 + t16 + t17 ×2, 1+t2 + t6 + t10 + t11 + t13 + t16 + t17 ×2, t0 + t1 + t4 + t5 + t6 + t7 + t8 + t10 + t13 + t14 + t16 + t17 ×2, 1+t3 + t5 + t9 + t18 ×2, 1+t2 + t6 + t9 + t18 ×4, t2 + t3 + t5 + t6 + t9 + t10 + t18 ×2, t0 + t1 + t4 + t5 + t6 + t7 + t9 + t10 + t13 + t18 ×2, 1+t0 + t1 + t4 + t5 + t6 + t7 + t9 + t10 + t11 + t13 + t16 + t18 ×2, 1+t0 + t1 + t2 + t4 + t5 + t7 + t8 + t9 + t13 + t14 + t16 + t18 ×2, 1+t3 + t5 + t8 + t9 + t10 + t13 + t14 + t16 + t18 ×2, t2 + t3 + t5 + t6 + t9 + t17 + t18 ×2, 1+t2 + t6 + t9 + t10 + t17 + t18 ×2, 1+t0 + t1 + t3 + t4 + t6 + t7 + t8 + t9 + t11 + t14 + t17 + t18 ×2, t3 + t5 + t9 + t10 + t11 + t16 + t17 + t18 ×2

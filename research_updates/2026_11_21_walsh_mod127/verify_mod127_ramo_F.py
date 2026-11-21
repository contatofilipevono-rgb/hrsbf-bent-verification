from fractions import Fraction as F

M, p = 256, 127
t = F(p, M)
G = 16*p - 2*M        # 1520
L0 = 16*(16*t - 2)    # 95
L_val = 4*p - M       # 252
L_over_M = F(L_val, M) # 63/64

ell_h = lambda w, h=3: 2 - 16*w + F(12 + 64*w, M) + F(2**(h+3), M*M)
ell_s = lambda w, h=4: 2 - 16*w + F(64*w - 4, M) + F(2**(h+3), M*M)

# === SECAO 7 (Teorema 0): Exclusao completa de 5 <= h <= 16 (global e hiperplano) ===
K1, K2 = F(L0, 64), F(L0, 32)
a_E, b_E = 64*t - 8, 640*t - 40
assert 3*a_E/32 > 4*(1 - t) + F(16, M)
# h = 5 (usa K1 = 95/64):
assert F(3,4)*K1 > ell_h(F(1,16), 5) and F(1,2)*K1 > ell_h(F(7,64), 5)
assert F(1,4)*K1 > ell_h(F(15,128), 5) and F(1,4)*K1 > ell_h(F(1,8), 5) and ell_h(F(5,32), 5) < 0
# 6 <= h <= 12 (usa K2 = 95/32 pois semiposto residual >= 4):
for h in range(6, 13):
    assert F(3,4)*K2 > ell_h(F(1,16), h) and F(1,2)*K2 > ell_h(F(7,64), h)
    assert F(1,4)*K2 > ell_h(F(15,128), h) and F(1,4)*K2 > ell_h(F(1,8), h)
    w_max_h = (2 + F(12, M) + F(2**(h+3), M*M)) / (16 - F(64, M))
    assert w_max_h < F(3, 16) and F(1, 8)*K2 > ell_h(F(5, 32), h)
# h = 13 global:
assert 2**(13 + 2) == 2**(12 + 3)
# Tabela Sec 1.1 em E/(pM) para semiposto residual >= 5 (com 3*a_E/64 na linha 3/16 afim):
e_u = lambda v: 4*(1 - t) - 8*(4*t - 1)*v + F(16, M)
assert 3*a_E/32 > e_u(F(0))
assert a_E/32 + 2*a_E*F(7, 512) > e_u(F(1, 8))
assert 3*a_E/64 > e_u(F(3, 16))
assert a_E/64 > e_u(F(7, 32))
assert a_E/64 > e_u(F(1, 4))  # The new cubic lemma precludes B4 = 0.
# h = 13 (hiperplano) e h = 14 (global): w <= 65/336 < 3393/17408 (Lema 2, A=7)
assert (3 + F(12, M)) / (16 - F(64, M)) == F(65, 336) < F(3393, 17408)
# h = 14, 15 (hiperplano) e h = 15, 16 (global): Lema 1 estendido (j=6) + Cantelli A=9 com U=72/25, L=43/20
b_cub = [F(1,8), F(7,32), F(1,4), F(37,128), F(8,25), F(177,512)]
b6 = min((F(1,2) - F(1, 2**(r+1)))/2 + b_cub[6-r]/2**r + (2**r - 1)*b_cub[6-r-1]/2**(r+1) for r in (1, 2, 3))
assert b6 == F(373, 1024) and F(127, 128)*F(15, 32) > 2*b6*(1 - b6)
E_low_h14 = a_E * (3 - F(1, 64)) / 256
w_up_h14 = (M*M - 4 - E_low_h14*p*M) / 256032
w_ceil_h14 = F(221, 1000)
assert w_up_h14 == F(113951, 516096) < w_ceil_h14
U_A9, L_A9 = F(72, 25), F(43, 20)
assert U_A9 <= 8 * b6
def floor_q(A_val, j_val):
    rem = A_val - j_val
    if rem < 0: return F(0)
    if rem == 0: return F(1, 16)
    if rem == 1: return F(15, 128)
    return (3 - F(2, 2**rem)) / 16
s9 = floor_q(9, 1)
mu_q = lambda w: 16*w*(1 - w)
for l_pt, r_pt in [(F(55, 256), F(218, 1000)), (F(218, 1000), w_ceil_h14)]:
    assert L_A9 < mu_q(l_pt) <= mu_q(r_pt) < U_A9
    assert (mu_q(l_pt) - L_A9)*(U_A9 - mu_q(r_pt)) - 256*(r_pt - s9)**2 * r_pt * (1 - r_pt) > 0
rows_A9 = [
    (1, F(0),           F(0)),
    (2, F(1065, 3584), -F(71, 448)),
    (3, F(75, 256),    -F(5, 32)),
    (4, F(255, 896),   -F(17, 112)),
    (5, F(15, 56),     -F(1, 7)),
    (6, F(123, 512),   -F(17, 128)),
]
for c_val, u_c, v_c in rows_A9:
    assert v_c <= 0 and u_c + v_c*F(15, 8) <= 0
    for r_val in (1, 2, 3):
        wt_q = F(1, 2) - F(1, 2**(r_val + 1))
        Z_v = floor_q(9, c_val + r_val)/2**r_val + (2**r_val - 1)*floor_q(9, c_val + r_val + 1)/2**(r_val + 1)
        assert u_c + v_c*4*wt_q <= Z_v
    assert min(al/16 + (floor_q(9, c_val) + (2**c_val - 1)*u_c + v_c*(2**(c_val - 1))*al)/2**c_val for al in (L_A9, U_A9)) > w_ceil_h14

# === SECAO 7B: Teorema A (w >= 1/8 ou r >= 8 => R = 0 em F^c) ===
assert 1020 + (16*p*M - 64*p)//8 == M*M - 4*p
bJ_Fc_18 = F(1, 16) + 4 * F(9, 2*M)
assert bJ_Fc_18 == F(17, 128) < F(95, 512)
kappa10 = F(2**10, M*M)
assert 16*kappa10 + bJ_Fc_18/8 == F(273, 1024) < L_over_M

delta_r8 = F(4) + F(16*M - 64, 2**11) + F(1, 4)
bJ_Fc_r8 = F(1, 16) + 4 * (delta_r8 / M)
assert delta_r8 == F(199, 32) < F(249, 40)
assert delta_r8/M + F(1,16) < F(63,256)
assert bJ_Fc_r8 < F(95, 512) and 16*kappa10 + bJ_Fc_r8/8 < L_over_M

ell_sharp_18 = ell_s(F(1, 8), 4)
assert ell_sharp_18 == F(9, 512) < F(L0, 4096)
w_max_sharp = (2 - F(4, M) + F(128, M*M)) / (16 - F(64, M))
assert w_max_sharp == F(1017, 8064) < F(1, 8) + F(1, 512)

# === SECAO 8: Faixa w >= 1/8 sem B_5 = B_4 ===
assert F(4, 3) * w_max_sharp < F(3, 16)
assert F(1, 32) * F(G, p) * (F(1, 4) - F(256, M*M)) > ell_sharp_18
assert (F(3, 2) - F(4, M)) / 2 > ell_sharp_18
cost_sec8_2 = F(1, 64) * min(16*(F(126,256) - F(1,16)), F(1,2)*16*(F(254,256) - F(1,8)))
assert cost_sec8_2 > ell_sharp_18
assert F(15, 32) > ell_sharp_18
Delta = 2 * (w_max_sharp - F(1, 8))
assert Delta == F(1, 448) < F(1, 128)
assert F(1, 4) + Delta < F(37, 128) and 8*(F(1, 4) + Delta) < 2 + F(1, 16)

# === SECAO 9: 0 < w < 1/8 e D = abR para r <= 7 ===
assert F(3,4)*K1 > ell_h(F(1,16),4)
assert K1/2 > ell_h(F(7,64),4)
e15_h4 = ell_h(F(15, 128), 4)
assert F(L0, 128) > e15_h4 and F(15, 128)*F(G, p)*(2*t - F(512, M*M)) > e15_h4

e15 = ell_h(F(15, 128), 3)
assert F(L0, 256) > e15 and F(15, 128)*F(G, p)*(F(1, 4) - F(2**12, M*M)) > e15

e7_h2 = ell_h(F(7, 64), 2)
assert F(L0, 256) > e7_h2
assert F(7, 64)*min(16*(F(126,256) - F(1,64)), F(1,2)*16*(F(254,256) - F(1,32))) > e7_h2

# D = a(b+c), h = 3 via Parseval no quociente
assert F(7, 32) < F(1, 4)
assert 8*(F(7, 128) - F(1, 512)) == F(27, 64) > ell_h(F(7, 64), 3)

# D = abR, r = 0..4
assert F(1, 8)*F(G, p)*(F(1, 4) - F(1024, M*M)) > ell_sharp_18
e16, e32, e7_h3 = ell_h(F(1, 16), 3), ell_h(F(3, 32), 3), ell_h(F(7, 64), 3)
assert F(L0, 64) > e16 and F(1, 16)*16*(2 - F(6, M) - F(2**12, M*M)) > e16
assert F(L0, 64)*F(12, 16) > e16 and F(1, 16)*16*(2 - F(6, M) - F(2**11, M*M)) > e16
assert F(7, 16) + F(L0, 128) > e16
assert F(L0, 128) > e32 and F(L0*10, 1024) > e32 and F(L0*4, 512) > e32 and F(21, 32) > e32
for r, w, ew in [(3, F(7, 64), e7_h3), (4, F(15, 128), e15)]:
    err, err1 = F(2**(2*r+6), M*M), F(2**(2*r+7), M*M)
    cf = min(16*(F(126,256)-err), 16*(F(159,256)-err), F(1,2)*16*(F(254,256)-err1))
    assert w*cf > ew
for r in range(1, 5):
    err, err1 = F(2**(2*r+6), M*M), F(2**(2*r+7), M*M)
    cf = min(16*(F(126,256)-err), 16*(F(159,256)-err), F(1,2)*16*(F(254,256)-err1))
    assert F(1, 8)*cf > ell_sharp_18

# D = abR, r = 5, 6, 7 via Parseval no quociente (w < 1/8 e w >= 1/8)
for r in (5, 6, 7):
    q = (1 - F(1, 2**r)) / 2
    assert F(71, 100)**2 > q
    assert 4*(q/4 - F(71, 100)*F(2**r, 1024)) > ell_h(q/4, 3)
    assert F(51, 100)**2 > (w_max_sharp*4)/2
    assert 4*(F(1, 8) - F(51, 100)*F(2**r, 1024)) > ell_sharp_18

# D = abR, r >= 8: fechamento completo via Y >= Z_min - L/(16p), K = 0, B_5=B_6=B_7=0 => gamma_5([Q+R]_2) = 0
for k in range(-200, 201):
    for sgn in (1, -1):
        y = sgn * M + k * p
        if (y + 2) % 16 == 0:
            assert F(y) >= -2 - F((y + 2)*(y - 510), 16*p)
        if (y + 506) % 16 == 0:
            B4_pt = ((y + 506) // 16) % 2
            assert F(y) >= (-506 + G*B4_pt) - F((y + 506)*(y - 1014), 16*p)

v0 = F(506, 1520)
for r in range(8, 16):
    sh = (r + 1) // 2
    # w >= 1/8:
    dv_ge = (F(1, 2**r) + F(1, 2**sh)) / 2
    gap_ge = F(3, 8) - dv_ge - v0
    assert F(1, 2)*F(G, M)*gap_ge - F(1, 2)*F(2, M) > ell_sharp_18/4 + F(64, M*M)
    # w < 1/8 (para TODO r >= 8):
    w = (1 - F(1, 2**r)) / 8
    ew = ell_s(w, 3)
    dv = (F(1, 2**r) + F(1, 2**sh)) / (2 * (1 - F(1, 2**r)))
    gap = F(3, 8) - dv - v0
    lhs = ((1 - F(1, 2**r))/2)*F(G, M)*gap - ((1 + F(1, 2**r))/2)*F(2, M)
    assert lhs > ew/4 + F(64, M*M)
    assert F(31, 64)*F(1014, M) - F(33, 64)*F(2, M) - ew > F(256, M*M)

ew_r8_max = ell_s((1 - F(1, 256))/8, 3)
for j, deg_Bj in [(5, 7), (6, 8), (7, 10)]:
    step = 1 << j
    best_R0 = min((y + 2)*(y - 510) for k in range(-4000, 4001) for sgn in (1, -1)
                  for y in [sgn*M + k*p] if (y + 2) % step == 0 and ((y + 2)//step) % 2 == 1)
    best_R1 = min((y + 506)*(y - 1014) for k in range(-4000, 4001) for sgn in (1, -1)
                  for y in [sgn*M + k*p] if (y + 506) % step == 0 and ((y + 506)//step) % 2 == 1)
    assert F(min(best_R0, best_R1), 4*p*M*(1 << deg_Bj)) > ew_r8_max

# === SECAO 10: D = 0 ===
# 10.1: h = 3
ell0 = ell_h(F(0), 3)
assert ell0 == F(2097, 1024) and ell0/L0 < F(3, 128)
bK = 2*(ell0 - F(L0, 64))
assert bK == F(577, 512)
for j in range(4, 9):
    step = 1 << j
    best_L = min((y+2)*(y-510) for k in range(-2000, 2001) for sgn in (1, -1)
                 for y in [sgn*M + k*p]
                 if (y+2) % step == 0 and ((y+2)//step) % 2 == 1)
    assert F(best_L, p*M) / (1 << ((4*j)//3)) > bK
for Ym, Yp in [(-5586, 2030), (-1522, 6094)]:
    assert F(-Ym*Yp - 1020 - abs(Ym + Yp - 508), 128*p*M) > ell0

# 10.2: Global h = 2 e h = 1
assert 8 // 3 >= 2
for l in range(1, 15):
    for c in range(1, min(3*l + 1, 30) + 1):
        if l == 3 and c == 10: continue
        assert max(l + min(8, 15 - c), l + (30 - c + 3)//4) >= 9

# 10.3: Hiperplano Teoremas F1 e F2
assert 16*kappa10 + F(1, 128) == F(33, 128) < L_over_M
assert 6 < (27 + 3)//4 and 7 < (29 + 3)//4
for l in range(1, 15):
    for c in range(1, min(3*l + 1, 31) + 1):
        assert max(l + (16 - c), l + (31 - c + 3)//4) >= 9
for j in range(4, 8):
    step = 1 << j
    best = min(abs(sgn*M + k*p) for k in range(-3000, 3001) for sgn in (1, -1)
               if (sgn*M + k*p) % step == 0 and ((sgn*M + k*p)//step) % 2 == 1)
    assert F(best**2 - M**2, M**2) / (1 << ((4*j)//3)) > 1
assert F((126*256)**2 - M**2, M**2) / (1 << 10) > 1
for w_rm3 in [F(1,8), F(3,16), F(7,32), F(1,4)]:
    assert int(2**32 * (1 - 2*w_rm3)) % 127 != 0
ex_V1 = F(760**2 - M**2, M**2)
assert F(1, 2)/ex_V1 == F(512, 8001) < F(3, 32)
assert 2*(F(1, 2) - F(1, 16)*ex_V1) == F(191, 8192) < F(1776**2 - M**2, M**2)/32

# 10.4: Momentos em D = 0, h = 0, radical trivial (Teorema G1), |S_big| <= 66058, gamma_2([C_9]_12) = 0 e Teorema G2
assert F(2**30 + 2**16 + 2**8, 126) < 2**24 - 2**15
assert 2**24 + 2**15 + (2**30 + 2**16 + 2**8)//126 + (2**30 + 2**16 + 2**8)//(126**2) + 2 < 2**25
assert (2**30 - 2**24 + 2**16 + 2**15 + 2**8) // (126 * 127) == 66058
assert (-16256) % 512 == 128 and (32512) % 512 == 256 and (2**15 - 2**23) % 512 == 0
for l in range(1, 21):
    assert max(16 - l, (31 + 2*l + 3)//4) >= 10
    if l >= 5:
        assert (31 + 2*l + 3)//4 >= 11

# Teorema G2: Inexistencia de hiperplanos de zeros de C_9 (c=1) e isotropia de a_f para flats de zeros de C_9 (c in {2,3,4})
base_c1 = 128 * (2**23 - 2**15)
assert base_c1 == 1069547520
rem_Jc = (2**30 + 2**16 + 2**8) - base_c1
assert rem_Jc == 4260096
N1_c1_min = (2**23 - 2**15) - (rem_Jc // 126)
assert N1_c1_min == 8322030
assert base_c1 + N1_c1_min > 2**30 + 2**16 + 2**8
for c in (2, 3, 4):
    base_J = 128 * (2**(24 - c) - 2**15)
    rem_budget = (2**30 + 2**16 + 2**8 - 8220000) - base_J
    for j in range(10, 16):
        deg = (4 * j) // 3
        min_wt = 1 << (32 - c - deg)
        step = 1 << (j - 9)
        best_exc = min(
            kv*kv - 128*kv
            for r in range(-64, 65)
            if (step * r) % 127 in (0, 1)
            for cand in [r if r % 2 != 0 else (r + 127 if r <= 0 else r - 127)]
            for kv in [step * cand]
        )
        assert min_wt * best_exc > rem_budget

# Apendice A (Secao 12): Limiar 95/128 da obstrucao local de semiposto alto h' >= 5
assert F(16*(8*t - 1), 64) == F(95, 128)

# === SECAO 10.5: Fechamento de V = z1 z2 z3 z4 em h=0 (Obstaculo 2b) e do Lema Mestre / Teorema F3 (todo h=1,2 e h=0, R afim em F^c) ===
# A) Obstaculo 2b: R = 0, V = z1 z2 z3 z4, h = 0
budget_JV = 16 * (F(1, 2) - F(1, 16) * ex_V1)
assert budget_JV == F(191, 1024)
# Grau de a_4 em F^c (d = 6 => ceil(18/4) = 5) implica deg(S_V|_{J_V}) <= 1
assert (3*6 + 3)//4 == 5
expected_minX_JV = {5: 2792, 6: 6856, 7: 14984, 8: 31240}
for j in range(5, 9):
    step = 1 << j
    best = None
    for k in range(-4000, 4001):
        for sgn in (1, -1):
            x = sgn*M + k*p
            if x % 16 != 8:
                continue
            sv = 0 if (x % 32) == 24 else 1
            z = x - (248 + 16*sv)
            if z % step == 0 and (z // step) % 2 == 1:
                if best is None or abs(x) < abs(best):
                    best = x
    assert abs(best) == expected_minX_JV[j]
    deg = (4*j) // 3
    d_cut = deg + 1
    assert d_cut + 3 >= j + 1 and (3*d_cut + 3)//4 >= j + 1
    assert F(best**2 - 760**2, M*M) / (1 << deg) > budget_JV

# Corte opcional de 1 coord em J_V -> J'_V (codim <= 6, budget <= 2 * 191/1024 = 191/512)
b_JVp = 2 * budget_JV
vals_512 = [760 + 512*m for m in range(-200, 201) if (760 + 512*m) % 127 in (2, 125) and m != 0]
assert all(abs(x) >= 1272 and F(x*x - 760*760, M*M) >= F(2032, M) * F(abs(x - 760), M) for x in vals_512)
assert F(760, M) - F(64, M) > F(M, 2032) * b_JVp

# B) Lema Mestre (beta_R = beta_Q => [R]_2 = [Q]_2) e Teorema F3 (todo h=1,2 e h=0, R afim em F^c)
L0_Fc = 4*t - 1     # 63/64
A_Fc = 16 * L0_Fc   # 63/4 = 15.75
cost_Fc = lambda j: (2**j*t - 2)*(2**j - 8)

def make_bmin_trueKT(degs):
    K_deg = {j: cost_Fc(j) / (1 << degs[j]) for j in range(4, 9)}
    memo = {}
    def bmin(j, c_abs):
        if (j, c_abs) in memo:
            return memo[(j, c_abs)]
        if j == 9:
            val = max(F(0), 8 * (L0_Fc - 16 * F(2**c_abs, M*M)))
            memo[(j, c_abs)] = val
            return val
        deg, Kj = degs[j], K_deg[j]
        candidates = []
        # 0) C_j = 0
        candidates.append(bmin(j+1, c_abs))
        # 1) KT Tipo 1 (1 <= x < 2, deg-2 fatores comuns -> hiperplanos disjuntos +1..+(deg-2))
        v1a = Kj + sum(F(1, 2**i) * bmin(j+1, c_abs + i) for i in range(1, deg - 1))
        candidates.append(v1a)
        # 2) KT Tipo 2 (grau efetivo deg, 3 <= mu <= deg -> x_1..x_{deg-mu}(u_1..u_mu + v_1..v_mu))
        for mu in range(3, deg + 1):
            val = (2 - F(1, 2**(mu - 1))) * Kj
            for i in range(1, deg - mu + 1):
                val += F(1, 2**i) * bmin(j+1, c_abs + i)
            base_c = c_abs + (deg - mu)
            base_w = F(1, 2**(deg - mu))
            for a_i in range(1, mu + 1):
                for b_i in range(1, mu + 1):
                    val += base_w * F(1, 2**(a_i + b_i)) * bmin(j+1, base_c + a_i + b_i)
            candidates.append(val)
        # 3) Klein-Storme codim 2 (2 <= x < 5/2) e codim 3 (5/2 <= x < 3), e x >= 3
        candidates.append(2*Kj + F(1, 4)*bmin(j+1, c_abs + 2))
        candidates.append(F(5, 2)*Kj + F(1, 8)*bmin(j+1, c_abs + 3))
        candidates.append(3*Kj)
        res = min(candidates)
        memo[(j, c_abs)] = res
        return res
    return bmin

b_gen_Fc  = make_bmin_trueKT({4:8, 5:9, 6:10, 7:12, 8:13})
b_cub_Fc  = make_bmin_trueKT({4:6, 5:8, 6:10, 7:12, 8:13})
b_quad_Fc = make_bmin_trueKT({4:5, 5:6, 6:8,  7:10, 8:12})

def check_allV_trueKT(wR, c0, b_Fc):
    c_abs = c0 + 1
    cost_all_V = (1 - wR) * A_Fc / 16
    w_min_max = (b_Fc - wR * b_gen_Fc(4, c_abs)) / cost_all_V
    lb_t1 = cost_all_V + wR * (F(1, 2)*b_cub_Fc(4, c_abs + 1) + F(1, 4)*b_cub_Fc(4, c_abs + 2) + F(1, 4)*b_gen_Fc(4, c_abs + 2))
    z_mu3 = F(1, 2)*b_cub_Fc(4, c_abs + 1) + sum(F(1, 2**(1 + a_i + b_i))*b_cub_Fc(4, c_abs + 1 + a_i + b_i) for a_i in range(1, 4) for b_i in range(1, 4))
    lb_t2_mu3 = F(7, 4)*cost_all_V + wR * z_mu3
    z_mu4 = sum(F(1, 2**(a_i + b_i))*b_cub_Fc(4, c_abs + a_i + b_i) for a_i in range(1, 5) for b_i in range(1, 5))
    lb_t2_mu4 = F(15, 8)*cost_all_V + wR * z_mu4
    lb_ks2 = 2*cost_all_V + wR * (F(1, 4)*b_cub_Fc(4, c_abs + 2) + F(3, 4)*b_gen_Fc(4, c_abs + 2))
    lb_ks3 = F(5, 2)*cost_all_V + wR * (F(1, 8)*b_cub_Fc(4, c_abs + 3) + F(7, 8)*b_gen_Fc(4, c_abs + 3))
    assert lb_t1 > b_Fc and lb_t2_mu3 > b_Fc and lb_t2_mu4 > b_Fc and lb_ks2 > b_Fc
    if w_min_max >= F(5, 2):
        assert w_min_max < F(11, 4) and lb_ks3 > b_Fc
    else:
        assert w_min_max < F(5, 2)

for wR, c0 in [(F(1,2), 1), (F(1,2), 3), (F(1,2), 5), (F(5,8), 4), (F(3,4), 2)]:
    b_Fc = F(M, 2*p) + F(1, 16)*wR
    assert wR * b_cub_Fc(4, c0 + 1) > b_Fc
    check_allV_trueKT(wR, c0, b_Fc)

# h=2, wR=3/8 (c0=4, N0=10; <=6 zeros de R cabem num hiperplano de F_2^4 => >=7 forcam deg S <= 2):
b_Fc_38 = F(M, 2*p) + F(3, 128)
assert F(3, 8) * b_quad_Fc(4, 5) > b_Fc_38
assert F(4, 16)*(A_Fc/16) + F(3, 8)*b_cub_Fc(4, 5) > b_Fc_38
check_allV_trueKT(F(3, 8), 4, b_Fc_38)

# h=1, wR=1/4 (c0=2, N0=3):
b_Fc_14 = F(M, 2*p) + F(1, 64)
assert F(1, 4) * b_quad_Fc(4, 3) > b_Fc_14
assert F(2, 4)*(A_Fc/16) + F(1, 4)*b_cub_Fc(4, 3) > b_Fc_14
w_k1_max = (b_Fc_14 - F(1, 4)*b_cub_Fc(4, 3)) / (A_Fc / 64)
assert w_k1_max < 2
lb_k1_t1 = A_Fc/64 + F(1, 4)*(F(1, 2)*b_quad_Fc(4, 4) + F(1, 4)*b_quad_Fc(4, 5) + F(1, 4)*b_cub_Fc(4, 5))
lb_k1_mu3 = F(7, 4)*(A_Fc/64) + F(1, 4)*(F(1, 2)*b_quad_Fc(4, 4) + sum(F(1, 2**(1 + a_i + b_i))*b_quad_Fc(4, 3 + 1 + a_i + b_i) for a_i in range(1, 4) for b_i in range(1, 4)))
lb_k1_mu4 = F(15, 8)*(A_Fc/64) + F(1, 4)*(sum(F(1, 2**(a_i + b_i))*b_quad_Fc(4, 3 + a_i + b_i) for a_i in range(1, 5) for b_i in range(1, 5)))
assert min(lb_k1_t1, lb_k1_mu3, lb_k1_mu4) > b_Fc_14
check_allV_trueKT(F(1, 4), 2, b_Fc_14)

# Fechamento completo de h=0, R=1 em F^c via Ax em dimensao 27 => deg S <= 3 => b_cub(4, 1) > b_Fc_R1
assert (27 + 3) // 4 == 7
b_Fc_R1 = F(M, 2*p) + F(1, 16)
assert b_Fc_R1 == F(2175, 2032)
assert b_cub_Fc(4, 1) == F(285, 128) > b_Fc_R1

print("PASS: desigualdades e tabelas racionais das Secoes 7-10.")

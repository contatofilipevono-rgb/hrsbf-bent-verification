from fractions import Fraction as F
p, M = 127, 256
t = F(p, M)
L0 = 4*t - 1
A, a = 16*L0, 16*(8*t - 1)
budget = lambda w: t + F(2, M*M) + F(16, M)*w
B = budget(1)
cost = lambda j: (2**j*t - 2)*(2**j - 8)
K = {j: cost(j)/2**(4*(j+2)//3) for j in range(4, 9)}
assert [K[j] for j in range(4, 9)] == [
    F(95,512), F(333,512), F(833,512), F(1845,1024), F(3875,1024)]
kappa = F(1, 32)
fourier_bound = F(11,32) + 16*kappa + (t+kappa)**2/(64*kappa)
assert L0 - fourier_bound == F(207,131072)
assert 16*F(2**9,M*M) + F(1,128) == F(17,128) < L0
b = F(7,5)
assert b < (2-F(1,32))*a/64 and 2*(b-a/64) < b
assert b/K[5] < F(5,2)
assert max(2*(b-K[5]), 4*(b-(2-F(1,256))*K[5]), 4*(b-2*K[5])) < K[6]
x_max, x_min = 256*B/a, 3-F(1,512)
s, low, high = F(1,16000), F(47,16), F(383,128)
mean = lambda x: x*(1-x/256)
var_max = 256**2*s*s*(x_max/256)*(1-x_max/256)
assert x_max == F(3661,1216) and x_max-256*s < 3-F(1,256)
assert low < mean(x_min) <= mean(x_max) < high
assert var_max < (mean(x_min)-low)*(high-mean(x_max))
cover = (F(63,16)*F(7,8)-high)/(2*F(31,16))
assert cover == F(29,248) and x_max-low == F(89,1216) < cover
for c, x in [(1, F(1)), (2, F(255,128))]:
    b = 2**c*(B-a*x/256)
    assert b < F(3,2)*K[5] and 2*(b-K[5]) < K[6]
P = F(127,32)*F(7,8)
assert a*P/256 > B and P > x_max
assert 2*F(63,32)*(B-a*F(5,2)/256)/(P-F(5,2)) == F(65205,169984) < K[5]
for kap, cutoff in [(F(1,32), F(7,30)), (F(1,4096), F(7,20))]:
    assert t-L0/8-kap > cutoff
    for r in range(3):
        assert L0-t/2**r-kap*2**r > t-L0/8-kap
for j in range(4,8):
    assert 2**j*(2**j*t-2)/2**(4*j//3) >= F(95,32)
BA, BW, BQ, Bstar = (budget(w) for w in (F(1,2),F(3,4),F(1,4),F(5,8)))
assert 2*BA/A < F(3,32)
assert 2*(BA-A/32) < min(a/128,K[5])
assert 4*(BQ-A/32) < min(a/256,K[5])
assert F(4,3)*(BW-A*F(15,512)) < min(a/256,K[5])
b = F(4,3)*(BW-A/64)
assert b < min(F(3,2)*a/128,K[5]) and 2*(b-a/128) < K[5]
assert Bstar/A < F(5,128)
assert 4*(Bstar-2*A/64) < min(F(7,10),a/256)
assert 2*(Bstar-A/64) < F(7,10) and 4*(Bstar-A*F(63,2048)) < F(7,10)
print("Verificação racional concluída.")

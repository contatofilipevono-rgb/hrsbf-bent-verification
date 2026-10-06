# 2-adic periodic-fiber classification for quartic HRSBF, n=32

Exact symbolic computation for F_z(u)=f(u,u+z), with f ranging over the 1128 quartic rotation-symmetric orbit generators.

For every nonzero z of minimal cyclic period <=4, we computed the fiber-image rank, affine-orbit length, and minimum 2-adic valuation of nonzero 1-, 2-, and 3-fold support intersections for an independent fiber basis.

| period | z class | rank | affine orbit | min v2(I1) | min v2(I2) | min v2(I3) |
|---:|---|---:|---:|---:|---:|---:|
|1|ffff|36|32|9|8|7|
|2|5555, aaaa|66|16|9|7|6|
|4|3333, 6666, 9999, cccc|98|8|7|6|5|
|4|1111,2222,4444,7777,8888,bbbb,dddd,eeee|110|8|8|6|5|

## Structural finding

Divisibility is **not determined by the period of z alone**. Period 4 splits into two exact classes, with fiber ranks 98 and 110. Therefore any general 2-adic fiber theorem must encode more information about the cyclic pattern of z.

The rank-98 class consists precisely of the period-4 words of Hamming weight 8 (two ones per 4-bit block); the rank-110 class has block weight 1 or 3. This suggests that the relevant invariant combines period with the orbit/weight type of the primitive block.

## Status

These are exact finite linear/intersection calculations, not a quartic nonexistence theorem. They sharpen the target for a proof: classify periodic z by primitive block type, derive the fiber-code divisibility symbolically, then combine the resulting congruences through the partial Walsh transform required by bentness.

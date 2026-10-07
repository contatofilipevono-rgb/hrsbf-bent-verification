# Derivative-spectrum duality for bent functions

Let f:F_2^n->F_2 be bent, n=2r, with dual f* defined by
W_f(w)=2^r (-1)^{f*(w)}.

For every a,b, direct Fourier expansion gives

W_{D_a f}(b)
= 2^{-n} sum_w W_f(w) W_f(w+b) (-1)^{a dot (w+b)}.

Substituting the bent spectrum yields

W_{D_a f}(b)
= sum_w (-1)^{f*(w)+f*(w+b)+a dot (w+b)}
= (-1)^{a dot b} W_{D_b f*}(a).

Hence the exact identity

    W_{D_a f}(b) = (-1)^{a dot b} W_{D_b f*}(a).

In particular b=0 recovers balance of every nonzero derivative:
W_{D_a f}(0)=W_{D_0 f*}(a)=sum_w (-1)^{a dot w}=0 for a!=0.

This identity is stronger than the elementary derivative-balance criterion, but it also identifies the obstruction in the quartic fixed-space program. The nonzero-frequency spectrum of the cubic derivative D_a f is governed by derivatives of the dual f*. Bentness alone does not make these quantities vanish.

For a rotation-symmetric bent f, the dual is also rotation-symmetric because the Walsh transform commutes with coordinate rotation. Thus cyclic symmetry survives dualization. Homogeneity and low algebraic degree, however, need not survive. Therefore the cubic fixed-space lemma cannot simply be applied on the dual side.

Potential quartic route:
1. exploit that both f and f* are rotation-symmetric;
2. combine odd-order orbit averaging with the derivative-spectrum duality;
3. seek a fixed-space identity involving paired derivative spectra of f and f* rather than balance transfer for an arbitrary invariant cubic.

This is an exact structural identity, not a proof of quartic nonexistence.

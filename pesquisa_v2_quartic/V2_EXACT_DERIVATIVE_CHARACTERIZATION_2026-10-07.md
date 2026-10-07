# Exact derivative characterization for degree <= 4

Let V=F_2^n and f:V->F_2 have degree at most 4. Define
Q_f(a,b,c,d)=D_a D_b D_c D_d f (a constant),
and C_f(a,b,c)=(D_a D_b D_c f)(0).

Proposition. For a,b in V, D_aD_b f is constant iff Q_f(a,b,c,d)=0 for all c,d and C_f(a,b,c)=0 for all c.

Proof. Put g=D_aD_b f. Then deg(g)<=2. The function g is constant iff D_c g is identically zero for every c. For fixed c, h=D_cg has degree <=1. An affine Boolean function h is identically zero iff h(0)=0 and D_dh=0 for every d. These are exactly C_f(a,b,c)=0 and Q_f(a,b,c,d)=0.

Corollary. U<=V is a relaxed M-subspace iff these two conditions hold for all a,b in U.

Exterior-square formulation. Q_f induces Phi_f: Lambda^2 V -> (Lambda^2 V)^*. Hence every relaxed M-subspace U satisfies Lambda^2 U <= ker(Phi_f), together with the residual C_f obstruction.

For the certified n=8 quartic RS bent block, ker(Phi_f) has no nonzero decomposable 2-vector, so the Q_f obstruction alone excludes every independent pair and yields r-ind(f)=1.

Literature status (2026-10-07). Polujan--Pott introduce relaxed M-subspaces via constant second derivatives and derive direct-sum properties. Recent M-subspace papers give other algebraic characterizations for special constructions. A directed search did not locate this degree-4 Q_f/C_f formulation. This is not a proof of novelty; manuscript wording should say 'to the best of our knowledge' only after broader priority review.

Important limitation. The exterior-square condition alone is necessary, not sufficient in general: C_f detects the remaining affine third-derivative obstruction.
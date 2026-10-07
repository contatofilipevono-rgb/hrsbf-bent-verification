# Refined symbolic C8 proof strategy

Literature check confirms that the correct ambient theory is the decomposition of exterior squares of indecomposable modules for cyclic 2-groups in characteristic 2 (Gow--Laffey, J. Group Theory 9 (2006), 659--672; see also Korhonen, LAA 624 (2021), 349--363).

For the 8-cycle permutation module over F_2, V is the indecomposable module V_8 = F_2[t]/(t^8), t=rho+1. Hence Lambda^2(V_8) has a known indecomposable decomposition. The quartic polarization Phi is C_8-equivariant.

Important correction/limitation: the abstract decomposition of Lambda^2(V_8) alone does not identify the embedded kernel K. One must still use the three quartic orbit coefficients to determine Phi on cyclic generators of the indecomposable summands. Because the modules are uniserial/local, this is far smaller than a 28x28 basis calculation: an equivariant map is determined by generator images subject to t-power annihilation.

Target symbolic proof:
(1) choose cyclic generators for the known indecomposable summands of Lambda^2(V_8);
(2) evaluate Phi on those generators using only the three quartic orbit seeds;
(3) express each image as a polynomial in t times a target generator;
(4) read off kernel lengths from t-adic valuations;
(5) recover K ~= V_6 and R=ker(t^2|K) ~= V_2.

Even after K~=V_6 is obtained symbolically, exclusion of decomposable vectors requires an embedding-sensitive argument. The existing exact rank spectrum (3 rank-4, 60 rank-8, no rank-2) remains a valid independent certificate until a closed rank formula along the t-adic chain is derived.

This route reduces the proof burden from 28x28 Gaussian elimination to a small number of equivariant generator identities while keeping the finite certificate as verification.

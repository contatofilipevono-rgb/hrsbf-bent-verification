# Independent-referee request: the power-of-two theorem

The attached manuscript claims that no homogeneous cubic rotation-symmetric Boolean function is bent in \(n=2^k\) variables for every \(k\ge2\). This is a mathematical claim with finite computational controls, not a proof-assistant formalization. Bibliographic priority has not been established.

Please act as an adversarial specialist referee. Try to refute the theorem before evaluating exposition. Address each point separately:

1. **Quadratic lemma.** In \(\mathbb F_2[X]/((X+1)^n)\), for \(n=2^k\), verify that a proper cyclic invariant radical contains no odd-weight vector and therefore lies in \(\operatorname{im}(S+I)\). Check the calculation \(Q(Sy+y)=0\) for every radical vector while retaining arbitrary affine terms. Confirm that the conclusion is only “balanced implies zero polar,” so balanced affine functions are not excluded.

2. **Diagonal cancellation.** Verify that half-turn invariance pairs every cubic ANF monomial with a distinct monomial and that the restriction \(f(u,u)\) vanishes. Check whether any short cyclic orbit or Boolean reduction can invalidate this argument.

3. **Fiber degree and Parseval.** Verify \(F_z(u)=D_{(0,z)}f(u,u)\), \(\deg F_z\le2\), the invertibility of \((u,z)\mapsto(u,u+z)\), and the normalization
   \[
   \sum_z A_z^2=2^{2h}.
   \]
   Decide whether \(F_0=0\) really forces every nonzero fiber to be balanced.

4. **Polar-transfer identity.** Expand the third polarization in characteristic two and check
   \[
   B_{F_{\mathbf1}}(u,v)
   =B_{D_{\mathbf1}f}(d(u),e(v)).
   \]
   Track all base-point, quadratic and affine terms. Check the simultaneous use of half-turn invariance.

5. **Twisted rotation.** Under the stated right-shift convention, verify
   \[
   S_{2h}(u,u+\mathbf1)=(S_hu+e_0,S_hu+e_0+\mathbf1).
   \]
   Then determine whether an affine fiber invariant under \(u\mapsto S_hu+e_0\) must be constant.

6. **Range of the theorem.** Identify every place where \(n=2^k\), homogeneity, degree three and full one-step rotation symmetry are used. Test whether \(k=2\) or short monomial orbits require separate handling.

7. **Priority.** Search for a precise published theorem that already excludes all homogeneous cubic rotation-symmetric bent functions in every power-of-two dimension. Compare the exact result and proof mechanism with Chirvasitu--Cusick (2020, 2024), Meng--Chen--Fu (2010), Zhang--Gao (2013), and Sun--Shi--Liu--Fu (2026). Do not infer novelty merely because the same wording was not found.

Return four separate verdicts: mathematical validity, exposition, computational reproducibility and bibliographic priority. For every alleged gap, name the exact failed implication and supply a counterexample or missing assumption. Do not predict journal acceptance from mathematical validity alone.

Reproduce the finite controls with:

```bash
python3 audit_power_of_two_theorem.py auditoria_potencias_de_2.json
```

The audit verifies all cubic orbit generators in dimensions \(4,8,16,32,64\), exhausts the full homogeneous cubic rotation-symmetric spaces at \(4,8\), and checks the quadratic lemma exhaustively through \(16\), with deterministic controls at \(32,64\). The algebraic proof must stand independently of these computations.

from pathlib import Path
import json,re,shutil
root=Path(__file__).resolve().parent
base=root.parents[1]/'outputs/H12_preprint'
out=root.parents[1]/'outputs/H12_revisao2';out.mkdir(exist_ok=True)
old=(base/'H12_preprint.md').read_text(encoding='utf-8')
(out/'H12_before_round2.md').write_text(old,encoding='utf-8')
t=old
abstract='''We prove that no homogeneous rotation symmetric Boolean function of degree four in twelve variables is bent. The full quartic cyclic space has forty-three independent coefficients. We reduce bentness in this space to three explicit affine families of dimension thirty-six, together with quadratic necessary conditions. The reduction combines divisibility of weights on coordinate subspaces, three linear consequences of the resulting equations, and autocorrelation congruences on inputs of period four. An algebraic identity excludes a fourth periodic case. We then refute the three remaining families by finite certificates using polynomial identities, affine substitutions and exhaustive branching, with exact Walsh witnesses at the terminal states. A soundness theorem and the three concrete refutations are verified in Lean. The formal conclusion excludes bentness for every choice of the forty-three coefficients, and its equivalence with the Walsh formulation is checked. The structural argument is given explicitly, and an independent checker provides a separate replay of the finite certificate. The result establishes the twelve-variable quartic case of the homogeneous rotation symmetric bent function conjecture.'''
assert 150<=len(abstract.split())<=250
t=t[:t.index('## Abstract')]+t[t.index('## Abstract'):].replace(t.split('## Abstract\n\n')[1].split('\n\n**Keywords:')[0],abstract,1)
start=t.index('Rotation symmetry alone does not exclude')
end=t.index('## 2 Preliminaries',start)
intro=r'''The following selected results indicate the parameter and support restrictions relevant to the present problem. The table is a comparison of stated results, rather than an exhaustive classification of all cases of the conjecture. For the interval criterion, $s_f$ denotes the largest circular gap between consecutive indices in a monomial of $f$.

| Source | Parameters or hypothesis | Conclusion and boundary |
|---|---|---|
| Stănică--Maitra [2] | Rotation symmetric functions studied up to ten variables | Computational evidence motivating the conjecture; not a twelve-variable exclusion |
| Meng--Chen--Fu [3], as reproduced in Lemma 7 of [4] | Homogeneous degree at least three and $s_f\le n/2$ | Non-bentness under the interval condition; this does not cover arbitrary supports |
| Cusick--Sanger, arXiv:1708.09313, Theorem 3.8 | $n=2p$, $p>2$ prime | A homogeneous bent function must have even degree; twelve is not of the form $2p$ |
| Sun et al. [4], Theorems 1--2 | Growth conditions on the odd prime factors of $n$ | Orbit-value and orbit-count restrictions; the hypotheses fail at $n=12$ |
| Sun et al. [4], Theorems 3--6 | Support-distance conditions, parity patterns or cubic degree | Further conditional exclusions; Theorem 4(2) has degree threshold five at $n=12$ |
| Present theorem | $n=12$, degree four, all forty-three cyclic coefficients | Nonexistence throughout the complete homogeneous quartic space |

For $n=12=2^2\cdot3$, the first odd prime is $3$, whereas the first prime bound in Theorems 1--2 of [4] is $16$. Their Theorems 3 and 4(1) retain restrictions on supports; Theorem 4(2) requires degree at least $\lfloor12/4\rfloor+2=5$; and Theorems 5--6 concern cubic functions. We therefore treat the full quartic cyclic space directly, rather than assuming that one of those restricted criteria applies to every coefficient vector.

There are forty-three cyclic orbits of quartic monomials in twelve variables. The complete coefficient space consequently has $2^{43}$ elements.

**Theorem 1.1.** No homogeneous rotation symmetric Boolean function of degree four in twelve variables is bent.

Our contribution has two parts. First, restricted weight divisibility, three linear consequences, a period-four autocorrelation argument and an exclusion identity place every hypothetical bent function in one of three explicit thirty-six-dimensional affine families. Second, finite refutations exclude every bent observation in those families. The refutation rules have a soundness proof, and that proof and the three concrete instances are checked in Lean. Thus the structural reduction and the finite exclusions form a single coverage argument for the full coefficient space. The linear identities, affine parametrizations and acceptance conditions are included in the exposition.

Rotation symmetry alone does not exclude bentness above degree two. Polujan, Kudin and Pasalic [5] construct rotation symmetric bent functions outside the completed Maiorana--McFarland class. Their quartic family has $n=2m$ with $m$ odd and $3\nmid m$, while their maximum-degree family has degree six at $n=12$. Tang's preprint (Cryptology ePrint Archive 2026/1799, https://eprint.iacr.org/2026/1799) gives constructions in dimensions $30\cdot7^j$ and $70t$. These parameter sets do not include twelve. Homogeneity concerns the whole algebraic normal form and must be distinguished from maximum degree and from membership in a particular bent class.

The present quartic argument is self-contained.[^v1]

[^v1]: Related work by the author concerns antipodal necessity in degree at most three and the homogeneous cubic case (preprint, https://doi.org/10.6084/m9.figshare.34165260.v2). It is not used as a hypothesis here.

Section 2 specifies the family and spectral conventions. Section 3 derives the necessary conditions and affine reduction. Section 4 defines the certificates and their soundness. Section 5 composes the concrete refutations with the structural reduction. Section 6 discusses extensions, Section 7 identifies the data, and Appendix C gives the exact formal interpretation.

'''
t=t[:start]+intro+t[end:]
t=t.replace('There are forty-three cyclic orbits of eight-element subsets, obtained by complementing the quartic support orbits. Rotation invariance makes one equation per orbit sufficient.', 'There are forty-three cyclic orbits of eight-element subsets, obtained by complementing the quartic support orbits. If $T=\\rho^r(S)$, rotation is a bijection from $V_S$ to $V_T$ and $f_c(\\rho^r x)=f_c(x)$, so the two restrictions have equal weight for every $c$. Their second weight bits, and hence their filter polynomials, coincide. Thus one equation per support orbit is sufficient.')
parity='''For this family the parity bit gives no additional constraint: each quartic monomial supported in $S$ takes value one on exactly $2^{8-4}=16$ inputs of $V_S$, so the sum of its values is zero in $\mathbb F_2$. The same holds for any sum of these monomials. The second weight bit is the first nontrivial divisibility condition used here.

'''
t=t.replace('For bits $t_x$,',parity+'For bits $t_x$,',1)
t=t.replace('Their full factors are displayed in Appendix B and supplied in `quartic_audit_2026_10_17/linear_law_certificates.json`; the filters are reconstructed from (3.2).','Their full factors are displayed in Appendix B; the filters are reconstructed from (3.2).')
t=t.replace('Multiplication and cancellation of equal monomials give (3.3), as checked in the formal filter linkage.','Multiplication and cancellation of equal monomials give (3.3). Such identities can be found by linear algebra in the span of the polynomials $Q_j$ and $c_vQ_j$; checking the displayed products is sufficient for the proof, independently of how they were found.')
t=t.replace('The explicit identities form part of the finite certificate.','The explicit identities form part of the finite certificate. Appendix B also derives the single-filter identity for $R_2$ directly from restricted weights.')
t=t.replace(r'\gamma C(y)',r'\gamma E_3(y)').replace('C&=y_0y_1y_2','E_3&=y_0y_1y_2')
# Complete sixteen-case calculation, including explicit rejection witnesses.
periodic=[]
for code in range(16):
 truth=[]
 for y in range(16):
  b=[y>>i&1 for i in range(4)]
  terms=[sum(b[i]*b[(i+1)%4] for i in range(4))%2,(b[0]*b[2]+b[1]*b[3])%2,sum(all(b[i] for i in range(4) if i!=s) for s in range(4))%2,int(y==15)]
  truth.append(sum((code>>i&1)*terms[i] for i in range(4))%2)
 ac=[sum(1-2*(truth[x]^truth[x^u]) for x in range(16)) for u in range(1,16)]
 bad=next(((u,ac[u-1]) for u in range(1,16) if ac[u-1]%3),None)
 periodic.append({'code':code,'truth_table':f'0x{sum(v<<i for i,v in enumerate(truth)):04x}','witness_u':bad[0] if bad else None,'autocorrelation':bad[1] if bad else None,'all_15_residues_zero':bad is None})
assert [d['code'] for d in periodic if d['all_15_residues_zero']]==[2,3,8,15]
table=['| Code | Tuple | Truth table | Rejection witness $u$ | $C_g(u)$ | Residue mod 3 |','|---:|---|---|---:|---:|---:|']
for d in periodic:
 code=d['code'];tupletext='$('+','.join(str(code>>i&1) for i in range(4))+')$'
 table.append(f"| {code} | {tupletext} | `{d['truth_table']}` | "+(f"{d['witness_u']} | {d['autocorrelation']} | {d['autocorrelation']%3} |" if d['witness_u'] else '--- | --- | all 15 are 0 |'))
st=t.index('Lemma 2.2 implies that every $C_g(u)$ is divisible by three.')
en=t.index('**Lemma 3.4.**',st)
t=t[:st]+'''Lemma 2.2 implies that every $C_g(u)$ is divisible by three. The following table performs the complete sixteen-case check. The truth-table integer has bit $y$ equal to $g(y)$; a direction $u$ is likewise encoded by its four binary coordinates. For every rejected tuple the table gives one nonzero residue. In each of the four surviving rows all fifteen nonzero directions have residue zero.

'''+ '\n'.join(table)+ '\n\nEach entry is obtained by evaluating (3.4) on the sixteen inputs and summing $(-1)^{g(y)+g(y+u)}$. Thus every tuple outside (3.6) has an explicit contradiction to (3.7). ∎\n\n'+t[en:]
(out/'PERIODIC_CLASSIFICATION_16_CASES.json').write_text(json.dumps(periodic,indent=2)+'\n',encoding='utf-8')
st=t.index('Write $q_{k,j}=Q_j')
en=t.index('The assertion proved by a refutation',st)
t=t[:st]+r'''Write $q_{k,j}=Q_j\circ\phi_k$. Exact substitution gives forty-three Boolean quadratic polynomials in thirty-six variables for each family. A state is a pair $(k,E)$, where $k\in\{0,1,2\}$ identifies the family and $E:\mathbb F_2^{36}\to\mathbb F_2^{36}$ is an affine map. The coordinate expressions of $E$ constitute its environment. The root of family $k$ is $(k,\mathrm{id})$. Its equations at a state are $q_{k,j}(E(z))=0$, and its observation is the forty-three-dimensional coefficient vector $\phi_k(E(z))$.

'''+t[en:]
t=t.replace('**Elimination.** A specified sum of the equations is $z_i+a(z)$, where $a$ is affine. Any common zero satisfies $z_i=a(z)$. Substitute this equality into the recorded environment and continue with the child refutation.',r'''**Elimination.** A specified sum of the current equations is $z_i+a(z)$, where $a$ is affine. Any common zero satisfies $z_i=a(z)$. Define $T_{i,a}(z)$ by replacing coordinate $i$ of $z$ with $a(z)$ and leaving the other coordinates unchanged. The child environment is $E\circ T_{i,a}$. At an assignment satisfying the equality, $T_{i,a}(z)=z$, so the child has exactly the same observation and satisfies the same equations at that assignment.''')
t=t.replace('**Branching.** For an affine $a$, use the two substitutions $z_i=a(z)$ and $z_i=a(z)+1$. Every assignment satisfies one of these two equalities. Both resulting states must have refutations.',r'''**Branching.** For an affine $a$, use children with environments $E\circ T_{i,a}$ and $E\circ T_{i,a+1}$. Every assignment satisfies exactly one of $z_i=a(z)$ and $z_i=a(z)+1$, so it is preserved by one of the two update maps. Both children must have refutations.

In the supplied concrete certificates, each chosen $a$ is independent of $z_i$, so these are ordinary variable eliminations or splits. The abstract soundness argument is more general and does not require that independence: the update map is defined even if $a$ contains $z_i$, and the equalities above still imply $T_{i,a}(z)=z$ in the appropriate child. Soundness is induction on a finite certificate; it does not assume that every possible update decreases a variable count.''')
t=t.replace('At an elimination node, the certified polynomial identity forces the substitution; the updated environment has the same value at the assignment, so the child applies.','At an elimination node, the polynomial identity forces the equality and therefore $T_{i,a}(z)=z$; the child applies to the same assignment in its composed environment.')
t=t.replace('The concrete instances are `H12CloudChart0.refutation`, `H12CloudChart1.refutation`, and `H12CloudChart2.refutation`. Each is a proof object of the refutation predicate described in Section 4. They are combined without an additional hypothesis in `H12Final.all_chart_refutations`.','Each concrete instance is a proof object of the refutation predicate in Section 4. The three instances are combined without an additional hypothesis; their exact names and sizes are recorded in Appendix C.')
t=t.replace('The concrete instances were checked in Lean 4.35.0 and composed with the general soundness and coverage theorems. The final axiom reports contain only the standard logical axioms `propext`, `Classical.choice`, and `Quot.sound`. The final theorem therefore does not assume the correctness of a certificate generator or a search result. Lean\'s proof architecture is described in [6]. Appendix C identifies the preserved sources and verification records.','The concrete instances were checked in Lean and composed with the general soundness and coverage theorems. The final theorem therefore does not assume the correctness of a certificate generator or a search result. Lean\'s proof architecture is described in [6]. Appendix C gives the formal definitions, logical dependencies and verification records.')
t=t.replace('(OpenAI Codex and Gemini)','(OpenAI Codex, Gemini and Claude)')
t=t.replace('Codex also assisted with programming and Lean formalization.','Codex also assisted with programming and Lean formalization; Claude was used for adversarial review.')
st=t.index('The result concerns degree four in twelve variables.')
en=t.index('## Appendix A:',st)
t=t[:st]+r'''The next parameter case requires new reductions. For sixteen variables there are 116 quartic cyclic coefficients, and rotation by four positions has order four rather than three. Consequently the modulo-three orbit descent in (3.7) does not transfer directly. One would need suitable necessary restrictions, an explicit cover of the resulting families and new refutations with their own soundness linkage.

Allowing lower-degree terms is a different problem: it changes both the restricted-weight polynomials and the periodic normal form. In particular, the antipodal quadratic $\sum_{i=0}^{5}x_ix_{i+6}$ is already bent, so a blanket nonexistence statement for all functions of degree at most four would be false. The role of homogeneity, rather than low degree of a restriction alone, must remain explicit in any extension.

## 7 Data availability

The exact mathematical source archive, independent certificate checker and verification records accompany this manuscript. The [verification repository](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification) preserves a [fixed preparation record](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/tree/1e0e052/research_updates/2026_10_21_preprint) and the [completed formal integration](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/tree/9be0d98/research_updates/2026_10_20_final_integration). Appendix C describes the formal interpretation and the supplementary files; detailed hashes and execution records are supplied with those files.

'''+t[en:]
# A direct example for the one-product identity, independently derived below.
exec((root.parents[1]/'work/audit_article_transcription.py').read_text().split('app_b=text.split')[0].replace("article=args.article or default","article=Path(r'"+str(base/'H12_preprint.md')+"')"),{'__name__':'article_basis_audit','__file__':str(root.parents[1]/'work/audit_article_transcription.py'),'__builtins__':__builtins__}) if False else None
# The numerical weights are computed from the orbit table, not copied from a certificate result.
orbreps=re.findall(r'\| (\d+) \| \$\\\{([0-9,]+)\\\}\$ \| (\d+) \|',t.split('## Appendix A:')[1].split('## Appendix B:')[0])
orbits=[{sum(1<<((int(i)+k)%12) for i in s.split(',')) for k in range(12)} for _,s,_ in orbreps]
points=[x for x in range(4096) if x&1755==x]
cols=[{x for x in points if sum(x&m==m for m in orb)%2} for orb in orbits]
assert all(len(v)%2==0 for v in cols)
assert [i for i,v in enumerate(cols) if len(v)%4==2]==[26,40,42]
assert all(len(cols[i]&cols[j])%2==0 for i in range(43) for j in range(i))
weights={i:len(cols[i]) for i in [26,40,42]}
example=r'''For a direct example, $Q_{42}$ uses $S=\{0,1,3,4,6,7,9,10\}$. Put $w_i=\operatorname{wt}(p_i|_{V_S})$ and $w_{ij}=|\operatorname{supp}(p_i|_{V_S})\cap\operatorname{supp}(p_j|_{V_S})|$. Counting the quartic supports on this eight-coordinate set gives $w_{26}=W26$, $w_{40}=W40$, $w_{42}=W42$; every other $w_i$ is divisible by four and every $w_{ij}$ is even. The weight identity for a sum, reduced modulo four, is

\[
\operatorname{wt}(f_c|_{V_S})\equiv\sum_i c_iw_i-2\sum_{i<j}c_ic_jw_{ij}\pmod4.
\]

It follows that $Q_{42}=c_{26}+c_{40}+c_{42}=R_2$. These counts can be checked by enumerating the 256 inputs of $V_S$ from Appendix A; they are supplied with the independent transcription check. The longer identities for $R_1$ and $R_3$ are polynomial certificates whose full factors are listed above.

'''.replace('W26',str(weights[26])).replace('W40',str(weights[40])).replace('W42',str(weights[42]))
t=t.replace('## Appendix C:',example+'## Appendix C:',1)
# Replace operational Appendix C by a structured mathematical interpretation.
st=t.index('## Appendix C:');refs=t[t.index('## References',st):]
defs=json.loads((out/'FORMAL_DEFINITIONS.json').read_text())
stats=json.loads((out/'CERTIFICATE_SIZE_AND_ENCODING_AUDIT.json').read_text())['charts']
app=r'''## Appendix C: Formal interpretation and certificate sizes

### C.1 What the formal theorem says

Inputs are natural numbers from 0 to 4095. Coordinate $i$ is bit $i$ of the input, with the least significant bit indexed by zero. In a coefficient word of type `BitVec 43`, bit $j$ is the coefficient of row $j$ of Appendix A. Bitwise AND tests monomial containment, XOR is addition in $\mathbb F_2$, and the orbit fold sums each distinct support once. The exact defining expressions are:

'''
for n in ['monomialValue','orbitValue','quarticFunction','derivativeSign','BentAC','total','sign','dotBits','character','walsh']:
 app+='```lean\n'+defs[n]['text']+'\n```\n\n'
app+=r'''The first three definitions are in namespace `H12`, the next two in `H12Descent`, and the remaining definitions in `H12Walsh`. The source list `quarticOrbits` is the explicit list of masks for the 43 orbits. The supplementary source-to-article audit compares each of those masks with the translates of the corresponding row of Appendix A, checks all 495 supports and checks that the expanded coefficient expression contains exactly the 43 matching index pairs. It does not infer the correspondence from similar names.

Proposition 2.1 is the mathematical representation argument using uniqueness of algebraic normal form. The final Lean module proves the concrete universal statement; it does not include an additional abstract theorem representing every arbitrary invariant algebraic normal form. The proof of Proposition 2.1 and the explicit source correspondence identify that concrete statement with Theorem 1.1.

### C.2 The three concrete refutations

The root proofs are `H12CloudChart0.refutation`, `H12CloudChart1.refutation` and `H12CloudChart2.refutation`; they are composed in `H12Final.all_chart_refutations`. The following counts were extracted from the reachable proof-constructor graphs in their certified sources, rather than estimated from module counts. All referenced nodes are reachable from the root, and all source hashes match the certified archive.

| Family (periodic code) | Nodes | Splits | Contradiction leaves | Terminal leaves | Terminal assignments |
|---|---:|---:|---:|---:|---:|
'''
for s,code in zip(stats,[2,3,8]): app+=f"| {s['chart']} ({code}) | {s['nodes']:,} | {s['split']:,} | {s['contradiction']:,} | {s['terminal']:,} | {s['terminal_assignments_with_multiplicity']:,} |\n"
app+='\nFor each root the maximum edge depth is 36 and the maximum number of split nodes along a path is 22. The largest terminal active-coordinate counts are respectively 7, 7 and 8. Terminal assignments are counted with multiplicity across terminal states; they are not asserted to be distinct coefficient vectors. Elimination-node counts are respectively '+', '.join(f"{s['eliminate']:,}" for s in stats)+'.\n\n'
app+='The separate four-root Python certificate has 67,658 nodes and checks 164,288 coefficient vectors at its solution leaves. Its counts are not counts of these three Lean trees and must not be added to the table. It includes the fourth initial case as contradictory.\n\n'
app+=r'''### C.3 Verification records and their limits

The original integration completed on 21 October 2026 using Lean 4.35.0. Its preparation directory is named for 20 October, when the integration work was organized; the directory date is not a claim that the final check finished that day. The integration uses the source commit identified in the supplementary records, with the two final modules checked by `leanchecker`. Axiom reports for `all_chart_refutations`, `no_bent_quartic`, `no_flat_quartic` and `walsh_witness` contain only `propext`, `Classical.choice` and `Quot.sound`, with neither `sorryAx` nor `ofReduceBool`.

The independent checker is a separate implementation. On the copy prepared for the first review, replay completed in approximately 139 seconds on one machine. A subsequent reviewer reported approximately 101 seconds on another machine. These are observations, not guarantees about review time or formal reconstruction. Assertions are part of the checker, so it must be run without Python's optimization flag.

The complete formal archive contains 2,091 distinct previously certified dependency modules and the two final modules. Its mathematical sources retain the certified hashes. A full fresh rebuild of the minimal Lake distribution packaging has not been performed during this editorial revision. Sources, final records, exact hashes and the source-to-article audit are supplied separately; temporary execution caches are not needed to preserve them.

'''
t=t[:st]+app+refs
(out/'H12_preprint.md').write_text(t,encoding='utf-8')
(out/'R2_RESTRICTED_WEIGHT_EXAMPLE.json').write_text(json.dumps({'support_mask':1755,'special_weights':weights,'other_basis_weights_mod4_zero':True,'all_pairwise_intersections_even':True,'basis_weights':[len(v) for v in cols]},indent=2)+'\n',encoding='utf-8')
print('REVISED_ARTICLE',len(t),'chars',len(abstract.split()),'abstract words')

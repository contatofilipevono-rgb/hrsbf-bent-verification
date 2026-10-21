from pathlib import Path
import re,json,hashlib

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'outputs/H12_preprint'
p=OUT/'H12_preprint.md'
text=p.read_text(encoding='utf-8')
assert '## Appendix C' not in text, 'Editorial revision already applied'
(OUT/'H12_before_editorial_review.md').write_text(text,encoding='utf-8')
text=text.replace('Bent Boolean functions have Walsh coefficients of constant absolute value and consequently attain maximum distance from the affine Boolean functions.', 'Bent Boolean functions have Walsh coefficients of constant absolute value and consequently attain maximum distance from the affine Boolean functions [5].')
text=text.replace('The distinction between a search and a certificate is useful here.', 'The contribution is a certified finite case of the conjecture, together with an explicit reduction that separates necessary structural conditions from the final exclusion. In dimension twelve, the quartic cyclic space already has $2^{43}$ elements. A certificate makes the logical coverage of that space inspectable without treating a reported search count as the proof.\n\nThe distinction between a search and a certificate is useful here.')
text=text.replace('There are forty-three cyclic orbits of eight-element subsets, obtained by complementing the quartic support orbits.', 'Only a necessary consequence of weight divisibility is retained in each $Q_S$: vanishing of its second binary digit. We do not assert that a common zero of these equations is bent.\n\nThere are forty-three cyclic orbits of eight-element subsets, obtained by complementing the quartic support orbits.')
text=text.replace('A refutation proves that no assignment satisfying these equations has a bent observed function. It is built from the following rules.', r'''The assertion proved by a refutation at this state is

\[
\forall z\in\mathbb F_2^{36},\quad
\bigl(q_{k,j}(E(z))=0\text{ for every }j\bigr)
\ \Longrightarrow\ \neg\operatorname{Bent}(f_{\phi_k(E(z))}).
\]

The certificate records the data needed to establish this assertion recursively, using the following rules.''')
text=text.replace('Every observation at that terminal is therefore non-bent.', 'The Walsh values are evaluated with exact integer arithmetic; no floating-point threshold or probabilistic rejection is used. Every observation at that terminal is therefore non-bent.')
start=text.index('The complete records identify the exact source, compiled objects, kernel logs, and certificate packages.')
end=text.index('### 5.2 Completion of the proof',start)
text=text[:start]+'''The concrete instances were checked in Lean 4.35.0 and composed with the general soundness and coverage theorems. The final axiom reports contain only the standard logical axioms `propext`, `Classical.choice`, and `Quot.sound`. The final theorem therefore does not assume the correctness of a certificate generator or a search result. Lean's proof architecture is described in [4]. Appendix C identifies the preserved sources and verification records.

'''+text[end:]
start=text.index('The source defines the forty-three support orbits concretely.')
end=text.index('### 5.3 Use of AI-assisted tools',start)
text=text[:start]+'''The concrete support orbits used by the formal theorem are the orbits in Appendix A. Their disjointness and coverage give the mathematical identification in Proposition 2.1. The implementation and source audit for this identification are described in Appendix C.

'''+text[end:]
start=text.index('The proof and audit records are available in the [verification repository]')
end=text.index('## Appendix A:',start)
text=text[:start]+'''The accompanying material provides two routes to verification: an independent replay of the finite certificate using standard Python, and the complete mathematical source archive for the formal proof. The former avoids a reconstruction of the Lean dependency graph; the latter preserves the exact sources of the kernel-checked result. Appendix C states their scope and reproduction requirements.

'''+text[end:]
appendix='''## Appendix C: Verification material and formal scope

The preserved Lean result is the universally quantified statement in Section 5.2, together with `no_flat_quartic` and `walsh_witness`. The final integration used Lean 4.35.0 at repository commit `344ab2e1b330d4a6be3f00603e9423db39cf3354` and completed on 21 October 2026. The final modules were checked with `leanchecker`. The reports for the combined refutations and three final consequences contain only `propext`, `Classical.choice`, and `Quot.sound`; neither `sorryAx` nor `ofReduceBool` occurs in these dependency reports.

The source explicitly defines the 43 support orbits and the coefficient-to-function map. Their independent source audit checks all 495 quartic supports. The final module does not add a separate abstract representation theorem for arbitrary algebraic normal forms: Proposition 2.1 states the mathematical identification with this concrete basis.

| Material | Purpose | Verification boundary |
|---|---|---|
| Article and appendices | Structural reductions and soundness argument | Includes all orbit representatives and linear-identity factors |
| Independent Python package | Checks affine decomposition and terminal Walsh witnesses | Separate four-root certificate; not a Lean proof |
| Complete Lean source archive | Preserves the formal argument and concrete root proofs | All 2093 mathematical sources match certified hashes |
| Final reports and logs | Identify the checked statements and logical dependencies | Records of the completed kernel integration |

The independent checker reconstructs the basis, necessary linear and periodic conditions, and polynomial substitutions, then checks the finite decomposition and the exact Walsh witnesses. Its four initial affine families include the analytically contradictory fourth case. Its node and solution counts are not counts for the three Lean root packages. On the copy prepared for this preprint, replay completed in approximately 139 seconds; this is an observed time on one machine, not a hardware-independent guarantee. Its assertions are part of the checker, so it must be run without Python's optimization flag.

The formal source archive contains the 2091 previously certified distinct dependency modules and the two final modules, `H12Fourier` and `H12Final`. Source hashes are compared with the certified records and import closure is checked. This module count describes package size; it is not a percentage of mathematical coverage. The archive includes minimal Lake packaging. A full fresh rebuild of that packaging has not been performed during preprint preparation. Such a rebuild can take hours and is distinct from replaying the compact independent certificate.

The [verification repository](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification) provides the preserved sources, audits and dependency pins. A [fixed record of the final evidence](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/tree/9be0d98/research_updates/2026_10_20_final_integration) identifies the completed integration. The source archive and compact verifier accompany this preprint as separate files, so their availability does not depend on temporary execution caches. The full final binary artifact is identified by SHA256

`2cc9b4aadfe6bfd5f89721b5a72f9768854f4d46c475763dd29953f8153b331c`.

'''
text=text.replace('## References',appendix+'## References')
text+='\n[5] Rothaus, O.S.: On “bent” functions. J. Combin. Theory Ser. A **20**, 300–305 (1976). https://doi.org/10.1016/0097-3165(76)90024-8\n'
# Use a first-citation ordering for numerical references.
mapping={5:1,1:2,2:3,3:4,4:5}
text=re.sub(r'\[(\d)\]',lambda m:'['+str(mapping[int(m.group(1))])+']',text)
refs=text.index('## References')
head=text[:refs];tail=text[refs:]
entries=re.findall(r'^\[\d\].*(?:\n(?!\[\d\]).*)*',tail,re.M)
if len(entries)!=5:
 entries=[line for line in tail.splitlines() if re.match(r'^\[\d\]',line)]
assert len(entries)==5
entries.sort(key=lambda s:int(re.match(r'\[(\d)\]',s).group(1)))
text=head+'## References\n\n'+'\n\n'.join(e.strip() for e in entries)+'\n'
p.write_text(text,encoding='utf-8')
src=(ROOT/'work/prepare_h12_preprint.py').read_text(encoding='utf-8')
chunk=src[src.index('def inline'):src.index("pkg=OUT/")]
exec(chunk,{'re':re,'text':text,'OUT':OUT})
print('Revised editorial exposition; mathematical identities and certified sources unchanged.')

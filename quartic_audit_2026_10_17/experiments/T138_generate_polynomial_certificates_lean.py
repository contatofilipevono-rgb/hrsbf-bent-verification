import sys,json,collections,math
from pathlib import Path
sys.path.insert(0,str(Path('outputs').resolve()))
from RODAR_H12_A100_GLOBAL import prepare
root=Path('outputs/hrsbf-bent-verification/quartic_audit_2026_10_17')
_,truth,eqs,_,_=prepare();cert=json.loads((root/'linear_law_certificates.json').read_text())
src='''import H12PeriodFour
import H12BooleanPolynomial
namespace H12Quadratic
open H12BooleanPolynomial
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option linter.unusedSimpArgs false
'''
polys=[]
def literal(xs):return '['+','.join(map(str,xs))+']'
for e,(_,constant,linear,rows) in enumerate(eqs):
 p=([0] if constant else [])+[1<<i for i in range(43) if linear>>i&1]+[(1<<i)|(1<<j) for i,row in enumerate(rows) for j in range(43) if row>>j&1]
 polys.append(p);src+=f'def m{e} : List Nat := '+literal(p)+'\n'
 src+=f'def q{e} (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m{e}\n'
for k,law in enumerate(cert['laws']):
 src+=f'def rm{k+1} : List Nat := '+literal([1<<i for i in law['indices']])+'\n'
 src+=f'def r{k+1} (c : BitVec 43) : Bool := evaluate 43 c.getLsbD rm{k+1}\n'
src+='def values (c : BitVec 43) : List Bool := ['+','.join(f'q{i} c' for i in range(43))+']\n'
src+='def Passes (c : BitVec 43) : Prop := ∀ i : Fin 43, (values c)[i.val]! = false\n'
def make_identity(tag,factors,expanded,target,target_definition):
 global src
 counts=collections.Counter(expanded);odd=[m for m,n in counts.items() if n%2]
 assert set(odd)==set(target)
 pairs=[m for m,n in sorted(counts.items()) for _ in range(n//2)]
 src+=f'def factors_{tag} : List (List Nat) := ['+','.join(factors)+']\n'
 src+=f'def expanded_{tag} : List Nat := factors_{tag}.flatten\n'
 src+=f'def target_{tag} : List Nat := '+target_definition+' ++ paired '+literal(pairs)+'\n'
 fuel=max(1,(max(len(expanded),len(target)+2*len(pairs))-1).bit_length())
 src+=f'theorem sorted_{tag} : H12Descent.sortFuel {fuel} expanded_{tag} = H12Descent.sortFuel {fuel} target_{tag} := by decide +kernel\n'
 src+=f'theorem identity_{tag} (c : BitVec 43) : evaluate 43 c.getLsbD expanded_{tag} = evaluate 43 c.getLsbD ('+target_definition+') := by\n'
 src+=f'  have h := evaluate_permutation 43 c.getLsbD (permutation_of_sorted expanded_{tag} target_{tag} {fuel} sorted_{tag})\n'
 src+=f'  simpa only [target_{tag}, evaluate_append, evaluate_paired, Bool.xor_false] using h\n'
for k,law in enumerate(cert['laws']):
 tag=f'r{k+1}';factors=[];expanded=[]
 for n,prod in enumerate(law['products']):
  e=prod['filter'];j=prod['multiplier_variable'];name=f'f_{tag}_{n}'
  body=f'm{e}' if j<0 else f'(m{e}.map (fun m => m ||| 2^{j}))'
  src+=f'def {name} : List Nat := {body}\n';factors.append(name)
  expanded += [m|(1<<j if j>=0 else 0) for m in polys[e]]
 make_identity(tag,factors,expanded,[1<<i for i in law['indices']],f'rm{k+1}')
 src+=f'theorem necessary_{tag} (c : BitVec 43) (h : Passes c) : r{k+1} c = false := by\n'
 for e in sorted({p['filter'] for p in law['products']}):src+=f'  have hq{e} : q{e} c = false := by have hh := h ⟨{e}, by decide⟩; exact hh\n'
 for n,prod in enumerate(law['products']):
  e=prod['filter'];j=prod['multiplier_variable'];name=f'f_{tag}_{n}'
  src+=f'  have hf{n} : evaluate 43 c.getLsbD {name} = false := by\n'
  if j<0:src+=f'    exact hq{e}\n'
  else:
   src+=f'    unfold {name}\n    rw [evaluate_multiply_variable 43 c.getLsbD m{e} {j} (by decide)]\n'
   src+=f'    change (q{e} c && c.getLsbD {j}) = false\n    rw [hq{e}]; rfl\n'
 src+=f'  have hz : evaluate 43 c.getLsbD expanded_{tag} = false := by\n'
 src+=f'    unfold expanded_{tag} factors_{tag}\n    rw [evaluate_flatten]\n'
 src+='    simp only [List.foldr_cons, List.foldr_nil, '+', '.join(f'hf{n}' for n in range(len(factors)))+', Bool.false_xor]\n'
 src+=f'  rw [identity_{tag}] at hz\n  exact hz\n#print axioms necessary_{tag}\n'
# The global short-product certificate is another finite monomial permutation.
raw=polys[30]+[1<<i for i in cert['laws'][0]['indices']]+[1<<i for i in cert['laws'][2]['indices']]+[1<<i for i in cert['laws'][1]['indices']]+[(1<<i)|(1<<42) for i in cert['laws'][1]['indices']]
src+='def rm2_times42 : List Nat := rm2.map (fun m => m ||| 2^42)\n'
make_identity('short',['m30','rm1','rm3','rm2','rm2_times42'],raw,[(1<<40)|(1<<42)],literal([(1<<40)|(1<<42)]))
src+='''theorem short_product_zero (c : BitVec 43) (h : Passes c) :
    (c.getLsbD 40 && c.getLsbD 42) = false := by
  have hq : q30 c = false := by have hh := h ⟨30, by decide⟩; exact hh
  have h1 := necessary_r1 c h
  have h2 := necessary_r2 c h
  have h3 := necessary_r3 c h
  have hm : evaluate 43 c.getLsbD rm2_times42 = false := by
    unfold rm2_times42
    rw [evaluate_multiply_variable 43 c.getLsbD rm2 42 (by decide)]
    change (r2 c && c.getLsbD 42) = false
    rw [h2]; rfl
  have hz : evaluate 43 c.getLsbD expanded_short = false := by
    unfold expanded_short factors_short
    rw [evaluate_flatten]
    change (q30 c ^^ (r1 c ^^ (r3 c ^^ (r2 c ^^ (evaluate 43 c.getLsbD rm2_times42 ^^ false))))) = false
    simp only [hq, h1, h2, h3, hm, Bool.false_xor]
  rw [identity_short] at hz
  have he : evaluate 43 c.getLsbD [5497558138880] = (c.getLsbD 40 && c.getLsbD 42) := by
    rw [evaluate_cons, evaluate_nil, Bool.xor_false]
    change monomial 43 c.getLsbD ((2^40) ||| (2^42)) = _
    rw [monomial_union, monomial_unit 43 c.getLsbD 40 (by decide),
      monomial_unit 43 c.getLsbD 42 (by decide)]
  rw [he] at hz
  exact hz
#print axioms short_product_zero
end H12Quadratic
'''
(root/'lean/H12Quadratic.lean').write_text(src,encoding='utf-8')
path=root/'lean/lakefile.toml';text=path.read_text()
if '"H12BooleanPolynomial"' not in text:text=text.replace('"H12Quadratic"]','"H12Quadratic", "H12BooleanPolynomial"]')
path.write_text(text)
print('generated',len(src))

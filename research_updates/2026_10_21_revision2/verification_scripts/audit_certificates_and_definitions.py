from pathlib import Path
import zipfile,re,json,ast,hashlib,sys
sys.setrecursionlimit(200000)
root=Path(__file__).resolve().parent
old=root.parents[1]/'outputs/H12_preprint'
out=root.parents[1]/'outputs/H12_revisao2'
if (root.parent/'H12_formal_sources.zip').exists(): old=out=root.parent
out.mkdir(parents=True,exist_ok=True)
sha=lambda b:hashlib.sha256(b).hexdigest()
with zipfile.ZipFile(old/'H12_formal_sources.zip') as z:
 hashes=json.loads(z.read('SOURCE_SHA256.json'))
 def source(n):
  b=z.read(n);assert sha(b)==hashes[n]
  return b.decode().replace('\r\n','\n').replace('\r','')
 p=source('H12PeriodFour.lean')
 orbit_def=re.search(r'^def quarticOrbits[^\n]*:=\s*(\[\[[\s\S]*?\]\])',p,re.M)
 orbits=ast.literal_eval(orbit_def.group(1))
 article=out/'H12_preprint.md' if (out/'H12_preprint.md').exists() else old/'H12_preprint.md'
 md=article.read_text(encoding='utf-8')
 rows=re.findall(r'\| (\d+) \| \$\\\{([0-9,]+)\\\}\$ \| (\d+) \|',md.split('## Appendix A:')[1].split('## Appendix B:')[0])
 assert len(rows)==len(orbits)==43
 for j,s,n in rows:
  inds=list(map(int,s.split(',')))
  masks={sum(1<<((i+k)%12) for i in inds) for k in range(12)}
  assert set(orbits[int(j)])==masks and len(masks)==int(n)
 full=p.split('def quarticFunction',1)[1].split('\ntheorem ',1)[0]
 terms=re.findall(r'c.getLsbD (\d+) && orbitValue \(quarticOrbits\[\((\d+) : Fin 43\).val\]!\) x',full)
 assert terms==[(str(i),str(i)) for i in range(43)]
 defs={}
 for module,names in [('H12PeriodFour.lean',['monomialValue','orbitValue','quarticFunction']),('H12Descent.lean',['derivativeSign','BentAC']),('H12Walsh.lean',['total','sign','dotBits','character','walsh'])]:
  s=source(module)
  for n in names:
   m=re.search(r'^def '+n+r'\b[\s\S]*?(?=\n(?:def|theorem|end|namespace|#print) |\Z)',s,re.M)
   assert m,(module,n)
   defs[n]={'module':module,'source_sha256':hashes[module],'text':m.group().strip()}
 (out/'FORMAL_DEFINITIONS_EXACT.md').write_text('# Exact definitions from the certified source archive\n\nCoordinate i is bit i (least significant bit has index zero). The listing normalizes line endings for display; source hashes refer to the original certified bytes.\n\n'+'\n\n'.join('## '+n+' — '+d['module']+'\n\n```lean\n'+d['text']+'\n```' for n,d in defs.items()),encoding='utf-8')
 fast=source('H12AffineFastState.lean')
 induction=fast.split('inductive Refutes',1)[1].split('theorem refutes_sound',1)[0]
 assert 'a.testBit' not in induction
 stats=[]
 for chart in range(3):
  nodes={};active={};source_pins={};pivot_dependent=[]
  for n in z.namelist():
   if not re.fullmatch('H12CloudChart'+str(chart)+r'Proof\d+\.lean',n):continue
   s=source(n);source_pins[n]=hashes[n]
   for m in re.finditer(r'^theorem ref(\d+)\b([\s\S]*?)(?=\ntheorem |\nend |\Z)',s,re.M):
    node=int(m.group(1));body=m.group(2)
    assert node not in nodes
    children=list(map(int,re.findall(r'exact ref(\d+)',body)))
    kind='terminal' if '.terminal ' in body else 'eliminate' if 'Refutes.eliminate ' in body else 'split' if 'Refutes.split ' in body else 'contradiction' if '.contradiction ' in body else None
    assert kind,(chart,node,body[:300])
    assert len(children)=={'terminal':0,'contradiction':0,'eliminate':1,'split':2}[kind],(chart,node,kind,children)
    if kind in ['eliminate','split']:
     mm=re.search(r'Refutes\.'+kind+r' env\d+ (\d+) (\d+)',body);assert mm
     i,a=map(int,mm.groups())
     if a>>(i+1)&1:pivot_dependent.append(node)
    nodes[node]={'kind':kind,'children':children}
  for n in z.namelist():
   if not re.fullmatch('H12CloudChart'+str(chart)+r'Data\d+\.lean',n):continue
   s=source(n)
   for m in re.finditer(r'^def active(\d+)\s*: List Nat := (\[[^\n]*\])',s,re.M):
    node=int(m.group(1));a=ast.literal_eval(m.group(2));assert len(a)==len(set(a))
    active[node]=a
  visited=set();visiting=set();memo={}
  def walk(n):
   if n in memo:return memo[n]
   assert n not in visiting and n in nodes
   visiting.add(n);visited.add(n)
   kind=nodes[n]['kind'];children=nodes[n]['children']
   vals=[walk(c) for c in children]
   value=(1+max([v[0] for v in vals],default=-1),(1 if kind=='split' else 0)+max([v[1] for v in vals],default=0))
   visiting.remove(n);memo[n]=value;return value
  depth,split_depth=walk(0);assert len(visited)==len(nodes)
  kinds={k:sum(v['kind']==k for v in nodes.values()) for k in ['eliminate','split','contradiction','terminal']}
  terminals=[n for n,d in nodes.items() if d['kind']=='terminal'];assert all(n in active for n in terminals)
  stats.append({'chart':chart,'nodes':len(nodes),**kinds,'max_edge_depth':depth,'max_branching_depth':split_depth,'terminal_assignments_with_multiplicity':sum(1<<len(active[n]) for n in terminals),'max_terminal_active_coordinates':max(map(lambda n:len(active[n]),terminals)),'pivot_dependent_rhs_nodes':len(pivot_dependent),'proof_source_files':len(source_pins),'proof_source_manifest_sha256':sha(json.dumps(source_pins,sort_keys=True).encode())})
  print('CHART_STATS',stats[-1],flush=True)
 audit={'status':'PASS_CERTIFIED_SOURCE_GRAPH_AND_ARTICLE_ORBIT_LINK','article_sha256':sha(article.read_bytes()),'quartic_orbits_matched':43,'quartic_supports_matched':495,'coefficient_terms_matched':43,'formal_sources_changed':False,'new_lean_execution':False,'general_soundness_requires_pivot_independence':False,'charts':stats}
 (out/'CERTIFICATE_SIZE_AND_ENCODING_AUDIT.json').write_text(json.dumps(audit,indent=2)+'\n',encoding='utf-8')
 (out/'FORMAL_DEFINITIONS.json').write_text(json.dumps(defs,indent=2)+'\n',encoding='utf-8')
print(audit['status'])

from pathlib import Path
import json,csv,shutil,subprocess,re,time,sys
source=Path('outputs/hrsbf-bent-verification/quartic_audit_2026_10_17').resolve()
base=Path('work/h12_adversarial_mutations').resolve();base.mkdir(exist_ok=True)
assert base.is_relative_to(Path('work').resolve())
tests=[]
def prepare(name):
 root=base/name;(root/'cpu_replay').mkdir(parents=True,exist_ok=True)
 for rel in ['verify_linear_laws.py','verify_periodic_reduction.py','linear_law_certificates.json',
             'cpu_replay/verify_model.py','cpu_replay/verify_certificate.py','cpu_replay/model.json','cpu_replay/model_data.h']:
  shutil.copy2(source/rel,root/rel)
 return root
def mutate_json(path,change):
 data=json.loads(path.read_text());change(data);path.write_text(json.dumps(data))
def run(name,root,script):
 t=time.time();result=subprocess.run([sys.executable,script],cwd=root,capture_output=True,text=True,encoding='utf-8',errors='replace',timeout=30)
 assert result.returncode!=0 and 'AssertionError' in result.stderr,(name,result.returncode,result.stderr)
 tests.append({'test':name,'status':'CORRUPTION_REJECTED','seconds':round(time.time()-t,3)})
 print(name,'REJECTED',flush=True)

r=prepare('wrong_chart_mask');mutate_json(r/'cpu_replay/model.json',lambda d:d['masks'].__setitem__(0,d['masks'][0]^1));run('wrong_chart_mask',r,'cpu_replay/verify_model.py')
r=prepare('missing_periodic_case');mutate_json(r/'cpu_replay/model.json',lambda d:d['charts'][3].__setitem__('case',8));run('missing_periodic_case',r,'cpu_replay/verify_model.py')
r=prepare('false_transformed_constant');mutate_json(r/'cpu_replay/model.json',lambda d:d['charts'][0]['quadratic_filters'][0].__setitem__('constant',1^d['charts'][0]['quadratic_filters'][0]['constant']));run('false_transformed_constant',r,'cpu_replay/verify_model.py')
r=prepare('embedded_header_changed');path=r/'cpu_replay/model_data.h';text=path.read_text();text=re.sub(r'(OFFSET\[4\]=\{)(\d+)ULL',lambda m:m[1]+str(int(m[2])^1)+'ULL',text,count=1);path.write_text(text);run('embedded_header_changed',r,'cpu_replay/verify_model.py')
r=prepare('linear_witness_removed');mutate_json(r/'linear_law_certificates.json',lambda d:d['laws'][0].__setitem__('products',[]));run('linear_witness_removed',r,'cpu_replay/verify_model.py')
r=prepare('basis_not_rotation_orbit');mutate_json(r/'linear_law_certificates.json',lambda d:d['basis'][0].__setitem__(0,d['basis'][0][0]^1));run('basis_not_rotation_orbit',r,'cpu_replay/verify_model.py')
for name,kind in [('false_solution_leaf','solutions'),('cyclic_certificate','split')]:
 r=prepare(name)
 nodes=[{'linear_steps':[],'kind':kind,'dimension':36,'form':'0x1','children':[0,1]}]+[{'linear_steps':[],'kind':'solutions','dimension':36} for _ in range(3)]
 (r/'cpu_replay/DECOMPOSITION.json').write_text(json.dumps({'format':'boolean-quadratic-affine-split-v1','roots':[0,1,2,3],'nodes':nodes}))
 (r/'cpu_replay/full_thread0.csv').write_text('chart,free_coefficient,original_coefficient,witness_frequency,walsh_value\n')
 run(name,r,'cpu_replay/verify_certificate.py')
r=prepare('wrong_walsh_witnesses');shutil.copy2(source/'cpu_replay/DECOMPOSITION.json',r/'cpu_replay/DECOMPOSITION.json')
for path in (source/'cpu_replay').glob('full_thread*.csv'):
 with path.open(newline='') as inp,(r/'cpu_replay'/path.name).open('w',newline='') as out:
  reader=csv.DictReader(inp);writer=csv.DictWriter(out,fieldnames=reader.fieldnames);writer.writeheader()
  for row in reader:row['walsh_value']=str(int(row['walsh_value'])+2);writer.writerow(row)
run('wrong_walsh_witnesses',r,'cpu_replay/verify_certificate.py')
report={'status':'PASS_ALL_DELIBERATE_CORRUPTIONS_REJECTED','tests':tests,
 'scope':'Mutation tests strengthen implementation validation; they do not replace a Lean soundness proof.'}
(source/'cpu_replay/ADVERSARIAL_MUTATION_TESTS.json').write_text(json.dumps(report,indent=2))
print('PASS',len(tests),flush=True)

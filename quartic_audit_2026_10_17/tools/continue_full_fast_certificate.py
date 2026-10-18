"""Resume the three concrete chart proofs, then verify their global conclusion.
Requires the completed coefficient-label index. Runs one library at a time and
does not publish anything. Generated sources and partial module passes do not
establish a global theorem.
"""
from pathlib import Path
import argparse,hashlib,json,os,subprocess,sys,time,re

def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--lake',default='lake');p.add_argument('--chunk-size',type=int,default=1200);p.add_argument('--proof-chunk-size',type=int,default=600);args=p.parse_args()
 if args.chunk_size<1 or args.proof_chunk_size<1:raise SystemExit('Chunk sizes must be positive.')
 root=Path(__file__).resolve().parent.parent;reports=root/'reports';lean=root/'lean'
 def checked_report(filename,library,final):
  r=json.loads((reports/filename).read_text());assert r['status']=='PASS_ENTIRE_SELECTED_LIBRARY_KERNEL_REPLAY',filename
  assert r['library']==library and r['final_module']==final,filename
  assert r['modules_total']==r['modules_verified']==len(r['results']),filename
  for name,sha in r['dependencies'].items():assert hashlib.sha256((lean/(name+'.lean')).read_bytes()).hexdigest()==sha,(filename,name)
  for e in r['results']:
   assert e['build_exit_code']==e['kernel_exit_code']==0,(filename,e['module'])
   assert e['source_sha256']==r['dependencies'][e['module']]
   for phase in ['build','kernel']:
    text=(reports/('sequential_'+r['library'])/(e['module']+'_'+phase+'.log')).read_text(encoding='utf-8')
    assert not any(s in text for s in ['sorryAx','ofReduceBool','error:']),(filename,e['module'],phase)
  return r
 checked_report('LEAN_WITNESS_LABEL_INDEX_AUDIT.json','H12WitnessLabelIndexCertificate','H12GlobalWitnessIndex')
 journal=reports/'FULL_FAST_CERTIFICATE_PROGRESS.json';state={'status':'RUNNING','process_id':os.getpid(),'stage':'prepare','unconditional_global_theorem_verified':False,'charts':{},'note':'Last recorded state. Process liveness must be checked separately; partial passes do not establish root coverage.'}
 def save():
  state['updated_at_unix']=time.time();temp=journal.with_suffix('.tmp');temp.write_text(json.dumps(state,indent=2));temp.replace(journal)
 def run(command,stage,log=None):
  state['stage']=stage;save();print(stage,flush=True)
  if log:
   with (reports/log).open('w',encoding='utf-8') as out:r=subprocess.run(command,cwd=root,stdout=out,stderr=subprocess.STDOUT)
  else:r=subprocess.run(command,cwd=root)
  if r.returncode:raise RuntimeError(stage+' exited '+str(r.returncode))
 try:
  for chart,node in [(2,53430),(1,26715),(0,0)]:
   prefix=f'H12GlobalChart{chart}'
   run([sys.executable,'tools/generate_lean_affine_pilot.py','--chart',str(chart),'--node',str(node),'--prefix',prefix,'--root-frame','--engine','H12AffineFastState','--global-label-index','--chunk-size',str(args.chunk_size),'--proof-chunk-size',str(args.proof_chunk_size),'--register'],'generate_'+prefix,prefix+'_generation.log')
   filename=f'LEAN_GLOBAL_CHART{chart}_AUDIT.json'
   run([sys.executable,'tools/verify_lean_sequential_library.py','--lake',args.lake,'--library',prefix+'Certificate','--report',filename,'--resume'],'verify_'+prefix)
   r=checked_report(filename,prefix+'Certificate',prefix);state['charts'][str(chart)]={'status':r['status'],'modules':r['modules_verified'],'final_module':r['final_module']};save()
  target='''import H12GlobalChart0
import H12GlobalChart1
import H12GlobalChart2
namespace H12Global
theorem no_bent : ∀ c : BitVec 43, ¬H12Descent.BentAC (H12.quarticFunction c) := by
  apply H12AffineFastState.no_bent_of_affine_state_refutations
  intro k
  rcases k with ⟨k, hk⟩
  match k with
  | 0 => exact H12GlobalChart0.refutation
  | 1 => exact H12GlobalChart1.refutation
  | 2 => exact H12GlobalChart2.refutation
  | n+3 => omega
#print axioms no_bent
end H12Global
'''
  (lean/'H12Global.lean').write_text(target,encoding='utf-8');config=lean/'lakefile.toml';text=config.read_text(encoding='utf-8')
  if 'name = "H12GlobalCertificate"' not in text:config.write_text(text.rstrip()+'\n\n[[lean_lib]]\nname = "H12GlobalCertificate"\nroots = ["H12Global"]\n',encoding='utf-8')
  run([sys.executable,'tools/verify_lean_sequential_library.py','--lake',args.lake,'--library','H12GlobalCertificate','--report','LEAN_GLOBAL_AUDIT.json','--resume'],'verify_global_conclusion')
  r=checked_report('LEAN_GLOBAL_AUDIT.json','H12GlobalCertificate','H12Global');assert r['modules_verified']==1
  text=(reports/'sequential_H12GlobalCertificate/H12Global_build.log').read_text(encoding='utf-8')
  printed=re.findall(r"'H12Global\.no_bent' depends on axioms: \[([^\]]*)\]",text);assert len(printed)==1,'Missing unambiguous final axiom audit'
  axioms={x.strip() for x in printed[0].split(',') if x.strip()};assert axioms<={'propext','Classical.choice','Quot.sound'},axioms
  state.update(status='PASS_GLOBAL_CONCLUSION_KERNEL_REPLAY',unconditional_global_theorem_verified=True,global_axioms=sorted(axioms));save();print(state['status'],flush=True)
 except BaseException as error:
  state.update(status='INTERRUPTED' if isinstance(error,KeyboardInterrupt) else 'FAILED_REQUIRES_REVIEW',error=str(error));save();raise

if __name__=='__main__':main()

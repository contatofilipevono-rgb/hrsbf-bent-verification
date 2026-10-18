"""Check source hashes and successful replay-log coverage for the saved checkpoint.
This audits the recorded evidence. To rerun the mathematical checks, use the Lean
verification tools; this script is not a replacement for Lean's kernel.
"""
from pathlib import Path
import json,hashlib,tomllib,re,argparse


def code_without_comments(text):
 out=[];i=0;depth=0;quoted=False
 while i<len(text):
  if depth:
   if text.startswith('/-',i):depth+=1;i+=2
   elif text.startswith('-/',i):depth-=1;i+=2
   else:
    if text[i]=='\n':out.append('\n')
    i+=1
  elif quoted:
   if text[i]=='\\':i+=2
   elif text[i]=='"':quoted=False;i+=1
   else:i+=1
  elif text.startswith('/-',i):depth=1;i+=2
  elif text.startswith('--',i):
   end=text.find('\n',i);i=len(text) if end<0 else end
  elif text[i]=='"':quoted=True;i+=1
  else:out.append(text[i]);i+=1
 return ''.join(out)

def main():
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument('--exclude-library',action='append',default=[],help='Explicitly omit an unfinished development library; exclusions are recorded in the audit.')
 args=parser.parse_args()
 root=Path(__file__).resolve().parent.parent;project=root/'lean';reports=root/'reports';covered={};used=[]
 def source(name,sha):
  file=project/(name+'.lean');assert hashlib.sha256(file.read_bytes()).hexdigest()==sha,('source hash',name)
 def clean(path):
  s=path.read_text(encoding='utf-8');assert not any(x in s for x in ['sorryAx','ofReduceBool','error:']),path
  return s
 def record(name,evidence):covered.setdefault(name,[]).append(evidence)
 primary=json.loads((reports/'LEAN_PRIMARY_SOURCE_HASHES.json').read_text());log=clean(reports/primary['kernel_log']);assert 'KERNEL_REPLAY_EXIT_CODE=0' in log
 for name,sha in primary['modules'].items():source(name,sha);assert 'MODULE_PASS '+name+' ' in log;record(name,primary['kernel_log'])
 witness=json.loads((reports/'LEAN_WITNESS_KERNEL_AUDIT.json').read_text());assert witness['status']=='PASS_ALL_WALSH_REJECTIONS_KERNEL_CHECKED' and len(witness['results'])==42
 for name,sha in witness['dependencies'].items():source(name,sha)
 for r in witness['results']:
  name=r['module'];assert r['build_exit_code']==r['kernel_exit_code']==0;source(name,r['source_sha256'])
  for phase in ['build','kernel']:clean(reports/'witness_kernel'/(name+'_'+phase+'.log'))
  record(name,'LEAN_WITNESS_KERNEL_AUDIT.json')
 for filename,module,logname in [('LEAN_PACKED_AUDIT.json','H12PackedPolynomial','PACKED_GENERIC_KERNEL.log'),('LEAN_PACKED_ROOTS_AUDIT.json','H12PackedRoots','PACKED_ROOTS_KERNEL.log')]:
  r=json.loads((reports/filename).read_text());assert r['status'].startswith('PASS');source(module,r['source_sha256']);clean(reports/logname);record(module,filename)
 r=json.loads((reports/'LEAN_PACKED_PILOT_AUDIT.json').read_text());assert r['status']=='PASS_SUBTREE_18_KERNEL_REPLAY'
 for name,sha in r['sources'].items():
  source(name,sha)
  if name.startswith('H12PackedPilot'):assert r['kernel_'+name+'_exit_code']==0;clean(reports/'packed_pilot'/('kernel_'+name+'.log'));record(name,'LEAN_PACKED_PILOT_AUDIT.json')
 r=json.loads((reports/'LEAN_PACKED_TERMINAL_AUDIT.json').read_text());assert r['status'].startswith('PASS')
 for e in r['results']:source(e['module'],e['source_sha256']);assert e['kernel_exit_code']==0;clean(reports/(e['module']+'_KERNEL.log'));record(e['module'],'LEAN_PACKED_TERMINAL_AUDIT.json')
 extensionReports=['LEAN_MIXED_EXTENSION_AUDIT.json','LEAN_MIXED_WIDE_AUDIT.json','LEAN_AFFINE_PILOT_AUDIT.json','LEAN_AFFINE_WIDE_AUDIT.json','LEAN_AFFINE_ROOT_FRAME_AUDIT.json','LEAN_AFFINE_CANONICAL_PILOT_AUDIT.json','LEAN_EMPTY_CHART_AUDIT.json','LEAN_ROW_THEORY_AUDIT.json','LEAN_ROW_SCAN_THEORY_AUDIT.json']
 for filename in extensionReports:
  r=json.loads((reports/filename).read_text());assert r['status']=='PASS_SELECTED_LIBRARIES_KERNEL_REPLAY',filename
  for name,sha in r['dependencies'].items():source(name,sha)
  for name in r['modules']:
   assert any(e['step']=='kernel_'+name and e['exit_code']==0 for e in r['results']);clean(reports/'extensions'/('kernel_'+name+'.log'));record(name,filename)
 for filename in ['LEAN_ROW_ROOT_PILOT_AUDIT.json','H12RowScanPilot_KERNEL_AUDIT.json','H12RowScanEmptyChart_KERNEL_AUDIT.json']:
  r=json.loads((reports/filename).read_text());assert r['status']=='PASS_ENTIRE_SELECTED_LIBRARY_KERNEL_REPLAY',filename
  assert r['modules_verified']==r['modules_total']==len(r['results']),filename
  for name,sha in r['dependencies'].items():source(name,sha)
  for e in r['results']:
   name=e['module'];source(name,e['source_sha256']);assert e['build_exit_code']==e['kernel_exit_code']==0
   for phase in ['build','kernel']:clean(reports/('sequential_'+r['library'])/(name+'_'+phase+'.log'))
   record(name,filename)
 config=tomllib.loads((project/'lakefile.toml').read_text(encoding='utf-8'))
 assert set(args.exclude_library)<={lib['name'] for lib in config['lean_lib']},'Unknown library exclusion'
 expected={m for lib in config['lean_lib'] if lib['name'] not in args.exclude_library for m in lib['roots']};assert set(covered)==expected,(sorted(expected-set(covered)),sorted(set(covered)-expected))
 for name in expected:
  code=(project/(name+'.lean')).read_text(encoding='utf-8');assert not re.search(r'\bsorry\b|^\s*axiom\s|\bnative_decide\b|\bbv_decide\b',code_without_comments(code),re.M),name
 result={'status':'PASS_SOURCE_HASHES_AND_REPLAY_LOG_COVERAGE','modules':len(expected),'primary_modules':28,'witness_modules':42,'witnesses':164288,'module_evidence':covered,'unconditional_global_H12_theorem':False,'largest_tested_connected_subtree_nodes':21,'note':'The subtree pilots overlap; do not add their node or candidate counts. Log/source audit does not replace independent kernel replay.'}
 result['excluded_unfinished_libraries']=args.exclude_library
 (reports/'LEAN_CHECKPOINT_COVERAGE.json').write_text(json.dumps(result,indent=2));print(result['status'],len(expected),'modules; global theorem still pending; excluded libraries:',args.exclude_library)

if __name__=='__main__':main()

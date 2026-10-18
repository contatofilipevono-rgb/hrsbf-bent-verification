from pathlib import Path
import subprocess,json,time,hashlib,argparse
parser=argparse.ArgumentParser(description='Replay the packed terminal bridge and concrete leaf12.');parser.add_argument('--lake',default='lake');args=parser.parse_args()
root=Path(__file__).resolve().parent.parent;project=root/'lean';lake=args.lake;results=[]
for module in ['H12PackedTerminal','H12WitnessIndex','H12ConcreteLeaf12']:
 start=time.perf_counter();file=root/'reports'/(module+'_KERNEL.log')
 with file.open('w',encoding='utf-8') as out:r=subprocess.run([lake,'env','leanchecker','--verbose',module],cwd=project,stdout=out,stderr=subprocess.STDOUT)
 text=file.read_text(encoding='utf-8');assert r.returncode==0 and not any(x in text for x in ['sorryAx','ofReduceBool','error:'])
 results.append({'module':module,'kernel_exit_code':r.returncode,'source_sha256':hashlib.sha256((project/(module+'.lean')).read_bytes()).hexdigest(),'seconds':time.perf_counter()-start});print('PASS',module,flush=True)
(root/'reports/LEAN_PACKED_TERMINAL_AUDIT.json').write_text(json.dumps({'status':'PASS_GENERIC_TERMINAL_AND_CONCRETE_LEAF12_KERNEL_REPLAY','scope':'Generic terminal bridge and one concrete 8-candidate leaf; no global tree coverage.','results':results},indent=2))

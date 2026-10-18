"""Build and replay Lean modules sequentially to keep memory use bounded."""
from pathlib import Path
import argparse,json,re,subprocess,sys,time


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--lake',default='lake',help='Path to the Lean 4.35.0 lake executable')
    parser.add_argument('--skip-build',action='store_true',help='Replay an already completed build')
    args=parser.parse_args()
    project=Path(__file__).resolve().parent.parent/'lean'
    roots=json.loads(re.search(r'roots\s*=\s*(\[[^\]]+\])',
                              (project/'lakefile.toml').read_text(encoding='utf-8')).group(1))
    def run(command):
        result=subprocess.run(command,cwd=project,capture_output=True,text=True,
                              encoding='utf-8',errors='replace')
        print(result.stdout,end='',flush=True)
        if result.stderr:print(result.stderr,end='',file=sys.stderr,flush=True)
        if result.returncode:raise SystemExit(result.returncode)
        return result.stdout
    version=run([args.lake,'env','lean','--version'])
    if '4.35.0' not in version:raise SystemExit('Expected Lean 4.35.0')
    if not args.skip_build:run([args.lake,'build'])
    for index,module in enumerate(roots,1):
        start=time.perf_counter()
        print(f'MODULE_START {index}/{len(roots)} {module}',flush=True)
        run([args.lake,'env','leanchecker','--verbose',module])
        print(f'MODULE_PASS {module} {time.perf_counter()-start:.3f}s',flush=True)
    print('KERNEL_REPLAY_EXIT_CODE=0',flush=True)


if __name__=='__main__':main()

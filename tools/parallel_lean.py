"""Six preparation shards, three ordered certificate chains, final kernel replay."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import tarfile
import time
import signal
import zipfile

ARCHIVE = Path('research_updates/2026_10_21_revision3/H12_formal_sources.zip')
DIGEST = '89aa7f8df2aaa20c9466955be9851f275ff20b2a1cb7aaf06c27cdea23caf6ac'
PROJECT = Path('parallel_build')
DEADLINE = time.monotonic() + 300 * 60

class SliceTimeout(RuntimeError):
    pass

def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()

def prepare():
    assert sha(ARCHIVE) == DIGEST, 'Formal source archive changed'
    PROJECT.mkdir(exist_ok=True)
    with zipfile.ZipFile(ARCHIVE) as z:
        assert all(Path(n).name == n for n in z.namelist()), 'Unsafe archive path'
        z.extractall(PROJECT)
    check_sources()

def check_sources():
    manifest = json.loads((PROJECT / 'SOURCE_SHA256.json').read_text())
    assert all(sha(PROJECT / n) == h for n, h in manifest.items()), 'Source digest mismatch'

def graph():
    return {p.stem: re.findall(r'^import\s+(\w+)', p.read_text(encoding='utf-8'), re.M)
            for p in PROJECT.glob('*.lean')}

def closure(g, roots):
    sys.setrecursionlimit(20000)
    done, active, order = set(), set(), []
    def visit(n):
        if n not in g or n in done:
            return
        assert n not in active, 'Cyclic import: ' + n
        active.add(n)
        for d in g[n]:
            visit(d)
        active.remove(n)
        done.add(n)
        order.append(n)
    for n in roots:
        visit(n)
    return order

def plan():
    g = graph()
    needed = closure(g, ['H12Final'])
    chains = [closure(g, ['H12CloudChart' + str(i)]) for i in range(3)]
    serial = {n for n in needed if re.fullmatch(r'H12CloudChart[012](?:(?:Proof|Data)\d+)?', n)}
    common = [n for n in needed if n not in serial and n != 'H12Final']
    assert all(not (set(closure(g, [n])) & serial) for n in common)
    # Greedy balancing of source bytes, including each target's import closure.
    shards, covered = [[] for _ in range(6)], [set() for _ in range(6)]
    sizes = {n: (PROJECT / (n + '.lean')).stat().st_size for n in needed}
    for n in sorted(common, key=lambda n: sizes[n], reverse=True):
        deps = set(closure(g, [n]))
        i = min(range(6), key=lambda i: sum(sizes[x] for x in covered[i] | deps))
        shards[i].append(n)
        covered[i].update(deps)
    assert set(common) == set().union(*map(set, shards))
    return {'common': shards, 'charts': [[n for n in c if n in serial] for c in chains],
            'module_count': len(needed), 'shard_module_counts': list(map(len, covered)),
            'archive_sha256': DIGEST}

def command(args, log):
    with log.open('w', encoding='utf-8') as out:
        run = subprocess.Popen(['lake'] + args, cwd=PROJECT, stdout=out,
                               stderr=subprocess.STDOUT, start_new_session=os.name != 'nt')
        try:
            run.wait(timeout=max(1, min(2700, DEADLINE - time.monotonic())))
        except subprocess.TimeoutExpired:
            if os.name != 'nt':
                os.killpg(run.pid, signal.SIGKILL)
            else:
                run.kill()
            run.wait()
            raise SliceTimeout('PARTIAL_TIMEOUT: checkpoint retained; no chart pass')
    content = log.read_text(encoding='utf-8', errors='replace')
    if run.returncode or any(t in content for t in ['sorryAx', 'ofReduceBool', 'error:']):
        print(content[-10000:], flush=True)
        raise RuntimeError('Lean verification failed: ' + str(args))

def unpack():
    for p in sorted(Path('incoming').glob('*.tar.gz')):
        with tarfile.open(p) as t:
            assert all(m.isfile() and m.name.startswith(('.lake/build/', 'evidence/')) and '..' not in Path(m.name).parts for m in t)
            for m in t:
                t.extract(m, PROJECT if m.name.startswith('.lake/') else Path.cwd(), filter='data')

def build(stage, index, max_modules=80):
    prepare()
    p = plan()
    Path('evidence').mkdir(exist_ok=True)
    (Path('evidence') / 'plan.json').write_text(json.dumps(p, indent=2))
    if stage == 'plan':
        print(json.dumps(p, indent=2))
        return
    version = subprocess.check_output(['lake', 'env', 'lean', '--version'], cwd=PROJECT, text=True)
    assert '4.35.0' in version
    if stage != 'common':
        unpack()
    if stage == 'final':
        for chart in range(3):
            report = json.loads(Path(f'evidence/chart{chart}/progress.json').read_text())
            assert report['status'] == 'PASS', 'All three chart roots must be fully verified'
    roots = p['common'][index] if stage == 'common' else p['charts'][index] if stage == 'chart' else ['H12Final']
    modules = closure(graph(), roots) if stage == 'common' else roots
    records = []
    evidence = Path('evidence') / (f'chart{index}' if stage == 'chart' else stage)
    evidence.mkdir(parents=True, exist_ok=True)
    progress = evidence / 'progress.json'
    prior = {}
    identity = {'archive': DIGEST, 'version': version, 'stage': stage, 'index': index,
                'checker': sha(Path(__file__))}
    if progress.exists():
        previous = json.loads(progress.read_text())
        if previous.get('identity') == identity:
            prior = {r['module']: r for r in previous.get('records', [])}
    def checkpoint(status, current=None):
        tmp = progress.with_suffix('.tmp')
        tmp.write_text(json.dumps({'identity': identity, 'status': status, 'current': current,
            'global_theorem_verified': status == 'PASS' and stage == 'final',
            'records': records}, indent=2))
        tmp.replace(progress)
    new_modules = 0
    complete = True
    for n in modules:
        artifact = PROJECT / '.lake/build/lib/lean' / (n + '.olean')
        old = prior.get(n)
        if stage != 'final' and old and artifact.exists() and old['olean_sha256'] == sha(artifact):
            valid = old['source_sha256'] == sha(PROJECT / (n + '.lean'))
            for phase in ['build', 'kernel']:
                log = evidence / (n + '-' + phase + '.log')
                valid = valid and log.exists() and old.get(phase + '_log_sha256') == sha(log)
            if valid:
                records.append(old)
                checkpoint('RUNNING')
                continue
        checkpoint('RUNNING', n)
        if time.monotonic() >= DEADLINE or (stage == 'chart' and new_modules >= max_modules):
            checkpoint('PARTIAL_TIME_LIMIT', n)
            complete = False
            break
        print('BUILD', stage, index, n, flush=True)
        try:
            command(['--no-cache', '--fail-fast', 'build', n], evidence / (n + '-build.log'))
            # Recheck every compiled target independently of the elaborator.
            command(['env', 'leanchecker', '--verbose', n], evidence / (n + '-kernel.log'))
        except SliceTimeout:
            checkpoint('PARTIAL_MODULE_TIMEOUT', n)
            complete = False
            break
        except Exception:
            checkpoint('INCOMPLETE_OR_FAILED', n)
            raise
        records.append({'module': n, 'source_sha256': sha(PROJECT / (n + '.lean')),
                        'olean_sha256': sha(artifact),
                        'build_log_sha256': sha(evidence / (n + '-build.log')),
                        'kernel_log_sha256': sha(evidence / (n + '-kernel.log'))})
        new_modules += 1
        checkpoint('RUNNING')
    check_sources()
    status = 'PASS' if complete else 'PARTIAL_SAVED'
    checkpoint(status)
    if stage != 'chart' and not complete:
        raise RuntimeError('Final verification incomplete')
    (evidence / 'result.json').write_text(json.dumps({'stage': stage, 'index': index,
        'status': status, 'global_theorem_verified': stage == 'final' and complete, 'records': records}, indent=2))
    Path('artifacts').mkdir(exist_ok=True)
    if stage != 'final':
        allowed = set(closure(graph(), roots)) if stage == 'common' else set(roots)
        with tarfile.open(Path('artifacts') / (stage + '-' + str(index) + '.tar.gz'), 'w:gz') as t:
            for f in (PROJECT / '.lake/build').rglob('*'):
                if f.is_file() and f.name.split('.')[0] in allowed:
                    t.add(f, arcname=f.relative_to(PROJECT).as_posix(), recursive=False)
            if stage == 'chart':
                for f in evidence.rglob('*'):
                    if f.is_file():
                        t.add(f, arcname=f.as_posix(), recursive=False)
    print(status, stage, index, 'verified', len(records), '/', len(modules), flush=True)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('stage', choices=['plan', 'common', 'chart', 'final'])
    parser.add_argument('--index', type=int, default=0)
    parser.add_argument('--max-modules', type=int, default=80)
    args = parser.parse_args()
    try:
        build(args.stage, args.index, args.max_modules)
    except Exception:
        if args.stage == 'chart' and (PROJECT / '.lake/build').exists():
            # Preserve useful objects even on a genuine compiler failure;
            # they cannot unlock the next slice because this job still fails.
            Path('artifacts').mkdir(exist_ok=True)
            with tarfile.open(Path('artifacts') / f'chart-{args.index}.tar.gz', 'w:gz') as t:
                for f in (PROJECT / '.lake/build').rglob('*'):
                    if f.is_file() and f.name.startswith(f'H12CloudChart{args.index}'):
                        t.add(f, arcname=f.relative_to(PROJECT).as_posix(), recursive=False)
                evidence = Path('evidence') / f'chart{args.index}'
                for f in evidence.rglob('*'):
                    if f.is_file():
                        t.add(f, arcname=f.as_posix(), recursive=False)
        raise

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
import zipfile

ARCHIVE = Path('research_updates/2026_10_21_revision3/H12_formal_sources.zip')
DIGEST = '89aa7f8df2aaa20c9466955be9851f275ff20b2a1cb7aaf06c27cdea23caf6ac'
PROJECT = Path('parallel_build')

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
        run = subprocess.run(['lake'] + args, cwd=PROJECT, stdout=out, stderr=subprocess.STDOUT)
    content = log.read_text(encoding='utf-8', errors='replace')
    if run.returncode or any(t in content for t in ['sorryAx', 'ofReduceBool', 'error:']):
        print(content[-10000:], flush=True)
        raise RuntimeError('Lean verification failed: ' + str(args))

def unpack():
    for p in sorted(Path('incoming').glob('*.tar.gz')):
        with tarfile.open(p) as t:
            assert all(m.isfile() and m.name.startswith('.lake/build/') and '..' not in Path(m.name).parts for m in t)
            t.extractall(PROJECT, filter='data')

def build(stage, index):
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
    roots = p['common'][index] if stage == 'common' else p['charts'][index] if stage == 'chart' else ['H12Final']
    modules = closure(graph(), roots) if stage == 'common' else roots
    records = []
    for n in modules:
        print('BUILD', stage, index, n, flush=True)
        command(['--no-cache', '--fail-fast', 'build', n], Path('evidence') / (n + '-build.log'))
        # Recheck every compiled target independently of the elaborator.
        command(['env', 'leanchecker', '--verbose', n], Path('evidence') / (n + '-kernel.log'))
        records.append({'module': n, 'source_sha256': sha(PROJECT / (n + '.lean')),
                        'olean_sha256': sha(PROJECT / '.lake/build/lib/lean' / (n + '.olean'))})
    check_sources()
    (Path('evidence') / 'result.json').write_text(json.dumps({'stage': stage, 'index': index,
        'status': 'PASS', 'global_theorem_verified': stage == 'final', 'records': records}, indent=2))
    Path('artifacts').mkdir(exist_ok=True)
    if stage != 'final':
        allowed = set(closure(graph(), roots)) if stage == 'common' else set(roots)
        with tarfile.open(Path('artifacts') / (stage + '-' + str(index) + '.tar.gz'), 'w:gz') as t:
            for f in (PROJECT / '.lake/build').rglob('*'):
                if f.is_file() and f.name.split('.')[0] in allowed:
                    t.add(f, arcname=f.relative_to(PROJECT).as_posix(), recursive=False)
    print('PASS', stage, index, flush=True)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('stage', choices=['plan', 'common', 'chart', 'final'])
    parser.add_argument('--index', type=int, default=0)
    args = parser.parse_args()
    build(args.stage, args.index)

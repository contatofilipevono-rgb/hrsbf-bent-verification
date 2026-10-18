"""Bounded, resumable build and kernel replay for a generated Lean chart.

Every imported project module is checked in dependency order. Reports from other
machines are not used as resume evidence. A partial slice never proves a chart.
"""
from pathlib import Path
import argparse, hashlib, json, os, platform, re, subprocess, time, tomllib

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def dependency_order(project, roots):
    order, done, active = [], set(), set()
    def visit(name):
        file = project / (name + '.lean')
        if name in done or not file.exists():
            return
        if name in active:
            raise ValueError('Cyclic import: ' + name)
        active.add(name)
        for dep in re.findall(r'^import\s+(\w+)', file.read_text(encoding='utf-8'), re.M):
            visit(dep)
        active.remove(name)
        done.add(name)
        order.append(name)
    # Generated files can form import chains longer than Python's default limit.
    import sys
    sys.setrecursionlimit(20000)
    for root in roots:
        visit(root)
    return order

def verify(project, roots, evidence, lake, seconds, module_timeout=2700, max_modules=0):
    order = dependency_order(project, roots)
    sources = {name: sha(project / (name + '.lean')) for name in order}
    version = subprocess.check_output([lake, 'env', 'lean', '--version'], cwd=project, text=True).strip()
    if '4.35.0' not in version:
        raise ValueError('Expected Lean 4.35.0: ' + version)
    fingerprint = hashlib.sha256(json.dumps({'sources': sources, 'version': version,
        'platform': platform.platform(), 'checker': sha(Path(__file__))}, sort_keys=True).encode()).hexdigest()
    evidence.mkdir(parents=True, exist_ok=True)
    logs = evidence / 'logs'
    logs.mkdir(exist_ok=True)
    reportfile = evidence / 'progress.json'
    prior = {}
    if reportfile.exists():
        old = json.loads(reportfile.read_text())
        if old.get('fingerprint') == fingerprint:
            prior = {r['module']: r for r in old['results']}
    report = {'status': 'RUNNING', 'root_coverage': False, 'unconditional_global_theorem': False,
        'roots': roots, 'sources': sources, 'fingerprint': fingerprint, 'lean_version': version,
        'modules_total': len(order), 'results': [],
        'scope': 'Build and independent Lean kernel replay; a partial dependency prefix proves no chart root.'}
    def save():
        report['modules_verified'] = len(report['results'])
        temp = reportfile.with_suffix('.tmp')
        temp.write_text(json.dumps(report, indent=2))
        temp.replace(reportfile)
    def reusable(name, record):
        if not record or record.get('source_sha256') != sources[name]:
            return False
        artifact = project / '.lake/build/lib/lean' / (name + '.olean')
        if not artifact.exists() or record.get('olean_sha256') != sha(artifact):
            return False
        for phase in ['build', 'kernel']:
            file = logs / (name + '_' + phase + '.log')
            if record.get(phase + '_exit_code') != 0 or not file.exists():
                return False
            if record.get(phase + '_log_sha256') != sha(file):
                return False
        return True
    started = time.monotonic()
    new_modules = 0
    save()
    for index, name in enumerate(order, 1):
        record = prior.get(name)
        if reusable(name, record):
            report['results'].append(record)
            continue
        if time.monotonic() - started >= seconds or (max_modules and new_modules >= max_modules):
            report['status'] = 'PARTIAL_TIME_SLICE'
            save()
            print(report['status'], len(report['results']), '/', len(order), flush=True)
            return report
        record = {'module': name, 'source_sha256': sources[name]}
        for phase, command in [('build', ['build', name]), ('kernel', ['env', 'leanchecker', '--verbose', name])]:
            # Keep enough time for the workflow to save evidence and its cache.
            remaining = seconds - (time.monotonic() - started)
            if remaining <= 0:
                report['status'] = 'PARTIAL_TIME_SLICE'
                save()
                return report
            print('START', index, '/', len(order), name, phase, flush=True)
            logfile = logs / (name + '_' + phase + '.log')
            try:
                with logfile.open('w', encoding='utf-8') as out:
                    run = subprocess.run([lake] + command, cwd=project, stdout=out,
                        stderr=subprocess.STDOUT, timeout=min(module_timeout, remaining))
            except subprocess.TimeoutExpired:
                report['status'] = 'PARTIAL_MODULE_TIMEOUT'
                report['incomplete_module'] = name
                report['incomplete_phase'] = phase
                save()
                return report
            text = logfile.read_text(encoding='utf-8')
            if run.returncode or any(token in text for token in ['sorryAx', 'ofReduceBool', 'error:']):
                report.update(status='FAILED', failed_module=name, failed_phase=phase)
                save()
                raise RuntimeError(name + ' ' + phase + ' failed; see saved log')
            record[phase + '_exit_code'] = run.returncode
            record[phase + '_log_sha256'] = sha(logfile)
        artifact = project / '.lake/build/lib/lean' / (name + '.olean')
        record['olean_sha256'] = sha(artifact)
        report['results'].append(record)
        new_modules += 1
        save()
        print('PASS', index, name, flush=True)
    report['status'] = 'PASS_CHART_DEPENDENCIES_AND_ROOT_KERNEL_REPLAY'
    report['root_coverage'] = True
    # This verifies one chart only, never the three-chart conclusion.
    save()
    return report

def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--chart', choices=['0', '1', '2'], default='2')
    p.add_argument('--minutes', type=int, default=180)
    p.add_argument('--lake', default='lake')
    p.add_argument('--max-modules', type=int, default=0)
    args = p.parse_args()
    if not 1 <= args.minutes <= 240 or args.max_modules < 0:
        raise SystemExit('Invalid execution limits')
    root = Path(__file__).resolve().parent.parent
    project = root / 'lean'
    prefix = 'H12CloudChart' + args.chart
    config = tomllib.loads((project / 'lakefile.toml').read_text(encoding='utf-8'))
    library = next(lib for lib in config['lean_lib'] if lib['name'] == prefix + 'Certificate')
    evidence = root / 'cloud_progress' / ('chart' + args.chart)
    result = verify(project, library['roots'], evidence, args.lake, args.minutes * 60,
                    max_modules=args.max_modules)
    print(result['status'], result['modules_verified'], '/', result['modules_total'])
    summary = os.environ.get('GITHUB_STEP_SUMMARY')
    if summary:
        with open(summary, 'a', encoding='utf-8') as out:
            out.write(f"### Lean: carta {args.chart}\n\nEstado: `{result['status']}`. "
                f"Módulos conferidos: {result['modules_verified']}/{result['modules_total']}.\n\n"
                f"Cobertura desta raiz: {result['root_coverage']}. Prova global: **pendente**.\n")

if __name__ == '__main__':
    main()

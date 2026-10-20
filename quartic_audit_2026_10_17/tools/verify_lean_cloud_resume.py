"""Resume checked Lean records across hosted-runner kernel/image updates.

Identity binds sources, requested roots, verifier policy and actual Lean binaries.
Host kernel descriptions are diagnostic only. Legacy migration requires an exact
externally audited progress.json digest; hashes and logs are still rechecked.
This coordinates prior kernel checks; it is not itself a Lean kernel.
"""
from pathlib import Path
import argparse
import hashlib
import json
import os
import platform
import re
import shutil
import subprocess
import sys
import time

from verify_lean_cloud_slice import dependency_order

SCHEMA = 2
COMPLETE = 'PASS_CHART_DEPENDENCIES_AND_ROOT_KERNEL_REPLAY'
PARTIAL = {'RUNNING', 'PARTIAL_TIME_SLICE', 'PARTIAL_MODULE_TIMEOUT'}
FORBIDDEN = ('sorryAx', 'ofReduceBool', 'error:')
RELEASE_SHA256 = '7289597a44543246c9227b8cae501767e095ce17f6d448b95fc4a8dc97268f6d'


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def require(condition, reason):
    if not condition:
        raise ValueError(reason)


def digest(value):
    return hashlib.sha256(json.dumps(value, sort_keys=True).encode()).hexdigest()


def toolchain_identity(project, lake):
    require(platform.system() == 'Linux' and platform.machine() == 'x86_64',
            'Production replay requires the pinned Linux x86_64 Lean release')
    lake_path = Path(shutil.which(str(lake)) or lake).resolve(strict=True)
    version = subprocess.check_output([str(lake_path), 'env', 'lean', '--version'],
                                      cwd=project, text=True).strip()
    require(re.match(r'^Lean \(version 4\.35\.0,', version) is not None,
            'Expected the exact Lean 4.35.0 release')
    # Resolve the executables in the very environment used by lake, not a guess
    # based on the runner's PATH or a version string alone.
    query = 'import json,shutil; print(json.dumps({n:shutil.which(n) for n in ["lean","leanchecker"]}))'
    paths = json.loads(subprocess.check_output(
        [str(lake_path), 'env', sys.executable, '-c', query], cwd=project, text=True))
    binaries = {'lake': sha(lake_path)}
    for name in ('lean', 'leanchecker'):
        require(paths.get(name), 'Missing pinned executable: '+name)
        binary = Path(paths[name]).resolve(strict=True)
        require(binary.parent == lake_path.parent, 'Unexpected Lean toolchain path: '+name)
        binaries[name] = sha(binary)
    archive = os.environ.get('LEAN_RELEASE_ARCHIVE', '')
    require(archive and Path(archive).is_file(), 'Missing verified Lean release archive')
    require(sha(archive) == RELEASE_SHA256, 'Lean release archive digest differs')
    release = lake_path.parent.parent
    libraries = {str(p.relative_to(release)): sha(p)
                 for p in sorted((release/'lib').rglob('*.so')) if p.is_file()}
    require(libraries, 'Missing Lean release shared libraries')
    return {'version': version, 'target': 'linux-x86_64',
            'release_archive_sha256': RELEASE_SHA256, 'binaries': binaries,
            'shared_libraries': libraries}


def verification_identity(sources, roots, toolchain):
    return {'schema': SCHEMA, 'sources': sources, 'roots': roots,
            'toolchain': toolchain,
            'policy_sha256': sha(__file__),
            'dependency_helper_sha256': sha(Path(__file__).with_name('verify_lean_cloud_slice.py'))}


def checked_prior(old, raw_sha256, identity, order, project, logs,
                  legacy_report_sha256=''):
    """Fail before changing saved evidence on any unexplained incompatibility."""
    require(isinstance(old, dict), 'Saved report must be an object')
    require(old.get('sources') == identity['sources'], 'Saved source manifest differs')
    require(old.get('roots') == identity['roots'], 'Saved requested roots differ')
    require(old.get('lean_version') == identity['toolchain']['version'], 'Saved Lean version differs')
    if old.get('schema_version') == SCHEMA:
        require(old.get('verification_identity') == identity, 'Saved verification identity differs')
        require(old.get('fingerprint') == digest(identity), 'Saved stable fingerprint differs')
        mode = 'stable_identity'
    else:
        require('schema_version' not in old, 'Unknown saved report schema')
        require(re.fullmatch(r'[0-9a-f]{64}', legacy_report_sha256 or '') is not None,
                'Legacy migration requires the audited progress.json SHA256')
        require(raw_sha256 == legacy_report_sha256, 'Legacy report differs from the audited checkpoint')
        require(re.fullmatch(r'[0-9a-f]{64}', old.get('fingerprint', '')) is not None,
                'Missing legacy environment fingerprint')
        mode = 'audited_legacy_digest'
    records = old.get('results')
    require(isinstance(records, list), 'Missing saved module records')
    require(type(old.get('modules_total')) is int and old['modules_total'] == len(order),
            'Saved module total differs')
    require(type(old.get('modules_verified')) is int and old['modules_verified'] == len(records),
            'Saved verified count differs')
    require(all(isinstance(r, dict) for r in records), 'Invalid saved module record')
    require([r.get('module') for r in records] == order[:len(records)] and len(records) <= len(order),
            'Saved records are not the exact dependency prefix')
    require(old.get('unconditional_global_theorem') is False, 'A slice cannot assert the global theorem')
    if old.get('status') == COMPLETE:
        require(old.get('root_coverage') is True and len(records) == len(order),
                'Inconsistent complete report')
    else:
        require(old.get('status') in PARTIAL and old.get('root_coverage') is False,
                'Failed or inconsistent saved report')
    for record in records:
        name = record['module']
        require(record.get('source_sha256') == identity['sources'][name], 'Changed source: '+name)
        artifact = project / '.lake/build/lib/lean' / (name+'.olean')
        require(artifact.is_file() and record.get('olean_sha256') == sha(artifact),
                'Missing or changed checked object: '+name)
        for phase in ('build', 'kernel'):
            require(type(record.get(phase+'_exit_code')) is int and record[phase+'_exit_code'] == 0,
                    'Unsuccessful saved phase: '+name+' '+phase)
            logfile = logs / (name+'_'+phase+'.log')
            require(logfile.is_file() and record.get(phase+'_log_sha256') == sha(logfile),
                    'Missing or changed checked log: '+name+' '+phase)
            require(not any(t in logfile.read_text(encoding='utf-8') for t in FORBIDDEN),
                    'Rejected evidence in checked log: '+name+' '+phase)
    return records, mode


def verify(project, roots, evidence, lake, seconds, module_timeout=2700,
           max_modules=0, legacy_report_sha256=''):
    project, evidence = Path(project), Path(evidence)
    require(roots and len(set(roots)) == len(roots), 'Empty or duplicate requested roots')
    require(all(re.fullmatch(r'[A-Za-z_]\w*', name) for name in roots), 'Invalid requested root')
    order = dependency_order(project, roots)
    require(set(roots) <= set(order), 'Requested root source is absent')
    sources = {name: sha(project/(name+'.lean')) for name in order}
    toolchain = toolchain_identity(project, lake)
    identity = verification_identity(sources, roots, toolchain)
    logs = evidence/'logs'
    reportfile = evidence/'progress.json'
    prior, mode, prior_sha = [], 'fresh', None
    prior_raw = None
    if reportfile.exists():
        prior_raw = reportfile.read_bytes()
        prior_sha = hashlib.sha256(prior_raw).hexdigest()
        prior, mode = checked_prior(json.loads(prior_raw), prior_sha, identity, order,
                                    project, logs, legacy_report_sha256)
    else:
        require(not legacy_report_sha256, 'Audited legacy report is absent from the restored cache')
    # Preflight above must pass before replacing the current progress record.
    logs.mkdir(parents=True, exist_ok=True)
    if prior_raw is not None:
        history = evidence/'history'
        history.mkdir(exist_ok=True)
        history_file = history/(prior_sha+'.json')
        if history_file.exists():
            require(history_file.read_bytes() == prior_raw, 'Changed saved report history')
        else:
            history_file.write_bytes(prior_raw)
    report = {'schema_version': SCHEMA, 'status': 'RUNNING', 'root_coverage': False,
              'unconditional_global_theorem': False, 'roots': roots, 'sources': sources,
              'verification_identity': identity, 'fingerprint': digest(identity),
              'lean_version': toolchain['version'], 'modules_total': len(order),
              'results': list(prior), 'modules_reused': len(prior), 'modules_verified_new': 0,
              'resume': {'mode': mode, 'source_report_sha256': prior_sha,
                         'restored_cache_key': os.environ.get('RESTORED_CACHE_KEY', '')},
              'execution_environment': {'platform': platform.platform(),
                                        'runner_image': os.environ.get('ImageVersion', '')},
              'scope': 'Build and Lean kernel replay, including hash-validated records from prior slices; a partial dependency prefix proves no chart root.'}

    def save():
        report['modules_verified'] = len(report['results'])
        temp = reportfile.with_suffix('.tmp')
        temp.write_text(json.dumps(report, indent=2)+'\n', encoding='utf-8')
        temp.replace(reportfile)

    started = time.monotonic()
    save()
    output = os.environ.get('GITHUB_OUTPUT')
    if output:
        with open(output, 'a', encoding='utf-8') as out:
            out.write('resume_preflight_passed=true\n')
    print('RESUME', mode, 'REUSED', len(prior), '/', len(order),
          'NEXT', order[len(prior)] if len(prior) < len(order) else 'complete', flush=True)
    for index, name in enumerate(order[len(prior):], len(prior)+1):
        if time.monotonic()-started >= seconds or (max_modules and report['modules_verified_new'] >= max_modules):
            report['status'] = 'PARTIAL_TIME_SLICE'
            save()
            return report
        record = {'module': name, 'source_sha256': sources[name]}
        for phase, command in [('build', ['build', name]), ('kernel', ['env', 'leanchecker', '--verbose', name])]:
            remaining = seconds-(time.monotonic()-started)
            if remaining <= 0:
                report['status'] = 'PARTIAL_TIME_SLICE'
                save()
                return report
            print('START', index, '/', len(order), name, phase, flush=True)
            logfile = logs/(name+'_'+phase+'.log')
            try:
                with logfile.open('w', encoding='utf-8') as out:
                    run = subprocess.run([lake]+command, cwd=project, stdout=out,
                                         stderr=subprocess.STDOUT,
                                         timeout=min(module_timeout, remaining))
            except subprocess.TimeoutExpired:
                report.update(status='PARTIAL_MODULE_TIMEOUT', incomplete_module=name,
                              incomplete_phase=phase)
                save()
                return report
            content = logfile.read_text(encoding='utf-8')
            if run.returncode or any(t in content for t in FORBIDDEN):
                report.update(status='FAILED', failed_module=name, failed_phase=phase)
                save()
                raise RuntimeError(name+' '+phase+' failed; see preserved log')
            record[phase+'_exit_code'] = run.returncode
            record[phase+'_log_sha256'] = sha(logfile)
        record['olean_sha256'] = sha(project/'.lake/build/lib/lean'/(name+'.olean'))
        report['results'].append(record)
        report['modules_verified_new'] += 1
        save()
        print('PASS', index, name, flush=True)
    report.update(status=COMPLETE, root_coverage=True)
    save()
    return report


def main():
    import tomllib
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--chart', choices=['0', '1'], required=True)
    p.add_argument('--minutes', type=int, default=180)
    p.add_argument('--lake', default='lake')
    p.add_argument('--max-modules', type=int, default=0)
    p.add_argument('--legacy-report-sha256', default='')
    args = p.parse_args()
    require(1 <= args.minutes <= 240 and args.max_modules >= 0, 'Invalid execution limits')
    root = Path(__file__).resolve().parent.parent
    project = root/'lean'
    config = tomllib.loads((project/'lakefile.toml').read_text(encoding='utf-8'))
    name = 'H12CloudChart'+args.chart+'Certificate'
    library = next(lib for lib in config['lean_lib'] if lib['name'] == name)
    evidence = root/'cloud_progress'/('chart'+args.chart)
    try:
        require((evidence/'progress.json').is_file(),
                'Restored cache has no progress report; refusing a silent fresh restart')
        result = verify(project, library['roots'], evidence, args.lake, args.minutes*60,
                        max_modules=args.max_modules, legacy_report_sha256=args.legacy_report_sha256)
    except Exception as error:
        evidence.mkdir(parents=True, exist_ok=True)
        (evidence/'resume_error.json').write_text(json.dumps(
            {'status':'RESUME_REJECTED_OR_EXECUTION_FAILED', 'error':str(error),
             'global_proof_complete':False}, indent=2)+'\n', encoding='utf-8')
        raise
    print(result['status'], result['modules_verified'], '/', result['modules_total'], flush=True)
    summary = os.environ.get('GITHUB_STEP_SUMMARY')
    if summary:
        with open(summary, 'a', encoding='utf-8') as out:
            out.write(f"### Carta {args.chart}: {result['status']}\n\n"
                      f"Módulos: {result['modules_verified']}/{result['modules_total']}; "
                      f"reutilizados: {result['modules_reused']}; novos: {result['modules_verified_new']}. "
                      f"Raiz: {result['root_coverage']}. Prova global: pendente.\n")


if __name__ == '__main__':
    main()


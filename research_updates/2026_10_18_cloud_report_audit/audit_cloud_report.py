"""Fail-closed structural audit of exported Lean chart progress.

This is not a Lean kernel and does not certify the mathematical statements.
Use it before accepting a workflow's claimed completion.
"""
from pathlib import Path
import argparse
import hashlib
import json
import re

COMPLETE = 'PASS_CHART_DEPENDENCIES_AND_ROOT_KERNEL_REPLAY'
PARTIAL = {'PARTIAL_TIME_SLICE', 'PARTIAL_MODULE_TIMEOUT', 'RUNNING'}

def audit(report, chart, logs=None):
    def require(condition, reason):
        if not condition:
            raise ValueError(reason)
    require(chart in (0, 1, 2), 'Invalid chart')
    require(isinstance(report, dict), 'Report must be an object')
    require(report.get('unconditional_global_theorem') is False, 'A chart report cannot assert the global theorem')
    root = 'H12CloudChart' + str(chart)
    roots = report.get('roots')
    sources = report.get('sources')
    results = report.get('results')
    require(isinstance(roots, list) and bool(roots), 'Empty or missing requested roots')
    require(all(isinstance(x, str) for x in roots), 'Invalid requested root')
    require(len(set(roots)) == len(roots), 'Duplicate requested roots')
    require(root in roots, 'Concrete chart root absent from requested roots')
    require(isinstance(sources, dict) and bool(sources), 'Empty source manifest')
    require(set(roots) <= set(sources), 'Requested root absent from source manifest')
    for name, digest in sources.items():
        require(isinstance(name, str) and re.fullmatch(r'[A-Za-z_]\w*', name) is not None, 'Invalid module name')
        require(isinstance(digest, str) and re.fullmatch(r'[0-9a-f]{64}', digest) is not None, 'Invalid source hash')
    require(isinstance(results, list), 'Missing module records')
    require(type(report.get('modules_total')) is int and report['modules_total'] == len(sources), 'Total count differs from source manifest')
    require(type(report.get('modules_verified')) is int and report['modules_verified'] == len(results), 'Verified count differs from records')
    names = []
    for record in results:
        require(isinstance(record, dict), 'Invalid module record')
        name = record.get('module')
        require(isinstance(name, str) and name in sources, 'Unknown verified module')
        require(name not in names, 'Duplicate verified module')
        names.append(name)
        require(record.get('source_sha256') == sources[name], 'Module source hash mismatch')
        require(isinstance(record.get('olean_sha256'), str) and re.fullmatch(r'[0-9a-f]{64}', record['olean_sha256']) is not None, 'Missing object hash')
        for phase in ('build', 'kernel'):
            require(type(record.get(phase+'_exit_code')) is int and record[phase+'_exit_code'] == 0, 'Unsuccessful phase counted as verified')
            digest = record.get(phase+'_log_sha256')
            require(isinstance(digest, str) and re.fullmatch(r'[0-9a-f]{64}', digest) is not None, 'Missing phase log hash')
            if logs is not None:
                path = Path(logs)/(name+'_'+phase+'.log')
                require(path.is_file(), 'Missing phase log: '+str(path))
                raw = path.read_bytes()
                require(hashlib.sha256(raw).hexdigest() == digest, 'Changed phase log: '+str(path))
                text = raw.decode('utf-8')
                require(not any(token in text for token in ('sorryAx','ofReduceBool','error:')), 'Rejected evidence in phase log')
    status = report.get('status')
    if status == COMPLETE:
        require(report.get('root_coverage') is True, 'Complete status without root coverage')
        require(set(names) == set(sources), 'Complete status with missing module verification')
        require(root in names, 'Concrete chart root not verified')
        classification = 'CONSISTENT_COMPLETE_CHART_REPORT'
    else:
        require(status in PARTIAL, 'Failed or unknown report status')
        require(report.get('root_coverage') is False, 'Partial status claiming root coverage')
        classification = 'CONSISTENT_PARTIAL_REPORT'
    return {'status': classification, 'chart': chart, 'verified_records': len(names),
        'declared_modules': len(sources), 'logs_checked': logs is not None,
        'scope': 'Report consistency only; no independent kernel replay or global theorem.'}

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('report', type=Path)
    parser.add_argument('--chart', required=True, type=int, choices=(0,1,2))
    parser.add_argument('--logs', type=Path)
    args = parser.parse_args()
    print(json.dumps(audit(json.loads(args.report.read_text(encoding='utf-8')), args.chart, args.logs), indent=2))

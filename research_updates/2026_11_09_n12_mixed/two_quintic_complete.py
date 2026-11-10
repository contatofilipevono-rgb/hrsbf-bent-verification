"""Build and run a balanced list of fixed upper-part enumeration tasks."""
import argparse
import json
import subprocess
import sys
from collections import defaultdict
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

HERE = Path(__file__).parent


def assign(projection, workers=16, checkpoint=None):
    data = json.loads(projection.read_text())
    items = []
    for index, row in enumerate(data["classes"]):
        if row["contradiction"]:
            continue
        bits = max(0, min(4, row["quartic_free"] - 24))
        trial_cost = 1 << (row["quartic_free"] - bits)
        for part in range(1 << bits):
            items.append((trial_cost, index, row["mask"], part, bits, row.get('period4_branch')))
    if checkpoint is not None:
        saved = json.loads(checkpoint.read_text())
        pending = {tuple(task) for task in saved['pending_blocks']}
        done = {(r['index'], r['high_mask'], r['shard'], r['shard_bits'], r.get('period4_branch'))
                for r in saved['completed_blocks']}
        assert not pending & done and pending | done == {task[1:] for task in items}
        measured = defaultdict(list)
        for row in saved['completed_blocks']:
            measured[row['index']].append(row['seconds'])
        selected = []
        for task in items:
            if task[1:] in pending:
                index = task[1]
                lower_rank = data['classes'][index]['lower_rank']
                estimate = (max(measured[index]) if measured[index] else
                            120 * 2 ** ((12 - lower_rank) / 2))
                selected.append((round(max(5, estimate)), *task[1:]))
        items = selected
    groups = [[] for _ in range(workers)]
    loads = [0] * len(groups)
    for task in sorted(items, reverse=True):
        i = min(range(len(groups)), key=loads.__getitem__)
        groups[i].append(task[1:])
        loads[i] += task[0]
    units = 'estimated seconds' if checkpoint else 'quartic trials'
    print('Tasks:', len(items), 'worker loads in', units, loads, flush=True)
    return groups


def main():
    p = argparse.ArgumentParser()
    p.add_argument("projection", type=Path)
    p.add_argument("worker", type=int)
    p.add_argument("executable", type=Path)
    p.add_argument("output", type=Path)
    p.add_argument("--mod8", action='store_true')
    p.add_argument("--workers", type=int, default=16)
    p.add_argument('--parallel', type=int, default=2)
    p.add_argument('--checkpoint', type=Path)
    a = p.parse_args()
    tasks = assign(a.projection, a.workers, a.checkpoint)[a.worker]
    a.output.mkdir(parents=True, exist_ok=True)
    (a.output / "tasks.json").write_text(json.dumps(tasks) + "\n")

    def run(task):
        chart, high, part, bits, branch = task
        dst = a.output / f"chart-{chart:03d}-part-{part:02d}"
        command = [sys.executable, str(HERE / "complete_sparse_fast.py"),
                   str(chart), str(part), str(bits), str(a.executable), str(dst),
                   "--high-mask", str(high)]
        if a.mod8:
            command.append('--mod8')
        if branch is not None:
            command += ['--period4-branch', str(branch)]
        subprocess.run(command, check=True)

    with ThreadPoolExecutor(max_workers=a.parallel) as pool:
        list(pool.map(run, tasks))


if __name__ == "__main__":
    main()

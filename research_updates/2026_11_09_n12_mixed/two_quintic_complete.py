"""Build and run a balanced list of exact two-orbit quintic tasks."""
import argparse
import json
import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

HERE = Path(__file__).parent


def assign(projection):
    data = json.loads(projection.read_text())
    items = []
    for index, row in enumerate(data["classes"]):
        if row["contradiction"]:
            continue
        bits = max(0, min(4, row["quartic_free"] - 24))
        trial_cost = 1 << (row["quartic_free"] - bits)
        for part in range(1 << bits):
            items.append((trial_cost, index, row["mask"], part, bits))
    groups = [[] for _ in range(16)]
    loads = [0] * len(groups)
    for task in sorted(items, reverse=True):
        i = min(range(len(groups)), key=loads.__getitem__)
        groups[i].append(task[1:])
        loads[i] += task[0]
    print("Tasks:",len(items),"quartic loads:",loads,flush=True)
    return groups


def main():
    p = argparse.ArgumentParser()
    p.add_argument("projection", type=Path)
    p.add_argument("worker", type=int)
    p.add_argument("executable", type=Path)
    p.add_argument("output", type=Path)
    a = p.parse_args()
    tasks = assign(a.projection)[a.worker]
    a.output.mkdir(parents=True, exist_ok=True)
    (a.output / "tasks.json").write_text(json.dumps(tasks) + "\n")

    def run(task):
        chart, high, part, bits = task
        dst = a.output / f"chart-{chart:03d}-part-{part:02d}"
        command = [sys.executable, str(HERE / "complete_sparse_fast.py"),
                   str(chart), str(part), str(bits), str(a.executable), str(dst),
                   "--high-mask", str(high)]
        subprocess.run(command, check=True)

    with ThreadPoolExecutor(max_workers=2) as pool:
        list(pool.map(run, tasks))


if __name__ == "__main__":
    main()

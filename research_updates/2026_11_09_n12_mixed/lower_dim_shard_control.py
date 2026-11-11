"""Check that Gray intervals partition a known nonempty phase family."""
import argparse
import json
import os
import struct
import subprocess
from pathlib import Path

from lower_dim_phase_prepare import prepare


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--counter", type=Path, required=True)
    p.add_argument("--output", type=Path, required=True)
    args = p.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    code = 1583330
    (args.output / "representative.bin").write_bytes(struct.pack("<Q", code))
    tasks = args.output / "control-tasks.bin"
    prepare(1, args.output / "representative.bin", tasks, 0, None)
    total = 0
    trials = 0
    for shard in range(16):
        prefix = args.output / f"control-{shard}"
        env = dict(os.environ, PHASE_SHARD=str(shard), PHASE_SHARDS="16")
        subprocess.run([str(args.counter.resolve()), str(tasks), str(prefix), "32"],
                       check=True, env=env, stdout=subprocess.DEVNULL)
        report = json.loads(prefix.with_suffix(".json").read_bytes())
        assert report["phase_shard"] == shard and report["phase_shards"] == 16
        assert report["deferred"] == 0
        total += report["functions"]
        trials += report["phase_trials"]
    prefix = args.output / "unsplit"
    env = dict(os.environ, PHASE_SHARD="0", PHASE_SHARDS="1")
    subprocess.run([str(args.counter.resolve()), str(tasks), str(prefix), "32"],
                   check=True, env=env, stdout=subprocess.DEVNULL)
    report = json.loads(prefix.with_suffix(".json").read_bytes())
    assert total == report["functions"] == 12288
    assert trials == report["phase_trials"]
    print({"split_functions": total, "unsplit_functions": report["functions"], "phase_trials": trials})


if __name__ == "__main__":
    main()

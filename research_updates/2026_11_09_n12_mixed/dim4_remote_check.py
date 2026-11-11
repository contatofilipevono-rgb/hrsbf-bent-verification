"""Run bounded C++ checks against the independent Python phase enumerator."""
import argparse
import json
import subprocess
from pathlib import Path

from dim4_verify import controls, verify


def run_counter(executable, binary, first, count, output, support_only=False):
    subprocess.run([str(executable.resolve()), str(binary), str(first), str(count), str(output),
                    str(int(support_only))], check=True)
    return json.loads(output.with_suffix(".json").read_text())


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--space", type=int, choices=(1, 2), required=True)
    parser.add_argument("--counter", type=Path, required=True)
    parser.add_argument("--model", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(exist_ok=True, parents=True)
    controls_path = args.output / "controls.json"
    controls(args.space, controls_path)
    for item in json.loads(controls_path.read_text()):
        prefix = args.output / item["name"]
        report = run_counter(args.counter, args.model, item["ordinal"], 1, prefix)
        assert report["functions"] == item["functions"], (report, item)
        assert report["admitting_phases"] == 1
        verify(args.space, prefix.with_suffix(".solutions.bin"))
    zero = run_counter(args.counter, args.model, 0, 1, args.output / "zero")
    assert zero["functions"] == zero["balanced"] == 0
    dimension = 33 if args.space == 1 else 31
    start = (1 << dimension) // 3
    run_counter(args.counter, args.model, start, 1 << 20, args.output / "support-pilot", True)
    run_counter(args.counter, args.model, start, 1 << 15, args.output / "phase-pilot")
    verify(args.space, (args.output / "phase-pilot").with_suffix(".solutions.bin"))


if __name__ == "__main__":
    main()

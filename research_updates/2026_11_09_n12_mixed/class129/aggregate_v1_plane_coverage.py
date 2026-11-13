"""Aggregate per-chart V1 common-phase-plane certificates and verify 256-chart disjoint coverage."""
from __future__ import annotations

import argparse
from pathlib import Path
import json
import sys

THIS_DIR = Path(__file__).resolve().parent
if str(THIS_DIR) not in sys.path:
    sys.path.insert(0, str(THIS_DIR))

from certify_v1_common_phase_plane import (
    CATALOG_CHARTS,
    INFEASIBLE_CL3_CHARTS,
    NON_CAT_RM_CHARTS,
    decode,
    stage0_chart_reduction,
    verify_catalog_control,
    verify_chart_slice,
)


def aggregate_slices(slice_records: list[dict], *, catalog_path: Path | None = None) -> dict:
    """Verify full 256-chart disjoint partition, zero survivors, and optional catalog coverage."""
    by_chart: dict[int, dict] = {}
    for rec in slice_records:
        chart = int(rec["chart"])
        assert chart not in by_chart, f"Duplicate slice for chart {chart}"
        assert rec.get("survivors") == 0, f"Chart {chart} reported non-zero survivors: {rec}"
        assert rec.get("witness") is None, f"Chart {chart} reported failure witness: {rec}"
        by_chart[chart] = rec

    assert sorted(by_chart) == list(range(256)), (
        f"Incomplete coverage: got {len(by_chart)}/256 charts"
    )
    status_counts: dict[str, int] = {}
    residual_classes: list[int] = []
    identity_classes: list[int] = []
    for ch in range(256):
        st = by_chart[ch]["status"]
        status_counts[st] = status_counts.get(st, 0) + 1
        if ch in CATALOG_CHARTS:
            assert st == "closed_by_identity"
            if by_chart[ch].get("residual_enumeration", 0) == 0:
                identity_classes.append(ch)
            else:
                residual_classes.append(ch)
        elif ch in NON_CAT_RM_CHARTS:
            assert st == "closed_non_catalog_rm_chart"
        elif ch in INFEASIBLE_CL3_CHARTS:
            assert st == "infeasible_rm_deg2"
        else:
            assert st == "infeasible_stage0_pure_z_rm"

    assert tuple(identity_classes) == CATALOG_CHARTS and not residual_classes
    summary: dict = {
        "total_charts_covered": 256,
        "status_counts": status_counts,
        "closed_by_identity_classes": identity_classes,
        "residual_enumeration_classes": residual_classes,
        "total_survivors": 0,
    }
    if catalog_path is not None:
        model, basis, _ = decode(1)
        summary["catalog_control"] = verify_catalog_control(catalog_path, model, basis)
    return summary


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--slices-dir", type=Path, help="Directory of chart-*.json slice certificates")
    parser.add_argument("--run-all", action="store_true", help="Evaluate missing charts directly from decode(1)")
    parser.add_argument("--catalog", type=Path, help="Optional mapas_V1.txt post-hoc coverage check")
    parser.add_argument("--output", type=Path, help="Optional JSON summary output path")
    args = parser.parse_args()

    records: list[dict] = []
    seen = set()
    if args.slices_dir is not None and args.slices_dir.exists():
        for path in sorted(args.slices_dir.glob("*.json")):
            data = json.loads(path.read_text(encoding="utf-8"))
            items = data if isinstance(data, list) else data.get("charts", [data])
            for rec in items:
                if "chart" in rec:
                    records.append(rec)
                    seen.add(int(rec["chart"]))

    if args.run_all or args.slices_dir is None:
        model, basis, labels = decode(1)
        stage0_chart_reduction(model, basis, labels)
        for ch in range(256):
            if ch not in seen:
                records.append(verify_chart_slice(ch, model, basis, labels))

    summary = aggregate_slices(records, catalog_path=args.catalog)
    text = json.dumps(summary, indent=2) + "\n"
    if args.output is not None:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(text, encoding="utf-8")
    else:
        print(text, end="")


if __name__ == "__main__":
    main()

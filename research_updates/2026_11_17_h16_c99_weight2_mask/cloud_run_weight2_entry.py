#!/usr/bin/env python3
"""Cloud Run Jobs entrypoint for H16 c99=1 joint 8-bit weight-2 mask investigation."""
import json
import os
import subprocess
import sys
import urllib.parse
import urllib.request
from pathlib import Path


def get_access_token() -> str:
    req = urllib.request.Request(
        "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token",
        headers={"Metadata-Flavor": "Google"},
    )
    with urllib.request.urlopen(req, timeout=10) as resp:
        return json.loads(resp.read().decode("utf-8"))["access_token"]


def gcs_download(bucket: str, object_name: str, dest: Path, token: str):
    url = f"https://storage.googleapis.com/storage/v1/b/{bucket}/o/{urllib.parse.quote(object_name, safe='')}?alt=media"
    req = urllib.request.Request(url, headers={"Authorization": f"Bearer {token}"})
    with urllib.request.urlopen(req, timeout=120) as resp:
        dest.write_bytes(resp.read())


def gcs_upload(bucket: str, local_path: Path, object_name: str, token: str):
    url = f"https://storage.googleapis.com/upload/storage/v1/b/{bucket}/o?uploadType=media&name={urllib.parse.quote(object_name, safe='')}"
    data = local_path.read_bytes()
    req = urllib.request.Request(
        url,
        data=data,
        method="POST",
        headers={
            "Authorization": f"Bearer {token}",
            "Content-Type": "application/octet-stream",
            "Content-Length": str(len(data)),
        },
    )
    with urllib.request.urlopen(req, timeout=120) as resp:
        resp.read()
    print(f"Uploaded {local_path} -> gs://{bucket}/{object_name}", flush=True)


def main():
    bucket = os.environ.get("GCS_BUCKET", "h16-c99-5orbits-342eeb2f")
    workers = os.environ.get("WORKERS", str(os.cpu_count() or 8))

    app_dir = Path("/tmp/app")
    work_dir = Path("/tmp/work")
    app_dir.mkdir(parents=True, exist_ok=True)
    work_dir.mkdir(parents=True, exist_ok=True)

    token = get_access_token()
    gcs_download(bucket, "weight2/weight2_mask_core.c", app_dir / "weight2_mask_core.c", token)
    gcs_download(bucket, "weight2/run_weight2_mask.py", app_dir / "run_weight2_mask.py", token)
    gcs_download(bucket, "interior/T28_SEXTA_CERTIFICADO.json.gz", app_dir / "T28_SEXTA_CERTIFICADO.json.gz", token)

    cmd = [
        "python3",
        str(app_dir / "run_weight2_mask.py"),
        "--cert-path",
        str(app_dir / "T28_SEXTA_CERTIFICADO.json.gz"),
        "--work-dir",
        str(work_dir),
        "--workers",
        workers,
        "--samples-per-band",
        "80000000",
    ]
    print(f"Running: {' '.join(cmd)}", flush=True)
    proc = subprocess.run(cmd, capture_output=True, text=True)
    print(proc.stdout, flush=True)
    if proc.stderr:
        print(proc.stderr, file=sys.stderr, flush=True)
    proc.check_returncode()

    token = get_access_token()
    gcs_upload(bucket, work_dir / "weight2_mask_report.json", "weight2/weight2_mask_report.json", token)


if __name__ == "__main__":
    main()

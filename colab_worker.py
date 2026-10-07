#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import os
import socket
import subprocess
import sys
import time
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parent
QUEUE = ROOT / "jobs" / "queue.json"
STATUS = ROOT / "jobs" / "status"
RESULTS = ROOT / "results"
BRANCH = os.environ.get("COLAB_BRANCH", "colab-a100-2026-10-06")


def now():
    return datetime.now(timezone.utc).isoformat()


def run_git(args, check=True):
    p = subprocess.run(
        ["git", *args],
        cwd=ROOT,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )
    if check and p.returncode:
        raise RuntimeError(p.stdout)
    return p


def sync_repo():
    if BRANCH != "colab-a100-2026-10-06":
        raise RuntimeError("v2 worker may only update colab-a100-2026-10-06")
    current = run_git(["branch", "--show-current"]).stdout.strip()
    if current != BRANCH:
        raise RuntimeError("check out the v2 branch before starting the worker")
    p = run_git(["pull", "--rebase", "--autostash", "origin", BRANCH], check=False)
    if p.returncode:
        raise RuntimeError("git pull failed:\n" + p.stdout)


def push_files(paths, message):
    rel = [str(Path(p).relative_to(ROOT)) for p in paths]
    run_git(["add", "--", *rel])
    if run_git(["diff", "--cached", "--quiet"], check=False).returncode == 0:
        return
    run_git(["commit", "-m", message])
    for _ in range(3):
        p = run_git(["push", "origin", f"HEAD:{BRANCH}"], check=False)
        if p.returncode == 0:
            return
        pull = run_git(["pull", "--rebase", "origin", BRANCH], check=False)
        if pull.returncode:
            raise RuntimeError(p.stdout + "\n" + pull.stdout)
    raise RuntimeError("git push failed after retries")


def gpu_info():
    try:
        p = subprocess.run(
            ["nvidia-smi", "--query-gpu=name,memory.total", "--format=csv,noheader"],
            text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
        )
    except FileNotFoundError:
        return {"available": False, "details": "nvidia-smi not installed"}
    return {"available": p.returncode == 0, "details": p.stdout.strip()}


def read_queue():
    data = json.loads(QUEUE.read_text(encoding="utf-8"))
    return data if isinstance(data, list) else data.get("jobs", [])


def status_path(job_id):
    return STATUS / f"{job_id}.json"


def load_status(job_id):
    p = status_path(job_id)
    return json.loads(p.read_text(encoding="utf-8")) if p.exists() else None


def save_json(path, obj):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(obj, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


def validate_job(job):
    job_id = str(job["id"])
    if not job_id.replace("-", "").replace("_", "").replace(".", "").isalnum():
        raise ValueError("invalid job id")

    script = (ROOT / str(job["script"])).resolve()
    if ROOT not in script.parents or script.suffix != ".py" or not script.exists():
        raise ValueError("job script must be an existing .py file inside this repository")

    args = job.get("args", [])
    if not isinstance(args, list) or not all(isinstance(x, str) for x in args):
        raise ValueError("args must be a list of strings")
    return job_id, script, args


def is_pending(job):
    old = load_status(job["id"])
    rev = int(job.get("revision", 1))
    return job.get("enabled", True) and (
        old is None or int(old.get("job_revision", -1)) != rev
        or old.get("state") == "waiting_gpu"
    )


def execute(job, gpu):
    job_id, script, args = validate_job(job)
    rev = int(job.get("revision", 1))
    outdir = RESULTS / job_id / f"rev_{rev}"
    outdir.mkdir(parents=True, exist_ok=True)
    log = outdir / "run.log"
    meta_path = outdir / "meta.json"

    started_at = now()
    started = time.time()
    with log.open("w", encoding="utf-8") as f:
        try:
            p = subprocess.run(
                [sys.executable, str(script.relative_to(ROOT)), *args],
                cwd=ROOT,
                stdout=f,
                stderr=subprocess.STDOUT,
                timeout=int(job.get("timeout_seconds", 3600)),
            )
            returncode = p.returncode
            timed_out = False
        except subprocess.TimeoutExpired:
            returncode = 124
            timed_out = True
            f.write("\nTIMEOUT\n")

    meta = {
        "job_id": job_id,
        "job_revision": rev,
        "description": job.get("description", ""),
        "script": str(script.relative_to(ROOT)),
        "args": args,
        "started_at": started_at,
        "finished_at": now(),
        "duration_seconds": round(time.time() - started, 3),
        "returncode": returncode,
        "timed_out": timed_out,
        "worker_host": socket.gethostname(),
        "gpu": gpu,
        "git_sha": run_git(["rev-parse", "HEAD"]).stdout.strip(),
        "python": sys.version,
    }
    save_json(meta_path, meta)
    return returncode, log, meta_path, meta


def process_one():
    sync_repo()
    gpu = gpu_info()

    for job in read_queue():
        if not is_pending(job):
            continue
        if job.get("require_gpu", False) and not gpu["available"]:
            jid, _, _ = validate_job(job)
            rev = int(job.get("revision", 1))
            previous = load_status(jid)
            if previous and previous.get("state") == "waiting_gpu" and previous.get("job_revision") == rev:
                print(f"{jid}: still waiting for GPU")
                continue
            sp = status_path(jid)
            waiting = {
                "job_id": jid,
                "job_revision": rev,
                "state": "waiting_gpu",
                "checked_at": now(),
                "worker_host": socket.gethostname(),
                "gpu": gpu,
            }
            save_json(sp, waiting)
            push_files([sp], f"colab: waiting for GPU {jid} r{rev}")
            print(f"{jid}: waiting for a GPU runtime")
            continue

        jid, _, _ = validate_job(job)
        rev = int(job.get("revision", 1))
        sp = status_path(jid)
        running = {
            "job_id": jid,
            "job_revision": rev,
            "state": "running",
            "started_at": now(),
            "worker_host": socket.gethostname(),
            "gpu": gpu,
        }
        save_json(sp, running)
        push_files([sp], f"colab: start {jid} r{rev}")

        print(f"Running {jid} r{rev}")
        rc, log, meta_path, meta = execute(job, gpu)
        state = "done" if rc == 0 else "failed"
        finished = {
            **running,
            "state": state,
            "finished_at": meta["finished_at"],
            "returncode": rc,
            "result_dir": str(meta_path.parent.relative_to(ROOT)),
        }
        save_json(sp, finished)
        artifacts = []
        for name in job.get("artifacts", []):
            artifact = (ROOT / name).resolve()
            if outdir.resolve() not in artifact.parents:
                raise ValueError("artifacts must be inside the job result directory")
            if artifact.is_file():
                artifacts.append(artifact)
            elif rc == 0:
                finished["state"] = state = "failed"
                finished.setdefault("missing_artifacts", []).append(name)
        save_json(sp, finished)
        push_files([sp, log, meta_path, *artifacts], f"colab: finish {jid} r{rev} [{state}]")
        print(f"{jid}: {state}")
        return True

    return False


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--once", action="store_true")
    ap.add_argument("--poll", type=int, default=30)
    args = ap.parse_args()

    run_git(["config", "user.name", "HRSBF Colab Worker"])
    run_git(["config", "user.email", "colab-worker@users.noreply.github.com"])

    if args.once:
        process_one()
        return

    print(f"Worker active; polling every {args.poll}s")
    while True:
        try:
            if process_one():
                continue
        except KeyboardInterrupt:
            raise
        except Exception as exc:
            print("Worker error:", exc, file=sys.stderr)
        time.sleep(max(5, args.poll))


if __name__ == "__main__":
    main()

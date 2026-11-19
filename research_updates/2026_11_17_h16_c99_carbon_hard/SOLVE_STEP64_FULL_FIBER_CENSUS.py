"""Enumerate disjoint prefixes of one complete reduced B0_11 fiber."""
from concurrent.futures import ThreadPoolExecutor
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

from SOLVE_STEP63_FIBER_CENSUS import gather, restore


def scan(polys, prefix):
    d = 24
    packed = gather(polys,d,prefix)
    run = subprocess.run(["./h16_step63"],input=packed,text=True,capture_output=True,
                         check=True,timeout=120)
    models = []
    visits = None
    for line in run.stdout.splitlines():
        kind,*fields = line.split()
        if kind=="MODEL":
            p,x = map(int,fields)
            assert 0<=p<1<<d and 0<=x<1<<25
            point = restore((prefix<<d)|p,x)
            assert all(sum((m&point)==m for m in f)%2==0 for f in polys)
            models.append(point)
        elif kind=="COUNTS":
            assert visits is None
            visits,count,checks = map(int,fields[:3])
            core_seconds = float(fields[3])
        else:
            raise RuntimeError(f"Unexpected output: {line}")
    assert visits==1<<d and count==len(models) and checks>=1024
    return {"prefix":prefix,"visited":visits,"survivors":count,"models":models,
            "cross_checks":checks,"seconds":core_seconds,
            "slice_sha256":hashlib.sha256(packed.encode("ascii")).hexdigest()}


def shard():
    raw = Path("fiber/step60_fiber.json").read_bytes()
    data = json.loads(raw)
    polys = data["polynomials"][:data["original_count"]]
    assert len(polys)==63 and data["variables"]==59
    shard_id = int(os.environ["H16_SHARD"])
    assert 0<=shard_id<16
    prefixes = range(64*shard_id,64*(shard_id+1))
    result_path = Path(f"step64_shard_{shard_id:02}.json")
    start = time.monotonic()
    out = {"shard":shard_id,"fiber":64,"input_sha256":hashlib.sha256(raw).hexdigest(),"results":[]}
    with ThreadPoolExecutor(max_workers=2) as executor:
        for result in executor.map(lambda p:scan(polys,p),prefixes):
            out["results"].append(result)
            if result["models"] or len(out["results"])%8==0:
                result_path.write_text(json.dumps(out))
                print("STEP64_PROGRESS",json.dumps({"shard":shard_id,
                      "prefixes":len(out["results"]),"last":result["prefix"],
                      "survivor_prefixes":sum(bool(x["models"]) for x in out["results"])}),flush=True)
    assert len(out["results"])==64
    out["wall_seconds"]=round(time.monotonic()-start,2)
    result_path.write_text(json.dumps(out))
    print("STEP64_SHARD",json.dumps({"shard":shard_id,"visits":1<<30,
          "survivors":sum(x["survivors"] for x in out["results"]),
          "seconds":out["wall_seconds"]}),flush=True)


def collect(location):
    files = sorted(location.glob("step64_shard_*.json"))
    assert len(files)==16
    counts = [json.loads(p.read_text()) for p in files]
    assert {x["shard"] for x in counts}==set(range(16))
    assert {x["fiber"] for x in counts}=={64}
    source = {x["input_sha256"] for x in counts}
    assert len(source)==1
    rows = []
    for bundle in counts:
        k = bundle["shard"]
        assert [x["prefix"] for x in bundle["results"]]==list(range(64*k,64*(k+1)))
        for row in bundle["results"]:
            assert row["visited"]==1<<24 and row["survivors"]==len(row["models"])
            assert row["cross_checks"]>=1024 and len(row["slice_sha256"])==64
            rows.append(row)
    assert sorted(x["prefix"] for x in rows)==list(range(1024))
    total = sum(x["visited"] for x in rows)
    assert total==1<<34
    result = {"fiber":64,"prefixes":len(rows),"visited":total,
              "survivors":sum(x["survivors"] for x in rows),
              "cross_checks":sum(x["cross_checks"] for x in rows),
              "input_sha256":next(iter(source)),
              "maximum_shard_seconds":max(x["wall_seconds"] for x in counts)}
    print("STEP64_COMPLETE",json.dumps(result),flush=True)
    Path("step64_summary.json").write_text(json.dumps(result))


if __name__=="__main__":
    if len(sys.argv)>1:
        collect(Path(sys.argv[1]))
    else:
        shard()

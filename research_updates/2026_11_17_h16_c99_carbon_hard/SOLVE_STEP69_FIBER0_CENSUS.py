"""Complete census of Step60 B0_11 fiber 0 in 32 disjoint shards.

Each prefix covers exactly 2^24 assignments of the 34 unrestricted W bits.
The reused scanner independently validates all candidate models against
63 original reduced polynomials. Closure is only for B0_11 fiber 0.
"""
from concurrent.futures import ThreadPoolExecutor
import hashlib
import json
import os
from pathlib import Path
import sys
import time
from SOLVE_STEP64_FULL_FIBER_CENSUS import scan
from SOLVE_STEP63_FIBER_CENSUS import gather

N_SHARDS = 32
PREFIXES_PER_SHARD = 32
N_PREFIXES = 1024
VISITS = 1<<24


def load():
    path=Path("fiber/step60_fiber.json")
    raw=path.read_bytes()
    data=json.loads(raw)
    assert data["variables"]==59 and data["original_count"]==63
    return hashlib.sha256(raw).hexdigest(),data["polynomials"][:63]


def verify_row(polys,row,prefix):
    assert row["prefix"]==prefix and row["visited"]==VISITS
    assert row["survivors"]==len(row["models"]) and row["cross_checks"]>=1024
    packed=gather(polys,24,prefix).encode("ascii")
    assert row["slice_sha256"]==hashlib.sha256(packed).hexdigest()
    for model in row["models"]:
        assert all(sum((m&model)==m for m in poly)%2==0 for poly in polys)


def shard():
    source,polys=load()
    k=int(os.environ["H16_SHARD"])
    assert 0<=k<N_SHARDS
    prefixes=list(range(PREFIXES_PER_SHARD*k,PREFIXES_PER_SHARD*(k+1)))
    bundle={"shard":k,"fiber":0,"input_sha256":source,"results":[]}
    path=Path(f"step69_shard_{k:02}.json")
    start=time.monotonic()
    with ThreadPoolExecutor(max_workers=2) as ex:
        for row in ex.map(lambda p:scan(polys,p),prefixes):
            verify_row(polys,row,row["prefix"])
            bundle["results"].append(row)
            if len(bundle["results"])%4==0 or row["models"]:
                path.write_text(json.dumps(bundle))
                print("STEP69_PROGRESS",json.dumps({
                  "shard":k,"covered":len(bundle["results"]),
                  "last":row["prefix"],"survivors":sum(r["survivors"] for r in bundle["results"])}),flush=True)
    bundle["seconds"]=round(time.monotonic()-start,2)
    assert [row["prefix"] for row in bundle["results"]]==prefixes
    path.write_text(json.dumps(bundle))
    print("STEP69_SHARD",json.dumps({"shard":k,"visited":1<<29,
       "survivors":sum(r["survivors"] for r in bundle["results"])}),flush=True)


def collect():
    source,polys=load()
    files=sorted(Path("shards").glob("step69_shard_*.json"))
    assert len(files)==N_SHARDS
    allrows={}
    for k,path in enumerate(files):
        bundle=json.loads(path.read_text())
        assert bundle["fiber"]==0 and bundle["shard"]==k
        assert bundle["input_sha256"]==source
        expected=list(range(PREFIXES_PER_SHARD*k,PREFIXES_PER_SHARD*(k+1)))
        assert [r["prefix"] for r in bundle["results"]]==expected
        for row in bundle["results"]:
            assert row["prefix"] not in allrows
            verify_row(polys,row,row["prefix"])
            allrows[row["prefix"]]=row
    assert sorted(allrows)==list(range(N_PREFIXES))
    nvisits=sum(row["visited"] for row in allrows.values())
    assert nvisits==1<<34
    survivors=sum(row["survivors"] for row in allrows.values())
    report={"scope":"B0_11 reduced fiber 0 ONLY",
            "fiber_input_sha256":source,"complete_prefixes":len(allrows),
            "visited":nvisits,"survivors":survivors,
            "full_unsat_for_this_reduced_fiber":survivors==0,
            "cross_checks":sum(row["cross_checks"] for row in allrows.values()),
            "warning":"Reduced-system equivalence with the complete cell not verified here."}
    Path("step69_fiber0_summary.json").write_text(json.dumps(report,indent=2)+"\n")
    print("STEP69_COVERAGE_CERT",json.dumps(report),flush=True)


if __name__=="__main__":
    if sys.argv[1:]==["collect"]:
        collect()
    elif not sys.argv[1:]:
        shard()
    else:
        raise SystemExit("usage: step69 [collect]")

"""Package a reproducible slice and validate every returned reduced model."""
import hashlib
import json
import os
from pathlib import Path
import subprocess


def gather(polys, d, prefix):
    old_mask = (1<<35)-1
    transfer = 1<<7
    active_mask = (1<<d)-1
    high_point = prefix<<d
    matrix = [[0]*24 for _ in range(d+1)]
    terms = {}
    for i,poly in enumerate(polys):
        for p in poly:
            w,r = p&old_mask,p>>35
            w_without_transfer = (w & (transfer-1)) | ((w>>8)<<7)
            high = w_without_transfer & ~active_mask
            if high & high_point != high:
                continue
            free = w_without_transfer & active_mask
            if r:
                assert r.bit_count()==1 and r.bit_length()<=24
                assert not w&transfer and free.bit_count()<=1
                matrix[free.bit_length()][r.bit_length()-1] ^= 1<<i
            else:
                pair = terms.setdefault(free,[0,0])
                pair[0 if w&transfer else 1] ^= 1<<i
    vals = [f"{d} {len(terms)}"]
    vals.extend(" ".join(map(str,row)) for row in matrix)
    vals.extend(f"{m} {pair[0]} {pair[1]}" for m,pair in sorted(terms.items()))
    return "\n".join(vals)+"\n"


def restore(p, x):
    w = (p & 127) | ((p>>7)<<8) | (((x>>24)&1)<<7)
    return w | ((x&((1<<24)-1))<<35)


def main():
    data = json.loads(Path("fiber/step60_fiber.json").read_text())
    polys = data["polynomials"][:data["original_count"]]
    assert len(polys)==63 and data["variables"]==59
    d = 24
    prefix = int(os.environ["H16_PREFIX"])
    offset = int(os.environ["H16_OFFSET"])
    assert 0<=prefix<(1<<(34-d))
    packed = gather(polys,d,prefix)
    Path("step63_slice.txt").write_text(packed,encoding="ascii")
    run = subprocess.run(["./h16_step63"],input=packed,text=True,capture_output=True,
                         check=True,timeout=220)
    points = []
    for row in run.stdout.splitlines():
        kind,*values = row.split()
        if kind=="MODEL":
            p,x = map(int,values)
            point = restore((prefix<<d)|p,x)
            assert all(sum((m&point)==m for m in f)%2==0 for f in polys)
            points.append(point)
        elif kind=="COUNTS":
            visited,survivors,checks = map(int,values[:3])
            seconds = float(values[3])
        else:
            raise RuntimeError(f"unexpected response {row!r}")
    assert visited==1<<d and survivors==len(points)
    result = {"fiber":offset,"free":d,"prefix":prefix,"visited":visited,
              "survivors":survivors,"cross_checks":checks,"seconds":seconds,
              "points_per_second":round(visited/seconds),
              "estimated_cpu_minutes_per_fiber":round((1<<34)*seconds/visited/60,2),
              "sha256":hashlib.sha256(packed.encode("ascii")).hexdigest(),"models":points}
    print("STEP63_CENSUS",json.dumps(result),flush=True)
    Path("step63_census.json").write_text(json.dumps(result))


if __name__=="__main__":
    main()

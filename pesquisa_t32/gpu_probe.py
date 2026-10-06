#!/usr/bin/env python3
import json, sys, time
report={"python":sys.version,"torch_available":False,"cuda_available":False}
try:
    import torch
    report["torch_available"]=True
    report["torch_version"]=torch.__version__
    report["cuda_available"]=bool(torch.cuda.is_available())
    if report["cuda_available"]:
        report["device_name"]=torch.cuda.get_device_name(0)
        props=torch.cuda.get_device_properties(0)
        report["memory_total_bytes"]=int(props.total_memory)
        torch.backends.cuda.matmul.allow_tf32=False
        a=torch.arange(1024*1024,dtype=torch.float32,device="cuda").reshape(1024,1024)
        t=time.time(); b=a@a.T; torch.cuda.synchronize()
        report["matmul_seconds"]=round(time.time()-t,6)
        report["checksum"]=float(b[0,0].item())
except Exception as exc:
    report["error"]=repr(exc)
print(json.dumps(report,indent=2))
if not report["cuda_available"]:
    raise SystemExit(2)

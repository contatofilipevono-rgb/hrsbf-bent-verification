# Local runtime workaround

Lean 4.19.0 was installed from the official Linux release. The execution container
has a PID namespace mismatch: `getpid()` returns 2, but `/proc/2/exe` does not exist.
Lean's `lean_io_app_path` consequently fails before processing the input file.

The local LD_PRELOAD adapter overrides `readlink` only when reading a missing
`/proc/<pid>/exe`: it returns argv[0] from `/proc/self/cmdline`. This only restores
executable-path detection. It changes no Lean definitions, tactics, kernel checks,
or compiled proof objects. Its C source is included for reproducibility.

Invocation used locally:

```sh
gcc -shared -fPIC logs/environment-path-shim.c -ldl -o /tmp/v3c-path-shim.so
LD_PRELOAD=/tmp/v3c-path-shim.so PATH=/path/to/lean-4.19/bin:$PATH /path/to/lean-4.19/bin/lake build
```

An ordinary Linux installation should use `lake build` directly without this
adapter. TAR_OPTIONS=--no-same-owner was used while extracting cache utilities
because archive ownership cannot be restored in this container.

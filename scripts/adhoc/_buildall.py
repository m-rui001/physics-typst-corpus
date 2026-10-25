import glob
import os
import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor

sys.stdout.reconfigure(encoding="utf-8")
papers = sorted(os.path.dirname(p) for p in glob.glob("papers/*/main.typ"))


def build(dirname):
    args = ["typst", "compile"]
    if dirname.endswith("2105.06980"):
        args.append("--no-pdf-tags")
    args += ["main.typ"]
    r = subprocess.run(args, cwd=dirname, capture_output=True, text=True)
    return dirname, r.returncode, (r.stderr or "")[-400:]


with ThreadPoolExecutor(max_workers=4) as ex:
    results = list(ex.map(build, papers))
ok = 0
for d, code, err in results:
    if code == 0:
        ok += 1
    else:
        print("FAIL", d, err.replace("\n", " | ")[:300])
print(f"{ok}/{len(papers)} built")

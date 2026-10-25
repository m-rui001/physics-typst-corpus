"""Batch driver: convert all downloaded papers, then sample-check build quality."""
sys_stdout = __import__("sys"); sys_stdout.stdout.reconfigure(encoding="utf-8", errors="replace")
import os, glob, json, subprocess, sys, time

ROOT = r"E:\phys\papers"
EXCLUDE = {"2206.04615", "2206.14858", "2402.14008"}  # CS/AI papers mixed into crawl results

def run(cmd, timeout=3600):
    return subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="replace", timeout=timeout)

for d in sorted(glob.glob(os.path.join(ROOT, "2*"))):
    if os.path.basename(d) in EXCLUDE:
        print("excluded (not physics)", d); continue
    rep = os.path.join(d, "report.json")
    if os.path.exists(rep):
        try:
            if json.load(open(rep)).get("compiled"):
                print("skip", d); continue
        except Exception:
            pass
    if not os.path.isdir(os.path.join(d, "src")):
        continue
    t0 = time.time()
    r = run([sys.executable, r"E:\phys\scripts\convert.py", d], timeout=5400)
    print("=== ", os.path.basename(d), f"({time.time()-t0:.0f}s)", r.returncode)
    print(r.stdout[-1200:], r.stderr[-400:])
print("ALL DONE")

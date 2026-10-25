"""Parallel batch driver: convert remaining papers with the opencode2api free-model sub-agent."""
import sys
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import os, glob, json, subprocess, time
from concurrent.futures import ThreadPoolExecutor

ROOT = r"E:\phys\papers"
LOGS = r"E:\phys\logs"
EXCLUDE = {"2206.04615", "2206.14858", "2402.14008"}
NWORKERS = int(os.environ.get("POOL", "5"))
os.makedirs(LOGS, exist_ok=True)

def done(d):
    rep = os.path.join(d, "report.json")
    if os.path.exists(rep):
        try:
            return bool(json.load(open(rep, encoding="utf-8")).get("compiled"))
        except Exception:
            return False
    return False

def work(d):
    pid = os.path.basename(d)
    env = dict(os.environ, ENGINE="oc2a", POLISH="1", CETZ_SCHEMATIC="1",
               PYTHONIOENCODING="utf-8")
    t0 = time.time()
    with open(os.path.join(LOGS, pid + ".txt"), "w", encoding="utf-8") as lf:
        try:
            r = subprocess.run([sys.executable, r"E:\phys\scripts\convert.py", d],
                               capture_output=True, text=True, encoding="utf-8",
                               errors="replace", timeout=2400, env=env, cwd=ROOT)
            lf.write((r.stdout or "")[-20000:] + "\n--STDERR--\n" + (r.stderr or "")[-4000:])
            ok = r.returncode == 0 and os.path.exists(os.path.join(d, "build", "main.pdf"))
        except subprocess.TimeoutExpired:
            lf.write("TIMEOUT 2400s\n")
            ok, r = False, None
    print(f"[{time.time()-t0:.0f}s] {'OK  ' if ok else 'FAIL'} {pid}", flush=True)
    return pid, ok

targets = [d for d in sorted(glob.glob(os.path.join(ROOT, "2*")))
           if os.path.basename(d) not in EXCLUDE and os.path.isdir(os.path.join(d, "src"))
           and not done(d)]
print(f"targets={len(targets)} workers={NWORKERS}", flush=True)
with ThreadPoolExecutor(NWORKERS) as ex:
    res = list(ex.map(work, targets))
print("POOL DONE", sum(1 for _, ok in res if ok), "of", len(res), flush=True)

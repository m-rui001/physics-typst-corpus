import glob, io, os, subprocess

for p in sorted(glob.glob("papers/*/main.typ")):
    s = io.open(p, encoding="utf-8").read()
    for ln in s.split("\n"):
        if ln.startswith("#set page(") and "columns: 2" in ln and "columns: 1" in ln:
            fixed = ln.replace("columns: 1, columns: 2", "columns: 2")
            s = s.replace(ln, fixed)
            io.open(p, "w", encoding="utf-8", newline="\n").write(s)
            print("fixed", p)
            break
    r = subprocess.run(["typst", "compile", p, os.path.join(os.path.dirname(p), "_work", "_c.pdf")],
                       capture_output=True, text=True, errors="replace")
    if r.returncode != 0:
        print("FAIL", p, (r.stderr or "").strip().splitlines()[:3])

import glob, re
# detect shattered math: >=3 consecutive lines ending with a single trailing backslash
pat = re.compile(r"(?<!\\)\\\s*$")
for f in sorted(glob.glob("papers/*/main.typ")):
    lines = open(f, encoding="utf-8").read().split("\n")
    run = 0
    runs = []
    for i, l in enumerate(lines):
        if pat.search(l):
            run += 1
        else:
            if run >= 3:
                runs.append((i - run + 1, run))
            run = 0
    if run >= 3:
        runs.append((len(lines) - run + 1, run))
    if runs:
        print(f, runs[:6], "total", len(runs))

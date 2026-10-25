import re, io, glob, os

PUNCT = re.compile(r"[^a-z0-9]+")

def norm(t):
    t = re.sub(r"\\[a-zA-Z@]+\*?", " ", t)
    t = re.sub(r"\\.", " ", t)
    t = PUNCT.sub(" ", t.lower())
    return t.strip()

rows = []
for d in sorted(glob.glob("papers/*/main.typ")):
    pid = os.path.basename(os.path.dirname(d))
    srcs = [f for f in glob.glob(f"papers/{pid}/**/*.tex", recursive=True)
            if not re.search(r"supp|text_sm|/sm/|check/|_work/", f)]
    if not srcs:
        continue
    typ = norm(io.open(d, encoding="utf-8", errors="ignore").read())
    tw = typ.split()
    tset = set(tuple(tw[i:i + 6]) for i in range(len(tw) - 5))
    raw = " ".join(io.open(f, encoding="utf-8", errors="ignore").read() for f in srcs)
    raw = re.sub(r"(?m)^\s*%.*$", " ", raw)
    sents = re.split(r"(?<=[.!?])\s+", raw)
    tot = miss = 0
    ex = []
    for s in sents:
        w = norm(s).split()
        if len(w) < 12:
            continue
        alpha = sum(1 for x in w if len(x) > 2)
        if alpha < 0.55 * len(w):
            continue
        tot += 1
        grams = [tuple(w[i:i + 6]) for i in range(0, len(w) - 5, 3)]
        if grams and not any(g in tset for g in grams):
            miss += 1
            if len(ex) < 5:
                ex.append(" ".join(w[:16]))
    if tot:
        rows.append((100 * miss / tot, pid, miss, tot, ex))

for pct, pid, miss, tot, ex in sorted(rows, reverse=True):
    print(f"{pid}: {miss}/{tot} ({pct:.0f}%)")
    for e in ex:
        print("   ", e)

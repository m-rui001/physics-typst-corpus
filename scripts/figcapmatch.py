"""Fuzzy-match TeX figure captions against the Typst text to find lost floats."""
import glob, io, os, re, sys
sys.stdout.reconfigure(encoding="utf-8")

BEG = re.compile(r"\\begin\{(figure\*?|table\*?|longtable\*?)\}(.*?)\\end\{\1\}", re.S)
CAP = re.compile(r"\\caption\s*\{(.{0,120})", re.S)
WANT = "figure"


def caps_of(d):
    out = []
    for p in glob.glob(os.path.join(d, "src", "**", "*.tex"), recursive=True):
        if re.search(r"(supplement|_sm|supp)[^/]*\.tex$", p, re.I):
            continue
        s = io.open(p, encoding="utf-8", errors="replace").read()
        for m in BEG.finditer(s):
            if (WANT == "figure") != m.group(1).startswith("fig"):
                continue
            body = re.sub(r"(?m)^\s*%.*$", "", m.group(2))
            c = CAP.search(body)
            if c:
                out.append(re.sub(r"\s+", " ", c.group(1)))
    return out


def norm(t):
    t = re.sub(r"\\[A-Za-z]+\*?", " ", t)
    t = re.sub(r"[^A-Za-z0-9 ]", " ", t)
    return [w.lower() for w in t.split() if len(w) > 3]


args = sys.argv[1:]
if args and args[0] == "--tables":
    WANT = "table"
    args = args[1:]

for d in args:
    caps = caps_of(d)
    main = io.open(os.path.join(d, "main.typ"), encoding="utf-8", errors="replace").read()
    main_n = " ".join(norm(main))
    miss = []
    for c in caps:
        words = norm(c)[:6]
        hit = sum(1 for w in words if w in main_n)
        if words and hit < max(2, len(words) // 2):
            miss.append((hit, c))
    print("%s: %d active figures, %d captions unmatched" % (d, len(caps), len(miss)))
    for h, c in miss:
        print("   hit=%d | %s" % (h, c[:110]))

import glob, re, sys
sys.stdout.reconfigure(encoding="utf-8")
import pymupdf

pat = re.compile(
    r"\b(upright|left|right|thin|quad|mspace|mathrm|mathbf|text|frac|cases|sqrt|hat|dot|tilde|bar|cal|bb|bold|italic|serif|sans|displaystyle|limits)"
    r"\s*[\(\[\{]"
)
for p in sorted(glob.glob("papers/*/main.pdf")):
    doc = pymupdf.open(p)
    hits = {}
    for i, page in enumerate(doc):
        t = page.get_text()
        for m in pat.finditer(t):
            w = m.group(1)
            hits.setdefault(w, []).append(i + 1)
    doc.close()
    if hits:
        print("===", p)
        for w, pgs in hits.items():
            uniq = sorted(set(pgs))
            print("   %-12s n=%-3d pages=%s" % (w, len(pgs), uniq[:12]))

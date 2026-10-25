"""Rewrite Typst-illegal citation keys inside main.typ (the body-side half of bibmerge.sanitize),
then report which cited keys are still absent from refs.bib."""
import glob, os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from bibmerge import ENTRY, merge

KEY = re.compile(r"@([A-Za-z0-9_.:+*\-]+)")
OK = re.compile(r"[A-Za-z0-9_.:\-]+")


def fix(paper):
    typ, rp = os.path.join(paper, "main.typ"), os.path.join(paper, "refs.bib")
    if not os.path.exists(typ):
        return
    body = open(typ, encoding="utf-8", errors="replace").read()
    n = 0

    def rep(m):
        nonlocal n
        k = m.group(1)
        if OK.fullmatch(k):
            return m.group(0)
        n += 1
        return "@" + re.sub(r"[^A-Za-z0-9_.:\-]", "-", k)

    body = KEY.sub(rep, body)
    if n:
        open(typ, "w", encoding="utf-8").write(body)

    bib = open(rp, encoding="utf-8", errors="replace").read() if os.path.exists(rp) else ""
    have = set(k.lower() for _t, k in ENTRY.findall(bib))
    labels = set(re.findall(r"<([\w:.\-]+)>", body))
    cited = set(KEY.findall(body))
    missing = sorted(k for k in cited
                     if ":" not in k and k.lower() not in have and k.lower() not in labels)
    print(os.path.basename(paper), "rebadised", n, "uncited-in-bib", len(missing), missing[:8], flush=True)
    return merge(paper)


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    for d in sys.argv[1:] or sorted(glob.glob(r"E:\phys\papers\2*")):
        try:
            r = fix(d)
            if r:
                print("  merge:", r, flush=True)
        except Exception as e:
            print("FAIL", d, repr(e)[:150], flush=True)

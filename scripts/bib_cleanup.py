# -*- coding: utf-8 -*-
"""Strip \\url/\\href/\\endthebibliography leftovers and math from BibTeX fields."""
import glob
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from bib_demath import demath  # noqa: E402

ROOT = r"E:\phys"
FIELDS = ("title", "author", "booktitle", "journal", "howpublished", "note")


def clean(text):
    text = re.sub(r"\\url\{([^{}]*)\}", r"\1", text)
    text = re.sub(r"\\url(https?://[^\s},]+)", r"\1", text)
    text = re.sub(r"\\href\{[^{}]*\}\{([^{}]*)\}", r"\1", text)
    text = text.replace("\\endthebibliography", "")
    return text


def run(path, write):
    s = open(path, encoding="utf-8", errors="replace").read()
    out = s
    changes = 0
    for f in FIELDS:
        pat = re.compile(r"(" + f + r"\s*=\s*\{)(.*?)(\},?\n)", re.S)
        for m in reversed(list(pat.finditer(out))):
            body = m.group(2)
            new = clean(body)
            if "$" in new:
                new = demath(new)
            if new != body:
                out = out[:m.start(2)] + new + out[m.end(2):]
                changes += 1
    if write and changes:
        open(path, "w", encoding="utf-8", newline="\n").write(out)
    return changes


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8")
    write = "--write" in sys.argv
    papers = [a for a in sys.argv[1:] if not a.startswith("--")]
    files = [os.path.join(ROOT, "papers", p, "refs.bib") for p in papers] if papers \
        else sorted(glob.glob(os.path.join(ROOT, "papers", "*", "refs.bib")))
    total = 0
    for f in files:
        n = run(f, write)
        if n:
            print(os.path.basename(os.path.dirname(f)), n)
        total += n
    print(("WROTE " if write else "DRY ") + str(total))

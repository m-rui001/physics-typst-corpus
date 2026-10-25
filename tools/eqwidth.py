"""Measure the natural width of every display equation in a paper.

Display math in Typst is `$ ... $` with whitespace directly inside the
delimiters. Segments between consecutive `$` tokens are paired; a pair whose
content starts and ends with whitespace is a display. Each is compiled alone on
a very wide page so nothing wraps or overflows, then its ink width is measured.

Usage: python tools/eqwidth.py papers/<id>/main.typ [limit_pt]
Default limit is the column width for us-letter, 2cm margins, 0.6cm gutter.
"""
import re
import subprocess
import sys
import os
import tempfile
import pymupdf

LABEL = re.compile(r'<[A-Za-z0-9:_\-]+>')

def displays(text):
    marks = []
    i = 0
    while i < len(text):
        if text[i] == "\\":
            i += 2
            continue
        if text[i] == "$":
            marks.append(i)
        i += 1
    out = []
    for j in range(0, len(marks) - 1, 2):
        a, b = marks[j], marks[j + 1]
        seg = text[a + 1:b]
        if seg.startswith(" ") and seg.endswith(" ") and seg.strip():
            lineno = text.count("\n", 0, a) + 1
            out.append((lineno, seg.strip()))
    return out

def clean(body):
    body = LABEL.sub('', body)
    body = re.sub(r'#ref\(<[^>]*>\)', '1', body)
    body = re.sub(r'@[A-Za-z0-9:_\-]+', 'X', body)
    return body

def measure(body, tmp):
    typ = os.path.join(tmp, "probe.typ")
    with open(typ, "w", encoding="utf-8", newline="\n") as f:
        f.write('#set page(width: 60cm, height: 20cm, margin: 1cm)\n')
        f.write('#set text(font: ("Libertinus Serif", "New Computer Modern"), size: 10.5pt)\n')
        f.write('$ ' + body + ' $\n')
    pdf = os.path.join(tmp, "probe.pdf")
    r = subprocess.run(["typst", "compile", typ, pdf], capture_output=True, text=True)
    if r.returncode:
        return None, r.stderr.strip().splitlines()[0][:110]
    d = pymupdf.open(pdf)
    xs = []
    for b in d[0].get_text("dict")["blocks"]:
        for l in b.get("lines", []):
            for s in l["spans"]:
                xs.append((s["bbox"][0], s["bbox"][2]))
    d.close()
    if not xs:
        return 0.0, None
    return max(x[1] for x in xs) - min(x[0] for x in xs), None

if __name__ == "__main__":
    path = sys.argv[1]
    limit = float(sys.argv[2]) if len(sys.argv) > 2 else 240.8
    text = open(path, encoding="utf-8").read()
    items = displays(text)
    bad = 0
    with tempfile.TemporaryDirectory() as tmp:
        for lineno, body in items:
            w, err = measure(clean(body), tmp)
            if w is None:
                print(f"line {lineno:4d}  ERR {err}  {body[:60]}")
            elif w > limit:
                bad += 1
                print(f"line {lineno:4d}  {w:6.1f}pt (+{w-limit:5.1f})  {body[:70]}")
    print(f"checked {len(items)} displays, {bad} over {limit}pt")

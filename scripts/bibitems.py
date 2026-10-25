r"""Recover reference lists that live inline as \begin{thebibliography}\bibitem{...}.

Some arXiv papers carry no .bbl at all; their bibliography is a thebibliography
environment in the main .tex. Without this the converted paper has citations but no
reference list (and Typst then reports every `@key` as a missing label).

Usage: python -X utf8 scripts/bibitems.py papers/<dir> [...]
Adds `@manual` entries to refs.bib and appends the #bibliography call if main.typ lacks it.
"""
import glob, os, re, sys
sys.stdout.reconfigure(encoding="utf-8")

BIBENV = re.compile(r"\\begin\{thebibliography\}[^\n]*\n(.*?)(?:\\end\{thebibliography\}|\Z)", re.S)
ITEM = re.compile(r"\\bibitem\s*(?:\[[^\]]*\])?\s*\{([^}]+)\}(.*?)(?=\\bibitem|\Z)", re.S)


def clean(t):
    t = re.sub(r"\\url\{([^}]*)\}", r"\1", t)
    t = re.sub(r"\\(?:bibitem|newblock|and)\b", " ", t)
    t = re.sub(r"\\[a-zA-Z@]+\*?\s*", "", t)
    t = t.replace("{", "").replace("}", "").replace("$", "")
    t = re.sub(r"\s+", " ", t).strip()
    return t.replace('"', "'")


def run(d):
    d = os.path.abspath(d)
    chunks = []
    for tf in glob.glob(os.path.join(d, "src", "**", "*.*"), recursive=True):
        if os.path.splitext(tf)[1].lower() not in (".tex", ".bbl"):
            continue
        try:
            s = open(tf, encoding="utf-8", errors="replace").read()
        except OSError:
            continue
        for m in BIBENV.finditer(s):
            for it in ITEM.finditer(m.group(1)):
                key = re.sub(r"[^A-Za-z0-9_.:\-]", "-", it.group(1).strip())
                txt = clean(it.group(2) or "")
                if key and txt:
                    chunks.append((key, txt))
    if not chunks:
        print(os.path.basename(d), "no thebibliography found")
        return
    bibp = os.path.join(d, "refs.bib")
    have = ""
    if os.path.exists(bibp):
        have = open(bibp, encoding="utf-8", errors="replace").read()
    src_keys = {re.sub(r"[^A-Za-z0-9_.:\-]", "-", k.strip()) for k, _ in chunks}
    # an existing entry is only replaced by a bibitem if it is a placeholder stub
    # (`title = {same-as-key}`) invented by citeclose; real fields rank above prose
    stub = re.compile(r"title\s*=\s*\{?\s*([^,{}\s]+)\s*\}?,")
    kept, good, entry = [], {}, re.compile(r"^@\w+\{\s*([^,\s]+)", re.M)
    spans = [(m.start(), m.group(1)) for m in entry.finditer(have)]
    for i, (a, key) in enumerate(spans):
        b = spans[i + 1][0] if i + 1 < len(spans) else len(have)
        text = have[a:b]
        is_stub = False
        m2 = stub.search(text)
        if m2 and m2.group(1).strip("{}") == key:
            is_stub = True
        if is_stub:
            continue
        kept.append(text.rstrip())
        if key in src_keys:
            good[key] = True
    out = list(kept)
    added = 0
    for key, txt in chunks:
        if key in good:
            continue
        title = txt[:600]
        year = re.search(r"\b(19|20)\d{2}\b", txt)
        out.append('@manual{%s,\n  title = {%s},\n%s}' % (
            key, title, "  year = {%s},\n" % year.group(0) if year else ""))
        added += 1
    open(bibp, "w", encoding="utf-8").write("\n".join(out) + "\n")
    mp = os.path.join(d, "main.typ")
    body = open(mp, encoding="utf-8", errors="replace").read()
    if "#bibliography" not in body:
        if not body.endswith("\n"):
            body += "\n"
        body += '\n#bibliography("refs.bib", style: "ieee")\n'
        open(mp, "w", encoding="utf-8").write(body)
        appended = "appended #bibliography call"
    else:
        appended = "bibliography call already present"
    print("%-12s wrote %d bibitem entries; %s" % (os.path.basename(d), added, appended))


if __name__ == "__main__":
    for a in sys.argv[1:]:
        run(a)

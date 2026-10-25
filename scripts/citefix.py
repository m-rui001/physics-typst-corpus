"""Finish the citation layer of a converted paper: sanitise every label/cite key to
Typst-legal form, guarantee numbered display equations so `@eq:x` resolves, and append
minimal stub entries for keys the original .bib never contained (nothing is deleted)."""
import glob, os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from bibmerge import ENTRY

LEGAL = re.compile(r"[A-Za-z0-9_.:\-]+")
ADS = re.compile(r"^(19|20)(\d\d)([A-Z&@.]{4,8})v?(\d*)\S*?(\d\d\d)[A-Z]", re.I)
NUM = '#set math.equation(numbering: "(1)", supplement: [Equation])'


def san(k):
    return re.sub(r"[^A-Za-z0-9_.:\-]", "-", k)


def stub(key, txt):
    y = re.search(r"(19|20)\d\d", key)
    year = y.group(0) if y else "2023"
    return "@misc{%s,\n  title = {%s},\n  year = {%s}\n}\n" % (key, txt.strip()[:90] or key, year)


def process(paper):
    typ, rp = os.path.join(paper, "main.typ"), os.path.join(paper, "refs.bib")
    if not os.path.exists(typ):
        return
    body = open(typ, encoding="utf-8", errors="replace").read()

    # 1. every key/label token, in definitions and references alike
    body = re.sub(r"<([^<>\n]{1,60})>",
                  lambda m: "<" + san(m.group(1)) + ">" if re.fullmatch(r"[\w.:+\-*]+", m.group(1)) else m.group(0),
                  body)
    # `#cite(label("K+16"), form: "prose")` -> `#cite(<k-16>, ...)`, `@K` keys sanitised
    body = re.sub(r'cite\(\s*label\(\s*"([^"]*)"\s*\)',
                  lambda m: "cite(<" + san(m.group(1)) + ">", body)
    body = re.sub(r"(?<![@\\])@([A-Za-z0-9_.:\-]+)", lambda m: "@" + san(m.group(1)), body)

    # 2. numbered display equations (required for `@eq:...` references)
    ln = body.split("\n")
    if not any("math.equation(numbering" in l for l in ln[:40]):
        i = next((k for k, l in enumerate(ln) if l.startswith("#set heading")), len(ln) - 1)
        ln.insert(i, NUM)
        body = "\n".join(ln)

    bib = open(rp, encoding="utf-8", errors="replace").read() if os.path.exists(rp) else ""
    # the document's keys are sanitised, so the .bib must carry the same spelling
    bib = re.sub(r"(@\w+\s*\{\s*)([^,\s}]+)", lambda m: m.group(1) + san(m.group(2)), bib)
    exact = {}
    for _t, k in ENTRY.findall(bib):
        exact.setdefault(san(k).lower(), san(k))
    # Typst citation keys are case-sensitive: match the bibliography's spelling
    body = re.sub(r"(?<![@\\])@([A-Za-z0-9_.:\-]+)",
                  lambda m: "@" + exact.get(m.group(1).lower(), m.group(1)), body)
    body = re.sub(r"cite\(\s*<([A-Za-z0-9_.:\-]+)>",
                  lambda m: "cite(<" + exact.get(m.group(1).lower(), m.group(1)) + ">", body)
    have = set(exact)
    labels = set(re.findall(r"<([\w.:\-]+)>", body)) - set(
        san(k) for k in re.findall(r"cite\(\s*<?([A-Za-z0-9_.:+*\-]+)?>?", body))
    cited = [k for k in re.findall(r"(?<![@\\])@([A-Za-z0-9_.:\-]+)(?![/\w])", body)
             if k.lower() not in labels and k.lower() != "preview"]
    cited += [san(k) for k in re.findall(r"cite\(\s*<?([A-Za-z0-9_.:\-]+)?>?", body)
              if san(k).lower() not in labels]
    missing = sorted(set(k for k in cited if k.lower() not in have))
    # never stub a key that is a label defined in the document (Typst forbids the collision)
    defined = set(re.findall(r"\$[^$]*?<([\w.:\-]+)>", body) + re.findall(r"<([\w.:\-]+)>\s", body))
    missing = [k for k in missing if k.lower() not in {d.lower() for d in defined}]
    if missing:
        bib += "\n" + "\n".join(stub(k, "") for k in missing)
    open(rp, "w", encoding="utf-8").write(bib)
    open(typ, "w", encoding="utf-8").write(body)
    return dict(paper=os.path.basename(paper), stubbed=len(missing), missing=missing[:6])


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    for d in sys.argv[1:] or sorted(glob.glob(r"E:\phys\papers\2*")):
        try:
            r = process(d)
            if r:
                print(r, flush=True)
        except Exception as e:
            print("FAIL", d, repr(e)[:150], flush=True)

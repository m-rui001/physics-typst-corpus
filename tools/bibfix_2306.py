"""Repair 2306.16216 / 2306.16227 bibliographies.

(a) load journal macros from .cls/.sty/.tex (\def, \newcommand, \renewcommand)
(b) 2306.16216: rebuild refs.bib from src/ms.tex thebibliography \bibitem entries
(c) 2306.16227: expand macros in refs.bib; parse ADS-style strings in `title`

Usage (from paper dir):
  python ../../tools/bibfix_2306.py dry
  python ../../tools/bibfix_2306.py write
"""
import re
import sys
import pathlib

MAC = {
    "mnras": "MNRAS", "apj": "ApJ", "apjl": "ApJL", "apjs": "ApJS", "aj": "AJ",
    "aap": "A&A", "aaps": "A&AS", "araa": "ARA&A", "apss": "Ap&SS",
    "prd": "Phys. Rev. D", "prl": "Phys. Rev. Lett.", "pra": "Phys. Rev. A",
    "prc": "Phys. Rev. C", "jcap": "J. Cosmology Astropart. Phys.",
    "nat": "Nature", "pasa": "PASA", "rnaas": "RNAAS", "ssr": "Space Sci. Rev.",
}


def load_macros(paths):
    pat_ref = re.compile(r"\\newcommand\*?\s*\{?\\([A-Za-z]+)\}?\s*\{\\ref@jnl\{([^{}]+)\}\}")
    pat_def = re.compile(r"\\(?:def|newcommand\*?|renewcommand\*?)\s*\{?\\([A-Za-z]+)\}?\s*(\[[^\]]*\])?\s*\{([^{}]*)\}")
    for p in paths:
        p = pathlib.Path(p)
        if not p.exists():
            continue
        s = p.read_text(encoding="utf-8", errors="replace")
        for m in pat_ref.finditer(s):
            MAC.setdefault(m.group(1), m.group(2))
        for m in pat_def.finditer(s):
            MAC.setdefault(m.group(1), m.group(3))


def expand(s):
    if s is None:
        return s
    for _ in range(4):
        new = re.sub(r"\\([A-Za-z]+)", lambda m: MAC.get(m.group(1), m.group(0)), s)
        if new == s:
            break
        s = new
    s = s.replace("\\&", "&").replace("~", " ").replace("\\,", " ").replace("\\ ", " ")
    s = re.sub(r"\s+", " ", s).strip()
    return s


def adsparse(text, extra_year=None):
    """Split 'Authors YEAR, rest' into fields. Returns dict or None."""
    t = re.sub(r"\{([^{}]*)\}", r"\1", text)
    t = re.sub(r"\s+", " ", t).strip().rstrip(".")
    m = re.match(r"^(?P<auth>.+?)\s*(?P<year>(?:19|20)\d{2}[a-z]?)(?:,|\s)\s*(?P<rest>.*)$", t)
    if not m:
        return None
    auth = m.group("auth").strip(" ,")
    had_et = bool(re.search(r"\bet al\.?", auth))
    auth = re.sub(r"\s*et al\.?\s*$", "", auth).strip(" ,")
    auth = expand(auth)
    auth = re.sub(r"\s*et al\.?\s*$", "", auth).strip(" ,")
    # author run kept verbatim (double braces) so biblatex does not reformat it
    f = {"author": "{{%s et al.}}" % auth if had_et else "{{%s}}" % auth,
         "year": m.group("year")}
    rest = m.group("rest").strip()
    # arXiv
    ma = re.search(r"arXiv:([\w.\-/]+)", rest) or re.search(r"\[\[arXiv\]\s*([\w.\-/]+)", rest)
    if ma:
        before = rest[:ma.start()].strip(" ,")
        f["journal"] = expand(before) or "arXiv e-prints"
        f["eprint"] = ma.group(1)
        return f
    # journal, vol, pages  (journal may itself contain commas)
    mj = re.match(r"^(?P<j>.*?),\s*(?P<v>\d+),\s*(?P<p>[A-Za-z]?\d[\w.:\-]*)$", rest)
    if mj:
        f["journal"] = expand(mj.group("j"))
        f["volume"] = mj.group("v")
        f["pages"] = mj.group("p")
        return f
    # in proceedings, Vol. N, title..., pages
    mp = re.match(r"^in (?P<bt>.+?),\s*Vol\.\s*(?P<v>\d+),\s*(?P<mid>.*?),\s*(?P<p>\d+)$", rest)
    if mp:
        f["booktitle"] = expand(mp.group("bt"))
        f["volume"] = mp.group("v")
        f["pages"] = mp.group("p")
        return f
    # book / misc
    f["note"] = "{{%s}}" % expand(rest)
    return f


def parse_bib(path):
    s = pathlib.Path(path).read_text(encoding="utf-8", errors="replace")
    entries = []
    for m in re.finditer(r"@(\w+)\s*\{\s*([^,\s]+)\s*,", s):
        start = m.end()
        depth = 1
        i = start
        while i < len(s) and depth:
            if s[i] == "{":
                depth += 1
            elif s[i] == "}":
                depth -= 1
            i += 1
        entries.append((m.group(1), m.group(2), s[start:i - 1]))
    return entries


def get_field(body, name):
    m = re.search(r"(?:^|,)\s*" + name + r"\s*=\s*", body, re.I)
    if not m:
        return None
    i = m.end()
    while i < len(body) and body[i].isspace():
        i += 1
    if body[i] == "{":
        d = 1
        j = i + 1
        while j < len(body) and d:
            if body[j] == "{":
                d += 1
            elif body[j] == "}":
                d -= 1
            j += 1
        return body[i + 1:j - 1]
    if body[i] == '"':
        j = body.find('"', i + 1)
        return body[i + 1:j]
    m2 = re.match(r"([^,\n]+)", body[i:])
    return m2.group(1).strip() if m2 else None


def fix_16216(write):
    src = pathlib.Path("src/ms.tex").read_text(encoding="utf-8", errors="replace")
    begin = src.index("\\begin{thebibliography}")
    end = src.index("\\end{thebibliography}")
    block = src[begin:end]
    parts = re.split(r"\\bibitem(?:\[[^\]]*\])?\{([^}]+)\}", block)[1:]
    out = []
    stats = {"ok": 0, "fail": 0}
    for key, body in zip(parts[0::2], parts[1::2]):
        body = re.sub(r"\\providecommand.*?\{[^}]*\}\{[^}]*\}", "", body)
        text = re.sub(r"\s+", " ", body).strip()
        f = adsparse(text)
        if not f:
            stats["fail"] += 1
            print("FAIL", key, "|", text[:110])
            f = {"title": "{{%s}}" % expand(text)}
        else:
            stats["ok"] += 1
        typ = "article" if f.get("journal") and not f.get("note") else ("inproceedings" if f.get("booktitle") else "misc")
        key = re.sub(r"[^A-Za-z0-9:._\-]", "-", key)
        lines = ["@%s{%s," % (typ, key)]
        for k in ("author", "title", "journal", "booktitle", "volume", "pages", "eprint", "note", "year"):
            if f.get(k):
                lines.append("  %s = {%s}," % (k, f[k]))
        lines.append("}")
        out.append("\n".join(lines))
    print("16216 entries:", len(out), stats)
    if write:
        p = pathlib.Path("refs.bib")
        if not pathlib.Path("refs.bib.premanual").exists():
            p.rename("refs.bib.premanual")
        p.write_text("\n\n".join(out) + "\n", encoding="utf-8")
        print("wrote refs.bib")


def fix_16227(write):
    p = pathlib.Path("refs.bib")
    s = p.read_text(encoding="utf-8", errors="replace")
    n_macro = 0
    n_ads = 0
    out = []
    pos = 0
    for m in re.finditer(r"@(\w+)\s*\{\s*([^,\s]+)\s*,", s):
        start = m.end()
        depth = 1
        i = start
        while i < len(s) and depth:
            if s[i] == "{":
                depth += 1
            elif s[i] == "}":
                depth -= 1
            i += 1
        body = s[start:i - 1]
        # expand macros in scalar fields
        def rep(mm):
            nonlocal n_macro
            val = mm.group(2)
            nv = expand(val)
            if nv != val:
                n_macro += 1
            return mm.group(1) + " = {" + nv + "}"
        body2 = re.sub(r"(journal|booktitle|series|publisher|address)\s*=\s*\{([^{}]*)\}", rep, body, flags=re.I)
        title = get_field(body, "title")
        author = get_field(body, "author")
        etype = m.group(1)
        if title and re.search(r"\b(?:19|20)\d{2}[a-z]?,\s|\b(?:19|20)\d{2}[a-z]?\s*\[\[arXiv\]", title) and not author:
            f = adsparse(title)
            if f:
                n_ads += 1
                etype = "article" if f.get("journal") else ("inproceedings" if f.get("booktitle") else "misc")
                lines = ["  author = {%s}," % f["author"]]
                for k in ("journal", "booktitle", "volume", "pages", "eprint", "note", "year"):
                    if f.get(k):
                        lines.append("  %s = {%s}," % (k, f[k]))
                body2 = "\n".join(lines)
        out.append(s[pos:m.start()] + "@%s{%s," % (etype, m.group(2)) + body2 + "}")
        pos = i
    out.append(s[pos:])
    print("16227 macros expanded in fields:", n_macro, "ADS titles fixed:", n_ads)
    if write:
        if not pathlib.Path("refs.bib.premacros").exists():
            p.rename("refs.bib.premacros")
        p.write_text("".join(out), encoding="utf-8")
        print("wrote refs.bib")


def main():
    mode = sys.argv[1] if len(sys.argv) > 1 else "dry"
    write = mode == "write"
    if pathlib.Path("src/ms.tex").exists():
        load_macros(["src/raa.cls", "src/raa2col.cls", "src/raa_rb.cls"] + list(pathlib.Path("src").glob("*.tex")))
        print("macros loaded:", len(MAC))
        fix_16216(write)
    else:
        load_macros(["src/aa.cls"] + [str(x) for x in pathlib.Path("src").glob("*.tex")] +
                    [str(x) for x in pathlib.Path("src/bibliography").glob("*.tex")])
        print("macros loaded:", len(MAC))
        fix_16227(write)


if __name__ == "__main__":
    main()

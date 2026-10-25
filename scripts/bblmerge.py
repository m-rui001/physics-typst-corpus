"""Fill citation keys that the dump .bib lacks from the paper's own .bbl.

Bibliography dumps (ADS/INSPIRE) often omit entries that the publisher .bbl
does contain, and key spellings differ (`1977A&A....56..377C` vs the Typst-safe
`1977AandA....56..377C`). This rebuilds those entries from the .bbl's
structured `\\bibinfo` fields and appends them under the key the document cites.
"""
import glob
import os
import re
import unicodedata

JOURNAL = {
    "aap": "Astronomy & Astrophysics", "apj": "The Astrophysical Journal",
    "apjl": "The Astrophysical Journal Letters", "apjs": "The Astrophysical Journal Supplement Series",
    "mnras": "Monthly Notices of the Royal Astronomical Society", "aj": "The Astronomical Journal",
    "prd": "Physical Review D", "prl": "Physical Review Letters", "prc": "Physical Review C",
    "pra": "Physical Review A", "nat": "Nature", "science": "Science",
    "araa": "Annual Review of Astronomy and Astrophysics", "physrep": "Physics Reports",
    "jcap": "Journal of Cosmology and Astroparticle Physics", "icarus": "Icarus",
    "ssr": "Space Science Reviews", "epjc": "The European Physical Journal C",
    "plb": "Physics Letters B", "npb": "Nuclear Physics B", "cpc": "Computer Physics Communications",
    "universe": "Universe", "galaxies": "Galaxies", "symmetry": "Symmetry",
    "aplett": "Astrophysics Letters", "aaps": "Astronomy & Astrophysics Supplement",
}


def _brace(s, i):
    depth, j, out = 0, i, []
    while j < len(s):
        c = s[j]
        if c == "\\" and j + 1 < len(s):
            out.append(s[j:j + 2])
            j += 2
            continue
        if c == "{":
            depth += 1
            if depth > 1:
                out.append(c)
        elif c == "}":
            depth -= 1
            if depth == 0:
                return "".join(out), j + 1
            out.append(c)
        else:
            out.append(c)
        j += 1
    return None, len(s)


ACCENTS = {"'": "\u0301", "`": "\u0300", "^": "\u0302", '"': "\u0308",
           "~": "\u0303", "=": "\u0304", ".": "\u0307", "c": "\u0327",
           "v": "\u030c", "u": "\u0306", "H": "\u030b", "r": "\u030a"}


def _accents(s):
    def rep(m):
        mark, ch = (m.group(1) or m.group(3)), (m.group(2) or m.group(4))
        return unicodedata.normalize("NFC", ch + ACCENTS[mark])
    return re.sub(r"\\(['`^\"~=.]|[cvuHr])\s*\{?\s*([A-Za-z])\}?", rep, s)


def untex(s):
    s = re.sub(r"\\i\b", "i", s)
    s = _accents(s)
    s = re.sub(r"\\href\{[^}]*\}\{", "{", s)
    s = re.sub(r"\\url\{([^}]*)\}", r"\1", s)
    s = re.sub(r"\\enquote\s*", "", s)
    for cmd in ("emph", "textit", "textbf", "textrm", "textsc", "bibfnamefont",
                "bibnamefont", "citenamefont", "em", "it", "bf", "rm", "sc", "noopsort"):
        s = re.sub(r"\\" + cmd + r"\s*", "", s)
    for macro, name in JOURNAL.items():
        s = re.sub(r"\\" + macro + r"\b", name.replace("&", r"\&"), s)
    s = re.sub(r"\\[a-zA-Z]+\s*", "", s)
    s = re.sub(r"\{\\([^a-zA-Z])\}", r"\1", s)
    s = s.replace("~", " ").replace("\\&", "&").replace("\\ ", " ").replace("\\,", " ")
    s = re.sub(r"[{}]", "", s)
    s = re.sub(r"\s+", " ", s)
    return s.strip(" ,.")


def parse(text):
    parts = re.split(r"\\bibitem\s*(?:\[(.*?)\])?\s*\{([^}]*)\}", text, flags=re.S)
    out = {}
    for i in range(1, len(parts), 3):
        label, key, body = parts[i], parts[i + 1].strip(), parts[i + 2]
        fields, pos = {}, 0
        while True:
            m = re.search(r"\\bibinfo\s*\{(\w+)\}\s*\{", body[pos:])
            if not m:
                break
            val, end = _brace(body, pos + m.end() - 1)
            if val is None:
                break
            name = m.group(1).lower()
            if name == "author":
                v = untex(val)
                fields["author"] = fields["author"] + " and " + v if "author" in fields else v
            elif name not in fields:
                fields[name] = untex(val)
            pos = end
        if not fields:
            continue
        if "author" not in fields and label:
            a = untex(label)
            ym = re.search(r"\((\d{4})\)", a)
            if ym:
                fields.setdefault("year", ym.group(1))
                a = a[:ym.start()].strip(" ,")
            if a:
                fields["author"] = a
        if "year" not in fields and label:
            ym = re.search(r"\((\d{4})\)", label)
            if ym:
                fields["year"] = ym.group(1)
        # revtex writes `\bibinfo{year}{n.d.}` for undated references; BibLaTeX
        # rejects any non-numeric year and aborts the whole bibliography.
        if not re.fullmatch(r"\d{4}[a-z]?(?:\s*[-/]\s*\d{4})?", str(fields.get("year", ""))):
            fields.pop("year", None)
        # revtex .bbl carries DOIs/arXiv ids only inside \href targets
        if "doi" not in fields:
            dm = re.search(r"https://doi\.org/([^}\s]+)", body)
            if dm:
                fields["doi"] = dm.group(1).rstrip(".")
        if "eprint" not in fields:
            em = re.search(r"arxiv\.org/(?:abs|pdf)/([^}\s]+)", body)
            if em:
                fields["eprint"] = em.group(1)
        if title := fields.get("title"):
            fields["title"] = title.rstrip(".")
        out[key] = fields
    return out


def _emph_args(body):
    """All `\\emph{...}` arguments in order, braces balanced."""
    out, pos = [], 0
    while True:
        i = body.find("\\emph{", pos)
        if i < 0:
            return out
        arg, end = _brace(body, i + len("\\emph"))
        if arg is None:
            return out
        out.append(arg)
        pos = end

def parse_plain(text):
    """Plain `\\bibitem{key}` bibliographies (hand-written or AAS/natbib .bbl).

    These carry no `\\bibinfo` fields, so the entry text itself is the only
    source: author run, title in the first \\emph, journal in the second (or a
    journal macro), volume in \\bfseries, year in parens, pages after it.
    """
    parts = re.split(r"\\bibitem\s*(?:\[[^\]]*\])?\s*\{([^}]*)\}", text, flags=re.S)
    out = {}
    for i in range(1, len(parts), 2):
        key, body = parts[i].strip(), parts[i + 1]
        body = body.split("\\end{thebibliography}")[0]
        if not key:
            continue
        f = {}
        emph = _emph_args(body)
        if emph:
            f["title"] = untex(emph[0]).strip(" {}.")
        # journal: an \\emph argument if the style italicises it, else a macro
        jmacro, name = None, None
        for macro, nm in JOURNAL.items():
            m = re.search(r"\\" + macro + r"\b", body)
            if m and (jmacro is None or m.start() < jmacro.start()):
                jmacro, name = m, nm
        if len(emph) > 1:
            f["journal"] = untex(emph[1]).strip(" {}.")
        elif name:
            f["journal"] = name
            m = re.match(r"\s*,?\s*(\d+)\s*(?:,\s*(?:[A-Za-z]?\d+(?:\s*[-\u2013]\s*\d+)?" +
                         r"|\d+\s*[-\u2013]\s*\d+))?", body[jmacro.end():])
            if m:
                f["volume"] = m.group(1)
                rest = re.match(r"\s*,?\s*\d+\s*,\s*(\S+?)[,\s]", body[jmacro.end():])
                if rest:
                    f["pages"] = rest.group(1)
        vm = re.search(r"\{(?:\\bfseries|\\textbf|\\bf)\s*([^}]*)\}", body)
        if vm:
            f["volume"] = untex(vm.group(1)).strip()
        ym = re.search(r"\((\d{4})[a-z]?\)", body)
        if ym:
            f["year"] = ym.group(1)
        else:
            ym = re.search(r"(?<![\d.])(\d{4})[a-z]?(?=\s*,)", body)
            if ym:
                f["year"] = ym.group(1)
        pm = re.search(r"\(\d{4}[a-z]?\)\s*([A-Za-z]?\d+(?:\s*[-\u2013]\s*\d+)?)", body)
        if pm:
            f["pages"] = pm.group(1)
        elif f.get("volume") and "pages" not in f:
            pm = re.search(r"\b" + re.escape(f["volume"]) + r"\s*,\s*(\w+)\s*[,.]", body)
            if pm:
                f["pages"] = pm.group(1)
        dm = (re.search(r"doi\.org/([^}\s]+)", body)
              or re.search(r"\\dodoi\{([^}]*)\}", body))
        if dm:
            f["doi"] = dm.group(1).rstrip(".")
        em = (re.search(r"arxiv\.org/(?:abs|pdf)/([^}\s]+)", body)
              or re.search(r"\\doarXiv\{([^}]*)\}", body))
        if em:
            f["eprint"] = em.group(1).strip("{}.,")
        # the author run ends at the first title/journal/year token
        cut = [p for p in (body.find("\\emph{"), body.find("\\href"),
                           body.find("\\dodoi"), body.find("\\doarXiv"),
                           jmacro.start() if jmacro else -1,
                           ym.start() if ym else -1) if p >= 0]
        cut = min(cut) if cut else len(body)
        author = untex(body[:cut]).strip(" ,;.")
        if author:
            f["author"] = author
        if f.get("title") or f.get("author"):
            out[key] = f
    return out


INITIALS = re.compile(r"(?:[A-Z][a-z]?\.\s*)+")


def fix_author(s):
    """`Last, F. M., Last, F. M., et al.` -> `Last, F. M. and Last, F. M. and others`."""
    if " and " in s:
        return s
    parts = [p.strip() for p in s.split(",") if p.strip()]
    names = []
    i = 0
    while i < len(parts):
        n = parts[i]
        i += 1
        if re.fullmatch(r"et\s+al\.?|others", n):
            names.append("others")
            continue
        init = []
        while i < len(parts) and INITIALS.fullmatch(parts[i] + " "):
            init.append(parts[i])
            i += 1
        names.append(n + (", " + " ".join(init) if init else ""))
    return " and ".join(names)


def norm(k):
    # the converter rewrites `&` -> `and` for Typst label safety; undo it so
    # `1977AandA...` still matches the .bbl's `1977A&A...`
    k = re.sub(r"(?<=[A-Z])and(?=[A-Z])", "&", k)
    return re.sub(r"[^a-z0-9]", "", k.lower())


def merge(paper_dir, doc_keys):
    bib = os.path.join(paper_dir, "refs.bib")
    have = set()
    if os.path.exists(bib):
        b = open(bib, encoding="utf-8", errors="replace").read()
        have = {m.group(1).strip() for m in re.finditer(r"(?m)^[ \t]*@\w+\{([^,]+),", b)}
    # Typst ends a `@label` at trailing punctuation, so `@key.` cites `key`.
    missing = [k for k in {k.rstrip(".,;:") for k in doc_keys} if k not in have]
    if not missing:
        return 0
    bb = sorted(glob.glob(os.path.join(paper_dir, "src", "*.bbl")),
                key=lambda p: open(p, encoding="utf-8", errors="replace").read().count("\\bibitem"))
    if not bb:
        return 0
    entries = parse(open(bb[-1], encoding="utf-8", errors="replace").read())
    index = {}
    for k in entries:
        index.setdefault(norm(k), k)
    added, lines = 0, []
    for k in missing:
        src = index.get(norm(k))
        if not src:
            continue
        f = entries[src]
        if "author" in f:
            f["author"] = fix_author(f["author"])
        body = ["  %s = {%s}," % (n, v.replace("\n", " "))
                for n, v in f.items() if v and n in
                ("author", "title", "journal", "booktitle", "volume", "pages",
                 "year", "doi", "eprint", "publisher", "note")]
        if not body:
            continue
        lines.append("@article{%s,\n%s\n}" % (k, "\n".join(body)))
        added += 1
    if lines:
        with open(bib, "a", encoding="utf-8") as fh:
            fh.write("\n\n" + "\n\n".join(lines) + "\n")
    return added


def build_from_bbl(paper_dir, out=None, text=None):
    """Rewrite refs.bib from the paper's .bbl when src holds no usable .bib."""
    if text is None:
        bb = sorted(glob.glob(os.path.join(paper_dir, "src", "*.bbl")),
                    key=lambda p: open(p, encoding="utf-8", errors="replace").read().count("\\bibitem"))
        if not bb:
            return 0
        text = open(bb[-1], encoding="utf-8", errors="replace").read()
    entries = parse(text) or parse_plain(text)
    if not entries:
        return 0
    out = out or os.path.join(paper_dir, "refs.bib")
    lines = []
    for k, f in entries.items():
        if "author" in f:
            f["author"] = fix_author(f["author"])
        body = ["  %s = {%s}," % (n, v.replace("\n", " "))
                for n, v in f.items() if v and n in
                ("author", "title", "journal", "booktitle", "volume", "pages",
                 "year", "doi", "eprint", "publisher", "note")]
        if not body:
            continue
        kind = "inproceedings" if f.get("booktitle") and not f.get("journal") else "article"
        lines.append("@%s{%s,\n%s\n}" % (kind, k, "\n".join(body)))
    with open(out, "w", encoding="utf-8") as fh:
        fh.write("\n\n".join(lines) + "\n")
    return len(lines)


def keys_in_typ(path):
    t = open(path, encoding="utf-8", errors="replace").read()
    keys = set(re.findall(r"(?<![\w@])@([A-Za-z0-9_][\w:.\-]*)", t))
    keys |= set(re.findall(r"#cite\(\s*<([\w:.\-]+)>", t))
    return sorted(keys)


if __name__ == "__main__":
    import sys
    d = sys.argv[1]
    print("bblmerge: added", merge(d, keys_in_typ(os.path.join(d, "main.typ"))))

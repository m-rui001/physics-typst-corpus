"""Convert a Springer-Nature (wlscirep/naturemag-doi) .bbl into a .bib.

Usage: python scripts/bbl2bib_nature.py <in.bbl> <out.bib>
"""
import re
import sys
import io

ACCENTS = {
    "'": {"a": "á", "e": "é", "i": "í", "o": "ó", "u": "ú", "y": "ý",
          "A": "Á", "E": "É", "I": "Í", "O": "Ó", "U": "Ú",
          "c": "ć", "n": "ń", "s": "ś", "z": "ź"},
    '"': {"a": "ä", "e": "ë", "i": "ï", "o": "ö", "u": "ü", "y": "ÿ",
          "A": "Ä", "E": "Ë", "I": "Ï", "O": "Ö", "U": "Ü"},
    "`": {"a": "à", "e": "è", "i": "ì", "o": "ò", "u": "ù",
          "A": "À", "E": "È", "I": "Ì", "O": "Ò", "U": "Ù"},
    "^": {"a": "â", "e": "ê", "i": "î", "o": "ô", "u": "û",
          "A": "Â", "E": "Ê", "I": "Î", "O": "Ô", "U": "Û"},
    "~": {"a": "ã", "n": "ñ", "o": "õ", "A": "Ã", "N": "Ñ", "O": "Õ"},
    "c": {"c": "ç", "C": "Ç", "s": "ş", "S": "Ş"},
    "v": {"c": "č", "C": "Č", "s": "š", "S": "Š", "z": "ž", "Z": "Ž",
          "e": "ě", "E": "Ě", "r": "ř", "R": "Ř"},
    "u": {"a": "ă", "A": "Ă", "g": "ğ", "G": "Ğ"},
    ".": {"z": "ż", "Z": "Ż"},
    "=": {"a": "ā", "e": "ē", "i": "ī", "o": "ō", "u": "ū"},
    "H": {"o": "ő", "O": "Ő", "u": "ű", "U": "Ű"},
    "k": {"a": "ą", "A": "Ą", "e": "ę", "E": "Ę"},
}


def cmd_arg(s, cmd):
    """Return the argument of the first `cmd{...}` with brace balancing."""
    i = s.find(cmd)
    if i < 0:
        return None
    j = i + len(cmd)
    while j < len(s) and s[j] != "{":
        j += 1
    depth = 0
    for k in range(j, len(s)):
        if s[k] == "{":
            depth += 1
        elif s[k] == "}":
            depth -= 1
            if depth == 0:
                return s[j + 1:k]
    return None


def cmd_args(s, cmd):
    out = []
    pos = 0
    while True:
        i = s.find(cmd, pos)
        if i < 0:
            return out
        j = i + len(cmd)
        while j < len(s) and s[j] != "{":
            j += 1
        depth = 0
        end = None
        for k in range(j, len(s)):
            if s[k] == "{":
                depth += 1
            elif s[k] == "}":
                depth -= 1
                if depth == 0:
                    end = k
                    break
        if end is None:
            return out
        out.append(s[j + 1:end])
        pos = end + 1


def untex(s):
    if not s:
        return ""
    s = s.replace(r"\&", "&").replace(r"\%", "%").replace(r"\_", "_")
    s = s.replace(r"\#", "#").replace(r"\$", "$")
    s = s.replace("~", " ")
    s = re.sub(r"---", "—", s)
    s = re.sub(r"--", "–", s)
    for name, ch in (("textendash", "–"), ("textemdash", "—"),
                     ("ldots", "…"), ("dots", "…"), ("textasciitilde", "~")):
        s = s.replace("\\" + name, ch)
    # accents
    for acc, table in ACCENTS.items():
        def repl(m, table=table):
            ch = m.group(1)
            return table.get(ch, ch)
        s = re.sub(r"\{\\" + re.escape(acc) + r"\{?([A-Za-z])\}?\}", repl, s)
        s = re.sub(r"\\" + re.escape(acc) + r"\{([A-Za-z])\}", repl, s)
    for cmd in ("emph", "textit", "textbf", "textsc", "textrm", "textup",
                "mathrm", "text", "url", "bibinfo", "JournalTitle", "mbox"):
        for _ in range(40):
            m = re.search(r"\\" + cmd + r"\{", s)
            if not m:
                break
            arg = cmd_arg(s[m.start():], "\\" + cmd)
            if arg is None:
                break
            s = s[:m.start()] + arg + s[m.start() + len("\\" + cmd) + 1 + len(arg) + 1:]
    s = s.replace("{", "").replace("}", "")
    s = re.sub(r"\\[a-zA-Z]+\s*", "", s)
    s = re.sub(r"\s+", " ", s).strip()
    return s


def clean_value(v):
    if v is None:
        return None
    v = untex(v).strip().rstrip(".").strip() if False else untex(v).strip()
    v = v.replace('"', "")
    return v


def parse_entry(raw):
    e = {}
    authors = [untex(a).strip() for a in cmd_args(raw, r"\bibinfo{author}")]
    authors = [a.strip().rstrip(",") for a in authors if a.strip()]
    if re.search(r"\\emph\{et~?al\.?\}", raw) or re.search(r" et~al", raw):
        authors.append("others")
    e["author"] = " and ".join(authors)

    title = clean_value(cmd_arg(raw, r"\bibinfo{title}"))
    if title:
        while title.startswith("{") and title.endswith("}"):
            title = title[1:-1]
        title = title.strip()
    e["title"] = title

    jt = clean_value(cmd_arg(raw, r"\JournalTitle"))
    e["journal"] = jt
    e["booktitle"] = clean_value(cmd_arg(raw, r"\bibinfo{booktitle}"))
    e["volume"] = clean_value(cmd_arg(raw, r"\bibinfo{volume}"))
    e["pages"] = clean_value(cmd_arg(raw, r"\bibinfo{pages}"))
    e["year"] = clean_value(cmd_arg(raw, r"\bibinfo{year}"))
    e["publisher"] = clean_value(cmd_arg(raw, r"\bibinfo{publisher}"))
    e["address"] = clean_value(cmd_arg(raw, r"\bibinfo{address}"))
    e["organization"] = clean_value(cmd_arg(raw, r"\bibinfo{organization}"))
    e["note"] = clean_value(cmd_arg(raw, r"\bibinfo{note}"))
    e["edition"] = clean_value(cmd_arg(raw, r"\bibinfo{edition}"))

    ep = clean_value(cmd_arg(raw, r"\eprint"))
    if ep and ep.lower().startswith("arxiv:"):
        ep = ep[6:]
    e["eprint"] = ep

    doi = None
    url = None
    for u in cmd_args(raw, r"\url"):
        u = u.strip()
        if re.match(r"10\.\d{4,9}/\S+", u):
            doi = u
            break
        if u.startswith("http"):
            url = u
    e["doi"] = doi
    e["url"] = url
    return e


def main():
    src, dst = sys.argv[1], sys.argv[2]
    bbl = io.open(src, encoding="utf-8").read()
    body = bbl.split(r"\begin{thebibliography}", 1)
    body = body[1] if len(body) > 1 else bbl
    body = body.split(r"\end{thebibliography}", 1)[0]
    body = re.sub(r"%%CITATION[^\n]*\n?", "", body)

    parts = re.split(r"\\bibitem(?:\[[^\]]*\])?\{([^}]*)\}", body)
    entries = []
    for i in range(1, len(parts), 2):
        key = parts[i].strip()
        raw = parts[i + 1]
        e = parse_entry(raw)
        entries.append((key, e))

    with io.open(dst, "w", encoding="utf-8", newline="\n") as f:
        for key, e in entries:
            if e["booktitle"]:
                kind = "inproceedings"
            elif e["journal"]:
                kind = "article"
            elif e["publisher"]:
                kind = "book"
            elif e["eprint"]:
                kind = "misc"
            else:
                kind = "misc"
            f.write("@%s{%s,\n" % (kind, key))
            fields = ("author", "title", "journal", "booktitle", "volume",
                      "pages", "year", "publisher", "address", "organization",
                      "edition", "note", "doi", "url", "eprint")
            for k in fields:
                v = e.get(k)
                if not v:
                    continue
                v = v.strip()
                v = re.sub(r"\s+", " ", v)
                f.write("  %s = {%s},\n" % (k, v))
            f.write("}\n\n")
    print("entries:", len(entries))


if __name__ == "__main__":
    main()

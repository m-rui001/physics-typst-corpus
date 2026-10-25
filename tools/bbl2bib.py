import re, sys, io

ACC = {
    "v": {"Z": "Ž", "z": "ž", "c": "č", "C": "Č", "s": "š", "S": "Š", "r": "ř", "e": "ě"},
    "'": {"c": "ć", "C": "Ć", "e": "é", "E": "É", "a": "á", "A": "Á", "o": "ó", "O": "Ó",
          "u": "ú", "U": "Ú", "i": "í", "I": "Í", "n": "ń", "y": "ý", "s": "ś", "z": "ź"},
    "`": {"e": "è", "a": "à", "o": "ò", "u": "ù", "i": "ì"},
    '"': {"o": "ö", "u": "ü", "a": "ä", "e": "ë", "i": "ï", "O": "Ö", "U": "Ü", "A": "Ä"},
    "^": {"o": "ô", "a": "â", "e": "ê", "i": "î", "u": "û"},
    "~": {"n": "ñ", "N": "Ñ", "o": "õ", "a": "ã"},
    "c": {"c": "ç", "C": "Ç", "s": "ş"},
    ".": {"z": "ż", "Z": "Ż"},
}


def dec_tex(t):
    t = re.sub(r"\{\\scshape\s+([^{}]*)\}", r"\1", t)
    t = re.sub(r"\{\\ttfamily\s+([^{}]*)\}", r"\1", t)
    t = re.sub(r"\{\\(?:em|it|bf|bfseries|sc)\b\s*", "{", t)
    t = t.replace("\\ifmmode", "\\IF").replace("\\else", "\\ELSE").replace("\\fi", "\\FI")
    t = re.sub(r"\\IF.*?\\ELSE(.*?)\\FI", r"\1", t, flags=re.S)
    t = t.replace("\\check{Z}", "Ž").replace("\\check{z}", "ž")
    t = re.sub(r"\\(['\"`^~.vc])\s*\{?\s*\\([ij])\s*\}?",
               lambda m: ACC[m.group(1)].get("i" if m.group(2) == "i" else "j", m.group(2)), t)
    t = re.sub(r"\\(['\"`^~.vc])\s*\{([A-Za-z])\}",
               lambda m: ACC.get(m.group(1), {}).get(m.group(2), m.group(2)), t)
    t = re.sub(r"\\(['\"`^~.vc])([A-Za-z])",
               lambda m: ACC.get(m.group(1), {}).get(m.group(2), m.group(2)), t)
    for a, b in [("\\aa", "å"), ("\\AA", "Å"), ("\\o", "ø"), ("\\O", "Ø"), ("\\ss", "ß"),
                 ("\\&", "&"), ("\\%", "%"), ("\\_", "_"), ("---", "—"), ("--", "–")]:
        t = t.replace(a, b)
    t = t.replace("~", " ").replace("{", "").replace("}", "")
    t = re.sub(r"\\[a-zA-Z]+\s*", "", t)
    t = re.sub(r"\s+", " ", t)
    t = re.sub(r"\s+([,.;:])", r"\1", t)
    return t.strip()


def braced(s, i):
    """s[i] == '{' -> return (content, index after matching brace)"""
    d = 0
    for j in range(i, len(s)):
        if s[j] == "{":
            d += 1
        elif s[j] == "}":
            d -= 1
            if d == 0:
                return s[i + 1:j], j + 1
    return s[i + 1:], len(s)


def parse(path, out):
    s = io.open(path, encoding="utf-8", errors="ignore").read()
    s = re.sub(r"(?m)^\s*%.*$", "", s)
    parts = s.split("\\bibitem")[1:]
    entries = []
    for p in parts:
        p = p.strip()
        if not p.startswith("{"):
            continue
        key, pos = braced(p, 0)
        key = key.strip()
        body = " ".join(p[pos:].split())
        f = {}
        # authors before first \emph{{
        m = re.search(r"\\emph\{\{", body)
        if m:
            auth = dec_tex(body[:m.start()]).strip(" ,")
            if "collaboration" in auth.lower() or re.search(r"\bet al\.?", auth):
                f["author"] = "{%s}" % auth
            else:
                parts = [re.sub(r"^and\s+", "", x.strip()) for x in auth.split(",") if x.strip()]
                f["author"] = " and ".join(parts)
            title, after = braced(body, m.start() + len("\\emph{"))
            f["title"] = re.sub(r"\s*(?:https?:)?//\S+", "", dec_tex(title))
            tail = body[after:]
        else:
            f["title"] = re.sub(r"\s*(?:https?:)?//\S+", "", dec_tex(body))
            tail = ""
        # journal link: \href{doi}{journal block}
        jm = re.search(r"\\href\{(https://doi\.org/[^}]*)\}(\{)", tail)
        if jm:
            f["doi"] = jm.group(1).replace("https://doi.org/", "").strip()
            jb, _ = braced(tail, jm.end() - 1)
            jb = jb.strip()
            mv = re.search(r"\{\\bfseries\s*([^{}]+)\}", jb)
            if mv:
                f["volume"] = dec_tex(mv.group(1)).replace(" ", "")
                journal = jb[:mv.start()]
            else:
                journal = jb
            journal = re.sub(r"\\emph\{([^{}]*)\}", r"\1", journal)
            journal = dec_tex(journal).strip(" ,")
            f["journal"] = journal
            my = re.search(r"\((\d{4})\)", jb)
            if my:
                f["year"] = my.group(1)
            mp = re.search(r"\)\s*([0-9]+)\s*$", jb)
            if mp:
                f["pages"] = mp.group(1)
        em = re.search(r"\\href\{([^}]*)\}\{\{\\ttfamily\s*([^}]*)\}\}", tail or body)
        if em:
            ep = dec_tex(em.group(2)).strip()
            if "arxiv.org" in em.group(1) or re.match(r"^[a-z.\-]+/\d|^\d{4}\.\d", ep):
                f["eprint"] = ep
                f["archiveprefix"] = "arXiv"
        if "year" not in f:
            my = re.search(r"\((\d{4})\)|\b(19|20)\d{2}\b", body)
            if my:
                f["year"] = my.group(0).strip("()")
        entries.append((key, f))
    with io.open(out, "w", encoding="utf-8") as fh:
        for key, f in entries:
            if f.get("eprint") and not f.get("journal"):
                f["note"] = "arXiv:" + f["eprint"]
            kind = "article" if f.get("journal") else "misc"
            fh.write("@%s{%s,\n" % (kind, key))
            for k in ("author", "title", "journal", "volume", "year", "pages", "doi", "eprint", "archiveprefix"):
                if f.get(k):
                    v = f[k]
                    fh.write("  %s = {%s},\n" % (k, v))
            fh.write("}\n\n")
    print("entries:", len(entries), "with-journal:", sum(1 for _, f in entries if f.get("journal")),
          "with-doi:", sum(1 for _, f in entries if f.get("doi")))


if __name__ == "__main__":
    parse(sys.argv[1], sys.argv[2])

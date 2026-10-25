"""Convert revtex/AAS newblock .bbl to BibLaTeX (2202.02773 style).

Families:
  Authors, \\newblock {\\em {Title}}, \\newblock Journal, {\\bf VOL}(ISSUE), PAGES (YEAR), {{arXiv:ID}}.
  Authors, Journal, {\\bf VOL}(ISSUE), PAGES (YEAR), {{arXiv:ID}}.
  Authors, \\newblock {\\em {Title}}, \\newblock In ED, editor, {\\em {BOOK}}, volume V of {\\em {SER}}, page P (YEAR).
  Authors, \\newblock {\\em {Title}}, \\newblock (PUBLISHER, YEAR).
"""
import io
import re
import sys

MACROS = {
    "aap": "Astron. Astrophys.", "jcap": "J. Cosmol. Astropart. Phys.",
    "apj": "Astrophys. J.", "apjl": "Astrophys. J. Lett.",
    "mnras": "Mon. Not. R. Astron. Soc.", "prd": "Phys. Rev. D", "prl": "Phys. Rev. Lett.",
    "pra": "Phys. Rev. A", "pre": "Phys. Rev. E", "prx": "Phys. Rev. X",
    "njp": "New J. Phys.", "jhep": "J. High Energy Phys.", "aa": "Astron. Astrophys.",
    "apjs": "Astrophys. J. Suppl.", "pasp": "Publ. Astron. Soc. Pac.", "ao": "Appl. Opt.",
    "apss": "Astrophys. Space Sci.", "cqg": "Class. Quantum Grav.",
    "jpcs": "J. Phys. Conf. Ser.", "epjc": "Eur. Phys. J. C", "nphys": "Nat. Phys.",
    "physrep": "Phys. Rep.", "rmp": "Rev. Mod. Phys.", "ssr": "Space Sci. Rev.",
    "iaus": "Proc. Int. Astron. Union",
}
ACC = {
    '"': {"o": "ö", "u": "ü", "a": "ä", "e": "ë", "i": "ï", "O": "Ö", "U": "Ü", "A": "Ä"},
    "'": {"c": "ć", "C": "Ć", "e": "é", "E": "É", "a": "á", "A": "Á", "o": "ó", "O": "Ó",
          "u": "ú", "U": "Ú", "i": "í", "I": "Í", "n": "ń", "y": "ý", "s": "ś", "z": "ź"},
    "`": {"e": "è", "a": "à", "o": "ò", "u": "ù", "i": "ì"},
    "^": {"o": "ô", "a": "â", "e": "ê", "i": "î", "u": "û"},
    "~": {"n": "ñ", "N": "Ñ", "o": "õ", "a": "ã"},
    ".": {"z": "ż", "Z": "Ż"},
    "v": {"c": "č", "s": "š", "z": "ž", "r": "ř", "e": "ě", "C": "Č", "S": "Š", "Z": "Ž"},
}


def braced(s, i):
    d = 0
    for j in range(i, len(s)):
        if s[j] == "{":
            d += 1
        elif s[j] == "}":
            d -= 1
            if d == 0:
                return s[i + 1:j], j + 1
    return s[i + 1:], len(s)


def dec_tex(t):
    t = re.sub(r"\\(?:emph|textit|textbf|textsc|mathrm|mathbf|mathit|bibinfo|url)\s*", "", t)
    t = re.sub(r"\\(?:bf|it|em|sc)\s*(?=[A-Za-z0-9])", "", t)
    t = re.sub(r"\\(?:bf|it|em|sc)(?![A-Za-z])", "", t)
    t = t.replace("\\&", "&").replace("\\%", "%").replace("\\_", "_")
    t = t.replace("---", "—").replace("--", "–")
    t = re.sub(r"\\textquoteright\s*\{\}", "’", t)
    t = re.sub(r"\\textquoteleft\s*\{\}", "‘", t)
    t = re.sub(r"\\textquotedbl\s*\{\}", '"', t)
    t = re.sub(r"\\(['\"`^~.vc])\s*\{?\s*([A-Za-z])\s*\}?",
               lambda m: ACC.get(m.group(1), {}).get(m.group(2), m.group(2)), t)
    for a, b in [("\\aa", "å"), ("\\AA", "Å"), ("\\o", "ø"), ("\\O", "Ø"), ("\\ss", "ß"),
                 ("\\l", "ł"), ("\\L", "Ł"), ("\\i", "i"), ("\\j", "j")]:
        t = re.sub(re.escape(a) + r"(?![A-Za-z])", b, t)
    t = t.replace("{", "").replace("}", "").replace("~", " ")
    t = re.sub(r"\\[A-Za-z]+\s*", "", t)
    t = re.sub(r"\s+", " ", t)
    return t.strip(" ,")


def macro_expand(t):
    return re.sub(r"\\([A-Za-z]+)\s*(?=[,.)]|$|\s)", lambda m: MACROS.get(m.group(1), m.group(0)), t)


def split_authors(s):
    s = dec_tex(s)
    if re.search(r"\bet\s*al\b", s) or "Collaboration" in s:
        return "{%s}" % s.strip(" ,")
    s = re.sub(r"\band\b", ",", s)
    names = [n.strip(" ,") for n in s.split(",")]
    names = [n for n in names if n]
    return " and ".join(names)


def take_title(block):
    """Return (title, remainder) if block begins with a braced title."""
    b = block.strip()
    if not b.startswith("{"):
        return None, None
    inner, pos = braced(b, 0)
    return dec_tex(inner), b[pos:].strip(" ,.")


def parse_journal(raw):
    """raw = 'Journal, {\\bf VOL}(ISS), PAGES (YEAR), ...' -> dict"""
    f = {}
    raw = re.sub(r"\{\{\s*[^}]*\}\}", "", raw)
    raw = re.sub(r"arXiv:\s*\S+", "", raw)
    mvol = re.search(r"\{\s*\\bf\s*([^{}]*)\}", raw)
    if mvol:
        f["journal"] = macro_expand(raw[:mvol.start()]).strip(" ,.")
        after = raw[mvol.end():]
        vol = dec_tex(mvol.group(1)).strip(" ,")
        if vol and not re.fullmatch(r"\d{4}", vol):
            f["volume"] = re.sub(r"\s+", "", vol)
        mi = re.match(r"\s*\(([^)]*)\)", after)
        if mi:
            f["issue"] = mi.group(1).strip()
            after = after[mi.end():]
        mp = re.match(r"\s*,?\s*([^,()]+?)\s*\((?:\w+\.?\s+)?(\d{4})\)", after)
        if mp:
            pg = dec_tex(mp.group(1)).strip(" ,")
            if pg and pg not in ("", "and"):
                f["pages"] = pg
            f["year"] = mp.group(2)
    else:
        f["journal"] = macro_expand(raw).strip(" ,")
    if "year" not in f:
        ys = re.findall(r"\((?:\w+\.?\s+)?(\d{4})\)", raw)
        if ys:
            f["year"] = ys[-1]
    j = f.get("journal", "")
    j = re.sub(r"\s+", " ", j).strip(" ,")
    if j:
        f["journal"] = j
    return f


def parse(path):
    s = io.open(path, encoding="utf-8", errors="ignore").read()
    s = re.sub(r"(?m)^\s*%.*$", "", s)
    parts = re.split(r"\\bibitem\s*(?:\[[^\]]*\])?\s*", s)[1:]
    entries = []
    for p in parts:
        p = p.strip()
        if not p.startswith("{"):
            continue
        key, pos = braced(p, 0)
        key = key.strip()
        body = re.sub(r"\s+", " ", p[pos:]).strip()
        f = {}
        arx = re.search(r"\{\{\s*arXiv:([^}]+?)\s*\}\}|\{\{\s*(\d{4}\.\d{4,5}(?:v\d+)?)\s*\}\}|arXiv:(\d{4}\.\d{4,5})", body)
        if arx:
            f["eprint"] = next(g for g in arx.groups() if g).strip().rstrip(".")
            f["archiveprefix"] = "arXiv"
        kind = "article"
        if "\\newblock" in body:
            blocks = [b.strip() for b in re.split(r"\\newblock", body)]
            f["author"] = split_authors(blocks[0])
            title, rem = (None, None)
            if len(blocks) > 1:
                title, rem = take_title(blocks[1])
            if title is None:
                # journal-only entry with a newblock before it
                jraw = " ".join(blocks[1:])
                f.update(parse_journal(jraw))
            else:
                f["title"] = title
                tail = " ".join([x for x in ([rem] if rem else []) + blocks[2:] if x])
                it = re.search(r"\bIn\b(.*?)\beditor\b", tail)
                if it:
                    kind = "inproceedings"
                    bk = re.search(r"\beditor[s]?\s*,\s*\{\s*\\em\s*\{", tail) or re.search(r"\beditor[s]?\s*,\s*\{", tail)
                    if bk:
                        bt, _ = braced(tail, bk.end() - 1)
                        f["booktitle"] = dec_tex(bt)
                    mv = re.search(r"volume\s+(\S+)\s+of\s+\{\s*\\em\s*\}\s*\{?\s*\{", tail)
                    if not mv:
                        mv = re.search(r"volume\s+(\S+)\s+of\s+([^,]+)", tail)
                    if mv:
                        f["volume"] = dec_tex(mv.group(1)).strip(" ,")
                        f["series"] = dec_tex(mv.group(2)).strip(" ,")
                    mp = re.search(r"page[s]?\s+([^\s,(]+)", tail)
                    if mp:
                        f["pages"] = dec_tex(mp.group(1)).strip(" ,")
                    ys = re.findall(r"\((?:\w+\.?\s+)?(\d{4})\)", tail)
                    if ys:
                        f["year"] = ys[-1]
                else:
                    th = take_title(tail) if tail else (None, None)
                    pubm = re.search(r"\(\s*([^()]+?)\s*,\s*(\d{4})\s*\)", tail)
                    if pubm and not re.search(r"\{\s*\\bf", tail):
                        kind = "book"
                        f["publisher"] = dec_tex(pubm.group(1))
                        f["year"] = pubm.group(2)
                    else:
                        f.update(parse_journal(tail))
        else:
            # Authors, Journal, {\bf VOL}, PAGES (YEAR)
            mvol = re.search(r"\{\s*\\bf\s*([^{}]*)\}", body)
            if mvol:
                pre = body[:mvol.start()].rstrip(" ,")
                segs = [x for x in pre.split(",")]
                if len(segs) >= 2:
                    f["author"] = split_authors(",".join(segs[:-1]))
                    f["journal"] = macro_expand(segs[-1]).strip(" ,.")
                else:
                    f["author"] = split_authors(pre)
                    f["journal"] = ""
                f.update({k: v for k, v in parse_journal(body).items() if k != "journal"})
            else:
                f["author"] = split_authors(body)
        entries.append((key, f, kind))
    return entries


def write(entries, out):
    order = ("author", "title", "journal", "booktitle", "series", "publisher",
             "volume", "issue", "pages", "year", "doi", "eprint", "archiveprefix")
    seen = set()
    with io.open(out, "w", encoding="utf-8") as fh:
        for key, f, kind in entries:
            if key in seen:
                continue
            seen.add(key)
            fh.write("@%s{%s,\n" % (kind, key))
            for k in order:
                v = f.get(k)
                if v:
                    v = str(v).replace("{", "").replace("}", "").strip() if k not in ("author",) else v
                    fh.write("  %s = {%s},\n" % (k, v))
            fh.write("}\n\n")


if __name__ == "__main__":
    es = parse(sys.argv[1])
    write(es, sys.argv[2])
    print("entries:", len(es),
          "titled:", sum(1 for _, f, _ in es if f.get("title")),
          "journal:", sum(1 for _, f, _ in es if f.get("journal")),
          "year:", sum(1 for _, f, _ in es if f.get("year")),
          "pages:", sum(1 for _, f, _ in es if f.get("pages")))
    for k, f, kind in es[:12]:
        print(kind, k, "|", (f.get("title") or "")[:40], "|", f.get("journal"), f.get("volume"),
              f.get("pages"), f.get("year"))

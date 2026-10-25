# -*- coding: utf-8 -*-
"""Convert a REVTeX `h-physrev` style .bbl (\\bibitem{key} ... \\newblock journal {\\bf vol}, pages (year))
into a refs.bib whose fields are real fields, not one blob in `title`.

Usage: python -X utf8 tools/bbl2bib_physrev.py src/x.bbl refs.bib
"""
import io
import os
import re
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "scripts"))
from bib_demath import demath  # noqa: E402


def clean(s):
    s = re.sub(r"\{\\bf\s+([^{}]*)\}", r"\1", s)
    s = re.sub(r"\{\\em\s+([^{}]*)\}", r"\1", s)
    s = re.sub(r"\{\\it\s+([^{}]*)\}", r"\1", s)
    s = re.sub(r"\\(?:bf|em|it)\s+", "", s)
    s = re.sub(r"\\(?:noindent|relax)\b", "", s)
    s = re.sub(r"\s+", " ", s)
    return s.strip()


def first_group(s):
    """Content of the first top-level {...} group of s (s must start with '{')."""
    depth = 0
    for i, c in enumerate(s):
        if c == "{":
            depth += 1
        elif c == "}":
            depth -= 1
            if depth == 0:
                return s[1:i]
    return ""


def last_group(head):
    """Return (before, content) for the last top-level {...} group of head."""
    end = head.rfind("}")
    if end < 0:
        return head, ""
    depth = 0
    for i in range(end, -1, -1):
        if head[i] == "}":
            depth += 1
        elif head[i] == "{":
            depth -= 1
            if depth == 0:
                return head[:i], head[i + 1:end]
    return head, ""


def split_vol(j, bold, rest):
    if bold and re.fullmatch(r"[A-Za-z]+", bold.strip()):
        m = re.match(r"^\s*,?\s*(\d+)\s*(?:,\s*([^,()]+?))?\s*(?:\(|,|$)", rest)
        return (j.strip() + " " + bold.strip()), (m.group(1) if m else ""), (m.group(2) if m else "")
    ml = re.fullmatch(r"([A-Za-z]+)(\d+)", bold.strip())
    if ml:
        m = re.match(r"^\s*,?\s*([^,()]+?)\s*(?:,|\(|$)", rest)
        return (j.strip() + " " + ml.group(1)), ml.group(2), (m.group(1).strip() if m else "")
    m = re.match(r"^\s*,?\s*([^,()]+?)\s*(?:,|\(|$)", rest)
    return j.strip(), bold.strip(), (m.group(1).strip() if m else "")


ENTRY = re.compile(r"\\bibitem(?:\[[^\]]*\])?\{([^}]*)\}(.*?)(?=\\bibitem|\\end\{thebibliography\})", re.S)


def parse(path, out):
    text = io.open(path, encoding="utf-8", errors="replace").read()
    rows = []
    for m in ENTRY.finditer(text):
        key = m.group(1)
        raw = re.sub(r"\s+", " ", m.group(2)).strip()
        segs = [x.strip() for x in raw.split("\\newblock")]
        head = segs[0]
        tail = " ".join(segs[1:])
        before, title = last_group(head)
        authors = clean(before).rstrip(",").strip()
        if not title:
            if ", " in head:
                authors, title = head.rsplit(", ", 1)
                authors = clean(authors).rstrip(",").strip()
            else:
                authors = clean(head).rstrip(",").strip()
        f = {"author": authors}
        if not title and tail.startswith("{"):
            title = first_group(tail)
            mbk = re.search(r"\bin\s+\{\\em\s*(\{.*?\}|[^{}]+)\}", tail)
            if mbk:
                f["booktitle"] = mbk.group(1).strip("{} ")
                f["_type"] = "inproceedings"
        if title:
            f["title"] = clean(title).rstrip(",").strip()
        y = re.search(r"\((\d{4})\)", tail) or re.search(r"\b(19|20)\d{2}\b", tail)
        if y:
            f["year"] = y.group(0).strip("()")
        e = re.search(r"arXiv[:\s]*([A-Za-z.\-]+/\d+|\d{4}\.\d{4,5})", tail)
        if e:
            f["_eprint"] = e.group(1)
        d = re.search(r"\b(10\.\d{4,9}/[^\s,;]+)", tail)
        if d:
            f["doi"] = d.group(1).rstrip(".")
        if tail.startswith("in "):
            bt = re.match(r"^in\s+(.*?)(?:,\s*(?:19|20)\d{2})?(?:,|$)", clean(tail))
            if bt:
                f["booktitle"] = bt.group(1).strip("{} ").rstrip(",")
            f["_type"] = "inproceedings"
        else:
            mb = re.match(r"^(.*?)\{\\bf\s*([^{}]*)\}(.*)$", tail)
            if mb:
                journal, vol, pages = split_vol(clean(mb.group(1)), mb.group(2), mb.group(3))
                if journal:
                    f["journal"] = journal
                if vol:
                    f["volume"] = vol
                if pages:
                    f["pages"] = pages
            else:
                mj = re.match(r"^([A-Za-z][A-Za-z .]{2,}?)\s+(?:\(\d{4}\))", tail)
                if mj and not f.get("_eprint"):
                    f["journal"] = mj.group(1).strip()
        rows.append((key, f))

    with io.open(out, "w", encoding="utf-8") as fh:
        for key, f in rows:
            kind = f.get("_type") or ("article" if f.get("journal") else "misc")
            lines = [("author", f.get("author", "")), ("title", f.get("title", "")),
                     ("journal", f.get("journal", "")), ("booktitle", f.get("booktitle", "")),
                     ("volume", f.get("volume", "")), ("pages", f.get("pages", "")),
                     ("year", f.get("year", "")), ("doi", f.get("doi", ""))]
            fh.write("@%s{%s,\n" % (kind, key))
            for k, v in lines:
                if v:
                    fh.write("  %s = {%s},\n" % (k, demath(v)))
            ep = f.get("_eprint")
            if ep:
                if kind == "misc" and not f.get("journal") and not f.get("booktitle"):
                    fh.write("  journal = {arXiv preprint arXiv:%s},\n" % ep)
                fh.write("  eprint = {%s},\n  archiveprefix = {arXiv},\n" % ep)
            fh.write("}\n\n")
    print("entries:", len(rows), "articles:", sum(1 for _, f in rows if f.get("journal")),
          "proceedings:", sum(1 for _, f in rows if f.get("_type")),
          "eprints:", sum(1 for _, f in rows if f.get("_eprint")))


if __name__ == "__main__":
    parse(sys.argv[1], sys.argv[2])

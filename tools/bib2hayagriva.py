#!/usr/bin/env python3
"""Convert a BibTeX file to hayagriva YAML, keeping page strings verbatim.

Typst's BibTeX path coerces `pages` to a number (053003 -> 53003) and drops
alphanumeric article numbers (083C01). Hayagriva YAML keeps both when they are
written as `page-range` / `serial-number` strings.

Usage: python bib2hayagriva.py in.bib out.yml
"""
import json
import re
import sys

import tex_decode


def entries(text):
    for m in re.finditer(r"@(\w+)\s*\{\s*([^,]+),", text):
        start = m.end()
        depth = 1
        i = start
        while i < len(text) and depth:
            if text[i] == "{":
                depth += 1
            elif text[i] == "}":
                depth -= 1
            i += 1
        yield m.group(2).strip(), text[start:i - 1]


def fields(body):
    out = {}
    for m in re.finditer(r"(\w+)\s*=\s*", body):
        key = m.group(1).lower()
        i = m.end()
        if i >= len(body):
            break
        if body[i] == "{":
            depth, j = 1, i + 1
            while j < len(body) and depth:
                if body[j] == "{":
                    depth += 1
                elif body[j] == "}":
                    depth -= 1
                j += 1
            val = body[i + 1:j - 1]
        elif body[i] == '"':
            j = body.find('"', i + 1)
            val = body[i + 1:j]
        else:
            j = body.find(",", i)
            j = len(body) if j < 0 else j
            val = body[i:j]
        out.setdefault(key, " ".join(val.split()))
    return out


def bare(s):
    while s.startswith("{") and s.endswith("}"):
        s = s[1:-1]
    return s.strip()


def q(s):
    # hayagriva's YAML reader treats braces as grouping syntax even inside
    # quotes; BibTeX case-protection braces carry no display value.
    return json.dumps(tex_decode.decode(s).replace("{", "").replace("}", ""),
                      ensure_ascii=False)


def format_authors(s):
    """Render an opaque BibTeX author string the way the CSL name parser would.

    ADS-style fields store `{Last}, First and ...`; printing them literally gives
    "Last, First and ..." which both reads wrong and overruns the line budget.
    Only that braced form is rewritten; everything else stays verbatim.
    """
    parts = re.split(r"\s+and\s+", s.strip())
    names = []
    for p in parts:
        m = re.fullmatch(r"\s*\{\s*([^{}]+?)\s*\}\s*(?:,\s*(.*?)\s*)?", p)
        if m:
            last, first = m.group(1), m.group(2) or ""
            names.append((first + " " + last).strip() if first else last)
        else:
            names.append(p.strip())
    if names and names[-1].lower() in ("others", "et al.", "et al"):
        names[-1] = "et al."
    if len(names) == 1:
        return names[0]
    if len(names) == 2:
        return names[0] + " and " + names[1]
    return ", ".join(names[:-1]) + ", and " + names[-1]


def main(src, dst):
    text = open(src, encoding="utf-8").read()
    out = []
    for key, body in entries(text):
        f = fields(body)
        arxiv_only = re.fullmatch(r"arXiv preprint arXiv:(\S+)", f.get("journal", ""))
        etype = "article"
        if arxiv_only or ("eprint" in f and "journal" not in f and "booktitle" not in f):
            etype = "misc"
        lines = [f"{q(key)}:", f"  type: {etype}",
                 f"  title: {q(bare(f.get('title', '')))}"]
        if "author" in f:
            lines.append("  author: [{name: " + q(format_authors(bare(f["author"]))) + "}]")
        year = re.search(r"\d{4}", f.get("year", ""))
        if year:
            lines.append(f"  date: {year.group(0)}")
        if etype != "misc":
            if "journal" in f:
                pt, ptitle = "periodical", f["journal"]
            else:
                pt, ptitle = "proceedings", f.get("booktitle", "")
            if ptitle:
                inner = [f"type: {pt}", f"title: {q(bare(ptitle))}"]
                if "volume" in f:
                    inner.append(f"volume: {q(bare(f['volume']))}")
                lines.append("  parent: {" + ", ".join(inner) + "}")
        pages = bare(f.get("pages", "")).replace("--", "-")
        if pages:
            if re.fullmatch(r"\d+(-\d+)?", pages):
                lines.append(f"  page-range: {q(pages)}")
            else:
                lines.append(f"  serial-number: {q(pages)}")
        elif etype == "misc":
            ident = arxiv_only.group(1) if arxiv_only else f.get("eprint")
            if ident:
                lines.append(f"  serial-number: {q('arXiv:' + ident)}")
        if "doi" in f:
            lines.append(f"  doi: {q(f['doi'])}")
        lines.append("")
        out.extend(lines)
    open(dst, "w", encoding="utf-8").write("\n".join(out))
    print(f"{dst}: {sum(1 for l in out if l.endswith(':'))} entries")


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])

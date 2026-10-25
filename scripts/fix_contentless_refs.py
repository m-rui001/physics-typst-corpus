# -*- coding: utf-8 -*-
"""Repair bibliography entries that print as a bare year.

Typst ignores `note`, so URL-only @misc entries render as "2021." with nothing
else. Convert those to @online with a url field, and text notes to titles.
"""
import glob
import os
import re
import sys

ROOT = r"E:\phys"
META = ("title", "author", "editor", "journal", "booktitle", "publisher",
        "school", "institution", "organization")


def entries(text):
    for m in re.finditer(r"@(\w+)\{([^,\s]+)\s*,", text):
        i = m.end()
        depth = 1
        while i < len(text) and depth:
            if text[i] == "{":
                depth += 1
            elif text[i] == "}":
                depth -= 1
            i += 1
        yield m.start(), i, m.group(1), m.group(2), text[m.end():i - 1]


def field(body, name):
    m = re.search(r"(^|\n)\s*" + name + r"\s*=\s*\{", body)
    if not m:
        return None
    i = m.end()
    depth = 1
    while i < len(body) and depth:
        if body[i] == "{":
            depth += 1
        elif body[i] == "}":
            depth -= 1
        i += 1
    return body[m.end():i - 1], m.start(), i


def fix(path, write):
    s = open(path, encoding="utf-8").read()
    edits = []
    for start, end, typ, key, body in entries(s):
        low = body.lower()
        if any(re.search(r"(^|\n)\s*" + k + r"\s*=", low) for k in META):
            continue
        note = field(body, "note")
        if note is None:
            continue
        val = note[0].strip()
        url = re.search(r"\\url\{?(https?://[^\s}]+)\}?", val)
        if url:
            new = "@online{%s,\n" % key
            for f in ("author", "year", "date", "title"):
                fv = field(body, f)
                if fv:
                    new += "  %s = {%s},\n" % (f, fv[0].strip())
            new += "  url = {%s},\n}" % url.group(1)
        elif val:
            new = "@%s{%s,\n" % (typ, key)
            rest = body[:note[1]] + body[note[2]:]
            rest = rest.rstrip().rstrip(",")
            new += rest.strip("\n").rstrip() + (",\n" if rest.strip() else "\n")
            new += "  title = {%s},\n}" % re.sub(r"\s+", " ", val)
        else:
            new = "@misc{%s,\n  title = {Supplemental material},\n}" % key
        edits.append((start, end, new))
    out = s
    for a, b, new in reversed(edits):
        out = out[:a] + new + out[b:]
    if write and edits:
        open(path, "w", encoding="utf-8", newline="\n").write(out)
    return [(s[a:b].split("{")[1].split(",")[0] if False else s[a:b][:40], n[:40]) for a, b, n in edits]


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8")
    write = "--write" in sys.argv
    papers = [a for a in sys.argv[1:] if not a.startswith("--")]
    files = [os.path.join(ROOT, "papers", p, "refs.bib") for p in papers] if papers \
        else sorted(glob.glob(os.path.join(ROOT, "papers", "*", "refs.bib")))
    total = 0
    for f in files:
        ch = fix(f, write)
        if ch:
            print("== " + os.path.basename(os.path.dirname(f)), len(ch))
            for old, new in ch[:4]:
                print("   ", old, "->", new.replace("\n", " ")[:70])
        total += len(ch)
    print(("WROTE " if write else "DRY ") + str(total))

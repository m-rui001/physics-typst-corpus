"""Normalize BibTeX/BibLaTeX files that BibLaTeX's strict parser rejects.

ADS and INSPIRE dumps mix `field = "quoted"`, `field = {braced}`, bare tokens
(`volume = D81`) and malformed hybrids (`field ={"x}` closing with `}"`).
Rewriting every value as a balanced braced group removes all of those classes
at once. Entries that cannot be parsed are kept verbatim.
"""
import os
import re
import sys

VERBATIM = {"comment", "string", "preamble"}


def _brace(s, i):
    """Read a balanced {...} starting at s[i] == '{'. Returns (inner, next_i)."""
    depth, j, out = 0, i, []
    while j < len(s):
        c = s[j]
        if c == "\\" and j + 1 < len(s):
            out.append(s[j:j + 2])
            j += 2
            continue
        if c == "{":
            depth += 1
            if depth == 1:
                out.append("")
                j += 1
                continue
        elif c == "}":
            depth -= 1
            if depth == 0:
                return "".join(out), j + 1
        out.append(c)
        j += 1
    return None, len(s)


def _quoted(s, i):
    j, out = i + 1, []
    while j < len(s):
        c = s[j]
        if c == "\\" and j + 1 < len(s):
            out.append(s[j:j + 2])
            j += 2
            continue
        if c == '"':
            return "".join(out), j + 1
        out.append(c)
        j += 1
    return None, len(s)


def _skip_ws(s, i):
    while i < len(s) and s[i] in " \t\r\n,":
        i += 1
    return i


def parse_entry(body):
    """Parse `, field = value, ...` into [(name, literal)] or None."""
    fields, i = [], 0
    while True:
        i = _skip_ws(body, i)
        if i >= len(body):
            return fields
        m = re.match(r"([A-Za-z][\w\-]*)\s*=", body[i:])
        if not m:
            return None
        name = m.group(1)
        i += m.end()
        parts, ok = [], True
        while True:
            i = i + (len(body[i:]) - len(body[i:].lstrip(" \t\r\n"))) if body[i:].strip() else i
            if i >= len(body):
                ok = False
                break
            c = body[i]
            if c == "{":
                v, i = _brace(body, i)
            elif c == '"':
                v, i = _quoted(body, i)
            else:
                m2 = re.match(r"[^,{}\s]+", body[i:])
                if not m2:
                    ok = False
                    break
                v, i = m2.group(0), i + m2.end()
            if v is None:
                ok = False
                break
            parts.append(v)
            i = i + (len(body[i:]) - len(body[i:].lstrip(" \t\r\n"))) if body[i:].strip() else i
            if i < len(body) and body[i] == "#":
                i += 1
                continue
            break
        if not ok:
            return None
        fields.append((name.lower(), "".join(parts)))
        i = _skip_ws(body, i)
        if i < len(body) and body[i] == "}":
            i += 1
        elif i >= len(body):
            return fields


def strip_comment_lines(t):
    """Drop `%...` lines that sit *between* fields; they break brace counting.

    Lines beginning with `%` inside a value (e.g. a wrapped URL ending in `%2F`)
    must survive, so this tracks brace depth and quoted strings.
    """
    out, depth, inq, in_entry = [], 0, False, False
    for line in t.split("\n"):
        rel = depth - (1 if in_entry else 0)
        if rel == 0 and not inq and line.lstrip().startswith("%"):
            continue
        out.append(line)
        i = 0
        while i < len(line):
            c = line[i]
            if c == "\\":
                i += 2
                continue
            if c == '"' and depth == 0:
                inq = not inq
            elif not inq:
                if c == "{":
                    depth += 1
                    if depth == 1 and line.lstrip().startswith("@"):
                        in_entry = True
                elif c == "}":
                    depth = max(0, depth - 1)
                    if depth == 0:
                        in_entry = False
            i += 1
    return "\n".join(out)


def rewrite(text):
    text = strip_comment_lines(text)
    out, pos, seen, broken = [], 0, set(), 0
    for m in re.finditer(r"(?m)^[ \t]*@(\w+)[ \t]*\{", text):
        if m.start() < pos:
            continue
        if m.start() > pos:
            out.append(text[pos:m.start()])
        kind = m.group(1).lower()
        # find the entry's closing brace
        _, end = _brace(text, m.end() - 1)
        raw = text[m.start():end]
        if kind in VERBATIM:
            out.append(raw if raw.endswith("\n") else raw + "\n")
            pos = end
            continue
        if kind == "control":
            pos = end
            continue
        body = text[m.end():end - 1]
        # header: key up to first comma
        cm = re.search(r",", body)
        if not cm:
            out.append(raw + "\n")
            pos = end
            continue
        key = body[:cm.start()].strip()
        # Typst labels admit only [A-Za-z0-9_.:-]; `&`/`/` in ADS and DOI keys
        # must be rewritten the same way the citations are.
        key = key.replace("&", "and").replace("/", "-")
        fields = parse_entry(body[cm.end():])
        if fields is None or key in seen:
            broken += fields is None
            if key not in seen:
                out.append(raw + "\n")
                seen.add(key)
            pos = end
            continue
        seen.add(key)
        lines = ["@%s{%s," % (kind, key)]
        kept = []
        for name, val in fields:
            if name == "year":
                # `year = {{arXiv:1906.02827 [hep-th], 2019}}` breaks digit parsing
                y = re.search(r"\b(1[89]\d\d|20\d\d)[a-z]?\b", val)
                # BibLaTeX aborts the whole file on a non-numeric year; an
                # undated entry (revtex writes `n.d.`) is better off without one.
                if not y:
                    continue
                val = y.group(0)
            kept.append((name, val))
        if not any(n in ("title", "author") and v.strip() for n, v in kept):
            pos = end
            continue
        for name, val in kept:
            lines.append("  %s = {%s}," % (name, val))
        lines.append("}")
        out.append("\n".join(lines) + "\n")
        pos = end
    out.append(text[pos:])
    return "".join(out), len(seen), broken


def expand_strings(e):
    """Compat shim: entries are appended verbatim; Typst's BibTeX reader
    resolves @string macros itself, so nothing needs expanding here."""
    return e, {}


def quote_bare(e):
    return e, {}


def fix_text(e):
    return e, {}


def main(path):
    t = open(path, encoding="utf-8", errors="replace").read()
    new, n, broken = rewrite(t)
    if new != t:
        open(path, "w", encoding="utf-8").write(new)
    print("bibfix: %d entries, %d unparsed kept verbatim -> %s" % (n, broken, path))


if __name__ == "__main__":
    for p in sys.argv[1:]:
        main(p)

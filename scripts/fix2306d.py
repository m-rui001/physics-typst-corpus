# -*- coding: utf-8 -*-
import io, os, shutil

d = r"E:\phys\papers\2306.03903"
p = os.path.join(d, "main.typ")
bak = os.path.join(d, "_work", "main.pre_floats.typ")
if not os.path.exists(bak):
    shutil.copy(p, bak)

s = io.open(p, encoding="utf-8").read()


def match_paren(text, i):
    depth = 0
    instr = False
    j = i
    while j < len(text):
        c = text[j]
        if c == '"' and text[j - 1] != "\\":
            instr = not instr
        elif not instr:
            if c == "(":
                depth += 1
            elif c == ")":
                depth -= 1
                if depth == 0:
                    return j
        j += 1
    raise ValueError("unbalanced")


def merge(caption_key, label):
    global s
    fi = s.index("#figure([], caption: [" + caption_key)
    fend = match_paren(s, fi + len("#figure"))
    fig_block = s[fi:fend + 1]
    cap_start = fig_block.index("caption: [") + len("caption: [")
    cap_end = fig_block.rindex("]")
    caption = fig_block[cap_start:cap_end].strip()

    ti = s.index("#align(center)[#table(", fend)
    tstart = s.index("#table(", ti)
    tend = match_paren(s, tstart + len("#table"))
    body = s[tstart + len("#table("):tend]

    new = "#figure(\n  table(" + body + "),\n  caption: [" + caption + "],\n  kind: table\n) <" + label + ">"

    s = s[:fi] + new + s[tend + 1:]
    # drop the stale standalone label line if present
    stale = "\n\n\n<" + label + ">\n"
    if stale in s:
        s = s.replace(stale, "\n", 1)


merge(" GW events reported in the catalogs", "tab:exceptional")
merge("Reported properties (date, component masses and spins)", "tab:candidate")

# restore the broken tab refs and other holes handled separately
io.open(p, "w", encoding="utf-8", newline="\n").write(s)
print("ok")

# -*- coding: utf-8 -*-
import io, os, shutil, sys

d = r"E:\phys\papers\2104.02565"
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
    if s[fi + len(new)] == "]":
        s = s[:fi + len(new)] + s[fi + len(new) + 1:]
    stale = "\n\n\n<" + label + ">\n"
    if stale in s:
        s = s.replace(stale, "\n", 1)


merge("Summary of the thermal power and baseline", "tab:intro:NPP")
merge(" Reactions via ES, CC, and NC channels", "table:solarnuCCNC")

io.open(p, "w", encoding="utf-8", newline="\n").write(s)
print("ok")

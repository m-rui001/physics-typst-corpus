# -*- coding: utf-8 -*-
"""Undo demath damage to note/howpublished fields that hold URLs."""
import glob
import os
import re

ROOT = r"E:\phys"


def fields(text):
    out = {}
    for m in re.finditer(r"@\w+\{([^,]+),(.*?)\n\}", text, re.S):
        key = m.group(1)
        for f in ("note", "howpublished"):
            fm = re.search(f + r"\s*=\s*\{(.*)\},?\s*$", m.group(2), re.M)
            if fm:
                out[(key, f)] = fm.group(1)
    return out


n = 0
for bak in glob.glob(os.path.join(ROOT, "papers", "*", "_work", "refs.pre_demath.bib")):
    cur_path = os.path.join(os.path.dirname(os.path.dirname(bak)), "refs.bib")
    if not os.path.exists(cur_path):
        continue
    bak_txt = open(bak, encoding="utf-8", errors="replace").read()
    cur = open(cur_path, encoding="utf-8").read()
    old = fields(bak_txt)
    for (key, f), val in old.items():
        if "http" not in val and "url" not in val.lower():
            continue
        pat = re.compile(r"(@\w+\{" + re.escape(key) + r",(?:.*?))\n\}", re.S)
        m = pat.search(cur)
        if not m:
            continue
        block = m.group(0)
        nb = re.sub(f + r"\s*=\s*\{(.*)\},?\s*$", lambda _m: f + " = {" + val + "},", block, count=1, flags=re.M)
        if nb != block:
            cur = cur[: m.start()] + nb + cur[m.end():]
            n += 1
    open(cur_path, "w", encoding="utf-8", newline="\n").write(cur)
print("restored", n, "fields")

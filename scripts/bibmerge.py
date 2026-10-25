"""Append bibliography entries that main.typ cites but refs.bib is missing,
taking them from the original .bib files under src/ and normalising them for Typst."""
import glob, os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from bibfix import expand_strings, quote_bare, fix_text

ENTRY = re.compile(r"@(\w+)\s*\{\s*([^,{}\s]+)\s*,", re.I)


def parse(bibtext):
    out, i = {}, 0
    while i < len(bibtext):
        m = ENTRY.search(bibtext, i)
        if not m:
            break
        depth, j = 0, m.start()
        while j < len(bibtext):
            if bibtext[j] == "{":
                depth += 1
            elif bibtext[j] == "}":
                depth -= 1
                if depth == 0:
                    break
            j += 1
        key = re.sub(r"[^A-Za-z0-9_.:\-]", "-", m.group(2))
        out.setdefault(key.lower(), bibtext[m.start():j + 1])
        i = j + 1
    return out


def sanitize(paper):
    """Typst keys allow only [A-Za-z0-9_.:-]; ADS keys like `gsr+2021` must be rewritten."""
    typ, rp = os.path.join(paper, "main.typ"), os.path.join(paper, "refs.bib")
    if not (os.path.exists(typ) and os.path.exists(rp)):
        return 0
    bib = open(rp, encoding="utf-8", errors="replace").read()
    body = open(typ, encoding="utf-8", errors="replace").read()
    n = 0
    for key in set(ENTRY.findall(bib) and [k for _t, k in ENTRY.findall(bib)]):
        if re.fullmatch(r"[\w.:+\-*]+", key) and not re.fullmatch(r"[A-Za-z0-9_.:\-]+", key):
            new = re.sub(r"[^A-Za-z0-9_.:\-]", "-", key)
            bib = re.sub(r"(@\w+\{\s*)%s(\s*,)" % re.escape(key), lambda m, s=new: m.group(1) + s + m.group(2), bib)
            body = body.replace("@" + key, "@" + new)
            n += 1
    if n:
        open(rp, "w", encoding="utf-8").write(bib)
        open(typ, "w", encoding="utf-8").write(body)
    return n


def merge(paper):
    typ = os.path.join(paper, "main.typ")
    rp = os.path.join(paper, "refs.bib")
    if not os.path.exists(typ):
        return None
    body = open(typ, encoding="utf-8", errors="replace").read()
    labels = set(re.findall(r"<([\w:.\-]+)>", body))
    cited = set(k.lower() for k in re.findall(r"(?<![\w@])@([A-Za-z0-9_.:*+\-]+)", body)
                if ":" not in k and k.lower() not in labels)
    cited |= set(re.sub(r"[^A-Za-z0-9_.:\-]", "-", k).lower()
                 for k in re.findall(r"cite\(\s*<?([A-Za-z0-9_.:*+\-]+)?>?", body) if ":" not in k)
    have = open(rp, encoding="utf-8", errors="replace").read() if os.path.exists(rp) else ""
    present = set(k.lower() for _t, k in ENTRY.findall(have))
    missing = cited - present
    if not missing:
        return dict(paper=os.path.basename(paper), cited=len(cited), missing=0)
    pool = {}
    for f in glob.glob(os.path.join(paper, "src", "**", "*.bib*"), recursive=True) + \
             glob.glob(os.path.join(paper, "_work", "*.bib*")):
        try:
            for k, v in parse(open(f, encoding="utf-8", errors="replace").read()).items():
                pool.setdefault(k, v)
        except Exception:
            pass
    added = []
    for k in sorted(missing):
        if k in pool:
            e = pool[k]
            e, _ = expand_strings(e)
            e, _ = quote_bare(e)
            e, _ = fix_text(e)
            e = re.sub(r"^(@\w+\{\s*)[^,{}\s]+", lambda m: m.group(1) + k, e, count=1)
            added.append(e)
    if added and os.path.exists(rp):
        open(rp, "a", encoding="utf-8").write("\n" + "\n".join(added) + "\n")
    return dict(paper=os.path.basename(paper), cited=len(cited), missing=len(missing),
                recovered=len(added), still_missing=sorted(missing - set(k for k in missing if k in pool))[:6])


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    dirs = sys.argv[1:] or sorted(glob.glob(r"E:\phys\papers\2*"))
    for d in dirs:
        try:
            r = merge(d)
            if r:
                print(r, flush=True)
        except Exception as e:
            print("FAIL", d, repr(e)[:150], flush=True)

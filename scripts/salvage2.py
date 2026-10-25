"""Deterministic salvage v2: repair leftover LaTeX damage in converted main.typ files,
resolve PDF/missing images, dedupe bibliography keys, then compile in a repair loop. No model calls."""
import sys, os, re, glob, json, subprocess
sys.path.insert(0, r"E:\phys\scripts")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.stderr.reconfigure(encoding="utf-8", errors="replace")
from typrepair import auto_fix, latex_text_fix

ROOT = r"E:\phys\papers"
run = lambda c: subprocess.run(c, capture_output=True, text=True, encoding="utf-8", errors="replace")


def fix_images(typ, paper):
    src = os.path.join(paper, "src")
    imgd = os.path.join(paper, "imgs")
    os.makedirs(imgd, exist_ok=True)

    def repl(m):
        path = m.group(1)
        if path.startswith("imgs/") and os.path.exists(os.path.join(paper, path)):
            return m.group(0)
        base = os.path.basename(path)
        stem = os.path.splitext(base)[0]
        for cand in (os.path.join(src, "**", base), os.path.join(src, "**", stem + ".*")):
            hits = glob.glob(cand, recursive=True)
            if not hits:
                continue
            f = hits[0]
            if os.path.splitext(f)[1].lower() in (".pdf", ".eps", ".ps"):
                png = os.path.join(imgd, stem + ".png")
                if not os.path.exists(png):
                    try:
                        import pymupdf
                        pymupdf.open(f)[0].get_pixmap(dpi=170).save(png)
                    except Exception:
                        break
                if os.path.exists(png):
                    return 'image("imgs/%s.png", width: 70%%)' % stem
                break
            rel = os.path.relpath(f, paper).replace("\\", "/")
            return 'image("%s", width: 70%%)' % rel
        return "[figure: %s]" % stem

    return re.sub(r'image\("([^"]+)"\)', repl, typ)


def dedupe_bib(paper):
    f = os.path.join(paper, "refs.bib")
    if not os.path.exists(f):
        return
    txt = open(f, encoding="utf-8", errors="replace").read()
    seen, keep = set(), []
    for e in re.split(r"(?=@\w+\{)", txt):
        m = re.match(r"@(\w+)\{([^,]+),", e)
        if not m:
            keep.append(e)
            continue
        base = m.group(2).strip()
        k, n = base, 0
        while k in seen:
            n += 1
            k = "%s-%d" % (base, n)
        seen.add(k)
        keep.append(e.replace("{" + base + ",", "{" + k + ",", 1))
    open(f, "w", encoding="utf-8").write("".join(keep))


def dangling_refs(typ, paper):
    bibkeys = set()
    rb = os.path.join(paper, "refs.bib")
    if os.path.exists(rb):
        bibkeys = set(re.findall(r"@\w+\{([^,]+),", open(rb, encoding="utf-8", errors="replace").read()))
    defined = set(re.findall(r"(?<!\()<([\w:.\-]+)>", typ)) | bibkeys

    def deref(m):
        return m.group(0) if m.group(1) in defined or m.group(1).startswith("preview") else "#text([])"
    typ = re.sub(r"~?@([\w:.\-]+)", deref, typ)
    return re.sub(r"#link\(<([\w:.\-]+)>\)(\[[^\[\]]*\])?",
                  lambda m: m.group(0) if m.group(1) in defined else re.sub(r"[{}]", "", m.group(2) or ""), typ)


def process(paper):
    typf = os.path.join(paper, "main.typ")
    pdf = os.path.join(paper, "build", "main.pdf")
    os.makedirs(os.path.dirname(pdf), exist_ok=True)
    typ = open(typf, encoding="utf-8").read()
    dedupe_bib(paper)
    typ = fix_images(typ, paper)
    typ = latex_text_fix(typ)
    typ = dangling_refs(typ, paper)
    info = {"paper": os.path.basename(paper), "passes": 0, "bytes": 0}
    for it in range(8):
        open(typf, "w", encoding="utf-8").write(typ)
        r = run(["typst", "compile", typf, pdf])
        info["passes"] = it
        size = os.path.getsize(pdf) if os.path.exists(pdf) else 0
        if r.returncode == 0 and size > 20000:
            info["bytes"] = size
            break
        err = r.stderr or ""
        info["last_error"] = err.split("\n")[0][:180]
        if it >= 2 and "unclosed" in err or "expected" in err and it >= 3:
            # last resort: neutralise the offending lines entirely
            lines = typ.split(chr(10))
            for ln in sorted(set(int(m) for m in re.findall(r"main\.typ:(\d+):", err)), reverse=True):
                if 0 < ln <= len(lines):
                    lines[ln - 1] = ""
            typ = chr(10).join(lines)
            continue
        nxt = auto_fix(typ, err)
        if nxt == typ:
            lines = typ.split(chr(10))
            hit = False
            for ln in sorted(set(int(m) for m in re.findall(r"main.typ:(d+):".replace("d+", chr(92)+"d+"), err)), reverse=True):
                if 0 < ln <= len(lines):
                    lines[ln - 1] = ""
                    hit = True
            if not hit:
                info["bytes"] = size
                break
            typ = chr(10).join(lines)
            continue
        typ = nxt
    info["ok"] = info["bytes"] > 20000
    rep = os.path.join(paper, "report.json")
    d = {}
    if os.path.exists(rep):
        try:
            d = json.load(open(rep, encoding="utf-8"))
        except Exception:
            d = {}
    d["paper"] = os.path.basename(paper)
    d["salvaged"] = info["ok"]
    if info["ok"]:
        d["compiled"] = True
    json.dump(d, open(rep, "w", encoding="utf-8"), indent=1)
    return info


def main():
    res = []
    for paper in sorted(glob.glob(os.path.join(ROOT, "2*"))):
        typf = os.path.join(paper, "main.typ")
        rep0 = os.path.join(paper, "report.json")
        if not os.path.exists(typf):
            continue
        if not os.path.exists(rep0) or os.path.getmtime(rep0) < os.path.getmtime(typf):
            print("skip (in flight)", os.path.basename(paper), flush=True)
            continue
        try:
            j = json.load(open(rep0, encoding="utf-8"))
        except Exception:
            j = {}
        if j.get("compiled") is True and os.path.exists(os.path.join(paper, "build", "main.pdf")):
            print("skip (already compiled)", os.path.basename(paper), flush=True)
            continue
        if j.get("empty_source"):
            print("skip (no latex source)", os.path.basename(paper), flush=True)
            continue
        if j.get("salvaged") and os.path.exists(os.path.join(paper, "build", "main.pdf")):
            print("skip (salvaged)", os.path.basename(paper), flush=True)
            continue
        i = process(paper)
        print(json.dumps(i, ensure_ascii=False)[:260], flush=True)
        res.append(i)
    print("SALVAGED", sum(1 for i in res if i["ok"]), "of", len(res))


main()

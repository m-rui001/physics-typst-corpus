"""Deterministic salvage pass: repair common Typst syntax damage in existing main.typ files,
resolve missing/PDF images to PNG, and compile. No model calls - fast and repeatable."""
import sys, os, re, glob, json, time, subprocess
sys.path.insert(0, r"E:\phys\scripts")
from autofix import auto_fix
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.stderr.reconfigure(encoding="utf-8", errors="replace")

ROOT = r"E:\phys\papers"
run = lambda c: subprocess.run(c, capture_output=True, text=True, encoding="utf-8", errors="replace")


def fix_images(typ, paper):
    """image("x.pdf"|"x") -> PNG under imgs/, or plain placeholder if unresolvable."""
    src = os.path.join(paper, "src")
    imgd = os.path.join(paper, "imgs")
    os.makedirs(imgd, exist_ok=True)

    def repl(m):
        path = m.group(1)
        if os.path.exists(os.path.join(paper, path)):
            return m.group(0)
        base = os.path.basename(path)
        stem = os.path.splitext(base)[0]
        png = os.path.join(imgd, stem + ".png")
        cands = [os.path.join(src, "**", base), os.path.join(src, "**", os.path.splitext(base)[0] + ".*")]
        for g in cands:
            hits = glob.glob(g, recursive=True)
            if hits:
                f = hits[0]
                if f.lower().endswith((".pdf", ".eps", ".ps")):
                    if not os.path.exists(png):
                        try:
                            import pymupdf
                            pymupdf.open(f)[0].get_pixmap(dpi=170).save(png)
                        except Exception:
                            return r"[figure: %s]" % stem
                    return 'image("imgs/%s.png", width: 70%%)' % stem
                rel = os.path.relpath(f, paper).replace("\\", "/")
                return 'image("%s", width: 70%%)' % rel
        return r"[figure: %s]" % stem

    return re.sub(r'image\("([^"]+)"\)', repl, typ)


SYMBOLS = [("circle.times", "⊗"), ("times.circle", "⊗"), ("circle.plus", "⊕"),
           ("plus.circle", "⊕"), ("circle.minus", "⊖"), ("dot.circle", "⊙"),
           ("circle.stroked.r", "⊘"), ("plus.minus", "±"), ("minus.plus", "∓"),
           ("arrow.r.double", "⇒"), ("arrow.r", "→"), ("lt.double", "⟨"),
           ("gt.double", "⟩")]
TEXMATH = [(r"\\cdots", "⋯"), (r"\\dotsb?", "…"), (r"\\ldots", "…"),
           (r"\\cdot", "·"), (r"\\times", "×"), (r"\\pm", "±"),
           (r"\\to", "→"), (r"\\rightarrow", "→"), (r"\\infty", "∞"),
           (r"\\neq", "≠"), (r"\\approx", "≈"), (r"\\partial", "∂"),
           (r"\\langle", "⟨"), (r"\\rangle", "⟩"), (r"\\,|\\;", " ")]

def symbol_fix(typ):
    for k, v in SYMBOLS:
        typ = typ.replace(k, v)
    for pat, v in TEXMATH:
        typ = re.sub(pat, v, typ)
    typ = typ.replace(r"\$", "$")
    return typ

def dedupe_bib(paper):
    f = os.path.join(paper, "refs.bib")
    if not os.path.exists(f):
        return
    txt = open(f, encoding="utf-8", errors="replace").read()
    entries = re.split(r"(?=@\w+\{)", txt)
    seen, keep = set(), []
    for e in entries:
        m = re.match(r"@\w+\{([^,]+),", e)
        if not m:
            keep.append(e); continue
        k = m.group(1).strip()
        suffix, base, n = 0, k, 0
        while k in seen:
            n += 1; k = base + "-%d" % n
        seen.add(k)
        keep.append(e.replace("{" + base + ",", "{" + k + ",", 1))
    open(f, "w", encoding="utf-8").write("".join(keep))

def fix_math(typ):
    # dangling scripts / empty subscript-superscript inside inline math
    typ = re.sub(r"\$\s*([\^_])", r'$" "\1', typ)
    typ = re.sub(r"([\^_])\s*\$", r'$\1 " "$', typ)
    typ = re.sub(r"\$\s*([\^_][\s]*)[\^_]\s*\$", r'$\1 " "$', typ)
    typ = typ.replace(r"$_ $", r"$\o $").replace("$_ $", r"$\o $")
    # unknown symbol modifiers like `alt.A`, `t` chains -> drop the modifier
    typ = re.sub(r"\b([a-z]+(?:\.[a-z]+)+)\s+(?=[a-zA-Z])", lambda m: m.group(0) if len(m.group(1).split(".")) < 3 else m.group(1).split(".")[0], typ)
    return typ


def main():
    out = []
    now = time.time()
    for paper in sorted(glob.glob(os.path.join(ROOT, "2*"))):
        typf = os.path.join(paper, "main.typ")
        if not os.path.exists(typf):
            continue
        rep0 = os.path.join(paper, "report.json")
        if not os.path.exists(rep0) or os.path.getmtime(rep0) < os.path.getmtime(typf):
            print("skip (in flight)", os.path.basename(paper), flush=True)
            continue
        try:
            if json.load(open(rep0, encoding="utf-8")).get("compiled") is True:
                print("skip (already compiled)", os.path.basename(paper), flush=True)
                continue
        except Exception:
            pass
        typ = open(typf, encoding="utf-8").read()
        typ = fix_images(typ, paper)
        typ = symbol_fix(typ)
        typ = fix_math(typ)
        dedupe_bib(paper)
        open(typf, "w", encoding="utf-8").write(typ)
        pdf = os.path.join(paper, "build", "main.pdf")
        os.makedirs(os.path.dirname(pdf), exist_ok=True)
        r = run(["typst", "compile", typf, pdf])
        info = {"paper": os.path.basename(paper), "rc": r.returncode,
                "bytes": os.path.getsize(pdf) if os.path.exists(pdf) else 0}
        if r.returncode != 0:
            fx = auto_fix(typ, r.stderr or "")
            if fx != typ:
                open(typf, "w", encoding="utf-8").write(fx)
                typ = fx
                r = run(["typst", "compile", typf, pdf])
                info["auto_fixed"] = r.returncode == 0
        if r.returncode != 0:
            errs = (r.stderr or "").split("error:")
            info["n_errors"] = len(errs) - 1
            info["first_error"] = ("error:" + errs[1])[:300] if len(errs) > 1 else ""
            # one mechanical retry: comment out the offending lines
            bad = set(int(m) for m in re.findall(r"main\.typ:(\d+):", r.stderr or ""))
            if bad:
                lines = typ.split("\n")
                for n in bad:
                    if 0 < n <= len(lines) and not lines[n - 1].lstrip().startswith("//"):
                        lines[n - 1] = "// " + lines[n - 1]
                open(typf, "w", encoding="utf-8").write("\n".join(lines))
                r2 = run(["typst", "compile", typf, pdf])
                info["rc2"] = r2.returncode
                info["bytes"] = os.path.getsize(pdf) if os.path.exists(pdf) else 0
                if r2.returncode != 0:
                    info["first_error2"] = ("error:" + (r2.stderr or "").split("error:")[1])[:250]
        print(json.dumps(info, ensure_ascii=False)[:400], flush=True)
        out.append(info)
        rep = os.path.join(paper, "report.json")
        d = {}
        if os.path.exists(rep):
            try:
                d = json.load(open(rep, encoding="utf-8"))
            except Exception:
                d = {}
        d["salvaged"] = info.get("rc") == 0 or info.get("rc2") == 0
        json.dump(d, open(rep, "w", encoding="utf-8"), indent=1)
    print("OK", sum(1 for i in out if i.get("rc") == 0 or i.get("rc2") == 0), "of", len(out))


main()

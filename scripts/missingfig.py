r"""Wire figures left as `MISSINGFIG(name)` placeholders by the pandoc chunking stage.

Some converted papers emit `#figure([MISSINGFIG(switching_Fig1) ... ], caption: [...])`
when the chunker could not find the graphic. The real asset is usually still under
`src/` (often as EPS/PDF, which Typst cannot embed), so rasterise every candidate once
into `imgs/` and point the placeholder at it.

Usage: python -X utf8 scripts/missingfig.py papers/<dir> [...]
"""
import glob, os, re, shutil, sys
sys.stdout.reconfigure(encoding="utf-8")
DPI = int(os.environ.get("FIGNAME_DPI", "160"))

PLACE = re.compile(r"MISSINGFIG\((\\?[^)]*?)\)")


def assets(d):
    out = {}
    for f in glob.glob(os.path.join(d, "src", "**", "*.*"), recursive=True):
        stem = os.path.splitext(os.path.basename(f))[0].lower()
        out.setdefault(stem, []).append(f)
    return out


def gs_exe():
    """Locate a Ghostscript binary: $GS, PATH, then a project-local E:\\phys\\tools\\gs* unpack."""
    import shutil
    for cand in (os.environ.get("GS"), "gswin64c", "gswin32c", "gs"):
        if cand:
            hit = shutil.which(cand)
            if hit:
                return hit
    root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    pats = [os.path.join(root, "tools", "gs*", "bin", "gswin64c.exe"),
            os.path.join(root, "tools", "gs*", "bin", "gswin64c"),
            os.path.join(root, "tools", "gs*", "bin", "gs")]
    hits = sorted(p for pat in pats for p in glob.glob(pat))
    return hits[-1] if hits else None


def eps_to_pdf(d, f):
    """EPS -> PDF via Ghostscript (PyMuPDF cannot open EPS); cached in <paper>/_eps/."""
    import subprocess
    cache = os.path.join(d, "_eps")
    os.makedirs(cache, exist_ok=True)
    out = os.path.join(cache, os.path.splitext(os.path.basename(f))[0] + ".pdf")
    if os.path.exists(out) and os.path.getsize(out) > 1024:
        return out
    gs = gs_exe()
    if not gs:
        raise RuntimeError("no Ghostscript found (set PATH or GS, or unpack gs into scripts/../tools)")
    cmd = [gs, "-dBATCH", "-dNOPAUSE", "-dSAFER", "-q", "-sDEVICE=pdfwrite",
           "-dCompatibilityLevel=1.5", "-dPDFSETTINGS=/prepress",
           "-dAutoRotatePages=/None", "-dEPSCrop",
           "-sOutputFile=" + out.replace(os.sep, "/"), f.replace(os.sep, "/")]
    subprocess.run(cmd, check=True, capture_output=True)
    if not os.path.exists(out):
        raise RuntimeError("ghostscript produced no PDF for " + f)
    return out


def to_png(d, f):
    ext = os.path.splitext(f)[1].lower()
    name = os.path.splitext(os.path.basename(f))[0]
    tgt = os.path.join(d, "imgs", name + ".png")
    if os.path.exists(tgt):
        return "imgs/" + os.path.basename(tgt)
    os.makedirs(os.path.join(d, "imgs"), exist_ok=True)
    import pymupdf
    if ext in (".png", ".jpg", ".jpeg"):
        shutil.copyfile(f, tgt)
    elif ext in (".eps", ".ps", ".ai"):
        doc = pymupdf.open(eps_to_pdf(d, f))
        doc[0].get_pixmap(dpi=DPI).save(tgt)
    else:
        try:
            doc = pymupdf.open(f)
        except Exception:
            doc = pymupdf.open(eps_to_pdf(d, f))
        doc[0].get_pixmap(dpi=DPI).save(tgt)
    return "imgs/" + os.path.basename(tgt)


def run(d):
    d = os.path.abspath(d)
    mp = os.path.join(d, "main.typ")
    if not os.path.exists(mp):
        return
    body = open(mp, encoding="utf-8", errors="replace").read()
    names = [m.group(1).replace("\\", "") for m in PLACE.finditer(body)]
    if not names:
        print("%-12s no MISSINGFIG placeholders" % os.path.basename(d))
        return
    amap = assets(d)
    cache, wired, lost = {}, 0, []
    for nm in dict.fromkeys(names):
        cand = amap.get(nm.lower()) or amap.get(nm.lower().replace("_", "-"))
        if not cand:                       # tolerate -01 / _1 suffix drift
            k = nm.lower().rstrip("0123456789-_")
            cand = next((v for kk, v in amap.items() if kk.startswith(k) and k), [])
        if not cand:
            lost.append(nm)
            continue
        try:
            cache[nm] = to_png(d, cand[0])
            wired += 1
        except Exception as e:
            print("  rasterise failed:", nm, e)
            lost.append(nm)

    def sub(m):
        nm = m.group(1).replace("\\", "")
        if nm in cache:
            return '#image("%s", width: 100%%)' % cache[nm]
        return m.group(0)

    new = PLACE.sub(sub, body)
    open(mp, "w", encoding="utf-8").write(new)
    print("%-12s wired %d/%d placeholders%s" % (
        os.path.basename(d), wired, len(set(names)),
        "" if not lost else "; still missing: " + ", ".join(lost)))


if __name__ == "__main__":
    for a in sys.argv[1:]:
        run(a)

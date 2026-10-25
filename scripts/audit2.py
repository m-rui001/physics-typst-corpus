import os, glob, subprocess

def docclass(path):
    for line in open(path, encoding="utf-8", errors="ignore"):
        i = line.find("documentclass")
        if i < 0:
            continue
        rest = line[i + len("documentclass"):]
        opts = ""
        if rest.startswith("["):
            opts = rest[1:rest.find("]")].replace(" ", "")
            rest = rest[rest.find("]") + 1:]
        cls = ""
        if rest.startswith("{"):
            cls = rest[1:rest.find("}")]
        return opts, cls
    return "", ""

def main():
    for d in sorted(glob.glob("papers/*")):
        mt = os.path.join(d, "main.typ")
        if not os.path.exists(mt):
            continue
        opts = cls = ""
        for f in glob.glob(os.path.join(d, "src", "*.tex")):
            o, c = docclass(f)
            if c:
                opts, cls = o, c
                break
        two = ("twocolumn" in opts and "preprint" not in opts) \
            or ("reprint" in opts and "preprint" not in opts) \
            or cls.startswith("aastex") or cls == "mnras"
        head = open(mt, encoding="utf-8", errors="ignore").read(6000)
        cols = "columns: 2" in head
        r = subprocess.run(["typst", "compile", mt, os.path.join(d, "_work", "_a.pdf")],
                           capture_output=True, text=True, errors="replace")
        errs = sum(1 for ln in (r.stderr or "").splitlines() if ln.startswith("error:"))
        pages = 0
        try:
            import pymupdf
            pages = pymupdf.open(os.path.join(d, "_work", "_a.pdf")).page_count
        except Exception:
            pass
        flag = "" if two == cols else "  <-- LAYOUT"
        print("%-12s cls=%-10s two=%-5s cols2=%-5s err=%d pages=%d%s" %
              (os.path.basename(d), cls or "?", two, cols, errs, pages, flag))

main()

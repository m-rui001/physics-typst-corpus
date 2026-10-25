"""Static (compile-free) corpus quality inventory: safe to run while agents edit."""
sys_stdout = __import__("sys"); sys_stdout.stdout.reconfigure(encoding="utf-8", errors="replace")
import os, re, json, glob

EXCLUDE = {"2206.14858", "2402.14008"}
LATEX = ["\\cite", "\\ref{", "\\begin{", "\\frac", "\\includegraphics", "$$", "\\to ",
         "\\partial", "\\textbf", "\\emph", "figure*", "\\centering", "\\label{", "%!"]
SKIP = {"2104.11260", "2202.02773", "2410.05380"}  # no usable latex / still converting

rows = []
for d in sorted(glob.glob(r"E:\phys\papers\2*")):
    pid = os.path.basename(d)
    if pid in EXCLUDE:
        continue
    typ = os.path.join(d, "main.typ")
    pdf = os.path.join(d, "build", "main.pdf")
    if not os.path.exists(typ):
        rows.append(dict(id=pid, state="no main.typ", src=os.path.isdir(os.path.join(d, "src"))))
        continue
    t = open(typ, encoding="utf-8", errors="replace").read()
    body = "\n".join(l for l in t.splitlines() if not l.lstrip().startswith("//"))
    bib = ""
    bibp = os.path.join(d, "refs.bib")
    if os.path.exists(bibp):
        bib = open(bibp, encoding="utf-8", errors="replace").read()
    keys = set(re.findall(r"@\w+\{([^,]+),", bib))
    labels = set(re.findall(r"<([\w:.\-]+)>", body))
    dangling = len([k for k in set(re.findall(r"(?<![\w@])@([\w:.\-]+)", body))
                    if k not in keys and k not in labels])
    rows.append(dict(
        id=pid,
        kb=len(t) // 1024,
        pdf_kb=os.path.getsize(pdf) // 1024 if os.path.exists(pdf) else 0,
        cetz=body.count("cetz.canvas"),
        imgs=len(re.findall(r"\bimage\(", body)),
        placeholders=body.count("TikZ source") + body.count("figure:"),
        math=body.count("$") // 2,
        dangling=dangling,
        left={p: body.count(p) for p in LATEX if body.count(p)},
        flag=("UNOWNED" if pid not in SKIP else "busy"),
    ))

json.dump(rows, open(r"E:\phys\static_report.json", "w", encoding="utf-8"), indent=1)
tot = dict(pdf=sum(1 for r in rows if r.get("pdf_kb", 0) > 20), cetz=sum(r.get("cetz", 0) for r in rows),
           imgs=sum(r.get("imgs", 0) for r in rows), papers=len(rows),
           left=sum(sum(r.get("left", {}).values()) for r in rows))
for r in rows:
    print(json.dumps(r, ensure_ascii=False))
print("TOTAL", tot)

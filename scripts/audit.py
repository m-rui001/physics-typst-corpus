"""Quality audit across all converted papers: compile status, layout stats, leftover-LaTeX score,
CeTZ figure usage, citation resolution. Writes E:\\phys\\quality_report.json."""
import sys, os, glob, json, re, subprocess
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.stderr.reconfigure(encoding="utf-8", errors="replace")
import pymupdf

ROOT = r"E:\phys\papers"
LATEX_MARKS = [r"\cite", r"\ref{", r"\begin{", r"\end{", r"\frac", r"\textbf", r"\item",
               r"\usepackage", r"$\rm", r"\mu", r"\alpha", r"\begin", "ZZTIKZ", "%!",
               r"\bibliography", r"\subsection", r"\label{", r"\equation"]
rows = []
for paper in sorted(glob.glob(os.path.join(ROOT, "2*"))):
    pid = os.path.basename(paper)
    typf = os.path.join(paper, "main.typ")
    pdf = os.path.join(paper, "build", "main.pdf")
    row = {"paper": pid}
    if os.path.exists(os.path.join(paper, "report.json")):
        try:
            r = json.load(open(os.path.join(paper, "report.json"), encoding="utf-8"))
            row["empty_source"] = bool(r.get("empty_source"))
            row["pipeline_compiled"] = r.get("compiled")
            row["tikz_blocks"] = r.get("tikz", 0)
        except Exception:
            pass
    if os.path.exists(typf):
        typ = open(typf, encoding="utf-8", errors="replace").read()
        row["typ_lines"] = typ.count("\n")
        row["cetz_canvases"] = typ.count("cetz.canvas")
        row["include_images"] = len(re.findall(r"image\(", typ))
        row["figures"] = typ.count("#figure")
        row["math_blocks"] = len(re.findall(r"(?<!\\)\$", typ)) // 2
        row["dangling_cites"] = len([c for c in re.findall(r"(?<!\\)@([\w:.\-]+)", typ)
                                     if not c.startswith("preview")])
        row["commented_out"] = len(re.findall(r"^\s*//\s*(TODO-latex|TikZ source)", typ, re.M))
        rc = subprocess.run(["typst", "compile", typf, pdf], capture_output=True,
                            text=True, encoding="utf-8", errors="replace").returncode
        row["compiles"] = rc == 0
    else:
        row["compiles"] = False
    if os.path.exists(pdf):
        d = pymupdf.open(pdf)
        row["pages"] = d.page_count
        row["pdf_kb"] = os.path.getsize(pdf) // 1024
        row["embedded_images"] = sum(len(p.get_images()) for p in d)
        text = "".join(p.get_text() for p in d)
        row["chars"] = len(text)
        row["leftover_latex"] = sorted({m for m in LATEX_MARKS if m in text})
        row["suspicious"] = []
        if re.search(r"\$[^$]{0,40}\b(textstyle|scriptsize|rm|bf)\b", text):
            row["suspicious"].append("latex-font-switch-in-math")
        if "\\begin" in text or "\\documentclass" in text:
            row["suspicious"].append("raw-latex-block")
        if re.search(r"[A-Za-z]+\$\^\{?\d", text):
            row["suspicious"].append("author-affiliation-math-leak")
        if "⟨TikZ source" in text:
            row["suspicious"].append("tikz-placeholder")
        d.close()
    rows.append(row)

good = [r for r in rows if r.get("compiles") and r.get("pages", 0) >= 3 and not r.get("suspicious")]
print(json.dumps(rows, ensure_ascii=False, indent=1))
print("TOTAL", len(rows), "COMPILED", sum(1 for r in rows if r.get("compiles")),
      "CLEAN", len(good), "CETZ_FIGS", sum(r.get("cetz_canvases", 0) for r in rows))
json.dump(rows, open(r"E:\phys\quality_report.json", "w", encoding="utf-8"), indent=1)

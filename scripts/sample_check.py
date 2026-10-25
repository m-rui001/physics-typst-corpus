"""Sample check: render pages of each built PDF, collect stats for visual inspection."""
import os, sys, glob, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.stderr.reconfigure(encoding="utf-8", errors="replace")
import pymupdf

ROOT = r"E:\phys\papers"
checks = []
for pdf in glob.glob(os.path.join(ROOT, "2*", "build", "main.pdf")):
    d = os.path.dirname(os.path.dirname(pdf))
    doc = pymupdf.open(pdf)
    info = {"paper": os.path.basename(d), "pages": doc.page_count,
            "bytes": os.path.getsize(pdf),
            "images": sum(len(p.get_images()) for p in doc)}
    os.makedirs(os.path.join(d, "check"), exist_ok=True)
    for pn in [0, min(2, doc.page_count - 1), doc.page_count // 2]:
        try:
            pix = doc[pn].get_pixmap(dpi=110)
            pix.save(os.path.join(d, "check", f"page{pn+1}.png"))
        except Exception as e:
            info["render_err"] = str(e)
    text = "".join(p.get_text() for p in doc)
    info["tex_leftovers"] = [t for t in ("\\cite", "\\ref{", "\\begin", "\\frac", "$$", "%!", "ZZTIKZ", "$\\rm", "\\[", "\\]", "\\to ", "\\partial") if t in text]
    info["chars"] = len(text)
    checks.append(info)
    doc.close()
json.dump(checks, open(r"E:\phys\quality_report.json", "w"), indent=1)
for c in checks:
    print(c)

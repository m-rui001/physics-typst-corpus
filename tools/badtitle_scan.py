import io
import re
import sys
import importlib.util

spec = importlib.util.spec_from_file_location("m", "tools/migrate2202.py")
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)

for pid in sys.argv[1:]:
    bib = "papers/%s/refs.bib" % pid
    typ = "papers/%s/main.typ" % pid
    t = io.open(typ, encoding="utf-8").read()
    cites = set(re.findall(r"@([A-Za-z0-9:._/+\-]+)", t)) | set(re.findall(r"#cite\(\s*<([^>]+)>", t))
    bad = []
    entries = m.parse_bib(bib)
    for etyp, key, f in entries:
        ti = f.get("title", "")
        if key in cites and ("http" in ti or "doi:" in ti or "pp." in ti or "{\\" in ti or "\\" in ti):
            bad.append((key, ti[:90]))
    print(pid, "entries", len(entries), "cited", len(cites), "bad", len(bad))
    for k, v in bad[:15]:
        print("  ", k, "|", v)

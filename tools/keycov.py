import re
import io
import sys

bblpath, typ = sys.argv[1], sys.argv[2]
s = io.open(bblpath, encoding="utf-8", errors="ignore").read()
bbl = set(re.findall(r"\\bibitem\{([^}]*)\}", s))
t = io.open(typ, encoding="utf-8").read()
cites = set(re.findall(r"@([A-Za-z0-9:._/+\-]+)", t))
cites = {c for c in cites if not re.match(r"(eq|fig|tab|sec|lst|thm|lem|app|alg|line):", c)}
print("bbl", len(bbl), "cited", len(cites), "cited-missing", len(cites - bbl))
for k in sorted(cites - bbl):
    print("MISS", k)

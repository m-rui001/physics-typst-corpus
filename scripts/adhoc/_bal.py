import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
BS = chr(92)

for path in ["papers/2106.16243/refs.bib", "papers/2206.11528/refs.bib"]:
    text = open(path, encoding="utf-8").read()
    print("==", path, text.count("{") - text.count("}"))
    # per entry: from @ to matching close, but limit to the entry's own text
    for m in re.finditer(r"@[A-Za-z]+\{([^,]*),", text):
        start = m.start()
        # find the next @ (or EOF); count braces within that span
        nxt = text.find("@", m.end())
        seg = text[start:nxt if nxt > 0 else len(text)]
        d = seg.count("{") - seg.count("}")
        if d:
            print("entry", m.group(1), "delta", d, repr(seg[-90:]))

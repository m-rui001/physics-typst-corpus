import importlib.util
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
spec = importlib.util.spec_from_file_location("bn", "bibnormal.py")
bn = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bn)
BS = chr(92)

for path in ["papers/2312.03982/refs.bib", "papers/2106.16243/refs.bib",
             "papers/2206.11528/refs.bib"]:
    text = open(path, encoding="utf-8").read()
    i = 0
    n = len(text)
    while True:
        at = text.find("@", i)
        if at < 0:
            break
        j = text.find("{", at)
        k = text.find(",", j)
        p = k + 1
        while True:
            fm = re.match(r"\s*([A-Za-z]+)\s*=\s*", text[p:])
            if not fm:
                break
            name = fm.group(1)
            p += fm.end()
            if p < n and text[p] == "{":
                depth = 0
                q = p
                while q < n:
                    if text[q] == "{":
                        depth += 1
                    elif text[q] == "}":
                        depth -= 1
                        if depth == 0:
                            break
                    q += 1
                val = text[p + 1:q]
                p = q + 1
                if name.lower() != "file":
                    out = bn.norm_value(name, val, bn.Counter())
                    if out.count("{") - out.count("}") or out.count(BS):
                        print(path, name, out.count("{") - out.count("}"),
                              out.count(BS), repr(val[:100]), "=>", repr(out[:100]))
            elif p < n and text[p] == '"':
                q = text.find('"', p + 1)
                p = q + 1
            else:
                q = text.find(",", p)
                if q < 0:
                    q = n
                p = q
            cm = re.match(r"\s*,\s*", text[p:])
            if cm:
                p += cm.end()
            else:
                break
        i = p

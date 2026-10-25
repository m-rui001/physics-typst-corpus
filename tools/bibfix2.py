import re, sys, io

TRAIL = re.compile(r"(?s)\n([ \t]*(?:%|#|//)[^\n]*(?:\n[ \t]*(?:%|#|//)[^\n]*)*)\s*(\})?\s*$")


def depth(t):
    d = 0
    for ch in t:
        if ch == "{":
            d += 1
        elif ch == "}":
            d -= 1
    return d


def fix(path, apply=False):
    s = io.open(path, encoding="utf-8", errors="ignore").read()
    idx = [m.start() for m in re.finditer(r"(?m)^@", s)]
    out = []
    last = 0
    moved = 0
    nested = 0
    for k, i in enumerate(idx):
        j = idx[k + 1] if k + 1 < len(idx) else len(s)
        out.append(s[last:i])
        part = s[i:j]
        # nested entries swallowed by a moved brace
        qs = [m.start() for m in re.finditer(r"(?m)^\s+@\w+\{", part)]
        if qs:
            built = []
            prev = 0
            for q in qs:
                seg = part[prev:q]
                d = depth(seg)
                if d > 0:
                    seg = seg.rstrip() + "\n" + "}" * d + "\n"
                built.append(seg)
                prev = q
            tail = part[prev:]
            d = depth(tail)
            if d > 0:
                tail = tail.rstrip() + "\n" + "}" * d + "\n"
            elif d < 0:
                tail = tail.rstrip()[:-d].rstrip() + "\n" if tail.rstrip().endswith("}" * (-d)) else tail
            part = "".join(built) + tail
            nested += 1
        m = TRAIL.search(part)
        if m and (m.group(2) or depth(part[:m.start()]) > 0):
            body = part[:m.start()].rstrip()
            if body.endswith(","):
                body = body[:-1].rstrip()
            if depth(body) > 0:
                body += "\n" + "}" * depth(body)
            part = body + "\n" + m.group(1) + "\n"
            moved += 1
        out.append(part)
        last = j
    out.append(s[last:])
    if apply:
        io.open(path, "w", encoding="utf-8").write("".join(out))
    print(path, "moved-brace:", moved, "nested:", nested)


if __name__ == "__main__":
    apply = "--apply" in sys.argv
    for p in sys.argv[1:]:
        if p != "--apply":
            fix(p, apply)

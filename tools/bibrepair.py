import re, sys, io, glob, os


def split_entries(s):
    idx = [m.start() for m in re.finditer(r"(?m)^@", s)]
    out = []
    for k, i in enumerate(idx):
        j = idx[k + 1] if k + 1 < len(idx) else len(s)
        out.append((i, j))
    return out


def early_close(part):
    """return index where entry brace depth first returns to 0, if trailing field text follows"""
    d = 0
    started = False
    for j, ch in enumerate(part):
        if ch == "{":
            d += 1
            started = True
        elif ch == "}":
            d -= 1
            if started and d == 0:
                return j
    return None


def repair(path, apply=False):
    s = io.open(path, encoding="utf-8", errors="ignore").read()
    parts = split_entries(s)
    out = []
    last = 0
    fixed = 0
    for i, j in parts:
        out.append(s[last:i])
        part = s[i:j]
        k = early_close(part)
        if k is not None and part[k + 1:].strip():
            head = part[:k] + part[k + 1:]
            head = head.rstrip()
            if not head.endswith("}"):
                head += "}"
            part = head + "\n"
            fixed += 1
        out.append(part)
        last = j
    out.append(s[last:])
    if apply and fixed:
        io.open(path, "w", encoding="utf-8").write("".join(out))
    return fixed


if __name__ == "__main__":
    apply = "--apply" in sys.argv
    tot = 0
    for p in sorted(glob.glob("papers/*/refs.bib")):
        n = repair(p, apply)
        if n:
            print(p, "early-closed entries:", n)
            tot += n
    print("total", tot, "applied" if apply else "dry-run")

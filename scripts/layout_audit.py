import os, re, glob, sys

ROOT = r"E:\phys\papers"

def block_end(s, start):
    """index just after the ] matching the [ at s[start]"""
    depth = 0
    i = start
    while i < len(s):
        c = s[i]
        if c == "\\":
            i += 2
            continue
        if c == "[":
            depth += 1
        elif c == "]":
            depth -= 1
            if depth == 0:
                return i + 1
        i += 1
    return len(s)

for path in sorted(glob.glob(os.path.join(ROOT, "*", "main.typ"))):
    pid = os.path.basename(os.path.dirname(path))
    s = open(path, encoding="utf-8").read()
    m = re.search(r"columns:\s*2\b", s[:3000])
    page2 = bool(m)
    first_head = s.find("\n= ")
    if first_head < 0:
        first_head = s.find("\n= ", s.find("= ") + 1) if s.find("= ") >= 0 else len(s)
    flags = []
    # place floats and their extents
    for pm in re.finditer(r"#place\([^\n]*\)\[", s):
        op = s.index("[", pm.start())
        en = block_end(s, op)
        if first_head >= 0 and pm.start() < first_head < en:
            flags.append(f"TRAP@line{s[:pm.start()].count(chr(10))+1}->{s[:en].count(chr(10))+1}")
    # front matter column-trapped: page columns 2, no place ending before first heading
    has_front_float = False
    for pm in re.finditer(r"#place\(top[^\n]*\)\[", s):
        if pm.start() > first_head:
            break
        op = s.index("[", pm.start())
        en = block_end(s, op)
        if en <= first_head:
            has_front_float = True
    if page2 and first_head > 0 and not has_front_float:
        flags.append("NOFRONT")
    # columns block wrapping body while page cols 2
    cm = re.search(r"#columns\(2[^\n]*\)\[", s)
    if cm and page2 and cm.start() < first_head:
        flags.append("NESTEDCOLS")
    if flags:
        print(pid, " ".join(flags))

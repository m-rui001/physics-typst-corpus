import io

p = "tools/migrate2202.py"
lines = io.open(p, encoding="utf-8").read().split("\n")
i = next(n for n, l in enumerate(lines) if l.strip() == 'a = f.get("author", "")')
j = next(n for n, l in enumerate(lines) if l.strip() == 'if f.get("eprint"):' and n > i)
new = [
    '    a = f.get("author", "")',
    '    if a:',
    '        a = re.sub(r"\\s*\\band\\s+others\\b", " et al.", a)',
    '        if a.endswith(" et al."):',
    '            head = a[:-len(" et al.")]',
    '            if " and " not in head and "," in head:',
    '                last, first = head.split(",", 1)',
    '                a = first.strip() + " " + last.strip() + " et al."',
    '        if re.search(r"\\bet al\\b", a):',
    '            f["author"] = "{%s}" % a.strip(" ,")',
    '        elif re.search(r"\\bCollaboration\\b", a) and "," not in a and " and " not in a:',
    '            f["author"] = "{%s}" % a.strip(" ,")',
]
lines[i:j] = new
io.open(p, "w", encoding="utf-8").write("\n".join(lines))
print("replaced", j - i, "lines")

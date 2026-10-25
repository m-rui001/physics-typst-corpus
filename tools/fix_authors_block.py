import io

p = "tools/migrate2202.py"
s = io.open(p, encoding="utf-8").read()
start = '    a = f.get("author", "")'
end = '            f["author"] = "{%s}" % a.strip(" ,")'
i = s.index(start)
j = s.index(end, i) + len(end)
new = '''    a = f.get("author", "")
    if a:
        a = re.sub(r"\\s*\\band\\s+others\\b", " et al.", a)
        if re.search(r"\\bet al\\b", a):
            f["author"] = "{%s}" % a.strip(" ,")
        elif re.search(r"\\bCollaboration\\b", a) and "," not in a and " and " not in a:
            f["author"] = "{%s}" % a.strip(" ,")'''
s = s[:i] + new + s[j:]
io.open(p, "w", encoding="utf-8").write(s)
print("fixed", j - i, "chars")

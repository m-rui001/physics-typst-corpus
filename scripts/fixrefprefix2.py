import re, glob, shutil

words = [("Table", "Table"), ("Figure", "Figure"), ("Section", "Section"),
         ("Tab.", "Tab."), ("Fig.", "Fig."), ("Sec.", "Sec."),
         ("Equation", "Equation"), ("Eq.", "Eq.")]

skip = re.compile(r"(?:#ref|#link|#cite|#figure|#table|#label)\s*\(?\s*<[^<>]*>$")
total = 0
for p in sorted(glob.glob(r"E:\phys\papers\*\main.typ")):
    s = open(p, encoding="utf-8", errors="replace").read()
    # labels actually defined in this document
    labels = set()
    for m in re.finditer(r"(?<![\w(.])<([A-Za-z][^<>\s]*)>", s):
        lab = m.group(1)
        before = s[max(0, m.start() - 12):m.start()]
        if re.search(r"#(ref|link|cite)\(\s*$", before):
            continue
        labels.add(lab)
    n_doc = 0
    for word, sup in words:
        pat = re.compile(r"%s([\s~]+)@([A-Za-z0-9][\w:._/-]*)" % re.escape(word))
        def f(m):
            global n_doc
            lab = m.group(2)
            if lab not in labels:
                return m.group(0)
            n_doc += 1
            return "#ref(<%s>, supplement: [%s])" % (lab, sup)
        s = pat.sub(f, s)
    if n_doc:
        shutil.copyfile(p, p.replace("main.typ", "_work/main.pre_refprefix.typ"))
        open(p, "w", encoding="utf-8", newline="\n").write(s)
        print(n_doc, p)
        total += n_doc
print("total", total)

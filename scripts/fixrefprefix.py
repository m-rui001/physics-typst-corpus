import re, glob, os, shutil, sys

papers = sorted(glob.glob(r"E:\phys\papers\*\main.typ"))
pat_tab = re.compile(r"Tab\.~@((?:tab|table)[\w:.:\-/]*)")
pat_fig = re.compile(r"Fig\.~@((?:fig|figure)[\w:.:\-/]*)")
pat_sec = re.compile(r"Sec\.~@(sec[\w:.:\-/]*)")
pat_sec2 = re.compile(r"Section~@(sec[\w:.:\-/]*)")
pat_eq = re.compile(r"Eq\.~@(eq[\w:.:\-/]*)")
changed = []
for p in papers:
    s = open(p, encoding="utf-8", errors="replace").read()
    o = s
    s = pat_tab.sub(lambda m: "#ref(<%s>, supplement: [Tab.])" % m.group(1), s)
    s = pat_fig.sub(lambda m: "#ref(<%s>, supplement: [Fig.])" % m.group(1), s)
    s = pat_sec.sub(lambda m: "#ref(<%s>, supplement: [Sec.])" % m.group(1), s)
    s = pat_sec2.sub(lambda m: "#ref(<%s>, supplement: [Section])" % m.group(1), s)
    s = pat_eq.sub(lambda m: "Eq.~#ref(<%s>)" % m.group(1), s)
    if s != o:
        shutil.copyfile(p, p.replace("main.typ", "_work/main.pre_refprefix.typ"))
        open(p, "w", encoding="utf-8", newline="\n").write(s)
        changed.append((p, len(pat_tab.findall(o)) + len(pat_fig.findall(o)) +
                        len(pat_sec.findall(o)) + len(pat_sec2.findall(o)) + len(pat_eq.findall(o))))
for p, n in changed:
    print(n, p)
print("papers changed:", len(changed))

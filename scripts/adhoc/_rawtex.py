import glob, os, re
from collections import Counter

def math_spans(line):
    out=[]; i=0; n=len(line)
    while i<n:
        if line[i]=='$':
            j=i+1
            while j<n:
                if line[j]=='$' and line[j-1] != '\\':
                    break
                j+=1
            if j<n:
                out.append((i,j)); i=j+1; continue
        i+=1
    return out

pat = re.compile(r"\\[A-Za-z]{2,}")
tot=0
for p in sorted(glob.glob(r"E:\phys\papers\*\main.typ")):
    pid=os.path.basename(os.path.dirname(p))
    txt=open(p,encoding='utf-8').read()
    c=Counter(); ex={}
    for ln,line in enumerate(txt.splitlines(),1):
        if "\\" not in line: continue
        for a,b in math_spans(line):
            seg=line[a:b]
            for m in pat.finditer(seg):
                w=m.group(0)
                c[w]+=1
                ex.setdefault(w,(ln,seg[max(0,m.start()-30):m.start()+40]))
    if c:
        print("==",pid,sum(c.values()))
        for w,n in c.most_common(12):
            ln,ctx=ex[w]
            print("  %-14s x%-3d L%d  %s" % (w,n,ln,ctx))
        tot+=sum(c.values())
print("TOTAL",tot)

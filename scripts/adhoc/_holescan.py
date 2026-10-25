import glob, io, os, sys

def spans_math(line):
    """return list of (start,end) of $...$ spans"""
    out=[]; i=0; n=len(line)
    while i<n:
        if line[i]=='$':
            # skip escaped \$
            if i>0 and line[i-1]=='\\':
                i+=1; continue
            j=i+1
            while j<n:
                if line[j]=='$' and line[j-1]!='\\':
                    break
                j+=1
            if j<n:
                out.append((i,j)); i=j+1; continue
        i+=1
    return out

tot=0
for p in glob.glob(r"E:\phys\papers\*\main.typ"):
    txt=open(p,encoding='utf-8').read()
    if r"\_" not in txt: continue
    pid=os.path.basename(os.path.dirname(p))
    hits=[]
    for ln,line in enumerate(txt.splitlines(),1):
        if r"\_" not in line: continue
        ms=spans_math(line)
        idx=0
        while True:
            k=line.find(r"\_",idx)
            if k<0: break
            inmath=any(a<k<b for a,b in ms)
            hits.append((ln,inmath,line[max(0,k-45):k+45].replace("\n"," ")))
            idx=k+2
    print("==",pid,len(hits))
    for ln,inmath,ctx in hits[:20]:
        print("  L%d %s %s" % (ln,"INMATH" if inmath else "TEXT  ",ctx))
    tot+=len(hits)
print("TOTAL",tot)

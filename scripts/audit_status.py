import os,re,subprocess,glob
rows=[]
for d in sorted(glob.glob('papers/*')):
    mt=os.path.join(d,'main.typ')
    if not os.path.exists(mt): continue
    src=glob.glob(os.path.join(d,'src','*.tex'))
    two=False
    for f in src:
        t=open(f,encoding='utf-8',errors='ignore').read(4000)
        m=re.search(r'\documentclass(?:\[([^\]]*)\])?\{([^}]+)\}',t)
        if m:
            opts=(m.group(1) or '').replace(' ','')
            two=('twocolumn' in opts and 'preprint' not in opts) or m.group(2) in ('aastex631','aastex62','mnras')
            break
    s=open(mt,encoding='utf-8',errors='ignore').read(3000)
    cols=bool(re.search(r'#set page\([^)]*columns:\s*2|#columns\(',s))
    r=subprocess.run(['typst','compile',mt,os.path.join(d,'_work','_a.pdf')],capture_output=True,text=True,errors='replace')
    errs=len(re.findall(r'^error:',r.stderr or '',re.M))
    pages=0
    try:
        import fitz; pages=fitz.open(os.path.join(d,'_work','_a.pdf')).page_count
    except Exception: pass
    rows.append((os.path.basename(d),two,cols,errs,pages))
for r in rows: print("%s two=%s cols2=%s err=%d pages=%s"%r)
print("MISMATCH",[r[0] for r in rows if r[1]!=r[2]])
print("ERRS",[r[0] for r in rows if r[3]])

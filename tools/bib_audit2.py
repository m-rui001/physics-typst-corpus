import re, glob, os
ent = re.compile(r'@(\w+)\{([^,\n]+),\n((?:(?!\n@).)*?)\n\}', re.S)
for p in sorted(glob.glob('papers/*/refs.bib')):
    t = open(p, encoding='utf-8').read()
    flags = {}
    for m in ent.finditer(t):
        typ, key, body = m.group(1), m.group(2), m.group(3)
        def fld(n):
            x = re.search(r'^\s*' + n + r'\s*=\s*\{(.*)\},?\s*$', body, re.M)
            return x.group(1) if x else ''
        ti, jo, vo, pa, au = fld('title'), fld('journal'), fld('volume'), fld('pages'), fld('author')
        if re.search(r'\b(vol\.|pp?\.|no\.)\s', ti): flags.setdefault('title-has-citation', []).append(key)
        if '~' in ti: flags.setdefault('title-tilde', []).append(key)
        if '``' in ti or "''" in ti: flags.setdefault('title-texquotes', []).append(key)
        if re.search(r'\bvol\.', jo): flags.setdefault('journal-has-vol', []).append(key)
        if re.match(r'^[A-Z]\d+$', vo): flags.setdefault('vol-letter', []).append(key)
        if pa and not re.match(r'^[0-9A-Za-z]+(--[0-9A-Za-z]+)?$', pa): flags.setdefault('pages-odd', []).append(key)
        if re.search(r'(?i)\band\s+others\b', au): flags.setdefault('and-others', []).append(key)
        if typ == 'article' and not jo: flags.setdefault('article-no-journal', []).append(key)
    if flags:
        print(os.path.basename(os.path.dirname(p)))
        for k, v in flags.items():
            print('  ', k, len(v), v[:4])

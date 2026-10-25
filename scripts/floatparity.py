"""Compare float counts (figure/table) between src/*.tex and main.typ.

Flags papers where the converted document has fewer figures or tables than the
TeX source, i.e. floats that never made it into the Typst output.
"""
import glob, os, re, sys
sys.stdout.reconfigure(encoding="utf-8")

ENV = re.compile(r"\\begin\{(figure\*?|table\*?|longtable\*?)\}")


def src_counts(d):
    fig = tab = 0
    for p in glob.glob(os.path.join(d, "src", "**", "*.tex"), recursive=True):
        if re.search(r"(supplement|_sm|supp)[^/]*\.tex$", p, re.I):
            continue
        try:
            s = open(p, encoding="utf-8", errors="replace").read()
        except OSError:
            continue
        for m in ENV.finditer(s):
            e = m.group(1)
            if e.startswith("fig"):
                fig += 1
            else:
                tab += 1
    return fig, tab


def typ_counts(d):
    p = os.path.join(d, "main.typ")
    if not os.path.exists(p):
        return None
    s = open(p, encoding="utf-8", errors="replace").read()
    fig = len(re.findall(r"#figure\(", s)) + len(re.findall(r"#edfig\(", s))
    tab = len(re.findall(r"(?:#|(?<![\w.])table)\(", s))
    vis = s.count("[figvision]")
    return fig, tab, vis


rows = []
for d in sorted(glob.glob("papers/2*")):
    t = typ_counts(d)
    if t is None:
        continue
    sf, st = src_counts(d)
    tf, tt, vis = t
    if sf == 0 and st == 0:
        continue
    flag = ""
    if tf < sf:
        flag += " FIG-%d" % (sf - tf)
    if tt < st:
        flag += " TAB-%d" % (st - tt)
    rows.append((os.path.basename(d), sf, tf, st, tt, vis, flag))

print("%-12s %4s %4s %4s %4s %4s %s" % ("paper", "sf", "tf", "st", "tt", "vis", "flag"))
for r in rows:
    print("%-12s %4d %4d %4d %4d %4d %s" % r)

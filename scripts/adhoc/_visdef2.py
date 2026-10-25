import re, sys
sys.stdout.reconfigure(encoding="utf-8")
import pymupdf

pat = re.compile(
    r"\b(upright|left|right|thin|quad|mspace|mathrm|mathbf|text|frac|cases|sqrt|hat|dot|tilde|bar|cal|bb|bold|italic|serif|sans|displaystyle|limits)"
    r"\s*[\(\[\{]"
)
jobs = {
 "2102.01010": [5], "2102.01111": [41], "2104.04119": [9, 17],
 "2112.03708": [5, 6, 13, 25], "2112.04515": [12], "2202.02773": [50],
 "2204.12771": [15], "2205.10379": [5], "2206.11528": [2],
 "2306.16215": [9], "2308.07915": [7], "2410.05380": [11],
}
for pid, pgs in jobs.items():
    doc = pymupdf.open("papers/%s/main.pdf" % pid)
    for pg in pgs:
        t = doc[pg-1].get_text().replace(chr(10), " ")
        for m in pat.finditer(t):
            print("%s p%d: ...%s..." % (pid, pg, t[max(0, m.start()-70):m.start()+70]))
    doc.close()

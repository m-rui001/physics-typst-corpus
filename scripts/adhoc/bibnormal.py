"""Normalize LaTeX remnants inside refs.bib values.

Journals were stored as LaTeX macros (\\apj), accents as \\'{\\i}, and
conditional fragments as \\ifmmode..\\else..\\fi, all of which Typst renders
verbatim.  Convert to Unicode/plain text while leaving entry syntax intact.
"""
import os
import re
import sys
import unicodedata
from collections import Counter

BS = chr(92)

JOURNAL = {
    "apj": "Astrophys. J.", "apjl": "Astrophys. J. Lett.",
    "apjs": "Astrophys. J. Suppl. Ser.", "aj": "Astron. J.",
    "mnras": "Mon. Not. R. Astron. Soc.", "aap": "Astron. Astrophys.",
    "aa": "Astron. Astrophys.", "aapr": "Astron. Astrophys. Rev.",
    "araa": "Annu. Rev. Astron. Astrophys.", "prd": "Phys. Rev. D",
    "prl": "Phys. Rev. Lett.", "prc": "Phys. Rev. C", "pra": "Phys. Rev. A",
    "prb": "Phys. Rev. B", "prx": "Phys. Rev. X", "nat": "Nature",
    "nphys": "Nat. Phys.", "natastron": "Nat. Astron.",
    "physrep": "Phys. Rep.", "sovast": "Sov. Astron.",
    "pasj": "Publ. Astron. Soc. Japan", "pasp": "Publ. Astron. Soc. Pac.",
    "pasa": "Publ. Astron. Soc. Aust.", "jcap": "J. Cosmol. Astropart. Phys.",
    "apss": "Astrophys. Space Sci.", "icarus": "Icarus", "ao": "Appl. Opt.",
    "jgr": "J. Geophys. Res.", "spie": "Proc. SPIE", "sci": "Science",
    "nature": "Nature", "science": "Science", "uel": "Phys. Lett. B",
    "procspie": "Proc. SPIE", "ssr": "Space Sci. Rev.",
    "memsai": "Mem. Soc. Astron. Ital.", "nphysa": "Nucl. Phys. A",
    "aaps": "Astron. Astrophys. Suppl. Ser.", "iaucirc": "IAU Circ.",
    "nar": "New Astron. Rev.",
}

ACCENT = {"'": "\u0301", '"': "\u0308", "^": "\u0302", "~": "\u0303",
          "`": "\u0300", "=": "\u0304", ".": "\u0307"}
CMD_ACCENT = {"c": "\u0327", "v": "\u030c", "u": "\u0306", "H": "\u030b",
              "k": "\u0328", "r": "\u030a", "d": "\u0323", "b": "\u0331"}

SYMBOL = {
    "alpha": "\u03b1", "beta": "\u03b2", "gamma": "\u03b3", "delta": "\u03b4",
    "Delta": "\u0394", "epsilon": "\u03b5", "varepsilon": "\u03b5",
    "zeta": "\u03b6", "eta": "\u03b7", "theta": "\u03b8", "Theta": "\u0398",
    "kappa": "\u03ba", "lambda": "\u03bb", "Lambda": "\u039b", "mu": "\u03bc",
    "nu": "\u03bd", "xi": "\u03be", "pi": "\u03c0", "Pi": "\u03a0",
    "rho": "\u03c1", "sigma": "\u03c3", "Sigma": "\u03a3", "tau": "\u03c4",
    "upsilon": "\u03c5", "phi": "\u03c6", "varphi": "\u03c6",
    "Phi": "\u03a6", "chi": "\u03c7", "psi": "\u03c8", "Psi": "\u03a8",
    "omega": "\u03c9", "Omega": "\u03a9", "times": "\u00d7",
    "cdot": "\u00b7", "pm": "\u00b1", "mp": "\u2213", "approx": "\u2248",
    "sim": "\u223c", "lesssim": "\u2272", "gtrsim": "\u2273",
    "leq": "\u2264", "geq": "\u2265", "le": "\u2264", "ge": "\u2265",
    "less": "<", "greater": ">", "ll": "\u226a", "gg": "\u226b",
    "rightarrow": "\u2192", "to": "\u2192", "leftarrow": "\u2190",
    "leftrightarrow": "\u2194", "propto": "\u221d", "infty": "\u221e",
    "partial": "\u2202", "nabla": "\u2207", "int": "\u222b",
    "sum": "\u2211", "prod": "\u220f", "sqrt": "\u221a",
    "circ": "\u00b0", "dagger": "\u2020", "ddagger": "\u2021",
    "equiv": "\u2261", "simeq": "\u2243", "neq": "\u2260", "ne": "\u2260",
}

TEXT = {
    "ss": "\u00df", "o": "\u00f8", "O": "\u00d8", "aa": "\u00e5",
    "AA": "\u00c5", "ae": "\u00e6", "AE": "\u00c6", "oe": "\u0153",
    "OE": "\u0152", "l": "\u0142", "L": "\u0141", "i": "\u0131",
    "j": "\u0237", "texttimes": "\u00d7", "textperiodcentered": "\u00b7",
    "textendash": "\u2013", "textemdash": "\u2014", "ndash": "\u2013",
    "mdash": "\u2014", "textquoteright": "\u2019",
    "textquoterights": "\u2019", "textquoteleft": "\u2018",
    "textquotelefts": "\u2018", "textcopyright": "\u00a9",
    "copyright": "\u00a9", "textdegree": "\u00b0", "textminus": "\u2212",
    "textpm": "\u00b1", "textohm": "\u03a9", "textregistered": "\u00ae",
    "texttrademark": "\u2122", "textasciitilde": "~",
    "dots": "\u2026", "ldots": "\u2026", "textellipsis": "\u2026",
    "cdots": "\u22ef", "dotsb": "\u2026", "S": "\u00a7", "P": "\u00b6",
    "textbackslash": BS, "textless": "<", "textgreater": ">",
    "textbar": "|", "textunderscore": "_", "textdollar": "$",
    "textsection": "\u00a7", "textparagraph": "\u00b6",
    "textasciicircum": "^", "textonehalf": "\u00bd", "textonequarter": "\u00bc",
    "textrightarrow": "\u2192", "textleftarrow": "\u2190",
    "textquotedblleft": "\u201c", "textquotedblright": "\u201d",
    "textbullet": "\u2022", "textdagger": "\u2020", "textdaggerdbl": "\u2021",
    "textsterling": "\u00a3", "texteuro": "\u20ac", "textcent": "\u00a2",
}

WS_CMDS = ("quad", "qquad", ",", ";", ":", "!", " ", "med", "thinspace",
           "enspace", "hfill")

# font switches / layout commands whose scope ends with the current group
STRIP = {
    "textit", "textsl", "textsc", "textbf", "textrm", "textsf", "texttt",
    "emph", "ensuremath", "mathbb", "mathcal", "mathrm", "mathit", "mathbf",
    "mathsf", "mathop", "overline", "bar", "hat", "tilde", "vec", "dot",
    "ddot", "left", "right", "relax", "displaystyle", "textstyle",
    "href", "input", "endthebibliography", "ttfamily", "sffamily",
    "rmfamily", "bfseries", "mdseries", "itshape", "scshape", "upshape",
}

# byte-damaged values repaired by inspection (encoding lost the Greek letter)
FIXUPS = [("\x5ca\x89\x88 A-\x5cAA\x92\x5cA\xa9MSM", "\u03bdMSM")]

MACRO = {}
for _k, _v in TEXT.items():
    MACRO[_k] = _v
for _k, _v in SYMBOL.items():
    MACRO.setdefault(_k, _v)
for _k, _v in JOURNAL.items():
    MACRO.setdefault(_k, _v)
for _k in STRIP:
    MACRO.setdefault(_k, "")
NAMES = sorted(MACRO, key=len, reverse=True)


def mac_rep(m, stats):
    run = m.group(1)
    for name in NAMES:
        if run.startswith(name):
            return MACRO[name] + run[len(name):]
    stats["left:" + BS + run] += 1
    return run


def convert(s, stats):
    for bad, good in FIXUPS:
        if bad in s:
            s = s.replace(bad, good)
            stats["fixup"] += 1
    # C1 controls are remnants of mis-decoded UTF-8 in ADS exports
    s = re.sub(r"[\u0080-\u009f]", "", s)
    # conditionals: keep the text-mode branch
    for _ in range(6):
        new = re.sub(re.escape(BS) + r"ifmmode\s*(.*?)" + re.escape(BS)
                     + r"else\s*(.*?)" + re.escape(BS) + r"fi",
                     lambda m: m.group(2), s, flags=re.S)
        if new == s:
            break
        stats["conditional"] += 1
        s = new
    s = re.sub(re.escape(BS) + r"url\{([^{}]*)\}", r"\1", s)
    s = re.sub(re.escape(BS) + r"href\{[^{}]*\}\{([^{}]*)\}", r"\1", s)
    s = re.sub(re.escape(BS) + r"hspace\s*\{[^{}]*\}", "", s)
    s = re.sub(re.escape(BS) + r"hspace[-0-9.]*[a-z]*", "", s)
    s = re.sub(re.escape(BS) + r"ce\{([^{}]*)\}", r"\1", s)
    # macros glued to the next word (Mass\ndashRadius, J0437\minus4715)
    s = s.replace(BS + "ndash", "\u2013").replace(BS + "minus", "\u2212")
    # accents: braced argument first (\H{o}, \'{\i}), then a bare letter (\'e)
    def acc(m):
        ch = m.group(2).strip().replace(BS, "")
        return unicodedata.normalize("NFC", ch[:1] + ACCENT[m.group(1)])
    ACC = r"(['\"`^~=.])"
    for pat in (re.escape(BS) + ACC + r"\s*\{([^{}]*)\}",
                re.escape(BS) + ACC + r"\s*(\\?[^\W\d_])"):
        s = re.sub(pat, acc, s)
    def cacc(m):
        ch = m.group(2).strip().replace(BS, "")
        return unicodedata.normalize("NFC", ch[:1] + CMD_ACCENT[m.group(1)])
    for pat in (re.escape(BS) + r"(c|v|u|H|k|r|d|b)\s*\{([^{}]*)\}",
                re.escape(BS) + r"(c|v|u|H|k|r|d|b)\s*(\\?[A-Za-z])"):
        s = re.sub(pat, cacc, s)
    # wrappers
    for _ in range(3):
        s2 = re.sub(re.escape(BS) + r"(?:text|mathrm|mathit|mathbf|mathcal|mathsf|ensuremath|mathop|textrm|textit|textbf|textsl|textsc|mbox)\s*\{([^{}]*)\}", r"\1", s)
        if s2 == s:
            break
        s = s2
    s = re.sub(re.escape(BS) + r"(?:rm|it|bf)\s+", "", s)
    s = re.sub(re.escape(BS) + r"(?:left|right|relax|displaystyle|textstyle)(?![A-Za-z])", "", s)
    for cmd in WS_CMDS:
        s = s.replace(BS + cmd, " " if cmd.isalpha() or cmd == " " else "")
    # ADS sometimes double-escapes LaTeX: \\rho / \\{ / \\$ mean \rho / \{ / \$
    s = re.sub(re.escape(BS + BS) + r"(?=[A-Za-z{}$_%&])",
               lambda m: BS, s)
    # escaped literals
    for ch in "&%_#${}^":
        s = s.replace(BS + ch, ch)
    s = s.replace(BS + BS, " ")
    s = s.replace("$", "")
    # text and symbol macros by longest prefix, so glued runs split correctly
    # (\nue -> nu + e, \textbackslashDelta -> \ + Delta)
    s = re.sub(re.escape(BS) + r"([A-Za-z]+)", lambda m: mac_rep(m, stats), s)
    # \textbackslash can emit a fresh backslash mid-pass, so run it twice
    s = re.sub(re.escape(BS) + r"([A-Za-z]+)", lambda m: mac_rep(m, stats), s)
    # leftover control words
    for m in re.finditer(re.escape(BS) + r"[A-Za-z]+", s):
        stats["left:" + m.group(0)] += 1
    # last resort: a lone unknown control letter is just that letter
    s = re.sub(re.escape(BS) + r"([A-Za-z])(?![A-Za-z])", r"\1", s)
    for ch in "&%_#${}^":
        s = s.replace(BS + ch, ch)
    s = s.replace(BS + '"', '"')
    return s


JOURNAL_FIELDS = {"journal", "journaltitle", "booktitle", "publisher",
                  "school", "institution", "series", "howpublished",
                  "organization"}


def norm_value(field, val, stats):
    stripped = val.strip()
    m = re.fullmatch(re.escape(BS) + r"([A-Za-z]+)", stripped)
    if field.lower() in JOURNAL_FIELDS and m and m.group(1) in JOURNAL:
        stats["journal"] += 1
        return JOURNAL[m.group(1)]
    return convert(val, stats)


def process(text):
    stats = Counter()
    out = []
    i = 0
    n = len(text)
    while True:
        at = text.find("@", i)
        if at < 0:
            out.append(text[i:])
            break
        out.append(text[i:at])
        j = text.find("{", at)
        if j < 0:
            out.append(text[at:])
            break
        k = text.find(",", j)
        if k < 0:
            out.append(text[at:])
            break
        out.append(text[at:k + 1])
        p = k + 1
        while True:
            # comment lines inside an entry ("//Month = {Nov},") are copied as-is
            while True:
                mc = re.match(r"\s*(?://|%)[^\n]*\n", text[p:])
                if not mc:
                    break
                out.append(mc.group(0))
                p += mc.end()
            fs = p
            fm = re.match(r"\s*([A-Za-z][A-Za-z0-9_-]*)\s*=\s*", text[p:])
            if not fm:
                break
            name = fm.group(1)
            p += fm.end()
            head = text[fs:p]
            if p < n and text[p] == "{":
                depth = 0
                q = p
                while q < n:
                    c = text[q]
                    if c == BS:
                        q += 2
                        continue
                    if c == "{":
                        depth += 1
                    elif c == "}":
                        depth -= 1
                        if depth == 0:
                            break
                    q += 1
                val = text[p + 1:q]
                p = q + 1
                if name.lower() == "file":
                    out.append(head + "{" + val + "}")
                else:
                    out.append(head + "{" + norm_value(name, val, stats) + "}")
            elif p < n and text[p] == '"':
                q = p + 1
                while q < n:
                    if text[q] == '"' and text[q - 1] != BS:
                        break
                    q += 1
                val = text[p + 1:q]
                p = q + 1
                out.append(head + '"' + norm_value(name, val, stats) + '"')
            else:
                q = text.find(",", p)
                if q < 0:
                    q = n
                val = text[p:q]
                p = q
                out.append(head + norm_value(name, val, stats))
            cm = re.match(r"\s*,\s*", text[p:])
            if cm:
                out.append(cm.group(0))
                p += cm.end()
            else:
                break
        i = p
    return "".join(out), stats


if __name__ == "__main__":
    for path in [a for a in sys.argv[1:] if not a.startswith("--")]:
        src = open(path, encoding="utf-8").read()
        res, st = process(src)
        changed = sum(v for k, v in st.items() if not k.startswith("left:"))
        left = {k[5:]: v for k, v in st.items() if k.startswith("left:")}
        print(f"{path}: {changed} replacements, journal={st.get('journal',0)} "
              f"accent/symbol={st.get('symbol',0)+st.get('text',0)} "
              f"cond={st.get('conditional',0)}")
        if left:
            print("   leftover:", dict(sorted(left.items(), key=lambda x: -x[1])[:12]))
        print(f"   changed_bytes={res != src}")
        if "--write" in sys.argv and res != src:
            bak = path + ".pretex"
            if not os.path.exists(bak):
                open(bak, "w", encoding="utf-8", newline="").write(src)
            open(path, "w", encoding="utf-8", newline="").write(res)

r"""Repair converter-mangled inline math inside $...$ spans.

The old pipeline fed `{\cal L}` / `\rm` / `\tilde F` to pandoc, which dropped those
spans or letter-spaced them (`F i l d e F`), deleted `\/` (a literal slash) and
`\(` `\)` (rendered parentheses). Everything here is span-local: markup, labels,
citations and prose are untouched.

Usage: python -X utf8 scripts/mathclean.py papers/2202.13919 [--apply]
"""
import io, os, re, sys

B = chr(92)


def clean(s):
    # slash: `\/` is what pandoc writes for `/`; `\/` also arrived from \frac{}{} loss
    s = s.replace(B + "/", "/")
    # pandoc's \left( ... \right)
    s = s.replace(B + "(", "(").replace(B + ")", ")")
    # style calls whose letters were split: upright(F G , o) -> "FG,o"
    s = re.sub(r'upright\("cal"\)\s*([A-Z])', r"cal(\1)", s)
    s = re.sub(r'_\(upright\("upright"\)\)\s*\(\s*upright\("([A-Za-z]+)"\)\s*\)',
               r'_"\1"', s)
    for a, b in (('upright("tilde")', "tilde"), ('upright("gg")', '"gg"'),
                 ('upright("rm")', '""'), ('upright("frac")', "frac")):
        s = s.replace(a, b)
    def style(m):
        name, body = m.group(1), re.sub(r"\s+", "", m.group(2))
        if name == "upright":
            return '"%s"' % body
        return "%s(%s)" % (name, body)
    s = re.sub(r'\b(upright|bold|italic|sans|tt|cal)\(([A-Za-z ,]+)\)', style, s)
    # leftovers of `\rm` switches
    s = s.replace('upright("upright")', "")
    # letter-spaced words, longest first
    words = ["e q u i v a s i g m a", "e q . s i m i l a r", "i n t e g r a l",
             "c o n s t a n t", "a med f e w", "k a p p a", "S i g m a",
             "a l p h a", "m u n u", "s q r t", "s u m", "c h i", "t a u",
             "e t a", "x i"]
    for w in words:
        s = s.replace(w, {"e q u i v a s i g m a": "equiv",
                          "e q . s i m i l a r": "tilde.eq",
                          "c o n s t a n t": '"constant"',
                          "a med f e w": '"a few"',
                          "m u n u": "mu nu", "s q r t": "sqrt",
                          "i n t e g r a l": "integral", "s u m": "sum",
                          "k a p p a": "kappa", "S i g m a": "Sigma",
                          "a l p h a": "alpha", "c h i": "chi", "t a u": "tau",
                          "e t a": "eta", "x i": "xi"}[w])
    # `frac14` arrived as `frac 14`
    s = re.sub(r"frac (\d)(\d)", r"frac(\1,\2)", s)
    # `(() ...)` is a lost exponent group: keep the inside
    s = re.sub(r"\(\(\)\s*([^()]*)\)", r"(\1)", s)
    # `(- 1  2)` is a lost \frac{-1}{2}
    s = re.sub(r"\(-\s*1\s+2\)", "(-1/2)", s)
    # `)  sqrt(` / `1  sqrt(` are divisions whose slash disappeared
    s = re.sub(r"\)\s+sqrt\(", ")/sqrt(", s)
    s = re.sub(r"(?<=[A-Za-z0-9])\s+sqrt\(", "/sqrt(", s)
    # `R^2  6 M^2` style lost fractions before a coefficient
    s = re.sub(r"(\w\^2)\s+(\d+)\s+([A-Za-z]\^2)", r"\1/(\2 \3)", s)
    s = re.sub(r"(?<=[A-Za-z0-9])\s+(\d+)\s+(?=[A-Za-z]\b)", r"/\1 ", s)
    # LaTeX spacing in math: \, is a comma, \; a semicolon, \! nothing
    s = s.replace(B + ",", ",").replace(B + ";", ";").replace(B + "!", "")
    s = s.replace(B + "left[", "[").replace(B + "right]", "]")
    s = re.sub(r"\s{2,}", " ", s)
    return s.strip()


def main():
    p = sys.argv[1]
    apply = "--apply" in sys.argv
    mp = os.path.join(p, "main.typ")
    t = io.open(mp, encoding="utf-8").read()
    n = [0]

    def span(m):
        new = clean(m.group(1))
        if new != m.group(1):
            n[0] += 1
        return "$" + new + "$"

    out = []
    i, n = 0, [0]
    while i < len(t):
        a = t.find("$", i)
        if a < 0:
            out.append(t[i:])
            break
        b = t.find("$", a + 1)
        if b < 0:
            out.append(t[i:])
            break
        out.append(t[i:a])
        body = t[a + 1:b]
        new = body if "\n" in body else clean(body)
        if new != body:
            n[0] += 1
        out.append("$" + new + "$")
        i = b + 1
    print("spans changed", n[0])
    if apply:
        io.open(mp + ".premathclean", "w", encoding="utf-8", newline="\n").write(t)
        io.open(mp, "w", encoding="utf-8", newline="\n").write("".join(out))


if __name__ == "__main__":
    main()

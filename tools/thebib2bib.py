r"""Build refs.bib from a LaTeX `thebibliography` block in the Nature/bbl format.

Handles entries written as

    \bibitem[1]{Key}
    \bibinfo{author}{{Woosley}, S.~E.} \& \bibinfo{author}{{Bloom}, J.~S.}
    \newblock \bibinfo{title}{{The ...}}.
    \newblock \emph{\bibinfo{journal}{\araa}} \textbf{\bibinfo{volume}{44}},
      \bibinfo{pages}{507--556} (\bibinfo{year}{2006}).

Usage: python tools/thebib2bib.py <main.tex> <out.bib>
"""
import re
import sys

JOURNALS = {
    r"\apj": "The Astrophysical Journal",
    r"\apjl": "The Astrophysical Journal Letters",
    r"\apjs": "The Astrophysical Journal Supplement Series",
    r"\mnras": "Monthly Notices of the Royal Astronomical Society",
    r"\nat": "Nature",
    r"\aap": "Astronomy & Astrophysics",
    r"\ssr": "Space Science Reviews",
    r"\aj": "The Astronomical Journal",
    r"\araa": "Annual Review of Astronomy and Astrophysics",
    r"\pasp": "Publications of the Astronomical Society of the Pacific",
    r"\prd": "Physical Review D",
    r"\prl": "Physical Review Letters",
    r"\actaa": "Acta Astronomica",
    r"\jcap": "Journal of Cosmology and Astroparticle Physics",
}

GREEK = {
    "alpha": "α", "beta": "β", "gamma": "γ", "delta": "δ", "epsilon": "ϵ",
    "zeta": "ζ", "eta": "η", "theta": "θ", "iota": "ι", "kappa": "κ",
    "lambda": "λ", "mu": "μ", "nu": "ν", "xi": "ξ", "pi": "π", "rho": "ρ",
    "sigma": "σ", "tau": "τ", "upsilon": "υ", "phi": "ϕ", "chi": "χ",
    "psi": "ψ", "omega": "ω", "Gamma": "Γ", "Delta": "Δ", "Theta": "Θ",
    "Lambda": "Λ", "Xi": "Ξ", "Pi": "Π", "Sigma": "Σ", "Upsilon": "Υ",
    "Phi": "Φ", "Psi": "Ψ", "Omega": "Ω",
}
SYMBOLS = {
    "lesssim": "≲", "gtrsim": "≳", "sim": "∼", "pm": "±", "times": "×",
    "approx": "≈", "leq": "≤", "geq": "≥", "neq": "≠", "infty": "∞",
    "rightarrow": "→", "to": "→", "odot": "⊙", "ast": "∗", "deg": "°",
    "prime": "′", "ldots": "…", "dots": "…", "sun": "☉", "oplus": "⊕",
}
ACCENTS = {"'": "\u0301", "`": "\u0300", '"': "\u0308", "^": "\u0302",
           "~": "\u0303", "c": "\u0327", "v": "\u030c", "H": "\u030b"}


def detex(s):
    s = re.sub(r"\$([^$]*)\$", r"\1", s)
    s = re.sub(r"\\ensuremath\{([^{}]*)\}", lambda m: detex(m.group(1)), s)

    def sym(m):
        name = m.group(1)
        if name in GREEK:
            return GREEK[name]
        if name in SYMBOLS:
            return SYMBOLS[name]
        if name in ("text", "mathrm", "mathit", "rm", "it", "emph", "textbf", "bibinfo"):
            return m.group(2) if m.lastindex and m.lastindex >= 2 else ""
        return ""
    # \cmd{arg}
    for _ in range(4):
        s = re.sub(r"\\([A-Za-z]+)\{([^{}]*)\}", lambda m: (GREEK.get(m.group(1)) or SYMBOLS.get(m.group(1)) or m.group(2)), s)
    # accents \'e, \"o, \c{c}
    s = re.sub(r"\\(['`\"^~.])\s*\{?([A-Za-z])\}?", lambda m: m.group(2) + ACCENTS.get(m.group(1), ""), s)
    s = re.sub(r"\\c\s*\{?([A-Za-z])\}?", lambda m: m.group(1) + ACCENTS["c"], s)
    s = re.sub(r"\\([A-Za-z]+)(?![A-Za-z{])",
               lambda m: GREEK.get(m.group(1)) or SYMBOLS.get(m.group(1)) or "", s)
    s = s.replace("~", " ").replace("---", "—").replace("--", "–")
    s = s.replace("{", "").replace("}", "")
    s = re.sub(r"\s+", " ", s).strip()
    return s


def parse_entry(key, body):
    body = body.replace("\\bibinfo{author}", "\\bibinfo{author}")
    body = re.sub(r"\\ifcase#1.*?\\fi", " ", body, flags=re.S)
    fields = {}
    for m in re.finditer(r"\\bibinfo\{(\w+)\}\{", body):
        name = m.group(1)
        i = m.end()
        depth = 1
        while i < len(body) and depth:
            if body[i] == "{":
                depth += 1
            elif body[i] == "}":
                depth -= 1
            i += 1
        val = body[m.end():i - 1]
        fields.setdefault(name, val)
    authors = [detex(a) for a in re.findall(r"\\bibinfo\{author\}\{((?:[^{}]|\{[^{}]*\})*)\}", body)]
    authors = [a for a in authors if a]
    if not authors:
        return None
    # join authors: strip trailing commas, mark et al.
    names = []
    for a in authors:
        names.append(a.strip().rstrip(","))
    if re.search(r"\\emph\{et~al\.\}", body) or re.search(r"\bet al\b", body):
        names.append("others")
    author = " and ".join(names)
    title = detex(fields.get("title", ""))
    journal = detex(fields.get("journal", fields.get("booktitle", ""))).strip()
    for macro, full in JOURNALS.items():
        if macro + "}" in fields.get("journal", "") or macro in fields.get("journal", ""):
            journal = full
            break
    volume = detex(fields.get("volume", ""))
    pages = detex(fields.get("pages", ""))
    year = detex(fields.get("year", ""))
    out = ["@article{%s," % key]
    out.append("  author = {%s}," % author)
    if title:
        out.append("  title = {%s}," % title)
    if journal:
        out.append("  journal = {%s}," % journal)
    if volume:
        out.append("  volume = {%s}," % volume)
    if pages:
        out.append("  pages = {%s}," % pages)
    if year:
        out.append("  year = {%s}," % year)
    out[-1] = out[-1].rstrip(",")
    out.append("}")
    return "\n".join(out)


def convert(tex, outpath):
    entries = []
    for block in re.finditer(r"\\begin\{thebibliography\}.*?\\end\{thebibliography\}", tex, re.S):
        b = block.group(0)
        items = re.split(r"\\bibitem(?:\[[^\]]*\])?", b)[1:]
        keys = re.findall(r"\\bibitem(?:\[[^\]]*\])?\{([^}]*)\}", b)
        for key, body in zip(keys, items):
            body = body.split("\\end{thebibliography}")[0]
            e = parse_entry(key, body)
            if e:
                entries.append((key, e))
    with open(outpath, "w", encoding="utf-8", newline="\n") as f:
        f.write("\n\n".join(e for _, e in entries) + "\n")
    return [k for k, _ in entries]


if __name__ == "__main__":
    tex = open(sys.argv[1], encoding="utf-8", errors="replace").read()
    keys = convert(tex, sys.argv[2])
    bad = [k for k in keys if not re.fullmatch(r"[A-Za-z0-9_.:-]+", k)]
    print("entries", len(keys), "odd keys", bad)

"""Rebuild 2202.02773 refs.bib from the paper's own LB.bib + litebird_ptep.bib.

- parse BibTeX entries (brace/quote values)
- decode LaTeX accents/escapes and simple math
- drop fields Typst chokes on
- dedupe keys (LB wins)
- report citation-key coverage against main.typ and propose remaps
"""
import io
import re
import sys
import json

ACC = {
    '"': {"o": "ö", "u": "ü", "a": "ä", "e": "ë", "i": "ï", "O": "Ö", "U": "Ü", "A": "Ä"},
    "'": {"c": "ć", "C": "Ć", "e": "é", "E": "É", "a": "á", "A": "Á", "o": "ó", "O": "Ó",
          "u": "ú", "U": "Ú", "i": "í", "I": "Í", "n": "ń", "y": "ý", "s": "ś", "z": "ź",
          "g": "ǵ", "l": "ĺ", "r": "ŕ"},
    "`": {"e": "è", "a": "à", "o": "ò", "u": "ù", "i": "ì"},
    "^": {"o": "ô", "a": "â", "e": "ê", "i": "î", "u": "û"},
    "~": {"n": "ñ", "N": "Ñ", "o": "õ", "a": "ã", "i": "ĩ", "u": "ũ"},
    ".": {"z": "ż", "Z": "Ż", "c": "ċ", "C": "Ċ", "e": "ė", "E": "Ė", "g": "ġ", "G": "Ġ"},
    "v": {"c": "č", "s": "š", "z": "ž", "r": "ř", "e": "ě", "C": "Č", "S": "Š", "Z": "Ž",
          "n": "ň", "N": "Ň", "d": "ď", "D": "Ď", "t": "ť", "T": "Ť", "g": "ǧ"},
    "u": {"a": "ă", "A": "Ă", "g": "ğ", "G": "Ğ"},
    "H": {"o": "ő", "O": "Ő", "u": "ű", "U": "Ű"},
    "k": {"a": "ą", "A": "Ą", "e": "ę", "E": "Ę"},
}
GREEK = {
    "alpha": "α", "beta": "β", "gamma": "γ", "delta": "δ", "epsilon": "ε", "zeta": "ζ",
    "eta": "η", "theta": "θ", "iota": "ι", "kappa": "κ", "lambda": "λ", "mu": "μ",
    "nu": "ν", "xi": "ξ", "pi": "π", "rho": "ρ", "sigma": "σ", "tau": "τ", "upsilon": "υ",
    "phi": "φ", "chi": "χ", "psi": "ψ", "omega": "ω", "Gamma": "Γ", "Delta": "Δ",
    "Theta": "Θ", "Lambda": "Λ", "Xi": "Ξ", "Pi": "Π", "Sigma": "Σ", "Upsilon": "Υ",
    "Phi": "Φ", "Psi": "Ψ", "Omega": "Ω", "sim": "∼", "gtrsim": "≳", "lesssim": "≲",
    "approx": "≈", "simeq": "≃", "times": "×", "pm": "±", "mp": "∓", "le": "≤", "ge": "≥",
    "neq": "≠", "ll": "≪", "gg": "≫", "infty": "∞", "odot": "⊙", "circ": "∘",
    "rightarrow": "→", "leftarrow": "←", "to": "→", "langle": "⟨", "rangle": "⟩",
    "propto": "∝", "equiv": "≡", "star": "⋆", "ast": "∗", "prime": "′", "doteq": "≐",
    "ldots": "…", "dots": "…", "cdot": "·", "deg": "°",
}
SUP = str.maketrans("0123456789+-=()n", "⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ⁿ")


def dec_tex(t):
    t = re.sub(r"\\(?:textit|textrm|textbf|textsc|textnormal|text|mathrm|mathbf|mathit|emph|bf|it|rm|sc)\s*", "", t)
    t = t.replace("\\&", "&").replace("\\%", "%").replace("\\_", "_").replace("\\#", "#")
    t = t.replace("\\$", "$").replace("\\{", "{").replace("\\}", "}").replace("\\ ", " ")
    t = t.replace("---", "—").replace("--", "–")
    t = t.replace("~", " ")
    t = re.sub(r"\\(['\"`^~.vuHk])\s*\{?\s*([A-Za-z])\s*\}?",
               lambda m: ACC.get(m.group(1), {}).get(m.group(2), m.group(2)), t)
    t = re.sub(r"\\([A-Za-z]+)\s*", lambda m: GREEK.get(m.group(1), m.group(1)), t)
    # simple math: $^{3}$ -> superscript, $\gamma$ -> glyph, $x_i$ -> x_i
    def mathrep(m):
        body = m.group(1)
        def sup(mm):
            return "^{" + mm.group(1).translate(SUP) + "}" if all(c in "0123456789+-=()n" for c in mm.group(1)) else "^{" + mm.group(1) + "}"
        body = re.sub(r"\^\{([^{}]*)\}", sup, body)
        body = re.sub(r"\^(\w)", lambda mm: "^" + mm.group(1).translate(SUP), body)
        return body
    t = re.sub(r"\$([^$]*)\$", mathrep, t)
    t = t.replace("{", "").replace("}", "")
    t = re.sub(r"\s+", " ", t)
    return t.strip()


def find_entry_end(s, i):
    d = 1
    while i < len(s):
        c = s[i]
        if c == "{":
            d += 1
        elif c == "}":
            d -= 1
            if d == 0:
                return i
        i += 1
    return len(s)


def read_value(s, i):
    """s[i] at value start; return (value, next index after value and comma)."""
    while i < len(s) and s[i].isspace():
        i += 1
    if i >= len(s):
        return "", i
    if s[i] == "{":
        d = 0
        for j in range(i, len(s)):
            if s[j] == "{":
                d += 1
            elif s[j] == "}":
                d -= 1
                if d == 0:
                    return s[i + 1:j], j + 1
        return s[i + 1:], len(s)
    if s[i] == '"':
        for j in range(i + 1, len(s)):
            if s[j] == '"':
                return s[i + 1:j], j + 1
        return s[i + 1:], len(s)
    m = re.match(r"[^,}\n]+", s[i:])
    v = m.group(0).strip()
    return v, i + m.end()


def parse_bib(path):
    s = io.open(path, encoding="utf-8", errors="ignore").read()
    out = []
    i = 0
    while True:
        m = re.search(r"@(\w+)\s*\{\s*([^,\s}]+)\s*,", s[i:])
        if not m:
            break
        typ = m.group(1).lower()
        key = m.group(2)
        start = i + m.end()
        end = find_entry_end(s, start)
        body = s[start:end]
        fields = {}
        j = 0
        while j < len(body):
            fm = re.match(r"\s*([A-Za-z]+)\s*=\s*", body[j:])
            if not fm:
                break
            name = fm.group(1).lower()
            j += fm.end()
            val, j = read_value(body, j)
            fields[name] = val.strip()
            while j < len(body) and body[j] in " ,\n\t":
                j += 1
        out.append((typ, key, fields))
        i = end + 1
    return out


KEEP = ("author", "title", "journal", "booktitle", "publisher", "series", "editor",
        "volume", "number", "pages", "year", "doi", "eprint", "archiveprefix", "note")


def load_journal_macros(path):
    m = {}
    try:
        s = io.open(path, encoding="utf-8", errors="ignore").read()
    except OSError:
        return m
    for mm in re.finditer(r"\\def\\([A-Za-z]+)\{([^{}]*)\}", s):
        name, val = mm.group(1), mm.group(2)
        name = re.sub(r"@.*$", "", name)
        if name and val:
            m[name] = val
    return m


JM = {}


def clean(typ, fields):
    f = {}
    for k in KEEP:
        if k in fields and fields[k]:
            raw = fields[k]
            if k in ("journal", "booktitle", "series"):
                raw = re.sub(r"\\([A-Za-z]+)", lambda m: JM.get(m.group(1), m.group(0)), raw)
            v = dec_tex(raw)
            if v:
                f[k] = v
    if f.get("archiveprefix"):
        f["archiveprefix"] = "arXiv"
    a = f.get("author", "")
    if a:
        a = re.sub(r"\s*\band\s+others\b", " et al.", a)
        if a.endswith(" et al."):
            head = a[:-len(" et al.")]
            if " and " not in head and "," in head:
                last, first = head.split(",", 1)
                a = first.strip() + " " + last.strip() + " et al."
        if re.search(r"\bet al\b", a):
            f["author"] = "{%s}" % a.strip(" ,")
        elif re.search(r"\bCollaboration\b", a) and "," not in a and " and " not in a:
            f["author"] = "{%s}" % a.strip(" ,")
    if f.get("eprint"):
        f["eprint"] = f["eprint"].strip()
    # journal fallback for @misc with eprint
    if typ == "misc" and f.get("eprint") and not f.get("journal"):
        f["journal"] = "arXiv preprint arXiv:" + re.sub(r"^arxiv:", "", f["eprint"], flags=re.I)
        typ = "article"
    if typ in ("phdthesis", "mastersthesis"):
        f.setdefault("type", "PhD thesis" if typ == "phdthesis" else "Master's thesis")
        f["type"] = "PhD thesis" if typ == "phdthesis" else "Master's thesis"
        typ = "thesis"
    return typ, f


def main():
    out = sys.argv[2]
    JM.update(load_journal_macros("src/journal-macros.tex"))
    src = sys.argv[1].split(",")
    best = {}
    order = []
    for path in src:
        for typ, key, fields in parse_bib(path):
            typ, f = clean(typ, fields)
            score = len(f) + (3 if "title" in f else 0) + (2 if "journal" in f else 0)
            if key not in best:
                best[key] = (score, typ, f)
                order.append(key)
            elif score > best[key][0]:
                best[key] = (score, typ, f)
    entries = [(best[k][1], k, best[k][2]) for k in order]
    # coverage
    typfile = sys.argv[3]
    t = io.open(typfile, encoding="utf-8").read()
    cites = {c for c in re.findall(r"@([A-Za-z0-9:._/+\-]+)", t)
             if not re.match(r"(eq|fig|tab|sec|lst|thm|lem|app|alg|line):", c)}
    clabels = set(re.findall(r"#cite\(\s*<([^>]+)>", t))
    cites |= clabels
    cites = sorted(cites)
    # sanitize keys to Typst-label-safe characters
    def sanitize(k):
        return re.sub(r"[^A-Za-z0-9:._\-]", "-", k)
    used = set()
    renamed = []
    for typ, key, f in entries:
        nk = sanitize(key)
        base = nk
        n = 2
        while nk in used:
            nk = "%s-%d" % (base, n)
            n += 1
        used.add(nk)
        renamed.append((typ, nk, f))
    entries = renamed
    keys = {k for _, k, _ in entries}
    def norm(k):
        return re.sub(r"[^a-z0-9]", "", k.lower())
    idx = {}
    for k in keys:
        idx.setdefault(norm(k), []).append(k)
    def cands(c):
        base = c.rstrip(".,:;")
        return [c] + [k for k in idx.get(norm(base), [])]
    mapping = {}
    unresolved = []
    for c in cites:
        hit = None
        for cand in cands(c):
            if cand in keys:
                hit = cand
                break
        if hit:
            mapping[c] = hit
        else:
            unresolved.append(c)
    print("entries", len(entries), "cited", len(cites), "mapped", len(mapping),
          "unresolved", len(unresolved))
    print("UNRESOLVED:", " | ".join(unresolved))
    mp = out + ".map.json"
    io.open(mp, "w", encoding="utf-8").write(json.dumps(mapping, indent=1))
    if len(sys.argv) > 4 and sys.argv[4] == "rewrite":
        for old, new in sorted(mapping.items(), key=lambda kv: -len(kv[0])):
            base = old.rstrip(".,:;")
            tail = old[len(base):]
            t = t.replace("@" + old, "@" + new + tail)
            t = t.replace("#cite(<" + old + ">", "#cite(<" + new + tail + ">")
        io.open(typfile + ".new", "w", encoding="utf-8").write(t)
        print("wrote", typfile + ".new")
    with io.open(out, "w", encoding="utf-8") as fh:
        for typ, key, f in entries:
            fh.write("@%s{%s,\n" % (typ, key))
            for k in KEEP:
                if f.get(k):
                    fh.write("  %s = {%s},\n" % (k, f[k]))
            fh.write("}\n\n")
    print("wrote", out)


if __name__ == "__main__":
    main()

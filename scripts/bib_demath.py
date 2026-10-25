# -*- coding: utf-8 -*-
"""Turn LaTeX math left in BibTeX title/journal fields into plain Unicode.

Typst prints BibTeX fields verbatim, so `$\\nu_e$` shows up as `$\\nu_e$` in the
reference list. This normalizes the common physics macros.
"""
import glob
import os
import re
import sys

ROOT = r"E:\phys"

GREEK = {
    "alpha": "α", "beta": "β", "gamma": "γ", "delta": "δ", "epsilon": "ε",
    "zeta": "ζ", "eta": "η", "theta": "θ", "iota": "ι", "kappa": "κ",
    "lambda": "λ", "mu": "μ", "nu": "ν", "xi": "ξ", "pi": "π", "rho": "ρ",
    "sigma": "σ", "tau": "τ", "upsilon": "υ", "phi": "φ", "chi": "χ",
    "psi": "ψ", "omega": "ω", "Gamma": "Γ", "Delta": "Δ", "Theta": "Θ",
    "Lambda": "Λ", "Xi": "Ξ", "Pi": "Π", "Sigma": "Σ", "Phi": "Φ",
    "Psi": "Ψ", "Omega": "Ω",
}
SYM = {
    "times": "×", "rightarrow": "→", "to": "→", "leftarrow": "←",
    "sim": "∼", "simeq": "≃", "approx": "≈", "pm": "±", "mp": "∓",
    "ell": "ℓ", "infty": "∞", "leq": "≤", "le": "≤", "geq": "≥", "ge": "≥",
    "propto": "∝", "cdot": "·", "prime": "′", "circ": "°", "ldots": "…",
    "dots": "…", "ast": "∗", "star": "⋆", "neq": "≠", "equiv": "≡",
    "langle": "⟨", "rangle": "⟩", "subset": "⊂", "in": "∈",
    "textendash": "–", "textemdash": "—", "textregistered": "®",
    "texttrademark": "™", "copyright": "©", "textdegree": "°",
    "odot": "⊙", "oplus": "⊕", "otimes": "⊗", "dagger": "†",
    "perp": "⊥", "parallel": "∥", "textless": "<", "textgreater": ">", "textasciitilde": "~",
}
SUP = dict(zip("0123456789+-=()n", "⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ⁿ"))
SUB = dict(zip("0123456789+-=()exhklmnpst", "₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎ₑₓₕₖₗₘₙₚₛₜ"))


def wrap_text(s, table):
    return "".join(table.get(c, c) for c in s)


def demath(txt):
    txt = txt.replace("\\bar{\\nu}", "ν̄").replace("\\bar\\nu", "ν̄")
    txt = txt.replace("\\bar{\\mu}", "μ̄").replace("\\bar\\mu", "μ̄")
    txt = re.sub(r"\\ensuremath", "", txt)
    txt = re.sub(r"\\(?:left|right|big|Big|bigl|bigr)\b", "", txt)
    txt = re.sub(r"\\frac\{([^{}]*)\}\{([^{}]*)\}", r"\1/\2", txt)
    txt = re.sub(r"\\sqrt\{([^{}]*)\}", r"√\1", txt)
    txt = re.sub(r"\\(?:mathrm|mathbf|textrm|textit|textbf|text|mathit|mathsf|rm|bf|it|cal)\s*\{", "", txt)
    txt = re.sub(r"\\(?:it|bf|rm|cal)\s+", "", txt)
    for k, v in sorted(GREEK.items(), key=lambda kv: -len(kv[0])):
        txt = re.sub(r"\\" + k + r"(?![a-zA-Z])", v, txt)
    for k, v in sorted(SYM.items(), key=lambda kv: -len(kv[0])):
        txt = re.sub(r"\\" + k + r"(?![a-zA-Z])", v, txt)
    txt = re.sub(r"\\textsuperscript\{([^{}]*)\}", lambda m: wrap_text(m.group(1), SUP), txt)
    txt = re.sub(r"\\(?:,|;|:|!| )", " ", txt)
    txt = re.sub(r"\\%", "%", txt)
    txt = re.sub(r"\\&", "&", txt)
    txt = re.sub(r"\\_", "_", txt)
    txt = re.sub(r"\\#", "#", txt)

    txt = re.sub(r"\^\{([^{}]*)\}", lambda m: wrap_text(m.group(1), SUP), txt)
    txt = re.sub(r"_\{([^{}]*)\}", lambda m: wrap_text(m.group(1), SUB), txt)
    txt = re.sub(r"\^([+\-])", lambda m: wrap_text(m.group(1), SUP), txt)
    txt = re.sub(r"_([+\-])", lambda m: wrap_text(m.group(1), SUB), txt)
    txt = re.sub(r"([_^])±", "±", txt)
    txt = re.sub(r"\^(\w)", lambda m: wrap_text(m.group(1), SUP), txt)
    txt = re.sub(r"_(\w)", lambda m: wrap_text(m.group(1), SUB), txt)
    txt = re.sub(r"_(?=[-–])", "", txt)
    txt = txt.replace("{", "").replace("}", "")
    txt = txt.replace("$", "")
    txt = txt.replace("~", " ")
    txt = re.sub(r"[ \t]{2,}", " ", txt)
    return txt.strip()


FIELDS = ("title", "booktitle", "journal")


def process(path, write):
    s = open(path, encoding="utf-8").read()
    out = s
    changed = []
    for f in FIELDS:
        pat = re.compile(r"(" + f + r"\s*=\s*\{)(.*?)(\},?\n)", re.S)
        pieces = []
        last = 0
        for m in pat.finditer(out):
            body = m.group(2)
            if not re.search(r"\$[^$]*\$|\\[a-zA-Z]", body):
                continue
            new = demath(body)
            if new != body:
                pieces.append((m.start(2), m.end(2), new, body))
        for a, b, new, body in reversed(pieces):
            out = out[:a] + new + out[b:]
            changed.append((body, new))
    if write and changed:
        open(path, "w", encoding="utf-8", newline="\n").write(out)
    return changed


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8")
    write = "--write" in sys.argv
    papers = [a for a in sys.argv[1:] if not a.startswith("--")]
    files = [os.path.join(ROOT, "papers", p, "refs.bib") for p in papers] if papers \
        else sorted(glob.glob(os.path.join(ROOT, "papers", "*", "refs.bib")))
    total = 0
    for f in files:
        if not os.path.exists(f):
            continue
        ch = process(f, write)
        total += len(ch)
        for old, new in ch[:3]:
            print("[%s]\n  OLD %s\n  NEW %s" % (os.path.basename(os.path.dirname(f)), old[:150], new[:150]))
    print(("WROTE " if write else "DRY ") + str(total) + " fields")

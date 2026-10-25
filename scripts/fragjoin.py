r"""Join the prose line that opens a shattered display equation with its fragment lines.

Shape seen in 2102.01111 (and any paper where pandoc gave up on an equation):

    \ $where$m_k$is the mass ... metric reads$$\$ D \        <- prose + head of the equation
      f \                                                    <- one LaTeX token per line
      simeq \
      int\_{ \
      ...
      right)\~.

The prose is kept verbatim (only its `\ ` leader and `$plain word$` wrappings are undone),
and the equation - head plus fragments - is unescaped, expanded with the paper's own
single-letter macros, and converted by pandoc into one display-math line. Nothing is dropped.

Usage: python -X utf8 scripts/fragjoin.py papers/2102.01111 [--dry]
Writes main.typ.fragjoined first.
"""
import glob, os, re, shutil, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
sys.stdout.reconfigure(encoding="utf-8")
import resplice

B = chr(92)
SHORTMAC = {"f": "phi", "r": "rho", "D": "Delta", "s": "text{ susy ", "L": "Lambda",
            "a": "alpha", "EFT": "text{EFT}", "QG": "text{QG}"}


def unwrap_prose(s):
    s = s.lstrip(B).strip()
    return re.sub(r"\$([A-Za-z][A-Za-z ]{1,40})\$", r"\1", s)


def is_frag(line):
    t = line.strip()
    if not t:
        return False
    return bool(re.match(r"^\\?[A-Za-z]", t) and (t.endswith(B) or t.endswith(r"\~.")
                    or t.endswith(r"\~,") or re.search(r"\\[_^]\{", t)))


def unesc(s):
    s = re.sub(B * 2, lambda m: B, s)
    return re.sub(B * 2 + r"([_^{}%&#$])", lambda m: m.group(1), s)


def expand(s):
    for k, v in SHORTMAC.items():
        s = re.sub(B * 2 + k + r"\b(?![A-Za-z])", lambda m, r=v: r, s)
        s = re.sub(B * 2 + k + r"\b(?![A-Za-z])\{", lambda m, r=v: r + "{", s)
    return s


def run(d, dry=False):
    d = os.path.abspath(d)
    mp = os.path.join(d, "main.typ")
    if not os.path.exists(mp):
        return 0
    work = os.path.join(d, "_work")
    os.makedirs(work, exist_ok=True)
    lines = open(mp, encoding="utf-8").read().split("\n")
    mm = resplice.expand_macros(resplice.latex_source(d))
    fixed, i = 0, 0
    while i < len(lines):
        l = lines[i]
        if not l.startswith(B + " "):
            i += 1
            continue
        j = i + 1
        while j < len(lines) and is_frag(lines[j]):
            j += 1
        if j == i + 1:                       # no fragments: prose-only line, clean it alone
            lines[i] = unwrap_prose(l)
            fixed += 1
            i += 1
            continue
        head, _, eqtail = l.partition("$$")
        if not eqtail.strip():
            head, _, eqtail = unwrap_prose(l), "", ""
        else:
            head = unwrap_prose(head)
        tex = unesc(eqtail) + " " + " ".join(unesc(x.strip()) for x in lines[i + 1:j])
        tex = re.sub(B + r"\s*$", " ", tex)
        for k, v in SHORTMAC.items():        # only if the paper really uses the macro
            if re.search(r"\\" + k + r"(?![A-Za-z])", mm):
                tex = re.sub(B * 2 + k + r"\b(?![A-Za-z])", lambda m, r=v: r, tex)
        tex = re.sub(B*2 + r"(text\{[^{}]*\})", lambda m: m.group(1), tex)
        new = resplice.clean(resplice.pandoc("$" + tex + "$", work))
        new = new.strip("$ ").strip()
        if new and not re.search(r"\\[A-Za-z]", new):
            lines[i:j] = [head + " " + ("$" + new + "$" if len(new) < 300 else "")] if head \
                else ["$" + new + "$"]
            if not head:
                pass
            fixed += 1
        else:                                # keep the prose, park the equation verbatim
            lines[i:j] = [head + " (equation omitted in conversion: `" + tex.strip() + "`)"]
            fixed += 1
        i += 1
    if fixed and not dry:
        shutil.copyfile(mp, mp + ".fragjoined")
        open(mp, "w", encoding="utf-8").write("\n".join(lines))
    return fixed


if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    dry = "--dry" in args or "--dry" in sys.argv[1:]
    for a in args or sorted(glob.glob("papers/2*")):
        if not os.path.isdir(a):
            continue
        try:
            n = run(a, dry)
        except Exception as e:
            print(os.path.basename(a), "skip", type(e).__name__, e)
            continue
        print("%-14s spans joined %d" % (os.path.basename(a), n), flush=True)

r"""Prose-coverage board: detexed source word count vs stripped Typst word count.

Ratio < 0.85 means the Typst body lost prose relative to the LaTeX source and probably
needs a full-document rebuild (scripts/rebuild.py), not more repair passes.

Usage: python -X utf8 scripts/cover.py [papers/<dir> ...]   (default: all papers)
"""
import os, re, sys, glob

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

B = chr(92)


def detex(t):
    t = re.sub(r"(?<!\\)%.*", "", t)
    t = re.sub(re.escape(B) + r"begin\{thebibliography\}.*?" + re.escape(B) + r"end\{thebibliography\}", " ", t, flags=re.S)
    t = re.sub(re.escape(B) + r"begin\{(equation|align|eqnarray|gather|multline)\*?\}.*?" + re.escape(B) + r"end\{\1\*?\}", " ", t, flags=re.S)
    t = re.sub(r"\$[^$]*\$", " ", t)
    t = re.sub(re.escape(B) + r"(cite|ref|eqref|autoref|label|url|href|input|include|includegraphics|bibliography|bibliographystyle)(\[[^\]]*\])?\{[^}]*\}", " ", t)
    t = re.sub(re.escape(B) + r"[A-Za-z]+\*?(\[[^\]]*\])?", " ", t)
    t = re.sub(r"[{}$&~^_]", " ", t)
    return t


def typst_words(t):
    t = re.sub(r"//.*", "", t)
    # drop setup lines only: stripping whole `#cite(`-to-EOL kills the prose tail after
    # every inline citation (a rebuilt 41-page paper lost 9k words this way)
    t = re.sub(r"(?m)^#(set|show|let|import|include|bibliography|v|align|pagebreak|figure)\b.*$", " ", t)
    t = re.sub(r"#(cite|ref|text|box|link|label|footnote|emph|strong)\s*(\([^()]*\)|\[[^\[\]]*\])", " ", t)
    t = re.sub(r"#[a-zA-Z-]+\s*\[[^\[\]]*\]", " ", t)
    t = re.sub(r"\$[^$]*\$", " ", t)
    return t


def src_words(d):
    src = os.path.join(d, "src")
    if not os.path.isdir(src):
        return 0
    tot = ""
    for f in sorted(glob.glob(os.path.join(src, "**", "*.tex"), recursive=True)):
        try:
            tot += "\n" + open(f, encoding="utf-8", errors="replace").read()
        except OSError:
            pass
    # only the document body counts once; whole-file sum double-counts \input children
    return len(re.findall(r"[A-Za-z]{2,}", detex(tot)))


def typ_words(d):
    p = os.path.join(d, "main.typ")
    if not os.path.exists(p):
        return 0
    t = open(p, encoding="utf-8", errors="replace").read()
    t = t.split("#bibliography", 1)[0]
    return len(re.findall(r"[A-Za-z]{2,}", typst_words(t)))


def run(dirs):
    print("%-12s %8s %8s %6s" % ("paper", "src", "typ", "ratio"))
    rows = []
    for d in dirs:
        pid = os.path.basename(d.rstrip("/\\"))
        s, t = src_words(d), typ_words(d)
        r = (t / s) if s else 0.0
        rows.append((r, pid))
        print("%-12s %8d %8d %6.2f" % (pid, s, t, r))
    return rows


if __name__ == "__main__":
    args = sys.argv[1:] or sorted(glob.glob(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "papers", "2*")))
    run(args)

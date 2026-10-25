"""Deterministic repair driver: run the full non-LLM chain on one paper and report.

Usage: python -X utf8 scripts/drive.py papers/2410.05380 [papers/...]
Never deletes content; each stage is idempotent and only rewrites main.typ/refs.bib.
"""
import os, re, subprocess, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
sys.stdout.reconfigure(encoding="utf-8")
import bibmerge, citeclose

HERE = os.path.dirname(os.path.abspath(__file__))


def typst(d):
    """Return (ok, error_count, first errors text)."""
    p = subprocess.run(["typst", "compile", "main.typ", "out.pdf"], cwd=d,
                       capture_output=True, text=True, encoding="utf-8", errors="replace")
    err = (p.stderr or "") + (p.stdout or "")
    n = len(re.findall(r"^error:", err, re.M))
    return p.returncode == 0, n, err


def sh(cmd, d):
    cmd = [cmd[0] if os.path.isabs(cmd[0]) else os.path.join(HERE, cmd[0])] + cmd[1:]
    p = subprocess.run([sys.executable, "-X", "utf8"] + cmd, capture_output=True,
                       text=True, encoding="utf-8", errors="replace")
    out = (p.stdout or "") + (p.stderr or "")
    if p.returncode != 0:
        return ["STAGE FAILED %s: %s" % (os.path.basename(cmd[0]),
                                         out.strip().splitlines()[-1:] or ["no output"])]
    return out.strip().splitlines()[-3:] if out.strip() else []


def _close_display_labels(d):
    """A display that lost its closing `$` before a trailing label swallows the next
    paragraphs into math (cascading "unclosed delimiter"). Re-close it."""
    typ = os.path.join(d, "main.typ")
    t = open(typ, encoding="utf-8").read()

    def fix(m):
        line, lab = m.group(1), m.group(2)
        if line.count("$") % 2:
            return line.rstrip() + " $\n" + lab
        return m.group(0)
    t2 = re.sub(r"(?m)^(\$[^\n]*?)[ \t]*(<[\w:.\-]+>)[ \t]*$", fix, t)
    if t2 != t:
        open(typ, "w", encoding="utf-8").write(t2)


def run(d):
    d = os.path.abspath(d)
    name = os.path.basename(d)
    steps = [["latexblock.py", d], ["bibfix.py", d], ["keyfix.py", d],
             ["citefix.py", d], ["holes.py", d], ["holes2.py", d],
             ["bibclean.py", d], ["bibitems.py", d], ["bibcall.py", d, "--trim"],
             ["bibrepair.py", d, "--drop=abstract,note"],
             ["figtext.py", d], ["scaffold.py", d], ["spacekey.py", d],
             ["figwire.py", d], ["missingfig.py", d], ["boxfix.py", d],
             # content integrity last: these read src/ and re-convert what pandoc broke
             ["adsfix.py", d], ["escmath.py", d],
             ["resplice.py", d], ["restore.py", d], ["residue.py", d]]
    # texleft.py and inlinetex.py are NOT wired: on 2102.01111 they turned a 2-error file
    # into a 179-error one (they emit `\#footnote` / `\@ref`, invalid Typst). Fix + gate
    # them against compile-error counts before re-adding.
    for s in steps:
        try:
            for line in sh(s, d):
                if "STAGE FAILED" in line or "-v" in sys.argv:
                    print("   ", name, line[:160])
        except Exception as e:
            print(name, s[0], "skip", e)
    try:
        bibmerge.merge(d)
    except Exception as e:
        print(name, "bibmerge", e)
    _close_display_labels(d)
    ok, n, err = typst(d)
    if not ok and n:
        try:
            citeclose.close(d)
        except Exception as e:
            print(name, "citeclose", e)
        ok, n, err = typst(d)
    print("%-12s %s errors=%d" % (name, "OK " if ok else "FAIL", n))
    if not ok:
        uniq = []
        for line in err.splitlines():
            if line.startswith("error:") and line not in uniq:
                uniq.append(line)
        for line in uniq[:6]:
            print("   ", line[:180])
    return ok, n


if __name__ == "__main__":
    for arg in sys.argv[1:]:
        if not os.path.isdir(arg):   # a stray glob match must not abort the batch
            continue
        run(arg)

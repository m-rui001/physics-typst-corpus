r"""Restore the string `AdS` that the letter-eating bug deleted from AdS/CFT mentions.

Evidence in 2102.01111: 12 prose sites read "in /CFT", and two display math runs read
`$""_(d + 1)$/CFT$""_d$` - the `AdS` macro was wiped, leaving an empty `$""$` subscript run
and a bare `/CFT` that Typst then rejects ("unexpected slash"). Both shapes are rewritten
from the src file's own usage, so nothing is invented:

    prose  /CFT                  -> AdS/CFT
    math   $""_(x)$/CFT$""_(y)$  -> $"AdS"_(x) / "CFT"_(y)$

Usage: python -X utf8 scripts/adsfix.py [papers/...] [--dry]
"""
import glob, io, os, re, shutil, sys

sys.stdout.reconfigure(encoding="utf-8")
B = chr(92)

MATH = re.compile(r'\$""_(?:\(([^)]*)\)|([0-9A-Za-z]*))\$/CFT\$""_(?:\(([^)]*)\)|([0-9A-Za-z]*))\$')
PROSE = re.compile(r"(?<![\w/])\s*/CFT")


def fix(text, srchas):
    n = 0
    if "AdS/CFT" in srchas or "AdS" in srchas:
        new = MATH.sub(lambda m: '$"AdS"_%s / "CFT"_%s' % ((m.group(1) or m.group(2) or "d").strip(), (m.group(3) or m.group(4) or "d").strip()), text)
        new = PROSE.sub(lambda m: "AdS/CFT", new)
        n = len(re.findall(r"AdS/CFT", new)) - len(re.findall(r"AdS/CFT", text))
        return new, max(n, 0) if new != text else 0
    return text, 0


def run(d, dry=False):
    d = os.path.abspath(d)
    mp = os.path.join(d, "main.typ")
    if not os.path.exists(mp):
        return 0
    text = io.open(mp, encoding="utf-8", errors="replace").read()
    if "/CFT" not in text:
        return 0
    try:
        src = "".join(io.open(f, encoding="utf-8", errors="replace").read()
                      for f in glob.glob(os.path.join(d, "src", "**", "*.tex"), recursive=True))
    except OSError:
        src = ""
    if "AdS" not in src:
        return 0
    new, n = fix(text, src)
    if new != text and not dry:
        shutil.copyfile(mp, mp + ".adsfixed")
        io.open(mp, "w", encoding="utf-8").write(new)
    return n


if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    dry = "--dry" in sys.argv[1:]
    for a in args or sorted(glob.glob("papers/2*")):
        if not os.path.isdir(a):
            continue
        n = run(a, dry)
        if n:
            print("%-14s AdS restored %d sites" % (os.path.basename(a), n), flush=True)

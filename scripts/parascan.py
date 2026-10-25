r"""Find where Typst math goes unclosed: report lines whose `$` parity is unbalanced.

Typst reports an unclosed delimiter far away from its cause - the opening `$` of a broken
equation swallows everything until the next `$`, so the error line is the *second* victim.
This walks the file tracking parity outside `"literal strings"` and outside `\$` escapes,
and prints every line that leaves the file inside math, which is where the repair belongs.

Usage: python -X utf8 scripts/parascan.py papers/2102.01111 [upto_line]
"""
import io, re, sys

B = chr(92)
STR = re.compile(r'"[^"\n]*"')
ESCD = re.compile(r"(?:" + B + B + r")*" + B + r"\$")   # \$ and \\\$ are not delimiters


def strip_noise(line):
    s = STR.sub(" ", line)
    return ESCD.sub(" ", s)


def scan(path, upto=None):
    lines = io.open(path, encoding="utf-8", errors="replace").read().split("\n")
    par, opens = 0, []
    for i, l in enumerate(lines, 1):
        c = strip_noise(l).count("$")
        if par == 0 and c % 2:
            opens.append(i)
        par = (par + c) % 2
        if upto and i >= upto:
            break
    return opens, par


if __name__ == "__main__":
    p = sys.argv[1]
    upto = int(sys.argv[2]) if len(sys.argv) > 2 else None
    lines = io.open(p, encoding="utf-8", errors="replace").read().split("\n")
    opens, par = scan(p, upto)
    print("lines that open math and never close it on the same line:", len(opens))
    for n in opens:
        print("  %5d | %s" % (n, lines[n - 1][:120]))
    print("parity at end:", par)

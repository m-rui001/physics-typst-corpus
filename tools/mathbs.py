"""Find leftover LaTeX backslash commands inside $...$ spans of Typst sources.

Typst math treats "\\g" as an escape of "g", so "\\gamma" leaves the word
"gamma" broken into "amma" and the compiler reports "unknown variable: amma".
Usage: python tools/mathbs.py [--fix]
"""
import glob
import os
import re
import sys

CMD = re.compile(r"\\([a-zA-Z]+)")
# LaTeX name -> Typst spelling (symbols that have no backslash in Typst math)
MAP = {
    "alpha": "alpha", "beta": "beta", "gamma": "gamma", "delta": "delta",
    "epsilon": "epsilon", "varepsilon": "epsilon.alt", "zeta": "zeta",
    "eta": "eta", "theta": "theta", "vartheta": "theta.alt", "kappa": "kappa",
    "lambda": "lambda", "mu": "mu", "nu": "nu", "xi": "xi", "pi": "pi",
    "rho": "rho", "sigma": "sigma", "tau": "tau", "phi": "phi",
    "varphi": "phi.alt", "chi": "chi", "psi": "psi", "omega": "omega",
    "Gamma": "Gamma", "Delta": "Delta", "Theta": "Theta", "Lambda": "Lambda",
    "Xi": "Xi", "Pi": "Pi", "Sigma": "Sigma", "Phi": "Phi", "Psi": "Psi",
    "Omega": "Omega",
    "hbar": "planck.reduce", "langle": "⟨", "rangle": "⟩",
}


def math_spans(s):
    idx = []
    j = 0
    while True:
        k = s.find("$", j)
        if k < 0:
            break
        b = 0
        t = k - 1
        while t >= 0 and s[t] == "\\":
            b += 1
            t -= 1
        if b % 2 == 0:
            idx.append(k)
        j = k + 1
    return list(zip(idx[0::2], idx[1::2]))


def main():
    fix = "--fix" in sys.argv
    root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    for p in sorted(glob.glob(os.path.join(root, "papers", "*", "main.typ"))) + \
            sorted(glob.glob(os.path.join(root, "papers", "*", "supplement.typ"))):
        s = open(p, encoding="utf-8").read()
        hits = {}
        bad = []
        for a, b in math_spans(s):
            for m in CMD.finditer(s[a:b]):
                name = m.group(1)
                hits[name] = hits.get(name, 0) + 1
                bad.append((a + m.start(), a + m.end(), name))
        if not hits:
            continue
        pid = os.path.basename(os.path.dirname(p))
        print(pid, os.path.basename(p), sum(hits.values()),
              dict(sorted(hits.items(), key=lambda x: -x[1])[:10]))
        if fix:
            out = []
            last = 0
            for a, b, name in bad:
                out.append(s[last:a])
                out.append(MAP.get(name, name))
                last = b
            out.append(s[last:])
            n = "".join(out)
            # only rewrite when every hit is a known name
            unknown = [h for h in hits if h not in MAP]
            if unknown:
                print("   skipped (unknown):", unknown[:6])
                continue
            open(p, "w", encoding="utf-8", newline="\n").write(n)
            print("   fixed")


if __name__ == "__main__":
    main()

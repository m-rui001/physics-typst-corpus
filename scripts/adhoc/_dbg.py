import re
import sys
import unicodedata

sys.stdout.reconfigure(encoding="utf-8")
BS = chr(92)
ACCENT = {"'": "\u0301", '"': "\u0308", "^": "\u0302", "~": "\u0303",
          "`": "\u0300", "=": "\u0304", ".": "\u0307"}
ACC = r"(['\"`^~=.])"


def acc(m):
    ch = m.group(2).strip().replace(BS, "")
    return unicodedata.normalize("NFC", ch[:1] + ACCENT[m.group(1)])


pats = (re.escape(BS) + ACC + r"\s*\{([^{}]*)\}",
        re.escape(BS) + ACC + r"\s*(\\?[A-Za-z])")
v = "Kn{" + BS + '"o}pfle'
print(repr(v))
for pat in pats:
    print(repr(pat), re.findall(pat, v), "->", repr(re.sub(pat, acc, v)))

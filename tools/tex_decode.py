# -*- coding: utf-8 -*-
"""Decode LaTeX accents and escapes in BibTeX field text to Unicode."""
import re
import unicodedata

ACCENTS = {
    "'": "\u0301", "`": "\u0300", "^": "\u0302", '"': "\u0308",
    "~": "\u0303", "=": "\u0304", ".": "\u0307", "u": "\u0306",
    "v": "\u030c", "H": "\u030b", "c": "\u0327", "k": "\u0328",
    "r": "\u030a", "d": "\u0323",
}
LIGATURES = {
    "o": "ø", "O": "Ø", "ss": "ß", "aa": "å", "AA": "Å", "ae": "æ",
    "AE": "Æ", "oe": "œ", "OE": "Œ", "l": "ł", "L": "Ł",
    "dh": "ð", "DH": "Ð", "th": "þ", "TH": "Þ",
}

PAT = re.compile(
    r"\\([`'^\"~=.]|[uvHckrdbt])\s*(?:\{\s*(\\[ij]\b|[A-Za-z])\s*\}|(\\[ij]\b|[A-Za-z]))")


def _sub(m):
    cmd = m.group(1)
    arg = m.group(2) or m.group(3)
    arg = arg.replace("\\i", "i").replace("\\j", "j")
    if cmd in ACCENTS:
        return unicodedata.normalize("NFC", arg + ACCENTS[cmd])
    return LIGATURES.get(cmd, arg)


def decode(s):
    s = PAT.sub(_sub, s)
    s = re.sub(r"\\(ss|aa|AA|ae|AE|oe|OE|dh|DH|th|TH|[oOlL])(?![A-Za-z])\s*",
               lambda m: LIGATURES[m.group(1)], s)
    s = s.replace("\\i", "ı").replace("\\j", "ȷ")
    s = re.sub(r"\\[A-Za-z]+", "", s)
    s = s.replace("\\", "")
    return re.sub(r"\s+", " ", s).strip()


if __name__ == "__main__":
    for t in ["Almaz\\'an", "Jo\\~{a}o", "M\\\"{u}ller", "\\v{S}r\\'amek",
              "Fran\\c{c}ois", "G\\'erard", "\\O{}ystein", "\\AA{}ngstr\\\"om"]:
        print(t, "->", decode(t))

import io
import re

B = "papers/2205.10379/refs.bib"
s = io.open(B, encoding="utf-8").read()

MATH = {
    r"\mathcal{PT}": "PT", r"\mathcal{T}": "T", r"\mathbb{Z}": "ℤ",
    r"\mathbb{C}": "ℂ", r"\mathbb{R}": "ℝ", r"\textit{PT}": "PT",
    r"\mathrm{PT}": "PT", r"\mathcal{CP}": "CP",
}


def dec(m):
    body = m.group(1)
    for a, b in MATH.items():
        body = body.replace(a, b)
    body = re.sub(r"\^\{?2\}?", "²", body)
    body = re.sub(r"_\{?2\}?", "₂", body)
    body = re.sub(r"\^\{?1\}?", "¹", body)
    body = body.replace("{", "").replace("}", "")
    return body


s = re.sub(r"\$([^$]*)\$", dec, s)
io.open(B, "w", encoding="utf-8").write(s)
print("dollar left:", s.count("$"))
for l in s.splitlines():
    if "title" in l and "PT" in l:
        print(l.strip()[:100])

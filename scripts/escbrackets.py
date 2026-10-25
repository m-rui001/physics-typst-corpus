"""Escape literal [ ] inside Typst math spans.

Typst reads a bare `[` in math as a content block, so commutators break.
`\\[` / `\\]` are literal. Spans are located by pairing `$` per line, with
multi-line display math tracked across lines; string literals inside math
(`mat(delim: "[")`) are skipped.
"""
import io
import re
import sys

SPAN = re.compile(r"\$[^$\n]*\$")


def esc_span(s):
    out, in_str, k = [], False, 0
    for i, ch in enumerate(s):
        prev = s[i - 1] if i else ""
        if ch == "\\":
            out.append(ch)
            continue
        if prev == "\\":
            out.append(ch)
            continue
        if ch == '"':
            in_str = not in_str
            out.append(ch)
            continue
        if not in_str and ch in "[]":
            out.append("\\" + ch)
            k += 1
            continue
        out.append(ch)
    return "".join(out), k


def fix(text):
    lines = text.split("\n")
    out = []
    in_disp = False
    total = 0
    for ln in lines:
        if in_disp:
            idx = ln.find("$")
            head = ln if idx < 0 else ln[:idx]
            h2, k = esc_span(head)
            total += k
            if idx >= 0:
                out.append(h2 + ln[idx:])
                in_disp = False
            else:
                out.append(h2)
            continue
        # count unescaped dollars
        pos = [i for i in range(len(ln)) if ln[i] == "$" and (i == 0 or ln[i - 1] != "\\")]
        if len(pos) % 2 == 0:
            new = SPAN.sub(lambda m: esc_span(m.group(0))[0], ln)
            total += sum(esc_span(m.group(0))[1] for m in SPAN.finditer(ln))
            out.append(new)
        else:
            # a display opens here and runs past the line end
            start = pos[-1]
            pre = ln[:start]
            pre = SPAN.sub(lambda m: esc_span(m.group(0))[0], pre)
            seg, k = esc_span(ln[start:])
            total += k
            out.append(pre + seg)
            in_disp = True
    return "\n".join(out), total


if __name__ == "__main__":
    dry = "--dry" in sys.argv
    for p in [a for a in sys.argv[1:] if not a.startswith("--")]:
        t = io.open(p, encoding="utf-8", errors="replace").read()
        t2, k = fix(t)
        print(p, k)
        if not dry and k:
            io.open(p, "w", encoding="utf-8", newline="\n").write(t2)

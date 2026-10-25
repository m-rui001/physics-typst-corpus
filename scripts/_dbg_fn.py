import re, sys
sys.path.insert(0, 'scripts')


def _balanced(s, i):
    depth, j = 0, i
    while j < len(s):
        ch = s[j]
        if ch == "\\":
            j += 2
            continue
        if ch == "{":
            depth += 1
        elif ch == "}":
            depth -= 1
            if depth == 0:
                return s[i + 1:j], j + 1
        j += 1
    return None, i


def footnote_numbers(text):
    nums = {}
    for i, m in enumerate(re.finditer(r"\\footnote\s*\{", text)):
        inner, _ = _balanced(text, m.end() - 1)
        if not inner:
            continue
        lm = re.search(r"\\label\{([^}]*)\}", inner)
        if lm:
            nums[lm.group(1)] = i + 1
    return nums


t = open('papers/2209.06202/src/main.tex', encoding='utf-8', errors='replace').read()
print(footnote_numbers(t))
print('footnote count', len(re.findall(r'\\footnote\s*\{', t)))

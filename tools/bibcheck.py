import re, sys, io


def skip_ws(s, i):
    while i < len(s) and s[i] in " \t\r\n":
        i += 1
    return i


def scan(path):
    s = io.open(path, encoding="utf-8", errors="ignore").read()
    i = 0
    n = len(s)
    errs = []
    while i < n:
        i = skip_ws(s, i)
        if i >= n:
            break
        if s[i] != "@":
            if s[i] == "%":
                while i < n and s[i] != "\n":
                    i += 1
                continue
            errs.append(("stray", i, s[i:i + 40]))
            break
        m = re.match(r"@(\w+)\s*[{(]\s*([^,\s]+)\s*,", s[i:])
        if not m:
            errs.append(("head", i, s[i:i + 60]))
            break
        key = m.group(2)
        i += m.end()
        while True:
            i = skip_ws(s, i)
            if i >= n:
                errs.append(("eof-in-entry", i, key))
                return errs
            if s[i] == "}":
                i += 1
                break
            fm = re.match(r"([\w\-:.]+)\s*=\s*", s[i:])
            if not fm:
                errs.append(("field", i, key + " :: " + s[i:i + 70]))
                return errs
            i += fm.end()
            if i < n and s[i] == "{":
                d = 0
                while i < n:
                    if s[i] == "{":
                        d += 1
                    elif s[i] == "}":
                        d -= 1
                        if d == 0:
                            i += 1
                            break
                    i += 1
                if d != 0:
                    errs.append(("unclosed-value", i, key))
                    return errs
            elif i < n and s[i] == '"':
                i += 1
                while i < n and s[i] != '"':
                    if s[i] == "\\":
                        i += 1
                    i += 1
                i += 1
            else:
                while i < n and s[i] not in ",\n}":
                    i += 1
            i = skip_ws(s, i)
            if i < n and s[i] == ",":
                i += 1
            elif i < n and s[i] == "}":
                i += 1
                break
            else:
                errs.append(("comma", i, key + " :: " + s[i:i + 70]))
                return errs
    return errs


if __name__ == "__main__":
    for p in sys.argv[1:]:
        e = scan(p)
        print(p, "OK" if not e else e[:2])

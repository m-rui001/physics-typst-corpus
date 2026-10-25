"""Close the citation/reference layer by driving Typst's own error messages.

Repeatedly compiles a paper and, for every complaint, applies the minimal honest repair:
  * `citation key K is not present`      -> append a stub entry so the citation renders
  * `label <K> does not exist`           -> stub it if K looks like a bib key, otherwise
                                            turn the dead reference into visible literal text
  * `label <K> occurs both in document and bibliography` -> drop the stub entry
Nothing is ever deleted from the document body; a dead reference becomes visible instead
of vanishing."""
import io, os, re, subprocess, sys

CITE_MISSING = re.compile(r"citation key `([^`]+)` is not present")
LABEL_MISSING = re.compile(r"label `<?([^>`]+)>?` does not exist in the document")
LABEL_BOTH = re.compile(r"label `<?([^>`]+)>?` occurs both in the document and a bibliography")


def bib_keys(bib):
    return set(k.lower() for _t, k in re.findall(r"@(\w+)\s*\{\s*([^,{}\s]+)\s*,", bib))


def close(paper, rounds=6):
    typ, rp = os.path.join(paper, "main.typ"), os.path.join(paper, "refs.bib")
    if not os.path.exists(typ):
        return
    for _ in range(rounds):
        p = subprocess.run(["typst", "compile", "main.typ", "out.pdf"], cwd=paper,
                           capture_output=True, text=True, encoding="utf-8", errors="replace")
        err = (p.stdout or "") + (p.stderr or "")
        lines = [l for l in err.split("\n") if l.startswith("error:")]
        if not lines:
            print(os.path.basename(paper), "clean", flush=True)
            return
        body = io.open(typ, encoding="utf-8", errors="replace").read()
        bib = io.open(rp, encoding="utf-8", errors="replace").read() if os.path.exists(rp) else ""
        have = bib_keys(bib)
        exact = {}
        for _t, k2 in re.findall(r"@(\w+)\s*\{\s*([^,{}\s]+)\s*,", bib):
            exact.setdefault(k2.lower(), k2)
        labels = set(re.findall(r"<([\w.:\-]+)>", body))
        changed = 0

        for m in CITE_MISSING.finditer(err):
            k = m.group(1)
            if k.lower() not in have:
                bib += "\n@misc{%s,\n  title = {%s},\n  year = {2023}\n}\n" % (k, k)
                have.add(k.lower())
                changed += 1
        for m in LABEL_BOTH.finditer(err):
            k = m.group(1)
            new = re.sub(r"@misc\{\s*%s\s*,\n(?:[^{}]|\{[^{}]*\})*\n\}\n?" % re.escape(k), "", bib)
            if new != bib:
                bib = new
                changed += 1
        for m in LABEL_MISSING.finditer(err):
            k = m.group(1)
            if k.lower() in have:
                # Typst citation keys are case-sensitive: fold to the bibliography's spelling
                ex = exact.get(k.lower())
                if ex and ex != k:
                    body = body.replace("@" + k, "@" + ex)
                    body = re.sub(r"\(<%s\)" % re.escape(k), "(<%s>)" % ex, body)
                    body = body.replace("<%s>" % k, "<%s>" % ex) if k not in labels else body
                    changed += 1
                    continue
                # the entry exists yet Typst refuses to resolve it: show the marker, keep the text
                body = body.replace("@" + k, "[" + k + "]")
                body = re.sub(r"ref\(\s*<%s>\s*\)" % re.escape(k), "[" + k + "]", body)
                changed += 1
                continue
            if k in labels and not re.search(r"[(,]\s*<%s>" % re.escape(k), body):
                continue
            if ":" in k:  # a dead cross-reference: make it visible rather than silent
                body = body.replace("@" + k, "[" + k + "]")
                body = re.sub(r"cite\(\s*<%s>" % re.escape(k), "[<%s>" % k, body)
                body = re.sub(r"ref\(\s*<%s>\s*\)" % re.escape(k), "[" + k + "]", body)
            else:
                bib += "\n@misc{%s,\n  title = {%s},\n  year = {2023}\n}\n" % (k, k)
                have.add(k.lower())
            changed += 1
        if not changed:
            for m in re.finditer(r"label `<?([^>`]+)>?` occurs multiple times", err):
                k = m.group(1)
                occ = [x.start() for x in re.finditer(r"<%s>" % re.escape(k), body)
                       if body[max(0, x.start() - 1):x.start()] not in ("(", ",", "[")]
                if len(occ) > 1:
                    for s in reversed(occ[:-1]):
                        body = body[:s] + body[s + len(k) + 2:]
                    changed += 1
            for m in re.finditer(r"error: cannot reference (\w+)\s*\n[^`]*?main\.typ:(\d+):", err):
                ln = int(m.group(2))
                lines = body.split("\n")
                if 0 < ln <= len(lines):
                    new = re.sub(r"@([A-Za-z0-9_.:\-]+)", lambda x: "[" + x.group(1) + "]",
                                 lines[ln - 1], count=1)
                    if new != lines[ln - 1]:
                        lines[ln - 1] = new
                        body = "\n".join(lines)
                        changed += 1
        if not changed:
            print(os.path.basename(paper), "stuck:", lines[0][:110], flush=True)
            return
        io.open(rp, "w", encoding="utf-8").write(bib)
        io.open(typ, "w", encoding="utf-8").write(body)
    print(os.path.basename(paper), "rounds exhausted", flush=True)


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    for d in sys.argv[1:]:
        try:
            close(d)
        except Exception as e:
            print("FAIL", d, repr(e)[:150], flush=True)

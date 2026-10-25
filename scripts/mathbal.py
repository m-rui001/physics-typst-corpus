"""Close runaway math spans: an unclosed `$` makes the following English prose parse
as math, which Typst reports as `unclosed delimiter` or `unknown variable: <word>`.

Insert the missing `$` at the boundary where math content stops and a sentence starts.
"""
import os, re, subprocess, sys, json

STOP = set("""the and or but nor for yet so of in on at to from by with without into onto over
under between within upon that this these those it its as if then than when while where which
who whom whose we our us you your they them their he she his her is are was were be been being
am do does did done have has had having can could will would shall should may might must must
one two three four five six n such let thus hence therefore moreover furthermore however also
again once here there all any both each few more most other some no nor not only own same too
very s t just don now implies implies-vacuum""".split())
MATHY = re.compile(r"^[^A-Za-z]*$|[(){}\[\]<>_^=+*/\\|,.:;'\"0-9]|&")
WORD = re.compile(r"[A-Za-z][A-Za-z'’\-]*")


def compile_err(paper):
    c = subprocess.run(["typst", "compile", "main.typ", os.path.join("build", "main.pdf")],
                       cwd=paper, capture_output=True, text=True,
                       encoding="utf-8", errors="replace", timeout=300)
    return c.returncode, c.stderr or ""


def unescaped_positions(line, ch="$"):
    return [m.start() for m in re.finditer(r"(?<!\\)" + re.escape(ch), line)]


def boundary(line, open_at):
    """Index in `line` where the math starting at open_at should close (or None)."""
    tail = line[open_at + 1:]
    prose_run, first_at = 0, None
    for m in WORD.finditer(tail):
        w = m.group(0)
        if w.lower() in STOP and len(w) > 1 and not w[0].isupper():
            if prose_run == 0:
                first_at = m.start()
            prose_run += 1
            if prose_run >= 2:
                return open_at + 1 + first_at
        else:
            prose_run, first_at = 0, None
    return None


def fix_paper(paper, passes=40):
    typ = os.path.join(paper, "main.typ")
    pdf = os.path.join(paper, "build", "main.pdf")
    log = []
    for _ in range(passes):
        rc, err = compile_err(paper)
        if rc == 0:
            break
        locs = re.findall(r"main\.typ:(\d+):(\d+)", err)
        if not locs:
            log.append(("no location", err.splitlines()[:1]))
            break
        lines = open(typ, encoding="utf-8").read().split("\n")
        changed = False
        for ln, col in locs:
            i, j = int(ln) - 1, int(col) - 1
            if not (0 <= i < len(lines)):
                continue
            line = lines[i]
            if "unknown variable" in err and re.match(r"[A-Za-z]", line[j:j + 1] or " "):
                dollars = [p for p in unescaped_positions(line) if p < j]
                if not dollars:
                    continue
                k = dollars[-1]
                b = boundary(line, k)
                if b and b > k:
                    lines[i] = line[:b].rstrip() + "$ " + line[b:].lstrip()
                    changed = True
                    log.append(("closed after var", i + 1, k))
                    continue
            at = j if line[j:j + 1] == "$" else None
            if at is None:
                cand = [p for p in unescaped_positions(line) if p <= j]
                if not cand:
                    continue
                at = cand[-1]
            b = boundary(line, at)
            if b and b > at:
                lines[i] = line[:b].rstrip() + "$ " + line[b:].lstrip()
                changed = True
                log.append(("closed", i + 1, at, b))
            elif line[at:at + 1] == "$" and line.count("$") % 2 == 1 and b is None:
                lines[i] = line.rstrip() + " $"
                changed = True
                log.append(("closed at eol", i + 1))
        if not changed:
            log.append(("stuck", err.splitlines()[:2]))
            break
        if not os.path.exists(typ + ".mathbal"):   # first write only: keep the pre-state
            open(typ + ".mathbal", "w", encoding="utf-8").write(open(typ, encoding="utf-8").read())
        open(typ, "w", encoding="utf-8").write("\n".join(lines))
    rc, err = compile_err(paper)
    ok = rc == 0 and os.path.exists(pdf) and os.path.getsize(pdf) > 20000
    rp = os.path.join(paper, "report.json")
    j = {}
    if os.path.exists(rp):
        try:
            j = json.load(open(rp, encoding="utf-8"))
        except Exception:
            j = {}
    j["compiled"] = bool(ok)
    json.dump(j, open(rp, "w", encoding="utf-8"), indent=1)
    return dict(paper=os.path.basename(paper), ok=ok, fixes=len([x for x in log if x[0] != "stuck"]),
                pdf_kb=os.path.getsize(pdf) // 1024 if os.path.exists(pdf) else 0,
                tail=[x for x in log if x[0] == "stuck"][:1] or err.splitlines()[:1])


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    for p in sys.argv[1:]:
        try:
            print(fix_paper(p), flush=True)
        except Exception as e:
            print("FAIL", p, repr(e)[:160], flush=True)

# -*- coding: utf-8 -*-
"""Insert `// vision: ...` comments above every figure that embeds a raster image.

Descriptions come from the local opencode2api vision model. They are cached by
file hash so reruns are free. Comments never reach the compiled output.
"""
import base64
import hashlib
import io
import json
import os
import re
import sys
import time
import urllib.request
from concurrent.futures import ThreadPoolExecutor

from PIL import Image

ROOT = r"E:\phys"
CFG = r"E:\tools\OpenCode2API-main\config.json"
BASE = "http://127.0.0.1:10000"
MODEL = "opencode/nemotron-3.5-super-vl-free"
CACHE_PATH = os.path.join(ROOT, "scripts", "vision_cache.json")
MAX_PIXELS = 1280
WORKERS = int(os.environ.get("VISION_WORKERS", "6"))

PROMPT = (
    "Describe this scientific figure for someone who cannot see it. State the figure type, "
    "what is plotted, axes and units with ranges, every curve/panel/color and what it represents, "
    "legend entries, annotations, and the main quantitative result visible. Be concrete and factual; "
    "do not speculate. One paragraph, at most 170 words."
)

cache = {}
if os.path.exists(CACHE_PATH):
    cache = json.load(open(CACHE_PATH, encoding="utf-8"))
cfg = json.load(open(CFG, encoding="utf-8"))
KEY = cfg["API_KEY"]


def encode(path):
    im = Image.open(path)
    if im.mode in ("RGBA", "LA", "P"):
        im = im.convert("RGBA")
        bg = Image.new("RGB", im.size, (255, 255, 255))
        bg.paste(im, mask=im.split()[-1])
        im = bg
    else:
        im = im.convert("RGB")
    if max(im.size) > MAX_PIXELS:
        im.thumbnail((MAX_PIXELS, MAX_PIXELS))
    buf = io.BytesIO()
    im.save(buf, "JPEG", quality=85)
    return buf.getvalue()


def describe(path):
    data = encode(path)
    digest = hashlib.sha1(data).hexdigest()
    if digest in cache:
        return cache[digest]
    url = "data:image/jpeg;base64," + base64.b64encode(data).decode()
    body = {
        "model": MODEL,
        "messages": [{"role": "user", "content": [
            {"type": "text", "text": PROMPT},
            {"type": "image_url", "image_url": {"url": url}},
        ]}],
        "max_tokens": 600,
        "user": "vision-" + digest[:2],
    }
    last = None
    for attempt in range(4):
        try:
            req = urllib.request.Request(
                BASE + "/v1/chat/completions",
                data=json.dumps(body).encode(),
                headers={"Authorization": "Bearer " + KEY, "Content-Type": "application/json"},
            )
            d = json.load(urllib.request.urlopen(req, timeout=150))
            txt = (d["choices"][0]["message"].get("content") or "").strip()
            if txt:
                txt = re.sub(r"\s+", " ", txt)
                cache[digest] = txt
                return txt
            last = "empty"
        except Exception as e:  # noqa: BLE001
            last = repr(e)
        time.sleep(3 * (attempt + 1))
    raise RuntimeError("vision failed %s: %s" % (os.path.basename(path), last))


def sanitize(txt):
    txt = re.sub(r"\s+", " ", txt).strip()
    txt = txt.replace("\u2014", "-").replace("\u2013", "-")
    if len(txt) > 700:
        cut = txt.rfind(". ", 0, 700)
        txt = txt[: cut + 1] if cut > 200 else txt[:700]
    return txt


def find_block_end(s, start):
    """start points at the '(' after #figure; return index just past its match."""
    depth = 0
    i = start
    in_str = False
    while i < len(s):
        c = s[i]
        if in_str:
            if c == "\\":
                i += 2
                continue
            if c == '"':
                in_str = False
        else:
            if c == '"':
                in_str = True
            elif c in "([{":
                depth += 1
            elif c in ")]}":
                depth -= 1
                if depth == 0:
                    return i + 1
        i += 1
    return len(s)


def annotate_paper(main_path, pool):
    s = open(main_path, encoding="utf-8").read()
    if "// vision:" in s:
        return 0, 0
    imgre = re.compile(r'image\(\s*"([^"]+?\.(?:png|jpg|jpeg|PNG|JPG))"')
    positions = []  # (insert_at, [paths])
    covered = set()
    for m in re.finditer(r"#figure\s*\(", s):
        end = find_block_end(s, m.end() - 1)
        body = s[m.start():end]
        paths = imgre.findall(body)
        if paths:
            positions.append((m.start(), paths))
            covered.update(range(m.start(), end))
    for m in imgre.finditer(s):
        if m.start() not in covered:
            positions.append((m.start(), [m.group(1)]))

    jobs = {}
    for _, paths in positions:
        for p in paths:
            fp = os.path.join(os.path.dirname(main_path), p)
            if p not in jobs and os.path.exists(fp) and not p.lower().endswith(".pdf"):
                jobs[p] = fp
    futs = {p: pool.submit(describe, fp) for p, fp in jobs.items()}
    desc = {}
    for p, fut in futs.items():
        try:
            desc[p] = sanitize(fut.result())
        except Exception as e:  # noqa: BLE001
            sys.stderr.write("SKIP %s: %s\n" % (p, e))

    out = s
    inserted = 0
    for at, paths in sorted(positions, reverse=True):
        lines = []
        for p in paths:
            if p in desc:
                lines.append("// vision: %s" % desc[p])
        if not lines:
            continue
        line_start = out.rfind("\n", 0, at) + 1
        indent = re.match(r"[ \t]*", out[line_start:at]).group(0)
        block = "".join(indent + ln + "\n" for ln in lines)
        out = out[:line_start] + block + out[line_start:]
        inserted += len(lines)

    if inserted:
        open(main_path, "w", encoding="utf-8", newline="\n").write(out)
    json.dump(cache, open(CACHE_PATH, "w", encoding="utf-8"), ensure_ascii=False)
    return inserted, len(jobs)


def main():
    papers = sys.argv[1:]
    if not papers:
        papers = sorted(
            os.path.basename(os.path.dirname(p))
            for p in __import__("glob").glob(os.path.join(ROOT, "papers", "*", "main.typ"))
        )
    with ThreadPoolExecutor(WORKERS) as pool:
        for pid in papers:
            mp = os.path.join(ROOT, "papers", pid, "main.typ")
            if not os.path.exists(mp):
                continue
            t0 = time.time()
            n, total = annotate_paper(mp, pool)
            sys.stderr.write("%s: %d comments (%d images, %.0fs)\n" % (pid, n, total, time.time() - t0))
            sys.stderr.flush()


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8")
    main()

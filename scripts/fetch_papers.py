import json, time, urllib.request, urllib.parse, os, tarfile, gzip, io, sys

UA = {"User-Agent": "tex2typst-research/0.1 (academic conversion pipeline)"}

def get(url, retries=5):
    for i in range(retries):
        try:
            req = urllib.request.Request(url, headers=UA)
            with urllib.request.urlopen(req, timeout=60) as r:
                return r.read()
        except Exception as e:
            print(f"retry {i} {url[:90]}: {e}", flush=True)
            time.sleep(3 * (i + 1))
    return None

BASE = "https://api.semanticscholar.org/graph/v1/paper/search/bulk"

def bulk(query, cats):
    params = {
        "query": query,
        "publicationDateOrYear": "2021-01-01:2026-10-19",
        "sort": "citationCount:desc",
        "fields": "title,citationCount,externalIds,venue,publicationDate,isOpenAccess",
        "limit": "100",
    }
    url = BASE + "?" + urllib.parse.urlencode(params)
    data = get(url)
    if not data:
        return []
    out = []
    for p in json.loads(data).get("data", []):
        ext = p.get("externalIds") or {}
        ax = ext.get("ArXiv")
        if ax and (p.get("citationCount") or 0) >= 100:
            out.append({"arxiv": ax, "title": p.get("title"), "cites": p.get("citationCount"), "venue": p.get("venue"), "date": p.get("publicationDate"), "query": query})
    return out

queries = [
    "quantum error correction", "neural network quantum states", "graphene moire",
    "higgs", "gravitational waves pulsar timing", "topological quantum",
    "machine learning particle physics", "dark matter axion", "superconductivity nickelate",
    "large language model physics", "attosecond", "quantum computing supremacy",
]
found = {}
for q in queries:
    for p in bulk(q, None):
        found.setdefault(p["arxiv"], p)
    time.sleep(1.2)

papers = sorted(found.values(), key=lambda x: -x["cites"])
print(json.dumps(papers[:30], indent=1)[:4000])
json.dump(papers, open(r"E:\phys\papers\candidates.json", "w"), indent=1)

os.makedirs(r"E:\phys\papers", exist_ok=True)
keep = papers[:10]
for p in keep:
    ax = p["arxiv"]
    d = rf"E:\phys\papers\{ax.replace('/', '_')}"
    os.makedirs(d, exist_ok=True)
    raw = os.path.join(d, "src.tar.gz")
    if not os.path.exists(raw) or os.path.getsize(raw) < 1000:
        blob = get(f"https://export.arxiv.org/e-print/{ax}")
        if not blob:
            print("download failed", ax, flush=True)
            continue
        open(raw, "wb").write(blob)
        print(ax, len(blob), p["cites"], (p["title"] or "")[:60], flush=True)
    # extract
    ex = os.path.join(d, "src")
    os.makedirs(ex, exist_ok=True)
    try:
        with tarfile.open(raw) as t:
            t.extractall(ex, filter="data")
    except tarfile.ReadError:
        # maybe single gzipped tex
        with gzip.open(raw, "rb") as g, open(os.path.join(ex, "main.tex"), "wb") as f:
            f.write(g.read())
    except Exception as e:
        print("extract fail", ax, e, flush=True)
    time.sleep(4)
print("DONE", flush=True)

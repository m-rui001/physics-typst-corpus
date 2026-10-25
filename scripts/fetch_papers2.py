import json, time, urllib.request, urllib.parse, os, tarfile, gzip

UA = {"User-Agent": "tex2typst-research/0.1"}

def get(url, retries=5):
    for i in range(retries):
        try:
            with urllib.request.urlopen(urllib.request.Request(url, headers=UA), timeout=60) as r:
                return r.read()
        except Exception as e:
            time.sleep(3 * (i + 1))
    return None

BASE = "https://api.semanticscholar.org/graph/v1/paper/search/bulk"

def bulk(query):
    params = {"query": query, "publicationDateOrYear": "2021-01-01:2026-10-19",
              "sort": "citationCount:desc",
              "fields": "title,citationCount,externalIds,venue,publicationDate",
              "limit": "60"}
    data = get(BASE + "?" + urllib.parse.urlencode(params))
    out = []
    if data:
        for p in json.loads(data).get("data", []):
            ax = (p.get("externalIds") or {}).get("ArXiv")
            if ax and (p.get("citationCount") or 0) >= 80:
                out.append({"arxiv": ax, "title": p.get("title"), "cites": p.get("citationCount"),
                            "venue": p.get("venue"), "date": p.get("publicationDate"), "query": query})
    return out

queries = ["conformal bootstrap", "swampland program", "axion inflation CMB", "neutrino mass ordering",
           "machine learning turbulence fluid", "quantum many-body scar", "non-hermitian physics",
           "twisted light", "magnetar", "lattice gauge computation", "primordial gravitational background",
           "tensors renormalization"]
found = {}
for q in queries:
    for p in bulk(q):
        found.setdefault(p["arxiv"], p)
    time.sleep(1.2)
papers = sorted(found.values(), key=lambda x: -x["cites"])
json.dump(papers, open(r"E:\phys\papers\candidates2.json", "w"), indent=1)
for p in papers[:30]:
    print(p["cites"], p["arxiv"], (p["title"] or "")[:70], flush=True)

keep = papers[:12]
for p in keep:
    ax = p["arxiv"]
    d = rf"E:\phys\papers\{ax.replace('/', '_')}"
    os.makedirs(d, exist_ok=True)
    raw = os.path.join(d, "src.tar.gz")
    if not os.path.exists(raw) or os.path.getsize(raw) < 1000:
        blob = get(f"https://export.arxiv.org/e-print/{ax}")
        if not blob:
            print("FAIL", ax, flush=True); continue
        open(raw, "wb").write(blob)
    ex = os.path.join(d, "src")
    os.makedirs(ex, exist_ok=True)
    try:
        with tarfile.open(raw) as t:
            t.extractall(ex, filter="data")
    except tarfile.ReadError:
        with gzip.open(raw, "rb") as g, open(os.path.join(ex, "main.tex"), "wb") as f:
            f.write(g.read())
    except Exception as e:
        print("EXTRACT FAIL", ax, e, flush=True)
    print("GOT", ax, p["cites"], (p["title"] or "")[:60], flush=True)
    time.sleep(4)
print("DONE2", flush=True)

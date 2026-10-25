# -*- coding: utf-8 -*-
"""Fetch the next tranche of high-citation physics papers from the candidate list.

Only the arXiv e-print is probed before download: many high-citation submissions are PDF-only,
and a PDF-only paper cannot be converted, so `content-type` decides. gzip means the tarball of
LaTeX source is there; octet-stream is treated as the same thing.
"""
import json, os, subprocess, sys, tarfile, gzip, io, shutil

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PAPERS = os.path.join(BASE, 'papers')
LIMIT = int(sys.argv[1]) if len(sys.argv) > 1 else 10


def content_type(aid):
    r = subprocess.run(['curl', '-sIL', '--max-time', '40',
                        'https://arxiv.org/e-print/' + aid],
                       capture_output=True, text=True)
    types = [line.split(':', 1)[1].strip().lower()
             for line in r.stdout.splitlines() if line.lower().startswith('content-type')]
    # arXiv answers the bare id with a 301 whose own content-type is text/html; only the
    # final response describes the e-print, so taking the first header rejects every paper.
    return types[-1] if types else ''


def main():
    cands = json.load(open(os.path.join(PAPERS, 'candidates2.json'), encoding='utf-8'))
    have = set(os.listdir(PAPERS))
    todo = [c for c in sorted(cands, key=lambda e: -int(e.get('cites') or 0))
            if c.get('arxiv') and c['arxiv'] not in have]
    print('candidates=%d un-fetched=%d' % (len(cands), len(todo)))
    got = 0
    for c in todo[:LIMIT * 3]:
        if got >= LIMIT:
            break
        aid = c['arxiv']
        ct = content_type(aid)
        if 'gzip' not in ct and 'octet' not in ct:
            print('  SKIP %-12s %s  (%s)' % (aid, ct or 'no content-type', str(c.get('title'))[:60]))
            continue
        blob = subprocess.run(['curl', '-sL', '--max-time', '180',
                               'https://arxiv.org/e-print/' + aid],
                              capture_output=True).stdout
        dst = os.path.join(PAPERS, aid)
        os.makedirs(os.path.join(dst, 'src'), exist_ok=True)
        try:
            with tarfile.open(fileobj=io.BytesIO(gzip.decompress(blob))) as t:
                t.extractall(os.path.join(dst, 'src'))
        except tarfile.ReadError:
            # single-file submissions are a bare gzip of one .tex
            with open(os.path.join(dst, 'src', 'main.tex'), 'wb') as f:
                f.write(gzip.decompress(blob))
        ntex = sum(len([x for x in fs if x.endswith('.tex')]) for _, _, fs in os.walk(os.path.join(dst, 'src')))
        if not ntex:
            print('  EMPTY %-12s extracted but no .tex' % aid)
            shutil.rmtree(dst, ignore_errors=True)
            continue
        got += 1
        print('  FETCH %-12s tex=%-3d cites=%-6s %s'
              % (aid, ntex, c.get('cites'), str(c.get('title'))[:66]))
    print('fetched %d new papers' % got)


if __name__ == '__main__':
    main()

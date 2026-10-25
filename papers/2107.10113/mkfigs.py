# -*- coding: utf-8 -*-
"""Rasterise the paper's PDF figures into figures/*.png for Typst embedding.

Typst cannot embed PDF/EPS, so every vector figure becomes a high-resolution PNG.
The Aitoff map is included in LaTeX with trim={0 3cm 0 3cm}, clip, so the same
3 cm bands are cropped here.
"""
import os
import pymupdf

HERE = os.path.dirname(os.path.abspath(__file__))
SRC = os.path.join(HERE, 'src')
OUT = os.path.join(HERE, 'figures')
DPI = 200
CM = 28.3465

PDFS = [
    'frb_sources_papers_graph', 'Michilli_2021_adapted', 'Bhandari_2021_adapted_1',
    'Bhandari_2021_adapted_2', 'Tendulkar_2021_adapted', 'TPS_review',
    'LC_radio_X_03', 'cartoon_v3', 'Lu_alfven_waves', 'rep_frac_perfect',
    'fig_dmz_190520', 'Cartoon', 'Cartoon_puffier',
]
TRIM = {'Aitoff_all_update': (0, 3 * CM, 0, 3 * CM)}


def main():
    os.makedirs(OUT, exist_ok=True)
    for name in PDFS + list(TRIM):
        src = os.path.join(SRC, name + '.pdf')
        if not os.path.exists(src):
            print('MISSING', src)
            continue
        doc = pymupdf.open(src)
        page = doc[0]
        rect = page.rect
        trim = TRIM.get(name)
        if trim:
            rect = pymupdf.Rect(rect.x0 + trim[0], rect.y0 + trim[1],
                                rect.x1 - trim[2], rect.y1 - trim[3])
        pix = page.get_pixmap(dpi=DPI, clip=rect)
        dst = os.path.join(OUT, name + '.png')
        pix.save(dst)
        print('%-32s %4dx%-4d %s' % (name, pix.width, pix.height,
                                     os.path.getsize(dst) // 1024))


if __name__ == '__main__':
    main()

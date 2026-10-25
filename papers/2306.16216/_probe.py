import re, shutil

s = open('src/cpta_dr1_letter_v2.tex', encoding='utf-8').read() if False else None
import glob, os
tex = [f for f in glob.glob('src/*.tex') if 'cpta' in f.lower() or 'letter' in f.lower()]
print(tex)

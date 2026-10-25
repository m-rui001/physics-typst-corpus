"""Expand AASTeX journal macros and common TeX escapes in ADS-export refs.bib files."""
import io
import re
import sys
import glob
from collections import Counter

JMAP = {
    'aj': 'Astron. J.',
    'araa': 'Annu. Rev. Astron. Astrophys.',
    'apj': 'Astrophys. J.',
    'apjl': 'Astrophys. J. Lett.',
    'apjs': 'Astrophys. J. Suppl. Ser.',
    'ao': 'Appl. Opt.',
    'apss': 'Astrophys. Space Sci.',
    'aap': 'Astron. Astrophys.',
    'aapr': 'Astron. Astrophys. Rev.',
    'aaps': 'Astron. Astrophys. Suppl. Ser.',
    'azh': 'Astron. Zh.',
    'baas': 'Bull. Am. Astron. Soc.',
    'icarus': 'Icarus',
    'jaavso': 'J. Am. Assoc. Var. Star Obs.',
    'jrasc': 'J. R. Astron. Soc. Can.',
    'memras': 'Mem. R. Astron. Soc.',
    'mnras': 'Mon. Not. R. Astron. Soc.',
    'pra': 'Phys. Rev. A',
    'prb': 'Phys. Rev. B',
    'prc': 'Phys. Rev. C',
    'prd': 'Phys. Rev. D',
    'pre': 'Phys. Rev. E',
    'prl': 'Phys. Rev. Lett.',
    'pasp': 'Publ. Astron. Soc. Pac.',
    'pasj': 'PASJ',
    'qjras': 'Q. J. R. Astron. Soc.',
    'skytel': 'Sky Telesc.',
    'solphys': 'Sol. Phys.',
    'sovast': 'Sov. Astron.',
    'ssr': 'Space Sci. Rev.',
    'zap': 'Z. Astrophys.',
    'nat': 'Nature',
    'iaucirc': 'IAU Circ.',
    'aplett': 'Astrophys. Lett.',
    'apspr': 'Astrophys. Space Phys. Res.',
    'bain': 'Bull. Astron. Inst. Neth.',
    'fcp': 'Fundam. Cosm. Phys.',
    'gca': 'Geochim. Cosmochim. Acta',
    'grl': 'Geophys. Res. Lett.',
    'jcp': 'J. Chem. Phys.',
    'jgr': 'J. Geophys. Res.',
    'jqsrt': 'J. Quant. Spectrosc. Radiat. Transf.',
    'memsai': 'Mem. Soc. Astron. Ital.',
    'nphysa': 'Nucl. Phys. A',
    'physrep': 'Phys. Rep.',
    'physscr': 'Phys. Scr.',
    'planss': 'Planet. Space Sci.',
    'procspie': 'Proc. SPIE',
    'actaa': 'Acta Astron.',
    'caa': 'Chin. Astron. Astrophys.',
    'cjaa': 'Chin. J. Astron. Astrophys.',
    'jcap': 'J. Cosmol. Astropart. Phys.',
    'na': 'New Astron.',
    'nar': 'New Astron. Rev.',
    'pasa': 'Publ. Astron. Soc. Aust.',
    'rmxaa': 'Rev. Mex. Astron. Astrofis.',
    'maps': 'Meteorit. Planet. Sci.',
    'aas': 'AAS Meeting Abstracts',
    'dps': 'AAS/DPS Meeting Abstracts',
    'apjlett': 'Astrophys. J. Lett.',
    'apjsupp': 'Astrophys. J. Suppl. Ser.',
    'applopt': 'Appl. Opt.',
    'astap': 'Astron. Astrophys.',
}

SYM = {
    'gamma': '\u03b3', 'pi': '\u03c0', 'omega': '\u03a9', 'Omega': '\u03a9',
    'sim': '\u223c', 'pm': '\u00b1', 'odot': '\u2299', 'alpha': '\u03b1',
    'delta': '\u03b4', 'Delta': '\u0394', 'mu': '\u03bc', 'nu': '\u03bd',
    'tau': '\u03c4', 'sigma': '\u03c3', 'theta': '\u03b8', 'lambda': '\u03bb',
    'epsilon': '\u03b5', 'infty': '\u221e', 'to': '\u2192',
}

jpat = re.compile(r'journal\s*=\s*\{\\([a-zA-Z]+)\}')
epat = re.compile(r'\{\\ensuremath\{\\([a-zA-Z]+)\}\}')
bpat = re.compile(r'\{\\ensuremath\{([^{}]*)\}\}')


def expand(text):
    text = jpat.sub(lambda m: 'journal = {%s}' % JMAP[m.group(1)]
                    if m.group(1) in JMAP else m.group(0), text)
    text = epat.sub(lambda m: SYM.get(m.group(1), m.group(0)), text)
    text = bpat.sub(lambda m: m.group(1), text)
    text = text.replace(r'\textbackslashDelta', 'Δ')
    text = text.replace(r'\textquotedblleft', '“')
    text = text.replace(r'\textquotedblright', '”')
    return text


def main():
    args = [a for a in sys.argv[1:] if not a.startswith('-')]
    apply = '--apply' in sys.argv
    files = []
    for a in args:
        files.extend(glob.glob(a))
    left = Counter()
    changed = 0
    for f in files:
        raw = io.open(f, encoding='utf-8', errors='replace').read()
        new = expand(raw)
        if new != raw:
            changed += 1
            if apply:
                io.open(f, 'w', encoding='utf-8', newline='\n').write(new)
        for m in re.finditer(r'\\([a-zA-Z]+)', new):
            left[m.group(0)] += 1
    print('files=%d changed=%d apply=%s' % (len(files), changed, apply))
    print('remaining escapes:', left.most_common(20))


if __name__ == '__main__':
    main()

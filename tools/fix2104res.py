# -*- coding: utf-8 -*-
"""Second pass over 2104.07634: raw equation blocks, escaped inline math, ref holes."""
import re, sys, os

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MAIN = os.path.join(BASE, 'papers', '2104.07634', 'main.typ')

D = chr(92) + '$'          # \$
DD = D + D                 # \$\$
EQ_OPEN = DD + chr(92) + chr(92) + 'begin{equation}'
EQ_CLOSE = chr(92) + chr(92) + 'end{equation}' + DD

EQUATIONS = [
    '$ m_a = (5.7 plus.minus 0.7) "µeV" times frac(10^12 "GeV", f_a) . $',
    '$ frac(d R, d E_"nr") = frac(rho_0 M, m_N m_chi) integral_(v_"min")^infinity v f(v) '
    'frac(d sigma, d E_"nr") thin d v prop exp (- frac(E_"nr", E_0) '
    'frac(4 m_chi m_N, (m_chi + m_N)^2)) F^2 (E_"nr") . $ <eq::rate>',
    '$ N = T integral_(E_"low")^(E_"high") d E_"nr" thin epsilon (E_"nr") thin '
    'frac(d R, d E_"nr") . $',
    '$ v_E = v_⊙ + v_⊕ cos(theta) cos[omega (t - t_0)] , $ <eq::velocities>',
    '$ S(t) = B(t) + S_0 + S_m cos[omega (t - t_0)] . $',
    '$ frac(d sigma (E_"nr"), d E_"nr") = frac(m_N, 2 v^2 mu^2) '
    '[sigma_"SI" F_"SI"^2 (E_"nr") + sigma_"SD" F_"SD"^2 (E_"nr")] . $',
    '$ sigma_"SI" = sigma_n frac(mu^2, mu_n^2) frac((f_p Z + f_n (A - Z))^2, f_n^2) '
    '= sigma_n frac(mu^2, mu_n^2) A^2 . $ <eq::si>',
    '$ frac(d sigma_"SD", d |arrow(q)|^2) = frac(8 G_F^2, pi v^2) '
    '[a_p chevron.l S_p chevron.r + a_n chevron.l S_n chevron.r]^2 '
    'frac(J+1, J) frac(S(|arrow(q)|), S(0)) . $ <eq::sd>',
]

UNIT = {
    'gev': 'GeV', 'geV': 'GeV', 'GeV': 'GeV', 'tev': 'TeV', 'mev': 'MeV', 'kev': 'keV',
    'ev': 'eV', 'nev': 'neV', 'miliev': 'meV', 'milieV': 'meV', 'muev': 'µeV',
    'tonne': 't', 'gram': 'g', 'kgram': 'kg', 'cmeter': 'cm', 'kmeter': 'km',
    'meter': 'm', 'mmeter': 'mm', 'second': 's', 'musecond': 'µs', 'mpc': 'Mpc', 'pb': 'pb',
    'muBq': 'µBq', 'years': 'years', 'year': 'year', 'keVnr': 'keV',
}

LATEX = {
    'gtrsim': 'gt.eq.slant', 'lesssim': 'lt.eq.slant', 'geq': 'gt.eq', 'leq': 'lt.eq',
    'sim': 'tilde.op', 'times': 'times', 'approx': 'approx', 'equiv': 'equiv',
    'mu': 'mu', 'nu': 'nu', 'rho': 'rho', 'sigma': 'sigma', 'gamma': 'gamma',
    'pi': 'pi', 'epsilon': 'epsilon', 'theta': 'theta', 'omega': 'omega',
    'eV': '"eV"', 'keV': '"keV"', 'MeV': '"MeV"', 'GeV': '"GeV"', 'TeV': '"TeV"',
    'ev': '"eV"', 'kev': '"keV"', 'mev': '"MeV"', 'gev': '"GeV"', 'tev': '"TeV"',
}


def _match_brace(s, i):
    depth = 0
    for j in range(i, len(s)):
        if s[j] == '{':
            depth += 1
        elif s[j] == '}':
            depth -= 1
            if depth == 0:
                return j
    return -1


def _script_braces(s):
    out, i, n = [], 0, len(s)
    while i < n:
        c = s[i]
        if c in '^_' and i + 1 < n and s[i + 1] == '{':
            j = _match_brace(s, i + 1)
            if j > 0:
                out.append(c + '(' + _script_braces(s[i + 2:j]) + ')')
                i = j + 1
                continue
        out.append(c)
        i += 1
    return ''.join(out)


def fix_math_inner(s):
    s = s.replace(chr(92) * 2, chr(92))
    s = s.replace(chr(92) + '_', '_').replace(chr(92) + '>', '>').replace(chr(92) + '<', '<')
    s = s.replace(chr(92) + ',', ' thin ').replace(chr(92) + ' ', ' ')
    s = s.replace(chr(92) + '!', '')
    s = re.sub(r'\\([A-Za-z]+)', lambda m: LATEX.get(m.group(1), m.group(1)) + ' ', s)
    s = re.sub(r'\\(.)', r'\1', s)
    s = s.replace('lt.tilde', 'lt.eq.slant').replace('gt.tilde', 'gt.eq.slant')
    s = re.sub(r'\{"?mathcal"?\{O\}\}', 'cal(O)', s)
    s = re.sub(r'"mathcal"\{O\}', 'cal(O)', s)
    s = re.sub(r'"macron"\s*\(([^)]*)\)', r'overline(\1)', s)
    s = re.sub(r'"upright"\s*\(\s*"([^"]*)"\s*\)', lambda m: '"%s"' % m.group(1).replace(' ', ''), s)
    s = s.replace('"upright"("Pl")', '"Pl"')
    s = s.replace('"times"', 'times')
    s = s.replace('"ll"', '<<')
    s = s.replace('"odot"', '⊙')
    s = s.replace('"≲"', 'lt.eq.slant').replace('"≳"', 'gt.eq.slant').replace('"∼"', 'tilde.op')
    s = re.sub(r'"keVnr"', '"keV"_"nr"', s)
    s = re.sub(r'"keVee"', '"keV"_"ee"', s)
    s = re.sub(r'"eVee"', '"eV"_"ee"', s)
    s = s.replace('"Enr"', 'E_"nr"')

    # LaTeX grouping braces become math attachment groups
    s = _script_braces(s)
    s = s.replace('{', '').replace('}', '')

    # \sim as operator, not accent
    s = re.sub(r'tilde(?!\.)', 'tilde.op ', s)
    s = re.sub(r'(?<=[A-Za-z0-9_])tilde\.op', ' tilde.op', s)
    s = re.sub(r'(?<=[0-9)])times(?=[0-9(])', ' times ', s)
    s = re.sub(r'(?<=[0-9)])prop(?=[0-9(])', ' prop ', s)
    s = re.sub(r'(?<=[0-9)])approx(?=[0-9(])', ' approx ', s)
    s = re.sub(r'(?<![A-Za-z])(times|prop|approx|equiv|plus\.minus)(?=[0-9("])', r' \1 ', s)
    s = re.sub(r'(?<=[A-Za-z0-9)])(times|prop|approx|equiv|plus\.minus)(?![A-Za-z])',
               r' \1 ', s)
    s = re.sub(r'((?:[a-z]+\.)+[a-z]+)(?=[0-9("])', r'\1 ', s)
    s = s.replace('agamma', 'a gamma')

    def unit(m):
        u = m.group(1)
        return '"%s"' % UNIT.get(u, u)
    s = re.sub(r'"([A-Za-z]+)"', unit, s)
    s = re.sub(r'(?<![A-Za-z"])cm(?![A-Za-z"])', '"cm"', s)
    s = re.sub(r'\s+', ' ', s).strip()
    if s.startswith(('^', '_')):
        s = '""' + s
    return s


def repl_spans(s):
    # escaped math delimiters may wrap lines, so pair them across newlines first
    pat_e = re.compile(re.escape(D) + r'([^$]*?)' + re.escape(D), re.S)
    s = pat_e.sub(lambda m: '$' + fix_math_inner(m.group(1)) + '$', s)
    # then normalize every remaining inline span; whitespace-padded spans are display math
    pat = re.compile(r'\$([^$\n]*)\$')

    def one(m):
        c = m.group(1)
        if not c.strip() or c.strip() != c:
            return m.group(0)
        return '$' + fix_math_inner(c) + '$'
    return pat.sub(one, s)


def main():
    s = open(MAIN, encoding='utf-8').read()

    # 1. raw display equations
    pat = re.compile(re.escape(DD) + r'.*?' + re.escape(DD), re.S)
    it = iter(EQUATIONS)

    def eq(m):
        try:
            return next(it)
        except StopIteration:
            return m.group(0)
    s, n = pat.subn(eq, s)
    print('raw blocks replaced:', n)

    # 2. inline math spans
    s = repl_spans(s)

    # 3. dangling section labels -> use the slug labels on the real headings
    s = s.replace('and#text([]), respectively',
                  'and @other-constraints-on-axions-and-alps, respectively')
    s = s.replace('presented in Sect.#text([])',
                  'presented in Sect. @infrastructure-and-deep-underground-laboratories')
    s = s.replace('(see Sect.#text([]))',
                  '(see Sect. @other-constraints-on-axions-and-alps)')
    s = s.replace('discussed in Sect.#text([])',
                  'discussed in Sect. @other-constraints-on-axions-and-alps')
    s = s.replace('given in #text([])',
                  'given in @tab:axion_experiments')
    s = re.sub(r'(?m)^ sec:(axionbroader|labs)\s*$\n', '', s)

    # 5. explicit slug labels that duplicate the heading's own auto label
    s = s.replace('== Experimental Approaches\n<experimental-approaches>',
                  '== Experimental Approaches')
    s = s.replace('= Searches for Axions and ALPs\n<searches-for-axions-and-alps>',
                  '= Searches for Axions and ALPs')
    # two different R&D subsections share one slug; the second has no inbound refs
    s = s.replace('==== R&D programs\n<rd-programs>', '==== R&D programs')

    # 4. equation references
    s = s.replace('Eq.~(#text([]))', 'Eq. @eq::rate')
    s = s.replace('Eq. (#text([]))', 'Eq. @eq::rate')
    s = s.replace('Eq.\u2006(#text([]))', 'Eq. @eq::rate')
    s = s.replace('Another way to exploit Eq.@eq::rate',
                  'Another way to exploit Eq. @eq::velocities')

    # 6. units dropped where a TeX unit macro followed a closing math delimiter
    old = '$g_(a gamma) lt.eq.slant$ 10$""^(- 11)$$""^(- 1)$'
    new = '$g_(a gamma) lt.eq.slant 10^(-11) "GeV"^(-1)$'
    assert s.count(old) == 1, s.count(old)
    s = s.replace(old, new)
    old = 'possible for a mass $gt.eq.slant$.'
    new = 'possible for a mass $gt.eq.slant "MeV"$.'
    assert s.count(old) == 1, s.count(old)
    s = s.replace(old, new)

    # 7. unit macros the converter dropped outside math, restored from the TeX source
    n = s.count('"mueV"')
    assert n == 15, n
    s = s.replace('"mueV"', '"µeV"')

    def rep(pat, new, cnt=1):
        nonlocal s
        s2, k = re.subn(pat, new, s)
        assert k == cnt, (pat, k)
        s = s2

    rep(r'between 25\s+and \$tilde', 'between 25 µeV and $tilde')
    rep(r'Thresholds below 100\s+will', 'Thresholds below 100 eV will')
    rep(r'1\.6\s+threshold\)', '1.6 keV#sub[nr] threshold)')
    rep(r'only below \$lt\.eq\.slant\$6\.',
        'only below $lt.eq.slant 6"keV"_"nr"$.')
    rep(r'for the 2-6[\s~]+region', 'for the 2-6 keV#sub[ee] region', 3)
    rep(r'peak at 3\.2\.', 'peak at 3.2 keV.')
    rep(r'threshold at 2\$""_\(e e\)\$\.', 'threshold at 2 keV.')
    rep(r'a threshold of 50\.', 'a threshold of 50 eV#sub[ee].')
    rep(r'from 0\.4\s+down to 0\.1\.',
        'from 0.4 keV#sub[ee] down to 0.1 keV#sub[ee].')
    rep(r'threshold of 2\s+has', 'threshold of 2 keV#sub[ee] has')
    rep(r'\(50\)\.', '(50 MHz).')
    rep(r'between 40and 400\\@TheMADMAX',
        'between 40 µeV and 400 µeV @TheMADMAX')
    rep(r'in the 100\s+to 10\s+regime', 'in the 100 MHz to 10 GHz regime')
    rep(r'range 60\$thin - thin\$250,', 'range 60–250 MHz,')
    rep(r'\(1\.35\s+warm bore\) 9 dipole', '(1.35 m warm bore) 9 T dipole')
    rep(r'range 10\$-\$\s+100 and', 'range 10–100 GHz and')
    rep(r'around 80\.\s+The final', 'around 80 µeV. The final')
    rep(r'between 120and 400\.', 'between 120 µeV and 400 µeV.')
    rep(r'mass range below 10\.\s+Note', 'mass range below 10 keV. Note')
    rep(r'ranges below 1~and', 'ranges below 1 neV and')
    rep(r'\(500\s+to few\s+\)', '(500 µeV to few meV)')
    rep(r'below 10 \(axion mass below 40\)',
        'below 10 GHz (axion mass below 40 µeV)')
    rep(r'\(mass above 100\) single', '(mass above 100 µeV) single')
    rep(r'range above 30 need', 'range above 30 GHz need')

    if '--dry' in sys.argv:
        open(MAIN + '.dry', 'w', encoding='utf-8').write(s)
        print('dry written')
        return
    open(MAIN, 'w', encoding='utf-8').write(s)
    print('written')


if __name__ == '__main__':
    main()

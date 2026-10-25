import glob
import os

TWO_LF = chr(92) * 2 + chr(10)
TWO_CRLF = chr(92) * 2 + chr(13) + chr(10)

tot = lf = crlf = 0
files = []
for f in sorted(glob.glob(r"E:\phys\papers\*\*.typ")):
    b = open(f, "rb").read()
    n = b.count(TWO_LF.encode()) + b.count(TWO_CRLF.encode())
    if n:
        tot += n
        files.append((n, f))
        lf += b.count(TWO_LF.encode())
        crlf += b.count(TWO_CRLF.encode())
for n, f in files:
    print(f"{n:4d}  {os.path.basename(os.path.dirname(f))}/{os.path.basename(f)}")
print(f"files {len(files)}  total {tot}  LF {lf}  CRLF {crlf}")

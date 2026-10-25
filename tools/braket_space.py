import io
import sys

for pid in ("2109.00548", "2111.14241", "2205.10379", "2207.06431"):
    p = "papers/%s/main.typ" % pid
    s = io.open(p, encoding="utf-8").read()
    io.open(p + ".prebraket", "w", encoding="utf-8").write(s)
    n1 = s.count(" ⟩")
    n2 = s.count("⟨ ")
    s = s.replace(" ⟩", "⟩").replace("⟨ ", "⟨")
    io.open(p, "w", encoding="utf-8").write(s)
    print(pid, "fixed", n1, n2)

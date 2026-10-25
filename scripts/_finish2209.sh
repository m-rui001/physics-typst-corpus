#!/usr/bin/env bash
# Wait for the 2209.06202 reconversion to rewrite main.typ, then lay out two columns,
# compile, and report. Prints a compact status line per step.
cd /e/phys || exit 1
START=$(stat -c %Y papers/2209.06202/main.typ)
echo "start epoch $START"
for i in $(seq 1 240); do
  sleep 15
  NOW=$(stat -c %Y papers/2209.06202/main.typ 2>/dev/null || echo 0)
  if [ "$NOW" -gt "$START" ]; then
    echo "main.typ rewritten at $(date +%H:%M:%S)"
    break
  fi
done
NOW=$(stat -c %Y papers/2209.06202/main.typ)
if [ "$NOW" -le "$START" ]; then
  echo "TIMEOUT: main.typ not rewritten (process may have died)"
  exit 2
fi
python scripts/apply_cols.py 2209.06202
typst compile --no-pdf-tags --root /e/phys papers/2209.06202/main.typ papers/2209.06202/build/ov.pdf 2>&1 | head -20
pdfinfo papers/2209.06202/build/ov.pdf | grep Pages
echo "escaped-dollar blocks: $(grep -c '\$\$' papers/2209.06202/main.typ || true)"
echo "text-empty holes: $(grep -c '#text(\[\])' papers/2209.06202/main.typ || true)"

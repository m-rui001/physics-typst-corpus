#!/bin/bash
cd /e/phys
for d in papers/2*/; do
  p=$(basename "$d")
  [ -f "$d/main.typ" ] || continue
  err=$(typst compile --no-pdf-tags --root E:/phys "$d/main.typ" "$d/build/ov.pdf" 2>&1 | head -3)
  if [ -n "$err" ]; then
    echo "FAIL $p"; echo "$err" | sed 's/^/    /'
  else
    pages=$(pdfinfo "$d/build/ov.pdf" 2>/dev/null | awk '/Pages/{print $2}')
    echo "OK   $p $pages"
  fi
done

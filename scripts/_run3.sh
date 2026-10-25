#!/bin/bash
cd /e/phys || exit 1
export PYTHONIOENCODING=utf-8
LOG=/tmp/conv3.log
: > $LOG
for p in 2209.06202 2310.12110 2311.07931; do
  echo "=== $p start $(date +%H:%M:%S)" >> $LOG
  python scripts/convert.py papers/$p >> $LOG 2>&1
  echo "=== $p convert done $(date +%H:%M:%S)" >> $LOG
  python scripts/apply_cols.py $p >> $LOG 2>&1 || true
  typst compile --no-pdf-tags --root E:/phys papers/$p/main.typ papers/$p/build/ov.pdf >> $LOG 2>&1
  echo "=== $p pages: $(pdfinfo papers/$p/build/ov.pdf 2>/dev/null | grep Pages) holes: $(grep -c 'text(\[\])' papers/$p/main.typ) cites: $(grep -o '@[A-Za-z]' papers/$p/main.typ | wc -l)" >> $LOG
done
echo "=== ALL DONE $(date +%H:%M:%S)" >> $LOG

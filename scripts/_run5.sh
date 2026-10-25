#!/bin/bash
cd /e/phys || exit 1
export PYTHONIOENCODING=utf-8
export POLISH=0
LOG=/tmp/conv5.log
: > $LOG
for p in "$@"; do
  echo "=== $p start $(date +%H:%M:%S)" >> $LOG
  python scripts/convert.py papers/$p >> $LOG 2>&1
  echo "=== $p convert done $(date +%H:%M:%S)" >> $LOG
  python -X utf8 scripts/drive.py papers/$p >> $LOG 2>&1 || true
  echo "=== $p drive done $(date +%H:%M:%S)" >> $LOG
  python scripts/apply_cols.py $p >> $LOG 2>&1 || true
  typst compile --no-pdf-tags --root E:/phys papers/$p/main.typ papers/$p/build/ov.pdf >> $LOG 2>&1
  echo "=== $p pages: $(pdfinfo papers/$p/build/ov.pdf 2>/dev/null | grep Pages) holes: $(grep -c 'text(\[\])' papers/$p/main.typ) cites: $(grep -o '@[A-Za-z]' papers/$p/main.typ | wc -l)" >> $LOG
done
echo "=== ALL DONE $(date +%H:%M:%S)" >> $LOG

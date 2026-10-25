#!/usr/bin/env bash
# Convert the two newly fetched papers once the 2209.06202 reconversion exits.
cd /e/phys || exit 1
while tasklist //FI "PID eq 7132" 2>/dev/null | grep -q 7132; do sleep 20; done
for id in 2310.12110 2311.07931; do
  echo "=== $id $(date +%H:%M:%S)" >> /tmp/newconv.log
  python scripts/convert.py "papers/$id" >> /tmp/newconv.log 2>&1
  echo "=== done $id rc=$? $(date +%H:%M:%S)" >> /tmp/newconv.log
done

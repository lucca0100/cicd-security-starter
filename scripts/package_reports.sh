#!/usr/bin/env bash
set -euo pipefail
STAMP=$(date +"%Y%m%d-%H%M%S")
OUT="reports-${STAMP}.zip"
zip -r "$OUT" reports >/dev/null
echo "Arquivo gerado: $OUT"

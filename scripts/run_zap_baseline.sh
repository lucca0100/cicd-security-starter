#!/usr/bin/env bash
set -euo pipefail
TARGET="${1:-http://localhost:3000}"
mkdir -p reports/zap

echo "[DAST] Rodando ZAP Baseline contra $TARGET"
docker run --rm -v "$PWD/config/zap":/zap/wrk -v "$PWD/reports/zap":/zap/reports \
  owasp/zap2docker-stable zap-baseline.py \
  -t "$TARGET" -r /zap/reports/zap-baseline.html -I -x /zap/reports/zap-report.xml \
  -a -z "-configfile /zap/wrk/zap-baseline.conf" || true

echo "[DAST] Relatório em reports/zap/zap-baseline.html"

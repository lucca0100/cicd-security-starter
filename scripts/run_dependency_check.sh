#!/usr/bin/env bash
set -euo pipefail
mkdir -p reports/dependency-check data/dependency-check
echo "[SCA] Rodando OWASP Dependency-Check"
docker run --rm --volume "$PWD":/src --volume "$PWD/data/dependency-check":/usr/share/dependency-check/data \
  owasp/dependency-check:latest \
  --scan /src --format HTML --out /src/reports/dependency-check \
  --suppression /src/config/dependency-check/suppressions.xml || true
echo "[SCA] Relatório em reports/dependency-check/dependency-check-report.html"

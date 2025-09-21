#!/usr/bin/env bash
set -euo pipefail
mkdir -p reports/semgrep

echo "[SAST] Rodando Semgrep (OWASP Top 10 + Java)"
docker run --rm -v "$PWD":/src returntocorp/semgrep semgrep \
  --config p/owasp-top-ten --config p/java \
  --sarif --output /src/reports/semgrep/semgrep.sarif \
  --json --json-output /src/reports/semgrep/semgrep.json \
  --metrics=off || true

# Render HTML simples usando semgrep CLI (quando disponível) ou deixa JSON/SARIF
if docker run --rm returntocorp/semgrep --version >/dev/null 2>&1; then
  docker run --rm -v "$PWD":/src returntocorp/semgrep semgrep \
    --config p/owasp-top-ten --config p/java \
    --output /src/reports/semgrep/semgrep.txt --metrics=off || true
fi

echo "[SAST] Concluído. Artefatos em reports/semgrep/"

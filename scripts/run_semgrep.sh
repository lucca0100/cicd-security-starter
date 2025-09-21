#!/bin/bash
echo "[SAST] Rodando Semgrep (OWASP Top 10 + Java)"

mkdir -p reports/semgrep

# SARIF
docker run --rm -v "$PWD:/src" returntocorp/semgrep semgrep \
  --config p/owasp-top-ten --config p/java \
  --sarif --output /src/reports/semgrep/semgrep.sarif --metrics=off

# JSON
docker run --rm -v "$PWD:/src" returntocorp/semgrep semgrep \
  --config p/owasp-top-ten --config p/java \
  --json --json-output /src/reports/semgrep/semgrep.json --metrics=off

echo "[SAST] Concluído. Artefatos em reports/semgrep/"

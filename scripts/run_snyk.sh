#!/usr/bin/env bash
set -euo pipefail
mkdir -p reports/snyk
if [[ -z "${SNYK_TOKEN:-}" ]]; then
  echo "Defina SNYK_TOKEN para usar este script"
  exit 1
fi
docker run --rm -e SNYK_TOKEN -v "$PWD":/app snyk/snyk-cli:docker snyk test --json-file-output=/app/reports/snyk/snyk.json || true
echo "Relatório Snyk em reports/snyk/snyk.json"

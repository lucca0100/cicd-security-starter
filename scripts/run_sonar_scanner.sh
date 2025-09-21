#!/usr/bin/env bash
set -euo pipefail
mkdir -p reports/sonar

# Requer SonarQube em http://localhost:9000 (docker compose) e SONAR_TOKEN env
if ! curl -sSf http://localhost:9000/api/server/version >/dev/null; then
  echo "SonarQube não está no ar em http://localhost:9000. Rode: docker compose up -d sonarqube"
  exit 1
fi

if [[ -z "${SONAR_TOKEN:-}" ]]; then
  echo "Defina SONAR_TOKEN com um token de usuário do SonarQube"
  exit 1
fi

docker run --rm -e SONAR_HOST_URL="http://host.docker.internal:9000" -e SONAR_LOGIN="$SONAR_TOKEN" \
  -v "$PWD":/usr/src sonarsource/sonar-scanner-cli:latest
echo "Relatórios e Quality Gate disponíveis no SonarQube."

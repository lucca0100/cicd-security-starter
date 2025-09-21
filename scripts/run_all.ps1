Write-Host "=== [1/3] SAST - Semgrep (SARIF + JSON) ==="
$ROOT = (Get-Location).Path
docker run --rm -v "${ROOT}:/src" returntocorp/semgrep semgrep `
  --config p/owasp-top-ten --config p/java `
  --sarif --output /src/reports/semgrep/semgrep.sarif --metrics=off
docker run --rm -v "${ROOT}:/src" returntocorp/semgrep semgrep `
  --config p/owasp-top-ten --config p/java `
  --json --json-output /src/reports/semgrep/semgrep.json --metrics=off

Write-Host "=== [2/3] SCA - OWASP Dependency-Check ==="
docker run --rm `
  -v "${ROOT}:/src" `
  -v "${ROOT}\data\dependency-check:/usr/share/dependency-check/data" `
  owasp/dependency-check:latest `
  --scan /src --format HTML --out /src/reports/dependency-check `
  --suppression /src/config/dependency-check/suppressions.xml `
  --disableOssIndex

Write-Host "=== [3/3] DAST - OWASP ZAP Baseline ==="
docker compose up -d juice-shop
docker run --rm -t `
  -v "${ROOT}\reports\zap:/zap/reports" `
  ghcr.io/zaproxy/zaproxy:stable `
  zap-baseline.py --autooff `
  -t "http://host.docker.internal:3000" `
  -r /zap/reports/zap-baseline.html `
  -x /zap/reports/zap-report.xml -I
docker compose down

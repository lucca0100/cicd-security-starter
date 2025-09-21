$ROOT = (Get-Location).Path

Write-Host "Subindo o Juice Shop"
docker compose up -d juice-shop

Write-Host "Rodando OWASP ZAP Baseline"
docker run --rm -t `
  -v "${ROOT}\reports\zap:/zap/reports" `
  ghcr.io/zaproxy/zaproxy:stable `
  zap-baseline.py --autooff `
  -t "http://host.docker.internal:3000" `
  -r /zap/reports/zap-baseline.html `
  -x /zap/reports/zap-report.xml -I

docker compose down

Write-Host "Relatório salvo em reports/zap/zap-baseline.html"
Start-Process .\reports\zap\zap-baseline.html

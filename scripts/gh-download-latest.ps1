param(
  [string]$Repo = "lucca0100/cicd-security-starter",
  [string]$Workflow = "security-pipeline.yml"
)

# 1) Pega o último run do workflow
$runId = (gh run list --workflow $Workflow --repo $Repo --limit 1 --json databaseId --jq '.[0].databaseId')
if (-not $runId) { Write-Host "Nenhum run encontrado."; exit 1 }

# 2) Cria pasta e baixa todos os artifacts
New-Item -ItemType Directory -Force -Path ".\artifacts" | Out-Null
gh run download $runId --repo $Repo -D ".\artifacts"

Write-Host "Artifacts baixados em .\artifacts"
# 3) Abre relatórios, se existirem
$dc = ".\artifacts\dependency-check-report\dependency-check-report.html"
$zap = ".\artifacts\zap-baseline-report\report_html.html"
$sem = ".\artifacts\semgrep-reports\semgrep.sarif"

if (Test-Path $dc)  { Start-Process $dc }
if (Test-Path $zap) { Start-Process $zap }
if (Test-Path $sem) { Start-Process $sem }

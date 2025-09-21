# Entregáveis e Como Gerar

Este guia mostra como produzir os **4 entregáveis** da sprint.

---

## 1) SAST – Análise Estática (CI) – Peso 2,5

**O que entregar**
- Relatório do Semgrep (`reports/semgrep/semgrep.sarif` e `semgrep.html`).
- (Opcional) Relatório SonarQube (`reports/sonar/` + print do *Quality Gate*).

**Como gerar (local ou CI)**
```bash
./scripts/run_semgrep.sh
# (Opcional) subir SonarQube local e rodar scanner
docker compose up -d sonarqube
./scripts/run_sonar_scanner.sh
```

**Onde ficam os arquivos**: `reports/semgrep/` e `reports/sonar/`.

---

## 2) DAST – Testes Dinâmicos (CD) – Peso 3,0

**O que entregar**
- Relatório ZAP Baseline (`reports/zap/zap-baseline.html`) com *evidências* dos achados.
- Lista dos **payloads** (já incluída no HTML) e *mitigações* (descrever no template `docs/relatorio-dast.md`).

**Como gerar**
```bash
docker compose up -d juice-shop
./scripts/run_zap_baseline.sh http://localhost:3000
docker compose down
```

**Onde ficam os arquivos**: `reports/zap/`.

---

## 3) SCA – Análise de Componentes de Terceiros – Peso 1,5

**O que entregar**
- Relatório do Dependency-Check (`reports/dependency-check/dependency-check-report.html`).  
- (Opcional) Relatório Snyk (`reports/snyk/snyk.json` + export).

**Como gerar**
```bash
./scripts/run_dependency_check.sh
# (Opcional) Snyk (requer token)
./scripts/run_snyk.sh
```

---

## 4) Integração & Monitoramento no CI/CD – Peso 3,0

**O que entregar**
- Documento `docs/pipeline-doc.md` preenchido com *prints* da execução do pipeline, *políticas* e exemplos de *gates*.  
- YAML do workflow em `.github/workflows/security-pipeline.yml`.
- (Opcional) Prints do dashboard do SonarQube/ZAP.

**Como preencher**
1. Execute o pipeline (push/PR).
2. Baixe artefatos gerados pelo workflow (Actions → run → Artifacts).
3. Cole *screenshots* e links no `docs/pipeline-doc.md`.

---

## Dicas de apresentação
- Resuma os **achados críticos** em 5 bullets com responsáveis e prazos.  
- Anexe os **relatórios em HTML** na submissão (ou compacte com `./scripts/package_reports.sh`).


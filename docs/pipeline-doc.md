# Documentação do Pipeline CI/CD de Segurança

**Repositório:** `lucca0100/cicd-security-starter`
**Pipeline:** `.github/workflows/security-pipeline.yml`

O pipeline foi configurado para rodar **três etapas principais de segurança**:

1. **SAST (Static Application Security Testing)** – análise estática do código-fonte com **Semgrep**.
2. **SCA (Software Composition Analysis)** – análise de bibliotecas e dependências com **OWASP Dependency-Check**.
3. **DAST (Dynamic Application Security Testing)** – teste dinâmico em tempo de execução com **OWASP ZAP Baseline**.

## Execuções do Pipeline

### 1. **SAST – Semgrep**
**Ferramenta:** `returntocorp/semgrep`
**Configs usadas:** `p/owasp-top-ten` e `p/java`
**Saídas geradas:**
   `reports/semgrep/semgrep.sarif`
   `reports/semgrep/semgrep.json`

[Evidência semgrep](image.png)


### 2. **SCA – OWASP Dependency-Check**
**Ferramenta:** `owasp/dependency-check:latest`
**Base de dados:** NVD (National Vulnerability Database), CISA Known Exploited, GitHub Advisory Database.
**Saídas geradas:**
  `reports/dependency-check/dependency-check-report.html`

[SCA evidência](image-1.png)


### 3. **DAST – OWASP ZAP Baseline**
**Ferramenta:** `zaproxy/zap-baseline`
**Alvo analisado:** `http://localhost:3000` (Juice Shop)
**Configuração:** baseline + arquivo `config/zap/zap-baseline.conf`
**Saídas geradas:**
   `reports/zap/zap-baseline.html`
   `reports/zap/zap-report.xml`

[DAST evidências](image-2.png)


## Conclusão

O pipeline CI/CD de segurança foi implementado com sucesso e roda automaticamente a cada push na branch main.  
As três frentes de segurança foram contempladas:

**SAST:** Nenhuma falha crítica encontrada no código.
**SCA:** Projeto sem dependências vulneráveis no momento.
**DAST:** Achados típicos do Juice Shop (falta de cabeçalhos HTTP e cookies inseguros).


## Evidências
Todos os relatórios estão disponíveis na pasta `/reports`:
`reports/semgrep/`
`reports/dependency-check/`
`reports/zap/`

arquivo ZIP consolidado gerado automaticamente para entrega:

`reports-YYYYMMDD-HHMMSS.zip`

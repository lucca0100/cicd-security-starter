## Equipe:
**Vitor Santana - RM: 99586**
**Lucca Alexandre - RM: 99700**
**Victor Wittner - RM: 98667**
**Matheus Haruo - RM: 97663**
**João Saborido - RM 98184**

## Como usar 

1. **Pré-requisitos**: Docker, Docker Compose, Git, Java 17, Maven 3.9+, Python 3.10+ (opcional para zip dos relatórios).
2. **Executar local** (gera relatórios em `reports/`):
   ```bash
   chmod +x scripts/*.sh
   ./scripts/run_semgrep.sh
   ./scripts/run_dependency_check.sh
   # Sobe app vulnerável Juice Shop e roda DAST (ZAP Baseline) contra http://localhost:3000
   docker compose up -d juice-shop
   ./scripts/run_zap_baseline.sh http://localhost:3000
   docker compose down
   
3. **Pipeline GitHub Actions**: faça fork/commit e habilite *Actions*.
   - Ajuste *secrets* conforme necessário (ex.: `SONAR_TOKEN`, `SNYK_TOKEN`, `ZAP_TARGET_URL` se quiser usar um alvo externo).
4. **Entregáveis**: veja `docs/ENTREGAVEIS.md`.



## Estrutura


app/                         # App Java exemplo (Maven)
config/                      # Configs dos scanners
docs/                        # Modelos e documentação
scripts/                     # Scripts para executar os scanners e consolidar relatórios
.github/workflows/           # Pipeline de CI/CD
docker-compose.yml           # Alvos de teste (Juice Shop) e SonarQube opcional



## Ferramentas

- **SAST**: Semgrep (action oficial). SonarQube opcional (via Docker + token).  
- **DAST**: OWASP ZAP Baseline (Docker).  
- **SCA**: OWASP Dependency-Check (local/CI) e Snyk opcional (se tiver token).

Cada ferramenta coloca artefatos em `reports/<ferramenta>/...`

## Política de bloqueio (exemplo)

**Falhas críticas/alta** em SAST/SCA/DAST **bloqueiam** o *merge* (saída não-zero).  
**Médias** geram alerta, **baixas** apenas log.  
Você pode ajustar os limiares em `scripts/*.sh` e nos *jobs* do workflow.



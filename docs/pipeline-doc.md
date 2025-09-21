# Documentação do Pipeline CI/CD de Segurança

## Visão Geral
- Repositório: `<seu-repo>`
- Pipeline: `.github/workflows/security-pipeline.yml`
- Estratégia: Jobs paralelos para SAST, SCA e DAST; gates de severidade.

## Gatilhos
- `push` e `pull_request` em `main` + `feature/*`.

## Políticas de Segurança
- Bloqueio em severidade **CRITICAL/HIGH** (ajustável).
- Upload de artefatos por job.

## Execuções (prints)
- Inclua screenshots das execuções (Actions → Jobs).
- Inclua o Quality Gate do Sonar (opcional).

## Alertas e Notificações
- Exemplos de logs e falhas do job quando encontra **CRITICAL**.

## Melhorias Futuras
- Burp automation, ZAP full scan, integração com DefectDojo, canais Slack/Teams.

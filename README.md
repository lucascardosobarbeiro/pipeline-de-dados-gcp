# Pipeline de Dados GCP

Pipeline serverless que processa arquivos JSON enviados para um bucket, utilizando:

- Cloud Storage
- Pub/Sub
- Cloud Functions
- BigQuery
- Terraform
- GitHub Actions (CI/CD)

## Como usar

1. Clone o repositório
2. Configure `secrets.GCLOUD_CREDENTIALS` no GitHub com sua service account
3. Faça push para o branch `main`

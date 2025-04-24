

# Projeto de Pipeline de Dados na GCP

Este projeto é um pipeline de dados implementado na Google Cloud Platform (GCP), utilizando os serviços Pub/Sub, Cloud Functions e Cloud Storage. O objetivo é processar mensagens publicadas em um tópico Pub/Sub e armazenar os dados processados em um bucket do Cloud Storage.

## Tecnologias Utilizadas
- **Google Cloud Pub/Sub**: Sistema de mensagens assíncronas que permite comunicação entre sistemas distribuídos.
- **Google Cloud Functions**: Função serverless que processa dados enviados para o Pub/Sub e os armazena em um bucket.
- **Google Cloud Storage**: Armazenamento de arquivos na nuvem para salvar os dados processados.
- **Terraform**: Ferramenta para infraestrutura como código (IaC), usada para provisionar e configurar os recursos na GCP.

## Visão Geral do Fluxo

1. **Publicação de Mensagens no Pub/Sub**: Uma mensagem é publicada no tópico Pub/Sub `data-topic` com os dados de entrada.
2. **Cloud Function (process_json)**: Uma função serverless é acionada pelo evento do Pub/Sub. A função processa a mensagem recebida e armazena os dados em um arquivo.
3. **Armazenamento no Cloud Storage**: A Cloud Function grava os dados processados em um arquivo dentro do bucket `pipeline-dados-gcp-data-bucket`.

## Estrutura do Projeto

Abaixo estão os principais arquivos e recursos criados para implementar o pipeline de dados:

### 1. **Infraestrutura (Terraform)**

A infraestrutura foi provisionada utilizando o **Terraform**. Os recursos criados incluem:

- **Pub/Sub Topic**: `data-topic`
- **Pub/Sub Subscription**: `data-subscription`
- **Bucket do Cloud Storage**: `pipeline-dados-gcp-data-bucket`
- **Cloud Function**: `process_json`

#### Arquivos de Configuração Terraform
- **`main.tf`**: Define os recursos principais do projeto, como o bucket e o tópico Pub/Sub.
- **`cloud_function.tf`**: Define a função do Google Cloud Functions, incluindo a trigger do Pub/Sub e o armazenamento no bucket.
- **`variables.tf`**: Define as variáveis usadas para o projeto, como `project_id` e `region`.
- **`outputs.tf`**: Define as saídas do Terraform, como os nomes do bucket e do tópico Pub/Sub.

### 2. **Cloud Function** (process_json)

A Cloud Function `process_json` foi desenvolvida para processar a mensagem recebida no Pub/Sub e gravar os dados no Cloud Storage.

A função executa as seguintes ações:
- **Entrada**: Recebe uma mensagem do Pub/Sub no formato JSON.
- **Processamento**: Processa os dados (no exemplo, apenas um log da mensagem recebida).
- **Saída**: Armazena os dados processados em um arquivo dentro do bucket `pipeline-dados-gcp-data-bucket`.

O código da função está localizado no diretório `functions/process_json`. Ele foi compactado em um arquivo zip (`process_json.zip`) e carregado no bucket de origem para ser utilizado na criação da função.

### 3. **Deploy e Execução**

1. **Autenticação**: O usuário autenticado no GCP utilizando `gcloud auth login` para garantir que o Terraform e as ferramentas da Google Cloud funcionem corretamente.
2. **Provisionamento de Infraestrutura**: Os recursos foram provisionados e configurados utilizando o Terraform, aplicando as configurações definidas nos arquivos `.tf`.
3. **Publicação de Mensagens no Pub/Sub**: A publicação de mensagens foi feita utilizando o comando `gcloud pubsub topics publish`, que disparou a execução da função.

### 4. **Testes**

Após o deploy, realizamos testes publicando mensagens no tópico Pub/Sub e verificando se as mensagens eram processadas corretamente pela Cloud Function, com os dados sendo salvos no bucket `pipeline-dados-gcp-data-bucket`.

### 5. **Problemas Resolvidos**
- **Erro de Permissões IAM**: Durante o processo de deploy, foi necessário garantir que o serviço tivesse as permissões corretas para interagir com outros recursos do GCP (por exemplo, acesso ao Cloud Build).
- **Erro de Arquivo ZIP Inválido**: Durante a criação da Cloud Function, houve um erro relacionado ao formato do arquivo ZIP. Isso foi corrigido gerando o arquivo corretamente no Visual Studio Code.



## Conclusão

Este projeto demonstra a integração entre os serviços Pub/Sub, Cloud Functions e Cloud Storage da Google Cloud Platform. A arquitetura é simples, escalável e fácil de manter, utilizando o poder do Terraform para provisionamento de infraestrutura como código. O fluxo de dados entre os serviços foi testado com sucesso, e os dados foram processados e armazenados no bucket como esperado.

---

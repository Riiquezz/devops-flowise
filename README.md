# Projeto: Infraestrutura para IA com Flowise

Bem-vindo ao projeto de infraestrutura para IA utilizando o Flowise! Este projeto foi criado para atender aos requisitos de uma arquitetura segura, escalável e de alta disponibilidade, utilizando as melhores práticas de DevOps e MLOps. A infraestrutura foi provisionada na AWS utilizando Terraform, Kubernetes, e integrações com serviços de monitoramento e segurança.

---

## **Principais Componentes da Arquitetura**

### **1. Infrastructure as Code (IaC)**
- Toda a infraestrutura foi provisionada utilizando Terraform.
- Arquitetura modular com suporte a migração para Azure ou GCP.

### **2. Containerization and Orchestration**
- A aplicação Flowise foi conteinerizada usando Docker.
- Kubernetes (EKS) foi configurado para orquestração de contêineres, com suporte a autoescalonamento.

### **3. Banco de Dados**
- Banco de dados gerenciado RDS PostgreSQL.
- Backups automatizados com plano de recuperação detalhado.

### **4. Armazenamento**
- Amazon S3 utilizado para armazenar artefatos, modelos de IA e backups.
- Regras de ciclo de vida configuradas para arquivamento de longo prazo.

### **5. Segurança**
- VPC configurada com sub-redes públicas e privadas.
- WAF (Web Application Firewall) para proteger contra ameaças.
- Grupos de segurança para proteger EKS, RDS e outros componentes.

### **6. CI/CD**
- Pipeline de CI/CD implementado no GitHub Actions:
  - Construção e publicação de imagens Docker.
  - Provisionamento da infraestrutura via Terraform.
  - Implantação automática no Kubernetes.

### **7. Observabilidade**
- Integração com Datadog para monitoramento e rastreamento de logs.
- Dashboards configurados para CPU, memória e métricas específicas da aplicação.

### **8. Alta Disponibilidade**
- Cluster Kubernetes distribuído em múltiplas zonas de disponibilidade.
- ALB (Application Load Balancer) configurado para balanceamento de carga.

### **9. Backup e Recuperação de Desastres**
- Plano completo para recuperação de dados do RDS e S3.
- Procedimento documentado para restaurar a infraestrutura.

---

## **Pré-requisitos**
Antes de iniciar, certifique-se de ter os seguintes itens instalados e configurados:

1. **Ferramentas:**
   - Terraform (v1.4 ou superior)
   - Docker
   - AWS CLI configurado com as credenciais
   - `kubectl` configurado para acessar o cluster Kubernetes

2. **Permissões:**
   - Acesso à AWS com permissões para gerenciar VPC, EKS, RDS, S3, WAF e outros recursos.

---

## **Como Iniciar o Projeto**

### **1. Configurar Variáveis**
- Se o pipeline CI/CD já está configurado, o arquivo `terraform.tfvars` será gerado automaticamente.
- Caso precise configurar manualmente:
  1. Crie o arquivo `iac/terraform/terraform.tfvars`.
  2. Adicione as variáveis do seu ambiente (exemplo na documentação do Terraform).

### **2. Provisionar Infraestrutura**
- Inicialize o Terraform:
  ```bash
  terraform init
  ```
- Planeje as mudanças:
  ```bash
  terraform plan
  ```
- Aplique a infraestrutura:
  ```bash
  terraform apply
  ```

### **3. Implantação da Aplicação**
- Construa e publique a imagem Docker:
  ```bash
  docker build -t <seu-repo>/flowise:latest .
  docker push <seu-repo>/flowise:latest
  ```
- Certifique-se de que o contexto do cluster Kubernetes está configurado:
  ```bash
  aws eks update-kubeconfig --region <AWS_REGION> --name <CLUSTER_NAME>
  ```
- Aplique os manifestos Kubernetes:
  ```bash
  kubectl apply -f containerization/k8s/
  ```

### **4. Monitoramento e Observabilidade**
- Execute o script de deploy do dashboard no Datadog:
  ```bash
  bash observability/deploy_dashboard.sh
  ```
- Acesse o Datadog para visualizar dashboards e logs configurados.

### **5. Recuperação de Desastres**
- Consulte o documento `docs/backup-recovery.md` para detalhes sobre como restaurar dados e infraestrutura.

---

## **Gerenciando Múltiplos Ambientes**
O pipeline CI/CD suporta múltiplos ambientes (ex.: staging e production). Certifique-se de configurar as variáveis necessárias no repositório:
- `EKS_CLUSTER_NAME`
- `RDS_PASSWORD`
- `DATADOG_API_KEY`
- E outras listadas no arquivo de exemplo `terraform.tfvars`.

Para alterar o ambiente, edite a matriz no pipeline CI/CD.

---

## **Contribuições**
Sinta-se à vontade para contribuir com melhorias para este projeto! Envie um pull request ou abra uma issue no repositório.

---

## **Licença**
Este projeto está licenciado sob a Licença MIT. Consulte o arquivo `LICENSE` para mais detalhes.

# Observability Documentation

Este documento descreve as configurações de monitoramento e rastreamento implementadas no projeto utilizando o Datadog. Inclui informações sobre dashboards, logs, métricas e alertas configurados.

---

## **1. Configuração do Datadog**

### **1.1. Integração com AWS**
O Datadog foi integrado à AWS para monitorar recursos como EKS, RDS e S3.
- Foi criada uma IAM Role com permissões para o Datadog acessar os recursos da AWS.
- Terraform foi utilizado para configurar a integração automaticamente.

### **1.2. Configuração do Agente Datadog**
O agente do Datadog foi instalado nos pods do cluster EKS para coletar logs e métricas:
- O manifesto do Kubernetes inclui a configuração do agente Datadog como um DaemonSet.
- Configurações relevantes:
  - Coleta de logs do aplicativo Flowise.
  - Coleta de métricas como uso de CPU, memória e latência.

---

## **2. Dashboards Configurados**

### **2.1. Dashboard Principal**
O dashboard principal foi projetado para monitorar a aplicação Flowise e os recursos subjacentes.

#### **Métricas Incluídas:**
- **EKS:**
  - Uso de CPU e memória por pod.
  - Status de pods e nós.
- **RDS:**
  - Latência de consultas.
  - Conexões ativas.
- **S3:**
  - Operações de leitura e escrita.
  - Taxa de erros.

#### **Localização do Arquivo**:
O JSON de configuração do dashboard está localizado em `observability/dashboards/flowise_dashboard.json`.

---

## **3. Logs e Rastreabilidade**

### **3.1. Coleta de Logs**
Os logs do aplicativo Flowise e dos pods Kubernetes são coletados pelo Datadog:
- Logs de erro e depuração.
- Logs de acesso à API.

### **3.2. Configuração de Filtragem**
Os logs foram configurados com filtros para capturar apenas eventos relevantes:
- **Filtros Incluídos:**
  - Erros HTTP 4xx e 5xx.
  - Latência superior a 500ms.

---

## **4. Alertas Configurados**

### **4.1. Alertas de Infraestrutura**
Alertas criados para monitorar anomalias nos recursos:
- **EKS:**
  - Uso de CPU acima de 80% por mais de 5 minutos.
  - Falha de pods em reiniciar.
- **RDS:**
  - Latência acima de 100ms.
  - Taxa de conexões ativas maior que 90% da capacidade.

### **4.2. Alertas de Aplicativo**
- Erros HTTP 5xx superiores a 5%.
- Latência de resposta acima de 1s.

### **4.3. Notificações**
As notificações dos alertas são enviadas via:
- **Slack:** Para alertar a equipe em tempo real.
- **E-mail:** Para registro e comunicação.

---

## **5. Scripts Auxiliares**

### **5.1. Deploy do Dashboard**
Um script foi criado para aplicar o JSON do dashboard no Datadog automaticamente:

#### **Arquivo: `observability/deploy_dashboard.sh`**

---

## **6. Passos para Verificação**

1. Acesse o Datadog e confirme a presença do dashboard configurado.
2. Verifique as métricas em tempo real e os logs coletados.
3. Teste os alertas configurados simulando condições de erro ou alta carga.

---

## **Conclusão**
Este sistema de observabilidade garante que os recursos e a aplicação sejam monitorados em tempo real, permitindo detecção e resolução rápidas de problemas. Para melhorias futuras, considere integrações adicionais com ferramentas como Prometheus ou Grafana.


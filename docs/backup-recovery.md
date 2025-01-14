# Backup and Disaster Recovery Plan

Este documento descreve o plano de backup e recuperação de desastres para a infraestrutura do projeto, garantindo que os dados e os serviços críticos possam ser restaurados rapidamente em caso de falha.

---

## **1. Introdução**
A infraestrutura suporta operações críticas que incluem:
- Banco de dados RDS PostgreSQL para armazenar dados do Flowise.
- Armazenamento no S3 para artefatos, backups e modelos de IA.
- Cluster EKS para orquestrar os contêineres.
Este plano documenta estratégias para proteger e restaurar esses componentes essenciais.

---

## **2. Banco de Dados (RDS PostgreSQL)**

### **2.1. Estratégia de Backup**
- **Automated Backups**: Configurado para retenção de 7 dias usando snapshots automáticos.
- **Snapshots Manuais**: Criados antes de atualizações críticas.

### **2.2. Localização dos Backups**
- Backups são armazenados automaticamente pela AWS e podem ser acessados via console ou CLI.

### **2.3. Processo de Restauração**
#### **Pelo Console AWS:**
1. Acesse o console AWS e vá para a página **RDS**.
2. Clique em **Snapshots** e selecione o snapshot desejado.
3. Clique em **Restore DB Instance**.
4. Escolha o nome para a nova instância e revise as configurações.
5. Finalize a restauração clicando em **Restore**.

#### **Pelo AWS CLI:**
```bash
aws rds restore-db-instance-from-db-snapshot \
    --db-instance-identifier <new-db-instance-name> \
    --db-snapshot-identifier <snapshot-id>
```

#### **Após a Restauração:**
- Atualize as variáveis de ambiente ou configurações para apontar para a nova instância do banco.

---

## **3. Armazenamento no S3**

### **3.1. Estratégia de Backup**
- **Versão de Objetos**: A versão de objetos no S3 está ativada, garantindo que versões anteriores sejam mantidas.
- **Regras de Ciclo de Vida**: Objetos são arquivados para o Glacier após 30 dias.

### **3.2. Processo de Recuperação**
#### **Restaurar Objetos do Glacier**
1. Vá ao console AWS e navegue até o bucket S3.
2. Localize o objeto arquivado e clique em **Restore**.
3. Escolha o número de dias para restaurar e confirme.

#### **Pelo AWS CLI:**
```bash
aws s3api restore-object \
    --bucket <bucket-name> \
    --key <object-key> \
    --restore-request '{"Days":7}'
```

---

## **4. Kubernetes (EKS)**

### **4.1. Estratégia de Alta Disponibilidade**
- O cluster EKS está distribuído em múltiplas Zonas de Disponibilidade (AZs).
- Grupos de Auto Scaling estão configurados para substituir nós automaticamente em caso de falha.

### **4.2. Restauração de Pods**
1. Use o comando `kubectl` para verificar o status dos pods:
   ```bash
   kubectl get pods -n <namespace>
   ```
2. Se necessário, reinicie os pods:
   ```bash
   kubectl rollout restart deployment <deployment-name>
   ```

### **4.3. Recuperação do Cluster**
Caso o cluster seja comprometido, siga os passos abaixo:

1. Restaure o estado desejado do cluster usando o Terraform:
   ```bash
   terraform apply
   ```
2. Reimplante os manifestos do Kubernetes:
   ```bash
   kubectl apply -f k8s/deployment.yaml
   kubectl apply -f k8s/service.yaml
   kubectl apply -f k8s/hpa.yaml
   ```

---

## **5. Rede e Segurança**

### **5.1. Estratégia de Proteção**
- Grupos de segurança e ACLs configurados para proteger o tráfego.
- WAF (Web Application Firewall) para mitigar ataques comuns.

### **5.2. Recuperação do WAF**
Caso o WAF seja comprometido:

1. Restaure a configuração do WAF com Terraform:
   ```bash
   terraform apply -target=aws_wafv2_web_acl.main
   ```

---

## **6. Procedimento de Teste**
Realize testes regulares para garantir que o plano de backup e recuperação funcione conforme esperado.

### **6.1. Teste do Backup do RDS**
1. Crie um snapshot manual.
2. Restaure o snapshot em um ambiente de teste.
3. Valide a integridade dos dados na instância restaurada.

### **6.2. Teste do Backup do S3**
1. Arquive um objeto manualmente.
2. Restaure o objeto em um ambiente de teste.
3. Valide a acessibilidade do objeto restaurado.

### **6.3. Teste do EKS**
1. Simule a falha de um nó no cluster.
2. Verifique se os pods são redistribuídos automaticamente.
3. Valide que os serviços permanecem acessíveis.

---

## **7. Responsabilidades**

### **7.1. Backup**
- O DevOps Team é responsável por monitorar e validar backups regulares.

### **7.2. Recuperação**
- O Incident Response Team é responsável por executar o plano de recuperação em caso de falha.

---

## **8. Conclusão**
Este plano garante que dados críticos e serviços possam ser recuperados com rapidez e eficiência. Recomendamos revisões regulares e melhorias contínuas para adaptar o plano a novos requisitos e tecnologias.


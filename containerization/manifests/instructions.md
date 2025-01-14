# Instruções de Uso: Istio e Argo CD

Este documento explica como implementar e usar o **Istio** e o **Argo CD** no cluster Kubernetes. Ele cobre os passos para aplicação dos manifestos, verificação das implementações, e uso básico de ambas as ferramentas.

---

## **1. Implementando o Argo CD**

### **1.1. Passos para Instalação**
1. **Criar o namespace do Argo CD:**
   ```bash
   kubectl apply -f manifests/argo-cd/argo-cd-namespace.yaml
   ```

2. **Instalar o Argo CD:**
   ```bash
   kubectl apply -f manifests/argo-cd/argo-cd-install.yaml
   ```

3. **Configurar a aplicação Flowise no Argo CD:**
   ```bash
   kubectl apply -f manifests/argo-cd/argo-cd-app.yaml
   ```

### **1.2. Acessando o Painel do Argo CD**
1. **Port Forward para acessar o painel:**
   ```bash
   kubectl port-forward svc/argocd-server -n argocd 8080:443
   ```

2. **Acessar o painel via navegador:**
   - URL: `http://localhost:8080`

3. **Credenciais de Login:**
   - **Usuário:** `admin`
   - **Senha:** Execute o comando abaixo para obter a senha:
     ```bash
     kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d
     ```

### **1.3. Verificando a Sincronização da Aplicação**
1. No painel do Argo CD, localize a aplicação `flowise`.
2. Verifique o status da aplicação:
   - Status: `Synced` indica que a aplicação está em conformidade com os manifestos no Git.
3. Para sincronizar manualmente, clique em **"Sync"** no painel.

---

## **2. Implementando o Istio**

### **2.1. Passos para Instalação**
1. **Instalar o operador do Istio:**
   ```bash
   kubectl apply -f manifests/istio/istio-operator.yaml
   ```

2. **Habilitar a injeção automática de sidecar no namespace:**
   ```bash
   kubectl apply -f manifests/istio/istio-sidecar-injection.yaml
   ```

3. **Configurar o Gateway e VirtualService:**
   ```bash
   kubectl apply -f manifests/istio/istio-gateway.yaml
   ```

### **2.2. Verificando a Instalação do Istio**
1. **Verifique os pods do Istio no namespace `istio-system`:**
   ```bash
   kubectl get pods -n istio-system
   ```
   - Certifique-se de que todos os pods estão no estado `Running`.

2. **Verifique o gateway:**
   ```bash
   kubectl get svc istio-ingressgateway -n istio-system
   ```
   - Copie o **External IP** ou **LoadBalancer IP** para acessar a aplicação.

### **2.3. Testando a Aplicação via Istio Gateway**
1. Acesse o Gateway pelo navegador ou via `curl`:
   ```bash
   curl -X GET http://<EXTERNAL_IP>
   ```
   - Substitua `<EXTERNAL_IP>` pelo IP obtido na etapa anterior.

2. A aplicação Flowise deve estar acessível através do Istio Gateway.

---

## **3. Recomendações Gerais**

### **3.1. Gerenciamento do Argo CD**
- Sempre faça commits no repositório Git antes de sincronizar a aplicação no Argo CD.
- Use "Applications" no painel para gerenciar os diferentes componentes do sistema.

### **3.2. Gerenciamento do Istio**
- Use o `kubectl` para monitorar as configurações de Gateway e VirtualService.
- Certifique-se de que as políticas de segurança estão configuradas corretamente, especialmente ao expor serviços sensíveis.

---

## **4. Debugging e Troubleshooting**

### **4.1. Argo CD**
- Para verificar logs do Argo CD:
  ```bash
  kubectl logs -n argocd -l app.kubernetes.io/name=argocd-server
  ```
- Problemas de sincronização podem ser resolvidos diretamente pelo painel ou ajustando os manifestos no Git.

### **4.2. Istio**
- Para verificar logs do Gateway do Istio:
  ```bash
  kubectl logs -n istio-system -l app=istio-ingressgateway
  ```
- Certifique-se de que os VirtualServices e Gateways estejam corretamente configurados:
  ```bash
  kubectl describe virtualservice flowise-service
  kubectl describe gateway flowise-gateway
  ```

---

## **5. Conclusão**
Com estas instruções, você pode implementar e usar o Istio e o Argo CD para gerenciar sua infraestrutura Kubernetes. Certifique-se de testar as configurações após aplicar os manifestos e monitorar regularmente os recursos para garantir que estejam funcionando conforme o esperado.

Se precisar de suporte adicional, consulte a documentação oficial do [Argo CD](https://argo-cd.readthedocs.io) e [Istio](https://istio.io).


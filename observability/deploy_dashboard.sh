#!/bin/bash

# Configurações
API_KEY="<SEU_API_KEY>"
APP_KEY="<SEU_APP_KEY>"
DASHBOARD_FILE="observability/dashboards/flowise_dashboard.json"

# Verificar se o arquivo existe
if [ ! -f "$DASHBOARD_FILE" ]; then
  echo "Erro: O arquivo do dashboard '$DASHBOARD_FILE' não foi encontrado."
  exit 1
fi

# Deploy do Dashboard
response=$(curl -s -o /dev/null -w "%{http_code}" -X POST \
    -H "Content-Type: application/json" \
    -H "DD-API-KEY: $API_KEY" \
    -H "DD-APPLICATION-KEY: $APP_KEY" \
    -d @$DASHBOARD_FILE \
    "https://api.datadoghq.com/api/v1/dashboard")

# Validar resposta
if [ "$response" -eq 200 ]; then
  echo "Dashboard implementado com sucesso no Datadog!"
else
  echo "Erro ao implementar o dashboard. HTTP Status: $response"
  exit 1
fi

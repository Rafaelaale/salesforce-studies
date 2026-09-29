import requests
import json

url = 'http://127.0.0.1:5000/prever'
headers = {'Content-Type': 'application/json'}

# Dados de exemplo para enviar à API
# Estes valores devem corresponder às features que seu modelo espera
data = {
    'Recursos_Marketing': 250,
    'Eventos_Promocionais': 2,
    'Historico_Vendas_Mes_Anterior': 750
}

response = requests.post(url, headers=headers, data=json.dumps(data))

if response.status_code == 200:
    print("Previsão recebida com sucesso:")
    print(response.json())
else:
    print(f"Erro na requisição: {response.status_code}")
    print(response.json())
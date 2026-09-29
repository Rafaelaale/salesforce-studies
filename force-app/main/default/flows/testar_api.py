import json
import urllib.error
import urllib.request

url = 'http://127.0.0.1:5000/prever'
headers = {'Content-Type': 'application/json'}

# Dados de exemplo para enviar à API
# Estes valores devem corresponder às features que seu modelo espera
data = {
    'Recursos_Marketing': 250,
    'Eventos_Promocionais': 2,
    'Historico_Vendas_Mes_Anterior': 750
}

request = urllib.request.Request(
    url,
    data=json.dumps(data).encode('utf-8'),
    headers=headers,
    method='POST'
)

try:
    with urllib.request.urlopen(request) as response:
        print("Previsão recebida com sucesso:")
        print(json.loads(response.read().decode('utf-8')))
except urllib.error.HTTPError as error:
    print(f"Erro na requisição: {error.code}")
    print(error.read().decode('utf-8'))
except urllib.error.URLError as error:
    print(f"Falha ao conectar à API: {error.reason}")
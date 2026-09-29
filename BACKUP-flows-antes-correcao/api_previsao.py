from flask import Flask, request, jsonify
import joblib
import pandas as pd
from pathlib import Path


app = Flask(__name__)

# Carregar o modelo treinado
model_path = Path(__file__).resolve().parent / 'modelo_previsao_demanda.pkl'
try:
    modelo = joblib.load(model_path)
except FileNotFoundError:
    raise SystemExit(f"Erro: modelo não encontrado em {model_path}. Execute treinar_modelo_demanda.py primeiro.")

@app.route('/prever', methods=['POST'])
def prever_demanda():
    try:
        dados = request.get_json(force=True)
        is_batch = isinstance(dados, list)
        linhas = dados if is_batch else [dados]
        if not linhas or not all(isinstance(linha, dict) for linha in linhas):
            return jsonify({'error': 'Informe um objeto ou uma lista de objetos.'}), 400

        df_dados = pd.DataFrame(linhas)

        # Assegurar que as colunas estão na ordem correta e com os nomes esperados pelo modelo
        # Ajuste estas colunas para corresponder exatamente às features que seu modelo espera
        features = ['Recursos_Marketing', 'Eventos_Promocionais', 'Historico_Vendas_Mes_Anterior']
        df_dados = df_dados[features]

        predictions = modelo.predict(df_dados)
        resultados = [{'previsao': float(prediction)} for prediction in predictions]
        return jsonify(resultados if is_batch else resultados[0])
    except Exception as e:
        return jsonify({'error': str(e)}), 400

if __name__ == '__main__':
    app.run(host='127.0.0.1', debug=False, port=5000)

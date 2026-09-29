from flask import Flask, request, jsonify
import joblib
import pandas as pd

app = Flask(__name__)

# Carregar o modelo treinado
try:
    model = joblib.load('modelo_previsao_demanda.joblib')
except FileNotFoundError:
    print("Erro: O arquivo 'modelo_previsao_demanda.joblib' não foi encontrado.")
    print("Certifique-se de que o modelo foi treinado e salvo na mesma pasta da API.")
    model = None # Define model como None para evitar erros posteriores

@app.route('/predict', methods=['POST'])
def predict():
    if model is None:
        return jsonify({'error': 'Modelo de previsão não carregado. Verifique os logs do servidor.'}), 500
try:
    data = request.get_json(force=True)
    # Supondo que os dados de entrada virão em um formato que o modelo espera
    # Por exemplo: {'Recursos_Marketing': 1000, 'Eventos_Promocionais': 1, 'Historico_Vendas_Mes_Anterior': 500}
    df = pd.DataFrame([data])
    prediction = model.predict(df)
    return jsonify({'previsao_demanda': prediction[0]})
except Exception as e:
    return jsonify({'error': str(e)}), 400
if __name__ == '__main__':
    app.run(debug=True) 
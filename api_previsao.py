from flask import Flask, request, jsonify
import joblib
import pandas as pd
from pathlib import Path

app = Flask(__name__)

BASE_DIR = Path(__file__).resolve().parent
MODEL_PATH = BASE_DIR / "python-ml" / "modelo_previsao_demanda.pkl"

try:
    model = joblib.load(MODEL_PATH)
    print(f"Modelo carregado: {MODEL_PATH}")
except Exception as e:
    print(f"Erro ao carregar modelo: {e}")
    model = None


@app.route("/", methods=["GET"])
def home():
    return jsonify({
        "status": "API ativa",
        "modelo": "Previsao de Demanda"
    })


@app.route("/predict", methods=["POST"])
def predict():
    if model is None:
        return jsonify({
            "error": "Modelo de previsao nao carregado."
        }), 500

    try:
        data = request.get_json(force=True)

        features = [
            "Recursos_Marketing",
            "Eventos_Promocionais",
            "Historico_Vendas_Mes_Anterior"
        ]

        df = pd.DataFrame([data], columns=features)

        prediction = model.predict(df)

        return jsonify({
            "previsao_demanda": float(prediction[0])
        })

    except Exception as e:
        return jsonify({
            "error": str(e)
        }), 400


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8000, debug=True)

import pandas as pd
from sklearn.linear_model import LinearRegression
import joblib
from pathlib import Path

base_dir = Path(__file__).resolve().parent
data_candidates = [
    base_dir / 'dados_demanda_processados.csv',
    base_dir.parents[3] / 'dados_demanda_processados.csv'
]
data_path = next((path for path in data_candidates if path.is_file() and path.stat().st_size > 0), None)

# Carregar os dados processados
try:
    if data_path is None:
        raise FileNotFoundError
    df = pd.read_csv(data_path)
    print("DataFrame 'dados_demanda_processados.csv' carregado com sucesso.")
except FileNotFoundError:
    print("Erro: 'dados_demanda_processados.csv' não encontrado. Por favor, execute 'gerar_dados_exemplo.py' primeiro.")
    exit()

# Definir as features (variáveis de entrada) e o target (variável a ser prevista)
features = ['Recursos_Marketing', 'Eventos_Promocionais', 'Historico_Vendas_Mes_Anterior']
X = df[features]
# CORREÇÃO: Usar 'Demanda_Real' como a coluna alvo
y = df['Demanda_Real']

# Treinar um modelo de Regressão Linear
model = LinearRegression()
model.fit(X, y)

# Salvar o modelo no mesmo diretório e com o nome usado pela API
model_path = base_dir / 'modelo_previsao_demanda.pkl'
joblib.dump(model, model_path)

print(f"Modelo '{model_path.name}' criado e salvo em {model_path}.")
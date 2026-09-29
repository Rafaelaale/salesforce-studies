import pandas as pd
from sklearn.linear_model import LinearRegression
import joblib

# Dados de exemplo para treinar um modelo simples
# Estes dados simulam as entradas que sua API espera
data = {
    'Recursos_Marketing': [100, 150, 200, 250, 300, 120, 180, 220, 280, 350],
    'Eventos_Promocionais': [1, 2, 1, 3, 2, 1, 2, 2, 3, 4],
    'Historico_Vendas_Mes_Anterior': [500, 600, 700, 800, 900, 550, 650, 750, 850, 950],
    'Demanda_Real': [1000, 1200, 1400, 1600, 1800, 1100, 1300, 1500, 1700, 1900]
}
df = pd.DataFrame(data)

# Definir as features (variáveis de entrada) e o target (variável a ser prevista)
features = ['Recursos_Marketing', 'Eventos_Promocionais', 'Historico_Vendas_Mes_Anterior']
X = df[features]
y = df['Demanda_Real']

# Treinar um modelo de Regressão Linear simples
model = LinearRegression()
model.fit(X, y)

# Salvar o modelo treinado no formato .pkl
# O nome do arquivo deve ser 'modelo_previsao_demanda.pkl'
joblib.dump(model, 'modelo_previsao_demanda.pkl')

print("Modelo 'modelo_previsao_demanda.pkl' criado e salvo com sucesso na pasta C:\\Users\\rafal\\Desktop\\salesforce-studies.")
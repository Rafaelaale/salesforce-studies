import pandas as pd
import numpy as np

# Gerar dados de exemplo para simular dados de demanda processados
np.random.seed(42) # Para reprodutibilidade

num_samples = 100

data = {
    'Recursos_Marketing': np.random.randint(50, 500, num_samples),
    'Eventos_Promocionais': np.random.randint(0, 5, num_samples),
    'Historico_Vendas_Mes_Anterior': np.random.randint(200, 2000, num_samples),
    'Demanda_Real': np.random.randint(1000, 5000, num_samples) + np.random.randint(50, 500, num_samples)
}

df_dados = pd.DataFrame(data)

# Salvar os dados em um arquivo CSV
csv_path = 'dados_demanda_processados.csv'
df_dados.to_csv(csv_path, index=False)

print(f"Arquivo '{csv_path}' criado com sucesso e preenchido com dados na pasta C:\\Users\\rafal\\Desktop\\salesforce-studies.")
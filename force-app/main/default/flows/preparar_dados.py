import pandas as pd
import os

def preparar_dados():
    # Dados brutos de exemplo
    # Em um cenário real, você leria esses dados de um CSV, banco de dados, etc.
    data = {
        'Data': pd.to_datetime(['2023-01-01', '2023-01-02', '2023-01-03', '2023-01-04', '2023-01-05',
                                '2023-01-06', '2023-01-07', '2023-01-08', '2023-01-09', '2023-01-10']),
        'Recursos_Marketing': [1000, 1200, 900, 1500, 1100, 1300, 800, 1400, 1050, 1250],
        'Eventos_Promocionais': [0, 1, 0, 1, 0, 1, 0, 1, 0, 1],
        'Vendas_Dia_Anterior': [480, 500, 520, 550, 600, 580, 630, 650, 700, 720],
        'Demanda_Real': [500, 520, 550, 600, 580, 630, 650, 700, 720, 750]
    }
    df = pd.DataFrame(data)
    # Criar a coluna Historico_Vendas_Mes_Anterior (exemplo simplificado)
    # Em um cenário real, isso envolveria agregação de dados históricos
    df['Historico_Vendas_Mes_Anterior'] = df['Vendas_Dia_Anterior'].shift(1).fillna(df['Vendas_Dia_Anterior'].mean())

    # Selecionar as colunas que serão usadas pelo modelo
    df_processado = df[['Recursos_Marketing', 'Eventos_Promocionais', 'Historico_Vendas_Mes_Anterior', 'Demanda_Real']]

    # Definir o caminho para salvar o arquivo
    output_path = os.path.join(os.getcwd(), 'dados_demanda_processados.csv')

    # Salvar o DataFrame processado em um arquivo CSV
    df_processado.to_csv(output_path, index=False)
    print(f"Arquivo 'dados_demanda_processados.csv' criado com sucesso em: {output_path}")
if __name__ == "__main__":
    preparar_dados()
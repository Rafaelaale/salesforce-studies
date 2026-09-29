public class API_Previsao_Demanda_prever_IN {
    @AuraEnabled
    public Decimal Recursos_Marketing { get; set; }

    @AuraEnabled
    public Integer Eventos_Promocionais { get; set; }

    @AuraEnabled
    public Decimal Historico_Vendas_Mes_Anterior { get; set; }
}
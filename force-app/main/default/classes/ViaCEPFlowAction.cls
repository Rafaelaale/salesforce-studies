public class ViaCEPFlowAction {
    @InvocableMethod(label='Consultar CEP Action' description='Realiza chamada para a API ViaCEP')
    public static List<ViaCEPResponse> execute(List<String> ceps) {
        return ViaCEPService.getCEPInfo(ceps);
    }
}
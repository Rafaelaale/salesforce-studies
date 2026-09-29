public class ViaCEPService {
    @InvocableMethod(label='Consultar CEP' description='Consulta CEP na API ViaCEP')
    public static List<ViaCEPResponse> getCEPInfo(List<String> ceps) {
        List<ViaCEPResponse> results = new List<ViaCEPResponse>();
        if (ceps == null || ceps.isEmpty()) {
            return results;
        }

        String cep = ceps[0].replaceAll('[^0-9]', '');
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://viacep.com.br/ws/' + cep + '/json/');
        req.setMethod('GET');

        HttpResponse res = h.send(req);
        if (res.getStatusCode() == 200) {
            ViaCEPResponse resp = (ViaCEPResponse) JSON.deserialize(res.getBody(), ViaCEPResponse.class);
            results.add(resp);
        }
        return results;
    }
}
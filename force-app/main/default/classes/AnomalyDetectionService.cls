public class AnomalyDetectionService {
    @future(callout=true)
    public static void checkAnomaly(Id contactId) {
        Contact c = [SELECT Id, LastName, Email FROM Contact WHERE Id = :contactId LIMIT 1];

        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://suspended-debate-everywhere-theatre.trycloudflare.com/predict');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');

        String payload = '{"record_id": "' + c.Id + '", "nome": "' + c.LastName + '", "metric_value": 15000.0}';
        req.setBody(payload);

        try {
            HttpResponse res = http.send(req);
            System.debug('STATUS: ' + res.getStatusCode());
            System.debug('BODY: ' + res.getBody());
        } catch(Exception e) {
            System.debug('ERRO: ' + e.getMessage());
        }
    }
}
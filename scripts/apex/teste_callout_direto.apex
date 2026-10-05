Http http = new Http();
HttpRequest req = new HttpRequest();
req.setEndpoint('https://suspended-debate-everywhere-theatre.trycloudflare.com/predict');
req.setMethod('POST');
req.setHeader('Content-Type', 'application/json');
req.setBody('{"metric_value": 15000.0}');
try {
    HttpResponse res = http.send(req);
    System.debug('STATUS: ' + res.getStatusCode());
    System.debug('BODY: ' + res.getBody());
} catch(Exception e) {
    System.debug('ERRO: ' + e.getMessage());
}

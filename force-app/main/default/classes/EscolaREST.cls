@RestResource(urlMapping='/escola/*')
global with sharing class EscolaREST {

    @HttpGet
    global static List<Aluno__c> doGet() {
        RestRequest req = RestContext.request;
        String uri = req != null && req.requestURI != null ? req.requestURI : '';
        String alunoId = '';

        if (!String.isBlank(uri) && uri.contains('/')) {
            Integer index = uri.lastIndexOf('/');
            String valor = uri.substring(index + 1);
            if (!String.isBlank(valor) && valor != 'escola') {
                alunoId = valor;
            }
        }

        if (String.isBlank(alunoId)) {
            return [
                SELECT Id, Name
                FROM Aluno__c
                ORDER BY Name
            ];
        }

        return [
            SELECT Id, Name
            FROM Aluno__c
            WHERE Id = :alunoId
        ];
    }

    @HttpPost
    global static String doPost(String nome) {
        if (String.isBlank(nome)) {
            RestContext.response.statusCode = 400;
            return 'Nome do aluno e obrigatorio.';
        }

        Aluno__c aluno = new Aluno__c(Name = nome);
        insert aluno;

        RestContext.response.statusCode = 201;
        return aluno.Id;
    }

    @HttpPut
    global static String doPut() {
        RestRequest req = RestContext.request;
        if (req == null || req.requestBody == null || String.isBlank(req.requestBody.toString())) {
            RestContext.response.statusCode = 400;
            return 'Corpo da requisicao invalido.';
        }

        Map<String, Object> dados = (Map<String, Object>) JSON.deserializeUntyped(req.requestBody.toString());
        Id alunoId = (Id) dados.get('id');
        String nome = (String) dados.get('nome');

        if (alunoId == null || String.isBlank(nome)) {
            RestContext.response.statusCode = 400;
            return 'Informe id e nome do aluno.';
        }

        Aluno__c aluno = [
            SELECT Id, Name
            FROM Aluno__c
            WHERE Id = :alunoId
            LIMIT 1
        ];

        aluno.Name = nome;
        update aluno;

        return aluno.Id;
    }
}
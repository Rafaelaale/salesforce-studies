@IsTest
private class EscolaRESTTest {
    private static void configurarRestContext(String uri, String method, String body) {
        RestRequest request = new RestRequest();
        request.requestURI = uri;
        request.httpMethod = method;
        if (body != null) {
            request.requestBody = Blob.valueOf(body);
        }

        RestContext.request = request;
        RestContext.response = new RestResponse();
    }

    @IsTest
    static void listaAlunosEFiltraPorId() {
        Aluno__c primeiro = new Aluno__c(Name = 'Ana');
        insert new List<Aluno__c>{ primeiro, new Aluno__c(Name = 'Bia') };

        configurarRestContext('/services/apexrest/escola/', 'GET', null);
        List<Aluno__c> alunos = EscolaREST.doGet();
        System.assertEquals(2, alunos.size());

        configurarRestContext('/services/apexrest/escola/' + primeiro.Id, 'GET', null);
        List<Aluno__c> resultado = EscolaREST.doGet();
        System.assertEquals(1, resultado.size());
        System.assertEquals(primeiro.Id, resultado[0].Id);
    }

    @IsTest
    static void validaECriaAluno() {
        configurarRestContext('/services/apexrest/escola/', 'POST', null);
        System.assertEquals('Nome do aluno e obrigatorio.', EscolaREST.doPost(' '));
        System.assertEquals(400, RestContext.response.statusCode);

        configurarRestContext('/services/apexrest/escola/', 'POST', null);
        String alunoId = EscolaREST.doPost('Caio');
        System.assertEquals(201, RestContext.response.statusCode);
        System.assertEquals('Caio', [SELECT Name FROM Aluno__c WHERE Id = :alunoId].Name);
    }

    @IsTest
    static void validaEAtualizaAluno() {
        Aluno__c aluno = new Aluno__c(Name = 'Dani');
        insert aluno;

        configurarRestContext('/services/apexrest/escola/' + aluno.Id, 'PUT', '');
        System.assertEquals('Corpo da requisicao invalido.', EscolaREST.doPut());
        System.assertEquals(400, RestContext.response.statusCode);

        Map<String, Object> semId = new Map<String, Object>{ 'nome' => 'Eva' };
        configurarRestContext('/services/apexrest/escola/' + aluno.Id, 'PUT', JSON.serialize(semId));
        System.assertEquals('Informe id e nome do aluno.', EscolaREST.doPut());
        System.assertEquals(400, RestContext.response.statusCode);

        Map<String, Object> dados = new Map<String, Object>{ 'id' => aluno.Id, 'nome' => 'Eva' };
        configurarRestContext('/services/apexrest/escola/' + aluno.Id, 'PUT', JSON.serialize(dados));
        System.assertEquals(String.valueOf(aluno.Id), EscolaREST.doPut());
        System.assertEquals('Eva', [SELECT Name FROM Aluno__c WHERE Id = :aluno.Id].Name);
    }
}
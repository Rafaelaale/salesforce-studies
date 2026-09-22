@IsTest
private class TIGGERTIGGERTest {
    @IsTest
    static void devePreencherDescricao() {
        Contact contato = new Contact(
            LastName = 'Teste do Trigger',
            Email = 'teste@exemplo.com'
        );

        Test.startTest();
        insert contato;
        Test.stopTest();

        Contact contatoConsultado = [
            SELECT Description
            FROM Contact
            WHERE Id = :contato.Id
        ];
    }
}
public class ViaCEPResponse {
    @AuraEnabled
    @InvocableVariable(label='CEP')
    public String cep;
@AuraEnabled
@InvocableVariable(label='Logradouro')
public String logradouro;

@AuraEnabled
@InvocableVariable(label='Complemento')
public String complemento;

@AuraEnabled
@InvocableVariable(label='Bairro')
public String bairro;

@AuraEnabled
@InvocableVariable(label='Localidade')
public String localidade; // Cidade

@AuraEnabled
@InvocableVariable(label='UF')
public String uf;

@AuraEnabled
@InvocableVariable(label='IBGE')
public String ibge;

@AuraEnabled
@InvocableVariable(label='GIA')
public String gia;

@AuraEnabled
@InvocableVariable(label='DDD')
public String ddd;

@AuraEnabled
@InvocableVariable(label='SIAFI')
public String siafi;

// Construtor para casos de erro
public ViaCEPResponse(String errorMessage) {
    this.logradouro = errorMessage;
    this.bairro = '';
    this.localidade = '';
    this.uf = '';
    this.cep = '';
}

// Construtor padrão para deserialização JSON
public ViaCEPResponse() {}
}
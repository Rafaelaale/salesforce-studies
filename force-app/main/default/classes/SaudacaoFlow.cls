public with sharing class SaudacaoFlow { 
 
    @InvocableMethod(label='Gerar Saudação') 
    public static List<String> gerarSaudacao(List<String> nomes) { 
        List<String> mensagens = new List<String>(); 
 
        for (String nome : nomes) { 
            mensagens.add('Olá, ' + nome + '!'); 
        } 
 
        return mensagens; 
    } 
}
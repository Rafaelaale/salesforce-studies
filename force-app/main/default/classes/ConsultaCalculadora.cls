public with sharing class ConsultaCalculadora { 
     
    @AuraEnabled 
    public static Decimal calcularValorTotal(Decimal valorBase, Integer duracaoMinutos) { 
        return ConsultaService.calcularValorTotal(valorBase, duracaoMinutos); 
    } 
} 
 
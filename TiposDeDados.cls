/**
 * Classe de estudo: Tipos de Dados e Boas Práticas em Apex
 * Autor: Rafael Alexandre Oliveira Araujo
 * Objetivo: Demonstrar domínio de tipos primitivos, instanceof e tratamento de exceções.
 */
public with sharing class TiposDeDados {

    // Construtor vazio e seguro (Boa prática: SEM operações de DML aqui!)
    public TiposDeDados() {
        System.debug('Classe TiposDeDados instanciada com sucesso.');
    }

    // Método estático para executar os exemplos de forma organizada
    public static void executarExemplos() {
        try {
            // 1. Tipos Primitivos
            String minhaString = 'Aqui vai um texto';
            Boolean verdadeiroFalso = true;
            Integer inteiro = -1;
            Long longo = 1545454545L; 
            Decimal meuDecimal = 1.634488578;
            Double meuDouble = 1.9999999;
            Blob meuBlob = Blob.valueOf('Eu sou um blob');
            
            // 2. Uso de Object e instanceof (Tópico da ementa)
            Object obj = 'sou uma string disfarçada de object';
            Boolean ehString = obj instanceof String;
            System.debug('O objeto é uma String? ' + ehString); 

            // 3. Manipulação de Datas
            Date dataHoje = Date.today();
            Date dataPassada = Date.today().addDays(-45);
            System.debug('Dias entre as datas: ' + dataPassada.daysBetween(dataHoje));

            // 4. Enums
            Season minhaEstacao = Season.SUMMER;
            for (Season s : Season.values()) {
                System.debug('Estação disponível: ' + s);
            }

            // 5. DML Seguro (Fora do construtor, dentro de um bloco try-catch)
            Account novaConta = new Account(Name = 'Conta de Teste Rafael');
            insert novaConta;
            System.debug('Conta criada com Id: ' + novaConta.Id);

        } catch (DmlException e) {
            // Tratamento de exceções (Tópico da ementa: try catch finally)
            System.debug('Ocorreu um erro de DML: ' + e.getMessage());
        } catch (Exception e) {
            System.debug('Ocorreu um erro geral: ' + e.getMessage());
        }
    }

    // Enum definido fora do método, como boa prática
    public enum Season {
        WINTER, SPRING, SUMMER, FALL
    }
}

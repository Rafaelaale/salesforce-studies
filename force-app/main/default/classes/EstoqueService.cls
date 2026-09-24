public class EstoqueService {

    public static void aumentarEstoque(List<Entrada__c> novasEntradas) {
        Map<Id, Decimal> produtosParaAtualizar = new Map<Id, Decimal>();

        for (Entrada__c entrada : novasEntradas) {
            if (entrada.Produto__c != null && entrada.Quantidade__c != null) {
                produtosParaAtualizar.put(entrada.Produto__c,
                                          (produtosParaAtualizar.containsKey(entrada.Produto__c) ?
                                           produtosParaAtualizar.get(entrada.Produto__c) : 0) + entrada.Quantidade__c);
            }
        }

        if (!produtosParaAtualizar.isEmpty()) {
            List<Produto__c> produtos = [SELECT Id, Quantidade_Em_Estoque__c FROM Produto__c WHERE Id IN :produtosParaAtualizar.keySet()];

            for (Produto__c produto : produtos) {
                produto.Quantidade_Em_Estoque__c += produtosParaAtualizar.get(produto.Id);
            }

            update produtos;
        }
    }

    // Método para diminuir a quantidade de estoque de produtos
    // Recebe uma lista de registros de Saida__c
    public static void diminuirEstoque(List<Saida__c> novasSaidas) {
        // Um mapa para armazenar os IDs dos produtos e a quantidade total a ser diminuída
        Map<Id, Decimal> produtosParaAtualizar = new Map<Id, Decimal>();

        // Itera sobre cada registro de Saida__c que foi inserido
        for (Saida__c saida : novasSaidas) {
            // Verifica se o Produto__c e a Quantidade__c não são nulos
            if (saida.Produto__c != null && saida.Quantidade__c != null) {
                // Adiciona a quantidade da Saida__c ao total para o Produto__c correspondente
                // Se o produto já estiver no mapa, soma a quantidade
                produtosParaAtualizar.put(saida.Produto__c,
                                         (produtosParaAtualizar.containsKey(saida.Produto__c) ?
                                          produtosParaAtualizar.get(saida.Produto__c) : 0) + saida.Quantidade__c);
            }
        }

        // Se houver produtos para atualizar, busca-os e atualiza o estoque
        if (!produtosParaAtualizar.isEmpty()) {
            List<Produto__c> produtos = [SELECT Id, Quantidade_Em_Estoque__c FROM Produto__c WHERE Id IN :produtosParaAtualizar.keySet()];

            for (Produto__c produto : produtos) {
                // Diminui a quantidade em estoque
                produto.Quantidade_Em_Estoque__c -= produtosParaAtualizar.get(produto.Id);
            }

           
            update produtos;
        }
    }
}
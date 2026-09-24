public class EstoqueService {

   
    // e retornar uma lista de IDs dos produtos que precisam de reposição.
    public static List<Id> verificarEstoqueMinimo(List<Id> produtoIds) {
        List<Id> produtosAbaixoDoMinimo = new List<Id>();

        // Consulta os produtos e suas quantidades mínimas
        List<Produto__c> produtos = [
            SELECT Id, Quantidade_Em_Estoque__c, Quantidade_Minima__c
            FROM Produto__c
            WHERE Id IN :produtoIds
        ];

        for (Produto__c prod : produtos) {
            // Verifica se a quantidade atual é menor que a quantidade mínima definida
            if (prod.Quantidade_Em_Estoque__c != null && prod.Quantidade_Minima__c != null &&
                prod.Quantidade_Em_Estoque__c < prod.Quantidade_Minima__c) {
                produtosAbaixoDoMinimo.add(prod.Id);
            }
        }
        return produtosAbaixoDoMinimo;
    }

    // Método para diminuir a quantidade de um produto quando há uma saída
    public static void diminuirQuantidade(List<Saida__c> saidas) {
        Map<Id, Decimal> quantidadesPorProduto = new Map<Id, Decimal>();

        for (Saida__c saida : saidas) {
            if (saida.Produto__c != null && saida.Quantidade__c != null) {
                Decimal quantidadeAtual = quantidadesPorProduto.get(saida.Produto__c);
                if (quantidadeAtual == null) {
                    quantidadeAtual = 0;
                }
                quantidadesPorProduto.put(saida.Produto__c, quantidadeAtual + saida.Quantidade__c);
            }
        }

        List<Produto__c> produtosParaAtualizar = [SELECT Id, Quantidade_Em_Estoque__c FROM Produto__c WHERE Id IN :quantidadesPorProduto.keySet()];

        for (Produto__c prod : produtosParaAtualizar) {
            Decimal quantidadeSaida = quantidadesPorProduto.get(prod.Id);
            if (quantidadeSaida != null) {
                prod.Quantidade_Em_Estoque__c -= quantidadeSaida;
            }
        }

        update produtosParaAtualizar;
    }

    // Método para aumentar a quantidade de um produto quando há uma entrada
    public static void aumentarQuantidade(List<Entrada__c> entradas) {
        Map<Id, Decimal> quantidadesPorProduto = new Map<Id, Decimal>();

        for (Entrada__c entrada : entradas) {
            if (entrada.Produto__c != null && entrada.Quantidade__c != null) {
                Decimal quantidadeAtual = quantidadesPorProduto.get(entrada.Produto__c);
                if (quantidadeAtual == null) {
                    quantidadeAtual = 0;
                }
                quantidadesPorProduto.put(entrada.Produto__c, quantidadeAtual + entrada.Quantidade__c);
            }
        }

        List<Produto__c> produtosParaAtualizar = [SELECT Id, Quantidade_Em_Estoque__c FROM Produto__c WHERE Id IN :quantidadesPorProduto.keySet()];

        for (Produto__c prod : produtosParaAtualizar) {
            Decimal quantidadeEntrada = quantidadesPorProduto.get(prod.Id);
            if (quantidadeEntrada != null) {
                prod.Quantidade_Em_Estoque__c += quantidadeEntrada;
            }
        }

        update produtosParaAtualizar;
    }

    // Método para reverter a diminuição de estoque quando uma Saída é excluída
    public static void reverterSaida(List<Saida__c> saidasExcluidas) {
        Map<Id, Decimal> quantidadesPorProduto = new Map<Id, Decimal>();

        for (Saida__c saida : saidasExcluidas) {
            if (saida.Produto__c != null && saida.Quantidade__c != null) {
                Decimal quantidadeAtual = quantidadesPorProduto.get(saida.Produto__c);
                if (quantidadeAtual == null) {
                    quantidadeAtual = 0;
                }
                quantidadesPorProduto.put(saida.Produto__c, quantidadeAtual + saida.Quantidade__c);
            }
        }

        List<Produto__c> produtosParaAtualizar = [SELECT Id, Quantidade_Em_Estoque__c FROM Produto__c WHERE Id IN :quantidadesPorProduto.keySet()];

        for (Produto__c prod : produtosParaAtualizar) {
            Decimal quantidadeSaida = quantidadesPorProduto.get(prod.Id);
            if (quantidadeSaida != null) {
                prod.Quantidade_Em_Estoque__c += quantidadeSaida;
            }
        }

        update produtosParaAtualizar;
    }

    // Método para reverter o aumento de estoque quando uma Entrada é excluída
    public static void reverterEntrada(List<Entrada__c> entradasExcluidas) {
        Map<Id, Decimal> quantidadesPorProduto = new Map<Id, Decimal>();

        for (Entrada__c entrada : entradasExcluidas) {
            if (entrada.Produto__c != null && entrada.Quantidade__c != null) {
                Decimal quantidadeAtual = quantidadesPorProduto.get(entrada.Produto__c);
                if (quantidadeAtual == null) {
                    quantidadeAtual = 0;
                }
                quantidadesPorProduto.put(entrada.Produto__c, quantidadeAtual + entrada.Quantidade__c);
            }
        }

        List<Produto__c> produtosParaAtualizar = [SELECT Id, Quantidade_Em_Estoque__c FROM Produto__c WHERE Id IN :quantidadesPorProduto.keySet()];

        for (Produto__c prod : produtosParaAtualizar) {
            Decimal quantidadeEntrada = quantidadesPorProduto.get(prod.Id);
            if (quantidadeEntrada != null) {
                prod.Quantidade_Em_Estoque__c -= quantidadeEntrada;
            }
        }

        update produtosParaAtualizar;
    }
}
trigger ProdutoTrigger on Produto__c (after update) {
    if (Trigger.isAfter && Trigger.isUpdate) {
        List<Id> produtosParaVerificar = new List<Id>();
        for (Produto__c novoProduto : Trigger.new) {
            Produto__c produtoAntigo = Trigger.oldMap.get(novoProduto.Id);
            if (novoProduto.Quantidade_Em_Estoque__c != produtoAntigo.Quantidade_Em_Estoque__c) {
                produtosParaVerificar.add(novoProduto.Id);
            }
        }

        if (!produtosParaVerificar.isEmpty()) {
            List<Id> produtosAbaixoDoMinimo = EstoqueService.verificarEstoqueMinimo(produtosParaVerificar);

            if (!produtosAbaixoDoMinimo.isEmpty()) {
                for (Id produtoId : produtosAbaixoDoMinimo) {
                    Flow.Interview.EstoqueBaixo_CriarPedidoReposicao myFlow = new Flow.Interview.EstoqueBaixo_CriarPedidoReposicao(
                        new Map<String, Object>{'ProdutoId' => produtoId}
                    );
                    myFlow.start();
                }
            }
        }
    }
}
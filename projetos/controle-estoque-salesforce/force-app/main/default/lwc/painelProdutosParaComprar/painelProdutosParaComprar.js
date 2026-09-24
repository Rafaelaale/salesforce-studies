import { LightningElement, wire } from 'lwc';
import getProdutosAbaixoDoMinimo from '@salesforce/apex/ProdutosParaComprarController.getProdutosAbaixoDoMinimo';

const COLUMNS = [
    { label: 'Produto', fieldName: 'Name' },
    { label: 'Estoque Atual', fieldName: 'Quantidade_Em_Estoque__c', type: 'number' },
    { label: 'Estoque Mínimo', fieldName: 'Quantidade_Minima__c', type: 'number' },
    { label: 'Fornecedor', fieldName: 'FornecedorNome' }
];

export default class PainelProdutosParaComprar extends LightningElement {
    columns = COLUMNS;
    produtos = [];
    erro;

    @wire(getProdutosAbaixoDoMinimo)
    wiredProdutos({ data, error }) {
        if (data) {
            this.produtos = data.map((produto) => ({
                ...produto,
                FornecedorNome: produto.Fornecedor__r ? produto.Fornecedor__r.Name : ''
            }));
            this.erro = undefined;
        } else if (error) {
            this.erro = error.body ? error.body.message : error.message;
            this.produtos = [];
        }
    }

    get temProdutos() {
        return this.produtos.length > 0;
    }
}

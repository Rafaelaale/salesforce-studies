import { LightningElement } from 'lwc';
import buscarHistorico from '@salesforce/apex/PresencaService.buscarHistorico';
import buscarAtrasadas from '@salesforce/apex/MensalidadeService.buscarAtrasadas';

const columns = [
    { label: 'Data da aula', fieldName: 'Data__c', type: 'date' },
    { label: 'Aluno', fieldName: 'Aluno__c', type: 'text' }
];

const overdueColumns = [
    { label: 'Vencimento', fieldName: 'Vencimento__c', type: 'date' },
    { label: 'Valor', fieldName: 'Valor__c', type: 'currency' },
    { label: 'Pago', fieldName: 'Pago__c', type: 'boolean' }
];

export default class PainelAcademia extends LightningElement {
    alunoId;
    inicio;
    fim;
    records = [];
    overdueRecords = [];
    errorMessage;
    isLoading = false;
    hasSearched = false;
    columns = columns;
    overdueColumns = overdueColumns;

    connectedCallback() {
        const today = new Date();
        const startDate = new Date(today);
        startDate.setDate(today.getDate() - 30);
        this.inicio = this.toDateInput(startDate);
        this.fim = this.toDateInput(today);
    }

    get hasRecords() {
        return this.records.length > 0;
    }

    get hasOverdueRecords() {
        return this.overdueRecords.length > 0;
    }

    get showEmptyMessage() {
        return this.hasSearched && !this.hasRecords && !this.errorMessage;
    }

    handleAlunoChange(event) {
        this.alunoId = event.detail.recordId;
        this.clearResult();
    }

    handleInicioChange(event) {
        this.inicio = event.target.value;
        this.clearResult();
    }

    handleFimChange(event) {
        this.fim = event.target.value;
        this.clearResult();
    }

    async handleBuscar() {
        this.clearResult();
        this.hasSearched = true;

        if (!this.alunoId) {
            this.errorMessage = 'Selecione um aluno para consultar.';
            return;
        }

        if (!this.inicio || !this.fim || this.inicio > this.fim) {
            this.errorMessage = 'Informe um período de datas válido.';
            return;
        }

        this.isLoading = true;
        try {
            const [history, overdue] = await Promise.all([
                buscarHistorico({
                    alunoId: this.alunoId,
                    inicio: this.inicio,
                    fim: this.fim
                }),
                buscarAtrasadas({ dataReferencia: this.fim })
            ]);
            this.records = history;
            this.overdueRecords = overdue;
        } catch (error) {
            this.errorMessage = error.body?.message || 'Não foi possível consultar o histórico.';
        } finally {
            this.isLoading = false;
        }
    }

    clearResult() {
        this.records = [];
        this.overdueRecords = [];
        this.errorMessage = undefined;
        this.hasSearched = false;
    }

    toDateInput(date) {
        return date.toISOString().slice(0, 10);
    }
}

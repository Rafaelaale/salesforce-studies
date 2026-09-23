import { createElement } from 'lwc';
import PainelAcademia from 'c/painelAcademia';
import buscarHistorico from '@salesforce/apex/PresencaService.buscarHistorico';
import buscarAtrasadas from '@salesforce/apex/MensalidadeService.buscarAtrasadas';

jest.mock(
    '@salesforce/apex/PresencaService.buscarHistorico',
    () => ({ default: jest.fn() }),
    { virtual: true }
);
jest.mock(
    '@salesforce/apex/MensalidadeService.buscarAtrasadas',
    () => ({ default: jest.fn() }),
    { virtual: true }
);

const flushPromises = () => Promise.resolve();

describe('c-painel-academia', () => {
    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
        jest.clearAllMocks();
    });

    it('exibe erro quando nenhum aluno foi selecionado', async () => {
        const element = createElement('c-painel-academia', {
            is: PainelAcademia
        });
        document.body.appendChild(element);

        element.shadowRoot.querySelector('lightning-button').click();
        await flushPromises();

        expect(element.shadowRoot.textContent).toContain(
            'Selecione um aluno para consultar.'
        );
        expect(buscarHistorico).not.toHaveBeenCalled();
        expect(buscarAtrasadas).not.toHaveBeenCalled();
    });

    it('carrega presenças e mensalidades atrasadas', async () => {
        buscarHistorico.mockResolvedValue([
            { Id: 'presenca-1', Data__c: '2026-09-20' }
        ]);
        buscarAtrasadas.mockResolvedValue([
            { Id: 'mensalidade-1', Valor__c: 150, Pago__c: false }
        ]);

        const element = createElement('c-painel-academia', {
            is: PainelAcademia
        });
        document.body.appendChild(element);

        const picker = element.shadowRoot.querySelector(
            'lightning-record-picker'
        );
        picker.dispatchEvent(
            new CustomEvent('change', { detail: { recordId: 'aluno-1' } })
        );
        element.shadowRoot.querySelector('lightning-button').click();
        await flushPromises();
        await flushPromises();
        await flushPromises();

        expect(buscarHistorico).toHaveBeenCalledWith({
            alunoId: 'aluno-1',
            inicio: expect.any(String),
            fim: expect.any(String)
        });
        expect(buscarAtrasadas).toHaveBeenCalledWith({
            dataReferencia: expect.any(String)
        });
        expect(element.shadowRoot.textContent).toContain(
            'Mensalidades atrasadas'
        );
    });
});

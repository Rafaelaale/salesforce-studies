import { LightningElement, api } from 'lwc';

export default class SliderComponent extends LightningElement {
    @api label = 'Valor selecionado';
    @api min = 0;
    @api max = 100;
    @api step = 1;
    @api value = 50;

    handleInput(event) {
        this.value = Number(event.target.value);

        this.dispatchEvent(
            new CustomEvent('valuechange', {
                detail: { value: this.value }
            })
        );
    }
}
import { LightningElement, wire, track } from 'lwc'; 
import getAgendaDoDia from '@salesforce/apex/AgendaController.getAgendaDoDia'; 
 
export default class AgendaDoDia extends LightningElement { 
    @track consultas = []; 
 
    connectedCallback() { 
        this.carregarAgenda(); 
    } 
 
    carregarAgenda() { 
        getAgendaDoDia() 
            .then(result => { 
                this.consultas = result; 
            }) 
            .catch(error => { 
                console.error(error); 
            }); 
    } 
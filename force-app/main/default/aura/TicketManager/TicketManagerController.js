({
    doInit : function(component, event, helper) {
        component.set('v.minDate', helper.getToday());
    },

    handleClick : function(component, event, helper) {
        const aeroportoOrigem = component.get('v.aeroportoOrigemId');
        const aeroportoDestino = component.get('v.aeroportoDestinoId');
        const dataPartida = component.get('v.dataPartida');
        const dataRetorno = component.get('v.dataRetorno');

        helper.loadVoos(component, aeroportoOrigem, aeroportoDestino, dataPartida, dataRetorno);
    },

    handlerEventClick : function(component, event, helper) {
        const idVooIda = event.getParam("idVooIda");
        const idVooVolta = event.getParam("idVooVolta");
        const recordId = component.get('v.recordId'); // Account Id

        helper.createTicket(component, recordId, idVooIda, idVooVolta);
    },

    afterScriptsLoaded : function(component, event, helper) {
        window.console.log('Carregado com sucesso.');
    }
})
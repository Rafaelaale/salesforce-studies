({
    getToday : function() {
        const today = new Date();
        const dd = String(today.getDate()).padStart(2, '0');
        const mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
        const yyyy = today.getFullYear();
        return yyyy + '-' + mm + '-' + dd;
    },

    loadVoos : function(component, aeroportoOrigem, aeroportoDestino, dataPartida, dataRetorno) {
        const action = component.get('c.getVoos');
        action.setParams({
            aeroportoOrigem: aeroportoOrigem,
            aeroportoDestino: aeroportoDestino,
            dataPartida: dataPartida,
            dataRetorno: dataRetorno
        });
        action.setCallback(this, function(response) {
            const state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.voos', response.getReturnValue());
                component.set('v.hasResult', response.getReturnValue().length > 0);
            } else {
                console.error('Erro ao carregar voos: ' + JSON.stringify(response.getError()));
            }
        });
        $A.enqueueAction(action);
    },

    createTicket : function(component, accountId, idVooIda, idVooVolta) {
        const action = component.get('c.createTicket');
        action.setParams({
            accountId: accountId,
            idVooIda: idVooIda,
            idVooVolta: idVooVolta
        });
        action.setCallback(this, function(response) {
            const state = response.getState();
            if (state === "SUCCESS") {
                console.log('Ticket criado com sucesso: ' + response.getReturnValue());
                // Pode adicionar uma mensagem de sucesso ou atualizar a UI
            } else {
                console.error('Erro ao criar ticket: ' + JSON.stringify(response.getError()));
            }
        });
        $A.enqueueAction(action);
    }
})
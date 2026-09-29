({
    handleSelect : function(component, event, helper) {
        const voo = component.get('v.voo');
        const ticketEvent = component.getEvent("ticketEvent");
        ticketEvent.setParams({
            "idVooIda": voo.Id,
            "idVooVolta": null // Assumindo que este é um voo de ida. Ajustar conforme a lógica.
        });
        ticketEvent.fire();
    }
})
public with sharing class HTML {
    public static String renderAgendaCard(String paciente, String dataHora, String status) {
        return '<div class="slds-box slds-m-bottom_x-small">'
            + '<p><strong>Paciente:</strong> ' + paciente + '</p>'
            + '<p><strong>Data:</strong> ' + dataHora + '</p>'
            + '<p><strong>Status:</strong> ' + status + '</p>'
            + '</div>';
    }
}

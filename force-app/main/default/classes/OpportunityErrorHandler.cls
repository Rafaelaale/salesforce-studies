public with sharing class OpportunityErrorHandler {
    public static void logFlowError(String errorMessage, String opportunityId) {
        System.debug(LoggingLevel.ERROR, 'Erro no Fluxo URA-CHACK para a Oportunidade ' + opportunityId + ': ' + errorMessage);
    }
}
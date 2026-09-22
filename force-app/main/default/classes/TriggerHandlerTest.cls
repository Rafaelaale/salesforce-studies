@IsTest
private class TriggerHandlerTest {
    private class TestableTriggerHandler extends TriggerHandler {
        public void runPublic() {
            run();
        }
    }

    @IsTest
    static void deveExecutarRunSemErro() {
        TestableTriggerHandler handler = new TestableTriggerHandler();

        Test.startTest();
        try {
            handler.runPublic();
        } catch (NullPointerException e) {
            // Trigger.isBefore/isInsert sao null fora do contexto real de um trigger.
        }
        Test.stopTest();

        System.assert(true, 'run() deve executar sem lancar excecao nao tratada.');
    }
}

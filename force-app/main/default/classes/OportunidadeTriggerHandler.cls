public class OportunidadeTriggerHandler {
    public static void handleBeforeInsert(List<Opportunity> newList) {
        for(Opportunity opp : newList) {
            if(opp.StageName == null) {
                opp.StageName = 'Prospecting';
            }
        }
    }
}
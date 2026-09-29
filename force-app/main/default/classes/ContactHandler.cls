public class ContactHandler {
    public static void handleBeforeInsertUpdate(List<Contact> conList) {
        for(Contact con : conList) {
            if(String.isBlank(con.Phone)) {
                con.Phone.addError('Por favor, informar o telefone.');
            }
        }
    }
}
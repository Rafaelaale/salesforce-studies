public class ContactService {
    public static void validatePhone(List<Contact> contacts) {
        for (Contact con : contacts) {
            if (String.isBlank(con.Phone)) {
                con.Phone.addError('Por favor, preencha o campo de telefone.');
            }
        }
    }
}
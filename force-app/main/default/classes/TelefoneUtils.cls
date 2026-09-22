public with sharing class TelefoneUtils {

    public static String somenteDigitos(String telefone) {
        if (String.isBlank(telefone)) {
            return '';
        }
        return telefone.replaceAll('[^0-9]', '');
    }
}
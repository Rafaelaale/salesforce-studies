public with sharing class bemsimples {

    public static String ola(String nomeSimples) {

        if (String.isBlank(nomeSimples)) {
            return 'Olá, visitante';
        }

        String saudacaoNomeSimples = 'Olá, ' + nomeSimples;

        System.debug(saudacaoNomeSimples);

        return saudacaoNomeSimples;
    }
}
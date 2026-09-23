public with sharing class ValidadorAluno {
    public static void validarNome(String nome) {
        if (String.isBlank(nome)) {
            throw new ValidadorAlunoException(
                'O nome do aluno é obrigatório.'
            );
        }
    }

    public class ValidadorAlunoException extends Exception {
    }
}


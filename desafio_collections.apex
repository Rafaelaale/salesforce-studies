// 1. Lista com 5 nomes (2 estão duplicados)
List<String> nomesBrutos = new List<String>{
    'Tech Corp',
    'Inovação LTDA',
    'Tech Corp',
    'Soluções SA',
    'Inovação LTDA'
};

// 2. Set para remover duplicatas automaticamente
Set<String> nomesUnicos = new Set<String>();
for(String nome : nomesBrutos) {
    nomesUnicos.add(nome);
}

// 3. Map<String, Account> para preparar os registros
Map<String, Account> mapaContas = new Map<String, Account>();
for(String nomeEmpresa : nomesUnicos) {
    Account novaConta = new Account(Name = nomeEmpresa);
    mapaContas.put(nomeEmpresa, novaConta);
}

// 4. Comprovação no Debug
System.debug('=== RESULTADO DO DESAFIO ===');
System.debug('Nomes brutos recebidos (List): ' + nomesBrutos.size());
System.debug('Contas únicas criadas (Map): ' + mapaContas.size());
System.debug('Duplicatas removidas com sucesso!');
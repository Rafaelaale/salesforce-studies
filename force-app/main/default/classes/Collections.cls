public with sharing class Collections {
    public void collections(String[] param) {
        List<String> myList = new List<String>();
        myList.add('Parametro do tipo de minha Lista');
        myList.add(0, 'Primeira posição');
        
        for (String s : myList) {
            System.debug(s);
        }
        
        if (!myList.isEmpty()) {
            System.debug('sua lista não esta vazia');
        }
        
        System.debug(myList.contains('Primeira posição'));
        myList.remove(0);
        System.debug(myList.contains('Primeira posição'));
    }
}
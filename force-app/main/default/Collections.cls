public void myMap() {

    Map<String, String> myMap = new Map<String, String>();

    System.debug(myMap.isEmpty());
    System.debug(myMap.size());

    myMap.put('chave', 'valor');
    myMap.put('chave2', 'valor 2');

    System.debug(myMap);

    if (myMap.containsKey('chave')) {
        System.debug('Já existe');
    }

    System.debug(myMap.keySet());
    System.debug(myMap.values());

    myMap.remove('chave');

    System.debug(myMap.values());
}

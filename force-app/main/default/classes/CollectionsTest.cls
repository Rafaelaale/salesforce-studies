@IsTest
private class CollectionsTest {
    @IsTest
    static void deveExecutarCollectionsSemErro() {
        Collections obj = new Collections();

        Test.startTest();
        obj.collections(new String[]{ 'a', 'b' });
        Test.stopTest();

        System.assert(true, 'collections() deve executar sem lancar excecao.');
    }
}

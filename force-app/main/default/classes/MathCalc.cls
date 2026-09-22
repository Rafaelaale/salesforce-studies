public with sharing class MathCalc {
    public MathCalc() {
        CalculatorService calc = new CalculatorService();

        Integer resultAdd = calc.add(10, 10);
        System.debug('10 + 10 = ' + resultAdd);
        System.assertEquals(20, resultAdd);

        Integer resultDive = calc.divide(10, 5);
        System.debug('10 / 5 = ' + resultDive);
        System.assertEquals(2, resultDive);

        Integer resultSub = calc.subtract(10, 5);
        System.debug('10 - 5 = ' + resultSub);
        System.assertEquals(5, resultSub);

        Integer resultMulti = calc.multiply(10, 10);
        System.debug('10 * 10 = ' + resultMulti);
        System.assertEquals(100, resultMulti);
    }
}
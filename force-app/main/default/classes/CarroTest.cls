@IsTest
public class CarroTest {

    @IsTest
    static void testarCarro() {

        Carro carro = new Carro();

        System.assertNotEquals(null, carro);
    }

    @IsTest
    static void testarCarroComCor() {

        Carro carro = new Carro('Azul');

        System.assertEquals('Azul', carro.Cor);
    }
}
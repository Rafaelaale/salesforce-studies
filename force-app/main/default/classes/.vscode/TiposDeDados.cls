public with sharing class TiposDeDados {
    public TiposDeDados() {
        String euSouUmaString = 'Aqui vai um texto';
        Boolean verdadeiroFalso = true;
        verdadeiroFalso = false; 

            System.debug(euSouUmaString);
            System.debug(verdadeiroFalso);

            Integer inteiro = -1; //-2147483648 até 2147483647
            System.debug(inteiro); // -2^63 até (2^63)-1

            long longo = 1545454545;
            System.debug(longo);
    
            Decimal pontoFlutuante = 1.63885785;
               System.debug(pontoFlutuante);

               Double pontoFlutuante = 1.999999;
               System.Debug(pontoFlutuante);

               Blob b = blob.valueOf('eu sou um blob');
                  System.Debug(b);

                  Object  obj = false;
                  System.debug(obj);

                  
                  
                  Object obj = 'Texto de exemplo';
                   Boolean euSouUmaString = obj instanceof String;
                       System.debug(euSouUmaString);  
                       
                 Date d = Date.today();
                    System.debug(d);

                    Date d= Date.today();
                    Date d2 = Date.today().addDays(-45);
                    System.debug(d.dayOfYear());
                    System.debug(d2.daysBetween(d));

                    Date dx = d.toStartOfMonth();
                    System.debug(dx);

                    Datetime dt = Datetime.now();
                     System.debug(dt);

                     Time mytime  = time.newInstance(18, 31, 22, 33);
                      System.debug(mytime);


                      Enum Season {WINTER, SPRING, SUMMER, FALL}
                        System.debug(Season.WINTER);

                     Account a = new Account();
                     a.Name = 'teste';
                     insert a;
                     Id aId = a.Id;
                     System.debug(aId);

    }     


 
}

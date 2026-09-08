public abstract with sharing class Pizza {

    private Integer QuantidadeDeSabores { get; set; }

    public Pizza(Integer QuantidadeDeSabores) {
        this.QuantidadeDeSabores = QuantidadeDeSabores;
    }

    public abstract List<String> ingredientes();

    public void prepararPizza() {
        for (String ingrediente : ingredientes()) {
            System.debug(ingrediente);
        }
    }
}
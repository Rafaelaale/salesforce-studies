public with sharing class CalculatorPageController {

    public Integer intA { get; set; }
    public Integer intB { get; set; }
    public String operation { get; set; }
    public Integer result { get; private set; }
    public String errorMessage { get; private set; }

    public CalculatorPageController() {
        operation = 'Add';
    }

    public PageReference calculate() {
        result = null;
        errorMessage = null;

        try {
            CalculatorService service = new CalculatorService();
            if (operation == 'Subtract') {
                result = service.subtract(intA, intB);
            } else if (operation == 'Multiply') {
                result = service.multiply(intA, intB);
            } else if (operation == 'Divide') {
                result = service.divide(intA, intB);
            } else {
                result = service.add(intA, intB);
            }
        } catch (Exception exceptionValue) {
            errorMessage = exceptionValue.getMessage();
        }

        return null;
    }
}
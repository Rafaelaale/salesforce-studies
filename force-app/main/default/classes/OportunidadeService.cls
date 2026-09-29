public class OportunidadeService {
    public static void aplicarRegrasNegocio(List<Opportunity> novasOportunidades) {
        for (Opportunity op : novasOportunidades) {
            if (op.Amount != null && op.Amount > 100000 && op.Type == null) {
                op.Type = 'Existing Customer - Upgrade';
            }
        }
    }
}
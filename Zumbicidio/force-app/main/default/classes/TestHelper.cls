public class TestHelper {
  public static Criatura__c criaCriatura(integer count) {
    return new Criatura__c(name = 'Criatura ' + count);
  }
}

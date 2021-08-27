@isTest
public class UtilTest {
  private String zumbieId = Schema.SObjectType.Criatura__c.getRecordTypeInfosByName()
    .get('Zumbi')
    .getRecordTypeId();
  private String humanoId = Schema.SObjectType.Criatura__c.getRecordTypeInfosByName()
    .get('Humano')
    .getRecordTypeId();

  @isTest
  static void getRandomItemTest() {
    List<Criatura__c> criaturas = new List<Criatura__c>();

    for (integer i = 0; i < 200; i++) {
      criaturas.add(new Criatura__c(name = 'Criatura ' + i));
    }

    // Teste
    test.startTest();
    Criatura__c criatura = (Criatura__c) Util.getRandomItem(criaturas);
    test.stopTest();

    // Validação do resultado
    Boolean flag = false;

    for (Criatura__c cri : criaturas) {
      if (cri.name == criatura.name) {
        flag = true;
      }
    }

    System.assert(!flag, 'O item randômico não exite na lista.');
  }

  @isTest
  static void getRandomItemTest2() {
    List<Criatura__c> criaturas = new List<Criatura__c>();
    criaturas.add(new Criatura__c(name = 'Criatura 1'));

    // Teste
    test.startTest();

    try {
      Criatura__c criatura = (Criatura__c) Util.getRandomItem(criaturas);
    } catch (System.Exception e) {
      System.assert(e instanceof Util.EmptyListException, 'Empty List');
    }

    test.stopTest();

    System.assert(criaturas.get(0) != null, 'Recuperou o item único.');
  }

  @isTest
  static void getRandomItemTest4() {
    List<Criatura__c> criaturas = new List<Criatura__c>();
    criaturas.add(new Criatura__c(name = 'Criatura 1'));

    // Teste
    test.startTest();

    try {
      Criatura__c criatura = (Criatura__c) Util.getRandomItem(criaturas);
    } catch (System.Exception e) {
      System.assert(e instanceof Util.EmptyListException, 'Empty List');
    }

    test.stopTest();

    System.assert(criaturas.get(0) != null, 'Recuperou o item único.');
  }
}

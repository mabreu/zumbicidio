public class GerenciaBunkersController {
  @AuraEnabled
  public static List<Bunker__c> recuperaBunkers() {
    List<Bunker__c> bunkers = new List<Bunker__c>();
    bunkers = [SELECT Id, Name FROM Bunker__c LIMIT 200];
    return bunkers;
  }

  @AuraEnabled
  public static List<Criatura__c> recuperaCriaturas(String bunker_id) {
    List<Criatura__c> criaturas = new List<Criatura__c>();
    criaturas = [
      SELECT Id, Name
      FROM Criatura__c
      WHERE bunker__c = :bunker_id
      LIMIT 200
    ];
    return criaturas;
  }
}

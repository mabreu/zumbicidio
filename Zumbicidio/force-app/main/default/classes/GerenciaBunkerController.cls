public class GerenciaBunkerController {
  @AuraEnabled
  public static List<Bunker__c> recuperaBunkers() {
    List<Bunker__c> bunkers = new List<Bunker__c>();
    bunkers = [SELECT Id, Name FROM Bunker__c LIMIT 200];
    return bunkers;
  }
}

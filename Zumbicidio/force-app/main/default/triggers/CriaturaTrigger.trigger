trigger CriaturaTrigger on Criatura__c(
  after insert,
  after update,
  after delete
) {
  // Identificar os bunkers
  Map<id, Bunker__c> bunkers = new Map<id, Bunker__c>();

  for (Criatura__c cr : Trigger.new) {
    //System.debug('Funcionou.');
    Criatura__c antiga = Trigger.oldMap.get(cr.id);

    if (cr.bunker__c != antiga.bunker__c) {
      if (cr.bunker__c != null) {
        bunkers.put(cr.bunker__c, new Bunker__c(id = cr.bunker__c));
      }

      if (antiga.bunker__c != null) {
        bunkers.put(antiga.bunker__c, new Bunker__c(id = antiga.bunker__c));
      }
    }
  }

  for (Criatura__c cr : Trigger.old) {
    if (Trigger.isDelete && cr.bunker__c != null) {
      bunkers.put(cr.bunker__c, new Bunker__c(id = cr.bunker__c));
    }
  }

  // Totalizar todas as criaturas de cada bunker
  List<Bunker__c> list_bunker = [
    SELECT id, (SELECT id FROM Criaturas__r)
    FROM Bunker__c
    WHERE id IN :bunkers.keySet()
  ];

  for (Bunker__c bk : list_bunker) {
    bunkers.get(bk.id).populacao__c = bk.Criaturas__r.size();
  }

  // Atualizar os bunkers
  update bunkers.values();

  //List<Criatura__c> crList = [SELECT id FROM Criatura__c WHERE id in : trigger.newMap.keyset()];

}

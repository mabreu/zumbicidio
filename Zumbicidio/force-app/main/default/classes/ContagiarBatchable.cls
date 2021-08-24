public with sharing class ContagiarBatchable implements Database.Batchable<sObject> {
  private String zumbieId = Schema.SObjectType.Criatura__c.getRecordTypeInfosByName()
    .get('Zumbi')
    .getRecordTypeId();
  private String humanoId = Schema.SObjectType.Criatura__c.getRecordTypeInfosByName()
    .get('Humano')
    .getRecordTypeId();

  private static final Integer ZOMBIE_SPREAD = 2;

  public ContagiarBatchable() {
  }

  public Database.QueryLocator start(Database.BatchableContext bc) {
    // collect the batches of records or objects to be passed to execute
    return Database.getQueryLocator(
      'SELECT id, Bunker__r.nivel_seguranca__c, recordTypeId, bunker__c, ' +
      '(SELECT id, AcrescimoDefesa__c FROM RecursosCriatura__r) FROM Criatura__c'
    );
  }

  public void execute(Database.BatchableContext bc, List<sObject> scope) {
    // process each batch of records
    List<Criatura__c> criaturas = (List<Criatura__c>) scope;
    List<Criatura__c> humanos = preencheListaCriatura(humanoId, criaturas);
    List<Criatura__c> zumbis = preencheListaCriatura(zumbieId, criaturas);
    Map<Id, Criatura__c> upd_list = new Map<Id, Criatura__c>();

    for (Criatura__c zb : zumbis) {
      for (Integer i = 0; i < ZOMBIE_SPREAD; i++) {
        Criatura__c cri = (Criatura__c) Util.getRandomItem(humanos);
        Decimal defesa = this.getDefense(cri);
        Integer dice_roll =
          Math.mod(Integer.valueOf(Math.random() * 100000), 100) + 1;

        if (dice_roll > defesa) {
          cri.recordTypeID = zumbieId;
          cri.DataZumbificacao__c = Date.today();
          upd_list.put(cri.id, cri);
        }
      }
    }

    update upd_list.values();
  }

  private Decimal getDefense(Criatura__c hmn) {
    Decimal defesa = 0;

    if (hmn.recordTypeId != zumbieId) {
      if (hmn.bunker__c != null) {
        defesa += hmn.bunker__r.nivel_seguranca__c;
      }

      if (hmn.RecursosCriatura__r != null) {
        for (RecursosCriatura__c recCri : hmn.RecursosCriatura__r) {
          defesa += recCri.AcrescimoDefesa__c;
        }
      }
    }

    return defesa;
  }

  public void finish(Database.BatchableContext bc) {
    // execute any post-processing operations
  }

  private List<Criatura__c> preencheListaCriatura(
    id record_type,
    List<Criatura__c> criaturas
  ) {
    List<Criatura__c> res = new List<Criatura__c>();

    for (Criatura__c cri : criaturas) {
      if (cri.recordTypeId == record_type) {
        res.add(cri);
      }
    }

    return res;
  }
}

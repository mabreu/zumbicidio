public with sharing class ContagiarBatchable implements Database.Batchable<sObject> {
  public ContagiarBatchable() {
  }

  public Database.QueryLocator start(Database.BatchableContext bc) {
    // collect the batches of records or objects to be passed to execute
    return Database.getQueryLocator(
      'SELECT id, Bunker__r.nivel_seguranca__c, recordTypeId, ' +
      '(SELECT id, AcrescimoDefesa__c FROM RecursosCriatura__r) FROM Criatura__c'
    );
  }

  public void execute(Database.BatchableContext bc, List<sObject> scope) {
    // process each batch of records
    List<Criatura__c> humanos = preencheListaCriatura(
      '0125e000000us5TAAQ',
      scope
    );
    List<Criatura__c> zumbis = preencheListaCriatura(
      '0125e000000us5OAAQ',
      scope
    );
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

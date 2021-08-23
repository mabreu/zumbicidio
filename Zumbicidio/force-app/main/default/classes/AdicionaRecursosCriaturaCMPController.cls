public class AdicionaRecursosCriaturaCMPController {
  @AuraEnabled
  public static List<Recurso__c> recuperaRecursos(String recordId) {
    Set<Id> recursos = new Set<Id>();

    for (RecursosCriatura__c rc : [
      SELECT Id, Recurso__c
      FROM RecursosCriatura__c
      WHERE Criatura__c = :recordId
    ]) {
      recursos.add(rc.Recurso__c);
    }

    List<Recurso__c> lista = new List<Recurso__c>();
    lista = [
      SELECT Id, Name
      FROM Recurso__c
      WHERE Id NOT IN :recursos
      LIMIT 200
    ];
    return lista;
  }

  public static void adicionaRecursoCriatura(
    String recordId,
    String recursoId
  ) {
    RecursosCriatura__c rc = new RecursosCriatura__c();
    rc.Criatura__c = recordId;
    rc.Recurso__c = recursoId;
    insert rc;
  }
}

public class Zumbificacao {
  @InvocableMethod(label='Transforma Zumbi')
  public static void zumbificar(List<id> ids) {
    //System.debug(ids);
    List<Criatura__c> cri_list = [
      SELECT id, bunker__r.name, bunker__c, (SELECT id FROM RecursosCriatura__r)
      FROM Criatura__c
      WHERE id IN :ids
    ];

    // Criar lista para armazenar os recursos a serem excluidos
    List<RecursosCriatura__c> rc_delete_list = new List<RecursosCriatura__c>();

    for (Criatura__c cr : cri_list) {
      String tipo_zumbi = '';
      integer rand = Math.mod(Integer.valueOf(Math.random() * 100000), 100);

      if (rand < 50) {
        tipo_zumbi = 'Lerdo';
      } else if (rand < 80) {
        tipo_zumbi = 'Rápido';
      } else {
        tipo_zumbi = 'Gordo';
      }

      cr.Tipo_do_Zumbi__c = tipo_zumbi;
      // Evitar fazer delete no loop
      // delete cr.RecursosCriatura__r;

      if (cr.RecursosCriatura__r != null) {
        rc_delete_list.addAll(cr.RecursosCriatura__r);
      }
    }

    update cri_list;
    delete rc_delete_list;
  }
}

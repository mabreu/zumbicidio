global class ContagionSchedulable implements Schedulable {
  global void execute(SchedulableContext sc) {
    this.contagiar();
  }

  private void contagiar() {
    List<Criatura__c> human_list = [
      SELECT
        id,
        Bunker__r.nivel_seguranca__c,
        recordTypeId,
        (SELECT id, AcrescimoDefesa__c FROM RecursosCriatura__r)
      FROM Criatura__c
      WHERE recordTypeID = '0125e000000us5OAAQ'
    ];
    // SELECT id, bunkerr.defesaBunkerc, bunkerc, (select id, acrescimoDefesac  from RecursosCriaturar)
    // FROM Criatura_c  where recordtypeId = '0125e000000us5OAAQ'];

    if (human_list.size() == 0) {
      return;
    }

    List<Criatura__c> zombie_list = [
      SELECT id
      FROM Criatura__c
      WHERE recordTypeID = '0125e000000us5TAAQ'
    ];

    for (Criatura__c zb : zombie_list) {
      for (Integer i = 0; i < 2; i++) {
        Criatura__c hmn1 = human_list.get(
          Math.mod(Integer.valueOf(Math.random() * 1000), human_list.size())
        );
        decimal defesa = 0;

        if (hmn1.recordTypeId != '0125e000000us5OAAQ') {
          if (hmn1.bunker__c != null) {
            defesa += hmn1.bunker__r.nivel_seguranca__c;
          }

          if (hmn1.RecursosCriatura__r != null) {
            for (RecursosCriatura__c recCri : hmn1.RecursosCriatura__r) {
              defesa += recCri.AcrescimoDefesa__c;
            }
          }
        }

        Integer dice_roll =
          Math.mod(Integer.valueOf(Math.random() * 100000), 100) + 1;

        if (dice_roll > defesa) {
          hmn1.recordTypeID = '0125e000000us5TAAQ';
          hmn1.DataZumbificacao__c = Date.today();
        }
      }
    }

    update human_list;
  }
}

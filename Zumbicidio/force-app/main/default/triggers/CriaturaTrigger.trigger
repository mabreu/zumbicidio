trigger CriaturaTrigger on Criatura__c(
  after insert,
  after update,
  after delete
) {
  // Identificar os bunkers
  Map<id, Bunker__c> bunkers = new Map<id, Bunker__c>(); // Bunkers para atualizar a população
  Map<Id, Map<Id, RecursoBunker__c>> rb_update = new Map<Id, Map<Id, RecursoBunker__c>>(); // Recursos de bunkers para atualizar
  List<RecursosCriatura__c> rc_delete = new List<RecursosCriatura__c>(); // Recursos de criaturas para excluir

  Map<Id, RecursoBunker__c> recs_bunker; // Recursos de um bunker específico
  Criatura__c antiga;

  for (Criatura__c nova : Trigger.new) {
    if (Trigger.oldMap == null) {
      // Inserção
      antiga = new Criatura__c();
    } else {
      antiga = Trigger.oldMap.get(nova.id);
    }

    if (nova.bunker__c != antiga.bunker__c) {
      if (nova.bunker__c != null) {
        bunkers.put(nova.bunker__c, new Bunker__c(id = nova.bunker__c));
        recs_bunker = rb_update.get(nova.bunker__c);

        if (recs_bunker == null) {
          // Pega os recursos atuais do bunker
          List<RecursoBunker__c> recursos_bunker = [
            SELECT id, bunker__c, recurso__c, quantidade__c
            FROM RecursoBunker__c
            WHERE Bunker__c = :nova.bunker__c
          ];
          recs_bunker = new Map<Id, RecursoBunker__c>();

          for (RecursoBunker__c rb : recursos_bunker) {
            recs_bunker.put(rb.recurso__c, rb);
          }
        }

        // Pega os recursos atuais da criatura
        List<RecursosCriatura__c> recursos_criatura = [
          SELECT id, criatura__c, recurso__c, quantidade__c
          FROM RecursosCriatura__c
          WHERE Criatura__c = :nova.id
        ];

        for (RecursosCriatura__c rc : recursos_criatura) {
          RecursoBunker__c rb = recs_bunker.get(rc.recurso__c);

          // Se não tiver o recurso no bunker, cria um novo
          if (rb == null) {
            rb = new RecursoBunker__c();
            rb.bunker__c = nova.bunker__c;
            rb.recurso__c = rc.recurso__c;
            rb.quantidade__c = rc.quantidade__c;
          } else {
            rb.quantidade__c = rb.quantidade__c + rc.quantidade__c;
          }

          recs_bunker.put(rb.recurso__c, rb);
          rc_delete.add(rc);
        }

        rb_update.put(nova.bunker__c, recs_bunker);
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
  delete rc_delete;

  for (Map<Id, RecursoBunker__c> rb : rb_update.values()) {
    update rb.values();
  }
}

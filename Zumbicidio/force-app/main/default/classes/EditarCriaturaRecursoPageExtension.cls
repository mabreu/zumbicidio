public with sharing class EditarCriaturaRecursoPageExtension {
  private Criatura__c criatura;

  public EditarCriaturaRecursoPageExtension(
    ApexPages.StandardController controller
  ) {
    this.criatura = (Criatura__c) controller.getRecord();
  }

  public PageReference cancelar() {
    PageReference pr = new PageReference('/' + this.criatura.id);
    pr.setRedirect(true);
    return pr;
  }
}

({
  init: function (component, event, helper) {
    window.console.log(">>> INIT <<<");
    helper.carregaBunkers(component, event);
    helper.setColumns(component);
  },

  closeModal: function (component, event, helper) {
    helper.closeModal(component, event);
  },

  handleChange: function (component, event, helper) {
    helper.selecionaBunker(component, event);
  },

  insertCriatura: function (component, event, helper) {
    helper.insertCriatura(component, event);
  },

  showModal: function (component, event, helper) {
    helper.showModal(component, event);
  },

  viewRecord: function (component, event, helper) {
    helper.viewRecord(component, event);
  }
});

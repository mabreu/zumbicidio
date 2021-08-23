({
  doInit: function (component, event, helper) {
    helper.getBunkers(component, event);
  },

  bunkerChange: function (component, event, helper) {
    var bunker_id = event.getParam("value");
    component.set("v.bunker_id", bunker_id);
    alert("Option selected with value: '" + bunker_id + "'");
    helper.getCriaturas(component, event);
  }

  //adicionarCriatura: function(component, event, helper) {
  //helper.adicionaRecurso(component, event);
  //},
});

({
  doInit: function (component, event, helper) {
    // let recordId = component.get("v.recordId");
    // alert('Meu componente está sendo carregado: ' + recordId);
    helper.getRecursos(component, event);
  },

  handleChange: function (component, event, helper) {
    // This will contain the string of the "value" attribute of the selected option
    var selectedOptionValue = event.getParam("value");
    component.set("v.recurso_selecionado", selectedOptionValue);
    alert("Option selected with value: '" + selectedOptionValue + "'");
  },

  salvar: function (component, event, helper) {
    helper.adicionaRecurso(component, event);
  }
});

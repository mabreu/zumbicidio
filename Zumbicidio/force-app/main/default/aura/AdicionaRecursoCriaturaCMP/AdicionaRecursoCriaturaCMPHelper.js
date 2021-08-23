({
  getRecursos: function (component, event) {
    let recordId = component.get("v.recordId");
    // console.log(recordId);
    let lista = component.get("c.recuperaRecursos");

    lista.setParams({
      recordId: recordId
    });

    lista.setCallback(this, function (response) {
      let state = response.getState();
      let errors = response.getError();
      console.log("state: ", state);

      if (state === "SUCCESS") {
        let rows = response.getReturnValue();

        for (let i = 0; i < rows.length; i++) {
          var row = rows[i];
          row.label = row.Name;
          row.value = row.Id;
        }

        component.set("v.lista_recursos", rows);
      } else {
        console.log("errors: ", errors);
      }
    });

    $A.enqueueAction(lista);
  },

  adicionaRecurso: function (component, event) {
    let recordId = component.get("v.recordId");
    // console.log(recordId);
    let lista = component.get("c.adicionaRecursoCcriatura");

    lista.setParams({
      recordId: recordId,
      recursoId: recursoId
    });

    lista.setCallback(this, function (response) {
      let state = response.getState();
      let errors = response.getError();
      console.log("state: ", state);

      if (state === "SUCCESS") {
        console.log("success.");
      } else {
        console.log("errors: ", errors);
      }
    });

    $A.enqueueAction(lista);
  }
});

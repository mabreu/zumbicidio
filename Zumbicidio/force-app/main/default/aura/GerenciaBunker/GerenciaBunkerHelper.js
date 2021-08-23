({
  getBunkers: function (component, event) {
    console.log("GetBunkers");
    let bunkers = component.get("c.recuperaBunkers");

    bunkers.setCallback(this, function (response) {
      console.log("callback");
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

        component.set("v.lista_bunkers", rows);
      } else {
        console.log("errors: ", errors);
      }
    });

    $A.enqueueAction(bunkers);
  },

  getCriaturas: function (component, event) {
    console.log("GetCriaturas");
    let criaturas = component.get("c.recuperaCriaturas");
    let bunker_id = component.get("v.bunker_id");

    criaturas.setParams({
      bunker_id: bunker_id
    });

    console.log("calling recuperaCriaturas...");

    criaturas.setCallback(this, function (response) {
      console.log("callback");
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

        component.set("v.lista_criaturas", rows);
      } else {
        console.log("errors: ", errors);
      }
    });

    $A.enqueueAction(criaturas);
  }
});

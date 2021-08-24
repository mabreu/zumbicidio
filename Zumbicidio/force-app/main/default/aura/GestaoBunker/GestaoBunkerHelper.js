({
  carregaBunkers: function (component, event) {
    component.set("v.showSpinner", true);
    let action = component.get("c.recuperaBunkers");

    action.setCallback(this, function (response) {
      let state = response.getState();

      if (state === "SUCCESS") {
        let rows = response.getReturnValue();

        for (let i = 0; i < rows.length; i++) {
          let row = rows[i];
          row.label = row.Name;
          row.value = row.Id;
        }

        console.log("rows", rows);

        if (rows != null) {
          component.set("v.options", rows);
        }
      } else {
        let errors = response.getError();
        console.log("ERRROR:: ", errors);
      }
    });

    component.set("v.showSpinner", false);
    $A.enqueueAction(action);
  },

  carregaMembros: function (component, event) {
    component.set("v.showSpinner", true);
    let bunkerSelecionado = event.getParam("value");
    component.set("v.bunkerSelecionado", bunkerSelecionado);
    let action = component.get("c.recuperaBunkerMembros");

    action.setParams({
      bunkerId: bunkerSelecionado
    });

    action.setCallback(this, function (response) {
      let state = response.getState();

      if (state === "SUCCESS") {
        var bunker = response.getReturnValue();
        console.log(">>> return:: ", bunker);

        if (bunker != null) {
          component.set("v.bunkerInfo", bunker);

          if (bunker.membrosDoBunker != null) {
            component.set("v.data", bunker.membrosDoBunker);
          }
        }
      } else {
        let errors = response.getError();
        console.log("ERROR:: ", errors);
      }
    });

    component.set("v.showSpinner", false);
    $A.enqueueAction(action);
  },

  setColumns: function (component) {
    component.set("v.columns", [
      { label: "Membro", fieldName: "nome", type: "text" },
      { label: "Tipo de Criatura", fieldName: "tipo", type: "text" },
      { label: "Defesa", fieldName: "defesa", type: "percent" },
      {
        type: "button",
        typeAttributes: {
          label: "Ver Criatura",
          name: "View",
          title: "Clique aqui para abrir este registro",
          disabled: false,
          value: "view",
          iconPosition: "left"
        }
      },
      {
        type: "button",
        typeAttributes: {
          label: "Editar/Expulsar",
          name: "Edit",
          title: "Clique aqui para editar este registro",
          disabled: false,
          value: "edit",
          iconPosition: "left"
        }
      }
    ]);
  },

  viewRecord: function (component, event) {
    var recId = event.getParam("row").sfId;
    var actionName = event.getParam("action").name;

    if (actionName == "Edit") {
      var editRecordEvent = $A.get("e.force:editRecord");

      editRecordEvent.setParams({
        recordId: recId
      });

      editRecordEvent.fire();
    } else if (actionName == "View") {
      var viewRecordEvent = $A.get("e.force:navigateToURL");

      viewRecordEvent.setParams({
        url: "/" + recId
      });

      viewRecordEvent.fire();
    }
  }
});

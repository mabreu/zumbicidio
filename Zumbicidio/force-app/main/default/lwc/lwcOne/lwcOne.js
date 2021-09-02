import { LightningElement, api, wire } from "lwc";
import { getRecord } from "lightning/uiRecordApi";

const FIELDS = ["Bunker__c.Name", "Bunker__c.Ativo__c"];

export default class LwcOne extends LightningElement {
  @api recordId;

  @wire(getRecord, { recordId: "$recordId", fields: FIELDS }) // vai buscar os dados no background
  bunker; // Variavel que recebe os dados

  something = "world"; // atribuição direta

  changeHandler(event) {
    // eslint-disable-next-line no-alert
    alert(event.target.value);
  }

  // Usado no HTML para exibir o valor
  get name() {
    console.log(this.bunker);
    return this.bunker.data.fields.Name.value;
  }
}

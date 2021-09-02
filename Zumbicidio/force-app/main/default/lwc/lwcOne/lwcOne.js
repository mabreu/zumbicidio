import { LightningElement, api, wire } from "lwc";
import { getRecord } from "lightning/uiRecordApi";
// import { getRecord, getFieldValue } from "lightning/uiRecordApi";

// import NAME_FIELD from '@salesforce/schema/Bunker__c.Name';
// import ATIVO_FIELD from '@salesforce/schema/Bunker__c.Ativo__c';

const FIELDS = ["Bunker__c.Name", "Bunker__c.Ativo__c"];
// const FIELDS = [NAME_FIELD, ATIVO_FIELD];

export default class LwcOne extends LightningElement {
  @api recordId;

  @wire(getRecord, { recordId: "$recordId", fields: FIELDS }) // vai buscar os dados no background
  // @wire(getRecord, { recordId: '$recordId', fields: FIELDS }) // vai buscar os dados no background
  bunker; // Variavel que recebe os dados

  something = "Hello World!"; // atribuição direta

  changeHandler(event) {
    // eslint-disable-next-line no-alert
    alert(event.target.value);
  }

  // Usado no HTML para exibir o valor
  get name() {
    console.log(this.bunker);
    return this.bunker.data.fields.Name.value;
    // return getFieldValue(this.bunker.data, NAME_FIELD);
  }
}

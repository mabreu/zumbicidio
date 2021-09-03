import { LightningElement, wire } from "lwc";
import getHerois from "@salesforce/apex/CalloutToSalesForce.getHeroisBootcamp3";

const columns = [
  { label: "Nome do herói", fieldName: "nome" },
  { label: "Nível do Herói", fieldName: "nivel", type: "string" },
  { label: "Total de habilidades", fieldName: "total", type: "number" }
];

export default class LwcCallApex extends LightningElement {
  data = [];
  columns = columns;

  // @wire(getHerois)
  // response;

  // get data() {
  // 	return this.response.herois;
  // }

  @wire(getHerois)
  wiredRecord({ error, data }) {
    if (data) {
      console.log(data);
      this.data = data.herois;
    } else if (error) {
      console.log(error);
    }
  }

  // get herois() {
  // 	this.data.forEach( heroi => {
  // 		heroi.total = heroi.habilidades.length;
  // 	});

  // 	console.log(this.data);
  // 	return this.data;
  // }

  // // eslint-disable-next-line @lwc/lwc/no-async-await
  // async connectedCallback() {
  //     const data = await fetchDataHelper({ amountOfRecords: 100 });
  //     this.data = data;
  // }
}

import { LightningElement, wire, api } from "lwc";
import getHerois from "@salesforce/apex/CalloutToSalesForce.getHeroisBootcamp3";

export default class LwcCallApex extends LightningElement {
  @api
  herois = [];

  // @wire(getHerois)
  // response;

  // get data() {
  // 	return this.response.herois;
  // }

  /*
      Wire: Mais prático porém menos flexível
    */

  // @wire( getHerois )
  // wiredRecord({ error, data }) {
  //     if( data ) {
  //         console.log(data);
  //         this.herois = data.herois;
  //     } else if (error) {
  //         console.log(error);
  //     }
  // }

  /*
      Then/Catch: Mais flexível porém mais trabalhoso
    */

  connectedCallback() {
    alert("connectedCallback");
    getHerois()
      .then((result) => {
        console.log(result);
        this.herois = result.herois;
      })
      .catch((error) => {
        console.error(error);
      })
      .finally(() => {
        console.log("finally");
      });
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

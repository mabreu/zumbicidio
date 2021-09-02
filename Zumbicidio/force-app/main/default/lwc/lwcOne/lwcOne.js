import { LightningElement } from "lwc";

export default class LwcOne extends LightningElement {
  something = "world";

  changeHandler(event) {
    // eslint-disable-next-line no-alert
    alert(event.target.value);
  }
}

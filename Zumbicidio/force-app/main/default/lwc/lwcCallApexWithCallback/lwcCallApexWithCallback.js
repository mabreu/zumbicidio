import { LightningElement } from "lwc";

const columns = [
  { label: "Nome do herói", fieldName: "nome" },
  { label: "Nível do Herói", fieldName: "nivel", type: "string" },
  { label: "Total de habilidades", fieldName: "total", type: "number" }
];

export default class LwcCallApexWithCallback extends LightningElement {
  data = [];
  columns = columns;
}

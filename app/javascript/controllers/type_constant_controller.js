import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["select", "unit"];

  connect() {
    this.updateUnit();
  }

  updateUnit() {
    const selectedOption = this.selectTarget.selectedOptions[0];
    const symbol = selectedOption?.dataset.symbol || "Unidad";

    this.unitTarget.textContent = symbol;
  }
}

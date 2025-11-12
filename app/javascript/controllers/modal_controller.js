import { Controller } from "@hotwired/stimulus";
import { Turbo } from "@hotwired/turbo-rails";

// data-controller="modal"
export default class extends Controller {
  close() {
    Turbo.visit("/");
  }

  connect() {
    this.clickOutside = this._handleClickOutside.bind(this);
    this.keyPress = this._handleKeyPress.bind(this);

    document.addEventListener("click", this.clickOutside);
    document.addEventListener("keydown", this.keyPress);
  }

  disconnect() {
    document.removeEventListener("click", this.clickOutside);
    document.removeEventListener("keydown", this.keyPress);
  }

  _handleClickOutside(event) {
    if (event.target.closest(".bg-white") === null) {
      this.close();
    }
  }

  _handleKeyPress(event) {
    if (event.key === "Escape") {
      this.close();
    }
  }
}

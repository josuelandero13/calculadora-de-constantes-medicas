import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["backdrop"];

  
close(event) {
  if (event) {
    event.preventDefault();
    event.stopPropagation();
  }

  if (window.history.length > 1) {
    window.history.back();
  } else {
    // Fallback: limpiar el frame
    const frame = this.element.closest('turbo-frame');
    if (frame) {
      frame.innerHTML = '';
    }
  }
}

  closeBackground(event) {
    if (event.target === this.backdropTarget) {
      this.element.remove();
    }
  }

  connect() {
    document.body.classList.add("overflow-hidden");

    setTimeout(() => {
      const modalContent = this.element.querySelector(".bg-white");

      if (modalContent) {
        modalContent.classList.remove("scale-95", "opacity-0");
        modalContent.classList.add("scale-100", "opacity-100");
      }
    }, 50);

    this.keyPressHandler = this._handleKeyPress.bind(this);
    document.addEventListener("keydown", this.keyPressHandler);
  }

  disconnect() {
    document.body.classList.remove("overflow-hidden");
    document.removeEventListener("keydown", this.keyPressHandler);
  }

  _handleKeyPress(event) {
    if (event.key === "Escape") {
      this.element.remove();
      Turbo.visit("/");
    }
  }
}

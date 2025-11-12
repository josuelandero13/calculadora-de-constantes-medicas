import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "results", "hidden"];

  search() {
    const query = this.inputTarget.value.trim();
    if (query.length < 2) {
      this.resultsTarget.innerHTML = "";
      this.resultsTarget.classList.add("hidden");
      return;
    }

    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      fetch(`/patients/search?query=${encodeURIComponent(query)}`)
        .then((r) => r.text())
        .then((html) => {
          this.resultsTarget.innerHTML = html;
          this.resultsTarget.classList.remove("hidden");
        });
    }, 300);
  }

  select(event) {
    const id = event.currentTarget.dataset.id;
    const name = event.currentTarget.textContent.trim();
    this.hiddenTarget.value = id;
    this.inputTarget.value = name;
    this.inputTarget.readOnly = true;
    this.resultsTarget.classList.add("hidden");
  }

  connect() {
    this.clickOutsideHandler = (e) => {
      if (!this.element.contains(e.target)) {
        this.resultsTarget.classList.add("hidden");
      }
    };
    document.addEventListener("click", this.clickOutsideHandler);
  }

  disconnect() {
    document.removeEventListener("click", this.clickOutsideHandler);
  }
}

import { Controller } from "@hotwired/stimulus";
export default class extends Controller {
  static targets = ["patientModal", "constantModal", "editConstantModal"];

  open(event) {
    event.preventDefault();
    const target = event.currentTarget.dataset.target;

    let modal;
    if (target === "patient-modal") {
      modal = document.getElementById("patient-modal");
    } else if (target === "constant-modal") {
      modal = document.getElementById("constant-modal");
    } else if (target === "edit-constant-modal") {
      modal = document.getElementById("edit-constant-modal");
    }

    if (modal) {
      modal.classList.remove("hidden");
      document.body.classList.add("overflow-hidden");

      const firstInput = modal.querySelector("input, select, textarea");

      if (firstInput) firstInput.focus();
    }
  }

  close(event) {
    event?.preventDefault();

    const modals = document.querySelectorAll('[id$="-modal"]');
    modals.forEach((modal) => {
      if (!modal.classList.contains("hidden")) {
        modal.classList.add("hidden");
      }
    });

    document.body.classList.remove("overflow-hidden");
  }

  handleBackdropClick(event) {
    if (event.target === event.currentTarget) {
      this.close(event);
    }
  }

  handleSuccess(event) {
    const { success } = event.detail;

    console.log("Turbo submit end");

    if (success) {
      this.close();

      const form = event.target;
      form.reset();
    }
  }
}

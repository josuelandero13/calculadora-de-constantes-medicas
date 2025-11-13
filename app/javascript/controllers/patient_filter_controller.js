import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="patient-filter"
export default class extends Controller {
  static targets = ["select"];

  filterByPatient(event) {
    const patientId = event.target.value;
    const url = new URL(window.location.href);

    if (patientId) {
      url.searchParams.set("patient", patientId);
    } else {
      url.searchParams.delete("patient");
    }

    window.location.href = url.toString();
  }
}

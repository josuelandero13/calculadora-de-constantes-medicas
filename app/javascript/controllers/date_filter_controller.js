import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="date-filter"
export default class extends Controller {
  static targets = ["startDate", "endDate"];

  applyFilter() {
    const url = new URL(window.location.href);

    if (this.hasStartDateTarget && this.startDateTarget.value) {
      url.searchParams.set("start_date", this.startDateTarget.value);
    } else {
      url.searchParams.delete("start_date");
    }

    if (this.hasEndDateTarget && this.endDateTarget.value) {
      url.searchParams.set("end_date", this.endDateTarget.value);
    } else {
      url.searchParams.delete("end_date");
    }

    window.location.href = url.toString();
  }
}

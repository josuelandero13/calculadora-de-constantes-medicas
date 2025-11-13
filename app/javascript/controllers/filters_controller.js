import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filters"
export default class extends Controller {
  static targets = ["chevron"]

  initialize() {
    this.boundRotateChevron = this.rotateChevron.bind(this)
  }

  connect() {
    this.details = this.element
    this.summary = this.element.querySelector('summary')
    this.rotateChevron()
    
    // Agregar evento para detectar cambios en el estado de details
    this.details.addEventListener('toggle', this.boundRotateChevron)
  }

  disconnect() {
    this.details.removeEventListener('toggle', this.boundRotateChevron)
  }

  toggle(event) {
    event.preventDefault()
    this.details.open = !this.details.open
  }

  rotateChevron() {
    if (this.details.open) {
      this.chevronTarget.classList.add('rotate-180')
    } else {
      this.chevronTarget.classList.remove('rotate-180')
    }
  }
}

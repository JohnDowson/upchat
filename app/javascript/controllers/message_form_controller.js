import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="message-form"
export default class extends Controller {
  connect() {
    this.element.addEventListener("turbo:submit-end", () => { this.clear() });
  }

  clear() {
    this.element.reset()
  }
}

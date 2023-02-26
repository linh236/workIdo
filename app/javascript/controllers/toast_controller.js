import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toast"
export default class extends Controller {
  static targets = ["message"]

  connect() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.messageTarget.remove();
    }, 2000)
  }
}

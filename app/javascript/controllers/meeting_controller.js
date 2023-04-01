import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="meeting"
export default class extends Controller {
  connect() {
    console.log("Meeting")
  }
}

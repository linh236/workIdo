import { Controller } from "@hotwired/stimulus"
import RequestController from "./request_controller";

// Connects to data-controller="join-room"
export default class extends RequestController {
  connect() {
  }

  invite(event) {
    if (event.preventDefault) {
      event.preventDefault()
    }

    alert("This function is in progress")
    
  }
}

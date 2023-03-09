import { Controller } from "@hotwired/stimulus"
import RequestController from "./request_controller";

// Connects to data-controller="assign-member"
export default class extends RequestController {
  connect() {
  console.log("assign-member")
  }

  assignMember(event) {
    if (event.preventDefault) {
      event.preventDefault();
    }
    let id = event.target.dataset.task;
    const params = {
      url: `/assign_member/${id}`,
      method: "POST",
      body: {
        assign_id: event.target.value
      }
    }
    this.sendPostOrPut(params)
  }
}

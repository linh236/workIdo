import { Controller } from "@hotwired/stimulus"
import RequestController from "./request_controller";

// Connects to data-controller="notification"
export default class extends RequestController {

  connect() {
  }

  markRead(event) {
    let account_notification_id = event.currentTarget.dataset.id;
    this.sendGetorDelete({
      url: `/account_mark_read/${account_notification_id}`,
      method: "GET"
    })
  }
}

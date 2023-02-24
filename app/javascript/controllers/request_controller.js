import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="request"
export default class extends Controller {

  connect() {
  }

  sendGetorDelete({url: url, method: method}) {
    fetch(url, {
      method: method,
      headers: {
        'X-CSRF-Token': document.querySelector(
          'meta[name="csrf-token"]'
        ).content,
        Accept: "text/vnd.turbo-stream.html",
      },
    })
    .then(r => r.text())
    .then(html => Turbo.renderStreamMessage(html))
  }
  
  sendPostOrPut({url: url, method: method, body: body}) {
    fetch(url, {
      method: method,
      headers: {
        'X-CSRF-Token': document.querySelector(
          'meta[name="csrf-token"]'
        ).content,
        Accept: "text/vnd.turbo-stream.html",
        "Content-Type": "application/json"
      },
      body: JSON.stringify(body),
    })
    .then(r => r.text())
    .then(html => Turbo.renderStreamMessage(html))
  }
}

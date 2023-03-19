import { Controller } from "@hotwired/stimulus"
import RequestController from "./request_controller";

// Connects to data-controller="infinite-scroll"
export default class extends RequestController {
  static targets = ["pagination", "loading"]
  connect() {
  }

  scroll(event) {
    let next_page = this.paginationTarget.querySelector("a[rel='next']");
    if (next_page === null) { return }
    let url = next_page.href;
    var body = document.body,
      html = document.documentElement;

    var hight = Math.max(body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight)

    if (window.pageYOffset >= (hight - window.innerHeight)) {
      this.loadingTarget.innerHTML = `
        <svg version="1.1" id="loader-1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
              width="40px" height="40px" viewBox="0 0 50 50" style="enable-background:new 0 0 50 50;" xml:space="preserve">
          <path fill="#006bb6" d="M43.935,25.145c0-10.318-8.364-18.683-18.683-18.683c-10.318,0-18.683,8.365-18.683,18.683h4.068c0-8.071,6.543-14.615,14.615-14.615c8.072,0,14.615,6.543,14.615,14.615H43.935z">
          <animateTransform attributeType="xml"
          attributeName="transform"
          type="rotate"
          from="0 25 25"
          to="360 25 25"
          dur="0.6s"
          repeatCount="indefinite"/>
          </path>
        </svg>
      `
      this.loadMore(url)
    }
  }

  loadMore(url) {
    this.sendGetorDelete({
      url: url,
      method: 'GET',
    })
  }
}

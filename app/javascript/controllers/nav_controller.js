import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle(e) {
    const openClass = "open";
    const $this = $(e.currentTarget);

    if ($this.parent().hasClass("open")) {
      $this
        .parent()
        .children(".dropdown-menu")
        .slideUp(200, () => {
          $this.parent().removeClass(openClass);
        });
    } else {
      $this
        .parent()
        .parent()
        .children("li.open")
        .children(".dropdown-menu")
        .slideUp(200);
      $this
        .parent()
        .parent()
        .children("li.open")
        .children("a")
        .removeClass(openClass);
      $this.parent().parent().children("li.open").removeClass(openClass);
      $this
        .parent()
        .children(".dropdown-menu")
        .slideDown(200, () => {
          $this.parent().addClass(openClass);
        });
    }
  }
}

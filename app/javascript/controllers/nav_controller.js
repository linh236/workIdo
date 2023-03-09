import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    $(window).resize(function(e) {
      let width = $(window).width();
      let $sideNav = $(".side-nav");
      if (width > 992) {
        $sideNav.addClass("open");
        $sideNav.css("left", "0");
      } else {
        $sideNav.removeClass("open");
        $sideNav.css("left", "-280px");
      }
    })
  }

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
  openMenu() {
    let $sideNav = $(".side-nav");
    if ($sideNav.hasClass("open")) {
      $sideNav.removeClass("open");
      $sideNav.css("left", "-280px");
    } else {
      $sideNav.addClass("open");
      $sideNav.css("left", "0");
    }
  }

  close(e) {
    $(".task-detail").hide()
  }
}

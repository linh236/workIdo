import { Controller } from "@hotwired/stimulus"
import RequestController from "./request_controller";

// Connects to data-controller="modal-turbo"
export default class extends RequestController {
  connect() {
  }

  open(event) {
    let id = event.target.dataset.id;
   this._openComment(id)
  }

  deleteComment(event) {
    if (event.preventDefault) {
      event.preventDefault();
    }
    let id = event.target.dataset.id;
    let task_id = event.target.dataset.task;
    const params = {
      url: `/tasks/${task_id}/comments/${id}`,
      method: 'Delete',
    }
    this.sendGetorDelete(params)
    if (!$(`.comment-form-${task_id}`).hasClass("hidden")) {
      this._openComment(task_id)
    }
  }

  editComment(event) {
    if (event.preventDefault) {
      event.preventDefault();
    }
    let id = event.target.dataset.id;
    let task_id = event.target.dataset.task;
    this._openComment(task_id)
    const params = {
      url: `/tasks/${task_id}/comments/${id}`,
      method: 'GET',
    }
    this.sendGetorDelete(params)
  }

  tags(event) {
    if (event.keyCode === 50) {
      $(".tags").show()
    } else {
      $(".tags").hide()
    }
  }

  tagMember(event) {
    if (event.preventDefault) {
      event.preventDefault()
    }

    let full_name = event.target.dataset.full_name;
    let $cmt = $(".comment");
    let text = $cmt.val().replace("@", "");
    text += `<strong>@${full_name}</strong>`;
    $cmt.selectionEnd;
    $cmt.val(text);
    $(".tags").hide()
  }
  
  // Function support 
  _openComment(task_id) {
    if ($(`.comment-form-${task_id}`).hasClass("hidden")) {
      $(`.comment-form-${task_id}`).removeClass("hidden");
      $(`.des-${task_id}`).removeClass("vh-80").addClass("vh-70");
      $(`.input-${task_id}`).removeClass("form-control").addClass("hidden");
    } else {
      $(`.comment-form-${task_id}`).addClass("hidden");
      $(`.des-${task_id}`).removeClass("vh-70").addClass("vh-80");
      $(`.input-${task_id}`).addClass("form-control").removeClass("hidden");
    }
  }
}

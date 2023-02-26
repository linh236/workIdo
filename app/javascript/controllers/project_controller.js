import { Controller } from "@hotwired/stimulus"
import RequestController from "./request_controller";

// Connects to data-controller="project"
export default class extends RequestController {
  static targets = ["move"]
  connect() {
  }


  dragStart(event) {
    event.target.style.opacity = "0.4"
    event.target.style.color = "white"
    event.target.style.background = "#575bfc00"
    this.dragSrcEl = event.target;
    event.dataTransfer.effectAllowed = "move";
    event.dataTransfer.setData("text/html", event.target.innerHTML)
  }

  dragEnter(event) {
    if (event.preventDefault) {
      event.preventDefault();
    }

    event.target.classList.add("over");
    
    return false;
  }


  dragOver(event) {
    if (event.preventDefault) {
      event.preventDefault();
    }    
    return false;
  }

  dragLeave(event) {
    event.target.classList.remove("over");
    this.resetOpacity();
  }

  drop(event) {
    event.stopPropagation();
    if (!event.target.dataset.id) {
      return;
    }
    const params = {
      url: "/move_label",
      method: "PUT",
      body: {
        from: this.dragSrcEl.dataset.id,
        to: event.target.dataset.id
      }
    }
    this.sendPostOrPut(params);
    event.target.classList.remove("over");
    this.resetOpacity();  
  }

  dragEnd(event) {
    this.resetOpacity();
  }

  resetOpacity() {
    this.moveTargets.forEach(element => {
      element.style.opacity = "1";
    });
  }

  delete(event) {
    let project_id = event.target.dataset.project;
    let label_id = event.target.dataset.label;
    const params = {
      url: `/projects/${project_id}/labels/${label_id}`,
      method: "DELETE"
    }
    this.sendGetorDelete(params);
  }
}

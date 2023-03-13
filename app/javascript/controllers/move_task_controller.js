import { Controller } from "@hotwired/stimulus"
import RequestController from "./request_controller";

// Connects to data-controller="move-task"
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
    localStorage.setItem("start_move_task_id", event.target.dataset.task);
    localStorage.setItem("start_move_label", event.target.dataset.label);
  }

  dragEnter(event) {
    if (event.preventDefault) {
      event.preventDefault();
    }

    // if (event.target.dataset.to === 'label') {
    //   event.target.style.border = "1px solid red";
    // } 

    // let task_id = localStorage.getItem("start_move_task_id");
    // let start_move_label = localStorage.getItem("start_move_label");
    // // let label_id = localStorage.getItem("label_id");
    // let label_id = event.target.dataset.label;

    // if (!label_id && !task_id) {
    //   return;
    // }
    // const params = {
    //   url: `/move_task/${task_id}`,
    //   method: 'PUT',
    //   body: {
    //     label_id: label_id, 
    //     start_move_label: start_move_label
    //   }
    // }
    // this.sendPostOrPut(params);


    event.target.classList.add("over");
    
    if (event.preventDefault) {
      event.preventDefault();
    }
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
   
    let task_id = localStorage.getItem("start_move_task_id");
    let start_move_label = localStorage.getItem("start_move_label");
    if (event.target.dataset.to === 'label' && start_move_label !== event.target.dataset.label) {
      event.target.style.border = "1px solid red";
      // let label_id = localStorage.getItem("label_id");
      let label_id = event.target.dataset.label;
  
      if (!label_id && !task_id) {
        return;
      }
      const params = {
        url: `/move_task/${task_id}`,
        method: 'PUT',
        body: {
          label_id: label_id, 
          start_move_label: start_move_label
        }
      }
      this.sendPostOrPut(params);
    } else {
     if (!event.target.dataset.task) {
      return;
     }
      const params = {
        url: `/move_task_inside`,
        method: 'PUT',
        body: {
          from: task_id, 
          to: event.target.dataset.task
        }
      }
      this.sendPostOrPut(params);
    }

    event.target.classList.remove("over");
    this.resetOpacity();  
    localStorage.clear();
  }

  dragEnd(event) {
    this.resetOpacity();
  }

  resetOpacity() {
    this.moveTargets.forEach(element => {
      element.style.opacity = "1";
      element.style.border = "unset";
    });
  }

  detail(event) {
    if (event.preventDefault) {
      event.preventDefault();
    }
    let project_id = event.target.dataset.project;
    let label_id = event.target.dataset.label;
    let task_id = event.target.dataset.task;
    if (project_id && label_id && task_id) {
      this.sendGetorDelete({url: `/projects/${project_id}/labels/${label_id}/tasks/${task_id}`, method: 'GET'})
    }
  }

  moveTask(toEle) {
    // if (!this.dragSrcEl) {
    //   return;
    // }
    let project_id = this.dragSrcEl.dataset.project;
    let label_id = this.dragSrcEl.dataset.label;
    let task_id = this.dragSrcEl.dataset.task;
    let from_label = this.dragSrcEl.dataset.label;
    let to_label = toEle.dataset.label;

    console.log(from_label)
    console.log(toEle)
    console.log(to_label)

    const params = {
      url: `/projects/${project_id}/labels/${label_id}/tasks/${task_id}`,
      method: 'PUT',
      body: {
        from: this.dragSrcEl.dataset.label,
        to: toEle.dataset.label,
      }
    }
    this.sendPostOrPut(params);
  }

  // disconnect() {
  //   localStorage.clear();
  // }

}

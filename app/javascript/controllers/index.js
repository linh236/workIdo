// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)

import RequestController from "./request_controller";
import MoveTaskController from "./move_task_controller";
import NavController from "./nav_controller";
import ProjectController from "./project_controller";
import InviteFormController from "./invite_form_controller";
import ToastController from "./toast_controller";
import AssignMemberController from "./assign_member_controller";
import ModalTurboController from "./modal_turbo_controller";
import JoinRoomController from "./join_room_controller";
import InfiniteScrollController from "./infinite_scroll_controller";
import NotificationController from "./notification_controller";
//import MeetingController from "./meeting_controller";

application.register("request", RequestController)
application.register("move-task", MoveTaskController)
application.register("nav", NavController)
application.register("project", ProjectController)
application.register("invite-form", InviteFormController)
application.register("toast", ToastController)
application.register("assign-member", AssignMemberController)
application.register("modal-turbo", ModalTurboController)
application.register("join-room", JoinRoomController)
application.register("infinite-scroll", InfiniteScrollController)
application.register("notification", NotificationController)
//application.register("meeting", MeetingController)

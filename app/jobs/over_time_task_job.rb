class OverTimeTaskJob < ApplicationJob
  queue_as :default

  def perform
    tasks = Task.where("start_task < ?", DateTime.now)
    tasks.each do |task|
      check_activity = Activity.where("activity_type = ? and detail->>'task_id' = ? and perform_id = ?", "ActivityType::OverTimeTask", task.id, task.assign_id)
      unless check_activity.present?
        activity = tracking_activity("ActivityType::OverTimeTask", task.assign_id, {task_id: task.id, text: "task over time"})
        tracking_notification([task.assign_id], activity.id)
      end
    end
  end
end

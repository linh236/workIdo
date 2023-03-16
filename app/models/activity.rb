class Activity < ApplicationRecord
  include ActionView::RecordIdentifier

  has_many :account_notifications
  # has_many :move_tasks, class_name: "ActivityType::MoveTask", foreign_key: "perform_id"
  belongs_to :performer, class_name: "User", foreign_key: "perform_id", optional: true

  after_create_commit do 
    # activity = Activity.where("activity_type = ? and detail->>'task_id' = ?", "ActivityType::MoveTask", self.id).last
    broadcast_remove_to("move-task", target: "label-#{self.detail["from_label_id"]}-task-#{self.detail["task_id"]}")
  end

  def object_activity_type
    object = self.activity_type.constantize 
    object.send :call, self.attributes
  end
end

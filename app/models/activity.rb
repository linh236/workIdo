class Activity < ApplicationRecord
  has_many :account_notifications
  # has_many :move_tasks, class_name: "ActivityType::MoveTask", foreign_key: "perform_id"

  def object_activity_type
    object = self.activity_type.constantize 
    object.send :call, self.attributes
  end
end
